local function read(path)
    local file=assert(io.open(path,"rb"))
    local source=file:read("*a"):gsub("\r\n","\n")
    file:close()
    return source
end
local source=read("HealBot/Healbot_Aura.lua")
local operations=assert(source:match("(do\n    local function readable%(aura%).-\nend)\n\nfunction HealBot_Aura_UpdateUnitDebuffsV9"))
local check=assert(source:match("(local function HealBot_Aura_AuraDataIsUsable%b().-\nend)"))
local dispatch=assert(source:match("(function HealBot_Aura_UpdateUnitDebuffsV9%b().-\nend)"))
local secret={}
local inaccessible={}
local combat=false
local generallyRestricted=false
local all,removable,byID
local seen,queries
local e=setmetatable({
    HEALBOT_FOREVER=true, hb_lVars={},
    HealBot_Globals={CustomDebuffs={[6788]=10,[888]=8,[999]=12},DebuffIconVisibility={[990]={combat=true}}},
    C_Secrets={
        GetSpellAuraSecrecy=function(id) return id==999 and "always" or "never" end,
        ShouldAurasBeSecret=function() return generallyRestricted end,
    },
    Enum={SecrecyLevel={NeverSecret="never"}},
    InCombatLockdown=function() return combat end,
    HealBot_issecretvalue=function(v) return rawequal(secret,v) end,
    canaccesstable=function(v) return not rawequal(inaccessible,v) end,
    HealBot_UnitDebuffCurrent={party1={}},
    C_UnitAuras={
        GetUnitAuras=function(_,filter)
            queries[filter]=(queries[filter] or 0)+1
            if filter=="HARMFUL" then if all==nil then error("restricted") end; return all end
            return removable
        end,
        GetUnitAuraBySpellID=function(_,id) queries[id]=(queries[id] or 0)+1; return byID[id] end,
    },
},{__index=_G})
setfenv(assert(loadstring(check.."\n"..operations.."\n"..dispatch)),e)()
e.HealBot_Aura_UpdateUnitDebuffsData=function(button,_,_,iconOnly)
    assert(not iconOnly,"readable debuff bypassed ordinary caster, color and priority policy")
    seen[e.uaSpellId]=(seen[e.uaSpellId] or 0)+1
    e.HealBot_UnitDebuffCurrent[button.unit][e.uaName]=e.uaSpellId
end
local button={unit="party1",aura={debuff={}}}
local function aura(id,dispeller,caster)
    return {name="Test"..id,spellId=id,duration=12,expirationTime=14,sourceUnit=caster or "player",
        isHarmful=true,dispelName=dispeller,applications=1,icon=123}
end
local function scan(broad,dispels,lookups)
    all,removable,byID=broad,dispels,lookups or {}
    seen,queries={},{}
    e.HealBot_UnitDebuffCurrent.party1={}
    e.HealBot_Aura_UpdateUnitDebuffsV9(button,false)
end
for _,lock in ipairs({false,true}) do
    combat=lock
    scan({aura(6788),aura(888),aura(777,"Magic")})
    assert(seen[6788]==1 and seen[888]==1 and seen[777]==1 and queries.RAID_PLAYER_DISPELLABLE==1)
    assert(button.aura.debuff.publicUnit=="party1" and button.aura.debuff.scanCombat==combat)
end
local partial=aura(999)
partial.expirationTime=secret
scan({aura(777,"Magic"),partial,aura(888),aura(777,"Magic","party2"),inaccessible},
    {aura(777,"Magic"),secret},{[6788]=aura(6788),[990]=aura(990)})
assert(not button.aura.debuff.publicUnit and button.aura.debuff.publicShield)
assert(seen[777]==2 and seen[888]==1 and seen[6788]==1 and seen[990]==1 and not seen[999])
assert(queries.HARMFUL==1 and queries.RAID_PLAYER_DISPELLABLE==1 and not queries[999])
local observed=button.aura.debuff.publicDispels
assert(observed[777] and not observed[888])
scan({partial,aura(777,"Magic")},{aura(777,"Magic")},{})
assert(rawequal(observed,button.aura.debuff.publicDispels),"unchanged public dispels invalidated the native row")
scan(nil,{aura(301,"Magic")},{[6788]=partial,[888]=inaccessible,[990]=secret})
assert(not button.aura.debuff.publicShield and seen[301]==1 and not seen[6788] and not seen[888])
generallyRestricted=true
scan({},nil,{[6788]=aura(6788)})
assert(not button.aura.debuff.publicUnit and seen[6788]==1,"empty restricted response hid the native renderer")
scan({aura(888),aura(301,"Magic")},{aura(301,"Magic")},{[6788]=aura(6788)})
assert(not button.aura.debuff.publicUnit and seen[6788]==1 and seen[888]==1 and seen[301]==1,
    "nonempty public subset suppressed restricted auras or duplicated a readable dispel")
local first,sibling=aura(301,"Magic"),aura(301,"Magic")
first.auraInstanceID=94; sibling.auraInstanceID=95
scan({first,sibling},{first},{})
assert(seen[301]==2,"the second public application of the same spell/caster was dropped")
scan({sibling},{first},{})
assert(seen[301]==2,"distinct readable instance IDs were incorrectly merged across queries")
first.auraInstanceID=secret; sibling.auraInstanceID=secret
scan({first,sibling},{first},{})
assert(seen[301]==2,"unavailable instance IDs lost application multiplicity")
scan({},nil,{[6788]=aura(98765)})
assert(not seen[98765] and not button.aura.debuff.publicShield,"unrelated lookup result claimed tracked identity")
generallyRestricted=false
scan({},nil,{})
assert(button.aura.debuff.publicUnit=="party1" and not button.aura.debuff.publicShield)
local visible,connected=true,true
e.UnitIsVisible=function() return visible end
e.UnitIsConnected=function() return connected end
visible=false; scan({},nil,{})
assert(not button.aura.debuff.publicUnit,"invisible unit's empty scan claimed all rows")
visible=true; connected=secret; scan({aura(888)},nil,{})
assert(not button.aura.debuff.publicUnit and seen[888]==1,"unverified connection suppressed native ownership")
connected=true; scan({aura(888)},nil,{})
assert(button.aura.debuff.publicUnit=="party1" and seen[888]==1,"reconnected public scan failed to recover")
combat=false
e.C_UnitAuras.GetAuraDataByIndex=function(_,index) if index==1 then return aura(888) end end
scan(nil,nil,{})
assert(button.aura.debuff.publicUnit=="party1" and seen[888]==1,"ordinary indexed access lost")
e.C_UnitAuras.GetAuraDataByIndex=function(_,index) if index==1 then return aura(888) end; error("restricted") end
scan(nil,{aura(301,"Magic")},{})
assert(not button.aura.debuff.publicUnit and seen[888]==1 and seen[301]==1,"interrupted ordinary scan lost its public data")
-- Exercise actual renderer ownership with the existing native widget fixture.
local base=assert(read("tests/bg_weakened_soul.lua"):match("^(.-)local d=fixture"))
local fixture=assert(loadstring(base.."return fixture"))()
local d=fixture("PRIEST",4)
local env=d.env
env.IsInInstance=function() return true,"pvp" end
env.HealBot_Forever_WatchesWeakenedSoul=function() return true end
local queued={}
-- Run the production slow-update marker to verify that only this button
-- enters the per-unit debuff refresh queue when native ownership changes.
local slowSource=assert(read("HealBot/HealBot.lua"):match("(function HealBot_DebuffSlowUpdate%b().-\nend)"))
local slowUpdate=setfenv(assert(loadstring(slowSource.."\nreturn HealBot_DebuffSlowUpdate")),{})()
env.HealBot_DebuffSlowUpdate=function(button)
    queued[#queued+1]=button
    slowUpdate(button)
end
env.HealBot_Timers_Set=function(_,name) assert(name~="CheckDebuffs","slot change queued a roster-wide refresh") end
env.HealBot_Aura_GetHiddenDebuffIcons=function(inCombat) return {[inCombat and 988 or 989]=true} end
d.globals.CombatAurasNativeWeakenedSoul=true
local b=d.button()
local db,slot
for _,f in ipairs(d.frames) do
    if f.groups.hbcadb then db=f end
    if f.groups.hbcaweakenedSoul then slot=f end
end
assert(db and slot and db.shown and slot.shown and db.groups.hbcadb.options.candidateFilters.excludeSpellIDs[989])
b.aura={debuff={scanUnit=b.unit,scanCombat=false,publicUnit=b.unit,publicShield=true}}
d.hook("HealBot_Aura_CheckUnitDebuffs",b)
assert(not db.shown and not slot.shown and not b.hbcaNativeDebuffs,"readable auras drawn twice")
assert(#queued==1 and queued[1]==b and b.status.slowupdate and b.aura.debuff.slowupd and b.aura.debuff.update)
d.hook("HealBot_Aura_CheckUnitDebuffs",b)
assert(#queued==1,"unchanged slot ownership queued its button twice")
env.HealBot_Events_UnitDebuff=function(target) target.debuffQueued=true end
b.aura.debuff.update=false
d.fire("PLAYER_ENTERING_WORLD")
assert(b.debuffQueued and b.aura.debuff.update and db.shown and slot.shown,"same token carried its previous world's scan into the BG")
b.aura.debuff={scanUnit=b.unit,scanCombat=false,publicUnit=b.unit,publicShield=true}
d.hook("HealBot_Aura_CheckUnitDebuffs",b)
assert(not db.shown and not slot.shown)
d.hook("HealBot_UpdateUnitGUIDChange",b)
assert(not b.aura.debuff.scanUnit and b.aura.debuff.update and db.shown and slot.shown,
    "party token rebound to a new occupant retained the old public suppression")
b.aura.debuff.scanUnit=b.unit
b.aura.debuff.publicUnit=nil
b.aura.debuff.publicDispels={[777]=true}
d.hook("HealBot_Aura_CheckUnitDebuffs",b)
assert(db.shown and not slot.shown,"public shield duplicated during mixed scan")
assert(db.groups.hbcadb.options.candidateFilters.excludeSpellIDs[777],"mixed scan failed to exclude exact public dispels")
local policy=db.groups.hbcadb.options.candidateFilters
assert(policy.includeDispelTypes.Magic and not (policy.excludeDispelTypes and policy.excludeDispelTypes.Magic),
    "one public Magic debuff hid the entire native Magic category")
-- Friendly harmful spell-ID exclusions are effective only for NeverSecret.
-- Keep the native row for other protected Magic applications even when the
-- client cannot disambiguate one previously readable non-NeverSecret ID.
local function nativeShows(spell,never)
    return policy.includeDispelTypes.Magic and not (never and policy.excludeSpellIDs[spell])
end
assert(not nativeShows(777,true) and nativeShows(778,false))
assert(nativeShows(777,false) and nativeShows(778,false))
local writes=db.filterWrites
d.hook("HealBot_Aura_CheckUnitDebuffs",b)
assert(db.filterWrites==writes,"unchanged mixed scan rewrote native group filters")
local frameCount=#d.frames
d.combat(true)
assert(slot.shown and db.shown and db.groups.hbcadb.options.candidateFilters.excludeSpellIDs[988])
assert(not db.groups.hbcadb.options.candidateFilters.excludeSpellIDs[989] and #d.frames==frameCount)
b.unit="raid1"
d.hook("HealBot_SetUnitDisconnectChange",b)
assert(slot.shown,"old occupant's public scan suppressed new unit")
env.HealBot_Aura_GetTrackedDebuffIconSet=function() return nil end
d.hook("HealBot_Aura_CheckUnitDebuffs",b)
assert(not slot.shown,"native slot ignored the target or instance exclusion")
local matches=false
env.HealBot_Forever_GetDebuffTypes=function(target)
    if target and not matches then return {},"",true end
    return {Magic=true},"Magic",true
end
d.hook("HealBot_Options_Debuff_Reset")
assert(not db.shown,"selected dispel category leaked to a nonmatching target")
matches=true; d.hook("HealBot_Aura_CheckUnitDebuffs",b)
assert(db.shown,"unit role change failed to restore dispel row")
print("PASS: public harmful auras use ordinary profile rules, mixed and denied scans recover, native filters switch without new frames")
