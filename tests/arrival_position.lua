local function read(path)
    local f=assert(io.open(path,'rb')); local s=f:read('*a'); f:close()
    return s:gsub('\r\n','\n'):gsub('^\239\187\191','')
end
local prefix=assert(read('tests/native_buff_casters.lua'):match('^(.-)\nlocal function admits%('))
local fixture=assert(loadstring(prefix..'\nreturn fixture'))()
local d=fixture('PRIEST',4); d.skin.limits={4,2,2}
local donor=d.button(); local rows={}
for i=1,28 do
    local row={unit='raid'..i,frame=1,healthBar={}}
    function row:GetFrameLevel() return 5 end
    rows[i]=row; d.env.HealBot_Forever_SkinArrivalAuras(row,donor)
end
local allocated=#d.frames
for _,index in ipairs({1,9,11}) do
    donor.gref.icon[index].GetCenter=function() return 123.125,214.75 end
end
for _,row in ipairs(rows) do
    d.env.HealBot_Forever_SkinArrivalAuras(row,donor)
    for _,item in ipairs(row.arrivalAuras) do
        assert(item.container.point[4]==31.125,'horizontal anchor not updated exactly')
        assert(item.container.point[5]==(item.set==2 and 22.75 or 6.75),'vertical anchor not updated exactly')
    end
end
assert(#d.frames==allocated,'position-only changes rebuilt native frames')
local item=rows[1].arrivalAuras[1]; local original=item.container.SetPoint
item.container.SetPoint=function() error('injected anchor failure') end
donor.gref.icon[1].GetCenter=function() return 124.125,214.75 end
d.env.HealBot_Forever_SkinArrivalAuras(rows[1],donor)
d.env.HealBot_Forever_UpdateArrivalAuras(rows[1])
assert(item.anchorFailed and not item.container.shown,'failed anchor left visible')
item.container.SetPoint=original
d.env.HealBot_Forever_SkinArrivalAuras(rows[1],donor)
d.env.HealBot_Forever_UpdateArrivalAuras(rows[1])
assert(not item.anchorFailed and item.container.shown,'anchor retry did not recover')
assert(item.container.point[4]==32.125 and #d.frames==allocated,'retry rebuilt or lost exact offset')
-- A structural style change still replaces native icon factories.
d.skin.size=20
d.env.HealBot_Forever_SkinArrivalAuras(rows[1],donor)
assert(#d.frames>allocated,'icon size change incorrectly reused old factory')
allocated=#d.frames
d.combat(true)
donor.gref.icon[1].GetCenter=function() error('combat inspected donor geometry') end
d.env.HealBot_Forever_SkinArrivalAuras(rows[1],donor)
assert(#d.frames==allocated,'combat allocated frames')
print('PASS: 28 reserve rows reanchor without allocations; exact offsets, failure hiding/retry, size rebuilds and combat guard preserved')

-- A roster event may fire before the old panel buttons have finished moving.
-- Exercise Sync with real native aura preparation and the existing secure watch.
local syncFixture=fixture('PRIEST',4)
local api=syncFixture.env
api.IsInRaid=function() return true end
api.HealBot_retLuVars=function() return true end
api.HealBot_Media_retLuVars=function() return true end
api.Healbot_Config_Skins={Current_Skin='test',HealGroups={test={}}}
api.hbv_Aux_GetBarVar=function() return 1 end
api.RegisterUnitWatch=function(row) row.watches=(row.watches or 0)+1 end
local existing={raid2=true,target=true,raid9=true}
api.UnitExists=function(unit) return existing[unit] end
local departing=syncFixture.button('raid1')
local other=syncFixture.button('target')
local member=syncFixture.button('raid2')
for _,button in ipairs({departing,other,member}) do button.status.active=true end
departing.gref.Bar.GetCenter=function() return nil end
api.HealBot_Buttons={departing,other,member}
local rosterRuntime=setfenv(assert(loadstring(read('HealBot/HealBot_ForeverPartyJoin.lua')..[[
    rows=...
    rosterMode,frame,frameSkin,skinDirty='raid',1,'test',false
    PositionReservedRows=function() return true end
    return Sync,PrepareNextReserve
]])),api)
local reserve={unit='raid30',healthBar={},bindingGeneration=0,GetFrameLevel=function() return 5 end}
local donorUsed
local prepare=api.HealBot_Forever_SkinArrivalAuras
api.HealBot_Forever_SkinArrivalAuras=function(row,donor,context)
    donorUsed=donor
    return prepare(row,donor,context)
end
local sync,update=rosterRuntime({reserve})
sync()
assert(reserve.watches==1 and not reserve.arrivalAuras,"secure watch must be ready before native artwork")
update()
assert(reserve.watches==1 and reserve.arrivalAuras and #reserve.arrivalAuras>0,
    'reserve armed without native aura artwork while another same-frame player was ready')
assert(donorUsed==member,'a special target displaced the ready raid member as the skin donor')
existing.raid2=nil
member.status.active=false
sync()
update()
assert(donorUsed==other and reserve.watches==1,'same-frame fallback lost when all regular members left')
print('PASS: roster shrink arms the reserve with native artwork and retains the alternate donor for split frames')

syncFixture.skin.limits={4,4,4}
local battleground={}
for i=1,40 do
    if i<=9 then existing["raid"..i]=true end
    battleground[i]={unit="raid"..i,healthBar={},bindingGeneration=0,GetFrameLevel=function() return 5 end}
end
member.status.active=true
sync,update=rosterRuntime(battleground)
local count=#syncFixture.frames
sync()
local function newContainers()
    local n=0
    for j=count+1,#syncFixture.frames do
        if syncFixture.frames[j].kind=="AuraContainer" then n=n+1 end
    end
    count=#syncFixture.frames
    return n
end
assert(newContainers()==0,"Warsong entry allocated a native reserve container in PartyJoin.Sync")
local total,peak=0,0
for i=10,40 do
    update()
    local n=newContainers()
    assert(n>0 and battleground[i].watches==1 and #battleground[i].arrivalAuras==3,
        "reserve skin or native icon sets failed to warm")
    total,peak=total+n,math.max(peak,n)
end
assert(total==peak*31,"expected the same configured icon count on every reserve")
print(("PASS: real battleground reserve builds spread %d native containers across 31 renders, max %d per frame"):format(total,peak))
