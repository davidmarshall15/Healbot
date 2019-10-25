--[[ HealBot Continued ]]

local HealBot_UnitBuffIcons={}
local HealBot_BuffNameTypes = {}
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
local HealBot_Ignore_Debuffs = {["Class"]={},["Movement"]={},["NonHarmful"]={},};
local HealBot_Timers={["HB1Inc"]=0,["HB1Th"]=0.1,["HB2Inc"]=0,["HB2Th"]=0.1,["HBaInc"]=0,["HBaTh"]=0.05,["CheckTimeMod"]=0.1}
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
local libCHC = nil
local libCTM = nil
local libCD = nil
local LDB11 = LibStub("LibDataBroker-1.1", true)
local LDBIcon = LibStub("LibDBIcon-1.0", true)
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
local HealBot_trackHiddenFrames={}
local _
local HealBot_Buff_Aura2Item={};
local HealBot_RefreshTypes={[0]=true,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false}
local UnitBuffIcons=nil
local UnitDebuffIcons=nil
local TimeNow=GetTime()
local HealBot_luVars={}
local HealBot_SpellID_LookupData={}
local HealBot_SpellID_LookupIdx={}
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
HealBot_luVars["AddonMsgType"]=3
HealBot_luVars["27YardsOnly"]=false
HealBot_luVars["TargetNeedReset"]=true
HealBot_luVars["FocusNeedReset"]=true
HealBot_luVars["SoftResetAfterCombat"]=false
HealBot_luVars["VehicleType"]=1
HealBot_luVars["PetType"]=2
HealBot_luVars["Timer8000"]=0
HealBot_luVars["TankUnit"]="x"
HealBot_luVars["HealBot_Refresh"]=TimeNow
HealBot_luVars["healthFactor"]=1
HealBot_luVars["clearGUID"]=false
HealBot_luVars["PrevTipTime"]=TimeNow
HealBot_luVars["TipTimeInterval"]=0.098
HealBot_luVars["lastBuffMsg"]="nil"
HealBot_luVars["reCheckActionFrames"]=false
HealBot_luVars["debuffExists"]=false
HealBot_luVars["buffExists"]=false
HealBot_luVars["EnableErrorSpeech"]=false
HealBot_luVars["EnableErrorText"]=false
HealBot_luVars["DelayLockdownCheck"]=TimeNow
HealBot_luVars["addonMsgTh"]=TimeNow+20
HealBot_luVars["NoSpamOOM"]=0

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
    for r=0,6 do
        if HealBot_RefreshTypes[r] then
            HealBot_luVars["HealBot_Refresh"]=GetTime()+HealBot_Globals.RangeCheckFreq
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
    if typeRequired==2 and Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["SELFPET"] then
        HealBot_nextRecalcParty(6)
    end
    HealBot_RefreshTypes[typeRequired]=true
    if not HealBot_luVars["HealBot_Refresh"] then
        HealBot_luVars["HealBot_Refresh"]=GetTime()+(HealBot_Globals.RangeCheckFreq*2)
    end
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

function HealBot_setNotVisible(unit,group)
    HealBot_notVisible[unit]=group
  --HealBot_setCall("HealBot_setNotVisible")
end

function HealBot_Clear_BuffWatch()
    for x,_ in pairs(HealBot_BuffWatch) do
        HealBot_BuffWatch[x]=nil;
    end
  --HealBot_setCall("HealBot_Clear_BuffWatch")
end

function HealBot_retBuffWatch(bName)
  --HealBot_setCall("HealBot_retLuVars")
    return HealBot_BuffWatch[bName]
end

function HealBot_Set_BuffWatch(buffName, ddId)
   -- table.insert(HealBot_BuffWatch,buffName);
    HealBot_BuffWatch[buffName]=ddId
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

function HealBot_RetMyBuffTime(button,buffName)
    if not button.aura.buff.recheck[buffName] then return end
    if HealBot_ShortBuffs[buffName] then
        return button.aura.buff.recheck[buffName]+HealBot_Config_Buffs.ShortBuffTimer
    else
        return button.aura.buff.recheck[buffName]+HealBot_Config_Buffs.LongBuffTimer
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
        --HealBot_AddDebug("Calling soft reset") 
    else
        HealBot_setResetFlagCode(4)
        --HealBot_AddDebug("Calling quick reset")
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
    if HealBot_Globals.DebugOut and HBmsg and (HealBot_SpamCut[HBmsg] or 0)<GetTime() then
        HealBot_SpamCut[HBmsg]=GetTime()+2
        HBmsg="["..date("%H:%M", time()).."] DEBUG: "..HBmsg;
        local unique=true;
        table.foreach(HealBot_DebugMsg, function (index,msg)
            if msg==HBmsg then unique=false; end
        end)
        if unique then
            table.insert(HealBot_DebugMsg,HBmsg)
        end
    end
  --HealBot_setCall("HealBot_AddDebug")
end

function HealBot_TogglePanel(HBpanel)
    if not HBpanel then return end
    if ( HBpanel:IsVisible() ) then
        HBpanel:Hide();
    else
        local fTop=HealBot_Comm_round(((HBpanel:GetTop()/GetScreenHeight())*100),2)
        local fLeft=HealBot_Comm_round(((HBpanel:GetLeft()/GetScreenWidth())*100),2)
        local fBottom=HealBot_Comm_round(((HBpanel:GetBottom()/GetScreenHeight())*100),2)
        local fRight=HealBot_Comm_round(((HBpanel:GetRight()/GetScreenWidth())*100),2)
        if fLeft<0 or fTop>100 or fBottom<0 or fRight>100 then 
            HBpanel:ClearAllPoints(); 
        end
        if fLeft<0 then 
            HBpanel:SetPoint("LEFT","UIParent","LEFT",0,0);
        elseif fTop>100 then 
            HBpanel:SetPoint("TOP","UIParent","TOP",0,0);
        elseif fBottom<0 then 
            HBpanel:SetPoint("BOTTOM","UIParent","BOTTOM",0,0);
        elseif fRight>100 then 
            HBpanel:SetPoint("RIGHT","UIParent","RIGHT",0,0); 
        end
        HBpanel:Show();
       -- HBpanel:ClearAllPoints();
       -- HBpanel:SetPoint("CENTER","UIParent","CENTER",0,0);
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
        HealBot_Action_StickyFrameClearStuck(hbCurFrame)
        HealBot_Action_setPoint(hbCurFrame)
    end
  --HealBot_setCall("HealBot_StopMoving")
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

local function HealBot_Reset_AutoUpdateDebuffIDs()
    HealBot_Globals.CatchAltDebuffIDs={}
    for dName, x in pairs(HealBot_Globals.HealBot_Custom_Debuffs) do
        local name, _, _, _, _, _, spellId = GetSpellInfo(dName)
        if name then
            HealBot_Globals.CatchAltDebuffIDs[name]=true
        elseif dName~=HEALBOT_CUSTOM_CAT_CUSTOM_AUTOMATIC then
            HealBot_Globals.CatchAltDebuffIDs[dName]=true
        end
    end
end

local function HealBot_Reset_AutoUpdateSpellIDs()
    HealBot_Reset_AutoUpdateDebuffIDs()
    HealBot_AddChat("Automatic Spell ID's Turned On")
end

local function HealBot_UIMessage(msg)
    local hbDebugChan=HealBot_Comms_GetChan("HBmsg");
    if hbDebugChan then
        --SendChatMessage(msg , "CHANNEL", nil, hbDebugChan);
    else
        HealBot_AddChat(msg)
    end
end

local function HealBot_UnitHasBuff(unit, bName)
    local z=1
    while true do
        name = UnitBuff(unit,z)
        if name then
            z=z+1
            if name==bName then return true end
        else
            break
        end
    end
    return false
end

local hbInPhase=true
local function HealBot_UnitInPhase(unit)
    if not HealBot_Data["UILOCK"] and UnitCreatureFamily(unit)=="Imp" and HealBot_UnitHasBuff(unit, HBC_PHASE_SHIFT) then
        hbInPhase=false
    else
        hbInPhase=UnitInPhase(unit)
    end
    return hbInPhase
end

local function HealBot_SlashCmd(cmd)
    if not cmd then cmd="" end
    local HBcmd, x, y, z = string.split(" ", cmd)
    HBcmd=string.lower(HBcmd) 
    if (HBcmd=="se1") then
        SetCVar("Sound_EnableErrorSpeech", "0");
    elseif (HBcmd=="se2") then
        HealBot_luVars["EnableErrorSpeech"]=true
    elseif (HBcmd=="se3") then
        UIErrorsFrame:Hide()
    elseif (HBcmd=="se4") then
        HealBot_luVars["EnableErrorText"]=true
    elseif (HBcmd=="" or HBcmd=="o" or HBcmd=="options" or HBcmd=="opt" or HBcmd=="config" or HBcmd=="cfg") then
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
    elseif (HBcmd=="cs") then
        HealBot_CheckAllSkins()
        HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_SKIN_CHECK_DONE)
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
    elseif (HBcmd=="spt") then
        if Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["SELFPET"] then
            Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["SELFPET"]=false
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_SELFPETSOFF)
        else
            Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["SELFPET"]=true
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
    elseif (HBcmd=="rau") then
        HealBot_Reset_AutoUpdateSpellIDs()
    elseif (HBcmd=="tdb01") then
        if HealBot_Globals.Debug01 then
            HealBot_Globals.Debug01=false
            HealBot_AddChat(HEALBOT_CHAT_ADDONID.."Debug 01 turned OFF")
        else
            HealBot_Globals.Debug01=true
            HealBot_AddChat(HEALBOT_CHAT_ADDONID.."Debug 01 turned ON")
        end
    elseif (HBcmd=="debug") then
        if HealBot_Globals.DebugOut then
            HealBot_Globals.DebugOut=false
            HealBot_AddChat("Debug OFF")
        else
            HealBot_Globals.DebugOut=true
            HealBot_AddChat("Debug ON")
        end
    elseif (HBcmd=="zzz") then
        if UnitExists("target") then
            v1=UnitName("target")
            v2=UnitCreatureFamily("target")
            if not HealBot_UnitInPhase("target") then
                HealBot_AddDebug(v1.." ("..v2..") not in phase")
            else
                HealBot_AddDebug(v1.." ("..v2..")  is with us")
            end
        else
            HealBot_AddDebug("target does not exist")
        end
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
            if tonumber(sName)==nil and not HealBot_SpellID_LookupData[sName] then
                HealBot_SpellID_LookupData[sName]={}
                HealBot_SpellID_LookupData[sName]["CHECK"]=true
                HealBot_SpellID_LookupData[sName]["CLASS"]=xClass
            elseif GetSpellInfo(sName) then
                sName=GetSpellInfo(sName)
            end
            local giftNaaru=false
            if sName==HealBot_Spell_IDs[HEALBOT_GIFT_OF_THE_NAARU] or (HealBot_Spell_Names[sName] or 0)==HEALBOT_GIFT_OF_THE_NAARU then
                giftNaaru=true
            end
            if xClass=="ALL" and x==3 then
                HealBot_Watch_HoT[sName]="C"
                if giftNaaru and HealBot_Data["PRACE_EN"]=="Draenei" then HealBot_Watch_HoT[sName]="C" end
            elseif (x==4) or (x==3 and xClass==HealBot_Data["PCLASSTRIM"]) then
                HealBot_Watch_HoT[sName]="A"
                if giftNaaru and HealBot_Data["PRACE_EN"]=="Draenei" then HealBot_Watch_HoT[sName]="A" end
            elseif x==2 then 
                HealBot_Watch_HoT[sName]="S"
                if giftNaaru and HealBot_Data["PRACE_EN"]=="Draenei" then HealBot_Watch_HoT[sName]="S" end
            else
                HealBot_Watch_HoT[sName]="H"
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
    if UnitExists(button.unit) and (button.aggro.status<0 or button.aggro.status>3) then 
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
    button.aura.buff.check=true
    button.aura.debuff.check=true
    HealBot_ClearUnitAggro(button)
    HealBot_Action_CheckUnitLowMana(button)
    button.health.updincoming=true
    button.health.updabsorbs=true
    button.health.update=true
end

local function HealBot_UnitID_Mismatch(unit)
    local xButton=HealBot_Unit_Button[unit] or HealBot_Pet_Button[unit] 
    if xButton then
        xButton.reset=true
        xButton.update.unit=true
        xButton.status.update=true
        if xButton.status.unittype==1 then
            HealBot_nextRecalcParty(6)
        elseif xButton.status.unittype<4 then
            HealBot_nextRecalcParty(2)
        else
        
        end
    end
end

function HealBot_UpdateUnit(button)
    if UnitExists(button.unit) and button.guid~=UnitGUID(button.unit) and button.status.unittype<4 then
        HealBot_UnitID_Mismatch(button.unit)
    end
    button.guid=UnitGUID(button.unit)
    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["CLASSONBAR"] then
        button.update.roleicon=true
    end    
    if Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][button.frame]["SHOW"] then 
        button.update.targeticon=true
    end
    HealBot_Action_UpdateBackgroundButton(button)
    HealBot_Action_setNameTag(button)
    HealBot_Action_setHealthText(button)
    HealBot_Action_setNameText(button)
    HealBot_Action_HBText(button)
    if UnitExists(button.unit) then
        button.health.updhealth=true
        HealBot_OnEvent_UnitMana(button);
    else
        HealBot_Action_UpdateHealthButton(button)
        HealBot_HoT_RemoveIconButton(button)
        if button.status.unittype==2 and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["STATE"] then
            HealBot_nextRecalcParty(1)
        elseif button.status.unittype==3 and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["STATE"] then
            HealBot_nextRecalcParty(2)
        end
    end
    button.health.updincoming=true
    button.health.updabsorbs=true
    button.health.update=true
    HealBot_Action_SetBar3Value(button)
    button.aura.debuff.check=true    
    button.aura.buff.check=true
    button.update.state=true
    button.status.update=true
  --HealBot_setCall("HealBot_UpdateUnit")
end

local function HealBot_RecalcParty(changeType)
    HealBot_RefreshTypes[changeType]=false
    HealBot_Action_PartyChanged(changeType);
  --HealBot_setCall("HealBot_RecalcParty")
end

function HealBot_ClearAllBuffs()
    for _,xButton in pairs(HealBot_Unit_Button) do
        if xButton.aura.buff.name then
            HealBot_ClearBuff(xButton)
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

local function HealBot_CheckZone()
    HealBot_setOptions_Timer(405)
    HealBot_setOptions_Timer(20)
    HealBot_setOptions_Timer(30)
    HealBot_setOptions_Timer(595)
    HealBot_setOptions_Timer(10)
    HealBot_setOptions_Timer(7950)
  --HealBot_setCall("HealBot_CheckZone")
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
        HealBot_Action_SetSpell("ENABLED", "Left", GetSpellInfo(HEALBOT_REGROWTH))
        HealBot_Action_SetSpell("ENABLED", "CtrlLeft", GetSpellInfo(HEALBOT_REMOVE_CORRUPTION))
        HealBot_Action_SetSpell("ENABLED", "Right", GetSpellInfo(HEALBOT_HEALING_TOUCH))
        HealBot_Action_SetSpell("ENABLED", "CtrlRight", GetSpellInfo(HEALBOT_NATURES_CURE))
        HealBot_Action_SetSpell("ENABLED", "Middle", GetSpellInfo(HEALBOT_REJUVENATION))
        HealBot_Action_SetSpell("DISABLED", "Left", GetSpellInfo(HEALBOT_REGROWTH))
        HealBot_Action_SetSpell("DISABLED", "Right", GetSpellInfo(HEALBOT_HEALING_TOUCH))
        HealBot_Action_SetSpell("DISABLED", "Middle", GetSpellInfo(HEALBOT_REJUVENATION))
    elseif pClassTrim=="MONK" then
        HealBot_Action_SetSpell("ENABLED", "Left", GetSpellInfo(HEALBOT_SOOTHING_MIST))
        HealBot_Action_SetSpell("ENABLED", "ShiftLeft", GetSpellInfo(HEALBOT_SURGING_MIST))
        HealBot_Action_SetSpell("ENABLED", "ShiftRight", GetSpellInfo(HEALBOT_REVIVAL))
        HealBot_Action_SetSpell("ENABLED", "CtrlLeft", GetSpellInfo(HEALBOT_DETOX))
        HealBot_Action_SetSpell("ENABLED", "Right", GetSpellInfo(HEALBOT_SOOTHING_MIST))
        HealBot_Action_SetSpell("ENABLED", "Middle", GetSpellInfo(HEALBOT_RENEWING_MIST))
        HealBot_Action_SetSpell("ENABLED", "ShiftMiddle", GetSpellInfo(HEALBOT_UPLIFT))
        HealBot_Action_SetSpell("ENABLED", "CtrlMiddle", GetSpellInfo(HEALBOT_LIFE_COCOON))
        HealBot_Action_SetSpell("ENABLED", "AltMiddle", GetSpellInfo(HEALBOT_ZEN_MEDITATION))
        HealBot_Action_SetSpell("DISABLED", "Left", GetSpellInfo(HEALBOT_SOOTHING_MIST))
        HealBot_Action_SetSpell("DISABLED", "Right", GetSpellInfo(HEALBOT_SOOTHING_MIST))
        HealBot_Action_SetSpell("DISABLED", "Middle", GetSpellInfo(HEALBOT_RENEWING_MIST))
    elseif pClassTrim=="PALA" then
        HealBot_Action_SetSpell("ENABLED", "Left", GetSpellInfo(HEALBOT_FLASH_OF_LIGHT))
        HealBot_Action_SetSpell("ENABLED", "ShiftRight", GetSpellInfo(HEALBOT_LIGHT_OF_DAWN))
        HealBot_Action_SetSpell("ENABLED", "CtrlLeft", GetSpellInfo(HEALBOT_CLEANSE))
        HealBot_Action_SetSpell("ENABLED", "Middle", GetSpellInfo(HEALBOT_WORD_OF_GLORY))
        HealBot_Action_SetSpell("ENABLED", "ShiftMiddle", GetSpellInfo(HEALBOT_HOLY_RADIANCE))
        HealBot_Action_SetSpell("DISABLED", "Left", GetSpellInfo(HEALBOT_FLASH_OF_LIGHT))
        HealBot_Action_SetSpell("DISABLED", "Middle", GetSpellInfo(HEALBOT_WORD_OF_GLORY))
        if HEALBOT_GAME_VERSION>3 then
            HealBot_Action_SetSpell("ENABLED", "Right", GetSpellInfo(HEALBOT_HOLY_LIGHT))
            HealBot_Action_SetSpell("DISABLED", "Right", GetSpellInfo(HEALBOT_HOLY_LIGHT))
        else
            HealBot_Action_SetSpell("ENABLED", "Right", GetSpellInfo(HBC_HOLY_LIGHT))
            HealBot_Action_SetSpell("DISABLED", "Right", GetSpellInfo(HBC_HOLY_LIGHT))
        end
    elseif pClassTrim=="PRIE" then
        HealBot_Action_SetSpell("ENABLED", "Left", GetSpellInfo(HEALBOT_FLASH_HEAL))
        HealBot_Action_SetSpell("ENABLED", "ShiftLeft", GetSpellInfo(HEALBOT_BINDING_HEAL))
        HealBot_Action_SetSpell("ENABLED", "CtrlLeft", GetSpellInfo(HEALBOT_PURIFY))
        HealBot_Action_SetSpell("ENABLED", "ShiftRight", GetSpellInfo(HEALBOT_HOLY_WORD_SERENITY))
        HealBot_Action_SetSpell("ENABLED", "CtrlRight", GetSpellInfo(HEALBOT_MASS_DISPEL))
        HealBot_Action_SetSpell("ENABLED", "Middle", GetSpellInfo(HEALBOT_RENEW))
        HealBot_Action_SetSpell("ENABLED", "ShiftMiddle", GetSpellInfo(HEALBOT_PRAYER_OF_MENDING))
        HealBot_Action_SetSpell("ENABLED", "AltMiddle", GetSpellInfo(HEALBOT_PRAYER_OF_HEALING))
        HealBot_Action_SetSpell("ENABLED", "CtrlMiddle", GetSpellInfo(HEALBOT_DIVINE_HYMN))
        HealBot_Action_SetSpell("DISABLED", "Left", GetSpellInfo(HEALBOT_FLASH_HEAL))
        HealBot_Action_SetSpell("DISABLED", "Middle", GetSpellInfo(HEALBOT_RENEW))
        if HEALBOT_GAME_VERSION>3 then
            HealBot_Action_SetSpell("ENABLED", "Right", GetSpellInfo(HEALBOT_HEAL))
            HealBot_Action_SetSpell("DISABLED", "Right", GetSpellInfo(HEALBOT_HEAL))
        else
            HealBot_Action_SetSpell("ENABLED", "Right", GetSpellInfo(HBC_HEAL))
            HealBot_Action_SetSpell("DISABLED", "Right", GetSpellInfo(HBC_HEAL))
        end
    elseif pClassTrim=="SHAM" then
        if HealBot_Config.CurrentSpec==3 then
            x=GetSpellInfo(HEALBOT_PURIFY_SPIRIT);
        else
            x=GetSpellInfo(HEALBOT_CLEANSE_SPIRIT);
        end
        HealBot_Action_SetSpell("ENABLED", "Right", GetSpellInfo(HEALBOT_HEALING_SURGE))
        HealBot_Action_SetSpell("ENABLED", "Middle", GetSpellInfo(HEALBOT_HEALING_RAIN))
        HealBot_Action_SetSpell("ENABLED", "CtrlLeft", x)
        HealBot_Action_SetSpell("ENABLED", "CtrlRight", x)
        HealBot_Action_SetSpell("ENABLED", "ShiftLeft", GetSpellInfo(HEALBOT_CHAIN_HEAL))
        HealBot_Action_SetSpell("ENABLED", "ShiftMiddle", GetSpellInfo(HEALBOT_HEALING_STREAM_TOTEM))
        HealBot_Action_SetSpell("DISABLED", "Right", GetSpellInfo(HEALBOT_HEALING_SURGE))
        HealBot_Action_SetSpell("DISABLED", "Middle", GetSpellInfo(HEALBOT_HEALING_RAIN))
        if HEALBOT_GAME_VERSION>3 then
            HealBot_Action_SetSpell("ENABLED", "Left", GetSpellInfo(HEALBOT_HEALING_WAVE))
            HealBot_Action_SetSpell("DISABLED", "Left", GetSpellInfo(HEALBOT_HEALING_WAVE))
        else
            HealBot_Action_SetSpell("ENABLED", "Left", GetSpellInfo(HBC_HEALING_WAVE))
            HealBot_Action_SetSpell("DISABLED", "Left", GetSpellInfo(HBC_HEALING_WAVE))
        end
    elseif pClassTrim=="MAGE" then
        HealBot_Action_SetSpell("ENABLED", "Left", GetSpellInfo(HEALBOT_REMOVE_CURSE))
    end
    HealBot_Action_SetSpell("ENABLED", "Alt-ShiftMiddle", bandage)
    HealBot_Action_SetSpell("ENABLED", "Alt-ShiftLeft", HEALBOT_DISABLED_TARGET)
    HealBot_Action_SetSpell("ENABLED", "Alt-ShiftRight", HEALBOT_ASSIST)
    HealBot_Action_SetSpell("ENABLED", "Ctrl-ShiftLeft", HEALBOT_MENU)
    HealBot_Action_SetSpell("ENABLED", "Ctrl-ShiftRight", HEALBOT_HBMENU)
    HealBot_Action_SetSpell("DISABLED", "Alt-ShiftLeft", HEALBOT_DISABLED_TARGET)
    HealBot_Action_SetSpell("DISABLED", "Alt-ShiftRight", HEALBOT_ASSIST)
    HealBot_Action_SetSpell("DISABLED", "Ctrl-ShiftLeft", HEALBOT_MENU)
    HealBot_Action_SetSpell("DISABLED", "Ctrl-ShiftRight", HEALBOT_HBMENU)
  --HealBot_setCall("HealBot_DoReset_Spells")
end

local function HealBot_DoReset_Cures(pClassTrim)
    HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_WORDS_NONE,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
    HealBot_Config_Cures.HealBotDebuffDropDown = {[1]=4,[2]=4,[3]=4}
    if pClassTrim=="DRUI" then
        if HealBot_KnownSpell(HEALBOT_NATURES_CURE) then
            if HealBot_KnownSpell(HEALBOT_REMOVE_CORRUPTION) then
                HealBot_Config_Cures.HealBotDebuffText = {[1]=HealBot_Spell_IDs[HEALBOT_REMOVE_CORRUPTION].name,[2]=HealBot_Spell_IDs[HEALBOT_NATURES_CURE].name,[3]=HEALBOT_WORDS_NONE}
            else
                HealBot_Config_Cures.HealBotDebuffText = {[1]=HealBot_Spell_IDs[HEALBOT_NATURES_CURE].name,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
            end
        elseif HealBot_KnownSpell(HEALBOT_REMOVE_CORRUPTION) then
            HealBot_Config_Cures.HealBotDebuffText = {[1]=HealBot_Spell_IDs[HEALBOT_REMOVE_CORRUPTION].name,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
        end
    elseif pClassTrim=="MONK" then
        if HealBot_KnownSpell(HEALBOT_DETOX) then
            HealBot_Config_Cures.HealBotDebuffText = {[1]=HealBot_Spell_IDs[HEALBOT_DETOX].name,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
        end
    elseif pClassTrim=="PALA" then
        if HealBot_KnownSpell(HEALBOT_CLEANSE) then
            HealBot_Config_Cures.HealBotDebuffText = {[1]=HealBot_Spell_IDs[HEALBOT_CLEANSE].name,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
        elseif HealBot_KnownSpell(HEALBOT_CLEANSE_TOXIN) then
            HealBot_Config_Cures.HealBotDebuffText = {[1]=HealBot_Spell_IDs[HEALBOT_CLEANSE_TOXIN].name,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
        end
    elseif pClassTrim=="PRIE" then
        if HealBot_KnownSpell(HEALBOT_PURIFY) then
            if HealBot_KnownSpell(HEALBOT_MASS_DISPEL) then
                if HealBot_KnownSpell(HEALBOT_PURIFY_DISEASE) then
                    HealBot_Config_Cures.HealBotDebuffText = {[1]=HealBot_Spell_IDs[HEALBOT_PURIFY].name,[2]=HealBot_Spell_IDs[HEALBOT_MASS_DISPEL].name,
                                                              [3]=HealBot_Spell_IDs[HEALBOT_PURIFY_DISEASE].name}
                else
                    HealBot_Config_Cures.HealBotDebuffText = {[1]=HealBot_Spell_IDs[HEALBOT_PURIFY].name,[2]=HealBot_Spell_IDs[HEALBOT_MASS_DISPEL].name,[3]=HEALBOT_WORDS_NONE}
                end
            elseif HealBot_KnownSpell(HEALBOT_PURIFY_DISEASE) then
                HealBot_Config_Cures.HealBotDebuffText = {[1]=HealBot_Spell_IDs[HEALBOT_PURIFY].name,[2]=HealBot_Spell_IDs[HEALBOT_PURIFY_DISEASE].name,[3]=HEALBOT_WORDS_NONE}
            else
                HealBot_Config_Cures.HealBotDebuffText = {[1]=HealBot_Spell_IDs[HEALBOT_PURIFY].name,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
            end
        elseif HealBot_KnownSpell(HEALBOT_MASS_DISPEL) then
            if HealBot_KnownSpell(HEALBOT_PURIFY_DISEASE) then
                HealBot_Config_Cures.HealBotDebuffText = {[1]=HealBot_Spell_IDs[HEALBOT_MASS_DISPEL].name,[2]=HealBot_Spell_IDs[HEALBOT_PURIFY_DISEASE].name,[3]=HEALBOT_WORDS_NONE}
            else
                HealBot_Config_Cures.HealBotDebuffText = {[1]=HealBot_Spell_IDs[HEALBOT_MASS_DISPEL].name,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
            end
        elseif HealBot_KnownSpell(HEALBOT_PURIFY_DISEASE) then
            HealBot_Config_Cures.HealBotDebuffText = {[1]=HealBot_Spell_IDs[HEALBOT_PURIFY_DISEASE].name,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
        end
    elseif pClassTrim=="SHAM" then
        if HealBot_KnownSpell(HEALBOT_PURIFY_SPIRIT) then
            HealBot_Config_Cures.HealBotDebuffText = {[1]=HealBot_Spell_IDs[HEALBOT_PURIFY_SPIRIT].name,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
        elseif HealBot_KnownSpell(HEALBOT_CLEANSE_SPIRIT) then
            HealBot_Config_Cures.HealBotDebuffText = {[1]=HealBot_Spell_IDs[HEALBOT_CLEANSE_SPIRIT].name,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
        end
    elseif pClassTrim=="MAGE" then
        if HealBot_KnownSpell(HEALBOT_REMOVE_CURSE) then
            HealBot_Config_Cures.HealBotDebuffText = {[1]=HealBot_Spell_IDs[HEALBOT_REMOVE_CURSE].name,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
        end
    end
  --HealBot_setCall("HealBot_DoReset_Cures")
end

local function HealBot_DoReset_Buffs(pClassTrim)
    HealBot_Config_Buffs.HealBotBuffText = {[1]=HEALBOT_WORDS_NONE,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE,[4]=HEALBOT_WORDS_NONE,[5]=HEALBOT_WORDS_NONE,
                                      [6]=HEALBOT_WORDS_NONE,[7]=HEALBOT_WORDS_NONE,[8]=HEALBOT_WORDS_NONE,[9]=HEALBOT_WORDS_NONE}
    HealBot_Config_Buffs.HealBotBuffDropDown = {[1]=4,[2]=4,[3]=4,[4]=4,[5]=4,[6]=4,[7]=2,[8]=2,[9]=2}
    if pClassTrim=="DRUI" then
        if HealBot_KnownSpell(HEALBOT_MARK_OF_THE_WILD) then
            HealBot_Config_Buffs.HealBotBuffText[1]=HealBot_Spell_IDs[HEALBOT_MARK_OF_THE_WILD].name
        end
    elseif pClassTrim=="MONK" then
        if HealBot_KnownSpell(HEALBOT_LEGACY_WHITETIGER) and HealBot_Config.CurrentSpec==3 then
            HealBot_Config_Buffs.HealBotBuffText[1]=HealBot_Spell_IDs[HEALBOT_LEGACY_EMPEROR].name
            HealBot_Config_Buffs.HealBotBuffText[2]=HealBot_Spell_IDs[HEALBOT_LEGACY_WHITETIGER].name
        elseif HealBot_KnownSpell(HEALBOT_LEGACY_EMPEROR) then
            HealBot_Config_Buffs.HealBotBuffText[1]=HealBot_Spell_IDs[HEALBOT_LEGACY_EMPEROR].name
        end
    elseif pClassTrim=="PALA" then
        local i=1
        if HealBot_KnownSpell(HEALBOT_BLESSING_OF_KINGS) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_Spell_IDs[HEALBOT_BLESSING_OF_KINGS].name
            i=i+1 
        elseif HealBot_KnownSpell(HBC_GREATER_BLESSING_OF_KINGS) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_Spell_IDs[HBC_GREATER_BLESSING_OF_KINGS].name
            i=i+1
        elseif HealBot_KnownSpell(HBC_BLESSING_OF_KINGS) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_Spell_IDs[HBC_BLESSING_OF_KINGS].name
            i=i+1
        end
        if HealBot_KnownSpell(HEALBOT_BLESSING_OF_MIGHT) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_Spell_IDs[HEALBOT_BLESSING_OF_MIGHT].name
            i=i+1
        elseif HealBot_KnownSpell(HBC_GREATER_BLESSING_OF_MIGHT) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_Spell_IDs[HBC_GREATER_BLESSING_OF_MIGHT].name
            i=i+1
        elseif HealBot_KnownSpell(HBC_BLESSING_OF_MIGHT) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_Spell_IDs[HBC_BLESSING_OF_MIGHT].name
            i=i+1
        end
        if HealBot_KnownSpell(HEALBOT_BLESSING_OF_WISDOM) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_Spell_IDs[HEALBOT_BLESSING_OF_WISDOM].name
        elseif HealBot_KnownSpell(HBC_GREATER_BLESSING_OF_WISDOM) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_Spell_IDs[HBC_GREATER_BLESSING_OF_WISDOM].name
        elseif HealBot_KnownSpell(HBC_BLESSING_OF_WISDOM) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_Spell_IDs[HBC_BLESSING_OF_WISDOM].name
        end
    elseif pClassTrim=="PRIE" then
        if HealBot_KnownSpell(HEALBOT_POWER_WORD_FORTITUDE) then
            HealBot_Config_Buffs.HealBotBuffText[1]=HealBot_Spell_IDs[HEALBOT_POWER_WORD_FORTITUDE].name
        elseif HealBot_KnownSpell(HBC_POWER_WORD_FORTITUDE) then
            HealBot_Config_Buffs.HealBotBuffText[1]=HealBot_Spell_IDs[HBC_POWER_WORD_FORTITUDE].name
        end
        local i=2
        if HealBot_KnownSpell(HEALBOT_FEAR_WARD) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_Spell_IDs[HEALBOT_FEAR_WARD].name
            HealBot_Config_Buffs.HealBotBuffDropDown[i]=24
            i=i+1
        end
        if HealBot_KnownSpell(HBC_DIVINE_SPIRIT) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_Spell_IDs[HBC_DIVINE_SPIRIT].name
            i=i+1
        end
    elseif pClassTrim=="SHAM" then
        if HealBot_KnownSpell(HEALBOT_WATER_SHIELD) then
            HealBot_Config_Buffs.HealBotBuffText[1]=HealBot_Spell_IDs[HEALBOT_WATER_SHIELD].name
        end
        if HealBot_KnownSpell(HEALBOT_EARTH_SHIELD) then
            HealBot_Config_Buffs.HealBotBuffText[2]=HealBot_Spell_IDs[HEALBOT_EARTH_SHIELD].name
            HealBot_Config_Buffs.HealBotBuffDropDown[2]=24
        end
    elseif pClassTrim=="MAGE" then
        if HealBot_KnownSpell(HEALBOT_ARCANE_BRILLIANCE) then
            HealBot_Config_Buffs.HealBotBuffText[1]=HealBot_Spell_IDs[HEALBOT_ARCANE_BRILLIANCE].name
        end
    elseif pClassTrim=="WARR" then
        if HealBot_KnownSpell(HEALBOT_COMMANDING_SHOUT) then
            HealBot_Config_Buffs.HealBotBuffText[1]=HealBot_Spell_IDs[HEALBOT_COMMANDING_SHOUT].name
        end
        if HealBot_KnownSpell(HEALBOT_VIGILANCE) then
            HealBot_Config_Buffs.HealBotBuffText[2]=HealBot_Spell_IDs[HEALBOT_VIGILANCE].name
            HealBot_Config_Buffs.HealBotBuffDropDown[2]=24
        end
    elseif pClassTrim=="WARL" then
        if HealBot_KnownSpell(HEALBOT_DARK_INTENT) then
            HealBot_Config_Buffs.HealBotBuffText[1]=HealBot_Spell_IDs[HEALBOT_DARK_INTENT].name
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
    end
  --HealBot_setCall("HealBot_InitNewChar")
end

local function HealBot_Load(hbCaller)
    HealBot_setOptions_Timer(60)
    HealBot_setOptions_Timer(25)
    HealBot_Options_LoadTips()
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
    HealBot_InitSpells()
    HealBot_setOptions_Timer(550)
    HealBot_useCrashProtection()
    HealBot_Action_ResetSkin("init")
    HealBot_InitNewChar()
    HealBot_Options_SetSkins();
    HealBot_configClassHoT()
    if HealBot_luVars["AddonMsgType"]==2 then HealBot_Comms_SendAddonMsg("CTRA", "SR", HealBot_luVars["AddonMsgType"], HealBot_Data["PNAME"]) end
    if not HealBot_luVars["HelpNotice"] then
        HealBot_setOptions_Timer(990)
        HealBot_luVars["HelpNotice"]=true
    end
    if hbCaller~="playerEW" then
        HealBot_OnEvent_PlayerEnteringWorld("Load")
    end
    HealBot_setOptions_Timer(140)
    HealBot_setEnemyBars()
    HealBot_MMButton_Init();
  --HealBot_setCall("HealBot_Load")
end

local function HealBot_Register_Events()
    if HealBot_Config.DisabledNow==0 then
        if HEALBOT_GAME_VERSION>3 then
            HealBot:RegisterEvent("PLAYER_FOCUS_CHANGED");
            HealBot:RegisterEvent("UNIT_ENTERED_VEHICLE");
            HealBot:RegisterEvent("UNIT_EXITED_VEHICLE");
            HealBot:RegisterEvent("UNIT_EXITING_VEHICLE");
            HealBot:RegisterEvent("UNIT_ABSORB_AMOUNT_CHANGED");
            HealBot:RegisterEvent("PLAYER_TALENT_UPDATE");
            HealBot:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
            HealBot:RegisterEvent("COMPANION_LEARNED");
            HealBot:RegisterEvent("PET_BATTLE_OPENING_START");
            HealBot:RegisterEvent("PET_BATTLE_OVER");
        else
            libCD = libCD or LibStub("LibClassicDurations")
            if libCD then libCD:Register(HEALBOT_HEALBOT) end
        end
        HealBot:RegisterEvent("PLAYER_REGEN_DISABLED");
        HealBot:RegisterEvent("PLAYER_REGEN_ENABLED");
        HealBot:RegisterEvent("PLAYER_TARGET_CHANGED");
        HealBot:RegisterEvent("UNIT_HEALTH");
        HealBot:RegisterEvent("UNIT_MAXHEALTH");
        local regPower=false
        for j=1,10 do
            if Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j]["POWERSIZE"]>0 or
               (Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j]["POWERCNT"] and  
               (HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_PALADIN] or HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_MONK])) then
                regPower=true
            end
        end
        if regPower then
            for j=1,10 do
                if Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j]["LOWMANA"]>1 then
                    HealBot_Register_Mana() 
                end
            end
        end
        HealBot:RegisterEvent("LEARNED_SPELL_IN_TAB");
        HealBot:RegisterEvent("UNIT_AURA");
        HealBot:RegisterEvent("CHARACTER_POINTS_CHANGED");
		HealBot:RegisterEvent("INSPECT_READY");
        HealBot:RegisterEvent("CHAT_MSG_SYSTEM");
        HealBot:RegisterEvent("MODIFIER_STATE_CHANGED");
        HealBot:RegisterEvent("UNIT_PET");
        HealBot:RegisterEvent("UNIT_NAME_UPDATE");
        HealBot_Options_RegAggro()

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
        HealBot:RegisterEvent("PLAYER_CONTROL_GAINED");
        HealBot:RegisterEvent("PLAYER_CONTROL_LOST");
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
        if HEALBOT_GAME_VERSION>3 then
            HealBot:UnregisterEvent("PLAYER_FOCUS_CHANGED");
            HealBot:UnregisterEvent("UNIT_ENTERED_VEHICLE");
            HealBot:UnregisterEvent("UNIT_EXITED_VEHICLE");
            HealBot:UnregisterEvent("UNIT_EXITING_VEHICLE");
            HealBot:UnregisterEvent("PLAYER_TALENT_UPDATE");
            HealBot:UnregisterEvent("COMPANION_LEARNED");
        end
        HealBot:UnregisterEvent("ZONE_CHANGED_NEW_AREA");
        HealBot:UnregisterEvent("ZONE_CHANGED");
        HealBot:UnregisterEvent("ZONE_CHANGED_INDOORS");
        HealBot:UnregisterEvent("PLAYER_REGEN_DISABLED");
        HealBot:UnregisterEvent("PLAYER_REGEN_ENABLED");
        HealBot:UnregisterEvent("PLAYER_TARGET_CHANGED");
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
        HealBot:UnregisterEvent("MODIFIER_STATE_CHANGED");
        HealBot:UnregisterEvent("PLAYER_CONTROL_GAINED");
        HealBot:UnregisterEvent("PLAYER_CONTROL_LOST");
        HealBot:UnregisterEvent("UNIT_TARGET")
    end
    if HEALBOT_GAME_VERSION>3 then
        HealBot:UnregisterEvent("PLAYER_SPECIALIZATION_CHANGED");
        HealBot:UnregisterEvent("PET_BATTLE_OPENING_START");
        HealBot:UnregisterEvent("PET_BATTLE_OVER");
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
    HealBot:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
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
        HealBot_setOptions_Timer(7950)
        HealBot_Register_Events()
        HealBot_nextRecalcParty(0)
    else
        for _,xButton in pairs(HealBot_Unit_Button) do
            xButton.update.reset=true
            xButton.status.update=true
        end
    end
  --HealBot_setCall("HealBot_Reset")
end

local function HealBot_OnEvent_UnitNameUpdate(button)
    button.update.unit=true
    button.status.update=true
  --HealBot_setCall("HealBot_OnEvent_UnitNameUpdate")
end

local idGUID,idUnit,idTarget,idFocus,idButton=nil,nil,nil,nil,nil
local function HealBot_UnitID(unit, cExtras)   
    idGUID=UnitGUID(unit)
    idUnit=HealBot_Panel_RaidUnitGUID(idGUID)
    idTarget=false
    idFocus=false
    if idGUID and idUnit then
        if not UnitIsUnit(unit, idUnit) then
            HealBot_UnitID_Mismatch(idUnit)
        elseif cExtras then
            if HealBot_Unit_Button[idUnit] or HealBot_Pet_Button[idUnit] then
                unit=idUnit
            end
            if unit~="target" and HealBot_Unit_Button["target"] then
                idTarget=UnitIsUnit(unit, "target")
            end
            if HEALBOT_GAME_VERSION>3 and unit~="focus" and HealBot_Unit_Button["focus"] then
                idFocus=UnitIsUnit(unit, "focus")
            end
        end
    end
    idButton=HealBot_Unit_Button[unit] or HealBot_Pet_Button[unit]   
    if idButton and idGUID then
        if idButton.guid~=idGUID then HealBot_UnitID_Mismatch(unit) end
        return unit, idGUID, idButton, idTarget, idFocus
    elseif idGUID and idUnit and UnitIsUnit(unit,idUnit) then
        if HealBot_Unit_Button[idUnit] then
            return idUnit, idGUID, HealBot_Unit_Button[idUnit], idTarget, idFocus
        elseif HealBot_Pet_Button[idUnit] then
            return idUnit, idGUID, HealBot_Pet_Button[idUnit], idTarget, idFocus
        end
    end
  --HealBot_setCall("HealBot_UnitID")
    return nil,nil,nil,nil,nil
end

function HealBot_HealsInUpdate(button)
    button.health.updincoming=false
    local ebubar2 = _G["HealBot_Action_HealUnit"..button.id.."Bar2"]
    if button.status.current>3 and button.status.current<9 and button.status.range>0 and UnitExists(button.unit) then
        local healin=0
        if HEALBOT_GAME_VERSION>3 then
            healin=(UnitGetIncomingHeals(button.unit) or 0)
        elseif libCHC then
            healin = (libCHC:GetHealAmount(button.guid, libCHC.ALL_HEALS) or 0) * (libCHC:GetHealModifier(button.guid) or 1)
        end
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

function HealBotClassic_HealsInUpdate(arg1, arg2, arg3, arg4, arg5, ...)
    for i=1, select("#", ...) do
        local targetGUID = select(i, ...)
        if targetGUID and HealBot_Panel_RaidUnitGUID(targetGUID) then
            local _,_,xButton,aTarget,_ = HealBot_UnitID(HealBot_Panel_RaidUnitGUID(targetGUID), true)
            if xButton then
                HealBot_HealsInUpdate(xButton)
            end
            if aTarget then
                HealBot_HealsInUpdate(HealBot_Unit_Button["target"])
            end
        end
    end
end

function HealBot_AbsorbsUpdate(button)
    button.health.updabsorbs=false
    local ebubar6 = _G["HealBot_Action_HealUnit"..button.id.."Bar6"]
    if button.status.current>3 and button.status.current<9 and button.status.range>0 and UnitExists(button.unit) then
        local absorb=0
        if HEALBOT_GAME_VERSION>3 then
            absorb=(UnitGetTotalAbsorbs(button.unit) or 0)
        elseif 1==0 then --libCHC then
            absorb = (libCHC:GetHealAmount(button.guid, libCHC.ABSORB_SHIELDS) or 0)
        end
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

function HealBotClassic_AbsorbsUpdate(arg1, arg2, arg3, arg4, arg5, ...)
    for i=1, select("#", ...) do
        local targetGUID = select(i, ...)
        if targetGUID and HealBot_Panel_RaidUnitGUID(targetGUID) then
            local _,_,xButton,aTarget,_ = HealBot_UnitID(HealBot_Panel_RaidUnitGUID(targetGUID), true)
            if xButton then
                HealBot_AbsorbsUpdate(xButton)
            end
            if aTarget then
                HealBot_AbsorbsUpdate(HealBot_Unit_Button["target"])
            end
        end
    end
end

function HealBot_Player_CheckTime(button)
    HealBot_luVars["RangeCheckTime"]=HealBot_luVars["RangeCheckTime"]+(HealBot_Timers["CheckTimeMod"])
    if HealBot_luVars["RangeCheckTime"]<TimeNow then
        HealBot_luVars["RangeCheckTime"]=TimeNow+0.02
    end
    button.checks.timed=HealBot_luVars["RangeCheckTime"]
    --HealBot_setCall("HealBot_Player_CheckTime")
end

function HealBot_Enemy_CheckTime(button)
    HealBot_luVars["EnemyCheckTime"]=HealBot_luVars["EnemyCheckTime"]+0.025
    if HealBot_luVars["EnemyCheckTime"]<TimeNow then
        HealBot_luVars["EnemyCheckTime"]=TimeNow+0.05
    end
    button.checks.timed=HealBot_luVars["EnemyCheckTime"]
    --HealBot_setCall("HealBot_Enemy_CheckTime")
end

function HealBot_Pet_CheckTime(button)
    HealBot_luVars["PetRangeCheckTime"]=HealBot_luVars["PetRangeCheckTime"]+(HealBot_Timers["CheckTimeMod"] * 2)
    if HealBot_luVars["PetRangeCheckTime"]<TimeNow then
        HealBot_luVars["PetRangeCheckTime"]=TimeNow+0.04
    end
    button.checks.timed=HealBot_luVars["PetRangeCheckTime"]
    --HealBot_setCall("HealBot_Pet_CheckTime")
end

local function HealBot_DoUnitNameUpdate(unUnit,unGUID)
    if unGUID then
        if unGUID==HealBot_Data["PGUID"] then 
            unUnit="player" 
        elseif unUnit=="target" then
            unUnit=HealBot_Panel_RaidUnitGUID(unGUID) or "target"
        end
    end
    if HealBot_Unit_Button[unUnit] then
        local unb=HealBot_Unit_Button[unUnit]
        local doUpdate=false
        if unGUID then
            if not HealBot_Panel_RaidUnitGUID(unGUID) then
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
        unb.guid=unGUID or UnitGUID(unUnit) or unUnit or "nk"
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
    HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol=HealBot_Options_copyTable(HealBot_GlobalsDefaults.HealBot_Custom_Debuffs_ShowBarCol)
    HealBot_Options_NewCDebuff:SetText("")
    HealBot_Options_InitSub(407)
    HealBot_Options_InitSub(408)
    HealBot_Options_InitSub(419)
    HealBot_SetCDCBarColours();
    HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_CONFIRMCUSTOMDEFAULTS)
    HealBot_Reset_AutoUpdateDebuffIDs()
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

HealBot_luVars["FadeTimeDiv"]=18
local function HealBot_Icon_AlphaValue(secLeft, curFrame)
    if secLeft>=0 then
        if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][curFrame]["FADE"] and 
           secLeft<Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][curFrame]["FADESECS"] then
            return (secLeft/HealBot_luVars["FadeTimeDiv"])+.1
        else
            return 1
        end
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
    HealBot_UpdateIcon(button, iconData)
  --HealBot_setCall("HealBot_AddIcon")
end

local function HealBot_RaidTargetUpdate(button, iconID)
    local prevId=button.icon.debuff.targeticon
    button.icon.debuff.targeticon=iconID
    if button.icon.debuff.targeticon~=prevId then
        button.aura.debuff.check=true
    end
  --HealBot_setCall("HealBot_RaidTargetUpdate")
end

function HealBot_setUnitIcons(unit, guid)
    if not HealBot_UnitDebuffIcons[unit] then HealBot_UnitDebuffIcons[unit]={} end
    if not HealBot_UnitBuffIcons[unit] then HealBot_UnitBuffIcons[unit]={} end
  --HealBot_setCall("HealBot_setUnitIcons")
end

local function HealBot_Reset_Button(button)
    button.update.reset=true
    button.status.update=true
    HealBot_Action_ResetUnitStatus(button)
    if HealBot_Action_AlwaysEnabled(button.guid) then HealBot_Action_Toggle_Enabled(button); end
end

function HealBot_Reset_Unit(unit)
    local _,_,xButton,aTarget,aFocus = HealBot_UnitID(unit, true)
    if xButton then
        HealBot_Reset_Button(xButton)
    end
    if aTarget then
        HealBot_Reset_Button(HealBot_Unit_Button["target"])
    end
    if aFocus then
        HealBot_Reset_Button(HealBot_Unit_Button["focus"])
    end
  --HealBot_setCall("HealBot_Reset_Unit")
end

function HealBot_KnownSpell(spellID)
    if not spellID then return nil end
    if HealBot_Spell_IDs[spellID] and HealBot_Spell_IDs[spellID].known then   
        return HealBot_Spell_IDs[spellID].name; 
    else
        local sName=GetSpellInfo(spellID)
        if sName and HealBot_Spell_Names[sName] then
            return sName
        end
    end
  --HealBot_setCall("HealBot_KnownSpell")
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
    if HealBot_Panel_RaidUnitGUID(destGUID) then
        local xButton=HealBot_Unit_Button[HealBot_Panel_RaidUnitGUID(destGUID)]
        if xButton then
            if (event == "UNIT_DIED") then
                HealBot_Action_UpdateTheDeadButton(button)
            elseif (event=="SWING_DAMAGE" or event=="SPELL_PERIODIC_DAMAGE" or event=="SPELL_DAMAGE" or event=="DAMAGE_SPLIT" or
                event=="DAMAGE_SHIELD" or event=="ENVIRONMENTAL_DAMAGE") and xButton.health.current > 0 then
                xButton.health.updhealth=true
                xButton.health.update=true
            elseif (event=="SPELL_HEAL" or event=="SPELL_PERIODIC_HEAL") and xButton.health.current < xButton.health.max then
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
        HealBot_Timers["HB1Th"]=HealBot_Comm_round((1+(HealBot_Globals.RangeCheckFreq*16))/(HealBot_luVars["qaFR"]/4), 4)
        HealBot_Timers["HB2Th"]=HealBot_Comm_round((HealBot_Globals.RangeCheckFreq*4)/(HealBot_luVars["qaFR"]/2), 4)
        HealBot_Timers["HBaTh"]=0.01+(HealBot_Globals.RangeCheckFreq/8)
    else
        HealBot_Timers["HB1Th"]=1
        HealBot_Timers["HB2Th"]=1
        HealBot_Timers["HBaTh"]=10
    end
    HealBot_setTooltipUpdateInterval()
    HealBot_CheckTime_Modifier()
    --HealBot_AddDebug("HB2Th="..HealBot_Timers["HB2Th"])
  --HealBot_setCall("HealBot_Set_Timers")
end

local HealBot_Options_Timer={}
function HealBot_setOptions_Timer(value)
    HealBot_luVars["HealBot_Options_Timer"]=true
    HealBot_Options_Timer[value]=true
  --HealBot_setCall("HealBot_setOptions_Timer")
  --HealBot_setCall("HealBot_setOptions_Timer-"..value)
end

local HealBot_ErrorNum=0

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
    if Healbot_Config_Skins.ExtraIncGroup then Healbot_Config_Skins.ExtraIncGroup=nil end
    if Healbot_Config_Skins.BarsHide then Healbot_Config_Skins.BarsHide=nil end
    if Healbot_Config_Skins.EmergIncMonitor then Healbot_Config_Skins.EmergIncMonitor=nil end
    
    if not HealBot_Config.SkinDefault[SkinName] then HealBot_Config.SkinDefault[SkinName]={} end
    if HealBot_Config.SkinDefault[SkinName][HEALBOT_WORD_SOLO]==nil then HealBot_Config.SkinDefault[SkinName][HEALBOT_WORD_SOLO]=false end
    if HealBot_Config.SkinDefault[SkinName][HEALBOT_WORD_PARTY]==nil then HealBot_Config.SkinDefault[SkinName][HEALBOT_WORD_PARTY]=false end
    if HealBot_Config.SkinDefault[SkinName][HEALBOT_OPTIONS_RAID10]==nil then HealBot_Config.SkinDefault[SkinName][HEALBOT_OPTIONS_RAID10]=false end
    if HealBot_Config.SkinDefault[SkinName][HEALBOT_OPTIONS_RAID25]==nil then HealBot_Config.SkinDefault[SkinName][HEALBOT_OPTIONS_RAID25]=false end
    if HealBot_Config.SkinDefault[SkinName][HEALBOT_OPTIONS_RAID40]==nil then HealBot_Config.SkinDefault[SkinName][HEALBOT_OPTIONS_RAID40]=false end
    if HealBot_Config.SkinDefault[SkinName][HEALBOT_WORD_ARENA]==nil then HealBot_Config.SkinDefault[SkinName][HEALBOT_WORD_ARENA]=false end
    if HealBot_Config.SkinDefault[SkinName][HEALBOT_WORD_BG10]==nil then HealBot_Config.SkinDefault[SkinName][HEALBOT_WORD_BG10]=false end
    if HealBot_Config.SkinDefault[SkinName][HEALBOT_WORD_BG15]==nil then HealBot_Config.SkinDefault[SkinName][HEALBOT_WORD_BG15]=false end
    if HealBot_Config.SkinDefault[SkinName][HEALBOT_WORD_BG40]==nil then HealBot_Config.SkinDefault[SkinName][HEALBOT_WORD_BG40]=false end
    if HealBot_Config.SkinDefault[SkinName][HEALBOT_WORD_PETBATTLE]==nil then HealBot_Config.SkinDefault[SkinName][HEALBOT_WORD_PETBATTLE]=false end
    
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
        for id=1,11 do
            if Healbot_Config_Skins.HealGroups[SkinName][id]["NAME"]=="Targets" then
                Healbot_Config_Skins.HealGroups[SkinName][id]["NAME"]=HEALBOT_OPTIONS_TARGETHEALS
                break
            end
        end
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
    if not Healbot_Config_Skins.FrameAliasBar[SkinName] then Healbot_Config_Skins.FrameAliasBar[SkinName]={} end
    if not Healbot_Config_Skins.HealBar[SkinName] then Healbot_Config_Skins.HealBar[SkinName]={} end
    if not Healbot_Config_Skins.BarCol[SkinName] then Healbot_Config_Skins.BarCol[SkinName]={} end
    if not Healbot_Config_Skins.BarIACol[SkinName] then Healbot_Config_Skins.BarIACol[SkinName]={} end
    if not Healbot_Config_Skins.BarText[SkinName] then Healbot_Config_Skins.BarText[SkinName]={} end
    if not Healbot_Config_Skins.BarTextCol[SkinName] then Healbot_Config_Skins.BarTextCol[SkinName]={} end
    if not Healbot_Config_Skins.Icons[SkinName] then Healbot_Config_Skins.Icons[SkinName]={} end
    if not Healbot_Config_Skins.RaidIcon[SkinName] then Healbot_Config_Skins.RaidIcon[SkinName]={} end
    if not Healbot_Config_Skins.IconText[SkinName] then Healbot_Config_Skins.IconText[SkinName]={} end
    if not Healbot_Config_Skins.Protection[SkinName] then Healbot_Config_Skins.Protection[SkinName]={} end
    if not Healbot_Config_Skins.Frame[SkinName] then Healbot_Config_Skins.Frame[SkinName]={} end
    if not Healbot_Config_Skins.StickyFrames[SkinName] then Healbot_Config_Skins.StickyFrames[SkinName]={} end
    if not Healbot_Config_Skins.Healing[SkinName] then Healbot_Config_Skins.Healing[SkinName]={} end
    if not Healbot_Config_Skins.General[SkinName] then Healbot_Config_Skins.General[SkinName]={} end
    if not Healbot_Config_Skins.BarSort[SkinName] then Healbot_Config_Skins.BarSort[SkinName]={} end
    if not Healbot_Config_Skins.Chat[SkinName] then Healbot_Config_Skins.Chat[SkinName]={} end
    if not Healbot_Config_Skins.Enemy[SkinName] then Healbot_Config_Skins.Enemy[SkinName]={} end
    if not Healbot_Config_Skins.IncludeGroup[SkinName] then Healbot_Config_Skins.IncludeGroup[SkinName]={} end
    if not Healbot_Config_Skins.BarVisibility[SkinName] then Healbot_Config_Skins.BarVisibility[SkinName]={} end
    if not Healbot_Config_Skins.BarAggro[SkinName] then Healbot_Config_Skins.BarAggro[SkinName]={} end
    if not Healbot_Config_Skins.BarHighlight[SkinName] then Healbot_Config_Skins.BarHighlight[SkinName]={} end
    for gl=1,10 do
        if not Healbot_Config_Skins.HeadText[SkinName][gl] then Healbot_Config_Skins.HeadText[SkinName][gl]={} end
        if not Healbot_Config_Skins.HeadBar[SkinName][gl] then Healbot_Config_Skins.HeadBar[SkinName][gl]={} end
        if not Healbot_Config_Skins.Anchors[SkinName][gl] then Healbot_Config_Skins.Anchors[SkinName][gl]={} end
        if not Healbot_Config_Skins.FrameAlias[SkinName][gl] then Healbot_Config_Skins.FrameAlias[SkinName][gl]={} end
        if not Healbot_Config_Skins.FrameAliasBar[SkinName][gl] then Healbot_Config_Skins.FrameAliasBar[SkinName][gl]={} end
        if not Healbot_Config_Skins.HealBar[SkinName][gl] then Healbot_Config_Skins.HealBar[SkinName][gl]={} end
        if not Healbot_Config_Skins.BarCol[SkinName][gl] then Healbot_Config_Skins.BarCol[SkinName][gl]={} end
        if not Healbot_Config_Skins.BarIACol[SkinName][gl] then Healbot_Config_Skins.BarIACol[SkinName][gl]={} end
        if not Healbot_Config_Skins.BarText[SkinName][gl] then Healbot_Config_Skins.BarText[SkinName][gl]={} end
        if not Healbot_Config_Skins.BarTextCol[SkinName][gl] then Healbot_Config_Skins.BarTextCol[SkinName][gl]={} end
        if not Healbot_Config_Skins.Icons[SkinName][gl] then Healbot_Config_Skins.Icons[SkinName][gl]={} end
        if not Healbot_Config_Skins.RaidIcon[SkinName][gl] then Healbot_Config_Skins.RaidIcon[SkinName][gl]={} end
        if not Healbot_Config_Skins.IconText[SkinName][gl] then Healbot_Config_Skins.IconText[SkinName][gl]={} end
        if not Healbot_Config_Skins.Frame[SkinName][gl] then Healbot_Config_Skins.Frame[SkinName][gl]={} end
        if not Healbot_Config_Skins.StickyFrames[SkinName][gl] then Healbot_Config_Skins.StickyFrames[SkinName][gl]={} end
        if not Healbot_Config_Skins.IncludeGroup[SkinName][gl] then Healbot_Config_Skins.IncludeGroup[SkinName][gl]={} end
        if not Healbot_Config_Skins.BarVisibility[SkinName][gl] then Healbot_Config_Skins.BarVisibility[SkinName][gl]={} end
        if not Healbot_Config_Skins.BarSort[SkinName][gl] then Healbot_Config_Skins.BarSort[SkinName][gl]={} end
        if not Healbot_Config_Skins.BarAggro[SkinName][gl] then Healbot_Config_Skins.BarAggro[SkinName][gl]={} end
        if not Healbot_Config_Skins.BarHighlight[SkinName][gl] then Healbot_Config_Skins.BarHighlight[SkinName][gl]={} end
    end

    for gl=1,10 do
        for g=1,8 do
            if Healbot_Config_Skins.IncludeGroup[SkinName][gl][g]==nil then Healbot_Config_Skins.IncludeGroup[SkinName][gl][g]=true end
        end
        if Healbot_Config_Skins.BarVisibility[SkinName][gl]["ALERTIC"]==nil then
            Healbot_Config_Skins.BarVisibility[SkinName][gl]["ALERTIC"]=Healbot_Config_Skins.Healing[SkinName]["ALERTIC"] or 0.98
        end
        if Healbot_Config_Skins.BarVisibility[SkinName][gl]["ALERTOC"]==nil then
            Healbot_Config_Skins.BarVisibility[SkinName][gl]["ALERTOC"]=Healbot_Config_Skins.Healing[SkinName]["ALERTOC"] or 0.9
        end
        if Healbot_Config_Skins.BarSort[SkinName][gl]["RAIDORDER"]==nil then 
            if Healbot_Config_Skins.Sort and Healbot_Config_Skins.Sort[SkinName] then
                Healbot_Config_Skins.BarSort[SkinName][gl]["RAIDORDER"]=Healbot_Config_Skins.Sort[SkinName]["RAIDORDER"] or 3
            else
                Healbot_Config_Skins.BarSort[SkinName][gl]["RAIDORDER"]=3
            end
        end
        if Healbot_Config_Skins.BarSort[SkinName][gl]["SUBORDER"]==nil then 
            if Healbot_Config_Skins.Sort and Healbot_Config_Skins.Sort[SkinName] then
                Healbot_Config_Skins.BarSort[SkinName][gl]["SUBORDER"]=Healbot_Config_Skins.Sort[SkinName]["SUBORDER"] or 1
            else
                Healbot_Config_Skins.BarSort[SkinName][gl]["SUBORDER"]=1
            end
        end
        if Healbot_Config_Skins.BarSort[SkinName][gl]["OORLAST"]==nil then 
            if Healbot_Config_Skins.Sort and Healbot_Config_Skins.Sort[SkinName] then
                Healbot_Config_Skins.BarSort[SkinName][gl]["OORLAST"]=Healbot_Config_Skins.Sort[SkinName]["OORLAST"] or false
            else
                Healbot_Config_Skins.BarSort[SkinName][gl]["OORLAST"]=false
            end
        end
        if Healbot_Config_Skins.BarSort[SkinName][gl]["SUBPF"]==nil then 
            if Healbot_Config_Skins.Sort and Healbot_Config_Skins.Sort[SkinName] then
                Healbot_Config_Skins.BarSort[SkinName][gl]["SUBPF"]=Healbot_Config_Skins.Sort[SkinName]["SUBPF"] or true
            else
                Healbot_Config_Skins.BarSort[SkinName][gl]["SUBPF"]=true
            end
        end
        if Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOW"]==nil then 
            if Healbot_Config_Skins.Aggro and Healbot_Config_Skins.Aggro[SkinName] then 
                Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOW"]=Healbot_Config_Skins.Aggro[SkinName]["SHOW"] or true
            else
                Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOW"]=true
            end
        end
        if Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOWBARS"]==nil then 
            if Healbot_Config_Skins.Aggro and Healbot_Config_Skins.Aggro[SkinName] then 
                Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOWBARS"]=Healbot_Config_Skins.Aggro[SkinName]["SHOWBARS"] or true
            else
                Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOWBARS"]=true
            end
        end
        if Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOWTEXT"]==nil then 
            if Healbot_Config_Skins.Aggro and Healbot_Config_Skins.Aggro[SkinName] then 
                Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOWTEXT"]=Healbot_Config_Skins.Aggro[SkinName]["SHOWTEXT"] or true
            else
                Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOWTEXT"]=true
            end
        end
        if Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOWIND"]==nil then 
            if Healbot_Config_Skins.Aggro and Healbot_Config_Skins.Aggro[SkinName] then 
                Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOWIND"]=Healbot_Config_Skins.Aggro[SkinName]["SHOWIND"] or true
            else
                Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOWIND"]=true
            end
        end
        if Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOWBARSPCT"]==nil then 
            if Healbot_Config_Skins.Aggro and Healbot_Config_Skins.Aggro[SkinName] then 
                Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOWBARSPCT"]=Healbot_Config_Skins.Aggro[SkinName]["SHOWBARSPCT"] or false
            else
                Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOWBARSPCT"]=false
            end
        end
        if Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOWTEXTPCT"]==nil then 
            if Healbot_Config_Skins.Aggro and Healbot_Config_Skins.Aggro[SkinName] then 
                Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOWTEXTPCT"]=Healbot_Config_Skins.Aggro[SkinName]["SHOWTEXTPCT"] or true
            else
                Healbot_Config_Skins.BarAggro[SkinName][gl]["SHOWTEXTPCT"]=true
            end
        end
        if not Healbot_Config_Skins.BarAggro[SkinName][gl]["FREQ"] then 
            if Healbot_Config_Skins.Aggro and Healbot_Config_Skins.Aggro[SkinName] then 
                Healbot_Config_Skins.BarAggro[SkinName][gl]["FREQ"]=Healbot_Config_Skins.Aggro[SkinName]["FREQ"] or 0.03
            else
                Healbot_Config_Skins.BarAggro[SkinName][gl]["FREQ"]=0.03
            end
        end
        if not Healbot_Config_Skins.BarAggro[SkinName][gl]["MAXA"] then 
            if Healbot_Config_Skins.Aggro and Healbot_Config_Skins.Aggro[SkinName] then 
                Healbot_Config_Skins.BarAggro[SkinName][gl]["MAXA"]=Healbot_Config_Skins.Aggro[SkinName]["MAXA"] or 1
            else
                Healbot_Config_Skins.BarAggro[SkinName][gl]["MAXA"]=1
            end
        end
        if not Healbot_Config_Skins.BarAggro[SkinName][gl]["MINA"] then 
            if Healbot_Config_Skins.Aggro and Healbot_Config_Skins.Aggro[SkinName] then 
                Healbot_Config_Skins.BarAggro[SkinName][gl]["MINA"]=Healbot_Config_Skins.Aggro[SkinName]["MINA"] or 0.2
            else
                Healbot_Config_Skins.BarAggro[SkinName][gl]["MINA"]=0.2
            end
        end
        if not Healbot_Config_Skins.BarAggro[SkinName][gl]["ALERT"] then Healbot_Config_Skins.BarAggro[SkinName][gl]["ALERT"]=2 end
        if not Healbot_Config_Skins.BarAggro[SkinName][gl]["ALERTIND"] then 
            if Healbot_Config_Skins.Aggro and Healbot_Config_Skins.Aggro[SkinName] then 
                Healbot_Config_Skins.BarAggro[SkinName][gl]["ALERTIND"]=Healbot_Config_Skins.Aggro[SkinName]["ALERTIND"] or 2
            else
                Healbot_Config_Skins.BarAggro[SkinName][gl]["ALERTIND"]=2
            end
        end
        if not Healbot_Config_Skins.BarAggro[SkinName][gl]["R"] then 
            if Healbot_Config_Skins.Aggro and Healbot_Config_Skins.Aggro[SkinName] then 
                Healbot_Config_Skins.BarAggro[SkinName][gl]["R"]=Healbot_Config_Skins.Aggro[SkinName]["R"] or 1
            else
                Healbot_Config_Skins.BarAggro[SkinName][gl]["R"]=1
            end
        end
        if not Healbot_Config_Skins.BarAggro[SkinName][gl]["G"] then 
            if Healbot_Config_Skins.Aggro and Healbot_Config_Skins.Aggro[SkinName] then 
                Healbot_Config_Skins.BarAggro[SkinName][gl]["G"]=Healbot_Config_Skins.Aggro[SkinName]["G"] or 0
            else
                Healbot_Config_Skins.BarAggro[SkinName][gl]["G"]=0
            end
        end
        if not Healbot_Config_Skins.BarAggro[SkinName][gl]["B"] then 
            if Healbot_Config_Skins.Aggro and Healbot_Config_Skins.Aggro[SkinName] then 
                Healbot_Config_Skins.BarAggro[SkinName][gl]["B"]=Healbot_Config_Skins.Aggro[SkinName]["B"] or 0
            else
                Healbot_Config_Skins.BarAggro[SkinName][gl]["B"]=0
            end
        end
        if not Healbot_Config_Skins.BarAggro[SkinName][gl]["TEXTFORMAT"] then 
            if Healbot_Config_Skins.Aggro and Healbot_Config_Skins.Aggro[SkinName] then 
                Healbot_Config_Skins.BarAggro[SkinName][gl]["TEXTFORMAT"]=Healbot_Config_Skins.Aggro[SkinName]["TEXTFORMAT"] or 3
            else
                Healbot_Config_Skins.BarAggro[SkinName][gl]["TEXTFORMAT"]=3
            end
        end
        if Healbot_Config_Skins.BarHighlight[SkinName][gl]["CBAR"]==nil then 
            if Healbot_Config_Skins.Highlight and Healbot_Config_Skins.Highlight[SkinName] then 
                Healbot_Config_Skins.BarHighlight[SkinName][gl]["CBAR"]=Healbot_Config_Skins.Highlight[SkinName]["CBAR"] or true
            else
                Healbot_Config_Skins.BarHighlight[SkinName][gl]["CBAR"]=true
            end
        end
        if Healbot_Config_Skins.BarHighlight[SkinName][gl]["CBARCOMBAT"]==nil then 
            if Healbot_Config_Skins.Highlight and Healbot_Config_Skins.Highlight[SkinName] then 
                Healbot_Config_Skins.BarHighlight[SkinName][gl]["CBARCOMBAT"]=Healbot_Config_Skins.Highlight[SkinName]["CBARCOMBAT"] or false
            else
                Healbot_Config_Skins.BarHighlight[SkinName][gl]["CBARCOMBAT"]=false
            end
        end
        if Healbot_Config_Skins.BarHighlight[SkinName][gl]["TBAR"]==nil then 
            if Healbot_Config_Skins.Highlight and Healbot_Config_Skins.Highlight[SkinName] then 
                Healbot_Config_Skins.BarHighlight[SkinName][gl]["TBAR"]=Healbot_Config_Skins.Highlight[SkinName]["TBAR"] or false
            else
                Healbot_Config_Skins.BarHighlight[SkinName][gl]["TBAR"]=false
            end
        end
        if Healbot_Config_Skins.BarHighlight[SkinName][gl]["TBARCOMBAT"]==nil then 
            if Healbot_Config_Skins.Highlight and Healbot_Config_Skins.Highlight[SkinName] then 
                Healbot_Config_Skins.BarHighlight[SkinName][gl]["TBARCOMBAT"]=Healbot_Config_Skins.Highlight[SkinName]["TBARCOMBAT"] or false
            else
                Healbot_Config_Skins.BarHighlight[SkinName][gl]["TBARCOMBAT"]=false
            end
        end
        if not Healbot_Config_Skins.BarHighlight[SkinName][gl]["CR"] then 
            if Healbot_Config_Skins.Highlight and Healbot_Config_Skins.Highlight[SkinName] then 
                Healbot_Config_Skins.BarHighlight[SkinName][gl]["CR"]=Healbot_Config_Skins.Highlight[SkinName]["CR"] or 1
            else
                Healbot_Config_Skins.BarHighlight[SkinName][gl]["CR"]=1
            end
        end
        if not Healbot_Config_Skins.BarHighlight[SkinName][gl]["CG"] then 
            if Healbot_Config_Skins.Highlight and Healbot_Config_Skins.Highlight[SkinName] then 
                Healbot_Config_Skins.BarHighlight[SkinName][gl]["CG"]=Healbot_Config_Skins.Highlight[SkinName]["CG"] or 1
            else
                Healbot_Config_Skins.BarHighlight[SkinName][gl]["CG"]=1
            end
        end
        if not Healbot_Config_Skins.BarHighlight[SkinName][gl]["CB"] then 
            if Healbot_Config_Skins.Highlight and Healbot_Config_Skins.Highlight[SkinName] then 
                Healbot_Config_Skins.BarHighlight[SkinName][gl]["CB"]=Healbot_Config_Skins.Highlight[SkinName]["CB"] or 0.7
            else
                Healbot_Config_Skins.BarHighlight[SkinName][gl]["CB"]=0.7
            end
        end
        if not Healbot_Config_Skins.BarHighlight[SkinName][gl]["TR"] then 
            if Healbot_Config_Skins.Highlight and Healbot_Config_Skins.Highlight[SkinName] then 
                Healbot_Config_Skins.BarHighlight[SkinName][gl]["TR"]=Healbot_Config_Skins.Highlight[SkinName]["TR"] or 0.8
            else
                Healbot_Config_Skins.BarHighlight[SkinName][gl]["TR"]=0.8
            end
        end
        if not Healbot_Config_Skins.BarHighlight[SkinName][gl]["TG"] then 
            if Healbot_Config_Skins.Highlight and Healbot_Config_Skins.Highlight[SkinName] then 
                Healbot_Config_Skins.BarHighlight[SkinName][gl]["TG"]=Healbot_Config_Skins.Highlight[SkinName]["TG"] or 0.8
            else
                Healbot_Config_Skins.BarHighlight[SkinName][gl]["TG"]=0.8
            end
        end
        if not Healbot_Config_Skins.BarHighlight[SkinName][gl]["TB"] then 
            if Healbot_Config_Skins.Highlight and Healbot_Config_Skins.Highlight[SkinName] then 
                Healbot_Config_Skins.BarHighlight[SkinName][gl]["TB"]=Healbot_Config_Skins.Highlight[SkinName]["TB"] or 0.7
            else
                Healbot_Config_Skins.BarHighlight[SkinName][gl]["TB"]=0.7
            end
        end
        if Healbot_Config_Skins.BarVisibility[SkinName][gl]["HIDEOOR"]==nil then Healbot_Config_Skins.BarVisibility[SkinName][gl]["HIDEOOR"]=false end
        if Healbot_Config_Skins.BarVisibility[SkinName][gl]["INCCLASSES"]==nil then Healbot_Config_Skins.BarVisibility[SkinName][gl]["INCCLASSES"]=1 end
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
        if Healbot_Config_Skins.Frame[SkinName][gl]["SFOFFSETH"]==nil then Healbot_Config_Skins.Frame[SkinName][gl]["SFOFFSETH"]=0 end
        if Healbot_Config_Skins.Frame[SkinName][gl]["SFOFFSETV"]==nil then Healbot_Config_Skins.Frame[SkinName][gl]["SFOFFSETV"]=0 end
        if Healbot_Config_Skins.StickyFrames[SkinName][gl]["STUCK"]==nil then Healbot_Config_Skins.StickyFrames[SkinName][gl]["STUCK"]=false end
        if Healbot_Config_Skins.StickyFrames[SkinName][gl]["STUCKTO"]==nil then Healbot_Config_Skins.StickyFrames[SkinName][gl]["STUCKTO"]=0 end
        if Healbot_Config_Skins.StickyFrames[SkinName][gl]["STUCKPOINT"]==nil then Healbot_Config_Skins.StickyFrames[SkinName][gl]["STUCKPOINT"]="NONE" end
        if Healbot_Config_Skins.StickyFrames[SkinName][gl]["STUCKTOPOINT"]==nil then Healbot_Config_Skins.StickyFrames[SkinName][gl]["STUCKTOPOINT"]="NONE" end
        if Healbot_Config_Skins.IconText[SkinName][gl]["DURTHRH"]==nil then Healbot_Config_Skins.IconText[SkinName][gl]["DURTHRH"]=9 end
        if Healbot_Config_Skins.IconText[SkinName][gl]["DURWARN"]==nil then Healbot_Config_Skins.IconText[SkinName][gl]["DURWARN"]=3 end
        if Healbot_Config_Skins.IconText[SkinName][gl]["SCNT"]==nil then Healbot_Config_Skins.IconText[SkinName][gl]["SCNT"]=true end
        if Healbot_Config_Skins.IconText[SkinName][gl]["SSCNT"]==nil then Healbot_Config_Skins.IconText[SkinName][gl]["SSCNT"]=false end
        if Healbot_Config_Skins.IconText[SkinName][gl]["SDUR"]==nil then Healbot_Config_Skins.IconText[SkinName][gl]["SDUR"]=true end
        if Healbot_Config_Skins.IconText[SkinName][gl]["SSDUR"]==nil then Healbot_Config_Skins.IconText[SkinName][gl]["SSDUR"]=true end
        if Healbot_Config_Skins.IconText[SkinName][gl]["FONT"]==nil then Healbot_Config_Skins.IconText[SkinName][gl]["FONT"]=HealBot_Default_Font end
        if Healbot_Config_Skins.IconText[SkinName][gl]["OUTLINE"]==nil then Healbot_Config_Skins.IconText[SkinName][gl]["OUTLINE"]=2 end
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
        if Healbot_Config_Skins.Icons[SkinName][gl]["DSCALE"]==nil then 
            Healbot_Config_Skins.Icons[SkinName][gl]["DSCALE"]=Healbot_Config_Skins.Icons[SkinName][gl]["SCALE"]
        end
        if Healbot_Config_Skins.Icons[SkinName][gl]["I15EN"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["I15EN"]=true end
        if Healbot_Config_Skins.Icons[SkinName][gl]["SHOWBUFF"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["SHOWBUFF"]=true end
        if Healbot_Config_Skins.Icons[SkinName][gl]["POSITION"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["POSITION"]=2 end
        if Healbot_Config_Skins.Icons[SkinName][gl]["FADE"]==nil then Healbot_Config_Skins.Icons[SkinName][gl]["FADE"]=true end
        if not Healbot_Config_Skins.Icons[SkinName][gl]["FADESECS"] then Healbot_Config_Skins.Icons[SkinName][gl]["FADESECS"]=15 end
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
        if Healbot_Config_Skins.BarText[SkinName][gl]["OFFSET"]==nil then Healbot_Config_Skins.BarText[SkinName][gl]["OFFSET"]=0 end
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
        if Healbot_Config_Skins.HeadText[SkinName][gl]["OFFSET"]==nil then Healbot_Config_Skins.HeadText[SkinName][gl]["OFFSET"]=0 end
        if Healbot_Config_Skins.HeadText[SkinName][gl]["R"]==nil then Healbot_Config_Skins.HeadText[SkinName][gl]["R"]=1 end
        if Healbot_Config_Skins.HeadText[SkinName][gl]["G"]==nil then Healbot_Config_Skins.HeadText[SkinName][gl]["G"]=1 end
        if Healbot_Config_Skins.HeadText[SkinName][gl]["B"]==nil then Healbot_Config_Skins.HeadText[SkinName][gl]["B"]=0.1 end
        if Healbot_Config_Skins.HeadText[SkinName][gl]["A"]==nil then Healbot_Config_Skins.HeadText[SkinName][gl]["A"]=0.7 end
        if Healbot_Config_Skins.HeadBar[SkinName][gl]["SHOW"]==nil then Healbot_Config_Skins.HeadBar[SkinName][gl]["SHOW"]=false end
        if Healbot_Config_Skins.HeadBar[SkinName][gl]["TEXTURE"]==nil then Healbot_Config_Skins.HeadBar[SkinName][gl]["TEXTURE"]=HealBot_Default_Textures[10].name end
        if Healbot_Config_Skins.HeadBar[SkinName][gl]["WIDTH"]==nil then Healbot_Config_Skins.HeadBar[SkinName][gl]["WIDTH"]=0.7 end
        if Healbot_Config_Skins.HeadBar[SkinName][gl]["HEIGHT"]==nil then 
            Healbot_Config_Skins.HeadBar[SkinName][gl]["HEIGHT"]=20 
        elseif Healbot_Config_Skins.HeadBar[SkinName][gl]["HEIGHT"]<2 then
            local bheight=(Healbot_Config_Skins.HealBar[SkinName][gl]["HEIGHT"]+Healbot_Config_Skins.HealBar[SkinName][gl]["POWERSIZE"])
            Healbot_Config_Skins.HeadBar[SkinName][gl]["HEIGHT"]=ceil(bheight*Healbot_Config_Skins.HeadBar[SkinName][gl]["HEIGHT"])
        end
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
        if Healbot_Config_Skins.HealBar[SkinName][gl]["LOWMANA"]==nil then 
            if Healbot_Config_Skins.General[SkinName]["LOWMANA"] then
                Healbot_Config_Skins.HealBar[SkinName][gl]["LOWMANA"]=Healbot_Config_Skins.General[SkinName]["LOWMANA"]
            else
                Healbot_Config_Skins.HealBar[SkinName][gl]["LOWMANA"]=1
            end
        end
        if Healbot_Config_Skins.HealBar[SkinName][gl]["LOWMANACOMBAT"]==nil then 
            if Healbot_Config_Skins.General[SkinName]["LOWMANACOMBAT"] then
                Healbot_Config_Skins.HealBar[SkinName][gl]["LOWMANACOMBAT"]=Healbot_Config_Skins.General[SkinName]["LOWMANACOMBAT"]
            else
                Healbot_Config_Skins.HealBar[SkinName][gl]["LOWMANACOMBAT"]=true
            end
        end
        if Healbot_Config_Skins.Anchors[SkinName][gl]["FRAME"]==nil then Healbot_Config_Skins.Anchors[SkinName][gl]["FRAME"]=1 end
        if Healbot_Config_Skins.Anchors[SkinName][gl]["BARS"]==nil then Healbot_Config_Skins.Anchors[SkinName][gl]["BARS"]=1 end
        if Healbot_Config_Skins.Anchors[SkinName][gl]["GROW"]==nil then Healbot_Config_Skins.Anchors[SkinName][gl]["GROW"]=2 end
        if Healbot_Config_Skins.FrameAlias[SkinName][gl]["NAME"]==nil then Healbot_Config_Skins.FrameAlias[SkinName][gl]["NAME"]="" end
        if Healbot_Config_Skins.FrameAlias[SkinName][gl]["SHOW"]==nil then Healbot_Config_Skins.FrameAlias[SkinName][gl]["SHOW"]=false end
        if Healbot_Config_Skins.FrameAlias[SkinName][gl]["FONT"]==nil then Healbot_Config_Skins.FrameAlias[SkinName][gl]["FONT"]=HealBot_Default_Font end
        if Healbot_Config_Skins.FrameAlias[SkinName][gl]["SIZE"]==nil then Healbot_Config_Skins.FrameAlias[SkinName][gl]["SIZE"]=12 end
        if Healbot_Config_Skins.FrameAlias[SkinName][gl]["OUTLINE"]==nil then Healbot_Config_Skins.FrameAlias[SkinName][gl]["OUTLINE"]=1 end
        if Healbot_Config_Skins.FrameAlias[SkinName][gl]["OFFSET"]==nil then Healbot_Config_Skins.FrameAlias[SkinName][gl]["OFFSET"]=0 end
        if Healbot_Config_Skins.FrameAlias[SkinName][gl]["R"]==nil then Healbot_Config_Skins.FrameAlias[SkinName][gl]["R"]=1 end
        if Healbot_Config_Skins.FrameAlias[SkinName][gl]["G"]==nil then Healbot_Config_Skins.FrameAlias[SkinName][gl]["G"]=1 end
        if Healbot_Config_Skins.FrameAlias[SkinName][gl]["B"]==nil then Healbot_Config_Skins.FrameAlias[SkinName][gl]["B"]=1 end
        if Healbot_Config_Skins.FrameAlias[SkinName][gl]["A"]==nil then Healbot_Config_Skins.FrameAlias[SkinName][gl]["A"]=1 end
        if Healbot_Config_Skins.FrameAliasBar[SkinName][gl]["TEXTURE"]==nil then Healbot_Config_Skins.FrameAliasBar[SkinName][gl]["TEXTURE"]=HealBot_Default_Textures[10].name end
        if Healbot_Config_Skins.FrameAliasBar[SkinName][gl]["WIDTH"]==nil then Healbot_Config_Skins.FrameAliasBar[SkinName][gl]["WIDTH"]=0.7 end
        if Healbot_Config_Skins.FrameAliasBar[SkinName][gl]["HEIGHT"]==nil then Healbot_Config_Skins.FrameAliasBar[SkinName][gl]["HEIGHT"]=20 end
        if Healbot_Config_Skins.FrameAliasBar[SkinName][gl]["R"]==nil then Healbot_Config_Skins.FrameAliasBar[SkinName][gl]["R"]=0.1 end
        if Healbot_Config_Skins.FrameAliasBar[SkinName][gl]["G"]==nil then Healbot_Config_Skins.FrameAliasBar[SkinName][gl]["G"]=0.25 end
        if Healbot_Config_Skins.FrameAliasBar[SkinName][gl]["B"]==nil then Healbot_Config_Skins.FrameAliasBar[SkinName][gl]["B"]=0.25 end
        if Healbot_Config_Skins.FrameAliasBar[SkinName][gl]["A"]==nil then Healbot_Config_Skins.FrameAliasBar[SkinName][gl]["A"]=0.5 end
        if Healbot_Config_Skins.Anchors[SkinName][gl]["Y"]==nil then Healbot_Config_Skins.Anchors[SkinName][gl]["Y"]=(49+gl) end
        if Healbot_Config_Skins.Anchors[SkinName][gl]["X"]==nil then Healbot_Config_Skins.Anchors[SkinName][gl]["X"]=(49+gl) end
        if Healbot_Config_Skins.Anchors[SkinName][gl]["Y"]>100 or Healbot_Config_Skins.Anchors[SkinName][gl]["X"]>100 then
            Healbot_Config_Skins.Anchors[SkinName][gl]["Y"]=HealBot_Comm_round(((Healbot_Config_Skins.Anchors[SkinName][gl]["Y"]/GetScreenHeight())*100),2)
            Healbot_Config_Skins.Anchors[SkinName][gl]["X"]=HealBot_Comm_round(((Healbot_Config_Skins.Anchors[SkinName][gl]["X"]/GetScreenWidth())*100),2)
        end
        if Healbot_Config_Skins.IconText[SkinName][gl]["HEIGHT"]==nil then 
            if Healbot_Config_Skins.IconText[SkinName][gl]["SCALE"] then
                local iScale=Healbot_Config_Skins.HealBar[SkinName][gl]["HEIGHT"]*(Healbot_Config_Skins.Icons[SkinName][gl]["SCALE"]*0.7)
                Healbot_Config_Skins.IconText[SkinName][gl]["HEIGHT"]=floor(iScale*Healbot_Config_Skins.IconText[SkinName][gl]["SCALE"])
                Healbot_Config_Skins.IconText[SkinName][gl]["SCALE"]=nil
                if Healbot_Config_Skins.IconText[SkinName][gl]["HEIGHT"]>12 then Healbot_Config_Skins.IconText[SkinName][gl]["HEIGHT"]=12 end
                if Healbot_Config_Skins.IconText[SkinName][gl]["HEIGHT"]<8 then Healbot_Config_Skins.IconText[SkinName][gl]["HEIGHT"]=8 end
            else
                Healbot_Config_Skins.IconText[SkinName][gl]["HEIGHT"]=10
            end
        end
    end

    if Healbot_Config_Skins.Healing[SkinName]["ALERTIC"] then Healbot_Config_Skins.Healing[SkinName]["ALERTIC"]=nil end
    if Healbot_Config_Skins.Healing[SkinName]["ALERTOC"] then Healbot_Config_Skins.Healing[SkinName]["ALERTOC"]=nil end
    if Healbot_Config_Skins.Sort then Healbot_Config_Skins.Sort=nil end
    if Healbot_Config_Skins.Aggro then Healbot_Config_Skins.Aggro=nil end
    if Healbot_Config_Skins.Highlight then Healbot_Config_Skins.Highlight=nil end
    
    if Healbot_Config_Skins.Author[SkinName]==nil then Healbot_Config_Skins.Author[SkinName] = HEALBOT_WORDS_UNKNOWN end
    if Healbot_Config_Skins.Protection[SkinName]["CRASH"]==nil then Healbot_Config_Skins.Protection[SkinName]["CRASH"]=false end
    if Healbot_Config_Skins.Protection[SkinName]["GENERALMACRO"]==nil then Healbot_Config_Skins.Protection[SkinName]["GENERALMACRO"]=false end
    if Healbot_Config_Skins.Protection[SkinName]["COMBAT"]==nil then Healbot_Config_Skins.Protection[SkinName]["COMBAT"]=false end
    if Healbot_Config_Skins.Protection[SkinName]["COMBATPARTY"]==nil then Healbot_Config_Skins.Protection[SkinName]["COMBATPARTY"]=true end
    if Healbot_Config_Skins.Protection[SkinName]["COMBATRAID"]==nil then Healbot_Config_Skins.Protection[SkinName]["COMBATRAID"]=true end
    if Healbot_Config_Skins.Healing[SkinName]["GROUPPETS"]==nil then Healbot_Config_Skins.Healing[SkinName]["GROUPPETS"]=true end
    if Healbot_Config_Skins.Healing[SkinName]["SELFPET"]==nil then Healbot_Config_Skins.Healing[SkinName]["SELFPET"]=false end
    if Healbot_Config_Skins.Healing[SkinName]["TALWAYSSHOW"] then 
        Healbot_Config_Skins.Healing[SkinName]["TARGETINCOMBAT"]=3
        Healbot_Config_Skins.Healing[SkinName]["TALWAYSSHOW"]=nil
    end
    if Healbot_Config_Skins.Healing[SkinName]["TARGETINCOMBAT"]==nil then Healbot_Config_Skins.Healing[SkinName]["TARGETINCOMBAT"]=2 end
    if Healbot_Config_Skins.Healing[SkinName]["FALWAYSSHOW"] then 
        Healbot_Config_Skins.Healing[SkinName]["FOCUSINCOMBAT"]=3
        Healbot_Config_Skins.Healing[SkinName]["FALWAYSSHOW"]=nil
    end
    if not Healbot_Config_Skins.Healing[SkinName]["FOCUSINCOMBAT"] then Healbot_Config_Skins.Healing[SkinName]["FOCUSINCOMBAT"]=2 end
    if Healbot_Config_Skins.Healing[SkinName]["TONLYFRIEND"]==nil then Healbot_Config_Skins.Healing[SkinName]["TONLYFRIEND"]=false end
    if Healbot_Config_Skins.Healing[SkinName]["FONLYFRIEND"]==nil then Healbot_Config_Skins.Healing[SkinName]["FONLYFRIEND"]=false end
    if Healbot_Config_Skins.Healing[SkinName]["TEXRAID"]==nil then Healbot_Config_Skins.Healing[SkinName]["TEXRAID"]=false end
    if Healbot_Config_Skins.Healing[SkinName]["FEXRAID"]==nil then Healbot_Config_Skins.Healing[SkinName]["FEXRAID"]=false end
    if Healbot_Config_Skins.General[SkinName]["HIDEPARTYF"]==nil then Healbot_Config_Skins.General[SkinName]["HIDEPARTYF"]=false end
    if Healbot_Config_Skins.General[SkinName]["HIDEPTF"]==nil then Healbot_Config_Skins.General[SkinName]["HIDEPTF"]=false end
    if Healbot_Config_Skins.General[SkinName]["HIDEBOSSF"]==nil then Healbot_Config_Skins.General[SkinName]["HIDEBOSSF"]=false end
    if Healbot_Config_Skins.General[SkinName]["HIDERAIDF"]==nil then Healbot_Config_Skins.General[SkinName]["HIDERAIDF"]=true end
    if Healbot_Config_Skins.General[SkinName]["FLUIDBARS"]==nil then Healbot_Config_Skins.General[SkinName]["FLUIDBARS"]=false end
    if Healbot_Config_Skins.General[SkinName]["FLUIDFREQ"]==nil then Healbot_Config_Skins.General[SkinName]["FLUIDFREQ"]=3 end
    if Healbot_Config_Skins.General[SkinName]["STICKYFRAME"]==nil then Healbot_Config_Skins.General[SkinName]["STICKYFRAME"]=false end
    if Healbot_Config_Skins.General[SkinName]["STICKYSENSITIVITY"]==nil then Healbot_Config_Skins.General[SkinName]["STICKYSENSITIVITY"]=30 end
    if Healbot_Config_Skins.Chat[SkinName]["NOTIFY"]==nil then Healbot_Config_Skins.Chat[SkinName]["NOTIFY"]=1 end
    if Healbot_Config_Skins.Chat[SkinName]["MSG"]==nil then Healbot_Config_Skins.Chat[SkinName]["MSG"]=HEALBOT_NOTIFYOTHERMSG end
    if Healbot_Config_Skins.Chat[SkinName]["RESONLY"]==nil then Healbot_Config_Skins.Chat[SkinName]["RESONLY"]=true end
    if Healbot_Config_Skins.Chat[SkinName]["EOCOOM"]==nil then Healbot_Config_Skins.Chat[SkinName]["EOCOOM"]=false end
    if not Healbot_Config_Skins.Chat[SkinName]["EOCOOMV"] then Healbot_Config_Skins.Chat[SkinName]["EOCOOMV"]=20 end
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
    if Healbot_Config_Skins.General[SkinName]["LOWMANA"] then Healbot_Config_Skins.General[SkinName]["LOWMANA"]=nil end
    if Healbot_Config_Skins.General[SkinName]["LOWMANACOMBAT"] then Healbot_Config_Skins.General[SkinName]["LOWMANACOMBAT"]=nil end
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

local function HealBot_Include_Skin(skinName)
    local skinExists=false;
    table.foreach(Healbot_Config_Skins.Skins, function (index,skin)
        if skin==skinName then skinExists=true; end
    end)
    local defaultExists=false;
    table.foreach(HealBot_Config_SkinsDefaults.Skins, function (index,skin)
        if skin==skinName then defaultExists=true; end
    end)
    if not skinExists and defaultExists then
        Healbot_Config_Skins.Author[skinName]=HealBot_Config_SkinsDefaults.Author[skinName]
        Healbot_Config_Skins.Chat[skinName]=HealBot_Options_copyTable(HealBot_Config_SkinsDefaults.Chat[skinName])
        Healbot_Config_Skins.General[skinName]=HealBot_Options_copyTable(HealBot_Config_SkinsDefaults.General[skinName])
        Healbot_Config_Skins.Healing[skinName]=HealBot_Options_copyTable(HealBot_Config_SkinsDefaults.Healing[skinName])
        Healbot_Config_Skins.Protection[skinName]=HealBot_Options_copyTable(HealBot_Config_SkinsDefaults.Protection[skinName])
        Healbot_Config_Skins.BarHighlight[skinName]=HealBot_Options_copyTable(HealBot_Config_SkinsDefaults.BarHighlight[skinName])
        Healbot_Config_Skins.BarAggro[skinName]=HealBot_Options_copyTable(HealBot_Config_SkinsDefaults.BarAggro[skinName])
        Healbot_Config_Skins.BarSort[skinName]=HealBot_Options_copyTable(HealBot_Config_SkinsDefaults.BarSort[skinName])
        Healbot_Config_Skins.BarVisibility[skinName]=HealBot_Options_copyTable(HealBot_Config_SkinsDefaults.BarVisibility[skinName])
        Healbot_Config_Skins.IncludeGroup[skinName]=HealBot_Options_copyTable(HealBot_Config_SkinsDefaults.IncludeGroup[skinName])
        Healbot_Config_Skins.FrameAlias[skinName]=HealBot_Options_copyTable(HealBot_Config_SkinsDefaults.FrameAlias[skinName])
        Healbot_Config_Skins.FrameAliasBar[skinName]=HealBot_Options_copyTable(HealBot_Config_SkinsDefaults.FrameAliasBar[skinName])
        Healbot_Config_Skins.Frame[skinName]=HealBot_Options_copyTable(HealBot_Config_SkinsDefaults.Frame[skinName])
        Healbot_Config_Skins.StickyFrames[skinName]=HealBot_Options_copyTable(HealBot_Config_SkinsDefaults.StickyFrames[skinName])
        Healbot_Config_Skins.HealGroups[skinName]=HealBot_Options_copyTable(HealBot_Config_SkinsDefaults.HealGroups[skinName])
        Healbot_Config_Skins.Anchors[skinName]=HealBot_Options_copyTable(HealBot_Config_SkinsDefaults.Anchors[skinName])
        Healbot_Config_Skins.HeadBar[skinName]=HealBot_Options_copyTable(HealBot_Config_SkinsDefaults.HeadBar[skinName])
        Healbot_Config_Skins.HeadText[skinName]=HealBot_Options_copyTable(HealBot_Config_SkinsDefaults.HeadText[skinName])
        Healbot_Config_Skins.HealBar[skinName]=HealBot_Options_copyTable(HealBot_Config_SkinsDefaults.HealBar[skinName])
        Healbot_Config_Skins.BarCol[skinName]=HealBot_Options_copyTable(HealBot_Config_SkinsDefaults.BarCol[skinName])
        Healbot_Config_Skins.BarIACol[skinName]=HealBot_Options_copyTable(HealBot_Config_SkinsDefaults.BarIACol[skinName])
        Healbot_Config_Skins.BarText[skinName]=HealBot_Options_copyTable(HealBot_Config_SkinsDefaults.BarText[skinName])
        Healbot_Config_Skins.BarTextCol[skinName]=HealBot_Options_copyTable(HealBot_Config_SkinsDefaults.BarTextCol[skinName])
        Healbot_Config_Skins.Icons[skinName]=HealBot_Options_copyTable(HealBot_Config_SkinsDefaults.Icons[skinName])
        Healbot_Config_Skins.RaidIcon[skinName]=HealBot_Options_copyTable(HealBot_Config_SkinsDefaults.RaidIcon[skinName])
        Healbot_Config_Skins.IconText[skinName]=HealBot_Options_copyTable(HealBot_Config_SkinsDefaults.IconText[skinName])
        Healbot_Config_Skins.Enemy[skinName]=HealBot_Options_copyTable(HealBot_Config_SkinsDefaults.Enemy[skinName])
        table.insert(Healbot_Config_Skins.Skins,skinName)
        HealBot_Check_Skin(skinName)
    end
end

local function HealBot_Update_Skins(forceCheck)
    if HealBot_Globals.LastVersionSkinUpdate then
        HealBot_Globals.LastVersionSkinUpdate=nil
    end
    if HealBot_Config.ActionVisible then
        HealBot_Config.ActionVisible=nil
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
        local retryWithSkin = HealBot_getDefaultSkin()
        HealBot_Options_Set_Current_Skin(retryWithSkin, nil, true)
    end

    local tMajor, tMinor, tPatch, tHealbot = string.split(".", HealBot_Config.LastVersionSkinUpdate)
    if tonumber(tMajor)<8 then
        HealBot_Options_SetDefaults();
        HealBot_ReloadUI()
    elseif HealBot_Config.LastVersionSkinUpdate~=HEALBOT_VERSION_SC or forceCheck then   
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
                if tonumber(tMinor)==0 or (tonumber(tMinor)==1 and tonumber(tPatch)==0) or (tonumber(tMinor)==1 and tonumber(tPatch)==5 and tonumber(tHealbot)<14) then
                    for gl=1,10 do
                        if Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Skins[x]][gl]["HEIGHT"]<1 then
                            local bheight=(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Skins[x]][gl]["HEIGHT"]+Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Skins[x]][gl]["POWERSIZE"])
                            Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Skins[x]][gl]["HEIGHT"]=ceil(bheight*Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Skins[x]][gl]["HEIGHT"])
                        end
                        if Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Skins[x]][gl]["OFFSET"]>2 then
                            Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Skins[x]][gl]["OFFSET"]=Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Skins[x]][gl]["OFFSET"]-10
                        end
                    end
                end
            end
        end
        if tonumber(tMajor)==8 then
            if tonumber(tMinor)==0 or (tonumber(tMinor)==1 and tonumber(tPatch)==0) or (tonumber(tMinor)==1 and tonumber(tPatch)==5 and tonumber(tHealbot)<4) then
                for dName, x in pairs(HealBot_Globals.HealBot_Custom_Debuffs) do
                    local name, _, _, _, _, _, spellId = GetSpellInfo(dName)
                    if name==dName and spellId then
                        HealBot_Globals.HealBot_Custom_Debuffs[spellId]=x;
                        HealBot_Globals.HealBot_Custom_Debuffs[dName]=nil;
                    elseif dName==GetSpellInfo(HEALBOT_SHROUD_OF_PURGATORY) then
                        HealBot_Globals.HealBot_Custom_Debuffs[HEALBOT_SHROUD_OF_PURGATORY]=x;
                        HealBot_Globals.HealBot_Custom_Debuffs[dName]=nil;
                    elseif dName==GetSpellInfo(HEALBOT_DEBUFF_ROCKET_FUEL_LEAK) then
                        HealBot_Globals.HealBot_Custom_Debuffs[HEALBOT_DEBUFF_ROCKET_FUEL_LEAK]=x;
                        HealBot_Globals.HealBot_Custom_Debuffs[dName]=nil;
                    elseif dName==GetSpellInfo(HEALBOT_DEBUFF_FORBEARANCE) then
                        HealBot_Globals.HealBot_Custom_Debuffs[HEALBOT_DEBUFF_FORBEARANCE]=x;
                        HealBot_Globals.HealBot_Custom_Debuffs[dName]=nil;
                    elseif dName==GetSpellInfo(HEALBOT_DEBUFF_WEAKENED_SOUL) then
                        HealBot_Globals.HealBot_Custom_Debuffs[HEALBOT_DEBUFF_WEAKENED_SOUL]=x;
                        HealBot_Globals.HealBot_Custom_Debuffs[dName]=nil;
                    elseif dName==GetSpellInfo(HEALBOT_SHADOW_TOUCHED) then
                        HealBot_Globals.HealBot_Custom_Debuffs[HEALBOT_SHADOW_TOUCHED]=x;
                        HealBot_Globals.HealBot_Custom_Debuffs[dName]=nil;
                    end
                end
            end
            if tonumber(tMinor)==0 or (tonumber(tMinor)==1 and tonumber(tPatch)==0) or (tonumber(tMinor)==1 and tonumber(tPatch)==5 and tonumber(tHealbot)<6) then
                local hbClassHoTwatch=HealBot_Globals.WatchHoT
                for xClass,_  in pairs(hbClassHoTwatch) do
                    local HealBot_configClassHoTClass=HealBot_Globals.WatchHoT[xClass]
                    for sName,x  in pairs(HealBot_configClassHoTClass) do
                        local name, _, _, _, _, _, spellId = GetSpellInfo(sName)
                        if name==sName and spellId then
                            HealBot_Globals.WatchHoT[xClass][spellId]=x
                            HealBot_Globals.WatchHoT[xClass][sName]=nil
                        end
                    end
                end
            end
            if tonumber(tMinor)==0 or (tonumber(tMinor)==1 and tonumber(tPatch)==0) or (tonumber(tMinor)==1 and tonumber(tPatch)==5 and tonumber(tHealbot)<8) then
                for dId, x in pairs(HealBot_Globals.HealBot_Custom_Debuffs) do
                    HealBot_Globals.HealBot_Custom_Debuffs[HEALBOT_CUSTOM_CAT_CUSTOM_AUTOMATIC]=15
                    if not HealBot_Globals.Custom_Debuff_Categories[dId] or 
                       (HealBot_Globals.Custom_Debuff_Categories[dId]==1 and dId~=HEALBOT_CUSTOM_CAT_CUSTOM_AUTOMATIC) then
                        HealBot_Globals.HealBot_Custom_Debuffs[dId]=nil
                    end
                    if HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[dId]==nil then HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[dId]=true end
                end
            end
            if tonumber(tMinor)==0 or (tonumber(tMinor)==1 and tonumber(tPatch)==0) or (tonumber(tMinor)==1 and tonumber(tPatch)==5 and tonumber(tHealbot)<12) then
                HealBot_Globals.VersionResetDone["Reset_AutoUpdateSpellIDs"]=nil
                HealBot_Reset_AutoUpdateSpellIDs()
            end
            if tonumber(tMinor)<2 then
                HealBot_Include_Skin(HEALBOT_OPTIONS_RAID25)
                HealBot_Include_Skin(HEALBOT_OPTIONS_RAID40)
            elseif tonumber(tPatch)==0 then
                if tonumber(tHealbot)<3 then
                    HealBot_setOptions_Timer(7990)
                end
                if tonumber(tHealbot)<5 then
                    HealBot_Globals.CatchAltBuffIDs=nil
                end
                if tonumber(tHealbot)<7 then
                    HealBot_Globals.v1BuffExpireTimes=nil
                    if HealBot_Globals.RangeCheckFreq>0.25 then HealBot_Globals.RangeCheckFreq=HealBot_Globals.RangeCheckFreq-0.1 end
                end
            end
        end
        if HealBot_Globals.mapScale then HealBot_Globals.mapScale=nil end
        if HealBot_Globals.RangeCheckFreq>1 then HealBot_Globals.RangeCheckFreq=1 end
        if HealBot_Globals.RangeCheckFreq<0.1 then HealBot_Globals.RangeCheckFreq=0.1 end
        local customDebuffPriority=HEALBOT_CUSTOM_en.."15"
        if not HealBot_Globals.CDCBarColour[customDebuffPriority] then
            HealBot_Globals.CDCBarColour[customDebuffPriority]={}
            HealBot_Globals.CDCBarColour[customDebuffPriority]["R"] = 0.45
            HealBot_Globals.CDCBarColour[customDebuffPriority]["G"] = 0
            HealBot_Globals.CDCBarColour[customDebuffPriority]["B"] = 0.28
        end
    
        HealBot_AddDebug("Version change - "..HealBot_Config.LastVersionSkinUpdate)
    else
        HealBot_AddDebug("No version change - "..HealBot_Config.LastVersionSkinUpdate)
    end
    if HealBot_Config.CurrentSpec==9 then
        HealBot_Config.CurrentSpec=1
        HealBot_Update_SpellCombos()
        HealBot_Update_BuffsForSpec()
    end
    
    HealBot_Config.LastVersionSkinUpdate=HEALBOT_VERSION_SC
  --HealBot_setCall("HealBot_Update_Skins")
end

function HealBot_CheckAllSkins()
    HealBot_Update_Skins(true)
end

local function HealBot_VersionUpdate_Spells()
    local combo,button,sText,cType=nil,nil,nil,nil
    for x=1,3 do
        cType="ENEMY"
        if x==1 then
            cType="ENABLED"
        elseif x==2 then
            cType="DISABLED"
        end
        for y=1,15 do
            button = HealBot_Options_ComboClass_Button(y)
            for z=1,4 do
                sText=HealBot_Action_GetSpell(cType, button..z)
                if sText then
                    HealBot_Action_SetSpell(cType, button..z, sText)
                end
            end
            for z=1,4 do
                sText=HealBot_Action_GetSpell(cType, "Shift"..button..z)
                if sText then
                    HealBot_Action_SetSpell(cType, "Shift"..button..z, sText)
                end
            end
            for z=1,4 do
                sText=HealBot_Action_GetSpell(cType, "Ctrl"..button..z)
                if sText then
                    HealBot_Action_SetSpell(cType, "Ctrl"..button..z, sText)
                end
            end
            for z=1,4 do
                sText=HealBot_Action_GetSpell(cType, "Alt"..button..z)
                if sText then
                    HealBot_Action_SetSpell(cType, "Alt"..button..z, sText)
                end
            end
            for z=1,4 do
                sText=HealBot_Action_GetSpell(cType, "Ctrl-Shift"..button..z)
                if sText then
                    HealBot_Action_SetSpell(cType, "Ctrl-Shift"..button..z, sText)
                end
            end
            for z=1,4 do
                sText=HealBot_Action_GetSpell(cType, "Alt-Shift"..button..z)
                if sText then
                    HealBot_Action_SetSpell(cType, "Alt-Shift"..button..z, sText)
                end
            end
            for z=1,4 do
                sText=HealBot_Action_GetSpell(cType, "Alt-Ctrl"..button..z)
                if sText then
                    HealBot_Action_SetSpell(cType, "Alt-Ctrl"..button..z, sText)
                end
            end
        end
    end
    HealBot_AddDebug("Updated Spells")
end

function HealBot_setTooltipUpdateInterval()
    if HealBot_Globals.Tooltip_ShowCD then
        HealBot_luVars["TipTimeInterval"]=0.098
    else
        HealBot_luVars["TipTimeInterval"]=HealBot_Globals.RangeCheckFreq
    end
  --HealBot_setCall("HealBot_setTooltipUpdateInterval")
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
    local sName=nil
    if HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_PRIEST] then
        sName=GetSpellInfo(HBC_DAMPEN_MAGIC)
        if sName then HealBot_ShortBuffs[sName]=true end
        sName=GetSpellInfo(HBC_SHADOW_PROTECTION)
        if sName then HealBot_ShortBuffs[sName]=true end
        sName=GetSpellInfo(HEALBOT_FEAR_WARD)
        if sName then HealBot_ShortBuffs[sName]=true end
        sName=GetSpellInfo(HBC_INNER_FIRE)
        if sName then HealBot_ShortBuffs[sName]=true end
    elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_DRUID] then
        sName=GetSpellInfo(HBC_THORNS)
        if sName then HealBot_ShortBuffs[sName]=true end
        sName=GetSpellInfo(HBC_OMEN_OF_CLARITY)
        if sName then HealBot_ShortBuffs[sName]=true end
    elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_PALADIN] then
        sName=GetSpellInfo(HEALBOT_BEACON_OF_LIGHT)
        if sName then HealBot_ShortBuffs[sName]=true end
        sName=GetSpellInfo(HEALBOT_SACRED_SHIELD)
        if sName then HealBot_ShortBuffs[sName]=true end
        sName=GetSpellInfo(HBC_BLESSING_OF_KINGS)
        if sName then HealBot_ShortBuffs[sName]=true end
        sName=GetSpellInfo(HBC_BLESSING_OF_MIGHT)
        if sName then HealBot_ShortBuffs[sName]=true end
        sName=GetSpellInfo(HBC_BLESSING_OF_WISDOM)
        if sName then HealBot_ShortBuffs[sName]=true end
        sName=GetSpellInfo(HBC_BLESSING_OF_LIGHT)
        if sName then HealBot_ShortBuffs[sName]=true end
        sName=GetSpellInfo(HBC_BLESSING_OF_SANCTUARY)
        if sName then HealBot_ShortBuffs[sName]=true end
    elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_MONK] then
        -- short buffs
    elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_WARRIOR] then
        -- short buffs
    elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_MAGE] then
        sName=GetSpellInfo(HEALBOT_ICE_WARD)
        if sName then HealBot_ShortBuffs[sName]=true end
        sName=GetSpellInfo(HEALBOT_ICE_BARRIER)
        if sName then HealBot_ShortBuffs[sName]=true end
        sName=GetSpellInfo(HBC_DAMPEN_MAGIC)
        if sName then HealBot_ShortBuffs[sName]=true end
	elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_WARLOCK] then
        -- short buffs
	elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_DEATHKNIGHT] then
        sName=GetSpellInfo(HEALBOT_HORN_OF_WINTER)
        if sName then HealBot_ShortBuffs[sName]=true end
	elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_HUNTER] then
        -- short buffs
    elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_SHAMAN] then
        -- short buffs
    elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_ROGUE] then
        -- short buffs
    elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_DEMONHUNTER] then
        -- short buffs
    end
    
    HealBot_customTempUserName=HealBot_Options_copyTable(HealBot_Globals.HealBot_customPermUserName)
    HealBot_Update_Skins()  

    if HealBot_Globals.localLang then
        HealBot_Options_Lang(HealBot_Globals.localLang)
    else
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
    HealBot_Vers[HealBot_Data["PNAME"]]=HEALBOT_VERSION
    
    if HEALBOT_GAME_VERSION<4 then
        local HBC_WISDOM_ID = 1 --Mana Regen
        local HBC_LIGHT_ID = 2 --Incoming Heals
        local HBC_SALVATION_ID = 3 --Threat Reduction
        local HBC_SANCTUARY_ID = 4 --Damage Reduction
        local HBC_STATS_ID = 5 --Stats
        local HBC_MIGHT_ID = 6 --Attack Power
        local HBC_STAMINA_ID = 7 --Stamina
        local HBC_INT_ID = 8 --Int
        local HBC_SPIRIT_ID = 9 --Spirit
        local HBC_SP_ID = 10 --Shadow Resistance 

        if HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_DRUID] then
            HealBot_BuffNameTypes = {
                [(GetSpellInfo(HEALBOT_MARK_OF_THE_WILD) or "x")] = HBC_STATS_ID,
                [(GetSpellInfo(HBC_GIFT_OF_THE_WILD) or "x")] = HBC_STATS_ID,
            }
        elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_MAGE] then
            HealBot_BuffNameTypes = {
                [(GetSpellInfo(HBC_ARCANE_BRILLIANCE) or "x")] = HBC_INT_ID,
            }
        elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_PALADIN] then
            HealBot_BuffNameTypes = {
                [(GetSpellInfo(HBC_BLESSING_OF_KINGS) or "x")] = HBC_STATS_ID,
                [(GetSpellInfo(HBC_BLESSING_OF_LIGHT) or "x")] = HBC_LIGHT_ID,
                [(GetSpellInfo(HBC_BLESSING_OF_MIGHT) or "x")] = HBC_MIGHT_ID,
                [(GetSpellInfo(HEALBOT_HAND_OF_SALVATION) or "x")] = HBC_SALVATION_ID,
                [(GetSpellInfo(HBC_BLESSING_OF_SANCTUARY) or "x")] = HBC_SANCTUARY_ID,
                [(GetSpellInfo(HBC_BLESSING_OF_WISDOM) or "x")] = HBC_WISDOM_ID,
                [(GetSpellInfo(HBC_GREATER_BLESSING_OF_KINGS) or "x")] = HBC_STATS_ID,
                [(GetSpellInfo(HBC_GREATER_BLESSING_OF_LIGHT) or "x")] = HBC_LIGHT_ID,
                [(GetSpellInfo(HBC_GREATER_BLESSING_OF_MIGHT) or "x")] = HBC_MIGHT_ID,
                [(GetSpellInfo(HBC_GREATER_BLESSING_OF_SALVATION) or "x")] = HBC_SALVATION_ID,
                [(GetSpellInfo(HBC_GREATER_BLESSING_OF_SANCTUARY) or "x")] = HBC_SANCTUARY_ID,
                [(GetSpellInfo(HBC_GREATER_BLESSING_OF_WISDOM) or "x")] = HBC_WISDOM_ID,
            }
        elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_PRIEST] then
            HealBot_BuffNameTypes = {
                [(GetSpellInfo(HBC_POWER_WORD_FORTITUDE) or "x")] = HBC_STAMINA_ID,
                [(GetSpellInfo(HEALBOT_POWER_WORD_FORTITUDE) or "x")] = HBC_STAMINA_ID,
                [(GetSpellInfo(HBC_DIVINE_SPIRIT) or "x")] = HBC_SPIRIT_ID,
                [(GetSpellInfo(HBC_PRAYER_OF_SPIRIT) or "x")] = HBC_SPIRIT_ID,
                [(GetSpellInfo(HBC_SHADOW_PROTECTION) or "x")] = HBC_SP_ID,
                [(GetSpellInfo(HBC_PRAYER_OF_SHADOW_PROTECTION) or "x")] = HBC_SP_ID,
            }
        else
            HealBot_BuffNameTypes = {
                [(GetSpellInfo(HEALBOT_TRUESHOT_AURA) or "x")] = HBC_STAMINA_ID,
                [(GetSpellInfo(HEALBOT_BATTLE_SHOUT) or "x")] = HBC_STAMINA_ID,
            }
        end
        HealBot_setOptions_Timer(9920)
    else
        -- Don't see the point of this in current retail (8.2)
        -- Aura checks are often done and this adds unnecessary looping
        -- Should it be required in the future, consider only sticky buffs and exclude in range buffs
        -- Also simplifying by only including the primary buff, using int instead of table
        
        --local HEALBOT_STATS_ID = 1 --RAID_BUFF_1 --Stats
        --local HEALBOT_STAMINA_ID = 2 --RAID_BUFF_2 --Stamina
        --local HEALBOT_ATTACK_POWER_ID = 3 --RAID_BUFF_3 --Attack Power
        --local HEALBOT_HASTE_ID = 4 --RAID_BUFF_4 --Haste
        --local HEALBOT_SPELL_POWER_ID = 5 --RAID_BUFF_5 --Spell Power
        --local HEALBOT_CRITICAL_STRIKE_ID = 6 --RAID_BUFF_6 --Critical Strike
        --local HEALBOT_MASTERY_ID = 7 --RAID_BUFF_7 --Mastery
        --local HEALBOT_MULTISTRIKE_ID = 8 --RAID_BUFF_8 --Multistrike
        --local HEALBOT_VERSATILITY_ID = 9 --RAID_BUFF_9 --Versatility

        HealBot_BuffNameTypes = {
            -- Death Knight
        --    [(GetSpellInfo(HEALBOT_HORN_OF_WINTER) or "x")] = HEALBOT_ATTACK_POWER_ID,
        --    [(GetSpellInfo(HEALBOT_POWER_OF_THE_GRAVE) or "x")] = HEALBOT_MASTERY_ID,
        --    [(GetSpellInfo(HEALBOT_UNHOLY_AURA) or "x")] = HEALBOT_HASTE_ID,
            -- Druid
        --    [(GetSpellInfo(HEALBOT_MARK_OF_THE_WILD) or "x")] = HEALBOT_STATS_ID,
        --    [(GetSpellInfo(HEALBOT_MOONKIN_AURA) or "x")] = HEALBOT_MASTERY_ID,
        --    [(GetSpellInfo(HEALBOT_LEADER_OF_THE_PACK) or "x")] = HEALBOT_CRITICAL_STRIKE_ID,
            -- Hunter
        --    [(GetSpellInfo(HEALBOT_TRUESHOT_AURA) or "x")] = HEALBOT_ATTACK_POWER_ID,
        --    [(GetSpellInfo(HEALBOT_LW_FORTITUDE_OF_THE_BEAR) or "x")] = HEALBOT_STAMINA_ID,
        --    [(GetSpellInfo(HEALBOT_LW_POWER_OF_THE_PRIMATES) or "x")] = HEALBOT_STATS_ID,
        --    [(GetSpellInfo(HEALBOT_LW_WISDOM_OF_THE_SERPENT) or "x")] = HEALBOT_SPELL_POWER_ID,
        --    [(GetSpellInfo(HEALBOT_LW_GRACE_OF_THE_CAT) or "x")] = HEALBOT_MASTERY_ID,
        --    [(GetSpellInfo(HEALBOT_LW_HASTE_OF_THE_HYENA) or "x")] = HEALBOT_HASTE_ID,
        --    [(GetSpellInfo(HEALBOT_LW_FEROCITY_OF_THE_RAPTOR) or "x")] = HEALBOT_CRITICAL_STRIKE_ID,
        --    [(GetSpellInfo(HEALBOT_LW_QUICKNESS_OF_THE_DRAGONHAWK) or "x")] = HEALBOT_MULTISTRIKE_ID,
        --    [(GetSpellInfo(HEALBOT_LW_VERSATILITY_OF_THE_RAVAGER) or "x")] = HEALBOT_VERSATILITY_ID,
            -- Hunter Pets
        --    [(GetSpellInfo(HEALBOT_BARK_OF_THE_WILD) or "x")] = HEALBOT_STATS_ID,
        --    [(GetSpellInfo(HEALBOT_BLESSING_OF_KONGS) or "x")] = HEALBOT_STATS_ID,
        --    [(GetSpellInfo(HEALBOT_EMBRACE_OF_THE_SHALE_SPIDER) or "x")] = HEALBOT_STATS_ID,
        --    [(GetSpellInfo(HEALBOT_STRENGTH_OF_THE_EARTH) or "x")] = HEALBOT_STATS_ID,
        --    [(GetSpellInfo(HEALBOT_INVIGORATING_ROAR) or "x")] = HEALBOT_STAMINA_ID,
        --    [(GetSpellInfo(HEALBOT_STURDINESS) or "x")] = HEALBOT_STAMINA_ID,
        --    [(GetSpellInfo(HEALBOT_SAVAGE_VIGOR) or "x")] = HEALBOT_HASTE_ID,
        --    [(GetSpellInfo(HEALBOT_QIRAJI_FORTITUDE) or "x")] = HEALBOT_SPELL_POWER_ID,
        --    [(GetSpellInfo(HEALBOT_SERPENTS_CUNNING) or "x")] = HEALBOT_SPELL_POWER_ID,
        --    [(GetSpellInfo(HEALBOT_STILL_WATER) or "x")] = HEALBOT_CRITICAL_STRIKE_ID,
        --    [(GetSpellInfo(HEALBOT_ROAR_OF_COURAGE) or "x")] = HEALBOT_MASTERY_ID,
        --    [(GetSpellInfo(HEALBOT_KEEN_SENSES) or "x")] = HEALBOT_MASTERY_ID,
        --    [(GetSpellInfo(HEALBOT_SPIRIT_BEAST_BLESSING) or "x")] = HEALBOT_MASTERY_ID,
        --    [(GetSpellInfo(HEALBOT_PLAINSWALKING) or "x")] = HEALBOT_MASTERY_ID,
        --    [(GetSpellInfo(HEALBOT_CACKLING_HOWL) or "x")] = HEALBOT_HASTE_ID,
        --    [(GetSpellInfo(HEALBOT_ENERGIZING_SPORES) or "x")] = HEALBOT_HASTE_ID,
        --    [(GetSpellInfo(HEALBOT_SPEED_OF_THE_SWARM) or "x")] = HEALBOT_HASTE_ID,
        --    [(GetSpellInfo(HEALBOT_TERRIFYING_ROAR) or "x")] = HEALBOT_CRITICAL_STRIKE_ID,
        --    [(GetSpellInfo(HEALBOT_FEARLESS_ROAR) or "x")] = HEALBOT_CRITICAL_STRIKE_ID,
        --    [(GetSpellInfo(HEALBOT_STRENGTH_OF_THE_PACK) or "x")] = HEALBOT_CRITICAL_STRIKE_ID,
        --    [(GetSpellInfo(HEALBOT_FURIOUS_HOWL) or "x")] = HEALBOT_CRITICAL_STRIKE_ID,
        --    [(GetSpellInfo(HEALBOT_SONIC_FOCUS) or "x")] = HEALBOT_MULTISTRIKE_ID,
        --    [(GetSpellInfo(HEALBOT_WILD_STRENGTH) or "x")] = HEALBOT_VERSATILITY_ID,
        --    [(GetSpellInfo(HEALBOT_DOUBLE_BITE) or "x")] = HEALBOT_MULTISTRIKE_ID,
        --    [(GetSpellInfo(HEALBOT_SPRY_ATTACKS) or "x")] = HEALBOT_MULTISTRIKE_ID,
        --    [(GetSpellInfo(HEALBOT_BREATH_OF_THE_WINDS) or "x")] = HEALBOT_MULTISTRIKE_ID,
        --    [(GetSpellInfo(HEALBOT_TENACITY) or "x")] = HEALBOT_VERSATILITY_ID,
        --    [(GetSpellInfo(HEALBOT_INDOMITABLE) or "x")] = HEALBOT_VERSATILITY_ID,
        --    [(GetSpellInfo(HEALBOT_DEFENSIVE_QUILLS) or "x")] = HEALBOT_VERSATILITY_ID,
        --    [(GetSpellInfo(HEALBOT_CHITINOUS_ARMOR) or "x")] = HEALBOT_VERSATILITY_ID,
        --    [(GetSpellInfo(HEALBOT_GRACE) or "x")] = HEALBOT_VERSATILITY_ID,
            -- Mage
        --    [(GetSpellInfo(HEALBOT_ARCANE_BRILLIANCE) or "x")] = HEALBOT_SPELL_POWER_ID,
        --    [(GetSpellInfo(HEALBOT_DALARAN_BRILLIANCE) or "x")] = HEALBOT_SPELL_POWER_ID,
            -- Monk
        --    [(GetSpellInfo(HEALBOT_LEGACY_EMPEROR) or "x")] = HEALBOT_STATS_ID,
        --    [(GetSpellInfo(HEALBOT_LEGACY_WHITETIGER) or "x")] = HEALBOT_STATS_ID,
        --    [(GetSpellInfo(HEALBOT_WINDFLURRY) or "x")] = HEALBOT_MULTISTRIKE_ID,
            -- Paladin
        --    [(GetSpellInfo(HEALBOT_BLESSING_OF_KINGS) or "x")] = HEALBOT_STATS_ID,
        --    [(GetSpellInfo(HEALBOT_BLESSING_OF_MIGHT) or "x")] = HEALBOT_MASTERY_ID,
        --    [(GetSpellInfo(HEALBOT_SANCTITY_AURA) or "x")] = HEALBOT_VERSATILITY_ID,
            -- Priest
        --    [(GetSpellInfo(HEALBOT_POWER_WORD_FORTITUDE) or "x")] = HEALBOT_STAMINA_ID,
        --    [(GetSpellInfo(HEALBOT_MIND_QUICKENING) or "x")] = HEALBOT_HASTE_ID,
            -- Warlock
        --    [(GetSpellInfo(HEALBOT_BLOOD_PACT) or "x")] = HEALBOT_STAMINA_ID,
        --    [(GetSpellInfo(HEALBOT_DARK_INTENT) or "x")] = HEALBOT_SPELL_POWER_ID,
            -- Warrior
        --    [(GetSpellInfo(HEALBOT_COMMANDING_SHOUT) or "x")] = HEALBOT_STAMINA_ID,
        --    [(GetSpellInfo(HEALBOT_BATTLE_SHOUT) or "x")] = HEALBOT_ATTACK_POWER_ID,
        --    [(GetSpellInfo(HEALBOT_INSPIRING_PRESENCE) or "x")] = HEALBOT_VERSATILITY_ID,
            -- Rogue
        --    [(GetSpellInfo(HEALBOT_SWIFTBLADES_CUNNING) or "x")] = HEALBOT_HASTE_ID,
            -- Shaman
        --    [(GetSpellInfo(HEALBOT_GRACE_OF_AIR) or "x")] = HEALBOT_MASTERY_ID,
        }
    end

    HealBot_Options_EmergencyFilter_Reset()
    HealBot_Action_sethbNumberFormat()
    HealBot_Action_sethbAggroNumberFormat()
    HealBot:RegisterEvent("PLAYER_ENTERING_WORLD");
    HealBot:RegisterEvent("PLAYER_LEAVING_WORLD");
    g=_G["HealBot_Options_SkinsFrameIconsGeneralb"]
    g:LockHighlight()
    g=_G["HealBot_Options_SkinsFramesBarsGeneralb"]
    g:LockHighlight()
    g=_G["HealBot_Options_SkinsFrameHeadersBarb"]
    g:LockHighlight()
    HealBot_Options_ObjectsEnableDisable("HealBot_FrameStickyOffsetHorizontal",false)
    HealBot_Options_ObjectsEnableDisable("HealBot_FrameStickyOffsetVertical",false)
    HealBot_Options_ObjectsEnableDisable("HealBot_Options_GroupPetsByFive",false)
    HealBot_Options_ObjectsEnableDisable("HealBot_Options_SelfPet",false)
    HealBot_Options_ShowBarsPanelVisibilityFocus(false)
    HealBot_Options_ShowBarsPanelVisibilityTargets(false)
    HealBot_Options_Init(11)
    HealBot_Action_SetResSpells()
    HealBot_setIconUpdateInterval()
    HealBot_setTooltipUpdateInterval()
    HealBot_Action_ResetSkin("init")
    if HealBot_Globals.CatchAltDebuffIDs["init"] then
        HealBot_Reset_AutoUpdateDebuffIDs()
    end
    HealBot_Load("VarsLoaded")
    HealBot_Options_Set_Current_Skin(Healbot_Config_Skins.Current_Skin)
    HealBot_luVars["hbLoaded"]=true
  --HealBot_setCall("HealBot_OnEvent_VariablesLoaded")
end

local function HealBot_OnEvent_ItemInfoReceived(self)
    HealBot:UnregisterEvent("GET_ITEM_INFO_RECEIVED");
    HealBot_setOptions_Timer(6)
  --HealBot_setCall("HealBot_OnEvent_ItemInfoReceived")
end

local function HealBot_CheckLowMana()
    for xGUID,xUnit in pairs(hbManaPlayers) do
        local xButton=HealBot_Unit_Button[xUnit]
        if xButton and xGUID==xButton.guid then
            HealBot_Action_CheckUnitLowMana(xButton)
        else
            HealBot_mark2clearGUID(xGUID)
        end
    end
  --HealBot_setCall("HealBot_CheckLowMana")
end

function HealBot_GetSpec(unit)
    local s,r,i=nil,nil,nil
    if UnitExists(unit) then
        i = GetInspectSpecialization(unit)
        if i then
            _, s, _, _, r, _ = GetSpecializationInfoByID(i)
        end
    end
    return i,s,r
end

local function HealBot_GetTalentInfo(button)
    if HEALBOT_GAME_VERSION>3 then
        local s,r,i=nil,nil,nil
        if UnitIsUnit(button.unit, "player") then
            i = GetSpecialization()
            if i then
                _, s, _, _, r, _ = GetSpecializationInfo(i,false,false) 
                if HealBot_Config.CurrentSpec~=i or HealBot_Data["PLEVEL"]~=UnitLevel("player") then 
                    HealBot_Config.CurrentSpec=i 
                    HealBot_Data["PLEVEL"]=UnitLevel("player")
                    HealBot_InitSpells()
                    HealBot_Options_ResetDoInittab(50)
                    HealBot_Options_ResetDoInittab(40)
                    HealBot_Options_ResetDoInittab(10)
                    HealBot_Options_ResetDoInittab(5)
                    HealBot_Options_ResetDoInittab(4)
                    HealBot_Options_setDebuffTypes()
                    HealBot_ClearAllBuffs()
                    HealBot_ClearAllDebuffs()
                    HealBot_setOptions_Timer(10)
                    HealBot_Action_setpcClass()
                    HealBot_Action_SetAllAttribs()
                end
            end
        else
            i,s,r = HealBot_GetSpec(button.unit)
        end
        if s then
            if button.unit=="target" then
                button.spec = " "..s.." " 
            elseif button.spec~=" "..s.." " then
                if button.spec~=" " then
                    HealBot_nextRecalcParty(6)
                end
                button.spec = " "..s.." "
                HealBot_CheckPlayerMana(button)
            end
        end
    elseif UnitIsUnit(button.unit, "player") and HealBot_Data["PLEVEL"]~=UnitLevel("player") then 
        HealBot_Data["PLEVEL"]=UnitLevel("player")
        HealBot_InitSpells()
        HealBot_Options_ResetDoInittab(50)
        HealBot_Options_ResetDoInittab(40)
        HealBot_Options_ResetDoInittab(10)
        HealBot_Options_ResetDoInittab(5)
        HealBot_Options_ResetDoInittab(4)
        HealBot_Options_setDebuffTypes()
        HealBot_ClearAllBuffs()
        HealBot_ClearAllDebuffs()
        HealBot_setOptions_Timer(10)
        HealBot_Action_setpcClass()
        HealBot_Action_SetAllAttribs()
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

function HealBot_setHighlightTargetBar()
    HealBot_luVars["hlPlayerBars"]=false
    HealBot_luVars["hlPetBars"]=false
    HealBot_luVars["hlPlayerBarsIC"]=false
    HealBot_luVars["hlPetBarsIC"]=false
    for j=1,5 do
        if Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][j]["TBAR"] then
            HealBot_luVars["hlPlayerBars"]=true
        end
        if Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][j]["TBARCOMBAT"] then
            HealBot_luVars["hlPlayerBarsIC"]=true
        end
    end
    for j=6,7 do
        if Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][j]["TBAR"] then
            HealBot_luVars["hlPetBars"]=true
        end
        if Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][j]["TBARCOMBAT"] then
            HealBot_luVars["hlPetBarsIC"]=true
        end
    end
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
        for j=1,nUnits do
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

local function HealBot_Options_Update()
    HealBot_Timers["HB1Th"]=(HealBot_Globals.RangeCheckFreq*0.1)
    if HealBot_Options_Timer[150] then
        HealBot_Action_ResetSkin("init")
        HealBot_Options_Timer[150]=nil
       -- HealBot_setOptions_Timer(595)
    elseif HealBot_Options_Timer[5] then
        HealBot_Options_InitBuffList()
        HealBot_Options_Timer[5]=nil
    elseif HealBot_Options_Timer[6] then
        HealBot_OnEvent_VariablesLoaded()
        HealBot_Options_Timer[6]=nil
    elseif HealBot_Options_Timer[10] then
        if HealBot_Config_Buffs.NoAuraWhenRested and not IsResting() then HealBot_CheckAllBuffs() end
        HealBot_Options_Timer[10]=nil
    elseif HealBot_Options_Timer[15] then
        HealBot_Options_ComboClass_Text()
        HealBot_Options_Timer[15]=nil
    elseif  HealBot_Options_Timer[405] then
        HealBot_MountsPets_InitUse()
        HealBot_Options_Timer[405]=nil
    elseif  HealBot_Options_Timer[410] then
        HealBot_MountsPets_InitMount()
        HealBot_Options_Timer[410]=nil
    elseif HealBot_Options_Timer[20] then
        HealBot_CheckAllDebuffs()
        HealBot_Options_Timer[20]=nil
    elseif HealBot_Options_Timer[25] then
        if HealBot_Globals.HealBot_Enable_MouseWheel then
            for i=1, 10 do
                local g = _G["f"..i.."_HealBot_Action"]
                g:EnableMouseWheel(1)  
                g:SetScript("OnMouseWheel", function(self, delta)
                    HealBot_Action_HealUnit_Wheel(self, delta)
                end)
            end
        end
        HealBot_Options_Timer[25]=nil
    elseif HealBot_Options_Timer[30] then
        HealBot_CheckAllBuffs()
        HealBot_Options_Timer[30]=nil
    elseif HealBot_Options_Timer[40] then
        HealBot_Options_BuffDebuff_Reset("buff")
        HealBot_Options_ResetDoInittab(5)
        HealBot_Options_Timer[40]=nil
    elseif HealBot_Options_Timer[50] then
        HealBot_Options_BuffDebuff_Reset("debuff")
        HealBot_Options_ResetDoInittab(4)
        HealBot_Options_Timer[50]=nil
    elseif HealBot_Options_Timer[60] then
        HealBot_Options_EmergencyFilter_Reset()
        HealBot_Options_Timer[60]=nil
    elseif HealBot_Options_Timer[80] then
        HealBot_Action_sethbNumberFormat()
        HealBot_Action_sethbAggroNumberFormat()
        HealBot_Action_ResetUnitStatus()
        HealBot_setOptions_Timer(595)
        HealBot_Options_Timer[80]=nil
    elseif HealBot_Options_Timer[90] then
        HealBot_SetSkinColours();
        HealBot_Options_Timer[90]=nil
    elseif HealBot_Options_Timer[100] then
        HealBot_SetBuffBarColours()
        HealBot_Options_Timer[100]=nil
    elseif HealBot_Options_Timer[110] then
        HealBot_Action_setRegisterForClicks()
        HealBot_Options_Timer[110]=nil
    elseif HealBot_Options_Timer[120] then
        HealBot_CheckZone();
        HealBot_Options_Timer[120]=nil
    elseif HealBot_Options_Timer[125] then
        HealBot_setOptions_Timer(130)
        HealBot_Options_Timer[125]=nil
    elseif HealBot_Options_Timer[160] then
        HealBot_Options_SetSkinBars()
        HealBot_Options_Timer[160]=nil
    elseif HealBot_Options_Timer[169] then
        HealBot_Options_BuffResetList()
        HealBot_Options_Timer[169]=nil
    elseif HealBot_Options_Timer[170] then
        HealBot_configClassHoT()
        HealBot_setOptions_Timer(30)
        HealBot_Options_Timer[170]=nil
    elseif  HealBot_Options_Timer[180] then
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
        HealBot_Options_Timer[180]=nil
    elseif  HealBot_Options_Timer[185] then
        if Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["HIDEBOSSF"] then
            HealBot_trackHiddenFrames["MINIBOSS"]=true
            HealBot_Options_DisableMiniBossFrame()
            if HealBot_luVars["ReloadUI"]>GetTime() then
                HealBot_Options_ReloadUI(HEALBOT_OPTIONS_HIDEMINIBOSSFRAMES.." - "..HEALBOT_WORD_ON)
            end
        elseif HealBot_trackHiddenFrames["MINIBOSS"] then
            HealBot_Options_ReloadUI(HEALBOT_OPTIONS_HIDEMINIBOSSFRAMES.." - "..HEALBOT_WORD_OFF)
        end
        HealBot_Options_Timer[185]=nil
    elseif  HealBot_Options_Timer[188] then
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
        HealBot_Options_Timer[188]=nil
    elseif HealBot_Options_Timer[190] then
        HealBot_setOptions_Timer(195)
        HealBot_PartyUpdate_CheckSkin()
        HealBot_Options_Timer[190]=nil
    elseif HealBot_Options_Timer[195] then
        HealBot_Options_InitSub(318)
        HealBot_Options_Timer[195]=nil
    elseif HealBot_Options_Timer[200] then
        local _,_,xButton = HealBot_UnitID("player", false)
        if xButton then
            HealBot_GetTalentInfo(xButton)
        end
        HealBot_Options_Timer[200]=nil
    elseif  HealBot_Options_Timer[400] then
        HealBot_Action_SetAllAttribs()
        HealBot_Options_Timer[400]=nil
    elseif  HealBot_Options_Timer[415] then
        for fNo=1,10 do
            HealBot_Action_SetAlias(fNo)
            HealBot_Action_SetAliasFontSize(fNo)
        end
        HealBot_Options_Timer[415]=nil
    elseif  HealBot_Options_Timer[419] then
        HealBot_Options_FrameAlias_initFrameSel()
        HealBot_Options_Timer[419]=nil
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
        end
    elseif HealBot_Options_Timer[550] then
        HealBot_InitSpells()
        HealBot_Options_Timer[550]=nil
    elseif not HealBot_Options_Timer[8000] and HealBot_Options_Timer[580] then
        HealBot_nextRecalcParty(6)
        HealBot_Options_Timer[580]=nil
    elseif not HealBot_Options_Timer[8000] and HealBot_Options_Timer[581] then
        HealBot_nextRecalcParty(1)
        HealBot_Options_Timer[581]=nil
    elseif not HealBot_Options_Timer[8000] and HealBot_Options_Timer[582] then
        HealBot_nextRecalcParty(2)
        HealBot_Options_Timer[582]=nil
    elseif not HealBot_Options_Timer[8000] and HealBot_Options_Timer[583] then
        HealBot_nextRecalcParty(3)
        HealBot_Options_Timer[583]=nil
    elseif not HealBot_Options_Timer[8000] and HealBot_Options_Timer[584] then
        HealBot_nextRecalcParty(4)
        HealBot_Options_Timer[584]=nil
    elseif not HealBot_Options_Timer[8000] and HealBot_Options_Timer[585] then
        HealBot_nextRecalcParty(5)
        HealBot_Options_Timer[585]=nil
    elseif HealBot_Options_Timer[595] then
        HealBot_nextRecalcParty(0)
        HealBot_Options_Timer[595]=nil
    elseif HealBot_Options_Timer[800] then
        HealBot_Options_RaidTargetUpdate()
        HealBot_Options_Timer[800]=nil
    elseif  HealBot_Options_Timer[950] then
        local _,z = GetNumMacros()
        if z>12 then
            HealBot_useCrashProtection()
        end
        HealBot_Options_Timer[950]=nil
    elseif  HealBot_Options_Timer[990] then
        HealBot_AddChat("  "..HEALBOT_ADDON .. HEALBOT_LOADED);
        HealBot_AddChat(HEALBOT_HELP[1])
        HealBot_Options_Timer[990]=nil
    elseif HealBot_Options_Timer[2001] then
        if HealBot_FrameVisible[1] then
            HealBot_Action_setPoint(1)
        end
        HealBot_Options_Timer[2001]=nil
    elseif HealBot_Options_Timer[2002] then
        if HealBot_FrameVisible[2] then
            HealBot_Action_setPoint(2)
        end
        HealBot_Options_Timer[2002]=nil
    elseif HealBot_Options_Timer[2003] then
        if HealBot_FrameVisible[3] then
            HealBot_Action_setPoint(3)
        end
        HealBot_Options_Timer[2003]=nil
    elseif HealBot_Options_Timer[2004] then
        if HealBot_FrameVisible[4] then
            HealBot_Action_setPoint(4)
        end
        HealBot_Options_Timer[2004]=nil
    elseif HealBot_Options_Timer[2005] then
        if HealBot_FrameVisible[5] then
            HealBot_Action_setPoint(5)
        end
        HealBot_Options_Timer[2005]=nil
    elseif HealBot_Options_Timer[2006] then
        if HealBot_FrameVisible[6] then
            HealBot_Action_setPoint(6)
        end
        HealBot_Options_Timer[2006]=nil
    elseif HealBot_Options_Timer[2007] then
        if HealBot_FrameVisible[7] then
            HealBot_Action_setPoint(7)
        end
        HealBot_Options_Timer[2007]=nil
    elseif HealBot_Options_Timer[2008] then
        if HealBot_FrameVisible[8] then
            HealBot_Action_setPoint(8)
        end
        HealBot_Options_Timer[2008]=nil
    elseif HealBot_Options_Timer[2009] then
        if HealBot_FrameVisible[9] then
            HealBot_Action_setPoint(9)
        end
        HealBot_Options_Timer[2009]=nil
    elseif HealBot_Options_Timer[2010] then
        if HealBot_FrameVisible[10] then
            HealBot_Action_setPoint(10)
        end
        HealBot_Options_Timer[2010]=nil
    elseif HealBot_Options_Timer[4910] then
        HealBot_Action_setLowManaTrig()
        HealBot_setOptions_Timer(4915)
        HealBot_Options_Timer[4910]=nil
    elseif HealBot_Options_Timer[4915] then
        HealBot_CheckLowMana()
        HealBot_Options_Timer[4915]=nil
    elseif HealBot_Options_Timer[4920] then
        HealBot_Options_FrameAlias_AfterTextChange()
        HealBot_Options_Timer[4920]=nil
    elseif HealBot_Options_Timer[5000] then
        HealBot_Options_DoManaIndicator_DropDown()
        HealBot_Options_DoVisibility_DropDowns()
        HealBot_Options_Timer[5000]=nil
    elseif HealBot_Options_Timer[7000] then
        for x=1,10 do
            if HealBot_FrameVisible[x] then
                HealBot_Action_setPoint(x)
            end
        end
        HealBot_Options_Timer[7000]=nil
    elseif HealBot_Options_Timer[7950] then
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
        HealBot_Options_SetEnableDisableBuffBtn()
        HealBot_SetAddonComms()
        HealBot_Options_Timer[7950]=nil
    elseif HealBot_Options_Timer[7990] then
        HealBot_Options_Timer[7990]=nil
        HealBot_VersionUpdate_Spells()
    elseif HealBot_Options_Timer[8000] then
        HealBot_Options_Timer[8000]=HealBot_Options_idleInit()
        if HealBot_Options_Timer[8000] then
            HealBot_luVars["Timer8000"]=(HealBot_luVars["Timer8000"])+1
        end
        if not HealBot_Options_Timer[8000] then
            HealBot_AddDebug("Timer 8000 called #"..HealBot_luVars["Timer8000"])
            HealBot_luVars["Timer8000"]=0
            HealBot_setqaFR()
            HealBot_CheckAllBuffs("player")
            HealBot_nextRecalcParty(0)
        end
    elseif HealBot_Options_Timer[130] then
        HealBot_Comms_SendAddonMsg(HEALBOT_HEALBOT, "R", HealBot_luVars["AddonMsgType"], HealBot_Data["PNAME"])
        HealBot_Options_Timer[130]=nil
    elseif HealBot_Options_Timer[140] then
        if GetGuildInfo("player") then HealBot_Comms_SendAddonMsg(HEALBOT_HEALBOT, "G", 5, HealBot_Data["PNAME"]) end
        HealBot_setOptions_Timer(200)
        HealBot_setOptions_Timer(800)
        HealBot_setOptions_Timer(145)
        HealBot_Options_Timer[140]=nil
    elseif HealBot_Options_Timer[145] then
        if HEALBOT_GAME_VERSION>3 then
            local x=GetNumFriends()
            if x>0 then
                for y=1,x do
                    local uName, _, _, _, z = GetFriendInfo(y)
                    if z then HealBot_Comms_SendAddonMsg(HEALBOT_HEALBOT, "F", 4, uName) end
                end
            end
        end
        HealBot_Options_Timer[145]=nil
    elseif HealBot_Options_Timer[9920] then
        HealBot_Options_Timer[9920]=nil
        HealBot_Action_SetAllAttribs()
    elseif HealBot_Options_Timer[9940] then
        HealBot_Options_Timer[9940]=nil
        if HealBot_luVars["NoSpamOOM"]<TimeNow and 
          (((UnitPower("player", 0)/UnitPowerMax("player", 0))*100) < Healbot_Config_Skins.Chat[Healbot_Config_Skins.Current_Skin]["EOCOOMV"]) then
            HealBot_luVars["NoSpamOOM"]=TimeNow+75
            DoEmote(HEALBOT_EMOTE_OOM)
            --HealBot_AddDebug(HEALBOT_EMOTE_OOM.." - mPct="..((UnitPower("player", 0)/UnitPowerMax("player", 0))*100))
        end
    elseif HealBot_Options_Timer[9980] then
        HealBot_Options_Timer[9980]=nil
        if HealBot_Check_Pets() then
            HealBot_nextRecalcParty(2)
            --HealBot_AddDebug("Exit Combat HealBot_Check_Pets RecalcParty=true")
        end
    else -- 9999 will drop in here - for set timers only
        HealBot_Set_Timers()
        HealBot_luVars["HealBot_Options_Timer"]=false
      --  HealBot_AddDebug("Leaving HealBot_Options_Timer")
    end
  --HealBot_setCall("HealBot_Options_Update")
end

local function HealBot_NoVehicle(unit)
    local HBvUnits=HealBot_VehicleUnit[unit]
    for xUnit,_ in pairs(HBvUnits) do
        if HealBot_UnitInVehicle[xUnit] then HealBot_UnitInVehicle[xUnit]=nil end
    end
	if HealBot_VehicleUnit[unit] then HealBot_VehicleUnit[unit]=nil end
  --HealBot_setCall("HealBot_NoVehicle")
end

local function HealBot_OnEvent_UnitThreat(button)
    if not UnitIsDeadOrGhost("player") then
        if UnitAffectingCombat(button.unit) then
            if not HealBot_Data["UILOCK"] and HealBot_Panel_RaidUnitGUID(button.guid) and HealBot_Globals.EnAutoCombat and UnitIsVisible(button.unit) then
                local z, y=HealBot_CalcThreat(button.unit)
                if (y+z)>0 then 
                    HealBot_OnEvent_PlayerRegenDisabled()
                    HealBot_Action_UpdateAggro(button.unit,true,y,z)
                end
            end
            if Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["SHOW"] then
                HealBot_CheckAggroUnits(button)
            end
        end
    end
  --HealBot_setCall("HealBot_OnEvent_UnitThreat")
end

local function HealBot_MaxHealth()
    if UnitExists("boss1") then
        local maxHealthPercent = select(15, UnitAura("boss1", HEALBOT_DEBUFF_AURA_OF_CONTEMPT))
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
            if healthMax~=100 or not HealBot_Panel_RaidUnitGUID(button.guid) or button.health.max<200 then
                button.health.current=health
                button.health.max=healthMax
            end
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
    local xUnit,_,xButton = HealBot_UnitID(unit, false)
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
            HealBot_Action_Refresh(xButton)
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

function HealBot_getDefaultSkin()
    local _,z = IsInInstance()
    local LastAutoSkinChangeType="None"
    local newSkinName="_-none-_"
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
    elseif HEALBOT_GAME_VERSION>3 and C_PetBattles.IsInBattle() and HealBot_luVars["lastPetBattleEvent"]~="PET_BATTLE_OVER" then
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
    end
    return newSkinName,LastAutoSkinChangeType
end

function HealBot_PartyUpdate_CheckSkin()
    local PrevSolo=HealBot_luVars["IsSolo"]
    HealBot_luVars["IsSolo"]=nil
    local newSkinName,LastAutoSkinChangeType=HealBot_getDefaultSkin()

    if LastAutoSkinChangeType~=HealBot_Config.LastAutoSkinChangeType or HealBot_Config.LastAutoSkinChangeTime<GetTime() then
        if newSkinName~="_-none-_" and newSkinName~=Healbot_Config_Skins.Current_Skin then
            HealBot_Options_Set_Current_Skin(newSkinName)
        end
        HealBot_Config.LastAutoSkinChangeType=LastAutoSkinChangeType
    end
    if (PrevSolo or "nil")~=(HealBot_luVars["IsSolo"] or "nil") then
        HealBot_setOptions_Timer(20)
        HealBot_setOptions_Timer(30)
        HealBot_Options_DisableCheck()
    end
  --HealBot_setCall("HealBot_PartyUpdate_CheckSkin")
end

local function HealBot_Not_Fighting()
    HealBot_Data["UILOCK"]=false
    --if HEALBOT_GAME_VERSION<4 then
    --    HealBot_RecalcParty(0)
    --end
    HealBot_RecalcParty(5);
    if HealBot_Config_Buffs.BuffWatch and not HealBot_Config_Buffs.BuffWatchInCombat then
        HealBot_setOptions_Timer(30)
    end
    if HealBot_Config_Cures.DebuffWatch and not HealBot_Config_Cures.DebuffWatchInCombat then
        HealBot_setOptions_Timer(20)
    end
    HealBot_Action_CheckHideFrames()
    HealBot_Action_ResetActiveUnitStatus()
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["STATE"] then
        HealBot_setOptions_Timer(9980)
    end
    if HealBot_luVars["SoftResetAfterCombat"] then
        HealBot_luVars["SoftResetAfterCombat"]=false
        HealBot_SetResetFlag("QUICK")
    end
    if HealBot_Globals.DisableToolTipInCombat and HealBot_Data["TIPUSE"] and HealBot_Data["TIPUNIT"] then
        HealBot_Action_RefreshTooltip();
    end
    HealBot_EndAggro()
    for j=1,10 do
        if Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j]["LOWMANA"]>1 and 
           Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j]["LOWMANACOMBAT"]==false then
            HealBot_setOptions_Timer(4915)
            break
        end
    end
    if HealBot_luVars["MessageReloadUI"]>0 then
        HealBot_MessageReloadUI(HealBot_luVars["MessageReloadUI"])
    end
    if Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TARGETINCOMBAT"]==1 and UnitExists("target") then
        HealBot_OnEvent_PlayerTargetChanged(true)
    end
    HealBot_EndInstanceEncounter()
    HealBot_setOptions_Timer(9999)
    if Healbot_Config_Skins.Chat[Healbot_Config_Skins.Current_Skin]["EOCOOM"] then
        HealBot_setOptions_Timer(9940)
    end
  --HealBot_setCall("HealBot_Not_Fighting")
end

local function HealBot_OnEvent_ReadyCheckClear()
    for _,xButton in pairs(HealBot_Unit_Button) do
        if xButton.icon.debuff.readycheck then
            if xButton.icon.debuff.readycheck == READY_CHECK_WAITING_TEXTURE then
                xButton.icon.debuff.readycheck = READY_CHECK_AFK_TEXTURE
            else
                xButton.icon.debuff.readycheck=false
            end
            xButton.aura.debuff.check=true
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
        if HealBot_luVars["ResetFlag"] then
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
        elseif HealBot_luVars["HealBot_Refresh"] and HealBot_luVars["HealBot_Refresh"]<TimeNow then
            if HealBot_RefreshTypes[0] then
                HealBot_RefreshTypes[1]=false
                HealBot_RefreshTypes[2]=false
                HealBot_RefreshTypes[3]=false
                HealBot_RefreshTypes[4]=false
                HealBot_RefreshTypes[5]=false
                HealBot_RefreshTypes[6]=false
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
            HealBot_luVars["HealBot_Refresh"]=false
            HealBot_needRecalcParty()
        elseif HealBot_luVars["HealBot_Options_Timer"] then
            HealBot_Options_Update()
        else
            HealBot_luVars["slowSwitch"]=HealBot_luVars["slowSwitch"]+1
            if HealBot_luVars["slowSwitch"]<2 then
                for xUnit,xGroup in pairs(HealBot_notVisible) do
                    if UnitIsVisible(xUnit) then
                        HealBot_setOptions_Timer(580+xGroup)
                        HealBot_notVisible[xUnit]=nil
                    end
                end
            elseif HealBot_luVars["slowSwitch"]<3 then
                if HealBot_DebugMsg[1] and (HealBot_luVars["nextDebugMsg"] or 0)<TimeNow then
                    HealBot_luVars["nextDebugMsg"]=TimeNow+1
                    HealBot_AddChat(HealBot_DebugMsg[1])
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
            elseif HealBot_luVars["slowSwitch"]<6 then
                if HealBot_luVars["addonMsgTh"]<TimeNow then
                    HealBot_Comms_SendAddonMessage()
                    HealBot_luVars["addonMsgTh"]=TimeNow+2
                end
            elseif HealBot_luVars["slowSwitch"]<7 then
                if HealBot_SpellID_LookupIdx[1] then
                    local sName=HealBot_SpellID_LookupIdx[1]
                    local sID=HealBot_SpellID_LookupData[sName]["ID"]
                    local class=HealBot_SpellID_LookupData[sName]["CLASS"]
                    table.remove(HealBot_SpellID_LookupIdx,1)
                    if GetSpellInfo(sID) and GetSpellInfo(sID)==sName and HealBot_Globals.WatchHoT[class][sName] then
                        HealBot_Globals.WatchHoT[class][sID]=HealBot_Globals.WatchHoT[class][sName]
                        if HealBot_Globals.IgnoreCustomBuff[sName] then
                            HealBot_Globals.IgnoreCustomBuff[sID]=HealBot_Options_copyTable(HealBot_Globals.IgnoreCustomBuff[sName])
                        end
                        if HealBot_Globals.HealBot_Custom_Buffs[sName] then
                            HealBot_Globals.HealBot_Custom_Buffs[sID]=HealBot_Globals.HealBot_Custom_Buffs[sName]
                        end
                        if HealBot_Globals.CustomBuffBarColour[sName] then
                            HealBot_Globals.CustomBuffBarColour[sID]=HealBot_Options_copyTable(HealBot_Globals.CustomBuffBarColour[sName])
                        end
                        if HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[sName] then
                            HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[sID]=HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[sName]
                        end
                        HealBot_Options_DeleteBuffHoT(class, sName)
                    end
                end
            elseif HealBot_luVars["slowSwitch"]<8 then
                HealBot_Action_DeleteMarkedButtons()
            else
                HealBot_setqaFR()
                HealBot_luVars["slowSwitch"]=0
            end
        end
    elseif not InCombatLockdown() then
        if HealBot_luVars["IsReallyFighting"] then
            HealBot_luVars["IsReallyFighting"]=false
            HealBot_Not_Fighting()
        elseif HealBot_luVars["DelayLockdownCheck"]<TimeNow then
            HealBot_luVars["IsReallyFighting"]=true
            if HealBot_Globals.EnAutoCombat then
                for xUnit,xButton in pairs(HealBot_Unit_Button) do
                    if xButton.aggro.threatpct>0 and UnitIsVisible(xUnit) then
                        HealBot_luVars["IsReallyFighting"]=false
                        break
                    end
                end
            end
        end
    end
    if HealBot_luVars["mapUpdate"] and HealBot_luVars["mapUpdate"]<TimeNow then
        HealBot_luVars["mapUpdate"]=nil
        local mapAreaID = C_Map.GetBestMapForUnit('player')
        HealBot_Data["MAPID"]=mapAreaID or 0
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

local function HealBot_AutoUpdateCustomDebuff(button, name, spellId)
    HealBot_Globals.CatchAltDebuffIDs[name]=nil
    for dID, x in pairs(HealBot_Globals.HealBot_Custom_Debuffs) do
        if (GetSpellInfo(dID) and GetSpellInfo(dID)==dName) or (not GetSpellInfo(dID) and dID==name) then
            local oldId=dID
            if dID==name then oldId=name end
            HealBot_Globals.Custom_Debuff_Categories[spellId]=HealBot_Globals.Custom_Debuff_Categories[oldId]
            HealBot_Globals.HealBot_Custom_Debuffs[spellId]=x
            if HealBot_Globals.FilterCustomDebuff[oldId] then 
                HealBot_Globals.FilterCustomDebuff[spellId]=HealBot_Globals.FilterCustomDebuff[oldId]
            end
            if HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[oldId] then
                HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[spellId]=HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[oldId]
            end
            if HealBot_Globals.CDCBarColour[oldId] then
                HealBot_Globals.CDCBarColour[spellId]=HealBot_Options_copyTable(HealBot_Globals.CDCBarColour[oldId])
            end
            if HealBot_Globals.HealBot_Custom_Debuffs_RevDur[oldId] then
                HealBot_Globals.HealBot_Custom_Debuffs_RevDur[spellId]=HealBot_Globals.HealBot_Custom_Debuffs_RevDur[oldId]
            end
            if HealBot_Globals.IgnoreCustomDebuff[oldId] then
                HealBot_Globals.IgnoreCustomDebuff[spellId]=HealBot_Options_copyTable(HealBot_Globals.IgnoreCustomDebuff[oldId])
            end
            if dID==name then 
                HealBot_Options_DeleteCDebuff(name)
            else
                HealBot_Options_CDebuffResetList()
                button.aura.debuff.check=true
            end
            break
        end
    end
end

local function HealBot_addCurDebuffs(dName,deBuffTexture,bCount,debuff_type,debuffDuration,expirationTime,spellId,unitCaster,isBossDebuff,button)
    if HealBot_Globals.CatchAltDebuffIDs[dName] then
        if not HealBot_Globals.HealBot_Custom_Debuffs[spellId] then
            HealBot_AutoUpdateCustomDebuff(button, dName, spellId)
        else
            HealBot_Globals.CatchAltDebuffIDs[dName]=nil
        end
    end
    local dNamePriority, dTypePriority=HealBot_Options_retDebuffPriority(spellId, debuff_type)
    if dTypePriority>dNamePriority and dNamePriority<21 then
        if HealBot_Globals.IgnoreCustomDebuff[spellId] and HealBot_Globals.IgnoreCustomDebuff[spellId][HealBot_luVars["hbInsName"]] then
            -- Ignore it
        else
            local castByListIndexed = HealBot_Options_getCDebuffCasyByIndexed()
            local hbCastByEveryone = castByListIndexed[HEALBOT_CUSTOM_CASTBY_EVERYONE] or -1
            local hbCastByEnemy = castByListIndexed[HEALBOT_CUSTOM_CASTBY_ENEMY] or -1
            local hbCastByFriend = castByListIndexed[HEALBOT_CUSTOM_CASTBY_FRIEND] or -1
            local hbCastBySelf = castByListIndexed[HEALBOT_OPTIONS_SELFHEALS] or -1
     
            local hbCasterID=HealBot_Globals.FilterCustomDebuff[spellId] or 0
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
            if unitCasterID==hbCasterID then 
                if not curDebuffs[spellId] then curDebuffs[spellId]={} end
                debuff_type=HEALBOT_CUSTOM_en
                curDebuffs[spellId]["priority"]=dNamePriority
                if hbCasterID==hbCastByEveryone then
                    curDebuffs[spellId]["always"]=true
                else
                    curDebuffs[spellId]["always"]=false
                end
            end
        end
    else
        local checkthis,always=false,false;
        if dTypePriority<21 then
            local spellCD=0
            local WatchTarget=nil
            if HealBot_Config_Cures.IgnoreOnCooldownDebuffs then 
                    spellCD=HealBot_Options_retDebuffWatchTargetCD(debuff_type)
            end
            if spellCD<=1.5 then
                WatchTarget=HealBot_Options_retDebuffWatchTarget(debuff_type);
            end
            if WatchTarget then 
                if WatchTarget["Raid"] then
                    checkthis=true;
                    always=true
                elseif WatchTarget["Party"] and HealBot_Panel_UnitInParty(button.unit) then 
                    checkthis=true;
                elseif WatchTarget[strsub(DebuffClass,1,4)] then
                    checkthis=true;
                elseif WatchTarget["MainTanks"] and HealBot_Panel_IsTank(button.guid) then
                    checkthis=true;
                elseif WatchTarget["SingleTank"] and UnitIsUnit(button.unit, HealBot_luVars["TankUnit"]) then
                    checkthis=true
                elseif WatchTarget["Self"] and button.guid==HealBot_Data["PGUID"] then
                    checkthis=true
                elseif WatchTarget["Name"] and xGUID==HealBot_Config.MyFriend then
                    checkthis=true
                elseif WatchTarget["Focus"] and UnitIsUnit(button.unit, "focus") then
                    checkthis=true;
                elseif WatchTarget["MyTargets"] then
                    local myhTargets=HealBot_GetMyHealTargets();
                    for i=1, #myhTargets do
                        if button.guid==myhTargets[i] then
                            checkthis=true;
                            break
                        end
                    end
                elseif WatchTarget["PvP"] and UnitIsPVP(button.unit) then
                    checkthis=true
                elseif WatchTarget["PvE"] and not UnitIsPVP(button.unit) then
                    checkthis=true
                end
            end
            if checkthis then
                if HealBot_luVars["MaskAuraDCheck"]>TimeNow then
                    checkthis=false;
                    prevDebuff["name"]="x" 
                elseif HealBot_Config_Cures.IgnoreFriendDebuffs and unitCaster and unitCaster~=button.unit and UnitIsFriend("player",unitCaster) then
                    checkthis=false;
                elseif HealBot_Config_Cures.IgnoreMovementDebuffs and HealBot_Ignore_Debuffs["Movement"][spellId] then
                    checkthis=false;
                elseif prevDebuff["name"]~=dName and HealBot_Config_Cures.IgnoreFastDurDebuffs and debuffDuration and debuffDuration>0 
                  and (debuffDuration<HealBot_Config_Cures.IgnoreFastDurDebuffsSecs or expirationTime<TimeNow+HealBot_Config_Cures.IgnoreFastDurDebuffsSecs) then
                    checkthis=false;
                elseif HealBot_Config_Cures.IgnoreNonHarmfulDebuffs and HealBot_Ignore_Debuffs["NonHarmful"][spellId] then
                    checkthis=false;
                elseif HealBot_Config_Cures.IgnoreClassDebuffs and HealBot_Ignore_Debuffs["Class"][strsub(DebuffClass,1,4)][spellId] then
                    checkthis=false;
                end
            end
        end
        if checkthis then
            if not curDebuffs[spellId] then curDebuffs[spellId]={} end
            curDebuffs[spellId]["priority"]=dTypePriority
            curDebuffs[spellId]["always"]=always
        elseif isBossDebuff and HealBot_Config_Cures.AlwaysShowBoss and (UnitExists("boss1") or not HealBot_Config_Cures.AlwaysShowBossStrict) then
            if not curDebuffs[spellId] then curDebuffs[spellId]={} end
            debuff_type=HEALBOT_CUSTOM_en
            curDebuffs[spellId]["priority"]=15
            if dTypePriority<21 then
                curDebuffs[spellId]["always"]=false
            else
                curDebuffs[spellId]["always"]=true
            end
        elseif HealBot_Config_Cures.HealBot_Custom_Defuffs_All[debuff_type] then
            if not curDebuffs[spellId] then curDebuffs[spellId]={} end
            debuff_type=HEALBOT_CUSTOM_en
            curDebuffs[spellId]["priority"]=15
            if dTypePriority<21 then
                curDebuffs[spellId]["always"]=false
            else
                curDebuffs[spellId]["always"]=true
            end
        end
    end
    if curDebuffs[spellId] then
        curDebuffs[spellId]["type"]=debuff_type
        curDebuffs[spellId]["texture"]=deBuffTexture
        curDebuffs[spellId]["bCount"]=bCount
        curDebuffs[spellId]["expirationTime"]=expirationTime
        curDebuffs[spellId]["name"]=dName
        curDebuffs[spellId]["current"]=true
        if HealBot_Globals.HealBot_Custom_Debuffs_RevDur[spellId] then
            if not HealBot_CustomDebuff_RevDurLast[spellId] then HealBot_CustomDebuff_RevDurLast[spellId]={} end
            if not HealBot_CustomDebuff_RevDurLast[spellId][button.unit] or HealBot_CustomDebuff_RevDurLast[spellId][button.unit]<(expirationTime-debuffDuration) then
                HealBot_CustomDebuff_RevDurLast[spellId][button.unit]=TimeNow
            end
        end
       -- if prevDebuff["name"]==dName then
       --     button.aura.debuff.type=curDebuffs[spellId]["type"]
       --     button.aura.debuff.priority=curDebuffs[spellId]["priority"]
       -- end
    end
  --HealBot_setCall("HealBot_addCurDebuffs")
end

local debuffIcons = {[1]={},[2]={},[3]={},[4]={},[5]={}}
local function HealBot_BumpDebuffIcon(button,id)
    local iconcount=button.icon.debuff.count
    local maxicons=Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["MAXDICONS"]-1
    if iconcount>maxicons then
        iconcount=maxicons
        button.icon.debuff.count=button.icon.debuff.count-1
    end
    for x=iconcount,id,-1 do
        debuffIcons[x+1]["name"]=debuffIcons[x]["name"]
        debuffIcons[x+1]["priority"]=debuffIcons[x]["priority"]
        debuffIcons[x+1]["texture"]=debuffIcons[x]["texture"]
        debuffIcons[x+1]["count"]=debuffIcons[x]["count"]
        debuffIcons[x+1]["expirationTime"]=debuffIcons[x]["expirationTime"]
        debuffIcons[x+1]["spellId"]=debuffIcons[x]["spellId"]
        debuffIcons[x+1]["index"]=x+51
    end
  --HealBot_setCall("HealBot_BumpDebuffIcon")
end

local function HealBot_SetDebuffIcon(button, id, spellId)
    debuffIcons[id]["name"]=curDebuffs[spellId]["name"]
    debuffIcons[id]["priority"]=curDebuffs[spellId]["priority"]
    debuffIcons[id]["texture"]=curDebuffs[spellId]["texture"]
    debuffIcons[id]["count"]=curDebuffs[spellId]["bCount"]
    debuffIcons[id]["expirationTime"]=curDebuffs[spellId]["expirationTime"]
    debuffIcons[id]["index"]=50+id
    debuffIcons[id]["spellId"]=spellId
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
        debuffIcons[button.icon.debuff.count]["spellId"]=0
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
        debuffIcons[button.icon.debuff.count]["spellId"]=0
    end
    if button.icon.debuff.readycheck and button.icon.debuff.count<5 then
        button.icon.debuff.count=button.icon.debuff.count+1
        debuffIcons[button.icon.debuff.count]["name"]="ExtraIcon"
        debuffIcons[button.icon.debuff.count]["texture"]=button.icon.debuff.readycheck
        debuffIcons[button.icon.debuff.count]["count"]=0
        debuffIcons[button.icon.debuff.count]["expirationTime"]=0
        debuffIcons[button.icon.debuff.count]["index"]=50+button.icon.debuff.count
        debuffIcons[button.icon.debuff.count]["spellId"]=0
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
                UnitDebuffIcons[debuffIcons[i]["name"]].spellId=debuffIcons[i]["spellId"]
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
    local name, texture, count, debuffType, duration, expirationTime, unitCaster, spellId, isBossDebuff = nil,nil,nil,nil,nil,nil,nil,nil,nil
    TimeNow=GetTime()
    if not button or not UnitExists(button.unit) then return end
    _,DebuffClass=UnitClass(button.unit)
    if not DebuffClass then DebuffClass=HealBot_Class_En[HEALBOT_WARRIOR] end

    prevDebuff["name"]=button.aura.debuff.name or "x"
    prevDebuff["type"]=button.aura.debuff.type or "x"
    button.aura.debuff.type=false
    for x,_ in pairs(curDebuffs) do
        curDebuffs[x].current=false;
    end
    if not UnitIsDeadOrGhost(button.unit) or UnitIsFeignDeath(button.unit) then
        local z=1
        while true do
            name=false
            if HEALBOT_GAME_VERSION<4 and libCD then
                name, texture, count, debuffType, duration, expirationTime, unitCaster, _, _, spellId = libCD:UnitAura(button.unit,z,"HARMFUL")
                if unitCaster and UnitClassification(unitCaster)=="worldboss" then
                    isBossDebuff=true
                else
                    isBossDebuff=false
                end
            else
                name, texture, count, debuffType, duration, expirationTime, unitCaster, _, _, spellId, _, isBossDebuff = UnitDebuff(button.unit,z)
            end
            if name then
                z = z +1
                if curDebuffs[spellId] and curDebuffs[spellId]["always"] and (curDebuffs[spellId]["type"]==HEALBOT_CUSTOM_en or HealBot_luVars["MaskAuraDCheck"]<TimeNow) then
                    curDebuffs[spellId]["bCount"]=count
                    curDebuffs[spellId]["expirationTime"]=expirationTime
                    curDebuffs[spellId]["current"]=true
                else
                    HealBot_addCurDebuffs(name, texture, count, debuffType, duration, expirationTime, spellId, unitCaster, isBossDebuff, button)
                end
            else
                break
            end 
        end
        z=1
        while true do
            name=false
            if HEALBOT_GAME_VERSION<4 and libCD then
                name, texture, count, debuffType, duration, expirationTime, unitCaster, _, _, spellId = libCD:UnitAura(button.unit,z,"HELPFUL")
                if unitCaster and UnitClassification(unitCaster)=="worldboss" then
                    isBossDebuff=true
                else
                    isBossDebuff=false
                end
            else
                name, texture, count, debuffType, duration, expirationTime, unitCaster, _, _, spellId, _, isBossDebuff = UnitBuff(button.unit,z)
            end
            if name then
                z = z +1
                if HealBot_Globals.HealBot_Custom_Debuffs[spellId] then 
                    if curDebuffs[spellId] and curDebuffs[spellId]["always"] then
                        curDebuffs[spellId]["bCount"]=count
                        curDebuffs[spellId]["expirationTime"]=expirationTime
                        curDebuffs[spellId]["current"]=true
                    else
                        HealBot_addCurDebuffs(name, texture, count, debuffType, duration, expirationTime, spellId, unitCaster, isBossDebuff, button)
                    end
                end
            else
                break
            end 
        end
        for spellId,_ in pairs(HealBot_CustomDebuff_RevDurLast) do
            if not curDebuffs[spellId] and HealBot_CustomDebuff_RevDurLast[spellId][button.unit] then 
                HealBot_CustomDebuff_RevDurLast[spellId][button.unit]=nil 
            end
        end
    end
    
    local dPrio = 99    
    HealBot_luVars["prevIconCount"]=button.icon.debuff.count
    button.icon.debuff.count=0
    
    for spellId,_ in pairs(curDebuffs) do
        if curDebuffs[spellId]["current"] then
            if curDebuffs[spellId]["priority"]<dPrio then
                button.aura.debuff.type=curDebuffs[spellId]["type"]
                button.aura.debuff.name=curDebuffs[spellId]["name"]
                button.aura.debuff.id=spellId
                button.aura.debuff.priority=curDebuffs[spellId]["priority"]
                dPrio=curDebuffs[spellId]["priority"]
            end
            if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWDEBUFF"] and (HealBot_Data["PGUID"]==button.guid or UnitIsVisible(button.unit)) and curDebuffs[spellId]["texture"] then
                local iconset=false
                if button.icon.debuff.count>0 then
                    for x=1, button.icon.debuff.count do
                        if debuffIcons[x]["priority"]>curDebuffs[spellId]["priority"] then
                            if x<Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["MAXDICONS"] then 
                                HealBot_BumpDebuffIcon(button,x) 
                                button.icon.debuff.count=button.icon.debuff.count+1
                            end
                            HealBot_SetDebuffIcon(button, x, spellId)
                            iconset=true
                            break
                        end
                    end
                end
                if not iconset and button.icon.debuff.count < Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["MAXDICONS"] then
                    button.icon.debuff.count=button.icon.debuff.count+1
                    HealBot_SetDebuffIcon(button, button.icon.debuff.count, spellId)
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
            if HealBot_Config_Cures.CDCshownAB and HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[button.aura.debuff.id] then
                if button.status.range>(HealBot_Config_Cures.HealBot_CDCWarnRange_Aggro-3) then
                    HealBot_Action_UpdateAggro(button.unit,"debuff",debuffCodes[button.aura.debuff.type], 0)
                end
            end
            if HealBot_Config_Cures.ShowDebuffWarning and button.status.range>(HealBot_Config_Cures.HealBot_CDCWarnRange_Screen-3) then
                if HealBot_Globals.CDCBarColour[button.aura.debuff.id] then
                    UIErrorsFrame:AddMessage(HealBot_GetUnitName(button.unit, button.guid).." suffers from "..button.aura.debuff.name, 
                                             HealBot_Globals.CDCBarColour[button.aura.debuff.id].R,
                                             HealBot_Globals.CDCBarColour[button.aura.debuff.id].G,
                                             HealBot_Globals.CDCBarColour[button.aura.debuff.id].B,
                                             1, UIERRORS_HOLD_TIME);
                elseif button.aura.debuff.type == HEALBOT_CUSTOM_en then
                    local customDebuffPriority=HEALBOT_CUSTOM_en.."15"
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
        HealBot_luVars["debuffExists"]=true
    end
  --HealBot_setCall("HealBot_CheckUnitDebuffs")
end

local function HealBot_doAuraDebuffUnit(button)
    if HealBot_Config_Buffs.NoAuraWhenRested and IsResting() then 
        HealBot_CheckUnitDebuffIconsExtras(button)
        if HealBot_luVars["debuffExists"] then
            HealBot_luVars["debuffExists"]=false
            HealBot_ClearAllDebuffs()
        end
    elseif (not HealBot_Config_Cures.DebuffWatchWhenGrouped or GetNumGroupMembers()>0) and 
           (HealBot_Config_Cures.DebuffWatchInCombat or not HealBot_Data["UILOCK"]) then
        if UnitIsFriend("player",button.unit) then
            HealBot_CheckUnitDebuffs(button)
        else
            HealBot_CheckUnitDebuffIconsExtras(button)
        end
    else
        HealBot_CheckUnitDebuffIconsExtras(button)
        if HealBot_luVars["debuffExists"] then
            HealBot_luVars["debuffExists"]=false
            HealBot_ClearAllDebuffs()
        end
    end
  --HealBot_setCall("HealBot_doAuraDebuffUnit")
end

local function HealBot_ResetCheckBuffsTime(button)
    local lowTime=TimeNow+10000000
    local PlayerBuffsList=button.aura.buff.recheck
    button.aura.buff.nextcheck=false
    for name,nexttime in pairs (PlayerBuffsList) do
        if nexttime<0 then
            PlayerBuffsList[name]=nil
        elseif nexttime < lowTime then
            lowTime=nexttime
            button.aura.buff.nextcheck=nexttime
        end
    end
  --HealBot_setCall("HealBot_ResetCheckBuffsTime")
end

local function HealBot_SetUnitBuffTimer(button,buffName,endtime)
    if HealBot_ShortBuffs[buffName] then 
        button.aura.buff.recheck[buffName] = endtime-HealBot_Config_Buffs.ShortBuffTimer
    else
        button.aura.buff.recheck[buffName] = endtime-HealBot_Config_Buffs.LongBuffTimer
    end
    button.aura.buff.nextcheck=1
  --HealBot_setCall("HealBot_SetUnitBuffTimer")
end

local hasBuffTypes = false
local function HealBot_HasBuffTypes(spellName, pBuffTypes, ownBlessing)
    hasBuffTypes = false
    if HealBot_BuffNameTypes[spellName] then
        if pBuffTypes[HealBot_BuffNameTypes[spellName]] or (ownBlessing and HealBot_BuffNameTypes[spellName]<7 and HealBot_Config_Buffs.PalaBlessingsAsOne) then
            hasBuffTypes = true
        end
    end
  --HealBot_setCall("HealBot_HasBuffTypes")
    return hasBuffTypes
end

local hbExcludeSpells = { [67358]="Rejuvenating",
                          [58597]="Sacred Shield",
                          --[65148]="Sacred Shield",
                        }
                        
local hbExcludeBuffSpells = { [65148]="Sacred Shield",
                        }

local buffIcons = {[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
local function HealBot_CheckUnitBuffIcons(button)
    if button.icon.buff.count<HealBot_luVars["prevBuffIconCount"] then 
        for i = HealBot_luVars["prevBuffIconCount"], button.icon.buff.count+1, -1 do
            HealBot_RemoveIcon(button, i)
        end
    end    
    UnitBuffIcons=HealBot_UnitBuffIcons[button.unit]
    for bName,_ in pairs(UnitBuffIcons) do
        UnitBuffIcons[bName].current=false
    end
    if button.icon.buff.count>0 then
        for i = 1, button.icon.buff.count do
            if i==1 then
                button.aura.buff.priority=buffIcons[i]["priority"]
            end
            if not UnitBuffIcons[buffIcons[i]["name"]] then 
                UnitBuffIcons[buffIcons[i]["name"]]={}
            end
            UnitBuffIcons[buffIcons[i]["name"]].count=buffIcons[i]["count"]
            UnitBuffIcons[buffIcons[i]["name"]].expirationTime=buffIcons[i]["expirationTime"]
            UnitBuffIcons[buffIcons[i]["name"]].unitCaster=buffIcons[i]["unitCaster"]
            UnitBuffIcons[buffIcons[i]["name"]].current=true
            if ((UnitBuffIcons[buffIcons[i]["name"]].index or 0)~=buffIcons[i]["index"]) or (UnitBuffIcons[buffIcons[i]["name"]].texture~=buffIcons[i]["texture"]) then
                UnitBuffIcons[buffIcons[i]["name"]].texture=buffIcons[i]["texture"]
                UnitBuffIcons[buffIcons[i]["name"]].index = buffIcons[i]["index"]
                HealBot_AddIcon(button, buffIcons[i])
            end
            if buffIcons[i]["expirationTime"]>0 then
                UnitBuffIcons[buffIcons[i]["name"]].nextUpdate=floor(TimeNow-2) + buffIcons[i]["expirationTime"]%3 + 0.002
            else
                UnitBuffIcons[buffIcons[i]["name"]].nextUpdate=TimeNow+1000000
                HealBot_UpdateIcon(button, buffIcons[i])
            end
        end
    end
    for bName,_ in pairs(UnitBuffIcons) do
        if not UnitBuffIcons[bName].current and UnitBuffIcons[bName].index>0 then
            UnitBuffIcons[bName].index=0
            UnitBuffIcons[bName].nextUpdate=TimeNow+1000000
        end
    end
  --HealBot_setCall("HealBot_CheckUnitDebuffIcons")
end

local function HealBot_BumpBuffIcon(button,id)
    local iconcount=button.icon.buff.count
    local maxicons=Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["MAXBICONS"]-1
    if iconcount>maxicons then 
        iconcount=maxicons 
        button.icon.buff.count=button.icon.buff.count-1
    end
    for x=iconcount,id,-1 do
        buffIcons[x+1]["name"]=buffIcons[x]["name"]
        buffIcons[x+1]["priority"]=buffIcons[x]["priority"]
        buffIcons[x+1]["texture"]=buffIcons[x]["texture"]
        buffIcons[x+1]["count"]=buffIcons[x]["count"]
        buffIcons[x+1]["spellId"]=buffIcons[x]["spellId"]
        buffIcons[x+1]["expirationTime"]=buffIcons[x]["expirationTime"]
        buffIcons[x+1]["unitCaster"]=buffIcons[x]["unitCaster"]
        buffIcons[x+1]["index"]=x+1
    end
  --HealBot_setCall("HealBot_BumpBuffIcon")
end

local function HealBot_CacheBuffIcon(button, id, name, texture, count, expirationTime, unitCaster, spellId, priority)
    buffIcons[id]["name"]=name
    buffIcons[id]["priority"]=priority
    buffIcons[id]["texture"]=texture
    buffIcons[id]["count"]=count
    buffIcons[id]["spellId"]=spellId
    buffIcons[id]["expirationTime"]=expirationTime
    buffIcons[id]["unitCaster"]=unitCaster
    buffIcons[id]["index"]=id
  --HealBot_setCall("HealBot_CacheBuffIcon")
end

local function HealBot_SetBuffIcon(button, name, texture, count, expirationTime, unitCaster, spellId, cIcons)
    if HealBot_SpellID_LookupData[name] and HealBot_SpellID_LookupData[name]["CHECK"] then
        HealBot_SpellID_LookupData[name]["CHECK"]=false
        HealBot_SpellID_LookupData[name]["ID"]=spellId
        table.insert(HealBot_SpellID_LookupIdx,name)
    end
    if HealBot_Globals.IgnoreCustomBuff[spellId] and HealBot_Globals.IgnoreCustomBuff[spellId][HealBot_luVars["hbInsName"]] then
        -- Ignore it
    else
        local iconset=false
        local bPrio=HealBot_Globals.HealBot_Custom_Buffs[spellId] or 10
        local cPrio=true
        if button.icon.buff.count>0 then
            for x=1, button.icon.buff.count do
                if buffIcons[x]["priority"]>bPrio then
                    if cIcons then
                        HealBot_BumpBuffIcon(button,x) 
                        button.icon.buff.count=button.icon.buff.count+1
                        HealBot_CacheBuffIcon(button, x, name, texture, count, expirationTime, unitCaster, spellId, bPrio)
                        iconset=true
                    end
                    break
                elseif HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[buffIcons[x]["spellId"]] then
                    cPrio=false
                end
            end
        end
        if cIcons and not iconset and button.icon.buff.count<Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["MAXBICONS"] then
            button.icon.buff.count=button.icon.buff.count+1
            HealBot_CacheBuffIcon(button, button.icon.buff.count, name, texture, count, expirationTime, unitCaster, spellId, bPrio)
        end
        if HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[spellId] and cPrio then
            return true
        end
    end
    return false
  --HealBot_setCall("HealBot_SetBuffIcon")
end

local function HealBot_CheckUnitBuffs(button)
    local xGUID=button.guid
    local xUnit=button.unit   
    if not xUnit or not UnitExists(xUnit) then return end
    local doBuffCheck=true
    if HealBot_Config_Buffs.NoAuraWhenRested and IsResting() then 
        if HealBot_luVars["buffExists"] then
            HealBot_luVars["buffExists"]=false
            HealBot_ClearAllBuffs()
        end
        doBuffCheck=false 
    end
    local cBuffs=false
    local gBuffs=false
    local cIcons=false
    local curBuffName=nil;
    local doResetBuffTime=false
    local ownBlessing=false
    local onlyPlayers=UnitIsPlayer(xUnit)
    if HEALBOT_GAME_VERSION<4 then onlyPlayers=UnitIsFriend("player", xUnit) end
    if HealBot_Config_Buffs.BuffWatch then
        cBuffs=true
        if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWBUFF"] then 
            cIcons=true
        end
        if (not HealBot_Config_Buffs.BuffWatchWhenGrouped or GetNumGroupMembers()>0) and (HealBot_Config_Buffs.BuffWatchInCombat or not HealBot_Data["UILOCK"]) and onlyPlayers then
            gBuffs=true
        end
    end
    if cIcons then 
        HealBot_luVars["prevBuffIconCount"]=button.icon.buff.count
        button.icon.buff.count=0
    end
    if doBuffCheck then 
        local name, texture, count, expirationTime, unitCaster, spellId = nil,nil,nil,nil,nil,nil
        TimeNow=GetTime()
        local _,BuffClass=UnitClass(xUnit)
        if not BuffClass then BuffClass=HealBot_Class_En[HEALBOT_WARRIOR] end   
        if gBuffs then 
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
                name=false
                if HEALBOT_GAME_VERSION<4 and libCD then
                    name, texture, count, _, _, expirationTime, unitCaster, _, _, spellId = libCD:UnitAura(button.unit,z,"HARMFUL")
                else
                    name, texture, count, _, _, expirationTime, unitCaster, _, _, spellId = UnitDebuff(button.unit,z)
                end
                if name then
                    z=z+1
                    if unitCaster and unitCaster=="player" and expirationTime and not hbExcludeSpells[spellId] then
                        if HealBot_SetBuffIcon(button, name, texture, count, expirationTime, unitCaster, spellId, cIcons) then
                            curBuffName=HEALBOT_CUSTOM_en
                            button.aura.buff.id=spellId
                        end
                    end
                else
                    break
                end
            end
        else
            while true do
                name=false
                if HEALBOT_GAME_VERSION<4 and libCD then
                    name, texture, count, _, _, expirationTime, unitCaster, _, _, spellId, _, _ = libCD:UnitAura(button.unit,z,"HELPFUL")
                else
                    name, texture, count, _, _, expirationTime, unitCaster, _, _, spellId, _, _ = UnitBuff(button.unit,z)
                end
                if name then
                    z = z +1
                    if cBuffs then 
                        if unitCaster and expirationTime and not hbExcludeSpells[spellId] then
                            local y=HealBot_Watch_HoT[name] or HealBot_Watch_HoT[spellId] or "nil"
                            local _, uClassEN = UnitClass(xUnit);
                            local uClassTrim = strsub(uClassEN or "XXXX",1,4)
                           -- HealBot_AddDebug("y="..y.." - name="..name)
                            if (y=="A" or (y=="S" and unitCaster=="player") or (y=="C" and HealBot_Data["PCLASSTRIM"]==uClassTrim)) then
                                if HealBot_SetBuffIcon(button, name, texture, count, expirationTime, unitCaster, spellId, cIcons) then
                                    curBuffName=HEALBOT_CUSTOM_en
                                    button.aura.buff.id=spellId
                                end
                            end
                        end
                    end
                    if gBuffs then
                        if HealBot_Buff_Aura2Item[spellId] then
                            name=GetItemInfo(HealBot_Buff_Aura2Item[spellId]) or name
                        end
                        if HealBot_BuffNameTypes[name] and (not button.aura.buff.recheck[name] or button.aura.buff.recheck[name]>TimeNow) then
                            if HealBot_BuffNameTypes[name] then
                                if HealBot_BuffNameTypes[name]<7 and xUnit==unitCaster then ownBlessing=true end
                                PlayerBuffTypes[HealBot_BuffNameTypes[name]]=true
                            end
                        end
                        if not hbExcludeBuffSpells[spellId] then
                            PlayerBuffs[name]=true
                            if HealBot_CheckBuffs[name] then
                                if expirationTime-TimeNow>0 then
                                    HealBot_SetUnitBuffTimer(button,name,expirationTime)
                                elseif button.aura.buff.recheck[name] then
                                    button.aura.buff.recheck[name]=nil
                                    doResetBuffTime=true
                                end
                            end
                        end
                    end
                else
                    break
                end 
            end
        end
        
        if gBuffs then
            local PlayerBuffsList=button.aura.buff.recheck
            for bName,nexttime in pairs (PlayerBuffsList) do
                if not PlayerBuffs[bName] then
                    PlayerBuffsList[bName]=nil
                    doResetBuffTime=true
                elseif nexttime < TimeNow then
                    PlayerBuffs[bName]=nil
                end
            end
            if doResetBuffTime then HealBot_ResetCheckBuffsTime(button) end
            for bName,_ in pairs(HealBot_BuffWatch) do
                if not PlayerBuffs[bName] and not HealBot_HasBuffTypes(bName, PlayerBuffTypes, ownBlessing) then
                    local checkthis=false;
                    local WatchTarget=HealBot_Options_retBuffWatchTarget(bName);
                    local z, x = nil, nil
                    if HealBot_Spell_Names[bName] then
                        z, x = GetSpellCooldown(bName);
                    elseif UnitIsUnit("player",xUnit) and HealBot_Options_retItemID(bName) then
                        local getCD = false
                        if HealBot_Options_retItemID(bName)~=HEALBOT_EVER_BLOOMING_FROND then
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
                            end
                        end
                        if getCD then
                            z, x = GetItemCooldown(HealBot_Options_retItemID(bName)) -- Using the name returns errors
                        end
                    end
                    if not x then
                        -- Spec change within that last few secs - buff outdated so do nothing
                    elseif x<2 then
                        if WatchTarget["Raid"] then
                            checkthis=true;
                        elseif WatchTarget["Party"] and HealBot_Panel_UnitInParty(xUnit) then 
                            checkthis=true
                        elseif WatchTarget[strsub(BuffClass,1,4)] then
                            checkthis=true
                        elseif WatchTarget["MainTanks"] and HealBot_Panel_IsTank(xGUID) then
                            checkthis=true;
                        elseif WatchTarget["SingleTank"] and UnitIsUnit(xUnit, HealBot_luVars["TankUnit"]) then
                            checkthis=true
                        elseif WatchTarget["Self"] and xGUID==HealBot_Data["PGUID"] then
                            checkthis=true
                        elseif WatchTarget["Name"] and xGUID==HealBot_Config.MyFriend then
                            checkthis=true
                        elseif WatchTarget["Focus"] and UnitIsUnit(xUnit, "focus") then
                            checkthis=true
                        elseif WatchTarget["MyTargets"] then
                            local myhTargets=HealBot_GetMyHealTargets();
                            for i=1, #myhTargets do
                                if xGUID==myhTargets[i] then
                                    checkthis=true;
                                    break;
                                end
                            end
                        elseif WatchTarget["PvP"] and UnitIsPVP(xUnit) then
                            checkthis=true
                        elseif WatchTarget["PvE"] and not UnitIsPVP(xUnit) then
                            checkthis=true
                        end
                    end
                    if checkthis then
                        curBuffName=bName;
                        break
                    end
                end
            end
        end
    end
    if cIcons then 
        HealBot_CheckUnitBuffIcons(button)
    end
    if curBuffName then
        if button.aura.buff.name~=curBuffName or curBuffName==HEALBOT_CUSTOM_en then
            button.aura.buff.name=curBuffName;
            if HealBot_Config_Buffs.SoundBuffWarning and button.status.range>(HealBot_Config_Buffs.HealBot_CBWarnRange_Sound-3) then
                HealBot_PlaySound(HealBot_Config_Buffs.SoundBuffPlay)
            end
            if HealBot_Config_Buffs.CBshownAB and button.status.range>(HealBot_Config_Buffs.HealBot_CBWarnRange_Aggro-3) then
                HealBot_Action_UpdateAggro(button.unit,"buff",4, 0)
            end
            if HealBot_Config_Buffs.ShowBuffWarning and button.status.range>(HealBot_Config_Buffs.HealBot_CBWarnRange_Screen-3) then
                if HealBot_BuffWatch[button.aura.buff.name] and HealBot_Config_Buffs.HealBotBuffColR[HealBot_BuffWatch[button.aura.buff.name]] then
                    UIErrorsFrame:AddMessage(HealBot_GetUnitName(button.unit, button.guid).." requires "..button.aura.buff.name, 
                                             HealBot_Config_Buffs.HealBotBuffColR[HealBot_BuffWatch[button.aura.buff.name]],
                                             HealBot_Config_Buffs.HealBotBuffColG[HealBot_BuffWatch[button.aura.buff.name]],
                                             HealBot_Config_Buffs.HealBotBuffColB[HealBot_BuffWatch[button.aura.buff.name]],
                                             1, UIERRORS_HOLD_TIME);
                else
                    local bName=GetSpellInfo(button.aura.buff.id)
                    if bName and HealBot_luVars["lastBuffMsg"]~=bName then
                        HealBot_luVars["lastBuffMsg"]=bName
                        if HealBot_Globals.CustomBuffBarColour[button.aura.buff.id] then
                            UIErrorsFrame:AddMessage(HealBot_GetUnitName(button.unit, button.guid).." benefits from "..bName, 
                                                     HealBot_Globals.CustomBuffBarColour[button.aura.buff.id].R,
                                                     HealBot_Globals.CustomBuffBarColour[button.aura.buff.id].G,
                                                     HealBot_Globals.CustomBuffBarColour[button.aura.buff.id].B,
                                                     1, UIERRORS_HOLD_TIME);
                        else
                            local customBuffPriority=HEALBOT_CUSTOM_en.."Buff"
                            UIErrorsFrame:AddMessage(HealBot_GetUnitName(button.unit, button.guid).." benefits from "..bName,
                                                     HealBot_Globals.CustomBuffBarColour[customBuffPriority].R,
                                                     HealBot_Globals.CustomBuffBarColour[customBuffPriority].G,
                                                     HealBot_Globals.CustomBuffBarColour[customBuffPriority].B,
                                                     1, UIERRORS_HOLD_TIME);
                        end
                    end
                end
            end
        end
        HealBot_Action_UpdateDebuffButton(button)
        HealBot_luVars["buffExists"]=true
    elseif button.aura.buff.name then 
        HealBot_ClearBuff(button)
        HealBot_luVars["lastBuffMsg"]="nil"
        if HealBot_Config_Buffs.CBshownAB then
            HealBot_Action_UpdateAggro(button.unit,"off",nil,0)
        end
    end 
  --HealBot_setCall("HealBot_CheckUnitBuffs")
end

function HealBot_CheckAggroUnits(button)
    if UnitExists(button.unit) then
        local z, y=HealBot_CalcThreat(button.unit)
        if (z+y)==0 then
            HealBot_ClearUnitAggro(button)
        elseif z~=button.aggro.threatpct then
            HealBot_Action_UpdateAggro(button.unit,true,y,z)
            if button.icon.debuff.readycheck == READY_CHECK_AFK_TEXTURE then
                button.icon.debuff.readycheck=false
                button.aura.debuff.check=true
            end
        end
    else
        HealBot_ClearUnitAggro(button)
    end
  --HealBot_setCall("HealBot_CheckAggroUnits")
end

local HealBot_iconUpdate={[1]=0.2,[2]=0.2,[3]=0.2,[4]=0.2,[5]=0.2,[6]=0.2,[7]=0.2,[8]=0.2,[9]=0.2,[10]=0.2,}
function HealBot_setIconUpdateInterval()
    for f=1,10 do
        if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][f]["FADE"] then
            HealBot_iconUpdate[f]=0.2
        else
            HealBot_iconUpdate[f]=1
        end
    end
  --HealBot_setCall("HealBot_setIconUpdateInterval")
end

local function HealBot_Update_UnitIcons(button)
    UnitBuffIcons=HealBot_UnitBuffIcons[button.unit]
    for name,_ in pairs(UnitBuffIcons) do
        if UnitBuffIcons[name].nextUpdate<TimeNow then
            UnitBuffIcons[name].nextUpdate=UnitBuffIcons[name].nextUpdate+HealBot_iconUpdate[button.frame]
            HealBot_UpdateIcon(button, UnitBuffIcons[name])
        end
    end
    UnitDebuffIcons=HealBot_UnitDebuffIcons[button.unit]
    for name,_ in pairs(UnitDebuffIcons) do
        if UnitDebuffIcons[name].nextUpdate<TimeNow then
            UnitDebuffIcons[name].nextUpdate=UnitDebuffIcons[name].nextUpdate+HealBot_iconUpdate[button.frame]
            HealBot_UpdateIcon(button, UnitDebuffIcons[name])
        end
    end
end

local function HealBot_UnitUpdateHealth(button)
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

local function HealBot_UnitUpdateFriendly(button)
    if button.status.update then
        if button.update.reset then
            button.update.reset=false
            HealBot_UpdateUnitReset(button)
            button.update.unit=true
        elseif button.update.unit then
            HealBot_UpdateUnit(button)
            button.update.unit=false
        elseif button.update.state then
            button.update.state=false
            HealBot_Action_Refresh(button) 
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
        if button.status.dirarrow<99998 or (not IsInInstance() and button.status.range<1) then
            HealBot_Action_ShowDirectionArrow(button)
        end
        if button.aggro.threatpct > 0 then 
            HealBot_CheckAggroUnits(button) 
        elseif button.status.current==9 then 
            HealBot_Action_UpdateTheDeadButton(button)
        elseif button.status.offline and UnitIsConnected(button.unit) then
            button.status.offline = false
            HealBot_Action_setNameTag(button)
            button.update.state=true
            button.status.update=true                      
        elseif not button.status.offline and not UnitIsConnected(button.unit) then
            button.status.offline = TimeNow
            HealBot_Action_setNameTag(button)
            button.update.state=true
            button.status.update=true
        elseif button.aura.buff.nextcheck and button.aura.buff.nextcheck<TimeNow and not UnitOnTaxi("player") then
            if button.aura.buff.nextcheck==1 then
                HealBot_ResetCheckBuffsTime(button)
            else
                button.aura.buff.check=true
                button.aura.buff.nextcheck=false
            end
        elseif button.health.current<button.health.max then
            button.health.updhealth=true
            button.health.update=true
        end
    end
end

local function HealBot_UnitUpdateCheckDebuff(button)
    if button.aura.debuff.check then
        button.aura.debuff.check=false
        HealBot_doAuraDebuffUnit(button) 
    end
    if button.health.update then
        button.health.update=false
        HealBot_UnitUpdateHealth(button)
    end
end

local function HealBot_UnitUpdateCheckBuff(button)
    if button.status.current>0 or button.status.range<1 or not UnitInRange(button.unit) or not HealBot_UnitInPhase(button.unit) then
        HealBot_UpdateUnitRange(button, button.spells.rangecheck, true)
    end
    if button.aura.buff.check and not UnitOnTaxi("player") then
        button.aura.buff.check=false
        HealBot_CheckUnitBuffs(button)
    end
    if button.checks.timed < TimeNow then
        HealBot_Player_CheckTime(button)
        HealBot_UnitUpdateFriendly(button)
    end
    HealBot_Update_UnitIcons(button)
end

local function HealBot_UnitUpdateEnemy(button)
    if button.checks.timed < TimeNow then
        HealBot_Enemy_CheckTime(button)
        if UnitIsDeadOrGhost(button.unit) then
            button.health.current=0
            HealBot_Action_Refresh(button)
        else
            local xGUID=UnitGUID(button.unit) or button.unit
            if xGUID~=button.guid then
                button.guid=xGUID
                HealBot_UpdateUnit(button)
            else
                if HEALBOT_GAME_VERSION>3 then 
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
                end
                button.health.updhealth=true
                button.health.updincoming=true
                button.health.updabsorbs=true
                button.health.update=true
                HealBot_CheckUnitBuffs(button)
                HealBot_Update_UnitIcons(button)
            end
        end
    end
end

local function HealBot_UnitUpdateButton(button, dmask, bmask)
    if not button.status.reserved then
        if UnitExists(button.unit) then
            if button.bucket==dmask then
                HealBot_UnitUpdateCheckDebuff(button)
            end
            if button.bucket==bmask then
                HealBot_UnitUpdateCheckBuff(button)
            end
        else
            HealBot_UpdateUnitReset(button)
            HealBot_UpdateUnit(button)
            button.status.reserved=true
        end
    elseif UnitExists(button.unit) then
        button.status.reserved=false
        button.update.unit=true
        button.status.update=true
    end
end

HealBot_luVars["petSwitch"]=0
local function HealBot_Update_Fast()
    HealBot_luVars["fastSwitch"]=HealBot_luVars["fastSwitch"]+1
    if HealBot_luVars["fastSwitch"]<2 then
        for _,xButton in pairs(HealBot_Unit_Button) do
            HealBot_UnitUpdateButton(xButton, 1, 3)
        end
    elseif HealBot_luVars["fastSwitch"]<3 then
        for xUnit,xButton in pairs(HealBot_Enemy_Button) do
            if not xButton.status.reserved then
                if UnitExists(xUnit) then
                    if xButton.health.update then
                        xButton.health.update=false
                        HealBot_UnitUpdateHealth(xButton) 
                    end
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
    elseif HealBot_luVars["fastSwitch"]<4 then
        for _,xButton in pairs(HealBot_Unit_Button) do
            HealBot_UnitUpdateButton(xButton, 2, 4)
        end
    elseif HealBot_luVars["fastSwitch"]<5 then
        for _,xButton in pairs(HealBot_Pet_Button) do
            HealBot_UnitUpdateButton(xButton, 1, 1)
        end
    elseif HealBot_luVars["fastSwitch"]<6 then
        for _,xButton in pairs(HealBot_Unit_Button) do
            HealBot_UnitUpdateButton(xButton, 3, 1)
        end
    elseif HealBot_luVars["fastSwitch"]<7 then
        for _,xButton in pairs(HealBot_Unit_Button) do
            HealBot_UnitUpdateButton(xButton, 4, 2)
        end
    else
        if HealBot_Data["TIPUSE"] and HealBot_Globals.TooltipUpdate and HealBot_Data["TIPUNIT"] and HealBot_luVars["PrevTipTime"]<TimeNow then 
            HealBot_luVars["PrevTipTime"]=TimeNow+HealBot_luVars["TipTimeInterval"]
            HealBot_Action_RefreshTooltip() 
        end
        if HealBot_luVars["MaskAuraDCheck"]<TimeNow and HealBot_luVars["MaskAuraReCheck"] then
            HealBot_luVars["MaskAuraReCheck"]=nil
            HealBot_CheckAllActiveDebuffs()
        end
        HealBot_luVars["fastSwitch"]=0
    end
    if HealBot_luVars["EnableErrorSpeech"] then
        HealBot_luVars["EnableErrorSpeech"]=false
        SetCVar("Sound_EnableErrorSpeech", "1");
    elseif HealBot_luVars["EnableErrorText"] then
        HealBot_luVars["EnableErrorText"]=false
        UIErrorsFrame:Clear()
        UIErrorsFrame:Show()
    end
    --HealBot_setCall("HealBot_Update_Fast")
end

local lTimer,eTimer=0,GetTime()
function HealBot_OnUpdate(self)
    if HealBot_luVars["hbLoaded"] then
        TimeNow=GetTime()
        lTimer=TimeNow-eTimer
        eTimer=TimeNow
        HealBot_Timers["HB1Inc"] = HealBot_Timers["HB1Inc"]+lTimer;
        HealBot_Timers["HB2Inc"] = HealBot_Timers["HB2Inc"]+lTimer;
        HealBot_Timers["HBaInc"] = HealBot_Timers["HBaInc"]+lTimer;
        if HealBot_Timers["HB1Inc"]>=HealBot_Timers["HB1Th"] then
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
        if HealBot_luVars["reCheckActionFrames"] then
            HealBot_luVars["reCheckActionFrames"]=false
            HealBot_Action_CheckFrameSetPoint()
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
    if HEALBOT_GAME_VERSION>3 then
        HealBot:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE")
        HealBot:RegisterEvent("UNIT_THREAT_LIST_UPDATE")
    else
        libCTM = libCTM or LibStub("ThreatClassic-1.0", true)
    end
  --HealBot_setCall("HealBot_Register_Aggro")
end

function HealBot_UnRegister_Aggro()
    HealBot:UnregisterEvent("UNIT_COMBAT")
    if HEALBOT_GAME_VERSION>3 then
        HealBot:UnregisterEvent("UNIT_THREAT_SITUATION_UPDATE")
        HealBot:UnregisterEvent("UNIT_THREAT_LIST_UPDATE")
    end
    HealBot_EndAggro() 
  --HealBot_setCall("HealBot_UnRegister_Aggro")
end

function HealBot_Register_IncHeals()
    if HEALBOT_GAME_VERSION>3 then
        HealBot:RegisterEvent("UNIT_HEAL_PREDICTION")
    else
        libCHC = libCHC or LibStub("LibClassicHealComm-1.0", true)
        
        if libCHC then
            libCHC.RegisterCallback(HEALBOT_HEALBOT, "HealComm_HealStarted", 
                function(event, casterGUID, spellID, healType, endTime, ...) 
                HealBotClassic_HealsInUpdate(event, casterGUID, spellID, healType, endTime, ...) end)
                
            libCHC.RegisterCallback(HEALBOT_HEALBOT, "HealComm_HealUpdated", 
                function(event, casterGUID, spellID, healType, endTime, ...) 
                HealBotClassic_HealsInUpdate(event, casterGUID, spellID, healType, endTime, ...) end)
                
            libCHC.RegisterCallback(HEALBOT_HEALBOT, "HealComm_HealDelayed", 
                function(event, casterGUID, spellID, healType, endTime, ...) 
                HealBotClassic_HealsInUpdate(event, casterGUID, spellID, healType, endTime, ...) end)
                
            libCHC.RegisterCallback(HEALBOT_HEALBOT, "HealComm_HealStopped", 
                function(event, casterGUID, spellID, healType, interrupted, ...) 
                HealBotClassic_HealsInUpdate(event, casterGUID, spellID, healType, interrupted, ...) end)
                
            --libCHC.RegisterCallback(HEALBOT_HEALBOT, "HealComm_ABSORB-EVENT", 
            --    function(event, casterGUID, spellID, ???, ???, ...) 
            --    HealBotClassic_AbsorbsUpdate(event, casterGUID, spellID, ???, ???, ...) end)
        end
    end
  --HealBot_setCall("HealBot_Register_IncHeals")
end

function HealBot_UnRegister_IncHeals()
    if HEALBOT_GAME_VERSION>3 then
        HealBot:UnregisterEvent("UNIT_HEAL_PREDICTION")
    elseif libCHC then
        libCHC.UnregisterCallback(HEALBOT_HEALBOT, "HealComm_HealStarted")
        libCHC.UnregisterCallback(HEALBOT_HEALBOT, "HealComm_HealUpdated")
        libCHC.UnregisterCallback(HEALBOT_HEALBOT, "HealComm_HealDelayed")
        libCHC.UnregisterCallback(HEALBOT_HEALBOT, "HealComm_HealStopped")
        --libCHC.UnregisterCallback(HEALBOT_HEALBOT, "HealComm_ABSORB-EVENT")
    end
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
    HealBot_luVars["TankUnit"]=unit
  --HealBot_setCall("HealBot_SetTankUnit")
end

function HealBot_CalcThreat(unit)
    local z,y,eUnit=0,0,nil
    if UnitExists(unit.."target") and UnitIsEnemy(unit, unit.."target") then 
        if UnitIsUnit(unit, unit.."targettarget") then
            z=100
        else
            eUnit=unit.."target"
        end
    elseif UnitExists(HealBot_luVars["TankUnit"]) and UnitExists(HealBot_luVars["TankUnit"].."target") and 
           UnitIsEnemy(HealBot_luVars["TankUnit"], HealBot_luVars["TankUnit"].."target") then 
        if UnitIsUnit(unit, HealBot_luVars["TankUnit"].."targettarget") then
            z=100
        else
            eUnit=HealBot_luVars["TankUnit"].."target"
        end
    elseif UnitExists("target") and UnitIsEnemy("player", "target") then 
        if UnitIsUnit(unit, "playertargettarget") then
            z=100
        else
            eUnit="target"
        end
    elseif UnitExists("boss1") and UnitIsEnemy("player", "boss1") then 
        if UnitIsUnit(unit, "boss1target") then
            z=100
        else
            eUnit="boss1"
        end
    elseif UnitExists("boss2") and UnitIsEnemy("player", "boss2") then 
        if UnitIsUnit(unit, "boss2target") then
            z=100
        else
            eUnit="boss2"
        end
    end
    if eUnit then
        if HEALBOT_GAME_VERSION>3 then
            _, _, z, _, _ = UnitDetailedThreatSituation(unit, eUnit)
            y = UnitThreatSituation(unit, eUnit)
        elseif libCTM then
            _, _, z, _, _ = libCTM:UnitDetailedThreatSituation(unit, eUnit)
            y = libCTM:UnitThreatSituation(unit, eUnit)
        end
        z=floor(z or 0)
    elseif z==0 then
        if HEALBOT_GAME_VERSION>3 then
            y = UnitThreatSituation(unit)
        elseif libCTM then
            y = libCTM:UnitThreatSituation(unit, eUnit)
        end
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
        end
    end
  --HealBot_setCall("HealBot_OnEvent_AddonMsg")
end

local extShareSkin={}
function HealBot_ShareSkinSendMsg(cmd, msg)
    if cmd=="Init" then
        if tonumber(msg) then msg='#'..msg end
        extShareSkin={[1]=msg}
        HealBot_luVars["saveSkinsTabSize"]=1
        HealBot_AddChat(HEALBOT_SHARE_INSTRUCTION)
    elseif cmd and msg then
        HealBot_luVars["saveSkinsTabSize"]=HealBot_luVars["saveSkinsTabSize"]+1
        extShareSkin[HealBot_luVars["saveSkinsTabSize"]]=cmd.."!"..msg
        if cmd=="Complete" then
            local ssStr="Skin"
            local ssStr=ssStr.."\n"..extShareSkin[1]
            for j=2,#extShareSkin do
                ssStr=ssStr.."\n"..extShareSkin[j] 
            end
            HealBot_Options_ShareExternalEditBox:SetText(ssStr)
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
    local vGUID=UnitGUID(unit)
    if not vGUID then
        HealBot_NoVehicle(unit)
        return 100,100
    end
  --HealBot_setCall("HealBot_VehicleHealth")
    return UnitHealth(unit), UnitHealthMax(unit)  
end

local function HealBot_OnEvent_LeavingVehicle(unit)
    if unit and UnitExists(unit) then
        local xUnit,_,xButton = HealBot_UnitID(unit, false)
        if xUnit and HealBot_UnitInVehicle[xUnit] then
            HealBot_CheckAggroUnits(xButton)
        end
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
    button.aura.debuff.check=true
    button.aura.buff.check=true
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
        local xButton=HealBot_Unit_Button["target"]
        if xButton then xButton.spec = " " end
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
            if xButton then 
                local xGUID=UnitGUID("target") or "target"
                if HealBot_luVars["TargetNeedReset"] then
                    HealBot_RecalcParty(3)
                elseif UnitExists("target") and HealBot_Panel_validTarget(xGUID) then
                    if HealBot_Data["UILOCK"] then
                        if HealBot_FrameVisible[8] then
                            HealBot_UpdateUnitReset(xButton)
                            HealBot_UpdateUnit(xButton)
                        end
                    else
                        HealBot_UpdateUnitReset(xButton)
                        HealBot_UpdateUnit(xButton)
                        if not HealBot_FrameVisible[8] then
                            HealBot_Action_ShowPanel(8)
                        end
                        HealBot_Panel_TargetChangedCheckFocus()
                    end
                elseif not HealBot_Data["UILOCK"] and HealBot_FrameVisible[8] then
                    HealBot_Action_HidePanel(8)
                end
            else
                HealBot_RecalcParty(3)
            end
        end
    elseif HealBot_FrameVisible[8] then
        HealBot_RecalcParty(3)
    end
    if HealBot_luVars["hlPlayerBars"] then
        if not HealBot_Data["UILOCK"] or HealBot_luVars["hlPlayerBarsIC"] then
            for xUnit,xButton in pairs(HealBot_Unit_Button) do
                if UnitExists("target") and not UnitIsEnemy("target", "player") and UnitIsUnit(xUnit, "target") and xUnit~="target" then
                    HealBot_Action_UpdateAggro(xUnit,"target",xButton.aggro.status,0)
                    HealBot_luVars["HighlightTarget"]=xUnit
                elseif xButton.aggro.status==-2 then
                     HealBot_Action_UpdateAggro(xUnit,"off",nil,0)
                end
            end
        end
    end
    if HealBot_luVars["hlPetBars"] then
        if not HealBot_Data["UILOCK"] or HealBot_luVars["hlPetBarsIC"] then
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
    HealBot_luVars["DelayLockdownCheck"]=TimeNow+3
    if not HealBot_Data["PGUID"] then
        HealBot_Load("playerRD")      
        HealBot_luVars["SoftResetAfterCombat"]=true
    elseif HealBot_RefreshTypes[0] then
            HealBot_RecalcParty(0)
    else
        if HealBot_RefreshTypes[6] then HealBot_RecalcParty(6); end
        if HealBot_RefreshTypes[1] then HealBot_RecalcParty(1); end
        if HealBot_RefreshTypes[2] then HealBot_RecalcParty(2); end
        HealBot_RecalcParty(5);
    end
    if HealBot_Globals.DisableToolTipInCombat and HealBot_Data["TIPUNIT"] then
        HealBot_Action_HideTooltipFrame()
    end
    for xUnit,xButton in pairs(HealBot_Unit_Button) do
        if not HealBot_FrameVisible[xButton.frame] and UnitExists(xUnit) then
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
        if not HealBot_FrameVisible[xButton.frame] and UnitExists(xUnit) then
            HealBot_Action_ShowPanel(xButton.frame)
        end
        if xButton.aura.debuff.name and not HealBot_Config_Cures.DebuffWatchInCombat then
            HealBot_ClearDebuff(xButton)
        end
        if xButton.aura.buff.name and not HealBot_Config_Buffs.BuffWatchInCombat then
            HealBot_ClearBuff(xButton)
        end
    end
    if Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["FOCUSINCOMBAT"]==1 then
        HealBot_Action_HidePanel(9)
    elseif HealBot_RefreshTypes[4] or Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["FOCUSINCOMBAT"]==3 then
        if HealBot_RefreshTypes[4] or not HealBot_Unit_Button["focus"] then
            HealBot_RecalcParty(4)
        else
            HealBot_Action_ShowPanel(9)
        end
    end
    if Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TARGETINCOMBAT"]==1 then
        HealBot_Action_HidePanel(8)
    elseif HealBot_RefreshTypes[3] or Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TARGETINCOMBAT"]==3 then
        if HealBot_RefreshTypes[3] or not HealBot_Unit_Button["target"] then
            HealBot_RecalcParty(3)
        else
            HealBot_Action_ShowPanel(8)
        end
    end
    if not HealBot_luVars["hlPlayerBarsIC"] and HealBot_luVars["HighlightTarget"] then
        HealBot_OnEvent_PlayerTargetChanged(false)
    end
    if not Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["LOWMANACOMBAT"] then HealBot_ClearLowMana() end
    --HealBot_Action_ResetUnitStatus()
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

function HealBot_CheckAllBuffs(unit)
    if unit then
        local xButton = HealBot_Unit_Button[unit]
        if xButton then
            xButton.aura.buff.check=true
        end
    else
        for _,xButton in pairs(HealBot_Unit_Button) do
            xButton.aura.buff.check=true
        end
    end
  --HealBot_setCall("HealBot_CheckAllBuffs")
end

function HealBot_CheckAllActiveDebuffs()
    for _,xButton in pairs(HealBot_Unit_Button) do
        if xButton.aura.debuff.name then
            xButton.aura.debuff.check=true
        end
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        if xButton.aura.debuff.name then
            xButton.aura.debuff.check=true
        end
    end
end

function HealBot_CheckAllDebuffs()
    for _,xButton in pairs(HealBot_Unit_Button) do
        xButton.aura.debuff.check=true
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        xButton.aura.debuff.check=true
    end
  --HealBot_setCall("HealBot_CheckAllDebuffs")
end

function HealBot_ClearDebuff(button)
	if button.aura.debuff.name then
		button.aura.debuff.type = false;
		button.aura.debuff.name = false;
        button.aura.debuff.id=0
		button.aura.debuff.priority = 99;
        if button.aggro.status>4 then
            HealBot_Action_UpdateAggro(button.unit,false,nil,0)
        end
        HealBot_Action_UpdateDebuffButton(button)
	end
  --HealBot_setCall("HealBot_ClearDebuff")
end

function HealBot_ClearBuff(button)
    if button.aura.buff.name then
        button.aura.buff.name=false
        button.aura.buff.priority=99
        HealBot_Action_UpdateDebuffButton(button)
    end
  --HealBot_setCall("HealBot_ClearBuff")
end

function HealBot_CheckPlayerMana(button)
    if ((UnitPowerType(button.unit) or 1)==0) then
        hbManaPlayers[button.guid]=button.unit
    elseif hbManaPlayers[button.guid] then
        hbManaPlayers[button.guid]=nil
    end
  --HealBot_setCall("HealBot_CheckPlayerMana")
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
    HealBot_setOptions_Timer(190)
    HealBot_nextRecalcParty(6)
    HealBot_Action_CheckReserved()
    if HealBot_Data["UILOCK"] then 
        HealBot_IC_PartyMembersChanged()
        HealBot_luVars["SoftResetAfterCombat"]=true 
        HealBot_ResetClassIconTexture()
        HealBot_luVars["DelayLockdownCheck"]=TimeNow
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

local function HealBot_OnEvent_ReadyCheckUpdate(unit,response)
    local xButton=HealBot_Unit_Button[unit]
    if HealBot_luVars["rcEnd"] and xButton and Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][xButton.frame]["SHOWRC"] then 
        local prevRedyCheck=xButton.icon.debuff.readycheck
        if response then
            xButton.icon.debuff.readycheck=READY_CHECK_READY_TEXTURE --"Interface\\RAIDFRAME\\ReadyCheck-Ready"
        else
            xButton.icon.debuff.readycheck=READY_CHECK_NOT_READY_TEXTURE --"Interface\\RAIDFRAME\\ReadyCheck-NotReady"
        end
        if xButton.icon.debuff.readycheck~=prevRedyCheck then
            xButton.aura.debuff.check=true
        end
    end
  --HealBot_setCall("HealBot_OnEvent_ReadyCheckUpdate")
end

function HealBot_OnEvent_ReadyCheck(self,unitName,timer)
    local lUnit=HealBot_Panel_RaidUnitName(HealBot_UnitNameOnly(unitName))
    HealBot_luVars["rcEnd"]=GetTime()+timer
    for _,xButton in pairs(HealBot_Unit_Button) do
        if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][xButton.frame]["SHOWRC"] then 
            xButton.icon.debuff.readycheck=READY_CHECK_WAITING_TEXTURE
            xButton.aura.debuff.check=true
        end
    end
    if lUnit and HealBot_Unit_Button[lUnit] then HealBot_OnEvent_ReadyCheckUpdate(lUnit,true) end
  --HealBot_setCall("HealBot_OnEvent_ReadyCheck")
end

local function HealBot_OnEvent_ReadyCheckConfirmed(self,unit,response)
    local xUnit = HealBot_UnitID(unit, false)
    if HealBot_Unit_Button[xUnit] then HealBot_OnEvent_ReadyCheckUpdate(xUnit,response) end
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
            if HealBot_luVars["FocusNeedReset"] then
                HealBot_RecalcParty(4)
            elseif UnitExists("focus") and HealBot_Panel_validFocus(xButton.guid, xButton.unit) then
                if HealBot_Data["UILOCK"] then
                    if HealBot_FrameVisible[9] then 
                        HealBot_UpdateUnitReset(xButton)
                        HealBot_UpdateUnit(xButton)
                    end
                else
                    HealBot_UpdateUnitReset(xButton)
                    HealBot_UpdateUnit(xButton)
                    if not HealBot_FrameVisible[9] then
                        HealBot_Action_ShowPanel(9)
                    end
                end
            elseif not HealBot_Data["UILOCK"] and HealBot_FrameVisible[9] then 
                HealBot_Action_HidePanel(9)
            end
        else
            HealBot_RecalcParty(4)
        end
    elseif HealBot_FrameVisible[9] then
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
            local xUnit=HealBot_Panel_RaidUnitName(uName)
            if xUnit then
                local xButton=HealBot_Unit_Button[xUnit]
                if xButton then 
                    if (string.find(msg, HB_ONLINE)) and xButton.status.offline then
                        xButton.status.offline = false
                        HealBot_Action_setNameTag(xButton)
                        HealBot_Action_Refresh(xButton)
                    end
                    HealBot_Action_setNameTag(xButton) 
                    HealBot_Action_ResetUnitStatus(xButton);
                end
            end
        end
    end
  --HealBot_setCall("HealBot_OnEvent_SystemMsg")
end

function HealBot_OnEvent_TalentsChanged(button)
    button.spec = " "
    if button.unit=="player" then 
        HealBot_setOptions_Timer(200) 
    else
        HealBot_GetTalentInfo(button)
    end
  --HealBot_setCall("HealBot_OnEvent_TalentsChanged")
end

function HealBot_OnEvent_SpellsChanged(self, arg1)
    if arg1==0 then return; end
    if UnitIsDeadOrGhost("player") then return end
    HealBot_setOptions_Timer(550)
  --HealBot_setCall("HealBot_OnEvent_SpellsChanged")
end

function HealBot_ClearDebuffCache(spellId)
    if spellId then
        curDebuffs[spellId]=nil;
    else
        for x,_ in pairs(curDebuffs) do
            curDebuffs[x]=nil;
        end
    end
end

function HealBot_OnEvent_PlayerEnteringWorld(hbCaller)
    if HealBot_FrameVisible[8] then
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
                if xButton.checks.timed < TimeNow then HealBot_Player_CheckTime(xButton) end
            end
            UnitBuffIcons=HealBot_UnitBuffIcons[xUnit]
            if UnitBuffIcons then
                for bName,_ in pairs(UnitBuffIcons) do
                    if not UnitBuffIcons[bName].current then
                        UnitBuffIcons[bName]=nil
                    end
                end  
            end
            UnitDebuffIcons=HealBot_UnitDebuffIcons[xUnit]
            if UnitDebuffIcons then
                for dName,_ in pairs(UnitDebuffIcons) do
                    if not UnitDebuffIcons[dName].current then
                        UnitDebuffIcons[dName]=nil
                    end
                end
            end
        end
        for xUnit,xButton in pairs(HealBot_Enemy_Button) do
            if not xButton.status.reserved then
                if xButton.checks.timed < TimeNow then HealBot_Enemy_CheckTime(xButton) end
            end
        end
        for xUnit,xButton in pairs(HealBot_Pet_Button) do
            if not xButton.status.reserved then
                if xButton.checks.timed < TimeNow then HealBot_Pet_CheckTime(xButton) end
            end
        end
        HealBot_ClearDebuffCache()
    end

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

local function HealBot_OnEvent_UnitSpellCastSent(self,caster,unitName,spellRank,spellID)
    local xUnit=nil
    local uscName = HealBot_UnitNameOnly(unitName)
    local spellName = GetSpellInfo(spellID) or spellID
    if caster=="player" and uscName == HEALBOT_WORDS_UNKNOWN then
        uscName = HealBot_GetCorpseName(uscName)
    end
    if uscName=="" then
        if spellID==HEALBOT_MENDPET and UnitExists("pet") then
            uscName=HealBot_GetUnitName("pet")
            xUnit="pet"
        end
    elseif UnitExists(HealBot_luVars["TargetUnitID"]) and UnitName(HealBot_luVars["TargetUnitID"])==uscName then
        xUnit=HealBot_luVars["TargetUnitID"]
    else
        xUnit=HealBot_Panel_RaidUnitName(HealBot_UnitNameOnly(uscName))
    end

    if xUnit then
        if (spellID==HEALBOT_MASS_RESURRECTION or spellID==HEALBOT_ABSOLUTION or spellID==HEALBOT_ANCESTRAL_VISION or spellID==HEALBOT_REAWAKEN or spellID==HEALBOT_REVITALIZE or 
            spellID==HEALBOT_RESURRECTION or spellID==HEALBOT_ANCESTRALSPIRIT or spellID==HEALBOT_REBIRTH or spellID==HEALBOT_REDEMPTION or spellID==HEALBOT_REVIVE or spellID==HEALBOT_RESUSCITATE)
            and UnitExists(xUnit) and HealBot_Unit_Button[xUnit]  then
            local xButton=HealBot_Unit_Button[xUnit]
            xButton.update.state=true
            xButton.status.update=true
            if caster=="player" and uscName then
                if Healbot_Config_Skins.Chat[Healbot_Config_Skins.Current_Skin]["NOTIFY"]>1 and Healbot_Config_Skins.Chat[Healbot_Config_Skins.Current_Skin]["RESONLY"] then
                    if spellID==HEALBOT_MASS_RESURRECTION or spellID==HEALBOT_ABSOLUTION or spellID==HEALBOT_ANCESTRAL_VISION or spellID==HEALBOT_REAWAKEN or spellID==HEALBOT_REVITALIZE then           
                        HealBot_CastNotify(HEALBOT_OPTIONS_GROUPHEALS,spellName,xUnit)
                    else
                        HealBot_CastNotify(uscName,spellName,xUnit)
                    end
                end
            elseif HealBot_Spell_IDs[spellName] then
                if Healbot_Config_Skins.Chat[Healbot_Config_Skins.Current_Skin]["NOTIFY"]>1 and Healbot_Config_Skins.Chat[Healbot_Config_Skins.Current_Skin]["RESONLY"]==false then
                    HealBot_CastNotify(uscName,spellName,xUnit)
                end
            end
        end
    end
  --HealBot_setCall("HealBot_OnEvent_UnitSpellCastSent")
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

function HealBot_CastNotify(unitName,spell,unit)
    local z = Healbot_Config_Skins.Chat[Healbot_Config_Skins.Current_Skin]["NOTIFY"];
    local s = gsub(Healbot_Config_Skins.Chat[Healbot_Config_Skins.Current_Skin]["MSG"],"#s",spell)
    s = gsub(s,"#l",GetSpellLink(spell, ""))
    s = gsub(s,"#n",unitName)
    local w=nil;
    if z==5 and not IsInRaid() then z = 4 end
    if z==4 and GetNumGroupMembers()==0 then z = 2 end
    if z==3 and UnitIsPlayer(unit) and UnitPlayerControlled(unit) and unit~="player" then
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

function HealBot_retDebufftype(id)
  --HealBot_setCall("HealBot_retDebufftype")
    local dType=HEALBOT_CUSTOM_en
    if curDebuffs[id] then dType=curDebuffs[id]["type"] end
    return dType
end

function HealBot_HoT_RemoveAllIconsButton(button)
    for i=1,10 do
        HealBot_RemoveIcon(button, i)
    end
    for i=51,55 do
        HealBot_RemoveIcon(button, i)
    end
    HealBot_RaidTargetUpdate(button, 0)
  --HealBot_setCall("HealBot_HoT_RemoveAllIconsButton")
end

function HealBot_HoT_RemoveIconButton(button)
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
        if HealBot_KnownSpell(HEALBOT_HEAL) then
            HealBot_SmartCast_Spells[HEALBOT_HEAL]="L"
        elseif HealBot_KnownSpell(HBC_HEAL) then
            HealBot_SmartCast_Spells[HBC_HEAL]="L"
        end
        if HealBot_KnownSpell(HEALBOT_FLASH_HEAL) then
            HealBot_SmartCast_Spells[HEALBOT_FLASH_HEAL]="S"
        end
	elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_DRUID] then
        if HealBot_KnownSpell(HEALBOT_HEALING_TOUCH) then
            HealBot_SmartCast_Spells[HEALBOT_HEALING_TOUCH]="L"
        end
        if HealBot_KnownSpell(HEALBOT_REJUVENATION) then
            HealBot_SmartCast_Spells[HEALBOT_REJUVENATION]="S"
        end
    elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_PALADIN] then
        if HealBot_KnownSpell(HEALBOT_HOLY_LIGHT) then
            HealBot_SmartCast_Spells[HEALBOT_HOLY_LIGHT]="L"
        elseif HealBot_KnownSpell(HBC_HOLY_LIGHT) then
            HealBot_SmartCast_Spells[HBC_HOLY_LIGHT]="L"
        end
        if HealBot_KnownSpell(HEALBOT_FLASH_OF_LIGHT) then
            HealBot_SmartCast_Spells[HEALBOT_FLASH_OF_LIGHT]="S"
        end
    elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_SHAMAN] then
        if HealBot_KnownSpell(HEALBOT_HEALING_SURGE) then
            HealBot_SmartCast_Spells[HEALBOT_HEALING_SURGE]="S"
        elseif HealBot_KnownSpell(HBC_LESSER_HEALING_WAVE) then
            HealBot_SmartCast_Spells[HBC_LESSER_HEALING_WAVE]="S"
        end
        if HealBot_KnownSpell(HEALBOT_HEALING_WAVE) then
            HealBot_SmartCast_Spells[HEALBOT_HEALING_WAVE]="L"
        elseif HealBot_KnownSpell(HBC_HEALING_WAVE) then
            HealBot_SmartCast_Spells[HBC_HEALING_WAVE]="L"
        end
    elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_MONK] then
        if HealBot_KnownSpell(HEALBOT_ENVELOPING_MIST) then
            HealBot_SmartCast_Spells[HEALBOT_ENVELOPING_MIST]="L"
        end
        if HealBot_KnownSpell(HEALBOT_REVIVAL) then
            HealBot_SmartCast_Spells[HEALBOT_REVIVAL]="S"
        elseif HealBot_KnownSpell(HEALBOT_SOOTHING_MIST) then
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
    for sID,sType in pairs(HealBot_SmartCast_Spells) do
        local sName=HealBot_KnownSpell(sID)
        if sName then
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

local oldRange=0
function HealBot_UpdateUnitRange(button, spellName, doRefresh) 
    oldRange=button.status.range
    button.spells.rangecheck=spellName
    button.status.range=HealBot_UnitInRange(button.unit, button.spells.rangecheck)
    if oldRange~=button.status.range then
        HealBot_Action_setNameTag(button)
        button.health.updincoming=true
        button.health.updabsorbs=true
        button.health.update=true
        if doRefresh then
            button.checks.timed=1
            button.update.state=true
            button.status.update=true
            button.aura.buff.check=true  
        end
        if Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][button.frame]["OORLAST"] and (oldRange==1 or button.status.range==1) then
            if button.status.unittype==1 then 
                HealBot_nextRecalcParty(6)
            elseif button.status.unittype<4 then
                HealBot_nextRecalcParty(2)
            end
        end
    end
  --HealBot_setCall("HealBot_UpdateUnitRange")
end

local uRange=0
function HealBot_UnitInRange(unit, spellName) -- added by Diacono of Ursin
    uRange=0
    if UnitIsUnit("player",unit) then
        uRange = 1
    elseif not HealBot_UnitInPhase(unit) then 
        uRange = -2
    elseif not UnitIsVisible(unit) then 
        uRange = -1
    elseif CheckInteractDistance(unit,1) then
        uRange = 1
    elseif not HealBot_luVars["27YardsOnly"] then
        if HealBot_Spell_Names[spellName] and IsSpellInRange(spellName, unit) then
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
            if pFacing then
                pFacing = pFacing < 0 and pFacing + hbPi * 2 or pFacing;
                direction = hbPi - hbaTan2(px - tx, ty - py) - pFacing;
                direction = floor(direction * hbdMod + 0.5) % 108
                hbX, hbY = (direction % 9) * 0.109375, floor(direction / 9) * 0.08203125;
            end
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
    if hbManaPlayers[hbGUID] then hbManaPlayers[hbGUID]=nil end
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
                HealBot_Globals.VersionResetDone["8.1.5.7.2"]=true
                HealBot_ResetCustomDebuffs()
            end,
            timeout = 0,
            whileDead = 1,
            hideOnEscape = 1
        };
    elseif resetTab=="ICON" then
        local msg="Healbot recommends resetting HoT/buff icons\n\n Continue?"
        StaticPopupDialogs["HEALBOT_OPTIONS_RESETSETTING"] = {
            text = msg,
            button1 = HEALBOT_WORDS_YES,
            button2 = HEALBOT_WORDS_NO,
            OnAccept = function()
                HealBot_Globals.VersionResetDone["8.1.5.5"]=true
                HealBot_Reset_Icons()
                HealBot_SetResetFlag("HARD")
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
    HealBot_Config_Buffs.SoundBuffWarning=HealBot_Config_BuffsDefaults.SoundBuffWarning
    HealBot_Config_Buffs.SoundBuffPlay=HealBot_Config_BuffsDefaults.SoundBuffPlay
    HealBot_Config_Buffs.ShowBuffWarning=HealBot_Config_BuffsDefaults.ShowBuffWarning
    HealBot_Config_Buffs.CBshownHB=HealBot_Config_BuffsDefaults.CBshownHB
    HealBot_Config_Buffs.CBshownAB=HealBot_Config_BuffsDefaults.CBshownAB
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
    Healbot_Config_Skins.Icons[HEALBOT_OPTIONS_RAID25]=HealBot_Config_SkinsDefaults.Icons[HEALBOT_OPTIONS_RAID25]
    Healbot_Config_Skins.Icons[HEALBOT_OPTIONS_RAID40]=HealBot_Config_SkinsDefaults.Icons[HEALBOT_OPTIONS_RAID40]
    Healbot_Config_Skins.RaidIcon[HEALBOT_SKINS_STD]=HealBot_Config_SkinsDefaults.RaidIcon[HEALBOT_SKINS_STD]
    Healbot_Config_Skins.RaidIcon[HEALBOT_OPTIONS_GROUPHEALS]=HealBot_Config_SkinsDefaults.RaidIcon[HEALBOT_OPTIONS_GROUPHEALS]
    Healbot_Config_Skins.RaidIcon[HEALBOT_OPTIONS_RAID25]=HealBot_Config_SkinsDefaults.RaidIcon[HEALBOT_OPTIONS_RAID25]
    Healbot_Config_Skins.RaidIcon[HEALBOT_OPTIONS_RAID40]=HealBot_Config_SkinsDefaults.RaidIcon[HEALBOT_OPTIONS_RAID40]
    Healbot_Config_Skins.IconText[HEALBOT_SKINS_STD]=HealBot_Config_SkinsDefaults.IconText[HEALBOT_SKINS_STD]
    Healbot_Config_Skins.IconText[HEALBOT_OPTIONS_GROUPHEALS]=HealBot_Config_SkinsDefaults.IconText[HEALBOT_OPTIONS_GROUPHEALS]
    Healbot_Config_Skins.IconText[HEALBOT_OPTIONS_RAID25]=HealBot_Config_SkinsDefaults.IconText[HEALBOT_OPTIONS_RAID25]
    Healbot_Config_Skins.IconText[HEALBOT_OPTIONS_RAID40]=HealBot_Config_SkinsDefaults.IconText[HEALBOT_OPTIONS_RAID40]
    HealBot_Globals.IgnoreCustomBuff={}
    HealBot_Globals.HealBot_Custom_Buffs={}
    HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol={}
    HealBot_Globals.CustomBuffBarColour = {[HEALBOT_CUSTOM_en.."Buff"] = { R = 0.25, G = 0.58, B = 0.8, },}
    HealBot_Globals.WatchHoT=HealBot_GlobalsDefaults.WatchHoT
    HealBot_Options_ResetDoInittab(3)
    HealBot_Options_Init(3)
    HealBot_Options_ComboClass_Text()
    HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_CONFIRMICONRESET)
  --HealBot_setCall("HealBot_Reset_Icons")
end

function HealBot_IsItemInBag(itemID)
  --HealBot_setCall("HealBot_IsItemInBag")
    if itemID then
        for bag = 0,4 do
            for slot = 1,GetContainerNumSlots(bag) do
                if GetContainerItemID(bag,slot)==itemID then
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
        local _,_,xButton,aTarget,aFocus = HealBot_UnitID(arg1, true)
        if xButton then
            HealBot_OnEvent_UnitAura(xButton);
        end
        if aTarget then
            HealBot_OnEvent_UnitAura(HealBot_Unit_Button["target"])
        end
        if aFocus then
            HealBot_OnEvent_UnitAura(HealBot_Unit_Button["focus"])
        end
    elseif (event=="UNIT_HEALTH") or (event=="UNIT_MAXHEALTH") then
        local _,_,xButton,aTarget,aFocus = HealBot_UnitID(arg1, true)
        if xButton then
            if (event=="UNIT_MAXHEALTH") then
                HealBot_OnEvent_TalentsChanged(xButton)
            end
            HealBot_OnEvent_UnitHealth(xButton)
        end
        if aTarget then
            HealBot_OnEvent_UnitHealth(HealBot_Unit_Button["target"])
        end
        if aFocus then
            HealBot_OnEvent_UnitHealth(HealBot_Unit_Button["focus"])
        end
    elseif (event=="UNIT_THREAT_SITUATION_UPDATE") or (event=="UNIT_THREAT_LIST_UPDATE") or (event=="UNIT_COMBAT") then
        local _,_,xButton,aTarget,aFocus = HealBot_UnitID(arg1, true)
        if xButton then
            HealBot_OnEvent_UnitThreat(xButton) 
        end
        if aTarget then
            HealBot_OnEvent_UnitThreat(HealBot_Unit_Button["target"])
        end
        if aFocus then
            HealBot_OnEvent_UnitThreat(HealBot_Unit_Button["focus"])
        end
    elseif (event=="UNIT_HEAL_PREDICTION") then
        local _,_,xButton,aTarget,aFocus = HealBot_UnitID(arg1, true)
        if xButton then
            HealBot_HealsInUpdate(xButton)
        end
        if aTarget then
            HealBot_HealsInUpdate(HealBot_Unit_Button["target"])
        end
        if aFocus then
            HealBot_HealsInUpdate(HealBot_Unit_Button["focus"])
        end
    elseif (event=="UNIT_ABSORB_AMOUNT_CHANGED") then
        local _,_,xButton,aTarget,aFocus = HealBot_UnitID(arg1, true)
        if xButton then
            HealBot_AbsorbsUpdate(xButton)
        end
        if aTarget then
            HealBot_AbsorbsUpdate(HealBot_Unit_Button["target"])
        end
        if aFocus then
            HealBot_AbsorbsUpdate(HealBot_Unit_Button["focus"])
        end
    elseif (event=="UNIT_SPELLCAST_FAILED") or (event=="UNIT_SPELLCAST_INTERRUPTED") or (event=="UNIT_SPELLCAST_START") 
        or (event=="UNIT_SPELLCAST_STOP") or (event=="UNIT_SPELLCAST_SUCCEEDED") then
        local _,_,xButton,aTarget,aFocus = HealBot_UnitID(arg1, true)
        if xButton then
            HealBot_OnEvent_UnitThreat(xButton)
        end
        if aTarget then
            HealBot_OnEvent_UnitThreat(HealBot_Unit_Button["target"])
        end
        if aFocus then
            HealBot_OnEvent_UnitThreat(HealBot_Unit_Button["focus"])
        end
    elseif (event=="UNIT_SPELLCAST_SENT") then
        HealBot_OnEvent_UnitSpellCastSent(self,arg1,arg2,arg3,arg4);  
    elseif (event=="PLAYER_REGEN_DISABLED") then
        HealBot_OnEvent_PlayerRegenDisabled();
    elseif (event=="PLAYER_REGEN_ENABLED") then
        HealBot_luVars["IsReallyFighting"] = true
    elseif (event=="INSTANCE_ENCOUNTER_ENGAGE_UNIT") then
        HealBot_OnEvent_InstanceEncounterEngageUnit(arg1,arg2,arg3,arg4)
    elseif (event=="UNIT_NAME_UPDATE") then
        local _,_,xButton,aTarget,aFocus = HealBot_UnitID(arg1, true)
        if xButton then
            HealBot_OnEvent_UnitNameUpdate(xButton)
        end
        if aTarget then
            HealBot_OnEvent_UnitNameUpdate(HealBot_Unit_Button["target"])
        end
        if aFocus then
            HealBot_OnEvent_UnitNameUpdate(HealBot_Unit_Button["focus"])
        end
    elseif (event=="UNIT_POWER_UPDATE") or (event=="UNIT_MAXPOWER") then
        local _,_,xButton,aTarget,aFocus = HealBot_UnitID(arg1, true)
        if xButton then
            HealBot_OnEvent_UnitMana(xButton)
        end
        if aTarget then
            HealBot_OnEvent_UnitMana(HealBot_Unit_Button["target"])
        end
        if aFocus then
            HealBot_OnEvent_UnitMana(HealBot_Unit_Button["focus"])
        end
    elseif (event=="CHAT_MSG_SYSTEM") then
        HealBot_OnEvent_SystemMsg(self,arg1);
    elseif (event=="GROUP_ROSTER_UPDATE") then
        HealBot_OnEvent_PartyMembersChanged(self);
    elseif (event=="RAID_TARGET_UPDATE") then
        HealBot_OnEvent_RaidTargetUpdateAll()
    elseif (event=="UNIT_TARGET") then
        local xUnit,xGUID,xButton,aTarget,aFocus = HealBot_UnitID(arg1, true)
        if xButton and UnitExists(xUnit.."target") and UnitIsEnemy(xUnit, xUnit.."target") then
            HealBot_Action_ResetUnitStatus(xButton)
        end
        if aTarget and UnitExists("targettarget") and UnitIsEnemy("target", "targettarget") then
            HealBot_Action_ResetUnitStatus(HealBot_Unit_Button["target"])
        end
        if aFocus and UnitExists("focustarget") and UnitIsEnemy("focus", "focustarget") then
            HealBot_Action_ResetUnitStatus(HealBot_Unit_Button["focus"])
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
        HealBot_CheckAllDebuffs();
        HealBot_CheckAllBuffs();
    elseif (event=="PLAYER_CONTROL_LOST") then  
        HealBot_ClearAllBuffs();
    elseif (event=="UNIT_PET") then
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["STATE"] then
            HealBot_nextRecalcParty(2)
        end
    elseif (event=="ROLE_CHANGED_INFORM") then
        HealBot_ResetClassIconTexture()
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
        local xUnit = HealBot_Panel_RaidUnitGUID(arg1)
        if xUnit then
            local _,_,xButton = HealBot_UnitID(xUnit, false)
            if xButton then
                HealBot_GetTalentInfo(xButton) 
            end
        end
    elseif (event=="PLAYER_SPECIALIZATION_CHANGED") then
        local _,_,xButton = HealBot_UnitID(arg1, false)
        if xButton then 
            HealBot_GetTalentInfo(xButton) 
            xButton.update.roleicon=true
            xButton.status.update=true
        end
    elseif (event=="UNIT_CONNECTION") then
        local xUnit,_,xButton = HealBot_UnitID(arg1, false)
        if xButton and xUnit then 
            if xButton.status.offline and UnitIsConnected(xUnit) then
                xButton.status.offline = false
                HealBot_Action_setNameTag(xButton)
                HealBot_Action_Refresh(xButton)                            
            elseif not xButton.status.offline and not UnitIsConnected(xUnit) then
                xButton.status.offline = GetTime()
                HealBot_Action_setNameTag(xButton)
                HealBot_Action_Refresh(xButton)
            end
        end
    elseif (event=="ZONE_CHANGED_NEW_AREA") or (event=="ZONE_CHANGED")  or (event=="ZONE_CHANGED_INDOORS") then
        HealBot_setOptions_Timer(9999)
        if (event=="ZONE_CHANGED_NEW_AREA") then
            HealBot_setOptions_Timer(120)
        end
    elseif (event=="CHAT_MSG_ADDON") then
        HealBot_OnEvent_AddonMsg(self,arg1,arg2,arg3,arg4);
    elseif (event=="PET_BATTLE_OPENING_START") or (event=="PET_BATTLE_OVER") then
        HealBot_luVars["lastPetBattleEvent"]=event
        HealBot_setOptions_Timer(190)
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
        local _,_,xButton = HealBot_UnitID("player", false)
        if xButton then
            HealBot_OnEvent_TalentsChanged(xButton)
        end
    elseif (event=="PLAYER_TALENT_UPDATE") or (event=="CHARACTER_POINTS_CHANGED") then
        local _,_,xButton = HealBot_UnitID("player", false)
        if xButton then
            HealBot_OnEvent_TalentsChanged(xButton)
        end
    elseif (event=="COMPANION_LEARNED") then
        HealBot_setOptions_Timer(405)
    elseif (event=="VARIABLES_LOADED") then
        HealBot_OnEvent_VariablesLoaded(self);
    elseif (event=="GET_ITEM_INFO_RECEIVED") then
        HealBot_OnEvent_ItemInfoReceived(self);
    else
        HealBot_AddDebug("Missing OnEvent (" .. event .. ")");
    end
    --HealBot_setCall("HealBot_OnEvent")
end

