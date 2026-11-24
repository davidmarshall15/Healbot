-- Exercise the real UI callbacks and the real /hbca setter together.
local passed=0
local function eq(a,b,label)
    assert(a==b,label..": expected "..tostring(b)..", got "..tostring(a)); passed=passed+1
end
local function read(path)
    local f=assert(io.open(path,"rb"));local s=f:read("*a");f:close();return s
end
local env,combat,menu={},false,{}
local creationCount=0
local function frame(kind,name,parent)
    creationCount=creationCount+1
    local f={kind=kind,name=name,parent=parent,shown=true,enabled=true,scripts={}}
    function f:SetText(v) self.text=v end
    function f:GetText() return self.text end
    function f:GetName() return self.name end
    function f:SetWidth(v) self.width=v end
    function f:SetJustifyH() end
    function f:SetSize(w,h) self.width=w;self.height=h end
    function f:SetAutoFocus() end
    function f:SetNumeric() end
    function f:SetMaxLetters() end
    function f:ClearFocus() end
    function f:SetPoint(...) self.point={...} end
    function f:SetScript(k,v) self.scripts[k]=v end
    function f:RegisterEvent() end
    function f:IsShown() return self.shown end
    function f:Show() self.shown=true end
    function f:Hide() self.shown=false end
    function f:SetChecked(v) self.checked=v end
    function f:GetChecked() return self.checked end
    function f:Enable() self.enabled=true end
    function f:Disable() self.enabled=false end
    function f:SetEnabled(v) self.enabled=v end
    function f:SetAlpha(v) self.alpha=v end
    function f:SetObeyStepOnDrag() end
    function f:SetMinMaxValues(low,high) self.low=low;self.high=high end
    function f:SetValue(v)
        self.value=v
        if self.scripts.OnValueChanged then self.scripts.OnValueChanged(self,v) end
    end
    function f:CreateFontString() return frame("FontString",nil,self) end
    if name then env[name]=f end
    if kind=="CheckButton" then f.Text=frame("FontString",name.."Text",f) end
    return f
end
local name="HealBot_Options_SkinsFrameIconsNative"
env._G=env
setmetatable(env,{__index=_G})
env.HEALBOT_MIDNIGHT=true;env.HEALBOT_FOREVER=true
env.HealBot_Globals={};env.SlashCmdList={}
env.CreateFrame=frame
env.InCombatLockdown=function() return combat end
env.UnitClass=function() return "Priest","PRIEST" end
env.print=function() end
env.hooksecurefunc=function() end
env.HealBot_Options_SetText=function(f,text) f.Text= f.Text or {}; f.Text.text=text end
env.HealBot_Options_val_OnLoad=function(f,text,low,high) f:SetMinMaxValues(low,high) end
env.UIDropDownMenu_SetWidth=function(f,v) f:SetWidth(v) end
env.UIDropDownMenu_SetText=function(f,v) f:SetText(v) end
env.UIDropDownMenu_EnableDropDown=function(f) f:Enable() end
env.UIDropDownMenu_DisableDropDown=function(f) f:Disable() end
env.UIDropDownMenu_CreateInfo=function() return {} end
env.UIDropDownMenu_AddButton=function(info) menu[#menu+1]=info end
local panel=frame("Frame",name)
frame("FontString",name.."bTxt")
for _,path in ipairs({"HealBot/HealBot_Options_NativeAuras.lua","HealBot/HealBot_CombatAuras.lua"}) do
    setfenv(assert(loadstring(read(path))),env)()
end
env.HealBot_Options_SkinsFramesIconsNativeTab()
local function control(key) return env[name..key] end
local function click(key,value)
    local c=control(key);assert(c.enabled,"clicked disabled control: "..key)
    c:SetChecked(value);c.scripts.OnClick(c)
end
local function slider(key,value)
    local c=control(key);assert(c.enabled,"changed disabled slider: "..key);c:SetValue(value)
end
local function selectTimer(index)
    menu={};control("nums").initialize();menu[index].func()
end
local g=env.HealBot_Globals
eq(control("enabled").checked,true,"enabled default loaded")
eq(control("persist").checked,true,"persistence default loaded")
eq(control("priest").checked,false,"unset priest filter shows unchecked like its off behavior")
eq(control("nums").text,"Follow skin","timer migration reflected")
eq(control("size").enabled,false,"manual size disabled while following skin")
eq(g.CombatAurasMaxDur,0,"opening panel does not overwrite duration")
local count=creationCount
env.HealBot_Options_NativeAuras_Refresh()
eq(creationCount,count,"refresh reuses controls")
click("skinSize",false);slider("size",25)
eq(g.CombatAurasSize,25,"UI saves manual icon size")
env.SlashCmdList.HBCOMBATAURAS("size skin")
eq(control("skinSize").checked,true,"slash updates open checkbox")
eq(control("size").enabled,false,"slash updates dependent slider")
slider("hots",2);slider("debuffs",0);slider("maxdur",120)
eq(g.CombatAurasHots,2,"UI saves buff cap")
eq(g.CombatAurasDebuffs,0,"UI accepts zero debuff cap")
eq(g.CombatAurasMaxDur,120,"UI saves finite duration")
control("maxdurValue"):SetText("123")
control("maxdurValue").scripts.OnEnterPressed(control("maxdurValue"))
eq(g.CombatAurasMaxDur,123,"exact duration can be typed")
eq(control("maxdur").value,123,"exact duration synchronizes slider")
control("maxdurValue"):SetText("")
control("maxdurValue").scripts.OnEditFocusLost(control("maxdurValue"))
eq(control("maxdurValue").text,"123","empty input restores saved duration")
selectTimer(2);eq(g.CombatAurasNums,true,"dropdown enables countdowns")
eq(g.CombatAurasNumsFollowSkin,false,"dropdown sets explicit override")
selectTimer(3);eq(g.CombatAurasNums,false,"dropdown disables countdowns")
selectTimer(1);eq(g.CombatAurasNumsFollowSkin,true,"dropdown restores skin mode")
eq(g.CombatAurasNums,nil,"skin mode clears explicit override")
click("persist",false);eq(g.CombatAurasPersistDebuffs,false,"UI disables persistence")
click("priest",false);eq(g.CombatAurasPriestOnly,false,"UI disables priest filter")
eq(control("priest").checked,false,"disabled priest filter shows unchecked")
env.SlashCmdList.HBCOMBATAURAS("priest on")
eq(control("priest").checked,true,"slash updates priest filter checkbox")
env.SlashCmdList.HBCOMBATAURAS("persist on")
eq(control("persist").checked,true,"slash updates persistence checkbox")
env.SlashCmdList.HBCOMBATAURAS("nums off")
eq(control("nums").text,"Always hide","slash updates timer dropdown")
env.SlashCmdList.HBCOMBATAURAS("maxdur 0")
eq(control("maxdur").value,0,"slash updates duration slider")
eq(control("maxdur").Text.text,"Maximum buff duration (seconds): No limit","zero duration explained")
click("enabled",false)
eq(control("enabled").enabled,true,"master switch remains usable")
eq(control("hots").enabled,false,"dependent controls disabled with master switch")
eq(control("nums").enabled,false,"dropdown disabled with master switch")
click("enabled",true)
eq(control("hots").enabled,true,"dependent controls restored")
combat=true;panel.scripts.OnEvent()
count=creationCount
slider("maxdur",90);selectTimer(2)
eq(creationCount,count,"UI changes create no frames during combat")
eq(g.CombatAurasMaxDur,90,"combat changes saved")
combat=false;panel.scripts.OnEvent()
env.HealBot_Options_NativeAuras_SetLanguage("itIT")
eq(env[name.."bTxt"].text,"Aure native","Italian tab title")
eq(control("nums").text,"Mostra sempre","Italian dropdown")
env.HealBot_Options_NativeAuras_SetLanguage("deDE")
eq(control("nums").text,"Immer anzeigen","German dropdown")
env.HealBot_Options_NativeAuras_SetLanguage("frFR")
eq(control("nums").text,"Always show","untranslated language falls back to English")
panel:Hide();env.SlashCmdList.HBCOMBATAURAS("hots 5")
eq(control("hots").value,2,"hidden UI does not refresh")
panel:Show();env.HealBot_Options_SkinsFramesIconsNativeTab()
eq(control("hots").value,5,"reopening reads saved settings")
eq(env.HealBot_CombatAuras_SetOption("maxdur","bad"),false,"invalid numeric value rejected")
eq(g.CombatAurasMaxDur,90,"invalid value preserves setting")
eq(env.HealBot_CombatAuras_SetOption("nums","bad"),false,"invalid timer mode rejected")
env.HealBot_CombatAuras_SetOption("hots",99)
eq(g.CombatAurasHots,8,"icon cap clamped")
env.HealBot_CombatAuras_SetOption("size",2)
eq(g.CombatAurasSize,8,"size clamped")
env.UnitClass=function() return "Shaman","SHAMAN" end
env.HealBot_Options_NativeAuras_Refresh()
eq(control("priest").enabled,false,"priest setting disabled for other classes")
env.HEALBOT_MIDNIGHT=false;env.HealBot_Options_NativeAuras_Refresh()
eq(control("enabled").enabled,false,"unsupported client cannot enable native icons")
eq(control("hots").enabled,false,"unsupported client controls disabled")
-- Execute the actual XML navigation handler and the existing panel router.
local optionsSource=read("HealBot/HealBot_Options.lua"):gsub("\r\n","\n")
local router=assert(optionsSource:match("(function HealBot_Options_ShowIconPanel%b().-\nend)"))
env.hb_lVars={CurrentSkinsIconsPanel="BuffPanel",CurrentSkinsIconsPanelButton="BuffButton"}
env.HealBot_Options_SubTabs={SkinsFramesIconsBuffs="SkinsFramesIconsBuffsGeneral"}
local selectedTab
env.HealBot_Options_UpdateTab=function(_,_,_,_,tab) selectedTab=tab end
env.HealBot_Options_ObjectsShowHide=function(key,show) if show then env[key]:Show() else env[key]:Hide() end end
env.HealBot_Options_InnerContent_Colour=function() end
for _,key in ipairs({"BuffPanel","BuffButton","BuffButtonTxt",name.."b","HealBot_Options_FramesSelFrame","HealBot_Options_ApplyTab2Frames"}) do frame("Frame",key) end
setfenv(assert(loadstring(router)),env)()
local xml=read("HealBot/HealBot_Options.xml")
local tabXML=assert(xml:match('<StatusBar name="HealBot_Options_SkinsFrameIconsNativeb">(.-)</StatusBar>'))
local clickScript=assert(tabXML:match("<OnMouseDown>(.-)</OnMouseDown>"))
setfenv(assert(loadstring(clickScript)),env)()
eq(selectedTab,"SkinsFramesIconsNative","XML click selects native settings route")
eq(env.HealBot_Options_FramesSelFrame.shown,false,"global tab hides frame selector")
eq(env.HealBot_Options_ApplyTab2Frames.shown,false,"global tab hides per-frame copy")
eq(env.BuffPanel.shown,false,"previous tab hidden")
eq(panel.shown,true,"native panel shown")
env.HealBot_Options_ShowIconPanel("BuffPanel","BuffButton","SkinsFramesIconsBuffs",true)
eq(selectedTab,"SkinsFramesIconsBuffsGeneral","existing parent tab still routes correctly")
eq(panel.shown,false,"native panel hides when leaving")
eq(env.HealBot_Options_FramesSelFrame.shown,true,"frame selector restored")
eq(env.HealBot_Options_ApplyTab2Frames.shown,true,"per-frame copy restored")
print("PASS: "..passed.." native aura options assertions (real callbacks, mock widgets)")
