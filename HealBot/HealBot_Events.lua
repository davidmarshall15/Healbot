local xButton,pButton
local scName, scStartTime, scEndTime="",0,0
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
HealBot_Events_luVars["EventsDelay"]=1
HealBot_Events_luVars["EventsShortDelay"]=0.02
HealBot_Events_luVars["EventsTime"]=0

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

function HealBot_Events_UpdateCheckInterval()
    HealBot_Events_luVars["EventsDelay"]=HealBot_Util_PerfVal2(970)
    if HealBot_Events_luVars["EventsDelay"]<0.05 then
        HealBot_Events_luVars["EventsDelay"]=0.05
    elseif HealBot_Events_luVars["EventsDelay"]>0.25 then
        HealBot_Events_luVars["EventsDelay"]=0.25
    end
    HealBot_Events_luVars["EventsShortDelay"]=HealBot_Util_Round((HealBot_Events_luVars["EventsDelay"]/8),2)
    if HealBot_Events_luVars["EventsShortDelay"]<0.01 then HealBot_Events_luVars["EventsShortDelay"]=0.01 end
    HealBot_Debug_PerfUpdate("EventsDelay", HealBot_Events_luVars["EventsDelay"])
    HealBot_Debug_PerfUpdate("EventsShortDelay", HealBot_Events_luVars["EventsShortDelay"])
end

function HealBot_Events_SetEventsTime()
    HealBot_Events_luVars["EventsTime"]=HealBot_TimeNow-HealBot_Events_luVars["EventsDelay"]
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
    else
        HealBot_Events_luVars["DelayCD"]=HealBot_Globals.LAG+0.075
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
    button.status.rangenextcheck=HealBot_TimeNow
end

function HealBot_Events_UnitTarget(button)
          --HealBot_setCall("HealBot_Events_UnitTarget", button)
    if UnitAffectingCombat(button.unit) then
        if button.status.current<HealBot_Unit_Status["DC"] then
            if button.isplayer then
                if not HealBot_Data["UILOCK"] then
                    if HealBot_Panel_IsTargetingEnemy(button.unit) then
                        HealBot_nextRecalcParty(5,0.05)
                    end
                else
                    HealBot_Events_CalcThreat(button)
                end
            end
        else
            HealBot_Events_UnitStatus(button)
        end
    elseif button.isplayer and button.status.unittype<7 then
        HealBot_Panel_EnemyTargetsWithPlayersUpdate(button.unit, button.guid)
    end
end

function HealBot_Events_UnitPhase(button)
      --HealBot_setCall("HealBot_Events_UnitPhase", button)
    if button.status.range>0 then button.status.range=-3 end
    button.status.rangenextcheck=0
end

function HealBot_Events_PlayerCheck()
      --HealBot_setCall("HealBot_Events_PlayerCheck")
    HealBot_Timers_Set("AURA","PlayerCheckExtended")
end

function HealBot_Events_PartyMembersChanged()
      --HealBot_setCall("HealBot_Events_PartyMembersChanged")
    HealBot_Timers_Set("OOC","RefreshPartyNextRecalcPlayers")
    if HealBot_Data["UILOCK"] then
        HealBot_Update_AllPartyGUIDs()
    end
end

function HealBot_Events_RosterUpdate()
      --HealBot_setCall("HealBot_Events_RosterUpdate")
    HealBot_Timers_Set("SKINS","PartyUpdateCheckSkin",0.05)
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
    HealBot_Timers_Set("AURA","ResetClassIconTexture",0.05)
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

function HealBot_Events_UnitGUIDChange(button)
      --HealBot_setCall("HealBot_Events_UnitGUIDChange", button)
    if button.guid~=UnitGUID(button.unit) then
        HealBot_UpdateUnitGUIDChange(button, true)
    else
        button.status.slowupdate=true
        button.status.change=true
        button.status.update=true
    end
end

function HealBot_Events_UnitStatus(button)
      --HealBot_setCall("HealBot_Events_UnitStatus", button)
    HealBot_SetUnitDisconnect(button)
    if button.status.current<HealBot_Unit_Status["DC"] then
        HealBot_Action_UpdateTheDeadButton(button)
        if button.health.current == 0 then
            HealBot_Events_UnitHealth(button)
        end
    end
end

function HealBot_Events_PlayerLevelSpellChange(arg1)
      --HealBot_setCall("HealBot_Events_PlayerLevelSpellChange")
    HealBot_Events_SpellsChanged(arg1);
    HealBot_Timers_Set("LAST","MountsPetsUse")
    HealBot_Timers_Set("PLAYER","TalentsChanged",1)
end

function HealBot_Events_PlayerTalentUpdate()
      --HealBot_setCall("HealBot_Events_PlayerTalentUpdate")
    HealBot_Timers_Set("PLAYER","TalentsChanged",1)
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
    HealBot_Timers_Set("LAST","InitLoadSpells",0.2)
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
        if HealBot_Events_AuxAssigns["CastBar"][button.frame] and button.status.unittype~=11 then
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
    if HealBot_Events_AuxAssigns["CastBar"][button.frame] and button.status.unittype~=11 then
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
    if button.status.castend>0 and button.status.unittype~=11 then
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
            if (xButton and HealBot_Skins_GetFrameVar("BarText", "OVERHEAL", xButton.frame)<3) or
               (pButton and HealBot_Skins_GetFrameVar("BarText", "OVERHEAL", pButton.frame)<3) then
                HealBot_setLuVars("overhealUnit", uscUnit)
                HealBot_Events_luVars["overhealUnit"]=uscUnit
                HealBot_Events_luVars["overhealCastID"]=castGUID
            end
        end
        if HealBot_Events_luVars["ChatNOTIFY"]>1 then
            if HealBot_Events_luVars["ChatRESONLY"] then
                if HealBot_Events_ResSpells[uscSpellName] then
                    if HealBot_Events_ResSpells[uscSpellName] == 2 then
                        HealBot_Events_CastNotify(HEALBOT_OPTIONS_GROUPHEALS,uscSpellName,(uscUnit or ""))
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
        if HealBot_Skins_GetBoolean("Enemy", "SHOWDEBUFFS") then
            HealBot_Aura_CheckUnitAuras(button, true, HealBot_Skins_GetBoolean("Enemy", "SELFDEBUFFS"))
        end
    elseif HealBot_Skins_GetBoolean("Enemy", "SHOWDEBUFFSPLAYERFRAMES") then
        HealBot_Aura_CheckUnitAuras(button, true, HealBot_Skins_GetBoolean("Enemy", "SELFDEBUFFSPLAYERFRAMES"))
    end
end

function HealBot_Events_TimedUnitDebuff(button)
    button.aura.debuff.timed=false
    if button.status.unittype<11 then
        HealBot_Aura_CheckUnitAuras(button, true)
    else
        HealBot_Events_EnemyDebuff(button)
    end
end

function HealBot_Events_UnitDebuff(button)
      --HealBot_setCall("HealBot_Events_UnitDebuff", button)
    if not button.aura.debuff.timed then
        button.aura.debuff.timed=true
        if button.aura.debuff.updtime>HealBot_Events_luVars["EventsTime"] then
            C_Timer.After(HealBot_Events_luVars["EventsDelay"], function() HealBot_Events_TimedUnitDebuff(button) end)
        else
            C_Timer.After(HealBot_Events_luVars["EventsShortDelay"], function() HealBot_Events_TimedUnitDebuff(button) end)
        end
    end
end

function HealBot_Events_EnemyBuff(button)
    if button.frame == 10 then
        if HealBot_Skins_GetBoolean("Enemy", "SHOWBUFFS") then
            HealBot_Aura_CheckUnitAuras(button, false, HealBot_Skins_GetBoolean("Enemy", "SELFBUFFS"))
        end
    elseif HealBot_Skins_GetBoolean("Enemy", "SHOWBUFFSPLAYERFRAMES") then
        HealBot_Aura_CheckUnitAuras(button, false, HealBot_Skins_GetBoolean("Enemy", "SELFBUFFSPLAYERFRAMES"))
    end
end

function HealBot_Events_TimedUnitBuff(button)
    button.aura.buff.timed=false
    if button.status.unittype<11 then
        HealBot_Aura_CheckUnitAuras(button, false)
    else
        HealBot_Events_EnemyBuff(button)
    end
end

function HealBot_Events_UnitBuff(button)
      --HealBot_setCall("HealBot_Events_UnitBuff", button)
    if not button.aura.buff.timed then
        button.aura.buff.timed=true
        if button.aura.buff.updtime>HealBot_Events_luVars["EventsTime"] then
            C_Timer.After(HealBot_Events_luVars["EventsDelay"], function() HealBot_Events_TimedUnitBuff(button) end)
        else
            C_Timer.After(HealBot_Events_luVars["EventsShortDelay"], function() HealBot_Events_TimedUnitBuff(button) end)
        end
    end
end

function HealBot_Events_TimedUnitHealth(button)
    button.health.timed=false
    HealBot_UnitHealth(button)
end

function HealBot_Events_UnitHealth(button)
      --HealBot_setCall("HealBot_Events_UnitHealth", button)
    if not button.health.timed then
        button.health.timed=true
        if button.health.updtime>HealBot_Events_luVars["EventsTime"] then
            C_Timer.After(HealBot_Events_luVars["EventsDelay"], function() HealBot_Events_TimedUnitHealth(button) end)
        else
            C_Timer.After(HealBot_Events_luVars["EventsShortDelay"], function() HealBot_Events_TimedUnitHealth(button) end)
        end
    end
end

function HealBot_Events_TimedUnitMana(button)
    button.mana.timed=false
    HealBot_UnitMana(button)
end

function HealBot_Events_UnitMana(button)
      --HealBot_setCall("HealBot_Events_UnitMana", button)
    if not button.mana.timed then
        button.mana.timed=true
        if button.mana.updtime>HealBot_Events_luVars["EventsTime"] then
            C_Timer.After(HealBot_Events_luVars["EventsDelay"], function() HealBot_Events_TimedUnitMana(button) end)
        else
            C_Timer.After(HealBot_Events_luVars["EventsShortDelay"], function() HealBot_Events_TimedUnitMana(button) end)
        end
    end
end

function HealBot_Events_UnitManaUpdate(button)
      --HealBot_setCall("HealBot_Events_UnitManaUpdate", button)
    button.mana.change=true
    button.mana.nextcheck=HealBot_TimeNow+15
    HealBot_Events_UnitMana(button)
end

function HealBot_Events_TimedHealsInUpdate(button)
    button.health.inhealtimed=false
    HealBot_HealsInUpdate(button)
end

function HealBot_Events_HealsInUpdate(button)
      --HealBot_setCall("HealBot_Events_HealsInUpdate", button)
    if not button.health.inhealtimed then
        button.health.inhealtimed=true
        if button.health.inhealupdtime>HealBot_Events_luVars["EventsTime"] then
            C_Timer.After(HealBot_Events_luVars["EventsDelay"], function() HealBot_Events_TimedHealsInUpdate(button) end)
        else
            C_Timer.After(HealBot_Events_luVars["EventsShortDelay"], function() HealBot_Events_TimedHealsInUpdate(button) end)
        end
    end
end

function HealBot_Events_TimedAbsorbsUpdate(button)
    button.health.absorbtimed=false
    HealBot_AbsorbsUpdate(button)
end

function HealBot_Events_AbsorbsUpdate(button)
      --HealBot_setCall("HealBot_Events_AbsorbsUpdate", button)
    if not button.health.absorbtimed then
        button.health.absorbtimed=true
        if button.health.absorbupdtime>HealBot_Events_luVars["EventsTime"] then
            C_Timer.After(HealBot_Events_luVars["EventsDelay"], function() HealBot_Events_TimedAbsorbsUpdate(button) end)
        else
            C_Timer.After(HealBot_Events_luVars["EventsShortDelay"], function() HealBot_Events_TimedAbsorbsUpdate(button) end)
        end
    end
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

function HealBot_Events_TimedCalcThreat(button)
    button.aggro.timed=false
    HealBot_CalcThreat(button)
end

function HealBot_Events_CalcThreat(button)
      --HealBot_setCall("HealBot_Events_CalcThreat", button)
    if not button.aggro.timed then
        button.aggro.timed=true
        if button.aggro.updtime>HealBot_Events_luVars["EventsTime"] then
            C_Timer.After(HealBot_Events_luVars["EventsDelay"], function() HealBot_Events_TimedCalcThreat(button) end)
        else
            C_Timer.After(HealBot_Events_luVars["EventsShortDelay"], function() HealBot_Events_TimedCalcThreat(button) end)
        end
    end
end

function HealBot_Events_UnitThreat(button)
      --HealBot_setCall("HealBot_Events_UnitThreat", button)
    if UnitAffectingCombat(button.unit) then
        if button.status.current<HealBot_Unit_Status["DC"] then
            if not HealBot_Data["UILOCK"] and HealBot_retLuVars("UpdateEnemyFrame") and HealBot_Data["PALIVE"] then
                if HealBot_Skins_GetVar("General", "UNITINCOMBAT")>1 and button.status.range>0 and
                   HealBot_ValidLivingEnemy(button.unit, button.unit.."target") and UnitIsUnit(button.unit, button.unit.."targettarget") then
                    if HealBot_Skins_GetVar("General", "UNITINCOMBAT") == 3 then
                        HealBot_PlayerRegenDisabled()
                    else
                        HealBot_UnitInCombat()
                    end
                end
            end
            HealBot_Events_CalcThreat(button)
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
    HealBot_Timers_Set("PLAYER","InitSmartCast",1)
end

function HealBot_Events_InvChange()
      --HealBot_setCall("HealBot_Events_InvChange")
    HealBot_Timers_Set("PLAYER","InvChange")
end

function HealBot_Events_EquipmentChange()
      --HealBot_setCall("HealBot_Events_EquipmentChange")
    HealBot_Events_InvChange()
    if HEALBOT_GAME_VERSION == 1 then
        HealBot_Timers_Set("LAST","InitLoadSpells",0.2)
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
        if not button.status.hostile or HealBot_Skins_GetFrameBoolean("Icons", "SHOWHOSTILE", button.frame) then
            button.icon.extra.hostile=button.status.hostile
            HealBot_Aura_UpdateState(button)
        end
    end
end

local hbafk=false
function HealBot_Events_UnitFlagsChanged(button)
          --HealBot_setCall("HealBot_Events_UnitFlagsChanged", button)
    hbafk=false
    if HealBot_Skins_GetFrameBoolean("Icons", "SHOWAFK", button.frame) and UnitIsAFK(button.unit) then
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
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][11]["STATE"] and HealBot_Skins_GetBoolean("Enemy", "INCFOCUS") then
        HealBot_nextRecalcParty(5,0.05)
    end
    HealBot_FocusChanged()
    HealBot_Options_FramesActionIconsSetLists()
end

function HealBot_Events_PetsChanged()
      --HealBot_setCall("HealBot_Events_PetsChanged")
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["STATE"] then
        HealBot_Timers_Set("OOC","RefreshPartyNextRecalcPets")
    end
    if HealBot_Data["UILOCK"] then
        HealBot_Update_AllPetGUIDs()
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
                        if not HealBot_Events_luVars[amSenderId] then
                            HealBot_Comms_SendAddonMsg("W", 2, amSenderId)
                        end
                    end
                elseif datatype == "G" then
                    if amSenderId~=UnitName("player") then
                        HealBot_AddDebug("RECV: AddonMsg="..datatype.." from "..amSenderId,"Comms",true)
                        HealBot_SendGuildVersion()
                        if not HealBot_Events_luVars[amSenderId] then
                            HealBot_Comms_SendAddonMsg("W", 2, amSenderId)
                        end
                    end
                elseif datatype == "S" then
                    if datamsg then
                        HealBot_Events_luVars[amSenderId]=datamsg
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
            if HealBot_Skins_GetFrameBoolean("Icons", "SHOWRC", xButton.frame) then
                xButton.icon.extra.readycheck=HealBot_ReadyCheckStatus["WAITING"]
                HealBot_Aura_UpdateState(xButton)
            end
        end
        for _,xButton in pairs(HealBot_Private_Button) do
            if HealBot_Skins_GetFrameBoolean("Icons", "SHOWRC", xButton.frame) then
                xButton.icon.extra.readycheck=HealBot_ReadyCheckStatus["WAITING"]
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
        HealBot_Timers_Set("OOC","FullReload",1)
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
    HealBot_setLuVars("qaFRNext", HealBot_TimeNow+5)
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
--        HealBot_AddDebug("RefreshTooltip","Tooltip",true)
    elseif HealBot_Data["TIPICON"] then
        HealBot_Tooltip_UpdateIconTooltip()
    end
    if not HealBot_Data["UILOCK"] then HealBot_Action_ModKey() end
    HealBot_Range_setLuVars("modKeyUpdate", HealBot_TimeNow)
end

function HealBot_Events_PetBattleStart()
      --HealBot_setCall("HealBot_Events_PetBattleStart")
    HealBot_setLuVars("lastPetBattleEvent", "PET_BATTLE_OPENING_START")
    HealBot_Timers_Set("SKINS","PartyUpdateCheckSkin")
end

function HealBot_Events_PetBattleOver()
      --HealBot_setCall("HealBot_Events_PetBattleOver")
    HealBot_setLuVars("lastPetBattleEvent", "PET_BATTLE_OVER")
    HealBot_Timers_Set("SKINS","PartyUpdateCheckSkin")
end
