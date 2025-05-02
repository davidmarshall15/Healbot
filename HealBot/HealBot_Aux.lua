local HealBot_Aux_Buttons={}
local HealBot_AuxStatic_Buttons={}
local HealBot_AuxFluid_Buttons={}
local HealBot_AuxTimed_Buttons={}
local aBarActive,ufaBarActive,aBarSetValue,aBarGetValue=false,false,0,0
local HealBot_Aux_luVars={}

HealBot_Aux_luVars["auxAlpha"]=0.1
HealBot_Aux_luVars["AUXOMIN"]=0.1
HealBot_Aux_luVars["AUXOMAX"]=0.95
HealBot_Aux_luVars["AuxFluidBarOpacityUpdate"]=0.02
HealBot_Aux_luVars["AuxFluidBarOpacityFreq"]=0.088
HealBot_Aux_luVars["AuxFluidBarFreq"]=0.088
HealBot_Aux_luVars["FluidBarSmoothAdj"]=5
HealBot_Aux_luVars["TestBarsOn"]=false

local hbCustomRoleCols={["TANK"]={}, ["HEALER"]={}, ["DAMAGER"]={}}
function HealBot_Aux_SetCustomRoleCols()
      --HealBot_setCall("HealBot_Aux_SetCustomRoleCols")
    hbCustomRoleCols["TANK"].r,hbCustomRoleCols["TANK"].g, hbCustomRoleCols["TANK"].b=hbv_Skins_GetRoleCol("TANK", HealBot_Globals.OverrideColours["USEROLE"])
    hbCustomRoleCols["HEALER"].r,hbCustomRoleCols["HEALER"].g, hbCustomRoleCols["HEALER"].b=hbv_Skins_GetRoleCol("HEALER", HealBot_Globals.OverrideColours["USEROLE"])
    hbCustomRoleCols["DAMAGER"].r,hbCustomRoleCols["DAMAGER"].g, hbCustomRoleCols["DAMAGER"].b=hbv_Skins_GetRoleCol("DAMAGER", HealBot_Globals.OverrideColours["USEROLE"])
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
    local maxHlth=HealBot_MaxPlayerHealth(HealBot_Data["PGUID"])
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
        HealBot_Timers_Set("LAST", "SetInHealAbsorbMax",true,true) -- All recall require a delay
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
    button.aux[id]["FLUIDSTATE"]=-1
    button.aux[id]["ISFLUID"]=false
    button.gref.aux[id]:SetStatusBarColor(0,0,0,0)
    button.gref.aux[id]:SetValue(0)
    if button.aux[id]["OUTLINE"] then
        button.gref.auxglow[id]:SetBackdropBorderColor(0,0,0,0)
    end
end

local function HealBot_Aux_clearAllBar(id)
      --HealBot_setCall("HealBot_Aux_clearAllBar")
    for _,xButton in pairs(HealBot_AuxStatic_Buttons) do
        if xButton.frame>0 and hbv_Aux_GetBarVar("USE", xButton.frame, id) == 1 then
            xButton.aux[id]["CLEAR"]=true
        end
    end
    for _,xButton in pairs(HealBot_Aux_Buttons) do
        if xButton.frame>0 and hbv_Aux_GetBarVar("USE", xButton.frame, id) == 1 then
            xButton.aux[id]["CLEAR"]=true
        end
    end
    for _,xButton in pairs(HealBot_AuxFluid_Buttons) do
        if xButton.frame>0 and hbv_Aux_GetBarVar("USE", xButton.frame, id) == 1 then
            xButton.aux[id]["CLEAR"]=true
        end
    end
    for _,xButton in pairs(HealBot_AuxTimed_Buttons) do
        if xButton.frame>0 and hbv_Aux_GetBarVar("USE", xButton.frame, id) == 1 then
            xButton.aux[id]["CLEAR"]=true
        end
    end
    HealBot_Timers_Set("LAST","AuxBarsReset")
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
        if hbv_Aux_GetBarVar("COLOUR", button.frame, id) == 2 then
            button.aux[id]["R"]=button.text.r
            button.aux[id]["G"]=button.text.g
            button.aux[id]["B"]=button.text.b
        elseif hbv_Aux_GetBarVar("COLOUR", button.frame, id) == 3 then
            button.aux[id]["R"]=hbCustomRoleCols[button.roletxt].r
            button.aux[id]["G"]=hbCustomRoleCols[button.roletxt].g
            button.aux[id]["B"]=hbCustomRoleCols[button.roletxt].b
        elseif hbv_Aux_GetBarVar("COLOUR", button.frame, id) == 4 then
            button.aux[id]["R"]=hbv_Aux_GetBarVar("R", button.frame, id)
            button.aux[id]["G"]=hbv_Aux_GetBarVar("G", button.frame, id)
            button.aux[id]["B"]=hbv_Aux_GetBarVar("B", button.frame, id)
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
    if hbv_Aux_GetBarVar("OTYPE", button.frame, id) == 2 then
        button.aux[id]["FLASH"]=true
        button.gref.aux[id]:SetStatusBarColor(button.aux[id]["R"], button.aux[id]["G"], button.aux[id]["B"], HealBot_Aux_luVars["auxAlpha"])
        HealBot_Aux_Buttons[button.id]=button
        if not HealBot_Aux_luVars["AuxFlashBarsInUse"] then HealBot_Aux_UpdateVariableBars() end
    else
        button.aux[id]["STATIC"]=true
        HealBot_AuxStatic_Buttons[button.id]=button
        if hbv_Aux_GetBarVar("OTYPE", button.frame, id) == 3 then
            button.gref.aux[id]:SetStatusBarColor(button.aux[id]["R"], button.aux[id]["G"], button.aux[id]["B"], HealBot_Action_BarColourAlpha(button, hbv_Aux_GetBarVar("A", button.frame, id), 1))
        else
            button.gref.aux[id]:SetStatusBarColor(button.aux[id]["R"], button.aux[id]["G"], button.aux[id]["B"], button.status.alpha)
        end
    end
    if button.aux[id]["OUTLINE"] then
        if hbv_Aux_GetBarVar("OUTLINE", button.frame, id) then
            button.gref.auxglow[id]:SetBackdropBorderColor(button.aux[id]["R"],button.aux[id]["G"],button.aux[id]["B"],1)
        else
            button.gref.auxglow[id]:SetBackdropBorderColor(0,0,0,0)
        end
    end
    if text then
        if hbv_Aux_GetBarVar("ANCHOR", button.frame, id)>2 and hbv_Aux_GetBarVar("ANCHOR", button.frame, id)<5 then
            text=HealBot_Aux_VerticalText(text)
        end
        if hbv_Aux_GetBarTextVar("COLTYPE", button.frame, id) == 2 then
            button.auxtxt[id]["R"]=button.text.r
            button.auxtxt[id]["G"]=button.text.g
            button.auxtxt[id]["B"]=button.text.b
        elseif hbv_Aux_GetBarTextVar("COLTYPE", button.frame, id) == 3 then
            button.auxtxt[id]["R"]=hbCustomRoleCols[button.roletxt].r
            button.auxtxt[id]["G"]=hbCustomRoleCols[button.roletxt].g
            button.auxtxt[id]["B"]=hbCustomRoleCols[button.roletxt].b
        elseif hbv_Aux_GetBarTextVar("COLTYPE", button.frame, id) == 4 then
            button.auxtxt[id]["R"]=hbv_Aux_GetBarTextVar("COLR", button.frame, id)
            button.auxtxt[id]["G"]=hbv_Aux_GetBarTextVar("COLG", button.frame, id)
            button.auxtxt[id]["B"]=hbv_Aux_GetBarTextVar("COLB", button.frame, id)
        end
        if HealBot_Text_Len(text)>hbAuxTextMaxChars[button.frame][id] then
            text=HealBot_Text_Sub(text,1,hbAuxTextMaxChars[button.frame][id])
        end
        button.gref.auxtxt[id]:SetText(text)
        if button.status.enabled or HealBot_Aux_luVars["TestBarsOn"] then
            if button.status.range>0 then
                button.gref.auxtxt[id]:SetTextColor(button.auxtxt[id]["R"],button.auxtxt[id]["G"],button.auxtxt[id]["B"],HealBot_Action_BarColourAlpha(button, hbv_Aux_GetBarTextVar("COLA", button.frame, id), 1))
            else
                button.gref.auxtxt[id]:SetTextColor(button.auxtxt[id]["R"],button.auxtxt[id]["G"],button.auxtxt[id]["B"],HealBot_Action_BarColourAlpha(button, hbv_Aux_GetBarTextVar("COLOA", button.frame, id), 1))
            end
        else
            button.gref.auxtxt[id]:SetTextColor(button.auxtxt[id]["R"],button.auxtxt[id]["G"],button.auxtxt[id]["B"],HealBot_Action_BarColourAlpha(button, hbv_Aux_GetBarTextVar("COLDA", button.frame, id), 1))
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
            if hbv_Aux_GetBarVar("OTYPE", button.frame, x) == 3 then
                button.gref.aux[x]:SetStatusBarColor(button.aux[x]["R"], button.aux[x]["G"], button.aux[x]["B"], HealBot_Action_BarColourAlpha(button, hbv_Aux_GetBarVar("A", button.frame, x), 1))
            else
                button.gref.aux[x]:SetStatusBarColor(button.aux[x]["R"], button.aux[x]["G"], button.aux[x]["B"], button.status.alpha)
            end
        end
        if button.auxtxt[x]["TEXT"] then
            if button.status.enabled or HealBot_Aux_luVars["TestBarsOn"] then
                if button.status.range>0 then
                    button.gref.auxtxt[x]:SetTextColor(button.auxtxt[x]["R"],button.auxtxt[x]["G"],button.auxtxt[x]["B"],HealBot_Action_BarColourAlpha(button, hbv_Aux_GetBarTextVar("COLA", button.frame, x), 1))
                else
                    button.gref.auxtxt[x]:SetTextColor(button.auxtxt[x]["R"],button.auxtxt[x]["G"],button.auxtxt[x]["B"],HealBot_Action_BarColourAlpha(button, hbv_Aux_GetBarTextVar("COLOA", button.frame, x), 1))
                end
            else
                button.gref.auxtxt[x]:SetTextColor(button.auxtxt[x]["R"],button.auxtxt[x]["G"],button.auxtxt[x]["B"],HealBot_Action_BarColourAlpha(button, hbv_Aux_GetBarTextVar("COLDA", button.frame, x), 1))
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
    --if button.frame>0 and UnitExists(button.unit) then HealBot_Events_UnitManaUpdate(button) end
end

function HealBot_Aux_clearMarkedBars(button)
      --HealBot_setCall("HealBot_Aux_clearMarkedBars", button)
    for x=1,9 do
        if button.aux[x]["CLEAR"] then
            HealBot_Aux_clearBar(button, x)
        end
    end
end

function HealBot_Aux_barsReset()
      --HealBot_setCall("HealBot_Aux_barsReset")
    HealBot_Update_AuxClearAllMarkedBars()
    HealBot_Aux_luVars["FluidInUse"]=HealBot_Aux_luVars["TmpFluidInUse"]
end

function HealBot_Aux_resetBars()
      --HealBot_setCall("HealBot_Aux_resetBars")
    if HealBot_retLuVars("Loaded") then
        HealBot_Aux_luVars["TmpFluidInUse"]=HealBot_Aux_luVars["FluidInUse"]
        if HealBot_Aux_luVars["FluidInUse"] then
            HealBot_Aux_luVars["FluidInUse"]=false
        end
        HealBot_Options_clearAuxBars()
        HealBot_Options_setAuxBars()
        HealBot_Update_AllAuxBars()
        HealBot_Aux_UpdateAllAuxByType()
        HealBot_PlayerTargetChanged()
        HealBot_Options_framesChanged(false, false, false, false, true)
        HealBot_Timers_Set("LAST","UpdateAllUnitBars")
        HealBot_Timers_Set("AURA","CheckUnits")
        HealBot_Aux_barsReset()
    else
        HealBot_Timers_Set("AUX","ResetBars",true) -- All recall require a delay
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
end

function HealBot_Aux_resetFrameBar(frame, id)
      --HealBot_setCall("HealBot_Aux_resetFrameBar")
    for _,xButton in pairs(HealBot_AuxStatic_Buttons) do
        if xButton.frame == frame then HealBot_Aux_clearBar(xButton, id) end
    end
    for _,xButton in pairs(HealBot_Aux_Buttons) do
        if xButton.frame == frame then HealBot_Aux_clearBar(xButton, id) end
    end
    for _,xButton in pairs(HealBot_AuxFluid_Buttons) do
        if xButton.frame == frame then HealBot_Aux_clearBar(xButton, id) end
    end
    for _,xButton in pairs(HealBot_AuxTimed_Buttons) do
        if xButton.frame == frame then HealBot_Aux_clearBar(xButton, id) end
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

HealBot_Aux_luVars["UpdateTimedFreq"]=0.03
function HealBot_Aux_AdjUpdateTimedFreq(freq)
      --HealBot_setCall("HealBot_Aux_AdjUpdateTimedFreq")
    HealBot_Aux_luVars["UpdateTimedFreq"]=freq
    HealBot_Debug_PerfUpdate("AuxFluidFreq", freq)
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

local function HealBot_Aux_AutoTextColour(button,id,r,g,b,minVal)
    r=r+0.2
    g=g+0.2
    b=b+0.2
    if r<minVal then r=minVal end
    if g<minVal then g=minVal end
    if b<minVal then b=minVal end
    button.auxtxt[id]["R"]=r
    button.auxtxt[id]["G"]=g
    button.auxtxt[id]["B"]=b
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

local function HealBot_Aux_setPowerBarsById(button, id)
    if button.status.current<HealBot_Unit_Status["DEAD"] then
        local noPowerbar=false
        if hbv_Aux_GetBarBoolean("MANAONLY", button.frame, id) then
            if button.mana.type~=0 then
                noPowerbar=true
            elseif hbv_Aux_GetBarBoolean("HEALERSMANAONLY", button.frame, id) and button.role~=3 and button.role~=5 then
                noPowerbar=true
            end
        end
        if button.mana.max == 0 or noPowerbar then
            button.aux[id]["R"]=0
            button.aux[id]["G"]=0
            button.aux[id]["B"]=0
            HealBot_Aux_setBar(button, id, 0, true)
        else
            if hbv_Aux_GetBarVar("COLOUR", button.frame, id) == 1 then
                button.aux[id]["R"]=button.mana.r
                button.aux[id]["G"]=button.mana.g
                button.aux[id]["B"]=button.mana.b
            end
            if button.mana.change then
                button.mana.change=false
                HealBot_Aux_UpdBar(button, true)
            end
            if hbv_Aux_GetBarBoolean("TEXT", button.frame, id) then
                if hbv_Aux_GetBarTextVar("COLTYPE", button.frame, id) == 1 then
                    HealBot_Aux_AutoTextColour(button, id, button.mana.r, button.mana.g, button.mana.b, 0.58)
                end
                if hbv_Skins_GetFrameVar("BarText", "HLTHTYPE", button.frame) == 1 then
                    HealBot_Aux_setBar(button, id, button.mana.pctc, true, HealBot_Text_shortHealTxt(button.mana.current, button.frame))
                elseif hbv_Skins_GetFrameVar("BarText", "HLTHTYPE", button.frame) == 2 then
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

function HealBot_Aux_setPowerBars(button)
      --HealBot_setCall("HealBot_Aux_setPowerBars", button)
    for id in pairs(hbAuxPowerAssigned[button.frame]) do
        HealBot_Aux_setPowerBarsById(button, id)
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
    if aType == "AGGRO" then
        hbAuxAggroAssigned[frame][id]=true
    else
        hbAuxThreatAssigned[frame][id]=true
    end
end

local function HealBot_Aux_UpdateThreatBarById(button, id)
    if button.status.current<HealBot_Unit_Status["DEAD"] and button.aggro.threatpct>0 then
        if hbv_Aux_GetBarVar("COLOUR", button.frame, id) == 1 then
            button.aux[id]["R"]=1
            button.aux[id]["G"]=1
            button.aux[id]["B"]=0.2
        end
        if hbv_Aux_GetBarBoolean("TEXT", button.frame, id) then
            if hbv_Aux_GetBarTextVar("COLTYPE", button.frame, id) == 1 then
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

function HealBot_Aux_UpdateThreatBar(button)
      --HealBot_setCall("HealBot_Aux_UpdateThreatBar", button)
    for id in pairs(hbAuxThreatAssigned[button.frame]) do
        HealBot_Aux_UpdateThreatBarById(button, id)
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
            if hbv_Aux_GetBarVar("COLOUR", button.frame, id) == 1 then
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
    if aType == "BUFF" then
        hbAuxBuffAssigned[frame][id]=true
    else
        hbAuxDebuffAssigned[frame][id]=true
    end
end

local function HealBot_Aux_UpdateAuraBuffBarsById(button, id)
    if button.status.current<HealBot_Unit_Status["DEAD"] then
        if hbv_Aux_GetBarVar("COLOUR", button.frame, id) == 1 then
            button.aux[id]["R"],button.aux[id]["G"],button.aux[id]["B"]=button.aura.buff.r,button.aura.buff.g,button.aura.buff.b
        end
        if hbv_Aux_GetBarBoolean("TEXT", button.frame, id) then
            if hbv_Aux_GetBarTextVar("COLTYPE", button.frame, id) == 1 then
                HealBot_Aux_AutoTextColour(button, id, button.aura.buff.r, button.aura.buff.g, button.aura.buff.b, 0.4)
            end
            HealBot_Aux_setBar(button, id, 1000, false, button.aura.buff.name)
        else
            HealBot_Aux_setBar(button, id, 1000, false, false)
        end
    else
        HealBot_Aux_clearBar(button, id)
    end
end

function HealBot_Aux_UpdateAuraBuffBars(button)
      --HealBot_setCall("HealBot_Aux_UpdateAuraBuffBars", button)
    for id in pairs(hbAuxBuffAssigned[button.frame]) do
        HealBot_Aux_UpdateAuraBuffBarsById(button, id)
    end
end

function HealBot_Aux_ClearAuraBuffBars(button)
      --HealBot_setCall("HealBot_Aux_ClearAuraBuffBars", button)
    for id in pairs(hbAuxBuffAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end

local function HealBot_Aux_UpdateAuraDebuffBarsById(button, id)
    if button.status.current<HealBot_Unit_Status["DEAD"] then
        if hbv_Aux_GetBarVar("COLOUR", button.frame, id) == 1 then
            button.aux[id]["R"],button.aux[id]["G"],button.aux[id]["B"]=button.aura.debuff.r,button.aura.debuff.g,button.aura.debuff.b
        end
        if hbv_Aux_GetBarBoolean("TEXT", button.frame, id) then
            if hbv_Aux_GetBarTextVar("COLTYPE", button.frame, id) == 1 then
                HealBot_Aux_AutoTextColour(button, id, button.aura.debuff.r, button.aura.debuff.g, button.aura.debuff.b, 0.4)
            end
            HealBot_Aux_setBar(button, id, 1000, false, button.aura.debuff.name)
        else
            HealBot_Aux_setBar(button, id, 1000, false, false)
        end
    else
        HealBot_Aux_clearBar(button, id)
    end
end

function HealBot_Aux_UpdateAuraDebuffBars(button)
      --HealBot_setCall("HealBot_Aux_UpdateAuraDebuffBars", button)
    for id in pairs(hbAuxDebuffAssigned[button.frame]) do
        HealBot_Aux_UpdateAuraDebuffBarsById(button, id)
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
    if aType == "ABSORB" then
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

local function HealBot_Aux_UpdateAbsorbBarById(button, id)
    if button.status.current<HealBot_Unit_Status["DEAD"] and button.health.auxabsorbs>0 then
        if hbv_Aux_GetBarVar("COLOUR", button.frame, id) == 1 then
            button.aux[id]["R"]=button.health.absorbr
            button.aux[id]["G"]=button.health.absorbg
            button.aux[id]["B"]=button.health.absorbb
        end
        HealBot_Aux_SetAuxHlth10(button)
        if hbv_Aux_GetBarBoolean("TEXT", button.frame, id) then
            if hbv_Aux_GetBarTextVar("COLTYPE", button.frame, id) == 1 then
                HealBot_Aux_AutoTextColour(button, id, button.health.absorbr, button.health.absorbg, button.health.absorbb, 0.25)
            end
            HealBot_Aux_setBar(button, id, hbAuxHlth10, true, HealBot_Text_shortHealTxt(button.health.auxabsorbs, button.frame))
        else
            HealBot_Aux_setBar(button, id, hbAuxHlth10, true)
        end
    else
        HealBot_Aux_clearBar(button, id)
    end
end

function HealBot_Aux_UpdateAbsorbBar(button)
      --HealBot_setCall("HealBot_Aux_UpdateAbsorbBar", button)
    for id in pairs(hbAuxAbsorbAssigned[button.frame]) do
        HealBot_Aux_UpdateAbsorbBarById(button, id)
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

local function HealBot_Aux_UpdateHealInBarById(button, id)
    if button.status.current<HealBot_Unit_Status["DEAD"] and button.health.auxincoming>0 then
        if hbv_Aux_GetBarVar("COLOUR", button.frame, id) == 1 then
            button.aux[id]["R"]=button.health.inhealr
            button.aux[id]["G"]=button.health.inhealg
            button.aux[id]["B"]=button.health.inhealb
        end
        HealBot_Aux_SetAuxHealIn10(button)
        if hbv_Aux_GetBarBoolean("TEXT", button.frame, id) then
            if hbv_Aux_GetBarTextVar("COLTYPE", button.frame, id) == 1 then
                HealBot_Aux_AutoTextColour(button, id, button.health.inhealr, button.health.inhealg, button.health.inhealb, 0.25)
            end
            HealBot_Aux_setBar(button, id, hbAuxHealIn10, true, HealBot_Text_shortHealTxt(button.health.auxincoming, button.frame))
        else
            HealBot_Aux_setBar(button, id, hbAuxHealIn10, true)
        end
    else
        HealBot_Aux_clearBar(button, id)
    end
end

function HealBot_Aux_UpdateHealInBar(button)
      --HealBot_setCall("HealBot_Aux_UpdateHealInBar", button)
    for id in pairs(hbAuxHealInAssigned[button.frame]) do
        HealBot_Aux_UpdateHealInBarById(button, id)
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

local function HealBot_Aux_UpdateTotalHealAbsorbsBarById(button, id)
    if button.status.current<HealBot_Unit_Status["DEAD"] and button.health.healabsorbs>0 then
        if hbv_Aux_GetBarVar("COLOUR", button.frame, id) == 1 then
            button.aux[id]["R"]=0.7
            button.aux[id]["G"]=0.2
            button.aux[id]["B"]=0.9
        end
        HealBot_Aux_SetAuxTotalHeal10(button)
        if hbv_Aux_GetBarBoolean("TEXT", button.frame, id) then
            if hbv_Aux_GetBarTextVar("COLTYPE", button.frame, id) == 1 then
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

function HealBot_Aux_UpdateTotalHealAbsorbsBar(button)
      --HealBot_setCall("HealBot_Aux_UpdateTotalHealAbsorbsBar", button)
    for id in pairs(hbAuxTotalHealAbsorbsAssigned[button.frame]) do
        HealBot_Aux_UpdateTotalHealAbsorbsBarById(button, id)
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

local function HealBot_Aux_UpdateOverHealBarById(button, id)
    if button.status.current<HealBot_Unit_Status["DEAD"] and button.status.range>-1 and button.health.overheal>0 then
        if hbv_Aux_GetBarVar("COLOUR", button.frame, id) == 1 then
            button.aux[id]["R"]=1
            button.aux[id]["G"]=0.2
            button.aux[id]["B"]=0.2
        end
        HealBot_Aux_SetohValue(button)
        if hbv_Aux_GetBarBoolean("TEXT", button.frame, id) then
            if hbv_Aux_GetBarTextVar("COLTYPE", button.frame, id) == 1 then
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

function HealBot_Aux_UpdateOverHealBar(button)
      --HealBot_setCall("HealBot_Aux_UpdateOverHealBar", button)
    for id in pairs(hbAuxOverHealAssigned[button.frame]) do
        HealBot_Aux_UpdateOverHealBarById(button, id)
    end
end

function HealBot_Aux_ClearOverHealBar(button)
      --HealBot_setCall("HealBot_Aux_ClearOverHealBar", button)
    for id in pairs(hbAuxOverHealAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end

-- Highlight
local hbAuxHighlightAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
function HealBot_Aux_clearHighlightAssigned(frame,id)
      --HealBot_setCall("HealBot_Aux_clearHighlightAssigned")
    if frame and id then
        if hbAuxHighlightAssigned[frame] and hbAuxHighlightAssigned[frame][id] then
            HealBot_Aux_clearAllBar(id)
            hbAuxHighlightAssigned[frame][id]=nil
        end
    else
        for f=1,9 do
            for id in pairs(hbAuxHighlightAssigned[f]) do
                HealBot_Aux_clearAllBar(id)
            end
            hbAuxHighlightAssigned[f]={};
        end
    end
end

function HealBot_Aux_setHighlightAssigned(frame, id)
      --HealBot_setCall("HealBot_Aux_setHighlightAssigned")
    hbAuxHighlightAssigned[frame][id]=true
end

function HealBot_Aux_UpdateHighlightBar(button)
      --HealBot_setCall("HealBot_Aux_UpdateHighlightBar", button)
    for id in pairs(hbAuxHighlightAssigned[button.frame]) do
        if hbv_Aux_GetBarVar("COLOUR", button.frame, id) == 1 then
            button.aux[id]["R"]=0.4
            button.aux[id]["G"]=1
            button.aux[id]["B"]=1
        end
        HealBot_Aux_setBar(button, id, 1000, false)
    end
end

function HealBot_Aux_ClearHighlightBar(button)
      --HealBot_setCall("HealBot_Aux_ClearHighlightBar", button)
    for id in pairs(hbAuxHighlightAssigned[button.frame]) do
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

function HealBot_Aux_UpdateTargetBarById(button, id)
    if button.status.current<HealBot_Unit_Status["RESERVED"] then
        if hbv_Aux_GetBarVar("COLOUR", button.frame, id) == 1 then
            button.aux[id]["R"]=1
            button.aux[id]["G"]=0.9
            button.aux[id]["B"]=0.2
        end
        HealBot_Aux_setBar(button, id, 1000, false)
    else
        HealBot_Aux_clearBar(button, id)
    end
end

function HealBot_Aux_UpdateTargetBar(button)
      --HealBot_setCall("HealBot_Aux_UpdateTargetBar", button)
    for id in pairs(hbAuxTargetAssigned[button.frame]) do
        HealBot_Aux_UpdateTargetBarById(button, id)
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
            HealBot_Events_setAuxAssigns("CastBar", frame, false)
        end
    else
        for f=1,10 do
            for id in pairs(hbAuxCastBarAssigned[f]) do
                HealBot_Aux_clearAllBar(id)
            end
            hbAuxCastBarAssigned[f]={};
            HealBot_setAuxAssigns("CastBar", f, false)
            HealBot_Events_setAuxAssigns("CastBar", f, false)
        end
    end
end

function HealBot_Aux_setCastBarAssigned(frame, id)
      --HealBot_setCall("HealBot_Aux_setCastBarAssigned")
    hbAuxCastBarAssigned[frame][id]=true
    HealBot_setAuxAssigns("CastBar", frame, true)
    HealBot_Events_setAuxAssigns("CastBar", frame, true)
end

function HealBot_Aux_UpdateCastBar(button, text, startTime, endTime, CastIsChan)
      --HealBot_setCall("HealBot_Aux_UpdateCastBar", button)
    for id in pairs(hbAuxCastBarAssigned[button.frame]) do
        if button.status.current<HealBot_Unit_Status["DEAD"] then
            if hbv_Aux_GetBarVar("COLOUR", button.frame, id) == 1 then
                button.aux[id]["R"]=0.8
                button.aux[id]["G"]=0.7
                button.aux[id]["B"]=0.1
            end
            if hbv_Aux_GetBarBoolean("TEXT", button.frame, id) then
                if hbv_Aux_GetBarTextVar("COLTYPE", button.frame, id) == 1 then
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

local function HealBot_Aux_UpdateOORBarById(button, id)
    if button.status.current<HealBot_Unit_Status["DC"] then
        if hbv_Aux_GetBarVar("COLOUR", button.frame, id) == 1 then
            button.aux[id]["R"]=0
            button.aux[id]["G"]=0
            button.aux[id]["B"]=0
        end
        HealBot_Aux_setBar(button, id, 1000, false)
    else
        HealBot_Aux_clearBar(button, id)
    end
end

function HealBot_Aux_UpdateOORBar(button)
      --HealBot_setCall("HealBot_Aux_UpdateOORBar", button)
    for id in pairs(hbAuxOORAssigned[button.frame]) do
        HealBot_Aux_UpdateOORBarById(button, id)
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

local function HealBot_Aux_UpdateInRangeBarById(button, id)
    if button.status.current<HealBot_Unit_Status["DC"] then
        if hbv_Aux_GetBarVar("COLOUR", button.frame, id) == 1 then
            button.aux[id]["R"]=1
            button.aux[id]["G"]=1
            button.aux[id]["B"]=1
        end
        HealBot_Aux_setBar(button, id, 1000, false)
    else
        HealBot_Aux_clearBar(button, id)
    end
end

function HealBot_Aux_UpdateInRangeBar(button)
      --HealBot_setCall("HealBot_Aux_UpdateInRangeBar", button)
    for id in pairs(hbAuxInRangeAssigned[button.frame]) do
        HealBot_Aux_UpdateInRangeBarById(button, id)
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
            if hbv_Aux_GetBarVar("COLOUR", button.frame, id) == 1 then
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
                if hbv_Aux_GetBarVar("COLOUR", button.frame, id) == 1 then
                    button.aux[id]["R"]=hbv_Skins_GetFrameVar("BarTextCol", "NRCR", button.frame)
                    button.aux[id]["G"]=hbv_Skins_GetFrameVar("BarTextCol", "NRCG", button.frame)
                    button.aux[id]["B"]=hbv_Skins_GetFrameVar("BarTextCol", "NRCB", button.frame)
                end
                if hbv_Aux_GetBarBoolean("TEXT", button.frame, id) then
                    if hbv_Aux_GetBarTextVar("COLTYPE", button.frame, id) == 1 then
                        HealBot_Aux_AutoTextColour(button, id, hbv_Skins_GetFrameVar("BarTextCol", "NRCR", button.frame), hbv_Skins_GetFrameVar("BarTextCol", "NRCG", button.frame), hbv_Skins_GetFrameVar("BarTextCol", "NRCB", button.frame), 0.5)
                    end
                    HealBot_Aux_setBar(button, id, startTime, false, text, endTime, CastIsChan)
                else
                    HealBot_Aux_setBar(button, id, startTime, false, false, endTime, CastIsChan)
                end
            else
                if hbv_Aux_GetBarVar("COLOUR", button.frame, id) == 1 then
                    button.aux[id]["R"]=hbv_Skins_GetFrameVar("BarTextCol", "NDCR", button.frame)
                    button.aux[id]["G"]=hbv_Skins_GetFrameVar("BarTextCol", "NDCG", button.frame)
                    button.aux[id]["B"]=hbv_Skins_GetFrameVar("BarTextCol", "NDCB", button.frame)
                end
                button.gref.aux[id]:SetMinMaxValues(0,1000)
                if hbv_Aux_GetBarBoolean("TEXT", button.frame, id) then
                    if hbv_Aux_GetBarTextVar("COLTYPE", button.frame, id) == 1 then
                        HealBot_Aux_AutoTextColour(button, id, hbv_Skins_GetFrameVar("BarTextCol", "NDCR", button.frame), hbv_Skins_GetFrameVar("BarTextCol", "NDCG", button.frame), hbv_Skins_GetFrameVar("BarTextCol", "NDCB", button.frame), 0.5)
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
            if hbv_Aux_GetBarVar("COLOUR", button.frame, id) == 1 then
                button.aux[id]["R"]=hbv_Skins_GetFrameVar("BarTextCol", "NSCR", button.frame)-0.1
                button.aux[id]["G"]=hbv_Skins_GetFrameVar("BarTextCol", "NSCG", button.frame)-0.1
                button.aux[id]["B"]=hbv_Skins_GetFrameVar("BarTextCol", "NSCB", button.frame)-0.1
            end
            if hbv_Aux_GetBarBoolean("TEXT", button.frame, id) then
                if hbv_Aux_GetBarTextVar("COLTYPE", button.frame, id) == 1 then
                    HealBot_Aux_AutoTextColour(button, id, hbv_Skins_GetFrameVar("BarTextCol", "NSCR", button.frame), hbv_Skins_GetFrameVar("BarTextCol", "NSCG", button.frame), hbv_Skins_GetFrameVar("BarTextCol", "NSCB", button.frame), 0.5)
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
            if hbv_Aux_GetBarVar("COLOUR", button.frame, id) == 1 then
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
    if HealBot_Globals.OverrideColours["USEADAPTIVE"] == 2 then
        overlayColours[1]=HealBot_Options_copyTable(HealBot_Globals.OverrideAdaptiveCol["RecentHeals"])
        overlayColours[4]=HealBot_Options_copyTable(HealBot_Globals.OverrideAdaptiveCol["Aggro"])
        overlayColours[5]=HealBot_Options_copyTable(HealBot_Globals.OverrideAdaptiveCol["Highlight"])
        overlayColours[6]=HealBot_Options_copyTable(HealBot_Globals.OverrideAdaptiveCol["Target"])
        overlayColours[7]=HealBot_Options_copyTable(HealBot_Globals.OverrideAdaptiveCol["OOR"])
    else
        overlayColours[1]["R"]=hbv_Skins_GetColVar("AdaptiveCol", "RecentHeals", "R")
        overlayColours[1]["G"]=hbv_Skins_GetColVar("AdaptiveCol", "RecentHeals", "G")
        overlayColours[1]["B"]=hbv_Skins_GetColVar("AdaptiveCol", "RecentHeals", "B")
        overlayColours[4]["R"]=hbv_Skins_GetColVar("AdaptiveCol", "Aggro", "R")
        overlayColours[4]["G"]=hbv_Skins_GetColVar("AdaptiveCol", "Aggro", "G")
        overlayColours[4]["B"]=hbv_Skins_GetColVar("AdaptiveCol", "Aggro", "B")
        overlayColours[5]["R"]=hbv_Skins_GetColVar("AdaptiveCol", "Highlight", "R")
        overlayColours[5]["G"]=hbv_Skins_GetColVar("AdaptiveCol", "Highlight", "G")
        overlayColours[5]["B"]=hbv_Skins_GetColVar("AdaptiveCol", "Highlight", "B")
        overlayColours[6]["R"]=hbv_Skins_GetColVar("AdaptiveCol", "Target", "R")
        overlayColours[6]["G"]=hbv_Skins_GetColVar("AdaptiveCol", "Target", "G")
        overlayColours[6]["B"]=hbv_Skins_GetColVar("AdaptiveCol", "Target", "B")
        overlayColours[7]["R"]=hbv_Skins_GetColVar("AdaptiveCol", "OOR", "R")
        overlayColours[7]["G"]=hbv_Skins_GetColVar("AdaptiveCol", "OOR", "G")
        overlayColours[7]["B"]=hbv_Skins_GetColVar("AdaptiveCol", "OOR", "B")
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
    elseif oType == 3 then -- Debuff
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
        if not hbv_Aux_GetOverlayBoolean("OVERLAYDEBUFF", button.frame) or button.status.range<0 or button.aura.debuff.colbar == 0 then
            nameLastOverlayType[button.id][3]=false
        end
    elseif hbv_Aux_GetOverlayBoolean("OVERLAYDEBUFF", button.frame) and button.status.range>-1 and button.aura.debuff.colbar>0 then
        nameLastOverlayType[button.id][3]=true
    end
    if nameLastOverlayType[button.id][4] then
        if not hbv_Aux_GetOverlayBoolean("OVERLAYAGGRO", button.frame) or button.aggro.status<=hbv_Skins_GetFrameVar("BarAggro", "ALERT", button.frame) then
            nameLastOverlayType[button.id][4]=false
        end
    elseif hbv_Aux_GetOverlayBoolean("OVERLAYAGGRO", button.frame) and button.aggro.status>hbv_Skins_GetFrameVar("BarAggro", "ALERT", button.frame) then
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
        if not hbv_Aux_GetOverlayBoolean("OVERLAYOOR", button.frame) or button.status.range>0 then
            nameLastOverlayType[button.id][7]=false
        end
    elseif hbv_Aux_GetOverlayBoolean("OVERLAYOOR", button.frame) and button.status.range<1 then
        nameLastOverlayType[button.id][7]=true
    end
    if nameLastOverlayType[button.id][8] then
        if not hbv_Aux_GetOverlayBoolean("OVERLAYBUFF", button.frame) or button.status.range<0 or button.aura.buff.colbar == 0 then
            nameLastOverlayType[button.id][8]=false
        end
    elseif hbv_Aux_GetOverlayBoolean("OVERLAYBUFF", button.frame) and button.status.range>-1 and button.aura.buff.colbar>0 then
        nameLastOverlayType[button.id][8]=true
    end

    if healthLastOverlayType[button.id][1] then
        healthLastOverlayType[button.id][1]=false
     end
    if healthLastOverlayType[button.id][2] then
        healthLastOverlayType[button.id][2]=false
    end
    if healthLastOverlayType[button.id][3] then
        if not hbv_Aux_GetOverlayBoolean("OVERLAYDEBUFF", button.frame) or button.status.range<0 or button.aura.debuff.colbar == 0 then
            healthLastOverlayType[button.id][3]=false
        end
    elseif hbv_Aux_GetOverlayBoolean("OVERLAYDEBUFF", button.frame) and button.status.range>-1 and button.aura.debuff.colbar>0 then
        healthLastOverlayType[button.id][3]=true
    end
    if healthLastOverlayType[button.id][4] then
        if not hbv_Aux_GetOverlayBoolean("OVERLAYAGGRO", button.frame) or button.aggro.status<=hbv_Skins_GetFrameVar("BarAggro", "ALERT", button.frame) then
            healthLastOverlayType[button.id][4]=false
        end
    elseif hbv_Aux_GetOverlayBoolean("OVERLAYAGGRO", button.frame) and button.aggro.status>hbv_Skins_GetFrameVar("BarAggro", "ALERT", button.frame) then
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
        if not hbv_Aux_GetOverlayBoolean("OVERLAYOOR", button.frame) or button.status.range>0 then
            healthLastOverlayType[button.id][7]=false
        end
    elseif hbv_Aux_GetOverlayBoolean("OVERLAYOOR", button.frame) and button.status.range<1 then
        healthLastOverlayType[button.id][7]=true
    end
    if healthLastOverlayType[button.id][8] then
        if not hbv_Aux_GetOverlayBoolean("OVERLAYBUFF", button.frame) or button.status.range<0 or button.aura.buff.colbar == 0 then
            healthLastOverlayType[button.id][8]=false
        end
    elseif hbv_Aux_GetOverlayBoolean("OVERLAYBUFF", button.frame) and button.status.range>-1 and button.aura.buff.colbar>0 then
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
    if hbv_Aux_GetOverlayBoolean("OVERLAYRECENTHEALS", frame) then
        HealBot_setAuxAssigns("NameOverlayRecentHeals", frame, true)
    end
    if hbv_Aux_GetOverlayBoolean("OVERLAYHEALTHDROP", frame) then
        HealBot_setAuxAssigns("NameOverlayHealthDrop", frame, true)
    end
    if hbv_Aux_GetOverlayBoolean("OVERLAYAGGRO", frame) then
        HealBot_Aggro_setAuxAssigns("NameOverlayAggro", frame, true)
    end
    if hbv_Aux_GetOverlayBoolean("OVERLAYDEBUFF", frame) then
        HealBot_Aura_setAuxAssigns("NameOverlayDebuff", frame, true)
    end
    if hbv_Aux_GetOverlayBoolean("OVERLAYHIGHLIGHT", frame) then
        HealBot_Action_setAuxAssigns("NameOverlayHighlight", frame, true)
    end
    if hbv_Aux_GetOverlayBoolean("OVERLAYTARGET", frame) then
        HealBot_setAuxAssigns("NameOverlayTarget", frame, true)
        HealBot_setLuVars("AuxTargetOverlayInUse", true)
    end
    if hbv_Aux_GetOverlayBoolean("OVERLAYOOR", frame) then
        HealBot_setAuxAssigns("NameOverlayOOR", frame, true)
    end
    if hbv_Aux_GetOverlayBoolean("OVERLAYBUFF", frame) then
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
        elseif hbv_Aux_GetBarVar("COLOUR", button.frame, id) == 1 then
            button.aux[id]["R"]=0
            button.aux[id]["G"]=0
            button.aux[id]["B"]=0.1
        end
        if hbv_Aux_GetBarTextVar("COLTYPE", button.frame, id) == 1 then
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
    if hbv_Aux_GetOverlayBoolean("OVERLAYRECENTHEALS", frame) then
        HealBot_setAuxAssigns("HealthOverlayRecentHeals", frame, true)
    end
    if hbv_Aux_GetOverlayBoolean("OVERLAYHEALTHDROP", frame) then
        HealBot_setAuxAssigns("HealthOverlayHealthDrop", frame, true)
    end
    if hbv_Aux_GetOverlayBoolean("OVERLAYAGGRO", frame) then
        HealBot_Aggro_setAuxAssigns("HealthOverlayAggro", frame, true)
    end
    if hbv_Aux_GetOverlayBoolean("OVERLAYDEBUFF", frame) then
        HealBot_Aura_setAuxAssigns("HealthOverlayDebuff", frame, true)
    end
    if hbv_Aux_GetOverlayBoolean("OVERLAYHIGHLIGHT", frame) then
        HealBot_Action_setAuxAssigns("HealthOverlayHighlight", frame, true)
    end
    if hbv_Aux_GetOverlayBoolean("OVERLAYTARGET", frame) then
        HealBot_setAuxAssigns("HealthOverlayTarget", frame, true)
    end
    if hbv_Aux_GetOverlayBoolean("OVERLAYOOR", frame) then
        HealBot_setAuxAssigns("HealthOverlayOOR", frame, true)
    end
    if hbv_Aux_GetOverlayBoolean("OVERLAYBUFF", frame) then
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
        elseif hbv_Aux_GetBarVar("COLOUR", button.frame, id) == 1 then
            button.aux[id]["R"]=0
            button.aux[id]["G"]=0
            button.aux[id]["B"]=0.1
        end
        if hbv_Aux_GetBarTextVar("COLTYPE", button.frame, id) == 1 then
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

local function HealBot_Aux_UpdateStateBarById(button, id)
    if button.status.current<HealBot_Unit_Status["DC"] then
        if hbv_Aux_GetBarVar("COLOUR", button.frame, id) == 1 then
            button.aux[id]["R"]=0
            button.aux[id]["G"]=0
            button.aux[id]["B"]=0.1
        end
        if hbv_Aux_GetBarTextVar("COLTYPE", button.frame, id) == 1 then
            button.auxtxt[id]["R"]=0.9
            button.auxtxt[id]["G"]=0.9
            button.auxtxt[id]["B"]=0.9
        end
        HealBot_Aux_setBar(button, id, 1000, false, button.text.tag)
    else
        HealBot_Aux_clearBar(button, id)
    end
end

function HealBot_Aux_UpdateStateBar(button)
      --HealBot_setCall("HealBot_Aux_UpdateStateBar", button)
    for id in pairs(hbAuxStateAssigned[button.frame]) do
        HealBot_Aux_UpdateStateBarById(button, id)
    end
end

function HealBot_Aux_ClearStateBar(button)
      --HealBot_setCall("HealBot_Aux_ClearStateBar", button)
    for id in pairs(hbAuxStateAssigned[button.frame]) do
        HealBot_Aux_clearBar(button, id)
    end
end

-- Update by Type

function HealBot_Aux_UpdateAuxByTypeById(button, frame, id)
    if hbAuxNameAssigned[frame][id] then
        HealBot_Aux_DoUpdateNameOverLay(button)
    elseif hbAuxHealthAssigned[frame][id] then
        HealBot_Aux_DoUpdateHealthOverLay(button)
    elseif hbAuxStateAssigned[frame][id] then
        HealBot_Aux_UpdateStateBarById(button, id)
    elseif hbAuxPowerAssigned[frame][id] then
        HealBot_Aux_setPowerBarsById(button, id)
    elseif hbAuxBuffAssigned[frame][id] then
        HealBot_Aux_UpdateAuraBuffBarsById(button, id)
    elseif hbAuxDebuffAssigned[frame][id] then
        HealBot_Aux_UpdateAuraDebuffBarsById(button, id)
    elseif hbAuxTargetAssigned[frame][id] then
        HealBot_Aux_UpdateTargetBarById(button, id)
    elseif hbAuxOORAssigned[frame][id] then
        HealBot_Aux_UpdateOORBarById(button, id)
    elseif hbAuxInRangeAssigned[frame][id] then
        HealBot_Aux_UpdateInRangeBarById(button, id)
    elseif hbAuxOverHealAssigned[frame][id] then
        HealBot_Aux_UpdateOverHealBarById(button, id)
    elseif hbAuxHealInAssigned[frame][id] then
        HealBot_Aux_UpdateHealInBarById(button, id)
    elseif hbAuxAbsorbAssigned[frame][id] then
        HealBot_Aux_UpdateAbsorbBarById(button, id)
    elseif hbAuxThreatAssigned[frame][id] then
        HealBot_Aux_UpdateThreatBarById(button, id)
    elseif hbAuxTotalHealAbsorbsAssigned[frame][id] then
        HealBot_Aux_UpdateTotalHealAbsorbsBarById(button, id)
    end
end

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

function HealBot_Aux_ResetTextByTypeById(button, id)
      --HealBot_setCall("HealBot_Aux_ResetTextByTypeById", button)
    if hbv_Aux_GetBarBoolean("TEXT", button.frame, id) then
        if hbAuxNameAssigned[button.frame][id] then
            HealBot_Aux_setBar(button, id, 1000, false, button.text.nameonly.." ", nil, nil, true)
            HealBot_Aux_DoUpdateNameOverLay(button)
        elseif hbAuxHealthAssigned[button.frame][id] then
            HealBot_Aux_setBar(button, id, 1000, false, button.text.health.." ", nil, nil, true)
            HealBot_Aux_DoUpdateHealthOverLay(button)
        elseif hbAuxStateAssigned[button.frame][id] then
            HealBot_Aux_setBar(button, id, 1000, false, button.text.tag.." ")
            HealBot_Aux_setBar(button, id, 1000, false, button.text.tag)
        elseif hbv_Aux_GetBarBoolean("TEXT", button.frame, id) then
            if hbAuxPowerAssigned[button.frame][id] then
                HealBot_Aux_setBar(button, id, button.mana.pctc, true, " ")
                HealBot_Aux_setPowerBarsById(button, id)
            elseif button.aura.buff.missingbuff and hbAuxBuffAssigned[button.frame][id] then
                HealBot_Aux_setBar(button, id, 1000, false, button.aura.buff.missingbuff.." ")
                HealBot_Aux_UpdateAuraBuffBarsById(button, id)
            elseif button.aura.debuff.name and hbAuxDebuffAssigned[button.frame][id] then
                HealBot_Aux_setBar(button, id, 1000, false, button.aura.debuff.name.." ")
                HealBot_Aux_UpdateAuraDebuffBarsById(button, id)
            elseif hbAuxAbsorbAssigned[button.frame][id] then
                HealBot_Aux_SetAuxHlth10(button)
                HealBot_Aux_setBar(button, id, hbAuxHlth10, true, HealBot_Text_shortHealTxt(button.health.auxabsorbs+1, button.frame))
                HealBot_Aux_UpdateAbsorbBarById(button, id)
            elseif hbAuxHealInAssigned[button.frame][id] then
                HealBot_Aux_SetAuxHealIn10(button)
                HealBot_Aux_setBar(button, id, hbAuxHealIn10, true, HealBot_Text_shortHealTxt(button.health.auxincoming+1, button.frame))
                HealBot_Aux_UpdateHealInBarById(button, id)
            elseif hbAuxTotalHealAbsorbsAssigned[button.frame][id] then
                HealBot_Aux_SetAuxTotalHeal10(button)
                HealBot_Aux_setBar(button, id, hbAuxTotalHeal10, true, HealBot_Text_shortHealTxt(button.health.healabsorbs+1, button.frame))
                HealBot_Aux_UpdateTotalHealAbsorbsBarById(button, id)
            elseif hbAuxOverHealAssigned[button.frame][id] then
                HealBot_Aux_SetohValue(button)
                HealBot_Aux_setBar(button, id, ohValue, true, HealBot_Text_shortHealTxt(button.health.overheal+1, button.frame))
                HealBot_Aux_UpdateOverHealBarById(button, id)
            end
        end
    end
end

function HealBot_Aux_ResetByTypeById(button)
      --HealBot_setCall("HealBot_Aux_ResetByTypeById", button)
    for x=1,9 do
        HealBot_Aux_clearBar(button, x)
        if hbAuxPowerAssigned[button.frame][x] then
            HealBot_Aux_setPowerBarsById(button, x)
        elseif button.aura.buff.missingbuff and hbAuxBuffAssigned[button.frame][x] then
            HealBot_Aux_UpdateAuraBuffBarsById(button, x)
        elseif button.aura.debuff.name and hbAuxDebuffAssigned[button.frame][x] then
            HealBot_Aux_UpdateAuraDebuffBarsById(button, x)
        elseif hbAuxAbsorbAssigned[button.frame][x] then
            HealBot_Aux_UpdateAbsorbBarById(button, x)
        elseif hbAuxHealInAssigned[button.frame][x] then
            HealBot_Aux_UpdateHealInBarById(button, x)
        elseif hbAuxTotalHealAbsorbsAssigned[button.frame][x] then
            HealBot_Aux_UpdateTotalHealAbsorbsBarById(button, x)
        elseif hbAuxOverHealAssigned[button.frame][x] then
            HealBot_Aux_UpdateOverHealBarById(button, x)
        end
        HealBot_Aux_ResetTextByTypeById(button, x)
    end
end

local auxTestText, auxTestCol, auxTestNonTextBarSize, auxTestNonTextTxtSize="", false, 0, 0
local customDebuffPriority=hbv_GetStatic("cDebuff")
local function HealBot_Aux_SetTestButton(button)
      --HealBot_setCall("HealBot_Aux_SetTestButton", button)
    for x=1,9 do
        if hbv_Aux_GetBarVar("USE", button.frame, x)>1 then
            button.gref.auxtxt[x]:SetText("")
            button.gref.aux[x]:SetValue(1000)
            auxTestCol=false
            if hbv_Aux_GetBarVar("COLOUR", button.frame, x) == 2 then
                button.gref.aux[x]:SetStatusBarColor(button.text.r,button.text.g,button.text.b,1)
            elseif hbv_Aux_GetBarVar("COLOUR", button.frame, x) == 3 then
                if not hbCustomRoleCols[button.roletxt] then button.roletxt="DAMAGER" end
                button.gref.aux[x]:SetStatusBarColor(hbCustomRoleCols[button.roletxt].r,hbCustomRoleCols[button.roletxt].g,hbCustomRoleCols[button.roletxt].b,1)
            elseif hbv_Aux_GetBarVar("COLOUR", button.frame, x) == 4 then
                button.gref.aux[x]:SetStatusBarColor(hbv_Aux_GetBarVar("R", button.frame, x),
                                                     hbv_Aux_GetBarVar("G", button.frame, x),
                                                     hbv_Aux_GetBarVar("B", button.frame, x), 1)
            end
            if hbv_Aux_GetBarVar("USE", button.frame, x) == 2 then
                if hbv_Aux_GetBarVar("COLOUR", button.frame, x) == 1 then
                    if hbv_Skins_GetFrameVar("BarIACol", "AC", button.frame) == 4 then
                        if button.status.hostile then
                            button.gref.aux[x]:SetStatusBarColor(hbv_Skins_GetFrameVar("BarIACol", "ARE", button.frame),
                                                                 hbv_Skins_GetFrameVar("BarIACol", "AGE", button.frame),
                                                                 hbv_Skins_GetFrameVar("BarIACol", "ABE", button.frame), 1)
                        else
                            button.gref.aux[x]:SetStatusBarColor(hbv_Skins_GetFrameVar("BarIACol", "AR", button.frame),
                                                                 hbv_Skins_GetFrameVar("BarIACol", "AG", button.frame),
                                                                 hbv_Skins_GetFrameVar("BarIACol", "AB", button.frame), 1)
                        end
                    elseif hbv_Skins_GetFrameVar("BarIACol", "AC", button.frame) == 5 then
                        button.gref.aux[x]:SetStatusBarColor(button.text.r,button.text.g,button.text.b, 1)
                    else
                        button.gref.aux[x]:SetStatusBarColor(0,1,0,1)
                    end
                end
                if hbv_Aux_GetBarTextVar("COLTYPE", button.frame, x) == 1 then
                    if hbv_Skins_GetFrameVar("BarIACol", "AC", button.frame) == 4 then
                        if button.status.hostile then
                            HealBot_Aux_AutoTextColour(button, x, hbv_Skins_GetFrameVar("BarIACol", "ARE", button.frame),
                                                                  hbv_Skins_GetFrameVar("BarIACol", "AGE", button.frame),
                                                                  hbv_Skins_GetFrameVar("BarIACol", "ABE", button.frame), 0.25)
                        else
                            HealBot_Aux_AutoTextColour(button, x, hbv_Skins_GetFrameVar("BarIACol", "AR", button.frame),
                                                                  hbv_Skins_GetFrameVar("BarIACol", "AG", button.frame),
                                                                  hbv_Skins_GetFrameVar("BarIACol", "AB", button.frame), 0.25)
                        end
                        button.gref.auxtxt[x]:SetTextColor(button.auxtxt[x]["R"], button.auxtxt[x]["G"], button.auxtxt[x]["B"],1)
                    elseif hbv_Skins_GetFrameVar("BarIACol", "AC", button.frame) == 5 then
                        HealBot_Aux_AutoTextColour(button, x, button.text.r, button.text.g, button.text.b, 0.25)
                        button.gref.auxtxt[x]:SetTextColor(button.auxtxt[x]["R"], button.auxtxt[x]["G"], button.auxtxt[x]["B"],1)
                    else
                        button.gref.auxtxt[x]:SetTextColor(0.2,1,0.2,1)
                    end
                end
                auxTestCol=true
                auxTestText=HEALBOT_classicABSORBHOTUP
            elseif hbv_Aux_GetBarVar("USE", button.frame, x) == 3 then
                if hbv_Aux_GetBarVar("COLOUR", button.frame, x) == 1 then
                    if hbv_Skins_GetFrameVar("BarIACol", "IC", button.frame) == 4 then
                        if button.status.hostile then
                            button.gref.aux[x]:SetStatusBarColor(hbv_Skins_GetFrameVar("BarIACol", "IRE", button.frame),
                                                                 hbv_Skins_GetFrameVar("BarIACol", "IGE", button.frame),
                                                                 hbv_Skins_GetFrameVar("BarIACol", "IBE", button.frame), 1)
                        else
                            button.gref.aux[x]:SetStatusBarColor(hbv_Skins_GetFrameVar("BarIACol", "IR", button.frame),
                                                                 hbv_Skins_GetFrameVar("BarIACol", "IG", button.frame),
                                                                 hbv_Skins_GetFrameVar("BarIACol", "IB", button.frame), 1)
                        end
                    elseif hbv_Skins_GetFrameVar("BarIACol", "IC", button.frame) == 5 then
                        button.gref.aux[x]:SetStatusBarColor(button.text.r,button.text.g,button.text.b, 1)
                    else
                        button.gref.aux[x]:SetStatusBarColor(0,1,0,1)
                    end
                end
                if hbv_Aux_GetBarTextVar("COLTYPE", button.frame, x) == 1 then
                    if hbv_Skins_GetFrameVar("BarIACol", "IC", button.frame) == 4 then
                        if button.status.hostile then
                            HealBot_Aux_AutoTextColour(button, x, hbv_Skins_GetFrameVar("BarIACol", "IRE", button.frame),
                                                                  hbv_Skins_GetFrameVar("BarIACol", "IGE", button.frame),
                                                                  hbv_Skins_GetFrameVar("BarIACol", "IBE", button.frame), 0.25)
                        else
                            HealBot_Aux_AutoTextColour(button, x, hbv_Skins_GetFrameVar("BarIACol", "IR", button.frame),
                                                                  hbv_Skins_GetFrameVar("BarIACol", "IG", button.frame),
                                                                  hbv_Skins_GetFrameVar("BarIACol", "IB", button.frame), 0.25)
                        end
                        button.gref.auxtxt[x]:SetTextColor(button.auxtxt[x]["R"], button.auxtxt[x]["G"], button.auxtxt[x]["B"],1)
                    elseif hbv_Skins_GetFrameVar("BarIACol", "IC", button.frame) == 5 then
                        HealBot_Aux_AutoTextColour(button, x, button.text.r, button.text.g, button.text.b, 0.25)
                        button.gref.auxtxt[x]:SetTextColor(button.auxtxt[x]["R"], button.auxtxt[x]["G"], button.auxtxt[x]["B"],1)
                    else
                        button.gref.auxtxt[x]:SetTextColor(0.2,1,0.2,1)
                    end
                end
                auxTestCol=true
                auxTestText=HEALBOT_OPTIONS_INCHEAL
            elseif hbv_Aux_GetBarVar("USE", button.frame, x) == 4 then
                if hbv_Aux_GetBarVar("COLOUR", button.frame, x) == 1 then
                    button.gref.aux[x]:SetStatusBarColor(button.mana.r,button.mana.g,button.mana.b,1)
                end
                if hbv_Aux_GetBarTextVar("COLTYPE", button.frame, x) == 1 then
                    HealBot_Aux_AutoTextColour(button, x, button.mana.r, button.mana.g, button.mana.b, 0.58)
                    button.gref.auxtxt[x]:SetTextColor(button.auxtxt[x]["R"], button.auxtxt[x]["G"], button.auxtxt[x]["B"],1)
                end
                auxTestCol=true
                auxTestText=HEALBOT_OPTIONS_POWER
            elseif hbv_Aux_GetBarVar("USE", button.frame, x) == 5 then
                if button.frame<10 then
                    auxTestText=HEALBOT_OPTIONS_TAB_AGGRO
                    if hbv_Aux_GetBarVar("COLOUR", button.frame, x) == 1 then
                        button.gref.aux[x]:SetStatusBarColor(1,0,0,1)
                    end
                else
                    auxTestText=HEALBOT_OPTIONS_CASTBAR
                    if hbv_Aux_GetBarVar("COLOUR", button.frame, x) == 1 then
                        button.gref.aux[x]:SetStatusBarColor(0.8,0.7,0.1,1)
                    end
                    if hbv_Aux_GetBarTextVar("COLTYPE", button.frame, x) == 1 then
                        button.gref.auxtxt[x]:SetTextColor(1,1,1,1)
                    end
                    auxTestCol=true
                end
            elseif hbv_Aux_GetBarVar("USE", button.frame, x) == 6 then
                if button.frame<10 then
                    auxTestText=HEALBOT_WORD_THREAT
                    if hbv_Aux_GetBarVar("COLOUR", button.frame, x) == 1 then
                        button.gref.aux[x]:SetStatusBarColor(1,1,0.2,1)
                    end
                    if hbv_Aux_GetBarTextVar("COLTYPE", button.frame, x) == 1 then
                        button.gref.auxtxt[x]:SetTextColor(1,1,1,1)
                    end
                    auxTestCol=true
                else
                    auxTestText=HEALBOT_OUTOFRANGE_LABEL
                    if hbv_Aux_GetBarVar("COLOUR", button.frame, x) == 1 then
                        button.gref.aux[x]:SetStatusBarColor(0,0,0,1)
                    end
                end
            elseif hbv_Aux_GetBarVar("USE", button.frame, x) == 7 then
                if button.frame<10 then
                    auxTestText=HEALBOT_WORD_OVERHEALS
                    if hbv_Aux_GetBarVar("COLOUR", button.frame, x) == 1 then
                        button.gref.aux[x]:SetStatusBarColor(1,0.2,0.2,1)
                    end
                    if hbv_Aux_GetBarTextVar("COLTYPE", button.frame, x) == 1 then
                        button.gref.auxtxt[x]:SetTextColor(1,1,1,1)
                    end
                    auxTestCol=true
                else
                    auxTestText=HEALBOT_INRANGE
                    if hbv_Aux_GetBarVar("COLOUR", button.frame, x) == 1 then
                        button.gref.aux[x]:SetStatusBarColor(1,1,1,1)
                    end
                end
            elseif hbv_Aux_GetBarVar("USE", button.frame, x) == 8 then
                if button.frame<10 then
                    auxTestText=HEALBOT_OPTION_HIGHLIGHTACTIVEBAR
                    if hbv_Aux_GetBarVar("COLOUR", button.frame, x) == 1 then
                        button.gref.aux[x]:SetStatusBarColor(0.4,1,1,1)
                    end
                else
                    auxTestText=HEALBOT_OPTION_HEALTHDROP
                    if hbv_Aux_GetBarVar("COLOUR", button.frame, x) == 1 then
                        button.gref.aux[x]:SetStatusBarColor(1,0.58,0.2,1)
                    end
                end
            elseif hbv_Aux_GetBarVar("USE", button.frame, x) == 9 then
                if button.frame<10 then
                    auxTestText=HEALBOT_OPTIONS_TAB_BUFFS
                    if hbv_Aux_GetBarVar("COLOUR", button.frame, x) == 1 then
                        button.gref.aux[x]:SetStatusBarColor(1,1,1,1)
                    end
                    if hbv_Aux_GetBarTextVar("COLTYPE", button.frame, x) == 1 then
                        button.gref.auxtxt[x]:SetTextColor(1,1,1,1)
                    end
                    auxTestCol=true
                else
                    auxTestText=HEALBOT_OPTIONS_TAB_NAMETEXT
                    if hbv_Aux_GetBarVar("COLOUR", button.frame, x) == 1 then
                        button.gref.aux[x]:SetStatusBarColor(0,0,0.1,1)
                    end
                    if hbv_Aux_GetBarTextVar("COLTYPE", button.frame, x) == 1 then
                        button.gref.auxtxt[x]:SetTextColor(0.9,0.9,0.9,1)
                    end
                    auxTestCol=true
                end
            elseif hbv_Aux_GetBarVar("USE", button.frame, x) == 10 then
                if button.frame<10 then
                    auxTestText=HEALBOT_OPTIONS_TAB_DEBUFFS
                    if hbv_Aux_GetBarVar("COLOUR", button.frame, x) == 1 then
                        button.gref.aux[x]:SetStatusBarColor(HealBot_Globals.CDCBarColour[customDebuffPriority].R,
                                                             HealBot_Globals.CDCBarColour[customDebuffPriority].G,
                                                             HealBot_Globals.CDCBarColour[customDebuffPriority].B,1)
                    end
                    if hbv_Aux_GetBarTextVar("COLTYPE", button.frame, x) == 1 then
                        HealBot_Aux_AutoTextColour(button, x, HealBot_Globals.CDCBarColour[customDebuffPriority].R, HealBot_Globals.CDCBarColour[customDebuffPriority].G, HealBot_Globals.CDCBarColour[customDebuffPriority].B, 0.4)
                        button.gref.auxtxt[x]:SetTextColor(button.auxtxt[x]["R"], button.auxtxt[x]["G"], button.auxtxt[x]["B"],1)
                    end
                    auxTestCol=true
                else
                    auxTestText=HEALBOT_WORD_HEALTH
                    if hbv_Aux_GetBarVar("COLOUR", button.frame, x) == 1 then
                        button.gref.aux[x]:SetStatusBarColor(0,0,0.1,1)
                    end
                    if hbv_Aux_GetBarTextVar("COLTYPE", button.frame, x) == 1 then
                        button.gref.auxtxt[x]:SetTextColor(0.9,0.9,0.9,1)
                    end
                    auxTestCol=true
                end
            elseif hbv_Aux_GetBarVar("USE", button.frame, x) == 11 then
                if button.frame<10 then
                    auxTestText=HEALBOT_OPTIONS_CASTBAR
                    if hbv_Aux_GetBarVar("COLOUR", button.frame, x) == 1 then
                        button.gref.aux[x]:SetStatusBarColor(0.8,0.7,0.1,1)
                    end
                    if hbv_Aux_GetBarTextVar("COLTYPE", button.frame, x) == 1 then
                        button.gref.auxtxt[x]:SetTextColor(1,1,1,1)
                    end
                    auxTestCol=true
                else
                    auxTestText=HEALBOT_OPTIONS_TAB_STATETEXT
                    if hbv_Aux_GetBarVar("COLOUR", button.frame, x) == 1 then
                        button.gref.aux[x]:SetStatusBarColor(0,0,0.1,1)
                    end
                    if hbv_Aux_GetBarTextVar("COLTYPE", button.frame, x) == 1 then
                        button.gref.auxtxt[x]:SetTextColor(0.9,0.9,0.9,1)
                    end
                    auxTestCol=true
                end
            elseif hbv_Aux_GetBarVar("USE", button.frame, x) == 12 then
                if hbv_Aux_GetBarVar("COLOUR", button.frame, x) == 1 then
                    button.gref.aux[x]:SetStatusBarColor(1,0.9,0.2,1)
                end
                auxTestText=HEALBOT_OPTIONS_TARGETHEALS
            elseif hbv_Aux_GetBarVar("USE", button.frame, x) == 13 then
                if hbv_Aux_GetBarVar("COLOUR", button.frame, x) == 1 then
                    button.gref.aux[x]:SetStatusBarColor(0,0,0,1)
                end
                auxTestText=HEALBOT_OUTOFRANGE_LABEL
            elseif hbv_Aux_GetBarVar("USE", button.frame, x) == 14 then
                if hbv_Aux_GetBarVar("COLOUR", button.frame, x) == 1 then
                    button.gref.aux[x]:SetStatusBarColor(1,1,1,1)
                end
                auxTestText=HEALBOT_INRANGE
            elseif hbv_Aux_GetBarVar("USE", button.frame, x) == 15 then
                if hbv_Aux_GetBarVar("COLOUR", button.frame, x) == 1 then
                    button.gref.aux[x]:SetStatusBarColor(0.1,1,0.2,1)
                end
                auxTestText=HEALBOT_RECENTHEALS
            elseif hbv_Aux_GetBarVar("USE", button.frame, x) == 16 then
                if hbv_Aux_GetBarVar("COLOUR", button.frame, x) == 1 then
                    button.gref.aux[x]:SetStatusBarColor(0.8,0.1,0.1,1)
                end
                if hbv_Aux_GetBarTextVar("COLTYPE", button.frame, x) == 1 then
                    button.gref.auxtxt[x]:SetTextColor(1,0.4,0.4,1)
                end
                auxTestCol=true
                auxTestText=HEALBOT_WORD_RESURRECTION
            elseif HEALBOT_GAME_VERSION<4 then
                if hbv_Aux_GetBarVar("USE", button.frame, x) == 17 then
                    if hbv_Aux_GetBarVar("COLOUR", button.frame, x) == 1 then
                        button.gref.aux[x]:SetStatusBarColor(1,0.58,0.2,1)
                    end
                    auxTestText=HEALBOT_OPTION_HEALTHDROP
                elseif hbv_Aux_GetBarVar("USE", button.frame, x) == 18 then
                    if hbv_Aux_GetBarVar("COLOUR", button.frame, x) == 1 then
                        button.gref.aux[x]:SetStatusBarColor(0,0,0.1,1)
                    end
                    if hbv_Aux_GetBarTextVar("COLTYPE", button.frame, x) == 1 then
                        button.gref.auxtxt[x]:SetTextColor(0.9,0.9,0.9,1)
                    end
                    auxTestCol=true
                    auxTestText=HEALBOT_OPTIONS_TAB_NAMETEXT
                elseif hbv_Aux_GetBarVar("USE", button.frame, x) == 19 then
                    if hbv_Aux_GetBarVar("COLOUR", button.frame, x) == 1 then
                        button.gref.aux[x]:SetStatusBarColor(0,0,0.1,1)
                    end
                    if hbv_Aux_GetBarTextVar("COLTYPE", button.frame, x) == 1 then
                        button.gref.auxtxt[x]:SetTextColor(0.9,0.9,0.9,1)
                    end
                    auxTestCol=true
                    auxTestText=HEALBOT_WORD_HEALTH
                elseif hbv_Aux_GetBarVar("USE", button.frame, x) == 20 then
                    if hbv_Aux_GetBarVar("COLOUR", button.frame, x) == 1 then
                        button.gref.aux[x]:SetStatusBarColor(0,0,0.1,1)
                    end
                    if hbv_Aux_GetBarTextVar("COLTYPE", button.frame, x) == 1 then
                        button.gref.auxtxt[x]:SetTextColor(0.9,0.9,0.9,1)
                    end
                    auxTestCol=true
                    auxTestText=HEALBOT_OPTIONS_TAB_STATETEXT
                end
            else
                if hbv_Aux_GetBarVar("USE", button.frame, x) == 17 then
                    if hbv_Aux_GetBarVar("COLOUR", button.frame, x) == 1 then
                        button.gref.aux[x]:SetStatusBarColor(hbv_Skins_GetFrameVar("BarTextCol", "NSCR", button.frame),
                                                             hbv_Skins_GetFrameVar("BarTextCol", "NSCG", button.frame),
                                                             hbv_Skins_GetFrameVar("BarTextCol", "NSCB", button.frame),1)
                    end
                    if hbv_Aux_GetBarTextVar("COLTYPE", button.frame, x) == 1 then
                        HealBot_Aux_AutoTextColour(button, x, hbv_Skins_GetFrameVar("BarTextCol", "NSCR", button.frame), hbv_Skins_GetFrameVar("BarTextCol", "NSCG", button.frame), hbv_Skins_GetFrameVar("BarTextCol", "NSCB", button.frame), 0.5)
                        button.gref.auxtxt[x]:SetTextColor(button.auxtxt[x]["R"], button.auxtxt[x]["G"], button.auxtxt[x]["B"],1)
                    end
                    auxTestCol=true
                    auxTestText=HEALBOT_WORD_SUMMONS
                elseif hbv_Aux_GetBarVar("USE", button.frame, x) == 18 then
                    if hbv_Aux_GetBarVar("COLOUR", button.frame, x) == 1 then
                        button.gref.aux[x]:SetStatusBarColor(1,0.58,0.2,1)
                    end
                    auxTestText=HEALBOT_OPTION_HEALTHDROP
                elseif hbv_Aux_GetBarVar("USE", button.frame, x) == 19 then
                    if hbv_Aux_GetBarVar("COLOUR", button.frame, x) == 1 then
                        button.gref.aux[x]:SetStatusBarColor(0,0,0.1,1)
                    end
                    if hbv_Aux_GetBarTextVar("COLTYPE", button.frame, x) == 1 then
                        button.gref.auxtxt[x]:SetTextColor(0.9,0.9,0.9,1)
                    end
                    auxTestCol=true
                    auxTestText=HEALBOT_OPTIONS_TAB_NAMETEXT
                elseif hbv_Aux_GetBarVar("USE", button.frame, x) == 20 then
                    if hbv_Aux_GetBarVar("COLOUR", button.frame, x) == 1 then
                        button.gref.aux[x]:SetStatusBarColor(0,0,0.1,1)
                    end
                    if hbv_Aux_GetBarTextVar("COLTYPE", button.frame, x) == 1 then
                        button.gref.auxtxt[x]:SetTextColor(0.9,0.9,0.9,1)
                    end
                    auxTestCol=true
                    auxTestText=HEALBOT_WORD_HEALTH
                elseif hbv_Aux_GetBarVar("USE", button.frame, x) == 21 then
                    if hbv_Aux_GetBarVar("COLOUR", button.frame, x) == 1 then
                        button.gref.aux[x]:SetStatusBarColor(0,0,0.1,1)
                    end
                    if hbv_Aux_GetBarTextVar("COLTYPE", button.frame, x) == 1 then
                        button.gref.auxtxt[x]:SetTextColor(0.9,0.9,0.9,1)
                    end
                    auxTestCol=true
                    auxTestText=HEALBOT_OPTIONS_TAB_STATETEXT
                elseif hbv_Aux_GetBarVar("USE", button.frame, x) == 22 then
                    button.gref.aux[x]:SetStatusBarColor(0.7,0.2,0.9,1)
                    button.gref.auxtxt[x]:SetTextColor(1,1,1,1)
                    auxTestCol=true
                    auxTestText=HEALBOT_OPTIONS_TOTALHEALABSORBS
                end
            end
            if hbv_Aux_GetBarVar("ANCHOR", button.frame, x)>2 and hbv_Aux_GetBarVar("ANCHOR", button.frame, x)<5 then
                auxTestText=""
            elseif auxTestCol then
                if hbv_Aux_GetBarTextVar("COLTYPE", button.frame, x) == 2 then
                    button.gref.auxtxt[x]:SetTextColor(button.text.r,button.text.g,button.text.b,1)
                elseif hbv_Aux_GetBarTextVar("COLTYPE", button.frame, x) == 3 then
                    button.gref.auxtxt[x]:SetTextColor(hbv_Aux_GetBarTextVar("COLR", button.frame, x),
                                                       hbv_Aux_GetBarTextVar("COLG", button.frame, x),
                                                       hbv_Aux_GetBarTextVar("COLB", button.frame, x),1)
                end
            else
                auxTestNonTextBarSize=ceil(hbv_Aux_GetBarVar("DEPTH", button.frame, x)*hbv_Skins_GetFrameVar("Frame", "SCALE", button.frame))
                auxTestNonTextTxtSize=ceil(hbv_Aux_GetBarTextVar("HEIGHT", button.frame, x)*hbv_Skins_GetFrameVar("Frame", "SCALE", button.frame))
                if auxTestNonTextTxtSize>auxTestNonTextBarSize then
                    if auxTestNonTextBarSize<7 then
                        auxTestNonTextTxtSize=7
                    else
                        auxTestNonTextTxtSize=auxTestNonTextBarSize
                    end
                    HealBot_Media_UpdateFont(button.gref.auxtxt[x],
                                             hbv_Aux_GetBarTextVar("FONT", button.frame, x),
                                             auxTestNonTextTxtSize,
                                             hbv_Aux_GetBarTextVar("OUTLINE", button.frame, x),
                                             "Aux_SetTestButton - AuxBarText")
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
