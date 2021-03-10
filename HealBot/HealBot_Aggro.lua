local HealBot_Aggro_rCalls={}
local tConcat={}
local HealBot_Aggro_luVars={}
HealBot_Aggro_luVars["pluginThreat"]=false

function HealBot_Aggro_setLuVars(vName, vValue)
    HealBot_Aggro_luVars[vName]=vValue
end

function HealBot_Aggro_retLuVars(vName)
    return HealBot_Aggro_luVars[vName]
end

function HealBot_Aggro_Concat(elements)
    return table.concat(tConcat,"",1,elements)
end

function HealBot_Aggro_IndicatorUpdate(button)
    if button.aggro.status>=Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["ALERTIND"] then
        if button.aggro.status==1 then
            if button.aggro.ind~=1 then
                button.aggro.ind=1
                button.gref.indicator.aggro["Iconal1"]:SetAlpha(1)
                button.gref.indicator.aggro["Iconal2"]:SetAlpha(0)
                button.gref.indicator.aggro["Iconal3"]:SetAlpha(0)
                button.gref.indicator.aggro["Iconar1"]:SetAlpha(1)
                button.gref.indicator.aggro["Iconar2"]:SetAlpha(0)
                button.gref.indicator.aggro["Iconar3"]:SetAlpha(0)
            end
        elseif button.aggro.status==2 then
            if button.aggro.ind~=2 then
                button.aggro.ind=2
                button.gref.indicator.aggro["Iconal1"]:SetAlpha(1)
                button.gref.indicator.aggro["Iconal2"]:SetAlpha(1)
                button.gref.indicator.aggro["Iconal3"]:SetAlpha(0)
                button.gref.indicator.aggro["Iconar1"]:SetAlpha(1)
                button.gref.indicator.aggro["Iconar2"]:SetAlpha(1)
                button.gref.indicator.aggro["Iconar3"]:SetAlpha(0)
            end
        elseif button.aggro.status==3 then
            if button.aggro.ind~=3 then
                button.aggro.ind=3
                button.gref.indicator.aggro["Iconal1"]:SetAlpha(1)
                button.gref.indicator.aggro["Iconal2"]:SetAlpha(1)
                button.gref.indicator.aggro["Iconal3"]:SetAlpha(1)
                button.gref.indicator.aggro["Iconar1"]:SetAlpha(1)
                button.gref.indicator.aggro["Iconar2"]:SetAlpha(1)
                button.gref.indicator.aggro["Iconar3"]:SetAlpha(1)
            end
        end
    elseif button.aggro.ind~=0 then
        button.aggro.ind=0
        button.gref.indicator.aggro["Iconal1"]:SetAlpha(0)
        button.gref.indicator.aggro["Iconal2"]:SetAlpha(0)
        button.gref.indicator.aggro["Iconal3"]:SetAlpha(0)
        button.gref.indicator.aggro["Iconar1"]:SetAlpha(0)
        button.gref.indicator.aggro["Iconar2"]:SetAlpha(0)
        button.gref.indicator.aggro["Iconar3"]:SetAlpha(0)
    end
      --HealBot_setCall("HealBot_Aggro_IndicatorUpdate")
end

local hbAuxAggroAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
local hbAuxThreatAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
function HealBot_Aggro_clearAuxAssigned()
    for f=1,9 do
        hbAuxAggroAssigned[f]={};
        hbAuxThreatAssigned[f]={};
    end
end

function HealBot_Aggro_setAuxAssigned(aType, frame, id)
    if aType=="AGGRO" then
        hbAuxAggroAssigned[frame][id]=true
    else
        hbAuxThreatAssigned[frame][id]=true
    end
end

function HealBot_Aggro_UpdateThreatBar(button)
    for id in pairs(hbAuxThreatAssigned[button.frame]) do
        if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==1 then
            button.aux[id]["R"]=1
            button.aux[id]["G"]=1
            button.aux[id]["B"]=0.2
        end
        HealBot_setAuxBar(button, id, button.aggro.threatpct*10, true)
    end
end

function HealBot_Aggro_ClearThreatBar(button)
    for id in pairs(hbAuxThreatAssigned[button.frame]) do
        HealBot_clearAuxBar(button, id)
    end
end

function HealBot_Aggro_UpdateAggroBar(button)
    for id in pairs(hbAuxAggroAssigned[button.frame]) do
        if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==1 then
            button.aux[id]["R"]=1
            button.aux[id]["G"]=0
            button.aux[id]["B"]=0
        end
        HealBot_setAuxBar(button, id, 1000, false)
    end
end

function HealBot_Aggro_ClearAggroBar(button)
    for id in pairs(hbAuxAggroAssigned[button.frame]) do
        HealBot_clearAuxBar(button, id)
    end
end

local debuffCodes={ [HEALBOT_DISEASE_en]=5, [HEALBOT_MAGIC_en]=6, [HEALBOT_POISON_en]=7, [HEALBOT_CURSE_en]=8, [HEALBOT_CUSTOM_en]=9}
function HealBot_Aggro_UpdateUnit(button,status,threatStatus,threatPct,extra,threatValue,mobName)
    if button.status.current<9 and UnitIsFriend("player",button.unit) then
        if status then
            if Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["SHOW"] then
                if threatStatus>Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["ALERT"] then
                    HealBot_Aggro_UpdateAggroBar(button)
                else
                    HealBot_Aggro_ClearAggroBar(button)
                end
            end
        else
            threatStatus=0
            HealBot_Aggro_ClearAggroBar(button)
        end
    else
        HealBot_Aggro_ClearAggroBar(button)
        threatPct=0
        threatStatus=0
        threatValue=0
        mobName=""
    end
    button.aggro.status=threatStatus
    if threatStatus==0 or (Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["SHOW"] and 
                           Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWIND"]) then
        HealBot_Aggro_IndicatorUpdate(button)
    end
    if button.aggro.threatpct~=threatPct or button.aggro.threatvalue~=threatValue or button.aggro.mobname~=mobName then 
        button.aggro.threatpct=threatPct
        button.aggro.threatvalue=threatValue
        button.aggro.mobname=mobName
        HealBot_Text_setNameText(button) 
        if HealBot_Aggro_luVars["pluginThreat"] and button.status.plugin then HealBot_Plugin_Threat_UnitUpdate(button) end
        if HealBot_Data["TIPBUTTON"] and HealBot_Data["TIPBUTTON"]==button then HealBot_Action_RefreshTooltip() end
        if threatPct<1 then
            HealBot_Aggro_ClearThreatBar(button)
        else
            HealBot_Aggro_UpdateThreatBar(button)
        end
        HealBot_Action_UpdateHealthButton(button) 
    end
      --HealBot_setCall("HealBot_Aggro_UpdateUnit")
end
