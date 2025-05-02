local xButton,pButton,xUnit
local scName, scStartTime, scEndTime="",0,0
local hbEventsFrames={}
local HealBot_Events_ResSpells={}
local HealBot_Events_luVars={}
HealBot_Events_luVars["AddonLoaded"]=false
HealBot_Events_luVars["VarsLoaded"]=false
HealBot_Events_luVars["Loaded"]=false
HealBot_Events_luVars["pluginMyCooldowns"]=false
HealBot_Events_luVars["pluginAuraWatch"]=false
HealBot_Events_luVars["WaitedOnAddonLoaded"]=false
HealBot_Events_luVars["ChatNOTIFY"]=1
HealBot_Events_luVars["ChatMSG"]=""
HealBot_Events_luVars["massResTime"]=0
HealBot_Events_luVars["massResUnit"]="-nil"
HealBot_Events_luVars["massResAltTime"]=0
HealBot_Events_luVars["massResAltUnit"]="-nil"
HealBot_Events_luVars["DelayCD"]=0.2
HealBot_Events_luVars["overhealUnit"]="-nil-"
HealBot_Events_luVars["overhealCastID"]="-nil-"

local HealBot_Events_AuxAssigns={}
HealBot_Events_AuxAssigns["CastBar"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}

function HealBot_Events_setLuVars(vName, vValue)
      --HealBot_setCall("HealBot_Update_setLuVars - "..vName)
    HealBot_Events_luVars[vName]=vValue
end

function HealBot_Events_retLuVars(vName)
      --HealBot_setCall("HealBot_Update_retLuVars - "..vName)
    return HealBot_Events_luVars[vName]
end

function HealBot_Events_setAuxAssigns(vName, frame, vValue)
      --HealBot_setCall("HealBot_setAuxAssigns - "..vName)
    HealBot_Events_AuxAssigns[vName][frame]=vValue
end

function HealBot_Events_FrameOnEvent(self, event, arg1, arg2, arg3)
    if self.id == "TARGET" then
        HealBot_nextRecalcParty(3)
    elseif self.id == "FOCUS" then
        HealBot_nextRecalcParty(4)
    else
        HealBot_nextRecalcParty(6)
    end
end

function HealBot_Events_FrameCommon(f)
    f:SetMovable(false)
    f:EnableMouse(false)
    f:SetHeight(20)
    f:SetWidth(20)
    ShowUIPanel(f)
end

function HealBot_Events_Frame()
    if not hbEventsFrames["MAIN"] then
        hbEventsFrames["MAIN"]=CreateFrame("Frame", "HealBot_Events_Frame", UIParent)
        HealBot_Events_FrameCommon(hbEventsFrames["MAIN"])
        hbEventsFrames["MAIN"]:SetPoint("TOP",0,50)
        HideUIPanel(hbEventsFrames["MAIN"])
        hbEventsFrames["TARGET"]=CreateFrame("Frame", "HealBot_Events_FrameTarget", hbEventsFrames["MAIN"])
        HealBot_Events_FrameCommon(hbEventsFrames["TARGET"])
        hbEventsFrames["TARGET"]:SetScript("OnEvent", function(self, event, arg1, arg2, arg3) HealBot_Events_FrameOnEvent(self, event, arg1, arg2, arg3) end)
        hbEventsFrames["TARGET"]:SetAttribute("unit", "target")
        hbEventsFrames["TARGET"].id="TARGET"
        if HEALBOT_GAME_VERSION>1 then
            hbEventsFrames["FOCUS"]=CreateFrame("Frame", "HealBot_Events_FrameFocus", hbEventsFrames["MAIN"])
            HealBot_Events_FrameCommon(hbEventsFrames["FOCUS"])
            hbEventsFrames["FOCUS"]:SetScript("OnEvent", function(self, event, arg1, arg2, arg3) HealBot_Events_FrameOnEvent(self, event, arg1, arg2, arg3) end)
            hbEventsFrames["FOCUS"]:SetAttribute("unit", "focus")
            hbEventsFrames["FOCUS"].id="FOCUS"
        end
        hbEventsFrames["PRIVFOCUS"]=CreateFrame("Frame", "HealBot_Events_FramePrivFocus", hbEventsFrames["MAIN"])
        HealBot_Events_FrameCommon(hbEventsFrames["PRIVFOCUS"])
        hbEventsFrames["PRIVFOCUS"]:SetScript("OnEvent", function(self, event, arg1, arg2, arg3) HealBot_Events_FrameOnEvent(self, event, arg1, arg2, arg3) end)
        hbEventsFrames["PRIVFOCUS"].id="PRIVFOCUS"
    end
end

function HealBot_Events_FrameUnit(frame, enable, unit)
    if hbEventsFrames[frame] then
        if enable then
            if frame == "PRIVFOCUS" then
                hbEventsFrames["TARGET"]:SetAttribute("unit", unit)
            end
            hbEventsFrames[frame]:RegisterUnitEvent("UNIT_TARGET", unit)
        else
            hbEventsFrames[frame]:UnregisterEvent("UNIT_TARGET")
        end
    end
end

function HealBot_Events_SetFrameUnits()
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][12]["STATE"] then
        HealBot_Events_FrameUnit("TARGET", true, "target")
    else
        HealBot_Events_FrameUnit("TARGET", false, "target")
    end
    if HEALBOT_GAME_VERSION>1 and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][14]["STATE"] then
        HealBot_Events_FrameUnit("FOCUS", true, "focus")
    else
        HealBot_Events_FrameUnit("FOCUS", false, "focus")
    end
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["STATE"] then
        xUnit=HealBot_Panel_RetPrivFocus()
        if UnitExists(xUnit) then
            HealBot_Events_FrameUnit("PRIVFOCUS", true, xUnit)
        else
            HealBot_Events_FrameUnit("PRIVFOCUS", false, "x")
        end
    else
        HealBot_Events_FrameUnit("PRIVFOCUS", false, "x")
    end
end

function HealBot_Events_SetResSpells()
      --HealBot_setCall("HealBot_Events_SetResSpells")
    HealBot_Events_ResSpells={[HealBot_WoWAPI_SpellName(HEALBOT_MASS_RESURRECTION) or "x"]=2,
                              [HealBot_WoWAPI_SpellName(HBC_MASS_RESURRECTION) or "x"]=2,
                              [HealBot_WoWAPI_SpellName(HEALBOT_MASS_RETURN) or "x"]=2,
                              [HealBot_WoWAPI_SpellName(HEALBOT_ABSOLUTION) or "x"]=2,
                              [HealBot_WoWAPI_SpellName(HEALBOT_ANCESTRAL_VISION) or "x"]=2,
                              [HealBot_WoWAPI_SpellName(HEALBOT_REAWAKEN) or "x"]=2,
                              [HealBot_WoWAPI_SpellName(HEALBOT_REVITALIZE) or "x"]=2,
                              [HealBot_WoWAPI_SpellName(HEALBOT_RESURRECTION) or "x"]=1,
                              [HealBot_WoWAPI_SpellName(HEALBOT_RETURN) or "x"]=1,
                              [HealBot_WoWAPI_SpellName(HEALBOT_ANCESTRALSPIRIT) or "x"]=1,
                              [HealBot_WoWAPI_SpellName(HEALBOT_REBIRTH) or "x"]=1,
                              [HealBot_WoWAPI_SpellName(HEALBOT_REDEMPTION) or "x"]=1,
                              [HealBot_WoWAPI_SpellName(HEALBOT_REVIVE) or "x"]=1,
                              [HealBot_WoWAPI_SpellName(HEALBOT_RESUSCITATE) or "x"]=1,
                              [HealBot_WoWAPI_SpellName(HEALBOT_INTERCESSION) or "x"]=1}
end

function HealBot_Events_setLag()
      --HealBot_setCall("HealBot_Events_setLag")
    if HealBot_Globals.LAG<0.05 then
        HealBot_Events_luVars["DelayCD"]=HealBot_Globals.LAG*2.5
    elseif HealBot_Globals.LAG<0.1 then
        HealBot_Events_luVars["DelayCD"]=HealBot_Globals.LAG*2.25
    elseif HealBot_Globals.LAG<0.25 then
        HealBot_Events_luVars["DelayCD"]=HealBot_Globals.LAG*2
    else
        HealBot_Events_luVars["DelayCD"]=HealBot_Globals.LAG*1.25
    end
    HealBot_Debug_PerfUpdate("lag", HealBot_Globals.LAG)
    HealBot_Debug_PerfUpdate("CDdelay", HealBot_Events_luVars["DelayCD"])
end

local LogSourceGUID, LogDestGUID, LogEvent, LogUnit, LogAbsorbAmount, Log12, Log14, Log15, Log17, Log19, Log22="","","","",0,"",0,"",0,0,0
function HealBot_Events_Combat_Log()
      --HealBot_setCall("HealBot_Events_Combat_Log")
    _, LogEvent, _, LogSourceGUID, _, _, _, LogDestGUID, _, _, _, Log12, _, Log14, Log15, _, Log17, _, Log19, _, _, Log22=CombatLogGetCurrentEventInfo()
    if HEALBOT_GAME_VERSION<5 and LogEvent == "SPELL_ABSORBED" then
        LogAbsorbAmount=Log22 or Log19 or 0
        if LogAbsorbAmount>0 then
            xButton,pButton=HealBot_Panel_RaidPetUnitButton(LogDestGUID)
            if xButton then HealBot_Classic_AbsorbsUpdate(xButton, LogAbsorbAmount) end
            if pButton then HealBot_Classic_AbsorbsUpdate(pButton, LogAbsorbAmount) end
        end
    end

    if HealBot_Data["PGUID"] == LogSourceGUID then
        if LogEvent == "SPELL_HEAL" then
            xButton,pButton=HealBot_Panel_RaidPetUnitButton(LogDestGUID)
            if xButton then HealBot_Update_RecentHealsBar(xButton) end
            if pButton then HealBot_Update_RecentHealsBar(pButton) end
        end
        --if type(Log12) == "number" and HealBot_Spell_IDs[Log12] then
        --    HealBot_Check_SpellCooldown(Log12, HealBot_Events_luVars["DelayCD"])
        --end
    end
end

function HealBot_Events_UpdateRange(button)
      --HealBot_setCall("HealBot_Events_UpdateRange", button)
    HealBot_Range_UpdateUnit(button)
end

function HealBot_Events_UnitTarget(button)
          --HealBot_setCall("HealBot_Events_UnitTarget", button)
    if button.isplayer or button.isgroupraid then
        if UnitAffectingCombat(button.unit) then
            if button.status.current<HealBot_Unit_Status["DC"] then
                if not HealBot_Data["UILOCK"] then
                    if HealBot_Panel_IsTargetingEnemy(button.unit) then
                        HealBot_nextRecalcParty(5)
                    end
                else
                    HealBot_CalcThreat(button)
                end
            else
                HealBot_Events_UnitStatus(button)
            end
        elseif button.status.unittype<20 then
            HealBot_Panel_EnemyTargetsWithPlayersUpdate(button.unit, button.guid)
        end
    elseif button.special.unit and HealBot_ValidLivingEnemy("player", button.unit) then
        HealBot_UnitEnemyTargetUpdate(button.unit, button.guid)
    end
end

function HealBot_Events_UnitPhase(button)
      --HealBot_setCall("HealBot_Events_UnitPhase", button)
    if button.status.range>0 then button.status.range=-3 end
    HealBot_Range_UpdateUnit(button)
end

function HealBot_Events_PlayerCheck()
      --HealBot_setCall("HealBot_Events_PlayerCheck")
    HealBot_Timers_Set("AURA","PlayerCheckExtended")
end

function HealBot_Events_PartyMembersChanged()
      --HealBot_setCall("HealBot_Events_PartyMembersChanged")
    HealBot_Timers_Set("OOC","RefreshPartyNextRecalcPlayers",true)
end

function HealBot_Events_RosterUpdate()
      --HealBot_setCall("HealBot_Events_RosterUpdate")
    HealBot_Timers_Set("OOC","PartyUpdateCheckSkin")
    HealBot_Events_PartyMembersChanged();
end

function HealBot_Events_TargetUpdate()
      --HealBot_setCall("HealBot_Events_TargetUpdate")
    HealBot_setLuVars("TargetNeedReset", true)
    HealBot_PlayerTargetChanged()
end

function HealBot_Events_VehicleChange(unit, enterVehicle)
      --HealBot_setCall("HealBot_Events_VehicleChange", nil, nil, unit)
    _,xButton,pButton=HealBot_UnitID(unit, true)
    if xButton then
        HealBot_VehicleChange(xButton, enterVehicle)
    end
    if pButton then
        HealBot_VehicleChange(pButton, enterVehicle)
    end
end

function HealBot_Events_UnitEnteredVehicle(unit)
      --HealBot_setCall("HealBot_Events_UnitEnteredVehicle", nil, nil, unit)
    HealBot_Events_VehicleChange(unit, true)
end

function HealBot_Events_UnitExitedVehicle(unit)
      --HealBot_setCall("HealBot_Events_UnitExitedVehicle", nil, nil, unit)
    HealBot_Events_VehicleChange(unit, false)
end

function HealBot_Events_UnitRoleChange()
      --HealBot_setCall("HealBot_Events_UnitRoleChange")
    HealBot_Events_PartyMembersChanged()
    HealBot_Timers_Set("AURA","ResetClassIconTexture",true)
end

function HealBot_Events_SpecChange(button)
          --HealBot_setCall("HealBot_Events_SpecChange", button)
    button.status.slowupdate=true
    button.specchange=true
end

function HealBot_Events_InspectReady(guid)
      --HealBot_setCall("HealBot_Events_InspectReady", nil, guid)
    xButton,pButton=HealBot_Panel_AllUnitButton(guid)
    if xButton then
        HealBot_GetTalentInfo(xButton)
    end
    if pButton then
        HealBot_GetTalentInfo(pButton)
    end
end

function HealBot_Events_UnitStatus(button)
      --HealBot_setCall("HealBot_Events_UnitStatus", button)
    HealBot_SetUnitDisconnect(button)
    if button.status.current<HealBot_Unit_Status["DC"] then
        HealBot_Action_UpdateTheDeadButton(button)
        if button.health.current == 0 then
            HealBot_UnitHealth(button)
        end
    end
end

function HealBot_Events_PlayerLevelSpellChange(arg1)
      --HealBot_setCall("HealBot_Events_PlayerLevelSpellChange")
    HealBot_Events_SpellsChanged(arg1);
    HealBot_Timers_Set("LAST","MountsPetsUse")
    HealBot_Timers_Set("PLAYER","TalentsChanged",true)
end

function HealBot_Events_PlayerTalentUpdate()
      --HealBot_setCall("HealBot_Events_PlayerTalentUpdate")
    HealBot_Timers_Set("PLAYER","TalentsChanged",true)
    HealBot_Events_SpellsChanged(1)
end

function HealBot_Events_CheckMount()
      --HealBot_setCall("HealBot_Events_CheckMount")
    HealBot_Timers_Set("LAST","MountsPetsUse")
end

function HealBot_Events_UnitGuildUpdate(unitTarget)
      --HealBot_setCall("HealBot_Events_UnitGuildUpdate")
    if UnitIsUnit(unitTarget, "player") then
        HealBot_Timers_Set("LAST","GuildUpdate")
    end
    local _,xButton,pButton=HealBot_UnitID(unitTarget)
    if xButton then HealBot_GetUnitGuild(xButton) end
    if pButton then HealBot_GetUnitGuild(pButton) end
end

function HealBot_Events_SpellsChanged(arg1)
      --HealBot_setCall("HealBot_Events_SpellsChanged")
    if arg1 == 0 then return; end
    HealBot_Timers_Set("LAST","InitLoadSpells",true)
end

function HealBot_Events_CastNotify(unitName,spell,unit)
      --HealBot_setCall("HealBot_Events_CastNotify", nil, nil, unit)
    local z=HealBot_Events_luVars["ChatNOTIFY"];
    local s=gsub(HealBot_Events_luVars["ChatMSG"],"#s",spell)
    s=gsub(s,"#l",HealBot_WoWAPI_SpellLink(spell, ""))
    s=gsub(s,"#n",unitName)
    local w=nil;

    if z == 3 and UnitIsPlayer(unit) and UnitPlayerControlled(unit) and not UnitIsUnit("player",unit) then
        s=gsub(s,unitName,HEALBOT_WORDS_YOU)
        HealBot_Comms_SendInstantMsg(s,unitName)
    elseif z == 5 then
        HealBot_Comms_SendInstantMsg(s,false,true)
    elseif z == 6 then
        HealBot_Comms_SendInstantMsg(s,false,false,true)
    elseif z == 4 then
        HealBot_Comms_SendInstantMsg(s)
    else
        HealBot_AddChat(s);
    end
end

function HealBot_Events_UnitSpellCastStart(button, unitTarget, castGUID, spellID)
      --HealBot_setCall("HealBot_Events_UnitSpellCastStart", button)
    if button.status.current<HealBot_Unit_Status["DC"] then
        if HealBot_Events_AuxAssigns["CastBar"][button.frame] and button.status.unittype<40 then
            scName, _, _, scStartTime, scEndTime=UnitCastingInfo(button.unit)
            if scEndTime then
                button.status.castend=scEndTime
                HealBot_Aux_UpdateCastBar(button, scName, scStartTime, scEndTime, false)
            end
        else
            scName=HealBot_WoWAPI_SpellName(spellID) or spellID or "x"
        end
        if HealBot_Events_ResSpells[scName] then
            if HealBot_Events_ResSpells[scName] == 2 then
                if HealBot_Events_luVars["massResTime"]<HealBot_TimeNow then
                    HealBot_Events_luVars["massResUnit"]=button.unit
                    HealBot_Events_luVars["massResTime"]=HealBot_TimeNow+10
                elseif HealBot_Events_luVars["massResAltTime"]<HealBot_TimeNow and HealBot_Events_luVars["massResUnit"]~=button.unit then
                    HealBot_Events_luVars["massResAltUnit"]=button.unit
                    HealBot_Events_luVars["massResAltTime"]=HealBot_TimeNow+10
                end
            end
        end
    else
        HealBot_Events_UnitStatus(button)
    end
    if button.player and HealBot_Spell_IDs[spellID] then
        HealBot_Check_SpellCooldown(spellID, HealBot_Spell_IDs[spellID].CastTime+HealBot_Events_luVars["DelayCD"])
    end
end

function HealBot_Events_UnitSpellChanStart(button, unitTarget, castGUID, spellID)
      --HealBot_setCall("HealBot_Events_UnitSpellChanStart", button)
    if HealBot_Events_AuxAssigns["CastBar"][button.frame] and button.status.unittype<40 then
        scName, _, _, scStartTime, scEndTime=UnitChannelInfo(button.unit)
        if scEndTime then
            button.status.castend=scEndTime
            HealBot_Aux_UpdateCastBar(button, scName, scStartTime, scEndTime, true)
        end
    end
    if button.player and HealBot_Spell_IDs[spellID] then
        HealBot_Check_SpellCooldown(spellID, HealBot_Spell_IDs[spellID].CastTime+HealBot_Events_luVars["DelayCD"])
    end
end

function HealBot_Events_UnitSpellCastStop(button, unitTarget, castGUID, spellID)
      --HealBot_setCall("HealBot_Events_UnitSpellCastStop", button)
    if castGUID == HealBot_Events_luVars["overhealCastID"] then
        _,xButton,pButton=HealBot_UnitID(HealBot_Events_luVars["overhealUnit"], true)
        HealBot_Events_luVars["overhealUnit"]="-nil-"
        HealBot_setLuVars("overhealUnit", "-nil-")
        HealBot_Events_luVars["overhealCastID"]="-nil-"
        if xButton and xButton.health.overheal>0 then
            xButton.health.overheal=0
            HealBot_Aux_UpdateOverHealBar(xButton)
            HealBot_OverHealText(xButton)
            HealBot_Action_AdaptiveOverhealsUpdate(button)
        end
        if pButton and pButton.health.overheal>0 then
            pButton.health.overheal=0
            HealBot_Aux_UpdateOverHealBar(pButton)
            HealBot_OverHealText(pButton)
            HealBot_Action_AdaptiveOverhealsUpdate(button)
        end
    end
    if button.status.castend>0 and button.status.unittype<40 then
        HealBot_Aux_ClearCastBar(button)
    end

    if HealBot_Events_luVars["massResUnit"] == button.unit then HealBot_Events_luVars["massResUnit"]="-nil" end
    if HealBot_Events_luVars["massResAltUnit"] == button.unit then HealBot_Events_luVars["massResAltUnit"]="-nil" end
    if button.player and HealBot_Spell_IDs[spellID] then HealBot_Check_SpellCooldown(spellID, HealBot_Events_luVars["DelayCD"]) end
end

function HealBot_Events_UnitSpellCastComplete(button, unitTarget, castGUID, spellID)
      --HealBot_setCall("HealBot_Events_UnitSpellCastComplete", button)
    if button.player then
        if HEALBOT_GAME_VERSION>8 and HealBot_Config_Cures.IgnoreOnCooldownDebuffs then
            C_Timer.After(HealBot_Events_luVars["DelayCD"], function() HealBot_Options_DebuffSpellAuraCD(HealBot_WoWAPI_SpellName(spellID) or HealBot_WoWAPI_ItemInfoInstant(spellID) or spellID) end)
        end
        if HealBot_Spell_IDs[spellID] then
            HealBot_Check_SpellCooldown(spellID, HealBot_Events_luVars["DelayCD"])
        end
    end
end

function HealBot_Events_UnitSpellCastFailed(button, unitTarget, castGUID, spellID)
      --HealBot_setCall("HealBot_Events_UnitSpellCastFailed", button)
    if HealBot_Events_luVars["massResUnit"] == button.unit then
        HealBot_Events_luVars["massResTime"]=0
        HealBot_Events_luVars["massResUnit"]="-nil"
    elseif HealBot_Events_luVars["massResAltUnit"] == button.unit then
        HealBot_Events_luVars["massResAltTime"]=0
        HealBot_Events_luVars["massResAltUnit"]="-nil"
    end
end

function HealBot_Events_MassRes()
      --HealBot_setCall("HealBot_Events_MassRes")
    if HealBot_Events_luVars["massResTime"]>HealBot_TimeNow or HealBot_Events_luVars["massResAltTime"]>HealBot_TimeNow then
        return true
    else
        return false
    end
end

local uscUnit, uscUnitName, uscSpellName=nil,false,false
function HealBot_Events_UnitSpellCastSent(caster,unitName,castGUID,spellID)
      --HealBot_setCall("HealBot_Events_UnitSpellCastSent")
    if UnitIsUnit("player",caster) then
        uscUnit=nil
        uscUnitName=HealBot_UnitNameOnly(unitName)
        uscSpellName=HealBot_WoWAPI_SpellName(spellID) or spellID

        if uscUnitName == HEALBOT_WORDS_UNKNOWN then
            uscUnitName=HealBot_GetCorpseName(uscUnitName)
        end

        if uscUnitName == "" then
            if spellID == HEALBOT_MENDPET and UnitExists("pet") then
                uscUnitName=UnitName("pet")
                uscUnit="pet"
            end
        else
            uscUnit=HealBot_Panel_RaidUnitName(uscUnitName)
            if uscUnit and not UnitExists(uscUnit) then uscUnit=nil end
        end

        if uscUnit and uscUnitName then
            _,xButton,pButton=HealBot_UnitID(uscUnit)
            if (xButton and hbv_Skins_GetFrameVar("BarText", "OVERHEAL", xButton.frame)<3) or
               (pButton and hbv_Skins_GetFrameVar("BarText", "OVERHEAL", pButton.frame)<3) then
                HealBot_setLuVars("overhealUnit", uscUnit)
                HealBot_Events_luVars["overhealUnit"]=uscUnit
                HealBot_Events_luVars["overhealCastID"]=castGUID
            end
        end
        if HealBot_Events_luVars["ChatNOTIFY"]>1 then
            if HealBot_Events_luVars["ChatRESONLY"] then
                if HealBot_Events_ResSpells[uscSpellName] then
                    if HealBot_Events_ResSpells[uscSpellName] == 2 then
                        HealBot_Events_CastNotify(HEALBOT_SORTBY_GROUP,uscSpellName,(uscUnit or ""))
                    elseif uscUnit and uscUnitName then
                        HealBot_Events_CastNotify(uscUnitName,uscSpellName,uscUnit)
                    end
                end
            elseif HealBot_Spells_KnownByName(uscSpellName) and uscUnit and uscUnitName then
                HealBot_Events_CastNotify(uscUnitName,uscSpellName,uscUnit)
            end
        end
        if HealBot_Spell_IDs[spellID] then
            HealBot_Check_SpellCooldown(spellID, HealBot_Spell_IDs[spellID].CastTime+HealBot_Events_luVars["DelayCD"])
        end
    end
end

function HealBot_Events_UnitAura(button)
      --HealBot_setCall("HealBot_Events_UnitAura", button)
    button.aura.buff.update=true
    button.aura.debuff.update=true
    HealBot_Events_CheckUnitAura(button)
end

function HealBot_Events_CheckUnitAura(button)
      --HealBot_setCall("HealBot_Events_CheckUnitAura", button)
    HealBot_Events_UnitDebuff(button)
    HealBot_Events_UnitBuff(button)
end

function HealBot_Events_EnemyDebuff(button)
    if button.frame == 10 then
        if hbv_Skins_GetBoolean("Enemy", "SHOWDEBUFFS") then
            HealBot_Aura_CheckUnitAuras(button, true, hbv_Skins_GetBoolean("Enemy", "SELFDEBUFFS"))
        end
    elseif hbv_Skins_GetBoolean("Enemy", "SHOWDEBUFFSPLAYERFRAMES") then
        HealBot_Aura_CheckUnitAuras(button, true, hbv_Skins_GetBoolean("Enemy", "SELFDEBUFFSPLAYERFRAMES"))
    end
end

function HealBot_Events_TimedUnitDebuff(button)
    button.event.debuff=false
    if button.status.unittype<40 then
        HealBot_Aura_CheckUnitAuras(button, true)
    else
        HealBot_Events_EnemyDebuff(button)
    end
end

function HealBot_Events_UnitDebuff(button)
      --HealBot_setCall("HealBot_Events_UnitDebuff", button)
    if not button.event.debuff then
        button.event.debuff=true
        button.event.aura=true
    end
end

function HealBot_Events_EnemyBuff(button)
    if button.frame == 10 then
        if hbv_Skins_GetBoolean("Enemy", "SHOWBUFFS") then
            HealBot_Aura_CheckUnitAuras(button, false, hbv_Skins_GetBoolean("Enemy", "SELFBUFFS"))
        end
    elseif hbv_Skins_GetBoolean("Enemy", "SHOWBUFFSPLAYERFRAMES") then
        HealBot_Aura_CheckUnitAuras(button, false, hbv_Skins_GetBoolean("Enemy", "SELFBUFFSPLAYERFRAMES"))
    end
end

function HealBot_Events_TimedUnitBuff(button)
    button.event.buff=false
    if button.status.unittype<40 then
        HealBot_Aura_CheckUnitAuras(button, false)
    else
        HealBot_Events_EnemyBuff(button)
    end
end

function HealBot_Events_UnitBuff(button)
      --HealBot_setCall("HealBot_Events_UnitBuff", button)
    if not button.event.buff then
        button.event.buff=true
        button.event.aura=true
    end
end

function HealBot_Events_UnitManaUpdate(button)
      --HealBot_setCall("HealBot_Events_UnitManaUpdate", button)
    button.mana.change=true
    --button.mana.nextcheck=HealBot_TimeNow+15
    HealBot_UnitMana(button)
end

local thauHealAmount=0
function HealBot_Events_TotalHealAbsorbs(button)
      --HealBot_setCall("HealBot_Events_TotalHealAbsorbs", button)
    if button.status.current<HealBot_Unit_Status["DEAD"] then
        thauHealAmount=(UnitGetTotalHealAbsorbs(button.unit) or 0)
    else
        thauHealAmount=0
    end
    if button.health.healabsorbs~=thauHealAmount then
        button.health.healabsorbs=thauHealAmount
        HealBot_Aux_UpdateTotalHealAbsorbsBar(button)
    end
end

function HealBot_Events_UnitThreat(button)
      --HealBot_setCall("HealBot_Events_UnitThreat", button)
    if UnitAffectingCombat(button.unit) then
        if button.status.current<HealBot_Unit_Status["DC"] then
            if not HealBot_Data["UILOCK"] and HealBot_retLuVars("UpdateEnemyFrame") and HealBot_Data["PALIVE"] then
                if hbv_Skins_GetVar("General", "UNITINCOMBAT")>1 and button.status.range>0 and
                   HealBot_ValidLivingEnemy(button.unit, button.unit.."target") and UnitIsUnit(button.unit, button.unit.."targettarget") then
                    if hbv_Skins_GetVar("General", "UNITINCOMBAT") == 3 then
                        HealBot_PlayerRegenDisabled()
                    else
                        HealBot_UnitInCombat()
                        HealBot_ResetRefreshLists()
                    end
                end
            end
            HealBot_CalcThreat(button)
        else
            HealBot_Events_UnitStatus(button)
        end
    end
end

function HealBot_Events_PowerIndicators(button)
      --HealBot_setCall("HealBot_Events_PowerIndicators", button)
    if button.player and button.status.current<HealBot_Unit_Status["DEAD"] then
        HealBot_Action_PowerIndicators(button)
    elseif button.mana.power~=0 then
        HealBot_Action_ZeroPowerIndicators(button)
    end
end

function HealBot_Events_ItemInfoReceived(self, itemId)
      --HealBot_setCall("HealBot_Events_ItemInfoReceived")
    HealBot_setLuVars("ItemDataReady", true)
    HealBot_Timers_Set("PLAYER","InitSmartCast",true,true)
end

function HealBot_Events_InvChange()
      --HealBot_setCall("HealBot_Events_InvChange")
    HealBot_Timers_Set("PLAYER","InvChange")
end

function HealBot_Events_EquipmentChange()
      --HealBot_setCall("HealBot_Events_EquipmentChange")
    HealBot_Events_InvChange()
    if HEALBOT_GAME_VERSION == 1 then
        HealBot_Timers_Set("LAST","InitLoadSpells",true)
    end
end

function HealBot_Events_RaidTargetAll()
      --HealBot_setCall("HealBot_Events_RaidTargetAll")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_RaidTargetUpdate(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_RaidTargetUpdate(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_RaidTargetUpdate(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_RaidTargetUpdate(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_RaidTargetUpdate(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_RaidTargetUpdate(xButton)
    end
    for xUnit,xButton in pairs(HealBot_UnitTarget_Button) do
        HealBot_RaidTargetUpdate(xButton)
    end
    for xUnit,xButton in pairs(HealBot_PrivateTarget_Button) do
        HealBot_RaidTargetUpdate(xButton)
    end
end

function HealBot_Events_ClassificationChanged(button)
          --HealBot_setCall("HealBot_Events_ClassificationChanged", button)
    if not UnitIsFriend("player",button.unit) then
        if not button.status.hostile then
            button.status.hostile=true
            HealBot_Range_ButtonSpell(button)
        end
    elseif button.status.hostile then
        button.status.hostile=false
        HealBot_Range_ButtonSpell(button)
    end
    if button.status.hostile~=button.icon.extra.hostile then
        if hbv_Skins_GetFrameBoolean("Icons", "SHOWHOSTILE", button.frame) then
            button.icon.extra.hostile=button.status.hostile
        else
            button.icon.extra.hostile=false
        end
        HealBot_Aura_UpdateCombat(button)
    end
end

local hbafk=false
function HealBot_Events_UnitFlagsChanged(button)
          --HealBot_setCall("HealBot_Events_UnitFlagsChanged", button)
    hbafk=false
    if hbv_Skins_GetFrameBoolean("Icons", "SHOWAFK", button.frame) and UnitIsAFK(button.unit) then
        hbafk=true
    end
    if button.status.afk~=hbafk then
        button.status.afk=hbafk
        HealBot_Aura_UpdateState(button)
    end
end

function HealBot_Events_IncomingSummons(unit)
      --HealBot_setCall("HealBot_Events_IncomingSummons", nil, nil, unit)
    _,xButton,pButton=HealBot_UnitID(unit, true)
    if C_IncomingSummon.IncomingSummonStatus(unit) == 1 then
        if xButton then HealBot_UnitSummonsUpdate(xButton, true) end
        if pButton then HealBot_UnitSummonsUpdate(pButton, true) end
    else
        if xButton then HealBot_UnitSummonsUpdate(xButton, false) end
        if pButton then HealBot_UnitSummonsUpdate(pButton, false) end
    end
end

function HealBot_Events_FocusChanged()
      --HealBot_setCall("HealBot_Events_FocusChanged")
    if (Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][13]["STATE"] or Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][14]["STATE"]) and hbv_Skins_GetBoolean("Enemy", "INCFOCUS") then
        HealBot_nextRecalcParty(5)
    end
    HealBot_FocusChanged()
    HealBot_Options_FramesActionIconsSetLists()
end

function HealBot_Events_PetsChanged()
      --HealBot_setCall("HealBot_Events_PetsChanged")
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["STATE"] then
        HealBot_Timers_Set("OOC","RefreshPartyNextRecalcPets")
    end
end

local amSenderId=false
function HealBot_Events_AddonMsg(addon_id,msg,distribution,sender_id)
      --HealBot_setCall("HealBot_Events_AddonMsg")
    if addon_id == HEALBOT_HEALBOT then
        amSenderId=HealBot_UnitNameOnly(sender_id)
        if amSenderId and msg then
            local datatype, datamsg=string.split(":", msg)
            if datatype then
                if datatype == "R" then
                    if amSenderId~=UnitName("player") then
                        HealBot_AddDebug("RECV: AddonMsg="..datatype.." from "..amSenderId,"Comms",true)
                        HealBot_SendVersion()
                        if not HealBot_Comms_KnownNames(amSenderId) then
                            HealBot_Comms_SendAddonMsg("W", 2, amSenderId)
                        end
                    end
                elseif datatype == "G" then
                    if amSenderId~=UnitName("player") then
                        HealBot_AddDebug("RECV: AddonMsg="..datatype.." from "..amSenderId,"Comms",true)
                        HealBot_SendGuildVersion()
                        if not HealBot_Comms_KnownNames(amSenderId) then
                            HealBot_Comms_SendAddonMsg("W", 2, amSenderId)
                        end
                    end
                elseif datatype == "S" then
                    if datamsg then
                        HealBot_Comms_PlayerVersion(amSenderId, datamsg)
                        HealBot_AddDebug("RECV: AddonMsg="..datatype.." from "..amSenderId.." Version="..datamsg,"Comms",true)
                        HealBot_Comms_CheckVer(amSenderId, datamsg)
                    end
                elseif datatype == "W" then
                    HealBot_Comms_SendAddonMsg("S:"..HEALBOT_VERSION, 2, amSenderId)
                elseif datatype == "U" then
                    if datamsg then
                        local guid,s=strsplit("~", datamsg)
                        if guid and s then
                            xButton,pButton=HealBot_Panel_RaidUnitButton(guid)
                            if xButton and xButton.spec~=" "..s.." " then
                                HealBot_Action_setGuidSpec(xButton, s)
                                if pButton then pButton.spec=" "..s.." " end
                            elseif pButton and pButton.spec~=" "..s.." " then
                                HealBot_Action_setGuidSpec(pButton, s)
                            end
                        end
                    end
                elseif datatype == "L" then
                    HealBot_Share_LinkMsg(datamsg, amSenderId)
                end
            end
        end
    end
end

function HealBot_Events_ReadyCheck(unitName,timer)
      --HealBot_setCall("HealBot_Events_ReadyCheck")
    if HealBot_UnitNameOnly(unitName) then
        local lUnit=HealBot_Panel_RaidUnitName(HealBot_UnitNameOnly(unitName))
        HealBot_setLuVars("rcEnd", HealBot_TimeNow+timer)
        for _,xButton in pairs(HealBot_Unit_Button) do
            if hbv_Skins_GetFrameBoolean("Icons", "SHOWRC", xButton.frame) then
                xButton.icon.extra.readycheck=hbv_GetStatic("rcWAITING")
                HealBot_Aura_UpdateState(xButton)
            end
        end
        for _,xButton in pairs(HealBot_Private_Button) do
            if hbv_Skins_GetFrameBoolean("Icons", "SHOWRC", xButton.frame) then
                xButton.icon.extra.readycheck=hbv_GetStatic("rcWAITING")
                HealBot_Aura_UpdateState(xButton)
            end
        end
        if lUnit then
            _,xButton,pButton=HealBot_UnitID(lUnit)
            if xButton then HealBot_ReadyCheckUpdate(xButton,true) end
            if pButton then HealBot_ReadyCheckUpdate(pButton,true) end
        end
    end
end

function HealBot_Events_ReadyCheckConfirmed(unit,response)
      --HealBot_setCall("HealBot_Events_ReadyCheckConfirmed", nil, nil, unit)
    _,xButton,pButton=HealBot_UnitID(unit)
    if xButton then HealBot_ReadyCheckUpdate(xButton,response) end
    if pButton then HealBot_ReadyCheckUpdate(pButton,response) end
end

function HealBot_Events_ReadyCheckClear(noAFK)
      --HealBot_setCall("HealBot_Events_ReadyCheckClear")
    if noAFK then
        HealBot_Update_RemoveExtraIcons(93)
    else
        for _,xButton in pairs(HealBot_Unit_Button) do
            HealBot_ReadyCheckClear(xButton)
        end
        for _,xButton in pairs(HealBot_Private_Button) do
            HealBot_ReadyCheckClear(xButton)
        end
    end
end

function HealBot_Events_ReadyCheckFinished()
      --HealBot_setCall("HealBot_Events_ReadyCheckFinished")
    HealBot_setLuVars("rcEnd", HealBot_TimeNow+3)
end

function HealBot_Events_SpellCD()
      --HealBot_setCall("HealBot_Events_SpellCD")
    if HealBot_Data["TIPBUTTON"] then HealBot_setTooltipUpdateNow() end
    if HealBot_Events_luVars["pluginMyCooldowns"] then
        HealBot_Plugin_MyCooldowns_PlayerUpdateAll()
    end
    if HealBot_Events_luVars["pluginAuraWatch"] then
        HealBot_Plugin_AuraWatch_UpdateAllCDs()
    end
    HealBot_ActionIcons_UpdateAllCDs()
end

function HealBot_Events_SpellCharges()
      --HealBot_setCall("HealBot_Events_SpellCharges")
    HealBot_Timers_Set("SKINS","SelfCountTextUpdate")
end

function HealBot_Events_RegenDisabled()
      --HealBot_setCall("HealBot_Events_RegenDisabled")
    --if HealBot_Options:IsVisible() then
    --    HealBot_TogglePanel(HealBot_Options, true)
    --end
    if HealBot_Events_luVars["AddonLoaded"] and not HealBot_Events_luVars["VarsLoaded"] then
        HealBot_VariablesLoaded()
    end
    if HealBot_Events_luVars["VarsLoaded"] and not HealBot_Events_luVars["Loaded"] then
        HealBot_Init_Spells_Defaults()
        HealBot_Options_InitDebuffTypes()
        HealBot_InitSmartCast()
        HealBot_Options_InitBuffList()
        HealBot_Options_ComboClass_Text()
        HealBot_Options_BarFreq_setVars()
        HealBot_Options_FluidFlashInUse()
        HealBot_Action_SetFocusGroups()
        HealBot_Options_AuxBarFlashAlphaMinMaxSet()
        HealBot_Options_Buff_Reset()
        HealBot_Aura_ConfigClassHoT()
        HealBot_Aura_ResetBuffCache()
        HealBot_Options_Debuff_Reset()
        HealBot_Options_setDebuffPriority()
        HealBot_Action_ResetAllButtons()
        HealBot_Aura_InitData()
        HealBot_Action_setAdaptive()
        HealBot_Register_Events()
        HealBot_PartyUpdate_CheckSkin(true)
        HealBot_Options_SetSkins()
        HealBot_Options_setAuxBars()
        HealBot_Update_AllAuxBars()
        HealBot_Action_ResetFrameAlias()
        HealBot_AllRefreshTypes()
    end
    HealBot_PlayerRegenDisabled();
    HealBot_UpdateLocalUILock(true)
    if HealBot_Events_luVars["VarsLoaded"] and not HealBot_Events_luVars["Loaded"] then
        HealBot_Timers_PowerIndicator()
        HealBot_Update_AllThreat()
        HealBot_Timers_Set("OOC","FullReload",true)
    end
end

function HealBot_Events_RegenEnabled()
      --HealBot_setCall("HealBot_Events_RegenEnabled")
    HealBot_UpdateLocalUILock(false)
end

function HealBot_Events_AddOnLoaded(addonName)
      --HealBot_setCall("HealBot_Events_AddOnLoaded")
    if addonName == "HealBot" and not HealBot_Events_luVars["AddonLoaded"] then
        HealBot_LoadAddOn()
        HealBot_Events_luVars["AddonLoaded"]=true
    end
end

function HealBot_Events_VariablesLoaded()
      --HealBot_setCall("HealBot_Events_VariablesLoaded")
    if HealBot_Events_luVars["AddonLoaded"] then
        HealBot_VariablesLoaded()
        HealBot_Events_luVars["VarsLoaded"]=true
    elseif not HealBot_Events_luVars["WaitedOnAddonLoaded"] then
        HealBot_Events_luVars["WaitedOnAddonLoaded"]=true
        C_Timer.After(0.5, HealBot_Events_VariablesLoaded)
    else
        C_Timer.After(1, HealBot_FullReload)
    end
end

function HealBot_Events_ZoneChange()
      --HealBot_setCall("HealBot_Events_ZoneChange")
    HealBot_Timers_Set("LAST","CheckZone")
end

function HealBot_Events_SubZoneChange()
      --HealBot_setCall("HealBot_Events_SubZoneChange")
    HealBot_Timers_Set("LAST","CheckSubZone")
end

function HealBot_Events_PlayerEnteringWorld()
      --HealBot_setCall("HealBot_Events_PlayerEnteringWorld")
    HealBot_resetLuVars()
    HealBot_setLuVars("CheckAuraFlags", true)
    HealBot_setLuVars("DropCombat", 1)
    HealBot_Timers_Set("INIT","EnteringWorld")
    HealBot_Timers_Set("OOC","SaveSpellsProfile")
    HealBot_setLuVars("qaFRNext", HealBot_TimeNow+5)
    HealBot_Timers_TurboOn()
end

function HealBot_Events_PlayerLeavingWorld()
      --HealBot_setCall("HealBot_Events_PlayerLeavingWorld")
    HealBot_setLuVars("qaFRNext", HealBot_TimeNow+90)
    HealBot_Timers_Set("LAST","EndAggro")
    HealBot_Options_SaveSpellsProfile()
    --HealBot_UnRegister_Events();
end

function HealBot_Events_UIDisplayChange()
      --HealBot_setCall("HealBot_Events_UIDisplayChange")
    HealBot_Timers_Set("SKINS","FramesSetPointCheck")
end

function HealBot_Events_CursorChanged(isDefault, newCursorType)
      --HealBot_setCall("HealBot_Events_CursorChanged")
    HealBot_Options_CursorChanged(isDefault, newCursorType)
    HealBot_ActionIcons_CursorChanged(isDefault, newCursorType)
end

function HealBot_Events_ModifierChange()
      --HealBot_setCall("HealBot_Events_ModifierChange")
    HealBot_Action_SetCurrentModKeys()
    if HealBot_Data["TIPBUTTON"] then
        HealBot_setTooltipUpdateNow()
    elseif HealBot_Data["TIPICON"] then
        HealBot_Tooltip_UpdateIconTooltip()
    end
    if not HealBot_Data["UILOCK"] then HealBot_Action_ModKey() end
    HealBot_Range_setLuVars("modKeyUpdate", HealBot_TimeNow)
end

function HealBot_Events_PetBattleStart()
      --HealBot_setCall("HealBot_Events_PetBattleStart")
    HealBot_setLuVars("lastPetBattleEvent", "PET_BATTLE_OPENING_START")
    HealBot_Timers_Set("OOC","PartyUpdateCheckSkin")
end

function HealBot_Events_PetBattleOver()
      --HealBot_setCall("HealBot_Events_PetBattleOver")
    HealBot_setLuVars("lastPetBattleEvent", "PET_BATTLE_OVER")
    HealBot_Timers_Set("OOC","PartyUpdateCheckSkin")
end
