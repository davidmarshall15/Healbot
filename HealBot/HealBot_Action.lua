local ceil=ceil;
local floor=floor
local hbBarTextLen={[1]=50,[2]=50,[3]=50,[4]=50,[5]=50,[6]=50,[7]=50,[8]=50,[9]=50,[10]=50}
local strsub=strsub
local HealBot_ActiveButtons={[0]=1}
local HealBot_RangeSpells={}
local HealBot_AlwaysEnabled={}
local HealBot_pcClass={[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
local LSM = HealBot_retLSM() --LibStub("LibSharedMedia-3.0") 
local HealBot_ResetBarSkinDone={}
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
HealBot_Action_luVars["FrameMoving"]=false
HealBot_Action_luVars["ResetAttribs"]=false
HealBot_Action_luVars["AggroBarUp"]=false
HealBot_Action_luVars["UnitPowerMax"]=3
HealBot_Action_luVars["resetSkinTo"]=""
HealBot_Action_luVars["UpdatedAggroBars"]=true
HealBot_Action_luVars["UpdateFluidBars"]=true
HealBot_Action_luVars["updateBucket"]=1

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
        if button.aggro.status>=Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["ALERTIND"] then
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
        if threatStatus and (Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][xButton.frame]["SHOWBARSPCT"] or 
                             Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][xButton.frame]["SHOWTEXTPCT"]) then
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
        end
        if status then
            if HealBot_Config_Cures.CDCshownAB and xButton.aura.debuff.type then
                xButton.aggro.status=debuffCodes[xButton.aura.debuff.type]
            elseif HealBot_Config_Buffs.CBshownAB and xButton.aura.buff.name then
                xButton.aggro.status=4
            elseif Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][xButton.frame]["SHOW"] and 
                   threatStatus>Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][xButton.frame]["ALERT"] then
                xButton.aggro.status=threatStatus
            elseif status=="target" and Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][xButton.frame]["TBAR"] then
                xButton.aggro.status=-2
            elseif status=="highlight" and Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][xButton.frame]["CBAR"] then
                xButton.aggro.status=-1
            elseif xButton.aggro.status<0 and status=="off" then
                xButton.aggro.status=0
            else
                xButton.aggro.status=threatStatus or 0
            end
            if Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][xButton.frame]["SHOW"] and 
               Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][xButton.frame]["SHOWIND"] then
                HealBot_Action_aggroIndicatorUpd(xButton)
            end
        else
            xButton.aggro.status=0
            HealBot_Action_aggroIndicatorUpd(xButton)
        end
        if status and (xButton.aggro.status<0 or xButton.aggro.status>3 or 
                      (xButton.aggro.status>Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][xButton.frame]["ALERT"] and 
                       xButton.aggro.status<4 and Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][xButton.frame]["SHOWBARS"])) then
            if xButton.aggro.status>0 and xButton.aggro.status<4 and Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][xButton.frame]["SHOWBARSPCT"] then
                if Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][xButton.frame]["SHOWBARS"] and 
                   threatStatus>Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][xButton.frame]["ALERT"] then
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
    for x,_ in pairs(HealBot_ResetBarSkinDone) do
        HealBot_ResetBarSkinDone[x]=nil;
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
    local sName=nil
    if HealBot_Data["PCLASSTRIM"]=="DRUI" then
        sName=HealBot_KnownSpell(HEALBOT_WRATH)
        if sName then 
            HealBot_RangeSpells["HARM"]=sName
            x=sName
        else
            sName=HealBot_KnownSpell(HEALBOT_HURRICANE)
            if sName then 
                HealBot_RangeSpells["HARM"]=sName
                x=sName
            end
        end
        sName=HealBot_KnownSpell(HBC_GIFT_OF_THE_WILD)
        if sName then 
			HealBot_RangeSpells["BUFF"]=sName
			x=sName
		else
            sName=HealBot_KnownSpell(HEALBOT_MARK_OF_THE_WILD)
            if sName then 
                HealBot_RangeSpells["BUFF"]=sName
                x=sName
            end
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
        sName=HealBot_KnownSpell(HEALBOT_REJUVENATION)
        if sName then 
			HealBot_RangeSpells["HEAL"]=sName
			x=sName
		end
    elseif HealBot_Data["PCLASSTRIM"]=="MAGE" then
        sName=HealBot_KnownSpell(HEALBOT_FROSTFIRE_BOLT)
        if sName then 
            HealBot_RangeSpells["HARM"]=sName
            x=sName
        else
            sName=HealBot_KnownSpell(HEALBOT_FIRE_BLAST)
            if sName then 
                HealBot_RangeSpells["HARM"]=sName
                x=sName
            end
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
        sName=HealBot_KnownSpell(HEALBOT_HOLY_SHOCK)
        if sName then 
            HealBot_RangeSpells["HARM"]=sName
            x=sName
        else
            sName=HealBot_KnownSpell(HEALBOT_JUDGMENT)
            if sName then 
                HealBot_RangeSpells["HARM"]=sName
                x=sName
            end
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
        sName=HealBot_KnownSpell(HEALBOT_FLASH_OF_LIGHT)
		if sName then 
			HealBot_RangeSpells["HEAL"]=sName
			x=sName
		end
    elseif HealBot_Data["PCLASSTRIM"]=="PRIE" then
        sName=HealBot_KnownSpell(HEALBOT_SHADOW_WORD_PAIN)
        if sName then 
            HealBot_RangeSpells["HARM"]=sName
            x=sName
        else
            sName=HealBot_KnownSpell(HEALBOT_PENANCE)
            if sName then 
                HealBot_RangeSpells["HARM"]=sName
                x=sName
            else
                sName=HealBot_KnownSpell(HEALBOT_SMITE)
                if sName then 
                    HealBot_RangeSpells["HARM"]=sName
                    x=sName
                end
            end
        end
        sName=HealBot_KnownSpell(HEALBOT_POWER_WORD_FORTITUDE)
        if not sName and HEALBOT_GAME_VERSION<4 then sName=HealBot_KnownSpell(HBC_POWER_WORD_FORTITUDE) end
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
        sName=HealBot_KnownSpell(HEALBOT_FLASH_HEAL)
		if sName then 
			HealBot_RangeSpells["HEAL"]=sName
			x=sName
        else
            sName=HealBot_KnownSpell(HEALBOT_PENANCE)
            if sName then 
                HealBot_RangeSpells["HEAL"]=sName
                x=sName
            end
		end
    elseif HealBot_Data["PCLASSTRIM"]=="SHAM" then
        sName=HealBot_KnownSpell(HEALBOT_LIGHTNING_BOLT)
        if sName then 
			HealBot_RangeSpells["HARM"]=sName
            x=sName
		end
        sName=HealBot_KnownSpell(HEALBOT_EARTH_SHIELD)
		if sName then 
			HealBot_RangeSpells["BUFF"]=sName
			x=sName
		end
        sName=HealBot_KnownSpell(HEALBOT_PURIFY_SPIRIT)
		if sName then 
			HealBot_RangeSpells["CURE"]=sName
			x=sName
        else
            sName=HealBot_KnownSpell(HEALBOT_CLEANSE_SPIRIT)
            if sName then 
                HealBot_RangeSpells["CURE"]=sName
                x=sName
            else
                sName=HealBot_KnownSpell(HEALBOT_HEALING_SURGE)
                if sName then 
                    HealBot_RangeSpells["CURE"]=sName
                    x=sName
                end
            end
		end
        sName=HealBot_KnownSpell(HEALBOT_ANCESTRALSPIRIT)
		if sName then 
			HealBot_RangeSpells["RES"]=sName
			x=sName
		end
        sName=HealBot_KnownSpell(HEALBOT_HEALING_SURGE)
		if sName then 
			HealBot_RangeSpells["HEAL"]=sName
			x=sName
		end
    elseif HealBot_Data["PCLASSTRIM"]=="MONK" then
        sName=HealBot_KnownSpell(HEALBOT_CRACKLING_JADE_LIGHTNING)
        if sName then 
			HealBot_RangeSpells["HARM"]=sName
            x=sName
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
        sName=HealBot_KnownSpell(HEALBOT_CORRUPTION)
        if sName then 
			HealBot_RangeSpells["HARM"]=sName
            x=sName
        else
            sName=HealBot_KnownSpell(HEALBOT_FEAR)
            if sName then 
                HealBot_RangeSpells["HARM"]=sName
                x=sName
            end
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
            x=sName
		end
        sName=HealBot_KnownSpell(HEALBOT_VIGILANCE)
        if sName then 
			HealBot_RangeSpells["BUFF"]=sName
			x=sName
        else
            sName=HealBot_KnownSpell(HEALBOT_BATTLE_SHOUT)
            if sName then 
                HealBot_RangeSpells["BUFF"]=sName
                x=sName
            end
		end
    elseif HealBot_Data["PCLASSTRIM"]=="HUNT" then
        sName=HealBot_KnownSpell(HEALBOT_ARCANE_SHOT)
        if sName then 
			HealBot_RangeSpells["HARM"]=sName
            x=sName
        else
            sName=HealBot_KnownSpell(HEALBOT_CONCUSSIVE_SHOT)
            if sName then 
                HealBot_RangeSpells["HARM"]=sName
                x=sName
            else
                sName=HealBot_KnownSpell(HEALBOT_AIMED_SHOT)
                if sName then 
                    HealBot_RangeSpells["HARM"]=sName
                    x=sName
                end
            end
		end
        sName=HealBot_KnownSpell(HEALBOT_MENDPET)
		if sName then 
			HealBot_RangeSpells["HEAL"]=sName
			x=sName
		end
    elseif HealBot_Data["PCLASSTRIM"]=="ROGU" then
        sName=HealBot_KnownSpell(HEALBOT_THROW)
        if sName then 
			HealBot_RangeSpells["HARM"]=sName
            x=sName
        else
            sName=HealBot_KnownSpell(HEALBOT_GOUGE)
            if sName then 
                HealBot_RangeSpells["HARM"]=sName
                x=sName
            end
		end
    elseif HealBot_Data["PCLASSTRIM"]=="DEAT" then
        sName=HealBot_KnownSpell(HEALBOT_DEATH_COIL)
        if sName then 
			HealBot_RangeSpells["HARM"]=sName
            x=sName
        else
            sName=HealBot_KnownSpell(HEALBOT_PLAGUE_STRIKE)
            if sName then 
                HealBot_RangeSpells["HARM"]=sName
                x=HsName
            end
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
            local isDebuff=true
            if button.aura.buff.priority<button.aura.debuff.priority then
                if button.aura.buff.name and HealBot_Config_Buffs.CBshownHB and button.status.range>(HealBot_Config_Buffs.HealBot_CBWarnRange_Aggro-3) then
                    isDebuff=false
                end
            end
            if isDebuff and button.status.range>(HealBot_Config_Cures.HealBot_CDCWarnRange_Bar-3) then 
                local hcr,hcg,hcb = 0, 0, 0
                local ebusr,ebusg,ebusb = HealBot_Action_TextColours(button)
                local ebubar = _G["HealBot_Action_HealUnit"..button.id.."Bar"]

                if button.aura.debuff.type == HEALBOT_CUSTOM_en then
                    if HealBot_Globals.CDCBarColour[button.aura.debuff.id] then
                        if HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[button.aura.debuff.id] then
                            hcr = HealBot_Globals.CDCBarColour[button.aura.debuff.id].R
                            hcg = HealBot_Globals.CDCBarColour[button.aura.debuff.id].G
                            hcb = HealBot_Globals.CDCBarColour[button.aura.debuff.id].B
                        else
                            button.status.current=6
                            HealBot_Action_UpdateBuffButton(button)
                            return
                        end
                    else
                        if HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[button.aura.debuff.id] or 
                          (not HealBot_Globals.HealBot_Custom_Debuffs[button.aura.debuff.id]
                           and button.aura.debuff.priority==15
                           and HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[HEALBOT_CUSTOM_CAT_CUSTOM_AUTOMATIC]) then
                            local customDebuffPriority=HEALBOT_CUSTOM_en.."15"
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
                    if HealBot_Action_rCalls[button.unit]["hca"]~=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"] then
                        HealBot_Action_rCalls[button.unit]["hca"]=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"]
                        HealBot_Action_SetBar3Value(button)
                    end
                    button.status.enabled=true
                else
                    ebubar:SetStatusBarColor(hcr,hcg,hcb,Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["ORA"]);
                    HealBot_Action_HBText(button,ebusr,ebusg,ebusb,Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["DA"])
                    if HealBot_Action_rCalls[button.unit]["hca"]~=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["ORA"] then
                        HealBot_Action_rCalls[button.unit]["hca"]=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["ORA"]
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
        if HealBot_Config_Buffs.CBshownHB and button.status.range>(HealBot_Config_Buffs.HealBot_CBWarnRange_Aggro-3) then
            HealBot_UpdateUnitRange(button,HealBot_RangeSpells["BUFF"],false)
            local hcr,hcg,hcb = 0, 0, 0
            local ebusr,ebusg,ebusb = HealBot_Action_TextColours(button)
            local ebubar = _G["HealBot_Action_HealUnit"..button.id.."Bar"]
            local prevEnabled=button.status.enabled
            hcr,hcg,hcb=HealBot_Options_RetBuffRGB(button)  
            button.status.current=7
            HealBot_Action_setHealthText(button)
            if button.status.range==1 then  
                ebubar:SetStatusBarColor(hcr,hcg,hcb,Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"]);
                HealBot_Action_HBText(button,ebusr,ebusg,ebusb,Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["EA"])
                if HealBot_Action_rCalls[button.unit]["hca"]~=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"] then
                    HealBot_Action_rCalls[button.unit]["hca"]=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"]
                    HealBot_Action_SetBar3Value(button)
                end
                button.status.enabled=true
            else
                ebubar:SetStatusBarColor(hcr,hcg,hcb,Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["ORA"]);
                HealBot_Action_HBText(button,ebusr,ebusg,ebusb,Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["DA"])
                if HealBot_Action_rCalls[button.unit]["hca"]~=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["ORA"] then
                    HealBot_Action_rCalls[button.unit]["hca"]=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["ORA"]
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
            end
            if Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][button.frame]["SHOW"] then 
                button.update.targeticon=true
            end
            button.aura.buff.check=true
            button.update.state=true
            button.status.update=true
            button.health.updhealth=true
            button.health.update=true
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
        local PlayerBuffsList=button.aura.buff.recheck
        button.aura.buff.nextcheck=false
        for name,_ in pairs (PlayerBuffsList) do
            PlayerBuffsList[name]=nil
        end
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
                hcr, hcg = HealBot_Action_BarColourPct(hpct)
            end

            if button.aggro.status==3 or HealBot_AlwaysEnabled[button.guid] or
              (HealBot_Data["UILOCK"] and button.health.current<=(button.health.max*Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][button.frame]["ALERTIC"])) or
             (not HealBot_Data["UILOCK"] and button.health.current<=(button.health.max*Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][button.frame]["ALERTOC"])) then
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
            if HealBot_Action_rCalls[button.unit]["hca"]~=hca then
                HealBot_Action_rCalls[button.unit]["hca"]=hca
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
            HealBot_Action_SetBar3ColAlpha(barName, y, hcr, hcg, hcb, HealBot_Action_rCalls[unit]["hca"])
        end
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
        HealBot_Action_SetBar3ColAlpha(barName, 0, r, g, b, 0)
    end
  --HealBot_setCall("HealBot_Action_SetBar3Value")
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

function HealBot_Action_CheckUnitLowMana(button)
    if button then
        local bar = _G["HealBot_Action_HealUnit"..button.id.."Bar"]
        local iconName=nil
        if UnitExists(button.unit) and button.mana.current>0 and button.mana.max>0 and 
           Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["LOWMANA"]>1 then
            local z=floor((button.mana.current/button.mana.max)*100)
            local y=0
            if z<hbLowManaTrig[button.frame][1] then
                y=1
            elseif z<hbLowManaTrig[button.frame][2] then
                y=2
            elseif z<hbLowManaTrig[button.frame][3] then
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

local aggroNumFormatSurLa={[1]="[",[2]="[",[3]="[",[4]="[",[5]="[",[6]="[",[7]="[",[8]="[",[9]="[",}
local aggroNumFormatSurRa={[1]="]",[2]="]",[3]="]",[4]="]",[5]="]",[6]="]",[7]="]",[8]="]",[9]="]",}
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
        if HEALBOT_GAME_VERSION>3 and UnitInVehicle(button.unit) then
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
        if button.frame<10 and Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWTEXTPCT"] and button.aggro.threatpct>0 then 
            btHBbarText=btHBbarText.."  "..aggroNumFormatSurLa[button.frame]..button.aggro.threatpct.."%"..aggroNumFormatSurRa[button.frame]
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
                local hbRole=HealBot_Panel_UnitRole(button.unit)
                if hbRole=="DAMAGER" then
                    clTxt=HEALBOT_WORD_DAMAGER
                elseif hbRole=="HEALER" then
                    clTxt=HEALBOT_WORD_HEALER
                elseif hbRole=="TANK" then
                    clTxt=HEALBOT_WORD_TANK
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

            if Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWTEXT"] and button.aggro.status<4 and 
               (button.aggro.status or 0)>Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["ALERT"] and uName then
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
    for j=1,9 do
        if Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][j]["TEXTFORMAT"]==2 then
            aggroNumFormatSurLa[j]="("
            aggroNumFormatSurRa[j]=")"
        elseif Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][j]["TEXTFORMAT"]==3 then
            aggroNumFormatSurLa[j]="["
            aggroNumFormatSurRa[j]="]"
        elseif Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][j]["TEXTFORMAT"]==4 then
            aggroNumFormatSurLa[j]="{"
            aggroNumFormatSurRa[j]="}"
        elseif Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][j]["TEXTFORMAT"]==5 then
            aggroNumFormatSurLa[j]="<"
            aggroNumFormatSurRa[j]=">"
        elseif Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][j]["TEXTFORMAT"]==6 then
            aggroNumFormatSurLa[j]="~"
            aggroNumFormatSurRa[j]=""
        elseif Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][j]["TEXTFORMAT"]==7 then
            aggroNumFormatSurLa[j]=":"
            aggroNumFormatSurRa[j]=":"
        elseif Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][j]["TEXTFORMAT"]==8 then
            aggroNumFormatSurLa[j]="*"
            aggroNumFormatSurRa[j]="*"
        else
            aggroNumFormatSurLa[j]=""
            aggroNumFormatSurRa[j]=""
        end
    end
end

local HealBot_initSetFrame={[1]=true,[2]=true,[3]=true,[4]=true,[5]=true,[6]=true,[7]=true,[8]=true,[9]=true,[10]=true}
function HealBot_Action_resetInitSetFrame(frameID)
    HealBot_initSetFrame[frameID]=true
end

local function HealBot_DoAction_ResetSkin(barType,button,numcols)
    local frameScale = 1
    local b2Size = 0
    local abSize = 2
    local bheight= 20
    local bWidth = 120
    local bOutline = 1
    local btextheight=10
    local btextoutline=1
    if button and button.frame then 
        frameScale = Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][button.frame]["SCALE"]
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
    local barScale,h,hwidth,hheight,iScale,diScale,itScale,x,hcpct,bar5,bar6,barDir=nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil
    local abtSize = {[0]=1,[1]=1,[2]=1,[3]=2,[4]=2,[5]=2,[6]=3,[7]=3,[8]=3,[9]=3,[10]=4,[11]=4,[12]=4,[13]=4,[14]=4,[15]=5}
  
    if barType=="bar" then
        b=button;
        if Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][b.frame]["SHOW"]==false and 
           Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][b.frame]["CBAR"]==false and
           Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][b.frame]["TBAR"]==false then 
            abSize=0 
        end
         --for x=1,51 do
        HealBot_ResetBarSkinDone[b.id]=true
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
            bar.txt:SetPoint("LEFT",bar,"LEFT",4,Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["OFFSET"])
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["ALIGN"]==2 then
            bar.txt:SetPoint("CENTER",bar,"CENTER",0,Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["OFFSET"])
        else
            bar.txt:SetPoint("RIGHT",bar,"RIGHT",-4,Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][b.frame]["OFFSET"])
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
        for x=1,10 do
            icon=_G[bar:GetName().."Icon"..x];
            expire=_G[bar:GetName().."Expire"..x];
            count=_G[bar:GetName().."Count"..x];
            icon:SetHeight(iScale);
            icon:SetWidth(iScale);
            expire:SetFont(LSM:Fetch('font',Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][b.frame]["FONT"]),
                                            Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][b.frame]["HEIGHT"],
                                            HealBot_Font_Outline[Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][b.frame]["OUTLINE"]]);
            count:SetFont(LSM:Fetch('font',Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][b.frame]["FONT"]),
                                            Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][b.frame]["HEIGHT"],
                                            HealBot_Font_Outline[Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][b.frame]["OUTLINE"]]);
        end
        if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DOUBLE"] then
            diScale=floor(((bheight*Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DSCALE"])-2)*0.485)
        else
            diScale=(bheight*Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["DSCALE"])-2
        end
        for x=51,55 do
            icon=_G[bar:GetName().."Icon"..x];
            expire=_G[bar:GetName().."Expire"..x];
            count=_G[bar:GetName().."Count"..x];
            icon:SetHeight(diScale);
            icon:SetWidth(diScale);
            expire:SetFont(LSM:Fetch('font',Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][b.frame]["FONT"]),
                                            Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][b.frame]["HEIGHT"],
                                            HealBot_Font_Outline[Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][b.frame]["OUTLINE"]]);
            count:SetFont(LSM:Fetch('font',Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][b.frame]["FONT"]),
                                            Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][b.frame]["HEIGHT"],
                                            HealBot_Font_Outline[Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][b.frame]["OUTLINE"]]);
        end
        if diScale>iScale then iScale=diScale end
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
        if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["ONBAR"]==1 then
            HealBot_Panel_SetMultiColHoToffset(0)
            HealBot_Panel_SetMultiRowHoToffset(0)
            if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["POSITION"]==1 then
                icon1:ClearAllPoints();
                icon1:SetPoint("BOTTOMLEFT",b,"BOTTOMLEFT",1,0);
                expire1:ClearAllPoints();
                expire1:SetPoint("BOTTOMLEFT",icon1,"BOTTOMLEFT",0,0);
                count1:ClearAllPoints();
                count1:SetPoint("TOPRIGHT",icon1,"TOPRIGHT",2,0);
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
                    expire:SetPoint("BOTTOMLEFT",icon,"BOTTOMLEFT",0,0);
                    count:ClearAllPoints();
                    count:SetPoint("TOPRIGHT",icon,"TOPRIGHT",2,0);
                end
                icon51:ClearAllPoints();
                icon51:SetPoint("BOTTOMRIGHT",b,"BOTTOMRIGHT",1,0);
                expire51:ClearAllPoints();
                expire51:SetPoint("BOTTOMLEFT",icon51,"BOTTOMLEFT",0,0);
                count51:ClearAllPoints();
                count51:SetPoint("TOPRIGHT",icon51,"TOPRIGHT",2,0);
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
                    expire:SetPoint("BOTTOMLEFT",icon,"BOTTOMLEFT",0,0);
                    count:ClearAllPoints();
                    count:SetPoint("TOPRIGHT",icon,"TOPRIGHT",2,0);
                end
            else
                icon1:ClearAllPoints();
                icon1:SetPoint("BOTTOMRIGHT",b,"BOTTOMRIGHT",-1,0);
                expire1:ClearAllPoints();
                expire1:SetPoint("BOTTOMRIGHT",icon1,"BOTTOMRIGHT",2,0);
                count1:ClearAllPoints();
                count1:SetPoint("TOPLEFT",icon1,"TOPLEFT",0,0);
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
                    expire:SetPoint("BOTTOMRIGHT",icon,"BOTTOMRIGHT",2,0);
                    count:ClearAllPoints();
                    count:SetPoint("TOPLEFT",icon,"TOPLEFT",0,0);
                end
                icon51:ClearAllPoints();
                icon51:SetPoint("BOTTOMLEFT",b,"BOTTOMLEFT",-1,0);
                expire51:ClearAllPoints();
                expire51:SetPoint("BOTTOMRIGHT",icon51,"BOTTOMRIGHT",2,0);
                count51:ClearAllPoints();
                count51:SetPoint("TOPLEFT",icon51,"TOPLEFT",0,0);
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
                    expire:SetPoint("BOTTOMRIGHT",icon,"BOTTOMRIGHT",2,0);
                    count:ClearAllPoints();
                    count:SetPoint("TOPLEFT",icon,"TOPLEFT",0,0);
                end
            end
        elseif Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["ONBAR"]==2 then
            HealBot_Panel_SetMultiColHoToffset((iScale+1)*5)
            HealBot_Panel_SetMultiRowHoToffset(0)
            if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][b.frame]["POSITION"]==1 then
                icon1:ClearAllPoints();
                icon1:SetPoint("BOTTOMRIGHT",b,"BOTTOMLEFT",-1,0);
                expire1:ClearAllPoints();
                expire1:SetPoint("BOTTOMRIGHT",icon1,"BOTTOMRIGHT",2,0);
                count1:ClearAllPoints();
                count1:SetPoint("TOPLEFT",icon1,"TOPLEFT",0,0);
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
                    expire:SetPoint("BOTTOMRIGHT",icon,"BOTTOMRIGHT",2,0);
                    count:ClearAllPoints();
                    count:SetPoint("TOPLEFT",icon,"TOPLEFT",0,0);
                end
                icon51:ClearAllPoints();
                icon51:SetPoint("BOTTOMLEFT",b,"BOTTOMRIGHT",-1,0);
                expire51:ClearAllPoints();
                expire51:SetPoint("BOTTOMRIGHT",icon51,"BOTTOMRIGHT",2,0);
                count51:ClearAllPoints();
                count51:SetPoint("TOPLEFT",icon51,"TOPLEFT",0,0);
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
                    expire:SetPoint("BOTTOMRIGHT",icon,"BOTTOMRIGHT",2,0);
                    count:ClearAllPoints();
                    count:SetPoint("TOPLEFT",icon,"TOPLEFT",0,0);
                end
            else
                icon1:ClearAllPoints();
                icon1:SetPoint("BOTTOMLEFT",b,"BOTTOMRIGHT",2,0);
                expire1:ClearAllPoints();
                expire1:SetPoint("BOTTOMLEFT",icon1,"BOTTOMLEFT",0,0);
                count1:ClearAllPoints();
                count1:SetPoint("TOPRIGHT",icon1,"TOPRIGHT",2,0);
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
                    expire:SetPoint("BOTTOMLEFT",icon,"BOTTOMLEFT",0,0);
                    count:ClearAllPoints();
                    count:SetPoint("TOPRIGHT",icon,"TOPRIGHT",2,0);
                end
                icon51:ClearAllPoints();
                icon51:SetPoint("BOTTOMRIGHT",b,"BOTTOMLEFT",2,0);
                expire51:ClearAllPoints();
                expire51:SetPoint("BOTTOMLEFT",icon51,"BOTTOMLEFT",0,0);
                count51:ClearAllPoints();
                count51:SetPoint("TOPRIGHT",icon51,"TOPRIGHT",2,0);
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
                    expire:SetPoint("BOTTOMLEFT",icon,"BOTTOMLEFT",0,0);
                    count:ClearAllPoints();
                    count:SetPoint("TOPRIGHT",icon,"TOPRIGHT",2,0);
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
                expire1:SetPoint("BOTTOMLEFT",icon1,"BOTTOMLEFT",0,0);
                count1:ClearAllPoints();
                count1:SetPoint("TOPRIGHT",icon1,"TOPRIGHT",2,0);
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
                    expire:SetPoint("BOTTOMLEFT",icon,"BOTTOMLEFT",0,0);
                    count:ClearAllPoints();
                    count:SetPoint("TOPRIGHT",icon,"TOPRIGHT",2,0);
                end
                icon51:ClearAllPoints();
                icon51:SetPoint("TOPRIGHT",b,"BOTTOMRIGHT",-1,-1);
                expire51:ClearAllPoints();
                expire51:SetPoint("BOTTOMLEFT",icon51,"BOTTOMLEFT",0,0);
                count51:ClearAllPoints();
                count51:SetPoint("TOPRIGHT",icon51,"TOPRIGHT",2,0);
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
                    expire:SetPoint("BOTTOMLEFT",icon,"BOTTOMLEFT",0,0);
                    count:ClearAllPoints();
                    count:SetPoint("TOPRIGHT",icon,"TOPRIGHT",2,0);
                end
            else
                icon1:ClearAllPoints();
                icon1:SetPoint("TOPRIGHT",b,"BOTTOMRIGHT",-1,-1);
                expire1:ClearAllPoints();
                expire1:SetPoint("BOTTOMRIGHT",icon1,"BOTTOMRIGHT",2,0);
                count1:ClearAllPoints();
                count1:SetPoint("TOPLEFT",icon1,"TOPLEFT",0,0);
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
                    expire:SetPoint("BOTTOMRIGHT",icon,"BOTTOMRIGHT",2,0);
                    count:ClearAllPoints();
                    count:SetPoint("TOPLEFT",icon,"TOPLEFT",0,0);
                end
                icon51:ClearAllPoints();
                icon51:SetPoint("TOPLEFT",b,"BOTTOMLEFT",-1,-1);
                expire51:ClearAllPoints();
                expire51:SetPoint("BOTTOMRIGHT",icon51,"BOTTOMRIGHT",2,0);
                count51:ClearAllPoints();
                count51:SetPoint("TOPLEFT",icon51,"TOPLEFT",0,0);
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
                    expire:SetPoint("BOTTOMRIGHT",icon,"BOTTOMRIGHT",2,0);
                    count:ClearAllPoints();
                    count:SetPoint("TOPLEFT",icon,"TOPLEFT",0,0);
                end
            end
        end

        if Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][b.frame]["POWERSIZE"]==0 then
            bar3:SetHeight(0);
            bar3:SetValue(0);
            bar3:SetStatusBarColor(0,0,0,0)
        elseif b.unit then 
            HealBot_Action_SetBar3Value(b)
        end
        if not Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][b.frame]["SHOWBARS"] and 
           not Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][b.frame]["CBAR"] and
           not Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][b.frame]["TBAR"] then
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
        h=button
        bar = _G[h:GetName().."Bar"]
        hwidth = ceil(bWidth*Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][h.frame]["WIDTH"])
        HealBot_Panel_SetHeadArrays(h.id)
        h:SetHeight(ceil(Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][h.frame]["HEIGHT"]*frameScale));
        h:SetWidth(hwidth);
        bar:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][h.frame]["TEXTURE"]));
        bar:GetStatusBarTexture():SetHorizTile(false)
        bar:SetMinMaxValues(0,100);
        bar:SetValue(100);
        bar:SetStatusBarColor(Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][button.frame]["R"],
                              Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][button.frame]["G"],
                              Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][button.frame]["B"],
                              Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][button.frame]["A"]);
        bar:SetHeight(ceil(Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][h.frame]["HEIGHT"]*frameScale));
        bar:SetWidth(hwidth);
        bar.txt = _G[bar:GetName().."_text"];
        bar.txt:SetFont(LSM:Fetch('font',Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][h.frame]["FONT"]),
                                Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][h.frame]["HEIGHT"],
                                HealBot_Font_Outline[Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][h.frame]["OUTLINE"]]);
        bar.txt:SetTextColor(Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][button.frame]["R"],
                             Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][button.frame]["G"],
                             Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][button.frame]["B"],
                             Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][button.frame]["A"]);
        bar.txt:SetPoint("CENTER",bar,"CENTER",0,Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][h.frame]["OFFSET"])
        bar:EnableMouse(false)
        h:Disable();
    elseif barType=="frameheader" then
        local g=_G["f"..numcols.."_HealBot_Action"]
        if g:IsVisible() and g:GetRight() and g:GetLeft() then
            bar=_G["f"..numcols.."_HealBot_Action_HeaderBar"]
            if Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][numcols]["SHOW"] then
                local fWidth=g:GetRight()-g:GetLeft()
                --bar = _G[h:GetName().."Bar"]
                hwidth = ceil(fWidth*Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][numcols]["WIDTH"])
                --HealBot_Panel_SetHeadArrays(h.id)
                bar:SetHeight(ceil(Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][numcols]["HEIGHT"]*frameScale));
                bar:SetWidth(hwidth);
                bar:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][numcols]["TEXTURE"]));
                bar:GetStatusBarTexture():SetHorizTile(false)
                bar:SetMinMaxValues(0,100);
                bar:SetValue(100);
                bar:SetStatusBarColor(Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][numcols]["R"],
                                      Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][numcols]["G"],
                                      Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][numcols]["B"],
                                      Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][numcols]["A"]);
            else
                bar:SetStatusBarColor(0,0,0,0);
            end
            bar:EnableMouse(false)
            barScale = bar:GetScale();
            bar:SetScale(barScale + 0.01);
            bar:SetScale(barScale);
        end
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
        barScale = bar:GetScale();
        bar:SetScale(barScale + 0.01);
        bar:SetScale(barScale);
    else
        HealBot_Action_SetAddHeightWidth()
        HealBot_Panel_clearResetHeaderSkinDone()
        HealBot_Action_clearResetBarSkinDone()
        HealBot_setOptions_Timer(80)
        if HealBot_Action_luVars["resetSkinTo"]~=Healbot_Config_Skins.Current_Skin then
            HealBot_Action_luVars["resetSkinTo"]=Healbot_Config_Skins.Current_Skin
            HealBot_setOptions_Timer(800)
            for x=1,10 do
                HealBot_Action_resetInitSetFrame(x)
            end
        end
        HealBot_setHighlightTargetBar()
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
        HealBot_DoAction_ResetSkin("frameheader",nil,hbCurFrame)
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

local function HealBot_Action_ResetrCallsUnit(unit)
    if not HealBot_Action_rCalls[unit] then HealBot_Action_rCalls[unit]={} end
    HealBot_Action_rCalls[unit]["aggroIndicator"]="notSet"
    HealBot_Action_rCalls[unit]["powerIndicator"]="notSet"
    HealBot_Action_rCalls[unit]["manaIndicator"]="notSet"
    HealBot_Action_rCalls[unit]["barText"]="notSet"
    HealBot_Action_rCalls[unit]["hca"]=0
end

function HealBot_Action_ResetrCalls()
    for xUnit,_ in pairs(HealBot_Unit_Button) do
        HealBot_Action_ResetrCallsUnit(xUnit)
    end
    for xUnit,_ in pairs(HealBot_Pet_Button) do
        HealBot_Action_ResetrCallsUnit(xUnit)
    end
    for xUnit,_ in pairs(HealBot_Enemy_Button) do
        HealBot_Action_ResetrCallsUnit(xUnit)
    end
end 

local function HealBot_Action_InitButton(button)
    HealBot_Action_setRegisterForClicks(button)
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
    button.text={}
    button.icon={}
    button.icon.debuff={}
    button.icon.buff={}
    local bar = _G["HealBot_Action_HealUnit"..button.id.."Bar"]
    local bar2 = _G["HealBot_Action_HealUnit"..button.id.."Bar2"] 
    local bar3 = _G["HealBot_Action_HealUnit"..button.id.."Bar3"] 
    local bar4 = _G["HealBot_Action_HealUnit"..button.id.."Bar4"] 
    local bar5 = _G["HealBot_Action_HealUnit"..button.id.."Bar5"]
    local bar6 = _G["HealBot_Action_HealUnit"..button.id.."Bar6"]
    local barDir = _G["HealBot_Action_HealUnit"..button.id.."BarDir"]
    bar:UnregisterAllEvents()
    bar2:UnregisterAllEvents()
    bar3:UnregisterAllEvents()
    bar4:UnregisterAllEvents()
    bar5:UnregisterAllEvents()
    bar6:UnregisterAllEvents()
    barDir:UnregisterAllEvents()
    barDir:ClearAllPoints();
    barDir:SetPoint("TOP",button,"TOP",-1,0);
    button:Enable();
    bar:SetMinMaxValues(0,100)
    bar2:SetMinMaxValues(0,100)
    bar3:SetMinMaxValues(0,100)
    bar5:SetMinMaxValues(0,100)
    bar6:SetMinMaxValues(0,100)
    bar5:SetStatusBarColor(0,1,0,0)
    bar:SetValue(100)
    bar2:SetValue(0)
    bar5:SetValue(100)
    bar6:SetValue(0)
    bar2:SetStatusBarColor(0,1,0,0)
    bar:SetStatusBarColor(0,1,0,1)
    bar6:SetStatusBarColor(0,1,0,0)
    bar4:SetStatusBarColor(1,0,0,0)
    bar4:SetMinMaxValues(0,100)
    bar4:SetValue(100)
    HealBot_Panel_SetBarArrays(button.id)
end
 
local function HealBot_Action_PrepButton(button)
    button.guid="nil"
    button.unit="nil"
    button.health.current=99
    button.health.max=100
    button.health.incoming=0
    button.health.absorbs=0
    button.health.update=false
    button.health.updhealth=false
    button.health.updincoming=false
    button.health.updabsorbs=false
    button.mana.current=0
    button.mana.max=0
    button.status.current=0
    button.status.update=0
    button.update.reset=true
    button.update.unit=false
    button.update.state=false
    button.update.roleicon=false
    button.update.targeticon=false
    button.bucket=1
    button.status.range=-9
    button.status.unittype=1
    button.status.offline=false
    button.status.enabled=false
    button.status.dirarrow=99999 
    button.status.reserved=false
    button.status.bar4=0
    button.checks.timed=GetTime()+1000000
    button.spells.castpct=-1
    button.aura.buff.name=false
    button.aura.buff.id=0
    button.icon.buff.count=0
    button.aura.buff.priority=99
    button.aura.buff.nextcheck=false
    button.aura.debuff.type=false
    button.aura.debuff.name=false
    button.aura.debuff.id=0
    button.icon.debuff.count=0
    button.icon.debuff.targeticon=0
    button.icon.debuff.classtexture=false
    button.icon.debuff.readycheck=false
    button.aura.debuff.priority=99
    button.aura.buff.check=false
    button.aura.debuff.check=false
    button.aggro.status=0
    button.aggro.threatpct=0
    button.text.health="100"
    button.text.name=" "
    button.text.tag=""
    button.spec=" "
    button.reset=true
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
        local ghb=_G[gn]
        if not ghb then 
            local gp=_G["f"..hbCurFrame.."_HealBot_Action"]
            ghb=CreateFrame("Button", gn, gp, "HealBotButtonSecureTemplate") 
            ghb.id=freeId
            HealBot_Action_InitButton(ghb)
            HealBot_Action_PrepButton(ghb)
            ghb.frame=hbCurFrame
        end
        HealBot_ActiveButtons[0]=freeId+1
        return ghb
    else
        return nil
    end
end

local HealBot_Keys_List = {"","Shift","Ctrl","Alt","Alt-Shift","Ctrl-Shift","Alt-Ctrl"}
local hbAttribsMinReset = {}
local HB_button,HB_prefix=nil,nil
local showHBmenu=nil

local function HealBot_Action_SpellCmdCodes(cType, cText)
    local cID=nil
    if cType == "ENEMY" then
        if cText == HEALBOT_DISABLED_TARGET then
            cID="A"
        elseif cText == HEALBOT_FOCUS then
            cID="B"
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
        elseif cText == HEALBOT_TELL.." ..." then
            cID="G"
        end
    end
    return cID
end

local function HealBot_Action_SpellCmdText(cType, cID)
    local cText=nil
    if cType == "ENEMY" then
        if cID == "A" then
            cText=HEALBOT_DISABLED_TARGET
        elseif cID == "B" then
            cText=HEALBOT_FOCUS
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
            cText=HEALBOT_TELL.." ..."
        end
    end
    return cText
end

function HealBot_Action_SetSpell(cType, cKey, sText)
    local combo=nil
    if cType == "ENABLED" then
        combo = HealBot_Config_Spells.EnabledKeyCombo;
    elseif cType == "DISABLED" then
        combo = HealBot_Config_Spells.DisabledKeyCombo;
    else
        combo=HealBot_Config_Spells.EnemyKeyCombo;
    end
    if sText and hbStringLen(sText)>0 then
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
    end
    combo[cKey] = sText
end

function HealBot_Action_GetSpell(cType, cKey)
    local sVar=nil
    if cType == "ENABLED" then
        sVar=HealBot_Config_Spells.EnabledKeyCombo[cKey]
    elseif cType == "DISABLED" then
        sVar=HealBot_Config_Spells.DisabledKeyCombo[cKey]
    else
        sVar=HealBot_Config_Spells.EnemyKeyCombo[cKey]
    end
    if sVar and hbStringLen(sVar)>2 then
        local sType,sID = string.split(":", sVar)
        if sType and sID then
            if sType == "C" then
                sVar=HealBot_Action_SpellCmdText(cType, sID)
            elseif sType == "I" then
                sVar=GetItemInfo(sID)
            else
                sVar=GetSpellInfo(sID)
				if HEALBOT_GAME_VERSION<4 then
					local rank = GetSpellSubtext(sID)
					if rank then
                        local knownHealSpells=HealBot_Init_retFoundHealSpells()
                        if knownHealSpells[sVar] then
                            sVar=sVar.."("..rank..")"
                        end
					end
				end
            end
        end
    end
    return sVar
end

function HealBot_Action_AttribSpellPattern(HB_combo_prefix)
    local sName = HealBot_Action_GetSpell("ENABLED", HB_combo_prefix)
    local hbTarget = HealBot_Config_Spells.EnabledSpellTarget
    local hbTrinket1 = HealBot_Config_Spells.EnabledSpellTrinket1
    local hbTrinket2 = HealBot_Config_Spells.EnabledSpellTrinket2
    local hbAvoidBC  = HealBot_Config_Spells.EnabledAvoidBlueCursor
    if not sName then 
        return nil 
    end
    return sName, hbTarget[HB_combo_prefix] or false, hbTrinket1[HB_combo_prefix] or false, hbTrinket2[HB_combo_prefix] or false, hbAvoidBC[HB_combo_prefix] or false
end

function HealBot_Action_AttribDisSpellPattern(HB_combo_prefix)
    local sName = HealBot_Action_GetSpell("DISABLED", HB_combo_prefix)
    local hbTarget = HealBot_Config_Spells.DisabledSpellTarget
    local hbTrinket1 = HealBot_Config_Spells.DisabledSpellTrinket1
    local hbTrinket2 = HealBot_Config_Spells.DisabledSpellTrinket2
    local hbAvoidBC  = HealBot_Config_Spells.DisabledAvoidBlueCursor
    if not sName then 
        return nil 
    end
    return sName, hbTarget[HB_combo_prefix] or false, hbTrinket1[HB_combo_prefix] or false, hbTrinket2[HB_combo_prefix] or false, hbAvoidBC[HB_combo_prefix] or false
end

function HealBot_Action_AttribEnemySpellPattern(HB_combo_prefix)
    local sName = HealBot_Action_GetSpell("ENEMY", HB_combo_prefix)
    local hbTarget = HealBot_Config_Spells.EnemySpellTarget
    local hbTrinket1 = HealBot_Config_Spells.EnemySpellTrinket1
    local hbTrinket2 = HealBot_Config_Spells.EnemySpellTrinket2
    local hbAvoidBC  = HealBot_Config_Spells.EnemyAvoidBlueCursor
    if not sName then 
        return nil 
    end
    return sName, hbTarget[HB_combo_prefix] or false, hbTrinket1[HB_combo_prefix] or false, hbTrinket2[HB_combo_prefix] or false, hbAvoidBC[HB_combo_prefix] or false
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

local function HealBot_Action_ToggelMyFriend(unit)
    local xGUID=UnitGUID(unit)
    if xGUID then
        if HealBot_Config.MyFriend==xGUID then
            HealBot_Config.MyFriend="x"
        else
            HealBot_Config.MyFriend=xGUID
        end
    end
    HealBot_CheckAllBuffs(unit)
end

local function HealBot_Action_hbmenuFrame_DropDown_Initialize(self,level,menuList)
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

        if HEALBOT_GAME_VERSION>3 then 
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
    elseif menuList=="hbFocus" and HEALBOT_GAME_VERSION>3 then
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

    if HealBot_Globals.MacroSuppressError==1 then smName=smName..'/hb se3\n' end
    if HealBot_Globals.MacroSuppressSound==1 then smName=smName..'/hb se1\n' end
    if spellTar then smName=smName.."/target "..unit..";\n" end
    if spellTrin1 then smName=smName.."/use 13;\n" end
    if spellTrin2 then smName=smName.."/use 14;\n" end
    if HealBot_Config.MacroUse10==1 then smName=smName.."/use 10;\n" end
    if HealBot_Globals.MacroSuppressSound==1 then smName=smName.."/hb se2\n" end
    if HealBot_Globals.MacroSuppressError==1 then smName=smName..'/hb se4\n' end
    smName=smName..scText
    if spellAvoidBC then smName=smName.."/use 4;" end
    if strlen(smName)>255 then
        smName=""
        if HealBot_Globals.MacroSuppressSound==1 then smName=smName.."/hb se1\n" end
        if spellTar then smName=smName.."/target "..unit..";\n" end
        if spellTrin1 then smName=smName.."/use 13;\n" end
        if spellTrin2 then smName=smName.."/use 14;\n" end
        if HealBot_Config.MacroUse10==1 then smName=smName.."/use 10;\n" end
        if HealBot_Globals.MacroSuppressSound==1 then smName=smName.."/hb se2\n" end
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
                smName=""
                if spellTrin1 then smName=smName.."/use 13;\n" end
                if spellTrin2 then smName=smName.."/use 14;\n" end
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
    elseif status=="Fixed" then
        if j==1 then
            sName=strlower(HEALBOT_MENU)
        elseif j==2 then
            sName=strlower(HEALBOT_HBMENU)
        end
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
            button:SetAttribute(HB_prefix.."type"..j, "togglemenu")
        elseif strlower(sName)==strlower(HEALBOT_HBMENU) and UnitGUID(button.unit) then
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
        elseif HealBot_Spell_Names[sName] then
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
        HealBot_Action_SetButtonAttrib(button,"Left","Alt-Ctrl-Shift","Fixed",1)
        HealBot_Action_SetButtonAttrib(button,"Right","Alt-Ctrl-Shift","Fixed",2)
    end
end

function HealBot_Action_SetHealButton(unit,hbGUID,hbCurFrame,unitType)
    local shb=nil
    if hbGUID then
        shb=HealBot_Unit_Button[unit] or HealBot_Enemy_Button[unit] or HealBot_Pet_Button[unit] or HealBot_Action_CreateButton(hbCurFrame)
        if not shb then return nil end
        if shb.frame~=hbCurFrame then
            local gp=_G["f"..hbCurFrame.."_HealBot_Action"]
            shb:ClearAllPoints()
            shb:SetParent(gp)
            shb.frame=hbCurFrame
            HealBot_ResetBarSkinDone[shb.id]=nil
            HealBot_Panel_SetBarArrays(shb.id)
        end
        if shb.unit~=unit or shb.reset or shb.guid~=hbGUID then
            shb.reset=false
            shb.unit=unit
            shb.guid=hbGUID
            if unitType==9 then
                HealBot_Enemy_Button[unit]=shb
            elseif unitType>1 and unitType<4 then
                HealBot_Pet_Button[unit]=shb
            else
                HealBot_Unit_Button[unit]=shb
            end
            shb.status.unittype = unitType  -- 1=player  2=vehicle  3=pet  4=target  5=focus  6-8=reserved  9=enemy
            shb.checks.timed=GetTime() + HealBot_Action_luVars["updateDelay"]
            HealBot_Action_luVars["updateDelay"]=HealBot_Action_luVars["updateDelay"]+0.02
            if shb.status.offline and UnitIsConnected(unit) then
                shb.status.offline=false
            end
            shb:SetAttribute("unit", unit);
            HealBot_Action_ResetrCallsUnit(unit)
            HealBot_Action_SetAllButtonAttribs(shb,"Enemy")
            HealBot_Action_SetAllButtonAttribs(shb,"Enabled")
            HealBot_setUnitIcons(unit, hbGUID)
            HealBot_OnEvent_UnitHealth(shb)
            HealBot_HealsInUpdate(shb)
            HealBot_AbsorbsUpdate(shb)
            HealBot_Action_setHealthText(shb)
            HealBot_Action_setNameText(shb)
            HealBot_Action_HBText(shb)
            HealBot_Action_CheckUnitLowMana(shb)
            shb.update.unit=true
            shb.status.update=true
            shb.status.range=-9
            if UnitExists(unit) then
                if UnitIsFriend("player",unit) then 
                    HealBot_CheckPlayerMana(shb) 
                end
            end
        end
        if not shb.update.unit and Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][hbCurFrame]["CLASSONBAR"] then
            shb.update.roleicon=true
            shb.status.update=true
        end
        if not HealBot_ResetBarSkinDone[shb.id] then
            HealBot_Action_ResetSkin("bar",shb)
        end
        if unitType==1 or (unitType>3 and unitType<9) then
            HealBot_Action_luVars["updateBucket"]=HealBot_Action_luVars["updateBucket"]+1
            if HealBot_Action_luVars["updateBucket"]>4 then HealBot_Action_luVars["updateBucket"]=1 end
            shb.bucket=HealBot_Action_luVars["updateBucket"]
        else
            shb.bucket=1
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
        thb.guid="TestBar"
        HealBot_Action_ResetrCallsUnit(thb.unit)
        thb.status.bar4=0
        HealBot_Unit_Button[unitText]=thb
        if thb.frame~=hbCurFrame then
            local gp=_G["f"..hbCurFrame.."_HealBot_Action"]
            thb:ClearAllPoints()
            thb:SetParent(gp)
            thb.frame=hbCurFrame
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
    if not InCombatLockdown() and HealBot_Data["PGUID"] then
        if not HealBot_PreCombat and HealBot_Action_luVars["ResetAttribs"] then
            for _,xButton in pairs(HealBot_Unit_Button) do
                xButton.reset=true
            end
            for _,xButton in pairs(HealBot_Enemy_Button) do
                xButton.reset=true
            end
            for _,xButton in pairs(HealBot_Pet_Button) do
                xButton.reset=true
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
                HealBot_Action_MarkDeleteButton(xButton)
            end 
            for _,xButton in pairs(HealBot_Enemy_Button) do
                HealBot_Action_MarkDeleteButton(xButton)
            end 
            for _,xButton in pairs(HealBot_Pet_Button) do
                HealBot_Action_MarkDeleteButton(xButton)
            end 
            hbInitButtons=true
        end
        HealBot_Action_luVars["updateDelay"]=0
        HealBot_Panel_PartyChanged(HealBot_Data["UILOCK"], changeType)
    else
        HealBot_nextRecalcParty(changeType)
    end
end

function HealBot_Action_DeleterCallsUnit(unit)
    HealBot_Action_rCalls[unit]=nil
end

local function HealBot_Action_DeleteButton(hbBarID)
    local dg=_G["HealBot_Action_HealUnit"..hbBarID]
    local bar4=_G["HealBot_Action_HealUnit"..hbBarID.."Bar4"]
    dg.unit="nil"
    HealBot_Action_PrepButton(dg)
    HealBot_mark2clearGUID(dg.guid)
    HealBot_HoT_RemoveAllIconsButton(dg)
    HealBot_Action_SetBar3Value(dg)
    bar4:SetStatusBarColor(1,0,0,0)
    HealBot_ActiveButtons[hbBarID]=false
    if hbBarID<HealBot_ActiveButtons[0] then HealBot_ActiveButtons[0]=hbBarID end
    HealBot_Panel_SetBarArrays(hbBarID)
    --HealBot_AddDebug("Deleted button "..hbBarID)
end

HealBot_Action_luVars["PreCacheBars"]=1
local hbMarkedDeleteButtons={}
function HealBot_Action_DeleteMarkedButtons()
    if #hbMarkedDeleteButtons>50 then
        for i = 10, 1, -1 do
            HealBot_Action_DeleteButton(hbMarkedDeleteButtons[i])
            table.remove(hbMarkedDeleteButtons,i)
        end
    elseif hbMarkedDeleteButtons[1] then
        HealBot_Action_DeleteButton(hbMarkedDeleteButtons[1])
        table.remove(hbMarkedDeleteButtons,1)
    elseif HealBot_Action_luVars["PreCacheBars"]<HealBot_Globals.MaxBarsCache then
        HealBot_Action_luVars["PreCacheBars"]=HealBot_Action_luVars["PreCacheBars"]+1
        local gn="HealBot_Action_HealUnit"..HealBot_Action_luVars["PreCacheBars"]
        local ghb=_G[gn]
        if not ghb then 
            HealBot_ActiveButtons[HealBot_Action_luVars["PreCacheBars"]]=true
            local gp=_G["f10_HealBot_Action"]
            ghb=CreateFrame("Button", gn, gp, "HealBotButtonSecureTemplate") 
            ghb.id=HealBot_Action_luVars["PreCacheBars"]
            HealBot_Action_InitButton(ghb)
            ghb.frame=0
            ghb.guid="nil"
            ghb.unit="nil"
            HealBot_Action_MarkDeleteButton(ghb)
        end
    end
end

function HealBot_Action_MarkDeleteButton(button)
    button:Hide()
    button.status.bar4=0
    if HealBot_Unit_Button[button.unit] and HealBot_Unit_Button[button.unit]==button then HealBot_Unit_Button[button.unit]=nil end
    if HealBot_Enemy_Button[button.unit] and HealBot_Enemy_Button[button.unit]==button then HealBot_Enemy_Button[button.unit]=nil end
    if HealBot_Pet_Button[button.unit] and HealBot_Pet_Button[button.unit]==button then HealBot_Pet_Button[button.unit]=nil end
    table.insert(hbMarkedDeleteButtons, button.id)
end

function HealBot_Action_Reset()
    local screenWidth = (ceil(GetScreenWidth()/2)) or 700
    local screenHeight = (ceil(GetScreenHeight()/2)) or 500
    for i=1, 10 do
        Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][i]["X"]=(49+i)
        Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][i]["Y"]=(49+i)
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][i]["AUTOCLOSE"]=false
        if HealBot_Config.DisabledNow==0 and HealBot_FrameVisible[i] then
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

local hbFrameSetPoint={[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
local hbFrameGetCoords={[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
function HealBot_Action_DelayCheckFrameSetPoint(hbCurFrame, setPoint)
    if setPoint then
        hbFrameSetPoint[hbCurFrame]=true
    else
        hbFrameGetCoords[hbCurFrame]=true
    end
    HealBot_setLuVars("reCheckActionFrames", true)
end

function HealBot_Action_CheckFrameSetPoint()
    for x=1,10 do
        if hbFrameSetPoint[x] then
            hbFrameSetPoint[x]=false
            hbFrameGetCoords[x]=false
            HealBot_Action_setPoint(x)
        elseif hbFrameGetCoords[x] then
            hbFrameGetCoords[x]=false
            local cf=_G["f"..x.."_HealBot_Action"]
            HealBot_Action_CheckFrame(x, cf)
        end
    end
end

local hbStickyFrameGetCoords={[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
function HealBot_Action_CheckStuckFrames(hbCurFrame)
    for x=hbCurFrame,10 do
        if hbStickyFrameGetCoords[x] then
            local cf=_G["f"..x.."_HealBot_Action"]
            HealBot_Action_CheckFrame(x, cf)
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
    elseif HealBot_FrameVisible[hbCurFrame] then
        HealBot_Action_DelayCheckFrameSetPoint(hbCurFrame, false)
    end
  --HealBot_setCall("HealBot_CheckActionFrame")
end

function HealBot_Action_FrameSetPoint(hbCurFrame, gaf)
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
end

function HealBot_Action_setPoint(hbCurFrame)
    if not hbCurFrame then return end
    if not InCombatLockdown() then  -- not InCombatLockdown() -- not HealBot_Data["UILOCK"]
        local gaf=_G["f"..hbCurFrame.."_HealBot_Action"]
        HealBot_Action_CheckFrame(hbCurFrame, gaf)
        if not HealBot_Action_StickyFrame(hbCurFrame, gaf) then
            HealBot_Action_FrameSetPoint(hbCurFrame, gaf)
        end
        if hbCurFrame<10 then
            HealBot_Action_CheckStuckFrames(hbCurFrame)
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

local hideFrame={[1]=true,[2]=true,[3]=true,[4]=true,[5]=true,[6]=true,[7]=true,[8]=true,[9]=true,[10]=true}
function HealBot_Action_CheckHideFrames()
    for j=1,10 do
        hideFrame[j]=true
    end
    for _,xButton in pairs(HealBot_Unit_Button) do
        if xButton.status.enabled then
            hideFrame[xButton.frame]=false
            break
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
    for i=1, 10 do
        if Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][i]["AUTOCLOSE"] and HealBot_FrameVisible[i] and hideFrame[i] then
            HealBot_Action_HidePanel(i)
        end
    end
end

function HealBot_Action_ShowHideFrames(button)
    if Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][button.frame]["AUTOCLOSE"] then 
        if not HealBot_Data["UILOCK"] then
            if not HealBot_FrameVisible[button.frame] and HealBot_Config.DisabledNow==0 then
                if button.status.enabled then
                    HealBot_Action_ShowPanel(button.frame);
                end
            elseif HealBot_FrameVisible[button.frame] then
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
        elseif UnitAffectingCombat(self.unit) then
            HealBot_Data["TIPTYPE"] = "Enabled"
        elseif self.status.enabled or HealBot_Config.EnableHealthy then 
            HealBot_Data["TIPTYPE"] = "Enabled"
        elseif self.status.current<9 then
            HealBot_Data["TIPTYPE"] = "Disabled"
        end
        HealBot_Action_RefreshTooltip();
    end
    if Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][self.frame]["CBAR"] and not UnitIsDeadOrGhost(self.unit) and HealBot_retHighlightTarget()~=self.unit then
        local z=false
        if HealBot_Data["UILOCK"] then
            if Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][self.frame]["CBARCOMBAT"] then z=true end
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
    if self.aggro and Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][self.frame]["CBAR"] and self.aggro.status==-1 then
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
	elseif HEALBOT_GAME_VERSION>3 and CanExitVehicle() then	
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
    
    if HealBot_MouseWheelCmd==HEALBOT_HB_MENU then
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
        HealBot_Action_Toggle_Enabled(xUnit)
    elseif HealBot_MouseWheelCmd==HEALBOT_TOGGLE_MYTARGETS then
        HealBot_Panel_ToggelHealTarget(xButton.unit)
    elseif HealBot_MouseWheelCmd==HEALBOT_TOGGLE_PRIVATETANKS then
        HealBot_Panel_ToggelPrivateTanks(xButton.unit, false)
    elseif HealBot_MouseWheelCmd==HEALBOT_TOGGLE_PRIVATEHEALERS then
        HealBot_Panel_ToggelPrivateHealers(xButton.unit, false)
    elseif HealBot_MouseWheelCmd==HEALBOT_RESET_BAR then
        HealBot_Reset_Unit(xUnit)
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
    elseif HealBot_MouseWheelCmd==HEALBOT_EMOTE then
        DoEmote(HealBot_Globals.HealBot_Emotes[y], xUnit)
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
        if HealBot_Spell_Names[sName] then
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
    local xButton=self
    if self.id<999 and UnitExists(self.unit) and UnitIsFriend("player",self.unit) then
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
            elseif button=="LeftButton" and HealBot_Globals.SmartCast and not IsModifierKeyDown() and 
                   not HealBot_Data["UILOCK"] and not UnitAffectingCombat(self.unit) then
                HealBot_Action_UseSmartCast(xButton)
            end
        elseif IsShiftKeyDown() and IsControlKeyDown() and IsAltKeyDown() and button=="MiddleButton" then
            HealBot_Action_Toggle_Enabled(self.unit)
        elseif not HealBot_Data["UILOCK"] and not UnitAffectingCombat(self.unit) then
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

local function HealBot_Action_PostClick(self,button)
    if self.id==999 then
        HealBot_Panel_clickToFocus("hide")
        HealBot_nextRecalcParty(3)
    elseif UnitExists(self.unit) and UnitIsFriend("player",self.unit) and usedSmartCast then
        HealBot_Action_SetButtonAttrib(self,abutton,ModKey,"Enemy",aj)
        HealBot_Action_SetButtonAttrib(self,abutton,ModKey,"Enabled",aj)
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

local HealBot_AggroBarColr = {[1]= {[-2]=0.7, [-1]=1, [0]=1, [1]=1, [2]=1, [3]=1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},
                              [2]= {[-2]=0.7, [-1]=1, [0]=1, [1]=1, [2]=1, [3]=1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},
                              [3]= {[-2]=0.7, [-1]=1, [0]=1, [1]=1, [2]=1, [3]=1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},
                              [4]= {[-2]=0.7, [-1]=1, [0]=1, [1]=1, [2]=1, [3]=1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},
                              [5]= {[-2]=0.7, [-1]=1, [0]=1, [1]=1, [2]=1, [3]=1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},
                              [6]= {[-2]=0.7, [-1]=1, [0]=1, [1]=1, [2]=1, [3]=1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},
                              [7]= {[-2]=0.7, [-1]=1, [0]=1, [1]=1, [2]=1, [3]=1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},
                              [8]= {[-2]=0.7, [-1]=1, [0]=1, [1]=1, [2]=1, [3]=1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},
                              [9]= {[-2]=0.7, [-1]=1, [0]=1, [1]=1, [2]=1, [3]=1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},}
local HealBot_AggroBarColg = {[1]= {[-2]=0.7, [-1]=1, [0]=1, [1]=1, [2]=0.1, [3]=0.1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},
                              [2]= {[-2]=0.7, [-1]=1, [0]=1, [1]=1, [2]=0.1, [3]=0.1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},
                              [3]= {[-2]=0.7, [-1]=1, [0]=1, [1]=1, [2]=0.1, [3]=0.1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},
                              [4]= {[-2]=0.7, [-1]=1, [0]=1, [1]=1, [2]=0.1, [3]=0.1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},
                              [5]= {[-2]=0.7, [-1]=1, [0]=1, [1]=1, [2]=0.1, [3]=0.1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},
                              [6]= {[-2]=0.7, [-1]=1, [0]=1, [1]=1, [2]=0.1, [3]=0.1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},
                              [7]= {[-2]=0.7, [-1]=1, [0]=1, [1]=1, [2]=0.1, [3]=0.1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},
                              [8]= {[-2]=0.7, [-1]=1, [0]=1, [1]=1, [2]=0.1, [3]=0.1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},
                              [9]= {[-2]=0.7, [-1]=1, [0]=1, [1]=1, [2]=0.1, [3]=0.1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},}
local HealBot_AggroBarColb = {[1]= {[-2]=1, [-1]=1, [0]=0.4, [1]=0.2, [2]=0.1, [3]=0.1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},
                              [2]= {[-2]=1, [-1]=1, [0]=0.4, [1]=0.2, [2]=0.1, [3]=0.1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},
                              [3]= {[-2]=1, [-1]=1, [0]=0.4, [1]=0.2, [2]=0.1, [3]=0.1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},
                              [4]= {[-2]=1, [-1]=1, [0]=0.4, [1]=0.2, [2]=0.1, [3]=0.1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},
                              [5]= {[-2]=1, [-1]=1, [0]=0.4, [1]=0.2, [2]=0.1, [3]=0.1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},
                              [6]= {[-2]=1, [-1]=1, [0]=0.4, [1]=0.2, [2]=0.1, [3]=0.1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},
                              [7]= {[-2]=1, [-1]=1, [0]=0.4, [1]=0.2, [2]=0.1, [3]=0.1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},
                              [8]= {[-2]=1, [-1]=1, [0]=0.4, [1]=0.2, [2]=0.1, [3]=0.1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},
                              [9]= {[-2]=1, [-1]=1, [0]=0.4, [1]=0.2, [2]=0.1, [3]=0.1, [5]=1, [6]=1, [7]=1, [8]=1, [9]=1},}
local HealBot_AggroUnitThreat=1

function HealBot_Action_SetDebuffAggroCols()
    for j=1,9 do
        HealBot_AggroBarColr[j][5]=HealBot_Config_Cures.CDCBarColour[HEALBOT_DISEASE_en].R
        HealBot_AggroBarColg[j][5]=HealBot_Config_Cures.CDCBarColour[HEALBOT_DISEASE_en].G
        HealBot_AggroBarColb[j][5]=HealBot_Config_Cures.CDCBarColour[HEALBOT_DISEASE_en].B 
        HealBot_AggroBarColr[j][6]=HealBot_Config_Cures.CDCBarColour[HEALBOT_MAGIC_en].R
        HealBot_AggroBarColg[j][6]=HealBot_Config_Cures.CDCBarColour[HEALBOT_MAGIC_en].G
        HealBot_AggroBarColb[j][6]=HealBot_Config_Cures.CDCBarColour[HEALBOT_MAGIC_en].B 
        HealBot_AggroBarColr[j][7]=HealBot_Config_Cures.CDCBarColour[HEALBOT_POISON_en].R
        HealBot_AggroBarColg[j][7]=HealBot_Config_Cures.CDCBarColour[HEALBOT_POISON_en].G
        HealBot_AggroBarColb[j][7]=HealBot_Config_Cures.CDCBarColour[HEALBOT_POISON_en].B 
        HealBot_AggroBarColr[j][8]=HealBot_Config_Cures.CDCBarColour[HEALBOT_CURSE_en].R
        HealBot_AggroBarColg[j][8]=HealBot_Config_Cures.CDCBarColour[HEALBOT_CURSE_en].G
        HealBot_AggroBarColb[j][8]=HealBot_Config_Cures.CDCBarColour[HEALBOT_CURSE_en].B 
        HealBot_AggroBarColr[j][9]=HealBot_Globals.CDCBarColour[HEALBOT_CUSTOM_en.."15"].R
        HealBot_AggroBarColg[j][9]=HealBot_Globals.CDCBarColour[HEALBOT_CUSTOM_en.."15"].G
        HealBot_AggroBarColb[j][9]=HealBot_Globals.CDCBarColour[HEALBOT_CUSTOM_en.."15"].B
    end
end

function HealBot_Action_SetHightlightAggroCols()
    for j=1,9 do
        HealBot_AggroBarColr[j][-1]=Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][j]["CR"]
        HealBot_AggroBarColg[j][-1]=Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][j]["CG"]
        HealBot_AggroBarColb[j][-1]=Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][j]["CB"]
    end
end

function HealBot_Action_SetHightlightTargetAggroCols()
    for j=1,9 do
        HealBot_AggroBarColr[j][-2]=Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][j]["TR"]
        HealBot_AggroBarColg[j][-2]=Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][j]["TG"]
        HealBot_AggroBarColb[j][-2]=Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][j]["TB"]
    end
end

function HealBot_Action_SetAggroCols()
    for j=1,9 do
        HealBot_AggroBarColr[j][2]=Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][j]["R"]
        HealBot_AggroBarColg[j][2]=Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][j]["G"]
        HealBot_AggroBarColb[j][2]=Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][j]["B"]
        HealBot_AggroBarColr[j][3]=Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][j]["R"]
        HealBot_AggroBarColg[j][3]=Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][j]["G"]
        HealBot_AggroBarColb[j][3]=Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][j]["B"]
    end
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

local aFrameUpd={[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false}
local aAlpha={[1]=0.5,[2]=0.5,[3]=0.5,[4]=0.5,[5]=0.5,[6]=0.5,[7]=0.5,[8]=0.5,[9]=0.5}
local uaBar4,uaRGB=nil,nil
local function HealBot_Action_UpdateAggroBar(button)
    uaBar4=_G["HealBot_Action_HealUnit"..button.id.."Bar4"]
    if UnitExists(button.unit) and button.frame<10 then
        HealBot_AggroUnitThreat=button.aggro.status or 2
        if HealBot_AggroUnitThreat>4 and button.aura.debuff.name then
            if HealBot_Globals.CDCBarColour[button.aura.debuff.id] then
                uaBar4:SetStatusBarColor(HealBot_Globals.CDCBarColour[button.aura.debuff.id].R,
                                       HealBot_Globals.CDCBarColour[button.aura.debuff.id].G,
                                       HealBot_Globals.CDCBarColour[button.aura.debuff.id].B,aAlpha[button.frame])
            else
                uaRGB=HEALBOT_CUSTOM_en.."15"
                uaBar4:SetStatusBarColor(HealBot_Globals.CDCBarColour[uaRGB].R,
                                       HealBot_Globals.CDCBarColour[uaRGB].G,
                                       HealBot_Globals.CDCBarColour[uaRGB].B,aAlpha[button.frame])
            end
        elseif HealBot_AggroUnitThreat==4 and button.aura.buff.name then
            uaRGB=HealBot_retBuffWatch(button.aura.buff.name)
            if uaRGB and HealBot_Config_Buffs.HealBotBuffColR[uaRGB] then
                uaBar4:SetStatusBarColor(HealBot_Config_Buffs.HealBotBuffColR[uaRGB],
                                       HealBot_Config_Buffs.HealBotBuffColG[uaRGB],
                                       HealBot_Config_Buffs.HealBotBuffColB[uaRGB],aAlpha[button.frame])
            elseif HealBot_Globals.CustomBuffBarColour[button.aura.buff.id] then
                uaBar4:SetStatusBarColor(HealBot_Globals.CustomBuffBarColour[button.aura.buff.id].R,
                                       HealBot_Globals.CustomBuffBarColour[button.aura.buff.id].G,
                                       HealBot_Globals.CustomBuffBarColour[button.aura.buff.id].B,aAlpha[button.frame])
            
            else
                uaRGB=HEALBOT_CUSTOM_en.."Buff"
                uaBar4:SetStatusBarColor(HealBot_Globals.CustomBuffBarColour[uaRGB].R,
                                       HealBot_Globals.CustomBuffBarColour[uaRGB].G,
                                       HealBot_Globals.CustomBuffBarColour[uaRGB].B,aAlpha[button.frame])
            end
        else
            uaBar4:SetStatusBarColor(HealBot_AggroBarColr[button.frame][HealBot_AggroUnitThreat],
                                   HealBot_AggroBarColg[button.frame][HealBot_AggroUnitThreat],
                                   HealBot_AggroBarColb[button.frame][HealBot_AggroUnitThreat],
                                   aAlpha[button.frame])
        end
        HealBot_Action_luVars["UpdatedAggroBars"]=true
        aFrameUpd[button.frame]=true
    elseif bar4 then
        bar4:SetStatusBarColor(1,0,0,0)
        button.status.bar4=0
    end
end

local function HealBot_Action_UpdateAggroBars()
    for j=1,9 do
        aFrameUpd[j]=false
    end
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
    for j=1,9 do
        if aFrameUpd[j] then
            if HealBot_Action_luVars["AggroBarUp"] then
                aAlpha[j]=aAlpha[j]+0.04+Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][j]["FREQ"]
                if aAlpha[j]>=Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][j]["MAXA"] then
                    HealBot_Action_luVars["AggroBarUp"]=false
                    aAlpha[j]=Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][j]["MAXA"]
                end
            else
                aAlpha[j]=aAlpha[j]-0.04-Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][j]["FREQ"]
                if aAlpha[j]<=Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][j]["MINA"] then
                    HealBot_Action_luVars["AggroBarUp"]=true
                    aAlpha[j]=Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][j]["MINA"]
                end
            end
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
    HealBot_FrameVisible[hbCurFrame]=true
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
    HealBot_DoAction_ResetSkin("frameheader",nil,hbCurFrame)
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

function HealBot_Action_OnHide(self, hbCurFrame)
    HealBot_FrameVisible[hbCurFrame]=false
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

function HealBot_Action_Toggle_Enabled(unit)
    local xGUID=UnitGUID(unit)
    if HealBot_AlwaysEnabled[xGUID] then
        HealBot_AlwaysEnabled[xGUID]=nil
    else
        HealBot_AlwaysEnabled[xGUID]=true
    end
    HealBot_setOptions_Timer(80)
end

function HealBot_Action_AlwaysEnabled(hbGUID)
    return HealBot_AlwaysEnabled[hbGUID]
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
        local h=25
        if HEALBOT_GAME_VERSION<4 then h=10 end
        if x>(UnitLevel("player")*h) then
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

function HealBot_Action_StickyFrameSetPoint(hbCurFrame,stuckTo,stuckPoint,stuckToPoint,HBframe,cf)
    hbStickyFrameGetCoords[hbCurFrame]=true
    local x,y=0,0
    if (stuckPoint=="BOTTOMLEFT" or stuckPoint=="BOTTOM" or stuckPoint=="BOTTOMRIGHT") and
       (stuckToPoint=="TOPLEFT" or stuckToPoint=="TOP" or stuckToPoint=="TOPRIGHT") then
        if Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][stuckTo]["SHOW"] then
            y=Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][stuckTo]["HEIGHT"]
        end
    elseif (stuckToPoint=="BOTTOMLEFT" or stuckToPoint=="BOTTOM" or stuckToPoint=="BOTTOMRIGHT") and
           (stuckPoint=="TOPLEFT" or stuckPoint=="TOP" or stuckPoint=="TOPRIGHT") then
        if Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][hbCurFrame]["SHOW"] then
            y=0-Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][hbCurFrame]["HEIGHT"]
        end
    end
    x=x+Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][hbCurFrame]["SFOFFSETH"]
    y=y+Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][hbCurFrame]["SFOFFSETV"]
    HBframe:ClearAllPoints();
    HBframe:SetPoint(stuckPoint,cf,stuckToPoint,x,y)
    local OptionsUpdate=false
    if stuckPoint=="TOPLEFT" and Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]~=1 then
        Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]=1
        OptionsUpdate=true
    elseif stuckPoint=="BOTTOMLEFT" and Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]~=2 then
        Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]=2
        OptionsUpdate=true
    elseif stuckPoint=="TOPRIGHT" and Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]~=3 then
        Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]=3
        OptionsUpdate=true
    elseif stuckPoint=="BOTTOMRIGHT" and Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]~=4 then
        Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]=4
        OptionsUpdate=true
    elseif stuckPoint=="TOP" and Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]~=5 then
        Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]=5
        OptionsUpdate=true
    elseif stuckPoint=="LEFT" and Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]~=6 then
        Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]=6
        OptionsUpdate=true
    elseif stuckPoint=="RIGHT" and Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]~=7 then
        Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]=7
        OptionsUpdate=true
    elseif stuckPoint=="BOTTOM" and Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]~=8 then
        Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]=8
        OptionsUpdate=true
    end
    if OptionsUpdate then
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

function HealBot_Action_StickyFrame(hbCurFrame, HBframe)
    local isSticky=false
    if Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["STICKYFRAME"] and hbCurFrame>1 then
        if Healbot_Config_Skins.StickyFrames[Healbot_Config_Skins.Current_Skin][hbCurFrame]["STUCK"] and
           HealBot_FrameVisible[Healbot_Config_Skins.StickyFrames[Healbot_Config_Skins.Current_Skin][hbCurFrame]["STUCKTO"]] then
            local cf=_G["f"..Healbot_Config_Skins.StickyFrames[Healbot_Config_Skins.Current_Skin][hbCurFrame]["STUCKTO"].."_HealBot_Action"]
            HealBot_Action_StickyFrameSetPoint(hbCurFrame,
                                               Healbot_Config_Skins.StickyFrames[Healbot_Config_Skins.Current_Skin][hbCurFrame]["STUCKTO"],
                                               Healbot_Config_Skins.StickyFrames[Healbot_Config_Skins.Current_Skin][hbCurFrame]["STUCKPOINT"],
                                               Healbot_Config_Skins.StickyFrames[Healbot_Config_Skins.Current_Skin][hbCurFrame]["STUCKTOPOINT"],
                                               HBframe,
                                               cf)
            isSticky=true
        elseif HBframe:GetLeft() then
            local left=HBframe:GetLeft()
            local right=HBframe:GetRight()
            local top=HBframe:GetTop()
            local bottom=HBframe:GetBottom()
            local sfSensitivity=Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["STICKYSENSITIVITY"]
            for x=1,hbCurFrame-1 do
                if HealBot_FrameVisible[x] then
                    local cf=_G["f"..x.."_HealBot_Action"]
                    if cf:GetLeft() then
                        if cf:GetLeft()>(right-sfSensitivity) and cf:GetLeft()<(right+sfSensitivity) and
                           cf:GetTop()>(top-sfSensitivity) and cf:GetTop()<(top+sfSensitivity) then
                            HealBot_Action_StickyFrameStuckTo(hbCurFrame,x,"TOPRIGHT","TOPLEFT",HBframe,cf)
                            isSticky=true
                            break
                        elseif cf:GetLeft()>(left-sfSensitivity) and cf:GetLeft()<(left+sfSensitivity) and
                           cf:GetTop()>(bottom-sfSensitivity) and cf:GetTop()<(bottom+sfSensitivity) then
                            HealBot_Action_StickyFrameStuckTo(hbCurFrame,x,"BOTTOMLEFT","TOPLEFT",HBframe,cf)
                            isSticky=true
                            break
                        elseif cf:GetRight()>(right-sfSensitivity) and cf:GetRight()<(right+sfSensitivity) and
                           cf:GetTop()>(bottom-sfSensitivity) and cf:GetTop()<(bottom+sfSensitivity) then
                            HealBot_Action_StickyFrameStuckTo(hbCurFrame,x,"BOTTOMRIGHT","TOPRIGHT",HBframe,cf)
                            isSticky=true
                            break
                        elseif cf:GetRight()>(left-sfSensitivity) and cf:GetRight()<(left+sfSensitivity) and
                           cf:GetTop()>(top-sfSensitivity) and cf:GetTop()<(top+sfSensitivity) then
                            HealBot_Action_StickyFrameStuckTo(hbCurFrame,x,"TOPLEFT","TOPRIGHT",HBframe,cf)
                            isSticky=true
                            break
                        elseif cf:GetRight()>(left-sfSensitivity) and cf:GetRight()<(left+sfSensitivity) and
                           cf:GetBottom()>(bottom-sfSensitivity) and cf:GetBottom()<(bottom+sfSensitivity) then
                            HealBot_Action_StickyFrameStuckTo(hbCurFrame,x,"BOTTOMLEFT","BOTTOMRIGHT",HBframe,cf)
                            isSticky=true
                            break
                        elseif cf:GetRight()>(right-sfSensitivity) and cf:GetRight()<(right+sfSensitivity) and
                           cf:GetBottom()>(top-sfSensitivity) and cf:GetBottom()<(top+sfSensitivity) then
                            HealBot_Action_StickyFrameStuckTo(hbCurFrame,x,"TOPRIGHT","BOTTOMRIGHT",HBframe,cf)
                            isSticky=true
                            break
                        elseif cf:GetLeft()>(left-sfSensitivity) and cf:GetLeft()<(left+sfSensitivity) and
                           cf:GetBottom()>(top-sfSensitivity) and cf:GetBottom()<(top+sfSensitivity) then
                            HealBot_Action_StickyFrameStuckTo(hbCurFrame,x,"TOPLEFT","BOTTOMLEFT",HBframe,cf)
                            isSticky=true
                            break
                        elseif cf:GetLeft()>(right-sfSensitivity) and cf:GetLeft()<(right+sfSensitivity) and
                           cf:GetBottom()>(bottom-sfSensitivity) and cf:GetBottom()<(bottom+sfSensitivity) then
                            HealBot_Action_StickyFrameStuckTo(hbCurFrame,x,"BOTTOMRIGHT","BOTTOMLEFT",HBframe,cf)
                            isSticky=true
                            break
                        elseif cf:GetTop()>(bottom-sfSensitivity) and cf:GetTop()<(bottom+sfSensitivity) and
                               ((cf:GetLeft()+cf:GetRight())/2)>(((left+right)/2)-sfSensitivity) and
                               ((cf:GetLeft()+cf:GetRight())/2)<(((left+right)/2)+sfSensitivity) then
                            HealBot_Action_StickyFrameStuckTo(hbCurFrame,x,"BOTTOM","TOP",HBframe,cf)
                            isSticky=true
                            break
                        elseif cf:GetBottom()>(top-sfSensitivity) and cf:GetBottom()<(top+sfSensitivity) and
                               ((cf:GetLeft()+cf:GetRight())/2)>(((left+right)/2)-sfSensitivity) and
                               ((cf:GetLeft()+cf:GetRight())/2)<(((left+right)/2)+sfSensitivity) then
                            HealBot_Action_StickyFrameStuckTo(hbCurFrame,x,"TOP","BOTTOM",HBframe,cf)
                            isSticky=true
                            break
                        elseif cf:GetLeft()>(right-sfSensitivity) and cf:GetLeft()<(right+sfSensitivity) and
                               ((cf:GetTop()+cf:GetBottom())/2)>(((top+bottom)/2)-sfSensitivity) and
                               ((cf:GetTop()+cf:GetBottom())/2)<(((top+bottom)/2)+sfSensitivity) then
                            HealBot_Action_StickyFrameStuckTo(hbCurFrame,x,"RIGHT","LEFT",HBframe,cf)
                            isSticky=true
                            break
                        elseif cf:GetRight()>(left-sfSensitivity) and cf:GetRight()<(left+sfSensitivity) and
                               ((cf:GetTop()+cf:GetBottom())/2)>(((top+bottom)/2)-sfSensitivity) and
                               ((cf:GetTop()+cf:GetBottom())/2)<(((top+bottom)/2)+sfSensitivity) then
                            HealBot_Action_StickyFrameStuckTo(hbCurFrame,x,"LEFT","RIGHT",HBframe,cf)
                            isSticky=true
                            break
                        end
                    end
                end
            end
        else
            HealBot_setOptions_Timer(2000+hbCurFrame) -- Came back with coords
        end
        if not isSticky then
            hbStickyFrameGetCoords[hbCurFrame]=false
        end
        HealBot_Options_ActionAnchor_SetAlpha(hbCurFrame)
    end
    return isSticky
end