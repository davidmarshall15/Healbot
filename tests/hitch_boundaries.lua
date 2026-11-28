local function read(path)
    local f=assert(io.open(path,"rb"))
    local source=f:read("*a"):gsub("\r\n","\n")
    f:close()
    return source
end
local code=read("HealBot/HealBot_ForeverFrames.lua")
local start=assert(code:find("-- Optional timing for the still-reported",1,true))
local block=code:sub(start)
local clock,nativeReads,frameNumber,printed=0,0,0,{}
local sampler={events={}}
function sampler:Hide() self.shown=false end
function sampler:Show() self.shown=true end
function sampler:RegisterEvent(event) self.events[event]=true end
function sampler:UnregisterAllEvents() self.events={} end
function sampler:SetScript(name,fn) self[name]=fn end
local env=setmetatable({
    CreateFrame=function() return sampler end, GetTime=function() return clock/1000 end,
    GetServerTime=function() return 1780000000 end,GetBuildInfo=function() return '1.60.1','71139' end,
    UnitClass=function() return 'Warrior','WARRIOR' end, HealBot_issecretvalue=function() return false end,
    debugprofilestop=function() return clock end,
    IsInGroup=function()return false end,IsInRaid=function() return false end,
    InCombatLockdown=function() return false end, Enum={AddOnProfilerMetric={LastTime=3}},
    SlashCmdList={},HealBot_Globals={},wipe=function(t)for k in pairs(t) do t[k]=nil end end,
    print=function(s)printed[#printed+1]=s end}, {__index=_G})
env._G=env
local inaccessible={}
env.canaccesstable=function(t) return t~=inaccessible end
env.C_AddOnProfiler={
    GetAddOnMetric=function(name,m) nativeReads=nativeReads+1;assert(name=="HealBot" and m==3);return frameNumber+1 end,
    GetOverallMetric=function(m) nativeReads=nativeReads+1;assert(m==3);return frameNumber+2 end,
    GetApplicationMetric=function(m) nativeReads=nativeReads+1;assert(m==3);return frameNumber+3 end,
    GetTopKAddOnsForMetric=function(m,k)
        nativeReads=nativeReads+1;assert(m==3 and k==5)
        return {{addOnName="OtherAddon",metricValue=frameNumber+4},inaccessible}
    end}
env.HealBot_Panel_PositionBars=function() clock=clock+4 end
env.HealBot_Panel_SetupBars=function() env.HealBot_Panel_PositionBars(); clock=clock+3 end
env.HealBot_Panel_PlayersChanged=function() env.HealBot_Panel_SetupBars(); clock=clock+2 end
env.HealBot_Panel_buildDataStore=function() clock=clock+1 end
local updateCosts={HealBot_Update_ResetUnitOpacity=4,HealBot_Forever_UpdatePrediction=2,HealBot_ItemIdsInBag=3}
for name,cost in pairs(updateCosts) do env[name]=function() clock=clock+cost end end
env.HealBot_Panel_PartyChanged=function() env.HealBot_Panel_buildDataStore(); env.HealBot_Panel_PlayersChanged(); clock=clock+1 end
local original=env.HealBot_Panel_PartyChanged
local netReads=0
env.GetNetStats=function() netReads=netReads+1; return 1000,2000,42,65 end
setfenv(assert(loadstring(block)),env)()
assert(not sampler.shown and not next(sampler.events) and original==env.HealBot_Panel_PartyChanged)
local cmd=env.SlashCmdList.HEALBOTLIVEPERF
cmd("on")
local function tick(ms)
    frameNumber=frameNumber+1
    clock=clock+ms
    sampler:OnUpdate(ms/1000)
end
local cpu=os.clock()
for i=1,200000 do tick(6) end
local steady=os.clock()-cpu
assert(nativeReads==0 and netReads==0)
local function drawTooltip() clock=clock+2; return "drawn" end
env.HealBot_Action_DoRefreshTooltip=drawTooltip
sampler:OnEvent("ADDON_LOADED","HealBot_Tips")
sampler:OnEvent("ADDON_LOADED","HealBot_Tips")
assert(env.HealBot_Action_DoRefreshTooltip()=="drawn")
sampler:OnEvent("PLAYER_TARGET_CHANGED")
env.HealBot_Panel_PartyChanged()
for name in pairs(updateCosts) do env[name]() end
tick(160)
assert(nativeReads==4)
tick(99) -- the following and the second hitch share the native sample, one query set
assert(nativeReads==8)
tick(6)
assert(nativeReads==12 and netReads==2)
cmd("report")
local r=env.HealBot_Globals.ForeverPerformanceReport
local h=r.hitches[1]
assert(h.boundary.recentHomeLatencyMs==42 and h.boundary.recentWorldLatencyMs==65)
assert(not r.hitches[2].following.recentHomeLatencyMs and not r.hitches[2].following.recentWorldLatencyMs)
assert(r.playerClass=="WARRIOR" and r.clientBuild=="71139" and r.startedUtc==1780000000)
assert(r.slowFrames==2 and #r.hitches==2 and h.boundary.wallMs==160)
assert(h.boundary.heaviestName=="HealBot_Panel_PartyChanged" and h.boundary.heaviestMs==11)
assert(h.boundary.tooltipPhases.HealBot_Action_DoRefreshTooltip.ms==2)
assert(h.boundary.tooltipPhases.HealBot_Action_DoRefreshTooltip.calls==1)
for name,cost in pairs(updateCosts) do
    assert(h.boundary.updatePhases[name].ms==cost and h.boundary.updatePhases[name].calls==1)
end
assert(env.HealBot_Action_DoRefreshTooltip==drawTooltip)
assert(h.boundary.partyPhases.HealBot_Panel_buildDataStore.ms==1 and h.boundary.partyPhases.HealBot_Panel_PlayersChanged.ms==9)
assert(h.boundary.partyPhases.HealBot_Panel_SetupBars.ms==7 and h.boundary.partyPhases.HealBot_Panel_PositionBars.ms==4)
assert(h.boundary.topAddons[1].name=="OtherAddon" and #h.boundary.topAddons==1)
assert(h.boundary.recentEvents.PLAYER_TARGET_CHANGED<1 and h.following.healBotMs==h.boundary.healBotMs+1)
assert(h.following==r.hitches[2].boundary and r.hitches[2].following.wallMs==6)
assert(h.boundary.heaviestMs<1+9+7+4 and not h.following.heaviestMs)
assert(not sampler.shown and original==env.HealBot_Panel_PartyChanged)
cmd("on")
env.C_AddOnProfiler.GetOverallMetric=function() error("native unavailable") end
env.C_AddOnProfiler.GetTopKAddOnsForMetric=function() return inaccessible end
env.GetNetStats=function() netReads=netReads+1; return 0,0,55567,"unavailable" end
env.HealBot_issecretvalue=function(v) return v==55567 end
for i=1,20 do tick(100+i) end
tick(6)
local prior,priorNet=nativeReads,netReads
tick(40)
tick(6)
assert(nativeReads==prior and netReads==priorNet,"discarded smaller hitch requested native counters")
cmd("report")
r=env.HealBot_Globals.ForeverPerformanceReport
assert(#r.hitches==12 and r.slowFrames==21 and r.hitches[1].boundary.wallMs==120)
assert(r.hitches[12].boundary.wallMs==109 and not r.hitches[1].boundary.addonsMs and not r.hitches[1].boundary.topAddons)
assert(not r.hitches[1].boundary.recentHomeLatencyMs and not r.hitches[1].boundary.recentWorldLatencyMs)
cmd("on"); env.C_AddOnProfiler=nil;env.GetNetStats=function() error("unavailable") end;tick(180);cmd("report")
h=env.HealBot_Globals.ForeverPerformanceReport.hitches[1]
assert(h.boundary and not h.following and not h.boundary.addonsMs)
assert(not h.boundary.recentHomeLatencyMs and not h.boundary.recentWorldLatencyMs)
cmd("on");env.GetNetStats=nil;tick(80);cmd("report")
assert(not env.HealBot_Globals.ForeverPerformanceReport.hitches[1].boundary.recentHomeLatencyMs)
cmd("on");env.GetNetStats=function() return 0,0,55567,0 end;tick(80);cmd("report")
h=env.HealBot_Globals.ForeverPerformanceReport.hitches[1]
assert(not h.boundary.recentHomeLatencyMs and h.boundary.recentWorldLatencyMs==0)
cmd("on");cmd("off");assert(not sampler.shown and not next(sampler.events))
print(("PASS: 200000 ordinary frame samples in %.3fs, zero native profiler calls; nested phases, coincident boundaries, top-12 retention and unavailable counters"):format(steady))
