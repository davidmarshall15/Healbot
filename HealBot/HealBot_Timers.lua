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
local HealBot_Timers_ShortDelay={
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
local HealBot_Timers_Delayed={
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
local HealBot_Timers_LongDelay={
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
local HealBot_Timers_Trottle={
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
local HealBot_Timers_NoCalls={}
local HealBot_Timers_luVars={}
local xButton,pButton,aButton
HealBot_Timers_luVars["DoneBuffReset"]=false
HealBot_Timers_luVars["nCalls"]=0
HealBot_Timers_luVars["nProcs"]=9
HealBot_Timers_luVars["nProcsOn"]=8
HealBot_Timers_luVars["nProcsOff"]=2
HealBot_Timers_luVars["turboEndTimer"]=0
HealBot_Timers_luVars["ResetSkins"]=false

function HealBot_Timers_TurboOn()
      --HealBot_setCall("HealBot_Timers_TurboOn")
    HealBot_Timers_luVars["nProcs"]=HealBot_Timers_luVars["nProcsOn"]
    HealBot_Timers_Set("LAST","TimerTurboOff",true) --,true)
end

function HealBot_Timers_TurboOff()
      --HealBot_setCall("HealBot_Timers_TurboOff")
    HealBot_Timers_luVars["nProcs"]=HealBot_Timers_luVars["nProcsOff"]
end

function HealBot_Timers_SetnProcs(cpuProfilerOn)
      --HealBot_setCall("HealBot_Timers_SetnProcs")
    if cpuProfilerOn or HealBot_Config.DisabledNow == 1 then
        HealBot_Timers_luVars["nProcsOn"]=2
        HealBot_Timers_luVars["nProcsOff"]=1
    else
        HealBot_Timers_luVars["nProcsOn"]=HealBot_Util_PerfVal1(200)
        if HealBot_Timers_luVars["nProcsOn"]<2 then
            HealBot_Timers_luVars["nProcsOn"]=2
        end
        HealBot_Timers_luVars["nProcsOff"]=HealBot_Util_PerfVal1(50)
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
    HealBot_Timers_Set("AURA","ResetBuffCache",true)
    HealBot_Timers_Set("AURA","ResetDebuffCache",true)
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
    HealBot_Timers_Set("SKINS","SetFocusGroups",true)
    HealBot_Timers_Set("SKINS","FluidFlashInUse",true)
    HealBot_Options_AuxBarFlashAlphaMinMaxSet()
end

function HealBot_Timer_ResetAllButtonsRecalcAll()
      --HealBot_setCall("HealBot_Timer_ResetAllButtonsRecalcAll")
    HealBot_Action_ResetAllButtons(true)
    HealBot_Timers_Set("OOC","RefreshPartyNextRecalcAll")
    HealBot_AddDebug("ResetAllButtonsRecalcAll Called", "Debug", true)
end

function HealBot_Timers_ResetSkins()
    HealBot_Timers_luVars["ResetSkins"]=false
    HealBot_Action_setLuVars("resetSkin", true)
    HealBot_Action_ResetSkinAllButtons()
    HealBot_Timers_TurboOn()
end

function HealBot_Timers_ResetEnemySkins()
    HealBot_Timers_luVars["ResetEnemySkins"]=false
    HealBot_Action_ResetEnemySkinAllButtons()
end

function HealBot_Timers_nextRecalcAll()
      --HealBot_setCall("HealBot_Timers_nextRecalcAll")
    if HealBot_Timers_luVars["ResetSkins"] then
        HealBot_Timers_ResetSkins()
    elseif HealBot_Timers_luVars["ResetEnemySkins"] then
        HealBot_Timers_ResetEnemySkins()
    end
    HealBot_nextRecalcParty(0)
end

function HealBot_Timers_nextRecalcPlayers()
      --HealBot_setCall("HealBot_Timers_nextRecalcPlayers")
    if HealBot_Timers_luVars["UpdateEnemy"] then
        HealBot_Timers_luVars["UpdateEnemy"]=false
        HealBot_setLuVars("UpdateEnemy", true)
     --   HealBot_SetResetFlag("SOFT")
    end
    if HealBot_Timers_luVars["ResetSkins"] then
        HealBot_Timers_ResetSkins()
    elseif HealBot_Timers_luVars["ResetEnemySkins"] then
        HealBot_Timers_ResetEnemySkins()
    end
    if HealBot_Timers_luVars["ResetClassRank"] then
        HealBot_Timers_luVars["ResetClassRank"]=false
        HealBot_Timers_Set("AURA","ResetClassIconTexture",true)
        HealBot_Timers_Set("AURA","IconUpdAllRank",true)
        HealBot_Timers_Set("SKINS","TextUpdateNames",true)
    end
    HealBot_nextRecalcParty(6)
end

function HealBot_Timers_nextRecalcVehicle()
    if HealBot_Timers_luVars["ResetSkins"] then
        HealBot_Timers_ResetSkins()
    end
    HealBot_nextRecalcParty(1)
      --HealBot_setCall("HealBot_Timers_nextRecalcVehicle")
end

function HealBot_Timers_nextRecalcPets()
    if HealBot_Timers_luVars["ResetSkins"] then
        HealBot_Timers_ResetSkins()
    end
    HealBot_nextRecalcParty(2)
      --HealBot_setCall("HealBot_Timers_nextRecalcPets")
end

function HealBot_Timers_nextRecalcEnemy()
      --HealBot_setCall("HealBot_Timers_nextRecalcEnemy")
    if HealBot_Timers_luVars["ResetSkins"] then
        HealBot_Timers_ResetSkins()
    end
    HealBot_nextRecalcParty(5)
end

function HealBot_Timers_nextRecalcTarget()
      --HealBot_setCall("HealBot_Timers_nextRecalcEnemy")
    if HealBot_Timers_luVars["ResetSkins"] then
        HealBot_Timers_ResetSkins()
    elseif HealBot_Timers_luVars["ResetEnemySkins"] then
        HealBot_Timers_ResetEnemySkins()
    end
    HealBot_nextRecalcParty(3)
end

function HealBot_Timers_nextRecalcFocus()
      --HealBot_setCall("HealBot_Timers_nextRecalcEnemy")
    if HealBot_Timers_luVars["ResetSkins"] then
        HealBot_Timers_ResetSkins()
    end
    HealBot_nextRecalcParty(4)
end

function HealBot_Timers_updateEnemyFrames()
    HealBot_Timers_luVars["UpdateEnemy"]=true
    HealBot_Action_ResetSkinTextAuxAllButtons()
    HealBot_Timers_Set("OOC","RefreshPartyNextRecalcPlayers")
    HealBot_Timers_Set("OOC","RefreshPartyNextRecalcEnemy")
end

function HealBot_Timers_SkinChangePluginUpdate()
      --HealBot_setCall("HealBot_Timers_SkinChangePluginUpdate")
    if HealBot_Timers_luVars["pluginThreat"] and HealBot_Plugin_Threat_Profile then HealBot_Plugin_Threat_Profile(); HealBot_Plugin_Threat_UpdateAll() end
    if HealBot_Timers_luVars["pluginTimeToDie"] and HealBot_Plugin_TimeToDie_Profile then HealBot_Plugin_TimeToDie_Profile(); HealBot_Plugin_TimeToDie_UpdateAll() end
    if HealBot_Timers_luVars["pluginTimeToLive"] and HealBot_Plugin_TimeToLive_Profile then HealBot_Plugin_TimeToLive_Profile(); HealBot_Plugin_TimeToLive_UpdateAll() end
    if HealBot_Timers_luVars["pluginCombatProt"] and HealBot_Plugin_CombatProt_Profile then HealBot_Plugin_CombatProt_Profile() end
    if HealBot_Timers_luVars["pluginPerformance"] and HealBot_Plugin_Performance_Profile then HealBot_Plugin_Performance_Profile() end
    if HealBot_Timers_luVars["pluginTweaks"] and HealBot_Plugin_Tweaks_Profile then HealBot_Plugin_Tweaks_Profile() end
    if HealBot_Timers_luVars["pluginMedia"] and HealBot_Plugin_Media_Profile then HealBot_Plugin_Media_Profile() end
    if HealBot_Timers_luVars["pluginHealthWatch"] and HealBot_Plugin_HealthWatch_Profile then HealBot_Plugin_HealthWatch_Profile() end
    if HealBot_Timers_luVars["pluginManaWatch"] and HealBot_Plugin_ManaWatch_Profile then HealBot_Plugin_ManaWatch_Profile() end
    if HealBot_Timers_luVars["pluginMyCooldowns"] and HealBot_Plugin_MyCooldowns_Profile then HealBot_Plugin_MyCooldowns_Profile(); HealBot_Plugin_MyCooldowns_UpdateAll() end
end

function HealBot_Timers_PluginTweaks_Refresh()
    if HealBot_Timers_luVars["pluginTweaks"] then
        HealBot_Plugin_Options_Tweaks_RefreshLists()
    end
end

function HealBot_Timers_SkinBarTextColours()
      --HealBot_setCall("HealBot_Timers_SkinBarTextColours")
    HealBot_Panel_resetTestCols(true)
    HealBot_Options_SetBarsTextColour()
    HealBot_Timer_BarsTextUpdate()
end

function HealBot_Timers_CheckPlayerAura()
      --HealBot_setCall("HealBot_Timers_CheckPlayerAura")
    xButton, pButton=HealBot_Panel_RaidUnitButton(HealBot_Data["PGUID"])
    if xButton then HealBot_Events_CheckUnitAura(xButton) end
    if pButton then HealBot_Events_CheckUnitAura(pButton) end
end

function HealBot_Timers_CheckTalentInfo()
      --HealBot_setCall("HealBot_Timers_CheckTalentInfo")
    xButton, pButton=HealBot_Panel_RaidUnitButton(HealBot_Data["PGUID"])
    if xButton then HealBot_GetTalentInfo(xButton) end
    if pButton then HealBot_GetTalentInfo(pButton) end
end

function HealBot_Timers_PowerIndicator()
      --HealBot_setCall("HealBot_Timers_PowerIndicator")
    if HealBot_Data["PCLASSTRIM"] then
        xButton, pButton=HealBot_Panel_RaidUnitButton(HealBot_Data["PGUID"])
        if xButton then
            HealBot_Action_setpcClass(xButton)
            xButton.mana.power=-1
            HealBot_Events_PowerIndicators(xButton)
        end
        if pButton then
            HealBot_Action_setpcClass(pButton)
            pButton.mana.power=-1
            HealBot_Events_PowerIndicators(pButton)
        end
    else
        HealBot_SetPlayerData()
        HealBot_Timers_Set("SKINS","PowerIndicator",true,true)
    end
end

function HealBot_Timers_TipPowerCol()
      --HealBot_setCall("HealBot_Timers_TipPowerCol")
    aButton=HealBot_Panel_RaidButton(HealBot_Data["PGUID"])
    if aButton then
        HealBot_Tooltip_setPlayerPowerCols(aButton.mana.r,aButton.mana.g,aButton.mana.b)
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
        if hbv_Skins_GetFrameVar("HealBar", "LOWMANA", j)>1 and not hbv_Skins_GetFrameBoolean("HealBar", "LOWMANACOMBAT", j) then
            checkLowMana=true
            break
        end
    end
    if checkLowMana then HealBot_Timers_Set("LAST","UpdateLowMana",true) end
end

function HealBot_Timers_FramesSetPoint()
      --HealBot_setCall("HealBot_Timers_FramesSetPoint")
    for x=1,10 do
        if HealBot_Action_FrameIsVisible(x) then
            HealBot_Action_setPoint(x)
        end
    end
end

function HealBot_Timers_FramesSetPointCheck()
      --HealBot_setCall("HealBot_Timers_FramesSetPoint")
    for x=1,10 do
        if HealBot_Action_FrameIsVisible(x) then
            HealBot_Action_setPoint(x, true)
        end
    end
end

function HealBot_Timers_TargetFocusUpdate()
      --HealBot_setCall("HealBot_Timers_TargetFocusUpdate")
    if HealBot_Timers_luVars["ResetSkins"] then
        HealBot_Timers_ResetSkins()
    end
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
    HealBot_FastFuncsUpdate()
    HealBot_Timers_Set("INIT","RegEvents")
    HealBot_Timers_Set("PLAYER","TalentsChanged")
    HealBot_Timers_Set("OOC","RefreshPartyNextRecalcAll")
    HealBot_Timers_Set("OOC","PartyUpdateCheckSkin")
    HealBot_Timers_Set("AURA","PlayerCheckExtended")
    HealBot_Timers_ToggleBlizzardFrames()
    HealBot_AddChat(HEALBOT_CHAT_ENABLED)
    HealBot_Timers_TurboOn()
end

function HealBot_Timers_DisableHealBot()
      --HealBot_setCall("HealBot_Timers_DisableHealBot")
    HealBot_Config.DisabledNow=1
    HealBot_FastFuncsUpdate()
    HealBot_Timers_Set("INIT","UnRegEvents")
    HealBot_Timers_Set("INIT","RegEvents")
    HealBot_Timers_Set("OOC","RefreshPartyNextRecalcAll")
    for j=1,10 do
        HealBot_Action_HidePanel(j)
    end
    HealBot_Timers_ToggleBlizzardFrames()
    HealBot_AddChat(HEALBOT_CHAT_DISABLED)
    HealBot_Timers_TurboOn()
end

function HealBot_Timers_SpellsLoaded()
      --HealBot_setCall("HealBot_Timers_SpellsLoaded")
    HealBot_Timers_Set("INIT","InitBuffList")
    HealBot_Timers_Set("INIT","SpellsTabText")
    HealBot_Timers_Set("AURA","BuffsReset")
    HealBot_Timers_Set("LAST","ResetAllButtons")
    HealBot_Timers_Set("SKINS","PowerIndicator")
    HealBot_Timers_Set("INIT","PrepSetAllAttribs")
    HealBot_Timers_Set("AURA","InitAuraData")
    HealBot_Timers_Set("INIT","FluidFlash",true)
end

function HealBot_Timers_SpellsResetTabs()
      --HealBot_setCall("HealBot_Timers_SpellsResetTabs")
    HealBot_Timers_InitExtraOptions()
    HealBot_Options_setDebuffTypes()
end

function HealBot_Timers_TalentsLookupImprovedCallback()
      --HealBot_setCall("HealBot_Timers_TalentsLookupImproved")
    if HealBot_Data["PCLASSTRIM"] then
        HealBot_Init_TalentLookupImproved(true)
        HealBot_Options_setDebuffTypes()
    else
        HealBot_SetPlayerData()
        HealBot_Timers_Set("LAST","TalentsLookupImprovedCallback",true,true)
    end
end

function HealBot_Timers_TalentsLookupImproved()
      --HealBot_setCall("HealBot_Timers_TalentsLookupImproved")
    if HealBot_Data["PCLASSTRIM"] then
        HealBot_Init_TalentLookupImproved()
        HealBot_Options_setDebuffTypes()
    else
        HealBot_SetPlayerData()
        HealBot_Timers_Set("LAST","TalentsLookupImproved",true,true)
    end
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
    HealBot_Timers_Set("CHAT","SetChat")
    HealBot_Timers_Set("AURA","PlayerCheckExtended")
    HealBot_Timers_Set("AUX","UpdateAllAuxByType")
    HealBot_Timers_Set("PLAYER","InvChange")
    HealBot_Timers_Set("OOC","DisableCheck",true)
    HealBot_Timers_Set("LAST","UpdateAllHealth",true)
	HealBot_Timers_Set("LAST","UpdateAllUnitBars",true)
    HealBot_Timers_Set("LAST","UpdateCheckInterval",true)
    HealBot_Timers_Set("LAST","MarkedCacheButtons",true)
    HealBot_Timers_Set("LAST","CheckVersions",true)
    HealBot_Timers_Set("AURA","ConfigClassHoT",true)
    HealBot_Timers_Set("AURA","ConfigDebuffs",true)
    HealBot_Timers_Set("OOC","RefreshPartyNextRecalcAll",true)
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
    xButton, pButton=HealBot_Panel_RaidUnitButton(HealBot_Data["PGUID"])
    if xButton then HealBot_Aura_UpdateState(xButton) end
    if pButton then HealBot_Aura_UpdateState(pButton) end
end

function HealBot_Timers_InitSpells()
      --HealBot_setCall("HealBot_Timers_InitSpells")
    HealBot_Timers_Set("INIT","InitSpells")
    HealBot_Timers_Set("INIT","SpellsLoaded")
end

function HealBot_Timers_OnLoadMessages()
    if HealBot_Timers_luVars["oldOptionsExists"] then
        if GetServerTime() >= 1747100000 then
            HealBot_AddChat("=== Please Note ===")
            HealBot_AddChat("The HealBot_Options folder in AddOns can be deleted.")
        elseif HealBot_Globals.DebugOut then
            local t,l=HealBot_Util_GetTimeElapsed(1747100000, true)
            HealBot_AddDebug("The HealBot_Options folder in AddOns can be deleted in "..t..l)
        end
    end
    if HealBot_Timers_luVars["oldDataExists"] then
        if GetServerTime() >= 1748300000 then
            HealBot_AddChat("=== Please Note ===")
            HealBot_AddChat("The HealBot_Data folder in AddOns can be deleted.")
            HealBot_AddChat("IMPORTANT: Before deleting HealBot_Data, logon all characters that use HealBot to allow copying saves variables.")
        elseif HealBot_Globals.DebugOut then
            local t,l=HealBot_Util_GetTimeElapsed(1748300000, true)
            HealBot_AddDebug("The HealBot_Data folder in AddOns can be deleted in "..t..l)
        end
    end
end

function HealBot_Timers_LastLoad()
      --HealBot_setCall("HealBot_Timers_LastLoad")
    HealBot_Globals.LAG=HealBot_Globals.LAG+0.1
    HealBot_Options_ObjectsEnableDisable("HealBot_FrameStickyOffsetHorizontal",false)
    HealBot_Options_ObjectsEnableDisable("HealBot_FrameStickyOffsetVertical",false)
    HealBot_Options_ObjectsEnableDisable("HealBot_Options_GroupPetsByFive",false)
    HealBot_Options_ObjectsEnableDisable("HealBot_Options_SelfPet",false)
    HealBot_Timers_InitSpells()
    HealBot_Init_Plugins()
    HealBot_Timers_Set("LAST","MountsPetsUse")
    HealBot_Timers_Set("PLAYER","InvChange")
    HealBot_Timers_Set("OOC","PartyUpdateCheckSkin")
    HealBot_Timers_Set("LAST","LoadComplete")
    HealBot_Timers_Set("SKINS","EmergHealthCol")
    HealBot_Timers_Set("AURA","ConfigClassHoT")
    HealBot_Timers_Set("AURA","ConfigDebuffs")
    HealBot_Timers_Set("LAST","CheckZone")
    HealBot_Timers_Set("LAST","UpdateButtonGlow")
    HealBot_Timers_Set("LAST","UpdateIconGlow")
    HealBot_Timers_Set("AURA","BuffTagNames")
    HealBot_Timers_Set("AURA","DebuffTagNames")
    HealBot_Timers_Set("SKINS","SetAdaptive")
    HealBot_Timers_Set("INIT","SetPlayerData")
    HealBot_Timers_Set("AURA","BuffsReset")
    HealBot_Timers_Set("AUX","ResetTextButtons")
    HealBot_Timers_Set("SKINS","TextSetTagInUse")
    HealBot_Timers_Set("OOC","EventsSetFrameUnits")
    HealBot_Timers_Set("LAST","MediaUpdateIndexes")
    HealBot_Timers_Set("LAST","OnLoadMessages")
    HealBot_Timers_Set("LAST","LastUpdate")
    HealBot_Timers_Set("LAST","MediaInitFonts",true)
    HealBot_Timers_Set("INIT","HealBotLoaded")
    HealBot_Timers_Set("LAST","CleanPermPrivateData",true,true)
    HealBot_Timers_Set("OOC","RemoveInvalidLoadouts",true,true)
    if not HealBot_Timers_luVars["HelpNotice"] then
        HealBot_Timers_Set("LAST","HealBotLoadedChat")
        HealBot_Timers_luVars["HelpNotice"]=true
    end
end

function HealBot_Timers_EnteringWorld2()
      --HealBot_setCall("HealBot_Timers_EnteringWorld2")
    HealBot_Timers_Set("OOC","RefreshPartyNextRecalcAll")
    HealBot_Timers_Set("LAST","CheckDC",true)
    if HealBot_Timers_luVars["DoneBuffReset"] then
        HealBot_Timers_Set("LAST","LastUpdate",true)
    end
end

function HealBot_Timers_EnteringWorld()
      --HealBot_setCall("HealBot_Timers_EnteringWorld")
    HealBot_Timers_Set("LAST","TargetFocusUpdate",true)
    HealBot_Timers_Set("LAST","ResetUnitStatus",true)
    HealBot_Timers_Set("SKINS","UpdateEmergBars",true)
    HealBot_Timers_Set("INIT","EnteringWorld2",true)
end

function HealBot_Timers_PostSkinChange()
    HealBot_Action_setAutoClose(true)
    HealBot_Timers_Set("SKINS","ResetGlobalDimming",true)
    HealBot_Timers_Set("SKINS","FluidFlashInUse",true)
    HealBot_Timers_Set("LAST","SetAutoClose",true)
end

function HealBot_Timer_Plugin_InitBinds()
      --HealBot_setCall("HealBot_Timer_Plugin_InitBinds")
    if HealBot_Action_retLuVars("pluginExtraButtons") then
        HealBot_Plugin_Options_InitBinds()
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
end

function HealBot_Timers_SendGuildVersion()
      --HealBot_setCall("HealBot_Timers_SendGuildVersion")
    HealBot_Comms_SendAddonMsg("S:"..HEALBOT_VERSION, 3)
end

function HealBot_Timer_UpdateGlow()
      --HealBot_setCall("HealBot_Timer_UpdateGlow")
    HealBot_Action_DisableGlow()
    HealBot_Timers_Set("SKINS","UpdateGlow")
end

function HealBot_Timer_UpdateIconGlow()
      --HealBot_setCall("HealBot_Timer_UpdateIconGlow")
    HealBot_Action_DisableGlowIcons()
    HealBot_Timers_Set("AURA","UpdateAllIcons")
    HealBot_Timers_Set("LAST","UpdateEmergIconGlow")
end

function HealBot_Timer_UpdateEmergIconGlow()
    HealBot_Update_DisableEmergButtonGlow()
    HealBot_Timers_Set("SKINS","UpdateEmergBars")
end

function HealBot_Timers_SetCurrentSkin()
      --HealBot_setCall("HealBot_Timers_SetCurrentSkin")
    HealBot_Options_Set_Current_Skin(Healbot_Config_Skins.Current_Skin)
    HealBot_Options_SetSkins()
    HealBot_Options_setAuxBars()
    HealBot_Update_AllAuxBars()
    HealBot_Action_ResetFrameAlias()
    HealBot_nextRecalcParty(0)
    HealBot_Timers_Set("AUX","ResetText")
    HealBot_Timers_Set("SKINS","SkinChangePluginUpdate")
end

function HealBot_Timers_InitExtraOptions()
      --HealBot_setCall("HealBot_Timers_InitExtraOptions")
    HealBot_Timers_Set("LAST","OptionsInitExtraTabs",true)
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
                        ["SetEnabledAttribs"]=HealBot_Update_SetEnabledAttribs,
                        ["SetEnemyAttribs"]=HealBot_Update_SetEnemyAttribs,
                        ["SetEmergAttribs"]=HealBot_Update_SetEmergAttribs,
                        ["PrepSetAllAttribs"]=HealBot_Action_PrepSetAllAttribs,
                        ["PrepSetEnabledAttribs"]=HealBot_Action_PrepSetEnabledAttribs,
                        ["PrepSetEnemyAttribs"]=HealBot_Action_PrepSetEnemyAttribs,
                        ["PrepSetEmergAttribs"]=HealBot_Action_PrepSetEmergAttribs,
                        ["InitBuffList"]=HealBot_Options_InitBuffList,
                        ["SpellsLoaded"]=HealBot_Timers_SpellsLoaded,
                        ["SpellsResetTabs"]=HealBot_Timers_SpellsResetTabs,
                        ["SeparateInHealsAbsorbs"]=HealBot_Text_setSeparateInHealsAbsorbs,
                        ["RegEvents"]=HealBot_Register_Events,
                        ["UnRegEvents"]=HealBot_UnRegister_Events,
                        ["ResetActiveUnitStatus"]=HealBot_Update_ResetActiveUnitStatus,
                        ["EnteringWorld"]=HealBot_Timers_EnteringWorld,
                        ["EnteringWorld2"]=HealBot_Timers_EnteringWorld2,
                        ["SetPlayerData"]=HealBot_SetPlayerData,
                        ["InitSpellsDefaults"]=HealBot_Init_Spells_Defaults,
                        ["UpdateLang"]=HealBot_Options_UpdateLang,
                        ["HealBotLoaded"]=HealBot_Loaded,
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
                        ["PlayerTargetChanged"]=HealBot_PlayerTargetChanged,
                        ["SetRestingState"]=HealBot_Timers_SetPlayerRestingState,
                        ["InitSmartCast"]=HealBot_InitSmartCast,
                        ["SetRangeSpells"]=HealBot_Range_SetSpells,
                        ["InvChange"]=HealBot_ItemIdsInBags,
                        ["InvReady"]=HealBot_InvReady,
                        ["ScanNextBag"]=HealBot_ItemIdsInNextBag,
                        ["EmoteOOM"]=HealBot_Timer_EmoteOOM,
                        ["SpecUpdate"]=HealBot_ResetOnSpecChange,
                        ["PlayerCheck"]=HealBot_PlayerCheck,
                        ["LoadProfile"]=HealBot_Options_LoadProfile,
                        ["SaveProfile"]=HealBot_Options_SaveProfile,
                        ["TalentsChanged"]=HealBot_Player_TalentsChanged,
                        ["CheckSpellsValid"]=HealBot_Options_SpellsCheckTextValid,
                    },
                    ["SKINS"]={
                        ["SkinsFormat"]=HealBot_Timers_SkinsFormat,
                        ["TextExtraCustomCols"]=HealBot_Text_setExtraCustomCols,
                        ["SetBarsTextColour"]=HealBot_Options_SetBarsTextColour,
                        ["TextUpdateNames"]=HealBot_Update_TextNames,
                        ["TextUpdateEnemyNames"]=HealBot_Update_TextNames_EnemyOnly,
                        ["TextUpdateHealth"]=HealBot_Update_TextHealth,
                        ["TextUpdateState"]=HealBot_Update_TextState,
                        ["TextPlayersAlpha"]=HealBot_Update_TextPlayersAlpha,
                        ["TextSetTagInUse"]=HealBot_Text_SetTagInUse,
                        ["TextUpdateAggro"]=HealBot_Update_TextAggro,
                        ["ClearSeparateInHealsAbsorbs"]=HealBot_Text_ClearSeparateInHealsAbsorbs,
                        ["ClearOverHeals"]=HealBot_Text_ClearOverHeals,
                        ["SkinColours"]=HealBot_SetSkinColours,
                        ["UpdateBackground"]=HealBot_Update_AllBackground,
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
                        ["FramesSetPointCheck"]=HealBot_Timers_FramesSetPointCheck,
                        ["UpdateTextButtons"]=HealBot_Update_TextButtons,
                        ["UpdateEmergBars"]=HealBot_Update_AllEmergBars,
                        ["PowerIndicator"]=HealBot_Timers_PowerIndicator,
                        ["UpdateAFK"]=HealBot_Update_AllStateIconAFK,
                        ["ZeroHiddenButtons"]=HealBot_Action_ZeroHiddenButtons,
                        ["SetAdaptive"]=HealBot_Action_setAdaptive,
                        ["SetActionIconsList"]=HealBot_Options_SetActionIconsList,
                        ["FramesActionIconsLists"]=HealBot_Options_FramesActionIconsLists,
                        ["ActionIconsPlayerNames"]=HealBot_Options_ActionIcons_PlayerNames,
                        ["ActionIconsStateChange"]=HealBot_ActionIcons_CheckStateChange,
                        ["UpdateActiveFrameIdx"]=HealBot_ActionIcons_UpdateActiveFrameIdx,
                        ["ActionIconsSetFontChange"]=HealBot_ActionIcons_setFontChange,
                        ["SelfCountTextUpdate"]=HealBot_ActionIcons_SelfCountTextUpdateAll,
                        ["SkinChangePluginUpdate"]=HealBot_Timers_SkinChangePluginUpdate,
                        ["ClearReset"]=HealBot_Action_ClearReset,
                        ["ResetSkinAllElements"]=HealBot_Action_ResetSkinAllElements,
                        ["ResetSkinAllButtons"]=HealBot_Action_ResetSkinAllButtons,
                        ["ResetUpdate"]=HealBot_Options_ResetUpdate,
                        ["VarsHasSkin"]=hbv_Skins_VarsHasSkin,
                        ["ResetUpdateCurrentTab"]=HealBot_Options_ResetUpdateCurrentTab,
                        ["UpdateTestButtons"]=HealBot_Action_UpdateTestButtons,
                        ["DisableGlobalDimming"]=HealBot_Action_DisableGlobalDimming,
                        ["UpdateGlow"]=HealBot_Action_UpdateGlow,
                        ["UpdateGlobalDimming"]=HealBot_Action_ResetOpacity,
                        ["CheckHideFrames"]=HealBot_Action_CheckHideFrames,
                        ["ResetGlobalDimming"]=HealBot_Action_ResetGlobalDimming,
                        ["OverShield"]=HealBot_Update_AllOverShields,
                        ["TagWithName"]=HealBot_Text_tagWithName,
                        ["ResetClassRoleIcons"]=HealBot_Media_setClassRoleIcons,
                        ["ResetRankIcons"]=HealBot_Media_setRankIcons,
                        ["ResetTargetIcons"]=HealBot_Media_setTargetIcons,
                        ["IconUpdAllTarget"]=HealBot_Update_RaidTargetReset,
                        ["PostChange"]=HealBot_Timers_PostSkinChange,
                    },
                    ["AUX"]={
                        ["BarFlashAlphaMinMax"]=HealBot_Options_AuxBarFlashAlphaMinMaxSet,
                        ["UpdateAllAuxByType"]=HealBot_Aux_UpdateAllAuxByType,
                        ["CheckAllAuxOverLays"]=HealBot_Update_AllAuxOverLays,
                        ["ResetBars"]=HealBot_Aux_resetBars,
                        ["ResetText"]=HealBot_Update_ResetAllAuxText,
                        ["TestUpdate"]=HealBot_Aux_TestUpdate,
                        ["ResetRange"]=HealBot_Update_AuxResetRange,
                        ["updAllAuxRangeBars"]=HealBot_Update_AllAuxRangeBars,
                        ["updAllAuxInRangeBars"]=HealBot_Update_AllAuxInRangeBars,
                        ["updAllAuxBuffBars"]=HealBot_Update_AllAuxBuffBars,
                        ["updAllAuxDebuffBars"]=HealBot_Update_AllAuxDebuffBars,
                        ["UpdateAllAuxPowerBars"]=HealBot_Update_AllAuxPowerBars,
                        ["UpdateAllAuxOverHealsBars"]=HealBot_Update_AllAuxOverHealsBars,
                        ["UpdateAllAuxInHealsBars"]=HealBot_Update_AllAuxInHealsBars,
                        ["UpdateAllAuxAbsorbBars"]=HealBot_Update_AllAuxAbsorbBars,
                        ["UpdateAllAuxTotalHealAbsorbBars"]=HealBot_Update_AllAuxTotalHealAbsorbBars,
                        ["UpdateAllAuxThreatBars"]=HealBot_Update_AllAuxThreatBars,
                        ["CheckInUse"]=HealBot_Options_CheckAuxInUse,
                        ["ResetTextButtons"]=HealBot_Update_AuxTextButtons,
                        ["SetTargetBar"]=HealBot_SetTargetBar,
                    },
                    ["AURA"]={
                        ["CheckUnits"]=HealBot_Update_AllAuras,
                        ["CheckBuffs"]=HealBot_Update_AllBuffs,
                        ["CheckDebuffs"]=HealBot_Update_AllDebuffs,
                        ["BuffThrottledUpdate"]=HealBot_BuffThrottleUpdate,
                        ["DebuffThrottledUpdate"]=HealBot_DebuffThrottleUpdate,
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
                        ["RemoveAllBuffIcons"]=HealBot_Update_RemoveAllBuffIcons,
                        ["RemoveAllDebuffIcons"]=HealBot_Update_RemoveAllDebuffIcons,
                        ["ClearAllBuffs"]=HealBot_Update_ClearAllBuffs,
                        ["ClearAllDebuffs"]=HealBot_Update_ClearAllDebuffs,
                        ["BuffBarColours"]=HealBot_SetBuffBarColours,
                        ["PlayerCheckExtended"]=HealBot_PlayerCheckExtended,
                        ["RemoveUnusedDebuffIcons"]=HealBot_Update_RemoveUnusedDebuffIcons,
                        ["RemoveUnusedBuffIcons"]=HealBot_Update_RemoveUnusedBuffIcons,
                        ["UpdateAllIcons"]=HealBot_Update_AllIcons,
                        ["RaidTargetUpdateAll"]=HealBot_Events_RaidTargetAll,
                        ["ResetClassIconTexture"]=HealBot_Update_ClassIconTexture,
                        ["UpdateAllBuffIcons"]=HealBot_Aura_UpdateAllBuffIcons,
                        ["UpdateAllDebuffIcons"]=HealBot_Aura_UpdateAllDebuffIcons,
                        ["UpdateActiveDebuffs"]=HealBot_Aura_UpdateActiveDebuffs,
                        ["UpdateAllExtraIcons"]=HealBot_Aura_UpdateAllExtraIcons,
                        ["InitAuraData"]=HealBot_Aura_InitData,
                        ["UpdateAllHotBars"]=HealBot_Update_AllHotBars,
                        ["CustomDebuffList"]=HealBot_Options_setCustomDebuffList,
                        ["CustomDebuffListPrep"]=HealBot_Options_prepCustomDebuffList,
                        ["CustomBuffList"]=HealBot_Options_setCustomBuffList,
                        ["CustomBuffListPrep"]=HealBot_Options_prepCustomBuffList,
                        ["ConfigDebuffs"]=HealBot_Aura_ConfigDebuffs,
                        ["BuffTagNames"]=HealBot_Aura_BuffTagNames,
                        ["DebuffTagNames"]=HealBot_Aura_DebuffTagNames,
                        ["IconUpdAllRank"]=HealBot_Update_AuraAllRank,
                        ["IconUpdHostile"]=HealBot_Update_AllStateIconHostile,
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
                        ["ResetUnitStatus"]=HealBot_Update_ResetUnitStatus,
                        ["ResetAllButtons"]=HealBot_Action_ResetAllButtons,
                        ["ResetAllButtonsRecalcAll"]=HealBot_Timer_ResetAllButtonsRecalcAll,
                        ["LowManaTrig"]=HealBot_Action_setLowManaTrig,
                        ["CheckLowMana"]=HealBot_Timers_CheckLowMana,
                        ["UpdateLowMana"]=HealBot_Update_LowMana,
                        ["EndAggro"]=HealBot_Update_EndAggro,
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
                        ["CheckDC"]=HealBot_Update_CheckDC,
                        ["MarkedCacheButtons"]=HealBot_Action_MarkedCacheButtons,
                        ["UpdateAllHealth"]=HealBot_Update_AllHealth,
                        ["UpdateAllUnitBars"]=HealBot_Update_AllUnitBars,
                        ["Reload"]=HealBot_Reload,
                        ["ReadyCheck"]=HealBot_ReadyCheck,
                        ["ReadyCheckClear"]=HealBot_Events_ReadyCheckClear,
                        ["LoadComplete"]=HealBot_Timers_LoadComplete,
                        ["GetVersion"]=HealBot_Timers_GetVersion,
                        ["GetGuildVersion"]=HealBot_Timers_GetGuildVersion,
                        ["SendVersion"]=HealBot_Timers_SendVersion,
                        ["SendGuildVersion"]=HealBot_Timers_SendGuildVersion,
                        ["CheckVersions"]=HealBot_CheckVersions,
                        ["OptionsInitExtraTabs"]=HealBot_Options_InitExtras,
                        ["TimerTurboOff"]=HealBot_Timers_TurboOff,
                        ["IconNotInCombat"]=HealBot_Update_AllStateIconNotInCombat,
                        ["PluginInitBinds"]=HealBot_Timer_Plugin_InitBinds,
                        ["InitBinds"]=HealBot_Options_InitBinds,
                        ["InitLoadSpells"]=HealBot_Timers_InitSpells,
                        ["SetAutoClose"]=HealBot_Action_setAutoClose,
                        ["CheckAutoClose"]=HealBot_Action_CheckAutoClose,
                        ["MountsPetsDalaran"]=HealBot_MountsPets_ClassicDalaranCheck,
                        ["LoadTips"]=HealBot_Options_LoadTips,
                        ["SetInHealAbsorbMax"]=HealBot_Aux_setInHealAbsorbMax,
                        ["UpdateButtonGlow"]=HealBot_Timer_UpdateGlow,
                        ["UpdateIconGlow"]=HealBot_Timer_UpdateIconGlow,
                        ["UpdateEmergIconGlow"]=HealBot_Timer_UpdateEmergIconGlow,
                        ["ClearClassGuidData"]=HealBot_Update_ClearClassGuidData,
                        ["DisableAllButtonGlow"]=HealBot_Action_DisableGlow,
                        ["DisableAllIconGlow"]=HealBot_Action_DisableGlowIcons,
                        ["TalentsLookupImproved"]=HealBot_Timers_TalentsLookupImproved,
                        ["TalentsLookupImprovedCallback"]=HealBot_Timers_TalentsLookupImprovedCallback,
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
                        ["GuildUpdate"]=HealBot_Comms_GuildUpdate,
                        ["ActionCheckInterval"]=HealBot_Action_UpdateCheckInterval,
                        ["DebugCheckInterval"]=HealBot_DebugCheckInterval,
                        ["UpdateCheckInterval"]=HealBot_UpdateCheckInterval,
                        ["MediaPluginChange"]=HealBot_Media_PluginChange,
                        ["RefreshEnemyUnits"]=HealBot_Update_ResetUnitsEnemyOnly,
                        ["SetDebuffTypes"]=HealBot_Options_setDebuffTypes,
                        ["NewCharInitSpells"]=HealBot_Init_Spells,
                        ["ResetSpells"]=HealBot_Reset_Spells,
                        ["ResetBuffs"]=HealBot_Reset_Buffs,
                        ["ResetCures"]=HealBot_Reset_Cures,
                        ["UpdateRefreshListFreq"]=HealBot_Update_RefreshListFreq,
                        ["PluginClearDown"]=HealBot_PluginClearDown,
                        ["ProcMarkedCacheButtons"]=HealBot_Action_ProcMarkedCacheButtons,
                        ["ActionIconsValidateItemsQueue"]=HealBot_ActionIcons_ValidateItemsQueue,
                        ["MediaUpdateIndexes"]=HealBot_Media_UpdateIndexes,
                        ["MediaInitFonts"]=HealBot_Media_InitFonts,
                        ["TimeoutShareRequest"]=HealBot_Share_TimeoutRequest,
                        ["ActionIconsUpdateTip"]=HealBot_ActionIcons_DoUpdateTip,
                        ["InitPlugins"]=HealBot_Init_Plugins,
                        ["CleanPermPrivateData"]=HealBot_Panel_CleanPermPrivateData,
                        ["PrivateListUpdate"]=HealBot_Panel_PrivateListUpdate,
                        ["OnLoadMessages"]=HealBot_Timers_OnLoadMessages,
                        ["PluginTweaksRefresh"]=HealBot_Timers_PluginTweaks_Refresh,
                        ["ExtraBuffsTabInvUp"]=HealBot_Options_BuffsExtraBuffsTabInvUpdate,
                        ["LastLoad"]=HealBot_Timers_LastLoad,
                        ["LastUpdate"]=HealBot_Timers_LastUpdate,
                    },
                    ["OOC"]={
                        ["FullReload"]=HealBot_FullReload,
                        ["EnableHealBot"]=HealBot_Timers_EnableHealBot,
                        ["DisableHealBot"]=HealBot_Timers_DisableHealBot,
                        ["TogglePartyFrames"]=HealBot_Timer_TogglePartyFrames,
                        ["ToggleFocusFrame"]=HealBot_Timer_ToggleFocusFrame,
                        ["ToggleMiniBossFrames"]=HealBot_Timer_ToggleMiniBossFrames,
                        ["ToggleRaidFrames"]=HealBot_Timer_ToggleRaidFrames,
                        ["ProcessRefreshTypes"]=HealBot_ProcessRefreshTypes,
                        ["CheckFrameSetPoint"]=HealBot_Action_CheckFrameSetPoint,
                        ["ModKey"]=HealBot_Action_ModKey,
                        ["RegisterForClicks"]=HealBot_Update_RegisterForClicks,
                        ["ActionIconsNumbers"]=HealBot_ActionIcons_UpdateNumIconsAll,
                        ["ActionIconsSetPoints"]=HealBot_ActionIcons_SetAllFramePoints,
                        ["ActionIconsValidateTarget"]=HealBot_ActionIcons_ValidateTargetAll,
                        ["ActionIconsValidateTargetIcons"]=HealBot_ActionIcons_ValidateTargetAllIconFrames,
                        ["ActionIconsValidateAbility"]=HealBot_ActionIcons_ValidateAbilityAll,
                        ["ActionIconsValidateItems"]=HealBot_ActionIcons_ValidateItems,
                        ["SaveSpellsProfile"]=HealBot_Options_SaveSpellsProfile,
                        ["SaveActionIconsProfile"]=HealBot_Options_SaveActionIconsProfile,
                        ["ActionIconsSpecChange"]=HealBot_ActionIcons_SpecChange,
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
                        ["RefreshPartyNextRecalcTarget"]=HealBot_Timers_nextRecalcTarget,
                        ["RefreshPartyNextRecalcFocus"]=HealBot_Timers_nextRecalcFocus,
                        ["BuffIdLookup"]=HealBot_Aura_BuffIdLookup,
                        ["DisableCheck"]=HealBot_Options_DisableCheck,
                        ["ToggleHealBot"]=HealBot_ToggleHealBotOOC,
                        ["NewSkinLoaded"]=HealBot_NewSkinLoaded,
                        ["ShowFramesOnSkinChange"]=HealBot_Action_ShowFramesOnSkinChange,
                        ["CheckHideUnusedFrames"]=HealBot_Action_HideUnusedFrames,
                        ["UpdateEnemyFrames"]=HealBot_Timers_updateEnemyFrames,
                        ["PlayersTargetsResetSkins"]=HealBot_Panel_PlayersTargetsResetSkins,
                        ["ValidateEnemyPlayerFrames"]=HealBot_Panel_validateEnemyPlayerFrames,
                        ["CheckPlayersTargets"]=HealBot_CheckPlayersTargets,
                        ["DeleteAllPlayerFrames"]=HealBot_Panel_PlayersTargetsDelAll,
                        ["FramesRefresh"]=HealBot_Timer_FramesRefresh,
                        ["RemoveInvalidLoadouts"]=HealBot_Action_RemoveInvalidLoadouts,
                        ["OrphanedCheck"]=HealBot_Skins_Clear_Orphaned,
                        ["UnusedFramesVarsCheck"]=HealBot_Skins_Clear_UnusedFramesVars,
                        ["UnusedVarsCheck"]=HealBot_Skins_Clear_UnusedVars,
                        ["EventsSetFrameUnits"]=HealBot_Events_SetFrameUnits,
                        ["PartyUpdateCheckSkin"]=HealBot_PartyUpdate_CheckSkin,
                        ["MarkedAttribsButtons"]=HealBot_Action_MarkedAttribsButtons,
                        ["ProcMarkedAttribsButtons"]=HealBot_Action_ProcMarkedAttribsButtons,
                        ["FrameStrata"]=HealBot_Action_SetStrata,
                    },
                   }

function HealBot_Timers_DoSet(cat,timer)
      --HealBot_setCall("HealBot_Timers_DoSet", nil, nil, nil, true)
    table.insert(HealBot_Timers[cat],timer)
    HealBot_setLuVars("HealBot_RunTimers", true)
    HealBot_Timers_Trottle[cat][timer]=HealBot_TimeNow+0.25
end

function HealBot_Timers_SetShortDelay(cat,timer)
    table.insert(HealBot_Timers_ShortDelay[cat],timer)
    HealBot_setLuVars("HealBot_RunTimers", true)
--    HealBot_Timers_Usage(cat, timer)
end

function HealBot_Timers_SetDelay(cat,timer)
    table.insert(HealBot_Timers_Delayed[cat],timer)
    HealBot_setLuVars("HealBot_RunDelayTimers", true)
end

function HealBot_Timers_SetLongDelay(cat,timer)
    table.insert(HealBot_Timers_LongDelay[cat],timer)
    HealBot_setLuVars("HealBot_RunLongDelayTimers", true)
end

function HealBot_Timers_Set(cat,timer,delay,longDelay)
      --HealBot_setCall("HealBot_Timers_Set", nil, nil, nil, true)
    if not HealBot_Timers_NoDups[cat][timer] then
        HealBot_Timers_NoDups[cat][timer]=true
        if delay then
            if longDelay then
                HealBot_Timers_SetLongDelay(cat,timer)
            else
                HealBot_Timers_SetDelay(cat,timer)
            end
        elseif HealBot_Timers_Trottle[cat][timer] then
            if HealBot_Timers_Trottle[cat][timer]>HealBot_TimeNow then
                HealBot_Timers_SetShortDelay(cat,timer)
            else
                HealBot_Timers_DoSet(cat,timer)
            end
        else
            HealBot_Timers_DoSet(cat,timer)
        end
    end
end


function HealBot_Timers_PluginsSet(tId)
      --HealBot_setCall("HealBot_Timers_PluginsSet")
    if tId == 1 then
        HealBot_Timers_Set("OOC","RefreshPartyNextRecalcPlayers",true)
    elseif tId == 2 then
        HealBot_Timers_Set("AURA","CheckUnits",true)
    elseif tId == 3 then
        HealBot_Timers_Set("INIT","PrepSetAllAttribs",true)
    elseif tId == 4 then
        HealBot_Timers_Set("LAST","InitBinds",true)
    elseif tId == 5 then
        HealBot_Timers_Set("AURA","ResetBuffCache",true)
    elseif tId == 6 then
        HealBot_Timers_Set("AURA","ResetDebuffCache",true)
    elseif tId == 7 then
        HealBot_Timers_Set("LAST","SetInHealAbsorbMax",true)
    elseif tId == 8 then
        HealBot_Timers_Set("LAST","MediaPluginChange",true)
    elseif tId == 9 then
        HealBot_Timers_Set("LAST","InitPlugins",true)
    elseif tId == 10 then
        HealBot_Timers_Set("LAST","PrivateListUpdate",true)
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
 --if HealBot_retLuVars("TestBarsOn") then HealBot_AddDebug("RunTimer "..timer) end
    else
        NoCallsInx=cat..":"..timer
        HealBot_AddDebug(HEALBOT_HEALBOT .. " " .. _G["ORANGE_FONT_COLOR_CODE"] .. "ERROR: Timer " .._G["FONT_COLOR_CODE_CLOSE"] .. _G["YELLOW_FONT_COLOR_CODE"] .. NoCallsInx  .._G["FONT_COLOR_CODE_CLOSE"].. _G["ORANGE_FONT_COLOR_CODE"] .." not found.")
        HealBot_AddDebug(HEALBOT_HEALBOT .. " " .. _G["ORANGE_FONT_COLOR_CODE"] .. " ERROR: Timer " .._G["FONT_COLOR_CODE_CLOSE"] .. _G["YELLOW_FONT_COLOR_CODE"] .. NoCallsInx  .._G["FONT_COLOR_CODE_CLOSE"].. _G["ORANGE_FONT_COLOR_CODE"] .." not found.","Timers",true)
    end
    --if HealBot_Globals.DebugOut then HealBot_Timers_Usage(cat, timer) end
end

function HealBot_Timers_ProcLongDelay()
    if HealBot_Timers_LongDelay["INIT"][1] then
        HealBot_Timers_SetDelay("INIT", HealBot_Timers_LongDelay["INIT"][1])
        table.remove(HealBot_Timers_LongDelay["INIT"],1)
    elseif HealBot_Timers_LongDelay["RESET"][1] then
        HealBot_Timers_SetDelay("RESET", HealBot_Timers_LongDelay["RESET"][1])
        table.remove(HealBot_Timers_LongDelay["RESET"],1)
    elseif HealBot_Timers_LongDelay["PLAYER"][1] then
        HealBot_Timers_SetDelay("PLAYER", HealBot_Timers_LongDelay["PLAYER"][1])
        table.remove(HealBot_Timers_LongDelay["PLAYER"],1)
    elseif HealBot_Timers_LongDelay["SKINS"][1] then
        HealBot_Timers_SetDelay("SKINS", HealBot_Timers_LongDelay["SKINS"][1])
        table.remove(HealBot_Timers_LongDelay["SKINS"],1)
    elseif HealBot_Timers_LongDelay["AUX"][1] then
        HealBot_Timers_SetDelay("AUX", HealBot_Timers_LongDelay["AUX"][1])
        table.remove(HealBot_Timers_LongDelay["AUX"],1)
    elseif HealBot_Timers_LongDelay["AURA"][1] then
        HealBot_Timers_SetDelay("AURA", HealBot_Timers_LongDelay["AURA"][1])
        table.remove(HealBot_Timers_LongDelay["AURA"],1)
    elseif HealBot_Timers_LongDelay["CHAT"][1] then
        HealBot_Timers_SetDelay("CHAT", HealBot_Timers_LongDelay["CHAT"][1])
        table.remove(HealBot_Timers_LongDelay["CHAT"],1)
    elseif HealBot_Timers_LongDelay["LAST"][1] then
        HealBot_Timers_SetDelay("LAST", HealBot_Timers_LongDelay["LAST"][1])
        table.remove(HealBot_Timers_LongDelay["LAST"],1)
    elseif not HealBot_Data["UILOCK"] and HealBot_Timers_LongDelay["OOC"][1] then
        HealBot_Timers_SetDelay("OOC", HealBot_Timers_LongDelay["OOC"][1])
        table.remove(HealBot_Timers_LongDelay["OOC"],1)
    else
        HealBot_setLuVars("HealBot_RunLongDelayTimers", false)
    end
end

function HealBot_Timers_ProcDelayed()
    if HealBot_Timers_Delayed["INIT"][1] then
        HealBot_Timers_DoSet("INIT", HealBot_Timers_Delayed["INIT"][1])
        table.remove(HealBot_Timers_Delayed["INIT"],1)
    elseif HealBot_Timers_Delayed["RESET"][1] then
        HealBot_Timers_DoSet("RESET", HealBot_Timers_Delayed["RESET"][1])
        table.remove(HealBot_Timers_Delayed["RESET"],1)
    elseif HealBot_Timers_Delayed["PLAYER"][1] then
        HealBot_Timers_DoSet("PLAYER", HealBot_Timers_Delayed["PLAYER"][1])
        table.remove(HealBot_Timers_Delayed["PLAYER"],1)
    elseif HealBot_Timers_Delayed["SKINS"][1] then
        HealBot_Timers_DoSet("SKINS", HealBot_Timers_Delayed["SKINS"][1])
        table.remove(HealBot_Timers_Delayed["SKINS"],1)
    elseif HealBot_Timers_Delayed["AUX"][1] then
        HealBot_Timers_DoSet("AUX", HealBot_Timers_Delayed["AUX"][1])
        table.remove(HealBot_Timers_Delayed["AUX"],1)
    elseif HealBot_Timers_Delayed["AURA"][1] then
        HealBot_Timers_DoSet("AURA", HealBot_Timers_Delayed["AURA"][1])
        table.remove(HealBot_Timers_Delayed["AURA"],1)
    elseif HealBot_Timers_Delayed["CHAT"][1] then
        HealBot_Timers_DoSet("CHAT", HealBot_Timers_Delayed["CHAT"][1])
        table.remove(HealBot_Timers_Delayed["CHAT"],1)
    elseif HealBot_Timers_Delayed["LAST"][1] then
        HealBot_Timers_DoSet("LAST", HealBot_Timers_Delayed["LAST"][1])
        table.remove(HealBot_Timers_Delayed["LAST"],1)
    elseif not HealBot_Data["UILOCK"] and HealBot_Timers_Delayed["OOC"][1] then
        HealBot_Timers_DoSet("OOC", HealBot_Timers_Delayed["OOC"][1])
        table.remove(HealBot_Timers_Delayed["OOC"],1)
    else
        HealBot_setLuVars("HealBot_RunDelayTimers", false)
    end
end

function HealBot_Timers_ProcShortDelay()
    if HealBot_Timers_ShortDelay["INIT"][1] then
        HealBot_Timers_RunTimer("INIT", HealBot_Timers_ShortDelay["INIT"][1])
        table.remove(HealBot_Timers_ShortDelay["INIT"],1)
    elseif HealBot_Timers_ShortDelay["RESET"][1] then
        HealBot_Timers_RunTimer("RESET", HealBot_Timers_ShortDelay["RESET"][1])
        table.remove(HealBot_Timers_ShortDelay["RESET"],1)
    elseif HealBot_Timers_ShortDelay["PLAYER"][1] then
        HealBot_Timers_RunTimer("PLAYER", HealBot_Timers_ShortDelay["PLAYER"][1])
        table.remove(HealBot_Timers_ShortDelay["PLAYER"],1)
    elseif HealBot_Timers_ShortDelay["SKINS"][1] then
        HealBot_Timers_RunTimer("SKINS", HealBot_Timers_ShortDelay["SKINS"][1])
        table.remove(HealBot_Timers_ShortDelay["SKINS"],1)
    elseif HealBot_Timers_ShortDelay["AUX"][1] then
        HealBot_Timers_RunTimer("AUX", HealBot_Timers_ShortDelay["AUX"][1])
        table.remove(HealBot_Timers_ShortDelay["AUX"],1)
    elseif HealBot_Timers_ShortDelay["AURA"][1] then
        HealBot_Timers_RunTimer("AURA", HealBot_Timers_ShortDelay["AURA"][1])
        table.remove(HealBot_Timers_ShortDelay["AURA"],1)
    elseif HealBot_Timers_ShortDelay["CHAT"][1] then
        HealBot_Timers_RunTimer("CHAT", HealBot_Timers_ShortDelay["CHAT"][1])
        table.remove(HealBot_Timers_ShortDelay["CHAT"],1)
    elseif HealBot_Timers_ShortDelay["LAST"][1] then
        HealBot_Timers_RunTimer("LAST", HealBot_Timers_ShortDelay["LAST"][1])
        table.remove(HealBot_Timers_ShortDelay["LAST"],1)
    elseif not HealBot_Data["UILOCK"] and HealBot_Timers_ShortDelay["OOC"][1] then
        HealBot_Timers_RunTimer("OOC", HealBot_Timers_ShortDelay["OOC"][1])
        table.remove(HealBot_Timers_ShortDelay["OOC"],1)
    else
        return false
    end
    return true
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
    elseif not HealBot_Timers_ProcShortDelay() then
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
