local HealBot_Timers_Init={}
local HealBot_Timers={
                      ["INIT"]={},
                      ["RESET"]={},
                      ["PLAYER"]={},
                      ["DELAYED"]={},
                      ["SKINS"]={},
                      ["AUX"]={},
                      ["EMERG"]={},
                      ["AURA"]={},
                      ["CHAT"]={},
                      ["RUNDELAYED"]={},
                      ["INITSLOW"]={},
                      ["PARTYSLOW"]={},
                      ["PLAYERSLOW"]={},
                      ["SKINSSLOW"]={},
                      ["LAST"]={},
                     }
local HealBot_Timers_NoDups={
                      ["INIT"]={},
                      ["RESET"]={},
                      ["PLAYER"]={},
                      ["DELAYED"]={},
                      ["SKINS"]={},
                      ["AUX"]={},
                      ["EMERG"]={},
                      ["AURA"]={},
                      ["CHAT"]={},
                      ["RUNDELAYED"]={},
                      ["INITSLOW"]={},
                      ["PARTYSLOW"]={},
                      ["PLAYERSLOW"]={},
                      ["SKINSSLOW"]={},
                      ["LAST"]={},
                     }
local HealBot_Timers_LastRun={
                      ["INIT"]={},
                      ["RESET"]={},
                      ["PLAYER"]={},
                      ["DELAYED"]={},
                      ["SKINS"]={},
                      ["AUX"]={},
                      ["EMERG"]={},
                      ["AURA"]={},
                      ["CHAT"]={},
                      ["RUNDELAYED"]={},
                      ["INITSLOW"]={},
                      ["PARTYSLOW"]={},
                      ["PLAYERSLOW"]={},
                      ["SKINSSLOW"]={},
                      ["LAST"]={},
                     }
local HealBot_Timers_NoCalls={}
local HealBot_Timers_luVars={}
HealBot_Timers_luVars["UpdateAllBuffIcons"]=false
HealBot_Timers_luVars["LastDelayedTime"]=0
HealBot_Timers_luVars["LastLastTime"]=0
HealBot_Timers_luVars["DoneBuffReset"]=false
HealBot_Timers_luVars["nCalls"]=0

function HealBot_Timers_setLuVars(vName, vValue)
    HealBot_Timers_luVars[vName]=vValue
      --HealBot_setCall("HealBot_Action_setLuVars - "..vName)
end

function HealBot_Timers_retLuVars(vName)
    --HealBot_setCall("HealBot_Action_retLuVars")
    return HealBot_Timers_luVars[vName]
end

function HealBot_Timers_SkinsFormat()
    HealBot_Text_sethbNumberFormat()
    HealBot_Text_sethbAggroNumberFormat()
    HealBot_Timers_Set("PARTYSLOW","ResetUnitStatus")
    HealBot_Aura_SetIconUpdateInterval()
    HealBot_Timers_Set("PARTYSLOW","RefreshPartyNextRecalcAll")
end

function HealBot_Timers_FluidFlashUpdate()
    HealBot_Options_BarFreq_setVars()
    HealBot_Timers_Set("SKINS","FluidFlashInUse")
    HealBot_Timers_Set("SKINS","SetFocusGroups")
    HealBot_Options_AuxBarFlashAlphaMinMaxSet()
end

function HealBot_Timers_nextRecalcAll()
    HealBot_nextRecalcParty(0)
    if HealBot_Timers_luVars["UpdateAllBuffIcons"] then
        HealBot_Timers_luVars["UpdateAllBuffIcons"]=false
        HealBot_Timers_Set("SKINSSLOW","UpdateAllBuffIcons")
    end
end

function HealBot_Timers_nextRecalcPlayers()
    HealBot_nextRecalcParty(6)
end

function HealBot_Timers_nextRecalcVehicle()
    HealBot_nextRecalcParty(1)
end

function HealBot_Timers_nextRecalcPets()
    HealBot_nextRecalcParty(2)
end

function HealBot_Timers_nextRecalcEnemy()
    HealBot_nextRecalcParty(5)
end

function HealBot_Timers_MouseWheelUpdate()
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
        HealBot_Timers_Set("DELAYED","WheelUpdate")
    end
end

function HealBot_Timers_HealthAlertLevel_OC()
    HealBot_HealthAlertLevel(false)
end

function HealBot_Timers_SkinBarTextColours()
    HealBot_Options_SetBarsTextColour()
    HealBot_Panel_resetTestCols(true)
    HealBot_Timers_Set("PARTYSLOW","ResetUnitStatus")
    HealBot_Timers_Set("SKINSSLOW","UpdateTextButtons")
end

function HealBot_Timers_CheckPlayerAura()
    local _,xButton,pButton = HealBot_UnitID("player")
    if xButton then HealBot_Check_UnitAura(xButton) end
    if pButton then HealBot_Check_UnitAura(pButton) end
end

function HealBot_Timers_CheckTalentInfo()
    local _,xButton,pButton = HealBot_UnitID("player")
    if xButton then HealBot_GetTalentInfo(xButton) end
    if pButton then HealBot_GetTalentInfo(pButton) end
end

function HealBot_Timers_PowerIndicator()
    local _,xButton,pButton = HealBot_UnitID("player")
    if xButton then
        HealBot_Action_setpcClass(xButton)
        xButton.mana.power=-1
        HealBot_Action_setPowerIndicators(xButton)
    end
    if pButton then
        HealBot_Action_setpcClass(pButton)
        pButton.mana.power=-1
        HealBot_Action_setPowerIndicators(pButton)
    end
end

function HealBot_Timers_TipPowerCol()
    local _,xButton,pButton = HealBot_UnitID("player")
    if xButton then
        HealBot_Tooltip_setPlayerPowerCols(xButton.mana.r,xButton.mana.g,xButton.mana.b)
    elseif pButton then
        HealBot_Tooltip_setPlayerPowerCols(pButton.mana.r,pButton.mana.g,pButton.mana.b)
    end
end

function HealBot_Timers_FrameAliases()
    for fNo=1,10 do
        HealBot_Action_SetAlias(fNo)
        HealBot_Action_SetAliasFontSize(fNo)
    end
end

function HealBot_Timers_CheckLowMana()
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

function HealBot_Timers_FramesSetPoint()
    for x=1,10 do
        if HealBot_Action_FrameIsVisible(x) then
            HealBot_Action_setPoint(x)
        end
    end
end

function HealBot_Timers_TargetFocusUpdate()
    HealBot_PlayerTargetChanged()
    if HEALBOT_GAME_VERSION>1 then
        HealBot_FocusChanged()
    end
    HealBot_nextRecalcParty(2)
    HealBot_nextRecalcParty(1)
end

function HealBot_Timers_PlayerSpecUpdate()
    if HEALBOT_GAME_VERSION>3 then
        HealBot_ResetOnSpecChange(HealBot_Config.CurrentSpec)
    else
        HealBot_ResetOnSpecChange()
    end
end

function HealBot_Timers_EnableHealBot()
    HealBot_Register_Events()
    HealBot_Timers_Set("PARTYSLOW","RefreshPartyNextRecalcAll")
end

function HealBot_Timers_DisableHealBot()
    HealBot_Config.DisabledNow=1
    HealBot_Timers_Set("PARTYSLOW","RefreshPartyNextRecalcAll")
    HealBot_UnRegister_Events()
    HealBot_Register_Events()
    for j=1,10 do
        HealBot_Action_HidePanel(j)
    end
end

function HealBot_Timers_SpellsLoaded()
    HealBot_Timers_Set("INIT","InitBuffList")
    HealBot_Timers_Set("INIT","SpellsTabText")
    HealBot_Timers_Set("INIT","FluidFlash")
    HealBot_Timers_Set("AURA","BuffsReset")
    HealBot_Timers_Set("PARTYSLOW","ResetAllButtons")
    HealBot_Timers_Set("PARTYSLOW","RefreshPartyNextRecalcAll")
    HealBot_Timers_Set("DELAYED","InitAuraData")
end

function HealBot_Timers_SpellsResetTabs()
    HealBot_Options_ResetDoInittab(50)
    HealBot_Options_ResetDoInittab(40)
    HealBot_Options_ResetDoInittab(10)
    HealBot_Options_ResetDoInittab(5)
    HealBot_Options_ResetDoInittab(4)
    HealBot_Options_setDebuffTypes()
end

function HealBot_Timers_BuffsReset()
    HealBot_Timers_luVars["DoneBuffReset"]=true
    HealBot_Timers_Set("INIT","BuffReset")
    HealBot_Timers_Set("INIT","DebuffReset")
end

function HealBot_Timers_LoadComplete()
    HealBot_Timers_luVars["LoadComplete"]=true
end

function HealBot_Timers_LastUpdate()
    HealBot_Timers_Set("LAST","UpdateAllHealth")
    HealBot_Timers_Set("LAST","PlayerCheckExtended")
    HealBot_Timers_Set("LAST","BuffsReset")
    HealBot_Timers_Set("DELAYED","AuraCheckUnits")
	HealBot_Timers_Set("DELAYED","UpdateAllUnitBars")
    HealBot_Timers_Set("DELAYED","ProcCacheButtons")
    HealBot_Timers_Set("DELAYED","LoadComplete")
end

function HealBot_Timers_Lang()
    if HealBot_Globals.localLang then
        HealBot_Options_Lang(HealBot_Globals.localLang, false)
    else
        HealBot_Options_Lang(GetLocale(), false)
    end
end

function HealBot_Timers_LastLoad()
    HealBot_Timers_Set("SKINS","EmergHealthCol")
    HealBot_Timers_Set("AURA","ConfigClassHoT")
    HealBot_Timers_Set("LAST","InitSpells")
    HealBot_Timers_Set("LAST","SpellsLoaded")
    HealBot_Timers_Set("DELAYED","CheckZone")
    HealBot_Timers_Set("DELAYED","InvChange")
    HealBot_Timers_Set("DELAYED","PowerIndicator")
    HealBot_Timers_Set("DELAYED","LastUpdate")
end

function HealBot_Timers_EnteringWorld2()
    HealBot_Timers_Set("LAST","RefreshPartyNextRecalcAll")
    HealBot_Timers_Set("LAST","CheckDC")
    HealBot_Timers_Set("DELAYED","LastUpdate")
end

function HealBot_Timers_EnteringWorld()
    HealBot_Timers_Set("PARTYSLOW","TargetFocusUpdate")
    HealBot_Timers_Set("SKINS","PartyUpdateCheckSkin")
    HealBot_Timers_Set("PARTYSLOW","ResetUnitStatus")
    HealBot_Timers_Set("LAST","UpdateEmergBars")
    HealBot_Timers_Set("DELAYED","EnteringWorld2")
end

function HealBot_Timers_CheckDC()
    for _,xButton in pairs(HealBot_Unit_Button) do
        if xButton.status.current==HealBot_Unit_Status["DC"] then
            HealBot_CheckUnitStatus(xButton)
        end
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        if xButton.status.current==HealBot_Unit_Status["DC"] then
            HealBot_CheckUnitStatus(xButton)
        end
    end
        --HealBot_setCall("HealBot_Timers_CheckDC")
end

function HealBot_Timers_QuickFramesChanged()
    HealBot_Options_framesChanged(false)
end

function HealBot_Timers_SkinsFramesChanged()
    HealBot_Options_framesChanged(true)
end

function HealBot_Timers_IconsFramesChanged()
    HealBot_Options_framesChanged(false, true)
end

function HealBot_Timers_IndicatorFramesChanged()
    HealBot_Options_framesChanged(false, false, true)
end

function HealBot_Timers_AllFramesChanged()
    HealBot_Options_framesChanged(true, true, true)
end

function HealBot_Timers_Loaded()
    HealBot_AddChat(HEALBOT_HEALBOT .. " " .. _G["GREEN_FONT_COLOR_CODE"]..HEALBOT_VERSION.._G["FONT_COLOR_CODE_CLOSE"] .. HEALBOT_LOADED .. " " .. HEALBOT_FORHELP .. _G["YELLOW_FONT_COLOR_CODE"].." /hb h".._G["FONT_COLOR_CODE_CLOSE"]);
end

local hbTimerFuncs={["INIT"]={
                        ["InitSpells"]=HealBot_InitSpells,
                        ["SpellsTabText"]=HealBot_Options_ComboClass_Text,
                        ["FluidFlash"]=HealBot_Timers_FluidFlashUpdate,
                        ["CheckFrameSetPoint"]=HealBot_Action_CheckFrameSetPoint,
                        ["CheckTalentInfo"]=HealBot_Timers_CheckTalentInfo,
                        ["SetEnabledAttribs"]=HealBot_Action_SetEnabledAttribs,
                        ["SetEnemyAttribs"]=HealBot_Action_SetEnemyAttribs,
                        ["SetEmergAttribs"]=HealBot_Action_SetEmergAttribs,
                        ["PrepSetAllAttribs"]=HealBot_Action_PrepSetAllAttribs,
                        ["PrepSetEnabledAttribs"]=HealBot_Action_PrepSetEnabledAttribs,
                        ["PrepSetEnemyAttribs"]=HealBot_Action_PrepSetEnemyAttribs,
                        ["PrepSetEmergAttribs"]=HealBot_Action_PrepSetEmergAttribs,
                        ["EnableHealBot"]=HealBot_Timers_EnableHealBot,
                        ["DisableHealBot"]=HealBot_Timers_DisableHealBot,
                        ["InitBuffList"]=HealBot_Options_InitBuffList,
                        ["SpellsLoaded"]=HealBot_Timers_SpellsLoaded,
                        ["SpellsResetTabs"]=HealBot_Timers_SpellsResetTabs,
                        ["HealthAlertLevel"]=HealBot_Timers_HealthAlertLevel_OC,
                        ["RefreshParty"]=HealBot_Timer_FramesRefresh,
                        ["BuffReset"]=HealBot_Options_Buff_Reset,
                        ["DebuffReset"]=HealBot_Options_Debuff_Reset,
                        ["InitAuraData"]=HealBot_Aura_InitData,
                        ["ConfigClassHoT"]=HealBot_Aura_ConfigClassHoT,
                        ["SeparateInHealsAbsorbs"]=HealBot_Text_setSeparateInHealsAbsorbs,
                        ["WheelUpdate"]=HealBot_Timers_MouseWheelUpdate,
                        ["RegEvents"]=HealBot_Register_Events,
                        ["ResetSkinAllButtons"]=HealBot_Action_ResetSkinAllButtons,
                        ["RefreshPartyNextRecalcAll"]=HealBot_Timers_nextRecalcAll,
                        ["InitPlugins"]=HealBot_InitPlugins,
                    },
                    ["RESET"]={
                        ["Full"]=HealBot_Reset_Full,
                        ["Quick"]=HealBot_Reset_Quick,
                        ["CustomDebuffs"]=HealBot_ResetCustomDebuffs,
                        ["Skins"]=HealBot_ResetSkins,
                    },
                    ["PLAYER"]={
                        ["PlayerTargetChanged"]=HealBot_OnEvent_PlayerTargetChanged,
                    },
                    ["SKINS"]={
                        ["PartyUpdateCheckSkin"]=HealBot_PartyUpdate_CheckSkin,
                        ["UpdateIconFreq"]=HealBot_Aura_SetUpdateIconFreq,
                        ["SkinsFormat"]=HealBot_Timers_SkinsFormat,
                        ["TextExtraCustomCols"]=HealBot_Text_setExtraCustomCols,
                        ["TextUpdateNames"]=HealBot_Text_UpdateNames,
                        ["TextUpdateHealth"]=HealBot_Text_UpdateHealth,
                        ["TextUpdateState"]=HealBot_Text_UpdateState,
                        ["TextResetState"]=HealBot_Text_ResetState,
                        ["TextClearState"]=HealBot_Text_ClearState,
                        ["ClearSeparateInHealsAbsorbs"]=HealBot_Text_ClearSeparateInHealsAbsorbs,
                        ["ClearOverHeals"]=HealBot_Text_ClearOverHeals,
                        ["SkinColours"]=HealBot_SetSkinColours,
                        ["SkinBarTextColours"]=HealBot_Timers_SkinBarTextColours,
                        ["SetSkinBars"]=HealBot_Options_SetSkinBars,
                        ["TogglePartyFrames"]=HealBot_Timer_TogglePartyFrames,
                        ["ToggleMiniBossFrames"]=HealBot_Timer_ToggleMiniBossFrames,
                        ["ToggleRaidFrames"]=HealBot_Timer_ToggleRaidFrames,
                        ["FrameAliases"]=HealBot_Timers_FrameAliases,
                        ["FrameAliasesInitFrameSel"]=HealBot_Options_FrameAlias_initFrameSel,
                        ["RaidTargetUpdate"]=HealBot_Options_RaidTargetUpdate,
                        ["FluidFlashInUse"]=HealBot_Options_FluidFlashInUse,
                        ["SetFocusGroups"]=HealBot_Action_SetFocusGroups,
                        ["SwitchStateFontString"]=HealBot_Text_SwitchStateFontString,
                        ["EmergHealthCol"]=HealBot_Action_EmergHealthCol,
                    },
                    ["AUX"]={
                        ["ClearBars"]=HealBot_Options_clearAuxBars,
                        ["SetBars"]=HealBot_Options_setAuxBars,
                        ["BarFlashAlphaMinMax"]=HealBot_Options_AuxBarFlashAlphaMinMaxSet,
                        ["UpdateAllUnitBars"]=HealBot_UpdateAllAuxBars,
                        ["ResetBars"]=HealBot_Aux_resetBars,
                    },
                    ["EMERG"]={
                        ["ResetBars"]=HealBot_Action_ResetEmergBars,
                        ["UpdateBars"]=HealBot_UpdateAllEmergBars,
                    },
                    ["AURA"]={
                        ["CheckUnits"]=HealBot_AuraCheck,
                        ["CheckPlayer"]=HealBot_Timers_CheckPlayerAura,
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
                        ["SetIconUpdateInterval"]=HealBot_Aura_SetIconUpdateInterval,
                        ["BuffsReset"]=HealBot_Timers_BuffsReset,
                    },
                    ["CHAT"]={
                        ["OverrideChatUseToggle"]=HealBot_Options_Override_ChatUse_Toggle,
                        ["SetChat"]=HealBot_Options_SetChat,
                    },
                    ["RUNDELAYED"]={
                        ["BuffReset"]=HealBot_Options_Buff_Reset,
                        ["DebuffReset"]=HealBot_Options_Debuff_Reset,
                        ["MountsPetsUse"]=HealBot_MountsPets_InitUse,
                        ["MountsPetsInit"]=HealBot_MountsPets_InitMount,
                        ["BuffBarColours"]=HealBot_SetBuffBarColours,
                        ["RegisterForClicks"]=HealBot_Action_setRegisterForClicks,
                        ["HealBotLoaded"]=HealBot_Timers_Loaded,
                        ["OptionsInit"]=HealBot_Options_idleInit,
                        ["OptionsMainPanel"]=HealBot_Options_MainPanel,
                        ["OverrideEffectsUseToggle"]=HealBot_Options_Override_EffectsUse_Toggle,
                        ["FramesSetPoint"]=HealBot_Timers_FramesSetPoint,
                        ["CheckFramesOnCombat"]=HealBot_CheckFramesOnCombat,
                        ["CheckHideFrames"]=HealBot_Action_CheckHideFrames,
                        ["InitItemsDataReady"]=HealBot_Aura_InitItemsDataReady,
                        ["InitSmartCast"]=HealBot_InitSmartCast,
                        ["InitSpells"]=HealBot_InitSpells,
                        ["RefreshPartyNextRecalcAll"]=HealBot_Timers_nextRecalcAll,
                        ["RefreshPartyNextRecalcPlayers"]=HealBot_Timers_nextRecalcPlayers,
                        ["RefreshPartyNextRecalcPets"]=HealBot_Timers_nextRecalcPets,
                        ["RefreshPartyNextRecalcVehicle"]=HealBot_Timers_nextRecalcVehicle,
                        ["ResetUnitStatus"]=HealBot_Action_ResetUnitStatus,
                        ["ResetUnitOpacity"]=HealBot_Action_ResetUnitOpacity,
                        ["ResetAllButtons"]=HealBot_Action_ResetAllButtons,
                        ["LowManaTrig"]=HealBot_Action_setLowManaTrig,
                        ["CheckLowMana"]=HealBot_Timers_CheckLowMana,
                        ["AuxResetRange"]=HealBot_AuxResetRange,
                        ["EndAggro"]=HealBot_EndAggro,
                        ["AfterCombatCleanup"]=HealBot_AfterCombatCleanup,
                        ["TargetFocusUpdate"]=HealBot_Timers_TargetFocusUpdate,
                        ["RegAggro"]=HealBot_Action_Register_Aggro,
                        ["PlayerCheckExtended"]=HealBot_PlayerCheckExtended,
                        ["CheckZone"]=HealBot_CheckZone,
                        ["ZoneUpdate"]=HealBot_Timer_ZoneUpdate,
                        ["InvChange"]=HealBot_Player_InvChange,
                        ["EmoteOOM"]=HealBot_Timer_EmoteOOM,
                        ["PlayerSpecUpdate"]=HealBot_Timers_PlayerSpecUpdate,
                        ["PartyUpdateCheckSolo"]=HealBot_PartyUpdate_CheckSolo,
                        ["TipPowerCol"]=HealBot_Timers_TipPowerCol,
                        ["RemoveUnusedDebuffIcons"]=HealBot_Aura_RemoveUnusedDebuffIcons,
                        ["RemoveUnusedBuffIcons"]=HealBot_Aura_RemoveUnusedBuffIcons,
                        ["UpdateAllIconsAlpha"]=HealBot_UpdateAllIconsAlpha,
                        ["RaidTargetUpdateAll"]=HealBot_OnEvent_RaidTargetUpdateAll,
                        ["FrameAliasTextChange"]=HealBot_Options_FrameAlias_AfterTextChange,
                        ["BarFreqVars"]=HealBot_Options_BarFreq_setVars,
                        ["OverrideFramesUseToggle"]=HealBot_Options_Override_FramesUse_Toggle,
                        ["ModKey"]=HealBot_Action_ModKey,
                        ["UpdateAggroText"]=HealBot_Aggro_UpdateAggroText,
                        ["ResetClassIconTexture"]=HealBot_ResetClassIconTexture,
                        ["SeparateInHealsAbsorbs"]=HealBot_Text_setSeparateInHealsAbsorbs,
                        ["UpdateTextButtons"]=HealBot_Text_UpdateButtons,
                        ["setRaidTargetChecked"]=HealBot_setRaidTargetChecked,
                        ["UpdateAllBuffIcons"]=HealBot_Aura_Update_UnitAllBuffIcons,
                        ["UpdateAllDebuffIcons"]=HealBot_Aura_Update_UnitAllDebuffIcons,
                        ["RefreshPartyNextRecalcEnemy"]=HealBot_Timers_nextRecalcEnemy,
                        ["InitItemsData"]=HealBot_Aura_InitItemsData,
                        ["ReadyPlayerCheck"]=HealBot_ReadyPlayerCheck,
                        ["UpdateEmergBars"]=HealBot_UpdateAllEmergBars,
                        ["TextResetState"]=HealBot_Text_ResetState,
                        ["TextUpdateNames"]=HealBot_Text_UpdateNames,
                        ["TextUpdateHealth"]=HealBot_Text_UpdateHealth,
                        ["CheckDC"]=HealBot_Timers_CheckDC,
                        ["ProcCacheButtons"]=HealBot_Action_ProcCacheButtons,
                        ["LastLoad"]=HealBot_Timers_LastLoad,
                        ["LastUpdate"]=HealBot_Timers_LastUpdate,
                        ["WheelUpdate"]=HealBot_Timers_MouseWheelUpdate,
                        ["PowerIndicator"]=HealBot_Timers_PowerIndicator,
                        ["SpellsLoaded"]=HealBot_Timers_SpellsLoaded,
                        ["EnteringWorld"]=HealBot_Timers_EnteringWorld,
                        ["EnteringWorld2"]=HealBot_Timers_EnteringWorld2,
                        ["UpdateAllHealth"]=HealBot_UpdateAllHealth,
                        ["InitAuraData"]=HealBot_Aura_InitData,
                        ["BuffsReset"]=HealBot_Timers_BuffsReset,
                        ["AuraCheckUnits"]=HealBot_AuraCheck,
                        ["UpdateAllUnitBars"]=HealBot_UpdateAllUnitBars,
                        ["Reload"]=HealBot_Reload,
                        ["FullReload"]=HealBot_FullReload,
                        ["ReadyCheck"]=HealBot_ReadyCheck,
                        ["LoadComplete"]=HealBot_Timers_LoadComplete,
                        ["QuickFramesChanged"]=HealBot_Timers_QuickFramesChanged,
                        ["SkinsFramesChanged"]=HealBot_Timers_SkinsFramesChanged,
                        ["IconsFramesChanged"]=HealBot_Timers_IconsFramesChanged,
                        ["IndicatorFramesChanged"]=HealBot_Timers_IndicatorFramesChanged,
                        ["AllFramesChanged"]=HealBot_Timers_AllFramesChanged,
                        ["UpdateMaxUnitsAdj"]=HealBot_UpdateMaxUnitsAdj,
                        ["SetLang"]=HealBot_Timers_Lang,
                    },
                   }

local LastRunDiff=0
function HealBot_Timers_DoSet(cat,timer)
    HealBot_Timers_LastRun[cat][timer]=GetTime()
    table.insert(HealBot_Timers[cat],timer)
    HealBot_setLuVars("HealBot_RunTimers", true)
end

function HealBot_Timers_DelayedSet(cat,timer,delay)
    C_Timer.After(delay, function() HealBot_Timers_DoSet(cat,timer) end)
    --HealBot_AddDebug("Freq Timer cat="..cat.." timer="..timer.." delay="..delay,"Timers",true)
end

function HealBot_Timers_Set(cat,timer)
    if not HealBot_Timers_NoDups[cat][timer] then
        HealBot_Timers_NoDups[cat][timer]=true
        if HealBot_Timers_LastRun[cat][timer] then
            LastRunDiff=HealBot_Timers_LastRun[cat][timer]-(GetTime()-0.5)
        else
            LastRunDiff=0
        end
        if LastRunDiff>0 then
            HealBot_Timers_DelayedSet(cat,timer,LastRunDiff)
        else
            HealBot_Timers_DoSet(cat,timer)
        end
    end
end

local NoCallsInx=""
function HealBot_Timers_Usage(cat, timer)
    NoCallsInx=cat..":"..timer
    if not HealBot_Timers_NoCalls[NoCallsInx] then HealBot_Timers_NoCalls[NoCallsInx]=0 end
    HealBot_Timers_NoCalls[NoCallsInx]=HealBot_Timers_NoCalls[NoCallsInx]+1
    HealBot_AddDebug(NoCallsInx.."="..HealBot_Timers_NoCalls[NoCallsInx],"Timers",true)
end

function HealBot_Timers_RunTimer(cat, timer)
    if hbTimerFuncs[cat][timer] then
        HealBot_Timers_NoDups[cat][timer]=false
        hbTimerFuncs[cat][timer]()
    else
        NoCallsInx=cat..":"..timer
        HealBot_AddDebug(HEALBOT_HEALBOT .. " " .. _G["ORANGE_FONT_COLOR_CODE"] .. "ERROR: Timer " .._G["FONT_COLOR_CODE_CLOSE"] .. _G["YELLOW_FONT_COLOR_CODE"] .. NoCallsInx  .._G["FONT_COLOR_CODE_CLOSE"].. _G["ORANGE_FONT_COLOR_CODE"] .." not found.")
        HealBot_AddDebug(HEALBOT_HEALBOT .. " " .. _G["ORANGE_FONT_COLOR_CODE"] .. "ERROR: Timer " .._G["FONT_COLOR_CODE_CLOSE"] .. _G["YELLOW_FONT_COLOR_CODE"] .. NoCallsInx  .._G["FONT_COLOR_CODE_CLOSE"].. _G["ORANGE_FONT_COLOR_CODE"] .." not found.","Timers",true)
    end
    --HealBot_Timers_Usage(cat, timer)
          --HealBot_setCall("HealBot_Timers_RunTimer-"..cat..":"..timer)
end

function HealBot_Timers_SetDelayedTimer(cat, timer)
    HealBot_Timers_Set("RUNDELAYED",timer)
    HealBot_Timers_NoDups[cat][timer]=false
end

function HealBot_Timers_RunDelayedTimer(cat, timer, delay)
    C_Timer.After(delay, function() HealBot_Timers_SetDelayedTimer(cat,timer) end)
end

function HealBot_Timers_ClearTimers()
    if #HealBot_Timers["INIT"]>0 then
        for x=1, #HealBot_Timers["INIT"] do
            HealBot_Timers_RunTimer("INIT", HealBot_Timers["INIT"][1])
            table.remove(HealBot_Timers["INIT"],1)
        end
    end
    if #HealBot_Timers["SKINS"]>0 then
        for x=1, #HealBot_Timers["SKINS"] do
            HealBot_Timers_RunTimer("SKINS", HealBot_Timers["SKINS"][1])
            table.remove(HealBot_Timers["SKINS"],1)
        end
    end
    if #HealBot_Timers["AUX"]>0 then
        for x=1, #HealBot_Timers["AUX"] do
            HealBot_Timers_RunTimer("AUX", HealBot_Timers["AUX"][1])
            table.remove(HealBot_Timers["AUX"],1)
        end
    end
    if #HealBot_Timers["EMERG"]>0 then
        for x=1, #HealBot_Timers["EMERG"] do
            HealBot_Timers_RunTimer("EMERG", HealBot_Timers["EMERG"][1])
            table.remove(HealBot_Timers["EMERG"],1)
        end
    end
    if #HealBot_Timers["AURA"]>0 then
        for x=1, #HealBot_Timers["AURA"] do
            HealBot_Timers_RunTimer("AURA", HealBot_Timers["AURA"][1])
            table.remove(HealBot_Timers["AURA"],1)
        end
    end

end

function HealBot_Timers_PlayerRegenDisabled()
    if not HealBot_Timers_luVars["DoneBuffReset"] then
        if not HealBot_retLuVars("Loaded") then
            HealBot_OnEvent_VariablesLoaded()
            HealBot_Timers_Set("DELAYED","FullReload")
        end
        HealBot_Timers_Set("INIT","InitBuffList")
        HealBot_Timers_Set("INIT","SpellsTabText")
        HealBot_Timers_Set("INIT","FluidFlash")
        HealBot_Timers_BuffsReset()
        for x=1,3 do
            HealBot_Timers_ClearTimers()
        end
    else
        for x=1,2 do
            HealBot_Timers_ClearTimers()
        end
        if not HealBot_Timers_luVars["LoadComplete"] then HealBot_Timers_Set("DELAYED","Reload") end
    end
end

local hbCurTimer=""
function HealBot_Timers_Run()
    --HealBot_Timers_luVars["nCalls"]=HealBot_Timers_luVars["nCalls"]+1
    if HealBot_Timers["INIT"][1] then
        HealBot_Timers_RunTimer("INIT", HealBot_Timers["INIT"][1])
        table.remove(HealBot_Timers["INIT"],1)
    elseif HealBot_Timers["RESET"][1] then
        HealBot_Timers_RunTimer("RESET", HealBot_Timers["RESET"][1])
        table.remove(HealBot_Timers["RESET"],1)
    elseif HealBot_Timers["PLAYER"][1] then
        HealBot_Timers_RunTimer("PLAYER", HealBot_Timers["PLAYER"][1])
        table.remove(HealBot_Timers["PLAYER"],1)
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
    elseif HealBot_Timers["RUNDELAYED"][1] then
        HealBot_Timers_RunTimer("RUNDELAYED", HealBot_Timers["RUNDELAYED"][1])
        table.remove(HealBot_Timers["RUNDELAYED"],1)
    elseif HealBot_Timers["INITSLOW"][1] then
        HealBot_Timers_SetDelayedTimer("INITSLOW", HealBot_Timers["INITSLOW"][1])
        table.remove(HealBot_Timers["INITSLOW"],1)
    elseif HealBot_Timers["PARTYSLOW"][1] then
        HealBot_Timers_SetDelayedTimer("PARTYSLOW", HealBot_Timers["PARTYSLOW"][1])
        table.remove(HealBot_Timers["PARTYSLOW"],1)
    elseif HealBot_Timers["PLAYERSLOW"][1] then
        HealBot_Timers_SetDelayedTimer("PLAYERSLOW", HealBot_Timers["PLAYERSLOW"][1])
        table.remove(HealBot_Timers["PLAYERSLOW"],1)
    elseif HealBot_Timers["SKINSSLOW"][1] then
        HealBot_Timers_SetDelayedTimer("SKINSSLOW", HealBot_Timers["SKINSSLOW"][1])
        table.remove(HealBot_Timers["SKINSSLOW"],1)
    elseif HealBot_Timers["LAST"][1] then
        if HealBot_Timers_luVars["LastLastTime"]<GetTime() then
            HealBot_Timers_luVars["LastLastTime"]=GetTime()+0.025
            HealBot_Timers_RunDelayedTimer("LAST", HealBot_Timers["LAST"][1],0.025)
            table.remove(HealBot_Timers["LAST"],1)
        end
    elseif HealBot_Timers["DELAYED"][1] then
        if HealBot_Timers_luVars["LastDelayedTime"]<GetTime() then
            HealBot_Timers_luVars["LastDelayedTime"]=GetTime()+0.05
            HealBot_Timers_RunDelayedTimer("DELAYED", HealBot_Timers["DELAYED"][1],0.05)
            table.remove(HealBot_Timers["DELAYED"],1)
        end
    else
        HealBot_setLuVars("HealBot_RunTimers", false)
        --HealBot_AddDebug("Run timers off, #Calls="..HealBot_Timers_luVars["nCalls"],"Timers",true)
        --HealBot_Timers_luVars["nCalls"]=0
    end
end