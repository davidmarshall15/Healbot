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

function HealBot_Aux_setLuVars(vName, vValue)
    HealBot_Aux_luVars[vName]=vValue
      --HealBot_setCall("HealBot_Aux_setLuVars - "..vName)
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
    hbAuxTextMaxChars[frame][id]=size
end

local function HealBot_Aux_clearBar(button, id)
    button.aux[id]["FLASH"]=false
    button.aux[id]["STATIC"]=false
    button.aux[id]["FLUID"]=-1
    button.aux[id]["TIMED"]=-1
    button.aux[id]["TIMEDH2L"]=-1
    button.aux[id]["TIMEDL2H"]=-1
    button.aux[id]["FLUIDTEXT"]=-1
    button.auxtxt[id]["TEXT"]=false
    button.gref.auxtxt[id]:SetText("")
    if HealBot_Aux_luVars["FluidAlphaInUse"] then
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
end

local function HealBot_Aux_clearAllBar(id)
    for _,xButton in pairs(HealBot_AuxStatic_Buttons) do
        if xButton.aux[id]["STATIC"] then
            HealBot_Aux_clearBar(xButton, id)
        end
    end
    for _,xButton in pairs(HealBot_Aux_Buttons) do
        if xButton.aux[id]["FLASH"] then
            HealBot_Aux_clearBar(xButton, id)
        end
    end
    for _,xButton in pairs(HealBot_AuxFluid_Buttons) do
        if xButton.aux[id]["FLUID"]>-1 then
            HealBot_Aux_clearBar(xButton, id)
        end
    end
    for _,xButton in pairs(HealBot_AuxTimed_Buttons) do
        if xButton.aux[id]["TIMED"]>-1 then
            HealBot_Aux_clearBar(xButton, id)
        end
    end
    for _,xButton in pairs(HealBot_AuxFluid_ButtonsAlpha) do
        if xButton.aux[id]["FLUIDSTATE"]>-1 or xButton.aux[id]["FLUIDTEXT"]>-1 then
            HealBot_Aux_clearBar(xButton, id)
        end
    end
end

local vText,sLen="",0
local function HealBot_Aux_VerticalText(text)
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
    if not colSet then
        if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==2 then
            button.aux[id]["R"]=button.text.r
            button.aux[id]["G"]=button.text.g
            button.aux[id]["B"]=button.text.b
        elseif Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==3 then
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
    if text then
        if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["ANCHOR"]>2 and Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["ANCHOR"]<5 then
            text=HealBot_Aux_VerticalText(text)
        end
        if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLTYPE"]==2 then
            button.auxtxt[id]["R"]=button.text.r
            button.auxtxt[id]["G"]=button.text.g
            button.auxtxt[id]["B"]=button.text.b
        elseif Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLTYPE"]==3 then
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
      --HealBot_setCall("HealBot_Aux_setBar")
end

local hbStaticOn=false
function HealBot_Aux_UpdBar(button, noFluid)
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
      --HealBot_setCall("HealBot_DoUpdAuxBar")
    if not hbStaticOn and HealBot_AuxStatic_Buttons[button.id] then
        HealBot_AuxStatic_Buttons[button.id]=nil
    end
end

function HealBot_Aux_clearAllBars(button)
    for x=1,9 do
        HealBot_Aux_clearBar(button, x)
    end
    --if button.frame>0 and UnitExists(button.unit) then HealBot_OnEvent_UnitManaUpdate(button) end
      --HealBot_setCall("HealBot_Aux_clearAllBars")
end

function HealBot_Aux_resetBars()
    if HealBot_retLuVars("Loaded") then
        HealBot_Timers_Set("AUX","ClearBars")
        HealBot_Timers_Set("AUX","SetBars")
        HealBot_Timers_Set("AUX","UpdateAllAuxBars")
        HealBot_Timers_Set("AUX","UpdateAllAuxByType")
        HealBot_Timers_Set("PLAYER","PlayerTargetChanged")
        HealBot_Timers_Set("SKINS","AuxFramesChanged")
        HealBot_Timers_Set("LAST","UpdateAllUnitBars")
        HealBot_Timers_Set("AURA","CheckUnits")
    else
        HealBot_Timers_Set("AUX","ResetBars")
    end
end

function HealBot_Aux_resetAllBars()
    for _,xButton in pairs(HealBot_AuxStatic_Buttons) do
        for x=1,9 do
            if xButton.aux[x]["STATIC"] then
                xButton.aux[x]["STATIC"]=false
                xButton.aux[x]["ISFLUID"]=false
                xButton.gref.aux[x]:SetStatusBarColor(0,0,0,0)
            end
            if xButton.auxtxt[x]["TEXT"] then
                xButton.gref.auxtxt[x]:SetText("")
                xButton.auxtxt[x]["TEXT"]=false
            end
        end
    end
    for _,xButton in pairs(HealBot_Aux_Buttons) do
        for x=1,9 do
            if xButton.aux[x]["FLASH"] then
                xButton.aux[x]["FLASH"]=false
                xButton.gref.aux[x]:SetStatusBarColor(0,0,0,0)
            end
            if xButton.auxtxt[x]["TEXT"] then
                xButton.gref.auxtxt[x]:SetText("")
                xButton.auxtxt[x]["TEXT"]=false
            end
        end
    end
    for _,xButton in pairs(HealBot_AuxFluid_Buttons) do
        for x=1,9 do
            if xButton.aux[x]["FLUID"]>-1 then
                xButton.aux[x]["FLUID"]=-1
            end
        end
    end
    for _,xButton in pairs(HealBot_AuxTimed_Buttons) do
        for x=1,9 do
            if xButton.aux[x]["TIMED"]>-1 then
                xButton.aux[x]["TIMED"]=-1
                xButton.aux[x]["TIMEDH2L"]=-1
                xButton.aux[x]["TIMEDL2H"]=-1
            end
        end
    end
    for _,xButton in pairs(HealBot_AuxFluid_ButtonsAlpha) do
        for x=1,9 do
            if xButton.aux[x]["FLUIDSTATE"]>-1 then
                xButton.aux[x]["FLUIDSTATE"]=0
            end
            if xButton.aux[x]["FLUIDTEXT"]>-1 then
                xButton.aux[x]["FLUIDTEXT"]=0
            end
        end
    end
      --HealBot_setCall("HealBot_resetAllAuxBar")
end

local hbFlashOn=false
local function HealBot_Aux_DoUpdateVariableBars(button)
    hbFlashOn=false
    for x=1,9 do
        if button.aux[x]["FLASH"] then
            button.gref.aux[x]:SetStatusBarColor(button.aux[x]["R"], button.aux[x]["G"], button.aux[x]["B"], HealBot_Aux_luVars["auxAlpha"])
            hbFlashOn=true
        end
    end
      --HealBot_setCall("HealBot_DoUpdateVariableAuxBars")
    return hbFlashOn
end

function HealBot_Aux_UpdateVariableBars()
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
      --HealBot_setCall("HealBot_Aux_UpdateFluidBarsValue")
    return ufaBarActive
end

local utaElap=0
local function HealBot_Aux_UpdateTimedBarsValue(button, TimeNow) 
    ufaBarActive=false
    for x=1,9 do
        if button.aux[x]["TIMED"]>-1 then
            if button.aux[x]["TIMEDH2L"]>-1 then
                utaElap=((TimeNow*1000)-button.aux[x]["TIMEDH2L"])
                if utaElap<button.aux[x]["TIMED"] then
                    button.gref.aux[x]:SetValue(button.aux[x]["TIMED"]-utaElap)
                    ufaBarActive=true
                end
            else
                utaElap=((TimeNow*1000)-button.aux[x]["TIMEDL2H"])
                if utaElap<button.aux[x]["TIMED"] then
                    button.gref.aux[x]:SetValue(utaElap)
                    ufaBarActive=true
                end
            end
        end
    end
      --HealBot_setCall("HealBot_Aux_UpdateTimedBarsValue")
    return ufaBarActive
end

local function HealBot_Aux_UpdateFluidBarsAlphaValue(button)
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
    
      --HealBot_setCall("HealBot_Aux_UpdateFluidBarsAlphaValue")
    return ufaBarActive
end

function HealBot_Aux_UpdateFluidBars()
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

local TimeNow=0
HealBot_Aux_luVars["UpdateTimedFreq"]=0.02
function HealBot_Aux_AdjUpdateTimedFreq(freq)
    HealBot_Aux_luVars["UpdateTimedFreq"]=freq
end

function HealBot_Aux_UpdateTimedBars()
    HealBot_Aux_luVars["AuxCastBarInUse"]=false
    TimeNow=GetTime()
    for id,xButton in pairs(HealBot_AuxTimed_Buttons) do
        if not HealBot_Aux_UpdateTimedBarsValue(xButton, TimeNow) then
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
    hbAuxPowerAssigned[frame][id]=true
end

function HealBot_Aux_setPowerBars(button)
    for id in pairs(hbAuxPowerAssigned[button.frame]) do
        if button.status.current<HealBot_Unit_Status["DEAD"] then
            if button.mana.max==0 or (Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["MANAONLY"] and button.mana.type~=0) then
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
                        HealBot_Aux_setBar(button, id, button.mana.pct*10, true, HealBot_Text_shortHealTxt(button.mana.current, button.frame))
                    elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTYPE"]==2 then
                        HealBot_Aux_setBar(button, id, button.mana.pct*10, true, HealBot_Text_shortHealTxt(button.mana.current-button.mana.max, button.frame))
                    else
                        HealBot_Aux_setBar(button, id, button.mana.pct*10, true, button.mana.pct.."%")
                    end
                else
                    HealBot_Aux_setBar(button, id, button.mana.pct*10, true)
                end
            end
        else
            HealBot_Aux_clearBar(button, id)
        end
    end
    --HealBot_setCall("HealBot_Aux_setPowerBars")
end

-- Aggro and Threat

local hbAuxAggroAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
local hbAuxThreatAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
function HealBot_Aux_clearAggroAssigned(frame,id)
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
    if aType=="AGGRO" then
        hbAuxAggroAssigned[frame][id]=true
    else
        hbAuxThreatAssigned[frame][id]=true
    end
end

function HealBot_Aux_UpdateThreatBar(button)
    for id in pairs(hbAuxThreatAssigned[button.frame]) do
        if button.status.current<HealBot_Unit_Status["DEAD"] then
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
    for id in pairs(hbAuxThreatAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end

function HealBot_Aux_UpdateAggroBar(button)
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
    for id in pairs(hbAuxAggroAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end

-- Buff and Debuff
local hbAuxBuffAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
local hbAuxDebuffAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
function HealBot_Aux_clearAuraAssigned(frame,id)
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
    if aType=="BUFF" then
        hbAuxBuffAssigned[frame][id]=true
    else
        hbAuxDebuffAssigned[frame][id]=true
    end
end

function HealBot_Aux_UpdateAuraBuffBars(button)
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
    for id in pairs(hbAuxBuffAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end

function HealBot_Aux_UpdateAuraDebuffBars(button)
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
    for id in pairs(hbAuxDebuffAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end

-- HealIn and Absorbs (HoT in classic)
local hbAuxAbsorbAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
local hbAuxHealInAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
function HealBot_Aux_clearInHealsAssigned(frame,id)
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
    if aType=="ABSORB" then
        hbAuxAbsorbAssigned[frame][id]=true
    else
        hbAuxHealInAssigned[frame][id]=true
    end
end

local hbAuxHlth10=0
function HealBot_Aux_UpdateAbsorbBar(button)
    for id in pairs(hbAuxAbsorbAssigned[button.frame]) do
        if button.status.current<HealBot_Unit_Status["DEAD"] then
            if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==1 then
                button.aux[id]["R"]=button.health.absorbr
                button.aux[id]["G"]=button.health.absorbg
                button.aux[id]["B"]=button.health.absorbb
            end
            if button.health.auxabsorbs>0 then
                hbAuxHlth10=floor(1000/((button.health.max/10)/button.health.auxabsorbs))
                if hbAuxHlth10>1000 then hbAuxHlth10=1000 end
            else
                hbAuxHlth10=0
            end
            if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["TEXT"] then
                if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLTYPE"]==1 then
                    button.auxtxt[id]["R"],button.auxtxt[id]["G"],button.auxtxt[id]["B"]=(button.health.absorbr+0.2),(button.health.absorbg+0.2),(button.health.absorbb+0.2)
                end
                if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTYPE"]==3 then
                    HealBot_Aux_setBar(button, id, hbAuxHlth10, true, floor((button.health.auxabsorbs/button.health.max)*100).."%")
                else
                    HealBot_Aux_setBar(button, id, hbAuxHlth10, true, HealBot_Text_shortHealTxt(button.health.auxabsorbs, button.frame))
                end
            else
                HealBot_Aux_setBar(button, id, hbAuxHlth10, true)
            end
        else
            HealBot_Aux_clearBar(button, id)
        end
    end
end

function HealBot_Aux_ClearAbsorbBar(button)
    for id in pairs(hbAuxAbsorbAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end

function HealBot_Aux_UpdateHealInBar(button)
    for id in pairs(hbAuxHealInAssigned[button.frame]) do
        if button.status.current<HealBot_Unit_Status["DEAD"] then
            if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==1 then
                button.aux[id]["R"]=button.health.inhealr
                button.aux[id]["G"]=button.health.inhealg
                button.aux[id]["B"]=button.health.inhealb
            end
            if button.health.auxincoming>0 then
                hbAuxHlth10=floor(1000/((button.health.max/10)/button.health.auxincoming))
                if hbAuxHlth10>1000 then hbAuxHlth10=1000 end
            else
                hbAuxHlth10=0
            end
            if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["TEXT"] then
                if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLTYPE"]==1 then
                    button.auxtxt[id]["R"],button.auxtxt[id]["G"],button.auxtxt[id]["B"]=(button.health.inhealr+0.2),(button.health.inhealg+0.2),(button.health.inhealb+0.2)
                end
                if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTYPE"]==3 then
                    HealBot_Aux_setBar(button, id, hbAuxHlth10, true, floor((button.health.auxincoming/button.health.max)*100).."%")
                else
                    HealBot_Aux_setBar(button, id, hbAuxHlth10, true, HealBot_Text_shortHealTxt(button.health.auxincoming, button.frame))
                end
            else
                HealBot_Aux_setBar(button, id, hbAuxHlth10, true)
            end
        else
            HealBot_Aux_clearBar(button, id)
        end
    end
end

function HealBot_Aux_ClearHealInBar(button)
    for id in pairs(hbAuxHealInAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end

-- OverHeal

local hbAuxOverHealAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
function HealBot_Aux_clearOverHealAssigned(frame,id)
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
    hbAuxOverHealAssigned[frame][id]=true
end

local ohValue=0
function HealBot_Aux_UpdateOverHealBar(button)
    for id in pairs(hbAuxOverHealAssigned[button.frame]) do
        if button.status.current<HealBot_Unit_Status["DEAD"] then
            if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==1 then
                button.aux[id]["R"]=1
                button.aux[id]["G"]=0.2
                button.aux[id]["B"]=0.2
            end
            if button.health.auxincoming>0 then
                ohValue=floor((button.health.auxoverheal/button.health.auxincoming)*1000)
            else
                ohValue=0
            end
            if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["TEXT"] then
                if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLTYPE"]==1 then
                    button.auxtxt[id]["R"],button.auxtxt[id]["G"],button.auxtxt[id]["B"]=1,1,1
                end
                if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTYPE"]==3 then
                    HealBot_Aux_setBar(button, id, ohValue, true, ceil(ohValue/10).."%")
                else
                    HealBot_Aux_setBar(button, id, ohValue, true, HealBot_Text_shortHealTxt(button.health.auxoverheal, button.frame))
                end
            else
                HealBot_Aux_setBar(button, id, ohValue, true)
            end
        else
            HealBot_Aux_clearBar(button, id)
        end
    end
end

function HealBot_Aux_ClearOverHealBar(button)
    for id in pairs(hbAuxOverHealAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end

-- Highlight
local hbAuxHightlightAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
function HealBot_Aux_clearHightlightAssigned(frame,id)
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
    hbAuxHightlightAssigned[frame][id]=true
end

function HealBot_Aux_UpdateHighlightBar(button)
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
    for id in pairs(hbAuxHightlightAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end

-- Target
local hbAuxTargetAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
function HealBot_Aux_clearTargetAssigned(frame,id)
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
    hbAuxTargetAssigned[frame][id]=true
    HealBot_setLuVars("AuxTargetInUse", true)
end

function HealBot_Aux_UpdateTargetBar(button)
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
    for id in pairs(hbAuxTargetAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end

-- Cast bar

local hbAuxCastBarAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
function HealBot_Aux_clearCastBarAssigned(frame,id)
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
    hbAuxCastBarAssigned[frame][id]=true
    HealBot_setAuxAssigns("CastBar", frame, true)
end

function HealBot_Aux_UpdateCastBar(button, text, startTime, endTime, CastIsChan)
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
    button.status.castend=-1
    for id in pairs(hbAuxCastBarAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end

-- Out of Range
local hbAuxOORAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
function HealBot_Aux_clearOORAssigned(frame,id)
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
    hbAuxOORAssigned[frame][id]=true
    HealBot_setAuxAssigns("OORBar", frame, true)
    HealBot_Timers_Set("AUX","ResetRange")
end

function HealBot_Aux_UpdateOORBar(button)
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
    for id in pairs(hbAuxOORAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end

-- Range30

local hbAuxRange30Assigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
function HealBot_Aux_clearRange30Assigned(frame,id)
    if frame and id then
        if hbAuxRange30Assigned[frame] and hbAuxRange30Assigned[frame][id] then
            HealBot_Aux_clearAllBar(id)
            hbAuxRange30Assigned[frame][id]=nil
            HealBot_setLuVars("AuxRange30InUse", false)
            HealBot_setAuxAssigns("Range30Bar", frame, false)
            for x=1,9 do
                if hbAuxRange30Assigned[frame][x] then
                    HealBot_setLuVars("AuxRange30InUse", true)
                    break
                end
            end
        end
    else
        HealBot_setLuVars("AuxRange30InUse", false)
        for f=1,10 do
            for id in pairs(hbAuxRange30Assigned[f]) do
                HealBot_Aux_clearAllBar(id)
            end
            hbAuxRange30Assigned[f]={};
            HealBot_setAuxAssigns("Range30Bar", f, false)
        end
    end
end

function HealBot_Aux_setRange30Assigned(frame, id)
    hbAuxRange30Assigned[frame][id]=true
    HealBot_setAuxAssigns("Range30Bar", frame, true)
    HealBot_setLuVars("AuxRange30InUse", true)
    HealBot_Timers_Set("AUX","ResetRange")
end

function HealBot_Aux_UpdateRange30Bar(button)
    for id in pairs(hbAuxRange30Assigned[button.frame]) do
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

function HealBot_Aux_ClearRange30Bar(button)
    for id in pairs(hbAuxRange30Assigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end

-- Recent Heals

local hbAuxRecentHealsAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
function HealBot_Aux_clearRecentHealsAssigned(frame,id)
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
    hbAuxRecentHealsAssigned[frame][id]=true
    HealBot_setAuxAssigns("RecentHeals", frame, true)
end

function HealBot_Aux_UpdateRecentHealsBar(button)
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
    for id in pairs(hbAuxRecentHealsAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end

-- Res

local hbAuxResAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
function HealBot_Aux_clearResAssigned(frame,id)
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
    hbAuxResAssigned[frame][id]=true
end

function HealBot_Aux_UpdateResBar(button, text, startTime, endTime, CastIsChan)
    for id in pairs(hbAuxResAssigned[button.frame]) do
        if HealBot_Action_IsUnitDead(button) then
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
    for id in pairs(hbAuxResAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end

-- Res

local hbAuxSummonsAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
function HealBot_Aux_clearSummonsAssigned(frame,id)
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
    hbAuxSummonsAssigned[frame][id]=true
end

function HealBot_Aux_UpdateSummonsBar(button, text, startTime, endTime, CastIsChan)
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
    for id in pairs(hbAuxSummonsAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end

-- Health Drop

local hbAuxHealthDropAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
function HealBot_Aux_clearHealthDropAssigned(frame,id)
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
    hbAuxHealthDropAssigned[frame][id]=true
    HealBot_setAuxAssigns("HealthDrop", frame, true)
end

function HealBot_Aux_UpdateHealthDropBar(button)
    for id in pairs(hbAuxHealthDropAssigned[button.frame]) do
        if button.status.current<HealBot_Unit_Status["DC"] then
            if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==1 then
                button.aux[id]["R"]=1
                button.aux[id]["G"]=0.58
                button.aux[id]["B"]=0.2
            end
            HealBot_Aux_setBar(button, id, 1000, false)
        else
            HealBot_Aux_clearBar(button, id)
        end
    end
end

function HealBot_Aux_ClearHealthDropBar(button)
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

function HealBot_Aux_AssignLastOverlayType(id)
    nameLastOverlayType[id]={[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false}
    healthLastOverlayType[id]={[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false}
end

local function HealBot_Aux_OverlayColour(button, id, oType)
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
        HealBot_PlayerTargetChanged()
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
        HealBot_PlayerTargetChanged()
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
    for x=1,8 do
        if nameLastOverlayType[button.id][x] then
            HealBot_Aux_UpdateNameBar(button, true, x)
            return
        end
    end
    HealBot_Aux_UpdateNameBar(button)
end

function HealBot_Aux_UpdateNameOverLay(button, oType, state)
    if state or nameLastOverlayType[button.id][oType] then
        nameLastOverlayType[button.id][oType]=state
        HealBot_Aux_DoUpdateNameOverLay(button)
    end
end

function HealBot_Aux_UpdateNameBar(button, colSet, oType)
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
    for id in pairs(hbAuxNameAssigned[button.frame]) do
        button.gref.auxtxt[id]:SetText("")
    end
    HealBot_Aux_UpdateNameBar(button)
end

function HealBot_Aux_ClearNameBar(button)
    for id in pairs(hbAuxNameAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end

-- Health

local hbAuxHealthAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
function HealBot_Aux_clearHealthAssigned(frame,id)
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
    for x=1,8 do
        if healthLastOverlayType[button.id][x] then
            HealBot_Aux_UpdateHealthBar(button, true, x)
            return
        end
    end
    HealBot_Aux_UpdateHealthBar(button)
end

function HealBot_Aux_UpdateHealthOverLay(button, oType, state)
    healthLastOverlayType[button.id][oType]=state
    HealBot_Aux_DoUpdateHealthOverLay(button)
end

function HealBot_Aux_UpdateHealthBar(button, colSet, oType)
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
    for id in pairs(hbAuxHealthAssigned[button.frame]) do
        button.gref.auxtxt[id]:SetText("")
    end
    HealBot_Aux_UpdateHealthBar(button)
end

function HealBot_Aux_ClearHealthBar(button)
    for id in pairs(hbAuxHealthAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end

-- State

local hbAuxStateAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
function HealBot_Aux_clearStateAssigned(frame,id)
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
    hbAuxStateAssigned[frame][id]=true
    HealBot_Text_setAuxAssigns("State", frame, true)
end

function HealBot_Aux_UpdateStateBar(button)
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
    for id in pairs(hbAuxStateAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end

-- Update by Type

local function HealBot_Aux_UpdateAllAuxByTypeById(f, x)
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
    elseif hbAuxRange30Assigned[f][x] then
        HealBot_Timers_Set("AUX","updAllAuxRange30Bars")
    elseif hbAuxOverHealAssigned[f][x] then
        HealBot_Timers_Set("AUX","UpdateAllAuxOverHealsBars")
    elseif hbAuxHealInAssigned[f][x] then
        HealBot_Timers_Set("AUX","UpdateAllAuxInHealsBars")
    elseif hbAuxAbsorbAssigned[f][x] then
        HealBot_Timers_Set("AUX","UpdateAllAuxAbsorbBars")
    elseif hbAuxThreatAssigned[f][x] then
        HealBot_Timers_Set("AUX","UpdateAllAuxThreatBars")
    end
end

function HealBot_Aux_UpdateAllAuxByType(frame, id)
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
                HealBot_Aux_setBar(button, x, button.mana.pct*10, true, " ")
                HealBot_Aux_setPowerBars(button)
            elseif button.aura.buff.name and hbAuxBuffAssigned[button.frame][x] then
                HealBot_Aux_setBar(button, x, 1000, false, button.aura.buff.name.." ")
                HealBot_Aux_UpdateAuraBuffBars(button)
            elseif button.aura.debuff.name and hbAuxDebuffAssigned[button.frame][x] then
                HealBot_Aux_setBar(button, id, 1000, false, button.aura.debuff.name.." ")
                HealBot_Aux_UpdateAuraDebuffBars(button)
            end
        end
    end
end

function HealBot_Aux_ResetTextButtons()
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
    for x=1,9 do
        if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["USE"]>1 then
            button.gref.auxtxt[x]:SetText("")
            button.gref.aux[x]:SetValue(1000)
            auxTestCol=false
            if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLOUR"]==2 then
                button.gref.aux[x]:SetStatusBarColor(button.text.r,button.text.g,button.text.b,1)
            elseif Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][x][button.frame]["COLOUR"]==3 then
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
                    auxTestText=HEALBOT_RANGE30
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
                auxTestText=HEALBOT_RANGE30
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

function HealBot_Aux_TestUpdate()
    for _,xButton in pairs(HealBot_Test_Button) do
        HealBot_Aux_SetTestButton(xButton)
    end
end
