local function read(path)
    local f=assert(io.open(path,'rb')); local s=f:read('*a'); f:close()
    return s:gsub('\r\n','\n'):gsub('^\239\187\191','')
end
local prefix=assert(read('tests/native_buff_casters.lua'):match('^(.-)\nlocal function admits%('))
local fixture=assert(loadstring(prefix..'\nreturn fixture'))()
local d=fixture('PRIEST',4)
local e=d.env
local donor=d.button()
local reserve={unit='raid2',frame=1,healthBar={}}
function reserve:GetFrameLevel() return 5 end
e.HealBot_Forever_SkinArrivalAuras(reserve,donor)
e._G=e
local now=1
e.GetTime=function() return now end
e.debugprofilestop=function() now=now+.001; return now*1000 end
e.wipe=function(t) for k in pairs(t) do t[k]=nil end end
local sampler={events={}}
function sampler:Hide() self.shown=false end
function sampler:Show() self.shown=true end
function sampler:SetScript(name,fn) self[name]=fn end
function sampler:RegisterEvent(name) self.events[name]=true end
function sampler:UnregisterAllEvents() self.events={} end
local instance,zone,zoneReads='none','Ironforge',0
e.IsInInstance=function() return instance~='none',instance end
e.GetRealZoneText=function() zoneReads=zoneReads+1; return zone end
local homeMode,homeSize,instanceMode,instanceSize,rosterReads
e.LE_PARTY_CATEGORY_HOME=1
e.LE_PARTY_CATEGORY_INSTANCE=2
e.IsInGroup=function(category)
    rosterReads=rosterReads+1
    return category==1 and homeMode~=nil or category==2 and instanceMode~=nil
end
e.IsInRaid=function(category)
    rosterReads=rosterReads+1
    return category==1 and homeMode=='raid' or category==2 and instanceMode=='raid'
end
e.GetNumGroupMembers=function(category)
    rosterReads=rosterReads+1
    if category==1 then return homeSize end
    assert(category==2); return instanceSize
end
local lines={}
e.print=function(line) lines[#lines+1]=line end
local create=e.CreateFrame
e.CreateFrame=function(kind,...) if kind=='Frame' then return sampler end; return create(kind,...) end
local function original(...) return select('#',...),... end
e.HealBot_Action_setLuVars=original
local function throwing() error('test failure') end
e.HealBot_Timers_Set=throwing
local party=read('HealBot/HealBot_ForeverPartyJoin.lua')
local visitor=assert(party:match('(function HealBot_Forever_VisitPartyPerfScopes%b().-\nend)'))
local runSync=setfenv(assert(loadstring('local Sync=...\n'..visitor..'\nreturn function(...) return Sync(...) end')),e)(original)
local function runTimer(_,_,...) now=now+.020; return ... end
e.HealBot_Timers_RunTimer=runTimer
e.HealBot_UnitUpdateButton=original
local baseline={}
e.HealBot_Forever_VisitAuraPerfScopes(function(name,fn) baseline[name]=fn; return fn end)
local text=read('HealBot/HealBot_ForeverFrames.lua')
local start=assert(text:find('-- Optional timing for the still-reported',1,true))
text=text:sub(start)
setfenv(assert(loadstring(text)),e)()
local cmd=e.SlashCmdList.HEALBOTLIVEPERF
for pass=1,2 do
    instance,zone='none','Ironforge'
    homeMode,homeSize,instanceMode,instanceSize,rosterReads=nil,0,nil,0,0
    lines={}
    cmd('on')
    assert(e.HealBot_Forever_ShieldPerf and e.HealBot_Forever_ShieldPerf.sent==0)
    e.HealBot_Forever_ShieldPerf.sent=pass
    assert(sampler.shown and sampler.events.PLAYER_ENTERING_WORLD and sampler.events.PLAYER_REGEN_DISABLED)
    local syncCount,x,y,z=runSync(1,nil,3)
    assert(syncCount==3 and x==1 and y==nil and z==3)
    local reads,membershipReads=zoneReads,rosterReads
    for i=1,100 do sampler:OnUpdate(.001); e.HealBot_UnitUpdateButton(i) end
    assert(zoneReads==reads and rosterReads==membershipReads,'timing polled zone/roster on each frame or call')
    homeMode,homeSize='raid',25; sampler:OnEvent('GROUP_ROSTER_UPDATE'); sampler:OnUpdate(.008)
    assert(zoneReads==reads,'roster change unnecessarily read the zone')
    instance,zone,instanceMode,instanceSize='party','Shadowfang Keep','party',5; sampler:OnEvent('PLAYER_ENTERING_WORLD'); sampler:OnUpdate(.01)
    instance,zone,instanceMode,instanceSize='raid','Molten Core','raid',20; sampler:OnEvent('PLAYER_ENTERING_WORLD'); sampler:OnUpdate(.03)
    instance,zone,instanceMode,instanceSize='pvp','Arathi Basin','raid',36; sampler:OnEvent('PLAYER_ENTERING_WORLD')
    instanceSize=40; sampler:OnEvent('GROUP_ROSTER_UPDATE')
    membershipReads=rosterReads
    sampler:OnEvent('PLAYER_REGEN_DISABLED')
    assert(rosterReads==membershipReads,'combat transition re-polled roster')
    assert(select('#',e.HealBot_Timers_RunTimer('AURA','Refresh',1,nil,3,nil))==4)
    local count,a,b,c=e.HealBot_Action_setLuVars(12,nil,34)
    assert(count==3 and a==12 and b==nil and c==34,'monitor changed argument/return arity')
    assert(not pcall(e.HealBot_Timers_Set),'monitor swallowed an error')
    e.HealBot_Forever_PrepareArrivalAuraContext()
    d.skin.size=20+pass
    d.hook('HealBot_Aura_SetAuraCheckFlags')
    e.HealBot_Forever_SkinArrivalAuras(reserve,donor)
    sampler:OnUpdate(.15)
    cmd('report')
    assert(e.HealBot_Action_setLuVars==original and e.HealBot_Timers_Set==throwing,'global wrappers not restored')
    e.HealBot_Forever_VisitAuraPerfScopes(function(name,fn) assert(fn==baseline[name],'local wrapper not restored'); return fn end)
    local report=d.globals.ForeverPerformanceReport
    assert(report.revision=='1.6' and report.slowFrames==1,'report lost frame metrics')
    assert(report.shield.sent==pass and report.shield.partialUnknown==0 and not e.HealBot_Forever_ShieldPerf)
    assert(table.concat(lines,'\n'):find('Shield: '..pass..' sent',1,true))
    assert(not sampler.shown and not next(sampler.events),'profiling events still subscribed after report')
    local bg='pvp / Arathi Basin / instance raid (40) / combat'
    local city='world / Ironforge / solo (1) / out of combat'
    assert(report.maxFrameContext==bg and report.contexts[bg].slowFrames==1)
    assert(report.maxFrameRosterType=='instance raid' and report.maxFrameRosterSize==40)
    assert(report.contexts[city].frames==100 and report.contexts[city].slowFrames==0)
    assert(report.contexts['world / Ironforge / raid (25) / out of combat'].frames==1)
    assert(report.contexts['party / Shadowfang Keep / instance party (5) / out of combat'].frames==1)
    assert(report.contexts['raid / Molten Core / instance raid (20) / out of combat'].maxFrameMs==30)
    local printed=table.concat(lines,'\n')
    assert(printed:find('Longest frame observed in '..bg,1,true))
    assert(printed:find('PartyJoin.Sync:',1,true) and printed:find(city,1,true))
    assert(e.HealBot_Timers_RunTimer==runTimer,'timer callback not restored')
    e.HealBot_Forever_VisitPartyPerfScopes(function(_,fn) assert(fn==original);return fn end)
    assert(report.rebuildReasons.size==1,'rebuild field reason not captured')
    assert(e.HealBot_Forever_RecordArrivalRebuild==nil,'observer not restored')
    local found=false
    local correlated,owner,partyScope,unitScope=false,false,false,false
    for _,entry in ipairs(report.functions) do
        if entry.name=='Aura.ConfiguredBuffFilters' then
            -- The explicit reserve passes each take a fresh snapshot. The flags
            -- notification between them reuses the current policy.
            found=true
            assert(entry.calls==2,'unexpected number of full filter compilations')
        end
        if entry.name=='Aura.RefreshBuffRows' then
            correlated=true
            assert(entry.worstBuildCalls==0 and entry.worstBuildMs==0,'policy refresh rebuilt native containers')
        end
        if entry.name=='HealBot_Timers_RunTimer' then
            owner=entry.calls==1 and entry.maxContext==bg and entry.maxRosterType=='instance raid'
                and entry.maxRosterSize==40 and entry.maxTimerCategory=='AURA' and entry.maxTimerName=='Refresh'
        elseif entry.name=='PartyJoin.Sync' then
            partyScope=entry.calls==1 and entry.maxContext==city
        elseif entry.name=='HealBot_UnitUpdateButton' then
            unitScope=entry.calls==100 and entry.maxContext==city
        end
    end
    assert(found and correlated,'missing detailed aura scopes')
    assert(owner and partyScope and unitScope,'timer, party sync or update owner missing')
end
cmd('on'); cmd('off')
e.HealBot_Forever_VisitAuraPerfScopes(function(name,fn) assert(fn==baseline[name]); return fn end)
assert(e.HealBot_Action_setLuVars==original)
do
    local count={painted=0,outOfRange=0,paintBlocked=0}
    local inRange,paints=true,0
    local noop=function() end
    local env={HealBot_Forever_ShieldPerf=count,hbAdaptive={},hbAdaptiveOrderName={Debuffs=1},
        HealBot_Unit_Status={PLUGINBARCOL=10,DEBUFFBARCOL=3,DEBUFFNOCOL=2,BUFFBARCOL=1},
        HealBot_Config_Cures={CDCshownHB=true,EnableBar=true},
        HealBot_Action_AdaptiveNextActive=noop,HealBot_Action_setState=noop,
        HealBot_Aura_IsCureSpell=noop,HealBot_Range_WarnInRange=function() return inRange end,
        HealBot_Action_BarColourAlpha=noop,hbv_Skins_GetFrameVar=noop,HealBot_Action_setEnabled=noop,
        HealBot_Action_UpdateHealthStatusBarColor=function() paints=paints+1 end,
        hbv_Skins_GetFrameBoolean=noop,HealBot_Action_UpdateBackground=noop,
        HealBot_Action_UpdateBuffButton=noop,HealBot_Action_UpdateHealthButton=noop}
    local action=assert(read('HealBot/HealBot_Action.lua'):match('(function HealBot_Action_UpdateDebuffButton%b().-\nend)'))
    setfenv(assert(loadstring(action)),env)()
    local bar={aura={debuff={id=6788,name='Weakened Soul',colbar=2,r=.45,g=0,b=.28}},status={current=0},range={current=1}}
    env.HealBot_Action_UpdateDebuffButton(bar)
    inRange=false; env.HealBot_Action_UpdateDebuffButton(bar)
    bar.status.current=10; env.HealBot_Action_UpdateDebuffButton(bar)
    bar.aura.debuff.id=1; env.HealBot_Action_UpdateDebuffButton(bar)
    assert(paints==1 and count.painted==1 and count.outOfRange==1 and count.paintBlocked==1)
end
print('PASS: detailed monitor captures local scopes, preserves nil varargs/returns and errors, restores locals/globals, and restarts without nested wrappers')
