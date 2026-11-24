-- Exercise the per-skin adaptive colour reset buttons.
local passed=0
local function eq(actual,expected,label)
    assert(actual==expected,label..": expected "..tostring(expected)..", got "..tostring(actual))
    passed=passed+1
end
local function read(path)
    local f=assert(io.open(path,"rb"));local s=f:read("*a"):gsub("\r\n","\n");f:close();return s
end
local env
env=setmetatable({
    HealBot_Timers_Set=function(when,name) env.timer=when.." "..name end,
    HealBot_Util_EmptyTable=function(t,key) if next(t[key]) == nil then t[key]=nil end end,
}, {__index=_G})
local function extract(path,name)
    setfenv(assert(loadstring(assert(read(path):match("(function "..name.."%b().-\nend)"),name))),env)()
end
extract("HealBot/HealBot_Vars.lua","hbv_Skins_NilColVarSkin")
extract("HealBot/HealBot_Options.lua","HealBot_Options_AdaptiveResetColour_OnClick")

env.Healbot_Config_Skins={Current_Skin="Mine",
    AdaptiveCol={Mine={Threat={R=0.2,G=0.3,B=0.4},Aggro={R=0.5}},Other={Threat={R=0.6,G=0.7,B=0.8}}}}
local ok,err=pcall(env.HealBot_Options_AdaptiveResetColour_OnClick,"Threat",false)
eq(ok,true,"reset button runs without error: "..tostring(err))
eq(env.Healbot_Config_Skins.AdaptiveCol.Mine.Threat,nil,"current skin colour reset")
eq(env.Healbot_Config_Skins.AdaptiveCol.Mine.Aggro.R,0.5,"other colours in the skin kept")
eq(env.Healbot_Config_Skins.AdaptiveCol.Other.Threat.G,0.7,"other skins kept")
eq(env.timer,"LAST AdaptiveColourUpdate","colour update scheduled")

print("Adaptive colour reset tests passed: "..passed)
