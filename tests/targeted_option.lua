-- Exercise the per-frame "Targeted" aggro option when an enemy targets a friendly unit.
local passed=0
local function eq(actual,expected,label)
    assert(actual==expected,label..": expected "..tostring(expected)..", got "..tostring(actual))
    passed=passed+1
end
local function read(path)
    local f=assert(io.open(path,"rb"));local s=f:read("*a"):gsub("\r\n","\n");f:close();return s
end
local marked=0
local env
env=setmetatable({
    hbv_Default_FontName=function() return "Font" end,
    hbv_Default_TextureName=function() return "Texture" end,
    HealBot_Util_EmptyTable=function() end,
    HealBot_Aggro_PlayerTargeted=function() marked=marked+1 end,
    HealBot_Aggro_PlayerTargetedUpdate=function() marked=marked+1 end,
    HealBot_Aggro_PlayerNotTargeted=function() end,
    HealBot_Panel_AllButton=function() return {special={},frame=2,unit="player",aggro={status=1}} end,
    HealBot_Panel_AllUnitButtonCheck=function() return false end,
    HealBot_UnitClassification=function() return "Boss" end,
    UnitExists=function() return true end,
    HealBot_luVars={},
}, {__index=function(_,k) if type(k)=="string" and k:match("^HEALBOT_") then return "x" end return _G[k] end})
local vars=read("HealBot/HealBot_Vars.lua")
local from=assert(vars:find("local hbSkinFrameDefaults=",1,true))
local to=assert(vars:find("function hbv_Skins_FrameHasDefault",from,true))
setfenv(assert(loadstring((vars:sub(from,to-1):gsub("^local ","")))),env)()
local function extract(source,name)
    setfenv(assert(loadstring(assert(source:match("(function "..name.."%b().-\nend)"),name))),env)()
end
for _,name in ipairs({"hbv_Skins_GetFrameBoolean","hbv_Skins_GetFrameVarSkin","hbv_Skins_GetFrameVar",
                      "hbv_Skins_SetFrameVarSkin","hbv_Skins_SetFrameVar","hbv_Skins_NilFrameVarSkin"}) do
    extract(vars,name)
end
extract(read("HealBot/HealBot.lua"),"HealBot_UnitEnemyTargetUpdate")

local function run(setup)
    env.Healbot_Config_Skins={Current_Skin="Mine",BarAggro={Mine={}}}
    env.HealBot_MobTarget={mob1="player"}
    env.HealBot_MobGUID={guid={}}
    if setup then setup() end
    marked=0
    env.HealBot_UnitEnemyTargetUpdate("mob1","guid")
    return marked
end

eq(run(),1,"targeted unit is marked with the default setting")
eq(run(function() env.hbv_Skins_SetFrameVar(true,"BarAggro","TARGETED",2) end),1,"targeted unit is marked when ticked")
eq(run(function() env.hbv_Skins_SetFrameVar(false,"BarAggro","TARGETED",2) end),0,"targeted unit is not marked when unticked")
eq(run(function() env.hbv_Skins_SetFrameVar(false,"BarAggro","TARGETED",1) end),1,"another frame's unticked setting is ignored")

print("Targeted option tests passed: "..passed)
