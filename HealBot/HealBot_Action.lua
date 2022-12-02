local HealBot_ActiveButtons={[0]=1}
local HealBot_Action_ActiveButton={}
HealBot_Action_ActiveButton.id=0
HealBot_Action_ActiveButton.lastid=0
local HealBot_RangeSpells={}
local HealBot_RangeSpellsKeysFriendly={}
local HealBot_RangeSpellsKeysEnemy={}
local HealBot_AlwaysEnabled={}
local HealBot_pcClass={[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
local HealBot_AutoCloseFrame={[1]=1,[2]=1,[3]=1,[4]=1,[5]=1,[6]=1,[7]=1,[8]=1,[9]=1,[10]=1}
local LSM = HealBot_Libs_LSM() --LibStub("LibSharedMedia-3.0") 
local HealBot_Action_rCalls={}
local HealBot_PluginUpdate_TimeToLive={}
local grpFrame={}
local grpFrameBar={}
local grpFrameText={}
local grpFrameStickyInd={}
local xButton, xButton=nil, nil
local HealBot_Keys_List = {"","Shift","Ctrl","Alt","Alt-Shift","Ctrl-Shift","Alt-Ctrl","Alt-Ctrl-Shift"}
local hbAttribsMinReset = {}
local hbAttribsFramesMinReset = {}
local HB_button,HB_prefix=nil,nil
local showHBmenu=nil
local _
local HealBot_Action_AuxAssigns={}
HealBot_Action_AuxAssigns["NameOverlayHighlight"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
HealBot_Action_AuxAssigns["HealthOverlayHighlight"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
local HealBot_Action_luVars={}
HealBot_Action_luVars["FrameMoving"]=false
HealBot_Action_luVars["UnitPowerMax"]=3
HealBot_Action_luVars["resetSkinTo"]=""
HealBot_Action_luVars["TestBarsOn"]=false
HealBot_Action_luVars["ShapeshiftForm"]=-1
HealBot_Action_luVars["FluidInUse"]=false
HealBot_Action_luVars["FluidAlphaInUse"]=false
HealBot_Action_luVars["FrameInitDone"]=false
HealBot_Action_luVars["pluginExtraButtons"]=false
HealBot_Action_luVars["showTestPowerIndicator"]=0
HealBot_Action_luVars["FocusGroups"]=false
HealBot_Action_luVars["FGDimming"]=2
HealBot_Action_luVars["GlobalDimming"]=0
HealBot_Action_luVars["HotBarDimming"]=4
HealBot_Action_luVars["HotBarsHealth"]=0
HealBot_Action_luVars["FluidBarAlphaUpdate"]=0.025
HealBot_Action_luVars["FluidBarAlphaFreq"]=0.025
HealBot_Action_luVars["FluidBarSmoothAdj"]=5
HealBot_Action_luVars["FluidBarFreq"]=0.025
HealBot_Action_luVars["ScreenHeight"]=0
HealBot_Action_luVars["ScreenWidth"]=0
HealBot_Action_luVars["CurrentModKey"]=""
HealBot_Action_luVars["FGroups"]={[1]=true,[2]=true,[3]=true,[4]=true,[5]=true,[6]=true,[7]=true,[8]=true}
HealBot_Action_luVars["HazardFreq"]=0.3
HealBot_Action_luVars["HazardMinAlpha"]=0.25

local sConcat={}
local tabconcat=table.concat
function HealBot_Action_Concat(elements)
    return tabconcat(sConcat,"",1,elements)
end

function HealBot_Action_setLuVars(vName, vValue)
    HealBot_Action_luVars[vName]=vValue
      --HealBot_setCall("HealBot_Action_setLuVars - "..vName)
end

function HealBot_Action_retLuVars(vName)
    --HealBot_setCall("HealBot_Action_retLuVars")
    return HealBot_Action_luVars[vName]
end

function HealBot_Action_retComboKeysList()
    return HealBot_Keys_List
end

function HealBot_Action_setAuxAssigns(vName, frame, vValue)
    HealBot_Action_AuxAssigns[vName][frame]=vValue
end

function HealBot_Action_setpcClass(button)
    for j=1,5 do
        if HEALBOT_GAME_VERSION>3 and Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j] and Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j]["POWERCNT"] then
            local prevHealBot_pcMax=HealBot_Action_luVars["UnitPowerMax"]
            if HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_PALADIN] then
                HealBot_pcClass[j]=9
                HealBot_Action_luVars["UnitPowerMax"] = UnitPowerMax("player" , 9);
            elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_ROGUE] or HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_DRUID] then
                HealBot_pcClass[j]=4
                HealBot_Action_luVars["UnitPowerMax"] = UnitPowerMax("player" , 4);
            elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_WARLOCK] then
                HealBot_pcClass[j]=7
                HealBot_Action_luVars["UnitPowerMax"] = UnitPowerMax("player" , 7);
            elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_MONK] then
                HealBot_pcClass[j]=12
                HealBot_Action_luVars["UnitPowerMax"] = UnitPowerMax("player" , 12);
            else
                HealBot_Action_luVars["UnitPowerMax"]=0
            end
            if prevHealBot_pcMax~=HealBot_Action_luVars["UnitPowerMax"] then
                if HealBot_Action_luVars["UnitPowerMax"]==0 then
                    HealBot_pcClass[j]=false
                    button.mana.power=0
                    for y=1,5 do
                        button.gref.indicator.power[y]:SetAlpha(0)
                    end
                else
                    button.skinreset=true
                    button.icon.reset=true
                    HealBot_Timers_Set("INIT","RefreshPartyNextRecalcPlayers",0.1)
                end
            end
        else
            HealBot_pcClass[j]=false
            button.mana.power=0
            for y=1,5 do
                button.gref.indicator.power[y]:SetAlpha(0)
            end
        end
    end
    --HealBot_setCall("HealBot_Action_setpcClass")
end

HealBot_RangeSpells["HEAL"]=""
for y=1, getn(HealBot_Keys_List), 1 do
    HealBot_RangeSpellsKeysFriendly[HealBot_Keys_List[y]]=""
    HealBot_RangeSpellsKeysEnemy[HealBot_Keys_List[y]]=""
end
function HealBot_Action_SetrSpell()
    HealBot_RangeSpells["HEAL"]=nil
    HealBot_RangeSpells["HARM"]=nil
    local x=HealBot_GetBandageType() or HEALBOT_LINEN_BANDAGE
    local y=GetInventoryItemID("player", INVSLOT_MAINHAND) or HEALBOT_WORDS_UNKNOWN
    if y~=HEALBOT_WORDS_UNKNOWN then y=GetItemInfo(y) or y end
    local sName=HealBot_Action_GetSpell("ENEMY", "Left"..HealBot_Config.CurrentSpec)
    if sName and HealBot_Spell_Names[sName] then
        HealBot_RangeSpells["HARM"]=sName
    else
        if HealBot_Data["PCLASSTRIM"]=="DRUI" then
            sName=HealBot_KnownSpell(HEALBOT_WRATH) or HealBot_KnownSpell(HEALBOT_HURRICANE)
            if sName then HealBot_RangeSpells["HARM"]=sName end
        elseif HealBot_Data["PCLASSTRIM"]=="MAGE" then
            sName=HealBot_KnownSpell(HEALBOT_FROSTFIRE_BOLT) or HealBot_KnownSpell(HEALBOT_FIRE_BLAST)
            if sName then HealBot_RangeSpells["HARM"]=sName end
        elseif HealBot_Data["PCLASSTRIM"]=="PALA" then
            sName=HealBot_KnownSpell(HEALBOT_HOLY_SHOCK) or HealBot_KnownSpell(HEALBOT_JUDGMENT)
            if sName then HealBot_RangeSpells["HARM"]=sName end
        elseif HealBot_Data["PCLASSTRIM"]=="PRIE" then
            sName=HealBot_KnownSpell(HEALBOT_SMITE) or HealBot_KnownSpell(HEALBOT_SHADOW_WORD_PAIN) or HealBot_KnownSpell(HEALBOT_PENANCE)
            if sName then HealBot_RangeSpells["HARM"]=sName end
        elseif HealBot_Data["PCLASSTRIM"]=="SHAM" then
            sName=HealBot_KnownSpell(HEALBOT_LIGHTNING_BOLT) or HealBot_KnownSpell(HBC_LIGHTNING_BOLT)
            if sName then HealBot_RangeSpells["HARM"]=sName end
        elseif HealBot_Data["PCLASSTRIM"]=="MONK" then
            sName=HealBot_KnownSpell(HEALBOT_CRACKLING_JADE_LIGHTNING)
            if sName then HealBot_RangeSpells["HARM"]=sNameend end
        elseif HealBot_Data["PCLASSTRIM"]=="WARL" then
            sName=HealBot_KnownSpell(HEALBOT_CORRUPTION) or HealBot_KnownSpell(HEALBOT_FEAR)
            if sName then HealBot_RangeSpells["HARM"]=sName end
        elseif HealBot_Data["PCLASSTRIM"]=="WARR" then
            sName=HealBot_KnownSpell(HEALBOT_TAUNT)
            if sName then HealBot_RangeSpells["HARM"]=sName end
        elseif HealBot_Data["PCLASSTRIM"]=="HUNT" then
            sName=HealBot_KnownSpell(HEALBOT_ARCANE_SHOT) or HealBot_KnownSpell(HEALBOT_CONCUSSIVE_SHOT) or HealBot_KnownSpell(HEALBOT_AIMED_SHOT)
            if sName then HealBot_RangeSpells["HARM"]=sName end
        elseif HealBot_Data["PCLASSTRIM"]=="ROGU" then
            sName=HealBot_KnownSpell(HEALBOT_THROW) or HealBot_KnownSpell(HEALBOT_GOUGE)
            if sName then HealBot_RangeSpells["HARM"]=sName end
        elseif HealBot_Data["PCLASSTRIM"]=="DEAT" then
            sName=HealBot_KnownSpell(HEALBOT_DEATH_COIL) or HealBot_KnownSpell(HEALBOT_PLAGUE_STRIKE)
            if sName then HealBot_RangeSpells["HARM"]=sName end
        elseif HealBot_Data["PCLASSTRIM"]=="DEMO" then
            sName=HealBot_KnownSpell(185123) or HealBot_KnownSpell(185245)
            if sName then HealBot_RangeSpells["HARM"]=sName end
        elseif HealBot_Data["PCLASSTRIM"]=="EVOK" then
        end
    end
    sName=HealBot_Action_GetSpell("ENABLED", "Left"..HealBot_Config.CurrentSpec)
    if sName and HealBot_Spell_Names[sName] then
        HealBot_RangeSpells["HEAL"]=sName
    else
        if HealBot_Data["PCLASSTRIM"]=="DRUI" then
            sName=HealBot_KnownSpell(HEALBOT_REJUVENATION) or HealBot_KnownSpell(HEALBOT_HEALING_TOUCH)
            if sName then HealBot_RangeSpells["HEAL"]=sName end
        elseif HealBot_Data["PCLASSTRIM"]=="PALA" then
            sName=HealBot_KnownSpell(HEALBOT_FLASH_OF_LIGHT) or HealBot_KnownSpell(HEALBOT_HOLY_LIGHT) or HealBot_KnownSpell(HBC_HOLY_LIGHT)
            if sName then HealBot_RangeSpells["HEAL"]=sName end
        elseif HealBot_Data["PCLASSTRIM"]=="PRIE" then
            sName=HealBot_KnownSpell(HEALBOT_FLASH_HEAL) or HealBot_KnownSpell(HEALBOT_RENEW) or HealBot_KnownSpell(HEALBOT_HEAL) or HealBot_KnownSpell(HEALBOT_PENANCE) or HealBot_KnownSpell(HEALBOT_HOLY_WORD_SERENITY)
            if sName then HealBot_RangeSpells["HEAL"]=sName end
        elseif HealBot_Data["PCLASSTRIM"]=="SHAM" then
            sName=HealBot_KnownSpell(HEALBOT_HEALING_WAVE) or HealBot_KnownSpell(HEALBOT_HEALING_SURGE) or HealBot_KnownSpell(HBC_HEALING_WAVE)
            if sName then HealBot_RangeSpells["HEAL"]=sName end
        elseif HealBot_Data["PCLASSTRIM"]=="MONK" then
            sName=HealBot_KnownSpell(HEALBOT_SOOTHING_MIST)
            if sName then HealBot_RangeSpells["HEAL"]=sName end
        elseif HealBot_Data["PCLASSTRIM"]=="HUNT" then
            sName=HealBot_KnownSpell(HEALBOT_MENDPET)
            if sName then HealBot_RangeSpells["HEAL"]=sName end
        end
    end
    if (HealBot_RangeSpells["HEAL"] or HEALBOT_WORDS_UNKNOWN)==HEALBOT_WORDS_UNKNOWN then HealBot_RangeSpells["HEAL"]=x end
    if (HealBot_RangeSpells["HARM"] or HEALBOT_WORDS_UNKNOWN)==HEALBOT_WORDS_UNKNOWN then HealBot_RangeSpells["HARM"]=y end
    
    sConcat[2]="Left"
    sConcat[3]=HealBot_Config.CurrentSpec
    for y=1, getn(HealBot_Keys_List), 1 do
        sConcat[1]=HealBot_Keys_List[y]
        sName=HealBot_Action_GetSpell("ENABLED", HealBot_Action_Concat(3))
        if not sName or not HealBot_Spell_Names[sName] then
            sName=HealBot_RangeSpells["HEAL"]
        end
        HealBot_RangeSpellsKeysFriendly[HealBot_Keys_List[y]]=sName
        sName=HealBot_Action_GetSpell("ENEMY", HealBot_Action_Concat(3))
        if not sName or not HealBot_Spell_Names[sName] then
            sName=HealBot_RangeSpells["HARM"]
        end
        HealBot_RangeSpellsKeysEnemy[HealBot_Keys_List[y]]=sName
    end
end

function HealBot_GetBandageType()
    local bandage = nil
    if HealBot_IsItemInBag(HEALBOT_HEAVY_SHROUDED_CLOTH_BANDAGE) then bandage = HEALBOT_HEAVY_SHROUDED_CLOTH_BANDAGE
    elseif HealBot_IsItemInBag(HEALBOT_SHROUDED_CLOTH_BANDAGE) then bandage = HEALBOT_SHROUDED_CLOTH_BANDAGE
    elseif HealBot_IsItemInBag(HEALBOT_TIDESPRAY_LINEN_BANDAGE) then bandage = HEALBOT_TIDESPRAY_LINEN_BANDAGE
    elseif HealBot_IsItemInBag(HEALBOT_DEEP_SEA_BANDAGE) then bandage = HEALBOT_DEEP_SEA_BANDAGE
    elseif HealBot_IsItemInBag(HEALBOT_SILKWEAVE_BANDAGE) then bandage = HEALBOT_SILKWEAVE_BANDAGE
    elseif HealBot_IsItemInBag(HEALBOT_ASHRAN_BANDAGE) then bandage = HEALBOT_ASHRAN_BANDAGE
    elseif HealBot_IsItemInBag(HEALBOT_HEAVY_WINDWOOL_BANDAGE) then bandage = HEALBOT_HEAVY_WINDWOOL_BANDAGE
    elseif HealBot_IsItemInBag(HEALBOT_WINDWOOL_BANDAGE) then bandage = HEALBOT_WINDWOOL_BANDAGE
    elseif HealBot_IsItemInBag(HEALBOT_DENSE_EMBERSILK_BANDAGE) then bandage = HEALBOT_DENSE_EMBERSILK_BANDAGE
    elseif HealBot_IsItemInBag(HEALBOT_HEAVY_EMBERSILK_BANDAGE) then bandage = HEALBOT_HEAVY_EMBERSILK_BANDAGE
    elseif HealBot_IsItemInBag(HEALBOT_EMBERSILK_BANDAGE) then bandage = HEALBOT_EMBERSILK_BANDAGE
    elseif HealBot_IsItemInBag(HEALBOT_HEAVY_FROSTWEAVE_BANDAGE) then bandage = HEALBOT_HEAVY_FROSTWEAVE_BANDAGE
    elseif HealBot_IsItemInBag(HEALBOT_FROSTWEAVE_BANDAGE) then bandage = HEALBOT_FROSTWEAVE_BANDAGE
    elseif HealBot_IsItemInBag(HEALBOT_HEAVY_NETHERWEAVE_BANDAGE) then bandage = HEALBOT_HEAVY_NETHERWEAVE_BANDAGE
    elseif HealBot_IsItemInBag(HEALBOT_NETHERWEAVE_BANDAGE) then bandage = HEALBOT_NETHERWEAVE_BANDAGE
    elseif HealBot_IsItemInBag(HEALBOT_HEAVY_RUNECLOTH_BANDAGE) then bandage = HEALBOT_HEAVY_RUNECLOTH_BANDAGE
    elseif HealBot_IsItemInBag(HEALBOT_RUNECLOTH_BANDAGE) then bandage = HEALBOT_RUNECLOTH_BANDAGE
    elseif HealBot_IsItemInBag(HEALBOT_HEAVY_MAGEWEAVE_BANDAGE) then bandage = HEALBOT_HEAVY_MAGEWEAVE_BANDAGE
    elseif HealBot_IsItemInBag(HEALBOT_MAGEWEAVE_BANDAGE) then bandage = HEALBOT_MAGEWEAVE_BANDAGE
    elseif HealBot_IsItemInBag(HEALBOT_HEAVY_SILK_BANDAGE) then bandage = HEALBOT_HEAVY_SILK_BANDAGE
    elseif HealBot_IsItemInBag(HEALBOT_SILK_BANDAGE) then bandage = HEALBOT_SILK_BANDAGE
    elseif HealBot_IsItemInBag(HEALBOT_HEAVY_WOOL_BANDAGE) then bandage = HEALBOT_HEAVY_WOOL_BANDAGE
    elseif HealBot_IsItemInBag(HEALBOT_WOOL_BANDAGE) then bandage = HEALBOT_WOOL_BANDAGE
    elseif HealBot_IsItemInBag(HEALBOT_HEAVY_LINEN_BANDAGE) then bandage = HEALBOT_HEAVY_LINEN_BANDAGE
    elseif HealBot_IsItemInBag(HEALBOT_LINEN_BANDAGE) then bandage = HEALBOT_LINEN_BANDAGE
    end
    return bandage
end

local HealBot_Fluid_AbsorbButtons={}
local HealBot_Fluid_EmergButtonsAlpha={}
local HealBot_Fluid_InHealButtons={}
local HealBot_Fluid_BarButtons={}
local HealBot_Fluid_BarButtonsAlpha={}
local HealBot_Fluid_BarHealthDropAlpha={}
local aufbButtonActive=false
local aufbBarValue,aufbSetValue,aufbAlphaValue=0,0,0
local aufbRValue,aufbGValue,aufbBValue=0,0,0
local aufbSetRValue,aufbSetGValue,aufbSetBValue=0,0,0


function HealBot_Action_setFluid_Aborbs_BarButtons(button)
    HealBot_Fluid_AbsorbButtons[button.id]=button
    if not HealBot_Action_luVars["FluidBarInUse"] then HealBot_Action_UpdateFluidBars() end
      --HealBot_setCall("HealBot_Action_setFluid_Aborbs_BarButtons")
end

function HealBot_Action_setFluid_InHeal_BarButtons(button)
    HealBot_Fluid_InHealButtons[button.id]=button
    if not HealBot_Action_luVars["FluidBarInUse"] then HealBot_Action_UpdateFluidBars() end
      --HealBot_setCall("HealBot_Action_setFluid_InHeal_BarButtons")
end

function HealBot_Action_setFluid_BarButtons(button)
    HealBot_Fluid_BarButtons[button.id]=button
    if not HealBot_Action_luVars["FluidBarInUse"] then HealBot_Action_UpdateFluidBars() end
      --HealBot_setCall("HealBot_Action_setFluid_BarButtons")
end

local hbSmooth=0
function HealBot_Action_UpdateFluidBars()
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
      --HealBot_setCall("HealBot_Action_UpdateFluidBars")
end

local HealBot_Hazard_Buttons={}
function HealBot_Action_UpdateHazardBordersColours(button, alpha)
    button.gref["BackBorder"]:SetBackdropBorderColor(button.hazard.r,button.hazard.g,button.hazard.b,HealBot_Action_BarColourAlpha(button, alpha, 1))
end

function HealBot_Action_UpdateHazardBordersColoursNew(button, r, g, b)
    button.hazard.r,button.hazard.g,button.hazard.b=r,g,b
    if HealBot_Action_luVars["HazardAltAlpha"] then
        HealBot_Action_UpdateHazardBordersColours(button, 1)
    else
        HealBot_Action_UpdateHazardBordersColours(button, HealBot_Action_luVars["HazardMinAlpha"])
    end
end

function HealBot_Action_UpdateHazardBorders()
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
      --HealBot_setCall("HealBot_Action_UpdateHazardBorders")
end

function HealBot_Action_EnableBorderHazard(button, r, g, b)
    HealBot_Hazard_Buttons[button.id]=button
    button.hazard.r,button.hazard.g,button.hazard.b=r,g,b
    if not HealBot_Action_luVars["HazardInUse"] then
        HealBot_Action_luVars["HazardInUse"]=true
        HealBot_Action_luVars["HazardAltAlpha"]=true
        HealBot_Action_UpdateHazardBorders()
    end
end

function HealBot_Action_EnableBorderHazardType(button, r, g, b, hType)
    if hType=="PLUGIN" then
        button.hazard.plugin=true
        HealBot_Action_EnableBorderHazard(button, r, g, b)
    elseif hType=="DEBUFF" then
        button.hazard.debuff=true
        if not button.hazard.plugin then
            HealBot_Action_EnableBorderHazard(button, r, g, b)
        end
    elseif hType=="AGGRO" then
        button.hazard.aggro=true
        if not button.hazard.plugin and not button.hazard.debuff then
            HealBot_Action_EnableBorderHazard(button, r, g, b)
        end
    end
end

function HealBot_Action_DisableBorderHazard(button)
    HealBot_Hazard_Buttons[button.id]=nil
    HealBot_Action_UpdateBackgroundBorder(button)
end

function HealBot_Action_DisableBorderHazardType(button, hType)
    if hType=="PLUGIN" then
        button.hazard.plugin=false
        if button.hazard.debuff then
            HealBot_Action_UpdateHazardBordersColoursNew(button, button.aura.debuff.r, button.aura.debuff.g, button.aura.debuff.b)
        elseif button.hazard.aggro then
            HealBot_Action_UpdateHazardBordersColoursNew(button, 1, 0, 0)
        else
            HealBot_Action_DisableBorderHazard(button)
        end
    elseif hType=="DEBUFF" then
        button.hazard.debuff=false
        if button.hazard.aggro then
            HealBot_Action_UpdateHazardBordersColoursNew(button, 1, 0, 0)
        else
            HealBot_Action_DisableBorderHazard(button)
        end
    elseif hType=="AGGRO" then
        button.hazard.aggro=false
        HealBot_Action_DisableBorderHazard(button)
    end
end

function HealBot_Action_DisableBorderHazardTypeGUID(guid)
    if HealBot_retLuVars("pluginRequests") then HealBot_Plugin_Requests_CancelGUID(guid) end
    if HealBot_retLuVars("pluginBuffWatch") then HealBot_Plugin_BuffWatch_CancelGUID(guid) end
    if HealBot_retLuVars("pluginHealthWatch") then HealBot_Plugin_HealthWatch_CancelGUID(guid) end
    if HealBot_retLuVars("pluginManaWatch") then HealBot_Plugin_ManaWatch_CancelGUID(guid) end
end

function HealBot_Action_DisableBorderHazardTypeButton(button)
    if HealBot_retLuVars("pluginRequests") then HealBot_Plugin_Requests_Cancel(button) end
    if HealBot_retLuVars("pluginBuffWatch") then HealBot_Plugin_BuffWatch_Cancel(button) end
    if HealBot_retLuVars("pluginHealthWatch") then HealBot_Plugin_HealthWatch_Cancel(button) end
    if HealBot_retLuVars("pluginManaWatch") then HealBot_Plugin_ManaWatch_Cancel(button) end
end

local hdaAlphaValue, hdaSetValue, hdaAdjValue=0,0,0
local hdaButtonActive=false
function HealBot_Action_UpdateHealthDropAlertBarsAlpha()
    HealBot_Action_luVars["HealthDropAlphaInUse"]=false
    for id,xButton in pairs(HealBot_Fluid_BarHealthDropAlpha) do
        hdaButtonActive=true
        if xButton.health.dropalert>0 then
            hdaAdjValue=HealBot_Action_luVars["HealthDropSpeed"]+(xButton.health.dropalertalpha/25)
            if xButton.health.dropalert==2 then
                xButton.health.dropalertalpha=xButton.health.dropalertalpha-hdaAdjValue
                if xButton.health.dropalertalpha<0.02 then 
                    hdaButtonActive=false
                    xButton.health.dropalertalpha=0
                end
            else
                xButton.health.dropalertalpha=xButton.health.dropalertalpha+hdaAdjValue+0.01
                if xButton.health.dropalertalpha>1 then 
                    xButton.health.dropalertalpha=1
                    xButton.health.dropalert=2
                end
            end
            xButton.gref["BackBorder"].tex:SetColorTexture(xButton.health.mixcolr, xButton.health.mixcolg, xButton.health.mixcolb, xButton.health.dropalertalpha)
        else
            hdaButtonActive=false
        end
        if not hdaButtonActive then
            HealBot_Fluid_BarHealthDropAlpha[id]=nil
            xButton.gref["BackBorder"].tex:Hide()
            xButton.health.dropalert=0
        else
            HealBot_Action_luVars["HealthDropAlphaInUse"]=true
        end
    end
    if HealBot_Action_luVars["HealthDropAlphaInUse"] then
        C_Timer.After(0.02, HealBot_Action_UpdateHealthDropAlertBarsAlpha)
    end
end

function HealBot_Action_HealthDropAlertBarsAlpha(button)
    if button.health.dropalert==0 then
        button.health.dropalert=1
        button.health.dropalertalpha=0.01
        button.gref["BackBorder"].tex:SetColorTexture(button.health.mixcolr, button.health.mixcolg, button.health.mixcolb, button.health.dropalertalpha)
        button.gref["BackBorder"].tex:Show()
        HealBot_Fluid_BarHealthDropAlpha[button.id]=button
        if not HealBot_Action_luVars["HealthDropAlphaInUse"] then
            HealBot_Action_UpdateHealthDropAlertBarsAlpha()
        end
    elseif button.health.dropalert==2 then
        button.health.dropalert=1
    end
end

function HealBot_Action_UpdateFluidBarsAlpha()
    HealBot_Action_luVars["FluidBarAlphaInUse"]=false
    for id,xButton in pairs(HealBot_Fluid_BarButtonsAlpha) do
        aufbButtonActive=false
        if xButton.status.current<HealBot_Unit_Status["DEAD"] then
            aufbRValue,aufbGValue,aufbBValue,aufbAlphaValue=xButton.gref["Bar"]:GetStatusBarColor()
            aufbRValue=HealBot_Comm_round(aufbRValue, 2)
            aufbGValue=HealBot_Comm_round(aufbGValue, 2)
            aufbBValue=HealBot_Comm_round(aufbBValue, 2)
            aufbAlphaValue=HealBot_Comm_round(aufbAlphaValue, 2)
            if aufbRValue>xButton.status.r then
                aufbSetRValue=aufbRValue-HealBot_Action_luVars["FluidBarAlphaUpdate"]
                if aufbSetRValue<xButton.status.r then 
                    aufbSetRValue=xButton.status.r
                else
                    aufbButtonActive=true
                end
            elseif aufbRValue<xButton.status.r then
                aufbSetRValue=aufbRValue+HealBot_Action_luVars["FluidBarAlphaUpdate"]
                if aufbSetRValue>xButton.status.r then 
                    aufbSetRValue=xButton.status.r
                else
                    aufbButtonActive=true
                end
            else
                aufbSetRValue=xButton.status.r
            end
            if aufbGValue>xButton.status.g then
                aufbSetGValue=aufbGValue-HealBot_Action_luVars["FluidBarAlphaUpdate"]
                if aufbSetGValue<xButton.status.g then 
                    aufbSetGValue=xButton.status.g
                else
                    aufbButtonActive=true
                end
            elseif aufbGValue<xButton.status.g then
                aufbSetGValue=aufbGValue+HealBot_Action_luVars["FluidBarAlphaUpdate"]
                if aufbSetGValue>xButton.status.g then 
                    aufbSetGValue=xButton.status.g
                else
                    aufbButtonActive=true
                end
            else
                aufbSetGValue=xButton.status.g
            end
            if aufbBValue>xButton.status.b then
                aufbSetBValue=aufbBValue-HealBot_Action_luVars["FluidBarAlphaUpdate"]
                if aufbSetBValue<xButton.status.b then 
                    aufbSetBValue=xButton.status.b
                else
                    aufbButtonActive=true
                end
            elseif aufbBValue<xButton.status.b then
                aufbSetBValue=aufbBValue+HealBot_Action_luVars["FluidBarAlphaUpdate"]
                if aufbSetBValue>xButton.status.b then 
                    aufbSetBValue=xButton.status.b
                else
                    aufbButtonActive=true
                end
            else
                aufbSetBValue=xButton.status.b
            end
            if aufbAlphaValue>xButton.status.alpha then
                aufbSetValue=aufbAlphaValue-HealBot_Action_luVars["FluidBarAlphaUpdate"]
                if aufbSetValue<xButton.status.alpha then 
                    aufbSetValue=xButton.status.alpha
                else
                    aufbButtonActive=true
                end
            elseif aufbAlphaValue<xButton.status.alpha then
                aufbSetValue=aufbAlphaValue+HealBot_Action_luVars["FluidBarAlphaUpdate"]
                if aufbSetValue>xButton.status.alpha then 
                    aufbSetValue=xButton.status.alpha
                else
                    aufbButtonActive=true
                end
            else
                aufbSetValue=xButton.status.alpha
            end
            xButton.gref["Bar"]:SetStatusBarColor(aufbSetRValue,aufbSetGValue,aufbSetBValue,aufbSetValue)
        end
        if not aufbButtonActive then
            HealBot_Fluid_BarButtonsAlpha[id]=nil
        else
            HealBot_Action_luVars["FluidBarAlphaInUse"]=true
        end
    end

    for id,xButton in pairs(HealBot_Fluid_EmergButtonsAlpha) do
        aufbButtonActive=false
        aufbRValue,aufbGValue,aufbBValue,aufbAlphaValue=xButton.bar:GetStatusBarColor()
        aufbRValue=HealBot_Comm_round(aufbRValue, 2)
        aufbGValue=HealBot_Comm_round(aufbGValue, 2)
        aufbBValue=HealBot_Comm_round(aufbBValue, 2)
        aufbAlphaValue=HealBot_Comm_round(aufbAlphaValue, 2)
        if aufbRValue>xButton.r then
            aufbSetRValue=aufbRValue-HealBot_Action_luVars["FluidBarAlphaUpdate"]
            if aufbSetRValue<xButton.r then 
                aufbSetRValue=xButton.r
            else
                aufbButtonActive=true
            end
        elseif aufbRValue<xButton.r then
            aufbSetRValue=aufbRValue+HealBot_Action_luVars["FluidBarAlphaUpdate"]
            if aufbSetRValue>xButton.r then 
                aufbSetRValue=xButton.r
            else
                aufbButtonActive=true
            end
        else
            aufbSetRValue=xButton.r
        end
        if aufbGValue>xButton.g then
            aufbSetGValue=aufbGValue-HealBot_Action_luVars["FluidBarAlphaUpdate"]
            if aufbSetGValue<xButton.g then 
                aufbSetGValue=xButton.g
            else
                aufbButtonActive=true
            end
        elseif aufbGValue<xButton.g then
            aufbSetGValue=aufbGValue+HealBot_Action_luVars["FluidBarAlphaUpdate"]
            if aufbSetGValue>xButton.g then 
                aufbSetGValue=xButton.g
            else
                aufbButtonActive=true
            end
        else
            aufbSetGValue=xButton.g
        end
        if aufbBValue>xButton.b then
            aufbSetBValue=aufbBValue-HealBot_Action_luVars["FluidBarAlphaUpdate"]
            if aufbSetBValue<xButton.b then 
                aufbSetBValue=xButton.b
            else
                aufbButtonActive=true
            end
        elseif aufbBValue<xButton.b then
            aufbSetBValue=aufbBValue+HealBot_Action_luVars["FluidBarAlphaUpdate"]
            if aufbSetBValue>xButton.b then 
                aufbSetBValue=xButton.b
            else
                aufbButtonActive=true
            end
        else
            aufbSetBValue=xButton.b
        end
        if aufbAlphaValue>xButton.a then
            aufbSetValue=aufbAlphaValue-HealBot_Action_luVars["FluidBarAlphaUpdate"]
            if aufbSetValue<xButton.a then 
                aufbSetValue=xButton.a
            else
                aufbButtonActive=true
            end
        elseif aufbAlphaValue<xButton.a then
            aufbSetValue=aufbAlphaValue+HealBot_Action_luVars["FluidBarAlphaUpdate"]
            if aufbSetValue>xButton.a then 
                aufbSetValue=xButton.a
            else
                aufbButtonActive=true
            end
        else
            aufbSetValue=xButton.a
        end
        xButton.bar:SetStatusBarColor(aufbSetRValue,aufbSetGValue,aufbSetBValue,aufbSetValue)
        if not aufbButtonActive then
            HealBot_Fluid_EmergButtonsAlpha[id]=nil
        else
            HealBot_Action_luVars["FluidBarAlphaInUse"]=true
        end
    end
    if HealBot_Action_luVars["FluidBarAlphaInUse"] then
        C_Timer.After(HealBot_Action_luVars["FluidBarAlphaFreq"], HealBot_Action_UpdateFluidBarsAlpha)
    end
    --HealBot_Aux_setLuVars("FluidBarAlphaInUse", HealBot_Action_luVars["FluidBarAlphaInUse"])
end

local erButton=nil
local prevState=0
local emergHealthCol={[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,}
function HealBot_Action_EmergBarCheck(button, force)
    if Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][button.frame]["USE"] then
        erButton=HealBot_Emerg_Button[button.id]
		if button.status.current<HealBot_Unit_Status["DEAD"] and button.health.current>0 then
			if Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][button.frame]["DEBUFFBARCOL"] and button.aura.debuff.colbar>0 then
                erButton.state=1
                HealBot_Action_EmergBarUpdate(button, erButton, (HealBot_Options_retDebuffCureSpell(button.aura.debuff.type) or button.status.rangespell), button.aura.debuff.r, button.aura.debuff.g, button.aura.debuff.b)
            elseif Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][button.frame]["BUFFBARCOL"] and button.aura.buff.colbar>0 then
                erButton.state=2
                HealBot_Action_EmergBarUpdate(button, erButton, button.aura.buff.name, button.aura.buff.r, button.aura.buff.g, button.aura.buff.b)
			else
                prevState=erButton.state
                if button.health.pct<Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][button.frame]["CRITICAL"] then
                    erButton.state=4
                elseif button.health.pct<Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][button.frame]["INJURED"] then
                    erButton.state=3
                else
                    erButton.state=0
                end
                if erButton.state~=prevState or force or 
                  (erButton.state>2 and emergHealthCol[button.frame]) then
                    HealBot_Action_EmergBarUpdate(button, erButton, HealBot_RangeSpells["HEAL"])
                end
            end
		elseif erButton.state>0 then
			erButton.state=0
			HealBot_Action_EmergBarUpdate(button, erButton, HealBot_RangeSpells["HEAL"])
		end
    end
end

function HealBot_Action_EmergHealthCol()
    for x=1,9 do
        if Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][x]["BARCOL"]==1 or 
           Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][x]["BARCOL"]==4 then
            emergHealthCol[x]=true
        else
            emergHealthCol[x]=false
        end
    end
end

local ebRange=0
function HealBot_Action_EmergBarUpdate(button, eButton, rSpell, r, g, b)
	if r then
		eButton.r,eButton.g,eButton.b=r, g, b
	elseif Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][button.frame]["BARCOL"]==1 then
		eButton.r,eButton.g,eButton.b=button.health.rcol, button.health.gcol, 0
	elseif Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][button.frame]["BARCOL"]==2 then
		eButton.r,eButton.g,eButton.b=button.text.r,button.text.g,button.text.b
	elseif Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][button.frame]["BARCOL"]==4 then
        eButton.r,eButton.g,eButton.b = button.health.mixcolr, button.health.mixcolg, button.health.mixcolb
	elseif eButton.state==4 then
		eButton.r=Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][button.frame]["CR"]
		eButton.g=Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][button.frame]["CG"]
		eButton.b=Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][button.frame]["CB"]
	elseif eButton.state==3 then
		eButton.r=Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][button.frame]["IR"]
		eButton.g=Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][button.frame]["IG"]
		eButton.b=Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][button.frame]["IB"]
	else
		eButton.r=Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][button.frame]["HR"]
		eButton.g=Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][button.frame]["HG"]
		eButton.b=Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][button.frame]["HB"]
	end
	if eButton.state>0 then
        if button.status.rangespell==rSpell then
            ebRange=button.status.range
        else
            ebRange=HealBot_UnitInRangeExc30(button, rSpell)
        end
        if ebRange>0 then
            eButton.a=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][button.frame]["A"],1)
        else
            eButton.a=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][button.frame]["OA"],1)
        end
	else
		eButton.a=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][button.frame]["DA"],1)
	end

    if HealBot_Action_luVars["FluidAlphaInUse"] then
        HealBot_Fluid_EmergButtonsAlpha[button.id]=eButton
        if not HealBot_Action_luVars["FluidBarAlphaInUse"] then
            HealBot_Action_UpdateFluidBarsAlpha()
        end
    else
        eButton.bar:SetStatusBarColor(eButton.r,eButton.g,eButton.b,eButton.a)
    end
end

local auhiHiPct, auhiHiHealsIn=1,0
function HealBot_Action_UpdateHealsInButton(button)
    auhiHiHealsIn=button.health.incoming
    if Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IC"]<2 then auhiHiHealsIn=0 end
    
    if auhiHiHealsIn>0 and button.status.enabled then
        auhiHiPct = button.health.current+button.health.incoming
        if auhiHiPct<button.health.max then 
            auhiHiPct=auhiHiPct/button.health.max  
         else
            auhiHiPct=1;
        end
        button.health.inhptc=floor(auhiHiPct*1000)
        if (Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IC"] == 4) then -- Incoming Heal Bar Colour = "Custom"
            if auhiHiPct>Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IIT"] then
                button.health.inhealr=Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IR"]
                button.health.inhealg=Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IG"]
                button.health.inhealb=Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IB"]
            elseif auhiHiPct>Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["ICT"] then
                button.health.inhealr=Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IIR"]
                button.health.inhealg=Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IIG"]
                button.health.inhealb=Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IIB"]
            else
                button.health.inhealr=Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["ICR"]
                button.health.inhealg=Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["ICG"]
                button.health.inhealb=Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["ICB"]
            end
        elseif (Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IC"] == 3) then -- Incoming Heal Bar Colour = "Future Health"
            button.health.inhealr, button.health.inhealg = HealBot_Action_BarColourPct(auhiHiPct)
            button.health.inhealb=0
        elseif (Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IC"] == 5) then -- Incoming Heal Bar Colour = "Class Health Mix"
            button.health.inhealr,button.health.inhealg,button.health.inhealb = button.health.mixcolr, button.health.mixcolg, button.health.mixcolb
        else
            button.health.inhealr,button.health.inhealg,button.health.inhealb = button.health.rcol, button.health.gcol,0
        end
        if button.status.range==1 then
            button.health.inheala=HealBot_Action_BarColourAlpha(button, (Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IA"]*button.status.alpha),2)
        else
            button.health.inheala=HealBot_Action_BarColourAlpha(button, (Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IA"]*(button.status.alpha/3)),2)
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
    --HealBot_setCall("HealBot_Action_UpdateHealsInButton")
end

local auaHaPct, auaUnitHealsIn, auaUnitAbsorbsIn=1,0,0
function HealBot_Action_UpdateAbsorbsButton(button)
    auaUnitAbsorbsIn=button.health.absorbs
    if Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AC"]<2 then auaUnitAbsorbsIn=0 end
    
    if auaUnitAbsorbsIn>0 and button.status.enabled then
        if Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IC"]<2 then 
            auaUnitHealsIn=0 
        else
            auaUnitHealsIn=button.health.incoming
        end
        auaHaPct = button.health.current+auaUnitHealsIn+auaUnitAbsorbsIn
        if auaHaPct<button.health.max then
            auaHaPct=auaHaPct/button.health.max
        else
            auaHaPct=1;
        end
        button.health.abptc=floor(auaHaPct*1000)
        if (Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AC"] == 4) then -- Incoming Heal Bar Colour = "Custom"
            if auaHaPct>Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AIT"] then
                button.health.absorbr=Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AR"]
                button.health.absorbg=Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AG"]
                button.health.absorbb=Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AB"]
            elseif auaHaPct>Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["ACT"] then
                button.health.absorbr=Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AIR"]
                button.health.absorbg=Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AIG"]
                button.health.absorbb=Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AIB"]
            else
                button.health.absorbr=Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["ACR"]
                button.health.absorbg=Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["ACG"]
                button.health.absorbb=Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["ACB"]
            end
        elseif (Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AC"] == 5) then -- Incoming Heal Bar Colour = "Class Health Mix"
            button.health.absorbr,button.health.absorbg,button.health.absorbb = button.health.mixcolr, button.health.mixcolg, button.health.mixcolb
        elseif (Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AC"] == 3) then -- Incoming Heal Bar Colour = "Future Health"
            button.health.absorbr, button.health.absorbg = HealBot_Action_BarColourPct(auaHaPct)
            button.health.absorbb=0
        else
            button.health.absorbr,button.health.absorbg,button.health.absorbb = button.health.rcol, button.health.gcol,0
        end
        if button.status.range==1 then
            button.health.absorba=HealBot_Action_BarColourAlpha(button, (Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AA"]*button.status.alpha),2)
        else
            button.health.absorba=HealBot_Action_BarColourAlpha(button, (Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AA"]*(button.status.alpha/3)),2)
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
    --HealBot_setCall("HealBot_Action_UpdateAbsorbsButton")
end
               
local ubbHcR, ubbHcG, ubbHcB=0,0,0
function HealBot_Action_UpdateHealthBackgroundBorderCustom(button)
    if button.health.pct>Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BORIT"] then
        button.gref["BackBorder"]:SetBackdropBorderColor(Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BORR"],
                                                         Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BORG"],
                                                         Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BORB"],
                                                         HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BORA"], 1))
    elseif button.health.pct>Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BORCT"] then
        button.gref["BackBorder"]:SetBackdropBorderColor(Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BORIR"],
                                                         Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BORIG"],
                                                         Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BORIB"],
                                                         HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BORA"], 1))
    else
        button.gref["BackBorder"]:SetBackdropBorderColor(Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BORCR"],
                                                         Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BORCG"],
                                                         Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BORCB"],
                                                         HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BORA"], 1))
    end
end

function HealBot_Action_UpdateHealthBackgroundBorder(button)
    if Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BORDER"]==2 then
        button.gref["BackBorder"]:SetBackdropBorderColor(button.health.rcol, button.health.gcol,0,HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BORA"], 1));
    elseif Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BORDER"]==4 then
        HealBot_Action_UpdateHealthBackgroundBorderCustom(button)
    elseif Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BORDER"]==5 then
        button.gref["BackBorder"]:SetBackdropBorderColor(button.health.mixcolr, button.health.mixcolg,button.health.mixcolb,HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BORA"], 1));
    elseif Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BORDER"]>5 then
        if button.plugin.colbar>0 then
            button.gref["BackBorder"]:SetBackdropBorderColor(button.plugin.r,button.plugin.g,button.plugin.b,HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BORA"], 1));
        elseif button.aura.debuff.colbar>0 then
            button.gref["BackBorder"]:SetBackdropBorderColor(button.aura.debuff.r,button.aura.debuff.g,button.aura.debuff.b,HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BORA"], 1));
        elseif button.aggro.status>Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["ALERT"] then
            button.gref["BackBorder"]:SetBackdropBorderColor(1,0,0,HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BORA"], 1));
        elseif button.aura.buff.colbar>0 then
            button.gref["BackBorder"]:SetBackdropBorderColor(button.aura.buff.r,button.aura.buff.g,button.aura.buff.b,HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BORA"], 1));
        elseif Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BORDER"]==6 then
            button.gref["BackBorder"]:SetBackdropBorderColor(button.text.r,button.text.g,button.text.b,HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BORA"], 1))
        elseif Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BORDER"]==7 then
            HealBot_Action_UpdateHealthBackgroundBorderCustom(button)
        else
            button.gref["BackBorder"]:SetBackdropBorderColor(0,0,0,0)
        end
    end
end

function HealBot_Action_UpdateBackgroundBorder(button)
    if not HealBot_Hazard_Buttons[button.id] and button.frame>0 then
        if Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BORDER"]>1 then
            if button.status.current<HealBot_Unit_Status["DEAD"] and Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BORDER"]~=3 then
                HealBot_Action_UpdateHealthBackgroundBorder(button) 
            elseif Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BORDER"]==8 then
                button.gref["BackBorder"]:SetBackdropBorderColor(0,0,0,0)
            else
                if button.status.current>HealBot_Unit_Status["PLUGINBARCOL"] then
                    ubbHcR,ubbHcG,ubbHcB = 0, 0, 0
                else
                    ubbHcR,ubbHcG,ubbHcB = button.text.r,button.text.g,button.text.b
                end
                button.gref["BackBorder"]:SetBackdropBorderColor(ubbHcR,ubbHcG,ubbHcB,HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BORA"],1))
            end
        else
            button.gref["BackBorder"]:SetBackdropBorderColor(0,0,0,0)
        end
    end
end

function HealBot_Action_UpdateHealthBackgroundCustom(button)
    if button.health.pct>Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BIT"] then
        button.gref["Back"]:SetStatusBarColor(Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BR"],
                                              Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BG"],
                                              Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BB"],
                                              HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BA"], 1.5))
    elseif button.health.pct>Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BCT"] then
        button.gref["Back"]:SetStatusBarColor(Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BIR"],
                                              Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BIG"],
                                              Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BIB"],
                                              HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BA"], 1.5))
    else
        button.gref["Back"]:SetStatusBarColor(Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BCR"],
                                              Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BCG"],
                                              Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BCB"],
                                              HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BA"], 1.5))
    end
end

function HealBot_Action_UpdateHealthBackground(button)
    if Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BACK"]==1 then
        button.gref["Back"]:SetStatusBarColor(button.health.rcol, button.health.gcol,0,HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BA"], 1.5));
    elseif Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BACK"]==3 then
        HealBot_Action_UpdateHealthBackgroundCustom(button)
    elseif Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BACK"]==4 then
        button.gref["Back"]:SetStatusBarColor(button.health.mixcolr, button.health.mixcolg,button.health.mixcolb,HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BA"], 1.5));
    elseif Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BACK"]>4 then
        if button.plugin.colbar>0 then
            button.gref["Back"]:SetStatusBarColor(button.plugin.r,button.plugin.g,button.plugin.b,HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BA"], 1.5));
        elseif button.aura.debuff.colbar>0 then
            button.gref["Back"]:SetStatusBarColor(button.aura.debuff.r,button.aura.debuff.g,button.aura.debuff.b,HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BA"], 1.5));
        elseif button.aggro.status>Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["ALERT"] then
            button.gref["Back"]:SetStatusBarColor(1,0,0,HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BA"], 1.5));
        elseif button.aura.buff.colbar>0 then
            button.gref["Back"]:SetStatusBarColor(button.aura.buff.r,button.aura.buff.g,button.aura.buff.b,HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BA"], 1.5));
        elseif Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BACK"]==5 then
            button.gref["Back"]:SetStatusBarColor(button.text.r,button.text.g,button.text.b,HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BA"], 1.5))
        elseif Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BACK"]==6 then
            HealBot_Action_UpdateHealthBackgroundCustom(button)
        else
            button.gref["Back"]:SetStatusBarColor(0,0,0,0)
        end
    end
end

function HealBot_Action_UpdateBackground(button)
    if button.status.current<HealBot_Unit_Status["DEAD"] and Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BACK"]~=2 then
            HealBot_Action_UpdateHealthBackground(button)
    elseif Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BACK"]==7 then
        button.gref["Back"]:SetStatusBarColor(0,0,0,0)
    else
        if button.status.current>HealBot_Unit_Status["PLUGINBARCOL"] then
            ubbHcR,ubbHcG,ubbHcB = 0, 0, 0
        else
            ubbHcR,ubbHcG,ubbHcB = button.text.r,button.text.g,button.text.b
        end
        button.gref["Back"]:SetStatusBarColor(ubbHcR,ubbHcG,ubbHcB,HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BA"],1.5));
    end
    HealBot_Action_UpdateBackgroundBorder(button)
    --HealBot_setCall("HealBot_Action_UpdateBackground")
end

function HealBot_Action_setState(button, state)
    button.status.current=state
    if button.status.current>HealBot_Unit_Status["PLUGINBARCOL"] then 
        if button.hotbars.state then HealBot_Action_BarHotRemove(button) end
        if HealBot_Hazard_Buttons[button.id] then 
            HealBot_Action_DisableBorderHazard(button)
            if button.hazard.debuff then button.hazard.debuff=false end
        end
    end
end

function HealBot_Action_setEnabled(button, enabled, a)
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
    button.gref["Absorb"]:SetStatusBarColor(button.health.absorbr,button.health.absorbg,button.health.absorbb,button.health.absorba);
end

function HealBot_Action_UpdateInHealStatusBarColor(button)
    button.gref["InHeal"]:SetStatusBarColor(button.health.inhealr,button.health.inhealg,button.health.inhealb,button.health.inheala);
end

function HealBot_Action_UpdateHealthStatusBarColor(button)
    if not HealBot_Action_luVars["TestBarsOn"] then
        if not HealBot_Action_luVars["FluidAlphaInUse"] then
            button.gref["Bar"]:SetStatusBarColor(button.status.r,button.status.g,button.status.b,button.status.alpha);
        else
            HealBot_Fluid_BarButtonsAlpha[button.id]=button
            if not HealBot_Action_luVars["FluidBarAlphaInUse"] then
                HealBot_Action_UpdateFluidBarsAlpha()
            end
            --HealBot_Aux_setLuVars("FluidBarAlphaInUse", true)
        end
    end
end

local curAlpha=0
function HealBot_Action_UpdatePluginBarCol(button, r, g, b)
    if button.request.colbar>0 and button.request.colbar<3 then
        button.plugin.colbar=button.request.colbar
    elseif button.buffwatch.colbar>0 and button.buffwatch.colbar<3 then
        button.plugin.colbar=button.buffwatch.colbar
    elseif button.healthwatch.colbar>0 and button.healthwatch.colbar<3 then
        button.plugin.colbar=button.healthwatch.colbar
    elseif button.manawatch.colbar>0 and button.manawatch.colbar<3 then
        button.plugin.colbar=button.manawatch.colbar
    else
        button.plugin.colbar=0
    end
    if button.plugin.colbar>0 then
        if r then
            button.plugin.r,button.plugin.g,button.plugin.b=r,g,b
            if button.plugin.colbar==2 then
                button.status.r,button.status.g,button.status.b=r, g, b
                HealBot_Action_setState(button, HealBot_Unit_Status["PLUGINBARCOL"])
                if button.status.range==1 then  
                    curAlpha=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"],1)
                else
                    curAlpha=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["ORA"],1)
                end
                HealBot_Action_setEnabled(button, true, curAlpha)
            end
            HealBot_Action_UpdateHealthStatusBarColor(button)
            HealBot_Action_UpdateBackground(button)
        end
    elseif UnitExists(button.unit) then
        if button.status.current>HealBot_Unit_Status["DEBUFFBARCOL"] and button.status.current<HealBot_Unit_Status["DEAD"] then HealBot_Action_setState(button, HealBot_Unit_Status["CHECK"]) end
        HealBot_Action_UpdateDebuffButton(button)
    end
end

function HealBot_Action_UpdateRequestButton(button, r, g, b)
    HealBot_Action_UpdatePluginBarCol(button, r, g, b)
    if button.request.colbar==3 then
        HealBot_Action_EnableBorderHazardType(button, r, g, b, "PLUGIN")
    end
end

function HealBot_Action_UpdateBuffWatchButton(button, r, g, b)
    HealBot_Action_UpdatePluginBarCol(button, r, g, b)
    if button.buffwatch.colbar==3 then
        HealBot_Action_EnableBorderHazardType(button, r, g, b, "PLUGIN")
    end
end

function HealBot_Action_UpdateHealthWatchButton(button, r, g, b)
    HealBot_Action_UpdatePluginBarCol(button, r, g, b)
    if button.healthwatch.colbar==3 then
        HealBot_Action_EnableBorderHazardType(button, r, g, b, "PLUGIN")
    end
end

function HealBot_Action_UpdateManaWatchButton(button, r, g, b)
    HealBot_Action_UpdatePluginBarCol(button, r, g, b)
    if button.manawatch.colbar==3 then
        HealBot_Action_EnableBorderHazardType(button, r, g, b, "PLUGIN")
    end
end

function HealBot_Action_UpdateDebuffButton(button)
    button.aura.debuffcol=false
    if button.status.current<HealBot_Unit_Status["PLUGINBARCOL"] then
        if button.aura.debuff.colbar==2 then
            if button.icon.debuff.showcol then
                if button.aura.debuff.curespell and button.status.rangespell~=button.aura.debuff.curespell then
                    button.status.rangespellspecial=button.aura.debuff.curespell
                    HealBot_Action_SetRangeSpell(button)
                end
                if button.status.range>(HealBot_Config_Cures.HealBot_CDCWarnRange_Bar-3) then
                    button.status.r,button.status.g,button.status.b=button.aura.debuff.r,button.aura.debuff.g,button.aura.debuff.b
                    HealBot_Action_setState(button, HealBot_Unit_Status["DEBUFFBARCOL"])
                    button.aura.debuffcol=true
                    if button.status.range==1 then  
                        curAlpha=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"],1)
                    else
                        curAlpha=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["ORA"],1)
                    end
                    HealBot_Action_setEnabled(button, true, curAlpha)
                    HealBot_Action_UpdateHealthStatusBarColor(button)
                    if Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][button.frame]["DEBUFFBARCOL"] then
                        HealBot_Action_EmergBarCheck(button)
                    end
                    HealBot_Action_UpdateBackground(button)
                else
                    HealBot_Action_setState(button, HealBot_Unit_Status["DEBUFFNOCOL"])
                    HealBot_Action_UpdateBuffButton(button)
                end
            else
                if button.status.current>HealBot_Unit_Status["BUFFBARCOL"] and button.status.current<HealBot_Unit_Status["DEAD"] then HealBot_Action_setState(button, HealBot_Unit_Status["CHECK"]) end
                HealBot_Action_UpdateBuffButton(button)
            end
        else
            if button.status.current>HealBot_Unit_Status["BUFFBARCOL"] and button.status.current<HealBot_Unit_Status["DEAD"] then HealBot_Action_setState(button, HealBot_Unit_Status["CHECK"]) end
            HealBot_Action_UpdateBuffButton(button)
        end
    else
        HealBot_Action_UpdateHealthButtonState(button)
    end
      --HealBot_setCall("HealBot_Action_UpdateDebuffButton")
end

function HealBot_Action_UpdateBuffButton(button)
    button.aura.buffcol=false
    if button.aura.buff.colbar==2 then 
        if button.aura.buff.showcol then
            if button.status.current<HealBot_Unit_Status["DEBUFFNOCOL"] and button.aura.buff.missingbuff and button.status.rangespell~=button.aura.buff.missingbuff then
                button.status.rangespellspecial=button.aura.buff.missingbuff
                HealBot_Action_SetRangeSpell(button)
            end
            if button.status.range>(HealBot_Config_Buffs.HealBot_CBWarnRange_Bar-3) then
                HealBot_Action_setState(button, HealBot_Unit_Status["BUFFBARCOL"])
                button.aura.buffcol=true
                button.status.r,button.status.g,button.status.b=button.aura.buff.r,button.aura.buff.g,button.aura.buff.b
                if button.status.range==1 then  
                    curAlpha=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"], 1)
                else
                    curAlpha=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["ORA"], 1)
                end
                HealBot_Action_setEnabled(button, true, curAlpha)
                HealBot_Action_UpdateHealthStatusBarColor(button)
                if Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][button.frame]["BUFFBARCOL"] then
                    HealBot_Action_EmergBarCheck(button)
                end
                HealBot_Action_UpdateBackground(button)
            else
                HealBot_Action_setState(button, HealBot_Unit_Status["BUFFNOCOL"])
                HealBot_Action_UpdateHealthButton(button)
            end
        else
            if button.status.current<HealBot_Unit_Status["DEBUFFNOCOL"] and button.status.current>HealBot_Unit_Status["ENABLEDIR"] then HealBot_Action_setState(button, HealBot_Unit_Status["CHECK"]) end
            HealBot_Action_UpdateHealthButton(button)
        end
    else
        if button.status.current<HealBot_Unit_Status["DEBUFFNOCOL"] and button.status.current>HealBot_Unit_Status["ENABLEDIR"] then HealBot_Action_setState(button, HealBot_Unit_Status["CHECK"]) end
        HealBot_Action_UpdateHealthButton(button)
    end
      --HealBot_setCall("HealBot_Action_UpdateBuffButton")
end

local ripHasResStart={}
local ripHasResEnd={}
local ripHadResStart={}
local ripHadResEnd={}
function HealBot_Action_UpdateUnitDeadButtons(button, TimeNow, state)
    if state==1 then
        HealBot_Action_setState(button, HealBot_Unit_Status["RES"])
        HealBot_Text_setNameTag(button)
        button.status.hasres=1
        if HealBot_Action_luVars["pluginTimeToLive"] and button.status.plugin then HealBot_Plugin_TimeToLive_UnitUpdate(button) end
        HealBot_Aux_UpdateResBar(button, HEALBOT_WORD_RESURRECTION, ripHasResStart[button.guid]*1000, (ripHasResEnd[button.guid]+1.5)*1000, false)
    else
        ripHasResEnd[button.guid]=false
        ripHasResStart[button.guid]=false
        if state==2 then
            button.status.hasres=2
            if HealBot_Action_luVars["pluginTimeToLive"] and button.status.plugin then HealBot_Plugin_TimeToLive_UnitUpdate(button) end
            HealBot_Aux_UpdateResBar(button, HEALBOT_WORD_RESURRECTION, ripHadResStart[button.guid]*1000, ripHadResEnd[button.guid]*1000, true)
        else
            ripHadResEnd[button.guid]=false
            ripHadResStart[button.guid]=false
            HealBot_Action_setState(button, HealBot_Unit_Status["DEAD"])
            button.status.resstart=0
            HealBot_Text_setNameTag(button)
            button.status.hasres=false
            if HealBot_Action_luVars["pluginTimeToLive"] and button.status.plugin then HealBot_Plugin_TimeToLive_UnitUpdate(button) end
            HealBot_Aux_UpdateResBar(button, HEALBOT_DEAD_LABEL)
        end
    end
    HealBot_Text_UpdateButton(button)
end

function HealBot_Action_SetResTimes(button, TimeNow)
    ripHasResStart[button.guid]=TimeNow
    button.status.resstart=TimeNow
    if HealBot_Data["UILOCK"] then
        if HEALBOT_GAME_VERSION>3 then
            ripHasResEnd[button.guid]=TimeNow+1.25
        elseif HEALBOT_GAME_VERSION>2 then
            ripHasResEnd[button.guid]=TimeNow+1.5
        else
            ripHasResEnd[button.guid]=TimeNow+1.75
        end
    else
        if HEALBOT_GAME_VERSION>3 then
            ripHasResEnd[button.guid]=TimeNow+7
        elseif HEALBOT_GAME_VERSION>2 then
            ripHasResEnd[button.guid]=TimeNow+8
        else
            ripHasResEnd[button.guid]=TimeNow+9
        end
    end
end

function HealBot_Action_UpdateUnitNotDead(button)
    HealBot_Action_setState(button, HealBot_Unit_Status["CHECK"])
    button.status.resstart=0
    ripHasResEnd[button.guid]=false
    ripHadResEnd[button.guid]=false
    button.status.rangespellspecial=false
    HealBot_Action_SetRangeSpell(button)
    if button.player then 
        HealBot_Data["PALIVE"]=true
        HealBot_Action_ResetActiveUnitStatus()
        HealBot_Timers_Set("AURA","PlayerCheckExtended")
    end
    HealBot_OnEvent_UnitHealth(button)
    HealBot_Action_UpdateBackground(button)
    button.status.hasres=false
    if HealBot_Action_luVars["pluginTimeToLive"] and button.status.plugin then HealBot_Plugin_TimeToLive_UnitUpdate(button) end
    button.text.nameupdate=true
    HealBot_Text_setNameTag(button)
    HealBot_Text_UpdateText(button)
    HealBot_RefreshUnit(button)
    HealBot_Check_UnitAura(button)
    HealBot_Aux_ClearResBar(button)
end

function HealBot_Action_UpdateTheDeadButton(button, TimeNow)
    if button.frame<10 then
        if HealBot_Action_IsUnitDead(button) then
            if not UnitIsDeadOrGhost(button.unit) then
                HealBot_Action_UpdateUnitNotDead(button)
            elseif not ripHadResEnd[button.guid] and (UnitHasIncomingResurrection(button.unit) or HealBot_MassRes()) then
                if not ripHasResEnd[button.guid] and not ripHadResEnd[button.guid] then
                    HealBot_Action_SetResTimes(button, TimeNow)
                    HealBot_Action_UpdateUnitDeadButtons(button, TimeNow, 1) 
                elseif ripHasResStart[button.guid] and ripHasResStart[button.guid]~=button.status.resstart then
                    button.status.resstart=ripHasResStart[button.guid]
                    HealBot_Action_UpdateUnitDeadButtons(button, TimeNow, 1) 
                end
            elseif ripHasResEnd[button.guid] then
                if ripHasResEnd[button.guid]<TimeNow then
                    ripHadResStart[button.guid]=TimeNow
                    button.status.resstart=TimeNow
                    ripHadResEnd[button.guid]=TimeNow+30
                    HealBot_Action_UpdateUnitDeadButtons(button, TimeNow, 2)
                else
                    HealBot_Action_UpdateUnitDeadButtons(button, TimeNow, 3)
                end
            elseif ripHadResEnd[button.guid] then
                if ripHadResEnd[button.guid]<TimeNow then
                    HealBot_Action_UpdateUnitDeadButtons(button, TimeNow, 3)
                elseif ripHadResStart[button.guid] and ripHadResStart[button.guid]~=button.status.resstart then
                    button.status.resstart=ripHadResStart[button.guid]
                    HealBot_Action_UpdateUnitDeadButtons(button, TimeNow, 2)
                end
            elseif button.status.resstart>0 then
                HealBot_Action_UpdateUnitDeadButtons(button, TimeNow, 3)
            end
        elseif UnitIsDeadOrGhost(button.unit) and not UnitIsFeignDeath(button.unit) then
            if HealBot_PluginUpdate_TimeToLive[button.guid] then
                --HealBot_AddDebug("Res Plugin Update for "..(UnitName(button.unit) or "_nil"),"Res",true)
                HealBot_PluginUpdate_TimeToLive[button.guid]=false
                HealBot_Plugin_TimeToLive_UnitUpdate(button, true)
            end
            HealBot_Action_setState(button, HealBot_Unit_Status["DEAD"])
            button.status.rangespellspecial=HealBot_Action_retResSpell(button)
            HealBot_Action_SetRangeSpell(button)
            if button.player then 
                HealBot_Data["PALIVE"]=false
                HealBot_Timers_Set("AURA","PlayerCheckExtended")
                HealBot_Action_ResetActiveUnitStatus()
                HealBot_setLuVars("pluginCDsCheckExisting", 0)
                --if HealBot_retLuVars("pluginRequests") then HealBot_Plugin_Requests_PlayerDead() end
                if HealBot_retLuVars("pluginBuffWatch") then HealBot_Plugin_BuffWatch_PlayerDead() end
                if HealBot_retLuVars("pluginHealthWatch") then HealBot_Plugin_HealthWatch_PlayerDead() end
                if HealBot_retLuVars("pluginManaWatch") then HealBot_Plugin_ManaWatch_PlayerDead() end
            end
            button.aura.buff.nextcheck=false
            button.text.nameupdate=true
            HealBot_UpdateUnitClear(button)
            HealBot_Text_setNameTag(button)
            HealBot_Text_UpdateText(button)
            HealBot_Action_setEnabled(button, true, button.status.alpha)
            if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWCLASS"] then
                HealBot_Action_SetClassIconTexture(button)
            end
            if Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][button.frame]["SHOW"] then 
                HealBot_OnEvent_RaidTargetUpdate(button)
            end
            HealBot_OnEvent_UnitHealth(button)
            HealBot_Action_UpdateBackground(button)
            if button.health.incoming>0 then HealBot_OnEvent_HealsInUpdate(button) end
            if button.health.absorbs>0 then HealBot_OnEvent_AbsorbsUpdate(button) end
            HealBot_RefreshUnit(button)
            --HealBot_Action_EmergBarCheck(button, true)
            button.status.hasres=false
            if HealBot_Action_luVars["pluginTimeToLive"] and button.status.plugin then HealBot_Plugin_TimeToLive_UnitUpdate(button) end
            HealBot_Aux_UpdateResBar(button, HEALBOT_DEAD_LABEL)
            if button.status.range<1 then
                HealBot_Update_OORBar(button)
            end
        elseif button.status.resstart>0 then
            HealBot_Action_UpdateUnitNotDead(button)
        end
    elseif HealBot_Action_IsUnitDead(button) then
        if not UnitIsDeadOrGhost(button.unit) then
            HealBot_Action_setState(button, HealBot_Unit_Status["CHECK"])
            HealBot_Check_UnitAura(button)
            HealBot_Action_UpdateBackground(button)
            HealBot_RefreshUnit(button)
        end
    elseif UnitIsDeadOrGhost(button.unit) then
        if not UnitIsFeignDeath(button.unit) then
            HealBot_Action_setState(button, HealBot_Unit_Status["DEAD"])
            HealBot_Action_UpdateBackground(button)
            HealBot_RefreshUnit(button)
        end
    elseif button.status.resstart>0 then
        button.status.resstart=0
        HealBot_Text_setNameTag(button)
        HealBot_Text_UpdateButton(button)
        HealBot_Aux_ClearResBar(button)
    end
      --HealBot_setCall("HealBot_Action_UpdateTheDeadButton")
end

function HealBot_Action_UpdatePlugin_TimeToLive(guid)
    HealBot_PluginUpdate_TimeToLive[guid]=true
end

function HealBot_Action_IsUnitDead(button, guid)
    if button then
        if button.status.current>HealBot_Unit_Status["PLUGINBARCOL"] and button.status.current<HealBot_Unit_Status["DC"] then
            return true
        end
    else
        local xButton,pButton = HealBot_Panel_RaidUnitButton(guid)
        if (xButton and HealBot_Action_IsUnitDead(xButton)) or (pButton and HealBot_Action_IsUnitDead(pButton)) then
            return true
        end
    end
    return false
end

function HealBot_Action_UpdateHealthHotBar(button)
    if HealBot_Action_luVars["HotBarsHealth"]>0 then
        if button.isplayer and button.frame<10 and button.status.range>0 and button.health.hpct>0 and (button.health.hpct+button.health.absorbspctc)<HealBot_Action_luVars["HotBarsHealth"] then
            HealBot_Action_BarHotEnable(button, "HEALTH")
        elseif button.hotbars.health then
            HealBot_Action_BarHotDisable(button, "HEALTH")
        end
    end
end

local mixPct=0
function HealBot_Action_UpdateHealthButton(button, healthEvent)
    if healthEvent then
        button.health.pct = button.health.current/button.health.max
        button.health.hpct=floor(button.health.pct*1000)
        button.health.rcol, button.health.gcol=HealBot_Action_BarColourPct(button.health.pct)

        if button.health.hpct>890 then
            button.health.mixcolr, button.health.mixcolg, button.health.mixcolb=button.text.r, button.text.g, button.text.b
        elseif button.health.hpct>640 then
            mixPct=(250-(button.health.hpct-640))/250
            button.health.mixcolr=button.text.r+((1-button.text.r)*mixPct)
            button.health.mixcolg=button.text.g+((1-button.text.g)*mixPct)
            button.health.mixcolb=button.text.b*(button.health.hpct/1000)
        else
            button.health.mixcolr, button.health.mixcolg, button.health.mixcolb=button.health.rcol, button.health.gcol, 0
        end

        if Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NAME"]==1 or
           Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NAME"]==4 then 
            button.text.nameupdate=true 
        end
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTXTANCHOR"]~=4 and
          (Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["HLTH"]==1 or
           Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["HLTH"]==4) then 
            button.text.healthupdate=true 
        end
        HealBot_Action_UpdateHealthHotBar(button)
    end

    if not button.aura.buffcol and not button.aura.debuffcol and button.status.current<HealBot_Unit_Status["PLUGINBARCOL"] then 
        if (Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HLTH"] == 2) then
            button.status.r,button.status.g,button.status.b = button.text.r,button.text.g,button.text.b
        elseif (Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HLTH"] == 1) then
            button.status.r, button.status.g, button.status.b = button.health.rcol, button.health.gcol, 0
        elseif (Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HLTH"] == 4) then
            button.status.r, button.status.g, button.status.b = button.health.mixcolr, button.health.mixcolg, button.health.mixcolb
        elseif button.health.pct>Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HIT"] then
            button.status.r=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HR"]
            button.status.g=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HG"]
            button.status.b=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HB"]
        elseif button.health.pct>Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HCT"] then
            button.status.r=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HIR"]
            button.status.g=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HIG"]
            button.status.b=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HIB"]
        else
            button.status.r=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HCR"]
            button.status.g=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HCG"]
            button.status.b=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HCB"]
        end
    end
    HealBot_Action_UpdateHealthButtonState(button)
end

function HealBot_Action_UpdateHealthButtonState(button)
    if button.status.current<HealBot_Unit_Status["DEAD"] then
        if not button.aura.buffcol and not button.aura.debuffcol and button.status.current<HealBot_Unit_Status["PLUGINBARCOL"] then 
            if button.aggro.status>Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["ALERT"] or HealBot_AlwaysEnabled[button.guid] or button.health.pct<=button.health.alert then
                if button.status.current<HealBot_Unit_Status["BUFFNOCOL"] and button.status.rangespellspecial then
                    button.status.rangespellspecial=false
                    HealBot_Action_SetRangeSpell(button)
                end
                if button.status.range==1 then
                    curAlpha=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"], 1)
                    if button.status.current<HealBot_Unit_Status["BUFFNOCOL"] then HealBot_Action_setState(button, HealBot_Unit_Status["ENABLEDIR"]) end
                else
                    curAlpha=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["ORA"], 1)
                    if button.status.current<HealBot_Unit_Status["BUFFNOCOL"] then HealBot_Action_setState(button, HealBot_Unit_Status["ENABLEDOOR"]) end
                end
                HealBot_Action_setEnabled(button, true, curAlpha)
            else
                if button.status.current<HealBot_Unit_Status["BUFFNOCOL"] then HealBot_Action_setState(button, HealBot_Unit_Status["DISABLED"]) end
                curAlpha=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["DISA"], 1)
                HealBot_Action_setEnabled(button, false, curAlpha)
            end
            HealBot_Action_UpdateHealthStatusBarColor(button)
        end
        HealBot_Action_UpdateHealthBackground(button)
        if not HealBot_Hazard_Buttons[button.id] then
            HealBot_Action_UpdateHealthBackgroundBorder(button)
        end
    else
        button.health.hpct=0
        button.health.current=0
        button.mana.current=0
        button.health.init=true
        button.mana.init=true
        button.gref["Bar"]:SetStatusBarColor(0.2,0.2,0.2,0.4);
    end
    HealBot_Text_setHealthText(button)
    HealBot_Text_UpdateText(button)
    if button.gref["Bar"]:GetValue()~=button.health.hpct then
        if button.health.init or not HealBot_Action_luVars["FluidInUse"] then
            button.gref["Bar"]:SetValue(button.health.hpct)
            button.health.init=false
        else
            HealBot_Action_setFluid_BarButtons(button)
        end
        if button.health.incoming>0 then HealBot_Action_UpdateHealsInButton(button) end
        if button.health.absorbs>0 then HealBot_Action_UpdateAbsorbsButton(button) end
    end
    HealBot_Action_EmergBarCheck(button)
      --HealBot_setCall("HealBot_Action_UpdateHealthButtonState")
end

local HealBot_Action_HotBars={}
function HealBot_Action_BarHotEnable(button, hType)
    if hType=="DEBUFF" then
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
        HealBot_Action_ResetUnitStatus()
    end
end

function HealBot_Action_BarHotRemove(button)
    button.hotbars.state=false
    for x=1,#HealBot_Action_HotBars do
        if HealBot_Action_HotBars[x]==button.id then
            table.remove(HealBot_Action_HotBars, x)
            break
        end
    end
    if #HealBot_Action_HotBars==0 and HealBot_Action_luVars["HotBarsEnabled"] then
        HealBot_Action_luVars["HotBarsEnabled"]=false
        HealBot_Action_ResetUnitStatus()
    end
end

function HealBot_Action_BarHotDisable(button, hType)
    if hType=="DEBUFF" then
        button.hotbars.debuff=false
    else
        button.hotbars.health=false
    end
    if button.hotbars.state and not button.hotbars.debuff and not button.hotbars.health then
        HealBot_Action_BarHotRemove(button)
    end
end

function HealBot_Action_BarColourAlpha(button, a, dMult)
    if HealBot_Action_luVars["GlobalDimming"]>0 then
        a=a/(HealBot_Action_luVars["GlobalDimming"]*dMult)
    elseif HealBot_Action_luVars["FocusGroups"]==2 and button.status.unittype==5 and not HealBot_Action_luVars["FGroups"][button.group] then
        a=a/(HealBot_Action_luVars["FGDimming"]*dMult)
    elseif HealBot_Action_luVars["HotBarsEnabled"] and not button.hotbars.state then
        a=a/(HealBot_Action_luVars["HotBarDimming"]*dMult)
    end
    if button.status.current>=HealBot_Unit_Status["DC"] then
        a=a/2
    end
    return a
end

function HealBot_Action_SetFocusGroups()
    if HealBot_Globals.OverrideEffects["USE"]==2 then
        HealBot_Action_luVars["FocusGroups"]=HealBot_Globals.OverrideEffects["FOCUSGROUPS"]
        HealBot_Action_luVars["FGroups"]=HealBot_Globals.OverrideFocusGroups
        HealBot_Action_luVars["FGDimming"]=HealBot_Globals.OverrideEffects["FGDIMMING"]
    else
        HealBot_Action_luVars["FocusGroups"]=Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["FOCUSGROUPS"]
        HealBot_Action_luVars["FGroups"]=Healbot_Config_Skins.FocusGroups[Healbot_Config_Skins.Current_Skin]
        HealBot_Action_luVars["FGDimming"]=Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["FGDIMMING"]
    end
    HealBot_Timers_Set("SKINS","UpdateTextButtons")
    HealBot_Panel_SetFocusGroups()
    HealBot_Timers_Set("SKINS","QuickFramesChanged")
end

local hacpr, hacpg=1,1 
function HealBot_Action_BarColourPct(hlthPct)
    hacpr, hacpg = 1,1
    if hlthPct>=0.98 then 
        hacpr = 0
    elseif hlthPct<0.98 and hlthPct>=0.65 then 
        hacpr=2.94-(hlthPct*3)
    elseif hlthPct<=0.64 and hlthPct>0.31 then 
        hacpg=(hlthPct-0.31)*3
    elseif hlthPct<=0.31 then 
        hacpg = 0
    end
    --HealBot_setCall("HealBot_Action_BarColourPct")
    return hacpr, hacpg
end

local hbShouldHealSomePlayerFrames={[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,}
local hbShouldHealSomePrivateFrames={[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,}

function HealBot_Action_resetShouldHealSomeFrames()
    for x,_ in pairs(hbShouldHealSomePlayerFrames) do
        hbShouldHealSomePlayerFrames[x]=false;
    end
    for x,_ in pairs(hbShouldHealSomePrivateFrames) do
        hbShouldHealSomePrivateFrames[x]=false;
    end
end

function HealBot_Action_ShouldHealSome(hbCurFrame)
    --HealBot_setCall("HealBot_Action_ShouldHealSome")
    if hbCurFrame<6 then
        if hbShouldHealSomePlayerFrames[hbCurFrame] then
            for _,xButton in pairs(HealBot_Unit_Button) do
                if xButton.frame==hbCurFrame and xButton.status.enabled then
                    return true
                end
            end
        end
        if hbShouldHealSomePrivateFrames[hbCurFrame] then
            for _,xButton in pairs(HealBot_Private_Button) do
                if xButton.frame==hbCurFrame and xButton.status.enabled then
                    return true
                end
            end
        end
    elseif hbCurFrame<8 then
        for _,xButton in pairs(HealBot_Extra_Button) do
            if xButton.frame==hbCurFrame and xButton.status.enabled then
                return true
            end
        end
    elseif hbCurFrame<10 then
        for _,xButton in pairs(HealBot_Pet_Button) do
            if xButton.frame==hbCurFrame and xButton.status.enabled then
                return true
            end
        end
        for _,xButton in pairs(HealBot_Vehicle_Button) do
            if xButton.frame==hbCurFrame and xButton.status.enabled then
                return true
            end
        end
    else
        for _,xButton in pairs(HealBot_Enemy_Button) do
            if xButton.status.enabled then
                return true
            end
        end
    end
    return false
end

local vPowerBarInfo={}
local vPowerBarType,vPowerBarToken,vPowerBarR,vPowerBarG,vPowerBarB=0,"MANA",0,0,0
function HealBot_Action_GetManaBarCol(button)
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
        return vPowerBarInfo.r, vPowerBarInfo.g, vPowerBarInfo.b
    elseif not vPowerBarR then
        vPowerBarInfo = PowerBarColor[vPowerBarType] or PowerBarColor["MANA"];
        return vPowerBarInfo.r, vPowerBarInfo.g, vPowerBarInfo.b
    else
        return vPowerBarR, vPowerBarG, vPowerBarB
    end
end

function HealBot_Action_setButtonManaBarCol(button)
    button.mana.r,button.mana.g,button.mana.b=HealBot_Action_GetManaBarCol(button)
    if button.player and HealBot_Data["TIPUSE"] then
        HealBot_Tooltip_setPlayerPowerCols(button.mana.r,button.mana.g,button.mana.b)
    end
end

function HealBot_Action_hasPowerCounter(frame)
    if HealBot_pcClass[frame] then
        return HealBot_Action_luVars["UnitPowerMax"]
    end
    return 0
end

function HealBot_Action_UpdateAllIndicators(button)
    HealBot_Action_setPowerIndicators(button)
    button.mana.lowcheck=true
    HealBot_Aggro_IndicatorUpdate(button)
end

local hbPowerIndicator=0
function HealBot_Action_setPowerIndicators(button)
    if HealBot_pcClass[button.frame] and button.player and button.status.current<HealBot_Unit_Status["DEAD"] then
        hbPowerIndicator=UnitPower("player", HealBot_pcClass[button.frame])
        local indAlpha=HealBot_Action_BarColourAlpha(button, 1, 1)
        if hbPowerIndicator==1 then
            if button.mana.power~=1 then
                button.mana.power=1
                if Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][button.frame]["PCOL"]==1 then
                    button.gref.indicator.power[1]:SetTexture([[Interface\AddOns\HealBot\Images\indicator_red.tga]])
                end
                button.gref.indicator.power[1]:SetAlpha(indAlpha)
                button.gref.indicator.power[2]:SetAlpha(0)
                button.gref.indicator.power[3]:SetAlpha(0)
                button.gref.indicator.power[4]:SetAlpha(0)
                button.gref.indicator.power[5]:SetAlpha(0)
            end
        elseif hbPowerIndicator==2 then
            if button.mana.power~=2 then
                button.mana.power=2
                if Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][button.frame]["PCOL"]==1 then
                    if HealBot_Action_luVars["UnitPowerMax"]<4 then
                        button.gref.indicator.power[1]:SetTexture([[Interface\AddOns\HealBot\Images\indicator_yellow.tga]]);
                        button.gref.indicator.power[2]:SetTexture([[Interface\AddOns\HealBot\Images\indicator_yellow.tga]]);
                    else
                        button.gref.indicator.power[1]:SetTexture([[Interface\AddOns\HealBot\Images\indicator_orange.tga]]);
                        button.gref.indicator.power[2]:SetTexture([[Interface\AddOns\HealBot\Images\indicator_orange.tga]]);
                    end
                end
                button.gref.indicator.power[1]:SetAlpha(indAlpha)
                button.gref.indicator.power[2]:SetAlpha(indAlpha)
                button.gref.indicator.power[3]:SetAlpha(0)
                button.gref.indicator.power[4]:SetAlpha(0)
                button.gref.indicator.power[5]:SetAlpha(0)
            end
        elseif hbPowerIndicator==3 then
            if button.mana.power~=3 then
                button.mana.power=3
                if Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][button.frame]["PCOL"]==1 then
                    if HealBot_Action_luVars["UnitPowerMax"]<4 then
                        button.gref.indicator.power[1]:SetTexture([[Interface\AddOns\HealBot\Images\indicator_green.tga]]);
                        button.gref.indicator.power[2]:SetTexture([[Interface\AddOns\HealBot\Images\indicator_green.tga]]);
                        button.gref.indicator.power[3]:SetTexture([[Interface\AddOns\HealBot\Images\indicator_green.tga]]);
                    elseif HealBot_Action_luVars["UnitPowerMax"]<5 then
                        button.gref.indicator.power[1]:SetTexture([[Interface\AddOns\HealBot\Images\indicator_lime.tga]]);
                        button.gref.indicator.power[2]:SetTexture([[Interface\AddOns\HealBot\Images\indicator_lime.tga]]);
                        button.gref.indicator.power[3]:SetTexture([[Interface\AddOns\HealBot\Images\indicator_lime.tga]]);
                    else
                        button.gref.indicator.power[1]:SetTexture([[Interface\AddOns\HealBot\Images\indicator_yellow.tga]]);
                        button.gref.indicator.power[2]:SetTexture([[Interface\AddOns\HealBot\Images\indicator_yellow.tga]]);
                        button.gref.indicator.power[3]:SetTexture([[Interface\AddOns\HealBot\Images\indicator_yellow.tga]]);
                    end
                end
                button.gref.indicator.power[1]:SetAlpha(indAlpha)
                button.gref.indicator.power[2]:SetAlpha(indAlpha)
                button.gref.indicator.power[3]:SetAlpha(indAlpha)
                button.gref.indicator.power[4]:SetAlpha(0)
                button.gref.indicator.power[5]:SetAlpha(0)
            end
        elseif hbPowerIndicator==4 then
            if button.mana.power~=4 then
                button.mana.power=4
                if Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][button.frame]["PCOL"]==1 then
                    if HealBot_Action_luVars["UnitPowerMax"]<5 then
                        button.gref.indicator.power[1]:SetTexture([[Interface\AddOns\HealBot\Images\indicator_green.tga]]);
                        button.gref.indicator.power[2]:SetTexture([[Interface\AddOns\HealBot\Images\indicator_green.tga]]);
                        button.gref.indicator.power[3]:SetTexture([[Interface\AddOns\HealBot\Images\indicator_green.tga]]);
                        button.gref.indicator.power[4]:SetTexture([[Interface\AddOns\HealBot\Images\indicator_green.tga]]);

                    else
                        button.gref.indicator.power[1]:SetTexture([[Interface\AddOns\HealBot\Images\indicator_lime.tga]]);
                        button.gref.indicator.power[2]:SetTexture([[Interface\AddOns\HealBot\Images\indicator_lime.tga]]);
                        button.gref.indicator.power[3]:SetTexture([[Interface\AddOns\HealBot\Images\indicator_lime.tga]]);
                        button.gref.indicator.power[4]:SetTexture([[Interface\AddOns\HealBot\Images\indicator_lime.tga]]);
                    end
                end
                button.gref.indicator.power[1]:SetAlpha(indAlpha)
                button.gref.indicator.power[2]:SetAlpha(indAlpha)
                button.gref.indicator.power[3]:SetAlpha(indAlpha)
                button.gref.indicator.power[4]:SetAlpha(indAlpha)
                button.gref.indicator.power[5]:SetAlpha(0)
            end
        elseif hbPowerIndicator==5 then
            if button.mana.power~=5 then
                button.mana.power=5
                if Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][button.frame]["PCOL"]==1 then
                    button.gref.indicator.power[1]:SetTexture([[Interface\AddOns\HealBot\Images\indicator_green.tga]]);
                    button.gref.indicator.power[2]:SetTexture([[Interface\AddOns\HealBot\Images\indicator_green.tga]]);
                    button.gref.indicator.power[3]:SetTexture([[Interface\AddOns\HealBot\Images\indicator_green.tga]]);
                    button.gref.indicator.power[4]:SetTexture([[Interface\AddOns\HealBot\Images\indicator_green.tga]]);
                end
                button.gref.indicator.power[1]:SetAlpha(indAlpha)
                button.gref.indicator.power[2]:SetAlpha(indAlpha)
                button.gref.indicator.power[3]:SetAlpha(indAlpha)
                button.gref.indicator.power[4]:SetAlpha(indAlpha)
                button.gref.indicator.power[5]:SetAlpha(indAlpha)
            end
        elseif button.mana.power~=0 then
            button.mana.power=0
            button.gref.indicator.power[1]:SetAlpha(0)
            button.gref.indicator.power[2]:SetAlpha(0)
            button.gref.indicator.power[3]:SetAlpha(0)
            button.gref.indicator.power[4]:SetAlpha(0)
            button.gref.indicator.power[5]:SetAlpha(0)
        end
    elseif button.mana.power~=0 then
        button.mana.power=0
        button.gref.indicator.power[1]:SetAlpha(0)
        button.gref.indicator.power[2]:SetAlpha(0)
        button.gref.indicator.power[3]:SetAlpha(0)
        button.gref.indicator.power[4]:SetAlpha(0)
        button.gref.indicator.power[5]:SetAlpha(0)
    end
end

local hbLowManaTrig={[1] = {[1]=1,[2]=2,[3]=3},
                     [2] = {[1]=1,[2]=2,[3]=3},
                     [3] = {[1]=1,[2]=2,[3]=3},
                     [4] = {[1]=1,[2]=2,[3]=3},
                     [5] = {[1]=1,[2]=2,[3]=3},
                     [6] = {[1]=1,[2]=2,[3]=3},
                     [7] = {[1]=1,[2]=2,[3]=3},
                     [8] = {[1]=1,[2]=2,[3]=3},
                     [9] = {[1]=1,[2]=2,[3]=3},
                     [10] = {[1]=1,[2]=2,[3]=3},
                    }

function HealBot_Action_setLowManaTrig()
    for j=1,10 do
        if Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j]["LOWMANA"]==2 then
            hbLowManaTrig[j][1]=10
            hbLowManaTrig[j][2]=20
            hbLowManaTrig[j][3]=30
        elseif Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j]["LOWMANA"]==3 then
            hbLowManaTrig[j][1]=15
            hbLowManaTrig[j][2]=30
            hbLowManaTrig[j][3]=45
        elseif Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j]["LOWMANA"]==4 then
            hbLowManaTrig[j][1]=20
            hbLowManaTrig[j][2]=40
            hbLowManaTrig[j][3]=60
        elseif Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j]["LOWMANA"]==5 then
            hbLowManaTrig[j][1]=25
            hbLowManaTrig[j][2]=50
            hbLowManaTrig[j][3]=75
        elseif Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j]["LOWMANA"]==6 then
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
    --HealBot_setCall("HealBot_Action_setLowManaTrig")
end

function HealBot_Action_CheckUnitLowMana(button)
    if button.mana.type==0 and button.frame<10 then
        if button.status.current<HealBot_Unit_Status["DEAD"] and button.mana.max>0 and 
           Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["LOWMANA"]>1 then
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
        HealBot_Check_UnitBuff(button)
    end
    --HealBot_setCall("HealBot_Action_CheckUnitLowMana")
end

local ooRhbX, ooRhbY, ooRhbD=0,0,-999
function HealBot_Action_ShowDirectionArrow(button, TimeNow)
    if button.status.range==0 and (not Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWDIRMOUSE"] or button.mouseover) then
        ooRhbX, ooRhbY, ooRhbD = HealBot_Direction_Check(button.unit)
        if ooRhbD then
            if button.status.dirarrowshown==0 or button.status.dirarrowcords~=ooRhbD then 
                button.status.dirarrowcords=ooRhbD
                HealBot_Aura_OORUpdate(button, "Interface\\AddOns\\HealBot\\Images\\arrow.blp")
            end
            button.status.dirarrowshown=TimeNow+0.25
        elseif button.status.dirarrowshown>0 then
            HealBot_Action_HideDirectionArrow(button)
        end
    elseif button.status.dirarrowshown>0 then
        HealBot_Action_HideDirectionArrow(button)
    end
    --HealBot_setCall("HealBot_Action_ShowDirectionArrow")
end

function HealBot_Action_SetDirectionArrow(button, index)
    button.gref.icon[index]:SetTexCoord(ooRhbX, ooRhbX + 0.109375, ooRhbY, ooRhbY + 0.08203125)
end

function HealBot_Action_HideDirectionArrow(button)
    button.status.dirarrowshown=0
    HealBot_Aura_OORUpdate(button, false)
    --HealBot_setCall("HealBot_Action_HideDirectionArrow")
end

function HealBot_Action_setFrameHeader(f)
    if Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][f]["SHOW"] then
        grpFrameBar[f]:SetPoint("BOTTOM",grpFrame[f],"TOP",0,Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][f]["OFFSET"])
        local fWidth=grpFrame[f]:GetRight()-grpFrame[f]:GetLeft()
        local hwidth = ceil(fWidth*Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][f]["WIDTH"])
        grpFrameBar[f]:SetHeight(ceil(Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][f]["HEIGHT"]*Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][f]["SCALE"]));
        grpFrameBar[f]:SetWidth(hwidth);
        grpFrameBar[f]:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][f]["TEXTURE"]));
        grpFrameBar[f]:GetStatusBarTexture():SetHorizTile(false)
        HealBot_Action_UpdateFrameHeaderOpacity(f)
    else
        grpFrameBar[f]:SetStatusBarColor(0,0,0,0);
    end
end

local hbEventFuncs={["UNIT_AURA"]=HealBot_Check_UnitAura,
                    ["UNIT_INVENTORY_CHANGED"]=HealBot_OnEvent_InvChange,
                    ["UNIT_HEALTH_FREQUENT"]=HealBot_OnEvent_UnitHealth,
                    ["UNIT_HEALTH"]=HealBot_OnEvent_UnitHealth,
                    ["UNIT_MAXHEALTH"]=HealBot_OnEvent_UnitHealth,
                    ["UNIT_THREAT_SITUATION_UPDATE"]=HealBot_OnEvent_UnitThreat,
                    ["UNIT_THREAT_LIST_UPDATE"]=HealBot_OnEvent_UnitThreat,
                    ["UNIT_HEAL_PREDICTION"]=HealBot_OnEvent_HealsInUpdate,
                    ["UNIT_ABSORB_AMOUNT_CHANGED"]=HealBot_OnEvent_AbsorbsUpdate,
                    ["UNIT_POWER_UPDATE"]=HealBot_OnEvent_UnitMana,
                    ["UNIT_POWER_POINT_CHARGE"]=HealBot_Action_setPowerIndicators,
                    ["UNIT_MAXPOWER"]=HealBot_OnEvent_UnitMana,
                    ["UNIT_ATTACK"]=HealBot_CalcThreat,
                    ["UNIT_COMBAT"]=HealBot_CalcThreat,
                    ["UNIT_SPELLCAST_START"]=HealBot_OnEvent_UnitSpellCastStart,
                    ["UNIT_SPELLCAST_CHANNEL_START"]=HealBot_OnEvent_UnitSpellChanStart,
                    ["UNIT_SPELLCAST_FAILED"]=HealBot_OnEvent_UnitSpellCastFailed,
                    ["UNIT_SPELLCAST_INTERRUPTED"]=HealBot_OnEvent_UnitSpellCastFailed,
                    ["UNIT_SPELLCAST_CHANNEL_STOP"]=HealBot_OnEvent_UnitSpellCastStop,
                    ["UNIT_SPELLCAST_STOP"]=HealBot_OnEvent_UnitSpellCastStop,
                    ["UNIT_SPELLCAST_SUCCEEDED"]=HealBot_OnEvent_UnitSpellCastComplete,
                    ["UNIT_TARGETABLE_CHANGED"]=HealBot_CalcThreat,
                    ["PLAYER_TARGET_SET_ATTACKING"]=HealBot_CalcThreat,
                    ["UNIT_TARGET"]=HealBot_OnEvent_UnitTarget,
                    ["UNIT_PHASE"]=HealBot_OnEvent_UnitPhase,
                    ["UNIT_NAME_UPDATE"]=HealBot_CheckUpdateUnitGUIDChange,
                    ["UNIT_DISPLAYPOWER"]=HealBot_OnEvent_UnitManaUpdate,
                    ["UNIT_CONNECTION"]=HealBot_CheckUnitStatus,
                    ["PARTY_MEMBER_ENABLE"]=HealBot_CheckUnitStatus,
                    ["PARTY_MEMBER_DISABLE"]=HealBot_CheckUnitStatus,
                    ["PLAYER_SPECIALIZATION_CHANGED"]=HealBot_OnEvent_SpecChange,
                    ["UNIT_CLASSIFICATION_CHANGED"]=HealBot_OnEvent_ClassificationChanged,
                    ["PLAYER_FLAGS_CHANGED"]=HealBot_OnEvent_UnitFlagsChanged,
                    ["UNIT_FLAGS"]=HealBot_OnEvent_UnitFlagsChanged,
                   }

local hbEnemyEventFuncs={["UNIT_AURA"]=HealBot_EnemyCheck_UnitAura,
                         ["UNIT_HEALTH_FREQUENT"]=HealBot_OnEvent_EnemyUnitHealth,
                         ["UNIT_HEALTH"]=HealBot_OnEvent_EnemyUnitHealth,
                         ["UNIT_MAXHEALTH"]=HealBot_OnEvent_EnemyUnitHealth,
                         ["UNIT_HEAL_PREDICTION"]=HealBot_HealsInEnemyUpdate,
                         ["UNIT_ABSORB_AMOUNT_CHANGED"]=HealBot_AbsorbsEnemyUpdate,
                         ["UNIT_POWER_UPDATE"]=HealBot_OnEvent_UnitMana,
                         ["UNIT_MAXPOWER"]=HealBot_OnEvent_UnitMana,
                         ["UNIT_SPELLCAST_START"]=HealBot_OnEvent_UnitSpellCastStart,
                         ["UNIT_SPELLCAST_CHANNEL_START"]=HealBot_OnEvent_UnitSpellChanStart,
                         ["UNIT_SPELLCAST_FAILED"]=HealBot_OnEvent_UnitSpellCastFailed,
                         ["UNIT_SPELLCAST_INTERRUPTED"]=HealBot_OnEvent_UnitSpellCastFailed,
                         ["UNIT_SPELLCAST_CHANNEL_STOP"]=HealBot_OnEvent_UnitSpellCastStop,
                         ["UNIT_SPELLCAST_STOP"]=HealBot_OnEvent_UnitSpellCastStop,
                         ["UNIT_PHASE"]=HealBot_OnEvent_UnitPhase,
                         ["UNIT_NAME_UPDATE"]=HealBot_CheckUpdateUnitGUIDChange,
                         ["UNIT_DISPLAYPOWER"]=HealBot_OnEvent_UnitManaUpdate,
                         ["UNIT_CLASSIFICATION_CHANGED"]=HealBot_OnEvent_ClassificationChanged,
                   }
function HealBot_Action_InitFrames()
    for x=1,10 do
        grpFrame[x]=_G["f"..x.."_HealBot_Action"]
        if not grpFrame[x] then
            grpFrame[x]=CreateFrame("Frame", "f"..x.."_HealBot_Action", UIParent, BackdropTemplateMixin and "SecureFrameTemplate,BackdropTemplate")
            grpFrame[x]:SetBackdrop({
                bgFile = "Interface\\Addons\\HealBot\\Images\\WhiteLine",
                edgeFile = "Interface\\Addons\\HealBot\\Images\\border",
                tile = true,
                tileSize = 8,
                edgeSize = 8,
                insets = { left = 3, right = 3, top = 3, bottom = 3, },
            })
            grpFrameText[1000+x]=grpFrame[x]:CreateFontString("f"..x.."_HealBot_Action_UnlockTxt", "ARTWORK", "GameFontNormal")
            grpFrameText[1000+x]:SetPoint("BOTTOM",grpFrame[x],"BOTTOM",0,4)
            grpFrame[x].id=x
            grpFrame[x]:SetMovable(true)
            grpFrame[x]:EnableMouse(true)
            grpFrame[x]:SetScript("OnShow", function(self) HealBot_Action_OnShow(self) end)
            grpFrame[x]:SetScript("OnMouseDown", function(self, button) HealBot_Action_OnMouseDown(self, button) end)
            grpFrame[x]:SetScript("OnEnter", function(self) HealBot_Action_OnEnter(self) end)
            grpFrame[x]:SetScript("OnLeave", function(self) HealBot_Action_OnLeave(self) end)
            grpFrame[x]:SetScript("OnMouseUp", function(self, button) HealBot_Action_OnMouseUp(self, button) end)
            grpFrameBar[x]=CreateFrame("StatusBar", "f"..x.."_HealBot_Action_HeaderBar", grpFrame[x], "TextStatusBar")
            grpFrameBar[x]:SetPoint("BOTTOM",grpFrame[x],"TOP",0,0)
            grpFrameBar[x]:SetMinMaxValues(0,100);
            grpFrameBar[x]:SetValue(100);
            local barScale = grpFrameBar[x]:GetScale();
            grpFrameBar[x]:SetScale(barScale + 0.01);
            grpFrameBar[x]:SetScale(barScale);
            grpFrameBar[x]:EnableMouse(false)
            grpFrameText[x]=grpFrameBar[x]:CreateFontString("f"..x.."_HealBot_Action_Title", "ARTWORK", "GameFontNormal")
            local StickIndPoints={[1]="BOTTOMLEFT",[2]="BOTTOM",[3]="BOTTOMRIGHT",[4]="TOPLEFT",[5]="LEFT",[6]="BOTTOMLEFT",[7]="TOPRIGHT",[8]="TOP",[9]="TOPLEFT",[10]="BOTTOMRIGHT",[11]="RIGHT",[12]="TOPRIGHT"}
            local FrameStickIndPoints={[1]="TOPLEFT",[2]="TOP",[3]="TOPRIGHT",[4]="TOPRIGHT",[5]="RIGHT",[6]="BOTTOMRIGHT",[7]="BOTTOMRIGHT",[8]="BOTTOM",[9]="BOTTOMLEFT",[10]="BOTTOMLEFT",[11]="LEFT",[12]="TOPLEFT"}
            for y=1,12 do
                if not grpFrameStickyInd[x] then grpFrameStickyInd[x]={} end
                grpFrameStickyInd[x][y]=CreateFrame("StatusBar", "f"..x.."_HealBot_Action_StickyInd"..y, grpFrame[x], "TextStatusBar")
                grpFrameStickyInd[x][y]:SetStatusBarTexture(LSM:Fetch('statusbar',HealBot_Default_Textures[16].name));
                grpFrameStickyInd[x][y]:SetStatusBarColor(1,1,0.25,0)
                grpFrameStickyInd[x][y]:SetPoint(StickIndPoints[y],grpFrame[x],FrameStickIndPoints[y])
                grpFrameStickyInd[x][y]:SetMinMaxValues(0,100);
                grpFrameStickyInd[x][y]:SetValue(100);
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
            HealBot_Action_FrameSetPoint(x, grpFrame[x])
            HideUIPanel(grpFrame[x])
        end
    end

    HealBot_Action_luVars["FrameInitDone"]=true
end

function HealBot_Action_ShowPanel(frame)
    if HealBot_Config.DisabledNow==0 then
        if not grpFrame[frame]:IsVisible() then 
            ShowUIPanel(grpFrame[frame])
            if HealBot_AutoCloseFrame[frame]==3 then
                PlaySound(SOUNDKIT.IG_ABILITY_OPEN)
            end
        end
    end
    --HealBot_setCall("HealBot_Action_ShowPanel"..frame)
end

function HealBot_Action_FrameIsVisible(frame)
    if grpFrame[frame] and grpFrame[frame]:IsVisible() then 
        return true
    else
        return false
    end
end

function HealBot_Action_HidePanel(frame)
    if grpFrame[frame]:IsVisible() then 
        HideUIPanel(grpFrame[frame])
        if HealBot_AutoCloseFrame[frame]==3 then
            PlaySound(SOUNDKIT.IG_ABILITY_CLOSE)
        end
    end
end

function HealBot_Action_ResetUnitButtonOpacity(button)
    HealBot_Action_UpdateBackground(button)
    HealBot_Text_UpdateButton(button)
    HealBot_Action_EmergBarCheck(button, true)
    HealBot_Aux_UpdBar(button)
    HealBot_RefreshUnit(button)
    if button.health.incoming>0 then HealBot_Action_UpdateHealsInButton(button) end
    if button.health.absorbs>0 then HealBot_Action_UpdateAbsorbsButton(button) end
    HealBot_Aura_Update_AllIcons(button)
    HealBot_Action_setPowerIndicators(button)
    HealBot_Action_CheckUnitLowMana(button)
    HealBot_Aggro_IndicatorUpdate(button)
end

function HealBot_Action_ResetUnitOpacity()
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
    --HealBot_Action_ResetUnitStatus()
end

function HealBot_Action_ResetOpacity()
    HealBot_Action_ResetUnitOpacity()
    HealBot_Action_UpdateFramesOpacity()
    HealBot_Panel_UpdateHeadersOpacity()
end

function HealBot_Action_ResetUnitStatus()
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
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_RefreshUnit(xButton)
    end
    --HealBot_setCall("HealBot_Action_ResetUnitStatus")
end

function HealBot_Action_ResetActiveUnitStatus()
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
    --HealBot_setCall("HealBot_Action_ResetActiveUnitStatus")
end

function HealBot_Action_ResetrCallsUnit(button)
    button.mana.ind=-1
    button.mana.power=-1
    button.aggro.ind=-1
end

function HealBot_Action_ResetrCalls()
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
    --HealBot_setCall("HealBot_Action_ResetrCalls")
end 

function HealBot_Action_InitButton(button)
    erButton=HealBot_Emerg_Button[button.id]
    button.guid="nil"
    button.unit="nil"
    erButton.unit="nil"
    button.skin=""
    button.aura={}
    button.aura.buff={}
    button.aura.buff.recheck={}
    button.aura.debuff={}
    button.status={}
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
    button.plugin={}
    button.request={}
    button.buffwatch={}
    button.healthwatch={}
    button.manawatch={}
    button.attribs={["Emerg"]={},["Enemy"]={},["Enabled"]={}}
    erButton.attribs={["Emerg"]={},["Enemy"]={},["Enabled"]={}}
    button.binds={["Emerg"]={},["Enemy"]={},["Enabled"]={}}
    erButton.binds={["Emerg"]={},["Enemy"]={},["Enabled"]={}}
    button.icon.debuff={}
    button.icon.buff={}
    button.icon.extra={}
    button.aux={}
    button.auxtxt={}
    for x=1,10 do
        button.aux[x]={}
        button.auxtxt[x]={}
    end
    button.gref={}
    button.gref.aux={}
    button.gref.auxtxt={}
    button.gref.txt={}
    button.gref.txt.expire={}
    button.gref.txt.count={}
    button.gref.icon={}
    button.gref.iconf={}
    button.gref.indicator={}
    button.gref.indicator.aggro={}
    button.gref.indicator.mana={}
    button.gref.indicator.selfcast={}
    button.gref.indicator.power={}
    button.gref["Bar"]=_G["HealBot_Action_HealUnit"..button.id.."Bar"]
    button.gref["Bar"]:UnregisterAllEvents()
    button.gref["Bar"]:SetMinMaxValues(0,1000)
    erButton.bar=_G["HealBot_Action_EmergUnit"..button.id.."Bar"]
    erButton.bar:UnregisterAllEvents()
    erButton.bar:SetMinMaxValues(0,1)
    erButton.bar:SetValue(1)
    button.gref["InHeal"]=_G["HealBot_Action_HealUnit"..button.id.."Bar2"]
    button.gref["InHeal"]:UnregisterAllEvents()
    button.gref["InHeal"]:SetMinMaxValues(0,1000)
    button.gref["InHeal"]:SetValue(0)
    button.gref["Back"]=_G["HealBot_Action_HealUnit"..button.id.."Bar5"]
    button.gref["Back"]:UnregisterAllEvents()
    button.gref["Back"]:SetValue(100)
    button.gref["Back"]:SetMinMaxValues(0,100)
    button.gref["Back"]:SetStatusBarTexture("Interface\\Buttons\\WHITE8X8");
    button.gref["Back"]:GetStatusBarTexture():SetHorizTile(false)
    button.gref["BackBorder"]=CreateFrame("Frame", "HealBot_BarBackBorder_"..button.id , button.gref["Back"], BackdropTemplateMixin and "BackdropTemplate")
    button.gref["BackBorder"].size=0
    button.gref["Top"]=_G["HealBot_Action_HealUnit"..button.id.."Bar7"]
    button.gref["Top"]:UnregisterAllEvents()
    button.gref["Top"]:SetValue(100)
    button.gref["Top"]:SetMinMaxValues(0,100)
    button.gref["Top"]:SetStatusBarColor(0, 0, 0, 0)
    button.gref["IconTop"]=_G["HealBot_Action_HealUnit"..button.id.."Bar8"]
    button.gref["IconTop"]:UnregisterAllEvents()
    button.gref["IconTop"]:SetValue(100)
    button.gref["IconTop"]:SetMinMaxValues(0,100)
    button.gref["IconTop"]:SetStatusBarColor(0, 0, 0, 0)
    button.gref["Absorb"]=_G["HealBot_Action_HealUnit"..button.id.."Bar6"]
    button.gref["Absorb"]:UnregisterAllEvents()
    button.gref["Absorb"]:SetMinMaxValues(0,1000)
    button.gref["Absorb"]:SetValue(0)            
    button:SetFrameLevel(100); 
    button.gref["Back"]:SetFrameLevel(button:GetFrameLevel()+ 1)
    button.gref["Top"]:SetFrameLevel(button:GetFrameLevel()+50)
    button.gref["BackBorder"]:SetFrameLevel(200)
    button.gref["IconTop"]:SetFrameLevel(500)
    button.gref["BackBorder"]:SetBackdrop({
                                           edgeFile = "Interface\\Buttons\\WHITE8X8",
                                           edgeSize = 1, 
                                           insets = { left = 0, right = 0, top = 0, bottom = 0}
                                          })
    button.gref["BackBorder"].tex=button.gref["BackBorder"]:CreateTexture("Interface\\Buttons\\WHITE8X8", "ARTWORK")
    button.gref["BackBorder"].tex:SetAllPoints(button.gref["BackBorder"])
    button.gref["BackBorder"].mask=button.gref["BackBorder"]:CreateMaskTexture()
    button.gref["BackBorder"].mask:SetAllPoints(button.gref["BackBorder"].tex)
    button.gref["BackBorder"].mask:SetTexture("Interface\AdventureMap\BrokenIsles\AM_29", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
    button.gref["BackBorder"].tex:AddMaskTexture(button.gref["BackBorder"].mask)
    button.gref["BackBorder"].mask:Show()
    
    button.gref["Absorb"]:SetFrameLevel(button.gref["Back"]:GetFrameLevel()+ 1)
    button.gref["InHeal"]:SetFrameLevel(button.gref["Absorb"]:GetFrameLevel()+ 1)
    button.gref["Bar"]:SetFrameLevel(button.gref["InHeal"]:GetFrameLevel()+ 1)
    erButton:SetFrameLevel(button:GetFrameLevel()+20)
    erButton.bar:SetFrameLevel(button.gref["Top"]:GetFrameLevel()-1)
    button:Enable();
    erButton:Enable();
    for x=1,9 do
        button.gref.aux[x]=_G["HealBot_Action_HealUnit"..button.id.."Aux"..x]
        button.gref.aux[x]:UnregisterAllEvents()
        button.gref.aux[x]:SetMinMaxValues(0,1000)
        button.gref.aux[x]:SetFrameLevel(button.gref["Bar"]:GetFrameLevel()+x)
        button.gref.auxtxt[x]=_G["HealBot_Action_HealUnit"..button.id.."Aux"..x.."_Txt"]
        button.gref.auxtxt[x]:SetSpacing(0)
        button.gref.auxtxt[x]:SetWordWrap(false)
    end
    button.gref.txt["text"]=_G["HealBot_Action_HealUnit"..button.id.."Bar_text"]
    button.gref.txt["text"]:SetWordWrap(false)
    button.gref.txt["text2"]=_G["HealBot_Action_HealUnit"..button.id.."Bar_text2"]
    button.gref.txt["text2"]:SetWordWrap(false)
    button.gref.txt["text3"]=_G["HealBot_Action_HealUnit"..button.id.."Bar_text3"]
    button.gref.txt["text3"]:SetWordWrap(false)
    button.gref.txt["text4"]=_G["HealBot_Action_HealUnit"..button.id.."Bar_text4"]
    button.gref.txt["text4"]:SetWordWrap(false)
    button.gref.icon["Icontm1"]=_G["HealBot_Action_HealUnit"..button.id.."Bar8Icontm1"]
    button.gref.icon["Icontm2"]=_G["HealBot_Action_HealUnit"..button.id.."Bar8Icontm2"]
    button.gref.icon["Icontm3"]=_G["HealBot_Action_HealUnit"..button.id.."Bar8Icontm3"]
    for x=1,12 do
        button.gref.icon[x]=_G["HealBot_Action_HealUnit"..button.id.."Bar8Icon"..x]
        button.gref.iconf[x]=_G["HealBot_Action_HealUnit"..button.id.."Icon"..x]
    end
    for x=51,58 do
        button.gref.icon[x]=_G["HealBot_Action_HealUnit"..button.id.."Bar8Icon"..x]
        button.gref.iconf[x]=_G["HealBot_Action_HealUnit"..button.id.."Icon"..x]
    end
    button.gref.icon[91]=_G["HealBot_Action_HealUnit"..button.id.."Bar8ExtraClass"]
    button.gref.icon[92]=_G["HealBot_Action_HealUnit"..button.id.."Bar8ExtraTarget"]
    button.gref.icon[93]=_G["HealBot_Action_HealUnit"..button.id.."Bar8ExtraRC"]
    button.gref.icon[94]=_G["HealBot_Action_HealUnit"..button.id.."Bar8ExtraOOR"]
    for x=1,12 do
        button.gref.txt.expire[x]=_G["HealBot_Action_HealUnit"..button.id.."Bar8Expire"..x]
        button.gref.txt.count[x]=_G["HealBot_Action_HealUnit"..button.id.."Bar8Count"..x]
    end
    for x=51,58 do
        button.gref.txt.expire[x]=_G["HealBot_Action_HealUnit"..button.id.."Bar8Expire"..x]
        button.gref.txt.count[x]=_G["HealBot_Action_HealUnit"..button.id.."Bar8Count"..x]
    end
    for x=1,3 do
        button.gref.indicator.aggro["Iconal"..x]=_G["HealBot_Action_HealUnit"..button.id.."Bar8Iconal"..x]
        button.gref.indicator.aggro["Iconar"..x]=_G["HealBot_Action_HealUnit"..button.id.."Bar8Iconar"..x]
        button.gref.indicator.mana[x]=_G["HealBot_Action_HealUnit"..button.id.."Bar8Icontm"..x]
    end
    for x=1,12 do
        button.gref.indicator.selfcast[x]=_G["HealBot_Action_HealUnit"..button.id.."Bar8Own"..x]
        button.gref.indicator.selfcast[x]:SetAlpha(0)
    end
    for x=1,5 do
        button.gref.indicator.power[x]=_G["HealBot_Action_HealUnit"..button.id.."Bar8Iconpi"..x]
        button.gref.indicator.power[x]:SetAlpha(0);
    end
    button.frame=0
    erButton.r,erButton.g,erButton.b,erButton.a=0,0,0,0
    erButton:EnableMouse(false)
    erButton.regClicks=false
    button:EnableMouse(false)
    button.regClicks=false
    HealBot_Aura_setButtonIcons(button.id)
    HealBot_Aux_AssignLastOverlayType(button.id)
    --HealBot_setCall("HealBot_Action_InitButton")
end

function HealBot_Action_UnregisterUnitEvents(button)
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
    if HEALBOT_GAME_VERSION==1 then
        button:UnregisterEvent("PLAYER_TARGET_SET_ATTACKING")
    end
    button:UnregisterEvent("UNIT_TARGET")
    button:UnregisterEvent("UNIT_THREAT_SITUATION_UPDATE")
    button:UnregisterEvent("UNIT_THREAT_LIST_UPDATE")
    button:UnregisterEvent("UNIT_CLASSIFICATION_CHANGED")
    button:UnregisterEvent("PLAYER_FLAGS_CHANGED")
    button:UnregisterEvent("UNIT_FLAGS")
    if HEALBOT_GAME_VERSION>3 then
        button:UnregisterEvent("UNIT_ABSORB_AMOUNT_CHANGED")
        button:UnregisterEvent("PLAYER_SPECIALIZATION_CHANGED")
        button:UnregisterEvent("UNIT_POWER_POINT_CHARGE")
        button:UnregisterEvent("UNIT_HEALTH")
    else
        button:UnregisterEvent("UNIT_HEALTH_FREQUENT")
    end
    button:UnregisterEvent("UNIT_HEAL_PREDICTION")
end

HealBot_Action_luVars["regAggro"]=false
function HealBot_Action_Register_Aggro()
    local regAggro=HealBot_Action_luVars["pluginThreat"]
    for x=1,10 do
        if Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][x]["SHOW"] then
            regAggro=true
            break
        end
    end
    if HealBot_Action_luVars["regAggro"]~=regAggro then
        HealBot_Action_luVars["resetEvents"]=true
        HealBot_Action_luVars["regAggro"]=regAggro
        HealBot_setLuVars("regAggro", regAggro)
        HealBot_Timers_Set("LAST","ResetAllButtons")
        HealBot_Timers_Set("INIT","RefreshPartyNextRecalcAll")
    end
end

function HealBot_Action_RegisterUnitEvents(button)
    button.status.events=true
    button:RegisterUnitEvent("UNIT_AURA", button.unit)
    button:RegisterUnitEvent("UNIT_MAXHEALTH", button.unit)
    button:RegisterUnitEvent("UNIT_POWER_UPDATE", button.unit)
    button:RegisterUnitEvent("UNIT_DISPLAYPOWER", button.unit)
    button:RegisterUnitEvent("UNIT_MAXPOWER", button.unit)
    button:RegisterUnitEvent("UNIT_PHASE", button.unit)
    button:RegisterUnitEvent("UNIT_NAME_UPDATE", button.unit)
    button:RegisterUnitEvent("UNIT_SPELLCAST_START", button.unit)
    button:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_START", button.unit)
    button:RegisterUnitEvent("UNIT_SPELLCAST_FAILED", button.unit)
    button:RegisterUnitEvent("UNIT_SPELLCAST_INTERRUPTED", button.unit)
    button:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_STOP", button.unit)
    button:RegisterUnitEvent("UNIT_SPELLCAST_STOP", button.unit)
    button:RegisterUnitEvent("UNIT_HEAL_PREDICTION", button.unit)
    button:RegisterUnitEvent("UNIT_CLASSIFICATION_CHANGED", button.unit)
    button:RegisterUnitEvent("PLAYER_FLAGS_CHANGED", button.unit)
    button:RegisterUnitEvent("UNIT_FLAGS", button.unit)
    if HEALBOT_GAME_VERSION>3 then
        button:RegisterUnitEvent("UNIT_ABSORB_AMOUNT_CHANGED", button.unit)
        button:RegisterUnitEvent("UNIT_HEALTH", button.unit)
    else
        button:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", button.unit)
    end
    if button.frame<10 then
        button:RegisterUnitEvent("UNIT_CONNECTION", button.unit)
        button:RegisterUnitEvent("PARTY_MEMBER_ENABLE", button.unit)
        button:RegisterUnitEvent("PARTY_MEMBER_DISABLE", button.unit)
        if HEALBOT_GAME_VERSION==1 and HealBot_Action_luVars["regAggro"] then
            button:RegisterUnitEvent("PLAYER_TARGET_SET_ATTACKING", button.unit)
        elseif HEALBOT_GAME_VERSION>3 then
            button:RegisterUnitEvent("PLAYER_SPECIALIZATION_CHANGED", button.unit)
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
    erButton=HealBot_Emerg_Button[button.id]
    button.status.role=0
    button.status.hasres=false
    button.status.markdel=false
    button.status.nextcheck=0
    button.group=1
    button.rank=0
    button.role=0
    button.player=false
    button.isplayer=false
    button.guid="prep"
    button.name=false
    button.level=1
    button.health.init=true
    button.mana.init=true
    button.mana.nextcheck=0
    button.health.current=-1
    button.health.max=100
    button.health.alert=1
    button.health.pct=.999
    button.health.hpct=999
    button.health.incoming=0
    button.health.auxincoming=0
    button.health.inhptc=0
    button.health.absorbs=0
    button.health.absorbspctc=0
    button.health.auxabsorbs=0
    button.health.auraabsorbs=0
    button.health.abptc=0
    button.health.overheal=0
    button.health.auxoverheal=0
    button.health.updhlth=true
    button.health.updincoming=false
    button.health.updabsorbs=false
    button.health.rcol=0
    button.health.gcol=0
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
    button.status.events=false
    button.status.duplicate=false
    button.status.classknown=false
    button.status.plugin=false
    button.status.current=HealBot_Unit_Status["CHECK"]
    button.status.range=1
    button.status.range30=true
    button.status.rangespell=HealBot_RangeSpells["HEAL"]
    button.status.rangespellspecial=false
    button.status.rangenextcheck=0
    button.status.unittype=0
    button.status.enabled=false
    button.status.summons=false
    button.status.incombat=false
    button.status.hostile=false
    button.status.playerlastheal=0
    button.status.lasthealthdrop=0
    button.status.r=0
    button.status.g=0
    button.status.b=0
    button.status.alpha=1
    button.status.dirarrowcords=0 
    button.status.dirarrowshown=0 
    button.status.update=true
    button.status.change=true
    button.status.castend=-1
    button.status.resstart=0
    button.hotbars.state=false
    button.hotbars.debuff=false
    button.hotbars.health=false
    button.aura.update=false
    button.aura.buffcol=false
    button.aura.debuffcol=false
    button.aura.buff.name=false
    button.aura.buff.missingbuff=false
    button.aura.buff.id=0
    button.icon.buff.count=0
    button.aura.buff.priority=99
    button.aura.buff.nextcheck=false
    button.aura.buff.resetcheck=false
    button.aura.buff.showcol=true
    button.aura.buff.colbar=0
    button.aura.buff.r=1
    button.aura.buff.g=1
    button.aura.buff.b=1
    button.aura.debuff.type=false
    button.aura.debuff.name=false
    button.aura.debuff.id=0
    button.icon.debuff.count=0
    button.aura.debuff.priority=99
    button.icon.debuff.showcol=true
    button.aura.debuff.colbar=0
    button.aura.debuff.curespell=false
    button.aura.debuff.r=1
    button.aura.debuff.g=1
    button.aura.debuff.b=1
    button.icon.extra.targeticon=0
    button.icon.extra.classtexture=false
    button.icon.extra.oorarrow=false
    button.aggro.ind=-1
    button.aggro.status=-1
    button.aggro.threatpct=0
    button.aggro.threatvalue=0
    button.aggro.mobname=""
    button.text.health=""
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
    button.text.classtrim="XXXX"
    button.text.nameupdate=true
    button.text.tagupdate=true
    button.text.healthupdate=true
    button.text.aggroupdate=true
    button.spec=" "
    button.specupdate=0
    button.hazard.r=1
    button.hazard.g=1
    button.hazard.b=1
    button.plugin.colbar=0
    button.request.colbar=0
    button.buffwatch.colbar=0
    button.healthwatch.colbar=0
    button.manawatch.colbar=0
    button.plugin.r=1
    button.plugin.g=1
    button.plugin.b=1
    button.gref["Bar"]:SetStatusBarColor(0, 0, 0, 0)
    button.gref["Bar"]:SetValue(1000)
    button.gref["InHeal"]:SetStatusBarColor(0, 0, 0, 0)
    button.gref["Back"]:SetStatusBarColor(0, 0, 0, 0)
    button.gref["Absorb"]:SetStatusBarColor(0, 0, 0, 0)
    button.gref.txt["text"]:SetText("")
    button.gref.txt["text2"]:SetText("")
    button.gref.txt["text3"]:SetText("")
    button.gref.txt["text4"]:SetText("")
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
        button.gref.aux[x]:SetStatusBarColor(0, 0, 0, 0)
        button.gref.aux[x]:SetValue(0)
    end
    --button.gref["BackBorder"].tex:Hide()
    erButton.state=0
    erButton.bar:SetStatusBarColor(0,0,0,0)
    HealBot_Action_SetAllButtonAttribs(button,"Enemy",true)
    HealBot_Action_SetAllButtonAttribs(button,"Enabled",true)
    HealBot_Action_SetAllButtonAttribs(erButton,"Emerg",true)
    --HealBot_setCall("HealBot_Action_PrepButton")
end

local tryId,freeId,fromId,buttonId=1,0,0,0
HealBot_ActiveButtons[0]=1
HealBot_Action_luVars["ButtonHWM"]=0
function HealBot_Action_FreeId()
    tryId,freeId=HealBot_ActiveButtons[0],0
    if not HealBot_ActiveButtons[tryId] then
        freeId=tryId
    else
        if tryId<(HealBot_Globals.AutoCacheSize*2) then
            fromId=tryId+1
        else
            fromId=1
        end
        for i=fromId,998 do
            if not HealBot_ActiveButtons[i] then
                freeId=i
                break
            end
        end
    end
    if freeId<998 then
        HealBot_ActiveButtons[0]=freeId+1
    else
        HealBot_ActiveButtons[0]=1
    end
    return freeId
end

function HealBot_Action_CreateNewButton(hbCurFrame, buttonId)
    local ghb=CreateFrame("Button", "HealBot_Action_HealUnit"..buttonId, grpFrame[hbCurFrame], "HealBotButtonSecureTemplate") 
    HealBot_Buttons[buttonId]=ghb
    ghb.id=buttonId
    ghb.isEmerg=false
    local ehb=CreateFrame("Button", "HealBot_Action_EmergUnit"..buttonId, grpFrame[hbCurFrame], "HealingButtonTemplateEmerg")
    HealBot_Emerg_Button[buttonId]=ehb
    ehb.id=buttonId
    ehb.isEmerg=true
    local iBtns
    for x=1,12 do
        iBtns=CreateFrame("Button", "HealBot_Action_HealUnit"..buttonId.."Icon"..x, ghb)
        iBtns.id=buttonId
        iBtns:SetScript("OnEnter", function() HealBot_Options_BuffIconTooltip(ghb, x) end)
        iBtns:SetScript("OnLeave", function() HealBot_Action_HideTooltipFrame() end)
        iBtns:SetScript("OnMouseDown", function(self, button) HealBot_Options_BuffClick(ghb, x, button) end)
        iBtns:SetFrameLevel(0)
        iBtns:UnregisterAllEvents()
    end
    for x=51,58 do
        iBtns=CreateFrame("Frame", "HealBot_Action_HealUnit"..buttonId.."Icon"..x, ghb)
        iBtns.id=buttonId
        iBtns:SetScript("OnEnter", function() HealBot_Options_DebuffIconTooltip(ghb, x) end)
        iBtns:SetScript("OnLeave", function() HealBot_Action_HideTooltipFrame() end)
        iBtns:SetScript("OnMouseDown", function(self, button) HealBot_Options_DebuffClick(ghb, x, button) end)
        iBtns:SetFrameLevel(0)
        iBtns:UnregisterAllEvents()
    end
    HealBot_Action_InitButton(ghb)
    if buttonId>HealBot_Action_luVars["ButtonHWM"] then
        HealBot_Action_luVars["ButtonHWM"]=buttonId
    end
    ghb:HookScript("OnEnter", function(self) HealBot_Action_HealUnit_OnEnter(self) end);
    ghb:HookScript("OnLeave", function(self) HealBot_Action_HealUnit_OnLeave(self) end);
    ehb:HookScript("OnEnter", function(self) HealBot_Action_EmergUnit_OnEnter(self) end);
    ehb:HookScript("OnLeave", function(self) HealBot_Action_EmergUnit_OnLeave(self) end);
    return ghb
end
          
function HealBot_Action_ButtonActive(id)
    return HealBot_ActiveButtons[id]
end

function HealBot_Action_CreateButton(hbCurFrame)
    buttonId=HealBot_Action_FreeId()
    if buttonId>0 then 
        HealBot_ActiveButtons[buttonId]=true 
        local ghb=_G["HealBot_Action_HealUnit"..buttonId]
        if not ghb then 
            ghb=HealBot_Action_CreateNewButton(hbCurFrame, buttonId)
            HealBot_Action_PrepButton(ghb)
            --ghb.frame=hbCurFrame
        end
        ghb.reset=true
        return ghb
    else
        return nil
    end
    --HealBot_setCall("HealBot_Action_CreateButton")
end

function HealBot_Action_ResetAllButtons()
    if HealBot_Action_luVars["ButtonHWM"]>0 then
        for i=1,HealBot_Action_luVars["ButtonHWM"] do
            local ghb=_G["HealBot_Action_HealUnit"..i]
            ghb.reset=true
            if HealBot_Action_luVars["resetEvents"] then
                ghb.status.events=false
            end
        end
    end
    HealBot_Action_luVars["resetEvents"]=false
end

function HealBot_Action_ResetSkinAllButtons()
    if HealBot_Action_luVars["ButtonHWM"]>0 then
        for i=1,HealBot_Action_luVars["ButtonHWM"] do
            local ghb=_G["HealBot_Action_HealUnit"..i]
            if ghb then
                if HealBot_Action_luVars["resetSkin"] then ghb.skinreset=true end
                if HealBot_Action_luVars["resetIcon"] then ghb.icon.reset=true end
                if HealBot_Action_luVars["resetIndicator"] then ghb.indreset=true end
                if HealBot_Action_luVars["resetText"] then ghb.text.reset=true end
                if HealBot_Action_luVars["resetAux"] then ghb.auxreset=true end
                --ghb.reset=true
            end
        end
        HealBot_Panel_ResetHeaders()
        HealBot_Action_luVars["resetSkin"]=false
        HealBot_Action_luVars["resetIcon"]=false
        HealBot_Action_luVars["resetIndicator"]=false
        HealBot_Action_luVars["resetText"]=false
        HealBot_Action_luVars["resetAux"]=false
    end
end

function HealBot_Action_SpellCmdCodes(cType, cText)
    local cID=nil
    if cType == "ENEMY" then
        if cText == HEALBOT_DISABLED_TARGET then
            cID="A"
        elseif cText == HEALBOT_FOCUS then
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
        end
    else
        if cText == HEALBOT_DISABLED_TARGET then
            cID="A"
        elseif cText == HEALBOT_ASSIST then
            cID="B"
        elseif cText == HEALBOT_FOCUS then
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
        end
    end
    --HealBot_setCall("HealBot_Action_SpellCmdCodes")
    return cID
end

function HealBot_Action_SpellCmdText(cType, cID)
    local cText=nil
    if cType == "ENEMY" then
        if cID == "A" then
            cText=HEALBOT_DISABLED_TARGET
        elseif cID == "B" then
            cText=HEALBOT_FOCUS
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
        end
    else
        if cID == "A" then
            cText=HEALBOT_DISABLED_TARGET
        elseif cID == "B" then
            cText=HEALBOT_ASSIST
        elseif cID == "C" then
            cText=HEALBOT_FOCUS
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
        end
    end
    --HealBot_setCall("HealBot_Action_SpellCmdText")
    return cText
end

function HealBot_Action_SetSpell(cType, cKey, sText)
    if sText then
        if HealBot_Text_Len(sText)>0 then
            local cID = HealBot_Action_SpellCmdCodes(cType, sText)
            if cID then 
                sText = "C:"..cID 
            else
                local _, _, _, _, _, _, spellId = GetSpellInfo(sText)
                if spellId then 
                    sText = "S:"..spellId
                else
                    local itemID = GetItemInfoInstant(sText)
                    if itemID then 
                        sText = "I:"..itemID 
                    else
                        local e,t=string.split("=", sText)
                        if e and e==HEALBOT_EMOTE and t then
                            sText = "E:"..t
                        end
                    end
                end
            end
        else
            sText=nil
        end
    end
    if cType == "ENABLED" then
        HealBot_Config_Spells.EnabledKeyCombo[cKey] = sText
    elseif cType == "ENEMY" then
        HealBot_Config_Spells.EnemyKeyCombo[cKey] = sText
    elseif cType == "EMERG" then
        HealBot_Config_Spells.EmergKeyCombo[cKey] = sText
    else
        HealBot_Globals.IconKeyCombo[cKey] = sText
    end
    --HealBot_setCall("HealBot_Action_SetSpell")
end

local HealBot_Action_SpellCache={}
HealBot_Action_SpellCache["ENABLED"]={}
HealBot_Action_SpellCache["ENEMY"]={}
HealBot_Action_SpellCache["EMERG"]={}
HealBot_Action_SpellCache["ICON"]={}

function HealBot_Action_ClearSpellCache(cType)
    if cType then
        HealBot_Action_SpellCache[cType]={}
    else
        HealBot_Action_SpellCache["ENABLED"]={}
        HealBot_Action_SpellCache["ENEMY"]={}
        HealBot_Action_SpellCache["EMERG"]={}
        HealBot_Action_SpellCache["ICON"]={}
    end
    --HealBot_setCall("HealBot_Action_ClearSpellCache")
end

local vSpellText=nil
function HealBot_Action_GetSpell(cType, cKey)
    vSpellText=HealBot_Action_SpellCache[cType][cKey]
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
            local sType,sID = string.split(":", vSpellText)
            if sType and sID then
                if sType == "C" then
                    vSpellText=HealBot_Action_SpellCmdText(cType, sID)
                elseif sType == "E" then
                    vSpellText=HEALBOT_EMOTE.."="..sID
                elseif sType == "I" then
                    vSpellText=GetItemInfo(sID)
                else
                    vSpellText=GetSpellInfo(sID)
                    if HEALBOT_GAME_VERSION<3 then
                        local rank = GetSpellSubtext(sID)
                        if rank then
                            local knownHealSpells=HealBot_Init_retFoundHealSpells()
                            if knownHealSpells[vSpellText] then
                                vSpellText=vSpellText.."("..rank..")"
                            end
                        end
                    end
                end
            end
            if vSpellText then 
                HealBot_Action_SpellCache[cType][cKey]=vSpellText
            end
        end
        --HealBot_setCall("HealBot_Action_GetSpell")
    end
    return vSpellText
end

local hbModKeys=false
function HealBot_Action_SetCurrentModKeys()
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
end

function HealBot_Action_SpellPattern(click, cType)
    sConcat[1]=HealBot_Action_luVars["CurrentModKey"]
    sConcat[2]=click
    sConcat[3]=HealBot_Config.CurrentSpec
    return HealBot_Action_GetSpell(cType, HealBot_Action_Concat(3))
end

local vAttribSpellName=""
function HealBot_Action_AttribSpellPattern(HB_combo_prefix)
    vAttribSpellName = HealBot_Action_GetSpell("ENABLED", HB_combo_prefix)
    if vAttribSpellName then
        return vAttribSpellName, 
               HealBot_Config_Spells.EnabledSpellTarget[HB_combo_prefix], 
               HealBot_Config_Spells.EnabledSpellTrinket1[HB_combo_prefix], 
               HealBot_Config_Spells.EnabledSpellTrinket2[HB_combo_prefix], 
               HealBot_Config_Spells.EnabledAvoidBlueCursor[HB_combo_prefix]
    else
        return false, false, false, false, false 
    end
    --HealBot_setCall("HealBot_Action_AttribSpellPattern")
end

function HealBot_Action_AttribEnemySpellPattern(HB_combo_prefix)
    vAttribSpellName = HealBot_Action_GetSpell("ENEMY", HB_combo_prefix)
    if vAttribSpellName then
        return vAttribSpellName, 
               HealBot_Config_Spells.EnemySpellTarget[HB_combo_prefix], 
               HealBot_Config_Spells.EnemySpellTrinket1[HB_combo_prefix], 
               HealBot_Config_Spells.EnemySpellTrinket2[HB_combo_prefix], 
               HealBot_Config_Spells.EnemyAvoidBlueCursor[HB_combo_prefix]
    else
        return false, false, false, false, false 
    end
    --HealBot_setCall("HealBot_Action_AttribEnemySpellPattern")
end

function HealBot_Action_AttribEmergSpellPattern(HB_combo_prefix)
    vAttribSpellName = HealBot_Action_GetSpell("EMERG", HB_combo_prefix)
    if vAttribSpellName then
        return vAttribSpellName, 
               HealBot_Config_Spells.EnemySpellTarget[HB_combo_prefix], 
               HealBot_Config_Spells.EnemySpellTrinket1[HB_combo_prefix], 
               HealBot_Config_Spells.EnemySpellTrinket2[HB_combo_prefix], 
               HealBot_Config_Spells.EnemyAvoidBlueCursor[HB_combo_prefix]
    else
        return false, false, false, false, false 
    end
    --HealBot_setCall("HealBot_Action_AttribEnemySpellPattern")
end

function HealBot_Action_AttribIconSpellPattern(HB_combo_prefix)
    vAttribSpellName = HealBot_Action_GetSpell("ICON", HB_combo_prefix)
    if vAttribSpellName then
        return vAttribSpellName, false, false, false, false
    else
        return false, false, false, false, false
    end
    --HealBot_setCall("HealBot_Action_AttribEnemySpellPattern")
end

local hbCustomName={}
local HealBot_customTempUserName={}
function HealBot_Action_CustomName(cName)
    local xGUID=hbCustomName["GUID"]
    local isAdd=hbCustomName["isAdd"]
    local isPerm=hbCustomName["isPerm"]
    if isAdd then
        if isPerm then
            HealBot_Globals.HealBot_customPermUserName[xGUID]=cName
        end
        HealBot_customTempUserName[xGUID]=cName
        HealBot_SetUnitName(cName, xGUID)
    else
        if isPerm then
            HealBot_Globals.HealBot_customPermUserName[xGUID]=nil
        else
            HealBot_customTempUserName[xGUID]=nil
        end
        HealBot_DelUnitName(xGUID)
    end
end

function HealBot_Action_GetCustomNameDialog(hbGUID, isAdd, isPerm)
    local dText=HEALBOT_WORDS_ADDTEMPCUSTOMNAME
    local cName = nil
    hbCustomName["GUID"]=hbGUID
    hbCustomName["isAdd"]=isAdd
    hbCustomName["isPerm"]=isPerm
    if isPerm then dText=HEALBOT_WORDS_ADDPERMCUSTOMNAME end
    StaticPopupDialogs["HEALBOT_WORDS_CUSTOMNAME"] = {
        text = dText,
        button1 = HEALBOT_WORDS_CUSTOMNAME,
        button2 = HEALBOT_WORD_CANCEL,
        hasEditBox = 1,
        whileDead = 1,
        hideOnEscape = 1,
        timeout = 0,
        OnShow = function(self)
            getglobal(self:GetName().."EditBox"):SetText("");
        end,
        OnAccept = function(self)
              cName = getglobal(self:GetName().."EditBox"):GetText();
              HealBot_Action_CustomName(cName)
        end,
    };
    StaticPopup_Show("HEALBOT_WORDS_CUSTOMNAME");
end

function HealBot_Action_DelCustomName(hbGUID, isAdd, isPerm)
    hbCustomName["GUID"]=hbGUID
    hbCustomName["isAdd"]=isAdd
    hbCustomName["isPerm"]=isPerm
    HealBot_Action_CustomName()
    --HealBot_setCall("HealBot_Action_DelCustomName")
end

function HealBot_Action_DoToggelMyFriend(button)
    if HealBot_Config.MyFriend==button.guid then
        HealBot_Config.MyFriend="x"
    else
        HealBot_Config.MyFriend=button.guid
    end
    HealBot_Check_UnitBuff(button)
end

function HealBot_Action_ToggelMyFriend(unit)
    _,xButton,pButton = HealBot_UnitID(unit)
    if xButton then 
        HealBot_Action_DoToggelMyFriend(xButton)
    elseif pButton then
        HealBot_Action_DoToggelMyFriend(pButton)
    end
end

function HealBot_Action_hbmountmenuFrame_DropDown_Initialize()
    local info
    info = UIDropDownMenu_CreateInfo();
    info.isTitle = true
    info.notCheckable = true
    if HEALBOT_GAME_VERSION>3 then
        info.text = HEALBOT_MOUNTSPETS
    else
        info.text = HEALBOT_MOUNTS
    end
    UIDropDownMenu_AddButton(info);
    wipe(info)
    info.disabled = true
    info.notCheckable = true
    UIDropDownMenu_AddButton(info)
    info.disabled = false
    info.notCheckable = true
    if HEALBOT_GAME_VERSION>2 then
        if HEALBOT_GAME_VERSION>3 then
            info.text = HEALBOT_RANDOMFAVMOUNT;
        else
            info.text = HEALBOT_FAVMOUNT;
        end
        info.func = function() HealBot_MountsPets_FavMount() end
        UIDropDownMenu_AddButton(info);

        info.text = HEALBOT_RANDOMMOUNT;
        info.func = function() HealBot_MountsPets_ToggelMount("all") end
        UIDropDownMenu_AddButton(info);
        info.text = HEALBOT_RANDOMGOUNDMOUNT;
        info.func = function() HealBot_MountsPets_ToggelMount("ground") end
        UIDropDownMenu_AddButton(info);
    end
    info.text = HEALBOT_CMD_DISMOUNT;
    info.func = function() HealBot_MountsPets_Dismount() end
    UIDropDownMenu_AddButton(info);
    if HEALBOT_GAME_VERSION>3 then
        wipe(info)
        info.disabled = true
        info.notCheckable = true
        UIDropDownMenu_AddButton(info)
        info.disabled = false
        info.notCheckable = true
        info.text = HEALBOT_RANDOMFAVPET;
        info.func = function() HealBot_MountsPets_RandomPet(true) end
        UIDropDownMenu_AddButton(info);
        info.text = HEALBOT_RANDOMPET;
        info.func = function() HealBot_MountsPets_RandomPet(false) end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Action_hbmenuFrame_DropDown_Initialize(self,level,menuList)
    local info
    level = level or 1;
    if level==1 then
        info = UIDropDownMenu_CreateInfo();
        info.isTitle = true
        info.notCheckable = true
        info.text = self.name
        UIDropDownMenu_AddButton(info, 1);
        
        wipe(info)
        info.disabled = true
        info.notCheckable = true
        UIDropDownMenu_AddButton(info)
        info.disabled = false
        
        info = UIDropDownMenu_CreateInfo();
        info.hasArrow = false; 
        info.notCheckable = true;
        if HealBot_AlwaysEnabled[UnitGUID(self.unit)] then
            info.text = HEALBOT_SKIN_DISTEXT;
        else
            info.text = HEALBOT_SKIN_ENTEXT;
        end
        info.func = function() HealBot_Action_Toggle_Enabled(self.unit); end
        UIDropDownMenu_AddButton(info, 1);
        
        info = UIDropDownMenu_CreateInfo();
        info.hasArrow = false; 
        info.notCheckable = true;
        if HealBot_Config.MyFriend==UnitGUID(self.unit) then
            info.text = HEALBOT_WORDS_UNSET.." "..HEALBOT_OPTIONS_MYFRIEND;
        else
            info.text = HEALBOT_WORDS_SETAS.." "..HEALBOT_OPTIONS_MYFRIEND
        end
        info.func = function() HealBot_Action_ToggelMyFriend(self.unit); end;
        UIDropDownMenu_AddButton(info, 1);

        if UnitIsPlayer(self.unit) then
            info = UIDropDownMenu_CreateInfo();
            info.notCheckable = true;
            info.text = HEALBOT_WORDS_CUSTOMNAME
            info.hasArrow = true; 
            info.menuList = "cNames"
            UIDropDownMenu_AddButton(info, 1);

            wipe(info)
            info.disabled = true
            info.notCheckable = true
            UIDropDownMenu_AddButton(info)
            info.disabled = false
            
            info = UIDropDownMenu_CreateInfo();
            info.notCheckable = true;
            info.text = HEALBOT_OPTIONS_MYTARGET
            info.hasArrow = true; 
            info.menuList = "myHeals"
            UIDropDownMenu_AddButton(info, 1);
            
            info = UIDropDownMenu_CreateInfo();
            info.notCheckable = true;
            info.text = HEALBOT_OPTIONS_PRIVATETANKS
            info.hasArrow = true; 
            info.menuList = "pTanks"
            UIDropDownMenu_AddButton(info, 1);
            
            info = UIDropDownMenu_CreateInfo();
            info.notCheckable = true;
            info.text = HEALBOT_OPTIONS_PRIVATEHEALERS
            info.hasArrow = true; 
            info.menuList = "pHeals"
            UIDropDownMenu_AddButton(info, 1);
            
            info = UIDropDownMenu_CreateInfo();
            info.notCheckable = true;
            info.text = HEALBOT_OPTIONS_PRIVATEDAMAGERS
            info.hasArrow = true; 
            info.menuList = "pDPS"
            UIDropDownMenu_AddButton(info, 1);
        else
            info = UIDropDownMenu_CreateInfo();
            info.hasArrow = false; 
            info.notCheckable = true;
            if HealBot_customTempUserName[UnitGUID(self.unit)] then
                info.text = HEALBOT_WORDS_REMOVETEMPCUSTOMNAME
                info.func = function() HealBot_Action_DelCustomName(UnitGUID(self.unit), false, false); end;
            else
                info.text = HEALBOT_WORDS_ADDTEMPCUSTOMNAME
                info.func = function() HealBot_Action_GetCustomNameDialog(UnitGUID(self.unit), true, false); end;
            end
            UIDropDownMenu_AddButton(info, 1);

            wipe(info)
            info.disabled = true
            info.notCheckable = true
            UIDropDownMenu_AddButton(info)
            info.disabled = false
            
            info = UIDropDownMenu_CreateInfo();
            info.hasArrow = false; 
            info.notCheckable = true;
            if HealBot_Panel_RetMyHealTarget(self.unit, false) then
                info.text = HEALBOT_WORDS_REMOVEFROM.." "..HEALBOT_OPTIONS_MYTARGET;
            else
                info.text = HEALBOT_WORDS_ADDTO.." "..HEALBOT_OPTIONS_MYTARGET
            end
            info.func = function() HealBot_Panel_ToggelHealTarget(self.unit, true); end;
            UIDropDownMenu_AddButton(info, 1);

            info = UIDropDownMenu_CreateInfo();
            info.hasArrow = false; 
            info.notCheckable = true;
            if HealBot_Panel_RetPrivateTanks(self.unit, false) then
                info.text = HEALBOT_WORDS_REMOVEFROM.." "..HEALBOT_OPTIONS_PRIVATETANKS;
            else
                info.text = HEALBOT_WORDS_ADDTO.." "..HEALBOT_OPTIONS_PRIVATETANKS
            end
            info.func = function() HealBot_Panel_ToggelPrivateTanks(self.unit, false); end;
            UIDropDownMenu_AddButton(info, 1);

            info = UIDropDownMenu_CreateInfo();
            info.hasArrow = false; 
            info.notCheckable = true;
            if HealBot_Panel_RetPrivateHealers(self.unit, false) then
                info.text = HEALBOT_WORDS_REMOVEFROM.." "..HEALBOT_OPTIONS_PRIVATEHEALERS;
            else
                info.text = HEALBOT_WORDS_ADDTO.." "..HEALBOT_OPTIONS_PRIVATEHEALERS
            end
            info.func = function() HealBot_Panel_ToggelPrivateHealers(self.unit, false); end;
            UIDropDownMenu_AddButton(info, 1);

            info = UIDropDownMenu_CreateInfo();
            info.hasArrow = false; 
            info.notCheckable = true;
            if HealBot_Panel_RetPrivateDamagers(self.unit, false) then
                info.text = HEALBOT_WORDS_REMOVEFROM.." "..HEALBOT_OPTIONS_PRIVATEDAMAGERS;
            else
                info.text = HEALBOT_WORDS_ADDTO.." "..HEALBOT_OPTIONS_PRIVATEDAMAGERS
            end
            info.func = function() HealBot_Panel_ToggelPrivateDamagers(self.unit, false); end;
            UIDropDownMenu_AddButton(info, 1);
        end

        wipe(info)
        info.disabled = true
        info.notCheckable = true
        UIDropDownMenu_AddButton(info)
        info.disabled = false
        
        if HEALBOT_GAME_VERSION>1 then 
            info = UIDropDownMenu_CreateInfo();
            info.notCheckable = true;
            if HealBot_retHbFocus(self.unit) then
                info.text = HEALBOT_WORD_CLEAR.." "..HEALBOT_WORD_HBFOCUS;
                info.hasArrow = false;
                info.func = function() HealBot_ToggelFocusMonitor(self.unit); end;
            else
                info.text = HEALBOT_WORD_SET.." "..HEALBOT_WORD_HBFOCUS
                info.hasArrow = true; 
                info.menuList = "hbFocus"
            end
            UIDropDownMenu_AddButton(info, 1);
        end
        
        info = UIDropDownMenu_CreateInfo();
        info.hasArrow = false; 
        info.notCheckable = true;
        info.text = HEALBOT_WORD_RESET
        info.func = function() HealBot_Reset_Unit(self.unit); end
        UIDropDownMenu_AddButton(info, 1);
        
        info = UIDropDownMenu_CreateInfo();
        info.hasArrow = false; 
        info.notCheckable = true;
        info.text = HEALBOT_PANEL_BLACKLIST
        info.func = function() HealBot_Panel_AddBlackList(self.unit); end
        UIDropDownMenu_AddButton(info, 1);
        
        info = UIDropDownMenu_CreateInfo();
        info.hasArrow = false; 
        info.notCheckable = true;
        info.text = HEALBOT_WORD_CANCEL
        UIDropDownMenu_AddButton(info, 1);
    elseif menuList=="cNames" then
        info = UIDropDownMenu_CreateInfo();
        info.hasArrow = false; 
        info.notCheckable = true;
        if HealBot_Globals.HealBot_customPermUserName[UnitGUID(self.unit)] then
            info.text = HEALBOT_WORDS_REMOVEPERMCUSTOMNAME
            info.func = function() HealBot_Action_DelCustomName(UnitGUID(self.unit), false, true); end;
        else
            info.text = HEALBOT_WORDS_ADDPERMCUSTOMNAME
            info.func = function() HealBot_Action_GetCustomNameDialog(UnitGUID(self.unit), true, true); end;
        end
        UIDropDownMenu_AddButton(info, 2);
    
        info = UIDropDownMenu_CreateInfo();
        info.hasArrow = false; 
        info.notCheckable = true;
        if HealBot_customTempUserName[UnitGUID(self.unit)] then
            info.text = HEALBOT_WORDS_REMOVETEMPCUSTOMNAME
            info.func = function() HealBot_Action_DelCustomName(UnitGUID(self.unit), false, false); end;
        else
            info.text = HEALBOT_WORDS_ADDTEMPCUSTOMNAME
            info.func = function() HealBot_Action_GetCustomNameDialog(UnitGUID(self.unit), true, false); end;
        end
        UIDropDownMenu_AddButton(info, 2);
    elseif menuList=="myHeals" then        
        info = UIDropDownMenu_CreateInfo();
        info.hasArrow = false; 
        info.notCheckable = true;
        if HealBot_Panel_RetMyHealTarget(self.unit, false) then
            info.text = HEALBOT_WORDS_REMOVEFROM.." "..HEALBOT_OPTIONS_MYTARGET;
        else
            info.text = HEALBOT_WORDS_ADDTO.." "..HEALBOT_OPTIONS_MYTARGET
        end
        info.func = function() HealBot_Panel_ToggelHealTarget(self.unit, false); end;
        UIDropDownMenu_AddButton(info, 2);
           
        info = UIDropDownMenu_CreateInfo();
        info.hasArrow = false; 
        info.notCheckable = true;
        if HealBot_Panel_RetMyHealTarget(self.unit, true) then
            info.text = HEALBOT_WORDS_REMOVEFROM.." "..HEALBOT_WORD_PERMANENT.." "..HEALBOT_OPTIONS_MYTARGET;
        else
            info.text = HEALBOT_WORDS_ADDTO.." "..HEALBOT_WORD_PERMANENT.." "..HEALBOT_OPTIONS_MYTARGET
        end
        info.func = function() HealBot_Panel_ToggelHealTarget(self.unit, true); end;
        UIDropDownMenu_AddButton(info, 2);
    elseif menuList=="pTanks" then
        info = UIDropDownMenu_CreateInfo();
        info.hasArrow = false; 
        info.notCheckable = true;
        if HealBot_Panel_RetPrivateTanks(self.unit, false) then
            info.text = HEALBOT_WORDS_REMOVEFROM.." "..HEALBOT_OPTIONS_PRIVATETANKS;
        else
            info.text = HEALBOT_WORDS_ADDTO.." "..HEALBOT_OPTIONS_PRIVATETANKS
        end
        info.func = function() HealBot_Panel_ToggelPrivateTanks(self.unit, false); end;
        UIDropDownMenu_AddButton(info, 2);
        
        info = UIDropDownMenu_CreateInfo();
        info.hasArrow = false; 
        info.notCheckable = true;
        if HealBot_Panel_RetPrivateTanks(self.unit, true) then
            info.text = HEALBOT_WORDS_REMOVEFROM.." "..HEALBOT_WORD_PERMANENT.." "..HEALBOT_OPTIONS_PRIVATETANKS;
        else
            info.text = HEALBOT_WORDS_ADDTO.." "..HEALBOT_WORD_PERMANENT.." "..HEALBOT_OPTIONS_PRIVATETANKS
        end
        info.func = function() HealBot_Panel_ToggelPrivateTanks(self.unit, true); end;
        UIDropDownMenu_AddButton(info, 2);
    elseif menuList=="pHeals" then
        info = UIDropDownMenu_CreateInfo();
        info.hasArrow = false; 
        info.notCheckable = true;
        if HealBot_Panel_RetPrivateHealers(self.unit, false) then
            info.text = HEALBOT_WORDS_REMOVEFROM.." "..HEALBOT_OPTIONS_PRIVATEHEALERS;
        else
            info.text = HEALBOT_WORDS_ADDTO.." "..HEALBOT_OPTIONS_PRIVATEHEALERS
        end
        info.func = function() HealBot_Panel_ToggelPrivateHealers(self.unit, false); end;
        UIDropDownMenu_AddButton(info, 2);
        
        info = UIDropDownMenu_CreateInfo();
        info.hasArrow = false; 
        info.notCheckable = true;
        if HealBot_Panel_RetPrivateHealers(self.unit, true) then
            info.text = HEALBOT_WORDS_REMOVEFROM.." "..HEALBOT_WORD_PERMANENT.." "..HEALBOT_OPTIONS_PRIVATEHEALERS;
        else
            info.text = HEALBOT_WORDS_ADDTO.." "..HEALBOT_WORD_PERMANENT.." "..HEALBOT_OPTIONS_PRIVATEHEALERS
        end
        info.func = function() HealBot_Panel_ToggelPrivateHealers(self.unit, true); end;
        UIDropDownMenu_AddButton(info, 2);
    elseif menuList=="pDPS" then
        info = UIDropDownMenu_CreateInfo();
        info.hasArrow = false; 
        info.notCheckable = true;
        if HealBot_Panel_RetPrivateDamagers(self.unit, false) then
            info.text = HEALBOT_WORDS_REMOVEFROM.." "..HEALBOT_OPTIONS_PRIVATEDAMAGERS;
        else
            info.text = HEALBOT_WORDS_ADDTO.." "..HEALBOT_OPTIONS_PRIVATEDAMAGERS
        end
        info.func = function() HealBot_Panel_ToggelPrivateDamagers(self.unit, false); end;
        UIDropDownMenu_AddButton(info, 2);
        
        info = UIDropDownMenu_CreateInfo();
        info.hasArrow = false; 
        info.notCheckable = true;
        if HealBot_Panel_RetPrivateDamagers(self.unit, true) then
            info.text = HEALBOT_WORDS_REMOVEFROM.." "..HEALBOT_WORD_PERMANENT.." "..HEALBOT_OPTIONS_PRIVATEDAMAGERS;
        else
            info.text = HEALBOT_WORDS_ADDTO.." "..HEALBOT_WORD_PERMANENT.." "..HEALBOT_OPTIONS_PRIVATEDAMAGERS
        end
        info.func = function() HealBot_Panel_ToggelPrivateDamagers(self.unit, true); end;
        UIDropDownMenu_AddButton(info, 2);
    elseif menuList=="hbFocus" and HEALBOT_GAME_VERSION>1 then
        info = UIDropDownMenu_CreateInfo();
        info.text = HEALBOT_WORD_ALLZONE
        info.hasArrow = false; 
        info.notCheckable = true;
        info.func = function() HealBot_ToggelFocusMonitor(self.unit, "all"); end;
        UIDropDownMenu_AddButton(info, 2);
        
        info = UIDropDownMenu_CreateInfo();
        local _,z = IsInInstance()
        if z=="pvp" or z == "arena" then 
            info.text = HEALBOT_WORD_BATTLEGROUND
        elseif z~="none" then
            info.text=GetRealZoneText()
        else
            info.text = HEALBOT_WORD_OUTSIDE
        end
        info.hasArrow = false; 
        info.notCheckable = true;
        info.func = function() HealBot_ToggelFocusMonitor(self.unit, z); end;
        UIDropDownMenu_AddButton(info, 2);
    end
    --HealBot_setCall("HealBot_Action_hbmenuFrame_DropDown_Initialize")
end

function HealBot_Action_AlterSpell2Macro(spellName, spellTar, spellTrin1, spellTrin2, spellAvoidBC, unit, cType)
    local smName=""
    local spellType="help"
    if cType=="Enemy" then spellType="harm" end
    local scText="/cast [@"..unit..","..spellType.."] "..spellName.."\n"

    if HealBot_Globals.MacroSuppressError then smName=smName..'/hb se3\n' end
    if HealBot_Globals.MacroSuppressSound then smName=smName..'/hb se1\n' end
    if spellTar then smName=smName.."/target "..unit.."\n" end
    if spellTrin1 then smName=smName.."/use 13\n" end
    if spellTrin2 then smName=smName.."/use 14\n" end
    if HealBot_Config.MacroUse10 then smName=smName.."/use 10\n" end
    if HealBot_Globals.MacroSuppressSound then smName=smName.."/hb se2\n" end
    if HealBot_Globals.MacroSuppressError then smName=smName..'/hb se4\n' end
    smName=smName..scText
    if spellAvoidBC then smName=smName.."/use 4\n" end
    --HealBot_setCall("HealBot_Action_AlterSpell2Macro")
    return smName
end

function HealBot_Action_UnitID(unit)
    if strsub(unit,1,4)=="raid" then
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
    --HealBot_setCall("HealBot_Action_UnitID")
    return unit
end


local tAttribConcat={}
local hbAttribsMinResetElement=""

function HealBot_Action_ReturnAttribsFramesMinReset(button, prefix, cType, bno)
    tAttribConcat[1]=prefix
    tAttribConcat[2]=bno
    hbAttribsMinResetElement=tabconcat(tAttribConcat,"",1,2)
    return button.attribs[cType][hbAttribsMinResetElement]
end

function HealBot_Action_UpdateAttribsMinReset(button, prefix, cType, bno, value)
    tAttribConcat[1]=prefix
    tAttribConcat[2]=bno
    hbAttribsMinResetElement=tabconcat(tAttribConcat,"",1,2)
    button.attribs[cType][hbAttribsMinResetElement]=value
end

function HealBot_Action_DoSetButtonAttrib(button,cType,j,unit,HB_prefix,buttonType,sName,sTar,sTrin1,sTrin2,AvoidBC,sType)
    if sName then
        local mId=GetMacroIndexByName(sName)
        if strlower(sName)==strlower(HEALBOT_DISABLED_TARGET) then
            button:SetAttribute(HB_prefix..buttonType..j, "target"..j);
            button:SetAttribute(HB_prefix.."type"..j, "target")
            button:SetAttribute(HB_prefix.."type-target"..j, "target")
            HealBot_Action_UpdateAttribsMinReset(button, HB_prefix, cType, j, 2)
        elseif strlower(sName)==strlower(HEALBOT_FOCUS) then
            button:SetAttribute(HB_prefix..buttonType..j, "focus"..j);
            button:SetAttribute(HB_prefix.."type"..j, "focus")
            button:SetAttribute(HB_prefix.."type-focus"..j, "focus")
            HealBot_Action_UpdateAttribsMinReset(button, HB_prefix, cType, j, 2)
        elseif strlower(sName)==strlower(HEALBOT_ASSIST) then
            button:SetAttribute(HB_prefix..buttonType..j, "assist"..j);
            button:SetAttribute(HB_prefix.."type"..j, "assist")
            button:SetAttribute(HB_prefix.."type-assist"..j, "assist")
            HealBot_Action_UpdateAttribsMinReset(button, HB_prefix, cType, j, 2)
        elseif strlower(sName)==strlower(HEALBOT_STOP) then
            button:SetAttribute(HB_prefix..buttonType..j, nil);
            button:SetAttribute(HB_prefix.."type"..j, "macro")
            button:SetAttribute(HB_prefix.."macrotext"..j, "/stopcasting")
            HealBot_Action_UpdateAttribsMinReset(button, HB_prefix, cType, j, 2)
        elseif strlower(sName)==strlower(HEALBOT_MENU) then
            button:SetAttribute(HB_prefix..buttonType..j, nil);
            button:SetAttribute(HB_prefix.."type"..j, "togglemenu")
            HealBot_Action_UpdateAttribsMinReset(button, HB_prefix, cType, j, 2)
        elseif strlower(sName)==strlower(HEALBOT_HBMENU) then
            button:SetAttribute(HB_prefix..buttonType..j, nil);
            button:SetAttribute(HB_prefix.."type"..j, "showhbmenu")
            showHBmenu = function()
                if UnitExists(unit) then
                    local HBFriendsDropDown = CreateFrame("Frame", "HealBot_Action_hbmenuFrame_DropDown", UIParent, "UIDropDownMenuTemplate");
                    HBFriendsDropDown.unit = unit
                    HBFriendsDropDown.name = UnitName(unit)
                    HBFriendsDropDown.initialize = HealBot_Action_hbmenuFrame_DropDown_Initialize
                    HBFriendsDropDown.displayMode = "MENU"
                    ToggleDropDownMenu(1, nil, HBFriendsDropDown, "cursor", 10, -8)
                end
            end
            button.showhbmenu = showHBmenu
        elseif HEALBOT_GAME_VERSION>2 and (strlower(sName)==strlower(HEALBOT_MOUNTS) or strlower(sName)==strlower(HEALBOT_MOUNTSPETS)) then
            if UnitIsUnit(unit, "player") then
                button:SetAttribute(HB_prefix..buttonType..j, nil);
                button:SetAttribute(HB_prefix.."type"..j, "showhbmountmenu")
                showhbmountmenu = function()
                    local HBFriendsDropDown = CreateFrame("Frame", "HealBot_Action_hbmountmenuFrame_DropDown", UIParent, "UIDropDownMenuTemplate");
                    HBFriendsDropDown.initialize = HealBot_Action_hbmountmenuFrame_DropDown_Initialize
                    HBFriendsDropDown.displayMode = "MENU"
                    ToggleDropDownMenu(1, nil, HBFriendsDropDown, "cursor", 10, -8)
                end
                button.showhbmountmenu = showhbmountmenu
            else
                button:SetAttribute(HB_prefix..buttonType..j, nil)
            end
        elseif HEALBOT_GAME_VERSION>2 and strlower(sName)==strlower(HEALBOT_FAVMOUNT) then
            if UnitIsUnit(unit, "player") then
                button:SetAttribute(HB_prefix..buttonType..j, nil);
                button:SetAttribute(HB_prefix.."type"..j, "macro")
                button:SetAttribute(HB_prefix.."macrotext"..j, "/run HealBot_MountsPets_FavMount()")
            else
                button:SetAttribute(HB_prefix..buttonType..j, nil)
            end
        elseif HEALBOT_GAME_VERSION>2 and strlower(sName)==strlower(HEALBOT_RANDOMMOUNT) then
            if UnitIsUnit(unit, "player") then
                button:SetAttribute(HB_prefix..buttonType..j, nil);
                button:SetAttribute(HB_prefix.."type"..j, "macro")
                button:SetAttribute(HB_prefix.."macrotext"..j, '/run HealBot_MountsPets_ToggelMount("all")')
            else
                button:SetAttribute(HB_prefix..buttonType..j, nil)
            end
        elseif HEALBOT_GAME_VERSION>2 and strlower(sName)==strlower(HEALBOT_RANDOMGOUNDMOUNT) then
            if UnitIsUnit(unit, "player") then
                button:SetAttribute(HB_prefix..buttonType..j, nil);
                button:SetAttribute(HB_prefix.."type"..j, "macro")
                button:SetAttribute(HB_prefix.."macrotext"..j, '/run HealBot_MountsPets_ToggelMount("ground")')
            else
                button:SetAttribute(HB_prefix..buttonType..j, nil)
            end
        elseif HEALBOT_GAME_VERSION>3 and strlower(sName)==strlower(HEALBOT_FAVPET) then
            if UnitIsUnit(unit, "player") then
                button:SetAttribute(HB_prefix..buttonType..j, nil);
                button:SetAttribute(HB_prefix.."type"..j, "macro")
                button:SetAttribute(HB_prefix.."macrotext"..j, "/run C_PetJournal.SummonRandomPet(true)")
            else
                button:SetAttribute(HB_prefix..buttonType..j, nil)
            end
        elseif strlower(sName)==strlower(HEALBOT_CANCELPLUGINALERT) then
            button:SetAttribute(HB_prefix..buttonType..j, nil);
            button:SetAttribute(HB_prefix.."type"..j, "macro")
            button:SetAttribute(HB_prefix.."macrotext"..j, '/run HealBot_Action_DisableBorderHazardTypeGUID("'..button.guid..'", "PLUGIN")')
        elseif HealBot_Spell_Names[sName] then
            if sTar or sTrin1 or sTrin2 or AvoidBC then
                local mText = HealBot_Action_AlterSpell2Macro(sName, sTar, sTrin1, sTrin2, AvoidBC, unit, cType)
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
        elseif IsUsableItem(sName) then
            button:SetAttribute(HB_prefix..buttonType..j, "item"..j);
            button:SetAttribute(HB_prefix.."type-item"..j, "item");
            button:SetAttribute(HB_prefix.."item-item"..j, sName);
            HealBot_Action_UpdateAttribsMinReset(button, HB_prefix, cType, j, 2)
        else
            local e,t=string.split("=", sName)
            if e and strlower(e)==strlower(HEALBOT_EMOTE) and t then
                button:SetAttribute(HB_prefix..buttonType..j, nil);
                button:SetAttribute(HB_prefix.."type"..j, "macro")
                button:SetAttribute(HB_prefix.."macrotext"..j, "/run DoEmote(\""..t.."\", "..unit..")")
            elseif sTar or sTrin1 or sTrin2 or AvoidBC then
                local mText = HealBot_Action_AlterSpell2Macro(sName, sTar, sTrin1, sTrin2, AvoidBC, unit, cType)
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
        button:SetAttribute(HB_prefix.."checkselfcast"..j, "false")
        return true
    else
        button:SetAttribute(HB_prefix..buttonType..j, nil);
        HealBot_Action_UpdateAttribsMinReset(button, HB_prefix, cType, j, 1)
        return false
    end
end

function HealBot_Action_SetButtonAttrib(button,bbutton,bkey,cType,j,unit)
    local HB_prefix = "";
    local buttonType="helpbutton"
    local sType="heal"
    if strlen(bkey)>1 then
        HB_prefix = strlower(bkey).."-"
    end
    local HB_combo_prefix = bkey..bbutton..HealBot_Config.CurrentSpec;
    local sName,sTar,sTrin1,sTrin2,AvoidBC=false,false,false,false,false
    HealBot_Action_UpdateAttribsMinReset(button, HB_prefix, cType, j, false)
    if cType=="Emerg" then
        sName, sTar, sTrin1, sTrin2, AvoidBC = HealBot_Action_AttribEmergSpellPattern(HB_combo_prefix)
        HealBot_Action_DoSetButtonAttrib(button,cType,j,unit,HB_prefix,"harmbutton",sName,sTar,sTrin1,sTrin2,AvoidBC,"harm")
    elseif cType=="Enemy" then
        sName, sTar, sTrin1, sTrin2, AvoidBC = HealBot_Action_AttribEnemySpellPattern(HB_combo_prefix)
        buttonType="harmbutton"
        sType="harm"
    else
        sName, sTar, sTrin1, sTrin2, AvoidBC = HealBot_Action_AttribSpellPattern(HB_combo_prefix)
    end
    --HealBot_setCall("HealBot_Action_SetButtonAttrib")
    return HealBot_Action_DoSetButtonAttrib(button,cType,j,unit,HB_prefix,buttonType,sName,sTar,sTrin1,sTrin2,AvoidBC,sType)
end

local hbMaxMouseButtons={["Enemy"]=20,["Enabled"]=20,["Emerg"]=5}
local hbBindTxt={}
function HealBot_Action_DefaultBinds(button)
    button:SetAttribute("_onleave", "self:ClearBindings();");
    button:SetAttribute("_onshow", "self:ClearBindings();");
    button:SetAttribute("_onhide", "self:ClearBindings();");
end

function HealBot_Action_InitBinds(button)
    hbBindTxt[0]=""
    button:SetAttribute("_onenter", "self:ClearBindings();");
    HealBot_Action_DefaultBinds(button)
end

function HealBot_Action_Binds(bNo)
    hbBindTxt[bNo]=[[self:SetBindingClick(1, "]] .. HealBot_Options_retBindKey(HealBot_Config_Spells.Binds[bNo]) .. [[", self, "Button]] .. bNo .. [[");]]
end

function HealBot_Action_SetBinds(button, maxButton)
    for x=1,maxButton do
        if string.len(hbBindTxt[x])>0 then hbBindTxt[0]=hbBindTxt[0]..hbBindTxt[x] end
    end
    button:SetAttribute("_onenter", "self:ClearBindings();"..hbBindTxt[0]);
    HealBot_Action_DefaultBinds(button)
end

function HealBot_Action_SetAllButtonAttribs(button,cType,prep)
    if hbMaxMouseButtons[cType]>0 then
        local hasSpells,attribSet,maxBinds=false,false,0
        for x=1, hbMaxMouseButtons[cType] do
            hasSpells=false
            for y=1, getn(HealBot_Keys_List), 1 do
                if strlen(HealBot_Keys_List[y])>1 then
                    HB_prefix = strlower(HealBot_Keys_List[y]).."-"
                else
                    HB_prefix = "";
                end
                attribSet=HealBot_Action_ReturnAttribsFramesMinReset(button, HB_prefix, cType, x)
                if not attribSet then
                    if x==1 then 
                        HB_button="Left";
                    elseif x==2 then 
                        HB_button="Right";
                    elseif x==3 then 
                        HB_button="Middle";
                    else
                        HB_button="Button"..x
                    end
                    if HealBot_Action_SetButtonAttrib(button,HB_button,HealBot_Keys_List[y],cType,x,button.unit) then
                        hasSpells=true 
                    end
                elseif attribSet==2 then
                    hasSpells=true
                end
            end
            if hasSpells then
                hbMaxMouseButtons[cType]=x
            elseif x==20 and hbMaxMouseButtons[cType]==20 then 
                hbMaxMouseButtons[cType]=0
            end
            if not button.binds[cType].set then
                if (x<6 or (x>5 and HealBot_retLuVars("pluginExtraButtons"))) and HealBot_Config_Spells.Binds[x]>1 then
                    if maxBinds==0 then
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
    --HealBot_AddDebug(cType.." Max Mouse Buttons used = "..hbMaxMouseButtons[cType])
    --HealBot_setCall("HealBot_Action_SetAllButtonAttribs")
end

function HealBot_Action_PrepSetEnabledAttribs()
    if HealBot_Action_luVars["ButtonHWM"]>0 then
        local ghb,ehb
        for i=1,HealBot_Action_luVars["ButtonHWM"] do
            ghb=_G["HealBot_Action_HealUnit"..i]
            if ghb then
                ghb.attribs["Enabled"]={}
                ghb.binds["Enabled"]={}
            end
            ehb= _G["HealBot_Action_EmergUnit"..i]
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
    if HealBot_Action_luVars["ButtonHWM"]>0 then
        local ghb,ehb
        for i=1,HealBot_Action_luVars["ButtonHWM"] do
            ghb=_G["HealBot_Action_HealUnit"..i]
            if ghb then
                ghb.attribs["Enemy"]={}
                ghb.binds["Enemy"]={}
            end
            ehb= _G["HealBot_Action_EmergUnit"..i]
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
    if HealBot_Action_luVars["ButtonHWM"]>0 then
        local ghb,ehb
        for i=1,HealBot_Action_luVars["ButtonHWM"] do
            ghb=_G["HealBot_Action_HealUnit"..i]
            if ghb then
                ghb.attribs["Emerg"]={}
                ghb.binds["Emerg"]={}
            end
            ehb= _G["HealBot_Action_EmergUnit"..i]
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
    if HealBot_Action_luVars["ButtonHWM"]>0 then
        local ghb,ehb
        for i=1,HealBot_Action_luVars["ButtonHWM"] do
            ghb=_G["HealBot_Action_HealUnit"..i]
            if ghb then
                ghb.attribs={["Emerg"]={},["Enemy"]={},["Enabled"]={}}
                ghb.binds={["Emerg"]={},["Enemy"]={},["Enabled"]={}}
            end
            ehb= _G["HealBot_Action_EmergUnit"..i]
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

local function HealBot_Action_SetHealButtonAuraCols(button)
    if button.status.unittype<11 then
        if HealBot_Config_Buffs.CBshownHB and (not HealBot_Action_luVars["InRaid"] or HealBot_Config_Buffs.ShowGroups[HealBot_RetUnitGroups(button.unit)])  then
            button.aura.buff.showcol=true
        else
            button.aura.buff.showcol=false
        end
        if HealBot_Config_Cures.CDCshownHB and (not HealBot_Action_luVars["InRaid"] or HealBot_Config_Cures.ShowGroups[HealBot_RetUnitGroups(button.unit)]) then
            button.icon.debuff.showcol=true
        else
            button.icon.debuff.showcol=false
        end
    else
        button.aura.buff.showcol=false
        button.icon.debuff.showcol=false
    end
end

function HealBot_Action_SetAllHealButtonAuraCols()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Action_SetHealButtonAuraCols(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Action_SetHealButtonAuraCols(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Action_SetHealButtonAuraCols(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Action_SetHealButtonAuraCols(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Action_SetHealButtonAuraCols(xButton)
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
    if UnitExists(button.unit) then
        if UnitGUID(button.unit)==button.guid then
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

function HealBot_Action_getGuidData(guid, attrib)
    if not hbGuidData[guid] then
        return hbGuidDefault[attrib]
    else
        return hbGuidData[guid][attrib]
    end
end

function HealBot_Action_setGuidData(button, attrib, value, callback)
    if hbGuidData[button.guid] then 
        hbGuidData[button.guid][attrib]=value
    else
        HealBot_Action_initGuidData(button)
        if not callback then HealBot_Action_setGuidData(button, attrib, value, true) end
    end
end

function HealBot_Action_setGuidSpec(button, spec)
    button.spec = " "..spec.." "
    HealBot_Action_setGuidData(button, "SPEC", button.spec)
    HealBot_Action_setGuidData(button, "TMPSPEC", button.spec)
    HealBot_Timers_Set("INIT","RefreshPartyNextRecalcPlayers",1.25)
end

function HealBot_Action_SetRangeSpellType(button, hostile)
    if hostile then
        button.status.rangespell=HealBot_RangeSpellsKeysEnemy[HealBot_Action_luVars["CurrentModKey"]]
    elseif HealBot_Action_ActiveButton.id~=button.id and button.status.rangespellspecial then
        button.status.rangespell=button.status.rangespellspecial
    else
        button.status.rangespell=HealBot_RangeSpellsKeysFriendly[HealBot_Action_luVars["CurrentModKey"]]
    end
    HealBot_UpdateUnitRange(button)
end

function HealBot_Action_SetActiveButton(id)
    if HealBot_Action_ActiveButton.id>0 then
        HealBot_Action_ActiveButton.lastid=HealBot_Action_ActiveButton.id
    end
    HealBot_Action_ActiveButton.id=id
    if HealBot_Action_ActiveButton.id>0 then
        HealBot_Action_SetRangeSpell(HealBot_Buttons[HealBot_Action_ActiveButton.id])
        HealBot_Action_ActiveButton.lastid=0
    elseif HealBot_Action_ActiveButton.lastid>0 and HealBot_Buttons[HealBot_Action_ActiveButton.lastid] then
        HealBot_Action_SetRangeSpell(HealBot_Buttons[HealBot_Action_ActiveButton.lastid])
    end
end

function HealBot_Action_SetRangeSpell(button)
    if not UnitIsFriend("player",button.unit) then
        HealBot_Action_SetRangeSpellType(button, true)
    else
        HealBot_Action_SetRangeSpellType(button, false)
    end
end

local hButton=false
local vEnemyUnitsWithEvents={["boss1"]=true,["boss2"]=true,["boss3"]=true,["boss4"]=true,
                             ["arena1"]=true,["arena2"]=true,["arena3"]=true,["arena4"]=true,["arena5"]=true}
function HealBot_Action_SetHealButton(unit,guid,frame,unitType,duplicate,role,preCombat)
    hButton=false
    if guid then
        if unitType<5 then
            hButton=HealBot_Private_Button[unit] or HealBot_Action_CreateButton(frame)
        elseif unitType==8 then
            hButton=HealBot_Pet_Button[unit] or HealBot_Action_CreateButton(frame)
        elseif unitType==7 then
            hButton=HealBot_Vehicle_Button[unit] or HealBot_Action_CreateButton(frame)
        elseif unitType>10 then
            hButton=HealBot_Enemy_Button[unit] or HealBot_Action_CreateButton(frame)
        elseif unitType>8 then
            hButton=HealBot_Extra_Button[unit] or HealBot_Action_CreateButton(frame)
        else
            hButton=HealBot_Unit_Button[unit] or HealBot_Action_CreateButton(frame)
        end
        if hButton.status.markdel then
            hButton=HealBot_Action_CreateButton(frame)
            HealBot_AddDebug("hButton has marked delete - unit="..(unit or "nil"), "Panel", true)
        end
        if hButton then
            hButton.gref["Back"]:ClearAllPoints()
            hButton.test=false
            erButton=HealBot_Emerg_Button[hButton.id]
            if hButton.frame~=frame or hButton.skin~=Healbot_Config_Skins.Current_Skin then
                hButton:ClearAllPoints()
                hButton:SetParent(grpFrame[frame])
                erButton:ClearAllPoints()
                erButton:SetParent(grpFrame[frame])
                hButton.frame=frame
                hButton.skin=Healbot_Config_Skins.Current_Skin
                hButton.icon.reset=true
                hButton.text.reset=true
                hButton.skinreset=true
                hButton.indreset=true
                hButton.auxreset=true
                hButton.reset=true
            end
            
            if not hButton.regClicks then
                HealBot_Action_setRegisterForClicks(hButton)
                HealBot_Action_setRegisterForClicks(erButton)
            end
            
            hButton.status.role=role
            if hButton.unit~=unit or hButton.reset or hButton.guid~=guid or hButton.status.unittype~=unitType then 
                if unitType>10 then 
                    HealBot_Enemy_Button[unit]=hButton
                    if vEnemyUnitsWithEvents[unit] then
                        hButton.status.unittype = 12
                    else
                        hButton.status.unittype = 11
                    end
                else
                    hButton.status.unittype = unitType            -- 1=Tanks  2=Healers  3=Self  4=Private  5=Raid  6=Group
                    if unitType==8 then                           -- 7=vehicle  8=pet  9=target  10=focus  11=enemy without events  12=enemy with events 
                        HealBot_Pet_Button[unit]=hButton
                    elseif unitType==7 then
                        HealBot_Vehicle_Button[unit]=hButton
                    elseif unitType<5 then
                        HealBot_Private_Button[unit]=hButton
                        hbShouldHealSomePrivateFrames[frame]=true
                    elseif unitType>8 then
                        HealBot_Extra_Button[unit]=hButton
                    else
                        HealBot_Unit_Button[unit]=hButton 
                        hbShouldHealSomePlayerFrames[frame]=true
                    end
                end
                if hButton.unit~=unit or hButton.guid~=guid or hButton.reset then 
                    hButton.reset=false
                    hButton.unit=unit
                    erButton.unit=unit
                    hButton.status.change=true
                    if hButton.guid~=guid then 
                        HealBot_UpdateUnitGUIDChange(hButton)
                    end
                    HealBot_Action_ResetrCallsUnit(hButton)
                    HealBot_Aura_setUnitIcons(unit)
                    hButton.status.range=1
                    if hButton.frame<10 then
                        hButton:SetScript("OnEvent", function(self, event, arg1, arg2, arg3) hbEventFuncs[event](self, arg1, arg2, arg3) end)
                    elseif hbEnemyEventFuncs[event] then
                        hButton:SetScript("OnEvent", function(self, event, arg1, arg2, arg3) hbEnemyEventFuncs[event](self, arg1, arg2, arg3) end)
                    end
                end
                hButton:SetAttribute("unit", unit);
                erButton:SetAttribute("unit", unit);
                HealBot_Action_SetAllButtonAttribs(hButton,"Enemy") 
                HealBot_Action_SetAllButtonAttribs(hButton,"Enabled")
                HealBot_Action_SetAllButtonAttribs(erButton,"Emerg")
                if not hButton.status.events then HealBot_Action_RegisterUnitEvents(hButton) end
                HealBot_HealthAlertLevel(preCombat, hButton)
                if not UnitExists(unit) then
                    HealBot_UpdateUnitNotExists(hButton, true)
                end
                hButton.status.update=true
            end
            HealBot_Action_SetHealButtonAuraCols(hButton)
            hButton.group=HealBot_RetUnitGroups(unit)
            hButton.rank=HealBot_RetUnitRank(unit)
            hButton.role=HealBot_RetUnitPlayerRole(unit)
            if hButton.player then
                HealBot_Data["PLAYERGROUP"]=hButton.group
            end
            if hButton.skinreset or hButton.icon.reset or hButton.indreset or hButton.auxreset or hButton.text.reset then
                HealBot_Skins_ResetSkin("bar",hButton)
            elseif frame==10 then
                HealBot_Skins_ResetSkinWidth(hButton)
            end
            hButton.status.duplicate=duplicate
        end
    end
    --HealBot_setCall("HealBot_Action_SetHealButton")
    return hButton
end

local tButton=false
local testBarsDat={["cnt"]=0, ["targetCnt"]=0, ["buffId"]=0,["debuffId"]=50}
local testBarsManaClass={["DRUI"]=true,["MAGE"]=true,["PALA"]=true,["PRIE"]=true,["SHAM"]=true,["WARL"]=true}
function HealBot_Action_SetTestButton(frame, unitText, unitRole, unitClass)
    tButton=HealBot_Test_Button[unitText] or HealBot_Action_CreateButton(frame)
    if tButton then
        tButton.test=true
        tButton.gref["Back"]:ClearAllPoints()
        if tButton.regClicks then
            HealBot_Action_setRegisterForClicks(tButton)
        end
        if tButton.frame~=frame then
            tButton:ClearAllPoints()
            tButton:SetParent(grpFrame[frame])
            tButton.frame=frame
        end
        tButton.unit=unitText
        tButton.guid="TestBar"
        HealBot_Action_ResetrCallsUnit(tButton)
        HealBot_Test_Button[unitText]=tButton
        tButton.status.unittype=5
        if tButton.skin~=Healbot_Config_Skins.Current_Skin then
            tButton.skin=Healbot_Config_Skins.Current_Skin
        end
        if testBarsManaClass[unitClass] then
            tButton.mana.type=0
        else
            tButton.mana.type=1
        end
        HealBot_Skins_showPowerCounter(HealBot_Action_luVars["showTestPowerIndicator"])
        HealBot_Action_luVars["showTestPowerIndicator"]=0
        tButton.icon.reset=true
        tButton.text.reset=true
        tButton.skinreset=true
        tButton.indreset=true
        tButton.auxreset=true
        HealBot_Skins_ResetSkin("bar",tButton)
        for j=1,3 do
            tButton.gref.icon[j]:SetAlpha(0)
        end
        for j=51,53 do
            tButton.gref.icon[j]:SetAlpha(0)
        end
        tButton.gref.icon[91]:SetAlpha(0)
        tButton.gref.icon[92]:SetAlpha(0)
        testBarsDat["cnt"]=testBarsDat["cnt"]+1
        testBarsDat["buffId"]=0
        testBarsDat["debuffId"]=50
        if not testBarsDat["buffTexture"] then _, _, testBarsDat["buffTexture"] = GetSpellInfo(HEALBOT_RENEW) end
        if not testBarsDat["debuffTexture"] then _, _, testBarsDat["debuffTexture"] = GetSpellInfo(HEALBOT_SHADOW_WORD_PAIN) end
        if (testBarsDat["cnt"] % 2 == 0) and HealBot_Config_Buffs.BuffWatch and 
           Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][frame]["MAXBICONS"]>0 then
            testBarsDat["buffId"]=testBarsDat["buffId"]+1
            tButton.gref.icon[testBarsDat["buffId"]]:SetTexture(testBarsDat["buffTexture"])
            tButton.gref.icon[testBarsDat["buffId"]]:SetAlpha(1)
            tButton.icon.buff.count=1
            tButton.icon.buff.id=1
            tButton.icon.buff.name="Test"
            if Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][tButton.frame]["BUFFSDUR"] then
                tButton.gref.txt.expire[testBarsDat["buffId"]]:SetText("9")
                tButton.gref.txt.expire[testBarsDat["buffId"]]:SetTextColor(1,1,1,1)
            else
                tButton.gref.txt.expire[testBarsDat["buffId"]]:SetText(" ")
            end
            if Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][tButton.frame]["BUFFSCNT"] then
                tButton.gref.txt.count[testBarsDat["buffId"]]:SetText("2")
                tButton.gref.txt.count[testBarsDat["buffId"]]:SetTextColor(1,1,1,1)
            else
                tButton.gref.txt.count[testBarsDat["buffId"]]:SetText(" ")
            end
        else
            tButton.gref.icon[1]:SetAlpha(0)
            tButton.gref.txt.expire[1]:SetText(" ")
            tButton.gref.txt.count[1]:SetText(" ")
            tButton.icon.buff.count=0
            tButton.icon.buff.id=0
            tButton.icon.buff.name=false
        end
        if (testBarsDat["cnt"] % 3 == 0) and HealBot_Config_Cures.DebuffWatch and 
           Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][frame]["MAXDICONS"]>0 then
            testBarsDat["debuffId"]=testBarsDat["debuffId"]+1
            tButton.gref.icon[testBarsDat["debuffId"]]:SetTexture(testBarsDat["debuffTexture"])
            tButton.gref.icon[testBarsDat["debuffId"]]:SetAlpha(1)
            tButton.icon.debuff.count=1
            tButton.icon.debuff.id=1
            tButton.icon.debuff.name="Test"
            if Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][tButton.frame]["SDUR"] then
                tButton.gref.txt.expire[testBarsDat["debuffId"]]:SetText("9")
                tButton.gref.txt.expire[testBarsDat["debuffId"]]:SetTextColor(1,1,1,1)
            else
                tButton.gref.txt.expire[testBarsDat["debuffId"]]:SetText(" ")
            end
            if Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][tButton.frame]["SCNT"] then
                tButton.gref.txt.count[testBarsDat["debuffId"]]:SetText("2")
                tButton.gref.txt.count[testBarsDat["debuffId"]]:SetTextColor(1,1,1,1)
            else
                tButton.gref.txt.count[testBarsDat["debuffId"]]:SetText(" ")
            end
        else
            tButton.gref.icon[51]:SetAlpha(0)
            tButton.gref.txt.expire[51]:SetText(" ")
            tButton.gref.txt.count[51]:SetText(" ")
            tButton.icon.debuff.count=0
            tButton.icon.debuff.id=0
            tButton.icon.debuff.name=false
        end
        if (testBarsDat["cnt"] % 4 == 0) and Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][frame]["SHOW"] then
            testBarsDat["targetCnt"]=testBarsDat["targetCnt"]+1
            if testBarsDat["targetCnt"]>8 then testBarsDat["targetCnt"]=1 end
            tButton.gref.icon[92]:SetTexture(HealBot_Aura_retRaidtargetIcon(testBarsDat["targetCnt"]))
            tButton.gref.icon[92]:SetAlpha(1)
        else
            tButton.gref.icon[92]:SetAlpha(0)
        end
        if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][frame]["SHOWCLASS"] then
            if not unitRole then unitRole="DAMAGER" end
            local classTexture=HealBot_Panel_retClassRoleIcon(unitClass)
            if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][frame]["SHOWROLE"] then
                classTexture=HealBot_Panel_retClassRoleIcon(unitRole)
            end
            tButton.gref.icon[91]:SetTexture(classTexture)
            tButton.gref.icon[91]:SetAlpha(1)
        else
            tButton.gref.icon[91]:SetAlpha(0)
        end
        tButton.status.hostile=false
        tButton.status.incombat=false
        tButton.icon.extra.readycheck=false
        if frame<6 then
            if (testBarsDat["cnt"] % 5 == 0) and Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][frame]["SHOWHOSTILE"] then
                tButton.status.hostile=true
            elseif (testBarsDat["cnt"] % 2 == 0) and Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][frame]["SHOWCOMBAT"] then
                tButton.status.incombat=true
            elseif Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][frame]["SHOWRC"] then
                tButton.icon.extra.readycheck=READY_CHECK_WAITING_TEXTURE
            end
        elseif frame<8 then
            if (testBarsDat["cnt"] % 5 == 0) and Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][frame]["SHOWHOSTILE"] then
                tButton.status.hostile=true
            end
        elseif Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][frame]["SHOWHOSTILE"] then
            tButton.status.hostile=true
        end
        HealBot_Aura_UpdateState(tButton)
    end
    return tButton
end

function HealBot_Action_resetTestBarsCounters()
    testBarsDat["cnt"]=0
    testBarsDat["targetCnt"]=0
end

function HealBot_Action_SetEnabledAttribs()
    HealBot_Action_ClearSpellCache("ENABLED")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Action_SetAllButtonAttribs(xButton,"Enabled")
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Action_SetAllButtonAttribs(xButton,"Enabled")
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Action_SetAllButtonAttribs(xButton,"Enabled")
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Action_SetAllButtonAttribs(xButton,"Enabled")
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Action_SetAllButtonAttribs(xButton,"Enabled")
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Action_SetAllButtonAttribs(xButton,"Enabled")
    end
end

function HealBot_Action_SetEnemyAttribs()
    HealBot_Action_ClearSpellCache("ENEMY")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Action_SetAllButtonAttribs(xButton,"Enemy")
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Action_SetAllButtonAttribs(xButton,"Enemy")
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Action_SetAllButtonAttribs(xButton,"Enemy")
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Action_SetAllButtonAttribs(xButton,"Enemy")
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Action_SetAllButtonAttribs(xButton,"Enemy")
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Action_SetAllButtonAttribs(xButton,"Enemy")
    end
end

function HealBot_Action_SetEmergAttribs()
    HealBot_Action_ClearSpellCache("EMERG")
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Action_SetAllButtonAttribs(HealBot_Emerg_Button[xButton.id],"Emerg")
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Action_SetAllButtonAttribs(HealBot_Emerg_Button[xButton.id],"Emerg")
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Action_SetAllButtonAttribs(HealBot_Emerg_Button[xButton.id],"Emerg")
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Action_SetAllButtonAttribs(HealBot_Emerg_Button[xButton.id],"Emerg")
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Action_SetAllButtonAttribs(HealBot_Emerg_Button[xButton.id],"Emerg")
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Action_SetAllButtonAttribs(HealBot_Emerg_Button[xButton.id],"Emerg")
    end
end

function HealBot_Action_SethbFocusButtonAttrib(button)
    button:SetAttribute("unit", "target")
    button:SetAttribute("helpbutton1", "focus1");
    button:SetAttribute("type1", "focus")
    button:SetAttribute("type-focus1", "focus")
end

function HealBot_Action_ResethbInitButtons()
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
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Action_MarkDeleteButton(xButton)
    end 
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Action_MarkDeleteButton(xButton)
    end
end

function HealBot_Action_DeleterCallsUnit(unit)
    HealBot_Action_rCalls[unit]=nil
end

function HealBot_Action_DeleteButton(hbBarID)
    local dg=_G["HealBot_Action_HealUnit"..hbBarID]
    if dg.frame>0 then HealBot_UpdateUnitClear(dg) end
    HealBot_Action_PrepButton(dg)
    HealBot_ActiveButtons[hbBarID]=false
    if hbBarID>HealBot_Globals.AutoCacheSize then
        HealBot_ActiveButtons[0]=1
    elseif hbBarID<HealBot_ActiveButtons[0] then 
        HealBot_ActiveButtons[0]=hbBarID
    end
    --HealBot_AddDebug("Deleted button "..hbBarID)
      --HealBot_setCall("HealBot_Action_DeleteButton")
end

HealBot_Action_luVars["PreCacheBars"]=1
local hbMarkedDeleteButtons={}
local cButtonId=0
function HealBot_Action_CacheButton()
    if HealBot_Action_luVars["PreCacheBars"]<HealBot_Globals.AutoCacheSize then
        HealBot_Action_luVars["PreCacheBars"]=HealBot_Action_luVars["PreCacheBars"]+1
        cButtonId=HealBot_Action_FreeId()
        if cButtonId>0 then
            local ghb=_G["HealBot_Action_HealUnit"..cButtonId]
            if not ghb then 
                HealBot_ActiveButtons[cButtonId]=true
                ghb=HealBot_Action_CreateNewButton(1, cButtonId)
                HealBot_Action_PrepButton(ghb)
                HealBot_Action_MarkDeleteButton(ghb)
            end
        end
        return true
    else
        return false
    end
end

function HealBot_Action_InitCacheButtons()
    for x=1,5 do
        HealBot_Action_CacheButton()
        HealBot_Action_DeleteMarkedButton()
    end
end

function HealBot_Action_DeleteMarkedButton()
    if hbMarkedDeleteButtons[1] then
        HealBot_Action_DeleteButton(hbMarkedDeleteButtons[1])
        table.remove(hbMarkedDeleteButtons,1)
        return true
    else
        return false
    end
end

function HealBot_Action_DoProcCacheButtons()
    if not InCombatLockdown() then
        HealBot_Action_luVars["DeleteMarkedButtonsActive"]=true
        if HealBot_Action_DeleteMarkedButton() or HealBot_Action_CacheButton() then
            C_Timer.After(0.05, HealBot_Action_DoProcCacheButtons)
        else
            HealBot_Action_luVars["DeleteMarkedButtonsActive"]=false
        end
    else
        HealBot_Timers_Set("LAST","ProcCacheButtons",5)
    end
end

function HealBot_Action_ProcCacheButtons()
    if not HealBot_Action_luVars["DeleteMarkedButtonsActive"] then
        HealBot_Action_DoProcCacheButtons()
    end
end

function HealBot_Action_MarkDeleteButton(button)
    HealBot_QueueClearGUID(button.guid)
    HealBot_Action_UnregisterUnitEvents(button)
    if button.frame>0 then HealBot_Action_DisableBorderHazardTypeButton(button) end
    button.status.markdel=true
    if HealBot_Enemy_Button[button.unit] and HealBot_Enemy_Button[button.unit].id==button.id then 
        HealBot_Enemy_Button[button.unit]=nil 
    end
    if HealBot_Pet_Button[button.unit] and HealBot_Pet_Button[button.unit].id==button.id then 
        HealBot_Pet_Button[button.unit]=nil 
    end
    if HealBot_Vehicle_Button[button.unit] and HealBot_Vehicle_Button[button.unit].id==button.id then 
        HealBot_Vehicle_Button[button.unit]=nil 
    end
    if HealBot_Private_Button[button.unit] and HealBot_Private_Button[button.unit].id==button.id then 
        HealBot_Private_Button[button.unit]=nil 
    end
    if HealBot_Extra_Button[button.unit] and HealBot_Extra_Button[button.unit].id==button.id then 
        HealBot_Extra_Button[button.unit]=nil 
    end
    if HealBot_Unit_Button[button.unit] and HealBot_Unit_Button[button.unit].id==button.id then 
        HealBot_Unit_Button[button.unit]=nil 
    end
    if HealBot_Test_Button[button.unit] and HealBot_Test_Button[button.unit].id==button.id then 
        HealBot_Test_Button[button.unit]=nil
    end
    button:Hide()
    HealBot_Emerg_Button[button.id]:Hide()
    for x=1,12 do
        button.gref.iconf[x]:SetFrameLevel(0)
    end
    for x=51,58 do
        button.gref.iconf[x]:SetFrameLevel(0)
    end
    if button.hotbars.state then HealBot_Action_BarHotRemove(button) end
    if HealBot_Fluid_BarButtons[button.id] then HealBot_Fluid_BarButtons[button.id]=nil end
    if HealBot_Fluid_BarButtonsAlpha[button.id] then HealBot_Fluid_BarButtonsAlpha[button.id]=nil end
    if HealBot_Fluid_InHealButtons[button.id] then HealBot_Fluid_InHealButtons[button.id]=nil end
    if HealBot_Fluid_AbsorbButtons[button.id] then HealBot_Fluid_AbsorbButtons[button.id]=nil end
    if HealBot_Hazard_Buttons[button.id] then HealBot_Hazard_Buttons[button.id]=nil end
    button.status.enabled=false
    table.insert(hbMarkedDeleteButtons, button.id)
    HealBot_Timers_Set("LAST","ProcCacheButtons",5)
end

function HealBot_Action_Reset()
    HealBot_Update_Skins()
    HealBot_Timers_TurboOn(1)
    if HealBot_Config.DisabledNow==1 then
        HealBot_Options_DisableHealBotOpt:SetChecked(false)
        HealBot_Options_DisableHealBot(false)
        HealBot_Timers_Set("RESET","Frames",0.2)
    else
        for i=1, 10 do
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][i]["X"]=(49+(i*2))
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][i]["Y"]=(49+(i*2))
            Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][i]["AUTOCLOSE"]=1
            HealBot_AutoCloseFrame[i]=1
            if HealBot_Action_FrameIsVisible(i) then
                HealBot_Action_ShowPanel(i)
                HealBot_Action_setPoint(i)
            end
            HealBot_Action_unlockFrame(i)
        end
        HealBot_Options_SetSkins(true)
        HealBot_Timers_InitExtraOptions()
    end
end

function HealBot_Action_unlockFrame(hbCurFrame)
    Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][hbCurFrame]["LOCKED"]=1
end

local hbFrameSetPoint={[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
local hbFrameGetCoords={[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
function HealBot_Action_DelayCheckFrameSetPoint(hbCurFrame, setPoint)
    if setPoint then
        hbFrameSetPoint[hbCurFrame]=true
    else
        hbFrameGetCoords[hbCurFrame]=true
    end
    HealBot_Timers_Set("INIT","CheckFrameSetPoint",1)
end

function HealBot_Action_CheckFrameSetPoint()
    for x=1,10 do
        if hbFrameSetPoint[x] then
            hbFrameSetPoint[x]=false
            hbFrameGetCoords[x]=false
            HealBot_Action_setPoint(x)
        elseif hbFrameGetCoords[x] then
            hbFrameGetCoords[x]=false
            HealBot_Action_CheckFrame(x, grpFrame[x])
        end
    end
end

local hbStickyFrameGetCoords={[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
function HealBot_Action_CheckStuckFrames(hbCurFrame)
    for x=hbCurFrame,10 do
        if hbStickyFrameGetCoords[x] then
            HealBot_Action_CheckFrame(x, grpFrame[x])
        end
    end
end


function HealBot_Action_CheckFrame(hbCurFrame, HBframe)
    if HealBot_Action_luVars["ScreenHeight"]==GetScreenHeight() and HealBot_Action_luVars["ScreenWidth"]==GetScreenWidth() then
        if HBframe:GetTop() then
            if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==1 then
                local fTop=HealBot_Comm_round(((HBframe:GetTop()/GetScreenHeight())*100),2)
                local fLeft=HealBot_Comm_round(((HBframe:GetLeft()/GetScreenWidth())*100),2)
                Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"] = fTop
                Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"] = fLeft
            elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==2 then
                local fBottom=HealBot_Comm_round(((HBframe:GetBottom()/GetScreenHeight())*100),2)
                local fLeft=HealBot_Comm_round(((HBframe:GetLeft()/GetScreenWidth())*100),2)
                Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"] = fBottom
                Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"] = fLeft
            elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==3 then
                local fTop=HealBot_Comm_round(((HBframe:GetTop()/GetScreenHeight())*100),2)
                local fRight=HealBot_Comm_round(((HBframe:GetRight()/GetScreenWidth())*100),2)
                Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"] = fTop
                Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"] = fRight
            elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==4 then
                local fBottom=HealBot_Comm_round(((HBframe:GetBottom()/GetScreenHeight())*100),2)
                local fRight=HealBot_Comm_round(((HBframe:GetRight()/GetScreenWidth())*100),2)
                Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"] = fBottom
                Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"] = fRight
            elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==5 then
                local fTop=HealBot_Comm_round(((HBframe:GetTop()/GetScreenHeight())*100),2)
                local fHcenter=HealBot_Comm_round(((HBframe:GetCenter()/GetScreenWidth())*100),2)
                Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"] = fTop
                Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"] = fHcenter
            elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==6 then
                local fVcenter=HealBot_Comm_round(((((HBframe:GetTop()+HBframe:GetBottom())/2)/GetScreenHeight())*100),2)
                local fLeft=HealBot_Comm_round(((HBframe:GetLeft()/GetScreenWidth())*100),2)
                Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"] = fVcenter
                Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"] = fLeft
            elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==7 then
                local fVcenter=HealBot_Comm_round(((((HBframe:GetTop()+HBframe:GetBottom())/2)/GetScreenHeight())*100),2)
                local fRight=HealBot_Comm_round(((HBframe:GetRight()/GetScreenWidth())*100),2)
                Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"] = fVcenter
                Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"] = fRight
            elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==8 then
                local fBottom=HealBot_Comm_round(((HBframe:GetBottom()/GetScreenHeight())*100),2)
                local fHcenter=HealBot_Comm_round(((HBframe:GetCenter()/GetScreenWidth())*100),2)
                Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"] = fBottom
                Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"] = fHcenter
            end
            HealBot_CheckFrame(hbCurFrame, HBframe) 
        elseif HealBot_Action_FrameIsVisible(hbCurFrame) then
            HealBot_Action_DelayCheckFrameSetPoint(hbCurFrame, false)
        end
    else
        HealBot_Action_luVars["ScreenHeight"]=GetScreenHeight()
        HealBot_Action_luVars["ScreenWidth"]=GetScreenWidth()
    end
    --HealBot_setCall("HealBot_CheckActionFrame")
end

local vFrameSetPointX,vFrameSetPointY=0,0
function HealBot_Action_FrameSetPoint(hbCurFrame, gaf, callback)
    if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin] and 
       Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame] and
       Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"] and
       Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"] then 
        gaf:ClearAllPoints();
        vFrameSetPointY=GetScreenHeight()*(Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]/100)
        vFrameSetPointX=GetScreenWidth()*(Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]/100)
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==1 then
            gaf:SetPoint("TOPLEFT","UIParent","BOTTOMLEFT",vFrameSetPointX,vFrameSetPointY);
        elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==2 then
            gaf:SetPoint("BOTTOMLEFT","UIParent","BOTTOMLEFT",vFrameSetPointX,vFrameSetPointY);
        elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==3 then
            gaf:SetPoint("TOPRIGHT","UIParent","BOTTOMLEFT",vFrameSetPointX,vFrameSetPointY);
        elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==4 then
            gaf:SetPoint("BOTTOMRIGHT","UIParent","BOTTOMLEFT",vFrameSetPointX,vFrameSetPointY);
        elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==5 then
            gaf:SetPoint("TOP","UIParent","BOTTOMLEFT",vFrameSetPointX,vFrameSetPointY);
        elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==6 then
            gaf:SetPoint("LEFT","UIParent","BOTTOMLEFT",vFrameSetPointX,vFrameSetPointY);
        elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==7 then
            gaf:SetPoint("RIGHT","UIParent","BOTTOMLEFT",vFrameSetPointX,vFrameSetPointY);
        elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==8 then
            gaf:SetPoint("BOTTOM","UIParent","BOTTOMLEFT",vFrameSetPointX,vFrameSetPointY);
        end
    elseif not callback and Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin] and 
           Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame] then
        HealBot_Action_CheckFrame(hbCurFrame, gaf)
        HealBot_Action_FrameSetPoint(hbCurFrame, gaf, true)
    end
end

function HealBot_Action_setPoint(hbCurFrame)
    if not hbCurFrame then return end
    if not InCombatLockdown() then
        HealBot_Action_CheckFrame(hbCurFrame, grpFrame[hbCurFrame])
        if not HealBot_Action_StickyFrame(hbCurFrame) then
            HealBot_Action_FrameSetPoint(hbCurFrame, grpFrame[hbCurFrame])
        end
        if hbCurFrame<10 then
            HealBot_Action_CheckStuckFrames(hbCurFrame)
        end
    else
        HealBot_Action_DelayCheckFrameSetPoint(hbCurFrame, true)
    end
end

local hbClassCols = {
          ["DEMO"] = {r=0.8,  g=0.1,  b=0.8, },
          ["DRUI"] = {r=1.0,  g=0.49, b=0.04, },
          ["HUNT"] = {r=0.67, g=0.83, b=0.45, },
          ["MAGE"] = {r=0.41, g=0.8,  b=0.94, },
          ["MONK"] = {r=0.0,  g=1.0,  b=0.59, },
          ["PALA"] = {r=0.96, g=0.55, b=0.73, },
          ["PRIE"] = {r=1.0,  g=1.0,  b=1.0,  },
          ["ROGU"] = {r=1.0,  g=0.96, b=0.41, },
          ["SHAM"] = {r=0.14, g=0.35, b=1.0,  },
          ["WARL"] = {r=0.58, g=0.51, b=0.79, },
          ["DEAT"] = {r=0.78, g=0.04, b=0.04, },
          ["WARR"] = {r=0.78, g=0.61, b=0.43, },
          ["EVOK"] = {r=0.22, g=0.59, b=0.49, },
      }

function HealBot_Action_ClassColour(unit, cTrim)
    if cTrim and cTrim~="XXXX" then
        return hbClassCols[cTrim].r, hbClassCols[cTrim].g, hbClassCols[cTrim].b
    else
        local xClass=nil
        if unit and UnitClass(unit) then
            _,xClass=UnitClass(unit)    
        end
        if xClass then
            xClass = strsub(xClass,1,4)
        else
            xClass = "WARR"
        end
        return hbClassCols[xClass].r, hbClassCols[xClass].g, hbClassCols[xClass].b
    end
end

function HealBot_Action_HideTooltip(self)
    if HealBot_Data["TIPBUTTON"] then
        HealBot_Data["TIPBUTTON"] = false;
        HealBot_Data["TIPTYPE"] = "NONE";
        HealBot_Action_HideTooltipFrame()
    end
end

function HealBot_Action_HideTooltipFrame()
    if HealBot_Data["TIPUSE"] then
        HealBot_Tooltip_Hide()
        HealBot_Data["TIPICON"]=false
    end
end

local hideFrame={[1]=true,[2]=true,[3]=true,[4]=true,[5]=true,[6]=true,[7]=true,[8]=true,[9]=true,[10]=true}
function HealBot_Action_CheckHideFrames()
    for j=1,10 do
        hideFrame[j]=true
    end
    for _,xButton in pairs(HealBot_Unit_Button) do
        if xButton.status.enabled then
            hideFrame[xButton.frame]=false
        end
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        if xButton.status.enabled then
            hideFrame[xButton.frame]=false
        end
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        if xButton.status.enabled then
            hideFrame[xButton.frame]=false
        end
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        if xButton.status.enabled then
            hideFrame[xButton.frame]=false
            break
        end
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        if xButton.status.enabled then
            hideFrame[xButton.frame]=false
            break
        end
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        if xButton.status.enabled then
            hideFrame[xButton.frame]=false
            break
        end
    end
    for i=1, 10 do
        if HealBot_AutoCloseFrame[i]>1 and hideFrame[i] and HealBot_Action_FrameIsVisible(i) then
            HealBot_Action_HidePanel(i)
        end
    end
end

local showFrame={[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
function HealBot_Action_CheckHideUnusedFrames()
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
    for _,xButton in pairs(HealBot_Pet_Button) do
        showFrame[xButton.frame]=true
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        showFrame[xButton.frame]=true
    end
    for i=1, 10 do
        if not showFrame[i] and HealBot_Action_FrameIsVisible(i) then
            HealBot_Action_HidePanel(i)
        end
    end
end

local initFrame={[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
function HealBot_Action_ShowFramesOnSkinChange()
    for j=1,10 do
        initFrame[j]=false
    end
    for j=1,11 do
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][j]["STATE"] then
            initFrame[Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][j]["FRAME"]]=true
        end
    end
    for j=1,10 do
        if initFrame[j] and not HealBot_Action_FrameIsVisible(j) then
            HealBot_Action_ShowPanel(j)
            HealBot_Action_setPoint(j)
        end
    end
    HealBot_Timers_Set("LAST","CheckHideUnusedFrames")
end

function HealBot_Action_ShowHideFrames(button)
    if not InCombatLockdown() and HealBot_AutoCloseFrame[button.frame]>1 then 
        if not HealBot_Action_FrameIsVisible(button.frame) then 
            if button.status.enabled and HealBot_Config.DisabledNow==0  then
                HealBot_Action_ShowPanel(button.frame)
                HealBot_Action_setPoint(button.frame)
            end
        elseif not HealBot_Action_ShouldHealSome(button.frame) then
            HealBot_Action_HidePanel(button.frame)
        end
    end
end

function HealBot_Action_ShowHideFrameOption(frame)
    if not HealBot_Data["UILOCK"] then
        if frame>5 then
            if frame<8 then
                HealBot_Timers_Set("INIT","RefreshPartyNextRecalcPets")
            elseif frame==8 then
                HealBot_nextRecalcParty(3) 
            elseif frame==9 then 
                HealBot_nextRecalcParty(4)
            elseif frame==10 then 
                HealBot_nextRecalcParty(5)
            end
        else
            HealBot_Timers_Set("INIT","RefreshPartyNextRecalcPlayers")
        end
    end
end

function HealBot_Action_setAutoClose(reset)
    local cVal=1
    for x=1,10 do
        if not reset then cVal=Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][x]["AUTOCLOSE"] end
        if cVal~=HealBot_AutoCloseFrame[x] then
            HealBot_AutoCloseFrame[x]=cVal
            HealBot_Panel_setAutoClose(x)
            HealBot_Action_ShowHideFrameOption(x)
            HealBot_Timers_Set("LAST","CheckFramesOnCombat")
            HealBot_Timers_Set("LAST","CheckHideFrames")
            HealBot_AddDebug("Auto Hide for frame "..x.." = "..HealBot_AutoCloseFrame[x],"AutoClose",true)
        end
    end
end

function HealBot_Action_ResetGlobalDimming()
    if Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["GLOBALDIMMING"]>1 then
        HealBot_Action_luVars["GlobalDimming"]=Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["GLOBALDIMMING"]
        HealBot_Action_luVars["GlobalDimmingEnabled"]=true
    else
        HealBot_Action_luVars["GlobalDimming"]=0
        HealBot_Action_luVars["GlobalDimmingEnabled"]=false
    end
    HealBot_Action_ResetOpacity()
end

function HealBot_Action_UpdateFramesOpacity()
    for x=1,10 do
        if grpFrame[x]:IsVisible() then
            HealBot_Action_SetFrameColours(grpFrame[x])
            if Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][x]["SHOW"] then
                HealBot_Action_UpdateFrameHeaderOpacity(x)
                HealBot_Action_SetFrameTextColours(x)
            end
        end
    end
end

function HealBot_Action_UpdateFrameHeaderOpacity(f)
    if HealBot_Action_luVars["GlobalDimmingEnabled"] then
        grpFrameBar[f]:SetStatusBarColor(Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][f]["R"],
                              Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][f]["G"],
                              Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][f]["B"],
                              (Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][f]["A"]/HealBot_Action_luVars["GlobalDimming"]));
    else
        grpFrameBar[f]:SetStatusBarColor(Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][f]["R"],
                              Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][f]["G"],
                              Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][f]["B"],
                              Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][f]["A"]);
    end
end

function HealBot_Action_UpdateHeaderOpacity(header)
    if header.frame>0 then
        if HealBot_Action_luVars["GlobalDimmingEnabled"] then
            header.bar:SetStatusBarColor(Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][header.frame]["R"],
                                      Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][header.frame]["G"],
                                      Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][header.frame]["B"],
                                     (Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][header.frame]["A"]/HealBot_Action_luVars["GlobalDimming"]))
            header.bar.txt:SetTextColor(Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][header.frame]["R"],
                                        Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][header.frame]["G"],
                                        Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][header.frame]["B"],
                                       (Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][header.frame]["A"]/HealBot_Action_luVars["GlobalDimming"]))
        else
            header.bar:SetStatusBarColor(Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][header.frame]["R"],
                                      Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][header.frame]["G"],
                                      Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][header.frame]["B"],
                                      Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][header.frame]["A"])
            header.bar.txt:SetTextColor(Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][header.frame]["R"],
                                        Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][header.frame]["G"],
                                        Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][header.frame]["B"],
                                        Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][header.frame]["A"])
        end
    end
end

function HealBot_Action_EnableGlobalDimming()
    if not HealBot_Action_luVars["GlobalDimmingEnabled"] and GetTime()>HealBot_Action_luVars["EnableDimmingAfter"] then
        HealBot_Action_luVars["GlobalDimmingEnabled"]=true
        HealBot_Action_luVars["GlobalDimming"]=Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["GLOBALDIMMING"]
        HealBot_Action_ResetOpacity()
    end
end

function HealBot_Action_DisableGlobalDimming()
    if HealBot_Action_luVars["GlobalDimmingEnabled"] then
        HealBot_Action_luVars["GlobalDimmingEnabled"]=false
        HealBot_Action_luVars["GlobalDimming"]=0
        HealBot_Action_ResetOpacity()
    end
end

local function HealBot_Action_AuxSetHighlightBar(button)
    HealBot_Aux_UpdateHighlightBar(button) 
    if HealBot_Action_AuxAssigns["NameOverlayHighlight"][button.frame] then
        HealBot_Aux_UpdateNameOverLay(button, 5, true)
    end
    if HealBot_Action_AuxAssigns["HealthOverlayHighlight"][button.frame] then
        HealBot_Aux_UpdateHealthOverLay(button, 5, true)
    end
end

local function HealBot_Action_AuxClearHighlightBar(button)
    HealBot_Aux_ClearHighlightBar(button) 
    if HealBot_Action_AuxAssigns["NameOverlayHighlight"][button.frame] then
        HealBot_Aux_UpdateNameOverLay(button, 5, false)
    end
    if HealBot_Action_AuxAssigns["HealthOverlayHighlight"][button.frame] then
        HealBot_Aux_UpdateHealthOverLay(button, 5, false)
    end
end

function HealBot_Action_HealUnit_OnEnter(self)
    if not self.unit then return; end
    self.mouseover=true
    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][self.frame]["SHOWDIR"] and Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][self.frame]["SHOWDIRMOUSE"] then 
        HealBot_Action_ShowDirectionArrow(self, GetTime()) 
    end
    HealBot_Action_SetActiveButton(self.id)
    if HealBot_Globals.ShowTooltip and HealBot_Data["TIPUSE"] and UnitExists(self.unit) then
        HealBot_Data["TIPBUTTON"] = self
        if HealBot_Globals.ShowGameUnitInfo then
            HealBot_Data["TIPTYPE"] = "WoWUnit"
        elseif not UnitIsFriend("player",self.unit) then
            HealBot_Data["TIPTYPE"] = "Enemy"
        else
            HealBot_Data["TIPTYPE"] = "Enabled"
        end
        HealBot_Action_RefreshTooltip();
    end
    if self and self.aux then
        HealBot_Action_AuxSetHighlightBar(self)
    end
    if Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["GLOBALDIMMING"]>1 and HealBot_Action_luVars["GlobalDimming"]<1000 then
        HealBot_Action_luVars["EnableDimmingAfter"]=GetTime()+1
        C_Timer.After(0.001, HealBot_Action_DisableGlobalDimming)
    end
    --HealBot_setCall("HealBot_Action_HealUnit_OnEnter")
end

function HealBot_Action_HealUnit_OnLeave(self)
    HealBot_Action_HideTooltip(self);
    self.mouseover=false
    HealBot_Action_SetActiveButton(0)
    if self.status and self.status.dirarrowshown>0 and Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][self.frame]["SHOWDIRMOUSE"] then
        HealBot_Action_HideDirectionArrow(self)
    end
    if self and self.aux then 
        HealBot_Action_AuxClearHighlightBar(self)
    end
    if Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["GLOBALDIMMING"]>1 and HealBot_Action_luVars["GlobalDimming"]<1000 then
        HealBot_Action_luVars["EnableDimmingAfter"]=GetTime()+0.35
        C_Timer.After(0.4, HealBot_Action_EnableGlobalDimming)
    end
   -- ClearOverrideBindings(HealBot_Action)
end

function HealBot_Action_EmergUnit_OnEnter(self)
    HealBot_Action_SetActiveButton(self.id)
    if HealBot_Globals.ShowTooltip and HealBot_Data["TIPUSE"] then
        xButton=HealBot_Buttons[self.id]
        if xButton and UnitExists(xButton.unit) then
            HealBot_Data["TIPBUTTON"]=xButton
            if HealBot_Globals.ShowGameUnitInfo then
                HealBot_Data["TIPTYPE"] = "WoWUnit"
            else
                HealBot_Data["TIPTYPE"] = "Emerg"
            end
            HealBot_Action_RefreshTooltip();
        end
    end
    if Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["GLOBALDIMMING"]>1 and HealBot_Action_luVars["GlobalDimming"]<1000 then
        HealBot_Action_luVars["EnableDimmingAfter"]=GetTime()+1
        C_Timer.After(0.001, HealBot_Action_DisableGlobalDimming)
    end
    --HealBot_setCall("HealBot_Action_EmergUnit_OnEnter")
end

function HealBot_Action_EmergUnit_OnLeave(self)
    HealBot_Action_SetActiveButton(0)
    if HealBot_Data["TIPBUTTON"] then HealBot_Action_HideTooltip(HealBot_Data["TIPBUTTON"]) end
    if Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["GLOBALDIMMING"]>1 and HealBot_Action_luVars["GlobalDimming"]<1000 then
        HealBot_Action_luVars["EnableDimmingAfter"]=GetTime()+0.35
        C_Timer.After(0.4, HealBot_Action_EnableGlobalDimming)
    end
end

function HealBot_Action_OptionsButton_OnClick(self)
    HealBot_TogglePanel(HealBot_Options, true);
end

local usedSmartCast=nil
local abutton=nil
local aj=nil
local uLevel=0

function HealBot_Action_UseSmartCast(self,button)
    local sName=HealBot_Action_SmartCast(button);
    if sName then
        if HealBot_Spell_Names[sName] then
            if HEALBOT_GAME_VERSION<4 then
                uLevel=button.level
                if uLevel and uLevel>0 then
                    if HealBot_Data["PCLASSTRIM"]=="PRIE" then
                        if sName==GetSpellInfo(HBC_POWER_WORD_FORTITUDE) then
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
                        elseif sName==GetSpellInfo(HBC_DIVINE_SPIRIT) then
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
                        elseif sName==GetSpellInfo(HBC_SHADOW_PROTECTION) then
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
                    elseif HealBot_Data["PCLASSTRIM"]=="DRUI" then
                        if sName==GetSpellInfo(HEALBOT_MARK_OF_THE_WILD) then
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
                        elseif sName==GetSpellInfo(HBC_THORNS) then
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
                    elseif HealBot_Data["PCLASSTRIM"]=="PALA" then
                        if sName==GetSpellInfo(HBC_BLESSING_OF_LIGHT) and HEALBOT_GAME_VERSION<3 then
                            if uLevel<50 then
                                sName=HealBot_Init_retRank(sName, 1)
                            elseif uLevel<60 then
                                sName=HealBot_Init_retRank(sName, 2)
                            elseif uLevel<69 then
                                sName=HealBot_Init_retRank(sName, 3)
                            else
                                sName=HealBot_Init_retRank(sName, 4)
                            end
                        elseif sName==GetSpellInfo(HBC_BLESSING_OF_MIGHT) then
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
                        elseif sName==GetSpellInfo(HBC_BLESSING_OF_WISDOM) then
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
                        elseif sName==GetSpellInfo(HBC_BLESSING_OF_SANCTUARY) and HEALBOT_GAME_VERSION<3 then
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
                    elseif HealBot_Data["PCLASSTRIM"]=="SHAM" then
                        if sName==GetSpellInfo(HBC_EARTH_SHIELD) then
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
                    elseif HealBot_Data["PCLASSTRIM"]=="MAGE" then
                        if sName==GetSpellInfo(HEALBOT_ARCANE_BRILLIANCE) then
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
            HealBot_AddDebug("Casting spell="..sName,"SmartCast",true)
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
                HealBot_AddDebug("[NON HB] Using macro="..sName,"SmartCast",true)
            else
                self:SetAttribute("helpbutton1", "item1");
                self:SetAttribute("type-item1", "item");
                self:SetAttribute("item-item1", sName);
                HealBot_AddDebug("[NON HB] Casting macro="..sName,"SmartCast",true)
            end
        end
        usedSmartCast=true;
    end
end

function HealBot_Action_PreSmartCast(self,mButton,button)
    if not usedSmartCast and mButton=="LeftButton" and HealBot_Globals.SmartCast and not IsModifierKeyDown() then
        HealBot_Action_UseSmartCast(self,button)
    end
end

function HealBot_Action_ButtonPreClick(self,mButton,button)
    usedSmartCast=false;
    if not InCombatLockdown() and button and self.id<999 and UnitExists(button.unit) and UnitIsFriend("player",button.unit) then
        HealBot_setLuVars("TargetUnitID", button.unit)
        if mButton=="LeftButton" then 
            abutton="Left"
            aj=1
        elseif mButton=="RightButton" then 
            abutton="Right"
            aj=2
        elseif mButton=="MiddleButton" then 
            abutton="Middle"
            aj=3
        else
            abutton=mButton
            aj=tonumber(strmatch(mButton, "(%d+)"))
        end
        if button.unit=="target" and HealBot_Globals.TargetBarRestricted==1 then
            if mButton=="RightButton" then
                HealBot_Panel_ToggelHealTarget(button.unit)
                if HealBot_Data["TIPUSE"] and HealBot_Globals.ShowTooltip then 
                    HealBot_Action_RefreshTargetTooltip(self) 
                end
            else
                HealBot_Action_PreSmartCast(self,mButton,button)
            end
        else
            HealBot_Action_PreSmartCast(self,mButton,button)
        end
    end
end

function HealBot_Action_PreClick(self,button)
    HealBot_Action_ButtonPreClick(self,button,self)
end

function HealBot_EmergAction_PreClick(self,button)
    HealBot_Action_ButtonPreClick(self,button,HealBot_Buttons[self.id])
end

function HealBot_Action_PostClick(self,button)
    if self.id==999 then
        HealBot_Panel_clickToFocus("hide")
        HealBot_nextRecalcParty(3)
    elseif UnitExists(self.unit) and UnitIsFriend("player",self.unit) and usedSmartCast and aj==1 then
        HealBot_Action_SetButtonAttrib(self,abutton,"","Enabled",aj,self.unit)
    end
end

function HealBot_EmergAction_PostClick(self,button)
    xButton=HealBot_Buttons[self.id]
    if self.id==999 then
        HealBot_Panel_clickToFocus("hide")
        HealBot_nextRecalcParty(3)
    elseif xButton and UnitExists(xButton.unit) and UnitIsFriend("player",xButton.unit) and usedSmartCast and aj==1 then
        HealBot_Action_SetButtonAttrib(self,abutton,"","Emerg",aj,xButton.unit)
    end
end

function HealBot_Action_OnLoad(self)
    self:SetScript("PreClick", HealBot_Action_PreClick); 
    self:SetScript("PostClick", HealBot_Action_PostClick)
end

function HealBot_Action_EmergOnLoad(self)
    self:SetScript("PreClick", HealBot_EmergAction_PreClick); 
    self:SetScript("PostClick", HealBot_EmergAction_PostClick)
end


local function HealBot_Action_setButtonRegisterForClicks(button)
    if HealBot_Action_luVars["TestBarsOn"] then
        button:EnableMouse(false)
        button.regClicks=false
    else
        button:EnableMouse(true)
        if HealBot_Config_Spells.ButtonCastMethod==1 then
            button:RegisterForClicks("AnyDown");
        else
            button:RegisterForClicks("AnyUp");
        end
        button.regClicks=true
    end
end

function HealBot_Action_setRegisterForClicks(button)
    if button then
        HealBot_Action_setButtonRegisterForClicks(button)
    else
        for _,xButton in pairs(HealBot_Unit_Button) do
            HealBot_Action_setButtonRegisterForClicks(xButton)
        end
        for _,xButton in pairs(HealBot_Private_Button) do
            HealBot_Action_setButtonRegisterForClicks(xButton)
        end
        for _,xButton in pairs(HealBot_Enemy_Button) do
            HealBot_Action_setButtonRegisterForClicks(xButton)
        end
        for _,xButton in pairs(HealBot_Pet_Button) do
            HealBot_Action_setButtonRegisterForClicks(xButton)
        end
        for _,xButton in pairs(HealBot_Vehicle_Button) do
            HealBot_Action_setButtonRegisterForClicks(xButton)
        end
        for _,xButton in pairs(HealBot_Extra_Button) do
            HealBot_Action_setButtonRegisterForClicks(xButton)
        end
    end   
end

function HealBot_Action_SetFrameColours(frame)
    if HealBot_Action_luVars["GlobalDimmingEnabled"] then
        frame:SetBackdropColor(
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][frame.id]["BACKR"],
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][frame.id]["BACKG"],
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][frame.id]["BACKB"], 
        (Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][frame.id]["BACKA"]/HealBot_Action_luVars["GlobalDimming"]));
        frame:SetBackdropBorderColor(
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][frame.id]["BORDERR"],
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][frame.id]["BORDERG"],
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][frame.id]["BORDERB"],
        (Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][frame.id]["BORDERA"]/HealBot_Action_luVars["GlobalDimming"]));
    else
        frame:SetBackdropColor(
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][frame.id]["BACKR"],
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][frame.id]["BACKG"],
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][frame.id]["BACKB"], 
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][frame.id]["BACKA"]);
        frame:SetBackdropBorderColor(
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][frame.id]["BORDERR"],
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][frame.id]["BORDERG"],
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][frame.id]["BORDERB"],
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][frame.id]["BORDERA"]);
    end
end

function HealBot_Action_SetFrameTextColours(hbCurFrame)
    if HealBot_Action_luVars["GlobalDimmingEnabled"] then
        grpFrameText[hbCurFrame]:SetTextColor(Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame]["R"],
                                              Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame]["G"],
                                              Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame]["B"],
                                             (Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame]["A"]/HealBot_Action_luVars["GlobalDimming"]))
    else
        grpFrameText[hbCurFrame]:SetTextColor(Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame]["R"],
                                              Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame]["G"],
                                              Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame]["B"],
                                              Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame]["A"])
    end
end

function HealBot_Action_SetFrameCols(frameID)
    HealBot_Action_SetFrameColours(grpFrame[frameID])
end

local HealBot_Action_Init={}
function HealBot_Action_OnShow(self)
    if HealBot_Action_luVars["FrameInitDone"] then
        if not HealBot_Action_Init[self.id] then
            HealBot_Action_SetFrameColours(self)
            HealBot_Action_Init[self.id]=true
            HealBot_Action_SetAlias(self.id)
            HealBot_Action_SetAliasFontSize(self.id)
        end
    end
end

function HealBot_Action_SetAlias(hbCurFrame)
    if Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame] and
       Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame]["NAME"] and 
       Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame]["SHOW"] then
        grpFrameText[hbCurFrame]:SetText(Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame]["NAME"])
    else
        grpFrameText[hbCurFrame]:SetText("")
    end
end

function HealBot_Action_SetAliasFontSize(hbCurFrame)
    if Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame] and Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FONT"] then
        grpFrameText[hbCurFrame]:SetFont(LSM:Fetch('font',Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FONT"]),
                                                     ceil(Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame]["SIZE"]*
                                                          Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][hbCurFrame]["SCALE"]),
                                           HealBot_Font_Outline[Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame]["OUTLINE"]]);
        grpFrameText[hbCurFrame]:SetTextHeight(ceil(Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame]["SIZE"]*
                                                    Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][hbCurFrame]["SCALE"]))
        grpFrameText[hbCurFrame]:ClearAllPoints();
        grpFrameText[hbCurFrame]:SetPoint("CENTER",0,Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame]["OFFSET"]);
        HealBot_Action_SetFrameTextColours(hbCurFrame)
    end
end

function  HealBot_Action_ResetFrameAlias()
    for j=1,10 do
        if Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][j] then
            HealBot_Action_SetAlias(j)
            HealBot_Action_SetAliasFontSize(j)
        end
    end
end

local modKey=1 -- Not Locked
function HealBot_Action_OnMouseDown(self,button)
    if button=="LeftButton" then
        modKey=1 -- Not Locked
        if Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][self.id]["LOCKED"]>2 then
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
        if HealBot_Action_luVars["TestBarsOn"] or Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][self.id]["LOCKED"]==modKey then
            HealBot_Action_luVars["FrameMoving"]=true
            HealBot_StartMoving(self, self.id);
        end
    end
end

local hbFrameTags={[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false,}
local function HealBot_Action_ToggleFrameTag(self)
    if not HealBot_Globals.HideUnlockedTag then
        if not HealBot_Data["UILOCK"] then
            if hbFrameTags[self.id] then
                hbFrameTags[self.id]=false
            else
                hbFrameTags[self.id]=true
            end
            HealBot_Timers_nextRecalcAll()
        else
            HealBot_Timers_Set("LAST","ModKey")
        end
    end
end

function HealBot_Action_OnEnter(self)
    modKey=1
    if Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][self.id]["LOCKED"]>2 then
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
    if Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][self.id]["LOCKED"]==modKey then
        if not hbFrameTags[self.id] then
            HealBot_Action_ToggleFrameTag(self)
        end
    elseif hbFrameTags[self.id] then
        HealBot_Action_ToggleFrameTag(self)
    end
    HealBot_Action_luVars["ActiveFrame"]=self
    if Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["GLOBALDIMMING"]>1 and HealBot_Action_luVars["GlobalDimming"]<1000 then
        HealBot_Action_luVars["EnableDimmingAfter"]=GetTime()+1
        C_Timer.After(0.001, HealBot_Action_DisableGlobalDimming)
    end
end

function HealBot_Action_OnLeave(self)
    HealBot_Action_luVars["ActiveFrame"]=false
    if hbFrameTags[self.id] then
        HealBot_Action_ToggleFrameTag(self)
    end
    if Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["GLOBALDIMMING"]>1 and HealBot_Action_luVars["GlobalDimming"]<1000 then
        HealBot_Action_luVars["EnableDimmingAfter"]=GetTime()+0.35
        C_Timer.After(0.4, HealBot_Action_EnableGlobalDimming)
    end
end

function HealBot_Action_ModKey()
    if HealBot_Action_luVars["ActiveFrame"] then
        HealBot_Action_OnEnter(HealBot_Action_luVars["ActiveFrame"])
        HealBot_Timers_nextRecalcAll()
    end
end

function HealBot_Action_CanMove(id)
    if HealBot_Globals.HideUnlockedTag then
        return false
    else
        return hbFrameTags[id]
    end
end

function HealBot_Action_OnMouseUp(self,button)
    if button=="LeftButton" and HealBot_Action_luVars["FrameMoving"] then
        HealBot_StopMoving(self,self.id);
        HealBot_Action_luVars["FrameMoving"]=false
    elseif button=="RightButton" and not HealBot_Data["UILOCK"] and HealBot_Globals.RightButtonOptions then
        HealBot_Action_OptionsButton_OnClick();
    end
end

function HealBot_Action_Toggle_Enabled(unit)
    _,xButton,pButton = HealBot_UnitID(unit)
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

function HealBot_Action_AlwaysEnabled(hbGUID)
    return HealBot_AlwaysEnabled[hbGUID]
end

local function HealBot_Action_IsPlayersDead(button)
    if HealBot_Action_IsUnitDead(button) and button.status.range>-1 then
        return true
    else
        return false
    end
end

function HealBot_Action_UseMassRes()
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

local scSpell=false
function HealBot_Action_SmartCast(button)
    if button.player and HealBot_Action_IsUnitDead(button) then return nil; end
    scSpell=false
 
    if HealBot_Globals.SmartCastRes and HealBot_Action_IsUnitDead(button) then
        scSpell=HealBot_Action_retResSpell(button)
        HealBot_AddDebug("Res spell="..(scSpell or "nil"),"SmartCast",true)
    elseif button.aura.debuff.curespell and HealBot_Globals.SmartCastDebuff then
        scSpell=button.aura.debuff.curespell
    elseif button.aura.buff.missingbuff and HealBot_Globals.SmartCastBuff then
        if button.aura.buff.missingbuff==HEALBOT_WELL_FED then
            if HealBot_Config_Buffs.WellFedItem and IsUsableItem(HealBot_Config_Buffs.WellFedItem) then
                scSpell=HealBot_Config_Buffs.WellFedItem
            elseif HealBot_Config_Buffs.BackupWellFedItem and IsUsableItem(HealBot_Config_Buffs.BackupWellFedItem) then
                scSpell=HealBot_Config_Buffs.BackupWellFedItem
            end
        elseif button.aura.buff.missingbuff==HEALBOT_MANA_DRINK then
            if HealBot_Config_Buffs.ManaDrinkItem and IsUsableItem(HealBot_Config_Buffs.ManaDrinkItem) then
                scSpell=HealBot_Config_Buffs.ManaDrinkItem
            elseif HealBot_Config_Buffs.BackupManaDrinkItem and IsUsableItem(HealBot_Config_Buffs.BackupManaDrinkItem) then
                scSpell=HealBot_Config_Buffs.BackupManaDrinkItem
            end
        else
            scSpell=button.aura.buff.missingbuff
        end
    end

    if scSpell and HealBot_UnitInRangeExc30(button, scSpell)>0 then
        HealBot_AddDebug("In Range spell="..scSpell,"SmartCast",true)
        return scSpell
    else
        if scSpell then 
            HealBot_AddDebug("Out of Range spell="..scSpell,"SmartCast",true)   
        end
        return nil
    end
end

function HealBot_Action_StickyFrameClearStuck(hbCurFrame)
    if hbCurFrame then
        Healbot_Config_Skins.StickyFrames[Healbot_Config_Skins.Current_Skin][hbCurFrame]["STUCK"]=false
    else
        for x=1,10 do
            Healbot_Config_Skins.StickyFrames[Healbot_Config_Skins.Current_Skin][x]["STUCK"]=false
            hbStickyFrameGetCoords[x]=false
        end
    end
end

function HealBot_Action_hbStickyFrameGetCoords(hbCurFrame)
    return hbStickyFrameGetCoords[hbCurFrame]
end

local vSticktSetPointX,vSticktSetPointY,vSticktSetPointOptionUpd=0,0,false
function HealBot_Action_StickyFrameSetPoint(hbCurFrame,stuckTo,stuckPoint,stuckToPoint,HBframe,cf)
    hbStickyFrameGetCoords[hbCurFrame]=true
    vSticktSetPointX,vSticktSetPointY=0,0
    if (stuckPoint=="BOTTOMLEFT" or stuckPoint=="BOTTOM" or stuckPoint=="BOTTOMRIGHT") and
       (stuckToPoint=="TOPLEFT" or stuckToPoint=="TOP" or stuckToPoint=="TOPRIGHT") then
        if Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][stuckTo]["SHOW"] then
            vSticktSetPointY=Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][stuckTo]["HEIGHT"]
        end
    elseif (stuckToPoint=="BOTTOMLEFT" or stuckToPoint=="BOTTOM" or stuckToPoint=="BOTTOMRIGHT") and
           (stuckPoint=="TOPLEFT" or stuckPoint=="TOP" or stuckPoint=="TOPRIGHT") then
        if Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame]["SHOW"] then
            vSticktSetPointY=0-Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][hbCurFrame]["HEIGHT"]
        end
    end
    vSticktSetPointX=vSticktSetPointX+Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][hbCurFrame]["SFOFFSETH"]
    vSticktSetPointY=vSticktSetPointY+Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][hbCurFrame]["SFOFFSETV"]
    HBframe:ClearAllPoints();
    HBframe:SetPoint(stuckPoint,cf,stuckToPoint,vSticktSetPointX,vSticktSetPointY)
    vSticktSetPointOptionUpd=false
    if stuckPoint=="TOPLEFT" and Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]~=1 then
        Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]=1
        vSticktSetPointOptionUpd=true
    elseif stuckPoint=="BOTTOMLEFT" and Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]~=2 then
        Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]=2
        vSticktSetPointOptionUpd=true
    elseif stuckPoint=="TOPRIGHT" and Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]~=3 then
        Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]=3
        vSticktSetPointOptionUpd=true
    elseif stuckPoint=="BOTTOMRIGHT" and Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]~=4 then
        Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]=4
        vSticktSetPointOptionUpd=true
    elseif stuckPoint=="TOP" and Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]~=5 then
        Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]=5
        vSticktSetPointOptionUpd=true
    elseif stuckPoint=="LEFT" and Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]~=6 then
        Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]=6
        vSticktSetPointOptionUpd=true
    elseif stuckPoint=="RIGHT" and Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]~=7 then
        Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]=7
        vSticktSetPointOptionUpd=true
    elseif stuckPoint=="BOTTOM" and Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]~=8 then
        Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]=8
        vSticktSetPointOptionUpd=true
    end
    if vSticktSetPointOptionUpd then
        HealBot_Options_ActionAnchor_UpdateDropDown()
    end
end

function HealBot_Action_StickyFrameStuckTo(hbCurFrame,stuckTo,stuckPoint,stuckToPoint,HBframe,cf)
    Healbot_Config_Skins.StickyFrames[Healbot_Config_Skins.Current_Skin][hbCurFrame]["STUCK"]=true
    Healbot_Config_Skins.StickyFrames[Healbot_Config_Skins.Current_Skin][hbCurFrame]["STUCKTO"]=stuckTo
    Healbot_Config_Skins.StickyFrames[Healbot_Config_Skins.Current_Skin][hbCurFrame]["STUCKPOINT"]=stuckPoint
    Healbot_Config_Skins.StickyFrames[Healbot_Config_Skins.Current_Skin][hbCurFrame]["STUCKTOPOINT"]=stuckToPoint
    HealBot_Action_StickyFrameSetPoint(hbCurFrame,stuckTo,stuckPoint,stuckToPoint,HBframe,cf)
end

local vStickyFrameCurInd={[2]=0,[3]=0,[4]=0,[5]=0,[6]=0,[7]=0,[8]=0,[9]=0,[10]=0,}
local vStickyFrameParInd={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,[6]=0,[7]=0,[8]=0,[9]=0,}
local vStickyFrameLastPar=0
local vStickyFrameLastParInd=0
local vsfIndCols={["R"]=1,["G"]=1,["B"]=.025}
function HealBot_Action_StickyFrameIndCols()
    vsfIndCols["R"],vsfIndCols["G"],vsfIndCols["B"]=HealBot_Options_OptionsThemeCols()
end

function HealBot_Action_StickyFrameCanStickTo(frame,frameind,parent,parentind)
    if vStickyFrameCurInd[frame]~=frameind then
        if vStickyFrameCurInd[frame]>0 then
            grpFrameStickyInd[frame][vStickyFrameCurInd[frame]]:SetStatusBarColor(vsfIndCols["R"],vsfIndCols["G"],vsfIndCols["B"],0)
        end
        if frameind>0 then
            grpFrameStickyInd[frame][frameind]:SetStatusBarColor(vsfIndCols["R"],vsfIndCols["G"],vsfIndCols["B"],1)
        end
        vStickyFrameCurInd[frame]=frameind
    end
    if parent==0 then
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
local vStickyFrameSen=25
function HealBot_Action_CheckForStickyFrame(frame,stick)
    vStickyFrameIsSticky=false
    vStickyFrameCurAnchor=0
    vStickyFrameParAnchor=0
    vStickyFrameLeft=grpFrame[frame]:GetLeft() or Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][frame]["LEFT"] or Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][frame]["X"]
    vStickyFrameRight=grpFrame[frame]:GetRight() or Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][frame]["RIGHT"] or Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][frame]["X"]
    vStickyFrameTop=grpFrame[frame]:GetTop() or Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][frame]["TOP"] or Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][frame]["Y"]
    vStickyFrameBottom=grpFrame[frame]:GetBottom() or Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][frame]["BOTTOM"] or Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][frame]["Y"]
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
            if vStickyFrameLeft then Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][frame]["LEFT"]=vStickyFrameLeft end
            if vStickyFrameRight then Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][frame]["RIGHT"]=vStickyFrameRight end
            if vStickyFrameTop then Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][frame]["TOP"]=vStickyFrameTop end
            if vStickyFrameBottom then Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][frame]["BOTTOM"]=vStickyFrameBottom end
        end
    end
    if not vStickyFrameIsSticky and not stick then
        HealBot_Action_StickyFrameCanStickTo(frame,0,0,0)
    end
end

function HealBot_Action_StickyFrame(frame)
    vStickyFrameIsSticky=false
    if Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["STICKYFRAME"] and frame>1 then
        if Healbot_Config_Skins.StickyFrames[Healbot_Config_Skins.Current_Skin][frame]["STUCK"] and
           HealBot_Action_FrameIsVisible(Healbot_Config_Skins.StickyFrames[Healbot_Config_Skins.Current_Skin][frame]["STUCKTO"]) then
            HealBot_Action_StickyFrameSetPoint(frame,
                                               Healbot_Config_Skins.StickyFrames[Healbot_Config_Skins.Current_Skin][frame]["STUCKTO"],
                                               Healbot_Config_Skins.StickyFrames[Healbot_Config_Skins.Current_Skin][frame]["STUCKPOINT"],
                                               Healbot_Config_Skins.StickyFrames[Healbot_Config_Skins.Current_Skin][frame]["STUCKTOPOINT"],
                                               grpFrame[frame],
                                               grpFrame[Healbot_Config_Skins.StickyFrames[Healbot_Config_Skins.Current_Skin][frame]["STUCKTO"]])
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