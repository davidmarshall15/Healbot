local HealBot_ActiveButtons={[0]=1}
local HealBot_ButtonIndex={}
local HealBot_RangeSpells={}
local HealBot_AlwaysEnabled={}
local HealBot_pcClass={[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
local LSM = HealBot_Libs_LSM() --LibStub("LibSharedMedia-3.0") 
local HealBot_Action_rCalls={}
local _
local HealBot_Action_luVars={}
HealBot_Action_luVars["FrameMoving"]=false
HealBot_Action_luVars["UnitPowerMax"]=3
HealBot_Action_luVars["resetSkinTo"]=""
HealBot_Action_luVars["TestBarsOn"]=false
HealBot_Action_luVars["ShapeshiftForm"]=-1
HealBot_Action_luVars["FluidInUse"]=false
HealBot_Action_luVars["FrameInitDone"]=false
HealBot_Action_luVars["pluginExtraButtons"]=false
HealBot_Action_luVars["showTestPowerIndicator"]=0
HealBot_Action_luVars["FocusGroups"]=false
HealBot_Action_luVars["FGDimming"]=2
HealBot_Action_luVars["FluidBarAlphaUpdate"]=0.025
HealBot_Action_luVars["FluidBarAlphaFreq"]=0.025
HealBot_Action_luVars["FluidBarUpdate"]=100
HealBot_Action_luVars["FluidBarFreq"]=0.025
HealBot_Action_luVars["FGroups"]={[1]=true,[2]=true,[3]=true,[4]=true,[5]=true,[6]=true,[7]=true,[8]=true}

function HealBot_Action_setLuVars(vName, vValue)
    HealBot_Action_luVars[vName]=vValue
      --HealBot_setCall("HealBot_Action_setLuVars - "..vName)
end

function HealBot_Action_retLuVars(vName)
    --HealBot_setCall("HealBot_Action_retLuVars")
    return HealBot_Action_luVars[vName]
end

function HealBot_Action_setpcClass()
    local xButton=HealBot_Unit_Button["player"] or HealBot_Private_Button["player"]
    if xButton then
        for j=1,5 do
            if HEALBOT_GAME_VERSION>3 and 
               (HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_PALADIN] or 
                HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_MONK] or
                HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_WARLOCK] or
                HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_ROGUE]) and 
                Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j] and Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j]["POWERCNT"] then
                local prevHealBot_pcMax=HealBot_Action_luVars["UnitPowerMax"];
                if HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_PALADIN] then
                    HealBot_pcClass[j]=9
                    HealBot_Action_luVars["UnitPowerMax"] = UnitPowerMax("player" , 9);
                elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_ROGUE] then
                    HealBot_pcClass[j]=4
                    HealBot_Action_luVars["UnitPowerMax"] = UnitPowerMax("player" , 4);
                elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_WARLOCK] then
                    HealBot_pcClass[j]=7
                    HealBot_Action_luVars["UnitPowerMax"] = UnitPowerMax("player" , 7);
                else
                    HealBot_pcClass[j]=12
                    HealBot_Action_luVars["UnitPowerMax"] = UnitPowerMax("player" , 12);
                end     
                if prevHealBot_pcMax~=HealBot_Action_luVars["UnitPowerMax"] then
                    xButton.skinreset=true
                    xButton.icon.reset=true
                    HealBot_nextRecalcParty(6)
                end
            else
                HealBot_pcClass[j]=false
                xButton.mana.power=0
                for y=1,5 do
                    xButton.gref.indicator.power[y]:SetAlpha(0)
                end
            end
        end
    end
    --HealBot_setCall("HealBot_Action_setpcClass")
end

HealBot_RangeSpells["HEAL"]=""
function HealBot_Action_SetrSpell()
    HealBot_RangeSpells["HEAL"]=nil
    HealBot_RangeSpells["BUFF"]=nil
    HealBot_RangeSpells["CURE"]=nil
    HealBot_RangeSpells["RES"]=nil
    HealBot_RangeSpells["HARM"]=nil
    local x=HealBot_GetBandageType() or HEALBOT_WORDS_UNKNOWN
    local y=GetInventoryItemID("player", INVSLOT_MAINHAND) or HEALBOT_WORDS_UNKNOWN
    if y~=HEALBOT_WORDS_UNKNOWN then y=GetItemInfo(y) or y end
    local sName=nil
    if HealBot_Data["PCLASSTRIM"]=="DRUI" then
        sName=HealBot_KnownSpell(HEALBOT_WRATH) or HealBot_KnownSpell(HEALBOT_HURRICANE)
        if sName then 
            HealBot_RangeSpells["HARM"]=sName
            x=sName
        end
        sName=HealBot_KnownSpell(HBC_GIFT_OF_THE_WILD) or HealBot_KnownSpell(HEALBOT_MARK_OF_THE_WILD)
        if sName then 
            HealBot_RangeSpells["BUFF"]=sName
            x=sName
        end
        sName=HealBot_KnownSpell(HEALBOT_REMOVE_CORRUPTION)
        if sName then 
            HealBot_RangeSpells["CURE"]=sName
            x=sName
        end
        sName=HealBot_KnownSpell(HEALBOT_REVIVE)
        if sName then 
            HealBot_RangeSpells["RES"]=sName
            x=sName
        end
        sName=HealBot_KnownSpell(HEALBOT_REJUVENATION) or HealBot_KnownSpell(HEALBOT_HEALING_TOUCH)
        if sName then 
            HealBot_RangeSpells["HEAL"]=sName
            x=sName
        end
    elseif HealBot_Data["PCLASSTRIM"]=="MAGE" then
        sName=HealBot_KnownSpell(HEALBOT_FROSTFIRE_BOLT) or HealBot_KnownSpell(HEALBOT_FIRE_BLAST)
        if sName then 
            HealBot_RangeSpells["HARM"]=sName
            y=sName
        end
        sName=HealBot_KnownSpell(HEALBOT_ARCANE_BRILLIANCE)
        if sName then 
            HealBot_RangeSpells["BUFF"]=sName
            x=sName
        end
        sName=HealBot_KnownSpell(HEALBOT_REMOVE_CURSE)
        if sName then 
            HealBot_RangeSpells["CURE"]=sName
            x=sName
        end
    elseif HealBot_Data["PCLASSTRIM"]=="PALA" then
        sName=HealBot_KnownSpell(HEALBOT_HOLY_SHOCK) or HealBot_KnownSpell(HEALBOT_JUDGMENT)
        if sName then 
            HealBot_RangeSpells["HARM"]=sName
            y=sName
        end
        sName=HealBot_KnownSpell(HEALBOT_REDEMPTION)
        if sName then 
            HealBot_RangeSpells["BUFF"]=sName
            x=sName
        end
        sName=HealBot_KnownSpell(HEALBOT_CLEANSE)
        if sName then 
            HealBot_RangeSpells["CURE"]=sName
            x=sName
        end
        sName=HealBot_KnownSpell(HEALBOT_REDEMPTION)
        if sName then 
            HealBot_RangeSpells["RES"]=sName
            x=sName
        end
        sName=HealBot_KnownSpell(HEALBOT_FLASH_OF_LIGHT) or HealBot_KnownSpell(HEALBOT_HOLY_LIGHT) or HealBot_KnownSpell(HBC_HOLY_LIGHT)
        if sName then 
            HealBot_RangeSpells["HEAL"]=sName
            x=sName
        end
    elseif HealBot_Data["PCLASSTRIM"]=="PRIE" then
        sName=HealBot_KnownSpell(HEALBOT_SMITE) or HealBot_KnownSpell(HEALBOT_SHADOW_WORD_PAIN) or HealBot_KnownSpell(HEALBOT_PENANCE)
        if sName then 
            HealBot_RangeSpells["HARM"]=sName
            y=sName
        end
        sName=HealBot_KnownSpell(HEALBOT_POWER_WORD_FORTITUDE) or HealBot_KnownSpell(HBC_POWER_WORD_FORTITUDE)
        if sName then 
            HealBot_RangeSpells["BUFF"]=sName
            x=sName
        end
        sName=HealBot_KnownSpell(HEALBOT_PURIFY)
        if sName then 
            HealBot_RangeSpells["CURE"]=sName
            x=sName
        end
        sName=HealBot_KnownSpell(HEALBOT_RESURRECTION)
        if sName then 
            HealBot_RangeSpells["RES"]=sName
            x=sName
        end
        sName=HealBot_KnownSpell(HEALBOT_FLASH_HEAL) or HealBot_KnownSpell(HEALBOT_PENANCE) or HealBot_KnownSpell(HEALBOT_HOLY_WORD_SERENITY)
        if sName then 
            HealBot_RangeSpells["HEAL"]=sName
            x=sName
        end
    elseif HealBot_Data["PCLASSTRIM"]=="SHAM" then
        sName=HealBot_KnownSpell(HEALBOT_LIGHTNING_BOLT)
        if sName then 
            HealBot_RangeSpells["HARM"]=sName
            y=sName
        end
        sName=HealBot_KnownSpell(HEALBOT_EARTH_SHIELD)
        if sName then 
            HealBot_RangeSpells["BUFF"]=sName
            x=sName
        end
        sName=HealBot_KnownSpell(HEALBOT_PURIFY_SPIRIT) or HealBot_KnownSpell(HEALBOT_CLEANSE_SPIRIT) or HealBot_KnownSpell(HEALBOT_HEALING_SURGE)
        if sName then 
            HealBot_RangeSpells["CURE"]=sName
            x=sName
        end
        sName=HealBot_KnownSpell(HEALBOT_ANCESTRALSPIRIT)
        if sName then 
            HealBot_RangeSpells["RES"]=sName
            x=sName
        end
        sName=HealBot_KnownSpell(HEALBOT_HEALING_WAVE) or HealBot_KnownSpell(HEALBOT_HEALING_SURGE) or HealBot_KnownSpell(HBC_HEALING_WAVE)
        if sName then 
            HealBot_RangeSpells["HEAL"]=sName
            x=sName
        end
    elseif HealBot_Data["PCLASSTRIM"]=="MONK" then
        sName=HealBot_KnownSpell(HEALBOT_CRACKLING_JADE_LIGHTNING)
        if sName then 
            HealBot_RangeSpells["HARM"]=sName
            y=sName
        end
        sName=HealBot_KnownSpell(HEALBOT_LEGACY_EMPEROR)
        if sName then 
            HealBot_RangeSpells["BUFF"]=sName
            x=sName
        end
        sName=HealBot_KnownSpell(HEALBOT_DETOX)
        if sName then 
            HealBot_RangeSpells["CURE"]=sName
            x=sName
        end
        sName=HealBot_KnownSpell(HEALBOT_RESUSCITATE)
        if sName then 
            HealBot_RangeSpells["RES"]=sName
            x=sName
        end
        sName=HealBot_KnownSpell(HEALBOT_SOOTHING_MIST)
        if sName then 
            HealBot_RangeSpells["HEAL"]=sName
            x=sName
        end
    elseif HealBot_Data["PCLASSTRIM"]=="WARL" then
        sName=HealBot_KnownSpell(HEALBOT_CORRUPTION) or HealBot_KnownSpell(HEALBOT_FEAR)
        if sName then 
            HealBot_RangeSpells["HARM"]=sName
            y=sName
        end
        sName=HealBot_KnownSpell(HEALBOT_UNENDING_BREATH)
        if sName then 
            HealBot_RangeSpells["BUFF"]=sName
            x=sName
        end
    elseif HealBot_Data["PCLASSTRIM"]=="WARR" then
        sName=HealBot_KnownSpell(HEALBOT_TAUNT)
        if sName then 
            HealBot_RangeSpells["HARM"]=sName
            y=sName
        end
        sName=HealBot_KnownSpell(HEALBOT_VIGILANCE) or HealBot_KnownSpell(HEALBOT_BATTLE_SHOUT)
        if sName then 
            HealBot_RangeSpells["BUFF"]=sName
            x=sName
        end
    elseif HealBot_Data["PCLASSTRIM"]=="HUNT" then
        sName=HealBot_KnownSpell(HEALBOT_ARCANE_SHOT) or HealBot_KnownSpell(HEALBOT_CONCUSSIVE_SHOT) or HealBot_KnownSpell(HEALBOT_AIMED_SHOT)
        if sName then 
            HealBot_RangeSpells["HARM"]=sName
            y=sName
        end
        sName=HealBot_KnownSpell(HEALBOT_MENDPET)
        if sName then 
            HealBot_RangeSpells["HEAL"]=sName
            x=sName
        end
    elseif HealBot_Data["PCLASSTRIM"]=="ROGU" then
        sName=HealBot_KnownSpell(HEALBOT_THROW) or HealBot_KnownSpell(HEALBOT_GOUGE)
        if sName then 
            HealBot_RangeSpells["HARM"]=sName
            y=sName
        end
        sName=HealBot_KnownSpell(HEALBOT_DEADLY_POISON) or HealBot_KnownSpell(HEALBOT_CRIPPLING_POISON)
        if sName then 
            HealBot_RangeSpells["BUFF"]=sName
            x=sName
        end
    elseif HealBot_Data["PCLASSTRIM"]=="DEAT" then
        sName=HealBot_KnownSpell(HEALBOT_DEATH_COIL) or HealBot_KnownSpell(HEALBOT_PLAGUE_STRIKE)
        if sName then 
            HealBot_RangeSpells["HARM"]=sName
            y=sName
        end
    elseif HealBot_Data["PCLASSTRIM"]=="DEMO" then
    end
    if (HealBot_RangeSpells["HEAL"] or HEALBOT_WORDS_UNKNOWN)==HEALBOT_WORDS_UNKNOWN then HealBot_RangeSpells["HEAL"]=x end
    if (HealBot_RangeSpells["BUFF"] or HEALBOT_WORDS_UNKNOWN)==HEALBOT_WORDS_UNKNOWN then HealBot_RangeSpells["BUFF"]=x end
    if (HealBot_RangeSpells["CURE"] or HEALBOT_WORDS_UNKNOWN)==HEALBOT_WORDS_UNKNOWN then HealBot_RangeSpells["CURE"]=x end
    if (HealBot_RangeSpells["RES"] or HEALBOT_WORDS_UNKNOWN)==HEALBOT_WORDS_UNKNOWN then HealBot_RangeSpells["RES"]=x end
    if (HealBot_RangeSpells["HARM"] or HEALBOT_WORDS_UNKNOWN)==HEALBOT_WORDS_UNKNOWN then HealBot_RangeSpells["HARM"]=y end
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
local aufbButtonActive=false
local aufbBarValue,aufbSetValue,aufbAlphaValue=0,0,0
local aufbRValue,aufbGValue,aufbBValue=0,0,0
local aufbSetRValue,aufbSetGValue,aufbSetBValue=0,0,0


function HealBot_Action_setFluid_Aborbs_BarButtons(button)
    HealBot_Fluid_AbsorbButtons[button.id]=button
    if not HealBot_Action_luVars["FluidBarInUse"] then HealBot_Action_UpdateFluidBars(GetTime()-0.01) end
      --HealBot_setCall("HealBot_Action_setFluid_Aborbs_BarButtons")
end

function HealBot_Action_setFluid_InHeal_BarButtons(button)
    HealBot_Fluid_InHealButtons[button.id]=button
    if not HealBot_Action_luVars["FluidBarInUse"] then HealBot_Action_UpdateFluidBars(GetTime()-0.01) end
      --HealBot_setCall("HealBot_Action_setFluid_InHeal_BarButtons")
end

function HealBot_Action_setFluid_BarButtons(button)
    HealBot_Fluid_BarButtons[button.id]=button
    if not HealBot_Action_luVars["FluidBarInUse"] then HealBot_Action_UpdateFluidBars(GetTime()-0.01) end
      --HealBot_setCall("HealBot_Action_setFluid_BarButtons")
end

function HealBot_Action_UpdateFluidBars(PrevTime)
    HealBot_Action_luVars["FluidBarInUse"]=false
    HealBot_Action_luVars["FluidBarElapsed"]=(GetTime()-PrevTime)*2
    HealBot_Action_luVars["FluidBarUpdateElapsed"]=HealBot_Comm_round(HealBot_Action_luVars["FluidBarElapsed"]*HealBot_Action_luVars["FluidBarUpdate"],2)
    --HealBot_Action_luVars["FluidBarUpdateElapsed"]=HealBot_Action_luVars["FluidBarUpdate"]
    for id,xButton in pairs(HealBot_Fluid_BarButtons) do
        aufbButtonActive=false
        if xButton.status.current<HealBot_Unit_Status["DEAD"] then
            aufbBarValue=xButton.gref["Bar"]:GetValue()
            if aufbBarValue>xButton.health.hptc then
                aufbSetValue=aufbBarValue-HealBot_Action_luVars["FluidBarUpdateElapsed"]
                if aufbSetValue<xButton.health.hptc then 
                    aufbSetValue=xButton.health.hptc
                else
                    aufbButtonActive=true
                end
                xButton.gref["Bar"]:SetValue(aufbSetValue)
            elseif aufbBarValue<xButton.health.hptc then
                aufbSetValue=aufbBarValue+HealBot_Action_luVars["FluidBarUpdateElapsed"]
                if aufbSetValue>xButton.health.hptc then 
                    aufbSetValue=xButton.health.hptc
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
        if xButton.status.current>HealBot_Unit_Status["ENABLEDOOR"] and xButton.status.current<HealBot_Unit_Status["DEAD"] and xButton.health.incoming>0 then
            HealBot_Action_luVars["FluidBarInUse"]=true
            aufbBarValue=0
            aufbBarValue=xButton.gref["InHeal"]:GetValue()
            if aufbBarValue>xButton.health.inhptc then
                aufbSetValue=aufbBarValue-HealBot_Action_luVars["FluidBarUpdateElapsed"]
                if aufbSetValue<xButton.health.inhptc then aufbSetValue=xButton.health.inhptc end
                xButton.gref["InHeal"]:SetValue(aufbSetValue)
            elseif aufbBarValue<xButton.health.inhptc then
                aufbSetValue=aufbBarValue+HealBot_Action_luVars["FluidBarUpdateElapsed"]
                if aufbSetValue>xButton.health.inhptc then aufbSetValue=xButton.health.inhptc end
                xButton.gref["InHeal"]:SetValue(aufbSetValue)
            end
        else
            xButton.gref["InHeal"]:SetValue(0)
            xButton.gref["InHeal"]:SetStatusBarColor(0,0,0,0)
            HealBot_Fluid_InHealButtons[id]=nil
        end
    end

    for id,xButton in pairs(HealBot_Fluid_AbsorbButtons) do
        if xButton.status.current>HealBot_Unit_Status["ENABLEDOOR"] and xButton.status.current<HealBot_Unit_Status["DEAD"] and xButton.health.absorbs>0 then
            HealBot_Action_luVars["FluidBarInUse"]=true
            aufbBarValue=0
            aufbBarValue=xButton.gref["Absorb"]:GetValue()
            if aufbBarValue>xButton.health.abptc then
                aufbSetValue=aufbBarValue-HealBot_Action_luVars["FluidBarUpdateElapsed"]
                if aufbSetValue<xButton.health.abptc then aufbSetValue=xButton.health.abptc end
                xButton.gref["Absorb"]:SetValue(aufbSetValue)
            elseif aufbBarValue<xButton.health.abptc then
                aufbSetValue=aufbBarValue+HealBot_Action_luVars["FluidBarUpdateElapsed"]
                if aufbSetValue>xButton.health.abptc then aufbSetValue=xButton.health.abptc end
                xButton.gref["Absorb"]:SetValue(aufbSetValue)
            end
        else
            xButton.gref["Absorb"]:SetValue(0)
            xButton.gref["Absorb"]:SetStatusBarColor(0,0,0,0)
            HealBot_Fluid_AbsorbButtons[id]=nil
        end
    end
    if HealBot_Action_luVars["FluidBarInUse"] then
        PrevTime=GetTime()
        C_Timer.After(HealBot_Action_luVars["FluidBarFreq"], function() HealBot_Action_UpdateFluidBars(PrevTime) end)
    end
    --HealBot_Aux_setLuVars("FluidBarInUse", HealBot_Action_luVars["FluidBarInUse"])
      --HealBot_setCall("HealBot_Action_UpdateFluidBars")
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
function HealBot_Action_ResetEmergBar(button)
    erButton=HealBot_Emerg_Button[button.id]
    erButton.debuff=false
    erButton.buff=false
end

function HealBot_Action_ResetEmergBars()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Action_ResetEmergBar(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Action_ResetEmergBar(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Action_ResetEmergBar(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Action_ResetEmergBar(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Action_ResetEmergBar(xButton)
    end
end

local prevState,hPct=0,0
function HealBot_Action_EmergBarCheck(button, force)
    if Healbot_Config_Skins.Spells[Healbot_Config_Skins.Current_Skin][button.frame]["USE"] then
        erButton=HealBot_Emerg_Button[button.id]
		if button.status.current<HealBot_Unit_Status["DEAD"] and button.health.current>0 then
			if erButton.debuff then
				erButton.state=1
				HealBot_Action_EmergBarUpdate(button, HealBot_RangeSpells["CURE"], button.aura.debuff.r, button.aura.debuff.g, button.aura.debuff.b)
			elseif erButton.buff then
				erButton.state=2
				HealBot_Action_EmergBarUpdate(button, HealBot_RangeSpells["BUFF"], button.aura.buff.r, button.aura.buff.g, button.aura.buff.b)
			else
                prevState=erButton.state
                hPct=ceil(button.health.hptc/10)
                if hPct<Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][button.frame]["CRITICAL"] then
                    erButton.state=4
                elseif hPct<Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][button.frame]["INJURED"] then
                    erButton.state=3
                else
                    erButton.state=0
                end
                if erButton.state~=prevState or force then
                    HealBot_Action_EmergBarUpdate(button,HealBot_RangeSpells["HEAL"])
                end
            end
		elseif erButton.state>0 then
			erButton.state=0
			HealBot_Action_EmergBarUpdate(button,HealBot_RangeSpells["HEAL"])
		end
    end
end

function HealBot_Action_EmergBarUpdate(button, rSpell, r, g, b)
    erButton=HealBot_Emerg_Button[button.id]
	if r then
		erButton.r,erButton.g,erButton.b=r, g, b
	elseif Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][button.frame]["BARCOL"]==1 then
		erButton.r,erButton.g=button.health.rcol, button.health.gcol
		erButton.b=0
	elseif Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][button.frame]["BARCOL"]==2 then
		erButton.r,erButton.g,erButton.b=button.text.r,button.text.g,button.text.b
	elseif erButton.state==4 then
		erButton.r=Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][button.frame]["CR"]
		erButton.g=Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][button.frame]["CG"]
		erButton.b=Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][button.frame]["CB"]
	elseif erButton.state==3 then
		erButton.r=Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][button.frame]["IR"]
		erButton.g=Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][button.frame]["IG"]
		erButton.b=Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][button.frame]["IB"]
	else
		erButton.r=Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][button.frame]["HR"]
		erButton.g=Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][button.frame]["HG"]
		erButton.b=Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][button.frame]["HB"]
	end
	if erButton.state>0 then
        if HealBot_UnitInRange(button.unit, rSpell)>0 then
            erButton.a=Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][button.frame]["A"]
        else
            erButton.a=Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][button.frame]["OA"]
        end
	else
		erButton.a=Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][button.frame]["DA"]
	end
	HealBot_Action_EmergBarColUpdate(button)
end

function HealBot_Action_EmergBarColUpdate(button)
    erButton=HealBot_Emerg_Button[button.id]
    if HealBot_Action_luVars["FluidInUse"] then
        HealBot_Fluid_EmergButtonsAlpha[button.id]=erButton
        if not HealBot_Action_luVars["FluidBarAlphaInUse"] then
            HealBot_Action_UpdateFluidBarsAlpha()
        end
        --HealBot_Aux_setLuVars("FluidBarAlphaInUse", true)
    else
        erButton.bar:SetStatusBarColor(erButton.r,erButton.g,erButton.b,erButton.a)
    end
end

local auhiHiPct, auhiHiHealsIn=1,0
function HealBot_Action_UpdateHealsInButton(button)
    auhiHiHealsIn=button.health.incoming
    if Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IC"]<2 then auhiHiHealsIn=0 end
    
    if auhiHiHealsIn>0 and button.status.current>HealBot_Unit_Status["ENABLEDOOR"] and button.status.current<HealBot_Unit_Status["DEAD"] then
        auhiHiPct = button.health.current+button.health.incoming
        if auhiHiPct<button.health.max then 
            auhiHiPct=auhiHiPct/button.health.max  
         else
            auhiHiPct=1;
        end
        button.health.inhptc=floor(auhiHiPct*1000)
        if (Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IC"] == 4) then -- Incoming Heal Bar Colour = "Custom"
            button.health.inhealr=Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IR"]
            button.health.inhealg=Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IG"]
            button.health.inhealb=Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IB"]
        elseif (Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IC"] == 3) then -- Incoming Heal Bar Colour = "Future Health"
            button.health.inhealr, button.health.inhealg = HealBot_Action_BarColourPct(auhiHiPct)
            button.health.inhealb=0
        else
            button.health.inhealr,button.health.inhealg,button.health.inhealb = button.health.rcol, button.health.gcol,0
        end
        button.health.inheala=HealBot_Action_BarColourAlpha(button, (Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IA"]*button.status.alpha),2)
        HealBot_Action_UpdateInHealStatusBarColor(button)
        if not HealBot_Action_luVars["FluidInUse"] then
            button.gref["InHeal"]:SetValue(button.health.inhptc);
        else
            if button.gref["InHeal"]:GetValue() < button.gref["Bar"]:GetValue() then
                button.gref["InHeal"]:SetValue(button.gref["Bar"]:GetValue())
            end
            HealBot_Action_setFluid_InHeal_BarButtons(button)
        end
        HealBot_Aux_UpdateHealInBar(button, button.health.inhptc)
    else
        button.health.inheala=0
        button.health.inhptc=0
        if not HealBot_Action_luVars["FluidInUse"] or button.status.current<HealBot_Unit_Status["ENABLEDIR"] or button.status.current>HealBot_Unit_Status["DEBUFFBARCOL"] then
            button.gref["InHeal"]:SetValue(0)
        end
        HealBot_Action_UpdateInHealStatusBarColor(button)
        HealBot_Aux_ClearHealInBar(button)
    end
    --HealBot_setCall("HealBot_Action_UpdateHealsInButton")
end

local auaHaPct, auaHbPct, auaUnitHealsIn, auaUnitAbsorbsIn=1,1,0,0
function HealBot_Action_UpdateAbsorbsButton(button)
    auaUnitAbsorbsIn=button.health.absorbs
    if Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AC"]<2 then auaUnitAbsorbsIn=0 end
    
    if auaUnitAbsorbsIn>0 and button.status.current>HealBot_Unit_Status["ENABLEDOOR"] and button.status.current<HealBot_Unit_Status["DEAD"] then
        auaUnitHealsIn=button.health.incoming
        if Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IC"]<2 then auaUnitHealsIn=0 end
        auaHaPct = button.health.current+auaUnitHealsIn+auaUnitAbsorbsIn
        if auaHaPct<button.health.max then
            auaHaPct=auaHaPct/button.health.max
        else
            auaHaPct=1;
        end
        button.health.abptc=floor(auaHaPct*1000)
        if (Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AC"] == 4) then -- Incoming Heal Bar Colour = "Custom"
            button.health.absorbr=Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AR"]
            button.health.absorbg=Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AG"]
            button.health.absorbb=Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AB"]
        elseif (Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AC"] == 3) then -- Incoming Heal Bar Colour = "Future Health"
            auaHbPct=auaHaPct
            if Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AC"] == 1 then
                auaHbPct=button.health.current+auaUnitAbsorbsIn
                if auaHbPct<button.health.max then
                    auaHbPct=auaHbPct/button.health.max
                else
                    auaHbPct=1;
                end
            end
            button.health.absorbr, button.health.absorbg = HealBot_Action_BarColourPct(auaHbPct)
            button.health.absorbb=0
        else
            button.health.absorbr,button.health.absorbg,button.health.absorbb = button.health.rcol, button.health.gcol,0
        end
        button.health.absorba=HealBot_Action_BarColourAlpha(button, (Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AA"]*button.status.alpha),2)
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
        HealBot_Aux_UpdateAbsorbBar(button, button.health.abptc)
    else
        button.health.absorba=0
        button.health.abptc=0
        if not HealBot_Action_luVars["FluidInUse"] or button.status.current<HealBot_Unit_Status["ENABLEDIR"] or button.status.current>HealBot_Unit_Status["DEBUFFBARCOL"] then
            button.gref["Absorb"]:SetValue(0)
        end
        HealBot_Action_UpdateAbsorbStatusBarColor(button)
        HealBot_Aux_ClearAbsorbBar(button)
    end
    --HealBot_setCall("HealBot_Action_UpdateAbsorbsButton")
end
               
local ubbHcR, ubbHcG, ubbHcB=0,0,0
function HealBot_Action_UpdateBackgroundButton(button)
    if button.status.current<HealBot_Unit_Status["DEAD"] and Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BACK"]==1 then
        HealBot_Action_UpdateHealthButton(button)
    else
        if button.status.current>HealBot_Unit_Status["DEBUFFBARCOL"] then
            ubbHcR,ubbHcG,ubbHcB = 0, 0, 0
        elseif Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BACK"]==3 then
            ubbHcR=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BR"]
            ubbHcG=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BG"]
            ubbHcB=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BB"]
        else
            ubbHcR,ubbHcG,ubbHcB = button.text.r,button.text.g,button.text.b
        end
        button.gref["Back"]:SetStatusBarColor(ubbHcR,ubbHcG,ubbHcB,HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BA"],1.5));
    end
    --HealBot_setCall("HealBot_Action_UpdateBackgroundButton")
end

function HealBot_Action_dSpell()
    return HealBot_RangeSpells["CURE"] or HealBot_RangeSpells["HEAL"]
end

function HealBot_Action_bSpell()
    return HealBot_RangeSpells["BUFF"] or HealBot_RangeSpells["HEAL"]
end

function HealBot_Action_stateChange(button)
    HealBot_Aux_UpdBar(button)
    HealBot_UnitAuraAlpha(button)
    button.text.healthupdate=true
    button.text.nameupdate=true
    HealBot_Text_UpdateText(button)
end

function HealBot_Action_setState(button, state)
    if button.status.enabled~=state then
        button.status.enabled=state
        HealBot_Action_ShowHideFrames(button) 
        HealBot_Text_UpdateButton(button)
        HealBot_Action_stateChange(button)
        if not state then
            if button.health.incoming>0 then HealBot_Action_UpdateHealsInButton(button) end
            if button.health.absorbs>0 then HealBot_Action_UpdateAbsorbsButton(button) end
        end
    end
end

function HealBot_Action_UpdateAbsorbStatusBarColor(button)
    button.gref["Absorb"]:SetStatusBarColor(button.health.absorbr,button.health.absorbg,button.health.absorbb,button.health.absorba);
end

function HealBot_Action_UpdateInHealStatusBarColor(button)
    button.gref["InHeal"]:SetStatusBarColor(button.health.inhealr,button.health.inhealg,button.health.inhealb,button.health.inheala);
end

function HealBot_Action_UpdateHealthStatusBarColor(button)
    if not HealBot_Action_luVars["FluidInUse"] then
        button.gref["Bar"]:SetStatusBarColor(button.status.r,button.status.g,button.status.b,button.status.alpha);
    else
        HealBot_Fluid_BarButtonsAlpha[button.id]=button
        if not HealBot_Action_luVars["FluidBarAlphaInUse"] then
            HealBot_Action_UpdateFluidBarsAlpha()
        end
        --HealBot_Aux_setLuVars("FluidBarAlphaInUse", true)
    end
end

local customDebuffPriority=HEALBOT_CUSTOM_en.."15"
function HealBot_Action_UpdateDebuffButton(button)
    erButton=HealBot_Emerg_Button[button.id]
    if button.aura.debuff.colbar and button.status.current<HealBot_Unit_Status["DEAD"] then
        if Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][button.frame]["DEBUFFBARCOL"] then
            erButton.debuff=true
            HealBot_Action_EmergBarCheck(button)
        end
        if button.icon.debuff.showcol then
            if button.status.unittype<11 then button.status.rangespell=HealBot_RangeSpells["CURE"] end
            HealBot_UpdateUnitRange(button,false)
            if button.status.range>(HealBot_Config_Cures.HealBot_CDCWarnRange_Bar-3) then
                button.status.r,button.status.g,button.status.b=button.aura.debuff.r,button.aura.debuff.g,button.aura.debuff.b
                button.status.current=HealBot_Unit_Status["DEBUFFBARCOL"]
                if button.status.range==1 then  
                    button.status.alpha=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"],1)
                else
                    button.status.alpha=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["ORA"],1)
                end
                HealBot_Action_UpdateHealthStatusBarColor(button)
                HealBot_Action_setState(button, true)
            else
                button.status.current=HealBot_Unit_Status["DEBUFFNOCOL"]
                HealBot_Action_UpdateBuffButton(button)
            end
        else
            if button.status.current>HealBot_Unit_Status["BUFFBARCOL"] then button.status.current=HealBot_Unit_Status["CHECK"] end
            HealBot_Action_UpdateBuffButton(button)
        end
    else
        if button.status.current<HealBot_Unit_Status["DEAD"] then button.status.current=HealBot_Unit_Status["CHECK"] end
        erButton.debuff=false
        HealBot_Action_UpdateBuffButton(button)
    end
      --HealBot_setCall("HealBot_Action_UpdateDebuffButton")
end

function HealBot_Action_UpdateBuffButton(button)
    erButton=HealBot_Emerg_Button[button.id]
    if button.aura.buff.colbar and button.status.current<HealBot_Unit_Status["DEBUFFBARCOL"] then
        if Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][button.frame]["BUFFBARCOL"] then
            erButton.buff=true
            HealBot_Action_EmergBarCheck(button)
        elseif Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][button.frame]["DEBUFFBARCOL"] then
            HealBot_Action_EmergBarCheck(button)
        end
        if button.aura.buff.showcol then
            if button.status.current<HealBot_Unit_Status["DEBUFFNOCOL"] then
                if button.status.unittype<11 then button.status.rangespell=HealBot_RangeSpells["BUFF"] end
                HealBot_UpdateUnitRange(button,false)
            end
            if button.status.range>(HealBot_Config_Buffs.HealBot_CBWarnRange_Bar-3) then
                button.status.current=HealBot_Unit_Status["BUFFBARCOL"]
                button.status.r,button.status.g,button.status.b=button.aura.buff.r,button.aura.buff.g,button.aura.buff.b
                --HealBot_Text_setHealthText(button)
                if button.status.range==1 then  
                    button.status.alpha=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"], 1)
                else
                    button.status.alpha=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["ORA"], 1)
                end
                HealBot_Action_UpdateHealthStatusBarColor(button)
                HealBot_Action_setState(button, true)
            else
                button.status.current=HealBot_Unit_Status["BUFFNOCOL"]
                HealBot_Action_UpdateHealthButton(button)
            end
        else
            if button.status.current>HealBot_Unit_Status["ENABLEDIR"] then button.status.current=HealBot_Unit_Status["CHECK"] end
            HealBot_Action_UpdateHealthButton(button)
        end
    else
        if button.status.current<HealBot_Unit_Status["DEBUFFBARCOL"] then button.status.current=HealBot_Unit_Status["CHECK"] end
        erButton.buff=false
        HealBot_Action_UpdateHealthButton(button)
    end
      --HealBot_setCall("HealBot_Action_UpdateBuffButton")
end

local ripHasRes={}
local ripHadRes={}
function HealBot_Action_UpdateTheDeadButton(button, TimeNow)
     if HealBot_Action_IsUnitDead(button) then
        if not UnitIsDeadOrGhost(button.unit) then
            button.status.current=HealBot_Unit_Status["CHECK"]
            button.aura.check=true
            ripHasRes[button.id]=nil
            ripHadRes[button.id]=nil
            if button.status.unittype<11 then button.status.rangespell=HealBot_RangeSpells["HEAL"] end
            HealBot_UpdateUnitRange(button,false)
            HealBot_OnEvent_UnitHealth(button)
            HealBot_Action_UpdateBackgroundButton(button)
            if UnitIsUnit(button.unit,"player") then 
                HealBot_Data["PALIVE"]=true
                HealBot_Action_ResetActiveUnitStatus() 
            end
            if HealBot_Action_luVars["pluginTimeToLive"] and button.status.plugin then HealBot_Plugin_TimeToLive_UnitUpdate(button, false) end
            button.text.nameupdate=true
            HealBot_Text_setNameTag(button)
            HealBot_Text_UpdateText(button)
            button.status.refresh=true
            HealBot_Aux_ClearResBar(button)
        elseif UnitHasIncomingResurrection(button.unit) or HealBot_MassRes() then
            if not ripHasRes[button.id] then
                if HEALBOT_GAME_VERSION>3 then
                    ripHasRes[button.id]=TimeNow+7
                else
                    ripHasRes[button.id]=TimeNow+8.5
                end
                button.status.current=HealBot_Unit_Status["RES"]
                button.text.nameupdate=true
                HealBot_Text_setNameTag(button)
                HealBot_Text_UpdateText(button)
                if HealBot_Action_luVars["pluginTimeToLive"] and button.status.plugin then HealBot_Plugin_TimeToLive_UnitUpdate(button, 1) end
                HealBot_Aux_UpdateResBar(button, HEALBOT_WORD_RESURRECTION, TimeNow*1000, (ripHasRes[button.id]+1.5)*1000, false)
            end
        elseif ripHasRes[button.id] and ripHasRes[button.id]<TimeNow then
            ripHasRes[button.id]=nil
            ripHadRes[button.id]=TimeNow+85
            button.text.nameupdate=true
            HealBot_Text_UpdateText(button)
            if HealBot_Action_luVars["pluginTimeToLive"] and button.status.plugin then HealBot_Plugin_TimeToLive_UnitUpdate(button, 2) end
            HealBot_Aux_UpdateResBar(button, HEALBOT_WORDS_PENDING, TimeNow*1000, ripHadRes[button.id]*1000, true)
        else
            ripHasRes[button.id]=nil
            if ripHadRes[button.id] and ripHadRes[button.id]<TimeNow then
                ripHadRes[button.id]=nil
                button.status.current=HealBot_Unit_Status["DEAD"]
                button.text.nameupdate=true
                HealBot_Text_setNameTag(button)
                HealBot_Text_UpdateText(button)
                if HealBot_Action_luVars["pluginTimeToLive"] and button.status.plugin then HealBot_Plugin_TimeToLive_UnitUpdate(button, false) end
                HealBot_Aux_UpdateResBar(button, HEALBOT_DEAD_LABEL)
            end
        end
    elseif UnitIsDeadOrGhost(button.unit) and not UnitIsFeignDeath(button.unit) then
        button.status.current=HealBot_Unit_Status["DEAD"]
        button.aura.buff.nextcheck=false
        button.text.nameupdate=true
        HealBot_Text_setNameTag(button)
        HealBot_Text_UpdateText(button)
        HealBot_Action_setState(button, true)
        if button.aura.debuff.name then  
            HealBot_Aura_ClearDebuff(button)
        end
        if button.aggro.status>0 then
            HealBot_Aggro_UpdateUnit(button,false,0,0,"",0,"")
        end
        HealBot_Aura_RemoveIcons(button, GetTime())
        if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWCLASS"] then
            HealBot_Action_SetClassIconTexture(button)
        end
        if Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][button.frame]["SHOW"] then 
            HealBot_OnEvent_RaidTargetUpdate(button)
        end
        if button.status.unittype<11 then button.status.rangespell=HealBot_RangeSpells["RES"] end
        HealBot_UpdateUnitRange(button,false)
        HealBot_OnEvent_UnitHealth(button)
        HealBot_Action_UpdateBackgroundButton(button)
        if button.health.incoming>0 then HealBot_Action_UpdateHealsInButton(button) end
        if button.health.absorbs>0 then HealBot_Action_UpdateAbsorbsButton(button) end
        HealBot_Aggro_ClearUnitAggro(button)
        HealBot_Aux_clearAllBars(button)
        if UnitIsUnit(button.unit,"player") then 
            HealBot_Data["PALIVE"]=false
            HealBot_Action_ResetActiveUnitStatus() 
        end
        HealBot_Action_UpdateDebuffButton(button)
		--HealBot_Action_EmergBarCheck(button, true)
        if HealBot_Action_luVars["pluginTimeToLive"] and button.status.plugin then HealBot_Plugin_TimeToLive_UnitUpdate(button, false) end
        HealBot_Aux_UpdateResBar(button, HEALBOT_DEAD_LABEL)
        if button.status.range<1 then
            HealBot_Aux_UpdateOORBar(button)
        end
    end
      --HealBot_setCall("HealBot_Action_UpdateTheDeadButton")
end

function HealBot_Action_IsUnitDead(button, guid)
    if button then
        if button.status.current>HealBot_Unit_Status["DEBUFFBARCOL"] and button.status.current<HealBot_Unit_Status["DC"] then
            return true
        end
    else
        local unit=HealBot_Panel_RaidUnitGUID(guid)
        if unit and UnitExists(unit) then
            local button=HealBot_Unit_Button[unit] or HealBot_Private_Button[unit]
            if button and button.status.current>HealBot_Unit_Status["DEBUFFBARCOL"] and button.status.current<HealBot_Unit_Status["DC"] then
                return true
            end
        end
    end
    return false
end

local auhbPtc=0
local auhbHcT=0
function HealBot_Action_UpdateHealthButton(button)
    --if not HealBot_Action_luVars["TestBarsOn"] then 
        if button.status.current<HealBot_Unit_Status["DEAD"] then
            auhbHcT = button.health.current/button.health.max
            auhbPtc=floor(auhbHcT*1000)
            HealBot_Action_BarColourPctSet(button, auhbHcT)
            if button.status.current<HealBot_Unit_Status["BUFFBARCOL"] then 
                if (Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HLTH"] >= 2) then
                    if (Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HLTH"] == 2) then
                        button.status.r,button.status.g,button.status.b = button.text.r,button.text.g,button.text.b
                    else
                        button.status.r=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HR"]
                        button.status.g=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HG"]
                        button.status.b=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HB"]
                    end
                else
                    button.status.r, button.status.g = button.health.rcol, button.health.gcol
                    button.status.b=0
                end
                if button.aggro.status==3 or HealBot_AlwaysEnabled[button.guid] or auhbHcT<=button.health.alert then
                    if button.status.current<HealBot_Unit_Status["BUFFNOCOL"] then
                        if button.status.unittype<11 then button.status.rangespell=HealBot_RangeSpells["HEAL"] end
                        HealBot_UpdateUnitRange(button,false)
                    end
                    if button.status.range==1 then
                        button.status.alpha=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"], 1)
                        if button.status.current<HealBot_Unit_Status["BUFFNOCOL"] then button.status.current=HealBot_Unit_Status["ENABLEDIR"] end
                    else
                        button.status.alpha=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["ORA"], 1)
                        if button.status.current<HealBot_Unit_Status["BUFFNOCOL"] then button.status.current=HealBot_Unit_Status["ENABLEDOOR"] end
                    end
                    HealBot_Action_setState(button, true)
                else
                    if button.status.current<HealBot_Unit_Status["BUFFNOCOL"] then button.status.current=HealBot_Unit_Status["DISABLED"] end
                    button.status.alpha=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["DISA"], 1)
                    HealBot_Action_setState(button, false)
                end
                HealBot_Action_UpdateHealthStatusBarColor(button)
            end
            if Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BACK"]==1 then
                button.gref["Back"]:SetStatusBarColor(button.health.rcol, button.health.gcol,0,HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BA"], 1.5));
            end
        else
            auhbPtc=0
            button.health.current=0
            button.mana.current=0
            button.health.init=true
            button.mana.init=true
            button.gref["Bar"]:SetStatusBarColor(0.2,0.2,0.2,0.4);
        end
        HealBot_Text_setHealthText(button)
        if button.gref["Bar"]:GetValue()~=auhbPtc then
            button.health.hptc=auhbPtc
            if button.health.init or not HealBot_Action_luVars["FluidInUse"] then
                button.gref["Bar"]:SetValue(auhbPtc)
                button.health.init=false
            else
                HealBot_Action_setFluid_BarButtons(button)
            end
            if button.health.incoming>0 then HealBot_Action_UpdateHealsInButton(button) end
            if button.health.absorbs>0 then HealBot_Action_UpdateAbsorbsButton(button) end
        end
        HealBot_Action_EmergBarCheck(button)
    --end
      --HealBot_setCall("HealBot_Action_UpdateHealthButton")
end

function HealBot_Action_BarColourAlpha(button, a, dMult)
    if HealBot_Action_luVars["FocusGroups"]==2 and button.status.unittype==5 and not HealBot_Action_luVars["FGroups"][button.group] then
        a=a/(HealBot_Action_luVars["FGDimming"]*dMult)
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
    HealBot_Text_UpdateButtons()
    HealBot_Panel_SetFocusGroups()
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

function HealBot_Action_BarColourPctSet(button, hlthPct)
    button.health.rcol, button.health.gcol=HealBot_Action_BarColourPct(hlthPct)
    --HealBot_setCall("HealBot_Action_BarColourPctSet")
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
        if UnitIsUnit("player", button.unit) then
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
end

function HealBot_Action_hasPowerCounter(frame)
    if HealBot_pcClass[frame] then
        return HealBot_Action_luVars["UnitPowerMax"]
    end
    return 0
end

function HealBot_Action_UpdateAllIndicators(button)
    HealBot_Action_setPowerIndicators(button)
    HealBot_Action_CheckUnitLowMana(button)
    HealBot_Aggro_IndicatorUpdate(button)
end

local hbPowerIndicator=0
function HealBot_Action_setPowerIndicators(button)
    if HealBot_pcClass[button.frame] and button.unit=="player" and button.status.current<HealBot_Unit_Status["DEAD"] then
        hbPowerIndicator=UnitPower("player", HealBot_pcClass[button.frame])
        if hbPowerIndicator==1 then
            if button.mana.power~=1 then
                button.mana.power=1
                if Healbot_Config_Skins.Indicators[Healbot_Config_Skins.Current_Skin][button.frame]["PCOL"]==1 then
                    button.gref.indicator.power[1]:SetTexture([[Interface\AddOns\HealBot\Images\indicator_red.tga]])
                end
                button.gref.indicator.power[1]:SetAlpha(1)
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
                button.gref.indicator.power[1]:SetAlpha(1)
                button.gref.indicator.power[2]:SetAlpha(1)
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
                button.gref.indicator.power[1]:SetAlpha(1)
                button.gref.indicator.power[2]:SetAlpha(1)
                button.gref.indicator.power[3]:SetAlpha(1)
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
                button.gref.indicator.power[1]:SetAlpha(1)
                button.gref.indicator.power[2]:SetAlpha(1)
                button.gref.indicator.power[3]:SetAlpha(1)
                button.gref.indicator.power[4]:SetAlpha(1)
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
                button.gref.indicator.power[1]:SetAlpha(1)
                button.gref.indicator.power[2]:SetAlpha(1)
                button.gref.indicator.power[3]:SetAlpha(1)
                button.gref.indicator.power[4]:SetAlpha(1)
                button.gref.indicator.power[5]:SetAlpha(1)
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
    --HealBot_setCall("HealBot_Action_setLowManaTrig")
end

local tCheckLowManaPct=0
function HealBot_Action_CheckUnitLowMana(button)
    if button.mana.type==0 and button.frame<10 then
        if button.status.current<HealBot_Unit_Status["DEAD"] and button.mana.max>0 and 
           Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["LOWMANA"]>1 then
            tCheckLowManaPct=floor((button.mana.current/button.mana.max)*100)
            if tCheckLowManaPct<hbLowManaTrig[button.frame][1] then
                if button.mana.ind~=1 then
                    button.mana.ind=1
                    button.gref.indicator.mana[1]:SetAlpha(1)
                    button.gref.indicator.mana[2]:SetAlpha(0)
                    button.gref.indicator.mana[3]:SetAlpha(0)
                end
            elseif tCheckLowManaPct<hbLowManaTrig[button.frame][2] then
                if button.mana.ind~=2 then
                    button.mana.ind=2
                    button.gref.indicator.mana[1]:SetAlpha(1)
                    button.gref.indicator.mana[2]:SetAlpha(1)
                    button.gref.indicator.mana[3]:SetAlpha(0)
                end
            elseif tCheckLowManaPct<hbLowManaTrig[button.frame][3] then
                if button.mana.ind~=3 then
                    button.mana.ind=3
                    button.gref.indicator.mana[1]:SetAlpha(1)
                    button.gref.indicator.mana[2]:SetAlpha(1)
                    button.gref.indicator.mana[3]:SetAlpha(1)
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
    --HealBot_setCall("HealBot_Action_CheckUnitLowMana")
end

local ooRhbX, ooRhbY, ooRhbD=0,0,-999
function HealBot_Action_ShowDirectionArrow(button, TimeNow)
    if button.status.range==0 and Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWDIR"] and
       (not Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWDIRMOUSE"] or button==(HealBot_Data["TIPBUTTON"] or "x")) then
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

local grpFrame={}
local grpFrameBar={}
local grpFrameText={}
local grpFrameStickyInd={}

function HealBot_Action_setFrameHeader(f, frameScale)
    if Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][f]["SHOW"] then
        local fWidth=grpFrame[f]:GetRight()-grpFrame[f]:GetLeft()
        local hwidth = ceil(fWidth*Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][f]["WIDTH"])
        grpFrameBar[f]:SetHeight(ceil(Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][f]["HEIGHT"]*frameScale));
        grpFrameBar[f]:SetWidth(hwidth);
        grpFrameBar[f]:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][f]["TEXTURE"]));
        grpFrameBar[f]:GetStatusBarTexture():SetHorizTile(false)
        grpFrameBar[f]:SetMinMaxValues(0,100);
        grpFrameBar[f]:SetValue(100);
        grpFrameBar[f]:SetStatusBarColor(Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][f]["R"],
                              Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][f]["G"],
                              Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][f]["B"],
                              Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][f]["A"]);
    else
        grpFrameBar[f]:SetStatusBarColor(0,0,0,0);
    end
    grpFrameBar[f]:EnableMouse(false)
    barScale = grpFrameBar[f]:GetScale();
    grpFrameBar[f]:SetScale(barScale + 0.01);
    grpFrameBar[f]:SetScale(barScale);
end

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
            grpFrameBar[x]:SetPoint("BOTTOM",grpFrame[x],"TOP",0,-2)
            grpFrameText[x]=grpFrameBar[x]:CreateFontString("f"..x.."_HealBot_Action_Title", "ARTWORK", "GameFontNormal")
            local StickIndPoints={[1]="TOPLEFT",[2]="TOP",[3]="TOPRIGHT",[4]="TOPRIGHT",[5]="RIGHT",[6]="BOTTOMRIGHT",[7]="BOTTOMRIGHT",[8]="BOTTOM",[9]="BOTTOMLEFT",[10]="BOTTOMLEFT",[11]="LEFT",[12]="TOPLEFT"}
            for y=1,12 do
                if not grpFrameStickyInd[x] then grpFrameStickyInd[x]={} end
                grpFrameStickyInd[x][y]=CreateFrame("StatusBar", "f"..x.."_HealBot_Action_StickyInd"..y, grpFrame[x], "TextStatusBar")
                grpFrameStickyInd[x][y]:SetStatusBarTexture(LSM:Fetch('statusbar',HealBot_Default_Textures[16].name));
                grpFrameStickyInd[x][y]:SetStatusBarColor(1,1,0.25,0)
                grpFrameStickyInd[x][y]:SetPoint(StickIndPoints[y],grpFrame[x])
                grpFrameStickyInd[x][y]:SetMinMaxValues(0,100);
                grpFrameStickyInd[x][y]:SetValue(100);
                if (y>3 and y<7) or (y>9) then
                    grpFrameStickyInd[x][y]:SetOrientation("VERTICAL")
                    grpFrameStickyInd[x][y]:SetHeight(25);
                    grpFrameStickyInd[x][y]:SetWidth(1);
                else
                    grpFrameStickyInd[x][y]:SetOrientation("HORIZONTAL")
                    grpFrameStickyInd[x][y]:SetHeight(1);
                    grpFrameStickyInd[x][y]:SetWidth(25);
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
            if Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][frame]["AUTOCLOSE"]==3 then
                PlaySound(SOUNDKIT.IG_ABILITY_OPEN)
            end
        end
        HealBot_Skins_ResetSkin("frameheader",nil,frame)
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
        if Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][frame]["AUTOCLOSE"]==3 then
            PlaySound(SOUNDKIT.IG_ABILITY_CLOSE)
        end
    end
end

function HealBot_Action_ResetUnitStatus(immediate)
    for _,xButton in pairs(HealBot_Unit_Button) do
        xButton.status.refresh=true
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        xButton.status.refresh=true
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        xButton.status.refresh=true
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        xButton.status.refresh=true
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        xButton.status.refresh=true
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        xButton.status.refresh=true
    end
    if immediate then HealBot_fastUpdateEveryFrame(2) end
    --HealBot_setCall("HealBot_Action_ResetUnitStatus")
end

function HealBot_Action_ResetActiveUnitStatus()
    for xUnit,xButton in pairs(HealBot_Unit_Button) do
        if xButton.status.current<HealBot_Unit_Status["DC"] and xButton.status.current>HealBot_Unit_Status["DISABLED"] then
            xButton.status.refresh=true
        end
    end
    for xUnit,xButton in pairs(HealBot_Private_Button) do
        if xButton.status.current<HealBot_Unit_Status["DC"] and xButton.status.current>HealBot_Unit_Status["DISABLED"] then
            xButton.status.refresh=true
        end
    end
    for xUnit,xButton in pairs(HealBot_Pet_Button) do
        if xButton.status.current<HealBot_Unit_Status["DC"] and xButton.status.current>HealBot_Unit_Status["DISABLED"] then
            xButton.status.refresh=true
        end
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        if xButton.status.current<HealBot_Unit_Status["DC"] and xButton.status.current>HealBot_Unit_Status["DISABLED"] then
            xButton.status.refresh=true
        end
    end
    for xUnit,xButton in pairs(HealBot_Extra_Button) do
        if xButton.status.current<HealBot_Unit_Status["DC"] and xButton.status.current>HealBot_Unit_Status["DISABLED"] then
            xButton.status.refresh=true
        end
    end
    HealBot_fastUpdateEveryFrame(1)
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

local hbEventFuncs={["UNIT_AURA"]=HealBot_Check_UnitAura,
                    ["UNIT_INVENTORY_CHANGED"]=HealBot_OnEvent_InvChange,
                    ["UNIT_HEALTH"]=HealBot_OnEvent_UnitHealth,
                    ["UNIT_MAXHEALTH"]=HealBot_OnEvent_UnitHealth,
                    ["UNIT_THREAT_SITUATION_UPDATE"]=HealBot_OnEvent_UnitThreat,
                    ["UNIT_THREAT_LIST_UPDATE"]=HealBot_OnEvent_UnitThreat,
                    ["UNIT_HEAL_PREDICTION"]=HealBot_HealsInUpdate,
                    ["UNIT_ABSORB_AMOUNT_CHANGED"]=HealBot_AbsorbsUpdate,
                    ["UNIT_POWER_UPDATE"]=HealBot_OnEvent_UnitMana,
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
                    ["UNIT_NAME_UPDATE"]=HealBot_UpdateUnitGUIDChange,
                    ["UNIT_DISPLAYPOWER"]=HealBot_OnEvent_UnitManaUpdate,
                    ["UNIT_CONNECTION"]=HealBot_SetUnitDisconnect,
                    ["PLAYER_SPECIALIZATION_CHANGED"]=HealBot_OnEvent_SpecChange,
                   }
function HealBot_Action_InitButton(button)
    erButton=HealBot_Emerg_Button[button.id]
    button.aura={}
    button.aura.buff={}
    button.aura.buff.recheck={}
    button.aura.debuff={}
    button.status={}
    button.update={}
    button.checks={}
    button.health={}
    button.spells={}
    button.aggro={}
    button.mana={}
    button.power={}
    button.text={}
    button.icon={}
    button.attribs={["Emerg"]={},["Enemy"]={},["Enabled"]={}}
    erButton.attribs={["Emerg"]={},["Enemy"]={},["Enabled"]={}}
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
    button.gref["Top"]=_G["HealBot_Action_HealUnit"..button.id.."Bar7"]
    button.gref["Top"]:UnregisterAllEvents()
    button.gref["Top"]:SetValue(100)
    button.gref["Top"]:SetMinMaxValues(0,100)
    button.gref["Top"]:SetStatusBarColor(0, 0, 0, 0)
    button.gref["Absorb"]=_G["HealBot_Action_HealUnit"..button.id.."Bar6"]
    button.gref["Absorb"]:UnregisterAllEvents()
    button.gref["Absorb"]:SetMinMaxValues(0,1000)
    button.gref["Absorb"]:SetValue(0)
    button:Enable();
    erButton:Enable();
    button.gref.aux[1]=_G["HealBot_Action_HealUnit"..button.id.."Aux1"]
    button.gref.aux[2]=_G["HealBot_Action_HealUnit"..button.id.."Aux2"]
    button.gref.aux[3]=_G["HealBot_Action_HealUnit"..button.id.."Aux3"]
    button.gref.aux[4]=_G["HealBot_Action_HealUnit"..button.id.."Aux4"]
    button.gref.aux[5]=_G["HealBot_Action_HealUnit"..button.id.."Aux5"]
    button.gref.aux[6]=_G["HealBot_Action_HealUnit"..button.id.."Aux6"]
    button.gref.aux[7]=_G["HealBot_Action_HealUnit"..button.id.."Aux7"]
    button.gref.aux[8]=_G["HealBot_Action_HealUnit"..button.id.."Aux8"]
    button.gref.aux[9]=_G["HealBot_Action_HealUnit"..button.id.."Aux9"]
    button.gref.auxtxt[1]=_G["HealBot_Action_HealUnit"..button.id.."Aux1_Txt"]
    button.gref.auxtxt[2]=_G["HealBot_Action_HealUnit"..button.id.."Aux2_Txt"]
    button.gref.auxtxt[3]=_G["HealBot_Action_HealUnit"..button.id.."Aux3_Txt"]
    button.gref.auxtxt[4]=_G["HealBot_Action_HealUnit"..button.id.."Aux4_Txt"]
    button.gref.auxtxt[5]=_G["HealBot_Action_HealUnit"..button.id.."Aux5_Txt"]
    button.gref.auxtxt[6]=_G["HealBot_Action_HealUnit"..button.id.."Aux6_Txt"]
    button.gref.auxtxt[7]=_G["HealBot_Action_HealUnit"..button.id.."Aux7_Txt"]
    button.gref.auxtxt[8]=_G["HealBot_Action_HealUnit"..button.id.."Aux8_Txt"]
    button.gref.auxtxt[9]=_G["HealBot_Action_HealUnit"..button.id.."Aux9_Txt"]
    for x=1,9 do
        button.gref.aux[x]:UnregisterAllEvents()
        button.gref.aux[x]:SetMinMaxValues(0,1000)
    end
    button.gref.txt["text"]=_G["HealBot_Action_HealUnit"..button.id.."Bar_text"]
    button.gref.txt["text2"]=_G["HealBot_Action_HealUnit"..button.id.."Bar_text2"]
    button.gref.icon["Icontm1"]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Icontm1"]
    button.gref.icon["Icontm2"]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Icontm2"]
    button.gref.icon["Icontm3"]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Icontm3"]
    button.gref.icon[1]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Icon1"]
    button.gref.iconf[1]=_G["HealBot_Action_HealUnit"..button.id.."Icon1"]
    button.gref.icon[2]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Icon2"]
    button.gref.iconf[2]=_G["HealBot_Action_HealUnit"..button.id.."Icon2"]
    button.gref.icon[3]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Icon3"]
    button.gref.iconf[3]=_G["HealBot_Action_HealUnit"..button.id.."Icon3"]
    button.gref.icon[4]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Icon4"]
    button.gref.iconf[4]=_G["HealBot_Action_HealUnit"..button.id.."Icon4"]
    button.gref.icon[5]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Icon5"]
    button.gref.iconf[5]=_G["HealBot_Action_HealUnit"..button.id.."Icon5"]
    button.gref.icon[6]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Icon6"]
    button.gref.iconf[6]=_G["HealBot_Action_HealUnit"..button.id.."Icon6"]
    button.gref.icon[7]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Icon7"]
    button.gref.iconf[7]=_G["HealBot_Action_HealUnit"..button.id.."Icon7"]
    button.gref.icon[8]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Icon8"]
    button.gref.iconf[8]=_G["HealBot_Action_HealUnit"..button.id.."Icon8"]
    button.gref.icon[9]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Icon9"]
    button.gref.iconf[9]=_G["HealBot_Action_HealUnit"..button.id.."Icon9"]
    button.gref.icon[10]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Icon10"]
    button.gref.iconf[10]=_G["HealBot_Action_HealUnit"..button.id.."Icon10"]
    button.gref.icon[11]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Icon11"]
    button.gref.iconf[11]=_G["HealBot_Action_HealUnit"..button.id.."Icon11"]
    button.gref.icon[12]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Icon12"]
    button.gref.iconf[12]=_G["HealBot_Action_HealUnit"..button.id.."Icon12"]
    button.gref.icon[51]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Icon51"]
    button.gref.iconf[51]=_G["HealBot_Action_HealUnit"..button.id.."Icon51"]
    button.gref.icon[52]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Icon52"]
    button.gref.iconf[52]=_G["HealBot_Action_HealUnit"..button.id.."Icon52"]
    button.gref.icon[53]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Icon53"]
    button.gref.iconf[53]=_G["HealBot_Action_HealUnit"..button.id.."Icon53"]
    button.gref.icon[54]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Icon54"]
    button.gref.iconf[54]=_G["HealBot_Action_HealUnit"..button.id.."Icon54"]
    button.gref.icon[55]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Icon55"]
    button.gref.iconf[55]=_G["HealBot_Action_HealUnit"..button.id.."Icon55"]
    button.gref.icon[56]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Icon56"]
    button.gref.iconf[56]=_G["HealBot_Action_HealUnit"..button.id.."Icon56"]
    button.gref.icon[57]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Icon57"]
    button.gref.iconf[57]=_G["HealBot_Action_HealUnit"..button.id.."Icon57"]
    button.gref.icon[58]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Icon58"]
    button.gref.iconf[58]=_G["HealBot_Action_HealUnit"..button.id.."Icon58"]
    button.gref.icon[91]=_G["HealBot_Action_HealUnit"..button.id.."Bar7ExtraClass"]
    button.gref.icon[92]=_G["HealBot_Action_HealUnit"..button.id.."Bar7ExtraTarget"]
    button.gref.icon[93]=_G["HealBot_Action_HealUnit"..button.id.."Bar7ExtraRC"]
    button.gref.icon[94]=_G["HealBot_Action_HealUnit"..button.id.."Bar7ExtraOOR"]
    button.gref.txt.expire[1]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Expire1"]
    button.gref.txt.count[1]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Count1"]
    button.gref.txt.expire[2]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Expire2"]
    button.gref.txt.count[2]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Count2"]
    button.gref.txt.expire[3]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Expire3"]
    button.gref.txt.count[3]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Count3"]
    button.gref.txt.expire[4]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Expire4"]
    button.gref.txt.count[4]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Count4"]
    button.gref.txt.expire[5]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Expire5"]
    button.gref.txt.count[5]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Count5"]
    button.gref.txt.expire[6]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Expire6"]
    button.gref.txt.count[6]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Count6"]
    button.gref.txt.expire[7]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Expire7"]
    button.gref.txt.count[7]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Count7"]
    button.gref.txt.expire[8]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Expire8"]
    button.gref.txt.count[8]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Count8"]
    button.gref.txt.expire[9]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Expire9"]
    button.gref.txt.count[9]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Count9"]
    button.gref.txt.expire[10]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Expire10"]
    button.gref.txt.count[10]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Count10"]
    button.gref.txt.expire[11]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Expire11"]
    button.gref.txt.count[11]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Count11"]
    button.gref.txt.expire[12]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Expire12"]
    button.gref.txt.count[12]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Count12"]
    button.gref.txt.expire[51]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Expire51"]
    button.gref.txt.count[51]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Count51"]
    button.gref.txt.expire[52]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Expire52"]
    button.gref.txt.count[52]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Count52"]
    button.gref.txt.expire[53]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Expire53"]
    button.gref.txt.count[53]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Count53"]
    button.gref.txt.expire[54]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Expire54"]
    button.gref.txt.count[54]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Count54"]
    button.gref.txt.expire[55]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Expire55"]
    button.gref.txt.count[55]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Count55"]
    button.gref.txt.expire[56]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Expire56"]
    button.gref.txt.count[56]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Count56"]
    button.gref.txt.expire[57]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Expire57"]
    button.gref.txt.count[57]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Count57"]
    button.gref.txt.expire[58]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Expire58"]
    button.gref.txt.count[58]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Count58"]
    button.gref.indicator.aggro["Iconal1"]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Iconal1"]
    button.gref.indicator.aggro["Iconal2"]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Iconal2"]
    button.gref.indicator.aggro["Iconal3"]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Iconal3"]
    button.gref.indicator.aggro["Iconar1"]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Iconar1"]
    button.gref.indicator.aggro["Iconar2"]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Iconar2"]
    button.gref.indicator.aggro["Iconar3"]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Iconar3"]
    button.gref.indicator.mana[1]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Icontm1"]
    button.gref.indicator.mana[2]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Icontm2"]
    button.gref.indicator.mana[3]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Icontm3"]
    button.gref.indicator.power[1]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Iconpi1"]
    button.gref.indicator.power[2]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Iconpi2"]
    button.gref.indicator.power[3]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Iconpi3"]
    button.gref.indicator.power[4]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Iconpi4"]
    button.gref.indicator.power[5]=_G["HealBot_Action_HealUnit"..button.id.."Bar7Iconpi5"]
    for x=1,5 do
        button.gref.indicator.power[x]:SetAlpha(0);
    end
    button.skin=""
    button.frame=0
    erButton.r,erButton.g,erButton.b,erButton.a=0,0,0,0
    button:SetScript("OnEvent", function(self, event, arg1, arg2, arg3) hbEventFuncs[event](self, arg1, arg2, arg3) end)
    button.regClicks=false
    --HealBot_setCall("HealBot_Action_InitButton")
end

function HealBot_Action_UnregisterUnitEvents(button)
    button:UnregisterEvent("UNIT_AURA")
    button:UnregisterEvent("UNIT_INVENTORY_CHANGED")
    button:UnregisterEvent("UNIT_HEALTH")
    button:UnregisterEvent("UNIT_MAXHEALTH")
    HealBot_UnRegister_Aggro(button)
    HealBot_UnRegister_IncHeals(button)
    HealBot_UnRegister_Mana(button)
    button:UnregisterEvent("UNIT_PHASE")
    button:UnregisterEvent("UNIT_NAME_UPDATE")
    button:UnregisterEvent("UNIT_CONNECTION")
    button:UnregisterEvent("UNIT_SPELLCAST_START")
    button:UnregisterEvent("UNIT_SPELLCAST_CHANNEL_START")
    button:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED")
    button:UnregisterEvent("UNIT_SPELLCAST_FAILED")
    button:UnregisterEvent("UNIT_SPELLCAST_INTERRUPTED")
    button:UnregisterEvent("UNIT_SPELLCAST_CHANNEL_STOP")
    button:UnregisterEvent("UNIT_SPELLCAST_STOP")
    if HEALBOT_GAME_VERSION>3 then
        button:UnregisterEvent("UNIT_ABSORB_AMOUNT_CHANGED")
        button:UnregisterEvent("PLAYER_SPECIALIZATION_CHANGED")
    end
end

function HealBot_Action_RegisterUnitEvents(button)
    button:RegisterUnitEvent("UNIT_AURA", button.unit)
    button:RegisterUnitEvent("UNIT_HEALTH", button.unit)
    button:RegisterUnitEvent("UNIT_MAXHEALTH", button.unit)
    button:RegisterUnitEvent("UNIT_PHASE", button.unit)
    button:RegisterUnitEvent("UNIT_NAME_UPDATE", button.unit)
    button:RegisterUnitEvent("UNIT_CONNECTION", button.unit)
    button:RegisterUnitEvent("UNIT_SPELLCAST_START", button.unit)
    button:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_START", button.unit)
    button:RegisterUnitEvent("UNIT_SPELLCAST_FAILED", button.unit)
    button:RegisterUnitEvent("UNIT_SPELLCAST_INTERRUPTED", button.unit)
    button:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_STOP", button.unit)
    button:RegisterUnitEvent("UNIT_SPELLCAST_STOP", button.unit)
    if HEALBOT_GAME_VERSION>3 then
        button:RegisterUnitEvent("UNIT_ABSORB_AMOUNT_CHANGED", button.unit)
        button:RegisterUnitEvent("PLAYER_SPECIALIZATION_CHANGED", button.unit)
    end
    if UnitIsUnit(button.unit,"player") then
        button:RegisterUnitEvent("UNIT_INVENTORY_CHANGED", button.unit)
        button:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", button.unit)
    end
end

local tPrepButton=""
function HealBot_Action_PrepButton(button)
    erButton=HealBot_Emerg_Button[button.id]
    if not button.guid then button.guid="nil" end
    if not button.unit then button.unit="nil" end
    button.status.role=0
    button.group=1
    button.health.init=true
    button.mana.init=true
    button.health.current=99
    button.health.max=100
    button.health.alert=1
    button.health.hptc=999
    button.health.incoming=0
    button.health.inhptc=0
    button.health.absorbs=0
    button.health.abptc=0
    button.health.overheal=0
    button.health.updhlth=false
    button.health.updincoming=false
    button.health.updabsorbs=false
    button.health.rcol=0
    button.health.gcol=0
    button.health.inhealr=0
    button.health.inhealg=0
    button.health.inhealb=0
    button.health.inheala=0
    button.health.absorbr=0
    button.health.absorbg=0
    button.health.absorbb=0
    button.health.absorba=0
    button.mana.current=0
    button.mana.max=0
    button.mana.type=0
    button.mana.ind=-1
    button.mana.power=-1
    button.mana.r=0
    button.mana.g=0
    button.mana.b=1
    button.mana.change=false
    button.status.duplicate=false
    button.status.classknown=false
    button.status.plugin=false
    button.status.current=HealBot_Unit_Status["CHECK"]
    button.status.range=1
    button.status.rangespell=HealBot_RangeSpells["HEAL"]
    button.status.unittype=1
    button.status.offline=false
    button.status.enabled=false
    button.status.summons=false
    button.status.r=0
    button.status.g=0
    button.status.b=0
    button.status.alpha=1
    button.status.dirarrowcords=0 
    button.status.dirarrowshown=0 
    button.status.update=true
    button.status.change=true
    button.status.refresh=false
    button.status.throttle=0
    button.status.switch=true
    button.status.castend=-1
    button.aura.buff.name=false
    button.aura.buff.missingbuff=false
    button.aura.buff.id=0
    button.icon.buff.count=0
    button.aura.buff.priority=99
    button.aura.buff.nextcheck=false
    button.aura.buff.nextupdate=GetTime()
    button.aura.buff.showcol=true
    button.aura.buff.colbar=false
    button.aura.buff.r=1
    button.aura.buff.g=1
    button.aura.buff.b=1
    button.aura.debuff.type=false
    button.aura.debuff.name=false
    button.aura.debuff.id=0
    button.icon.debuff.count=0
    button.icon.debuff.showcol=true
    button.aura.debuff.colbar=false
    button.aura.debuff.r=1
    button.aura.debuff.g=1
    button.aura.debuff.b=1
    button.icon.extra.targeticon=0
    button.icon.extra.classtexture=false
    button.icon.extra.readycheck=false
    button.icon.extra.oorarrow=false
    button.aura.debuff.priority=99
    button.aura.debuff.nextupdate=GetTime()
    button.aura.check=true
    button.aggro.ind=-1
    button.aggro.status=-1
    button.aggro.threatpct=0
    button.aggro.threatvalue=0
    button.aggro.mobname=""
    button.text.health="100"
    button.text.healthcomplete="100"
    button.text.inheallen=0
    button.text.overheallen=0
    button.text.aggrolen=0
    button.text.name=""
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
    button.text.ar=0
    button.text.ag=0
    button.text.ab=0
    button.text.aa=0
    button.text.classtrim="XXXX"
    button.text.nameupdate=true
    button.text.healthupdate=true
    button.spec=" "
    button.specupdate=true
    button.reset=true 
    button.gref["Bar"]:SetStatusBarColor(0, 0, 0, 0)
    button.gref["Bar"]:SetValue(1000)
    button.gref["InHeal"]:SetStatusBarColor(0, 0, 0, 0)
    button.gref["Back"]:SetStatusBarColor(0, 0, 0, 0)
    button.gref["Absorb"]:SetStatusBarColor(0, 0, 0, 0)
    for x=1,9 do
        button.aux[x]["FLUID"]=-1
        button.aux[x]["TIMED"]=-1
        button.aux[x]["TIMEDH2L"]=-1
        button.aux[x]["TIMEDL2H"]=-1
        button.aux[x]["FLUIDSTATE"]=-1
        button.aux[x]["FLUIDTEXT"]=-1
        button.aux[x]["FLASH"]=false
        button.aux[x]["STATIC"]=false
        button.gref.aux[x]:SetStatusBarColor(0, 0, 0, 0)
    end
    erButton.state=0
    erButton.bar:SetStatusBarColor(0,0,0,0)
    HealBot_Action_SetAllButtonAttribs(button,"Enabled")
    HealBot_Action_SetAllButtonAttribs(erButton,"Emerg")
    HealBot_Action_UnregisterUnitEvents(button)
    --HealBot_setCall("HealBot_Action_PrepButton")
end

local tryId,freeId,fromId,buttonId=1,0,0.0
HealBot_ActiveButtons[0]=1
HealBot_Action_luVars["ButtonHWM"]=1
function HealBot_Action_FreeId()
    tryId,freeId=HealBot_ActiveButtons[0],0
    if not HealBot_ActiveButtons[tryId] then
        freeId=tryId
    else
        if tryId<HealBot_Globals.AutoCacheSize then
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
    HealBot_ButtonIndex[buttonId]=ghb
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
    return ghb
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
    for i=1,HealBot_Action_luVars["ButtonHWM"] do
        local ghb=_G["HealBot_Action_HealUnit"..i]
        if ghb then
            if HealBot_Action_luVars["resetSkin"] then ghb.skinreset=true end
            if HealBot_Action_luVars["resetIcon"] then ghb.icon.reset=true end
            if HealBot_Action_luVars["resetIndicator"] then ghb.indreset=true end
            --ghb.reset=true
        end
    end
    HealBot_Panel_ResetHeaders()
    HealBot_setOptions_Timer(188)
    HealBot_Action_luVars["resetSkin"]=false
    HealBot_Action_luVars["resetIcon"]=false
    HealBot_Action_luVars["resetIndicator"]=false
end

local HealBot_Keys_List = {"","Shift","Ctrl","Alt","Alt-Shift","Ctrl-Shift","Alt-Ctrl","Alt-Ctrl-Shift"}
local hbAttribsMinReset = {}
local hbAttribsFramesMinReset = {}
local HB_button,HB_prefix=nil,nil
local showHBmenu=nil

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
        elseif cText == HEALBOT_TELL then
            cID="G"
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
            cText=HEALBOT_TELL
        end
    end
    --HealBot_setCall("HealBot_Action_SpellCmdText")
    return cText
end

function HealBot_Action_SetSpell(cType, cKey, sText, frame)
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
                    if itemID then sText = "I:"..itemID end
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
                elseif sType == "I" then
                    vSpellText=GetItemInfo(sID)
                else
                    vSpellText=GetSpellInfo(sID)
                    if HEALBOT_GAME_VERSION<4 then
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

function HealBot_Action_IconSpellPattern(click)
    local x=HealBot_Action_CurrentModKeys()
    if x then
        x=x..click
    else
        x=click
    end
    x=x..HealBot_Config.CurrentSpec
    return HealBot_Action_GetSpell("ICON", x)
end

local hbModKeys=false
function HealBot_Action_CurrentModKeys()
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
    return hbModKeys
end

function HealBot_Action_SpellPattern(click)
    local sPattern=nil
    local x=HealBot_Action_CurrentModKeys()
    if x then
        x = x..click
    else
        x = click
    end
    x=x..HealBot_Config.CurrentSpec
    sPattern=HealBot_Action_GetSpell(string.upper(HealBot_Data["TIPTYPE"]), x)
    return sPattern
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

function HealBot_Action_ToggelMyFriend(unit)
    local xGUID=UnitGUID(unit)
    if xGUID then
        if HealBot_Config.MyFriend==xGUID then
            HealBot_Config.MyFriend="x"
        else
            HealBot_Config.MyFriend=xGUID
        end
    end
    HealBot_AuraCheck(unit)
    --HealBot_setCall("HealBot_Action_ToggelMyFriend")
end

function HealBot_Action_hbmenuFrame_DropDown_Initialize(self,level,menuList)
    local info
    level = level or 1;
    if level==1 then
        info = UIDropDownMenu_CreateInfo();
        info.isTitle = true
        info.text = HealBot_GetUnitName(self.unit)
        UIDropDownMenu_AddButton(info, 1);
        
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
        info.func = function() HealBot_Action_ToggelMyFriend(self.unit, false); end;
        UIDropDownMenu_AddButton(info, 1);

        if UnitIsPlayer(self.unit) then
            info = UIDropDownMenu_CreateInfo();
            info.notCheckable = true;
            info.text = HEALBOT_WORDS_CUSTOMNAME
            info.hasArrow = true; 
            info.menuList = "cNames"
            UIDropDownMenu_AddButton(info, 1);

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
        end

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

function HealBot_Action_AlterSpell2Macro(spellName, spellTar, spellTrin1, spellTrin2, spellAvoidBC, unit, status)
    local smName=""
    local scText=""
    local spellType="help"
    if status=="Enemy" then spellType="harm" end
    scText="/cast [@"..unit..","..spellType.."] "..spellName.."\n"

    if HealBot_Globals.MacroSuppressError==1 then smName=smName..'/hb se3\n' end
    if HealBot_Globals.MacroSuppressSound==1 then smName=smName..'/hb se1\n' end
    if spellTar then smName=smName.."/target "..unit.."\n" end
    if spellTrin1 then smName=smName.."/use 13\n" end
    if spellTrin2 then smName=smName.."/use 14\n" end
    if HealBot_Config.MacroUse10==1 then smName=smName.."/use 10\n" end
    if HealBot_Globals.MacroSuppressSound==1 then smName=smName.."/hb se2\n" end
    if HealBot_Globals.MacroSuppressError==1 then smName=smName..'/hb se4\n' end
    smName=smName..scText
    if spellAvoidBC then smName=smName.."/use 4\n" end
    if strlen(smName)>255 then
        smName=""
        if HealBot_Globals.MacroSuppressSound==1 then smName=smName.."/hb se1\n" end
        if spellTar then smName=smName.."/target "..unit.."\n" end
        if spellTrin1 then smName=smName.."/use 13\n" end
        if spellTrin2 then smName=smName.."/use 14\n" end
        if HealBot_Config.MacroUse10==1 then smName=smName.."/use 10\n" end
        if HealBot_Globals.MacroSuppressSound==1 then smName=smName.."/hb se2\n" end
        smName=smName..scText
        if spellAvoidBC then smName=smName.."/use 4\n" end
        if strlen(smName)>255 then
            smName=""
            if spellTar then smName=smName.."/target "..unit.."\n" end
            if spellTrin1 then smName=smName.."/use 13\n" end
            if spellTrin2 then smName=smName.."/use 14\n" end
            if HealBot_Config.MacroUse10==1 then smName=smName.."/use 10\n" end
            smName=smName..scText
            if spellAvoidBC then smName=smName.."/use 4\n" end
            if strlen(smName)>255 then
                smName=""
                if spellTrin1 then smName=smName.."/use 13\n" end
                if spellTrin2 then smName=smName.."/use 14\n" end
                smName=smName..scText
                if spellAvoidBC then smName=smName.."/use 4\n" end
                if strlen(smName)>255 then
                    smName=spellName
                end
            end
        end
    end
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
local tabconcat=table.concat
local hbAttribsMinResetElement=""

function HealBot_Action_ReturnAttribsFramesMinReset(button, prefix, status, bno)
    tAttribConcat[1]=prefix
    tAttribConcat[2]=bno
    hbAttribsMinResetElement=tabconcat(tAttribConcat,"",1,2)
    return button.attribs[status][hbAttribsMinResetElement]
end

function HealBot_Action_UpdateAttribsMinReset(button, prefix, status, bno, value)
    tAttribConcat[1]=prefix
    tAttribConcat[2]=bno
    hbAttribsMinResetElement=tabconcat(tAttribConcat,"",1,2)
    button.attribs[status][hbAttribsMinResetElement]=value
end

function HealBot_Action_DoSetButtonAttrib(button,status,j,unit,HB_prefix,buttonType,sName,sTar,sTrin1,sTrin2,AvoidBC,sType)
    if sName then
        local mId=GetMacroIndexByName(sName)
        if strlower(sName)==strlower(HEALBOT_DISABLED_TARGET) then
            button:SetAttribute(HB_prefix..buttonType..j, "target"..j);
            button:SetAttribute(HB_prefix.."type"..j, "target")
            button:SetAttribute(HB_prefix.."type-target"..j, "target")
            HealBot_Action_UpdateAttribsMinReset(button, HB_prefix, status, j, 2)
        elseif strlower(sName)==strlower(HEALBOT_FOCUS) then
            button:SetAttribute(HB_prefix..buttonType..j, "focus"..j);
            button:SetAttribute(HB_prefix.."type"..j, "focus")
            button:SetAttribute(HB_prefix.."type-focus"..j, "focus")
            HealBot_Action_UpdateAttribsMinReset(button, HB_prefix, status, j, 2)
        elseif strlower(sName)==strlower(HEALBOT_ASSIST) then
            button:SetAttribute(HB_prefix..buttonType..j, "assist"..j);
            button:SetAttribute(HB_prefix.."type"..j, "assist")
            button:SetAttribute(HB_prefix.."type-assist"..j, "assist")
            HealBot_Action_UpdateAttribsMinReset(button, HB_prefix, status, j, 2)
        elseif strlower(sName)==strlower(HEALBOT_STOP) then
            button:SetAttribute(HB_prefix..buttonType..j, nil);
            button:SetAttribute(HB_prefix.."type"..j, "macro")
            button:SetAttribute(HB_prefix.."macrotext"..j, "/stopcasting")
            HealBot_Action_UpdateAttribsMinReset(button, HB_prefix, status, j, 2)
        elseif strlower(sName)==strlower(HEALBOT_TELL) then
            local mText='/script local n=UnitName("hbtarget");SendChatMessage("hbMSG","WHISPER",nil,n)'
            mText=string.gsub(mText,"hbtarget",unit)
            mText=string.gsub(mText,"hbMSG", strtrim(strsub(sName,5)))
            button:SetAttribute(HB_prefix..buttonType..j, nil);
            button:SetAttribute(HB_prefix.."type"..j, "macro")
            button:SetAttribute(HB_prefix.."macrotext"..j, mText)
        elseif strlower(sName)==strlower(HEALBOT_MENU) then
            button:SetAttribute(HB_prefix..buttonType..j, nil);
            button:SetAttribute(HB_prefix.."type"..j, "togglemenu")
            HealBot_Action_UpdateAttribsMinReset(button, HB_prefix, status, j, 2)
        elseif strlower(sName)==strlower(HEALBOT_HBMENU) then
            button:SetAttribute(HB_prefix..buttonType..j, nil);
            button:SetAttribute(HB_prefix.."type"..j, "showhbmenu")
            showHBmenu = function()
                if UnitExists(unit) then
                    local HBFriendsDropDown = CreateFrame("Frame", "HealBot_Action_hbmenuFrame_DropDown", UIParent, "UIDropDownMenuTemplate");
                    HBFriendsDropDown.unit = unit
                    HBFriendsDropDown.name = HealBot_GetUnitName(unit)
                    HBFriendsDropDown.initialize = HealBot_Action_hbmenuFrame_DropDown_Initialize
                    HBFriendsDropDown.displayMode = "MENU"
                    ToggleDropDownMenu(1, nil, HBFriendsDropDown, "cursor", 10, -8)
                end
            end
            button.showhbmenu = showHBmenu
        elseif HealBot_Spell_Names[sName] then
            if sTar or sTrin1 or sTrin2 or AvoidBC then
                local mText = HealBot_Action_AlterSpell2Macro(sName, sTar, sTrin1, sTrin2, AvoidBC, unit, status)
                button:SetAttribute(HB_prefix..buttonType..j, nil);
                button:SetAttribute(HB_prefix.."type"..j,"macro")
                button:SetAttribute(HB_prefix.."macrotext"..j, mText)
            else
                button:SetAttribute(HB_prefix..buttonType..j, sType..j);
                button:SetAttribute(HB_prefix.."type-"..sType..j, "spell");
                button:SetAttribute(HB_prefix.."spell-"..sType..j, sName);
                HealBot_Action_UpdateAttribsMinReset(button, HB_prefix, status, j, 2)
            end
        elseif mId ~= 0 then
            local _,_,mText=GetMacroInfo(mId)
            if HealBot_UnitPet(unit) and UnitExists(HealBot_UnitPet(unit)) then
                mText=string.gsub(mText,"hbtargetpet",HealBot_UnitPet(unit))
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
            HealBot_Action_UpdateAttribsMinReset(button, HB_prefix, status, j, 2)
        else
            if sTar or sTrin1 or sTrin2 or AvoidBC then
                local mText = HealBot_Action_AlterSpell2Macro(sName, sTar, sTrin1, sTrin2, AvoidBC, unit, status)
                button:SetAttribute(HB_prefix..buttonType..j, nil);
                button:SetAttribute(HB_prefix.."type"..j,"macro")
                button:SetAttribute(HB_prefix.."macrotext"..j, mText)
            else
                button:SetAttribute(HB_prefix..buttonType..j, sType..j);
                button:SetAttribute(HB_prefix.."type-"..sType..j, "spell");
                button:SetAttribute(HB_prefix.."spell-"..sType..j, sName);
                HealBot_Action_UpdateAttribsMinReset(button, HB_prefix, status, j, 2)
            end
        end
        button:SetAttribute(HB_prefix.."checkselfcast"..j, "false")
        return true
    else
        button:SetAttribute(HB_prefix..buttonType..j, nil);
        HealBot_Action_UpdateAttribsMinReset(button, HB_prefix, status, j, 1)
        return false
    end
end

function HealBot_Action_SetButtonAttrib(button,bbutton,bkey,status,j,unit)
    local HB_prefix = "";
    local buttonType="helpbutton"
    local sType="heal"
    if strlen(bkey)>1 then
        HB_prefix = strlower(bkey).."-"
    end
    local HB_combo_prefix = bkey..bbutton..HealBot_Config.CurrentSpec;
    local sName,sTar,sTrin1,sTrin2,AvoidBC=false,false,false,false
    HealBot_Action_UpdateAttribsMinReset(button, HB_prefix, status, j, false)
    if status=="Emerg" then
        sName, sTar, sTrin1, sTrin2, AvoidBC = HealBot_Action_AttribEmergSpellPattern(HB_combo_prefix)
        HealBot_Action_DoSetButtonAttrib(button,status,j,unit,HB_prefix,"harmbutton",sName,sTar,sTrin1,sTrin2,AvoidBC,"harm")
    elseif status=="Enemy" then
        sName, sTar, sTrin1, sTrin2, AvoidBC = HealBot_Action_AttribEnemySpellPattern(HB_combo_prefix)
        buttonType="harmbutton"
        sType="harm"
    else
        sName, sTar, sTrin1, sTrin2, AvoidBC = HealBot_Action_AttribSpellPattern(HB_combo_prefix)
    end
    return HealBot_Action_DoSetButtonAttrib(button,status,j,unit,HB_prefix,buttonType,sName,sTar,sTrin1,sTrin2,AvoidBC,sType)
    --HealBot_setCall("HealBot_Action_SetButtonAttrib")
end

local hbMaxMouseButtons={["Enemy"]=15,["Enabled"]=15,["Emerg"]=15}

function HealBot_Action_MaxMouseButtons(status)
    return hbMaxMouseButtons[status]
end

function HealBot_Action_SetAllButtonAttribs(button,status)
    if hbMaxMouseButtons[status]>0 then
        local hasSpells,attribSet=false,false
        for x=1,hbMaxMouseButtons[status] do
            hasSpells=false
            for y=1, getn(HealBot_Keys_List), 1 do
                if strlen(HealBot_Keys_List[y])>1 then
                    HB_prefix = strlower(HealBot_Keys_List[y]).."-"
                else
                    HB_prefix = "";
                end
                attribSet=HealBot_Action_ReturnAttribsFramesMinReset(button, HB_prefix, status, x)
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
                    if HealBot_Action_SetButtonAttrib(button,HB_button,HealBot_Keys_List[y],status,x,button.unit) then
                        hasSpells=true 
                    end
                elseif attribSet==2 then
                    hasSpells=true
                end
            end
            if hasSpells then
                hbMaxMouseButtons[status]=x
            elseif x==15 and hbMaxMouseButtons[status]==15 then 
                hbMaxMouseButtons[status]=0
            end
        end
    end
    --HealBot_AddDebug(status.." Max Mouse Buttons used = "..hbMaxMouseButtons[status])
    --HealBot_setCall("HealBot_Action_SetAllButtonAttribs")
end

function HealBot_Action_PrepSetEnabledAttribs()
    local ghb,ehb
    for i=1,HealBot_Action_luVars["ButtonHWM"] do
        ghb=_G["HealBot_Action_HealUnit"..i]
        if ghb then
            ghb.attribs["Enabled"]={}
        end
        ehb= _G["HealBot_Action_EmergUnit"..i]
        if ehb then
            ehb.attribs["Enabled"]={}
        end
    end
    hbMaxMouseButtons["Enabled"]=15
    HealBot_setOptions_Timer(9920)
end

function HealBot_Action_PrepSetEnemyAttribs()
    local ghb,ehb
    for i=1,HealBot_Action_luVars["ButtonHWM"] do
        ghb=_G["HealBot_Action_HealUnit"..i]
        if ghb then
            ghb.attribs["Enemy"]={}
        end
        ehb= _G["HealBot_Action_EmergUnit"..i]
        if ehb then
            ehb.attribs["Enemy"]={}
        end
    end
    hbMaxMouseButtons["Enemy"]=15
    HealBot_setOptions_Timer(9921)
end

function HealBot_Action_PrepSetEmergAttribs()
    local ghb,ehb
    for i=1,HealBot_Action_luVars["ButtonHWM"] do
        ghb=_G["HealBot_Action_HealUnit"..i]
        if ghb then
            ghb.attribs["Emerg"]={}
        end
        ehb= _G["HealBot_Action_EmergUnit"..i]
        if ehb then
            ehb.attribs["Emerg"]={}
        end
    end
    hbMaxMouseButtons["Emerg"]=15
    HealBot_setOptions_Timer(9922)
end

function HealBot_Action_PrepSetAllAttribs()
    local ghb,ehb
    for i=1,HealBot_Action_luVars["ButtonHWM"] do
        ghb=_G["HealBot_Action_HealUnit"..i]
        if ghb then
            ghb.attribs={["Emerg"]={},["Enemy"]={},["Enabled"]={}}
        end
        ehb= _G["HealBot_Action_EmergUnit"..i]
        if ehb then
            ehb.attribs={["Emerg"]={},["Enemy"]={},["Enabled"]={}}
        end
    end
    hbMaxMouseButtons["Enemy"]=15
    hbMaxMouseButtons["Enabled"]=15
    hbMaxMouseButtons["Emerg"]=15
    HealBot_setOptions_Timer(9920)
    HealBot_setOptions_Timer(9921)
    HealBot_setOptions_Timer(9922)
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

local tSetHealButton={}
local vEnemyUnitsWithEvents={["boss1"]=true,["boss2"]=true,["boss3"]=true,["boss4"]=true,
                             ["arena1"]=true,["arena2"]=true,["arena3"]=true,["arena4"]=true,["arena5"]=true}
function HealBot_Action_SetHealButton(unit,hbGUID,hbCurFrame,unitType,duplicate,role,preCombat)
    tSetHealButton=false
    if hbGUID then
        if unitType<5 then
            tSetHealButton=HealBot_Private_Button[unit] or HealBot_Action_CreateButton(hbCurFrame)
        elseif unitType>10 then
            tSetHealButton=HealBot_Enemy_Button[unit] or HealBot_Action_CreateButton(hbCurFrame)
        elseif unitType==8 then
            tSetHealButton=HealBot_Pet_Button[unit] or HealBot_Action_CreateButton(hbCurFrame)
        elseif unitType==7 then
            tSetHealButton=HealBot_Vehicle_Button[unit] or HealBot_Action_CreateButton(hbCurFrame)
        elseif unitType>8 then
            tSetHealButton=HealBot_Extra_Button[unit] or HealBot_Action_CreateButton(hbCurFrame)
        else
            tSetHealButton=HealBot_Unit_Button[unit] or HealBot_Action_CreateButton(hbCurFrame)
        end
        if not tSetHealButton then return nil end
        erButton=HealBot_Emerg_Button[tSetHealButton.id]
        if tSetHealButton.frame~=hbCurFrame or tSetHealButton.skin~=Healbot_Config_Skins.Current_Skin then
            tSetHealButton:ClearAllPoints()
            tSetHealButton:SetParent(grpFrame[hbCurFrame])
            erButton:ClearAllPoints()
            erButton:SetParent(grpFrame[hbCurFrame])
            tSetHealButton.frame=hbCurFrame
            tSetHealButton.icon.reset=true
            tSetHealButton.skinreset=true
            tSetHealButton.indreset=true
            tSetHealButton.reset=true
            tSetHealButton.skin=Healbot_Config_Skins.Current_Skin
        end
        
        if not tSetHealButton.regClicks then
            HealBot_Action_setRegisterForClicks(tSetHealButton)
            HealBot_Action_setRegisterForClicks(erButton)
        end

        if tSetHealButton.unit~=unit or tSetHealButton.reset or tSetHealButton.guid~=hbGUID or tSetHealButton.status.unittype~=unitType then
            tSetHealButton.reset=false
            tSetHealButton.guid=hbGUID
            tSetHealButton.unit=unit
            tSetHealButton:SetAttribute("unit", unit);
            erButton:SetAttribute("unit", unit);
            HealBot_Action_SetAllButtonAttribs(tSetHealButton,"Enemy") 
            HealBot_Action_SetAllButtonAttribs(tSetHealButton,"Enabled")
            HealBot_Action_SetAllButtonAttribs(erButton,"Emerg")
            tSetHealButton.status.unittype = unitType      -- 1=Tanks  2=Healers  3=Self  4=Private  5=Raid  6=Group
            if unitType>10 then                            -- 7=vehicle  8=pet  9=target  10=focus  11=enemy without events  12=enemy with events 
                HealBot_Enemy_Button[unit]=tSetHealButton
                if vEnemyUnitsWithEvents[unit] then
                    tSetHealButton.status.unittype = 12
                else
                    tSetHealButton.status.unittype = 11
                end
                tSetHealButton.status.rangespell=HealBot_RangeSpells["HARM"]
            else
                tSetHealButton.status.rangespell=HealBot_RangeSpells["HEAL"]
                if unitType==8 then
                    HealBot_Pet_Button[unit]=tSetHealButton
                elseif unitType==7 then
                    HealBot_Vehicle_Button[unit]=tSetHealButton
                elseif unitType<5 then
                    HealBot_Private_Button[unit]=tSetHealButton
                    hbShouldHealSomePrivateFrames[hbCurFrame]=true
                elseif unitType>8 then
                    HealBot_Extra_Button[unit]=tSetHealButton
                else
                    HealBot_Unit_Button[unit]=tSetHealButton 
                    hbShouldHealSomePlayerFrames[hbCurFrame]=true
                end
            end
            tSetHealButton.status.role=role
            HealBot_Action_ResetrCallsUnit(tSetHealButton)
            HealBot_Aura_setUnitIcons(tSetHealButton.id, unit)
            tSetHealButton.text.r,tSetHealButton.text.g,tSetHealButton.text.b=HealBot_Action_ClassColour(unit)
            tSetHealButton.text.nameupdate=true
            tSetHealButton.text.healthupdate=true
            tSetHealButton.health.init=true
            tSetHealButton.mana.init=true
            tSetHealButton.status.range=1
            tSetHealButton.status.change=true
            tSetHealButton.status.throttle=0
            HealBot_HealthAlertLevel(preCombat, tSetHealButton)
            HealBot_Action_RegisterUnitEvents(tSetHealButton)
        end
        tSetHealButton.status.update=true
        HealBot_Action_SetHealButtonAuraCols(tSetHealButton)
        if tSetHealButton.skinreset or tSetHealButton.icon.reset or tSetHealButton.indreset then
            HealBot_Skins_ResetSkin("bar",tSetHealButton)
        elseif hbCurFrame==10 then
            HealBot_Skins_ResetSkinWidth(tSetHealButton)
        end
        tSetHealButton.status.duplicate=duplicate
    else
        return nil
    end
    --HealBot_setCall("HealBot_Action_SetHealButton")
    return tSetHealButton
end

local testBarsDat={["cnt"]=0, ["targetCnt"]=0, ["buffId"]=0,["debuffId"]=50}
local testBarsManaClass={["DRUI"]=true,["MAGE"]=true,["PALA"]=true,["PRIE"]=true,["SHAM"]=true,["WARL"]=true}
function HealBot_Action_SetTestButton(hbCurFrame, unitText, unitRole, unitClass)
    local thb=HealBot_Unit_Button[unitText] or HealBot_Action_CreateButton(hbCurFrame)
    if thb then
        if tSetHealButton.regClicks then
            HealBot_Action_setRegisterForClicks(thb)
        end
        if thb.frame~=hbCurFrame then
            thb:ClearAllPoints()
            thb:SetParent(grpFrame[hbCurFrame])
            thb.frame=hbCurFrame
        end
        thb.unit=unitText
        thb.guid="TestBar"
        HealBot_Action_ResetrCallsUnit(thb)
        HealBot_Unit_Button[unitText]=thb
        thb.status.unittype=5
        if thb.skin~=Healbot_Config_Skins.Current_Skin then
            thb.skin=Healbot_Config_Skins.Current_Skin
        end
        if testBarsManaClass[unitClass] then
            thb.mana.type=0
        else
            thb.mana.type=1
        end
        HealBot_Skins_showPowerCounter(HealBot_Action_luVars["showTestPowerIndicator"])
        HealBot_Action_luVars["showTestPowerIndicator"]=0
        thb.icon.reset=true
        thb.skinreset=true
        thb.indreset=true
        HealBot_Skins_ResetSkin("bar",thb)
        for j=1,3 do
            thb.gref.icon[j]:SetAlpha(0)
        end
        for j=51,53 do
            thb.gref.icon[j]:SetAlpha(0)
        end
        thb.gref.icon[91]:SetAlpha(0)
        thb.gref.icon[92]:SetAlpha(0)
        testBarsDat["cnt"]=testBarsDat["cnt"]+1
        testBarsDat["buffId"]=0
        testBarsDat["debuffId"]=50
        if not testBarsDat["buffTexture"] then _, _, testBarsDat["buffTexture"] = GetSpellInfo(HEALBOT_RENEW) end
        if not testBarsDat["debuffTexture"] then _, _, testBarsDat["debuffTexture"] = GetSpellInfo(HEALBOT_SHADOW_WORD_PAIN) end
        if (testBarsDat["cnt"] % 3 == 0) and HealBot_Config_Buffs.BuffWatch and 
           Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][hbCurFrame]["MAXBICONS"]>0 then
            testBarsDat["buffId"]=testBarsDat["buffId"]+1
            thb.gref.icon[testBarsDat["buffId"]]:SetTexture(testBarsDat["buffTexture"])
            thb.gref.icon[testBarsDat["buffId"]]:SetAlpha(1)
        end
        if (testBarsDat["cnt"] % 4 == 0) and HealBot_Config_Cures.DebuffWatch and 
           Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][hbCurFrame]["MAXDICONS"]>0 then
            testBarsDat["debuffId"]=testBarsDat["debuffId"]+1
            thb.gref.icon[testBarsDat["debuffId"]]:SetTexture(testBarsDat["debuffTexture"])
            thb.gref.icon[testBarsDat["debuffId"]]:SetAlpha(1)
        end
        if (testBarsDat["cnt"] % 5 == 0) and Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][hbCurFrame]["SHOW"] then
            testBarsDat["targetCnt"]=testBarsDat["targetCnt"]+1
            if testBarsDat["targetCnt"]>8 then testBarsDat["targetCnt"]=1 end
            thb.gref.icon[92]:SetTexture(HealBot_Aura_retRaidtargetIcon(testBarsDat["targetCnt"]))
            thb.gref.icon[92]:SetAlpha(1)
        end
        if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][hbCurFrame]["SHOWCLASS"] then
            if not unitRole then unitRole="DAMAGER" end
            local classTexture=HealBot_Panel_retClassRoleIcon(unitClass)
            if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][hbCurFrame]["SHOWROLE"] then
                classTexture=HealBot_Panel_retClassRoleIcon(unitRole)
            end
            thb.gref.icon[91]:SetTexture(classTexture)
            thb.gref.icon[91]:SetAlpha(1)
        end
    end
    return thb
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
    --HealBot_Aux_clearAllBars(dg)
    HealBot_Aura_RemoveIcons(dg, GetTime())
    HealBot_Aura_delUnitIcons(dg.id)
    HealBot_Action_PrepButton(dg)
    HealBot_ActiveButtons[hbBarID]=false
    if hbBarID>HealBot_Globals.AutoCacheSize then
        HealBot_ActiveButtons[0]=1
    elseif hbBarID<HealBot_ActiveButtons[0] then 
        HealBot_ActiveButtons[0]=hbBarID
    end
    --HealBot_AddDebug("Deleted button "..hbBarID)
end

HealBot_Action_luVars["PreCacheBars"]=1
local hbMarkedDeleteButtons={}
local cButtonId=0
function HealBot_Action_DoDeleteMarkedButtons()
    if not HealBot_Data["UILOCK"] then
        HealBot_Action_luVars["DeleteMarkedButtonsActive"]=true
        if hbMarkedDeleteButtons[1] then
            HealBot_Action_DeleteButton(hbMarkedDeleteButtons[1])
            table.remove(hbMarkedDeleteButtons,1)
            C_Timer.After(0.075, HealBot_Action_DoDeleteMarkedButtons)
        elseif HealBot_Action_luVars["PreCacheBars"]<HealBot_Globals.AutoCacheSize then
            HealBot_Action_luVars["PreCacheBars"]=HealBot_Action_luVars["PreCacheBars"]+1
            cButtonId=HealBot_Action_FreeId()
            if cButtonId>0 then
                local ghb=_G["HealBot_Action_HealUnit"..cButtonId]
                if not ghb then 
                    HealBot_ActiveButtons[buttonId]=true
                    ghb=HealBot_Action_CreateNewButton(10, cButtonId)
                    HealBot_Action_MarkDeleteButton(ghb)
                end
            end
            C_Timer.After(0.075, HealBot_Action_DoDeleteMarkedButtons)
        else
            HealBot_Action_luVars["DeleteMarkedButtonsActive"]=false
        end
    else
        HealBot_setOptions_Timer(9990)
    end
end

function HealBot_Action_DeleteMarkedButtons()
    if not HealBot_Action_luVars["DeleteMarkedButtonsActive"] then
        HealBot_Action_DoDeleteMarkedButtons()
    end
end

function HealBot_Action_MarkDeleteButton(button)
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
    button:Hide()
    HealBot_Emerg_Button[button.id]:Hide()
    for x=1,12 do
        button.gref.iconf[x]:SetFrameLevel(0)
    end
    for x=51,58 do
        button.gref.iconf[x]:SetFrameLevel(0)
    end
    if HealBot_Fluid_BarButtons[button.id] then HealBot_Fluid_BarButtons[button.id]=nil end
    if HealBot_Fluid_BarButtonsAlpha[button.id] then HealBot_Fluid_BarButtonsAlpha[button.id]=nil end
    if HealBot_Fluid_InHealButtons[button.id] then HealBot_Fluid_InHealButtons[button.id]=nil end
    if HealBot_Fluid_AbsorbButtons[button.id] then HealBot_Fluid_AbsorbButtons[button.id]=nil end
    button.status.enabled=false
    table.insert(hbMarkedDeleteButtons, button.id)
    HealBot_setOptions_Timer(9990)
end

function HealBot_Action_Reset()
    for i=1, 10 do
        Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][i]["X"]=(49+(i*2))
        Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][i]["Y"]=(49+(i*2))
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][i]["AUTOCLOSE"]=1
        if HealBot_Config.DisabledNow==0 and HealBot_Action_FrameIsVisible(i) then
            HealBot_Action_FrameSetPoint(i, grpFrame[i])
            HealBot_Action_ShowPanel(i)
        end
        HealBot_Action_unlockFrame(i)
    end
    HealBot_Options_Frame_initCurFrame()
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
    HealBot_setOptions_Timer(19)
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
    --HealBot_setCall("HealBot_CheckActionFrame")
end

local vFrameSetPointX,vFrameSetPointY=0,0
function HealBot_Action_FrameSetPoint(hbCurFrame, gaf)
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
          ["DEMO"] = {r=0.8,  g=0.1, b=0.8, },
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
      }
      
function HealBot_Action_ClassColour(unit)
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

function HealBot_Action_HideTooltip(self)
    if HealBot_Data["TIPBUTTON"] then
        HealBot_Data["TIPBUTTON"] = false;
        HealBot_Data["TIPTYPE"] = "NONE";
        HealBot_Action_HideTooltipFrame()
    end
    HealBot_Data["INSPECT"] = false;
end

function HealBot_Action_HideTooltipFrame()
    if HealBot_Data["TIPUSE"] then
        if HealBot_Globals.UseGameTooltip then
            GameTooltip:Hide();
        else
            HealBot_Tooltip:Hide();
        end
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
        if Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][i]["AUTOCLOSE"]>1 and hideFrame[i] and HealBot_Action_FrameIsVisible(i) then
            HealBot_Action_HidePanel(i)
        end
    end
end

function HealBot_Action_ShowHideFrames(button)
    if not HealBot_Data["UILOCK"] and Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][button.frame]["AUTOCLOSE"]>1 then 
        if not HealBot_Action_FrameIsVisible(button.frame) and HealBot_Config.DisabledNow==0 then
            if button.status.enabled and button:IsVisible() then
                HealBot_Action_ShowPanel(button.frame)
            end
        elseif  HealBot_Action_FrameIsVisible(button.frame) and not button.status.enabled and not HealBot_Action_ShouldHealSome(button.frame) then
            HealBot_Action_HidePanel(button.frame)
        end
    end
end

function HealBot_Action_ShowHideFrameOption(frame)
    if not HealBot_Data["UILOCK"] then
        if frame>5 then
            if frame<8 then
                HealBot_nextRecalcParty(2)
            elseif frame==8 then
                HealBot_nextRecalcParty(3) 
            elseif frame==9 then 
                HealBot_nextRecalcParty(4)
            elseif frame==10 then 
                HealBot_nextRecalcParty(5)
            end
        else
            HealBot_nextRecalcParty(6)
        end
    end
end
function HealBot_Action_Refresh(button)
    button.status.refresh=false
    HealBot_Action_UpdateDebuffButton(button)
      --HealBot_setCall("HealBot_Action_Refresh")
end

function HealBot_Action_HealUnit_OnEnter(self)
    if not self.unit then return; end
    HealBot_Action_ShowDirectionArrow(self, GetTime())
    if HealBot_Globals.ShowTooltip and HealBot_Data["TIPUSE"] and UnitExists(self.unit) then
        HealBot_Data["TIPBUTTON"] = self
        if not UnitIsFriend("player",self.unit) then
            HealBot_Data["TIPTYPE"] = "Enemy"
        else
            HealBot_Data["TIPTYPE"] = "Enabled"
        end
        HealBot_Action_RefreshTooltip();
    end
    if self and self.aux then HealBot_Aux_UpdateHighlightBar(self) end
    HealBot_MountsPets_lastbutton(self)
    --HealBot_setCall("HealBot_Action_HealUnit_OnEnter")
end

function HealBot_Action_HealUnit_OnLeave(self)
    HealBot_Action_HideTooltip(self);
    if self.status and self.status.dirarrowshown>0 and Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][self.frame]["SHOWDIRMOUSE"] then
        HealBot_Action_HideDirectionArrow(self)
    end
    if self and self.aux then HealBot_Aux_ClearHighlightBar(self) end
    HealBot_MountsPets_lastbutton(false)
   -- ClearOverrideBindings(HealBot_Action)
end

function HealBot_Action_EmergUnit_OnEnter(self)
    if HealBot_Globals.ShowTooltip and HealBot_Data["TIPUSE"] then
        xButton=HealBot_ButtonIndex[self.id]
        if xButton and UnitExists(xButton.unit) and not UnitIsEnemy("player",xButton.unit) then
            HealBot_Data["TIPBUTTON"]=xButton
            HealBot_Data["TIPTYPE"] = "Emerg"
            HealBot_Action_RefreshTooltip();
        end
    end
    --HealBot_setCall("HealBot_Action_HealUnit_OnEnter")
end

function HealBot_Action_EmergUnit_OnLeave(self)
    if HealBot_Data["TIPBUTTON"] then HealBot_Action_HideTooltip(HealBot_Data["TIPBUTTON"]) end
end

function HealBot_Action_OptionsButton_OnClick(self)
    HealBot_TogglePanel(HealBot_Options, true);
end

local usedSmartCast=nil
local ModKey=nil
local abutton=nil
local aj=nil
local uLevel=0

function HealBot_Action_UseSmartCast(bp,button)
    local sName=HealBot_Action_SmartCast(button);
    if sName then
        if HealBot_Spell_Names[sName] then
            if HEALBOT_GAME_VERSION<4 then
                uLevel=UnitLevel(button.unit)
                if uLevel and uLevel>0 then
                    if HealBot_Data["PCLASSTRIM"]=="PRIE" then
                        if sName==GetSpellInfo(HBC_POWER_WORD_FORTITUDE) then
                            if uLevel<12 then
                                sName=HealBot_Init_Buffs_retRank(sName, 1)
                            elseif uLevel<24 then
                                sName=HealBot_Init_Buffs_retRank(sName, 2)
                            elseif uLevel<36 then
                                sName=HealBot_Init_Buffs_retRank(sName, 3)
                            elseif uLevel<48 then
                                sName=HealBot_Init_Buffs_retRank(sName, 4)
                            elseif uLevel<60 then
                                sName=HealBot_Init_Buffs_retRank(sName, 5)
                            elseif uLevel<70 then
                                sName=HealBot_Init_Buffs_retRank(sName, 6)
                            else
                                sName=HealBot_Init_Buffs_retRank(sName, 7)
                            end
                        elseif sName==GetSpellInfo(HBC_DIVINE_SPIRIT) then
                            if uLevel<40 then
                                sName=HealBot_Init_Buffs_retRank(sName, 1)
                            elseif uLevel<50 then
                                sName=HealBot_Init_Buffs_retRank(sName, 2)
                            elseif uLevel<60 then
                                sName=HealBot_Init_Buffs_retRank(sName, 3)
                            elseif uLevel<70 then
                                sName=HealBot_Init_Buffs_retRank(sName, 4)
                            else
                                sName=HealBot_Init_Buffs_retRank(sName, 5)
                            end
                        elseif sName==GetSpellInfo(HBC_SHADOW_PROTECTION) then
                            if uLevel<42 then
                                sName=HealBot_Init_Buffs_retRank(sName, 1)
                            elseif uLevel<56 then
                                sName=HealBot_Init_Buffs_retRank(sName, 2)
                            elseif uLevel<68 then
                                sName=HealBot_Init_Buffs_retRank(sName, 3)
                            else
                                sName=HealBot_Init_Buffs_retRank(sName, 4)
                            end
                        end
                    elseif HealBot_Data["PCLASSTRIM"]=="DRUI" then
                        if sName==GetSpellInfo(HEALBOT_MARK_OF_THE_WILD) then
                            if uLevel<10 then
                                sName=HealBot_Init_Buffs_retRank(sName, 1)
                            elseif uLevel<20 then
                                sName=HealBot_Init_Buffs_retRank(sName, 2)
                            elseif uLevel<30 then
                                sName=HealBot_Init_Buffs_retRank(sName, 3)
                            elseif uLevel<40 then
                                sName=HealBot_Init_Buffs_retRank(sName, 4)
                            elseif uLevel<50 then
                                sName=HealBot_Init_Buffs_retRank(sName, 5)
                            elseif uLevel<60 then
                                sName=HealBot_Init_Buffs_retRank(sName, 6)
                            elseif uLevel<70 then
                                sName=HealBot_Init_Buffs_retRank(sName, 7)
                            else
                                sName=HealBot_Init_Buffs_retRank(sName, 8)
                            end
                        elseif sName==GetSpellInfo(HBC_THORNS) then
                            if uLevel<14 then
                                sName=HealBot_Init_Buffs_retRank(sName, 1)
                            elseif uLevel<24 then
                                sName=HealBot_Init_Buffs_retRank(sName, 2)
                            elseif uLevel<34 then
                                sName=HealBot_Init_Buffs_retRank(sName, 3)
                            elseif uLevel<44 then
                                sName=HealBot_Init_Buffs_retRank(sName, 4)
                            elseif uLevel<54 then
                                sName=HealBot_Init_Buffs_retRank(sName, 5)
                            elseif uLevel<64 then
                                sName=HealBot_Init_Buffs_retRank(sName, 6)
                            else
                                sName=HealBot_Init_Buffs_retRank(sName, 7)
                            end
                        end
                    elseif HealBot_Data["PCLASSTRIM"]=="PALA" then
                        if sName==GetSpellInfo(HBC_BLESSING_OF_LIGHT) then
                            if uLevel<50 then
                                sName=HealBot_Init_Buffs_retRank(sName, 1)
                            elseif uLevel<60 then
                                sName=HealBot_Init_Buffs_retRank(sName, 2)
                            elseif uLevel<69 then
                                sName=HealBot_Init_Buffs_retRank(sName, 3)
                            else
                                sName=HealBot_Init_Buffs_retRank(sName, 4)
                            end
                        elseif sName==GetSpellInfo(HBC_BLESSING_OF_MIGHT) then
                            if uLevel<12 then
                                sName=HealBot_Init_Buffs_retRank(sName, 1)
                            elseif uLevel<22 then
                                sName=HealBot_Init_Buffs_retRank(sName, 2)
                            elseif uLevel<32 then
                                sName=HealBot_Init_Buffs_retRank(sName, 3)
                            elseif uLevel<42 then
                                sName=HealBot_Init_Buffs_retRank(sName, 4)
                            elseif uLevel<52 then
                                sName=HealBot_Init_Buffs_retRank(sName, 5)
                            elseif uLevel<60 then
                                sName=HealBot_Init_Buffs_retRank(sName, 6)
                            elseif uLevel<70 then
                                sName=HealBot_Init_Buffs_retRank(sName, 7)
                            else
                                sName=HealBot_Init_Buffs_retRank(sName, 8)
                            end
                        elseif sName==GetSpellInfo(HBC_BLESSING_OF_WISDOM) then
                            if uLevel<24 then
                                sName=HealBot_Init_Buffs_retRank(sName, 1)
                            elseif uLevel<34 then
                                sName=HealBot_Init_Buffs_retRank(sName, 2)
                            elseif uLevel<44 then
                                sName=HealBot_Init_Buffs_retRank(sName, 3)
                            elseif uLevel<54 then
                                sName=HealBot_Init_Buffs_retRank(sName, 4)
                            elseif uLevel<60 then
                                sName=HealBot_Init_Buffs_retRank(sName, 5)
                            elseif uLevel<65 then
                                sName=HealBot_Init_Buffs_retRank(sName, 6)
                            else
                                sName=HealBot_Init_Buffs_retRank(sName, 7)
                            end
                        elseif sName==GetSpellInfo(HBC_BLESSING_OF_SANCTUARY) then
                            if uLevel<40 then
                                sName=HealBot_Init_Buffs_retRank(sName, 1)
                            elseif uLevel<50 then
                                sName=HealBot_Init_Buffs_retRank(sName, 2)
                            elseif uLevel<60 then
                                sName=HealBot_Init_Buffs_retRank(sName, 3)
                            elseif uLevel<70 then
                                sName=HealBot_Init_Buffs_retRank(sName, 4)
                            else
                                sName=HealBot_Init_Buffs_retRank(sName, 5)
                            end
                        end
                    elseif HealBot_Data["PCLASSTRIM"]=="SHAM" then
                        if sName==GetSpellInfo(HBC_EARTH_SHIELD) then
                            if uLevel<60 then
                                sName=HealBot_Init_Buffs_retRank(sName, 1)
                            elseif uLevel<70 then
                                sName=HealBot_Init_Buffs_retRank(sName, 2)
                            else
                                sName=HealBot_Init_Buffs_retRank(sName, 3)
                            end
                        end
                    elseif HealBot_Data["PCLASSTRIM"]=="MAGE" then
                        if sName==GetSpellInfo(HEALBOT_ARCANE_BRILLIANCE) then
                            if uLevel<14 then
                                sName=HealBot_Init_Buffs_retRank(sName, 1)
                            elseif uLevel<28 then
                                sName=HealBot_Init_Buffs_retRank(sName, 2)
                            elseif uLevel<42 then
                                sName=HealBot_Init_Buffs_retRank(sName, 3)
                            elseif uLevel<56 then
                                sName=HealBot_Init_Buffs_retRank(sName, 4)
                            elseif uLevel<70 then
                                sName=HealBot_Init_Buffs_retRank(sName, 5)
                            else
                                sName=HealBot_Init_Buffs_retRank(sName, 6)
                            end
                        end
                    end
                end
            end
            bp:SetAttribute("helpbutton1", "heal1");
            bp:SetAttribute("type-heal1", "spell");
            bp:SetAttribute("spell-heal1", sName);
        else
            local mId=GetMacroIndexByName(sName)
            if mId ~= 0 then
               local _,_,mText=GetMacroInfo(mId)
                if HealBot_UnitPet(button.unit) and UnitExists(HealBot_UnitPet(button.unit)) then
                    mText=string.gsub(mText,"hbtargetpet",HealBot_UnitPet(button.unit))
                end
                mText=string.gsub(mText,"hbtarget",button.unit)
                mText=string.gsub(mText,"hbtargettarget",button.unit.."target")
                mText=string.gsub(mText,"hbtargettargettarget",button.unit.."targettarget")
                bp:SetAttribute("type1","macro")
                bp:SetAttribute("macrotext1", mText)
            else
                bp:SetAttribute("helpbutton1", "item1");
                bp:SetAttribute("type-item1", "item");
                bp:SetAttribute("item-item1", sName);
            end
        end
        usedSmartCast=true;
    end
end

function HealBot_Action_PreSmartCast(self,mButton,button)
    if HealBot_Globals.ProtectPvP then
        if UnitIsPVP(button.unit) and not UnitIsPVP("player") then 
            self:SetAttribute("helpbutton1", nil);
            self:SetAttribute("type-heal1", nil);
            self:SetAttribute("spell-heal1", nil);
            usedSmartCast=true;
        end
    end
    if not usedSmartCast and mButton=="LeftButton" and HealBot_Globals.SmartCast and not IsModifierKeyDown() then
        HealBot_Action_UseSmartCast(self,button)
    end
end

function HealBot_Action_ButtonPreClick(self,button,xButton)
    if xButton and self.id<999 and UnitExists(xButton.unit) and UnitIsFriend("player",xButton.unit) then
        HealBot_setLuVars("TargetUnitID", xButton.unit)
        usedSmartCast=false;
        ModKey=nil
        if IsAltKeyDown() then 
            ModKey="Alt" 
        end
        if IsControlKeyDown() then
            if ModKey then
                ModKey=ModKey.."-Ctrl"
            else
                ModKey="Ctrl"
            end
        end
        if IsShiftKeyDown() then
            if ModKey then
                ModKey=ModKey.."-Shift"
            else
                ModKey="Shift"
            end
        end
        if not ModKey then
            ModKey=""
        end
        if button=="LeftButton" then 
            abutton="Left"
            aj=1
        elseif button=="RightButton" then 
            abutton="Right"
            aj=2
        elseif button=="MiddleButton" then 
            abutton="Middle"
            aj=3
        else
            abutton=button
            aj=tonumber(strmatch(button, "(%d+)"))
        end
        if xButton.unit=="target" and HealBot_Globals.TargetBarRestricted==1 then
            if button=="RightButton" then
                HealBot_Panel_ToggelHealTarget(xButton.unit)
                if HealBot_Data["TIPUSE"] and HealBot_Globals.ShowTooltip then 
                    HealBot_Action_RefreshTargetTooltip(self) 
                end
            elseif not InCombatLockdown() then
                HealBot_Action_PreSmartCast(self,button,xButton)
            end
        elseif not InCombatLockdown() then
            HealBot_Action_PreSmartCast(self,button,xButton)
        end
    end
end

function HealBot_Action_PreClick(self,button)
    HealBot_Action_ButtonPreClick(self,button,self)
end

function HealBot_EmergAction_PreClick(self,button)
    HealBot_Action_ButtonPreClick(self,button,HealBot_ButtonIndex[self.id])
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
    xButton=HealBot_ButtonIndex[self.id]
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
        button:RegisterForClicks(nil)
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
    local g=_G["f"..hbCurFrame.."_HealBot_Action_Title"]
    if Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame] and
       Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame]["NAME"] and 
       Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame]["SHOW"] then
        g:SetText(Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame]["NAME"])
    else
        g:SetText("")
    end
    HealBot_Skins_ResetSkin("frameheader",nil,hbCurFrame)
end

function HealBot_Action_SetAliasFontSize(hbCurFrame)
    if Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame] and Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FONT"] then
        local g=_G["f"..hbCurFrame.."_HealBot_Action_Title"]
        g:SetTextColor(Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame]["R"],
                               Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame]["G"],
                               Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame]["B"],
                               Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame]["A"]);
        g:SetFont(LSM:Fetch('font',Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FONT"]),
                                           Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame]["SIZE"],
                                           HealBot_Font_Outline[Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame]["OUTLINE"]]);
        g:SetTextHeight(Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame]["SIZE"])
        g:ClearAllPoints();
        g:SetPoint("CENTER",0,Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame]["OFFSET"]);
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

hbFrameTags={[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false,}
local function HealBot_Action_ToggleFrameTag(self)
    if not HealBot_Globals.HideUnlockedTag then
        if not HealBot_Data["UILOCK"] then
            if hbFrameTags[self.id] then
                hbFrameTags[self.id]=false
            else
                hbFrameTags[self.id]=true
            end
            HealBot_nextRecalcParty(0)
        else
            HealBot_setOptions_Timer(9200)
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
end

function HealBot_Action_OnLeave(self)
    HealBot_Action_luVars["ActiveFrame"]=false
    if hbFrameTags[self.id] then
        HealBot_Action_ToggleFrameTag(self)
    end
end

function HealBot_Action_ModKey()
    if HealBot_Action_luVars["ActiveFrame"] then
        HealBot_Action_OnEnter(HealBot_Action_luVars["ActiveFrame"])
        HealBot_nextRecalcParty(0)
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
    local xGUID=UnitGUID(unit)
    if HealBot_AlwaysEnabled[xGUID] then
        HealBot_AlwaysEnabled[xGUID]=nil
    else
        HealBot_AlwaysEnabled[xGUID]=true
    end
    --HealBot_setOptions_Timer(80)
end

function HealBot_Action_AlwaysEnabled(hbGUID)
    return HealBot_AlwaysEnabled[hbGUID]
end

local function HealBot_Action_IsPlayersDead(button, isVisible)
    if HealBot_Action_IsUnitDead(button) and (button.status.range>-1 or not isVisible) then
        return true
    else
        return false
    end
end

function HealBot_Action_NumPlayersDead(isVisible)
    local nDead=0
    for _,xButton in pairs(HealBot_Unit_Button) do
        if not xButton.status.duplicate then
            if HealBot_Action_IsPlayersDead(xButton, isVisible) then
                nDead=nDead+1
            end
        end
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        if not xButton.status.duplicate then
            if HealBot_Action_IsPlayersDead(xButton, isVisible) then
                nDead=nDead+1
            end
        end
    end
    return nDead
end

function HealBot_Action_SmartCast(button)
    if HealBot_Action_IsUnitDead(button) and UnitIsUnit("player",button.unit) then return nil; end
    local scuSpell = nil
    local rSpell=HealBot_RangeSpells["HEAL"]
 
    if HealBot_Globals.SmartCastRes and HealBot_Action_IsUnitDead(button) then
        if HealBot_Init_retSmartCast_MassRes() then
            if button.status.range<1 or HealBot_Action_NumPlayersDead(true)>1 then
                scuSpell=HealBot_Init_retSmartCast_MassRes();
            else
                scuSpell=HealBot_Init_retSmartCast_Res();
            end
        else
            scuSpell=HealBot_Init_retSmartCast_Res();
        end
        rSpell=HealBot_RangeSpells["RES"]
    elseif button.aura.debuff.type and HealBot_Globals.SmartCastDebuff then
        scuSpell=HealBot_Options_retDebuffCureSpell(button.aura.debuff.type);
        rSpell=HealBot_RangeSpells["CURE"]
    elseif button.aura.buff.missingbuff and button.aura.buff.name and HealBot_Globals.SmartCastBuff then
        if button.aura.buff.name==HEALBOT_WELL_FED and IsUsableItem(HealBot_Config_Buffs.WellFedItem) then
            scuSpell=HealBot_Config_Buffs.WellFedItem
        else
            scuSpell=button.aura.buff.name
        end
        rSpell=HealBot_RangeSpells["BUFF"]
    end

    if HealBot_UnitInRange(button.unit, rSpell)<1 then
        return nil
    end
    return scuSpell;
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
local vStickyFrameSen=28
function HealBot_Action_CheckForStickyFrame(frame,stick)
    vStickyFrameIsSticky=false
    vStickyFrameCurAnchor=0
    vStickyFrameParAnchor=0
    vStickyFrameLeft=grpFrame[frame]:GetLeft()
    vStickyFrameRight=grpFrame[frame]:GetRight()
    vStickyFrameTop=grpFrame[frame]:GetTop()
    vStickyFrameBottom=grpFrame[frame]:GetBottom()
    for x=1,frame-1 do
        if HealBot_Action_FrameIsVisible(x) then
            if grpFrame[x]:GetLeft() then
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
            end
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