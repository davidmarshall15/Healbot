local function read(path)
    local f=assert(io.open(path,'rb')); local s=f:read('*a'); f:close()
    return s:gsub('\r\n','\n'):gsub('^\239\187\191','')
end
local source=assert(read('tests/native_buff_casters.lua'):match('^(.-)\nlocal function admits%('))
local fixture=assert(loadstring(source..'\nreturn fixture'))()
local d=fixture('PRIEST',4)
d.skin.limits={4,2,2}
local donor=d.button()
local calls=0
local original=d.env.HealBot_WoWAPI_SpellName
d.env.HealBot_WoWAPI_SpellName=function(...) calls=calls+1; return original(...) end
local rows={}
for i=1,28 do
    local row={unit='raid'..i,frame=1,healthBar={}}
    function row:GetFrameLevel() return 5 end
    rows[i]=row
end
local prepare=d.env.HealBot_Forever_PrepareArrivalAuraContext
local context=prepare and prepare()
for _,row in ipairs(rows) do d.env.HealBot_Forever_SkinArrivalAuras(row,donor,context) end
local initial=calls
assert(initial>0,'configuration workload was not exercised')
local allocated=#d.frames
calls=0
context=prepare and prepare()
for _,row in ipairs(rows) do d.env.HealBot_Forever_SkinArrivalAuras(row,donor,context) end
assert(#d.frames==allocated,'unchanged refresh allocates containers')
if prepare then assert(calls==initial,'unchanged pass must scan once, not once per row') end
if prepare then
    calls=0
    for _=1,8 do
        local rosterPass=prepare(true)
        for _,row in ipairs(rows) do d.env.HealBot_Forever_SkinArrivalAuras(row,donor,rosterPass) end
    end
    assert(calls==0,'warm roster passes repeated spell lookups')
end
for _,row in ipairs(rows) do assert(#row.arrivalAuras==3,'reserve row lost prepared icon sets') end
-- Next event must see changed settings; a snapshot must never survive the pass.
d.globals.CustomBuffsIconSet[139]=2
d.globals.WatchHoT.PRIE[139]=3
context=prepare and prepare(true)
for _,row in ipairs(rows) do d.env.HealBot_Forever_SkinArrivalAuras(row,donor,context) end
for _,row in ipairs(rows) do
    local found=false
    for _,item in ipairs(row.arrivalAuras) do
        if item.set==2 then
            local group=item.container.groups.hbcahotEveryone
            assert(group.options.candidateFilters.includeSpellIDs[139],'next pass missed icon-set/caster edit')
            found=true
        end
    end
    assert(found,'missing second icon set')
end
if prepare then
    calls=0; prepare(); local oneScan=calls
    calls=0; d.hook('HealBot_Aura_ConfigClassHoT')
    assert(calls==oneScan,'configuration event rescanned for each reserve row')
    -- DropAll rebuilds normal and reserve rows with the same pass snapshot.
    calls=0; d.env.SlashCmdList.HBCOMBATAURAS('size 19')
    assert(calls==0,'a size-only rebuild rescanned unchanged spell settings')
end
-- No native allocations or configuration scan from the direct combat path.
d.combat(true); calls=0; allocated=#d.frames
for _,row in ipairs(rows) do d.env.HealBot_Forever_SkinArrivalAuras(row,donor) end
assert(calls==0 and #d.frames==allocated,'combat arrival path performed configuration work')
if prepare then
    prepare(); assert(calls==0,'combat snapshot builder scanned configuration')
    d.combat(false); d.globals.CombatAurasOn=false; calls=0
    context=prepare()
    for _,row in ipairs(rows) do d.env.HealBot_Forever_SkinArrivalAuras(row,donor,context) end
    assert(calls==0,'disabled native auras scanned configuration')
end
print('PASS: 28 reserve rows; spell-name calls per pass='..initial..'; shared='..tostring(not not prepare)..'; settings and combat checks passed')
