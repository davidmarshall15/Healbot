-- Replay a real deferred UNIT_AURA, the combat scanner, and bar selection.
local function read(path)
    local file=assert(io.open(path,"rb"))
    local source=file:read("*a"):gsub("\r\n","\n")
    file:close()
    return source
end
local fixture=assert(read("tests/public_debuff_parity.lua"):match("^(.-)for _,lock in ipairs"))
local e,button,scan,aura,secret,inaccessible,combat=assert(loadstring(fixture..[[
return e,button,scan,aura,secret,inaccessible,function(value) combat=value; generallyRestricted=value end
]]))()
local events=read("HealBot/HealBot_Events.lua")
local first=assert(events:find("local function ReadableAuraTable",1,true))
local last=assert(events:find("function HealBot_Events_UnitManaUpdate",first,true))
setfenv(assert(loadstring(events:sub(first,last-1))),e)()
local source=read("HealBot/Healbot_Aura.lua")
local selectors=assert(source:match("(function HealBot_Aura_CustomDebuffCasterMatches%b().-\nend)")).."\n"..
    assert(source:match("(do\n    local function customBar.-\nend)"))
setfenv(assert(loadstring(selectors)),e)()
button.status,button.event,button.aura.buff,button.frame={events=true,unittype=1},{},{},1
local now,guid,visible,connected=100,"Player-1",true,true
local clock,cast,retired={},nil,nil
e.GetTime=function() return now end
e.C_Timer={After=function(delay,fn) clock[#clock+1]={at=now+delay,run=fn} end}
e.UnitGUID=function() return guid end
e.UnitIsVisible=function() return visible end
e.UnitIsConnected=function() return connected end
e.HealBot_Options_retDebuffPriority=function(id) return id==6788 and 4 or 6,21 end
e.HEALBOT_CUSTOM_CASTBY_EVERYONE="everyone"
e.castByListIndexed={everyone=1}
e.hbCustomDebuffsCastBy={}
e.HealBot_DebuffFilter={}
e.HealBot_Globals.CureCustomDefaultCastBy=1
e.HealBot_Globals.CustomDebuffsShowBarCol={[6788]=3,[888]=3}
e.HealBot_Aura_CustomDebuffDisabled=function() return false end
e.HealBot_Forever_GetShieldLockout=function() return cast end
e.HealBot_Forever_ConfirmShieldAbsent=function(_,start) retired=start end
e.HealBot_Forever_WatchesWeakenedSoul=function() return true end
e.HealBot_WoWAPI_SpellName=function(id) return "Test"..id end
e.HealBot_Aura_CheckUnitAuras=function(_,harmful)
    assert(harmful)
    scan(nil,{}, {})
end
local function entry(id,instance,ending)
    local row=aura(id,nil,"party3")
    row.auraInstanceID,row.expirationTime=instance,ending
    return row
end
local function event(payload)
    e.HealBot_Events_UnitAura(button,button.unit,payload)
end
local function drain()
    assert(button.event.debuff)
    e.HealBot_Events_TimedUnitDebuff(button)
    return e.HealBot_Forever_GetPartialBarWarning(button,false)
end
local function partial()
    scan(nil,{}, {})
    return e.HealBot_Forever_GetPartialBarWarning(button,false)
end
local function add(...)
    event({addedAuras={...}})
end
local state=button.aura.debuff
-- Start outside combat. A normal, timed application from a different priest
-- must stay on the same roster member when both the GUID and scan go private.
local normal=entry(6788,41,115)
scan({normal},{},{})
local cache,original=state.reported,state.reported.records[41]
scan({normal},{},{})
assert(cache==state.reported and original==cache.records[41],"stable complete scans allocated new records")
combat(true); guid=secret
assert(partial()==6788 and #clock==1 and clock[1].at==115,"combat entry lost a verified precombat application")
assert(partial()==6788 and #clock==1,"unchanged incomplete reads scheduled repeated timers")
-- The regular unit refresh also dispatches UnitStatus without a disconnect.
-- Its event must preserve the timed application on an unchanged roster slot.
e.HealBot_SetUnitDisconnect=function() end
e.HealBot_Unit_Status={DC=10}
button.status.current=10
e.HealBot_Events_UnitStatus(button)
assert(state.reported==cache and partial()==6788,"routine combat status refresh cleared a confirmed harmful instance")
now=115; clock[1].run()
assert(drain()==nil,"public expiration left the restricted bar colored")
-- Mixed deliveries must retain both signals while normal queues coalesce.
local shield,other=entry(6788,42,130),entry(888,43,131)
add(shield,other,{isHelpful=true})
add(shield)
shield.spellId=12345  -- the event-owned table must not be retained
assert(drain()==6788 and state.reported.records[42].spellId==6788)
assert(e.HealBot_Forever_GetPartialBarWarning(button,false,2)==nil,"higher-priority visible warning was overwritten")
assert(state.reported.records[43].sourceUnit=="party3")
cast=112
add(entry(6788,44,130)); assert(drain()==6788)
event({removedAuraInstanceIDs={42}}); assert(drain()==6788 and retired==nil,"one of two applications was treated as the last")
event({removedAuraInstanceIDs={44}})
assert(drain()==888 and retired==112 and state.shieldAbsentStart==112,"removed lockout incorrectly reclaimed the bar")
cast=116; assert(partial()==6788,"a genuinely new successful cast was suppressed")
add(entry(6788,66,130)); assert(drain()==6788) -- first seen at 115, before the next cast
now=117; cast=117
event({removedAuraInstanceIDs={66}})
assert(drain()==6788 and retired==112,"a delayed removal retired a newer shield on the same member")
now=118;add(entry(6788,67,120)); assert(drain()==6788)
now=120
assert(partial()==888 and retired==117,"known early 6788 expiry did not retire its matching estimate")
cast=nil
local instanceReads=0
e.C_UnitAuras.GetAuraDataByAuraInstanceID=function(_,id)
    instanceReads=instanceReads+1
    if id==43 then return entry(888,43,134) end
end
event({updatedAuraInstanceIDs={43,9999}})
assert(drain()==888 and state.reported.records[43].expirationTime==134 and instanceReads==1)
e.C_UnitAuras.GetAuraDataByAuraInstanceID=function() return inaccessible end
event({updatedAuraInstanceIDs={43}})
assert(drain()==888 and state.reported.records[43].expirationTime==134,"opaque update lost a known, timed instance")
local opaque=entry(888,43,139)
opaque.spellId=secret
e.C_UnitAuras.GetAuraDataByAuraInstanceID=function() return opaque end
event({updatedAuraInstanceIDs={43}})
assert(drain()==888 and state.reported.records[43].expirationTime==134,"opaque identity extended the known expiry")
opaque.expirationTime=124
event({updatedAuraInstanceIDs={43}})
assert(drain()==888 and state.reported.records[43].expirationTime==124,"public shorter expiry was ignored")
opaque.spellId,opaque.expirationTime=888,secret
event({updatedAuraInstanceIDs={43}})
assert(drain()==888 and state.reported.records[43].expirationTime==124,"private timer extended a publicly identified update")
now=124; assert(partial()==nil,"private update left an expired warning on the bar")
-- The public instance ID identifies an ongoing application, only until a
-- removal, authoritative rescan or identity change. Never seed an unseen ID.
add(entry(6788,53,130)); assert(drain()==6788)
e.C_UnitAuras.GetAuraDataByAuraInstanceID=function() return inaccessible end
event({updatedAuraInstanceIDs={53}}); assert(drain()==6788)
event({removedAuraInstanceIDs={53}}); assert(drain()==nil)
add(entry(888,54,nil)); assert(drain()==888)
event({updatedAuraInstanceIDs={54}}); assert(drain()==nil,"unknown timing retained an opaque update indefinitely")
for _,invalid in ipairs({entry(999,43,140),entry(888,99,140)}) do
    add(entry(888,43,130)); assert(drain()==888)
    e.C_UnitAuras.GetAuraDataByAuraInstanceID=function() return invalid end
    event({updatedAuraInstanceIDs={43}}); assert(drain()==nil,"a contrary identity retained a stale warning")
end
local changedSource=entry(888,43,130); changedSource.spellId,changedSource.sourceUnit=secret,"player"
add(entry(888,43,130)); assert(drain()==888)
e.C_UnitAuras.GetAuraDataByAuraInstanceID=function() return changedSource end
event({updatedAuraInstanceIDs={43}}); assert(drain()==nil,"partial update retained a conflicting caster")
add(entry(6788,43,125)); assert(drain()==6788)
e.C_UnitAuras.GetAuraDataByAuraInstanceID=function() error("restricted") end
event({updatedAuraInstanceIDs={43}}); assert(drain()==6788)
cast=124; now=125
event({updatedAuraInstanceIDs={43}})
assert(drain()==nil and retired==124,"update at verified expiry resurrected a completed shield cast")
cast=nil
add(entry(888,43,130)); assert(drain()==888)
e.C_UnitAuras.GetAuraDataByAuraInstanceID=function() return nil end
event({updatedAuraInstanceIDs={43}}); assert(drain()==888)
combat(false);event({updatedAuraInstanceIDs={43}})
assert(drain()==nil,"public instance lookup reported absence")
combat(true)
-- Roster generation, physical occupant, connection, visibility and incomplete
-- mutation boundaries each invalidate the cache before it can color another unit.
for _,change in ipairs({{isFullUpdate=true},{updatedAuraInstanceIDs=secret},
    {removedAuraInstanceIDs={secret}},{removedAuraInstanceIDs=inaccessible}}) do
    add(entry(6788,45,130)); assert(drain()==6788); event(change); assert(drain()==nil)
end
add(entry(6788,46,130)); assert(drain()==6788)
e.HealBot_Events_ResetReportedAuraGeneration(); assert(drain()==nil)
guid="A"; add(entry(6788,47,130)); assert(drain()==6788); guid="B"; assert(partial()==nil)
add(entry(6788,47,130)); assert(drain()==6788); connected=false
e.HealBot_Events_UnitStatus(button); assert(drain()==nil and not state.reported); connected=true
add(entry(6788,47,130)); assert(drain()==6788); visible=secret; assert(partial()==nil); visible=true
add(entry(6788,47,130)); assert(drain()==6788); button.status.events=false; assert(partial()==nil); button.status.events=true
button.unit="target"; guid=secret; add(entry(6788,47,130)); assert(drain()==nil); button.unit="party1"
-- An authoritative complete scan with no matching instance wins. Unrelated
-- IDs, unidentifiable auras and missing instance IDs cannot seed a warning.
add(entry(6788,48,130)); assert(drain()==6788)
combat(false);scan({},{},{});combat(true);assert(partial()==nil)
local opaqueDispel=entry(888,50,130); opaqueDispel.dispelName=secret
local opaqueID=entry(6788,52,130); opaqueID.spellId=secret
add(entry(555,49,130),opaqueID,entry(6788,secret,130),opaqueDispel)
assert(drain()==nil and not state.reported)
event({addedAuras={entry(6788,55,130)},removedAuraInstanceIDs={secret}})
assert(drain()==nil and not state.reported,"an unknown mutation certified a first newly observed instance")
-- A late click can ask about one unit. The actual scoped result must prove
-- which aura exists and how long remains, even when it predates that click.
local function copyButton(unit)
    return {unit=unit,status=button.status,event={},aura={debuff={}},frame=1}
end
local duplicate,bystander=copyButton(button.unit),copyButton("party2")
local views={[button]=true,[duplicate]=true,[bystander]=true}
local reads,scopeData=0,nil
local getAuras=e.C_UnitAuras.GetUnitAuras
e.C_UnitAuras.GetUnitAuras=function(unit,filter,...)
    if filter~="HARMFUL|PLAYER" then return getAuras(unit,filter,...) end
    assert(unit==button.unit)
    reads=reads+1
    if scopeData==nil then error("restricted") end
    return scopeData
end
local function own(id,ending)
    local row=entry(id,60,ending); row.sourceUnit="player"; return row
end
local observe=e.HealBot_Events_ObserveOwnShieldDebuff
local counts={ownDebuffFound=0}
e.HealBot_Forever_ShieldPerf=counts
assert(not observe(button.unit,views))
local helpful=own(6788,130); helpful.isHarmful=false; helpful.isHelpful=true
local unknownSpell=own(6788,130); unknownSpell.spellId=secret
for _,value in ipairs({secret,inaccessible,{}, {secret}, {own(17,130)}, {own(6788,secret)},
    {own(6788,120)}, {entry(6788,60,130)}, {helpful}, {unknownSpell}}) do
    scopeData=value
    assert(not observe(button.unit,views) and not state.reported)
end
local previousReads=reads
scopeData={own(6788,127)}
assert(observe(button.unit,views) and reads==previousReads+1 and counts.ownDebuffFound==1)
assert(button.event.debuff and duplicate.event.debuff and not bystander.event.debuff)
assert(state.reported.records[60].expirationTime==127 and duplicate.aura.debuff.reported.records[60].expirationTime==127)
e.HealBot_Forever_ShieldPerf=nil
assert(drain()==6788)
now=127; assert(partial()==nil,"an existing short debuff acquired a new shield timer")
-- An exact aura may first become readable in the middle of combat, without
-- a public UNIT_AURA add. The next restricted scan must retain that same
-- timed instance for Everyone, including a shield cast by a different priest.
combat(true); cast=nil; guid="A"
local foreign=entry(6788,70,140)
scan(nil,{}, {[6788]=foreign})
assert(state.publicShield and state.reported and state.reported.records[70].sourceUnit=="party3",
    "a targeted public observation of another priest's shield was discarded")
assert(partial()==6788 and e.HealBot_Forever_GetPartialBarWarning(button,false,2)==nil)
e.HealBot_SafeUnitIsUnit=function(a,b) return a==b end
foreign.sourceUnit=secret
scan(nil,{}, {[6788]=foreign})
assert(state.reported.records[70].sourceUnit=="party3" and state.partialWarnings[1].source=="party3")
assert(e.HealBot_Forever_GetPartialBarWarning(button,true)==nil,"a foreign shield passed the self-only policy")
event({removedAuraInstanceIDs={70}}); assert(drain()==nil)

local frost=entry(888,71,140)
frost.icon=secret
scan({frost},{}, {})
assert(#state.partialWarnings==1 and e.HealBot_Forever_GetPartialBarWarning(button,false)==888)
local wake=clock[#clock]
assert(wake and wake.at==140 and partial()==888,"another caster's exact timed custom debuff did not survive an opaque scan")
now=140; wake.run(); assert(drain()==nil,"partially readable aura failed to expire")

local late=entry(888,72,150)
scan({late},{},{}); assert(partial()==888)
guid="B"; assert(partial()==nil,"a new occupant inherited a scan-only debuff")
local invalid=entry(888,73,150); invalid.isHarmful=secret
local private=entry(6788,74,150); private.spellId=secret
local untimed=entry(888,75,150); untimed.expirationTime=secret
scan({invalid,private,untimed,secret,inaccessible},{},{[6788]=entry(888,76,150)})
assert(partial()==nil and not state.reported,"an unverified observation seeded a lasting warning")

-- Group roster notifications can concern another member. A still-public
-- GUID must prove the same recipient before carrying a timer across them.
local pending=entry(6788,80,160)
add(pending); assert(drain()==6788)
e.HealBot_Events_ResetReportedAuraGeneration(true)
assert(partial()==6788,"an unrelated roster notification erased the same public recipient's aura")
local deadline=clock[#clock]; now=160; deadline.run(); assert(drain()==nil)
for _,change in ipairs({"changed GUID","private GUID","disconnected","rebound","world"}) do
    guid="original"; button.unit="party1"; connected=true
    add(entry(888,81,180)); assert(drain()==888)
    if change=="changed GUID" then guid="new"
    elseif change=="private GUID" then guid=secret
    elseif change=="disconnected" then connected=false
    elseif change=="rebound" then button.unit="raid4" end
    e.HealBot_Events_ResetReportedAuraGeneration(change~="world")
    assert(not state.reported,change.." retained the old recipient")
end

-- Restricted GUIDs are common on battleground members. A public full name
-- and realm can prove that this particular roster slot kept its recipient.
local short,realm,player=nil,nil,true
e.UnitFullName=function(unit) assert(unit==button.unit); return short,realm end
e.UnitIsPlayer=function() return player end
for _,case in ipairs({
    {secret,secret,"Member","RealmA",true}, {"A",secret,"Member","RealmA",true},
    {secret,"A","Member","RealmA",true}, {"A","B","Member","RealmA",false},
    {secret,secret,"Member","RealmB",false}, {secret,secret,"Other","RealmA",false},
    {secret,secret,"Member",nil,false}, {secret,secret,secret,"RealmA",false},
    {secret,secret,"Member",secret,false}, {"A","A","Changed","RealmB",true},
}) do
    button.unit="raid6"; guid=case[1]; short,realm="Member","RealmA"; connected=true
    add(entry(888,82,180)); assert(drain()==888)
    guid,short,realm=case[2],case[3],case[4]
    e.HealBot_Events_ResetReportedAuraGeneration(true)
    assert((partial()==888)==case[5],"failed current roster-recipient check")
    e.HealBot_Events_ResetReportedAuraGeneration()
end
guid=secret; short,realm="Member","RealmA"
add(entry(888,82,180)); assert(drain()==888)
player=false; e.HealBot_Events_ResetReportedAuraGeneration(true)
assert(partial()==nil,"a non-player inherited a roster member's warning")
player=true
for _,value in ipairs({"",secret}) do
    guid=secret; short,realm="Member",value
    add(entry(888,82,180)); assert(drain()==888)
    short,realm="Member","RealmA"; e.HealBot_Events_ResetReportedAuraGeneration(true)
    assert(partial()==nil,"incomplete original identity survived a roster change")
end
e.UnitFullName=nil

button.unit="party1"; guid="original"; connected=true; combat(true)
local uncertain=entry(6788,92,180); uncertain.expirationTime=secret
local refreshed=entry(6788,92,180)
local reads=0
e.C_UnitAuras.GetAuraDataByAuraInstanceID=function(_,id) reads=reads+1; assert(id==92); return refreshed end
scan({uncertain},{},{})
for i=1,40 do event({updatedAuraInstanceIDs={200+i}}) end
assert(reads==0 and not state.reported)
event({updatedAuraInstanceIDs={92}})
assert(reads==1 and drain()==6788,"an update with the exact observed instance and now-public lifetime was lost")
event({removedAuraInstanceIDs={92}}); assert(drain()==nil)
for _,kind in ipairs({"wrong id","wrong instance","hidden","private time","already ended","infinite","nan","changed recipient","hidden GUID"}) do
    guid="original"; refreshed=entry(6788,92,180)
    scan({uncertain},{},{})
    if kind=="wrong id" then refreshed.spellId=888
    elseif kind=="wrong instance" then refreshed.auraInstanceID=93
    elseif kind=="hidden" then refreshed=inaccessible
    elseif kind=="private time" then refreshed.expirationTime=secret
    elseif kind=="already ended" then refreshed.expirationTime=now
    elseif kind=="infinite" then refreshed.expirationTime=math.huge
    elseif kind=="nan" then refreshed.expirationTime=0/0
    elseif kind=="changed recipient" then guid="replacement"
    else guid=secret end
    local before=reads
    event({updatedAuraInstanceIDs={92}}); event({updatedAuraInstanceIDs={92}})
    assert(reads<=before+1 and drain()==nil and not state.reported,kind.." certified an invalid update")
end
guid="original"; refreshed=entry(6788,92,180)
for _,boundary in ipairs({{isFullUpdate=true},{removedAuraInstanceIDs={92}},{removedAuraInstanceIDs=secret}}) do
    scan({uncertain},{},{})
    local before=reads
    event(boundary); event({updatedAuraInstanceIDs={92}})
    assert(reads==before and drain()==nil,"old incomplete observation survived a mutation boundary")
end
scan({uncertain},{},{})
local before=reads
e.HealBot_Forever_DebuffsEnabled=function() return false end
event({updatedAuraInstanceIDs={92}})
assert(reads==before and drain()==nil,"a disabled monitor queried a changed instance")

-- A complete application from one caster must not mask a different public
-- instance of the same spell from the caster selected in the configuration.
e.HealBot_Forever_DebuffsEnabled=function() return true end
e.HEALBOT_OPTIONS_SELFHEALS="self"; e.castByListIndexed.self=2; e.hbCustomDebuffsCastBy[888]=2
e.HEALBOT_CUSTOM_CASTBY_FRIEND="friend"; e.HEALBOT_CUSTOM_CASTBY_ENEMY="enemy"
e.UnitIsFriend=function() return true end; e.UnitIsEnemy=function() return false end
local other=entry(888,101,190)
local mine=entry(888,102,185); mine.sourceUnit="player"; mine.icon=secret
local function selected() return e.HealBot_Forever_GetPartialBarWarning(button,false) end
for _,list in ipairs({{other,mine},{mine,other}}) do
    scan(list,{},{})
    assert(selected()==888,"another caster's readable instance blocked the configured caster")
    assert(e.HealBot_Forever_GetPartialBarWarning(button,false,2)==nil,"instance evidence overrode a higher priority")
end
scan({other},{},{})
assert(selected()==888,"event-retained application was hidden by the other caster's spell ID")
local foreignSibling=entry(888,103,190)
scan({foreignSibling,other},{},{})
assert(selected()==888,"multiple readable siblings masked a separate configured instance")
other.auraInstanceID=102
scan({other},{},{})
assert(selected()==nil,"same instance was processed again with an outdated caster")
other.auraInstanceID=secret
scan({other,mine},{},{})
assert(selected()==nil,"two readings without distinct public instance identities asserted separate applications")
other.auraInstanceID=101
scan({other,mine},{},{})
event({removedAuraInstanceIDs={102}}); scan({other},{},{})
assert(selected()==nil,"removed occurrence was reintroduced by a sibling")
print("PASS: verified custom harmful applications survive combat privacy changes and retire on expiry, removal, roster changes and authoritative scans")
