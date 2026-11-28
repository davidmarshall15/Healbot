-- Replay the nine-player battleground entrance with the real Sync and worker.
local file=assert(io.open("HealBot/HealBot_ForeverPartyJoin.lua","rb"))
local source=file:read("*a")
file:close()
local combat,raid,render=false,true,0
local filters,donor=1,nil
local units,widgets,pending,builds,armed={},{},{},{},{}
local perFrame={}
local function noop() end
local methods={SetSize=noop,SetPoint=noop,SetFrameStrata=noop,Hide=noop,RegisterEvent=noop}
function methods:SetScript(event,callback) self[event]=callback end
function methods:IsShown() return true end
local function widget(_,name)
    assert(not combat,"created a frame in combat")
    local value=setmetatable({},{__index=methods})
    if name then widgets[name]=value end
    return value
end
local api=setmetatable({
    HEALBOT_FOREVER=true,SlashCmdList={},HEALBOT_OPTIONS_GROUPHEALS_en="Group",
    _G=widgets,UIParent={},HealBot_Globals={ForeverPartyJoin=true},
    Healbot_Config_Skins={Current_Skin="A",HealGroups={A={},B={}}},
    C_Timer={After=function(_,callback) pending[#pending+1]=callback end},
    InCombatLockdown=function() return combat end,IsInRaid=function() return raid end,
    UnitExists=function(unit) return units[unit] end,CreateFrame=widget,hooksecurefunc=noop,
    HealBot_retLuVars=function() return true end,HealBot_Media_retLuVars=function() return true end,
    RegisterStateDriver=noop,UnregisterStateDriver=noop,
    RegisterUnitWatch=function(row) assert(not combat and row.styled and row.bound); armed[row.unit]=true end,
    UnregisterUnitWatch=function(row) assert(not combat); armed[row.unit]=nil end,
    HealBot_Forever_PrepareArrivalAuraContext=function() return {filters=filters} end,
    HealBot_Forever_UpdateArrivalAuras=function(row) assert(row.prepared) end,
    HealBot_Forever_SkinArrivalAuras=function(row,sourceButton,context)
        assert(not combat and not units[row.unit] and armed[row.unit],"worked on an unavailable slot")
        assert(context.filters==filters and sourceButton==donor,"used stale policy or donor")
        perFrame[render]=(perFrame[render] or 0)+1
        assert(perFrame[render]==1,"built multiple reserve members in one rendered frame")
        builds[#builds+1]=row.unit
        row.prepared=true
    end,
    donor=function() return donor,0,0 end,
},{__index=_G})
local sync,tick,working=setfenv(assert(loadstring(source..[[
    ApplySkin=function() end
    PositionReservedRows=function() return true end
    FindSkinDonor=donor
    CreateRow=function(mode,index)
        local row=CreateFrame("Button","HealBotForeverJoin"..mode..index)
        row.unit=mode..index
        return row
    end
    BindRow=function(row) row.bound=true; row.bindingGeneration=bindingGeneration end
    SkinExtras=function(row) row.styled=true; row.frame=frame end
    return Sync,function() if auraWorker and auraWorker.OnUpdate then auraWorker:OnUpdate() end end,
        function() return auraWorker and auraWorker.OnUpdate~=nil end
]])),api)()
local function nextFrame()
    render=render+1
    tick()
end
local function readyDonor()
    local member=widget()
    member.status,member.frame={active=true},1
    return member
end
local function setup()
    for i=1,9 do units["raid"..i]=true end
    donor=readyDonor()
    sync()
    for i=10,40 do assert(armed["raid"..i],"empty slot was not prearmed") end
    assert(#builds==0 and working(),"setup built native widgets synchronously")
end
setup()
for slot=10,17 do
    sync(); sync()
    nextFrame()
    assert(builds[#builds]=="raid"..slot,"repeated syncs starved a later slot")
end
filters=2
api.HealBot_Forever_UpdateQueuedArrivalFilters(filters)
nextFrame()
assert(builds[#builds]=="raid18")
donor=readyDonor()
api.Healbot_Config_Skins.Current_Skin="B"
sync()
nextFrame()
assert(builds[#builds]=="raid19")
combat=true
units.raid20=true
nextFrame()
assert(not working() and not widgets.HealBotForeverJoinraid20.prepared and armed.raid20,
    "an unwarmed combat arrival lost its secure click target")
local before=#builds
for i=1,3 do sync(); nextFrame() end
assert(#builds==before)
combat=false
sync()
assert(not armed.raid20,"ordinary roster did not reclaim the occupied slot")
nextFrame()
assert(builds[#builds]=="raid21","regen restarted the queue or built an occupied slot")
for i=1,40 do nextFrame() end
assert(not working(),"queue failed to finish")
for i=10,40 do
    if i~=20 then assert(widgets["HealBotForeverJoinraid"..i].prepared) end
end
api.HealBot_Forever_QueueReserveAuraRefresh()
assert(#pending==1)
table.remove(pending,1)()
assert(working())
raid=false
sync()
for i=1,4 do
    nextFrame()
    assert(builds[#builds]=="party"..i and armed["party"..i],"old raid work survived a pool change")
end
assert(not working())
sync()
api.HealBot_Globals.ForeverPartyJoin=false
nextFrame()
assert(not working(),"feature disable did not cancel queued work")
print("PASS: 31 BG reserves immediately armed, one native row per render, fresh policy and donor, combat handoff, mode switch and cancellation")
