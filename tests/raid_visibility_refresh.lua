-- Count actual native visibility visits, including the secure hook from the legacy refresh.
local function read(path)
    local file=assert(io.open(path,"rb"))
    local source=file:read("*a"):gsub("\r\n","\n")
    file:close()
    return source
end
local fixture=assert(read("tests/native_buff_casters.lua"):match("^(.-)\nlocal function admits%("))
local d=assert(loadstring(fixture.."\nreturn fixture"))()("MAGE",4)
local api=d.env
local aura=read("HealBot/Healbot_Aura.lua")
local refresh=assert(aura:match("(function HealBot_Aura_RefreshDebuffIconVisibility%(.-)\nlocal debuffWarningSlot"))
setfenv(assert(loadstring(refresh)),api)()
api.HealBot_Aura_GetDebuffIconPreference=function() return nil end
local checks,visits=0,0
api.HealBot_Timers_Set=function(category,name)
    assert(category=="AURA" and name=="CheckDebuffs")
    checks=checks+1
end
local refreshLegacy=api.HealBot_Aura_RefreshDebuffIconVisibility
api.HealBot_Aura_RefreshDebuffIconVisibility=function(...)
    refreshLegacy(...)
    d.hook("HealBot_Aura_RefreshDebuffIconVisibility",...)
end
for i=1,40 do d.button("raid"..i) end
api.HealBot_Forever_VisitAuraPerfScopes(function(name,fn)
    if name~="Aura.SetButtonShown" then return fn end
    return function(...) visits=visits+1; return fn(...) end
end)
local function once(label,fn,...)
    checks,visits=0,0
    fn(...)
    assert(checks==1 and visits==40,label..": legacy checks="..checks..", native bar visits="..visits)
end
once("enter combat",d.combat,true)
once("leave combat",d.combat,false)
once("change a preference",api.HealBot_Aura_SetDebuffIconPreference,123,true,false)
once("direct refresh",api.HealBot_Aura_RefreshDebuffIconVisibility)
d.globals.CombatAurasOn=false
once("enter with native monitoring disabled",d.combat,true)
print("PASS: combat transitions, settings and direct debuff refresh each queue one legacy check and visit all 40 raid buttons once")
