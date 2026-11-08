local passed=0
local function eq(a,b,label) assert(a==b,label);passed=passed+1 end
local sourceFile=assert(io.open("HealBot/HealBot_Action.lua","rb"))
local source=sourceFile:read("*a"):gsub("\r\n","\n");sourceFile:close()
local env=setmetatable({
    HEALBOT_GAME_VERSION=1,HEALBOT_DISABLED_TARGET="Target",strlower=string.lower,
    GetMacroIndexByName=function() return 0 end,HealBot_Data={UILOCK=false},
    HealBot_Globals={SmartCast=true},HealBot_Spell_Names={Buff=1},
    HealBot_Spells_KnownByName=function() return true end,
    HealBot_Action_SmartCast=function() return "Buff" end,
    UnitExists=function() return true end,UnitIsEnemy=function() return false end,
    IsModifierKeyDown=function() return false end,HealBot_setLuVars=function() end,
}, {__index=_G})
for _,name in ipairs({"HealBot_Action_DoSetButtonAttrib","HealBot_Action_UseSmartCast",
    "HealBot_Action_ButtonPreClick","HealBot_Action_PreClick","HealBot_EmergAction_PreClick"}) do
    setfenv(assert(loadstring(assert(source:match("(function "..name.."%b().-\nend)")))),env)()
end
local function button()
    local b={id=1,unit="party1",attrs={unit="party1"}}
    function b:SetAttribute(k,v) self.attrs[k]=v end
    function b:GetAttribute(k) return self.attrs[k] end
    return b
end
local b,emerg=button(),button()
env.HealBot_Buttons={[1]=b}
local function target(btn)
    env.HealBot_Action_DoSetButtonAttrib(btn,"Enabled",1,"party1","","helpbutton","Target",false,false,false,false,"heal")
end
target(b)
env.HealBot_Action_PreClick(b,"LeftButton")
eq(b.attrs.helpbutton1,"target1","Target survives SmartCast")
eq(b.attrs["type-target1"],"target","Target action retained")
eq(b.attrs.unit,"party1","Target unit retained")
target(emerg)
env.HealBot_EmergAction_PreClick(emerg,"LeftButton")
eq(emerg.attrs.helpbutton1,"target1","emergency Target survives SmartCast")
-- A normal healing action still gets the intended SmartCast buff.
b.attrs.helpbutton1="heal1";b.attrs["type-heal1"]="spell";b.attrs["spell-heal1"]="Heal"
env.HealBot_Action_PreClick(b,"LeftButton")
eq(b.attrs["spell-heal1"],"Buff","SmartCast still works for spells")
b.attrs["spell-heal1"]="Heal";env.HealBot_Data.UILOCK=true
env.HealBot_Action_PreClick(b,"LeftButton")
eq(b.attrs["spell-heal1"],"Heal","combat skips SmartCast")
env.HealBot_Data.UILOCK=false;env.HealBot_Globals.SmartCast=false
env.HealBot_Action_PreClick(b,"LeftButton")
eq(b.attrs["spell-heal1"],"Heal","SmartCast setting respected")
env.HealBot_Globals.SmartCast=true;env.IsModifierKeyDown=function() return true end
env.HealBot_Action_PreClick(b,"LeftButton")
eq(b.attrs["spell-heal1"],"Heal","modified click unchanged")
env.IsModifierKeyDown=function() return false end
env.HealBot_Action_PreClick(b,"RightButton")
eq(b.attrs["spell-heal1"],"Heal","right click unchanged")
print("PASS: "..passed.." Target/SmartCast assertions (mock buttons)")
