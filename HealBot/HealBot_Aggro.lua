local HealBot_Aggro_rCalls={}
local xButton, pButton, aButton=nil, nil, nil
local HealBot_Aggro_AuxAssigns={}
HealBot_Aggro_AuxAssigns["NameOverlayAggro"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
HealBot_Aggro_AuxAssigns["HealthOverlayAggro"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
local HealBot_Aggro_luVars={}
HealBot_Aggro_luVars["pluginThreat"]=false

function HealBot_Aggro_setLuVars(vName, vValue)
      --HealBot_setCall("HealBot_Aggro_setLuVars - "..vName)
    HealBot_Aggro_luVars[vName]=vValue
end

function HealBot_Aggro_retLuVars(vName)
      --HealBot_setCall("HealBot_Aggro_retLuVars - "..vName)
    return HealBot_Aggro_luVars[vName]
end

function HealBot_Aggro_setAuxAssigns(vName, frame, vValue)
      --HealBot_setCall("HealBot_Aggro_setAuxAssigns - "..vName)
    HealBot_Aggro_AuxAssigns[vName][frame]=vValue
end

function HealBot_Aggro_IndicatorClear(button)
      --HealBot_setCall("HealBot_Aggro_IndicatorClear", button)
    button.aggro.ind=0
    button.gref.indicator.aggro["Iconal1"]:SetAlpha(0)
    button.gref.indicator.aggro["Iconal2"]:SetAlpha(0)
    button.gref.indicator.aggro["Iconal3"]:SetAlpha(0)
    button.gref.indicator.aggro["Iconar1"]:SetAlpha(0)
    button.gref.indicator.aggro["Iconar2"]:SetAlpha(0)
    button.gref.indicator.aggro["Iconar3"]:SetAlpha(0)
end

function HealBot_Aggro_HazardClear(button)
      --HealBot_setCall("HealBot_Aggro_HazardClear", button)
    HealBot_Action_DisableBorderHazardType(button, "AGGRO")
end

function HealBot_Aggro_IndicatorUpdate(button)
      --HealBot_setCall("HealBot_Aggro_IndicatorUpdate", button)
    if hbv_Skins_GetFrameBoolean("BarAggro", "SHOW", button.frame) and button.status.current<HealBot_Unit_Status["DEAD"] and button.frame<10 then
        if hbv_Skins_GetFrameBoolean("BarAggro", "SHOWIND", button.frame) and button.aggro.status>=hbv_Skins_GetFrameVar("BarAggro", "ALERTIND", button.frame) then
            local indAlpha=HealBot_Action_BarColourAlpha(button, 1, 1)
            if button.aggro.status == 1 then
                if button.aggro.ind~=1 then
                    button.aggro.ind=1
                    button.gref.indicator.aggro["Iconal1"]:SetAlpha(indAlpha)
                    button.gref.indicator.aggro["Iconal2"]:SetAlpha(0)
                    button.gref.indicator.aggro["Iconal3"]:SetAlpha(0)
                    button.gref.indicator.aggro["Iconar1"]:SetAlpha(indAlpha)
                    button.gref.indicator.aggro["Iconar2"]:SetAlpha(0)
                    button.gref.indicator.aggro["Iconar3"]:SetAlpha(0)
                end
            elseif button.aggro.status == 2 then
                if button.aggro.ind~=2 then
                    button.aggro.ind=2
                    button.gref.indicator.aggro["Iconal1"]:SetAlpha(indAlpha)
                    button.gref.indicator.aggro["Iconal2"]:SetAlpha(indAlpha)
                    button.gref.indicator.aggro["Iconal3"]:SetAlpha(0)
                    button.gref.indicator.aggro["Iconar1"]:SetAlpha(indAlpha)
                    button.gref.indicator.aggro["Iconar2"]:SetAlpha(indAlpha)
                    button.gref.indicator.aggro["Iconar3"]:SetAlpha(0)
                end
            elseif button.aggro.status == 3 then
                if button.aggro.ind~=3 then
                    button.aggro.ind=3
                    button.gref.indicator.aggro["Iconal1"]:SetAlpha(indAlpha)
                    button.gref.indicator.aggro["Iconal2"]:SetAlpha(indAlpha)
                    button.gref.indicator.aggro["Iconal3"]:SetAlpha(indAlpha)
                    button.gref.indicator.aggro["Iconar1"]:SetAlpha(indAlpha)
                    button.gref.indicator.aggro["Iconar2"]:SetAlpha(indAlpha)
                    button.gref.indicator.aggro["Iconar3"]:SetAlpha(indAlpha)
                end
            end
        elseif button.aggro.ind~=0 then
            HealBot_Aggro_IndicatorClear(button)
        end
        if hbv_Skins_GetFrameBoolean("BarAggro", "HAZARD", button.frame) and button.aggro.status == 3 then
            HealBot_Action_EnableBorderHazardType(button, 1, 0, 0, "AGGRO")
        elseif button.hazard.aggro then
            HealBot_Aggro_HazardClear(button)
        end
    else
        if button.aggro.ind~=0 then HealBot_Aggro_IndicatorClear(button) end
        if button.hazard.aggro then HealBot_Aggro_HazardClear(button) end
    end
end

local function HealBot_Aggro_AuxSetAggroBar(button)
      --HealBot_setCall("HealBot_Aggro_AuxSetAggroBar", button)
    HealBot_Aux_UpdateAggroBar(button)
    if HealBot_Aggro_AuxAssigns["NameOverlayAggro"][button.frame] then
        HealBot_Aux_UpdateNameOverLay(button, 4, true)
    end
    if HealBot_Aggro_AuxAssigns["HealthOverlayAggro"][button.frame] then
        HealBot_Aux_UpdateHealthOverLay(button, 4, true)
    end
end

local function HealBot_Aggro_AuxClearAggroBar(button)
      --HealBot_setCall("HealBot_Aggro_AuxClearAggroBar", button)
    HealBot_Aux_ClearAggroBar(button)
    if HealBot_Aggro_AuxAssigns["NameOverlayAggro"][button.frame] then
        HealBot_Aux_UpdateNameOverLay(button, 4, false)
    end
    if HealBot_Aggro_AuxAssigns["HealthOverlayAggro"][button.frame] then
        HealBot_Aux_UpdateHealthOverLay(button, 4, false)
    end
end

local hbAuraWatchAggro={}
local hbActionWatchAggro={}
function HealBot_Aggro_AuraWatch(guid, state)
      --HealBot_setCall("HealBot_Aggro_AuraWatch", nil, guid)
    if state then
        hbAuraWatchAggro[guid]=true
    else
        hbAuraWatchAggro[guid]=nil
    end
end

function HealBot_Aggro_ActionWatch(guid, state)
      --HealBot_setCall("HealBot_Aggro_ActionWatch", nil, guid)
    if state then
        hbActionWatchAggro[guid]=true
    else
        hbActionWatchAggro[guid]=nil
    end
end

function HealBot_Aggro_AuraWatchClear()
      --HealBot_setCall("HealBot_Aggro_AuraWatchClear")
    hbAuraWatchAggro={}
end

local hbPTTData={}
hbPTTData["threatpct"]=100
hbPTTData["status"]=3
hbPTTData["threatvalue"]=100
function HealBot_Aggro_PlayerTargetedUpdate(button)
    button.aggro.targeted=HealBot_TimeNow+1
    button.aggro.nextcheck=HealBot_TimeNow+2
end

function HealBot_Aggro_PlayerTargeted(button, targeted, name)
    if targeted then
        hbPTTData["threatname"]=name
        if button.aggro.threatvalue>100 then
            hbPTTData["threatvalue"]=button.aggro.threatvalue
        else
            hbPTTData["threatvalue"]=100
        end
        HealBot_Aggro_PlayerTargetedUpdate(button)
        HealBot_Aggro_UpdateUnit(button,true,hbPTTData)
    else
        button.aggro.nextcheck=1
        button.aggro.targeted=0
    end
end

function HealBot_Aggro_PlayerNotTargeted(guid)
    xButton, pButton=HealBot_Panel_AllUnitButton(guid)
    if xButton then HealBot_Aggro_PlayerTargeted(xButton, false) end
    if pButton then HealBot_Aggro_PlayerTargeted(pButton, false) end
end

function HealBot_Aggro_UpdateUnit(button,status,threatData)
      --HealBot_setCall("HealBot_Aggro_UpdateUnit", button)
    if button.status.current<HealBot_Unit_Status["DEAD"] and UnitIsFriend("player",button.unit) and UnitAffectingCombat(button.unit) then
        if status and hbv_Skins_GetFrameBoolean("BarAggro", "SHOW", button.frame) then
            if threatData["status"]>hbv_Skins_GetFrameVar("BarAggro", "ALERT", button.frame) then
                HealBot_Aggro_AuxSetAggroBar(button)
            else
                HealBot_Aggro_AuxClearAggroBar(button)
            end
        else
            threatData["status"]=0
            HealBot_Aggro_AuxClearAggroBar(button)
        end
    else
        HealBot_Aggro_AuxClearAggroBar(button)
        threatData["threatpct"]=0
        threatData["status"]=0
        threatData["threatvalue"]=0
        threatData["threatname"]=""
    end
    if button.aggro.status~=threatData["status"] then
        button.aggro.status=threatData["status"]
        HealBot_Action_AdaptiveAggroUpdate(button)
        if button.aggro.status>hbv_Skins_GetFrameVar("BarAggro", "ALERT", button.frame) then
            HealBot_Aux_UpdateThreatBar(button)
        end
        HealBot_Aggro_IndicatorUpdate(button)
        if hbAuraWatchAggro[button.guid] then
            HealBot_Plugin_AuraWatch_AggroUpdate(button)
        end
        if hbActionWatchAggro[button.guid] then
            HealBot_ActionIcons_UpdateAggro(button.guid, button.aggro.status)
        end
    end
    if button.aggro.threatpct~=threatData["threatpct"] or button.aggro.threatvalue~=threatData["threatvalue"] or button.aggro.mobname~=threatData["threatname"] then
        button.aggro.threatpct=threatData["threatpct"]
        HealBot_Action_AdaptiveThreatUpdate(button)
        button.aggro.threatvalue=threatData["threatvalue"]
        button.aggro.mobname=threatData["threatname"]
        if hbv_Skins_GetFrameVar("BarAggro", "SHOWTEXT", button.frame)>1 then
            HealBot_Text_setNameText(button)
        end
        if not hbv_Skins_GetFrameBoolean("BarText", "TAGAGGROONLYTIP", button.frame) then
            HealBot_Text_setAggroText(button)
        end
        if HealBot_Aggro_luVars["pluginThreat"] and button.status.plugin then HealBot_Plugin_Threat_UnitUpdate(button) end
        if button.mouseover and HealBot_Data["TIPBUTTON"] then HealBot_setTooltipUpdateNow() end
    end
end

local hbClearThreat={["status"]=0,
                     ["threatpct"]=0,
                     ["threatvalue"]=0,
                     ["threatname"]=""}
function HealBot_Aggro_ClearUnitAggro(button)
      --HealBot_setCall("HealBot_Aggro_ClearUnitAggro", button)
    HealBot_Aggro_UpdateUnit(button,false,hbClearThreat)
end

function HealBot_Aggro_ClearGUID(guid)
        --HealBot_setCall("HealBot_Aggro_ClearGUID", nil, guid)
    hbAuraWatchAggro[guid]=nil
    hbActionWatchAggro[guid]=nil
end
