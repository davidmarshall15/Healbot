local HealBot_UnitBarsRange3a={}
local ceil=ceil;
local floor=floor
local hbBarTextLen={[1]=50,[2]=50,[3]=50,[4]=50,[5]=50,[6]=50,[7]=50,[8]=50,[9]=50,[10]=50}
local strsub=strsub
local HealBot_ActiveButtons={[0]=1}
local HealBot_RangeSpells={}
local HealBot_MyTargets={}
local HealBot_pcClass={[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
local LSM = HealBot_retLSM() --LibStub("LibSharedMedia-3.0") 
local HealBot_ResetBarSkinDone={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
local HealBot_Action_rCalls={}
local _
local hbNumFormats = {["Places"]        = {[1]=-1, [2]=-1, [3]=-1, [4]=-1, [5]=-1, [6]=-1, [7]=-1, [8]=-1, [9]=-1, [10]=-1},
                      ["SurroundLeft"]  = {[1]="(",[2]="(",[3]="(",[4]="(",[5]="(",[6]="(",[7]="(",[8]="(",[9]="(",[10]="("},
                      ["SurroundRight"] = {[1]=")",[2]=")",[3]=")",[4]=")",[5]=")",[6]=")",[7]=")",[8]=")",[9]=")",[10]=")"},
                      ["Suffix"]        = {[1]=1,  [2]=1,  [3]=1,  [4]=1,  [5]=1,  [6]=1,  [7]=1,  [8]=1,  [9]=1,  [10]=1},
                     }
local HealBotButtonMacroAttribs={}
local HealBot_Action_luVars={}
HealBot_Action_luVars["PrevThreatPct"]=-3
HealBot_Action_luVars["NumFormatSurLa"]="["
HealBot_Action_luVars["NumFormatSurRa"]="]"
HealBot_Action_luVars["FrameMoving"]=false
HealBot_Action_luVars["ResetAttribs"]=false
HealBot_Action_luVars["AggroBarAlpha"]=0.8
HealBot_Action_luVars["AggroBarUp"]=false
HealBot_Action_luVars["UnitPowerMax"]=3
HealBot_Action_luVars["resetSkinTo"]=""
HealBot_Action_luVars["UpdatedAggroBars"]=true
HealBot_Action_luVars["UpdateFluidBars"]=true

local hbStringSub=nil
local hbStringLen=nil
if HealBot_Globals.useUTF8 then
    hbStringSub=string.utf8sub
    hbStringLen=string.utf8len
else
    hbStringSub=string.sub
    hbStringLen=string.len
end

local function HealBot_Action_DoAggroIndicatorUpd(button)
    if not UnitExists(button.unit) or (UnitExists(button.unit) and not UnitIsFriend("player",button.unit)) then
        if HealBot_Action_rCalls[button.unit]["aggroIndicator"]~="notUnit" then
            HealBot_Action_rCalls[button.unit]["aggroIndicator"]="notUnit"
            local mainBar=_G["HealBot_Action_HealUnit"..button.id.."Bar"]
            local iconName=nil
            iconName = _G[mainBar:GetName().."Iconal1"];
            iconName:SetAlpha(0)
            iconName = _G[mainBar:GetName().."Iconal2"];
            iconName:SetAlpha(0)
            iconName = _G[mainBar:GetName().."Iconal3"];
            iconName:SetAlpha(0)
            iconName = _G[mainBar:GetName().."Iconar1"];
            iconName:SetAlpha(0)
            iconName = _G[mainBar:GetName().."Iconar2"];
            iconName:SetAlpha(0)
            iconName = _G[mainBar:GetName().."Iconar3"];
            iconName:SetAlpha(0)
        end
    else
        if button.aggro.status>=Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["ALERTIND"] then
            if button.aggro.status==1 then
                if HealBot_Action_rCalls[button.unit]["aggroIndicator"]~="a1" then
                    HealBot_Action_rCalls[button.unit]["aggroIndicator"]="a1"
                    local mainBar=_G["HealBot_Action_HealUnit"..button.id.."Bar"]
                    local iconName=nil
                    iconName = _G[mainBar:GetName().."Iconal1"];
                    iconName:SetAlpha(1)
                    iconName = _G[mainBar:GetName().."Iconal2"];
                    iconName:SetAlpha(0)
                    iconName = _G[mainBar:GetName().."Iconal3"];
                    iconName:SetAlpha(0)
                    iconName = _G[mainBar:GetName().."Iconar1"];
                    iconName:SetAlpha(1)
                    iconName = _G[mainBar:GetName().."Iconar2"];
                    iconName:SetAlpha(0)
                    iconName = _G[mainBar:GetName().."Iconar3"];
                    iconName:SetAlpha(0)
                end
            elseif button.aggro.status==2 then
                if HealBot_Action_rCalls[button.unit]["aggroIndicator"]~="a2" then
                    HealBot_Action_rCalls[button.unit]["aggroIndicator"]="a2"
                    local mainBar=_G["HealBot_Action_HealUnit"..button.id.."Bar"]
                    local iconName=nil
                    iconName = _G[mainBar:GetName().."Iconal1"];
                    iconName:SetAlpha(1)
                    iconName = _G[mainBar:GetName().."Iconal2"];
                    iconName:SetAlpha(1)
                    iconName = _G[mainBar:GetName().."Iconal3"];
                    iconName:SetAlpha(0)
                    iconName = _G[mainBar:GetName().."Iconar1"];
                    iconName:SetAlpha(1)
                    iconName = _G[mainBar:GetName().."Iconar2"];
                    iconName:SetAlpha(1)
                    iconName = _G[mainBar:GetName().."Iconar3"];
                    iconName:SetAlpha(0)
                end
            elseif button.aggro.status==3 then
                if HealBot_Action_rCalls[button.unit]["aggroIndicator"]~="a3" then
                    HealBot_Action_rCalls[button.unit]["aggroIndicator"]="a3"
                    local mainBar=_G["HealBot_Action_HealUnit"..button.id.."Bar"]
                    local iconName=nil
                    iconName = _G[mainBar:GetName().."Iconal1"];
                    iconName:SetAlpha(1)
                    iconName = _G[mainBar:GetName().."Iconal2"];
                    iconName:SetAlpha(1)
                    iconName = _G[mainBar:GetName().."Iconal3"];
                    iconName:SetAlpha(1)
                    iconName = _G[mainBar:GetName().."Iconar1"];
                    iconName:SetAlpha(1)
                    iconName = _G[mainBar:GetName().."Iconar2"];
                    iconName:SetAlpha(1)
                    iconName = _G[mainBar:GetName().."Iconar3"];
                    iconName:SetAlpha(1)
                end
            end
        elseif button.aggro.status>-1 and button.aggro.status<4 then
            if HealBot_Action_rCalls[button.unit]["aggroIndicator"]~="off" then
                HealBot_Action_rCalls[button.unit]["aggroIndicator"]="off"
                local mainBar=_G["HealBot_Action_HealUnit"..button.id.."Bar"]
                local iconName=nil
                iconName = _G[mainBar:GetName().."Iconal1"];
                iconName:SetAlpha(0)
                iconName = _G[mainBar:GetName().."Iconal2"];
                iconName:SetAlpha(0)
                iconName = _G[mainBar:GetName().."Iconal3"];
                iconName:SetAlpha(0)
                iconName = _G[mainBar:GetName().."Iconar1"];
                iconName:SetAlpha(0)
                iconName = _G[mainBar:GetName().."Iconar2"];
                iconName:SetAlpha(0)
                iconName = _G[mainBar:GetName().."Iconar3"];
                iconName:SetAlpha(0)
            end
        end
    end
  --HealBot_setCall("HealBot_Action_DoAggroIndicatorUpd")
end

function HealBot_Action_aggroIndicatorUpd(button)
    HealBot_Action_DoAggroIndicatorUpd(button)
end

local debuffCodes={ [HEALBOT_DISEASE_en]=5, [HEALBOT_MAGIC_en]=6, [HEALBOT_POISON_en]=7, [HEALBOT_CURSE_en]=8, [HEALBOT_CUSTOM_en]=9}
local function HealBot_Action_DoUpdateAggro(unit,status,threatStatus,threatPct)
    local xButton=HealBot_Unit_Button[unit] or HealBot_Pet_Button[unit]
    if not xButton then return end
    local barName=_G["HealBot_Action_HealUnit"..xButton.id.."Bar4"]
    HealBot_Action_luVars["PrevThreatPct"]=xButton.aggro.threatpct
    
    if UnitExists(unit) and UnitIsFriend("player",unit) then
        if UnitIsDeadOrGhost(unit) and not UnitIsFeignDeath(unit) then
            status=nil
            threatPct=0
            if threatStatus then threatStatus=0 end
        end
        if threatStatus and (Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["SHOWBARSPCT"] or Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["SHOWTEXTPCT"]) then
            if not threatPct then threatPct,_=HealBot_CalcThreat(unit) end
            if threatPct>0 then
                xButton.aggro.threatpct=threatPct
                if threatStatus==0 then
                    threatStatus=1
                    if not status then status=true end
                end
            elseif threatStatus==3 then
                xButton.aggro.threatpct=100
            elseif threatStatus==2 then
                if xButton.aggro.threatpct<1 then xButton.aggro.threatpct=75 end
            elseif threatStatus==1 then
                if xButton.aggro.threatpct<1 then xButton.aggro.threatpct=25 end
            else
                xButton.aggro.threatpct=0
            end
        else
            if not threatStatus then threatStatus=0 end
            xButton.aggro.threatpct=0
            if status and not UnitIsFriend("player",unit) then status=nil end
        end
        if status then
            if HealBot_Config_Cures.CDCshownAB and xButton.aura.debuff.type then
                xButton.aggro.status=debuffCodes[xButton.aura.debuff.type]
            elseif Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["SHOW"] and 
                   threatStatus>Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["ALERT"] then
                xButton.aggro.status=threatStatus
            elseif status=="target" and Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["TBAR"] then
                xButton.aggro.status=-2
            elseif status=="highlight" and Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["CBAR"] then
                xButton.aggro.status=-1
            elseif xButton.aggro.status<0 and status=="off" then
                xButton.aggro.status=0
            else
                xButton.aggro.status=threatStatus or 0
            end
            if Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["SHOW"] and Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["SHOWIND"] then
                HealBot_Action_aggroIndicatorUpd(xButton)
            end
        else
            xButton.aggro.status=0
            HealBot_Action_aggroIndicatorUpd(xButton)
        end
        if status and (xButton.aggro.status<0 or xButton.aggro.status>4 or (xButton.aggro.status>Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["ALERT"] and 
                                                                            xButton.aggro.status<4 and Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["SHOWBARS"])) then
            if xButton.aggro.status>0 and xButton.aggro.status<4 and Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["SHOWBARSPCT"] then
                if Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["SHOWBARS"] and threatStatus>Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["ALERT"] then
                    barName:SetValue(xButton.aggro.threatpct)
                end
            else
                barName:SetValue(100)
            end
            xButton.status.bar4=1
            HealBot_Action_luVars["UpdatedAggroBars"]=true
        else
            barName:SetStatusBarColor(1,0,0,0)
            xButton.status.bar4=0
        end
    else
        barName:SetStatusBarColor(1,0,0,0);
        xButton.status.bar4=0
    end
    if xButton.aggro.threatpct~=HealBot_Action_luVars["PrevThreatPct"] then 
        HealBot_Action_setNameText(xButton) 
        HealBot_Action_UpdateHealthButton(xButton) 
    end
  --HealBot_setCall("HealBot_Action_DoUpdateAggro")
end

function HealBot_Action_UpdateAggro(unit,status,threatStatus,threatPct)
    HealBot_Action_DoUpdateAggro(unit,status,threatStatus,threatPct)
end

local function HealBot_Action_clearResetBarSkinDone()
    for j=1,10 do
        HealBot_ResetBarSkinDone[j]={};
    end
end

function HealBot_Action_setpcClass()
    for j=1,5 do
        if (HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_PALADIN] or HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_MONK]) and 
            Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j] and Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j]["POWERCNT"] then
            local prevHealBot_pcMax=HealBot_Action_luVars["UnitPowerMax"];
            if HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_PALADIN] then
                HealBot_pcClass[j]=9
                HealBot_Action_luVars["UnitPowerMax"] = UnitPowerMax("player" , 9);
            else
                HealBot_pcClass[j]=12
                HealBot_Action_luVars["UnitPowerMax"] = UnitPowerMax("player" , 12);
            end     
            if prevHealBot_pcMax~=HealBot_Action_luVars["UnitPowerMax"] then
                HealBot_Action_clearResetBarSkinDone()
                HealBot_nextRecalcParty(6)
            end
        else
            HealBot_pcClass[j]=false
            local xButton=HealBot_Unit_Button["player"]
            if xButton then
                for y=1,5 do
                    local iconName = _G["HealBot_Action_HealUnit"..xButton.id.."Bar3Icon"..y];
                    iconName:SetAlpha(0)
                end
            end
        end
    end
end

function HealBot_Action_SetrSpell()
	HealBot_RangeSpells["HEAL"]=nil
	HealBot_RangeSpells["BUFF"]=nil
	HealBot_RangeSpells["CURE"]=nil
	HealBot_RangeSpells["RES"]=nil
    HealBot_RangeSpells["HARM"]=nil
	local x=HealBot_GetBandageType() or HEALBOT_WORDS_UNKNOWN
    if HealBot_Data["PCLASSTRIM"]=="DRUI" then
        if HealBot_GetSpellId(HEALBOT_WRATH) then 
            HealBot_RangeSpells["HARM"]=HEALBOT_WRATH -- 40
            x=HEALBOT_WRATH
        elseif HealBot_GetSpellId(HEALBOT_HURRICANE) then 
            HealBot_RangeSpells["HARM"]=HEALBOT_HURRICANE -- 30
            x=HEALBOT_HURRICANE
        end
        if HealBot_GetSpellId(HEALBOT_MARK_OF_THE_WILD) then 
			HealBot_RangeSpells["BUFF"]=HEALBOT_MARK_OF_THE_WILD
			x=HEALBOT_MARK_OF_THE_WILD
		end
        if HealBot_GetSpellId(HEALBOT_REMOVE_CORRUPTION) then 
			HealBot_RangeSpells["CURE"]=HEALBOT_REMOVE_CORRUPTION
			x=HEALBOT_REMOVE_CORRUPTION
		end
        if HealBot_GetSpellId(HEALBOT_REVIVE) then 
			HealBot_RangeSpells["RES"]=HEALBOT_REVIVE
			x=HEALBOT_REVIVE
		end
        if HealBot_GetSpellId(HEALBOT_REJUVENATION) then 
			HealBot_RangeSpells["HEAL"]=HEALBOT_REJUVENATION 
			x=HEALBOT_REJUVENATION
		end
    elseif HealBot_Data["PCLASSTRIM"]=="MAGE" then
        if HealBot_GetSpellId(HEALBOT_FROSTFIRE_BOLT) then 
            HealBot_RangeSpells["HARM"]=HEALBOT_FROSTFIRE_BOLT -- 40
            x=HEALBOT_FROSTFIRE_BOLT
        elseif HealBot_GetSpellId(HEALBOT_FIRE_BLAST) then 
            HealBot_RangeSpells["HARM"]=HEALBOT_FIRE_BLAST -- 30
            x=HEALBOT_FIRE_BLAST
        end
		if HealBot_GetSpellId(HEALBOT_ARCANE_BRILLIANCE) then 
			HealBot_RangeSpells["BUFF"]=HEALBOT_ARCANE_BRILLIANCE
			x=HEALBOT_ARCANE_BRILLIANCE
		end
		if HealBot_GetSpellId(HEALBOT_REMOVE_CURSE) then 
			HealBot_RangeSpells["CURE"]=HEALBOT_REMOVE_CURSE
			x=HEALBOT_REMOVE_CURSE
		end
    elseif HealBot_Data["PCLASSTRIM"]=="PALA" then
        if HealBot_GetSpellId(HEALBOT_HOLY_SHOCK) then 
            HealBot_RangeSpells["HARM"]=HEALBOT_HOLY_SHOCK -- 40
            x=HEALBOT_HOLY_SHOCK
        elseif HealBot_GetSpellId(HEALBOT_JUDGMENT) then 
			HealBot_RangeSpells["HARM"]=HEALBOT_JUDGMENT -- 30
            x=HEALBOT_JUDGMENT
		end
		if HealBot_GetSpellId(HEALBOT_REDEMPTION) then 
			HealBot_RangeSpells["BUFF"]=HEALBOT_REDEMPTION
			x=HEALBOT_REDEMPTION
		end
		if HealBot_GetSpellId(HEALBOT_CLEANSE) then 
			HealBot_RangeSpells["CURE"]=HEALBOT_CLEANSE
			x=HEALBOT_CLEANSE
		end
		if HealBot_GetSpellId(HEALBOT_REDEMPTION) then 
			HealBot_RangeSpells["RES"]=HEALBOT_REDEMPTION
			x=HEALBOT_REDEMPTION
		end
		if HealBot_GetSpellId(HEALBOT_FLASH_OF_LIGHT) then 
			HealBot_RangeSpells["HEAL"]=HEALBOT_FLASH_OF_LIGHT
			x=HEALBOT_FLASH_OF_LIGHT
		end
    elseif HealBot_Data["PCLASSTRIM"]=="PRIE" then
        if HealBot_GetSpellId(HEALBOT_SHADOW_WORD_PAIN) then 
            HealBot_RangeSpells["HARM"]=HEALBOT_SHADOW_WORD_PAIN 
            x=HEALBOT_SHADOW_WORD_PAIN
        elseif HealBot_GetSpellId(HEALBOT_PENANCE) then 
            HealBot_RangeSpells["HARM"]=HEALBOT_PENANCE 
            x=HEALBOT_PENANCE
        elseif HealBot_GetSpellId(HEALBOT_SMITE) then 
            HealBot_RangeSpells["HARM"]=HEALBOT_SMITE 
            x=HEALBOT_SMITE
        end
		if HealBot_GetSpellId(HEALBOT_POWER_WORD_FORTITUDE) then 
			HealBot_RangeSpells["BUFF"]=HEALBOT_POWER_WORD_FORTITUDE
			x=HEALBOT_POWER_WORD_FORTITUDE
		end
		if HealBot_GetSpellId(HEALBOT_PURIFY) then 
			HealBot_RangeSpells["CURE"]=HEALBOT_PURIFY
			x=HEALBOT_PURIFY
		end
		if HealBot_GetSpellId(HEALBOT_RESURRECTION) then 
			HealBot_RangeSpells["RES"]=HEALBOT_RESURRECTION
			x=HEALBOT_RESURRECTION
		end
		if HealBot_GetSpellId(HEALBOT_FLASH_HEAL) then 
			HealBot_RangeSpells["HEAL"]=HEALBOT_FLASH_HEAL
			x=HEALBOT_FLASH_HEAL
        elseif HealBot_GetSpellId(HEALBOT_PENANCE) then 
            HealBot_RangeSpells["HEAL"]=HEALBOT_PENANCE
            x=HEALBOT_PENANCE
		end
    elseif HealBot_Data["PCLASSTRIM"]=="SHAM" then
        if HealBot_GetSpellId(HEALBOT_LIGHTNING_BOLT) then 
			HealBot_RangeSpells["HARM"]=HEALBOT_LIGHTNING_BOLT -- 30 or 40 depending on Spec
            x=HEALBOT_LIGHTNING_BOLT
		end
		if HealBot_GetSpellId(HEALBOT_EARTH_SHIELD) then 
			HealBot_RangeSpells["BUFF"]=HEALBOT_EARTH_SHIELD
			x=HEALBOT_EARTH_SHIELD
		end
		if HealBot_GetSpellId(HEALBOT_PURIFY_SPIRIT) then 
			HealBot_RangeSpells["CURE"]=HEALBOT_PURIFY_SPIRIT
			x=HEALBOT_PURIFY_SPIRIT
        elseif HealBot_GetSpellId(HEALBOT_CLEANSE_SPIRIT) then 
			HealBot_RangeSpells["CURE"]=HEALBOT_CLEANSE_SPIRIT
			x=HEALBOT_CLEANSE_SPIRIT
		elseif HealBot_GetSpellId(HEALBOT_HEALING_SURGE) then 
			HealBot_RangeSpells["CURE"]=HEALBOT_HEALING_SURGE
			x=HEALBOT_HEALING_SURGE
		end
		if HealBot_GetSpellId(HEALBOT_ANCESTRALSPIRIT) then 
			HealBot_RangeSpells["RES"]=HEALBOT_ANCESTRALSPIRIT
			x=HEALBOT_ANCESTRALSPIRIT
		end
		if HealBot_GetSpellId(HEALBOT_HEALING_SURGE) then 
			HealBot_RangeSpells["HEAL"]=HEALBOT_HEALING_SURGE
			x=HEALBOT_HEALING_SURGE
		end
    elseif HealBot_Data["PCLASSTRIM"]=="MONK" then
        if HealBot_GetSpellId(HEALBOT_CRACKLING_JADE_LIGHTNING) then 
			HealBot_RangeSpells["HARM"]=HEALBOT_CRACKLING_JADE_LIGHTNING  -- 40
            x=HEALBOT_CRACKLING_JADE_LIGHTNING
		end
		if HealBot_GetSpellId(HEALBOT_LEGACY_EMPEROR) then 
			HealBot_RangeSpells["BUFF"]=HEALBOT_LEGACY_EMPEROR
			x=HEALBOT_LEGACY_EMPEROR
		end
		if HealBot_GetSpellId(HEALBOT_DETOX) then 
			HealBot_RangeSpells["CURE"]=HEALBOT_DETOX
			x=HEALBOT_DETOX
		end
		if HealBot_GetSpellId(HEALBOT_RESUSCITATE) then 
			HealBot_RangeSpells["RES"]=HEALBOT_RESUSCITATE
			x=HEALBOT_RESUSCITATE
		end
		if HealBot_GetSpellId(HEALBOT_SOOTHING_MIST) then 
			HealBot_RangeSpells["HEAL"]=HEALBOT_SOOTHING_MIST
			x=HEALBOT_SOOTHING_MIST
		end
    elseif HealBot_Data["PCLASSTRIM"]=="WARL" then
        if HealBot_GetSpellId(HEALBOT_CORRUPTION) then 
			HealBot_RangeSpells["HARM"]=HEALBOT_CORRUPTION -- 40
            x=HEALBOT_CORRUPTION
        elseif HealBot_GetSpellId(HEALBOT_FEAR) then 
			HealBot_RangeSpells["HARM"]=HEALBOT_FEAR -- 30
            x=HEALBOT_FEAR
		end
		if HealBot_GetSpellId(HEALBOT_UNENDING_BREATH) then 
			HealBot_RangeSpells["BUFF"]=HEALBOT_UNENDING_BREATH
			x=HEALBOT_UNENDING_BREATH
		end
    elseif HealBot_Data["PCLASSTRIM"]=="WARR" then
        if HealBot_GetSpellId(HEALBOT_TAUNT) then 
			HealBot_RangeSpells["HARM"]=HEALBOT_TAUNT -- 30 
            x=HEALBOT_TAUNT
		end
        if HealBot_GetSpellId(HEALBOT_VIGILANCE) then 
			HealBot_RangeSpells["BUFF"]=HEALBOT_VIGILANCE 
			x=HEALBOT_VIGILANCE
        elseif HealBot_GetSpellId(HEALBOT_BATTLE_SHOUT) then 
			HealBot_RangeSpells["BUFF"]=HEALBOT_BATTLE_SHOUT 
			x=HEALBOT_BATTLE_SHOUT
		end
    elseif HealBot_Data["PCLASSTRIM"]=="HUNT" then
        if HealBot_GetSpellId(HEALBOT_ARCANE_SHOT) then 
			HealBot_RangeSpells["HARM"]=HEALBOT_ARCANE_SHOT -- 40
            x=HEALBOT_ARCANE_SHOT
        elseif HealBot_GetSpellId(HEALBOT_CONCUSSIVE_SHOT) then 
			HealBot_RangeSpells["HARM"]=HEALBOT_CONCUSSIVE_SHOT -- 40
            x=HEALBOT_CONCUSSIVE_SHOT
        elseif HealBot_GetSpellId(HEALBOT_AIMED_SHOT) then 
			HealBot_RangeSpells["HARM"]=HEALBOT_AIMED_SHOT -- 40
            x=HEALBOT_AIMED_SHOT
		end
		if HealBot_GetSpellId(HEALBOT_MENDPET) then 
			HealBot_RangeSpells["HEAL"]=HEALBOT_MENDPET
			x=HEALBOT_MENDPET
		end
    elseif HealBot_Data["PCLASSTRIM"]=="ROGU" then
        if HealBot_GetSpellId(HEALBOT_THROW) then 
			HealBot_RangeSpells["HARM"]=HEALBOT_THROW -- 30
            x=HEALBOT_THROW
        elseif HealBot_GetSpellId(HEALBOT_GOUGE) then 
			HealBot_RangeSpells["HARM"]=HEALBOT_GOUGE -- 30
            x=HEALBOT_GOUGE
		end
    elseif HealBot_Data["PCLASSTRIM"]=="DEAT" then
        if HealBot_GetSpellId(HEALBOT_DEATH_COIL) then 
			HealBot_RangeSpells["HARM"]=HEALBOT_DEATH_COIL -- 30 
            x=HEALBOT_DEATH_COIL
        elseif HealBot_GetSpellId(HEALBOT_PLAGUE_STRIKE) then 
			HealBot_RangeSpells["HARM"]=HEALBOT_PLAGUE_STRIKE -- 30 
            x=HEALBOT_PLAGUE_STRIKE
		end
    elseif HealBot_Data["PCLASSTRIM"]=="DEMO" then
    end
	if (HealBot_RangeSpells["HEAL"] or HEALBOT_WORDS_UNKNOWN)==HEALBOT_WORDS_UNKNOWN then HealBot_RangeSpells["HEAL"]=x end
	if (HealBot_RangeSpells["BUFF"] or HEALBOT_WORDS_UNKNOWN)==HEALBOT_WORDS_UNKNOWN then HealBot_RangeSpells["BUFF"]=x end
	if (HealBot_RangeSpells["CURE"] or HEALBOT_WORDS_UNKNOWN)==HEALBOT_WORDS_UNKNOWN then HealBot_RangeSpells["CURE"]=x end
	if (HealBot_RangeSpells["RES"] or HEALBOT_WORDS_UNKNOWN)==HEALBOT_WORDS_UNKNOWN then HealBot_RangeSpells["RES"]=x end
    if (HealBot_RangeSpells["HARM"] or HEALBOT_WORDS_UNKNOWN)==HEALBOT_WORDS_UNKNOWN then HealBot_RangeSpells["HARM"]=x end
end

function HealBot_GetBandageType()
    local bandage = nil
    if IsUsableItem(HEALBOT_TIDESPRAY_LINEN_BANDAGE) or HealBot_IsItemInBag(HEALBOT_TIDESPRAY_LINEN_BANDAGE) then bandage = HEALBOT_TIDESPRAY_LINEN_BANDAGE
    elseif IsUsableItem(HEALBOT_DEEP_SEA_BANDAGE) or HealBot_IsItemInBag(HEALBOT_DEEP_SEA_BANDAGE) then bandage = HEALBOT_DEEP_SEA_BANDAGE
    elseif IsUsableItem(HEALBOT_SILKWEAVE_BANDAGE) or HealBot_IsItemInBag(HEALBOT_SILKWEAVE_BANDAGE) then bandage = HEALBOT_SILKWEAVE_BANDAGE
    elseif IsUsableItem(HEALBOT_ASHRAN_BANDAGE) or HealBot_IsItemInBag(HEALBOT_ASHRAN_BANDAGE) then bandage = HEALBOT_ASHRAN_BANDAGE
    elseif IsUsableItem(HEALBOT_HEAVY_WINDWOOL_BANDAGE) or HealBot_IsItemInBag(HEALBOT_HEAVY_WINDWOOL_BANDAGE) then bandage = HEALBOT_HEAVY_WINDWOOL_BANDAGE
    elseif IsUsableItem(HEALBOT_WINDWOOL_BANDAGE) or HealBot_IsItemInBag(HEALBOT_WINDWOOL_BANDAGE) then bandage = HEALBOT_WINDWOOL_BANDAGE
    elseif IsUsableItem(HEALBOT_DENSE_EMBERSILK_BANDAGE) or HealBot_IsItemInBag(HEALBOT_DENSE_EMBERSILK_BANDAGE) then bandage = HEALBOT_DENSE_EMBERSILK_BANDAGE
    elseif IsUsableItem(HEALBOT_HEAVY_EMBERSILK_BANDAGE) or HealBot_IsItemInBag(HEALBOT_HEAVY_EMBERSILK_BANDAGE) then bandage = HEALBOT_HEAVY_EMBERSILK_BANDAGE
    elseif IsUsableItem(HEALBOT_EMBERSILK_BANDAGE) or HealBot_IsItemInBag(HEALBOT_EMBERSILK_BANDAGE) then bandage = HEALBOT_EMBERSILK_BANDAGE
    elseif IsUsableItem(HEALBOT_HEAVY_FROSTWEAVE_BANDAGE) or HealBot_IsItemInBag(HEALBOT_HEAVY_FROSTWEAVE_BANDAGE) then bandage = HEALBOT_HEAVY_FROSTWEAVE_BANDAGE
    elseif IsUsableItem(HEALBOT_FROSTWEAVE_BANDAGE) or HealBot_IsItemInBag(HEALBOT_FROSTWEAVE_BANDAGE) then bandage = HEALBOT_FROSTWEAVE_BANDAGE
    elseif IsUsableItem(HEALBOT_HEAVY_NETHERWEAVE_BANDAGE) or HealBot_IsItemInBag(HEALBOT_HEAVY_NETHERWEAVE_BANDAGE) then bandage = HEALBOT_HEAVY_NETHERWEAVE_BANDAGE
    elseif IsUsableItem(HEALBOT_NETHERWEAVE_BANDAGE) or HealBot_IsItemInBag(HEALBOT_NETHERWEAVE_BANDAGE) then bandage = HEALBOT_NETHERWEAVE_BANDAGE
    elseif IsUsableItem(HEALBOT_HEAVY_RUNECLOTH_BANDAGE) or HealBot_IsItemInBag(HEALBOT_HEAVY_RUNECLOTH_BANDAGE) then bandage = HEALBOT_HEAVY_RUNECLOTH_BANDAGE
    elseif IsUsableItem(HEALBOT_RUNECLOTH_BANDAGE) or HealBot_IsItemInBag(HEALBOT_RUNECLOTH_BANDAGE) then bandage = HEALBOT_RUNECLOTH_BANDAGE
    elseif IsUsableItem(HEALBOT_HEAVY_MAGEWEAVE_BANDAGE) or HealBot_IsItemInBag(HEALBOT_HEAVY_MAGEWEAVE_BANDAGE) then bandage = HEALBOT_HEAVY_MAGEWEAVE_BANDAGE
    elseif IsUsableItem(HEALBOT_MAGEWEAVE_BANDAGE) or HealBot_IsItemInBag(HEALBOT_MAGEWEAVE_BANDAGE) then bandage = HEALBOT_MAGEWEAVE_BANDAGE
    elseif IsUsableItem(HEALBOT_HEAVY_SILK_BANDAGE) or HealBot_IsItemInBag(HEALBOT_HEAVY_SILK_BANDAGE) then bandage = HEALBOT_HEAVY_SILK_BANDAGE
    elseif IsUsableItem(HEALBOT_SILK_BANDAGE) or HealBot_IsItemInBag(HEALBOT_SILK_BANDAGE) then bandage = HEALBOT_SILK_BANDAGE
    elseif IsUsableItem(HEALBOT_HEAVY_WOOL_BANDAGE) or HealBot_IsItemInBag(HEALBOT_HEAVY_WOOL_BANDAGE) then bandage = HEALBOT_HEAVY_WOOL_BANDAGE
    elseif IsUsableItem(HEALBOT_WOOL_BANDAGE) or HealBot_IsItemInBag(HEALBOT_WOOL_BANDAGE) then bandage = HEALBOT_WOOL_BANDAGE
    elseif IsUsableItem(HEALBOT_HEAVY_LINEN_BANDAGE) or HealBot_IsItemInBag(HEALBOT_HEAVY_LINEN_BANDAGE) then bandage = HEALBOT_HEAVY_LINEN_BANDAGE
    elseif IsUsableItem(HEALBOT_LINEN_BANDAGE) or HealBot_IsItemInBag(HEALBOT_LINEN_BANDAGE) then bandage = HEALBOT_LINEN_BANDAGE
    end
    return bandage
end

function HealBot_Action_UpdateHealsInButton(button)
    local ebubar = _G["HealBot_Action_HealUnit"..button.id.."Bar"]
    local ebubar2 = _G["HealBot_Action_HealUnit"..button.id.."Bar2"]
    local uInHeals=button.health.incoming
    if Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IC"]<2 then uInHeals=0 end
    
    if uInHeals>0 and button.status.current<9 then
        local hipct = button.health.current+button.health.incoming
        local hir, hig, hib = 0, 0, 0
        if hipct<button.health.max then 
            hipct=hipct/button.health.max  
         else
            hipct=1;
        end
        if (Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IC"] == 5) then -- Incoming Heal Bar Colour = "Custom"
            hir=Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IR"]
            hig=Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IG"]
            hib=Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IB"]
        elseif (Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IC"] == 4) then -- Incoming Heal Bar Colour = "Future Health"
            hir, hig = HealBot_Action_BarColourPct(hipct)
        else
            hir,hig,hib = ebubar:GetStatusBarColor();
        end
        ebubar2:SetStatusBarColor(hir,hig,hib,Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IA"]);

        if ebubar2:GetValue()~=floor(hipct*100) then
            ebubar2:SetValue(floor(hipct*100));
        end
        ebubar2:SetValue(floor(hipct*100));
    else
        ebubar2:SetValue(0)
        ebubar2:SetStatusBarColor(0,0,0,0);
    end
    HealBot_Action_HBText(button)
  --HealBot_setCall("HealBot_Action_UpdateHealsInButton")
end

function HealBot_Action_UpdateAbsorbsButton(button)
    local ebubar = _G["HealBot_Action_HealUnit"..button.id.."Bar"]
    local ebubar6 = _G["HealBot_Action_HealUnit"..button.id.."Bar6"]
    local uAbsorbs=button.health.absorbs
    if Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AC"]<2 then uAbsorbs=0 end
    
    if uAbsorbs>0 and button.status.current<9 then
        local uInHeals=button.health.incoming
        local har, hag, hab = 0, 0, 0
        if Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IC"]<2 then uInHeals=0 end
        local hapct = button.health.current+uInHeals+uAbsorbs
        if hapct<button.health.max then
            hapct=hapct/button.health.max
        else
            hapct=1;
        end
        if (Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AC"] == 4) then -- Incoming Heal Bar Colour = "Custom"
            har=Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AR"]
            hag=Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AG"]
            hab=Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AB"]
        elseif (Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AC"] == 3) then -- Incoming Heal Bar Colour = "Future Health"
            local hbpct=hapct
            if Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AC"] == 1 then
                hbpct=button.health.current+uAbsorbs
                if hbpct<button.health.max then
                    hbpct=hbpct/button.health.max
                else
                    hbpct=1;
                end
            end
            har, hag = HealBot_Action_BarColourPct(hbpct)
        else
            har,hag,hab = ebubar:GetStatusBarColor();
        end
        ebubar6:SetStatusBarColor(har,hag,hab,Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AA"]);
        if ebubar6:GetValue()~=floor(hapct*100) then
            ebubar6:SetValue(floor(hapct*100));
        end
    else
        ebubar6:SetValue(0)
        ebubar6:SetStatusBarColor(0,0,0,0);
    end
    HealBot_Action_HBText(button)
  --HealBot_setCall("HealBot_Action_UpdateAbsorbsButton")
end

local function HealBot_Action_TextColours(button)
    local ebusr,ebusg,ebusb= 1, 1, 1
    if button.status.current==9 and not hbGUID~=HealBot_Data["PGUID"] then
        if UnitHasIncomingResurrection(button.unit) then
            ebusr,ebusg,ebusb=0.2, 1.0, 0.2
        elseif UnitIsFriend(button.unit, "player") then
            if button.status.range > 0 or UnitInRange(button.unit) then
                ebusr,ebusg,ebusb=1.0, 0.2, 0.2
            else
                ebusr,ebusg,ebusb=0.5, 0.5, 0.5
            end
        else
            ebusr,ebusg,ebusb=0.4, 0.4, 0.4
        end
    elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["CLASSCOL"] then
        ebusr,ebusg,ebusb = HealBot_Action_ClassColour(button.unit);
    elseif button.aura.debuff.type then
        ebusr=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["CR"];
        ebusg=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["CG"];
        ebusb=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["CB"];
    elseif button.status.range<1 and not hbGUID~=HealBot_Data["PGUID"] then
        ebusr=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["DR"]
        ebusg=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["DG"]
        ebusb=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["DB"]
    else
        ebusr=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["ER"] or 1;
        ebusg=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["EG"] or 1;
        ebusb=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["EB"] or 1;
    end
  --HealBot_setCall("HealBot_Action_TextColours")
    return ebusr,ebusg,ebusb
end

local hbCustomDebuffCats={ [9] = HEALBOT_CUSTOM_CAT_CUSTOM_IMPORTANT, 
                          [10] = HEALBOT_CUSTOM_CAT_CUSTOM_DAMAGE, 
                          [11] = HEALBOT_CUSTOM_CAT_CUSTOM_EFFECT, 
                          [12] = HEALBOT_CUSTOM_CAT_CUSTOM_MISC,
                         }
                         
function HealBot_Action_UpdateBackgroundButton(button)
    if Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BACK"]>1 then
        local ebubar5 = _G["HealBot_Action_HealUnit"..button.id.."Bar5"]
        if not UnitExists(button.unit) then
            ebubar5:SetStatusBarColor(0, 0, 0, 0)
        else
            local hbr,hbg,hbb = 0, 0, 0
            if button.status.current<9 then
                if Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BACK"]==2 then
                    hbr,hbg,hbb = HealBot_Action_ClassColour(button.unit)
                else
                    hbr=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BR"]
                    hbg=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BG"]
                    hbb=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BB"]
                end
            end
            ebubar5:SetStatusBarColor(hbr,hbg,hbb,Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BA"]);
        end
    end
  --HealBot_setCall("HealBot_Action_UpdateBackgroundButton")
end

function HealBot_Action_dSpell()
    return HealBot_RangeSpells["CURE"]
end

function HealBot_Action_UpdateDebuffButton(button)
    if button.aura.debuff.type and UnitExists(button.unit) and button.status.current<9 then
        if HealBot_Config_Cures.CDCshownHB then
            HealBot_UpdateUnitRange(button,HealBot_RangeSpells["CURE"],false)
            local prevEnabled=button.status.enabled
            if button.status.range>(HealBot_Config_Cures.HealBot_CDCWarnRange_Bar-3) then
                local hcr,hcg,hcb = 0, 0, 0
                local ebusr,ebusg,ebusb = HealBot_Action_TextColours(button)
                local ebubar = _G["HealBot_Action_HealUnit"..button.id.."Bar"]

                if button.aura.debuff.type == HEALBOT_CUSTOM_en then
                    if HealBot_Globals.CDCBarColour[button.aura.debuff.name] then
                        if HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[button.aura.debuff.name]==nil then
                            hcr = HealBot_Globals.CDCBarColour[button.aura.debuff.name].R
                            hcg = HealBot_Globals.CDCBarColour[button.aura.debuff.name].G
                            hcb = HealBot_Globals.CDCBarColour[button.aura.debuff.name].B
                        else
                            button.status.current=6
                            HealBot_Action_UpdateBuffButton(button)
                            return
                        end
                    else
                        local customDebuffPriority=HEALBOT_CUSTOM_en.."10"
                        if HealBot_GlobalsDefaults.HealBot_Custom_Debuffs[button.aura.debuff.name] then
                            customDebuffPriority=HEALBOT_CUSTOM_en..HealBot_GlobalsDefaults.HealBot_Custom_Debuffs[button.aura.debuff.name]
                        end
                        if not hbCustomDebuffCats[HealBot_GlobalsDefaults.HealBot_Custom_Debuffs[button.aura.debuff.name]] or 
                           HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[hbCustomDebuffCats[HealBot_GlobalsDefaults.HealBot_Custom_Debuffs[button.aura.debuff.name]]]==nil then
                            hcr = HealBot_Globals.CDCBarColour[customDebuffPriority].R
                            hcg = HealBot_Globals.CDCBarColour[customDebuffPriority].G
                            hcb = HealBot_Globals.CDCBarColour[customDebuffPriority].B
                        else
                            button.status.current=6
                            HealBot_Action_UpdateBuffButton(button)
                            return
                        end
                    end
                else
                    hcr = HealBot_Config_Cures.CDCBarColour[button.aura.debuff.type].R
                    hcg = HealBot_Config_Cures.CDCBarColour[button.aura.debuff.type].G
                    hcb = HealBot_Config_Cures.CDCBarColour[button.aura.debuff.type].B
                end
                button.status.current=8
                HealBot_Action_setHealthText(button)
                if button.status.range==1 then  
                    ebubar:SetStatusBarColor(hcr,hcg,hcb,Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"]);
                    HealBot_Action_HBText(button,ebusr,ebusg,ebusb,Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["EA"])
                    if HealBot_UnitBarsRange3a[button.unit]~=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"] then
                        HealBot_UnitBarsRange3a[button.unit]=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"]
                        HealBot_Action_SetBar3Value(button)
                    end
                    button.status.enabled=true
                else
                    ebubar:SetStatusBarColor(hcr,hcg,hcb,Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["ORA"]);
                    HealBot_Action_HBText(button,ebusr,ebusg,ebusb,Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["DA"])
                    if HealBot_UnitBarsRange3a[button.unit]~=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["ORA"] then
                        HealBot_UnitBarsRange3a[button.unit]=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["ORA"]
                        HealBot_Action_SetBar3Value(button)
                    end
                    button.status.enabled=false
                end
            else
                button.status.current=6
                HealBot_Action_UpdateBuffButton(button)
            end
            if prevEnabled~=button.status.enabled then HealBot_Action_ShowHideFrames(button) end
        else
            button.status.current=1
            HealBot_Action_UpdateBuffButton(button)
        end
    else
        if button.status.current==9 then 
            HealBot_Action_UpdateTheDeadButton(button)
        else
            button.status.current=1 
            HealBot_Action_UpdateBuffButton(button)
        end
    end
  --HealBot_setCall("HealBot_Action_UpdateDebuffButton")
end

function HealBot_Action_UpdateBuffButton(button)
    if button.aura.buff.name and button.status.current<8 and UnitExists(button.unit) then
        if UnitIsVisible(button.unit) then
            HealBot_UpdateUnitRange(button,HealBot_RangeSpells["BUFF"],false)
            local hcr,hcg,hcb = 0, 0, 0
            local ebusr,ebusg,ebusb = HealBot_Action_TextColours(button)
            local ebubar = _G["HealBot_Action_HealUnit"..button.id.."Bar"]
            local prevEnabled=button.status.enabled
            hcr,hcg,hcb=HealBot_Options_RetBuffRGB(button.aura.buff.name)  
            button.status.current=7
            HealBot_Action_setHealthText(button)
            if button.status.range==1 then  
                ebubar:SetStatusBarColor(hcr,hcg,hcb,Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"]);
                HealBot_Action_HBText(button,ebusr,ebusg,ebusb,Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["EA"])
                if HealBot_UnitBarsRange3a[button.unit]~=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"] then
                    HealBot_UnitBarsRange3a[button.unit]=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"]
                    HealBot_Action_SetBar3Value(button)
                end
                button.status.enabled=true
            else
                ebubar:SetStatusBarColor(hcr,hcg,hcb,Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["ORA"]);
                HealBot_Action_HBText(button,ebusr,ebusg,ebusb,Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["DA"])
                if HealBot_UnitBarsRange3a[button.unit]~=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["ORA"] then
                    HealBot_UnitBarsRange3a[button.unit]=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["ORA"]
                    HealBot_Action_SetBar3Value(button)
                end
                button.status.enabled=false
            end
            if prevEnabled~=button.status.enabled then HealBot_Action_ShowHideFrames(button) end
        else
            button.status.current=5
            HealBot_Action_UpdateHealthButton(button)
        end
    else
        if button.status.current==9 then 
            HealBot_Action_UpdateTheDeadButton(button)
        else
            button.status.current=1 
            HealBot_Action_UpdateHealthButton(button)
        end
    end
  --HealBot_setCall("HealBot_Action_UpdateBuffButton")
end

function HealBot_Action_UpdateTheDeadButton(button)
     if button.status.current==9 then
        if not UnitIsDeadOrGhost(button.unit) then
            button.status.current=2
            HealBot_UpdateUnitRange(button,HealBot_RangeSpells["HEAL"],false)
            HealBot_Action_UpdateBackgroundButton(button)
            HealBot_Action_setNameTag(button)
            if UnitIsUnit(button.unit,"player") then 
                HealBot_Action_ResetActiveUnitStatus() 
            else
                button.update.state=true
                button.status.update=true
            end
            HealBot_AuraChecks(button)
            button.health.updhealth=true
            button.health.update=true
            if Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][button.frame]["SHOW"] then 
                button.update.targeticon=true
                button.status.update=true
            end
        else
            HealBot_UpdateUnitRange(button,HealBot_RangeSpells["RES"],false)
        end
    elseif UnitIsDeadOrGhost(button.unit) and not UnitIsFeignDeath(button.unit) then
        button.status.current=9
        button.health.updincoming=true
        button.health.updabsorbs=true
        button.health.update=true
        HealBot_Action_UpdateBackgroundButton(button)
        if button.aura.debuff.name then  
            HealBot_ClearDebuff(button)
        end
        if button.aggro.status>0 then
            HealBot_Action_UpdateAggro(button.unit,false,nil,0)
        end
        HealBot_HoT_RemoveIconButton(button)
        if UnitIsUnit(button.unit,"player") then
            HealBot_Action_ResetActiveUnitStatus() 
        else
            button.update.state=true
            button.status.update=true
        end
        if Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][button.frame]["SHOW"] then 
            button.update.targeticon=true
            button.status.update=true
        end
        local ebubar = _G["HealBot_Action_HealUnit"..button.id.."Bar"]
        HealBot_UpdateUnitRange(button,HealBot_RangeSpells["RES"],false)
        HealBot_Action_setHealthText(button)
        HealBot_Action_setNameTag(button)
        ebubar:SetValue(0)
    end
    local ebusr,ebusg,ebusb = HealBot_Action_TextColours(button)
    HealBot_Action_HBText(button,ebusr,ebusg,ebusb,Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["EA"])
  --HealBot_setCall("HealBot_Action_UpdateTheDeadButton")
end

function HealBot_Action_UpdateHealthButton(button)
    local bptc=0
    local ebubar = _G["HealBot_Action_HealUnit"..button.id.."Bar"]
    if UnitExists(button.unit) then
        local hcr,hcg,hcb,hca,hcta,hpct = 0, 0, 0, 0, 0, 0
        if (Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IC"] == 3) then
            hpct = (button.health.current+button.health.incoming)/button.health.max
            if hpct > 1 then hpct = 1 end
            bptc=floor(hpct*100)
        else 
            hpct = button.health.current/button.health.max
            bptc=floor(hpct*100)
        end
        if button.status.current==9 or (UnitIsDeadOrGhost(button.unit) and not UnitIsFeignDeath(button.unit)) then
            HealBot_Action_UpdateTheDeadButton(button)
            return
        elseif button.status.current<7 then 
            HealBot_UpdateUnitRange(button,HealBot_RangeSpells["HEAL"],false)
            local ebusr,ebusg,ebusb = HealBot_Action_TextColours(button)
            local prevEnabled=button.status.enabled
            if (Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HLTH"] >= 2) then
                if (Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HLTH"] == 2) then
                    hcr,hcg,hcb = HealBot_Action_ClassColour(button.unit)
                else
                    hcr=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HR"]
                    hcg=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HG"]
                    hcb=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HB"]
                end
            else
                if (Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IC"] == 3) then
                    hcr, hcg = HealBot_Action_BarColourPct(hpct)
                else
                    hcr, hcg = HealBot_Action_BarColourPct(hpct)
                end
            end

            if button.aggro.status==3 or (HealBot_Data["UILOCK"] and button.health.current<=(button.health.max*Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["ALERTIC"])) or
             (not HealBot_Data["UILOCK"] and button.health.current<=(button.health.max*Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["ALERTOC"])) then
                if button.status.current<5 then button.status.current=4 end
                if button.status.range==1 then
                    button.status.enabled=true
                    hca=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"]
                    hcta=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["EA"]
                else
                    button.status.enabled=false
                    hca=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["ORA"]
                    hcta=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["DA"]
                end
            else
                if button.status.current<5 then button.status.current=0 end
                button.status.enabled=false
                hca=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["DISA"]
                hcta=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["DA"]
            end

            ebubar:SetStatusBarColor(hcr,hcg,hcb,hca);
            if Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BACK"]==1 then
                local ebubar5 = _G["HealBot_Action_HealUnit"..button.id.."Bar5"]
                ebubar5:SetStatusBarColor(hcr,hcg,hcb,Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BA"]);
            end
            if HealBot_UnitBarsRange3a[button.unit]~=hca then
                HealBot_UnitBarsRange3a[button.unit]=hca
                HealBot_Action_SetBar3Value(button)
            end
            HealBot_Action_setHealthText(button)
            HealBot_Action_HBText(button, ebusr,ebusg,ebusb,hcta)
            if prevEnabled~=button.status.enabled then HealBot_Action_ShowHideFrames(button) end
        else
            HealBot_Action_setHealthText(button)
            HealBot_Action_HBText(button)
        end
    else
        button.status.current=2
        button.health.current=0
        HealBot_Action_setHealthText(button)
        ebubar:SetStatusBarColor(0.2,0.2,0.2,0.4);
        local ebubar5 = _G["HealBot_Action_HealUnit"..button.id.."Bar5"]
        ebubar5:SetStatusBarColor(0, 0, 0, 0)
        HealBot_Action_HBText(button, 0.5,0.5,0.5,0.8)
    end
    
                                
    if ebubar:GetValue()~=bptc then
        if not Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["FLUIDBARS"] then
            ebubar:SetValue(bptc)
        else
            HealBot_Action_luVars["UpdateFluidBars"]=true
        end
    end
    if button.status.current>3 and button.status.current<9 and button.status.range==1 then
        if button.health.incoming>0 then HealBot_Action_UpdateHealsInButton(button) end
        if button.health.absorbs>0 then HealBot_Action_UpdateAbsorbsButton(button) end
    else
        HealBot_HealsInUpdate(button)
        HealBot_AbsorbsUpdate(button)
    end
  --HealBot_setCall("HealBot_Action_UpdateHealthButton")
end

function HealBot_Action_BarColourPct(hlthPct)
    local hcpr, hcpg = 1,1
    if hlthPct>=0.98 then 
        hcpr = 0.0
    elseif hlthPct<0.98 and hlthPct>=0.65 then 
        hcpr=2.94-(hlthPct*3)
    elseif hlthPct<=0.64 and hlthPct>0.31 then 
        hcpg=(hlthPct-0.31)*3
    elseif hlthPct<=0.31 then 
        hcpg = 0.0 
    end
  --HealBot_setCall("HealBot_Action_BarColourPct")
    return hcpr, hcpg
end

function HealBot_Action_ShouldHealSome(hbCurFrame)
  --HealBot_setCall("HealBot_Action_ShouldHealSome")
    for _,xButton in pairs(HealBot_Unit_Button) do
        if xButton.frame==hbCurFrame and xButton.status.enabled then
            return true
        end
    end
    return false
end

function HealBot_Action_ShouldHealSomePet(hbCurFrame)
  --HealBot_setCall("HealBot_Action_ShouldHealSome")
    for _,xButton in pairs(HealBot_Pet_Button) do
        if xButton.frame==hbCurFrame and xButton.status.enabled then
            return true
        end
    end
    return false
end

local function HealBot_Action_SetBar3ColAlpha(barName, pct, r, g, b, a, sName)
    barName:SetValue(pct);
    barName:SetStatusBarColor(r,g,b,a);
    local barText = _G[barName:GetName().."Bar3Txt"];
    barText:SetText(sName or "")
  --HealBot_setCall("HealBot_Action_SetBar3ColAlpha")
end

local function HealBot_Action_GetManaBarCol(unit)
    local x, p=UnitPowerType(unit);
    local c=PowerBarColor[p]
    if c then
        return c.r, c.g, c.b
    elseif z==1 then
        return 1,0.1,0.1 -- Rage
    elseif z==2 then
        return 1,0.5,0.25 -- Focus
    elseif z==3 then
        return 1,1,0 -- Energy
    elseif z==4 then
        return 0,1,1 -- Happy
    elseif z==5 then
        return 0.5,0.5,0.5 -- Runes
    elseif z==6 then
        return 0.1,0.8,1 -- Runic power
    elseif z==7 then
        return 0.5,0.32,0.55 -- Soul shards
    elseif z==8 then
        return 0.3,0.52,0.9 -- Eclipse
    elseif z==9 then
        return 0.95,0.9,0.6 -- Holy power
    end
    return 0.1,0.1,1 -- Mana  - z==0
end

local xx,xy,xz=nil,nil,nil
function HealBot_Action_SetBar3Value(button, sName)
    if not button then return end
    local barName = _G["HealBot_Action_HealUnit"..button.id.."Bar3"]
    local unit=button.unit
    if UnitExists(unit) then
        if not UnitIsFriend("player",unit) then
            local cast=button.spells.castpct or -1
            local r, g, b, a = 1, 0.1, 0.1, 1
            if cast>-1 then
                if sName then
                    HealBot_Action_SetBar3ColAlpha(barName, cast, r, g, b, a, sName)
                end
            else
                HealBot_Action_SetBar3ColAlpha(barName, 0, r, g, b, 0)
            end
            HealBot_Action_rCalls[unit]["powerIndicator"]="p9"
        else
            local x,iconName=nil,nil
            if HealBot_pcClass[button.frame] and unit=="player" then
                x = UnitPower("player", HealBot_pcClass[button.frame])
                if x==1 then
                    if HealBot_Action_rCalls[unit]["powerIndicator"]~="p1" then
                        HealBot_Action_rCalls[unit]["powerIndicator"]="p1"
                        iconName = _G[barName:GetName().."Icon"..1];
                        iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_red.tga]]);
                        iconName:SetAlpha(1)
                        iconName = _G[barName:GetName().."Icon"..2];
                        iconName:SetAlpha(0)
                        iconName = _G[barName:GetName().."Icon"..3];
                        iconName:SetAlpha(0)
                        iconName = _G[barName:GetName().."Icon"..4];
                        iconName:SetAlpha(0)
                        iconName = _G[barName:GetName().."Icon"..5];
                        iconName:SetAlpha(0)
                    end
                elseif x==2 then
                    if HealBot_Action_rCalls[unit]["powerIndicator"]~="p2" then
                        HealBot_Action_rCalls[unit]["powerIndicator"]="p2"
                        if HealBot_Action_luVars["UnitPowerMax"]<4 then
                            iconName = _G[barName:GetName().."Icon"..1];
                            iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_yellow.tga]]);
                            iconName:SetAlpha(1)
                            iconName = _G[barName:GetName().."Icon"..2];
                            iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_yellow.tga]]);
                            iconName:SetAlpha(1)
                        else
                            iconName = _G[barName:GetName().."Icon"..1];
                            iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_orange.tga]]);
                            iconName:SetAlpha(1)
                            iconName = _G[barName:GetName().."Icon"..2];
                            iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_orange.tga]]);
                            iconName:SetAlpha(1)
                        end
                        iconName = _G[barName:GetName().."Icon"..3];
                        iconName:SetAlpha(0)
                        iconName = _G[barName:GetName().."Icon"..4];
                        iconName:SetAlpha(0)
                        iconName = _G[barName:GetName().."Icon"..5];
                        iconName:SetAlpha(0)
                    end
                elseif x==3 then
                    if HealBot_Action_rCalls[unit]["powerIndicator"]~="p3" then
                        HealBot_Action_rCalls[unit]["powerIndicator"]="p3"
                        if HealBot_Action_luVars["UnitPowerMax"]<4 then
                            iconName = _G[barName:GetName().."Icon"..1];
                            iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_green.tga]]);
                            iconName:SetAlpha(1)
                            iconName = _G[barName:GetName().."Icon"..2];
                            iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_green.tga]]);
                            iconName:SetAlpha(1)
                            iconName = _G[barName:GetName().."Icon"..3];
                            iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_green.tga]]);
                            iconName:SetAlpha(1)

                        elseif HealBot_Action_luVars["UnitPowerMax"]<5 then
                            iconName = _G[barName:GetName().."Icon"..1];
                            iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_lime.tga]]);
                            iconName:SetAlpha(1)
                            iconName = _G[barName:GetName().."Icon"..2];
                            iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_lime.tga]]);
                            iconName:SetAlpha(1)
                            iconName = _G[barName:GetName().."Icon"..3];
                            iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_lime.tga]]);
                            iconName:SetAlpha(1)

                        else
                            iconName = _G[barName:GetName().."Icon"..1];
                            iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_yellow.tga]]);
                            iconName:SetAlpha(1)
                            iconName = _G[barName:GetName().."Icon"..2];
                            iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_yellow.tga]]);
                            iconName:SetAlpha(1)
                            iconName = _G[barName:GetName().."Icon"..3];
                            iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_yellow.tga]]);
                            iconName:SetAlpha(1)
                        end
                        iconName = _G[barName:GetName().."Icon"..4];
                        iconName:SetAlpha(0)
                        iconName = _G[barName:GetName().."Icon"..5];
                        iconName:SetAlpha(0)
                    end
                elseif x==4 then
                    if HealBot_Action_rCalls[unit]["powerIndicator"]~="p4" then
                        HealBot_Action_rCalls[unit]["powerIndicator"]="p4"
                        if HealBot_Action_luVars["UnitPowerMax"]<5 then
                            iconName = _G[barName:GetName().."Icon"..1];
                            iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_green.tga]]);
                            iconName:SetAlpha(1)
                            iconName = _G[barName:GetName().."Icon"..2];
                            iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_green.tga]]);
                            iconName:SetAlpha(1)
                            iconName = _G[barName:GetName().."Icon"..3];
                            iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_green.tga]]);
                            iconName:SetAlpha(1)
                            iconName = _G[barName:GetName().."Icon"..4];
                            iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_green.tga]]);
                            iconName:SetAlpha(1)

                        else
                            iconName = _G[barName:GetName().."Icon"..1];
                            iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_lime.tga]]);
                            iconName:SetAlpha(1)
                            iconName = _G[barName:GetName().."Icon"..2];
                            iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_lime.tga]]);
                            iconName:SetAlpha(1)
                            iconName = _G[barName:GetName().."Icon"..3];
                            iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_lime.tga]]);
                            iconName:SetAlpha(1)
                            iconName = _G[barName:GetName().."Icon"..4];
                            iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_lime.tga]]);
                            iconName:SetAlpha(1)
                        end
                        iconName = _G[barName:GetName().."Icon"..5];
                        iconName:SetAlpha(0)
                    end
                elseif x==5 then
                    if HealBot_Action_rCalls[unit]["powerIndicator"]~="p5" then
                        HealBot_Action_rCalls[unit]["powerIndicator"]="p5"
                        iconName = _G[barName:GetName().."Icon"..1];
                        iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_green.tga]]);
                        iconName:SetAlpha(1)
                        iconName = _G[barName:GetName().."Icon"..2];
                        iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_green.tga]]);
                        iconName:SetAlpha(1)
                        iconName = _G[barName:GetName().."Icon"..3];
                        iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_green.tga]]);
                        iconName:SetAlpha(1)
                        iconName = _G[barName:GetName().."Icon"..4];
                        iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_green.tga]]);
                        iconName:SetAlpha(1)
                        iconName = _G[barName:GetName().."Icon"..5];
                        iconName:SetAlpha(1)
                    end
                else
                    if HealBot_Action_rCalls[unit]["powerIndicator"]~="p0" then
                        HealBot_Action_rCalls[unit]["powerIndicator"]="p0"
                        iconName = _G[barName:GetName().."Icon"..1];
                        iconName:SetAlpha(0)
                        iconName = _G[barName:GetName().."Icon"..2];
                        iconName:SetAlpha(0)
                        iconName = _G[barName:GetName().."Icon"..3];
                        iconName:SetAlpha(0)
                        iconName = _G[barName:GetName().."Icon"..4];
                        iconName:SetAlpha(0)
                        iconName = _G[barName:GetName().."Icon"..5];
                        iconName:SetAlpha(0)
                        if Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["POWERSIZE"]==0 then
                            HealBot_Action_SetBar3ColAlpha(barName, 0, r, g, b, 0)
                        end
                    end
                end
            end
        end
        if Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["POWERSIZE"]>0 then
            if UnitPowerMax(unit)==0 then
                x=100
            else
                x=UnitPowerMax(unit)
            end
            local y=floor((UnitPower(unit)/x)*100)
            local hcr,hcg,hcb=HealBot_Action_GetManaBarCol(unit)
            HealBot_Action_SetBar3ColAlpha(barName, y, hcr, hcg, hcb, HealBot_UnitBarsRange3a[unit] or Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["DISA"])
        end
    else
        if HealBot_Action_rCalls[unit]["powerIndicator"]~="p0" then
            HealBot_Action_rCalls[unit]["powerIndicator"]="p0"
            iconName = _G[barName:GetName().."Icon"..1];
            iconName:SetAlpha(0)
            iconName = _G[barName:GetName().."Icon"..2];
            iconName:SetAlpha(0)
            iconName = _G[barName:GetName().."Icon"..3];
            iconName:SetAlpha(0)
            iconName = _G[barName:GetName().."Icon"..4];
            iconName:SetAlpha(0)
            iconName = _G[barName:GetName().."Icon"..5];
            iconName:SetAlpha(0)
        end
        HealBot_Action_SetBar3ColAlpha(barName, 0, r, g, b, 0)
    end
  --HealBot_setCall("HealBot_Action_SetBar3Value")
end

local hbLowManaTrig={[1]=1,[2]=2,[3]=3,[9]=30}

function HealBot_Action_setLowManaTrig()
    if Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["LOWMANA"]==2 then
        hbLowManaTrig={[1]=10,[2]=20,[3]=30}
    elseif Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["LOWMANA"]==3 then
        hbLowManaTrig={[1]=15,[2]=30,[3]=45}
    elseif Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["LOWMANA"]==4 then
        hbLowManaTrig={[1]=20,[2]=40,[3]=60}
    elseif Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["LOWMANA"]==5 then
        hbLowManaTrig={[1]=25,[2]=50,[3]=75}
    elseif Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["LOWMANA"]==6 then
        hbLowManaTrig={[1]=30,[2]=60,[3]=90}
    else
        hbLowManaTrig={[1]=1,[2]=2,[3]=3}
    end
  --HealBot_setCall("HealBot_Action_setLowManaTrig")
end

function HealBot_Action_CheckUnitLowMana(button)
    if button then
        local bar = _G["HealBot_Action_HealUnit"..button.id.."Bar"]
        local iconName=nil
        if UnitExists(button.unit) and button.mana.current>0 and button.mana.max>0 and Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["LOWMANA"]>1 then
            local z=floor((button.mana.current/button.mana.max)*100)
            local y=0
            if z<hbLowManaTrig[1] then
                y=1
            elseif z<hbLowManaTrig[2] then
                y=2
            elseif z<hbLowManaTrig[3] then
                y=3
            end
            if y==1 then
                if HealBot_Action_rCalls[button.unit]["manaIndicator"]~="m1" then
                    HealBot_Action_rCalls[button.unit]["manaIndicator"]="m1"
                    iconName = _G[bar:GetName().."Icontm1"];
                    iconName:SetAlpha(1)
                    iconName = _G[bar:GetName().."Icontm2"];
                    iconName:SetAlpha(0)
                    iconName = _G[bar:GetName().."Icontm3"];
                    iconName:SetAlpha(0)
                end
            elseif y==2 then
                if HealBot_Action_rCalls[button.unit]["manaIndicator"]~="m2" then
                    HealBot_Action_rCalls[button.unit]["manaIndicator"]="m2"
                    iconName = _G[bar:GetName().."Icontm1"];
                    iconName:SetAlpha(1)
                    iconName = _G[bar:GetName().."Icontm2"];
                    iconName:SetAlpha(1)
                    iconName = _G[bar:GetName().."Icontm3"];
                    iconName:SetAlpha(0)
                end
            elseif y==3 then
                if HealBot_Action_rCalls[button.unit]["manaIndicator"]~="m3" then
                    HealBot_Action_rCalls[button.unit]["manaIndicator"]="m3"
                    iconName = _G[bar:GetName().."Icontm1"];
                    iconName:SetAlpha(1)
                    iconName = _G[bar:GetName().."Icontm2"];
                    iconName:SetAlpha(1)
                    iconName = _G[bar:GetName().."Icontm3"];
                    iconName:SetAlpha(1)
                end
            else
                if HealBot_Action_rCalls[button.unit]["manaIndicator"]~="m0" then
                    HealBot_Action_rCalls[button.unit]["manaIndicator"]="m0"
                    iconName = _G[bar:GetName().."Icontm1"];
                    iconName:SetAlpha(0)
                    iconName = _G[bar:GetName().."Icontm2"];
                    iconName:SetAlpha(0)
                    iconName = _G[bar:GetName().."Icontm3"];
                    iconName:SetAlpha(0)
                end
            end
        else
            if HealBot_Action_rCalls[button.unit]["manaIndicator"]~="m0" then
                HealBot_Action_rCalls[button.unit]["manaIndicator"]="m0"
                iconName = _G[bar:GetName().."Icontm1"];
                iconName:SetAlpha(0)
                iconName = _G[bar:GetName().."Icontm2"];
                iconName:SetAlpha(0)
                iconName = _G[bar:GetName().."Icontm3"];
                iconName:SetAlpha(0)
            end
        end
    end
  --HealBot_setCall("HealBot_Action_CheckUnitLowMana")
end

function HealBot_CorrectPetHealth(unit,hlth,maxhlth)
    if maxhlth==0 then maxhlth=hlth end
    local hbPetLevel=UnitLevel(unit)
    local targetHlth=25
    if hbPetLevel>110 then
        targetHlth=70000
    elseif hbPetLevel>100 then
        targetHlth=20000
    elseif hbPetLevel>90 then
        targetHlth=14000
    elseif hbPetLevel>80 then
        targetHlth=10000
    elseif hbPetLevel>70 then
        targetHlth=7000
    elseif hbPetLevel>60 then
        targetHlth=5000
    elseif hbPetLevel>40 then
        targetHlth=3000
    elseif hbPetLevel>20 then
        targetHlth=1000
    elseif hbPetLevel>5 then
        targetHlth=500
    end
    if hlth>targetHlth then
        targetHlth=hlth
    end
  --HealBot_setCall("HealBot_CorrectPetHealth")
    return targetHlth
end

local hbFontVal={ ["Accidental Presidency"]=3,
                  ["Alba Super"]=1.4,
                  ["Anime Ace"]=1,
                  ["Ariel Narrow"]=3,
                  ["Blazed"]=1.1,
                  ["Designer Block"]=1.7,
                  ["DestructoBeam BB"]=1.4,
                  ["Diogenes"]=2.1,
                  ["Disko"]=1.9,
                  ["DreamSpeak"]=3,
                  ["Drummon"]=1.5,
                  ["Dustismo"]=1.9,
                  ["Electrofied"]=1.1,
                  ["Emblem"]=1.7,
                  ["Frakturika Spamless"]=2.4,
                  ["Friz Quadrata TT"]=1.6,
                  ["Impact"]=2,
                  ["Liberation Sans"]=1.6,
                  ["Liberation Serif"]=1.8,
                  ["Morpheus"]=1.9,
                  ["Mystic Orbs"]=1.2,
                  ["Pokemon Solid"]=1.9,
                  ["Rock Show Whiplash"]=2.4,
                  ["SF Diego Sans"]=1.5,
                  ["SF Laundromatic"]=3,
                  ["Skurri"]=2.2,
                  ["Solange"]=1.4,
                  ["Star Cine"]=1,
                  ["Trashco"]=1.6,
                  ["Waltograph UI"]=1,
                  ["X360"]=1.4,
                  ["Zekton"]=1.6,
 }

local function HealBot_Action_shortenHealIn(healin, numSuffix, hbCurFrame)
    local isK=true
    if hbNumFormats["Places"][hbCurFrame]<3 then 
        if healin>999999 then
            healin=HealBot_Comm_round(healin/1000000,hbNumFormats["Places"][hbCurFrame]) 
            isK=false
        else
            healin=HealBot_Comm_round(healin/1000,hbNumFormats["Places"][hbCurFrame]) 
        end
    else
        if healin>9999999 then
            healin=HealBot_Comm_round(healin/1000000,0)
            isK=false
        elseif healin>999999 then
            healin=HealBot_Comm_round(healin/1000000,1)
            isK=false
        elseif healin>99999 then
            healin=HealBot_Comm_round(healin/1000,0)
        else
            healin=HealBot_Comm_round(healin/1000,1)
        end
    end
    if isK then
        if hbNumFormats["Suffix"][hbCurFrame]==1 then
            numSuffix="K"
        elseif hbNumFormats["Suffix"][hbCurFrame]==2 then
            numSuffix="k"
        end
    else
        if hbNumFormats["Suffix"][hbCurFrame]==1 then
            numSuffix="M"
        elseif hbNumFormats["Suffix"][hbCurFrame]==2 then
            numSuffix="m"
        end
    end
  --HealBot_setCall("HealBot_Action_shortenHealIn")
    return healin, numSuffix
end

local function HealBot_PercentToHexColor(percent)
    local percent = percent/100
    local r,g,b = 0,1,0
    if percent <= 0 then
        r,g,b = 1,0,0
    elseif percent <= 0.5 then
        r,g,b = 1,percent*2,0
    end 
  --HealBot_setCall("HealBot_PercentToHexColor")
    return string.format("%02x%02x%02x",r*255,g*255,b*255)
end

function HealBot_Action_setHealthText(button)
    local btHBbarText,bthlthdelta=" ",0
    local hbHealInTxt=Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["INCHEALS"]
    local healInTxt=button.health.incoming
    if hbHealInTxt>3 then
        if hbHealInTxt>5 then
            if hbHealInTxt<8 and button.health.current==button.health.max then 
                healInTxt=0
            else
                healInTxt=button.health.incoming+button.health.absorbs 
            end
        end
        if hbHealInTxt==4 or hbHealInTxt==6 or hbHealInTxt==8 then hbHealInTxt=2 end
        if hbHealInTxt==5 or hbHealInTxt==7 or hbHealInTxt==9 then hbHealInTxt=3 end
    elseif button.health.current==button.health.max then 
        healInTxt=0
    end
    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHONBAR"] and button.health.max then
        local numSuffix=""
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTYPE"]==1 then
            if hbHealInTxt==2 then
                bthlthdelta=button.health.current+healInTxt
            else
                bthlthdelta=button.health.current;
            end
            if bthlthdelta>-2 and bthlthdelta<2 then bthlthdelta=0 end
            if hbNumFormats["Places"][button.frame]>-1 then 
                if hbNumFormats["Places"][button.frame]<3 then 
                    if bthlthdelta>999999 then
                        bthlthdelta=HealBot_Comm_round(bthlthdelta/1000000,hbNumFormats["Places"][button.frame]) 
                        if hbNumFormats["Suffix"][button.frame]==1 then
                            numSuffix="M"
                        elseif hbNumFormats["Suffix"][button.frame]==2 then
                            numSuffix="m"
                        end
                    elseif bthlthdelta>9999 then
                        bthlthdelta=HealBot_Comm_round(bthlthdelta/1000,hbNumFormats["Places"][button.frame]) 
                        if hbNumFormats["Suffix"][button.frame]==1 then
                            numSuffix="K"
                        elseif hbNumFormats["Suffix"][button.frame]==2 then
                            numSuffix="k"
                        end
                    end
                else
                    if bthlthdelta>999999 then
                        if bthlthdelta>99999999 then
                            bthlthdelta=HealBot_Comm_round(bthlthdelta/1000000,0) 
                        elseif bthlthdelta>9999999 then
                            bthlthdelta=HealBot_Comm_round(bthlthdelta/1000000,1)  
                        else
                            bthlthdelta=HealBot_Comm_round(bthlthdelta/1000000,2)  
                        end
                        if hbNumFormats["Suffix"][button.frame]==1 then
                            numSuffix="M"
                        elseif hbNumFormats["Suffix"][button.frame]==2 then
                            numSuffix="m"
                        end
                    elseif bthlthdelta>9999 then
                        if bthlthdelta>99999 then
                            bthlthdelta=HealBot_Comm_round(bthlthdelta/1000,0) 
                        else
                            bthlthdelta=HealBot_Comm_round(bthlthdelta/1000,1)   
                        end
                        if hbNumFormats["Suffix"][button.frame]==1 then
                            numSuffix="K"
                        elseif hbNumFormats["Suffix"][button.frame]==2 then
                            numSuffix="k"
                        end
                    end
                end
            end
            btHBbarText=btHBbarText..hbNumFormats["SurroundLeft"][button.frame]..bthlthdelta..numSuffix..hbNumFormats["SurroundRight"][button.frame]
            if healInTxt>0 and hbHealInTxt==3 then
                numSuffix=""
                if hbNumFormats["Places"][button.frame]>-1 and healInTxt>999 then
                    healInTxt, numSuffix=HealBot_Action_shortenHealIn(healInTxt, numSuffix, button.frame)
                end
                btHBbarText=btHBbarText.." +"..healInTxt..numSuffix
            end
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTYPE"]==2 then
            if hbHealInTxt==2 then
                bthlthdelta=(button.health.current+healInTxt)-button.health.max;
            else
                bthlthdelta=button.health.current-button.health.max;
            end
            if hbNumFormats["Places"][button.frame]>-1 then 
                if hbNumFormats["Places"][button.frame]<3 then 
                    if bthlthdelta<-999999 then
                        bthlthdelta=HealBot_Comm_round(bthlthdelta/1000000,hbNumFormats["Places"][button.frame]) 
                        if hbNumFormats["Suffix"][button.frame]==1 then
                            numSuffix="M"
                        elseif hbNumFormats["Suffix"][button.frame]==2 then
                            numSuffix="m"
                        end
                    elseif bthlthdelta<-9999 then
                        bthlthdelta=HealBot_Comm_round(bthlthdelta/1000,hbNumFormats["Places"][button.frame]) 
                        if hbNumFormats["Suffix"][button.frame]==1 then
                            numSuffix="K"
                        elseif hbNumFormats["Suffix"][button.frame]==2 then
                            numSuffix="k"
                        end
                    end
                else
                    if bthlthdelta<-999999 then
                        if bthlthdelta<-99999999 then
                            bthlthdelta=HealBot_Comm_round(bthlthdelta/1000000,0) 
                        elseif bthlthdelta<-9999999 then
                            bthlthdelta=HealBot_Comm_round(bthlthdelta/1000000,1)  
                        else
                            bthlthdelta=HealBot_Comm_round(bthlthdelta/1000000,2)  
                        end
                        if hbNumFormats["Suffix"][button.frame]==1 then
                            numSuffix="M"
                        elseif hbNumFormats["Suffix"][button.frame]==2 then
                            numSuffix="m"
                        end
                    elseif bthlthdelta<-9999 then
                        if bthlthdelta<-99999 then
                            bthlthdelta=HealBot_Comm_round(bthlthdelta/1000,0) 
                        else
                            bthlthdelta=HealBot_Comm_round(bthlthdelta/1000,1)   
                        end
                        if hbNumFormats["Suffix"][button.frame]==1 then
                            numSuffix="K"
                        elseif hbNumFormats["Suffix"][button.frame]==2 then
                            numSuffix="k"
                        end
                    end
                end
            end
            if bthlthdelta>0 then
                btHBbarText=btHBbarText.." "..hbNumFormats["SurroundLeft"][button.frame].."+"..bthlthdelta..numSuffix..hbNumFormats["SurroundRight"][button.frame]
            else
                btHBbarText=btHBbarText..hbNumFormats["SurroundLeft"][button.frame]..bthlthdelta..numSuffix..hbNumFormats["SurroundRight"][button.frame]
            end
            if hbHealInTxt==3 and healInTxt>0 then
                numSuffix=""
                if hbNumFormats["Places"][button.frame]>-1  and healInTxt>999 then 
                    healInTxt, numSuffix=HealBot_Action_shortenHealIn(healInTxt, numSuffix, button.frame)
                end
                btHBbarText=btHBbarText.." +"..healInTxt..numSuffix
            end
        else
            if hbHealInTxt==2 then
                btHBbarText=btHBbarText..hbNumFormats["SurroundLeft"][button.frame]..floor(((button.health.current+healInTxt)/button.health.max)*100).."%"..hbNumFormats["SurroundRight"][button.frame]
            else
                btHBbarText=btHBbarText..hbNumFormats["SurroundLeft"][button.frame]..floor((button.health.current/button.health.max)*100).."%"..hbNumFormats["SurroundRight"][button.frame]
            end
            if hbHealInTxt==3 and floor((healInTxt/button.health.max)*100)>0 then
                btHBbarText=btHBbarText.." +"..floor((healInTxt/button.health.max)*100).."%"
            end
        end

        local vInfo=""
        if UnitInVehicle(button.unit) then
            local vUnit=HealBot_UnitPet(button.unit)
            if vUnit then
                local vName=UnitName(vUnit)
                if vName then
                    local x=UnitHealth(vUnit)
                    local y=UnitHealthMax(vUnit)
                    local hpPerc = floor((x/y)*100)
                    if hpPerc < 1 then 
                        hpPerc = 1
                    end
                    vInfo="  "..hpPerc --string.format("|cff%s%d%%|r", HealBot_PercentToHexColor(hpPerc), hpPerc)
                    local stringLen=hbStringLen(string.gsub(vName, "%s+", ""))+1
                    local bttextlen=hbBarTextLen[button.frame]-stringLen
                    if bttextlen<1 then
                        vInfo = hbStringSub(vName,1,hbBarTextLen[button.frame]) .. '.' ..vInfo
                    else
                        vInfo = vName..vInfo
                    end
                end
            end
        end
        if Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["SHOWTEXTPCT"] and button.aggro.threatpct>0 then 
            btHBbarText=btHBbarText.."  "..HealBot_Action_luVars["NumFormatSurLa"]..button.aggro.threatpct.."%"..HealBot_Action_luVars["NumFormatSurRa"]
        end
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["DOUBLE"] then
            if vUnit then
                btHBbarText = btHBbarText.."\n"..vInfo
            else
                btHBbarText = "\n"..btHBbarText
            end
        elseif vUnit then
                btHBbarText = btHBbarText.."\n"..vInfo
        end

        button.text.health=btHBbarText
    else
        button.text.health=""
    end
  --HealBot_setCall("HealBot_Action_setHealthText")
end

function HealBot_Action_setTextLen(curFrame)
    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][curFrame]["MAXCHARS"]==0 then
        local widthAdj=0.8
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][curFrame]["DOUBLE"] then
            widthAdj=1.7
        end
        local hbFontAdj=hbFontVal[Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][curFrame]["FONT"]] or 2
        hbBarTextLen[curFrame] = floor((hbFontAdj*2)+HealBot_Globals.tsadjmod+((Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][curFrame]["WIDTH"]*widthAdj)
                                /(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][curFrame]["HEIGHT"])
                                -(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][curFrame]["HEIGHT"]/hbFontAdj)))
    else
        hbBarTextLen[curFrame] = Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][curFrame]["MAXCHARS"]
    end
end

function HealBot_Action_setNameTag(button)
    if UnitExists(button.unit) then
        if UnitIsFriend("player",button.unit) then
            if button.status.offline then
                button.text.tag=Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["TAGDC"];
            elseif button.status.current==9 then
                button.text.tag=Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["TAGRIP"];
            elseif button.status.range<1 then
                button.text.tag=Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["TAGOOR"];
            else
                button.text.tag=""
            end
        else
            button.text.tag=""
        end
    else
        button.text.tag=Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["TAGR"]
    end
  --HealBot_setCall("HealBot_Action_setNameTag")
end

function HealBot_Action_setNameText(button)
    local uName=""
    if UnitExists(button.unit) then
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["CLASSONBAR"] and Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["CLASSTYPE"]==2 and UnitClass(button.unit) then
            local clTxt=UnitClass(button.unit)
            if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWROLE"] then
                local hbRole=UnitGroupRolesAssigned(button.unit)
                if hbRole=="NONE" and HealBot_UnitData[button.guid] then
                    hbRole=HealBot_UnitData[button.guid]["ROLE"]
                end
                if hbRole=="DAMAGER" then
                    clTxt=HEALBOT_WORD_DAMAGER
                elseif hbRole=="HEALER" then
                    clTxt=HEALBOT_WORD_HEALER
                elseif hbRole=="TANK" then
                    clTxt=HEALBOT_WORD_TANK
                elseif hbRole=="LEADER" then
                    clTxt=HEALBOT_WORD_LEADER
                else
                    clTxt=UnitClass(button.unit)
                end
            end
            if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["NAMEONBAR"] then
                uName=clTxt..":"..HealBot_GetUnitName(button.unit, button.guid)
            else
                uName=clTxt;
            end
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["NAMEONBAR"] then
            uName=HealBot_GetUnitName(button.unit, button.guid)
        end
        if uName then

            if Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["SHOWTEXT"] and button.aggro.status<4 and 
               (button.aggro.status or 0)>Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["ALERT"] and uName then
                uName=">> "..uName.." <<"
            end
        end
    else
        uName=button.unit
        HealBot_Action_ResetUnitStatus(button)
    end

    local stringLen=hbStringLen(string.gsub(uName, "%s+", ""))+1
    local bttextlen=hbBarTextLen[button.frame]-stringLen
    if bttextlen<1 then
        uName = hbStringSub(uName,1,hbBarTextLen[button.frame]) .. '.'
    end

    button.text.name=uName
  --HealBot_setCall("HealBot_Action_setNameText")
end

function HealBot_Action_HBText(button, r, g, b, a)
    local ebubar = _G["HealBot_Action_HealUnit"..button.id.."Bar"]
    local bartxt = _G[ebubar:GetName().."_text"];
    if r then
        bartxt:SetTextColor(r, g, b, a)
    elseif not UnitExists(button.unit) then
        bartxt:SetTextColor(0.5, 0.5, 0.5, 0.8)
    end
    if UnitExists(button.unit) then
        bartxt:SetText(button.text.tag..button.text.name..button.text.health);
    else
        bartxt:SetText(button.text.tag..button.text.name)
    end
  --HealBot_setCall("HealBot_Action_HBText")
end

function HealBot_Action_ShowDirectionArrow(button)
    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWDIR"] and button.guid~=HealBot_Data["PGUID"] and 
       (not Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWDIRMOUSE"] or button.unit==(HealBot_Data["TIPUNIT"] or "x")) then
        local hbX, hbY, hbD = HealBot_Direction_Check(button.unit)
        if hbD then
            if button.status.dirarrow>99998 then 
                local barDir = _G["HealBot_Action_HealUnit"..button.id.."BarDir"]
                local ebuicon17 = _G["HealBot_Action_HealUnit"..button.id.."BarDirIcon17"];
                ebuicon17:SetTexture("Interface\\AddOns\\HealBot\\Images\\arrow.blp")
                ebuicon17:SetTexCoord(hbX, hbX + 0.109375, hbY, hbY + 0.08203125)
                button.status.dirarrow=hbD
                ebuicon17:Show()
            elseif button.status.dirarrow~=hbD then
                local barDir = _G["HealBot_Action_HealUnit"..button.id.."BarDir"]
                local ebuicon17 = _G["HealBot_Action_HealUnit"..button.id.."BarDirIcon17"];
                ebuicon17:SetTexCoord(hbX, hbX + 0.109375, hbY, hbY + 0.08203125)
                button.status.dirarrow=hbD
            end
            return
        end
    end
    if button.status.dirarrow>99998 then
        HealBot_Action_HideDirectionArrow(button)
    end
  --HealBot_setCall("HealBot_Action_ShowDirectionArrow")
end

function HealBot_Action_HideDirectionArrow(button)
    button.status.dirarrow=99999
    local ebuicon17 = _G["HealBot_Action_HealUnit"..button.id.."BarDirIcon17"];
    ebuicon17:Hide()
end

function HealBot_Action_sethbNumberFormat()
    for j=1,10 do
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT1"]==2 or Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT1"]==5 or Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT1"]==8 then
            hbNumFormats["Places"][j]=0
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT1"]==3 or Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT1"]==6 or Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT1"]==9 then
            hbNumFormats["Places"][j]=1
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT1"]==4 or Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT1"]==7 or Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT1"]==10 then
            hbNumFormats["Places"][j]=2
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT1"]==11 then
            hbNumFormats["Places"][j]=3
        else
            hbNumFormats["Places"][j]=-1
        end
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT1"]>1 and Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT1"]<5 then
            hbNumFormats["Suffix"][j]=1
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT1"]>4 and Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT1"]<8 then
            hbNumFormats["Suffix"][j]=2
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT1"]==11 then
            hbNumFormats["Suffix"][j]=1
        else
            hbNumFormats["Suffix"][j]=0
        end
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT2"]==2 then
            hbNumFormats["SurroundLeft"][j]="("
            hbNumFormats["SurroundRight"][j]=")"
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT2"]==3 then
            hbNumFormats["SurroundLeft"][j]="["
            hbNumFormats["SurroundRight"][j]="]"
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT2"]==4 then
            hbNumFormats["SurroundLeft"][j]="{"
            hbNumFormats["SurroundRight"][j]="}"
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT2"]==5 then
            hbNumFormats["SurroundLeft"][j]="<"
            hbNumFormats["SurroundRight"][j]=">"
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT2"]==6 then
            hbNumFormats["SurroundLeft"][j]="~"
            hbNumFormats["SurroundRight"][j]=""
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT2"]==7 then
            hbNumFormats["SurroundLeft"][j]=":"
            hbNumFormats["SurroundRight"][j]=":"
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT2"]==8 then
            hbNumFormats["SurroundLeft"][j]="*"
            hbNumFormats["SurroundRight"][j]="*"
        else
            hbNumFormats["SurroundLeft"][j]=""
            hbNumFormats["SurroundRight"][j]=""
        end
        if hbNumFormats["Places"][j]==-1 then
            hbNumFormats["Suffix"][j]=0
        end
    end
end

function HealBot_Action_sethbAggroNumberFormat()
    if Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["TEXTFORMAT"]==2 then
        HealBot_Action_luVars["NumFormatSurLa"]="("
        HealBot_Action_luVars["NumFormatSurRa"]=")"
    elseif Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["TEXTFORMAT"]==3 then
        HealBot_Action_luVars["NumFormatSurLa"]="["
        HealBot_Action_luVars["NumFormatSurRa"]="]"
    elseif Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["TEXTFORMAT"]==4 then
        HealBot_Action_luVars["NumFormatSurLa"]="{"
        HealBot_Action_luVars["NumFormatSurRa"]="}"
    elseif Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["TEXTFORMAT"]==5 then
        HealBot_Action_luVars["NumFormatSurLa"]="<"
        HealBot_Action_luVars["NumFormatSurRa"]=">"
    elseif Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["TEXTFORMAT"]==6 then
        HealBot_Action_luVars["NumFormatSurLa"]="~"
        HealBot_Action_luVars["NumFormatSurRa"]=""
    elseif Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["TEXTFORMAT"]==7 then
        HealBot_Action_luVars["NumFormatSurLa"]=":"
        HealBot_Action_luVars["NumFormatSurRa"]=":"
    elseif Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["TEXTFORMAT"]==8 then
        HealBot_Action_luVars["NumFormatSurLa"]="*"
        HealBot_Action_luVars["NumFormatSurRa"]="*"
    else
        HealBot_Action_luVars["NumFormatSurLa"]=""
        HealBot_Action_luVars["NumFormatSurRa"]=""
    end
end

local HealBot_initSkin={[0]={},[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
local function HealBot_DoAction_ResetSkin(barType,button,numcols)
    local frameScale = 1
    local sa = 0.8
    local sb=0.1
    local sg=1
    local sr=1
    local br=0.1
    local bg=0.7
    local bb=0.1
    local ba=0.4
    local b2Size = 0
    local abSize = 2
    local bheight= 20
    local bWidth = 120
    local bOutline = 1
    local btextheight=10
    local btextoutline=1
    if button and button.frame then 
        frameScale = Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][button.frame]["SCALE"]
        sr=Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][button.frame]["R"];
        sg=Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][button.frame]["G"];
        sb=Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][button.frame]["B"];
        sa=Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][button.frame]["A"];
        br=Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][button.frame]["R"];
        bg=Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][button.frame]["G"];
        bb=Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][button.frame]["B"];
        ba=Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][button.frame]["A"];
        b2Size = ceil(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["POWERSIZE"]*frameScale)
        abSize = ceil(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["AGGROSIZE"]*frameScale)
        bheight= ceil(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["HEIGHT"]*frameScale);
        bWidth = ceil(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["WIDTH"]*frameScale);
        bOutline = ceil(Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BOUT"]*frameScale);
        btextheight=ceil(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HEIGHT"]*frameScale);
        btextoutline=Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["OUTLINE"];
    end
    local b,bar,bar2,bar3,bar4,icon,txt,icon17,pIcon,expire,count=nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil
    local icon1,expire1,count1,icon51,expire51,count51=nil,nil,nil,nil,nil,nil
    local barScale,h,hwidth,hheight,iScale,itScale,x,hcpct,bar5,bar6,barDir=nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil
    local abtSize = {[0]=1,[1]=1,[2]=1,[3]=2,[4]=2,[5]=2,[6]=3,[7]=3,[8]=3,[9]=3,[10]=4,[11]=4,[12]=4,[13]=4,[14]=4,[15]=5}
  
    if barType=="bar" then
        b=button;
        if Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["SHOW"]==false and 
           Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["CBAR"]==false and
           Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["TBAR"]==false then 
            abSize=0 
        end
         --for x=1,51 do
        HealBot_ResetBarSkinDone[b.frame][b.id]=true
        HealBot_Action_setHealthText(b)
        HealBot_Action_setTextLen(b.frame)
        HealBot_Action_setNameText(b)
        HealBot_Action_ResetUnitStatus(b)
        bar = _G["HealBot_Action_HealUnit"..b.id.."Bar"]
        bar2 = _G["HealBot_Action_HealUnit"..b.id.."Bar2"]
        bar3 = _G["HealBot_Action_HealUnit"..b.id.."Bar3"]
        bar4 = _G["HealBot_Action_HealUnit"..b.id.."Bar4"]
        bar5 = _G["HealBot_Action_HealUnit"..b.id.."Bar5"]
        bar6 = _G["HealBot_Action_HealUnit"..b.id.."Bar6"]
        barDir = _G["HealBot_Action_HealUnit"..b.id.."BarDir"];
        bar.txt = _G[bar:GetName().."_text"];
        bar3.txt=_G[bar3:GetName().."Bar3Txt"];
        bar:SetHeight(bheight);
        bar:SetWidth(bWidth)
        bar5:SetHeight(bheight+b2Size+(bOutline*2));
        bar5:SetWidth(bWidth+(bOutline*2))
        bar2:SetHeight(bheight);
        bar2:SetWidth(bWidth)
        bar6:SetHeight(bheight);
        bar6:SetWidth(bWidth)
        barDir:SetHeight(bheight);
        barDir:SetWidth(bWidth)
        if Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][b.frame]["OFIX"]==1 then
            bar:SetOrientation("HORIZONTAL");
            bar2:SetOrientation("HORIZONTAL");
            bar3:SetOrientation("HORIZONTAL");
            bar5:SetOrientation("HORIZONTAL");
            bar6:SetOrientation("HORIZONTAL");
        else
            bar:SetOrientation("VERTICAL");
            bar2:SetOrientation("VERTICAL");
            bar3:SetOrientation("VERTICAL");
            bar5:SetOrientation("VERTICAL");
            bar6:SetOrientation("VERTICAL");
        end
        bar5:SetPoint("TOPLEFT",bar,"TOPLEFT",-bOutline,bOutline);
        local gaf = _G["f"..b.frame.."_HealBot_Action"]
        b:SetFrameLevel(gaf:GetFrameLevel()+ 1);    
        bar5:SetFrameLevel(b:GetFrameLevel()+ 1);      -- Background
        bar4:SetFrameLevel(bar5:GetFrameLevel()+ 1);   -- Aggro
        bar6:SetFrameLevel(bar4:GetFrameLevel()+ 1);   -- Absorbs
        bar2:SetFrameLevel(bar6:GetFrameLevel()+ 1);   -- Incoming Heal
        bar:SetFrameLevel(bar2:GetFrameLevel()+ 1);    -- Health
		bar3:SetFrameLevel(bar:GetFrameLevel()+ 1);    -- Mana
        barDir:SetFrameLevel(bar:GetFrameLevel()+ 1); -- Direction Arrow
     --   bar:SetTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][b.frame]["TEXTURE"]),false);
        bar:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][b.frame]["TEXTURE"]));
        bar:GetStatusBarTexture():SetHorizTile(false)
        bar.txt:SetFont(LSM:Fetch('font',Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["FONT"]),
                        btextheight,
                        HealBot_Font_Outline[btextoutline]);
        bar3.txt:SetFont(LSM:Fetch('font',Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["FONT"]),
                        btextheight,
                        HealBot_Font_Outline[btextoutline]);
        bar.txt:ClearAllPoints();
        bar5:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][b.frame]["TEXTURE"]));
        bar5:GetStatusBarTexture():SetHorizTile(false)
        bar6:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][b.frame]["TEXTURE"]));
        bar6:GetStatusBarTexture():SetHorizTile(false)
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["ALIGN"]==1 then
            bar.txt:SetPoint("LEFT",bar,"LEFT",4,0)
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["ALIGN"]==2 then
            bar.txt:SetPoint("CENTER",bar,"CENTER")
        else
            bar.txt:SetPoint("RIGHT",bar,"RIGHT",-4,0)
        end
        bar2:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][b.frame]["TEXTURE"]));
        bar2:GetStatusBarTexture():SetHorizTile(false)
        bar3:SetHeight(b2Size);
        bar3:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][b.frame]["TEXTURE"]));
        bar3:GetStatusBarTexture():SetHorizTile(false)
        bar4:ClearAllPoints();
        bar4:SetPoint("TOPLEFT",bar,"TOPLEFT",0,abSize);
        bar4:SetPoint("TOPRIGHT",bar,"TOPRIGHT",0,abSize);
        if b2Size==0 then
            bar4:SetHeight(bheight+(abSize*2))
        else
            bar4:SetHeight(b2Size+bheight+(abSize*2))
        end
        bar4:SetStatusBarTexture('Interface\\Addons\\HealBot\\Images\\aggro'..abtSize[abSize]..'.tga')
        bar4:GetStatusBarTexture():SetHorizTile(false)
        bar4:SetStatusBarColor(1,0,0,0)
        bar4:SetMinMaxValues(0,100)
        bar4:SetValue(100)
        b:SetHeight(bheight); 
        b:SetWidth(bWidth)
        iScale=(bheight*Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["SCALE"])-2
        icon17 = _G[barDir:GetName().."Icon17"];
        icon17:SetHeight(iScale);
        icon17:SetWidth(iScale);
        barDir:SetHeight(iScale);
        barDir:SetWidth(iScale);
        icon17:Hide()
        icon1=_G[bar:GetName().."Icon1"];
        expire1=_G[bar:GetName().."Expire1"];
        count1=_G[bar:GetName().."Count1"];
        icon51=_G[bar:GetName().."Icon51"];
        expire51=_G[bar:GetName().."Expire51"];
        count51=_G[bar:GetName().."Count51"];
        if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
            iScale=floor(((bheight*Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["SCALE"])-2)*0.485)
        end
        itScale=ceil(iScale*Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][b.frame]["SCALE"])
        for x=1,10 do
            icon=_G[bar:GetName().."Icon"..x];
            expire=_G[bar:GetName().."Expire"..x];
            count=_G[bar:GetName().."Count"..x];
            icon:SetHeight(iScale);
            icon:SetWidth(iScale);
            expire:SetTextHeight(itScale)
            count:SetTextHeight(itScale)
        end
        for x=51,55 do
            icon=_G[bar:GetName().."Icon"..x];
            expire=_G[bar:GetName().."Expire"..x];
            count=_G[bar:GetName().."Count"..x];
            icon:SetHeight(iScale);
            icon:SetWidth(iScale);
            expire:SetTextHeight(itScale)
            count:SetTextHeight(itScale)
        end
        for x=1,3 do
            pIcon = _G[bar:GetName().."Iconal"..x];
            pIcon:SetAlpha(0);
            pIcon = _G[bar:GetName().."Iconar"..x];
            pIcon:SetAlpha(0);
            pIcon = _G[bar:GetName().."Icontm"..x];
            pIcon:SetAlpha(0);
        end
        for x=1,5 do
            pIcon = _G[bar3:GetName().."Icon"..x];
            pIcon:SetAlpha(0);
        end
        if HealBot_Action_luVars["UnitPowerMax"]==3 then
            pIcon = _G[bar3:GetName().."Icon1"];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","-9","0");
            pIcon = _G[bar3:GetName().."Icon2"];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","0","0");
            pIcon = _G[bar3:GetName().."Icon3"];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","9","0");
        elseif HealBot_Action_luVars["UnitPowerMax"]==4 then
            pIcon = _G[bar3:GetName().."Icon1"];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","-12","0");
            pIcon = _G[bar3:GetName().."Icon2"];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","-4","0");
            pIcon = _G[bar3:GetName().."Icon3"];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","4","0");
            pIcon = _G[bar3:GetName().."Icon4"];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","12","0");
        else
            pIcon = _G[bar3:GetName().."Icon1"];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","-14","0");
            pIcon = _G[bar3:GetName().."Icon2"];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","-7","0");
            pIcon = _G[bar3:GetName().."Icon3"];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","0","0");
            pIcon = _G[bar3:GetName().."Icon4"];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","7","0");
            pIcon = _G[bar3:GetName().."Icon5"];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","14","0");
        end
        if not HealBot_initSkin[b.frame][b.id] then
            HealBot_initSkin[b.frame][b.id]=true
            b:Enable();
            bar:SetMinMaxValues(0,100)
            bar2:SetMinMaxValues(0,100);
            bar3:SetMinMaxValues(0,100)
            bar5:SetMinMaxValues(0,100)
            bar6:SetMinMaxValues(0,100)
            bar:SetStatusBarColor(0,1,0,Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][b.frame]["DISA"]);
            bar5:SetStatusBarColor(0,1,0,0);
            bar6:SetStatusBarColor(0,1,0,Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][b.frame]["AA"]);
            local hcpct=100
            if b.health.current<b.health.max then
                hcpct=floor(b.health.current/b.health.max)*100
            end
            bar:SetValue(hcpct)
            HealBot_Panel_SetBarArrays(b.id)
            bar2:SetValue(0);
            bar5:SetValue(100);
            bar6:SetValue(0);
            bar2:SetStatusBarColor(0,1,0,0);
            if b.guid then HealBot_RecalcHeals(b) end
        end
        barDir:ClearAllPoints();
        barDir:SetPoint("TOP",b,"TOP",-1,0);
        if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["ONBAR"]==1 then
            HealBot_Panel_SetMultiColHoToffset(0)
            HealBot_Panel_SetMultiRowHoToffset(0)
            if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["POSITION"]==1 then
                icon1:ClearAllPoints();
                icon1:SetPoint("BOTTOMLEFT",b,"BOTTOMLEFT",1,0);
                expire1:ClearAllPoints();
                expire1:SetPoint("BOTTOMLEFT",icon1,"BOTTOMLEFT",-1,0);
                count1:ClearAllPoints();
                count1:SetPoint("TOPRIGHT",icon1,"TOPRIGHT",5,0);
                for x=2,10 do
                    icon=_G[bar:GetName().."Icon"..x];
                    expire=_G[bar:GetName().."Expire"..x];
                    count=_G[bar:GetName().."Count"..x];
                    icon:ClearAllPoints();
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                        if (x/2)==floor(x/2) then
                            icon:SetPoint("BOTTOMLEFT",bar:GetName().."Icon"..x-1,"TOPLEFT",0,1);
                        else
                            icon:SetPoint("BOTTOMLEFT",bar:GetName().."Icon"..x-2,"BOTTOMRIGHT",1,0);
                        end
                    else
                        icon:SetPoint("BOTTOMLEFT",bar:GetName().."Icon"..x-1,"BOTTOMRIGHT",1,0);
                    end
                    expire:ClearAllPoints();
                    expire:SetPoint("BOTTOMLEFT",icon,"BOTTOMLEFT",-1,0);
                    count:ClearAllPoints();
                    count:SetPoint("TOPRIGHT",icon,"TOPRIGHT",5,0);
                end
                icon51:ClearAllPoints();
                icon51:SetPoint("BOTTOMRIGHT",b,"BOTTOMRIGHT",1,0);
                expire51:ClearAllPoints();
                expire51:SetPoint("BOTTOMLEFT",icon51,"BOTTOMLEFT",-1,0);
                count51:ClearAllPoints();
                count51:SetPoint("TOPRIGHT",icon51,"TOPRIGHT",5,0);
                for x=52,55 do
                    icon=_G[bar:GetName().."Icon"..x];
                    expire=_G[bar:GetName().."Expire"..x];
                    count=_G[bar:GetName().."Count"..x];
                    icon:ClearAllPoints();
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                        if (x/2)==floor(x/2) then
                            icon:SetPoint("BOTTOMRIGHT",bar:GetName().."Icon"..x-1,"TOPRIGHT",0,1);
                        else
                            icon:SetPoint("BOTTOMRIGHT",bar:GetName().."Icon"..x-2,"BOTTOMLEFT",1,0);
                        end
                    else
                        icon:SetPoint("BOTTOMRIGHT",bar:GetName().."Icon"..x-1,"BOTTOMLEFT",1,0);
                    end
                    expire:ClearAllPoints();
                    expire:SetPoint("BOTTOMLEFT",icon,"BOTTOMLEFT",-1,0);
                    count:ClearAllPoints();
                    count:SetPoint("TOPRIGHT",icon,"TOPRIGHT",5,0);
                end
            else
                icon1:ClearAllPoints();
                icon1:SetPoint("BOTTOMRIGHT",b,"BOTTOMRIGHT",-1,0);
                expire1:ClearAllPoints();
                expire1:SetPoint("BOTTOMRIGHT",icon1,"BOTTOMRIGHT",5,0);
                count1:ClearAllPoints();
                count1:SetPoint("TOPLEFT",icon1,"TOPLEFT",-1,0);
                for x=2,10 do
                    icon=_G[bar:GetName().."Icon"..x];
                    expire=_G[bar:GetName().."Expire"..x];
                    count=_G[bar:GetName().."Count"..x];
                    icon:ClearAllPoints();
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                        if (x/2)==floor(x/2) then
                            icon:SetPoint("BOTTOMRIGHT",bar:GetName().."Icon"..x-1,"TOPRIGHT",0,1);
                        else
                            icon:SetPoint("BOTTOMRIGHT",bar:GetName().."Icon"..x-2,"BOTTOMLEFT",-1,0);
                        end
                    else
                        icon:SetPoint("BOTTOMRIGHT",bar:GetName().."Icon"..x-1,"BOTTOMLEFT",-1,0);
                    end
                    expire:ClearAllPoints();
                    expire:SetPoint("BOTTOMRIGHT",icon,"BOTTOMRIGHT",5,0);
                    count:ClearAllPoints();
                    count:SetPoint("TOPLEFT",icon,"TOPLEFT",-1,0);
                end
                icon51:ClearAllPoints();
                icon51:SetPoint("BOTTOMLEFT",b,"BOTTOMLEFT",-1,0);
                expire51:ClearAllPoints();
                expire51:SetPoint("BOTTOMRIGHT",icon51,"BOTTOMRIGHT",5,0);
                count51:ClearAllPoints();
                count51:SetPoint("TOPLEFT",icon51,"TOPLEFT",-1,0);
                for x=52,55 do
                    icon=_G[bar:GetName().."Icon"..x];
                    expire=_G[bar:GetName().."Expire"..x];
                    count=_G[bar:GetName().."Count"..x];
                    icon:ClearAllPoints();
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                        if (x/2)==floor(x/2) then
                            icon:SetPoint("BOTTOMLEFT",bar:GetName().."Icon"..x-1,"TOPLEFT",0,1);
                        else
                            icon:SetPoint("BOTTOMLEFT",bar:GetName().."Icon"..x-2,"BOTTOMRIGHT",-1,0);
                        end
                    else
                        icon:SetPoint("BOTTOMLEFT",bar:GetName().."Icon"..x-1,"BOTTOMRIGHT",-1,0);
                    end
                    expire:ClearAllPoints();
                    expire:SetPoint("BOTTOMRIGHT",icon,"BOTTOMRIGHT",5,0);
                    count:ClearAllPoints();
                    count:SetPoint("TOPLEFT",icon,"TOPLEFT",-1,0);
                end
            end
        elseif Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["ONBAR"]==2 then
            HealBot_Panel_SetMultiColHoToffset((iScale+1)*5)
            HealBot_Panel_SetMultiRowHoToffset(0)
            if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["POSITION"]==1 then
                icon1:ClearAllPoints();
                icon1:SetPoint("BOTTOMRIGHT",b,"BOTTOMLEFT",-1,0);
                expire1:ClearAllPoints();
                expire1:SetPoint("BOTTOMRIGHT",icon1,"BOTTOMRIGHT",5,0);
                count1:ClearAllPoints();
                count1:SetPoint("TOPLEFT",icon1,"TOPLEFT",-1,0);
                for x=2,10 do
                    icon=_G[bar:GetName().."Icon"..x];
                    expire=_G[bar:GetName().."Expire"..x];
                    count=_G[bar:GetName().."Count"..x];
                    icon:ClearAllPoints();
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                        if (x/2)==floor(x/2) then
                            icon:SetPoint("BOTTOMRIGHT",bar:GetName().."Icon"..x-1,"TOPRIGHT",0,1);
                        else
                            icon:SetPoint("BOTTOMRIGHT",bar:GetName().."Icon"..x-2,"BOTTOMLEFT",-1,0);
                        end
                    else
                        icon:SetPoint("BOTTOMRIGHT",bar:GetName().."Icon"..x-1,"BOTTOMLEFT",-1,0);
                    end
                    expire:ClearAllPoints();
                    expire:SetPoint("BOTTOMRIGHT",icon,"BOTTOMRIGHT",5,0);
                    count:ClearAllPoints();
                    count:SetPoint("TOPLEFT",icon,"TOPLEFT",-1,0);
                end
                icon51:ClearAllPoints();
                icon51:SetPoint("BOTTOMLEFT",b,"BOTTOMRIGHT",-1,0);
                expire51:ClearAllPoints();
                expire51:SetPoint("BOTTOMRIGHT",icon51,"BOTTOMRIGHT",5,0);
                count51:ClearAllPoints();
                count51:SetPoint("TOPLEFT",icon51,"TOPLEFT",-1,0);
                for x=52,55 do
                    icon=_G[bar:GetName().."Icon"..x];
                    expire=_G[bar:GetName().."Expire"..x];
                    count=_G[bar:GetName().."Count"..x];
                    icon:ClearAllPoints();
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                        if (x/2)==floor(x/2) then
                            icon:SetPoint("BOTTOMLEFT",bar:GetName().."Icon"..x-1,"TOPLEFT",0,1);
                        else
                            icon:SetPoint("BOTTOMLEFT",bar:GetName().."Icon"..x-2,"BOTTOMRIGHT",-1,0);
                        end
                    else
                        icon:SetPoint("BOTTOMLEFT",bar:GetName().."Icon"..x-1,"BOTTOMRIGHT",-1,0);
                    end
                    expire:ClearAllPoints();
                    expire:SetPoint("BOTTOMRIGHT",icon,"BOTTOMRIGHT",5,0);
                    count:ClearAllPoints();
                    count:SetPoint("TOPLEFT",icon,"TOPLEFT",-1,0);
                end
            else
                icon1:ClearAllPoints();
                icon1:SetPoint("BOTTOMLEFT",b,"BOTTOMRIGHT",2,0);
                expire1:ClearAllPoints();
                expire1:SetPoint("BOTTOMLEFT",icon1,"BOTTOMLEFT",-1,0);
                count1:ClearAllPoints();
                count1:SetPoint("TOPRIGHT",icon1,"TOPRIGHT",5,0);
                for x=2,10 do
                    icon=_G[bar:GetName().."Icon"..x];
                    expire=_G[bar:GetName().."Expire"..x];
                    count=_G[bar:GetName().."Count"..x];
                    icon:ClearAllPoints();
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                        if (x/2)==floor(x/2) then
                            icon:SetPoint("BOTTOMLEFT",bar:GetName().."Icon"..x-1,"TOPLEFT",0,1);
                        else
                            icon:SetPoint("BOTTOMLEFT",bar:GetName().."Icon"..x-2,"BOTTOMRIGHT",1,0);
                        end
                    else
                        icon:SetPoint("BOTTOMLEFT",bar:GetName().."Icon"..x-1,"BOTTOMRIGHT",1,0);
                    end
                    expire:ClearAllPoints();
                    expire:SetPoint("BOTTOMLEFT",icon,"BOTTOMLEFT",-1,0);
                    count:ClearAllPoints();
                    count:SetPoint("TOPRIGHT",icon,"TOPRIGHT",5,0);
                end
                icon51:ClearAllPoints();
                icon51:SetPoint("BOTTOMRIGHT",b,"BOTTOMLEFT",2,0);
                expire51:ClearAllPoints();
                expire51:SetPoint("BOTTOMLEFT",icon51,"BOTTOMLEFT",-1,0);
                count51:ClearAllPoints();
                count51:SetPoint("TOPRIGHT",icon51,"TOPRIGHT",5,0);
                for x=52,55 do
                    icon=_G[bar:GetName().."Icon"..x];
                    expire=_G[bar:GetName().."Expire"..x];
                    count=_G[bar:GetName().."Count"..x];
                    icon:ClearAllPoints();
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                        if (x/2)==floor(x/2) then
                            icon:SetPoint("BOTTOMRIGHT",bar:GetName().."Icon"..x-1,"TOPRIGHT",0,1);
                        else
                            icon:SetPoint("BOTTOMRIGHT",bar:GetName().."Icon"..x-2,"BOTTOMLEFT",1,0);
                        end
                    else
                        icon:SetPoint("BOTTOMRIGHT",bar:GetName().."Icon"..x-1,"BOTTOMLEFT",1,0);
                    end
                    expire:ClearAllPoints();
                    expire:SetPoint("BOTTOMLEFT",icon,"BOTTOMLEFT",-1,0);
                    count:ClearAllPoints();
                    count:SetPoint("TOPRIGHT",icon,"TOPRIGHT",5,0);
                end
            end
        else
            HealBot_Panel_SetMultiColHoToffset(0)
            if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                HealBot_Panel_SetMultiRowHoToffset((iScale*2)+1)
            else
                HealBot_Panel_SetMultiRowHoToffset(iScale+1)
            end
            if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["POSITION"]==1 then
                icon1:ClearAllPoints();
                icon1:SetPoint("TOPLEFT",b,"BOTTOMLEFT",1,-1);
                expire1:ClearAllPoints();
                expire1:SetPoint("BOTTOMLEFT",icon1,"BOTTOMLEFT",-1,0);
                count1:ClearAllPoints();
                count1:SetPoint("TOPRIGHT",icon1,"TOPRIGHT",5,0);
                for x=2,10 do
                    icon=_G[bar:GetName().."Icon"..x];
                    expire=_G[bar:GetName().."Expire"..x];
                    count=_G[bar:GetName().."Count"..x];
                    icon:ClearAllPoints();
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                        if (x/2)==floor(x/2) then
                            icon:SetPoint("TOPLEFT",bar:GetName().."Icon"..x-1,"BOTTOMLEFT",0,-1);
                        else
                            icon:SetPoint("BOTTOMLEFT",bar:GetName().."Icon"..x-2,"BOTTOMRIGHT",1,0);
                        end
                    else
                        icon:SetPoint("BOTTOMLEFT",bar:GetName().."Icon"..x-1,"BOTTOMRIGHT",1,0);
                    end
                    expire:ClearAllPoints();
                    expire:SetPoint("BOTTOMLEFT",icon,"BOTTOMLEFT",-1,0);
                    count:ClearAllPoints();
                    count:SetPoint("TOPRIGHT",icon,"TOPRIGHT",5,0);
                end
                icon51:ClearAllPoints();
                icon51:SetPoint("TOPRIGHT",b,"BOTTOMRIGHT",-1,-1);
                expire51:ClearAllPoints();
                expire51:SetPoint("BOTTOMLEFT",icon51,"BOTTOMLEFT",-1,0);
                count51:ClearAllPoints();
                count51:SetPoint("TOPRIGHT",icon51,"TOPRIGHT",5,0);
                for x=52,55 do
                    icon=_G[bar:GetName().."Icon"..x];
                    expire=_G[bar:GetName().."Expire"..x];
                    count=_G[bar:GetName().."Count"..x];
                    icon:ClearAllPoints();
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                        if (x/2)==floor(x/2) then
                            icon:SetPoint("TOPRIGHT",bar:GetName().."Icon"..x-1,"BOTTOMRIGHT",0,-1);
                        else
                            icon:SetPoint("BOTTOMRIGHT",bar:GetName().."Icon"..x-2,"BOTTOMLEFT",1,0);
                        end
                    else
                        icon:SetPoint("BOTTOMRIGHT",bar:GetName().."Icon"..x-1,"BOTTOMLEFT",1,0);
                    end
                    expire:ClearAllPoints();
                    expire:SetPoint("BOTTOMLEFT",icon,"BOTTOMLEFT",-1,0);
                    count:ClearAllPoints();
                    count:SetPoint("TOPRIGHT",icon,"TOPRIGHT",5,0);
                end
            else
                icon1:ClearAllPoints();
                icon1:SetPoint("TOPRIGHT",b,"BOTTOMRIGHT",-1,-1);
                expire1:ClearAllPoints();
                expire1:SetPoint("BOTTOMRIGHT",icon1,"BOTTOMRIGHT",5,0);
                count1:ClearAllPoints();
                count1:SetPoint("TOPLEFT",icon1,"TOPLEFT",-1,0);
                for x=2,10 do
                    icon=_G[bar:GetName().."Icon"..x];
                    expire=_G[bar:GetName().."Expire"..x];
                    count=_G[bar:GetName().."Count"..x];
                    icon:ClearAllPoints();
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                        if (x/2)==floor(x/2) then
                            icon:SetPoint("TOPRIGHT",bar:GetName().."Icon"..x-1,"BOTTOMRIGHT",0,-1);
                        else
                            icon:SetPoint("BOTTOMRIGHT",bar:GetName().."Icon"..x-2,"BOTTOMLEFT",-1,0);
                        end
                    else
                        icon:SetPoint("BOTTOMRIGHT",bar:GetName().."Icon"..x-1,"BOTTOMLEFT",-1,0);
                    end
                    expire:ClearAllPoints();
                    expire:SetPoint("BOTTOMRIGHT",icon,"BOTTOMRIGHT",5,0);
                    count:ClearAllPoints();
                    count:SetPoint("TOPLEFT",icon,"TOPLEFT",-1,0);
                end
                icon51:ClearAllPoints();
                icon51:SetPoint("TOPLEFT",b,"BOTTOMLEFT",-1,-1);
                expire51:ClearAllPoints();
                expire51:SetPoint("BOTTOMRIGHT",icon51,"BOTTOMRIGHT",5,0);
                count51:ClearAllPoints();
                count51:SetPoint("TOPLEFT",icon51,"TOPLEFT",-1,0);
                for x=52,55 do
                    icon=_G[bar:GetName().."Icon"..x];
                    expire=_G[bar:GetName().."Expire"..x];
                    count=_G[bar:GetName().."Count"..x];
                    icon:ClearAllPoints();
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                        if (x/2)==floor(x/2) then
                            icon:SetPoint("TOPLEFT",bar:GetName().."Icon"..x-1,"BOTTOMLEFT",0,-1);
                        else
                            icon:SetPoint("BOTTOMLEFT",bar:GetName().."Icon"..x-2,"BOTTOMRIGHT",-1,0);
                        end
                    else
                        icon:SetPoint("BOTTOMLEFT",bar:GetName().."Icon"..x-1,"BOTTOMRIGHT",-1,0);
                    end
                    expire:ClearAllPoints();
                    expire:SetPoint("BOTTOMRIGHT",icon,"BOTTOMRIGHT",5,0);
                    count:ClearAllPoints();
                    count:SetPoint("TOPLEFT",icon,"TOPLEFT",-1,0);
                end
            end
        end

        if Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][b.frame]["POWERSIZE"]==0 then
            bar3:SetHeight(1);
            bar3:SetValue(0);
            bar3:SetStatusBarColor(0,0,0,0)
        elseif b.guid then 
            HealBot_Action_SetBar3Value(b)
        end
        if Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["SHOWBARS"]==false and 
           Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["CBAR"]==false and
           Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["TBAR"]==false then
            bar4:SetMinMaxValues(0,100)
            bar4:SetValue(0)
            bar4:SetStatusBarColor(0,0,0,0)
        end
        --barScale = bar:GetScale();
        --bar:SetScale(barScale + 0.01);
        --bar:SetScale(barScale);
        --barScale = bar2:GetScale();
        --bar2:SetScale(barScale + 0.01);
        --bar2:SetScale(barScale);
        --barScale = bar3:GetScale();
        --bar3:SetScale(barScale + 0.01);
        --bar3:SetScale(barScale);
        --barScale = bar4:GetScale();
        --bar4:SetScale(barScale + 0.01);
        --bar4:SetScale(barScale);
        --barScale = bar5:GetScale();
        --bar5:SetScale(barScale + 0.01);
        --bar5:SetScale(barScale);
        --barScale = bar6:GetScale();
        --bar6:SetScale(barScale + 0.01);
        --bar6:SetScale(barScale);
    elseif barType=="header" then
          --for x=1,15 do
        h=button
        bar = _G[h:GetName().."Bar"]
        hwidth = ceil(bWidth*Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][h.frame]["WIDTH"])
        hheight = ceil((bheight+Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][h.frame]["POWERSIZE"])*Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][h.frame]["HEIGHT"])
        HealBot_Panel_SetHeadArrays(h.id)
        h:SetHeight(hheight);
        h:SetWidth(hwidth);
        bar:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][h.frame]["TEXTURE"]));
        bar:GetStatusBarTexture():SetHorizTile(false)
        bar:SetMinMaxValues(0,100);
        bar:SetValue(100);
        bar:SetStatusBarColor(br,bg,bb,ba);
        bar:SetHeight(hheight);
        bar:SetWidth(hwidth);
        bar.txt = _G[bar:GetName().."_text"];
        bar.txt:SetFont(LSM:Fetch('font',Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][h.frame]["FONT"]),
                                Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][h.frame]["HEIGHT"],
                                HealBot_Font_Outline[Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][h.frame]["OUTLINE"]]);
        bar.txt:SetTextColor(sr,sg,sb,sa);
        h:Disable();
        --barScale = bar:GetScale();
        --bar:SetScale(barScale + 0.01);
        --bar:SetScale(barScale);
    elseif barType=="hbfocus" then
        bar = _G["HealBot_Action_HealUnit"..button.id.."Bar"]
        bar:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["TEXTURE"]));
        bar:GetStatusBarTexture():SetHorizTile(false)

        bar:SetStatusBarColor(1,1,1,1);
        bar.txt = _G[bar:GetName().."_text"];
        bar.txt:SetFont(LSM:Fetch('font',Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["FONT"]),
                                            btextheight,
                                            HealBot_Font_Outline[btextoutline]);
        bar.txt:SetTextColor(0,0,0,1);
        iScale=0.84
        iScale=iScale+(numcols/10)
        bar:SetWidth(bWidth*iScale)
        button:SetWidth(bWidth*iScale)
        bar:SetHeight(bheight); 
        button:SetHeight(bheight); 
        bar.txt:SetText(HEALBOT_ACTION_HBFOCUS)
        --barScale = bar:GetScale();
        --bar:SetScale(barScale + 0.01);
        --bar:SetScale(barScale);
    else
        HealBot_Action_SetAddHeightWidth()
        HealBot_Panel_clearResetHeaderSkinDone()
        HealBot_Action_clearResetBarSkinDone()
        HealBot_setOptions_Timer(80)
        if HealBot_Action_luVars["resetSkinTo"]~=Healbot_Config_Skins.Current_Skin then
            HealBot_Action_luVars["resetSkinTo"]=Healbot_Config_Skins.Current_Skin
            HealBot_setOptions_Timer(800)
            for x=1,10 do
                local gaf = _G["f"..x.."_HealBot_Action"]
                HealBot_CheckFrame(x, gaf)
            end
        end
        HealBot_setOptions_Timer(595)
    end
  --HealBot_setCall("HealBot_DoAction_ResetSkin")
end

function HealBot_Action_ResetSkin(barType,button,numcols)
    HealBot_DoAction_ResetSkin(barType,button,numcols)
end

function HealBot_Action_CheckReserved()
    for xUnit,xButton in pairs(HealBot_Unit_Button) do
        if xButton.status.reserved and UnitExists(xUnit) then
            xButton.status.reserved=false
            HealBot_UnitNameUpdate(xUnit)
        end
    end
    for xUnit,xButton in pairs(HealBot_Enemy_Button) do
        if xButton.status.reserved and UnitExists(xUnit) then
            xButton.status.reserved=false
            HealBot_UnitNameUpdate(xUnit)
        end
    end
  --HealBot_setCall("HealBot_Action_CheckReserved")
end

function HealBot_Action_ShowPanel(hbCurFrame)
    if HealBot_Config.DisabledNow==0 then
        local g = _G["f"..hbCurFrame.."_HealBot_Action"]
        if not g:IsVisible() then 
            ShowUIPanel(g)
        end
    end
end

function HealBot_Action_HidePanel(hbCurFrame)
    local g = _G["f"..hbCurFrame.."_HealBot_Action"]
    if g:IsVisible() then 
        HideUIPanel(g)
    end
end

function HealBot_Action_ResetUnitStatus(button)
    if button then
        button.update.state=true
        button.status.update=true
    else
        for _,xButton in pairs(HealBot_Unit_Button) do
            xButton.update.state=true
            xButton.status.update=true
        end
        for _,xButton in pairs(HealBot_Pet_Button) do
            xButton.update.state=true
            xButton.status.update=true
        end
    end
  --HealBot_setCall("HealBot_Action_ResetUnitStatus")
end

function HealBot_Action_ResetActiveUnitStatus()
    for xUnit,xButton in pairs(HealBot_Unit_Button) do
        if not xButton.status.reserved and xButton.status.current>3 then
            xButton.update.state=true
            xButton.status.update=true
        end
    end
    for xUnit,xButton in pairs(HealBot_Pet_Button) do
        if not xButton.status.reserved and xButton.status.current>3 then
            xButton.update.state=true
            xButton.status.update=true
        end
    end
  --HealBot_setCall("HealBot_Action_ResetActiveUnitStatus")
end

local resSpellsCastTime={}
function HealBot_Action_SetResSpells()
    local castTime = nil
    _, _, _, castTime, _, _ = GetSpellInfo(HEALBOT_DEBUFF_MASS_RESURRECTED)
    resSpellsCastTime[HEALBOT_DEBUFF_MASS_RESURRECTED] = ceil((castTime or 10000)/1000)
    _, _, _, castTime, _, _ = GetSpellInfo(HEALBOT_RESUSCITATE)
    resSpellsCastTime[HEALBOT_RESUSCITATE] = ceil((castTime or 7000)/1000)
    _, _, _, castTime, _, _ = GetSpellInfo(HEALBOT_REVIVE)
    resSpellsCastTime[HEALBOT_REVIVE] = ceil((castTime or 10000)/1000)
    _, _, _, castTime, _, _ = GetSpellInfo(HEALBOT_REDEMPTION)
    resSpellsCastTime[HEALBOT_REDEMPTION] = ceil((castTime or 10000)/1000)
    _, _, _, castTime, _, _ = GetSpellInfo(HEALBOT_REBIRTH)
    resSpellsCastTime[HEALBOT_REBIRTH] = ceil((castTime or 2000)/1000)
    _, _, _, castTime, _, _ = GetSpellInfo(HEALBOT_ANCESTRALSPIRIT)
    resSpellsCastTime[HEALBOT_ANCESTRALSPIRIT] = ceil((castTime or 10000)/1000)
    _, _, _, castTime, _, _ = GetSpellInfo(HEALBOT_RESURRECTION)
    resSpellsCastTime[HEALBOT_RESURRECTION] = ceil((castTime or 10000)/1000)
end

function HealBot_Action_ResetrCalls()
    for xUnit,_ in pairs(HealBot_Unit_Button) do
        HealBot_Action_rCalls[xUnit]={["aggroIndicator"]="notSet",["powerIndicator"]="notSet",["manaIndicator"]="notSet",["barText"]="notSet",}
    end
    for xUnit,_ in pairs(HealBot_Pet_Button) do
        HealBot_Action_rCalls[xUnit]={["aggroIndicator"]="notSet",["powerIndicator"]="notSet",["manaIndicator"]="notSet",["barText"]="notSet",}
    end
end 

local function HealBot_Action_CreateButton(hbCurFrame)
    if HealBot_ActiveButtons[0]>998 then HealBot_ActiveButtons[0]=1 end
    local tryId,freeId=HealBot_ActiveButtons[0],nil
    if not HealBot_ActiveButtons[tryId] then
        freeId=tryId
    else
        for i=1,998 do
            if not HealBot_ActiveButtons[i] then
                freeId=i
                break
            end
        end
    end
    if freeId then 
        HealBot_ActiveButtons[freeId]=true 
        local gn="HealBot_Action_HealUnit"..freeId
        local gp=_G["f"..hbCurFrame.."_HealBot_Action"]
        local ghb=_G[gn]
        if not ghb then 
            ghb=CreateFrame("Button", gn, gp, "HealBotButtonSecureTemplate") 
            HealBot_Action_setRegisterForClicks(ghb)
            ghb.frame=hbCurFrame
            ghb.id=freeId
        elseif ghb.frame~=hbCurFrame then
            ghb.frame=0
        end
        ghb.guid="nil"
        ghb.unit="nil"
        if not ghb.aura then
            ghb.aura={}
            ghb.aura.buff={}
            ghb.aura.debuff={}
            ghb.status={}
            ghb.update={}
            ghb.checks={}
            ghb.health={}
            ghb.spells={}
            ghb.aggro={}
            ghb.mana={}
            ghb.text={}
            ghb.icon={}
            ghb.icon.debuff={}
            ghb.icon.buff={}
        end
        ghb.health.current=0
        ghb.health.max=100
        ghb.health.incoming=0
        ghb.health.absorbs=0
        ghb.health.update=false
        ghb.health.updhealth=false
        ghb.health.updincoming=false
        ghb.health.updabsorbs=false
        ghb.mana.current=0
        ghb.mana.max=0
        ghb.status.current=0
        ghb.status.update=0
        ghb.update.reset=false
        ghb.update.unit=false
        ghb.update.state=false
        ghb.update.roleicon=false
        ghb.update.targeticon=false
        ghb.status.range=-2
        ghb.status.unittype=1
        ghb.status.offline=false
        ghb.status.enabled=false
        ghb.status.dirarrow=99999 
        ghb.status.reserved=false
        ghb.status.bar4=0
        ghb.checks.range=GetTime()+1000000
        ghb.checks.other=GetTime()+1000000
        ghb.spells.castpct=-1
        ghb.aura.buff.name=false
        ghb.icon.buff.count=0
        ghb.aura.debuff.type=false
        ghb.aura.debuff.name=false
        ghb.icon.debuff.count=0
        ghb.icon.debuff.targeticon=0
        ghb.icon.debuff.classtexture=false
        ghb.icon.debuff.readycheck=false
        ghb.aura.debuff.priority=99
        ghb.aura.buff.check=false
        ghb.aura.debuff.check=false
        ghb.aggro.status=0
        ghb.aggro.threatpct=0
        ghb.text.health="100"
        ghb.text.name=" "
        ghb.text.tag=""
        local bar = _G["HealBot_Action_HealUnit"..ghb.id.."Bar"]
        local bar2 = _G["HealBot_Action_HealUnit"..ghb.id.."Bar2"] 
        local bar3 = _G["HealBot_Action_HealUnit"..ghb.id.."Bar3"] 
        local bar4 = _G["HealBot_Action_HealUnit"..ghb.id.."Bar4"] 
        local bar5 = _G["HealBot_Action_HealUnit"..ghb.id.."Bar5"]
        local bar6 = _G["HealBot_Action_HealUnit"..ghb.id.."Bar6"]
        local barDir = _G["HealBot_Action_HealUnit"..ghb.id.."BarDir"]
        bar:UnregisterAllEvents()
        bar2:UnregisterAllEvents()
        bar3:UnregisterAllEvents()
        bar4:UnregisterAllEvents()
        bar5:UnregisterAllEvents()
        bar6:UnregisterAllEvents()
        barDir:UnregisterAllEvents()
        HealBot_ActiveButtons[0]=freeId+1
        return ghb
    else
        return nil
    end
end

local HealBot_Keys_List = {"","Shift","Ctrl","Alt","Alt-Shift","Ctrl-Shift","Alt-Ctrl"}
local hbAttribsMinReset = {}
local HB_button,HB_prefix=nil,nil

--local mUnit=nil
local mText=nil
local showmenu=nil
local showHBmenu=nil
local setDropdown=nil
local partyNo=nil

local function HealBot_Action_AttribSpellPattern(HB_combo_prefix)
    local hbCombos = HealBot_Config_Spells.EnabledKeyCombo
    local hbTarget = HealBot_Config_Spells.EnabledSpellTarget
    local hbTrinket1 = HealBot_Config_Spells.EnabledSpellTrinket1
    local hbTrinket2 = HealBot_Config_Spells.EnabledSpellTrinket2
    local hbAvoidBC  = HealBot_Config_Spells.EnabledAvoidBlueCursor
    if not hbCombos then 
        return nil 
    end
    return hbCombos[HB_combo_prefix], hbTarget[HB_combo_prefix] or false, hbTrinket1[HB_combo_prefix] or false, hbTrinket2[HB_combo_prefix] or false, hbAvoidBC[HB_combo_prefix] or false
end

local function HealBot_Action_AttribDisSpellPattern(HB_combo_prefix)
    local hbCombos = HealBot_Config_Spells.DisabledKeyCombo
    local hbTarget = HealBot_Config_Spells.DisabledSpellTarget
    local hbTrinket1 = HealBot_Config_Spells.DisabledSpellTrinket1
    local hbTrinket2 = HealBot_Config_Spells.DisabledSpellTrinket2
    local hbAvoidBC  = HealBot_Config_Spells.DisabledAvoidBlueCursor
    if not hbCombos then 
        return nil 
    end
    return hbCombos[HB_combo_prefix], hbTarget[HB_combo_prefix] or false, hbTrinket1[HB_combo_prefix] or false, hbTrinket2[HB_combo_prefix] or false, hbAvoidBC[HB_combo_prefix] or false
end

local function HealBot_Action_AttribEnemySpellPattern(HB_combo_prefix)
    local hbCombos = HealBot_Config_Spells.EnemyKeyCombo
    local hbTarget = HealBot_Config_Spells.EnemySpellTarget
    local hbTrinket1 = HealBot_Config_Spells.EnemySpellTrinket1
    local hbTrinket2 = HealBot_Config_Spells.EnemySpellTrinket2
    local hbAvoidBC  = HealBot_Config_Spells.EnemyAvoidBlueCursor
    if not hbCombos then 
        return nil 
    end
    return hbCombos[HB_combo_prefix], hbTarget[HB_combo_prefix] or false, hbTrinket1[HB_combo_prefix] or false, hbTrinket2[HB_combo_prefix] or false, hbAvoidBC[HB_combo_prefix] or false
end

local hbCustomName={}
local function HealBot_Action_CustomName(cName)
    local xGUID=hbCustomName["GUID"]
    local isAdd=hbCustomName["isAdd"]
    local isPerm=hbCustomName["isPerm"]
    if isAdd then
        if isPerm then
            HealBot_Globals.HealBot_customPermUserName[xGUID]=cName
        end
        HealBot_customTempUserName[xGUID]=cName
    else
        if isPerm then
            HealBot_Globals.HealBot_customPermUserName[xGUID]=nil
        else
            HealBot_customTempUserName[xGUID]=nil
        end
    end
end

local function HealBot_Action_GetCustomNameDialog(hbGUID, isAdd, isPerm)
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

local function HealBot_Action_DelCustomName(hbGUID, isAdd, isPerm)
    hbCustomName["GUID"]=hbGUID
    hbCustomName["isAdd"]=isAdd
    hbCustomName["isPerm"]=isPerm
    HealBot_Action_CustomName()
end

local function HealBot_Action_hbmenuFrame_DropDown_Initialize(self,level,menuList)
    local info
    level = level or 1;
    if level==1 then
 
        xButton=HealBot_Unit_Button[self.unit]
        info = UIDropDownMenu_CreateInfo();
        info.isTitle = 1
        info.text = self.name
        UIDropDownMenu_AddButton(info, 1);
        
        info = UIDropDownMenu_CreateInfo();
        info.hasArrow = false; 
        info.notCheckable = true;
        if HealBot_Action_RetMyTarget(HealBot_UnitGUID(self.unit)) then
            info.text = HEALBOT_SKIN_DISTEXT;
        else
            info.text = HEALBOT_SKIN_ENTEXT;
        end
        info.func = function() HealBot_Action_Toggle_Enabled(xButton); end
        UIDropDownMenu_AddButton(info, 1);

        info = UIDropDownMenu_CreateInfo();
        info.notCheckable = true;
        info.text = HEALBOT_WORDS_CUSTOMNAME
        info.hasArrow = true; 
        info.menuList = "cNames"
        UIDropDownMenu_AddButton(info, 1);
        
        
        info = UIDropDownMenu_CreateInfo();
        info.hasArrow = false; 
        info.notCheckable = true;
        if HealBot_Panel_RetMyHealTarget(self.unit) then
            info.text = HEALBOT_WORDS_REMOVEFROM.." "..HEALBOT_OPTIONS_TARGETHEALS;
        else
            info.text = HEALBOT_WORDS_ADDTO.." "..HEALBOT_OPTIONS_TARGETHEALS
        end
        info.func = function() HealBot_Panel_ToggelHealTarget(self.unit); end;
        UIDropDownMenu_AddButton(info, 1);
        
        info = UIDropDownMenu_CreateInfo();
        info.hasArrow = false; 
        info.notCheckable = true;
        if HealBot_Panel_RetPrivateTanks(self.unit) then
            info.text = HEALBOT_WORDS_REMOVEFROM.." "..HEALBOT_OPTIONS_PRIVATETANKS;
        else
            info.text = HEALBOT_WORDS_ADDTO.." "..HEALBOT_OPTIONS_PRIVATETANKS
        end
        info.func = function() HealBot_Panel_ToggelPrivateTanks(self.unit); end;
        UIDropDownMenu_AddButton(info, 1);

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
        
        info = UIDropDownMenu_CreateInfo();
        info.hasArrow = false; 
        info.notCheckable = true;
        info.text = HEALBOT_WORD_RESET
        info.func = function() HealBot_Reset_Unit(xButton); end
        UIDropDownMenu_AddButton(info, 1);
        
        info = UIDropDownMenu_CreateInfo();
        info.hasArrow = false; 
        info.notCheckable = true;
        info.text = HEALBOT_PANEL_BLACKLIST
        info.func = function() HealBot_Panel_AddBlackList(HealBot_UnitGUID(self.unit)); end
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
        if HealBot_Globals.HealBot_customPermUserName[HealBot_UnitGUID(self.unit)] then
            info.text = HEALBOT_WORDS_REMOVEPERMCUSTOMNAME
            info.func = function() HealBot_Action_DelCustomName(HealBot_UnitGUID(self.unit), false, true); end;
        else
            info.text = HEALBOT_WORDS_ADDPERMCUSTOMNAME
            info.func = function() HealBot_Action_GetCustomNameDialog(HealBot_UnitGUID(self.unit), true, true); end;
        end
        UIDropDownMenu_AddButton(info, 2);
    
        info = UIDropDownMenu_CreateInfo();
        info.hasArrow = false; 
        info.notCheckable = true;
        if HealBot_customTempUserName[HealBot_UnitGUID(self.unit)] then
            info.text = HEALBOT_WORDS_REMOVETEMPCUSTOMNAME
            info.func = function() HealBot_Action_DelCustomName(HealBot_UnitGUID(self.unit), false, false); end;
        else
            info.text = HEALBOT_WORDS_ADDTEMPCUSTOMNAME
            info.func = function() HealBot_Action_GetCustomNameDialog(HealBot_UnitGUID(self.unit), true, false); end;
        end
        UIDropDownMenu_AddButton(info, 2);
    elseif menuList=="hbFocus" then
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
end

local function HealBot_Action_AlterSpell2Macro(spellName, spellTar, spellTrin1, spellTrin2, spellAvoidBC, unit, status)
    local smName=""
    local scText=""
    local spellType="help"
    if status=="Enemy" then spellType="harm" end
    scText="/cast [@"..unit..","..spellType.."] "..spellName..";\n"

    if HealBot_Globals.MacroSuppressSound==1 then smName=smName.."/console Sound_EnableSFX 0;\n" end
    if HealBot_Globals.MacroSuppressSound==1 then smName=smName.."/console Sound_EnableErrorSpeech 0;\n" end
    if spellTar then smName=smName.."/target "..unit..";\n" end
    if spellTrin1 then smName=smName.."/use 13;\n" end
    if spellTrin2 then smName=smName.."/use 14;\n" end
    if HealBot_Config.MacroUse10==1 then smName=smName.."/use 10;\n" end
    if HealBot_Globals.MacroSuppressError==1 then smName=smName.."/script UIErrorsFrame:Clear();\n" end
    if HealBot_Globals.MacroSuppressSound==1 then smName=smName.."/console Sound_EnableSFX 1;\n" end
    if HealBot_Globals.MacroSuppressSound==1 then smName=smName.."/console Sound_EnableErrorSpeech 1;\n" end
    smName=smName..scText
    if spellAvoidBC then smName=smName.."/use 4;" end
    if strlen(smName)>255 then
        smName=""
        if HealBot_Globals.MacroSuppressSound==1 then smName=smName.."/console Sound_EnableErrorSpeech 0;\n" end
        if spellTar then smName=smName.."/target "..unit..";\n" end
        if spellTrin1 then smName=smName.."/use 13;\n" end
        if spellTrin2 then smName=smName.."/use 14;\n" end
        if HealBot_Config.MacroUse10==1 then smName=smName.."/use 10;\n" end
        if HealBot_Globals.MacroSuppressError==1 then smName=smName.."/script UIErrorsFrame:Clear();\n" end
        if HealBot_Globals.MacroSuppressSound==1 then smName=smName.."/console Sound_EnableErrorSpeech 1;\n" end
        smName=smName..scText
        if spellAvoidBC then smName=smName.."/use 4;" end
        if strlen(smName)>255 then
            smName=""
            if HealBot_Globals.MacroSuppressSound==1 then smName=smName.."/console Sound_EnableErrorSpeech 0;\n" end
            if spellTar then smName=smName.."/target "..unit..";\n" end
            if spellTrin1 then smName=smName.."/use 13;\n" end
            if spellTrin2 then smName=smName.."/use 14;\n" end
            if HealBot_Config.MacroUse10==1 then smName=smName.."/use 10;\n" end
            if HealBot_Globals.MacroSuppressSound==1 then smName=smName.."/console Sound_EnableErrorSpeech 1;\n" end
            smName=smName..scText
            if spellAvoidBC then smName=smName.."/use 4;" end
            if strlen(smName)>255 then
                smName=""
                if spellTar then smName=smName.."/target "..unit..";\n" end
                if spellTrin1 then smName=smName.."/use 13;\n" end
                if spellTrin2 then smName=smName.."/use 14;\n" end
                if HealBot_Config.MacroUse10==1 then smName=smName.."/use 10;\n" end
                smName=smName..scText
                if spellAvoidBC then smName=smName.."/use 4;" end
                if strlen(smName)>255 then
                    smName=spellName
                end
            end
        end
    end
    return smName
end

local function HealBot_Action_UnitID(unit)
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
    return unit
end

local function HealBot_Action_SetButtonAttrib(button,bbutton,bkey,status,j)
    local HB_prefix = "";
    local buttonType="helpbutton"
    local sType="heal"
    if strlen(bkey)>1 then
        HB_prefix = strlower(bkey).."-"
    end
    local HB_combo_prefix = bkey..bbutton..HealBot_Config.CurrentSpec;
    local sName,sTar,sTrin1,sTrin2,AvoidBC=nil,0, 0, 0, 0
    if status=="Enabled" then
        sName, sTar, sTrin1, sTrin2, AvoidBC = HealBot_Action_AttribSpellPattern(HB_combo_prefix)
    elseif status=="Disabled" then
        sName, sTar, sTrin1, sTrin2, AvoidBC = HealBot_Action_AttribDisSpellPattern(HB_combo_prefix)
    elseif status=="Enemy" then
        sName, sTar, sTrin1, sTrin2, AvoidBC = HealBot_Action_AttribEnemySpellPattern(HB_combo_prefix)
        buttonType="harmbutton"
        sType="harm"
    end
    if sName then
        hbAttribsMinReset[button.frame..button.id..HB_prefix..status..j]=false
        local mId=GetMacroIndexByName(sName)
        if strlower(sName)==strlower(HEALBOT_DISABLED_TARGET) then
            button:SetAttribute(HB_prefix..buttonType..j, "target"..j);
            button:SetAttribute(HB_prefix.."type"..j, "target")
            button:SetAttribute(HB_prefix.."type-target"..j, "target")
            hbAttribsMinReset[button.frame..button.id..HB_prefix..status..j]=true
        elseif strlower(sName)==strlower(HEALBOT_FOCUS) then
            button:SetAttribute(HB_prefix..buttonType..j, "focus"..j);
            button:SetAttribute(HB_prefix.."type"..j, "focus")
            button:SetAttribute(HB_prefix.."type-focus"..j, "focus")
            hbAttribsMinReset[button.frame..button.id..HB_prefix..status..j]=true
        elseif strlower(sName)==strlower(HEALBOT_ASSIST) then
            button:SetAttribute(HB_prefix..buttonType..j, "assist"..j);
            button:SetAttribute(HB_prefix.."type"..j, "assist")
            button:SetAttribute(HB_prefix.."type-assist"..j, "assist")
            hbAttribsMinReset[button.frame..button.id..HB_prefix..status..j]=true
        elseif strlower(sName)==strlower(HEALBOT_STOP) then
            button:SetAttribute(HB_prefix..buttonType..j, nil);
            button:SetAttribute(HB_prefix.."type"..j, "macro")
            button:SetAttribute(HB_prefix.."macrotext"..j, "/stopcasting")
            hbAttribsMinReset[button.frame..button.id..HB_prefix..status..j]=true
        elseif strsub(strlower(sName),1,4)==strlower(HEALBOT_TELL) then
            local mText='/script local n=UnitName("hbtarget");SendChatMessage("hbMSG","WHISPER",nil,n)'
            mText=string.gsub(mText,"hbtarget",button.unit)
            mText=string.gsub(mText,"hbMSG", strtrim(strsub(sName,5)))
            button:SetAttribute(HB_prefix..buttonType..j, nil);
            button:SetAttribute(HB_prefix.."type"..j, "macro")
            button:SetAttribute(HB_prefix.."macrotext"..j, mText)
            hbAttribsMinReset[button.frame..button.id..HB_prefix..status..j]=true
        elseif strlower(sName)==strlower(HEALBOT_MENU) then
            button:SetAttribute(HB_prefix..buttonType..j, nil);
            button:SetAttribute(HB_prefix.."type"..j, "showmenu")
            showmenu = function()
                local setDropdown=nil
                if button.unit=="player" then
                    setDropdown=PlayerFrameDropDown
                elseif button.unit=="target" then
                    setDropdown=TargetFrameDropDown
                elseif button.unit=="pet" then
                    setDropdown=PetFrameDropDown
                else
                    local xUnit=HealBot_Action_UnitID(button.unit)
                    local partyNo = tonumber(xUnit:match('party(%d+)')) or 0
                    if partyNo > 0 then
                        setDropdown = _G['PartyMemberFrame' .. partyNo .. 'DropDown']
                    else
                        partyNo = tonumber(xUnit:match('raid(%d+)')) or 0
                        if partyNo == 0 then
                            partyNo=button.id
                        end
                        FriendsDropDown.name = HealBot_GetUnitName(xUnit, button.guid);    
                        FriendsDropDown.id = partyNo;    
                        FriendsDropDown.unit = xUnit;    
                        FriendsDropDown.initialize = RaidFrameDropDown_Initialize;    
                        FriendsDropDown.displayMode = "MENU";    
                        setDropdown=FriendsDropDown
                    end
                end
                ToggleDropDownMenu(1, nil, setDropdown, "cursor", 10, -8)  
            end
            button.showmenu = showmenu 
        elseif strlower(sName)==strlower(HEALBOT_HBMENU) and HealBot_UnitGUID(button.unit) then
            button:SetAttribute(HB_prefix..buttonType..j, nil);
            button:SetAttribute(HB_prefix.."type"..j, "showhbmenu")
            showHBmenu = function()
                local HBFriendsDropDown = CreateFrame("Frame", "HealBot_Action_hbmenuFrame_DropDown", UIParent, "UIDropDownMenuTemplate");
                HBFriendsDropDown.unit = button.unit
                HBFriendsDropDown.name = HealBot_GetUnitName(button.unit, button.guid)
                HBFriendsDropDown.initialize = HealBot_Action_hbmenuFrame_DropDown_Initialize
                HBFriendsDropDown.displayMode = "MENU"
                ToggleDropDownMenu(1, nil, HBFriendsDropDown, "cursor", 10, -8)
            end
            button.showhbmenu = showHBmenu
        elseif HealBot_GetSpellId(sName) then
            if sTar or sTrin1 or sTrin2 or AvoidBC then
                local mText = HealBot_Action_AlterSpell2Macro(sName, sTar, sTrin1, sTrin2, AvoidBC, button.unit, status)
                button:SetAttribute(HB_prefix..buttonType..j, nil);
                button:SetAttribute(HB_prefix.."type"..j,"macro")
                button:SetAttribute(HB_prefix.."macrotext"..j, mText)
            else
                button:SetAttribute(HB_prefix..buttonType..j, sType..j);
                button:SetAttribute(HB_prefix.."type-"..sType..j, "spell");
                button:SetAttribute(HB_prefix.."spell-"..sType..j, sName);
                hbAttribsMinReset[button.frame..button.id..HB_prefix..status..j]=true
            end
        elseif mId ~= 0 then
            local _,_,mText=GetMacroInfo(mId)
            if UnitExists(HealBot_UnitPet(button.unit)) then
                mText=string.gsub(mText,"hbtargetpet",HealBot_UnitPet(button.unit))
            end
            mText=string.gsub(mText,"hbtargettargettarget",button.unit.."targettarget")
            mText=string.gsub(mText,"hbtargettarget",button.unit.."target")
            mText=string.gsub(mText,"hbtarget",button.unit)
            button:SetAttribute(HB_prefix..buttonType..j, nil);
            button:SetAttribute(HB_prefix.."type"..j,"macro")
            button:SetAttribute(HB_prefix.."macrotext"..j, mText)
            if status=="Enabled" then
                HealBotButtonMacroAttribs[HB_prefix..j]=sName
            end
        elseif IsUsableItem(sName) or HealBot_IsItemInBag(sName) then
            button:SetAttribute(HB_prefix..buttonType..j, "item"..j);
            button:SetAttribute(HB_prefix.."type-item"..j, "item");
            button:SetAttribute(HB_prefix.."item-item"..j, sName);
        else
            if sTar or sTrin1 or sTrin2 or AvoidBC then
                local mText = HealBot_Action_AlterSpell2Macro(sName, sTar, sTrin1, sTrin2, AvoidBC, button.unit, status)
                button:SetAttribute(HB_prefix..buttonType..j, nil);
                button:SetAttribute(HB_prefix.."type"..j,"macro")
                button:SetAttribute(HB_prefix.."macrotext"..j, mText)
            else
                button:SetAttribute(HB_prefix..buttonType..j, sType..j);
                button:SetAttribute(HB_prefix.."type-"..sType..j, "spell");
                button:SetAttribute(HB_prefix.."spell-"..sType..j, sName);
                hbAttribsMinReset[button.frame..button.id..HB_prefix..status..j]=true
            end
        end
        button:SetAttribute(HB_prefix.."checkselfcast"..j, "false")
    else
        button:SetAttribute(HB_prefix..buttonType..j, nil);
    end
end

local function HealBot_Action_SetAllButtonAttribs(button,status)
    for x=1,15 do
        if x==1 then 
            HB_button="Left";
        elseif x==2 then 
            HB_button="Right";
        elseif x==3 then 
            HB_button="Middle";
        elseif x==4 then 
            HB_button="Button4";
        elseif x==5 then 
            HB_button="Button5";
        elseif x==6 then 
            HB_button="Button6";
        elseif x==7 then 
            HB_button="Button7";
        elseif x==8 then 
            HB_button="Button8";
        elseif x==9 then 
            HB_button="Button9";
        elseif x==10 then 
            HB_button="Button10";
        elseif x==11 then
            HB_button="Button11";
        elseif x==12 then
            HB_button="Button12";
        elseif x==13 then
            HB_button="Button13";
        elseif x==14 then
            HB_button="Button14";
        elseif x==15 then
            HB_button="Button15";
        end
    
        for y=1, getn(HealBot_Keys_List), 1 do
            if strlen(HealBot_Keys_List[y])>1 then
                HB_prefix = strlower(HealBot_Keys_List[y]).."-"
            else
                HB_prefix = "";
            end
            if not hbAttribsMinReset[button.frame..button.id..HB_prefix..status..x] then
                HealBot_Action_SetButtonAttrib(button,HB_button,HealBot_Keys_List[y],status,x)
            end
        end
    end
end

function HealBot_Action_SetUnitData(hbGUID, unit)
    HealBot_UnitData[hbGUID]={}
    HealBot_UnitData[hbGUID]["SPEC"] = " "
    HealBot_UnitData[hbGUID]["UNIT"]=unit
    HealBot_UnitData[hbGUID]["ROLE"] = UnitGroupRolesAssigned(unit) or HEALBOT_WORDS_UNKNOWN
end

function HealBot_Action_SetHealButton(unit,hbGUID,hbCurFrame,unitType)
    local shb=nil
    if hbGUID then
        if not HealBot_Unit_Button[unit] and not HealBot_Enemy_Button[unit] and not HealBot_Pet_Button[unit] then
            shb=HealBot_Action_CreateButton(hbCurFrame)
            if not shb then
                return nil
            else
                shb.reset=true
            end
        else
            shb=HealBot_Unit_Button[unit] or HealBot_Enemy_Button[unit] or HealBot_Pet_Button[unit]
        end
        if shb.frame~=hbCurFrame then
            local gp=_G["f"..hbCurFrame.."_HealBot_Action"]
            shb:ClearAllPoints()
            shb:SetParent(gp)
            shb.frame=hbCurFrame
            HealBot_Panel_SetBarArrays(shb.id)
            HealBot_ResetBarSkinDone[shb.frame][shb.id] = nil
            HealBot_initSkin[shb.frame][shb.id]=nil
        end
        if not HealBot_UnitData[hbGUID] then
            HealBot_Action_SetUnitData(hbGUID, unit)
            if not HealBot_UnitData[unit] then HealBot_UnitData[unit]={} end
            if UnitExists(unit) then
                if UnitIsFriend("player",unit) then 
                    HealBot_CheckPlayerMana(hbGUID, unit) 
                end
            end
            shb.reset=true
        end
        if (HealBot_Unit_Button[unit] or HealBot_Enemy_Button[unit] or HealBot_Pet_Button[unit])~=shb or shb.unit~=unit or shb.reset then
            shb.reset=nil
            shb.unit=unit
            shb.guid=hbGUID
            shb.update.unit=true
            shb.status.update=true
            HealBot_UnitData[hbGUID]["UNIT"]=unit
            if unitType==9 then
                HealBot_Enemy_Button[unit]=shb
            elseif unitType>1 and unitType<4 then
                HealBot_Pet_Button[unit]=shb
            else
                HealBot_Unit_Button[unit]=shb
            end
            shb.status.unittype = unitType  -- 1=player  2=vehicle  3=pet  4=target  5=focus  6-8=reserved  9=enemy
            shb.checks.range=GetTime() + HealBot_Action_luVars["updateDelay"]
            if unitType>1 and unitType<4 then
                shb.checks.other=GetTime() + 1000000
            else
                shb.checks.other=GetTime() + 0.3 + (HealBot_Action_luVars["updateDelay"] * 2)
            end
            HealBot_Action_luVars["updateDelay"]=HealBot_Action_luVars["updateDelay"]+0.02
            if shb.status.offline and UnitIsConnected(unit) then
                shb.status.offline=false
            end
            shb:SetAttribute("unit", unit);
            HealBot_Action_rCalls[unit]={["aggroIndicator"]="notSet",["powerIndicator"]="notSet",["manaIndicator"]="notSet",["barText"]="notSet",}
            HealBot_Action_SetAllButtonAttribs(shb,"Enemy")
            HealBot_Action_SetAllButtonAttribs(shb,"Enabled")
            HealBot_setUnitIcons(unit)
            HealBot_Action_setNameText(shb)
            HealBot_Action_HBText(shb)
        elseif shb.guid~=hbGUID then
            shb.guid=hbGUID
        end
        HealBot_Action_CheckUnitLowMana(shb)
        if not HealBot_ResetBarSkinDone[shb.frame][shb.id] then
            HealBot_Action_ResetSkin("bar",shb)
        end
        if not shb.update.unit and Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][hbCurFrame]["CLASSONBAR"] then
            shb.update.roleicon=true
            shb.status.update=true
        end
        shb.health.updhealth=true
        shb.health.update=true
        HealBot_UpdateUnitRange(shb, HealBot_RangeSpells["HEAL"], false)
    else
        return nil
    end
    return shb
end

function HealBot_Action_SetTestButton(hbCurFrame, unitText)
    local thb=HealBot_Action_CreateButton(hbCurFrame)
    if thb then
        thb.unit=unitText
        thb.guid="TestBar"
        HealBot_Action_rCalls[thb.unit]={["aggroIndicator"]="notSet",["powerIndicator"]="notSet",["manaIndicator"]="notSet",["barText"]="notSet",}
        thb.status.bar4=0
        HealBot_Unit_Button[unitText]=thb
        if thb.frame~=hbCurFrame then
            local gp=_G["f"..hbCurFrame.."_HealBot_Action"]
            thb:ClearAllPoints()
            thb:SetParent(gp)
            thb.frame=hbCurFrame
            HealBot_Panel_SetBarArrays(thb.id)
        end
        HealBot_Action_ResetSkin("bar",thb)
    end
    return thb
end

function HealBot_Action_SetAllAttribs()
    HealBot_Action_luVars["ResetAttribs"]=true
    HealBot_nextRecalcParty(0)
end

function HealBot_Action_SethbFocusButtonAttrib(button)
    button:SetAttribute("unit", "target")
    button:SetAttribute("helpbutton1", "focus1");
    button:SetAttribute("type1", "focus")
    button:SetAttribute("type-focus1", "focus")
end

local hbInitButtons=false
function HealBot_Action_ResethbInitButtons()
    hbInitButtons=false
end

function HealBot_Action_PartyChanged(changeType)
    local HealBot_PreCombat=nil
    if InCombatLockdown() then 
        HealBot_Data["UILOCK"]=true
    elseif HealBot_Data["UILOCK"] then 
        HealBot_PreCombat=true
        HealBot_Data["UILOCK"]=false
    end
    if not HealBot_Data["UILOCK"] and HealBot_Data["PGUID"] then
        if not HealBot_PreCombat and HealBot_Action_luVars["ResetAttribs"] then
            for x,xButton in pairs(HealBot_Unit_Button) do
                xButton.reset="init";
            end
            for x,xButton in pairs(HealBot_Enemy_Button) do
                xButton.reset="init";
            end
            for x,xButton in pairs(HealBot_Pet_Button) do
                xButton.reset="init";
            end
            for x,_ in pairs(HealBotButtonMacroAttribs) do
                HealBotButtonMacroAttribs[x]=nil;
            end
            for x,_ in pairs(hbAttribsMinReset) do
                hbAttribsMinReset[x]=nil;
            end
            HealBot_Action_luVars["ResetAttribs"]=false
        end
        if not hbInitButtons then
            for _,xButton in pairs(HealBot_Unit_Button) do
                HealBot_Action_DeleteButton(xButton.id)
            end 
            for _,xButton in pairs(HealBot_Enemy_Button) do
                HealBot_Action_DeleteButton(xButton.id)
            end 
            for _,xButton in pairs(HealBot_Pet_Button) do
                HealBot_Action_DeleteButton(xButton.id)
            end 
            hbInitButtons=true
        end
        
        if HealBot_PreCombat then 
            HealBot_EnteringCombat()
        end
  
        HealBot_Data["UNITSLOCK"]=true
        HealBot_Action_luVars["updateDelay"]=0
        HealBot_Panel_PartyChanged(HealBot_PreCombat, changeType)
        HealBot_Data["UNITSLOCK"]=false

        if HealBot_PreCombat then 
            HealBot_Action_ResetUnitStatus()
        end 
    else
        HealBot_nextRecalcParty(changeType)
    end
end

function HealBot_Action_DeleterCallsUnit(unit)
    HealBot_Action_rCalls[unit]=nil
end

function HealBot_Action_DeleteButton(hbBarID)
    local dg=_G["HealBot_Action_HealUnit"..hbBarID]
    local dbUnit=dg.unit or "N"
    local dbGUID=dg.guid or "0"
    if not UnitExists(dbUnit) or dbGUID~=HealBot_UnitGUID(dbUnit) then
        HealBot_mark2clearGUID(dbGUID)
    end
    HealBot_HoT_RemoveIconButton(dg,true)
    HealBot_Action_UpdateAggro(dbUnit,false,nil,0)
    HealBot_Action_SetBar3Value(dg)
    local bar4=_G["HealBot_Action_HealUnit"..hbBarID.."Bar4"]
    bar4:SetStatusBarColor(1,0,0,0)
    dg.status.bar4=0
    if HealBot_Unit_Button[dbUnit] then HealBot_Unit_Button[dbUnit]=nil end
    if HealBot_Enemy_Button[dbUnit] then HealBot_Enemy_Button[dbUnit]=nil end
    if HealBot_Pet_Button[dbUnit] then HealBot_Pet_Button[dbUnit]=nil end
    dg:Hide();
    HealBot_ActiveButtons[hbBarID]=false
    if hbBarID<HealBot_ActiveButtons[0] then HealBot_ActiveButtons[0]=hbBarID end
    HealBot_Panel_SetBarArrays(hbBarID)
end

function HealBot_Action_Reset()
    local screenWidth = (ceil(GetScreenWidth()/2)) or 700
    local screenHeight = (ceil(GetScreenHeight()/2)) or 500
    for i=1, 10 do
        Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][i]["X"]=(49+i)
        Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][i]["Y"]=(49+i)
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][i]["AUTOCLOSE"]=false
        if HealBot_Config.DisabledNow==0 and HealBot_Config.ActionVisible[i] then
            HealBot_Action_setPoint(i)
            HealBot_Action_ShowPanel(i)
        end
        HealBot_Action_unlockFrame(i)
    end
end

function HealBot_Action_unlockFrame(hbCurFrame)
    Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][hbCurFrame]["LOCKED"]=false
    HealBot_Options_ActionLocked:SetChecked(Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][hbCurFrame]["LOCKED"])
end

function HealBot_Action_setPoint(hbCurFrame)
    if not hbCurFrame then return end
    if not InCombatLockdown() then  -- not HealBot_Data["UILOCK"]
        local gaf=_G["f"..hbCurFrame.."_HealBot_Action"]
        gaf:ClearAllPoints();
        local Y=GetScreenHeight()*(Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]/100)
        local X=GetScreenWidth()*(Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]/100)
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==1 then
            gaf:SetPoint("TOPLEFT","UIParent","BOTTOMLEFT",X,Y);
        elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==2 then
            gaf:SetPoint("BOTTOMLEFT","UIParent","BOTTOMLEFT",X,Y);
        elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==3 then
            gaf:SetPoint("TOPRIGHT","UIParent","BOTTOMLEFT",X,Y);
        elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==4 then
            gaf:SetPoint("BOTTOMRIGHT","UIParent","BOTTOMLEFT",X,Y);
        elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==5 then
            gaf:SetPoint("TOP","UIParent","BOTTOMLEFT",X,Y);
        elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==6 then
            gaf:SetPoint("LEFT","UIParent","BOTTOMLEFT",X,Y);
        elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==7 then
            gaf:SetPoint("RIGHT","UIParent","BOTTOMLEFT",X,Y);
        elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==8 then
            gaf:SetPoint("BOTTOM","UIParent","BOTTOMLEFT",X,Y);
        end
    else
        HealBot_setOptions_Timer(2000+hbCurFrame)
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
  --HealBot_setCall("HealBot_Action_ClassColour")
    return hbClassCols[xClass].r, hbClassCols[xClass].g, hbClassCols[xClass].b
end

function HealBot_Action_HideTooltip(self)
    if HealBot_Data["TIPUNIT"] then
        HealBot_Data["TIPUNIT"] = false;
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
    end
end

function HealBot_Action_CheckHideFrames()
    local hideFrame={[1]=true,[2]=true,[3]=true,[4]=true,[5]=true,[6]=true,[7]=true,[8]=true,[9]=true,[10]=true}
    for _,xButton in pairs(HealBot_Unit_Button) do
        if xButton.status.enabled then
            hideFrame[xButton.frame]=false
        end
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        if xButton.status.enabled then
            hideFrame[xButton.frame]=false
        end
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        if xButton.status.enabled then
            hideFrame[xButton.frame]=false
        end
    end
    for i=1, 10 do
        if Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][i]["AUTOCLOSE"] and HealBot_Config.ActionVisible[i] and hideFrame[i] then
            HealBot_Action_HidePanel(i)
        end
    end
end

function HealBot_Action_ShowHideFrames(button)
    if Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][button.frame]["AUTOCLOSE"] then 
        if not HealBot_Data["UILOCK"] then
            if not HealBot_Config.ActionVisible[button.frame] and HealBot_Config.DisabledNow==0 then
                if button.status.enabled then
                    HealBot_Action_ShowPanel(button.frame);
                end
            elseif HealBot_Config.ActionVisible[button.frame] then
                if not button.status.enabled then
                    if button.status.unittype>1 or button.status.unittype<4 then
                        if not HealBot_Action_ShouldHealSomePet(button.frame) then
                            HealBot_Action_HidePanel(button.frame);
                        end
                    elseif not HealBot_Action_ShouldHealSome(button.frame) then
                        HealBot_Action_HidePanel(button.frame);
                    end
                end
            end
        end
    end
end

function HealBot_Action_Refresh(button)
    if button then
        if button.text.name==button.unit and UnitExists(button.unit) then 
            button.update.unit=true
            button.status.update=true
        end
        HealBot_Action_UpdateDebuffButton(button)
        if UnitExists("target") and HealBot_Unit_Button["target"] and button.unit~="target" and UnitIsUnit("target",button.unit) then
            HealBot_Action_UpdateDebuffButton(HealBot_Unit_Button["target"])
        end
    end
end

local hbLastButton=nil
function HealBot_Action_HealUnit_OnEnter(self)
    if not self.unit then return; end
    HealBot_Data["TIPUNIT"] = self.unit
    if not IsInInstance() and self.status.range<1 and Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][self.frame]["SHOWDIRMOUSE"] then 
        HealBot_Action_ShowDirectionArrow(self)
    end
    if HealBot_Globals.ShowTooltip and HealBot_Data["TIPUSE"] and UnitExists(self.unit) then
        if not UnitIsFriend("player",self.unit) then
            HealBot_Data["TIPTYPE"] = "Enemy"
        elseif HealBot_Data["UILOCK"] and HealBot_Globals.DisableToolTipInCombat==false then
            HealBot_Data["TIPTYPE"] = "Enabled"
        elseif UnitAffectingCombat(self.unit)==1 then
            HealBot_Data["TIPTYPE"] = "Enabled"
        elseif self.status.enabled or HealBot_Config.EnableHealthy then 
            HealBot_Data["TIPTYPE"] = "Enabled"
        elseif UnitIsUnit(self.unit,"player") and self.status.current<9 then
            HealBot_Data["TIPTYPE"] = "Disabled"
        end
        if HealBot_Data["UILOCK"] or HealBot_Globals.DisableToolTipInCombat then
            HealBot_Action_RefreshTooltip();
        end
    end
    if Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["CBAR"] and not UnitIsDeadOrGhost(self.unit) and HealBot_retHighlightTarget()~=self.unit then
        local z=false
        if HealBot_Data["UILOCK"] then
            if Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["CBARCOMBAT"] then z=true end
        else
            z=true
        end
        if z then
            HealBot_Action_UpdateAggro(self.unit,"highlight",self.aggro.status or 0, self.aggro.threatpct)
        end
    end
    hbLastButton=self
   -- SetOverrideBindingClick(HealBot_Action,true,"MOUSEWHEELUP", "HealBot_Action_HealUnit"..self.id,"Button4");
   -- SetOverrideBindingClick(HealBot_Action,true,"MOUSEWHEELDOWN", "HealBot_Action_HealUnit"..self.id,"Button5");
end

function HealBot_Action_HealUnit_OnLeave(self)
    HealBot_Action_HideTooltip(self);
    if self.status and self.status.dirarrow<99998 and Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][self.frame]["SHOWDIRMOUSE"] then
        HealBot_Action_HideDirectionArrow(self)
    end
    if self.aggro and Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["CBAR"] and self.aggro.status==-1 then
        HealBot_Action_UpdateAggro(self.unit,"off",self.aggro.status or 0, 0)
    end
    hbLastButton=nil
   -- ClearOverrideBindings(HealBot_Action)
end

local HealBot_MouseWheelCmd=nil
local HealBot_GMount = {}
local HealBot_PrevGMounts = {}
local HealBot_FMount = {}
local HealBot_PrevFMounts = {}
local HealBot_SMount = {}
local HealBot_mountData = {}
local HealBot_MountIndex = {}

local function HealBot_MountsPets_FavMount()
    if not InCombatLockdown() then
        C_MountJournal.SummonByID(0)
    end
end

local function HealBot_MountsPets_RandomPet(isFav)
    if not InCombatLockdown() then
        C_PetJournal.SummonRandomPet(isFav)
    end
end

local function HealBot_MountsPets_Mount(mount)
    if HealBot_MountIndex[mount] then 
        if not InCombatLockdown() then
            C_MountJournal.SummonByID(HealBot_MountIndex[mount]) 
        end
    else
        HealBot_setOptions_Timer(405)
        HealBot_AddChat(HEALBOT_OPTION_EXCLUDEMOUNT_ON.." "..mount)
    end
end

local function HealBot_MountsPets_ToggelMount(mountType)
    if IsMounted() then
        Dismount()
	elseif CanExitVehicle() then	
		VehicleExit()
    elseif HealBot_mountData["ValidUse"] and IsOutdoors() and not HealBot_IsFighting then
        local mount = nil
        local i=0
        if mountType=="all" and not IsSwimming() and IsFlyableArea() and #HealBot_FMount>0 then
            for x=1,20 do
                i = math.random(1, #HealBot_FMount);
                mount = HealBot_FMount[i];
                if not HealBot_Globals.dislikeMount[mount] then
                    break
                else
                    if HealBot_Globals.dislikeMount[mount]>0 then
                        HealBot_Globals.dislikeMount[mount]=HealBot_Globals.dislikeMount[mount]-1
                    else
                        HealBot_Globals.dislikeMount[mount]=500
                        break
                    end
                end
            end
            if HealBot_mountData["PrevFlying#"]>0 then
                table.insert(HealBot_PrevFMounts, HealBot_FMount[i]);
                table.remove(HealBot_FMount,i)
            end
            if #HealBot_PrevFMounts>HealBot_mountData["PrevFlying#"] then
                table.insert(HealBot_FMount, HealBot_PrevFMounts[1]);
                table.remove(HealBot_PrevFMounts,1)
            end
        elseif IsSwimming() and #HealBot_SMount>0 then
            i = math.random(1, #HealBot_SMount);
            mount = HealBot_SMount[i];
        elseif #HealBot_GMount>0 then
            for x=1,20 do
                i = math.random(1, #HealBot_GMount);
                mount = HealBot_GMount[i];
                if not HealBot_Globals.dislikeMount[mount] then
                    break
                else
                    if HealBot_Globals.dislikeMount[mount]>0 then
                        HealBot_Globals.dislikeMount[mount]=HealBot_Globals.dislikeMount[mount]-1
                    else
                        HealBot_Globals.dislikeMount[mount]=500
                        break
                    end
                end
            end
            if HealBot_mountData["PrevGround#"]>0 then
                table.insert(HealBot_PrevGMounts, HealBot_GMount[i]);
                table.remove(HealBot_GMount,i)
            end
            if #HealBot_PrevGMounts>HealBot_mountData["PrevGround#"] then
                table.insert(HealBot_GMount, HealBot_PrevGMounts[1]);
                table.remove(HealBot_PrevGMounts,1)
            end
        end
        if mount then HealBot_MountsPets_Mount(mount) end
    end
end

local function HealBot_Action_DoHealUnit_Wheel(self, delta)
    local xButton=hbLastButton
    if not xButton then return end
    local xUnit=xButton.unit
    if not UnitExists(xUnit) then return end
    local y="None"
    if IsShiftKeyDown() then
        if not IsControlKeyDown() and not IsAltKeyDown() then 
            y="Shift" 
        else
            y=""
        end
    elseif IsControlKeyDown() then
        if not IsShiftKeyDown() and not IsAltKeyDown() then 
            y="Ctrl" 
        else
            y=""
        end

    elseif IsAltKeyDown() then
        if not IsControlKeyDown() and not IsShiftKeyDown() then 
            y="Alt" 
        else
            y=""
        end
    end    
    if delta>0 then
        y=y.."Up"
    else
        y=y.."Down"
    end
    if HealBot_Globals.HealBot_MouseWheelTxt[y] then
        HealBot_MouseWheelCmd=HealBot_Globals.HealBot_MouseWheelTxt[y]
    else
        HealBot_MouseWheelCmd=HEALBOT_WORDS_NONE
    end
    
    if HealBot_MouseWheelCmd==HEALBOT_BLIZZARD_MENU then
        if xUnit=="player" then
            setDropdown=PlayerFrameDropDown
        elseif xUnit=="target" then
            setDropdown=TargetFrameDropDown
        elseif xUnit=="pet" then
            setDropdown=PetFrameDropDown
        else
            partyNo = tonumber(xUnit:match('party(%d+)')) or 0
            if partyNo > 0 then
                setDropdown = _G['PartyMemberFrame' .. partyNo .. 'DropDown']
            else
                partyNo = tonumber(strmatch(xUnit, "(%d+)"))
                FriendsDropDown.name = HealBot_GetUnitName(xUnit, xButton.guid)   
                FriendsDropDown.id = partyNo;    
                FriendsDropDown.unit = xUnit;    
                FriendsDropDown.initialize = RaidFrameDropDown_Initialize;    
                FriendsDropDown.displayMode = "MENU";    
                setDropdown=FriendsDropDown
            end
        end
        ToggleDropDownMenu(1, nil, setDropdown, "cursor", 10, -8)  
    elseif HealBot_MouseWheelCmd==HEALBOT_HB_MENU then
        local HBFriendsDropDown = CreateFrame("Frame", "HealBot_Action_hbmenuFrame_DropDown", UIParent, "UIDropDownMenuTemplate");
        HBFriendsDropDown.unit = xUnit
        HBFriendsDropDown.name = HealBot_GetUnitName(xUnit, xButton.guid)
        HBFriendsDropDown.initialize = HealBot_Action_hbmenuFrame_DropDown_Initialize
        HBFriendsDropDown.displayMode = "MENU"
        ToggleDropDownMenu(1, nil, HBFriendsDropDown, "cursor", 10, -8)
    elseif HealBot_MouseWheelCmd==HEALBOT_FOLLOW then
        FollowUnit(xUnit)
    elseif HealBot_MouseWheelCmd==HEALBOT_TRADE then
        InitiateTrade(xUnit)
    elseif HealBot_MouseWheelCmd==HEALBOT_PROMOTE_RA then
        PromoteToAssistant(xUnit)
    elseif HealBot_MouseWheelCmd==HEALBOT_DEMOTE_RA then
        DemoteAssistant(xUnit)
    elseif HealBot_MouseWheelCmd==HEALBOT_TOGGLE_ENABLED then
        HealBot_Action_Toggle_Enabled(xButton)
    elseif HealBot_MouseWheelCmd==HEALBOT_TOGGLE_MYTARGETS then
        HealBot_Panel_ToggelHealTarget(xButton.unit)
    elseif HealBot_MouseWheelCmd==HEALBOT_TOGGLE_PRIVATETANKS then
        HealBot_Panel_ToggelPrivateTanks(xButton.unit)
    elseif HealBot_MouseWheelCmd==HEALBOT_RESET_BAR then
        HealBot_Reset_Unit(xButton)
    elseif HealBot_MouseWheelCmd==HEALBOT_RANDOMMOUNT and UnitIsUnit(xUnit,"player") and not UnitAffectingCombat("player") then
        HealBot_MountsPets_ToggelMount("all")
    elseif HealBot_MouseWheelCmd==HEALBOT_RANDOMGOUNDMOUNT and UnitIsUnit(xUnit,"player") and not UnitAffectingCombat("player") then
        HealBot_MountsPets_ToggelMount("ground")
    elseif HealBot_MouseWheelCmd==HEALBOT_RANDOMPET and UnitIsUnit(xUnit,"player") then
        HealBot_MountsPets_RandomPet(false)   
    elseif HealBot_MouseWheelCmd==HEALBOT_RANDOMFAVMOUNT and UnitIsUnit(xUnit,"player") then
        HealBot_MountsPets_FavMount()   
    elseif HealBot_MouseWheelCmd==HEALBOT_RANDOMFAVPET and UnitIsUnit(xUnit,"player") then
        HealBot_MountsPets_RandomPet(true)   
    end
end

function HealBot_Action_HealUnit_Wheel(self, delta)
    HealBot_Action_DoHealUnit_Wheel(self, delta)
end

function HealBot_Action_OptionsButton_OnClick(self)
    HealBot_TogglePanel(HealBot_Options);
end

local usedSmartCast=nil
local ModKey=nil
local abutton=nil
local aj=nil

local function HealBot_Action_UseSmartCast(bp)
    local sName=HealBot_Action_SmartCast(bp);
    if sName then
        if HealBot_GetSpellId(sName) then
            if bp.status.range>0 then
                bp:SetAttribute("helpbutton1", "heal1");
                bp:SetAttribute("type-heal1", "spell");
                bp:SetAttribute("spell-heal1", sName);
            end
        else
            local mId=GetMacroIndexByName(sName)
            if mId ~= 0 then
               local _,_,mText=GetMacroInfo(mId)
                if UnitExists(HealBot_UnitPet(bp.unit)) then
                    mText=string.gsub(mText,"hbtargetpet",HealBot_UnitPet(bp.unit))
                end
                mText=string.gsub(mText,"hbtarget",bp.unit)
                mText=string.gsub(mText,"hbtargettarget",bp.unit.."target")
                mText=string.gsub(mText,"hbtargettargettarget",bp.unit.."targettarget")
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

local function HealBot_Action_PreClick(self,button)
    if self.id<999 and UnitExists(self.unit) then
        if UnitIsFriend("player",self.unit) then
            HealBot_setLuVars("TargetUnitID", self.unit)
            usedSmartCast=false;
            ModKey=""
            if IsShiftKeyDown() then 
                if IsControlKeyDown() then 
                    ModKey="Ctrl-Shift"
                elseif IsAltKeyDown() then 
                    ModKey="Alt-Shift"
                else
                    ModKey="Shift" 
                end
            elseif IsControlKeyDown() then 
                ModKey="Ctrl"
            elseif IsAltKeyDown() then 
                ModKey="Alt"
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
            if self.unit=="target" and HealBot_Globals.TargetBarRestricted==1 then
                if button=="RightButton" then
                    HealBot_Panel_ToggelHealTarget(self.unit)
                    if HealBot_Data["TIPUSE"] and HealBot_Globals.ShowTooltip then 
                        HealBot_Action_RefreshTargetTooltip(self) 
                    end
                elseif button=="LeftButton" and HealBot_Globals.SmartCast and not IsModifierKeyDown() then
                    HealBot_Action_UseSmartCast(self)
                end
            elseif IsShiftKeyDown() and IsControlKeyDown() and IsAltKeyDown() and (button=="LeftButton" or button=="MiddleButton" or button=="RightButton") then
                if button=="LeftButton" then
                    HealBot_Action_Toggle_Enabled(self)
                elseif button=="RightButton" then
                    HealBot_Panel_ToggelHealTarget(self.unit)
                elseif not UnitIsUnit(self.unit, "player") and button=="MiddleButton" and HealBot_UnitGUID(self.unit) then
                    HealBot_Panel_AddBlackList(HealBot_UnitGUID(self.unit))
                end
            elseif not HealBot_Data["UILOCK"] then
                if UnitAffectingCombat(self.unit)==1 then 
                    return
                end
                if HealBot_Globals.ProtectPvP then
                    if UnitIsPVP(self.unit) and not UnitIsPVP("player") then 
                        HealBot_Action_SetButtonAttrib(self,abutton,ModKey,"nil",aj)
                        usedSmartCast=true;
                    end
                end
                if button=="LeftButton" and HealBot_Globals.SmartCast and not IsModifierKeyDown() then
                    HealBot_Action_UseSmartCast(self)
                end
                if not self.status.enabled and HealBot_Config.EnableHealthy==false and not usedSmartCast then
                    HealBot_Action_SetButtonAttrib(self,abutton,ModKey,"Disabled",aj)
                    usedSmartCast=true;
                end
            end
        end
    end
end

local function HealBot_Action_PostClick(self,button)
    if self.id==999 then
        HealBot_Panel_clickToFocus("hide")
        HealBot_nextRecalcParty(3)
    elseif UnitExists(self.unit) and UnitIsFriend("player",self.unit) and usedSmartCast then
        if self.unit=="target" then
            if aj==1 then
                self:SetAttribute(HB_prefix.."helpbutton"..aj, "target"..aj);
                self:SetAttribute(HB_prefix.."type"..aj, "target")
                self:SetAttribute(HB_prefix.."type-target"..aj, "target")
            end
        else
            HealBot_Action_SetButtonAttrib(self,abutton,ModKey,"Enemy",aj)
            HealBot_Action_SetButtonAttrib(self,abutton,ModKey,"Enabled",aj)
        end
    end
end

function HealBot_Action_OnLoad(self)
    self:SetScript("PreClick", HealBot_Action_PreClick); 
    self:SetScript("PostClick", HealBot_Action_PostClick)
end

function HealBot_Action_setRegisterForClicks(button)
    if button then
        if HealBot_Config_Spells.ButtonCastMethod==1 then
            button:RegisterForClicks("LeftButtonDown", "MiddleButtonDown", "RightButtonDown", "Button4Down", "Button5Down",
                                        "Button6Down", "Button7Down", "Button8Down", "Button9Down", "Button10Down",
                                       "Button11Down", "Button12Down", "Button13Down", "Button14Down", "Button15Down");
        else
            button:RegisterForClicks("LeftButtonUp", "MiddleButtonUp", "RightButtonUp", "Button4Up", "Button5Up",
                                        "Button6Up", "Button7Up", "Button8Up", "Button9Up", "Button10Up",
                                        "Button11Up", "Button12Up", "Button13Up", "Button14Up", "Button15Up");
        end
    else
        if HealBot_Config_Spells.ButtonCastMethod==1 then
            for _,xButton in pairs(HealBot_Unit_Button) do
                xButton:RegisterForClicks("LeftButtonDown", "MiddleButtonDown", "RightButtonDown", "Button4Down", "Button5Down",
                                        "Button6Down", "Button7Down", "Button8Down", "Button9Down", "Button10Down",
                                       "Button11Down", "Button12Down", "Button13Down", "Button14Down", "Button15Down");
            end
            for _,xButton in pairs(HealBot_Enemy_Button) do
                xButton:RegisterForClicks("LeftButtonDown", "MiddleButtonDown", "RightButtonDown", "Button4Down", "Button5Down",
                                        "Button6Down", "Button7Down", "Button8Down", "Button9Down", "Button10Down",
                                       "Button11Down", "Button12Down", "Button13Down", "Button14Down", "Button15Down");
            end
            for _,xButton in pairs(HealBot_Pet_Button) do
                xButton:RegisterForClicks("LeftButtonDown", "MiddleButtonDown", "RightButtonDown", "Button4Down", "Button5Down",
                                        "Button6Down", "Button7Down", "Button8Down", "Button9Down", "Button10Down",
                                       "Button11Down", "Button12Down", "Button13Down", "Button14Down", "Button15Down");
            end
        else
            for _,xButton in pairs(HealBot_Unit_Button) do
                xButton:RegisterForClicks("LeftButtonUp", "MiddleButtonUp", "RightButtonUp", "Button4Up", "Button5Up",
                                    "Button6Up", "Button7Up", "Button8Up", "Button9Up", "Button10Up",
                                    "Button11Up", "Button12Up", "Button13Up", "Button14Up", "Button15Up");
            end
            for _,xButton in pairs(HealBot_Enemy_Button) do
                xButton:RegisterForClicks("LeftButtonUp", "MiddleButtonUp", "RightButtonUp", "Button4Up", "Button5Up",
                                    "Button6Up", "Button7Up", "Button8Up", "Button9Up", "Button10Up",
                                    "Button11Up", "Button12Up", "Button13Up", "Button14Up", "Button15Up");
            end
            for _,xButton in pairs(HealBot_Pet_Button) do
                xButton:RegisterForClicks("LeftButtonUp", "MiddleButtonUp", "RightButtonUp", "Button4Up", "Button5Up",
                                    "Button6Up", "Button7Up", "Button8Up", "Button9Up", "Button10Up",
                                    "Button11Up", "Button12Up", "Button13Up", "Button14Up", "Button15Up");
            end
        end
    end
end

local HealBot_AggroBarColr = {[-2]=0.7, [-1]=1, [0]=1, [1]=1, [2]=1, [3]=1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1}
local HealBot_AggroBarColg = {[-2]=0.7, [-1]=1, [0]=1, [1]=1, [2]=0.1, [3]=0.1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1}
local HealBot_AggroBarColb = {[-2]=1, [-1]=1, [0]=0.4, [1]=0.2, [2]=0.1, [3]=0.1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1}
local HealBot_AggroUnitThreat=1

function HealBot_Action_SetDebuffAggroCols()
    HealBot_AggroBarColr[5]=HealBot_Config_Cures.CDCBarColour[HEALBOT_DISEASE_en].R
    HealBot_AggroBarColg[5]=HealBot_Config_Cures.CDCBarColour[HEALBOT_DISEASE_en].G
    HealBot_AggroBarColb[5]=HealBot_Config_Cures.CDCBarColour[HEALBOT_DISEASE_en].B 
    HealBot_AggroBarColr[6]=HealBot_Config_Cures.CDCBarColour[HEALBOT_MAGIC_en].R
    HealBot_AggroBarColg[6]=HealBot_Config_Cures.CDCBarColour[HEALBOT_MAGIC_en].G
    HealBot_AggroBarColb[6]=HealBot_Config_Cures.CDCBarColour[HEALBOT_MAGIC_en].B 
    HealBot_AggroBarColr[7]=HealBot_Config_Cures.CDCBarColour[HEALBOT_POISON_en].R
    HealBot_AggroBarColg[7]=HealBot_Config_Cures.CDCBarColour[HEALBOT_POISON_en].G
    HealBot_AggroBarColb[7]=HealBot_Config_Cures.CDCBarColour[HEALBOT_POISON_en].B 
    HealBot_AggroBarColr[8]=HealBot_Config_Cures.CDCBarColour[HEALBOT_CURSE_en].R
    HealBot_AggroBarColg[8]=HealBot_Config_Cures.CDCBarColour[HEALBOT_CURSE_en].G
    HealBot_AggroBarColb[8]=HealBot_Config_Cures.CDCBarColour[HEALBOT_CURSE_en].B 
    HealBot_AggroBarColr[9]=HealBot_Globals.CDCBarColour[HEALBOT_CUSTOM_en.."10"].R
    HealBot_AggroBarColg[9]=HealBot_Globals.CDCBarColour[HEALBOT_CUSTOM_en.."10"].G
    HealBot_AggroBarColb[9]=HealBot_Globals.CDCBarColour[HEALBOT_CUSTOM_en.."10"].B
end

function HealBot_Action_SetHightlightAggroCols()
    HealBot_AggroBarColr[-1]=Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["CR"]
    HealBot_AggroBarColg[-1]=Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["CG"]
    HealBot_AggroBarColb[-1]=Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["CB"]
end

function HealBot_Action_SetHightlightTargetAggroCols()
    HealBot_AggroBarColr[-2]=Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["TR"]
    HealBot_AggroBarColg[-2]=Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["TG"]
    HealBot_AggroBarColb[-2]=Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["TB"]
end

function HealBot_Action_SetAggroCols()
    HealBot_AggroBarColr[2]=Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["R"]
    HealBot_AggroBarColg[2]=Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["G"]
    HealBot_AggroBarColb[2]=Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["B"]
    HealBot_AggroBarColr[3]=Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["R"]
    HealBot_AggroBarColg[3]=Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["G"]
    HealBot_AggroBarColb[3]=Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["B"]
end

local function HealBot_Action_UpdateFluidBar(button)
    local hrpct=100
    local barName = _G["HealBot_Action_HealUnit"..button.id.."Bar"]
    if button.status.current==9 or (UnitIsDeadOrGhost(button.unit) and not UnitIsFeignDeath(button.unit)) then
        barName:SetValue(0)
    else
        if button.health.current<button.health.max then
            hrpct=floor((button.health.current/button.health.max)*100)
        end
        local barValue=barName:GetValue()
        if barValue>hrpct then
            local setValue=barValue-Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["FLUIDFREQ"]
            if setValue<hrpct then
                setValue=hrpct
                if button.status.current>3 and button.status.current<9 and button.status.range==1 then
                    if button.health.incoming>0 then HealBot_Action_UpdateHealsInButton(button) end
                    if button.health.absorbs>0 then HealBot_Action_UpdateAbsorbsButton(button) end
                end
            end
            barName:SetValue(setValue)
            HealBot_Action_luVars["UpdateFluidBars"]=true
        elseif barValue<hrpct then
            local setValue=barValue+Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["FLUIDFREQ"]
            if setValue>hrpct then
                setValue=hrpct
                if button.status.current>3 and button.status.current<9 and button.status.range==1 then
                    if button.health.incoming>0 then HealBot_Action_UpdateHealsInButton(button) end
                    if button.health.absorbs>0 then HealBot_Action_UpdateAbsorbsButton(button) end
                end
            end
            barName:SetValue(setValue)
            HealBot_Action_luVars["UpdateFluidBars"]=true
        end
    end
end

local function HealBot_Action_UpdateFluidBars()
    HealBot_Action_luVars["UpdateFluidBars"]=false
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Action_UpdateFluidBar(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Action_UpdateFluidBar(xButton)
    end
  --HealBot_setCall("HealBot_Action_UpdateFluidBars")
end

local function HealBot_Action_UpdateAggroBar(button)
    local bar4=_G["HealBot_Action_HealUnit"..button.id.."Bar4"]
    if UnitExists(button.unit) then
        HealBot_AggroUnitThreat=button.aggro.status or 2
        if HealBot_AggroUnitThreat==9 and button.aura.debuff.name then
            if HealBot_Globals.CDCBarColour[button.aura.debuff.name] then
                bar4:SetStatusBarColor(HealBot_Globals.CDCBarColour[button.aura.debuff.name].R,
                                       HealBot_Globals.CDCBarColour[button.aura.debuff.name].G,
                                       HealBot_Globals.CDCBarColour[button.aura.debuff.name].B,HealBot_Action_luVars["AggroBarAlpha"])
            else
                local customDebuffPriority=HEALBOT_CUSTOM_en.."10"
                if HealBot_GlobalsDefaults.HealBot_Custom_Debuffs[button.aura.debuff.name] then
                    customDebuffPriority=HEALBOT_CUSTOM_en..HealBot_GlobalsDefaults.HealBot_Custom_Debuffs[button.aura.debuff.name]
                end
                bar4:SetStatusBarColor(HealBot_Globals.CDCBarColour[customDebuffPriority].R,
                                       HealBot_Globals.CDCBarColour[customDebuffPriority].G,
                                       HealBot_Globals.CDCBarColour[customDebuffPriority].B,HealBot_Action_luVars["AggroBarAlpha"])
            end
        else
            bar4:SetStatusBarColor(HealBot_AggroBarColr[HealBot_AggroUnitThreat],HealBot_AggroBarColg[HealBot_AggroUnitThreat],HealBot_AggroBarColb[HealBot_AggroUnitThreat],HealBot_Action_luVars["AggroBarAlpha"])
        end
        HealBot_Action_luVars["UpdatedAggroBars"]=true
    else
        bar4:SetStatusBarColor(1,0,0,0)
        button.status.bar4=0
    end
end

local function HealBot_Action_UpdateAggroBars()
    HealBot_Action_luVars["UpdatedAggroBars"]=false
    for _,xButton in pairs(HealBot_Unit_Button) do
        if xButton.status.bar4>0 then
            HealBot_Action_UpdateAggroBar(xButton)
        end
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        if xButton.status.bar4>0 then
            HealBot_Action_UpdateAggroBar(xButton)
        end
    end
    if HealBot_Action_luVars["AggroBarUp"] then
        HealBot_Action_luVars["AggroBarAlpha"]=HealBot_Action_luVars["AggroBarAlpha"]+0.04+Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["FREQ"]
        if HealBot_Action_luVars["AggroBarAlpha"]>=Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["MAXA"] then
            HealBot_Action_luVars["AggroBarUp"]=false
            HealBot_Action_luVars["AggroBarAlpha"]=Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["MAXA"]
        end
    else
        HealBot_Action_luVars["AggroBarAlpha"]=HealBot_Action_luVars["AggroBarAlpha"]-0.04-Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["FREQ"]
        if HealBot_Action_luVars["AggroBarAlpha"]<=Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["MINA"] then
            HealBot_Action_luVars["AggroBarUp"]=true
            HealBot_Action_luVars["AggroBarAlpha"]=Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["MINA"]
        end
    end
  --HealBot_setCall("HealBot_Action_UpdateAggroBars")
end

function HealBot_Action_UpdateBars()
    if HealBot_Action_luVars["UpdatedAggroBars"] then
        HealBot_Action_UpdateAggroBars()
    end
    if HealBot_Action_luVars["UpdateFluidBars"] then
        HealBot_Action_UpdateFluidBars()
    end
end

local HealBot_Action_Init={}
function HealBot_Action_OnShow(self, hbCurFrame)
    if Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][hbCurFrame]["OPENSOUND"] then
        PlaySound(SOUNDKIT.IG_ABILITY_OPEN);
    end
    HealBot_Config.ActionVisible[hbCurFrame]=true
    if not HealBot_Action_Init[hbCurFrame] then
        self:SetBackdropColor(
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][hbCurFrame]["BACKR"],
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][hbCurFrame]["BACKG"],
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][hbCurFrame]["BACKB"], 
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][hbCurFrame]["BACKA"]);
        self:SetBackdropBorderColor(
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][hbCurFrame]["BORDERR"],
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][hbCurFrame]["BORDERG"],
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][hbCurFrame]["BORDERB"],
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][hbCurFrame]["BORDERA"]);
        HealBot_Action_Init[hbCurFrame]=true
        HealBot_Action_SetAlias(hbCurFrame)
        HealBot_Action_SetAliasFontSize(hbCurFrame)
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
        g:SetPoint("TOP",0,Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame]["OFFSET"]);
    end
end

function HealBot_Action_OnHide(self, hbCurFrame)
    HealBot_Config.ActionVisible[hbCurFrame]=false
end

function HealBot_Action_OnMouseDown(self,button, hbCurFrame)
    if button=="LeftButton" then
        if Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][hbCurFrame]["LOCKED"]==false or (HealBot_Globals.ByPassLock==1 and IsControlKeyDown() and IsAltKeyDown()) then
            HealBot_Action_luVars["FrameMoving"]=true
            HealBot_StartMoving(self);
        end
    end
end

function HealBot_Action_OnMouseUp(self,button,bID)
    if button=="LeftButton" and HealBot_Action_luVars["FrameMoving"] then
        HealBot_StopMoving(self,bID);
        HealBot_Action_luVars["FrameMoving"]=false
    elseif button=="RightButton" and not HealBot_Data["UILOCK"] and HealBot_Globals.RightButtonOptions then
        HealBot_Action_OptionsButton_OnClick();
    end
end

function HealBot_Action_OnDragStart(self, hbCurFrame)
    if Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][hbCurFrame]["LOCKED"]==false then
        HealBot_Action_luVars["FrameMoving"]=true
        HealBot_StartMoving(self);
    end
end

function HealBot_Action_Toggle_Enabled(button)
    local xGUID=HealBot_UnitGUID(button.unit)
    if HealBot_MyTargets[xGUID] then
        HealBot_MyTargets[xGUID]=nil
    else
        HealBot_MyTargets[xGUID]=true
    end
    HealBot_RecalcHeals(button)
end

function HealBot_Action_RetMyTarget(hbGUID)
    return HealBot_MyTargets[hbGUID]
end

function HealBot_Action_SmartCast(button)
    if button.status.current==9 and UnitIsUnit("player",button.unit) then return nil; end
    local scuSpell = nil
    local rSpell=HealBot_RangeSpells["HEAL"]
 
    if HealBot_Globals.SmartCastRes and button.status.current==9 then
        local mrSpell = HealBot_Init_retSmartCast_MassRes();
		scuSpell=HealBot_Init_retSmartCast_Res();
        rSpell=HealBot_RangeSpells["RES"]
    elseif button.aura.debuff.type and HealBot_Globals.SmartCastDebuff then
        scuSpell=HealBot_Options_retDebuffCureSpell(button.aura.debuff.type);
        rSpell=HealBot_RangeSpells["CURE"]
    elseif button.aura.buff.name and HealBot_Globals.SmartCastBuff then
        scuSpell=button.aura.buff.name
        rSpell=HealBot_RangeSpells["BUFF"]
    elseif HealBot_Globals.SmartCastHeal then
        local x=button.health.max-(button.health.current+button.health.incoming)
        if x>(UnitLevel("player")*20) then
            scuSpell=HealBot_SmartCast(x)
        end
    end
 
    if HealBot_UnitInRange(button.unit, rSpell, false)<1 then
        return nil
    end
    return scuSpell;
end

function HealBot_MountsPets_InitUse()
    if (HealBot_Globals.HealBot_MouseWheelTxt["NoneUp"] and (HealBot_Globals.HealBot_MouseWheelTxt["NoneUp"]==HEALBOT_RANDOMMOUNT or HealBot_Globals.HealBot_MouseWheelTxt["NoneUp"]==HEALBOT_RANDOMGOUNDMOUNT))
    or (HealBot_Globals.HealBot_MouseWheelTxt["NoneDown"] and (HealBot_Globals.HealBot_MouseWheelTxt["NoneDown"]==HEALBOT_RANDOMMOUNT or HealBot_Globals.HealBot_MouseWheelTxt["NoneDown"]==HEALBOT_RANDOMGOUNDMOUNT))
    or (HealBot_Globals.HealBot_MouseWheelTxt["ShiftUp"] and (HealBot_Globals.HealBot_MouseWheelTxt["ShiftUp"]==HEALBOT_RANDOMMOUNT or HealBot_Globals.HealBot_MouseWheelTxt["ShiftUp"]==HEALBOT_RANDOMGOUNDMOUNT))
    or (HealBot_Globals.HealBot_MouseWheelTxt["ShiftDown"] and (HealBot_Globals.HealBot_MouseWheelTxt["ShiftDown"]==HEALBOT_RANDOMMOUNT or HealBot_Globals.HealBot_MouseWheelTxt["ShiftDown"]==HEALBOT_RANDOMGOUNDMOUNT))
    or (HealBot_Globals.HealBot_MouseWheelTxt["CtrlUp"] and (HealBot_Globals.HealBot_MouseWheelTxt["CtrlUp"]==HEALBOT_RANDOMMOUNT or HealBot_Globals.HealBot_MouseWheelTxt["CtrlUp"]==HEALBOT_RANDOMGOUNDMOUNT))
    or (HealBot_Globals.HealBot_MouseWheelTxt["CtrlDown"] and (HealBot_Globals.HealBot_MouseWheelTxt["CtrlDown"]==HEALBOT_RANDOMMOUNT or HealBot_Globals.HealBot_MouseWheelTxt["CtrlDown"]==HEALBOT_RANDOMGOUNDMOUNT))
    or (HealBot_Globals.HealBot_MouseWheelTxt["AltUp"] and (HealBot_Globals.HealBot_MouseWheelTxt["AltUp"]==HEALBOT_RANDOMMOUNT or HealBot_Globals.HealBot_MouseWheelTxt["AltUp"]==HEALBOT_RANDOMGOUNDMOUNT))
    or (HealBot_Globals.HealBot_MouseWheelTxt["AltDown"] and (HealBot_Globals.HealBot_MouseWheelTxt["AltDown"]==HEALBOT_RANDOMMOUNT or HealBot_Globals.HealBot_MouseWheelTxt["AltDown"]==HEALBOT_RANDOMGOUNDMOUNT)) then
        HealBot_setOptions_Timer(410)
    end
end

function HealBot_MountsPets_InitMount()
    --SetMapToCurrentZone()
    for z,_ in pairs(HealBot_GMount) do
        HealBot_GMount[z]=nil;
    end
    for z,_ in pairs(HealBot_FMount) do
        HealBot_FMount[z]=nil;
    end
    for z,_ in pairs(HealBot_SMount) do
        HealBot_SMount[z]=nil;
    end
    for z,_ in pairs(HealBot_PrevGMounts) do
        HealBot_PrevGMounts[z]=nil;
    end
    for z,_ in pairs(HealBot_PrevFMounts) do
        HealBot_PrevFMounts[z]=nil;
    end
    for z,_ in pairs(HealBot_MountIndex) do
        HealBot_MountIndex[z]=nil;
    end
    HealBot_mountData["IncFlying"]=false
    
    HealBot_mountData["playerFaction"]=0 -- Horde
    local _,raceId = UnitRace("player");
    if raceId=="Dwarf" or raceId=="Draenei" or raceId=="Gnome" or raceId=="Human" or raceId=="NightElf" or raceId=="Worgen" then
        HealBot_mountData["playerFaction"]=1
    elseif raceId=="Pandaren" then
        if UnitFactionGroup("player")=="Alliance" then
            HealBot_mountData["playerFaction"]=1
        end
    end

    local mapC = 3 --GetCurrentMapContinent();
    if UnitLevel("player")>59 and (mapC==3 or mapC==5) or (mapC == 4 and IsSpellKnown(54197)) or (mapC<3 and IsSpellKnown(90267)) 
        or (mapC == 6 and IsSpellKnown(115913)) then --or (mapC == 7 and IsSpellKnown(nnnnnn)) then
        HealBot_mountData["IncFlying"]=true
    end
    
    local x = C_MountJournal.GetNumMounts()
	for z=1,x do
        local mount, sID, _, _, isUsable, _, _, _, faction, _, isCollected = C_MountJournal.GetMountInfoByID(z)
        if faction and isUsable and isCollected then
            local englishFaction = UnitFactionGroup("player")
            if (faction~=HealBot_mountData["playerFaction"]) then
                isUsable=nil
            end
        end
        
        if isUsable and isCollected and not HealBot_Globals.excludeMount[mount] then
            local _, _, _, _, mountType = C_MountJournal.GetMountInfoExtraByID(z)
            if (mountType==248 or mountType==247 or mountType==242) then
                if HealBot_mountData["IncFlying"] then
                    table.insert(HealBot_FMount, mount);
                    HealBot_MountIndex[mount]=z
                end
            elseif (mountType==232 or mountType==254) then
                table.insert(HealBot_SMount, mount);
                HealBot_MountIndex[mount]=z
            elseif (mountType==230 or mountType==231 or mountType==241) then
                table.insert(HealBot_GMount, mount);
                HealBot_MountIndex[mount]=z
            end
        end
	end   
    
    if #HealBot_FMount<4 then
        HealBot_mountData["PrevFlying#"]=0
    else
        HealBot_mountData["PrevFlying#"]=ceil(#HealBot_FMount/3) 
    end
    if #HealBot_GMount<4 then
        HealBot_mountData["PrevGround#"]=0
    else
        HealBot_mountData["PrevGround#"]=ceil(#HealBot_GMount/3) 
    end

    if #HealBot_GMount==0 and #HealBot_FMount==0 then
        HealBot_mountData["ValidUse"]=false
    else
        HealBot_mountData["ValidUse"]=true
    end
end

function HealBot_MountsPets_DislikeMount(action)
    local z = C_MountJournal.GetNumMounts()
    local mount=nil
	for i=1,z do
 		local creatureName, sID, _, active, isUsable, _, _, _, _, _, isCollected = C_MountJournal.GetMountInfoByID(i)
 		if active then
 			mount=creatureName
            break
 		end
 	end
    if mount then
        if action=="Exclude" then
            if HealBot_Globals.excludeMount[mount] then
                HealBot_AddChat(HEALBOT_OPTION_EXCLUDEMOUNT_OFF.." "..mount)
                HealBot_Globals.excludeMount[mount]=nil
            else
                HealBot_AddChat(HEALBOT_OPTION_EXCLUDEMOUNT_ON.." "..mount)
                HealBot_Globals.excludeMount[mount]=true
            end
            HealBot_setOptions_Timer(405)
        else
            if HealBot_Globals.dislikeMount[mount] then
                HealBot_AddChat(HEALBOT_OPTION_DISLIKEMOUNT_OFF.." "..mount)
                HealBot_Globals.dislikeMount[mount]=nil
            else
                HealBot_AddChat(HEALBOT_OPTION_DISLIKEMOUNT_ON.." "..mount)
                HealBot_Globals.dislikeMount[mount]=275
            end
        end
    end
end
