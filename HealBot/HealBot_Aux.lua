local LSM = HealBot_Libs_LSM()
local HealBot_Aux_Buttons={}
local HealBot_AuxStatic_Buttons={}
local HealBot_AuxFluid_Buttons={}
local HealBot_AuxTimed_Buttons={}
local HealBot_AuxFluid_ButtonsAlpha={}
local aBarActive,ufaBarActive,aBarSetValue,aBarGetValue=false,false,0,0
local HealBot_Aux_luVars={}

HealBot_Aux_luVars["auxAlpha"]=0.1
HealBot_Aux_luVars["AUXOMIN"]=0.1
HealBot_Aux_luVars["AUXOMAX"]=0.95
HealBot_Aux_luVars["AuxFluidBarAlphaUpdate"]=0.02
HealBot_Aux_luVars["AuxFluidBarAlphaFreq"]=0.088
HealBot_Aux_luVars["AuxFluidBarOpacityUpdate"]=0.02
HealBot_Aux_luVars["AuxFluidBarOpacityFreq"]=0.088
HealBot_Aux_luVars["AuxFluidBarFreq"]=0.088
HealBot_Aux_luVars["FluidBarSmoothAdj"]=5
HealBot_Aux_luVars["TestBarsOn"]=false
HealBot_Aux_luVars["WaitOnFullClear"]=false

local hbCustomRoleCols={}
function HealBot_Aux_SetCustomRoleCols()
      --HealBot_setCall("HealBot_Aux_SetCustomRoleCols")
    if HealBot_Globals.OverrideColours["USEROLE"]==1 then
        hbCustomRoleCols["TANK"]=HealBot_Options_copyTable(Healbot_Config_Skins.CustomCols[Healbot_Config_Skins.Current_Skin]["TANK"])
        hbCustomRoleCols["HEALER"]=HealBot_Options_copyTable(Healbot_Config_Skins.CustomCols[Healbot_Config_Skins.Current_Skin]["HEALER"])
        hbCustomRoleCols["DAMAGER"]=HealBot_Options_copyTable(Healbot_Config_Skins.CustomCols[Healbot_Config_Skins.Current_Skin]["DAMAGER"])
    else
        hbCustomRoleCols["TANK"]=HealBot_Options_copyTable(HealBot_Globals.OverrideColours["TANK"])
        hbCustomRoleCols["HEALER"]=HealBot_Options_copyTable(HealBot_Globals.OverrideColours["HEALER"])
        hbCustomRoleCols["DAMAGER"]=HealBot_Options_copyTable(HealBot_Globals.OverrideColours["DAMAGER"])
    end
end

if HEALBOT_GAME_VERSION>9 then
    HealBot_Aux_luVars["AbsorbMax"]=12000
    HealBot_Aux_luVars["InHealMax"]=12000
    HealBot_Aux_luVars["HealAbsorbsMax"]=12000
else
    HealBot_Aux_luVars["AbsorbMax"]=3000
    HealBot_Aux_luVars["InHealMax"]=3000
    HealBot_Aux_luVars["HealAbsorbsMax"]=3000
end

function HealBot_Aux_setInHealAbsorbMax()
      --HealBot_setCall("HealBot_Aux_setInHealAbsorbMax")
    local maxHlth=UnitHealthMax("player")
    if not HealBot_Globals.AbsorbDiv then HealBot_Globals.AbsorbDiv=12 end
    if not HealBot_Globals.InHealDiv then HealBot_Globals.InHealDiv=12 end
    if maxHlth and maxHlth>1 then
        HealBot_Aux_luVars["AbsorbMax"]=ceil((maxHlth/HealBot_Globals.AbsorbDiv)/1000)
        HealBot_Aux_luVars["InHealMax"]=ceil((maxHlth/HealBot_Globals.InHealDiv)/1000)
        HealBot_Aux_luVars["HealAbsorbsMax"]=ceil((maxHlth/HealBot_Globals.HealAbsorbsDiv)/1000)
        HealBot_Aux_luVars["AbsorbMax"]=HealBot_Aux_luVars["AbsorbMax"]*1000
        HealBot_Aux_luVars["InHealMax"]=HealBot_Aux_luVars["InHealMax"]*1000
        HealBot_Aux_luVars["HealAbsorbsMax"]=HealBot_Aux_luVars["HealAbsorbsMax"]*1000
        
        HealBot_Timers_Set("AUX","UpdateAllAuxInHealsBars")
        HealBot_Timers_Set("AUX","UpdateAllAuxAbsorbBars")
        HealBot_Timers_Set("AUX","UpdateAllAuxTotalHealAbsorbBars")
    else
        HealBot_Timers_Set("LAST", "SetInHealAbsorbMax", 5) -- All recall require a delay
    end
end

function HealBot_Aux_setLuVars(vName, vValue)
    --HealBot_setCall("HealBot_Aux_setLuVars - "..vName)
    HealBot_Aux_luVars[vName]=vValue
end

function HealBot_Aux_retLuVars(vName)
    --HealBot_setCall("HealBot_Aux_retLuVars - "..vName)
    return HealBot_Aux_luVars[vName]
end

local hbAuxTextMaxChars={[1]={[1]=20,[2]=20,[3]=20,[4]=20,[5]=20,[6]=20,[7]=20,[8]=20,[9]=20,},
                         [2]={[1]=20,[2]=20,[3]=20,[4]=20,[5]=20,[6]=20,[7]=20,[8]=20,[9]=20,},
                         [3]={[1]=20,[2]=20,[3]=20,[4]=20,[5]=20,[6]=20,[7]=20,[8]=20,[9]=20,},
                         [4]={[1]=20,[2]=20,[3]=20,[4]=20,[5]=20,[6]=20,[7]=20,[8]=20,[9]=20,},
                         [5]={[1]=20,[2]=20,[3]=20,[4]=20,[5]=20,[6]=20,[7]=20,[8]=20,[9]=20,},
                         [6]={[1]=20,[2]=20,[3]=20,[4]=20,[5]=20,[6]=20,[7]=20,[8]=20,[9]=20,},
                         [7]={[1]=20,[2]=20,[3]=20,[4]=20,[5]=20,[6]=20,[7]=20,[8]=20,[9]=20,},
                         [8]={[1]=20,[2]=20,[3]=20,[4]=20,[5]=20,[6]=20,[7]=20,[8]=20,[9]=20,},
                         [9]={[1]=20,[2]=20,[3]=20,[4]=20,[5]=20,[6]=20,[7]=20,[8]=20,[9]=20,},
                        [10]={[1]=20,[2]=20,[3]=20,[4]=20,[5]=20,[6]=20,[7]=20,[8]=20,[9]=20,},
                        }
function HealBot_Aux_setTextMaxChars(frame, size, id)
      --HealBot_setCall("HealBot_Aux_setTextMaxChars")
    hbAuxTextMaxChars[frame][id]=size
end

local function HealBot_Aux_clearBar(button, id)
      --HealBot_setCall("HealBot_Aux_clearBar", button)
    button.aux[id]["CLEAR"]=false
    button.aux[id]["FLASH"]=false
    button.aux[id]["STATIC"]=false
    button.aux[id]["FLUID"]=-1
    button.aux[id]["TIMED"]=-1
    button.aux[id]["TIMEDH2L"]=-1
    button.aux[id]["TIMEDL2H"]=-1
    button.aux[id]["FLUIDTEXT"]=-1
    button.auxtxt[id]["TEXT"]=false
    button.gref.auxtxt[id]:SetText("")
    if HealBot_Aux_luVars["FluidAlphaInUse"] and button.aux[id]["FLUIDSTATE"]>-1 then
        button.aux[id]["FLUIDSTATE"]=0
        button.aux[id]["ISFLUID"]=true
        HealBot_AuxFluid_ButtonsAlpha[button.id]=button
        if not HealBot_Aux_luVars["AuxFluidBarAlphaInUse"] then HealBot_Aux_UpdateFluidBarsAlpha() end
    else
        button.aux[id]["FLUIDSTATE"]=-1
        button.aux[id]["ISFLUID"]=false
        button.gref.aux[id]:SetStatusBarColor(0,0,0,0)
        button.gref.aux[id]:SetValue(0)
    end
    if button.aux[id]["OUTLINE"] then
        button.gref.auxglow[id]:SetBackdropBorderColor(0,0,0,0)
    end
end

local function HealBot_Aux_clearAllBar(id)
      --HealBot_setCall("HealBot_Aux_clearAllBar")
    for _,xButton in pairs(HealBot_AuxStatic_Buttons) do
        if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][xButton.frame]["USE"]==1 then
            xButton.aux[id]["CLEAR"]=true
        end
    end
    for _,xButton in pairs(HealBot_Aux_Buttons) do
        if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][xButton.frame]["USE"]==1 then
            xButton.aux[id]["CLEAR"]=true
        end
    end
    for _,xButton in pairs(HealBot_AuxFluid_Buttons) do
        if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][xButton.frame]["USE"]==1 then
            xButton.aux[id]["CLEAR"]=true
        end
    end
    for _,xButton in pairs(HealBot_AuxTimed_Buttons) do
        if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][xButton.frame]["USE"]==1 then
            xButton.aux[id]["CLEAR"]=true
        end
    end
    for _,xButton in pairs(HealBot_AuxFluid_ButtonsAlpha) do
        if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][xButton.frame]["USE"]==1 then
            xButton.aux[id]["CLEAR"]=true
        end
    end
    if not HealBot_Aux_luVars["WaitOnFullClear"] then
        HealBot_Aux_luVars["WaitOnFullClear"]=true
        HealBot_Timers_Set("LAST","AuxBarsReset")
    end
end

local vText,sLen="",0
local function HealBot_Aux_VerticalText(text)
      --HealBot_setCall("HealBot_Aux_VerticalText")
    sLen=string.len(text)
    if sLen>1 then
        if sLen>4 then sLen=4 end
        vText=""
        for x=1,sLen do
            vText=vText..string.sub(text,x,x).."\n"
        end
    else
        vText=text
    end
    return vText
end

local function HealBot_Aux_setBar(button, id, value, isFluid, text, endTime, CastIsChan, colSet)
      --HealBot_setCall("HealBot_Aux_setBar", button)
    button.aux[id]["CLEAR"]=false
    if not colSet then
        if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==2 then
            button.aux[id]["R"]=button.text.r
            button.aux[id]["G"]=button.text.g
            button.aux[id]["B"]=button.text.b
        elseif Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==3 then
            button.aux[id]["R"]=hbCustomRoleCols[button.roletxt].r
            button.aux[id]["G"]=hbCustomRoleCols[button.roletxt].g
            button.aux[id]["B"]=hbCustomRoleCols[button.roletxt].b
        elseif Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==4 then
            button.aux[id]["R"]=Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["R"]
            button.aux[id]["G"]=Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["G"]
            button.aux[id]["B"]=Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["B"]
        end
    end
    if isFluid and HealBot_Aux_luVars["FluidInUse"] and not button.mana.init then
        button.aux[id]["FLUID"]=value
        button.aux[id]["FIXED"]=false
        HealBot_AuxFluid_Buttons[button.id]=button
        if not HealBot_Aux_luVars["AuxFluidBarInUse"] then HealBot_Aux_UpdateFluidBars() end
    elseif endTime then
        if CastIsChan then
            button.aux[id]["TIMEDH2L"]=value
            button.aux[id]["TIMEDL2H"]=-1
            button.aux[id]["TIMED"]=endTime-value
            button.gref.aux[id]:SetMinMaxValues(0,button.aux[id]["TIMED"])
            button.gref.aux[id]:SetValue(button.aux[id]["TIMED"])
        else
            button.aux[id]["TIMEDH2L"]=-1
            button.aux[id]["TIMEDL2H"]=value
            button.aux[id]["TIMED"]=endTime-value
            button.gref.aux[id]:SetMinMaxValues(0,endTime-value)
            button.gref.aux[id]:SetValue(0)
        end
        button.aux[id]["FIXED"]=false
        HealBot_AuxTimed_Buttons[button.id]=button
        if not HealBot_Aux_luVars["AuxCastBarInUse"] then HealBot_Aux_UpdateTimedBars() end
    else
        button.aux[id]["FIXED"]=true
        button.gref.aux[id]:SetValue(value)
        button.mana.init=false
    end
    if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["OTYPE"]==2 then
        button.aux[id]["FLASH"]=true
        button.gref.aux[id]:SetStatusBarColor(button.aux[id]["R"], button.aux[id]["G"], button.aux[id]["B"], HealBot_Aux_luVars["auxAlpha"])
        HealBot_Aux_Buttons[button.id]=button
        if not HealBot_Aux_luVars["AuxFlashBarsInUse"] then HealBot_Aux_UpdateVariableBars() end
    else
        button.aux[id]["STATIC"]=true
        HealBot_AuxStatic_Buttons[button.id]=button
        if HealBot_Aux_luVars["FluidAlphaInUse"] then
            if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["OTYPE"]==3 then
                button.aux[id]["FLUIDSTATE"]=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["A"], 1)
            else
                button.aux[id]["FLUIDSTATE"]=button.status.alpha
            end
            button.aux[id]["ISFLUID"]=true
            HealBot_AuxFluid_ButtonsAlpha[button.id]=button
            if not HealBot_Aux_luVars["AuxFluidBarAlphaInUse"] then HealBot_Aux_UpdateFluidBarsAlpha() end
        elseif Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["OTYPE"]==3 then
            button.gref.aux[id]:SetStatusBarColor(button.aux[id]["R"], button.aux[id]["G"], button.aux[id]["B"], HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["A"], 1))
        else
            button.gref.aux[id]:SetStatusBarColor(button.aux[id]["R"], button.aux[id]["G"], button.aux[id]["B"], button.status.alpha)
        end
    end
    if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["OUTLINE"] and button.aux[id]["OUTLINE"] then
        button.gref.auxglow[id]:SetBackdropBorderColor(button.aux[id]["R"],button.aux[id]["G"],button.aux[id]["B"],1)
    end
    if text then
        if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["ANCHOR"]>2 and Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["ANCHOR"]<5 then
            text=HealBot_Aux_VerticalText(text)
        end
        if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLTYPE"]==2 then
            button.auxtxt[id]["R"]=button.text.r
            button.auxtxt[id]["G"]=button.text.g
            button.auxtxt[id]["B"]=button.text.b
        elseif Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLTYPE"]==3 then
            button.auxtxt[id]["R"]=hbCustomRoleCols[button.roletxt].r
            button.auxtxt[id]["G"]=hbCustomRoleCols[button.roletxt].g
            button.auxtxt[id]["B"]=hbCustomRoleCols[button.roletxt].b
        elseif Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLTYPE"]==4 then
            button.auxtxt[id]["R"]=Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLR"]
            button.auxtxt[id]["G"]=Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLG"]
            button.auxtxt[id]["B"]=Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLB"]
        end
        if HealBot_Text_Len(text)>hbAuxTextMaxChars[button.frame][id] then
            text=HealBot_Text_Sub(text,1,hbAuxTextMaxChars[button.frame][id])
        end
        button.gref.auxtxt[id]:SetText(text)
        if isFluid and HealBot_Aux_luVars["FluidAlphaInUse"] then
            if button.status.enabled or HealBot_Aux_luVars["TestBarsOn"] then
                button.aux[id]["FLUIDTEXT"]=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLA"], 1)
            else
                button.aux[id]["FLUIDTEXT"]=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLDA"], 1)
            end
        else
            if button.status.enabled or HealBot_Aux_luVars["TestBarsOn"] then
                button.gref.auxtxt[id]:SetTextColor(button.auxtxt[id]["R"],button.auxtxt[id]["G"],button.auxtxt[id]["B"],HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLA"], 1))
            else
                button.gref.auxtxt[id]:SetTextColor(button.auxtxt[id]["R"],button.auxtxt[id]["G"],button.auxtxt[id]["B"],HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLDA"], 1))
            end
        end
        button.auxtxt[id]["TEXT"]=true
    else
        button.gref.auxtxt[id]:SetText("")
        button.auxtxt[id]["TEXT"]=false
    end
end

local hbStaticOn=false
function HealBot_Aux_UpdBar(button, noFluid)
      --HealBot_setCall("HealBot_DoUpdAuxBar", button)
    hbStaticOn=false
    for x=1,9 do
        if button.aux[x]["STATIC"] then
            hbStaticOn=true
            if not noFluid and HealBot_Aux_luVars["FluidAlphaInUse"] then
                if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["OTYPE"]==3 then
                    button.aux[x]["FLUIDSTATE"]=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["A"], 1)
                else
                    button.aux[x]["FLUIDSTATE"]=button.status.alpha
                end
                HealBot_AuxFluid_ButtonsAlpha[button.id]=button
                if not HealBot_Aux_luVars["AuxFluidBarAlphaInUse"] then HealBot_Aux_UpdateFluidBarsAlpha() end
            elseif Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["OTYPE"]==3 then
                button.gref.aux[x]:SetStatusBarColor(button.aux[x]["R"], button.aux[x]["G"], button.aux[x]["B"], HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["A"], 1))
            else
                button.gref.aux[x]:SetStatusBarColor(button.aux[x]["R"], button.aux[x]["G"], button.aux[x]["B"], button.status.alpha)
            end
        end
        if button.auxtxt[x]["TEXT"] then
            if not noFluid and HealBot_Aux_luVars["FluidAlphaInUse"] then
                if button.status.enabled or HealBot_Aux_luVars["TestBarsOn"] then
                    button.aux[x]["FLUIDTEXT"]=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLA"], 1)
                else
                    button.aux[x]["FLUIDTEXT"]=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLDA"], 1)
                end
            else
                if button.status.enabled or HealBot_Aux_luVars["TestBarsOn"] then
                    button.gref.auxtxt[x]:SetTextColor(button.auxtxt[x]["R"],button.auxtxt[x]["G"],button.auxtxt[x]["B"],HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLA"], 1))
                else
                    button.gref.auxtxt[x]:SetTextColor(button.auxtxt[x]["R"],button.auxtxt[x]["G"],button.auxtxt[x]["B"],HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLDA"], 1))
                end
            end
        end
    end
    if not hbStaticOn and HealBot_AuxStatic_Buttons[button.id] then
        HealBot_AuxStatic_Buttons[button.id]=nil
    end
end

function HealBot_Aux_clearAllBars(button)
      --HealBot_setCall("HealBot_Aux_clearAllBars", button)
    for x=1,9 do
        HealBot_Aux_clearBar(button, x)
    end
    --if button.frame>0 and UnitExists(button.unit) then HealBot_OnEvent_UnitManaUpdate(button) end
end

function HealBot_Aux_clearMarkedBars(button)
      --HealBot_setCall("HealBot_Aux_clearMarkedBars", button)
    for x=1,9 do
        if button.aux[x]["CLEAR"] then
            HealBot_Aux_clearBar(button, x)
        end
    end
end

function HealBot_Aux_clearAllMarkedBars()
      --HealBot_setCall("HealBot_Aux_clearAllMarkedBars")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Aux_clearMarkedBars(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Aux_clearMarkedBars(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Aux_clearMarkedBars(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Aux_clearMarkedBars(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Aux_clearMarkedBars(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Aux_clearMarkedBars(xButton)
    end
    HealBot_Aux_luVars["WaitOnFullClear"]=false
end

function HealBot_Aux_barsReset()
      --HealBot_setCall("HealBot_Aux_barsReset")
    HealBot_Timers_Set("AUX","ClearAllMarkedBars")
end

function HealBot_Aux_doResetBars()
      --HealBot_setCall("HealBot_Aux_doResetBars")
    HealBot_Timers_Set("AUX","SetBars")
    HealBot_Timers_Set("AUX","UpdateAllAuxBars")
    HealBot_Timers_Set("AUX","UpdateAllAuxByType")
    HealBot_Timers_Set("PLAYER","PlayerTargetChanged")
    HealBot_Timers_Set("SKINS","AuxFramesChanged")
    HealBot_Timers_Set("LAST","UpdateAllUnitBars")
    HealBot_Timers_Set("AURA","CheckUnits")
    HealBot_Timers_Set("LAST","AuxBarsReset")
end

function HealBot_Aux_resetBars()
      --HealBot_setCall("HealBot_Aux_resetBars")
    if HealBot_retLuVars("Loaded") then
        if HealBot_Aux_luVars["WaitOnFullClear"] then
            HealBot_Timers_Set("AUX","ResetBars",0.25) -- All recall require a delay
        else
            HealBot_Aux_luVars["WaitOnFullClear"]=true
            HealBot_Options_clearAuxBars()
            HealBot_Timers_Set("AUX","doResetBars")
        end
    else
        HealBot_Timers_Set("AUX","ResetBars",1) -- All recall require a delay
    end
end

function HealBot_Aux_resetAllBars()
      --HealBot_setCall("HealBot_resetAllAuxBar")
    for _,xButton in pairs(HealBot_AuxStatic_Buttons) do
        HealBot_Aux_clearAllBars(xButton)
    end
    for _,xButton in pairs(HealBot_Aux_Buttons) do
        HealBot_Aux_clearAllBars(xButton)
    end
    for _,xButton in pairs(HealBot_AuxFluid_Buttons) do
        HealBot_Aux_clearAllBars(xButton)
    end
    for _,xButton in pairs(HealBot_AuxTimed_Buttons) do
        HealBot_Aux_clearAllBars(xButton)
    end
    for _,xButton in pairs(HealBot_AuxFluid_ButtonsAlpha) do
        HealBot_Aux_clearAllBars(xButton)
    end
end

function HealBot_Aux_resetFrameBar(frame, id)
      --HealBot_setCall("HealBot_Aux_resetFrameBar")
    for _,xButton in pairs(HealBot_AuxStatic_Buttons) do
        if xButton.frame==frame then HealBot_Aux_clearBar(xButton, id) end
    end
    for _,xButton in pairs(HealBot_Aux_Buttons) do
        if xButton.frame==frame then HealBot_Aux_clearBar(xButton, id) end
    end
    for _,xButton in pairs(HealBot_AuxFluid_Buttons) do
        if xButton.frame==frame then HealBot_Aux_clearBar(xButton, id) end
    end
    for _,xButton in pairs(HealBot_AuxTimed_Buttons) do
        if xButton.frame==frame then HealBot_Aux_clearBar(xButton, id) end
    end
    for _,xButton in pairs(HealBot_AuxFluid_ButtonsAlpha) do
        if xButton.frame==frame then HealBot_Aux_clearBar(xButton, id) end
    end
end
local hbFlashOn=false
local function HealBot_Aux_DoUpdateVariableBars(button)
      --HealBot_setCall("HealBot_DoUpdateVariableAuxBars", button)
    hbFlashOn=false
    for x=1,9 do
        if button.aux[x]["FLASH"] then
            button.gref.aux[x]:SetStatusBarColor(button.aux[x]["R"], button.aux[x]["G"], button.aux[x]["B"], HealBot_Aux_luVars["auxAlpha"])
            hbFlashOn=true
        end
    end
    return hbFlashOn
end

function HealBot_Aux_UpdateVariableBars()
      --HealBot_setCall("HealBot_Aux_UpdateVariableBars")
    HealBot_Aux_luVars["AuxFlashBarsInUse"]=false
    for id,xButton in pairs(HealBot_Aux_Buttons) do
        if not HealBot_Aux_DoUpdateVariableBars(xButton) then
            HealBot_Aux_Buttons[id]=nil
        else
            HealBot_Aux_luVars["AuxFlashBarsInUse"]=true
        end
    end
    if HealBot_Aux_luVars["AuxFlashBarsInUse"] then
        if HealBot_Aux_luVars["AuxAlphaUp"] then
            HealBot_Aux_luVars["auxAlpha"]=HealBot_Aux_luVars["auxAlpha"]+HealBot_Aux_luVars["AuxFluidBarOpacityUpdate"]
            if HealBot_Aux_luVars["auxAlpha"]>=HealBot_Aux_luVars["AUXOMAX"] then 
                HealBot_Aux_luVars["AuxAlphaUp"]=false
                HealBot_Aux_luVars["auxAlpha"]=HealBot_Aux_luVars["AUXOMAX"]
            end
        else
            HealBot_Aux_luVars["auxAlpha"]=HealBot_Aux_luVars["auxAlpha"]-HealBot_Aux_luVars["AuxFluidBarOpacityUpdate"]
            if HealBot_Aux_luVars["auxAlpha"]<=HealBot_Aux_luVars["AUXOMIN"] then
                HealBot_Aux_luVars["AuxAlphaUp"]=true
                HealBot_Aux_luVars["auxAlpha"]=HealBot_Aux_luVars["AUXOMIN"]
            end
        end
        C_Timer.After(HealBot_Aux_luVars["AuxFluidBarOpacityFreq"], HealBot_Aux_UpdateVariableBars)
    end
end

--------------------------------

local function HealBot_Aux_UpdateFluidBarsValue(button)
      --HealBot_setCall("HealBot_Aux_UpdateFluidBarsValue", button)
    ufaBarActive=false
    for x=1,9 do
        if button.aux[x]["FLUID"]>-1 then
            aBarGetValue=button.gref.aux[x]:GetValue()
            if aBarGetValue>button.aux[x]["FLUID"] then
                aBarSetValue=aBarGetValue-ceil((aBarGetValue-button.aux[x]["FLUID"])/HealBot_Aux_luVars["FluidBarSmoothAdj"])
                if aBarSetValue<button.aux[x]["FLUID"] then 
                    aBarSetValue=button.aux[x]["FLUID"]
                    button.aux[x]["FLUID"]=-1
                else
                    ufaBarActive=true
                end
                button.gref.aux[x]:SetValue(aBarSetValue)
            elseif aBarGetValue<button.aux[x]["FLUID"] then
                aBarSetValue=aBarGetValue+ceil((button.aux[x]["FLUID"]-aBarGetValue)/HealBot_Aux_luVars["FluidBarSmoothAdj"])
                if aBarSetValue>button.aux[x]["FLUID"] then 
                    aBarSetValue=button.aux[x]["FLUID"]
                    button.aux[x]["FLUID"]=-1
                else
                    ufaBarActive=true
                end
                button.gref.aux[x]:SetValue(aBarSetValue)
            else
                button.aux[x]["FLUID"]=-1
            end
        end
    end
    return ufaBarActive
end

local utaElap=0
local function HealBot_Aux_UpdateTimedBarsValue(button) 
      --HealBot_setCall("HealBot_Aux_UpdateTimedBarsValue", button)
    ufaBarActive=false
    for x=1,9 do
        if button.aux[x]["TIMED"]>-1 then
            if button.aux[x]["TIMEDH2L"]>-1 then
                utaElap=((HealBot_TimeNow*1000)-button.aux[x]["TIMEDH2L"])
                if utaElap<button.aux[x]["TIMED"] then
                    button.gref.aux[x]:SetValue(button.aux[x]["TIMED"]-utaElap)
                    ufaBarActive=true
                end
            else
                utaElap=((HealBot_TimeNow*1000)-button.aux[x]["TIMEDL2H"])
                if utaElap<button.aux[x]["TIMED"] then
                    button.gref.aux[x]:SetValue(utaElap)
                    ufaBarActive=true
                end
            end
        end
    end
    return ufaBarActive
end

local function HealBot_Aux_UpdateFluidBarsAlphaValue(button)
      --HealBot_setCall("HealBot_Aux_UpdateFluidBarsAlphaValue", button)
    ufaBarActive=false
    for x=1,9 do
        if button.aux[x]["FLUIDSTATE"]>-1 then
            _,_,_,aBarGetValue=button.gref.aux[x]:GetStatusBarColor()
            aBarGetValue=HealBot_Comm_round(aBarGetValue, 2)
            if aBarGetValue>button.aux[x]["FLUIDSTATE"] then
                aBarSetValue=aBarGetValue-HealBot_Aux_luVars["AuxFluidBarAlphaUpdate"]
                if aBarSetValue<button.aux[x]["FLUIDSTATE"] then 
                    aBarSetValue=button.aux[x]["FLUIDSTATE"]
                else
                    ufaBarActive=true
                end
            elseif aBarGetValue<button.aux[x]["FLUIDSTATE"] then
                aBarSetValue=aBarGetValue+HealBot_Aux_luVars["AuxFluidBarAlphaUpdate"]
                if aBarSetValue>button.aux[x]["FLUIDSTATE"] then 
                    aBarSetValue=button.aux[x]["FLUIDSTATE"]
                else
                    ufaBarActive=true
                end
            else
                aBarSetValue=aBarGetValue
                button.aux[x]["FLUIDSTATE"]=-1
            end
            button.gref.aux[x]:SetStatusBarColor(button.aux[x]["R"], button.aux[x]["G"], button.aux[x]["B"], aBarSetValue)
        end
        if button.aux[x]["FLUIDTEXT"]>-1 then
            _,_,_,aBarGetValue=button.gref.auxtxt[x]:GetTextColor()
            aBarGetValue=HealBot_Comm_round(aBarGetValue, 2)
            if aBarGetValue>button.aux[x]["FLUIDTEXT"] then
                aBarSetValue=aBarGetValue-HealBot_Aux_luVars["AuxFluidBarAlphaUpdate"]
                if aBarSetValue<button.aux[x]["FLUIDTEXT"] then 
                    aBarSetValue=button.aux[x]["FLUIDTEXT"]
                else
                    ufaBarActive=true
                end
            elseif aBarGetValue<button.aux[x]["FLUIDTEXT"] then
                aBarSetValue=aBarGetValue+HealBot_Aux_luVars["AuxFluidBarAlphaUpdate"]
                if aBarSetValue>button.aux[x]["FLUIDTEXT"] then 
                    aBarSetValue=button.aux[x]["FLUIDTEXT"]
                else
                    ufaBarActive=true
                end
            else
                aBarSetValue=aBarGetValue
                button.aux[x]["FLUIDTEXT"]=-1
            end
            button.gref.auxtxt[x]:SetTextColor(button.auxtxt[x]["R"],button.auxtxt[x]["G"],button.auxtxt[x]["B"], aBarSetValue)
        end
    end
    return ufaBarActive
end

function HealBot_Aux_UpdateFluidBars()
      --HealBot_setCall("HealBot_Aux_UpdateFluidBars")
    HealBot_Aux_luVars["AuxFluidBarInUse"]=false
    for id,xButton in pairs(HealBot_AuxFluid_Buttons) do
        if not HealBot_Aux_UpdateFluidBarsValue(xButton) then
            HealBot_AuxFluid_Buttons[id]=nil
        else
            HealBot_Aux_luVars["AuxFluidBarInUse"]=true
        end
    end
    if HealBot_Aux_luVars["AuxFluidBarInUse"] then
        C_Timer.After(HealBot_Aux_luVars["AuxFluidBarFreq"], function() HealBot_Aux_UpdateFluidBars() end)
    end
end

HealBot_Aux_luVars["UpdateTimedFreq"]=0.025
function HealBot_Aux_AdjUpdateTimedFreq(freq)
      --HealBot_setCall("HealBot_Aux_AdjUpdateTimedFreq")
    HealBot_Aux_luVars["UpdateTimedFreq"]=freq
end

function HealBot_Aux_UpdateTimedBars()
      --HealBot_setCall("HealBot_Aux_UpdateTimedBars")
    HealBot_Aux_luVars["AuxCastBarInUse"]=false
    for id,xButton in pairs(HealBot_AuxTimed_Buttons) do
        if not HealBot_Aux_UpdateTimedBarsValue(xButton) then
            HealBot_AuxTimed_Buttons[id]=nil
        else
            HealBot_Aux_luVars["AuxCastBarInUse"]=true
        end
    end
    if HealBot_Aux_luVars["AuxCastBarInUse"] then
        C_Timer.After(HealBot_Aux_luVars["UpdateTimedFreq"], HealBot_Aux_UpdateTimedBars)
    end
end

function HealBot_Aux_UpdateFluidBarsAlpha()
      --HealBot_setCall("HealBot_Aux_UpdateFluidBarsAlpha")
    HealBot_Aux_luVars["AuxFluidBarAlphaInUse"]=false
    for id,xButton in pairs(HealBot_AuxFluid_ButtonsAlpha) do
        if not HealBot_Aux_UpdateFluidBarsAlphaValue(xButton) then
            HealBot_AuxFluid_ButtonsAlpha[id]=nil
        else
            HealBot_Aux_luVars["AuxFluidBarAlphaInUse"]=true
        end
    end
    if HealBot_Aux_luVars["AuxFluidBarAlphaInUse"] then
        C_Timer.After(HealBot_Aux_luVars["AuxFluidBarAlphaFreq"], HealBot_Aux_UpdateFluidBarsAlpha)
    end
end

-- Power
local hbAuxPowerAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
function HealBot_Aux_clearPowerAssigned(frame,id)
      --HealBot_setCall("HealBot_Aux_clearPowerAssigned")
    if frame and id then
        if hbAuxPowerAssigned[frame] and hbAuxPowerAssigned[frame][id] then
            HealBot_Aux_clearAllBar(id)
            hbAuxPowerAssigned[frame][id]=nil
        end
    else
        for f=1,10 do
            for id in pairs(hbAuxPowerAssigned[f]) do
                HealBot_Aux_clearAllBar(id)
            end
            hbAuxPowerAssigned[f]={};
        end
    end
end

function HealBot_Aux_setPowerAssigned(frame, id)
      --HealBot_setCall("HealBot_Aux_setPowerAssigned")
    hbAuxPowerAssigned[frame][id]=true
end

function HealBot_Aux_setPowerBars(button)
      --HealBot_setCall("HealBot_Aux_setPowerBars", button)
    for id in pairs(hbAuxPowerAssigned[button.frame]) do
        if button.status.current<HealBot_Unit_Status["DEAD"] then
            local noPowerbar=false
            if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["MANAONLY"] then
                if button.mana.type~=0 then
                    noPowerbar=true
                elseif Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["HEALERSMANAONLY"] and button.role~=3 and button.role~=5 then
                    noPowerbar=true
                end
            end
            if button.mana.max==0 or noPowerbar then
                button.aux[id]["R"]=0
                button.aux[id]["G"]=0
                button.aux[id]["B"]=0
                HealBot_Aux_setBar(button, id, 0, true)
            else
                if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==1 then
                    button.aux[id]["R"]=button.mana.r
                    button.aux[id]["G"]=button.mana.g
                    button.aux[id]["B"]=button.mana.b
                end
                if button.mana.change then
                    button.mana.change=false
                    HealBot_Aux_UpdBar(button, true)
                end
                if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["TEXT"] then
                    if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLTYPE"]==1 then
                        button.auxtxt[id]["R"],button.auxtxt[id]["G"],button.auxtxt[id]["B"]=(button.mana.r+0.5),(button.mana.g+0.5),(button.mana.b+0.5)
                    end
                    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTYPE"]==1 then
                        HealBot_Aux_setBar(button, id, button.mana.pctc, true, HealBot_Text_shortHealTxt(button.mana.current, button.frame))
                    elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTYPE"]==2 then
                        HealBot_Aux_setBar(button, id, button.mana.pctc, true, HealBot_Text_shortHealTxt(button.mana.current-button.mana.max, button.frame))
                    else
                        HealBot_Aux_setBar(button, id, button.mana.pctc, true, button.mana.pct.."%")
                    end
                else
                    HealBot_Aux_setBar(button, id, button.mana.pctc, true)
                end
            end
        else
            HealBot_Aux_clearBar(button, id)
        end
    end
end

-- Aggro and Threat

local hbAuxAggroAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
local hbAuxThreatAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
function HealBot_Aux_clearAggroAssigned(frame,id)
      --HealBot_setCall("HealBot_Aux_clearAggroAssigned")
    if frame and id then
        if hbAuxAggroAssigned[frame] and hbAuxAggroAssigned[frame][id] then
            HealBot_Aux_clearAllBar(id)
            hbAuxAggroAssigned[frame][id]=nil
        end
        if hbAuxThreatAssigned[frame] and hbAuxThreatAssigned[frame][id] then
            HealBot_Aux_clearAllBar(id)
            hbAuxThreatAssigned[frame][id]=nil
        end
    else
        for f=1,9 do
            for id in pairs(hbAuxAggroAssigned[f]) do
                HealBot_Aux_clearAllBar(id)
            end
            for id in pairs(hbAuxThreatAssigned[f]) do
                HealBot_Aux_clearAllBar(id)
            end
            hbAuxAggroAssigned[f]={};
            hbAuxThreatAssigned[f]={};
        end
    end
end

function HealBot_Aux_setAggroAssigned(aType, frame, id)
      --HealBot_setCall("HealBot_Aux_setAggroAssigned")
    if aType=="AGGRO" then
        hbAuxAggroAssigned[frame][id]=true
    else
        hbAuxThreatAssigned[frame][id]=true
    end
end

function HealBot_Aux_UpdateThreatBar(button)
      --HealBot_setCall("HealBot_Aux_UpdateThreatBar", button)
    for id in pairs(hbAuxThreatAssigned[button.frame]) do
        if button.status.current<HealBot_Unit_Status["DEAD"] and button.aggro.threatpct>0 then
            if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==1 then
                button.aux[id]["R"]=1
                button.aux[id]["G"]=1
                button.aux[id]["B"]=0.2
            end
            if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["TEXT"] then
                if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLTYPE"]==1 then
                    button.auxtxt[id]["R"],button.auxtxt[id]["G"],button.auxtxt[id]["B"]=1,1,1
                end
                HealBot_Aux_setBar(button, id, button.aggro.threatpct*10, true, HealBot_Text_readNumber(button.aggro.threatvalue).." ("..button.aggro.threatpct.."%)")
            else
                HealBot_Aux_setBar(button, id, button.aggro.threatpct*10, true, false)
            end
        else
            HealBot_Aux_clearBar(button, id)
        end
    end
end

function HealBot_Aux_ClearThreatBar(button)
      --HealBot_setCall("HealBot_Aux_ClearThreatBar", button)
    for id in pairs(hbAuxThreatAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end

function HealBot_Aux_UpdateAggroBar(button)
      --HealBot_setCall("HealBot_Aux_UpdateAggroBar", button)
    for id in pairs(hbAuxAggroAssigned[button.frame]) do
        if button.status.current<HealBot_Unit_Status["DEAD"] then
            if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==1 then
                button.aux[id]["R"]=1
                button.aux[id]["G"]=0
                button.aux[id]["B"]=0
            end
            HealBot_Aux_setBar(button, id, 1000, false)
        else
            HealBot_Aux_clearBar(button, id)
        end
    end
end

function HealBot_Aux_ClearAggroBar(button)
      --HealBot_setCall("HealBot_Aux_ClearAggroBar", button)
    for id in pairs(hbAuxAggroAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end

-- Buff and Debuff
local hbAuxBuffAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
local hbAuxDebuffAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
function HealBot_Aux_clearAuraAssigned(frame,id)
      --HealBot_setCall("HealBot_Aux_clearAuraAssigned")
    if frame and id then
        if hbAuxBuffAssigned[frame] and hbAuxBuffAssigned[frame][id] then
            HealBot_Aux_clearAllBar(id)
            hbAuxBuffAssigned[frame][id]=nil
        end
        if hbAuxDebuffAssigned[frame] and hbAuxDebuffAssigned[frame][id] then
            HealBot_Aux_clearAllBar(id)
            hbAuxDebuffAssigned[frame][id]=nil
        end
    else
        for f=1,9 do
            for id in pairs(hbAuxBuffAssigned[f]) do
                HealBot_Aux_clearAllBar(id)
            end
            for id in pairs(hbAuxDebuffAssigned[f]) do
                HealBot_Aux_clearAllBar(id)
            end
            hbAuxBuffAssigned[f]={};
            hbAuxDebuffAssigned[f]={};
        end
    end
end

function HealBot_Aux_setAuraAssigned(aType, frame, id)
      --HealBot_setCall("HealBot_Aux_setAuraAssigned")
    if aType=="BUFF" then
        hbAuxBuffAssigned[frame][id]=true
    else
        hbAuxDebuffAssigned[frame][id]=true
    end
end

function HealBot_Aux_UpdateAuraBuffBars(button)
      --HealBot_setCall("HealBot_Aux_UpdateAuraBuffBars", button)
    for id in pairs(hbAuxBuffAssigned[button.frame]) do
        if button.status.current<HealBot_Unit_Status["DEAD"] then
            if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==1 then
                button.aux[id]["R"],button.aux[id]["G"],button.aux[id]["B"]=button.aura.buff.r,button.aura.buff.g,button.aura.buff.b
            end
            if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["TEXT"] then
                if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLTYPE"]==1 then
                    button.auxtxt[id]["R"],button.auxtxt[id]["G"],button.auxtxt[id]["B"]=(button.aura.buff.r+0.2),(button.aura.buff.g+0.2),(button.aura.buff.b+0.2)
                end
                HealBot_Aux_setBar(button, id, 1000, false, button.aura.buff.name)
            else
                HealBot_Aux_setBar(button, id, 1000, false, false)
            end
        else
            HealBot_Aux_clearBar(button, id)
        end
    end
end

function HealBot_Aux_ClearAuraBuffBars(button)
      --HealBot_setCall("HealBot_Aux_ClearAuraBuffBars", button)
    for id in pairs(hbAuxBuffAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end

function HealBot_Aux_UpdateAuraDebuffBars(button)
      --HealBot_setCall("HealBot_Aux_UpdateAuraDebuffBars", button)
    for id in pairs(hbAuxDebuffAssigned[button.frame]) do
        if button.status.current<HealBot_Unit_Status["DEAD"] then
            if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==1 then
                button.aux[id]["R"],button.aux[id]["G"],button.aux[id]["B"]=button.aura.debuff.r,button.aura.debuff.g,button.aura.debuff.b
            end
            if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["TEXT"] then
                if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLTYPE"]==1 then
                    button.auxtxt[id]["R"],button.auxtxt[id]["G"],button.auxtxt[id]["B"]=(button.aura.debuff.r+0.2),(button.aura.debuff.g+0.2),(button.aura.debuff.b+0.2)
                end
                HealBot_Aux_setBar(button, id, 1000, false, button.aura.debuff.name)
            else
                HealBot_Aux_setBar(button, id, 1000, false, false)
            end
        else
            HealBot_Aux_clearBar(button, id)
        end
    end
end

function HealBot_Aux_ClearAuraDebuffBars(button)
      --HealBot_setCall("HealBot_Aux_ClearAuraDebuffBars", button)
    for id in pairs(hbAuxDebuffAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end

-- HealIn and Absorbs
local hbAuxAbsorbAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
local hbAuxHealInAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
function HealBot_Aux_clearInHealsAssigned(frame,id)
      --HealBot_setCall("HealBot_Aux_clearInHealsAssigned")
    if frame and id then
        if hbAuxAbsorbAssigned[frame] and hbAuxAbsorbAssigned[frame][id] then
            HealBot_Aux_clearAllBar(id)
            hbAuxAbsorbAssigned[frame][id]=nil
        end
        if hbAuxHealInAssigned[frame] and hbAuxHealInAssigned[frame][id] then
            HealBot_Aux_clearAllBar(id)
            hbAuxHealInAssigned[frame][id]=nil
        end
    else
        for f=1,10 do
            for id in pairs(hbAuxAbsorbAssigned[f]) do
                HealBot_Aux_clearAllBar(id)
            end
            for id in pairs(hbAuxHealInAssigned[f]) do
                HealBot_Aux_clearAllBar(id)
            end
            hbAuxAbsorbAssigned[f]={};
            hbAuxHealInAssigned[f]={};
        end
    end
end

function HealBot_Aux_setInHealsAssigned(aType, frame, id)
      --HealBot_setCall("HealBot_Aux_setInHealsAssigned")
    if aType=="ABSORB" then
        hbAuxAbsorbAssigned[frame][id]=true
    else
        hbAuxHealInAssigned[frame][id]=true
    end
end

local hbAuxHlth10=0
local function HealBot_Aux_SetAuxHlth10(button)
      --HealBot_setCall("HealBot_Aux_SetAuxHlth10", button)
    if button.health.auxabsorbs>0 then
        hbAuxHlth10=floor(1000/(HealBot_Aux_luVars["AbsorbMax"]/button.health.auxabsorbs))
        if hbAuxHlth10>1000 then
            hbAuxHlth10=1000 
        elseif hbAuxHlth10<1 then
            hbAuxHlth10=1
        end
    else
        hbAuxHlth10=0
    end
end

function HealBot_Aux_UpdateAbsorbBar(button)
      --HealBot_setCall("HealBot_Aux_UpdateAbsorbBar", button)
    for id in pairs(hbAuxAbsorbAssigned[button.frame]) do
        if button.status.current<HealBot_Unit_Status["DEAD"] and button.health.auxabsorbs>0 then
            if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==1 then
                button.aux[id]["R"]=button.health.absorbr
                button.aux[id]["G"]=button.health.absorbg
                button.aux[id]["B"]=button.health.absorbb
            end
            HealBot_Aux_SetAuxHlth10(button)
            if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["TEXT"] then
                if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLTYPE"]==1 then
                    button.auxtxt[id]["R"],button.auxtxt[id]["G"],button.auxtxt[id]["B"]=(button.health.absorbr+0.2),(button.health.absorbg+0.2),(button.health.absorbb+0.2)
                end
                HealBot_Aux_setBar(button, id, hbAuxHlth10, true, HealBot_Text_shortHealTxt(button.health.auxabsorbs, button.frame))
            else
                HealBot_Aux_setBar(button, id, hbAuxHlth10, true)
            end
        else
            HealBot_Aux_clearBar(button, id)
        end
    end
end

function HealBot_Aux_ClearAbsorbBar(button)
      --HealBot_setCall("HealBot_Aux_ClearAbsorbBar", button)
    for id in pairs(hbAuxAbsorbAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end

local hbAuxHealIn10=0
local function HealBot_Aux_SetAuxHealIn10(button)
      --HealBot_setCall("HealBot_Aux_SetAuxHealIn10", button)
    if button.health.auxincoming>0 then
        hbAuxHealIn10=floor(1000/(HealBot_Aux_luVars["InHealMax"]/button.health.auxincoming))
        if hbAuxHealIn10>1000 then
            hbAuxHealIn10=1000
        elseif hbAuxHealIn10<1 then
            hbAuxHealIn10=1
        end
    else
        hbAuxHealIn10=0
    end
end

function HealBot_Aux_UpdateHealInBar(button)
      --HealBot_setCall("HealBot_Aux_UpdateHealInBar", button)
    for id in pairs(hbAuxHealInAssigned[button.frame]) do
        if button.status.current<HealBot_Unit_Status["DEAD"] and button.health.auxincoming>0 then
            if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==1 then
                button.aux[id]["R"]=button.health.inhealr
                button.aux[id]["G"]=button.health.inhealg
                button.aux[id]["B"]=button.health.inhealb
            end
            HealBot_Aux_SetAuxHealIn10(button)
            if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["TEXT"] then
                if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLTYPE"]==1 then
                    button.auxtxt[id]["R"],button.auxtxt[id]["G"],button.auxtxt[id]["B"]=(button.health.inhealr+0.2),(button.health.inhealg+0.2),(button.health.inhealb+0.2)
                end
                HealBot_Aux_setBar(button, id, hbAuxHealIn10, true, HealBot_Text_shortHealTxt(button.health.auxincoming, button.frame))
            else
                HealBot_Aux_setBar(button, id, hbAuxHealIn10, true)
            end
        else
            HealBot_Aux_clearBar(button, id)
        end
    end
end

function HealBot_Aux_ClearHealInBar(button)
      --HealBot_setCall("HealBot_Aux_ClearHealInBar", button)
    for id in pairs(hbAuxHealInAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end

-- TotalHealAbsorbs
local hbAuxTotalHeal10=0
local hbAuxTotalHealAbsorbsAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
function HealBot_Aux_clearTotalHealAbsorbsAssigned(frame,id)
      --HealBot_setCall("HealBot_Aux_clearTotalHealAbsorbsAssigned")
    if frame and id then
        if hbAuxTotalHealAbsorbsAssigned[frame] and hbAuxTotalHealAbsorbsAssigned[frame][id] then
            HealBot_Aux_clearAllBar(id)
            hbAuxTotalHealAbsorbsAssigned[frame][id]=nil
        end
    else
        for f=1,9 do
            for id in pairs(hbAuxTotalHealAbsorbsAssigned[f]) do
                HealBot_Aux_clearAllBar(id)
            end
            hbAuxTotalHealAbsorbsAssigned[f]={};
        end
    end
end

function HealBot_Aux_setTotalHealAbsorbsAssigned(frame, id)
      --HealBot_setCall("HealBot_Aux_setTotalHealAbsorbsAssigned")
    hbAuxTotalHealAbsorbsAssigned[frame][id]=true
end

local function HealBot_Aux_SetAuxTotalHeal10(button)
      --HealBot_setCall("HealBot_Aux_SetAuxTotalHeal10", button)
    if button.health.healabsorbs>0 then
        hbAuxTotalHeal10=floor(1000/(HealBot_Aux_luVars["HealAbsorbsMax"]/button.health.healabsorbs))
        if hbAuxTotalHeal10>1000 then
            hbAuxTotalHeal10=1000
        elseif hbAuxTotalHeal10<1 then
            hbAuxTotalHeal10=1
        end
    else
        hbAuxTotalHeal10=0
    end
end

function HealBot_Aux_UpdateTotalHealAbsorbsBar(button)
      --HealBot_setCall("HealBot_Aux_UpdateTotalHealAbsorbsBar", button)
    for id in pairs(hbAuxTotalHealAbsorbsAssigned[button.frame]) do
        if button.status.current<HealBot_Unit_Status["DEAD"] and button.health.healabsorbs>0 then
            if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==1 then
                button.aux[id]["R"]=0.7
                button.aux[id]["G"]=0.2
                button.aux[id]["B"]=0.9
            end
            HealBot_Aux_SetAuxTotalHeal10(button)
            if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["TEXT"] then
                if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLTYPE"]==1 then
                    button.auxtxt[id]["R"],button.auxtxt[id]["G"],button.auxtxt[id]["B"]=1,1,1
                end
                HealBot_Aux_setBar(button, id, hbAuxTotalHeal10, true, HealBot_Text_shortHealTxt(button.health.healabsorbs, button.frame))
            else
                HealBot_Aux_setBar(button, id, hbAuxTotalHeal10, true)
            end
        else
            HealBot_Aux_clearBar(button, id)
        end
    end
end

function HealBot_Aux_ClearTotalHealAbsorbsBar(button)
      --HealBot_setCall("HealBot_Aux_ClearTotalHealAbsorbsBar", button)
    for id in pairs(hbAuxTotalHealAbsorbsAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end


-- OverHeal

local ohValue=0
local hbAuxOverHealAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
function HealBot_Aux_clearOverHealAssigned(frame,id)
      --HealBot_setCall("HealBot_Aux_clearOverHealAssigned")
    if frame and id then
        if hbAuxOverHealAssigned[frame] and hbAuxOverHealAssigned[frame][id] then
            HealBot_Aux_clearAllBar(id)
            hbAuxOverHealAssigned[frame][id]=nil
        end
    else
        for f=1,9 do
            for id in pairs(hbAuxOverHealAssigned[f]) do
                HealBot_Aux_clearAllBar(id)
            end
            hbAuxOverHealAssigned[f]={};
        end
    end
end

function HealBot_Aux_setOverHealAssigned(frame, id)
      --HealBot_setCall("HealBot_Aux_setOverHealAssigned")
    hbAuxOverHealAssigned[frame][id]=true
end

local ohValue=0
local function HealBot_Aux_SetohValue(button)
      --HealBot_setCall("HealBot_Aux_SetohValue", button)
    if button.health.overheal>0 then
        ohValue=floor((button.health.overheal/button.health.max)*10000)
        if ohValue>1000 then
            ohValue=1000
        elseif ohValue<1 then
            ohValue=1
        end
    else
        ohValue=0
    end
end

function HealBot_Aux_UpdateOverHealBar(button)
      --HealBot_setCall("HealBot_Aux_UpdateOverHealBar", button)
    for id in pairs(hbAuxOverHealAssigned[button.frame]) do
        if button.status.current<HealBot_Unit_Status["DEAD"] and button.status.range>-1 and button.health.overheal>0 then
            if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==1 then
                button.aux[id]["R"]=1
                button.aux[id]["G"]=0.2
                button.aux[id]["B"]=0.2
            end
            HealBot_Aux_SetohValue(button)
            if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["TEXT"] then 
                if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLTYPE"]==1 then
                    button.auxtxt[id]["R"],button.auxtxt[id]["G"],button.auxtxt[id]["B"]=1,1,1
                end
                HealBot_Aux_setBar(button, id, ohValue, true, HealBot_Text_shortHealTxt(button.health.overheal, button.frame))
            else
                HealBot_Aux_setBar(button, id, ohValue, true)
            end
        else
            HealBot_Aux_clearBar(button, id)
        end
    end
end

function HealBot_Aux_ClearOverHealBar(button)
      --HealBot_setCall("HealBot_Aux_ClearOverHealBar", button)
    for id in pairs(hbAuxOverHealAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end

-- Highlight
local hbAuxHightlightAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
function HealBot_Aux_clearHightlightAssigned(frame,id)
      --HealBot_setCall("HealBot_Aux_clearHightlightAssigned")
    if frame and id then
        if hbAuxHightlightAssigned[frame] and hbAuxHightlightAssigned[frame][id] then
            HealBot_Aux_clearAllBar(id)
            hbAuxHightlightAssigned[frame][id]=nil
        end
    else
        for f=1,9 do
            for id in pairs(hbAuxHightlightAssigned[f]) do
                HealBot_Aux_clearAllBar(id)
            end
            hbAuxHightlightAssigned[f]={};
        end
    end
end

function HealBot_Aux_setHightlightAssigned(frame, id)
      --HealBot_setCall("HealBot_Aux_setHightlightAssigned")
    hbAuxHightlightAssigned[frame][id]=true
end

function HealBot_Aux_UpdateHighlightBar(button)
      --HealBot_setCall("HealBot_Aux_UpdateHighlightBar", button)
    for id in pairs(hbAuxHightlightAssigned[button.frame]) do
        if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==1 then
            button.aux[id]["R"]=0.4
            button.aux[id]["G"]=1
            button.aux[id]["B"]=1
        end
        HealBot_Aux_setBar(button, id, 1000, false)
    end
end

function HealBot_Aux_ClearHighlightBar(button)
      --HealBot_setCall("HealBot_Aux_ClearHighlightBar", button)
    for id in pairs(hbAuxHightlightAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end

-- Target
local hbAuxTargetAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
function HealBot_Aux_clearTargetAssigned(frame,id)
      --HealBot_setCall("HealBot_Aux_clearTargetAssigned")
    if frame and id then
        if hbAuxTargetAssigned[frame] and hbAuxTargetAssigned[frame][id] then
            HealBot_Aux_clearAllBar(id)
            hbAuxTargetAssigned[frame][id]=nil
            HealBot_setLuVars("AuxTargetInUse", false)
            for x=1,9 do
                if hbAuxTargetAssigned[frame][x] then
                    HealBot_setLuVars("AuxTargetInUse", true)
                    break
                end
            end
        end
    else
        HealBot_setLuVars("AuxTargetInUse", false)
        for f=1,10 do
            for id in pairs(hbAuxTargetAssigned[f]) do
                HealBot_Aux_clearAllBar(id)
            end
            hbAuxTargetAssigned[f]={};
        end
    end
end

function HealBot_Aux_setTargetAssigned(frame, id)
      --HealBot_setCall("HealBot_Aux_setTargetAssigned")
    hbAuxTargetAssigned[frame][id]=true
    HealBot_setLuVars("AuxTargetInUse", true)
end

function HealBot_Aux_UpdateTargetBar(button)
      --HealBot_setCall("HealBot_Aux_UpdateTargetBar", button)
    for id in pairs(hbAuxTargetAssigned[button.frame]) do
        if button.status.current<HealBot_Unit_Status["RESERVED"] then
            if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==1 then
                button.aux[id]["R"]=1
                button.aux[id]["G"]=0.9
                button.aux[id]["B"]=0.2
            end
            HealBot_Aux_setBar(button, id, 1000, false)
        else
            HealBot_Aux_clearBar(button, id)
        end
    end
end

function HealBot_Aux_ClearTargetBar(button)
      --HealBot_setCall("HealBot_Aux_ClearTargetBar", button)
    for id in pairs(hbAuxTargetAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end

-- Cast bar

local hbAuxCastBarAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
function HealBot_Aux_clearCastBarAssigned(frame,id)
      --HealBot_setCall("HealBot_Aux_clearCastBarAssigned")
    if frame and id then
        if hbAuxCastBarAssigned[frame] and hbAuxCastBarAssigned[frame][id] then
            HealBot_Aux_clearAllBar(id)
            hbAuxCastBarAssigned[frame][id]=nil
            HealBot_setAuxAssigns("CastBar", frame, false)
        end
    else
        for f=1,10 do
            for id in pairs(hbAuxCastBarAssigned[f]) do
                HealBot_Aux_clearAllBar(id)
            end
            hbAuxCastBarAssigned[f]={};
            HealBot_setAuxAssigns("CastBar", f, false)
        end
    end
end

function HealBot_Aux_setCastBarAssigned(frame, id)
      --HealBot_setCall("HealBot_Aux_setCastBarAssigned")
    hbAuxCastBarAssigned[frame][id]=true
    HealBot_setAuxAssigns("CastBar", frame, true)
end

function HealBot_Aux_UpdateCastBar(button, text, startTime, endTime, CastIsChan)
      --HealBot_setCall("HealBot_Aux_UpdateCastBar", button)
    for id in pairs(hbAuxCastBarAssigned[button.frame]) do
        if button.status.current<HealBot_Unit_Status["DEAD"] then
            if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==1 then
                button.aux[id]["R"]=0.8
                button.aux[id]["G"]=0.7
                button.aux[id]["B"]=0.1
            end
            if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["TEXT"] then
                if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLTYPE"]==1 then
                    button.auxtxt[id]["R"]=1
                    button.auxtxt[id]["G"]=1
                    button.auxtxt[id]["B"]=1
                end
                HealBot_Aux_setBar(button, id, startTime, false, text, endTime, CastIsChan)
            else
                HealBot_Aux_setBar(button, id, startTime, false, false, endTime, CastIsChan)
            end
        else
            HealBot_Aux_clearBar(button, id)
        end
    end
end

function HealBot_Aux_ClearCastBar(button)
      --HealBot_setCall("HealBot_Aux_ClearCastBar", button)
    button.status.castend=-1
    for id in pairs(hbAuxCastBarAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end

-- Out of Range
local hbAuxOORAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
function HealBot_Aux_clearOORAssigned(frame,id)
      --HealBot_setCall("HealBot_Aux_clearOORAssigned")
    if frame and id then
        if hbAuxOORAssigned[frame] and hbAuxOORAssigned[frame][id] then
            HealBot_Aux_clearAllBar(id)
            hbAuxOORAssigned[frame][id]=nil
            HealBot_setAuxAssigns("OORBar", frame, false)
        end
    else
        for f=1,10 do
            for id in pairs(hbAuxOORAssigned[f]) do
                HealBot_Aux_clearAllBar(id)
            end
            hbAuxOORAssigned[f]={};
            HealBot_setAuxAssigns("OORBar", f, false)
        end
    end
end

function HealBot_Aux_setOORAssigned(frame, id)
      --HealBot_setCall("HealBot_Aux_setOORAssigned")
    hbAuxOORAssigned[frame][id]=true
    HealBot_setAuxAssigns("OORBar", frame, true)
    HealBot_Timers_Set("AUX","ResetRange")
end

function HealBot_Aux_UpdateOORBar(button)
      --HealBot_setCall("HealBot_Aux_UpdateOORBar", button)
    for id in pairs(hbAuxOORAssigned[button.frame]) do
        if button.status.current<HealBot_Unit_Status["DC"] then
            if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==1 then
                button.aux[id]["R"]=0
                button.aux[id]["G"]=0
                button.aux[id]["B"]=0
            end
            HealBot_Aux_setBar(button, id, 1000, false)
        else
            HealBot_Aux_clearBar(button, id)
        end
    end
end

function HealBot_Aux_ClearOORBar(button)
      --HealBot_setCall("HealBot_Aux_ClearOORBar", button)
    for id in pairs(hbAuxOORAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end

-- InRange

local hbAuxInRangeAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
function HealBot_Aux_clearInRangeAssigned(frame,id)
      --HealBot_setCall("HealBot_Aux_clearInRangeAssigned")
    if frame and id then
        if hbAuxInRangeAssigned[frame] and hbAuxInRangeAssigned[frame][id] then
            HealBot_Aux_clearAllBar(id)
            hbAuxInRangeAssigned[frame][id]=nil
            HealBot_setAuxAssigns("InRangeBar", frame, false)
        end
    else
        for f=1,10 do
            for id in pairs(hbAuxInRangeAssigned[f]) do
                HealBot_Aux_clearAllBar(id)
            end
            hbAuxInRangeAssigned[f]={};
            HealBot_setAuxAssigns("InRangeBar", f, false)
        end
    end
end

-- This is now Range 40
function HealBot_Aux_setInRangeAssigned(frame, id)
      --HealBot_setCall("HealBot_Aux_setInRangeAssigned")
    hbAuxInRangeAssigned[frame][id]=true
    HealBot_setAuxAssigns("InRangeBar", frame, true)
    HealBot_Timers_Set("AUX","ResetRange")
end

function HealBot_Aux_UpdateInRangeBar(button)
      --HealBot_setCall("HealBot_Aux_UpdateInRangeBar", button)
    for id in pairs(hbAuxInRangeAssigned[button.frame]) do
        if button.status.current<HealBot_Unit_Status["DC"] then
            if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==1 then
                button.aux[id]["R"]=1
                button.aux[id]["G"]=1
                button.aux[id]["B"]=1
            end
            HealBot_Aux_setBar(button, id, 1000, false)
        else
            HealBot_Aux_clearBar(button, id)
        end
    end
end

function HealBot_Aux_ClearInRangeBar(button)
      --HealBot_setCall("HealBot_Aux_ClearInRangeBar", button)
    for id in pairs(hbAuxInRangeAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end

-- Recent Heals

local hbAuxRecentHealsAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
function HealBot_Aux_clearRecentHealsAssigned(frame,id)
      --HealBot_setCall("HealBot_Aux_clearRecentHealsAssigned")
    if frame and id then
        if hbAuxRecentHealsAssigned[frame] and hbAuxRecentHealsAssigned[frame][id] then
            HealBot_Aux_clearAllBar(id)
            hbAuxRecentHealsAssigned[frame][id]=nil
            HealBot_setAuxAssigns("RecentHeals", frame, false)
        end
    else
        for f=1,10 do
            for id in pairs(hbAuxRecentHealsAssigned[f]) do
                HealBot_Aux_clearAllBar(id)
            end
            hbAuxRecentHealsAssigned[f]={};
            HealBot_setAuxAssigns("RecentHeals", f, false)
        end
    end
end

function HealBot_Aux_setRecentHealsAssigned(frame, id)
      --HealBot_setCall("HealBot_Aux_setRecentHealsAssigned")
    hbAuxRecentHealsAssigned[frame][id]=true
    HealBot_setAuxAssigns("RecentHeals", frame, true)
end

function HealBot_Aux_UpdateRecentHealsBar(button)
      --HealBot_setCall("HealBot_Aux_UpdateRecentHealsBar", button)
    for id in pairs(hbAuxRecentHealsAssigned[button.frame]) do
        if button.status.current<HealBot_Unit_Status["DC"] then
            if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==1 then
                button.aux[id]["R"]=0.1
                button.aux[id]["G"]=1
                button.aux[id]["B"]=0.2
            end
            HealBot_Aux_setBar(button, id, 1000, false)
        else
            HealBot_Aux_clearBar(button, id)
        end
    end
end

function HealBot_Aux_ClearRecentHealsBar(button)
      --HealBot_setCall("HealBot_Aux_ClearRecentHealsBar", button)
    for id in pairs(hbAuxRecentHealsAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end

-- Res

local hbAuxResAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
function HealBot_Aux_clearResAssigned(frame,id)
      --HealBot_setCall("HealBot_Aux_clearResAssigned")
    if frame and id then
        if hbAuxResAssigned[frame] and hbAuxResAssigned[frame][id] then
            HealBot_Aux_clearAllBar(id)
            hbAuxResAssigned[frame][id]=nil
        end
    else
        for f=1,10 do
            for id in pairs(hbAuxResAssigned[f]) do
                HealBot_Aux_clearAllBar(id)
            end
            hbAuxResAssigned[f]={};
        end
    end
end

function HealBot_Aux_setResAssigned(frame, id)
      --HealBot_setCall("HealBot_Aux_setResAssigned")
    hbAuxResAssigned[frame][id]=true
end

function HealBot_Aux_UpdateResBar(button, text, startTime, endTime, CastIsChan)
      --HealBot_setCall("HealBot_Aux_UpdateResBar", button)
    for id in pairs(hbAuxResAssigned[button.frame]) do
        if button.status.isdead then
            if startTime then
                if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==1 then
                    button.aux[id]["R"]=0.1 --Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NRCR"]-0.1
                    button.aux[id]["G"]=0.8 --Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NRCG"]-0.1
                    button.aux[id]["B"]=0.1 --Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NRCB"]-0.1
                end
                if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["TEXT"] then
                    if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLTYPE"]==1 then
                        button.auxtxt[id]["R"]=0.4 --Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NRCR"]+0.1
                        button.auxtxt[id]["G"]=1 --Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NRCG"]+0.1
                        button.auxtxt[id]["B"]=0.4 --Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NRCB"]+0.1
                    end
                    HealBot_Aux_setBar(button, id, startTime, false, text, endTime, CastIsChan)
                else
                    HealBot_Aux_setBar(button, id, startTime, false, false, endTime, CastIsChan)
                end
            else
                if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==1 then
                    button.aux[id]["R"]=0.8 --Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NDCR"]-0.1
                    button.aux[id]["G"]=0.1 --Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NDCG"]-0.1
                    button.aux[id]["B"]=0.1 --Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NDCB"]-0.1
                end
                button.gref.aux[id]:SetMinMaxValues(0,1000)
                if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["TEXT"] then
                    if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLTYPE"]==1 then
                        button.auxtxt[id]["R"]=1 --Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NDCR"]+0.1
                        button.auxtxt[id]["G"]=0.4 --Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NDCG"]+0.1
                        button.auxtxt[id]["B"]=0.4 --Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NDCB"]+0.1
                    end
                    HealBot_Aux_setBar(button, id, 1000, false, text)
                else
                    HealBot_Aux_setBar(button, id, 1000)
                end
            end
        else
            HealBot_Aux_clearBar(button, id)
        end
    end
end

function HealBot_Aux_ClearResBar(button)
      --HealBot_setCall("HealBot_Aux_ClearResBar", button)
    for id in pairs(hbAuxResAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end

-- Res

local hbAuxSummonsAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
function HealBot_Aux_clearSummonsAssigned(frame,id)
      --HealBot_setCall("HealBot_Aux_clearSummonsAssigned")
    if frame and id then
        if hbAuxSummonsAssigned[frame] and hbAuxSummonsAssigned[frame][id] then
            HealBot_Aux_clearAllBar(id)
            hbAuxSummonsAssigned[frame][id]=nil
        end
    else
        for f=1,10 do
            for id in pairs(hbAuxSummonsAssigned[f]) do
                HealBot_Aux_clearAllBar(id)
            end
            hbAuxSummonsAssigned[f]={};
        end
    end
end

function HealBot_Aux_setSummonsAssigned(frame, id)
      --HealBot_setCall("HealBot_Aux_setSummonsAssigned")
    hbAuxSummonsAssigned[frame][id]=true
end

function HealBot_Aux_UpdateSummonsBar(button, text, startTime, endTime, CastIsChan)
      --HealBot_setCall("HealBot_Aux_UpdateSummonsBar", button)
    for id in pairs(hbAuxSummonsAssigned[button.frame]) do
        if button.status.current<HealBot_Unit_Status["DEAD"] then
            if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==1 then
                button.aux[id]["R"]=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NSCR"]-0.1
                button.aux[id]["G"]=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NSCG"]-0.1
                button.aux[id]["B"]=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NSCB"]-0.1
            end
            if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["TEXT"] then
                if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLTYPE"]==1 then
                    button.auxtxt[id]["R"]=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NSCR"]+0.1
                    button.auxtxt[id]["G"]=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NSCG"]+0.1
                    button.auxtxt[id]["B"]=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NSCB"]+0.1
                end
                HealBot_Aux_setBar(button, id, startTime, false, text, endTime, CastIsChan)
            else
                HealBot_Aux_setBar(button, id, startTime, false, false, endTime, CastIsChan)
            end
        else
            HealBot_Aux_clearBar(button, id)
        end
    end
end

function HealBot_Aux_ClearSummonsBar(button)
      --HealBot_setCall("HealBot_Aux_ClearSummonsBar", button)
    for id in pairs(hbAuxSummonsAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end

-- Health Drop

local hbAuxHealthDropAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
function HealBot_Aux_clearHealthDropAssigned(frame,id)
      --HealBot_setCall("HealBot_Aux_clearHealthDropAssigned")
    if frame and id then
        if hbAuxHealthDropAssigned[frame] and hbAuxHealthDropAssigned[frame][id] then
            HealBot_Aux_clearAllBar(id)
            hbAuxHealthDropAssigned[frame][id]=nil
            HealBot_setAuxAssigns("HealthDrop", frame, false)
        end
    else
        for f=1,10 do
            for id in pairs(hbAuxHealthDropAssigned[f]) do
                HealBot_Aux_clearAllBar(id)
            end
            hbAuxHealthDropAssigned[f]={};
            HealBot_setAuxAssigns("HealthDrop", f, false)
        end
    end
end

function HealBot_Aux_setHealthDropAssigned(frame, id)
      --HealBot_setCall("HealBot_Aux_setHealthDropAssigned")
    hbAuxHealthDropAssigned[frame][id]=true
    HealBot_setAuxAssigns("HealthDrop", frame, true)
end

function HealBot_Aux_UpdateHealthDropBar(button)
      --HealBot_setCall("HealBot_Aux_UpdateHealthDropBar", button)
    for id in pairs(hbAuxHealthDropAssigned[button.frame]) do
        if button.status.current<HealBot_Unit_Status["DC"] then
            if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==1 then
                button.aux[id]["R"]=button.health.mixcolr
                button.aux[id]["G"]=button.health.mixcolg
                button.aux[id]["B"]=button.health.mixcolb
            end
            HealBot_Aux_setBar(button, id, 1000, false)
        else
            HealBot_Aux_clearBar(button, id)
        end
    end
end

function HealBot_Aux_ClearHealthDropBar(button)
      --HealBot_setCall("HealBot_Aux_ClearHealthDropBar", button)
    for id in pairs(hbAuxHealthDropAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end

-- OverLay

local nameLastOverlayType={}
local healthLastOverlayType={}
local overlayColours={}
overlayColours[1]={["R"]=0.1,["G"]=1,["B"]=0.2} -- Recent Heals
overlayColours[2]={["R"]=1,["G"]=0.58,["B"]=0.2} -- Health Drop
overlayColours[4]={["R"]=1,["G"]=0,["B"]=0} -- Aggro
overlayColours[5]={["R"]=0.4,["G"]=1,["B"]=1} -- Highlight
overlayColours[6]={["R"]=1,["G"]=0.9,["B"]=0.2} -- Target
overlayColours[7]={["R"]=0,["G"]=0,["B"]=0} -- Out Of Range

function HealBot_Aux_setAdaptiveCols()
      --HealBot_setCall("HealBot_Aux_setAdaptiveCols")
    if HealBot_Globals.OverrideColours["USEADAPTIVE"]==2 then 
        overlayColours[1]=HealBot_Options_copyTable(HealBot_Globals.OverrideAdaptiveCol["RecentHeals"])
        overlayColours[4]=HealBot_Options_copyTable(HealBot_Globals.OverrideAdaptiveCol["Aggro"])
        overlayColours[5]=HealBot_Options_copyTable(HealBot_Globals.OverrideAdaptiveCol["Highlight"])
        overlayColours[6]=HealBot_Options_copyTable(HealBot_Globals.OverrideAdaptiveCol["Target"])
        overlayColours[7]=HealBot_Options_copyTable(HealBot_Globals.OverrideAdaptiveCol["OOR"])
    else
        overlayColours[1]=HealBot_Options_copyTable(Healbot_Config_Skins.AdaptiveCol[Healbot_Config_Skins.Current_Skin]["RecentHeals"])
        overlayColours[4]=HealBot_Options_copyTable(Healbot_Config_Skins.AdaptiveCol[Healbot_Config_Skins.Current_Skin]["Aggro"])
        overlayColours[5]=HealBot_Options_copyTable(Healbot_Config_Skins.AdaptiveCol[Healbot_Config_Skins.Current_Skin]["Highlight"])
        overlayColours[6]=HealBot_Options_copyTable(Healbot_Config_Skins.AdaptiveCol[Healbot_Config_Skins.Current_Skin]["Target"])
        overlayColours[7]=HealBot_Options_copyTable(Healbot_Config_Skins.AdaptiveCol[Healbot_Config_Skins.Current_Skin]["OOR"])
    end
end

function HealBot_Aux_AssignLastOverlayType(id)
      --HealBot_setCall("HealBot_Aux_AssignLastOverlayType")
    nameLastOverlayType[id]={[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false}
    healthLastOverlayType[id]={[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false}
end

local function HealBot_Aux_OverlayColour(button, id, oType)
      --HealBot_setCall("HealBot_Aux_OverlayColour", button)
    if overlayColours[oType] then
        button.aux[id]["R"]=overlayColours[oType]["R"]
        button.aux[id]["G"]=overlayColours[oType]["G"]
        button.aux[id]["B"]=overlayColours[oType]["B"]
    elseif oType==3 then -- Debuff
        button.aux[id]["R"]=button.aura.debuff.r
        button.aux[id]["G"]=button.aura.debuff.g
        button.aux[id]["B"]=button.aura.debuff.b
    else -- Buff
        button.aux[id]["R"]=button.aura.buff.r
        button.aux[id]["G"]=button.aura.buff.g
        button.aux[id]["B"]=button.aura.buff.b
    end
end

function HealBot_Aux_CheckOverLays(button)
      --HealBot_setCall("HealBot_Aux_CheckOverLays", button)
    if nameLastOverlayType[button.id][1] then
        nameLastOverlayType[button.id][1]=false
    end
    if nameLastOverlayType[button.id][2] then
        nameLastOverlayType[button.id][2]=false
    end
    if nameLastOverlayType[button.id][3] then
        if not Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][button.frame]["OVERLAYDEBUFF"] or button.status.range<0 or button.aura.debuff.colbar==0 then
            nameLastOverlayType[button.id][3]=false
        end
    elseif Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][button.frame]["OVERLAYDEBUFF"] and button.status.range>-1 and button.aura.debuff.colbar>0 then
        nameLastOverlayType[button.id][3]=true
    end
    if nameLastOverlayType[button.id][4] then
        if not Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][button.frame]["OVERLAYAGGRO"] or button.aggro.status<=Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["ALERT"] then
            nameLastOverlayType[button.id][4]=false
        end
    elseif Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][button.frame]["OVERLAYAGGRO"] and button.aggro.status>Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["ALERT"] then
        nameLastOverlayType[button.id][4]=true
    end
    if nameLastOverlayType[button.id][5] then
        nameLastOverlayType[button.id][5]=false
    end
    if nameLastOverlayType[button.id][6] then
        nameLastOverlayType[button.id][6]=false
        HealBot_TargetChanged()
    end
    if nameLastOverlayType[button.id][7] then
        if not Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][button.frame]["OVERLAYOOR"] or button.status.range==1 then
            nameLastOverlayType[button.id][7]=false
        end
    elseif Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][button.frame]["OVERLAYOOR"] and button.status.range<1 then
        nameLastOverlayType[button.id][7]=true
    end
    if nameLastOverlayType[button.id][8] then
        if not Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][button.frame]["OVERLAYBUFF"] or button.status.range<0 or button.aura.buff.colbar==0 then
            nameLastOverlayType[button.id][8]=false
        end
    elseif Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][button.frame]["OVERLAYBUFF"] and button.status.range>-1 and button.aura.buff.colbar>0 then
        nameLastOverlayType[button.id][8]=true
    end
    
    if healthLastOverlayType[button.id][1] then
        healthLastOverlayType[button.id][1]=false
     end
    if healthLastOverlayType[button.id][2] then
        healthLastOverlayType[button.id][2]=false
    end
    if healthLastOverlayType[button.id][3] then
        if not Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][button.frame]["OVERLAYDEBUFF"] or button.status.range<0 or button.aura.debuff.colbar==0 then
            healthLastOverlayType[button.id][3]=false
        end
    elseif Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][button.frame]["OVERLAYDEBUFF"] and button.status.range>-1 and button.aura.debuff.colbar>0 then
        healthLastOverlayType[button.id][3]=true
    end
    if healthLastOverlayType[button.id][4] then
        if not Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][button.frame]["OVERLAYAGGRO"] or button.aggro.status<=Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["ALERT"] then
            healthLastOverlayType[button.id][4]=false
        end
    elseif Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][button.frame]["OVERLAYAGGRO"] and button.aggro.status>Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["ALERT"] then
        healthLastOverlayType[button.id][4]=true
    end
    if healthLastOverlayType[button.id][5] then
        healthLastOverlayType[button.id][5]=false
    end
    if healthLastOverlayType[button.id][6] then
        healthLastOverlayType[button.id][6]=false
        HealBot_TargetChanged()
    end
    if healthLastOverlayType[button.id][7] then
        if not Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][button.frame]["OVERLAYOOR"] or button.status.range==1 then
            healthLastOverlayType[button.id][7]=false
        end
    elseif Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][button.frame]["OVERLAYOOR"] and button.status.range<1 then
        healthLastOverlayType[button.id][7]=true
    end
    if healthLastOverlayType[button.id][8] then
        if not Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][button.frame]["OVERLAYBUFF"] or button.status.range<0 or button.aura.buff.colbar==0 then
            healthLastOverlayType[button.id][8]=false
        end
    elseif Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][button.frame]["OVERLAYBUFF"] and button.status.range>-1 and button.aura.buff.colbar>0 then
        healthLastOverlayType[button.id][8]=true
    end
    
    HealBot_Aux_DoUpdateHealthOverLay(button)
    HealBot_Aux_DoUpdateNameOverLay(button)
end
-- Name

local hbAuxNameAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
function HealBot_Aux_clearNameAssigned(frame,id)
      --HealBot_setCall("HealBot_Aux_clearNameAssigned")
    if frame and id then
        if hbAuxNameAssigned[frame] and hbAuxNameAssigned[frame][id] then
            HealBot_Aux_clearAllBar(id)
            hbAuxNameAssigned[frame][id]=nil
            HealBot_setLuVars("AuxTargetOverlayInUse", false)
            HealBot_Text_setAuxAssigns("Name", frame, false)
            HealBot_setAuxAssigns("NameOverlayRecentHeals", frame, false)
            HealBot_setAuxAssigns("NameOverlayHealthDrop", frame, false)
            HealBot_Aggro_setAuxAssigns("NameOverlayAggro", frame, false)
            HealBot_Aura_setAuxAssigns("NameOverlayDebuff", frame, false)
            HealBot_Action_setAuxAssigns("NameOverlayHighlight", frame, false)
            HealBot_setAuxAssigns("NameOverlayTarget", frame, false)
            HealBot_setAuxAssigns("NameOverlayOOR", frame, false)
            HealBot_Aura_setAuxAssigns("NameOverlayBuff", frame, false)
            HealBot_Timers_Set("AUX","CheckAllAuxOverLays")
        end
    else
        HealBot_setLuVars("AuxTargetOverlayInUse", false)
        for f=1,10 do
            for id in pairs(hbAuxNameAssigned[f]) do
                HealBot_Aux_clearAllBar(id)
            end
            hbAuxNameAssigned[f]={};
            HealBot_Text_setAuxAssigns("Name", f, false)
            HealBot_setAuxAssigns("NameOverlayRecentHeals", f, false)
            HealBot_setAuxAssigns("NameOverlayHealthDrop", f, false)
            HealBot_Aggro_setAuxAssigns("NameOverlayAggro", f, false)
            HealBot_Aura_setAuxAssigns("NameOverlayDebuff", f, false)
            HealBot_Action_setAuxAssigns("NameOverlayHighlight", f, false)
            HealBot_setAuxAssigns("NameOverlayTarget", f, false)
            HealBot_setAuxAssigns("NameOverlayOOR", f, false)
            HealBot_Aura_setAuxAssigns("NameOverlayBuff", f, false)
        end
    end
end

function HealBot_Aux_setNameAssigned(frame, id)
      --HealBot_setCall("HealBot_Aux_setNameAssigned")
    hbAuxNameAssigned[frame][id]=true
    HealBot_Text_setAuxAssigns("Name", frame, true)
    if Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][frame]["OVERLAYRECENTHEALS"] then
        HealBot_setAuxAssigns("NameOverlayRecentHeals", frame, true)
    end
    if Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][frame]["OVERLAYHEALTHDROP"] then
        HealBot_setAuxAssigns("NameOverlayHealthDrop", frame, true)
    end
    if Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][frame]["OVERLAYAGGRO"] then
        HealBot_Aggro_setAuxAssigns("NameOverlayAggro", frame, true)
    end
    if Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][frame]["OVERLAYDEBUFF"] then
        HealBot_Aura_setAuxAssigns("NameOverlayDebuff", frame, true)
    end
    if Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][frame]["OVERLAYHIGHLIGHT"] then
        HealBot_Action_setAuxAssigns("NameOverlayHighlight", frame, true)
    end
    if Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][frame]["OVERLAYTARGET"] then
        HealBot_setAuxAssigns("NameOverlayTarget", frame, true)
        HealBot_setLuVars("AuxTargetOverlayInUse", true)
    end
    if Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][frame]["OVERLAYOOR"] then
        HealBot_setAuxAssigns("NameOverlayOOR", frame, true)
    end
    if Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][frame]["OVERLAYBUFF"] then
        HealBot_Aura_setAuxAssigns("NameOverlayBuff", frame, true)
    end
end

function HealBot_Aux_DoUpdateNameOverLay(button)
      --HealBot_setCall("HealBot_Aux_DoUpdateNameOverLay", button)
    for x=1,8 do
        if nameLastOverlayType[button.id][x] then
            HealBot_Aux_UpdateNameBar(button, true, x)
            return
        end
    end
    HealBot_Aux_UpdateNameBar(button)
end

function HealBot_Aux_UpdateNameOverLay(button, oType, state)
      --HealBot_setCall("HealBot_Aux_UpdateNameOverLay", button)
    if state or nameLastOverlayType[button.id][oType] then
        nameLastOverlayType[button.id][oType]=state
        HealBot_Aux_DoUpdateNameOverLay(button)
    end
end

function HealBot_Aux_UpdateNameBar(button, colSet, oType)
      --HealBot_setCall("HealBot_Aux_UpdateNameBar", button)
    for id in pairs(hbAuxNameAssigned[button.frame]) do
        if colSet then
            HealBot_Aux_OverlayColour(button, id, oType)
        elseif Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==1 then
            button.aux[id]["R"]=0
            button.aux[id]["G"]=0
            button.aux[id]["B"]=0.1
        end
        if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLTYPE"]==1 then
            button.auxtxt[id]["R"]=0.9
            button.auxtxt[id]["G"]=0.9
            button.auxtxt[id]["B"]=0.9
        end
        HealBot_Aux_setBar(button, id, 1000, false, button.text.nameonly, nil, nil, colSet)
    end
end

function HealBot_Aux_ResetNameBar(button)
      --HealBot_setCall("HealBot_Aux_ResetNameBar", button)
    for id in pairs(hbAuxNameAssigned[button.frame]) do
        button.gref.auxtxt[id]:SetText("")
    end
    HealBot_Aux_UpdateNameBar(button)
end

function HealBot_Aux_ClearNameBar(button)
      --HealBot_setCall("HealBot_Aux_ClearNameBar", button)
    for id in pairs(hbAuxNameAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end

-- Health

local hbAuxHealthAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
function HealBot_Aux_clearHealthAssigned(frame,id)
      --HealBot_setCall("HealBot_Aux_clearHealthAssigned")
    if frame and id then
        if hbAuxHealthAssigned[frame] and hbAuxHealthAssigned[frame][id] then
            HealBot_Aux_clearAllBar(id)
            hbAuxHealthAssigned[frame][id]=nil
            HealBot_Text_setAuxAssigns("Health", frame, false)
            HealBot_setAuxAssigns("HealthOverlayRecentHeals", frame, false)
            HealBot_setAuxAssigns("HealthOverlayHealthDrop", frame, false)
            HealBot_Aggro_setAuxAssigns("HealthOverlayAggro", frame, false)
            HealBot_Aura_setAuxAssigns("HealthOverlayDebuff", frame, false)
            HealBot_Action_setAuxAssigns("HealthOverlayHighlight", frame, false)
            HealBot_setAuxAssigns("HealthOverlayTarget", frame, false)
            HealBot_setAuxAssigns("HealthOverlayOOR", frame, false)
            HealBot_Aura_setAuxAssigns("HealthOverlayBuff", frame, false)
            HealBot_Timers_Set("AUX","CheckAllAuxOverLays")
        end
    else
        for f=1,10 do
            for id in pairs(hbAuxHealthAssigned[f]) do
                HealBot_Aux_clearAllBar(id)
            end
            hbAuxHealthAssigned[f]={};
            HealBot_Text_setAuxAssigns("Health", f, false)
            HealBot_setAuxAssigns("HealthOverlayRecentHeals", f, false)
            HealBot_setAuxAssigns("HealthOverlayHealthDrop", f, false)
            HealBot_Aggro_setAuxAssigns("HealthOverlayAggro", f, false)
            HealBot_Aura_setAuxAssigns("HealthOverlayDebuff", f, false)
            HealBot_Action_setAuxAssigns("HealthOverlayHighlight", f, false)
            HealBot_setAuxAssigns("HealthOverlayTarget", f, false)
            HealBot_setAuxAssigns("HealthOverlayOOR", f, false)
            HealBot_Aura_setAuxAssigns("HealthOverlayBuff", f, false)
        end
    end
end

function HealBot_Aux_setHealthAssigned(frame, id)
      --HealBot_setCall("HealBot_Aux_setHealthAssigned")
    hbAuxHealthAssigned[frame][id]=true
    HealBot_Text_setAuxAssigns("Health", frame, true)
    if Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][frame]["OVERLAYRECENTHEALS"] then
        HealBot_setAuxAssigns("HealthOverlayRecentHeals", frame, true)
    end
    if Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][frame]["OVERLAYHEALTHDROP"] then
        HealBot_setAuxAssigns("HealthOverlayHealthDrop", frame, true)
    end
    if Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][frame]["OVERLAYAGGRO"] then
        HealBot_Aggro_setAuxAssigns("HealthOverlayAggro", frame, true)
    end
    if Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][frame]["OVERLAYDEBUFF"] then
        HealBot_Aura_setAuxAssigns("HealthOverlayDebuff", frame, true)
    end
    if Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][frame]["OVERLAYHIGHLIGHT"] then
        HealBot_Action_setAuxAssigns("HealthOverlayHighlight", frame, true)
    end
    if Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][frame]["OVERLAYTARGET"] then
        HealBot_setAuxAssigns("HealthOverlayTarget", frame, true)
    end
    if Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][frame]["OVERLAYOOR"] then
        HealBot_setAuxAssigns("HealthOverlayOOR", frame, true)
    end
    if Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][frame]["OVERLAYBUFF"] then
        HealBot_Aura_setAuxAssigns("HealthOverlayBuff", frame, true)
    end
end

function HealBot_Aux_DoUpdateHealthOverLay(button)
      --HealBot_setCall("HealBot_Aux_DoUpdateHealthOverLay", button)
    for x=1,8 do
        if healthLastOverlayType[button.id][x] then
            HealBot_Aux_UpdateHealthBar(button, true, x)
            return
        end
    end
    HealBot_Aux_UpdateHealthBar(button)
end

function HealBot_Aux_UpdateHealthOverLay(button, oType, state)
      --HealBot_setCall("HealBot_Aux_UpdateHealthOverLay", button)
    healthLastOverlayType[button.id][oType]=state
    HealBot_Aux_DoUpdateHealthOverLay(button)
end

function HealBot_Aux_UpdateHealthBar(button, colSet, oType)
      --HealBot_setCall("HealBot_Aux_UpdateHealthBar", button)
    for id in pairs(hbAuxHealthAssigned[button.frame]) do
        if colSet then
            HealBot_Aux_OverlayColour(button, id, oType)
        elseif Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==1 then
            button.aux[id]["R"]=0
            button.aux[id]["G"]=0
            button.aux[id]["B"]=0.1
        end
        if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLTYPE"]==1 then
            button.auxtxt[id]["R"]=0.9
            button.auxtxt[id]["G"]=0.9
            button.auxtxt[id]["B"]=0.9
        end
        HealBot_Aux_setBar(button, id, 1000, false, button.text.health, nil, nil, colSet)
    end
end

function HealBot_Aux_ResetHealthBar(button)
      --HealBot_setCall("HealBot_Aux_ResetHealthBar", button)
    for id in pairs(hbAuxHealthAssigned[button.frame]) do
        button.gref.auxtxt[id]:SetText("")
    end
    HealBot_Aux_UpdateHealthBar(button)
end

function HealBot_Aux_ClearHealthBar(button)
      --HealBot_setCall("HealBot_Aux_ClearHealthBar", button)
    for id in pairs(hbAuxHealthAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end

-- State

local hbAuxStateAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
function HealBot_Aux_clearStateAssigned(frame,id)
      --HealBot_setCall("HealBot_Aux_clearStateAssigned")
    if frame and id then
        if hbAuxStateAssigned[frame] and hbAuxStateAssigned[frame][id] then
            HealBot_Text_setAuxAssigns("State", frame, false)
            hbAuxStateAssigned[frame][id]=nil
            HealBot_Aux_clearAllBar(id)
        end
    else
        for f=1,10 do
            for id in pairs(hbAuxStateAssigned[f]) do
                HealBot_Aux_clearAllBar(id)
            end
            hbAuxStateAssigned[f]={};
            HealBot_Text_setAuxAssigns("State", f, false)
        end
    end
end

function HealBot_Aux_setStateAssigned(frame, id)
      --HealBot_setCall("HealBot_Aux_setStateAssigned")
    hbAuxStateAssigned[frame][id]=true
    HealBot_Text_setAuxAssigns("State", frame, true)
end

function HealBot_Aux_UpdateStateBar(button)
      --HealBot_setCall("HealBot_Aux_UpdateStateBar", button)
    for id in pairs(hbAuxStateAssigned[button.frame]) do
        if button.status.current<HealBot_Unit_Status["DC"] then
            if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==1 then
                button.aux[id]["R"]=0
                button.aux[id]["G"]=0
                button.aux[id]["B"]=0.1
            end
            if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLTYPE"]==1 then
                button.auxtxt[id]["R"]=0.9
                button.auxtxt[id]["G"]=0.9
                button.auxtxt[id]["B"]=0.9
            end
            HealBot_Aux_setBar(button, id, 1000, false, button.text.tag)
        else
            HealBot_Aux_clearBar(button, id)
        end
    end
end

function HealBot_Aux_ClearStateBar(button)
      --HealBot_setCall("HealBot_Aux_ClearStateBar", button)
    for id in pairs(hbAuxStateAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end

-- Update by Type

local function HealBot_Aux_UpdateAllAuxByTypeById(f, x)
      --HealBot_setCall("HealBot_Aux_UpdateAllAuxByTypeById")
    if hbAuxNameAssigned[f][x] then
        HealBot_Timers_Set("SKINS","TextUpdateNames")
        HealBot_Timers_Set("AUX","CheckAllAuxOverLays")
    elseif hbAuxHealthAssigned[f][x] then
        HealBot_Timers_Set("SKINS","TextUpdateHealth")
        HealBot_Timers_Set("AUX","CheckAllAuxOverLays")
    elseif hbAuxStateAssigned[f][x] then
        HealBot_Timers_Set("SKINS","TextUpdateState")
    elseif hbAuxPowerAssigned[f][x] then
        HealBot_Timers_Set("AUX","UpdateAllAuxPowerBars")
    elseif hbAuxBuffAssigned[f][x] then
        HealBot_Timers_Set("AUX","updAllAuxBuffBars")
    elseif hbAuxDebuffAssigned[f][x] then
        HealBot_Timers_Set("AUX","updAllAuxDebuffBars")
    elseif hbAuxTargetAssigned[f][x] then
        HealBot_Timers_Set("PLAYER","PlayerTargetChanged")
    elseif hbAuxOORAssigned[f][x] then
        HealBot_Timers_Set("AUX","updAllAuxRangeBars")
    elseif hbAuxInRangeAssigned[f][x] then
        HealBot_Timers_Set("AUX","updAllAuxInRangeBars")
    elseif hbAuxOverHealAssigned[f][x] then
        HealBot_Timers_Set("AUX","UpdateAllAuxOverHealsBars")
    elseif hbAuxHealInAssigned[f][x] then
        HealBot_Timers_Set("AUX","UpdateAllAuxInHealsBars")
    elseif hbAuxAbsorbAssigned[f][x] then
        HealBot_Timers_Set("AUX","UpdateAllAuxAbsorbBars")
    elseif hbAuxThreatAssigned[f][x] then
        HealBot_Timers_Set("AUX","UpdateAllAuxThreatBars")
    elseif hbAuxTotalHealAbsorbsAssigned[f][x] then
        HealBot_Timers_Set("AUX","UpdateAllAuxTotalHealAbsorbBars")
    else
        HealBot_Aux_resetFrameBar(f, x)
    end
end

function HealBot_Aux_UpdateAllAuxByType(frame, id)
      --HealBot_setCall("HealBot_Aux_UpdateAllAuxByType")
    if frame and id then
        HealBot_Aux_UpdateAllAuxByTypeById(frame, id)
    else
        for f=1,10 do
            for x=1,9 do
                HealBot_Aux_UpdateAllAuxByTypeById(f, x)
            end
        end
    end
end


local function HealBot_Aux_ResetTextByTypeById(button)
      --HealBot_setCall("HealBot_Aux_ResetTextByTypeById", button)
    for x=1,9 do
        if hbAuxNameAssigned[button.frame][x] then
            HealBot_Aux_setBar(button, x, 1000, false, button.text.nameonly.." ", nil, nil, true)
            HealBot_Aux_DoUpdateNameOverLay(button)
        elseif hbAuxHealthAssigned[button.frame][x] then
            HealBot_Aux_setBar(button, x, 1000, false, button.text.health.." ", nil, nil, true)
            HealBot_Aux_DoUpdateHealthOverLay(button)
        elseif hbAuxStateAssigned[button.frame][x] then
            HealBot_Aux_setBar(button, x, 1000, false, button.text.tag.." ")
            HealBot_Aux_setBar(button, x, 1000, false, button.text.tag)
        elseif Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["TEXT"] then
            if hbAuxPowerAssigned[button.frame][x] then
                HealBot_Aux_setBar(button, x, button.mana.pctc, true, " ")
                HealBot_Aux_setPowerBars(button)
            elseif button.aura.buff.name and hbAuxBuffAssigned[button.frame][x] then
                HealBot_Aux_setBar(button, x, 1000, false, button.aura.buff.name.." ")
                HealBot_Aux_UpdateAuraBuffBars(button)
            elseif button.aura.debuff.name and hbAuxDebuffAssigned[button.frame][x] then
                HealBot_Aux_setBar(button, x, 1000, false, button.aura.debuff.name.." ")
                HealBot_Aux_UpdateAuraDebuffBars(button)
            elseif hbAuxAbsorbAssigned[button.frame][x] then
                HealBot_Aux_SetAuxHlth10(button)
                HealBot_Aux_setBar(button, x, hbAuxHlth10, true, HealBot_Text_shortHealTxt(button.health.auxabsorbs+1, button.frame))
                HealBot_Aux_UpdateAbsorbBar(button)
            elseif hbAuxHealInAssigned[button.frame][x] then
                HealBot_Aux_SetAuxHealIn10(button)
                HealBot_Aux_setBar(button, x, hbAuxHealIn10, true, HealBot_Text_shortHealTxt(button.health.auxincoming+1, button.frame))
                HealBot_Aux_UpdateHealInBar(button)
            elseif hbAuxTotalHealAbsorbsAssigned[button.frame][x] then
                HealBot_Aux_SetAuxTotalHeal10(button)
                HealBot_Aux_setBar(button, x, hbAuxTotalHeal10, true, HealBot_Text_shortHealTxt(button.health.healabsorbs+1, button.frame))
                HealBot_Aux_UpdateTotalHealAbsorbsBar(button)
            elseif hbAuxOverHealAssigned[button.frame][x] then
                HealBot_Aux_SetohValue(button)
                HealBot_Aux_setBar(button, x, ohValue, true, HealBot_Text_shortHealTxt(button.health.overheal+1, button.frame))
                HealBot_Aux_UpdateOverHealBar(button)
            end
        end
    end
end

function HealBot_Aux_ResetTextButtons()
      --HealBot_setCall("HealBot_Aux_ResetTextButtons")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Aux_ResetTextByTypeById(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Aux_ResetTextByTypeById(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Aux_ResetTextByTypeById(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Aux_ResetTextByTypeById(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Aux_ResetTextByTypeById(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Aux_ResetTextByTypeById(xButton)
    end
end

local auxTestText, auxTestCol, auxTestNonTextBarSize, auxTestNonTextTxtSize="", false, 0, 0
local function HealBot_Aux_SetTestButton(button)
      --HealBot_setCall("HealBot_Aux_SetTestButton", button)
    for x=1,9 do
        if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["USE"]>1 then
            button.gref.auxtxt[x]:SetText("")
            button.gref.aux[x]:SetValue(1000)
            auxTestCol=false
            if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLOUR"]==2 then
                button.gref.aux[x]:SetStatusBarColor(button.text.r,button.text.g,button.text.b,1)
            elseif Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLOUR"]==3 then
                if not hbCustomRoleCols[button.roletxt] then button.roletxt="DAMAGER" end
                button.gref.aux[x]:SetStatusBarColor(hbCustomRoleCols[button.roletxt].r,hbCustomRoleCols[button.roletxt].g,hbCustomRoleCols[button.roletxt].b,1)
            elseif Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLOUR"]==4 then
                button.gref.aux[x]:SetStatusBarColor(Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["R"],
                                                Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["G"],
                                                Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["B"],1)
            end
            if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["USE"]==2 then
                if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLOUR"]==1 then
                    if (Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AC"] == 4) then
                        button.gref.aux[x]:SetStatusBarColor(Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AR"],
                                                             Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AG"],
                                                             Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AB"],1)
                    elseif (Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AC"] == 5) then
                        button.gref.aux[x]:SetStatusBarColor(button.text.r,button.text.g,button.text.b, 1)
                    else
                        button.gref.aux[x]:SetStatusBarColor(0,1,0,1)
                    end
                end
                if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLTYPE"]==1 then
                    if (Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AC"] == 4) then
                        button.gref.auxtxt[x]:SetTextColor(Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AR"]+0.2,
                                                           Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AG"]+0.2,
                                                           Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AB"]+0.2,1)
                    elseif (Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AC"] == 5) then
                        button.gref.auxtxt[x]:SetTextColor(button.text.r+0.2,button.text.g+0.2,button.text.b+0.2, 1)
                    else
                        button.gref.auxtxt[x]:SetTextColor(0.2,1,0.2,1)
                    end
                end
                auxTestCol=true
                auxTestText=HEALBOT_classicABSORBHOTUP
            elseif Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["USE"]==3 then
                if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLOUR"]==1 then
                    if (Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IC"] == 4) then
                        button.gref.aux[x]:SetStatusBarColor(Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IR"],
                                                             Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IG"],
                                                             Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IB"],1)
                    elseif (Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IC"] == 5) then
                        button.gref.aux[x]:SetStatusBarColor(button.text.r,button.text.g,button.text.b, 1)
                    else
                        button.gref.aux[x]:SetStatusBarColor(0,1,0,1)
                    end
                end
                if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLTYPE"]==1 then
                    if (Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IC"] == 4) then
                        button.gref.auxtxt[x]:SetTextColor(Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IR"]+0.2,
                                                           Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IG"]+0.2,
                                                           Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IB"]+0.2,1)
                    elseif (Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IC"] == 5) then
                        button.gref.auxtxt[x]:SetTextColor(button.text.r+0.2,button.text.g+0.2,button.text.b+0.2, 1)
                    else
                        button.gref.auxtxt[x]:SetTextColor(0.2,1,0.2,1)
                    end
                end
                auxTestCol=true
                auxTestText=HEALBOT_OPTIONS_INCHEAL
            elseif Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["USE"]==4 then
                if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLOUR"]==1 then
                    button.gref.aux[x]:SetStatusBarColor(button.mana.r,button.mana.g,button.mana.b,1)
                end
                if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLTYPE"]==1 then
                    button.gref.auxtxt[x]:SetTextColor(button.mana.r+0.5,button.mana.g+0.5,button.mana.b+0.5,1)
                end
                auxTestCol=true
                auxTestText=HEALBOT_OPTIONS_POWER
            elseif Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["USE"]==5 then
                if button.frame<10 then
                    auxTestText=HEALBOT_OPTIONS_TAB_AGGRO
                    if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLOUR"]==1 then
                        button.gref.aux[x]:SetStatusBarColor(1,0,0,1)
                    end
                else
                    auxTestText=HEALBOT_OPTIONS_CASTBAR
                    if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLOUR"]==1 then
                        button.gref.aux[x]:SetStatusBarColor(0.8,0.7,0.1,1)
                    end
                    if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLTYPE"]==1 then
                        button.gref.auxtxt[x]:SetTextColor(1,1,1,1)
                    end
                    auxTestCol=true
                end
            elseif Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["USE"]==6 then
                if button.frame<10 then
                    auxTestText=HEALBOT_WORD_THREAT
                    if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLOUR"]==1 then
                        button.gref.aux[x]:SetStatusBarColor(1,1,0.2,1)
                    end
                    if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLTYPE"]==1 then
                        button.gref.auxtxt[x]:SetTextColor(1,1,1,1)
                    end
                    auxTestCol=true
                else
                    auxTestText=HEALBOT_OUTOFRANGE_LABEL
                    if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLOUR"]==1 then
                        button.gref.aux[x]:SetStatusBarColor(0,0,0,1)
                    end
                end
            elseif Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["USE"]==7 then
                if button.frame<10 then
                    auxTestText=HEALBOT_WORD_OVERHEALS
                    if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLOUR"]==1 then
                        button.gref.aux[x]:SetStatusBarColor(1,0.2,0.2,1)
                    end
                    if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLTYPE"]==1 then
                        button.gref.auxtxt[x]:SetTextColor(1,1,1,1)
                    end
                    auxTestCol=true
                else
                    auxTestText=HEALBOT_INRANGE
                    if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLOUR"]==1 then
                        button.gref.aux[x]:SetStatusBarColor(1,1,1,1)
                    end
                end
            elseif Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["USE"]==8 then
                if button.frame<10 then
                    auxTestText=HEALBOT_OPTION_HIGHLIGHTACTIVEBAR
                    if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLOUR"]==1 then
                        button.gref.aux[x]:SetStatusBarColor(0.4,1,1,1)
                    end
                else
                    auxTestText=HEALBOT_OPTION_HEALTHDROP
                    if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLOUR"]==1 then
                        button.gref.aux[x]:SetStatusBarColor(1,0.58,0.2,1)
                    end
                end
            elseif Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["USE"]==9 then
                if button.frame<10 then
                    auxTestText=HEALBOT_OPTIONS_TAB_BUFFS
                    if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLOUR"]==1 then
                        button.gref.aux[x]:SetStatusBarColor(1,1,1,1)
                    end
                    if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLTYPE"]==1 then
                        button.gref.auxtxt[x]:SetTextColor(1,1,1,1)
                    end
                    auxTestCol=true
                else
                    auxTestText=HEALBOT_OPTIONS_TAB_NAMETEXT
                    if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLOUR"]==1 then
                        button.gref.aux[x]:SetStatusBarColor(0,0,0.1,1)
                    end
                    if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLTYPE"]==1 then
                        button.gref.auxtxt[x]:SetTextColor(0.9,0.9,0.9,1)
                    end
                    auxTestCol=true
                end
            elseif Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["USE"]==10 then
                if button.frame<10 then
                    auxTestText=HEALBOT_OPTIONS_TAB_DEBUFFS
                    if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLOUR"]==1 then
                        button.gref.aux[x]:SetStatusBarColor(HealBot_Globals.CDCBarColour[HEALBOT_CUSTOM_en.."15"].R,
                                                             HealBot_Globals.CDCBarColour[HEALBOT_CUSTOM_en.."15"].G,
                                                             HealBot_Globals.CDCBarColour[HEALBOT_CUSTOM_en.."15"].B,1)
                    end
                    if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLTYPE"]==1 then
                        button.gref.auxtxt[x]:SetTextColor(HealBot_Globals.CDCBarColour[HEALBOT_CUSTOM_en.."15"].R+0.2,
                                                           HealBot_Globals.CDCBarColour[HEALBOT_CUSTOM_en.."15"].G+0.2,
                                                           HealBot_Globals.CDCBarColour[HEALBOT_CUSTOM_en.."15"].B+0.2,1)
                    end
                    auxTestCol=true
                else
                    auxTestText=HEALBOT_WORD_HEALTH
                    if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLOUR"]==1 then
                        button.gref.aux[x]:SetStatusBarColor(0,0,0.1,1)
                    end
                    if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLTYPE"]==1 then
                        button.gref.auxtxt[x]:SetTextColor(0.9,0.9,0.9,1)
                    end
                    auxTestCol=true
                end
            elseif Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["USE"]==11 then
                if button.frame<10 then
                    auxTestText=HEALBOT_OPTIONS_CASTBAR
                    if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLOUR"]==1 then
                        button.gref.aux[x]:SetStatusBarColor(0.8,0.7,0.1,1)
                    end
                    if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLTYPE"]==1 then
                        button.gref.auxtxt[x]:SetTextColor(1,1,1,1)
                    end
                    auxTestCol=true
                else
                    auxTestText=HEALBOT_OPTIONS_TAB_STATETEXT
                    if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLOUR"]==1 then
                        button.gref.aux[x]:SetStatusBarColor(0,0,0.1,1)
                    end
                    if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLTYPE"]==1 then
                        button.gref.auxtxt[x]:SetTextColor(0.9,0.9,0.9,1)
                    end
                    auxTestCol=true
                end
            elseif Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["USE"]==12 then
                if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLOUR"]==1 then
                    button.gref.aux[x]:SetStatusBarColor(1,0.9,0.2,1)
                end
                auxTestText=HEALBOT_OPTIONS_TARGETHEALS
            elseif Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["USE"]==13 then
                if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLOUR"]==1 then
                    button.gref.aux[x]:SetStatusBarColor(0,0,0,1)
                end
                auxTestText=HEALBOT_OUTOFRANGE_LABEL
            elseif Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["USE"]==14 then
                if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLOUR"]==1 then
                    button.gref.aux[x]:SetStatusBarColor(1,1,1,1)
                end
                auxTestText=HEALBOT_INRANGE
            elseif Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["USE"]==15 then
                if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLOUR"]==1 then
                    button.gref.aux[x]:SetStatusBarColor(0.1,1,0.2,1)
                end
                auxTestText=HEALBOT_RECENTHEALS
            elseif Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["USE"]==16 then
                if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLOUR"]==1 then
                    button.gref.aux[x]:SetStatusBarColor(0.8,0.1,0.1,1)
                end
                if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLTYPE"]==1 then
                    button.gref.auxtxt[x]:SetTextColor(1,0.4,0.4,1)
                end
                auxTestCol=true
                auxTestText=HEALBOT_WORD_RESURRECTION
            elseif HEALBOT_GAME_VERSION<4 then
                if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["USE"]==17 then
                    if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLOUR"]==1 then
                        button.gref.aux[x]:SetStatusBarColor(1,0.58,0.2,1)
                    end
                    auxTestText=HEALBOT_OPTION_HEALTHDROP
                elseif Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["USE"]==18 then
                    if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLOUR"]==1 then
                        button.gref.aux[x]:SetStatusBarColor(0,0,0.1,1)
                    end
                    if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLTYPE"]==1 then
                        button.gref.auxtxt[x]:SetTextColor(0.9,0.9,0.9,1)
                    end
                    auxTestCol=true
                    auxTestText=HEALBOT_OPTIONS_TAB_NAMETEXT
                elseif Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["USE"]==19 then
                    if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLOUR"]==1 then
                        button.gref.aux[x]:SetStatusBarColor(0,0,0.1,1)
                    end
                    if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLTYPE"]==1 then
                        button.gref.auxtxt[x]:SetTextColor(0.9,0.9,0.9,1)
                    end
                    auxTestCol=true
                    auxTestText=HEALBOT_WORD_HEALTH
                elseif Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["USE"]==20 then
                    if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLOUR"]==1 then
                        button.gref.aux[x]:SetStatusBarColor(0,0,0.1,1)
                    end
                    if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLTYPE"]==1 then
                        button.gref.auxtxt[x]:SetTextColor(0.9,0.9,0.9,1)
                    end
                    auxTestCol=true
                    auxTestText=HEALBOT_OPTIONS_TAB_STATETEXT
                end
            else
                if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["USE"]==17 then
                    if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLOUR"]==1 then
                        button.gref.aux[x]:SetStatusBarColor(Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NSCR"]-0.1,
                                                             Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NSCG"]-0.1,
                                                             Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NSCB"]-0.1,1)
                    end
                    if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLTYPE"]==1 then
                        button.gref.auxtxt[x]:SetTextColor(Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NSCR"]+0.1,
                                                           Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NSCG"]+0.1,
                                                           Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NSCB"]+0.1,1)
                    end
                    auxTestCol=true
                    auxTestText=HEALBOT_WORD_SUMMONS
                elseif Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["USE"]==18 then
                    if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLOUR"]==1 then
                        button.gref.aux[x]:SetStatusBarColor(1,0.58,0.2,1)
                    end
                    auxTestText=HEALBOT_OPTION_HEALTHDROP
                elseif Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["USE"]==19 then
                    if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLOUR"]==1 then
                        button.gref.aux[x]:SetStatusBarColor(0,0,0.1,1)
                    end
                    if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLTYPE"]==1 then
                        button.gref.auxtxt[x]:SetTextColor(0.9,0.9,0.9,1)
                    end
                    auxTestCol=true
                    auxTestText=HEALBOT_OPTIONS_TAB_NAMETEXT
                elseif Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["USE"]==20 then
                    if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLOUR"]==1 then
                        button.gref.aux[x]:SetStatusBarColor(0,0,0.1,1)
                    end
                    if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLTYPE"]==1 then
                        button.gref.auxtxt[x]:SetTextColor(0.9,0.9,0.9,1)
                    end
                    auxTestCol=true
                    auxTestText=HEALBOT_WORD_HEALTH
                elseif Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["USE"]==21 then
                    if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLOUR"]==1 then
                        button.gref.aux[x]:SetStatusBarColor(0,0,0.1,1)
                    end
                    if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLTYPE"]==1 then
                        button.gref.auxtxt[x]:SetTextColor(0.9,0.9,0.9,1)
                    end
                    auxTestCol=true
                    auxTestText=HEALBOT_OPTIONS_TAB_STATETEXT
                elseif Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["USE"]==22 then
                    button.gref.aux[x]:SetStatusBarColor(0.7,0.2,0.9,1)
                    button.gref.auxtxt[x]:SetTextColor(1,1,1,1)
                    auxTestCol=true
                    auxTestText=HEALBOT_OPTIONS_TOTALHEALABSORBS
                end
            end
            if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["ANCHOR"]>2 and Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["ANCHOR"]<5 then
                auxTestText=""
            elseif auxTestCol then
                if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLTYPE"]==2 then
                    button.gref.auxtxt[x]:SetTextColor(button.text.r,button.text.g,button.text.b,1)
                elseif Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLTYPE"]==3 then
                    button.gref.auxtxt[x]:SetTextColor(Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLR"],
                                                       Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLG"],
                                                       Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLB"],1)
                end
            else
                auxTestNonTextBarSize=ceil(Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["DEPTH"]*Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][button.frame]["SCALE"])
                auxTestNonTextTxtSize=ceil(Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][button.frame]["HEIGHT"]*Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][button.frame]["SCALE"])
                if auxTestNonTextTxtSize>auxTestNonTextBarSize then
                    if auxTestNonTextBarSize<7 then
                        auxTestNonTextTxtSize=7
                    else
                        auxTestNonTextTxtSize=auxTestNonTextBarSize
                    end
                    button.gref.auxtxt[x]:SetFont(LSM:Fetch('font',Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][button.frame]["FONT"]),
                          auxTestNonTextTxtSize, HealBot_Font_Outline[Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][button.frame]["OUTLINE"]])
                end
                button.gref.auxtxt[x]:SetTextColor(1,1,1,1)
            end
            button.gref.auxtxt[x]:SetText(auxTestText)
        end
    end
end

function HealBot_Aux_TestUpdateButton(button)
      --HealBot_setCall("HealBot_Aux_TestUpdateButton", button)
    HealBot_Aux_SetTestButton(button)
end

function HealBot_Aux_TestUpdate()
      --HealBot_setCall("HealBot_Aux_TestUpdate")
    for _,xButton in pairs(HealBot_Test_Button) do
        HealBot_Aux_TestUpdateButton(xButton)
    end
end
