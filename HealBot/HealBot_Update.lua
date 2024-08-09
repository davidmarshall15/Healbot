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
    HealBot_Aux_setLuVars("WaitOnFullClear", false)
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

function HealBot_Update_AllStateIconHostile()
      --HealBot_setCall("HealBot_Update_AllStateIconHostile")
    for _,xButton in pairs(HealBot_Unit_Button) do
       HealBot_Events_ClassificationChanged(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
       HealBot_Events_ClassificationChanged(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
       HealBot_Events_ClassificationChanged(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
       HealBot_Events_ClassificationChanged(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
       HealBot_Events_ClassificationChanged(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
       HealBot_Events_ClassificationChanged(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Events_ClassificationChanged(xButton)
    end
    for xUnit,xButton in pairs(HealBot_UnitTarget_Button) do
        HealBot_Events_ClassificationChanged(xButton)
    end
    for xUnit,xButton in pairs(HealBot_PrivateTarget_Button) do
        HealBot_Events_ClassificationChanged(xButton)
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
        for _,xButton in pairs(HealBot_Unit_Button) do
            HealBot_Aura_Update_AllIcons(xButton)
        end
        for _,xButton in pairs(HealBot_Private_Button) do
            HealBot_Aura_Update_AllIcons(xButton)
        end
        for _,xButton in pairs(HealBot_Pet_Button) do
            HealBot_Aura_Update_AllIcons(xButton)
        end
        for _,xButton in pairs(HealBot_Vehicle_Button) do
            HealBot_Aura_Update_AllIcons(xButton)
        end
        for _,xButton in pairs(HealBot_Extra_Button) do
            HealBot_Aura_Update_AllIcons(xButton)
        end
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

function HealBot_Update_AuraAllState()
      --HealBot_setCall("HealBot_Update_AuraAllState")
    for _,xButton in pairs(HealBot_Unit_Button) do
       HealBot_Aura_UpdateState(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
       HealBot_Aura_UpdateState(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
       HealBot_Aura_UpdateState(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
       HealBot_Aura_UpdateState(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
       HealBot_Aura_UpdateState(xButton)
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

function HealBot_Update_ClearLowMana()
      --HealBot_setCall("HealBot_Update_ClearLowMana")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_DoClearLowMana(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_DoClearLowMana(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_DoClearLowMana(xButton)
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
      --HealBot_setCall(HealBot_Update_AllBuffs)
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

function HealBot_Update_AllPartyGUIDs()
      --HealBot_setCall("HealBot_Update_AllPartyGUIDs")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Events_UnitGUIDChange(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Events_UnitGUIDChange(xButton)
    end
end

function HealBot_Update_AllPetGUIDs()
      --HealBot_setCall("HealBot_Update_AllPetGUIDs")
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Events_UnitGUIDChange(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Events_UnitGUIDChange(xButton)
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


function HealBot_Update_Skins()
      --HealBot_setCall("HealBot_Update_Skins")
    local oldVersion=9
    if HealBot_Config.LastVersionSkinUpdate then HealBot_Config.LastVersionSkinUpdate=nil end

    local foundSkin=false
    for x in pairs (Healbot_Config_Skins.Skins) do
        if not HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]] then
            HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]]={[HEALBOT_WORD_SOLO]=false,
                                                                         [HEALBOT_WORD_PARTY]=false,
                                                                         [HEALBOT_OPTIONS_RAID10]=false,
                                                                         [HEALBOT_OPTIONS_RAID25]=false,
                                                                         [HEALBOT_OPTIONS_RAID40]=false,
                                                                         [HEALBOT_WORD_ARENA]=false,
                                                                         [HEALBOT_WORD_BG10]=false,
                                                                         [HEALBOT_WORD_BG15]=false,
                                                                         [HEALBOT_WORD_BG40]=false,
                                                                         [HEALBOT_WORD_PETBATTLE]=false}
        end
        if Healbot_Config_Skins.Skins[x] == Healbot_Config_Skins.Current_Skin then foundSkin=true end
    end
    if not foundSkin then
        local retryWithSkin=HealBot_getDefaultSkin()
        HealBot_Options_Set_Current_Skin(retryWithSkin, nil, true, true)
    end
    if HealBot_Globals.CacheSize then HealBot_Globals.CacheSize=nil end
    if HealBot_Globals.AutoCacheSize then HealBot_Globals.AutoCacheSize=nil end
    local tMajor, tMinor, tPatch, tHealbot=string.split(".", HealBot_Globals.LastVersionSkinUpdate)
    if not HealBot_Update_luVars["ResetGlobalOld"] and tonumber(tMajor)<=oldVersion then
        HealBot_Update_luVars["ResetGlobalOld"]=true
        HealBot_Options_SetDefaults(true)
    elseif HealBot_Globals.LastVersionSkinUpdate~=HealBot_Global_Version() then
        for x in pairs (Healbot_Config_Skins.Skins) do
            HealBot_Skins_Check_Skin(Healbot_Config_Skins.Skins[x])
        end
        if not HealBot_Update_luVars["UpdateMsg"] then
            HealBot_Update_luVars["UpdateMsg"]=true
            HealBot_Globals.OneTimeMsg["VERSION"]=false
        end
        if tonumber(tMajor) == 10 then
            if tonumber(tMinor) == 0 then
                if tonumber(tPatch) == 0 then
                    if tonumber(tHealbot)<4 then
                        if HealBot_Globals.Tooltip_SetScale == false then
                            HealBot_Globals.Tooltip_Scale=1
                            HealBot_Globals.Tooltip_SetScale=nil
                        end
                        if HealBot_Globals.Tooltip_SetAlpha == false then
                            HealBot_Globals.Tooltip_Alpha=1
                            HealBot_Globals.Tooltip_SetAlpha=nil
                        else
                            HealBot_Globals.Tooltip_Alpha=HealBot_Globals.Tooltip_SetAlphaValue or 1
                        end
                    end
                end
                if tonumber(tPatch) == 0 or (tonumber(tPatch)<8 and tonumber(tHealbot)<4) then
                    for id,_  in pairs(HealBot_Globals.HealBot_Custom_Buffs_IconSet) do
                        if type(id) == "number" and not HealBot_Globals.HealBot_Custom_Buffs[id] then
                            HealBot_Globals.HealBot_Custom_Buffs_IconSet[id]=nil
                        end
                    end
                    for id,_  in pairs(HealBot_Globals.HealBot_Custom_Buffs_IconGlow) do
                        if type(id) == "number" and not HealBot_Globals.HealBot_Custom_Buffs[id] then
                            HealBot_Globals.HealBot_Custom_Buffs_IconGlow[id]=nil
                        end
                    end
                    for id,_  in pairs(HealBot_Globals.HealBot_Custom_Debuffs_IconSet) do
                        if type(id) == "number" and not HealBot_Globals.HealBot_Custom_Debuffs[id] then
                            HealBot_Globals.HealBot_Custom_Debuffs_IconSet[id]=nil
                        end
                    end
                    for id,_  in pairs(HealBot_Globals.HealBot_Custom_Debuffs_IconGlow) do
                        if type(id) == "number" and not HealBot_Globals.HealBot_Custom_Debuffs[id] then
                            HealBot_Globals.HealBot_Custom_Debuffs_IconGlow[id]=nil
                        end
                    end
                end
                if not HealBot_Globals.WatchHoT["EVOK"] then HealBot_Globals.WatchHoT["EVOK"]={} end
                if not HealBot_Globals.WatchHoT["EVOK"][HEALBOT_REVERSION] then
                    local HealBot_EvokHoTClass=HealBot_GlobalsDefaults.WatchHoT["EVOK"]
                    for id,x  in pairs(HealBot_EvokHoTClass) do
                        HealBot_Globals.WatchHoT["EVOK"][id]=x
                    end
                end
                if type(HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[HEALBOT_CUSTOM_CAT_CUSTOM_AUTOMATIC])~="number" then
                    HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[HEALBOT_CUSTOM_CAT_CUSTOM_AUTOMATIC]=4
                end
                if type(HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol["DEFAULT"])~="number" then
                    HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol["DEFAULT"]=4
                end
                for id,_  in pairs(HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol) do
                    if type(HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[id])~="number" then
                        HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[id]=4
                    end
                end
                for id,_  in pairs(HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol) do
                    if type(HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[id])~="number" then
                        HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[id]=4
                    end
                end

                for x in pairs (Healbot_Config_Skins.Skins) do
                    for f=1,10 do
                        if Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Skins[x]][f]["HLTH"]>2 then
                            Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Skins[x]][f]["HLTH"]=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Skins[x]][f]["HLTH"]+1
                        end
                        if Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Skins[x]][f]["BACK"]>5 then
                            Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Skins[x]][f]["BACK"]=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Skins[x]][f]["BACK"]+3
                        elseif Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Skins[x]][f]["BACK"]>4 then
                            Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Skins[x]][f]["BACK"]=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Skins[x]][f]["BACK"]+2
                        elseif Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Skins[x]][f]["BACK"]>2 then
                            Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Skins[x]][f]["BACK"]=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Skins[x]][f]["BACK"]+1
                        end
                        if Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Skins[x]][f]["BORDER"]>6 then
                            Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Skins[x]][f]["BORDER"]=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Skins[x]][f]["BORDER"]+3
                        elseif Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Skins[x]][f]["BORDER"]>5 then
                            Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Skins[x]][f]["BORDER"]=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Skins[x]][f]["BORDER"]+2
                        elseif Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Skins[x]][f]["BORDER"]>3 then
                            Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Skins[x]][f]["BORDER"]=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Skins[x]][f]["BORDER"]+1
                        end
                        if Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Skins[x]][f]["IC"]>2 then
                            Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Skins[x]][f]["IC"]=Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Skins[x]][f]["IC"]+2
                        end
                        if Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Skins[x]][f]["AC"]>2 then
                            Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Skins[x]][f]["AC"]=Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Skins[x]][f]["AC"]+2
                        end
                        if Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Skins[x]][f]["NAME"]>2 then
                            Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Skins[x]][f]["NAME"]=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Skins[x]][f]["NAME"]+1
                        end
                        if Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Skins[x]][f]["HLTH"]>2 and Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Skins[x]][f]["HLTH"]<6 then
                            Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Skins[x]][f]["HLTH"]=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Skins[x]][f]["HLTH"]+1
                        end
                        if Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Skins[x]][f]["STATE"]>2 then
                            Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Skins[x]][f]["STATE"]=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Skins[x]][f]["STATE"]+1
                        end
                        if Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Skins[x]][f]["AGGRO"]>2 then
                            Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Skins[x]][f]["AGGRO"]=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Skins[x]][f]["AGGRO"]+1
                        end
                        if Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Skins[x]][f]["BARCOL"]>2 then
                            Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Skins[x]][f]["BARCOL"]=Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Skins[x]][f]["BARCOL"]+1
                        end
                        for z=1,9 do
                            if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Skins[x]][z][f]["COLOUR"] == 3 then
                                Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Skins[x]][z][f]["COLOUR"]=4
                            end
                            if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Skins[x]][z][f]["COLTYPE"] == 3 then
                                Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Skins[x]][z][f]["COLTYPE"]=4
                            end
                        end
                    end
                end
            end
            if tonumber(tMinor)<3 then
                if HealBot_Globals.InHealAbsorbDiv then
                    HealBot_Globals.AbsorbDiv=HealBot_Globals.InHealAbsorbDiv
                    HealBot_Globals.InHealDiv=HealBot_Globals.InHealAbsorbDiv
                    HealBot_Globals.InHealAbsorbDiv=nil
                end
                if tonumber(tPatch)<6 then
                    HealBot_Globals.AbsorbDiv=12
                    HealBot_Globals.InHealDiv=12
                elseif tonumber(tPatch) == 6 and tonumber(tHealbot)<1 then
                    HealBot_Globals.AbsorbDiv=12
                    HealBot_Globals.InHealDiv=12
                end
            end
        end
        if not HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol["DEFAULT"] then
            HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol["DEFAULT"]=4
        end
        if not HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol["DEFAULT"] then
            HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol["DEFAULT"]=4
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
        for x in pairs (Healbot_Config_Skins.Skins) do
            if Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Skins[x]]["ENEMYTARGETSIZE"]>10 then
                Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Skins[x]]["ENEMYTARGETSIZE"]=Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["ENEMYTARGETSIZE"]/100
            end
        end
        if not HealBot_Globals.Custom_Debuff_Categories[HEALBOT_CUSTOM_CAT_CUSTOM_AUTOMATIC] then HealBot_Globals.Custom_Debuff_Categories[HEALBOT_CUSTOM_CAT_CUSTOM_AUTOMATIC]=1 end
        HealBot_Update_BuffsForSpec("Debuff")
        if not HealBot_Globals.OverrideColours["TANK"] then HealBot_Skins_SetRoleCol(nil, "TANK", true) end         -- This is old when 10.0 is old.
        if not HealBot_Globals.OverrideColours["HEALER"] then HealBot_Skins_SetRoleCol(nil, "HEALER", true) end
        if not HealBot_Globals.OverrideColours["DAMAGER"] then HealBot_Skins_SetRoleCol(nil, "DAMAGER", true) end
        if not HealBot_Globals.OverrideColours["DEMO"] then HealBot_Skins_SetClassCol(nil, "DEMO", true) end
        if not HealBot_Globals.OverrideColours["DRUI"] then HealBot_Skins_SetClassCol(nil, "DRUI", true) end
        if not HealBot_Globals.OverrideColours["HUNT"] then HealBot_Skins_SetClassCol(nil, "HUNT", true) end
        if not HealBot_Globals.OverrideColours["MAGE"] then HealBot_Skins_SetClassCol(nil, "MAGE", true) end
        if not HealBot_Globals.OverrideColours["MONK"] then HealBot_Skins_SetClassCol(nil, "MONK", true) end
        if not HealBot_Globals.OverrideColours["PALA"] then HealBot_Skins_SetClassCol(nil, "PALA", true) end
        if not HealBot_Globals.OverrideColours["PRIE"] then HealBot_Skins_SetClassCol(nil, "PRIE", true) end
        if not HealBot_Globals.OverrideColours["ROGU"] then HealBot_Skins_SetClassCol(nil, "ROGU", true) end
        if not HealBot_Globals.OverrideColours["SHAM"] then HealBot_Skins_SetClassCol(nil, "SHAM", true) end
        if not HealBot_Globals.OverrideColours["WARL"] then HealBot_Skins_SetClassCol(nil, "WARL", true) end
        if not HealBot_Globals.OverrideColours["DEAT"] then HealBot_Skins_SetClassCol(nil, "DEAT", true) end
        if not HealBot_Globals.OverrideColours["WARR"] then HealBot_Skins_SetClassCol(nil, "WARR", true) end
        if not HealBot_Globals.OverrideColours["EVOK"] then HealBot_Skins_SetClassCol(nil, "EVOK", true) end
        if not HealBot_Globals.OverrideColours["MANA"] then HealBot_Skins_SetPowerCol(nil, "MANA", true) end
        if not HealBot_Globals.OverrideColours["RAGE"] then HealBot_Skins_SetPowerCol(nil, "RAGE", true) end
        if not HealBot_Globals.OverrideColours["FOCUS"] then HealBot_Skins_SetPowerCol(nil, "FOCUS", true) end
        if not HealBot_Globals.OverrideColours["ENERGY"] then HealBot_Skins_SetPowerCol(nil, "ENERGY", true) end
        if not HealBot_Globals.OverrideColours["RUNIC_POWER"] then HealBot_Skins_SetPowerCol(nil, "RUNIC_POWER", true) end
        if not HealBot_Globals.OverrideColours["INSANITY"] then HealBot_Skins_SetPowerCol(nil, "INSANITY", true) end
        if not HealBot_Globals.OverrideColours["LUNAR_POWER"] then HealBot_Skins_SetPowerCol(nil, "LUNAR_POWER", true) end
        if not HealBot_Globals.OverrideColours["MAELSTROM"] then HealBot_Skins_SetPowerCol(nil, "MAELSTROM", true) end
        if not HealBot_Globals.OverrideColours["FURY"] then HealBot_Skins_SetPowerCol(nil, "FURY", true) end
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
        if not HealBot_Globals.OverrideColours["USEADAPTIVE"] then HealBot_Globals.OverrideColours["USEADAPTIVE"]=1 end
        if not HealBot_Globals.OverrideColours["USECLASS"] then HealBot_Globals.OverrideColours["USECLASS"]=1 end
        if not HealBot_Globals.OverrideColours["GLOW"] then HealBot_Globals.OverrideColours["GLOW"]=3 end
        if not HealBot_Globals.OverrideColours["ICONGLOW"] then HealBot_Globals.OverrideColours["ICONGLOW"]=2 end
        HealBot_Globals.LastVersionSkinUpdate=HealBot_Global_Version()
    else
        HealBot_Skins_Check(Healbot_Config_Skins.Current_Skin)
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
    if not HealBot_Config.SpellsUpdatedToV10 then  -- When removing this check, also remove from HealBot_Action_GetComboWithSpec - This is old when 10.0 is old.
        if not HealBot_Config_Spells.EnabledKeyCombo["New"] then
            HealBot_Share_ExportSpells()
            HealBot_Config.SpellsUpdatedToV10=true
            HealBot_UpdateSpellsOnVersionChange(HealBot_Config_Spells.EnabledKeyCombo,20)
            HealBot_UpdateSpellsOnVersionChange(HealBot_Config_Spells.EnemyKeyCombo,20)
            HealBot_UpdateSpellsOnVersionChange(HealBot_Config_Spells.EmergKeyCombo,5)
            HealBot_UpdateSpellsOnVersionChange(HealBot_Config_Spells.EnabledSpellTarget,20)
            HealBot_UpdateSpellsOnVersionChange(HealBot_Config_Spells.EnemySpellTarget,20)
            HealBot_UpdateSpellsOnVersionChange(HealBot_Config_Spells.EmergSpellTarget,5)
            HealBot_UpdateSpellsOnVersionChange(HealBot_Config_Spells.EnabledSpellTrinket1,20)
            HealBot_UpdateSpellsOnVersionChange(HealBot_Config_Spells.EnemySpellTrinket1,20)
            HealBot_UpdateSpellsOnVersionChange(HealBot_Config_Spells.EmergSpellTrinket1,5)
            HealBot_UpdateSpellsOnVersionChange(HealBot_Config_Spells.EnabledSpellTrinket2,20)
            HealBot_UpdateSpellsOnVersionChange(HealBot_Config_Spells.EnemySpellTrinket2,20)
            HealBot_UpdateSpellsOnVersionChange(HealBot_Config_Spells.EmergSpellTrinket2,5)
            HealBot_UpdateSpellsOnVersionChange(HealBot_Config_Spells.EnabledAvoidBlueCursor,20)
            HealBot_UpdateSpellsOnVersionChange(HealBot_Config_Spells.EnemyAvoidBlueCursor,20)
            HealBot_UpdateSpellsOnVersionChange(HealBot_Config_Spells.EmergAvoidBlueCursor,5)
            HealBot_Share_LoadSpells(HealBot_Options_ShareSpellsExternalEditBox:GetText())
            HealBot_Options_ShareSpellsExternalEditBox:SetText("")
            StaticPopupDialogs["SpellsUpdatedToV10"]={
                text="HealBot\n\nCharacter spells have been updated\nCheck the spells tab\n\nOpen options now?",
                    button1=HEALBOT_WORDS_YES,
                    button2=HEALBOT_WORDS_NO,
                    OnAccept=function()
                        HealBot_Options_ShowHide()
                    end,
                    timeout=0,
                    whileDead=1,
                    hideOnEscape=1
            };
            StaticPopup_Show("SpellsUpdatedToV10");
        else
            HealBot_Config.SpellsUpdatedToV10=true
        end
    end
end
