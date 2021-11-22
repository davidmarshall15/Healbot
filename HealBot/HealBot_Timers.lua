local HealBot_Timers_Init={}
local HealBot_Timers={
                      ["INIT"]={},
                      ["RESET"]={},
                      ["PARTY"]={},
                      ["PLAYER"]={},
                      ["WHEEL"]={},
                      ["SKINS"]={},
                      ["AUX"]={},
                      ["EMERG"]={},
                      ["AURA"]={},
                      ["CHAT"]={},
                      ["INITSLOW"]={},
                      ["PARTYSLOW"]={},
                      ["PLAYERSLOW"]={},
                      ["SKINSSLOW"]={},
                      ["LAST"]={},
                     }
local HealBot_Timers_NoDups={
                      ["INIT"]={},
                      ["RESET"]={},
                      ["PARTY"]={},
                      ["PLAYER"]={},
                      ["WHEEL"]={},
                      ["SKINS"]={},
                      ["AUX"]={},
                      ["EMERG"]={},
                      ["AURA"]={},
                      ["CHAT"]={},
                      ["INITSLOW"]={},
                      ["PARTYSLOW"]={},
                      ["PLAYERSLOW"]={},
                      ["SKINSSLOW"]={},
                      ["LAST"]={},
                     }
local HealBot_Timers_NoCalls={}

function HealBot_Timer_SkinsFormat()
    HealBot_Text_sethbNumberFormat()
    HealBot_Text_sethbAggroNumberFormat()
    HealBot_Timers_Set("PARTYSLOW","ResetUnitStatus")
    HealBot_Aura_SetIconUpdateInterval()
    HealBot_Timers_Set("PARTYSLOW","RefreshPartyNextRecalcAll")
end

function HealBot_Timer_FluidFlashUpdate()
    HealBot_Options_BarFreq_setVars()
    HealBot_Timers_Set("SKINS","FluidFlashInUse")
    HealBot_Timers_Set("SKINS","SetFocusGroups")
    HealBot_Options_AuxBarFlashAlphaMinMaxSet()
end

function HealBot_Timer_nextRecalcAll()
    HealBot_nextRecalcParty(0)
end

function HealBot_Timer_nextRecalcPlayers()
    HealBot_nextRecalcParty(6)
end

function HealBot_Timer_nextRecalcPets()
    HealBot_nextRecalcParty(2)
end

function HealBot_Timer_nextRecalcEnemy()
    HealBot_nextRecalcParty(5)
end

function HealBot_Timer_MouseWheelUpdate()
    if not InCombatLockdown() then
        for i=1, 10 do
            local g = _G["f"..i.."_HealBot_Action"]
            if HealBot_Globals.HealBot_Enable_MouseWheel then
                g:EnableMouseWheel(1)  
                g:SetScript("OnMouseWheel", function(self, delta)
                    HealBot_Action_HealUnit_Wheel(self, delta)
                end)
            else
                g:SetScript("OnMouseWheel", nil)
                g:EnableMouseWheel(false)
            end
        end
    else
        HealBot_Timers_Set("WHEEL","WheelUpdate")
    end
end

function HealBot_Timer_HealthAlertLevel_OC()
    HealBot_HealthAlertLevel(false)
end

function HealBot_Timer_ResetUnitStatus()
    HealBot_Action_ResetUnitStatus()
end

function HealBot_Timer_SkinBarTextColours()
    HealBot_Options_SetBarsTextColour()
    HealBot_Panel_resetTestCols(true)
    HealBot_Timers_Set("PARTYSLOW","ResetUnitStatus")
    HealBot_Timers_Set("SKINSSLOW","UpdateTextButtons")
end

function HealBot_Timer_CheckPlayerAura()
    local _,xButton,pButton = HealBot_UnitID("player")
    if xButton then HealBot_Check_UnitAura(xButton) end
    if pButton then HealBot_Check_UnitAura(pButton) end
end

function HealBot_Timer_CheckTalentInfo()
    local _,xButton,pButton = HealBot_UnitID("player")
    if xButton then HealBot_GetTalentInfo(xButton) end
    if pButton then HealBot_GetTalentInfo(pButton) end
end

function HealBot_Timer_PowerIndicator()
    HealBot_Action_setpcClass()       
    local _,xButton,pButton = HealBot_UnitID("player")
    if xButton then
        HealBot_OnEvent_UnitManaUpdate(xButton)
    end
    if pButton then
        HealBot_OnEvent_UnitManaUpdate(pButton)
    end
end

function HealBot_Timer_FrameAliases()
    for fNo=1,10 do
        HealBot_Action_SetAlias(fNo)
        HealBot_Action_SetAliasFontSize(fNo)
    end
end

function HealBot_Timer_CheckLowMana()
    local checkLowMana=false
    for j=1,10 do
        if Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j]["LOWMANA"]>1 and 
           Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j]["LOWMANACOMBAT"]==false then
            checkLowMana=true
            break
        end
    end
    if checkLowMana then HealBot_CheckLowMana() end
end

function HealBot_Timer_FramesSetPoint()
    for x=1,10 do
        if HealBot_Action_FrameIsVisible(x) then
            HealBot_Action_setPoint(x)
        end
    end
end

function HealBot_Timer_TargetFocusUpdate()
    HealBot_PlayerTargetChanged()
    if HEALBOT_GAME_VERSION>1 then
        HealBot_FocusChanged()
    end
    HealBot_nextRecalcParty(2)
    HealBot_nextRecalcParty(1)
end

function HealBot_Timer_PlayerSpecUpdate()
    if HEALBOT_GAME_VERSION>3 then
        HealBot_ResetOnSpecChange(HealBot_Config.CurrentSpec)
    else
        HealBot_ResetOnSpecChange()
    end
end

function HealBot_Timer_EnableHealBot()
    HealBot_Register_Events()
    HealBot_nextRecalcParty(0)
end

function HealBot_Timer_DisableHealBot()
    HealBot_Config.DisabledNow=1
    HealBot_nextRecalcParty(0)
    HealBot_UnRegister_Events()
    HealBot_Register_Events()
    for j=1,10 do
        HealBot_Action_HidePanel(j)
    end
end

function HealBot_Timer_SpellsLoaded()
    HealBot_Timers_Set("INIT","InitBuffList")
    HealBot_Timers_Set("INITSLOW","InitAuraData")
    HealBot_Timers_Set("INIT","BuffReset")  
    HealBot_Timers_Set("INIT","DebuffReset")
    HealBot_Timers_Set("INIT","SpellsTabText")
    HealBot_Timers_Set("INIT","FluidFlash")
end

function HealBot_Timer_SpellsResetTabs()
    HealBot_Options_ResetDoInittab(50)
    HealBot_Options_ResetDoInittab(40)
    HealBot_Options_ResetDoInittab(10)
    HealBot_Options_ResetDoInittab(5)
    HealBot_Options_ResetDoInittab(4)
    HealBot_Options_setDebuffTypes()
end

function HealBot_Timer_LastLoad()
    HealBot_Timers_Set("INITSLOW","InitSpells")
    HealBot_Timers_Set("LAST","SpellsLoaded")
end

function HealBot_Timer_OnLoad()
    HealBot_Options_SetSkins()
    HealBot_PlayerCheckExtended()
    HealBot_Timers_Set("INIT","ConfigClassHoT")
    HealBot_Timers_Set("INIT","MMButtonInit")
    HealBot_Timers_Set("INIT","IgnoreDebuffsDuration")
    HealBot_Timers_Set("INIT","InitBuffClassList")
    HealBot_Timers_Set("INIT","SpellsLoaded")
end

function HealBot_Timer_Loaded()
    HealBot_AddChat(HEALBOT_HEALBOT .. " " .. _G["GREEN_FONT_COLOR_CODE"]..HEALBOT_VERSION.._G["FONT_COLOR_CODE_CLOSE"] .. HEALBOT_LOADED .. " " .. HEALBOT_FORHELP .. _G["YELLOW_FONT_COLOR_CODE"].." /hb h".._G["FONT_COLOR_CODE_CLOSE"]);
end

local hbTimerFuncs={["INIT"]={
                        ["InitSpells"]=HealBot_InitSpells,
                        ["BuffReset"]=HealBot_Options_Buff_Reset,
                        ["DebuffReset"]=HealBot_Options_Debuff_Reset,
                        ["SpellsTabText"]=HealBot_Options_ComboClass_Text,
                        ["FluidFlash"]=HealBot_Timer_FluidFlashUpdate,
                        ["CheckFrameSetPoint"]=HealBot_Action_CheckFrameSetPoint,
                        ["InitNewChar"]=HealBot_InitNewChar,
                        ["CheckTalentInfo"]=HealBot_Timer_CheckTalentInfo,
                        ["RegisterIncHeals"]=HealBot_Register_IncHeals,
                        ["SetEnabledAttribs"]=HealBot_Action_SetEnabledAttribs,
                        ["SetEnemyAttribs"]=HealBot_Action_SetEnemyAttribs,
                        ["SetEmergAttribs"]=HealBot_Action_SetEmergAttribs,
                        ["PrepSetAllAttribs"]=HealBot_Action_PrepSetAllAttribs,
                        ["PrepSetEnabledAttribs"]=HealBot_Action_PrepSetEnabledAttribs,
                        ["PrepSetEnemyAttribs"]=HealBot_Action_PrepSetEnemyAttribs,
                        ["PrepSetEmergAttribs"]=HealBot_Action_PrepSetEmergAttribs,
                        ["EnableHealBot"]=HealBot_Timer_EnableHealBot,
                        ["DisableHealBot"]=HealBot_Timer_DisableHealBot,
                        ["InitBuffList"]=HealBot_Options_InitBuffList,
                        ["OnLoad"]=HealBot_Timer_OnLoad,
                        ["ConfigClassHoT"]=HealBot_Aura_ConfigClassHoT,
                        ["InitBuffClassList"]=HealBot_Options_InitBuffClassList,
                        ["DebuffPriority"]=HealBot_Options_setDebuffPriority,
                        ["MMButtonInit"]=HealBot_MMButton_Init,
                        ["IgnoreDebuffsDuration"]=HealBot_Options_IgnoreDebuffsDuration_setAura,
                        ["MonitorBuffsToggle"]=HealBot_Options_MonitorBuffs_Toggle,
                        ["MonitorDebuffsToggle"]=HealBot_Options_MonitorDebuffs_Toggle,
                        ["SpellsLoaded"]=HealBot_Timer_SpellsLoaded,
                        ["SpellsResetTabs"]=HealBot_Timer_SpellsResetTabs,
                        ["HealthAlertLevel"]=HealBot_Timer_HealthAlertLevel_OC,
                        ["UpdateFast"]=HealBot_Update_FastTimer,
                        ["RefreshParty"]=HealBot_Timer_FramesRefresh,
                    },
                    ["RESET"]={
                        ["Full"]=HealBot_Reset_Full,
                        ["Quick"]=HealBot_Reset_Quick,
                        ["CustomDebuffs"]=HealBot_ResetCustomDebuffs,
                        ["Skins"]=HealBot_ResetSkins,
                    },
                    ["PARTY"]={
                        ["UpdateAllUnitBars"]=HealBot_UpdateAllUnitBars,
                    },
                    ["PLAYER"]={
                        ["PlayerTargetChanged"]=HealBot_OnEvent_PlayerTargetChanged,
                    },
                    ["WHEEL"]={
                        ["WheelUpdate"]=HealBot_Timer_MouseWheelUpdate,
                    },
                    ["SKINS"]={
                        ["PartyUpdateCheckSkin"]=HealBot_PartyUpdate_CheckSkin,
                        ["UpdateIconFreq"]=HealBot_Aura_SetUpdateIconFreq,
                        ["SkinsFormat"]=HealBot_Timer_SkinsFormat,
                        ["TextExtraCustomCols"]=HealBot_Text_setExtraCustomCols,
                        ["TextUpdateNames"]=HealBot_Text_UpdateNames,
                        ["TextUpdateHealth"]=HealBot_Text_UpdateHealth,
                        ["ClearSeparateInHealsAbsorbs"]=HealBot_Text_ClearSeparateInHealsAbsorbs,
                        ["ClearOverHeals"]=HealBot_Text_ClearOverHeals,
                        ["SkinColours"]=HealBot_SetSkinColours,
                        ["SkinBarTextColours"]=HealBot_Timer_SkinBarTextColours,
                        ["SetSkinBars"]=HealBot_Options_SetSkinBars,
                        ["TogglePartyFrames"]=HealBot_Timer_TogglePartyFrames,
                        ["ToggleMiniBossFrames"]=HealBot_Timer_ToggleMiniBossFrames,
                        ["ToggleRaidFrames"]=HealBot_Timer_ToggleRaidFrames,
                        ["FrameAliases"]=HealBot_Timer_FrameAliases,
                        ["FrameAliasesInitFrameSel"]=HealBot_Options_FrameAlias_initFrameSel,
                        ["RaidTargetUpdate"]=HealBot_Options_RaidTargetUpdate,
                        ["FluidFlashInUse"]=HealBot_Options_FluidFlashInUse,
                        ["SetFocusGroups"]=HealBot_Action_SetFocusGroups,
                    },
                    ["AUX"]={
                        ["ClearBars"]=HealBot_Options_clearAuxBars,
                        ["PrepBars"]=HealBot_Options_prepforAuxBars,
                        ["SetBars"]=HealBot_Options_setAuxBars,
                        ["BarFlashAlphaMinMax"]=HealBot_Options_AuxBarFlashAlphaMinMaxSet,
                    },
                    ["EMERG"]={
                        ["ResetBars"]=HealBot_Action_ResetEmergBars,
                        ["UpdateBars"]=HealBot_UpdateAllEmergBars,
                    },
                    ["AURA"]={
                        ["CheckUnits"]=HealBot_AuraCheck,
                        ["CheckPlayer"]=HealBot_Timer_CheckPlayerAura,
                        ["SetAuraWarningFlags"]=HealBot_Aura_SetAuraWarningFlags,
                        ["BuffResetList"]=HealBot_Options_BuffResetList,
                        ["ConfigClassHoT"]=HealBot_Aura_ConfigClassHoT,
                        ["ResetBuffCache"]=HealBot_Aura_ResetBuffCache,
                        ["CustomBuffFilterDisabled"]=HealBot_Aura_setCustomBuffFilterDisabled,
                        ["DeleteExcludeBuffInCache"]=HealBot_Aura_DeleteExcludeBuffInCache,
                        ["DebuffPriority"]=HealBot_Options_setDebuffPriority,
                        ["CustomDebuffFilterCastBy"]=HealBot_Aura_setCustomDebuffFilterCastBy,
                        ["ResetDebuffCache"]=HealBot_Aura_ResetDebuffCache,
                        ["CustomDebuffFilterDisabled"]=HealBot_Aura_setCustomDebuffFilterDisabled,
                    },
                    ["CHAT"]={
                        ["OverrideChatUseToggle"]=HealBot_Options_Override_ChatUse_Toggle,
                        ["SetChat"]=HealBot_Options_SetChat,
                    },
                    ["INITSLOW"]={
                        ["MountsPetsUse"]=HealBot_MountsPets_InitUse,
                        ["MountsPetsInit"]=HealBot_MountsPets_InitMount,
                        ["BuffBarColours"]=HealBot_SetBuffBarColours,
                        ["RegisterForClicks"]=HealBot_Action_setRegisterForClicks,
                        ["RegisterForClicks"]=HealBot_Action_setRegisterForClicks,
                        ["RegisterForClicks"]=HealBot_Action_setRegisterForClicks,
                        ["InitPlugins"]=HealBot_InitPlugins,
                        ["HealBotLoaded"]=HealBot_Timer_Loaded,
                        ["OptionsInit"]=HealBot_Options_idleInit,
                        ["UpdateSlow"]=HealBot_Update_Slow,
                        ["OptionsMainPanel"]=HealBot_Options_MainPanel,
                        ["OverrideEffectsUseToggle"]=HealBot_Options_Override_EffectsUse_Toggle,
                        ["SetTimers"]=HealBot_Set_Timers,
                        ["FramesSetPoint"]=HealBot_Timer_FramesSetPoint,
                        ["CheckFramesOnCombat"]=HealBot_CheckFramesOnCombat,
                        ["CheckHideFrames"]=HealBot_Action_CheckHideFrames,
                        ["InitAuraData"]=HealBot_Aura_InitData,
                        ["InitItemsDataReady"]=HealBot_Aura_InitItemsDataReady,
                        ["InitSmartCast"]=HealBot_InitSmartCast,
                        ["InitSpells"]=HealBot_InitSpells,
                    },
                    ["PARTYSLOW"]={
                        ["RefreshPartyNextRecalcAll"]=HealBot_Timer_nextRecalcAll,
                        ["RefreshPartyNextRecalcPlayers"]=HealBot_Timer_nextRecalcPlayers,
                        ["RefreshPartyNextRecalcPets"]=HealBot_Timer_nextRecalcPets,
                        ["ResetUnitStatus"]=HealBot_Timer_ResetUnitStatus,
                        ["ResetSkinAllButtons"]=HealBot_Action_ResetSkinAllButtons,
                        ["ResetAllButtons"]=HealBot_Action_ResetAllButtons,
                        ["LowManaTrig"]=HealBot_Action_setLowManaTrig,
                        ["CheckLowMana"]=HealBot_Timer_CheckLowMana,
                        ["UpdateAllHealth"]=HealBot_UpdateAllHealth,
                        ["ResetRange"]=HealBot_ResetRange,
                        ["EndAggro"]=HealBot_EndAggro,
                        ["AfterCombatCleanup"]=HealBot_AfterCombatCleanup,
                        ["TargetFocusUpdate"]=HealBot_Timer_TargetFocusUpdate,
                        ["RegAggro"]=HealBot_Action_Register_Aggro,
                    },
                    ["PLAYERSLOW"]={
                        ["PowerIndicator"]=HealBot_Timer_PowerIndicator,
                        ["PlayerCheckExtended"]=HealBot_PlayerCheckExtended,
                        ["CheckZone"]=HealBot_CheckZone,
                        ["ZoneUpdate"]=HealBot_Timer_ZoneUpdate,
                        ["InvChange"]=HealBot_Player_InvChange,
                        ["EmoteOOM"]=HealBot_Timer_EmoteOOM,
                        ["PlayerSpecUpdate"]=HealBot_Timer_PlayerSpecUpdate,
                        ["PartyUpdateCheckSolo"]=HealBot_PartyUpdate_CheckSolo,
                    },
                    ["SKINSSLOW"]={
                        ["RemoveUnusedDebuffIcons"]=HealBot_Aura_RemoveUnusedDebuffIcons,
                        ["RemoveUnusedBuffIcons"]=HealBot_Aura_RemoveUnusedBuffIcons,
                        ["UpdateAllIconsAlpha"]=HealBot_UpdateAllIconsAlpha,
                        ["RaidTargetUpdateAll"]=HealBot_OnEvent_RaidTargetUpdateAll,
                        ["FrameAliasTextChange"]=HealBot_Options_FrameAlias_AfterTextChange,
                        ["BarFreqVars"]=HealBot_Options_BarFreq_setVars,
                        ["OverrideFramesUseToggle"]=HealBot_Options_Override_FramesUse_Toggle,
                        ["ResetAll"]=HealBot_Skins_ResetAll,
                        ["StickyFrameIndCols"]=HealBot_Action_StickyFrameIndCols,
                        ["ModKey"]=HealBot_Action_ModKey,
                        ["UpdateAggroText"]=HealBot_Aggro_UpdateAggroText,
                        ["ResetClassIconTexture"]=HealBot_ResetClassIconTexture,
                        ["SeparateInHealsAbsorbs"]=HealBot_Text_setSeparateInHealsAbsorbs,
                        ["UpdateTextButtons"]=HealBot_Text_UpdateButtons,
                        ["setRaidTargetChecked"]=HealBot_setRaidTargetChecked,
                    },
                    ["LAST"]={
                        ["DeleteMarkedButtons"]=HealBot_Action_DeleteMarkedButtons,
                        ["RefreshPartyNextRecalcEnemy"]=HealBot_Timer_nextRecalcEnemy,
                        ["InitItemsData"]=HealBot_Aura_InitItemsData,
                        ["RefreshPartyNextRecalcAll"]=HealBot_Timer_nextRecalcAll,
                        ["SpellsLoaded"]=HealBot_Timer_SpellsLoaded,
                        ["LastLoad"]=HealBot_Timer_LastLoad,
                    },
                   }

function HealBot_Timers_Set(cat,timer)
    if not HealBot_Timers_NoDups[cat][timer] then
        HealBot_Timers_NoDups[cat][timer]=true
        table.insert(HealBot_Timers[cat],timer)
    end
    HealBot_setLuVars("HealBot_RunTimers", true)
end

local NoCallsInx=""
function HealBot_Timers_RunTimer(cat, timer)
    if hbTimerFuncs[cat][timer] then
        --NoCallsInx=cat..":"..timer
        --if not HealBot_Timers_NoCalls[NoCallsInx] then HealBot_Timers_NoCalls[NoCallsInx]=0 end
        --HealBot_Timers_NoCalls[NoCallsInx]=HealBot_Timers_NoCalls[NoCallsInx]+1
        --HealBot_AddDebug(NoCallsInx.."="..HealBot_Timers_NoCalls[NoCallsInx],"Timers",true)
        HealBot_Timers_NoDups[cat][timer]=false
        hbTimerFuncs[cat][timer]()
    else
        NoCallsInx=cat..":"..timer
        HealBot_AddDebug(HEALBOT_HEALBOT .. " " .. _G["ORANGE_FONT_COLOR_CODE"] .. "ERROR: Timer " .._G["FONT_COLOR_CODE_CLOSE"] .. _G["YELLOW_FONT_COLOR_CODE"] .. NoCallsInx  .._G["FONT_COLOR_CODE_CLOSE"].. _G["ORANGE_FONT_COLOR_CODE"] .." not found.")
        HealBot_AddDebug(HEALBOT_HEALBOT .. " " .. _G["ORANGE_FONT_COLOR_CODE"] .. "ERROR: Timer " .._G["FONT_COLOR_CODE_CLOSE"] .. _G["YELLOW_FONT_COLOR_CODE"] .. NoCallsInx  .._G["FONT_COLOR_CODE_CLOSE"].. _G["ORANGE_FONT_COLOR_CODE"] .." not found.","Timers",true)
    end
          --HealBot_setCall("HealBot_Timers_RunTimer-"..cat..":"..timer)
end

function HealBot_Timers_RunInitTimers()
    if #HealBot_Timers["INIT"]>0 then
        for x=1, #HealBot_Timers["INIT"] do
            HealBot_Timers_RunTimer("INIT", HealBot_Timers["INIT"][1])
            table.remove(HealBot_Timers["INIT"],1)
        end
    end
end

function HealBot_Timers_RunDelayedTimer(cat, timer, delay)
    C_Timer.After(delay, function() HealBot_Timers_RunTimer(cat, timer) end)
end

local hbCurTimer=""
function HealBot_Timers_Run()
    if HealBot_Timers["INIT"][1] then
        HealBot_Timers_RunTimer("INIT", HealBot_Timers["INIT"][1])
        table.remove(HealBot_Timers["INIT"],1)
    elseif HealBot_Timers["RESET"][1] then
        HealBot_Timers_RunTimer("RESET", HealBot_Timers["RESET"][1])
        table.remove(HealBot_Timers["RESET"],1)
    elseif HealBot_Timers["PARTY"][1] then
        HealBot_Timers_RunTimer("PARTY", HealBot_Timers["PARTY"][1])
        table.remove(HealBot_Timers["PARTY"],1)
    elseif HealBot_Timers["PLAYER"][1] then
        HealBot_Timers_RunTimer("PLAYER", HealBot_Timers["PLAYER"][1])
        table.remove(HealBot_Timers["PLAYER"],1)
    elseif HealBot_Timers["WHEEL"][1] then
        HealBot_Timers_RunDelayedTimer("WHEEL", HealBot_Timers["WHEEL"][1],0.5)
        table.remove(HealBot_Timers["WHEEL"],1)
    elseif HealBot_Timers["SKINS"][1] then
        HealBot_Timers_RunTimer("SKINS", HealBot_Timers["SKINS"][1])
        table.remove(HealBot_Timers["SKINS"],1)
    elseif HealBot_Timers["AUX"][1] then
        HealBot_Timers_RunTimer("AUX", HealBot_Timers["AUX"][1])
        table.remove(HealBot_Timers["AUX"],1)
    elseif HealBot_Timers["EMERG"][1] then
        HealBot_Timers_RunTimer("EMERG", HealBot_Timers["EMERG"][1])
        table.remove(HealBot_Timers["EMERG"],1)
    elseif HealBot_Timers["AURA"][1] then
        HealBot_Timers_RunTimer("AURA", HealBot_Timers["AURA"][1])
        table.remove(HealBot_Timers["AURA"],1)
    elseif HealBot_Timers["CHAT"][1] then
        HealBot_Timers_RunTimer("CHAT", HealBot_Timers["CHAT"][1])
        table.remove(HealBot_Timers["CHAT"],1)
    elseif HealBot_Timers["INITSLOW"][1] then
        HealBot_Timers_RunDelayedTimer("INITSLOW", HealBot_Timers["INITSLOW"][1],0.025)
        table.remove(HealBot_Timers["INITSLOW"],1)
    elseif HealBot_Timers["PARTYSLOW"][1] then
        HealBot_Timers_RunDelayedTimer("PARTYSLOW", HealBot_Timers["PARTYSLOW"][1],0.05)
        table.remove(HealBot_Timers["PARTYSLOW"],1)
    elseif HealBot_Timers["PLAYERSLOW"][1] then
        HealBot_Timers_RunDelayedTimer("PLAYERSLOW", HealBot_Timers["PLAYERSLOW"][1],0.075)
        table.remove(HealBot_Timers["PLAYERSLOW"],1)
    elseif HealBot_Timers["SKINSSLOW"][1] then
        HealBot_Timers_RunDelayedTimer("SKINSSLOW", HealBot_Timers["SKINSSLOW"][1],0.1)
        table.remove(HealBot_Timers["SKINSSLOW"],1)
    elseif HealBot_Timers["LAST"][1] then
        HealBot_Timers_RunDelayedTimer("LAST", HealBot_Timers["LAST"][1], 0.25)
        table.remove(HealBot_Timers["LAST"],1)
    else
        HealBot_setLuVars("HealBot_RunTimers", false)
    end
end
