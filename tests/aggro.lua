-- Exercise HealBot_CalcThreat on Midnight/Forever, where only UnitThreatSituation
-- is used. The status it reports must survive the threat-percentage checks.
local passed=0
local function eq(actual,expected,label)
    assert(actual==expected,label..": expected "..tostring(expected)..", got "..tostring(actual))
    passed=passed+1
end
local function forbidden() error("attempt to inspect a secret threat value") end
local secret=setmetatable({}, {__lt=forbidden,__le=forbidden,__eq=forbidden,
    __add=forbidden,__sub=forbidden,__mul=forbidden,__div=forbidden})
local file=assert(io.open(arg[1] or "HealBot/HealBot.lua","rb"))
local source=file:read("*a"):gsub("\r\n","\n")
file:close()
local calc=assert(source:match("(local ctEnemyUnit,ctTankUnit.-)\nlocal hbNameOnly"))

local function run(midnight,threat,existing)
    local updated,cleared
    local button={unit="party1",frame=1,status={current=1,incombat=true},
        aggro={status=existing or 0,threatpct=0,threatvalue=0,mobname="",targeted=0,nextcheck=0}}
    local env=setmetatable({
        HealBot_Unit_Status={DEAD=10},
        HealBot_luVars={TankGUID1="tank",aggroCheckInterval=1},
        HealBot_Globals={aggro2pct=55,aggro3pct=100},
        HealBot_TimeNow=100,
        UnitIsFriend=function() return true end,
        HealBot_Panel_PlayerUnitGUID=function() return nil end,
        HealBot_ValidLivingEnemy=function() return false end,
        HealBot_Util_isMidnight=function() return midnight end,
        HealBot_issecretvalue=function(value) return rawequal(value,secret) end,
        UnitThreatSituation=function() return threat end,
        HealBot_Aggro_UpdateUnit=function(_,_,data) updated=data["status"] end,
        HealBot_Aggro_ClearUnitAggro=function() cleared=true end,
        HealBot_UnitAffectingCombat=function() end,
    }, {__index=_G})
    setfenv(assert(loadstring(calc)),env)()
    env.HealBot_CalcThreat(button)
    return updated,cleared
end

eq((run(true,3)),3,"securely tanking shows aggro")
eq((run(true,2)),3,"insecurely tanking shows aggro")
eq((run(true,1)),2,"high threat shows the high threat level")
local updated,cleared=run(true,0,3)
eq(updated,nil,"no threat sends no aggro update")
eq(cleared,true,"no threat clears existing aggro")
updated=run(true,nil)
eq(updated,nil,"missing threat status is treated as none")
updated,cleared=run(true,secret,3)
eq(updated,nil,"secret threat status is not compared")
eq(cleared,true,"secret threat status clears aggro instead of erroring")

print("Aggro tests passed: "..passed)
