
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

function HealBot_Update_AllAuxPowerBars()
      --HealBot_setCall("HealBot_Update_AllAuxPowerBars")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_OnEvent_UnitManaUpdate(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_OnEvent_UnitManaUpdate(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_OnEvent_UnitManaUpdate(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_OnEvent_UnitManaUpdate(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_OnEvent_UnitManaUpdate(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_OnEvent_UnitManaUpdate(xButton)
    end
    for xUnit,xButton in pairs(HealBot_UnitTarget_Button) do
        HealBot_OnEvent_UnitManaUpdate(xButton)
    end
    for xUnit,xButton in pairs(HealBot_PrivateTarget_Button) do
        HealBot_OnEvent_UnitManaUpdate(xButton)
    end
end

function HealBot_Update_CheckAllAuxOverLays()
      --HealBot_setCall("HealBot_Update_CheckAllAuxOverLays")
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

function HealBot_Update_AllThreat()
      --HealBot_setCall("HealBot_Update_AllThreat")
    for _,xButton in pairs(HealBot_Unit_Button) do
        xButton.aggro.nextcheck=1
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        xButton.aggro.nextcheck=1
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

function HealBot_Update_AllStateIconAFK()
      --HealBot_setCall("HealBot_Update_AllStateIconAFK")
    for _,xButton in pairs(HealBot_Unit_Button) do
       HealBot_OnEvent_UnitFlagsChanged(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
       HealBot_OnEvent_UnitFlagsChanged(xButton)
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
       HealBot_OnEvent_ClassificationChanged(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
       HealBot_OnEvent_ClassificationChanged(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
       HealBot_OnEvent_ClassificationChanged(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
       HealBot_OnEvent_ClassificationChanged(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
       HealBot_OnEvent_ClassificationChanged(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
       HealBot_OnEvent_ClassificationChanged(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_OnEvent_ClassificationChanged(xButton)
    end
    for xUnit,xButton in pairs(HealBot_UnitTarget_Button) do
        HealBot_OnEvent_ClassificationChanged(xButton)
    end
    for xUnit,xButton in pairs(HealBot_PrivateTarget_Button) do
        HealBot_OnEvent_ClassificationChanged(xButton)
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

function HealBot_Update_CheckAllPartyGUIDs()
      --HealBot_setCall("HealBot_Update_CheckAllPartyGUIDs")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_CheckUpdateUnitGUIDChange(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_CheckUpdateUnitGUIDChange(xButton)
    end
end

function HealBot_Update_CheckAllPetGUIDs()
      --HealBot_setCall("HealBot_Update_CheckAllPetGUIDs")
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_CheckUpdateUnitGUIDChange(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_CheckUpdateUnitGUIDChange(xButton)
    end
end
