local HealBot_Update_luVars={}
HealBot_Update_luVars["TestBarsOn"]=false

function HealBot_Update_setLuVars(vName, vValue)
      --HealBot_setCall("HealBot_Update_setLuVars - "..vName)
    HealBot_Update_luVars[vName]=vValue
end

function HealBot_Update_retLuVars(vName)
      --HealBot_setCall("HealBot_Update_retLuVars - "..vName)
    return HealBot_Update_luVars[vName]
end

function HealBot_Update_AllThreat()
      --HealBot_setCall("HealBot_Update_AllThreat")
    for _,xButton in pairs(HealBot_Unit_Button) do
        xButton.aggro.nextcheck=1
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        xButton.aggro.nextcheck=1
    end
end

function HealBot_Update_ClearClassGuidData()
      --HealBot_setCall("HealBot_Update_ClearClassGuidData")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Action_SetGuidData(xButton, "CLASSKNOWN", false)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Action_SetGuidData(xButton, "CLASSKNOWN", false)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Action_SetGuidData(xButton, "CLASSKNOWN", false)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Action_SetGuidData(xButton, "CLASSKNOWN", false)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Action_SetGuidData(xButton, "CLASSKNOWN", false)
    end
    HealBot_Action_ResetAllButtons(true)
    HealBot_Timers_Set("OOC","RefreshPartyNextRecalcAll")
end

function HealBot_Update_EndAggro()
      --HealBot_setCall("HealBot_Update_EndAggro")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Aggro_ClearUnitAggro(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Aggro_ClearUnitAggro(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Aggro_ClearUnitAggro(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Aggro_ClearUnitAggro(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Aggro_ClearUnitAggro(xButton)
    end
end

function HealBot_Update_AllAuxThreatBars()
      --HealBot_setCall("HealBot_Update_AllAuxThreatBars")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Aux_UpdateThreatBar(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Aux_UpdateThreatBar(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Aux_UpdateThreatBar(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Aux_UpdateThreatBar(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Aux_UpdateThreatBar(xButton)
    end
end

function HealBot_Update_AllAuxPowerBars()
      --HealBot_setCall("HealBot_Update_AllAuxPowerBars")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Events_UnitManaUpdate(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Events_UnitManaUpdate(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Events_UnitManaUpdate(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Events_UnitManaUpdate(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Events_UnitManaUpdate(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Events_UnitManaUpdate(xButton)
    end
    for xUnit,xButton in pairs(HealBot_UnitTarget_Button) do
        HealBot_Events_UnitManaUpdate(xButton)
    end
    for xUnit,xButton in pairs(HealBot_PrivateTarget_Button) do
        HealBot_Events_UnitManaUpdate(xButton)
    end
end

function HealBot_Update_AllAuxOverLays()
      --HealBot_setCall("HealBot_Update_AllAuxOverLays")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Aux_CheckOverLays(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Aux_CheckOverLays(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Aux_CheckOverLays(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Aux_CheckOverLays(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Aux_CheckOverLays(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Aux_CheckOverLays(xButton)
    end
    for xUnit,xButton in pairs(HealBot_UnitTarget_Button) do
        HealBot_Aux_CheckOverLays(xButton)
    end
    for xUnit,xButton in pairs(HealBot_PrivateTarget_Button) do
        HealBot_Aux_CheckOverLays(xButton)
    end
end

function HealBot_Update_ResetAllAuxText()
      --HealBot_setCall("HealBot_Update_ResetAllAuxText")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Aux_ResetNameBar(xButton)
        HealBot_Aux_ResetHealthBar(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Aux_ResetNameBar(xButton)
        HealBot_Aux_ResetHealthBar(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Aux_ResetNameBar(xButton)
        HealBot_Aux_ResetHealthBar(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Aux_ResetNameBar(xButton)
        HealBot_Aux_ResetHealthBar(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Aux_ResetNameBar(xButton)
        HealBot_Aux_ResetHealthBar(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Aux_ResetNameBar(xButton)
        HealBot_Aux_ResetHealthBar(xButton)
    end
    for xUnit,xButton in pairs(HealBot_UnitTarget_Button) do
        HealBot_Aux_ResetNameBar(xButton)
        HealBot_Aux_ResetHealthBar(xButton)
    end
    for xUnit,xButton in pairs(HealBot_PrivateTarget_Button) do
        HealBot_Aux_ResetNameBar(xButton)
        HealBot_Aux_ResetHealthBar(xButton)
    end
end

function HealBot_Update_AllAuxBars()
      --HealBot_setCall("HealBot_Update_AllAuxBars")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Aux_UpdBar(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Aux_UpdBar(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Aux_UpdBar(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Aux_UpdBar(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Aux_UpdBar(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Aux_UpdBar(xButton)
    end
    for xUnit,xButton in pairs(HealBot_UnitTarget_Button) do
        HealBot_Aux_UpdBar(xButton)
    end
    for xUnit,xButton in pairs(HealBot_PrivateTarget_Button) do
        HealBot_Aux_UpdBar(xButton)
    end
end

function HealBot_Update_AuxBuffBars(button)
      --HealBot_setCall("HealBot_Update_AuxBuffBars", button)
    if button.aura.buff.name then
        HealBot_Aura_BuffWarnings(button, button.aura.buff.name, true)
    else
        HealBot_Aura_AuxClearAuraBuffBars(button)
    end
end

function HealBot_Update_AllAuxBuffBars()
      --HealBot_setCall("HealBot_Update_AllAuxBuffBars")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Update_AuxBuffBars(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Update_AuxBuffBars(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Update_AuxBuffBars(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Update_AuxBuffBars(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Update_AuxBuffBars(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Update_AuxBuffBars(xButton)
    end
    for xUnit,xButton in pairs(HealBot_UnitTarget_Button) do
        HealBot_Update_AuxBuffBars(xButton)
    end
    for xUnit,xButton in pairs(HealBot_PrivateTarget_Button) do
        HealBot_Update_AuxBuffBars(xButton)
    end
end

function HealBot_Update_AuxDebuffBars(button)
      --HealBot_setCall("HealBot_Update_AuxDebuffBars", button)
    if button.aura.debuff.name then
        HealBot_Aura_DebuffWarnings(button, button.aura.debuff.name, true, 0)
    else
        HealBot_Aura_AuxClearAuraDebuffBars(button)
    end
end

function HealBot_Update_AllAuxDebuffBars()
      --HealBot_setCall("HealBot_Update_AllAuxDebuffBars")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Update_AuxDebuffBars(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Update_AuxDebuffBars(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Update_AuxDebuffBars(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Update_AuxDebuffBars(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Update_AuxDebuffBars(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Update_AuxDebuffBars(xButton)
    end
    for xUnit,xButton in pairs(HealBot_UnitTarget_Button) do
        HealBot_Update_AuxDebuffBars(xButton)
    end
    for xUnit,xButton in pairs(HealBot_PrivateTarget_Button) do
        HealBot_Update_AuxDebuffBars(xButton)
    end
end

function HealBot_Update_AllAuxRangeBars()
      --HealBot_setCall("HealBot_Update_AllAuxRangeBars")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Update_OORBar(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Update_OORBar(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Update_OORBar(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Update_OORBar(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Update_OORBar(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Update_OORBar(xButton)
    end
    for xUnit,xButton in pairs(HealBot_UnitTarget_Button) do
        HealBot_Update_OORBar(xButton)
    end
    for xUnit,xButton in pairs(HealBot_PrivateTarget_Button) do
        HealBot_Update_OORBar(xButton)
    end
end

function HealBot_Update_AllAuxInRangeBars()
      --HealBot_setCall("HealBot_Update_AllAuxInRangeBars")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Update_InRangeBar(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Update_InRangeBar(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Update_InRangeBar(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Update_InRangeBar(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Update_InRangeBar(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Update_InRangeBar(xButton)
    end
    for xUnit,xButton in pairs(HealBot_UnitTarget_Button) do
        HealBot_Update_InRangeBar(xButton)
    end
    for xUnit,xButton in pairs(HealBot_PrivateTarget_Button) do
        HealBot_Update_InRangeBar(xButton)
    end
end

function HealBot_Update_AuxResetRange()
      --HealBot_setCall("HealBot_Update_AuxResetRange")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Update_AuxRange(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Update_AuxRange(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Update_AuxRange(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Update_AuxRange(xButton)
    end
    for xUnit,xButton in pairs(HealBot_UnitTarget_Button) do
        HealBot_Update_AuxRange(xButton)
    end
    for xUnit,xButton in pairs(HealBot_PrivateTarget_Button) do
        HealBot_Update_AuxRange(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Update_AuxRange(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Update_AuxRange(xButton)
    end
end

function HealBot_Update_AllAuxOverHealsBars()
      --HealBot_setCall("HealBot_Update_AllAuxOverHealsBars")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Aux_UpdateOverHealBar(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Aux_UpdateOverHealBar(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Aux_UpdateOverHealBar(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Aux_UpdateOverHealBar(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Aux_UpdateOverHealBar(xButton)
    end
end

function HealBot_Update_AllAuxInHealsBars()
      --HealBot_setCall("HealBot_Update_AllAuxInHealsBars")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Aux_UpdateHealInBar(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Aux_UpdateHealInBar(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Aux_UpdateHealInBar(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Aux_UpdateHealInBar(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Aux_UpdateHealInBar(xButton)
    end
end

function HealBot_Update_AllAuxAbsorbBars()
      --HealBot_setCall("HealBot_Update_AllAuxAbsorbBars")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Aux_UpdateAbsorbBar(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Aux_UpdateAbsorbBar(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Aux_UpdateAbsorbBar(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Aux_UpdateAbsorbBar(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Aux_UpdateAbsorbBar(xButton)
    end
end

function HealBot_Update_AllAuxTotalHealAbsorbBars()
      --HealBot_setCall("HealBot_Update_AllAuxTotalHealAbsorbBars")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Aux_UpdateTotalHealAbsorbsBar(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Aux_UpdateTotalHealAbsorbsBar(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Aux_UpdateTotalHealAbsorbsBar(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Aux_UpdateTotalHealAbsorbsBar(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Aux_UpdateTotalHealAbsorbsBar(xButton)
    end
end

function HealBot_Update_AuxClearAllMarkedBars()
      --HealBot_setCall("HealBot_Update_AuxClearAllMarkedBars")
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
    for xUnit,xButton in pairs(HealBot_UnitTarget_Button) do
        HealBot_Aux_clearMarkedBars(xButton)
    end
    for xUnit,xButton in pairs(HealBot_PrivateTarget_Button) do
        HealBot_Aux_clearMarkedBars(xButton)
    end
end

function HealBot_Update_AuxTextButtons()
      --HealBot_setCall("HealBot_Update_AuxTextButtons")
    for x=1,9 do
        for _,xButton in pairs(HealBot_Unit_Button) do
            HealBot_Aux_ResetTextByTypeById(xButton, x)
        end
        for _,xButton in pairs(HealBot_Private_Button) do
            HealBot_Aux_ResetTextByTypeById(xButton, x)
        end
        for _,xButton in pairs(HealBot_Pet_Button) do
            HealBot_Aux_ResetTextByTypeById(xButton, x)
        end
        for _,xButton in pairs(HealBot_Vehicle_Button) do
            HealBot_Aux_ResetTextByTypeById(xButton, x)
        end
        for _,xButton in pairs(HealBot_Enemy_Button) do
            HealBot_Aux_ResetTextByTypeById(xButton, x)
        end
        for xUnit,xButton in pairs(HealBot_UnitTarget_Button) do
            HealBot_Aux_ResetTextByTypeById(xButton, x)
        end
        for xUnit,xButton in pairs(HealBot_PrivateTarget_Button) do
            HealBot_Aux_ResetTextByTypeById(xButton, x)
        end
        for _,xButton in pairs(HealBot_Extra_Button) do
            HealBot_Aux_ResetTextByTypeById(xButton, x)
        end
    end
end

function HealBot_Update_AllHotBars()
      --HealBot_setCall("HealBot_Update_AllHotBars")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Action_UpdateHotBar(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Action_UpdateHotBar(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Action_UpdateHotBar(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Action_UpdateHotBar(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Action_UpdateHotBar(xButton)
    end
end

function HealBot_Update_AllBackground()
      --HealBot_setCall("HealBot_Update_AllBackground")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Action_UpdateBackground(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Action_UpdateBackground(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Action_UpdateBackground(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Action_UpdateBackground(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Action_UpdateBackground(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Action_UpdateBackground(xButton)
    end
    for xUnit,xButton in pairs(HealBot_UnitTarget_Button) do
        HealBot_Action_UpdateBackground(xButton)
    end
    for xUnit,xButton in pairs(HealBot_PrivateTarget_Button) do
        HealBot_Action_UpdateBackground(xButton)
    end
end

function HealBot_Update_AllStateIconAFK()
      --HealBot_setCall("HealBot_Update_AllStateIconAFK")
    for _,xButton in pairs(HealBot_Unit_Button) do
       HealBot_Events_UnitFlagsChanged(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
       HealBot_Events_UnitFlagsChanged(xButton)
    end
end

function HealBot_Update_AllStateIconNotInCombat()
      --HealBot_setCall("HealBot_Update_AllStateIconNotInCombat")
    for _,xButton in pairs(HealBot_Unit_Button) do
       HealBot_UnitAffectingCombat(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
       HealBot_UnitAffectingCombat(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
       HealBot_UnitAffectingCombat(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
       HealBot_UnitAffectingCombat(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
       HealBot_UnitAffectingCombat(xButton)
    end
end

function HealBot_Update_ButtonStateIconHostile(button)
    button.icon.extra.hostile=false
    HealBot_Events_ClassificationChanged(button)
end

function HealBot_Update_AllStateIconHostile()
      --HealBot_setCall("HealBot_Update_AllStateIconHostile")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Update_ButtonStateIconHostile(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Update_ButtonStateIconHostile(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Update_ButtonStateIconHostile(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Update_ButtonStateIconHostile(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Update_ButtonStateIconHostile(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Update_ButtonStateIconHostile(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Update_ButtonStateIconHostile(xButton)
    end
    for xUnit,xButton in pairs(HealBot_UnitTarget_Button) do
        HealBot_Update_ButtonStateIconHostile(xButton)
    end
    for xUnit,xButton in pairs(HealBot_PrivateTarget_Button) do
        HealBot_Update_ButtonStateIconHostile(xButton)
    end
end

function HealBot_Update_RaidTarget()
    for _,xButton in pairs(HealBot_Unit_Button) do
        if xButton.icon.extra.targeticon>0 then
            HealBot_Aura_RaidTargetUpdate(xButton,0)
        end
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        if xButton.icon.extra.targeticon>0 then
            HealBot_Aura_RaidTargetUpdate(xButton,0)
        end
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        if xButton.icon.extra.targeticon>0 then
            HealBot_Aura_RaidTargetUpdate(xButton,0)
        end
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        if xButton.icon.extra.targeticon>0 then
            HealBot_Aura_RaidTargetUpdate(xButton,0)
        end
    end
    for xUnit,xButton in pairs(HealBot_UnitTarget_Button) do
        if xButton.icon.extra.targeticon>0 then
            HealBot_Aura_RaidTargetUpdate(xButton,0)
        end
    end
    for xUnit,xButton in pairs(HealBot_PrivateTarget_Button) do
        if xButton.icon.extra.targeticon>0 then
            HealBot_Aura_RaidTargetUpdate(xButton,0)
        end
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        if xButton.icon.extra.targeticon>0 then
            HealBot_Aura_RaidTargetUpdate(xButton,0)
        end
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        if xButton.icon.extra.targeticon>0 then
            HealBot_Aura_RaidTargetUpdate(xButton,0)
        end
    end
end

function HealBot_Update_RaidTargetReset()
    HealBot_Update_RaidTarget()
    HealBot_Events_RaidTargetAll()
end

function HealBot_Update_ClassIconTexture()
      --HealBot_setCall("HealBot_Update_ClassIconTexture")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Action_SetClassIconTexture(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Action_SetClassIconTexture(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Action_SetClassIconTexture(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Action_SetClassIconTexture(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Action_SetClassIconTexture(xButton)
    end
end

function HealBot_Update_AllIcons()
      --HealBot_setCall("HealBot_Update_AllIcons")
    if not HealBot_Update_luVars["TestBarsOn"] then
        HealBot_Timers_Set("AURA","UpdateAllDebuffIcons")
        HealBot_Timers_Set("AURA","UpdateAllBuffIcons")
        HealBot_Timers_Set("AURA","UpdateAllExtraIcons")
    end
end

function HealBot_Update_ClearAllBuffs(enemyOnly)
      --HealBot_setCall("HealBot_Update_ClearAllBuffs")
    if not enemyOnly then
        for _,xButton in pairs(HealBot_Unit_Button) do
            HealBot_Aura_ClearBuff(xButton)
        end
        for _,xButton in pairs(HealBot_Private_Button) do
            HealBot_Aura_ClearBuff(xButton)
        end
        for _,xButton in pairs(HealBot_Pet_Button) do
            HealBot_Aura_ClearBuff(xButton)
        end
        for _,xButton in pairs(HealBot_Vehicle_Button) do
            HealBot_Aura_ClearBuff(xButton)
        end
        for _,xButton in pairs(HealBot_Extra_Button) do
            HealBot_Aura_ClearBuff(xButton)
        end
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Aura_ClearBuff(xButton)
    end
    for xUnit,xButton in pairs(HealBot_UnitTarget_Button) do
        HealBot_Aura_ClearBuff(xButton)
    end
    for xUnit,xButton in pairs(HealBot_PrivateTarget_Button) do
        HealBot_Aura_ClearBuff(xButton)
    end
    HealBot_Update_RemoveAllBuffIcons(enemyOnly)
end

function HealBot_Update_ClearAllDebuffs(enemyOnly)
        --HealBot_setCall("HealBot_Update_ClearAllDebuffs")
    if not enemyOnly then
        for _,xButton in pairs(HealBot_Unit_Button) do
            HealBot_Aura_ClearDebuff(xButton)
        end
        for _,xButton in pairs(HealBot_Private_Button) do
            HealBot_Aura_ClearDebuff(xButton)
        end
        for _,xButton in pairs(HealBot_Pet_Button) do
            HealBot_Aura_ClearDebuff(xButton)
        end
        for _,xButton in pairs(HealBot_Vehicle_Button) do
            HealBot_Aura_ClearDebuff(xButton)
        end
        for _,xButton in pairs(HealBot_Extra_Button) do
            HealBot_Aura_ClearDebuff(xButton)
        end
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Aura_ClearDebuff(xButton)
    end
    for xUnit,xButton in pairs(HealBot_UnitTarget_Button) do
        HealBot_Aura_ClearDebuff(xButton)
    end
    for xUnit,xButton in pairs(HealBot_PrivateTarget_Button) do
        HealBot_Aura_ClearDebuff(xButton)
    end
    HealBot_Update_RemoveAllDebuffIcons(enemyOnly)
end

function HealBot_Update_AuraAllRank()
      --HealBot_setCall("HealBot_Update_AuraAllRank")
    for _,xButton in pairs(HealBot_Unit_Button) do
       HealBot_Aura_UpdateRank(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
       HealBot_Aura_UpdateRank(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
       HealBot_Aura_UpdateRank(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
       HealBot_Aura_UpdateRank(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
       HealBot_Aura_UpdateRank(xButton)
    end
end

function HealBot_Update_AllOverShields()
      --HealBot_setCall("HealBot_Update_AuraAllState")
    for _,xButton in pairs(HealBot_Unit_Button) do
       HealBot_Action_OverShield(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
       HealBot_Action_OverShield(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
       HealBot_Action_OverShield(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
       HealBot_Action_OverShield(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
       HealBot_Action_OverShield(xButton)
    end
end

function HealBot_Update_RemoveAllBuffIcons(enemyOnly)
    if not enemyOnly then
        --HealBot_setCall("HealBot_Update_RemoveAllBuffIcons")
        for _,xButton in pairs(HealBot_Unit_Button) do
            HealBot_Aura_RemoveBuffIcons(xButton)
        end
        for _,xButton in pairs(HealBot_Private_Button) do
            HealBot_Aura_RemoveBuffIcons(xButton)
        end
        for _,xButton in pairs(HealBot_Pet_Button) do
            HealBot_Aura_RemoveBuffIcons(xButton)
        end
        for _,xButton in pairs(HealBot_Extra_Button) do
            HealBot_Aura_RemoveBuffIcons(xButton)
        end
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Aura_RemoveBuffIcons(xButton)
    end
    for xUnit,xButton in pairs(HealBot_UnitTarget_Button) do
        HealBot_Aura_RemoveBuffIcons(xButton)
    end
    for xUnit,xButton in pairs(HealBot_PrivateTarget_Button) do
        HealBot_Aura_RemoveBuffIcons(xButton)
    end
end

function HealBot_Update_RemoveUnusedBuffIcons()
        --HealBot_setCall("HealBot_Update_RemoveUnusedBuffIcons")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Aura_RemoveUnusedBuffIconsButton(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Aura_RemoveUnusedBuffIconsButton(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Aura_RemoveUnusedBuffIconsButton(xButton)
    end
    for xUnit,xButton in pairs(HealBot_PrivateTarget_Button) do
        HealBot_Aura_RemoveUnusedBuffIconsButton(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Aura_RemoveUnusedBuffIconsButton(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Aura_RemoveUnusedBuffIconsButton(xButton)
    end
end

function HealBot_Update_RemoveAllDebuffIcons(enemyOnly)
    if not enemyOnly then
        --HealBot_setCall("HealBot_Update_RemoveAllDebuffIcons")
        for _,xButton in pairs(HealBot_Unit_Button) do
            HealBot_Aura_RemoveDebuffIcons(xButton)
        end
        for _,xButton in pairs(HealBot_Private_Button) do
            HealBot_Aura_RemoveDebuffIcons(xButton)
        end
        for _,xButton in pairs(HealBot_Pet_Button) do
            HealBot_Aura_RemoveDebuffIcons(xButton)
        end
        for _,xButton in pairs(HealBot_Vehicle_Button) do
            HealBot_Aura_RemoveDebuffIcons(xButton)
        end
        for _,xButton in pairs(HealBot_Extra_Button) do
            HealBot_Aura_RemoveDebuffIcons(xButton)
        end
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Aura_RemoveDebuffIcons(xButton)
    end
    for xUnit,xButton in pairs(HealBot_UnitTarget_Button) do
        HealBot_Aura_RemoveDebuffIcons(xButton)
    end
    for xUnit,xButton in pairs(HealBot_PrivateTarget_Button) do
        HealBot_Aura_RemoveDebuffIcons(xButton)
    end
end

function HealBot_Update_RemoveUnusedDebuffIcons()
        --HealBot_setCall("HealBot_Update_RemoveUnusedDebuffIcons")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Aura_RemoveUnusedDebuffIconsButton(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Aura_RemoveUnusedDebuffIconsButton(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Aura_RemoveUnusedDebuffIconsButton(xButton)
    end
    for xUnit,xButton in pairs(HealBot_UnitTarget_Button) do
        HealBot_Aura_RemoveUnusedDebuffIconsButton(xButton)
    end
    for xUnit,xButton in pairs(HealBot_PrivateTarget_Button) do
        HealBot_Aura_RemoveUnusedDebuffIconsButton(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Aura_RemoveUnusedDebuffIconsButton(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Aura_RemoveUnusedDebuffIconsButton(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Aura_RemoveUnusedDebuffIconsButton(xButton)
    end
end

function HealBot_Update_RemoveExtraIcons(index)
        --HealBot_setCall("HealBot_Update_RemoveExtraIcons")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Aura_RemoveExtraUnitIcons(xButton, index)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Aura_RemoveExtraUnitIcons(xButton, index)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Aura_RemoveExtraUnitIcons(xButton, index)
    end
    for xUnit,xButton in pairs(HealBot_UnitTarget_Button) do
        HealBot_Aura_RemoveExtraUnitIcons(xButton, index)
    end
    for xUnit,xButton in pairs(HealBot_PrivateTarget_Button) do
        HealBot_Aura_RemoveExtraUnitIcons(xButton, index)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Aura_RemoveExtraUnitIcons(xButton, index)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Aura_RemoveExtraUnitIcons(xButton, index)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Aura_RemoveExtraUnitIcons(xButton, index)
    end
end

function HealBot_Update_AllUnitBars(playersOnly)
      --HealBot_setCall("HealBot_Update_AllUnitBars")
    for _,xButton in pairs(HealBot_Unit_Button) do
        xButton.status.slowupdate=true
        xButton.status.update=true
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        xButton.status.slowupdate=true
        xButton.status.update=true
    end
    if not playersOnly then
        for _,xButton in pairs(HealBot_Pet_Button) do
            xButton.status.slowupdate=true
            xButton.status.update=true
        end
        for _,xButton in pairs(HealBot_Vehicle_Button) do
            xButton.status.slowupdate=true
            xButton.status.update=true
        end
        for _,xButton in pairs(HealBot_Extra_Button) do
            xButton.status.slowupdate=true
            xButton.status.update=true
        end
        for _,xButton in pairs(HealBot_Enemy_Button) do
            xButton.status.slowupdate=true
            xButton.status.update=true
        end
        for xUnit,xButton in pairs(HealBot_UnitTarget_Button) do
            xButton.status.slowupdate=true
            xButton.status.update=true
        end
        for xUnit,xButton in pairs(HealBot_PrivateTarget_Button) do
            xButton.status.slowupdate=true
            xButton.status.update=true
        end
    end
end

function HealBot_Update_ResetUnitStatus(enemyOnly)
      --HealBot_setCall("HealBot_Update_ResetUnitStatus")
    if not enemyOnly then
        for _,xButton in pairs(HealBot_Unit_Button) do
            HealBot_RefreshUnit(xButton)
        end
        for _,xButton in pairs(HealBot_Private_Button) do
            HealBot_RefreshUnit(xButton)
        end
        for _,xButton in pairs(HealBot_Extra_Button) do
            HealBot_RefreshUnit(xButton)
        end
        for _,xButton in pairs(HealBot_Pet_Button) do
            HealBot_RefreshUnit(xButton)
        end
        for _,xButton in pairs(HealBot_Vehicle_Button) do
            HealBot_RefreshUnit(xButton)
        end
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_RefreshUnit(xButton)
    end
    for xUnit,xButton in pairs(HealBot_UnitTarget_Button) do
        HealBot_RefreshUnit(xButton)
    end
    for xUnit,xButton in pairs(HealBot_PrivateTarget_Button) do
        HealBot_RefreshUnit(xButton)
    end
end

function HealBot_Update_ResetUnitsEnemyOnly()
    HealBot_Update_ResetUnitStatus(true)
end

function HealBot_Update_ResetActiveUnitStatus()
      --HealBot_setCall("HealBot_Update_ResetActiveUnitStatus")
    for xUnit,xButton in pairs(HealBot_Unit_Button) do
        if xButton.status.current<HealBot_Unit_Status["DC"] and xButton.status.current>HealBot_Unit_Status["DISABLED"] then
            HealBot_RefreshUnit(xButton)
        end
    end
    for xUnit,xButton in pairs(HealBot_Private_Button) do
        if xButton.status.current<HealBot_Unit_Status["DC"] and xButton.status.current>HealBot_Unit_Status["DISABLED"] then
            HealBot_RefreshUnit(xButton)
        end
    end
    for xUnit,xButton in pairs(HealBot_Pet_Button) do
        if xButton.status.current<HealBot_Unit_Status["DC"] and xButton.status.current>HealBot_Unit_Status["DISABLED"] then
            HealBot_RefreshUnit(xButton)
        end
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        if xButton.status.current<HealBot_Unit_Status["DC"] and xButton.status.current>HealBot_Unit_Status["DISABLED"] then
            HealBot_RefreshUnit(xButton)
        end
    end
    for xUnit,xButton in pairs(HealBot_Extra_Button) do
        if xButton.status.current<HealBot_Unit_Status["DC"] and xButton.status.current>HealBot_Unit_Status["DISABLED"] then
            HealBot_RefreshUnit(xButton)
        end
    end
end

function HealBot_Update_CheckDC()
      --HealBot_setCall("HealBot_Update_CheckDC")
    for _,xButton in pairs(HealBot_Unit_Button) do
        if xButton.status.current == HealBot_Unit_Status["DC"] then
            HealBot_Events_UnitStatus(xButton)
        end
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        if xButton.status.current == HealBot_Unit_Status["DC"] then
            HealBot_Events_UnitStatus(xButton)
        end
    end
end

function HealBot_Update_AllHealth()
      --HealBot_setCall("HealBot_Update_AllHealth")
    for _,xButton in pairs(HealBot_Unit_Button) do
        xButton.health.slowupd=true
        xButton.status.slowupdate=true
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        xButton.health.slowupd=true
        xButton.status.slowupdate=true
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        xButton.health.slowupd=true
        xButton.status.slowupdate=true
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        xButton.health.slowupd=true
        xButton.status.slowupdate=true
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        xButton.health.slowupd=true
        xButton.status.slowupdate=true
    end
end

function HealBot_Update_ClearLowMana(frame)
      --HealBot_setCall("HealBot_Update_ClearLowMana")
    for _,xButton in pairs(HealBot_Unit_Button) do
        if xButton.frame == frame then
            HealBot_DoClearLowMana(xButton)
        end
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        if xButton.frame == frame then
            HealBot_DoClearLowMana(xButton)
        end
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        if xButton.frame == frame then
            HealBot_DoClearLowMana(xButton)
        end
    end
end

function HealBot_Update_LowMana()
      --HealBot_setCall("HealBot_Update_LowMana")
    for _,xButton in pairs(HealBot_Unit_Button) do
        xButton.mana.lowcheck=true
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        xButton.mana.lowcheck=true
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        xButton.mana.lowcheck=true
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        xButton.mana.lowcheck=true
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        xButton.mana.lowcheck=true
    end
end

function HealBot_Update_AllEmergBars()
      --HealBot_setCall("HealBot_Update_AllEmergBars")
    for _,xButton in pairs(HealBot_Unit_Button) do
        xButton.status.emergupd=true
        xButton.status.slowupdate=true
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        xButton.status.emergupd=true
        xButton.status.slowupdate=true
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        xButton.status.emergupd=true
        xButton.status.slowupdate=true
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        xButton.status.emergupd=true
        xButton.status.slowupdate=true
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        xButton.status.emergupd=true
        xButton.status.slowupdate=true
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        xButton.status.emergupd=true
        xButton.status.slowupdate=true
    end
    for xUnit,xButton in pairs(HealBot_UnitTarget_Button) do
        xButton.status.emergupd=true
        xButton.status.slowupdate=true
    end
    for xUnit,xButton in pairs(HealBot_PrivateTarget_Button) do
        xButton.status.emergupd=true
        xButton.status.slowupdate=true
    end
end

function HealBot_Update_AllAuras()
      --HealBot_setCall("HealBot_Update_AllAuras")
    HealBot_Update_AllBuffs()
    HealBot_Update_AllDebuffs()
end

function HealBot_Update_AllBuffs()
      --HealBot_setCall("HealBot_Update_AllBuffs")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_BuffSlowUpdate(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_BuffSlowUpdate(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_BuffSlowUpdate(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_BuffSlowUpdate(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_BuffSlowUpdate(xButton)
    end
end

function HealBot_Update_AllDebuffs()
      --HealBot_setCall("HealBot_Update_AllDebuffs")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_DebuffSlowUpdate(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_DebuffSlowUpdate(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_DebuffSlowUpdate(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_DebuffSlowUpdate(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_DebuffSlowUpdate(xButton)
    end
end

function HealBot_Update_AllDebuffsReindexActives()
      --HealBot_setCall("HealBot_Update_AllDebuffsReindexActives")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Aura_UnitDebuffsUpdateWhenActive(xButton)
        HealBot_DebuffSlowUpdate(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Aura_UnitDebuffsUpdateWhenActive(xButton)
        HealBot_DebuffSlowUpdate(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Aura_UnitDebuffsUpdateWhenActive(xButton)
        HealBot_DebuffSlowUpdate(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Aura_UnitDebuffsUpdateWhenActive(xButton)
        HealBot_DebuffSlowUpdate(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Aura_UnitDebuffsUpdateWhenActive(xButton)
        HealBot_DebuffSlowUpdate(xButton)
    end
end

function HealBot_Update_AdaptiveDown(id)
      --HealBot_setCall("HealBot_Update_AdaptiveDown")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Action_AdaptiveDownButton(xButton, id)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Action_AdaptiveDownButton(xButton, id)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Action_AdaptiveDownButton(xButton, id)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Action_AdaptiveDownButton(xButton, id)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Action_AdaptiveDownButton(xButton, id)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Action_AdaptiveDownButton(xButton, id)
    end
end

function HealBot_Update_AdaptiveUp(id)
      --HealBot_setCall("HealBot_Update_AdaptiveUp")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Action_AdaptiveUpButton(xButton, id)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Action_AdaptiveUpButton(xButton, id)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Action_AdaptiveUpButton(xButton, id)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Action_AdaptiveUpButton(xButton, id)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Action_AdaptiveUpButton(xButton, id)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Action_AdaptiveUpButton(xButton, id)
    end
end

function HealBot_Update_DisableEmergButtonGlow()
      --HealBot_setCall("HealBot_Update_DisableEmergButtonGlow")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Action_DisableEmergButtonGlowKeys(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Action_DisableEmergButtonGlowKeys(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Action_DisableEmergButtonGlowKeys(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Action_DisableEmergButtonGlowKeys(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Action_DisableEmergButtonGlowKeys(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Action_DisableEmergButtonGlowKeys(xButton)
    end
end

function HealBot_Update_ButtonGlow(enable)
      --HealBot_setCall("HealBot_Update_ButtonGlow")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Action_UpdateButtonGlow(xButton, enable)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Action_UpdateButtonGlow(xButton, enable)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Action_UpdateButtonGlow(xButton, enable)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Action_UpdateButtonGlow(xButton, enable)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Action_UpdateButtonGlow(xButton, enable)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Action_UpdateButtonGlow(xButton, enable)
    end
end

function HealBot_Update_DisableButtonIconsGlow()
      --HealBot_setCall("HealBot_Update_DisableButtonIconsGlow")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Action_DisableIconsGlow(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Action_DisableIconsGlow(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Action_DisableIconsGlow(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Action_DisableIconsGlow(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Action_DisableIconsGlow(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Action_DisableIconsGlow(xButton)
    end
    for xUnit,xButton in pairs(HealBot_UnitTarget_Button) do
        HealBot_Action_DisableIconsGlow(xButton)
    end
    for xUnit,xButton in pairs(HealBot_PrivateTarget_Button) do
        HealBot_Action_DisableIconsGlow(xButton)
    end
end

function HealBot_Update_ResetUnitOpacity()
      --HealBot_setCall("HealBot_Update_ResetUnitOpacity")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Action_ResetUnitButtonOpacity(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Action_ResetUnitButtonOpacity(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Action_ResetUnitButtonOpacity(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Action_ResetUnitButtonOpacity(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Action_ResetUnitButtonOpacity(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Action_ResetUnitButtonOpacity(xButton)
    end
    for xUnit,xButton in pairs(HealBot_UnitTarget_Button) do
        HealBot_Action_ResetUnitButtonOpacity(xButton)
    end
    for xUnit,xButton in pairs(HealBot_PrivateTarget_Button) do
        HealBot_Action_ResetUnitButtonOpacity(xButton)
    end
    --HealBot_Timers_Set("LAST","ResetUnitStatus")
end

function HealBot_Update_RegisterForClicks(button)
      --HealBot_setCall("HealBot_Update_RegisterForClicks", button)
    if button then
        HealBot_Action_ButtonRegisterForClicks(button)
    else
        for _,xButton in pairs(HealBot_Unit_Button) do
            HealBot_Action_ButtonRegisterForClicks(xButton)
        end
        for _,xButton in pairs(HealBot_Private_Button) do
            HealBot_Action_ButtonRegisterForClicks(xButton)
        end
        for _,xButton in pairs(HealBot_Enemy_Button) do
            HealBot_Action_ButtonRegisterForClicks(xButton)
        end
        for xUnit,xButton in pairs(HealBot_UnitTarget_Button) do
            HealBot_Action_ButtonRegisterForClicks(xButton)
        end
        for xUnit,xButton in pairs(HealBot_PrivateTarget_Button) do
            HealBot_Action_ButtonRegisterForClicks(xButton)
        end
        for _,xButton in pairs(HealBot_Pet_Button) do
            HealBot_Action_ButtonRegisterForClicks(xButton)
        end
        for _,xButton in pairs(HealBot_Vehicle_Button) do
            HealBot_Action_ButtonRegisterForClicks(xButton)
        end
        for _,xButton in pairs(HealBot_Extra_Button) do
            HealBot_Action_ButtonRegisterForClicks(xButton)
        end
    end
end

function HealBot_Update_ResetrCalls()
      --HealBot_setCall("HealBot_Update_ResetrCalls")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Action_ResetrCallsUnit(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Action_ResetrCallsUnit(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Action_ResetrCallsUnit(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Action_ResetrCallsUnit(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Action_ResetrCallsUnit(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Action_ResetrCallsUnit(xButton)
    end
    for xUnit,xButton in pairs(HealBot_UnitTarget_Button) do
        HealBot_Action_ResetrCallsUnit(xButton)
    end
    for xUnit,xButton in pairs(HealBot_PrivateTarget_Button) do
        HealBot_Action_ResetrCallsUnit(xButton)
    end
end

function HealBot_Update_SetEnabledAttribs()
      --HealBot_setCall("HealBot_Update_SetEnabledAttribs")
    HealBot_Action_ClearSpellCache("ENABLED")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Action_MarkAttribUpdateButton(xButton, true, false, false)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Action_MarkAttribUpdateButton(xButton, true, false, false)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Action_MarkAttribUpdateButton(xButton, true, false, false)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Action_MarkAttribUpdateButton(xButton, true, false, false)
    end
    for xUnit,xButton in pairs(HealBot_UnitTarget_Button) do
        HealBot_Action_MarkAttribUpdateButton(xButton, true, false, false)
    end
    for xUnit,xButton in pairs(HealBot_PrivateTarget_Button) do
        HealBot_Action_MarkAttribUpdateButton(xButton, true, false, false)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Action_MarkAttribUpdateButton(xButton, true, false, false)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Action_MarkAttribUpdateButton(xButton, true, false, false)
    end
end

function HealBot_Update_SetEnemyAttribs()
      --HealBot_setCall("HealBot_Update_SetEnemyAttribs")
    HealBot_Action_ClearSpellCache("ENEMY")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Action_MarkAttribUpdateButton(xButton, false, true, false)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Action_MarkAttribUpdateButton(xButton, false, true, false)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Action_MarkAttribUpdateButton(xButton, false, true, false)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Action_MarkAttribUpdateButton(xButton, false, true, false)
    end
    for xUnit,xButton in pairs(HealBot_UnitTarget_Button) do
        HealBot_Action_MarkAttribUpdateButton(xButton, false, true, false)
    end
    for xUnit,xButton in pairs(HealBot_PrivateTarget_Button) do
        HealBot_Action_MarkAttribUpdateButton(xButton, false, true, false)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Action_MarkAttribUpdateButton(xButton, false, true, false)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Action_MarkAttribUpdateButton(xButton, false, true, false)
    end
end

function HealBot_Update_SetEmergAttribs()
      --HealBot_setCall("HealBot_Update_SetEmergAttribs")
    HealBot_Action_ClearSpellCache("EMERG")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Action_MarkAttribUpdateButton(xButton, false, false, true)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Action_MarkAttribUpdateButton(xButton, false, false, true)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Action_MarkAttribUpdateButton(xButton, false, false, true)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Action_MarkAttribUpdateButton(xButton, false, false, true)
    end
    for xUnit,xButton in pairs(HealBot_UnitTarget_Button) do
        HealBot_Action_MarkAttribUpdateButton(xButton, false, false, true)
    end
    for xUnit,xButton in pairs(HealBot_PrivateTarget_Button) do
        HealBot_Action_MarkAttribUpdateButton(xButton, false, false, true)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Action_MarkAttribUpdateButton(xButton, false, false, true)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Action_MarkAttribUpdateButton(xButton, false, false, true)
    end
end

function HealBot_Update_ResetInitButtons()
      --HealBot_setCall("HealBot_Update_ResetInitButtons")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Action_MarkDeleteButton(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Action_MarkDeleteButton(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Action_MarkDeleteButton(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Action_MarkDeleteButton(xButton)
    end
    for xUnit,xButton in pairs(HealBot_UnitTarget_Button) do
        HealBot_Action_MarkDeleteButton(xButton)
    end
    for xUnit,xButton in pairs(HealBot_PrivateTarget_Button) do
        HealBot_Action_MarkDeleteButton(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Action_MarkDeleteButton(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Action_MarkDeleteButton(xButton)
    end
end

function HealBot_Update_TextButtons()
      --HealBot_setCall("HealBot_Update_TextButtons")
    if not HealBot_Update_luVars["TestBarsOn"] then
        for _,xButton in pairs(HealBot_Unit_Button) do
            HealBot_Text_UpdateButton(xButton)
        end
        for _,xButton in pairs(HealBot_Private_Button) do
            HealBot_Text_UpdateButton(xButton)
        end
        for _,xButton in pairs(HealBot_Pet_Button) do
            HealBot_Text_UpdateButton(xButton)
        end
        for _,xButton in pairs(HealBot_Vehicle_Button) do
            HealBot_Text_UpdateButton(xButton)
        end
        for _,xButton in pairs(HealBot_UnitTarget_Button) do
            HealBot_Text_UpdateButton(xButton)
        end
        for _,xButton in pairs(HealBot_PrivateTarget_Button) do
            HealBot_Text_UpdateButton(xButton)
        end
        for _,xButton in pairs(HealBot_Enemy_Button) do
            HealBot_Text_UpdateButton(xButton)
        end
        for _,xButton in pairs(HealBot_Extra_Button) do
            HealBot_Text_UpdateButton(xButton)
        end
    else
        for _,xButton in pairs(HealBot_Test_Button) do
            HealBot_Text_UpdateTestText(xButton)
        end
    end
end

function HealBot_Update_TextNames(enemyOnly)
      --HealBot_setCall("HealBot_Update_TextNames")
    if not enemyOnly then
        for _,xButton in pairs(HealBot_Unit_Button) do
            HealBot_Text_UpdateNameButton(xButton)
        end
        for _,xButton in pairs(HealBot_Private_Button) do
            HealBot_Text_UpdateNameButton(xButton)
        end
        for _,xButton in pairs(HealBot_Pet_Button) do
            HealBot_Text_UpdateNameButton(xButton)
        end
        for _,xButton in pairs(HealBot_Vehicle_Button) do
            HealBot_Text_UpdateNameButton(xButton)
        end
        for _,xButton in pairs(HealBot_Extra_Button) do
            HealBot_Text_UpdateNameButton(xButton)
        end
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Text_UpdateNameButton(xButton)
    end
    for _,xButton in pairs(HealBot_UnitTarget_Button) do
        HealBot_Text_UpdateNameButton(xButton)
    end
    for _,xButton in pairs(HealBot_PrivateTarget_Button) do
        HealBot_Text_UpdateNameButton(xButton)
    end
   -- HealBot_Timers_Set("LAST","ResetUnitStatus")
end

function HealBot_Update_TextNames_EnemyOnly()
    HealBot_Update_TextNames(true)
end

function HealBot_Update_TextPlayersAlphaButtonNow(button)
    button.text.updatealpha=false
    button.text.tagupdate=true
    button.text.aggroupdate=true
    button.text.nameupdate=true
    button.text.healthupdate=true
    HealBot_Text_UpdateText(button)
end

function HealBot_Update_TextPlayersAlphaButton(button)
    button.text.updatealpha=true
    button.status.slowupdate=true
end

function HealBot_Update_TextPlayersAlpha()
      --HealBot_setCall("HealBot_Update_TextPlayersAlpha")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Update_TextPlayersAlphaButton(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Update_TextPlayersAlphaButton(xButton)
    end
   -- HealBot_Timers_Set("LAST","ResetUnitStatus")
end

function HealBot_Update_TextHealth()
      --HealBot_setCall("HealBot_Update_TextHealth")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Text_UpdateHealthButton(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Text_UpdateHealthButton(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Text_UpdateHealthButton(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Text_UpdateHealthButton(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Text_UpdateHealthButton(xButton)
    end
    for _,xButton in pairs(HealBot_UnitTarget_Button) do
        HealBot_Text_UpdateHealthButton(xButton)
    end
    for _,xButton in pairs(HealBot_PrivateTarget_Button) do
        HealBot_Text_UpdateHealthButton(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Text_UpdateHealthButton(xButton)
    end
   -- HealBot_Timers_Set("LAST","ResetUnitStatus")
end

function HealBot_Update_TextState()
      --HealBot_setCall("HealBot_Update_TextState")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Text_UpdateStateButton(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Text_UpdateStateButton(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Text_UpdateStateButton(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Text_UpdateStateButton(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Text_UpdateStateButton(xButton)
    end
    for _,xButton in pairs(HealBot_UnitTarget_Button) do
        HealBot_Text_UpdateStateButton(xButton)
    end
    for _,xButton in pairs(HealBot_PrivateTarget_Button) do
        HealBot_Text_UpdateStateButton(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Text_UpdateStateButton(xButton)
    end
   -- HealBot_Timers_Set("LAST","ResetUnitStatus")
end

function HealBot_Update_TextAggro()
      --HealBot_setCall("HealBot_Update_TextAggro")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Text_UpdateAggroButton(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Text_UpdateAggroButton(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Text_UpdateAggroButton(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Text_UpdateAggroButton(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Text_UpdateAggroButton(xButton)
    end
    for _,xButton in pairs(HealBot_UnitTarget_Button) do
        HealBot_Text_UpdateAggroButton(xButton)
    end
    for _,xButton in pairs(HealBot_PrivateTarget_Button) do
        HealBot_Text_UpdateAggroButton(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Text_UpdateAggroButton(xButton)
    end
   -- HealBot_Timers_Set("LAST","ResetUnitStatus")
end

function HealBot_Update_TextAux(id)
      --HealBot_setCall("HealBot_Update_TextAux")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Text_UpdateAuxButton(xButton, id)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Text_UpdateAuxButton(xButton, id)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Text_UpdateAuxButton(xButton, id)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Text_UpdateAuxButton(xButton, id)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Text_UpdateAuxButton(xButton, id)
    end
    for _,xButton in pairs(HealBot_UnitTarget_Button) do
        HealBot_Text_UpdateAuxButton(xButton, id)
    end
    for _,xButton in pairs(HealBot_PrivateTarget_Button) do
        HealBot_Text_UpdateAuxButton(xButton, id)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Text_UpdateAuxButton(xButton, id)
    end
   -- HealBot_Timers_Set("LAST","ResetUnitStatus")
end

function HealBot_Update_ConvertSpells(combo, maxButtons, cType)
      --HealBot_setCall("HealBot_Update_ConvertSpells")
    local button,key,sType,sID,keySpec=nil,nil,nil,nil,nil
    local HealBot_Keys_List=HealBot_Action_retComboKeysList()
    local vKeys={}
    for z=1,maxButtons do
        button=HealBot_Options_ComboClass_Button(z)
        for y=1, getn(HealBot_Keys_List), 1 do
            key=HealBot_Keys_List[y]..button
            vKeys[key]=true
            keySpec=HealBot_Action_GetComboSpec_OLD(HealBot_Keys_List[y], button)
            if combo[keySpec] then
                combo[key]=combo[keySpec]
                combo[keySpec]=nil
            end
        end
    end
    table.foreach(combo, function (key,val)
        if not vKeys[key] then
            combo[key] = nil
        end
    end);
end

function HealBot_Update_ConvertClassToPlayer()
    if HealBot_Data["PCLASSTRIM"] and HealBot_Data["PGUID"] then
        for x,_ in pairs(HealBot_Spells_Loadouts) do
            local c,l=string.split(":",x)
            l=tonumber(l)
            if c == HealBot_Data["PCLASSTRIM"] or c == HealBot_Data["PGUID"] then
                HealBot_Spell_Loadouts[l]=HealBot_Options_copyTable(HealBot_Spells_Loadouts[x])
                HealBot_Spells_Loadouts[x]=nil
            end
        end
    else
        HealBot_SetPlayerData()
        C_Timer.After(0.1, HealBot_Update_ConvertClassToPlayer)
    end
end

function HealBot_Update_NilOnVal(t, key, v)
    if t[key] and t[key] == v then t[key]=nil end
end

function HealBot_Update_GlobalVars()
    local customDebuffPriority=hbv_GetStatic("cDebuff")
    local customBuffPriority=hbv_GetStatic("cBuff")
    for sid,_  in pairs(HealBot_Globals.CustomBuffBarColour) do
        if sid~=customBuffPriority then
            if HealBot_Globals.CustomBuffBarColour[sid].R == 0.25 and HealBot_Globals.CustomBuffBarColour[sid].G == 0.58 and HealBot_Globals.CustomBuffBarColour[sid].B == 0.8 then
                HealBot_Globals.CustomBuffBarColour[sid]=nil
            end
        end
    end
    for sid,tag in pairs(HealBot_Globals.CustomBuffTag) do
        if string.len(tag)<3 then
            HealBot_Globals.CustomBuffTag[sid]=nil
        end
    end
    for sid,tag in pairs(HealBot_Globals.CDCTag) do
        if string.len(tag)<3 then
            HealBot_Globals.CDCTag[sid]=nil
        end
    end
    if HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol then
        for sid,col in pairs(HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol) do
            HealBot_Update_NilOnVal(HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol, sid, 1)
        end
        HealBot_Globals.CustomBuffsShowBarCol=HealBot_Options_copyTable(HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol)
        HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol=nil
    end
    if HealBot_Globals.HealBot_Custom_Buffs_IconGlow then
        HealBot_Globals.CustomBuffsIconGlow=HealBot_Options_copyTable(HealBot_Globals.HealBot_Custom_Buffs_IconGlow)
        HealBot_Globals.HealBot_Custom_Buffs_IconGlow=nil
    end
    for sid,_ in pairs(HealBot_Globals.CustomBuffsIconGlow) do
        HealBot_Update_NilOnVal(HealBot_Globals.CustomBuffsIconGlow, sid, 1)
    end
    if HealBot_Globals.HealBot_Custom_Buffs_IconSet then
        HealBot_Globals.CustomBuffsIconSet=HealBot_Options_copyTable(HealBot_Globals.HealBot_Custom_Buffs_IconSet)
        HealBot_Globals.HealBot_Custom_Buffs_IconSet=nil
    end
    for sid,_ in pairs(HealBot_Globals.CustomBuffsIconSet) do
        HealBot_Update_NilOnVal(HealBot_Globals.CustomBuffsIconSet, sid, 1)
    end
    if HealBot_Globals.HealBot_Custom_Buffs then
        HealBot_Globals.CustomBuffs=HealBot_Options_copyTable(HealBot_Globals.HealBot_Custom_Buffs)
        HealBot_Globals.HealBot_Custom_Buffs=nil
    end
    for sid,_ in pairs(HealBot_Globals.CustomBuffs) do
        HealBot_Update_NilOnVal(HealBot_Globals.CustomBuffs, sid, 20)
    end
    if HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol then
        for sid,col in pairs(HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol) do
            HealBot_Update_NilOnVal(HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol, sid, 4)
        end
        HealBot_Globals.CustomDebuffsShowBarCol=HealBot_Options_copyTable(HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol)
        HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol=nil
    end
    if HealBot_Globals.HealBot_Custom_Debuffs then
        HealBot_Globals.CustomDebuffs=HealBot_Options_copyTable(HealBot_Globals.HealBot_Custom_Debuffs)
        HealBot_Globals.HealBot_Custom_Debuffs=nil
    end
    if HealBot_Globals.HealBot_Custom_Debuffs_IconGlow then
        HealBot_Globals.CustomDebuffsIconGlow=HealBot_Options_copyTable(HealBot_Globals.HealBot_Custom_Debuffs_IconGlow)
        HealBot_Globals.HealBot_Custom_Debuffs_IconGlow=nil
    end
    for sid,_ in pairs(HealBot_Globals.CustomDebuffsIconGlow) do
        HealBot_Update_NilOnVal(HealBot_Globals.CustomDebuffsIconGlow, sid, 1)
    end
    if HealBot_Globals.HealBot_Custom_Debuffs_IconSet then
        HealBot_Globals.CustomDebuffsIconSet=HealBot_Options_copyTable(HealBot_Globals.HealBot_Custom_Debuffs_IconSet)
        HealBot_Globals.HealBot_Custom_Debuffs_IconSet=nil
    end
    for sid,_ in pairs(HealBot_Globals.CustomDebuffsIconSet) do
        HealBot_Update_NilOnVal(HealBot_Globals.CustomDebuffsIconSet, sid, 1)
    end
    if HealBot_Globals.HealBot_PermPrivateDamagers then
        HealBot_Globals.PermPrivateDamagers=HealBot_Options_copyTable(HealBot_Globals.HealBot_PermPrivateDamagers)
        HealBot_Globals.HealBot_PermPrivateDamagers=nil
    end
    if HealBot_Globals.HealBot_PermPrivateHealers then
        HealBot_Globals.PermPrivateHealers=HealBot_Options_copyTable(HealBot_Globals.HealBot_PermPrivateHealers)
        HealBot_Globals.HealBot_PermPrivateHealers=nil
    end
    if HealBot_Globals.HealBot_PermPrivateTanks then
        HealBot_Globals.PermPrivateTanks=HealBot_Options_copyTable(HealBot_Globals.HealBot_PermPrivateTanks)
        HealBot_Globals.HealBot_PermPrivateTanks=nil
    end
    if HealBot_Globals.HealBot_PermMyTargets then
        HealBot_Globals.PermMyTargets=HealBot_Options_copyTable(HealBot_Globals.HealBot_PermMyTargets)
        HealBot_Globals.HealBot_PermMyTargets=nil
    end
    if HealBot_Globals.HealBot_customPermUserName then
        HealBot_Globals.PermUserName=HealBot_Options_copyTable(HealBot_Globals.HealBot_customPermUserName)
        HealBot_Globals.HealBot_customPermUserName=nil
    end
    for sid,_  in pairs(HealBot_Globals.CDCBarColour) do
        if sid~=customDebuffPriority then
            if HealBot_Globals.CDCBarColour[sid].R == 0.45 and HealBot_Globals.CDCBarColour[sid].G == 0 and HealBot_Globals.CDCBarColour[sid].B == 0.26 then
                HealBot_Globals.CDCBarColour[sid]=nil
            end
        end
    end
    HealBot_Globals.HealBot_Emotes=nil
    HealBot_Globals.HealBot_Custom_Debuffs_EnableBar=nil
    HealBot_Globals.VersionResetDone=nil
    HealBot_Globals.HealBot_Custom_Buffs_EnableBar=nil
    
    HealBot_Config.BuffReset=nil
    HealBot_Config.SpecIDAtSave=nil
    HealBot_Config.Skin_ID=nil
    HealBot_Config.SpellsUpdatedToV10=nil
    HealBot_Config.EnableHealthy=nil
end

function HealBot_Update_SkinDefault(skinName, id)
    if HealBot_Config.SkinDefault[skinName][id]~=nil then 
        if HealBot_Config.SkinDefault[skinName][id] == 1 then
            HealBot_Config.SkinDefault[skinName][id]=true
        elseif type(HealBot_Config.SkinDefault[skinName][id]) == "boolean" then
            hbv_SkinDefault_SetData(HealBot_Config.SkinDefault[skinName][id], skinName, id)
        else
            HealBot_Config.SkinDefault[skinName][id]=nil
        end
    end
end

local skinName=""
function HealBot_Update_Skins()
      --HealBot_setCall("HealBot_Update_Skins")
    local oldVersion=10
    if HealBot_Config.LastVersionSkinUpdate then HealBot_Config.LastVersionSkinUpdate=nil end

    local foundSkin=false
    for x in pairs (Healbot_Config_Skins.Skins) do
        if Healbot_Config_Skins.Skins[x] == Healbot_Config_Skins.Current_Skin then foundSkin=true end
    end
    if not foundSkin then
        local retryWithSkin=HealBot_getDefaultSkin()
        HealBot_Options_Set_Current_Skin(retryWithSkin, nil, true, true)
    end
    if not HealBot_Config_Spells.SpellsReset then
        if HealBot_Config_Spells.EnabledKeyCombo then HealBot_Update_ConvertSpells(HealBot_Config_Spells.EnabledKeyCombo, 20, "ENABLED") end
        if HealBot_Config_Spells.EnemyKeyCombo then HealBot_Update_ConvertSpells(HealBot_Config_Spells.EnemyKeyCombo, 20, "ENEMY") end
        if HealBot_Config_Spells.EmergKeyCombo then HealBot_Update_ConvertSpells(HealBot_Config_Spells.EmergKeyCombo, 5, "EMERG") end
        HealBot_Config_Spells.SpellsReset=true
    end
    if HealBot_Globals.CacheSize then HealBot_Globals.CacheSize=nil end
    if HealBot_Globals.AutoCacheSize then HealBot_Globals.AutoCacheSize=nil end
    local tMajor, tMinor, tPatch, tHealbot=string.split(".", HealBot_Globals.LastVersionSkinUpdate)
    if not HealBot_Update_luVars["ResetGlobalOld"] and tonumber(tMajor)<=oldVersion then
        HealBot_Update_luVars["ResetGlobalOld"]=true
        HealBot_Options_SetDefaults(true)
    elseif HealBot_Globals.LastVersionSkinUpdate~=HealBot_Global_Version() then
        HealBot_Update_GlobalVars()
        if tonumber(tMajor)<12 then
            for x in pairs (Healbot_Config_Skins.Skins) do
                skinName=Healbot_Config_Skins.Skins[x]
                if HealBot_Config.SkinDefault[skinName] then
                    HealBot_Update_SkinDefault(skinName, HEALBOT_WORD_SOLO)
                    HealBot_Update_SkinDefault(skinName, HEALBOT_WORD_PARTY)
                    HealBot_Update_SkinDefault(skinName, HEALBOT_OPTIONS_RAID10)
                    HealBot_Update_SkinDefault(skinName, HEALBOT_OPTIONS_RAID25)
                    HealBot_Update_SkinDefault(skinName, HEALBOT_OPTIONS_RAID40)
                    HealBot_Update_SkinDefault(skinName, HEALBOT_WORD_ARENA)
                    HealBot_Update_SkinDefault(skinName, HEALBOT_WORD_BG10)
                    HealBot_Update_SkinDefault(skinName, HEALBOT_WORD_BG15)
                    HealBot_Update_SkinDefault(skinName, HEALBOT_WORD_BG40)
                    HealBot_Update_SkinDefault(skinName, HEALBOT_WORD_PETBATTLE)
                end
            end
            if HealBot_Class_Spells[""] then HealBot_Class_Spells[""]=nil end
            if HealBot_Class_Spells.SpellsReset then HealBot_Class_Spells.SpellsReset=nil end
            if HealBot_Class_Buffs[""] then HealBot_Class_Buffs[""]=nil end
            if HealBot_Class_Cures[""] then HealBot_Class_Cures[""]=nil end
            Healbot_Config_Skins.AuxBar=nil
            Healbot_Config_Skins.AuxBarText=nil
            Healbot_Config_Skins.AuxBarFrame=nil
        end

        for x in pairs (Healbot_Config_Skins.Skins) do
            skinName=Healbot_Config_Skins.Skins[x]
            HealBot_Skins_Check_Skin(skinName)
            if tonumber(tMajor)<12 then
                if Healbot_Config_Skins.ActionIconsData and Healbot_Config_Skins.ActionIconsData[skinName] and not HealBot_Skins_ActionIconsData[skinName] then
                    for f=1,10 do
                        for i=1,20 do
                            if Healbot_Config_Skins.ActionIconsData[skinName][i] and Healbot_Config_Skins.ActionIconsData[skinName][i][f] then
                                if not HealBot_Skins_ActionIconsData[skinName] then HealBot_Skins_ActionIconsData[skinName]={} end
                                if not HealBot_Skins_ActionIconsData[skinName][f] then HealBot_Skins_ActionIconsData[skinName][f]={} end
                                HealBot_Skins_ActionIconsData[skinName][f][i]=HealBot_Options_copyTable(Healbot_Config_Skins.ActionIconsData[skinName][i][f])
                            end
                        end
                    end
                    Healbot_Config_Skins.ActionIconsData[skinName]=nil
                end
                if Healbot_Config_Skins.ActionIcons and Healbot_Config_Skins.ActionIcons[skinName] and not HealBot_Skins_ActionIcons[skinName] then
                    HealBot_Skins_ActionIcons[skinName]=HealBot_Options_copyTable(Healbot_Config_Skins.ActionIcons[skinName])
                    Healbot_Config_Skins.ActionIcons[skinName]=nil
                end
                for f=1,10 do
                    if HealBot_Skins_ActionIcons[skinName] and (not HealBot_Skins_ActionIcons[skinName][f] or (HealBot_Skins_ActionIcons[skinName][f] and (HealBot_Skins_ActionIcons[skinName][f]["NUMICONS"] or 0) == 0)) then
                        HealBot_Skins_ActionIcons[skinName][f]=nil
                        HealBot_Skins_ActionIconsData[skinName][f]=nil
                    elseif not HealBot_Skins_ActionIcons[skinName] and HealBot_Skins_ActionIconsData[skinName] then
                        HealBot_Skins_ActionIconsData[skinName][f]=nil
                    end
                end
            end
        end
        if tonumber(tMajor)<12 then
            if HealBot_Config_Spells.ActionIconsData then HealBot_Config_Spells.ActionIconsData=nil end
            if HealBot_Config_Spells.ActionIcons then HealBot_Config_Spells.ActionIcons=nil end
            if HealBot_Class_Spells.ActionIconsData then HealBot_Class_Spells.ActionIconsData=nil end
            if HealBot_Class_Spells.ActionIcons then HealBot_Class_Spells.ActionIcons=nil end
            if Healbot_Config_Skins.ActionIconsData then Healbot_Config_Skins.ActionIconsData=nil end
            if Healbot_Config_Skins.ActionIcons then Healbot_Config_Skins.ActionIcons=nil end
            if HealBot_Config_ActionIconsData then HealBot_Config_ActionIconsData=nil end
            if HealBot_Config_ActionIcons then HealBot_Config_ActionIcons=nil end
            local vClasses={["DRUI"]=1,["HUNT"]=1,["MAGE"]=1,["PALA"]=1,["PRIE"]=1,["ROGU"]=1,["SHAM"]=1,["WARL"]=1,["WARR"]=1,["EVOK"]=1,["DEAT"]=1,["MONK"]=1,["DEMO"]=1,["GLOBAL"]=1}
            for x,_ in pairs(HealBot_Class_Spells) do
                if not vClasses[x] then
                    HealBot_Class_Spells[x]=nil
                end
            end
            if not HealBot_Globals.Custom_Debuff_Categories[HEALBOT_CUSTOM_CAT_CUSTOM_AUTOMATIC] then HealBot_Globals.Custom_Debuff_Categories[HEALBOT_CUSTOM_CAT_CUSTOM_AUTOMATIC]=1 end
            for x in pairs (HealBot_Config.SkinDefault) do
                local skinExists=false
                for j=1, getn(Healbot_Config_Skins.Skins), 1 do
                    if x==Healbot_Config_Skins.Skins[j] then
                        skinExists=true
                    end
                end
                if not skinExists then
                    HealBot_Config.SkinDefault[x]=nil
                end
            end
            HealBot_Config.KnownLoadouts=nil
        end
        if not HealBot_Update_luVars["UpdateMsg"] then
            HealBot_Update_luVars["UpdateMsg"]=true
            HealBot_Globals.OneTimeMsg["VERSION"]=false
        end
        HealBot_Update_BuffsForSpec("Debuff")
        
        if tonumber(tMajor)<12 then
            if not HealBot_Globals.CustomDebuffsShowBarCol["DEFAULT"] then
                HealBot_Globals.CustomDebuffsShowBarCol["DEFAULT"]=4
            end
            if not HealBot_Globals.CustomBuffsShowBarCol["DEFAULT"] then
                HealBot_Globals.CustomBuffsShowBarCol["DEFAULT"]=1
            end
            if HealBot_Globals.UltraPerf~=nil then
                HealBot_Globals.UltraPerf=nil
            end
            if HealBot_Globals.PerfMode~=nil then
                HealBot_Globals.PerfMode=nil
            end
            if HealBot_Globals.SwitchAllowPlayerRoles then
                HealBot_Globals.SwitchAllowPlayerRoles=nil
            end
            if HealBot_Globals.AllowPlayerRoles then
                HealBot_Globals.AllowPlayerRoles=nil
            end
            hbv_Skins_CheckRoleCol("", "TANK", true)          -- This is old when 11.0 is old.
            hbv_Skins_CheckRoleCol("", "HEALER", true)
            hbv_Skins_CheckRoleCol("", "DAMAGER", true)
            hbv_Skins_CheckClassCol("", "DEMO", true)
            hbv_Skins_CheckClassCol("", "DRUI", true)
            hbv_Skins_CheckClassCol("", "HUNT", true)
            hbv_Skins_CheckClassCol("", "MAGE", true)
            hbv_Skins_CheckClassCol("", "MONK", true)
            hbv_Skins_CheckClassCol("", "PALA", true)
            hbv_Skins_CheckClassCol("", "PRIE", true)
            hbv_Skins_CheckClassCol("", "ROGU", true)
            hbv_Skins_CheckClassCol("", "SHAM", true)
            hbv_Skins_CheckClassCol("", "WARL", true)
            hbv_Skins_CheckClassCol("", "DEAT", true)
            hbv_Skins_CheckClassCol("", "WARR", true)
            hbv_Skins_CheckClassCol("", "EVOK", true)
            hbv_Skins_CheckPowerCol("", "MANA", true)
            hbv_Skins_CheckPowerCol("", "RAGE", true)
            hbv_Skins_CheckPowerCol("", "FOCUS", true)
            hbv_Skins_CheckPowerCol("", "ENERGY", true)
            hbv_Skins_CheckPowerCol("", "RUNIC_POWER", true)
            hbv_Skins_CheckPowerCol("", "INSANITY", true)
            hbv_Skins_CheckPowerCol("", "LUNAR_POWER", true)
            hbv_Skins_CheckPowerCol("", "MAELSTROM", true)
            hbv_Skins_CheckPowerCol("", "FURY", true)
            if not HealBot_Globals.OverrideEffects["USEBARS"] then HealBot_Globals.OverrideEffects["USEBARS"]=(HealBot_Globals.OverrideEffects["USE"] or 1) end
            if not HealBot_Globals.OverrideEffects["HEALTHDROPTIME"] then HealBot_Globals.OverrideEffects["HEALTHDROPTIME"]=3 end
            if not HealBot_Globals.OverrideEffects["HEALTHDROPCANCEL"] then HealBot_Globals.OverrideEffects["HEALTHDROPCANCEL"]=200 end
            if not HealBot_Globals.OverrideEffects["HAZARDMINALPHA"] then HealBot_Globals.OverrideEffects["HAZARDMINALPHA"]=0.25 end
            if not HealBot_Globals.OverrideEffects["HAZARDFREQ"] then HealBot_Globals.OverrideEffects["HAZARDFREQ"]=0.3 end
            if not HealBot_Globals.OverrideEffects["HEALTHDROPPCT"] then HealBot_Globals.OverrideEffects["HEALTHDROPPCT"]=400 end
            if not HealBot_Globals.OverrideEffects["FGDIMMING"] then HealBot_Globals.OverrideEffects["FGDIMMING"]=2.5 end
            if not HealBot_Globals.OverrideEffects["HOTBARDEBUFF"] then HealBot_Globals.OverrideEffects["HOTBARDEBUFF"]=1 end
            if not HealBot_Globals.OverrideEffects["GLOW"] then HealBot_Globals.OverrideEffects["GLOW"]=3 end
            if not HealBot_Globals.OverrideEffects["ICONGLOW"] then HealBot_Globals.OverrideEffects["ICONGLOW"]=3 end
            if not HealBot_Globals.OverrideEffects["HOTBARHLTH"] then HealBot_Globals.OverrideEffects["HOTBARHLTH"]=0 end
            if not HealBot_Globals.OverrideEffects["FOCUSGROUPS"] then HealBot_Globals.OverrideEffects["FOCUSGROUPS"]=1 end
            if not HealBot_Globals.OverrideEffects["GHRANGE"] then HealBot_Globals.OverrideEffects["GHRANGE"]=1 end
            if not HealBot_Globals.OverrideEffects["GHMINUNITS"] then HealBot_Globals.OverrideEffects["GHMINUNITS"]=5 end
            if not HealBot_Globals.OverrideEffects["GHTHRESHOLD"] then HealBot_Globals.OverrideEffects["GHTHRESHOLD"]=50 end
            if not HealBot_Globals.OverrideEffects["GHDIMMING"] then HealBot_Globals.OverrideEffects["GHDIMMING"]=0 end
            if not HealBot_Globals.OverrideColours["USEADAPTIVE"] then HealBot_Globals.OverrideColours["USEADAPTIVE"]=1 end
            if not HealBot_Globals.OverrideColours["USECLASS"] then HealBot_Globals.OverrideColours["USECLASS"]=1 end
            if not HealBot_Globals.OverrideColours["GLOW"] then HealBot_Globals.OverrideColours["GLOW"]=3 end
            if not HealBot_Globals.OverrideColours["ICONGLOW"] then HealBot_Globals.OverrideColours["ICONGLOW"]=2 end
            if HealBot_Class_Cures.ShowGroups then HealBot_Class_Cures.ShowGroups=nil end
            if HealBot_Class_Buffs.ShowGroups then HealBot_Class_Buffs.ShowGroups=nil end
            HealBot_Globals.OverrideAdaptiveCols=nil
        end
        HealBot_Globals.LastVersionSkinUpdate=HealBot_Global_Version()
        HealBot_Timers_Set("OOC","OrphanedCheck",true,true)
    else
        HealBot_Skins_Check(Healbot_Config_Skins.Current_Skin)
    end
    if HealBot_Config_Cures.ShowGroups then HealBot_Config_Cures.ShowGroups=nil end
    if HealBot_Config_Buffs.ShowGroups then HealBot_Config_Buffs.ShowGroups=nil end
    if HealBot_Spells_Loadouts then
        for x,_ in pairs(HealBot_Spells_Loadouts) do
            if HealBot_Spells_Loadouts[x].ActionIcons then HealBot_Spells_Loadouts[x].ActionIcons=nil end
            if HealBot_Spells_Loadouts[x].ActionIconsData then HealBot_Spells_Loadouts[x].ActionIconsData=nil end
            for n=1,20 do
                if HealBot_Spells_Loadouts[x].Binds and HealBot_Spells_Loadouts[x].Binds[n] and HealBot_Spells_Loadouts[x].Binds[n] == 1 then HealBot_Spells_Loadouts[x].Binds[n]=nil end
            end
        end
        HealBot_Update_ConvertClassToPlayer()
    end
    if HealBot_Config.LastVersionUpdate then HealBot_Config.LastVersionUpdate=nil end

    if not HealBot_Config_Buffs.CustomBuffName[4] then HealBot_Config_Buffs.CustomBuffName[4]="" end
    if not HealBot_Config_Buffs.CustomItemName[4] then HealBot_Config_Buffs.CustomItemName[4]="" end
    if not HealBot_Config_Cures.HealBotDebuffPriority[HEALBOT_BLEED_en] then HealBot_Config_Cures.HealBotDebuffPriority[HEALBOT_BLEED_en]=9 end -- This is old when 10.2 is old.
    if not HealBot_Config_Cures.CDCBarColour[HEALBOT_BLEED_en] then -- This is old when 10.2 is old.
        HealBot_Config_Cures.CDCBarColour[HEALBOT_BLEED_en]={}
        HealBot_Config_Cures.CDCBarColour[HEALBOT_BLEED_en].R=0.58
        HealBot_Config_Cures.CDCBarColour[HEALBOT_BLEED_en].G=0.02
        HealBot_Config_Cures.CDCBarColour[HEALBOT_BLEED_en].B=0.02
    end
    for x=1,5 do -- This is old when 10.2 is old.
        if not HealBot_Config_Cures.HealBotDebuffText[HealBot_Options_getDropDownId_bySpec(x)] then
            HealBot_Config_Cures.HealBotDebuffText[HealBot_Options_getDropDownId_bySpec(x)]=HEALBOT_WORDS_NONE
        end
        if not HealBot_Config_Cures.HealBotDebuffDropDown[HealBot_Options_getDropDownId_bySpec(x)] then
            HealBot_Config_Cures.HealBotDebuffDropDown[HealBot_Options_getDropDownId_bySpec(x)]=1
        end
    end
end
