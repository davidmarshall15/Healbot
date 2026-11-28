-- Drive the installed event handlers on a roster whose unit tokens can be
-- reassigned between SENT, SUCCEEDED and aura expiration.
local source=arg[1] or "HealBot/HealBot_ForeverPeriodic.lua"
local secret={}
local now=10
local function noop() end
local units={
    raid1={guid="GUID-A",name="Alice",realm="Home",player=true},
    raid2={guid="GUID-B",name="Bob",realm="Away",player=true},
    raid3={guid="GUID-C",name="Cora",realm="Home",player=true},
}
local rows,hooks,queue={},{},{}
local nameReads,playerReads=0,0
local events={RegisterEvent=noop,RegisterUnitEvent=noop}
function events:SetScript(_,fn) self.fire=fn end
local env=setmetatable({
    HEALBOT_FOREVER=true,SlashCmdList={},HealBot_Buttons=rows,
    UnitClass=function() return "Priest","PRIEST" end, CreateFrame=function() return events end,
    GetTime=function() return now end,GetNormalizedRealmName=function() return "Home" end,
    C_Spell={GetSpellName=function(id) return id==17 and "Power Word: Shield" or "Other" end},
    UnitGUID=function(unit) return units[unit].guid end,
    UnitFullName=function(unit) nameReads=nameReads+1;return units[unit].name,units[unit].realm end,
    UnitIsPlayer=function(unit) playerReads=playerReads+1;return units[unit].player end,
    C_Timer={After=function(t,fn) queue[#queue+1]={at=now+t,fn=fn} end},
    HealBot_issecretvalue=function(v) return rawequal(v,secret) end,
    hooksecurefunc=function(name,fn) hooks[name]=fn end,
    HealBot_Events_UnitDebuff=function(row)
        row.updates=row.updates+1
        row.dirtyWhenQueued=row.aura.debuff.update
    end,
    wipe=function(t) for k in pairs(t) do t[k]=nil end end,
    HealBot_Panel_RaidUnitName=function() end, print=noop,
},{__index=_G})
for i=1,4 do
    local unit="raid"..(i==4 and 1 or i)
    rows[i]={unit=unit,frame=1,guid=units[unit].guid,name=units[unit].name,status={events=true},
             aura={debuff={}},event={},updates=0}
end
setfenv(assert(loadfile(source)),env)()
local function event(kind,who,...)
    events:fire("UNIT_SPELLCAST_"..kind,who,...)
end
local function cast(name,id,rank)
    event("SENT","player",name,id,rank or 17)
    event("SUCCEEDED","player",id,rank or 17)
end
local function check(row,expected)
    local start,duration=env.HealBot_Forever_GetShieldLockout(row)
    assert((not expected and not start) or (expected and start and math.abs(start-expected)<0.00001 and duration==15),
           "wrong lockout on "..row.unit..": expected "..tostring(expected)..", got "..tostring(start))
end
local function advance(t)
    now=t
    for i=#queue,1,-1 do if queue[i].at<=now then table.remove(queue,i).fn() end end
end
local function click(row) hooks.HealBot_Action_ButtonPreClick(nil,nil,row) end
click(rows[1]); cast("Outside-Home","cast-outside");check(rows[1],nil)
click(rows[1]); cast(secret,"cast-secret-name");check(rows[1],nil)
click(rows[1]); cast("","cast-empty-name");check(rows[1],nil)
for _,failure in ipairs({"FAILED","FAILED_QUIET","INTERRUPTED"}) do
    event("SENT","player","Alice-Home",failure,17);event(failure,"player",failure,17)
    event("SUCCEEDED","player",failure,17);check(rows[1],nil)
end
event("SENT","player","Alice","wrong-rank",17);event("SUCCEEDED","player","wrong-rank",592);check(rows[1],nil)
event("SENT","player","Alice","secret-rank",17);event("SUCCEEDED","player","secret-rank",secret);check(rows[1],nil)
event("SENT","party1","Alice","not-own",17);event("SUCCEEDED","player","not-own",17);check(rows[1],nil)
event("SENT","player","Alice",secret,17);event("SUCCEEDED","player",secret,17);check(rows[1],nil)
units.raid2.name="Alice"
click(rows[1]);cast("Alice","ambiguous-short");check(rows[1],nil);check(rows[2],nil)
units.raid2.name="Bob"
event("SENT","player","Alice-Home","moving",592)
units.raid1,units.raid3=units.raid3,units.raid1 -- stale cached button guid and name intentionally persist
events:fire("GROUP_ROSTER_UPDATE")
event("SUCCEEDED","player","moving",592)
check(rows[1],nil);check(rows[3],10)
assert(rows[1].updates==0 and rows[2].updates==0 and rows[3].updates==1 and rows[4].updates==0 and rows[3].dirtyWhenQueued)
nameReads,playerReads=0,0
for _=1,40 do check(rows[1],nil);check(rows[3],10) end
assert(nameReads==0 and playerReads==0,"unrelated refreshes performed name/player reads despite public GUIDs")
event("SUCCEEDED","player","moving",592);assert(rows[3].updates==1)
units.raid3.guid=secret;check(rows[3],10) -- the same character's fully qualified public name
units.raid1.guid=secret;units.raid1.name=secret
check(rows[1],nil) -- a hidden replacement cannot borrow its previous occupant's cached identity
units.raid3.guid="GUID-NEW";check(rows[3],nil) -- a contrary public GUID defeats a same-name fallback
units.raid3.guid="GUID-A"
advance(12); cast("Alice-Home","fresh")
rows[3].aura.debuff.update=false;advance(25)
check(rows[3],12);assert(rows[3].updates==2,"superseded timer disturbed the newer cast")
advance(27);check(rows[3],nil);assert(rows[3].updates==3 and rows[3].dirtyWhenQueued,"expiry did not dirty the actual recipient")
units.raid3.guid,units.raid3.realm=secret,nil
cast("Alice-Home","no-guid");check(rows[3],27)
units.raid3.name="Another";check(rows[3],nil)
units.raid3.name="NPC";units.raid3.player=false
cast("NPC-Home","npc-without-guid");check(rows[3],nil)
units.raid1.name,units.raid1.guid,units.raid1.realm="Zed","GUID-Z",secret
cast("Zed-Home","opaque-realm");check(rows[1],nil)
units.raid1.realm="My Realm"
cast("Zed-MyRealm","full-realm");check(rows[1],27);check(rows[4],27)
assert(rows[1].updates==1 and rows[4].updates==1,"duplicate frames for a confirmed target were not both dirtied")
local counts={sent=0,targetMissing=0,castKeyMissing=0,matched=0,rankMismatch=0,unpaired=0}
env.HealBot_Forever_ShieldPerf=counts
cast("Zed-MyRealm","diagnostic-good",600)
event("SENT","player","Outside-Home","diagnostic-miss",600)
event("SUCCEEDED","player","diagnostic-miss",600)
event("SENT","player","Zed-MyRealm",secret,600)
event("SENT","player","Zed-MyRealm","diagnostic-rank",600)
event("SUCCEEDED","player","diagnostic-rank",592)
assert(counts.sent==4 and counts.matched==1 and counts.targetMissing==1 and
       counts.castKeyMissing==1 and counts.unpaired==1 and counts.rankMismatch==1)
advance(60)
local function aura(start,fields)
    local row={spellId=17,isHelpful=true,sourceUnit="player",duration=30,expirationTime=start+30}
    for k,v in pairs(fields or {}) do row[k]=v end
    return row
end
local function added(unit,row)
    events:fire("UNIT_AURA",unit,{addedAuras={row},isFullUpdate=false})
end
local lookup,exact=0
env.C_UnitAuras={GetUnitAuraBySpellID=function(unit,id)
    assert(id==17)
    lookup=lookup+1
    return exact
end}
added("raid1",aura(60));check(rows[1],nil)
cast(secret,"owned-shield")
for _,row in ipairs({aura(52),aura(62),aura(60,{sourceUnit="party2"}),aura(60,{spellId=1277463}),
            aura(60,{spellId=592}),aura(60,{isHelpful=false}),aura(60,{duration=secret}),
            aura(60,{expirationTime=secret}),aura(60,{sourceUnit=secret}),aura(60,{timeMod=2})}) do
    added("raid1",row);check(rows[1],nil)
end
advance(60.2)
added("raid1",aura(60.1));check(rows[1],60.1)
assert(lookup==0,"ordinary added-aura packets performed redundant queries")
events:fire("UNIT_AURA","raid1",{removedAuraInstanceIDs={111},isFullUpdate=false})
check(rows[1],60.1) -- breaking the absorb does not end its separate lockout
env.HealBot_Forever_ConfirmShieldAbsent(rows[1],(env.HealBot_Forever_GetShieldLockout(rows[1])))
check(rows[1],nil); check(rows[4],nil)
added("raid1",aura(60.1));check(rows[1],nil)
advance(63)
event("SENT","player","","aura-before-success",17)
added("raid1",aura(63));check(rows[1],nil)
event("SUCCEEDED","player","aura-before-success",17);check(rows[1],63)
units.raid1,units.raid2=units.raid2,units.raid1
check(rows[1],nil);check(rows[2],63)
advance(78);check(rows[2],nil)
event("SENT","player",secret,"failed-aura",17)
added("raid1",aura(78));event("FAILED","player","failed-aura",17)
event("SUCCEEDED","player","failed-aura",17);check(rows[1],nil)
event("SENT","player","","removed-before-success",17)
added("raid1",aura(78));env.HealBot_Forever_ConfirmShieldAbsent(rows[1])
event("SUCCEEDED","player","removed-before-success",17);check(rows[1],nil)
advance(80);cast("Other-Outside","named-outside")
added("raid1",aura(80));check(rows[1],nil)
advance(82);cast(secret,"exact-full-update");exact=aura(82)
events:fire("UNIT_AURA","raid1",{isFullUpdate=true})
check(rows[1],82);assert(lookup==1)
advance(97);check(rows[1],nil);cast(secret,"expired-evidence")
advance(99);added("raid1",aura(97));check(rows[1],nil)
cast(secret,"zone-hop");events:fire("PLAYER_ENTERING_WORLD");added("raid1",aura(99));check(rows[1],nil)
advance(101);cast(secret,"already-removed")
env.HealBot_Forever_ConfirmShieldAbsent(rows[1]);added("raid1",aura(101));check(rows[1],nil)
advance(105);cast(secret,"burst");exact=nil;lookup=0
for _=1,100 do
    events:fire("UNIT_AURA","raid1",{isFullUpdate=true})
    events:fire("UNIT_AURA","outside",{isFullUpdate=true})
end
assert(lookup==2,"many unrelated updates repeatedly queried the same unit")
added("raid1",aura(105));check(rows[1],105)
advance(122);cast("Zed-MyRealm","named-new");check(rows[2],122)
env.HealBot_Forever_ConfirmShieldAbsent(rows[2],122,121);check(rows[2],122)
env.HealBot_Forever_ConfirmShieldAbsent(rows[2],122,122.1);check(rows[2],nil)
advance(126);cast("Zed-MyRealm","named-after-removal");check(rows[2],126)
advance(129);event("SENT","player","Zed-MyRealm","early-6788",17)
advance(129.2);event("SUCCEEDED","player","early-6788",17);check(rows[2],129.2)
env.HealBot_Forever_ConfirmShieldAbsent(rows[2],129.2,129.1);check(rows[2],nil)
print("PASS: confirmed own shields follow current recipients, including independently corroborated applications, removal and expiry")
