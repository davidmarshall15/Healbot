local HealBot_UnitStatus={};
local HealBot_PlayerDead=false;
local HealBot_CheckGroup=0;
local HealBot_Enabled={};
local HealBot_PetMaxH={};
local HealBot_PetMaxHcnt1={};
local HealBot_PetMaxHcnt2={};
local HealBot_AttribStatus={};
local HealBot_UnitRange={}
local HealBot_UnitRangeSpell={}
local HealBot_UnitBarsRange={["r"]={},["g"]={},["b"]={},["a"]={},["3a"]={},["hr"]={},["hg"]={},["hb"]={},["sr"]={},["sg"]={},["sb"]={}}
local HealBot_UnitTextRange={["ir"]={},["ig"]={},["ib"]={},["or"]={},["og"]={},["ob"]={},["oa"]={}}
local HealBot_curUnitHealth={}
local HealBot_UnitBarUpdate={}
local HealBot_UnitOffline={}
local HealBot_ResetAttribs=nil
local ceil=ceil;
local floor=floor
local strsub=strsub
local HealBot_ActiveButtons={[0]=1}
local HealBot_RangeSpells={}
local HealBot_Aggro={}
local HealBot_AggroIndicator={}
local HealBot_AggroBarA=0.8
local HealBot_AggroBarAup=true
local HealBot_MyTargets={}
local HealBot_pcClass={[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
local HealBot_pcMax=3
local HealBot_FrameMoving=nil
local LSM = HealBot_retLSM() --LibStub("LibSharedMedia-3.0")
local HealBot_UnitThreat={}
local HealBot_ResetBarSkinDone={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
local HealBot_Hightlight={}
local HealBot_Reserved={}
local HealBot_UnitDirection={}
local HealBot_UnitHasRes={}
local _

-- Register Default HealBot Media

local HealBot_prevUnitThreat={}
local Healbot_tempUnitThreat=0
local UnitDebuffStatus={}
local HealBot_UnitThreatPct={}
local HealBot_UnitAggro={}
local hbprevThreatPct=-3
local hbstringSub=nil
local hbstringLen=nil
if HealBot_Globals.useUTF8 then
    hbstringSub=string.utf8sub
    hbstringLen=string.utf8len
else
    hbstringSub=string.sub
    hbstringLen=string.len
end

function HealBot_Action_UpdateAggro(unit,status,threatStatus,threatPct)
    local xButton=HealBot_Unit_Button[unit]
    if not xButton then return end

    local barName=HealBot_Action_HealthBar4(xButton)
    if not barName then return end    
    if UnitExists(unit) and UnitIsFriend("player",unit) then
        if UnitIsDeadOrGhost(unit) and not UnitIsFeignDeath(unit) then
            status=nil
            threatPct=0
            if threatStatus then threatStatus=0 end
        end
        hbprevThreatPct=HealBot_UnitThreatPct[unit] or -4
        if threatStatus and (Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["SHOWBARSPCT"] or Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["SHOWTEXTPCT"]) then
            if not threatPct then threatPct,_=HealBot_CalcThreat(unit) end
           -- threatPct,_=HealBot_CalcThreat(unit)
            if threatPct>0 then
                HealBot_UnitThreatPct[unit]=threatPct
                if threatStatus==0 then
                    threatStatus=1
                    if not status then status=true end
                end
            elseif threatStatus==3 then
                HealBot_UnitThreatPct[unit]=100
            elseif threatStatus==2 then
                if not HealBot_UnitThreatPct[unit] then HealBot_UnitThreatPct[unit]=75 end
            elseif threatStatus==1 then
                if not HealBot_UnitThreatPct[unit] then HealBot_UnitThreatPct[unit]=25 end
            elseif threatStatus>4 then 
                if not HealBot_UnitThreatPct[unit] then HealBot_UnitThreatPct[unit]=50 end
            else
                HealBot_UnitThreatPct[unit]=0
            end
            if HealBot_UnitThreatPct[unit]>0 then HealBot_UnitAggro[unit]=true end
        else
            if not threatStatus then threatStatus=0 end
            HealBot_UnitThreatPct[unit]=0
            if status and not UnitIsFriend("player",unit) then status=nil end
        end
        if status then
            if HealBot_Config_Cures.CDCshownAB and UnitDebuffStatus[unit] then
                HealBot_Aggro[unit]="d"
                HealBot_UnitThreat[unit]=UnitDebuffStatus[unit]
            elseif Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["SHOW"] and 
                   threatStatus>Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["ALERT"] then
                HealBot_UnitThreat[unit]=threatStatus
                HealBot_Aggro[unit]="a"
                HealBot_UnitAggro[unit]=true
            elseif status=="target" and Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["TBAR"] then
                HealBot_Aggro[unit]="h"
                HealBot_UnitThreat[unit]=-2
                HealBot_Hightlight[unit]="T"
            elseif status=="highlight" and Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["CBAR"] then
                HealBot_Aggro[unit]="h"
                HealBot_UnitThreat[unit]=-1
                HealBot_Hightlight[unit]="M"
            elseif HealBot_Aggro[unit] and HealBot_Aggro[unit]=="h" then
                if status~="off" then
                    if (HealBot_Hightlight[unit] or "M")=="M" then 
                        HealBot_UnitThreat[unit]=-1
                    else    
                        HealBot_UnitThreat[unit]=-2
                    end
                else
                    HealBot_Aggro[unit]=nil
                    HealBot_UnitThreat[unit]=threatStatus
                end
            else
                HealBot_UnitThreat[unit]=threatStatus
                HealBot_Aggro[unit]="a"
            end
            if Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["SHOW"] and
                Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["SHOWIND"] and
                (HealBot_AggroIndicator[unit] or -11) ~= threatStatus then
                    HealBot_Action_aggoIndicatorUpd(unit, threatStatus)
            end
        else
            HealBot_UnitThreat[unit]=threatStatus
            HealBot_Aggro[unit]=nil
            if HealBot_AggroIndicator[unit] then
                HealBot_AggroIndicator[unit]=nil
                HealBot_Action_aggoIndicatorUpd(unit, 0)
            end
        end
        if status and 
           (HealBot_Aggro[unit]=="d" or HealBot_Aggro[unit]=="h" or 
           (HealBot_Aggro[unit]=="a" and Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["SHOWBARS"] and
           threatStatus>Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["ALERT"])) then
            if HealBot_UnitThreat[unit]>-1 and HealBot_UnitThreat[unit]<4 and Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["SHOWBARSPCT"] then
                barName:SetValue(HealBot_UnitThreatPct[unit])
            else
                barName:SetValue(100)
            end
            xButton.bar4state=1
        else
            HealBot_Hightlight[unit]=nil
            barName:SetStatusBarColor(1,0,0,0)
            xButton.bar4state=0
        end
    else
        HealBot_Hightlight[unit]=nil
        barName:SetStatusBarColor(1,0,0,0)
        xButton.bar4state=0
    end
    if HealBot_UnitThreatPct[unit]~=hbprevThreatPct then HealBot_Action_ResetUnitStatus(unit) end
end

function HealBot_Action_aggoIndicatorUpd(unit, threatStatus)
    local xButton=HealBot_Unit_Button[unit]
    if not xButton then return end
    local mainBar=HealBot_Action_HealthBar(HealBot_Unit_Button[unit])
    local iconName=nil
    if not UnitExists(unit) or (UnitExists(unit) and not UnitIsFriend("player",unit)) then
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
    else
        HealBot_AggroIndicator[unit]=threatStatus
        if threatStatus>=Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["ALERTIND"] then
            if threatStatus==1 then
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
            elseif threatStatus==2 then
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
            elseif threatStatus==3 then
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
        elseif threatStatus>-1 and threatStatus<4 then
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

function HealBot_Action_SetThreatPct(unit, threatPct)
    if threatPct then
        hbprevThreatPct=HealBot_UnitThreatPct[unit] or -2
        HealBot_UnitThreatPct[unit]=threatPct
        if HealBot_UnitThreatPct[unit]~=hbprevThreatPct then HealBot_Action_ResetUnitStatus(unit) end
    end
end

function HealBot_Action_SetVAggro(unit, threatStatus)
    if threatStatus then
        HealBot_Aggro[unit]="a"
    else
        HealBot_Aggro[unit]=nil
    end
end

function HealBot_Action_retAggro(unit)
    return HealBot_Aggro[unit]
end

function HealBot_Action_EndAggro(check)
    if not check then
        for xUnit,_ in pairs(HealBot_Unit_Button) do
            if (HealBot_Aggro[xUnit] or "a")=="a" then
                HealBot_Action_UpdateAggro(xUnit,false,nil,0)
                HealBot_Action_aggoIndicatorUpd(xUnit, 0)
            end
        end
    end
    for xUnit,_ in pairs(HealBot_Aggro) do
        if HealBot_Aggro[xUnit]=="a" then
            if check then
                HealBot_qClearUnitAggro(xUnit)
            else
                HealBot_Action_UpdateAggro(xUnit,false,nil,0)
            end
        end
    end
end

function HealBot_Action_SetUnitDebuffStatus(unit,status)
    if not status then
        UnitDebuffStatus[unit]=nil
    else
        UnitDebuffStatus[unit]=status
    end
end

function HealBot_Action_ClearUnitDebuffStatus(unit)
    if unit then
        UnitDebuffStatus[unit]=nil
    else
        for x,_ in pairs(UnitDebuffStatus) do
            UnitDebuffStatus[x]=nil;
        end
    end
end

function HealBot_Action_RetUnitThreat(unit)
    return HealBot_UnitThreat[unit] or -9
end

function HealBot_Action_RetHealBot_UnitStatus(unit)
    return HealBot_UnitStatus[unit] or -9
end

function HealBot_Action_setpcClass()
    for j=1,10 do
        if (HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_PALADIN] or HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_MONK]) and 
            Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j] and Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j]["POWERCNT"] then
            local prevHealBot_pcMax=HealBot_pcMax;
            if HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_PALADIN] then
                HealBot_pcClass[j]=9
                HealBot_pcMax = UnitPowerMax("player" , 9);
            else
                HealBot_pcClass[j]=12
                HealBot_pcMax = UnitPowerMax("player" , 12);
            end     
            if prevHealBot_pcMax~=HealBot_pcMax then
                HealBot_Action_clearResetBarSkinDone()
                if HealBot_Data["REFRESH"]<1 then HealBot_Data["REFRESH"]=1; end
            end
        else
            HealBot_pcClass[j]=false
            local barName = HealBot_Action_HealthBar3(HealBot_Unit_Button["player"])
            if barName then
                for y=1,5 do
                    local iconName = _G[barName:GetName().."Icon"..y];
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
	local x=HealBot_GetBandageType()
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
            HealBot_RangeSpells["HARM"]=HEALBOT_SHADOW_WORD_PAIN -- 40
            x=HEALBOT_SHADOW_WORD_PAIN
        elseif HealBot_GetSpellId(HEALBOT_SMITE) then 
            HealBot_RangeSpells["HARM"]=HEALBOT_SMITE -- 30
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
    HealBot_Set_debuffSpell(HealBot_RangeSpells["CURE"])
end

function HealBot_GetBandageType()
    local bandage = ""
    if IsUsableItem(HEALBOT_DENSE_EMBERSILK_BANDAGE) or HealBot_IsItemInBag(HEALBOT_DENSE_EMBERSILK_BANDAGE) then bandage = HEALBOT_DENSE_EMBERSILK_BANDAGE
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
    else
        bandage = HEALBOT_WORDS_UNKNOWN
    end
    return bandage
end

function HealBot_HealthColor(unit,hlth,maxhlth,tooltipcol,UnitDead,Member_Buff,Member_Debuff,healin,absorbs,getBar5,button,hRange)
    local hca,hcr,hir,hcg,hig,hcb,hib,hbr,hbg,hbb,har,hag,hab=0,0,0,0,0,0,0,0,0,0,0,0,0
    local hcaggro,hcta,hcpct,hipct,hrpct,hapct,hbuff=nil,nil,nil,nil,100,nil,nil
    if UnitDead then
        hcpct=0
        hipct=0
        hrpct=0
        hapct=0
    else
        hipct = hlth+healin
        if hipct<maxhlth then
            hipct=hipct/maxhlth
        else
            hipct=1;
        end
        hcpct=hlth/maxhlth
        if maxhlth == 0 then
            hrpct = 100;
        else
            hrpct=floor((hlth/maxhlth)*100)
        end
        if Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AC"] == 1 then
            hapct=hlth+absorbs
        else
            hapct=hlth+healin+absorbs
        end
        if hapct<maxhlth then
            hapct=hapct/maxhlth
        else
            hapct=1;
        end
    end
  
    if HealBot_Aggro[unit] and (HealBot_UnitThreat[unit] or 0)>Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["ALERT"] and UnitIsConnected(unit) then
        hcaggro=true
    else
        hcaggro=nil
    end
    
    if not tooltipcol then
        HealBot_UnitStatus[unit]=1
        if UnitDead then
            HealBot_UnitStatus[unit]=8
            hbuff=true
        elseif Member_Debuff and UnitIsConnected(unit) then
            if HealBot_Config_Cures.CDCshownHB and HealBot_UnitInRange(HealBot_RangeSpells["CURE"], unit)>(HealBot_Config_Cures.HealBot_CDCWarnRange_Bar-3) and 
              (HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[button.debuff.name]==nil)  then
                if HealBot_Globals.CDCBarColour[button.debuff.name] then
                    hcr = HealBot_Globals.CDCBarColour[button.debuff.name].R
                    hcg = HealBot_Globals.CDCBarColour[button.debuff.name].G
                    hcb = HealBot_Globals.CDCBarColour[button.debuff.name].B
                    hbuff=true
                elseif Member_Debuff == HEALBOT_CUSTOM_en then
                    local customDebuffPriority=HEALBOT_CUSTOM_en.."10"
                    local customDebuffDefaultCat="nil"
                    if HealBot_GlobalsDefaults.HealBot_Custom_Debuffs[button.debuff.name] then
                        customDebuffPriority=HEALBOT_CUSTOM_en..HealBot_GlobalsDefaults.HealBot_Custom_Debuffs[button.debuff.name]
                        if HealBot_GlobalsDefaults.HealBot_Custom_Debuffs[button.debuff.name]==9 then
                            customDebuffDefaultCat=HEALBOT_CUSTOM_CAT_CUSTOM_IMPORTANT
                        elseif HealBot_GlobalsDefaults.HealBot_Custom_Debuffs[button.debuff.name]==10 then
                            customDebuffDefaultCat=HEALBOT_CUSTOM_CAT_CUSTOM_DAMAGE
                        elseif HealBot_GlobalsDefaults.HealBot_Custom_Debuffs[button.debuff.name]==11 then
                            customDebuffDefaultCat=HEALBOT_CUSTOM_CAT_CUSTOM_EFFECT
                        elseif HealBot_GlobalsDefaults.HealBot_Custom_Debuffs[button.debuff.name]==12 then
                            customDebuffDefaultCat=HEALBOT_CUSTOM_CAT_CUSTOM_MISC
                        end
                    end
                    if (HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[customDebuffDefaultCat]==nil) then
                        hcr = HealBot_Globals.CDCBarColour[customDebuffPriority].R
                        hcg = HealBot_Globals.CDCBarColour[customDebuffPriority].G
                        hcb = HealBot_Globals.CDCBarColour[customDebuffPriority].B
                        hbuff=true
                    end
                else
                    hcr = HealBot_Config_Cures.CDCBarColour[Member_Debuff].R
                    hcg = HealBot_Config_Cures.CDCBarColour[Member_Debuff].G
                    hcb = HealBot_Config_Cures.CDCBarColour[Member_Debuff].B
                    hbuff=true
                end
                hca = Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["ORA"]
                hcta = Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["EA"]
            end
        elseif Member_Buff and UnitIsConnected(unit) then
            hcr,hcg,hcb=HealBot_Options_RetBuffRGB(Member_Buff)
            hca = Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["ORA"]
            hcta = Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["EA"]
            hbuff=true
        elseif HealBot_Data["UILOCK"]=="YES" then
            if hlth>maxhlth*Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["ALERTIC"] and not hcaggro then
                local vUnit=HealBot_retIsInVehicle(unit)
                if vUnit then
                    x,y=HealBot_VehicleHealth(vUnit)
                    if x>y*Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["ALERTIC"] and not hcaggro then
                        HealBot_UnitStatus[unit]=0;
                    end
                else
                    HealBot_UnitStatus[unit]=0;
                end
            end
        elseif hlth>maxhlth*Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["ALERTOC"] and not hcaggro then
            local vUnit=HealBot_retIsInVehicle(unit)
            if vUnit then
                x,y=HealBot_VehicleHealth(vUnit)
                if x>y*Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["ALERTOC"] and not hcaggro then
                    HealBot_UnitStatus[unit]=0;
                end
            else
                HealBot_UnitStatus[unit]=0;
            end
        end
    end

    if not hbuff then
        hcr,hcg,hir,hig,har,hag = 1, 1, 1, 1, 1, 1
        if HealBot_UnitStatus[unit]~=0 then
            hca=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["ORA"]
            hcta=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["EA"]
        else
            hca=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["DISA"]
            hcta=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["DA"]
        end
        if (Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HLTH"] >= 2) and not tooltipcol then
            if (Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HLTH"] == 2) then
                hcr,hcg,hcb = HealBot_Action_ClassColour(unit)
            else
                hcr=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HR"]
                hcg=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HG"]
                hcb=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HB"]
            end
        else
            if (Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IC"] == 3) then -- Incoming Heal Bar Colour = "Same as Health (Future Health)"
                hcr, hcg = HealBot_Action_BarColourPct(hipct)
            else 
                hcr, hcg = HealBot_Action_BarColourPct(hcpct)
            end
        end
    end

    if (Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IC"] == 5) then -- Incoming Heal Bar Colour = "Custom"
        hir=Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IR"]
        hig=Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IG"]
        hib=Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IB"]
    elseif (Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IC"] == 4) then -- Incoming Heal Bar Colour = "Future Health"
        hir, hig = HealBot_Action_BarColourPct(hipct)
    else
        hir=hcr
        hig=hcg
        hib=hcb
    end
    if (Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AC"] == 4) then -- Incoming Heal Bar Colour = "Custom"
        har=Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AR"]
        hag=Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AG"]
        hab=Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AB"]
    elseif (Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AC"] == 3) then -- Incoming Heal Bar Colour = "Future Health"
        har, hag = HealBot_Action_BarColourPct(hapct)
        hab=hcb
    else
        har=hcr
        hag=hcg
        hab=hcb
    end
    
    if getBar5 then
        if Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BACK"]<3 and 
           Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HLTH"]==Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BACK"] and not UnitDead then
            hbr,hbg,hbb=hcr,hcg,hcb
        elseif Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BACK"]==1 then
            if Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IC"] > 2 then
                hbr,hbg = HealBot_Action_BarColourPct(hipct)
            else
                hbr,hbg = HealBot_Action_BarColourPct(hcpct)
            end
        elseif Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BACK"]==2 then
            hbr,hbg,hbb = HealBot_Action_ClassColour(unit)
        else
            hbr=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BR"]
            hbg=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BG"]
            hbb=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BB"]
        end
        
    end

    return hcr,hcg,hcb,hca,hrpct,hcta,hir,hig,hib,hbr,hbg,hbb,har,hag,hab
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
    return hcpr, hcpg
end

function HealBot_Action_HealthBar(button)
    if not button or not button:GetName() then return nil end
    local barName = button:GetName();
    return _G[barName.."Bar"];
end

function HealBot_Action_HealthBar2(button)
    if not button or not button:GetName() then return nil end
    local barName = button:GetName();
    return _G[barName.."Bar2"];
end

function HealBot_Action_HealthBar3(button)
    if not button or not button:GetName() then return nil end
    local barName = button:GetName();
    return _G[barName.."Bar3"];
end

function HealBot_Action_HealthBar4(button)
    if not button or not button:GetName() then return nil end
    local barName = button:GetName();
    return _G[barName.."Bar4"];
end

function HealBot_Action_HealthBar5(button)
    if not button or not button:GetName() then return nil end
    local barName = button:GetName();
    return _G[barName.."Bar5"];
end

function HealBot_Action_HealthBar6(button)
    if not button or not button:GetName() then return nil end
    local barName = button:GetName();
    return _G[barName.."Bar6"];
end

function HealBot_Action_HealthBarDir(button)
    if not button or not button:GetName() then return nil end
    local barName = button:GetName();
    return _G[barName.."BarDir"];
end

function HealBot_Action_ShouldHealSome(unit, hbCurFrame)
    if unit and HealBot_Enabled[unit] and HealBot_Enabled[unit]=="e" then 
        return true
    else
        if hbCurFrame then
            for xUnit,xButton in pairs(HealBot_Unit_Button) do
                if xButton.frame==hbCurFrame and HealBot_Enabled[xUnit] and HealBot_Enabled[xUnit]=="e" then
                    return true
                end
            end
        end
    end
    return false
end

function HealBot_MayHeal(unit)
    if UnitCanAttack("player",unit) then 
        return false 
    end
    return true;
end

function HealBot_Action_SetBar3Value(button, sName)
    if not button then return end
    local barName = HealBot_Action_HealthBar3(button)
    if UnitExists(button.unit) and not UnitIsFriend("player",button.unit) then
        local cast=HealBot_retEnemyUnits(button.unit, "CAST") or -1
        local r, g, b, a = 1, 0.1, 0.1, 1
        if cast>-1 then
            if sName then
                HealBot_Action_SetBar3ColAlpha(barName, cast, r, g, b, a, sName)
            end
        else
            HealBot_Action_SetBar3ColAlpha(barName, 0, r, g, b, 0)
        end
    else
        local x,iconName=nil,nil
        if HealBot_pcClass[button.frame] and button.unit=="player" then
            x = UnitPower("player", HealBot_pcClass[button.frame])
            if x==1 then
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
            elseif x==2 then
                if HealBot_pcMax<4 then
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
            elseif x==3 then
                if HealBot_pcMax<4 then
                    iconName = _G[barName:GetName().."Icon"..1];
                    iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_green.tga]]);
                    iconName:SetAlpha(1)
                    iconName = _G[barName:GetName().."Icon"..2];
                    iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_green.tga]]);
                    iconName:SetAlpha(1)
                    iconName = _G[barName:GetName().."Icon"..3];
                    iconName:SetTexture([[Interface\AddOns\HealBot\Images\indicator_green.tga]]);
                    iconName:SetAlpha(1)

                elseif HealBot_pcMax<5 then
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
            elseif x==4 then
                if HealBot_pcMax<5 then
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
            elseif x==5 then
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
            else
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
        end
        if Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["POWERSIZE"]==0 then return end
        if UnitManaMax(button.unit)==0 then
            x=100
        else
            x=UnitManaMax(button.unit)
        end
        local y=floor((UnitMana(button.unit)/x)*100)
        local hcr,hcg,hcb=HealBot_Action_GetManaBarCol(button.unit)
        HealBot_Action_SetBar3ColAlpha(barName, y, hcr, hcg, hcb, HealBot_UnitBarsRange["3a"][button.unit] or Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["DISA"])
    end
end

function HealBot_Action_SetBar3ColAlpha(barName, pct, r, g, b, a, sName)
    barName:SetValue(pct);
    barName:SetStatusBarColor(r,g,b,a)
    local barText = _G[barName:GetName().."Bar3Txt"];
    barText:SetText(sName or "")
end

function HealBot_Action_GetManaBarCol(unit)
    local z=UnitPowerType(unit);
    if z==0 then
        return 0.1,0.1,1 -- Mana
    elseif z==1 then
        return 1,0.1,0.1 -- Rage
    elseif z==4 then
        return 0,1,1 -- Happy
    elseif z==6 then
        return 0.1,0.8,1 -- Rune
    end
    return 1,1,0 -- Energy
end

function HealBot_CorrectPetHealth(unit,hlth,maxhlth,hbGUID)
    if maxhlth==0 then maxhlth=hlth end
    if not hbGUID then return maxhlth end
    if not HealBot_PetMaxH[hbGUID] then
        local hbPetLevel=UnitLevel(unit)
        if hbPetLevel>80 then
            if hlth<8100 then
                HealBot_PetMaxH[hbGUID]=hbPetLevel*100
            else
                HealBot_PetMaxH[hbGUID]=hlth;
            end
        elseif hbPetLevel>70 then
            if hlth<5325 then
                HealBot_PetMaxH[hbGUID]=hbPetLevel*75
            else
                HealBot_PetMaxH[hbGUID]=hlth;
            end
        elseif hbPetLevel>60 then
            if hlth<3050 then
                HealBot_PetMaxH[hbGUID]=hbPetLevel*50
            else
                HealBot_PetMaxH[hbGUID]=hlth;
            end
        elseif hbPetLevel>40 then
            if hlth<1640 then
                HealBot_PetMaxH[hbGUID]=hbPetLevel*40
            else
                HealBot_PetMaxH[hbGUID]=hlth;
            end
        elseif hbPetLevel>20 then
            if hlth<735 then
                HealBot_PetMaxH[hbGUID]=hbPetLevel*35
            else
                HealBot_PetMaxH[hbGUID]=hlth;
            end
        elseif hbPetLevel>5 then
            if hlth<180 then
                HealBot_PetMaxH[hbGUID]=hbPetLevel*30
            else
                HealBot_PetMaxH[hbGUID]=hlth;
            end
        else
            if hlth<25 then
                HealBot_PetMaxH[hbGUID]=hbPetLevel*25
            else
                HealBot_PetMaxH[hbGUID]=hlth;
            end
        end
    elseif hlth>HealBot_PetMaxH[hbGUID] then
        HealBot_PetMaxH[hbGUID]=hlth;
    elseif HealBot_Data["UILOCK"]=="NO" then
        if not HealBot_PetMaxHcnt1[hbGUID] then
            HealBot_PetMaxHcnt1[hbGUID]=1
            HealBot_PetMaxHcnt2[hbGUID]=HealBot_PetMaxH[hbGUID];
        else
            if HealBot_PetMaxHcnt2[hbGUID]~=hlth then
                HealBot_PetMaxHcnt2[hbGUID]=hlth;
                HealBot_PetMaxHcnt1[hbGUID]=1;
            else
                HealBot_PetMaxHcnt1[hbGUID]=HealBot_PetMaxHcnt1[hbGUID]+1;
                if HealBot_PetMaxHcnt1[hbGUID]>9 then
                    HealBot_PetMaxH[hbGUID]=HealBot_PetMaxHcnt2[hbGUID];
                    HealBot_PetMaxHcnt1[hbGUID]=1;
                end
            end
        end
    end
    return HealBot_PetMaxH[hbGUID]
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
 
function HealBot_Action_EnableButton(button, isTarget)
    local ebUnit=isTarget or button.unit
    local ebubar,ebubar2,ebubar5,ebubar6,ebuicon15=nil,nil,nil,nil,nil
    local ebusr,ebusg,ebusb,ebusa=nil,nil,nil,nil
    local ebur,ebir,ebug,ebig,ebub,ebib,ebua,hbr,hbg,hbb,har,hag,hab=nil,nil,nil,nil,nil,nil,nil,nil,nil,nil
    local ebpct,ebipct,ebapct,uHlth,uMaxHlth,uName=1,0,0,nil,nil,nil,nil
    local ebufastenable,ebuProcessThis,activeUnit=nil,nil,true
    local ebuUnitDead,ebuHealBot_UnitDebuff,ebuHealBot_UnitBuff=nil,nil,nil
    local uDirArrow = false
    hbGUID=button.guid

--    if not button then return end
--    if not uName then uName=HEALBOT_WORDS_UNKNOWN end

    ebubar = HealBot_Action_HealthBar(button)
    ebubar2 = HealBot_Action_HealthBar2(button)
    ebubar5 = HealBot_Action_HealthBar5(button)
    ebubar6 = HealBot_Action_HealthBar6(button)
    ebuicon15 = _G[ebubar:GetName().."Icon15"];
    
    if UnitExists(ebUnit) and not UnitIsFriend("player",ebUnit) then
        HealBot_UnitRangeSpell[ebUnit]=HealBot_RangeSpells["HARM"]
    else
        HealBot_UnitRangeSpell[ebUnit]=HealBot_RangeSpells["HEAL"]
    end
    local unitHRange=HealBot_UnitInRange(HealBot_UnitRangeSpell[ebUnit], ebUnit)

    local uHealIn, uAbsorbs = HealBot_IncHeals_retHealsIn(ebUnit, button.frame)
    local hbExclude=false
    if HealBot_UnitData[ebUnit] and HealBot_UnitData[ebUnit]["EEXCLUDE"] then hbExclude=true end
    if UnitExists(ebUnit) and not hbExclude then
        local isFriend=UnitIsFriend("player",ebUnit)
        activeUnit = true
        uName=HealBot_GetUnitName(ebUnit, hbGUID)
        uHlth,uMaxHlth=HealBot_UnitHealth(ebUnit)

        ebuUnitDead = UnitIsDeadOrGhost(ebUnit)
        if button.debuff and button.debuff.type then
            ebuHealBot_UnitDebuff=button.debuff.type
        else
            ebuHealBot_UnitDebuff=nil
        end
        ebuHealBot_UnitBuff=button.buff
        
        if uHlth>uMaxHlth then uMaxHlth=HealBot_CorrectPetHealth(ebUnit,uHlth,uMaxHlth,hbGUID) end
    
        if ebuUnitDead then
            if UnitIsFeignDeath(ebUnit) then
                ebuUnitDead = nil
            else
                uHealIn=0
                uAbsorbs=0
                if uHlth~=0 then
                    uHlth=0
                    HealBot_Set_UnitHealth(ebUnit, uHlth, uMaxHlth, nil)
                end
                --if HealBot_Aggro[ebUnit] then
                HealBot_Action_SetUnitDebuffStatus(ebUnit)
                if HealBot_Aggro[xUnit] and (HealBot_Aggro[xUnit]=="a" or HealBot_Aggro[xUnit]=="d") then
                    HealBot_Action_UpdateAggro(ebUnit,false,nil,0)
                end
                HealBot_Aggro[ebUnit]=nil
                --end
                if button.debuff.name then  
                    HealBot_CheckAllDebuffs(ebUnit)
                    ebuHealBot_UnitDebuff=nil
                end
                ebuHealBot_UnitBuff=nil
                HealBot_HoT_RemoveIconButton(button)
                if HealBot_UnitInRange(HealBot_RangeSpells["RES"], ebUnit)==1 and not UnitIsGhost(ebUnit) then
                    ebubar:SetValue(100)
                else
                    ebubar:SetValue(0)
                end
            end
            if HealBot_Data["PGUID"]==hbGUID and not HealBot_PlayerDead then
                HealBot_Action_ResetActiveUnitStatus()
                HealBot_PlayerDead=true
            end
        elseif HealBot_Data["PGUID"]==hbGUID and HealBot_PlayerDead then
            HealBot_Action_ResetActiveUnitStatus()
            HealBot_PlayerDead=false
        end
    
        ebur,ebug,ebub,ebua,ebpct,ebusa,ebir,ebig,ebib,hbr,hbg,hbb,har,hag,hab = HealBot_HealthColor(ebUnit,uHlth,uMaxHlth,false,ebuUnitDead,ebuHealBot_UnitBuff,ebuHealBot_UnitDebuff,uHealIn,uAbsorbs,true,button,unitHRange)

        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["CLASSCOL"] then
            ebusr,ebusg,ebusb = HealBot_Action_ClassColour(ebUnit);
        elseif ebuHealBot_UnitDebuff then
            ebusr=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["CR"];
            ebusg=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["CG"];
            ebusb=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["CB"];
        else
            ebusr=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["ER"] or 1;
            ebusg=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["EG"] or 1;
            ebusb=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["EB"] or 1;
        end

        if uMaxHlth<1 then 
            uHlth=1 
        end
  
        if Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["FLUIDBARS"]==false then
            ebubar:SetValue(ebpct)
        elseif HealBot_curUnitHealth[ebubar]~=ebpct then
            HealBot_UnitBarUpdate[ebubar]=HealBot_curUnitHealth[ebubar]
            HealBot_curUnitHealth[ebubar]=ebpct
        end

        --local hBarWidth=ceil(HealBot_bWidth*(ebpct/100))
        if uHealIn>0 and HealBot_UnitStatus[ebUnit]~=0 then
            ebipct = uHlth+uHealIn
            if ebipct<uMaxHlth then
                ebipct=ebipct/uMaxHlth
            else
                ebipct=1;
            end
            ebipct=floor(ebipct*100)
            --ebubar2:SetPoint("TOPLEFT",ebubar,"TOPLEFT",hBarWidth,0);
            ebubar2:SetValue(ebipct);
        elseif ebubar2:GetValue()>0 then
            ebubar2:SetValue(0)
        end
        if uAbsorbs>0 and HealBot_UnitStatus[ebUnit]~=0 then
            ebapct = uHlth+uHealIn+uAbsorbs
            if ebapct<uMaxHlth then
                ebapct=ebapct/uMaxHlth
            else
                ebapct=1;
            end
            ebapct=floor(ebapct*100)
            ebubar6:SetValue(ebapct);
        elseif ebubar6:GetValue()>0 then
            ebubar6:SetValue(0)
        end    

        ebuProcessThis=true
        ebufastenable=false
        if HealBot_Globals.ProtectPvP and isFriend then
            if UnitIsPVP(ebUnit) and not UnitIsPVP("player") then 
                ebuProcessThis=false
            end
        end
        if not ebuUnitDead and not HealBot_PlayerDead and ebuProcessThis then
            if not UnitIsFriend("player",ebUnit) then
                if unitHRange==1 then
                    ebufastenable=true
                end
            else
                if ebuHealBot_UnitDebuff then
                    HealBot_UnitRangeSpell[ebUnit]=HealBot_RangeSpells["CURE"]
                    if HealBot_UnitInRange(HealBot_RangeSpells["CURE"], ebUnit)==1 then 
                        ebufastenable=true 
                    else
                        uDirArrow=true
                    end
                elseif ebuHealBot_UnitBuff then
                    HealBot_UnitRangeSpell[ebUnit]=HealBot_RangeSpells["BUFF"]
                    if HealBot_UnitInRange(HealBot_RangeSpells["BUFF"], ebUnit)==1 then 
                        ebufastenable=true 
                    else
                        uDirArrow=true
                    end
                elseif (HealBot_Data["UILOCK"]=="YES" and uHlth<=uMaxHlth*Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["ALERTIC"]) or
                   (HealBot_Data["UILOCK"]~="YES" and uHlth<=uMaxHlth*Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["ALERTOC"]) then
                    if unitHRange==1 then
                        ebufastenable=true
                    else
                        uDirArrow=true
                    end
                elseif (HealBot_Aggro[ebUnit] and (HealBot_UnitThreat[ebUnit] or 0)>Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["ALERT"]) or HealBot_MyTargets[hbGUID] then
                    if unitHRange==1 then
                        ebufastenable=true
                    else
                        uDirArrow=true
                    end
                end
            end
        end
        if ebufastenable then
            ebusa = Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["EA"];
            HealBot_Enabled[ebUnit]="e"
            ebubar:SetStatusBarColor(ebur,ebug,ebub,Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"]);
            HealBot_UnitBarsRange["3a"][ebUnit]=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"]
            if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["CLASSONBAR"] and Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["CLASSTYPE"]==1 and not HealBot_retdebuffTargetIcon(ebUnit) then
                ebuicon15:SetAlpha(Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"]);
            end
            HealBot_UnitTextRange["ir"][ebUnit]=ebusr
            HealBot_UnitTextRange["ig"][ebUnit]=ebusg
            HealBot_UnitTextRange["ib"][ebUnit]=ebusb
            HealBot_UnitTextRange["or"][ebUnit]=ebusr
            HealBot_UnitTextRange["og"][ebUnit]=ebusg
            HealBot_UnitTextRange["ob"][ebUnit]=ebusb
            if HealBot_Data["TIPUSE"]=="YES" and HealBot_Data["TIPUNIT"] and ebUnit==HealBot_Data["TIPUNIT"] then
                if not isFriend then
                    HealBot_Data["TIPTYPE"] = "Enemy"
                else
                    HealBot_Data["TIPTYPE"] = "Enabled"
                end
                HealBot_Action_RefreshTooltip()
            end
            if Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][button.frame]["AUTOCLOSE"] then HealBot_Action_ShowPanel(button.frame) end
            if HealBot_UnitDirection[ebUnit] then
                HealBot_Action_HideDirectionArrow(button, ebUnit)
            end
        else
            HealBot_Enabled[ebUnit]="d"
            if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["CLASSCOL"]==false then
                ebusr=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["DR"]
                ebusg=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["DG"]
                ebusb=Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["DB"]
            end
            if HealBot_UnitHasRes[ebUnit] and HealBot_UnitHasRes[ebUnit]<GetTime() then
                HealBot_UnitHasRes[ebUnit]=nil
            end
            if ebuUnitDead and (UnitHasIncomingResurrection(ebUnit) or HealBot_UnitHasRes[ebUnit]) then
                ebusr=0.2
                ebusg=1.0
                ebusb=0.2
                ebusa=1
                HealBot_UnitTextRange["ir"][ebUnit]=0.2
                HealBot_UnitTextRange["ig"][ebUnit]=1
                HealBot_UnitTextRange["ib"][ebUnit]=0.2
                HealBot_UnitTextRange["or"][ebUnit]=0.2
                HealBot_UnitTextRange["og"][ebUnit]=1
                HealBot_UnitTextRange["ob"][ebUnit]=0.2
                HealBot_UnitStatus[ebUnit]=9
            elseif ebuUnitDead and hbGUID~=HealBot_Data["PGUID"] and isFriend then
                if HealBot_RangeSpells["RES"] then
                    HealBot_UnitRangeSpell[ebUnit]=HealBot_RangeSpells["RES"]
                    if HealBot_UnitInRange(HealBot_RangeSpells["RES"], ebUnit)==1 and not UnitIsGhost(ebUnit) then
                        ebusr=1;
                        ebusg=0.2;
                        ebusb=0.2;
                        ebusa=1;
                    else
                        ebusr=0.8;
                        ebusg=0;
                        ebusb=0;
                        ebusa=1;
                    end
                    if not UnitIsGhost(ebUnit) then
                        HealBot_UnitTextRange["ir"][ebUnit]=1
                        HealBot_UnitTextRange["ig"][ebUnit]=0.2
                        HealBot_UnitTextRange["ib"][ebUnit]=0.2
                    else
                        HealBot_UnitTextRange["ir"][ebUnit]=0.8
                        HealBot_UnitTextRange["ig"][ebUnit]=0
                        HealBot_UnitTextRange["ib"][ebUnit]=0
                    end
                    HealBot_UnitTextRange["or"][ebUnit]=0.8
                    HealBot_UnitTextRange["og"][ebUnit]=0
                    HealBot_UnitTextRange["ob"][ebUnit]=0
                end
                if not IsInInstance() and Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWDIR"] and hbGUID~=HealBot_Data["PGUID"] and UnitIsVisible(ebUnit) then
                    HealBot_Action_ShowDirectionArrow(button, ebUnit)
                end
            else
                if not IsInInstance() and uDirArrow and Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWDIR"] and hbGUID~=HealBot_Data["PGUID"] then
                    HealBot_Action_ShowDirectionArrow(button, ebUnit)
                elseif HealBot_UnitDirection[ebUnit] then
                    HealBot_Action_HideDirectionArrow(button, ebUnit)
                end
                HealBot_UnitTextRange["ir"][ebUnit]=ebusr
                HealBot_UnitTextRange["ig"][ebUnit]=ebusg
                HealBot_UnitTextRange["ib"][ebUnit]=ebusb
                HealBot_UnitTextRange["or"][ebUnit]=ebusr
                HealBot_UnitTextRange["og"][ebUnit]=ebusg
                HealBot_UnitTextRange["ob"][ebUnit]=ebusb
                --ebua=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["DISA"]
            end
            if UnitIsVisible(ebUnit) then
                ebubar:SetStatusBarColor(ebur,ebug,ebub,ebua);
                if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["CLASSONBAR"] and Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["CLASSTYPE"]==1 then
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["I15EN"]==false then
                        ebuicon15:SetAlpha(ebua);
                    else
                        ebuicon15:SetAlpha(Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"])
                    end
                end
            else
                ebubar:SetStatusBarColor(ebur,ebug,ebub,Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["DISA"]);
                if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["CLASSONBAR"] and Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["CLASSTYPE"]==1 then
                    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["I15EN"]==false then
                        ebuicon15:SetAlpha(Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["DISA"]);
                    else
                        ebuicon15:SetAlpha(Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"])
                    end
                end
            end
            if HealBot_Data["UILOCK"]=="NO" and HealBot_Config.EnableHealthy==false then
                if HealBot_Data["TIPUSE"]=="YES" and HealBot_Data["TIPUNIT"] and ebUnit==HealBot_Data["TIPUNIT"] then
                    if not isFriend then
                        HealBot_Data["TIPTYPE"] = "Enemy"
                    else
                        HealBot_Data["TIPTYPE"] = "Disabled"
                    end
                    HealBot_Action_RefreshTooltip()
                end
            end
            HealBot_UnitBarsRange["3a"][ebUnit]=ebua
        end
        HealBot_UnitBarsRange["r"][ebUnit]=ebur
        HealBot_UnitBarsRange["g"][ebUnit]=ebug
        HealBot_UnitBarsRange["b"][ebUnit]=ebub
        HealBot_UnitBarsRange["a"][ebUnit]=ebua
        HealBot_UnitTextRange["oa"][ebUnit]=ebusa
    else
        uHlth,uMaxHlth=1,1
        uHealIn = 0
        uAbsorbs = 0
        ebusr,ebusg,ebusb=0.7,0.7,0.7
        ebubar:SetStatusBarColor(0,1,0,0)
        ebubar2:SetStatusBarColor(0,0,0,0);
        ebubar5:SetStatusBarColor(0,0,0,0);
        ebubar6:SetStatusBarColor(0,0,0,0);
        HealBot_UnitBarsRange["r"][ebUnit]=0
        HealBot_UnitBarsRange["g"][ebUnit]=1
        HealBot_UnitBarsRange["b"][ebUnit]=0
        HealBot_UnitBarsRange["a"][ebUnit]=ebua or 0.1
        HealBot_UnitBarsRange["3a"][ebUnit]=ebua or 0.1
        HealBot_UnitTextRange["oa"][ebUnit]=ebusa or 0.01
        activeUnit = false
        HealBot_HoT_RemoveIconButton(button)
        if hbGUID==ebUnit then
            uName=HEALBOT_WORD_RESERVED..":"..ebUnit
            HealBot_Reserved[ebUnit]=true
        else
            uName=HEALBOT_WORDS_UNKNOWN
            if HealBot_Data["REFRESH"]<1 then HealBot_Data["REFRESH"]=1 end
            HealBot_UnitStatus[ebUnit]=7
        end
    end
    
    ebubar5:SetStatusBarColor(hbr,hbg,hbb,Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["BA"]);
    if uHealIn>0 then
        if unitHRange==1 and not HealBot_PlayerDead then
            ebubar2:SetStatusBarColor(ebir,ebig,ebib,Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IA"]);
        elseif unitHRange==0 then
            ebubar2:SetStatusBarColor(ebir,ebig,ebib,HealBot_UnitBarsRange["a"][ebUnit]);
        else
            ebubar2:SetStatusBarColor(ebir,ebig,ebib,Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["DISA"]);
        end
        --if unitHRange~=1 and UnitIsVisible(ebUnit) then HealBot_AddDebug("unitHRange="..unitHRange.." for visible unit "..ebUnit) end
        HealBot_UnitBarsRange["hr"][ebUnit]=ebir
        HealBot_UnitBarsRange["hg"][ebUnit]=ebig
        HealBot_UnitBarsRange["hb"][ebUnit]=ebib
    else
        ebubar2:SetStatusBarColor(ebur,ebug,ebub,0);
    end
    if uAbsorbs>0 then
        if unitHRange==1 and not HealBot_PlayerDead then
            ebubar6:SetStatusBarColor(har,hag,hab,Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AA"]);
        elseif unitHRange==0 then
            ebubar6:SetStatusBarColor(har,hag,hab,HealBot_UnitBarsRange["a"][ebUnit]);
        else
            ebubar6:SetStatusBarColor(har,hag,hab,Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["DISA"]);
        end
        HealBot_UnitBarsRange["sr"][ebUnit]=har
        HealBot_UnitBarsRange["sg"][ebUnit]=hag
        HealBot_UnitBarsRange["sb"][ebUnit]=hab
    else
        ebubar6:SetStatusBarColor(ebur,ebug,ebub,0);
    end

    local ebtext=uName
    if activeUnit then
        local hbFontAdj=hbFontVal[Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["FONT"]] or 2
        local bttextlen = floor((hbFontAdj*2)+HealBot_Globals.tsadjmod+((Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["WIDTH"]*1.88)
                                /(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HEIGHT"])
                                -(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HEIGHT"]/hbFontAdj)))
        ebtext=HealBot_Action_HBText(uHlth,uMaxHlth,uName,ebUnit,uHealIn, uAbsorbs, hbGUID, bttextlen, button.frame)
    end
    ebubar.txt = _G[ebubar:GetName().."_text"];
    ebubar.txt:SetText(ebtext);
    if activeUnit and UnitIsVisible(ebUnit) then
        ebubar.txt:SetTextColor(ebusr,ebusg,ebusb,ebusa);
    else
        ebubar.txt:SetTextColor(ebusr,ebusg,ebusb,Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["DA"]);
    end
    if Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["POWERSIZE"]>0 then 
        HealBot_Action_SetBar3Value(button);
    end
    HealBot_UnitRange[ebUnit]=HealBot_UnitInRange(HealBot_UnitRangeSpell[ebUnit], ebUnit)
end

function HealBot_Action_ShowDirectionArrow(button, unit)
    if (Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWDIRMOUSE"]==false or unit==HealBot_Data["TIPUNIT"]) then
        local hbX, hbY, hbD = HealBot_Direction_Check(unit)
        if hbD then
            if not HealBot_UnitDirection[unit] then 
                HealBot_UnitDirection[unit]=-999 
                local barDir = HealBot_Action_HealthBarDir(button)
                local ebuicon17 = _G[barDir:GetName().."Icon17"];
                if HealBot_Data["SHOWDIR"]~="DIRECTION" then
                    HealBot_Data["SHOWDIR"]="DIRECTION"
                    ebuicon17:SetTexture("Interface\\AddOns\\HealBot\\Images\\arrow.blp")
                end
                ebuicon17:SetTexCoord(hbX, hbX + 0.109375, hbY, hbY + 0.08203125)
                ebuicon17:Show()
            elseif HealBot_UnitDirection[unit]~=hbD then
                local barDir = HealBot_Action_HealthBarDir(button)
                local ebuicon17 = _G[barDir:GetName().."Icon17"];
                ebuicon17:SetTexCoord(hbX, hbX + 0.109375, hbY, hbY + 0.08203125)
                HealBot_UnitDirection[unit]=hbD
            end
        elseif HealBot_UnitDirection[unit] then
            HealBot_Action_HideDirectionArrow(button, unit)
        end
    elseif HealBot_UnitDirection[unit] then
        HealBot_Action_HideDirectionArrow(button, unit)
    end
end

function HealBot_Action_HideDirectionArrow(button, unit)
    HealBot_UnitDirection[unit]=nil
    local barDir = HealBot_Action_HealthBarDir(button)
    local ebuicon17 = _G[barDir:GetName().."Icon17"];
    ebuicon17:Hide()
end

local hbNumFormatPlaces={[1]=-1,[2]=-1,[3]=-1,[4]=-1,[5]=-1,[6]=-1,[7]=-1,[8]=-1,[9]=-1,[10]=-1}
local hbNumFormatSurL={[1]="(",[2]="(",[3]="(",[4]="(",[5]="(",[6]="(",[7]="(",[8]="(",[9]="(",[10]="("}
local hbNumFormatSurR={[1]=")",[2]=")",[3]=")",[4]=")",[5]=")",[6]=")",[7]=")",[8]=")",[9]=")",[10]=")"}
local hbNumFormatSuffix={[1]=1,[2]=1,[3]=1,[4]=1,[5]=1,[6]=1,[7]=1,[8]=1,[9]=1,[10]=1}
function HealBot_Action_sethbNumberFormat()
    for j=1,10 do
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT1"]==2 or Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT1"]==5 or Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT1"]==8 then
            hbNumFormatPlaces[j]=0
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT1"]==3 or Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT1"]==6 or Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT1"]==9 then
            hbNumFormatPlaces[j]=1
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT1"]==4 or Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT1"]==7 or Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT1"]==10 then
            hbNumFormatPlaces[j]=2
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT1"]==11 then
            hbNumFormatPlaces[j]=3
        else
            hbNumFormatPlaces[j]=-1
        end
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT1"]>1 and Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT1"]<5 then
            hbNumFormatSuffix[j]=1
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT1"]>4 and Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT1"]<8 then
            hbNumFormatSuffix[j]=2
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT1"]==11 then
            hbNumFormatSuffix[j]=1
        else
            hbNumFormatSuffix[j]=0
        end
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT2"]==2 then
            hbNumFormatSurL[j]="("
            hbNumFormatSurR[j]=")"
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT2"]==3 then
            hbNumFormatSurL[j]="["
            hbNumFormatSurR[j]="]"
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT2"]==4 then
            hbNumFormatSurL[j]="{"
            hbNumFormatSurR[j]="}"
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT2"]==5 then
            hbNumFormatSurL[j]="<"
            hbNumFormatSurR[j]=">"
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT2"]==6 then
            hbNumFormatSurL[j]="~"
            hbNumFormatSurR[j]=""
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT2"]==7 then
            hbNumFormatSurL[j]=":"
            hbNumFormatSurR[j]=":"
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["NUMFORMAT2"]==8 then
            hbNumFormatSurL[j]="*"
            hbNumFormatSurR[j]="*"
        else
            hbNumFormatSurL[j]=""
            hbNumFormatSurR[j]=""
        end
        if hbNumFormatPlaces[j]==-1 then
            hbNumFormatSuffix[j]=0
        end
    end
end

local hbNumFormatSurLa="["
local hbNumFormatSurRa="]"
function HealBot_Action_sethbAggroNumberFormat()
    if Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["TEXTFORMAT"]==2 then
        hbNumFormatSurLa="("
        hbNumFormatSurRa=")"
    elseif Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["TEXTFORMAT"]==3 then
        hbNumFormatSurLa="["
        hbNumFormatSurRa="]"
    elseif Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["TEXTFORMAT"]==4 then
        hbNumFormatSurLa="{"
        hbNumFormatSurRa="}"
    elseif Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["TEXTFORMAT"]==5 then
        hbNumFormatSurLa="<"
        hbNumFormatSurRa=">"
    elseif Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["TEXTFORMAT"]==6 then
        hbNumFormatSurLa="~"
        hbNumFormatSurRa=""
    elseif Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["TEXTFORMAT"]==7 then
        hbNumFormatSurLa=":"
        hbNumFormatSurRa=":"
    elseif Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["TEXTFORMAT"]==8 then
        hbNumFormatSurLa="*"
        hbNumFormatSurRa="*"
    else
        hbNumFormatSurLa=""
        hbNumFormatSurRa=""
    end
end

function HealBot_Action_HBText(hlth,maxhlth,unitName,unit,healin, absorbin, hbGUID, bttextlen, hbCurFrame)
    local btHBbarText,uName,bthlthdelta=" ",unitName,0
    local hbHealInTxt=Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][hbCurFrame]["INCHEALS"]
    local healInTxt=healin
    if hbHealInTxt>3 then
        healInTxt=healin+absorbin
        if hbHealInTxt==4 then hbHealInTxt=2 end
        if hbHealInTxt==5 then hbHealInTxt=3 end
    end
    
    
    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][hbCurFrame]["CLASSONBAR"] and Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][hbCurFrame]["CLASSTYPE"]==2 and UnitClass(unit) then
        local clTxt=UnitClass(unit)
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][hbCurFrame]["SHOWROLE"] then
            local hbRole=UnitGroupRolesAssigned(unit)
            if hbRole=="NONE" and HealBot_UnitData[hbGUID] then
                hbRole=HealBot_UnitData[hbGUID]["ROLE"]
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
                clTxt=UnitClass(unit)
            end
        end
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][hbCurFrame]["NAMEONBAR"] then
            uName=clTxt..":"..unitName;
        else
            uName=clTxt;
        end
    elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][hbCurFrame]["NAMEONBAR"] then
        uName=unitName;
    else
        uName=" "
    end
    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][hbCurFrame]["HLTHONBAR"] and maxhlth then
        local numSuffix=""
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][hbCurFrame]["HLTHTYPE"]==1 then
            if hbHealInTxt==2 then
                bthlthdelta=hlth+healInTxt
                if bthlthdelta>maxhlth then bthlthdelta=maxhlth end
            else
                bthlthdelta=hlth;
            end
            if bthlthdelta>-2 and bthlthdelta<2 then bthlthdelta=0 end
            if hbNumFormatPlaces[hbCurFrame]>-1 then 
                if hbNumFormatPlaces[hbCurFrame]<3 then 
                    if bthlthdelta>999999 then
                        bthlthdelta=HealBot_Comm_round(bthlthdelta/1000000,hbNumFormatPlaces[hbCurFrame]) 
                        if hbNumFormatSuffix[hbCurFrame]==1 then
                            numSuffix="M"
                        elseif hbNumFormatSuffix[hbCurFrame]==2 then
                            numSuffix="m"
                        end
                    elseif bthlthdelta>9999 then
                        bthlthdelta=HealBot_Comm_round(bthlthdelta/1000,hbNumFormatPlaces[hbCurFrame]) 
                        if hbNumFormatSuffix[hbCurFrame]==1 then
                            numSuffix="K"
                        elseif hbNumFormatSuffix[hbCurFrame]==2 then
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
                        if hbNumFormatSuffix[hbCurFrame]==1 then
                            numSuffix="M"
                        elseif hbNumFormatSuffix[hbCurFrame]==2 then
                            numSuffix="m"
                        end
                    elseif bthlthdelta>9999 then
                        if bthlthdelta>99999 then
                            bthlthdelta=HealBot_Comm_round(bthlthdelta/1000,0) 
                        else
                            bthlthdelta=HealBot_Comm_round(bthlthdelta/1000,1)   
                        end
                        if hbNumFormatSuffix[hbCurFrame]==1 then
                            numSuffix="K"
                        elseif hbNumFormatSuffix[hbCurFrame]==2 then
                            numSuffix="k"
                        end
                    end
                end
            end
            btHBbarText=btHBbarText..hbNumFormatSurL[hbCurFrame]..bthlthdelta..numSuffix..hbNumFormatSurR[hbCurFrame]
            if healInTxt>0 and hbHealInTxt==3 then
                numSuffix=""
                if hbNumFormatPlaces[hbCurFrame]>-1 and healInTxt>999 then
                    healInTxt, numSuffix=HealBot_Action_shortenHealIn(healInTxt, numSuffix, hbCurFrame)
                end
                btHBbarText=btHBbarText.." +"..healInTxt..numSuffix
            end
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][hbCurFrame]["HLTHTYPE"]==2 then
            if hbHealInTxt==2 then
                bthlthdelta=(hlth+healInTxt)-maxhlth;
            else
                bthlthdelta=hlth-maxhlth;
            end
            if hbNumFormatPlaces[hbCurFrame]>-1 then 
                if hbNumFormatPlaces[hbCurFrame]<3 then 
                    if bthlthdelta<-999999 then
                        bthlthdelta=HealBot_Comm_round(bthlthdelta/1000000,hbNumFormatPlaces[hbCurFrame]) 
                        if hbNumFormatSuffix[hbCurFrame]==1 then
                            numSuffix="M"
                        elseif hbNumFormatSuffix[hbCurFrame]==2 then
                            numSuffix="m"
                        end
                    elseif bthlthdelta<-9999 then
                        bthlthdelta=HealBot_Comm_round(bthlthdelta/1000,hbNumFormatPlaces[hbCurFrame]) 
                        if hbNumFormatSuffix[hbCurFrame]==1 then
                            numSuffix="K"
                        elseif hbNumFormatSuffix[hbCurFrame]==2 then
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
                        if hbNumFormatSuffix[hbCurFrame]==1 then
                            numSuffix="M"
                        elseif hbNumFormatSuffix[hbCurFrame]==2 then
                            numSuffix="m"
                        end
                    elseif bthlthdelta<-9999 then
                        if bthlthdelta<-99999 then
                            bthlthdelta=HealBot_Comm_round(bthlthdelta/1000,0) 
                        else
                            bthlthdelta=HealBot_Comm_round(bthlthdelta/1000,1)   
                        end
                        if hbNumFormatSuffix[hbCurFrame]==1 then
                            numSuffix="K"
                        elseif hbNumFormatSuffix[hbCurFrame]==2 then
                            numSuffix="k"
                        end
                    end
                end
            end
            if bthlthdelta>0 then
                btHBbarText=btHBbarText.." "..hbNumFormatSurL[hbCurFrame].."+"..bthlthdelta..numSuffix..hbNumFormatSurR[hbCurFrame]
            else
                btHBbarText=btHBbarText..hbNumFormatSurL[hbCurFrame]..bthlthdelta..numSuffix..hbNumFormatSurR[hbCurFrame]
            end
            if hbHealInTxt==3 and healInTxt>0 then
                numSuffix=""
                if hbNumFormatPlaces[hbCurFrame]>-1  and healInTxt>999 then 
                    healInTxt, numSuffix=HealBot_Action_shortenHealIn(healInTxt, numSuffix, hbCurFrame)
                end
                btHBbarText=btHBbarText.." +"..healInTxt..numSuffix
            end
        else
            if hbHealInTxt==2 then
                btHBbarText=btHBbarText..hbNumFormatSurL[hbCurFrame]..floor(((hlth+healInTxt)/maxhlth)*100).."%"..hbNumFormatSurR[hbCurFrame]
            else
                btHBbarText=btHBbarText..hbNumFormatSurL[hbCurFrame]..floor((hlth/maxhlth)*100).."%"..hbNumFormatSurR[hbCurFrame]
            end
            if hbHealInTxt==3 and healInTxt>0 then
                btHBbarText=btHBbarText.." +"..floor((healInTxt/maxhlth)*100).."%"
            end
        end
    end
    
    if HealBot_Action_UnitIsOffline(hbGUID) then
        uName=HEALBOT_DISCONNECTED_TEXT.." "..uName;
    end    -- added by Diacono of Ursin
    if Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["SHOWTEXT"] and HealBot_Aggro[unit] and HealBot_Aggro[unit]=="a" and 
       (HealBot_UnitThreat[unit] or 0)>Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["ALERT"] and uName then
        uName=">> "..uName.." <<"
        --uName=">"..HealBot_UnitThreat[unit].."> "..uName.." <"..HealBot_UnitThreat[unit].."<"
    end
    local vUnit=HealBot_retIsInVehicle(unit)
    if vUnit then
        local x,y=HealBot_VehicleHealth(vUnit)
        local hpPerc = floor((x/y)*100)
        if hpPerc < 1 then 
            hpPerc = 1
        end
        bthlthdelta="  "..hpPerc --string.format("|cff%s%d%%|r", HealBot_PercentToHexColor(hpPerc), hpPerc)
        if bttextlen>9 then 
            y=bttextlen-7
        else
            y=3
        end
        if UnitExists(vUnit) and hbstringLen(HealBot_GetUnitName(vUnit))>y then
            bthlthdelta = hbstringSub(HealBot_GetUnitName(vUnit),1,y).. '..'..bthlthdelta
        elseif UnitExists(vUnit) then
            bthlthdelta = UnitName(vUnit)..bthlthdelta
        else
            HealBot_CheckAllUnitVehicle(unit)
            if HealBot_retIsInVehicle(unit) then
                bthlthdelta = HEALBOT_VEHICLE..bthlthdelta
            end
        end
    end
    if Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["SHOWTEXTPCT"] and HealBot_UnitThreatPct[unit] and HealBot_UnitThreatPct[unit]>0 then 
        btHBbarText=btHBbarText.."  "..hbNumFormatSurLa..HealBot_UnitThreatPct[unit].."%"..hbNumFormatSurRa
    end
    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][hbCurFrame]["DOUBLE"]==false then
        bttextlen=bttextlen-hbstringLen(btHBbarText)
        if bttextlen<1 then 
            bttextlen=1
        end
        if uName and hbstringLen(uName)>bttextlen then
            btHBbarText = hbstringSub(uName,1,bttextlen) .. '.'..btHBbarText;
        elseif uName then
            btHBbarText = uName..btHBbarText;
        end
        if vUnit then
            btHBbarText = btHBbarText.."\n".." "..bthlthdelta
        end
    else
        if bttextlen<1 then 
            bttextlen=1
        end
        if uName and hbstringLen(uName)>bttextlen then
            btHBbarText = hbstringSub(uName,1,bttextlen) .. '.'.."\n"..btHBbarText;
        elseif uName then
            btHBbarText = uName.."\n"..btHBbarText;
        end
        if vUnit then
            btHBbarText = btHBbarText.." "..bthlthdelta
        end
    end
    return btHBbarText;
end

function HealBot_Action_shortenHealIn(healin, numSuffix, hbCurFrame)
    local isK=true
    if hbNumFormatPlaces[hbCurFrame]<3 then 
        if healin>999999 then
            healin=HealBot_Comm_round(healin/1000000,hbNumFormatPlaces[hbCurFrame]) 
            isK=false
        else
            healin=HealBot_Comm_round(healin/1000,hbNumFormatPlaces[hbCurFrame]) 
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
        if hbNumFormatSuffix[hbCurFrame]==1 then
            numSuffix="K"
        elseif hbNumFormatSuffix[hbCurFrame]==2 then
            numSuffix="k"
        end
    else
        if hbNumFormatSuffix[hbCurFrame]==1 then
            numSuffix="M"
        elseif hbNumFormatSuffix[hbCurFrame]==2 then
            numSuffix="m"
        end
    end
    return healin, numSuffix
end

function HealBot_PercentToHexColor(percent)
    local percent = percent/100
    local r,g,b = 0,1,0
    if percent <= 0 then
        r,g,b = 1,0,0
    elseif percent <= 0.5 then
        r,g,b = 1,percent*2,0
    end 
    return string.format("%02x%02x%02x",r*255,g*255,b*255)
end

function HealBot_Action_UnitIsOffline(hbGUID,preset) -- added by Diacono of Ursin
    local x = nil;
    if not HealBot_UnitData[hbGUID] or not UnitExists(HealBot_UnitData[hbGUID]["UNIT"]) then 
        if HealBot_UnitOffline[hbGUID] then HealBot_UnitOffline[hbGUID]=nil end
        return 
    end
    if preset then
        HealBot_UnitOffline[hbGUID]=preset
    else
        if HealBot_UnitOffline[hbGUID] then
            if time() - HealBot_UnitOffline[hbGUID] <= 2 then
                x = true;
            end
        end
        if not UnitIsConnected(HealBot_UnitData[hbGUID]["UNIT"]) or x then
            if not HealBot_UnitOffline[hbGUID] then
                HealBot_UnitOffline[hbGUID] = time();
            elseif HealBot_UnitOffline[hbGUID] == -1 then
                HealBot_UnitOffline[hbGUID] = nil;
            end
        else
            HealBot_UnitOffline[hbGUID] = nil;
        end
        return HealBot_UnitOffline[hbGUID]
    end
end

function HealBot_Action_retUnitOffline(hbGUID)
    return HealBot_UnitOffline[hbGUID]
end

function HealBot_Action_RefreshButton(button)
    if not button then return end
--  if type(button)~="table" then DEFAULT_CHAT_FRAME:AddMessage("***** "..type(button)) end
    HealBot_Action_EnableButton(button)
    if UnitExists("target") and HealBot_Unit_Button["target"] and button.unit~="target" and HealBot_UnitGUID("target")==button.guid then
        HealBot_Action_EnableButton(HealBot_Unit_Button["target"], "target")
    end
end

local HealBot_resetSkinTo=""
local HealBot_initSkin={[0]={},[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
function HealBot_Action_ResetSkin(barType,button,numcols)
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
    local b,bar,bar2,bar3,bar4,icon,txt,icon1,icon15,icon16,icon17,icon1t,icon15t,icon1ta,icon15ta,pIcon,icont,iconta=nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil
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
        bar = HealBot_Action_HealthBar(b);
        bar2 = HealBot_Action_HealthBar2(b);
        bar3 = HealBot_Action_HealthBar3(b);
        bar4 = HealBot_Action_HealthBar4(b)
        bar5 = HealBot_Action_HealthBar5(b)
        bar6 = HealBot_Action_HealthBar6(b)
        barDir = HealBot_Action_HealthBarDir(b);
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
        bar5:SetFrameLevel(b:GetFrameLevel()+ 1);
        bar4:SetFrameLevel(bar5:GetFrameLevel()+ 1);
        bar6:SetFrameLevel(bar4:GetFrameLevel()+ 1);
        bar2:SetFrameLevel(bar6:GetFrameLevel()+ 1);
        bar:SetFrameLevel(bar2:GetFrameLevel()+ 1);
		bar3:SetFrameLevel(bar:GetFrameLevel()+ 1);
        barDir:SetFrameLevel(bar3:GetFrameLevel()+ 1);
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
        if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
            iScale=floor(((bheight*Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["SCALE"])-2)*0.485)
        end
        itScale=ceil(iScale*Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][b.frame]["SCALE"])
        for x=2,14 do
            icon=_G[bar:GetName().."Icon"..x];
            icont=_G[bar:GetName().."Count"..x];
            iconta=_G[bar:GetName().."Count"..x.."a"];
            icon:SetHeight(iScale);
            icon:SetWidth(iScale);
            icont:SetTextHeight(itScale)
            iconta:SetTextHeight(itScale)
        end
        icon1 = _G[bar:GetName().."Icon1"];
        icon1t = _G[bar:GetName().."Count1"];
        icon1ta = _G[bar:GetName().."Count1a"];
        icon15 = _G[bar:GetName().."Icon15"];
        icon16 = _G[bar:GetName().."Icon16"];
        icon15t = _G[bar:GetName().."Count15"]; 
        icon15ta = _G[bar:GetName().."Count15a"];   
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
        if HealBot_pcMax==3 then
            pIcon = _G[bar3:GetName().."Icon1"];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","-9","0");
            pIcon = _G[bar3:GetName().."Icon2"];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","0","0");
            pIcon = _G[bar3:GetName().."Icon3"];
            pIcon:SetPoint("BOTTOM",bar3,"BOTTOM","9","0");
        elseif HealBot_pcMax==4 then
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
        icon1:SetHeight(iScale);
        icon1:SetWidth(iScale);
        icon1t:SetTextHeight(itScale)
        icon1ta:SetTextHeight(itScale)        
        icon15:SetHeight(iScale);
        icon15:SetWidth(iScale);
        icon15t:SetTextHeight(itScale)
        icon15ta:SetTextHeight(itScale)
        icon16:SetHeight(iScale);
        icon16:SetWidth(iScale);
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
            if not HealBot_curUnitHealth[bar] then
                local uHlth,uMaxHlth=HealBot_UnitHealth(b.unit)
                local hcpct=100
                if uHlth>uMaxHlth then uMaxHlth=HealBot_CorrectPetHealth(b.unit,uHlth,uMaxHlth,b.guid) end
                if uHlth<uMaxHlth then
                    hcpct=floor(uHlth/uMaxHlth)*100
                end
                HealBot_curUnitHealth[bar]=hcpct
            end
            bar:SetValue(HealBot_curUnitHealth[bar])
            HealBot_Panel_SetBarArrays(b.id)
            bar2:SetValue(0);
            bar5:SetValue(100);
            bar6:SetValue(0);
            bar2:SetStatusBarColor(0,1,0,0);
            if b.guid then HealBot_Action_RefreshButton(b) end
        end
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["CLASSONBAR"]==false or Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["CLASSTYPE"]==0 then
            icon15:SetAlpha(0);
        end
        barDir:ClearAllPoints();
        barDir:SetPoint("TOP",b,"TOP",-1,0);
        if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["ONBAR"]==1 then
            HealBot_Panel_SetMultiColHoToffset(0)
            HealBot_Panel_SetMultiRowHoToffset(0)
            if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["POSITION"]==1 then
                icon1:ClearAllPoints();
                icon1:SetPoint("BOTTOMLEFT",b,"BOTTOMLEFT",1,0);
                icon1t:ClearAllPoints();
                icon1t:SetPoint("BOTTOMLEFT",icon1,"BOTTOMLEFT",-1,0);
                icon1ta:ClearAllPoints();
                icon1ta:SetPoint("TOPRIGHT",icon1,"TOPRIGHT",5,0);
                for x=2,14 do
                    icon=_G[bar:GetName().."Icon"..x];
                    icont=_G[bar:GetName().."Count"..x];
                    iconta=_G[bar:GetName().."Count"..x.."a"];
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
                    icont:ClearAllPoints();
                    icont:SetPoint("BOTTOMLEFT",icon,"BOTTOMLEFT",-1,0);
                    iconta:ClearAllPoints();
                    iconta:SetPoint("TOPRIGHT",icon,"TOPRIGHT",5,0);
                end
                icon15:ClearAllPoints();
                icon15:SetPoint("BOTTOMRIGHT",b,"BOTTOMRIGHT",-1,0);
                icon16:ClearAllPoints();
                if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                    icon16:SetPoint("BOTTOMRIGHT",icon15,"TOPRIGHT",0,1);
                else
                    icon16:SetPoint("BOTTOMRIGHT",icon15,"BOTTOMLEFT",-1,0);
                end
                icon15t:ClearAllPoints();
                icon15t:SetPoint("BOTTOMLEFT",icon15,"BOTTOMLEFT",-1,0); 
                icon15ta:ClearAllPoints();
                icon15ta:SetPoint("TOPRIGHT",icon15,"TOPRIGHT",5,0);
            else
                icon1:ClearAllPoints();
                icon1:SetPoint("BOTTOMRIGHT",b,"BOTTOMRIGHT",-1,0);
                icon1t:ClearAllPoints();
                icon1t:SetPoint("BOTTOMRIGHT",icon1,"BOTTOMRIGHT",5,0);
                icon1ta:ClearAllPoints();
                icon1ta:SetPoint("TOPLEFT",icon1,"TOPLEFT",-1,0);
                for x=2,14 do
                    icon=_G[bar:GetName().."Icon"..x];
                    icont=_G[bar:GetName().."Count"..x];
                    iconta=_G[bar:GetName().."Count"..x.."a"];
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
                    icont:ClearAllPoints();
                    icont:SetPoint("BOTTOMRIGHT",icon,"BOTTOMRIGHT",5,0);
                    iconta:ClearAllPoints();
                    iconta:SetPoint("TOPLEFT",icon,"TOPLEFT",-1,0);
                end
                icon15:ClearAllPoints();
                icon15:SetPoint("BOTTOMLEFT",b,"BOTTOMLEFT",1,0);
                icon16:ClearAllPoints();
                if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                    icon16:SetPoint("BOTTOMLEFT",icon15,"TOPLEFT",0,1);
                else
                    icon16:SetPoint("BOTTOMLEFT",icon15,"BOTTOMRIGHT",1,0);
                end
                icon15t:ClearAllPoints();
                icon15t:SetPoint("BOTTOMRIGHT",icon15,"BOTTOMRIGHT",5,0); 
                icon15ta:ClearAllPoints();
                icon15ta:SetPoint("TOPLEFT",icon15,"TOPLEFT",-1,0);
            end
        elseif Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["ONBAR"]==2 then
            HealBot_Panel_SetMultiColHoToffset((iScale+1)*5)
            HealBot_Panel_SetMultiRowHoToffset(0)
            if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["POSITION"]==1 then
                icon1:ClearAllPoints();
                icon1:SetPoint("BOTTOMRIGHT",b,"BOTTOMLEFT",-1,0);
                icon1t:ClearAllPoints();
                icon1t:SetPoint("BOTTOMRIGHT",icon1,"BOTTOMRIGHT",5,0);
                icon1ta:ClearAllPoints();
                icon1ta:SetPoint("TOPLEFT",icon1,"TOPLEFT",-1,0);
                for x=2,14 do
                    icon=_G[bar:GetName().."Icon"..x];
                    icont=_G[bar:GetName().."Count"..x];
                    iconta=_G[bar:GetName().."Count"..x.."a"];
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
                    icont:ClearAllPoints();
                    icont:SetPoint("BOTTOMRIGHT",icon,"BOTTOMRIGHT",5,0);
                    iconta:ClearAllPoints();
                    iconta:SetPoint("TOPLEFT",icon,"TOPLEFT",-1,0);
                end
                icon15:ClearAllPoints();
                icon15:SetPoint("BOTTOMLEFT",b,"BOTTOMRIGHT",1,0);
                icon16:ClearAllPoints();
                if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                    icon16:SetPoint("BOTTOMLEFT",icon15,"TOPLEFT",0,1);
                else
                    icon16:SetPoint("BOTTOMLEFT",icon15,"BOTTOMRIGHT",1,0);
                end
                icon15t:ClearAllPoints();
                icon15t:SetPoint("BOTTOMRIGHT",icon15,"BOTTOMRIGHT",5,0); 
                icon15ta:ClearAllPoints();
                icon15ta:SetPoint("TOPLEFT",icon15,"TOPLEFT",-1,0);
            else
                icon1:ClearAllPoints();
                icon1:SetPoint("BOTTOMLEFT",b,"BOTTOMRIGHT",2,0);
                icon1t:ClearAllPoints();
                icon1t:SetPoint("BOTTOMLEFT",icon1,"BOTTOMLEFT",-1,0);
                icon1ta:ClearAllPoints();
                icon1ta:SetPoint("TOPRIGHT",icon1,"TOPRIGHT",5,0);
                for x=2,14 do
                    icon=_G[bar:GetName().."Icon"..x];
                    icont=_G[bar:GetName().."Count"..x];
                    iconta=_G[bar:GetName().."Count"..x.."a"];
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
                    icont:ClearAllPoints();
                    icont:SetPoint("BOTTOMLEFT",icon,"BOTTOMLEFT",-1,0);
                    iconta:ClearAllPoints();
                    iconta:SetPoint("TOPRIGHT",icon,"TOPRIGHT",5,0);
                end
                icon15:ClearAllPoints();
                icon15:SetPoint("BOTTOMRIGHT",b,"BOTTOMLEFT",-1,0);
                icon16:ClearAllPoints();
                if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                    icon16:SetPoint("BOTTOMRIGHT",icon15,"TOPRIGHT",0,1);
                else
                    icon16:SetPoint("BOTTOMRIGHT",icon15,"BOTTOMLEFT",-1,0);
                end
                icon15t:ClearAllPoints();
                icon15t:SetPoint("BOTTOMLEFT",icon15,"BOTTOMLEFT",-1,0); 
                icon15ta:ClearAllPoints();
                icon15ta:SetPoint("TOPRIGHT",icon15,"TOPRIGHT",5,0);
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
                icon1t:ClearAllPoints();
                icon1t:SetPoint("BOTTOMLEFT",icon1,"BOTTOMLEFT",-1,0);
                icon1ta:ClearAllPoints();
                icon1ta:SetPoint("TOPRIGHT",icon1,"TOPRIGHT",5,0);
                for x=2,14 do
                    icon=_G[bar:GetName().."Icon"..x];
                    icont=_G[bar:GetName().."Count"..x];
                    iconta=_G[bar:GetName().."Count"..x.."a"];
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
                    icont:ClearAllPoints();
                    icont:SetPoint("BOTTOMLEFT",icon,"BOTTOMLEFT",-1,0);
                    iconta:ClearAllPoints();
                    iconta:SetPoint("TOPRIGHT",icon,"TOPRIGHT",5,0);
                end
                icon15:ClearAllPoints();
                icon15:SetPoint("TOPRIGHT",b,"BOTTOMRIGHT",-1,-1);
                icon16:ClearAllPoints();
                if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                    icon16:SetPoint("BOTTOMRIGHT",icon15,"TOPRIGHT",0,-1);
                else
                    icon16:SetPoint("BOTTOMRIGHT",icon15,"BOTTOMLEFT",-1,0);
                end
                icon15t:ClearAllPoints();
                icon15t:SetPoint("BOTTOMLEFT",icon15,"BOTTOMLEFT",-1,0); 
                icon15ta:ClearAllPoints();
                icon15ta:SetPoint("TOPRIGHT",icon15,"TOPRIGHT",5,0);
            else
                icon1:ClearAllPoints();
                icon1:SetPoint("TOPRIGHT",b,"BOTTOMRIGHT",-1,-1);
                icon1t:ClearAllPoints();
                icon1t:SetPoint("BOTTOMRIGHT",icon1,"BOTTOMRIGHT",5,0);
                icon1ta:ClearAllPoints();
                icon1ta:SetPoint("TOPLEFT",icon1,"TOPLEFT",-1,0);
                for x=2,14 do
                    icon=_G[bar:GetName().."Icon"..x];
                    icont=_G[bar:GetName().."Count"..x];
                    iconta=_G[bar:GetName().."Count"..x.."a"];
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
                    icont:ClearAllPoints();
                    icont:SetPoint("BOTTOMRIGHT",icon,"BOTTOMRIGHT",5,0);
                    iconta:ClearAllPoints();
                    iconta:SetPoint("TOPLEFT",icon,"TOPLEFT",-1,0);
                end
                icon15:ClearAllPoints();
                icon15:SetPoint("TOPLEFT",b,"BOTTOMLEFT",1,-1);
                icon16:ClearAllPoints();
                if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
                    icon16:SetPoint("TOPLEFT",icon15,"BOTTOMRIGHT",0,-1);
                else
                    icon16:SetPoint("BOTTOMLEFT",icon15,"BOTTOMRIGHT",1,0);
                end
                icon15t:ClearAllPoints();
                icon15t:SetPoint("BOTTOMRIGHT",icon15,"BOTTOMRIGHT",5,0); 
                icon15ta:ClearAllPoints();
                icon15ta:SetPoint("TOPLEFT",icon15,"TOPLEFT",-1,0);
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
        barScale = bar:GetScale();
        bar:SetScale(barScale + 0.01);
        bar:SetScale(barScale);
        barScale = bar2:GetScale();
        bar2:SetScale(barScale + 0.01);
        bar2:SetScale(barScale);
        barScale = bar3:GetScale();
        bar3:SetScale(barScale + 0.01);
        bar3:SetScale(barScale);
        barScale = bar4:GetScale();
        bar4:SetScale(barScale + 0.01);
        bar4:SetScale(barScale);
        barScale = bar5:GetScale();
        bar5:SetScale(barScale + 0.01);
        bar5:SetScale(barScale);
        barScale = bar6:GetScale();
        bar6:SetScale(barScale + 0.01);
        bar6:SetScale(barScale);
    elseif barType=="header" then
          --for x=1,15 do
        h=button
        bar = HealBot_Action_HealthBar(h);
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
        barScale = bar:GetScale();
        bar:SetScale(barScale + 0.01);
        bar:SetScale(barScale);
    elseif barType=="hbfocus" then
        bar = HealBot_Action_HealthBar(button);
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
        barScale = bar:GetScale();
        bar:SetScale(barScale + 0.01);
        bar:SetScale(barScale);
    else
        HealBot_Action_SetAddHeightWidth()
        HealBot_Panel_clearResetHeaderSkinDone()
        HealBot_Action_clearResetBarSkinDone()
        HealBot_Action_sethbNumberFormat()
        HealBot_setOptions_Timer(85)
        if HealBot_resetSkinTo~=Healbot_Config_Skins.Current_Skin then
            HealBot_resetSkinTo=Healbot_Config_Skins.Current_Skin
            HealBot_Options_RaidTargetUpdate()
            for x=1,10 do
                local gaf = _G["f"..x.."_HealBot_Action"]
                HealBot_CheckFrame(x, gaf)
            end
        end
        if HealBot_Data["REFRESH"]<1 then 
            HealBot_Data["REFRESH"]=1; 
        end
    end
end

local curBucket=-25
function HealBot_Action_RefreshButtons(button)
    if button then
        HealBot_Action_RefreshButton(button)
    else
        curBucket=curBucket+1
        if curBucket>3 then curBucket=1 end
        for _,xButton in pairs(HealBot_Unit_Button) do
            if xButton.refresh==curBucket then
                HealBot_Action_CheckRange(xButton)
            end
        end
    end
end

function HealBot_Action_CheckAggro()
    for xUnit,_ in pairs(HealBot_UnitAggro) do
        if not HealBot_CheckUnitAggro(xUnit) then
            HealBot_UnitAggro[xUnit]=nil
        end
    end
end

function HealBot_Action_CheckRange(button)
    local unit=button.unit
    if (HealBot_UnitStatus[unit] or 0)>0 and UnitExists(unit) then
        if HealBot_UnitStatus[unit]>7 then 
            if unit~="player" and (UnitHealth(unit) or 0)>1 then 
                HealBot_Reset_UnitHealth(unit) 
            else
                local inRes=false
                if UnitHasIncomingResurrection(unit) then
                    inRes=true
                elseif HealBot_UnitHasRes[unit] then
                    if HealBot_UnitHasRes[unit]<GetTime() then 
                        HealBot_UnitHasRes[unit]=nil 
                    else
                        inRes=true
                    end
                end
                if ( inRes and HealBot_UnitStatus[unit]<9 ) or 
                       ( not inRes and HealBot_UnitStatus[unit]>8 ) or
                       ( not UnitIsDeadOrGhost(unit) ) then 
                    HealBot_Action_ResetUnitStatus(unit)
                elseif inRes and HealBot_UnitDirection[unit] then
                    HealBot_Action_HideDirectionArrow(button, unit)
                elseif HealBot_UnitDirection[unit] then
                    HealBot_Action_ShowDirectionArrow(button, unit)
                end
            end
        elseif HealBot_UnitRange[unit]==-2 then
            --HealBot_AddDebug("HealBot_UnitRange[unit]==-2 unit="..unit)
            HealBot_Action_RefreshButton(button)
        else
            local uRange=HealBot_UnitInRange(HealBot_UnitRangeSpell[unit] or HealBot_RangeSpells["HEAL"], unit)
            if uRange~=HealBot_UnitRange[unit] then
                local uHealIn, uAbsorbs = HealBot_IncHeals_retHealsIn(unit, button.frame)
                local ebubar,ebubar2,ebubar6,ebuicon15=nil,nil,nil,nil
                ebubar = HealBot_Action_HealthBar(button)
                ebubar2 = HealBot_Action_HealthBar2(button)
                ebubar6 = HealBot_Action_HealthBar6(button)
                ebubar.txt=_G[ebubar:GetName().."_text"];
                ebuicon15 = _G[ebubar:GetName().."Icon15"];
                HealBot_UnitRange[unit]=uRange
                if uHealIn==0 then
                    ebubar2:SetStatusBarColor(HealBot_UnitBarsRange["r"][unit],HealBot_UnitBarsRange["g"][unit],HealBot_UnitBarsRange["b"][unit],0);
                end
                if uAbsorbs==0 then
                    ebubar6:SetStatusBarColor(HealBot_UnitBarsRange["r"][unit],HealBot_UnitBarsRange["g"][unit],HealBot_UnitBarsRange["b"][unit],0);
                end
                if uRange==1 and not HealBot_PlayerDead then
                    if HealBot_UnitDirection[unit] then
                        HealBot_Action_RefreshButton(button)
                    else
                        ebubar:SetStatusBarColor(HealBot_UnitBarsRange["r"][unit],HealBot_UnitBarsRange["g"][unit],HealBot_UnitBarsRange["b"][unit],Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"])
                        if uHealIn>0 then 
                            ebubar2:SetStatusBarColor(HealBot_UnitBarsRange["hr"][unit],HealBot_UnitBarsRange["hg"][unit],HealBot_UnitBarsRange["hb"][unit],Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IA"]); 
                        end
                        if uAbsorbs>0 then 
                            ebubar6:SetStatusBarColor(HealBot_UnitBarsRange["sr"][unit],HealBot_UnitBarsRange["sg"][unit],HealBot_UnitBarsRange["sb"][unit],Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AA"]); 
                        end
                        ebubar.txt:SetTextColor(HealBot_UnitTextRange["ir"][unit],HealBot_UnitTextRange["ig"][unit],HealBot_UnitTextRange["ib"][unit],Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["EA"]);
                        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["CLASSONBAR"] and Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["CLASSTYPE"]==1 and not HealBot_retdebuffTargetIcon(unit) then
                            ebuicon15:SetAlpha(Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"]);
                        end
                        if Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["POWERSIZE"]>0 then 
                            HealBot_UnitBarsRange["3a"][unit]=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"]
                            HealBot_Action_SetBar3Value(button);
                        end
                        if Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][button.frame]["AUTOCLOSE"] then 
                            HealBot_Action_ShowPanel(button.frame) 
                        end
                    end
                elseif uRange==0 then
                    if not HealBot_UnitDirection[unit] and Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWDIR"] then
                        HealBot_Action_RefreshButton(button)
                    else
                        ebubar:SetStatusBarColor(HealBot_UnitBarsRange["r"][unit],HealBot_UnitBarsRange["g"][unit],HealBot_UnitBarsRange["b"][unit],Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["ORA"])
                        if uHealIn>0 then 
                            ebubar2:SetStatusBarColor(HealBot_UnitBarsRange["hr"][unit],HealBot_UnitBarsRange["hg"][unit],HealBot_UnitBarsRange["hb"][unit],HealBot_UnitBarsRange["a"][unit]); 
                        end
                        if uAbsorbs>0 then 
                            ebubar6:SetStatusBarColor(HealBot_UnitBarsRange["sr"][unit],HealBot_UnitBarsRange["sg"][unit],HealBot_UnitBarsRange["sb"][unit],HealBot_UnitBarsRange["a"][unit]); 
                        end
                        ebubar.txt:SetTextColor(HealBot_UnitTextRange["ir"][unit],HealBot_UnitTextRange["ig"][unit],HealBot_UnitTextRange["ib"][unit],HealBot_UnitTextRange["oa"][unit]);
                        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["CLASSONBAR"] and Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["CLASSTYPE"]==1 and
                           Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["I15EN"]==false and not HealBot_retdebuffTargetIcon(unit) then
                            ebuicon15:SetAlpha(HealBot_UnitBarsRange["a"][unit]);
                        end
                        if Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["POWERSIZE"]>0 then 
                            HealBot_UnitBarsRange["3a"][unit]=HealBot_UnitBarsRange["a"][unit]
                            HealBot_Action_SetBar3Value(button);
                        end
                    end
                else
                    if not HealBot_UnitDirection[unit] and Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWDIR"] then
                        HealBot_Action_RefreshButton(button)
                    else
                        ebubar:SetStatusBarColor(HealBot_UnitBarsRange["r"][unit],HealBot_UnitBarsRange["g"][unit],HealBot_UnitBarsRange["b"][unit],Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["DISA"])
                        if uHealIn>0 then 
                            ebubar2:SetStatusBarColor(HealBot_UnitBarsRange["hr"][unit],HealBot_UnitBarsRange["hg"][unit],HealBot_UnitBarsRange["hb"][unit],Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["DISA"]); 
                        end
                        if uAbsorbs>0 then 
                            ebubar6:SetStatusBarColor(HealBot_UnitBarsRange["sr"][unit],HealBot_UnitBarsRange["sg"][unit],HealBot_UnitBarsRange["sb"][unit],Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["DISA"]); 
                        end
                        ebubar.txt:SetTextColor(HealBot_UnitTextRange["or"][unit],HealBot_UnitTextRange["og"][unit],HealBot_UnitTextRange["ob"][unit],Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["DA"]);
                        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["CLASSONBAR"] and Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["CLASSTYPE"]==1 and 
                           Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["I15EN"]==false and not HealBot_retdebuffTargetIcon(unit) then
                            ebuicon15:SetAlpha(Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["DISA"]);
                        end
                        if Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["POWERSIZE"]>0 then 
                            HealBot_UnitBarsRange["3a"][unit]=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["DISA"]
                            HealBot_Action_SetBar3Value(button);
                        end
                    end
                end
            elseif HealBot_UnitDirection[unit] then
                HealBot_Action_ShowDirectionArrow(button, unit)
            end
        end
    elseif not UnitExists(unit) and HealBot_UnitStatus[unit]~=3 then
        HealBot_Action_RefreshButton(button)
        HealBot_UnitStatus[unit]=3
        HealBot_UnitRange[unit]=-2
    end
end

function HealBot_Action_CheckReserved()
    for xUnit,_ in pairs(HealBot_Reserved) do
        if HealBot_Unit_Button[xUnit] then
            if UnitExists(xUnit) then
                HealBot_UnitNameUpdate(xUnit)
                HealBot_Reserved[xUnit]=nil
            end
        else
            HealBot_Reserved[xUnit]=nil
        end
    end
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

function HealBot_Action_ResetUnitStatus(unit)
    if unit then
        HealBot_UnitStatus[unit]=1;
        HealBot_UnitRange[unit]=-2
    else
        for xUnit,_ in pairs(HealBot_Unit_Button) do
            HealBot_UnitStatus[xUnit]=1;
            HealBot_UnitRange[xUnit]=-2
        end
        --HealBot_AddDebug("HealBot_UnitRange for all")
    end
end

function HealBot_Action_ResetActiveUnitStatus()
    for xUnit,_ in pairs(HealBot_Unit_Button) do
        if HealBot_UnitStatus[xUnit]>0 or UnitHealth(xUnit)<2 then
            HealBot_UnitStatus[xUnit]=1
            HealBot_UnitRange[xUnit]=-2
        end
    end
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

function HealBot_Action_Res(resSpell, unit)
    local resTime = resSpellsCastTime[resSpell] or 10
    local addResTime = GetTime()+resTime+HealBot_Globals.ResLagDuration
    
    if resSpell==HEALBOT_DEBUFF_MASS_RESURRECTED then
        for xUnit,_ in pairs(HealBot_Unit_Button) do
            if UnitIsDeadOrGhost(xUnit) and not UnitIsFeignDeath(xUnit) and UnitIsVisible(xUnit) and not HealBot_HasDebuff(HEALBOT_DEBUFF_MASS_RESURRECTED, xUnit) then
                HealBot_UnitHasRes[xUnit]=addResTime
                HealBot_UnitStatus[xUnit]=1
                HealBot_UnitRange[xUnit]=-2
            end
        end
    elseif unit then
        if UnitIsDeadOrGhost(unit) and not UnitIsFeignDeath(unit) and UnitIsVisible(unit) then
            HealBot_UnitHasRes[unit]=addResTime
            HealBot_UnitStatus[unit]=1
            HealBot_UnitRange[unit]=-2
        end
    end
end

function HealBot_Action_clearResetBarSkinDone()
    for j=1,10 do
        HealBot_ResetBarSkinDone[j]={};
    end
end

function HealBot_Action_SetHealButton(unit,hbGUID,hbCurFrame,alsoEnemy)
    local shb=nil
    if hbGUID then
        if not HealBot_Unit_Button[unit] then
            shb=HealBot_Action_CreateButton(hbCurFrame)
            if not shb then
                return nil
            else
                shb.reset=true
            end
        else
            shb=HealBot_Unit_Button[unit]
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
        if not HealBot_UnitData[hbGUID] or HealBot_UnitData[hbGUID]["SPEC"]==" " then
            if HealBot_UnitData[hbGUID] then 
                HealBot_delClearLocalArr(hbGUID)
            else
                HealBot_UnitData[hbGUID]={}
                HealBot_UnitData[hbGUID]["UNIT"]="init2"
                HealBot_UnitData[hbGUID]["SPEC"] = " "
                HealBot_UnitData[hbGUID]["NAME"] = ""
                HealBot_UnitData[hbGUID]["ROLE"] = HEALBOT_WORDS_UNKNOWN
                if not HealBot_UnitData[unit] then HealBot_UnitData[unit]={} end
                HealBot_UnitData[unit]["EEXCLUDE"]=nil
                if UnitExists(unit) then
                    if UnitIsFriend("player",unit) then 
                        HealBot_CheckPlayerMana(hbGUID, unit) 
                    elseif (unit=="target" and Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TONLYFRIEND"]) or
                           (unit=="focus" and Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["FONLYFRIEND"]) then
                        HealBot_UnitData[unit]["EEXCLUDE"]=true
                    end
                end
            end
            HealBot_UnitData[hbGUID]["TIME"]=GetTime()
            shb.reset=true
        end
        if shb.guid~=hbGUID then
            shb.guid=hbGUID
            HealBot_UnitStatus[unit]=7
            HealBot_UnitRange[unit]=-2
        end
        if HealBot_Unit_Button[unit]~=shb or shb.unit~=unit or shb.reset then
            shb.reset=nil
            shb.unit=unit
            if (shb.refresh or 0)<1 then
                shb.refresh=HealBot_Action_BalanceRefresh()
            end
            if not shb.debuff then
                shb.buff=false
                shb.debuff={}
                shb.debuff.type=false
                shb.debuff.name=false
                shb.debuff.customPriority=99
                shb.debuff.spellId=false
                shb.bar4state=0
            end
            shb:SetAttribute("unit", unit);
            --if alsoEnemy then
                HealBot_Action_SetAllButtonAttribs(shb,"Enemy")
                HealBot_Action_SetAllButtonAttribs(shb,"Enabled")
            --else
            --    HealBot_Action_SetAllButtonAttribs(shb,"Enabled")
            --end
            HealBot_Unit_Button[unit]=shb
            HealBot_UnitData[hbGUID]["UNIT"]=unit
            HealBot_CheckAllBuffs(unit)
            HealBot_CheckAllDebuffs(unit)
            HealBot_CheckHealth(unit)
            HealBot_UnitStatus[unit]=7
            HealBot_UnitRange[unit]=-2
            if not HealBot_Enabled[unit] then HealBot_Enabled[unit]="e" end
        end
        if not HealBot_ResetBarSkinDone[shb.frame][shb.id] then
            HealBot_Action_ResetSkin("bar",shb)
        end
        if UnitExists(unit) and Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][hbCurFrame]["CLASSONBAR"] then
            HealBot_Action_SetClassIconTexture(shb)
        end
    else
        return nil
    end
    return shb
end

function HealBot_Action_SetTestButton(hbCurFrame, unitText)
    local thb=HealBot_Action_CreateButton(hbCurFrame)
    if thb then
        thb.unit=unitText
        thb.guid=nil
        thb.bar4state=0
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

local HealBotButtonMacroAttribs={}
function HealBot_Action_SetAllAttribs()
 --   HealBot_AddDebug("In HealBot_Action_SetAllAttribs")
    HealBot_ResetAttribs=true
    HealBot_Data["REFRESH"]=1
end

local HealBot_Keys_List = {"","Shift","Ctrl","Alt","Alt-Shift","Ctrl-Shift","Alt-Ctrl"}
local hbAttribsMinReset = {}
local HB_button,HB_prefix=nil,nil
function HealBot_Action_SetAllButtonAttribs(button,status)
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

--local mUnit=nil
local mText=nil
local showmenu=nil
local showHBmenu=nil
local setDropdown=nil
local partyNo=nil
function HealBot_Action_SetButtonAttrib(button,bbutton,bkey,status,j)
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

function HealBot_Action_SethbFocusButtonAttrib(button)
    button:SetAttribute("unit", "target")
    button:SetAttribute("helpbutton1", "focus1");
    button:SetAttribute("type1", "focus")
    button:SetAttribute("type-focus1", "focus")
end

function HealBot_Action_AlterSpell2Macro(spellName, spellTar, spellTrin1, spellTrin2, spellAvoidBC, unit, status)
    local smName=""
    local scText=""
    local sysSoundSFX = strsub(GetCVar("Sound_EnableErrorSpeech") or "nil",1,1)
    local spellType="help"
    if status=="Enemy" then spellType="harm" end
    scText="/cast [@"..unit..","..spellType.."] "..spellName..";\n"

    if HealBot_Globals.MacroSuppressSound==1 and sysSoundSFX=="1" then smName=smName.."/console Sound_EnableErrorSpeech 0\n" end
    if HealBot_Globals.MacroSuppressError==1 then smName=smName.."/script UIErrorsFrame:Hide();\n" end
    if spellTar then smName=smName.."/target "..unit..";\n" end
    if spellTrin1 then smName=smName.."/use 13;\n" end
    if spellTrin2 then smName=smName.."/use 14;\n" end
    if HealBot_Config.MacroUse10==1 then smName=smName.."/use 10;\n" end
    if HealBot_Globals.MacroSuppressError==1 then smName=smName.."/script UIErrorsFrame:Clear(); UIErrorsFrame:Show();\n" end
    if HealBot_Globals.MacroSuppressSound==1 and sysSoundSFX=="1" then smName=smName.."/console Sound_EnableErrorSpeech 1\n" end
    smName=smName..scText
    if spellAvoidBC then smName=smName.."/use 4;" end
    if strlen(smName)>255 then
        smName=""
        if HealBot_Globals.MacroSuppressSound==1 and sysSoundSFX=="1" then smName=smName.."/console Sound_EnableErrorSpeech 0\n" end
        if spellTar then smName=smName.."/target "..unit..";\n" end
        if spellTrin1 then smName=smName.."/use 13;\n" end
        if spellTrin2 then smName=smName.."/use 14;\n" end
        if HealBot_Config.MacroUse10==1 then smName=smName.."/use 10;\n" end
        if HealBot_Globals.MacroSuppressSound==1 and sysSoundSFX=="1" then smName=smName.."/console Sound_EnableErrorSpeech 1\n" end
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
    return smName
end

function HealBot_Action_hbmenuFrame_DropDown_Initialize(self,level,menuList)
    local info
    level = level or 1;
    if level==1 then
 
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
        info.func = function() HealBot_Action_Toggle_Enabled(self.unit); end
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
        info.func = function() HealBot_Reset_Unit(self); end
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

local hbCustomName={}
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
end

function HealBot_Action_CustomName(cName)
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
    return unit
end

function HealBot_Action_AttribSpellPattern(HB_combo_prefix)
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

function HealBot_Action_AttribDisSpellPattern(HB_combo_prefix)
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

function HealBot_Action_AttribEnemySpellPattern(HB_combo_prefix)
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

local hbInitButtons=false
function HealBot_Action_ResethbInitButtons()
    hbInitButtons=false
end

function HealBot_Action_PartyChanged(disableHealBot)
    local HealBot_PreCombat=nil
    if HealBot_Config.DisabledNow==1 and not disableHealBot then return end
    if InCombatLockdown() then 
        HealBot_Data["UILOCK"]="YES"
    elseif HealBot_Data["UILOCK"]=="YES" then 
        HealBot_PreCombat=true
        HealBot_Data["UILOCK"]="NO"
    end
    if HealBot_Data["UILOCK"]=="NO" and HealBot_Data["PGUID"] then
        if not HealBot_PreCombat and HealBot_ResetAttribs then
            for x,xButton in pairs(HealBot_Unit_Button) do
                xButton.reset="init";
            end
            for x,_ in pairs(HealBotButtonMacroAttribs) do
                HealBotButtonMacroAttribs[x]=nil;
            end
            for x,_ in pairs(hbAttribsMinReset) do
                hbAttribsMinReset[x]=nil;
            end
            HealBot_ResetAttribs=nil
        end
        if not hbInitButtons then
            for xUnit,xButton in pairs(HealBot_Unit_Button) do
                HealBot_Action_DeleteButton(xButton.id)
            end 
            hbInitButtons=true
        end
        
        if HealBot_PreCombat then 
            HealBot_EnteringCombat()
        end
  
        HealBot_Data["UNITSLOCK"]=1
        HealBot_Panel_PartyChanged(disableHealBot)
        HealBot_Data["UNITSLOCK"]=0
        
        for xUnit,_ in pairs(HealBot_Unit_Button) do
            if HealBot_UnitStatus[xUnit]==7 then
                HealBot_Action_ResetUnitStatus(xUnit)
            end
        end
    elseif HealBot_Data["REFRESH"]<2 then 
        HealBot_Data["REFRESH"]=2; 
    end
end

function HealBot_Action_CreateButton(hbCurFrame)
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
        local bar = HealBot_Action_HealthBar(ghb);
        local bar2 = HealBot_Action_HealthBar2(ghb);
        local bar3 = HealBot_Action_HealthBar3(ghb);
        local bar4 = HealBot_Action_HealthBar4(ghb)
        local bar5 = HealBot_Action_HealthBar5(ghb)
        local bar6 = HealBot_Action_HealthBar6(ghb)
        local barDir = HealBot_Action_HealthBarDir(ghb);
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

local ctlBuckets={[1]=0, [2]=0, [3]=0}
function HealBot_Action_BalanceRefresh()
    local nextBucket=1
    if ctlBuckets[2]<ctlBuckets[1] then 
        nextBucket=2
    elseif ctlBuckets[3]<ctlBuckets[1] then 
        nextBucket=3
    end
    ctlBuckets[nextBucket]=ctlBuckets[nextBucket]+1
    return nextBucket
end

function HealBot_Action_DeleteButton(hbBarID)
    local dg=_G["HealBot_Action_HealUnit"..hbBarID]
    local dbUnit=dg.unit or "N"
    local dbGUID=dg.guid or "0"
    HealBot_HoT_RemoveIconButton(dg,true)
    HealBot_Action_ClearUnitDebuffStatus(dbUnit)
    HealBot_Action_UpdateAggro(dbUnit,false,nil,0)
    HealBot_Aggro[dbUnit]=nil
    local bar4=HealBot_Action_HealthBar4(dg)
    bar4:SetStatusBarColor(1,0,0,0)
    dg.bar4state=0
    if HealBot_AggroIndicator[dbUnit] then
        HealBot_AggroIndicator[dbUnit]=nil
        HealBot_Action_aggoIndicatorUpd(dbUnit, 0)
    end
    if HealBot_UnitData[dbGUID] then HealBot_UnitData[dbGUID]["SPEC"] = " " end
    HealBot_Unit_Button[dbUnit]=nil
    dg.guid="nil"
    dg.unit="nil"
    HealBot_UnitStatus[dbUnit]=0
    HealBot_UnitRange[dbUnit]=0
    if (dg.refresh or 0)>0 then ctlBuckets[dg.refresh]=ctlBuckets[dg.refresh]-1 end
    dg.buff=false
    dg.debuff={}
    dg.debuff.type=false
    dg.debuff.name=false
    dg.debuff.customPriority=99
    dg.debuff.spellId=false
    dg.refresh=0
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
        if HealBot_Config.DisabledNow==0 and HealBot_Config.ActionVisible[i]==1 then
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
    if not InCombatLockdown() then  -- HealBot_Data["UILOCK"]=="NO"
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
    return hbClassCols[xClass].r, hbClassCols[xClass].g, hbClassCols[xClass].b
end

function HealBot_Action_HideTooltip(self)
    if HealBot_Data["TIPUNIT"] then
        HealBot_Data["TIPUNIT"] = false;
        HealBot_Data["TIPTYPE"] = "NONE";
        HealBot_Action_HideTooltipFrame()
    end
    HealBot_Data["INSPECT"]=false
end

function HealBot_Action_HideTooltipFrame()
    if HealBot_Data["TIPUSE"]=="YES" then
        if HealBot_Globals.UseGameTooltip then
            GameTooltip:Hide();
        else
            HealBot_Tooltip:Hide();
        end
    end
end

function HealBot_Action_Refresh(unit)
    if unit and HealBot_Unit_Button[unit] then
        local xButton=HealBot_Unit_Button[unit]
        if HealBot_PlayerDead then
            if Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][xButton.frame]["AUTOCLOSE"] and HealBot_Data["UILOCK"]=="NO" then
                HealBot_Action_HidePanel(xButton.frame); 
            else
                HealBot_Action_RefreshButton(xButton);
            end
            return;
        end
        HealBot_Action_RefreshButton(xButton);
        if HealBot_Data["UILOCK"]=="NO" then
            if HealBot_Config.ActionVisible[xButton.frame]==0 and HealBot_Config.DisabledNow==0 then
                if HealBot_Action_ShouldHealSome(unit, xButton.frame) then
                    HealBot_Action_ShowPanel(xButton.frame);
                end
            elseif Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][xButton.frame]["AUTOCLOSE"] then 
                if not HealBot_Action_ShouldHealSome(unit, xButton.frame) then
                    HealBot_Action_HidePanel(xButton.frame);
                end
            end
        end
    end
end

local hbLastButton=nil
function HealBot_Action_HealUnit_OnEnter(self)
    if not self.unit then return; end
    HealBot_Data["TIPUNIT"] = self.unit
    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][self.frame]["SHOWDIRMOUSE"] then
        HealBot_Action_ResetUnitStatus(self.unit)
    end
    if HealBot_Globals.ShowTooltip and HealBot_Data["TIPUSE"]=="YES" and UnitExists(self.unit) then
        if not UnitIsFriend("player",self.unit) then
            HealBot_Data["TIPTYPE"] = "Enemy"
        elseif HealBot_Data["UILOCK"]=="YES" and HealBot_Globals.DisableToolTipInCombat==false then
            HealBot_Data["TIPTYPE"] = "Enabled"
        elseif UnitAffectingCombat(self.unit)==1 then
            HealBot_Data["TIPTYPE"] = "Enabled"
        elseif HealBot_Enabled[self.unit]=="e" or HealBot_Config.EnableHealthy then 
            HealBot_Data["TIPTYPE"] = "Enabled"
        elseif not HealBot_PlayerDead then
            HealBot_Data["TIPTYPE"] = "Disabled"
        end
        if HealBot_Data["UILOCK"]=="YES" or HealBot_Globals.DisableToolTipInCombat then
            HealBot_Action_RefreshTooltip();
        end
    end
    if Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["CBAR"] and not UnitIsDeadOrGhost(self.unit) and HealBot_retHighlightTarget()~=self.unit then
        local z=false
        if HealBot_Data["UILOCK"]=="YES" then
            if Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["CBARCOMBAT"] then z=true end
        else
            z=true
        end
        if z then
            HealBot_Action_UpdateAggro(self.unit,"highlight",HealBot_UnitThreat[self.unit] or 0, HealBot_UnitThreatPct[self.unit])
        end
    end
    hbLastButton=self
   -- SetOverrideBindingClick(HealBot_Action,true,"MOUSEWHEELUP", "HealBot_Action_HealUnit"..self.id,"Button4");
   -- SetOverrideBindingClick(HealBot_Action,true,"MOUSEWHEELDOWN", "HealBot_Action_HealUnit"..self.id,"Button5");
end

function HealBot_Action_HealUnit_OnLeave(self)
    HealBot_Action_HideTooltip(self);
    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][self.frame]["SHOWDIRMOUSE"] then
        HealBot_Action_ResetUnitStatus(self.unit)
    end
    local xUnit=self.unit
    if Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["CBAR"] and HealBot_Hightlight[xUnit] and HealBot_Hightlight[xUnit]=="M" then
        if HealBot_Aggro[xUnit] and HealBot_Aggro[xUnit]=="h" then
            HealBot_Action_UpdateAggro(self.unit,"off",HealBot_UnitThreat[xUnit] or 0, 0)
        end
    end
    hbLastButton=nil
   -- ClearOverrideBindings(HealBot_Action)
end

local HealBot_MouseWheelCmd=nil

function HealBot_Action_HealUnit_Wheel(self, delta)
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
        HealBot_Action_Toggle_Enabled(xButton.unit)
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
        HealBot_MountsPets_RandomPet()   
    end

end

function HealBot_Action_OptionsButton_OnClick(self)
    HealBot_TogglePanel(HealBot_Options);
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
        else
            for _,xButton in pairs(HealBot_Unit_Button) do
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
local HealBot_HasAggro=false

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

function HealBot_Action_setTestBar(b)
    HealBot_UnitBarUpdate[b]=0
    HealBot_curUnitHealth[b]=100
end

function HealBot_Action_UpdateFluidBars()
    for ebubar,value in pairs(HealBot_UnitBarUpdate) do 
        if value>HealBot_curUnitHealth[ebubar] then
            if value-Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["FLUIDFREQ"]<=HealBot_curUnitHealth[ebubar] then
                HealBot_UnitBarUpdate[ebubar]=HealBot_curUnitHealth[ebubar]
            else
                HealBot_UnitBarUpdate[ebubar]=value-Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["FLUIDFREQ"]
            end
        elseif value+Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["FLUIDFREQ"]>=HealBot_curUnitHealth[ebubar] then
            HealBot_UnitBarUpdate[ebubar]=HealBot_curUnitHealth[ebubar]
        else
            HealBot_UnitBarUpdate[ebubar]=value+Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["FLUIDFREQ"]
        end
        ebubar:SetValue(HealBot_UnitBarUpdate[ebubar])
        if HealBot_UnitBarUpdate[ebubar]==HealBot_curUnitHealth[ebubar] then
            HealBot_UnitBarUpdate[ebubar]=nil
        end
    end
end

function HealBot_Action_UpdateAggroBars()
    for xUnit,xButton in pairs(HealBot_Unit_Button) do
        if xButton.bar4state>0 then
            local bar4=HealBot_Action_HealthBar4(xButton)
            if UnitExists(xUnit) then
                HealBot_AggroUnitThreat=HealBot_UnitThreat[xUnit] or 2
                if HealBot_AggroUnitThreat==9 and xButton.debuff.name then
                    if HealBot_Globals.CDCBarColour[xButton.debuff.name] then
                        bar4:SetStatusBarColor(HealBot_Globals.CDCBarColour[xButton.debuff.name].R,
                                               HealBot_Globals.CDCBarColour[xButton.debuff.name].G,
                                               HealBot_Globals.CDCBarColour[xButton.debuff.name].B,HealBot_AggroBarA)
                    else
                        local customDebuffPriority=HEALBOT_CUSTOM_en.."10"
                        if HealBot_GlobalsDefaults.HealBot_Custom_Debuffs[xButton.debuff.name] then
                            customDebuffPriority=HEALBOT_CUSTOM_en..HealBot_GlobalsDefaults.HealBot_Custom_Debuffs[xButton.debuff.name]
                        end
                        bar4:SetStatusBarColor(HealBot_Globals.CDCBarColour[customDebuffPriority].R,
                                               HealBot_Globals.CDCBarColour[customDebuffPriority].G,
                                               HealBot_Globals.CDCBarColour[customDebuffPriority].B,HealBot_AggroBarA)
                    end
                else
                    bar4:SetStatusBarColor(HealBot_AggroBarColr[HealBot_AggroUnitThreat],HealBot_AggroBarColg[HealBot_AggroUnitThreat],HealBot_AggroBarColb[HealBot_AggroUnitThreat],HealBot_AggroBarA)
                end
            else
                bar4:SetStatusBarColor(1,0,0,0)
                xButton.bar4state=0
            end
        end
    end
    if HealBot_AggroBarAup then
        if HealBot_AggroBarA>=Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["MAXA"] then
            HealBot_AggroBarAup=false
            HealBot_AggroBarA=HealBot_AggroBarA-0.05
        else
            HealBot_AggroBarA=HealBot_AggroBarA+0.05
        end
    else
        if HealBot_AggroBarA<=Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["MINA"] then
            HealBot_AggroBarAup=true
            HealBot_AggroBarA=HealBot_AggroBarA+0.05
        else
            HealBot_AggroBarA=HealBot_AggroBarA-0.05
        end
    end
end

local HealBot_Action_Init={}
function HealBot_Action_OnShow(self, hbCurFrame)
    if Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][hbCurFrame]["OPENSOUND"] then
        PlaySound(SOUNDKIT.IG_ABILITY_OPEN);
    end
    HealBot_Config.ActionVisible[hbCurFrame]=1
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
    HealBot_Config.ActionVisible[hbCurFrame] = 0
end

function HealBot_Action_OnMouseDown(self,button, hbCurFrame)
    if button=="LeftButton" then
        if Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][hbCurFrame]["LOCKED"]==false or (HealBot_Globals.ByPassLock==1 and IsControlKeyDown() and IsAltKeyDown()) then
            HealBot_FrameMoving=true
            HealBot_StartMoving(self);
        end
    end
end

function HealBot_Action_OnMouseUp(self,button,bID)
    if button=="LeftButton" and HealBot_FrameMoving then
        HealBot_StopMoving(self,bID);
        HealBot_FrameMoving=nil
    elseif button=="RightButton" and HealBot_Data["UILOCK"]=="NO" and HealBot_Globals.RightButtonOptions then
        HealBot_Action_OptionsButton_OnClick();
    end
end

function HealBot_Action_OnDragStart(self, hbCurFrame)
    if Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][hbCurFrame]["LOCKED"]==false then
        HealBot_FrameMoving=true
        HealBot_StartMoving(self);
    end
end

local usedSmartCast=nil
local ModKey=nil
local abutton=nil
local aj=nil
function HealBot_Action_PreClick(self,button)
    if self.id<999 and UnitExists(self.unit) then
        if UnitIsFriend("player",self.unit) then
            HealBot_UpdTargetUnitID(self.unit)
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
                    if HealBot_Data["TIPUSE"]=="YES" and HealBot_Globals.ShowTooltip then 
                        HealBot_Action_RefreshTargetTooltip(self) 
                    end
                elseif button=="LeftButton" and HealBot_Globals.SmartCast and not IsModifierKeyDown() then
                    HealBot_Action_UseSmartCast(self)
                end
            elseif IsShiftKeyDown() and IsControlKeyDown() and IsAltKeyDown() and (button=="LeftButton" or button=="MiddleButton" or button=="RightButton") then
                if button=="LeftButton" then
                    HealBot_Action_Toggle_Enabled(self.unit)
                elseif button=="RightButton" then
                    HealBot_Panel_ToggelHealTarget(self.unit)
                elseif not UnitIsUnit(self.unit, "player") and button=="MiddleButton" and HealBot_UnitGUID(self.unit) then
                    HealBot_Panel_AddBlackList(HealBot_UnitGUID(self.unit))
                end
            elseif HealBot_Data["UILOCK"]=="NO" then
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
                if HealBot_Enabled[self.unit]=="d" and HealBot_Config.EnableHealthy==false and not usedSmartCast then
                    HealBot_Action_SetButtonAttrib(self,abutton,ModKey,"Disabled",aj)
                    usedSmartCast=true;
                end
            end
        end
    end
end

function HealBot_Action_Toggle_Enabled(unit)
    local xGUID=HealBot_UnitGUID(unit)
    if HealBot_MyTargets[xGUID] then
        HealBot_MyTargets[xGUID]=nil
    else
        HealBot_MyTargets[xGUID]=true
    end
    HealBot_Action_ResetUnitStatus(unit)
end

function HealBot_Action_UseSmartCast(bp)
    local sName=HealBot_Action_SmartCast(bp);
    if sName then
        if HealBot_GetSpellId(sName) then
            if UnitIsUnit("player",bp.unit) or HealBot_UnitInRange(sName, bp.unit)==1 then
                bp:SetAttribute("helpbutton1", "heal1");
                bp:SetAttribute("type-heal1", "spell");
                bp:SetAttribute("spell-heal1", sName);
            end
        else
            local mId=GetMacroIndexByName(sName)
            if mId ~= 0 then
               local _,_,mText=GetMacroInfo(mId)
     --        mUnit = bp.unit
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

function HealBot_Action_PostClick(self,button)
    if UnitExists(self.unit) then
        if UnitIsFriend("player",self.unit) then
            if self.id==999 and not IsModifierKeyDown() then
                HealBot_Panel_clickToFocus("hide")
            elseif usedSmartCast then
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
        else
            HealBot_setCheckEnemyAura()
        end
    end
end

function HealBot_Action_RetMyTarget(hbGUID)
    return HealBot_MyTargets[hbGUID]
end

function HealBot_Action_GetNumDead()
    local numMembers = GetNumGroupMembers();
    local numDead = 0;
    for i = 1, numMembers do
       _, _, _, _, _, _, _, _, isDead = GetRaidRosterInfo(i);
       if isDead then numDead = numDead + 1 end
    end
    return numDead
end

function HealBot_Action_SmartCast(button)
    local scuSpell, scuHlth, scuMaxHlth, scuHealsIn, scuMinHlth = nil,nil,nil,nil, UnitLevel("player")*20
    local rangeSpell=HealBot_RangeSpells["HEAL"]
    if HealBot_PlayerDead then return nil; end
    
  
    if HealBot_Globals.SmartCastRes and UnitIsDead(button.unit) and not UnitIsGhost(button.unit) then
        local mrSpell = HealBot_Init_retSmartCast_MassRes();
        -- HealBot_Action_GetNumDead() > 1 and
        --[[if HealBot_GetSpellId(mrSpell) and (UnitInParty(button.unit) or UnitInRaid(button.unit)) then 
            scuSpell=HealBot_Init_retSmartCast_MassRes();
            rangeSpell=nil
        else
            scuSpell=HealBot_Init_retSmartCast_Res();
            rangeSpell=HealBot_RangeSpells["RES"]
        end--]]
		scuSpell=HealBot_Init_retSmartCast_Res();
        rangeSpell=HealBot_RangeSpells["RES"]
    elseif button.debuff.type and HealBot_Globals.SmartCastDebuff then
        scuSpell=HealBot_Options_retDebuffCureSpell(button.debuff.type);
        rangeSpell=HealBot_RangeSpells["CURE"]
    elseif button.buff and HealBot_Globals.SmartCastBuff then
        scuSpell=button.buff
        rangeSpell=HealBot_RangeSpells["BUFF"]
    elseif HealBot_Globals.SmartCastHeal then
        scuHealsIn = HealBot_IncHeals_retHealsIn(button.unit, button.frame);
        scuHlth, scuMaxHlth = HealBot_UnitHealth(button.unit);
        x = scuMaxHlth-(scuHlth+scuHealsIn);
        if x>scuMinHlth then
            scuSpell=HealBot_SmartCast(x)
        end
    end
    if rangeSpell and scuSpell and button.guid~=HealBot_Data["PGUID"] then
        if HealBot_UnitInRange(rangeSpell, button.unit)~=1 then return nil; end
    end
    return scuSpell;
end

function HealBot_Action_ClearLocalArr(hbGUID)
    HealBot_UnitOffline[hbGUID]=nil
    HealBot_PetMaxH[hbGUID]=nil
    HealBot_PetMaxHcnt1[hbGUID]=nil
    HealBot_PetMaxHcnt2[hbGUID]=nil
end

local HealBot_GMount = {}
local HealBot_PrevGMounts = {}
local HealBot_FMount = {}
local HealBot_PrevFMounts = {}
local HealBot_SMount = {}
local HealBot_mountData = {}
local HealBot_MountIndex = {}

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
    SetMapToCurrentZone()
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

    local mapC = GetCurrentMapContinent();
    if (mapC==3 or mapC==5) or (mapC == 4 and IsSpellKnown(54197)) or (mapC<3 and IsSpellKnown(90267)) 
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
                --HealBot_AddDebug("Not right faction for mount "..mount)
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

function HealBot_MountsPets_ToggelMount(mountType)
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

function HealBot_MountsPets_Mount(mount)
    if HealBot_MountIndex[mount] then 
        C_MountJournal.SummonByID(HealBot_MountIndex[mount]) 
    else
        HealBot_setOptions_Timer(405)
        HealBot_AddChat(HEALBOT_OPTION_EXCLUDEMOUNT_ON.." "..mount)
    end
end

function HealBot_MountsPets_RandomPet()
    C_PetJournal.SummonRandomPet("CRITTER");
end
