--[[ HealBot Continued ]]

local HealBot_UnitBuffIcons={}
local HealBot_UnitDebuffIcons={};
local HealBot_Watch_HoT={};
local HealBot_SmartCast_Spells={};
local HealBot_DebugMsg={};
local HealBot_markedGUIDs={}
local HealBot_SpamCut={}
local HealBot_Vers={}
local strfind=strfind
local strsub=strsub
local gsub=gsub
local HealBot_ReCheckBuffsTime=nil
local HealBot_ReCheckBuffsTimed={}
local HealBot_Ignore_Debuffs = {["Class"]={},["Movement"]={},["NonHarmful"]={},};
local HealBot_Timers={["HB1Inc"]=0,["HB1Th"]=0.01,["HB2Inc"]=0,["HB2Th"]=0.1,["HBaInc"]=0,["HBaTh"]=0.05,["CheckTimeMod"]=0.1}
local arrg = {}
local PlayerBuffs = {}
local PlayerBuffTypes = {}
local LSM = LibStub and LibStub:GetLibrary("LibSharedMedia-3.0", true)
for i = 1, #HealBot_Default_Textures do
    LSM:Register("statusbar", HealBot_Default_Textures[i].name, HealBot_Default_Textures[i].file)
end
for i = 1, #HealBot_Default_Sounds do
    LSM:Register("sound", HealBot_Default_Sounds[i].name, HealBot_Default_Sounds[i].file)
end
for i = 1, #HealBot_Default_Fonts do
    LSM:Register("font", HealBot_Default_Fonts[i].name, HealBot_Default_Fonts[i].file)
end
local LDB11 = LibStub("LibDataBroker-1.1", true)
local LDBIcon = LibStub("LibDBIcon-1.0", true)
local HealBot_PlayerBuff={}
local HealBot_CheckBuffs = {}
local HealBot_ShortBuffs = {}
local HealBot_BuffWatch={}
local CooldownBuffs={}
local debuffCodes={ [HEALBOT_DISEASE_en]=5, [HEALBOT_MAGIC_en]=6, [HEALBOT_POISON_en]=7, [HEALBOT_CURSE_en]=8, [HEALBOT_CUSTOM_en]=9}
local HealBot_VehicleUnit={}
local HealBot_UnitInVehicle={}
local HealBot_TargetIcons={}
local HealBot_notVisible={}
local HealBot_CustomDebuff_RevDurLast={}
local hbManaPlayers={}
local hbShareSkins={}
local HealBot_trackHiddenFrames={}
local _
local HealBot_Buff_ItemID={};
local HealBot_Buff_Aura2Item={};
local HealBot_RefreshTypes={[0]=true,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false}
local UnitBuffIcons=nil
local UnitDebuffIcons=nil
local TimeNow=GetTime()
local HealBot_luVars={}
HealBot_luVars["shareSkinsSent"]=0
HealBot_luVars["hbInsName"]=HEALBOT_WORD_OUTSIDE
HealBot_luVars["TargetUnitID"]="player"
HealBot_luVars["qaFR"]=100
HealBot_luVars["qaFR1"]=80
HealBot_luVars["qaFR2"]=80
HealBot_luVars["qaFR3"]=80
HealBot_luVars["IsSolo"]=true
HealBot_luVars["MaskAuraDCheck"]=TimeNow
HealBot_luVars["ReloadUI"]=0
HealBot_luVars["MessageReloadUI"]=0
HealBot_luVars["slowSwitch"]=0
HealBot_luVars["fastSwitch"]=0
HealBot_luVars["RangeCheckTime"]=TimeNow+1
HealBot_luVars["OtherCheckTime"]=TimeNow+2
HealBot_luVars["EnemyCheckTime"]=TimeNow+1.5
HealBot_luVars["PetRangeCheckTime"]=TimeNow+1.2
HealBot_luVars["hbLoaded"]=false
HealBot_luVars["VersionRequest"]=false
HealBot_luVars["ResetFlag"]=false
HealBot_luVars["CheckPlayerBuffsGUID"]=false
HealBot_luVars["CheckPlayerBuffsTime"]=false
HealBot_luVars["AddonMsgType"]=3
HealBot_luVars["CheckTalents"]=true
HealBot_luVars["Checks"]=true
HealBot_luVars["CastingTarget"]="player"
HealBot_luVars["27YardsOnly"]=false
HealBot_luVars["NumPlayers"]=0
HealBot_luVars["TargetNeedReset"]=true
HealBot_luVars["FocusNeedReset"]=true
HealBot_luVars["SoftResetAfterCombat"]=false
HealBot_luVars["VehicleType"]=1
HealBot_luVars["PetType"]=2
HealBot_luVars["Timer8000"]=0
HealBot_luVars["TankUnit"]="x"
HealBot_luVars["HealBot_Refresh"]=true
HealBot_luVars["healthFactor"]=1
HealBot_luVars["targetSpec"]=" "
HealBot_luVars["clearGUID"]=false
    
local HealBot_Calls={}
HealBot_luVars["MaxCount"]=0
function HealBot_setCall(Caller)
    if not HealBot_Calls[Caller] then 
        HealBot_Calls[Caller]={}
        HealBot_Calls[Caller].count=0
    end
    HealBot_Calls[Caller].count=HealBot_Calls[Caller].count+1
    if HealBot_luVars["MaxCount"]<HealBot_Calls[Caller].count then
        HealBot_luVars["MaxCount"]=HealBot_Calls[Caller].count
        HealBot_luVars["MaxCountName"]=Caller
    end
end

function HealBot_reportCalls()
    if HealBot_luVars["MaxCountName"] then HealBot_AddDebug("High Count:"..HealBot_luVars["MaxCountName"].."="..HealBot_luVars["MaxCount"]) end
end

function HealBot_retCalls()
    return HealBot_Calls
end

function HealBot_needRecalcParty()
    HealBot_luVars["HealBot_Refresh"]=false
    for r=0,5 do
        if HealBot_RefreshTypes[r] then
            HealBot_luVars["HealBot_Refresh"]=true
            break
        end
    end
  --HealBot_setCall("HealBot_needRecalcParty")
end

function HealBot_nextRecalcParty(typeRequired)
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["FRAME"]<7 and HealBot_luVars["PetType"]~=6 then HealBot_Action_HidePanel(7) end
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["FRAME"]<6 and HealBot_luVars["VehicleType"]~=6 then HealBot_Action_HidePanel(6) end
    if typeRequired==2 then
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["FRAME"]<7 then
            typeRequired=6
        end
        HealBot_luVars["PetType"]=typeRequired
    elseif typeRequired==1 then
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["FRAME"]<6 then
            typeRequired=6
        end 
        HealBot_luVars["VehicleType"]=typeRequired
    end
    if typeRequired==2 and Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["SELFPET"]==1 then
        HealBot_nextRecalcParty(6)
    end
    HealBot_RefreshTypes[typeRequired]=true
    HealBot_luVars["HealBot_Refresh"]=true
  --HealBot_setCall("HealBot_nextRecalcParty")
end

local function HealBot_InitVars()
    CooldownBuffs={[HEALBOT_FEAR_WARD]=true, 
                   [HEALBOT_PAIN_SUPPRESSION]=true, 
                   [HEALBOT_POWER_INFUSION]=true,}
    HealBot_Ignore_Debuffs["NonHarmful"] = {[HEALBOT_DEBUFF_MAJOR_DREAMLESS] = true,
                                            [HEALBOT_DEBUFF_GREATER_DREAMLESS] = true,
                                            [HEALBOT_DEBUFF_DREAMLESS_SLEEP] = true,
                                            [HEALBOT_DEBUFF_SHATTERED_DEFENSES] = true,
                                            [HEALBOT_DEBUFF_OVERWHELMING_POWER] = true,};
    HealBot_Ignore_Debuffs["Movement"] = {[HEALBOT_DEBUFF_FROSTBOLT] = true,
                                          [HEALBOT_DEBUFF_MAGMA_SHACKLES] = true,
                                          [HEALBOT_DEBUFF_SLOW] = true,
                                          [HEALBOT_DEBUFF_CHILLED] = true,
                                          [HEALBOT_DEBUFF_CONEOFCOLD] = true,
                                          [HEALBOT_DEBUFF_FROST_SHOCK] = true,
                                          [HEALBOT_DEBUFF_EARTHBIND] = true,
                                          [HEALBOT_DEBUFF_SEAL_OF_JUSTICE] = true,};
    HealBot_Ignore_Debuffs["Class"] = {
        ["WARR"] = { [HEALBOT_DEBUFF_IGNITE_MANA] = true, 
                     [HEALBOT_DEBUFF_TAINTED_MIND] = true, 
                     [HEALBOT_DEBUFF_VIPER_STING] = true,
                     [HEALBOT_DEBUFF_CURSE_OF_IMPOTENCE] = true,
                     [HEALBOT_DEBUFF_DECAYED_INTELLECT] = true,
                     [HEALBOT_DEBUFF_TRAMPLE] = true,
                     [HEALBOT_DEBUFF_UNSTABLE_AFFLICTION] = true,
					 [HEALBOT_DEBUFF_VAMPIRIC_TOUCH] = true,},
        ["ROGU"] = { [HEALBOT_DEBUFF_SILENCE] = true,    
                     [HEALBOT_DEBUFF_IGNITE_MANA] = true, 
                     [HEALBOT_DEBUFF_TAINTED_MIND] = true, 
                     [HEALBOT_DEBUFF_VIPER_STING] = true,
                     [HEALBOT_DEBUFF_CURSE_OF_IMPOTENCE] = true,
                     [HEALBOT_DEBUFF_DECAYED_INTELLECT] = true,
                     [HEALBOT_DEBUFF_TRAMPLE] = true,
                     [HEALBOT_DEBUFF_UNSTABLE_AFFLICTION] = true,
					 [HEALBOT_DEBUFF_VAMPIRIC_TOUCH] = true,},
        ["HUNT"] = { [HEALBOT_DEBUFF_UNSTABLE_AFFLICTION] = true,
					 [HEALBOT_DEBUFF_VAMPIRIC_TOUCH] = true,},	
        ["MAGE"] = { [HEALBOT_DEBUFF_DECAYED_STRENGHT] = true,
                     [HEALBOT_DEBUFF_UNSTABLE_AFFLICTION] = true,
					 [HEALBOT_DEBUFF_VAMPIRIC_TOUCH] = true,},
        ["DRUI"] = { [HEALBOT_DEBUFF_UNSTABLE_AFFLICTION] = true,
					 [HEALBOT_DEBUFF_VAMPIRIC_TOUCH] = true,},
        ["PALA"] = { [HEALBOT_DEBUFF_UNSTABLE_AFFLICTION] = true,
					 [HEALBOT_DEBUFF_VAMPIRIC_TOUCH] = true,},
        ["PRIE"] = { [HEALBOT_DEBUFF_DECAYED_STRENGHT] = true,
                     [HEALBOT_DEBUFF_UNSTABLE_AFFLICTION] = true,
					 [HEALBOT_DEBUFF_VAMPIRIC_TOUCH] = true,},
        ["SHAM"] = { [HEALBOT_DEBUFF_UNSTABLE_AFFLICTION] = true,
					 [HEALBOT_DEBUFF_VAMPIRIC_TOUCH] = true,},
        ["WARL"] = { [HEALBOT_DEBUFF_DECAYED_STRENGHT] = true,
                     [HEALBOT_DEBUFF_UNSTABLE_AFFLICTION] = true,
					 [HEALBOT_DEBUFF_VAMPIRIC_TOUCH] = true,},
        ["DEAT"] = { [HEALBOT_DEBUFF_DECAYED_INTELLECT] = true,
                     [HEALBOT_DEBUFF_TRAMPLE] = true,
                     [HEALBOT_DEBUFF_UNSTABLE_AFFLICTION] = true,
					 [HEALBOT_DEBUFF_VAMPIRIC_TOUCH] = true,},
        ["MONK"] = { [HEALBOT_DEBUFF_UNSTABLE_AFFLICTION] = true,
					 [HEALBOT_DEBUFF_VAMPIRIC_TOUCH] = true,},	
        ["DEMO"] = { [HEALBOT_DEBUFF_UNSTABLE_AFFLICTION] = true,
					 [HEALBOT_DEBUFF_VAMPIRIC_TOUCH] = true,},
    };
    HealBot_Buff_ItemID = {
        [HEALBOT_ORALIUS_WHISPERING_CRYSTAL] = 118922,
        [HEALBOT_EVER_BLOOMING_FROND] = 118935,
        [HEALBOT_REPURPOSED_FEL_FOCUSER] = 147707,
        [HEALBOT_BATTLE_SCARRED_AUGMENT_RUNE] = 160053,
        [HEALBOT_TAILWIND_SAPPHIRE] = 284567,
        [HEALBOT_AMETHYST_OF_THE_SHADOW_KING] = 284558,
    };
    HealBot_Buff_Aura2Item = {
        [HEALBOT_WHISPERS_OF_INSANITY] = HEALBOT_ORALIUS_WHISPERING_CRYSTAL,
        [HEALBOT_BLOOM] = HEALBOT_EVER_BLOOMING_FROND,
        [HEALBOT_FEL_FOCUS] = HEALBOT_REPURPOSED_FEL_FOCUSER,
        [HEALBOT_BATTLE_SCARRED_AUGMENT] = HEALBOT_BATTLE_SCARRED_AUGMENT_RUNE,
        [HEALBOT_TAILWIND] = HEALBOT_TAILWIND_SAPPHIRE,
        [HEALBOT_SHADOW_TOUCHED] = HEALBOT_AMETHYST_OF_THE_SHADOW_KING,
    };
  --HealBot_setCall("HealBot_InitVars")
end

function HealBot_retLSM()
  --HealBot_setCall("HealBot_retLSM")
    return LSM
end

function HealBot_MessageReloadUI(limit)
    if not HealBot_Data["UILOCK"] then
        HealBot_luVars["MessageReloadUI"]=0
        HealBot_luVars["ReloadUI"]=GetTime()+limit
    else
        HealBot_luVars["MessageReloadUI"]=limit
    end
  --HealBot_setCall("HealBot_MessageReloadUI")
end

function HealBot_setLuVars(vName, vValue)
    HealBot_luVars[vName]=vValue
  --HealBot_setCall("HealBot_setLuVars")
end

function HealBot_retLuVars(vName)
  --HealBot_setCall("HealBot_retLuVars")
    return HealBot_luVars[vName]
end

function HealBot_setNotVisible(hbGUID,unit)
    HealBot_notVisible[hbGUID]=unit
  --HealBot_setCall("HealBot_setNotVisible")
end

function HealBot_Clear_BuffWatch()
    for x,_ in pairs(HealBot_BuffWatch) do
        HealBot_BuffWatch[x]=nil;
    end
  --HealBot_setCall("HealBot_Clear_BuffWatch")
end

function HealBot_Set_BuffWatch(buffName)
    table.insert(HealBot_BuffWatch,buffName);
  --HealBot_setCall("HealBot_Set_BuffWatch")
end

function HealBot_Clear_CheckBuffs()
    for x,_ in pairs(HealBot_CheckBuffs) do
        HealBot_CheckBuffs[x]=nil;
    end
  --HealBot_setCall("HealBot_Clear_CheckBuffs")
end

function HealBot_Set_CheckBuffs(buffName)
    if not CooldownBuffs[buffName] and not HealBot_CheckBuffs[buffName] then
        HealBot_CheckBuffs[buffName]=true;
    end
  --HealBot_setCall("HealBot_Set_CheckBuffs")
end

function HealBot_RetMyBuffTime(hbGUID,buffName)
    if not HealBot_PlayerBuff[hbGUID] or not HealBot_PlayerBuff[hbGUID][buffName] then return end
    if HealBot_ShortBuffs[buffName] then
        return HealBot_PlayerBuff[hbGUID][buffName]+HealBot_Config_Buffs.ShortBuffTimer
    else
        return HealBot_PlayerBuff[hbGUID][buffName]+HealBot_Config_Buffs.LongBuffTimer
    end
  --HealBot_setCall("HealBot_RetMyBuffTime")
end

function HealBot_cpSave(mName, mBody)
    local perCharacter = 1
    if Healbot_Config_Skins.Protection[Healbot_Config_Skins.Current_Skin]["GENERALMACRO"] then
        perCharacter = nil
    end
    local z=GetMacroIndexByName(mName)
    if (z or 0) == 0 then
        z = CreateMacro(mName, "Spell_Holy_SealOfSacrifice", mBody, perCharacter)
    else
        z = EditMacro(z, mName, "Spell_Holy_SealOfSacrifice", mBody)
    end
    HBmsg=HEALBOT_CP_MACRO_SAVE.."   "..date("%H:%M:%S", time())
    HealBot_Options_cpMacroSave:SetText(HBmsg)
    HealBot_Options_SetcpMacroSave(HBmsg)
  --HealBot_setCall("HealBot_cpSave")
end

function HealBot_SetResetFlag(mode)
    if mode=="HARD" then
        ReloadUI()
    elseif mode=="SOFT" then
        HealBot_setResetFlagCode(1)
        HealBot_AddDebug("Calling soft reset") 
    else
        HealBot_setResetFlagCode(4)
        HealBot_AddDebug("Calling quick reset")
    end
  --HealBot_setCall("HealBot_SetResetFlag")
end

function HealBot_TooltipInit()
    if ( HealBot_ScanTooltip:IsOwned(HealBot) ) then return; end;
    HealBot_ScanTooltip:SetOwner(HealBot, 'ANCHOR_NONE' );
    HealBot_ScanTooltip:ClearLines();
  --HealBot_setCall("HealBot_TooltipInit")
end

function HealBot_AddChat(HBmsg)
    DEFAULT_CHAT_FRAME:AddMessage(HBmsg, 0.7, 0.7, 1.0);
  --HealBot_setCall("HealBot_AddChat")
end

function HealBot_AddDebug(HBmsg)
    if HBmsg and (HealBot_SpamCut[HBmsg] or 0)<GetTime() then
        HealBot_SpamCut[HBmsg]=GetTime()+1        
        HBmsg="["..date("%H:%M", time()).."] DEBUG: "..HBmsg;
        table.insert(HealBot_DebugMsg,HBmsg)
    end
  --HealBot_setCall("HealBot_AddDebug")
end

function HealBot_TogglePanel(HBpanel)
    if not HBpanel then return end
    if ( HBpanel:IsVisible() ) then
        HideUIPanel(HBpanel);
    else
        ShowUIPanel(HBpanel);
    end
  --HealBot_setCall("HealBot_TogglePanel")
end

function HealBot_StartMoving(HBframe)
    if ( not HBframe.isMoving ) and ( HBframe.isLocked ~= 1 ) then
        HBframe:StartMoving();
        HBframe.isMoving = true;
    end
  --HealBot_setCall("HealBot_StartMoving")
end

function HealBot_StopMoving(HBframe,hbCurFrame)
    if ( HBframe.isMoving ) then
        HBframe:StopMovingOrSizing();
        HBframe.isMoving = false;
    end
    if hbCurFrame then
        HealBot_CheckActionFrame(HBframe,hbCurFrame)
    end
  --HealBot_setCall("HealBot_StopMoving")
end

function HealBot_CheckActionFrame(HBframe,hbCurFrame)
    if HealBot_Config.DisabledNow==1 then return end
    if HBframe:IsVisible() and HBframe:GetTop() then
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
        HealBot_Action_setPoint(hbCurFrame)
    end
  --HealBot_setCall("HealBot_CheckActionFrame")
end

function HealBot_CheckFrame(hbCurFrame, HBframe)
    if HealBot_Config.DisabledNow==1 then return end
    local wPct=HealBot_Comm_round(((Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][hbCurFrame]["WIDTH"]/GetScreenWidth())*100),2)
    local hPct=HealBot_Comm_round(((Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][hbCurFrame]["HEIGHT"]/GetScreenHeight())*100),2)
    if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==1 then
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]<0.01 then 
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]=0.01
        elseif (Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]+wPct)>100 then
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]=100-wPct
        end
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]<hPct then
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]=hPct
        elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]>100 then
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]=100
        end
    elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==2 then
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]<0.01 then 
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]=0.01
        elseif (Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]+wPct)>100 then
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]=100-wPct
        end
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]<0.01 then
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]=0.01
        elseif (Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]+hPct)>100 then
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]=100-hPct
        end
    elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==3 then
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]<wPct then 
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]=wPct
        elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]>100 then
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]=100
        end
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]<hPct then
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]=hPct
        elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]>100 then
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]=100
        end
    elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==4 then
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]<wPct then 
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]=wPct
        elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]>100 then
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]=100
        end
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]<0.01 then
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]=0.01
        elseif (Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]+hPct)>100 then
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]=100-hPct
        end
    elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==5 then
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]<0.01 then 
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]=0.01
        elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]>100 then
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]=100
        end
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]<hPct then
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]=hPct
        elseif (Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"])>100 then
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]=100
        end
    elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==6 then
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]<0.01 then 
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]=0.01
        elseif (Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]+wPct)>100 then
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]=100-wPct
        end
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]<0.01 then
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]=0.01 
        elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]>100 then
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]=100
        end
    elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==7 then
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]<wPct then 
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]=wPct
        elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]>100 then
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]=100
        end
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]<0.01 then
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]=0.01 
        elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]>100 then
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]=100
        end
    elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["FRAME"]==8 then
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]<0.01 then 
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]=0.01
        elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]>100 then
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["X"]=100
        end
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]<0.01 then
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]=0.01
        elseif (Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]+hPct)>100 then
            Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["Y"]=100-hPct
        end
    end
  --HealBot_setCall("HealBot_CheckFrame")
end

function HealBot_TalentQuery(unit)
    if unit and UnitIsVisible(unit) and UnitIsConnected(unit) and CanInspect(unit) then 
        NotifyInspect(unit); 
    end
  --HealBot_setCall("HealBot_TalentQuery")
end

local function HealBot_SlashCmd(cmd)
    if not cmd then cmd="" end
    local HBcmd, x, y, z = string.split(" ", cmd)
    HBcmd=string.lower(HBcmd) 
    if (HBcmd=="" or HBcmd=="o" or HBcmd=="options" or HBcmd=="opt" or HBcmd=="config" or HBcmd=="cfg") then
        HealBot_TogglePanel(HealBot_Options);
    elseif (HBcmd=="d" or HBcmd=="defaults") then
        HealBot_Options_Defaults_OnClick(HealBot_Options_Defaults);
    elseif (HBcmd=="ui") then
        HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_HARDRELOAD)
        HealBot_SetResetFlag("HARD")
    elseif (HBcmd=="ri" or (HBcmd=="reset" and x and string.lower(x)=="healbot")) then
        HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_SOFTRELOAD)
        HealBot_SetResetFlag("SOFT")
    elseif (HBcmd=="rc" or (HBcmd=="reset" and x and string.lower(x)=="customdebuffs")) then
        HealBot_setResetFlagCode(2)
    elseif (HBcmd=="rs" or (HBcmd=="reset" and x and string.lower(x)=="skin")) then
        HealBot_setResetFlagCode(3)
    elseif (HBcmd=="show") then
        HealBot_Action_Reset()
    elseif (HBcmd=="cb") then
        HealBot_Panel_ClearBlackList()
    elseif (HBcmd=="cspells") then
        HealBot_Copy_SpellCombos()
    elseif (HBcmd=="rspells") then
        HealBot_Reset_Spells()
    elseif (HBcmd=="rcures") then
        HealBot_Reset_Cures()
    elseif (HBcmd=="rbuffs") then
        HealBot_Reset_Buffs()
    elseif (HBcmd=="ricons") then
        HealBot_Reset_Icons()
    elseif (HBcmd=="disable") then
        HealBot_Options_DisableHealBotOpt:SetChecked(1)
        HealBot_Options_DisableHealBot(1)
    elseif (HBcmd=="enable") then
        HealBot_Options_DisableHealBotOpt:SetChecked(0)
        HealBot_Options_DisableHealBot(0)
    elseif (HBcmd=="t") then
        if HealBot_Config.DisabledNow==0 then
            HealBot_Options_DisableHealBotOpt:SetChecked(1)
            HealBot_Options_DisableHealBot(1)
        else
            HealBot_Options_DisableHealBotOpt:SetChecked(0)
            HealBot_Options_DisableHealBot(0)
        end
    elseif (HBcmd=="comms") then
        HealBot_Comms_Zone()
    elseif (HBcmd=="help" or HBcmd=="h") then
        HealBot_luVars["HelpCnt1"]=0
        HealBot_luVars["Help"]=true
    elseif (HBcmd=="hs") then
        HealBot_luVars["HelpCnt2"]=0
        HealBot_luVars["Help"]=true
    elseif (HBcmd=="skin" and x) then
        if y then x=x.." "..y end
        if z then x=x.." "..z end
        HealBot_Options_Set_Current_Skin(x)
    elseif (HBcmd=="as") then
        HealBot_ToggleAcceptSkins()
    elseif (HBcmd=="use10") then
        if HealBot_Config.MacroUse10==1 then
            HealBot_Config.MacroUse10=0
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_USE10OFF)
        else
            HealBot_Config.MacroUse10=1
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_USE10ON)
        end
    elseif (HBcmd=="suppress" and x) then
        x=string.lower(x)
        HealBot_ToggleSuppressSetting(x)
    elseif (HBcmd=="test") then
        HealBot_TestBars(x)
    elseif (HBcmd=="tr" and x) then
        HealBot_Panel_SethbTopRole(x)
    elseif (HBcmd=="ssp") then
        HealBot_Panel_SetSubSortPlayer()
    elseif (HBcmd=="spt") then
        if Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["SELFPET"]==1 then
            Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["SELFPET"]=0
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_SELFPETSOFF)
        else
            Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["SELFPET"]=1
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_SELFPETSON)
        end
        HealBot_nextRecalcParty(6)
    elseif (HBcmd=="manabloom" and x) then
        if tonumber(x) and tonumber(x)>0 and tonumber(x)<=100 then
            HealBot_Globals.minManaBloom=ceil(x)
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_EVER_BLOOMING_FROND.." highlighted when mana below "..ceil(x).."%")
        else
            HealBot_AddChat(HEALBOT_CHAT_ADDONID.."Invalid Number")
        end
    elseif (HBcmd=="healthbloom" and x) then
        if tonumber(x) and tonumber(x)>0 and tonumber(x)<=100 then
            HealBot_Globals.minHealthBloom=ceil(x)
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_EVER_BLOOMING_FROND.." highlighted when health below "..ceil(x).."%")
        else
            HealBot_AddChat(HEALBOT_CHAT_ADDONID.."Invalid Number")
        end
    elseif (HBcmd=="cp") then
        if Healbot_Config_Skins.Protection[Healbot_Config_Skins.Current_Skin]["CRASH"] then
            Healbot_Config_Skins.Protection[Healbot_Config_Skins.Current_Skin]["CRASH"]=false
        else
            Healbot_Config_Skins.Protection[Healbot_Config_Skins.Current_Skin]["CRASH"]=true
        end
    elseif (HBcmd=="bt") then
        if HealBot_Config_Buffs.BuffWatch then
            HealBot_Config_Buffs.BuffWatch=false
        else
            HealBot_Config_Buffs.BuffWatch=true
        end
        HealBot_Options_MonitorBuffs:SetChecked(HealBot_Config_Buffs.BuffWatch)
        HealBot_Options_MonitorBuffs_Toggle()
    elseif (HBcmd=="dt") then
        if HealBot_Config_Cures.DebuffWatch then
            HealBot_Config_Cures.DebuffWatch=false
        else
            HealBot_Config_Cures.DebuffWatch=true
        end
        HealBot_Options_MonitorDebuffs:SetChecked(HealBot_Config_Cures.DebuffWatch)
        HealBot_Options_MonitorDebuffs_Toggle()
    elseif (HBcmd=="pcs" and x) then
        local minBH=50
        for j=1,10 do
            if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["HEIGHT"]<minBH then
                minBH=Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][j]["HEIGHT"]
            end
        end
		if (tonumber(x)<25) and ((minBH-tonumber(x))>0) then
			HealBot_Globals.PowerChargeTxtSizeMod=tonumber(x)
			HealBot_SetResetFlag("SOFT")
		end
    elseif (HBcmd=="hrfm") then
        HealBot_trackHiddenFrames["RAID"]=true
        if HealBot_Globals.RaidHideMethod==0 then
            HealBot_Globals.RaidHideMethod=1
            HealBot_setOptions_Timer(188)
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_OPTIONS_HIDERAIDFRAMES.." "..HEALBOT_WORD_DISABLE.." "..HEALBOT_WORD_ALWAYS)
        else
            local hbHideRaidFrameSetting=0
            if Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["HIDERAIDF"] then hbHideRaidFrameSetting=1 end
            HealBot_Globals.RaidHideMethod=3+hbHideRaidFrameSetting
            Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["HIDERAIDF"]=false
            HealBot_setOptions_Timer(188)
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_OPTIONS_HIDERAIDFRAMES.." "..HEALBOT_WORD_DISABLE.." "..HEALBOT_WORD_NEVER)
        end
    elseif (HBcmd=="hrfms") then
        if HealBot_Globals.RaidHideMethod==0 then
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_OPTIONS_HIDERAIDFRAMES.." "..HEALBOT_WORD_DISABLE.." "..HEALBOT_WORD_NEVER)
        else
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_OPTIONS_HIDERAIDFRAMES.." "..HEALBOT_WORD_DISABLE.." "..HEALBOT_WORD_ALWAYS)
        end
	elseif (HBcmd=="debug") then
		if CanInspect("target") then HealBot_TalentQuery("target") end
    elseif (HBcmd=="rld" and x) then
        if tonumber(x) and tonumber(x)>0 and tonumber(x)<=30 then
            HealBot_Globals.ResLagDuration=ceil(x)
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_RESLAG_INDICATOR.." "..ceil(x).." "..HEALBOT_WORDS_SEC)
        else
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_RESLAG_INDICATOR_ERROR)
        end
    elseif (HBcmd=="flb") then
        if HealBot_Globals.ByPassLock==1 then
            HealBot_Globals.ByPassLock=0
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_FRAMELOCK_BYPASS_OFF)
        else
            HealBot_Globals.ByPassLock=1
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_FRAMELOCK_BYPASS_ON)
        end
    elseif (HBcmd=="rtb") then
        if HealBot_Globals.TargetBarRestricted==1 then
            HealBot_Globals.TargetBarRestricted=0
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_RESTRICTTARGETBAR_OFF)
        else
            HealBot_Globals.TargetBarRestricted=1
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_RESTRICTTARGETBAR_ON)
        end
    elseif (HBcmd=="tsa" and x) then
        if tonumber(x) and tonumber(x)>0 and tonumber(x)<101 then
            HealBot_Globals.tsadjmod=tonumber(x)
            HealBot_AddChat(HEALBOT_CHAT_ADDONID.."Text size adjust = "..x)
        end
    elseif (HBcmd=="dm") then
        HealBot_MountsPets_DislikeMount("Dislike")
    elseif (HBcmd=="em") then
        HealBot_MountsPets_DislikeMount("Exclude")
    elseif (HBcmd=="afr") then
        HealBot_AddChat("qaFR="..HealBot_luVars["qaFR"])
    elseif (HBcmd=="aggro" and x and y) then
        if tonumber(x) and tonumber(x)==2 then
            if tonumber(y) and tonumber(y)>24 and tonumber(x)<96 then
                HealBot_Globals.aggro2pct=tonumber(y)
                HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_AGGRO2_SET_MSG..y)
            else
                HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_AGGRO2_ERROR_MSG)
            end
        elseif tonumber(x) and tonumber(x)==3 then
            if tonumber(y) and tonumber(y)>74 and tonumber(y)<101 then
                HealBot_Globals.aggro3pct=tonumber(y)
                HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_AGGRO3_SET_MSG..y)
            else
                HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_AGGRO3_ERROR_MSG)
            end
        else
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_AGGRO_ERROR_MSG)
        end
    elseif (HBcmd=="lang" and x) then
        HealBot_Options_Lang(x)
    elseif (HBcmd=="cw") then  -- Clear Warnings
        HealBot_Globals.OneTimeMsg={}
    elseif (HBcmd=="zzz") then
        HealBot_UnitData[HealBot_Data["PGUID"]]["ROLE"] = "HEALER"
        local xButton = HealBot_Unit_Button["player"]
        xButton.update.roleicon=true
        xButton.status.update=true
    elseif (HBcmd=="xxx") then
        HealBot_UnitData[HealBot_Data["PGUID"]]["ROLE"] = HEALBOT_WORDS_UNKNOWN
        local xButton = HealBot_Unit_Button["player"]
        xButton.update.roleicon=true
        xButton.status.update=true
    else
        if x then HBcmd=HBcmd.." "..x end
        if y then HBcmd=HBcmd.." "..y end
        if z then HBcmd=HBcmd.." "..z end
        HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_UNKNOWNCMD..HBcmd)
        HealBot_luVars["HelpCnt1"]=0
        HealBot_luVars["Help"]=true
    end
  --HealBot_setCall("HealBot_SlashCmd")
end

function HealBot_setResetFlagCode(resetCode)
    HealBot_luVars["ResetFlag"]=resetCode
  --HealBot_setCall("HealBot_setResetFlagCode")
end

function HealBot_ToggleAcceptSkins()
    if HealBot_Globals.AcceptSkins==1 then
        HealBot_Globals.AcceptSkins=0
        HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_ACCEPTSKINOFF)
    else
        HealBot_Globals.AcceptSkins=1
        HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_ACCEPTSKINON)
    end
    HealBot_Comms_AcceptSkins()
  --HealBot_setCall("HealBot_ToggleAcceptSkins")
end

function HealBot_ToggleSuppressSetting(settingType)
    if settingType=="sound" then
        if HealBot_Globals.MacroSuppressSound==1 then
            HealBot_Globals.MacroSuppressSound=0
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_MACROSOUNDON)
        else
            HealBot_Globals.MacroSuppressSound=1
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_MACROSOUNDOFF)
        end
        HealBot_Action_SetAllAttribs()
        HealBot_Comms_MacroSuppressSound()
    elseif settingType=="error" then
        if HealBot_Globals.MacroSuppressError==1 then
            HealBot_Globals.MacroSuppressError=0
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_MACROERRORON)
        else
            HealBot_Globals.MacroSuppressError=1
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_MACROERROROFF)
        end
        HealBot_Action_SetAllAttribs()
        HealBot_Comms_MacroSuppressError()
    end
  --HealBot_setCall("HealBot_ToggleSuppressSetting")
end

function HealBot_TestBars(noBars)
    local numBars=noBars or HealBot_Globals.TestBars["BARS"]
    if numBars and tonumber(numBars) and tonumber(numBars)>4 and tonumber(numBars)<51 then
        numBars=tonumber(numBars)
        HealBot_Panel_SetNumBars(numBars)
        HealBot_Panel_ToggleTestBars()
     elseif HealBot_Panel_retTestBars() then
         HealBot_Panel_ToggleTestBars()
    end
    HealBot_nextRecalcParty(0)
  --HealBot_setCall("HealBot_TestBars")
end

local function HealBot_configClassHoT()
    local hbClassHoTwatch=HealBot_Globals.WatchHoT
    for sName,_ in pairs(HealBot_Watch_HoT) do
        HealBot_Watch_HoT[sName]=nil
    end
    for xClass,_  in pairs(hbClassHoTwatch) do
        local HealBot_configClassHoTClass=HealBot_Globals.WatchHoT[xClass]
        for sName,x  in pairs(HealBot_configClassHoTClass) do
            if xClass=="ALL" and x==3 then
                HealBot_Watch_HoT[sName]="C"
                if sName==HEALBOT_GIFT_OF_THE_NAARU and HealBot_Data["PRACE_EN"]=="Draenei" then HealBot_Watch_HoT[sName]="C" end
            elseif (x==4) or (x==3 and xClass==HealBot_Data["PCLASSTRIM"]) then
                HealBot_Watch_HoT[sName]="A"
                if sName==HEALBOT_GIFT_OF_THE_NAARU and HealBot_Data["PRACE_EN"]=="Draenei" then HealBot_Watch_HoT[sName]="A" end
            elseif x==2 then 
                HealBot_Watch_HoT[sName]="S"
                if sName==HEALBOT_GIFT_OF_THE_NAARU and HealBot_Data["PRACE_EN"]=="Draenei" then HealBot_Watch_HoT[sName]="S" end
            else
                HealBot_Watch_HoT[sName]=nil
            end
        end
    end
  --HealBot_setCall("HealBot_configClassHoT")
end

local function HealBot_CheckTime_Modifier()
    if IsInRaid() then
        if GetNumGroupMembers() < 15 then
            HealBot_Timers["CheckTimeMod"]=HealBot_Comm_round(HealBot_Globals.RangeCheckFreq/(HealBot_luVars["qaFR"]/15), 4) -- At 50FPS with default settings = 0.12
        else
            HealBot_Timers["CheckTimeMod"]=HealBot_Comm_round(HealBot_Globals.RangeCheckFreq/(HealBot_luVars["qaFR"]/8), 4) -- At 50FPS with default settings = 0.064
        end
    elseif IsInGroup() then
        HealBot_Timers["CheckTimeMod"]=HealBot_Comm_round(HealBot_Globals.RangeCheckFreq/(HealBot_luVars["qaFR"]/25), 4) -- At 50FPS with default settings = 0.2
    else
        HealBot_Timers["CheckTimeMod"]=HealBot_Comm_round(HealBot_Globals.RangeCheckFreq/(HealBot_luVars["qaFR"]/70), 4) -- At 50FPS with default settings = 0.56
    end
  --HealBot_setCall("HealBot_CheckTime_Modifier")
end

local function HealBot_OnEvent_UnitMana(button)
    if UnitExists(button.unit) and button.status.unittype < 9 then
        button.mana.current=UnitPower(button.unit, 0)
        button.mana.max=UnitPowerMax(button.unit, 0)
        HealBot_Action_CheckUnitLowMana(button)
        HealBot_Action_SetBar3Value(button)
    end
  --HealBot_setCall("HealBot_OnEvent_UnitMana")
end

local function HealBot_ClearUnitAggro(button)
    local doClear=true
    if UnitExists(button.unit) and (button.aggro.status<0 or button.aggro.status>4) then 
        doClear=false
    end
    button.aggro.threatpct = -5
    HealBot_Action_aggroIndicatorUpd(button)
    if doClear then
        HealBot_Action_UpdateAggro(button.unit,false,nil,0)
    end
  --HealBot_setCall("HealBot_ClearUnitAggro")
end

function HealBot_UpdateUnitReset(button)
    if button.aura.buff.name then
        HealBot_ClearBuff(button)
    end
    if button.aura.debuff.name then 
        HealBot_ClearDebuff(button)
    end
    HealBot_ClearUnitAggro(button)
    HealBot_Action_CheckUnitLowMana(button)
    HealBot_HoT_RemoveIconButton(button)
    button.health.incoming=0
    button.health.absorbs=0
    HealBot_Action_UpdateHealsInButton(button)
    HealBot_Action_UpdateAbsorbsButton(button)
end

function HealBot_UpdateUnit(button)
    button.health.updincoming=true
    button.health.updabsorbs=true
    button.health.update=true
    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["CLASSONBAR"] then
        button.update.roleicon=true
        button.status.update=true
    end    
    if Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][button.frame]["SHOW"] then 
        button.update.targeticon=true
        button.status.update=true
    end
    HealBot_Action_UpdateBackgroundButton(button)
    HealBot_Action_setNameTag(button)
    HealBot_Action_setHealthText(button)
    HealBot_Action_setNameText(button)
    HealBot_Action_HBText(button)
    if UnitExists(button.unit) then
        button.health.updhealth=true
        button.health.update=true
        HealBot_OnEvent_UnitMana(button);
        button.guid=HealBot_UnitGUID(button.unit)
    else
        HealBot_Action_UpdateHealthButton(button)
    end
    HealBot_Action_SetBar3Value(button)
    HealBot_AuraChecks(button)
  --HealBot_setCall("HealBot_UpdateUnit")
end

local function HealBot_RecalcParty(changeType)
    HealBot_RefreshTypes[changeType]=false
    HealBot_Action_PartyChanged(changeType);
  --HealBot_setCall("HealBot_RecalcParty")
end

local function HealBot_ClearAllBuffs()
    for _,xButton in pairs(HealBot_Unit_Button) do
        if xButton.aura.buff.name then
            HealBot_ClearBuff(xButton,true)
        end
    end
  --HealBot_setCall("HealBot_ClearAllBuffs")
end

function HealBot_ClearAllDebuffs()
    for xUnit,xButton in pairs(HealBot_Unit_Button) do
        HealBot_ClearDebuff(xButton)
    end
    for xUnit,xButton in pairs(HealBot_Pet_Button) do
        HealBot_ClearDebuff(xButton)
    end
  --HealBot_setCall("HealBot_ClearAllDebuffs")
end

function HealBot_SetAuraChecks()
    if not HealBot_Data["UILOCK"] and HealBot_Config_Buffs.NoAuraWhenRested and IsResting() then
        if HealBot_luVars["BuffCheck"] then 
            HealBot_luVars["BuffCheck"]=false
            HealBot_ClearAllBuffs() 
        end
        if HealBot_luVars["DebuffCheck"] then 
            HealBot_luVars["DebuffCheck"]=false
            HealBot_ClearAllDebuffs() 
        end
    else
        if HealBot_Config_Buffs.BuffWatchWhenGrouped and GetNumGroupMembers()==0 then
            if HealBot_luVars["BuffCheck"] then 
                HealBot_luVars["BuffCheck"]=false
                HealBot_ClearAllBuffs() 
            end
        elseif HealBot_Config_Buffs.BuffWatch then
            if not HealBot_luVars["BuffCheck"] then 
                HealBot_luVars["BuffCheck"]=true
                HealBot_CheckAllBuffs() 
            end
        else
            if HealBot_luVars["BuffCheck"] then 
                HealBot_luVars["BuffCheck"]=false
                HealBot_ClearAllBuffs() 
            end
        end
        if HealBot_Config_Cures.DebuffWatchWhenGrouped and GetNumGroupMembers()==0 then
            if HealBot_luVars["DebuffCheck"] then 
                HealBot_luVars["DebuffCheck"]=false
                HealBot_ClearAllDebuffs() 
            end
        elseif HealBot_Config_Cures.DebuffWatch then
            if not HealBot_luVars["DebuffCheck"] then 
                HealBot_luVars["DebuffCheck"]=true
                HealBot_CheckAllDebuffs() 
            end
        else
            if HealBot_luVars["DebuffCheck"] then 
                HealBot_luVars["DebuffCheck"]=false
                HealBot_ClearAllDebuffs() 
            end
        end
    end
  --HealBot_setCall("HealBot_SetAuraChecks")
end

local function HealBot_CheckZone()
    HealBot_setOptions_Timer(405)
    HealBot_luVars["hbInsNameCheck"]=GetTime()+1
    HealBot_setOptions_Timer(7950)
    HealBot_SetAuraChecks()
    HealBot_setOptions_Timer(595)
    HealBot_setOptions_Timer(10)
  --HealBot_setCall("HealBot_CheckZone")
end

local hbStanceBuffs = {}
local function HealBot_setHbStanceBuffs()
    if HealBot_Data["PCLASSTRIM"]=="PALA" then
        hbStanceBuffs = {}
        local i = GetSpecialization()
        local specID = 0
        if i then specID = GetSpecializationInfo(i,false,false) end
        if specID==65 then
            hbStanceBuffs[HEALBOT_SEAL_OF_COMMAND]=1
            hbStanceBuffs[HEALBOT_SEAL_OF_INSIGHT]=2
        elseif specID==66 then
            hbStanceBuffs[HEALBOT_SEAL_OF_RIGHTEOUSNESS]=1
            hbStanceBuffs[HEALBOT_SEAL_OF_INSIGHT]=2
        else
            hbStanceBuffs[HEALBOT_SEAL_OF_TRUTH]=1
            hbStanceBuffs[HEALBOT_SEAL_OF_RIGHTEOUSNESS]=2
            hbStanceBuffs[HEALBOT_SEAL_OF_JUSTICE]=3
            hbStanceBuffs[HEALBOT_SEAL_OF_INSIGHT]=4
        end
    elseif HealBot_Data["PCLASSTRIM"]=="MONK" then
        hbStanceBuffs = {
            [HEALBOT_STANCE_MONK_SERPENT]=1,
            [HEALBOT_STANCE_MONK_TIGER]=2,
            }
    end
  --HealBot_setCall("HealBot_setHbStanceBuffs")
end

local function HealBot_Update_BuffsForSpecDD(ddId,bType)
    if bType=="Debuff" then
        for z=1,4 do
            if HealBot_Config_Cures.HealBotDebuffDropDown[ddId] and not HealBot_Config_Cures.HealBotDebuffDropDown[z..ddId] then 
                HealBot_Config_Cures.HealBotDebuffDropDown[z..ddId]=HealBot_Config_Cures.HealBotDebuffDropDown[ddId] 
            elseif not HealBot_Config_Cures.HealBotDebuffDropDown[z..ddId] then 
                HealBot_Config_Cures.HealBotDebuffDropDown[z..ddId]=4
            end
            if HealBot_Config_Cures.HealBotDebuffText[ddId] and not HealBot_Config_Cures.HealBotDebuffText[z..ddId] then 
				local sName = HealBot_Config_Cures.HealBotDebuffText[ddId] 
				if sName == HEALBOT_NATURES_CURE and z ~= 4 then 
					sName = HEALBOT_REMOVE_CORRUPTION
				elseif sName == HEALBOT_REMOVE_CORRUPTION and z == 4 then 
					sName = HEALBOT_NATURES_CURE
				elseif sName == HEALBOT_PURIFY_SPIRIT and z ~= 3 then 
					sName = HEALBOT_CLEANSE_SPIRIT
				elseif sName == HEALBOT_CLEANSE_SPIRIT and z == 3 then 
					sName = HEALBOT_PURIFY_SPIRIT
				end
				HealBot_Config_Cures.HealBotDebuffText[z..ddId]=sName
            elseif not not HealBot_Config_Cures.HealBotDebuffText[z..ddId] then 
                HealBot_Config_Cures.HealBotDebuffText[z..ddId]=HEALBOT_WORDS_NONE
            end
        end
    else
        for z=1,4 do
            if HealBot_Config_Buffs.HealBotBuffDropDown[ddId] and not HealBot_Config_Buffs.HealBotBuffDropDown[z..ddId] then 
                HealBot_Config_Buffs.HealBotBuffDropDown[z..ddId]=HealBot_Config_Buffs.HealBotBuffDropDown[ddId]
            elseif not HealBot_Config_Buffs.HealBotBuffDropDown[z..ddId] then 
                HealBot_Config_Buffs.HealBotBuffDropDown[z..ddId]=4
            end
            if HealBot_Config_Buffs.HealBotBuffText[ddId] and not HealBot_Config_Buffs.HealBotBuffText[z..ddId] then 
                HealBot_Config_Buffs.HealBotBuffText[z..ddId]=HealBot_Config_Buffs.HealBotBuffText[ddId]
            elseif not HealBot_Config_Buffs.HealBotBuffText[z..ddId] then 
                HealBot_Config_Buffs.HealBotBuffText[z..ddId]=HEALBOT_WORDS_NONE
            end
        end
    end
  --HealBot_setCall("HealBot_Update_BuffsForSpecDD")
end

local function HealBot_Update_BuffsForSpec(buffType)
    if buffType then
        if buffType=="Debuff" then
            for x=1,3 do
                HealBot_Update_BuffsForSpecDD(x,"Debuff")
            end
        else
            for x=1,8 do
                HealBot_Update_BuffsForSpecDD(x,"Buff")
            end
        end
    else
        for x=1,3 do
            HealBot_Update_BuffsForSpecDD(x,"Debuff")
        end
        for x=1,8 do
            HealBot_Update_BuffsForSpecDD(x,"Buff")
        end
    end
  --HealBot_setCall("HealBot_Update_BuffsForSpec")
end

local function HealBot_Update_SpellCombos()
    local combo,button=nil,nil
    for x=1,3 do
        if x==1 then
            combo = HealBot_Config_Spells.EnabledKeyCombo;
        elseif x==2 then
            combo = HealBot_Config_Spells.DisabledKeyCombo;
        else
            combo = HealBot_Config_Spells.EnemyKeyCombo;
        end
        for y=1,15 do
            button = HealBot_Options_ComboClass_Button(y)
            for z=1,4 do
                if combo then
                    combo[button..z] = combo[button]
                    combo["Shift"..button..z] = combo["Shift"..button]
                    combo["Ctrl"..button..z] = combo["Ctrl"..button]
                    combo["Alt"..button..z] = combo["Alt"..button]
                    combo["Ctrl-Shift"..button..z] = combo["Ctrl-Shift"..button]
                    combo["Alt-Shift"..button..z] = combo["Alt-Shift"..button]
                end
            end
        end
    end
  --HealBot_setCall("HealBot_Update_SpellCombos")
end

local function HealBot_DoReset_Spells(pClassTrim)
    HealBot_Config_Spells.EnabledKeyCombo = {}
    HealBot_Config_Spells.DisabledKeyCombo = {}
    HealBot_Config_Spells.EnemyKeyCombo = {}
    local bandage=HealBot_GetBandageType() or ""
    local x=""
    if pClassTrim=="DRUI" then
        HealBot_Config_Spells.EnabledKeyCombo = {
          ["Left"] = HEALBOT_REGROWTH,
          ["CtrlLeft"] =  HEALBOT_REMOVE_CORRUPTION,
          ["Right"] = HEALBOT_HEALING_TOUCH,
          ["CtrlRight"] =  HEALBOT_NATURES_CURE,
          ["Middle"] = HEALBOT_REJUVENATION,
          ["ShiftMiddle"] = bandage,
          ["Alt-ShiftLeft"] = HEALBOT_DISABLED_TARGET,
          ["Alt-ShiftRight"] = HEALBOT_ASSIST,
          ["Ctrl-ShiftLeft"] = HEALBOT_MENU,
          ["Ctrl-ShiftRight"] = HEALBOT_HBMENU,
                                         }
        HealBot_Config_Spells.DisabledKeyCombo = {
          ["Left"] = HEALBOT_DISABLED_TARGET,
          ["ShiftLeft"] = HEALBOT_MARK_OF_THE_WILD,
          ["Right"] = HEALBOT_ASSIST,
          ["Middle"] = HEALBOT_REJUVENATION,
          ["Ctrl-ShiftLeft"] = HEALBOT_MENU,
          ["Ctrl-ShiftRight"] = HEALBOT_HBMENU,
                                         }
    elseif pClassTrim=="MONK" then
        HealBot_Config_Spells.EnabledKeyCombo = {
          ["Left"] = HEALBOT_SOOTHING_MIST,
          ["ShiftLeft"] = HEALBOT_SURGING_MIST,
          ["ShiftRight"] = HEALBOT_REVIVAL,
          ["CtrlLeft"] =  HEALBOT_DETOX,
          ["Right"] = HEALBOT_ENVELOPING_MIST,
          ["Middle"] =  HEALBOT_RENEWING_MIST,
          ["ShiftMiddle"] = HEALBOT_UPLIFT,
          ["CtrlMiddle"] = HEALBOT_LIFE_COCOON,
          ["AltMiddle"] = HEALBOT_ZEN_MEDITATION,
          ["Alt-ShiftLeft"] = HEALBOT_DISABLED_TARGET,
          ["Alt-ShiftRight"] = HEALBOT_ASSIST,
          ["Ctrl-ShiftLeft"] = HEALBOT_MENU,
          ["Ctrl-ShiftRight"] = HEALBOT_HBMENU,
                                         }
        HealBot_Config_Spells.DisabledKeyCombo = {
          ["Left"] = HEALBOT_DISABLED_TARGET,
          ["Middle"] =  HEALBOT_RENEWING_MIST,
          ["Right"] = HEALBOT_ASSIST,
          ["Ctrl-ShiftLeft"] = HEALBOT_MENU,
          ["Ctrl-ShiftRight"] = HEALBOT_HBMENU,
                                         }
    elseif pClassTrim=="PALA" then
        HealBot_Config_Spells.EnabledKeyCombo = {
          ["Left"] = HEALBOT_FLASH_OF_LIGHT,
          ["ShiftLeft"] = x,
          ["ShiftRight"] = HEALBOT_LIGHT_OF_DAWN,
          ["CtrlLeft"] =  HEALBOT_CLEANSE,
          ["Right"] = HEALBOT_HOLY_LIGHT,
          ["Middle"] =  HEALBOT_WORD_OF_GLORY,
          ["ShiftMiddle"] = HEALBOT_HOLY_RADIANCE,
          ["Alt-ShiftLeft"] = HEALBOT_DISABLED_TARGET,
          ["Alt-ShiftRight"] = HEALBOT_ASSIST,
          ["Ctrl-ShiftLeft"] = HEALBOT_MENU,
          ["Ctrl-ShiftRight"] = HEALBOT_HBMENU,
                                         }
        HealBot_Config_Spells.DisabledKeyCombo = {
          ["Left"] = HEALBOT_DISABLED_TARGET,
          ["Middle"] =  HEALBOT_HAND_OF_SALVATION,
          ["Right"] = HEALBOT_ASSIST,
          ["Ctrl-ShiftLeft"] = HEALBOT_MENU,
          ["Ctrl-ShiftRight"] = HEALBOT_HBMENU,
                                         }
    elseif pClassTrim=="PRIE" then
        HealBot_Config_Spells.EnabledKeyCombo = {
          ["Left"] = HEALBOT_FLASH_HEAL,
          ["ShiftLeft"] = HEALBOT_BINDING_HEAL,
          ["CtrlLeft"] = HEALBOT_PURIFY,
          ["Right"] = HEALBOT_HEAL,
          ["ShiftRight"] = HEALBOT_HOLY_WORD_SERENITY,
          ["CtrlRight"] = HEALBOT_MASS_DISPEL,
          ["Middle"] = HEALBOT_RENEW,
          ["ShiftMiddle"] = HEALBOT_PRAYER_OF_MENDING,
          ["AltMiddle"] = HEALBOT_PRAYER_OF_HEALING,
          ["CtrlMiddle"] = HEALBOT_DIVINE_HYMN,
          ["Alt-ShiftLeft"] = HEALBOT_DISABLED_TARGET,
          ["Alt-ShiftRight"] = HEALBOT_HOLY_WORD_SALVATION,
          ["Ctrl-ShiftRight"] = HEALBOT_HBMENU,
                                         }
        HealBot_Config_Spells.DisabledKeyCombo = {
          ["Left"] = HEALBOT_DISABLED_TARGET,
          ["Right"] = HEALBOT_ASSIST,
          ["AltLeft"] = HEALBOT_RESURRECTION,
          ["ShiftRight"] = HEALBOT_HOLY_WORD_SERENITY,
          ["Middle"] = HEALBOT_RENEW,
          ["Ctrl-ShiftLeft"] = HEALBOT_FLASH_HEAL,
          ["Ctrl-ShiftRight"] = HEALBOT_HBMENU,
                                         }
    elseif pClassTrim=="SHAM" then
        if HealBot_Config.CurrentSpec==3 then
            x=HEALBOT_PURIFY_SPIRIT;
        else
            x=HEALBOT_CLEANSE_SPIRIT;
        end
        HealBot_Config_Spells.EnabledKeyCombo = {
          ["Left"] = HEALBOT_HEALING_WAVE,
          ["CtrlLeft"] = x,
          ["Right"] = x,
          ["CtrlRight"] = x,
          ["ShiftLeft"] = HEALBOT_CHAIN_HEAL,
		  ["Middle"] = HEALBOT_HEALING_RAIN,
          ["ShiftMiddle"] = HEALBOT_HEALING_SURGE,
          ["AltLeft"] = HEALBOT_HEALING_STREAM_TOTEM,
          ["AltRight"] = x,
          ["Alt-ShiftLeft"] = HEALBOT_DISABLED_TARGET,
          ["Alt-ShiftRight"] = HEALBOT_ASSIST,
          ["Ctrl-ShiftLeft"] = HEALBOT_MENU,
          ["Ctrl-ShiftRight"] = HEALBOT_HBMENU,
                                         }
        HealBot_Config_Spells.DisabledKeyCombo = {
          ["Left"] = HEALBOT_DISABLED_TARGET,
          ["Right"] = HEALBOT_ASSIST,
          ["Ctrl-ShiftLeft"] = HEALBOT_MENU,
          ["Ctrl-ShiftRight"] = HEALBOT_HBMENU,
                                         }
    elseif pClassTrim=="MAGE" then
        HealBot_Config_Spells.EnabledKeyCombo = {
          ["Left"] = HEALBOT_REMOVE_CURSE,
          ["ShiftLeft"] = bandage,
          ["Alt-ShiftLeft"] = HEALBOT_DISABLED_TARGET,
          ["Alt-ShiftRight"] = HEALBOT_ASSIST,
          ["Ctrl-ShiftLeft"] = HEALBOT_MENU,
          ["Ctrl-ShiftRight"] = HEALBOT_HBMENU,
                                         }
        HealBot_Config_Spells.DisabledKeyCombo = {
          ["Left"] = HEALBOT_DISABLED_TARGET,
          ["ShiftLeft"] = bandage,
          ["Right"] = HEALBOT_ASSIST,
          ["Ctrl-ShiftLeft"] = HEALBOT_MENU,
          ["Ctrl-ShiftRight"] = HEALBOT_HBMENU,
                                         }
    else
        HealBot_Config_Spells.EnabledKeyCombo = {
          ["Left"] = bandage,
          ["Alt-ShiftLeft"] = HEALBOT_DISABLED_TARGET,
          ["Alt-ShiftRight"] = HEALBOT_ASSIST,
          ["Ctrl-ShiftLeft"] = HEALBOT_MENU,
          ["Ctrl-ShiftRight"] = HEALBOT_HBMENU,
                                         }
        HealBot_Config_Spells.DisabledKeyCombo = {
          ["Left"] = HEALBOT_DISABLED_TARGET,
          ["ShiftLeft"] = bandage,
          ["Right"] = HEALBOT_ASSIST,
          ["Ctrl-ShiftLeft"] = HEALBOT_MENU,
          ["Ctrl-ShiftRight"] = HEALBOT_HBMENU,
                                         }
    end
  --HealBot_setCall("HealBot_DoReset_Spells")
end

local function HealBot_DoReset_Cures(pClassTrim)
    HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_WORDS_NONE,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
    HealBot_Config_Cures.HealBotDebuffDropDown = {[1]=4,[2]=4,[3]=4}
    if pClassTrim=="DRUI" then
        if HealBot_GetSpellId(HEALBOT_NATURES_CURE) then
            if HealBot_GetSpellId(HEALBOT_REMOVE_CORRUPTION) then
                HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_REMOVE_CORRUPTION,[2]=HEALBOT_NATURES_CURE,[3]=HEALBOT_WORDS_NONE}
            else
                HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_NATURES_CURE,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
            end
        elseif HealBot_GetSpellId(HEALBOT_REMOVE_CORRUPTION) then
            HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_REMOVE_CORRUPTION,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
        end
    elseif pClassTrim=="MONK" then
        if HealBot_GetSpellId(HEALBOT_DETOX) then
            HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_DETOX,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
        end
    elseif pClassTrim=="PALA" then
        if HealBot_GetSpellId(HEALBOT_CLEANSE) then
            HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_CLEANSE,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
        elseif HealBot_GetSpellId(HEALBOT_CLEANSE_TOXIN) then
            HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_CLEANSE_TOXIN,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
        end
    elseif pClassTrim=="PRIE" then
        if HealBot_GetSpellId(HEALBOT_PURIFY) then
            if HealBot_GetSpellId(HEALBOT_MASS_DISPEL) then
                if HealBot_GetSpellId(HEALBOT_PURIFY_DISEASE) then
                    HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_PURIFY,[2]=HEALBOT_MASS_DISPEL,[3]=HEALBOT_PURIFY_DISEASE}
                else
                    HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_PURIFY,[2]=HEALBOT_MASS_DISPEL,[3]=HEALBOT_WORDS_NONE}
                end
            elseif HealBot_GetSpellId(HEALBOT_PURIFY_DISEASE) then
                HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_PURIFY,[2]=HEALBOT_PURIFY_DISEASE,[3]=HEALBOT_WORDS_NONE}
            else
                HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_PURIFY,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
            end
        elseif HealBot_GetSpellId(HEALBOT_MASS_DISPEL) then
            if HealBot_GetSpellId(HEALBOT_PURIFY_DISEASE) then
                HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_MASS_DISPEL,[2]=HEALBOT_PURIFY_DISEASE,[3]=HEALBOT_WORDS_NONE}
            else
                HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_MASS_DISPEL,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
            end
        elseif HealBot_GetSpellId(HEALBOT_PURIFY_DISEASE) then
            HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_PURIFY_DISEASE,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
        end
    elseif pClassTrim=="SHAM" then
        if HealBot_GetSpellId(HEALBOT_PURIFY_SPIRIT) then
            HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_PURIFY_SPIRIT,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
        elseif HealBot_GetSpellId(HEALBOT_CLEANSE_SPIRIT) then
            HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_CLEANSE_SPIRIT,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
        end
    elseif pClassTrim=="MAGE" then
        if HealBot_GetSpellId(HEALBOT_REMOVE_CURSE) then
            HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_REMOVE_CURSE,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
        end
    end
  --HealBot_setCall("HealBot_DoReset_Cures")
end

local function HealBot_DoReset_Buffs(pClassTrim)
    HealBot_Config_Buffs.HealBotBuffText = {[1]=HEALBOT_WORDS_NONE,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE,[4]=HEALBOT_WORDS_NONE,[5]=HEALBOT_WORDS_NONE,
                                      [6]=HEALBOT_WORDS_NONE,[7]=HEALBOT_WORDS_NONE,[8]=HEALBOT_WORDS_NONE,[9]=HEALBOT_WORDS_NONE}
    HealBot_Config_Buffs.HealBotBuffDropDown = {[1]=4,[2]=4,[3]=4,[4]=4,[5]=4,[6]=4,[7]=2,[8]=2,[9]=2}
    if pClassTrim=="DRUI" then
        if HealBot_GetSpellId(HEALBOT_MARK_OF_THE_WILD) then
            HealBot_Config_Buffs.HealBotBuffText[1]=HEALBOT_MARK_OF_THE_WILD
        end
    elseif pClassTrim=="MONK" then
        if HealBot_GetSpellId(HEALBOT_LEGACY_WHITETIGER) and HealBot_Config.CurrentSpec==3 then
            HealBot_Config_Buffs.HealBotBuffText[1]=HEALBOT_LEGACY_EMPEROR
            HealBot_Config_Buffs.HealBotBuffText[2]=HEALBOT_LEGACY_WHITETIGER
        elseif HealBot_GetSpellId(HEALBOT_LEGACY_EMPEROR) then
            HealBot_Config_Buffs.HealBotBuffText[1]=HEALBOT_LEGACY_EMPEROR
        end
    elseif pClassTrim=="PALA" then
        local i=1
        if HealBot_GetSpellId(HEALBOT_BLESSING_OF_KINGS) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HEALBOT_BLESSING_OF_KINGS
            i=i+1
        end
        if HealBot_GetSpellId(HEALBOT_BLESSING_OF_MIGHT) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HEALBOT_BLESSING_OF_MIGHT
            i=i+1
        end
        if HealBot_GetSpellId(HEALBOT_BLESSING_OF_WISDOM) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HEALBOT_BLESSING_OF_WISDOM
        end
    elseif pClassTrim=="PRIE" then
        if HealBot_GetSpellId(HEALBOT_POWER_WORD_FORTITUDE) then
            HealBot_Config_Buffs.HealBotBuffText[1]=HEALBOT_POWER_WORD_FORTITUDE
        end
        if HealBot_GetSpellId(HEALBOT_FEAR_WARD) then
            HealBot_Config_Buffs.HealBotBuffText[2]=HEALBOT_FEAR_WARD
            HealBot_Config_Buffs.HealBotBuffDropDown[2]=24
        end
    elseif pClassTrim=="SHAM" then
        if HealBot_GetSpellId(HEALBOT_WATER_SHIELD) then
            HealBot_Config_Buffs.HealBotBuffText[1]=HEALBOT_WATER_SHIELD
        end
        if HealBot_GetSpellId(HEALBOT_EARTH_SHIELD) then
            HealBot_Config_Buffs.HealBotBuffText[2]=HEALBOT_EARTH_SHIELD
            HealBot_Config_Buffs.HealBotBuffDropDown[2]=24
        end
    elseif pClassTrim=="MAGE" then
        if HealBot_GetSpellId(HEALBOT_ARCANE_BRILLIANCE) then
            HealBot_Config_Buffs.HealBotBuffText[1]=HEALBOT_ARCANE_BRILLIANCE
        end
    elseif pClassTrim=="WARR" then
        if HealBot_GetSpellId(HEALBOT_COMMANDING_SHOUT) then
            HealBot_Config_Buffs.HealBotBuffText[1]=HEALBOT_COMMANDING_SHOUT
        end
        if HealBot_GetSpellId(HEALBOT_VIGILANCE) then
            HealBot_Config_Buffs.HealBotBuffText[2]=HEALBOT_VIGILANCE
            HealBot_Config_Buffs.HealBotBuffDropDown[2]=24
        end
    elseif pClassTrim=="WARL" then
        if HealBot_GetSpellId(HEALBOT_DARK_INTENT) then
            HealBot_Config_Buffs.HealBotBuffText[1]=HEALBOT_DARK_INTENT
        end
    end
    if IsUsableItem(HEALBOT_EVER_BLOOMING_FROND) or HealBot_IsItemInBag(HEALBOT_EVER_BLOOMING_FROND) then
        HealBot_Config_Buffs.HealBotBuffText[7]=HEALBOT_EVER_BLOOMING_FROND
    end
    if IsUsableItem(HEALBOT_ORALIUS_WHISPERING_CRYSTAL) or HealBot_IsItemInBag(HEALBOT_ORALIUS_WHISPERING_CRYSTAL) then
        HealBot_Config_Buffs.HealBotBuffText[6]=HEALBOT_ORALIUS_WHISPERING_CRYSTAL
    end
    if IsUsableItem(HEALBOT_REPURPOSED_FEL_FOCUSER) or HealBot_IsItemInBag(HEALBOT_REPURPOSED_FEL_FOCUSER) then
        HealBot_Config_Buffs.HealBotBuffText[8]=HEALBOT_REPURPOSED_FEL_FOCUSER
    end
    if IsUsableItem(HEALBOT_BATTLE_SCARRED_AUGMENT_RUNE) or HealBot_IsItemInBag(HEALBOT_BATTLE_SCARRED_AUGMENT_RUNE) then
        HealBot_Config_Buffs.HealBotBuffText[5]=HEALBOT_BATTLE_SCARRED_AUGMENT_RUNE
    end
    if IsUsableItem(HEALBOT_TAILWIND_SAPPHIRE) or HealBot_IsItemInBag(HEALBOT_TAILWIND_SAPPHIRE) then
        HealBot_Config_Buffs.HealBotBuffText[8]=HEALBOT_TAILWIND_SAPPHIRE
    end
    if IsUsableItem(HEALBOT_AMETHYST_OF_THE_SHADOW_KING) or HealBot_IsItemInBag(HEALBOT_AMETHYST_OF_THE_SHADOW_KING) then
        HealBot_Config_Buffs.HealBotBuffText[7]=HEALBOT_AMETHYST_OF_THE_SHADOW_KING
    end
  --HealBot_setCall("HealBot_DoReset_Buffs")
end

local function HealBot_InitNewChar()
    if HealBot_Config_Spells.EnabledKeyCombo then
        if not HealBot_Config_Spells.DisabledKeyCombo then 
            HealBot_Config_Spells.DisabledKeyCombo=HealBot_Config_Spells.EnabledKeyCombo
        end
        if not HealBot_Config_Spells.EnemyKeyCombo then
            HealBot_Config_Spells.EnemyKeyCombo={}
        end
    else
        HealBot_DoReset_Spells(HealBot_Data["PCLASSTRIM"])
        HealBot_DoReset_Cures(HealBot_Data["PCLASSTRIM"])
        HealBot_DoReset_Buffs(HealBot_Data["PCLASSTRIM"])
        HealBot_Config_Buffs.HealBotBuffColR = {[1]=1,[2]=1,[3]=1,[4]=1,[5]=1,[6]=1,[7]=1,[8]=1}
        HealBot_Config_Buffs.HealBotBuffColG = {[1]=1,[2]=1,[3]=1,[4]=1,[5]=1,[6]=1,[7]=1,[8]=1}
        HealBot_Config_Buffs.HealBotBuffColB = {[1]=1,[2]=1,[3]=1,[4]=1,[5]=1,[6]=1,[7]=1,[8]=1}
        HealBot_Update_SpellCombos()
        HealBot_Update_BuffsForSpec()
        for i=1, 10 do
            HealBot_Action_setPoint(i)
            HealBot_Action_unlockFrame(i)
        end
    end
  --HealBot_setCall("HealBot_InitNewChar")
end

local function HealBot_Load(hbCaller)
    HealBot_SetAuraChecks()
    HealBot_setOptions_Timer(60)
    HealBot_setOptions_Timer(50)
    HealBot_setOptions_Timer(40)
    HealBot_setOptions_Timer(25)
	HealBot_Action_setpcClass()
    HealBot_Tooltip:SetBackdropColor(0,0,0,HealBot_Globals.ttalpha)
    HealBot_Action_SetDebuffAggroCols()
    HealBot_Action_SetHightlightAggroCols()
    HealBot_Action_SetHightlightTargetAggroCols()
    HealBot_Action_SetAggroCols()
    HealBot_Panel_SetNumBars(HealBot_Globals.TestBars["BARS"])
    HealBot_Panel_SethbTopRole(HealBot_Globals.TopRole)
    local x=HealBot_Globals.ttalpha+0.12
    if x>1 then x=1 end
    HealBot_Tooltip:SetBackdropBorderColor(0.32,0.32,0.4, x)
    HealBot_setOptions_Timer(200)
    HealBot_Action_setLowManaTrig()
    HealBot_Options_MonitorBuffs_Toggle()
    HealBot_Options_MonitorDebuffs_Toggle()
    --
    HealBot_setOptions_Timer(8000)
    HealBot_Data["PGUID"]=UnitGUID("player")
    HealBot_PlayerBuff[HealBot_Data["PGUID"]]={}
    HealBot_setHbStanceBuffs()
    HealBot_InitSpells()
    HealBot_useCrashProtection()
    HealBot_Options_Set_Current_Skin()
    HealBot_Action_ResetSkin("init")
    HealBot_InitNewChar()
    HealBot_Options_SetSkins();
    HealBot_configClassHoT()
    if HealBot_luVars["AddonMsgType"]==2 then HealBot_Comms_SendAddonMsg("CTRA", "SR", HealBot_luVars["AddonMsgType"], HealBot_Data["PNAME"]) end
    if not HealBot_luVars["HelpNotice"] then
        HealBot_setOptions_Timer(990)
        HealBot_luVars["HelpNotice"]=true
    end
    HealBot_Panel_SetmaxHealDiv(UnitLevel("player"))
    HealBot_setOptions_Timer(800)
    if hbCaller~="playerEW" then
        HealBot_OnEvent_PlayerEnteringWorld("Load")
    end
    HealBot_setOptions_Timer(140)
    if HealBot_Globals.ShowTooltip then
        HealBot_Options_LoadTips()
    end
    HealBot_setEnemyBars()
    HealBot_MMButton_Init();
  --HealBot_setCall("HealBot_Load")
end

local function HealBot_Register_Events()
    if HealBot_Config.DisabledNow==0 then
        HealBot:RegisterEvent("PLAYER_REGEN_DISABLED");
        HealBot:RegisterEvent("PLAYER_REGEN_ENABLED");
        HealBot:RegisterEvent("PLAYER_TARGET_CHANGED");
        HealBot:RegisterEvent("PLAYER_FOCUS_CHANGED");
        HealBot:RegisterEvent("UNIT_ENTERED_VEHICLE");
        HealBot:RegisterEvent("UNIT_EXITED_VEHICLE");
        HealBot:RegisterEvent("UNIT_EXITING_VEHICLE");
        HealBot:RegisterEvent("UNIT_HEALTH");
        HealBot:RegisterEvent("UNIT_MAXHEALTH");
        HealBot:RegisterEvent("UNIT_ABSORB_AMOUNT_CHANGED");
        local regPower=false
        for j=1,10 do
            if Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j]["POWERSIZE"]>0 then 
                regPower=true
            elseif Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j]["POWERCNT"] and  
               (HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_PALADIN] or HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_MONK]) then
                regPower=true
            end
        end
        if regPower or Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["LOWMANA"]>1 then
            HealBot_Register_Mana() 
		end
        HealBot:RegisterEvent("LEARNED_SPELL_IN_TAB");
        HealBot:RegisterEvent("PLAYER_TALENT_UPDATE");
        HealBot:RegisterEvent("UNIT_AURA");
        HealBot:RegisterEvent("CHARACTER_POINTS_CHANGED");
        HealBot:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
		HealBot:RegisterEvent("INSPECT_READY");
        HealBot:RegisterEvent("CHAT_MSG_SYSTEM");
        HealBot:RegisterEvent("MODIFIER_STATE_CHANGED");
        HealBot:RegisterEvent("UNIT_PET");
        HealBot:RegisterEvent("UNIT_NAME_UPDATE");
        if Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["SHOW"] then HealBot_Register_Aggro() end

		HealBot:RegisterEvent("ROLE_CHANGED_INFORM");
        local regThis={}
        for j=1,10 do
            if Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][j]["SHOW"] then regThis["RAIDTARGET"]=true end
            if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][j]["SHOWRC"] then regThis["READYCHECK"]=true end
            if Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][j]["IC"]>1 or Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][j]["AC"]>1 then regThis["INCHEAL"]=true end
        end
        if regThis["RAIDTARGET"] then HealBot:RegisterEvent("RAID_TARGET_UPDATE") end
        if regThis["READYCHECK"] then HealBot_Register_ReadyCheck() end
        if regThis["INCHEAL"] then HealBot_Register_IncHeals() end
        HealBot:RegisterEvent("UNIT_SPELLCAST_SENT");
        HealBot:RegisterEvent("UNIT_SPELLCAST_START");
        HealBot:RegisterEvent("UNIT_SPELLCAST_STOP");
        HealBot:RegisterEvent("UNIT_SPELLCAST_FAILED");
        HealBot:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED");
        HealBot:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED");
        HealBot:RegisterEvent("UPDATE_MACROS");
        HealBot:RegisterEvent("UNIT_CONNECTION");
        HealBot:RegisterEvent("COMPANION_LEARNED");
        HealBot:RegisterEvent("PLAYER_CONTROL_GAINED");
        HealBot:RegisterEvent("PET_BATTLE_OPENING_START");
        HealBot:RegisterEvent("PET_BATTLE_OVER");
        if HealBot_Globals.EnLibQuickHealth then HealBot:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED") end
    end
    HealBot:RegisterEvent("GROUP_ROSTER_UPDATE");
    HealBot:RegisterEvent("CHAT_MSG_ADDON");
    HealBot:RegisterEvent("ZONE_CHANGED_NEW_AREA");
    HealBot:RegisterEvent("ZONE_CHANGED");
    HealBot:RegisterEvent("ZONE_CHANGED_INDOORS");
    HealBot_setOptions_Timer(125)
  --HealBot_setCall("HealBot_Register_Events")
end

local function HealBot_UnRegister_Events()
    if HealBot_Config.DisabledNow==1 then
        HealBot:UnregisterEvent("ZONE_CHANGED_NEW_AREA");
        HealBot:UnregisterEvent("ZONE_CHANGED");
        HealBot:UnregisterEvent("ZONE_CHANGED_INDOORS");
        HealBot:UnregisterEvent("PLAYER_REGEN_DISABLED");
        HealBot:UnregisterEvent("PLAYER_REGEN_ENABLED");
        HealBot:UnregisterEvent("UNIT_ENTERED_VEHICLE");
        HealBot:UnregisterEvent("UNIT_EXITED_VEHICLE");
        HealBot:UnregisterEvent("UNIT_EXITING_VEHICLE");
        HealBot:UnregisterEvent("PLAYER_TARGET_CHANGED");
        HealBot:UnregisterEvent("PLAYER_FOCUS_CHANGED");
        HealBot:UnregisterEvent("GROUP_ROSTER_UPDATE");
        HealBot:UnregisterEvent("UNIT_HEALTH");
        HealBot_UnRegister_Mana()
        HealBot_UnRegister_ReadyCheck()
        HealBot_UnRegister_IncHeals()
        HealBot:UnregisterEvent("UNIT_AURA");
        HealBot:UnregisterEvent("CHAT_MSG_SYSTEM");
        HealBot_UnRegister_Aggro()
        HealBot:UnregisterEvent("UNIT_PET");
        HealBot:UnregisterEvent("UNIT_NAME_UPDATE");
		HealBot:UnregisterEvent("ROLE_CHANGED_INFORM");
        HealBot:UnregisterEvent("PLAYER_TALENT_UPDATE");
        HealBot:UnregisterEvent("COMPANION_LEARNED");
        HealBot:UnregisterEvent("MODIFIER_STATE_CHANGED");
        HealBot:UnregisterEvent("PLAYER_CONTROL_GAINED");
        HealBot:UnregisterEvent("UNIT_TARGET")
    end

    HealBot:UnregisterEvent("RAID_TARGET_UPDATE")
    HealBot:UnregisterEvent("LEARNED_SPELL_IN_TAB");
    HealBot:UnregisterEvent("UNIT_SPELLCAST_SENT");
    HealBot:UnregisterEvent("UNIT_SPELLCAST_START");
    HealBot:UnregisterEvent("UNIT_SPELLCAST_STOP");
    HealBot:UnregisterEvent("UNIT_SPELLCAST_FAILED");
    HealBot:UnregisterEvent("UNIT_SPELLCAST_INTERRUPTED");
    HealBot:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED");
	HealBot:UnregisterEvent("INSPECT_READY");
    HealBot:UnregisterEvent("CHARACTER_POINTS_CHANGED");
    HealBot:UnregisterEvent("PLAYER_SPECIALIZATION_CHANGED");
    HealBot:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
    HealBot:UnregisterEvent("PET_BATTLE_OPENING_START");
    HealBot:UnregisterEvent("PET_BATTLE_OVER");
  --HealBot_setCall("HealBot_UnRegister_Events")
end

local function HealBot_EndAggro()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_ClearUnitAggro(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_ClearUnitAggro(xButton)
    end
  --HealBot_setCall("HealBot_EndAggro")
end

local function HealBot_Reset(rType)
    if rType=="Full" then
        HealBot_UnRegister_Events()
        HealBot_Panel_ClearBlackList()
        HealBot_Panel_ClearHealTargets()
        HealBot_Action_ResethbInitButtons()
        HealBot_EndAggro() 
        HealBot_Panel_ClearBarArrays()
        HealBot_setOptions_Timer(150)
        HealBot_Load("hbReset") 
        HealBot_setOptions_Timer(420)
        HealBot_setOptions_Timer(7950)
        HealBot_Register_Events()
    else
        for _,xButton in pairs(HealBot_Unit_Button) do
            xButton.reset=true
        end
        for _,xButton in pairs(HealBot_Pet_Button) do
            xButton.reset=true
        end
        HealBot_nextRecalcParty(0)
    end
  --HealBot_setCall("HealBot_Reset")
end

local function HealBot_OnEvent_UnitNameUpdate(button)
    button.update.unit=true
    button.status.update=true
  --HealBot_setCall("HealBot_OnEvent_UnitNameUpdate")
end

local function HealBot_UnitID(unit)   
    local idGUID=HealBot_UnitGUID(unit)
    local xButton=HealBot_Unit_Button[unit] or HealBot_Pet_Button[unit]   
    if xButton and idGUID then
        if xButton.guid~=idGUID and HealBot_Unit_Button[unit] then
            xButton.update.unit=true
            xButton.status.update=true
        end
        return unit, idGUID, xButton
    elseif idGUID and HealBot_UnitData[idGUID] and UnitIsUnit(unit,HealBot_UnitData[idGUID]["UNIT"]) and HealBot_Unit_Button[HealBot_UnitData[idGUID]["UNIT"]] then
        return HealBot_UnitData[idGUID]["UNIT"], idGUID, HealBot_Unit_Button[HealBot_UnitData[idGUID]["UNIT"]]
    elseif idGUID and HealBot_UnitData[idGUID] and UnitIsUnit(unit,HealBot_UnitData[idGUID]["UNIT"]) and HealBot_Pet_Button[HealBot_UnitData[idGUID]["UNIT"]] then
        return HealBot_UnitData[idGUID]["UNIT"], idGUID, HealBot_Pet_Button[HealBot_UnitData[idGUID]["UNIT"]]
    end
  --HealBot_setCall("HealBot_UnitID")
    return nil,nil
end

function HealBot_HealsInUpdate(button)
    button.health.updincoming=false
    local ebubar2 = _G["HealBot_Action_HealUnit"..button.id.."Bar2"]
    if UnitExists(button.unit) and button.health.current<button.health.max and button.status.current>3 and button.status.current<9 and button.status.range>0 then
        local healin=(UnitGetIncomingHeals(button.unit) or 0)
        if button.health.incoming~=healin or (healin==0 and ebubar2:GetValue()>0) then
            button.health.incoming=healin
            HealBot_Action_setHealthText(button)
            HealBot_Action_UpdateHealsInButton(button)
        end
    elseif button.health.incoming>0 or ebubar2:GetValue()>0 then
        button.health.incoming=0
        HealBot_Action_setHealthText(button)
        ebubar2:SetValue(0)
        ebubar2:SetStatusBarColor(0,0,0,0);
        HealBot_Action_HBText(button)
    end
  --HealBot_setCall("HealBot_HealsInUpdate")
end

function HealBot_AbsorbsUpdate(button)
    button.health.updabsorbs=false
    local ebubar6 = _G["HealBot_Action_HealUnit"..button.id.."Bar6"]
    if UnitExists(button.unit) and button.health.current<button.health.max and button.status.current>3 and button.status.current<9 and button.status.range>0 then
        local absorb=(UnitGetTotalAbsorbs(button.unit) or 0)
        if button.health.absorbs~=absorb or (absorb==0 and ebubar6:GetValue()>0) then
            button.health.absorbs=absorb
            HealBot_Action_setHealthText(button)
            HealBot_Action_UpdateAbsorbsButton(button)
        end
    elseif button.health.absorbs>0 or ebubar6:GetValue()>0 then
        button.health.absorbs=0
        HealBot_Action_setHealthText(button)
        ebubar6:SetValue(0)
        ebubar6:SetStatusBarColor(0,0,0,0);
        HealBot_Action_HBText(button)
    end
  --HealBot_setCall("HealBot_AbsorbsUpdate")
end

function HealBot_Range_CheckTime(button)
    HealBot_luVars["RangeCheckTime"]=HealBot_luVars["RangeCheckTime"]+(HealBot_Timers["CheckTimeMod"])
    if HealBot_luVars["RangeCheckTime"]<TimeNow then
        HealBot_luVars["RangeCheckTime"]=TimeNow+0.02
    end
    button.checks.range=HealBot_luVars["RangeCheckTime"]
    --HealBot_setCall("HealBot_Range_CheckTime")
end

function HealBot_Other_CheckTime(button)
    HealBot_luVars["OtherCheckTime"]=HealBot_luVars["OtherCheckTime"]+(HealBot_Timers["CheckTimeMod"] * 2)
    if HealBot_luVars["OtherCheckTime"]<TimeNow then
        HealBot_luVars["OtherCheckTime"]=TimeNow+0.1
    end
    button.checks.other=HealBot_luVars["OtherCheckTime"]
    --HealBot_setCall("HealBot_Other_CheckTime")
end

function HealBot_Enemy_CheckTime(button)
    HealBot_luVars["EnemyCheckTime"]=HealBot_luVars["EnemyCheckTime"]+0.025
    if HealBot_luVars["EnemyCheckTime"]<TimeNow then
        HealBot_luVars["EnemyCheckTime"]=TimeNow+0.05
    end
    button.checks.other=HealBot_luVars["EnemyCheckTime"]
    --HealBot_setCall("HealBot_Enemy_CheckTime")
end

function HealBot_PetRange_CheckTime(button)
    HealBot_luVars["PetRangeCheckTime"]=HealBot_luVars["PetRangeCheckTime"]+(HealBot_Timers["CheckTimeMod"] * 2)
    if HealBot_luVars["PetRangeCheckTime"]<TimeNow then
        HealBot_luVars["PetRangeCheckTime"]=TimeNow+0.04
    end
    button.checks.range=HealBot_luVars["PetRangeCheckTime"]
    --HealBot_setCall("HealBot_PetRange_CheckTime")
end

local function HealBot_DoUnitNameUpdate(unUnit,unGUID)
    if unGUID then
        if unGUID==HealBot_Data["PGUID"] then 
            unUnit="player" 
        elseif unUnit=="target" then
            unUnit=HealBot_Panel_RaidUnit(unGUID) or "target"
        end
    end
    if HealBot_Unit_Button[unUnit] then
        local unb=HealBot_Unit_Button[unUnit]
        local doUpdate=false
        if unGUID then
            if HealBot_notVisible[unGUID] then 
                HealBot_notVisible[unGUID]=unUnit 
            end
            if HealBot_UnitData[unGUID] then
                HealBot_UnitData[unGUID]["UNIT"]=unUnit
            else
                doUpdate=true
            end
        else
            doUpdate=true
        end
        if doUpdate then
            if unb.status.unittype==1 then 
                HealBot_nextRecalcParty(6)
            end
        end
        unb.guid=unGUID or HealBot_UnitGUID(unUnit) or unUnit or "nk"
        unb.update.unit=true
        unb.status.update=true
    end
  --HealBot_setCall("HealBot_DoUnitNameUpdate")
end

function HealBot_UnitNameUpdate(unUnit,unGUID)
    HealBot_DoUnitNameUpdate(unUnit,unGUID)
end

local function HealBot_ResetCustomDebuffs()
    HealBot_Globals.HealBot_Custom_Debuffs=HealBot_Options_copyTable(HealBot_GlobalsDefaults.HealBot_Custom_Debuffs)
    HealBot_Globals.Custom_Debuff_Categories=HealBot_Options_copyTable(HealBot_GlobalsDefaults.Custom_Debuff_Categories)
    HealBot_Globals.FilterCustomDebuff=HealBot_Options_copyTable(HealBot_GlobalsDefaults.FilterCustomDebuff)
    HealBot_Globals.CDCBarColour=HealBot_Options_copyTable(HealBot_GlobalsDefaults.CDCBarColour)
    HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol=(HealBot_GlobalsDefaults.HealBot_Custom_Debuffs_ShowBarCol)
    HealBot_Options_NewCDebuff:SetText("")
    HealBot_Options_InitSub(407)
    HealBot_Options_InitSub(408)
    HealBot_Options_InitSub(419)
    HealBot_SetCDCBarColours();
    HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_CONFIRMCUSTOMDEFAULTS)
  --HealBot_setCall("HealBot_ResetCustomDebuffs")
end

local function HealBot_ResetSkins()
    Healbot_Config_Skins = HealBot_Config_SkinsDefaults
    HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_CONFIRMSKINDEFAULTS)
    HealBot_Config.LastVersionSkinUpdate=HealBot_lastVerSkinUpdate
    HealBot_Options_ReloadUI(HEALBOT_CMD_RESETSKINS)
  --HealBot_setCall("HealBot_ResetSkins")
end

local function HealBot_RemoveIcon(button, index)
    if not button then return; end;
    local bar = _G["HealBot_Action_HealUnit"..button.id.."Bar"]
    local iconName = _G[bar:GetName().."Icon"..index];
    local iconExpire = _G[bar:GetName().."Expire"..index];
    local iconCount = _G[bar:GetName().."Count"..index];
    iconName:SetAlpha(0)
    iconExpire:SetTextColor(1,1,1,0);
    iconCount:SetTextColor(1,1,1,0)
    iconExpire:SetText(" ");
    iconCount:SetText(" ");
  --HealBot_setCall("HealBot_RemoveIcon")
end

local function HealBot_Icon_AlphaValue(secLeft, curFrame)
    if secLeft>=0 and secLeft<12 and Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][curFrame]["FADE"] then
        return (secLeft/11)+.2
    elseif secLeft>=0 then
        return 1
    end
  --HealBot_setCall("HealBot_Icon_AlphaValue")
    return 0
end

local function HealBot_UpdateIcon(button, iconData)
    if not button then return; end;
    local bar = _G["HealBot_Action_HealUnit"..button.id.."Bar"]
    local iconName = _G[bar:GetName().."Icon"..iconData.index];
    local iconExpire = _G[bar:GetName().."Expire"..iconData.index];
    local iconCount = _G[bar:GetName().."Count"..iconData.index];
    if iconData.expirationTime>0 then
        iconName:SetAlpha(HealBot_Icon_AlphaValue(iconData.expirationTime-TimeNow, button.frame))
    end
    if Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][button.frame]["SDUR"] and iconData.expirationTime>0 then
        local secLeft=floor(iconData.expirationTime-TimeNow)
        if secLeft>-1 and secLeft<Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][button.frame]["DURTHRH"] then
            iconExpire:SetText(secLeft);
            if secLeft<=Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][button.frame]["DURWARN"] then
                if iconData.index > 50 then
                    iconExpire:SetTextColor(0,1,0,1);
                else
                    iconExpire:SetTextColor(1,0,0,1);
                end
            else
                iconExpire:SetTextColor(1,1,1,1);
            end  
        else
            iconExpire:SetTextColor(1,1,1,0)
            iconExpire:SetText(" ");
        end
    else
        iconExpire:SetTextColor(1,1,1,0)
        iconExpire:SetText(" ");
    end
    if iconData.count > 1 then
        iconCount:SetText(iconData.count);
        iconCount:SetTextColor(1,1,1,1);
    else
        iconCount:SetTextColor(1,1,1,0)
        iconCount:SetText(" ");
    end
  --HealBot_setCall("HealBot_UpdateIcon")
end

local function HealBot_AddIcon(button, iconData)
    if not button then return; end;
    local bar = _G["HealBot_Action_HealUnit"..button.id.."Bar"]
    local iconName = _G[bar:GetName().."Icon"..iconData.index];
    iconName:SetTexture(iconData.texture)
    iconName:SetAlpha(1)
  --HealBot_setCall("HealBot_AddIcon")
end

local function HealBot_RaidTargetUpdate(button, iconID)
    local prevId=button.icon.debuff.targeticon
    button.icon.debuff.targeticon=iconID
    if button.icon.debuff.targeticon~=prevId then
        HealBot_DebuffChecks(button)
    end
  --HealBot_setCall("HealBot_RaidTargetUpdate")
end

function HealBot_setUnitIcons(unit)
    if not HealBot_UnitDebuffIcons[unit] then HealBot_UnitDebuffIcons[unit]={} end
    if not HealBot_UnitBuffIcons[unit] then HealBot_UnitBuffIcons[unit]={} end
  --HealBot_setCall("HealBot_setUnitIcons")
end

local hbExcludeSpells = { [67358]="Rejuvenating",
                          [58597]="Sacred Shield",
                          --[65148]="Sacred Shield",
                        }
                        
local hbExcludeBuffSpells = { [65148]="Sacred Shield",
                        }

local function HealBot_SetBuffIcon(button, UnitBuffIcons, name, texture, count, expirationTime, unitCaster)
    if button.icon.buff.count<Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["MAXBICONS"] then
        button.icon.buff.count=button.icon.buff.count+1
        if not UnitBuffIcons[name] then 
            UnitBuffIcons[name]={}
            UnitBuffIcons[name].texture=texture
        end
        UnitBuffIcons[name].count=count
        UnitBuffIcons[name].expirationTime=expirationTime
        UnitBuffIcons[name].unitCaster=unitCaster
        UnitBuffIcons[name].current=true
        if (UnitBuffIcons[name].index or 0)~=button.icon.buff.count then
            UnitBuffIcons[name].index=button.icon.buff.count
            HealBot_AddIcon(button, UnitBuffIcons[name])
        end
        if expirationTime>0 then
            UnitBuffIcons[name].nextUpdate=floor(TimeNow-2) + expirationTime%3 + 0.002
        else
            UnitBuffIcons[name].nextUpdate=TimeNow+1000000
            HealBot_UpdateIcon(button, UnitBuffIcons[name])
        end
    end
  --HealBot_setCall("HealBot_SetBuffIcon")
end

function HealBot_RecalcHeals(button)
    HealBot_Action_Refresh(button);
  --HealBot_setCall("HealBot_RecalcHeals")
end

function HealBot_Reset_Unit(button)
    xButton.update.reset=true
    xButton.status.update=true
    HealBot_Action_ResetUnitStatus(button)
    if HealBot_Action_RetMyTarget(button.guid) then HealBot_Action_Toggle_Enabled(button); end
  --HealBot_setCall("HealBot_Reset_Unit")
end

function HealBot_GetSpellId(spellName)
    if (not spellName) then return nil end
    if HealBot_Spells[spellName] and HealBot_Spells[spellName].known then   
        return HealBot_Spells[spellName].id; 
    end
  --HealBot_setCall("HealBot_GetSpellId")
    return nil;
end

function HealBot_IncHeals_retHealsIn(unit, button)
    local x=button.health.incoming
    local y=button.health.absorbs
    if Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AC"]<2 then y=0 end
    if Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IC"]<2 then x=0 end
  --HealBot_setCall("HealBot_IncHeals_retHealsIn")
    return x, y
end

local function HealBot_IncHeals_ClearAll()
    for xUnit,xButton in pairs(HealBot_Unit_Button) do
        xButton.health.incoming=0
        xButton.health.absorbs=0
        HealBot_Action_UpdateHealsInButton(xButton)
        HealBot_Action_UpdateAbsorbsButton(xButton)
    end
    for xUnit,xButton in pairs(HealBot_Pet_Button) do
        xButton.health.incoming=0
        xButton.health.absorbs=0
        HealBot_Action_UpdateHealsInButton(xButton)
        HealBot_Action_UpdateAbsorbsButton(xButton)
    end
  --HealBot_setCall("HealBot_IncHeals_ClearAll")
end

local function HealBot_OnEvent_Combat_Log(self, timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, ...)
    if HealBot_UnitData[destGUID] and UnitExists(HealBot_UnitData[destGUID]["UNIT"]) and HealBot_Unit_Button[HealBot_UnitData[destGUID]["UNIT"]] then
        local xButton=HealBot_Unit_Button[HealBot_UnitData[destGUID]["UNIT"]]
        if xButton then
            if (event == "SWING_DAMAGE" or event == "SPELL_PERIODIC_DAMAGE" or event == "SPELL_DAMAGE" or event == "DAMAGE_SPLIT" or
                event == "DAMAGE_SHIELD" or event == "ENVIRONMENTAL_DAMAGE") and xButton.health.current > 0 then
                xButton.health.updhealth=true
                xButton.health.update=true
            elseif (event == "SPELL_HEAL" or event == "SPELL_PERIODIC_HEAL") and xButton.health.current < xButton.health.max then
                xButton.health.updincoming=true
                xButton.health.updabsorbs=true
                xButton.health.updhealth=true
                xButton.health.update=true
            end
        end
    end
  --HealBot_setCall("HealBot_OnEvent_Combat_Log")
end

function HealBot_OnLoad(self)
    HealBot:RegisterEvent("VARIABLES_LOADED");
    HealBot:RegisterEvent("PLAYER_REGEN_DISABLED");
    HealBot:RegisterEvent("PLAYER_REGEN_ENABLED");
    HealBot:RegisterEvent("GET_ITEM_INFO_RECEIVED");
    SLASH_HEALBOT1 = "/healbot";
    SLASH_HEALBOT2 = "/hb";
    SlashCmdList["HEALBOT"] = function(msg)
        HealBot_SlashCmd(msg);
    end
  --HealBot_setCall("HealBot_OnLoad")
end

function HealBot_Set_Timers()
    if HealBot_Config.DisabledNow==0 then
        HealBot_Timers["HB1Th"]=HealBot_Comm_round((1+(HealBot_Globals.RangeCheckFreq*4))/(HealBot_luVars["qaFR"]/10), 4) -- At 50FPS with default settings = 0.36
        HealBot_Timers["HB2Th"]=HealBot_Comm_round(HealBot_Globals.RangeCheckFreq/(HealBot_luVars["qaFR"]/4), 4) -- At 50FPS with default settings = 0.016
        HealBot_Timers["HBaTh"]=0.01+(HealBot_Globals.RangeCheckFreq/20)
    else
        HealBot_Timers["HB1Th"]=1
        HealBot_Timers["HB2Th"]=1
        HealBot_Timers["HBaTh"]=10
    end
    HealBot_CheckTime_Modifier()
  --HealBot_setCall("HealBot_Set_Timers")
end

local HealBot_Options_Timer={}
function HealBot_setOptions_Timer(value)
    HealBot_luVars["HealBot_Options_Timer"]=value
    HealBot_Options_Timer[value]=true
    if value==500 then HealBot_Timers["HB1Th"]=0.01 end
  --HealBot_setCall("HealBot_setOptions_Timer")
  --HealBot_setCall("HealBot_setOptions_Timer-"..value)
end

local HealBot_ErrorNum=0
local hbRequestTime=0

local function HealBot_setqaFR()
    HealBot_luVars["qaFR3"]=HealBot_luVars["qaFR2"]
    HealBot_luVars["qaFR2"]=HealBot_luVars["qaFR1"]
    HealBot_luVars["qaFR1"]=GetFramerate()
    if HealBot_luVars["qaFR1"]>120 then 
        HealBot_luVars["qaFR1"]=120 
    elseif HealBot_luVars["qaFR1"]<40 then
        HealBot_luVars["qaFR1"]=40
    end
    HealBot_luVars["qaFR"]=HealBot_Comm_round((HealBot_luVars["qaFR1"]+HealBot_luVars["qaFR2"]+HealBot_luVars["qaFR3"])/3, 2)       
  --HealBot_setCall("HealBot_setqaFR")
end

local function HealBot_Update_DefaultSkins()
    local cacheSkinDefaults=HealBot_Options_copyTable(HealBot_Config.SkinDefault)
    HealBot_Config.SkinDefault={}
    for x in pairs (Healbot_Config_Skins.Skins) do
        HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]] = {[HEALBOT_WORD_SOLO]=false, 
                                                                     [HEALBOT_WORD_PARTY]=false, 
                                                                     [HEALBOT_OPTIONS_RAID10]=false, 
                                                                     [HEALBOT_OPTIONS_RAID25]=false, 
                                                                     [HEALBOT_OPTIONS_RAID40]=false,
                                                                     [HEALBOT_WORD_ARENA]=false, 
                                                                     [HEALBOT_WORD_BG10]=false, 
                                                                     [HEALBOT_WORD_BG15]=false, 
                                                                     [HEALBOT_WORD_BG40]=false, 
                                                                     [HEALBOT_WORD_PETBATTLE]=false}
        if cacheSkinDefaults[Healbot_Config_Skins.Skins[x]]==2 then
            HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]][HEALBOT_WORD_SOLO]=true;
        elseif cacheSkinDefaults[Healbot_Config_Skins.Skins[x]]==3 then
            HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]][HEALBOT_WORD_PARTY]=true;
        elseif cacheSkinDefaults[Healbot_Config_Skins.Skins[x]]==4 then
            HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]][HEALBOT_OPTIONS_RAID10]=true;
        elseif cacheSkinDefaults[Healbot_Config_Skins.Skins[x]]==5 then
            HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]][HEALBOT_OPTIONS_RAID25]=true;
        elseif cacheSkinDefaults[Healbot_Config_Skins.Skins[x]]==6 then
            HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]][HEALBOT_OPTIONS_RAID40]=true;
        elseif cacheSkinDefaults[Healbot_Config_Skins.Skins[x]]==7 then
            HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]][HEALBOT_WORD_ARENA]=true;
        elseif cacheSkinDefaults[Healbot_Config_Skins.Skins[x]]==8 then
            HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]][HEALBOT_WORD_BG10]=true;
        elseif cacheSkinDefaults[Healbot_Config_Skins.Skins[x]]==9 then
            HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]][HEALBOT_WORD_BG15]=true;
        elseif cacheSkinDefaults[Healbot_Config_Skins.Skins[x]]==10 then
            HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]][HEALBOT_WORD_BG40]=true;
        elseif cacheSkinDefaults[Healbot_Config_Skins.Skins[x]]==11 then
            HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]][HEALBOT_WORD_PETBATTLE]=true;
        end
    end
  --HealBot_setCall("HealBot_Update_DefaultSkins")
end

function HealBot_Check_Skin(SkinName)
    if not Healbot_Config_Skins.EmergIncMonitor[SkinName] then Healbot_Config_Skins.EmergIncMonitor[SkinName]=1 end
    if not Healbot_Config_Skins.ExtraIncGroup[SkinName] then 
        Healbot_Config_Skins.ExtraIncGroup[SkinName]={[1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true}
    end           
    if not Healbot_Config_Skins.HealGroups[SkinName] then Healbot_Config_Skins.HealGroups[SkinName]={
        [1] = {["NAME"]=HEALBOT_OPTIONS_SELFHEALS_en,["STATE"]=false,["FRAME"]=1}, 
        [2] = {["NAME"]=HEALBOT_OPTIONS_TANKHEALS_en,["STATE"]=true,["FRAME"]=1},
        [3] = {["NAME"]=HEALBOT_CLASSES_HEALERS_en,["STATE"]=false,["FRAME"]=1}, 
        [4] = {["NAME"]=HEALBOT_OPTIONS_GROUPHEALS_en,["STATE"]=true,["FRAME"]=1}, 
        [5] = {["NAME"]=HEALBOT_OPTIONS_EMERGENCYHEALS_en,["STATE"]=true,["FRAME"]=1}, 
        [6] = {["NAME"]=HEALBOT_OPTIONS_MYTARGET_en,["STATE"]=true,["FRAME"]=1}, 
        [7] = {["NAME"]=HEALBOT_VEHICLE_en,["STATE"]=false,["FRAME"]=6},
        [8] = {["NAME"]=HEALBOT_OPTIONS_PETHEALS_en,["STATE"]=false,["FRAME"]=7},
        [9] = {["NAME"]=HEALBOT_OPTIONS_TARGETHEALS_en,["STATE"]=false,["FRAME"]=8},
       [10] = {["NAME"]=HEALBOT_FOCUS_en,["STATE"]=false,["FRAME"]=9}, 
       [11] = {["NAME"]=HEALBOT_CUSTOM_CASTBY_ENEMY_en,["STATE"]=false,["FRAME"]=10},}
    else
        local freeHealGroups={}
        table.insert(freeHealGroups,HEALBOT_OPTIONS_SELFHEALS_en)
        table.insert(freeHealGroups,HEALBOT_OPTIONS_TANKHEALS_en)
        table.insert(freeHealGroups,HEALBOT_CLASSES_HEALERS_en)
        table.insert(freeHealGroups,HEALBOT_OPTIONS_GROUPHEALS_en)
        table.insert(freeHealGroups,HEALBOT_OPTIONS_EMERGENCYHEALS_en)
        table.insert(freeHealGroups,HEALBOT_OPTIONS_MYTARGET_en)
        table.insert(freeHealGroups,HEALBOT_VEHICLE_en)
        table.insert(freeHealGroups,HEALBOT_OPTIONS_PETHEALS_en)
        table.insert(freeHealGroups,HEALBOT_OPTIONS_TARGETHEALS_en)
        table.insert(freeHealGroups,HEALBOT_FOCUS_en)
        table.insert(freeHealGroups,HEALBOT_CUSTOM_CASTBY_ENEMY_en)
        
        for gl=1,11 do
            if not Healbot_Config_Skins.HealGroups[SkinName][gl] then Healbot_Config_Skins.HealGroups[SkinName][gl]={} end
            if Healbot_Config_Skins.HealGroups[SkinName][gl]["NAME"] then
                local mti=0
                for z=1, #freeHealGroups do
                    if Healbot_Config_Skins.HealGroups[SkinName][gl]["NAME"]==freeHealGroups[z] then
                        mti=z
                    end
                end
                if mti>0 then
                    table.remove(freeHealGroups,mti)
                end
            end
        end
        for gl=1,11 do
            if not Healbot_Config_Skins.HealGroups[SkinName][gl]["NAME"] then
                Healbot_Config_Skins.HealGroups[SkinName][gl]["NAME"]=freeHealGroups[1]
                table.remove(freeHealGroups,1)
            end
            if not Healbot_Config_Skins.HealGroups[SkinName][gl]["STATE"] then Healbot_Config_Skins.HealGroups[SkinName][gl]["STATE"]=false end
            if not Healbot_Config_Skins.HealGroups[SkinName][gl]["FRAME"] then 
                if Healbot_Config_Skins.HealGroups[SkinName][gl]["NAME"]==HEALBOT_CUSTOM_CASTBY_ENEMY_en then
                    Healbot_Config_Skins.HealGroups[SkinName][gl]["FRAME"]=10
                elseif Healbot_Config_Skins.HealGroups[SkinName][gl]["NAME"]==HEALBOT_FOCUS_en then
                    Healbot_Config_Skins.HealGroups[SkinName][gl]["FRAME"]=9
                elseif Healbot_Config_Skins.HealGroups[SkinName][gl]["NAME"]==HEALBOT_OPTIONS_TARGETHEALS_en then
                    Healbot_Config_Skins.HealGroups[SkinName][gl]["FRAME"]=8
                elseif Healbot_Config_Skins.HealGroups[SkinName][gl]["NAME"]==HEALBOT_OPTIONS_PETHEALS_en then
                    Healbot_Config_Skins.HealGroups[SkinName][gl]["FRAME"]=7
                elseif Healbot_Config_Skins.HealGroups[SkinName][gl]["NAME"]==HEALBOT_VEHICLE_en then
                    Healbot_Config_Skins.HealGroups[SkinName][gl]["FRAME"]=6
                else
                    Healbot_Config_Skins.HealGroups[SkinName][gl]["FRAME"]=1 
                end
            end
        end
    end
    if not Healbot_Config_Skins.HeadText[SkinName] then Healbot_Config_Skins.HeadText[SkinName]={} end
    if not Healbot_Config_Skins.HeadBar[SkinName] then Healbot_Config_Skins.HeadBar[SkinName]={} end
    if not Healbot_Config_Skins.Anchors[SkinName] then Healbot_Config_Skins.Anchors[SkinName]={} end
    if not Healbot_Config_Skins.FrameAlias[SkinName] then Healbot_Config_Skins.FrameAlias[SkinName]={} end
    if not Healbot_Config_Skins.HealBar[SkinName] then Healbot_Config_Skins.HealBar[SkinName]={} end
    if not Healbot_Config_Skins.BarCol[SkinName] then Healbot_Config_Skins.BarCol[SkinName]={} end
    if not Healbot_Config_Skins.BarIACol[SkinName] then Healbot_Config_Skins.BarIACol[SkinName]={} end
    if not Healbot_Config_Skins.BarText[SkinName] then Healbot_Config_Skins.BarText[SkinName]={} end
    if not Healbot_Config_Skins.BarTextCol[SkinName] then Healbot_Config_Skins.BarTextCol[SkinName]={} end
    if not Healbot_Config_Skins.Icons[SkinName] then Healbot_Config_Skins.Icons[SkinName]={} end
    if not Healbot_Config_Skins.RaidIcon[SkinName] then Healbot_Config_Skins.RaidIcon[SkinName]={} end
    if not Healbot_Config_Skins.BarsHide[SkinName] then Healbot_Config_Skins.BarsHide[SkinName]={} end
    if not Healbot_Config_Skins.IconText[SkinName] then Healbot_Config_Skins.IconText[SkinName]={} end
    if not Healbot_Config_Skins.Protection[SkinName] then Healbot_Config_Skins.Protection[SkinName]={} end
    if not Healbot_Config_Skins.Aggro[SkinName] then Healbot_Config_Skins.Aggro[SkinName]={} end
    if not Healbot_Config_Skins.Frame[SkinName] then Healbot_Config_Skins.Frame[SkinName]={} end
    if not Healbot_Config_Skins.Highlight[SkinName] then Healbot_Config_Skins.Highlight[SkinName]={} end
    if not Healbot_Config_Skins.Healing[SkinName] then Healbot_Config_Skins.Healing[SkinName]={} end
    if not Healbot_Config_Skins.General[SkinName] then Healbot_Config_Skins.General[SkinName]={} end
    if not Healbot_Config_Skins.Sort[SkinName] then Healbot_Config_Skins.Sort[SkinName]={} end
    if not Healbot_Config_Skins.Chat[SkinName] then Healbot_Config_Skins.Chat[SkinName]={} end
    if not Healbot_Config_Skins.Enemy[SkinName] then Healbot_Config_Skins.Enemy[SkinName]={} end
    for gl=1,10 do
        if not Healbot_Config_Skins.HeadText[SkinName][gl] then Healbot_Config_Skins.HeadText[SkinName][gl]={} end
        if not Healbot_Config_Skins.HeadBar[SkinName][gl] then Healbot_Config_Skins.HeadBar[SkinName][gl]={} end
        if not Healbot_Config_Skins.Anchors[SkinName][gl] then Healbot_Config_Skins.Anchors[SkinName][gl]={} end
        if not Healbot_Config_Skins.FrameAlias[SkinName][gl] then Healbot_Config_Skins.FrameAlias[SkinName][gl]={} end
        if not Healbot_Config_Skins.HealBar[SkinName][gl] then Healbot_Config_Skins.HealBar[SkinName][gl]={} end
        if not Healbot_Config_Skins.BarCol[SkinName][gl] then Healbot_Config_Skins.BarCol[SkinName][gl]={} end
        if not Healbot_Config_Skins.BarIACol[SkinName][gl] then Healbot_Config_Skins.BarIACol[SkinName][gl]={} end
        if not Healbot_Config_Skins.BarText[SkinName][gl] then Healbot_Config_Skins.BarText[SkinName][gl]={} end
        if not Healbot_Config_Skins.BarTextCol[SkinName][gl] then Healbot_Config_Skins.BarTextCol[SkinName][gl]={} end
        if not Healbot_Config_Skins.Icons[SkinName][gl] then Healbot_Config_Skins.Icons[SkinName][gl]={} end
        if not Healbot_Config_Skins.RaidIcon[SkinName][gl] then Healbot_Config_Skins.RaidIcon[SkinName][gl]={} end
        if not Healbot_Config_Skins.IconText[SkinName][gl] then Healbot_Config_Skins.IconText[SkinName][gl]={} end
        if not Healbot_Config_Skins.Frame[SkinName][gl] then Healbot_Config_Skins.Frame[SkinName][gl]={} end
    end

    for gl=1,10 do
        if Healbot_Config_Skins.Frame[SkinName][gl]["TIPLOC"]==nil then Healbot_Config_Skins.Frame[SkinName][gl]["TIPLOC"]=5 end
        if Healbot_Config_Skins.Frame[SkinName][gl]["AUTOCLOSE"]==nil then Healbot_Config_Skins.Frame[SkinName][gl]["AUTOCLOSE"]=false end
        if Healbot_Config_Skins.Frame[SkinName][gl]["OPENSOUND"]==nil then Healbot_Config_Skins.Frame[SkinName][gl]["OPENSOUND"]=false end
        if Healbot_Config_Skins.Frame[SkinName][gl]["LOCKED"]==nil then Healbot_Config_Skins.Frame[SkinName][gl]["LOCKED"]=false end
        if Healbot_Config_Skins.Frame[SkinName][gl]["SCALE"]==nil then Healbot_Config_Skins.Frame[SkinName][gl]["SCALE"]=1 end
        if Healbot_Config_Skins.Frame[SkinName][gl]["BACKR"]==nil then Healbot_Config_Skins.Frame[SkinName][gl]["BACKR"]=0.2 end
        if Healbot_Config_Skins.Frame[SkinName][gl]["BACKG"]==nil then Healbot_Config_Skins.Frame[SkinName][gl]["BACKG"]=0.2 end
        if Healbot_Config_Skins.Frame[SkinName][gl]["BACKB"]==nil then Healbot_Config_Skins.Frame[SkinName][gl]["BACKB"]=0.7 end
        if Healbot_Config_Skins.Frame[SkinName][gl]["BACKA"]==nil then Healbot_Config_Skins.Frame[SkinName][gl]["BACKA"]=0.1 end
        if Healbot_Config_Skins.Frame[SkinName][gl]["BORDERR"]==nil then Healbot_Config_Skins.Frame[SkinName][gl]["BORDERR"]=0.2 end
        if Healbot_Config_Skins.Frame[SkinName][gl]["BORDERG"]==nil then Healbot_Config_Skins.Frame[SkinName][gl]["BORDERG"]=0.2 end
        if Healbot_Config_Skins.Frame[SkinName][gl]["BORDERB"]==nil then Healbot_Config_Skins.Frame[SkinName][gl]["BORDERB"]=0.2 end
        if Healbot_Config_Skins.Frame[SkinName][gl]["BORDERA"]==nil then Healbot_Config_Skins.Frame[SkinName][gl]["BORDERA"]=0.4 end
        if Healbot_Config_Skins.IconText[SkinName][gl]["SCALE"]==nil then Healbot_Config_Skins.IconText[SkinName][gl]["SCALE"]=0.7 end
        if Healbot_Config_Skins.IconText[SkinName][gl]["DURTHRH"]==nil then Healbot_Config_Skins.IconText[SkinName][gl]["DURTHRH"]=9 end
        if Healbot_Config_Skins.IconText[SkinName][gl]["DURWARN"]==nil then Healbot_Config_Skins.IconText[SkinName][gl]["DURWARN"]=3 end
        if Healbot_Config_Skins.IconText[SkinName][gl]["SCNT"]==nil then Healbot_Config_Skins.IconText[SkinName][gl]["SCNT"]=true end
        if Healbot_Config_Skins.IconText[SkinName][gl]["SSCNT"]==nil then Healbot_Config_Skins.IconText[SkinName][gl]["SSCNT"]=false end
        if Healbot_Config_Skins.IconText[SkinName][gl]["SDUR"]==nil then Healbot_Config_Skins.IconText[SkinName][gl]["SDUR"]=true end
        if Healbot_Config_Skins.IconText[SkinName][gl]["SSDUR"]==nil then Healbot_Config_Skins.IconText[SkinName][gl]["SSDUR"]=true end
        if Healbot_Config_Skins.RaidIcon[SkinName][gl]["SHOW"]==nil then Healbot_Config_Skins.RaidIcon[SkinName][gl]["SHOW"]=true end
        if Healbot_Config_Skins.RaidIcon[SkinName][gl]["STAR"]==nil then Healbot_Config_Skins.RaidIcon[SkinName][gl]["STAR"]=true end
        if Healbot_Config_Skins.RaidIcon[SkinName][gl]["CIRCLE"]==nil then Healbot_Config_Skins.RaidIcon[SkinName][gl]["CIRCLE"]=true end
        if Healbot_Config_Skins.RaidIcon[SkinName][gl]["DIAMOND"]==nil then Healbot_Config_Skins.RaidIcon[SkinName][gl]["DIAMOND"]=true end
        if Healbot_Config_Skins.RaidIcon[SkinName][gl]["TRIANGLE"]==nil then Healbot_Config_Skins.RaidIcon[SkinName][gl]["TRIANGLE"]=true end
        if Healbot_Config_Skins.RaidIcon[SkinName][gl]["MOON"]==nil then Healbot_Config_Skins.RaidIcon[SkinName][gl]["MOON"]=true end
        if Healbot_Config_Skins.RaidIcon[SkinName][gl]["SQUARE"]==nil then Healbot_Config_Skins.RaidIcon[SkinName][gl]["SQUARE"]=true end
        if Healbot_Config_Skins.RaidIcon[SkinName][gl]["CROSS"]==nil then Healbot_Config_Skins.RaidIcon[SkinName][gl]["CROSS"]=true end
        if Healbot_Config_Skins.RaidIcon[SkinName][gl]["SKULL"]==nil then Healbot_Config_Skins.RaidIcon[SkinName][gl]["SKULL"]=true end
        if Healbot_Config_Skins.Icons[SkinName][gl]["ONBAR"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["ONBAR"]=1 end
        if Healbot_Config_Skins.Icons[SkinName][gl]["DOUBLE"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["DOUBLE"]=false end
        if Healbot_Config_Skins.Icons[SkinName][gl]["SHOWDEBUFF"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["SHOWDEBUFF"]=true end
        if Healbot_Config_Skins.Icons[SkinName][gl]["SHOWRC"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["SHOWRC"]=true end
        if Healbot_Config_Skins.Icons[SkinName][gl]["SHOWDIR"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["SHOWDIR"]=true end
        if Healbot_Config_Skins.Icons[SkinName][gl]["SHOWDIRMOUSE"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["SHOWDIRMOUSE"]=false end
        if Healbot_Config_Skins.Icons[SkinName][gl]["SCALE"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["SCALE"]=0.7 end
        if Healbot_Config_Skins.Icons[SkinName][gl]["I15EN"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["I15EN"]=true end
        if Healbot_Config_Skins.Icons[SkinName][gl]["SHOWBUFF"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["SHOWBUFF"]=true end
        if Healbot_Config_Skins.Icons[SkinName][gl]["POSITION"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["POSITION"]=2 end
        if Healbot_Config_Skins.Icons[SkinName][gl]["FADE"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["FADE"]=true end
        if Healbot_Config_Skins.Icons[SkinName][gl]["MAXDICONS"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["MAXDICONS"]=3 end
        if Healbot_Config_Skins.Icons[SkinName][gl]["MAXBICONS"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["MAXBICONS"]=8 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["ER"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["ER"]=1 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["EG"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["EG"]=1 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["EB"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["EB"]=0 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["EA"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["EA"]=1 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["DR"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["DR"]=0.5 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["DG"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["DG"]=0.5 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["DB"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["DB"]=0.5 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["DA"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["DA"]=0.4 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["CR"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["CR"]=1 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["CG"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["CG"]=1 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["CB"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["CB"]=1 end
        if Healbot_Config_Skins.BarTextCol[SkinName][gl]["CA"]==nil then Healbot_Config_Skins.BarTextCol[SkinName][gl]["CA"]=1 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["FONT"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["FONT"]=HealBot_Default_Font end
        if Healbot_Config_Skins.BarText[SkinName][gl]["HEIGHT"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["HEIGHT"]=10 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["CLASSTYPE"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["CLASSTYPE"]=1 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["SHOWROLE"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["SHOWROLE"]=true end
        if Healbot_Config_Skins.BarText[SkinName][gl]["CLASSONBAR"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["CLASSONBAR"]=false end
        if Healbot_Config_Skins.BarText[SkinName][gl]["NAMEONBAR"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["NAMEONBAR"]=true end
        if Healbot_Config_Skins.BarText[SkinName][gl]["HLTHONBAR"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["HLTHONBAR"]=true end
        if Healbot_Config_Skins.BarText[SkinName][gl]["CLASSCOL"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["CLASSCOL"]=false end
        if Healbot_Config_Skins.BarText[SkinName][gl]["ALIGN"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["ALIGN"]=2 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["DOUBLE"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["DOUBLE"]=true end
        if Healbot_Config_Skins.BarText[SkinName][gl]["INCHEALS"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["INCHEALS"]=2 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["NUMFORMAT1"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["NUMFORMAT1"]=1 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["NUMFORMAT2"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["NUMFORMAT2"]=1 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["OUTLINE"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["OUTLINE"]=1 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["HLTHTYPE"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["HLTHTYPE"]=1 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["MAXCHARS"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["MAXCHARS"]=0 end
        if Healbot_Config_Skins.BarText[SkinName][gl]["TAGDC"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["TAGDC"]=HEALBOT_DISCONNECTED_TAG end
        if Healbot_Config_Skins.BarText[SkinName][gl]["TAGRIP"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["TAGRIP"]=HEALBOT_DEAD_TAG end
        if Healbot_Config_Skins.BarText[SkinName][gl]["TAGOOR"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["TAGOOR"]=HEALBOT_OUTOFRANGE_TAG end
        if Healbot_Config_Skins.BarText[SkinName][gl]["TAGR"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["TAGR"]=HEALBOT_RESERVED_TAG end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["IC"]==nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["IC"]=4 end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["IR"]==nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["IR"]=0.2 end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["IG"]==nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["IG"]=1 end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["IB"]==nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["IB"]=0.2 end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["IA"]==nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["IA"]=0.82 end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["AC"]==nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["AC"]=3 end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["AR"]==nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["AR"]=1 end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["AG"]==nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["AG"]=1 end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["AB"]==nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["AB"]=1 end
        if Healbot_Config_Skins.BarIACol[SkinName][gl]["AA"]==nil then Healbot_Config_Skins.BarIACol[SkinName][gl]["AA"]=0.78 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["HLTH"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["HLTH"]=1 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["BACK"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["BACK"]=1 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["HR"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["HR"]=0.4 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["HG"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["HG"]=0.7 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["HB"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["HB"]=0.7 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["HA"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["HA"]=1 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["ORA"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["ORA"]=0.4 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["DISA"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["DISA"]=0.1 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["BR"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["BR"]=0.4 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["BG"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["BG"]=0.7 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["BB"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["BB"]=0.7 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["BA"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["BA"]=0 end
        if Healbot_Config_Skins.BarCol[SkinName][gl]["BOUT"]==nil then Healbot_Config_Skins.BarCol[SkinName][gl]["BOUT"]=1 end
        if Healbot_Config_Skins.HeadText[SkinName][gl]["OUTLINE"]==nil then Healbot_Config_Skins.HeadText[SkinName][gl]["OUTLINE"]=1 end
        if Healbot_Config_Skins.HeadText[SkinName][gl]["FONT"]==nil then Healbot_Config_Skins.HeadText[SkinName][gl]["FONT"]=HealBot_Default_Font end
        if Healbot_Config_Skins.HeadText[SkinName][gl]["HEIGHT"]==nil then Healbot_Config_Skins.HeadText[SkinName][gl]["HEIGHT"]=9 end
        if Healbot_Config_Skins.HeadText[SkinName][gl]["R"]==nil then Healbot_Config_Skins.HeadText[SkinName][gl]["R"]=1 end
        if Healbot_Config_Skins.HeadText[SkinName][gl]["G"]==nil then Healbot_Config_Skins.HeadText[SkinName][gl]["G"]=1 end
        if Healbot_Config_Skins.HeadText[SkinName][gl]["B"]==nil then Healbot_Config_Skins.HeadText[SkinName][gl]["B"]=0.1 end
        if Healbot_Config_Skins.HeadText[SkinName][gl]["A"]==nil then Healbot_Config_Skins.HeadText[SkinName][gl]["A"]=0.7 end
        if Healbot_Config_Skins.HeadBar[SkinName][gl]["SHOW"]==nil then Healbot_Config_Skins.HeadBar[SkinName][gl]["SHOW"]=false end
        if Healbot_Config_Skins.HeadBar[SkinName][gl]["TEXTURE"]==nil then Healbot_Config_Skins.HeadBar[SkinName][gl]["TEXTURE"]=HealBot_Default_Textures[10].name end
        if Healbot_Config_Skins.HeadBar[SkinName][gl]["WIDTH"]==nil then Healbot_Config_Skins.HeadBar[SkinName][gl]["WIDTH"]=0.7 end
        if Healbot_Config_Skins.HeadBar[SkinName][gl]["HEIGHT"]==nil then Healbot_Config_Skins.HeadBar[SkinName][gl]["HEIGHT"]=0.5 end
        if Healbot_Config_Skins.HeadBar[SkinName][gl]["R"]==nil then Healbot_Config_Skins.HeadBar[SkinName][gl]["R"]=0.1 end
        if Healbot_Config_Skins.HeadBar[SkinName][gl]["G"]==nil then Healbot_Config_Skins.HeadBar[SkinName][gl]["G"]=0.7 end
        if Healbot_Config_Skins.HeadBar[SkinName][gl]["B"]==nil then Healbot_Config_Skins.HeadBar[SkinName][gl]["B"]=0.1 end
        if Healbot_Config_Skins.HeadBar[SkinName][gl]["A"]==nil then Healbot_Config_Skins.HeadBar[SkinName][gl]["A"]=0.4 end
        if Healbot_Config_Skins.HealBar[SkinName][gl]["CMARGIN"]==nil then Healbot_Config_Skins.HealBar[SkinName][gl]["CMARGIN"]=2 end 
        if Healbot_Config_Skins.HealBar[SkinName][gl]["POWERSIZE"]==nil then Healbot_Config_Skins.HealBar[SkinName][gl]["POWERSIZE"]=0 end 
        if Healbot_Config_Skins.HealBar[SkinName][gl]["AGGROSIZE"]==nil then Healbot_Config_Skins.HealBar[SkinName][gl]["AGGROSIZE"]=2 end
        if Healbot_Config_Skins.HealBar[SkinName][gl]["GRPCOLS"]==nil then Healbot_Config_Skins.HealBar[SkinName][gl]["GRPCOLS"]=false end
        if Healbot_Config_Skins.HealBar[SkinName][gl]["POWERCNT"]==nil then Healbot_Config_Skins.HealBar[SkinName][gl]["POWERCNT"]=true end
        if Healbot_Config_Skins.HealBar[SkinName][gl]["TEXTURE"]==nil then Healbot_Config_Skins.HealBar[SkinName][gl]["TEXTURE"]=HealBot_Default_Textures[8].name end
        if Healbot_Config_Skins.HealBar[SkinName][gl]["TEXTURE"]=="Empty" then Healbot_Config_Skins.HealBar[SkinName][gl]["TEXTURE"]="Smooth" end
        if Healbot_Config_Skins.HealBar[SkinName][gl]["HEIGHT"]==nil then Healbot_Config_Skins.HealBar[SkinName][gl]["HEIGHT"]=25 end
        if Healbot_Config_Skins.HealBar[SkinName][gl]["WIDTH"]==nil then Healbot_Config_Skins.HealBar[SkinName][gl]["WIDTH"]=144 end
        if Healbot_Config_Skins.HealBar[SkinName][gl]["NUMCOLS"]==nil then Healbot_Config_Skins.HealBar[SkinName][gl]["NUMCOLS"]=2 end
        if Healbot_Config_Skins.HealBar[SkinName][gl]["RMARGIN"]==nil then Healbot_Config_Skins.HealBar[SkinName][gl]["RMARGIN"]=1 end
        if Healbot_Config_Skins.HealBar[SkinName][gl]["OFIX"]==nil then Healbot_Config_Skins.HealBar[SkinName][gl]["OFIX"]=1 end
        if Healbot_Config_Skins.Anchors[SkinName][gl]["FRAME"]==nil then Healbot_Config_Skins.Anchors[SkinName][gl]["FRAME"]=1 end
        if Healbot_Config_Skins.Anchors[SkinName][gl]["BARS"]==nil then Healbot_Config_Skins.Anchors[SkinName][gl]["BARS"]=1 end
        if Healbot_Config_Skins.Anchors[SkinName][gl]["GROW"]==nil then Healbot_Config_Skins.Anchors[SkinName][gl]["GROW"]=2 end
        if Healbot_Config_Skins.FrameAlias[SkinName][gl]["NAME"]==nil then Healbot_Config_Skins.FrameAlias[SkinName][gl]["NAME"]="" end
        if Healbot_Config_Skins.FrameAlias[SkinName][gl]["SHOW"]==nil then Healbot_Config_Skins.FrameAlias[SkinName][gl]["SHOW"]=false end
        if Healbot_Config_Skins.FrameAlias[SkinName][gl]["FONT"]==nil then Healbot_Config_Skins.FrameAlias[SkinName][gl]["FONT"]=HealBot_Default_Font end
        if Healbot_Config_Skins.FrameAlias[SkinName][gl]["SIZE"]==nil then Healbot_Config_Skins.FrameAlias[SkinName][gl]["SIZE"]=12 end
        if Healbot_Config_Skins.FrameAlias[SkinName][gl]["OUTLINE"]==nil then Healbot_Config_Skins.FrameAlias[SkinName][gl]["OUTLINE"]=1 end
        if Healbot_Config_Skins.FrameAlias[SkinName][gl]["OFFSET"]==nil then Healbot_Config_Skins.FrameAlias[SkinName][gl]["OFFSET"]=10 end
        if Healbot_Config_Skins.FrameAlias[SkinName][gl]["R"]==nil then Healbot_Config_Skins.FrameAlias[SkinName][gl]["R"]=1 end
        if Healbot_Config_Skins.FrameAlias[SkinName][gl]["G"]==nil then Healbot_Config_Skins.FrameAlias[SkinName][gl]["G"]=1 end
        if Healbot_Config_Skins.FrameAlias[SkinName][gl]["B"]==nil then Healbot_Config_Skins.FrameAlias[SkinName][gl]["B"]=1 end
        if Healbot_Config_Skins.FrameAlias[SkinName][gl]["A"]==nil then Healbot_Config_Skins.FrameAlias[SkinName][gl]["A"]=1 end
        if Healbot_Config_Skins.Anchors[SkinName][gl]["Y"]==nil then Healbot_Config_Skins.Anchors[SkinName][gl]["Y"]=(49+gl) end
        if Healbot_Config_Skins.Anchors[SkinName][gl]["X"]==nil then Healbot_Config_Skins.Anchors[SkinName][gl]["X"]=(49+gl) end
        if Healbot_Config_Skins.Anchors[SkinName][gl]["Y"]>100 or Healbot_Config_Skins.Anchors[SkinName][gl]["X"]>100 then
            Healbot_Config_Skins.Anchors[SkinName][gl]["Y"]=HealBot_Comm_round(((Healbot_Config_Skins.Anchors[SkinName][gl]["Y"]/GetScreenHeight())*100),2)
            Healbot_Config_Skins.Anchors[SkinName][gl]["X"]=HealBot_Comm_round(((Healbot_Config_Skins.Anchors[SkinName][gl]["X"]/GetScreenWidth())*100),2)
        end
    end

    if Healbot_Config_Skins.Author[SkinName]==nil then Healbot_Config_Skins.Author[SkinName] = HEALBOT_WORDS_UNKNOWN end
    if Healbot_Config_Skins.BarsHide[SkinName]["STATE"]==nil then Healbot_Config_Skins.BarsHide[SkinName]["STATE"]=false end
    if Healbot_Config_Skins.BarsHide[SkinName]["INCTANK"]==nil then Healbot_Config_Skins.BarsHide[SkinName]["INCTANK"]=false end
    if Healbot_Config_Skins.BarsHide[SkinName]["INCGROUP"]==nil then Healbot_Config_Skins.BarsHide[SkinName]["INCGROUP"]=false end
    if Healbot_Config_Skins.BarsHide[SkinName]["INCFOCUS"]==nil then Healbot_Config_Skins.BarsHide[SkinName]["INCFOCUS"]=false end
    if Healbot_Config_Skins.BarsHide[SkinName]["INCMYTARGETS"]==nil then Healbot_Config_Skins.BarsHide[SkinName]["INCMYTARGETS"]=false end
    if Healbot_Config_Skins.Protection[SkinName]["CRASH"]==nil then Healbot_Config_Skins.Protection[SkinName]["CRASH"]=false end
    if Healbot_Config_Skins.Protection[SkinName]["GENERALMACRO"]==nil then Healbot_Config_Skins.Protection[SkinName]["GENERALMACRO"]=false end
    if Healbot_Config_Skins.Protection[SkinName]["COMBAT"]==nil then Healbot_Config_Skins.Protection[SkinName]["COMBAT"]=false end
    if Healbot_Config_Skins.Protection[SkinName]["COMBATPARTY"]==nil then Healbot_Config_Skins.Protection[SkinName]["COMBATPARTY"]=true end
    if Healbot_Config_Skins.Protection[SkinName]["COMBATRAID"]==nil then Healbot_Config_Skins.Protection[SkinName]["COMBATRAID"]=true end
    if Healbot_Config_Skins.Aggro[SkinName]["ALERT"]==nil then Healbot_Config_Skins.Aggro[SkinName]["ALERT"]=3 end
    if Healbot_Config_Skins.Aggro[SkinName]["ALERTIND"]==nil then Healbot_Config_Skins.Aggro[SkinName]["ALERTIND"]=2 end
    if Healbot_Config_Skins.Aggro[SkinName]["R"]==nil then Healbot_Config_Skins.Aggro[SkinName]["R"]=1 end
    if Healbot_Config_Skins.Aggro[SkinName]["G"]==nil then Healbot_Config_Skins.Aggro[SkinName]["G"]=0 end
    if Healbot_Config_Skins.Aggro[SkinName]["B"]==nil then Healbot_Config_Skins.Aggro[SkinName]["B"]=0 end
    if Healbot_Config_Skins.Aggro[SkinName]["MAXA"]==nil then Healbot_Config_Skins.Aggro[SkinName]["MAXA"]=1 end
    if Healbot_Config_Skins.Aggro[SkinName]["MINA"]==nil then Healbot_Config_Skins.Aggro[SkinName]["MINA"]=0.2 end
    if Healbot_Config_Skins.Aggro[SkinName]["FREQ"]==nil then Healbot_Config_Skins.Aggro[SkinName]["FREQ"]=0.03 end
    if Healbot_Config_Skins.Aggro[SkinName]["SHOWIND"]==nil then Healbot_Config_Skins.Aggro[SkinName]["SHOWIND"]=true end
    if Healbot_Config_Skins.Aggro[SkinName]["SHOW"]==nil then Healbot_Config_Skins.Aggro[SkinName]["SHOW"]=true end
    if Healbot_Config_Skins.Aggro[SkinName]["SHOWBARS"]==nil then Healbot_Config_Skins.Aggro[SkinName]["SHOWBARS"]=true end
    if Healbot_Config_Skins.Aggro[SkinName]["SHOWTEXT"]==nil then Healbot_Config_Skins.Aggro[SkinName]["SHOWTEXT"]=false end
    if Healbot_Config_Skins.Aggro[SkinName]["SHOWBARSPCT"]==nil then Healbot_Config_Skins.Aggro[SkinName]["SHOWBARSPCT"]=false end
    if Healbot_Config_Skins.Aggro[SkinName]["SHOWTEXTPCT"]==nil then Healbot_Config_Skins.Aggro[SkinName]["SHOWTEXTPCT"]=true end
    if Healbot_Config_Skins.Aggro[SkinName]["TEXTFORMAT"]==nil then Healbot_Config_Skins.Aggro[SkinName]["TEXTFORMAT"]=3 end
    if Healbot_Config_Skins.Highlight[SkinName]["CBAR"]==nil then Healbot_Config_Skins.Highlight[SkinName]["CBAR"]=true end
    if Healbot_Config_Skins.Highlight[SkinName]["CBARCOMBAT"]==nil then Healbot_Config_Skins.Highlight[SkinName]["CBARCOMBAT"]=false end
    if Healbot_Config_Skins.Highlight[SkinName]["TBAR"]==nil then Healbot_Config_Skins.Highlight[SkinName]["TBAR"]=false end
    if Healbot_Config_Skins.Highlight[SkinName]["TBARCOMBAT"]==nil then Healbot_Config_Skins.Highlight[SkinName]["TBARCOMBAT"]=false end
    if Healbot_Config_Skins.Highlight[SkinName]["CR"]==nil then Healbot_Config_Skins.Highlight[SkinName]["CR"]=1 end
    if Healbot_Config_Skins.Highlight[SkinName]["CG"]==nil then Healbot_Config_Skins.Highlight[SkinName]["CG"]=1 end
    if Healbot_Config_Skins.Highlight[SkinName]["CB"]==nil then Healbot_Config_Skins.Highlight[SkinName]["CB"]=0.7 end
    if Healbot_Config_Skins.Highlight[SkinName]["TR"]==nil then Healbot_Config_Skins.Highlight[SkinName]["TR"]=0.8 end
    if Healbot_Config_Skins.Highlight[SkinName]["TG"]==nil then Healbot_Config_Skins.Highlight[SkinName]["TG"]=0.8 end
    if Healbot_Config_Skins.Highlight[SkinName]["TB"]==nil then Healbot_Config_Skins.Highlight[SkinName]["TB"]=0.7 end
    if Healbot_Config_Skins.Healing[SkinName]["ALERTIC"]==nil then Healbot_Config_Skins.Healing[SkinName]["ALERTIC"]=1 end
    if Healbot_Config_Skins.Healing[SkinName]["ALERTOC"]==nil then Healbot_Config_Skins.Healing[SkinName]["ALERTOC"]=0.95 end
    if Healbot_Config_Skins.Healing[SkinName]["GROUPPETS"]==nil then Healbot_Config_Skins.Healing[SkinName]["GROUPPETS"]=true end
    if Healbot_Config_Skins.Healing[SkinName]["SELFPET"]==nil then Healbot_Config_Skins.Healing[SkinName]["SELFPET"]=0 end
    if Healbot_Config_Skins.Healing[SkinName]["TINCSELF"]==nil then Healbot_Config_Skins.Healing[SkinName]["TINCSELF"]=false end
    if Healbot_Config_Skins.Healing[SkinName]["TINCGROUP"]==nil then Healbot_Config_Skins.Healing[SkinName]["TINCGROUP"]=true end
    if Healbot_Config_Skins.Healing[SkinName]["TINCRAID"]==nil then Healbot_Config_Skins.Healing[SkinName]["TINCRAID"]=true end
    if Healbot_Config_Skins.Healing[SkinName]["TINCPET"]==nil then Healbot_Config_Skins.Healing[SkinName]["TINCPET"]=false end
    if Healbot_Config_Skins.Healing[SkinName]["TALWAYSSHOW"]==nil then Healbot_Config_Skins.Healing[SkinName]["TALWAYSSHOW"]=false end
    if Healbot_Config_Skins.Healing[SkinName]["FALWAYSSHOW"]==nil then Healbot_Config_Skins.Healing[SkinName]["FALWAYSSHOW"]=false end
    if Healbot_Config_Skins.Healing[SkinName]["TONLYFRIEND"]==nil then Healbot_Config_Skins.Healing[SkinName]["TONLYFRIEND"]=false end
    if Healbot_Config_Skins.Healing[SkinName]["FONLYFRIEND"]==nil then Healbot_Config_Skins.Healing[SkinName]["FONLYFRIEND"]=false end
    if Healbot_Config_Skins.General[SkinName]["HIDEPARTYF"]==nil then Healbot_Config_Skins.General[SkinName]["HIDEPARTYF"]=false end
    if Healbot_Config_Skins.General[SkinName]["HIDEPTF"]==nil then Healbot_Config_Skins.General[SkinName]["HIDEPTF"]=false end
    if Healbot_Config_Skins.General[SkinName]["HIDEBOSSF"]==nil then Healbot_Config_Skins.General[SkinName]["HIDEBOSSF"]=false end
    if Healbot_Config_Skins.General[SkinName]["HIDERAIDF"]==nil then Healbot_Config_Skins.General[SkinName]["HIDERAIDF"]=true end
    if Healbot_Config_Skins.General[SkinName]["FLUIDBARS"]==nil then Healbot_Config_Skins.General[SkinName]["FLUIDBARS"]=false end
    if Healbot_Config_Skins.General[SkinName]["FLUIDFREQ"]==nil then Healbot_Config_Skins.General[SkinName]["FLUIDFREQ"]=3 end
    if Healbot_Config_Skins.General[SkinName]["LOWMANA"]==nil then Healbot_Config_Skins.General[SkinName]["LOWMANA"]=2 end
    if Healbot_Config_Skins.General[SkinName]["LOWMANACOMBAT"]==nil then Healbot_Config_Skins.General[SkinName]["LOWMANACOMBAT"]=true end
    if Healbot_Config_Skins.Sort[SkinName]["RAIDORDER"]==nil then Healbot_Config_Skins.Sort[SkinName]["RAIDORDER"]=3 end
    if Healbot_Config_Skins.Sort[SkinName]["SUBORDER"]==nil then Healbot_Config_Skins.Sort[SkinName]["SUBORDER"]=5 end
    if Healbot_Config_Skins.Sort[SkinName]["SUBIG"]==nil then Healbot_Config_Skins.Sort[SkinName]["SUBIG"]=true end
    if Healbot_Config_Skins.Sort[SkinName]["SUBIP"]==nil then Healbot_Config_Skins.Sort[SkinName]["SUBIP"]=true end
    if Healbot_Config_Skins.Sort[SkinName]["SUBIV"]==nil then Healbot_Config_Skins.Sort[SkinName]["SUBIV"]=true end
    if Healbot_Config_Skins.Sort[SkinName]["SUBIT"]==nil then Healbot_Config_Skins.Sort[SkinName]["SUBIT"]=true end
    if Healbot_Config_Skins.Sort[SkinName]["SUBIMT"]==nil then Healbot_Config_Skins.Sort[SkinName]["SUBIMT"]=false end
    if Healbot_Config_Skins.Sort[SkinName]["SUBPF"]==nil then Healbot_Config_Skins.Sort[SkinName]["SUBPF"]=true end
    if Healbot_Config_Skins.Chat[SkinName]["NOTIFY"]==nil then Healbot_Config_Skins.Chat[SkinName]["NOTIFY"]=1 end
    if Healbot_Config_Skins.Chat[SkinName]["CHAN"]==nil then Healbot_Config_Skins.Chat[SkinName]["CHAN"]="" end
    if Healbot_Config_Skins.Chat[SkinName]["MSG"]==nil then Healbot_Config_Skins.Chat[SkinName]["MSG"]=HEALBOT_NOTIFYOTHERMSG end
    if Healbot_Config_Skins.Chat[SkinName]["RESONLY"]==nil then Healbot_Config_Skins.Chat[SkinName]["RESONLY"]=true end
    if Healbot_Config_Skins.Enemy[SkinName]["INCSELF"]==nil then Healbot_Config_Skins.Enemy[SkinName]["INCSELF"]=false end
    if Healbot_Config_Skins.Enemy[SkinName]["INCTANKS"]==nil then Healbot_Config_Skins.Enemy[SkinName]["INCTANKS"]=true end
    if Healbot_Config_Skins.Enemy[SkinName]["INCMYTAR"]==nil then Healbot_Config_Skins.Enemy[SkinName]["INCMYTAR"]=false end
    if Healbot_Config_Skins.Enemy[SkinName]["INCARENA"]==nil then Healbot_Config_Skins.Enemy[SkinName]["INCARENA"]=true end
    if Healbot_Config_Skins.Enemy[SkinName]["INCARENAPETS"]==nil then Healbot_Config_Skins.Enemy[SkinName]["INCARENAPETS"]=false end
    if Healbot_Config_Skins.Enemy[SkinName]["NUMBOSS"]==nil then Healbot_Config_Skins.Enemy[SkinName]["NUMBOSS"]=2 end
    if Healbot_Config_Skins.Enemy[SkinName]["HIDE"]==nil then Healbot_Config_Skins.Enemy[SkinName]["HIDE"]=true end
    if Healbot_Config_Skins.Enemy[SkinName]["EXISTSHOWPTAR"]==nil then Healbot_Config_Skins.Enemy[SkinName]["EXISTSHOWPTAR"]=false end
    if Healbot_Config_Skins.Enemy[SkinName]["EXISTSHOWBOSS"]==nil then Healbot_Config_Skins.Enemy[SkinName]["EXISTSHOWBOSS"]=true end
    if Healbot_Config_Skins.Enemy[SkinName]["EXISTSHOWARENA"]==nil then Healbot_Config_Skins.Enemy[SkinName]["EXISTSHOWARENA"]=true end
    if Healbot_Config_Skins.Enemy[SkinName]["INCDPS"] then Healbot_Config_Skins.Enemy[SkinName]["INCDPS"]=nil end
    if Healbot_Config_Skins.Enemy[SkinName]["FRAME"] then Healbot_Config_Skins.Enemy[SkinName]["FRAME"]=nil end
    -- Fix Frames
    for id=1,10 do
        if Healbot_Config_Skins.HealGroups[SkinName][id]["NAME"]==HEALBOT_CUSTOM_CASTBY_ENEMY_en then
            HealBot_Options_HealGroupSwap(SkinName, 11, id)
            break
        end
    end
    for id=1,9 do
        if Healbot_Config_Skins.HealGroups[SkinName][id]["NAME"]==HEALBOT_FOCUS_en then
            HealBot_Options_HealGroupSwap(SkinName, 10, id)
            break
        end
    end
    for id=1,8 do
        if Healbot_Config_Skins.HealGroups[SkinName][id]["NAME"]==HEALBOT_OPTIONS_TARGETHEALS_en then
            HealBot_Options_HealGroupSwap(SkinName, 9, id)
            break
        end
    end
    for id=1,7 do
        if Healbot_Config_Skins.HealGroups[SkinName][id]["NAME"]==HEALBOT_OPTIONS_PETHEALS_en then
            HealBot_Options_HealGroupSwap(SkinName, 8, id)
            break
        end
    end
    for id=1,6 do
        if Healbot_Config_Skins.HealGroups[SkinName][id]["NAME"]==HEALBOT_VEHICLE_en then
            HealBot_Options_HealGroupSwap(SkinName, 7, id)
            break
        end
    end
    Healbot_Config_Skins.HealGroups[SkinName][11]["FRAME"]=10
    Healbot_Config_Skins.HealGroups[SkinName][10]["FRAME"]=9
    Healbot_Config_Skins.HealGroups[SkinName][9]["FRAME"]=8
    if Healbot_Config_Skins.HealGroups[SkinName][8]["FRAME"]>7 or Healbot_Config_Skins.HealGroups[SkinName][8]["FRAME"]==6 then
        Healbot_Config_Skins.HealGroups[SkinName][8]["FRAME"]=7
    end
    if Healbot_Config_Skins.HealGroups[SkinName][7]["FRAME"]>6 then
        Healbot_Config_Skins.HealGroups[SkinName][7]["FRAME"]=6
    end
    Healbot_Config_Skins.FrameAlias[SkinName][6]["ALIAS"]=HEALBOT_VEHICLE_en
    Healbot_Config_Skins.FrameAlias[SkinName][7]["ALIAS"]=HEALBOT_OPTIONS_PETHEALS_en
    Healbot_Config_Skins.FrameAlias[SkinName][8]["ALIAS"]=HEALBOT_OPTIONS_TARGETHEALS_en
    Healbot_Config_Skins.FrameAlias[SkinName][9]["ALIAS"]=HEALBOT_FOCUS_en
    Healbot_Config_Skins.FrameAlias[SkinName][10]["ALIAS"]=HEALBOT_CUSTOM_CASTBY_ENEMY_en
    for id=1,6 do
        if Healbot_Config_Skins.HealGroups[SkinName][id]["FRAME"]>5 then
            Healbot_Config_Skins.HealGroups[SkinName][id]["FRAME"]=1
        end
    end
  --HealBot_setCall("HealBot_Check_Skin")
end

local function HealBot_Update_Skins()
    if HealBot_Globals.LastVersionSkinUpdate then
        HealBot_Globals.LastVersionSkinUpdate=nil
    end
    if HealBot_Config.ActionVisible==0 or HealBot_Config.ActionVisible==1 or HealBot_Config.ActionVisible[1]==0 or HealBot_Config.ActionVisible[1]==1 then
        HealBot_Config.ActionVisible={[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
    end
    local foundSkin=false
    for x in pairs (Healbot_Config_Skins.Skins) do
        if not HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]] then 
            HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]] = {[HEALBOT_WORD_SOLO]=false, 
                                                                         [HEALBOT_WORD_PARTY]=false, 
                                                                         [HEALBOT_OPTIONS_RAID10]=false, 
                                                                         [HEALBOT_OPTIONS_RAID25]=false, 
                                                                         [HEALBOT_OPTIONS_RAID40]=false,
                                                                         [HEALBOT_WORD_ARENA]=false, 
                                                                         [HEALBOT_WORD_BG10]=false, 
                                                                         [HEALBOT_WORD_BG15]=false, 
                                                                         [HEALBOT_WORD_BG40]=false, 
                                                                         [HEALBOT_WORD_PETBATTLE]=false}
        end
        if Healbot_Config_Skins.Skins[x]==Healbot_Config_Skins.Current_Skin then foundSkin=true end
    end
    if not foundSkin then 
        Healbot_Config_Skins.Current_Skin=HEALBOT_SKINS_STD 
        Healbot_Config_Skins.Skin_ID = 1;
    end

    local tMajor, tMinor, tPatch, tHealbot = string.split(".", HealBot_Config.LastVersionSkinUpdate)
    if tonumber(tMajor)<8 then
        HealBot_Options_SetDefaults();
        HealBot_ReloadUI()
    elseif HealBot_Config.LastVersionSkinUpdate~=HEALBOT_VERSION then   
        for x in pairs (Healbot_Config_Skins.Skins) do
            HealBot_Check_Skin(Healbot_Config_Skins.Skins[x])
            if tonumber(tMajor)==8 then
                if tonumber(tMinor)==0 or (tonumber(tMinor)==1 and tonumber(tPatch)==0 and tonumber(tHealbot)<2) then
                    for gl=1,10 do
                        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Skins[x]][gl]["INCHEALS"]>3 and Healbot_Config_Skins.BarText[Healbot_Config_Skins.Skins[x]][gl]["INCHEALS"]<8 then
                            Healbot_Config_Skins.BarText[Healbot_Config_Skins.Skins[x]][gl]["INCHEALS"]=Healbot_Config_Skins.BarText[Healbot_Config_Skins.Skins[x]][gl]["INCHEALS"]+2
                        end
                    end
                end
            end
        end
        if HealBot_Globals.mapScale then HealBot_Globals.mapScale=nil end
        if HealBot_Globals.RangeCheckFreq>0.8 then HealBot_Globals.RangeCheckFreq=0.8 end
        if HealBot_Globals.RangeCheckFreq<0.2 then HealBot_Globals.RangeCheckFreq=0.2 end
    end
    
    if HealBot_Config.CurrentSpec==9 then
        HealBot_Config.CurrentSpec=1
        HealBot_Update_SpellCombos()
        HealBot_Update_BuffsForSpec()
    end
    
    HealBot_Config.LastVersionSkinUpdate=HEALBOT_VERSION
    HealBot_Config.Version=HEALBOT_VERSION
  --HealBot_setCall("HealBot_Update_Skins")
end

local function HealBot_OnEvent_VariablesLoaded(self)
    HealBot_globalVars()
    HealBot_Lang_InitVars()
    HealBot_Data_InitVars()
    HealBot_InitVars()
    HealBot_Options_InitVars()
    HealBot_Options_setLists()
    table.foreach(HealBot_ConfigDefaults, function (key,val)
        if HealBot_Config[key]==nil then
            HealBot_Config[key] = val;
        end
    end);
    table.foreach(HealBot_GlobalsDefaults, function (key,val)
        if HealBot_Globals[key]==nil then
            HealBot_Globals[key] = val;
        end
    end);
    table.foreach(HealBot_Config_SkinsDefaults, function (key,val)
        if Healbot_Config_Skins[key]==nil then
            Healbot_Config_Skins[key] = val;
        end
    end);
    table.foreach(HealBot_Config_SpellsDefaults, function (key,val)
        if HealBot_Config_Spells[key]==nil then
            HealBot_Config_Spells[key] = val;
        end
    end);
    table.foreach(HealBot_Config_BuffsDefaults, function (key,val)
        if HealBot_Config_Buffs[key]==nil then
            HealBot_Config_Buffs[key] = val;
        end
    end);
    table.foreach(HealBot_Config_CuresDefaults, function (key,val)
        if HealBot_Config_Cures[key]==nil then
            HealBot_Config_Cures[key] = val;
        end
    end);
    
    local pClass, pClassEN=UnitClass("player")
    HealBot_Data["PCLASSTRIM"]=strsub(pClassEN,1,4)
    
    HealBot_customTempUserName=HealBot_Options_copyTable(HealBot_Globals.HealBot_customPermUserName)
    HealBot_Update_Skins()  

    if HealBot_Globals.localLang then
        HealBot_Options_Lang(HealBot_Globals.localLang)
    elseif strsub(GetLocale(),1,2)~="en" then
        HealBot_Options_Lang(GetLocale())
    end
    HealBot_Options_setClassEn()
    
    if HealBot_Config.Profile==2 then
        HealBot_Options_hbProfile_setClass()
    end
    HealBot_Init_Spells_Defaults();
    local pRace, pRaceEN=UnitRace("player")
    HealBot_Data["PRACE_EN"]=pRaceEN
    HealBot_Data["PNAME"]=UnitName("player")
    HealBot_Data["PLEVEL"]=UnitLevel("player")
    C_ChatInfo.RegisterAddonMessagePrefix(HEALBOT_HEALBOT)
    HealBot_Options_InitBuffClassList()
    HealBot_setOptions_Timer(5)
    HealBot_Vers[HealBot_Data["PNAME"]]=HEALBOT_VERSION
    
    local HEALBOT_STATS_ID = 1 --RAID_BUFF_1 --Stats
    local HEALBOT_STAMINA_ID = 2 --RAID_BUFF_2 --Stamina
    local HEALBOT_ATTACK_POWER_ID = 3 --RAID_BUFF_3 --Attack Power
    local HEALBOT_HASTE_ID = 4 --RAID_BUFF_4 --Haste
    local HEALBOT_SPELL_POWER_ID = 5 --RAID_BUFF_5 --Spell Power
    local HEALBOT_CRITICAL_STRIKE_ID = 6 --RAID_BUFF_6 --Critical Strike
    local HEALBOT_MASTERY_ID = 7 --RAID_BUFF_7 --Mastery
    local HEALBOT_MULTISTRIKE_ID = 8 --RAID_BUFF_8 --Multistrike
    local HEALBOT_VERSATILITY_ID = 9 --RAID_BUFF_9 --Versatility
    
    HealBot_BuffNameTypes = {
        -- Death Knight
        [HEALBOT_HORN_OF_WINTER] = {HEALBOT_ATTACK_POWER_ID},
        [HEALBOT_POWER_OF_THE_GRAVE] = {HEALBOT_MASTERY_ID},
        [HEALBOT_UNHOLY_AURA] = {HEALBOT_HASTE_ID, HEALBOT_VERSATILITY_ID},
        -- Druid
        [HEALBOT_MARK_OF_THE_WILD] = {HEALBOT_STATS_ID, HEALBOT_VERSATILITY_ID},
        [HEALBOT_MOONKIN_AURA] = {HEALBOT_MASTERY_ID},
        [HEALBOT_LEADER_OF_THE_PACK] = {HEALBOT_CRITICAL_STRIKE_ID},
        -- Hunter
        [HEALBOT_TRUESHOT_AURA] = {HEALBOT_ATTACK_POWER_ID},
        [HEALBOT_LW_FORTITUDE_OF_THE_BEAR] = {HEALBOT_STAMINA_ID},
        [HEALBOT_LW_POWER_OF_THE_PRIMATES] = {HEALBOT_STATS_ID},
        [HEALBOT_LW_WISDOM_OF_THE_SERPENT] = {HEALBOT_SPELL_POWER_ID},
        [HEALBOT_LW_GRACE_OF_THE_CAT] = {HEALBOT_MASTERY_ID},
        [HEALBOT_LW_HASTE_OF_THE_HYENA] = {HEALBOT_HASTE_ID},
        [HEALBOT_LW_FEROCITY_OF_THE_RAPTOR] = {HEALBOT_CRITICAL_STRIKE_ID},
        [HEALBOT_LW_QUICKNESS_OF_THE_DRAGONHAWK] = {HEALBOT_MULTISTRIKE_ID},
        [HEALBOT_LW_VERSATILITY_OF_THE_RAVAGER] = {HEALBOT_VERSATILITY_ID},
        -- Hunter Pets
        [HEALBOT_BARK_OF_THE_WILD] = {HEALBOT_STATS_ID},
        [HEALBOT_BLESSING_OF_KONGS] = {HEALBOT_STATS_ID},
        [HEALBOT_EMBRACE_OF_THE_SHALE_SPIDER] = {HEALBOT_STATS_ID, HEALBOT_CRITICAL_STRIKE_ID},
        [HEALBOT_STRENGTH_OF_THE_EARTH] = {HEALBOT_STATS_ID, HEALBOT_VERSATILITY_ID},
        [HEALBOT_INVIGORATING_ROAR] = {HEALBOT_STAMINA_ID},
        [HEALBOT_STURDINESS] = {HEALBOT_STAMINA_ID},
        [HEALBOT_SAVAGE_VIGOR] = {HEALBOT_STAMINA_ID, HEALBOT_HASTE_ID},
        [HEALBOT_QIRAJI_FORTITUDE] = {HEALBOT_STAMINA_ID, HEALBOT_SPELL_POWER_ID},
        [HEALBOT_SERPENTS_CUNNING] = {HEALBOT_SPELL_POWER_ID},
        [HEALBOT_STILL_WATER] = {HEALBOT_SPELL_POWER_ID, HEALBOT_CRITICAL_STRIKE_ID},
        [HEALBOT_ROAR_OF_COURAGE] = {HEALBOT_MASTERY_ID},
        [HEALBOT_KEEN_SENSES] = {HEALBOT_MASTERY_ID},
        [HEALBOT_SPIRIT_BEAST_BLESSING] = {HEALBOT_MASTERY_ID},
        [HEALBOT_PLAINSWALKING] = {HEALBOT_MASTERY_ID},
        [HEALBOT_CACKLING_HOWL] = {HEALBOT_HASTE_ID},
        [HEALBOT_ENERGIZING_SPORES] = {HEALBOT_HASTE_ID},
        [HEALBOT_SPEED_OF_THE_SWARM] = {HEALBOT_HASTE_ID},
        [HEALBOT_TERRIFYING_ROAR] = {HEALBOT_CRITICAL_STRIKE_ID},
        [HEALBOT_FEARLESS_ROAR] = {HEALBOT_CRITICAL_STRIKE_ID},
        [HEALBOT_STRENGTH_OF_THE_PACK] = {HEALBOT_CRITICAL_STRIKE_ID},
        [HEALBOT_FURIOUS_HOWL] = {HEALBOT_CRITICAL_STRIKE_ID},
        [HEALBOT_SONIC_FOCUS] = {HEALBOT_MULTISTRIKE_ID},
        [HEALBOT_WILD_STRENGTH] = {HEALBOT_MULTISTRIKE_ID, HEALBOT_VERSATILITY_ID},
        [HEALBOT_DOUBLE_BITE] = {HEALBOT_MULTISTRIKE_ID},
        [HEALBOT_SPRY_ATTACKS] = {HEALBOT_MULTISTRIKE_ID},
        [HEALBOT_BREATH_OF_THE_WINDS] = {HEALBOT_MULTISTRIKE_ID},
        [HEALBOT_TENACITY] = {HEALBOT_VERSATILITY_ID},
        [HEALBOT_INDOMITABLE] = {HEALBOT_VERSATILITY_ID},
        [HEALBOT_DEFENSIVE_QUILLS] = {HEALBOT_VERSATILITY_ID},
        [HEALBOT_CHITINOUS_ARMOR] = {HEALBOT_VERSATILITY_ID},
        [HEALBOT_GRACE] = {HEALBOT_VERSATILITY_ID},
        -- Mage
        [HEALBOT_ARCANE_BRILLIANCE] = {HEALBOT_SPELL_POWER_ID, HEALBOT_CRITICAL_STRIKE_ID},
        [HEALBOT_DALARAN_BRILLIANCE] = {HEALBOT_SPELL_POWER_ID, HEALBOT_CRITICAL_STRIKE_ID},
        -- Monk
        [HEALBOT_LEGACY_EMPEROR] = {HEALBOT_STATS_ID},
        [HEALBOT_LEGACY_WHITETIGER] = {HEALBOT_STATS_ID, HEALBOT_CRITICAL_STRIKE_ID},
        [HEALBOT_WINDFLURRY] = {HEALBOT_MULTISTRIKE_ID},
        -- Paladin
        [HEALBOT_BLESSING_OF_KINGS] = {HEALBOT_STATS_ID},
        [HEALBOT_BLESSING_OF_MIGHT] = {HEALBOT_MASTERY_ID},
        [HEALBOT_SANCTITY_AURA] = {HEALBOT_VERSATILITY_ID},
        -- Priest
        [HEALBOT_POWER_WORD_FORTITUDE] = {HEALBOT_STAMINA_ID},
        [HEALBOT_MIND_QUICKENING] = {HEALBOT_HASTE_ID, HEALBOT_MULTISTRIKE_ID},
        -- Warlock
        [HEALBOT_BLOOD_PACT] = {HEALBOT_STAMINA_ID},
        [HEALBOT_DARK_INTENT] = {HEALBOT_SPELL_POWER_ID, HEALBOT_MULTISTRIKE_ID},
        -- Warrior
        [HEALBOT_COMMANDING_SHOUT] = {HEALBOT_STAMINA_ID},
        [HEALBOT_BATTLE_SHOUT] = {HEALBOT_ATTACK_POWER_ID},
        [HEALBOT_INSPIRING_PRESENCE] = {HEALBOT_VERSATILITY_ID},
        -- Rogue
        [HEALBOT_SWIFTBLADES_CUNNING] = {HEALBOT_HASTE_ID, HEALBOT_MULTISTRIKE_ID},
        -- Shaman
        [HEALBOT_GRACE_OF_AIR] = {HEALBOT_MASTERY_ID, HEALBOT_HASTE_ID},
    }
    
    if HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_PRIEST] then
        HealBot_ShortBuffs[HEALBOT_LEVITATE]=true
    elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_DRUID] then
        -- short buffs
    elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_PALADIN] then
        HealBot_ShortBuffs[HEALBOT_BEACON_OF_LIGHT]=true
        HealBot_ShortBuffs[HEALBOT_SACRED_SHIELD]=true
    elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_MONK] then
        -- short buffs
    elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_WARRIOR] then
        -- short buffs
    elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_MAGE] then
        HealBot_ShortBuffs[HEALBOT_ICE_WARD]=true
	elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_WARLOCK] then
        -- short buffs
	elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_DEATHKNIGHT] then
		HealBot_ShortBuffs[HEALBOT_HORN_OF_WINTER]=true
	elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_HUNTER] then
        -- short buffs
    elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_SHAMAN] then
        -- short buffs
    elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_ROGUE] then
        -- short buffs
    elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_DEMONHUNTER] then
        -- short buffs
    end

    HealBot:RegisterEvent("PLAYER_ENTERING_WORLD");
    HealBot:RegisterEvent("PLAYER_LEAVING_WORLD");
    HealBot_luVars["hbLoaded"]=true
    g=_G["HealBot_SkinsSubFrameSelectHealRaidFrameb"]
    g:LockHighlight()
    HealBot_Options_Init(11)
    HealBot_Action_SetResSpells()
  --HealBot_setCall("HealBot_OnEvent_VariablesLoaded")
end

local function HealBot_OnEvent_ItemInfoReceived(self)
    local allInfoReceived = true
    if HEALBOT_ORALIUS_WHISPERING_CRYSTAL=="--Oralius' Whispering Crystal" then
        HEALBOT_ORALIUS_WHISPERING_CRYSTAL = GetItemInfo(118922) or "-+Oralius' Whispering Crystal"
        allInfoReceived = false
    end
    if HEALBOT_EVER_BLOOMING_FROND=="--Ever-Blooming Frond" then
        HEALBOT_EVER_BLOOMING_FROND = GetItemInfo(118935) or "-+Ever-Blooming Frond"
        allInfoReceived = false
    end
    if HEALBOT_REPURPOSED_FEL_FOCUSER=="--Repurposed Fel Focuser" then
        HEALBOT_REPURPOSED_FEL_FOCUSER = GetItemInfo(147707) or "-+Repurposed Fel Focuser"
        allInfoReceived = false
    end
    if HEALBOT_BATTLE_SCARRED_AUGMENT_RUNE=="--Battle-Scarred Augment Rune" then
        HEALBOT_BATTLE_SCARRED_AUGMENT_RUNE = GetItemInfo(160053) or "-+Battle-Scarred Augment Rune"
        allInfoReceived = false
    end
    if HEALBOT_TAILWIND_SAPPHIRE=="--Tailwind Sapphire" then
        HEALBOT_TAILWIND_SAPPHIRE = GetItemInfo(284567) or "-+Tailwind Sapphire"
        allInfoReceived = false
    end
    if HEALBOT_AMETHYST_OF_THE_SHADOW_KING=="--Amethyst of the Shadow King" then
        HEALBOT_AMETHYST_OF_THE_SHADOW_KING = GetItemInfo(284558) or "-+Amethyst of the Shadow King"
        allInfoReceived = false
    end
    if allInfoReceived then
        HealBot:UnregisterEvent("GET_ITEM_INFO_RECEIVED");
        HealBot_OnEvent_VariablesLoaded(self)
    else
        HealBot_Options_InitBuffList()
    end
  --HealBot_setCall("HealBot_OnEvent_ItemInfoReceived")
end

local function HealBot_OnEvent_RaidRosterUpdate()
    HealBot_nextRecalcParty(6)
  --HealBot_setCall("HealBot_OnEvent_RaidRosterUpdate")
end

local function HealBot_CheckLowMana()
    for xGUID,xUnit in pairs(hbManaPlayers) do
        local xButton=HealBot_Unit_Button[xUnit]
        if xButton and xGUID==xButton.guid then
            HealBot_Action_CheckUnitLowMana(xButton)
        else
            hbManaPlayers[xGUID]=nil
        end
    end
  --HealBot_setCall("HealBot_CheckLowMana")
end

local function HealBot_GetSpec(unit)
    local s,r,i=nil,nil,nil
    if UnitExists(unit) then
        i = GetInspectSpecialization(unit)
        if i then
            _, s, _, _, _, r = GetSpecializationInfoByID(i) 
        end
    end
    return i,s,r
end

local function HealBot_GetTalentInfo(hbGUID, unit)
    local s,r,i=nil,nil,nil
    if HealBot_UnitData[hbGUID] then
        if hbGUID==HealBot_Data["PGUID"] then
            i = GetSpecialization()
            if i then
                _, s, _, _, _, r = GetSpecializationInfo(i,false,false) 
                if HealBot_Config.CurrentSpec~=i or HealBot_Data["PLEVEL"]~=UnitLevel("player") then 
                    HealBot_Config.CurrentSpec=i 
                    HealBot_Data["PLEVEL"]=UnitLevel("player")
                    HealBot_InitSpells()
                    HealBot_Options_ResetDoInittab(50)
                    HealBot_Options_ResetDoInittab(40)
                    HealBot_Options_ResetDoInittab(10)
                    HealBot_Options_ResetDoInittab(5)
                    HealBot_Options_ResetDoInittab(4)
                    HealBot_setHbStanceBuffs()
                    HealBot_Options_setDebuffTypes()
                    HealBot_setOptions_Timer(5)
                    HealBot_setOptions_Timer(15)
                    HealBot_setOptions_Timer(40)
                    HealBot_setOptions_Timer(50)
                    HealBot_ClearAllBuffs()
                    HealBot_ClearAllDebuffs()
                    HealBot_setOptions_Timer(400)
                    HealBot_setOptions_Timer(10)
                    HealBot_Action_setpcClass()
                end
            end
        else
            i,s,r = HealBot_GetSpec(unit)
        end
        if s and HealBot_UnitData[hbGUID] then
            HealBot_UnitData[hbGUID]["SPEC"] = s.." " 
            local _,_,xButton = HealBot_UnitID(unit)
            if xButton then 
                if r=="DAMAGER" or r=="TANK" or r=="HEALER" then
                    HealBot_UnitData[hbGUID]["ROLE"] = r
                else
                    HealBot_UnitData[hbGUID]["ROLE"] = UnitGroupRolesAssigned(unit) or HEALBOT_WORDS_UNKNOWN
                end
                xButton.update.roleicon=true
                xButton.status.update=true
            end
        end
    elseif unit=="target" then
        i,s,r = HealBot_GetSpec(unit)
        if s then
            HealBot_luVars["targetSpec"] = s.." " 
        end
    end
  --HealBot_setCall("HealBot_GetTalentInfo")
end

local function HealBot_SetAddonComms()
    if not HealBot_luVars["inBG"] then
        if GetNumGroupMembers()>5 then
            HealBot_luVars["AddonMsgType"]=2;
        elseif GetNumGroupMembers()>0 then
            HealBot_luVars["AddonMsgType"]=3;
        else
            HealBot_luVars["AddonMsgType"]=4;
        end
    else
        HealBot_luVars["AddonMsgType"]=1;
    end
  --HealBot_setCall("HealBot_SetAddonComms")
end

function HealBot_ResetClassIconTexture()
    for _,xButton in pairs(HealBot_Unit_Button) do
        xButton.update.roleicon=true
        xButton.status.update=true
    end
end

local function HealBot_Options_Update()
    HealBot_Timers["HB1Th"]=HealBot_Globals.RangeCheckFreq/25
    if HealBot_Options_Timer[150] then
        HealBot_Options_Timer[150]=nil
        HealBot_Action_ResetSkin("init")
    elseif HealBot_Options_Timer[10] then
        HealBot_Options_Timer[10]=nil
        if HealBot_Config_Buffs.NoAuraWhenRested and not IsResting() then HealBot_CheckAllBuffs() end
    elseif HealBot_Options_Timer[15] then
        HealBot_Options_Timer[15]=nil
        HealBot_Options_ComboClass_Text()
    elseif  HealBot_Options_Timer[405] then
        HealBot_Options_Timer[405]=nil
        HealBot_MountsPets_InitUse()
    elseif  HealBot_Options_Timer[410] then
        HealBot_Options_Timer[410]=nil
        HealBot_MountsPets_InitMount()
    elseif HealBot_Options_Timer[20] then
        HealBot_Options_Timer[20]=nil
        HealBot_CheckAllDebuffs()
    elseif HealBot_Options_Timer[25] then
        HealBot_Options_Timer[25]=nil
        if HealBot_Globals.HealBot_Enable_MouseWheel then
            for i=1, 10 do
                local g = _G["f"..i.."_HealBot_Action"]
                g:EnableMouseWheel(1)  
                g:SetScript("OnMouseWheel", function(self, delta)
                    HealBot_Action_HealUnit_Wheel(self, delta)
                end)
            end
        end
    elseif HealBot_Options_Timer[30] then
        HealBot_Options_Timer[30]=nil
        HealBot_CheckAllBuffs()
    elseif HealBot_Options_Timer[40] then
        HealBot_Options_Timer[40]=nil
        HealBot_Options_BuffDebuff_Reset("buff")
        HealBot_Options_ResetDoInittab(5)
    elseif HealBot_Options_Timer[50] then
        HealBot_Options_Timer[50]=nil
        HealBot_Options_BuffDebuff_Reset("debuff")
        HealBot_Options_ResetDoInittab(4)
    elseif HealBot_Options_Timer[60] then
        HealBot_Options_Timer[60]=nil
        HealBot_Options_EmergencyFilter_Reset()
    elseif HealBot_Options_Timer[80] then
        HealBot_Options_Timer[80]=nil
        HealBot_Action_sethbNumberFormat()
        HealBot_Action_sethbAggroNumberFormat()
        HealBot_Action_ResetUnitStatus()
        HealBot_setOptions_Timer(595)
    elseif HealBot_Options_Timer[90] then
        HealBot_Options_Timer[90]=nil
        HealBot_SetSkinColours();
    elseif HealBot_Options_Timer[100] then
        HealBot_Options_Timer[100]=nil
        HealBot_SetBuffBarColours()
    elseif HealBot_Options_Timer[110] then
        HealBot_Options_Timer[110]=nil
        HealBot_Action_setRegisterForClicks()
    elseif HealBot_Options_Timer[120] then
        HealBot_Options_Timer[120]=nil
        HealBot_CheckZone();
    elseif HealBot_Options_Timer[125] then
        HealBot_Options_Timer[125]=nil
        hbRequestTime=GetTime()+4
        HealBot_setOptions_Timer(130)
    elseif HealBot_Options_Timer[130] and hbRequestTime<GetTime() then
        HealBot_Options_Timer[130]=nil
        HealBot_Comms_SendAddonMsg(HEALBOT_HEALBOT, "R", HealBot_luVars["AddonMsgType"], HealBot_Data["PNAME"])
        hbRequestTime=GetTime()+8
    elseif HealBot_Options_Timer[140] and hbRequestTime<GetTime() then
        HealBot_Options_Timer[140]=nil
        if GetGuildInfo("player") then HealBot_Comms_SendAddonMsg(HEALBOT_HEALBOT, "G", 5, HealBot_Data["PNAME"]) end
        local x=GetNumFriends()
        if x>0 then
            for y=1,x do
                local uName, _, _, _, z = GetFriendInfo(y)
                if z then HealBot_Comms_SendAddonMsg(HEALBOT_HEALBOT, "F", 4, uName) end
            end
        end
        HealBot_GetTalentInfo(HealBot_Data["PGUID"], "player")
        hbRequestTime=GetTime()+8
    elseif HealBot_Options_Timer[160] then
        HealBot_Options_Timer[160]=nil
        HealBot_Options_SetSkinBars()
    elseif HealBot_Options_Timer[170] then
        HealBot_Options_Timer[170]=nil                        
        HealBot_configClassHoT()
    elseif  HealBot_Options_Timer[180] then
        HealBot_Options_Timer[180]=nil
        if Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["HIDEPARTYF"] then
            HealBot_trackHiddenFrames["PARTY"]=true
            HealBot_Options_DisablePartyFrame()
            HealBot_Options_PlayerTargetFrames:Enable();
            if Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["HIDEPTF"] then
                HealBot_trackHiddenFrames["PLAYER"]=true
                HealBot_Options_DisablePlayerFrame()
                HealBot_Options_DisablePetFrame()
                HealBot_Options_DisableTargetFrame()
            elseif HealBot_trackHiddenFrames["PLAYER"] then 
                HealBot_Options_ReloadUI(HEALBOT_OPTIONS_HIDEPARTYFRAMES.." ("..HEALBOT_OPTIONS_HIDEPLAYERTARGET..") - "..HEALBOT_WORD_OFF)
            end
            if HealBot_luVars["ReloadUI"]>GetTime() then
                HealBot_Options_ReloadUI(HEALBOT_OPTIONS_HIDEPARTYFRAMES.." - "..HEALBOT_WORD_ON)
            end
        elseif HealBot_trackHiddenFrames["PARTY"] then
            HealBot_Options_ReloadUI(HEALBOT_OPTIONS_HIDEPARTYFRAMES.." - "..HEALBOT_WORD_OFF)
        end
    elseif  HealBot_Options_Timer[185] then
        HealBot_Options_Timer[185]=nil
        if Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["HIDEBOSSF"] then
            HealBot_trackHiddenFrames["MINIBOSS"]=true
            HealBot_Options_DisableMiniBossFrame()
            if HealBot_luVars["ReloadUI"]>GetTime() then
                HealBot_Options_ReloadUI(HEALBOT_OPTIONS_HIDEMINIBOSSFRAMES.." - "..HEALBOT_WORD_ON)
            end
        elseif HealBot_trackHiddenFrames["MINIBOSS"] then
            HealBot_Options_ReloadUI(HEALBOT_OPTIONS_HIDEMINIBOSSFRAMES.." - "..HEALBOT_WORD_OFF)
        end
    elseif  HealBot_Options_Timer[188] then
        HealBot_Options_Timer[188]=nil
        if Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["HIDERAIDF"] then
            HealBot_trackHiddenFrames["RAID"]=true
            HealBot_Options_DisableRaidFrame()
            if HealBot_luVars["ReloadUI"]>GetTime() then
                HealBot_Options_ReloadUI(HEALBOT_OPTIONS_HIDERAIDFRAMES.." - "..HEALBOT_WORD_ON)
            end
        elseif HealBot_trackHiddenFrames["RAID"] then
            if HealBot_Globals.RaidHideMethod==0 then
                HealBot_Options_ReloadUI(HEALBOT_OPTIONS_HIDERAIDFRAMES.." - "..HEALBOT_WORD_OFF)
            elseif HealBot_Globals.RaidHideMethod>1 then
                if HealBot_Globals.RaidHideMethod>2 then
                    if HealBot_Globals.RaidHideMethod==4 then
                        Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["HIDERAIDF"]=true
                    end
                    HealBot_Globals.RaidHideMethod=0
                end
                local _, _, _, enabledCRF, _, _, _ = GetAddOnInfo("Blizzard_CompactRaidFrames")
                local _, _, _, enabledCUF, _, _, _ = GetAddOnInfo("Blizzard_CUFProfiles")
                if not enabledCRF or not enabledCUF then 
                    EnableAddOn("Blizzard_CompactRaidFrames")
                    EnableAddOn("Blizzard_CUFProfiles")
                    HealBot_Options_ReloadUI(HEALBOT_OPTIONS_HIDERAIDFRAMES.." - "..HEALBOT_WORD_OFF)
                end
            end
        end
    elseif HealBot_Options_Timer[190] then
        HealBot_Options_Timer[190]=nil
        HealBot_setOptions_Timer(195)
        HealBot_luVars["CheckSkin"]=true
        HealBot_luVars["Checks"]=true
    elseif HealBot_Options_Timer[195] then
        HealBot_Options_InitSub(318)
        HealBot_Options_Timer[195]=nil
    elseif HealBot_Options_Timer[200] then
        HealBot_GetTalentInfo(HealBot_Data["PGUID"], "player")
        HealBot_Options_Timer[200]=nil
    elseif  HealBot_Options_Timer[400] then
        HealBot_Options_Timer[400]=nil
        HealBot_Action_SetAllAttribs()
    elseif  HealBot_Options_Timer[415] then
        local fNo, fType=HealBot_Options_FrameAlias_retUpdates()
        if fNo then
            if fType=="T" then
                HealBot_Action_SetAlias(fNo)
            else
                HealBot_Action_SetAliasFontSize(fNo)
            end
        else
            HealBot_Options_Timer[415]=nil
        end
    elseif  HealBot_Options_Timer[419] then
        HealBot_Options_Timer[419]=nil
        HealBot_Options_FrameAlias_initFrameSel()
    elseif  HealBot_Options_Timer[420] then
        HealBot_Options_Timer[420]=nil
        HealBot_OnEvent_RaidRosterUpdate();
        HealBot_ResetClassIconTexture()
    elseif HealBot_Options_Timer[500] or HealBot_Options_Timer[501] or HealBot_Options_Timer[502] then
        if HealBot_Options_Timer[500] then
         --   HealBot_SetResetFlag("SOFT")
            HealBot_Register_Events()
            HealBot_nextRecalcParty(0);
            HealBot_Options_Timer[500]=nil
        elseif HealBot_Options_Timer[501] then
            HealBot_Config.DisabledNow=1
            HealBot_nextRecalcParty(0);
            HealBot_Options_Timer[501]=nil
            HealBot_Options_Timer[502]=true
        else
            HealBot_UnRegister_Events()
            HealBot_Register_Events()
            for j=1,10 do
                HealBot_Action_HidePanel(j)
            end
            HealBot_Options_Timer[502]=nil
            HealBot_setOptions_Timer(9000)
        end
    elseif HealBot_Options_Timer[550] then
        HealBot_Options_Timer[550]=nil
        HealBot_InitSpells()
    elseif HealBot_Options_Timer[5] then
        HealBot_Options_Timer[5]=nil
        if HEALBOT_ORALIUS_WHISPERING_CRYSTAL=="--Oralius' Whispering Crystal" or HEALBOT_REPURPOSED_FEL_FOCUSER=="--Repurposed Fel Focuser" or HEALBOT_BATTLE_SCARRED_AUGMENT_RUNE=="--Battle-Scarred Augment Rune" or
           HEALBOT_TAILWIND_SAPPHIRE=="--Tailwind Sapphire" or HEALBOT_AMETHYST_OF_THE_SHADOW_KING=="--Amethyst of the Shadow King" then 
            HealBot_OnEvent_ItemInfoReceived() 
        else
            HealBot_Options_InitBuffList()
        end
    elseif not HealBot_Options_Timer[8000] and HealBot_Options_Timer[580] then
        HealBot_Options_Timer[580]=nil
        HealBot_nextRecalcParty(6)
    elseif not HealBot_Options_Timer[8000] and HealBot_Options_Timer[581] then
        HealBot_Options_Timer[581]=nil
        HealBot_nextRecalcParty(1)
    elseif not HealBot_Options_Timer[8000] and HealBot_Options_Timer[582] then
        HealBot_Options_Timer[582]=nil
        HealBot_nextRecalcParty(2)
    elseif not HealBot_Options_Timer[8000] and HealBot_Options_Timer[583] then
        HealBot_Options_Timer[583]=nil
        HealBot_nextRecalcParty(3)
    elseif not HealBot_Options_Timer[8000] and HealBot_Options_Timer[584] then
        HealBot_Options_Timer[584]=nil
        HealBot_nextRecalcParty(4)
    elseif not HealBot_Options_Timer[8000] and HealBot_Options_Timer[585] then
        HealBot_Options_Timer[585]=nil
        HealBot_nextRecalcParty(5)
    elseif HealBot_Options_Timer[590] then
        HealBot_Options_Timer[590]=nil
        local needReset=false
        for xUnit,xButton in pairs(HealBot_Unit_Button) do
            if UnitExists(xUnit) then 
                if xButton.guid~=HealBot_UnitGUID(xUnit) then
                    needReset=true
                    break
                end 
            end
        end
        HealBot_Action_CheckReserved()
        if needReset then
            HealBot_nextRecalcParty(6)
        else
            HealBot_ResetClassIconTexture()
        end
    elseif HealBot_Options_Timer[595] then
        HealBot_Options_Timer[595]=nil
        if not HealBot_Options_Timer[8000] then
            HealBot_nextRecalcParty(0)
        end
    elseif HealBot_Options_Timer[800] then
        HealBot_Options_Timer[800]=nil
        HealBot_Options_RaidTargetUpdate()
    elseif  HealBot_Options_Timer[950] then
        HealBot_Options_Timer[950]=nil
        local _,z = GetNumMacros()
        if z>12 then
            HealBot_useCrashProtection()
        end
    elseif  HealBot_Options_Timer[990] then
        HealBot_Options_Timer[990]=nil
        HealBot_AddChat("  "..HEALBOT_ADDON .. HEALBOT_LOADED);
        HealBot_AddChat(HEALBOT_HELP[1])
    elseif HealBot_Options_Timer[4910] then
        HealBot_Options_Timer[4910]=nil
        HealBot_Action_setLowManaTrig()
        HealBot_CheckLowMana()
    elseif HealBot_Options_Timer[7950] then
        if GetTime()>HealBot_luVars["hbInsNameCheck"] then
            HealBot_Options_Timer[7950]=nil
            HealBot_luVars["hbInsNameCheck"]=nil
            local mapAreaID = C_Map.GetBestMapForUnit("player")
            HealBot_setOptions_Timer(30)
            local y,z = IsInInstance()
            local mapName=HEALBOT_WORD_OUTSIDE
            if mapAreaID and mapAreaID>0 and C_Map.GetMapInfo(mapAreaID).name then
                mapName=C_Map.GetMapInfo(mapAreaID).name
            elseif z and z=="arena" then 
                mapName="Arena"
            end
            if z and (z=="pvp" or z=="arena") then 
                HealBot_luVars["inBG"]=true 
            else
                HealBot_luVars["inBG"]=nil
            end                            
            HealBot_Data["MAPID"]=mapAreaID
            HealBot_Options_SetEnableDisableCDBtn()
            HealBot_SetAddonComms()
            HealBot_setOptions_Timer(9000)
        end
    elseif HealBot_Options_Timer[8000] then
        HealBot_Options_Timer[8000]=HealBot_Options_idleInit()
        if HealBot_Options_Timer[8000] then
            HealBot_luVars["Timer8000"]=(HealBot_luVars["Timer8000"])+1
        end
        if not HealBot_Options_Timer[8000] then
            HealBot_AddDebug("Timer 8000 called #"..HealBot_luVars["Timer8000"])
            HealBot_luVars["Timer8000"]=0
            HealBot_setqaFR()
            HealBot_setOptions_Timer(9000)
            HealBot_CheckAllBuffs("player")
            HealBot_nextRecalcParty(0)
        end
    elseif HealBot_Options_Timer[9000] then
        HealBot_Options_Timer[9000]=nil
        HealBot_Set_Timers()
    else
        HealBot_luVars["HealBot_Options_Timer"]=nil
        HealBot_Set_Timers()
    end
  --HealBot_setCall("HealBot_Options_Update")
end

local function HealBot_NoVehicle(unit)
    local HBvUnits=HealBot_VehicleUnit[unit]
    for xUnit,_ in pairs(HBvUnits) do
        if HealBot_UnitInVehicle[xUnit] then HealBot_UnitInVehicle[xUnit]=nil end
    end
	if HealBot_VehicleUnit[unit] then HealBot_VehicleUnit[unit]=nil end
    local vGUID=HealBot_UnitGUID(unit)
    if vGUID and HealBot_UnitData[vGUID] and HealBot_UnitData[vGUID]["VEHICLE"] then
        HealBot_UnitData[vGUID]=nil
    end
  --HealBot_setCall("HealBot_NoVehicle")
end

local function HealBot_OnEvent_UnitThreat(button)
    if not UnitIsDeadOrGhost("player") then
        if UnitAffectingCombat(button.unit) and UnitIsVisible(button.unit) then
            if not HealBot_Data["UILOCK"] and HealBot_Globals.EnAutoCombat then
                local z, y=HealBot_CalcThreat(button.unit)
                local x=y+z
                if x>0 then 
                    HealBot_OnEvent_PlayerRegenDisabled()
                end
            end
            if Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["SHOW"] then
                HealBot_CheckAggroUnits(button)
            end
        end
    end
  --HealBot_setCall("HealBot_OnEvent_UnitThreat")
end

local function HealBot_MaxHealth()
    if UnitExists("boss1") then
        local maxHealthPercent = select(15, UnitAura("boss1", HEALBOT_DEBUFF_AURA_OF_CONTEMPT_ID))
        if maxHealthPercent then
            local healthFactor = maxHealthPercent / 100
            if healthFactor~=HealBot_luVars["healthFactor"] then
                HealBot_luVars["healthFactor"]=healthFactor
            end
        end
    end
end

local ebubar=nil
local health,healthMax,bptc=0,0,0
function HealBot_OnEvent_UnitHealth(button)
    button.health.updhealth=false
    if UnitExists(button.unit) then
        if HealBot_luVars["adjMaxHealth"] then HealBot_MaxHealth() end
        health,healthMax=UnitHealth(button.unit),(UnitHealthMax(button.unit) * HealBot_luVars["healthFactor"])
        if (health~=button.health.current) or (healthMax~=button.health.max) then
            HealBot_OnEvent_UnitThreat(button)
            button.health.current=health
            button.health.max=healthMax
            HealBot_Action_setHealthText(button)
            HealBot_Action_UpdateHealthButton(button)
        elseif not Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["FLUIDBARS"] then
            ebubar = _G["HealBot_Action_HealUnit"..button.id.."Bar"]
            bptc=floor((button.health.current/button.health.max)*100)
            if (Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IC"] == 3) then
                bptc=floor(((button.health.current+button.health.incoming)/button.health.max)*100)
                if bptc>100 then bptc=100 end
            end
            if ebubar:GetValue()~=bptc then 
                HealBot_Action_setHealthText(button)
                HealBot_Action_UpdateHealthButton(button)
            end
        end
    end
  --HealBot_setCall("HealBot_OnEvent_UnitHealth")
end

local function HealBot_OnEvent_VehicleChange(self, unit, enterVehicle)
    local xUnit,_,xButton = HealBot_UnitID(unit)
    if xButton then
        HealBot_Action_setHealthText(xButton)
        local doRefresh=false
        if enterVehicle then
            local vUnit=HealBot_UnitPet(xUnit)
            if vUnit and UnitHasVehicleUI(xUnit) then
                local vButton=HealBot_Pet_Button[vUnit]
                if not HealBot_VehicleUnit[vUnit] then HealBot_VehicleUnit[vUnit]={} end
                HealBot_VehicleUnit[vUnit][xUnit]=true
                HealBot_UnitInVehicle[xUnit]=vUnit
                local xGUID=HealBot_UnitGUID(vUnit)
                if xGUID and not HealBot_UnitData[xGUID] then 
                    HealBot_UnitData[xGUID] = {}
                    HealBot_UnitData[xGUID]["UNIT"]=vUnit 
                    HealBot_UnitData[xGUID]["VEHICLE"]=true 
                end
                if vButton then 
                    vButton.health.updhealth=true
                    vButton.health.update=true 
                end
                doRefresh=true
            end
        elseif HealBot_UnitInVehicle[xUnit] then
            local vUnit=HealBot_UnitInVehicle[xUnit]
            HealBot_NoVehicle(vUnit)
            doRefresh=true
        end
        if doRefresh then
            HealBot_RecalcHeals(xButton)
            if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["STATE"] then
                HealBot_nextRecalcParty(1)
            end
        end
    end
  --HealBot_setCall("HealBot_OnEvent_VehicleChange")
end

local function HealBot_RaidTargetChecked(iconID, hbCurFrame)
    local z=nil
    if iconID==1 then
        if Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][hbCurFrame]["STAR"] then z=true end
    elseif iconID==2 then
        if Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][hbCurFrame]["CIRCLE"] then z=true end
    elseif iconID==3 then
        if Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][hbCurFrame]["DIAMOND"] then z=true end
    elseif iconID==4 then
        if Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][hbCurFrame]["TRIANGLE"] then z=true end
    elseif iconID==5 then
        if Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][hbCurFrame]["MOON"] then z=true end
    elseif iconID==6 then
        if Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][hbCurFrame]["SQUARE"] then z=true end
    elseif iconID==7 then
        if Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][hbCurFrame]["CROSS"] then z=true end
    elseif iconID==8 then
        if Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][hbCurFrame]["SKULL"] then z=true end
    end
  --HealBot_setCall("HealBot_RaidTargetChecked")
    return z
end

function HealBot_OnEvent_RaidTargetUpdate(button)
    if UnitExists(button.unit) then 
        local x=GetRaidTargetIndex(button.unit)
        if x and HealBot_RaidTargetChecked(x, button.frame) then
            HealBot_RaidTargetUpdate(button, x)
        else
            HealBot_RaidTargetUpdate(button, 0)
        end
    else
        HealBot_RaidTargetUpdate(button, 0)
    end
  --HealBot_setCall("HealBot_OnEvent_RaidTargetUpdate")
end

function HealBot_OnEvent_RaidTargetUpdateAll()
    for _,xButton in pairs(HealBot_Unit_Button) do
        xButton.update.targeticon=true
        xButton.status.update=true
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        xButton.update.targeticon=true
        xButton.status.update=true
    end
  --HealBot_setCall("HealBot_OnEvent_RaidTargetUpdateAll")
end

local function HealBot_PartyUpdate_CheckSkin()
    local _,z = IsInInstance()
    local PrevSolo=HealBot_luVars["IsSolo"]
    local LastAutoSkinChangeType="None"
    local newSkinName="_-none-_"
    HealBot_luVars["IsSolo"]=nil
    HealBot_luVars["CheckSkin"]=false
    if z == "arena" then
        for x in pairs (Healbot_Config_Skins.Skins) do
            if HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]][HEALBOT_WORD_ARENA] then
                    LastAutoSkinChangeType="Arena"
                    newSkinName=Healbot_Config_Skins.Skins[x]
                break
            end
        end
    elseif z=="pvp" then
        local y=GetRealZoneText()
        if GetNumGroupMembers()>29 or y==HEALBOT_ZONE_AV or y==HEALBOT_ZONE_IC then
            for x in pairs (Healbot_Config_Skins.Skins) do
                if HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]][HEALBOT_WORD_BG40] then
                    LastAutoSkinChangeType="BG40"
                    newSkinName=Healbot_Config_Skins.Skins[x]
                    break
                end
            end
        elseif GetNumGroupMembers()>11 or y==HEALBOT_ZONE_SA or y==HEALBOT_ZONE_ES or y==HEALBOT_ZONE_AB then
            for x in pairs (Healbot_Config_Skins.Skins) do
                if HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]][HEALBOT_WORD_BG15] then
                    LastAutoSkinChangeType="BG15"
                    newSkinName=Healbot_Config_Skins.Skins[x]
                    break
                end
            end
        else
            for x in pairs (Healbot_Config_Skins.Skins) do
                if HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]][HEALBOT_WORD_BG10] then
                    LastAutoSkinChangeType="BG10"
                    newSkinName=Healbot_Config_Skins.Skins[x]
                    break
                end
            end
        end
    elseif IsInRaid() then
        if GetNumGroupMembers()>29 then
            for x in pairs (Healbot_Config_Skins.Skins) do
                if HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]][HEALBOT_OPTIONS_RAID40] then
                    LastAutoSkinChangeType="Raid40"
                    newSkinName=Healbot_Config_Skins.Skins[x]
                    break
                end
            end
        elseif GetNumGroupMembers()>15 then
            for x in pairs (Healbot_Config_Skins.Skins) do
                if HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]][HEALBOT_OPTIONS_RAID25] then
                    LastAutoSkinChangeType="Raid25"
                    newSkinName=Healbot_Config_Skins.Skins[x]
                    break
                end
            end
        else
            for x in pairs (Healbot_Config_Skins.Skins) do
                if HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]][HEALBOT_OPTIONS_RAID10] then
                    LastAutoSkinChangeType="Raid10"
                    newSkinName=Healbot_Config_Skins.Skins[x]
                    break
                end
            end
        end
    elseif IsInGroup() and GetNumGroupMembers()>0 then
        for x in pairs (Healbot_Config_Skins.Skins) do
            if HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]][HEALBOT_WORD_PARTY] then
                LastAutoSkinChangeType="Party"
                newSkinName=Healbot_Config_Skins.Skins[x]
                break
            end
        end
    elseif C_PetBattles.IsInBattle() and HealBot_luVars["lastPetBattleEvent"]~="PET_BATTLE_OVER" then
        for x in pairs (Healbot_Config_Skins.Skins) do
            if HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]][HEALBOT_WORD_PETBATTLE] then
                LastAutoSkinChangeType="Pet"
                newSkinName=Healbot_Config_Skins.Skins[x]
                break
            end
        end
    else
        for x in pairs (Healbot_Config_Skins.Skins) do
            if HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]][HEALBOT_WORD_SOLO] then
                LastAutoSkinChangeType="Solo"
                newSkinName=Healbot_Config_Skins.Skins[x]
                break
            end
        end
        HealBot_luVars["IsSolo"]=true
        HealBot_Options_DisableCheck()
    end
    if LastAutoSkinChangeType~=HealBot_Config.LastAutoSkinChangeType or HealBot_Config.LastAutoSkinChangeTime<GetTime() then
        if newSkinName~="_-none-_" and newSkinName~=Healbot_Config_Skins.Current_Skin then
            HealBot_Options_Set_Current_Skin(newSkinName)
        end
        HealBot_Config.LastAutoSkinChangeType=LastAutoSkinChangeType
    end
    if (PrevSolo or "nil")~=(HealBot_luVars["IsSolo"] or "nil") then
        HealBot_SetAuraChecks()
    end
  --HealBot_setCall("HealBot_PartyUpdate_CheckSkin")
end

local function HealBot_Check_Pets()
    local nUnits=GetNumGroupMembers();
    local RecalcParty=false
    if IsInRaid() then 
        for j=1,nUnits do
            if UnitExists("raidpet"..j) and not HealBot_Pet_Button["raidpet"..j] then
                RecalcParty=true
                break
            end
        end
    elseif nUnits>1 then
        for j=1,4 do
            if UnitExists("partypet"..j) and not HealBot_Pet_Button["partypet"..j] then
                RecalcParty=true
                break
            end
        end
    end
    if UnitExists("pet") and not HealBot_Pet_Button["pet"] then
        RecalcParty=true
    end
  --HealBot_setCall("HealBot_Check_Pets")
    return RecalcParty
end

local function HealBot_Not_Fighting()
    HealBot_Data["UILOCK"]=false
    HealBot_RecalcParty(5);
    if HealBot_luVars["SoftResetAfterCombat"] then
        HealBot_luVars["SoftResetAfterCombat"]=false
        HealBot_SetResetFlag("QUICK")
    else
        if HealBot_Config_Buffs.BuffWatch and not HealBot_Config_Buffs.BuffWatchInCombat then
            HealBot_CheckAllBuffs()
        end
        if HealBot_Config_Cures.DebuffWatch and not HealBot_Config_Cures.DebuffWatchInCombat then
            HealBot_CheckAllDebuffs()
        end
        HealBot_Action_CheckHideFrames()
        HealBot_Action_ResetActiveUnitStatus()
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["STATE"] and HealBot_Check_Pets() then
            HealBot_nextRecalcParty(2)
            HealBot_AddDebug("Exit Combat HealBot_Check_Pets RecalcParty=true")
        end
    end
    if HealBot_Globals.DisableToolTipInCombat and HealBot_Data["TIPUSE"] and HealBot_Data["TIPUNIT"] then
        HealBot_Action_RefreshTooltip();
    end
    HealBot_EndAggro()
    if Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["LOWMANA"]>1 and Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["LOWMANACOMBAT"]==false then
        HealBot_CheckLowMana()
    end
    if HealBot_luVars["MessageReloadUI"]>0 then
        HealBot_MessageReloadUI(HealBot_luVars["MessageReloadUI"])
    end
    if not Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TALWAYSSHOW"] and HealBot_Unit_Button["target"] then
        HealBot_OnEvent_PlayerTargetChanged(true)
    end
    HealBot_EndInstanceEncounter()
  --HealBot_setCall("HealBot_Not_Fighting")
end

local function HealBot_OnEvent_ReadyCheckClear()
    for _,xButton in pairs(HealBot_Unit_Button) do
        if xButton.icon.debuff.readycheck then
            xButton.icon.debuff.readycheck=false
            HealBot_DebuffChecks(xButton)
        end
    end
  --HealBot_setCall("HealBot_OnEvent_ReadyCheckClear")
end

local function HealBot_Update_Slow()
    TimeNow=GetTime()
    if HealBot_luVars["rcEnd"] and HealBot_luVars["rcEnd"]<TimeNow then
        HealBot_luVars["rcEnd"]=nil
        HealBot_OnEvent_ReadyCheckClear()
    end
    if not HealBot_Data["UILOCK"] and not InCombatLockdown() then
        if HealBot_luVars["HealBot_Refresh"] then
            if HealBot_RefreshTypes[0] then
                HealBot_RefreshTypes[1]=false
                HealBot_RefreshTypes[2]=false
                HealBot_RefreshTypes[3]=false
                HealBot_RefreshTypes[4]=false
                HealBot_RefreshTypes[5]=false
                HealBot_RecalcParty(0)
            elseif HealBot_RefreshTypes[6] then
                HealBot_RecalcParty(6)
            elseif HealBot_RefreshTypes[1] then 
                HealBot_RecalcParty(1) 
            elseif HealBot_RefreshTypes[2] then 
                HealBot_RecalcParty(2)
            elseif HealBot_RefreshTypes[3] then 
                HealBot_RecalcParty(3)
            elseif HealBot_RefreshTypes[4] then 
                HealBot_RecalcParty(4)
            elseif HealBot_RefreshTypes[5] then 
                HealBot_RecalcParty(5)
            end
            HealBot_needRecalcParty()
        elseif HealBot_luVars["Checks"] then
            if HealBot_luVars["CheckSkin"] then
                HealBot_PartyUpdate_CheckSkin()
            elseif HealBot_luVars["CheckTalents"] then
                HealBot_luVars["CheckTalents"]=false; 
                HealBot_GetTalentInfo(HealBot_Data["PGUID"], "player")
            elseif HealBot_luVars["ResetCheckBuffsTime"] then
                HealBot_luVars["ResetCheckBuffsTime"]=false
                HealBot_ResetCheckBuffsTime()
            else
                HealBot_luVars["Checks"]=false
            end
        elseif HealBot_luVars["CheckPlayerBuffsGUID"] and HealBot_luVars["CheckPlayerBuffsTime"]<TimeNow then
            local PlayerBuffsGUID=HealBot_PlayerBuff[HealBot_luVars["CheckPlayerBuffsGUID"]]
            if PlayerBuffsGUID then
                HealBot_CheckAllBuffs(HealBot_Panel_RaidUnit(HealBot_luVars["CheckPlayerBuffsGUID"]))
            else
                HealBot_luVars["ResetCheckBuffsTime"]=true
                HealBot_luVars["Checks"]=true
            end
            HealBot_luVars["CheckPlayerBuffsGUID"]=false
        elseif HealBot_ReCheckBuffsTime and HealBot_ReCheckBuffsTime<TimeNow then
            HealBot_CheckAllBuffs(HealBot_Panel_RaidUnit(HealBot_ReCheckBuffsTimed[HealBot_ReCheckBuffsTime]))
            HealBot_ReCheckBuffsTimed[HealBot_ReCheckBuffsTime]=nil
            local z=HealBot_ReCheckBuffsTime+1000000
            HealBot_ReCheckBuffsTime=nil 
            for Time,_ in pairs (HealBot_ReCheckBuffsTimed) do
                if Time < z then
                    z=Time
                    HealBot_ReCheckBuffsTime=Time
                end
            end
        elseif HealBot_luVars["ResetFlag"] then
            if HealBot_luVars["ResetFlag"]==1 then
                HealBot_Reset("Full")
            elseif HealBot_luVars["ResetFlag"]==2 then
                HealBot_ResetCustomDebuffs()
            elseif HealBot_luVars["ResetFlag"]==3 then
                HealBot_ResetSkins()
            elseif HealBot_luVars["ResetFlag"]==4 then
                HealBot_Reset("Quick")
            end
            HealBot_luVars["ResetFlag"]=false 
        elseif HealBot_luVars["HealBot_Options_Timer"] then
            HealBot_Options_Update()
        elseif hbShareSkins[1] then
            local unitName,tMsg=string.split("!",hbShareSkins[1])
            HealBot_Comms_SendAddonMsg(HEALBOT_HEALBOT, tMsg, 4, unitName)
            table.remove(hbShareSkins,1)
            HealBot_luVars["shareSkinsSent"]=HealBot_luVars["shareSkinsSent"]+1
            local tabSize=HealBot_luVars["shareSkinsTabSize"]
            if tabSize<47 then tabSize=47 end
            local pctDone=floor((HealBot_luVars["shareSkinsSent"]/tabSize)*100)
            HealBot_Options_ShareSkinStatus:SetValue(pctDone)
            HealBot_Options_ShareSkinStatusf:SetText(pctDone.."%")
        elseif (HealBot_luVars["shareSkinsSent"] or 0)>0 then
            HealBot_Options_ShareSkinStatusf:SetTextColor(1,1,1,0)
            HealBot_Options_ShareSkinStatus:SetStatusBarColor(0.3,0.3,0.9,0)
            HealBot_luVars["shareSkinsSent"]=0
        else
            HealBot_luVars["slowSwitch"]=HealBot_luVars["slowSwitch"]+1
            if HealBot_luVars["slowSwitch"]<2 then
                for xGUID,xUnit in pairs(HealBot_notVisible) do
                    if UnitIsVisible(xUnit) then
                        HealBot_nextRecalcParty(0)
                        HealBot_notVisible[xGUID]=nil
                    end
                end
            elseif HealBot_luVars["slowSwitch"]<3 then
                if HealBot_DebugMsg[1] and (HealBot_luVars["nextDebugMsg"] or 0)<TimeNow then
                    HealBot_luVars["nextDebugMsg"]=TimeNow+1
                    local hbDebugChan=HealBot_Comms_GetChan("HBmsg");
                    if hbDebugChan then
                        SendChatMessage(HealBot_DebugMsg[1] , "CHANNEL", nil, hbDebugChan);
                    end
                    table.remove(HealBot_DebugMsg,1)
                end
            elseif HealBot_luVars["slowSwitch"]<4 then
                if HealBot_luVars["VersionRequest"] then
                    HealBot_Comms_SendAddonMsg(HEALBOT_HEALBOT, "S:"..HEALBOT_VERSION, HealBot_luVars["AddonMsgType"], HealBot_Data["PNAME"])
                    HealBot_luVars["VersionRequest"]=false;
                end
            elseif HealBot_luVars["slowSwitch"]<5 then
                if HealBot_luVars["clearGUID"] then
                    HealBot_check2clearGUID(HealBot_luVars["clearGUID"])
                    HealBot_luVars["clearGUID"]=false
                elseif HealBot_markedGUIDs[1] then
                    HealBot_luVars["clearGUID"]=HealBot_markedGUIDs[1]
                    table.remove(HealBot_markedGUIDs,1)
                end
            else
                HealBot_setqaFR()
                HealBot_luVars["slowSwitch"]=0
            end
        end
    elseif HealBot_luVars["IsReallyFighting"] then
        if not InCombatLockdown() then
            HealBot_luVars["IsReallyFighting"] = nil
            HealBot_Not_Fighting()
        end
    elseif not InCombatLockdown() then
        if not HealBot_luVars["DelayLockdownCheck"] or HealBot_luVars["DelayLockdownCheck"]<TimeNow then
            if not HealBot_Globals.EnAutoCombat then
                HealBot_luVars["IsReallyFighting"]=true
            else
                local endCombat=true
                if not UnitIsDeadOrGhost("player")  then
                    for xUnit,xButton in pairs(HealBot_Unit_Button) do
                        if UnitExists(xUnit) and UnitAffectingCombat(xUnit) and UnitIsVisible(xUnit) then
                            endCombat=false
                            break
                        end
                    end 
                end
                if endCombat then
                    HealBot_luVars["IsReallyFighting"]=true
                end
            end
        end
    end
    if HealBot_luVars["mapUpdate"] and HealBot_luVars["mapUpdate"]<TimeNow then
        HealBot_luVars["mapUpdate"]=nil
        local mapAreaID = C_Map.GetBestMapForUnit('player')
        HealBot_Data["MAPID"]=mapAreaID or 0
        --HealBot_AddDebug("mapID="..HealBot_Data["MAPID"])
    elseif HealBot_luVars["Help"] then 
        if HealBot_luVars["HelpCnt1"] then
            HealBot_luVars["HelpCnt1"]=HealBot_luVars["HelpCnt1"]+1
            if HealBot_luVars["HelpCnt1"]>#HEALBOT_HELP then
                HealBot_luVars["HelpCnt1"]=nil
            else
                HealBot_AddChat(HEALBOT_HELP[HealBot_luVars["HelpCnt1"]])
            end
        end
        if HealBot_luVars["HelpCnt2"] then
            HealBot_luVars["HelpCnt2"]=HealBot_luVars["HelpCnt2"]+1
            if HealBot_luVars["HelpCnt2"]>#HEALBOT_HELP2 then
                HealBot_luVars["HelpCnt2"]=nil
            else
                HealBot_AddChat(HEALBOT_HELP2[HealBot_luVars["HelpCnt2"]])
            end
        end
        if not HealBot_luVars["HelpCnt1"] and not HealBot_luVars["HelpCnt2"] then
            HealBot_luVars["Help"]=false
        end
    end
    --HealBot_setCall("HealBot_Update_Slow")
end

local curDebuffs={}
local prevDebuff={}
local DebuffClass=nil

local function HealBot_addCurDebuffs(dName,deBuffTexture,bCount,debuff_type,debuffDuration,expirationTime,spellId,unitCaster,isBossDebuff,button)
    local dNamePriority, dTypePriority=HealBot_Options_retDebuffPriority(dName, debuff_type)
    if dTypePriority>dNamePriority and dNamePriority<21 then
        local castByListIndexed = HealBot_Options_getCDebuffCasyByIndexed()
        local hbCastByEveryone = castByListIndexed[HEALBOT_CUSTOM_CASTBY_EVERYONE] or -1
        local hbCastByEnemy = castByListIndexed[HEALBOT_CUSTOM_CASTBY_ENEMY] or -1
        local hbCastByFriend = castByListIndexed[HEALBOT_CUSTOM_CASTBY_FRIEND] or -1
        local hbCastBySelf = castByListIndexed[HEALBOT_OPTIONS_SELFHEALS] or -1
 
        local hbCasterID=HealBot_Globals.FilterCustomDebuff[dName] or 0
        local unitCasterID=hbCastByEveryone
        if hbCasterID==0 then
            if HealBot_Globals.CureCustomDefaultCastBy=="ALL" then
                hbCasterID = hbCastByEveryone
            elseif HealBot_Globals.CureCustomDefaultCastBy=="ENEMY" then
                hbCasterID = hbCastByEnemy
            end
        end
        if hbCasterID~=hbCastByEveryone then
            if unitCaster and unitCaster=="player" then
                unitCasterID=hbCastBySelf --4
                if hbCasterID==3 then 
                    hbCasterID=hbCastBySelf 
                end
            elseif unitCaster and not UnitIsEnemy("player",unitCaster) then
                unitCasterID=hbCastByFriend --3
            else
                unitCasterID=hbCastByEnemy --2
            end
        end
        if HealBot_Globals.IgnoreCustomDebuff[dName] and HealBot_Globals.IgnoreCustomDebuff[dName][HealBot_luVars["hbInsName"]] then
            -- Ignore it
        elseif unitCasterID==hbCasterID then 
            curDebuffs[dName]={}
            debuff_type=HEALBOT_CUSTOM_en
            curDebuffs[dName]["priority"]=dNamePriority
            if hbCasterID==hbCastByEveryone then
                curDebuffs[dName]["always"]=true
            else
                curDebuffs[dName]["always"]=false
            end
        end
    else
        local checkthis,always=false,false;
        if dTypePriority<21 then
            local spellCD=0
            local WatchTarget, WatchGUID=nil,nil
            if HealBot_Config_Cures.IgnoreOnCooldownDebuffs then 
                    spellCD=HealBot_Options_retDebuffWatchTargetCD(debuff_type)
            end
            if spellCD<=1.5 then
                WatchTarget, WatchGUID=HealBot_Options_retDebuffWatchTarget(debuff_type,button.guid);
            end
            if WatchTarget then 
                if WatchTarget["Raid"] then
                    checkthis=true;
                    always=true
                elseif WatchTarget["Party"] and (UnitInParty(button.unit) or button.guid==HealBot_Data["PGUID"]) then
                    checkthis=true;
                elseif WatchTarget["Self"] and button.guid==HealBot_Data["PGUID"] then
                    checkthis=true
                elseif WatchTarget[strsub(DebuffClass,1,4)] then
                    checkthis=true;
                elseif WatchTarget["PvP"] and UnitIsPVP("player") then
                    checkthis=true;
                elseif WatchTarget["Name"] and button.guid==WatchGUID then
                    checkthis=true;
                elseif WatchTarget["Focus"] and UnitIsUnit(button.unit, "focus") then
                    checkthis=true;
                elseif WatchTarget["MainTanks"] and HealBot_Panel_IsTank(button.guid) then
                    checkthis=true;
                elseif WatchTarget["MyTargets"] then
                    local myhTargets=HealBot_GetMyHealTargets();
                    for i=1, #myhTargets do
                        if button.guid==myhTargets[i] then
                            checkthis=true;
                            break
                        end
                    end
                end
            end
            if checkthis then
                if HealBot_luVars["MaskAuraDCheck"]>TimeNow then
                    checkthis=false;
                    prevDebuff["name"]="x" 
                elseif HealBot_Config_Cures.IgnoreFriendDebuffs and unitCaster and unitCaster~=button.unit and UnitIsFriend("player",unitCaster) then
                    checkthis=false;
                elseif HealBot_Config_Cures.IgnoreMovementDebuffs and HealBot_Ignore_Debuffs["Movement"][dName] then
                    checkthis=false;
                elseif prevDebuff["name"]~=dName and HealBot_Config_Cures.IgnoreFastDurDebuffs and debuffDuration and debuffDuration>0 
                  and (debuffDuration<HealBot_Config_Cures.IgnoreFastDurDebuffsSecs or expirationTime<TimeNow+HealBot_Config_Cures.IgnoreFastDurDebuffsSecs) then
                    checkthis=false;
                elseif HealBot_Config_Cures.IgnoreNonHarmfulDebuffs and HealBot_Ignore_Debuffs["NonHarmful"][dName] then
                    checkthis=false;
                elseif HealBot_Config_Cures.IgnoreClassDebuffs and HealBot_Ignore_Debuffs["Class"][strsub(DebuffClass,1,4)][dName] then
                    checkthis=false;
                end
            end
        end
        if checkthis then
            curDebuffs[dName]={}
            curDebuffs[dName]["priority"]=dTypePriority
            curDebuffs[dName]["always"]=always
        elseif isBossDebuff and HealBot_Config_Cures.AlwaysShowBoss and (UnitExists("boss1") or not HealBot_Config_Cures.AlwaysShowBossStrict) then
            curDebuffs[dName]={}
            debuff_type=HEALBOT_CUSTOM_en
            curDebuffs[dName]["priority"]=21
            if dTypePriority<21 then
                curDebuffs[dName]["always"]=false
            else
                curDebuffs[dName]["always"]=true
            end
        elseif HealBot_Config_Cures.HealBot_Custom_Defuffs_All[debuff_type] then
            curDebuffs[dName]={}
            debuff_type=HEALBOT_CUSTOM_en
            curDebuffs[dName]["priority"]=22
            if dTypePriority<21 then
                curDebuffs[dName]["always"]=false
            else
                curDebuffs[dName]["always"]=true
            end
        end
    end
    if curDebuffs[dName] then
        curDebuffs[dName]["type"]=debuff_type
        curDebuffs[dName]["texture"]=deBuffTexture
        curDebuffs[dName]["bCount"]=bCount
        curDebuffs[dName]["expirationTime"]=expirationTime
        curDebuffs[dName]["spellId"]=spellId
        curDebuffs[dName]["current"]=true
        if HealBot_Globals.HealBot_Custom_Debuffs_RevDur[dName] then
            if not HealBot_CustomDebuff_RevDurLast[dName] then HealBot_CustomDebuff_RevDurLast[dName]={} end
            if not HealBot_CustomDebuff_RevDurLast[dName][button.unit] or HealBot_CustomDebuff_RevDurLast[dName][button.unit]<(expirationTime-debuffDuration) then
                HealBot_CustomDebuff_RevDurLast[dName][button.unit]=TimeNow
            end
        end
       -- if prevDebuff["name"]==dName then
       --     button.aura.debuff.type=curDebuffs[dName]["type"]
       --     button.aura.debuff.priority=curDebuffs[dName]["priority"]
       -- end
    end
  --HealBot_setCall("HealBot_addCurDebuffs")
end

local debuffIcons = {[1]={},[2]={},[3]={},[4]={},[5]={}}
local function HealBot_BumpDebuffIcon(button,id)
    local iconcount=button.icon.debuff.count
    if iconcount>4 then iconcount=4 end
    for x=iconcount,id,-1 do
        debuffIcons[x+1]["name"]=debuffIcons[x]["name"]
        debuffIcons[x+1]["priority"]=debuffIcons[x]["priority"]
        debuffIcons[x+1]["texture"]=debuffIcons[x]["texture"]
        debuffIcons[x+1]["count"]=debuffIcons[x]["count"]
        debuffIcons[x+1]["expirationTime"]=debuffIcons[x]["expirationTime"]
        debuffIcons[x+1]["index"]=x+51
    end
  --HealBot_setCall("HealBot_BumpDebuffIcon")
end

local function HealBot_SetDebuffIcon(button, id, dName)
    debuffIcons[id]["name"]=dName
    debuffIcons[id]["priority"]=curDebuffs[dName]["priority"]
    debuffIcons[id]["texture"]=curDebuffs[dName]["texture"]
    debuffIcons[id]["count"]=curDebuffs[dName]["bCount"]
    debuffIcons[id]["expirationTime"]=curDebuffs[dName]["expirationTime"]
    debuffIcons[id]["index"]=50+id
  --HealBot_setCall("HealBot_SetDebuffIcon")
end


local function HealBot_CheckUnitDebuffIcons(button)
    if button.icon.debuff.classtexture and button.icon.debuff.count<5 then
        button.icon.debuff.count=button.icon.debuff.count+1
        debuffIcons[button.icon.debuff.count]["name"]="ExtraIcon"
        debuffIcons[button.icon.debuff.count]["texture"]=button.icon.debuff.classtexture
        debuffIcons[button.icon.debuff.count]["count"]=0
        debuffIcons[button.icon.debuff.count]["expirationTime"]=0
        debuffIcons[button.icon.debuff.count]["index"]=50+button.icon.debuff.count
    end
    if button.icon.debuff.targeticon>0 and button.icon.debuff.count<5 then
        local HealBot_TargetIconsTextures = {[1]=[[Interface\Addons\HealBot\Images\Star.tga]],
                                             [2]=[[Interface\Addons\HealBot\Images\Circle.tga]],
                                             [3]=[[Interface\Addons\HealBot\Images\Diamond.tga]],
                                             [4]=[[Interface\Addons\HealBot\Images\Triangle.tga]],
                                             [5]=[[Interface\Addons\HealBot\Images\Moon.tga]],
                                             [6]=[[Interface\Addons\HealBot\Images\Square.tga]],
                                             [7]=[[Interface\Addons\HealBot\Images\Cross.tga]],
                                             [8]=[[Interface\Addons\HealBot\Images\Skull.tga]],}
        button.icon.debuff.count=button.icon.debuff.count+1
        debuffIcons[button.icon.debuff.count]["name"]="ExtraIcon"
        debuffIcons[button.icon.debuff.count]["texture"]=HealBot_TargetIconsTextures[button.icon.debuff.targeticon]
        debuffIcons[button.icon.debuff.count]["count"]=0
        debuffIcons[button.icon.debuff.count]["expirationTime"]=0
        debuffIcons[button.icon.debuff.count]["index"]=50+button.icon.debuff.count
    end
    if button.icon.debuff.readycheck and button.icon.debuff.count<5 then
        button.icon.debuff.count=button.icon.debuff.count+1
        debuffIcons[button.icon.debuff.count]["name"]="ExtraIcon"
        debuffIcons[button.icon.debuff.count]["texture"]=button.icon.debuff.readycheck
        debuffIcons[button.icon.debuff.count]["count"]=0
        debuffIcons[button.icon.debuff.count]["expirationTime"]=0
        debuffIcons[button.icon.debuff.count]["index"]=50+button.icon.debuff.count
    end
    
    if button.icon.debuff.count<HealBot_luVars["prevIconCount"] then 
        for i = HealBot_luVars["prevIconCount"], button.icon.debuff.count+1, -1 do
            HealBot_RemoveIcon(button, 50+i)
        end
    end    
    UnitDebuffIcons=HealBot_UnitDebuffIcons[button.unit]
    for dName,_ in pairs(UnitDebuffIcons) do
        UnitDebuffIcons[dName].current=false
    end
    if button.icon.debuff.count>0 then
        for i = 1, button.icon.debuff.count do
            if not UnitDebuffIcons[debuffIcons[i]["name"]] then 
                UnitDebuffIcons[debuffIcons[i]["name"]]={}
            end
            UnitDebuffIcons[debuffIcons[i]["name"]].count=debuffIcons[i]["count"]
            UnitDebuffIcons[debuffIcons[i]["name"]].expirationTime=debuffIcons[i]["expirationTime"]
            UnitDebuffIcons[debuffIcons[i]["name"]].current=true
            if ((UnitDebuffIcons[debuffIcons[i]["name"]].index or 0)~=debuffIcons[i]["index"]) or (UnitDebuffIcons[debuffIcons[i]["name"]].texture~=debuffIcons[i]["texture"]) then
                UnitDebuffIcons[debuffIcons[i]["name"]].texture=debuffIcons[i]["texture"]
                UnitDebuffIcons[debuffIcons[i]["name"]].index = debuffIcons[i]["index"]
                HealBot_AddIcon(button, debuffIcons[i])
            end
            if debuffIcons[i]["expirationTime"]>0 then
                UnitDebuffIcons[debuffIcons[i]["name"]].nextUpdate=floor(TimeNow-2) + debuffIcons[i]["expirationTime"]%3 + 0.002
            else
                UnitDebuffIcons[debuffIcons[i]["name"]].nextUpdate=TimeNow+1000000
                HealBot_UpdateIcon(button, debuffIcons[i])
            end
        end
    end
    for dName,_ in pairs(UnitDebuffIcons) do
        if not UnitDebuffIcons[dName].current and UnitDebuffIcons[dName].index>0 then
            UnitDebuffIcons[dName].index=0
            UnitDebuffIcons[dName].nextUpdate=TimeNow+1000000
        end
    end
  --HealBot_setCall("HealBot_CheckUnitDebuffIcons")
end

local function HealBot_CheckUnitDebuffIconsExtras(button)
    HealBot_luVars["prevIconCount"]=button.icon.debuff.count
    button.icon.debuff.count=0
    TimeNow=GetTime()
    HealBot_CheckUnitDebuffIcons(button)
  --HealBot_setCall("HealBot_CheckUnitDebuffIcons")
end

local function HealBot_CheckUnitDebuffs(button)
    local spellCD=0
    TimeNow=GetTime()
    if not button or not UnitExists(button.unit) then return end
    _,DebuffClass=UnitClass(button.unit)
    if not DebuffClass then DebuffClass=HealBot_Class_En[HEALBOT_WARRIOR] end

    prevDebuff["name"]=button.aura.debuff.name or "x"
    prevDebuff["type"]=button.aura.debuff.type or "x"
    button.aura.debuff.type=false
    button.aura.debuff.priority=99
    for x,_ in pairs(curDebuffs) do
        curDebuffs[x].current=false;
    end
    if not UnitIsDeadOrGhost(button.unit) or UnitIsFeignDeath(button.unit) then
        local z=1
        while true do
            local name, texture, count, debuffType, duration, expirationTime, unitCaster, _, _, spellId, _, isBossDebuff = UnitDebuff(button.unit,z)
            if name then
                z = z +1
                if curDebuffs[name] and curDebuffs[name]["always"] and (curDebuffs[name]["type"]==HEALBOT_CUSTOM_en or HealBot_luVars["MaskAuraDCheck"]<TimeNow) then
                    curDebuffs[name]["bCount"]=count
                    curDebuffs[name]["expirationTime"]=expirationTime
                    curDebuffs[name]["current"]=true
                else
                    HealBot_addCurDebuffs(name, texture, count, debuffType, duration, expirationTime, spellId, unitCaster, isBossDebuff, button)
                end
            else
                break
            end 
        end
        z=1
        while true do
            local name, texture, count, debuffType, duration, expirationTime, unitCaster, _, _, spellId, _, isBossDebuff = UnitBuff(button.unit,z)
            if name then
                z = z +1
                if HealBot_Globals.HealBot_Custom_Debuffs[name] then 
                    if curDebuffs[name] and curDebuffs[name]["always"] then
                        curDebuffs[name]["bCount"]=count
                        curDebuffs[name]["expirationTime"]=expirationTime
                        curDebuffs[name]["current"]=true
                    else
                        HealBot_addCurDebuffs(name, texture, count, debuffType, duration, expirationTime, spellId, unitCaster, isBossDebuff, button)
                    end
                end
            else
                break
            end 
        end
        for dName,_ in pairs(HealBot_CustomDebuff_RevDurLast) do
            if not curDebuffs[dName] and HealBot_CustomDebuff_RevDurLast[dName][button.unit] then HealBot_CustomDebuff_RevDurLast[dName][button.unit]=nil end
        end
    end
    
    local dPrio = 99    
    HealBot_luVars["prevIconCount"]=button.icon.debuff.count
    button.icon.debuff.count=0
    
    for dName,_ in pairs(curDebuffs) do
        if curDebuffs[dName]["current"] then
            if curDebuffs[dName]["priority"]<dPrio then
                button.aura.debuff.type=curDebuffs[dName]["type"]
                button.aura.debuff.name=dName
                button.aura.debuff.priority=curDebuffs[dName]["priority"]
                dPrio=curDebuffs[dName]["priority"]
            end
            if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWDEBUFF"] and (HealBot_Data["PGUID"]==button.guid or UnitIsVisible(button.unit)) and curDebuffs[dName]["texture"] then
                local iconset=false
                if button.icon.debuff.count>0 then
                    for x=1, button.icon.debuff.count do
                        if debuffIcons[x]["priority"]>curDebuffs[dName]["priority"] then
                            if x<Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["MAXDICONS"] then 
                                HealBot_BumpDebuffIcon(button,x) 
                                button.icon.debuff.count=button.icon.debuff.count+1
                            end
                            HealBot_SetDebuffIcon(button, x, dName)
                            iconset=true
                            break
                        end
                    end
                end
                if not iconset and button.icon.debuff.count < Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["MAXDICONS"] then
                    button.icon.debuff.count=button.icon.debuff.count+1
                    HealBot_SetDebuffIcon(button, button.icon.debuff.count, dName)
                end
            end
        end
    end
    HealBot_CheckUnitDebuffIcons(button)

    if not button.aura.debuff.type then 
        HealBot_ClearDebuff(button)
        if HealBot_Config_Cures.IgnoreOnCooldownDebuffs and prevDebuff["type"]~="x" and prevDebuff["type"]~=HEALBOT_CUSTOM_en and HealBot_luVars["MaskAuraDCheck"]<TimeNow and spellCD==0 then 
            spellCD=HealBot_Options_retDebuffWatchTargetCD(prevDebuff["type"])
        end
    end
 
    if spellCD>1.5 and spellCD<12 then 
        local nCheck=(TimeNow+spellCD)-0.1
        HealBot_luVars["MaskAuraDCheck"]=nCheck
        HealBot_luVars["MaskAuraReCheck"]=true
        for _,dButton in pairs(HealBot_Unit_Button) do
            if dButton.unit~=button.unit and dButton.aura.debuff.type and dButton.aura.debuff.type~=HEALBOT_CUSTOM_en then
                dButton.aura.debuff.check=true
            end
        end
        for _,dButton in pairs(HealBot_Pet_Button) do
            if dButton.unit~=button.unit and dButton.aura.debuff.type and dButton.aura.debuff.type~=HEALBOT_CUSTOM_en then
                dButton.aura.debuff.check=true
            end
        end
    end
    
    if button.aura.debuff.name then
        if button.aura.debuff.name~=prevDebuff["name"] or button.aura.debuff.type~=prevDebuff["type"] then
            HealBot_UpdateUnitRange(button,HealBot_Action_dSpell(),false)
            if HealBot_Config_Cures.CDCshownAB and (HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[button.aura.debuff.name]==nil) then
                if button.status.range>(HealBot_Config_Cures.HealBot_CDCWarnRange_Aggro-3) then
                    HealBot_Action_UpdateAggro(button.unit,"debuff",debuffCodes[button.aura.debuff.type], 0)
                end
            end
            if HealBot_Config_Cures.ShowDebuffWarning and button.status.range>(HealBot_Config_Cures.HealBot_CDCWarnRange_Screen-3) then
                if HealBot_Globals.CDCBarColour[button.aura.debuff.name] then
                    UIErrorsFrame:AddMessage(HealBot_GetUnitName(button.unit, button.guid).." suffers from "..button.aura.debuff.name, 
                                             HealBot_Globals.CDCBarColour[button.aura.debuff.name].R,
                                             HealBot_Globals.CDCBarColour[button.aura.debuff.name].G,
                                             HealBot_Globals.CDCBarColour[button.aura.debuff.name].B,
                                             1, UIERRORS_HOLD_TIME);
                elseif button.aura.debuff.type == HEALBOT_CUSTOM_en then
                    local customDebuffPriority=HEALBOT_CUSTOM_en.."10"
                    if HealBot_GlobalsDefaults.HealBot_Custom_Debuffs[button.aura.debuff.name] then
                        customDebuffPriority=HEALBOT_CUSTOM_en..HealBot_GlobalsDefaults.HealBot_Custom_Debuffs[button.aura.debuff.name]
                    end
                    UIErrorsFrame:AddMessage(HealBot_GetUnitName(button.unit, button.guid).." suffers from "..button.aura.debuff.name,                                             
                                             HealBot_Globals.CDCBarColour[customDebuffPriority].R,
                                             HealBot_Globals.CDCBarColour[customDebuffPriority].G,
                                             HealBot_Globals.CDCBarColour[customDebuffPriority].B,
                                             1, UIERRORS_HOLD_TIME);
                else
                    UIErrorsFrame:AddMessage(HealBot_GetUnitName(button.unit, button.guid).." suffers from "..button.aura.debuff.name, 
                                             HealBot_Config_Cures.CDCBarColour[button.aura.debuff.type].R,
                                             HealBot_Config_Cures.CDCBarColour[button.aura.debuff.type].G,
                                             HealBot_Config_Cures.CDCBarColour[button.aura.debuff.type].B,
                                             1, UIERRORS_HOLD_TIME);
                end
            end
            if HealBot_Config_Cures.SoundDebuffWarning and button.status.range>(HealBot_Config_Cures.HealBot_CDCWarnRange_Sound-3) then
                HealBot_PlaySound(HealBot_Config_Cures.SoundDebuffPlay)
            end
            HealBot_Action_UpdateDebuffButton(button)
        end
        HealBot_OnEvent_UnitThreat(button)
    end
  --HealBot_setCall("HealBot_CheckUnitDebuffs")
end

local function HealBot_doAuraDebuffUnit(button)
    if HealBot_luVars["DebuffCheck"] and (HealBot_Config_Cures.DebuffWatchInCombat or not HealBot_Data["UILOCK"]) then
        if UnitIsFriend("player",button.unit) then
            HealBot_CheckUnitDebuffs(button)
        else
            HealBot_CheckUnitDebuffIconsExtras(button)
        end
    else
        HealBot_CheckUnitDebuffIconsExtras(button)
    end
  --HealBot_setCall("HealBot_doAuraDebuffUnit")
end

local function HealBot_SetUnitBuffTimer(hbGUID,buffName,endtime)
    if not HealBot_PlayerBuff[hbGUID] then
        HealBot_PlayerBuff[hbGUID]={}
    end
    if HealBot_ShortBuffs[buffName] then 
        HealBot_PlayerBuff[hbGUID][buffName] = endtime-HealBot_Config_Buffs.ShortBuffTimer
    else
        HealBot_PlayerBuff[hbGUID][buffName] = endtime-HealBot_Config_Buffs.LongBuffTimer
    end
    if not HealBot_luVars["CheckPlayerBuffsTime"] or HealBot_PlayerBuff[hbGUID][buffName] < HealBot_luVars["CheckPlayerBuffsTime"] then
        HealBot_luVars["CheckPlayerBuffsTime"]=HealBot_PlayerBuff[hbGUID][buffName]
        HealBot_luVars["CheckPlayerBuffsGUID"]=hbGUID
    end
  --HealBot_setCall("HealBot_SetUnitBuffTimer")
end

local function HealBot_HasBuffTypes(spellName, pBuffTypes)
    local hasBuffTypes = false
    if (HealBot_BuffNameTypes[spellName]) then
        local index = 0
        local name = nil
        local found = false
        for _,v in pairs(HealBot_BuffNameTypes[spellName]) do
            index = index + 1
            if (pBuffTypes[v]) then
                found = true
            else
                found = false
            end
            --print("v:"..v.." found:"..tostring(found))
            if index == 1 then
                hasBuffTypes = found
            else
                hasBuffTypes = hasBuffTypes and found
            end
        end
    end
  --HealBot_setCall("HealBot_HasBuffTypes")
    return hasBuffTypes
end

local function HealBot_CheckUnitBuffs(button)
    local xGUID=button.guid
    local xUnit=button.unit   
    if not xUnit or not UnitExists(xUnit) then return end
    local cBuffs=false
    local cIcons=false
    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWBUFF"] then 
        cIcons=true
    end
    if HealBot_Config_Buffs.BuffWatch and UnitIsPlayer(xUnit) and (HealBot_Config_Buffs.BuffWatchInCombat or not HealBot_Data["UILOCK"]) then
        cBuffs=true
    end
    
    local prevIconCount = button.icon.buff.count
    if cIcons then 
        button.icon.buff.count=0
        UnitBuffIcons=HealBot_UnitBuffIcons[button.unit]
        for dName,_ in pairs(UnitBuffIcons) do
            UnitBuffIcons[dName].current=false
        end
    end
    TimeNow=GetTime()
    local _,BuffClass=UnitClass(xUnit)
    if not BuffClass then BuffClass=HealBot_Class_En[HEALBOT_WARRIOR] end   
    local bName=nil;
    if cBuffs then 
        for x,_ in pairs(PlayerBuffs) do
            PlayerBuffs[x]=nil;
        end
        for x,_ in pairs(PlayerBuffTypes) do
            PlayerBuffTypes[x]=nil;
        end
    end
    
    local z=1
    if not UnitIsFriend("player",button.unit) and cIcons then 
        while true do
            local name, texture, count, _, _, expirationTime, unitCaster, _, _, spellId, _, _ = UnitDebuff(button.unit, z); 
            if name then
                z=z+1
                if unitCaster and unitCaster=="player" and expirationTime and not hbExcludeSpells[spellID] then
                    HealBot_SetBuffIcon(button, UnitBuffIcons, name, texture, count, expirationTime, unitCaster)
                end
            else
                break
            end
        end
    else
        while true do
            local name, texture, count, _, _, expirationTime, unitCaster, _, _, spellId, _, _ = UnitBuff(button.unit,z)
            if name then
                z = z +1
                if cIcons then 
                    if unitCaster and expirationTime and not hbExcludeSpells[spellID] then
                        local y=HealBot_Watch_HoT[name] or "nil"
                        if (y=="A" or (y=="S" and unitCaster=="player") or (y=="C" and HealBot_Data["PCLASSTRIM"]==uClassTrim)) then
                            HealBot_SetBuffIcon(button, UnitBuffIcons, name, texture, count, expirationTime, unitCaster)
                        end
                    end
                end
                if cBuffs then
                    local buffName=HealBot_Buff_Aura2Item[name] or name
                    if (HealBot_BuffNameTypes[buffName]) then
                        for _,v in pairs(HealBot_BuffNameTypes[buffName]) do
                            PlayerBuffTypes[v]=true
                        end
                    end
                    if not hbExcludeBuffSpells[spellId] then
                        PlayerBuffs[buffName]=true
                        if HealBot_CheckBuffs[buffName] then
                            if expirationTime-TimeNow>0 then
                                HealBot_SetUnitBuffTimer(xGUID,buffName,expirationTime)
                            elseif HealBot_PlayerBuff[xGUID] and HealBot_PlayerBuff[xGUID][buffName] then
                                if HealBot_PlayerBuff[xGUID][buffName]==HealBot_luVars["CheckPlayerBuffsTime"] then
                                    HealBot_PlayerBuff[xGUID][buffName]=nil
                                    HealBot_luVars["ResetCheckBuffsTime"]=true
                                    HealBot_luVars["Checks"]=true
                                else
                                    HealBot_PlayerBuff[xGUID][buffName]=nil
                                end
                            end
                        end
                    end
                end
            else
                break
            end 
        end
    end
    
    if cIcons then 
        if button.icon.buff.count<prevIconCount then 
            for i = prevIconCount, button.icon.buff.count+1, -1 do
                HealBot_RemoveIcon(button, i)
            end
        end    
        for bName,_ in pairs(UnitBuffIcons) do
            if not UnitBuffIcons[bName].current and UnitBuffIcons[bName].index>0 then
                UnitBuffIcons[bName].index=0
                UnitBuffIcons[bName].nextUpdate=TimeNow+1000000
            end
        end  
    end

    if cBuffs then
        if HealBot_PlayerBuff[xGUID] then
            local PlayerBuffsGUID=HealBot_PlayerBuff[xGUID]
            for z,_ in pairs (PlayerBuffsGUID) do
                if not PlayerBuffs[z] then
                    if PlayerBuffsGUID[z]==HealBot_luVars["CheckPlayerBuffsTime"] then
                        PlayerBuffsGUID[z]=nil
                        HealBot_luVars["ResetCheckBuffsTime"]=true
                        HealBot_luVars["Checks"]=true
                    else
                        PlayerBuffsGUID[z]=nil
                    end
                end
            end
            for x,_ in pairs(PlayerBuffs) do
                if HealBot_PlayerBuff[xGUID][x] and HealBot_PlayerBuff[xGUID][x] < TimeNow then
                    PlayerBuffs[x]=nil
                end
            end
        end

        for k in pairs(HealBot_BuffWatch) do
            if not PlayerBuffs[HealBot_BuffWatch[k]] then
                local checkthis=false;
                local WatchTarget, WatchGUID=HealBot_Options_retBuffWatchTarget(HealBot_BuffWatch[k], xGUID);
                local z, x = nil, nil
                if HealBot_GetSpellId(HealBot_BuffWatch[k]) then
                    z, x = GetSpellCooldown(HealBot_BuffWatch[k]);
                elseif UnitIsUnit("player",xUnit) and HealBot_Buff_ItemID[HealBot_BuffWatch[k]] then
                    local getCD = false
                    if HealBot_BuffWatch[k]~=HEALBOT_EVER_BLOOMING_FROND then
                        getCD = true
                    elseif not IsInRaid() and not UnitAffectingCombat("player") then
                        getCD = true
                        local mPct, hPct = 100, 100
                        if button.mana.max>1000 then
                            mPct=floor((button.mana.current/button.mana.max)*100)
                        end
                        if button.health.current>button.health.max and button.health.max>1000 then
                            hPct=floor((button.health.current/button.health.max)*100)
                        end
                        if mPct>HealBot_Globals.minManaBloom and hPct>HealBot_Globals.minHealthBloom then
                            getCD=false
                        else
                            local mCheck=TimeNow+1
                            if not HealBot_ReCheckBuffsTime or HealBot_ReCheckBuffsTime>mCheck then
                                HealBot_ReCheckBuffsTime=mCheck
                                HealBot_ReCheckBuffsTimed[HealBot_ReCheckBuffsTime]=xGUID
                            elseif HealBot_ReCheckBuffsTime<mCheck then
                                HealBot_ReCheckBuffsTimed[mCheck]=xGUID
                            end
                        end
                    end
                    if getCD then
                        z, x = GetItemCooldown(HealBot_Buff_ItemID[HealBot_BuffWatch[k]]) -- Using the name returns errors
                    end
                end
                if not x then
                    -- Spec change within that last few secs - buff outdated so do nothing
                elseif x<2 then
                    if hbStanceBuffs[HealBot_BuffWatch[k]] then
                        local index = GetShapeshiftForm() or 0
                        if hbStanceBuffs[HealBot_BuffWatch[k]]~=index then checkthis=true end
                    elseif WatchTarget["Raid"] then
                        checkthis=true;
                    elseif WatchTarget["Party"] then 
                        if (UnitInParty(xUnit) or xGUID==HealBot_Data["PGUID"]) then checkthis=true; end
                    elseif WatchTarget["Self"] then
                        if xGUID==HealBot_Data["PGUID"] then checkthis=true end
                    elseif WatchTarget[strsub(BuffClass,1,4)] then
                        checkthis=true
                    elseif WatchTarget["PvP"] then
                        if UnitIsPVP(xUnit) then checkthis=true; end
                    elseif WatchTarget["PvE"] then
                        if not UnitIsPVP(xUnit) then checkthis=true; end
                    elseif WatchTarget["Name"] then
                        if xGUID==WatchGUID then checkthis=true; end
                    elseif WatchTarget["Focus"] then
                        if UnitIsUnit(xUnit, "focus") then checkthis=true; end
                    elseif WatchTarget["MainTanks"] and HealBot_Panel_IsTank(xGUID) then
                        checkthis=true;
                    elseif WatchTarget["SingleTank"] then
                        if UnitIsUnit(xUnit, HealBot_luVars["TankUnit"]) then checkthis=true; end
                    elseif WatchTarget["MyTargets"] then
                        local myhTargets=HealBot_GetMyHealTargets();
                        for i=1, #myhTargets do
                            if xGUID==myhTargets[i] then
                                checkthis=true;
                                break;
                            end
                        end
                    end
                elseif not HealBot_ReCheckBuffsTime or HealBot_ReCheckBuffsTime>z+x then
                    HealBot_ReCheckBuffsTime=z+x
                    HealBot_ReCheckBuffsTimed[HealBot_ReCheckBuffsTime]=xGUID
                elseif HealBot_ReCheckBuffsTime<z+x then
                    HealBot_ReCheckBuffsTimed[z+x]=xGUID
                end
                if checkthis then
                    if HealBot_HasBuffTypes(HealBot_BuffWatch[k], PlayerBuffTypes) then
                        altActive=true
                    else
                        bName=HealBot_BuffWatch[k];
                        break
                    end
                end
            end
        end
        if bName then
            if button.aura.buff.name~=bName then
                button.aura.buff.name=bName;
                HealBot_Action_UpdateBuffButton(button)
            end
        elseif button.aura.buff.name then 
            HealBot_ClearBuff(button)
        end 
    end
  --HealBot_setCall("HealBot_CheckUnitBuffs")
end

local function HealBot_doAuraBuff(button)
    if UnitExists(button.unit) then 
        HealBot_CheckUnitBuffs(button)
    end
  --HealBot_setCall("HealBot_doAuraBuff")
end

function HealBot_CheckAggroUnits(button)
    if UnitExists(button.unit) then
        local z, y=HealBot_CalcThreat(button.unit)
        local x=y+z
        if x==0 then
            HealBot_ClearUnitAggro(button)
        elseif z~=button.aggro.threatpct then
            HealBot_Action_UpdateAggro(button.unit,true,y,z)
        end
    else
        HealBot_ClearUnitAggro(button)
    end
  --HealBot_setCall("HealBot_CheckAggroUnits")
end

local function HealBot_Update_UnitIcons(button)
    UnitBuffIcons=HealBot_UnitBuffIcons[button.unit]
    for name,_ in pairs(UnitBuffIcons) do
        if UnitBuffIcons[name].nextUpdate<TimeNow then
            if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["FADE"] then
                UnitBuffIcons[name].nextUpdate=UnitBuffIcons[name].nextUpdate+0.2
            else
                UnitBuffIcons[name].nextUpdate=UnitBuffIcons[name].nextUpdate+1
            end
            HealBot_UpdateIcon(button, UnitBuffIcons[name])
        end
    end
    UnitDebuffIcons=HealBot_UnitDebuffIcons[button.unit]
    for name,_ in pairs(UnitDebuffIcons) do
        if UnitDebuffIcons[name].nextUpdate<TimeNow then
            if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["FADE"] then
                UnitDebuffIcons[name].nextUpdate=UnitDebuffIcons[name].nextUpdate+0.2
            else
                UnitDebuffIcons[name].nextUpdate=UnitDebuffIcons[name].nextUpdate+1
            end
            HealBot_UpdateIcon(button, UnitDebuffIcons[name])
        end
    end
end

local function HealBot_UnitUpdateHealth(button)
    if button.health.update then
        button.health.update=false
        if button.health.updhealth then
            HealBot_OnEvent_UnitHealth(button)
        end
        if button.health.updincoming then
            HealBot_HealsInUpdate(button)
        end
        if button.health.updabsorbs then
            HealBot_AbsorbsUpdate(button)
        end
    end
end

local function HealBot_UnitUpdateFriendly(button)
    if button.checks.range < TimeNow then
        if button.status.unittype>1 and button.status.unittype<4 then
            HealBot_PetRange_CheckTime(button)
        else
            HealBot_Range_CheckTime(button)
        end
        if button.status.update then
            if button.update.reset then
                button.update.reset=false
                HealBot_UpdateUnitReset(button)
                button.update.unit=true
            elseif button.update.unit then
                button.update.unit=false
                HealBot_UpdateUnit(button)
            elseif button.update.state then
                button.update.state=false
                HealBot_RecalcHeals(button)
            else
                button.status.update=false
            end
            if button.update.roleicon then
                button.update.roleicon=false
                HealBot_Action_SetClassIconTexture(button)
            end
            if button.update.targeticon then
                button.update.targeticon=false
                HealBot_OnEvent_RaidTargetUpdate(button)
            end
        else
            if button.aggro.threatpct > 0 then 
                HealBot_CheckAggroUnits(button) 
            elseif button.status.current==9 then 
                HealBot_Action_UpdateTheDeadButton(button)
            end
        end
        if not UnitIsUnit("player",button.unit) and (button.status.current>0 or button.status.range<1 or not UnitInRange(button.unit)) then
            HealBot_UpdateUnitRange(button, button.spells.rangecheck, true)
        end
    elseif button.checks.other < TimeNow then
        if button.status.unittype<2 or button.status.unittype>3 then
            HealBot_Other_CheckTime(button)
            if button.status.dirarrow<99998 or (not IsInInstance() and button.status.range<1) then
                HealBot_Action_ShowDirectionArrow(button)
            end
            if button.status.offline and UnitIsConnected(button.unit) then
                button.status.offline = false
                HealBot_Action_setNameTag(button)
                button.update.state=true
                button.status.update=true                      
            elseif not button.status.offline and not UnitIsConnected(button.unit) then
                button.status.offline = TimeNow
                HealBot_Action_setNameTag(button)
                button.update.state=true
                button.status.update=true
            elseif button.health.current==0 and button.status.current<9 then
                button.health.updhealth=true
                button.health.update=true
            end
        end
    else
        HealBot_Update_UnitIcons(button)
    end
end

local function HealBot_UnitUpdateCheckDebuff(button)
    if button.aura.debuff.check then
        button.aura.debuff.check=false
        HealBot_doAuraDebuffUnit(button) 
    else
        HealBot_UnitUpdateFriendly(button)
    end
end

local function HealBot_UnitUpdateCheckBuff(button)
    if button.aura.buff.check then
        button.aura.buff.check=false
        HealBot_doAuraBuff(button)
    else
        HealBot_UnitUpdateFriendly(button)
    end
end

local function HealBot_UnitUpdateEnemy(button)
    if button.checks.other < TimeNow then
        HealBot_Enemy_CheckTime(button)
        if UnitIsDeadOrGhost(button.unit) then
            button.health.current=0
            HealBot_RecalcHeals(button)
        else
            local xGUID=UnitGUID(button.unit) or button.unit
            if xGUID~=button.guid then
                if HealBot_UnitData[xGUID] then
                    HealBot_UnitData[xGUID]["UNIT"]=button.unit
                end
                button.guid=xGUID
                HealBot_UpdateUnit(button)
            else
                local name, _, _, startTime, endTime, _, _, notInterruptible = UnitCastingInfo(button.unit) 
                if name and Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][10]["POWERSIZE"]>0 then
                    if TimeNow+0.01>endTime and button.spells.castpct>-1 then
                        button.spells.castpct=-1
                        HealBot_Action_SetBar3Value(button)
                    else
                        local l=endTime-startTime
                        local c=((TimeNow*1000)-startTime)
                        local pct=ceil((c/l)*100)
                        if button.spells.castpct~=pct then
                            button.spells.castpct=pct
                            HealBot_Action_SetBar3Value(button, name)
                        end
                    end
                elseif button.spells.castpct>-1 then
                    button.spells.castpct = -1
                    HealBot_Action_SetBar3Value(button)
                end
                button.health.updhealth=true
                button.health.updincoming=true
                button.health.updabsorbs=true
                button.health.update=true
                HealBot_doAuraBuff(button)
                --HealBot_Update_UnitIcons(button)
            end
        end
    end
end

local function HealBot_Update_Fast()
    HealBot_luVars["fastSwitch"]=HealBot_luVars["fastSwitch"]+1
    if HealBot_luVars["fastSwitch"]<2 then
        for xUnit,xButton in pairs(HealBot_Unit_Button) do
            if not xButton.status.reserved then
                if UnitExists(xUnit) then
                    if (xButton.id % 2 == 0) then
                        HealBot_UnitUpdateCheckDebuff(xButton)
                    else
                        HealBot_UnitUpdateCheckBuff(xButton)
                    end
                else
                    HealBot_UpdateUnitReset(xButton)
                    HealBot_UpdateUnit(xButton)
                    xButton.status.reserved=true
                end
            elseif UnitExists(xUnit) then
                xButton.status.reserved=false
                xButton.update.unit=true
                xButton.status.update=true
            end
        end
    elseif HealBot_luVars["fastSwitch"]<3 then
        for xUnit,xButton in pairs(HealBot_Unit_Button) do
            if not xButton.status.reserved then
                if UnitExists(xUnit) then
                    if not (xButton.id % 2 == 0) then
                        HealBot_UnitUpdateCheckDebuff(xButton)
                    else
                        HealBot_UnitUpdateCheckBuff(xButton)
                    end
                else
                    HealBot_UpdateUnitReset(xButton)
                    HealBot_UpdateUnit(xButton)
                    xButton.status.reserved=true
                end
            elseif UnitExists(xUnit) then
                xButton.status.reserved=false
                xButton.update.unit=true
                xButton.status.update=true
            end
        end
    elseif HealBot_luVars["fastSwitch"]<4 then
        for xUnit,xButton in pairs(HealBot_Enemy_Button) do
            if not xButton.status.reserved then
                if UnitExists(xUnit) then
                    HealBot_UnitUpdateHealth(xButton)
                    HealBot_UnitUpdateEnemy(xButton)
                else
                    HealBot_UpdateUnitReset(xButton)
                    HealBot_UpdateUnit(xButton)
                    xButton.status.reserved=true
                end
            elseif UnitExists(xUnit) then
                xButton.status.reserved=false
                HealBot_UpdateUnit(xButton)
            end
        end
    elseif HealBot_luVars["fastSwitch"]<5 then
        for xUnit,xButton in pairs(HealBot_Unit_Button) do
            if not xButton.status.reserved then
                if UnitExists(xUnit) then
                    if (xButton.id % 2 == 0) then
                        HealBot_UnitUpdateCheckBuff(xButton)
                    else
                        HealBot_UnitUpdateCheckDebuff(xButton)
                    end
                else
                    HealBot_UpdateUnitReset(xButton)
                    HealBot_UpdateUnit(xButton)
                    xButton.status.reserved=true
                end
            elseif UnitExists(xUnit) then
                xButton.status.reserved=false
                xButton.update.unit=true
                xButton.status.update=true
            end
        end
    elseif HealBot_luVars["fastSwitch"]<6 then
        for xUnit,xButton in pairs(HealBot_Unit_Button) do
            if not xButton.status.reserved then
                if UnitExists(xUnit) then
                    if not (xButton.id % 2 == 0) then
                        HealBot_UnitUpdateCheckBuff(xButton)
                    else
                        HealBot_UnitUpdateCheckDebuff(xButton)
                    end
                else
                    HealBot_UpdateUnitReset(xButton)
                    HealBot_UpdateUnit(xButton)
                    xButton.status.reserved=true
                end
            elseif UnitExists(xUnit) then
                xButton.status.reserved=false
                xButton.update.unit=true
                xButton.status.update=true
            end
        end
    elseif HealBot_luVars["fastSwitch"]<7 then
        for xUnit,xButton in pairs(HealBot_Pet_Button) do
            if not xButton.status.reserved then
                if UnitExists(xUnit) then
                    if xButton.aura.debuff.check then
                        xButton.aura.debuff.check=false
                        HealBot_doAuraDebuffUnit(xButton) 
                    elseif xButton.aura.buff.check then
                        xButton.aura.buff.check=false
                        HealBot_doAuraBuff(xButton)
                    elseif xButton.health.update then
                        HealBot_UnitUpdateHealth(xButton)
                    else
                        HealBot_UnitUpdateFriendly(xButton)
                    end
                else
                    HealBot_UpdateUnitReset(xButton)
                    HealBot_UpdateUnit(xButton)
                    xButton.status.reserved=true
                    if xButton.status.unittype==2 and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["STATE"] then
                        HealBot_nextRecalcParty(1)
                    elseif xButton.status.unittype==3 and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["STATE"] then
                        HealBot_nextRecalcParty(2)
                    end
                end
            elseif UnitExists(xUnit) then
                xButton.status.reserved=false
                xButton.update.unit=true
                xButton.status.update=true
            end
        end
    elseif HealBot_luVars["fastSwitch"]<8 then
        for xUnit,xButton in pairs(HealBot_Unit_Button) do
            if not xButton.status.reserved then
                if UnitExists(xUnit) then
                    if (xButton.id % 2 == 0) then
                        HealBot_UnitUpdateHealth(xButton)
                    else
                        HealBot_UnitUpdateFriendly(xButton)
                    end
                else
                    HealBot_UpdateUnitReset(xButton)
                    HealBot_UpdateUnit(xButton)
                    xButton.status.reserved=true
                end
            elseif UnitExists(xUnit) then
                xButton.status.reserved=false
                xButton.update.unit=true
                xButton.status.update=true
            end
        end
    elseif HealBot_luVars["fastSwitch"]<9 then
        for xUnit,xButton in pairs(HealBot_Unit_Button) do
            if not xButton.status.reserved then
                if UnitExists(xUnit) then
                    if not (xButton.id % 2 == 0) then
                        HealBot_UnitUpdateHealth(xButton)
                    else
                        HealBot_UnitUpdateFriendly(xButton)
                    end
                else
                    HealBot_UpdateUnitReset(xButton)
                    HealBot_UpdateUnit(xButton)
                    xButton.status.reserved=true
                end
            elseif UnitExists(xUnit) then
                xButton.status.reserved=false
                xButton.update.unit=true
                xButton.status.update=true
            end
        end
    else
        if HealBot_Data["TIPUSE"] and HealBot_Globals.TooltipUpdate and HealBot_Data["TIPUNIT"] then HealBot_Action_RefreshTooltip() end
        if HealBot_luVars["MaskAuraDCheck"]<TimeNow and HealBot_luVars["MaskAuraReCheck"] then
            HealBot_luVars["MaskAuraReCheck"]=nil
            HealBot_CheckAllDebuffs()
        end
        HealBot_luVars["fastSwitch"]=0
    end
    --HealBot_setCall("HealBot_Update_Fast")
end

local lTimer,eTimer=0,GetTime()
function HealBot_OnUpdate(self)
    if HealBot_luVars["hbLoaded"] and not HealBot_Data["UNITSLOCK"] then
        TimeNow=GetTime()
        lTimer=TimeNow-eTimer
        eTimer=TimeNow
        HealBot_Timers["HB1Inc"] = HealBot_Timers["HB1Inc"]+lTimer;
        HealBot_Timers["HB2Inc"] = HealBot_Timers["HB2Inc"]+lTimer;
        HealBot_Timers["HBaInc"] = HealBot_Timers["HBaInc"]+lTimer;
        if HealBot_Data["PGUID"] and HealBot_Timers["HB1Inc"]>=HealBot_Timers["HB1Th"] then
            HealBot_Timers["HB1Inc"] = 0;
            HealBot_Update_Slow()
        end
        if not HealBot_Panel_retTestBars() then
            if HealBot_Timers["HB2Inc"]>HealBot_Timers["HB2Th"] then
                HealBot_Timers["HB2Inc"]=0
                HealBot_Update_Fast()
            end
            if HealBot_Timers["HBaInc"]>HealBot_Timers["HBaTh"] then
                HealBot_Timers["HBaInc"]=0
                HealBot_Action_UpdateBars()
            end
        end
    end
    --HealBot_setCall("HealBot_OnUpdate")
end

function HealBot_useCrashProtection()
    local y,z = GetNumMacros()
    local maxMacroSlots=18
    if Healbot_Config_Skins.Protection[Healbot_Config_Skins.Current_Skin]["GENERALMACRO"] then
        maxMacroSlots=100
        z=y
    end
    local x=maxMacroSlots-z
    if Healbot_Config_Skins.Protection[Healbot_Config_Skins.Current_Skin]["CRASH"] then
        for z=0,5 do
            local w=GetMacroBody(HealBot_Config.CrashProtMacroName.."_"..z)
            if w then
                x=x+1
            end
        end
    end
    if x<5 then
        Healbot_Config_Skins.Protection[Healbot_Config_Skins.Current_Skin]["CRASH"]=false
        HealBot_Options_CrashProt:SetChecked(Healbot_Config_Skins.Protection[Healbot_Config_Skins.Current_Skin]["CRASH"])
        HealBot_Options_CrashProt:Disable();
    else
        HealBot_Options_CrashProt:Enable();
    end
  --HealBot_setCall("HealBot_useCrashProtection")
end

function HealBot_Register_Aggro()
    HealBot:RegisterEvent("UNIT_COMBAT")
    HealBot:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE")
    HealBot:RegisterEvent("UNIT_THREAT_LIST_UPDATE")
  --HealBot_setCall("HealBot_Register_Aggro")
end

function HealBot_UnRegister_Aggro()
    HealBot:UnregisterEvent("UNIT_COMBAT")
    HealBot:UnregisterEvent("UNIT_THREAT_SITUATION_UPDATE")
    HealBot:UnregisterEvent("UNIT_THREAT_LIST_UPDATE")
    HealBot_EndAggro() 
  --HealBot_setCall("HealBot_UnRegister_Aggro")
end

function HealBot_Register_IncHeals()
    HealBot:RegisterEvent("UNIT_HEAL_PREDICTION")
  --HealBot_setCall("HealBot_Register_IncHeals")
end

function HealBot_UnRegister_IncHeals()
    HealBot:UnregisterEvent("UNIT_HEAL_PREDICTION")
    HealBot_IncHeals_ClearAll()
  --HealBot_setCall("HealBot_UnRegister_IncHeals")
end


function HealBot_Register_ReadyCheck()
    HealBot:RegisterEvent("READY_CHECK")
    HealBot:RegisterEvent("READY_CHECK_CONFIRM")
    HealBot:RegisterEvent("READY_CHECK_FINISHED")
  --HealBot_setCall("HealBot_Register_ReadyCheck")
end

function HealBot_UnRegister_ReadyCheck()
    HealBot:UnregisterEvent("READY_CHECK")
    HealBot:UnregisterEvent("READY_CHECK_CONFIRM")
    HealBot:UnregisterEvent("READY_CHECK_FINISHED")
    HealBot_luVars["rcEnd"]=GetTime()
  --HealBot_setCall("HealBot_UnRegister_ReadyCheck")
end

function HealBot_Register_Mana()
    HealBot:RegisterEvent("UNIT_POWER_UPDATE")
    HealBot:RegisterEvent("UNIT_MAXPOWER")
  --HealBot_setCall("HealBot_Register_Mana")
end

function HealBot_UnRegister_Mana()
    HealBot:UnregisterEvent("UNIT_POWER_UPDATE")
    HealBot:UnregisterEvent("UNIT_MAXPOWER")
  --HealBot_setCall("HealBot_UnRegister_Mana")
end

function HealBot_SetTankUnit(unit)
    if not UnitExists(HealBot_luVars["TankUnit"]) or (not UnitIsUnit(unit, HealBot_luVars["TankUnit"]) and UnitGroupRolesAssigned(HealBot_luVars["TankUnit"])~="TANK") then
        HealBot_luVars["TankUnit"]=unit
    end
  --HealBot_setCall("HealBot_SetTankUnit")
end

function HealBot_CalcThreat(unit)
    local z,y=0,0
    if UnitExists(unit.."target") and UnitIsEnemy(unit, unit.."target") and UnitHealth(unit.."target")>1 then 
        _, _, z, _, _ = UnitDetailedThreatSituation(unit, unit.."target")
        z=floor(z or 0)
        y = UnitThreatSituation(unit, unit.."target")
    elseif UnitExists(HealBot_luVars["TankUnit"]) and UnitExists(HealBot_luVars["TankUnit"].."target") and 
           UnitIsEnemy(HealBot_luVars["TankUnit"], HealBot_luVars["TankUnit"].."target") and UnitHealth(HealBot_luVars["TankUnit"].."target")>1 then 
        _, _, z, _, _ = UnitDetailedThreatSituation(unit, HealBot_luVars["TankUnit"].."target")
        z=floor(z or 0)
        y = UnitThreatSituation(unit, HealBot_luVars["TankUnit"].."target")
    elseif UnitExists("target") and UnitIsEnemy("player", "target") and UnitHealth("target")>1 then 
        _, _, z, _, _ = UnitDetailedThreatSituation(unit, "target") 
        z=floor(z or 0)
        y = UnitThreatSituation(unit, "playertarget")
    elseif UnitExists("boss1") and UnitIsEnemy("player", "boss1") and UnitHealth("boss1")>1 then 
        _, _, z, _, _ = UnitDetailedThreatSituation(unit, "boss1") 
        z=floor(z or 0)
        y = UnitThreatSituation(unit, "playertarget")
    elseif UnitExists("boss2") and UnitIsEnemy("player", "boss2") and UnitHealth("boss2")>1 then 
        _, _, z, _, _ = UnitDetailedThreatSituation(unit, "boss2") 
        z=floor(z or 0)
        y = UnitThreatSituation(unit, "playertarget")
    else
        z=0
        y = UnitThreatSituation(unit)
    end
    if not y then y=0 end
    if z>=HealBot_Globals.aggro3pct then
        y=3
        if z>100 then z=100 end
    elseif z>=HealBot_Globals.aggro2pct and y<2 then
        y=2 
    elseif z>0 and y<1 then
        y=1
    end
  --HealBot_setCall("HealBot_CalcThreat")
    return z, y
end

local function HealBot_UnitNameOnly(unitName)
    local uName=nil
    if unitName then
        uName=strtrim(string.match(unitName, "^[^-]*"))
    end
  --HealBot_setCall("HealBot_UnitNameOnly")
    return uName
end

local function HealBot_OnEvent_ReadyCheckUpdate(unit,response)
    local xButton=HealBot_Unit_Button[unit]
    if HealBot_luVars["rcEnd"] and xButton and Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][xButton.frame]["SHOWRC"] then 
        local prevRedyCheck=xButton.icon.debuff.readycheck
        if response=="Y" then
            xButton.icon.debuff.readycheck="Interface\\RAIDFRAME\\ReadyCheck-Ready"
        elseif response=="W" then
            xButton.icon.debuff.readycheck="Interface\\RAIDFRAME\\ReadyCheck-Waiting"
        else
            xButton.icon.debuff.readycheck="Interface\\RAIDFRAME\\ReadyCheck-NotReady"
        end
        if xButton.icon.debuff.readycheck~=prevRedyCheck then
            HealBot_DebuffChecks(xButton)
        end
    end
  --HealBot_setCall("HealBot_OnEvent_ReadyCheckUpdate")
end

local function HealBot_OnEvent_hbReadyCheck(unitName,timer)
    local uName=HealBot_UnitNameOnly(unitName)
    local lUnit=HealBot_Panel_RaidUnit(nil,unitName)
    if not HealBot_luVars["rcEnd"] or HealBot_luVars["rcEnd"]<GetTime()+timer then
        if lUnit then
            HealBot_luVars["rcEnd"]=GetTime()+timer
            if HealBot_Unit_Button[lUnit] then HealBot_OnEvent_ReadyCheckUpdate(lUnit,"Y") end
            for xUnit,xButton in pairs(HealBot_Unit_Button) do
                if xUnit~=lUnit and UnitIsPlayer(xUnit) then
                    HealBot_OnEvent_ReadyCheckUpdate(xUnit,"W")
                end
            end
        end
    end
  --HealBot_setCall("HealBot_OnEvent_hbReadyCheck")
end

local function HealBot_OnEvent_hbReadyCheckConfirmed(hbGUID,response)
    local xUnit=hbGUID
    if HealBot_UnitData[hbGUID] then 
        xUnit=HealBot_UnitData[hbGUID]["UNIT"]
    end
    if HealBot_Unit_Button[xUnit] then
        HealBot_OnEvent_ReadyCheckUpdate(xUnit,response)
    end
  --HealBot_setCall("HealBot_OnEvent_hbReadyCheckConfirmed")
end

local HealBotAddonSummary={}
local HealBotAddonIncHeals={}
local hbExtra1, hbExtra2=nil, nil
local function HealBot_OnEvent_AddonMsg(self,addon_id,msg,distribution,sender_id)
    local inc_msg=msg
    local sender_id = HealBot_UnitNameOnly(sender_id)
    if not HealBotAddonSummary[sender_id..": "..addon_id] then
        HealBotAddonSummary[sender_id..": "..addon_id]=string.len(inc_msg)
    else
        HealBotAddonSummary[sender_id..": "..addon_id]=HealBotAddonSummary[sender_id..": "..addon_id]+string.len(inc_msg)
    end
    if addon_id==HEALBOT_HEALBOT then
        local datatype, datamsg, hbExtra1, hbExtra2 = string.split(":", inc_msg)
        if datatype=="R" then
            HealBot_luVars["VersionRequest"]=sender_id
            if HealBot_Options_Timer[130] then HealBot_Options_Timer[130]=nil end
        elseif datatype=="S" then
            HealBot_Vers[sender_id]=datamsg
            HealBot_AddDebug(sender_id..":  "..datamsg);
            HealBot_Comms_CheckVer(sender_id, datamsg)
        elseif datatype=="G" then
            HealBot_Comms_SendAddonMsg(HEALBOT_HEALBOT, "H:"..HEALBOT_VERSION, 4, sender_id)
            if not HealBot_Vers[sender_id] then
                HealBot_Comms_SendAddonMsg(HEALBOT_HEALBOT, "G", 4, sender_id)
            end
        elseif datatype=="F" then
            HealBot_Comms_SendAddonMsg(HEALBOT_HEALBOT, "C:"..HEALBOT_VERSION, 4, sender_id)
            if not HealBot_Vers[sender_id] then
                HealBot_Comms_SendAddonMsg(HEALBOT_HEALBOT, "F", 4, sender_id)
            end
        elseif datatype=="H" then
            HealBot_Vers[sender_id]=datamsg
            HealBot_AddDebug(sender_id..":  "..datamsg);
            HealBot_Options_setMyGuildMates(sender_id)
            HealBot_Comms_CheckVer(sender_id, datamsg)
        elseif datatype=="C" then
            HealBot_Vers[sender_id]=datamsg
            HealBot_AddDebug(sender_id..":  "..datamsg);
            HealBot_Options_setMyFriends(sender_id)
            HealBot_Comms_CheckVer(sender_id, datamsg)
        elseif datatype=="X" and HealBot_Globals.AcceptSkins==1 then
            HealBot_Options_ShareSkinRec("X", sender_id.."!"..datamsg)
        elseif datatype=="Y" then
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_SHARESKINACPT..sender_id);
            HealBot_Options_ShareSkinSend("Z", datamsg, sender_id)
        elseif datatype=="Z" then
            HealBot_Options_ShareSkinRec("Z", hbExtra1, datamsg, hbExtra2)
        elseif datatype=="RC" then
            local doRC=false
            for j=1,10 do
                if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][j]["SHOWRC"] then
                    doRC=true
                end
            end
            if doRC then
                if datamsg=="I" then
                    HealBot_OnEvent_hbReadyCheck(hbExtra1,hbExtra2)
                else
                    HealBot_OnEvent_hbReadyCheckConfirmed(hbExtra1,hbExtra2)
                end
            end
        end
    end
  --HealBot_setCall("HealBot_OnEvent_AddonMsg")
end

local extShareSkin={}
function HealBot_ShareSkinSendMsg(cmd, msg, unitName)
    if unitName==HEALBOT_ABOUT_URL then
        if cmd=="Init" then
            extShareSkin={[1]=msg}
            HealBot_luVars["saveSkinsTabSize"]=1
            HealBot_AddChat(HEALBOT_SHARE_INSTRUCTION)
        elseif cmd and msg then
            HealBot_luVars["saveSkinsTabSize"]=HealBot_luVars["saveSkinsTabSize"]+1
            extShareSkin[HealBot_luVars["saveSkinsTabSize"]]=cmd.."!"..msg
            if cmd=="Complete" then
                local ssStr=extShareSkin[1]
                for j=2,#extShareSkin do
                    ssStr=ssStr.."\n"..extShareSkin[j] 
                end
                HealBot_Options_ShareExternalEditBox:SetText(ssStr)
            end
        end
    else
        if cmd=="Init" then
            HealBot_luVars["shareSkinsTabSize"]=0
            HealBot_Options_ShareSkinStatus:SetValue(0)
            HealBot_Options_ShareSkinStatusf:SetText("0%")
            HealBot_Options_ShareSkinStatusf:SetTextColor(1,1,1,1)
            HealBot_Options_ShareSkinStatus:SetStatusBarColor(0.3,0.3,0.9,1)
        else
            if string.len(msg)>200 then
                local p1=strsub(msg,1,200)
                local p2=strsub(msg,201)
                table.insert(hbShareSkins,unitName.."!".."Z:1:"..cmd..":"..p1);
                table.insert(hbShareSkins,unitName.."!".."Z:2:"..cmd..":"..p2);
                HealBot_luVars["shareSkinsTabSize"]=HealBot_luVars["shareSkinsTabSize"]+1
            else
                table.insert(hbShareSkins,unitName.."!".."Z:0:"..cmd..":"..msg);
            end
            HealBot_luVars["shareSkinsTabSize"]=HealBot_luVars["shareSkinsTabSize"]+1
        end
    end
  --HealBot_setCall("HealBot_ShareSkinSendMsg")
end

function HealBot_GetInfo()
  --HealBot_setCall("HealBot_GetInfo")
    return HealBot_Vers
end

function HealBot_Split(msg, char)
    local x,y=nil,nil
    for x,_ in pairs(arrg) do
        arrg[x]=nil;
    end
    while (strfind(msg, char) ) do
        x, y = strfind(msg, char);
        tinsert(arrg, strsub(msg, 1, x-1));
        msg = strsub(msg, y+1, strlen(msg));
    end
    if ( strlen(msg) > 0 ) then
        tinsert(arrg, msg);
    end
  --HealBot_setCall("HealBot_Split")
    return arrg;
end

function HealBot_VehicleHealth(unit)
    local vGUID=HealBot_UnitGUID(unit)
    if not vGUID then
        HealBot_NoVehicle(unit)
        return 100,100
    end
  --HealBot_setCall("HealBot_VehicleHealth")
    return UnitHealth(unit), UnitHealthMax(unit)  
end

local function HealBot_OnEvent_LeavingVehicle(self, unit)
    local xUnit,xGUID,xButton = HealBot_UnitID(unit)
    if xUnit and HealBot_UnitInVehicle[xUnit] and xButton then
        HealBot_CheckAggroUnits(xButton)
    end
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["STATE"] then
        HealBot_nextRecalcParty(1)
    end
  --HealBot_setCall("HealBot_OnEvent_LeavingVehicle")
end

function HealBot_retIsInVehicle(unit)
  --HealBot_setCall("HealBot_retIsInVehicle")
    return HealBot_UnitInVehicle[unit]
end

local function HealBot_OnEvent_UnitAura(button)
    HealBot_AuraChecks(button)
  --HealBot_setCall("HealBot_OnEvent_UnitAura")
end

local function HealBot_UpdateAllHealth()
    for _,xButton in pairs(HealBot_Unit_Button) do
        xButton.health.updhealth=true
        xButton.health.update=true
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        xButton.health.updhealth=true
        xButton.health.update=true
    end
  --HealBot_setCall("HealBot_UpdateAllHealth")
end

function HealBot_OnEvent_PlayerTargetChanged(doRecalc)
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][9]["STATE"] then
        HealBot_luVars["targetSpec"] = " "
        if doRecalc then
            if not HealBot_Data["UILOCK"] then
                if UnitName("target") and HealBot_retHbFocus("target") then
                    if not UnitExists("focus") or not HealBot_retHbFocus("focus") then
                        HealBot_Panel_clickToFocus("Show")
                    else
                        HealBot_Panel_clickToFocus("hide")
                    end
                else
                    HealBot_Panel_clickToFocus("hide")
                end
            end
            local xButton=HealBot_Unit_Button["target"]
            if xButton then 
                if HealBot_luVars["TargetNeedReset"] then
                    HealBot_RecalcParty(3)
                elseif UnitExists("target") then
                    if HealBot_Data["UILOCK"] then
                        if HealBot_Config.ActionVisible[8] then
                            HealBot_UpdateUnitReset(xButton)
                            HealBot_UpdateUnit(xButton)
                        end
                    elseif (not Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TONLYFRIEND"] or UnitIsFriend("target", "player")) then
                        HealBot_UpdateUnitReset(xButton)
                        HealBot_UpdateUnit(xButton)
                        if not HealBot_Config.ActionVisible[8] then
                            HealBot_Action_ShowPanel(8)
                        end
                        HealBot_Panel_TargetChangedCheckFocus()
                    elseif HealBot_Config.ActionVisible[8] then
                        HealBot_Action_HidePanel(8)
                    end
                elseif not Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TALWAYSSHOW"] and HealBot_Config.ActionVisible[8] and not HealBot_Data["UILOCK"] then
                    HealBot_Action_HidePanel(8)
                end
            else
                HealBot_RecalcParty(3)
            end
        end
    elseif HealBot_Config.ActionVisible[8] then
        if HealBot_Data["UILOCK"] then
            HealBot_RecalcParty(3)
        else
            HealBot_Action_HidePanel(8)
        end
    end
    if Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["TBAR"] then
        if not HealBot_Data["UILOCK"] or Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["TBARCOMBAT"] then
            for xUnit,xButton in pairs(HealBot_Unit_Button) do
                if UnitExists("target") and not UnitIsEnemy("target", "player") and UnitIsUnit(xUnit, "target") and xUnit~="target" then
                    HealBot_Action_UpdateAggro(xUnit,"target",xButton.aggro.status,0)
                elseif xButton.aggro.status==-2 then
                     HealBot_Action_UpdateAggro(xUnit,"off",nil,0)
                end
            end
            for xUnit,xButton in pairs(HealBot_Pet_Button) do
                if UnitExists("target") and not UnitIsEnemy("target", "player") and UnitIsUnit(xUnit, "target") and xUnit~="target" then
                    HealBot_Action_UpdateAggro(xUnit,"target",xButton.aggro.status,0)
                elseif xButton.aggro.status==-2 then
                     HealBot_Action_UpdateAggro(xUnit,"off",nil,0)
                end
            end
        end
    end
  --HealBot_setCall("HealBot_OnEvent_PlayerTargetChanged")
end

local function HealBot_ClearLowMana()
    for xUnit,xButton in pairs(HealBot_Unit_Button) do
        local bar = _G["HealBot_Action_HealUnit"..xButton.id.."Bar"]
        if bar then
            local iconName = _G[bar:GetName().."Icontm1"];
            iconName:SetAlpha(0)
            iconName = _G[bar:GetName().."Icontm2"];
            iconName:SetAlpha(0)
            iconName = _G[bar:GetName().."Icontm3"];
            iconName:SetAlpha(0)
        end
    end
  --HealBot_setCall("HealBot_ClearLowMana")
end

function HealBot_OnEvent_PlayerRegenDisabled()
    HealBot_Data["UILOCK"]=true
    HealBot_luVars["DelayLockdownCheck"]=GetTime()+5
    if not HealBot_Data["PGUID"] then
        HealBot_Load("playerRD")      
        HealBot_luVars["SoftResetAfterCombat"]=true
    elseif HealBot_RefreshTypes[0] then
            HealBot_RecalcParty(0)
    else
        if HealBot_RefreshTypes[6] then HealBot_RecalcParty(6); end
        if HealBot_RefreshTypes[1] then HealBot_RecalcParty(1); end
        if HealBot_RefreshTypes[2] then 
            HealBot_RecalcParty(2); 
        elseif Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["STATE"] and HealBot_Check_Pets() then
            HealBot_RecalcParty(2); 
            HealBot_AddDebug("Enter Combat HealBot_Check_Pets RecalcParty=true")
        end
        if HealBot_RefreshTypes[3] then HealBot_RecalcParty(3); end
        if HealBot_RefreshTypes[4] then HealBot_RecalcParty(4); end
        HealBot_RecalcParty(5);
    end
    for xUnit,xButton in pairs(HealBot_Unit_Button) do
        if not HealBot_Config.ActionVisible[xButton.frame] and UnitExists(xUnit) then
            HealBot_Action_ShowPanel(xButton.frame)
        end
        if xButton.aura.buff.name and not HealBot_Config_Buffs.BuffWatchInCombat then
            HealBot_ClearBuff(xButton)
        end
        if xButton.aura.debuff.name and not HealBot_Config_Cures.DebuffWatchInCombat then
            HealBot_ClearDebuff(xButton)
        end
    end
    for xUnit,xButton in pairs(HealBot_Pet_Button) do
        if not HealBot_Config.ActionVisible[xButton.frame] and UnitExists(xUnit) then
            HealBot_Action_ShowPanel(xButton.frame)
        end
        if xButton.aura.debuff.name and not HealBot_Config_Cures.DebuffWatchInCombat then
            HealBot_ClearDebuff(xButton)
        end
    end
    if not Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["TBARCOMBAT"] and HealBot_luVars["HighlightTarget"] then
        HealBot_OnEvent_PlayerTargetChanged(false)
    end
    if not Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["LOWMANACOMBAT"] then HealBot_ClearLowMana() end
    --HealBot_Options_RaidTargetUpdate()
  --HealBot_setCall("HealBot_OnEvent_PlayerRegenDisabled")
end

function HealBot_EndInstanceEncounter()
    HealBot_luVars["27YardsOnly"]=false
    HealBot_luVars["adjMaxHealth"]=false
    if HealBot_luVars["healthFactor"]~=1 then
        HealBot_luVars["healthFactor"]=1
        HealBot_UpdateAllHealth()
    end
end

local function HealBot_OnEvent_InstanceEncounterEngageUnit(arg1, arg2, arg3, arg4) 
    if UnitExists("boss1") and UnitGUID("boss1") then
        local _,_,_,_,_,id,_ = string.split("-", UnitGUID("boss1"))
        if id==93439 then
            if HealBot_Config.AdjustMaxHealth then HealBot_luVars["adjMaxHealth"]=true end
        elseif id==140853 then
            HealBot_luVars["27YardsOnly"]=true
        end
    end
    HealBot_OnEvent_PlayerRegenDisabled()
end    

function HealBot_HasUnitBuff(buffName, unit, casterUnitID)
    if UnitExists(unit) then
        local name, _, _, _, _, expirationTime, unitCaster, _, _, spellId = AuraUtil.FindAuraByName(buffName, unit, "HELPFUL")
        if name then
            if casterUnitID then
                if casterUnitID==(unitCaster or "0") and not hbExcludeSpells[spellId] then
                    return true, expirationTime
                end
            elseif not hbExcludeSpells[spellId] then
                return true, expirationTime
            end
        end
    end
  --HealBot_setCall("HealBot_HasUnitBuff")
    return false;
end

function HealBot_BuffsCheck(button)
    if HealBot_luVars["BuffCheck"] and (HealBot_Config_Buffs.BuffWatchInCombat or not HealBot_Data["UILOCK"]) and UnitIsFriend("player",button.unit) then
        button.aura.buff.check=true
    end
  --HealBot_setCall("HealBot_BuffsCheck")
end

function HealBot_CheckAllBuffs(unit)
    if unit then
        if HealBot_Unit_Button[unit] then
            HealBot_BuffsCheck(HealBot_Unit_Button[unit])
        end
    else
        for _,xButton in pairs(HealBot_Unit_Button) do
            HealBot_BuffsCheck(xButton)
        end
    end
  --HealBot_setCall("HealBot_CheckAllBuffs")
end

function HealBot_DebuffChecks(button)
    button.aura.debuff.check=true
  --HealBot_setCall("HealBot_DebuffChecks")
end

function HealBot_AuraChecks(button)
    HealBot_DebuffChecks(button)
    button.aura.buff.check=true
  --HealBot_setCall("HealBot_AuraChecks")
end

function HealBot_CheckAllDebuffs(unit)
    if unit then
        if HealBot_Unit_Button[unit] then
            HealBot_DebuffChecks(HealBot_Unit_Button[unit])
        elseif HealBot_Pet_Button[unit] then
            HealBot_DebuffChecks(HealBot_Pet_Button[unit])
        end
    else
        for _,xButton in pairs(HealBot_Unit_Button) do
            HealBot_DebuffChecks(xButton)
        end
        for _,xButton in pairs(HealBot_Pet_Button) do
            HealBot_DebuffChecks(xButton)
        end
    end
  --HealBot_setCall("HealBot_CheckAllDebuffs")
end

function HealBot_ClearDebuff(button)
	if button.aura.debuff.name then
		button.aura.debuff.type = false;
		button.aura.debuff.name = false;
		button.aura.debuff.priority = 99;
        if button.aggro.status>4 then
            HealBot_Action_UpdateAggro(button.unit,false,nil,0)
        end
        HealBot_Action_UpdateDebuffButton(button)
	end
  --HealBot_setCall("HealBot_ClearDebuff")
end

function HealBot_ClearBuff(button)
    button.aura.buff.name=false
    HealBot_Action_UpdateBuffButton(button)
  --HealBot_setCall("HealBot_ClearBuff")
end

function HealBot_CheckPlayerMana(hbGUID, unit)
    if ((UnitPowerType(unit) or 1)==0) then
        hbManaPlayers[hbGUID]=unit
    else
        local _,uClass=UnitClass(unit)
        uClass=strsub((uClass or "XXXX"),1,4)
        if uClass=="DRUI" then
            hbManaPlayers[hbGUID]=unit
        end
    end
  --HealBot_setCall("HealBot_CheckPlayerMana")
end

function HealBot_EnteringCombat()
    if HealBot_Globals.DisableToolTipInCombat and HealBot_Data["TIPUNIT"] then
        HealBot_Action_HideTooltipFrame()
    end
    HealBot_Data["UILOCK"]=true
  --HealBot_setCall("HealBot_EnteringCombat")
end

function HealBot_GetUnitName(unit, hbGUID)
    local uName=nil
    if unit and UnitExists(unit) then
        local xGUID=hbGUID or "0"
        uName=HealBot_customTempUserName[xGUID] or UnitName(unit)
    end
  --HealBot_setCall("HealBot_GetUnitName")
    return uName
end

function HealBot_setEnemyBars()
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][11]["STATE"] then
        HealBot:RegisterEvent("UNIT_TARGET")
    else
        HealBot:UnregisterEvent("UNIT_TARGET")
    end
  --HealBot_setCall("HealBot_setEnemyBars")
end

local cUnitGUID={}
function HealBot_UnitGUID(unit)
  --HealBot_setCall("HealBot_UnitGUID")
    if unit and UnitExists(unit) then
        local xGUID=UnitGUID(unit)
        if not UnitIsPlayer(unit) then
            if unit=="pet" then
                local s=string.gsub(HealBot_GetUnitName(unit), " ", "")
                xGUID=UnitGUID("player")..s
            elseif UnitPlayerOrPetInRaid(unit) and strsub(unit,1,7)=="raidpet" then
                local raidId=strsub(unit,8)
                if raidId and UnitGUID("raid"..raidId) then
                    local s=string.gsub(HealBot_GetUnitName(unit), " ", "")
                    xGUID=UnitGUID("raid"..raidId)..s
                end
            elseif UnitPlayerOrPetInParty(unit) and strsub(unit,1,8)=="partypet" then
                local partyId=strsub(unit,9)
                if partyId and UnitGUID("party"..partyId) then
                    local s=string.gsub(HealBot_GetUnitName(unit), " ", "")
                    xGUID=UnitGUID("party"..partyId)..s
                end
            end
        end
        return xGUID
    end
    return nil
end

function HealBot_UnitPet(unit)
    local vUnit=nil
    if unit=="player" then
        vUnit="pet"
    elseif strsub(unit,1,4)=="raid" then
        vUnit="raidpet"..strsub(unit,5)
    elseif strsub(unit,1,5)=="party" then
        vUnit="partypet"..strsub(unit,6)
    end
  --HealBot_setCall("HealBot_UnitPet")
    return vUnit
end

local function HealBot_IC_PartyMembersChanged()
    for xUnit,xButton in pairs(HealBot_Unit_Button) do
        xButton.update.unit=true
        xButton.status.update=true
    end
  --HealBot_setCall("HealBot_IC_PartyMembersChanged")
end

function HealBot_OnEvent_PartyMembersChanged(self)
    if HealBot_luVars["NumPlayers"]~=GetNumGroupMembers() then
        HealBot_luVars["NumPlayers"]=GetNumGroupMembers()
        HealBot_luVars["CheckSkin"]=true
        HealBot_luVars["Checks"]=true
        if HealBot_luVars["IsSolo"] and HealBot_Config.DisableSolo then
            HealBot_Options_DisableCheck()
        end
        HealBot_nextRecalcParty(6)
        HealBot_Action_CheckReserved()
    else
        HealBot_setOptions_Timer(590)
    end
    if HealBot_Data["UILOCK"] then 
        HealBot_IC_PartyMembersChanged()
        HealBot_luVars["SoftResetAfterCombat"]=true 
        HealBot_ResetClassIconTexture()
    end
  --HealBot_setCall("HealBot_OnEvent_PartyMembersChanged")
end

function HealBot_retHighlightTarget()
  --HealBot_setCall("HealBot_retHighlightTarget")
    return HealBot_luVars["HighlightTarget"] or "nil"
end

function HealBot_retHbFocus(unit)
  --HealBot_setCall("HealBot_retHbFocus")
    local unitName=HealBot_GetUnitName(unit)
    if HealBot_Globals.FocusMonitor[unitName] then
        if HealBot_Globals.FocusMonitor[unitName]=="all" then
            return true
        else
            local _,z = IsInInstance()
            if z=="pvp" or z == "arena" then 
                if HealBot_Globals.FocusMonitor[unitName]=="bg" then
                    return true
                end
            elseif z==HealBot_Globals.FocusMonitor[unitName] then
                return true
            else
                z = GetRealZoneText()
                if z==HealBot_Globals.FocusMonitor[unitName] then
                    return true
                end
            end
        end
    end
    return false
end

local function HealBot_OnEvent_ReadyCheck(self,unitName,timer)
    local isLeader = UnitIsGroupAssistant("player") or UnitIsGroupLeader("player")
    if isLeader then
        HealBot_luVars["rcEnd"]=nil
        HealBot_luVars["isLeader"]=true
        HealBot_Comms_SendAddonMsg(HEALBOT_HEALBOT, "RC:I:"..unitName..":"..timer, HealBot_luVars["AddonMsgType"], HealBot_Data["PNAME"])
    else
        HealBot_luVars["isLeader"]=false
    end
  --HealBot_setCall("HealBot_OnEvent_ReadyCheck")
end

local function HealBot_OnEvent_ReadyCheckConfirmed(self,unit,response)
    local xUnit,xGUID = HealBot_UnitID(unit)
    if xUnit then 
		local hbResponse="N"
        if response then hbResponse="Y" end
        HealBot_Comms_SendAddonMsg(HEALBOT_HEALBOT, "RC:U:"..xGUID..":"..hbResponse, HealBot_luVars["AddonMsgType"], HealBot_Data["PNAME"])
    end
  --HealBot_setCall("HealBot_OnEvent_ReadyCheckConfirmed")
end

function HealBot_RaidTargetToggle(switch)
    if switch then
        HealBot:RegisterEvent("RAID_TARGET_UPDATE")
        HealBot_OnEvent_RaidTargetUpdateAll()
    else
        HealBot:UnregisterEvent("RAID_TARGET_UPDATE")
        for xUnit,xButton in pairs(HealBot_Unit_Button) do
            HealBot_RaidTargetUpdate(xButton,0)
        end
        for xUnit,xButton in pairs(HealBot_Enemy_Button) do
            HealBot_RaidTargetUpdate(xButton,0)
        end
        for xUnit,xButton in pairs(HealBot_Pet_Button) do
            HealBot_RaidTargetUpdate(xButton,0)
        end
    end
  --HealBot_setCall("HealBot_RaidTargetToggle")
end

local function HealBot_OnEvent_FocusChanged(self)
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["STATE"] then
        local xButton=HealBot_Unit_Button["focus"]
        if xButton then
            if not HealBot_UnitData["focus"] then HealBot_UnitData["focus"]={} end
            if HealBot_luVars["FocusNeedReset"] then
                HealBot_RecalcParty(4)
            elseif UnitExists("focus") then
                if HealBot_Data["UILOCK"] then
                    if HealBot_Config.ActionVisible[9] then 
                        HealBot_UpdateUnitReset(xButton)
                        HealBot_UpdateUnit(xButton)
                    end
                elseif (not Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["FONLYFRIEND"] or UnitIsFriend("focus", "player")) then
                    HealBot_UpdateUnitReset(xButton)
                    HealBot_UpdateUnit(xButton)
                    if not HealBot_Config.ActionVisible[9] then
                        HealBot_Action_ShowPanel(9)
                    end
                elseif HealBot_Config.ActionVisible[9] then
                    HealBot_Action_HidePanel(9)
                end
            elseif not Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["FALWAYSSHOW"] and HealBot_Config.ActionVisible[9] then
                if HealBot_Data["UILOCK"] then
                    HealBot_RecalcParty(4)
                else
                    HealBot_Action_HidePanel(9)
                end
            end
        else
            HealBot_RecalcParty(4)
        end
    elseif HealBot_Config.ActionVisible[9] then
        if HealBot_Data["UILOCK"] then
            HealBot_RecalcParty(4)
        else
            HealBot_Action_HidePanel(9)
        end
    end
  --HealBot_setCall("HealBot_OnEvent_FocusChanged")
end

local function HealBot_OnEvent_SystemMsg(self,msg)
    if type(msg)=="string" then
        if (string.find(msg, HB_ONLINE)) or (string.find(msg, HB_OFFLINE)) then
            msg = gsub(msg, "|Hplayer:([^%c^%d^%s^%p]+)|h(.+)|h", "%1")
            local uName = msg:match("([^%c^%d^%s^%p]+)")
            local xGUID=HealBot_RetUnitNameGUIDs(uName)
            if HealBot_UnitData[xGUID] and UnitExists(HealBot_UnitData[xGUID]["UNIT"]) then
                local xButton=HealBot_Unit_Button[HealBot_UnitData[xGUID]["UNIT"]]
                if xButton then 
                    if (string.find(msg, HB_ONLINE)) and xButton.status.offline then
                        xButton.status.offline = false
                        HealBot_Action_setNameTag(xButton)
                        HealBot_RecalcHeals(xButton)
                    end
                    HealBot_Action_setNameTag(xButton) 
                    HealBot_Action_ResetUnitStatus(xButton);
                end
            end
        end
    end
  --HealBot_setCall("HealBot_OnEvent_SystemMsg")
end

function HealBot_OnEvent_TalentsChanged(self)
    if HealBot_UnitData[HealBot_Data["PGUID"]] then HealBot_UnitData[HealBot_Data["PGUID"]]["SPEC"] = " " end
    HealBot_luVars["CheckTalents"]=true
    HealBot_luVars["Checks"]=true
  --HealBot_setCall("HealBot_OnEvent_TalentsChanged")
end

function HealBot_OnEvent_SpellsChanged(self, arg1)
    if arg1==0 then return; end
    if UnitIsDeadOrGhost("player") then return end
    HealBot_OnEvent_TalentsChanged(self)
    HealBot_setOptions_Timer(550)
  --HealBot_setCall("HealBot_OnEvent_SpellsChanged")
end

function HealBot_OnEvent_PlayerEnteringWorld(hbCaller)
    if HealBot_Config.ActionVisible[8] then
        if HealBot_Data["UILOCK"] then
            HealBot_RecalcParty(3)
        else
            HealBot_Action_HidePanel(8)
        end
    end
    if not HealBot_Data["PGUID"] then
        HealBot_Load("playerEW")      
    else
        TimeNow=GetTime()
        for xUnit,xButton in pairs(HealBot_Unit_Button) do
            if not xButton.status.reserved then
                if xButton.checks.range < TimeNow then HealBot_Range_CheckTime(xButton) end
                if xButton.checks.other < TimeNow then HealBot_Other_CheckTime(xButton) end
            end
            UnitBuffIcons=HealBot_UnitBuffIcons[xUnit]
            for bName,_ in pairs(UnitBuffIcons) do
                if not UnitBuffIcons[bName].current then
                    UnitBuffIcons[bName]=nil
                end
            end  
            UnitDebuffIcons=HealBot_UnitDebuffIcons[xUnit]
            for dName,_ in pairs(UnitDebuffIcons) do
                if not UnitDebuffIcons[dName].current then
                    UnitDebuffIcons[dName]=nil
                end
            end
        end
        for xUnit,xButton in pairs(HealBot_Enemy_Button) do
            if not xButton.status.reserved then
                if xButton.checks.other < TimeNow then HealBot_Enemy_CheckTime(xButton) end
            end
        end
        for xUnit,xButton in pairs(HealBot_Pet_Button) do
            if not xButton.status.reserved then
                if xButton.checks.range < TimeNow then HealBot_PetRange_CheckTime(xButton) end
            end
        end
        for x,_ in pairs(curDebuffs) do
            curDebuffs[x]=nil;
        end
    end
	HealBot_luVars["IsReallyFighting"]=true
    if hbCaller=="Event" then HealBot_SetResetFlag("QUICK") end
    
    if Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["HIDEPARTYF"] then
        HealBot_trackHiddenFrames["PARTY"]=true
        HealBot_Options_DisablePartyFrame()
        HealBot_Options_PlayerTargetFrames:Enable();
        if Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["HIDEPTF"] then
            HealBot_trackHiddenFrames["PLAYER"]=true
            HealBot_Options_DisablePlayerFrame()
            HealBot_Options_DisablePetFrame()
            HealBot_Options_DisableTargetFrame()
        end
    end
    if Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["HIDEBOSSF"] then
        HealBot_trackHiddenFrames["MINIBOSS"]=true
        HealBot_Options_DisableMiniBossFrame()
    end
    if Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["HIDERAIDF"] then
        HealBot_trackHiddenFrames["RAID"]=true
        HealBot_Options_DisableRaidFrame()
    end
    HealBot_setOptions_Timer(180)
    HealBot_setOptions_Timer(185)
    HealBot_setOptions_Timer(188)
    HealBot_setOptions_Timer(190)
    HealBot_Register_Events()
    HealBot_setOptions_Timer(120)
    for x=1,10 do
        HealBot_Action_setPoint(x)
    end
  --HealBot_setCall("HealBot_OnEvent_PlayerEnteringWorld")
end

function HealBot_OnEvent_PlayerLeavingWorld(self)
    if HealBot_Config.Profile==2 then
        HealBot_Options_hbProfile_saveClass()
    end
    HealBot_EndAggro() 
    HealBot_UnRegister_Events();
  --HealBot_setCall("HealBot_OnEvent_PlayerLeavingWorld")
end

local function HealBot_OnEvent_UnitSpellcastSent(self,caster,unitName,spellRank,spellID)
    local xUnit=nil
    local uscName = HealBot_UnitNameOnly(unitName)
    local spellName = GetSpellInfo(spellID)
    if uscName=="" then
        if spellName==HEALBOT_MENDPET and UnitExists("pet") then
            uscName=HealBot_GetUnitName("pet")
            xUnit=pet
        elseif not IsAttackSpell(spellName) and HealBot_luVars["TargetUnitID"] and UnitExists(HealBot_luVars["TargetUnitID"]) then
            uscName=HealBot_GetUnitName(HealBot_luVars["TargetUnitID"])
            xUnit=HealBot_luVars["TargetUnitID"]
        end
    elseif HealBot_luVars["TargetUnitID"] and UnitExists(HealBot_luVars["TargetUnitID"]) and uscName==HealBot_GetUnitName(HealBot_luVars["TargetUnitID"]) then
        xUnit=HealBot_luVars["TargetUnitID"]
    end
    if caster=="player" and uscName == HEALBOT_WORDS_UNKNOWN then
        uscName = HealBot_GetCorpseName(uscName)
    end
    if not uscName and HealBot_luVars["TargetUnitID"] and UnitExists(HealBot_luVars["TargetUnitID"]) then
        uscName=HealBot_GetUnitName(HealBot_luVars["TargetUnitID"])
        if UnitExists("target") and HealBot_GetUnitName("target")==uscName then
            xUnit="target"
        else
            xUnit=HealBot_luVars["TargetUnitID"]
        end
    end
    if (spellName==HEALBOT_MASS_RESURRECTION or spellName==HEALBOT_ABSOLUTION or spellName==HEALBOT_ANCESTRAL_VISION or spellName==HEALBOT_REAWAKEN or spellName==HEALBOT_REVITALIZE or 
        spellName==HEALBOT_RESURRECTION or spellName==HEALBOT_ANCESTRALSPIRIT or spellName==HEALBOT_REBIRTH or spellName==HEALBOT_REDEMPTION or spellName==HEALBOT_REVIVE or spellName==HEALBOT_RESUSCITATE)
        and UnitExists(xUnit) and HealBot_Unit_Button[xUnit]  then
        local xButton=HealBot_Unit_Button[xUnit]
        xButton.update.state=true
        xButton.status.update=true
        if caster=="player" and uscName then
            if Healbot_Config_Skins.Chat[Healbot_Config_Skins.Current_Skin]["NOTIFY"]>1 and Healbot_Config_Skins.Chat[Healbot_Config_Skins.Current_Skin]["RESONLY"] then
                if spellName==HEALBOT_MASS_RESURRECTION or spellName==HEALBOT_ABSOLUTION or spellName==HEALBOT_ANCESTRAL_VISION or spellName==HEALBOT_REAWAKEN or spellName==HEALBOT_REVITALIZE then           
                    HealBot_CastNotify(HEALBOT_OPTIONS_GROUPHEALS,spellName,xUnit)
                else
                    HealBot_CastNotify(uscName,spellName,xUnit)
                end
            end
        elseif HealBot_Spells[spellName] then
            HealBot_luVars["CastingTarget"] = xUnit;
            if Healbot_Config_Skins.Chat[Healbot_Config_Skins.Current_Skin]["NOTIFY"]>1 and Healbot_Config_Skins.Chat[Healbot_Config_Skins.Current_Skin]["RESONLY"]==false then
                HealBot_CastNotify(uscName,spellName,xUnit)
            end
        end
    end
  --HealBot_setCall("HealBot_OnEvent_UnitSpellcastSent")
end

function HealBot_GetCorpseName(cName)
    local z = _G["GameTooltipTextLeft1"];
    local x = z:GetText();
    if (x) then
        cName = string.gsub(x, HEALBOT_TOOLTIP_CORPSE, "")
    end
  --HealBot_setCall("HealBot_GetCorpseName")
    return cName
end

function HealBot_ResetCheckBuffsTime()
    HealBot_luVars["CheckPlayerBuffsTime"]=GetTime()+10050000
    for z,_ in pairs(HealBot_PlayerBuff) do
        local PlayerBuffsGUID=HealBot_PlayerBuff[z]
        for y,_ in pairs (PlayerBuffsGUID) do
            if PlayerBuffsGUID[y]<0 then
                PlayerBuffsGUID[y]=nil
            elseif PlayerBuffsGUID[y] < HealBot_luVars["CheckPlayerBuffsTime"] then
                HealBot_luVars["CheckPlayerBuffsTime"]=PlayerBuffsGUID[y]
                HealBot_luVars["CheckPlayerBuffsGUID"]=z
            end
        end
    end
    if HealBot_luVars["CheckPlayerBuffsTime"]>GetTime()+10000000 then
        HealBot_luVars["CheckPlayerBuffsTime"]=nil
        HealBot_luVars["CheckPlayerBuffsGUID"]=false
    end
  --HealBot_setCall("HealBot_ResetCheckBuffsTime")
end

function HealBot_CastNotify(unitName,spell,unit)
    local z = Healbot_Config_Skins.Chat[Healbot_Config_Skins.Current_Skin]["NOTIFY"];
    local s = gsub(Healbot_Config_Skins.Chat[Healbot_Config_Skins.Current_Skin]["MSG"],"#s",spell)
    s = gsub(s,"#l",GetSpellLink(spell, ""))
    s = gsub(s,"#n",unitName)
    local w=nil;
    if z==6 then
        w=HealBot_Comms_GetChan(Healbot_Config_Skins.Chat[Healbot_Config_Skins.Current_Skin]["CHAN"]) 
        if not w then z=2 end
    end
    if z==5 and not IsInRaid() then z = 4 end
    if z==4 and GetNumGroupMembers()==0 then z = 2 end
    if z==3 and UnitIsPlayer(HealBot_luVars["CastingTarget"]) and UnitPlayerControlled(HealBot_luVars["CastingTarget"]) and HealBot_luVars["CastingTarget"]~="player" then
        s = gsub(s,unitName,HEALBOT_WORDS_YOU)
        SendChatMessage(s,"WHISPER",nil,unitName);
    elseif z==4 then
        local chanId=HealBot_Comms_GetChan(INSTANCE_CHAT)
        if not chanId then
            chanId=HealBot_Comms_GetChan(PARTY)
        end
        if chanId then
            SendChatMessage(s,"CHANNEL",nil,chanId);
        else
            local inInst=IsInInstance()
            if inInst and IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
                SendChatMessage(s,"INSTANCE_CHAT",nil,nil);
            else
                SendChatMessage(s,"PARTY",nil,nil);
            end
        end
    elseif z==5 then
        local chanId=HealBot_Comms_GetChan(INSTANCE_CHAT)
        if not chanId then
            chanId=HealBot_Comms_GetChan(RAID)
        end
        if chanId then
            SendChatMessage(s,"CHANNEL",nil,chanId);
        else
            local inInst=IsInInstance()
            if inInst and IsInRaid(LE_PARTY_CATEGORY_INSTANCE) then
                SendChatMessage(s,"INSTANCE_CHAT",nil,nil);
            else
                SendChatMessage(s,"RAID",nil,nil);
            end
        end
    elseif z==6 then
        SendChatMessage(s,"CHANNEL",nil,w);
    else
        HealBot_AddChat(s);
    end
  --HealBot_setCall("HealBot_CastNotify")
end

function HealBot_retHoTdetails(unit)
  --HealBot_setCall("HealBot_retHoTdetails")
    return HealBot_UnitBuffIcons[unit]
end

function HealBot_retDebuffdetails(unit)
  --HealBot_setCall("HealBot_retDebuffdetails")
    return HealBot_UnitDebuffIcons[unit]
end

function HealBot_retDebufftype(name)
  --HealBot_setCall("HealBot_retDebufftype")
    local dType=HEALBOT_CUSTOM_en
    if curDebuffs[name] then dType=curDebuffs[name]["type"] end
    return dType
end

function HealBot_HoT_RemoveIconButton(button,removeAll)
    if HealBot_UnitBuffIcons[button.unit] then
        UnitBuffIcons=HealBot_UnitBuffIcons[button.unit]
        for bName,_ in pairs(UnitBuffIcons) do
            UnitBuffIcons[bName]=nil
        end
        for i=1,10 do
            HealBot_RemoveIcon(button, i)
        end
    end
    if HealBot_UnitDebuffIcons[button.unit] then
        UnitDebuffIcons=HealBot_UnitDebuffIcons[button.unit]
        for dName,_ in pairs(UnitDebuffIcons) do
            UnitDebuffIcons[dName]=nil
        end
        for i=51,55 do
            HealBot_RemoveIcon(button, i)
        end
    end
    if removeAll then
        HealBot_RaidTargetUpdate(button, 0)
    end
  --HealBot_setCall("HealBot_HoT_RemoveIconButton")
end

function HealBot_ToggelFocusMonitor(unit, zone)
    local unitName=HealBot_GetUnitName(unit)
    if HealBot_Globals.FocusMonitor[unitName] then
        if UnitExists("target") and unitName==HealBot_GetUnitName("target") then HealBot_Panel_clickToFocus("hide") end
        HealBot_Globals.FocusMonitor[unitName] = nil
    else
        HealBot_Globals.FocusMonitor[unitName] = zone
        if UnitExists("target") and HealBot_Globals.FocusMonitor[HealBot_GetUnitName("target")] then HealBot_Panel_clickToFocus("Show") end
    end
  --HealBot_setCall("HealBot_ToggelFocusMonitor")
end

function HealBot_PlaySound(id)
    PlaySoundFile(LSM:Fetch('sound',id));
  --HealBot_setCall("HealBot_PlaySound")
end

function HealBot_InitSpells()
    local sName,sRank,x = nil,nil,nil
    for x,_ in pairs(HealBot_SmartCast_Spells) do
        HealBot_SmartCast_Spells[x]=nil;
    end
  
    HealBot_Init_Spells_Defaults();

    if HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_PRIEST] then
        if HealBot_GetSpellId(HEALBOT_HEAL) then
            HealBot_SmartCast_Spells[HEALBOT_HEAL]="L"
        end
        if HealBot_GetSpellId(HEALBOT_FLASH_HEAL) then
            HealBot_SmartCast_Spells[HEALBOT_FLASH_HEAL]="S"
        end
	elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_DRUID] then
        if HealBot_GetSpellId(HEALBOT_HEALING_TOUCH) then
            HealBot_SmartCast_Spells[HEALBOT_HEALING_TOUCH]="L"
        end
        if HealBot_GetSpellId(HEALBOT_REJUVENATION) then
            HealBot_SmartCast_Spells[HEALBOT_REJUVENATION]="S"
        end
    elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_PALADIN] then
        if HealBot_GetSpellId(HEALBOT_HOLY_LIGHT) then
            HealBot_SmartCast_Spells[HEALBOT_HOLY_LIGHT]="L"
        end
        if HealBot_GetSpellId(HEALBOT_FLASH_OF_LIGHT) then
            HealBot_SmartCast_Spells[HEALBOT_FLASH_OF_LIGHT]="S"
        end
    elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_SHAMAN] then
        if HealBot_GetSpellId(HEALBOT_HEALING_SURGE) then
            HealBot_SmartCast_Spells[HEALBOT_HEALING_SURGE]="S"
        end
        if HealBot_GetSpellId(HEALBOT_HEALING_WAVE) then
            HealBot_SmartCast_Spells[HEALBOT_HEALING_WAVE]="L"
        end
    elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_MONK] then
        if HealBot_GetSpellId(HEALBOT_ENVELOPING_MIST) then
            HealBot_SmartCast_Spells[HEALBOT_ENVELOPING_MIST]="L"
        end
        if HealBot_GetSpellId(HEALBOT_REVIVAL) then
            HealBot_SmartCast_Spells[HEALBOT_REVIVAL]="S"
        elseif HealBot_GetSpellId(HEALBOT_SOOTHING_MIST) then
            HealBot_SmartCast_Spells[HEALBOT_SOOTHING_MIST]="S"
        end
    end
    HealBot_Action_SetrSpell()
    HealBot_Init_SmartCast();
    HealBot_Options_ResetDoInittab(8)
  --HealBot_setCall("HealBot_InitSpells")
end

function HealBot_Cycle_Skins()
    local n=getn(Healbot_Config_Skins.Skins)
    if n==Healbot_Config_Skins.Skin_ID then
        n=1
    else
        n=Healbot_Config_Skins.Skin_ID+1
    end
    HealBot_Options_Set_Current_Skin(Healbot_Config_Skins.Skins[n])
  --HealBot_setCall("HealBot_Cycle_Skins")
end

local ldb=nil
function HealBot_MMButton_Init()
    if LDBIcon and ldb and not LDBIcon:IsRegistered(HEALBOT_HEALBOT) then
        LDBIcon:Register(HEALBOT_HEALBOT, ldb, HealBot_Globals.MinimapIcon)
        HealBot_MMButton_Toggle()
    end
  --HealBot_setCall("HealBot_MMButton_Init")
end

if LDB11 then
	ldb = LDB11:NewDataObject(HEALBOT_HEALBOT, {
		type = "launcher",
		label = HEALBOT_HEALBOT,
		icon = "Interface\\AddOns\\HealBot\\Images\\HealBot",
	})

	function ldb.OnClick(self, button)
        if button == "LeftButton" then
            if IsShiftKeyDown() then
                HealBot_Cycle_Skins()
            else
                HealBot_TogglePanel(HealBot_Options)
            end
        elseif button == "RightButton" then
            if IsShiftKeyDown() then
                if HealBot_Config.DisableHealBot then
                    HealBot_Config.DisableHealBot=false
                else
                    HealBot_Config.DisableHealBot=true
                end
                HealBot_Options_DisableHealBotOpt:SetChecked(HealBot_Config.DisableHealBot)
                HealBot_Options_DisableCheck()
            else
                HealBot_SetResetFlag("SOFT")
            end
        else
            HealBot_TogglePanel(HealBot_Options)
        end
    end

	function ldb.OnTooltipShow(tt)
        tt:AddLine(HEALBOT_ADDON)
        tt:AddLine(" ")
        tt:AddLine(HEALBOT_LDB_LEFT_TOOLTIP)
        tt:AddLine(HEALBOT_LDB_SHIFTLEFT_TOOLTIP)
        tt:AddLine(" ")
        tt:AddLine(HEALBOT_LDB_RIGHT_TOOLTIP)
        tt:AddLine(HEALBOT_LDB_SHIFTRIGHT_TOOLTIP)
    end
end

function HealBot_MMButton_Toggle()
    if LDBIcon then
        if HealBot_Globals.MinimapIcon.hide==false then
            LDBIcon:Show(HEALBOT_HEALBOT)
        else
            LDBIcon:Hide(HEALBOT_HEALBOT)
        end
    end
  --HealBot_setCall("HealBot_MMButton_Toggle")
end

local sSwitch=UnitLevel("player")*50
function HealBot_SmartCast(hlthDelta)
    local s=nil
    for sName,sType in pairs(HealBot_SmartCast_Spells) do
        if (HealBot_Spells[sName]) then
            if sType=="L" then
                if hlthDelta>sSwitch then s=sName end
            elseif not s then
                s=sName
            end
        end
    end
  --HealBot_setCall("HealBot_SmartCast")
    return s;
end

function HealBot_UpdateUnitRange(button, spellName, doRefresh) 
    local oldRange=button.status.range
    button.spells.rangecheck=spellName
    button.status.range=HealBot_UnitInRange(button.unit, button.spells.rangecheck)
    if oldRange~=button.status.range then
        HealBot_Action_setNameTag(button)
        button.health.updincoming=true
        button.health.updabsorbs=true
        button.health.update=true
        if doRefresh then
            HealBot_RecalcHeals(button)
        end
        if button.status.range==1 then
            HealBot_BuffsCheck(button)
        end
    end
  --HealBot_setCall("HealBot_UpdateUnitRange")
end

function HealBot_UnitInRange(unit, spellName) -- added by Diacono of Ursin
    local uRange=0
    if UnitIsUnit("player",unit) then
        uRange = 1
    elseif not UnitIsVisible(unit) then 
        uRange = -1
    elseif not UnitInPhase(unit) then 
        uRange = 0
    elseif CheckInteractDistance(unit,1) then
        uRange = 1
    elseif not HealBot_luVars["27YardsOnly"] then
        if IsSpellInRange(spellName, unit) then
            uRange = IsSpellInRange(spellName, unit)
        elseif IsItemInRange(spellName, unit) then
            uRange = IsItemInRange(spellName, unit)
        elseif UnitInRange(unit) then
            uRange = 1
        else
            uRange = 0
        end
    else
        uRange = 0
    end
  --HealBot_setCall("HealBot_UnitInRange")
    return uRange
end

local hbPi = math.pi
local hbaTan2 = math.atan2
local hbdMod = 108 / math.pi / 2;
function HealBot_Direction_Check(unit) 
    local direction, hbX, hbY = nil,nil,nil
    local px, py = HealBot_getUnitCoords("player")
    if px then
        local tx, ty = HealBot_getUnitCoords(unit)
        if tx then
            local pFacing = GetPlayerFacing();
            pFacing = pFacing < 0 and pFacing + hbPi * 2 or pFacing;
            direction = hbPi - hbaTan2(px - tx, ty - py) - pFacing;
            direction = floor(direction * hbdMod + 0.5) % 108
            hbX, hbY = (direction % 9) * 0.109375, floor(direction / 9) * 0.08203125;
        end
    elseif not HealBot_luVars["mapUpdate"] then
        HealBot_luVars["mapUpdate"]=GetTime()+5
    end
  --HealBot_setCall("HealBot_Direction_Check")
    return hbX, hbY, direction;
end

function HealBot_getUnitCoords(unit)
  --HealBot_setCall("HealBot_getUnitCoords")
    if UnitIsPlayer(unit) then
        local uiMapID=C_Map.GetBestMapForUnit(unit)
        if uiMapID then
            local pos=C_Map.GetPlayerMapPosition(uiMapID, unit)
            if pos and pos.x and pos.y and pos.x > 0 and pos.y > 0 then
                return pos.x, pos.y
            end
        end
    end
    return nil, nil
end

function HealBot_getCurrentMapContinent()
    local mapInfo = C_Map.GetMapInfo(C_Map.GetBestMapForUnit("player"))
    while mapInfo.mapType~=2 do
        mapInfo = C_Map.GetMapInfo(mapInfo.parentMapID)
    end
  --HealBot_setCall("HealBot_getCurrentMapContinent")
    return mapInfo.mapID
end

function HealBot_mark2clearGUID(hbGUID)
    table.insert(HealBot_markedGUIDs,hbGUID)
end

function HealBot_check2clearGUID(hbGUID)
    local clearGUID=true
    for xUnit,xButton in pairs(HealBot_Unit_Button) do
        if xButton.guid==hbGUID then
            clearGUID=false
            break
        end
    end
    if clearGUID then
        HealBot_clearGUID(hbGUID)
    end
end

function HealBot_clearGUID(hbGUID)
    if HealBot_UnitData[hbGUID] then
        HealBot_Panel_RemoveMember(hbGUID)
        if HealBot_PlayerBuff[hbGUID] then HealBot_PlayerBuff[hbGUID]=nil end
        if HealBot_luVars["CheckPlayerBuffsGUID"]==hbGUID then 
            HealBot_luVars["ResetCheckBuffsTime"]=true
            HealBot_luVars["Checks"]=true
        end
        if hbManaPlayers[hbGUID] then hbManaPlayers[hbGUID]=nil end
        HealBot_UnitData[hbGUID]=nil
    end
  --HealBot_setCall("HealBot_ClearGUIDs")
end

function HealBot_ReloadUI()
    local msg="HealBot Requires UI Reload\n\nDue to updating from a very old version"
    StaticPopupDialogs["HEALBOT_OPTIONS_RELOADUI"] = {
        text = msg,
        button1 = HEALBOT_WORDS_YES,
        button2 = HEALBOT_WORDS_NO,
        OnAccept = function()
            ReloadUI();
        end,
        timeout = 0,
        whileDead = 1,
        hideOnEscape = 1
    };

    StaticPopup_Show ("HEALBOT_OPTIONS_RELOADUI");
  --HealBot_setCall("HealBot_ReloadUI")
end

function HealBot_Options_ResetSetting(resetTab)
    if resetTab=="BUFF" then
        local msg="Healbot recommends resetting the buffs tab \n\n Continue?"
        StaticPopupDialogs["HEALBOT_OPTIONS_RESETSETTING"] = {
            text = msg,
            button1 = HEALBOT_WORDS_YES,
            button2 = HEALBOT_WORDS_NO,
            OnAccept = function()
                HealBot_Reset_Buffs()
            end,
            timeout = 0,
            whileDead = 1,
            hideOnEscape = 1
        };
    elseif resetTab=="CUSTOM" then
        local msg="Healbot recommends resetting the custom debuffs tab \n\n Continue?"
        StaticPopupDialogs["HEALBOT_OPTIONS_RESETSETTING"] = {
            text = msg,
            button1 = HEALBOT_WORDS_YES,
            button2 = HEALBOT_WORDS_NO,
            OnAccept = function()
                HealBot_ResetCustomDebuffs()
            end,
            timeout = 0,
            whileDead = 1,
            hideOnEscape = 1
        };
    end

    StaticPopup_Show ("HEALBOT_OPTIONS_RESETSETTING");
  --HealBot_setCall("HealBot_Options_ResetSetting")
end

function HealBot_Copy_SpellCombos()
    local combo,button=nil,nil
    for x=1,3 do
        if x==1 then
            combo = HealBot_Config_Spells.EnabledKeyCombo;
        elseif x==2 then
            combo = HealBot_Config_Spells.DisabledKeyCombo;
        else
            combo = HealBot_Config_Spells.EnemyKeyCombo;
        end
        for y=1,15 do
            button = HealBot_Options_ComboClass_Button(y)
            if combo then
                combo[button] = combo[button..HealBot_Config.CurrentSpec]
                combo["Shift"..button] = combo["Shift"..button..HealBot_Config.CurrentSpec]
                combo["Ctrl"..button] = combo["Ctrl"..button..HealBot_Config.CurrentSpec]
                combo["Alt"..button] = combo["Alt"..button..HealBot_Config.CurrentSpec]
                combo["Ctrl-Shift"..button] = combo["Ctrl-Shift"..button..HealBot_Config.CurrentSpec]
                combo["Alt-Shift"..button] = combo["Alt-Shift"..button..HealBot_Config.CurrentSpec]
            end
        end
    end
    HealBot_Update_SpellCombos()
    HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_CONFIRMSPELLCOPY)
  --HealBot_setCall("HealBot_Copy_SpellCombos")
end

function HealBot_Reset_Spells()
    HealBot_DoReset_Spells(HealBot_Data["PCLASSTRIM"])
    HealBot_Globals.SmartCast=HealBot_GlobalsDefaults.SmartCast
    HealBot_Globals.SmartCastDebuff=HealBot_GlobalsDefaults.SmartCastDebuff
    HealBot_Globals.SmartCastBuff=HealBot_GlobalsDefaults.SmartCastBuff
    HealBot_Globals.SmartCastHeal=HealBot_GlobalsDefaults.SmartCastHeal
    HealBot_Globals.SmartCastRes=HealBot_GlobalsDefaults.SmartCastRes
    HealBot_Config.EnableHealthy=HealBot_ConfigDefaults.EnableHealthy
    HealBot_Update_SpellCombos()
    HealBot_Options_ResetDoInittab(2)
    HealBot_Options_Init(2)
    HealBot_Options_ComboClass_Text()
    HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_CONFIRMSPELLRESET)
  --HealBot_setCall("HealBot_Reset_Spells")
end

function HealBot_Reset_Buffs()
    HealBot_DoReset_Buffs(HealBot_Data["PCLASSTRIM"])
    HealBot_Config_Buffs.BuffWatch=HealBot_Config_BuffsDefaults.BuffWatch
    HealBot_Config_Buffs.BuffWatchInCombat=HealBot_Config_BuffsDefaults.BuffWatchInCombat
    HealBot_Config_Buffs.BuffWatchWhenGrouped=HealBot_Config_BuffsDefaults.BuffWatchWhenGrouped
    HealBot_Config_Buffs.ShortBuffTimer=HealBot_Config_BuffsDefaults.ShortBuffTimer
    HealBot_Config_Buffs.LongBuffTimer=HealBot_Config_BuffsDefaults.LongBuffTimer
    HealBot_Update_BuffsForSpec("Buff")
    HealBot_Options_ResetDoInittab(5)
    HealBot_Options_Init(5)
    HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_CONFIRMBUFFSRESET)
    HealBot_setOptions_Timer(40)
  --HealBot_setCall("HealBot_Reset_Buffs")
end

function HealBot_Reset_Cures()
    HealBot_DoReset_Cures(HealBot_Data["PCLASSTRIM"])
    HealBot_Config_Cures.SoundDebuffWarning=HealBot_Config_CuresDefaults.SoundDebuffWarning
    HealBot_Config_Cures.DebuffWatch=HealBot_Config_CuresDefaults.DebuffWatch
    HealBot_Config_Cures.IgnoreClassDebuffs=HealBot_Config_CuresDefaults.IgnoreClassDebuffs
    HealBot_Config_Cures.IgnoreNonHarmfulDebuffs=HealBot_Config_CuresDefaults.IgnoreNonHarmfulDebuffs
    HealBot_Config_Cures.IgnoreFastDurDebuffs=HealBot_Config_CuresDefaults.IgnoreFastDurDebuffs
    HealBot_Config_Cures.IgnoreFastDurDebuffsSecs=HealBot_Config_CuresDefaults.IgnoreFastDurDebuffsSecs
    HealBot_Config_Cures.IgnoreOnCooldownDebuffs=HealBot_Config_CuresDefaults.IgnoreOnCooldownDebuffs
    HealBot_Config_Cures.IgnoreMovementDebuffs=HealBot_Config_CuresDefaults.IgnoreMovementDebuffs
    HealBot_Config_Cures.SoundDebuffPlay=HealBot_Config_CuresDefaults.SoundDebuffPlay
    HealBot_Config_Cures.DebuffWatchInCombat=HealBot_Config_CuresDefaults.DebuffWatchInCombat
    HealBot_Config_Cures.DebuffWatchWhenGrouped=HealBot_Config_CuresDefaults.DebuffWatchWhenGrouped
    HealBot_Config_Cures.ShowDebuffWarning=HealBot_Config_CuresDefaults.ShowDebuffWarning
    HealBot_Config_Cures.CDCshownHB=HealBot_Config_CuresDefaults.CDCshownHB
    HealBot_Config_Cures.CDCshownAB=HealBot_Config_CuresDefaults.CDCshownAB
    HealBot_Update_BuffsForSpec("Debuff")
    HealBot_Options_ResetDoInittab(4)
    HealBot_Options_Init(4)
    HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_CONFIRMCURESRESET)
    HealBot_setOptions_Timer(50)
  --HealBot_setCall("HealBot_Reset_Cures")
end

function HealBot_Reset_Icons()
    Healbot_Config_Skins.Icons[HEALBOT_SKINS_STD]=HealBot_Config_SkinsDefaults.Icons[HEALBOT_SKINS_STD]
    Healbot_Config_Skins.Icons[HEALBOT_OPTIONS_GROUPHEALS]=HealBot_Config_SkinsDefaults.Icons[HEALBOT_OPTIONS_GROUPHEALS]
    Healbot_Config_Skins.Icons[HEALBOT_OPTIONS_EMERGENCYHEALS]=HealBot_Config_SkinsDefaults.Icons[HEALBOT_OPTIONS_EMERGENCYHEALS]
    Healbot_Config_Skins.Icons[HEALBOT_ZONE_AV]=HealBot_Config_SkinsDefaults.Icons[HEALBOT_ZONE_AV]
    Healbot_Config_Skins.RaidIcon[HEALBOT_SKINS_STD]=HealBot_Config_SkinsDefaults.RaidIcon[HEALBOT_SKINS_STD]
    Healbot_Config_Skins.RaidIcon[HEALBOT_OPTIONS_GROUPHEALS]=HealBot_Config_SkinsDefaults.RaidIcon[HEALBOT_OPTIONS_GROUPHEALS]
    Healbot_Config_Skins.RaidIcon[HEALBOT_OPTIONS_EMERGENCYHEALS]=HealBot_Config_SkinsDefaults.RaidIcon[HEALBOT_OPTIONS_EMERGENCYHEALS]
    Healbot_Config_Skins.RaidIcon[HEALBOT_ZONE_AV]=HealBot_Config_SkinsDefaults.RaidIcon[HEALBOT_ZONE_AV]
    Healbot_Config_Skins.IconText[HEALBOT_SKINS_STD]=HealBot_Config_SkinsDefaults.IconText[HEALBOT_SKINS_STD]
    Healbot_Config_Skins.IconText[HEALBOT_OPTIONS_GROUPHEALS]=HealBot_Config_SkinsDefaults.IconText[HEALBOT_OPTIONS_GROUPHEALS]
    Healbot_Config_Skins.IconText[HEALBOT_OPTIONS_EMERGENCYHEALS]=HealBot_Config_SkinsDefaults.IconText[HEALBOT_OPTIONS_EMERGENCYHEALS]
    Healbot_Config_Skins.IconText[HEALBOT_ZONE_AV]=HealBot_Config_SkinsDefaults.IconText[HEALBOT_ZONE_AV]
    HealBot_Globals.WatchHoT=HealBot_GlobalsDefaults.WatchHoT
    HealBot_Options_ResetDoInittab(3)
    HealBot_Options_Init(3)
    HealBot_Options_ComboClass_Text()
    HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_CONFIRMICONRESET)
  --HealBot_setCall("HealBot_Reset_Icons")
end

function HealBot_IsItemInBag(itemName)
  --HealBot_setCall("HealBot_IsItemInBag")
    if itemName then
        for bag = 0,4 do
            for slot = 1,GetContainerNumSlots(bag) do
                local item = GetContainerItemLink(bag,slot)
                if item and item:find(itemName) then
                    return true
                end
            end
        end
    end
    return false
end

function HealBot_runDefaults()
    HealBot_InitNewChar()
    HealBot_Update_BuffsForSpec()
    HealBot_Update_SpellCombos()
    HealBot_ClearAllBuffs()
    HealBot_ClearAllDebuffs()
  --HealBot_setCall("HealBot_runDefaults")
end

local arg1,arg2,arg3,arg4 = nil,nil,nil,nil
function HealBot_OnEvent(self, event, ...)
    arg1,arg2,arg3,arg4 = ...;
    if (event=="COMBAT_LOG_EVENT_UNFILTERED") then
        HealBot_OnEvent_Combat_Log(self,...)
    elseif (event=="UNIT_AURA") then
        local _,_,xButton = HealBot_UnitID(arg1)
        if xButton then
            HealBot_OnEvent_UnitAura(xButton);
        end
    elseif (event=="UNIT_HEALTH") or (event=="UNIT_MAXHEALTH") then
        local _,_,xButton = HealBot_UnitID(arg1)
        if xButton then
            HealBot_OnEvent_UnitHealth(xButton)
        end
    elseif (event=="UNIT_THREAT_SITUATION_UPDATE") or (event=="UNIT_THREAT_LIST_UPDATE") or (event=="UNIT_COMBAT") then
        local _,_,xButton = HealBot_UnitID(arg1)
        if xButton then
            HealBot_OnEvent_UnitThreat(xButton) 
        end
    elseif (event=="UNIT_HEAL_PREDICTION") then
        local _,_,xButton = HealBot_UnitID(arg1)
        if xButton then
            HealBot_HealsInUpdate(xButton)
        end
    elseif (event=="UNIT_ABSORB_AMOUNT_CHANGED") then
        local _,_,xButton = HealBot_UnitID(arg1)
        if xButton then
            HealBot_AbsorbsUpdate(xButton)
        end
    elseif (event=="UNIT_SPELLCAST_START") or (event=="UNIT_SPELLCAST_SUCCEEDED") or (event=="UNIT_SPELLCAST_FAILED") or (event=="UNIT_SPELLCAST_INTERRUPTED") or (event=="UNIT_SPELLCAST_STOP") then
        local _,_,xButton = HealBot_UnitID(arg1)
        if xButton then
            HealBot_OnEvent_UnitThreat(xButton)
        end
    elseif (event=="UNIT_SPELLCAST_SENT") then
        HealBot_OnEvent_UnitSpellcastSent(self,arg1,arg2,arg3,arg4);  
    elseif (event=="PLAYER_REGEN_DISABLED") then
        HealBot_OnEvent_PlayerRegenDisabled();
    elseif (event=="PLAYER_REGEN_ENABLED") then
        HealBot_luVars["IsReallyFighting"] = true
    elseif (event=="INSTANCE_ENCOUNTER_ENGAGE_UNIT") then
        HealBot_OnEvent_InstanceEncounterEngageUnit(arg1,arg2,arg3,arg4)
    elseif (event=="UNIT_NAME_UPDATE") then
        local _,_,xButton = HealBot_UnitID(arg1)
        if xButton then
            HealBot_OnEvent_UnitNameUpdate(xButton)
        end
    elseif (event=="UNIT_POWER_UPDATE") or (event=="UNIT_MAXPOWER") then
        local _,_,xButton = HealBot_UnitID(arg1)
        if xButton then
            HealBot_OnEvent_UnitMana(xButton)
        end
    elseif (event=="CHAT_MSG_SYSTEM") then
        HealBot_OnEvent_SystemMsg(self,arg1);
    elseif (event=="GROUP_ROSTER_UPDATE") then
        HealBot_OnEvent_PartyMembersChanged(self);
    elseif (event=="RAID_TARGET_UPDATE") then
        HealBot_OnEvent_RaidTargetUpdateAll()
    elseif (event=="UNIT_TARGET") then
        local xUnit,xGUID,xButton = HealBot_UnitID(arg1)
        if xButton and UnitExists(xUnit.."target") and UnitIsEnemy(xUnit, xUnit.."target") then
            HealBot_Action_ResetUnitStatus(xButton)
        end
    elseif (event=="PLAYER_TARGET_CHANGED") then
        HealBot_OnEvent_PlayerTargetChanged(true);
    elseif (event=="PLAYER_FOCUS_CHANGED") then
        HealBot_OnEvent_FocusChanged(self);
    elseif (event=="MODIFIER_STATE_CHANGED") then
        if HealBot_Data["TIPUSE"] and HealBot_Data["TIPUNIT"] then
            HealBot_Action_RefreshTooltip();
        end
    elseif (event=="PLAYER_CONTROL_GAINED") then
        if HealBot_Data["UILOCK"] then
            HealBot_CheckAllDebuffs();
        end
    elseif (event=="UNIT_PET") then
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["STATE"] then
            HealBot_nextRecalcParty(2)
        end
    elseif (event=="ROLE_CHANGED_INFORM") then
        HealBot_setOptions_Timer(420)
    elseif (event=="UNIT_ENTERED_VEHICLE") then
        HealBot_OnEvent_VehicleChange(self, arg1, true)
    elseif (event=="UNIT_EXITED_VEHICLE") then
        HealBot_OnEvent_VehicleChange(self, arg1, nil)
    elseif (event=="UNIT_EXITING_VEHICLE") then
        HealBot_OnEvent_LeavingVehicle(self, arg1)
    elseif (event=="PLAYER_ENTERING_WORLD") then
        HealBot_OnEvent_PlayerEnteringWorld("Event");
    elseif (event=="PLAYER_LEAVING_WORLD") then
        HealBot_OnEvent_PlayerLeavingWorld(self);
    elseif (event=="INSPECT_READY") then
        local xUnit = nil
        if HealBot_UnitData[arg1] then
            xUnit=HealBot_UnitData[arg1]["UNIT"]
        elseif UnitExists("target") and UnitGUID("target")==arg1 then
            xUnit="target"
        end
        if xUnit and UnitExists(xUnit) then HealBot_GetTalentInfo(arg1, xUnit) end
    elseif (event=="PLAYER_SPECIALIZATION_CHANGED") then
        local xUnit,xGUID,_ = HealBot_UnitID(arg1)
        if xUnit then HealBot_GetTalentInfo(xGUID, xUnit) end
        HealBot_ResetClassIconTexture()
    elseif (event=="UNIT_CONNECTION") then
        local xUnit,_,xButton = HealBot_UnitID(arg1)
        if xButton and xUnit then 
            if xButton.status.offline and UnitIsConnected(xUnit) then
                xButton.status.offline = false
                HealBot_Action_setNameTag(xButton)
                HealBot_RecalcHeals(xButton)                            
            elseif not xButton.status.offline and not UnitIsConnected(xUnit) then
                xButton.status.offline = GetTime()
                HealBot_Action_setNameTag(xButton)
                HealBot_RecalcHeals(xButton)
            end
        end
    elseif (event=="ZONE_CHANGED_NEW_AREA") or (event=="ZONE_CHANGED")  or (event=="ZONE_CHANGED_INDOORS") then
        HealBot_setOptions_Timer(9000)
        if (event=="ZONE_CHANGED_NEW_AREA") then
            HealBot_setOptions_Timer(120)
        end
    elseif (event=="CHAT_MSG_ADDON") then
        HealBot_OnEvent_AddonMsg(self,arg1,arg2,arg3,arg4);
    elseif (event=="PET_BATTLE_OPENING_START") or (event=="PET_BATTLE_OVER") then
        HealBot_luVars["lastPetBattleEvent"]=event
        HealBot_luVars["CheckSkin"]=true
        HealBot_luVars["Checks"]=true
        HealBot_nextRecalcParty(0)
    elseif (event=="READY_CHECK") then
        HealBot_OnEvent_ReadyCheck(self,arg1,arg2);
    elseif (event=="READY_CHECK_CONFIRM") then
        HealBot_OnEvent_ReadyCheckConfirmed(self,arg1,arg2);
    elseif (event=="READY_CHECK_FINISHED") then
        HealBot_luVars["rcEnd"]=GetTime()
    elseif (event=="UPDATE_MACROS") then
        HealBot_setOptions_Timer(950)
    elseif (event=="LEARNED_SPELL_IN_TAB") then
        HealBot_OnEvent_SpellsChanged(self,arg1);
        HealBot_setOptions_Timer(405)
    elseif (event=="PLAYER_TALENT_UPDATE") or (event=="CHARACTER_POINTS_CHANGED") then
        HealBot_OnEvent_TalentsChanged(self)
    elseif (event=="COMPANION_LEARNED") then
        HealBot_setOptions_Timer(405)
    elseif (event=="VARIABLES_LOADED") then
        HealBot_OnEvent_VariablesLoaded(self);
    elseif (event=="GET_ITEM_INFO_RECEIVED") then
        HealBot_OnEvent_ItemInfoReceived(self);
    else
        HealBot_AddDebug("OnEvent (" .. event .. ")");
    end
    --HealBot_setCall("HealBot_OnEvent")
end

