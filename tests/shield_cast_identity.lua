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
    assert(start==expected and (not expected or duration==15),"wrong lockout on "..row.unit)
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
print("PASS: confirmed own shield casts follow live recipient identity across token reuse, ambiguity, failed casts and expiration")
