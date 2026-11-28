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
local selectors=assert(read("HealBot/Healbot_Aura.lua"):match("(do\n    local function casterMatches.-\nend)"))
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
event({updatedAuraInstanceIDs={43}}); assert(drain()==nil)
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
print("PASS: verified custom harmful applications survive combat privacy changes and retire on expiry, removal, roster changes and authoritative scans")
