local function read(path)
    local f=assert(io.open(path,"rb"))
    local source=f:read("*a"):gsub("\r\n","\n")
    f:close()
    return source
end
local source=read("HealBot/Healbot_Aura.lua")
local match=assert(source:match("(do\n    local function public%(value%).-\nend)\n\nfunction HealBot_Aura_CheckCurDebuff"))
local types=assert(source:match('(do\n    local names={"Magic","Curse","Disease","Poison","Bleed"}.-\nend)'))
local token,role,group,guid,class,pvp,focus,solo="raid3",true,2,"TANK","PRIEST",true,true,false
local secret={}
local scopes={Magic={MainTanks=true},Poison={Raid=true}}
local e=setmetatable({
    HealBot_issecretvalue=function(value) return rawequal(value,secret) end,
    HealBot_Data={PLAYERGROUP=2},HealBot_Config={PrivFocus="TANK"},hb_lVars={TankGUID1="TANK"},
    GetRaidRosterInfo=function() return "Member",0,group end,
    UnitGUID=function() return guid end,UnitClass=function() return "Priest",class end,
    UnitIsPVP=function() return pvp end,IsInRaid=function() return not solo end,IsInGroup=function() return not solo end,
    UnitIsUnit=function(unit,other) return unit==other or (other=="focus" and focus) end,
    HealBot_Panel_IsTank=function() return role end,HealBot_Panel_IsMyTarget=function(g) return g=="TANK" end,
    HealBot_Options_retDebuffWatchTarget=function(t) return scopes[t] end,
},{__index=_G})
setfenv(assert(loadstring(match.."\n"..types)),e)()
local row={unit=token}
for _,key in ipairs({"Raid","Party","MainTanks","SingleTank","PRIE","Name","Focus","PvP","MyTargets"}) do
    assert(e.HealBot_Aura_DispelTargetMatches(row,{[key]=true}),key)
end
local set,sig,limited=e.HealBot_Forever_GetDebuffTypes()
assert(limited and sig=="Magic,Poison" and set.Magic and set.Poison)
assert(rawequal(set,e.HealBot_Forever_GetDebuffTypes(row)),"equivalent target scopes recreated filter")
role,group,guid,class,pvp,focus=false,secret,secret,secret,secret,false
for _,key in ipairs({"Party","MainTanks","SingleTank","PRIE","Name","Focus","PvP","PvE","MyTargets","Self","Solo"}) do
    assert(not e.HealBot_Aura_DispelTargetMatches(row,{[key]=true}),key)
end
assert(select(2,e.HealBot_Forever_GetDebuffTypes(row))=="Poison")
solo,pvp,row.unit=true,false,"player"
for _,key in ipairs({"Self","Solo","PvE"}) do assert(e.HealBot_Aura_DispelTargetMatches(row,{[key]=true}),key) end
local fixture=assert(read("tests/forever_frames.lua"):match('^(.-)local b=button%("party1"%)'))
local eb,button,hooks=setfenv(assert(loadstring(fixture.."return env,button,hooks")),getfenv())()
local b=button("party1")
eb.HealBot_Forever_GetDebuffTypes=function(target)
    if target then return e.HealBot_Forever_GetDebuffTypes(row) end
    return e.HealBot_Forever_GetDebuffTypes()
end
role=true
hooks.HealBot_Action_RegisterUnitEvents(b)
for _,f in pairs(b.foreverDebuffs) do
    function f:SetAuraGroupCandidateFilters(_,policy)
        self.saved=policy.includeDispelTypes
        self.writes=(self.writes or 0)+1
    end
end
role=false
hooks.HealBot_Aura_CheckUnitDebuffs(b)
assert(b.foreverDebuffs.all.shown and b.foreverDebuffs.all.saved.Poison and not b.foreverDebuffs.all.saved.Magic)
local n=b.foreverDebuffs.all.writes
hooks.HealBot_Aura_CheckUnitDebuffs(b)
assert(b.foreverDebuffs.all.writes==n)
b.aura.debuff={scanUnit="party1",scanCombat=false,publicUnit="party1"}
hooks.HealBot_Aura_CheckUnitDebuffs(b)
assert(not b.foreverDebuffs.all.shown,"native dispel tint covered exact user color")
b.aura.debuff.publicUnit=nil; b.aura.debuff.id=6788
hooks.HealBot_Aura_CheckUnitDebuffs(b)
assert(not b.foreverDebuffs.all.shown,"public warning lost color during mixed scan")
b.aura.debuff.id=0
hooks.HealBot_Aura_CheckUnitDebuffs(b)
assert(b.foreverDebuffs.all.shown,"native tint failed to recover when public warning ended")
print("PASS: shared dispel targets match public roster metadata and restricted values; native health tint yields to public warnings")
