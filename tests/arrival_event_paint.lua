-- Run from the repository root with Lua 5.1. An optional source path and
-- "baseline" argument compare the prior release against the same event stream.
local f=assert(io.open(arg[1] or "HealBot/HealBot_ForeverPartyJoin.lua","rb"))
local source=f:read("*a")
f:close()
local baseline=arg[2]=="baseline"
local opaque,exists,clamp={},true,false
local numbers={health=70,maximum=100,power=20,powerMax=90,amount=15}
local calls={health=0,prediction=0,power=0,auras=0}
local noop=function() end
local function bar()
    local b=setmetatable({},{__index=function() return noop end})
    function b:SetValue(value,...)
        assert(select("#",...)==0,"unexpected StatusBar interpolation argument")
        self.value=value
    end
    function b:SetMinMaxValues(_,maximum) self.maximum=maximum end
    function b:Show() self.shown=true end
    function b:Hide() self.shown=false end
    return b
end
local mode=3
local env=setmetatable({
    HEALBOT_FOREVER=true,SlashCmdList={},hooksecurefunc=noop,CreateFrame=bar,
    HealBot_Globals={OverrideColours={}},PowerBarColor={MANA={r=0,g=0,b=1}},
    HealBot_issecretvalue=function(value) return rawequal(value,opaque) end,
    UnitExists=function() return exists end,
    UnitClass=function() return "Priest","PRIEST" end,UnitGroupRolesAssigned=function() return "HEALER" end,
    UnitInRange=function() return true,true end,UnitName=function() return "Fixture" end,
    UnitPowerType=function() return 0,"MANA" end,
    HealBot_WoWAPI_UnitHealth=function()
        calls.health=calls.health+1
        return numbers.health,numbers.maximum,0.7,70,0,0.3,0.7
    end,
    HealBot_WoWAPI_UnitMana=function(_,kind)
        assert(kind==0)
        calls.power=calls.power+1
        return numbers.power,numbers.powerMax,50
    end,
    HealBot_Action_ClassColour=function() return 1,1,1 end,
    hbv_Skins_GetRoleCol=function() return 1,1,1 end,
    hbv_Skins_GetFrameVar=function(_,key) return key=="IC" and mode or 1 end,
    hbv_Skins_GetFrameBoolean=function() return false end,
    hbv_Aux_GetBarVar=function() return 1 end,hbv_Aux_GetBarBoolean=function() return false end,
    UnitGetDetailedHealPrediction=function() calls.prediction=calls.prediction+1 end,
    HealBot_Forever_UpdateArrivalAuras=function(_,refresh)
        calls.auras=calls.auras+1; calls.refresh=refresh
    end,
},{__index=_G})
local paint=setfenv(assert(loadstring(source.."\nframe=1; return Paint")),env)()
local aux=bar()
local row={unit="raid39",healthBar=bar(),incomingBar=bar(),background=bar(),border=bar(),
    nameText=bar(),healthText=bar(),skinPower={{bar=aux,text=bar(),alpha=1}},
    incomingCalculator={GetMaximumHealth=function() return numbers.maximum end,
        GetIncomingHeals=function() return numbers.amount,clamp end}}

-- On this client opaque amounts are valid native bar inputs. Its interpolation
-- argument cannot take the calculator's second return, even when it is public.
for _,value in ipairs({false,true,opaque}) do
    clamp=value
    numbers.health,numbers.maximum,numbers.power,numbers.powerMax,numbers.amount=opaque,opaque,opaque,opaque,opaque
    local ok,err=pcall(paint,row,"UNIT_HEAL_PREDICTION")
    if baseline then
        assert(not ok and tostring(err):find("unexpected StatusBar interpolation argument",1,true))
    else
        assert(ok,err)
        assert(row.incomingBar.shown and rawequal(row.incomingBar.value,opaque))
        assert(rawequal(row.healthBar.value,opaque) and rawequal(row.healthBar.maximum,opaque))
        assert(rawequal(aux.value,opaque) and rawequal(aux.maximum,opaque))
    end
end
numbers.health,numbers.maximum,numbers.power,numbers.powerMax,numbers.amount=70,100,20,90,15
-- One return models a client build which never supplies clamp metadata.
row.incomingCalculator.GetIncomingHeals=function() return numbers.amount end
paint(row)
assert(row.healthBar.value==70 and row.incomingBar.value==15 and aux.value==20)
for _,entry in ipairs({{"UNIT_HEALTH",false},{"UNIT_MAXHEALTH",false},{"UNIT_HEAL_PREDICTION",false},
                       {"UNIT_CONNECTION",true},{"UNIT_NAME_UPDATE",true},{"UNIT_IN_RANGE_UPDATE",true}}) do
    local before=calls.health
    paint(row,entry[1])
    assert(calls.health==before+1 and calls.refresh==entry[2])
end
local beforeHealth,beforePrediction,beforePower,beforeAuras=calls.health,calls.prediction,calls.power,calls.auras
for _,event in ipairs({"UNIT_AURA","UNIT_POWER_UPDATE","UNIT_MAXPOWER","UNIT_DISPLAYPOWER"}) do
    for _=1,40 do paint(row,event) end
    assert(calls.refresh==(event=="UNIT_AURA" or event=="UNIT_DISPLAYPOWER"))
end
local health,prediction,power=calls.health-beforeHealth,calls.prediction-beforePrediction,calls.power-beforePower
assert(health==(baseline and 160 or 0) and prediction==(baseline and 160 or 0) and power==(baseline and 160 or 120))
assert(calls.auras==beforeAuras+160)
if not baseline then
    row.skinPower={}
    beforePower=calls.power
    paint(row,"UNIT_POWER_UPDATE")
    assert(calls.power==beforePower)
    mode=1
    paint(row)
    assert(not row.incomingBar.shown)
    mode=3; numbers.amount=27
    paint(row,"UNIT_HEAL_PREDICTION")
    assert(row.incomingBar.shown and row.incomingBar.value==27)
    exists=false
    beforeHealth,beforeAuras=calls.health,calls.auras
    paint(row,"UNIT_HEALTH"); paint(row,"UNIT_AURA")
    assert(calls.health==beforeHealth and calls.auras==beforeAuras)
end
print(string.format("%s: 160 aura/power events -> %d health reads, %d prediction calls, %d power reads, 160 aura updates",
    baseline and "BASELINE (interpolation failure reproduced)" or "PASS (opaque prediction, health and power accepted)",health,prediction,power))
