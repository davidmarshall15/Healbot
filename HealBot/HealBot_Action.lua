local HealBot_ButtonSeq={[0]=1,[1]=500}
local HealBot_Action_ActiveButton={}
HealBot_Action_ActiveButton.id=0
HealBot_Action_ActiveButton.lastid=0
local HealBot_AlwaysEnabled={}
local HealBot_pcClass={}
local HealBot_AutoCloseFrame={[1]=1,[2]=1,[3]=1,[4]=1,[5]=1,[6]=1,[7]=1,[8]=1,[9]=1,[10]=1}
local lGlow=HealBot_Libs_LibGlow()
local HealBot_PluginUpdate_TimeToLive={}
local grpFrame={}
local grpFrameBar={}
local grpFrameText={}
local grpFrameStickyInd={}
local xButton, pButton, aButton=nil, nil, nil
local HealBot_Keys_List={"","Shift","Ctrl","Alt","Alt-Shift","Ctrl-Shift","Alt-Ctrl","Alt-Ctrl-Shift"}
local hbAttribsMinReset={}
local hbAttribsFramesMinReset={}
local HB_button,HB_prefix=nil,nil
local showHBmenu=nil
local hbMarkedAttribButtons={}
local hbTrackAttribButtons={}
local HealBot_Action_Private_Button={}
local HealBot_Action_Pet_Button={}
local HealBot_Action_Vehicle_Button={}
local HealBot_Action_Enemy_Button={}
local HealBot_Action_PrivateTarget_Button={}
local HealBot_Action_UnitTarget_Button={}
local HealBot_Action_Extra_Button={}
local HealBot_Action_Unit_Button={}
local hbUpdateFramesOpacity={}
local _
local HealBot_Action_AuxAssigns={}
HealBot_Action_AuxAssigns["NameOverlayHighlight"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
HealBot_Action_AuxAssigns["HealthOverlayHighlight"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}

local hbAlert="ALERTOC"
local hbAdaptive={["Plugin"]=true,["RecentHeals"]=false,["Threat"]=false,["Debuffs"]=true,["Aggro"]=true,["Highlight"]=false,
                  ["Target"]=false,["OOR"]=false,["Buffs"]=true,["Overheals"]=false,["Absorbs"]=false}
local hbAdaptiveOrder={[1]="Plugin",[2]="RecentHeals",[3]="Debuffs",[4]="Aggro",[5]="Threat",[6]="Highlight",
                       [7]="Target",[8]="OOR",[9]="Buffs",[10]="Overheals",[11]="Absorbs",[12]="None"}
local hbAdaptiveOrderName={["Plugin"]=1,["RecentHeals"]=2,["Debuffs"]=3,["Aggro"]=4,["Threat"]=5,
                          ["Highlight"]=6,["Target"]=7,["OOR"]=8,["Buffs"]=9,["Overheals"]=10,["Absorbs"]=11}
local hbAdaptiveCol={["RecentHeals"]={R=0.1,G=1,B=0.2},["Threat"]={R=1,G=0.49,B=0.04},
                     ["Aggro"]={R=1,G=0,B=0},["Highlight"]={R=0.4,G=1,B=1},
                     ["Target"]={R=1,G=0.9,B=0.2},["OOR"]={R=0,G=0,B=0},
                     ["Overheals"]={R=1,G=0.2,B=0.2},["Absorbs"]={R=1,G=1,B=1}}

local HealBot_Action_luVars={}
HealBot_Action_luVars["FrameMoving"]=false
HealBot_Action_luVars["UnitPowerMax"]=3
HealBot_Action_luVars["resetSkinTo"]=""
HealBot_Action_luVars["TestBarsOn"]=false
HealBot_Action_luVars["ShapeshiftForm"]=-1
HealBot_Action_luVars["FluidInUse"]=false
HealBot_Action_luVars["FrameInitDone"]=false
HealBot_Action_luVars["pluginExtraButtons"]=false
HealBot_Action_luVars["pluginRequests"]=false
HealBot_Action_luVars["pluginAuraWatch"]=false
HealBot_Action_luVars["pluginHealthWatch"]=false
HealBot_Action_luVars["pluginManaWatch"]=false
HealBot_Action_luVars["showTestPowerIndicator"]=0
HealBot_Action_luVars["FocusGroups"]=false
HealBot_Action_luVars["FocusGroupDimming"]=2
HealBot_Action_luVars["GlobalDimming"]=0
HealBot_Action_luVars["HotBarDimming"]=4
HealBot_Action_luVars["HotBarsHealth"]=0
HealBot_Action_luVars["FluidBarSmoothAdj"]=5
HealBot_Action_luVars["FluidBarFreq"]=0.025
HealBot_Action_luVars["ScreenHeight"]=0
HealBot_Action_luVars["ScreenWidth"]=0
HealBot_Action_luVars["CurrentModKey"]=""
HealBot_Action_luVars["FGroups"]={[1]=true,[2]=true,[3]=true,[4]=true,[5]=true,[6]=true,[7]=true,[8]=true}
HealBot_Action_luVars["HazardFreq"]=0.3
HealBot_Action_luVars["HazardMinAlpha"]=0.25
HealBot_Action_luVars["PreCacheBars"]=0
HealBot_Action_luVars["HealthDropTime"]=3
HealBot_Action_luVars["deadCheckInterval"]=1
HealBot_Action_luVars["NumAuxOutlines"]=0
HealBot_Action_luVars["BarGlowSize"]=3
HealBot_Action_luVars["IconGlowSize"]=2
HealBot_Action_luVars["buttonFrameLevel"]=20
HealBot_Action_luVars["GroupBarsDimming"]=0
HealBot_Action_luVars["GroupBarsHealth"]=500
HealBot_Action_luVars["GroupBarsNumUnits"]=3
HealBot_Action_luVars["GroupBarsRange"]=-1
HealBot_Action_luVars["GroupBarsEnabled"]=false
HealBot_Action_luVars["ActiveFrameID"]=0
HealBot_Action_luVars["LastResetFrame"]=0
HealBot_Action_luVars["ResetFrame"]=0

function HealBot_Action_setLuVars(vName, vValue)
      --HealBot_setCall("HealBot_Action_setLuVars - "..vName)
    HealBot_Action_luVars[vName]=vValue
end

function HealBot_Action_retLuVars(vName)
      --HealBot_setCall("HealBot_Action_retLuVars - "..vName)
    return HealBot_Action_luVars[vName]
end

function HealBot_Action_setAlertState()
    if HealBot_Data["UILOCK"] then
        hbAlert="ALERTIC"
    else
        hbAlert="ALERTOC"
    end
end

function HealBot_Action_retComboKeysList()
      --HealBot_setCall("HealBot_Action_retComboKeysList")
    return HealBot_Keys_List
end

function HealBot_Action_setAuxAssigns(vName, frame, vValue)
      --HealBot_setCall("HealBot_Action_setAuxAssigns")
    HealBot_Action_AuxAssigns[vName][frame]=vValue
end

function HealBot_Action_UpdateCheckInterval()
    HealBot_Action_luVars["deadCheckInterval"]=HealBot_Util_PerfVal2(850)
    if HealBot_Action_luVars["deadCheckInterval"]<0.75 then HealBot_Action_luVars["deadCheckInterval"]=0.75 end
    HealBot_Debug_PerfUpdate("deadInt", HealBot_Action_luVars["deadCheckInterval"])
    HealBot_Aura_UpdateCheckInterval()
end

function HealBot_Action_setAdaptive()
      --HealBot_setCall("HealBot_Action_setAdaptive")
    if HealBot_Globals.OverrideColours["USEADAPTIVE"] == 2 then 
        hbAdaptive=HealBot_Options_copyTable(HealBot_Globals.OverrideAdaptive)
        hbAdaptiveOrder=HealBot_Options_copyTable(HealBot_Globals.OverrideAdaptiveOrder)
        hbAdaptiveCol=HealBot_Options_copyTable(HealBot_Globals.OverrideAdaptiveCol)
    else
        hbAdaptive["Plugin"]=hbv_Skins_GetBoolean("Adaptive", "Plugin")
        hbAdaptive["RecentHeals"]=hbv_Skins_GetBoolean("Adaptive", "RecentHeals")
        hbAdaptive["Threat"]=hbv_Skins_GetBoolean("Adaptive", "Threat")
        hbAdaptive["Debuffs"]=hbv_Skins_GetBoolean("Adaptive", "Debuffs")
        hbAdaptive["Aggro"]=hbv_Skins_GetBoolean("Adaptive", "Aggro")
        hbAdaptive["Highlight"]=hbv_Skins_GetBoolean("Adaptive", "Highlight")
        hbAdaptive["Target"]=hbv_Skins_GetBoolean("Adaptive", "Target")
        hbAdaptive["OOR"]=hbv_Skins_GetBoolean("Adaptive", "OOR")
        hbAdaptive["Buffs"]=hbv_Skins_GetBoolean("Adaptive", "Buffs")
        hbAdaptive["Overheals"]=hbv_Skins_GetBoolean("Adaptive", "Overheals")
        hbAdaptive["Absorbs"]=hbv_Skins_GetBoolean("Adaptive", "Absorbs")
        hbAdaptiveOrder=HealBot_Options_copyTable(Healbot_Config_Skins.AdaptiveOrder[Healbot_Config_Skins.Current_Skin])
        hbAdaptiveCol["RecentHeals"].R=hbv_Skins_GetColVar("AdaptiveCol", "RecentHeals", "R")
        hbAdaptiveCol["RecentHeals"].G=hbv_Skins_GetColVar("AdaptiveCol", "RecentHeals", "G")
        hbAdaptiveCol["RecentHeals"].B=hbv_Skins_GetColVar("AdaptiveCol", "RecentHeals", "B")
        hbAdaptiveCol["Threat"].R=hbv_Skins_GetColVar("AdaptiveCol", "Threat", "R")
        hbAdaptiveCol["Threat"].G=hbv_Skins_GetColVar("AdaptiveCol", "Threat", "G")
        hbAdaptiveCol["Threat"].B=hbv_Skins_GetColVar("AdaptiveCol", "Threat", "B")
        hbAdaptiveCol["Aggro"].R=hbv_Skins_GetColVar("AdaptiveCol", "Aggro", "R")
        hbAdaptiveCol["Aggro"].G=hbv_Skins_GetColVar("AdaptiveCol", "Aggro", "G")
        hbAdaptiveCol["Aggro"].B=hbv_Skins_GetColVar("AdaptiveCol", "Aggro", "B")
        hbAdaptiveCol["Highlight"].R=hbv_Skins_GetColVar("AdaptiveCol", "Highlight", "R")
        hbAdaptiveCol["Highlight"].G=hbv_Skins_GetColVar("AdaptiveCol", "Highlight", "G")
        hbAdaptiveCol["Highlight"].B=hbv_Skins_GetColVar("AdaptiveCol", "Highlight", "B")
        hbAdaptiveCol["Target"].R=hbv_Skins_GetColVar("AdaptiveCol", "Target", "R")
        hbAdaptiveCol["Target"].G=hbv_Skins_GetColVar("AdaptiveCol", "Target", "G")
        hbAdaptiveCol["Target"].B=hbv_Skins_GetColVar("AdaptiveCol", "Target", "B")
        hbAdaptiveCol["OOR"].R=hbv_Skins_GetColVar("AdaptiveCol", "OOR", "R")
        hbAdaptiveCol["OOR"].G=hbv_Skins_GetColVar("AdaptiveCol", "OOR", "G")
        hbAdaptiveCol["OOR"].B=hbv_Skins_GetColVar("AdaptiveCol", "OOR", "B")
        hbAdaptiveCol["Overheals"].R=hbv_Skins_GetColVar("AdaptiveCol", "Overheals", "R")
        hbAdaptiveCol["Overheals"].G=hbv_Skins_GetColVar("AdaptiveCol", "Overheals", "G")
        hbAdaptiveCol["Overheals"].B=hbv_Skins_GetColVar("AdaptiveCol", "Overheals", "B")
        hbAdaptiveCol["Absorbs"].R=hbv_Skins_GetColVar("AdaptiveCol", "Absorbs", "R")
        hbAdaptiveCol["Absorbs"].G=hbv_Skins_GetColVar("AdaptiveCol", "Absorbs", "G")
        hbAdaptiveCol["Absorbs"].B=hbv_Skins_GetColVar("AdaptiveCol", "Absorbs", "B")
    end
    hbAdaptiveOrder[12]="None"
    for x=1,11 do
        hbAdaptiveOrderName[hbAdaptiveOrder[x]]=x
    end
    HealBot_Aux_setAdaptiveCols()
    HealBot_ActionIcons_setBorderHighlightCol()
end

function HealBot_Action_AdaptiveDownButton(button, id)
      --HealBot_setCall("HealBot_Action_AdaptiveDownButton", button)
    local tmpId=button.adaptive[id]
    button.adaptive[id]=button.adaptive[id+1]
    button.adaptive[id+1]=tmpId
    HealBot_Action_setAdaptive()
end

function HealBot_Action_AdaptiveUpButton(button, id)
      --HealBot_setCall("HealBot_Action_AdaptiveUpButton", button)
    local tmpId=button.adaptive[id]
    button.adaptive[id]=button.adaptive[id-1]
    button.adaptive[id-1]=tmpId
    HealBot_Action_setAdaptive()
end

function HealBot_Action_AdaptiveSetNextActive(button, start)
      --HealBot_setCall("HealBot_Action_AdaptiveSetNextActive", button)
    if button.status.current>HealBot_Unit_Status["RES"] then
        button.adaptive.current=12
    else
        for x=start,11 do
            if button.adaptive[x] then
                button.adaptive.current=x
                break
            end
        end
    end
end

function HealBot_Action_AdaptiveNextActive(button, cType, upCol)
      --HealBot_setCall("HealBot_Action_AdaptiveNextActive", button)
    if button.adaptive[cType] then 
        button.adaptive[cType]=false
        if button.adaptive.current == cType then
            HealBot_Action_AdaptiveSetNextActive(button, button.adaptive.current)
            if not button.adaptive[button.adaptive.current] then button.adaptive.current=12 end
            if upCol then HealBot_Action_UpdateBackground(button) end
        end
    end
end

local hbCustomClassCols={["DEAT"]={}, ["DEMO"]={}, ["DRUI"]={}, ["EVOK"]={}, ["HUNT"]={}, ["MAGE"]={}, ["MONK"]={}, ["PALA"]={}, ["PRIE"]={}, ["ROGU"]={}, ["SHAM"]={}, ["WARL"]={}, ["WARR"]={}}
function HealBot_Action_SetCustomClassCols(useOverride)
      --HealBot_setCall("HealBot_Action_SetCustomClassCols")
    hbCustomClassCols["DEAT"].r, hbCustomClassCols["DEAT"].g, hbCustomClassCols["DEAT"].b=hbv_Skins_GetClassCol("DEAT", useOverride)
    hbCustomClassCols["DEMO"].r, hbCustomClassCols["DEMO"].g, hbCustomClassCols["DEMO"].b=hbv_Skins_GetClassCol("DEMO", useOverride)
    hbCustomClassCols["DRUI"].r, hbCustomClassCols["DRUI"].g, hbCustomClassCols["DRUI"].b=hbv_Skins_GetClassCol("DRUI", useOverride)
    hbCustomClassCols["EVOK"].r, hbCustomClassCols["EVOK"].g, hbCustomClassCols["EVOK"].b=hbv_Skins_GetClassCol("EVOK", useOverride)
    hbCustomClassCols["HUNT"].r, hbCustomClassCols["HUNT"].g, hbCustomClassCols["HUNT"].b=hbv_Skins_GetClassCol("HUNT", useOverride)
    hbCustomClassCols["MAGE"].r, hbCustomClassCols["MAGE"].g, hbCustomClassCols["MAGE"].b=hbv_Skins_GetClassCol("MAGE", useOverride)
    hbCustomClassCols["MONK"].r, hbCustomClassCols["MONK"].g, hbCustomClassCols["MONK"].b=hbv_Skins_GetClassCol("MONK", useOverride)
    hbCustomClassCols["PALA"].r, hbCustomClassCols["PALA"].g, hbCustomClassCols["PALA"].b=hbv_Skins_GetClassCol("PALA", useOverride)
    hbCustomClassCols["PRIE"].r, hbCustomClassCols["PRIE"].g, hbCustomClassCols["PRIE"].b=hbv_Skins_GetClassCol("PRIE", useOverride)
    hbCustomClassCols["ROGU"].r, hbCustomClassCols["ROGU"].g, hbCustomClassCols["ROGU"].b=hbv_Skins_GetClassCol("ROGU", useOverride)
    hbCustomClassCols["SHAM"].r, hbCustomClassCols["SHAM"].g, hbCustomClassCols["SHAM"].b=hbv_Skins_GetClassCol("SHAM", useOverride)
    hbCustomClassCols["WARL"].r, hbCustomClassCols["WARL"].g, hbCustomClassCols["WARL"].b=hbv_Skins_GetClassCol("WARL", useOverride)
    hbCustomClassCols["WARR"].r, hbCustomClassCols["WARR"].g, hbCustomClassCols["WARR"].b=hbv_Skins_GetClassCol("WARR", useOverride)
end

local hbCustomRoleCols={["TANK"]={}, ["HEALER"]={}, ["DAMAGER"]={}}
function HealBot_Action_SetCustomRoleCols()
      --HealBot_setCall("HealBot_Action_SetCustomRoleCols")
    hbCustomRoleCols["TANK"].r,hbCustomRoleCols["TANK"].g, hbCustomRoleCols["TANK"].b=hbv_Skins_GetRoleCol("TANK", HealBot_Globals.OverrideColours["USEROLE"])
    hbCustomRoleCols["HEALER"].r,hbCustomRoleCols["HEALER"].g, hbCustomRoleCols["HEALER"].b=hbv_Skins_GetRoleCol("HEALER", HealBot_Globals.OverrideColours["USEROLE"])
    hbCustomRoleCols["DAMAGER"].r,hbCustomRoleCols["DAMAGER"].g, hbCustomRoleCols["DAMAGER"].b=hbv_Skins_GetRoleCol("DAMAGER", HealBot_Globals.OverrideColours["USEROLE"])
    HealBot_Aux_SetCustomRoleCols()
    HealBot_Text_SetCustomRoleCols()
	HealBot_Panel_SetCustomRoleCols()
end

local hbCustomPowerCols={["ENERGY"]={}, ["FOCUS"]={}, ["FURY"]={}, ["INSANITY"]={}, ["LUNAR_POWER"]={}, ["MAELSTROM"]={}, ["MANA"]={}, ["RAGE"]={}, ["RUNIC_POWER"]={}}
function HealBot_Action_SetCustomPowerCols()
      --HealBot_setCall("HealBot_Action_SetCustomPowerCols")
    hbCustomPowerCols["ENERGY"].r, hbCustomPowerCols["ENERGY"].g, hbCustomPowerCols["ENERGY"].b=hbv_Skins_GetPowerCol("ENERGY", HealBot_Globals.OverrideColours["USEPOWER"])
    hbCustomPowerCols["FOCUS"].r, hbCustomPowerCols["FOCUS"].g, hbCustomPowerCols["FOCUS"].b=hbv_Skins_GetPowerCol("FOCUS", HealBot_Globals.OverrideColours["USEPOWER"])
    hbCustomPowerCols["FURY"].r, hbCustomPowerCols["FURY"].g, hbCustomPowerCols["FURY"].b=hbv_Skins_GetPowerCol("FURY", HealBot_Globals.OverrideColours["USEPOWER"])
    hbCustomPowerCols["INSANITY"].r, hbCustomPowerCols["INSANITY"].g, hbCustomPowerCols["INSANITY"].b=hbv_Skins_GetPowerCol("INSANITY", HealBot_Globals.OverrideColours["USEPOWER"])
    hbCustomPowerCols["LUNAR_POWER"].r, hbCustomPowerCols["LUNAR_POWER"].g, hbCustomPowerCols["LUNAR_POWER"].b=hbv_Skins_GetPowerCol("LUNAR_POWER", HealBot_Globals.OverrideColours["USEPOWER"])
    hbCustomPowerCols["MAELSTROM"].r, hbCustomPowerCols["MAELSTROM"].g, hbCustomPowerCols["MAELSTROM"].b=hbv_Skins_GetPowerCol("MAELSTROM", HealBot_Globals.OverrideColours["USEPOWER"])
    hbCustomPowerCols["MANA"].r, hbCustomPowerCols["MANA"].g, hbCustomPowerCols["MANA"].b=hbv_Skins_GetPowerCol("MANA", HealBot_Globals.OverrideColours["USEPOWER"])
    hbCustomPowerCols["RAGE"].r, hbCustomPowerCols["RAGE"].g, hbCustomPowerCols["RAGE"].b=hbv_Skins_GetPowerCol("RAGE", HealBot_Globals.OverrideColours["USEPOWER"])
    hbCustomPowerCols["RUNIC_POWER"].r, hbCustomPowerCols["RUNIC_POWER"].g, hbCustomPowerCols["RUNIC_POWER"].b=hbv_Skins_GetPowerCol("RUNIC_POWER", HealBot_Globals.OverrideColours["USEPOWER"])
end


local sConcat={}
local tabconcat=table.concat
function HealBot_Action_Concat(elements)
      --HealBot_setCall("HealBot_Action_Concat", nil, nil, nil, true)
    return tabconcat(sConcat,"",1,elements)
end

function HealBot_Action_setpcClass(button)
      --HealBot_setCall("HealBot_Action_setpcClass", button)
    for j=1,5 do
        if HEALBOT_GAME_VERSION>3 and hbv_Skins_GetFrameBoolean("HealBar", "POWERCNT", j) then
            local prevHealBot_pcMax=HealBot_Action_luVars["UnitPowerMax"]
            if HealBot_Data["PCLASSTRIM"] == hbv_GetClass("En", HEALBOT_PALADIN) then
                HealBot_pcClass[j]=9
                HealBot_Action_luVars["UnitPowerMax"]=UnitPowerMax("player" , 9);
            elseif HealBot_Data["PCLASSTRIM"] == hbv_GetClass("En", HEALBOT_ROGUE) or HealBot_Data["PCLASSTRIM"] == hbv_GetClass("En", HEALBOT_DRUID) then
                HealBot_pcClass[j]=4
                HealBot_Action_luVars["UnitPowerMax"]=UnitPowerMax("player" , 4);
            elseif HealBot_Data["PCLASSTRIM"] == hbv_GetClass("En", HEALBOT_WARLOCK) then
                HealBot_pcClass[j]=7
                HealBot_Action_luVars["UnitPowerMax"]=UnitPowerMax("player" , 7);
            elseif HealBot_Data["PCLASSTRIM"] == hbv_GetClass("En", HEALBOT_MONK) then
                HealBot_pcClass[j]=12
                HealBot_Action_luVars["UnitPowerMax"]=UnitPowerMax("player" , 12);
            elseif HealBot_Data["PCLASSTRIM"] == hbv_GetClass("En", HEALBOT_EVOKER) then
                HealBot_pcClass[j]=19
                HealBot_Action_luVars["UnitPowerMax"]=UnitPowerMax("player" , 19);
            else
                HealBot_Action_luVars["UnitPowerMax"]=0
            end
            if prevHealBot_pcMax~=HealBot_Action_luVars["UnitPowerMax"] then
                if HealBot_Action_luVars["UnitPowerMax"] == 0 then
                    HealBot_pcClass[j]=false
                    HealBot_Action_ZeroPowerIndicators(button)
                else
                    button.skinreset=true
                    button.icon.reset=true
                    HealBot_Timers_Set("OOC","RefreshPartyNextRecalcPlayers",true)
                end
            end
        else
            HealBot_pcClass[j]=false
            HealBot_Action_ZeroPowerIndicators(button)
        end
    end
end

function HealBot_GetBandageType()
      --HealBot_setCall("HealBot_GetBandageType")
    local bandage=nil
    if HealBot_IsItemInBag(HEALBOT_HEAVY_SHROUDED_CLOTH_BANDAGE) then bandage=HEALBOT_HEAVY_SHROUDED_CLOTH_BANDAGE
    elseif HealBot_IsItemInBag(HEALBOT_SHROUDED_CLOTH_BANDAGE) then bandage=HEALBOT_SHROUDED_CLOTH_BANDAGE
    elseif HealBot_IsItemInBag(HEALBOT_TIDESPRAY_LINEN_BANDAGE) then bandage=HEALBOT_TIDESPRAY_LINEN_BANDAGE
    elseif HealBot_IsItemInBag(HEALBOT_DEEP_SEA_BANDAGE) then bandage=HEALBOT_DEEP_SEA_BANDAGE
    elseif HealBot_IsItemInBag(HEALBOT_SILKWEAVE_BANDAGE) then bandage=HEALBOT_SILKWEAVE_BANDAGE
    elseif HealBot_IsItemInBag(HEALBOT_ASHRAN_BANDAGE) then bandage=HEALBOT_ASHRAN_BANDAGE
    elseif HealBot_IsItemInBag(HEALBOT_HEAVY_WINDWOOL_BANDAGE) then bandage=HEALBOT_HEAVY_WINDWOOL_BANDAGE
    elseif HealBot_IsItemInBag(HEALBOT_WINDWOOL_BANDAGE) then bandage=HEALBOT_WINDWOOL_BANDAGE
    elseif HealBot_IsItemInBag(HEALBOT_DENSE_EMBERSILK_BANDAGE) then bandage=HEALBOT_DENSE_EMBERSILK_BANDAGE
    elseif HealBot_IsItemInBag(HEALBOT_HEAVY_EMBERSILK_BANDAGE) then bandage=HEALBOT_HEAVY_EMBERSILK_BANDAGE
    elseif HealBot_IsItemInBag(HEALBOT_EMBERSILK_BANDAGE) then bandage=HEALBOT_EMBERSILK_BANDAGE
    elseif HealBot_IsItemInBag(HEALBOT_HEAVY_FROSTWEAVE_BANDAGE) then bandage=HEALBOT_HEAVY_FROSTWEAVE_BANDAGE
    elseif HealBot_IsItemInBag(HEALBOT_FROSTWEAVE_BANDAGE) then bandage=HEALBOT_FROSTWEAVE_BANDAGE
    elseif HealBot_IsItemInBag(HEALBOT_HEAVY_NETHERWEAVE_BANDAGE) then bandage=HEALBOT_HEAVY_NETHERWEAVE_BANDAGE
    elseif HealBot_IsItemInBag(HEALBOT_NETHERWEAVE_BANDAGE) then bandage=HEALBOT_NETHERWEAVE_BANDAGE
    elseif HealBot_IsItemInBag(HEALBOT_HEAVY_RUNECLOTH_BANDAGE) then bandage=HEALBOT_HEAVY_RUNECLOTH_BANDAGE
    elseif HealBot_IsItemInBag(HEALBOT_RUNECLOTH_BANDAGE) then bandage=HEALBOT_RUNECLOTH_BANDAGE
    elseif HealBot_IsItemInBag(HEALBOT_HEAVY_MAGEWEAVE_BANDAGE) then bandage=HEALBOT_HEAVY_MAGEWEAVE_BANDAGE
    elseif HealBot_IsItemInBag(HEALBOT_MAGEWEAVE_BANDAGE) then bandage=HEALBOT_MAGEWEAVE_BANDAGE
    elseif HealBot_IsItemInBag(HEALBOT_HEAVY_SILK_BANDAGE) then bandage=HEALBOT_HEAVY_SILK_BANDAGE
    elseif HealBot_IsItemInBag(HEALBOT_SILK_BANDAGE) then bandage=HEALBOT_SILK_BANDAGE
    elseif HealBot_IsItemInBag(HEALBOT_HEAVY_WOOL_BANDAGE) then bandage=HEALBOT_HEAVY_WOOL_BANDAGE
    elseif HealBot_IsItemInBag(HEALBOT_WOOL_BANDAGE) then bandage=HEALBOT_WOOL_BANDAGE
    elseif HealBot_IsItemInBag(HEALBOT_HEAVY_LINEN_BANDAGE) then bandage=HEALBOT_HEAVY_LINEN_BANDAGE
    elseif HealBot_IsItemInBag(HEALBOT_LINEN_BANDAGE) then bandage=HEALBOT_LINEN_BANDAGE
    end
    return bandage
end

local HealBot_Fluid_AbsorbButtons={}
local HealBot_Fluid_EmergButtonsAlpha={}
local HealBot_Fluid_InHealButtons={}
local HealBot_Fluid_BarButtons={}
local HealBot_Fluid_BarHealthDropAlpha={}
local aufbButtonActive=false
local aufbBarValue,aufbSetValue=0,0


function HealBot_Action_setFluid_Aborbs_BarButtons(button)
      --HealBot_setCall("HealBot_Action_setFluid_Aborbs_BarButtons", button)
    HealBot_Fluid_AbsorbButtons[button.id]=button
    if not HealBot_Action_luVars["FluidBarInUse"] then HealBot_Action_UpdateFluidBars() end
end

function HealBot_Action_setFluid_InHeal_BarButtons(button)
      --HealBot_setCall("HealBot_Action_setFluid_InHeal_BarButtons", button)
    HealBot_Fluid_InHealButtons[button.id]=button
    if not HealBot_Action_luVars["FluidBarInUse"] then HealBot_Action_UpdateFluidBars() end
end

function HealBot_Action_setFluid_BarButtons(button)
      --HealBot_setCall("HealBot_Action_setFluid_BarButtons", button)
    HealBot_Fluid_BarButtons[button.id]=button
    if not HealBot_Action_luVars["FluidBarInUse"] then HealBot_Action_UpdateFluidBars() end
end

local hbSmooth=0
function HealBot_Action_UpdateFluidBars()
      --HealBot_setCall("HealBot_Action_UpdateFluidBars")
    HealBot_Action_luVars["FluidBarInUse"]=false
    for id,xButton in pairs(HealBot_Fluid_BarButtons) do
        aufbButtonActive=false
        if xButton.status.current<HealBot_Unit_Status["DEAD"] then
            aufbBarValue=xButton.gref["Bar"]:GetValue()
            if aufbBarValue>xButton.health.hpct then
                aufbSetValue=aufbBarValue-ceil((aufbBarValue-xButton.health.hpct)/HealBot_Action_luVars["FluidBarSmoothAdj"])
                if aufbSetValue<xButton.health.hpct then 
                    aufbSetValue=xButton.health.hpct
                else
                    aufbButtonActive=true
                end
                xButton.gref["Bar"]:SetValue(aufbSetValue)
            elseif aufbBarValue<xButton.health.hpct then
                aufbSetValue=aufbBarValue+ceil((xButton.health.hpct-aufbBarValue)/HealBot_Action_luVars["FluidBarSmoothAdj"])
                if aufbSetValue>xButton.health.hpct then 
                    aufbSetValue=xButton.health.hpct
                else
                    aufbButtonActive=true
                end
                xButton.gref["Bar"]:SetValue(aufbSetValue)
            end
        else
            xButton.gref["Bar"]:SetValue(0)
        end
        if not aufbButtonActive then
            HealBot_Fluid_BarButtons[id]=nil
        else
            HealBot_Action_luVars["FluidBarInUse"]=true
        end
    end
    
    for id,xButton in pairs(HealBot_Fluid_InHealButtons) do
        if xButton.status.current>HealBot_Unit_Status["CHECK"] and xButton.status.current<HealBot_Unit_Status["DEAD"] and xButton.health.incoming>0 then
            aufbBarValue=xButton.gref["InHeal"]:GetValue()
            if aufbBarValue>xButton.health.inhptc then
                aufbSetValue=aufbBarValue-ceil((aufbBarValue-xButton.health.inhptc)/HealBot_Action_luVars["FluidBarSmoothAdj"])
                if aufbSetValue<xButton.health.inhptc then aufbSetValue=xButton.health.inhptc end
                xButton.gref["InHeal"]:SetValue(aufbSetValue)
                HealBot_Action_luVars["FluidBarInUse"]=true
            elseif aufbBarValue<xButton.health.inhptc then
                aufbSetValue=aufbBarValue+ceil((xButton.health.inhptc-aufbBarValue)/HealBot_Action_luVars["FluidBarSmoothAdj"])
                if aufbSetValue>xButton.health.inhptc then aufbSetValue=xButton.health.inhptc end
                xButton.gref["InHeal"]:SetValue(aufbSetValue)
                HealBot_Action_luVars["FluidBarInUse"]=true
            end
        else
            xButton.gref["InHeal"]:SetValue(0)
            xButton.gref["InHeal"]:SetStatusBarColor(0,0,0,0)
            HealBot_Fluid_InHealButtons[id]=nil
        end
    end

    for id,xButton in pairs(HealBot_Fluid_AbsorbButtons) do
        if xButton.status.current>HealBot_Unit_Status["CHECK"] and xButton.status.current<HealBot_Unit_Status["DEAD"] and xButton.health.absorbs>0 then
            aufbBarValue=xButton.gref["Absorb"]:GetValue()
            if aufbBarValue>xButton.health.abptc then
                aufbSetValue=aufbBarValue-ceil((aufbBarValue-xButton.health.abptc)/HealBot_Action_luVars["FluidBarSmoothAdj"])
                if aufbSetValue<xButton.health.abptc then aufbSetValue=xButton.health.abptc end
                xButton.gref["Absorb"]:SetValue(aufbSetValue)
                HealBot_Action_luVars["FluidBarInUse"]=true
            elseif aufbBarValue<xButton.health.abptc then
                aufbSetValue=aufbBarValue+ceil((xButton.health.abptc-aufbBarValue)/HealBot_Action_luVars["FluidBarSmoothAdj"])
                if aufbSetValue>xButton.health.abptc then aufbSetValue=xButton.health.abptc end
                xButton.gref["Absorb"]:SetValue(aufbSetValue)
                HealBot_Action_luVars["FluidBarInUse"]=true
            end
        else
            xButton.gref["Absorb"]:SetValue(0)
            xButton.gref["Absorb"]:SetStatusBarColor(0,0,0,0)
            HealBot_Fluid_AbsorbButtons[id]=nil
        end
    end
    if HealBot_Action_luVars["FluidBarInUse"] then
        C_Timer.After(HealBot_Action_luVars["FluidBarFreq"], function() HealBot_Action_UpdateFluidBars() end)
    end
    --HealBot_Aux_setLuVars("FluidBarInUse", HealBot_Action_luVars["FluidBarInUse"])
end

local HealBot_Hazard_Buttons={}
function HealBot_Action_UpdateHazardBordersColours(button, alpha)
      --HealBot_setCall("HealBot_Action_UpdateHazardBordersColours", button)
    button.gref["BackBorder"]:SetBackdropBorderColor(button.hazard.r,button.hazard.g,button.hazard.b,HealBot_Action_BarColourAlpha(button, alpha, 1))
end

function HealBot_Action_UpdateHazardBordersColoursNew(button, r, g, b)
      --HealBot_setCall("HealBot_Action_UpdateHazardBordersColoursNew", button)
    button.hazard.r,button.hazard.g,button.hazard.b=r,g,b
    if HealBot_Action_luVars["HazardAltAlpha"] then
        HealBot_Action_UpdateHazardBordersColours(button, 1)
    else
        HealBot_Action_UpdateHazardBordersColours(button, HealBot_Action_luVars["HazardMinAlpha"])
    end
end

function HealBot_Action_UpdateHazardBorders()
      --HealBot_setCall("HealBot_Action_UpdateHazardBorders")
    HealBot_Action_luVars["HazardCurrentInUse"]=false
    if HealBot_Action_luVars["HazardAltAlpha"] then
        HealBot_Action_luVars["HazardAltAlpha"]=false
        for id,xButton in pairs(HealBot_Hazard_Buttons) do
            HealBot_Action_luVars["HazardCurrentInUse"]=true
            HealBot_Action_UpdateHazardBordersColours(xButton, 1)
        end
    else
        HealBot_Action_luVars["HazardAltAlpha"]=true
        for id,xButton in pairs(HealBot_Hazard_Buttons) do
            HealBot_Action_luVars["HazardCurrentInUse"]=true
            HealBot_Action_UpdateHazardBordersColours(xButton, HealBot_Action_luVars["HazardMinAlpha"])
        end
    end

    if HealBot_Action_luVars["HazardCurrentInUse"] then
        C_Timer.After(HealBot_Action_luVars["HazardFreq"], function() HealBot_Action_UpdateHazardBorders() end)
    else
        HealBot_Action_luVars["HazardInUse"]=false
    end
end

function HealBot_Action_EnableBorderHazard(button, r, g, b)
      --HealBot_setCall("HealBot_Action_EnableBorderHazard", button)
    HealBot_Hazard_Buttons[button.id]=button
    button.hazard.r,button.hazard.g,button.hazard.b=r,g,b
    if not HealBot_Action_luVars["HazardInUse"] then
        HealBot_Action_luVars["HazardInUse"]=true
        HealBot_Action_luVars["HazardAltAlpha"]=true
        HealBot_Action_UpdateHazardBorders()
    end
end

function HealBot_Action_EnableBorderHazardHealthDrop(button, r, g, b)
      --HealBot_setCall("HealBot_Action_EnableBorderHazardHealthDrop", button)
    button.hazard.hlthdrop=true
    HealBot_Action_EnableBorderHazard(button, r, g, b)
    C_Timer.After(HealBot_Action_luVars["HealthDropTime"], function() HealBot_Action_DisableBorderHazardHealthDropTimer(button) end)
end

function HealBot_Action_EnableBorderHazardPlugin(button, r, g, b)
      --HealBot_setCall("HealBot_Action_EnableBorderHazardPlugin", button)
    button.hazard.plugin=true
    if not button.hazard.hlthdrop then
        HealBot_Action_EnableBorderHazard(button, r, g, b)
    end
end

function HealBot_Action_EnableBorderHazardDebuff(button, r, g, b)
      --HealBot_setCall("HealBot_Action_EnableBorderHazardDebuff", button)
    button.hazard.debuff=true
    if not button.hazard.plugin and not button.hazard.hlthdrop then
        HealBot_Action_EnableBorderHazard(button, r, g, b)
    end
end

function HealBot_Action_EnableBorderHazardAggro(button, r, g, b)
      --HealBot_setCall("HealBot_Action_EnableBorderHazardAggro", button)
    button.hazard.aggro=true
    if not button.hazard.plugin and not button.hazard.debuff and not button.hazard.hlthdrop then
        HealBot_Action_EnableBorderHazard(button, r, g, b)
    end
end

function HealBot_Action_EnableBorderHazardBuff(button, r, g, b)
      --HealBot_setCall("HealBot_Action_EnableBorderHazardBuff", button)
    button.hazard.buff=true
    if not button.hazard.plugin and not button.hazard.debuff and not button.hazard.aggro and not button.hazard.hlthdrop then
        HealBot_Action_EnableBorderHazard(button, r, g, b)
    end
end

local hbBorderEnableHazardTypeFuncs={["HLTHDROP"]=HealBot_Action_EnableBorderHazardHealthDrop,
                                     ["PLUGIN"]=HealBot_Action_EnableBorderHazardPlugin,
                                     ["DEBUFF"]=HealBot_Action_EnableBorderHazardDebuff,
                                     ["AGGRO"]=HealBot_Action_EnableBorderHazardAggro,
                                     ["BUFF"]=HealBot_Action_EnableBorderHazardBuff}
function HealBot_Action_EnableBorderHazardType(button, r, g, b, hType)
      --HealBot_setCall("HealBot_Action_EnableBorderHazardType", button)
    hbBorderEnableHazardTypeFuncs[hType](button, r, g, b)
end

function HealBot_Action_DisableBorderHazard(button)
      --HealBot_setCall("HealBot_Action_DisableBorderHazard", button)
    HealBot_Hazard_Buttons[button.id]=nil
    HealBot_Action_AdaptiveSetNextActive(button, 1)
    HealBot_Action_UpdateBackgroundBorder(button)
end

function HealBot_Action_DisableBorderHazardHealthDrop(button)
      --HealBot_setCall("HealBot_Action_DisableBorderHazardHealthDrop", button)
    if button.hazard.hlthdrop then
        button.hazard.hlthdrop=false
        if button.hazard.plugin then
            HealBot_Action_UpdateHazardBordersColoursNew(button, button.plugin.r, button.plugin.g, button.plugin.b)
        elseif button.hazard.debuff then
            HealBot_Action_UpdateHazardBordersColoursNew(button, button.aura.debuff.r, button.aura.debuff.g, button.aura.debuff.b)
        elseif button.hazard.aggro then
            HealBot_Action_UpdateHazardBordersColoursNew(button, 1, 0, 0)
        elseif button.hazard.buff then
            HealBot_Action_UpdateHazardBordersColoursNew(button, button.aura.buff.r, button.aura.buff.g, button.aura.buff.b)
        else
            HealBot_Action_DisableBorderHazard(button)
        end
    end
end

function HealBot_Action_DisableBorderHazardPlugin(button)
      --HealBot_setCall("HealBot_Action_DisableBorderHazardPlugin", button)
    if button.hazard.plugin then
        button.hazard.plugin=false
        if button.hazard.debuff then
            HealBot_Action_UpdateHazardBordersColoursNew(button, button.aura.debuff.r, button.aura.debuff.g, button.aura.debuff.b)
        elseif button.hazard.aggro then
            HealBot_Action_UpdateHazardBordersColoursNew(button, 1, 0, 0)
        elseif button.hazard.buff then
            HealBot_Action_UpdateHazardBordersColoursNew(button, button.aura.buff.r, button.aura.buff.g, button.aura.buff.b)
        else
            HealBot_Action_DisableBorderHazard(button)
        end
    end
end

function HealBot_Action_DisableBorderHazardDebuff(button)
      --HealBot_setCall("HealBot_Action_DisableBorderHazardDebuff", button)
    if button.hazard.debuff then
        button.hazard.debuff=false
        if button.hazard.aggro then
            HealBot_Action_UpdateHazardBordersColoursNew(button, 1, 0, 0)
        elseif button.hazard.buff then
            HealBot_Action_UpdateHazardBordersColoursNew(button, button.aura.buff.r, button.aura.buff.g, button.aura.buff.b)
        else
            HealBot_Action_DisableBorderHazard(button)
        end
    end
end

function HealBot_Action_DisableBorderHazardAggro(button)
      --HealBot_setCall("HealBot_Action_DisableBorderHazardAggro", button)
    if button.hazard.aggro then
        button.hazard.aggro=false
        if button.hazard.buff then
            HealBot_Action_UpdateHazardBordersColoursNew(button, button.aura.buff.r, button.aura.buff.g, button.aura.buff.b)
        else
            HealBot_Action_DisableBorderHazard(button)
        end
    end
end

function HealBot_Action_DisableBorderHazardBuff(button)
      --HealBot_setCall("HealBot_Action_DisableBorderHazardBuff", button)
    if button.hazard.buff then
        button.hazard.buff=false
        HealBot_Action_DisableBorderHazard(button)
    end
end

local hbBorderDisableHazardTypeFuncs={["HLTHDROP"]=HealBot_Action_DisableBorderHazardHealthDrop,
                                      ["PLUGIN"]=HealBot_Action_DisableBorderHazardPlugin,
                                      ["DEBUFF"]=HealBot_Action_DisableBorderHazardDebuff,
                                      ["AGGRO"]=HealBot_Action_DisableBorderHazardAggro,
                                      ["BUFF"]=HealBot_Action_DisableBorderHazardBuff}
function HealBot_Action_DisableBorderHazardType(button, hType)
      --HealBot_setCall("HealBot_Action_DisableBorderHazardType", button)
    hbBorderDisableHazardTypeFuncs[hType](button)
end

function HealBot_Action_DisableBorderHazardHealthDropTimer(button)
      --HealBot_setCall("HealBot_Action_DisableBorderHazardHealthDropTimer", button)
    if button.hazard.hlthdrop then
        HealBot_Action_DisableBorderHazardType(button, "HLTHDROP")
    end
end

local hbIconGlowLen={[1]=3, [2]=3, [3]=3, [4]=3, [5]=3, [6]=3, [7]=3, [8]=3, [9]=3, [10]=3}
local hbIconGlowSize={[1]=1, [2]=1, [3]=1, [4]=1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1, [10]=1}
local hbIconGlowSizeStars={[1]=1, [2]=1, [3]=1, [4]=1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1, [10]=1}
local hbGlowLen={[1]=12, [2]=12, [3]=12, [4]=12, [5]=12, [6]=12, [7]=12, [8]=12, [9]=12, [10]=12}
local hbGlowSize={[1]=4, [2]=4, [3]=4, [4]=4, [5]=4, [6]=4, [7]=4, [8]=4, [9]=4, [10]=4}
local hbGlowSizeStars={[1]=4, [2]=4, [3]=4, [4]=4, [5]=4, [6]=4, [7]=4, [8]=4, [9]=4, [10]=4}
local hbGlowFreq={["HW"]=0.28, ["MW"]=0.28, ["DEBUFF"]=-0.22, ["BUFF"]=0.22, ["ICONDEBUFF"]=-0.22, ["ICONBUFF"]=0.22,["EB"]=0.22,["ED"]=-0.22,["HL"]=0.28}
local hbGlowStyle={["HW"]=5, ["MW"]=5, ["DEBUFF"]=5, ["BUFF"]=5, ["ICONDEBUFF"]=5, ["ICONBUFF"]=5,["EB"]=2,["ED"]=2,["HL"]=6}
local hbGlowCol={["HW"]={},["MW"]={},["DEBUFF"]={},["BUFF"]={},["ICONDEBUFF"]={},["ICONBUFF"]={},["EB"]={},["ED"]={},["HL"]={}}
hbGlowCol["HW"][4]=1
hbGlowCol["MW"][4]=1
hbGlowCol["DEBUFF"][4]=1
hbGlowCol["BUFF"][4]=1
hbGlowCol["ICONDEBUFF"][4]=1
hbGlowCol["ICONBUFF"][4]=1
hbGlowCol["EB"][4]=1
hbGlowCol["ED"][4]=1
hbGlowCol["HL"][4]=1
for x=1,8 do
    hbGlowFreq["AW"..x]=0.28
    hbGlowStyle["AW"..x]=0
    hbGlowCol["AW"..x]={}
    hbGlowCol["AW"..x][4]=1
end

local HealBot_Hazard_EmergButtons={}
function HealBot_Action_UpdateEmergHazardBordersColours(button, alpha)
      --HealBot_setCall("HealBot_Action_UpdateHazardBordersColours", button)
    button.gref["EmergBorder"]:SetBackdropBorderColor(button.hazard.er,button.hazard.eg,button.hazard.eb,HealBot_Action_BarColourAlpha(button, alpha, 1))
end

function HealBot_Action_UpdateEmergHazardBorders()
      --HealBot_setCall("HealBot_Action_UpdateEmergHazardBorders")
    HealBot_Action_luVars["EmergHazardCurrentInUse"]=false
    if HealBot_Action_luVars["EmergHazardAltAlpha"] then
        HealBot_Action_luVars["EmergHazardAltAlpha"]=false
        for id,xButton in pairs(HealBot_Hazard_EmergButtons) do
            HealBot_Action_luVars["EmergHazardCurrentInUse"]=true
            HealBot_Action_UpdateEmergHazardBordersColours(xButton, 1)
        end
    else
        HealBot_Action_luVars["EmergHazardAltAlpha"]=true
        for id,xButton in pairs(HealBot_Hazard_EmergButtons) do
            HealBot_Action_luVars["EmergHazardCurrentInUse"]=true
            HealBot_Action_UpdateEmergHazardBordersColours(xButton, HealBot_Action_luVars["HazardMinAlpha"])
        end
    end

    if HealBot_Action_luVars["EmergHazardCurrentInUse"] then
        C_Timer.After(HealBot_Action_luVars["HazardFreq"], function() HealBot_Action_UpdateEmergHazardBorders() end)
    else
        HealBot_Action_luVars["EmergHazardInUse"]=false
    end
end

function HealBot_Action_EnableEmergBorderHazard(button, r, g, b)
      --HealBot_setCall("HealBot_Action_EnableBorderHazard", button)
    HealBot_Hazard_EmergButtons[button.id]=button
    button.hazard.er,button.hazard.eg,button.hazard.eb=r,g,b
    if not HealBot_Action_luVars["EmergHazardInUse"] then
        HealBot_Action_luVars["EmergHazardInUse"]=true
        HealBot_Action_luVars["EmergHazardAltAlpha"]=true
        HealBot_Action_UpdateEmergHazardBorders()
    end
end

function HealBot_Action_DisableEmergBorderHazard(button)
      --HealBot_setCall("HealBot_Action_DisableBorderHazard", button)
    HealBot_Hazard_EmergButtons[button.id]=nil
    button.gref["EmergBorder"]:SetBackdropBorderColor(0,0,0,0)
end

local HealBot_Hazard_ButtonIcons={}
local HealBot_Hazard_IconData={}
function HealBot_Action_UpdateHazardIconBordersColours(icon, id, alpha)
      --HealBot_setCall("HealBot_Action_UpdateHazardIconBordersColours")
    icon:SetBackdropBorderColor(HealBot_Hazard_IconData[id].r,HealBot_Hazard_IconData[id].g,HealBot_Hazard_IconData[id].b,alpha)
end

function HealBot_Action_UpdateIconHazardBorders()
      --HealBot_setCall("HealBot_Action_UpdateIconHazardBorders")
    HealBot_Action_luVars["IconHazardCurrentInUse"]=false
    if HealBot_Action_luVars["IconHazardAltAlpha"] then
        HealBot_Action_luVars["IconHazardAltAlpha"]=false
        for id,icon in pairs(HealBot_Hazard_ButtonIcons) do
            HealBot_Action_luVars["IconHazardCurrentInUse"]=true
            HealBot_Action_UpdateHazardIconBordersColours(icon, id, HealBot_Hazard_IconData[id].a)
        end
    else
        HealBot_Action_luVars["IconHazardAltAlpha"]=true
        for id,icon in pairs(HealBot_Hazard_ButtonIcons) do
            HealBot_Action_luVars["IconHazardCurrentInUse"]=true
            HealBot_Action_UpdateHazardIconBordersColours(icon, id, HealBot_Action_luVars["HazardMinAlpha"])
        end
    end

    if HealBot_Action_luVars["IconHazardCurrentInUse"] then
        C_Timer.After(HealBot_Action_luVars["HazardFreq"], function() HealBot_Action_UpdateIconHazardBorders() end)
    else
        HealBot_Action_luVars["IconHazardInUse"]=false
    end
end

function HealBot_Action_EnableIconBorderHazard(icon, id, r, g, b, a, gStyle)
      --HealBot_setCall("HealBot_Action_EnableIconBorderHazard")
    if not HealBot_Hazard_IconData[id] then HealBot_Hazard_IconData[id]={} end
    HealBot_Hazard_IconData[id].r=r
    HealBot_Hazard_IconData[id].g=g
    HealBot_Hazard_IconData[id].b=b
    HealBot_Hazard_IconData[id].a=a
    if gStyle == 6 then
        HealBot_Action_UpdateHazardIconBordersColours(icon, id, a)
    else
        HealBot_Hazard_ButtonIcons[id]=icon
        if not HealBot_Action_luVars["IconHazardInUse"] then
            HealBot_Action_luVars["IconHazardInUse"]=true
            HealBot_Action_luVars["IconHazardAltAlpha"]=true
            HealBot_Action_UpdateIconHazardBorders()
        end
    end
end

function HealBot_Action_DisableIconBorderHazard(icon, id)
      --HealBot_setCall("HealBot_Action_DisableIconBorderHazard")
    HealBot_Hazard_ButtonIcons[id]=nil
    icon:SetBackdropBorderColor(0,0,0,0)
end

function HealBot_Action_IconGlow(frame, key, enable, frameID)
      --HealBot_setCall("HealBot_Action_IconGlow")
    if enable then
        lGlow.PixelGlow_Start(frame, hbGlowCol[key], 8, hbGlowFreq[key], hbIconGlowLen[frameID], hbIconGlowSize[frameID], 1, 1, false, key)
    else
        lGlow.PixelGlow_Stop(frame, key)
    end
end

function HealBot_Action_IconGlowBall(frame, key, enable, frameID)
      --HealBot_setCall("HealBot_Action_IconGlowBall")
    if enable then
        lGlow.AutoCastGlow_Start(frame, hbGlowCol[key], 4, hbGlowFreq[key], hbIconGlowSizeStars[frameID], 1, 1, key)
    else
        lGlow.AutoCastGlow_Stop(frame, key)
    end
end

function HealBot_Action_IconGlowBlizz(frame, key, enable)
      --HealBot_setCall("HealBot_Action_IconGlowBlizz")
    if enable then
        lGlow.ButtonGlow_Start(frame, hbGlowCol[key], hbGlowFreq[key])
    else
        lGlow.ButtonGlow_Stop(frame)
    end
end

function HealBot_Action_ButtonGlow(frame, key, enable, frameID)
      --HealBot_setCall("HealBot_Action_ButtonGlow")
    if enable then
        lGlow.PixelGlow_Start(frame, hbGlowCol[key], 8, hbGlowFreq[key], hbGlowLen[frameID], hbGlowSize[frameID], 0, 0, false, key)
    else
        lGlow.PixelGlow_Stop(frame, key)
    end
end

function HealBot_Action_ButtonGlowBall(frame, key, enable, frameID)
      --HealBot_setCall("HealBot_Action_ButtonGlowBall")
    if enable then
        lGlow.AutoCastGlow_Start(frame, hbGlowCol[key], 4, hbGlowFreq[key], hbGlowSizeStars[frameID], 0, 0, key)
    else
        lGlow.AutoCastGlow_Stop(frame, key)
    end
end

function HealBot_Action_ButtonGlowBlizz(frame, key, enable)
      --HealBot_setCall("HealBot_Action_ButtonGlowBlizz")
    if enable then
        lGlow.ButtonGlow_Start(frame, hbGlowCol[key], hbGlowFreq[key])
    else
        lGlow.ButtonGlow_Stop(frame)
    end
end

function HealBot_Action_FramesGlowLen()
      --HealBot_setCall("HealBot_Action_FramesGlowLen")
    local l=100
    for x=1,10 do
        l=ceil(hbv_Skins_GetFrameVar("HealBar", "WIDTH", x)*hbv_Skins_GetFrameVar("Frame", "SCALE", x))
        if HealBot_Action_luVars["BarGlowSize"] == 1 then
            hbGlowLen[x]=ceil(l/12)
            hbGlowSize[x]=1*hbv_Skins_GetFrameVar("Frame", "SCALE", x)
            hbGlowSizeStars[x]=2.2*hbv_Skins_GetFrameVar("Frame", "SCALE", x)
        elseif HealBot_Action_luVars["BarGlowSize"] == 2 then
            hbGlowLen[x]=ceil(l/10)
            hbGlowSize[x]=2*hbv_Skins_GetFrameVar("Frame", "SCALE", x)
            hbGlowSizeStars[x]=3.1*hbv_Skins_GetFrameVar("Frame", "SCALE", x)
        elseif HealBot_Action_luVars["BarGlowSize"] == 4 then
            hbGlowLen[x]=ceil(l/7)
            hbGlowSize[x]=4*hbv_Skins_GetFrameVar("Frame", "SCALE", x)
            hbGlowSizeStars[x]=4.9*hbv_Skins_GetFrameVar("Frame", "SCALE", x)
        elseif HealBot_Action_luVars["BarGlowSize"] == 5 then
            hbGlowLen[x]=ceil(l/5)
            hbGlowSize[x]=5*hbv_Skins_GetFrameVar("Frame", "SCALE", x)
            hbGlowSizeStars[x]=5.8*hbv_Skins_GetFrameVar("Frame", "SCALE", x)
        else
            hbGlowLen[x]=ceil(l/9)
            hbGlowSize[x]=3*hbv_Skins_GetFrameVar("Frame", "SCALE", x)
            hbGlowSizeStars[x]=4*hbv_Skins_GetFrameVar("Frame", "SCALE", x)
        end
        if HEALBOT_GAME_VERSION<10 then
            hbGlowSizeStars[x]=hbGlowSizeStars[x]*1.25
        end
    end
end

function HealBot_Action_FramesIconGlowLen()
      --HealBot_setCall("HealBot_Action_FramesIconGlowLen")
    local i=10
    for x=1,10 do
        i=(hbv_Skins_GetFrameVar("HealBar", "HEIGHT", x)*hbv_Skins_GetFrameVar("Frame", "SCALE", x))
        if HealBot_Action_luVars["IconGlowSize"] == 1 then
            hbIconGlowLen[x]=i/18
            hbIconGlowSize[x]=1.25*hbv_Skins_GetFrameVar("Frame", "SCALE", x)
            hbIconGlowSizeStars[x]=1*hbv_Skins_GetFrameVar("Frame", "SCALE", x)
        elseif HealBot_Action_luVars["IconGlowSize"] == 2 then
            hbIconGlowLen[x]=i/16
            hbIconGlowSize[x]=1.5*hbv_Skins_GetFrameVar("Frame", "SCALE", x)
            hbIconGlowSizeStars[x]=1.25*hbv_Skins_GetFrameVar("Frame", "SCALE", x)
        elseif HealBot_Action_luVars["IconGlowSize"] == 4 then
            hbIconGlowLen[x]=i/14
            hbIconGlowSize[x]=2.2*hbv_Skins_GetFrameVar("Frame", "SCALE", x)
            hbIconGlowSizeStars[x]=1.75*hbv_Skins_GetFrameVar("Frame", "SCALE", x)
        elseif HealBot_Action_luVars["IconGlowSize"] == 5 then
            hbIconGlowLen[x]=i/12
            hbIconGlowSize[x]=2.7*hbv_Skins_GetFrameVar("Frame", "SCALE", x)
            hbIconGlowSizeStars[x]=2*hbv_Skins_GetFrameVar("Frame", "SCALE", x)
        else
            hbIconGlowLen[x]=i/15
            hbIconGlowSize[x]=1.8*hbv_Skins_GetFrameVar("Frame", "SCALE", x)
            hbIconGlowSizeStars[x]=1.5*hbv_Skins_GetFrameVar("Frame", "SCALE", x)
        end
        if HEALBOT_GAME_VERSION<10 then
            hbIconGlowSizeStars[x]=hbIconGlowSizeStars[x]*1.5
        end
    end
end

function HealBot_Action_EnableIconGlow(button, r, g, b, iKey, gStyle, iconIdx, a)
      --HealBot_setCall("HealBot_Action_EnableIconGlow", button)
    hbGlowCol[iKey][1]=r
    hbGlowCol[iKey][2]=g
    hbGlowCol[iKey][3]=b
    hbGlowCol[iKey][4]=a
    if button.glow.icon[iconIdx]>1 and button.glow.icon[iconIdx]~=gStyle then
        HealBot_Action_DisableIconGlow(button, iKey, iconIdx)
    end
    button.glow.icon[iconIdx]=gStyle
    if gStyle == 2 or gStyle == 6 then
        HealBot_Action_EnableIconBorderHazard(button.gref.iconf[iconIdx], button.id..iconIdx, r, g, b, a, gStyle)
    elseif gStyle == 3 then
        HealBot_Action_IconGlow(button.gref.iconf[iconIdx], iKey, true, button.frame)
    elseif gStyle == 4 then
        HealBot_Action_IconGlowBall(button.gref.iconf[iconIdx], iKey, true, button.frame)
    else
        HealBot_Action_IconGlowBlizz(button.gref.iconf[iconIdx], iKey, true)
    end
end

function HealBot_Action_DisableIconGlow(button, iKey, iconIdx)
      --HealBot_setCall("HealBot_Action_DisableIconGlow", button)
    if button.glow.icon[iconIdx] == 2 or button.glow.icon[iconIdx] == 6 then
        HealBot_Action_DisableIconBorderHazard(button.gref.iconf[iconIdx], button.id..iconIdx)
    elseif button.glow.icon[iconIdx] == 3 then
        HealBot_Action_IconGlow(button.gref.iconf[iconIdx], iKey, false)
    elseif button.glow.icon[iconIdx] == 4 then
        HealBot_Action_IconGlowBall(button.gref.iconf[iconIdx], iKey, false)
    elseif button.glow.icon[iconIdx] == 5 then
        HealBot_Action_IconGlowBlizz(button.gref.iconf[iconIdx], iKey, false)
    end
    button.glow.icon[iconIdx]=0
end

function HealBot_Action_DisableBuffIconGlow(button)
    for i=1,12 do
        if button.glow.icon[i]>1 then
            HealBot_Action_DisableIconGlow(button, "ICONDEBUFF", i)
        end
    end
end

function HealBot_Action_DisableDebuffIconGlow(button)
    for i=51,60 do
        if button.glow.icon[i]>1 then
            HealBot_Action_DisableIconGlow(button, "ICONDEBUFF", i)
        end
    end
end

function HealBot_Action_EnableEmergButtonGlowType(button, r, g, b, pKey, gStyle)
    hbGlowCol[pKey][1]=r
    hbGlowCol[pKey][2]=g
    hbGlowCol[pKey][3]=b
    hbGlowStyle[pKey]=gStyle
    if gStyle == 2 then
        HealBot_Action_EnableEmergBorderHazard(button, r, g, b)
    elseif gStyle == 3 then
        HealBot_Action_IconGlow(button.gref["EmergBorder"], pKey, true, button.frame)
    elseif gStyle == 4 then
        HealBot_Action_IconGlowBall(button.gref["EmergBorder"], pKey, true, button.frame)
    else
        HealBot_Action_IconGlowBlizz(button.gref["EmergBorder"], pKey, true)
    end
    button.glow.emerg[pKey]=gStyle
end

function HealBot_Action_DisableEmergButtonGlow(button, pKey)
      --HealBot_setCall("HealBot_Action_DisableIconGlow", button)
    if button.glow.emerg[pKey] == 2 then
        HealBot_Action_DisableEmergBorderHazard(button)
    elseif button.glow.emerg[pKey] == 3 then
        HealBot_Action_IconGlow(button.gref["EmergBorder"], pKey, false)
    elseif button.glow.emerg[pKey] == 4 then
        HealBot_Action_IconGlowBall(button.gref["EmergBorder"], pKey, false)
    elseif button.glow.emerg[pKey] == 5 then
        HealBot_Action_IconGlowBlizz(button.gref["EmergBorder"], pKey, false)
    end
    button.glow.emerg[pKey]=0
end

function HealBot_Action_DisableEmergButtonGlowKey(button, pKey)
    if button.glow.emerg[pKey]>0 then
        HealBot_Action_DisableEmergButtonGlow(button, pKey)
    end
end

function HealBot_Action_DisableEmergButtonGlowKeys(button)
    HealBot_Action_DisableEmergButtonGlowKey(button, "EB")
    HealBot_Action_DisableEmergButtonGlowKey(button, "ED")
end

function HealBot_Action_EnableButtonGlowType(button, r, g, b, gType, pKey, gStyle)
      --HealBot_setCall("HealBot_Action_EnableButtonGlowType", button)
    if gType == "PLUGIN" then
        if hbGlowStyle[pKey]~=gStyle then
            HealBot_Action_DisableButtonGlowType(button, gType, pKey)
        end
        button.glow.plugin=true
        hbGlowCol[pKey][1]=r
        hbGlowCol[pKey][2]=g
        hbGlowCol[pKey][3]=b
        hbGlowStyle[pKey]=gStyle
        if gStyle == 5 then
            HealBot_Action_ButtonGlow(button.gref["BackBorder"], pKey, true, button.frame)
        elseif gStyle == 6 then
            HealBot_Action_ButtonGlowBall(button.gref["BackBorder"], pKey, true, button.frame)
        else
            HealBot_Action_ButtonGlowBlizz(button.gref["BackBorder"], pKey, true)
        end
    else
        if hbGlowStyle[gType]~=gStyle then
            HealBot_Action_DisableButtonGlowType(button, gType)
        end
        if gType == "DEBUFF" then
            button.glow.debuff=true
        elseif gType == "BUFF" then
            button.glow.buff=true
        end
        hbGlowCol[gType][1]=r
        hbGlowCol[gType][2]=g
        hbGlowCol[gType][3]=b
        hbGlowStyle[gType]=gStyle
        if gStyle == 5 then
            HealBot_Action_ButtonGlow(button.gref["BackBorder"], gType, true, button.frame)
        elseif gStyle == 6 then
            HealBot_Action_ButtonGlowBall(button.gref["BackBorder"], gType, true, button.frame)
        elseif gType == "PLUGIN" then
            HealBot_Action_ButtonGlowBlizz(button.gref["BackBorder"], gType, true)
        elseif not button.glow.plugin or (hbGlowStyle["AW1"]~=7 and hbGlowStyle["AW2"]~=7 and hbGlowStyle["AW3"]~=7 and hbGlowStyle["AW4"]~=7 and 
                                          hbGlowStyle["AW5"]~=7 and hbGlowStyle["AW6"]~=7 and hbGlowStyle["AW7"]~=7 and hbGlowStyle["AW8"]~=7 and 
                                          hbGlowStyle["HW"]~=7 and hbGlowStyle["MW"]~=7) then
            if gType == "DEBUFF" or (not button.glow.debuff or hbGlowStyle["DEBUFF"]~=7) then
                HealBot_Action_ButtonGlowBlizz(button.gref["BackBorder"], gType, true)
            end
        else
        end
    end
end

function HealBot_Action_DisableButtonGlowType(button, gType, pKey)
      --HealBot_setCall("HealBot_Action_DisableButtonGlowType", button)
    if gType == "PLUGIN" then
        button.glow.plugin=false
        if hbGlowStyle[pKey] == 5 then
            HealBot_Action_ButtonGlow(button.gref["BackBorder"], pKey, false, button.frame)
        elseif hbGlowStyle[pKey] == 6 then
            HealBot_Action_ButtonGlowBall(button.gref["BackBorder"], pKey, false, button.frame)
        else
            HealBot_Action_ButtonGlowBlizz(button.gref["BackBorder"], pKey, false)
            if button.glow.debuff and hbGlowStyle["DEBUFF"] == 7 then
                HealBot_Action_ButtonGlowBlizz(button.gref["BackBorder"], "DEBUFF", true)
            elseif button.glow.buff and hbGlowStyle["BUFF"] == 7 then
                HealBot_Action_ButtonGlowBlizz(button.gref["BackBorder"], "BUFF", true)
            end
        end
    elseif gType == "DEBUFF" then
        button.glow.debuff=false
        if hbGlowStyle[gType] == 5 then
            HealBot_Action_ButtonGlow(button.gref["BackBorder"], gType, false, button.frame)
        elseif hbGlowStyle[gType] == 6 then
            HealBot_Action_ButtonGlowBall(button.gref["BackBorder"], gType, false, button.frame)
        else
            HealBot_Action_ButtonGlowBlizz(button.gref["BackBorder"], gType, false)
            if button.glow.buff and hbGlowStyle["BUFF"] == 7 then
                HealBot_Action_ButtonGlowBlizz(button.gref["BackBorder"], "BUFF", true)
            end
        end
    elseif gType == "BUFF" then
        button.glow.buff=false
        if hbGlowStyle[gType] == 5 then
            HealBot_Action_ButtonGlow(button.gref["BackBorder"], gType, false, button.frame)
        elseif hbGlowStyle[gType] == 6 then
            HealBot_Action_ButtonGlowBall(button.gref["BackBorder"], gType, false, button.frame)
        else
            HealBot_Action_ButtonGlowBlizz(button.gref["BackBorder"], gType, false)
        end
    else
        HealBot_Action_UpdateButtonGlow(button, false)
    end
end

function HealBot_Action_UpdateButtonGlow(button, enable)
      --HealBot_setCall("HealBot_Action_UpdateButtonGlow", button)
    if enable then
        if button.glow.plugin then
            if HealBot_Plugin_AuraWatch_GlowIndex and HealBot_Plugin_AuraWatch_GlowIndex(button, 5)>0 then
                HealBot_Action_ButtonGlow(button.gref["BackBorder"], "AW"..HealBot_Plugin_AuraWatch_GlowIndex(button, 5), enable, button.frame)
            end
            if HealBot_Plugin_AuraWatch_GlowIndex and HealBot_Plugin_AuraWatch_GlowIndex(button, 6)>0 then
                HealBot_Action_ButtonGlowBall(button.gref["BackBorder"], "AW"..HealBot_Plugin_AuraWatch_GlowIndex(button, 6), enable, button.frame)
            end
            if HealBot_Plugin_AuraWatch_GlowIndex and HealBot_Plugin_AuraWatch_GlowIndex(button, 7)>0 then
                HealBot_Action_ButtonGlowBlizz(button.gref["BackBorder"], "AW"..HealBot_Plugin_AuraWatch_GlowIndex(button, 7), enable)
            end
            if button.healthwatch.colbar == 5 then
                HealBot_Action_ButtonGlow(button.gref["BackBorder"], "HW", enable, button.frame)
            elseif button.healthwatch.colbar == 6 then
                HealBot_Action_ButtonGlowBall(button.gref["BackBorder"], "HW", enable, button.frame)
            elseif button.healthwatch.colbar == 7 then
                HealBot_Action_ButtonGlowBlizz(button.gref["BackBorder"], "HW", enable)
            end
            if button.manawatch.colbar == 5 then
                HealBot_Action_ButtonGlow(button.gref["BackBorder"], "MW", enable, button.frame)
            elseif button.manawatch.colbar == 6 then
                HealBot_Action_ButtonGlowBall(button.gref["BackBorder"], "MW", enable, button.frame)
            elseif button.manawatch.colbar == 7 then
                HealBot_Action_ButtonGlowBlizz(button.gref["BackBorder"], "MW", enable)
            end
        end
        if button.glow.debuff then
            if button.aura.debuff.colbar == 5 then
                HealBot_Action_ButtonGlow(button.gref["BackBorder"], "DEBUFF", enable, button.frame)
            elseif button.aura.debuff.colbar == 6 then
                HealBot_Action_ButtonGlowBall(button.gref["BackBorder"], "DEBUFF", enable, button.frame)
            elseif button.aura.debuff.colbar == 7 then
                HealBot_Action_ButtonGlowBlizz(button.gref["BackBorder"], "DEBUFF", enable)
            end
        end
        if button.glow.buff then
            if button.aura.buff.colbar == 5 then
                HealBot_Action_ButtonGlow(button.gref["BackBorder"], "BUFF", enable, button.frame)
            elseif button.aura.buff.colbar == 6 then
                HealBot_Action_ButtonGlowBall(button.gref["BackBorder"], "BUFF", enable, button.frame)
            elseif button.aura.buff.colbar == 7 then
                HealBot_Action_ButtonGlowBlizz(button.gref["BackBorder"], "BUFF", enable)
            end
        end
    else
        if button.glow.plugin then
            if HealBot_Plugin_AuraWatch_GlowIndex and HealBot_Plugin_AuraWatch_GlowIndex(button, 5)>0 then
                HealBot_Action_ButtonGlow(button.gref["BackBorder"], "AW"..HealBot_Plugin_AuraWatch_GlowIndex(button, 5), enable, button.frame) 
            end
            if button.aurawatch.HealBot_Plugin_AuraWatch_GlowIndex and HealBot_Plugin_AuraWatch_GlowIndex(button, 6)>0 then
                HealBot_Action_ButtonGlowBall(button.gref["BackBorder"], "AW"..HealBot_Plugin_AuraWatch_GlowIndex(button, 6), enable, button.frame)
            end
            if HealBot_Plugin_AuraWatch_GlowIndex and HealBot_Plugin_AuraWatch_GlowIndex(button, 7)>0 then
                HealBot_Action_ButtonGlowBlizz(button.gref["BackBorder"], "AW"..HealBot_Plugin_AuraWatch_GlowIndex(button, 7), enable)
            end
            if button.healthwatch.colbar>4 then
                HealBot_Action_ButtonGlow(button.gref["BackBorder"], "HW", enable, button.frame) 
                HealBot_Action_ButtonGlowBall(button.gref["BackBorder"], "HW", enable, button.frame)
                HealBot_Action_ButtonGlowBlizz(button.gref["BackBorder"], "HW", enable)
            end
            if button.manawatch.colbar>4 then
                HealBot_Action_ButtonGlow(button.gref["BackBorder"], "MW", enable, button.frame) 
                HealBot_Action_ButtonGlowBall(button.gref["BackBorder"], "MW", enable, button.frame)
                HealBot_Action_ButtonGlowBlizz(button.gref["BackBorder"], "MW", enable)
            end
        end
        if button.glow.debuff then
            HealBot_Action_ButtonGlow(button.gref["BackBorder"], "DEBUFF", enable, button.frame)
            HealBot_Action_ButtonGlowBall(button.gref["BackBorder"], "DEBUFF", enable, button.frame)
            HealBot_Action_ButtonGlowBlizz(button.gref["BackBorder"], "DEBUFF", enable)
        end
        if button.glow.buff then
            HealBot_Action_ButtonGlow(button.gref["BackBorder"], "BUFF", enable, button.frame)
            HealBot_Action_ButtonGlowBall(button.gref["BackBorder"], "BUFF", enable, button.frame)
            HealBot_Action_ButtonGlowBlizz(button.gref["BackBorder"], "BUFF", enable)
        end
    end
end

function HealBot_Action_DisableIconsGlow(button)
    for x=1,12 do
        if button.glow.icon[x]>1 then
            HealBot_Action_DisableIconGlow(button, "ICONBUFF", x)
        end
    end
    for x=51,60 do
        if button.glow.icon[x]>1 then
            HealBot_Action_DisableIconGlow(button, "ICONDEBUFF", x)
        end
    end
end

function HealBot_Action_UpdateGlow()
      --HealBot_setCall("HealBot_Action_UpdateGlow")
    HealBot_Update_ButtonGlow(true)
end

function HealBot_Action_DisableGlow()
      --HealBot_setCall("HealBot_Action_DisableGlow")
    HealBot_Update_ButtonGlow(false)
    HealBot_Action_FramesGlowLen()
end

function HealBot_Action_DisableGlowIcons()
      --HealBot_setCall("HealBot_Action_DisableIconGlow")
    HealBot_Update_DisableButtonIconsGlow()
    HealBot_Action_FramesIconGlowLen()
end

function HealBot_Action_DisableBorderHazardTypeGUID(guid)
      --HealBot_setCall("HealBot_Action_DisableBorderHazardTypeGUID", nil, guid)
    if HealBot_Action_luVars["pluginRequests"] then HealBot_Plugin_Requests_CancelGUID(guid) end
    if HealBot_Action_luVars["pluginAuraWatch"] then HealBot_Plugin_AuraWatch_CancelGUIDNoIndex(guid) end
    if HealBot_Action_luVars["pluginHealthWatch"] then HealBot_Plugin_HealthWatch_CancelGUID(guid) end
    if HealBot_Action_luVars["pluginManaWatch"] then HealBot_Plugin_ManaWatch_CancelGUID(guid) end
end

function HealBot_Action_DisableBorderHazardTypeButton(button)
      --HealBot_setCall("HealBot_Action_DisableBorderHazardTypeButton", button)
    if HealBot_Action_luVars["pluginRequests"] then HealBot_Plugin_Requests_Cancel(button) end
    if HealBot_Action_luVars["pluginAuraWatch"] then HealBot_Plugin_AuraWatch_CancelNoIndex(button) end
    if HealBot_Action_luVars["pluginHealthWatch"] then HealBot_Plugin_HealthWatch_Cancel(button) end
    if HealBot_Action_luVars["pluginManaWatch"] then HealBot_Plugin_ManaWatch_Cancel(button) end
end

local erButton=nil
local prevState=0
local emergHealthCol={[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,}
function HealBot_Action_EmergBarCheck(button, force)
      --HealBot_setCall("HealBot_Action_EmergBarCheck", button)
    if hbv_Skins_GetFrameBoolean("Emerg", "USE", button.frame) then
        erButton=HealBot_Emerg_Button[button.id]
		if button.status.current<HealBot_Unit_Status["DEAD"] and button.health.current>0 then
			if hbv_Skins_GetFrameBoolean("Emerg", "DEBUFFBARCOL", button.frame) and button.aura.debuff.colbar>0 then
                erButton.state=1
                HealBot_Action_EmergBarUpdate(button, erButton, (HealBot_Options_retDebuffCureSpell(button.aura.debuff.type) or button.status.rangespell), button.aura.debuff.r, button.aura.debuff.g, button.aura.debuff.b)
                if hbv_Skins_GetFrameVar("Emerg", "DEBUFFGLOW", button.frame)>1 and
                  (button.aura.debuff.dispellable or not hbv_Skins_GetFrameBoolean("Emerg", "DEBUFFGLOWONLYDISPEL", button.frame)) then
                    HealBot_Action_EnableEmergButtonGlowType(button, button.aura.debuff.r, button.aura.debuff.g, button.aura.debuff.b, "ED", hbv_Skins_GetFrameVar("Emerg", "DEBUFFGLOW", button.frame))
                else
                    HealBot_Action_DisableEmergButtonGlowKey(button, "ED")
                end
            elseif hbv_Skins_GetFrameBoolean("Emerg", "BUFFBARCOL", button.frame) and button.aura.buff.colbar>0 then 
                erButton.state=2
                HealBot_Action_EmergBarUpdate(button, erButton, button.aura.buff.name, button.aura.buff.r, button.aura.buff.g, button.aura.buff.b)
                if hbv_Skins_GetFrameVar("Emerg", "BUFFGLOW", button.frame)>1 and
                  (button.aura.buff.missingbuff or not hbv_Skins_GetFrameBoolean("Emerg", "BUFFGLOWONLYMISSING", button.frame)) then
                    HealBot_Action_EnableEmergButtonGlowType(button, button.aura.buff.r, button.aura.buff.g, button.aura.buff.b, "EB", hbv_Skins_GetFrameVar("Emerg", "BUFFGLOW", button.frame))
                else
                    HealBot_Action_DisableEmergButtonGlowKey(button, "EB")
                end
			else
                prevState=erButton.state
                if button.health.pct<hbv_Skins_GetFrameVar("Emerg", "CRITICAL", button.frame) then
                    erButton.state=4
                elseif button.health.pct<hbv_Skins_GetFrameVar("Emerg", "INJURED", button.frame) then
                    erButton.state=3
                else
                    erButton.state=0
                end
                if erButton.state~=prevState or force or 
                  (erButton.state>2 and emergHealthCol[button.frame]) then
                    HealBot_Action_EmergBarUpdate(button, erButton, HealBot_Range_Spell("HEAL"))
                    HealBot_Action_DisableEmergButtonGlowKey(button, "ED")
                    HealBot_Action_DisableEmergButtonGlowKey(button, "EB")
                end
            end
		elseif erButton.state>0 then
			erButton.state=0
			HealBot_Action_EmergBarUpdate(button, erButton, HealBot_Range_Spell("HEAL"))
		end
    end
end

function HealBot_Action_EmergHealthCol()
      --HealBot_setCall("HealBot_Action_EmergHealthCol")
    for x=1,9 do
        if hbv_Skins_GetFrameVar("Emerg", "BARCOL", x) == 1 or hbv_Skins_GetFrameVar("Emerg", "BARCOL", x) == 4 then
            emergHealthCol[x]=true
        else
            emergHealthCol[x]=false
        end
    end
end

function HealBot_Action_EmergBarColourHealth(button, eButton)
      --HealBot_setCall("HealBot_Action_EmergBarColourHealth", button)
    eButton.r,eButton.g,eButton.b=button.health.rcol, button.health.gcol, 0
end

function HealBot_Action_EmergBarColourClass(button, eButton)
      --HealBot_setCall("HealBot_Action_EmergBarColourClass", button)
    eButton.r,eButton.g,eButton.b=button.text.r,button.text.g,button.text.b
end

function HealBot_Action_EmergBarColourRole(button, eButton)
      --HealBot_setCall("HealBot_Action_EmergBarColourRole", button)
    eButton.r=hbCustomRoleCols[button.roletxt].r
    eButton.g=hbCustomRoleCols[button.roletxt].g
    eButton.b=hbCustomRoleCols[button.roletxt].b
end

function HealBot_Action_EmergBarColourCustom(button, eButton)
      --HealBot_setCall("HealBot_Action_EmergBarColourCustom", button)
    if eButton.state == 4 then
		eButton.r=hbv_Skins_GetFrameVar("Emerg", "CR", button.frame)
		eButton.g=hbv_Skins_GetFrameVar("Emerg", "CG", button.frame)
		eButton.b=hbv_Skins_GetFrameVar("Emerg", "CB", button.frame)
	elseif eButton.state == 3 then
		eButton.r=hbv_Skins_GetFrameVar("Emerg", "IR", button.frame)
		eButton.g=hbv_Skins_GetFrameVar("Emerg", "IG", button.frame)
		eButton.b=hbv_Skins_GetFrameVar("Emerg", "IB", button.frame)
	else
		eButton.r=hbv_Skins_GetFrameVar("Emerg", "HR", button.frame)
		eButton.g=hbv_Skins_GetFrameVar("Emerg", "HG", button.frame)
		eButton.b=hbv_Skins_GetFrameVar("Emerg", "HB", button.frame)
	end
end

function HealBot_Action_EmergBarColourClassHlthMix(button, eButton)
      --HealBot_setCall("HealBot_Action_EmergBarColourClassHlthMix", button)
    eButton.r,eButton.g,eButton.b=button.health.mixcolr, button.health.mixcolg, button.health.mixcolb
end

function HealBot_Action_EmergBarColourRoleHlthMix(button, eButton)
      --HealBot_setCall("HealBot_Action_EmergBarColourRoleHlthMix", button)
    eButton.r,eButton.g,eButton.b=button.health.rmixcolr, button.health.rmixcolg, button.health.rmixcolb
end

local ebRange=0
local hbEmergBarColourFuncs={[1]=HealBot_Action_EmergBarColourHealth,
                             [2]=HealBot_Action_EmergBarColourClass,
                             [3]=HealBot_Action_EmergBarColourRole,
                             [4]=HealBot_Action_EmergBarColourCustom,
                             [5]=HealBot_Action_EmergBarColourClassHlthMix,
                             [6]=HealBot_Action_EmergBarColourRoleHlthMix}
function HealBot_Action_EmergBarUpdate(button, eButton, rSpell, r, g, b)
      --HealBot_setCall("HealBot_Action_EmergBarUpdate", button)
	if r then
		eButton.r,eButton.g,eButton.b=r, g, b
	else
        hbEmergBarColourFuncs[hbv_Skins_GetFrameVar("Emerg", "BARCOL", button.frame)](button, eButton)
    end
	if eButton.state>0 then
        if button.status.rangespell == rSpell then
            ebRange=button.status.range
        elseif not button.player then
            ebRange=HealBot_Range_UnitCurrent(button, rSpell)
        end
        if ebRange>0 then
            eButton.a=HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("Emerg", "A", button.frame),1)
        else
            eButton.a=HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("Emerg", "OA", button.frame),1)
        end
	else
		eButton.a=HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("Emerg", "DA", button.frame),1)
	end
    eButton.bar:SetStatusBarColor(eButton.r,eButton.g,eButton.b,eButton.a)
end

local auhiHiPct, auhiHiHealsIn=1,0
function HealBot_Action_HealsInColourHealth(button)
      --HealBot_setCall("HealBot_Action_HealsInColourHealth", button)
    button.health.inhealr,button.health.inhealg,button.health.inhealb=button.health.rcol, button.health.gcol,0
end

function HealBot_Action_HealsInColourClass(button)
      --HealBot_setCall("HealBot_Action_HealsInColourClass", button)
    button.health.inhealr,button.health.inhealg,button.health.inhealb=button.text.r, button.text.g, button.text.b
end

function HealBot_Action_HealsInColourRole(button)
      --HealBot_setCall("HealBot_Action_HealsInColourRole", button)
    button.health.inhealr=hbCustomRoleCols[button.roletxt].r
    button.health.inhealg=hbCustomRoleCols[button.roletxt].g
    button.health.inhealb=hbCustomRoleCols[button.roletxt].b
end

function HealBot_Action_HealsInColourFutureHlth(button)
      --HealBot_setCall("HealBot_Action_HealsInColourFutureHlth", button)
    button.health.inhealr, button.health.inhealg=HealBot_Action_BarColourPct(auhiHiPct)
    button.health.inhealb=0
end

function HealBot_Action_HealsInColourCustom(button)
      --HealBot_setCall("HealBot_Action_HealsInColourCustom", button)
    if button.status.hostile then
        if auhiHiPct>hbv_Skins_GetFrameVar("BarIACol", "IIT", button.frame) then
            button.health.inhealr=hbv_Skins_GetFrameVar("BarIACol", "IRE", button.frame)
            button.health.inhealg=hbv_Skins_GetFrameVar("BarIACol", "IGE", button.frame)
            button.health.inhealb=hbv_Skins_GetFrameVar("BarIACol", "IBE", button.frame)
        elseif auhiHiPct>hbv_Skins_GetFrameVar("BarIACol", "ICT", button.frame) then
            button.health.inhealr=hbv_Skins_GetFrameVar("BarIACol", "IIRE", button.frame)
            button.health.inhealg=hbv_Skins_GetFrameVar("BarIACol", "IIGE", button.frame)
            button.health.inhealb=hbv_Skins_GetFrameVar("BarIACol", "IIBE", button.frame)
        else
            button.health.inhealr=hbv_Skins_GetFrameVar("BarIACol", "ICRE", button.frame)
            button.health.inhealg=hbv_Skins_GetFrameVar("BarIACol", "ICGE", button.frame)
            button.health.inhealb=hbv_Skins_GetFrameVar("BarIACol", "ICBE", button.frame)
        end
    else
        if auhiHiPct>hbv_Skins_GetFrameVar("BarIACol", "IIT", button.frame) then
            button.health.inhealr=hbv_Skins_GetFrameVar("BarIACol", "IR", button.frame)
            button.health.inhealg=hbv_Skins_GetFrameVar("BarIACol", "IG", button.frame)
            button.health.inhealb=hbv_Skins_GetFrameVar("BarIACol", "IB", button.frame)
        elseif auhiHiPct>hbv_Skins_GetFrameVar("BarIACol", "ICT", button.frame) then
            button.health.inhealr=hbv_Skins_GetFrameVar("BarIACol", "IIR", button.frame)
            button.health.inhealg=hbv_Skins_GetFrameVar("BarIACol", "IIG", button.frame)
            button.health.inhealb=hbv_Skins_GetFrameVar("BarIACol", "IIB", button.frame)
        else
            button.health.inhealr=hbv_Skins_GetFrameVar("BarIACol", "ICR", button.frame)
            button.health.inhealg=hbv_Skins_GetFrameVar("BarIACol", "ICG", button.frame)
            button.health.inhealb=hbv_Skins_GetFrameVar("BarIACol", "ICB", button.frame)
        end
    end
end

function HealBot_Action_HealsInColourClassHlthMix(button)
      --HealBot_setCall("HealBot_Action_HealsInColourClassHlthMix", button)
    button.health.inhealr,button.health.inhealg,button.health.inhealb=button.health.mixcolr, button.health.mixcolg, button.health.mixcolb
end

function HealBot_Action_HealsInColourRoleHlthMix(button)
      --HealBot_setCall("HealBot_Action_HealsInColourRoleHlthMix", button)
    button.health.inhealr,button.health.inhealg,button.health.inhealb=button.health.rmixcolr, button.health.rmixcolg, button.health.rmixcolb
end

local hbHealsInColourFuncs={[2]=HealBot_Action_HealsInColourHealth,
                            [3]=HealBot_Action_HealsInColourClass,
                            [4]=HealBot_Action_HealsInColourRole,
                            [5]=HealBot_Action_HealsInColourFutureHlth,
                            [6]=HealBot_Action_HealsInColourCustom,
                            [7]=HealBot_Action_HealsInColourClassHlthMix,
                            [8]=HealBot_Action_HealsInColourRoleHlthMix}
function HealBot_Action_UpdateHealsInButton(button)
      --HealBot_setCall("HealBot_Action_UpdateHealsInButton", button)
    auhiHiHealsIn=button.health.incoming
    if hbv_Skins_GetFrameVar("BarIACol", "IC", button.frame)<2 then auhiHiHealsIn=0 end
    
    if auhiHiHealsIn>0 and button.status.enabled then
        auhiHiPct=button.health.current+button.health.incoming
        if auhiHiPct<button.health.max then 
            auhiHiPct=auhiHiPct/button.health.max  
         else
            auhiHiPct=1;
        end
        button.health.inhptc=floor(auhiHiPct*1000)
        hbHealsInColourFuncs[hbv_Skins_GetFrameVar("BarIACol", "IC", button.frame)](button)
        if button.status.range>0 then
            button.health.inheala=HealBot_Action_BarColourAlpha(button, (hbv_Skins_GetFrameVar("BarIACol", "IA", button.frame)*button.status.alpha),2)
        else
            button.health.inheala=HealBot_Action_BarColourAlpha(button, (hbv_Skins_GetFrameVar("BarIACol", "IA", button.frame)*(button.status.alpha/3)),2)
        end
        HealBot_Action_UpdateInHealStatusBarColor(button)
        if not HealBot_Action_luVars["FluidInUse"] then
            button.gref["InHeal"]:SetValue(button.health.inhptc);
        else
            if button.gref["InHeal"]:GetValue() < button.gref["Bar"]:GetValue() then
                button.gref["InHeal"]:SetValue(button.gref["Bar"]:GetValue())
            end
            HealBot_Action_setFluid_InHeal_BarButtons(button)
        end
    else
        button.health.inheala=0
        button.health.inhptc=0
        if not HealBot_Action_luVars["FluidInUse"] or button.status.current<HealBot_Unit_Status["ENABLEDIR"] or button.status.current>HealBot_Unit_Status["PLUGINBARCOL"] then
            button.gref["InHeal"]:SetValue(0)
        end
        HealBot_Action_UpdateInHealStatusBarColor(button)
    end
end

local auaHaPct, auaUnitHealsIn, auaUnitAbsorbsIn=1,0,0
function HealBot_Action_AbsorbsColourHealth(button)
      --HealBot_setCall("HealBot_Action_AbsorbsColourHealth", button)
    button.health.absorbr,button.health.absorbg,button.health.absorbb=button.health.rcol, button.health.gcol,0
end

function HealBot_Action_AbsorbsColourClass(button)
      --HealBot_setCall("HealBot_Action_AbsorbsColourClass", button)
    button.health.absorbr,button.health.absorbg,button.health.absorbb=button.text.r, button.text.g, button.text.b
end

function HealBot_Action_AbsorbsColourRole(button)
      --HealBot_setCall("HealBot_Action_AbsorbsColourRole", button)
    button.health.absorbr=hbCustomRoleCols[button.roletxt].r
    button.health.absorbg=hbCustomRoleCols[button.roletxt].g
    button.health.absorbb=hbCustomRoleCols[button.roletxt].b
end

function HealBot_Action_AbsorbsColourFutureHlth(button)
      --HealBot_setCall("HealBot_Action_AbsorbsColourFutureHlth", button)
    button.health.absorbr, button.health.absorbg=HealBot_Action_BarColourPct(auaHaPct)
    button.health.absorbb=0
end

function HealBot_Action_AbsorbsColourCustom(button)
      --HealBot_setCall("HealBot_Action_AbsorbsColourCustom", button)
    if button.status.hostile then
        if auaHaPct>hbv_Skins_GetFrameVar("BarIACol", "AIT", button.frame) then
            button.health.absorbr=hbv_Skins_GetFrameVar("BarIACol", "ARE", button.frame)
            button.health.absorbg=hbv_Skins_GetFrameVar("BarIACol", "AGE", button.frame)
            button.health.absorbb=hbv_Skins_GetFrameVar("BarIACol", "ABE", button.frame)
        elseif auaHaPct>hbv_Skins_GetFrameVar("BarIACol", "ACT", button.frame) then
            button.health.absorbr=hbv_Skins_GetFrameVar("BarIACol", "AIRE", button.frame)
            button.health.absorbg=hbv_Skins_GetFrameVar("BarIACol", "AIGE", button.frame)
            button.health.absorbb=hbv_Skins_GetFrameVar("BarIACol", "AIBE", button.frame)
        else
            button.health.absorbr=hbv_Skins_GetFrameVar("BarIACol", "ACRE", button.frame)
            button.health.absorbg=hbv_Skins_GetFrameVar("BarIACol", "ACGE", button.frame)
            button.health.absorbb=hbv_Skins_GetFrameVar("BarIACol", "ACBE", button.frame)
        end
    else
        if auaHaPct>hbv_Skins_GetFrameVar("BarIACol", "AIT", button.frame) then
            button.health.absorbr=hbv_Skins_GetFrameVar("BarIACol", "AR", button.frame)
            button.health.absorbg=hbv_Skins_GetFrameVar("BarIACol", "AG", button.frame)
            button.health.absorbb=hbv_Skins_GetFrameVar("BarIACol", "AB", button.frame)
        elseif auaHaPct>hbv_Skins_GetFrameVar("BarIACol", "ACT", button.frame) then
            button.health.absorbr=hbv_Skins_GetFrameVar("BarIACol", "AIR", button.frame)
            button.health.absorbg=hbv_Skins_GetFrameVar("BarIACol", "AIG", button.frame)
            button.health.absorbb=hbv_Skins_GetFrameVar("BarIACol", "AIB", button.frame)
        else
            button.health.absorbr=hbv_Skins_GetFrameVar("BarIACol", "ACR", button.frame)
            button.health.absorbg=hbv_Skins_GetFrameVar("BarIACol", "ACG", button.frame)
            button.health.absorbb=hbv_Skins_GetFrameVar("BarIACol", "ACB", button.frame)
        end
    end
end

function HealBot_Action_AbsorbsColourClassHlthMix(button)
      --HealBot_setCall("HealBot_Action_AbsorbsColourClassHlthMix", button)
    button.health.absorbr,button.health.absorbg,button.health.absorbb=button.health.mixcolr, button.health.mixcolg, button.health.mixcolb
end

function HealBot_Action_AbsorbsColourRoleHlthMix(button)
      --HealBot_setCall("HealBot_Action_AbsorbsColourRoleHlthMix", button)
    button.health.absorbr,button.health.absorbg,button.health.absorbb=button.health.rmixcolr, button.health.rmixcolg, button.health.rmixcolb
end

function HealBot_Action_OverShield(button)
    if HealBot_Data["UILOCK"] and button.health.absorbs>5 and hbv_Skins_GetFrameBoolean("BarIACol", "OSHIELD", button.frame) and (button.health.absorbs+button.health.current) > button.health.max then
        button.gref["Shield"]:SetStatusBarColor(button.health.absorbr,button.health.absorbg,button.health.absorbb, 1)
    else
        button.gref["Shield"]:SetStatusBarColor(0,0,0,0)
    end
end

local hbAbsorbsColourFuncs={[2]=HealBot_Action_AbsorbsColourHealth,
                            [3]=HealBot_Action_AbsorbsColourClass,
                            [4]=HealBot_Action_AbsorbsColourRole,
                            [5]=HealBot_Action_AbsorbsColourFutureHlth,
                            [6]=HealBot_Action_AbsorbsColourCustom,
                            [7]=HealBot_Action_AbsorbsColourClassHlthMix,
                            [8]=HealBot_Action_AbsorbsColourRoleHlthMix}
function HealBot_Action_UpdateAbsorbsButton(button)
      --HealBot_setCall("HealBot_Action_UpdateAbsorbsButton", button)
    auaUnitAbsorbsIn=button.health.absorbs
    if hbv_Skins_GetFrameVar("BarIACol", "AC", button.frame)<2 then auaUnitAbsorbsIn=0 end
    
    if auaUnitAbsorbsIn>0 and button.status.enabled then
        if hbv_Skins_GetFrameVar("BarIACol", "IC", button.frame)<2 then 
            auaUnitHealsIn=0 
        else
            auaUnitHealsIn=button.health.incoming
        end
        auaHaPct=button.health.current+auaUnitHealsIn+auaUnitAbsorbsIn
        if auaHaPct<button.health.max then
            auaHaPct=auaHaPct/button.health.max
        else
            auaHaPct=1;
        end
        button.health.abptc=floor(auaHaPct*1000)
        hbAbsorbsColourFuncs[hbv_Skins_GetFrameVar("BarIACol", "AC", button.frame)](button)
        if button.status.range>0 then
            button.health.absorba=HealBot_Action_BarColourAlpha(button, (hbv_Skins_GetFrameVar("BarIACol", "AA", button.frame)*button.status.alpha),2)
        else
            button.health.absorba=HealBot_Action_BarColourAlpha(button, (hbv_Skins_GetFrameVar("BarIACol", "AA", button.frame)*(button.status.alpha/3)),2)
        end
        HealBot_Action_UpdateAbsorbStatusBarColor(button)
        if not HealBot_Action_luVars["FluidInUse"] then
            button.gref["Absorb"]:SetValue(button.health.abptc);
        else
            if button.gref["Absorb"]:GetValue() < button.gref["InHeal"]:GetValue() then
                button.gref["Absorb"]:SetValue(button.gref["InHeal"]:GetValue())
            elseif button.gref["Absorb"]:GetValue() < button.gref["Bar"]:GetValue() then
                button.gref["Absorb"]:SetValue(button.gref["Bar"]:GetValue())
            end
            HealBot_Action_setFluid_Aborbs_BarButtons(button)
        end
    else
        button.health.absorba=0
        button.health.abptc=0
        if not HealBot_Action_luVars["FluidInUse"] or button.status.current<HealBot_Unit_Status["ENABLEDIR"] or button.status.current>HealBot_Unit_Status["PLUGINBARCOL"] then
            button.gref["Absorb"]:SetValue(0)
        end
        HealBot_Action_UpdateAbsorbStatusBarColor(button)
    end
end

function HealBot_Action_BackgroundBorderColourHazardOnly(button)
      --HealBot_setCall("HealBot_Action_BackgroundBorderColourHazardOnly", button)
    if not HealBot_Hazard_Buttons[button.id] then
        button.gref["BackBorder"]:SetBackdropBorderColor(0,0,0,0)
    end
end

function HealBot_Action_BackgroundBorderColourHealth(button)
      --HealBot_setCall("HealBot_Action_BackgroundBorderColourHealth", button)
    button.gref["BackBorder"]:SetBackdropBorderColor(button.health.rcol, button.health.gcol,0,HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "BORA", button.framecol), 1));
end

local ubbHcR, ubbHcG, ubbHcB=0,0,0
function HealBot_Action_BackgroundBorderColourClass(button)
      --HealBot_setCall("HealBot_Action_BackgroundBorderColourClass", button)
    if button.status.current>HealBot_Unit_Status["PLUGINBARCOL"] then
        ubbHcR,ubbHcG,ubbHcB=0, 0, 0
    else
        ubbHcR,ubbHcG,ubbHcB=button.text.r,button.text.g,button.text.b
    end
    button.gref["BackBorder"]:SetBackdropBorderColor(ubbHcR,ubbHcG,ubbHcB,HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "BORA", button.framecol),1))
end

function HealBot_Action_BackgroundBorderColourRole(button)
      --HealBot_setCall("HealBot_Action_BackgroundBorderColourRole", button)
    if button.status.current>HealBot_Unit_Status["PLUGINBARCOL"] then
        ubbHcR,ubbHcG,ubbHcB=0, 0, 0
    else
        ubbHcR=hbCustomRoleCols[button.roletxt].r
        ubbHcG=hbCustomRoleCols[button.roletxt].g
        ubbHcB=hbCustomRoleCols[button.roletxt].b
    end
    button.gref["BackBorder"]:SetBackdropBorderColor(ubbHcR,ubbHcG,ubbHcB,HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "BORA", button.framecol),1))
end

function HealBot_Action_BackgroundBorderColourCustom(button)
      --HealBot_setCall("HealBot_Action_BackgroundBorderColourCustom", button)
    if button.status.hostile then
        if button.health.pct>hbv_Skins_GetFrameVar("BarCol", "BORIT", button.framecol) then
            button.gref["BackBorder"]:SetBackdropBorderColor(hbv_Skins_GetFrameVar("BarCol", "BORRE", button.framecol),
                                                             hbv_Skins_GetFrameVar("BarCol", "BORGE", button.framecol),
                                                             hbv_Skins_GetFrameVar("BarCol", "BORBE", button.framecol),
                                                             HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "BORA", button.framecol), 1))
        elseif button.health.pct>hbv_Skins_GetFrameVar("BarCol", "BORCT", button.framecol) then
            button.gref["BackBorder"]:SetBackdropBorderColor(hbv_Skins_GetFrameVar("BarCol", "BORIRE", button.framecol),
                                                             hbv_Skins_GetFrameVar("BarCol", "BORIGE", button.framecol),
                                                             hbv_Skins_GetFrameVar("BarCol", "BORIBE", button.framecol),
                                                             HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "BORA", button.framecol), 1))
        else
            button.gref["BackBorder"]:SetBackdropBorderColor(hbv_Skins_GetFrameVar("BarCol", "BORCRE", button.framecol),
                                                             hbv_Skins_GetFrameVar("BarCol", "BORCGE", button.framecol),
                                                             hbv_Skins_GetFrameVar("BarCol", "BORCBE", button.framecol),
                                                             HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "BORA", button.framecol), 1))
        end
    else
        if button.health.pct>hbv_Skins_GetFrameVar("BarCol", "BORIT", button.framecol) then
            button.gref["BackBorder"]:SetBackdropBorderColor(hbv_Skins_GetFrameVar("BarCol", "BORR", button.framecol),
                                                             hbv_Skins_GetFrameVar("BarCol", "BORG", button.framecol),
                                                             hbv_Skins_GetFrameVar("BarCol", "BORB", button.framecol),
                                                             HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "BORA", button.framecol), 1))
        elseif button.health.pct>hbv_Skins_GetFrameVar("BarCol", "BORCT", button.framecol) then
            button.gref["BackBorder"]:SetBackdropBorderColor(hbv_Skins_GetFrameVar("BarCol", "BORIR", button.framecol),
                                                             hbv_Skins_GetFrameVar("BarCol", "BORIG", button.framecol),
                                                             hbv_Skins_GetFrameVar("BarCol", "BORIB", button.framecol),
                                                             HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "BORA", button.framecol), 1))
        else
            button.gref["BackBorder"]:SetBackdropBorderColor(hbv_Skins_GetFrameVar("BarCol", "BORCR", button.framecol),
                                                             hbv_Skins_GetFrameVar("BarCol", "BORCG", button.framecol),
                                                             hbv_Skins_GetFrameVar("BarCol", "BORCB", button.framecol),
                                                             HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "BORA", button.framecol), 1))
        end
    end
end

function HealBot_Action_BackgroundBorderColourClassHlthMix(button)
      --HealBot_setCall("HealBot_Action_BackgroundBorderColourClassHlthMix", button)
    button.gref["BackBorder"]:SetBackdropBorderColor(button.health.mixcolr, button.health.mixcolg,button.health.mixcolb,HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "BORA", button.framecol), 1));
end

function HealBot_Action_BackgroundBorderColourRoleHlthMix(button)
      --HealBot_setCall("HealBot_Action_BackgroundBorderColourRoleHlthMix", button)
    button.gref["BackBorder"]:SetBackdropBorderColor(button.health.rmixcolr, button.health.rmixcolg,button.health.rmixcolb,HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "BORA", button.framecol), 1));
end

function HealBot_Action_BackgroundBorderColourAdaptiveClassMix(button)
      --HealBot_setCall("HealBot_Action_BackgroundBorderColourAdaptiveClassMix", button)
    if button.adaptive.current<12 then
        HealBot_Action_BackgroundBorderColourAdaptive(button)
    else
        button.gref["BackBorder"]:SetBackdropBorderColor(button.text.r,button.text.g,button.text.b,HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "BORA", button.framecol), 1))
    end
end

function HealBot_Action_BackgroundBorderColourAdaptiveRoleMix(button)
      --HealBot_setCall("HealBot_Action_BackgroundBorderColourAdaptiveRoleMix", button)
    if button.adaptive.current<12 then
        HealBot_Action_BackgroundBorderColourAdaptive(button)
    else
        button.gref["BackBorder"]:SetBackdropBorderColor(hbCustomRoleCols[button.roletxt].r,
                                                         hbCustomRoleCols[button.roletxt].g,
                                                         hbCustomRoleCols[button.roletxt].b,
                                                         HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "BORA", button.framecol), 1))
    end
end

function HealBot_Action_BackgroundBorderColourAdaptiveCustomMix(button)
      --HealBot_setCall("HealBot_Action_BackgroundBorderColourAdaptiveCustomMix", button)
    if button.adaptive.current<12 then
        HealBot_Action_BackgroundBorderColourAdaptive(button)
    else
        HealBot_Action_BackgroundBorderColourCustom(button)
    end
end

function HealBot_Action_BackgroundBorderColourAdaptivePlugin(button)
      --HealBot_setCall("HealBot_Action_BackgroundBorderColourAdaptivePlugin", button)
    button.gref["BackBorder"]:SetBackdropBorderColor(button.plugin.r,
                                                     button.plugin.g,
                                                     button.plugin.b,
                                                     HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "BORA", button.framecol), 1));
end

function HealBot_Action_BackgroundBorderColourAdaptiveDebuffs(button)
      --HealBot_setCall("HealBot_Action_BackgroundBorderColourAdaptiveDebuffs", button)
    button.gref["BackBorder"]:SetBackdropBorderColor(button.aura.debuff.r,
                                                     button.aura.debuff.g,
                                                     button.aura.debuff.b,
                                                     HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "BORA", button.framecol), 1));
end

function HealBot_Action_BackgroundBorderColourAdaptiveBuffs(button)
      --HealBot_setCall("HealBot_Action_BackgroundBorderColourAdaptiveBuffs", button)
    button.gref["BackBorder"]:SetBackdropBorderColor(button.aura.buff.r,
                                                     button.aura.buff.g,
                                                     button.aura.buff.b,
                                                     HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "BORA", button.framecol), 1));
end

function HealBot_Action_BackgroundBorderColourAdaptiveGeneric(button)
      --HealBot_setCall("HealBot_Action_BackgroundBorderColourAdaptiveGeneric", button)
    button.gref["BackBorder"]:SetBackdropBorderColor(hbAdaptiveCol[hbAdaptiveOrder[button.adaptive.current]].R,
                                                     hbAdaptiveCol[hbAdaptiveOrder[button.adaptive.current]].G,
                                                     hbAdaptiveCol[hbAdaptiveOrder[button.adaptive.current]].B,
                                                     HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "BORA", button.framecol), 1));
end

local dAlpha=1
function HealBot_Action_BackgroundBorderColourAdaptiveOverheals(button)
      --HealBot_setCall("HealBot_Action_BackgroundBorderColourAdaptiveOverheals", button)
    dAlpha=(button.health.overheal/button.health.max)*10
    if dAlpha>1 then dAlpha=1 end
    button.gref["BackBorder"]:SetBackdropBorderColor(hbAdaptiveCol[hbAdaptiveOrder[button.adaptive.current]].R,
                                                     hbAdaptiveCol[hbAdaptiveOrder[button.adaptive.current]].G,
                                                     hbAdaptiveCol[hbAdaptiveOrder[button.adaptive.current]].B,
                                                     HealBot_Action_BarColourAlpha(button, dAlpha, 1));
end

function HealBot_Action_BackgroundBorderColourAdaptiveAbsorbs(button)
      --HealBot_setCall("HealBot_Action_BackgroundBorderColourAdaptiveAbsorbs", button)
    dAlpha=(button.health.absorbs/button.health.max)*10
    if dAlpha>1 then dAlpha=1 end
    button.gref["BackBorder"]:SetBackdropBorderColor(hbAdaptiveCol[hbAdaptiveOrder[button.adaptive.current]].R,
                                                     hbAdaptiveCol[hbAdaptiveOrder[button.adaptive.current]].G,
                                                     hbAdaptiveCol[hbAdaptiveOrder[button.adaptive.current]].B,
                                                     HealBot_Action_BarColourAlpha(button, dAlpha, 1));
end

function HealBot_Action_BackgroundBorderColourAdaptiveThreat(button)
      --HealBot_setCall("HealBot_Action_BackgroundBorderColourAdaptiveThreat", button)
    dAlpha=button.aggro.threatpct/100
    if dAlpha>1 then dAlpha=1 end
    button.gref["BackBorder"]:SetBackdropBorderColor(hbAdaptiveCol[hbAdaptiveOrder[button.adaptive.current]].R,
                                                     hbAdaptiveCol[hbAdaptiveOrder[button.adaptive.current]].G,
                                                     hbAdaptiveCol[hbAdaptiveOrder[button.adaptive.current]].B,
                                                     HealBot_Action_BarColourAlpha(button, dAlpha, 1));
end

function HealBot_Action_BackgroundBorderColourAdaptiveNone(button)
      --HealBot_setCall("HealBot_Action_BackgroundBorderColourAdaptiveNone", button)
    button.gref["BackBorder"]:SetBackdropBorderColor(0,0,0,0)
end

local hbBackgroundBorderColourAdaptiveFuncs={["Plugin"]=HealBot_Action_BackgroundBorderColourAdaptivePlugin,
                                             ["RecentHeals"]=HealBot_Action_BackgroundBorderColourAdaptiveGeneric,
                                             ["Threat"]=HealBot_Action_BackgroundBorderColourAdaptiveThreat,
                                             ["Debuffs"]=HealBot_Action_BackgroundBorderColourAdaptiveDebuffs,
                                             ["Aggro"]=HealBot_Action_BackgroundBorderColourAdaptiveGeneric,
                                             ["Highlight"]=HealBot_Action_BackgroundBorderColourAdaptiveGeneric,
                                             ["Target"]=HealBot_Action_BackgroundBorderColourAdaptiveGeneric,
                                             ["OOR"]=HealBot_Action_BackgroundBorderColourAdaptiveGeneric,
                                             ["Buffs"]=HealBot_Action_BackgroundBorderColourAdaptiveBuffs,
                                             ["Overheals"]=HealBot_Action_BackgroundBorderColourAdaptiveOverheals,
                                             ["Absorbs"]=HealBot_Action_BackgroundBorderColourAdaptiveAbsorbs,
                                             ["None"]=HealBot_Action_BackgroundBorderColourAdaptiveNone}

function HealBot_Action_BackgroundBorderColourAdaptive(button)
      --HealBot_setCall("HealBot_Action_BackgroundBorderColourAdaptive", button)
    hbBackgroundBorderColourAdaptiveFuncs[hbAdaptiveOrder[button.adaptive.current]](button)
end

function HealBot_Action_AdaptiveAggroUpdate(button)
      --HealBot_setCall("HealBot_Action_AdaptiveAggroUpdate", button)
    if hbAdaptive["Aggro"] and button.status.current<HealBot_Unit_Status["DC"] and button.aggro.status == 3 then
        if hbAdaptiveOrderName["Aggro"]<button.adaptive.current then
            button.adaptive.current=hbAdaptiveOrderName["Aggro"]
            HealBot_Action_UpdateBackground(button)
        end
        button.adaptive[hbAdaptiveOrderName["Aggro"]]=true
    else
        HealBot_Action_AdaptiveNextActive(button, hbAdaptiveOrderName["Aggro"], true)
    end
end

function HealBot_Action_AdaptiveThreatUpdate(button)
      --HealBot_setCall("HealBot_Action_AdaptiveThreatUpdate", button)
    if hbAdaptive["Threat"] and button.status.current<HealBot_Unit_Status["DC"] and button.aggro.threatpct>25 then
        if hbAdaptiveOrderName["Threat"]<button.adaptive.current then
            button.adaptive.current=hbAdaptiveOrderName["Threat"]
            HealBot_Action_UpdateBackground(button)
        end
        button.adaptive[hbAdaptiveOrderName["Threat"]]=true
    else
        HealBot_Action_AdaptiveNextActive(button, hbAdaptiveOrderName["Threat"], true)
    end
end

function HealBot_Action_AdaptiveOORUpdate(button)
      --HealBot_setCall("HealBot_Action_AdaptiveOORUpdate", button)
    if hbAdaptive["OOR"] and button.status.current<HealBot_Unit_Status["DC"] and button.status.range<1 then
        if hbAdaptiveOrderName["OOR"]<button.adaptive.current then
            button.adaptive.current=hbAdaptiveOrderName["OOR"]
        end
        button.adaptive[hbAdaptiveOrderName["OOR"]]=true
    else
        HealBot_Action_AdaptiveNextActive(button, hbAdaptiveOrderName["OOR"])
    end
end

function HealBot_Action_AdaptiveOverhealsUpdate(button)
      --HealBot_setCall("HealBot_Action_AdaptiveOverhealsUpdate", button)
    if hbAdaptive["Overheals"] and button.status.current<HealBot_Unit_Status["DC"] and (button.health.overheal/button.health.max)>0.025 then
        if hbAdaptiveOrderName["Overheals"]<=button.adaptive.current then
            button.adaptive.current=hbAdaptiveOrderName["Overheals"]
            HealBot_Action_UpdateBackground(button)
        end
        button.adaptive[hbAdaptiveOrderName["Overheals"]]=true
    else
        HealBot_Action_AdaptiveNextActive(button, hbAdaptiveOrderName["Overheals"], true)
    end
end

function HealBot_Action_AdaptiveAbsorbsUpdate(button)
      --HealBot_setCall("HealBot_Action_AdaptiveAbsorbsUpdate", button)
    if hbAdaptive["Absorbs"] and button.status.current<HealBot_Unit_Status["DC"] and (button.health.absorbs/button.health.max)>0.025 then
        if hbAdaptiveOrderName["Absorbs"]<=button.adaptive.current then
            button.adaptive.current=hbAdaptiveOrderName["Absorbs"]
            HealBot_Action_UpdateBackground(button)
        end
        button.adaptive[hbAdaptiveOrderName["Absorbs"]]=true
    else
        HealBot_Action_AdaptiveNextActive(button, hbAdaptiveOrderName["Absorbs"], true)
    end
end

function HealBot_Action_AdaptiveTargetEnable(button)
      --HealBot_setCall("HealBot_Action_AdaptiveTargetEnable", button)
    if hbAdaptive["Target"] and button.status.current<HealBot_Unit_Status["DC"] then
        if hbAdaptiveOrderName["Target"]<button.adaptive.current then
            button.adaptive.current=hbAdaptiveOrderName["Target"]
            HealBot_Action_UpdateBackground(button)
        end
        button.adaptive[hbAdaptiveOrderName["Target"]]=true
    end
end

function HealBot_Action_AdaptiveTargetDisable(button)
      --HealBot_setCall("HealBot_Action_AdaptiveTargetDisable", button)
    HealBot_Action_AdaptiveNextActive(button, hbAdaptiveOrderName["Target"], true)
end

function HealBot_Action_AdaptiveRecentHealsEnable(button)
      --HealBot_setCall("HealBot_Action_AdaptiveRecentHealsEnable", button)
    if hbAdaptive["RecentHeals"] and button.status.current<HealBot_Unit_Status["DC"] then
        if hbAdaptiveOrderName["RecentHeals"]<button.adaptive.current then
            button.adaptive.current=hbAdaptiveOrderName["RecentHeals"]
            HealBot_Action_UpdateBackground(button)
        end
        button.adaptive[hbAdaptiveOrderName["RecentHeals"]]=true
    end
end

function HealBot_Action_AdaptiveRecentHealsDisable(button)
      --HealBot_setCall("HealBot_Action_AdaptiveRecentHealsDisable", button)
    HealBot_Action_AdaptiveNextActive(button, hbAdaptiveOrderName["RecentHeals"], true)
end

local hbBackgroundBorderColourFuncs={[1]=HealBot_Action_BackgroundBorderColourHazardOnly,
                                     [2]=HealBot_Action_BackgroundBorderColourHealth,
                                     [3]=HealBot_Action_BackgroundBorderColourClass,
                                     [4]=HealBot_Action_BackgroundBorderColourRole,
                                     [5]=HealBot_Action_BackgroundBorderColourCustom,
                                     [6]=HealBot_Action_BackgroundBorderColourClassHlthMix,
                                     [7]=HealBot_Action_BackgroundBorderColourRoleHlthMix,
                                     [8]=HealBot_Action_BackgroundBorderColourAdaptiveClassMix,
                                     [9]=HealBot_Action_BackgroundBorderColourAdaptiveRoleMix,
                                    [10]=HealBot_Action_BackgroundBorderColourAdaptiveCustomMix,
                                    [11]=HealBot_Action_BackgroundBorderColourAdaptive}
function HealBot_Action_UpdateBackgroundBorder(button)
      --HealBot_setCall("HealBot_Action_UpdateBackgroundBorder", button)
    if button.status.current<HealBot_Unit_Status["DC"] then
        hbBackgroundBorderColourFuncs[hbv_Skins_GetFrameVar("BarCol", "BORDER", button.framecol)](button)
    else
        HealBot_Action_BackgroundBorderColourAdaptiveNone(button)
    end
end

function HealBot_Action_BackgroundColourHealth(button)
      --HealBot_setCall("HealBot_Action_BackgroundColourHealth", button)
    button.gref["Back"]:SetStatusBarColor(button.health.rcol, button.health.gcol,0,HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "BA", button.framecol), 1.5));
end

function HealBot_Action_BackgroundColourClass(button)
      --HealBot_setCall("HealBot_Action_BackgroundColourClass", button)
    if button.status.current>HealBot_Unit_Status["PLUGINBARCOL"] then
        ubbHcR,ubbHcG,ubbHcB=0, 0, 0
    else
        ubbHcR,ubbHcG,ubbHcB=button.text.r,button.text.g,button.text.b
    end
    button.gref["Back"]:SetStatusBarColor(ubbHcR,ubbHcG,ubbHcB,HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "BA", button.framecol),1.5));
end

function HealBot_Action_BackgroundColourRole(button)
      --HealBot_setCall("HealBot_Action_BackgroundColourRole", button)
    if button.status.current>HealBot_Unit_Status["PLUGINBARCOL"] then
        ubbHcR,ubbHcG,ubbHcB=0, 0, 0
    else
        ubbHcR=hbCustomRoleCols[button.roletxt].r
        ubbHcG=hbCustomRoleCols[button.roletxt].g
        ubbHcB=hbCustomRoleCols[button.roletxt].b
    end
    button.gref["Back"]:SetStatusBarColor(ubbHcR,ubbHcG,ubbHcB,HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "BA", button.framecol),1.5));
end

function HealBot_Action_BackgroundColourCustom(button)
      --HealBot_setCall("HealBot_Action_BackgroundColourCustom", button)
    if button.status.hostile then
        if button.health.pct>hbv_Skins_GetFrameVar("BarCol", "BIT", button.framecol) then
            button.gref["Back"]:SetStatusBarColor(hbv_Skins_GetFrameVar("BarCol", "BRE", button.framecol),
                                                  hbv_Skins_GetFrameVar("BarCol", "BGE", button.framecol),
                                                  hbv_Skins_GetFrameVar("BarCol", "BBE", button.framecol),
                                                  HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "BA", button.framecol), 1.5))
        elseif button.health.pct>hbv_Skins_GetFrameVar("BarCol", "BCT", button.framecol) then
            button.gref["Back"]:SetStatusBarColor(hbv_Skins_GetFrameVar("BarCol", "BIRE", button.framecol),
                                                  hbv_Skins_GetFrameVar("BarCol", "BIGE", button.framecol),
                                                  hbv_Skins_GetFrameVar("BarCol", "BIBE", button.framecol),
                                                  HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "BA", button.framecol), 1.5))
        else
            button.gref["Back"]:SetStatusBarColor(hbv_Skins_GetFrameVar("BarCol", "BCRE", button.framecol),
                                                  hbv_Skins_GetFrameVar("BarCol", "BCGE", button.framecol),
                                                  hbv_Skins_GetFrameVar("BarCol", "BCBE", button.framecol),
                                                  HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "BA", button.framecol), 1.5))
        end
    else
        if button.health.pct>hbv_Skins_GetFrameVar("BarCol", "BIT", button.framecol) then
            button.gref["Back"]:SetStatusBarColor(hbv_Skins_GetFrameVar("BarCol", "BR", button.framecol),
                                                  hbv_Skins_GetFrameVar("BarCol", "BG", button.framecol),
                                                  hbv_Skins_GetFrameVar("BarCol", "BB", button.framecol),
                                                  HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "BA", button.framecol), 1.5))
        elseif button.health.pct>hbv_Skins_GetFrameVar("BarCol", "BCT", button.framecol) then
            button.gref["Back"]:SetStatusBarColor(hbv_Skins_GetFrameVar("BarCol", "BIR", button.framecol),
                                                  hbv_Skins_GetFrameVar("BarCol", "BIG", button.framecol),
                                                  hbv_Skins_GetFrameVar("BarCol", "BIB", button.framecol),
                                                  HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "BA", button.framecol), 1.5))
        else
            button.gref["Back"]:SetStatusBarColor(hbv_Skins_GetFrameVar("BarCol", "BCR", button.framecol),
                                                  hbv_Skins_GetFrameVar("BarCol", "BCG", button.framecol),
                                                  hbv_Skins_GetFrameVar("BarCol", "BCB", button.framecol),
                                                  HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "BA", button.framecol), 1.5))
        end
    end
end

function HealBot_Action_BackgroundColourClassHlthMix(button)
      --HealBot_setCall("HealBot_Action_BackgroundColourClassHlthMix", button)
    button.gref["Back"]:SetStatusBarColor(button.health.mixcolr, button.health.mixcolg,button.health.mixcolb,HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "BA", button.framecol), 1.5));
end

function HealBot_Action_BackgroundColourRoleHlthMix(button)
      --HealBot_setCall("HealBot_Action_BackgroundColourRoleHlthMix", button)
    button.gref["Back"]:SetStatusBarColor(button.health.rmixcolr, button.health.rmixcolg,button.health.rmixcolb,HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "BA", button.framecol), 1.5));
end

function HealBot_Action_BackgroundColourAdaptiveClassMix(button)
      --HealBot_setCall("HealBot_Action_BackgroundColourAdaptiveClassMix", button)
    if button.adaptive.current<12 then
        HealBot_Action_BackgroundColourAdaptive(button)
    else
        button.gref["Back"]:SetStatusBarColor(button.text.r,button.text.g,button.text.b,HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "BA", button.framecol), 1.5))
    end
end

function HealBot_Action_BackgroundColourAdaptiveRoleMix(button)
      --HealBot_setCall("HealBot_Action_BackgroundColourAdaptiveRoleMix", button)
    if button.adaptive.current<12 then
        HealBot_Action_BackgroundColourAdaptive(button)
    else
        button.gref["Back"]:SetStatusBarColor(hbCustomRoleCols[button.roletxt].r,
                                              hbCustomRoleCols[button.roletxt].g,
                                              hbCustomRoleCols[button.roletxt].b,
                                              HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "BA", button.framecol), 1.5))
    end
end

function HealBot_Action_BackgroundColourAdaptiveCustomMix(button)
      --HealBot_setCall("HealBot_Action_BackgroundColourAdaptiveCustomMix", button)
    if button.adaptive.current<12 then
        HealBot_Action_BackgroundColourAdaptive(button)
    else
        HealBot_Action_BackgroundColourCustom(button)
    end
end

function HealBot_Action_BackgroundColourAdaptivePlugin(button)
      --HealBot_setCall("HealBot_Action_BackgroundColourAdaptivePlugin", button)
    button.gref["Back"]:SetStatusBarColor(button.plugin.r,
                                               button.plugin.g,
                                               button.plugin.b,
                                               HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "BORA", button.framecol), 1));
end

function HealBot_Action_BackgroundColourAdaptiveDebuffs(button)
      --HealBot_setCall("HealBot_Action_BackgroundColourAdaptiveDebuffs", button)
    button.gref["Back"]:SetStatusBarColor(button.aura.debuff.r,
                                               button.aura.debuff.g,
                                               button.aura.debuff.b,
                                               HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "BORA", button.framecol), 1));
end

function HealBot_Action_BackgroundColourAdaptiveBuffs(button)
      --HealBot_setCall("HealBot_Action_BackgroundColourAdaptiveBuffs", button)
    button.gref["Back"]:SetStatusBarColor(button.aura.buff.r,
                                               button.aura.buff.g,
                                               button.aura.buff.b,
                                               HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "BORA", button.framecol), 1));
end

function HealBot_Action_BackgroundColourAdaptiveGeneric(button)
      --HealBot_setCall("HealBot_Action_BackgroundColourAdaptiveGeneric", button)
    button.gref["Back"]:SetStatusBarColor(hbAdaptiveCol[hbAdaptiveOrder[button.adaptive.current]].R,
                                               hbAdaptiveCol[hbAdaptiveOrder[button.adaptive.current]].G,
                                               hbAdaptiveCol[hbAdaptiveOrder[button.adaptive.current]].B,
                                               HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "BORA", button.framecol), 1));
end

local dAlpha=1
function HealBot_Action_BackgroundColourAdaptiveOverheals(button)
      --HealBot_setCall("HealBot_Action_BackgroundColourAdaptiveOverheals", button)
    dAlpha=(button.health.overheal/button.health.max)*10
    if dAlpha>1 then dAlpha=1 end
    button.gref["Back"]:SetStatusBarColor(hbAdaptiveCol[hbAdaptiveOrder[button.adaptive.current]].R,
                                               hbAdaptiveCol[hbAdaptiveOrder[button.adaptive.current]].G,
                                               hbAdaptiveCol[hbAdaptiveOrder[button.adaptive.current]].B,
                                               HealBot_Action_BarColourAlpha(button, dAlpha, 1));
end

function HealBot_Action_BackgroundColourAdaptiveAbsorbs(button)
      --HealBot_setCall("HealBot_Action_BackgroundColourAdaptiveAbsorbs", button)
    dAlpha=(button.health.absorbs/button.health.max)*10
    if dAlpha>1 then dAlpha=1 end
    button.gref["Back"]:SetStatusBarColor(hbAdaptiveCol[hbAdaptiveOrder[button.adaptive.current]].R,
                                               hbAdaptiveCol[hbAdaptiveOrder[button.adaptive.current]].G,
                                               hbAdaptiveCol[hbAdaptiveOrder[button.adaptive.current]].B,
                                               HealBot_Action_BarColourAlpha(button, dAlpha, 1));
end

function HealBot_Action_BackgroundColourAdaptiveThreat(button)
      --HealBot_setCall("HealBot_Action_BackgroundColourAdaptiveThreat", button)
    dAlpha=button.aggro.threatpct/100
    if dAlpha>1 then dAlpha=1 end
    button.gref["Back"]:SetStatusBarColor(hbAdaptiveCol[hbAdaptiveOrder[button.adaptive.current]].R,
                                               hbAdaptiveCol[hbAdaptiveOrder[button.adaptive.current]].G,
                                               hbAdaptiveCol[hbAdaptiveOrder[button.adaptive.current]].B,
                                               HealBot_Action_BarColourAlpha(button, dAlpha, 1));
end

function HealBot_Action_BackgroundColourAdaptiveNone(button)
      --HealBot_setCall("HealBot_Action_BackgroundColourAdaptiveNone", button)
    button.gref["Back"]:SetStatusBarColor(0,0,0,0)
end

local hbBackgroundColourAdaptiveFuncs={["Plugin"]=HealBot_Action_BackgroundColourAdaptivePlugin,
                                       ["RecentHeals"]=HealBot_Action_BackgroundColourAdaptiveGeneric,
                                       ["Threat"]=HealBot_Action_BackgroundColourAdaptiveThreat,
                                       ["Debuffs"]=HealBot_Action_BackgroundColourAdaptiveDebuffs,
                                       ["Aggro"]=HealBot_Action_BackgroundColourAdaptiveGeneric,
                                       ["Highlight"]=HealBot_Action_BackgroundColourAdaptiveGeneric,
                                       ["Target"]=HealBot_Action_BackgroundColourAdaptiveGeneric,
                                       ["OOR"]=HealBot_Action_BackgroundColourAdaptiveGeneric,
                                       ["Buffs"]=HealBot_Action_BackgroundColourAdaptiveBuffs,
                                       ["Overheals"]=HealBot_Action_BackgroundColourAdaptiveOverheals,
                                       ["Absorbs"]=HealBot_Action_BackgroundColourAdaptiveAbsorbs,
                                       ["None"]=HealBot_Action_BackgroundColourAdaptiveNone}

function HealBot_Action_BackgroundColourAdaptive(button)
      --HealBot_setCall("HealBot_Action_BackgroundColourAdaptive", button)
    hbBackgroundColourAdaptiveFuncs[hbAdaptiveOrder[button.adaptive.current]](button)
end

local hbBackgroundColourFuncs={[1]=HealBot_Action_BackgroundColourHealth,
                               [2]=HealBot_Action_BackgroundColourClass,
                               [3]=HealBot_Action_BackgroundColourRole,
                               [4]=HealBot_Action_BackgroundColourCustom,
                               [5]=HealBot_Action_BackgroundColourClassHlthMix,
                               [6]=HealBot_Action_BackgroundColourRoleHlthMix,
                               [7]=HealBot_Action_BackgroundColourAdaptiveClassMix,
                               [8]=HealBot_Action_BackgroundColourAdaptiveRoleMix,
                               [9]=HealBot_Action_BackgroundColourAdaptiveCustomMix,
                              [10]=HealBot_Action_BackgroundColourAdaptive}
function HealBot_Action_UpdateHealthBackground(button)
      --HealBot_setCall("HealBot_Action_UpdateHealthBackground", button)
    if button.status.current<HealBot_Unit_Status["DC"] then
        hbBackgroundColourFuncs[hbv_Skins_GetFrameVar("BarCol", "BACK", button.framecol)](button)
    else
        button.gref["Back"]:SetStatusBarColor(0.1,0.1,0.1,0.75)
    end
end

function HealBot_Action_UpdateBackground(button)
      --HealBot_setCall("HealBot_Action_UpdateBackground", button)
    HealBot_Action_UpdateHealthBackground(button)
    if not HealBot_Hazard_Buttons[button.id] then
        HealBot_Action_UpdateBackgroundBorder(button)
    elseif button.status.current>HealBot_Unit_Status["RES"] then
        HealBot_Action_DisableBorderHazard(button)
    end
end

function HealBot_Action_setState(button, state)
      --HealBot_setCall("HealBot_Action_setState", button)
    if button.status.current~=state then
        button.status.current=state
        if state>HealBot_Unit_Status["PLUGINBARCOL"] then 
            if button.hotbars.state then HealBot_Action_BarHotRemove(button) end
            if HealBot_Hazard_Buttons[button.id] then 
                HealBot_Action_DisableBorderHazard(button)
                button.hazard.hlthdrop=false
                button.hazard.plugin=false
                button.hazard.debuff=false
                button.hazard.aggro=false
                button.hazard.buff=false
            end
            button.status.hlthupd=false
        elseif state == HealBot_Unit_Status["BUFFBARCOL"] or state == HealBot_Unit_Status["DEBUFFBARCOL"] or state == HealBot_Unit_Status["PLUGINBARCOL"] then
            button.status.hlthupd=false
        else
            button.status.hlthupd=true
            if state == HealBot_Unit_Status["CHECK"] then
                HealBot_Range_ButtonSpell(button)
            end
        end
    end
end

function HealBot_Action_setEnabled(button, enabled, a)
      --HealBot_setCall("HealBot_Action_setEnabled", button)
    if button.status.enabled~=enabled then
        button.status.enabled=enabled
        HealBot_Action_ShowHideFrames(button) 
        HealBot_Text_UpdateButton(button)
    end
    if button.status.alpha~=a then
        button.status.alpha=a
        HealBot_Aux_UpdBar(button)
        HealBot_Aura_Update_AllIcons(button)
        if button.health.incoming>0 then HealBot_Action_UpdateHealsInButton(button) end
        if button.health.absorbs>0 then HealBot_Action_UpdateAbsorbsButton(button) end
    end
end

function HealBot_Action_UpdateAbsorbStatusBarColor(button)
      --HealBot_setCall("HealBot_Action_UpdateAbsorbStatusBarColor", button)
    button.gref["Absorb"]:SetStatusBarColor(button.health.absorbr,button.health.absorbg,button.health.absorbb,button.health.absorba);
end

function HealBot_Action_UpdateInHealStatusBarColor(button)
      --HealBot_setCall("HealBot_Action_UpdateInHealStatusBarColor", button)
    button.gref["InHeal"]:SetStatusBarColor(button.health.inhealr,button.health.inhealg,button.health.inhealb,button.health.inheala);
end

function HealBot_Action_UpdateHealthStatusBarColor(button)
      --HealBot_setCall("HealBot_Action_UpdateHealthStatusBarColor", button)
    if not HealBot_Action_luVars["TestBarsOn"] then
        button.gref["Bar"]:SetStatusBarColor(button.status.r,button.status.g,button.status.b,button.status.alpha);
    end
end

local curAlpha=0
function HealBot_Action_UpdatePluginBarCol(button, r, g, b)
      --HealBot_setCall("HealBot_Action_UpdatePluginBarCol", button)
    if button.request.colbar>0 and button.request.colbar<4 then
        button.plugin.colbar=button.request.colbar
    elseif button.aurawatch.colbar>0 and button.aurawatch.colbar<4 then
        button.plugin.colbar=button.aurawatch.colbar
    elseif button.healthwatch.colbar>0 and button.healthwatch.colbar<4 then
        button.plugin.colbar=button.healthwatch.colbar
    elseif button.manawatch.colbar>0 and button.manawatch.colbar<4 then
        button.plugin.colbar=button.manawatch.colbar
    else
        button.plugin.colbar=0
    end
    if button.plugin.colbar>0 then
        if r and button.status.current<HealBot_Unit_Status["DEAD"] then
            button.plugin.r,button.plugin.g,button.plugin.b=r,g,b
            if button.plugin.colbar>1 then
                button.status.r,button.status.g,button.status.b=r, g, b
                HealBot_Action_setState(button, HealBot_Unit_Status["PLUGINBARCOL"])
                if button.status.range>0 then  
                    curAlpha=HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "HA", button.framecol),1)
                else
                    curAlpha=HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "ORA", button.framecol),1)
                end
                HealBot_Action_setEnabled(button, true, curAlpha)
                HealBot_Action_UpdateHealthStatusBarColor(button)
                HealBot_Action_UpdateBackground(button)
            end
            if hbAdaptive["Plugin"] and button.plugin.colbar<3 then
                if hbAdaptiveOrderName["Plugin"]<button.adaptive.current then
                    button.adaptive.current=hbAdaptiveOrderName["Plugin"]
                end
                button.adaptive[hbAdaptiveOrderName["Plugin"]]=true
            else
                HealBot_Action_AdaptiveNextActive(button, hbAdaptiveOrderName["Plugin"])
            end
        end
    elseif UnitExists(button.unit) then
        HealBot_Action_AdaptiveNextActive(button, hbAdaptiveOrderName["Plugin"])
        if button.status.current>HealBot_Unit_Status["DEBUFFBARCOL"] then HealBot_Action_setState(button, HealBot_Unit_Status["CHECK"]) end
        --HealBot_Action_UpdateDebuffButton(button)
        HealBot_RefreshUnit(button)
    end
end

function HealBot_Action_UpdateRequestButton(button, r, g, b)
      --HealBot_setCall("HealBot_Action_UpdateRequestButton", button)
    HealBot_Action_UpdatePluginBarCol(button, r, g, b)
    if button.request.colbar == 4 then
        HealBot_Action_EnableBorderHazardType(button, r, g, b, "PLUGIN")
    elseif button.request.colbar>4 then
        HealBot_Action_EnableButtonGlowType(button, r, g, b, "PLUGIN", "R", button.request.colbar)
    end
end

function HealBot_Action_UpdateAuraWatchButton(button, index, barCol, r, g, b)
      --HealBot_setCall("HealBot_Action_UpdateAuraWatchButton", button)
    if barCol == 4 then
        HealBot_Action_EnableBorderHazardType(button, r, g, b, "PLUGIN")
    elseif barCol>4 then
        HealBot_Action_EnableButtonGlowType(button, r, g, b, "PLUGIN", "AW"..index, barCol)
    elseif barCol<4 then
        HealBot_Action_UpdatePluginBarCol(button, r, g, b)
    end
end

function HealBot_Action_UpdateHealthWatchButton(button, r, g, b)
      --HealBot_setCall("HealBot_Action_UpdateHealthWatchButton", button)
    HealBot_Action_UpdatePluginBarCol(button, r, g, b)
    if button.healthwatch.colbar == 4 then
        HealBot_Action_EnableBorderHazardType(button, r, g, b, "PLUGIN")
    elseif button.healthwatch.colbar>4 then
        HealBot_Action_EnableButtonGlowType(button, r, g, b, "PLUGIN", "HW", button.healthwatch.colbar)
    end
end

function HealBot_Action_UpdateManaWatchButton(button, r, g, b)
      --HealBot_setCall("HealBot_Action_UpdateManaWatchButton", button)
    HealBot_Action_UpdatePluginBarCol(button, r, g, b)
    if button.manawatch.colbar == 4 then
        HealBot_Action_EnableBorderHazardType(button, r, g, b, "PLUGIN")
    elseif button.manawatch.colbar>4 then
        HealBot_Action_EnableButtonGlowType(button, r, g, b, "PLUGIN", "MW", button.manawatch.colbar)
    end
end

function HealBot_Action_UpdateDebuffButton(button)
      --HealBot_setCall("HealBot_Action_UpdateDebuffButton", button)
    if hbAdaptive["Debuffs"] and button.aura.debuff.colbar>0 and button.aura.debuff.colbar<3 then
        if hbAdaptiveOrderName["Debuffs"]<button.adaptive.current then
            button.adaptive.current=hbAdaptiveOrderName["Debuffs"]
        end
        button.adaptive[hbAdaptiveOrderName["Debuffs"]]=true
    else
        HealBot_Action_AdaptiveNextActive(button, hbAdaptiveOrderName["Debuffs"])
    end
    if button.status.current<HealBot_Unit_Status["PLUGINBARCOL"] then
        if HealBot_Config_Cures.CDCshownHB and (button.aura.debuff.colbar == 2 or button.aura.debuff.colbar == 3) and (button.aura.debuff.dispellable or not HealBot_Config_Cures.CDCshownHBDispelOnly) then 
            if HealBot_Aura_IsCureSpell(button) then
                HealBot_Range_ButtonSpell(button, button.aura.debuff.curespell)
            end
            if HealBot_Range_WarnInRange(button, button.aura.debuff.curespell, HealBot_Config_Cures.WarnRange_Bar) then
                button.status.r,button.status.g,button.status.b=button.aura.debuff.r,button.aura.debuff.g,button.aura.debuff.b
                HealBot_Action_setState(button, HealBot_Unit_Status["DEBUFFBARCOL"])
                if button.status.range>0 then
                    curAlpha=HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "HA", button.framecol),1)
                else
                    curAlpha=HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "ORA", button.framecol),1)
                end
                HealBot_Action_setEnabled(button, true, curAlpha)
                HealBot_Action_UpdateHealthStatusBarColor(button)
                if hbv_Skins_GetFrameBoolean("Emerg", "DEBUFFBARCOL", button.frame) then
                    HealBot_Action_EmergBarCheck(button)
                end
                HealBot_Action_UpdateBackground(button)
            else
                HealBot_Action_setState(button, HealBot_Unit_Status["DEBUFFNOCOL"])
            end
        elseif button.aura.debuff.name and HealBot_Config_Cures.EnableBar then
            HealBot_Action_setState(button, HealBot_Unit_Status["DEBUFFNOCOL"])
        elseif button.status.current>HealBot_Unit_Status["BUFFBARCOL"] then 
            HealBot_Action_setState(button, HealBot_Unit_Status["CHECK"])
        end
        HealBot_Action_UpdateBuffButton(button)
    else
        HealBot_Action_UpdateHealthButton(button)
    end
end

function HealBot_Action_UpdateBuffButton(button)
      --HealBot_setCall("HealBot_Action_UpdateBuffButton", button)
    if hbAdaptive["Buffs"] and button.aura.buff.colbar>0 and button.aura.buff.colbar<3 and button.status.current<HealBot_Unit_Status["DC"] then
        if hbAdaptiveOrderName["Buffs"]<button.adaptive.current then
            button.adaptive.current=hbAdaptiveOrderName["Buffs"]
        end
        button.adaptive[hbAdaptiveOrderName["Buffs"]]=true
    else
        HealBot_Action_AdaptiveNextActive(button, hbAdaptiveOrderName["Buffs"])
    end
    if button.status.current<HealBot_Unit_Status["DEBUFFBARCOL"] then
        if HealBot_Config_Buffs.CBshownHB and (button.aura.buff.colbar == 2 or button.aura.buff.colbar == 3) and (button.aura.buff.missingbuff or not HealBot_Config_Buffs.CBshownHBMissingOnly) then 
            if button.status.current<HealBot_Unit_Status["DEBUFFNOCOL"] and button.aura.buff.missingbuff then
                HealBot_Range_ButtonSpell(button, button.aura.buff.missingbuff)
            end
            if HealBot_Range_WarnInRange(button, button.aura.buff.name, HealBot_Config_Buffs.WarnRange_Bar) then
                HealBot_Action_setState(button, HealBot_Unit_Status["BUFFBARCOL"])
                button.status.r,button.status.g,button.status.b=button.aura.buff.r,button.aura.buff.g,button.aura.buff.b
                if button.status.range>0 then  
                    curAlpha=HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "HA", button.framecol), 1)
                else
                    curAlpha=HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "ORA", button.framecol), 1)
                end
                HealBot_Action_setEnabled(button, true, curAlpha)
                HealBot_Action_UpdateHealthStatusBarColor(button)
                if hbv_Skins_GetFrameBoolean("Emerg", "BUFFBARCOL", button.frame) then
                    HealBot_Action_EmergBarCheck(button)
                end
            elseif button.status.current<HealBot_Unit_Status["DEBUFFNOCOL"] then
                HealBot_Action_setState(button, HealBot_Unit_Status["BUFFNOCOL"])
            end
        elseif button.status.current<HealBot_Unit_Status["DEBUFFNOCOL"] then
            if button.aura.buff.missingbuff and HealBot_Config_Buffs.EnableBar then
                HealBot_Action_setState(button, HealBot_Unit_Status["BUFFNOCOL"])
            elseif button.status.current>HealBot_Unit_Status["ENABLEDIR"] then
                HealBot_Action_setState(button, HealBot_Unit_Status["CHECK"])
            end
        end
    end
    HealBot_Action_UpdateHealthButton(button)
end

local ripHasResStart={}
local ripHasResEnd={}
local ripHadResStart={}
local ripHadResEnd={}
function HealBot_Action_UpdateUnitDeadButtons(button, state)
      --HealBot_setCall("HealBot_Action_UpdateUnitDeadButtons", button)
    if state == 1 then
        HealBot_Action_setState(button, HealBot_Unit_Status["RES"])
        if HealBot_Text_TagInUse(button.framecol, "RES") then
            HealBot_Text_setNameTag(button)
        end
        button.status.hasres=1
        if HealBot_Action_luVars["pluginTimeToLive"] and button.status.plugin then HealBot_Plugin_TimeToLive_UnitUpdate(button) end
        HealBot_Aux_UpdateResBar(button, HEALBOT_WORD_RESURRECTION, ripHasResStart[button.guid]*1000, (ripHasResEnd[button.guid]+1.5)*1000, false)
    else
        ripHasResEnd[button.guid]=false
        ripHasResStart[button.guid]=false
        if state == 2 then
            button.status.hasres=2
            if HealBot_Action_luVars["pluginTimeToLive"] and button.status.plugin then HealBot_Plugin_TimeToLive_UnitUpdate(button) end
            HealBot_Aux_UpdateResBar(button, HEALBOT_WORD_RESURRECTION, ripHadResStart[button.guid]*1000, ripHadResEnd[button.guid]*1000, true)
        else
            ripHadResEnd[button.guid]=false
            ripHadResStart[button.guid]=false
            HealBot_Action_setState(button, HealBot_Unit_Status["DEAD"])
            button.status.resstart=0
            if HealBot_Text_TagInUse(button.framecol, "DEAD") then
                HealBot_Text_setNameTag(button)
            end
            button.status.hasres=false
            if HealBot_Action_luVars["pluginTimeToLive"] and button.status.plugin then HealBot_Plugin_TimeToLive_UnitUpdate(button) end
            HealBot_Aux_UpdateResBar(button, HEALBOT_DEAD_LABEL)
        end
    end
    HealBot_Text_UpdateButton(button)
end

function HealBot_Action_SetResTimes(button)
      --HealBot_setCall("HealBot_Action_SetResTimes", button)
    ripHasResStart[button.guid]=HealBot_TimeNow
    button.status.resstart=HealBot_TimeNow
    if HealBot_Data["UILOCK"] then
        if HEALBOT_GAME_VERSION>4 then
            ripHasResEnd[button.guid]=HealBot_TimeNow+1.25
        elseif HEALBOT_GAME_VERSION>2 then
            ripHasResEnd[button.guid]=HealBot_TimeNow+1.5
        else
            ripHasResEnd[button.guid]=HealBot_TimeNow+1.75
        end
    else
        if HEALBOT_GAME_VERSION>4 then
            ripHasResEnd[button.guid]=HealBot_TimeNow+7
        elseif HEALBOT_GAME_VERSION>2 then
            ripHasResEnd[button.guid]=HealBot_TimeNow+8
        else
            ripHasResEnd[button.guid]=HealBot_TimeNow+9
        end
    end
end

function HealBot_Action_UpdateUnitNotDead(button)
      --HealBot_setCall("HealBot_Action_UpdateUnitNotDead", button)
    HealBot_Action_setState(button, HealBot_Unit_Status["CHECK"])
    button.status.resstart=0
    ripHasResEnd[button.guid]=false
    ripHadResEnd[button.guid]=false
    HealBot_Range_ButtonSpell(button)
    if button.player then 
        HealBot_Data["PALIVE"]=true
        HealBot_Timers_Set("INIT","ResetActiveUnitStatus")
        HealBot_Timers_Set("SKINS","ActionIconsStateChange",true)
        HealBot_Timers_Set("AURA","PlayerCheckExtended",true)
    end
    HealBot_UnitHealth(button)
    HealBot_Action_UpdateBackground(button)
    button.status.hasres=false
    if HealBot_Action_luVars["pluginTimeToLive"] and button.status.plugin then HealBot_Plugin_TimeToLive_UnitUpdate(button) end
    button.text.nameupdate=true
    HealBot_Text_setNameTag(button)
    HealBot_Text_UpdateText(button)
    HealBot_Events_UnitBuff(button)
    HealBot_RefreshUnit(button)
    HealBot_Aux_ClearResBar(button)
    HealBot_Text_Update(button)
    button.status.slowupdate=true
end

function HealBot_Action_ResStateChanged(button)
    button.status.deadnextcheck=0
end

function HealBot_Action_UpdateTheDeadButton(button)
      --HealBot_setCall("HealBot_Action_UpdateTheDeadButton", button)
    button.status.deadnextcheck=HealBot_TimeNow+HealBot_Action_luVars["deadCheckInterval"]
    if button.status.current<HealBot_Unit_Status["DC"] then
        if button.frame<10 then
            if button.status.isdead then
                if not HealBot_IsUnitDead(button) then
                    HealBot_Action_UpdateUnitNotDead(button)
                elseif not ripHadResEnd[button.guid] and (UnitHasIncomingResurrection(button.unit) or HealBot_Events_MassRes()) then
                    if not ripHasResEnd[button.guid] and not ripHadResEnd[button.guid] then
                        HealBot_Action_SetResTimes(button)
                        HealBot_Action_UpdateUnitDeadButtons(button, 1) 
                    elseif ripHasResStart[button.guid] and ripHasResStart[button.guid]~=button.status.resstart then
                        button.status.resstart=ripHasResStart[button.guid]
                        HealBot_Action_UpdateUnitDeadButtons(button, 1) 
                    end
                elseif ripHasResEnd[button.guid] then
                    if ripHasResEnd[button.guid]<HealBot_TimeNow then
                        ripHadResStart[button.guid]=HealBot_TimeNow
                        button.status.resstart=HealBot_TimeNow
                        ripHadResEnd[button.guid]=HealBot_TimeNow+30
                        HealBot_Action_UpdateUnitDeadButtons(button, 2)
                    else
                        HealBot_Action_UpdateUnitDeadButtons(button, 3)
                    end
                elseif ripHadResEnd[button.guid] then
                    if ripHadResEnd[button.guid]<HealBot_TimeNow then
                        HealBot_Action_UpdateUnitDeadButtons(button, 3)
                    elseif ripHadResStart[button.guid] and ripHadResStart[button.guid]~=button.status.resstart then
                        button.status.resstart=ripHadResStart[button.guid]
                        HealBot_Action_UpdateUnitDeadButtons(button, 2)
                    end
                elseif button.status.resstart>0 then
                    HealBot_Action_UpdateUnitDeadButtons(button, 3)
                end
            elseif HealBot_IsUnitDead(button) then
                if HealBot_PluginUpdate_TimeToLive[button.guid] then
                    HealBot_PluginUpdate_TimeToLive[button.guid]=false
                    HealBot_Plugin_TimeToLive_UnitUpdate(button, true)
                end
                HealBot_Action_setState(button, HealBot_Unit_Status["DEAD"])
                HealBot_Range_ButtonSpell(button, HealBot_Action_retResSpell(button))
                if button.player then 
                    HealBot_Data["PALIVE"]=false
                    HealBot_setLuVars("pluginCDsCheckExisting", 0)
                    HealBot_Timers_Set("INIT","ResetActiveUnitStatus")
                    HealBot_Timers_Set("AURA","PlayerCheckExtended",true)
                    if HealBot_Action_luVars["pluginRequests"] then HealBot_Plugin_Requests_PlayerDead() end
                    if HealBot_Action_luVars["pluginAuraWatch"] then HealBot_Plugin_AuraWatch_PlayerDead() end
                    if HealBot_Action_luVars["pluginHealthWatch"] then HealBot_Plugin_HealthWatch_PlayerDead() end
                    if HealBot_Action_luVars["pluginManaWatch"] then HealBot_Plugin_ManaWatch_PlayerDead() end
                    HealBot_ActionIcons_PlayerDied()
                else
                    HealBot_ActionIcons_FadeUnitIcons(button.guid, button.unit)
                end
                button.aura.buff.nextcheck=false
                button.text.nameupdate=true
                HealBot_UpdateUnitClear(button, true)
                HealBot_UnitHealth(button)
                if HealBot_Text_TagInUse(button.framecol, "DEAD") then
                    HealBot_Text_setNameTag(button)
                end
                HealBot_Text_UpdateText(button)
                HealBot_Action_setEnabled(button, true, button.status.alpha)
                if hbv_Skins_GetFrameBoolean("Icons", "SHOWCLASS", button.frame) then
                    HealBot_Action_SetClassIconTexture(button)
                end
                if hbv_Skins_GetFrameBoolean("RaidIcon", "SHOW", button.frame) then 
                    HealBot_RaidTargetUpdate(button)
                end
                HealBot_Action_UpdateBackground(button)
                if button.health.incoming>0 then HealBot_HealsInUpdate(button) end
                if button.health.absorbs>0 then HealBot_AbsorbsUpdate(button) end
                HealBot_RefreshUnit(button)
                --HealBot_Action_EmergBarCheck(button, true)
                button.status.hasres=false
                if HealBot_Action_luVars["pluginTimeToLive"] and button.status.plugin then HealBot_Plugin_TimeToLive_UnitUpdate(button) end
                HealBot_Aux_UpdateResBar(button, HEALBOT_DEAD_LABEL)
                if button.status.range<1 then
                    HealBot_Update_OORBar(button)
                end
                HealBot_Action_DisableDebuffIconGlow(button)
                if not button.status.isspirit then
                    HealBot_Action_DisableBuffIconGlow(button)
                end
                button.status.slowupdate=true
                button.status.update=true
            elseif button.status.resstart>0 then
                HealBot_Action_UpdateUnitNotDead(button)
            end
        elseif button.status.isdead then
            if not HealBot_IsUnitDead(button) then
                HealBot_Action_setState(button, HealBot_Unit_Status["CHECK"])
                HealBot_Events_CheckUnitAura(button)
                HealBot_Action_UpdateBackground(button)
                HealBot_RefreshUnit(button)
            end
        elseif HealBot_IsUnitDead(button) then
            HealBot_Action_setState(button, HealBot_Unit_Status["DEAD"])
            HealBot_Action_UpdateBackground(button)
            HealBot_RefreshUnit(button)
        elseif button.status.resstart>0 then
            button.status.resstart=0
            HealBot_Text_setNameTag(button)
            HealBot_Text_UpdateButton(button)
            HealBot_Aux_ClearResBar(button)
        end
    end
end

function HealBot_Action_UpdatePlugin_TimeToLive(guid)
      --HealBot_setCall("HealBot_Action_UpdatePlugin_TimeToLive", nil, guid)
    HealBot_PluginUpdate_TimeToLive[guid]=true
end

function HealBot_Action_IsUnitDead(button, guid)
      --HealBot_setCall("HealBot_Action_IsUnitDead", button)
    if button then
        return button.status.isdead
    else
        aButton=HealBot_Panel_AllButton(guid)
        if aButton and aButton.status.isdead then
            return true
        end
    end
    return false
end

local hbGroupHealthAuraWatch={}
function HealBot_Action_GroupHealthWatch(guid, enable)
      --HealBot_setCall("HealBot_TargetWatch", nil, guid)
    if enable then
        hbGroupHealthAuraWatch[guid]=true
    else
        hbGroupHealthAuraWatch[guid]=nil
    end
end

local hbGroupHealthActionIcons={}
function HealBot_Action_GroupHealthActionIcons(guid, state)
      --HealBot_setCall("HealBot_ActionWatchSwimming", nil, guid)
    if state then
        hbGroupHealthActionIcons[guid]=true
    else
        hbGroupHealthActionIcons[guid]=nil
    end
end

local HealBot_Action_GroupHealth={}
function HealBot_Action_SetGroupHealthVars(dimming, minHealth, numUnits, unitRange)
    if HealBot_Action_luVars["GroupBarsHealth"] ~= minHealth or HealBot_Action_luVars["GroupBarsNumUnits"] ~= numUnits or HealBot_Action_luVars["GroupBarsRange"] ~= unitRange then
        HealBot_Action_luVars["GroupBarsHealth"]=minHealth
        HealBot_Action_luVars["GroupBarsNumUnits"]=numUnits
        HealBot_Action_luVars["GroupBarsRange"]=unitRange
        for x=#HealBot_Action_GroupHealth,1,-1 do
            HealBot_Action_UpdateGroupHealth(HealBot_Buttons[HealBot_Action_GroupHealth[x]])
        end
    end
    if HealBot_Action_luVars["GroupBarsDimming"] ~= dimming then
        HealBot_Action_luVars["GroupBarsDimming"]=dimming
        HealBot_Action_BarColourAlphaSetFunc()
        HealBot_Timers_Set("LAST","ResetUnitStatus")
        HealBot_Timers_Set("SKINS","TextPlayersAlpha",true)
    end
end

function HealBot_Action_GroupHealthUpdateExtras()
    for x=1,#HealBot_Action_GroupHealth do
        if hbGroupHealthAuraWatch[HealBot_Buttons[HealBot_Action_GroupHealth[x]].guid] then
            HealBot_Plugin_AuraWatch_GroupHealthUpdate(HealBot_Buttons[HealBot_Action_GroupHealth[x]])
        end
    end
    for guid in pairs(hbGroupHealthActionIcons) do
        HealBot_ActionIcons_UpdateGroupHealth(guid, HealBot_Action_luVars["GroupBarsEnabled"])
    end
end

function HealBot_Action_RemoveGroupHealth(button)
    button.hotbars.grouphealth=false
    for x=1,#HealBot_Action_GroupHealth do
        if HealBot_Action_GroupHealth[x] == button.id then
            table.remove(HealBot_Action_GroupHealth, x)
            break
        end
    end
    if #HealBot_Action_GroupHealth<HealBot_Action_luVars["GroupBarsNumUnits"] and HealBot_Action_luVars["GroupBarsEnabled"] then
        HealBot_Action_luVars["GroupBarsEnabled"]=false
        if HealBot_Action_luVars["GroupBarsDimming"]>0 then
            HealBot_Action_BarColourAlphaSetFunc()
            HealBot_Timers_Set("LAST","ResetUnitStatus")
            HealBot_Timers_Set("SKINS","TextPlayersAlpha")
        end
        HealBot_Action_GroupHealthUpdateExtras()
    else
        HealBot_Update_TextPlayersAlphaButton(button)
    end
    if hbGroupHealthAuraWatch[button.guid] then
        HealBot_Plugin_AuraWatch_GroupHealthUpdate(button)
    end
end

function HealBot_Action_AddGroupHealth(button)
    button.hotbars.grouphealth=true
    if not button.status.duplicate then
        table.insert(HealBot_Action_GroupHealth, button.id)
    end
    if #HealBot_Action_GroupHealth>=HealBot_Action_luVars["GroupBarsNumUnits"] and not HealBot_Action_luVars["GroupBarsEnabled"] then
        HealBot_Action_luVars["GroupBarsEnabled"]=true
        if HealBot_Action_luVars["GroupBarsDimming"]>0 then
            HealBot_Action_BarColourAlphaSetFunc()
            HealBot_Timers_Set("LAST","ResetUnitStatus")
            HealBot_Timers_Set("SKINS","TextPlayersAlpha")
        end
        HealBot_Action_GroupHealthUpdateExtras()
    elseif hbGroupHealthAuraWatch[button.guid] then
        HealBot_Plugin_AuraWatch_GroupHealthUpdate(button)
        HealBot_Update_TextPlayersAlphaButton(button)
    end
end

function HealBot_Action_UpdateGroupHealth(button)
      --HealBot_setCall("HealBot_Action_UpdateHealthHotBar", button)
    if (button.isplayer or button.isgroupraid) and button.frame<10 then
        if button.status.range>HealBot_Action_luVars["GroupBarsRange"] and button.health.hpct>0 and button.health.hpct<HealBot_Action_luVars["GroupBarsHealth"] then
            if not button.hotbars.grouphealth then
                HealBot_Action_AddGroupHealth(button)
            end
        elseif button.hotbars.grouphealth then
            HealBot_Action_RemoveGroupHealth(button)
        end
    elseif button.hotbars.grouphealth then 
        HealBot_Action_RemoveGroupHealth(button)
    end
end

function HealBot_Action_UpdateHotBars(button)
      --HealBot_setCall("HealBot_Action_UpdateHealthHotBar", button)
    if (button.isplayer or button.isgroupraid) and button.frame<10 then
        if button.status.range>0 and button.health.hpct>0 and (button.health.hpct+button.health.absorbspctc)<HealBot_Action_luVars["HotBarsHealth"] then
            HealBot_Action_BarHotEnable(button, "HEALTH")
            HealBot_Update_TextPlayersAlphaButton(button)
        elseif button.hotbars.health then
            HealBot_Action_BarHotDisable(button, "HEALTH")
            HealBot_Update_TextPlayersAlphaButton(button)
        end
    elseif button.hotbars.health then 
        HealBot_Action_BarHotDisable(button, "HEALTH")
    end
end

function HealBot_Action_UpdateHotBar(button)
      --HealBot_setCall("HealBot_Action_UpdateHotBar", button)
    if HealBot_Action_luVars["HotBarsHealth"] == 0 then
        if button.hotbars.health then HealBot_Action_BarHotDisable(button, "HEALTH") end
    else
        HealBot_Action_UpdateHotBars(button)
    end
    if button.aura.debuff.name then HealBot_Aura_DebuffWarnings(button, button.aura.debuff.name, true, 0) end
end

function HealBot_Action_BarColourHealth(button)
      --HealBot_setCall("HealBot_Action_BarColourHealth", button)
    button.status.r, button.status.g, button.status.b=button.health.rcol, button.health.gcol, 0
end

function HealBot_Action_BarColourClass(button)
      --HealBot_setCall("HealBot_Action_BarColourClass", button)
    button.status.r,button.status.g,button.status.b=button.text.r,button.text.g,button.text.b
end

function HealBot_Action_BarColourRole(button)
      --HealBot_setCall("HealBot_Action_BarColourRole", button)
    button.status.r=hbCustomRoleCols[button.roletxt].r
    button.status.g=hbCustomRoleCols[button.roletxt].g
    button.status.b=hbCustomRoleCols[button.roletxt].b
end

function HealBot_Action_BarColourCustom(button)
      --HealBot_setCall("HealBot_Action_BarColourCustom", button)
    if button.status.hostile then
        if button.health.pct>hbv_Skins_GetFrameVar("BarCol", "HIT", button.framecol) then
            button.status.r=hbv_Skins_GetFrameVar("BarCol", "HRE", button.framecol)
            button.status.g=hbv_Skins_GetFrameVar("BarCol", "HGE", button.framecol)
            button.status.b=hbv_Skins_GetFrameVar("BarCol", "HBE", button.framecol)
        elseif button.health.pct>hbv_Skins_GetFrameVar("BarCol", "HCT", button.framecol) then
            button.status.r=hbv_Skins_GetFrameVar("BarCol", "HIRE", button.framecol)
            button.status.g=hbv_Skins_GetFrameVar("BarCol", "HIGE", button.framecol)
            button.status.b=hbv_Skins_GetFrameVar("BarCol", "HIBE", button.framecol)
        else
            button.status.r=hbv_Skins_GetFrameVar("BarCol", "HCRE", button.framecol)
            button.status.g=hbv_Skins_GetFrameVar("BarCol", "HCGE", button.framecol)
            button.status.b=hbv_Skins_GetFrameVar("BarCol", "HCBE", button.framecol)
        end
    else
        if button.health.pct>hbv_Skins_GetFrameVar("BarCol", "HIT", button.framecol) then
            button.status.r=hbv_Skins_GetFrameVar("BarCol", "HR", button.framecol)
            button.status.g=hbv_Skins_GetFrameVar("BarCol", "HG", button.framecol)
            button.status.b=hbv_Skins_GetFrameVar("BarCol", "HB", button.framecol)
        elseif button.health.pct>hbv_Skins_GetFrameVar("BarCol", "HCT", button.framecol) then
            button.status.r=hbv_Skins_GetFrameVar("BarCol", "HIR", button.framecol)
            button.status.g=hbv_Skins_GetFrameVar("BarCol", "HIG", button.framecol)
            button.status.b=hbv_Skins_GetFrameVar("BarCol", "HIB", button.framecol)
        else
            button.status.r=hbv_Skins_GetFrameVar("BarCol", "HCR", button.framecol)
            button.status.g=hbv_Skins_GetFrameVar("BarCol", "HCG", button.framecol)
            button.status.b=hbv_Skins_GetFrameVar("BarCol", "HCB", button.framecol)
        end
    end
end

function HealBot_Action_BarColourClassHlthMix(button)
      --HealBot_setCall("HealBot_Action_BarColourClassHlthMix", button)
    button.status.r, button.status.g, button.status.b=button.health.mixcolr, button.health.mixcolg, button.health.mixcolb
end

function HealBot_Action_BarColourRoleHlthMix(button)
      --HealBot_setCall("HealBot_Action_BarColourRoleHlthMix", button)
    button.status.r, button.status.g, button.status.b=button.health.rmixcolr, button.health.rmixcolg, button.health.rmixcolb
end

local hbBarColourFuncs={[1]=HealBot_Action_BarColourHealth,
                        [2]=HealBot_Action_BarColourClass,
                        [3]=HealBot_Action_BarColourRole,
                        [4]=HealBot_Action_BarColourCustom,
                        [5]=HealBot_Action_BarColourClassHlthMix,
                        [6]=HealBot_Action_BarColourRoleHlthMix}
local mixPct=0
local HealBot_TextColChangeWithHealth={[1]=true,[4]=true,[5]=true}
function HealBot_Action_UpdateHealthButton(button, hlthevent)
      --HealBot_setCall("HealBot_Action_UpdateHealthButton", button)
    if hlthevent then
        button.health.pct=button.health.current/button.health.max
        button.health.hpct=floor(button.health.pct*1000)
        button.health.rcol, button.health.gcol=HealBot_Action_BarColourPct(button.health.pct)

        if button.health.hpct>890 then
            button.health.mixcolr, button.health.mixcolg, button.health.mixcolb=button.text.r, button.text.g, button.text.b
            button.health.rmixcolr=hbCustomRoleCols[button.roletxt].r
            button.health.rmixcolg=hbCustomRoleCols[button.roletxt].g
            button.health.rmixcolb=hbCustomRoleCols[button.roletxt].b
        elseif button.health.hpct>640 then
            mixPct=(250-(button.health.hpct-640))/250
            button.health.mixcolr=button.text.r+((1-button.text.r)*mixPct)
            button.health.mixcolg=button.text.g+((1-button.text.g)*mixPct)
            button.health.mixcolb=button.text.b*(button.health.hpct/1000)
            button.health.rmixcolr=hbCustomRoleCols[button.roletxt].r+
                                  ((1-hbCustomRoleCols[button.roletxt].r)*mixPct)
            button.health.rmixcolg=hbCustomRoleCols[button.roletxt].g+
                                  ((1-hbCustomRoleCols[button.roletxt].g)*mixPct)
            button.health.rmixcolb=hbCustomRoleCols[button.roletxt].b*(button.health.hpct/1000)
        else
            button.health.mixcolr, button.health.mixcolg, button.health.mixcolb=button.health.rcol, button.health.gcol, 0
            button.health.rmixcolr, button.health.rmixcolg, button.health.rmixcolb=button.health.rcol, button.health.gcol, 0
        end

        if HealBot_TextColChangeWithHealth[hbv_Skins_GetFrameVar("BarTextCol", "NAME", button.frame)] then 
            button.text.nameupdate=true 
        end
        if hbv_Skins_GetFrameVar("BarText", "HLTHTXTANCHOR", button.frame)~=4 and
           HealBot_TextColChangeWithHealth[hbv_Skins_GetFrameVar("BarTextCol", "HLTH", button.frame)] then 
            button.text.healthupdate=true
        end
        HealBot_Action_UpdateHotBar(button)
        HealBot_Action_UpdateGroupHealth(button)
        HealBot_Text_setHealthText(button)
        HealBot_Text_UpdateText(button)
        --if button.aux[button.frame].sticky then
        --    button.aux[button.frame]:SetWidth(50)
        --end
        HealBot_Action_OverShield(button)
    end
    HealBot_Action_EmergBarCheck(button)

    if button.status.current<HealBot_Unit_Status["DEAD"] then --or (button.status.current == HealBot_Unit_Status["RESERVED"] and UnitHealth(button.unit)) then
        if button.status.hlthupd then 
            if button.status.current>HealBot_Unit_Status["ENABLEDIR"] or button.health.pct<=hbv_Skins_GetFrameVar("BarVisibility", hbAlert, button.frame) or
               button.aggro.status>hbv_Skins_GetFrameVar("BarAggro", "ALERT", button.frame) or HealBot_AlwaysEnabled[button.guid] then
                if button.status.current<HealBot_Unit_Status["BUFFNOCOL"] then
                    HealBot_Range_ButtonSpell(button)
                end
                if button.status.range>0 then
                    curAlpha=HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "HA", button.framecol), 1)
                    if button.status.current<HealBot_Unit_Status["BUFFNOCOL"] then HealBot_Action_setState(button, HealBot_Unit_Status["ENABLEDIR"]) end
                else
                    curAlpha=HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "ORA", button.framecol), 1)
                    if button.status.current<HealBot_Unit_Status["BUFFNOCOL"] then HealBot_Action_setState(button, HealBot_Unit_Status["ENABLEDOOR"]) end
                end
                HealBot_Action_setEnabled(button, true, curAlpha)
            else
                if button.status.current<HealBot_Unit_Status["BUFFNOCOL"] then HealBot_Action_setState(button, HealBot_Unit_Status["DISABLED"]) end
                curAlpha=HealBot_Action_BarColourAlpha(button, hbv_Skins_GetFrameVar("BarCol", "DISA", button.framecol), 1)
                HealBot_Action_setEnabled(button, false, curAlpha)
            end
            hbBarColourFuncs[hbv_Skins_GetFrameVar("BarCol", "HLTH", button.framecol)](button)
            HealBot_Action_UpdateHealthStatusBarColor(button)
        end
        HealBot_Action_UpdateBackground(button)
    else
        button.health.hpct=0
        button.health.current=0
        button.mana.current=0
        button.gref["Bar"]:SetStatusBarColor(0.2,0.2,0.2,0.4);
    end
    if button.gref["Bar"]:GetValue()~=button.health.hpct then
        if button.health.init or not HealBot_Action_luVars["FluidInUse"] then
            button.gref["Bar"]:SetValue(button.health.hpct)
            button.health.initover=true
        else
            HealBot_Action_setFluid_BarButtons(button)
        end
        if button.health.incoming>0 then HealBot_Action_UpdateHealsInButton(button) end
        if button.health.absorbs>0 then HealBot_Action_UpdateAbsorbsButton(button) end
    end
end

local HealBot_Action_HotBars={}
function HealBot_Action_BarHotEnable(button, hType)
      --HealBot_setCall("HealBot_Action_BarHotEnable", button)
    if hType == "DEBUFF" then
        button.hotbars.debuff=true
    else
        button.hotbars.health=true
    end
    if not button.hotbars.state then
        button.hotbars.state=true
        table.insert(HealBot_Action_HotBars, button.id)
    end
    if not HealBot_Action_luVars["HotBarsEnabled"] then
        HealBot_Action_luVars["HotBarsEnabled"]=true
        HealBot_Action_BarColourAlphaSetFunc()
        HealBot_Timers_Set("LAST","ResetUnitStatus")
    end
end

function HealBot_Action_BarHotRemove(button)
      --HealBot_setCall("HealBot_Action_BarHotRemove", button)
    button.hotbars.state=false
    for x=1,#HealBot_Action_HotBars do
        if HealBot_Action_HotBars[x] == button.id then
            table.remove(HealBot_Action_HotBars, x)
            break
        end
    end
    if #HealBot_Action_HotBars == 0 and HealBot_Action_luVars["HotBarsEnabled"] then
        HealBot_Action_luVars["HotBarsEnabled"]=false
        HealBot_Action_BarColourAlphaSetFunc()
        HealBot_Timers_Set("LAST","ResetUnitStatus")
    end
end

function HealBot_Action_IsFrameActive(frame)
    if grpFrameBar[frame].active or HealBot_Action_luVars["ActiveFrameID"] == frame then
        return true
    else
        return false
    end
end

function HealBot_Action_DebugFrameActive(frame)
    return grpFrameBar[frame].active, HealBot_Action_luVars["ActiveFrameID"]
end

function HealBot_Action_BarHotDisable(button, hType)
      --HealBot_setCall("HealBot_Action_BarHotDisable", button)
    if hType == "DEBUFF" then
        button.hotbars.debuff=false
    else
        button.hotbars.health=false
    end
    if button.hotbars.state and not button.hotbars.debuff and not button.hotbars.health then
        HealBot_Action_BarHotRemove(button)
    end
end

local hbBarColourAlpha=1
function HealBot_Action_BarColourAlphaNoMod(button, a, dMult)
      --HealBot_setCall("HealBot_Action_BarColourAlphaNoMod", button, nil, nil, true)
    hbBarColourAlpha=a
end

function HealBot_Action_BarColourAlphaGD(button, a, dMult)
      --HealBot_setCall("HealBot_Action_BarColourAlphaGD", button, nil, nil, true)
    if HealBot_Action_luVars["GlobalDimming"]>0 and not HealBot_Action_IsFrameActive(button.frame) then
        hbBarColourAlpha=a/(HealBot_Action_luVars["GlobalDimming"]*dMult)
    else
        hbBarColourAlpha=a
    end
end

function HealBot_Action_BarColourAlphaFG(button, a, dMult)
      --HealBot_setCall("HealBot_Action_BarColourAlphaFG", button, nil, nil, true)
    if hbv_IsUnitType(button.status.unittype, HEALBOT_RAID) and not HealBot_Action_luVars["FGroups"][button.group] then
        hbBarColourAlpha=a/(HealBot_Action_luVars["FocusGroupDimming"]*dMult)
    else
        hbBarColourAlpha=a
    end
end

function HealBot_Action_BarColourAlphaHB(button, a, dMult)
      --HealBot_setCall("HealBot_Action_BarColourAlphaHB", button, nil, nil, true)
    if not button.hotbars.state then
        hbBarColourAlpha=a/(HealBot_Action_luVars["HotBarDimming"]*dMult)
    else
        hbBarColourAlpha=a
    end
end

function HealBot_Action_BarColourAlphaGH(button, a, dMult)
      --HealBot_setCall("HealBot_Action_BarColourAlphaHB", button, nil, nil, true)
    if not button.hotbars.grouphealth then
        hbBarColourAlpha=a/(HealBot_Action_luVars["GroupBarsDimming"]*dMult)
    else
        hbBarColourAlpha=a
    end
end

function HealBot_Action_BarColourAlphaGDFG(button, a, dMult)
      --HealBot_setCall("HealBot_Action_BarColourAlphaGDFG", button, nil, nil, true)
    if HealBot_Action_luVars["GlobalDimming"]>0 and not HealBot_Action_IsFrameActive(button.frame) then
        hbBarColourAlpha=a/(HealBot_Action_luVars["GlobalDimming"]*dMult)
    elseif hbv_IsUnitType(button.status.unittype, HEALBOT_RAID) and not HealBot_Action_luVars["FGroups"][button.group] then
        hbBarColourAlpha=a/(HealBot_Action_luVars["FocusGroupDimming"]*dMult)
    else
        hbBarColourAlpha=a
    end
end

function HealBot_Action_BarColourAlphaGDGH(button, a, dMult)
      --HealBot_setCall("HealBot_Action_BarColourAlphaGDHB", button, nil, nil, true)
    if HealBot_Action_luVars["GlobalDimming"]>0 and not HealBot_Action_IsFrameActive(button.frame) then
        hbBarColourAlpha=a/(HealBot_Action_luVars["GlobalDimming"]*dMult)
    elseif not button.hotbars.grouphealth then
        hbBarColourAlpha=a/(HealBot_Action_luVars["GroupBarsDimming"]*dMult)
    else
        hbBarColourAlpha=a
    end
end

function HealBot_Action_BarColourAlphaGDHB(button, a, dMult)
      --HealBot_setCall("HealBot_Action_BarColourAlphaGDHB", button, nil, nil, true)
    if HealBot_Action_luVars["GlobalDimming"]>0 and not HealBot_Action_IsFrameActive(button.frame) then
        hbBarColourAlpha=a/(HealBot_Action_luVars["GlobalDimming"]*dMult)
    elseif not button.hotbars.state then
        hbBarColourAlpha=a/(HealBot_Action_luVars["HotBarDimming"]*dMult)
    else
        hbBarColourAlpha=a
    end
end

function HealBot_Action_BarColourAlphaFGGH(button, a, dMult)
      --HealBot_setCall("HealBot_Action_BarColourAlphaFGHB", button, nil, nil, true)
    if hbv_IsUnitType(button.status.unittype, HEALBOT_RAID) and not HealBot_Action_luVars["FGroups"][button.group] then
        hbBarColourAlpha=a/(HealBot_Action_luVars["FocusGroupDimming"]*dMult)
    elseif not button.hotbars.grouphealth then
        hbBarColourAlpha=a/(HealBot_Action_luVars["GroupBarsDimming"]*dMult)
    else
        hbBarColourAlpha=a
    end
end

function HealBot_Action_BarColourAlphaFGHB(button, a, dMult)
      --HealBot_setCall("HealBot_Action_BarColourAlphaFGHB", button, nil, nil, true)
    if hbv_IsUnitType(button.status.unittype, HEALBOT_RAID) and not HealBot_Action_luVars["FGroups"][button.group] then
        hbBarColourAlpha=a/(HealBot_Action_luVars["FocusGroupDimming"]*dMult)
    elseif not button.hotbars.state then
        hbBarColourAlpha=a/(HealBot_Action_luVars["HotBarDimming"]*dMult)
    else
        hbBarColourAlpha=a
    end
end

function HealBot_Action_BarColourAlphaGDFGGH(button, a, dMult)
      --HealBot_setCall("HealBot_Action_BarColourAlphaGDFGHB", button, nil, nil, true)
    if HealBot_Action_luVars["GlobalDimming"]>0 and not HealBot_Action_IsFrameActive(button.frame) then
        hbBarColourAlpha=a/(HealBot_Action_luVars["GlobalDimming"]*dMult)
    elseif hbv_IsUnitType(button.status.unittype, HEALBOT_RAID) and not HealBot_Action_luVars["FGroups"][button.group] then
        hbBarColourAlpha=a/(HealBot_Action_luVars["FocusGroupDimming"]*dMult)
    elseif not button.hotbars.grouphealth then
        hbBarColourAlpha=a/(HealBot_Action_luVars["GroupBarsDimming"]*dMult)
    else
        hbBarColourAlpha=a
    end
end

function HealBot_Action_BarColourAlphaGDFGHB(button, a, dMult)
      --HealBot_setCall("HealBot_Action_BarColourAlphaGDFGHB", button, nil, nil, true)
    if HealBot_Action_luVars["GlobalDimming"]>0 and not HealBot_Action_IsFrameActive(button.frame) then
        hbBarColourAlpha=a/(HealBot_Action_luVars["GlobalDimming"]*dMult)
    elseif hbv_IsUnitType(button.status.unittype, HEALBOT_RAID) and not HealBot_Action_luVars["FGroups"][button.group] then
        hbBarColourAlpha=a/(HealBot_Action_luVars["FocusGroupDimming"]*dMult)
    elseif not button.hotbars.state then
        hbBarColourAlpha=a/(HealBot_Action_luVars["HotBarDimming"]*dMult)
    else
        hbBarColourAlpha=a
    end
end

local hbBarColourAlphaFunc=HealBot_Action_BarColourAlphaNoMod
function HealBot_Action_BarColourAlphaSetFunc()
      --HealBot_setCall("HealBot_Action_BarColourAlphaSetFunc")
    if hbv_Skins_GetVar("General", "GLOBALDIMMING")>1 then
        if HealBot_Action_luVars["FocusGroups"] == 2 then
            if HealBot_Action_luVars["GroupBarsEnabled"] and HealBot_Action_luVars["GroupBarsDimming"]>0 then
                hbBarColourAlphaFunc=HealBot_Action_BarColourAlphaGDFGGH
            elseif HealBot_Action_luVars["HotBarsEnabled"] then
                hbBarColourAlphaFunc=HealBot_Action_BarColourAlphaGDFGHB
            else
                hbBarColourAlphaFunc=HealBot_Action_BarColourAlphaGDFG
            end
        elseif HealBot_Action_luVars["GroupBarsEnabled"] and HealBot_Action_luVars["GroupBarsDimming"]>0 then
            hbBarColourAlphaFunc=HealBot_Action_BarColourAlphaGDGH
        elseif HealBot_Action_luVars["HotBarsEnabled"] then
            hbBarColourAlphaFunc=HealBot_Action_BarColourAlphaGDHB
        else
            hbBarColourAlphaFunc=HealBot_Action_BarColourAlphaGD
        end
    elseif HealBot_Action_luVars["FocusGroups"] == 2 then
        if HealBot_Action_luVars["GroupBarsEnabled"] and HealBot_Action_luVars["GroupBarsDimming"]>0 then
            hbBarColourAlphaFunc=HealBot_Action_BarColourAlphaFGGH
        elseif HealBot_Action_luVars["HotBarsEnabled"] then
            hbBarColourAlphaFunc=HealBot_Action_BarColourAlphaFGHB
        else
            hbBarColourAlphaFunc=HealBot_Action_BarColourAlphaFG
        end
    elseif HealBot_Action_luVars["GroupBarsEnabled"] and HealBot_Action_luVars["GroupBarsDimming"]>0 then
        hbBarColourAlphaFunc=HealBot_Action_BarColourAlphaGH
    elseif HealBot_Action_luVars["HotBarsEnabled"] then
        hbBarColourAlphaFunc=HealBot_Action_BarColourAlphaHB
    else
        hbBarColourAlphaFunc=HealBot_Action_BarColourAlphaNoMod
    end
end

function HealBot_Action_BarColourAlpha(button, a, dMult)
      --HealBot_setCall("HealBot_Action_BarColourAlpha", button, nil, nil, true)
    hbBarColourAlphaFunc(button, a, dMult)
    --if button.status.current>=HealBot_Unit_Status["DC"] then
    --    hbBarColourAlpha=hbBarColourAlpha/2
    --end
    return hbBarColourAlpha
end

function HealBot_Action_SetFocusGroups()
      --HealBot_setCall("HealBot_Action_SetFocusGroups")
    if HealBot_Globals.OverrideEffects["USEBARS"] == 2 then
        HealBot_Action_luVars["FocusGroups"]=HealBot_Globals.OverrideEffects["FOCUSGROUPS"]
        HealBot_Action_luVars["FGroups"]=HealBot_Globals.OverrideFocusGroups
        HealBot_Action_luVars["FocusGroupDimming"]=HealBot_Globals.OverrideEffects["FGDIMMING"]
    else
        HealBot_Action_luVars["FocusGroups"]=hbv_Skins_GetVar("General", "FOCUSGROUPS")
        for x=1,8 do
            HealBot_Action_luVars["FGroups"][x]=hbv_Skins_GetFocusGroup(x)
        end
        
        HealBot_Action_luVars["FocusGroupDimming"]=hbv_Skins_GetVar("General", "FGDIMMING")
    end
    HealBot_Timers_Set("SKINS","UpdateTextButtons",true)
    HealBot_Panel_SetFocusGroups()
    HealBot_Options_framesChanged(false)
    HealBot_Timers_Set("LAST","BarColourAlphaSetFunc",true)
end

local hacpr, hacpg=1,1 
function HealBot_Action_BarColourPct(hlthPct)
      --HealBot_setCall("HealBot_Action_BarColourPct")
    hacpr, hacpg=1,1
    if hlthPct>=0.98 then 
        hacpr=0
    elseif hlthPct<0.98 and hlthPct>=0.65 then 
        hacpr=2.94-(hlthPct*3)
    elseif hlthPct<=0.64 and hlthPct>0.31 then 
        hacpg=(hlthPct-0.31)*3
    elseif hlthPct<=0.31 then 
        hacpg=0
    end
    return hacpr, hacpg
end

local hbShouldHealSomePlayerFrames={[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,}
local hbShouldHealSomePrivateFrames={[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,}

function HealBot_Action_resetShouldHealSomeFrames()
      --HealBot_setCall("HealBot_Action_resetShouldHealSomeFrames")
    for x,_ in pairs(hbShouldHealSomePlayerFrames) do
        hbShouldHealSomePlayerFrames[x]=false;
    end
    for x,_ in pairs(hbShouldHealSomePrivateFrames) do
        hbShouldHealSomePrivateFrames[x]=false;
    end
end

function HealBot_Action_ShouldHealSome(frame)
      --HealBot_setCall("HealBot_Action_ShouldHealSome")
    if frame<6 then
        if hbShouldHealSomePlayerFrames[frame] then
            for _,xButton in pairs(HealBot_Unit_Button) do
                if xButton.frame == frame and xButton.status.enabled then
                    return true
                end
            end
        end
        if hbShouldHealSomePrivateFrames[frame] then
            for _,xButton in pairs(HealBot_Private_Button) do
                if xButton.frame == frame and xButton.status.enabled then
                    return true
                end
            end
        end
    elseif frame<8 then
        for _,xButton in pairs(HealBot_Extra_Button) do
            if xButton.frame == frame and xButton.status.enabled then
                return true
            end
        end
    elseif frame<10 then
        for _,xButton in pairs(HealBot_Pet_Button) do
            if xButton.frame == frame and xButton.status.enabled then
                return true
            end
        end
        for _,xButton in pairs(HealBot_Vehicle_Button) do
            if xButton.frame == frame and xButton.status.enabled then
                return true
            end
        end
    else
        for _,xButton in pairs(HealBot_Enemy_Button) do
            if xButton.status.enabled then
                return true
            end
        end
        for xUnit,xButton in pairs(HealBot_UnitTarget_Button) do
            if xButton.status.enabled then
                return true
            end
        end
        for xUnit,xButton in pairs(HealBot_PrivateTarget_Button) do
            if xButton.status.enabled then
                return true
            end
        end
    end
    return false
end

local vPowerBarInfo={}
local vPowerBarType,vPowerBarToken,vPowerBarR,vPowerBarG,vPowerBarB=0,"MANA",0,0,0
function HealBot_Action_GetManaBarColour(button)
      --HealBot_setCall("HealBot_Action_GetManaBarColour", button)
    vPowerBarType, vPowerBarToken, vPowerBarR, vPowerBarG, vPowerBarB=UnitPowerType(button.unit);
    if vPowerBarType then 
        button.mana.type=vPowerBarType 
        if button.player then
            HealBot_Data["POWERTYPE"]=vPowerBarType
            if HealBot_Data["POWERTYPE"]<0 or HealBot_Data["POWERTYPE"]>9 then HealBot_Data["POWERTYPE"]=0 end
        end
    end
    vPowerBarInfo=PowerBarColor[vPowerBarToken]
    if vPowerBarInfo then
        return vPowerBarInfo.r, vPowerBarInfo.g, vPowerBarInfo.b, vPowerBarToken
    elseif not vPowerBarR then
        vPowerBarInfo=PowerBarColor[vPowerBarType] or PowerBarColor["MANA"];
        return vPowerBarInfo.r, vPowerBarInfo.g, vPowerBarInfo.b, false
    else
        return vPowerBarR, vPowerBarG, vPowerBarB, false
    end
end

local powerR, powerG, powerB, powerType=0,0,0,false
function HealBot_Action_GetManaBarCol(button)
      --HealBot_setCall("HealBot_Action_GetManaBarCol", button)
    powerR, powerG, powerB, powerType=HealBot_Action_GetManaBarColour(button)
    if powerType and hbCustomPowerCols[powerType] then
        return hbCustomPowerCols[powerType].r,
               hbCustomPowerCols[powerType].g,
               hbCustomPowerCols[powerType].b
    else
        return powerR, powerG, powerB
    end
end

function HealBot_Action_setButtonManaBarCol(button)
      --HealBot_setCall("HealBot_Action_setButtonManaBarCol", button)
    button.mana.r,button.mana.g,button.mana.b=HealBot_Action_GetManaBarCol(button)
    if button.player and HealBot_Data["TIPUSE"] then
        HealBot_Tooltip_setPlayerPowerCols(button.mana.r,button.mana.g,button.mana.b)
    end
end

function HealBot_Action_hasPowerCounter(frame)
      --HealBot_setCall("HealBot_Action_hasPowerCounter")
    if HealBot_pcClass[frame] then
        return HealBot_Action_luVars["UnitPowerMax"]
    end
    return 0
end

function HealBot_Action_UpdateAllIndicators(button)
      --HealBot_setCall("HealBot_Action_UpdateAllIndicators", button)
    HealBot_Events_PowerIndicators(button)
    button.mana.lowcheck=true
    HealBot_Aggro_IndicatorUpdate(button)
end

local hbPowerIndicator=0
function HealBot_Action_ZeroPowerIndicators(button)
    if button.mana.power~=0 then
        button.mana.power=0
        button.gref.indicator.power[1]:SetAlpha(0)
        button.gref.indicator.power[2]:SetAlpha(0)
        button.gref.indicator.power[3]:SetAlpha(0)
        button.gref.indicator.power[4]:SetAlpha(0)
        button.gref.indicator.power[5]:SetAlpha(0)
    end
end

function HealBot_Action_PowerIndicators(button)
      --HealBot_setCall("HealBot_Action_PowerIndicators", button)
    if HealBot_pcClass[button.frame] and button.player and button.status.current<HealBot_Unit_Status["DEAD"] then
        hbPowerIndicator=UnitPower("player", HealBot_pcClass[button.frame])
        local indAlpha=HealBot_Action_BarColourAlpha(button, 1, 1)
        if hbPowerIndicator == 1 then
            if button.mana.power~=1 then
                button.mana.power=1
                if hbv_Skins_GetFrameVar("Indicators", "PCOL", button.frame) == 1 then
                    button.gref.indicator.power[1]:SetTexture([[Interface\AddOns\HealBot\Images\indicators\indicator_red.tga]])
                end
                button.gref.indicator.power[1]:SetAlpha(indAlpha)
                button.gref.indicator.power[2]:SetAlpha(0)
                button.gref.indicator.power[3]:SetAlpha(0)
                button.gref.indicator.power[4]:SetAlpha(0)
                button.gref.indicator.power[5]:SetAlpha(0)
            end
        elseif hbPowerIndicator == 2 then
            if button.mana.power~=2 then
                button.mana.power=2
                if hbv_Skins_GetFrameVar("Indicators", "PCOL", button.frame) == 1 then
                    if HealBot_Action_luVars["UnitPowerMax"]<4 then
                        button.gref.indicator.power[1]:SetTexture([[Interface\AddOns\HealBot\Images\indicators\indicator_yellow.tga]]);
                        button.gref.indicator.power[2]:SetTexture([[Interface\AddOns\HealBot\Images\indicators\indicator_yellow.tga]]);
                    else
                        button.gref.indicator.power[1]:SetTexture([[Interface\AddOns\HealBot\Images\indicators\indicator_orange.tga]]);
                        button.gref.indicator.power[2]:SetTexture([[Interface\AddOns\HealBot\Images\indicators\indicator_orange.tga]]);
                    end
                end
                button.gref.indicator.power[1]:SetAlpha(indAlpha)
                button.gref.indicator.power[2]:SetAlpha(indAlpha)
                button.gref.indicator.power[3]:SetAlpha(0)
                button.gref.indicator.power[4]:SetAlpha(0)
                button.gref.indicator.power[5]:SetAlpha(0)
            end
        elseif hbPowerIndicator == 3 then
            if button.mana.power~=3 then
                button.mana.power=3
                if hbv_Skins_GetFrameVar("Indicators", "PCOL", button.frame) == 1 then
                    if HealBot_Action_luVars["UnitPowerMax"]<4 then
                        button.gref.indicator.power[1]:SetTexture([[Interface\AddOns\HealBot\Images\indicators\indicator_green.tga]]);
                        button.gref.indicator.power[2]:SetTexture([[Interface\AddOns\HealBot\Images\indicators\indicator_green.tga]]);
                        button.gref.indicator.power[3]:SetTexture([[Interface\AddOns\HealBot\Images\indicators\indicator_green.tga]]);
                    elseif HealBot_Action_luVars["UnitPowerMax"]<5 then
                        button.gref.indicator.power[1]:SetTexture([[Interface\AddOns\HealBot\Images\indicators\indicator_lime.tga]]);
                        button.gref.indicator.power[2]:SetTexture([[Interface\AddOns\HealBot\Images\indicators\indicator_lime.tga]]);
                        button.gref.indicator.power[3]:SetTexture([[Interface\AddOns\HealBot\Images\indicators\indicator_lime.tga]]);
                    else
                        button.gref.indicator.power[1]:SetTexture([[Interface\AddOns\HealBot\Images\indicators\indicator_yellow.tga]]);
                        button.gref.indicator.power[2]:SetTexture([[Interface\AddOns\HealBot\Images\indicators\indicator_yellow.tga]]);
                        button.gref.indicator.power[3]:SetTexture([[Interface\AddOns\HealBot\Images\indicators\indicator_yellow.tga]]);
                    end
                end
                button.gref.indicator.power[1]:SetAlpha(indAlpha)
                button.gref.indicator.power[2]:SetAlpha(indAlpha)
                button.gref.indicator.power[3]:SetAlpha(indAlpha)
                button.gref.indicator.power[4]:SetAlpha(0)
                button.gref.indicator.power[5]:SetAlpha(0)
            end
        elseif hbPowerIndicator == 4 then
            if button.mana.power~=4 then
                button.mana.power=4
                if hbv_Skins_GetFrameVar("Indicators", "PCOL", button.frame) == 1 then
                    if HealBot_Action_luVars["UnitPowerMax"]<5 then
                        button.gref.indicator.power[1]:SetTexture([[Interface\AddOns\HealBot\Images\indicators\indicator_green.tga]]);
                        button.gref.indicator.power[2]:SetTexture([[Interface\AddOns\HealBot\Images\indicators\indicator_green.tga]]);
                        button.gref.indicator.power[3]:SetTexture([[Interface\AddOns\HealBot\Images\indicators\indicator_green.tga]]);
                        button.gref.indicator.power[4]:SetTexture([[Interface\AddOns\HealBot\Images\indicators\indicator_green.tga]]);

                    else
                        button.gref.indicator.power[1]:SetTexture([[Interface\AddOns\HealBot\Images\indicators\indicator_lime.tga]]);
                        button.gref.indicator.power[2]:SetTexture([[Interface\AddOns\HealBot\Images\indicators\indicator_lime.tga]]);
                        button.gref.indicator.power[3]:SetTexture([[Interface\AddOns\HealBot\Images\indicators\indicator_lime.tga]]);
                        button.gref.indicator.power[4]:SetTexture([[Interface\AddOns\HealBot\Images\indicators\indicator_lime.tga]]);
                    end
                end
                button.gref.indicator.power[1]:SetAlpha(indAlpha)
                button.gref.indicator.power[2]:SetAlpha(indAlpha)
                button.gref.indicator.power[3]:SetAlpha(indAlpha)
                button.gref.indicator.power[4]:SetAlpha(indAlpha)
                button.gref.indicator.power[5]:SetAlpha(0)
            end
        elseif hbPowerIndicator == 5 then
            if button.mana.power~=5 then
                button.mana.power=5
                if hbv_Skins_GetFrameVar("Indicators", "PCOL", button.frame) == 1 then
                    button.gref.indicator.power[1]:SetTexture([[Interface\AddOns\HealBot\Images\indicators\indicator_green.tga]]);
                    button.gref.indicator.power[2]:SetTexture([[Interface\AddOns\HealBot\Images\indicators\indicator_green.tga]]);
                    button.gref.indicator.power[3]:SetTexture([[Interface\AddOns\HealBot\Images\indicators\indicator_green.tga]]);
                    button.gref.indicator.power[4]:SetTexture([[Interface\AddOns\HealBot\Images\indicators\indicator_green.tga]]);
                end
                button.gref.indicator.power[1]:SetAlpha(indAlpha)
                button.gref.indicator.power[2]:SetAlpha(indAlpha)
                button.gref.indicator.power[3]:SetAlpha(indAlpha)
                button.gref.indicator.power[4]:SetAlpha(indAlpha)
                button.gref.indicator.power[5]:SetAlpha(indAlpha)
            end
        elseif button.mana.power~=0 then
            HealBot_Action_ZeroPowerIndicators(button)
        end
    elseif button.mana.power~=0 then
        HealBot_Action_ZeroPowerIndicators(button)
    end
end

local hbLowManaTrig={[1]={[1]=1,[2]=2,[3]=3},
                     [2]={[1]=1,[2]=2,[3]=3},
                     [3]={[1]=1,[2]=2,[3]=3},
                     [4]={[1]=1,[2]=2,[3]=3},
                     [5]={[1]=1,[2]=2,[3]=3},
                     [6]={[1]=1,[2]=2,[3]=3},
                     [7]={[1]=1,[2]=2,[3]=3},
                     [8]={[1]=1,[2]=2,[3]=3},
                     [9]={[1]=1,[2]=2,[3]=3},
                     [10]={[1]=1,[2]=2,[3]=3},
                    }

function HealBot_Action_setLowManaTrig()
      --HealBot_setCall("HealBot_Action_setLowManaTrig")
    for j=1,10 do
        if hbv_Skins_GetFrameVar("HealBar", "LOWMANA", j) == 2 then
            hbLowManaTrig[j][1]=10
            hbLowManaTrig[j][2]=20
            hbLowManaTrig[j][3]=30
        elseif hbv_Skins_GetFrameVar("HealBar", "LOWMANA", j) == 3 then
            hbLowManaTrig[j][1]=15
            hbLowManaTrig[j][2]=30
            hbLowManaTrig[j][3]=45
        elseif hbv_Skins_GetFrameVar("HealBar", "LOWMANA", j) == 4 then
            hbLowManaTrig[j][1]=20
            hbLowManaTrig[j][2]=40
            hbLowManaTrig[j][3]=60
        elseif hbv_Skins_GetFrameVar("HealBar", "LOWMANA", j) == 5 then
            hbLowManaTrig[j][1]=25
            hbLowManaTrig[j][2]=50
            hbLowManaTrig[j][3]=75
        elseif hbv_Skins_GetFrameVar("HealBar", "LOWMANA", j) == 6 then
            hbLowManaTrig[j][1]=30
            hbLowManaTrig[j][2]=60
            hbLowManaTrig[j][3]=90
        else
            hbLowManaTrig[j][1]=1
            hbLowManaTrig[j][2]=2
            hbLowManaTrig[j][3]=3
        end
    end
    HealBot_Timers_Set("LAST","CheckLowMana")
end

function HealBot_Action_CheckUnitLowMana(button)
      --HealBot_setCall("HealBot_Action_CheckUnitLowMana", button)
    if button.mana.type == 0 and button.frame<10 then
        if button.status.current<HealBot_Unit_Status["DEAD"] and button.mana.max>0 and 
           hbv_Skins_GetFrameVar("HealBar", "LOWMANA", button.frame)>1 then
            local indAlpha=HealBot_Action_BarColourAlpha(button, 1, 1)
            if button.mana.pct<hbLowManaTrig[button.frame][1] then
                if button.mana.ind~=1 then
                    button.mana.ind=1
                    button.gref.indicator.mana[1]:SetAlpha(indAlpha)
                    button.gref.indicator.mana[2]:SetAlpha(0)
                    button.gref.indicator.mana[3]:SetAlpha(0)
                end
            elseif button.mana.pct<hbLowManaTrig[button.frame][2] then
                if button.mana.ind~=2 then
                    button.mana.ind=2
                    button.gref.indicator.mana[1]:SetAlpha(indAlpha)
                    button.gref.indicator.mana[2]:SetAlpha(indAlpha)
                    button.gref.indicator.mana[3]:SetAlpha(0)
                end
            elseif button.mana.pct<hbLowManaTrig[button.frame][3] then
                if button.mana.ind~=3 then
                    button.mana.ind=3
                    button.gref.indicator.mana[1]:SetAlpha(indAlpha)
                    button.gref.indicator.mana[2]:SetAlpha(indAlpha)
                    button.gref.indicator.mana[3]:SetAlpha(indAlpha)
                end
            elseif button.mana.ind~=0 then
                button.mana.ind=0
                button.gref.indicator.mana[1]:SetAlpha(0)
                button.gref.indicator.mana[2]:SetAlpha(0)
                button.gref.indicator.mana[3]:SetAlpha(0)
            end
        elseif button.mana.ind~=0 then
            button.mana.ind=0
            button.gref.indicator.mana[1]:SetAlpha(0)
            button.gref.indicator.mana[2]:SetAlpha(0)
            button.gref.indicator.mana[3]:SetAlpha(0)
        end
    elseif button.mana.ind~=0 then
        button.mana.ind=0
        button.gref.indicator.mana[1]:SetAlpha(0)
        button.gref.indicator.mana[2]:SetAlpha(0)
        button.gref.indicator.mana[3]:SetAlpha(0)
    end
    if button.player and HealBot_Action_luVars["CheckManaDrink"] then
        HealBot_Aura_CheckForMana(button)
    end
end

local ooRhbX, ooRhbY, ooRhbD=0,0,-999
function HealBot_Action_ShowDirectionArrow(button)
      --HealBot_setCall("HealBot_Action_ShowDirectionArrow", button)
    if button.status.range == 0 and (not hbv_Skins_GetFrameBoolean("Icons", "SHOWDIRMOUSE", button.frame) or button.mouseover) then
        ooRhbX, ooRhbY, ooRhbD=HealBot_Range_DirectionCheck(button.unit)
        if ooRhbD then
            if button.status.dirarrowshown == 0 or button.status.dirarrowcords~=ooRhbD then 
                button.status.dirarrowcords=ooRhbD
                HealBot_Aura_OORUpdate(button, "Interface\\AddOns\\HealBot\\Images\\oor\\arrow.blp")
            end
            button.status.dirarrowshown=HealBot_TimeNow+0.2
        elseif button.status.dirarrowshown>0 then
            HealBot_Action_HideDirectionArrow(button)
        end
    elseif button.status.dirarrowshown>0 then
        HealBot_Action_HideDirectionArrow(button)
    end
end

function HealBot_Action_SetDirectionArrow(button, index)
      --HealBot_setCall("HealBot_Action_SetDirectionArrow", button)
    button.gref.icon[index]:SetTexCoord(ooRhbX, ooRhbX + 0.109375, ooRhbY, ooRhbY + 0.08203125)
end

function HealBot_Action_HideDirectionArrow(button)
      --HealBot_setCall("HealBot_Action_HideDirectionArrow", button)
    button.status.dirarrowshown=0
    HealBot_Aura_OORUpdate(button, false)
end

function HealBot_Action_setFrameHeader(f)
      --HealBot_setCall("HealBot_Action_setFrameHeader")
    if hbv_Skins_GetFrameBoolean("FrameAlias", "SHOW", f) and grpFrame[f]:GetRight() then
        grpFrameBar[f]:SetPoint("BOTTOM",grpFrame[f],"TOP",0,hbv_Skins_GetFrameVar("FrameAliasBar", "OFFSET", f))
        local fWidth=grpFrame[f]:GetRight()-grpFrame[f]:GetLeft()
        local hwidth=ceil(fWidth*hbv_Skins_GetFrameVar("FrameAliasBar", "WIDTH", f))
        grpFrameBar[f]:SetHeight(ceil(hbv_Skins_GetFrameVar("FrameAliasBar", "HEIGHT", f)*hbv_Skins_GetFrameVar("Frame", "SCALE", f)));
        grpFrameBar[f]:SetWidth(hwidth);
        HealBot_Media_UpdateTexture(grpFrameBar[f], hbv_Skins_GetFrameVar("FrameAliasBar", "TEXTURE", f), "Action_setFrameHeader - FrameAliasBar")
        grpFrameBar[f]:GetStatusBarTexture():SetHorizTile(false)
        HealBot_Action_UpdateFrameHeaderOpacity(f)
    else
        grpFrameBar[f]:SetStatusBarColor(0,0,0,0);
    end
end

local hbEventFuncs={["UNIT_AURA"]=HealBot_Events_UnitAura,
                    ["UNIT_INVENTORY_CHANGED"]=HealBot_Events_InvChange,
                    ["UNIT_HEALTH_FREQUENT"]=HealBot_UnitHealth,
                    ["UNIT_HEALTH"]=HealBot_UnitHealth,
                    ["UNIT_MAXHEALTH"]=HealBot_UnitHealth,
                    ["UNIT_THREAT_SITUATION_UPDATE"]=HealBot_CalcThreat,
                    ["UNIT_THREAT_LIST_UPDATE"]=HealBot_CalcThreat,
                    ["UNIT_HEAL_PREDICTION"]=HealBot_HealsInUpdate,
                    ["UNIT_HEAL_ABSORB_AMOUNT_CHANGED"]=HealBot_Events_TotalHealAbsorbs,
                    ["UNIT_ABSORB_AMOUNT_CHANGED"]=HealBot_AbsorbsUpdate,
                    ["UNIT_POWER_UPDATE"]=HealBot_UnitMana,
                    ["UNIT_POWER_POINT_CHARGE"]=HealBot_Events_PowerIndicators,
                    ["UNIT_MAXPOWER"]=HealBot_UnitMana,
                    ["UNIT_ATTACK"]=HealBot_Events_UnitThreat,
                    ["UNIT_COMBAT"]=HealBot_Events_UnitThreat,
                    ["UNIT_SPELLCAST_START"]=HealBot_Events_UnitSpellCastStart,
                    ["UNIT_SPELLCAST_CHANNEL_START"]=HealBot_Events_UnitSpellChanStart,
                    ["UNIT_SPELLCAST_FAILED"]=HealBot_Events_UnitSpellCastFailed,
                    ["UNIT_SPELLCAST_INTERRUPTED"]=HealBot_Events_UnitSpellCastFailed,
                    ["UNIT_SPELLCAST_CHANNEL_STOP"]=HealBot_Events_UnitSpellCastStop,
                    ["UNIT_SPELLCAST_STOP"]=HealBot_Events_UnitSpellCastStop,
                    ["UNIT_SPELLCAST_SUCCEEDED"]=HealBot_Events_UnitSpellCastComplete,
                    ["UNIT_TARGETABLE_CHANGED"]=HealBot_Events_UnitThreat,
                    ["PLAYER_TARGET_SET_ATTACKING"]=HealBot_Events_UnitThreat,
                    ["UNIT_TARGET"]=HealBot_Events_UnitTarget,
                    ["UNIT_PHASE"]=HealBot_Events_UnitPhase,
                    ["UNIT_NAME_UPDATE"]=HealBot_UnitExists,
                    ["UNIT_DISPLAYPOWER"]=HealBot_Events_UnitManaUpdate,
                    ["UNIT_CONNECTION"]=HealBot_Events_UnitStatus,
                    ["PARTY_MEMBER_ENABLE"]=HealBot_Events_UnitStatus,
                    ["PARTY_MEMBER_DISABLE"]=HealBot_Events_UnitStatus,
                    ["PLAYER_SPECIALIZATION_CHANGED"]=HealBot_Events_SpecChange,
                    ["UNIT_CLASSIFICATION_CHANGED"]=HealBot_Events_ClassificationChanged,
                    ["PLAYER_FLAGS_CHANGED"]=HealBot_Events_UnitFlagsChanged,
                    ["UNIT_FLAGS"]=HealBot_Events_UnitFlagsChanged,
                    ["UNIT_PORTRAIT_UPDATE"]=HealBot_Events_UpdateRange,
                    ["UNIT_MODEL_CHANGED"]=HealBot_Events_UpdateRange,
                    ["UNIT_AREA_CHANGED"]=HealBot_Events_UpdateRange,
                    ["UNIT_DISTANCE_CHECK_UPDATE"]=HealBot_Events_UpdateRange,
                    ["UNIT_IN_RANGE_UPDATE"]=HealBot_Events_UpdateRange,
                    ["INCOMING_RESURRECT_CHANGED"]=HealBot_Action_ResStateChanged,
                   }

local hbEnemyEventFuncs={["UNIT_PHASE"]=HealBot_Events_UnitPhase,
                         ["UNIT_NAME_UPDATE"]=HealBot_UnitExists,
                         ["UNIT_CLASSIFICATION_CHANGED"]=HealBot_Events_ClassificationChanged,
                   }

function HealBot_Action_SetStrata(preCombat)
    if preCombat then
        for x=1,10 do
            grpFrame[x]:SetFrameStrata(HealBot_Globals.FrameStrataIC)
        end
    else
        for x=1,10 do
            grpFrame[x]:SetFrameStrata(HealBot_Globals.FrameStrata)
        end
    end
    HealBot_ActionIcons_SetStrata(preCombat)
end

function HealBot_Action_InitFrames()
      --HealBot_setCall("HealBot_Action_InitFrames")
    local StickIndPoints={[1]="BOTTOMLEFT",[2]="BOTTOM",[3]="BOTTOMRIGHT",[4]="TOPLEFT",[5]="LEFT",[6]="BOTTOMLEFT",[7]="TOPRIGHT",[8]="TOP",[9]="TOPLEFT",[10]="BOTTOMRIGHT",[11]="RIGHT",[12]="TOPRIGHT"}
    local FrameStickIndPoints={[1]="TOPLEFT",[2]="TOP",[3]="TOPRIGHT",[4]="TOPRIGHT",[5]="RIGHT",[6]="BOTTOMRIGHT",[7]="BOTTOMRIGHT",[8]="BOTTOM",[9]="BOTTOMLEFT",[10]="BOTTOMLEFT",[11]="LEFT",[12]="TOPLEFT"}
    for x=1,10 do
        grpFrame[x]=_G["f"..x.."_HealBot_Action"]
        if not grpFrame[x] then
            grpFrame[x]=CreateFrame("Frame", "f"..x.."_HealBot_Action", UIParent, BackdropTemplateMixin and "SecureFrameTemplate,BackdropTemplate")
            grpFrame[x]:SetBackdrop({
                bgFile="Interface\\Addons\\HealBot\\Images\\frame\\WhiteLine.tga",
                edgeFile="Interface\\Addons\\HealBot\\Images\\frame\\border.tga",
                tile=true,
                tileSize=8,
                edgeSize=8,
                insets={ left=3, right=3, top=3, bottom=3, },
            })
            grpFrameText[1000+x]=grpFrame[x]:CreateFontString("f"..x.."_HealBot_Action_UnlockTxt", "ARTWORK", "GameFontNormal")
            grpFrameText[1000+x]:SetPoint("BOTTOM",grpFrame[x],"BOTTOM",0,4)
            grpFrame[x].id=x
            grpFrame[x]:SetMovable(true)
            grpFrame[x]:EnableMouse(true)
            grpFrame[x]:SetHeight(20)
            grpFrame[x]:SetWidth(20)
            grpFrame[x]:SetFrameLevel(1)
            grpFrame[x]:SetFrameStrata(HealBot_Globals.FrameStrata)
            grpFrame[x]:SetScript("OnShow", function(self) HealBot_Action_OnShow(self) end)
            grpFrame[x]:SetScript("OnMouseDown", function(self, button) HealBot_Action_OnMouseDown(self, button) end)
            grpFrame[x]:SetScript("OnEnter", function(self) HealBot_Action_OnEnter(self) end)
            grpFrame[x]:SetScript("OnLeave", function(self) HealBot_Action_OnLeave(self) end)
            grpFrame[x]:SetScript("OnMouseUp", function(self, button) HealBot_Action_OnMouseUp(self, button) end)
            grpFrameBar[x]=CreateFrame("StatusBar", "f"..x.."_HealBot_Action_HeaderBar", grpFrame[x], "TextStatusBar")
            grpFrameBar[x]:SetPoint("BOTTOM",grpFrame[x],"TOP",0,0)
            grpFrameBar[x]:SetMinMaxValues(0,100);
            grpFrameBar[x]:SetValue(100);
            local barScale=grpFrameBar[x]:GetScale();
            grpFrameBar[x]:SetScale(barScale + 0.01);
            grpFrameBar[x]:SetScale(barScale);
            grpFrameBar[x]:EnableMouse(false)
            grpFrameBar[x]:UnregisterAllEvents()
            grpFrameText[x]=grpFrameBar[x]:CreateFontString("f"..x.."_HealBot_Action_Title", "ARTWORK", "GameFontNormal")
            for y=1,12 do
                if not grpFrameStickyInd[x] then grpFrameStickyInd[x]={} end
                grpFrameStickyInd[x][y]=CreateFrame("StatusBar", "f"..x.."_HealBot_Action_StickyInd"..y, grpFrame[x], "TextStatusBar")
                HealBot_Media_UpdateTexture(grpFrameStickyInd[x][y], HealBot_Supplied_Textures[16].name, "Action_InitFrames - 16")
                grpFrameStickyInd[x][y]:SetStatusBarColor(1,1,0.25,0)
                grpFrameStickyInd[x][y]:SetPoint(StickIndPoints[y],grpFrame[x],FrameStickIndPoints[y])
                grpFrameStickyInd[x][y]:SetMinMaxValues(0,100);
                grpFrameStickyInd[x][y]:SetValue(100);
                grpFrameStickyInd[x][y]:EnableMouse(false)
                grpFrameStickyInd[x][y]:UnregisterAllEvents()
                if (y>3 and y<7) or (y>9) then
                    grpFrameStickyInd[x][y]:SetOrientation("VERTICAL")
                    grpFrameStickyInd[x][y]:SetHeight(32);
                    grpFrameStickyInd[x][y]:SetWidth(2);
                else
                    grpFrameStickyInd[x][y]:SetOrientation("HORIZONTAL")
                    grpFrameStickyInd[x][y]:SetHeight(2);
                    grpFrameStickyInd[x][y]:SetWidth(32);
                end
            end
            ShowUIPanel(grpFrame[x])
            --HealBot_Action_FrameSetPoint(x, grpFrame[x]) -- ** Uncommenting this can result in frames being out of place. **
            HideUIPanel(grpFrame[x])
            grpFrame[x].visible=false
            HealBot_Panel_ParentFrameID(x)
        end
    end
    if not lGlow then lGlow=HealBot_Libs_LibGlow() end
    HealBot_Events_Frame()
    HealBot_Action_luVars["FrameInitDone"]=true
end

function HealBot_Action_ShowPanel(frame, initOnly)
      --HealBot_setCall("HealBot_Action_ShowPanel"..frame)
    if HealBot_Config.DisabledNow == 0 then
        if not HealBot_Action_FrameIsVisible(frame) then
            ShowUIPanel(grpFrame[frame])
            grpFrame[frame].visible=true
            if not initOnly then
                if HealBot_AutoCloseFrame[frame] == 3 then
                    PlaySound(SOUNDKIT.IG_ABILITY_OPEN)
                end
                if hbUpdateFramesOpacity[frame] then
                    hbUpdateFramesOpacity[frame]=false
                    HealBot_Action_UpdateFrameOpacity(frame)
                end
            end
        end
    end
end

local hideFrame={[1]=true,[2]=true,[3]=true,[4]=true,[5]=true,[6]=true,[7]=true,[8]=true,[9]=true,[10]=true}
local showFrame={[1]=true,[2]=true,[3]=true,[4]=true,[5]=true,[6]=true,[7]=true,[8]=true,[9]=true,[10]=true}
function HealBot_Action_CheckAutoClose()
      --HealBot_setCall("HealBot_Action_HideFrames")
    if not HealBot_Action_luVars["TestBarsOn"] then
        for j=1,10 do
            hideFrame[j]=true
            showFrame[j]=false
        end
        for _,xButton in pairs(HealBot_Unit_Button) do
            showFrame[xButton.frame]=true
            if xButton.status.enabled then
                hideFrame[xButton.frame]=false
            end
        end
        for _,xButton in pairs(HealBot_Private_Button) do
            showFrame[xButton.frame]=true
            if xButton.status.enabled then
                hideFrame[xButton.frame]=false
            end
        end
        for _,xButton in pairs(HealBot_Extra_Button) do
            showFrame[xButton.frame]=true
            if xButton.status.enabled then
                hideFrame[xButton.frame]=false
            end
        end
        for _,xButton in pairs(HealBot_Enemy_Button) do
            showFrame[xButton.frame]=true
            if xButton.status.enabled then
                hideFrame[xButton.frame]=false
                break
            end
        end
        for xUnit,xButton in pairs(HealBot_UnitTarget_Button) do
            showFrame[xButton.frame]=true
            if xButton.status.enabled then
                hideFrame[xButton.frame]=false
                break
            end
        end
        for xUnit,xButton in pairs(HealBot_PrivateTarget_Button) do
            showFrame[xButton.frame]=true
            if xButton.status.enabled then
                hideFrame[xButton.frame]=false
                break
            end
        end
        for _,xButton in pairs(HealBot_Pet_Button) do
            showFrame[xButton.frame]=true
            if xButton.status.enabled then
                hideFrame[xButton.frame]=false
                break
            end
        end
        for _,xButton in pairs(HealBot_Vehicle_Button) do
            showFrame[xButton.frame]=true
            if xButton.status.enabled then
                hideFrame[xButton.frame]=false
                break
            end
        end
        for i=1, 10 do
            if HealBot_AutoCloseFrame[i] > 1 and hideFrame[i] then
                HealBot_Action_HidePanel(i)
            elseif showFrame[i] then
                HealBot_Action_ShowPanel(i)
            end
        end
    end
end

function HealBot_Action_HideUnusedFrames()
      --HealBot_setCall("HealBot_Action_HideUnusedFrames")
    if not HealBot_Action_luVars["TestBarsOn"] then
        for j=1,10 do
            showFrame[j]=false
        end
        for _,xButton in pairs(HealBot_Unit_Button) do
            showFrame[xButton.frame]=true
        end
        for _,xButton in pairs(HealBot_Private_Button) do
            showFrame[xButton.frame]=true
        end
        for _,xButton in pairs(HealBot_Extra_Button) do
            showFrame[xButton.frame]=true
        end
        for _,xButton in pairs(HealBot_Enemy_Button) do
            showFrame[xButton.frame]=true
        end
        for xUnit,xButton in pairs(HealBot_UnitTarget_Button) do
            showFrame[xButton.frame]=true
        end
        for xUnit,xButton in pairs(HealBot_PrivateTarget_Button) do
            showFrame[xButton.frame]=true
        end
        for _,xButton in pairs(HealBot_Pet_Button) do
            showFrame[xButton.frame]=true
        end
        for _,xButton in pairs(HealBot_Vehicle_Button) do
            showFrame[xButton.frame]=true
        end
        for i=1, 10 do
            if not showFrame[i] then
                HealBot_Action_HidePanel(i)
            end
        end
    end
end

function HealBot_Action_UpdateFrameOpacity(frame)
      --HealBot_setCall("HealBot_Action_UpdateFrameOpacity")
    HealBot_Action_SetFrameCols(frame)
    if hbv_Skins_GetFrameBoolean("FrameAlias", "SHOW", frame) then
        HealBot_Action_UpdateFrameHeaderOpacity(frame)
        HealBot_Action_SetFrameTextColours(frame)
    end
end

function HealBot_Action_UpdateFramesOpacity()
      --HealBot_setCall("HealBot_Action_UpdateFramesOpacity")
    for x=1,10 do
        if HealBot_Action_FrameIsVisible(x) then
            HealBot_Action_UpdateFrameOpacity(x)
        else
            hbUpdateFramesOpacity[x]=true
        end
    end
end

function HealBot_Action_FrameIsVisible(frame)
      --HealBot_setCall("HealBot_Action_FrameIsVisible")
    return grpFrame[frame].visible
end

function HealBot_Action_HidePanel(frame, initOnly)
      --HealBot_setCall("HealBot_Action_HidePanel")
    if HealBot_Action_FrameIsVisible(frame) then
        HideUIPanel(grpFrame[frame])
        grpFrame[frame].visible=false
        if not initOnly and HealBot_AutoCloseFrame[frame] == 3 then
            PlaySound(SOUNDKIT.IG_ABILITY_CLOSE)
        end
    end
end

function HealBot_Action_ResetUnitButtonOpacity(button)
      --HealBot_setCall("HealBot_Action_ResetUnitButtonOpacity", button)
    HealBot_Action_UpdateBackground(button)
    HealBot_Text_UpdateButton(button)
    HealBot_Action_EmergBarCheck(button, true)
    HealBot_Aux_UpdBar(button)
    HealBot_RefreshUnit(button)
    if button.health.incoming>0 then HealBot_Action_UpdateHealsInButton(button) end
    if button.health.absorbs>0 then HealBot_Action_UpdateAbsorbsButton(button) end
    HealBot_Aura_Update_AllIcons(button)
    HealBot_Events_PowerIndicators(button)
    HealBot_Action_CheckUnitLowMana(button)
    HealBot_Aggro_IndicatorUpdate(button)
end

function HealBot_Action_ResetOpacity(force)
      --HealBot_setCall("HealBot_Action_ResetOpacity")
    if HealBot_Action_luVars["LastResetFrame"] ~= HealBot_Action_luVars["ResetFrame"] or force then
        HealBot_Action_luVars["LastResetFrame"]=HealBot_Action_luVars["ResetFrame"]
        HealBot_Update_ResetUnitOpacity()
        HealBot_Action_UpdateFramesOpacity()
        HealBot_Panel_UpdateHeadersOpacity()
    end
end

function HealBot_Action_UpdateGlobalDimming(frame)
    if hbv_Skins_GetVar("General", "GLOBALDIMMING")>1 then
        HealBot_Action_luVars["ResetFrame"]=frame
        HealBot_Timers_Set("SKINS","UpdateGlobalDimming",true)
    end
end

function HealBot_Action_ResetrCallsUnit(button)
      --HealBot_setCall("HealBot_Action_ResetrCallsUnit", button)
    button.mana.ind=-1
    button.mana.power=-1
    button.aggro.ind=-1
end

function HealBot_Action_SetAuxGlow(button, id)
      --HealBot_setCall("HealBot_Action_SetAuxGlow")
    if button.id<500 then
        button.gref.auxglow[id]=CreateFrame("Frame", "HB_AuxGlow_"..button.id..id , button.gref.aux[id], BackdropTemplateMixin and "BackdropTemplate")
        button.gref.auxglow[id]:SetFrameLevel(1001)
        button.gref.auxglow[id]:SetBackdrop({edgeFile="Interface\\Buttons\\WHITE8X8",
                                            edgeSize=2,
                                            insets={ left=0, right=0, top=0, bottom=0}})
        button.gref.auxglow[id]:SetPoint("TOPLEFT", button.gref.aux[id], "TOPLEFT",-1,1)
        button.gref.auxglow[id]:SetPoint("BOTTOMRIGHT", button.gref.aux[id], "BOTTOMRIGHT",1,-1)
        button.gref.auxglow[id]:SetBackdropColor(0,0,0,0)
        button.gref.auxglow[id]:SetBackdropBorderColor(0,0,0,0)
        button.gref.auxglow[id]:EnableMouse(false)
        button.gref.auxglow[id]:UnregisterAllEvents()
        button.aux[id]["OUTLINE"]=true
        HealBot_Action_luVars["NumAuxOutlines"]=HealBot_Action_luVars["NumAuxOutlines"]+1
        HealBot_Debug_PerfUpdate("auxOutlines", HealBot_Action_luVars["NumAuxOutlines"])
        HealBot_Aux_UpdateAuxByTypeById(button, button.frame, id)
    end
end

local hbInitAuxGlow={}
function HealBot_Action_InitAuxGlow(id, frame, button)
      --HealBot_setCall("HealBot_Action_InitAuxGlow")
    if hbv_Aux_GetBarVar("OUTLINE", frame, id) and hbv_Aux_GetBarVar("USE", frame, id)>1 then
        if not hbInitAuxGlow[frame] then hbInitAuxGlow[frame]={} end
        if button then
            if button.frame == frame and not button.aux[id]["OUTLINE"] then
                HealBot_Action_SetAuxGlow(button, id)
            end
        elseif not hbInitAuxGlow[frame][id] then
            hbInitAuxGlow[frame][id]=true
            for _,xButton in pairs(HealBot_Unit_Button) do
                if xButton.frame == frame and not xButton.aux[id]["OUTLINE"] then
                    HealBot_Action_SetAuxGlow(xButton, id)
                end
            end
            for _,xButton in pairs(HealBot_Private_Button) do
                if xButton.frame == frame and not xButton.aux[id]["OUTLINE"] then
                    HealBot_Action_SetAuxGlow(xButton, id)
                end
            end
            for _,xButton in pairs(HealBot_Extra_Button) do
                if xButton.frame == frame and not xButton.aux[id]["OUTLINE"] then
                    HealBot_Action_SetAuxGlow(xButton, id)
                end
            end
            for _,xButton in pairs(HealBot_Pet_Button) do
                if xButton.frame == frame and not xButton.aux[id]["OUTLINE"] then
                    HealBot_Action_SetAuxGlow(xButton, id)
                end
            end
            for _,xButton in pairs(HealBot_Vehicle_Button) do
                if xButton.frame == frame and not xButton.aux[id]["OUTLINE"] then
                    HealBot_Action_SetAuxGlow(xButton, id)
                end
            end
            for _,xButton in pairs(HealBot_Enemy_Button) do
                if xButton.frame == frame and not xButton.aux[id]["OUTLINE"] then
                    HealBot_Action_SetAuxGlow(xButton, id)
                end
            end
            for xUnit,xButton in pairs(HealBot_UnitTarget_Button) do
                if xButton.frame == frame and not xButton.aux[id]["OUTLINE"] then
                    HealBot_Action_SetAuxGlow(xButton, id)
                end
            end
            for xUnit,xButton in pairs(HealBot_PrivateTarget_Button) do
                if xButton.frame == frame and not xButton.aux[id]["OUTLINE"] then
                    HealBot_Action_SetAuxGlow(xButton, id)
                end
            end
        end
    end
end

function HealBot_Action_InitButton(button, prefix)
      --HealBot_setCall("HealBot_Action_InitButton")
    erButton=HealBot_Emerg_Button[button.id]
    button:SetAttribute("checkselfcast", false)
    erButton:SetAttribute("checkselfcast", false)
    if HEALBOT_GAME_VERSION>1 then
        button:SetAttribute("checkfocuscast", false)
        erButton:SetAttribute("checkfocuscast", false)
    end
    --button:SetFrameStrata(HealBot_Globals.FrameStrata)
    --erButton:SetFrameStrata(HealBot_Globals.FrameStrata)
    button.guid="nil"
    button.unit="nil"
    erButton.unit="nil"
    button.skin=""
    button.aura={}
    button.aura.buff={}
    button.aura.buff.recheck={}
    button.aura.buff.temp={}
    button.aura.debuff={}
    button.aura.debuff.temp={}
    button.status={}
    button.special={}
    button.debug={}
    button.event={}
    button.event.aura=true
    button.event.buff=true
    button.event.debuff=true
    button.special.unit=false
    button.special.aura=false
    button.special.auraupdate=0
    button.raidid=0
    erButton.status={}
    button.update={}
    button.checks={}
    button.health={}
    button.spells={}
    button.aggro={}
    button.mana={}
    button.power={}
    button.text={}
    button.icon={}
    button.hotbars={}
    button.hazard={}
    button.glow={}
    button.glow.icon={}
    button.plugin={}
    button.request={}
    button.buffwatch={}
    button.aurawatch={}
    button.healthwatch={}
    button.manawatch={}
    button.attribs={["Emerg"]={},["Enemy"]={},["Enabled"]={}}
    erButton.attribs={["Emerg"]={},["Enemy"]={},["Enabled"]={}}
    button.binds={["Emerg"]={},["Enemy"]={},["Enabled"]={}}
    erButton.binds={["Emerg"]={},["Enemy"]={},["Enabled"]={}}
    button.icon.debuff={}
    button.icon.debuff.count={}
    button.icon.buff={}
    button.icon.buff.count={}
    button.icon.extra={}
    button.aux={}
    button.auxtxt={}
    for x=1,10 do
        button.aux[x]={}
        button.auxtxt[x]={}
    end
    button.adaptive={}
    button.adaptive.current=12
    for x=1,11 do
        button.adaptive[x]=false
    end
    button.gref={}
    button.gref.aux={}
    button.gref.auxtxt={}
    button.gref.auxglow={}
    button.gref.txt={}
    button.gref.txt.expire={}
    button.gref.txt.count={}
    button.gref.icon={}
    button.gref.iconf={}
    button.gref.iconh={}
    button.gref.indicator={}
    button.gref.indicator.aggro={}
    button.gref.indicator.mana={}
    button.gref.indicator.selfcast={}
    button.gref.indicator.power={}
    button.gref["Bar"]=_G[button.bName.."Bar"]
    button.gref["Bar"]:SetMinMaxValues(0,1000)
    erButton.bar=_G[erButton.bName.."Bar"]
    erButton.bar:UnregisterAllEvents()
    erButton.bar:SetMinMaxValues(0,1)
    erButton.bar:SetValue(1)
    erButton.used=true
    button.gref["InHeal"]=_G[button.bName.."Bar2"]
    button.gref["InHeal"]:SetMinMaxValues(0,1000)
    button.gref["InHeal"]:SetValue(0)
    button.gref["Back"]=_G[button.bName.."Bar5"]
    button.gref["Back"]:SetValue(100)
    button.gref["Back"]:SetMinMaxValues(0,100)
    button.gref["Back"]:SetStatusBarTexture("Interface\\Buttons\\WHITE8X8");
    button.gref["Back"]:GetStatusBarTexture():SetHorizTile(false)
    button.gref["BackBorder"]=CreateFrame("Frame", "HealBot_BarBackBorder_"..button.id , button.gref["Back"], BackdropTemplateMixin and "BackdropTemplate")
    button.gref["BackBorder"].size=0
    button.gref["Top"]=_G[button.bName.."Bar7"]
    button.gref["Top"]:SetValue(100)
    button.gref["Top"]:SetMinMaxValues(0,100)
    button.gref["Top"]:SetStatusBarColor(0, 0, 0, 0)
    button.gref["IconTop"]=_G[button.bName.."Bar8"]
    button.gref["IconTop"]:SetValue(100)
    button.gref["IconTop"]:SetMinMaxValues(0,100)
    button.gref["IconTop"]:SetStatusBarColor(0, 0, 0, 0)
    button.gref["Absorb"]=_G[button.bName.."Bar6"]
    button.gref["Absorb"]:SetMinMaxValues(0,1000)
    button.gref["Absorb"]:SetValue(0)           
    button.gref["Shield"]=_G[button.bName.."Bar3"]
    button.gref["Shield"]:SetMinMaxValues(0,1000)
    button.gref["Shield"]:SetValue(1000)
    button.gref["Shield"]:SetStatusBarTexture("Interface\\Addons\\HealBot\\Images\\frame\\Shield.tga")
    button.gref["Shield"]:SetStatusBarColor(0,0,0,0)
    button.gref["Shield"]:SetOrientation("VERTICAL")
    button:SetFrameLevel(HealBot_Action_luVars["buttonFrameLevel"]); 
    button.gref["Back"]:SetFrameLevel(button:GetFrameLevel()+ 1)
    button.gref["Back"]:UnregisterAllEvents()
    button.gref["Back"]:EnableMouse(false)
    button.gref["Top"]:SetFrameLevel(button:GetFrameLevel()+30)
    button.gref["Top"]:UnregisterAllEvents()
    button.gref["Top"]:EnableMouse(false)
    button.gref["BackBorder"]:SetFrameLevel(80)
    button.gref["BackBorder"]:UnregisterAllEvents()
    button.gref["BackBorder"]:EnableMouse(false)
    button.gref["IconTop"]:SetFrameLevel(100)
    button.gref["IconTop"]:UnregisterAllEvents()
    button.gref["IconTop"]:EnableMouse(false)
    
    button.gref["Absorb"]:SetFrameLevel(button.gref["Back"]:GetFrameLevel()+ 1)
    button.gref["Absorb"]:UnregisterAllEvents()
    button.gref["Absorb"]:EnableMouse(false)
    button.gref["InHeal"]:SetFrameLevel(button.gref["Absorb"]:GetFrameLevel()+ 1)
    button.gref["InHeal"]:UnregisterAllEvents()
    button.gref["InHeal"]:EnableMouse(false)
    button.gref["Bar"]:SetFrameLevel(button.gref["InHeal"]:GetFrameLevel()+ 1)
    button.gref["Bar"]:UnregisterAllEvents()
    button.gref["Bar"]:EnableMouse(false)
    button.gref["Shield"]:SetFrameLevel(button.gref["Bar"]:GetFrameLevel()+ 1)
    button.gref["Shield"]:UnregisterAllEvents()
    button.gref["Shield"]:EnableMouse(false)
    button:Enable();
    erButton:Enable();
    for x=1,9 do
        button.gref.aux[x]=_G[button.bName.."Aux"..x]
        button.gref.aux[x]:UnregisterAllEvents()
        button.gref.aux[x]:SetMinMaxValues(0,1000)
        button.gref.aux[x]:SetFrameLevel(button.gref["Bar"]:GetFrameLevel()+x)
        button.gref.aux[x]:EnableMouse(false)
        button.gref.auxtxt[x]=_G[button.bName.."Aux"..x.."_Txt"]
        button.gref.auxtxt[x]:SetSpacing(0)
        button.gref.auxtxt[x]:SetWordWrap(false)
    end
    button.gref.txt["text"]=_G[button.bName.."Bar_text"]
    button.gref.txt["text"]:SetWordWrap(false)
    button.gref.txt["text2"]=_G[button.bName.."Bar_text2"]
    button.gref.txt["text2"]:SetWordWrap(false)
    button.gref.txt["text3"]=_G[button.bName.."Bar_text3"]
    button.gref.txt["text3"]:SetWordWrap(false)
    button.gref.txt["text4"]=_G[button.bName.."Bar_text4"]
    button.gref.txt["text4"]:SetWordWrap(false)
    button.gref.txt["text5"]=_G[button.bName.."Bar_text5"]
    button.gref.txt["text5"]:SetWordWrap(false)
    button.gref.icon["Icontm1"]=_G[button.bName.."Bar8Icontm1"]
    button.gref.icon["Icontm2"]=_G[button.bName.."Bar8Icontm2"]
    button.gref.icon["Icontm3"]=_G[button.bName.."Bar8Icontm3"]
    for x=1,12 do
        button.gref.icon[x]=_G[button.bName.."Bar8Icon"..x]
        button.gref.iconf[x]=_G[prefix.."ID"..button.id.."Icon"..x]
        button.glow.icon[x]=0
    end
    for x=51,60 do
        button.gref.icon[x]=_G[button.bName.."Bar8Icon"..x]
        button.gref.iconf[x]=_G[prefix.."ID"..button.id.."Icon"..x]
        button.glow.icon[x]=0
    end
    button.gref.icon[91]=_G[button.bName.."Bar8ExtraClass"]
    button.gref.icon[92]=_G[button.bName.."Bar8ExtraTarget"]
    button.gref.icon[93]=_G[button.bName.."Bar8ExtraRC"]
    button.gref.icon[94]=_G[button.bName.."Bar8ExtraOOR"]
    button.gref.icon[95]=_G[button.bName.."Bar8ExtraRank"]
    button.gref.icon[96]=_G[button.bName.."Bar8ExtraCombat"]
    for x=1,12 do
        button.gref.txt.expire[x]=_G[button.bName.."Bar8Expire"..x]
        button.gref.txt.count[x]=_G[button.bName.."Bar8Count"..x]
    end
    for x=51,60 do
        button.gref.txt.expire[x]=_G[button.bName.."Bar8Expire"..x]
        button.gref.txt.count[x]=_G[button.bName.."Bar8Count"..x]
    end
    for x=1,3 do
        button.gref.indicator.aggro["Iconal"..x]=_G[button.bName.."Bar8Iconal"..x]
        button.gref.indicator.aggro["Iconar"..x]=_G[button.bName.."Bar8Iconar"..x]
        button.gref.indicator.mana[x]=_G[button.bName.."Bar8Icontm"..x]
    end
    for x=1,16 do
        button.gref.indicator.selfcast[x]=_G[button.bName.."Bar8Own"..x]
        button.gref.indicator.selfcast[x]:SetAlpha(0)
    end
    for x=1,5 do
        button.gref.indicator.power[x]=_G[button.bName.."Bar8Iconpi"..x]
        button.gref.indicator.power[x]:SetAlpha(0);
    end
    button.frame=0
    button.framecol=10
    erButton.r,erButton.g,erButton.b,erButton.a=0,0,0,0
    erButton:EnableMouse(false)
    erButton.regClicks=false
    erButton.frame=0
    button:EnableMouse(false)
    button.regClicks=false
    button.text.r=1
    button.text.g=1
    button.text.b=1
    button.text.nr=1
    button.text.ng=1
    button.text.nb=1
    button.text.na=1
    button.text.hr=1
    button.text.hg=1
    button.text.hb=1
    button.text.ha=1
    button.text.sr=1
    button.text.sg=1
    button.text.sb=1
    button.text.sa=1
    button.text.ar=0
    button.text.ag=0
    button.text.ab=0
    button.text.aa=0
    button.hazard.r=1
    button.hazard.g=1
    button.hazard.b=1
    button.hazard.er=1
    button.hazard.eg=1
    button.hazard.eb=1
    button.hazard.hpct=800
    button.plugin.colbar=0
    button.request.colbar=0
    button.aurawatch.colbar=0
    button.healthwatch.colbar=0
    button.manawatch.colbar=0
    button.buffwatch.timeout=0
    button.aurawatch.timeout=0
    button.healthwatch.timeout=0
    button.manawatch.timeout=0
    button.plugin.r=1
    button.plugin.g=1
    button.plugin.b=1
    button.aggro.mobname=""
    button.text.health=""
    button.text.vphealth=""
    button.text.healthcomplete=""
    button.text.inheallen=0
    button.text.overheallen=0
    button.text.name=""
    button.text.nameonly=""
    button.text.namecomplete=""
    button.text.namehealth=""
    button.text.nametag=""
    button.text.inheal=""
    button.text.overheal=""
    button.text.aggro=""
    button.text.tag=""
    button.health.inhealr=0.2
    button.health.inhealg=1
    button.health.inhealb=0.2
    button.health.inheala=0
    button.health.absorbr=1
    button.health.absorbg=1
    button.health.absorbb=1
    button.health.absorba=0
    button.health.mixcolr=0
    button.health.mixcolg=0
    button.health.mixcolb=0
    button.health.rmixcolr=0
    button.health.rmixcolg=0
    button.health.rmixcolb=0
    --button.health.nextcheck=0
    
    for x=1,9 do
        button.aux[x]["R"]=1
        button.aux[x]["G"]=1
        button.aux[x]["B"]=1
        button.aux[x]["FLUID"]=-1
        button.aux[x]["TIMED"]=-1
        button.aux[x]["TIMEDH2L"]=-1
        button.aux[x]["TIMEDL2H"]=-1
        button.aux[x]["FLUIDSTATE"]=-1
        button.aux[x]["FLUIDTEXT"]=-1
        button.aux[x]["FLASH"]=false
        button.aux[x]["STATIC"]=false
        button.aux[x]["FIXED"]=true
        button.aux[x]["OUTLINE"]=false
        button.auxtxt[x]["R"]=1
        button.auxtxt[x]["G"]=1
        button.auxtxt[x]["B"]=1
        button.gref.aux[x]:SetStatusBarColor(0, 0, 0, 0)
        button.gref.aux[x]:SetValue(0)
    end
    button.aura.buff.update=true
    button.aura.buff.name=false
    button.aura.buff.missingbuff=false
    button.aura.buff.id=0
    button.aura.buff.priority=99
    button.aura.buff.nextcheck=false
    button.aura.buff.resetcheck=false
    button.aura.buff.colbar=0
    button.aura.buff.r=1
    button.aura.buff.g=1
    button.aura.buff.b=1
    button.aura.buff.temp.active=false
    button.aura.buff.temp.priority=99
    for z=1,3 do
        button.icon.buff.count[z]=0
        button.icon.debuff.count[z]=0
    end
    button.aura.debuff.update=true
    button.aura.debuff.type=false
    button.aura.debuff.name=false
    button.aura.debuff.id=0
    button.aura.debuff.priority=99
    button.aura.debuff.colbar=0
    button.aura.debuff.curespell=false
    button.aura.debuff.r=1
    button.aura.debuff.g=1
    button.aura.debuff.b=1
    button.aura.debuff.temp.active=false
    button.aura.debuff.temp.priority=99
    button.icon.extra.targeticon=0
    button.icon.extra.classtexture=false
    button.icon.extra.oorarrow=false
    button.icon.extra.hostile=false
    button.aggro.ind=-1
    button.aggro.status=-1
    button.aggro.threatpct=0
    button.aggro.threatvalue=0
    button.aggro.targeted=0
    button.aggro.nextcheck=0
    button.hotbars.state=false
    button.hotbars.debuff=false
    button.hotbars.health=false
    button.status.slowupdate=true
    button.status.update=true
    button.status.change=true
    button.status.hlthupd=true
    --button.mana.nextcheck=0
    button.health.rcol=0
    button.health.gcol=0
    button.health.dropalert=0
    button.mana.current=0
    button.mana.max=0
    button.mana.pct=0
    button.mana.pctc=0
    button.mana.type=0
    button.mana.ind=-1
    button.mana.power=-1
    button.mana.r=0
    button.mana.g=0
    button.mana.b=1
    button.mana.change=false
    button.mana.lowcheck=true
    
    button.guild=false
    button.guildtitle=""
    button.guildrank=99
    button.status.playerlastheal=0
    button.status.lasthealthdrop=0
    button.status.r=0
    button.status.g=0
    button.status.b=0
    button.status.alpha=1
    button.status.dirarrowcords=0 
    button.status.dirarrowshown=0 
    button.status.castend=-1
    button.status.isdead=false
    button.status.isspirit=false
    button.status.resstart=0
    button.status.range=-9
    button.status.rangespell=HealBot_Range_Spell("HEAL")
    button.status.deadnextcheck=0
    button.status.unittype=0
    button.status.enabled=false
    button.status.summons=false
    button.status.incombat=false
    button.status.hostile=false
    button.status.role=0
    button.status.hasres=false
    button.status.nextcheck=0
    button.status.falling=false
    button.status.swimming=false
    button.status.deadcheck=0
    button.debug.track=false
    button.debug.updtime="[]"
    button.debug.prevtime=false
    button.group=1
    button.rank=0
    button.role=0
    button.roletxt="DAMAGER"
    button.player=false
    button.isplayer=false
    button.isgroupraid=false
    button.level=1
    button.status.events=false
    button.status.duplicate=false
    button.name=false

    button.status.classknown=false
    button.status.plugin=false
    button.health.init=true
    button.mana.init=true
    button.status.current=HealBot_Unit_Status["CHECK"]
    button.health.current=-1
    button.health.max=100
    button.health.pct=.999
    button.health.hpct=999
    button.health.incoming=0
    button.health.auxincoming=0
    button.health.healabsorbs=0
    button.health.inhptc=0
    button.health.absorbs=0
    button.health.absorbspctc=0
    button.health.auxabsorbs=0
    button.health.auraabsorbs=0
    button.health.abptc=0
    button.health.overheal=0
    button.health.updhlth=true
    button.spec=" "
    button.specupdate=0
    button.gref["Bar"]:SetStatusBarColor(0, 0, 0, 0)
    button.gref["Bar"]:SetValue(1000)
    button.gref["InHeal"]:SetStatusBarColor(0, 0, 0, 0)
    button.gref["Back"]:SetStatusBarColor(0, 0, 0, 0)
    button.gref["Absorb"]:SetStatusBarColor(0, 0, 0, 0)
    button.text.classtrim="XXXX"
    button.gref.txt["text"]:SetText("")
    button.gref.txt["text2"]:SetText("")
    button.gref.txt["text3"]:SetText("")
    button.gref.txt["text4"]:SetText("")
    button.gref.txt["text5"]:SetText("")
    button.text.nameupdate=true
    button.text.tagupdate=true
    button.text.healthupdate=true
    button.text.aggroupdate=true
    erButton.state=0
    erButton.bar:SetStatusBarColor(0,0,0,0)
    erButton.isEmerg=true
    button.isEmerg=false
    button.gref["EmergBorder"]=CreateFrame("Frame", "HealBot_EmergBorder_"..button.id , erButton.bar, BackdropTemplateMixin and "BackdropTemplate")
    button.gref["EmergBorder"]:SetFrameLevel(80)
    button.gref["EmergBorder"]:UnregisterAllEvents()
    button.gref["EmergBorder"]:EnableMouse(false)
    button.gref["EmergBorder"]:SetPoint("TOPLEFT", erButton.bar, "TOPLEFT",0,0)
    button.gref["EmergBorder"]:SetPoint("BOTTOMRIGHT", erButton.bar, "BOTTOMRIGHT",0,0)
    button.glow.emerg={}
    button.glow.emerg["EB"]=0
    button.glow.emerg["ED"]=0
    
    HealBot_Action_MarkAttribUpdateButton(button, true, true, true)
    HealBot_Aura_setButtonIcons(button.id)
    HealBot_Aux_AssignLastOverlayType(button.id)
end

function HealBot_Action_UnregisterUnitEvents(button)
      --HealBot_setCall("HealBot_Action_UnregisterUnitEvents", button)
    button.status.events=false
    button:UnregisterEvent("UNIT_AURA")
    button:UnregisterEvent("UNIT_INVENTORY_CHANGED")
    button:UnregisterEvent("UNIT_MAXHEALTH")
    button:UnregisterEvent("UNIT_POWER_UPDATE")
    button:UnregisterEvent("UNIT_DISPLAYPOWER")
    button:UnregisterEvent("UNIT_MAXPOWER")
    button:UnregisterEvent("UNIT_PHASE")
    button:UnregisterEvent("UNIT_NAME_UPDATE")
    button:UnregisterEvent("UNIT_CONNECTION")
    button:UnregisterEvent("PARTY_MEMBER_ENABLE")
    button:UnregisterEvent("PARTY_MEMBER_DISABLE")
    button:UnregisterEvent("UNIT_SPELLCAST_START")
    button:UnregisterEvent("UNIT_SPELLCAST_CHANNEL_START")
    button:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED")
    button:UnregisterEvent("UNIT_SPELLCAST_FAILED")
    button:UnregisterEvent("UNIT_SPELLCAST_INTERRUPTED")
    button:UnregisterEvent("UNIT_SPELLCAST_CHANNEL_STOP")
    button:UnregisterEvent("UNIT_SPELLCAST_STOP")
    button:UnregisterEvent("UNIT_ATTACK")
    button:UnregisterEvent("UNIT_COMBAT")
    button:UnregisterEvent("UNIT_TARGETABLE_CHANGED")
    button:UnregisterEvent("UNIT_PORTRAIT_UPDATE")
    button:UnregisterEvent("UNIT_MODEL_CHANGED")
    if HEALBOT_GAME_VERSION == 1 then
        button:UnregisterEvent("PLAYER_TARGET_SET_ATTACKING")
    end
    button:UnregisterEvent("UNIT_TARGET")
    button:UnregisterEvent("UNIT_THREAT_SITUATION_UPDATE")
    button:UnregisterEvent("UNIT_THREAT_LIST_UPDATE")
    button:UnregisterEvent("UNIT_CLASSIFICATION_CHANGED")
    button:UnregisterEvent("PLAYER_FLAGS_CHANGED")
    button:UnregisterEvent("UNIT_FLAGS")
    button:UnregisterEvent("UNIT_DISTANCE_CHECK_UPDATE")
    button:UnregisterEvent("UNIT_IN_RANGE_UPDATE")
    button:UnregisterEvent("INCOMING_RESURRECT_CHANGED")
    if HEALBOT_GAME_VERSION>4 then
        button:UnregisterEvent("UNIT_ABSORB_AMOUNT_CHANGED")
        button:UnregisterEvent("UNIT_HEAL_ABSORB_AMOUNT_CHANGED")
        button:UnregisterEvent("UNIT_AREA_CHANGED")
    end
    if HEALBOT_GAME_VERSION>8 then
        button:UnregisterEvent("UNIT_POWER_POINT_CHARGE")
    end
    if HEALBOT_GAME_VERSION>3 then
        button:UnregisterEvent("UNIT_HEALTH")
        button:UnregisterEvent("PLAYER_SPECIALIZATION_CHANGED")
    else
        button:UnregisterEvent("UNIT_HEALTH_FREQUENT")
    end
    button:UnregisterEvent("UNIT_HEAL_PREDICTION")
end

HealBot_Action_luVars["regAggro"]=false
function HealBot_Action_Register_Aggro()
      --HealBot_setCall("HealBot_Action_Register_Aggro")
    local regAggro=HealBot_Action_luVars["pluginThreat"]
    for x=1,10 do
        if hbv_Skins_GetFrameBoolean("BarAggro", "SHOW", x) then
            regAggro=true
            break
        end
    end
    if HealBot_Action_luVars["regAggro"]~=regAggro then
        HealBot_Action_luVars["resetEvents"]=true
        HealBot_Action_luVars["regAggro"]=regAggro
        HealBot_setLuVars("regAggro", regAggro)
        HealBot_Timers_Set("LAST","ResetAllButtons")
        HealBot_Timers_Set("OOC","RefreshPartyNextRecalcAll")
    end
end

function HealBot_Action_RegisterUnitEvents(button)
      --HealBot_setCall("HealBot_Action_RegisterUnitEvents", button)
    button.status.events=true
    button:RegisterUnitEvent("UNIT_PHASE", button.unit)
    button:RegisterUnitEvent("UNIT_NAME_UPDATE", button.unit)
    button:RegisterUnitEvent("UNIT_CLASSIFICATION_CHANGED", button.unit)
    if button.frame<10 then
        button:RegisterUnitEvent("PLAYER_FLAGS_CHANGED", button.unit)
        button:RegisterUnitEvent("UNIT_FLAGS", button.unit)
        button:RegisterUnitEvent("UNIT_AURA", button.unit)
        button:RegisterUnitEvent("UNIT_MAXHEALTH", button.unit)
        button:RegisterUnitEvent("UNIT_POWER_UPDATE", button.unit)
        button:RegisterUnitEvent("UNIT_DISPLAYPOWER", button.unit)
        button:RegisterUnitEvent("UNIT_MAXPOWER", button.unit)
        button:RegisterUnitEvent("UNIT_SPELLCAST_START", button.unit)
        button:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_START", button.unit)
        button:RegisterUnitEvent("UNIT_SPELLCAST_FAILED", button.unit)
        button:RegisterUnitEvent("UNIT_SPELLCAST_INTERRUPTED", button.unit)
        button:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_STOP", button.unit)
        button:RegisterUnitEvent("UNIT_SPELLCAST_STOP", button.unit)
        button:RegisterUnitEvent("UNIT_HEAL_PREDICTION", button.unit)
        button:RegisterUnitEvent("UNIT_PORTRAIT_UPDATE", button.unit)
        button:RegisterUnitEvent("UNIT_MODEL_CHANGED", button.unit)
        button:RegisterUnitEvent("UNIT_DISTANCE_CHECK_UPDATE", button.unit)
        button:RegisterUnitEvent("UNIT_IN_RANGE_UPDATE", button.unit)
        button:RegisterUnitEvent("INCOMING_RESURRECT_CHANGED", button.unit)
        if HEALBOT_GAME_VERSION>4 then
            button:RegisterUnitEvent("UNIT_ABSORB_AMOUNT_CHANGED", button.unit)
            button:RegisterUnitEvent("UNIT_HEAL_ABSORB_AMOUNT_CHANGED", button.unit)
            button:RegisterUnitEvent("UNIT_AREA_CHANGED", button.unit)
        end
        if HEALBOT_GAME_VERSION>3 then
            button:RegisterUnitEvent("UNIT_HEALTH", button.unit)
            button:RegisterUnitEvent("PLAYER_SPECIALIZATION_CHANGED", button.unit)
        else
            button:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", button.unit)
        end
        button:RegisterUnitEvent("UNIT_CONNECTION", button.unit)
        button:RegisterUnitEvent("PARTY_MEMBER_ENABLE", button.unit)
        button:RegisterUnitEvent("PARTY_MEMBER_DISABLE", button.unit)
        if HEALBOT_GAME_VERSION == 1 and HealBot_Action_luVars["regAggro"] then
            button:RegisterUnitEvent("PLAYER_TARGET_SET_ATTACKING", button.unit)
        end
        if HEALBOT_GAME_VERSION>8 then
            button:RegisterUnitEvent("UNIT_POWER_POINT_CHARGE", button.unit)
        end
        if UnitIsUnit(button.unit, "player") then
            button:RegisterUnitEvent("UNIT_INVENTORY_CHANGED", button.unit)
            button:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", button.unit)
        end
        if HealBot_Action_luVars["regAggro"] then
            button:RegisterUnitEvent("UNIT_THREAT_SITUATION_UPDATE", button.unit)
            button:RegisterUnitEvent("UNIT_THREAT_LIST_UPDATE", button.unit)
            button:RegisterUnitEvent("UNIT_ATTACK", button.unit)
            button:RegisterUnitEvent("UNIT_COMBAT", button.unit)
            button:RegisterUnitEvent("UNIT_TARGETABLE_CHANGED", button.unit)
            button:RegisterUnitEvent("UNIT_TARGET", button.unit)
        end
    end
end

local tPrepButton=""
function HealBot_Action_PrepButton(button)
      --HealBot_setCall("HealBot_Action_PrepButton")
    button.reset=true
    button.status.markdel=false
end

local freeId=1
HealBot_Action_luVars["ButtonHWM"]=0
HealBot_Action_luVars["TestHWM"]=500
function HealBot_Action_FreeId(prefix)
      --HealBot_setCall("HealBot_Action_FreeId")
    if prefix == "hbTest_" then
        freeId=HealBot_ButtonSeq[1]
    else
        freeId=HealBot_ButtonSeq[0]
    end
    return freeId
end

function HealBot_Action_CreateNewButton(frame, buttonId, prefix)
      --HealBot_setCall("HealBot_Action_CreateNewButton")
    --HealBot_Action_luVars["CreatedButtons"]=HealBot_Action_luVars["CreatedButtons"]+1
    if prefix == "hbTest_" then
        HealBot_ButtonSeq[1]=HealBot_ButtonSeq[1]+1
    else
        HealBot_ButtonSeq[0]=HealBot_ButtonSeq[0]+1
    end
    local bName=prefix.."HealUnit"..buttonId
    local ghb=CreateFrame("Button", bName, grpFrame[frame], "HealBotButtonSecureTemplate") 
    HealBot_Buttons[buttonId]=ghb
    ghb.id=buttonId
    ghb.bName=bName
    ghb.isEmerg=false
    if prefix == "HealBot_" then
        prefix="HB_"
    end
    bName=prefix.."EmergUnit"..buttonId
    local ehb=CreateFrame("Button", bName, grpFrame[frame], "HealingButtonTemplateEmerg")
    HealBot_Emerg_Button[buttonId]=ehb
    ehb.id=buttonId
    ehb.bName=bName
    ehb.isEmerg=true
    local iBtns
    for x=1,12 do
        iBtns=CreateFrame("Frame", prefix.."ID"..buttonId.."Icon"..x, ghb, BackdropTemplateMixin and "BackdropTemplate")
        iBtns.id=buttonId
        iBtns.size=HealBot_Action_luVars["IconGlowSize"]
        iBtns:SetScript("OnEnter", function() HealBot_Action_BuffIcon_OnEnter(ghb, x) end)
        iBtns:SetScript("OnLeave", function() HealBot_Action_BuffIcon_OnLeave(ghb, x) end)
        iBtns:SetScript("OnMouseDown", function(self, button) HealBot_Options_BuffClick(ghb, x, button) end)
        iBtns:SetFrameLevel(0)
        if prefix~="hbTest_" then
            iBtns:SetBackdrop({edgeFile="Interface\\Buttons\\WHITE8X8",
                                              edgeSize=iBtns.size, 
                                              insets={ left=0, right=0, top=0, bottom=0}})
        end
        iBtns:SetBackdropBorderColor(0, 0, 0, 0)
        iBtns:EnableMouse(false)
        iBtns:EnableMouseMotion(true)
        iBtns:UnregisterAllEvents()
    end
    for x=51,60 do
        iBtns=CreateFrame("Frame", prefix.."ID"..buttonId.."Icon"..x, ghb, BackdropTemplateMixin and "BackdropTemplate")
        iBtns.id=buttonId
        iBtns.size=HealBot_Action_luVars["IconGlowSize"]
        iBtns:SetScript("OnEnter", function() HealBot_Action_DebuffIcon_OnEnter(ghb, x) end)
        iBtns:SetScript("OnLeave", function() HealBot_Action_DebuffIcon_OnLeave(ghb, x) end)
        iBtns:SetScript("OnMouseDown", function(self, button) HealBot_Options_DebuffClick(ghb, x, button) end)
        if prefix~="hbTest_" then
            iBtns:SetBackdrop({edgeFile="Interface\\Buttons\\WHITE8X8",
                                              edgeSize=iBtns.size, 
                                              insets={ left=0, right=0, top=0, bottom=0}})
        end
        iBtns:SetBackdropBorderColor(0, 0, 0, 0)
        iBtns:SetFrameLevel(0)
        iBtns:EnableMouse(false)
        iBtns:UnregisterAllEvents()
    end
    HealBot_Action_InitButton(ghb, prefix)
    if prefix~="hbTest_" then
        if buttonId>HealBot_Action_luVars["ButtonHWM"] then HealBot_Action_luVars["ButtonHWM"]=buttonId end
        ghb:HookScript("OnEnter", function(self) HealBot_Action_HealUnit_OnEnter(self) end);
        ghb:HookScript("OnLeave", function(self) HealBot_Action_HealUnit_OnLeave(self) end);
        ehb:HookScript("OnEnter", function(self) HealBot_Action_EmergUnit_OnEnter(self) end);
        ehb:HookScript("OnLeave", function(self) HealBot_Action_EmergUnit_OnLeave(self) end);
    else
        if buttonId>HealBot_Action_luVars["TestHWM"] then HealBot_Action_luVars["TestHWM"]=buttonId end
    end
    return ghb
end

function HealBot_Action_CreateButton(frame, prefix)
      --HealBot_setCall("HealBot_Action_CreateButton")
    local buttonId=HealBot_Action_FreeId(prefix)
    if (prefix == "hbTest_" and buttonId<998) or (prefix~="hbTest_" and buttonId<500) then 
        local ghb=_G[prefix.."HealUnit"..buttonId]
        if not ghb then
            ghb=HealBot_Action_CreateNewButton(frame, buttonId, prefix)
            if ghb then
                HealBot_Action_PrepButton(ghb)
            end
        end
        return ghb
    else
        return nil
    end
end

function HealBot_Action_ResetAllButtons(incGuid)
      --HealBot_setCall("HealBot_Action_ResetAllButtons")
    if HealBot_Action_luVars["ButtonHWM"]>0 then
        for i=1,HealBot_Action_luVars["ButtonHWM"] do
            if HealBot_Buttons[i] then
                HealBot_Buttons[i].reset=true
                if incGuid then HealBot_Buttons[i].guid="init" end
                if HealBot_Action_luVars["resetEvents"] then
                    HealBot_Buttons[i].status.events=false
                end
            end
        end
    end
    HealBot_Action_luVars["resetEvents"]=false
end

function HealBot_Action_ZeroHiddenButtons()
      --HealBot_setCall("HealBot_Action_ZeroHiddenButtons")
    if HealBot_Action_luVars["ButtonHWM"]>0 then
        for i=1,HealBot_Action_luVars["ButtonHWM"] do
            if HealBot_Buttons[i] and not HealBot_Buttons[i].status.active then
                HealBot_Buttons[i].frame=0
            end
        end
    end
end

function HealBot_Action_ResetEnemySkinAllButtons()
      --HealBot_setCall("HealBot_Action_ResetSkinAllButtons")
    if not HealBot_Action_luVars["TestBarsOn"] and HealBot_Action_luVars["ButtonHWM"]>0 then
        for i=1,HealBot_Action_luVars["ButtonHWM"] do
            if HealBot_Buttons[i] then
                HealBot_Buttons[i].enemyreset=true
            end
        end
    end
end

function HealBot_Action_ResetSkinButton(index)
      --HealBot_setCall("HealBot_Action_ResetSkinButton")
    if HealBot_Buttons[index] then
        if HealBot_Action_luVars["resetSkin"] then HealBot_Buttons[index].skinreset=true end
        if HealBot_Action_luVars["resetIcon"] then HealBot_Buttons[index].icon.reset=true end
        if HealBot_Action_luVars["resetIndicator"] then HealBot_Buttons[index].indreset=true end
        if HealBot_Action_luVars["resetText"] then HealBot_Buttons[index].text.reset=true end
        if HealBot_Action_luVars["resetAux"] then HealBot_Buttons[index].auxreset=true end
    end
end

function HealBot_Action_ResetSkinAllButtons()
      --HealBot_setCall("HealBot_Action_ResetSkinAllButtons")
    if HealBot_Action_luVars["TestBarsOn"] then
        if HealBot_Action_luVars["TestHWM"]>500 then
            for i=500,HealBot_Action_luVars["TestHWM"] do
                HealBot_Action_ResetSkinButton(i)
            end
        end
    elseif HealBot_Action_luVars["ButtonHWM"]>0 then
        for i=1,HealBot_Action_luVars["ButtonHWM"] do
            HealBot_Action_ResetSkinButton(i)
        end
    end
    HealBot_Panel_ResetHeaders()
    HealBot_setLuVars("ClearReset", true)
end

function HealBot_Action_ResetSkinTextAuxAllButtons()
    HealBot_Action_luVars["resetSkin"]=true
    HealBot_Action_luVars["resetText"]=true
    HealBot_Action_luVars["resetAux"]=true
    HealBot_Action_ResetSkinAllButtons()
end

function HealBot_Action_ClearReset()
    HealBot_Action_luVars["resetSkin"]=false
    HealBot_Action_luVars["resetIcon"]=false
    HealBot_Action_luVars["resetIndicator"]=false
    HealBot_Action_luVars["resetText"]=false
    HealBot_Action_luVars["resetAux"]=false
    HealBot_setLuVars("ClearReset", false)
end

function HealBot_Action_ResetTestButtons()
      --HealBot_setCall("HealBot_Action_ResetTestButtons")
    if HealBot_Action_luVars["TestHWM"]>500 then
        for i=500,HealBot_Action_luVars["TestHWM"] do
            if HealBot_Buttons[i] then 
                HealBot_Buttons[i].reset=true
            end
        end
    end
end

function HealBot_Action_ResetSkinAllElements()
      --HealBot_setCall("HealBot_Action_ResetSkinAllElements")
    HealBot_Action_luVars["resetSkin"]=true
    HealBot_Action_luVars["resetIcon"]=true
    HealBot_Action_luVars["resetIndicator"]=true
    HealBot_Action_luVars["resetText"]=true
    HealBot_Action_luVars["resetAux"]=true
    HealBot_Action_ResetTestButtons()
    HealBot_Action_ResetSkinAllButtons()
end

function HealBot_Action_SpellCmdCodes(cType, cText)
      --HealBot_setCall("HealBot_Action_SpellCmdCodes")
    local cID=nil
    if cType == "ENEMY" then
        if cText == HEALBOT_DISABLED_TARGET then
            cID="A"
        elseif cText == HEALBOT_WORD_FOCUS then
            cID="B"
        end
    elseif cType == "ICON" then
        if cText == HEALBOT_IGNOREAURAALL then
            cID="A"
        elseif cText == HEALBOT_ICONRAISEPRIO1 then
            cID="B"
        elseif cText == HEALBOT_ICONRAISEPRIO3 then
            cID="C"
        elseif cText == HEALBOT_ICONLOWERPRIO1 then
            cID="D"
        elseif cText == HEALBOT_ICONLOWERPRIO3 then
            cID="E"
        elseif cText == HEALBOT_ICONBARCOLOURON then
            cID="F"
        elseif cText == HEALBOT_ICONBARCOLOUROFF then
            cID="G"
        elseif cText == HEALBOT_ICONRAISESCALE then
            cID="H"
        elseif cText == HEALBOT_ICONLOWERSCALE then
            cID="I"
        elseif cText == HEALBOT_ICONBARCOLOURCYCLE then
            cID="J"
        elseif cText == HEALBOT_ICONNEXTSET then
            cID="K"
        elseif cText == HEALBOT_ICONPREVSET then
            cID="L"
        elseif cText == HEALBOT_ICONGLOWON then
            cID="M"
        elseif cText == HEALBOT_ICONGLOWOFF then
            cID="N"
        elseif cText == HEALBOT_ICONGLOWCYCLE then
            cID="O"
        end
    else
        if cText == HEALBOT_DISABLED_TARGET then
            cID="A"
        elseif cText == HEALBOT_ASSIST then
            cID="B"
        elseif cText == HEALBOT_WORD_FOCUS then
            cID="C"
        elseif cText == HEALBOT_MENU then
            cID="D"
        elseif cText == HEALBOT_HBMENU then
            cID="E"
        elseif cText == HEALBOT_STOP then
            cID="F"
        elseif HEALBOT_GAME_VERSION>2 and cText == HEALBOT_MOUNTS or cText == HEALBOT_MOUNTSPETS then
            cID="G"
        elseif HEALBOT_GAME_VERSION>2 and cText == HEALBOT_FAVMOUNT then
            cID="H"
        elseif HEALBOT_GAME_VERSION>3 and cText == HEALBOT_FAVPET then
            cID="I"
        elseif HEALBOT_GAME_VERSION>2 and cText == HEALBOT_RANDOMMOUNT then
            cID="J"
        elseif HEALBOT_GAME_VERSION>2 and cText == HEALBOT_RANDOMGOUNDMOUNT then
            cID="K"
        elseif cText == HEALBOT_CANCELPLUGINALERT then
            cID="L"
        elseif HEALBOT_GAME_VERSION>2 and cText == HEALBOT_TARGETVEHICLE then
            cID="M"
        elseif cText == HEALBOT_MOUSELOOK then
            cID="N"
        elseif cText == HEALBOT_TOGGLE_MYTARGETS then
            cID="O"
        elseif cText == HEALBOT_TOGGLE_PRIVTANKS then
            cID="P"
        elseif cText == HEALBOT_TOGGLE_PRIVHEALS then
            cID="Q"
        elseif cText == HEALBOT_TOGGLE_PRIVDPS then
            cID="R"
        elseif cText == HEALBOT_TOGGLE_PERMPRIVLISTS then
            cID="S"
        elseif cText == HEALBOT_TOGGLE_PERMPRIVTANKS then
            cID="T"
        elseif cText == HEALBOT_TOGGLE_PERMPRIVHEALS then
            cID="U"
        elseif cText == HEALBOT_TOGGLE_PERMPRIVDPS then
            cID="V"
        end
    end
    return cID
end

function HealBot_Action_SpellCmdText(cType, cID)
      --HealBot_setCall("HealBot_Action_SpellCmdText")
    local cText=nil
    if cType == "ENEMY" then
        if cID == "A" then
            cText=HEALBOT_DISABLED_TARGET
        elseif cID == "B" then
            cText=HEALBOT_WORD_FOCUS
        end
    elseif cType == "ICON" then
        if cID == "A" then
            cText=HEALBOT_IGNOREAURAALL
        elseif cID == "B" then
            cText=HEALBOT_ICONRAISEPRIO1
        elseif cID == "C" then
            cText=HEALBOT_ICONRAISEPRIO3
        elseif cID == "D" then
            cText=HEALBOT_ICONLOWERPRIO1
        elseif cID == "E" then
            cText=HEALBOT_ICONLOWERPRIO3
        elseif cID == "F" then
            cText=HEALBOT_ICONBARCOLOURON
        elseif cID == "G" then
            cText=HEALBOT_ICONBARCOLOUROFF
        elseif cID == "H" then
            cText=HEALBOT_ICONRAISESCALE
        elseif cID == "I" then
            cText=HEALBOT_ICONLOWERSCALE
        elseif cID == "J" then
            cText=HEALBOT_ICONBARCOLOURCYCLE
        elseif cID == "K" then
            cText=HEALBOT_ICONNEXTSET
        elseif cID == "L" then
            cText=HEALBOT_ICONPREVSET
        elseif cID == "M" then
            cText=HEALBOT_ICONGLOWON
        elseif cID == "N" then
            cText=HEALBOT_ICONGLOWOFF
        elseif cID == "O" then
            cText=HEALBOT_ICONGLOWCYCLE
        end
    else
        if cID == "A" then
            cText=HEALBOT_DISABLED_TARGET
        elseif cID == "B" then
            cText=HEALBOT_ASSIST
        elseif cID == "C" then
            cText=HEALBOT_WORD_FOCUS
        elseif cID == "D" then
            cText=HEALBOT_MENU
        elseif cID == "E" then
            cText=HEALBOT_HBMENU
        elseif cID == "F" then
            cText=HEALBOT_STOP
        elseif cID == "G" then
            if HEALBOT_GAME_VERSION>3 then
                cText=HEALBOT_MOUNTSPETS
            elseif HEALBOT_GAME_VERSION>2 then
                cText=HEALBOT_MOUNTS
            end
        elseif HEALBOT_GAME_VERSION>2 and cID == "H" then
            cText=HEALBOT_FAVMOUNT
        elseif HEALBOT_GAME_VERSION>3 and cID == "I" then
            cText=HEALBOT_FAVPET
        elseif HEALBOT_GAME_VERSION>2 and cID == "J" then
            cText=HEALBOT_RANDOMMOUNT
        elseif HEALBOT_GAME_VERSION>2 and cID == "K" then
            cText=HEALBOT_RANDOMGOUNDMOUNT
        elseif cID == "L" then
            cText=HEALBOT_CANCELPLUGINALERT
        elseif cID == "M" then
            cText=HEALBOT_TARGETVEHICLE
        elseif cID == "N" then
            cText=HEALBOT_MOUSELOOK
        elseif cID == "O" then
            cText=HEALBOT_TOGGLE_MYTARGETS
        elseif cID == "P" then
            cText=HEALBOT_TOGGLE_PRIVTANKS
        elseif cID == "Q" then
            cText=HEALBOT_TOGGLE_PRIVHEALS
        elseif cID == "R" then
            cText=HEALBOT_TOGGLE_PRIVDPS
        elseif cID == "S" then
            cText=HEALBOT_TOGGLE_PERMPRIVLISTS
        elseif cID == "T" then
            cText=HEALBOT_TOGGLE_PERMPRIVTANKS
        elseif cID == "U" then
            cText=HEALBOT_TOGGLE_PERMPRIVHEALS
        elseif cID == "V" then
            cText=HEALBOT_TOGGLE_PERMPRIVDPS
        end
    end
    return cText
end

function HealBot_Action_SetSpell(cType, cKey, sText)
      --HealBot_setCall("HealBot_Action_SetSpell")
    if sText then
        if HealBot_Text_Len(sText)>0 then
            local cID=HealBot_Action_SpellCmdCodes(cType, sText)
            if cID then 
                sText="C:"..cID 
            else
                local spellId=HealBot_Spells_KnownByName(sText)
                if spellId then
                    sText="S:"..spellId.."^"..sText
                else
                    local itemID=HealBot_WoWAPI_ItemInfoInstant(sText)
                    if itemID then 
                        sText="I:"..itemID 
                    else
                        local e,t=string.split("=", sText)
                        if e and e == HEALBOT_EMOTE and t then
                            sText="E:"..t
                        end
                    end
                end
            end
        else
            sText=nil
        end
    end
    if cType == "ENABLED" then
        HealBot_Config_Spells.EnabledKeyCombo[cKey]=sText
    elseif cType == "ENEMY" then
        HealBot_Config_Spells.EnemyKeyCombo[cKey]=sText
    elseif cType == "EMERG" then
        HealBot_Config_Spells.EmergKeyCombo[cKey]=sText
    else
        HealBot_Globals.IconKeyCombo[cKey]=sText
    end
    HealBot_Action_ClearSpellCache(cType, cKey)
end

function HealBot_Action_UpdateLoadoutId()
      --HealBot_setCall("HealBot_Action_UpdateLoadoutId")
    if HEALBOT_GAME_VERSION>9 then
        local spec=PlayerUtil.GetCurrentSpecID()
        local loadout=spec and C_ClassTalents.GetLastSelectedSavedConfigID(spec)
        local configId=false
        if loadout then
            local configInfo=C_Traits.GetConfigInfo(loadout)
            if configInfo then
                configId=configInfo.ID
            end
        end
        if not configId then
            configId=C_ClassTalents.GetActiveConfigID()
        end
        if configId and configId>0 then
            HealBot_Config.LastLoadout=configId
        else
            HealBot_Config.LastLoadout=GetSpecialization() or 0
        end
    else
        HealBot_Config.LastLoadout=0
    end
end

function HealBot_Action_RemoveInvalidActionIconLoadouts(t, key)
    local k,s,l=string.split(":",key)
    if l then
        s=tonumber(s)
        if s == HealBot_Config.CurrentSpec then
            l=tonumber(l)
            if l>9 and not C_Traits.GetConfigInfo(l) then
                t[key]=nil
            end
        end
    elseif s then
        s=tonumber(s)
        if t[k..":"..HealBot_Config.CurrentSpec..":"..s] or not C_Traits.GetConfigInfo(s) then
            t[key]=nil
        end
    else
        t[key]=nil
    end
end

function HealBot_Action_RemoveInvalidLoadouts()
    if HEALBOT_GAME_VERSION>9 then
        for x,_ in pairs(HealBot_Spell_Loadouts) do
            local s,l=string.split(":",x)
            if l then
                s=tonumber(s)
                if s == HealBot_Config.CurrentSpec then
                    l=tonumber(l)
                    if l>9 and not C_Traits.GetConfigInfo(l) then
                        HealBot_Spell_Loadouts[x]=nil
                    end
                end
            elseif s then
                s=tonumber(s)
                if HealBot_Spell_Loadouts[s] and (HealBot_Spell_Loadouts[HealBot_Config.CurrentSpec..":"..s] or not C_Traits.GetConfigInfo(s)) then
                    HealBot_Spell_Loadouts[s]=nil
                end
            end
        end
        for x,_ in pairs(HealBot_ActionIcons_Loadouts) do
            HealBot_Action_RemoveInvalidActionIconLoadouts(HealBot_ActionIcons_Loadouts, x)
        end
        for x,_ in pairs(HealBot_ActionIconsData_Loadouts) do
            HealBot_Action_RemoveInvalidActionIconLoadouts(HealBot_ActionIconsData_Loadouts, x)
        end
    end
end

function HealBot_Action_GetCombo(key, button)
      --HealBot_setCall("HealBot_Action_GetCombo", nil, nil, nil, true)
    sConcat[1]=key
    sConcat[2]=button
    return HealBot_Action_Concat(2)
end

function HealBot_Action_GetSpecID()
    if HEALBOT_GAME_VERSION>9 then
        sConcat[1]=HealBot_Config.CurrentSpec
        sConcat[2]=":"
        sConcat[3]=HealBot_Config.CurrentLoadout
        return HealBot_Action_Concat(3)
    else
        return HealBot_Config.CurrentSpec
    end
end

function HealBot_Action_GetSpecID_OLD()
    if HEALBOT_GAME_VERSION>9 then
        return HealBot_Config.CurrentLoadout
    else
        return HealBot_Config.CurrentSpec
    end
end

function HealBot_Action_GetSpecProf()
    sConcat[3]=HealBot_Action_GetSpecID()
    sConcat[1]=HealBot_Config.Profile
    sConcat[2]=":"
    return HealBot_Action_Concat(3)
end

function HealBot_Action_GetComboWithSpec_OLD(key, button, spec)
      --HealBot_setCall("HealBot_Action_GetComboWithSpec", nil, nil, nil, true)
    sConcat[1]=key
    sConcat[2]=button
    sConcat[3]=spec or 1
    sConcat[4]=HealBot_Config.LastLoadout
    return HealBot_Action_Concat(4)
end

function HealBot_Action_GetComboSpec_OLD(key, button)
      --HealBot_setCall("HealBot_Action_GetComboSpec", nil, nil, nil, true)
    return HealBot_Action_GetComboWithSpec_OLD(key, button, HealBot_Config.CurrentSpec)
end

function HealBot_Action_GetActionIconSpecWithSkin(skinname)
      --HealBot_setCall("HealBot_Action_GetActionIconSpecWithSkin")
    sConcat[3]=HealBot_Action_GetSpecID()
    sConcat[1]=skinname
    sConcat[2]=":"
    return HealBot_Action_Concat(3)
end

function HealBot_Action_GetActionIconSpec()
      --HealBot_setCall("HealBot_Action_GetActionIconSpec")
    return HealBot_Action_GetActionIconSpecWithSkin(Healbot_Config_Skins.Current_Skin)
end

local HealBot_Action_SpellCache={["ENABLED"]={},["ENEMY"]={},["EMERG"]={},["ICON"]={}}
HealBot_Action_SpellCache["ENABLED"]={["NAME"]={},["ICON"]={},["TYPE"]={},["ID"]={}}
HealBot_Action_SpellCache["ENEMY"]={["NAME"]={},["ICON"]={},["TYPE"]={},["ID"]={}}
HealBot_Action_SpellCache["EMERG"]={["NAME"]={},["ICON"]={},["TYPE"]={},["ID"]={}}
HealBot_Action_SpellCache["ICON"]={["NAME"]={},["ICON"]={},["TYPE"]={},["ID"]={}}

function HealBot_Action_ClearSpellCache(cType, cKey)
      --HealBot_setCall("HealBot_Action_ClearSpellCache")
    if cType then
        if cKey then
            HealBot_Action_SpellCache[cType]["NAME"][cKey]=nil
            HealBot_Action_SpellCache[cType]["ICON"][cKey]=nil
            HealBot_Action_SpellCache[cType]["TYPE"][cKey]=nil
            HealBot_Action_SpellCache[cType]["ID"][cKey]=nil
        else
            HealBot_Action_SpellCache[cType]={["NAME"]={},["ICON"]={},["TYPE"]={},["ID"]={}}
        end
    else
        HealBot_Action_SpellCache["ENABLED"]={["NAME"]={},["ICON"]={},["TYPE"]={},["ID"]={}}
        HealBot_Action_SpellCache["ENEMY"]={["NAME"]={},["ICON"]={},["TYPE"]={},["ID"]={}}
        HealBot_Action_SpellCache["EMERG"]={["NAME"]={},["ICON"]={},["TYPE"]={},["ID"]={}}
        HealBot_Action_SpellCache["ICON"]={["NAME"]={},["ICON"]={},["TYPE"]={},["ID"]={}}
    end
end

local vSpellText,cSpellText,vSpellIcon,vSpellType,vSpellID=nil,nil,nil
function HealBot_Action_GetSpell(cType, cKey)
      --HealBot_setCall("HealBot_Action_GetSpell", nil, nil, nil, true)
    vSpellText=HealBot_Action_SpellCache[cType]["NAME"][cKey]
    vSpellIcon=HealBot_Action_SpellCache[cType]["ICON"][cKey]
    vSpellType=HealBot_Action_SpellCache[cType]["TYPE"][cKey]
    vSpellID=HealBot_Action_SpellCache[cType]["ID"][cKey]
    if not vSpellText then
        if cType == "ENABLED" then
            vSpellText=HealBot_Config_Spells.EnabledKeyCombo[cKey]
        elseif cType == "ENEMY" then
            vSpellText=HealBot_Config_Spells.EnemyKeyCombo[cKey]
        elseif cType == "EMERG" then
            vSpellText=HealBot_Config_Spells.EmergKeyCombo[cKey]
        else
            vSpellText=HealBot_Globals.IconKeyCombo[cKey]
        end
        if vSpellText and HealBot_Text_Len(vSpellText)>2 then
            local sName
            local sType,sID=string.split(":", vSpellText)
            if sID then sID,sName=string.split("^", sID) end
            if sType and not sID and HealBot_Spells_KnownByName(sType) then
                sID=HealBot_Spells_KnownByName(sType)
            end
            if sType and sID then
                if sType == "C" then
                    vSpellText=HealBot_Action_SpellCmdText(cType, sID)
                    vSpellIcon=[[Interface\Addons\HealBot\Images\options\icon_command]]
                    vSpellType="command"
                elseif sType == "E" then
                    vSpellText=HEALBOT_EMOTE.."="..sID
                    vSpellIcon=[[Interface\Addons\HealBot\Images\options\icon_emote]]
                    vSpellType="emote"
                elseif sType == "I" then
                    sID=tonumber(sID)
                    vSpellText=HealBot_WoWAPI_ItemInfo(sID)
                    _, _, _, _, vSpellIcon, _, _=HealBot_WoWAPI_ItemInfoInstant(sID) 
                    vSpellType="item"
                    vSpellID=sID
                else
                    if HEALBOT_GAME_VERSION == 4 then
                        if vSpellText == HEALBOT_SPELL_HOLYWORDSERENITY then 
                            sID=HBC_HOLY_WORD_SERENITY 
                        elseif vSpellText == HEALBOT_SPELL_HOLYWORDSANCTUARY then 
                            sID=HEALBOT_HOLY_WORD_SANCTUARY 
                        end
                    end
                    sID=tonumber(sID)
                    cSpellText=HealBot_Spells_KnownByID(sID)
                    vSpellIcon=HealBot_WoWAPI_SpellTexture(sID)
                    vSpellText=cSpellText or vSpellText
                    vSpellType="spell"
                    vSpellID=sID
                    if HEALBOT_GAME_VERSION == 1 and string.find(vSpellText," Rune Ability") then
                        vSpellText=sName
                    end
                end
            elseif GetMacroIndexByName(vSpellText)>0 then
                vSpellType="macro"
                vSpellID=GetMacroIndexByName(vSpellText)
                _, vSpellIcon=GetMacroInfo(vSpellText)
            end
            if vSpellText and vSpellIcon then 
                HealBot_Action_SpellCache[cType]["NAME"][cKey]=vSpellText
                HealBot_Action_SpellCache[cType]["ICON"][cKey]=vSpellIcon
                HealBot_Action_SpellCache[cType]["TYPE"][cKey]=vSpellType
                HealBot_Action_SpellCache[cType]["ID"][cKey]=vSpellID
            end
        end
    end
    return vSpellText, 
           vSpellIcon,
           vSpellType,
           vSpellID
end

local hbModKeys=false
function HealBot_Action_SetCurrentModKeys()
      --HealBot_setCall("HealBot_Action_SetCurrentModKeys")
    hbModKeys=false
    if IsAltKeyDown() then 
        hbModKeys="Alt" 
    end
    if IsControlKeyDown() then
        if hbModKeys then
            hbModKeys=hbModKeys.."-Ctrl"
        else
            hbModKeys="Ctrl"
        end
    end
    if IsShiftKeyDown() then
        if hbModKeys then
            hbModKeys=hbModKeys.."-Shift"
        else
            hbModKeys="Shift"
        end
    end
    HealBot_Action_luVars["CurrentModKey"]=hbModKeys or ""
    HealBot_Range_setLuVars("CurrentModKey", HealBot_Action_luVars["CurrentModKey"])
end

function HealBot_Action_SpellPattern(click, cType)
      --HealBot_setCall("HealBot_Action_SpellPattern")
    return HealBot_Action_GetSpell(cType, HealBot_Action_GetCombo(HealBot_Action_luVars["CurrentModKey"], click))
end

function HealBot_Action_IconSpellPattern(click)
      --HealBot_setCall("HealBot_Action_IconSpellPattern")
    return HealBot_Action_GetSpell("ICON", HealBot_Action_GetCombo(HealBot_Action_luVars["CurrentModKey"], click))
end

local vAttribSpellName=""
function HealBot_Action_AttribSpellPattern(HB_combo_prefix)
      --HealBot_setCall("HealBot_Action_AttribSpellPattern")
    vAttribSpellName=HealBot_Action_GetSpell("ENABLED", HB_combo_prefix)
    if vAttribSpellName then
        return vAttribSpellName, 
               HealBot_Config_Spells.EnabledSpellTarget[HB_combo_prefix], 
               HealBot_Config_Spells.EnabledSpellTrinket1[HB_combo_prefix], 
               HealBot_Config_Spells.EnabledSpellTrinket2[HB_combo_prefix], 
               HealBot_Config_Spells.EnabledAvoidBlueCursor[HB_combo_prefix]
    else
        return false, false, false, false, false 
    end
end

function HealBot_Action_AttribEnemySpellPattern(HB_combo_prefix)
      --HealBot_setCall("HealBot_Action_AttribEnemySpellPattern")
    vAttribSpellName=HealBot_Action_GetSpell("ENEMY", HB_combo_prefix)
    if vAttribSpellName then
        return vAttribSpellName, 
               HealBot_Config_Spells.EnemySpellTarget[HB_combo_prefix], 
               HealBot_Config_Spells.EnemySpellTrinket1[HB_combo_prefix], 
               HealBot_Config_Spells.EnemySpellTrinket2[HB_combo_prefix], 
               HealBot_Config_Spells.EnemyAvoidBlueCursor[HB_combo_prefix]
    else
        return false, false, false, false, false 
    end
end

function HealBot_Action_AttribEmergSpellPattern(HB_combo_prefix)
      --HealBot_setCall("HealBot_Action_AttribEmergSpellPattern")
    vAttribSpellName=HealBot_Action_GetSpell("EMERG", HB_combo_prefix)
    if vAttribSpellName then
        return vAttribSpellName, 
               HealBot_Config_Spells.EmergSpellTarget[HB_combo_prefix], 
               HealBot_Config_Spells.EmergSpellTrinket1[HB_combo_prefix], 
               HealBot_Config_Spells.EmergSpellTrinket2[HB_combo_prefix], 
               HealBot_Config_Spells.EmergAvoidBlueCursor[HB_combo_prefix]
    else
        return false, false, false, false, false 
    end
end

function HealBot_Action_AttribIconSpellPattern(HB_combo_prefix)
      --HealBot_setCall("HealBot_Action_AttribIconSpellPattern")
    vAttribSpellName=HealBot_Action_GetSpell("ICON", HB_combo_prefix)
    if vAttribSpellName then
        return vAttribSpellName, false, false, false, false
    else
        return false, false, false, false, false
    end
end

local hbCustomName={}
local HealBot_customTempUserName={}
function HealBot_Action_CustomName(cName)
      --HealBot_setCall("HealBot_Action_CustomName")
    local xGUID=hbCustomName["GUID"]
    local isAdd=hbCustomName["isAdd"]
    local isPerm=hbCustomName["isPerm"]
    if isAdd then
        if isPerm then
            HealBot_Globals.PermUserName[xGUID]=cName
        end
        HealBot_customTempUserName[xGUID]=cName
        HealBot_SetUnitName(cName, xGUID)
    else
        if isPerm then
            HealBot_Globals.PermUserName[xGUID]=nil
        else
            HealBot_customTempUserName[xGUID]=nil
        end
        HealBot_DelUnitName(xGUID)
    end
end

function HealBot_Action_GetCustomNameDialog(guid, isAdd, isPerm)
      --HealBot_setCall("HealBot_Action_GetCustomNameDialog", nil, guid)
    local dText=HEALBOT_WORDS_ADDTEMPCUSTOMNAME
    local cName=nil
    hbCustomName["GUID"]=guid
    hbCustomName["isAdd"]=isAdd
    hbCustomName["isPerm"]=isPerm
    if isPerm then dText=HEALBOT_WORDS_ADDPERMCUSTOMNAME end
    StaticPopupDialogs["HEALBOT_WORDS_CUSTOMNAME"]={
        text=dText,
        button1=HEALBOT_WORDS_CUSTOMNAME,
        button2=HEALBOT_WORD_CANCEL,
        hasEditBox=1,
        whileDead=1,
        hideOnEscape=1,
        timeout=0,
        OnShow=function(self)
            getglobal(self:GetName().."EditBox"):SetText("");
        end,
        OnAccept=function(self)
              cName=getglobal(self:GetName().."EditBox"):GetText();
              HealBot_Action_CustomName(cName)
        end,
    };
    StaticPopup_Show("HEALBOT_WORDS_CUSTOMNAME");
end

function HealBot_Action_DelCustomName(guid, isAdd, isPerm)
      --HealBot_setCall("HealBot_Action_DelCustomName", nil, guid)
    hbCustomName["GUID"]=guid
    hbCustomName["isAdd"]=isAdd
    hbCustomName["isPerm"]=isPerm
    HealBot_Action_CustomName()
end

function HealBot_Action_hbmountmenuFrame_DropDown_Initialize()
      --HealBot_setCall("HealBot_Action_hbmountmenuFrame_DropDown_Initialize")
    local info
    info=UIDropDownMenu_CreateInfo();
    info.isTitle=true
    info.notCheckable=true
    if HEALBOT_GAME_VERSION>3 then
        info.text=HEALBOT_MOUNTSPETS
    else
        info.text=HEALBOT_MOUNTS
    end
    UIDropDownMenu_AddButton(info);
    wipe(info)
    info.disabled=true
    info.notCheckable=true
    UIDropDownMenu_AddButton(info)
    info.disabled=false
    info.notCheckable=true
    if HEALBOT_GAME_VERSION>2 then
        if HEALBOT_GAME_VERSION>3 then
            info.text=HEALBOT_RANDOMFAVMOUNT;
        else
            info.text=HEALBOT_FAVMOUNT;
        end
        info.func=function() HealBot_MountsPets_FavMount() end
        UIDropDownMenu_AddButton(info);

        info.text=HEALBOT_RANDOMMOUNT;
        info.func=function() HealBot_MountsPets_ToggelMount("all") end
        UIDropDownMenu_AddButton(info);
        info.text=HEALBOT_RANDOMGOUNDMOUNT;
        info.func=function() HealBot_MountsPets_ToggelMount("ground") end
        UIDropDownMenu_AddButton(info);
    end
    info.text=HEALBOT_CMD_DISMOUNT;
    info.func=function() HealBot_MountsPets_Dismount() end
    UIDropDownMenu_AddButton(info);
    if HEALBOT_GAME_VERSION>3 then
        wipe(info)
        info.disabled=true
        info.notCheckable=true
        UIDropDownMenu_AddButton(info)
        info.disabled=false
        info.notCheckable=true
        info.text=HEALBOT_RANDOMFAVPET;
        info.func=function() HealBot_MountsPets_RandomPet(true) end
        UIDropDownMenu_AddButton(info);
        info.text=HEALBOT_RANDOMPET;
        info.func=function() HealBot_MountsPets_RandomPet(false) end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Action_hbmenuFrame_DropDown_Initialize(self,level,menuList)
      --HealBot_setCall("HealBot_Action_hbmenuFrame_DropDown_Initialize", self)
    local info
    level=level or 1;
    if level == 1 then
        info=UIDropDownMenu_CreateInfo();
        info.isTitle=true
        info.notCheckable=true
        info.text=self.name
        UIDropDownMenu_AddButton(info, 1);
        
        wipe(info)
        info.disabled=true
        info.notCheckable=true
        UIDropDownMenu_AddButton(info)
        info.disabled=false
        
        info=UIDropDownMenu_CreateInfo();
        info.hasArrow=false; 
        info.notCheckable=true;
        if HealBot_AlwaysEnabled[UnitGUID(self.unit)] then
            info.text=HEALBOT_SKIN_DISTEXT;
        else
            info.text=HEALBOT_SKIN_ENTEXT;
        end
        info.func=function() HealBot_Action_Toggle_Enabled(self.unit); end
        UIDropDownMenu_AddButton(info, 1);
        
        info=UIDropDownMenu_CreateInfo();
        info.hasArrow=false; 
        info.notCheckable=true;
        if HealBot_Config.PrivFocus == UnitGUID(self.unit) then
            info.text=HEALBOT_WORDS_UNSET.." "..HEALBOT_OPTIONS_PRIVFOCUS
        else
            info.text=HEALBOT_WORD_SET.." "..HEALBOT_OPTIONS_PRIVFOCUS
        end
        info.func=function() HealBot_Panel_ToggelPrivFocus(self.unit); end;
        UIDropDownMenu_AddButton(info, 1);

        if UnitIsPlayer(self.unit) then
            info=UIDropDownMenu_CreateInfo();
            info.notCheckable=true;
            info.text=HEALBOT_WORDS_CUSTOMNAME
            info.hasArrow=true; 
            info.menuList="cNames"
            UIDropDownMenu_AddButton(info, 1);

            wipe(info)
            info.disabled=true
            info.notCheckable=true
            UIDropDownMenu_AddButton(info)
            info.disabled=false
            
            info=UIDropDownMenu_CreateInfo();
            info.notCheckable=true;
            info.text=HEALBOT_OPTIONS_MYTARGET
            info.hasArrow=true; 
            info.menuList="myHeals"
            UIDropDownMenu_AddButton(info, 1);
            
            info=UIDropDownMenu_CreateInfo();
            info.notCheckable=true;
            info.text=HEALBOT_OPTIONS_PRIVATETANKS
            info.hasArrow=true; 
            info.menuList="pTanks"
            UIDropDownMenu_AddButton(info, 1);
            
            info=UIDropDownMenu_CreateInfo();
            info.notCheckable=true;
            info.text=HEALBOT_OPTIONS_PRIVATEHEALERS
            info.hasArrow=true; 
            info.menuList="pHeals"
            UIDropDownMenu_AddButton(info, 1);
            
            info=UIDropDownMenu_CreateInfo();
            info.notCheckable=true;
            info.text=HEALBOT_OPTIONS_PRIVATEDAMAGERS
            info.hasArrow=true; 
            info.menuList="pDPS"
            UIDropDownMenu_AddButton(info, 1);
        else
            info=UIDropDownMenu_CreateInfo();
            info.hasArrow=false; 
            info.notCheckable=true;
            if HealBot_customTempUserName[UnitGUID(self.unit)] then
                info.text=HEALBOT_WORDS_REMOVETEMPCUSTOMNAME
                info.func=function() HealBot_Action_DelCustomName(UnitGUID(self.unit), false, false); end;
            else
                info.text=HEALBOT_WORDS_ADDTEMPCUSTOMNAME
                info.func=function() HealBot_Action_GetCustomNameDialog(UnitGUID(self.unit), true, false); end;
            end
            UIDropDownMenu_AddButton(info, 1);

            wipe(info)
            info.disabled=true
            info.notCheckable=true
            UIDropDownMenu_AddButton(info)
            info.disabled=false
            
            info=UIDropDownMenu_CreateInfo();
            info.hasArrow=false; 
            info.notCheckable=true;
            if HealBot_Panel_RetMyHealTarget(self.unit, false) then
                info.text=HEALBOT_WORDS_REMOVEFROM.." "..HEALBOT_OPTIONS_MYTARGET;
            else
                info.text=HEALBOT_WORDS_ADDTO.." "..HEALBOT_OPTIONS_MYTARGET
            end
            info.func=function() HealBot_Panel_ToggelHealTarget(self.unit, false); end;
            UIDropDownMenu_AddButton(info, 1);

            info=UIDropDownMenu_CreateInfo();
            info.hasArrow=false; 
            info.notCheckable=true;
            if HealBot_Panel_RetPrivateTanks(self.unit, false) then
                info.text=HEALBOT_WORDS_REMOVEFROM.." "..HEALBOT_OPTIONS_PRIVATETANKS;
            else
                info.text=HEALBOT_WORDS_ADDTO.." "..HEALBOT_OPTIONS_PRIVATETANKS
            end
            info.func=function() HealBot_Panel_ToggelPrivateTanks(self.unit, false); end;
            UIDropDownMenu_AddButton(info, 1);

            info=UIDropDownMenu_CreateInfo();
            info.hasArrow=false; 
            info.notCheckable=true;
            if HealBot_Panel_RetPrivateHealers(self.unit, false) then
                info.text=HEALBOT_WORDS_REMOVEFROM.." "..HEALBOT_OPTIONS_PRIVATEHEALERS;
            else
                info.text=HEALBOT_WORDS_ADDTO.." "..HEALBOT_OPTIONS_PRIVATEHEALERS
            end
            info.func=function() HealBot_Panel_ToggelPrivateHealers(self.unit, false); end;
            UIDropDownMenu_AddButton(info, 1);

            info=UIDropDownMenu_CreateInfo();
            info.hasArrow=false; 
            info.notCheckable=true;
            if HealBot_Panel_RetPrivateDamagers(self.unit, false) then
                info.text=HEALBOT_WORDS_REMOVEFROM.." "..HEALBOT_OPTIONS_PRIVATEDAMAGERS;
            else
                info.text=HEALBOT_WORDS_ADDTO.." "..HEALBOT_OPTIONS_PRIVATEDAMAGERS
            end
            info.func=function() HealBot_Panel_ToggelPrivateDamagers(self.unit, false); end;
            UIDropDownMenu_AddButton(info, 1);
        end

        wipe(info)
        info.disabled=true
        info.notCheckable=true
        UIDropDownMenu_AddButton(info)
        info.disabled=false
        
        if HEALBOT_GAME_VERSION>1 then 
            info=UIDropDownMenu_CreateInfo();
            info.notCheckable=true;
            if HealBot_retHbFocus(self.unit) then
                info.text=HEALBOT_WORD_CLEAR.." "..HEALBOT_WORD_HBFOCUS;
                info.hasArrow=false;
                info.func=function() HealBot_ToggelFocusMonitor(self.unit); end;
            else
                info.text=HEALBOT_WORD_SET.." "..HEALBOT_WORD_HBFOCUS
                info.hasArrow=true; 
                info.menuList="hbFocus"
            end
            UIDropDownMenu_AddButton(info, 1);
        end
        
        info=UIDropDownMenu_CreateInfo();
        info.hasArrow=false; 
        info.notCheckable=true;
        info.text=HEALBOT_WORD_RESET
        info.func=function() HealBot_Reset_Unit(self.unit); end
        UIDropDownMenu_AddButton(info, 1);
        
        info=UIDropDownMenu_CreateInfo();
        info.hasArrow=false; 
        info.notCheckable=true;
        info.text=HEALBOT_PANEL_BLACKLIST
        info.func=function() HealBot_Panel_AddBlackList(self.unit); end
        UIDropDownMenu_AddButton(info, 1);
        
        info=UIDropDownMenu_CreateInfo();
        info.hasArrow=false; 
        info.notCheckable=true;
        info.text=HEALBOT_WORD_CANCEL
        UIDropDownMenu_AddButton(info, 1);
    elseif menuList == "cNames" then
        info=UIDropDownMenu_CreateInfo();
        info.hasArrow=false; 
        info.notCheckable=true;
        if HealBot_Globals.PermUserName[UnitGUID(self.unit)] then
            info.text=HEALBOT_WORDS_REMOVEPERMCUSTOMNAME
            info.func=function() HealBot_Action_DelCustomName(UnitGUID(self.unit), false, true); end;
        else
            info.text=HEALBOT_WORDS_ADDPERMCUSTOMNAME
            info.func=function() HealBot_Action_GetCustomNameDialog(UnitGUID(self.unit), true, true); end;
        end
        UIDropDownMenu_AddButton(info, 2);
    
        info=UIDropDownMenu_CreateInfo();
        info.hasArrow=false; 
        info.notCheckable=true;
        if HealBot_customTempUserName[UnitGUID(self.unit)] then
            info.text=HEALBOT_WORDS_REMOVETEMPCUSTOMNAME
            info.func=function() HealBot_Action_DelCustomName(UnitGUID(self.unit), false, false); end;
        else
            info.text=HEALBOT_WORDS_ADDTEMPCUSTOMNAME
            info.func=function() HealBot_Action_GetCustomNameDialog(UnitGUID(self.unit), true, false); end;
        end
        UIDropDownMenu_AddButton(info, 2);
    elseif menuList == "myHeals" then        
        info=UIDropDownMenu_CreateInfo();
        info.hasArrow=false; 
        info.notCheckable=true;
        if HealBot_Panel_RetMyHealTarget(self.unit, false) then
            info.text=HEALBOT_WORDS_REMOVEFROM.." "..HEALBOT_OPTIONS_MYTARGET;
        else
            info.text=HEALBOT_WORDS_ADDTO.." "..HEALBOT_OPTIONS_MYTARGET
        end
        info.func=function() HealBot_Panel_ToggelHealTarget(self.unit, false); end;
        UIDropDownMenu_AddButton(info, 2);
           
        info=UIDropDownMenu_CreateInfo();
        info.hasArrow=false; 
        info.notCheckable=true;
        if HealBot_Panel_RetMyHealTarget(self.unit, true) then
            info.text=HEALBOT_WORDS_REMOVEFROM.." "..HEALBOT_WORD_PERMANENT.." "..HEALBOT_OPTIONS_MYTARGET;
        else
            info.text=HEALBOT_WORDS_ADDTO.." "..HEALBOT_WORD_PERMANENT.." "..HEALBOT_OPTIONS_MYTARGET
        end
        info.func=function() HealBot_Panel_ToggelHealTarget(self.unit, true); end;
        UIDropDownMenu_AddButton(info, 2);
    elseif menuList == "pTanks" then
        info=UIDropDownMenu_CreateInfo();
        info.hasArrow=false; 
        info.notCheckable=true;
        if HealBot_Panel_RetPrivateTanks(self.unit, false) then
            info.text=HEALBOT_WORDS_REMOVEFROM.." "..HEALBOT_OPTIONS_PRIVATETANKS;
        else
            info.text=HEALBOT_WORDS_ADDTO.." "..HEALBOT_OPTIONS_PRIVATETANKS
        end
        info.func=function() HealBot_Panel_ToggelPrivateTanks(self.unit, false); end;
        UIDropDownMenu_AddButton(info, 2);
        
        info=UIDropDownMenu_CreateInfo();
        info.hasArrow=false; 
        info.notCheckable=true;
        if HealBot_Panel_RetPrivateTanks(self.unit, true) then
            info.text=HEALBOT_WORDS_REMOVEFROM.." "..HEALBOT_WORD_PERMANENT.." "..HEALBOT_OPTIONS_PRIVATETANKS;
        else
            info.text=HEALBOT_WORDS_ADDTO.." "..HEALBOT_WORD_PERMANENT.." "..HEALBOT_OPTIONS_PRIVATETANKS
        end
        info.func=function() HealBot_Panel_ToggelPrivateTanks(self.unit, true); end;
        UIDropDownMenu_AddButton(info, 2);
    elseif menuList == "pHeals" then
        info=UIDropDownMenu_CreateInfo();
        info.hasArrow=false; 
        info.notCheckable=true;
        if HealBot_Panel_RetPrivateHealers(self.unit, false) then
            info.text=HEALBOT_WORDS_REMOVEFROM.." "..HEALBOT_OPTIONS_PRIVATEHEALERS;
        else
            info.text=HEALBOT_WORDS_ADDTO.." "..HEALBOT_OPTIONS_PRIVATEHEALERS
        end
        info.func=function() HealBot_Panel_ToggelPrivateHealers(self.unit, false); end;
        UIDropDownMenu_AddButton(info, 2);
        
        info=UIDropDownMenu_CreateInfo();
        info.hasArrow=false; 
        info.notCheckable=true;
        if HealBot_Panel_RetPrivateHealers(self.unit, true) then
            info.text=HEALBOT_WORDS_REMOVEFROM.." "..HEALBOT_WORD_PERMANENT.." "..HEALBOT_OPTIONS_PRIVATEHEALERS;
        else
            info.text=HEALBOT_WORDS_ADDTO.." "..HEALBOT_WORD_PERMANENT.." "..HEALBOT_OPTIONS_PRIVATEHEALERS
        end
        info.func=function() HealBot_Panel_ToggelPrivateHealers(self.unit, true); end;
        UIDropDownMenu_AddButton(info, 2);
    elseif menuList == "pDPS" then
        info=UIDropDownMenu_CreateInfo();
        info.hasArrow=false; 
        info.notCheckable=true;
        if HealBot_Panel_RetPrivateDamagers(self.unit, false) then
            info.text=HEALBOT_WORDS_REMOVEFROM.." "..HEALBOT_OPTIONS_PRIVATEDAMAGERS;
        else
            info.text=HEALBOT_WORDS_ADDTO.." "..HEALBOT_OPTIONS_PRIVATEDAMAGERS
        end
        info.func=function() HealBot_Panel_ToggelPrivateDamagers(self.unit, false); end;
        UIDropDownMenu_AddButton(info, 2);
        
        info=UIDropDownMenu_CreateInfo();
        info.hasArrow=false; 
        info.notCheckable=true;
        if HealBot_Panel_RetPrivateDamagers(self.unit, true) then
            info.text=HEALBOT_WORDS_REMOVEFROM.." "..HEALBOT_WORD_PERMANENT.." "..HEALBOT_OPTIONS_PRIVATEDAMAGERS;
        else
            info.text=HEALBOT_WORDS_ADDTO.." "..HEALBOT_WORD_PERMANENT.." "..HEALBOT_OPTIONS_PRIVATEDAMAGERS
        end
        info.func=function() HealBot_Panel_ToggelPrivateDamagers(self.unit, true); end;
        UIDropDownMenu_AddButton(info, 2);
    elseif menuList == "hbFocus" and HEALBOT_GAME_VERSION>1 then
        info=UIDropDownMenu_CreateInfo();
        info.text=HEALBOT_WORD_ALLZONE
        info.hasArrow=false; 
        info.notCheckable=true;
        info.func=function() HealBot_ToggelFocusMonitor(self.unit, "all"); end;
        UIDropDownMenu_AddButton(info, 2);
        
        info=UIDropDownMenu_CreateInfo();
        local _,z=IsInInstance()
        if z == "pvp" or z == "arena" then 
            info.text=HEALBOT_WORD_BATTLEGROUND
        elseif z~="none" then
            info.text=GetRealZoneText()
        else
            info.text=HEALBOT_WORD_OUTSIDE
        end
        info.hasArrow=false; 
        info.notCheckable=true;
        info.func=function() HealBot_ToggelFocusMonitor(self.unit, z); end;
        UIDropDownMenu_AddButton(info, 2);
    end
end

function HealBot_Action_AlterSpell2Macro(spellName, spellTar, spellTrin1, spellTrin2, spellAvoidBC, unit, cType)
      --HealBot_setCall("HealBot_Action_AlterSpell2Macro", nil, nil, unit)
    local hbMacroText=""
    if spellTrin1 or spellTrin2 then
        if HealBot_Globals.MacroSuppressError then hbMacroText=hbMacroText..'/hb se3\n' end
        if HealBot_Globals.MacroSuppressSound then hbMacroText=hbMacroText..'/hb se1\n' end
    end
    if spellTar and unit~="target" then hbMacroText=hbMacroText.."/target "..unit.."\n" end
    if spellTrin1 then hbMacroText=hbMacroText.."/use 13\n" end
    if spellTrin2 then hbMacroText=hbMacroText.."/use 14\n" end
    if HealBot_Config.MacroUse10 then hbMacroText=hbMacroText.."/use 10\n" end
    if spellTrin1 or spellTrin2 then
        if HealBot_Globals.MacroSuppressSound then hbMacroText=hbMacroText.."/hb se2\n" end
        if HealBot_Globals.MacroSuppressError then hbMacroText=hbMacroText..'/hb se4\n' end
    end
    if cType == "Enemy" then
        hbMacroText=hbMacroText.."/cast [@"..unit..",harm] "..spellName.."\n"
    else
        hbMacroText=hbMacroText.."/cast [@"..unit..",help] "..spellName.."\n"
    end
    if spellAvoidBC then hbMacroText=hbMacroText.."/stopspelltarget\n" end
    if spellTar and unit~="target" and HealBot_Config_Spells.SpellTargetLastTarget[cType] then hbMacroText=hbMacroText.."/targetlasttarget\n" end
    return hbMacroText
end

function HealBot_Action_UnitID(unit)
      --HealBot_setCall("HealBot_Action_UnitID", nil, nil, unit)
    if strsub(unit,1,4) == "raid" then
        if UnitIsUnit(unit,"party1") then
            unit="party1"
        elseif UnitIsUnit(unit,"party2") then
            unit="party2"
        elseif UnitIsUnit(unit,"party3") then
            unit="party3"
        elseif UnitIsUnit(unit,"party4") then
            unit="party4"
        end
    end
    return unit
end


local tAttribConcat={}
local hbAttribsMinResetElement=""

function HealBot_Action_ReturnAttribsFramesMinReset(button, prefix, cType, bno)
      --HealBot_setCall("HealBot_Action_ReturnAttribsFramesMinReset", button, nil, nil, true)
    tAttribConcat[1]=prefix
    tAttribConcat[2]=bno
    hbAttribsMinResetElement=tabconcat(tAttribConcat,"",1,2)
    return button.attribs[cType][hbAttribsMinResetElement]
end

function HealBot_Action_UpdateAttribsMinReset(button, prefix, cType, bno, value)
      --HealBot_setCall("HealBot_Action_UpdateAttribsMinReset", button, nil, nil, true)
    tAttribConcat[1]=prefix
    tAttribConcat[2]=bno
    hbAttribsMinResetElement=tabconcat(tAttribConcat,"",1,2)
    button.attribs[cType][hbAttribsMinResetElement]=value
end

function HealBot_Action_DoSetButtonAttrib(button,cType,j,unit,HB_prefix,buttonType,sName,sTar,sTrin1,sTrin2,AvoidBC,sType)
      --HealBot_setCall("HealBot_Action_DoSetButtonAttrib", button, nil, nil, true)
    if sName and type(sName) == "string" then
        if HEALBOT_GAME_VERSION == 4 and (sName == HEALBOT_SPELL_HOLYWORDSERENITY or sName == HEALBOT_SPELL_HOLYWORDSANCTUARY) then sName=HEALBOT_SPELL_HOLYWORDCHASTISE end
        local mId=GetMacroIndexByName(sName)
        if strlower(sName) == strlower(HEALBOT_DISABLED_TARGET) then
            button:SetAttribute(HB_prefix..buttonType..j, "target"..j);
            button:SetAttribute(HB_prefix.."type"..j, "target")
            button:SetAttribute(HB_prefix.."type-target"..j, "target")
        elseif HEALBOT_GAME_VERSION>2 and strlower(sName) == strlower(HEALBOT_TARGETVEHICLE) then
            local pet=HealBot_UnitPet(unit)
            button:SetAttribute(HB_prefix..buttonType..j, nil);
            if pet then
                button:SetAttribute(HB_prefix.."type"..j, "macro")
                button:SetAttribute(HB_prefix.."macrotext"..j, "/target "..pet..";")
            end
        elseif strlower(sName) == strlower(HEALBOT_WORD_FOCUS) then
            button:SetAttribute(HB_prefix..buttonType..j, "focus"..j);
            button:SetAttribute(HB_prefix.."type"..j, "focus")
            button:SetAttribute(HB_prefix.."type-focus"..j, "focus")
            HealBot_Action_UpdateAttribsMinReset(button, HB_prefix, cType, j, 2)
        elseif strlower(sName) == strlower(HEALBOT_ASSIST) then
            button:SetAttribute(HB_prefix..buttonType..j, "assist"..j);
            button:SetAttribute(HB_prefix.."type"..j, "assist")
            button:SetAttribute(HB_prefix.."type-assist"..j, "assist")
            HealBot_Action_UpdateAttribsMinReset(button, HB_prefix, cType, j, 2)
        elseif strlower(sName) == strlower(HEALBOT_STOP) then
            button:SetAttribute(HB_prefix..buttonType..j, nil);
            button:SetAttribute(HB_prefix.."type"..j, "macro")
            button:SetAttribute(HB_prefix.."macrotext"..j, "/stopcasting")
            HealBot_Action_UpdateAttribsMinReset(button, HB_prefix, cType, j, 2)
        elseif strlower(sName) == strlower(HEALBOT_MENU) then
            button:SetAttribute(HB_prefix..buttonType..j, nil);
            button:SetAttribute(HB_prefix.."type"..j, "togglemenu")
            HealBot_Action_UpdateAttribsMinReset(button, HB_prefix, cType, j, 2)
        elseif strlower(sName) == strlower(HEALBOT_HBMENU) then
            button:SetAttribute(HB_prefix..buttonType..j, nil);
            button:SetAttribute(HB_prefix.."type"..j, "showhbmenu")
            showHBmenu=function()
                if UnitExists(unit) then
                    local HBFriendsDropDown=CreateFrame("Frame", "HealBot_Action_hbmenuFrame_DropDown", UIParent, "UIDropDownMenuTemplate");
                    HBFriendsDropDown.unit=unit
                    HBFriendsDropDown.name=UnitName(unit)
                    HBFriendsDropDown.initialize=HealBot_Action_hbmenuFrame_DropDown_Initialize
                    HBFriendsDropDown.displayMode="MENU"
                    ToggleDropDownMenu(1, nil, HBFriendsDropDown, "cursor", 10, -8)
                end
            end
            button.showhbmenu=showHBmenu
        elseif HEALBOT_GAME_VERSION>2 and (strlower(sName) == strlower(HEALBOT_MOUNTS) or strlower(sName) == strlower(HEALBOT_MOUNTSPETS)) then
            button:SetAttribute(HB_prefix..buttonType..j, nil);
            if UnitIsUnit(unit, "player") then
                button:SetAttribute(HB_prefix.."type"..j, "showhbmountmenu")
                showhbmountmenu=function()
                    local HBFriendsDropDown=CreateFrame("Frame", "HealBot_Action_hbmountmenuFrame_DropDown", UIParent, "UIDropDownMenuTemplate");
                    HBFriendsDropDown.initialize=HealBot_Action_hbmountmenuFrame_DropDown_Initialize
                    HBFriendsDropDown.displayMode="MENU"
                    ToggleDropDownMenu(1, nil, HBFriendsDropDown, "cursor", 10, -8)
                end
                button.showhbmountmenu=showhbmountmenu
            end
        elseif HEALBOT_GAME_VERSION>2 and strlower(sName) == strlower(HEALBOT_FAVMOUNT) then
            button:SetAttribute(HB_prefix..buttonType..j, nil);
            if UnitIsUnit(unit, "player") then
                button:SetAttribute(HB_prefix.."type"..j, "macro")
                button:SetAttribute(HB_prefix.."macrotext"..j, "/run HealBot_MountsPets_FavMount()")
            end
        elseif HEALBOT_GAME_VERSION>2 and strlower(sName) == strlower(HEALBOT_RANDOMMOUNT) then
            button:SetAttribute(HB_prefix..buttonType..j, nil);
            if UnitIsUnit(unit, "player") then
                button:SetAttribute(HB_prefix.."type"..j, "macro")
                button:SetAttribute(HB_prefix.."macrotext"..j, '/run HealBot_MountsPets_ToggelMount("all")')
            end
        elseif HEALBOT_GAME_VERSION>2 and strlower(sName) == strlower(HEALBOT_RANDOMGOUNDMOUNT) then
            button:SetAttribute(HB_prefix..buttonType..j, nil);
            if UnitIsUnit(unit, "player") then
                button:SetAttribute(HB_prefix.."type"..j, "macro")
                button:SetAttribute(HB_prefix.."macrotext"..j, '/run HealBot_MountsPets_ToggelMount("ground")')
            end
        elseif HEALBOT_GAME_VERSION>3 and strlower(sName) == strlower(HEALBOT_FAVPET) then
            button:SetAttribute(HB_prefix..buttonType..j, nil);
            if UnitIsUnit(unit, "player") then
                button:SetAttribute(HB_prefix.."type"..j, "macro")
                button:SetAttribute(HB_prefix.."macrotext"..j, "/run C_PetJournal.SummonRandomPet(true)")
            end
        elseif strlower(sName) == strlower(HEALBOT_TOGGLE_MYTARGETS) then
            button:SetAttribute(HB_prefix..buttonType..j, nil);
            button:SetAttribute(HB_prefix.."type"..j, "macro")
            button:SetAttribute(HB_prefix.."macrotext"..j, '/run HealBot_Panel_ToggelHealTarget("'..unit..'", false)')
        elseif strlower(sName) == strlower(HEALBOT_TOGGLE_PRIVTANKS) then
            button:SetAttribute(HB_prefix..buttonType..j, nil);
            button:SetAttribute(HB_prefix.."type"..j, "macro")
            button:SetAttribute(HB_prefix.."macrotext"..j, '/run HealBot_Panel_ToggelPrivateTanks("'..unit..'", false)')
        elseif strlower(sName) == strlower(HEALBOT_TOGGLE_PRIVHEALS) then
            button:SetAttribute(HB_prefix..buttonType..j, nil);
            button:SetAttribute(HB_prefix.."type"..j, "macro")
            button:SetAttribute(HB_prefix.."macrotext"..j, '/run HealBot_Panel_ToggelPrivateHealers("'..unit..'", false)')
        elseif strlower(sName) == strlower(HEALBOT_TOGGLE_PRIVDPS) then
            button:SetAttribute(HB_prefix..buttonType..j, nil);
            button:SetAttribute(HB_prefix.."type"..j, "macro")
            button:SetAttribute(HB_prefix.."macrotext"..j, '/run HealBot_Panel_ToggelPrivateDamagers("'..unit..'", false)')
        elseif strlower(sName) == strlower(HEALBOT_TOGGLE_PERMPRIVLISTS) then
            button:SetAttribute(HB_prefix..buttonType..j, nil);
            button:SetAttribute(HB_prefix.."type"..j, "macro")
            button:SetAttribute(HB_prefix.."macrotext"..j, '/run HealBot_Panel_ToggelHealTarget("'..unit..'", true)')
        elseif strlower(sName) == strlower(HEALBOT_TOGGLE_PERMPRIVTANKS) then
            button:SetAttribute(HB_prefix..buttonType..j, nil);
            button:SetAttribute(HB_prefix.."type"..j, "macro")
            button:SetAttribute(HB_prefix.."macrotext"..j, '/run HealBot_Panel_ToggelPrivateTanks("'..unit..'", true)')
        elseif strlower(sName) == strlower(HEALBOT_TOGGLE_PERMPRIVHEALS) then
            button:SetAttribute(HB_prefix..buttonType..j, nil);
            button:SetAttribute(HB_prefix.."type"..j, "macro")
            button:SetAttribute(HB_prefix.."macrotext"..j, '/run HealBot_Panel_ToggelPrivateHealers("'..unit..'", true)')
        elseif strlower(sName) == strlower(HEALBOT_TOGGLE_PERMPRIVDPS) then
            button:SetAttribute(HB_prefix..buttonType..j, nil);
            button:SetAttribute(HB_prefix.."type"..j, "macro")
            button:SetAttribute(HB_prefix.."macrotext"..j, '/run HealBot_Panel_ToggelPrivateDamagers("'..unit..'", true)')
        elseif strlower(sName) == strlower(HEALBOT_CANCELPLUGINALERT) then
            button:SetAttribute(HB_prefix..buttonType..j, nil);
            button:SetAttribute(HB_prefix.."type"..j, "macro")
            button:SetAttribute(HB_prefix.."macrotext"..j, '/run HealBot_Action_DisableBorderHazardTypeGUID("'..button.guid..'", "PLUGIN")')
        elseif strlower(sName) == strlower(HEALBOT_MOUSELOOK) then
            button:SetAttribute(HB_prefix..buttonType..j, nil);
            button:SetAttribute(HB_prefix.."type"..j, "macro")
            button:SetAttribute(HB_prefix.."macrotext"..j, '/run if IsMouselooking() then MouselookStop() else MouselookStart() end')
        elseif HealBot_Spells_KnownByName(sName) then
            if sTar or sTrin1 or sTrin2 or AvoidBC then
                local mText=HealBot_Action_AlterSpell2Macro(sName, sTar, sTrin1, sTrin2, AvoidBC, unit, cType)
                button:SetAttribute(HB_prefix..buttonType..j, nil);
                button:SetAttribute(HB_prefix.."type"..j,"macro")
                button:SetAttribute(HB_prefix.."macrotext"..j, mText)
            else
                button:SetAttribute(HB_prefix..buttonType..j, sType..j);
                button:SetAttribute(HB_prefix.."type-"..sType..j, "spell");
                button:SetAttribute(HB_prefix.."spell-"..sType..j, sName);
                HealBot_Action_UpdateAttribsMinReset(button, HB_prefix, cType, j, 2)
            end
        elseif mId ~= 0 then
            local _,_,mText=GetMacroInfo(mId)
            if string.find(mText,"hbtargetpet") then
                local pet=HealBot_UnitPet(button.unit)
                if pet and UnitExists(pet) then
                    mText=string.gsub(mText,"hbtargetpet",pet)
                end
            end
            mText=string.gsub(mText,"hbtargettargettarget",unit.."targettarget")
            mText=string.gsub(mText,"hbtargettarget",unit.."target")
            mText=string.gsub(mText,"hbtarget",unit)
            button:SetAttribute(HB_prefix..buttonType..j, nil);
            button:SetAttribute(HB_prefix.."type"..j,"macro")
            button:SetAttribute(HB_prefix.."macrotext"..j, mText)
        elseif HealBot_IsKnownItem(sName) then
            button:SetAttribute(HB_prefix..buttonType..j, "item"..j);
            button:SetAttribute(HB_prefix.."type-item"..j, "item");
            button:SetAttribute(HB_prefix.."item-item"..j, sName);
            HealBot_Action_UpdateAttribsMinReset(button, HB_prefix, cType, j, 2)
        else
            local e,t=string.split("=", sName)
            if e and strlower(e) == strlower(HEALBOT_EMOTE) and t then
                button:SetAttribute(HB_prefix..buttonType..j, nil);
                button:SetAttribute(HB_prefix.."type"..j, "macro")
                button:SetAttribute(HB_prefix.."macrotext"..j, "/run DoEmote(\""..t.."\", "..unit..")")
            elseif e and strlower(e) == strlower(HEALBOT_ACTION) and t and (tonumber(t) or 0)>0 then
                button:SetAttribute(HB_prefix..buttonType..j, nil);
                button:SetAttribute(HB_prefix.."type"..j, "action")
                button:SetAttribute(HB_prefix.."action"..j, tonumber(t))
            elseif sTar or sTrin1 or sTrin2 or AvoidBC then
                local mText=HealBot_Action_AlterSpell2Macro(sName, sTar, sTrin1, sTrin2, AvoidBC, unit, cType)
                button:SetAttribute(HB_prefix..buttonType..j, nil);
                button:SetAttribute(HB_prefix.."type"..j,"macro")
                button:SetAttribute(HB_prefix.."macrotext"..j, mText)
            else
                button:SetAttribute(HB_prefix..buttonType..j, sType..j);
                button:SetAttribute(HB_prefix.."type-"..sType..j, "spell");
                button:SetAttribute(HB_prefix.."spell-"..sType..j, sName);
                HealBot_Action_UpdateAttribsMinReset(button, HB_prefix, cType, j, 2)
            end
        end
        return true
    else
        button:SetAttribute(HB_prefix..buttonType..j, nil);
        button:SetAttribute(HB_prefix.."type"..j, nil);
        HealBot_Action_UpdateAttribsMinReset(button, HB_prefix, cType, j, 1)
        return false
    end
end

function HealBot_Action_SetButtonAttrib(button,bbutton,bkey,cType,j,unit)
      --HealBot_setCall("HealBot_Action_SetButtonAttrib", button, nil, nil, true)
    local HB_prefix="";
    local buttonType="helpbutton"
    local sType="heal"
    if strlen(bkey)>1 then
        HB_prefix=strlower(bkey).."-"
    end
    local HB_combo_prefix=HealBot_Action_GetCombo(bkey, bbutton)
    local sName,sTar,sTrin1,sTrin2,AvoidBC=false,false,false,false,false
    HealBot_Action_UpdateAttribsMinReset(button, HB_prefix, cType, j, false)
    if cType == "Emerg" then
        sName, sTar, sTrin1, sTrin2, AvoidBC=HealBot_Action_AttribEmergSpellPattern(HB_combo_prefix)
        HealBot_Action_DoSetButtonAttrib(button,cType,j,unit,HB_prefix,"harmbutton",sName,sTar,sTrin1,sTrin2,AvoidBC,"harm")
    elseif cType == "Enemy" then
        sName, sTar, sTrin1, sTrin2, AvoidBC=HealBot_Action_AttribEnemySpellPattern(HB_combo_prefix)
        buttonType="harmbutton"
        sType="harm"
    else
        sName, sTar, sTrin1, sTrin2, AvoidBC=HealBot_Action_AttribSpellPattern(HB_combo_prefix)
    end
    return HealBot_Action_DoSetButtonAttrib(button,cType,j,unit,HB_prefix,buttonType,sName,sTar,sTrin1,sTrin2,AvoidBC,sType)
end

local hbMaxMouseButtons={["Enemy"]=20,["Enabled"]=20,["Emerg"]=5}
local hbBindTxt={}
function HealBot_Action_DefaultBinds(button)
      --HealBot_setCall("HealBot_Action_DefaultBinds", button)
    button:SetAttribute("_onleave", "self:ClearBindings();");
    button:SetAttribute("_onshow", "self:ClearBindings();");
    button:SetAttribute("_onhide", "self:ClearBindings();");
end

function HealBot_Action_InitBinds(button)
      --HealBot_setCall("HealBot_Action_InitBinds", button)
    hbBindTxt[0]=""
    button:SetAttribute("_onenter", "self:ClearBindings();");
    HealBot_Action_DefaultBinds(button)
end

local hbBindKey=""
function HealBot_Action_Binds(bNo)
      --HealBot_setCall("HealBot_Action_Binds")
    --hbBindTxt[bNo]=[[self:SetBindingClick(1, "]] .. HealBot_Options_retBindKey(HealBot_SpellBinds_GetData(bNo)) .. [[", self, "Button]] .. bNo .. [[");]]
    hbBindKey=HealBot_Options_retBindKey(HealBot_SpellBinds_GetData(bNo))
    if bNo == 1 then
        hbBindTxt[bNo]=[[self:SetBindingClick(1, "]] .. hbBindKey .. [[", self, "LeftButton");]]
    elseif bNo == 2 then
        hbBindTxt[bNo]=[[self:SetBindingClick(1, "]] .. hbBindKey .. [[", self, "MiddleButton");]]
    elseif bNo == 3 then
        hbBindTxt[bNo]=[[self:SetBindingClick(1, "]] .. hbBindKey .. [[", self, "RightButton");]]
    else
        hbBindTxt[bNo]=[[self:SetBindingClick(1, "]] .. hbBindKey .. [[", self, "Button]] .. bNo .. [[");]]
    end
end

function HealBot_Action_SetBinds(button, maxButton)
      --HealBot_setCall("HealBot_Action_SetBinds", button)
    for x=1,maxButton do
        if string.len(hbBindTxt[x])>0 then hbBindTxt[0]=hbBindTxt[0]..hbBindTxt[x] end
    end
    button:SetAttribute("_onenter", "self:ClearBindings();"..hbBindTxt[0]);
    HealBot_Action_DefaultBinds(button)
end

function HealBot_Action_SetAllButtonAttribs(button,cType)
      --HealBot_setCall("HealBot_Action_SetAllButtonAttribs", button)
    if hbMaxMouseButtons[cType]>0 then
        local hasSpells,attribSet,maxBinds=false,false,0
        for x=1, hbMaxMouseButtons[cType] do
            hasSpells=false
            for y=1, getn(HealBot_Keys_List), 1 do
                if strlen(HealBot_Keys_List[y])>1 then
                    HB_prefix=strlower(HealBot_Keys_List[y]).."-"
                else
                    HB_prefix="";
                end
                attribSet=HealBot_Action_ReturnAttribsFramesMinReset(button, HB_prefix, cType, x)
                if not attribSet then
                    if x == 1 then 
                        HB_button="Left";
                    elseif x == 2 then 
                        HB_button="Right";
                    elseif x == 3 then 
                        HB_button="Middle";
                    else
                        HB_button="Button"..x
                    end
                    if HealBot_Action_SetButtonAttrib(button,HB_button,HealBot_Keys_List[y],cType,x,button.unit) then
                        hasSpells=true
                    end
                elseif attribSet == 2 then
                    hasSpells=true
                end
            end
            if hasSpells then
                hbMaxMouseButtons[cType]=x
            elseif x == 20 and hbMaxMouseButtons[cType] == 20 then 
                hbMaxMouseButtons[cType]=0
            end
            if not button.binds[cType].set then
                if (x<6 or (x>5 and HealBot_Action_luVars["pluginExtraButtons"])) and HealBot_SpellBinds_GetData(x)>1 then
                    if maxBinds == 0 then
                        HealBot_Action_InitBinds(button)
                    end
                    HealBot_Action_Binds(x)
                    maxBinds=x
                else
                    hbBindTxt[x]=""
                end
            end
        end
        if maxBinds>0 then
            HealBot_Action_SetBinds(button, maxBinds)
            button.binds[cType].binds=true
            button.binds[cType].set=true
        elseif not button.binds[cType].set then
            if button.binds[cType].binds then
                HealBot_Action_InitBinds(button)
                button.binds[cType].binds=false
            end
            button.binds[cType].set=true
        end
    end
end

function HealBot_Action_PrepSetEnabledAttribs()
      --HealBot_setCall("HealBot_Action_PrepSetEnabledAttribs")
    if HealBot_Action_luVars["ButtonHWM"]>0 then
        local ghb,ehb
        for i=1,HealBot_Action_luVars["ButtonHWM"] do
            ghb=HealBot_Buttons[i]
            if ghb then
                ghb.attribs["Enabled"]={}
                ghb.binds["Enabled"]={}
            end
            ehb=HealBot_Emerg_Button[i]
            if ehb then
                ehb.attribs["Enabled"]={}
                ehb.binds["Enabled"]={}
            end
        end
        hbMaxMouseButtons["Enabled"]=20
        HealBot_Timers_Set("INIT","SetEnabledAttribs")
    end
end

function HealBot_Action_PrepSetEnemyAttribs()
      --HealBot_setCall("HealBot_Action_PrepSetEnemyAttribs")
    if HealBot_Action_luVars["ButtonHWM"]>0 then
        local ghb,ehb
        for i=1,HealBot_Action_luVars["ButtonHWM"] do
            ghb=HealBot_Buttons[i]
            if ghb then
                ghb.attribs["Enemy"]={}
                ghb.binds["Enemy"]={}
            end
            ehb=HealBot_Emerg_Button[i]
            if ehb then
                ehb.attribs["Enemy"]={}
                ehb.binds["Enemy"]={}
            end
        end
        hbMaxMouseButtons["Enemy"]=20
        HealBot_Timers_Set("INIT","SetEnemyAttribs")
        HealBot_Timers_Set("INIT","PrepSetEnabledAttribs")
    end
end

function HealBot_Action_PrepSetEmergAttribs()
      --HealBot_setCall("HealBot_Action_PrepSetEmergAttribs")
    if HealBot_Action_luVars["ButtonHWM"]>0 then
        local ghb,ehb
        for i=1,HealBot_Action_luVars["ButtonHWM"] do
            ghb=HealBot_Buttons[i]
            if ghb then
                ghb.attribs["Emerg"]={}
                ghb.binds["Emerg"]={}
            end
            ehb=HealBot_Emerg_Button[i]
            if ehb then
                ehb.attribs["Emerg"]={}
                ehb.binds["Emerg"]={}
            end
        end
        hbMaxMouseButtons["Emerg"]=5
        HealBot_Timers_Set("INIT","SetEmergAttribs")
    end
end

function HealBot_Action_PrepSetAllAttribs()
      --HealBot_setCall("HealBot_Action_PrepSetAllAttribs")
    if HealBot_Action_luVars["ButtonHWM"]>0 then
        local ghb,ehb
        for i=1,HealBot_Action_luVars["ButtonHWM"] do
            ghb=HealBot_Buttons[i]
            if ghb then
                ghb.attribs={["Emerg"]={},["Enemy"]={},["Enabled"]={}}
                ghb.binds={["Emerg"]={},["Enemy"]={},["Enabled"]={}}
            end
            ehb=HealBot_Emerg_Button[i]
            if ehb then
                ehb.attribs={["Emerg"]={},["Enemy"]={},["Enabled"]={}}
                ehb.binds={["Emerg"]={},["Enemy"]={},["Enabled"]={}}
            end
        end
        hbMaxMouseButtons["Enemy"]=20
        hbMaxMouseButtons["Enabled"]=20
        hbMaxMouseButtons["Emerg"]=5
        HealBot_Timers_Set("INIT","SetEnemyAttribs")
        HealBot_Timers_Set("INIT","SetEnabledAttribs")
        HealBot_Timers_Set("INIT","SetEmergAttribs")
    end
end

local hbGuidData={}
local hbGuidDefault={["OFFLINE"]=false,
                     ["SPEC"]=" ",
                     ["TMPSPEC"]=" ",
                     ["READYCHECK"]=false,
                     ["CLASSKNOWN"]=false,
                     ["PLAYER"]=false,
                     ["ISPLAYER"]=false,
                     ["CLASSTRIM"]="WARR",
                     ["CLASSR"]=1,
                     ["CLASSG"]=1,
                     ["CLASSB"]=1,
                    }
function HealBot_Action_initGuidData(button)
      --HealBot_setCall("HealBot_Action_initGuidData", button)
    if UnitExists(button.unit) then
        if UnitGUID(button.unit) == button.guid then
            hbGuidData[button.guid]={}
            hbGuidData[button.guid]["OFFLINE"]=false
            hbGuidData[button.guid]["SPEC"]=" "
            hbGuidData[button.guid]["TMPSPEC"]=" "
            hbGuidData[button.guid]["READYCHECK"]=false
            hbGuidData[button.guid]["CLASSKNOWN"]=false
            hbGuidData[button.guid]["PLAYER"]=false
            hbGuidData[button.guid]["ISPLAYER"]=false
            hbGuidData[button.guid]["CLASSTRIM"]="WARR"
            hbGuidData[button.guid]["CLASSR"]=1
            hbGuidData[button.guid]["CLASSG"]=1
            hbGuidData[button.guid]["CLASSB"]=1
        end
    end
end

function HealBot_Action_clearGuidData(guid)
      --HealBot_setCall("HealBot_Action_clearGuidData", nil, guid)
    if hbGuidData[guid] then hbGuidData[guid]=nil end
end

function HealBot_Action_getGuidData(guid, attrib)
      --HealBot_setCall("HealBot_Action_getGuidData", nil, guid)
    if not hbGuidData[guid] then
        return hbGuidDefault[attrib]
    else
        return hbGuidData[guid][attrib]
    end
end

function HealBot_Action_SetGuidData(button, attrib, value, callback)
      --HealBot_setCall("HealBot_Action_SetGuidData", button)
    if hbGuidData[button.guid] then 
        hbGuidData[button.guid][attrib]=value
    else
        HealBot_Action_initGuidData(button)
        if not callback then HealBot_Action_SetGuidData(button, attrib, value, true) end
    end
end

function HealBot_Action_setGuidSpec(button, spec)
      --HealBot_setCall("HealBot_Action_setGuidSpec", button)
    button.spec=" "..spec.." "
    HealBot_Action_SetGuidData(button, "SPEC", button.spec)
    HealBot_Action_SetGuidData(button, "TMPSPEC", button.spec)
    HealBot_Timers_Set("OOC","RefreshPartyNextRecalcPlayers",true)
end

function HealBot_Action_ActiveButtonId()
    return HealBot_Action_ActiveButton.id
end

function HealBot_Action_SetActiveButton(id)
      --HealBot_setCall("HealBot_Action_SetActiveButton")
    if HealBot_Action_ActiveButton.id>0 then
        HealBot_Action_ActiveButton.lastid=HealBot_Action_ActiveButton.id
    end
    HealBot_Action_ActiveButton.id=id
    if HealBot_Action_ActiveButton.id>0 then
        HealBot_Range_ButtonSpell(HealBot_Buttons[HealBot_Action_ActiveButton.id])
        HealBot_Action_ActiveButton.lastid=0
    elseif HealBot_Action_ActiveButton.lastid>0 and HealBot_Buttons[HealBot_Action_ActiveButton.lastid] then
        HealBot_Range_ButtonSpell(HealBot_Buttons[HealBot_Action_ActiveButton.lastid])
    end
end

function HealBot_Action_MarkAttribUpdateButton(button, enabled, enemy, emerg)
      --HealBot_setCall("HealBot_Action_MarkAttribUpdateButton", button)
    if not hbTrackAttribButtons[button.id] then
        hbTrackAttribButtons[button.id]=true
        table.insert(hbMarkedAttribButtons, button.id)
    end
    if enabled then button.attribs.enabled=true end
    if enemy then button.attribs.enemy=true end
    if emerg then button.attribs.emerg=true end
    HealBot_Timers_Set("OOC","MarkedAttribsButtons")
end

local hButton=false
function HealBot_Action_SetHealButton(unit,guid,frame,unitType,duplicate,role,preCombat,colFrame)
      --HealBot_setCall("HealBot_Action_SetHealButton", nil, guid)
    hButton=false
    if guid then
        if unitType<10 then
            if not HealBot_Action_Private_Button[unit] then
                HealBot_Action_Private_Button[unit]=HealBot_Action_CreateButton(frame, "HealBot_")
            end
            hButton=HealBot_Action_Private_Button[unit]
        elseif hbv_IsUnitType(unitType, HEALBOT_PET) then
            if not HealBot_Action_Pet_Button[unit] then 
                HealBot_Action_Pet_Button[unit]=HealBot_Action_CreateButton(frame, "hbPet_") 
            end
            hButton=HealBot_Action_Pet_Button[unit]
        elseif hbv_IsUnitType(unitType, HEALBOT_VEHICLE) then
            if not HealBot_Action_Vehicle_Button[unit] then 
                HealBot_Action_Vehicle_Button[unit]=HealBot_Action_CreateButton(frame, "hbVehicle_") 
            end
            hButton=HealBot_Action_Vehicle_Button[unit]
        elseif hbv_IsUnitType(unitType, HEALBOT_PRIVATETARGET) then
            if not HealBot_Action_PrivateTarget_Button[unit] then 
                HealBot_Action_PrivateTarget_Button[unit]=HealBot_Action_CreateButton(frame, "hbPrivTar_") 
            end
            hButton=HealBot_Action_PrivateTarget_Button[unit]
        elseif hbv_IsUnitType(unitType, HEALBOT_PLAYERTARGET) then
            if not HealBot_Action_UnitTarget_Button[unit] then 
                HealBot_Action_UnitTarget_Button[unit]=HealBot_Action_CreateButton(frame, "hbUnitTar_") 
            end
            hButton=HealBot_Action_UnitTarget_Button[unit]
        elseif hbv_IsUnitType(unitType, HEALBOT_ENEMY) then
            if not HealBot_Action_Enemy_Button[unit] then 
                HealBot_Action_Enemy_Button[unit]=HealBot_Action_CreateButton(frame, "hbEnemy_") 
            end
            hButton=HealBot_Action_Enemy_Button[unit]
        elseif unitType>30 then
            if not HealBot_Action_Extra_Button[unit] then 
                HealBot_Action_Extra_Button[unit]=HealBot_Action_CreateButton(frame, "hbExtra_") 
            end
            hButton=HealBot_Action_Extra_Button[unit]
        else
            if not HealBot_Action_Unit_Button[unit] then 
                HealBot_Action_Unit_Button[unit]=HealBot_Action_CreateButton(frame, "HealBot_") 
            end
            hButton=HealBot_Action_Unit_Button[unit]
        end
        if hButton then
            hButton.status.active=true
            if hButton.status.markdel then HealBot_Action_DeleteButton(hButton.id) end
            HealBot_Add_RefreshList(hButton.id)
            hButton.gref["Back"]:ClearAllPoints()
            erButton=HealBot_Emerg_Button[hButton.id]
            if hButton.frame~=frame or hButton.skin~=Healbot_Config_Skins.Current_Skin or hButton.guid~=guid then
                hButton.icon.reset=true
                hButton.text.reset=true
                hButton.skinreset=true
                hButton.indreset=true
                hButton.auxreset=true
                hButton.reset=true
                if hButton.frame~=frame or hButton.skin~=Healbot_Config_Skins.Current_Skin then
                    hButton:ClearAllPoints()
                    hButton:SetParent(grpFrame[frame])
                    erButton:ClearAllPoints()
                    erButton:SetParent(grpFrame[frame])
                    hButton.frame=frame
                    erButton.frame=frame
                    hButton.skin=Healbot_Config_Skins.Current_Skin
                    HealBot_Action_UpdateBackground(hButton)
                    for x=1,9 do
                        HealBot_Action_InitAuxGlow(x, frame, hButton)
                    end
                end
            elseif unitType>41 then
                hButton.skinreset=true
            end
            hButton.framecol=colFrame or frame
            
            if not hButton.regClicks then
                HealBot_Update_RegisterForClicks(hButton)
                HealBot_Update_RegisterForClicks(erButton)
            end
            
            hButton.status.role=role
            hButton.status.duplicate=duplicate
            if hButton.group~=HealBot_Panel_RetUnitGroups(unit) then
                hButton.group=HealBot_Panel_RetUnitGroups(unit)
                if HealBot_Text_TagInUse(hButton.framecol, "GROUP") then
                    HealBot_Text_setNameTag(hButton)
                end
            end
            if hButton.rank ~= HealBot_Panel_RetUnitRank(guid, frame) then
                hButton.rank=HealBot_Panel_RetUnitRank(guid, frame)
                HealBot_Timers_Set("AURA","IconUpdAllRank",true)
            end
            hButton.roletxt=HealBot_Panel_UnitRoleDefault(guid)
            if hButton.player then
                HealBot_Data["PLAYERGROUP"]=hButton.group
            end
            if hButton.unit~=unit or hButton.reset or hButton.guid~=guid or hButton.status.unittype~=unitType then
                hButton.status.unittype=unitType                                           -- 1=Tanks  2=Healers  3=Self  4=Private  5=privfocus  8=privfocusToT
                if hbv_IsUnitType(unitType, HEALBOT_PRIVATETARGET) then                    -- 11=Raid  12=Group
                    HealBot_PrivateTarget_Button[unit]=hButton                             -- 21=vehicle  22=pet
                    hButton:SetAttribute("toggleForVehicle", false)                        -- 31=target  32=tot  33=tof  35=focus
                    hButton.special.unit=true                                              -- 41=enemy  42=Player Target  43=Private Target
                elseif hbv_IsUnitType(unitType, HEALBOT_PLAYERTARGET) then
                    HealBot_UnitTarget_Button[unit]=hButton
                    hButton:SetAttribute("toggleForVehicle", false)
                    hButton.special.unit=true
                elseif hbv_IsUnitType(unitType, HEALBOT_ENEMY) then 
                    HealBot_Enemy_Button[unit]=hButton
                    hButton:SetAttribute("toggleForVehicle", false)
                    hButton.special.unit=true
                elseif hbv_IsUnitType(unitType, HEALBOT_PET) then 
                    HealBot_Pet_Button[unit]=hButton
                    hButton:SetAttribute("toggleForVehicle", false)
                    hButton.special.unit=false
                elseif hbv_IsUnitType(unitType, HEALBOT_VEHICLE) then
                    HealBot_Vehicle_Button[unit]=hButton
                    hButton:SetAttribute("toggleForVehicle", false)
                    hButton.special.unit=false
                elseif unitType<10 then
                    HealBot_Private_Button[unit]=hButton
                    hButton:SetAttribute("toggleForVehicle", true)
                    if unitType == 8 then
                        hButton.special.unit=true
                    else
                        hButton.special.unit=false
                    end
                elseif unitType>30 then
                    HealBot_Extra_Button[unit]=hButton
                    hButton:SetAttribute("toggleForVehicle", true)
                    if unitType == 32 or unitType == 33 then
                        hButton.special.unit=true
                    else
                        hButton.special.unit=false
                    end
                else
                    HealBot_Unit_Button[unit]=hButton
                    hButton:SetAttribute("toggleForVehicle", true)
                    hButton.special.unit=false
                end
                if hButton.unit~=unit or hButton.guid~=guid or hButton.reset then
                    if HealBot_Private_Button[unit] or HealBot_Unit_Button[unit] then
                        if UnitInRaid(unit) then
                            hButton.isgroupraid=true
                            hButton.raidid=UnitInRaid(unit)
                        else
                            hButton.raidid=0
                            if UnitInParty(unit) or (IsInGroup() and UnitIsUnit(unit, "player")) then
                                hButton.isgroupraid=true
                            else
                                hButton.isgroupraid=false
                            end
                        end
                    else
                        hButton.isgroupraid=false
                    end
                    hButton.reset=false
                    hButton.unit=unit
                    erButton.unit=unit
                    HealBot_Aura_setUnitIcons(unit)
                    HealBot_Action_ResetrCallsUnit(hButton)
                    if hButton.frame<10 then
                        hButton:SetScript("OnEvent", function(self, event, arg1, arg2, arg3) hbEventFuncs[event](self, arg1, arg2, arg3) end)
                    elseif hbEnemyEventFuncs[event] then
                        hButton:SetScript("OnEvent", function(self, event, arg1, arg2, arg3) hbEnemyEventFuncs[event](self, arg1, arg2, arg3) end)
                    end
                    hButton:SetAttribute("unit", unit);
                    erButton:SetAttribute("unit", unit);
                    HealBot_Action_SetAllButtonAttribs(hButton,"Enemy") 
                    HealBot_Action_SetAllButtonAttribs(hButton,"Enabled")
                    HealBot_Action_SetAllButtonAttribs(erButton,"Emerg")
                    if not UnitExists(unit) then
                        HealBot_UpdateUnitNotExists(hButton, true)
                    else
                        if hButton.guid~=guid then
                            HealBot_UpdateUnitGUIDChange(hButton)
                        end
                        --HealBot_UpdateUnitExists(hButton)
                        hButton.status.change=true
                        hButton.status.update=true
                        hButton.status.slowupdate=true
                    end
                end
                if not hButton.status.events then HealBot_Action_RegisterUnitEvents(hButton) end
            end
            if unitType<10 then
                HealBot_Panel_setButtonpGUID(hButton)
                hbShouldHealSomePrivateFrames[frame]=true
            elseif unitType<20 then
                HealBot_Panel_setButtonGUID(hButton)
                hbShouldHealSomePlayerFrames[frame]=true
            elseif unitType<30 then
                HealBot_Panel_setButtonPetGUID(hButton)
            end
            if hButton.skinreset or hButton.enemyreset or hButton.icon.reset or hButton.indreset or hButton.auxreset or hButton.text.reset then
                HealBot_Skins_ResetSkin("bar",hButton)
            elseif frame == 10 then
                HealBot_Skins_ResetSkinWidth(hButton)
            end
        else                
            if unitType>40 then
                HealBot_Timers_Set("OOC","RefreshPartyNextRecalcEnemy",true,true)
            elseif hbv_IsUnitType(unitType, HEALBOT_PET) then 
                HealBot_Timers_Set("OOC","RefreshPartyNextRecalcPets",true,true)
            elseif hbv_IsUnitType(unitType, HEALBOT_VEHICLE) then
                HealBot_Timers_Set("OOC","RefreshPartyNextRecalcVehicle",true,true)
            else
                HealBot_Timers_Set("OOC","RefreshPartyNextRecalcPlayers",true,true)
            end
        end
    end
    return hButton
end

function HealBot_Action_ClearTestIcon(button, id)
      --HealBot_setCall("HealBot_Action_ClearTestIcon")
    button.gref.icon[id]:SetAlpha(0)
    button.gref.txt.expire[id]:SetText(" ")
    button.gref.txt.count[id]:SetText(" ")
    button.gref.iconf[id]:SetFrameLevel(0)
end

local hbTestButtonUpdateQueue={}
local testBarsDat={["cnt"]=0, ["targetCnt"]=0}
local testBarsManaClass={["DRUI"]=true,["MAGE"]=true,["PALA"]=true,["PRIE"]=true,["SHAM"]=true,["WARL"]=true}
function HealBot_Action_UpdateTestButton(button)
      --HealBot_setCall("HealBot_Action_UpdateTestButton")
    button.testup=false
    button.status.unittype=hbv_GetUnitType(HEALBOT_RAID)
    if button.skin~=Healbot_Config_Skins.Current_Skin then
        button.skin=Healbot_Config_Skins.Current_Skin
    end
    if testBarsManaClass[unitClass] then
        button.mana.type=0
    else
        button.mana.type=1
    end
    for j=1,3 do
        button.gref.icon[j]:SetAlpha(0)
    end
    for j=51,53 do
        button.gref.icon[j]:SetAlpha(0)
    end
    button.gref.icon[91]:SetAlpha(0)
    button.gref.icon[92]:SetAlpha(0)
    testBarsDat["cnt"]=testBarsDat["cnt"]+1
    if not testBarsDat["buffTexture"] then testBarsDat["buffTexture"]=HealBot_WoWAPI_SpellTexture(HEALBOT_RENEW) end
    if not testBarsDat["debuffTexture"] then testBarsDat["debuffTexture"]=HealBot_WoWAPI_SpellTexture(HEALBOT_SHADOW_WORD_PAIN) end
    if HealBot_Config_Buffs.BuffWatch and HealBot_Globals.TestBarsIcons["BUFF"] then
        for x=1,8 do
            if x<=hbv_Skins_GetIconVar("MAXBICONS", button.frame, 1) then
                button.gref.icon[x]:SetTexture(testBarsDat["buffTexture"])
                button.gref.icon[x]:SetAlpha(1)
                button.icon.buff.count[1]=x
                button.icon.buff.id=1
                button.icon.buff.name="Test"
                if hbv_Skins_GetIconTextBoolean("BUFFSDUR", button.frame, 1) then
                    button.gref.txt.expire[x]:SetText("9")
                    button.gref.txt.expire[x]:SetTextColor(1,1,1,1)
                else
                    button.gref.txt.expire[x]:SetText(" ")
                end
                if hbv_Skins_GetIconTextBoolean("BUFFSCNT", button.frame, 1) then
                    button.gref.txt.count[x]:SetText("1")
                    button.gref.txt.count[x]:SetTextColor(1,1,1,1)
                else
                    button.gref.txt.count[x]:SetText(" ")
                end
            else
                HealBot_Action_ClearTestIcon(button, x)
            end
        end
        for x=9,10 do
            if (x-8)<=hbv_Skins_GetIconVar("MAXBICONS", button.frame, 2) then
                button.gref.icon[x]:SetTexture(testBarsDat["buffTexture"])
                button.gref.icon[x]:SetAlpha(1)
                button.icon.buff.count[2]=(x-8)
                button.icon.buff.id=1
                button.icon.buff.name="Test"
                if hbv_Skins_GetIconTextBoolean("BUFFSDUR", button.frame, 2) then
                    button.gref.txt.expire[x]:SetText("9")
                    button.gref.txt.expire[x]:SetTextColor(1,1,1,1)
                else
                    button.gref.txt.expire[x]:SetText(" ")
                end
                if hbv_Skins_GetIconTextBoolean("BUFFSCNT", button.frame, 2) then
                    button.gref.txt.count[x]:SetText("2")
                    button.gref.txt.count[x]:SetTextColor(1,1,1,1)
                else
                    button.gref.txt.count[x]:SetText(" ")
                end
            else
                HealBot_Action_ClearTestIcon(button, x)
            end
        end
        for x=11,12 do
            if (x-10)<=hbv_Skins_GetIconVar("MAXBICONS", button.frame, 3) then
                button.gref.icon[x]:SetTexture(testBarsDat["buffTexture"])
                button.gref.icon[x]:SetAlpha(1)
                button.icon.buff.count[3]=(x-10)
                button.icon.buff.id=1
                button.icon.buff.name="Test"
                if hbv_Skins_GetIconTextBoolean("BUFFSDUR", button.frame, 3) then
                    button.gref.txt.expire[x]:SetText("9")
                    button.gref.txt.expire[x]:SetTextColor(1,1,1,1)
                else
                    button.gref.txt.expire[x]:SetText(" ")
                end
                if hbv_Skins_GetIconTextBoolean("BUFFSCNT", button.frame, 3) then
                    button.gref.txt.count[x]:SetText("3")
                    button.gref.txt.count[x]:SetTextColor(1,1,1,1)
                else
                    button.gref.txt.count[x]:SetText(" ")
                end
            else
                HealBot_Action_ClearTestIcon(button, x)
            end
        end
    else
        for x=1,12 do
            HealBot_Action_ClearTestIcon(button, x)
        end
    end
    if HealBot_Config_Cures.DebuffWatch and HealBot_Globals.TestBarsIcons["DEBUFF"] then
        for x=51,56 do
            if (x-50)<=hbv_Skins_GetIconVar("MAXDICONS", button.frame, 1) then
                button.gref.icon[x]:SetTexture(testBarsDat["debuffTexture"])
                button.gref.icon[x]:SetAlpha(1)
                button.icon.debuff.count[1]=(x-50)
                button.icon.debuff.id=1
                button.icon.debuff.name="Test"
                if hbv_Skins_GetIconTextBoolean("DBSDUR", button.frame, 1) then
                    button.gref.txt.expire[x]:SetText("9")
                    button.gref.txt.expire[x]:SetTextColor(1,1,1,1)
                else
                    button.gref.txt.expire[x]:SetText(" ")
                end
                if hbv_Skins_GetIconTextBoolean("DBSCNT", button.frame, 1) then
                    button.gref.txt.count[x]:SetText("1")
                    button.gref.txt.count[x]:SetTextColor(1,1,1,1)
                else
                    button.gref.txt.count[x]:SetText(" ")
                end
            else
                HealBot_Action_ClearTestIcon(button, x)
            end
        end
        for x=57,58 do
            if (x-56)<=hbv_Skins_GetIconVar("MAXDICONS", button.frame, 2) then
                button.gref.icon[x]:SetTexture(testBarsDat["debuffTexture"])
                button.gref.icon[x]:SetAlpha(1)
                button.icon.debuff.count[2]=(x-56)
                button.icon.debuff.id=1
                button.icon.debuff.name="Test"
                if hbv_Skins_GetIconTextBoolean("DBSDUR", button.frame, 2) then
                    button.gref.txt.expire[x]:SetText("9")
                    button.gref.txt.expire[x]:SetTextColor(1,1,1,1)
                else
                    button.gref.txt.expire[x]:SetText(" ")
                end
                if hbv_Skins_GetIconTextBoolean("DBSCNT", button.frame, 2) then
                    button.gref.txt.count[x]:SetText("2")
                    button.gref.txt.count[x]:SetTextColor(1,1,1,1)
                else
                    button.gref.txt.count[x]:SetText(" ")
                end
            else
                HealBot_Action_ClearTestIcon(button, x)
            end
        end
        for x=59,60 do
            if (x-58)<=hbv_Skins_GetIconVar("MAXDICONS", button.frame, 3) then
                button.gref.icon[x]:SetTexture(testBarsDat["debuffTexture"])
                button.gref.icon[x]:SetAlpha(1)
                button.icon.debuff.count[3]=(x-58)
                button.icon.debuff.id=1
                button.icon.debuff.name="Test"
                if hbv_Skins_GetIconTextBoolean("DBSDUR", button.frame, 3) then
                    button.gref.txt.expire[x]:SetText("9")
                    button.gref.txt.expire[x]:SetTextColor(1,1,1,1)
                else
                    button.gref.txt.expire[x]:SetText(" ")
                end
                if hbv_Skins_GetIconTextBoolean("DBSCNT", button.frame, 3) then
                    button.gref.txt.count[x]:SetText("3")
                    button.gref.txt.count[x]:SetTextColor(1,1,1,1)
                else
                    button.gref.txt.count[x]:SetText(" ")
                end
            else
                HealBot_Action_ClearTestIcon(button, x)
            end
        end
    else
        for x=51,60 do
            HealBot_Action_ClearTestIcon(button, x)
        end
    end
    if HealBot_Globals.TestBarsIcons["EXTRA"] then
        if (testBarsDat["cnt"] % 4 == 0) and hbv_Skins_GetFrameBoolean("RaidIcon", "SHOW", button.frame) then
            testBarsDat["targetCnt"]=testBarsDat["targetCnt"]+1
            if testBarsDat["targetCnt"]>8 then testBarsDat["targetCnt"]=1 end
            button.gref.icon[92]:SetTexture(HealBot_Media_retTargetIcon(testBarsDat["targetCnt"]))
            button.gref.icon[92]:SetAlpha(1)
        else
            button.gref.icon[92]:SetAlpha(0)
        end
        if hbv_Skins_GetFrameBoolean("Icons", "SHOWCLASS", button.frame) then
            local classTexture=HealBot_Media_retClassRoleIcon(unitClass)
            if hbv_Skins_GetFrameBoolean("Icons", "SHOWROLE", button.frame) then
                classTexture=HealBot_Media_retClassRoleIcon(button.roletxt or "DAMAGER")
            end
            button.gref.icon[91]:SetTexture(classTexture)
            button.gref.icon[91]:SetAlpha(1)
        else
            button.gref.icon[91]:SetAlpha(0)
        end
        button.status.hostile=false
        button.icon.extra.hostile=false
        button.status.incombat=false
        button.icon.extra.readycheck=false
        button.status.afk=false
        button.rank=0
        if button.frame<6 then
            if (testBarsDat["cnt"] % 5 == 0) and hbv_Skins_GetFrameBoolean("Icons", "SHOWHOSTILE", button.frame) then
                button.status.hostile=true
                button.icon.extra.hostile=true
            elseif (testBarsDat["cnt"] % 2 == 0) and hbv_Skins_GetFrameBoolean("Icons", "SHOWCOMBAT", button.frame) then
                button.status.incombat=true
            end
            if hbv_Skins_GetFrameBoolean("Icons", "SHOWRC", button.frame) then
                button.icon.extra.readycheck=hbv_GetStatic("rcWAITING")
            elseif hbv_Skins_GetFrameBoolean("Icons", "SHOWAFK", button.frame) then
                button.status.afk=true
            end
            if (testBarsDat["cnt"] % 7 == 0) and hbv_Skins_GetFrameBoolean("Icons", "SHOWRANK", button.frame) then
                button.rank=1
            end
        elseif button.frame<8 then
            if (testBarsDat["cnt"] % 5 == 0) and hbv_Skins_GetFrameBoolean("Icons", "SHOWHOSTILE", button.frame) then
                button.status.hostile=true
                button.icon.extra.hostile=true
            end
        elseif hbv_Skins_GetFrameBoolean("Icons", "SHOWHOSTILE", button.frame) then
            button.status.hostile=true
            button.icon.extra.hostile=true
        end
        HealBot_Aura_UpdateRank(button)
        HealBot_Aura_UpdateCombat(button)
        HealBot_Aura_UpdateState(button)
    else
        for x=91,96 do
            HealBot_Aura_RemoveIcon(button, x)
        end
    end
    HealBot_Text_UpdateTestText(button)
    HealBot_Aux_TestUpdateButton(button)
end

function HealBot_Action_UpdateTestButtons()
      --HealBot_setCall("HealBot_Action_UpdateTestButtons")
    if hbTestButtonUpdateQueue[1] then
        HealBot_Action_UpdateTestButton(HealBot_Buttons[hbTestButtonUpdateQueue[1]])
        table.remove(hbTestButtonUpdateQueue, 1)
        HealBot_Timers_Set("SKINS","UpdateTestButtons")
    else
        HealBot_Action_luVars["UpTestButtons"]=false
    end
end

function HealBot_Action_ProcUpdateTestButtons()
      --HealBot_setCall("HealBot_Action_ProcUpdateTestButtons")
    if not HealBot_Action_luVars["UpTestButtons"] then
        HealBot_Action_luVars["UpTestButtons"]=true
        HealBot_Timers_Set("SKINS","UpdateTestButtons")
    end
end

local tButton=false
function HealBot_Action_SetTestButton(frame, unitText, unitRole, unitClass)
      --HealBot_setCall("HealBot_Action_SetTestButton")
    if not HealBot_Test_Button[unitText] then
        tButton=HealBot_Action_CreateButton(frame, "hbTest_")
        if tButton then
            tButton.icon.reset=true
            tButton.text.reset=true
            tButton.skinreset=true
            tButton.indreset=true
            tButton.auxreset=true
            tButton.reset=true
            tButton.unit=unitText
            tButton.guid="TestBar"
            HealBot_Test_Button[unitText]=tButton
        end
    else
        tButton=HealBot_Test_Button[unitText]
        if not tButton.testup then
            tButton.testup=true
            table.insert(hbTestButtonUpdateQueue, tButton.id)
        end
    end
    if tButton then
        tButton.gref["Back"]:ClearAllPoints()
        if tButton.regClicks then
            HealBot_Update_RegisterForClicks(tButton)
        end
        if tButton.roletxt~=unitRole then
            tButton.roletxt=unitRole
            tButton.reset=true
        end
        if tButton.frame~=frame then
            tButton:ClearAllPoints()
            tButton:SetParent(grpFrame[frame])
            tButton.frame=frame
            tButton.framecol=frame
            tButton.reset=true
            HealBot_Panel_resetTestColsButton(tButton.id)
        elseif tButton.skin~=Healbot_Config_Skins.Current_Skin then
            tButton.reset=true
            HealBot_Panel_resetTestColsButton(tButton.id)
        end
        HealBot_Skins_showPowerCounter(HealBot_Action_luVars["showTestPowerIndicator"])
        HealBot_Action_luVars["showTestPowerIndicator"]=0
        HealBot_Skins_ResetSkin("bar",tButton)
        if tButton.testup then
            HealBot_Action_ProcUpdateTestButtons()
        else
            HealBot_Action_UpdateTestButton(tButton)
        end
    end
    return tButton
end

function HealBot_Action_resetTestBarsCounters()
      --HealBot_setCall("HealBot_Action_resetTestBarsCounters")
    testBarsDat["cnt"]=0
    testBarsDat["targetCnt"]=0
end

function HealBot_Action_SethbFocusButtonAttrib(button)
      --HealBot_setCall("HealBot_Action_SethbFocusButtonAttrib", button)
    button:SetAttribute("unit", "target")
    button:SetAttribute("helpbutton1", "focus1");
    button:SetAttribute("type1", "focus")
    button:SetAttribute("type-focus1", "focus")
end

local sButton
function HealBot_Action_AttribsButton(buttonID)
      --HealBot_setCall("HealBot_Action_AttribsButton")
    hbTrackAttribButtons[buttonID]=false
    sButton=HealBot_Buttons[buttonID]
    if sButton.attribs.enemy then
        sButton.attribs.enemy=false
        HealBot_Action_SetAllButtonAttribs(sButton,"Enemy") 
    end
    if sButton.attribs.enabled then
        sButton.attribs.enabled=false
        HealBot_Action_SetAllButtonAttribs(sButton,"Enabled")
    end
    if sButton.attribs.emerg then
        sButton.attribs.emerg=false
        HealBot_Action_SetAllButtonAttribs(HealBot_Emerg_Button[buttonID],"Emerg")
    end
end

function HealBot_Action_AttribsMarkedButton()
      --HealBot_setCall("HealBot_Action_AttribsMarkedButton")
    if hbMarkedAttribButtons[1] then
        HealBot_Action_AttribsButton(hbMarkedAttribButtons[1])
        table.remove(hbMarkedAttribButtons,1)
        return true
    else
        return false
    end
end

function HealBot_Action_ProcMarkedAttribsButtons()
      --HealBot_setCall("HealBot_Action_ProcMarkedCacheButtons")
    HealBot_Action_luVars["MarkedAttribsButtonsActive"]=true
    if HealBot_Action_AttribsMarkedButton() then
        HealBot_Timers_Set("OOC","ProcMarkedAttribsButtons")
    else
        HealBot_Action_luVars["MarkedAttribsButtonsActive"]=false
    end
end

function HealBot_Action_MarkedAttribsButtons()
      --HealBot_setCall("HealBot_Action_MarkedAttribsButtons")
    if not HealBot_Action_luVars["MarkedAttribsButtonsActive"] then
        HealBot_Action_ProcMarkedAttribsButtons()
    end
end

local dButton
function HealBot_Action_DeleteButton(buttonID)
      --HealBot_setCall("HealBot_Action_DeleteButton")
    dButton=HealBot_Buttons[buttonID]
    if dButton.frame>0 and not dButton.status.active then 
        HealBot_Action_setState(dButton, HealBot_Unit_Status["RESERVED"])
        HealBot_UpdateUnitClear(dButton)
        HealBot_Action_DisableBorderHazardTypeButton(dButton) 
        HealBot_QueueClearGUID(dButton)
        for x=1,12 do
            dButton.gref.iconf[x]:SetFrameLevel(0)
        end
        for x=51,60 do
            dButton.gref.iconf[x]:SetFrameLevel(0)
        end
        HealBot_Del_RefreshList(buttonID)
    end
    HealBot_Action_PrepButton(dButton)
end

local hbMarkedDeleteButtons={}
function HealBot_Action_DeleteMarkedButton()
      --HealBot_setCall("HealBot_Action_DeleteMarkedButton")
    if hbMarkedDeleteButtons[1] then
        HealBot_Action_DeleteButton(hbMarkedDeleteButtons[1])
        table.remove(hbMarkedDeleteButtons,1)
        return true
    else
        return false
    end
end

function HealBot_Action_ProcMarkedCacheButtons()
      --HealBot_setCall("HealBot_Action_ProcMarkedCacheButtons")
    HealBot_Action_luVars["MarkedCacheButtonsActive"]=true
    if HealBot_Action_DeleteMarkedButton() then
        HealBot_Timers_Set("LAST","ProcMarkedCacheButtons")
    else
        HealBot_Action_luVars["MarkedCacheButtonsActive"]=false
    end
end

function HealBot_Action_MarkedCacheButtons()
      --HealBot_setCall("HealBot_Action_MarkedCacheButtons")
    if not HealBot_Action_luVars["MarkedCacheButtonsActive"] then
        HealBot_Action_ProcMarkedCacheButtons()
    end
end

function HealBot_Action_MarkDeleteButton(button)
      --HealBot_setCall("HealBot_Action_MarkDeleteButton", button)
    HealBot_Panel_ButtonHide(button)
    HealBot_Action_UnregisterUnitEvents(button)
    button.status.markdel=true
    if HealBot_Enemy_Button[button.unit] and HealBot_Enemy_Button[button.unit].id == button.id then 
        HealBot_Enemy_Button[button.unit]=nil 
    end
    if HealBot_UnitTarget_Button[button.unit] and HealBot_UnitTarget_Button[button.unit].id == button.id then 
        HealBot_UnitTarget_Button[button.unit]=nil 
    end
    if HealBot_PrivateTarget_Button[button.unit] and HealBot_PrivateTarget_Button[button.unit].id == button.id then 
        HealBot_PrivateTarget_Button[button.unit]=nil 
    end
    if HealBot_Pet_Button[button.unit] and HealBot_Pet_Button[button.unit].id == button.id then 
        HealBot_Pet_Button[button.unit]=nil 
    end
    if HealBot_Vehicle_Button[button.unit] and HealBot_Vehicle_Button[button.unit].id == button.id then 
        HealBot_Vehicle_Button[button.unit]=nil 
    end
    if HealBot_Private_Button[button.unit] and HealBot_Private_Button[button.unit].id == button.id then 
        HealBot_Private_Button[button.unit]=nil 
    end
    if HealBot_Extra_Button[button.unit] and HealBot_Extra_Button[button.unit].id == button.id then 
        HealBot_Extra_Button[button.unit]=nil 
    end
    if HealBot_Unit_Button[button.unit] and HealBot_Unit_Button[button.unit].id == button.id then 
        HealBot_Unit_Button[button.unit]=nil 
    end
    if HealBot_Test_Button[button.unit] and HealBot_Test_Button[button.unit].id == button.id then 
        HealBot_Test_Button[button.unit]=nil
    end
    if button.hotbars.state then HealBot_Action_BarHotRemove(button) end
    if HealBot_Fluid_BarButtons[button.id] then HealBot_Fluid_BarButtons[button.id]=nil end
    if HealBot_Fluid_InHealButtons[button.id] then HealBot_Fluid_InHealButtons[button.id]=nil end
    if HealBot_Fluid_AbsorbButtons[button.id] then HealBot_Fluid_AbsorbButtons[button.id]=nil end
    if HealBot_Hazard_Buttons[button.id] then HealBot_Hazard_Buttons[button.id]=nil end
    table.insert(hbMarkedDeleteButtons, button.id)
    HealBot_Timers_Set("LAST","MarkedCacheButtons")
end

function HealBot_Action_MarkDeleteEnemyButton(button)
    HealBot_Action_MarkDeleteButton(button)
    HealBot_Panel_PlayersTargetsQueueResetSkins()
    HealBot_Panel_setLuVars("RecalcOnZeroEnemy", true)
end

function HealBot_Action_Reset()
      --HealBot_setCall("HealBot_Action_Reset")
    HealBot_Update_Skins()
    if HealBot_Config.DisabledNow == 1 then
        HealBot_Options_DisableHealBotOpt:SetChecked(false)
        HealBot_Options_DisableHealBot(false)
        HealBot_Timers_Set("RESET","Frames",true)
    else
        for i=1, 10 do
            hbv_Skins_SetFrameVar((49+(i*2)), "Anchors", "X", i)
            hbv_Skins_SetFrameVar((49+(i*2)), "Anchors", "Y", i)
            hbv_Skins_SetFrameVar(1, "Frame", "AUTOCLOSE", i)
            HealBot_AutoCloseFrame[i]=1
            if HealBot_Action_FrameIsVisible(i) then
                --HealBot_Action_ShowPanel(i)
                --HealBot_Action_FrameSetPoint(i, grpFrame[i])
                HealBot_Action_setPoint(i)
            end
            HealBot_Action_unlockFrame(i)
        end
        HealBot_Options_SetSkins(true)
        HealBot_Timers_InitExtraOptions()
    end
    HealBot_Timers_TurboOn()
end

function HealBot_Action_unlockFrame(frame)
      --HealBot_setCall("HealBot_Action_unlockFrame")
    hbv_Skins_SetFrameVar(1, "Frame", "LOCKED", frame)
end

local hbFrameSetPoint={[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
local hbFrameSetPointCheck={[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
local hbFrameSetPointReal={[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
local hbFrameGetCoords={[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
function HealBot_Action_DelayCheckFrameSetPoint(frame, setPoint, check, useReal)
      --HealBot_setCall("HealBot_Action_DelayCheckFrameSetPoint")
    if setPoint then
        hbFrameSetPoint[frame]=true
        if check then hbFrameSetPointCheck[frame]=true end
        if useReal then hbFrameSetPointReal[frame]=true end
    else
        hbFrameGetCoords[frame]=true
    end
    HealBot_Timers_Set("OOC","CheckFrameSetPoint",true)
end

function HealBot_Action_CheckFrameSetPoint()
      --HealBot_setCall("HealBot_Action_CheckFrameSetPoint")
    for x=1,10 do
        if hbFrameSetPoint[x] then
            hbFrameSetPoint[x]=false
            HealBot_Action_setPoint(x, hbFrameSetPointCheck[x], hbFrameSetPointReal[x])
        elseif hbFrameGetCoords[x] then
            HealBot_Action_CheckFrame(x, grpFrame[x])
        end
        hbFrameGetCoords[x]=false
        hbFrameSetPointCheck[x]=false
        hbFrameSetPointReal[x]=false
    end
end

local hbStickyFrameGetCoords={[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
function HealBot_Action_CheckStuckFrames(frame)
      --HealBot_setCall("HealBot_Action_CheckStuckFrames")
    for x=frame,10 do
        if hbStickyFrameGetCoords[x] then
            HealBot_Action_CheckFrame(x, grpFrame[x])
        end
    end
end

function HealBot_Action_CheckFrameRealXY(frame, HBframe)
    local Hcenter=HealBot_Util_Round(GetScreenWidth()/2)
    local Vcenter=HealBot_Util_Round(GetScreenHeight()/2)
    if hbv_Skins_GetFrameVar("Anchors", "FRAME", frame) == 1 then
        hbv_Skins_SetFrameVar(HealBot_Util_Round(HBframe:GetLeft()-Hcenter), "Anchors", "RealX", frame)
        hbv_Skins_SetFrameVar(HealBot_Util_Round(HBframe:GetTop()-Vcenter), "Anchors", "RealY", frame)
    elseif hbv_Skins_GetFrameVar("Anchors", "FRAME", frame) == 2 then
        hbv_Skins_SetFrameVar(HealBot_Util_Round(HBframe:GetLeft()-Hcenter), "Anchors", "RealX", frame)
        hbv_Skins_SetFrameVar(HealBot_Util_Round(HBframe:GetBottom()-Vcenter), "Anchors", "RealY", frame)
    elseif hbv_Skins_GetFrameVar("Anchors", "FRAME", frame) == 3 then
        hbv_Skins_SetFrameVar(HealBot_Util_Round(HBframe:GetRight()-Hcenter), "Anchors", "RealX", frame)
        hbv_Skins_SetFrameVar(HealBot_Util_Round(HBframe:GetTop()-Vcenter), "Anchors", "RealY", frame)
    elseif hbv_Skins_GetFrameVar("Anchors", "FRAME", frame) == 4 then
        hbv_Skins_SetFrameVar(HealBot_Util_Round(HBframe:GetRight()-Hcenter), "Anchors", "RealX", frame)
        hbv_Skins_SetFrameVar(HealBot_Util_Round(HBframe:GetBottom()-Vcenter), "Anchors", "RealY", frame)
    elseif hbv_Skins_GetFrameVar("Anchors", "FRAME", frame) == 5 then
        hbv_Skins_SetFrameVar(HealBot_Util_Round(HBframe:GetCenter()-Hcenter), "Anchors", "RealX", frame)
        hbv_Skins_SetFrameVar(HealBot_Util_Round(HBframe:GetTop()-Vcenter), "Anchors", "RealY", frame)
    elseif hbv_Skins_GetFrameVar("Anchors", "FRAME", frame) == 6 then
        hbv_Skins_SetFrameVar(HealBot_Util_Round(HBframe:GetLeft()-Hcenter), "Anchors", "RealX", frame)
        local _, c=HBframe:GetCenter()
        hbv_Skins_SetFrameVar(HealBot_Util_Round(c-Vcenter), "Anchors", "RealY", frame)
    elseif hbv_Skins_GetFrameVar("Anchors", "FRAME", frame) == 7 then
        hbv_Skins_SetFrameVar(HealBot_Util_Round(HBframe:GetRight()-Hcenter), "Anchors", "RealX", frame)
        local _, c=HBframe:GetCenter()
        hbv_Skins_SetFrameVar(HealBot_Util_Round(c-Vcenter), "Anchors", "RealY", frame)
    elseif hbv_Skins_GetFrameVar("Anchors", "FRAME", frame) == 8 then
        hbv_Skins_SetFrameVar(HealBot_Util_Round(HBframe:GetCenter()-Hcenter), "Anchors", "RealX", frame)
        hbv_Skins_SetFrameVar(HealBot_Util_Round(HBframe:GetBottom()-Vcenter), "Anchors", "RealY", frame)
    end
end

function HealBot_Action_CheckFrame(frame, HBframe, callback)
      --HealBot_setCall("HealBot_CheckActionFrame")
    HealBot_Action_luVars["ScreenHeight"]=GetScreenHeight()
    HealBot_Action_luVars["ScreenWidth"]=GetScreenWidth()
    if HBframe:GetTop() then
        if not hbv_Skins_GetFrameBoolean("Anchors", "RealFixed", frame) then
            HealBot_Action_CheckFrameRealXY(frame, HBframe)
        end
        if hbv_Skins_GetFrameVar("Anchors", "FRAME", frame) == 1 then
            local fTop=HealBot_Util_Round(((HBframe:GetTop()/GetScreenHeight())*100),2)
            local fLeft=HealBot_Util_Round(((HBframe:GetLeft()/GetScreenWidth())*100),2)
            hbv_Skins_SetFrameVar(fTop, "Anchors", "Y", frame)
            hbv_Skins_SetFrameVar(fLeft, "Anchors", "X", frame)
        elseif hbv_Skins_GetFrameVar("Anchors", "FRAME", frame) == 2 then
            local fBottom=HealBot_Util_Round(((HBframe:GetBottom()/GetScreenHeight())*100),2)
            local fLeft=HealBot_Util_Round(((HBframe:GetLeft()/GetScreenWidth())*100),2)
            hbv_Skins_SetFrameVar(fBottom, "Anchors", "Y", frame)
            hbv_Skins_SetFrameVar(fLeft, "Anchors", "X", frame)
        elseif hbv_Skins_GetFrameVar("Anchors", "FRAME", frame) == 3 then
            local fTop=HealBot_Util_Round(((HBframe:GetTop()/GetScreenHeight())*100),2)
            local fRight=HealBot_Util_Round(((HBframe:GetRight()/GetScreenWidth())*100),2)
            hbv_Skins_SetFrameVar(fTop, "Anchors", "Y", frame)
            hbv_Skins_SetFrameVar(fRight, "Anchors", "X", frame)
        elseif hbv_Skins_GetFrameVar("Anchors", "FRAME", frame) == 4 then
            local fBottom=HealBot_Util_Round(((HBframe:GetBottom()/GetScreenHeight())*100),2)
            local fRight=HealBot_Util_Round(((HBframe:GetRight()/GetScreenWidth())*100),2)
            hbv_Skins_SetFrameVar(fBottom, "Anchors", "Y", frame)
            hbv_Skins_SetFrameVar(fRight, "Anchors", "X", frame)
        elseif hbv_Skins_GetFrameVar("Anchors", "FRAME", frame) == 5 then
            local fTop=HealBot_Util_Round(((HBframe:GetTop()/GetScreenHeight())*100),2)
            local fHcenter=HealBot_Util_Round(((HBframe:GetCenter()/GetScreenWidth())*100),2)
            hbv_Skins_SetFrameVar(fTop, "Anchors", "Y", frame)
            hbv_Skins_SetFrameVar(fHcenter, "Anchors", "X", frame)
        elseif hbv_Skins_GetFrameVar("Anchors", "FRAME", frame) == 6 then
            local fVcenter=HealBot_Util_Round(((((HBframe:GetTop()+HBframe:GetBottom())/2)/GetScreenHeight())*100),2)
            local fLeft=HealBot_Util_Round(((HBframe:GetLeft()/GetScreenWidth())*100),2)
            hbv_Skins_SetFrameVar(fVcenter, "Anchors", "Y", frame)
            hbv_Skins_SetFrameVar(fLeft, "Anchors", "X", frame)
        elseif hbv_Skins_GetFrameVar("Anchors", "FRAME", frame) == 7 then
            local fVcenter=HealBot_Util_Round(((((HBframe:GetTop()+HBframe:GetBottom())/2)/GetScreenHeight())*100),2)
            local fRight=HealBot_Util_Round(((HBframe:GetRight()/GetScreenWidth())*100),2)
            hbv_Skins_SetFrameVar(fVcenter, "Anchors", "Y", frame)
            hbv_Skins_SetFrameVar(fRight, "Anchors", "X", frame)
        elseif hbv_Skins_GetFrameVar("Anchors", "FRAME", frame) == 8 then
            local fBottom=HealBot_Util_Round(((HBframe:GetBottom()/GetScreenHeight())*100),2)
            local fHcenter=HealBot_Util_Round(((HBframe:GetCenter()/GetScreenWidth())*100),2)
            hbv_Skins_SetFrameVar(fBottom, "Anchors", "Y", frame)
            hbv_Skins_SetFrameVar(fHcenter, "Anchors", "X", frame)
        end
        HealBot_CheckFrame(frame, HBframe) 
        HealBot_Options_Coords_OnTextChanged(hbv_Skins_GetFrameVar("Anchors", "RealX", frame),
                                             hbv_Skins_GetFrameVar("Anchors", "RealY", frame),
                                             frame)
    elseif HealBot_Action_FrameIsVisible(frame) then
        HealBot_Action_DelayCheckFrameSetPoint(frame, false)
    elseif not callback then
        HealBot_Action_ShowPanel(frame)
        HealBot_Action_HidePanel(frame)
        HealBot_Action_CheckFrame(frame, HBframe, true)
    end
end

local vFrameSetPointX,vFrameSetPointY=0,0
function HealBot_Action_FrameSetPoint(frame, gaf, useReal, callback)
      --HealBot_setCall("HealBot_Action_FrameSetPoint")
    if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin] and 
       Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][frame] then
        gaf:ClearAllPoints();
        if hbv_Skins_GetFrameVar("Anchors", "RealX", frame) and hbv_Skins_GetFrameVar("Anchors", "RealY", frame) and (hbv_Skins_GetFrameBoolean("Anchors", "RealFixed", frame) or useReal) then
            vFrameSetPointY=hbv_Skins_GetFrameVar("Anchors", "RealY", frame)+HealBot_Util_Round(GetScreenHeight()/2)
            vFrameSetPointX=hbv_Skins_GetFrameVar("Anchors", "RealX", frame)+HealBot_Util_Round(GetScreenWidth()/2)
        else
            vFrameSetPointY=GetScreenHeight()*(hbv_Skins_GetFrameVar("Anchors", "Y", frame)/100)
            vFrameSetPointX=GetScreenWidth()*(hbv_Skins_GetFrameVar("Anchors", "X", frame)/100)
        end
        if hbv_Skins_GetFrameVar("Anchors", "FRAME", frame) == 1 then
            gaf:SetPoint("TOPLEFT","UIParent","BOTTOMLEFT",vFrameSetPointX,vFrameSetPointY);
        elseif hbv_Skins_GetFrameVar("Anchors", "FRAME", frame) == 2 then
            gaf:SetPoint("BOTTOMLEFT","UIParent","BOTTOMLEFT",vFrameSetPointX,vFrameSetPointY);
        elseif hbv_Skins_GetFrameVar("Anchors", "FRAME", frame) == 3 then
            gaf:SetPoint("TOPRIGHT","UIParent","BOTTOMLEFT",vFrameSetPointX,vFrameSetPointY);
        elseif hbv_Skins_GetFrameVar("Anchors", "FRAME", frame) == 4 then
            gaf:SetPoint("BOTTOMRIGHT","UIParent","BOTTOMLEFT",vFrameSetPointX,vFrameSetPointY);
        elseif hbv_Skins_GetFrameVar("Anchors", "FRAME", frame) == 5 then
            gaf:SetPoint("TOP","UIParent","BOTTOMLEFT",vFrameSetPointX,vFrameSetPointY);
        elseif hbv_Skins_GetFrameVar("Anchors", "FRAME", frame) == 6 then
            gaf:SetPoint("LEFT","UIParent","BOTTOMLEFT",vFrameSetPointX,vFrameSetPointY);
        elseif hbv_Skins_GetFrameVar("Anchors", "FRAME", frame) == 7 then
            gaf:SetPoint("RIGHT","UIParent","BOTTOMLEFT",vFrameSetPointX,vFrameSetPointY);
        elseif hbv_Skins_GetFrameVar("Anchors", "FRAME", frame) == 8 then
            gaf:SetPoint("BOTTOM","UIParent","BOTTOMLEFT",vFrameSetPointX,vFrameSetPointY);
        end

    elseif not callback then
        HealBot_Skins_Check_Skin(Healbot_Config_Skins.Current_Skin)
        HealBot_Action_CheckFrame(frame, gaf)
        HealBot_Action_FrameSetPoint(frame, gaf, useReal, true)
    end
end

function HealBot_Action_setPoint(frame, check, useReal)
      --HealBot_setCall("HealBot_Action_setPoint")
    if not frame then return end
    if not HealBot_Data["UILOCK"] then
        if check then HealBot_Action_CheckFrame(frame, grpFrame[frame]) end
        if not HealBot_Action_StickyFrame(frame) then
            HealBot_Action_FrameSetPoint(frame, grpFrame[frame], useReal)
        end
        if frame<10 then
            HealBot_Action_CheckStuckFrames(frame)
        end
    else
        HealBot_Action_DelayCheckFrameSetPoint(frame, true, check, useReal)
    end
end

function HealBot_Action_ClassColour(unit, cTrim)
      --HealBot_setCall("HealBot_Action_ClassColour", nil, nil, unit)
    if not cTrim or cTrim == "XXXX" then
        if unit and UnitClass(unit) then
            _,cTrim=UnitClass(unit)    
        end
        if cTrim then
            cTrim=strsub(cTrim,1,4)
        else
            cTrim="WARR"
        end
    end
    if not hbCustomClassCols[cTrim] then
        cTrim="WARR"
    end
    return hbCustomClassCols[cTrim].r,
           hbCustomClassCols[cTrim].g,
           hbCustomClassCols[cTrim].b
end

function HealBot_Action_HideTooltip(self)
      --HealBot_setCall("HealBot_Action_HideTooltip")
    if HealBot_Data["TIPBUTTON"] then
        HealBot_Data["TIPBUTTON"]=false;
        HealBot_Action_HideTooltipFrame()
    end
end

function HealBot_Action_HideTooltipFrame()
      --HealBot_setCall("HealBot_Action_HideTooltipFrame")
    if HealBot_Data["TIPUSE"] then
        HealBot_Tooltip_Hide()
        HealBot_Data["TIPICON"]=false
    end
end

local initFrame={}
function HealBot_Action_ShowFramesOnSkinChange()
      --HealBot_setCall("HealBot_Action_ShowFramesOnSkinChange")
    for j=1,10 do
        initFrame[j]=false
    end
    for j=1,15 do
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][j]["STATE"] then
            initFrame[Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][j]["FRAME"]]=true
        end
    end
    for j=1,10 do
        if initFrame[j] and not HealBot_Action_FrameIsVisible(j) then
            HealBot_Action_ShowPanel(j, true)
            HealBot_Action_setPoint(j, false)
            HealBot_Action_HidePanel(j, true)
        end
    end
    HealBot_Options_Set_Coords()
end

local hbHideFrame={}
local hbHideFrameList={}
function HealBot_Action_CheckHideFrames()
    if hbHideFrame[1] then
        if not HealBot_Action_ShouldHealSome(hbHideFrame[1]) then
            HealBot_Action_HidePanel(hbHideFrame[1])
        end
        hbHideFrameList[hbHideFrame[1]]=false
        table.remove(hbHideFrame, 1)
        HealBot_Timers_Set("SKINS","CheckHideFrames",true)
    else
        HealBot_Action_luVars["CheckingHideFrames"]=false
    end
end

function HealBot_Action_ShowHideFrames(button)
      --HealBot_setCall("HealBot_Action_ShowHideFrames", button)
    if not HealBot_Data["UILOCK"] and HealBot_AutoCloseFrame[button.frame]>1 then
        if button.status.enabled and HealBot_Config.DisabledNow == 0 then
            HealBot_Action_ShowPanel(button.frame)
        elseif HealBot_Action_FrameIsVisible(button.frame) then
            if not hbHideFrameList[button.frame] then
                hbHideFrameList[button.frame]=true
                table.insert(hbHideFrame, button.frame)
            end
            if not HealBot_Action_luVars["CheckingHideFrames"] then
                HealBot_Action_luVars["CheckingHideFrames"]=true
                HealBot_Timers_Set("SKINS","CheckHideFrames",true)
            end
        end
    end
end

function HealBot_Action_ShowHideFrameOption(frame)
      --HealBot_setCall("HealBot_Action_ShowHideFrameOption")
    if not HealBot_Data["UILOCK"] then
        if frame>5 then
            if frame == 6 then
                HealBot_nextRecalcParty(1)
            elseif frame == 7 then
                HealBot_nextRecalcParty(2)
            elseif frame == 8 then
                HealBot_nextRecalcParty(3)
            elseif frame == 9 then 
                HealBot_nextRecalcParty(4)
            elseif frame == 10 then 
                HealBot_nextRecalcParty(5)
            end
        else
            HealBot_nextRecalcParty(6)
        end
    end
end

function HealBot_Action_setAutoClose(reset)
      --HealBot_setCall("HealBot_Action_setAutoClose")
    local cVal=1
    for x=1,10 do
        if not reset then cVal=hbv_Skins_GetFrameVar("Frame", "AUTOCLOSE", x) end
        if cVal~=HealBot_AutoCloseFrame[x] then
            HealBot_AutoCloseFrame[x]=cVal
            HealBot_Panel_setAutoClose(x)
            HealBot_Action_ShowHideFrameOption(x)
            HealBot_Timers_Set("LAST","CheckFramesOnCombat")
            HealBot_Timers_Set("LAST","CheckAutoClose")
        end
    end
end

function HealBot_Action_ResetGlobalDimming()
      --HealBot_setCall("HealBot_Action_ResetGlobalDimming")
    if hbv_Skins_GetVar("General", "GLOBALDIMMING")>1 then
        HealBot_Action_luVars["GlobalDimming"]=hbv_Skins_GetVar("General", "GLOBALDIMMING")
        HealBot_Action_luVars["GlobalDimmingEnabled"]=true
    else
        HealBot_Action_luVars["GlobalDimming"]=0
        HealBot_Action_luVars["GlobalDimmingEnabled"]=false
    end
    HealBot_Timers_Set("LAST","BarColourAlphaSetFunc")
    HealBot_Action_ResetOpacity(true)
end

function HealBot_Action_UpdateFrameHeaderOpacity(f)
      --HealBot_setCall("HealBot_Action_UpdateFrameHeaderOpacity")
    if HealBot_Action_luVars["GlobalDimmingEnabled"] and not HealBot_Action_IsFrameActive(f) then
        grpFrameBar[f]:SetStatusBarColor(hbv_Skins_GetFrameVar("FrameAliasBar", "R", f),
                                         hbv_Skins_GetFrameVar("FrameAliasBar", "G", f),
                                         hbv_Skins_GetFrameVar("FrameAliasBar", "B", f),
                                        (hbv_Skins_GetFrameVar("FrameAliasBar", "A", f)/HealBot_Action_luVars["GlobalDimming"]));
    else
        grpFrameBar[f]:SetStatusBarColor(hbv_Skins_GetFrameVar("FrameAliasBar", "R", f),
                                         hbv_Skins_GetFrameVar("FrameAliasBar", "G", f),
                                         hbv_Skins_GetFrameVar("FrameAliasBar", "B", f),
                                         hbv_Skins_GetFrameVar("FrameAliasBar", "A", f));
    end
end

function HealBot_Action_UpdateHeaderOpacity(header)
      --HealBot_setCall("HealBot_Action_UpdateHeaderOpacity")
    if header.frame>0 then
        if HealBot_Action_luVars["GlobalDimmingEnabled"] and not HealBot_Action_IsFrameActive(header.frame) then
            header.bar:SetStatusBarColor(hbv_Skins_GetFrameVar("HeadBar", "R", header.frame),
                                         hbv_Skins_GetFrameVar("HeadBar", "G", header.frame),
                                         hbv_Skins_GetFrameVar("HeadBar", "B", header.frame),
                                        (hbv_Skins_GetFrameVar("HeadBar", "A", header.frame)/HealBot_Action_luVars["GlobalDimming"]))
            header.bar.txt:SetTextColor(hbv_Skins_GetFrameVar("HeadText", "R", header.frame),
                                        hbv_Skins_GetFrameVar("HeadText", "G", header.frame),
                                        hbv_Skins_GetFrameVar("HeadText", "B", header.frame),
                                       (hbv_Skins_GetFrameVar("HeadText", "A", header.frame)/HealBot_Action_luVars["GlobalDimming"]))
        else
            header.bar:SetStatusBarColor(hbv_Skins_GetFrameVar("HeadBar", "R", header.frame),
                                         hbv_Skins_GetFrameVar("HeadBar", "G", header.frame),
                                         hbv_Skins_GetFrameVar("HeadBar", "B", header.frame),
                                         hbv_Skins_GetFrameVar("HeadBar", "A", header.frame))
            header.bar.txt:SetTextColor(hbv_Skins_GetFrameVar("HeadText", "R", header.frame),
                                        hbv_Skins_GetFrameVar("HeadText", "G", header.frame),
                                        hbv_Skins_GetFrameVar("HeadText", "B", header.frame),
                                        hbv_Skins_GetFrameVar("HeadText", "A", header.frame))
        end
    end
end

local function HealBot_Action_AuxSetHighlightBar(button)
      --HealBot_setCall("HealBot_Action_AuxSetHighlightBar", button)
    HealBot_Aux_UpdateHighlightBar(button) 
    if HealBot_Action_AuxAssigns["NameOverlayHighlight"][button.frame] then
        HealBot_Aux_UpdateNameOverLay(button, 5, true)
    end
    if HealBot_Action_AuxAssigns["HealthOverlayHighlight"][button.frame] then
        HealBot_Aux_UpdateHealthOverLay(button, 5, true)
    end
end

local function HealBot_Action_AuxClearHighlightBar(button)
      --HealBot_setCall("HealBot_Action_AuxClearHighlightBar", button)
    HealBot_Aux_ClearHighlightBar(button) 
    if HealBot_Action_AuxAssigns["NameOverlayHighlight"][button.frame] then
        HealBot_Aux_UpdateNameOverLay(button, 5, false)
    end
    if HealBot_Action_AuxAssigns["HealthOverlayHighlight"][button.frame] then
        HealBot_Aux_UpdateHealthOverLay(button, 5, false)
    end
end

function HealBot_Action_ValidComboTypes(cType)
    if cType == "Enabled" or cType == "Enemy" or cType == "Emerg" then
        return true
    end
    return false
end

function HealBot_Action_HealUnit_OnEnter(self)
      --HealBot_setCall("HealBot_Action_HealUnit_OnEnter", self)
    grpFrameBar[self.frame].active=true
    if self.unit then
        self.mouseover=true
        if hbv_Skins_GetFrameBoolean("Icons", "SHOWDIR", self.frame) and hbv_Skins_GetFrameBoolean("Icons", "SHOWDIRMOUSE", self.frame) then 
            HealBot_Action_ShowDirectionArrow(self) 
        end
        HealBot_Action_SetActiveButton(self.id)
        if HealBot_Globals.ShowTooltip and HealBot_Data["TIPUSE"] then
            HealBot_Data["TIPBUTTON"]=self
            if HealBot_Globals.ShowGameUnitInfo then
                HealBot_Data["TIPTYPE"]="WoWUnit"
            elseif not UnitIsFriend("player",self.unit) then
                HealBot_Data["TIPTYPE"]="Enemy"
            else
                HealBot_Data["TIPTYPE"]="Enabled"
            end
            HealBot_setTooltipUpdateNow()
        end    
        if hbAdaptive["Highlight"] then
            if hbAdaptiveOrderName["Highlight"]<self.adaptive.current then
                self.adaptive.current=hbAdaptiveOrderName["Highlight"]
                HealBot_Action_UpdateBackground(self)
            end
            self.adaptive[hbAdaptiveOrderName["Highlight"]]=true
        end
        if self.aux then
            HealBot_Action_AuxSetHighlightBar(self)
        end
    end
    HealBot_Action_UpdateGlobalDimming(self.frame)
end

function HealBot_Action_HealUnit_OnLeave(self)
      --HealBot_setCall("HealBot_Action_HealUnit_OnLeave", self)
    grpFrameBar[self.frame].active=false
    if self.unit then
        HealBot_Action_HideTooltip(self);
        self.mouseover=false
        HealBot_Action_SetActiveButton(0)
        HealBot_Action_AdaptiveNextActive(self, hbAdaptiveOrderName["Highlight"], true)
        if self.status and self.status.dirarrowshown>0 and hbv_Skins_GetFrameBoolean("Icons", "SHOWDIRMOUSE", self.frame) then
            HealBot_Action_HideDirectionArrow(self)
        end
        if self and self.aux then 
            HealBot_Action_AuxClearHighlightBar(self)
        end
    end
    HealBot_Action_UpdateGlobalDimming(0)
   -- ClearOverrideBindings(HealBot_Action)
end

function HealBot_Action_EmergUnit_OnEnter(self)
      --HealBot_setCall("HealBot_Action_EmergUnit_OnEnter", self)
    grpFrameBar[self.frame].active=true
    HealBot_Action_SetActiveButton(self.id)
    if HealBot_Globals.ShowTooltip and HealBot_Data["TIPUSE"] then
        xButton=HealBot_Buttons[self.id]
        if xButton and UnitExists(xButton.unit) then
            HealBot_Data["TIPBUTTON"]=xButton
            if HealBot_Globals.ShowGameUnitInfo then
                HealBot_Data["TIPTYPE"]="WoWUnit"
            else
                HealBot_Data["TIPTYPE"]="Emerg"
            end
            HealBot_setTooltipUpdateNow()
        end
    end
    HealBot_Action_UpdateGlobalDimming(self.frame)
end

function HealBot_Action_EmergUnit_OnLeave(self)
      --HealBot_setCall("HealBot_Action_EmergUnit_OnLeave", self)
    grpFrameBar[self.frame].active=false
    HealBot_Action_SetActiveButton(0)
    if HealBot_Data["TIPBUTTON"] then HealBot_Action_HideTooltip(HealBot_Data["TIPBUTTON"]) end
    HealBot_Action_UpdateGlobalDimming(0)
end

function HealBot_Action_BuffIcon_OnEnter(button, id)
    grpFrameBar[button.frame].active=true
    HealBot_Options_BuffIconTooltip(button, id)
    HealBot_Action_UpdateGlobalDimming(button.frame)
end

function HealBot_Action_BuffIcon_OnLeave(button, id)
    grpFrameBar[button.frame].active=false
    HealBot_Action_HideTooltipFrame()
    HealBot_Action_UpdateGlobalDimming(0)
end

function HealBot_Action_DebuffIcon_OnEnter(button, id)
    grpFrameBar[button.frame].active=true
    HealBot_Options_DebuffIconTooltip(button, id)
    HealBot_Action_UpdateGlobalDimming(button.frame)
end

function HealBot_Action_DebuffIcon_OnLeave(button, id)
    grpFrameBar[button.frame].active=false
    HealBot_Action_HideTooltipFrame()
    HealBot_Action_UpdateGlobalDimming(0)
end

function HealBot_Action_OptionsButton_OnClick(self)
      --HealBot_setCall("HealBot_Action_OptionsButton_OnClick")
    HealBot_Options_ShowHide()
end

local usedSmartCast=false
local uLevel=0

function HealBot_Action_UseSmartCast(self,button)
      --HealBot_setCall("HealBot_Action_UseSmartCast", self)
    local sName=HealBot_Action_SmartCast(button);
    if sName then
        if HealBot_Spells_KnownByName(sName) then
            if HEALBOT_GAME_VERSION<4 then
                uLevel=button.level
                if uLevel and uLevel>0 and HealBot_Data["PCLASSTRIM"] then
                    if HealBot_Data["PCLASSTRIM"] == "PRIE" then
                        if sName == HealBot_WoWAPI_SpellName(HBC_POWER_WORD_FORTITUDE) then
                            if uLevel<12 then
                                sName=HealBot_Init_retRank(sName, 1)
                            elseif uLevel<24 then
                                sName=HealBot_Init_retRank(sName, 2)
                            elseif uLevel<36 then
                                sName=HealBot_Init_retRank(sName, 3)
                            elseif uLevel<48 then
                                sName=HealBot_Init_retRank(sName, 4)
                            elseif uLevel<60 then
                                sName=HealBot_Init_retRank(sName, 5)
                            elseif uLevel<70 then
                                sName=HealBot_Init_retRank(sName, 6)
                            elseif uLevel<80 then
                                sName=HealBot_Init_retRank(sName, 7)
                            else
                                sName=HealBot_Init_retRank(sName, 8)
                            end
                        elseif sName == HealBot_WoWAPI_SpellName(HBC_DIVINE_SPIRIT) then
                            if uLevel<40 then
                                sName=HealBot_Init_retRank(sName, 1)
                            elseif uLevel<50 then
                                sName=HealBot_Init_retRank(sName, 2)
                            elseif uLevel<60 then
                                sName=HealBot_Init_retRank(sName, 3)
                            elseif uLevel<70 then
                                sName=HealBot_Init_retRank(sName, 4)
                            elseif uLevel<80 then
                                sName=HealBot_Init_retRank(sName, 5)
                            else
                                sName=HealBot_Init_retRank(sName, 6)
                            end
                        elseif sName == HealBot_WoWAPI_SpellName(HBC_SHADOW_PROTECTION) then
                            if uLevel<42 then
                                sName=HealBot_Init_retRank(sName, 1)
                            elseif uLevel<56 then
                                sName=HealBot_Init_retRank(sName, 2)
                            elseif uLevel<68 then
                                sName=HealBot_Init_retRank(sName, 3)
                            elseif uLevel<76 then
                                sName=HealBot_Init_retRank(sName, 4)
                            else
                                sName=HealBot_Init_retRank(sName, 5)
                            end
                        end
                    elseif HealBot_Data["PCLASSTRIM"] == "DRUI" then
                        if sName == HealBot_WoWAPI_SpellName(HEALBOT_MARK_OF_THE_WILD) then
                            if uLevel<10 then
                                sName=HealBot_Init_retRank(sName, 1)
                            elseif uLevel<20 then
                                sName=HealBot_Init_retRank(sName, 2)
                            elseif uLevel<30 then
                                sName=HealBot_Init_retRank(sName, 3)
                            elseif uLevel<40 then
                                sName=HealBot_Init_retRank(sName, 4)
                            elseif uLevel<50 then
                                sName=HealBot_Init_retRank(sName, 5)
                            elseif uLevel<60 then
                                sName=HealBot_Init_retRank(sName, 6)
                            elseif uLevel<70 then
                                sName=HealBot_Init_retRank(sName, 7)
                            elseif uLevel<80 then
                                sName=HealBot_Init_retRank(sName, 8)
                            else
                                sName=HealBot_Init_retRank(sName, 9)
                            end
                        elseif sName == HealBot_WoWAPI_SpellName(HBC_THORNS) then
                            if uLevel<14 then
                                sName=HealBot_Init_retRank(sName, 1)
                            elseif uLevel<24 then
                                sName=HealBot_Init_retRank(sName, 2)
                            elseif uLevel<34 then
                                sName=HealBot_Init_retRank(sName, 3)
                            elseif uLevel<44 then
                                sName=HealBot_Init_retRank(sName, 4)
                            elseif uLevel<54 then
                                sName=HealBot_Init_retRank(sName, 5)
                            elseif uLevel<64 then
                                sName=HealBot_Init_retRank(sName, 6)
                            elseif uLevel<74 then
                                sName=HealBot_Init_retRank(sName, 7)
                            else
                                sName=HealBot_Init_retRank(sName, 8)
                            end
                        end
                    elseif HealBot_Data["PCLASSTRIM"] == "PALA" then
                        if sName == HealBot_WoWAPI_SpellName(HBC_BLESSING_OF_LIGHT) and HEALBOT_GAME_VERSION<3 then
                            if uLevel<50 then
                                sName=HealBot_Init_retRank(sName, 1)
                            elseif uLevel<60 then
                                sName=HealBot_Init_retRank(sName, 2)
                            elseif uLevel<69 then
                                sName=HealBot_Init_retRank(sName, 3)
                            else
                                sName=HealBot_Init_retRank(sName, 4)
                            end
                        elseif sName == HealBot_WoWAPI_SpellName(HBC_BLESSING_OF_MIGHT) then
                            if uLevel<12 then
                                sName=HealBot_Init_retRank(sName, 1)
                            elseif uLevel<22 then
                                sName=HealBot_Init_retRank(sName, 2)
                            elseif uLevel<32 then
                                sName=HealBot_Init_retRank(sName, 3)
                            elseif uLevel<42 then
                                sName=HealBot_Init_retRank(sName, 4)
                            elseif uLevel<52 then
                                sName=HealBot_Init_retRank(sName, 5)
                            elseif uLevel<60 then
                                sName=HealBot_Init_retRank(sName, 6)
                            elseif uLevel<70 then
                                sName=HealBot_Init_retRank(sName, 7)
                            elseif uLevel<73 then
                                sName=HealBot_Init_retRank(sName, 8)
                            elseif uLevel<79 then
                                sName=HealBot_Init_retRank(sName, 9)
                            else
                                sName=HealBot_Init_retRank(sName, 10)
                            end
                        elseif sName == HealBot_WoWAPI_SpellName(HBC_BLESSING_OF_WISDOM) then
                            if uLevel<24 then
                                sName=HealBot_Init_retRank(sName, 1)
                            elseif uLevel<34 then
                                sName=HealBot_Init_retRank(sName, 2)
                            elseif uLevel<44 then
                                sName=HealBot_Init_retRank(sName, 3)
                            elseif uLevel<54 then
                                sName=HealBot_Init_retRank(sName, 4)
                            elseif uLevel<60 then
                                sName=HealBot_Init_retRank(sName, 5)
                            elseif uLevel<65 then
                                sName=HealBot_Init_retRank(sName, 6)
                            elseif uLevel<71 then
                                sName=HealBot_Init_retRank(sName, 7)
                            elseif uLevel<77 then
                                sName=HealBot_Init_retRank(sName, 8)
                            else
                                sName=HealBot_Init_retRank(sName, 9)
                            end
                        elseif sName == HealBot_WoWAPI_SpellName(HBC_BLESSING_OF_SANCTUARY) and HEALBOT_GAME_VERSION<3 then
                            if uLevel<40 then
                                sName=HealBot_Init_retRank(sName, 1)
                            elseif uLevel<50 then
                                sName=HealBot_Init_retRank(sName, 2)
                            elseif uLevel<60 then
                                sName=HealBot_Init_retRank(sName, 3)
                            elseif uLevel<70 then
                                sName=HealBot_Init_retRank(sName, 4)
                            else
                                sName=HealBot_Init_retRank(sName, 5)
                            end
                        end
                    elseif HealBot_Data["PCLASSTRIM"] == "SHAM" then
                        if sName == HealBot_WoWAPI_SpellName(HBC_EARTH_SHIELD) then
                            if uLevel<60 then
                                sName=HealBot_Init_retRank(sName, 1)
                            elseif uLevel<70 then
                                sName=HealBot_Init_retRank(sName, 2)
                            elseif uLevel<75 then
                                sName=HealBot_Init_retRank(sName, 3)
                            elseif uLevel<80 then
                                sName=HealBot_Init_retRank(sName, 4)
                            else
                                sName=HealBot_Init_retRank(sName, 5)
                            end
                        end
                    elseif HealBot_Data["PCLASSTRIM"] == "MAGE" then
                        if sName == HealBot_WoWAPI_SpellName(HEALBOT_ARCANE_BRILLIANCE) then
                            if uLevel<14 then
                                sName=HealBot_Init_retRank(sName, 1)
                            elseif uLevel<28 then
                                sName=HealBot_Init_retRank(sName, 2)
                            elseif uLevel<42 then
                                sName=HealBot_Init_retRank(sName, 3)
                            elseif uLevel<56 then
                                sName=HealBot_Init_retRank(sName, 4)
                            elseif uLevel<70 then
                                sName=HealBot_Init_retRank(sName, 5)
                            elseif uLevel<80 then
                                sName=HealBot_Init_retRank(sName, 6)
                            else
                                sName=HealBot_Init_retRank(sName, 7)
                            end
                        end
                    end
                end
            end
            self:SetAttribute("helpbutton1", "heal1");
            self:SetAttribute("type-heal1", "spell");
            self:SetAttribute("spell-heal1", sName);
        else
            local mId=GetMacroIndexByName(sName)
            if mId ~= 0 then
                local _,_,mText=GetMacroInfo(mId)
                if string.find(mText,"hbtargetpet") then
                    local pet=HealBot_UnitPet(button.unit)
                    if pet and UnitExists(pet) then
                        mText=string.gsub(mText,"hbtargetpet",pet)
                    end
                end
                mText=string.gsub(mText,"hbtarget",button.unit)
                mText=string.gsub(mText,"hbtargettarget",button.unit.."target")
                mText=string.gsub(mText,"hbtargettargettarget",button.unit.."targettarget")
                self:SetAttribute("type1","macro")
                self:SetAttribute("macrotext1", mText)
            else
                self:SetAttribute("helpbutton1", "item1");
                self:SetAttribute("type-item1", "item");
                self:SetAttribute("item-item1", sName);
            end
        end
        usedSmartCast=true;
    end
end

function HealBot_Action_ButtonPreClick(self,mButton,button)
      --HealBot_setCall("HealBot_Action_ButtonPreClick", self)
    usedSmartCast=false;
    if not HealBot_Data["UILOCK"] and button and self.id<999 and UnitExists(button.unit) and not UnitIsEnemy("player",button.unit) then
        HealBot_setLuVars("TargetUnitID", button.unit)
        if mButton == "LeftButton" and HealBot_Globals.SmartCast and not IsModifierKeyDown() then
            HealBot_Action_UseSmartCast(self,button)
        end
    end
end

function HealBot_Action_PreClick(self,button)
      --HealBot_setCall("HealBot_Action_PreClick", self)
    HealBot_Action_ButtonPreClick(self,button,self)
end

function HealBot_EmergAction_PreClick(self,button)
      --HealBot_setCall("HealBot_EmergAction_PreClick", self)
    HealBot_Action_ButtonPreClick(self,button,HealBot_Buttons[self.id])
end

function HealBot_Action_PostClick(self,button)
      --HealBot_setCall("HealBot_Action_PostClick", self)
    if self.id == 999 then
        HealBot_Panel_clickToFocus("hide")
        HealBot_nextRecalcParty(3)
    elseif usedSmartCast then
        HealBot_Action_SetButtonAttrib(self,"Left","","Enabled",1,self.unit)
    end
end

function HealBot_EmergAction_PostClick(self,button)
      --HealBot_setCall("HealBot_EmergAction_PostClick", self)
    xButton=HealBot_Buttons[self.id]
    if self.id == 999 then
        HealBot_Panel_clickToFocus("hide")
        HealBot_nextRecalcParty(3)
    elseif xButton and usedSmartCast then
        HealBot_Action_SetButtonAttrib(self,"Left","","Emerg",1,xButton.unit)
    end
end

function HealBot_Action_OnLoad(self)
      --HealBot_setCall("HealBot_Action_OnLoad")
    self:SetScript("PreClick", HealBot_Action_PreClick); 
    self:SetScript("PostClick", HealBot_Action_PostClick)
end

function HealBot_Action_EmergOnLoad(self)
      --HealBot_setCall("HealBot_Action_EmergOnLoad")
    self:SetScript("PreClick", HealBot_EmergAction_PreClick); 
    self:SetScript("PostClick", HealBot_EmergAction_PostClick)
end

function HealBot_Action_ButtonRegisterForClicks(button)
      --HealBot_setCall("HealBot_Action_ButtonRegisterForClicks", button)
    if HealBot_Action_luVars["TestBarsOn"] then
        button:EnableMouse(false)
        button.regClicks=false
    else
        button:EnableMouse(true)
        if HealBot_Config_Spells.ButtonCastMethod == 1 then
            button:RegisterForClicks("AnyDown");
        else
            button:RegisterForClicks("AnyUp");
        end
        button.regClicks=true
    end
end

function HealBot_Action_SetFrameColours(frame)
      --HealBot_setCall("HealBot_Action_SetFrameColours")
    if HealBot_Action_luVars["GlobalDimmingEnabled"] and not HealBot_Action_IsFrameActive(frame.id) then
        frame:SetBackdropColor(
        hbv_Skins_GetFrameVar("Frame", "BACKR", frame.id),
        hbv_Skins_GetFrameVar("Frame", "BACKG", frame.id),
        hbv_Skins_GetFrameVar("Frame", "BACKB", frame.id),
       (hbv_Skins_GetFrameVar("Frame", "BACKA", frame.id)/HealBot_Action_luVars["GlobalDimming"]));
        frame:SetBackdropBorderColor(
        hbv_Skins_GetFrameVar("Frame", "BORDERR", frame.id),
        hbv_Skins_GetFrameVar("Frame", "BORDERG", frame.id),
        hbv_Skins_GetFrameVar("Frame", "BORDERB", frame.id),
       (hbv_Skins_GetFrameVar("Frame", "BORDERA", frame.id)/HealBot_Action_luVars["GlobalDimming"]));
    else
        frame:SetBackdropColor(
        hbv_Skins_GetFrameVar("Frame", "BACKR", frame.id),
        hbv_Skins_GetFrameVar("Frame", "BACKG", frame.id),
        hbv_Skins_GetFrameVar("Frame", "BACKB", frame.id),
        hbv_Skins_GetFrameVar("Frame", "BACKA", frame.id))
        frame:SetBackdropBorderColor(
        hbv_Skins_GetFrameVar("Frame", "BORDERR", frame.id),
        hbv_Skins_GetFrameVar("Frame", "BORDERG", frame.id),
        hbv_Skins_GetFrameVar("Frame", "BORDERB", frame.id),
        hbv_Skins_GetFrameVar("Frame", "BORDERA", frame.id))
    end
end

function HealBot_Action_SetFrameTextColours(frame)
      --HealBot_setCall("HealBot_Action_SetFrameTextColours")
    if HealBot_Action_luVars["GlobalDimmingEnabled"] and not HealBot_Action_IsFrameActive(frame) then
        grpFrameText[frame]:SetTextColor(hbv_Skins_GetFrameVar("FrameAlias", "R", frame),
                                         hbv_Skins_GetFrameVar("FrameAlias", "G", frame),
                                         hbv_Skins_GetFrameVar("FrameAlias", "B", frame),
                                        (hbv_Skins_GetFrameVar("FrameAlias", "A", frame)/HealBot_Action_luVars["GlobalDimming"]))
    else
        grpFrameText[frame]:SetTextColor(hbv_Skins_GetFrameVar("FrameAlias", "R", frame),
                                         hbv_Skins_GetFrameVar("FrameAlias", "G", frame),
                                         hbv_Skins_GetFrameVar("FrameAlias", "B", frame),
                                         hbv_Skins_GetFrameVar("FrameAlias", "A", frame))
    end
end

function HealBot_Action_SetFrameCols(frame)
      --HealBot_setCall("HealBot_Action_SetFrameCols")
    HealBot_Action_SetFrameColours(grpFrame[frame])
end

local HealBot_Action_Init={}
function HealBot_Action_OnShow(self)
      --HealBot_setCall("HealBot_Action_OnShow", self)
    if HealBot_Action_luVars["FrameInitDone"] then
        if not HealBot_Action_Init[self.id] then
            HealBot_Action_SetFrameColours(self)
            HealBot_Action_Init[self.id]=true
            HealBot_Action_SetAlias(self.id)
            HealBot_Action_SetAliasFontSize(self.id)
        elseif hbUpdateFramesOpacity[frame] then
            HealBot_Action_SetFrameColours(self)
        end
    end
end

function HealBot_Action_SetAlias(frame)
      --HealBot_setCall("HealBot_Action_SetAlias")
    if hbv_Skins_GetFrameBoolean("FrameAlias", "SHOW", frame) then
        grpFrameText[frame]:SetText(hbv_Skins_GetFrameVar("FrameAlias", "NAME", frame))
    else
        grpFrameText[frame]:SetText("")
    end
end

function HealBot_Action_SetAliasFontSize(frame)
      --HealBot_setCall("HealBot_Action_SetAliasFontSize")
    HealBot_Media_UpdateFont(grpFrameText[frame],
                             hbv_Skins_GetFrameVar("FrameAlias", "FONT", frame),
                             ceil(hbv_Skins_GetFrameVar("FrameAlias", "SIZE", frame)*
                                  hbv_Skins_GetFrameVar("Frame", "SCALE", frame)),
                                  hbv_Skins_GetFrameVar("FrameAlias", "OFFSET", frame),
                                  "Action_SetAliasFontSize - FrameAlias")
    grpFrameText[frame]:SetTextHeight(ceil(hbv_Skins_GetFrameVar("FrameAlias", "SIZE", frame)*
                                           hbv_Skins_GetFrameVar("Frame", "SCALE", frame)))
    grpFrameText[frame]:ClearAllPoints();
    grpFrameText[frame]:SetPoint("CENTER",0,hbv_Skins_GetFrameVar("FrameAlias", "OFFSET", frame));
    HealBot_Action_SetFrameTextColours(frame)
end

function  HealBot_Action_ResetFrameAlias()
      --HealBot_setCall("HealBot_Action_ResetFrameAlias")
    for j=1,10 do
        HealBot_Action_SetAlias(j)
        HealBot_Action_SetAliasFontSize(j)
    end
end

local modKey=1 -- Not Locked
function HealBot_Action_IsFrameLocked(frame)
      --HealBot_setCall("HealBot_Action_IsFrameLocked")
    modKey=1 -- Not Locked
    if hbv_Skins_GetFrameVar("Frame", "LOCKED", frame)>2 then
        if IsAltKeyDown() then 
            if IsControlKeyDown() then
                modKey=5
            else
                modKey=4
            end
        elseif IsControlKeyDown() then
            modKey=3
        end
    end
    if (HealBot_Action_luVars["TestBarsOn"] and not hbv_Skins_GetFrameBoolean("StickyFrames", "STUCK", frame)) 
      or hbv_Skins_GetFrameVar("Frame", "LOCKED", frame) == modKey then
        return false
    else
        return true
    end
end

function HealBot_Action_LockFrame(self)
      --HealBot_setCall("HealBot_Action_LockFrame", self)
    if not HealBot_Action_IsFrameLocked(self.id) then
        HealBot_Action_luVars["FrameMoving"]=self
        HealBot_StartMoving(self, self.id);
    elseif hbv_Skins_GetBoolean("General", "STICKYFRAME") and self.id>1 then
        if hbv_Skins_GetFrameBoolean("StickyFrames", "STUCK", self.id) and
           HealBot_Action_FrameIsVisible(hbv_Skins_GetFrameVar("StickyFrames", "STUCKTO", self.id)) then
            HealBot_Action_LockFrame(grpFrame[hbv_Skins_GetFrameVar("StickyFrames", "STUCKTO", self.id)])
        end
    end
end

function HealBot_Action_OnMouseDown(self,button)
      --HealBot_setCall("HealBot_Action_OnMouseDown", self)
    if button == "LeftButton" then
        HealBot_Action_LockFrame(self)
    end
end

local hbFrameTags={[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false,}
local function HealBot_Action_ToggleFrameTag(self)
      --HealBot_setCall("HealBot_Action_ToggleFrameTag", self)
    if not HealBot_Globals.HideUnlockedTag then
        if not HealBot_Data["UILOCK"] then
            if hbFrameTags[self.id] then
                hbFrameTags[self.id]=false
            else
                hbFrameTags[self.id]=true
            end
            HealBot_Timers_nextRecalcAll()
        else
            HealBot_Timers_Set("OOC","ModKey")
        end
    end
end

function HealBot_Action_OnEnter(self)
      --HealBot_setCall("HealBot_Action_OnEnter", self)
    HealBot_Action_luVars["ActiveFrameID"]=self.id
    modKey=1
    if hbv_Skins_GetFrameVar("Frame", "LOCKED", self.id)>2 then
        if IsAltKeyDown() then 
            if IsControlKeyDown() then
                modKey=5
            else
                modKey=4
            end
        elseif IsControlKeyDown() then
            modKey=3
        end
    end
    if hbv_Skins_GetFrameVar("Frame", "LOCKED", self.id) == modKey then
        if not hbFrameTags[self.id] then
            HealBot_Action_ToggleFrameTag(self)
        end
    elseif hbFrameTags[self.id] then
        HealBot_Action_ToggleFrameTag(self)
    end
    HealBot_Action_luVars["ActiveFrame"]=self
    HealBot_Action_UpdateGlobalDimming(self.id)
end

function HealBot_Action_OnLeave(self)
      --HealBot_setCall("HealBot_Action_OnLeave", self)
    HealBot_Action_luVars["ActiveFrameID"]=0
    HealBot_Action_luVars["ActiveFrame"]=false
    if hbFrameTags[self.id] then
        HealBot_Action_ToggleFrameTag(self)
    end
    HealBot_Action_UpdateGlobalDimming(0)
end

function HealBot_Action_ModKey()
      --HealBot_setCall("HealBot_Action_ModKey")
    if HealBot_Action_luVars["ActiveFrame"] then
        HealBot_Action_OnEnter(HealBot_Action_luVars["ActiveFrame"])
        HealBot_Timers_nextRecalcAll()
    end
end

function HealBot_Action_CanMove(id)
      --HealBot_setCall("HealBot_Action_CanMove")
    if HealBot_Globals.HideUnlockedTag then
        return false
    else
        return hbFrameTags[id]
    end
end

function HealBot_Action_OnMouseUp(self,button)
      --HealBot_setCall("HealBot_Action_IsPlayersDead", self)
    if button == "LeftButton" and HealBot_Action_luVars["FrameMoving"] then
        HealBot_StopMoving(HealBot_Action_luVars["FrameMoving"],HealBot_Action_luVars["FrameMoving"].id);
        HealBot_Action_luVars["FrameMoving"]=false
    elseif button == "RightButton" and HealBot_Globals.RightButtonOptions then
        HealBot_Action_OptionsButton_OnClick();
    end
end

function HealBot_Action_Toggle_Enabled(unit)
      --HealBot_setCall("HealBot_Action_Toggle_Enabled", nil, nil, unit)
    _,xButton,pButton=HealBot_UnitID(unit)
    local xGUID=UnitGUID(unit)
    if HealBot_AlwaysEnabled[xGUID] then
        HealBot_AlwaysEnabled[xGUID]=nil
    else
        HealBot_AlwaysEnabled[xGUID]=true
    end    
    if xButton then HealBot_RefreshUnit(xButton) end
    if pButton then HealBot_RefreshUnit(pButton) end
    --HealBot_Timers_Set("SKINS","SkinsFormat")
end

function HealBot_Action_AlwaysEnabled(guid)
      --HealBot_setCall("HealBot_Action_AlwaysEnabled", nil, guid)
    return HealBot_AlwaysEnabled[guid]
end

local function HealBot_Action_IsPlayersDead(button)
      --HealBot_setCall("HealBot_Action_IsPlayersDead", button)
    if button.status.isdead and button.status.range>-1 then
        return true
    else
        return false
    end
end

function HealBot_Action_UseMassRes()
      --HealBot_setCall("HealBot_Action_UseMassRes")
    local nDead=0
    for _,xButton in pairs(HealBot_Unit_Button) do
        if not xButton.status.duplicate then
            if HealBot_Action_IsPlayersDead(xButton) then
                nDead=nDead+1
                if nDead>1 then 
                    return true
                end
            end
        end
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        if not xButton.status.duplicate then
            if HealBot_Action_IsPlayersDead(xButton) then
                nDead=nDead+1
                if nDead>1 then 
                    return true
                end
            end
        end
    end
    return false
end

local arResSpell=false
HealBot_Action_luVars["lastMassRes"]=0
function HealBot_Action_retResSpell(button)
      --HealBot_setCall("HealBot_Action_retResSpell", button)
    arResSpell=false
    if HealBot_Init_retSmartCast_MassRes() then
        if HealBot_Action_luVars["lastMassRes"]>(GetTime()-2) then
            arResSpell=HealBot_Init_retSmartCast_MassRes()
        else
            if button.status.range<1 or HealBot_Action_UseMassRes() then
                arResSpell=HealBot_Init_retSmartCast_MassRes();
                HealBot_Action_luVars["lastMassRes"]=GetTime()
            else
                arResSpell=HealBot_Init_retSmartCast_Res();
            end
        end
    else
        arResSpell=HealBot_Init_retSmartCast_Res();
    end
    return arResSpell
end

local scSpell,scId=false,0
function HealBot_Action_SmartCast(button)
      --HealBot_setCall("HealBot_Action_StickyFrameClearStuck", button)
    if button.player and button.status.isdead then return nil; end
    scSpell=false
 
    if HealBot_Globals.SmartCastRes and button.status.isdead then
        scSpell=HealBot_Action_retResSpell(button)
    elseif HealBot_Aura_IsCureSpell(button) and HealBot_Globals.SmartCastDebuff then
        scSpell=button.aura.debuff.curespell
    elseif button.aura.buff.missingbuff and HealBot_Globals.SmartCastBuff then
        if button.aura.buff.missingbuff == HEALBOT_WELL_FED then
            if HealBot_Config_Buffs.WellFedItem and HealBot_IsKnownItem(HealBot_Config_Buffs.WellFedItem) then
                scSpell=HealBot_Config_Buffs.WellFedItem
            elseif HealBot_Config_Buffs.BackupWellFedItem and HealBot_IsKnownItem(HealBot_Config_Buffs.BackupWellFedItem) then
                scSpell=HealBot_Config_Buffs.BackupWellFedItem
            end
        elseif button.aura.buff.missingbuff == HEALBOT_MANA_DRINK then
            if HealBot_Config_Buffs.ManaDrinkItem and HealBot_IsKnownItem(HealBot_Config_Buffs.ManaDrinkItem) then
                scSpell=HealBot_Config_Buffs.ManaDrinkItem
            elseif HealBot_Config_Buffs.BackupManaDrinkItem and HealBot_IsKnownItem(HealBot_Config_Buffs.BackupManaDrinkItem) then
                scSpell=HealBot_Config_Buffs.BackupManaDrinkItem
            end
        else
            scSpell=button.aura.buff.missingbuff
        end
    end

    if scSpell and HealBot_Range_SpellInRange(button,scSpell) then
        return scSpell
    else
        return nil
    end
end

function HealBot_Action_StickyFrameClearStuck(frame)
        --HealBot_setCall("HealBot_Action_StickyFrameClearStuck")
    if frame then
        hbv_Skins_SetFrameVar(false, "StickyFrames", "STUCK", frame)
    else
        for x=1,10 do
            hbv_Skins_SetFrameVar(false, "StickyFrames", "STUCK", x)
            hbStickyFrameGetCoords[x]=false
        end
    end
end

function HealBot_Action_hbStickyFrameGetCoords(frame)
        --HealBot_setCall("HealBot_Action_hbStickyFrameGetCoords")
    return hbStickyFrameGetCoords[frame]
end

local vSticktSetPointX,vSticktSetPointY,vSticktSetPointOptionUpd=0,0,false
function HealBot_Action_StickyFrameSetPoint(frame,stuckTo,stuckPoint,stuckToPoint,HBframe,cf)
        --HealBot_setCall("HealBot_Action_StickyFrameSetPoint")
    hbStickyFrameGetCoords[frame]=true
    vSticktSetPointX,vSticktSetPointY=0,0
    if (stuckPoint == "BOTTOMLEFT" or stuckPoint == "BOTTOM" or stuckPoint == "BOTTOMRIGHT") and
       (stuckToPoint == "TOPLEFT" or stuckToPoint == "TOP" or stuckToPoint == "TOPRIGHT") then
        if hbv_Skins_GetFrameBoolean("FrameAlias", "SHOW", stuckTo) then
            vSticktSetPointY=hbv_Skins_GetFrameVar("FrameAliasBar", "HEIGHT", stuckTo)
        end
    elseif (stuckToPoint == "BOTTOMLEFT" or stuckToPoint == "BOTTOM" or stuckToPoint == "BOTTOMRIGHT") and
           (stuckPoint == "TOPLEFT" or stuckPoint == "TOP" or stuckPoint == "TOPRIGHT") then
        if hbv_Skins_GetFrameBoolean("FrameAlias", "SHOW", frame) then
            vSticktSetPointY=0-hbv_Skins_GetFrameVar("FrameAliasBar", "HEIGHT", frame)
        end
    end
    vSticktSetPointX=vSticktSetPointX+hbv_Skins_GetFrameVar("Frame", "SFOFFSETH", frame)
    vSticktSetPointY=vSticktSetPointY+hbv_Skins_GetFrameVar("Frame", "SFOFFSETV", frame)
    HBframe:ClearAllPoints();
    HBframe:SetPoint(stuckPoint,cf,stuckToPoint,vSticktSetPointX,vSticktSetPointY)
    vSticktSetPointOptionUpd=false
    if stuckPoint == "TOPLEFT" and hbv_Skins_GetFrameVar("Anchors", "FRAME", frame)~=1 then
        hbv_Skins_SetFrameVar(1, "Anchors", "FRAME", frame)
        vSticktSetPointOptionUpd=true
    elseif stuckPoint == "BOTTOMLEFT" and hbv_Skins_GetFrameVar("Anchors", "FRAME", frame)~=2 then
        hbv_Skins_SetFrameVar(2, "Anchors", "FRAME", frame)
        vSticktSetPointOptionUpd=true
    elseif stuckPoint == "TOPRIGHT" and hbv_Skins_GetFrameVar("Anchors", "FRAME", frame)~=3 then
        hbv_Skins_SetFrameVar(3, "Anchors", "FRAME", frame)
        vSticktSetPointOptionUpd=true
    elseif stuckPoint == "BOTTOMRIGHT" and hbv_Skins_GetFrameVar("Anchors", "FRAME", frame)~=4 then
        hbv_Skins_SetFrameVar(4, "Anchors", "FRAME", frame)
        vSticktSetPointOptionUpd=true
    elseif stuckPoint == "TOP" and hbv_Skins_GetFrameVar("Anchors", "FRAME", frame)~=5 then
        hbv_Skins_SetFrameVar(5, "Anchors", "FRAME", frame)
        vSticktSetPointOptionUpd=true
    elseif stuckPoint == "LEFT" and hbv_Skins_GetFrameVar("Anchors", "FRAME", frame)~=6 then
        hbv_Skins_SetFrameVar(6, "Anchors", "FRAME", frame)
        vSticktSetPointOptionUpd=true
    elseif stuckPoint == "RIGHT" and hbv_Skins_GetFrameVar("Anchors", "FRAME", frame)~=7 then
        hbv_Skins_SetFrameVar(7, "Anchors", "FRAME", frame)
        vSticktSetPointOptionUpd=true
    elseif stuckPoint == "BOTTOM" and hbv_Skins_GetFrameVar("Anchors", "FRAME", frame)~=8 then
        hbv_Skins_SetFrameVar(8, "Anchors", "FRAME", frame)
        vSticktSetPointOptionUpd=true
    end
    if vSticktSetPointOptionUpd then
        HealBot_Options_ActionAnchor_UpdateDropDown()
    end
end

function HealBot_Action_StickyFrameStuckTo(frame,stuckTo,stuckPoint,stuckToPoint,HBframe,cf)
        --HealBot_setCall("HealBot_Action_StickyFrameStuckTo")
    hbv_Skins_SetFrameVar(true, "StickyFrames", "STUCK", frame)
    hbv_Skins_SetFrameVar(stuckTo, "StickyFrames", "STUCKTO", frame)
    hbv_Skins_SetFrameVar(stuckPoint, "StickyFrames", "STUCKPOINT", frame)
    hbv_Skins_SetFrameVar(stuckToPoint, "StickyFrames", "STUCKTOPOINT", frame)
    HealBot_Action_StickyFrameSetPoint(frame,stuckTo,stuckPoint,stuckToPoint,HBframe,cf)
end

local vStickyFrameCurInd={[2]=0,[3]=0,[4]=0,[5]=0,[6]=0,[7]=0,[8]=0,[9]=0,[10]=0,}
local vStickyFrameParInd={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,[6]=0,[7]=0,[8]=0,[9]=0,}
local vStickyFrameLastPar=0
local vStickyFrameLastParInd=0
local vsfIndCols={["R"]=1,["G"]=1,["B"]=.025}
function HealBot_Action_StickyFrameIndCols()
        --HealBot_setCall("HealBot_Action_StickyFrameIndCols")
    vsfIndCols["R"],vsfIndCols["G"],vsfIndCols["B"]=HealBot_Options_OptionsThemeCols()
end

function HealBot_Action_StickyFrameCanStickTo(frame,frameind,parent,parentind)
        --HealBot_setCall("HealBot_Action_StickyFrameCanStickTo")
    if vStickyFrameCurInd[frame]~=frameind then
        if vStickyFrameCurInd[frame]>0 then
            grpFrameStickyInd[frame][vStickyFrameCurInd[frame]]:SetStatusBarColor(vsfIndCols["R"],vsfIndCols["G"],vsfIndCols["B"],0)
        end
        if frameind>0 then
            grpFrameStickyInd[frame][frameind]:SetStatusBarColor(vsfIndCols["R"],vsfIndCols["G"],vsfIndCols["B"],1)
        end
        vStickyFrameCurInd[frame]=frameind
    end
    if parent == 0 then
        if vStickyFrameLastPar>0 then
            grpFrameStickyInd[vStickyFrameLastPar][vStickyFrameLastParInd]:SetStatusBarColor(vsfIndCols["R"],vsfIndCols["G"],vsfIndCols["B"],0)
            vStickyFrameParInd[vStickyFrameLastPar]=0
            vStickyFrameLastPar=0
            vStickyFrameLastParInd=0
        end
    else
        if vStickyFrameLastPar~=parent then
            if vStickyFrameLastPar>0 then
                grpFrameStickyInd[vStickyFrameLastPar][vStickyFrameLastParInd]:SetStatusBarColor(vsfIndCols["R"],vsfIndCols["G"],vsfIndCols["B"],0)
                vStickyFrameParInd[vStickyFrameLastPar]=0
                vStickyFrameLastPar=parent
            end
        end
        if vStickyFrameParInd[parent]~=parentind then
            if vStickyFrameParInd[parent]>0 then
                grpFrameStickyInd[parent][vStickyFrameParInd[parent]]:SetStatusBarColor(vsfIndCols["R"],vsfIndCols["G"],vsfIndCols["B"],0)
            end
            if parentind>0 then
                grpFrameStickyInd[parent][parentind]:SetStatusBarColor(vsfIndCols["R"],vsfIndCols["G"],vsfIndCols["B"],1)
                vStickyFrameLastPar=parent
                vStickyFrameLastParInd=parentind
            end
        end
        vStickyFrameParInd[parent]=parentind
    end
end

local vStickyFrameIsSticky,vStickyFrameLeft,vStickyFrameRight,vStickyFrameTop,vStickyFrameBottom=false,0,0,0,0
local vStickyFrameCurAnchor=0
local vStickyFrameParAnchor=0
local vStickyFrameSen=20
function HealBot_Action_CheckForStickyFrame(frame,stick)
        --HealBot_setCall("HealBot_Action_CheckForStickyFrame")
    vStickyFrameIsSticky=false
    vStickyFrameCurAnchor=0
    vStickyFrameParAnchor=0
    vStickyFrameLeft=grpFrame[frame]:GetLeft() or hbv_Skins_GetFrameVar("Anchors", "LEFT", frame) or hbv_Skins_GetFrameVar("Anchors", "X", frame)
    vStickyFrameRight=grpFrame[frame]:GetRight() or hbv_Skins_GetFrameVar("Anchors", "RIGHT", frame) or hbv_Skins_GetFrameVar("Anchors", "X", frame)
    vStickyFrameTop=grpFrame[frame]:GetTop() or hbv_Skins_GetFrameVar("Anchors", "TOP", frame) or hbv_Skins_GetFrameVar("Anchors", "Y", frame)
    vStickyFrameBottom=grpFrame[frame]:GetBottom() or hbv_Skins_GetFrameVar("Anchors", "BOTTOM", frame) or hbv_Skins_GetFrameVar("Anchors", "Y", frame)
    for x=1,frame-1 do
        if HealBot_Action_FrameIsVisible(x) and HealBot_Action_FrameIsVisible(frame) then
            if vStickyFrameLeft and grpFrame[x]:GetLeft() then
                if grpFrame[x]:GetLeft()>(vStickyFrameRight-vStickyFrameSen) and grpFrame[x]:GetLeft()<(vStickyFrameRight+vStickyFrameSen) then
                    if grpFrame[x]:GetTop()>(vStickyFrameTop-vStickyFrameSen) and grpFrame[x]:GetTop()<(vStickyFrameTop+vStickyFrameSen) then
                        if stick then
                            HealBot_Action_StickyFrameStuckTo(frame,x,"TOPRIGHT","TOPLEFT",grpFrame[frame],grpFrame[x])
                        else
                            HealBot_Action_StickyFrameCanStickTo(frame,4,x,12)
                        end
                        vStickyFrameIsSticky=true
                        break
                    elseif grpFrame[x]:GetBottom()>(vStickyFrameBottom-vStickyFrameSen) and grpFrame[x]:GetBottom()<(vStickyFrameBottom+vStickyFrameSen) then
                        if stick then
                            HealBot_Action_StickyFrameStuckTo(frame,x,"BOTTOMRIGHT","BOTTOMLEFT",grpFrame[frame],grpFrame[x])
                        else
                            HealBot_Action_StickyFrameCanStickTo(frame,6,x,10)
                        end
                        vStickyFrameIsSticky=true
                        break
                    elseif ((grpFrame[x]:GetTop()+grpFrame[x]:GetBottom())/2)>(((vStickyFrameTop+vStickyFrameBottom)/2)-vStickyFrameSen) and
                           ((grpFrame[x]:GetTop()+grpFrame[x]:GetBottom())/2)<(((vStickyFrameTop+vStickyFrameBottom)/2)+vStickyFrameSen) then
                        if stick then
                            HealBot_Action_StickyFrameStuckTo(frame,x,"RIGHT","LEFT",grpFrame[frame],grpFrame[x])
                        else
                            HealBot_Action_StickyFrameCanStickTo(frame,5,x,11)
                        end
                        vStickyFrameIsSticky=true
                        break
                    end
                elseif grpFrame[x]:GetLeft()>(vStickyFrameLeft-vStickyFrameSen) and grpFrame[x]:GetLeft()<(vStickyFrameLeft+vStickyFrameSen) then
                    if grpFrame[x]:GetTop()>(vStickyFrameBottom-vStickyFrameSen) and grpFrame[x]:GetTop()<(vStickyFrameBottom+vStickyFrameSen) then
                        if stick then
                            HealBot_Action_StickyFrameStuckTo(frame,x,"BOTTOMLEFT","TOPLEFT",grpFrame[frame],grpFrame[x])
                        else
                            HealBot_Action_StickyFrameCanStickTo(frame,9,x,1)
                        end
                        vStickyFrameIsSticky=true
                        break
                    elseif grpFrame[x]:GetBottom()>(vStickyFrameTop-vStickyFrameSen) and grpFrame[x]:GetBottom()<(vStickyFrameTop+vStickyFrameSen) then
                        if stick then
                            HealBot_Action_StickyFrameStuckTo(frame,x,"TOPLEFT","BOTTOMLEFT",grpFrame[frame],grpFrame[x])
                        else
                            HealBot_Action_StickyFrameCanStickTo(frame,1,x,9)
                        end
                        vStickyFrameIsSticky=true
                        break
                    end
                elseif grpFrame[x]:GetRight()>(vStickyFrameRight-vStickyFrameSen) and grpFrame[x]:GetRight()<(vStickyFrameRight+vStickyFrameSen) then
                    if grpFrame[x]:GetTop()>(vStickyFrameBottom-vStickyFrameSen) and grpFrame[x]:GetTop()<(vStickyFrameBottom+vStickyFrameSen) then
                        if stick then
                            HealBot_Action_StickyFrameStuckTo(frame,x,"BOTTOMRIGHT","TOPRIGHT",grpFrame[frame],grpFrame[x])
                        else
                            HealBot_Action_StickyFrameCanStickTo(frame,7,x,3)
                        end
                        vStickyFrameIsSticky=true
                        break
                    elseif grpFrame[x]:GetBottom()>(vStickyFrameTop-vStickyFrameSen) and grpFrame[x]:GetBottom()<(vStickyFrameTop+vStickyFrameSen) then
                        if stick then
                            HealBot_Action_StickyFrameStuckTo(frame,x,"TOPRIGHT","BOTTOMRIGHT",grpFrame[frame],grpFrame[x])
                        else
                            HealBot_Action_StickyFrameCanStickTo(frame,3,x,7)
                        end
                        vStickyFrameIsSticky=true
                        break
                    end
                elseif grpFrame[x]:GetRight()>(vStickyFrameLeft-vStickyFrameSen) and grpFrame[x]:GetRight()<(vStickyFrameLeft+vStickyFrameSen) then
                    if grpFrame[x]:GetTop()>(vStickyFrameTop-vStickyFrameSen) and grpFrame[x]:GetTop()<(vStickyFrameTop+vStickyFrameSen) then
                        if stick then
                            HealBot_Action_StickyFrameStuckTo(frame,x,"TOPLEFT","TOPRIGHT",grpFrame[frame],grpFrame[x])
                        else
                            HealBot_Action_StickyFrameCanStickTo(frame,12,x,4)
                        end
                        vStickyFrameIsSticky=true
                        break
                    elseif grpFrame[x]:GetBottom()>(vStickyFrameBottom-vStickyFrameSen) and grpFrame[x]:GetBottom()<(vStickyFrameBottom+vStickyFrameSen) then
                        if stick then
                            HealBot_Action_StickyFrameStuckTo(frame,x,"BOTTOMLEFT","BOTTOMRIGHT",grpFrame[frame],grpFrame[x])
                        else
                            HealBot_Action_StickyFrameCanStickTo(frame,10,x,6)
                        end
                        vStickyFrameIsSticky=true
                        break
                    elseif ((grpFrame[x]:GetTop()+grpFrame[x]:GetBottom())/2)>(((vStickyFrameTop+vStickyFrameBottom)/2)-vStickyFrameSen) and
                           ((grpFrame[x]:GetTop()+grpFrame[x]:GetBottom())/2)<(((vStickyFrameTop+vStickyFrameBottom)/2)+vStickyFrameSen) then
                        if stick then
                            HealBot_Action_StickyFrameStuckTo(frame,x,"LEFT","RIGHT",grpFrame[frame],grpFrame[x])
                        else
                            HealBot_Action_StickyFrameCanStickTo(frame,11,x,5)
                        end
                        vStickyFrameIsSticky=true
                        break
                    end
                elseif grpFrame[x]:GetTop()>(vStickyFrameBottom-vStickyFrameSen) and grpFrame[x]:GetTop()<(vStickyFrameBottom+vStickyFrameSen) and
                       ((grpFrame[x]:GetLeft()+grpFrame[x]:GetRight())/2)>(((vStickyFrameLeft+vStickyFrameRight)/2)-vStickyFrameSen) and
                       ((grpFrame[x]:GetLeft()+grpFrame[x]:GetRight())/2)<(((vStickyFrameLeft+vStickyFrameRight)/2)+vStickyFrameSen) then
                    if stick then
                        HealBot_Action_StickyFrameStuckTo(frame,x,"BOTTOM","TOP",grpFrame[frame],grpFrame[x])
                    else
                        HealBot_Action_StickyFrameCanStickTo(frame,8,x,2)
                    end
                    vStickyFrameIsSticky=true
                    break
                elseif grpFrame[x]:GetBottom()>(vStickyFrameTop-vStickyFrameSen) and grpFrame[x]:GetBottom()<(vStickyFrameTop+vStickyFrameSen) and
                       ((grpFrame[x]:GetLeft()+grpFrame[x]:GetRight())/2)>(((vStickyFrameLeft+vStickyFrameRight)/2)-vStickyFrameSen) and
                       ((grpFrame[x]:GetLeft()+grpFrame[x]:GetRight())/2)<(((vStickyFrameLeft+vStickyFrameRight)/2)+vStickyFrameSen) then
                    if stick then
                        HealBot_Action_StickyFrameStuckTo(frame,x,"TOP","BOTTOM",grpFrame[frame],grpFrame[x])
                    else
                        HealBot_Action_StickyFrameCanStickTo(frame,2,x,8)
                    end
                    vStickyFrameIsSticky=true
                    break
                end
            else
                HealBot_Action_DelayCheckFrameSetPoint(frame, true)
            end
            if vStickyFrameLeft then hbv_Skins_SetFrameVar(vStickyFrameLeft, "Anchors", "LEFT", frame) end
            if vStickyFrameRight then hbv_Skins_SetFrameVar(vStickyFrameRight, "Anchors", "RIGHT", frame) end
            if vStickyFrameTop then hbv_Skins_SetFrameVar(vStickyFrameTop, "Anchors", "TOP", frame) end
            if vStickyFrameBottom then hbv_Skins_SetFrameVar(vStickyFrameBottom, "Anchors", "BOTTOM", frame) end
        end
    end
    if not vStickyFrameIsSticky and not stick then
        HealBot_Action_StickyFrameCanStickTo(frame,0,0,0)
    end
end

function HealBot_Action_StickyFrame(frame)
        --HealBot_setCall("HealBot_Action_StickyFrame")
    vStickyFrameIsSticky=false
    if hbv_Skins_GetBoolean("General", "STICKYFRAME") and frame>1 then
        if hbv_Skins_GetFrameBoolean("StickyFrames", "STUCK", frame) and
           HealBot_Action_FrameIsVisible(hbv_Skins_GetFrameVar("StickyFrames", "STUCKTO", frame)) then
            HealBot_Action_StickyFrameSetPoint(frame,
                                               hbv_Skins_GetFrameVar("StickyFrames", "STUCKTO", frame),
                                               hbv_Skins_GetFrameVar("StickyFrames", "STUCKPOINT", frame),
                                               hbv_Skins_GetFrameVar("StickyFrames", "STUCKTOPOINT", frame),
                                               grpFrame[frame],
                                               grpFrame[hbv_Skins_GetFrameVar("StickyFrames", "STUCKTO", frame)])
            vStickyFrameIsSticky=true
        else
            HealBot_Action_CheckForStickyFrame(frame,true)
        end
        if not vStickyFrameIsSticky then
            hbStickyFrameGetCoords[frame]=false
        end
        HealBot_Options_ActionAnchor_SetAlpha(frame)
    end
    return vStickyFrameIsSticky
end

function HealBot_Action_ClearGUID(guid)
        --HealBot_setCall("HealBot_Action_ClearGUID", nil, guid)
    ripHasResStart[guid]=nil
    ripHasResEnd[guid]=nil
    ripHadResStart[guid]=nil
    ripHadResEnd[guid]=nil
    hbGuidData[guid]=nil
    HealBot_PluginUpdate_TimeToLive[guid]=nil
    if HealBot_Action_luVars["pluginTimeToLive"] then HealBot_Plugin_TTLRemoveUnit(guid) end
    if HealBot_Action_luVars["pluginThreat"] then HealBot_Plugin_ThreatRemoveUnit(guid) end
    if HealBot_Action_luVars["pluginTimeToDie"] then HealBot_Plugin_TTDRemoveUnit(guid) end
end