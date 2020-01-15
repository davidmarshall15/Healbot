local HealBot_Aggro_rCalls={}
local HealBot_Aggro_luVars={}
HealBot_Aggro_luVars["AggroBarUp"]=false
HealBot_Aggro_luVars["UpdatedAggroBars"]=true
HealBot_Aggro_luVars["UpdateFluidBars"]=true

function HealBot_Aggro_setLuVars(vName, vValue)
    HealBot_Aggro_luVars[vName]=vValue
    --HealBot_setCall("HealBot_Aggro_setLuVars")
end

local tConcat={}
local function HealBot_Aggro_Concat(elements)
    return table.concat(tConcat,"",1,elements)
end

local aiuBar, aiuIconName=false,false
function HealBot_Aggro_IndicatorUpdate(button)
    if not UnitExists(button.unit) or (UnitExists(button.unit) and not button.status.friend) then
        if HealBot_Aggro_rCalls[button.unit] then HealBot_Aggro_rCalls[button.unit]["aggroIndicator"]="notUnit" end
        aiuBar=_G["HealBot_Action_HealUnit"..button.id.."Bar"]
        aiuIconName = _G[aiuBar:GetName().."Iconal1"];
        aiuIconName:SetAlpha(0)
        aiuIconName = _G[aiuBar:GetName().."Iconal2"];
        aiuIconName:SetAlpha(0)
        aiuIconName = _G[aiuBar:GetName().."Iconal3"];
        aiuIconName:SetAlpha(0)
        aiuIconName = _G[aiuBar:GetName().."Iconar1"];
        aiuIconName:SetAlpha(0)
        aiuIconName = _G[aiuBar:GetName().."Iconar2"];
        aiuIconName:SetAlpha(0)
        aiuIconName = _G[aiuBar:GetName().."Iconar3"];
        aiuIconName:SetAlpha(0)
    else
        if button.aggro.status>=Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["ALERTIND"] then
            if button.aggro.status==1 then
                if HealBot_Aggro_rCalls[button.unit]["aggroIndicator"]~="a1" then
                    HealBot_Aggro_rCalls[button.unit]["aggroIndicator"]="a1"
                    aiuBar=_G["HealBot_Action_HealUnit"..button.id.."Bar"]
                    aiuIconName = _G[aiuBar:GetName().."Iconal1"];
                    aiuIconName:SetAlpha(1)
                    aiuIconName = _G[aiuBar:GetName().."Iconal2"];
                    aiuIconName:SetAlpha(0)
                    aiuIconName = _G[aiuBar:GetName().."Iconal3"];
                    aiuIconName:SetAlpha(0)
                    aiuIconName = _G[aiuBar:GetName().."Iconar1"];
                    aiuIconName:SetAlpha(1)
                    aiuIconName = _G[aiuBar:GetName().."Iconar2"];
                    aiuIconName:SetAlpha(0)
                    aiuIconName = _G[aiuBar:GetName().."Iconar3"];
                    aiuIconName:SetAlpha(0)
                end
            elseif button.aggro.status==2 then
                if HealBot_Aggro_rCalls[button.unit]["aggroIndicator"]~="a2" then
                    HealBot_Aggro_rCalls[button.unit]["aggroIndicator"]="a2"
                    aiuBar=_G["HealBot_Action_HealUnit"..button.id.."Bar"]
                    aiuIconName = _G[aiuBar:GetName().."Iconal1"];
                    aiuIconName:SetAlpha(1)
                    aiuIconName = _G[aiuBar:GetName().."Iconal2"];
                    aiuIconName:SetAlpha(1)
                    aiuIconName = _G[aiuBar:GetName().."Iconal3"];
                    aiuIconName:SetAlpha(0)
                    aiuIconName = _G[aiuBar:GetName().."Iconar1"];
                    aiuIconName:SetAlpha(1)
                    aiuIconName = _G[aiuBar:GetName().."Iconar2"];
                    aiuIconName:SetAlpha(1)
                    aiuIconName = _G[aiuBar:GetName().."Iconar3"];
                    aiuIconName:SetAlpha(0)
                end
            elseif button.aggro.status==3 then
                if HealBot_Aggro_rCalls[button.unit]["aggroIndicator"]~="a3" then
                    HealBot_Aggro_rCalls[button.unit]["aggroIndicator"]="a3"
                    aiuBar=_G["HealBot_Action_HealUnit"..button.id.."Bar"]
                    aiuIconName = _G[aiuBar:GetName().."Iconal1"];
                    aiuIconName:SetAlpha(1)
                    aiuIconName = _G[aiuBar:GetName().."Iconal2"];
                    aiuIconName:SetAlpha(1)
                    aiuIconName = _G[aiuBar:GetName().."Iconal3"];
                    aiuIconName:SetAlpha(1)
                    aiuIconName = _G[aiuBar:GetName().."Iconar1"];
                    aiuIconName:SetAlpha(1)
                    aiuIconName = _G[aiuBar:GetName().."Iconar2"];
                    aiuIconName:SetAlpha(1)
                    aiuIconName = _G[aiuBar:GetName().."Iconar3"];
                    aiuIconName:SetAlpha(1)
                end
            end
        elseif button.aggro.status>-1 and button.aggro.status<4 then
            if HealBot_Aggro_rCalls[button.unit]["aggroIndicator"]~="off" then
                HealBot_Aggro_rCalls[button.unit]["aggroIndicator"]="off"
                aiuBar=_G["HealBot_Action_HealUnit"..button.id.."Bar"]
                aiuIconName = _G[aiuBar:GetName().."Iconal1"];
                aiuIconName:SetAlpha(0)
                aiuIconName = _G[aiuBar:GetName().."Iconal2"];
                aiuIconName:SetAlpha(0)
                aiuIconName = _G[aiuBar:GetName().."Iconal3"];
                aiuIconName:SetAlpha(0)
                aiuIconName = _G[aiuBar:GetName().."Iconar1"];
                aiuIconName:SetAlpha(0)
                aiuIconName = _G[aiuBar:GetName().."Iconar2"];
                aiuIconName:SetAlpha(0)
                aiuIconName = _G[aiuBar:GetName().."Iconar3"];
                aiuIconName:SetAlpha(0)
            end
        end
    end
    --HealBot_setCall("HealBot_Aggro_IndicatorUpdate")
end

function HealBot_Aggro_ResetrCallsUnit(unit)
    if not HealBot_Aggro_rCalls[unit] then HealBot_Aggro_rCalls[unit]={} end
    HealBot_Aggro_rCalls[unit]["aggroIndicator"]="notSet"
end

local debuffCodes={ [HEALBOT_DISEASE_en]=5, [HEALBOT_MAGIC_en]=6, [HEALBOT_POISON_en]=7, [HEALBOT_CURSE_en]=8, [HEALBOT_CUSTOM_en]=9}
local adaBar=false
function HealBot_Action_UpdateAggro(button,status,threatStatus,threatPct,extra)
    tConcat[1]="HealBot_Action_HealUnit"
    tConcat[2]=button.id
    tConcat[3]="Bar4"
    adaBar=_G[HealBot_Aggro_Concat(3)]
    
    if UnitExists(button.unit) and button.status.friend then
        if UnitIsDeadOrGhost(button.unit) and not UnitIsFeignDeath(button.unit) then
            status=false
            threatPct=0
            threatStatus=0
        end
        --if threatStatus and (Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWBARSPCT"] or 
        --                     Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWTEXTPCT"]) then
        --    if not threatPct then threatPct=HealBot_CalcThreat(button.unit) end
        --    if threatPct>0 and threatStatus==0 then 
        --        threatStatus=1
        --    elseif threatStatus==3 then
        --        threatPct=100
        --    elseif threatStatus==2 then
        --        if threatPct<25 then threatPct=50 end
        --    elseif threatStatus==1 then
        --        if threatPct<10 then threatPct=25 end
        --    end
        --end
        if status then
            if HealBot_Config_Cures.CDCshownAB and button.aura.debuff.type then
                threatStatus=debuffCodes[button.aura.debuff.type]
            elseif HealBot_Config_Buffs.CBshownAB and button.aura.buff.name then
                threatStatus=4
            elseif Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["SHOW"] and 
                   threatStatus>Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["ALERT"] then
                threatStatus=threatStatus or 0
            elseif extra=="target" and Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][button.frame]["TBAR"] then
                threatStatus=-2
            elseif extra=="highlight" and Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][button.frame]["CBAR"] then
                threatStatus=-1
            end
            if Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["SHOW"] and 
               Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWIND"] then
                HealBot_Aggro_IndicatorUpdate(button)
            end
        else
            threatStatus=0
            HealBot_Aggro_IndicatorUpdate(button)
        end
        if status then
            if threatStatus<0 or threatStatus>3 then
                adaBar:SetValue(100)
                button.status.bar4=1
                HealBot_Aggro_luVars["UpdatedAggroBars"]=true
                HealBot_UpdateBarNow()
            elseif Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWBARS"] then 
                if threatStatus>0 and Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWBARSPCT"] then
                    adaBar:SetValue(threatPct)
                    button.status.bar4=1
                    HealBot_Aggro_luVars["UpdatedAggroBars"]=true
                    HealBot_UpdateBarNow()
                elseif threatStatus>Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["ALERT"] then
                    adaBar:SetValue(100)
                    button.status.bar4=1
                    HealBot_Aggro_luVars["UpdatedAggroBars"]=true
                    HealBot_UpdateBarNow()
                else
                    adaBar:SetStatusBarColor(1,0,0,0)
                    button.status.bar4=0
                end
            else
                adaBar:SetStatusBarColor(1,0,0,0)
                button.status.bar4=0
            end
        else
            adaBar:SetStatusBarColor(1,0,0,0)
            button.status.bar4=0
        end
    else
        adaBar:SetStatusBarColor(1,0,0,0);
        button.status.bar4=0
        threatPct=0
        threatStatus=0
    end
    if button.aggro.status~=threatStatus then
        button.aggro.status=threatStatus
        if threatStatus==0 or (Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["SHOW"] and 
                               Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWIND"]) then
            HealBot_Aggro_IndicatorUpdate(button)
        end
    end
    if button.aggro.threatpct~=threatPct then 
        button.aggro.threatpct=threatPct
        HealBot_Text_setNameText(button) 
        HealBot_Action_UpdateHealthButton(button) 
    end
    --HealBot_setCall("HealBot_Action_DoUpdateAggro")
end


local HealBot_AggroBarColr = {[1]= {[-2]=0.7, [-1]=1, [0]=1, [1]=1, [2]=1, [3]=1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},
                              [2]= {[-2]=0.7, [-1]=1, [0]=1, [1]=1, [2]=1, [3]=1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},
                              [3]= {[-2]=0.7, [-1]=1, [0]=1, [1]=1, [2]=1, [3]=1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},
                              [4]= {[-2]=0.7, [-1]=1, [0]=1, [1]=1, [2]=1, [3]=1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},
                              [5]= {[-2]=0.7, [-1]=1, [0]=1, [1]=1, [2]=1, [3]=1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},
                              [6]= {[-2]=0.7, [-1]=1, [0]=1, [1]=1, [2]=1, [3]=1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},
                              [7]= {[-2]=0.7, [-1]=1, [0]=1, [1]=1, [2]=1, [3]=1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},
                              [8]= {[-2]=0.7, [-1]=1, [0]=1, [1]=1, [2]=1, [3]=1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},
                              [9]= {[-2]=0.7, [-1]=1, [0]=1, [1]=1, [2]=1, [3]=1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},}
local HealBot_AggroBarColg = {[1]= {[-2]=0.7, [-1]=1, [0]=1, [1]=1, [2]=0.1, [3]=0.1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},
                              [2]= {[-2]=0.7, [-1]=1, [0]=1, [1]=1, [2]=0.1, [3]=0.1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},
                              [3]= {[-2]=0.7, [-1]=1, [0]=1, [1]=1, [2]=0.1, [3]=0.1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},
                              [4]= {[-2]=0.7, [-1]=1, [0]=1, [1]=1, [2]=0.1, [3]=0.1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},
                              [5]= {[-2]=0.7, [-1]=1, [0]=1, [1]=1, [2]=0.1, [3]=0.1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},
                              [6]= {[-2]=0.7, [-1]=1, [0]=1, [1]=1, [2]=0.1, [3]=0.1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},
                              [7]= {[-2]=0.7, [-1]=1, [0]=1, [1]=1, [2]=0.1, [3]=0.1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},
                              [8]= {[-2]=0.7, [-1]=1, [0]=1, [1]=1, [2]=0.1, [3]=0.1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},
                              [9]= {[-2]=0.7, [-1]=1, [0]=1, [1]=1, [2]=0.1, [3]=0.1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},}
local HealBot_AggroBarColb = {[1]= {[-2]=1, [-1]=1, [0]=0.4, [1]=0.2, [2]=0.1, [3]=0.1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},
                              [2]= {[-2]=1, [-1]=1, [0]=0.4, [1]=0.2, [2]=0.1, [3]=0.1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},
                              [3]= {[-2]=1, [-1]=1, [0]=0.4, [1]=0.2, [2]=0.1, [3]=0.1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},
                              [4]= {[-2]=1, [-1]=1, [0]=0.4, [1]=0.2, [2]=0.1, [3]=0.1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},
                              [5]= {[-2]=1, [-1]=1, [0]=0.4, [1]=0.2, [2]=0.1, [3]=0.1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},
                              [6]= {[-2]=1, [-1]=1, [0]=0.4, [1]=0.2, [2]=0.1, [3]=0.1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},
                              [7]= {[-2]=1, [-1]=1, [0]=0.4, [1]=0.2, [2]=0.1, [3]=0.1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},
                              [8]= {[-2]=1, [-1]=1, [0]=0.4, [1]=0.2, [2]=0.1, [3]=0.1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},
                              [9]= {[-2]=1, [-1]=1, [0]=0.4, [1]=0.2, [2]=0.1, [3]=0.1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},}
local HealBot_AggroUnitThreat=1

function HealBot_Action_SetDebuffAggroCols()
    for j=1,9 do
        HealBot_AggroBarColr[j][5]=HealBot_Config_Cures.CDCBarColour[HEALBOT_DISEASE_en].R
        HealBot_AggroBarColg[j][5]=HealBot_Config_Cures.CDCBarColour[HEALBOT_DISEASE_en].G
        HealBot_AggroBarColb[j][5]=HealBot_Config_Cures.CDCBarColour[HEALBOT_DISEASE_en].B 
        HealBot_AggroBarColr[j][6]=HealBot_Config_Cures.CDCBarColour[HEALBOT_MAGIC_en].R
        HealBot_AggroBarColg[j][6]=HealBot_Config_Cures.CDCBarColour[HEALBOT_MAGIC_en].G
        HealBot_AggroBarColb[j][6]=HealBot_Config_Cures.CDCBarColour[HEALBOT_MAGIC_en].B 
        HealBot_AggroBarColr[j][7]=HealBot_Config_Cures.CDCBarColour[HEALBOT_POISON_en].R
        HealBot_AggroBarColg[j][7]=HealBot_Config_Cures.CDCBarColour[HEALBOT_POISON_en].G
        HealBot_AggroBarColb[j][7]=HealBot_Config_Cures.CDCBarColour[HEALBOT_POISON_en].B 
        HealBot_AggroBarColr[j][8]=HealBot_Config_Cures.CDCBarColour[HEALBOT_CURSE_en].R
        HealBot_AggroBarColg[j][8]=HealBot_Config_Cures.CDCBarColour[HEALBOT_CURSE_en].G
        HealBot_AggroBarColb[j][8]=HealBot_Config_Cures.CDCBarColour[HEALBOT_CURSE_en].B 
        HealBot_AggroBarColr[j][9]=HealBot_Globals.CDCBarColour[HEALBOT_CUSTOM_en.."15"].R
        HealBot_AggroBarColg[j][9]=HealBot_Globals.CDCBarColour[HEALBOT_CUSTOM_en.."15"].G
        HealBot_AggroBarColb[j][9]=HealBot_Globals.CDCBarColour[HEALBOT_CUSTOM_en.."15"].B
    end
end

function HealBot_Action_SetHightlightAggroCols()
    for j=1,9 do
        HealBot_AggroBarColr[j][-1]=Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][j]["CR"]
        HealBot_AggroBarColg[j][-1]=Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][j]["CG"]
        HealBot_AggroBarColb[j][-1]=Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][j]["CB"]
    end
end

function HealBot_Action_SetHightlightTargetAggroCols()
    for j=1,9 do
        HealBot_AggroBarColr[j][-2]=Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][j]["TR"]
        HealBot_AggroBarColg[j][-2]=Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][j]["TG"]
        HealBot_AggroBarColb[j][-2]=Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][j]["TB"]
    end
end

function HealBot_Action_SetAggroCols()
    for j=1,9 do
        HealBot_AggroBarColr[j][2]=Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][j]["R"]
        HealBot_AggroBarColg[j][2]=Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][j]["G"]
        HealBot_AggroBarColb[j][2]=Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][j]["B"]
        HealBot_AggroBarColr[j][3]=Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][j]["R"]
        HealBot_AggroBarColg[j][3]=Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][j]["G"]
        HealBot_AggroBarColb[j][3]=Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][j]["B"]
    end
end

local function HealBot_Action_UpdateFluidBar(button)
    local hrpct=100
    local barName = _G["HealBot_Action_HealUnit"..button.id.."Bar"]
    if button.status.current==9 or (UnitIsDeadOrGhost(button.unit) and not UnitIsFeignDeath(button.unit)) then
        barName:SetValue(0)
    else
        if button.health.current<button.health.max then
            hrpct=floor((button.health.current/button.health.max)*100)
        end
        local barValue=barName:GetValue()
        if barValue>hrpct then
            local setValue=barValue-Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["FLUIDFREQ"]
            if setValue<hrpct then
                setValue=hrpct
                if button.status.current>3 and button.status.current<9 and button.status.range==1 then
                    if button.health.incoming>0 then HealBot_Action_UpdateHealsInButton(button) end
                    if button.health.absorbs>0 then HealBot_Action_UpdateAbsorbsButton(button) end
                end
            end
            barName:SetValue(setValue)
            HealBot_Aggro_luVars["UpdateFluidBars"]=true
        elseif barValue<hrpct then
            local setValue=barValue+Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["FLUIDFREQ"]
            if setValue>hrpct then
                setValue=hrpct
                if button.status.current>3 and button.status.current<9 and button.status.range==1 then
                    if button.health.incoming>0 then HealBot_Action_UpdateHealsInButton(button) end
                    if button.health.absorbs>0 then HealBot_Action_UpdateAbsorbsButton(button) end
                end
            end
            barName:SetValue(setValue)
            HealBot_Aggro_luVars["UpdateFluidBars"]=true
        end
    end
end

local function HealBot_Aggro_UpdateFluidBars()
    HealBot_Aggro_luVars["UpdateFluidBars"]=false
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Action_UpdateFluidBar(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Action_UpdateFluidBar(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Action_UpdateFluidBar(xButton)
    end
    --HealBot_setCall("HealBot_Aggro_UpdateFluidBars")
end

local aFrameUpd={[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false}
local aAlpha={[1]=0.5,[2]=0.5,[3]=0.5,[4]=0.5,[5]=0.5,[6]=0.5,[7]=0.5,[8]=0.5,[9]=0.5}
local uaBar4,uaRGB=nil,nil
local function HealBot_Action_UpdateAggroBar(button)
    uaBar4=_G["HealBot_Action_HealUnit"..button.id.."Bar4"]
    if UnitExists(button.unit) and button.frame<10 then
        HealBot_AggroUnitThreat=button.aggro.status or 2
        if HealBot_AggroUnitThreat>4 and button.aura.debuff.name then
            if HealBot_Globals.CDCBarColour[button.aura.debuff.id] then
                uaBar4:SetStatusBarColor(HealBot_Globals.CDCBarColour[button.aura.debuff.id].R,
                                       HealBot_Globals.CDCBarColour[button.aura.debuff.id].G,
                                       HealBot_Globals.CDCBarColour[button.aura.debuff.id].B,aAlpha[button.frame])
            else
                uaRGB=HEALBOT_CUSTOM_en.."15"
                uaBar4:SetStatusBarColor(HealBot_Globals.CDCBarColour[uaRGB].R,
                                       HealBot_Globals.CDCBarColour[uaRGB].G,
                                       HealBot_Globals.CDCBarColour[uaRGB].B,aAlpha[button.frame])
            end
        elseif HealBot_AggroUnitThreat==4 and button.aura.buff.name then
            uaRGB=HealBot_Aura_retBuffWatch(button.aura.buff.name)
            if uaRGB and HealBot_Config_Buffs.HealBotBuffColR[uaRGB] then
                uaBar4:SetStatusBarColor(HealBot_Config_Buffs.HealBotBuffColR[uaRGB],
                                       HealBot_Config_Buffs.HealBotBuffColG[uaRGB],
                                       HealBot_Config_Buffs.HealBotBuffColB[uaRGB],aAlpha[button.frame])
            elseif HealBot_Globals.CustomBuffBarColour[button.aura.buff.id] then
                uaBar4:SetStatusBarColor(HealBot_Globals.CustomBuffBarColour[button.aura.buff.id].R,
                                       HealBot_Globals.CustomBuffBarColour[button.aura.buff.id].G,
                                       HealBot_Globals.CustomBuffBarColour[button.aura.buff.id].B,aAlpha[button.frame])
            
            else
                uaRGB=HEALBOT_CUSTOM_en.."Buff"
                uaBar4:SetStatusBarColor(HealBot_Globals.CustomBuffBarColour[uaRGB].R,
                                       HealBot_Globals.CustomBuffBarColour[uaRGB].G,
                                       HealBot_Globals.CustomBuffBarColour[uaRGB].B,aAlpha[button.frame])
            end
        else
            uaBar4:SetStatusBarColor(HealBot_AggroBarColr[button.frame][HealBot_AggroUnitThreat],
                                   HealBot_AggroBarColg[button.frame][HealBot_AggroUnitThreat],
                                   HealBot_AggroBarColb[button.frame][HealBot_AggroUnitThreat],
                                   aAlpha[button.frame])
        end
        HealBot_Aggro_luVars["UpdatedAggroBars"]=true
        aFrameUpd[button.frame]=true
    elseif uaBar4 then
        uaBar4:SetStatusBarColor(1,0,0,0)
        button.status.bar4=0
    end
end

local function HealBot_Aggro_UpdateAggroBars()
    for j=1,9 do
        aFrameUpd[j]=false
    end
    HealBot_Aggro_luVars["UpdatedAggroBars"]=false
    for _,xButton in pairs(HealBot_Unit_Button) do
        if xButton.status.bar4>0 then
            HealBot_Action_UpdateAggroBar(xButton)
        end
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        if xButton.status.bar4>0 then
            HealBot_Action_UpdateAggroBar(xButton)
        end
    end
    for j=1,9 do
        if aFrameUpd[j] then
            if HealBot_Aggro_luVars["AggroBarUp"] then
                aAlpha[j]=aAlpha[j]+0.05+Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][j]["FREQ"]
                if aAlpha[j]>=Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][j]["MAXA"] then
                    HealBot_Aggro_luVars["AggroBarUp"]=false
                    aAlpha[j]=Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][j]["MAXA"]
                end
            else
                aAlpha[j]=aAlpha[j]-0.05-Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][j]["FREQ"]
                if aAlpha[j]<=Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][j]["MINA"] then
                    HealBot_Aggro_luVars["AggroBarUp"]=true
                    aAlpha[j]=Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][j]["MINA"]
                end
            end
        end
    end
    --HealBot_setCall("HHealBot_Aggro_UpdateAggroBars")
end

local hbAggroUpdates=false
function HealBot_Aggro_UpdateBars()
    hbAggroUpdates=false
    if HealBot_Aggro_luVars["UpdatedAggroBars"] then
        HealBot_Aggro_UpdateAggroBars()
        hbAggroUpdates=true
    end
    if HealBot_Aggro_luVars["UpdateFluidBars"] then
        HealBot_Aggro_UpdateFluidBars()
        hbAggroUpdates=true
    end
    return hbAggroUpdates
end
