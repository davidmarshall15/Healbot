local HealBot_Timers_Init={}
local HealBot_Timers={
                      ["INIT"]={},
                      ["RESET"]={},
                      ["PLAYER"]={},
                      ["SKINS"]={},
                      ["AUX"]={},
                      ["AURA"]={},
                      ["CHAT"]={},
                      ["LAST"]={},
                      ["OOC"]={},
                     }
local HealBot_Timers_NoDups={
                      ["INIT"]={},
                      ["RESET"]={},
                      ["PLAYER"]={},
                      ["SKINS"]={},
                      ["AUX"]={},
                      ["AURA"]={},
                      ["CHAT"]={},
                      ["LAST"]={},
                      ["OOC"]={},
                     }
local HealBot_Timers_LastRun={
                      ["INIT"]={},
                      ["RESET"]={},
                      ["PLAYER"]={},
                      ["SKINS"]={},
                      ["AUX"]={},
                      ["AURA"]={},
                      ["CHAT"]={},
                      ["LAST"]={},
                      ["OOC"]={},
                     }
                     
local HealBot_Timers_NoCalls={}
local HealBot_Timers_luVars={}
local xButton,pButton
HealBot_Timers_luVars["DoneBuffReset"]=false
HealBot_Timers_luVars["nCalls"]=0
HealBot_Timers_luVars["nProcs"]=9
HealBot_Timers_luVars["nProcsOn"]=4
HealBot_Timers_luVars["nProcsOff"]=2
HealBot_Timers_luVars["turboEndTimer"]=0

function HealBot_Timers_TurboOn(duration)
      --HealBot_setCall("HealBot_Timers_TurboOn")
    HealBot_Timers_luVars["nProcs"]=HealBot_Timers_luVars["nProcsOn"]
    if HealBot_Timers_luVars["turboEndTimer"]<HealBot_TimeNow+duration then
        HealBot_Timers_luVars["turboEndTimer"]=HealBot_TimeNow+duration
        HealBot_Timers_Set("LAST","TimerTurboOff",duration)
    end
end

function HealBot_Timers_TurboOff()
      --HealBot_setCall("HealBot_Timers_TurboOff")
    if HealBot_TimeNow<HealBot_Timers_luVars["turboEndTimer"] then
        HealBot_Timers_Set("LAST","TimerTurboOff",1) -- All recall require a delay
    else
        HealBot_Timers_luVars["nProcs"]=HealBot_Timers_luVars["nProcsOff"]
    end
end

function HealBot_Timers_SetnProcs(cpuProfilerOn)
      --HealBot_setCall("HealBot_Timers_SetnProcs")
    if cpuProfilerOn then
        HealBot_Timers_luVars["nProcsOn"]=2
        HealBot_Timers_luVars["nProcsOff"]=1
    else
        HealBot_Timers_luVars["nProcsOn"]=ceil(HealBot_Globals.CPUUsage*0.2)
        if HealBot_Timers_luVars["nProcsOn"]<2 then
            HealBot_Timers_luVars["nProcsOn"]=2
        end
        HealBot_Timers_luVars["nProcsOff"]=ceil(HealBot_Globals.CPUUsage*0.1)
        if HealBot_Timers_luVars["nProcsOff"]<1 then
            HealBot_Timers_luVars["nProcsOff"]=1
        end
    end
    HealBot_Debug_PerfUpdate("TimersOn", HealBot_Timers_luVars["nProcsOn"])
    HealBot_Debug_PerfUpdate("TimersOff", HealBot_Timers_luVars["nProcsOff"])
end

function HealBot_Timers_setLuVars(vName, vValue)
      --HealBot_setCall("HealBot_Timers_setLuVars - "..vName)
    HealBot_Timers_luVars[vName]=vValue
end

function HealBot_Timers_retLuVars(vName)
      --HealBot_setCall("HealBot_Timers_retLuVars - "..vName)
    return HealBot_Timers_luVars[vName]
end

function HealBot_Timers_AuraReset()
      --HealBot_setCall("HealBot_Timers_AuraReset")
    HealBot_Timers_Set("AURA","ResetBuffCache",1)
    HealBot_Timers_Set("AURA","ResetDebuffCache",1)
end

function HealBot_Timers_SkinsFormat()
      --HealBot_setCall("HealBot_Timers_SkinsFormat")
    HealBot_Text_sethbNumberFormat()
    HealBot_Text_sethbAggroNumberFormat()
    HealBot_Timers_Set("OOC","RefreshPartyNextRecalcAll")
    HealBot_Timers_Set("LAST","ResetUnitStatus")
end

function HealBot_Timers_FluidFlashUpdate()
      --HealBot_setCall("HealBot_Timers_FluidFlashUpdate")
    HealBot_Options_BarFreq_setVars()
    HealBot_Timers_Set("SKINS","FluidFlashInUse")
    HealBot_Timers_Set("SKINS","SetFocusGroups")
    HealBot_Options_AuxBarFlashAlphaMinMaxSet()
end

function HealBot_Timer_ResetAllButtonsRecalcAll()
      --HealBot_setCall("HealBot_Timer_ResetAllButtonsRecalcAll")
    HealBot_Action_ResetAllButtons(true)
    HealBot_Timers_Set("OOC","RefreshPartyNextRecalcAll")
    HealBot_AddDebug("ResetAllButtonsRecalcAll Called", "Debug", true)
end

function HealBot_Timers_nextRecalcAll()
      --HealBot_setCall("HealBot_Timers_nextRecalcAll")
    HealBot_nextRecalcParty(0)
end

function HealBot_Timers_nextRecalcPlayers()
      --HealBot_setCall("HealBot_Timers_nextRecalcPlayers")
    HealBot_nextRecalcParty(6)
end

function HealBot_Timers_nextRecalcVehicle()
      --HealBot_setCall("HealBot_Timers_nextRecalcVehicle")
    HealBot_nextRecalcParty(1)
end

function HealBot_Timers_nextRecalcPets()
      --HealBot_setCall("HealBot_Timers_nextRecalcPets")
    HealBot_nextRecalcParty(2)
end

function HealBot_Timers_nextRecalcEnemy()
      --HealBot_setCall("HealBot_Timers_nextRecalcEnemy")
    HealBot_nextRecalcParty(5)
end

function HealBot_Timers_SkinChangePluginUpdate()
      --HealBot_setCall("HealBot_Timers_SkinChangePluginUpdate")
    if HealBot_Timers_luVars["pluginThreat"] and HealBot_Plugin_Threat_Profile then HealBot_Plugin_Threat_Profile() end
    if HealBot_Timers_luVars["pluginTimeToDie"] and HealBot_Plugin_TimeToDie_Profile then HealBot_Plugin_TimeToDie_Profile() end
    if HealBot_Timers_luVars["pluginTimeToLive"] and HealBot_Plugin_TimeToLive_Profile then HealBot_Plugin_TimeToLive_Profile() end
    if HealBot_Timers_luVars["pluginCombatProt"] and HealBot_Plugin_CombatProt_Profile then HealBot_Plugin_CombatProt_Profile() end
    if HealBot_Timers_luVars["pluginPerformance"] and HealBot_Plugin_Performance_Profile then HealBot_Plugin_Performance_Profile() end
    if HealBot_Timers_luVars["pluginTweaks"] and HealBot_Plugin_Tweaks_Profile then HealBot_Plugin_Tweaks_Profile() end
    if HealBot_Timers_luVars["pluginMedia"] and HealBot_Plugin_Media_Profile then HealBot_Plugin_Media_Profile() end
    if HealBot_Timers_luVars["pluginHealthWatch"] and HealBot_Plugin_HealthWatch_Profile then HealBot_Plugin_HealthWatch_Profile() end
    if HealBot_Timers_luVars["pluginManaWatch"] and HealBot_Plugin_ManaWatch_Profile then HealBot_Plugin_ManaWatch_Profile() end
    if HealBot_Timers_luVars["pluginMyCooldowns"] and HealBot_Plugin_MyCooldowns_Profile then HealBot_Plugin_MyCooldowns_Profile() end
end

function HealBot_Timers_HealthAlertLevel_OC()
      --HealBot_setCall("HealBot_Timers_HealthAlertLevel_OC")
    HealBot_HealthAlertLevel(false)
end

function HealBot_Timers_SkinBarTextColours()
      --HealBot_setCall("HealBot_Timers_SkinBarTextColours")
    HealBot_Panel_resetTestCols(true)
    HealBot_Options_SetBarsTextColour()
    HealBot_Timer_BarsTextUpdate()
end

function HealBot_Timers_CheckPlayerAura()
      --HealBot_setCall("HealBot_Timers_CheckPlayerAura")
    xButton, pButton = HealBot_Panel_RaidUnitButton(HealBot_Data["PGUID"])
    if xButton then HealBot_Check_UnitAura(xButton) end
    if pButton then HealBot_Check_UnitAura(pButton) end
end

function HealBot_Timers_CheckTalentInfo()
      --HealBot_setCall("HealBot_Timers_CheckTalentInfo")
    xButton, pButton = HealBot_Panel_RaidUnitButton(HealBot_Data["PGUID"])
    if xButton then HealBot_GetTalentInfo(xButton) end
    if pButton then HealBot_GetTalentInfo(pButton) end
end

function HealBot_Timers_PowerIndicator()
      --HealBot_setCall("HealBot_Timers_PowerIndicator")
    xButton, pButton = HealBot_Panel_RaidUnitButton(HealBot_Data["PGUID"])
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
      --HealBot_setCall("HealBot_Timers_TipPowerCol")
    xButton, pButton = HealBot_Panel_RaidUnitButton(HealBot_Data["PGUID"])
    if xButton then
        HealBot_Tooltip_setPlayerPowerCols(xButton.mana.r,xButton.mana.g,xButton.mana.b)
    elseif pButton then
        HealBot_Tooltip_setPlayerPowerCols(pButton.mana.r,pButton.mana.g,pButton.mana.b)
    end
end

function HealBot_Timers_FrameAliases()
      --HealBot_setCall("HealBot_Timers_FrameAliases")
    for fNo=1,10 do
        HealBot_Action_SetAlias(fNo)
        HealBot_Action_SetAliasFontSize(fNo)
    end
end

function HealBot_Timers_CheckLowMana()
      --HealBot_setCall("HealBot_Timers_CheckLowMana")
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
      --HealBot_setCall("HealBot_Timers_FramesSetPoint")
    for x=1,10 do
        if HealBot_Action_FrameIsVisible(x) then
            HealBot_Action_setPoint(x)
        end
    end
end

function HealBot_Timers_TargetFocusUpdate()
      --HealBot_setCall("HealBot_Timers_TargetFocusUpdate")
    HealBot_nextRecalcParty(3)
    if HEALBOT_GAME_VERSION>1 then
        HealBot_nextRecalcParty(4)
    end
    HealBot_nextRecalcParty(2)
    HealBot_nextRecalcParty(1)
end

function HealBot_Timers_ToggleBlizzardFrames()
      --HealBot_setCall("HealBot_Timers_ToggleBlizzardFrames")
    HealBot_Timers_Set("OOC","TogglePartyFrames")
    HealBot_Timers_Set("OOC","ToggleMiniBossFrames")
    HealBot_Timers_Set("OOC","ToggleFocusFrame")
    HealBot_Timers_Set("OOC","ToggleRaidFrames")
end

function HealBot_Timers_EnableHealBot()
      --HealBot_setCall("HealBot_Timers_EnableHealBot")
    HealBot_Config.DisabledNow=0
    HealBot_Timers_Set("INIT","RegEvents")
    HealBot_Timers_Set("PLAYER","TalentsChanged")
    HealBot_Timers_Set("OOC","RefreshPartyNextRecalcAll")
    HealBot_Timers_Set("SKINS","PartyUpdateCheckSkin")
    HealBot_Timers_ToggleBlizzardFrames()
    HealBot_AddChat(HEALBOT_CHAT_ENABLED)
end

function HealBot_Timers_DisableHealBot()
      --HealBot_setCall("HealBot_Timers_DisableHealBot")
    HealBot_Config.DisabledNow=1
    HealBot_Timers_Set("INIT","UnRegEvents")
    HealBot_Timers_Set("INIT","RegEvents")
    HealBot_Timers_Set("OOC","RefreshPartyNextRecalcAll")
    for j=1,10 do
        HealBot_Action_HidePanel(j)
    end
    HealBot_Timers_ToggleBlizzardFrames()
    HealBot_AddChat(HEALBOT_CHAT_DISABLED)
end

function HealBot_Timers_SpellsLoaded()
      --HealBot_setCall("HealBot_Timers_SpellsLoaded")
    HealBot_Timers_Set("INIT","InitBuffList")
    HealBot_Timers_Set("INIT","SpellsTabText")
    HealBot_Timers_Set("INIT","FluidFlash")
    HealBot_Timers_Set("AURA","BuffsReset")
    HealBot_Timers_Set("LAST","ResetAllButtons")
    HealBot_Timers_Set("SKINS","PowerIndicator")
    HealBot_Timers_Set("INIT","PrepSetAllAttribs")
    HealBot_Timers_Set("AURA","InitAuraData")
end

function HealBot_Timers_SpellsResetTabs()
      --HealBot_setCall("HealBot_Timers_SpellsResetTabs")
    HealBot_Timers_InitExtraOptions()
    HealBot_Options_setDebuffTypes()
end

function HealBot_Timers_TalentsLookupImproved()
      --HealBot_setCall("HealBot_Timers_TalentsLookupImproved")
    HealBot_Init_TalentLookupImproved()
    HealBot_Options_setDebuffTypes()
end

function HealBot_Timers_BuffsReset()
      --HealBot_setCall("HealBot_Timers_BuffsReset")
    HealBot_Timers_Set("AURA","BuffReset")
    HealBot_Timers_Set("AURA","DebuffReset")
    HealBot_Timers_luVars["DoneBuffReset"]=true
end

function HealBot_Timers_LoadComplete()
      --HealBot_setCall("HealBot_Timers_LoadComplete")
    HealBot_Timers_luVars["LoadComplete"]=true
end

function HealBot_Timers_LastUpdate()
      --HealBot_setCall("HealBot_Timers_LastUpdate")
    HealBot_setLuVars("DoSendGuildVersion", true)
    HealBot_Timers_Set("CHAT","SetChat",0.025)
    HealBot_Timers_Set("AURA","PlayerCheckExtended",0.05)
    HealBot_Timers_Set("AUX","UpdateAllAuxByType",0.075)
    HealBot_Timers_Set("LAST","DisableCheck",0.1)
    HealBot_Timers_Set("LAST","ProcMarkedCacheButtons",0.125)
    HealBot_Timers_Set("LAST","UpdateAllHealth",0.15)
    HealBot_Timers_Set("PLAYER","InvChange",0.175)
	HealBot_Timers_Set("LAST","UpdateAllUnitBars",0.225)
    HealBot_Timers_Set("LAST","CheckVersions",0.25)
    HealBot_Timers_Set("LAST","LoadComplete",0.3)
    HealBot_Timers_Set("LAST","UpdateCheckInterval",1)
    HealBot_Timers_Set("AURA","BuffsReset",5)
    C_Timer.After(0.5, HealBot_Timers_nextRecalcAll)
end

function HealBot_Timers_Lang()
      --HealBot_setCall("HealBot_Timers_Lang")
    if HealBot_Globals.localLang then
        HealBot_Options_Lang(HealBot_Globals.localLang, false)
    else
        HealBot_Options_Lang(GetLocale(), false)
    end
end

function HealBot_Timer_BarsTextUpdate()
      --HealBot_setCall("HealBot_Timer_BarsTextUpdate")
    HealBot_Timers_Set("SKINS","TextUpdateNames")
    HealBot_Timers_Set("SKINS","TextUpdateHealth")
    HealBot_Timers_Set("SKINS","TextUpdateState")
    HealBot_Timers_Set("SKINS","UpdateTextButtons")
end

function HealBot_Timers_SetPlayerRestingState()
      --HealBot_setCall("HealBot_Timers_SetPlayerRestingState")
    xButton, pButton = HealBot_Panel_RaidUnitButton(HealBot_Data["PGUID"])
    if xButton then HealBot_Aura_UpdateState(xButton) end
    if pButton then HealBot_Aura_UpdateState(pButton) end
end

function HealBot_Timers_InitFonts()
      --HealBot_setCall("HealBot_Timers_InitFonts")
    C_Timer.After(1, function() HealBot_Media_InitFonts(1) end)
end
    
function HealBot_Timers_InitSpells()
      --HealBot_setCall("HealBot_Timers_InitSpells")
    HealBot_Timers_Set("INIT","InitSpells")
    HealBot_Timers_Set("INIT","SpellsLoaded")
end

function HealBot_Timers_LastLoad()
      --HealBot_setCall("HealBot_Timers_LastLoad")
    HealBot_Globals.LAG=HealBot_Globals.LAG+0.1
    HealBot_Timers_Set("LAST","MountsPetsUse",0.025)
    HealBot_Timers_Set("PLAYER","InvReady",0.05)
    HealBot_Timers_Set("SKINS","PartyUpdateCheckSkin",0.075)
    HealBot_Timers_Set("LAST","InitLoadSpells",0.1)
    HealBot_Timers_Set("SKINS","EmergHealthCol",0.125)
    HealBot_Timers_Set("AURA","ConfigClassHoT",0.25)
    HealBot_Timers_Set("AURA","ConfigDebuffs",0.175)
    HealBot_Timers_Set("LAST","CheckZone",0.2)
    HealBot_Timers_Set("LAST","UpdateButtonGlow",0.225)
    HealBot_Timers_Set("LAST","UpdateIconGlow",0.225)
    HealBot_Timers_Set("AURA","BuffTagNames",0.25)
    HealBot_Timers_Set("AURA","DebuffTagNames",0.275)
    HealBot_Timers_Set("SKINS","SetAdaptive",0.3)
    HealBot_Timers_Set("LAST","SetPlayerData",0.325)
    HealBot_Timers_Set("AUX","ResetTextButtons",0.4)
    HealBot_Timers_Set("INIT","LastUpdate",0.5)
    HealBot_Timers_Set("INIT","HealBotLoaded",1)
    HealBot_Timers_InitFonts()
    if not HealBot_Timers_luVars["HelpNotice"] then
        HealBot_Timers_Set("LAST","HealBotLoadedChat")
        HealBot_Timers_luVars["HelpNotice"]=true
    end
end

function HealBot_Timers_EnteringWorld2()
      --HealBot_setCall("HealBot_Timers_EnteringWorld2")
    HealBot_Timers_Set("OOC","RefreshPartyNextRecalcAll",0.025)
    HealBot_Timers_Set("LAST","CheckDC",0.05)
    if HealBot_Timers_luVars["DoneBuffReset"] then
        HealBot_Timers_Set("INIT","LastUpdate",0.5)
    end
end

function HealBot_Timers_EnteringWorld()
      --HealBot_setCall("HealBot_Timers_EnteringWorld")
    HealBot_Timers_Set("LAST","TargetFocusUpdate",0.025)
    HealBot_Timers_Set("LAST","ResetUnitStatus",0.05)
    HealBot_Timers_Set("SKINS","UpdateEmergBars",0.075)
    HealBot_Timers_Set("INIT","EnteringWorld2",0.1)
end

function HealBot_Timer_Plugin_InitBinds()
      --HealBot_setCall("HealBot_Timer_Plugin_InitBinds")
    if HealBot_retLuVars("pluginExtraButtons") then 
        HealBot_Plugin_Options_InitBinds()
    end
end

function HealBot_Timers_CheckDC()
      --HealBot_setCall("HealBot_Timers_CheckDC")
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
end

function HealBot_Timers_GetGuildVersion()
      --HealBot_setCall("HealBot_Timers_GetGuildVersion")
    HealBot_Comms_SendAddonMsg("G", 3)
end

function HealBot_Timers_GetVersion()
      --HealBot_setCall("HealBot_Timers_GetVersion")
    HealBot_Comms_SendAddonMsg("R", 1)
    HealBot_Timers_Set("LAST","GetGuildVersion")
end

function HealBot_Timers_SendVersion()
      --HealBot_setCall("HealBot_Timers_SendVersion")
    HealBot_Comms_SendAddonMsg("S:"..HEALBOT_VERSION, 1)
    HealBot_Timers_Set("LAST","SendClassicAuraData",15)
end

function HealBot_Timers_SendGuildVersion()
      --HealBot_setCall("HealBot_Timers_SendGuildVersion")
    HealBot_Comms_SendAddonMsg("S:"..HEALBOT_VERSION, 3)
end

function HealBot_Timer_UpdateGlow()
      --HealBot_setCall("HealBot_Timer_UpdateGlow")
    HealBot_Action_DisableGlow()
    C_Timer.After(0.02, HealBot_Action_UpdateGlow)
end

function HealBot_Timer_UpdateIconGlow()
      --HealBot_setCall("HealBot_Timer_UpdateIconGlow")
    HealBot_Action_DisableGlowIcons()
    HealBot_Timers_Set("AURA","UpdateAllIcons")
end

function HealBot_Timers_SetCurrentSkin()
      --HealBot_setCall("HealBot_Timers_SetCurrentSkin")
    HealBot_Options_Set_Current_Skin(Healbot_Config_Skins.Current_Skin)
    HealBot_Options_SetSkins()
    HealBot_Options_setAuxBars()
    HealBot_UpdateAllAuxBars()
    HealBot_Action_ResetFrameAlias()
    HealBot_nextRecalcDelay(0,0.025)
    HealBot_Timers_Set("AUX","ResetText")
    HealBot_Timers_Set("SKINS","SkinChangePluginUpdate")
end
                
function HealBot_Timers_InitExtraOptions()
      --HealBot_setCall("HealBot_Timers_InitExtraOptions")
    HealBot_Timers_Set("LAST","OptionsInitExtraTabs")
end

function HealBot_Timers_LoadedChat()
      --HealBot_setCall("HealBot_Timers_LoadedChat")
    HealBot_AddChat(_G["GREEN_FONT_COLOR_CODE"]..HEALBOT_VERSION.._G["FONT_COLOR_CODE_CLOSE"] .. HEALBOT_LOADED .. " " .. HEALBOT_FORHELP .. _G["YELLOW_FONT_COLOR_CODE"].." /hb o".._G["FONT_COLOR_CODE_CLOSE"]);
end

local hbTimerFuncs={["INIT"]={
                        ["InitSpells"]=HealBot_InitSpells,
                        ["SpellsTabText"]=HealBot_Options_ComboClass_Text,
                        ["FluidFlash"]=HealBot_Timers_FluidFlashUpdate,
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
                        ["SeparateInHealsAbsorbs"]=HealBot_Text_setSeparateInHealsAbsorbs,
                        ["RegEvents"]=HealBot_Register_Events,
                        ["UnRegEvents"]=HealBot_UnRegister_Events,
                        ["ResetActiveUnitStatus"]=HealBot_Action_ResetActiveUnitStatus,
                        ["InitPlugins"]=HealBot_InitPlugins,
                        ["LastLoad"]=HealBot_Timers_LastLoad,
                        ["HealBotLoaded"]=HealBot_Loaded,
                        ["LastUpdate"]=HealBot_Timers_LastUpdate,
                        ["EnteringWorld"]=HealBot_Timers_EnteringWorld,
                        ["EnteringWorld2"]=HealBot_Timers_EnteringWorld2,
                    },
                    ["RESET"]={
                        ["Reload"]=HealBot_Options_ReloadUIAreYouSure,
                        ["Full"]=HealBot_Reset_Full,
                        ["Quick"]=HealBot_Reset_Quick,
                        ["CustomDebuffs"]=HealBot_ResetCustomDebuffs,
                        ["Skins"]=HealBot_ResetSkins,
                        ["Frames"]=HealBot_Action_Reset,
                    },
                    ["PLAYER"]={
                        ["PlayerTargetChanged"]=HealBot_OnEvent_PlayerTargetChanged,
                        ["SetRestingState"]=HealBot_Timers_SetPlayerRestingState,
                        ["InitSmartCast"]=HealBot_InitSmartCast,
                        ["SetRangeSpells"]=HealBot_Range_SetSpells,
                        ["InvChange"]=HealBot_Player_InvChange,
                        ["InvReady"]=HealBot_Player_InvReady,
                        ["EmoteOOM"]=HealBot_Timer_EmoteOOM,
                        ["SpecUpdate"]=HealBot_ResetOnSpecChange,
                        ["PlayerCheck"]=HealBot_PlayerCheck,
                        ["LoadProfile"]=HealBot_Options_LoadProfile,
                        ["SaveProfile"]=HealBot_Options_SaveProfile,
                        ["TalentsChanged"]=HealBot_Player_TalentsChanged,
                        ["CheckSpellsValid"]=HealBot_Options_SpellsCheckTextValid,
                    },
                    ["SKINS"]={
                        ["PartyUpdateCheckSkin"]=HealBot_PartyUpdate_CheckSkin,
                        ["SkinsFormat"]=HealBot_Timers_SkinsFormat,
                        ["TextExtraCustomCols"]=HealBot_Text_setExtraCustomCols,
                        ["SetBarsTextColour"]=HealBot_Options_SetBarsTextColour,
                        ["TextUpdateNames"]=HealBot_Text_UpdateNames,
                        ["TextUpdateHealth"]=HealBot_Text_UpdateHealth,
                        ["TextUpdateState"]=HealBot_Text_UpdateState,
                        ["ClearSeparateInHealsAbsorbs"]=HealBot_Text_ClearSeparateInHealsAbsorbs,
                        ["ClearOverHeals"]=HealBot_Text_ClearOverHeals,
                        ["SkinColours"]=HealBot_SetSkinColours,
                        ["UpdateBackground"]=HealBot_UpdateAllBackground,
                        ["SkinBarTextColours"]=HealBot_Timers_SkinBarTextColours,
                        ["SetSkinBars"]=HealBot_Options_SetSkinBars,
                        ["SetSkinText"]=HealBot_Options_SetSkinText,
                        ["FrameAliases"]=HealBot_Timers_FrameAliases,
                        ["RaidTargetUpdate"]=HealBot_Options_RaidTargetUpdate,
                        ["FluidFlashInUse"]=HealBot_Options_FluidFlashInUse,
                        ["SetFocusGroups"]=HealBot_Action_SetFocusGroups,
                        ["EmergHealthCol"]=HealBot_Action_EmergHealthCol,
                        ["ResetFrameAlias"]=HealBot_Action_ResetFrameAlias,
                        ["FramesSetPoint"]=HealBot_Timers_FramesSetPoint,
                        ["UpdateAggroText"]=HealBot_Aggro_UpdateAggroText,
                        ["UpdateTextButtons"]=HealBot_Text_UpdateButtons,
                        ["UpdateEmergBars"]=HealBot_UpdateAllEmergBars,
                        ["PowerIndicator"]=HealBot_Timers_PowerIndicator,
                        ["UpdateAFK"]=HealBot_updAllStateIconAFK,
                        ["ZeroHiddenButtons"]=HealBot_Action_ZeroHiddenButtons,
                        ["SetAdaptive"]=HealBot_Action_setAdaptive,
                        ["SetActionIconsList"]=HealBot_Options_SetActionIconsList,
                        ["FramesActionIconsLists"]=HealBot_Options_FramesActionIconsLists,
                        ["ActionIconsPlayerNames"]=HealBot_Options_ActionIcons_PlayerNames,
                        ["ActionIconsStateChange"]=HealBot_ActionIcons_CheckStateChange,
                        ["UpdateActiveFrameIdx"]=HealBot_ActionIcons_UpdateActiveFrameIdx,
                        ["ActionIconsSetGlowSize"]=HealBot_ActionIcons_SetGlowSize,
                        ["ActionIconsSetFontChange"]=HealBot_ActionIcons_setFontChange,
                        ["SelfCountTextUpdate"]=HealBot_ActionIcons_SelfCountTextUpdateAll,
                        ["SkinChangePluginUpdate"]=HealBot_Timers_SkinChangePluginUpdate,
                        ["ClearReset"]=HealBot_Action_ClearReset,
                        ["ResetSkinAllElements"]=HealBot_Action_ResetSkinAllElements,
                        ["ResetSkinAllButtons"]=HealBot_Action_ResetSkinAllButtons,
                    },
                    ["AUX"]={
                        ["ClearBars"]=HealBot_Options_clearAuxBars,
                        ["SetBars"]=HealBot_Options_setAuxBars,
                        ["BarFlashAlphaMinMax"]=HealBot_Options_AuxBarFlashAlphaMinMaxSet,
                        ["UpdateAllAuxBars"]=HealBot_UpdateAllAuxBars,
                        ["UpdateAllAuxByType"]=HealBot_Aux_UpdateAllAuxByType,
                        ["CheckAllAuxOverLays"]=HealBot_CheckAllAuxOverLays,
                        ["ResetBars"]=HealBot_Aux_resetBars,
                        ["doResetBars"]=HealBot_Aux_doResetBars,
                        ["ResetText"]=HealBot_ResetAllAuxText,
                        ["TestUpdate"]=HealBot_Aux_TestUpdate,
                        ["ResetRange"]=HealBot_AuxResetRange,
                        ["updAllAuxRangeBars"]=HealBot_updAllAuxRangeBars,
                        ["updAllAuxInRangeBars"]=HealBot_updAllAuxInRangeBars,
                        ["updAllAuxBuffBars"]=HealBot_updAllAuxBuffBars,
                        ["updAllAuxDebuffBars"]=HealBot_updAllAuxDebuffBars,
                        ["UpdateAllAuxPowerBars"]=HealBot_UpdateAllAuxPowerBars,
                        ["UpdateAllAuxOverHealsBars"]=HealBot_updAllAuxOverHealsBars,
                        ["UpdateAllAuxInHealsBars"]=HealBot_updAllAuxInHealsBars,
                        ["UpdateAllAuxAbsorbBars"]=HealBot_updAllAuxAbsorbBars,
                        ["UpdateAllAuxTotalHealAbsorbBars"]=HealBot_updAllAuxTotalHealAbsorbBars,
                        ["UpdateAllAuxThreatBars"]=HealBot_updAllAuxThreatBars,
                        ["CheckInUse"]=HealBot_Options_CheckAuxInUse,
                        ["ClearAllMarkedBars"]=HealBot_Aux_clearAllMarkedBars,
                        ["ResetTextButtons"]=HealBot_Aux_ResetTextButtons,
                    },
                    ["AURA"]={
                        ["CheckUnits"]=HealBot_AuraCheck,
                        ["CheckBuffs"]=HealBot_BuffCheck,
                        ["CheckDebuffs"]=HealBot_DebuffCheck,
                        ["BuffReset"]=HealBot_Options_Buff_Reset,
                        ["ExtraBuffReset"]=HealBot_Options_ExtraBuff_Reset,
                        ["DebuffReset"]=HealBot_Options_Debuff_Reset,
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
                        ["BuffsReset"]=HealBot_Timers_BuffsReset,
                        ["RemoveAllBuffIcons"]=HealBot_Aura_RemoveAllBuffIcons,
                        ["RemoveAllDebuffIcons"]=HealBot_Aura_RemoveAllDebuffIcons,
                        ["ClearAllBuffs"]=HealBot_Aura_ClearAllBuffs,
                        ["ClearAllDebuffs"]=HealBot_Aura_ClearAllDebuffs,
                        ["BuffBarColours"]=HealBot_SetBuffBarColours,
                        ["PlayerCheckExtended"]=HealBot_PlayerCheckExtended,
                        ["InitItemsDataReady"]=HealBot_Aura_InitItemsDataReady,
                        ["RemoveUnusedDebuffIcons"]=HealBot_Aura_RemoveUnusedDebuffIcons,
                        ["RemoveUnusedBuffIcons"]=HealBot_Aura_RemoveUnusedBuffIcons,
                        ["UpdateAllIcons"]=HealBot_UpdateAllIcons,
                        ["RaidTargetUpdateAll"]=HealBot_OnEvent_RaidTargetUpdateAll,
                        ["ResetClassIconTexture"]=HealBot_ResetClassIconTexture,
                        ["UpdateAllBuffIcons"]=HealBot_Aura_Update_UnitAllBuffIcons,
                        ["UpdateAllDebuffIcons"]=HealBot_Aura_Update_UnitAllDebuffIcons,
                        ["UpdateActiveDebuffs"]=HealBot_Aura_UpdateActiveDebuffs,
                        ["InitAuraData"]=HealBot_Aura_InitData,
                        ["UpdateAllHotBars"]=HealBot_UpdateAllHotBars,
                        ["CustomDebuffList"]=HealBot_Options_setCustomDebuffList,
                        ["CustomDebuffListPrep"]=HealBot_Options_prepCustomDebuffList,
                        ["CustomBuffList"]=HealBot_Options_setCustomBuffList,
                        ["CustomBuffListPrep"]=HealBot_Options_prepCustomBuffList,
                        ["ConfigDebuffs"]=HealBot_Aura_ConfigDebuffs,
                        ["BuffTagNames"]=HealBot_Aura_BuffTagNames,
                        ["DebuffTagNames"]=HealBot_Aura_DebuffTagNames,
                        ["IconUpdAllState"]=HealBot_Aura_UpdateAllState,
                        ["IconUpdHostile"]=HealBot_updAllStateIconHostile,
                    },
                    ["CHAT"]={
                        ["OverrideChatUseToggle"]=HealBot_Options_Override_ChatUse_Toggle,
                        ["SetChat"]=HealBot_Options_SetChat,
                    },
                    ["LAST"]={
                        ["MountsPetsUse"]=HealBot_MountsPets_InitUse,
                        ["MountsPetsZone"]=HealBot_MountsPets_ZoneChange,
                        ["MountsPetsInit"]=HealBot_MountsPets_InitMount,
                        ["HealBotLoadedChat"]=HealBot_Timers_LoadedChat,
                        ["OptionsMainPanel"]=HealBot_Options_MainPanel,
                        ["OverrideEffectsUseToggle"]=HealBot_Options_Override_EffectsUse_Toggle,
                        ["CheckFramesOnCombat"]=HealBot_CheckFramesOnCombat,
                        ["ResetUnitStatus"]=HealBot_Action_ResetUnitStatus,
                        ["ResetAllButtons"]=HealBot_Action_ResetAllButtons,
                        ["ResetAllButtonsRecalcAll"]=HealBot_Timer_ResetAllButtonsRecalcAll,
                        ["LowManaTrig"]=HealBot_Action_setLowManaTrig,
                        ["CheckLowMana"]=HealBot_Timers_CheckLowMana,
                        ["EndAggro"]=HealBot_EndAggro,
                        ["AfterCombatCleanup"]=HealBot_AfterCombatCleanup,
                        ["TargetFocusUpdate"]=HealBot_Timers_TargetFocusUpdate,
                        ["RegAggro"]=HealBot_Action_Register_Aggro,
                        ["CheckZone"]=HealBot_CheckZone,
                        ["CheckSubZone"]=HealBot_CheckSubZone,
                        ["ZoneUpdate"]=HealBot_Timer_ZoneUpdate,
                        ["PartyUpdateCheckSolo"]=HealBot_PartyUpdate_CheckSolo,
                        ["TipPowerCol"]=HealBot_Timers_TipPowerCol,
                        ["BarFreqVars"]=HealBot_Options_BarFreq_setVars,
                        ["OverrideFramesUseToggle"]=HealBot_Options_Override_FramesUse_Toggle,
                        ["InitItemsData"]=HealBot_Aura_InitItemsData,
                        ["CheckDC"]=HealBot_Timers_CheckDC,
                        ["ProcMarkedCacheButtons"]=HealBot_Action_MarkedCacheButtons,
                        ["UpdateAllHealth"]=HealBot_UpdateAllHealth,
                        ["UpdateAllUnitBars"]=HealBot_UpdateAllUnitBars,
                        ["Reload"]=HealBot_Reload,
                        ["ReadyCheck"]=HealBot_ReadyCheck,
                        ["ReadyCheckClear"]=HealBot_OnEvent_ReadyCheckClear,
                        ["LoadComplete"]=HealBot_Timers_LoadComplete,
                        ["UpdateMaxUnitsAdj"]=HealBot_UpdateMaxUnitsAdj,
                        ["DisableCheck"]=HealBot_Options_DisableCheck,
                        ["GetVersion"]=HealBot_Timers_GetVersion,
                        ["GetGuildVersion"]=HealBot_Timers_GetGuildVersion,
                        ["SendVersion"]=HealBot_Timers_SendVersion,
                        ["SendGuildVersion"]=HealBot_Timers_SendGuildVersion,
                        ["CheckVersions"]=HealBot_CheckVersions,
                        ["OptionsInitExtraTabs"]=HealBot_Options_InitExtras,
                        ["VarsNotLoaded"]=HealBot_OnEvent_VariablesLoaded,
                        ["TimerTurboOff"]=HealBot_Timers_TurboOff,
                        ["IconNotInCombat"]=HealBot_updAllStateIconNotInCombat,
                        ["PluginInitBinds"]=HealBot_Timer_Plugin_InitBinds,
                        ["InitBinds"]=HealBot_Options_InitBinds,
                        ["InitLoadSpells"]=HealBot_Timers_InitSpells,
                        ["SetAutoClose"]=HealBot_Action_setAutoClose,
                        ["CheckHideFrames"]=HealBot_Action_CheckHideFrames,
                        ["CheckHideUnusedFrames"]=HealBot_Action_CheckHideUnusedFrames,
                        ["ShowFramesOnSkinChange"]=HealBot_Action_ShowFramesOnSkinChange,
                        ["MountsPetsDalaran"]=HealBot_MountsPets_ClassicDalaranCheck,
                        ["SendClassicAuraData"]=HealBot_Aura_SendClassicData,
                        ["LoadTips"]=HealBot_Options_LoadTips,
                        ["SetPlayerData"]=HealBot_SetPlayerData,
                        ["SetInHealAbsorbMax"]=HealBot_Aux_setInHealAbsorbMax,
                        ["UpdateButtonGlow"]=HealBot_Timer_UpdateGlow,
                        ["UpdateIconGlow"]=HealBot_Timer_UpdateIconGlow,
                        ["ClearClassGuidData"]=HealBot_clearClassGuidData,
                        ["DisableAllButtonGlow"]=HealBot_Action_DisableGlow,
                        ["DisableAllIconGlow"]=HealBot_Action_DisableGlowIcons,
                        ["TalentsLookupImproved"]=HealBot_Timers_TalentsLookupImproved,
                        ["UpdateFramesOpacity"]=HealBot_Action_UpdateFramesOpacity,
                        ["ClassColourUpdate"]=HealBot_Options_ClassColourUpdate,
                        ["RoleColourUpdate"]=HealBot_Options_RoleColourUpdate,
                        ["PowerColourUpdate"]=HealBot_Options_PowerColourUpdate,
                        ["AdaptiveColourUpdate"]=HealBot_Options_AdaptiveColourUpdate,
                        ["OverrideClassColourUseToggle"]=HealBot_Options_Override_ColoursClassUse_Toggle,
                        ["OverrideRoleColourUseToggle"]=HealBot_Options_Override_ColoursRoleUse_Toggle,
                        ["OverridePowerColourUseToggle"]=HealBot_Options_Override_ColoursPowerUse_Toggle,
                        ["OverrideAdaptiveColourUseToggle"]=HealBot_Options_Override_ColoursAdaptiveUse_Toggle,
                        ["BarColourAlphaSetFunc"]=HealBot_Action_BarColourAlphaSetFunc,
                        ["AuxBarsReset"]=HealBot_Aux_barsReset,
                        ["ClassicSpellRanks"]=HealBot_Init_ClassicSpellRanks,
                        ["GuildUpdate"]=HealBot_Comms_GuildUpdate,
                        ["PerfRangeFreq"]=HealBot_Range_PerfFreq,
                        ["UpdateCheckInterval"]=HealBot_UpdateCheckInterval,
                        ["MediaPluginChange"]=HealBot_Media_PluginChange,
                    },
                    ["OOC"]={
                        ["FullReload"]=HealBot_FullReload,
                        ["TogglePartyFrames"]=HealBot_Timer_TogglePartyFrames,
                        ["ToggleFocusFrame"]=HealBot_Timer_ToggleFocusFrame,
                        ["ToggleMiniBossFrames"]=HealBot_Timer_ToggleMiniBossFrames,
                        ["ToggleRaidFrames"]=HealBot_Timer_ToggleRaidFrames,
                        ["ProcessRefreshTypes"]=HealBot_ProcessRefreshTypes,
                        ["ProcMarkedCache"]=HealBot_Action_ProcMarkedCacheButtons,
                        ["CheckFrameSetPoint"]=HealBot_Action_CheckFrameSetPoint,
                        ["ModKey"]=HealBot_Action_ModKey,
                        ["RegisterForClicks"]=HealBot_Action_setRegisterForClicks,
                        ["ActionIconsNumbers"]=HealBot_ActionIcons_UpdateNumIconsAll,
                        ["ActionIconsSetPoints"]=HealBot_ActionIcons_SetAllFramePoints,
                        ["ActionIconsValidateTarget"]=HealBot_ActionIcons_ValidateTargetAll,
                        ["ActionIconsValidateTargetIcons"]=HealBot_ActionIcons_ValidateTargetAllIconFrames,
                        ["ActionIconsValidateAbility"]=HealBot_ActionIcons_ValidateAbilityAll,
                        ["ActionIconsValidateItems"]=HealBot_ActionIcons_ValidateItems,
                        ["SaveSpellsProfile"]=HealBot_Options_SaveSpellsProfile,
                        ["SaveActionIconsProfile"]=HealBot_Options_SaveActionIconsProfile,
                        ["ToggleOptions"]=HealBot_Options_ShowHide,
                        ["ActionIconsUnitChecks"]=HealBot_ActionIcons_UnitChecks,
                        ["ActionIconsInitFrames"]=HealBot_ActionIcons_InitFrames,
                        ["PostCombatSetAttribs"]=HealBot_ActionIcons_PostCombatSetAttribs,
                        ["PostCombatClearAttribs"]=HealBot_ActionIcons_PostCombatClearAttribs,
                        ["UpdateTargetMyFriend"]=HealBot_ActionIcons_UpdateTargetMyFriend,
                        ["ActionIconsBindRecheck"]=HealBot_Options_ActionIconsBindRecheck,
                        ["RefreshPartyNextRecalcAll"]=HealBot_Timers_nextRecalcAll,
                        ["RefreshPartyNextRecalcPlayers"]=HealBot_Timers_nextRecalcPlayers,
                        ["RefreshPartyNextRecalcPets"]=HealBot_Timers_nextRecalcPets,
                        ["RefreshPartyNextRecalcVehicle"]=HealBot_Timers_nextRecalcVehicle,
                        ["RefreshPartyNextRecalcEnemy"]=HealBot_Timers_nextRecalcEnemy,
                        ["BuffIdLookup"]=HealBot_Aura_BuffIdLookup,
                    },
                   }

function HealBot_Timers_DoSet(cat,timer)
      --HealBot_setCall("HealBot_Timers_DoSet", nil, nil, nil, true)
    HealBot_Timers_LastRun[cat][timer]=HealBot_TimeNow
    table.insert(HealBot_Timers[cat],timer)
    HealBot_setLuVars("HealBot_RunTimers", true)
end

function HealBot_Timers_Set(cat,timer,delay)
      --HealBot_setCall("HealBot_Timers_Set", nil, nil, nil, true)
    if not HealBot_Timers_NoDups[cat][timer] then
        HealBot_Timers_NoDups[cat][timer]=true
        if delay then
            C_Timer.After(delay, function() HealBot_Timers_DoSet(cat,timer) end)
        elseif HealBot_Timers_LastRun[cat][timer] and HealBot_Timers_LastRun[cat][timer]-(HealBot_TimeNow-1)>0 then
            C_Timer.After(HealBot_Timers_LastRun[cat][timer]-(HealBot_TimeNow-1), function() HealBot_Timers_DoSet(cat,timer) end)
        else
            HealBot_Timers_DoSet(cat,timer)
        end
    end
end

function HealBot_Timers_PluginsSet(tId)
      --HealBot_setCall("HealBot_Timers_PluginsSet")
    if tId==1 then
        HealBot_Timers_Set("OOC","RefreshPartyNextRecalcPlayers",0.5)
    elseif tId==2 then
        HealBot_Timers_Set("AURA","CheckUnits",0.5)
    elseif tId==3 then
        HealBot_Timers_Set("INIT","PrepSetAllAttribs",1)
    elseif tId==4 then
        HealBot_Timers_Set("LAST","InitBinds",0.1)
    elseif tId==5 then
        HealBot_Timers_Set("AURA","ResetBuffCache",0.1)
    elseif tId==6 then
        HealBot_Timers_Set("AURA","ResetDebuffCache",0.1)
    elseif tId==7 then
        HealBot_Timers_Set("LAST","SetInHealAbsorbMax",0.1)
    elseif tId==8 then
        HealBot_Timers_Set("LAST","MediaPluginChange",0.1)
    end
end

local NoCallsInx=""
function HealBot_Timers_Usage(cat, timer)
      --HealBot_setCall("HealBot_Timers_Usage")
    NoCallsInx=cat..":"..timer
    if not HealBot_Timers_NoCalls[NoCallsInx] then HealBot_Timers_NoCalls[NoCallsInx]=0 end
    HealBot_Timers_NoCalls[NoCallsInx]=HealBot_Timers_NoCalls[NoCallsInx]+1
    HealBot_AddDebug(NoCallsInx.."="..HealBot_Timers_NoCalls[NoCallsInx],"Timers",true)
end

function HealBot_Timers_RunTimer(cat, timer)
        --HealBot_setCall("HealBot_Timers_RunTimer-"..cat..":"..timer)
    if hbTimerFuncs[cat][timer] then
        HealBot_Timers_NoDups[cat][timer]=false
        hbTimerFuncs[cat][timer]()
    else
        NoCallsInx=cat..":"..timer
        HealBot_AddDebug(HEALBOT_HEALBOT .. " " .. _G["ORANGE_FONT_COLOR_CODE"] .. "ERROR: Timer " .._G["FONT_COLOR_CODE_CLOSE"] .. _G["YELLOW_FONT_COLOR_CODE"] .. NoCallsInx  .._G["FONT_COLOR_CODE_CLOSE"].. _G["ORANGE_FONT_COLOR_CODE"] .." not found.")
        HealBot_AddDebug(HEALBOT_HEALBOT .. " " .. _G["ORANGE_FONT_COLOR_CODE"] .. " ERROR: Timer " .._G["FONT_COLOR_CODE_CLOSE"] .. _G["YELLOW_FONT_COLOR_CODE"] .. NoCallsInx  .._G["FONT_COLOR_CODE_CLOSE"].. _G["ORANGE_FONT_COLOR_CODE"] .." not found.","Timers",true)
    end
    --if HealBot_Globals.DebugOut then HealBot_Timers_Usage(cat, timer) end
end

function HealBot_Timers_Proc()
      --HealBot_setCall("HealBot_Timers_Proc")
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
    elseif HealBot_Timers["AURA"][1] then
        HealBot_Timers_RunTimer("AURA", HealBot_Timers["AURA"][1])
        table.remove(HealBot_Timers["AURA"],1)
    elseif HealBot_Timers["CHAT"][1] then
        HealBot_Timers_RunTimer("CHAT", HealBot_Timers["CHAT"][1])
        table.remove(HealBot_Timers["CHAT"],1)
    elseif HealBot_Timers["LAST"][1] then
        HealBot_Timers_RunTimer("LAST", HealBot_Timers["LAST"][1])
        table.remove(HealBot_Timers["LAST"],1)
    elseif not HealBot_Data["UILOCK"] and HealBot_Timers["OOC"][1] then
        HealBot_Timers_RunTimer("OOC", HealBot_Timers["OOC"][1])
        table.remove(HealBot_Timers["OOC"],1)
    else
        HealBot_setLuVars("HealBot_RunTimers", false)
        --HealBot_Timers_luVars["nCalls"]=0
        return false
    end
    return true
end

function HealBot_Timers_Run()
      --HealBot_setCall("HealBot_Timers_Run")
    if HealBot_Data["UILOCK"] then
        HealBot_Timers_Proc()
    else
        for x=1,HealBot_Timers_luVars["nProcs"] do
            --HealBot_Timers_Proc()
            if not HealBot_Timers_Proc() then break end
        end
    end
end
