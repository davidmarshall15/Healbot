local passed=0
local function eq(a,b,label)
    assert(a==b,label..": expected "..tostring(b)..", got "..tostring(a)); passed=passed+1
end
local function read(path)
    local f=assert(io.open(path,"rb")); local s=f:read("*a"):gsub("\r\n","\n"):gsub("^\239\187\191",""); f:close(); return s
end
local source=read("HealBot/HealBot_Action.lua")
local xml=read("HealBot/HealBot_Action.xml")
local prefix="ctrl-"
local bindingType=0
local globalKeyDown=true
local actions,globalActions=0,0
local lastType,lastUnit,lastSpell
local methods={}
function methods.GetAttribute(self,a,b,c)
    if not b then return self.attrs[a] end
    for _,key in ipairs({a..b..c,"*"..b..c,a..b.."*","*"..b.."*",b}) do
        if self.attrs[key]~=nil then return self.attrs[key] end
    end
end
local env=setmetatable({
    HEALBOT_GAME_VERSION=1, HEALBOT_CLIENT_VERSION=12,
    HealBot_Globals={},HealBot_Config_Spells={ButtonCastMethod=2},HealBot_Action_luVars={},
    GetFrameMetatable=function() return {__index=methods} end,
    IsShiftKeyDown=function() return prefix:find("shift",1,true)~=nil end,
    IsControlKeyDown=function() return prefix:find("ctrl",1,true)~=nil end,
    IsAltKeyDown=function() return prefix:find("alt",1,true)~=nil end,
    GetCVarBool=function(name) return name=="ActionButtonUseKeyDown" and globalKeyDown end,
    MakeModifiers=function() return prefix end,
    Enum={ClickBindingType={None=0,Interaction=1,Spell=2,Macro=3,PetAction=4}},
    UnitCanAttack=function() return false end,UnitCanAssist=function() return true end,
    UnitExists=function() return true end,SpellIsTargeting=function() return false end,
    GetMacroIndexByName=function() return 0 end,strlower=string.lower,
    HealBot_Spells_KnownByName=function(s) return s=="Heal" end,
    HealBot_Action_UpdateAttribsMinReset=function() end,
}, {__index=_G})
for key in source:gmatch("HEALBOT_[A-Z_]+") do if env[key]==nil then env[key]=key end end
env.HEALBOT_DISABLED_TARGET="Target"
env.C_ClickBindings={GetBindingType=function() return bindingType end,
    GetEffectiveInteractionButton=function(b) return b end,
    ExecuteBinding=function() globalActions=globalActions+1 end}
-- Unit resolution is independent of the click-binding gate under test.
env.SecureButton_GetModifiedUnit=function(b) return b.attrs.unit end
env.OnActionButtonClick=function(b,input,down)
    local converted,unit,kind=env.GetConvertedButtonUnitAndActionType(b,input,down and 1 or 2)
    if converted and kind then
        actions=actions+1; lastType=kind; lastUnit=unit
        lastSpell=env.SecureButton_GetModifiedAttribute(b,"spell",converted)
    end
end
env.OnActionButtonPressAndHoldRelease=function() error("unexpected hold release") end
setfenv(assert(loadstring(read("tests/fixtures/forever_secure_clicks.lua"))),env)()
for _,name in ipairs({"HealBot_Action_DoSetButtonAttrib","HealBot_Action_ButtonRegisterForClicks"}) do
    setfenv(assert(loadstring(assert(source:match("(function "..name.."%b().-\nend)")))) ,env)()
end
local function button()
    return {attrs={unit="party2"},GetAttribute=methods.GetAttribute,
        SetAttribute=function(self,k,v) self.attrs[k]=v end,
        EnableMouse=function(self,v) self.mouse=v end,
        RegisterForClicks=function(self,v) self.clicks=v end}
end
local function bind(b,n,mod,name)
    env.HealBot_Action_DoSetButtonAttrib(b,"Enabled",n,"party2",mod,"helpbutton",name,false,false,false,false,"heal")
end
-- Reproduce the original failure using Blizzard's unchanged handler, not a
-- synthetic assertion that merely checks ctrl-type-target1 exists.
local old=button(); bind(old,1,"ctrl-","Target")
env.SecureUnitButton_OnClick(old,"LeftButton",false)
eq(actions,0,"old handler discards Ctrl Target when Blizzard has no interaction binding")
prefix=""; bindingType=1; bind(old,1,"","Target")
env.SecureUnitButton_OnClick(old,"LeftButton",false)
eq(actions,1,"old handler accepts ordinary Target interaction")

for _,template in ipairs({"HealBotButtonSecureTemplate","HealingButtonTemplateEmerg"}) do
    local inherits=assert(xml:match('<Button name="'..template..'"[^>]-inherits="([^"]+)"'))
    local handler=inherits:find("SecureActionButtonTemplate",1,true) and env.SecureActionButton_OnClick or env.SecureUnitButton_OnClick
    for _,mod in ipairs({"ctrl-","","shift-","alt-","alt-ctrl-shift-"}) do
        for n,input in ipairs({"LeftButton","RightButton","MiddleButton"}) do
            for _,method in ipairs({1,2}) do
                local b=button()
                bind(b,n,"","Heal"); bind(b,n,mod,"Target")
                prefix=mod; bindingType=0
                env.HealBot_Config_Spells.ButtonCastMethod=method
                -- Set the global CVar opposite to the configured HealBot edge.
                globalKeyDown=method~=1
                env.HealBot_Action_ButtonRegisterForClicks(b)
                local before=actions
                handler(b,input,method==1)
                eq(actions,before+1,template.." "..mod..input.." executes once on chosen edge")
                eq(lastType,"target","secure target action")
                eq(lastUnit,"party2","clicked unit retained")
                eq(b.clicks,method==1 and "AnyDown" or "AnyUp","click registration agrees with handler")
                -- Even if delivered, the other edge must not execute twice.
                handler(b,input,method~=1)
                eq(actions,before+1,"opposite edge does not duplicate action")
                if mod~="" then
                    prefix=""; handler(b,input,method==1)
                    eq(lastType,"spell","ordinary healing binding remains separate")
                    eq(lastSpell,"Heal","ordinary spell retained")
                end
                -- Blizzard click-cast bindings must not take over HealBot's.
                prefix=mod; bindingType=2
                handler(b,input,method==1)
                eq(globalActions,0,"Blizzard spell binding does not override HealBot")
                eq(lastType,"target","Target retained with global click binding")
            end
        end
    end
end
local disabled=button(); env.HealBot_Action_luVars.TestBarsOn=true
env.HealBot_Action_ButtonRegisterForClicks(disabled)
eq(disabled.mouse,false,"test bars remain unclickable")
eq(disabled.regClicks,false,"test bars are not registered")
print("PASS: "..passed.." modified Target dispatch assertions (Blizzard handler fixture, mock APIs)")
