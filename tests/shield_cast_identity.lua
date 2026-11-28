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
local counts={sent=0,targetMissing=0,castKeyMissing=0,matched=0,rankMismatch=0,unpaired=0,
    clickAbsent=0,clickRankMismatch=0,clickNameMismatch=0,clickLate=0,clickInvalidated=0,
    publicNameMiss=0,nameHidden=0,
    directClick=0,clickMatched=0,auraMatched=0}
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

-- Use the action classifier itself and drive the hook invoked by the normal
-- and emergency PreClick handlers. Only the direct friendly release action
-- can fill an unnamed same-frame SENT; success must match the same cast/rank.
local action=assert(io.open("HealBot/HealBot_Action.lua","rb"))
local body=action:read("*a"):gsub("\r\n","\n");action:close()
body=assert(body:match("(local function ForeverClickedSpell.-)\nfunction HealBot_Action_ButtonPreClick"))
setfenv(assert(loadstring(body)),env)()
env.HealBot_Config_Spells={ButtonCastMethod=2}
env.C_Spell.GetSpellDescription=function() return "" end
env.SpellIsTargeting=function() return false end
env.UnitCanAttack=function() return false end
env.UnitCanAssist=function() return true end
env.SecureButton_GetModifiedUnit=function(frame) return frame.unit end
env.SecureButton_GetModifiedAttribute=function(frame,key,mouse)
    if key=="helpbutton" and mouse=="RightButton" then return "heal2" end
    if mouse=="heal2" then return frame[key] end
end
env.HealBot_Spells_KnownByName=function(spell) return spell=="Power Word: Shield(Rank 3)" and 600 or nil end
local function direct(row,kind)
    local frame={unit=row.unit,type=kind or "spell",spell="Power Word: Shield(Rank 3)"}
    hooks.HealBot_Action_ButtonPreClick(frame,"RightButton",row)
    return frame
end
advance(150)
local priorMissing=counts.targetMissing
direct(rows[1]);event("SENT","player",secret,"direct",600);check(rows[1],nil)
advance(150.15);event("SUCCEEDED","player","direct",600)
check(rows[1],150.15);check(rows[2],nil)
assert(counts.directClick==1 and counts.clickMatched==1 and counts.targetMissing==priorMissing+1)
advance(166);check(rows[1],nil)
env.HealBot_Forever_EndShieldClick(direct(rows[1]))
advance(166.01);cast(secret,"next-frame",600);check(rows[1],nil)
assert(counts.clickLate==1,"an unrelated later unnamed shield inherited a stale click")
direct(rows[1]);cast("Outside-Home","other-target",600);check(rows[1],nil)
direct(rows[1]);cast("","bad-binding-rank",17);check(rows[1],nil)
direct(rows[1]);click(rows[2]);cast("","different-click",600);check(rows[1],nil);check(rows[2],nil)
direct(rows[1],"macro");cast("","arbitrary-macro",600);check(rows[1],nil)
direct(rows[1]);event("SENT","player",secret,"failed-direct",600);event("FAILED","player","failed-direct",600)
event("SUCCEEDED","player","failed-direct",600);check(rows[1],nil)
direct(rows[1]);event("SENT","player",secret,"intervening",139);cast("","later",600);check(rows[1],nil)
-- Both identity fields can be hidden. The action still explicitly targeted
-- the public subscribed roster slot. Dropping/replacing the slot retires it.
local member=units.raid1
member.guid,member.name=secret,secret
direct(rows[1]);cast("","opaque-slot",600);check(rows[1],166.01);check(rows[4],166.01)
events:fire("GROUP_ROSTER_UPDATE");check(rows[1],nil);check(rows[4],nil)
direct(rows[1]);event("SENT","player",secret,"replaced-slot",600)
hooks.HealBot_Action_UnregisterUnitEvents(rows[1]);hooks.HealBot_Action_UnregisterUnitEvents(rows[4])
hooks.HealBot_Action_RegisterUnitEvents(rows[1]);hooks.HealBot_Action_RegisterUnitEvents(rows[4])
event("SUCCEEDED","player","replaced-slot",600);check(rows[1],nil);check(rows[4],nil)
member.guid,member.name="GUID-B","Bob"
-- If the actual cast arrives later, an explicit incremental addition still
-- has a public new instance under private timing. The same fields in an
-- arbitrary lookup or mixed update cannot bring an old shield back.
advance(180);local previousAura=counts.auraMatched
cast(secret,"hidden-delta-clock")
local opaque=aura(180,{duration=secret,expirationTime=secret,auraInstanceID=90001})
exact=opaque;events:fire("UNIT_AURA","raid1",{isFullUpdate=true})
events:fire("UNIT_AURA","raid1",{isFullUpdate=false,addedAuras={opaque},removedAuraInstanceIDs={90001}})
check(rows[1],nil)
advance(180.24);added("raid1",opaque);check(rows[1],180);check(rows[2],nil)
assert(counts.auraMatched==previousAura+1)
advance(200);direct(rows[1]);cast("Bob-Away","named-click-before-combat",600);check(rows[1],200)
member.guid,member.name=secret,secret;check(rows[1],200)
env.UnitIsConnected=function() return false end;check(rows[1],nil)
env.UnitIsConnected=function() return true end;check(rows[1],200)
events:fire("GROUP_ROSTER_UPDATE");check(rows[1],nil);check(rows[4],nil)
-- Regional names have both a given name and a surname. Ze Lang and Ze Lake
-- can share a roster. Neither a conflicting surname nor an unverified realm
-- may be turned into a match by truncating the event's target name.
advance(230)
units.raid1={guid="FOREVER-Z1",name="Ze",realm="Lang",player=true}
units.raid2={guid="FOREVER-Z2",name="Ze",realm="Lake",player=true}
units.raid3={guid="FOREVER-R",name="Rysha",realm="Flamebreeze",player=true}
env.RegionalUniqueNamesEnabled=function() return true end
env.GetUnitName=function(unit)
    if unit=="raid3" then return "Rysha Flamebreeze-North Moon" end
    return units[unit].name.."-"..units[unit].realm
end
cast("Ze","two-different-surnames",600);check(rows[1],nil);check(rows[2],nil)
cast("Ze Long","similar-surname",600);check(rows[1],nil);check(rows[2],nil)
cast("Ze Lang-Foreign","unverified-realm",600);check(rows[1],nil)
cast("Ze Lang","split-regional-name",600);check(rows[1],230);check(rows[4],230);check(rows[2],nil)
cast("Rysha Flamebreeze-NorthMoon","qualified-regional-name",600);check(rows[3],230)
advance(246)
env.RegionalUniqueNamesEnabled=function() return false end
cast("Ze Lang","second-value-is-realm",600);check(rows[1],nil)
cast("Ze-Lang","ordinary-realm",600);check(rows[1],246)
advance(262)
env.RegionalUniqueNamesEnabled=function() return secret end
cast("Ze Lang","unknown-name-format",600);check(rows[1],nil)
direct(rows[1]);advance(262.01);cast(secret,"inside-click-frame-boundary",600)
check(rows[1],262.01);check(rows[2],nil)
advance(278)
local here=direct(rows[1])
env.HealBot_Forever_EndShieldClick({}) -- a different frame cannot close this click
env.C_Spell.GetBaseSpell=function(id) return id==600 and 17 or id end
cast(secret,"attested-base-rank",17);check(rows[1],278);check(rows[2],nil)
advance(294);here=direct(rows[1]);env.HealBot_Forever_EndShieldClick(here)
advance(294.1);cast(secret,"unrelated-base-rank",17);check(rows[1],nil)
here=direct(rows[1]);env.HealBot_Forever_EndShieldClick(here)
local first,realm=units.raid1.name,units.raid1.realm
units.raid1.name,units.raid1.realm=secret,secret
advance(294.25);cast(first.."-"..realm,"delayed-identified-shield",600)
check(rows[1],294.25);check(rows[2],nil)
units.raid1.name,units.raid1.realm=first,realm
advance(311);env.RegionalUniqueNamesEnabled=function() return true end
here=direct(rows[1]);env.HealBot_Forever_EndShieldClick(here)
units.raid1.name,units.raid1.realm=secret,secret
advance(311.1);cast(first.." "..realm,"delayed-regional-shield",600)
check(rows[1],311.1);check(rows[2],nil)
units.raid1.name,units.raid1.realm=first,realm
assert(counts.clickRankMismatch>=2 and counts.clickNameMismatch>=1 and counts.clickAbsent>0)
advance(330)
local probes,verified=0,false
env.HealBot_Events_ObserveOwnShieldDebuff=function(unit,subscribed)
    assert(unit=="raid1" and subscribed[rows[1]])
    probes=probes+1
    return verified
end
local function laterShield(key,wait)
    local f=direct(rows[1]);env.HealBot_Forever_EndShieldClick(f)
    advance(now+wait);cast(secret,key,600)
end
local function tickAura(unit)
    events:fire("UNIT_AURA",unit,{isFullUpdate=false})
end
laterShield("no-public-aura",0.05)
tickAura("raid2");assert(probes==0)
for i=1,20 do tickAura("raid1") end
assert(probes==2);check(rows[1],nil);check(rows[2],nil)
verified=true;laterShield("actual-aura",0.05)
tickAura("raid1");tickAura("raid1");assert(probes==3);check(rows[1],nil)
laterShield("changed-member",0.05);events:fire("GROUP_ROSTER_UPDATE")
tickAura("raid1");assert(probes==3)
laterShield("rebound-member",0.05)
units.raid1.guid="OTHER";tickAura("raid1");assert(probes==3)
laterShield("too-old",1.05);tickAura("raid1");assert(probes==3)
advance(348)
event("SENT","player",secret,"older-attempt",600)
direct(rows[1]);event("FAILED_QUIET","player","older-attempt",600)
cast(secret,"newer-click",600);check(rows[1],348);check(rows[2],nil)
advance(364)
direct(rows[1]);event("FAILED_QUIET","player","no-previous-send",600)
cast(secret,"hotkey-after-local-failure",600);check(rows[1],nil)
print("PASS: confirmed own shields follow current recipients, including independently corroborated applications, removal and expiry")
