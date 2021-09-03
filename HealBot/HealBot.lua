--[[ HealBot Continued ]]

local HealBot_DebugMsg={};
local HealBot_SpamCut={}
local HealBot_Vers={}
local TimeNow=GetTime()+1
--local strfind=strfind
local arrg = {}
local LSM = HealBot_Libs_LSM() --LibStub and LibStub:GetLibrary("LibSharedMedia-3.0", true)
local LDB11 = HealBot_Libs_LDB11()
local LDBIcon = HealBot_Libs_LDBIcon()
local libCHC = HealBot_Libs_CHC()
local libCC = HealBot_Libs_CC()
local HealBot_VehicleUnit={}
local HealBot_UnitInVehicle={}
local HealBot_Player_ButtonCache1={}
local HealBot_Player_ButtonCache2={}
local HealBot_notVisible={}
local hbManaPlayers={}
local HealBot_customTempUserName={}
local HealBot_trackHiddenFrames={}
local HealBot_RefreshTypes={[0]=true,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false}
local HealBot_Timers={["fastUpdate"]=TimeNow,["fastUpdateFreq"]=0.05,
                      ["FPS"]=40,}
local HealBot_EveryFrameUpdates={[1]=1,[2]=1,[3]=1,[4]=1,[5]=1,}
local HealBot_ResSpells={}
local HealBot_MobGUID={}
local HealBot_MobNames={}
local xUnit="x"
local xGUID="x"
local xButton={}
local pButton={}
local HealBot_ItemsInBags={}
local HealBot_AuxAssigns={}
local HealBot_SummonsTracker={}
local HealBot_SummonsCaster={}
HealBot_AuxAssigns["CastBar"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
HealBot_AuxAssigns["OORBar"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
local HealBot_luVars={}
HealBot_luVars["FPS"]={[1]={[1]=40,[2]=40,[3]=40,[0]=40},
                       [2]={[1]=40,[2]=40,[3]=40,[0]=40},
                       [3]={[1]=40,[2]=40,[3]=40,[0]=40},}
HealBot_luVars["FPS"]={[1]={[1]=55,[2]=55,[3]=55,[0]=55},
                       [2]={[1]=55,[2]=55,[3]=55,[0]=55},
                       [3]={[1]=55,[2]=55,[3]=55,[0]=55},}
HealBot_luVars["qaFRNext"]=TimeNow+45
HealBot_luVars["IsSolo"]=true
HealBot_luVars["MaskAuraDCheck"]=TimeNow
HealBot_luVars["MaskAuraReCheck"]=false
HealBot_luVars["ReloadUI"]=0
HealBot_luVars["MessageReloadUI"]=0
HealBot_luVars["slowSwitch"]=0
HealBot_luVars["fastSwitch"]=0
HealBot_luVars["VersionRequest"]=false
HealBot_luVars["ResetFlag"]=false
HealBot_luVars["AddonMsgType"]=3
HealBot_luVars["MovingFrame"]=0
HealBot_luVars["TargetNeedReset"]=true
HealBot_luVars["FocusNeedReset"]=true
HealBot_luVars["VehicleType"]=1
HealBot_luVars["PetType"]=2
HealBot_luVars["Timer8000"]=0
HealBot_luVars["TankUnit"]="x"
HealBot_luVars["healthFactor"]=1
HealBot_luVars["NextTipTime"]=TimeNow
HealBot_luVars["TipUpdateFreq"]=1
HealBot_luVars["EnableErrorSpeech"]=false
HealBot_luVars["EnableErrorText"]=false
HealBot_luVars["AllOutOfCombatCheck"]=TimeNow+1
HealBot_luVars["UpdateEnemyFrame"]=true
HealBot_luVars["NoSpamOOM"]=0
HealBot_luVars["AuraEventRegistered"]=false 
HealBot_luVars["fastUpdateEveryFrame"]=0
HealBot_luVars["TestBarsOn"]=false
HealBot_luVars["RaidTargetUpdate"]=false
HealBot_luVars["showReloadMsg"]=true
HealBot_luVars["overhealUnit"]="-nil-"
HealBot_luVars["overhealCastID"]="-nil-"
HealBot_luVars["overhealAmount"]=0
HealBot_luVars["ChatMSG"]=""
HealBot_luVars["ChatNOTIFY"]=0
HealBot_luVars["pluginThreat"]=false
HealBot_luVars["pluginTimeToDie"]=false
HealBot_luVars["pluginEffectiveTanks"]=false
HealBot_luVars["pluginEfficientHealers"]=false
HealBot_luVars["adjMaxHealth"]=0
HealBot_luVars["slowUpdateID"]=1
HealBot_luVars["minButtonId"]=1
HealBot_luVars["maxButtonId"]=1
HealBot_luVars["UpdateAllAura"]=0

local HealBot_Calls={}
HealBot_luVars["MaxCount"]=0
function HealBot_setCall(Caller)
    if not HealBot_Calls[Caller] then 
        HealBot_Calls[Caller]=0
    end
    HealBot_Calls[Caller]=HealBot_Calls[Caller]+1
    if HealBot_luVars["MaxCount"]<HealBot_Calls[Caller] then
        HealBot_luVars["MaxCount"]=HealBot_Calls[Caller]
        HealBot_luVars["MaxCountName"]=Caller
    end
end

function HealBot_reportCalls()
    if HealBot_luVars["MaxCountName"] then HealBot_AddDebug("High Count:"..HealBot_luVars["MaxCountName"].."="..HealBot_luVars["MaxCount"]) end
end

function HealBot_retCalls()
    return HealBot_Calls
end

function HealBot_nextRecalcParty(typeRequired)
    if not HealBot_Data["UILOCK"] then
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["FRAME"]<7 and HealBot_luVars["PetType"]~=6 and HealBot_Action_FrameIsVisible(7) then 
            HealBot_Action_HidePanel(7) 
        end
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["FRAME"]<6 and HealBot_luVars["VehicleType"]~=6 and HealBot_Action_FrameIsVisible(6) then 
            HealBot_Action_HidePanel(6) 
        end
    end
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
    HealBot_setOptions_Timer(8888)
      --HealBot_setCall("HealBot_nextRecalcParty"..typeRequired)
end

function HealBot_MessageReloadUI(limit)
    if not HealBot_Data["UILOCK"] then
        HealBot_luVars["MessageReloadUI"]=0
        HealBot_luVars["ReloadUI"]=TimeNow+limit
    else
        HealBot_luVars["MessageReloadUI"]=limit
    end
      --HealBot_setCall("HealBot_MessageReloadUI")
end

function HealBot_setLuVars(vName, vValue)
    HealBot_luVars[vName]=vValue
	--HealBot_setCall("HealBot_setLuVars - "..vName)
end

function HealBot_retLuVars(vName)
      --HealBot_setCall("HealBot_retLuVars"..vName)
    return HealBot_luVars[vName]
end

function HealBot_setAuxAssigns(vName, frame, vValue)
    HealBot_AuxAssigns[vName][frame]=vValue
end

function HealBot_ClearPlayerButtonCache()
    for x,_ in pairs(HealBot_Player_ButtonCache1) do
        HealBot_Player_ButtonCache1[x]=nil
    end
    for x,_ in pairs(HealBot_Player_ButtonCache2) do
        HealBot_Player_ButtonCache2[x]=nil
    end
end

function HealBot_Update_MinMaxIds(button)
    if button.id<HealBot_luVars["minButtonId"] then HealBot_luVars["minButtonId"]=button.id end
    if button.id>HealBot_luVars["maxButtonId"] then HealBot_luVars["maxButtonId"]=button.id end
end

function HealBot_Update_ResetRefreshLists()
    HealBot_luVars["ResetRefreshLists"]=false
    HealBot_luVars["minButtonId"]=1000
    HealBot_luVars["maxButtonId"]=1
    HealBot_luVars["UnitRefresh1"]=true
    for xUnit,xButton in pairs(HealBot_Unit_Button) do
        if HealBot_luVars["UnitRefresh1"] then
            HealBot_Player_ButtonCache1[xUnit]=xButton
            HealBot_luVars["UnitRefresh1"]=false
        else
            HealBot_Player_ButtonCache2[xUnit]=xButton
            HealBot_luVars["UnitRefresh1"]=true
        end
        HealBot_Update_MinMaxIds(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Update_MinMaxIds(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Update_MinMaxIds(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Update_MinMaxIds(xButton)
    end
    if (HealBot_luVars["minButtonId"]+5)>HealBot_luVars["maxButtonId"] then HealBot_luVars["maxButtonId"]=HealBot_luVars["minButtonId"]+5 end
    HealBot_luVars["slowUpdateID"]=HealBot_luVars["minButtonId"]
end

function HealBot_setNotVisible(unit,group)
    HealBot_notVisible[unit]=group
      --HealBot_setCall("HealBot_setNotVisible")
end

function HealBot_SetResetFlag(mode)
    if mode=="HARD" then
        ReloadUI()
    elseif mode=="SOFT" then
        HealBot_setOptions_Timer(9100) 
    else
        HealBot_setOptions_Timer(9130)
    end
      --HealBot_setCall("HealBot_SetResetFlag")
end

function HealBot_TooltipInit()
    if ( HealBot_ScanTooltip:IsOwned(HealBot) ) then return; end;
    HealBot_ScanTooltip:SetOwner(HealBot, 'ANCHOR_NONE' );
    HealBot_ScanTooltip:ClearLines();
      --HealBot_setCall("HealBot_TooltipInit")
end

local uzText=""
function HealBot_UnitZone(unit, guid)
    if guid then
        unit=HealBot_Panel_RaidUnitGUID(guid) or unit or "x"
    end
    if UnitIsUnit("player", unit) or UnitIsVisible(unit) then
        uzText=GetRealZoneText();
    elseif IsInRaid() and UnitIsPlayer(unit) and UnitInRaid(unit) then
        local raidID=UnitInRaid(unit)
        _, _, _, _, _, _, uzText, _, _ = GetRaidRosterInfo(raidID);
    else
        HealBot_ScanTooltip:SetUnit(unit)
        uzText = HealBot_ScanTooltipTextLeft3:GetText()
        if uzText == "PvP" then
            uzText = HealBot_ScanTooltipTextLeft4:GetText()
        end
    end
    return uzText
end

function HealBot_AddChat(HBmsg)
    DEFAULT_CHAT_FRAME:AddMessage(HBmsg, 0.7, 0.7, 1.0);
      --HealBot_setCall("HealBot_AddChat")
end

function HealBot_AddDebug(HBmsg, cat, incTime)
    if HealBot_Globals.DebugOut and HBmsg and (HealBot_SpamCut[HBmsg] or 0)<TimeNow then
        HealBot_SpamCut[HBmsg]=TimeNow+60
        if cat then
            HealBot_Debug_Add(cat, HBmsg, incTime)
        else
            HBmsg="["..date("%H:%M", time()).."] DEBUG: "..HBmsg;
            table.insert(HealBot_DebugMsg,HBmsg)
        end
    end
      --HealBot_setCall("HealBot_AddDebug")
end

function HealBot_TogglePanel(HBpanel, sound)
    if not HBpanel then return end
    if ( HBpanel:IsVisible() ) then
        HBpanel:Hide();
        if sound then
            PlaySound(SOUNDKIT.IG_CHARACTER_INFO_CLOSE)
        end
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
        if sound then
            PlaySound(SOUNDKIT.IG_CHARACTER_INFO_OPEN)
        end
       -- HBpanel:ClearAllPoints();
       -- HBpanel:SetPoint("CENTER","UIParent","CENTER",0,0);
    end
      --HealBot_setCall("HealBot_TogglePanel")
end

function HealBot_StartMoving(HBframe, hbCurFrame)
    if not HBframe.isMoving then
        HBframe:StartMoving();
        HBframe.isMoving = true;
        if hbCurFrame and Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["STICKYFRAME"] and hbCurFrame>1 then HealBot_luVars["MovingFrame"]=hbCurFrame end
    end
      --HealBot_setCall("HealBot_StartMoving")
end

function HealBot_StopMoving(HBframe,hbCurFrame)
    if ( HBframe.isMoving ) then
        HBframe:StopMovingOrSizing();
        HBframe.isMoving = false;
        if HealBot_luVars["MovingFrame"]>1 then 
            HealBot_luVars["MovingFrame"]=0
            HealBot_Action_StickyFrameCanStickTo(HBframe.id,0,0,0)
        end
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

function HealBot_Reset_AutoUpdateDebuffIDs()
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

function HealBot_Reset_AutoUpdateSpellIDs()
    HealBot_Reset_AutoUpdateDebuffIDs()
    HealBot_AddChat("Automatic Spell ID's Turned On")
end

local ubZ=1
function HealBot_UnitHasBuff(unit, bName)
    ubZ=1
    while true do
        name = UnitBuff(unit,ubZ)
        if name then
            ubZ=ubZ+1
            if name==bName then return true end
        else
            break
        end
    end
    return false
end

local hbInPhase=true
function HealBot_UnitInPhase(unit)
    if HEALBOT_GAME_VERSION<9 then 
        if not HealBot_Data["UILOCK"] and UnitCreatureFamily(unit)=="Imp" and HealBot_UnitHasBuff(unit, HBC_PHASE_SHIFT) then
            hbInPhase=false
        else
            hbInPhase=UnitInPhase(unit)
        end
    elseif (UnitPhaseReason(unit) or 2)~=2 then
        hbInPhase=false
    else
        hbInPhase=true
    end
    return hbInPhase
end

function HealBot_SlashCmd(cmd)
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
        if HealBot_Version_Target() then HealBot_TogglePanel(HealBot_Options, true); end
    elseif (HBcmd=="d" or HBcmd=="defaults") then
        HealBot_Options_Defaults_OnClick(HealBot_Options_Defaults, true);
    elseif (HBcmd=="ui") then
        HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_HARDRELOAD)
        HealBot_SetResetFlag("HARD")
    elseif (HBcmd=="ri" or (HBcmd=="reset" and x and string.lower(x)=="healbot")) then
        HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_SOFTRELOAD)
        HealBot_SetResetFlag("SOFT")
    elseif (HBcmd=="rc" or (HBcmd=="reset" and x and string.lower(x)=="customdebuffs")) then
        HealBot_setOptions_Timer(9110)
    elseif (HBcmd=="rs" or (HBcmd=="reset" and x and string.lower(x)=="skin")) then
        HealBot_setOptions_Timer(9120)
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
    elseif (HBcmd=="tma") then
        HealBot_Options_ToggleMainAssist()
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
    elseif (HBcmd=="atd" and x) then
        if (tonumber(x)>1) and (tonumber(x)<302) then
            HealBot_Config_Cures.ShowTimeMaxDuration=tonumber(x)
            HealBot_Lang_Options_enALL()
        else
            HealBot_AddChat("Invalid Value for Auto Timed Duration. valid range from 2 to 301")
        end
    elseif (HBcmd=="test") then
        HealBot_TestBars()
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
            HealBot_setOptions_Timer(182)
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_OPTIONS_HIDERAIDFRAMES.." "..HEALBOT_WORD_DISABLE.." "..HEALBOT_WORD_ALWAYS)
        else
            local hbHideRaidFrameSetting=0
            if HealBot_luVars["HIDERAIDF"] then hbHideRaidFrameSetting=1 end
            HealBot_Globals.RaidHideMethod=3+hbHideRaidFrameSetting
            HealBot_luVars["HIDERAIDF"]=false
            HealBot_setOptions_Timer(182)
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_OPTIONS_HIDERAIDFRAMES.." "..HEALBOT_WORD_DISABLE.." "..HEALBOT_WORD_NEVER)
        end
    elseif (HBcmd=="hrfms") then
        if HealBot_Globals.RaidHideMethod==0 then
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_OPTIONS_HIDERAIDFRAMES.." "..HEALBOT_WORD_DISABLE.." "..HEALBOT_WORD_NEVER)
        else
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_OPTIONS_HIDERAIDFRAMES.." "..HEALBOT_WORD_DISABLE.." "..HEALBOT_WORD_ALWAYS)
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
    elseif (HBcmd=="cpu") then
        if HealBot_luVars["CPUProfilerOn"] then
            HealBot_AddChat("WARNING: cpu profiling is ON, to disable type:")
            HealBot_AddChat("WARNING: /console scriptProfile 0")
            HealBot_AddChat("WARNING: /reload")
        end
        HealBot_AddChat("Out of combat FPS="..HealBot_Timers["FPS"].." CPU Level="..HealBot_Globals.CPUUsage)
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
        HealBot_Options_Lang(x, true)
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
    elseif (HBcmd=="tpt" and x) then
        if UnitExists(x) then
            HealBot_Panel_ToggelPrivateTanks(x, false)
        else
            HealBot_AddChat(HEALBOT_CHAT_ADDONID.."Invalid Unit "..x)
        end
    elseif (HBcmd=="tph" and x) then
        if UnitExists(x) then
            HealBot_Panel_ToggelPrivateHealers(x, false)
        else
            HealBot_AddChat(HEALBOT_CHAT_ADDONID.."Invalid Unit "..x)
        end
    elseif (HBcmd=="tpl" and x) then
        if UnitExists(x) then
            HealBot_Panel_ToggelHealTarget(x, false)
        else
            HealBot_AddChat(HEALBOT_CHAT_ADDONID.."Invalid Unit "..x)
        end
    elseif (HBcmd=="chihd" and x) then
        if tonumber(x) and tonumber(x)>0 and tonumber(x)<=30 then
            HealBot_Globals.cHoTinHealDur=ceil(x)
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CLASSIC_HOT_IHDUR.." "..ceil(x).." "..HEALBOT_WORDS_SEC)
        else
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_RESLAG_INDICATOR_ERROR)
        end
    elseif (HBcmd=="debugshow") then
        HealBot_Debug_HideShow()
    elseif (HBcmd=="debug") then
        if HealBot_Globals.DebugOut then
            HealBot_Globals.DebugOut=false
            HealBot_AddChat("Debug OFF")
        else
            HealBot_Globals.DebugOut=true
            HealBot_AddChat("Debug ON")
        end
    elseif (HBcmd=="resetcalls") then
        HealBot_AddChat("Calls Reset")
        HealBot_Calls={}
    elseif (HBcmd=="trs") then
        xButton=HealBot_Unit_Button["player"] or HealBot_Private_Button["player"]
        if xButton then
            xButton.health.init=false
            xButton.health.current=1
            xButton.gref["Bar"]:SetValue(0)
            HealBot_OnEvent_UnitHealth(xButton)
        end
    elseif (HBcmd=="zzz") then
        HealBot_AddDebug("Timers: Fast="..HealBot_Timers["fastUpdateFreq"].." Tip="..HealBot_luVars["TipUpdateFreq"])
        HealBot_AddDebug("EveryFrame [1]="..HealBot_EveryFrameUpdates[1].." [2]="..HealBot_EveryFrameUpdates[2])
        HealBot_luVars["NOBEBUFF"]=true
        HealBot_AuraCheck()
    --    xButton=HealBot_Unit_Button["player"] or HealBot_Private_Button["player"]
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

function HealBot_ToggleSuppressSetting(settingType)
    if settingType=="sound" then
        if HealBot_Globals.MacroSuppressSound==1 then
            HealBot_Globals.MacroSuppressSound=0
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_MACROSOUNDON)
        else
            HealBot_Globals.MacroSuppressSound=1
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_MACROSOUNDOFF)
        end
        HealBot_Comms_MacroSuppressSound()
    elseif settingType=="error" then
        if HealBot_Globals.MacroSuppressError==1 then
            HealBot_Globals.MacroSuppressError=0
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_MACROERRORON)
        else
            HealBot_Globals.MacroSuppressError=1
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_MACROERROROFF)
        end
        HealBot_Comms_MacroSuppressError()
    end
      --HealBot_setCall("HealBot_ToggleSuppressSetting")
end

function HealBot_TestBars()
    local numBars=100
    HealBot_Panel_SetNumBars(numBars)
    HealBot_Panel_ToggleTestBars()
    HealBot_nextRecalcParty(0)
      --HealBot_setCall("HealBot_TestBars")
end

local hbManaCurrent, hbManaMax=0,0
function HealBot_OnEvent_UnitMana(button)
    if button.mana.change then HealBot_Action_setButtonManaBarCol(button) end
    if button.status.current<HealBot_Unit_Status["DEAD"] then
        hbManaCurrent=UnitPower(button.unit) or 0
        hbManaMax=UnitPowerMax(button.unit) or 0
        if button.mana.current~=hbManaCurrent or button.mana.max~=hbManaMax or button.mana.change then
            button.mana.current=hbManaCurrent
            button.mana.max=hbManaMax
            HealBot_Aux_setPowerBars(button)
            HealBot_Action_CheckUnitLowMana(button)
            if HealBot_Data["TIPBUTTON"] and HealBot_Data["TIPBUTTON"]==button then HealBot_Action_RefreshTooltip() end
        end
        HealBot_Action_setPowerIndicators(button)
    elseif button.mana.current>0 or button.mana.max>0 then
        button.mana.current=0
        button.mana.max=0
        HealBot_Aux_setPowerBars(button)
        HealBot_Action_CheckUnitLowMana(button)
        HealBot_Action_setPowerIndicators(button)
    end
      --HealBot_setCall("HealBot_OnEvent_UnitMana")
end

function HealBot_OnEvent_UnitManaUpdate(button)
    button.mana.change=true
    HealBot_OnEvent_UnitMana(button)
end


function HealBot_setAllPowerBars()
    for _,xButton in pairs(HealBot_Unit_Button) do
        xButton.status.update=true
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        xButton.status.update=true
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        xButton.status.update=true
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        xButton.status.update=true
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        xButton.status.update=true
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_UpdateUnit(xButton)
    end
end

local uuUnitClassEN="XXXX"
function HealBot_UpdateUnitNotExists(button)
    button.status.current=HealBot_Unit_Status["RESERVED"]
    button.status.update=true
    button.status.change=true
    HealBot_OnEvent_UnitHealth(button)
    HealBot_Text_setNameTag(button)
    HealBot_Text_setNameText(button)
    button.text.healthupdate=true
    HealBot_Text_UpdateText(button)
    HealBot_Aura_RemoveIcons(button, TimeNow)
    HealBot_Action_UpdateBackgroundButton(button)
    HealBot_Aux_clearAllBars(button)
    HealBot_Action_UpdateAllIndicators(button)
    HealBot_Action_EmergBarCheck(button)
    button.status.classknown=false
    button.guid=button.unit
    if button.status.unittype==7 and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["STATE"] then
        HealBot_nextRecalcParty(1)
    elseif button.status.unittype==8 and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["STATE"] then
        HealBot_nextRecalcParty(2)
    end
    if button.status.dirarrowshown>0 then HealBot_Action_HideDirectionArrow(button) end
end

function HealBot_UpdateUnit(button)
    button.status.update=false
    HealBot_OnEvent_RaidTargetUpdate(button)
    HealBot_Action_UpdateBackgroundButton(button)
    HealBot_OnEvent_UnitManaUpdate(button)
    HealBot_Text_setNameText(button)
    button.text.healthupdate=true
    HealBot_Aux_UpdBar(button)
    button.aura.check=true
    button.group=HealBot_RetUnitGroups(button.unit)
    HealBot_Action_SetClassIconTexture(button)
    HealBot_Text_UpdateText(button)
    button.status.range=-3
end

function HealBot_UpdateUnitGUIDChange(button)
    HealBot_Aura_RemoveIcons(button, TimeNow)
    button.guid=UnitGUID(button.unit)
    button.health.init=true
    button.mana.init=true
    button.specupdate=true
    button.text.nameupdate=true
    button.reset=true
    HealBot_Aura_ClearBuff(button)
    HealBot_Aura_ClearDebuff(button)
    HealBot_UpdateUnitExists(button)
    if button.status.unittype<7 then
        HealBot_nextRecalcParty(6)
    elseif button.status.unittype==8 then
        HealBot_nextRecalcParty(2)
    elseif button.status.unittype==9 then
        HealBot_nextRecalcParty(3)
    elseif button.status.unittype==10 then
        HealBot_nextRecalcParty(4)
    elseif button.status.unittype==7 then
        HealBot_nextRecalcParty(1)
    else
        HealBot_nextRecalcParty(5)
    end
end

function HealBot_UpdateUnitExists(button)
    button.status.change=false
    HealBot_SetUnitDisconnect(button)
    if button.status.current==HealBot_Unit_Status["RESERVED"] then button.status.current=HealBot_Unit_Status["CHECK"] end
    _, uuUnitClassEN = UnitClass(button.unit);
    if not uuUnitClassEN and UnitIsPlayer(button.unit) then
        button.status.classknown=false
    else
        button.text.r,button.text.g,button.text.b=HealBot_Action_ClassColour(button.unit)
        button.status.classknown=true
    end
    button.text.classtrim = strsub(uuUnitClassEN or "XXXX",1,4)
    HealBot_OnEvent_UnitHealth(button)
    HealBot_Text_setNameTag(button)
    HealBot_HealsInUpdate(button)
    HealBot_AbsorbsUpdate(button)
    HealBot_CalcThreat(button)
    HealBot_OnEvent_RaidTargetUpdate(button)
    HealBot_Action_EmergBarCheck(button, true)
    HealBot_UnitAuraAlpha(button)
    if button.status.unittype==11 then HealBot_Aura_CheckUnitsWithoutEvents(button, TimeNow) end
    button.specupdate=true
    if not button.status.duplicate and button.status.unittype<7 and button.status.classknown then 
        button.status.plugin=true
    else
        button.status.plugin=false
    end
    button.status.refresh=true
    HealBot_UpdateUnit(button)
        --HealBot_setCall("HealBot_UpdateUnit")
end

function HealBot_RecalcParty(changeType)
    HealBot_RefreshTypes[changeType]=false
    if changeType==5 and not HealBot_luVars["UpdateEnemyFrame"] then
        HealBot_setOptions_Timer(2530)
    else
        HealBot_Action_resetShouldHealSomeFrames()
        if changeType<3 or changeType>5 then
            HealBot_ClearPlayerButtonCache()
        end
        HealBot_Panel_PartyChanged(HealBot_Data["UILOCK"], changeType)
        if changeType<3 or changeType>5 then
            HealBot_luVars["ResetRefreshLists"]=true
        end
        HealBot_setOptions_Timer(2500)
        HealBot_setOptions_Timer(2510)
        HealBot_setOptions_Timer(2520)
        HealBot_setOptions_Timer(7100)
    end
    --HealBot_setCall("HealBot_RecalcParty")
end

function HealBot_CheckZone()
    HealBot_setOptions_Timer(405)
    HealBot_setOptions_Timer(7950)
    --HealBot_setCall("HealBot_CheckZone")
end

function HealBot_Update_BuffsForSpecDD(ddId,bType)
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
        if HealBot_Config_Buffs.HealBotBuffText[ddId] and tonumber(HealBot_Config_Buffs.HealBotBuffText[ddId]) then
            HealBot_Config_Buffs.HealBotBuffText[ddId]=HEALBOT_WORDS_NONE
            HealBot_Config_Buffs.HealBotBuffDropDown[ddId]=4
        end
        for z=1,4 do
            if HealBot_Config_Buffs.HealBotBuffText[z..ddId] and tonumber(HealBot_Config_Buffs.HealBotBuffText[z..ddId]) then
                HealBot_Config_Buffs.HealBotBuffDropDown[z..ddId]=nil
                HealBot_Config_Buffs.HealBotBuffText[z..ddId]=nil
            end
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

function HealBot_Update_BuffsForSpec(buffType)
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

function HealBot_Update_SpellCombos()
    local combo,button=nil,nil
    for x=1,2 do
        if x==1 then
            combo = HealBot_Config_Spells.EnabledKeyCombo;
        else
            combo = HealBot_Config_Spells.EnemyKeyCombo;
        end
        for y=1,5 do
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

function HealBot_DoReset_Spells(pClassTrim)
    HealBot_Config_Spells.EnabledKeyCombo = {}
    HealBot_Config_Spells.EnemyKeyCombo = {}
    local bandage=HealBot_GetBandageType() or ""
    local x=""
    if pClassTrim=="DRUI" then
        HealBot_Action_SetSpell("ENABLED", "Left", GetSpellInfo(HEALBOT_REGROWTH))
        HealBot_Action_SetSpell("ENABLED", "CtrlLeft", GetSpellInfo(HEALBOT_REMOVE_CORRUPTION))
        HealBot_Action_SetSpell("ENABLED", "Right", GetSpellInfo(HEALBOT_HEALING_TOUCH))
        HealBot_Action_SetSpell("ENABLED", "CtrlRight", GetSpellInfo(HEALBOT_NATURES_CURE))
        HealBot_Action_SetSpell("ENABLED", "Middle", GetSpellInfo(HEALBOT_REJUVENATION))
        HealBot_Action_SetSpell("ENABLED", "CtrlMiddle", GetSpellInfo(HEALBOT_NOURISH))
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
    elseif pClassTrim=="PALA" then
        HealBot_Action_SetSpell("ENABLED", "Left", GetSpellInfo(HEALBOT_FLASH_OF_LIGHT))
        HealBot_Action_SetSpell("ENABLED", "ShiftRight", GetSpellInfo(HEALBOT_LIGHT_OF_DAWN))
        HealBot_Action_SetSpell("ENABLED", "CtrlLeft", GetSpellInfo(HEALBOT_CLEANSE))
        HealBot_Action_SetSpell("ENABLED", "Middle", GetSpellInfo(HEALBOT_WORD_OF_GLORY))
        HealBot_Action_SetSpell("ENABLED", "ShiftMiddle", GetSpellInfo(HEALBOT_HOLY_RADIANCE))
        if HEALBOT_GAME_VERSION>3 then
            HealBot_Action_SetSpell("ENABLED", "Right", GetSpellInfo(HEALBOT_HOLY_LIGHT))
        else
            HealBot_Action_SetSpell("ENABLED", "Right", GetSpellInfo(HBC_HOLY_LIGHT))
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
        if HEALBOT_GAME_VERSION>3 then
            HealBot_Action_SetSpell("ENABLED", "Right", GetSpellInfo(HEALBOT_HEAL))
        else
            HealBot_Action_SetSpell("ENABLED", "Right", GetSpellInfo(HBC_HEAL))
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
        if HEALBOT_GAME_VERSION>3 then
            HealBot_Action_SetSpell("ENABLED", "Left", GetSpellInfo(HEALBOT_HEALING_WAVE))
        else
            HealBot_Action_SetSpell("ENABLED", "Left", GetSpellInfo(HBC_HEALING_WAVE))
        end
    elseif pClassTrim=="MAGE" then
        HealBot_Action_SetSpell("ENABLED", "Left", GetSpellInfo(HEALBOT_REMOVE_CURSE))
    end
    HealBot_Action_SetSpell("ENABLED", "Alt-ShiftMiddle", bandage)
    HealBot_Action_SetSpell("ENABLED", "Alt-ShiftLeft", HEALBOT_DISABLED_TARGET)
    HealBot_Action_SetSpell("ENABLED", "Alt-ShiftRight", HEALBOT_ASSIST)
    HealBot_Action_SetSpell("ENABLED", "Alt-Ctrl-ShiftLeft", HEALBOT_MENU)
    HealBot_Action_SetSpell("ENABLED", "Alt-Ctrl-ShiftRight", HEALBOT_HBMENU)
      --HealBot_setCall("HealBot_DoReset_Spells")
end

function HealBot_DoReset_Cures(pClassTrim)
    HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_WORDS_NONE,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
    HealBot_Config_Cures.HealBotDebuffDropDown = {[1]=4,[2]=4,[3]=4}
    if pClassTrim=="DRUI" then
        if HealBot_Spell_Names[HEALBOT_NATURES_CURE] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_NATURES_CURE]) then
            if HealBot_Spell_Names[HEALBOT_REMOVE_CORRUPTION] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_REMOVE_CORRUPTION]) then
                HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_REMOVE_CORRUPTION,[2]=HEALBOT_NATURES_CURE,[3]=HEALBOT_WORDS_NONE}
            else
                HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_NATURES_CURE,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
            end
        elseif HealBot_Spell_Names[HEALBOT_REMOVE_CORRUPTION] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_REMOVE_CORRUPTION]) then
            HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_REMOVE_CORRUPTION,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
        end
    elseif pClassTrim=="MONK" then
        if HealBot_Spell_Names[HEALBOT_DETOX] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_DETOX]) then
            HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_DETOX,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
        end
    elseif pClassTrim=="PALA" then
        if HealBot_Spell_Names[HEALBOT_CLEANSE] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_CLEANSE]) then
            HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_CLEANSE,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
        elseif HealBot_Spell_Names[HEALBOT_CLEANSE_TOXIN] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_CLEANSE_TOXIN]) then
            HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_CLEANSE_TOXIN,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
        end
    elseif pClassTrim=="PRIE" then
        if HealBot_Spell_Names[HEALBOT_PURIFY] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_PURIFY]) then
            if HealBot_Spell_Names[HEALBOT_MASS_DISPEL] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_MASS_DISPEL]) then
                if HealBot_Spell_Names[HEALBOT_PURIFY_DISEASE] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_PURIFY_DISEASE]) then
                    HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_PURIFY,[2]=HEALBOT_MASS_DISPEL,[3]=HEALBOT_PURIFY_DISEASE}
                else
                    HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_PURIFY,[2]=HEALBOT_MASS_DISPEL,[3]=HEALBOT_WORDS_NONE}
                end
            elseif HealBot_Spell_Names[HEALBOT_PURIFY_DISEASE] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_PURIFY_DISEASE]) then
                HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_PURIFY,[2]=HEALBOT_PURIFY_DISEASE,[3]=HEALBOT_WORDS_NONE}
            else
                HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_PURIFY,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
            end
        elseif HealBot_Spell_Names[HEALBOT_MASS_DISPEL] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_MASS_DISPEL]) then
            if HealBot_Spell_Names[HEALBOT_PURIFY_DISEASE] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_PURIFY_DISEASE]) then
                HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_MASS_DISPEL,[2]=HEALBOT_PURIFY_DISEASE,[3]=HEALBOT_WORDS_NONE}
            else
                HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_MASS_DISPEL,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
            end
        elseif HealBot_Spell_Names[HEALBOT_PURIFY_DISEASE] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_PURIFY_DISEASE]) then
            HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_PURIFY_DISEASE,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
        end
    elseif pClassTrim=="SHAM" then
        if HealBot_Spell_Names[HEALBOT_PURIFY_SPIRIT] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_PURIFY_SPIRIT]) then
            HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_PURIFY_SPIRIT,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
        elseif HealBot_Spell_Names[HEALBOT_CLEANSE_SPIRIT] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_CLEANSE_SPIRIT]) then
            HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_CLEANSE_SPIRIT,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
        end
    elseif pClassTrim=="MAGE" then
        if HealBot_Spell_Names[HEALBOT_REMOVE_CURSE] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_REMOVE_CURSE]) then
            HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_REMOVE_CURSE,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
        end
    end
      --HealBot_setCall("HealBot_DoReset_Cures")
end

local function HealBot_ItemIdsInBag(bag)
    local itemId=0
    for slot = 1,GetContainerNumSlots(bag) do
        itemId=GetContainerItemID(bag,slot) or 0
        if itemId>0 then
            HealBot_ItemsInBags[itemId]=true
        end
    end
    if bag<4 then
        C_Timer.After(0.05, function() HealBot_ItemIdsInBag(bag+1) end)
    else
        C_Timer.After(0.05, HealBot_CheckWellFedItems)
    end
end

function HealBot_ItemIdsInBags()
    for x,_ in pairs(HealBot_ItemsInBags) do
        HealBot_ItemsInBags[x]=nil;
    end
    C_Timer.After(0.025, function() HealBot_ItemIdsInBag(0) end)
      --HealBot_setCall("HealBot_retItemIdsInBag")
end

function HealBot_DoReset_Buffs(pClassTrim)
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
    --if HealBot_IsItemInBag(HEALBOT_EVER_BLOOMING_FROND) then
    --    HealBot_Config_Buffs.HealBotBuffText[7]=GetItemInfo(HEALBOT_EVER_BLOOMING_FROND)
    --end
    --if HealBot_IsItemInBag(HEALBOT_ORALIUS_WHISPERING_CRYSTAL) then
    --    HealBot_Config_Buffs.HealBotBuffText[6]=GetItemInfo(HEALBOT_ORALIUS_WHISPERING_CRYSTAL)
    --end
    --if HealBot_IsItemInBag(HEALBOT_REPURPOSED_FEL_FOCUSER) then
    --    HealBot_Config_Buffs.HealBotBuffText[8]=GetItemInfo(HEALBOT_REPURPOSED_FEL_FOCUSER)
    --end
    --if HealBot_IsItemInBag(HEALBOT_BATTLE_SCARRED_AUGMENT_RUNE) then
    --    HealBot_Config_Buffs.HealBotBuffText[5]=GetItemInfo(HEALBOT_BATTLE_SCARRED_AUGMENT_RUNE)
    --end
    --if HealBot_IsItemInBag(HEALBOT_LIGHTNING_FORGED_AUGMENT_RUNE) then
    --    HealBot_Config_Buffs.HealBotBuffText[5]=GetItemInfo(HEALBOT_LIGHTNING_FORGED_AUGMENT_RUNE)
    --end
    --if HealBot_IsItemInBag(HEALBOT_VEILED_AUGMENT_RUNE) then
    --    HealBot_Config_Buffs.HealBotBuffText[5]=GetItemInfo(HEALBOT_VEILED_AUGMENT_RUNE)
    --end
    --if HealBot_IsItemInBag(HEALBOT_TAILWIND_SAPPHIRE) then
    --    HealBot_Config_Buffs.HealBotBuffText[8]=GetItemInfo(HEALBOT_TAILWIND_SAPPHIRE)
    --end
    --if HealBot_IsItemInBag(HEALBOT_AMETHYST_OF_THE_SHADOW_KING) then
    --    HealBot_Config_Buffs.HealBotBuffText[7]=GetItemInfo(HEALBOT_AMETHYST_OF_THE_SHADOW_KING)
    --end
      --HealBot_setCall("HealBot_DoReset_Buffs")
end

function HealBot_InitNewChar()
    if not HealBot_Config_Spells.EnemyKeyCombo then
        HealBot_Config_Spells.EnemyKeyCombo={}
    end
    if not HealBot_Config_Spells.EnabledKeyCombo then
        HealBot_DoReset_Spells(HealBot_Data["PCLASSTRIM"])
        HealBot_DoReset_Cures(HealBot_Data["PCLASSTRIM"])
        HealBot_DoReset_Buffs(HealBot_Data["PCLASSTRIM"])
        HealBot_Config_Buffs.HealBotBuffColR = {[1]=1,[2]=1,[3]=1,[4]=1,[5]=1,[6]=1,[7]=1,[8]=1,[9]=1,[10]=1,[11]=1,[12]=1,[13]=1,[14]=1}
        HealBot_Config_Buffs.HealBotBuffColG = {[1]=1,[2]=1,[3]=1,[4]=1,[5]=1,[6]=1,[7]=1,[8]=1,[9]=1,[10]=1,[11]=1,[12]=1,[13]=1,[14]=1}
        HealBot_Config_Buffs.HealBotBuffColB = {[1]=1,[2]=1,[3]=1,[4]=1,[5]=1,[6]=1,[7]=1,[8]=1,[9]=1,[10]=1,[11]=1,[12]=1,[13]=1,[14]=1}
        HealBot_Update_SpellCombos()
        HealBot_Update_BuffsForSpec()
    end
      --HealBot_setCall("HealBot_InitNewChar")
end

function HealBot_Register_Events()
    if HealBot_Config.DisabledNow==0 then
        if HEALBOT_GAME_VERSION>1 then
            HealBot:RegisterEvent("PLAYER_FOCUS_CHANGED");
        end
        if HEALBOT_GAME_VERSION>2 then
            HealBot:RegisterEvent("UNIT_ENTERED_VEHICLE");
            HealBot:RegisterEvent("UNIT_EXITED_VEHICLE");
            HealBot:RegisterEvent("UNIT_EXITING_VEHICLE");
        end
        if HEALBOT_GAME_VERSION>3 then
            HealBot:RegisterEvent("PLAYER_TALENT_UPDATE");
            HealBot:RegisterEvent("COMPANION_LEARNED");
            HealBot:RegisterEvent("PET_BATTLE_OPENING_START");
            HealBot:RegisterEvent("PET_BATTLE_OVER");
            HealBot:RegisterEvent("INCOMING_SUMMON_CHANGED")
        end
        HealBot:RegisterEvent("SPELL_UPDATE_COOLDOWN")
        HealBot:RegisterEvent("PLAYER_REGEN_DISABLED");
        HealBot:RegisterEvent("PLAYER_REGEN_ENABLED");
        HealBot:RegisterEvent("PLAYER_TARGET_CHANGED");
        local regPower=false
        HealBot:RegisterEvent("LEARNED_SPELL_IN_TAB");
        HealBot:RegisterEvent("CHARACTER_POINTS_CHANGED");
        HealBot:RegisterEvent("INSPECT_READY");
        HealBot:RegisterEvent("MODIFIER_STATE_CHANGED");
        HealBot:RegisterEvent("UNIT_PET");

        HealBot:RegisterEvent("ROLE_CHANGED_INFORM");
        local regThis={}
        for j=1,10 do
            if Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][j]["SHOW"] then regThis["RAIDTARGET"]=true end
            if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][j]["SHOWRC"] then regThis["READYCHECK"]=true end
        end
        if regThis["RAIDTARGET"] then HealBot:RegisterEvent("RAID_TARGET_UPDATE") end
        if regThis["READYCHECK"] then HealBot_Register_ReadyCheck() end
        HealBot:RegisterEvent("UNIT_SPELLCAST_SENT");
        HealBot:RegisterEvent("PLAYER_CONTROL_GAINED");
        HealBot:RegisterEvent("PLAYER_CONTROL_LOST");
        HealBot:RegisterEvent("PLAYER_UPDATE_RESTING");
        HealBot:RegisterEvent("BAG_UPDATE");
        --if HEALBOT_GAME_VERSION<4 then HealBot:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED") end
    end
    HealBot:RegisterEvent("GROUP_ROSTER_UPDATE");
    HealBot:RegisterEvent("RAID_ROSTER_UPDATE");
    HealBot:RegisterEvent("CHAT_MSG_ADDON");
    HealBot:RegisterEvent("ZONE_CHANGED_NEW_AREA");
    HealBot:RegisterEvent("ZONE_CHANGED");
    HealBot:RegisterEvent("ZONE_CHANGED_INDOORS");
    HealBot_setOptions_Timer(125)
      --HealBot_setCall("HealBot_Register_Events")
end

function HealBot_Load(hbCaller)
    if HealBot_luVars["canLoad"] and not HealBot_luVars["Loaded"] then
        HealBot_setOptions_Timer(25)
        HealBot_setOptions_Timer(35)
        HealBot_setOptions_Timer(50)
        HealBot_Options_LoadTips()
        HealBot_setOptions_Timer(119)
        HealBot_setOptions_Timer(121)
        HealBot_setOptions_Timer(4925)
        HealBot_setOptions_Timer(4980)
        HealBot_setOptions_Timer(4985)
        HealBot_setOptions_Timer(4990)
        HealBot_setOptions_Timer(9930)
        HealBot_setOptions_Timer(9980)
        HealBot_luVars["LoadDelay"]=TimeNow+10
        HealBot_setOptions_Timer(9990)
        HealBot_Options_SetFrames()
        local x=HealBot_Globals.ttalpha+0.12
        if x>1 then x=1 end
        HealBot_Tooltip:SetBackdrop({
            bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            tile = true, tileSize = 8, edgeSize = 8,
            insets = { left = 0, right = 0, top = 0, bottom = 0, },
        })
        HealBot_Tooltip:SetBackdropColor(0,0,0,HealBot_Globals.ttalpha)
        HealBot_Tooltip:SetBackdropBorderColor(0.32,0.32,0.4, x)
        HealBot_Panel_SetNumBars(80)
        HealBot_Panel_SethbTopRole(HealBot_Globals.TopRole)
        HealBot_setOptions_Timer(200)
        HealBot_Action_setLowManaTrig()
        HealBot_Options_MonitorBuffs_Toggle()
        HealBot_Options_MonitorDebuffs_Toggle()
        --
        HealBot_setOptions_Timer(8000)
        HealBot_Data["PGUID"]=UnitGUID("player")
        HealBot_Data["POWERTYPE"]=UnitPowerType("player") or 0
        if HealBot_Data["POWERTYPE"]<0 or HealBot_Data["POWERTYPE"]>9 then HealBot_Data["POWERTYPE"]=0 end
        HealBot_setOptions_Timer(5)
        HealBot_setOptions_Timer(171)
        HealBot_Skins_ResetSkin("init")
        HealBot_InitNewChar()
        HealBot_Options_SetSkins();
        HealBot_Aura_ConfigClassHoT()
        HealBot_Options_setDebuffPriority()
        if HealBot_luVars["AddonMsgType"]==2 then HealBot_Comms_SendAddonMsg("CTRA", "SR", HealBot_luVars["AddonMsgType"], HealBot_Data["PNAME"]) end
        if not HealBot_luVars["HelpNotice"] then
            HealBot_setOptions_Timer(990)
            HealBot_luVars["HelpNotice"]=true
        end
        HealBot_setOptions_Timer(140)
        HealBot_MMButton_Init();
        HealBot_Options_IgnoreDebuffsDuration_setAura()        
        HealBot_Options_Set_Current_Skin(Healbot_Config_Skins.Current_Skin)
        HealBot_Options_clearAuxBars()
        if HealBot_luVars["HIDEPARTYF"] then
            HealBot_trackHiddenFrames["PARTY"]=true
            HealBot_Options_DisablePartyFrame()
            HealBot_Options_PlayerTargetFrames:Enable();
            if HealBot_luVars["HIDEPTF"] then
                HealBot_trackHiddenFrames["PLAYER"]=true
                HealBot_Options_DisablePlayerFrame()
                HealBot_Options_DisablePetFrame()
                HealBot_Options_DisableTargetFrame()
            end
        end
        if HealBot_luVars["HIDEBOSSF"] then
            HealBot_trackHiddenFrames["MINIBOSS"]=true
            HealBot_Options_DisableMiniBossFrame()
        end
        if HealBot_luVars["HIDERAIDF"] then
            HealBot_trackHiddenFrames["RAID"]=true
            HealBot_Options_DisableRaidFrame()
        end
        HealBot_setOptions_Timer(180)
        HealBot_setOptions_Timer(181)
        HealBot_setOptions_Timer(182)
        HealBot_setOptions_Timer(190)
        HealBot_Register_Events()
        HealBot_setOptions_Timer(120)
        HealBot_nextRecalcParty(0)
        HealBot_fastUpdateEveryFrame(5)
        HealBot_luVars["Loaded"]=true
          --HealBot_setCall("HealBot_Load")
    end
end

function HealBot_UnRegister_Events()
    if HealBot_Config.DisabledNow==1 then
        if HEALBOT_GAME_VERSION>1 then
            HealBot:UnregisterEvent("PLAYER_FOCUS_CHANGED");
        end
        if HEALBOT_GAME_VERSION>2 then
            HealBot:UnregisterEvent("UNIT_ENTERED_VEHICLE");
            HealBot:UnregisterEvent("UNIT_EXITED_VEHICLE");
            HealBot:UnregisterEvent("UNIT_EXITING_VEHICLE");
        end
        if HEALBOT_GAME_VERSION>3 then
            HealBot:UnregisterEvent("UNIT_ENTERED_VEHICLE");
            HealBot:UnregisterEvent("UNIT_EXITED_VEHICLE");
            HealBot:UnregisterEvent("UNIT_EXITING_VEHICLE");
            HealBot:UnregisterEvent("PLAYER_TALENT_UPDATE");
            HealBot:UnregisterEvent("COMPANION_LEARNED");
            HealBot:UnregisterEvent("INCOMING_SUMMON_CHANGED")
        end
        HealBot:UnregisterEvent("ZONE_CHANGED_NEW_AREA");
        HealBot:UnregisterEvent("ZONE_CHANGED");
        HealBot:UnregisterEvent("ZONE_CHANGED_INDOORS");
        HealBot:UnregisterEvent("PLAYER_REGEN_DISABLED");
        HealBot:UnregisterEvent("PLAYER_REGEN_ENABLED");
        HealBot:UnregisterEvent("PLAYER_TARGET_CHANGED");
        HealBot_UnRegister_ReadyCheck()
        HealBot:UnregisterEvent("UNIT_PET");
        HealBot:UnregisterEvent("ROLE_CHANGED_INFORM");
        HealBot:UnregisterEvent("MODIFIER_STATE_CHANGED");
        HealBot:UnregisterEvent("PLAYER_CONTROL_GAINED");
        HealBot:UnregisterEvent("PLAYER_CONTROL_LOST");
        HealBot:UnregisterEvent("PLAYER_UPDATE_RESTING");
        HealBot:UnregisterEvent("BAG_UPDATE");
    end
    if HEALBOT_GAME_VERSION>3 then
        HealBot:UnregisterEvent("PET_BATTLE_OPENING_START");
        HealBot:UnregisterEvent("PET_BATTLE_OVER");
    end
    HealBot:UnregisterEvent("SPELL_UPDATE_COOLDOWN")
    HealBot:UnregisterEvent("RAID_TARGET_UPDATE")
    HealBot:UnregisterEvent("LEARNED_SPELL_IN_TAB");
    HealBot:UnregisterEvent("UNIT_SPELLCAST_SENT");
    HealBot:UnregisterEvent("INSPECT_READY");
    HealBot:UnregisterEvent("CHARACTER_POINTS_CHANGED");
    --HealBot:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
      --HealBot_setCall("HealBot_UnRegister_Events")
end

function HealBot_EndAggro()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Aggro_ClearUnitAggro(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Aggro_ClearUnitAggro(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Aggro_ClearUnitAggro(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Aggro_ClearUnitAggro(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Aggro_ClearUnitAggro(xButton)
    end
      --HealBot_setCall("HealBot_EndAggro")
end

function HealBot_Reset(rType)
    if rType=="Full" then
        HealBot_UnRegister_Events()
        HealBot_Panel_ClearBlackList()
        HealBot_Panel_ClearHealTargets()
        HealBot_Action_ResethbInitButtons()
        HealBot_EndAggro()  
        HealBot_Options_framesChanged(true, true, true)
        HealBot_Load("hbReset") 
        HealBot_setOptions_Timer(7950)
        HealBot_Register_Events()
        HealBot_setOptions_Timer(185)
    else
        HealBot_Options_framesChanged(true, true, true)
    end
      --HealBot_setCall("HealBot_Reset")
end

local idGUID,idUnit,idButton,pidButton,eidButton=false,false,false,false,false
function HealBot_UnitID(unit, incEnemy)
    idButton=HealBot_Unit_Button[unit] or HealBot_Pet_Button[unit] or HealBot_Extra_Button[unit] or HealBot_Vehicle_Button[unit]
    pidButton=HealBot_Private_Button[unit]
    if idButton or pidButton then
        return unit, idButton, pidButton, false
    end
    idGUID=UnitGUID(unit) or false
    if idGUID then
        idUnit=HealBot_Panel_RaidUnitGUID(idGUID)
        if idUnit and UnitIsUnit(unit,idUnit) then
            if HealBot_Unit_Button[idUnit] or HealBot_Private_Button[idUnit] then
                return idUnit, HealBot_Unit_Button[idUnit], HealBot_Private_Button[idUnit], false
            elseif HealBot_Pet_Button[idUnit] then
                return idUnit, HealBot_Pet_Button[idUnit], false, false
            elseif HealBot_Vehicle_Button[idUnit] then
                return idUnit, HealBot_Vehicle_Button[idUnit], false, false
            end
        elseif incEnemy and HealBot_Enemy_Button[unit] then
            return unit, HealBot_Enemy_Button[unit], false, true
        end
    end
      --HealBot_setCall("HealBot_UnitID")
    return false,false,false
end

local hiuOverHeal=0
function HealBot_OverHeal(button)
    if button.status.current<HealBot_Unit_Status["DEAD"] and Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["OVERHEAL"]>1 then 
        if HealBot_luVars["overhealUnit"]==button.unit then
            if HealBot_luVars["overhealAmount"]==0 then
                HealBot_luVars["overhealAmount"]=button.health.incoming
            elseif HealBot_luVars["overhealAmount"]>button.health.incoming then
                HealBot_luVars["overhealAmount"]=button.health.incoming
            end
            hiuOverHeal=(button.health.current+HealBot_luVars["overhealAmount"])-button.health.max
            if hiuOverHeal<1 then hiuOverHeal=0 end
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["OVERHEAL"]==3 then
            hiuOverHeal=(button.health.current+button.health.incoming)-button.health.max
            if hiuOverHeal<1 then hiuOverHeal=0 end
        else
            hiuOverHeal=0
        end
    else
        hiuOverHeal=0
    end
    if button.health.overheal~=hiuOverHeal then
        button.health.overheal=hiuOverHeal
        HealBot_Text_setOverHealText(button)
        if hiuOverHeal>0 then
            HealBot_Aux_UpdateOverHealBar(button)
        else
            HealBot_Aux_ClearOverHealBar(button)
        end
    end
      --HealBot_setCall("HealBot_OverHeal")
end

local hiuHealAmount=0
function HealBot_HealsInUpdate(button)
    button.health.updincoming=false
    if button.status.current>HealBot_Unit_Status["ENABLEDOOR"] and button.status.current<HealBot_Unit_Status["DEAD"] and button.status.range>=0 then
        hiuHealAmount=0
        if HEALBOT_GAME_VERSION>3 then
            hiuHealAmount=(UnitGetIncomingHeals(button.unit) or 0)
        elseif libCHC then
            hiuHealAmount = (libCHC:GetHealAmount(button.guid, libCHC.DIRECT_HEALS) or 0) * (libCHC:GetHealModifier(button.guid) or 1)
        end
        if button.health.incoming~=hiuHealAmount or (hiuHealAmount==0 and button.gref["InHeal"]:GetValue()>0) then
            button.health.incoming=hiuHealAmount
            HealBot_OverHeal(button)
            HealBot_Text_setInHealAbsorbsText(button)
            HealBot_Action_UpdateHealsInButton(button)
        end
    elseif button.health.incoming>0 or button.gref["InHeal"]:GetValue()>0 then
        button.health.incoming=0
        button.health.overheal=0
        HealBot_Aux_ClearOverHealBar(button)
        HealBot_Text_setInHealAbsorbsText(button)
        HealBot_Text_setOverHealText(button)
        button.gref["InHeal"]:SetValue(0)
        button.health.inheala=0
        HealBot_Action_UpdateInHealStatusBarColor(button)
        HealBot_Aux_ClearHealInBar(button)
    end
      --HealBot_setCall("HealBot_HealsInUpdate")
end

function HealBotClassic_HealsInDoUpdate(button)
    HealBot_HealsInUpdate(button)
    HealBot_AbsorbsUpdate(button)
end

local chiTargetGUID=false
function HealBotClassic_HealsInUpdate(spellId, ...)
    for i=1, select("#", ...) do
        chiTargetGUID = select(i, ...)
        if chiTargetGUID and HealBot_Panel_RaidUnitGUID(chiTargetGUID) then
            xUnit,xButton,pButton = HealBot_UnitID(HealBot_Panel_RaidUnitGUID(chiTargetGUID))
            if xUnit and HealBot_Extra_Button["target"] and xUnit~="target" and UnitExists("target") and UnitIsUnit("target", xUnit) then
                HealBotClassic_HealsInDoUpdate(HealBot_Extra_Button["target"])
            end
            if xButton then HealBotClassic_HealsInDoUpdate(xButton) end
            if pButton then HealBotClassic_HealsInDoUpdate(pButton) end
        end
    end
end

local abuAbsorbAmount=0
function HealBot_AbsorbsUpdate(button)
    button.health.updabsorbs=false
    if button.status.current>HealBot_Unit_Status["ENABLEDOOR"] and button.status.current<HealBot_Unit_Status["DEAD"] and button.status.range>=0 then
        abuAbsorbAmount=0
        if HEALBOT_GAME_VERSION>3 then
            abuAbsorbAmount=(UnitGetTotalAbsorbs(button.unit) or 0)
        elseif libCHC then -- In Classic absorbs are not available from libhealcom but filtering HoT's is.
            abuAbsorbAmount = (libCHC:GetHealAmount(button.guid, libCHC.HOT_HEALS, TimeNow+1+HealBot_Globals.cHoTinHealDur) or 0) * (libCHC:GetHealModifier(button.guid) or 1)
        end
        if button.health.absorbs~=abuAbsorbAmount or (abuAbsorbAmount==0 and button.gref["Absorb"]:GetValue()>0) then
            button.health.absorbs=abuAbsorbAmount
            HealBot_Text_setInHealAbsorbsText(button)
            HealBot_Action_UpdateAbsorbsButton(button)
        end
    elseif button.health.absorbs>0 or button.gref["Absorb"]:GetValue()>0 then
        button.health.absorbs=0
        HealBot_Text_setInHealAbsorbsText(button)
        button.health.absorba=0
        button.gref["Absorb"]:SetValue(0)
        HealBot_Action_UpdateAbsorbStatusBarColor(button)
        HealBot_Aux_ClearAbsorbBar(button)
    end
      --HealBot_setCall("HealBot_AbsorbsUpdate")
end

function HealBot_ResetCustomDebuffs()
    HealBot_Globals.HealBot_Custom_Debuffs=HealBot_Options_copyTable(HealBot_GlobalsDefaults.HealBot_Custom_Debuffs)
    HealBot_Globals.Custom_Debuff_Categories=HealBot_Options_copyTable(HealBot_GlobalsDefaults.Custom_Debuff_Categories)
    HealBot_Globals.FilterCustomDebuff=HealBot_Options_copyTable(HealBot_GlobalsDefaults.FilterCustomDebuff)
    HealBot_Globals.CDCBarColour=HealBot_Options_copyTable(HealBot_GlobalsDefaults.CDCBarColour)
    HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol=HealBot_Options_copyTable(HealBot_GlobalsDefaults.HealBot_Custom_Debuffs_ShowBarCol)
    HealBot_Globals.IgnoreCustomDebuff=HealBot_Options_copyTable(HealBot_GlobalsDefaults.IgnoreCustomDebuff)
    HealBot_Options_NewCDebuff:SetText("")
    HealBot_Options_InitSub(407)
    HealBot_Options_InitSub(408)
    HealBot_Options_InitSub(419)
    HealBot_SetCDCBarColours();
    HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_CONFIRMCUSTOMDEFAULTS)
    HealBot_Reset_AutoUpdateDebuffIDs()
      --HealBot_setCall("HealBot_ResetCustomDebuffs")
end

function HealBot_ResetSkins()
    Healbot_Config_Skins = HealBot_Config_SkinsDefaults
    HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_CONFIRMSKINDEFAULTS)
    HealBot_Config.LastVersionUpdate=HealBot_lastVerUpdate
    HealBot_Globals.LastVersionSkinUpdate=HealBot_lastVerSkinUpdate
    HealBot_Options_ReloadUI(HEALBOT_CMD_RESETSKINS)
      --HealBot_setCall("HealBot_ResetSkins")
end

function HealBot_Reset_Button(button)
    button.status.update=true
    button.status.change=true
    if HealBot_Action_AlwaysEnabled(button.guid) then HealBot_Action_Toggle_Enabled(button); end
end

function HealBot_Reset_Unit(unit)
    _,xButton,pButton = HealBot_UnitID(unit, true)
    if xButton then
        HealBot_Reset_Button(xButton)
    end
    if pButton then
        HealBot_Reset_Button(pButton)
    end
      --HealBot_setCall("HealBot_Reset_Unit")
end

local ksName=false
function HealBot_KnownSpell(spellID)
    if not spellID then return nil end
    if HealBot_Spell_IDs[spellID] and HealBot_Spell_IDs[spellID].known then   
        return HealBot_Spell_IDs[spellID].name; 
    else
        ksName=GetSpellInfo(spellID) or false
        if ksName and HealBot_Spell_Names[ksName] then
            return ksName
        end
    end
      --HealBot_setCall("HealBot_KnownSpell")
    return nil;
end

function HealBot_IncHeals_retHealsIn(unit, button)
    local ihretX=button.health.incoming
    local ihretY=button.health.absorbs
    if Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AC"]<2 then ihretY=0 end
    if Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IC"]<2 then ihretX=0 end
      --HealBot_setCall("HealBot_IncHeals_retHealsIn")
    return ihretX, ihretY
end

function HealBot_IncHeals_ClearUnit(button)
    if button.health.incoming>0 then
        button.health.incoming=0
        button.health.overheal=0
        HealBot_Aux_ClearOverHealBar(button)
        HealBot_Action_UpdateHealsInButton(button)
    end
    if button.health.absorbs>0 then
        button.health.absorbs=0
        HealBot_Action_UpdateAbsorbsButton(button)
    end
end

function HealBot_IncHeals_ClearAll()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_IncHeals_ClearUnit(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_IncHeals_ClearUnit(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_IncHeals_ClearUnit(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_IncHeals_ClearUnit(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_IncHeals_ClearUnit(xButton)
    end
      --HealBot_setCall("HealBot_IncHeals_ClearAll")
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

local hbLTfps={[1]="<20",[2]="<30",[3]="<40",[4]="<55",[5]="<70",[6]="<85",[7]="<100",[8]="<125",[9]=">125",}
HealBot_luVars["cpuAdj"]=0
function HealBot_Update_CPUUsage()
    local prevCPU=HealBot_Globals.CPUUsage or 0
    HealBot_Timers["FPS"]=HealBot_Comm_round((HealBot_luVars["FPS"][1][0]+HealBot_luVars["FPS"][2][0]+HealBot_luVars["FPS"][3][0])/3, 2) 
    if HealBot_Timers["FPS"]<20 or HealBot_luVars["CPUProfilerOn"] then
        HealBot_Globals.CPUUsage=1
        if HealBot_luVars["CPUProfilerOn"] and not HealBot_luVars["warnCPUProfiler"] then
            HealBot_AddDebug("CPUUsage="..HealBot_Globals.CPUUsage.." CPU profiler running", "Perf", true)
            HealBot_luVars["warnCPUProfiler"]=true
        end
    elseif HealBot_Timers["FPS"]<30 then
        HealBot_Globals.CPUUsage=2
    elseif HealBot_Timers["FPS"]<40 then
        HealBot_Globals.CPUUsage=3
    elseif HealBot_Timers["FPS"]<55 then
        HealBot_Globals.CPUUsage=4
    elseif HealBot_Timers["FPS"]<70 then
        HealBot_Globals.CPUUsage=5
    elseif HealBot_Timers["FPS"]<85 then
        HealBot_Globals.CPUUsage=6
    elseif HealBot_Timers["FPS"]<100 then
        HealBot_Globals.CPUUsage=7
    elseif HealBot_Timers["FPS"]<125 then
        HealBot_Globals.CPUUsage=8
    else
        HealBot_Globals.CPUUsage=9
    end
    if not HealBot_luVars["CPUProfilerOn"] then
        HealBot_Globals.CPUUsage=HealBot_Globals.CPUUsage+HealBot_luVars["cpuAdj"]
        if HealBot_Globals.CPUUsage<1 then 
            HealBot_Globals.CPUUsage=1
        elseif HealBot_Globals.CPUUsage>9 then
            HealBot_Globals.CPUUsage=9
        end
    end
    if prevCPU~=HealBot_Globals.CPUUsage then
        HealBot_AddDebug("CPUUsage="..HealBot_Globals.CPUUsage, "Perf", true)
        HealBot_Comms_PerfLevel(hbLTfps[HealBot_Globals.CPUUsage])
        HealBot_Set_Timers()
        HealBot_Options_FluidFlashInUse()
    end
    if (HealBot_Timers["fastUpdate"]+HealBot_Timers["fastUpdateFreq"])<TimeNow then 
        HealBot_Timers["fastUpdate"]=TimeNow
    end
end

local TimersCPU={[1]=0.125,    -- <   20
                 [2]=0.1,      -- <   30
                 [3]=0.0833,   -- <   40
                 [4]=0.0714,   -- <   55
                 [5]=0.0625,   -- <   70
                 [6]=0.0555,   -- <   85
                 [7]=0.05,     -- <  100
                 [8]=0.0454,   -- <  125
                 [9]=0.0416,   -- >= 125
                }

local fpsRow,fpsCol=1,1
function HealBot_Set_FPS()
    if HealBot_luVars["qaFRNext"]<TimeNow then
        local fpsCurRate=GetFramerate()
        if fpsCurRate>150 then fpsCurRate=150 end
        if fpsCurRate<10 then fpsCurRate=10 end
        HealBot_luVars["FPS"][fpsRow][fpsCol]=fpsCurRate
        fpsCol=fpsCol+1
        if fpsCol>3 then 
            fpsCol=1 
            fpsRow=fpsRow+1
            if fpsRow>3 then fpsRow=1 end
        elseif fpsCol==3 then
            HealBot_luVars["FPS"][fpsRow][0]=HealBot_Comm_round((HealBot_luVars["FPS"][fpsRow][1]
                                                                +HealBot_luVars["FPS"][fpsRow][2]
                                                                +HealBot_luVars["FPS"][fpsRow][3])/3, 2)
            HealBot_Update_CPUUsage()
        end
    end
end

function HealBot_Reset_FPS()
    HealBot_luVars["FPS"]={[1]={[1]=40,[2]=40,[3]=40,[0]=40},
                           [2]={[1]=40,[2]=40,[3]=40,[0]=40},
                           [3]={[1]=40,[2]=40,[3]=40,[0]=40},}
    HealBot_Update_CPUUsage()
end

function HealBot_Set_Timers()
    if HealBot_Config.DisabledNow==0 then
        HealBot_Timers["fastUpdateFreq"]=TimersCPU[HealBot_Globals.CPUUsage]
        local adjSlow=0
        for x=1,5 do
            if HealBot_Globals.CPUUsage<7 then adjSlow=x end
            HealBot_EveryFrameUpdates[x]=(x*(ceil(HealBot_Globals.CPUUsage*0.45)))+adjSlow
        end
    else
        HealBot_Timers["fastUpdateFreq"]=1
        for x=1,5 do
            HealBot_EveryFrameUpdates[x]=1
        end
    end
end

local HealBot_Options_Timer={}
function HealBot_setOptions_Timer(value)
    if value<20 then HealBot_luVars["HealBot_Options_FastTimer"]=true end
    if HealBot_luVars["canLoad"] then HealBot_luVars["HealBot_Options_Timer"]=true end
    HealBot_Options_Timer[value]=true
        --HealBot_setCall("HealBot_setOptions_Timer")
        --HealBot_setCall("HealBot_setOptions_Timer-"..value)
end

function HealBot_Update_DefaultSkins()
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

function HealBot_Include_Skin(skinName)
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
        Healbot_Config_Skins.BarAggro[skinName]=HealBot_Options_copyTable(HealBot_Config_SkinsDefaults.BarAggro[skinName])
        Healbot_Config_Skins.BarSort[skinName]=HealBot_Options_copyTable(HealBot_Config_SkinsDefaults.BarSort[skinName])
        Healbot_Config_Skins.BarVisibility[skinName]=HealBot_Options_copyTable(HealBot_Config_SkinsDefaults.BarVisibility[skinName])
        Healbot_Config_Skins.FocusGroups[skinName]=HealBot_Options_copyTable(HealBot_Config_SkinsDefaults.FocusGroups[skinName])
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
        Healbot_Config_Skins.AuxBar[skinName]=HealBot_Options_copyTable(HealBot_Config_SkinsDefaults.AuxBar[skinName])
        Healbot_Config_Skins.AuxBarFrame[skinName]=HealBot_Options_copyTable(HealBot_Config_SkinsDefaults.AuxBarFrame[skinName])
        table.insert(Healbot_Config_Skins.Skins,skinName)
        HealBot_Skins_Check_Skin(skinName)
    end
end

function HealBot_UpdateBuffItem(buff, item)
    if string.len(HealBot_Config_Buffs.CustomBuffName[1])<3 and string.len(HealBot_Config_Buffs.CustomItemName[1])<3 then
        HealBot_Config_Buffs.CustomBuffName[1]=buff
        HealBot_Config_Buffs.CustomItemName[1]=item
        HealBot_Config_Buffs.CustomBuffCheck[1]=true
    elseif string.len(HealBot_Config_Buffs.CustomBuffName[2])<3 and string.len(HealBot_Config_Buffs.CustomItemName[2])<3 then
        HealBot_Config_Buffs.CustomBuffName[2]=buff
        HealBot_Config_Buffs.CustomItemName[2]=item
        HealBot_Config_Buffs.CustomBuffCheck[2]=true
    elseif string.len(HealBot_Config_Buffs.CustomBuffName[3])<3 and string.len(HealBot_Config_Buffs.CustomItemName[3])<3 then
        HealBot_Config_Buffs.CustomBuffName[3]=buff
        HealBot_Config_Buffs.CustomItemName[3]=item
        HealBot_Config_Buffs.CustomBuffCheck[3]=true
    end
end

function HealBot_Update_Skins(forceCheck)
    if HealBot_Config.LastVersionSkinUpdate then
        HealBot_Config.LastVersionUpdate=HealBot_Config.LastVersionSkinUpdate
        HealBot_Config.LastVersionSkinUpdate=nil
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
    if HealBot_Globals.CacheSize then HealBot_Globals.CacheSize=nil end
    if not HealBot_Globals.AutoCacheSize then HealBot_Globals.AutoCacheSize=20 end

    local tMajor, tMinor, tPatch, tHealbot = string.split(".", HealBot_Globals.LastVersionSkinUpdate)
    if tonumber(tMajor)<9 then
        HealBot_Options_SetDefaults(true);
        HealBot_ReloadUI()
    elseif HealBot_Globals.LastVersionSkinUpdate~=HEALBOT_VERSION_SC or forceCheck then    
        for x in pairs (Healbot_Config_Skins.Skins) do
            HealBot_Skins_Check_Skin(Healbot_Config_Skins.Skins[x])
            if tonumber(tMinor)==0 then
                if tonumber(tPatch)<3 then
                    if tonumber(tHealbot)<9 then
                        for i=1,10 do
                            if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Skins[x]][i]["TARGETONBAR"]<3 then
                                Healbot_Config_Skins.Icons[Healbot_Config_Skins.Skins[x]][i]["TARGETONBAR"]=1
                            else
                                Healbot_Config_Skins.Icons[Healbot_Config_Skins.Skins[x]][i]["TARGETONBAR"]=Healbot_Config_Skins.Icons[Healbot_Config_Skins.Skins[x]][i]["TARGETONBAR"]-2
                            end
                            if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Skins[x]][i]["CLASSONBAR"]<3 then
                                Healbot_Config_Skins.Icons[Healbot_Config_Skins.Skins[x]][i]["CLASSONBAR"]=1
                            else
                                Healbot_Config_Skins.Icons[Healbot_Config_Skins.Skins[x]][i]["CLASSONBAR"]=Healbot_Config_Skins.Icons[Healbot_Config_Skins.Skins[x]][i]["CLASSONBAR"]-2
                            end
                            if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Skins[x]][i]["RCONBAR"]<3 then
                                Healbot_Config_Skins.Icons[Healbot_Config_Skins.Skins[x]][i]["RCONBAR"]=1
                            else
                                Healbot_Config_Skins.Icons[Healbot_Config_Skins.Skins[x]][i]["RCONBAR"]=Healbot_Config_Skins.Icons[Healbot_Config_Skins.Skins[x]][i]["RCONBAR"]-2
                            end
                            if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Skins[x]][i]["OORONBAR"]<3 then
                                Healbot_Config_Skins.Icons[Healbot_Config_Skins.Skins[x]][i]["OORONBAR"]=1
                            else
                                Healbot_Config_Skins.Icons[Healbot_Config_Skins.Skins[x]][i]["OORONBAR"]=Healbot_Config_Skins.Icons[Healbot_Config_Skins.Skins[x]][i]["OORONBAR"]-2
                            end
                        end
                        if Healbot_Config_Skins.General[Healbot_Config_Skins.Skins[x]]["FLUIDFREQ"]<12 then
                            Healbot_Config_Skins.General[Healbot_Config_Skins.Skins[x]]["FLUIDFREQ"]=Healbot_Config_Skins.General[Healbot_Config_Skins.Skins[x]]["FLUIDFREQ"]+5
                        elseif Healbot_Config_Skins.General[Healbot_Config_Skins.Skins[x]]["FLUIDFREQ"]<15 then
                            Healbot_Config_Skins.General[Healbot_Config_Skins.Skins[x]]["FLUIDFREQ"]=Healbot_Config_Skins.General[Healbot_Config_Skins.Skins[x]]["FLUIDFREQ"]+2
                        end
                        if Healbot_Config_Skins.General[Healbot_Config_Skins.Skins[x]]["FOCUSGROUPS"]==true then 
                            Healbot_Config_Skins.General[Healbot_Config_Skins.Skins[x]]["FOCUSGROUPS"]=2
                        elseif not Healbot_Config_Skins.General[Healbot_Config_Skins.Skins[x]]["FOCUSGROUPS"] then
                            Healbot_Config_Skins.General[Healbot_Config_Skins.Skins[x]]["FOCUSGROUPS"]=1
                        end
                        if tonumber(tHealbot)<11 then
                            Healbot_Config_Skins.General[Healbot_Config_Skins.Skins[x]]["FLUIDFREQ"]=Healbot_Config_Skins.General[Healbot_Config_Skins.Skins[x]]["FLUIDFREQ"]-6
                            if Healbot_Config_Skins.General[Healbot_Config_Skins.Skins[x]]["FLUIDFREQ"]<3 then
                                Healbot_Config_Skins.General[Healbot_Config_Skins.Skins[x]]["FLUIDFREQ"]=3
                            end
                        end
                    end
                end
                Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Skins[x]][10]["SHOWIND"]=false
                Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Skins[x]][10]["SHOW"]=false
                Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Skins[x]][10]["SHOWBARS"]=false
                Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Skins[x]][10]["SHOWTEXT"]=1
                Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Skins[x]][10]["SHOWBARSPCT"]=false
                Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Skins[x]][10]["SHOWTEXTPCT"]=false
                Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Skins[x]][10]["POWERCNT"]=false
                Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Skins[x]][10]["LOWMANA"]=1
            elseif tonumber(tMinor)<2 then
                if tonumber(tPatch)<1 and tonumber(tHealbot)<8 then
                    for f=1,10 do
                        if Healbot_Config_Skins.Spells[Healbot_Config_Skins.Skins[x]] and Healbot_Config_Skins.Spells[Healbot_Config_Skins.Skins[x]][f] then
                            local useEmerg=Healbot_Config_Skins.Spells[Healbot_Config_Skins.Skins[x]][f]["USE"]
                            for k,v in pairs(Healbot_Config_Skins.Spells[Healbot_Config_Skins.Skins[x]][f]) do
                                if k~="USE" then
                                    if not HealBot_Config_Spells.EmergKeyCombo[k] then
                                        HealBot_Config_Spells.EmergKeyCombo[k]=v
                                    end
                                end
                            end
                            Healbot_Config_Skins.Spells[Healbot_Config_Skins.Skins[x]][f]={}
                            Healbot_Config_Skins.Spells[Healbot_Config_Skins.Skins[x]][f]["USE"]=useEmerg
                        end
                        if Healbot_Config_Skins.SpellsTarget[Healbot_Config_Skins.Skins[x]] and Healbot_Config_Skins.SpellsTarget[Healbot_Config_Skins.Skins[x]][f] then
                            for k,v in pairs(Healbot_Config_Skins.SpellsTarget[Healbot_Config_Skins.Skins[x]][f]) do
                                if not HealBot_Config_Spells.EmergSpellTarget[k] then
                                    HealBot_Config_Spells.EmergSpellTarget[k]=v
                                end
                            end
                            Healbot_Config_Skins.SpellsTarget[Healbot_Config_Skins.Skins[x]]=nil
                        end
                        if Healbot_Config_Skins.SpellsTrinket1[Healbot_Config_Skins.Skins[x]] and Healbot_Config_Skins.SpellsTrinket1[Healbot_Config_Skins.Skins[x]][f] then
                            for k,v in pairs(Healbot_Config_Skins.SpellsTrinket1[Healbot_Config_Skins.Skins[x]][f]) do
                                if not HealBot_Config_Spells.EmergSpellTrinket1[k] then
                                    HealBot_Config_Spells.EmergSpellTrinket1[k]=v
                                end
                            end
                            Healbot_Config_Skins.SpellsTrinket1[Healbot_Config_Skins.Skins[x]]=nil
                        end
                        if Healbot_Config_Skins.SpellsTrinket2[Healbot_Config_Skins.Skins[x]] and Healbot_Config_Skins.SpellsTrinket2[Healbot_Config_Skins.Skins[x]][f] then
                            for k,v in pairs(Healbot_Config_Skins.SpellsTrinket2[Healbot_Config_Skins.Skins[x]][f]) do
                                if not HealBot_Config_Spells.EmergSpellTrinket2[k] then
                                    HealBot_Config_Spells.EmergSpellTrinket2[k]=v
                                end
                            end
                            Healbot_Config_Skins.SpellsTrinket2[Healbot_Config_Skins.Skins[x]]=nil
                        end
                        if Healbot_Config_Skins.SpellsAvoidBlueCursor[Healbot_Config_Skins.Skins[x]] and Healbot_Config_Skins.SpellsAvoidBlueCursor[Healbot_Config_Skins.Skins[x]][f] then
                            for k,v in pairs(Healbot_Config_Skins.SpellsAvoidBlueCursor[Healbot_Config_Skins.Skins[x]][f]) do
                                if not HealBot_Config_Spells.EmergAvoidBlueCursor[k] then
                                    HealBot_Config_Spells.EmergAvoidBlueCursor[k]=v
                                end
                            end
                            Healbot_Config_Skins.SpellsAvoidBlueCursor[Healbot_Config_Skins.Skins[x]]=nil
                        end
                    end
                end
            end
        end
        if not HealBot_Globals.OverrideEffects["FGDIMMING"] then HealBot_Globals.OverrideEffects["FGDIMMING"]=2.5 end
        if not HealBot_Config_Buffs.ShowGroups then 
            HealBot_Config_Buffs.ShowGroups={}
            for x=1,8 do
                HealBot_Config_Buffs.ShowGroups[x]=true
            end
        end
        if not HealBot_Config_Cures.ShowGroups then 
            HealBot_Config_Cures.ShowGroups={}
            for x=1,8 do
                HealBot_Config_Cures.ShowGroups[x]=true
            end
        end
        if tonumber(tMinor)==0 then
            if tonumber(tPatch)<3 then
                if tonumber(tHealbot)<4 then
                    local key=""
                    local cmd=""
                    for x=1,4 do
                        cmd=HealBot_Action_SpellCmdCodes("ENABLED", HEALBOT_MENU)
                        if cmd and HealBot_Config_Spells.EnabledKeyCombo then
                            key="Alt-Ctrl-ShiftLeft"..x
                            cmd="C:"..cmd
                            HealBot_Config_Spells.EnabledKeyCombo[key] = cmd
                            if HealBot_Class_Spells[HealBot_Data["PCLASSTRIM"]] then
                                HealBot_Class_Spells[HealBot_Data["PCLASSTRIM"]].EnabledKeyCombo[key] = cmd
                            end
                        end
                        cmd=HealBot_Action_SpellCmdCodes("ENABLED", HEALBOT_HBMENU)
                        if cmd and HealBot_Config_Spells.EnabledKeyCombo then
                            key="Alt-Ctrl-ShiftRight"..x
                            cmd="C:"..cmd
                            HealBot_Config_Spells.EnabledKeyCombo[key] = cmd
                            if HealBot_Class_Spells[HealBot_Data["PCLASSTRIM"]] then
                                HealBot_Class_Spells[HealBot_Data["PCLASSTRIM"]].EnabledKeyCombo[key] = cmd
                            end
                        end
                    end
                end
                if tonumber(tHealbot)<9 then
                    if HealBot_Globals.OverrideEffects["FLUIDFREQ"]<12 then
                        HealBot_Globals.OverrideEffects["FLUIDFREQ"]=HealBot_Globals.OverrideEffects["FLUIDFREQ"]+5
                    elseif HealBot_Globals.OverrideEffects["FLUIDFREQ"]<15 then
                        HealBot_Globals.OverrideEffects["FLUIDFREQ"]=HealBot_Globals.OverrideEffects["FLUIDFREQ"]+2
                    end
                    if HealBot_Globals.OverrideEffects["FOCUSGROUPS"]==true then 
                        HealBot_Globals.OverrideEffects["FOCUSGROUPS"]=2
                    elseif not HealBot_Globals.OverrideEffects["FOCUSGROUPS"] then
                        HealBot_Globals.OverrideEffects["FOCUSGROUPS"]=1
                    end
                end
                if tonumber(tHealbot)<11 then
                    HealBot_Globals.OverrideEffects["FLUIDFREQ"]=HealBot_Globals.OverrideEffects["FLUIDFREQ"]-6
                    if HealBot_Globals.OverrideEffects["FLUIDFREQ"]<3 then HealBot_Globals.OverrideEffects["FLUIDFREQ"]=3 end
                end
            end

            HealBot_Options_NewHoTBuffBtn_OnClick(HEALBOT_LIFEBLOOM, HealBot_Class_En[HEALBOT_DRUID])
            HealBot_Options_NewHoTBuffBtn_OnClick(HEALBOT_PRAYER_OF_MENDING, HealBot_Class_En[HEALBOT_PRIEST])
            if HealBot_Globals.NoSpellsOnDisabled~=nil then HealBot_Globals.NoSpellsOnDisabled=nil end
            if HealBot_Globals.TestBars["BARS"] then HealBot_Globals.TestBars["BARS"]=nil end
            if HealBot_Globals.EnLibQuickHealth then HealBot_Globals.EnLibQuickHealth=nil end
            if HealBot_Globals.EnAutoCombat then HealBot_Globals.EnAutoCombat=nil end
            if HealBot_Globals.QueryTalents then HealBot_Globals.QueryTalents=nil end
            if HealBot_Config.AdjustMaxHealth then HealBot_Config.AdjustMaxHealth=nil end
            if HealBot_Config.EnableHealthy then HealBot_Config.EnableHealthy=nil end
            if HealBot_Config_Spells.DisabledKeyCombo then HealBot_Config_Spells.DisabledKeyCombo=nil end
            if HealBot_Config_Spells.DisabledSpellTarget then HealBot_Config_Spells.DisabledSpellTarget=nil end
            if HealBot_Config_Spells.DisabledSpellTrinket1 then HealBot_Config_Spells.DisabledSpellTrinket1=nil end
            if HealBot_Config_Spells.DisabledSpellTrinket2 then HealBot_Config_Spells.DisabledSpellTrinket2=nil end
            if HealBot_Config_Spells.DisabledAvoidBlueCursor then HealBot_Config_Spells.DisabledAvoidBlueCursor=nil end
            if HealBot_Config_Cures.SpamFilterSecs then HealBot_Config_Cures.SpamFilterSecs=nil end
            if HealBot_Globals.ByPassLock then HealBot_Globals.ByPassLock=nil end
            if HealBot_Class_Spells[HealBot_Data["PCLASSTRIM"]] then
                if HealBot_Class_Spells[HealBot_Data["PCLASSTRIM"]].DisabledKeyCombo then HealBot_Class_Spells[HealBot_Data["PCLASSTRIM"]].DisabledKeyCombo=nil end
                if HealBot_Class_Spells[HealBot_Data["PCLASSTRIM"]].DisabledSpellTarget then HealBot_Class_Spells[HealBot_Data["PCLASSTRIM"]].DisabledSpellTarget=nil end
                if HealBot_Class_Spells[HealBot_Data["PCLASSTRIM"]].DisabledSpellTrinket1 then HealBot_Class_Spells[HealBot_Data["PCLASSTRIM"]].DisabledSpellTrinket1=nil end
                if HealBot_Class_Spells[HealBot_Data["PCLASSTRIM"]].DisabledSpellTrinket2 then HealBot_Class_Spells[HealBot_Data["PCLASSTRIM"]].DisabledSpellTrinket2=nil end
                if HealBot_Class_Spells[HealBot_Data["PCLASSTRIM"]].DisabledAvoidBlueCursor then HealBot_Class_Spells[HealBot_Data["PCLASSTRIM"]].DisabledAvoidBlueCursor=nil end
            end
            if HealBot_Globals.mapScale then HealBot_Globals.mapScale=nil end
            if HealBot_Globals.TooltipUpdate~=nil then HealBot_Globals.TooltipUpdate=nil end
            if HealBot_Globals.CureCustomDefaultCastBy=="ALL" then HealBot_Globals.CureCustomDefaultCastBy=1 end
            if HealBot_Globals.CureCustomDefaultCastBy=="ENEMY" then HealBot_Globals.CureCustomDefaultCastBy=2 end
            local customDebuffPriority=HEALBOT_CUSTOM_en.."15"
            if not HealBot_Globals.CDCBarColour[customDebuffPriority] then
                HealBot_Globals.CDCBarColour[customDebuffPriority]={}
                HealBot_Globals.CDCBarColour[customDebuffPriority]["R"] = 0.45
                HealBot_Globals.CDCBarColour[customDebuffPriority]["G"] = 0
                HealBot_Globals.CDCBarColour[customDebuffPriority]["B"] = 0.28
            end
            if HealBot_Globals.OverrideProt then
                HealBot_Options_DeleteAllCpMacros()
                HealBot_Globals.OverrideProt=nil
            end
            if Healbot_Config_Skins.Protection then Healbot_Config_Skins.Protection=nil end
        end
        if tonumber(tMinor)<2 then
            HealBot_Globals.Custom_Debuff_Categories[HEALBOT_CUSTOM_CAT_CUSTOM_AUTOMATIC]=1
            HealBot_Globals.HealBot_Custom_Debuffs[HEALBOT_CUSTOM_CAT_CUSTOM_AUTOMATIC]=15
            if tonumber(tPatch)<1 and tonumber(tHealbot)<8 then
                for x=1,8 do
                    local id=HealBot_Options_getDropDownId_bySpec(x)
                    if HealBot_Config_Buffs.HealBotBuffText[id] then 
                        if HealBot_Config_Buffs.HealBotBuffText[id]==(GetItemInfo(HEALBOT_ORALIUS_WHISPERING_CRYSTAL) or "-x") then
                            HealBot_UpdateBuffItem(GetItemInfo(HEALBOT_WHISPERS_OF_INSANITY), GetItemInfo(HEALBOT_ORALIUS_WHISPERING_CRYSTAL))
                            HealBot_Config_Buffs.HealBotBuffText[id]=""
                        elseif HealBot_Config_Buffs.HealBotBuffText[id]==(GetItemInfo(HEALBOT_EVER_BLOOMING_FROND) or "-x") then
                            HealBot_UpdateBuffItem(GetItemInfo(HEALBOT_BLOOM), GetItemInfo(HEALBOT_EVER_BLOOMING_FROND))
                            HealBot_Config_Buffs.HealBotBuffText[id]=""
                        elseif HealBot_Config_Buffs.HealBotBuffText[id]==(GetItemInfo(HEALBOT_REPURPOSED_FEL_FOCUSER) or "-x") then
                            HealBot_UpdateBuffItem(GetItemInfo(HEALBOT_FEL_FOCUS), GetItemInfo(HEALBOT_REPURPOSED_FEL_FOCUSER))
                            HealBot_Config_Buffs.HealBotBuffText[id]=""
                        elseif HealBot_Config_Buffs.HealBotBuffText[id]==(GetItemInfo(HEALBOT_TAILWIND_SAPPHIRE) or "-x") then
                            HealBot_UpdateBuffItem(GetItemInfo(HEALBOT_TAILWIND), GetItemInfo(HEALBOT_TAILWIND_SAPPHIRE))
                            HealBot_Config_Buffs.HealBotBuffText[id]=""
                        elseif HealBot_Config_Buffs.HealBotBuffText[id]==(GetItemInfo(HEALBOT_AMETHYST_OF_THE_SHADOW_KING) or "-x") then
                            HealBot_UpdateBuffItem(GetItemInfo(HEALBOT_SHADOW_TOUCHED), GetItemInfo(HEALBOT_AMETHYST_OF_THE_SHADOW_KING))
                            HealBot_Config_Buffs.HealBotBuffText[id]=""
                        elseif HealBot_Config_Buffs.HealBotBuffText[id]==(GetItemInfo(HEALBOT_VEILED_AUGMENT_RUNE) or "-x") then
                            HealBot_UpdateBuffItem(GetItemInfo(HEALBOT_VEILED_AUGMENTATION), GetItemInfo(HEALBOT_VEILED_AUGMENT_RUNE))
                            HealBot_Config_Buffs.HealBotBuffText[id]=""
                        elseif HealBot_Config_Buffs.HealBotBuffText[id]==(GetItemInfo(HEALBOT_LIGHTNING_FORGED_AUGMENT_RUNE) or "-x") then
                            HealBot_UpdateBuffItem(GetItemInfo(HEALBOT_LIGHTNING_FORGED_AUGMENT), GetItemInfo(HEALBOT_LIGHTNING_FORGED_AUGMENT_RUNE))
                            HealBot_Config_Buffs.HealBotBuffText[id]=""
                        elseif HealBot_Config_Buffs.HealBotBuffText[id]==(GetItemInfo(HEALBOT_BATTLE_SCARRED_AUGMENT_RUNE) or "-x") then
                            HealBot_UpdateBuffItem(GetItemInfo(HEALBOT_BATTLE_SCARRED_AUGMENT), GetItemInfo(HEALBOT_BATTLE_SCARRED_AUGMENT_RUNE))
                            HealBot_Config_Buffs.HealBotBuffText[id]=""
                        end
                    end
                end
            end
        end
        HealBot_Globals.ResLagDuration=nil
    end
    tMajor, tMinor, tPatch, tHealbot = string.split(".", HealBot_Config.LastVersionUpdate)
    if HealBot_Config.LastVersionUpdate~=HEALBOT_VERSION_SC or forceCheck then 
        if HealBot_Config.ActionVisible then HealBot_Config.ActionVisible=nil end
        if HealBot_Config.CrashProtMacroName then 
            HealBot_Options_DeleteAllCpMacros()
            HealBot_Config.CrashProtMacroName=nil 
        end
        if HealBot_Config.CrashProtStartTime then HealBot_Config.CrashProtStartTime=nil end
        -- Character specific checks
    end
    
    if HealBot_Config.CurrentSpec==9 then
        HealBot_Config.CurrentSpec=1
        HealBot_Update_SpellCombos()
        HealBot_Update_BuffsForSpec()
    end
    HealBot_Globals.LastVersionSkinUpdate=HEALBOT_VERSION_SC
    HealBot_Config.LastVersionUpdate=HEALBOT_VERSION_SC
      --HealBot_setCall("HealBot_Update_Skins")
end

function HealBot_CheckAllSkins()
    HealBot_Update_Skins(true)
end

function HealBot_setTooltipUpdateInterval()
    if not HealBot_Data["TIPUSE"] then
        HealBot_luVars["TipUpdateFreq"]=900
    elseif HealBot_Globals.Tooltip_ShowCD then
        HealBot_luVars["TipUpdateFreq"]=0.1
    else
        HealBot_luVars["TipUpdateFreq"]=1
    end
      --HealBot_setCall("HealBot_setTooltipUpdateInterval")
end

function HealBot_IncorrentVersion()
    local msg=""
    if HEALBOT_GAME_VERSION>2 then
        msg="You have Healbot "..HEALBOT_VERSION.." in Retail\nHealbot "..HEALBOT_VERSION.." is not compatible with Retail\n\nTo use Healbot download Healbot Retail"
    elseif HEALBOT_GAME_VERSION==2 then
        msg="You have Healbot "..HEALBOT_VERSION.." in Classic TBC\nHealbot "..HEALBOT_VERSION.." is not compatible with Classic TBC\n\nTo use Healbot download Healbot Classic TBC"
    else
        msg="You have Healbot "..HEALBOT_VERSION.." in Classic\nHealbot "..HEALBOT_VERSION.." is not compatible with Classic\n\nTo use Healbot download Healbot Classic"
    end
    StaticPopupDialogs["HEALBOT_INCORRECTVERSION"] = {
        text = msg,
        button1 = HEALBOT_WORDS_OK,
        timeout = 0,
        whileDead = 1,
        hideOnEscape = 1
    };

    StaticPopup_Show ("HEALBOT_INCORRECTVERSION");
end

function HealBot_OnEvent_VariablesLoaded(self)
    if not HealBot_Version_Target() then
        HealBot_IncorrentVersion()
    else
        for i = 1, #HealBot_Default_Textures do
            LSM:Register("statusbar", HealBot_Default_Textures[i].name, HealBot_Default_Textures[i].file)
        end
        for i = 1, #HealBot_Default_Sounds do
            LSM:Register("sound", HealBot_Default_Sounds[i].name, HealBot_Default_Sounds[i].file)
        end
        for i = 1, #HealBot_Default_Fonts do
            LSM:Register("font", HealBot_Default_Fonts[i].name, HealBot_Default_Fonts[i].file)
        end
        HealBot_globalVars()
        HealBot_Lang_InitVars()
        HealBot_Data_InitVars()
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
        HealBot_ItemIdsInBags()
        local pClass, pClassEN=UnitClass("player")
        HealBot_Data["PCLASSTRIM"]=strsub(pClassEN,1,4)
        HealBot_Data["PLEVEL"]=UnitLevel("player")
        local pRace, pRaceEN=UnitRace("player")
        HealBot_Data["PRACE_EN"]=pRaceEN
        HealBot_Data["PNAME"]=UnitName("player")
        if UnitIsDeadOrGhost("player") and not UnitIsFeignDeath("player") then 
            HealBot_Data["PALIVE"]=false
        else
            HealBot_Data["PALIVE"]=true
        end
        HealBot_luVars["CPUProfilerOn"]=GetCVarBool("scriptProfile")
        HealBot_ResSpells={[GetSpellInfo(HEALBOT_MASS_RESURRECTION) or "x"]=2,
                           [GetSpellInfo(HEALBOT_ABSOLUTION) or "x"]=2,
                           [GetSpellInfo(HEALBOT_ANCESTRAL_VISION) or "x"]=2,
                           [GetSpellInfo(HEALBOT_REAWAKEN) or "x"]=2,
                           [GetSpellInfo(HEALBOT_REVITALIZE) or "x"]=2,
                           [GetSpellInfo(HEALBOT_RESURRECTION) or "x"]=1,
                           [GetSpellInfo(HEALBOT_ANCESTRALSPIRIT) or "x"]=1,
                           [GetSpellInfo(HEALBOT_REBIRTH) or "x"]=1,
                           [GetSpellInfo(HEALBOT_REDEMPTION) or "x"]=1,
                           [GetSpellInfo(HEALBOT_REVIVE) or "x"]=1,
                           [GetSpellInfo(HEALBOT_RESUSCITATE) or "x"]=1}
        HealBot_TooltipInit();
        HealBot_Update_Skins()
        HealBot_InitSpells()
        HealBot_Options_InitVars()
        HealBot_Options_setLists()
        HealBot_Action_InitFrames()
        HealBot_Panel_InitOptBars()
        HealBot_customTempUserName=HealBot_Options_copyTable(HealBot_Globals.HealBot_customPermUserName)
        
        if HealBot_Globals.AutoCacheSize>20 and (HealBot_Globals.AutoCacheTime or 0)<TimeNow then
            HealBot_Globals.AutoCacheSize=HealBot_Globals.AutoCacheSize-1
            HealBot_Globals.AutoCacheTime=TimeNow+(60*60*20)
        end
        
        if HealBot_Globals.localLang then
            HealBot_Options_Lang(HealBot_Globals.localLang, false)
        else
            HealBot_Options_Lang(GetLocale(), false)
        end
        HealBot_Options_setClassEn()
        
        if HealBot_Config.Profile==2 then
            HealBot_Options_hbProfile_setClass()
        end
        C_ChatInfo.RegisterAddonMessagePrefix(HEALBOT_HEALBOT)
        HealBot_Options_InitBuffClassList()
        HealBot_Vers[HealBot_Data["PNAME"]]=HEALBOT_VERSION
        HealBot_Text_sethbNumberFormat()
        HealBot_Text_sethbAggroNumberFormat()
        HealBot_setOptions_Timer(81)
        HealBot:RegisterEvent("PLAYER_ENTERING_WORLD");
        HealBot:RegisterEvent("PLAYER_LEAVING_WORLD");
        HealBot_Options_ObjectsEnableDisable("HealBot_FrameStickyOffsetHorizontal",false)
        HealBot_Options_ObjectsEnableDisable("HealBot_FrameStickyOffsetVertical",false)
        HealBot_Options_ObjectsEnableDisable("HealBot_Options_GroupPetsByFive",false)
        HealBot_Options_ObjectsEnableDisable("HealBot_Options_SelfPet",false)
        HealBot_Options_ShowBarsPanelVisibilityFocus(false)
        HealBot_Options_ShowBarsPanelVisibilityTargets(false)
        HealBot_Options_Init(11)
        HealBot_Aura_SetIconUpdateInterval()
        HealBot_setTooltipUpdateInterval()
        --HealBot_Skins_ResetSkin("init")
        if HealBot_Globals.CatchAltDebuffIDs["init"] then
            HealBot_Reset_AutoUpdateDebuffIDs()
        end
        HealBot_luVars["canLoad"]=true
        HealBot_luVars["HealBot_Options_Timer"]=true
        HealBot_Comms_PerfLevel(hbLTfps[HealBot_Globals.CPUUsage])
        HealBot_Reset_FPS()
        if HEALBOT_GAME_VERSION<2 and libCC then
            libCC.RegisterCallback(HEALBOT_HEALBOT,"UNIT_SPELLCAST_START", HealBot_libCC_CastStart)
            libCC.RegisterCallback(HEALBOT_HEALBOT,"UNIT_SPELLCAST_STOP", HealBot_libCC_CastStop)
            libCC.RegisterCallback(HEALBOT_HEALBOT,"UNIT_SPELLCAST_FAILED", HealBot_libCC_CastStop)
            libCC.RegisterCallback(HEALBOT_HEALBOT,"UNIT_SPELLCAST_INTERRUPTED", HealBot_libCC_CastStop)
            libCC.RegisterCallback(HEALBOT_HEALBOT,"UNIT_SPELLCAST_CHANNEL_START", HealBot_libCC_CastStart)
            libCC.RegisterCallback(HEALBOT_HEALBOT,"UNIT_SPELLCAST_CHANNEL_STOP", HealBot_libCC_CastStop)
        end
        HealBot_Load("VarsLoaded")
    end
      --HealBot_setCall("HealBot_OnEvent_VariablesLoaded")
end

function HealBot_OnEvent_ItemInfoReceived(self)
    HealBot:UnregisterEvent("GET_ITEM_INFO_RECEIVED");
    HealBot_setOptions_Timer(10)
      --HealBot_setCall("HealBot_OnEvent_ItemInfoReceived")
end

function HealBot_CheckLowMana()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Action_CheckUnitLowMana(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Action_CheckUnitLowMana(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Action_CheckUnitLowMana(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Action_CheckUnitLowMana(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Action_CheckUnitLowMana(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Action_CheckUnitLowMana(xButton)
    end
      --HealBot_setCall("HealBot_CheckLowMana")
end

function HealBot_UpdateAllEmergBars()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Action_EmergBarCheck(xButton, true)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Action_EmergBarCheck(xButton, true)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Action_EmergBarCheck(xButton, true)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Action_EmergBarCheck(xButton, true)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Action_EmergBarCheck(xButton, true)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Action_EmergBarCheck(xButton, true)
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

function HealBot_ResetOnSpecChange(spec)
    if spec then HealBot_Config.CurrentSpec=spec end
    HealBot_Data["PLEVEL"]=UnitLevel("player")
    HealBot_InitSpells()
    HealBot_Options_ResetDoInittab(50)
    HealBot_Options_ResetDoInittab(40)
    HealBot_Options_ResetDoInittab(10)
    HealBot_Options_ResetDoInittab(5)
    HealBot_Options_ResetDoInittab(4)
    HealBot_Options_setDebuffTypes()
    HealBot_setOptions_Timer(50)
    HealBot_setOptions_Timer(9930)
    HealBot_setOptions_Timer(176)
    HealBot_setOptions_Timer(170)
end

function HealBot_GetTalentInfo(button)
    if HEALBOT_GAME_VERSION>3 then
        local s,r,i=nil,nil,nil
        if UnitIsUnit(button.unit, "player") then
            i = GetSpecialization()
            if i then
                _, s, _, _, r, _ = GetSpecializationInfo(i,false,false) 
                if HealBot_Config.CurrentSpec~=i or HealBot_Data["PLEVEL"]~=UnitLevel("player") then 
                    HealBot_ResetOnSpecChange(i)
                end
            end
        else
            i,s,r = HealBot_GetSpec(button.unit)
        end
        if s then
            if button.unit=="target" then
                button.spec = " "..s.." " 
            elseif button.spec~=" "..s.." " then
                button.spec = " "..s.." "
                HealBot_Action_setButtonManaBarCol(button)
                if button.spec~=" " and button.frame<6 then
                    HealBot_nextRecalcParty(6)
                end
            end
        end
    elseif UnitIsUnit(button.unit, "player") and HealBot_Data["PLEVEL"]~=UnitLevel("player") then 
        HealBot_ResetOnSpecChange()
    end
    HealBot_OnEvent_UnitMana(button)
      --HealBot_setCall("HealBot_GetTalentInfo")
end

function HealBot_SetAddonComms()
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
        HealBot_Action_SetClassIconTexture(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Action_SetClassIconTexture(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Action_SetClassIconTexture(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Action_SetClassIconTexture(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Action_SetClassIconTexture(xButton)
    end
end

function HealBot_InitPlugins()
    local loaded, reason = LoadAddOn("HealBot_Plugin_Threat")
    HealBot_luVars["pluginThreatReason"]=reason or ""
    HealBot_luVars["pluginThreatLoaded"]=loaded
    if loaded and HealBot_Globals.PluginThreat then 
        HealBot_Plugin_Threat_Init()
        HealBot_Aggro_setLuVars("pluginThreat", true)
        HealBot_luVars["pluginThreat"]=true
    else
        HealBot_Aggro_setLuVars("pluginThreat", false)
        HealBot_luVars["pluginThreat"]=false
    end
    
    loaded, reason = LoadAddOn("HealBot_Plugin_TimeToDie")
    HealBot_luVars["pluginTimeToDieReason"]=reason or ""
    HealBot_luVars["pluginTimeToDieLoaded"]=loaded
    if loaded and HealBot_Globals.PluginTimeToDie then 
        HealBot_Plugin_TimeToDie_Init()
        HealBot_luVars["pluginTimeToDie"]=true
    else
        HealBot_luVars["pluginTimeToDie"]=false
    end
    
    loaded, reason = LoadAddOn("HealBot_Plugin_TimeToLive")
    HealBot_luVars["pluginTimeToLiveReason"]=reason or ""
    HealBot_luVars["pluginTimeToLiveLoaded"]=loaded
    if loaded and HealBot_Globals.PluginTimeToLive then 
        HealBot_Plugin_TimeToLive_Init()
        HealBot_luVars["pluginTimeToLive"]=true
    else
        HealBot_luVars["pluginTimeToLive"]=false
    end
        
    loaded, reason = LoadAddOn("HealBot_Plugin_ExtraButtons")
    HealBot_luVars["pluginExtraButtonsReason"]=reason or ""
    HealBot_luVars["pluginExtraButtonsLoaded"]=loaded
    if loaded and HealBot_Globals.PluginExtraButtons then 
        HealBot_luVars["pluginExtraButtons"]=true
        HealBot_Action_setLuVars("pluginExtraButtons", true)
        HealBot_setOptions_Timer(110)
    else
        HealBot_luVars["pluginExtraButtons"]=false
        HealBot_Action_setLuVars("pluginExtraButtons", false)
    end
    
    loaded, reason = LoadAddOn("HealBot_Plugin_CombatProt")
    HealBot_luVars["pluginCombatProtReason"]=reason or ""
    HealBot_luVars["pluginCombatProtLoaded"]=loaded
    if loaded and HealBot_Globals.PluginCombatProt then 
        HealBot_Plugin_CombatProt_Init()
        HealBot_luVars["pluginCombatProt"]=true
    else
        HealBot_luVars["pluginCombatProt"]=false
    end
    
    loaded, reason = LoadAddOn("HealBot_Plugin_Performance")
    HealBot_luVars["pluginPerformanceReason"]=reason or ""
    HealBot_luVars["pluginPerformanceLoaded"]=loaded
    if loaded and HealBot_Globals.PluginPerformance then 
        HealBot_Plugin_Performance_Init()
        HealBot_luVars["pluginPerformance"]=true
    else
        HealBot_luVars["pluginPerformance"]=false
    end
    
    loaded, reason = LoadAddOn("HealBot_Plugin_QuickSet")
    HealBot_luVars["pluginQuickSetReason"]=reason or ""
    HealBot_luVars["pluginQuickSetLoaded"]=loaded
    if loaded and HealBot_Globals.PluginQuickSet then 
        HealBot_Plugin_QuickSet_Init()
        HealBot_luVars["pluginQuickSet"]=true
    else
        HealBot_luVars["pluginQuickSet"]=false
    end
    
    
    --loaded, reason = LoadAddOn("HealBot_Plugin_EffectiveTanks")
    --HealBot_luVars["pluginEffectiveTanksReason"]=reason or ""
    --HealBot_luVars["pluginEffectiveTanksLoaded"]=loaded
    --if loaded and HealBot_Globals.PluginEffectiveTanks then 
    --    HealBot_Plugin_EffectiveTanks_Init()
    --    HealBot_luVars["pluginEffectiveTanks"]=true
    --else
    --    HealBot_luVars["pluginEffectiveTanks"]=false
    --end
    
    --loaded, reason = LoadAddOn("HealBot_Plugin_EfficientHealers")
    --HealBot_luVars["pluginEfficientHealersReason"]=reason or ""
    --HealBot_luVars["pluginEfficientHealersLoaded"]=loaded
    --if loaded and HealBot_Globals.PluginEfficientHealers then 
    --    HealBot_Plugin_EfficientHealers_Init()
    --    HealBot_luVars["pluginEfficientHealers"]=true
    --else
    --    HealBot_luVars["pluginEfficientHealers"]=false
    --end
end

function HealBot_Options_Update()
    if HealBot_Options_Timer[5] then
        HealBot_InitSpells()
        HealBot_Options_Timer[5]=nil
    elseif HealBot_Options_Timer[10] then
        HealBot_OnEvent_VariablesLoaded()
        HealBot_Options_Timer[10]=nil
    elseif HealBot_Options_Timer[11] then
        HealBot_Options_BuffDebuff_Reset("buff")
        HealBot_Options_ResetDoInittab(5)
        HealBot_Options_Timer[11]=nil
    elseif HealBot_Options_Timer[12] then
        HealBot_Options_BuffDebuff_Reset("debuff")
        HealBot_Options_ResetDoInittab(4)
        HealBot_Options_Timer[12]=nil
    elseif HealBot_Options_Timer[15] then
        HealBot_Options_ComboClass_Text()
        if HealBot_luVars["pluginExtraButtons"] then
           HealBot_Plugin_ExtraButtons_Options_Timer()
        end
        HealBot_Options_Timer[15]=nil
    elseif HealBot_Options_Timer[18] then
        HealBot_Options_BarFreq_setVars()
        HealBot_Options_FluidFlashInUse()
        HealBot_Action_SetFocusGroups()
        HealBot_Options_AuxBarFlashAlphaMinMaxSet()
        HealBot_Options_Timer[18]=nil
    elseif HealBot_Options_Timer[19] then
        HealBot_Action_CheckFrameSetPoint()
        HealBot_Options_Timer[19]=nil
    else
        HealBot_luVars["HealBot_Options_FastTimer"]=false
        if HealBot_Options_Timer[8888] then
            if not HealBot_luVars["ProcessRefresh"] then
                HealBot_luVars["ProcessRefresh"]=true
                C_Timer.After(0.02, HealBot_ProcessRefreshTypes)
            end
            HealBot_Options_Timer[8888]=nil
        elseif HealBot_Options_Timer[190] then
            HealBot_setOptions_Timer(195)
            HealBot_setOptions_Timer(9995)
            HealBot_PartyUpdate_CheckSkin()
            HealBot_Options_Timer[190]=nil
        elseif HealBot_Options_Timer[185] then
            HealBot_nextRecalcParty(0)
            HealBot_Options_Timer[185]=nil
        elseif HealBot_Options_Timer[405] then
            HealBot_MountsPets_InitUse()
            HealBot_Options_Timer[405]=nil
        elseif  HealBot_Options_Timer[410] then
            HealBot_MountsPets_InitMount()
            HealBot_Options_Timer[410]=nil
        elseif HealBot_Options_Timer[25] then
            for i=1, 10 do
                local g = _G["f"..i.."_HealBot_Action"]
                if HealBot_Globals.HealBot_Enable_MouseWheel then
                    g:EnableMouseWheel(1)  
                    g:SetScript("OnMouseWheel", function(self, delta)
                        HealBot_Action_HealUnit_Wheel(self, delta)
                    end)
                else
                    g:SetScript("OnMouseWheel", nil)
                    g:EnableMouseWheel(false)
                end
            end
            HealBot_Options_Timer[25]=nil
        elseif HealBot_Options_Timer[35] then
            HealBot_Aura_SetUpdateIconFreq()
            HealBot_Options_Timer[35]=nil
        elseif HealBot_Options_Timer[80] then
            HealBot_Text_sethbNumberFormat()
            HealBot_Text_sethbAggroNumberFormat()
            HealBot_Action_ResetUnitStatus(false)
            HealBot_Aura_SetIconUpdateInterval()
            HealBot_setOptions_Timer(185)
            HealBot_Options_Timer[80]=nil
        elseif HealBot_Options_Timer[81] then
            HealBot_Text_setExtraCustomCols()
            HealBot_Options_Timer[81]=nil
        elseif HealBot_Options_Timer[82] then
            HealBot_HealthAlertLevel(false)
            HealBot_Options_Timer[82]=nil
        elseif HealBot_Options_Timer[85] then
            HealBot_Text_UpdateNames()
            HealBot_Action_ResetUnitStatus(false)
            HealBot_Options_Timer[85]=nil
        elseif HealBot_Options_Timer[86] then
            HealBot_Text_UpdateHealth()
            HealBot_Options_Timer[86]=nil
        elseif HealBot_Options_Timer[88] then   
            HealBot_Text_ClearSeparateInHealsAbsorbs()
            HealBot_Options_Timer[88]=nil
        elseif HealBot_Options_Timer[87] then   
            HealBot_Text_ClearOverHeals()
            HealBot_Options_Timer[87]=nil
        elseif HealBot_Options_Timer[90] then
            HealBot_SetSkinColours();
            HealBot_Options_Timer[90]=nil
        elseif HealBot_Options_Timer[95] then
            HealBot_Text_UpdateButtons()
            HealBot_Action_ResetUnitStatus(false)
            HealBot_Options_SetBarsTextColour()
            HealBot_Panel_resetTestCols(true)
            HealBot_Options_Timer[95]=nil
        elseif HealBot_Options_Timer[100] then
            HealBot_SetBuffBarColours()
            HealBot_Options_Timer[100]=nil
        elseif HealBot_Options_Timer[110] then
            HealBot_Action_setRegisterForClicks()
            HealBot_Options_Timer[110]=nil
        elseif HealBot_Options_Timer[115] then
            HealBot_Options_clearAuxBars()
            HealBot_Options_Timer[115]=nil
        elseif HealBot_Options_Timer[116] then
            HealBot_Options_prepforAuxBars()
            HealBot_Options_Timer[116]=nil
            HealBot_setOptions_Timer(117)
        elseif HealBot_Options_Timer[117] then
            HealBot_Options_setAuxBars()
            HealBot_Options_Timer[117]=nil
            HealBot_setOptions_Timer(118)
        elseif HealBot_Options_Timer[118] then
            HealBot_setAllPowerBars()
            HealBot_OnEvent_PlayerTargetChanged()
            HealBot_setOptions_Timer(30)
            HealBot_Options_framesChanged(true)
            HealBot_Options_Timer[118]=nil
          --HealBot_setCall("HealBot_Options_Update-118")
        elseif HealBot_Options_Timer[119] then
            HealBot_InitPlugins();
            HealBot_Action_StickyFrameIndCols()
            HealBot_Options_Timer[119]=nil
        elseif HealBot_Options_Timer[120] then
            HealBot_CheckZone();
            HealBot_Options_Timer[120]=nil
        elseif HealBot_Options_Timer[121] then
            HealBot_Options_Timer[121]=nil
            HealBot_Aura_SetAuraWarningFlags()
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
            HealBot_Aura_ConfigClassHoT()
            HealBot_setOptions_Timer(171)
            HealBot_Options_Timer[170]=nil
        elseif HealBot_Options_Timer[171] then
            HealBot_Aura_ResetBuffCache()
            HealBot_Aura_setCustomBuffFilterDisabled()
            HealBot_setOptions_Timer(172)
            HealBot_Options_Timer[171]=nil
        elseif HealBot_Options_Timer[172] then
            HealBot_Aura_DeleteExcludeBuffInCache()
            HealBot_setOptions_Timer(30)
            HealBot_Options_Timer[172]=nil
        elseif HealBot_Options_Timer[174] then
            HealBot_Options_setDebuffPriority()
            HealBot_setOptions_Timer(176)
            HealBot_Options_Timer[174]=nil
        elseif HealBot_Options_Timer[175] then
            HealBot_Aura_setCustomDebuffFilterCastBy()
            HealBot_setOptions_Timer(30)
            HealBot_Options_Timer[175]=nil
        elseif HealBot_Options_Timer[176] then
            HealBot_Aura_ResetDebuffCache()
            HealBot_Aura_setCustomDebuffFilterDisabled()
            HealBot_setOptions_Timer(30)
            HealBot_Options_Timer[176]=nil
        elseif HealBot_Options_Timer[30] then
            HealBot_AuraCheck()
            HealBot_Options_Timer[30]=nil
        elseif HealBot_Options_Timer[50] then
            HealBot_Action_setpcClass()       
            _,xButton,pButton = HealBot_UnitID("player")
            if xButton then
                HealBot_OnEvent_UnitManaUpdate(xButton)
            end
            if pButton then
                HealBot_OnEvent_UnitManaUpdate(pButton)
            end
            HealBot_Options_Timer[50]=nil
        elseif  HealBot_Options_Timer[180] then
            if HealBot_luVars["HIDEPARTYF"] then
                HealBot_trackHiddenFrames["PARTY"]=true
                HealBot_Options_DisablePartyFrame()
                HealBot_Options_PlayerTargetFrames:Enable();
                if HealBot_luVars["HIDEPTF"] then
                    HealBot_trackHiddenFrames["PLAYER"]=true
                    HealBot_Options_DisablePlayerFrame()
                    HealBot_Options_DisablePetFrame()
                    HealBot_Options_DisableTargetFrame()
                elseif HealBot_trackHiddenFrames["PLAYER"] then 
                    HealBot_Options_ReloadUI(HEALBOT_OPTIONS_HIDEPARTYFRAMES.." ("..HEALBOT_OPTIONS_HIDEPLAYERTARGET..") - "..HEALBOT_WORD_OFF)
                end
                if HealBot_luVars["ReloadUI"]>TimeNow then
                    HealBot_Options_ReloadUI(HEALBOT_OPTIONS_HIDEPARTYFRAMES.." - "..HEALBOT_WORD_ON)
                end
            elseif HealBot_trackHiddenFrames["PARTY"] then
                HealBot_Options_ReloadUI(HEALBOT_OPTIONS_HIDEPARTYFRAMES.." - "..HEALBOT_WORD_OFF)
            end
            HealBot_Options_Timer[180]=nil
          --HealBot_setCall("HealBot_Options_Update-180")
        elseif HealBot_Options_Timer[181] then
            if HealBot_luVars["HIDEBOSSF"] then
                HealBot_trackHiddenFrames["MINIBOSS"]=true
                HealBot_Options_DisableMiniBossFrame()
                if HealBot_luVars["ReloadUI"]>TimeNow and HealBot_luVars["showReloadMsg"] then
                    HealBot_luVars["showReloadMsg"]=false
                    HealBot_Options_ReloadUI(HEALBOT_OPTIONS_HIDEMINIBOSSFRAMES.." - "..HEALBOT_WORD_ON)
                end
            elseif HealBot_trackHiddenFrames["MINIBOSS"] and HealBot_luVars["showReloadMsg"] then
                HealBot_luVars["showReloadMsg"]=false
                HealBot_Options_ReloadUI(HEALBOT_OPTIONS_HIDEMINIBOSSFRAMES.." - "..HEALBOT_WORD_OFF)
            end
            HealBot_Options_Timer[181]=nil
        elseif  HealBot_Options_Timer[182] then
            if HealBot_luVars["HIDERAIDF"] then
                HealBot_trackHiddenFrames["RAID"]=true
                HealBot_Options_DisableRaidFrame()
                if HealBot_luVars["ReloadUI"]>TimeNow then
                    HealBot_Options_ReloadUI(HEALBOT_OPTIONS_HIDERAIDFRAMES.." - "..HEALBOT_WORD_ON)
                end
            elseif HealBot_trackHiddenFrames["RAID"] then
                if HealBot_Globals.RaidHideMethod==0 then
                    HealBot_Options_ReloadUI(HEALBOT_OPTIONS_HIDERAIDFRAMES.." - "..HEALBOT_WORD_OFF)
                elseif HealBot_Globals.RaidHideMethod>1 then
                    if HealBot_Globals.RaidHideMethod>2 then
                        if HealBot_Globals.RaidHideMethod==4 then
                            HealBot_luVars["HIDERAIDF"]=true
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
            HealBot_Options_Timer[182]=nil
        elseif HealBot_Options_Timer[195] then
            HealBot_Options_InitSub(318)
            HealBot_Options_Timer[195]=nil
        elseif HealBot_Options_Timer[200] then
            _,xButton,pButton = HealBot_UnitID("player")
            if xButton then
                HealBot_GetTalentInfo(xButton)
            end
            if pButton then
                HealBot_GetTalentInfo(pButton)
            end
            HealBot_Aura_InitData()
            HealBot_Options_InitBuffClassList()
            HealBot_Options_InitBuffList()
            HealBot_Options_BuffDebuff_Reset("buff")
            if xButton then
                HealBot_Check_UnitAura(xButton)
            end
            if pButton then
                HealBot_Check_UnitAura(pButton)
            end
            HealBot_Options_Timer[200]=nil
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
                HealBot_nextRecalcParty(0)
                HealBot_Options_Timer[500]=nil
            elseif HealBot_Options_Timer[501] then
                HealBot_Config.DisabledNow=1
                HealBot_nextRecalcParty(0)
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
        elseif HealBot_Options_Timer[800] then
            HealBot_Options_RaidTargetUpdate()
            HealBot_Options_Timer[800]=nil
        elseif  HealBot_Options_Timer[990] then
            HealBot_AddChat(HEALBOT_HEALBOT .. " " .. _G["GREEN_FONT_COLOR_CODE"]..HEALBOT_VERSION.._G["FONT_COLOR_CODE_CLOSE"] .. HEALBOT_LOADED .. " " .. HEALBOT_FORHELP .. _G["YELLOW_FONT_COLOR_CODE"].." /hb h".._G["FONT_COLOR_CODE_CLOSE"]);
            HealBot_Options_Timer[990]=nil
        elseif HealBot_Options_Timer[2020] then
            HealBot_Aura_RemoveUnusedDebuffIcons()
            HealBot_Options_Timer[2020]=nil
        elseif HealBot_Options_Timer[2021] then
            HealBot_Aura_RemoveUnusedBuffIcons()
            HealBot_Options_Timer[2021]=nil
        elseif HealBot_Options_Timer[2025] then
            HealBot_UpdateAllIconsAlpha()
            HealBot_Options_Timer[2025]=nil
        elseif HealBot_Options_Timer[2050] then
            HealBot_Options_MainPanel()
            HealBot_Options_Timer[2050]=nil
        elseif HealBot_Options_Timer[2080] then
            HealBot_OnEvent_RaidTargetUpdateAll()
            HealBot_Options_Timer[2080]=nil
        elseif HealBot_Options_Timer[2100] then
            HealBot_Action_ResetEmergBars()
            HealBot_Options_Timer[2100]=nil
        elseif HealBot_Options_Timer[2110] then
            HealBot_UpdateAllEmergBars()
            HealBot_Options_Timer[2110]=nil
        elseif HealBot_Options_Timer[2500] then
            HealBot_Options_RegAggro()
            HealBot_Options_Timer[2500]=nil
        elseif HealBot_Options_Timer[2510] then
            HealBot_Options_CheckInHealsEvent()
            HealBot_Options_Timer[2510]=nil
        elseif HealBot_Options_Timer[2520] then
            HealBot_Options_Energy()
            HealBot_Options_Timer[2520]=nil
        elseif HealBot_Options_Timer[2530] then
            HealBot_nextRecalcParty(5)
            HealBot_Options_Timer[2530]=nil
        elseif HealBot_Options_Timer[3100] then
            HealBot_Plugin_Threat_TogglePanel()
            HealBot_Options_Timer[3100]=nil
        elseif HealBot_Options_Timer[3200] then
            HealBot_Plugin_TimeToDie_TogglePanel()
            HealBot_Options_Timer[3200]=nil
        elseif HealBot_Options_Timer[3300] then
            HealBot_Plugin_TimeToLive_TogglePanel()
            HealBot_Options_Timer[3300]=nil
        elseif HealBot_Options_Timer[3400] then
            HealBot_Plugin_EffectiveTanks_TogglePanel()
            HealBot_Options_Timer[3400]=nil
        elseif HealBot_Options_Timer[3500] then
            HealBot_Plugin_EfficientHealers_TogglePanel()
            HealBot_Options_Timer[3500]=nil
        elseif HealBot_Options_Timer[3600] then
            HealBot_Plugin_ExtraButtons_Options_Timer()
            HealBot_Options_Timer[3600]=nil
        elseif HealBot_Options_Timer[3700] then
            HealBot_Plugin_QuickSet_TogglePanel()
            HealBot_Options_Timer[3700]=nil
        elseif HealBot_Options_Timer[3710] then
            HealBot_Plugin_QuickSet_Options_Timer()
            HealBot_Options_Timer[3710]=nil
        elseif HealBot_Options_Timer[4910] then
            HealBot_Action_setLowManaTrig()
            HealBot_setOptions_Timer(4915)
            HealBot_Options_Timer[4910]=nil
        elseif HealBot_Options_Timer[4915] then
            local checkLowMana=false
            for j=1,10 do
                if Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j]["LOWMANA"]>1 and 
                   Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j]["LOWMANACOMBAT"]==false then
                    checkLowMana=true
                    break
                end
            end
            if checkLowMana then HealBot_CheckLowMana() end
            HealBot_Options_Timer[4915]=nil
        elseif HealBot_Options_Timer[4920] then
            HealBot_Options_FrameAlias_AfterTextChange()
            HealBot_Options_Timer[4920]=nil
        elseif HealBot_Options_Timer[4925] then
            HealBot_Options_Override_EffectsUse_Toggle()
            HealBot_Options_Timer[4925]=nil
        elseif HealBot_Options_Timer[4930] then
            HealBot_Options_AuxBarFlashAlphaMinMaxSet()
            HealBot_Options_Timer[4930]=nil
        elseif HealBot_Options_Timer[4940] then
            HealBot_Options_BarFreq_setVars()
            HealBot_Options_Timer[4940]=nil
        elseif HealBot_Options_Timer[4950] then
            HealBot_Options_FluidFlashInUse()
            HealBot_Options_Timer[4950]=nil
        elseif HealBot_Options_Timer[4960] then
            HealBot_Action_SetFocusGroups()
            HealBot_Options_Timer[4960]=nil
        elseif HealBot_Options_Timer[4980] then
            HealBot_Options_Override_ChatUse_Toggle()
            HealBot_Options_Timer[4980]=nil
        elseif HealBot_Options_Timer[4981] then
            HealBot_Options_SetChat()
            HealBot_Options_Timer[4981]=nil
        elseif HealBot_Options_Timer[4985] then
            HealBot_PlayerCheck()
            HealBot_Options_Timer[4985]=nil
        elseif HealBot_Options_Timer[4990] then
            HealBot_Options_Override_FramesUse_Toggle()
            HealBot_Options_Timer[4990]=nil
        elseif HealBot_Options_Timer[7000] then
            for x=1,10 do
                if HealBot_Action_FrameIsVisible(x) then
                    HealBot_Action_setPoint(x)
                end
            end
            HealBot_Options_Timer[7000]=nil
        elseif HealBot_Options_Timer[7100] then
            HealBot_Options_Timer[7100]=nil
            HealBot_CheckFramesOnCombat()
        elseif HealBot_Options_Timer[7950] then
            local mapAreaID = C_Map.GetBestMapForUnit("player")
            local y,z = IsInInstance()
            local mapName=HEALBOT_WORD_OUTSIDE
            if mapAreaID and mapAreaID>0 then
                mapName=C_Map.GetMapInfo(mapAreaID).name or mapName
                if mapAreaID==662 then 
                    HealBot_luVars["adjMaxHealth"]=mapAreaID 
                else
                    HealBot_luVars["adjMaxHealth"]=0
                end
            elseif z and z=="arena" then 
                mapName="Arena"
            end
            if z and (z=="pvp" or z=="arena") then 
                HealBot_luVars["inBG"]=true 
            else
                HealBot_luVars["inBG"]=nil
            end                            
            HealBot_Aura_setLuVars("hbInsName", mapName)
            HealBot_Panel_setLuVars("MAPID", mapAreaID)
            HealBot_Options_SetEnableDisableCDBtn()
            HealBot_Options_SetEnableDisableBuffBtn()
            HealBot_SetAddonComms()
            HealBot_setOptions_Timer(7955)
            HealBot_setOptions_Timer(7960)
            HealBot_Options_Timer[7950]=nil
        elseif HealBot_Options_Timer[7955] then
            HealBot_Aura_SetAuraCheckFlags()
            HealBot_Options_Timer[7955]=nil
        elseif HealBot_Options_Timer[7960] then
            HealBot_setOptions_Timer(176)
            HealBot_Options_Timer[7960]=nil
        elseif HealBot_Options_Timer[8000] then
            HealBot_Options_idleInit()
            HealBot_setOptions_Timer(8100)
            HealBot_setOptions_Timer(185)
            HealBot_Options_Timer[8000]=nil
        elseif HealBot_Options_Timer[187] then
            HealBot_Action_ResetAllButtons()
            HealBot_Options_Timer[187]=nil
        elseif HealBot_Options_Timer[188] then
            HealBot_Skins_ResetAll()
            HealBot_Options_Timer[188]=nil
        elseif HealBot_Options_Timer[8100] then
            HealBot_Options_Timer[8100]=nil
            HealBot_AuraCheck("player")
        elseif HealBot_Options_Timer[8110] then
            HealBot_Options_Timer[8110]=nil
            HealBot_Player_InvChange()
        elseif HealBot_Options_Timer[140] then
            if GetGuildInfo("player") then HealBot_Comms_SendAddonMsg(HEALBOT_HEALBOT, "G", 5, HealBot_Data["PNAME"]) end
            HealBot_setOptions_Timer(200)
            HealBot_setOptions_Timer(800)
            HealBot_setOptions_Timer(2145)
            HealBot_Options_Timer[140]=nil
        elseif HealBot_Options_Timer[2145] then
            if HEALBOT_GAME_VERSION>3 then
                local x=C_FriendList.GetNumFriends()
                if x>0 then
                    for y=1,x do
                        local f = C_FriendList.GetFriendInfoByIndex(y)
                        if f and f.connected then HealBot_Comms_SendAddonMsg(HEALBOT_HEALBOT, "F", 4, f.name) end
                    end
                end
            end
            HealBot_Options_Timer[2145]=nil
        elseif HealBot_Options_Timer[9100] then
            HealBot_Options_Timer[9100]=nil
            HealBot_Reset("Full")
        elseif HealBot_Options_Timer[9110] then
            HealBot_Options_Timer[9110]=nil
            HealBot_ResetCustomDebuffs()
        elseif HealBot_Options_Timer[9120] then
            HealBot_Options_Timer[9120]=nil
            HealBot_ResetSkins()
        elseif HealBot_Options_Timer[9130] then
            HealBot_Options_Timer[9130]=nil
            HealBot_Reset("Quick")
        elseif HealBot_Options_Timer[9150] then
            HealBot_Options_Timer[9150]=nil
            HealBot_UpdateAllHealth()
        elseif HealBot_Options_Timer[9200] then
            HealBot_Options_Timer[9200]=nil
            HealBot_Action_ModKey()
        elseif HealBot_Options_Timer[9300] then
            HealBot_Options_Timer[9300]=nil
            HealBot_Aggro_UpdateAggroText()
        elseif HealBot_Options_Timer[9400] then
            HealBot_Options_Timer[9400]=nil
            HealBot_ResetRange()
        elseif HealBot_Options_Timer[9920] then
            HealBot_Options_Timer[9920]=nil
            HealBot_Action_SetEnabledAttribs()
        elseif HealBot_Options_Timer[9921] then
            HealBot_Options_Timer[9921]=nil
            HealBot_Action_SetEnemyAttribs()
        elseif HealBot_Options_Timer[9922] then
            HealBot_Options_Timer[9922]=nil
            HealBot_Action_SetEmergAttribs()
        elseif HealBot_Options_Timer[9930] then
            HealBot_Options_Timer[9930]=nil
            HealBot_Action_PrepSetAllAttribs()
        elseif HealBot_Options_Timer[9931] then
            HealBot_Options_Timer[9931]=nil
            HealBot_Action_PrepSetEnabledAttribs()
        elseif HealBot_Options_Timer[9932] then
            HealBot_Options_Timer[9932]=nil
            HealBot_Action_PrepSetEnemyAttribs()
        elseif HealBot_Options_Timer[9933] then
            HealBot_Options_Timer[9933]=nil
            HealBot_Action_PrepSetEmergAttribs()
        elseif HealBot_Options_Timer[9940] then
            HealBot_Options_Timer[9940]=nil
            if HealBot_luVars["NoSpamOOM"]<TimeNow and 
              (((UnitPower("player", 0)/UnitPowerMax("player", 0))*100) < HealBot_luVars["EOCOOMV"]) then
                HealBot_luVars["NoSpamOOM"]=TimeNow+15
                DoEmote(HEALBOT_EMOTE_OOM)
            end
        elseif HealBot_Options_Timer[9950] then
            HealBot_Options_Timer[9950]=nil
            HealBot_ResetClassIconTexture()
        elseif HealBot_Options_Timer[9951] then
            HealBot_Options_Timer[9951]=nil
            HealBot_EndAggro()
        elseif HealBot_Options_Timer[9952] then
            HealBot_Options_Timer[9952]=nil
            HealBot_Action_CheckHideFrames()
        elseif HealBot_Options_Timer[9953] then
            HealBot_Options_Timer[9953]=nil
            HealBot_Not_Fighting()
        elseif HealBot_Options_Timer[9954] then
            HealBot_Options_Timer[9954]=nil
            HealBot_AfterCombatCleanup()
        elseif HealBot_Options_Timer[9960] then
            HealBot_Options_Timer[9960]=nil
            HealBot_Action_InitFrames()
            HealBot_ResetClassIconTexture()
        elseif HealBot_Options_Timer[9995] then
            HealBot_PartyUpdate_CheckSolo()
            HealBot_Options_Timer[9995]=nil
        elseif HealBot_Options_Timer[130] then
            HealBot_luVars["GetVersions"]=TimeNow+5
            HealBot_Options_Timer[130]=nil
        elseif HealBot_Options_Timer[9990] then 
            HealBot_Action_DeleteMarkedButtons()
            HealBot_Options_Timer[9990]=nil
        elseif HealBot_Options_Timer[9992] then 
            HealBot_Update_Slow()
            HealBot_Options_Timer[9992]=nil
        elseif HealBot_Options_Timer[9980] then
            local delay=HealBot_luVars["LoadDelay"]-TimeNow
            if delay<0.27 then delay=0.27 end
            C_Timer.After(delay, HealBot_Text_setSeparateInHealsAbsorbs)
            HealBot_Options_Timer[9980]=nil
        else -- 9999 will drop in here - for set timers only
            HealBot_Set_Timers()
            HealBot_luVars["HealBot_Options_Timer"]=false
        end
    end
    --HealBot_setCall("HealBot_Options_Update")
end

function HealBot_NoVehicle(unit)
    local HBvUnits=HealBot_VehicleUnit[unit]
    for xUnit,_ in pairs(HBvUnits) do
        if HealBot_UnitInVehicle[xUnit] then HealBot_UnitInVehicle[xUnit]=nil end
    end
    if HealBot_VehicleUnit[unit] then HealBot_VehicleUnit[unit]=nil end
      --HealBot_setCall("HealBot_NoVehicle")
end

function HealBot_ValidLivingEnemy(pUnit, eUnit)
    if UnitExists(pUnit) and UnitExists(eUnit) and UnitIsEnemy(pUnit, eUnit) and UnitHealthMax(eUnit)>100 and
       UnitHealth(eUnit)>(UnitHealthMax(eUnit)/10) then
        return true
    end
    return false
end

function HealBot_OnEvent_UnitThreat(button)
    if UnitAffectingCombat(button.unit) then
        if HealBot_luVars["UpdateEnemyFrame"] and not HealBot_Data["UILOCK"] and HealBot_Data["PALIVE"] then
            if Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["UNITINCOMBAT"]>1 and button.status.range>0 and 
               HealBot_ValidLivingEnemy(button.unit, button.unit.."target") and UnitIsUnit(button.unit, button.unit.."targettarget") then
                if Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["UNITINCOMBAT"]==3 then
                    HealBot_OnEvent_PlayerRegenDisabled()
                else
                    HealBot_UnitInCombat()
                end
            end
        end
        HealBot_CalcThreat(button)
    end
      --HealBot_setCall("HealBot_OnEvent_UnitThreat")
end

local health,healthMax,mhHealthPercent=0,0,0
function HealBot_OnEvent_UnitHealth(button)
    button.health.updhlth=false
    if button.status.current<HealBot_Unit_Status["DC"] then
        if UnitIsDeadOrGhost(button.unit) then
            healthMax=button.health.max
            if UnitIsFeignDeath(button.unit) then
                health=button.health.current
            else
                health=0
            end
        else
            if HealBot_luVars["adjMaxHealth"]>0 then 
                if UnitExists("boss1") then
                    --if HealBot_luVars["adjMaxHealth"]==662 then  -- Currently only have 1 encounter location
                        mhHealthPercent = select(15, UnitAura("boss1", GetSpellInfo(HEALBOT_DEBUFF_AURA_OF_CONTEMPT)))
                        if mhHealthPercent then
                            HealBot_luVars["healthFactor"]=mhHealthPercent / 100
                        end
                    --end
                end
                health,healthMax=UnitHealth(button.unit),(UnitHealthMax(button.unit) * HealBot_luVars["healthFactor"])
            else
                health,healthMax=UnitHealth(button.unit),UnitHealthMax(button.unit)
            end
            if health==0 then health=1 end
            --if health>healthMax then health=healthMax end
        end
        if healthMax==0 then healthMax=1 end
        if (health~=button.health.current) or (healthMax~=button.health.max) then
            --if healthMax~=100 or not HealBot_Panel_RaidUnitGUID(button.guid) or button.health.max<2000 then
                if HealBot_luVars["pluginTimeToDie"] and button.status.plugin then 
                    HealBot_Plugin_TimeToDie_UnitUpdate(button, health) 
                end
                if not HealBot_Data["UILOCK"] and health<button.health.current then
                    HealBot_OnEvent_UnitThreat(button)
                end
                button.health.current=health
                button.health.max=healthMax
            --end
            if health>0 then
                HealBot_OverHeal(button)
            elseif button.frame<10 and button.status.current<HealBot_Unit_Status["DEAD"] then 
                HealBot_Action_UpdateTheDeadButton(button, TimeNow)
            end
            HealBot_Action_UpdateHealthButton(button)
            if HealBot_Data["TIPBUTTON"] and HealBot_Data["TIPBUTTON"]==button then 
                HealBot_Action_RefreshTooltip() 
            end
        end
    else
        button.health.current=0
        button.status.alpha=0
        button.gref["Bar"]:SetValue(0)
        button.health.init=true
        HealBot_HealsInUpdate(button)
        HealBot_AbsorbsUpdate(button)
        HealBot_Text_UpdateText(button)
        if HealBot_luVars["pluginTimeToDie"] and button.status.plugin then 
            HealBot_Plugin_TimeToDie_UnitUpdate(button, 0) 
        end
    end
      --HealBot_setCall("HealBot_OnEvent_UnitHealth")
end

function HealBot_Plugin_TTDUpdate(guid)
    local unit=HealBot_Panel_RaidUnitGUID(guid)
    if unit and UnitExists(unit) then
        if HealBot_Unit_Button[unit] and HealBot_Unit_Button[unit].status.plugin then
            HealBot_Plugin_TimeToDie_UnitUpdate(HealBot_Unit_Button[unit], HealBot_Unit_Button[unit].health.current)
        elseif HealBot_Private_Button[unit] and HealBot_Private_Button[unit].status.plugin then
            HealBot_Plugin_TimeToDie_UnitUpdate(HealBot_Private_Button[unit], HealBot_Private_Button[unit].health.current)
        else
            HealBot_Plugin_TTDRemoveUnit(guid)
        end
    else
        HealBot_Plugin_TTDRemoveUnit(guid)
    end
end

function HealBot_DoVehicleChange(button, enterVehicle)
    --HealBot_Text_setHealthText(button)
    local doRefresh=false
    if enterVehicle then
        local vUnit=HealBot_UnitPet(button.unit)
        if vUnit and UnitHasVehicleUI(button.unit) then
            local vButton=HealBot_Vehicle_Button[vUnit] or HealBot_Pet_Button[vUnit]
            if not HealBot_VehicleUnit[vUnit] then HealBot_VehicleUnit[vUnit]={} end
            HealBot_VehicleUnit[vUnit][button.unit]=true
            HealBot_UnitInVehicle[button.unit]=vUnit
            if vButton then 
                HealBot_OnEvent_UnitHealth(vButton)
            end
            doRefresh=true
        end
    elseif HealBot_UnitInVehicle[button.unit] then
        local vUnit=HealBot_UnitInVehicle[button.unit]
        HealBot_NoVehicle(vUnit)
        doRefresh=true
    end
    if doRefresh then
        HealBot_Action_Refresh(button)
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["STATE"] then
            HealBot_nextRecalcParty(1)
        end
    end
end

function HealBot_OnEvent_VehicleChange(self, unit, enterVehicle)
    _,xButton,pButton = HealBot_UnitID(unit, true)
    if xButton then
        HealBot_DoVehicleChange(xButton, enterVehicle)
    end
    if pButton then
        HealBot_DoVehicleChange(pButton, enterVehicle)
    end
      --HealBot_setCall("HealBot_OnEvent_VehicleChange")
end

function HealBot_OnEvent_UnitPhase(button)
    if button.status.range==1 then button.status.range=-3 end
end

function HealBot_RaidTargetChecked(iconID, hbCurFrame)
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
    if button.status.current<HealBot_Unit_Status["RESERVED"] and Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][button.frame]["SHOW"] then 
        local x=GetRaidTargetIndex(button.unit)
        if x and HealBot_RaidTargetChecked(x, button.frame) then
            HealBot_Aura_RaidTargetUpdate(button, x)
        else
            HealBot_Aura_RaidTargetUpdate(button, 0)
        end
    else
        HealBot_Aura_RaidTargetUpdate(button, 0)
    end
      --HealBot_setCall("HealBot_OnEvent_RaidTargetUpdate")
end

function HealBot_OnEvent_RaidTargetUpdateAll()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_OnEvent_RaidTargetUpdate(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_OnEvent_RaidTargetUpdate(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_OnEvent_RaidTargetUpdate(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_OnEvent_RaidTargetUpdate(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_OnEvent_RaidTargetUpdate(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_OnEvent_RaidTargetUpdate(xButton)
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
        elseif GetNumGroupMembers()>14 then
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
    end
    return newSkinName,LastAutoSkinChangeType
end

function HealBot_PartyUpdate_CheckSolo()
    local PrevSolo=HealBot_luVars["IsSolo"]
    if IsInRaid() or IsInGroup() then
        if HealBot_luVars["IsSolo"] then
            HealBot_setOptions_Timer(130)
        end
        HealBot_luVars["IsSolo"]=false
    else
        HealBot_luVars["IsSolo"]=true
    end
    if PrevSolo~=HealBot_luVars["IsSolo"] then
        HealBot_setOptions_Timer(30)
        HealBot_setOptions_Timer(7955)
        HealBot_Options_DisableCheck()
    end
end

function HealBot_PartyUpdate_CheckSkin()
    local newSkinName,LastAutoSkinChangeType=HealBot_getDefaultSkin()
    if LastAutoSkinChangeType~=HealBot_Config.LastAutoSkinChangeType or HealBot_Config.LastAutoSkinChangeTime<TimeNow then
        if newSkinName~="_-none-_" and newSkinName~=Healbot_Config_Skins.Current_Skin then
            HealBot_Options_Set_Current_Skin(newSkinName)
        end
        HealBot_Config.LastAutoSkinChangeType=LastAutoSkinChangeType
    end
      --HealBot_setCall("HealBot_PartyUpdate_CheckSkin")
end

function HealBot_HealthAlertLevel(preCombat, button)
    if button then
        if preCombat then
            button.health.alert=Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][button.frame]["ALERTIC"]
        else
            button.health.alert=Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][button.frame]["ALERTOC"]
        end
    elseif preCombat then
        for _,xButton in pairs(HealBot_Unit_Button) do
            xButton.health.alert=Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][xButton.frame]["ALERTIC"]
        end
        for _,xButton in pairs(HealBot_Private_Button) do
            xButton.health.alert=Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][xButton.frame]["ALERTIC"]
        end
        for _,xButton in pairs(HealBot_Pet_Button) do
            xButton.health.alert=Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][xButton.frame]["ALERTIC"]
        end
        for _,xButton in pairs(HealBot_Vehicle_Button) do
             xButton.health.alert=Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][xButton.frame]["ALERTIC"]
        end
        for _,xButton in pairs(HealBot_Extra_Button) do
            xButton.health.alert=Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][xButton.frame]["ALERTIC"]
        end
        for _,xButton in pairs(HealBot_Enemy_Button) do
            xButton.health.alert=Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][xButton.frame]["ALERTIC"]
        end
    else
        for _,xButton in pairs(HealBot_Unit_Button) do
            xButton.health.alert=Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][xButton.frame]["ALERTOC"]
        end
        for _,xButton in pairs(HealBot_Private_Button) do
            xButton.health.alert=Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][xButton.frame]["ALERTOC"]
        end
        for _,xButton in pairs(HealBot_Pet_Button) do
            xButton.health.alert=Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][xButton.frame]["ALERTOC"]
        end
        for _,xButton in pairs(HealBot_Vehicle_Button) do
             xButton.health.alert=Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][xButton.frame]["ALERTOC"]
        end
        for _,xButton in pairs(HealBot_Extra_Button) do
            xButton.health.alert=Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][xButton.frame]["ALERTOC"]
        end
        for _,xButton in pairs(HealBot_Enemy_Button) do
            xButton.health.alert=Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][xButton.frame]["ALERTOC"]
        end
    end
end

local hbClassicEnemyCasts={}
function HealBot_AfterCombatCleanup()
    if HealBot_luVars["RegenDisabled"] then
        HealBot_luVars["RegenDisabled"]=false
        for guid in pairs(HealBot_MobGUID) do
            HealBot_MobGUID[guid]=nil
        end
        for name in pairs(HealBot_MobNames) do
            HealBot_MobNames[name]=nil
        end
        for guid in pairs(hbClassicEnemyCasts) do
            hbClassicEnemyCasts[guid]=nil
        end
        if HealBot_luVars["MessageReloadUI"]>0 then
            HealBot_MessageReloadUI(HealBot_luVars["MessageReloadUI"])
        end
        if HealBot_luVars["healthFactor"]~=1 then
            HealBot_luVars["healthFactor"]=1
            HealBot_setOptions_Timer(9150)
        end
        HealBot_setOptions_Timer(82)
        HealBot_setOptions_Timer(85)
        HealBot_setOptions_Timer(9951)
        HealBot_setOptions_Timer(9952)
        HealBot_setOptions_Timer(4915)
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["STATE"] then
            HealBot_nextRecalcParty(2)
        end
    end
end

function HealBot_Not_Fighting()
    if not InCombatLockdown() then
        if HealBot_Data["UILOCK"] then
            HealBot_Data["UILOCK"]=false
            HealBot_Aura_SetAuraCheckFlags()
            if not HealBot_luVars["UpdateEnemyFrame"] then
                HealBot_luVars["UpdateEnemyFrame"]=true
                HealBot_Panel_PartyChanged(false, 5)
            end
            if HealBot_Globals.DisableToolTipInCombat and HealBot_Data["TIPBUTTON"] then
                HealBot_Action_RefreshTooltip()
            end
            if HealBot_luVars["EOCOOM"] and HealBot_Data["POWERTYPE"]==0 then
                xButton=HealBot_Unit_Button["player"] or HealBot_Private_Button["player"]
                if xButton and xButton.status.current<HealBot_Unit_Status["DEAD"] then
                    HealBot_setOptions_Timer(9940)
                end
            end
            HealBot_luVars["TargetNeedReset"]=true
            HealBot_OnEvent_PlayerTargetChanged()
            HealBot_Action_ResetUnitStatus(true)
            HealBot_setOptions_Timer(9954)
        end
    elseif HealBot_Data["UILOCK"] then
        HealBot_luVars["DropCombat"]=true
    end
      --HealBot_setCall("HealBot_Not_Fighting")
end

function HealBot_OnEvent_DoReadyCheckClear(button)
    if button.icon.extra.readycheck then
        HealBot_Aura_RCUpdate(button, false)
    end
end

function HealBot_OnEvent_ReadyCheckClear(noAFK)
    if noAFK then
        HealBot_Aura_RemoveExtraIcons(93)
    else
        for _,xButton in pairs(HealBot_Unit_Button) do
            HealBot_OnEvent_DoReadyCheckClear(xButton)
        end
        for _,xButton in pairs(HealBot_Private_Button) do
            HealBot_OnEvent_DoReadyCheckClear(xButton)
        end
    end
      --HealBot_setCall("HealBot_OnEvent_ReadyCheckClear")
end

function HealBot_SetUnitDisconnectChange(button, offline, curState)
    button.status.offline=offline
    button.status.current=curState
    HealBot_Text_setNameTag(button)
    button.status.update=true
    button.status.change=true
end
        
function HealBot_SetUnitDisconnect(button)
    if button.status.offline and UnitIsConnected(button.unit) then
        HealBot_SetUnitDisconnectChange(button, false, HealBot_Unit_Status["CHECK"])
        HealBot_setOptions_Timer(130)
    elseif not button.status.offline and not UnitIsConnected(button.unit) then
        HealBot_SetUnitDisconnectChange(button, TimeNow, HealBot_Unit_Status["DC"])
        HealBot_Aux_clearAllBars(button)
    end
end

function HealBot_UnitSlowUpdateFriendly(button)
    if UnitIsDeadOrGhost(button.unit) and not UnitIsFeignDeath(button.unit) then
        HealBot_Action_UpdateTheDeadButton(button, TimeNow)
    elseif button.specupdate then
        button.specupdate=false
        HealBot_GetTalentInfo(button)
    elseif not button.status.classknown or button.health.max==1 then
        button.status.update=true
        button.status.change=true
    elseif not UnitOnTaxi("player") and button.aura.buff.nextcheck and button.aura.buff.nextcheck<TimeNow then
        if button.aura.buff.nextcheck==1 then
            HealBot_Aura_ResetCheckBuffsTime(button, TimeNow)
        else
            button.aura.buff.nextcheck=false
            HealBot_OnEvent_UnitAura(button)
        end
    else
        if button.health.updhlth then HealBot_OnEvent_UnitHealth(button) end
        if button.health.updincoming then 
            HealBot_HealsInUpdate(button) 
        elseif button.health.incoming>0 then
            button.health.updincoming=true
        end
        if button.health.updabsorbs then 
            HealBot_AbsorbsUpdate(button) 
        elseif button.health.absorbs>0 then
            button.health.updabsorbs=true
        end
    end
    if button.aggro.threatpct>0 then HealBot_CalcThreat(button) end
    HealBot_SetUnitDisconnect(button)
end

function HealBot_ProcessRefreshTypes()
    if not InCombatLockdown() then
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
        elseif HealBot_luVars["pluginClearDown"] then
            HealBot_luVars["pluginClearDown"]=false
            if HealBot_luVars["pluginTimeToDie"] then HealBot_Plugin_TimeToDie_Cleardown() end
            if HealBot_luVars["pluginTimeToLive"] then HealBot_Plugin_TimeToLive_Cleardown() end
            if HealBot_luVars["pluginThreat"] then HealBot_Plugin_Threat_Cleardown() end
        else
            HealBot_luVars["ProcessRefresh"]=false
            return
        end
        C_Timer.After(0.025, HealBot_ProcessRefreshTypes)
    else
        HealBot_luVars["ProcessRefresh"]=false
        HealBot_Options_Timer[8888]=true
    end
end

function HealBot_Update_Slow()
    if not HealBot_Data["UILOCK"] then
        HealBot_luVars["slowSwitch"]=HealBot_luVars["slowSwitch"]+1
        if HealBot_luVars["slowSwitch"]<2 then
            for xUnit,xGroup in pairs(HealBot_notVisible) do
                if UnitIsVisible(xUnit) then
                    HealBot_nextRecalcParty(xGroup)
                    HealBot_notVisible[xUnit]=nil
                end
            end
        elseif HealBot_luVars["slowSwitch"]<3 then
            if HealBot_luVars["GetVersions"] and HealBot_luVars["GetVersions"]<TimeNow then
                HealBot_Comms_SendAddonMsg(HEALBOT_HEALBOT, "R", HealBot_luVars["AddonMsgType"], HealBot_Data["PNAME"])
                HealBot_luVars["GetVersions"]=false
            end
        else
            if HealBot_DebugMsg[1] then
                HealBot_AddChat(HealBot_DebugMsg[1])
                table.remove(HealBot_DebugMsg,1)
            end
            if HealBot_luVars["VersionRequest"] then
                HealBot_Comms_SendAddonMsg(HEALBOT_HEALBOT, "S:"..HEALBOT_VERSION, HealBot_luVars["AddonMsgType"], HealBot_Data["PNAME"])
                HealBot_luVars["VersionRequest"]=false;
            end
            HealBot_Comms_SendAddonMessage()
            if HealBot_luVars["Loaded"] then HealBot_Set_FPS() end
            HealBot_luVars["slowSwitch"]=0
        end
    elseif HealBot_luVars["DropCombat"] and not InCombatLockdown() then
        HealBot_luVars["DropCombat"]=false
        HealBot_luVars["UILOCK"]=false
        HealBot_luVars["AllOutOfCombatCheck"]=TimeNow
    end
    if HealBot_luVars["Help"] then 
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
    if HealBot_luVars["EnableErrorSpeech"] then
        HealBot_luVars["EnableErrorSpeech"]=false
        SetCVar("Sound_EnableErrorSpeech", "1");
    end
    if HealBot_luVars["EnableErrorText"] then
        HealBot_luVars["EnableErrorText"]=false
        UIErrorsFrame:Clear()
        UIErrorsFrame:Show()
    end
    if HealBot_luVars["rcEnd"] and HealBot_luVars["rcEnd"]<TimeNow then
        HealBot_luVars["rcEnd"]=nil
        HealBot_OnEvent_ReadyCheckClear(false)
    end
    if HealBot_luVars["UpdateAllAura"]>0 then
        HealBot_luVars["UpdateAllAura"]=HealBot_luVars["UpdateAllAura"]-1
        if HealBot_luVars["UpdateAllAura"]==1 then
            HealBot_Aura_setLuVars("updateAll", false)
        end
    end
    if HealBot_luVars["massResTime"]>0 and HealBot_luVars["massResTime"]<TimeNow then
        HealBot_luVars["massResTime"]=0
        HealBot_UpdateMassRes()
    end
    if HealBot_luVars["massResAltTime"]>0 and HealBot_luVars["massResAltTime"]<TimeNow then
        HealBot_luVars["massResAltTime"]=0
        HealBot_UpdateMassRes()
    end
    for tGUID,_ in pairs(HealBot_SummonsTracker) do
        local sIncomming=false
        local tUnit=HealBot_Panel_RaidUnitGUID(tGUID)
        if not tUnit then
            HealBot_SummonsTracker[tGUID]=nil
        else
            for cGUID,eTime in pairs(HealBot_SummonsTracker[tGUID]) do
                local cUnit=HealBot_Panel_RaidUnitGUID(cGUID)
                if not cUnit or eTime<TimeNow or (UnitIsVisible(tUnit) and UnitIsVisible(cUnit)) then
                    HealBot_SummonsTracker[tGUID][cGUID]=nil
                else
                    sIncomming=true
                end
            end
        end
        if not sIncomming then HealBot_UnitSummonsUpdate(tGUID, sIncomming) end
    end
    if HealBot_luVars["runTimers"] then
        C_Timer.After(1, HealBot_Update_Slow)
    end
      --HealBot_setCall("HealBot_Update_Slow")
end

local hbCBLUsourceGUID, hbCBLUdestGUID, hbCBLUnit, hbCBLbutton="","","","",""
function HealBot_OnEvent_Combat_Log(...)
    hbCBLUsourceGUID, _, _, hbCBLUdestGUID = select(5, ...)
    if HealBot_luVars["pluginEffectiveTanks"] then 
        hbCBLUnit=HealBot_Panel_RaidUnitGUID(hbCBLUdestGUID)
        if hbCBLUnit then
            hbCBLbutton=HealBot_Unit_Button[hbCBLUnit]
            if hbCBLbutton and hbCBLbutton.status.plugin then
                HealBot_Plugin_EffectiveTanks_UnitUpdate(hbCBLbutton, ...)
            else
                hbCBLbutton=HealBot_Private_Button[hbCBLUnit]
                if hbCBLbutton and hbCBLbutton.status.plugin then
                    HealBot_Plugin_EffectiveTanks_UnitUpdate(hbCBLbutton, ...)
                end
            end
        end
    end
    if HealBot_luVars["pluginEfficientHealers"] then 
        hbCBLUnit=HealBot_Panel_RaidUnitGUID(hbCBLUsourceGUID)
        if hbCBLUnit then
            hbCBLbutton=HealBot_Unit_Button[hbCBLUnit]
            if hbCBLbutton and hbCBLbutton.status.plugin then
                HealBot_Plugin_EfficientHealers_UnitUpdate(hbCBLbutton, ...)
            else
                hbCBLbutton=HealBot_Private_Button[hbCBLUnit]
                if hbCBLbutton and hbCBLbutton.status.plugin then
                    HealBot_Plugin_EfficientHealers_UnitUpdate(hbCBLbutton, ...)
                end
            end
        end
    end
    --HealBot_setCall("HealBot_OnEvent_Combat_Log")
end

function HealBot_UnitUpdateButton(button)
    if UnitExists(button.unit) then
        if button.guid~=UnitGUID(button.unit) then
            HealBot_UpdateUnitGUIDChange(button)
        elseif button.status.update or button.status.current==HealBot_Unit_Status["RESERVED"] then 
            if button.status.change then
                HealBot_UpdateUnitExists(button)
            else
                HealBot_UpdateUnit(button)
            end
        elseif button.aura.check then
            HealBot_Aura_CheckUnitAuras(button, TimeNow)
        elseif button.status.refresh then 
            HealBot_Action_Refresh(button)
        else
            if button.status.range<1 or not CheckInteractDistance(button.unit, 4) then HealBot_UpdateUnitRange(button, true) end
            if HealBot_Action_IsUnitDead(button) then 
                HealBot_Action_UpdateTheDeadButton(button, TimeNow)
            elseif button.status.current==HealBot_Unit_Status["DC"] then
                HealBot_SetUnitDisconnect(button)
            elseif button.id==HealBot_luVars["slowUpdateID"] then 
                HealBot_UnitSlowUpdateFriendly(button)
            end
        end
        if button.status.dirarrowshown>0 and button.status.dirarrowshown<TimeNow then HealBot_Action_ShowDirectionArrow(button, TimeNow) end
        if button.aura.debuff.nextupdate<=TimeNow then HealBot_Aura_Update_UnitDebuffIcons(button,TimeNow) end
        if button.aura.buff.nextupdate<=TimeNow then HealBot_Aura_Update_UnitBuffIcons(button,TimeNow) end
    elseif button.status.current<HealBot_Unit_Status["RESERVED"] then
        HealBot_UpdateUnitNotExists(button)
    end
end

local addonMsg=""
function HealBot_ClassicEnemyCasts(guid, current, chan, name, startTime, endTime)
    if current then
        if not hbClassicEnemyCasts[guid] then hbClassicEnemyCasts[guid]={} end
        hbClassicEnemyCasts[guid].current=true
        hbClassicEnemyCasts[guid].chan=chan
        hbClassicEnemyCasts[guid].name=name
        hbClassicEnemyCasts[guid].startTime=startTime
        hbClassicEnemyCasts[guid].endTime=endTime
    elseif hbClassicEnemyCasts[guid] then
        hbClassicEnemyCasts[guid].current=false
    end
end

HealBot_luVars["updateEnemieGUID"]="ALL"
local euName, euStartTime, euEndTime, euChan="",0,false
function HealBot_EnemyUpdateAura(button)
    if UnitIsFriend("player",button.unit) then 
        if button.aura.buff.nextupdate<=TimeNow then HealBot_Aura_Update_UnitBuffIcons(button,TimeNow) end
        if button.status.dirarrowshown>0 and button.status.dirarrowshown<TimeNow then HealBot_Action_ShowDirectionArrow(button, TimeNow) end
        if button.status.castend>0 then HealBot_Aux_ClearCastBar(button) end
    elseif HealBot_AuxAssigns["CastBar"][button.frame] then
        if button.status.unittype==11 or HEALBOT_GAME_VERSION<2 then 
            euChan=false
            if HEALBOT_GAME_VERSION>1 then
                euName, _, _, euStartTime, euEndTime = UnitCastingInfo(button.unit) 
                if not euEndTime then
                    euChan=true
                    euName, _, _, euStartTime, euEndTime = UnitChannelInfo(button.unit) 
                end
            elseif hbClassicEnemyCasts[button.guid] and hbClassicEnemyCasts[button.guid].current then
                if hbClassicEnemyCasts[button.guid].endTime>(TimeNow*1000) then
                    euChan=hbClassicEnemyCasts[button.guid].chan
                    euName=hbClassicEnemyCasts[button.guid].name
                    euStartTime=hbClassicEnemyCasts[button.guid].startTime
                    euEndTime=hbClassicEnemyCasts[button.guid].endTime
                else
                    addonMsg="V:"..button.guid.."~F"
                    HealBot_Comms_SendInstantAddonMsg(HEALBOT_HEALBOT, addonMsg)
                    HealBot_ClassicEnemyCasts(button.guid, false, nil, nil, nil, nil)
                    euEndTime=false
                end
            else
                euEndTime=false
            end
            if not euEndTime and button.status.castend>0 then
                HealBot_Aux_ClearCastBar(button)
            elseif euEndTime and floor(button.status.castend/1000)~=floor(euEndTime/1000) then
                button.status.castend=euEndTime
                HealBot_Aux_UpdateCastBar(button, euName, euStartTime, euEndTime, euChan)
            end
        elseif button.status.castend>0 and button.status.castend<(TimeNow*1000) then
            HealBot_Aux_ClearCastBar(button)
        end
    elseif button.status.castend>0 then 
        HealBot_Aux_ClearCastBar(button)
    end
    if button.aura.debuff.nextupdate<=TimeNow then HealBot_Aura_Update_UnitDebuffIcons(button,TimeNow) end
    if HealBot_Config_Buffs.BuffWatch then
        if button.status.unittype==11 or button.aura.check then
            if UnitIsFriend("player",button.unit) then
                HealBot_Aura_CheckUnitAuras(button, TimeNow)
            else
                HealBot_Aura_RefreshEnemyAuras(button, TimeNow)
            end
        end
    end
end

function HealBot_EnemyUpdateHealth(button)
    if HealBot_Action_IsUnitDead(button) or (UnitIsDeadOrGhost(button.unit) and not UnitIsFeignDeath(button.unit)) then
        if UnitIsFriend("player",button.unit) then
            HealBot_Action_UpdateTheDeadButton(button, TimeNow)
        else
            button.health.current=2
            HealBot_Action_Refresh(button)
        end
    else
        HealBot_OnEvent_UnitHealth(button)
        HealBot_HealsInUpdate(button)
        HealBot_AbsorbsUpdate(button)
        HealBot_OnEvent_UnitMana(button)
    end
    if button.status.refresh then HealBot_Action_Refresh(button) end
end

function HealBot_EnemyUpdateButton(button)
    if UnitExists(button.unit) then
        euGUID=UnitGUID(button.unit) or button.unit
        if button.status.range<1 or not CheckInteractDistance(button.unit, 4) then
            HealBot_UpdateUnitRange(button, true)
        end
        if euGUID~=button.guid then 
            HealBot_UpdateUnitGUIDChange(button) 
        elseif button.status.update then
            if button.status.change then
                HealBot_UpdateUnitExists(button)
            else
                HealBot_UpdateUnit(button)
            end
        else
            if button.status.switch then
                button.status.switch=false
                HealBot_EnemyUpdateHealth(button)
            else
                button.status.switch=true
                HealBot_EnemyUpdateAura(button)
            end
        end
    elseif button.status.current<HealBot_Unit_Status["RESERVED"] then
        HealBot_UpdateUnitNotExists(button)
    end
end

function HealBot_Update_Fast01()
    for _,xButton in pairs(HealBot_Player_ButtonCache1) do
        HealBot_UnitUpdateButton(xButton)
    end
end

function HealBot_Update_Fast02()
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_UnitUpdateButton(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_UnitUpdateButton(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_UnitUpdateButton(xButton)
    end
end

function HealBot_Update_Fast03()
    for _,xButton in pairs(HealBot_Player_ButtonCache2) do
        HealBot_UnitUpdateButton(xButton)
    end
end

function HealBot_Update_Fast04()
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_UnitUpdateButton(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_EnemyUpdateButton(xButton)
    end
    if HealBot_luVars["MaskAuraCheckDebuff"] and HealBot_luVars["MaskAuraCheckDebuff"]<=TimeNow then
        HealBot_luVars["MaskAuraCheckDebuff"]=false
        HealBot_CheckAllActiveDebuffs()
    elseif HealBot_luVars["MaskAuraCheckBuff"] and HealBot_luVars["MaskAuraCheckBuff"]<=TimeNow then
        HealBot_luVars["MaskAuraCheckBuff"]=false
        HealBot_CheckAllActiveBuffs()
    end
    HealBot_luVars["slowUpdateID"]=HealBot_luVars["slowUpdateID"]+1
    if HealBot_luVars["slowUpdateID"]>HealBot_luVars["maxButtonId"] then
        HealBot_luVars["slowUpdateID"]=HealBot_luVars["minButtonId"]
    end
    HealBot_Update_Fast99()
    HealBot_luVars["fastSwitch"]=0
end

function HealBot_Update_Fast99()
    if HealBot_luVars["MovingFrame"]>0 then
        HealBot_Action_CheckForStickyFrame(HealBot_luVars["MovingFrame"],false)
    elseif HealBot_Data["TIPBUTTON"] then 
        HealBot_Action_RefreshTooltip()
    elseif HealBot_Data["TIPICON"] then
        HealBot_Tooltip_UpdateIconTooltip()
    end
end

local hbFastFuncs={[1]=HealBot_Update_Fast01,[2]=HealBot_Update_Fast02,[3]=HealBot_Update_Fast03,[4]=HealBot_Update_Fast04}
function HealBot_Update_Fast()
    TimeNow=GetTime()
    if HealBot_luVars["TestBarsOn"] then
        HealBot_Update_Fast99()
    elseif HealBot_luVars["ResetRefreshLists"] then
        HealBot_Update_ResetRefreshLists()
    else
        HealBot_luVars["fastSwitch"]=HealBot_luVars["fastSwitch"]+1
        hbFastFuncs[HealBot_luVars["fastSwitch"]]()
    end
end

function HealBot_Update_FastTimer()
    HealBot_Update_Fast()
    if HealBot_luVars["runTimers"] then
        C_Timer.After(HealBot_Timers["fastUpdateFreq"], HealBot_Update_FastTimer)
    end
end

function HealBot_fastUpdateEveryFrame(frames)
    if HealBot_luVars["fastUpdateEveryFrame"]<HealBot_EveryFrameUpdates[frames] then
        HealBot_luVars["fastUpdateEveryFrame"]=HealBot_EveryFrameUpdates[frames]
    end
end

local ouRegenEnabled=true
function HealBot_OnUpdate(self, elapsed)
    if not HealBot_luVars["UILOCK"] then
        if HealBot_Data["UILOCK"] and HealBot_luVars["AllOutOfCombatCheck"]<=TimeNow then
            ouRegenEnabled=true
            for xUnit,xButton in pairs(HealBot_Private_Button) do
                if xButton.status.current<HealBot_Unit_Status["DEAD"] and xButton.status.range>0 and UnitAffectingCombat(xUnit) and 
                   HealBot_ValidLivingEnemy(xUnit, xUnit.."target") and UnitIsUnit(xButton.unit, xButton.unit.."targettarget") then
                    ouRegenEnabled=false
                    break
                end
            end  
            if ouRegenEnabled then
                for xUnit,xButton in pairs(HealBot_Unit_Button) do
                    if xButton.status.current<HealBot_Unit_Status["DEAD"] and xButton.status.range>0 and UnitAffectingCombat(xUnit) and 
                       HealBot_ValidLivingEnemy(xUnit, xUnit.."target") and UnitIsUnit(xButton.unit, xButton.unit.."targettarget") then
                        ouRegenEnabled=false
                        break
                    end
                end
            end
            if ouRegenEnabled then
                HealBot_setOptions_Timer(9953)
                HealBot_luVars["AllOutOfCombatCheck"]=TimeNow+0.5
            else
                HealBot_luVars["AllOutOfCombatCheck"]=TimeNow+0.2
            end
        elseif HealBot_luVars["HealBot_Options_Timer"] then
            HealBot_Options_Update()
        end
    end
    if HealBot_luVars["fastUpdateEveryFrame"]>0 then
        HealBot_luVars["fastUpdateEveryFrame"]=HealBot_luVars["fastUpdateEveryFrame"]-1
        HealBot_Update_Fast()
    end
    --if HealBot_Data["TIPBUTTON"] and HealBot_luVars["NextTipTime"]<TimeNow then 
    --    HealBot_luVars["NextTipTime"]=HealBot_luVars["NextTipTime"]+HealBot_luVars["TipUpdateFreq"]
    --    HealBot_Action_RefreshTooltip()
    --end
end

function HealBot_Register_Aggro(button)
    button:RegisterUnitEvent("UNIT_ATTACK", button.unit)
    button:RegisterUnitEvent("UNIT_COMBAT", button.unit)
    button:RegisterUnitEvent("UNIT_TARGETABLE_CHANGED", button.unit)
    if HEALBOT_GAME_VERSION==1 then
        button:RegisterUnitEvent("PLAYER_TARGET_SET_ATTACKING", button.unit)
    end
    button:RegisterUnitEvent("UNIT_TARGET", button.unit)
    button:RegisterUnitEvent("UNIT_THREAT_SITUATION_UPDATE", button.unit)
    button:RegisterUnitEvent("UNIT_THREAT_LIST_UPDATE", button.unit)
      --HealBot_setCall("HealBot_Register_Aggro")
end

function HealBot_UnRegister_Aggro(button)
    button:UnregisterEvent("UNIT_ATTACK")
    button:UnregisterEvent("UNIT_COMBAT")
    button:UnregisterEvent("UNIT_TARGETABLE_CHANGED")
    if HEALBOT_GAME_VERSION==1 then
        button:UnregisterEvent("PLAYER_TARGET_SET_ATTACKING")
    end
    button:UnregisterEvent("UNIT_TARGET")
    button:UnregisterEvent("UNIT_THREAT_SITUATION_UPDATE")
    button:UnregisterEvent("UNIT_THREAT_LIST_UPDATE")
      --HealBot_setCall("HealBot_UnRegister_Aggro")
end

function HealBot_Register_IncHeals(button)
    if HEALBOT_GAME_VERSION>3 then
        button:RegisterUnitEvent("UNIT_HEAL_PREDICTION", button.unit)
    else
        libCHC = libCHC or HealBot_Libs_CHC()
        
        if libCHC and not HealBot_luVars["RegisteredLibCC"] then
            libCHC.RegisterCallback(HEALBOT_HEALBOT, "HealComm_HealStarted", 
                function(event, casterGUID, spellID, healType, endTime, ...) 
                HealBotClassic_HealsInUpdate(spellID, ...) end)
                
            libCHC.RegisterCallback(HEALBOT_HEALBOT, "HealComm_HealUpdated", 
                function(event, casterGUID, spellID, healType, endTime, ...) 
                HealBotClassic_HealsInUpdate(spellID, ...) end)
                
            libCHC.RegisterCallback(HEALBOT_HEALBOT, "HealComm_HealDelayed", 
                function(event, casterGUID, spellID, healType, endTime, ...) 
                HealBotClassic_HealsInUpdate(spellID, ...) end)
                
            libCHC.RegisterCallback(HEALBOT_HEALBOT, "HealComm_HealStopped", 
                function(event, casterGUID, spellID, healType, interrupted, ...) 
                HealBotClassic_HealsInUpdate(spellID, ...) end)

            HealBot_luVars["RegisteredLibCC"]=true
            --HealBot_luVars["UnregisteredLibCC"]=false
        end
    end
      --HealBot_setCall("HealBot_Register_IncHeals")
end

function HealBot_UnRegister_IncHeals(button)
    if HEALBOT_GAME_VERSION>3 then
        button:UnregisterEvent("UNIT_HEAL_PREDICTION")
    --elseif libCHC and not HealBot_luVars["UnregisteredLibCC"] then
    --    libCHC.UnregisterCallback(HEALBOT_HEALBOT, "HealComm_HealStarted")
    --    libCHC.UnregisterCallback(HEALBOT_HEALBOT, "HealComm_HealUpdated")
    --    libCHC.UnregisterCallback(HEALBOT_HEALBOT, "HealComm_HealDelayed")
    --    libCHC.UnregisterCallback(HEALBOT_HEALBOT, "HealComm_HealStopped")
    --    --libCHC.UnregisterCallback(HEALBOT_HEALBOT, "HealComm_ABSORB-EVENT")
    --    HealBot_luVars["UnregisteredLibCC"]=true
    --    HealBot_luVars["RegisteredLibCC"]=false
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
    HealBot_luVars["rcEnd"]=TimeNow
      --HealBot_setCall("HealBot_UnRegister_ReadyCheck")
end

function HealBot_Register_Mana(button)
    button:RegisterUnitEvent("UNIT_POWER_UPDATE", button.unit)
    button:RegisterUnitEvent("UNIT_DISPLAYPOWER", button.unit)
    button:RegisterUnitEvent("UNIT_MAXPOWER", button.unit)
      --HealBot_setCall("HealBot_Register_Mana")
end

function HealBot_UnRegister_Mana(button)
    button:UnregisterEvent("UNIT_POWER_UPDATE")
    button:UnregisterEvent("UNIT_DISPLAYPOWER")
    button:UnregisterEvent("UNIT_MAXPOWER")
      --HealBot_setCall("HealBot_UnRegister_Mana")
end

local UnitBosses={["boss1"]=true,["boss2"]=true,["boss3"]=true,["boss4"]=true}
function HealBot_UnitBosses(unit)
    return UnitBosses[unit]
end

local ctEnemyUnit=false
local UnitThreatData={["status"]=0,["threatpct"]=0,["threatvalue"]=0,["threatname"]=false,["mobname"]=false,["mobGUID"]=false,["tmpstatus"]=0,["tmppct"]=0,["tmpvalue"]=0}

function HealBot_CalcUnitThreat(unit, enemy)
    _, UnitThreatData["tmpstatus"], UnitThreatData["tmppct"], _, UnitThreatData["tmpvalue"] = UnitDetailedThreatSituation(unit, enemy)
    UnitThreatData["threatpct"]=ceil(UnitThreatData["tmppct"] or 0)
    UnitThreatData["status"]=UnitThreatData["tmpstatus"] or 0
    UnitThreatData["threatvalue"]=UnitThreatData["tmpvalue"] or 0
end

function HealBot_CalcThreat(button)
    UnitThreatData["threatpct"],UnitThreatData["status"],UnitThreatData["threatvalue"],ctEnemyUnit,UnitThreatData["threatname"]=0,0,0,false,""
    if button.status.current<HealBot_Unit_Status["DEAD"] and UnitIsFriend("player",button.unit) then
        UnitThreatData["tmppct"],UnitThreatData["tmpstatus"],UnitThreatData["tmpvalue"]=0,0,0
        if HealBot_ValidLivingEnemy(button.unit, button.unit.."target") then 
            ctEnemyUnit=button.unit.."target"
            _, UnitThreatData["status"], UnitThreatData["threatpct"], _, UnitThreatData["threatvalue"] = UnitDetailedThreatSituation(button.unit, ctEnemyUnit)
            UnitThreatData["threatpct"]=ceil(UnitThreatData["threatpct"] or 0)
            if not UnitThreatData["threatvalue"] then UnitThreatData["threatvalue"]=0 end
            if not UnitThreatData["status"] then UnitThreatData["status"]=0 end
        elseif HealBot_ValidLivingEnemy(HealBot_luVars["TankUnit"], HealBot_luVars["TankUnit"].."target") then 
            ctEnemyUnit=HealBot_luVars["TankUnit"].."target"
            HealBot_CalcUnitThreat(button.unit, ctEnemyUnit)
        elseif HealBot_ValidLivingEnemy(button.unit, "boss1") then 
            ctEnemyUnit="boss1"
            HealBot_CalcUnitThreat(button.unit, ctEnemyUnit)
        elseif HealBot_ValidLivingEnemy(button.unit, "boss2") then 
            ctEnemyUnit="boss2"
            HealBot_CalcUnitThreat(button.unit, ctEnemyUnit)
        elseif HealBot_ValidLivingEnemy("player", "target") then 
            ctEnemyUnit="playertarget"
            HealBot_CalcUnitThreat(button.unit, ctEnemyUnit)
        end
        if ctEnemyUnit then
            UnitThreatData["mobGUID"]=UnitGUID(ctEnemyUnit) or "-nil"
            if not HealBot_MobGUID[UnitThreatData["mobGUID"]] then
                UnitThreatData["mobname"]=UnitName(ctEnemyUnit)
                if UnitThreatData["mobname"] then
                    if HealBot_MobNames[UnitThreatData["mobname"]] then
                        HealBot_MobNames[UnitThreatData["mobname"]]=HealBot_MobNames[UnitThreatData["mobname"]]+1
                        HealBot_MobGUID[UnitThreatData["mobGUID"]]=UnitThreatData["mobname"].." "..HealBot_MobNames[UnitThreatData["mobname"]]
                    else
                        HealBot_MobNames[UnitThreatData["mobname"]]=1
                        HealBot_MobGUID[UnitThreatData["mobGUID"]]=UnitThreatData["mobname"]
                    end
                else
                    HealBot_MobGUID[UnitThreatData["mobGUID"]]=""
                end
            end
            UnitThreatData["threatname"]=HealBot_MobGUID[UnitThreatData["mobGUID"]]
            if HealBot_luVars["pluginThreat"] and button.status.plugin then 
                HealBot_Plugin_Threat_UpdateMobRT(UnitThreatData["threatname"], (GetRaidTargetIndex(ctEnemyUnit) or 0)) 
            end
            if not UnitThreatData["status"] then UnitThreatData["status"]=0 end
        else
            UnitThreatData["status"]=UnitThreatSituation(button.unit) or 0
            if UnitThreatData["status"]>0 then
                UnitThreatData["threatpct"]=button.aggro.threatpct
                UnitThreatData["threatvalue"]=button.aggro.threatvalue
                UnitThreatData["threatname"]=button.aggro.mobname
            end
        end
        if UnitThreatData["threatpct"]>=HealBot_Globals.aggro3pct then
            UnitThreatData["status"]=3
            if UnitThreatData["threatpct"]>100 then UnitThreatData["threatpct"]=100 end
        elseif UnitThreatData["threatpct"]>=HealBot_Globals.aggro2pct and UnitThreatData["status"]<2 then
            UnitThreatData["status"]=2 
        elseif (UnitThreatData["threatpct"]>0 or UnitThreatData["threatvalue"]>0) then
            if UnitThreatData["status"]<1 then UnitThreatData["status"]=1 end
            if UnitThreatData["threatpct"]<1 then UnitThreatData["threatpct"]=1 end
        end
        if UnitThreatData["threatpct"]<HealBot_Globals.aggro2pct and UnitThreatData["status"]>1 then
            UnitThreatData["status"]=1
        elseif  UnitThreatData["threatpct"]<HealBot_Globals.aggro3pct and UnitThreatData["status"]==3 then
            UnitThreatData["status"]=2
        end
        if not UnitThreatData["threatname"] then UnitThreatData["threatname"]="" end
        if UnitThreatData["status"]<1 then
            HealBot_Aggro_ClearUnitAggro(button)
        elseif button.aggro.status~=UnitThreatData["status"] or UnitThreatData["threatpct"]~=button.aggro.threatpct or UnitThreatData["threatvalue"]~=button.aggro.threatvalue or UnitThreatData["threatname"]~=button.aggro.mobname then
            HealBot_Aggro_UpdateUnit(button,true,UnitThreatData["status"],UnitThreatData["threatpct"],"",UnitThreatData["threatvalue"],UnitThreatData["threatname"])
        end
    else
        HealBot_Aggro_ClearUnitAggro(button)
    end
      --HealBot_setCall("HealBot_CalcThreat")
end

function HealBot_Plugin_ThreatUpdate(guid)
    local unit=HealBot_Panel_RaidUnitGUID(guid)
    if unit and UnitExists(unit) then
        if HealBot_Unit_Button[unit] and HealBot_Unit_Button[unit].status.plugin then
            HealBot_CalcThreat(HealBot_Unit_Button[unit])
            HealBot_Plugin_Threat_UnitUpdate(HealBot_Unit_Button[unit])
        elseif HealBot_Private_Button[unit] and HealBot_Private_Button[unit].status.plugin then
            HealBot_CalcThreat(HealBot_Private_Button[unit])
            HealBot_Plugin_Threat_UnitUpdate(HealBot_Private_Button[unit])
        else
            HealBot_Plugin_ThreatRemoveUnit(guid)
        end
    else
        HealBot_Plugin_ThreatRemoveUnit(guid)
    end
      --HealBot_setCall("HealBot_Plugin_ThreatUpdate")
end

local noName=false
function HealBot_UnitNameOnly(unitName)
    noName=false
    if unitName then
        noName=strtrim(string.match(unitName, "^[^-]*"))
    end
      --HealBot_setCall("HealBot_UnitNameOnly")
    return noName
end

local amSenderId=false
function HealBot_OnEvent_AddonMsg(self,addon_id,msg,distribution,sender_id)
    amSenderId = HealBot_UnitNameOnly(sender_id)
    if amSenderId and msg and addon_id==HEALBOT_HEALBOT then
        local datatype, datamsg = string.split(":", msg)
        if datatype then
            if datatype=="R" then
                HealBot_luVars["VersionRequest"]=amSenderId
            elseif datatype=="G" then
                HealBot_Comms_SendAddonMsg(HEALBOT_HEALBOT, "H:"..HEALBOT_VERSION, 4, amSenderId)
                if not HealBot_Vers[amSenderId] then
                    HealBot_Comms_SendAddonMsg(HEALBOT_HEALBOT, "G", 4, amSenderId)
                end
            elseif datatype=="F" then
                HealBot_Comms_SendAddonMsg(HEALBOT_HEALBOT, "C:"..HEALBOT_VERSION, 4, amSenderId)
                if not HealBot_Vers[amSenderId] then
                    HealBot_Comms_SendAddonMsg(HEALBOT_HEALBOT, "F", 4, amSenderId)
                end
            elseif datamsg then
                if datatype=="S" or datatype=="H" or datatype=="C" then
                    HealBot_Vers[amSenderId]=datamsg
                    HealBot_AddDebug(amSenderId..": "..datamsg, "Version", false);
                    HealBot_Comms_CheckVer(amSenderId, datamsg)
                elseif datatype=="V" and amSenderId~=UnitName("player") then
                    local guid, current, chan, name, startTime, endTime=string.split("~", datamsg)
                    if current=="T" then
                        if chan=="T" then
                            chan=true
                        else
                            chan=false
                        end
                        startTime=(TimeNow*1000)-tonumber(startTime)
                        endTime=startTime+tonumber(endTime)
                        HealBot_ClassicEnemyCasts(guid, true, chan, name, startTime, endTime)
                    else
                        HealBot_ClassicEnemyCasts(guid, false, nil, nil, nil, nil)
                    end
                    --HealBot_AddDebug("AddonMsg "..amSenderId..":"..datamsg);
                end
            end
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

function HealBot_OnEvent_LeavingVehicle(unit)
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["STATE"] then
        HealBot_nextRecalcParty(1)
    end
      --HealBot_setCall("HealBot_OnEvent_LeavingVehicle")
end

function HealBot_retIsInVehicle(unit)
      --HealBot_setCall("HealBot_retIsInVehicle")
    return HealBot_UnitInVehicle[unit]
end

function HealBot_Check_UnitAura(button)
    button.aura.check=true
    HealBot_fastUpdateEveryFrame(1)
        --HealBot_setCall("HealBot_Check_UnitAura")
end

local HealBot_BagScanTooltip=CreateFrame("GameTooltip", "hbBagScanerTooltip", nil, "GameTooltipTemplate")
local HealBot_WellFedItems={}
HealBot_BagScanTooltip:SetOwner( WorldFrame, "ANCHOR_NONE" );

function HealBot_retWellFedItems()
    return HealBot_WellFedItems
end

local function EnumerateTooltipLines_helper(...)
    local prevText,region=nil,nil
    for i = 1, select("#", ...) do
        region = select(i, ...)
        if region and region:GetObjectType() == "FontString" then
            if region:GetText() then
                if string.find(region:GetText(), HEALBOT_STRING_MATCH_WELLFED) then
                    return prevText
                elseif not prevText then
                    prevText=region:GetText()
                end
            end
        end
    end
    return false
end

function HealBot_BagScanWellFed(bag)
    local itemID=0
    local itemText=""
    for slot = 1,GetContainerNumSlots(bag) do
        HealBot_BagScanTooltip:SetBagItem(bag, slot)
        itemText=EnumerateTooltipLines_helper(HealBot_BagScanTooltip:GetRegions())
        if itemText then
            HealBot_WellFedItems[itemText]=true
        end
    end
    if bag<4 then
        C_Timer.After(0.05, function() HealBot_BagScanWellFed(bag+1) end)
    else
        HealBot_Options_SetBuffExtraItemText()
        C_Timer.After(0.05, HealBot_Aura_InitItemsData)
    end
end

function HealBot_CheckWellFedItems()
    for x,_ in pairs(HealBot_WellFedItems) do
        HealBot_WellFedItems[x]=nil
    end
    HealBot_BagScanWellFed(0)
end

function HealBot_Player_InvCheck()
    HealBot_luVars["invCheck"]=false
    HealBot_ItemIdsInBags()
end

function HealBot_OnEvent_InvChange()
    HealBot_setOptions_Timer(8110)
end

function HealBot_Player_InvChange()
    xButton=HealBot_Unit_Button["player"] or HealBot_Private_Button["player"]
    if xButton then
        if not HealBot_luVars["invCheck"] then
            HealBot_luVars["invCheck"]=true
            C_Timer.After(1, HealBot_Player_InvCheck)
        end
    else
        HealBot_OnEvent_InvChange()
    end
end

function HealBot_OnEvent_UnitAura(button)
    if button.status.unittype>10 then
        if UnitIsFriend("player",button.unit) then
            HealBot_Aura_CheckUnitAuras(button, TimeNow)
        else
            HealBot_Aura_RefreshEnemyAuras(button, TimeNow)
        end
    else
        HealBot_Aura_CheckUnitAuras(button, TimeNow)
    end
        --HealBot_setCall("HealBot_OnEvent_UnitAura")
end

function HealBot_UpdateAllHealth()
    for _,xButton in pairs(HealBot_Unit_Button) do
        xButton.health.updhlth=true
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        xButton.health.updhlth=true
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        xButton.health.updhlth=true
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        xButton.health.updhlth=true
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        xButton.health.updhlth=true
    end
    --HealBot_fastUpdateEveryFrame(1)
      --HealBot_setCall("HealBot_UpdateAllHealth")
end

function HealBot_OnEvent_SpecChange(button)
    if UnitIsUnit(button.unit,"player") then
        HealBot_Player_TalentsChanged()
    else
        HealBot_GetTalentInfo(button)
        HealBot_setOptions_Timer(185)
    end
end

function HealBot_OnEvent_UnitTarget(button)
    HealBot_CalcThreat(button)           
    if not HealBot_Data["UILOCK"] and HealBot_Panel_IsTargetingEnemy(button.unit) then
        HealBot_nextRecalcParty(5)
    end
end

function HealBot_PlayerTargetChanged()
    if UnitExists("target") then
        C_Timer.After(0.05, function() HealBot_nextRecalcParty(3) end)
    else
        HealBot_nextRecalcParty(3)
    end
end

HealBot_luVars["AuxTargetInUse"]=false
local hbCurrentTargetButton={}
function HealBot_OnEvent_PlayerTargetChanged()
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][9]["STATE"] then
        if not HealBot_Data["UILOCK"] and HealBot_luVars["TargetNeedReset"] then
            if UnitExists("target") and HealBot_retHbFocus("target") then
                if not UnitExists("focus") or not HealBot_retHbFocus("focus") then
                    HealBot_Panel_clickToFocus("Show")
                else
                    HealBot_Panel_clickToFocus("hide")
                end
            else
                HealBot_Panel_clickToFocus("hide")
            end
            HealBot_Panel_TargetChangedCheckFocus()
            HealBot_PlayerTargetChanged()
        else
            local xButton=HealBot_Extra_Button["target"]
            if xButton then
                if not HealBot_Data["UILOCK"] then
                    if UnitExists(xButton.unit) and HealBot_Panel_validTarget(xButton.unit) then
                        HealBot_Action_ShowHideFrames(xButton)
                    elseif HealBot_Action_FrameIsVisible(8) then
                        HealBot_Action_HidePanel(8)
                    end
                end
                xButton.status.update=true
                xButton.status.change=true
            else
                HealBot_PlayerTargetChanged()
            end
        end
    elseif HealBot_Action_FrameIsVisible(8) then
        HealBot_PlayerTargetChanged()
    end
    if HealBot_luVars["AuxTargetInUse"] then
        for xButton,_ in pairs(hbCurrentTargetButton) do
            HealBot_Aux_ClearTargetBar(xButton)
            hbCurrentTargetButton[xButton]=nil
        end
        if UnitExists("target") then
            local tUnit=HealBot_Panel_RaidUnitGUID(UnitGUID("target"))
            if tUnit then
                local xButton = HealBot_Unit_Button[tUnit] or HealBot_Pet_Button[tUnit] or HealBot_Vehicle_Button[tUnit]
                if xButton then
                    HealBot_Aux_UpdateTargetBar(xButton)
                    hbCurrentTargetButton[xButton]=true
                end
                xButton = HealBot_Private_Button[tUnit]
                if xButton then
                    HealBot_Aux_UpdateTargetBar(xButton)
                    hbCurrentTargetButton[xButton]=true
                end
            end
        end
    end
      --HealBot_setCall("HealBot_OnEvent_PlayerTargetChanged")
end

function HealBot_DoClearLowMana(button)
    button.gref.icon["Icontm1"]:SetAlpha(0)
    button.gref.icon["Icontm2"]:SetAlpha(0)
    button.gref.icon["Icontm3"]:SetAlpha(0)
end

function HealBot_ClearLowMana()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_DoClearLowMana(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_DoClearLowMana(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_DoClearLowMana(xButton)
    end
      --HealBot_setCall("HealBot_ClearLowMana")
end

local prdCheckIsVisible={[1]=true, [2]=true, [3]=true, [4]=true, [5]=true, [6]=true, [7]=true, [8]=true, [9]=true, [10]=true}
local prdCheckActiveFrames={[1]=true, [2]=true, [3]=true, [4]=true, [5]=true, [6]=true, [7]=true, [8]=true, [9]=true, [10]=true}
function HealBot_UnitInCombat()
    if HealBot_luVars["UpdateEnemyFrame"] then
        HealBot_luVars["UpdateEnemyFrame"]=false
        HealBot_luVars["AllOutOfCombatCheck"]=TimeNow+0.5
        HealBot_Panel_PartyChanged(true, 5)
    end
end

function HealBot_CheckActiveFrames(frame, active)
    prdCheckActiveFrames[frame]=active
    HealBot_luVars["CheckFramesOnCombat"]=true
end

function HealBot_CheckFramesOnCombat()
    HealBot_luVars["CheckFramesOnCombat"]=false
    for f=1,10 do
        if Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][f]["AUTOCLOSE"]>1 and prdCheckActiveFrames[f] then
            HealBot_luVars["CheckFramesOnCombat"]=true
            break
        end
    end
end

function HealBot_OnEvent_PlayerRegenDisabled()
    HealBot_Data["UILOCK"]=true
    HealBot_luVars["RegenDisabled"]=true
    if HealBot_luVars["HealBot_Options_FastTimer"] then
        for f=1,19 do
            if HealBot_luVars["HealBot_Options_FastTimer"] then
                HealBot_Options_Update()
            end
        end
    end
    if HealBot_RefreshTypes[0] then
        HealBot_RefreshTypes[1]=true
        HealBot_RefreshTypes[2]=true
        HealBot_RefreshTypes[3]=true
        HealBot_RefreshTypes[4]=true
        HealBot_RefreshTypes[6]=true
        HealBot_RefreshTypes[0]=false
    end
    if HealBot_RefreshTypes[6] then HealBot_RecalcParty(6); end
    if HealBot_RefreshTypes[1] then HealBot_RecalcParty(1); end
    if HealBot_RefreshTypes[2] then HealBot_RecalcParty(2); end
    if HealBot_RefreshTypes[3] then HealBot_RecalcParty(3); end
    if HealBot_RefreshTypes[4] then HealBot_RecalcParty(4); end
    HealBot_UnitInCombat()
    if HealBot_luVars["CheckFramesOnCombat"] then
        for f=1,10 do
            if Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][f]["AUTOCLOSE"]>1 and prdCheckActiveFrames[f] then
                prdCheckIsVisible[f]=true
            end
        end
        for _,xButton in pairs(HealBot_Unit_Button) do
            if prdCheckIsVisible[xButton.frame] and xButton.status.current<HealBot_Unit_Status["DC"] then
                if not HealBot_Action_FrameIsVisible(xButton.frame) then
                    HealBot_Action_ShowPanel(xButton.frame)
                    break
                end
                prdCheckIsVisible[xButton.frame]=false
            end
        end
        for _,xButton in pairs(HealBot_Private_Button) do
            if prdCheckIsVisible[xButton.frame] and xButton.status.current<HealBot_Unit_Status["DC"] then
                if not HealBot_Action_FrameIsVisible(xButton.frame) then
                    HealBot_Action_ShowPanel(xButton.frame)
                    break
                end
                prdCheckIsVisible[xButton.frame]=false
            end
        end
        for _,xButton in pairs(HealBot_Pet_Button) do
            if prdCheckIsVisible[xButton.frame] and xButton.status.current<HealBot_Unit_Status["DC"] then
                if not HealBot_Action_FrameIsVisible(xButton.frame) then
                    HealBot_Action_ShowPanel(xButton.frame)
                    break
                end
                prdCheckIsVisible[xButton.frame]=false
            end
        end
        for _,xButton in pairs(HealBot_Vehicle_Button) do
            if prdCheckIsVisible[xButton.frame] and xButton.status.current<HealBot_Unit_Status["DC"] then
                if not HealBot_Action_FrameIsVisible(xButton.frame) then
                    HealBot_Action_ShowPanel(xButton.frame)
                    break
                end
                prdCheckIsVisible[xButton.frame]=false
            end
        end
        for _,xButton in pairs(HealBot_Extra_Button) do
            if prdCheckIsVisible[xButton.frame] and xButton.status.current<HealBot_Unit_Status["DC"] then
                if not HealBot_Action_FrameIsVisible(xButton.frame) then
                    HealBot_Action_ShowPanel(xButton.frame)
                    break
                end
                prdCheckIsVisible[xButton.frame]=false
            end
        end
    end
    HealBot_HealthAlertLevel(true)
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["STATE"] then
        if Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["FOCUSINCOMBAT"]==1 then
            HealBot_Action_HidePanel(9)
        elseif not HealBot_Action_FrameIsVisible(9) and Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["FOCUSINCOMBAT"]==3 then
            HealBot_RecalcParty(4)
        end
    elseif HealBot_Action_FrameIsVisible(9) then
        HealBot_Action_HidePanel(9)
    end
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][9]["STATE"] then
        if Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TARGETINCOMBAT"]==1 then
            HealBot_Action_HidePanel(8)
        elseif not HealBot_Action_FrameIsVisible(8) and Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TARGETINCOMBAT"]==3 then
            HealBot_RecalcParty(3)
        end
    elseif HealBot_Action_FrameIsVisible(8) then
        HealBot_Action_HidePanel(8)
    end
    if HealBot_Globals.DisableToolTipInCombat and HealBot_Data["TIPBUTTON"] then
        HealBot_Action_HideTooltipFrame()
    end
    HealBot_Aura_SetAuraCheckFlags()

    if not HealBot_luVars["hlPlayerBarsIC"] and HealBot_luVars["HighlightTarget"] then
        HealBot_OnEvent_PlayerTargetChanged()
    end
    if not Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["LOWMANACOMBAT"] then HealBot_ClearLowMana() end
    HealBot_Action_ResetUnitStatus(true)
    if HealBot_luVars["rcEnd"] then
        HealBot_luVars["rcEnd"]=nil
        HealBot_OnEvent_ReadyCheckClear(true)
    end
    --HealBot_Options_RaidTargetUpdate()
      --HealBot_setCall("HealBot_OnEvent_PlayerRegenDisabled")
end

function HealBot_PlayerCheck()
    local CheckedFlags=false
    if not HealBot_luVars["isResting"] and IsResting() then
        CheckedFlags=true
        HealBot_luVars["isResting"]=true
        HealBot_Aura_SetAuraCheckFlags()
    elseif HealBot_luVars["isResting"] and not IsResting() then
        CheckedFlags=true
        HealBot_luVars["isResting"]=false
        HealBot_Aura_SetAuraCheckFlags()
    end
    if not HealBot_luVars["onTaxi"] and UnitOnTaxi("player") then
        HealBot_luVars["onTaxi"]=true
        HealBot_AuraCheck()
    elseif HealBot_luVars["onTaxi"] and not UnitOnTaxi("player") then
        HealBot_luVars["onTaxi"]=false
        if not CheckedFlags then HealBot_Aura_SetAuraCheckFlags() end
        HealBot_AuraCheck()
    end
end

function HealBot_AuraCheck(unit)
    if unit then
        xButton = HealBot_Unit_Button[unit] or HealBot_Pet_Button[unit] or HealBot_Vehicle_Button[unit]
        if xButton then
            xButton.aura.check=true
        end
        xButton = HealBot_Private_Button[unit]
        if xButton then
            xButton.aura.check=true
        end
        xButton = HealBot_Extra_Button[unit]
        if xButton then
            xButton.aura.check=true
        end
    else
        for _,xButton in pairs(HealBot_Unit_Button) do
            xButton.aura.check=true
        end
        for _,xButton in pairs(HealBot_Private_Button) do
            xButton.aura.check=true
        end
        for _,xButton in pairs(HealBot_Pet_Button) do
            xButton.aura.check=true
        end
        for _,xButton in pairs(HealBot_Vehicle_Button) do
            xButton.aura.check=true
        end
        for _,xButton in pairs(HealBot_Extra_Button) do
            xButton.aura.check=true
        end
    end
        --HealBot_setCall("HealBot_AuraCheck")
end

function HealBot_CheckAllActiveDebuffs()
    for _,xButton in pairs(HealBot_Unit_Button) do
        if xButton.aura.debuff.type then
            xButton.aura.check=true
        end
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        if xButton.aura.debuff.type then
            xButton.aura.check=true
        end
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        if xButton.aura.debuff.type then
            xButton.aura.check=true
        end
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        if xButton.aura.debuff.type then
            xButton.aura.check=true
        end
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        if xButton.aura.debuff.type then
            xButton.aura.check=true
        end
    end
    HealBot_fastUpdateEveryFrame(1)
        --HealBot_setCall("HealBot_CheckAllActiveDebuffs")
end

function HealBot_CheckAllActiveBuffs()
    for _,xButton in pairs(HealBot_Unit_Button) do
        if xButton.aura.buff.name then
            xButton.aura.check=true
        end
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        if xButton.aura.buff.name then
            xButton.aura.check=true
        end
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        if xButton.aura.buff.name then
            xButton.aura.check=true
        end
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        if xButton.aura.buff.name then
            xButton.aura.check=true
        end
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        if xButton.aura.buff.name then
            xButton.aura.check=true
        end
    end
    HealBot_fastUpdateEveryFrame(1)
        --HealBot_setCall("HealBot_CheckAllActiveBuffs")
end

function HealBot_UnitAuraAlpha(button)
    HealBot_Aura_Update_AllIcons(button,TimeNow)
      --HealBot_setCall("HealBot_UnitAuraAlpha")
end

function HealBot_UpdateAllIconsAlpha()
    if not HealBot_luVars["TestBarsOn"] then
        for _,xButton in pairs(HealBot_Unit_Button) do
            HealBot_UnitAuraAlpha(xButton)
        end
        for _,xButton in pairs(HealBot_Private_Button) do
            HealBot_UnitAuraAlpha(xButton)
        end
        for _,xButton in pairs(HealBot_Pet_Button) do
            HealBot_UnitAuraAlpha(xButton)
        end
        for _,xButton in pairs(HealBot_Vehicle_Button) do
            HealBot_UnitAuraAlpha(xButton)
        end
        for _,xButton in pairs(HealBot_Extra_Button) do
            HealBot_UnitAuraAlpha(xButton)
        end
    end
end

local guName, guGUID=false, 0
function HealBot_GetUnitName(unit, hbGUID)
    guName=HEALBOT_WORDS_UNKNOWN
    if unit and UnitExists(unit) then
        guGUID=hbGUID or UnitGUID(unit)
        guName=HealBot_customTempUserName[guGUID] or UnitName(unit) or unit
    end
      --HealBot_setCall("HealBot_GetUnitName")
    return guName
end

function HealBot_SetUnitName(name, hbGUID)
    HealBot_customTempUserName[hbGUID]=name
    HealBot_SetResetFlag("SOFT")
end

function HealBot_DelUnitName(hbGUID)
    HealBot_customTempUserName[hbGUID]=nil
    HealBot_SetResetFlag("SOFT")
end

local upUnit=false
function HealBot_UnitPet(unit)
    upUnit=false
    if unit=="player" then
        upUnit="pet"
    elseif strsub(unit,1,4)=="raid" then
        upUnit="raidpet"..strsub(unit,5)
    elseif strsub(unit,1,5)=="party" then
        upUnit="partypet"..strsub(unit,6)
    end
      --HealBot_setCall("HealBot_UnitPet")
    return upUnit
end

function HealBot_OnEvent_PartyMembersChanged(self)
    if HealBot_Data["UILOCK"] then 
        HealBot_setOptions_Timer(9950)
    end
    HealBot_setOptions_Timer(190)
    HealBot_nextRecalcParty(6)
      --HealBot_setCall("HealBot_OnEvent_PartyMembersChanged")
end

function HealBot_retHighlightTarget()
      --HealBot_setCall("HealBot_retHighlightTarget")
    return HealBot_luVars["HighlightTarget"] or "nil"
end

function HealBot_retHbFocus(unit)
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
      --HealBot_setCall("HealBot_retHbFocus")
    return false
end

function HealBot_OnEvent_ReadyCheckDoUpdate(button,response)
    if HealBot_luVars["rcEnd"] and button and Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWRC"] then 
        if response then
            HealBot_Aura_RCUpdate(button, READY_CHECK_READY_TEXTURE)
        else
            HealBot_Aura_RCUpdate(button, READY_CHECK_NOT_READY_TEXTURE)
        end
    end
end

function HealBot_OnEvent_ReadyCheckUpdate(unit,response)
    if HealBot_Unit_Button[unit] then HealBot_OnEvent_ReadyCheckDoUpdate(HealBot_Unit_Button[unit],response) end
    if HealBot_Private_Button[unit] then HealBot_OnEvent_ReadyCheckDoUpdate(HealBot_Private_Button[unit],response) end
      --HealBot_setCall("HealBot_OnEvent_ReadyCheckUpdate")
end

function HealBot_OnEvent_ReadyCheck(self,unitName,timer)
    if HealBot_UnitNameOnly(unitName) then
        local lUnit=HealBot_Panel_RaidUnitName(HealBot_UnitNameOnly(unitName))
        HealBot_luVars["rcEnd"]=TimeNow+timer
        for _,xButton in pairs(HealBot_Unit_Button) do
            if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][xButton.frame]["SHOWRC"] then 
                HealBot_Aura_RCUpdate(xButton, READY_CHECK_WAITING_TEXTURE)
            end
        end
        for _,xButton in pairs(HealBot_Private_Button) do
            if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][xButton.frame]["SHOWRC"] then 
                HealBot_Aura_RCUpdate(xButton, READY_CHECK_WAITING_TEXTURE)
            end
        end
        if lUnit and (HealBot_Unit_Button[lUnit] or HealBot_Private_Button[lUnit]) then HealBot_OnEvent_ReadyCheckUpdate(lUnit,true) end
    end
      --HealBot_setCall("HealBot_OnEvent_ReadyCheck")
end

function HealBot_OnEvent_ReadyCheckConfirmed(self,unit,response)
    xUnit = HealBot_UnitID(unit)
    if HealBot_Unit_Button[xUnit] or HealBot_Private_Button[xUnit] then HealBot_OnEvent_ReadyCheckUpdate(xUnit,response) end
      --HealBot_setCall("HealBot_OnEvent_ReadyCheckConfirmed")
end

function HealBot_RaidTargetToggle(switch)
    if switch then
        HealBot:RegisterEvent("RAID_TARGET_UPDATE")
        HealBot_OnEvent_RaidTargetUpdateAll()
    else
        HealBot:UnregisterEvent("RAID_TARGET_UPDATE")
        for _,xButton in pairs(HealBot_Unit_Button) do
            if xButton.icon.extra.targeticon>0 then
                HealBot_Aura_RaidTargetUpdate(xButton,0)
            end
        end
        for _,xButton in pairs(HealBot_Private_Button) do
            if xButton.icon.extra.targeticon>0 then
                HealBot_Aura_RaidTargetUpdate(xButton,0)
            end
        end
        for _,xButton in pairs(HealBot_Extra_Button) do
            if xButton.icon.extra.targeticon>0 then
                HealBot_Aura_RaidTargetUpdate(xButton,0)
            end
        end
        for _,xButton in pairs(HealBot_Enemy_Button) do
            if xButton.icon.extra.targeticon>0 then
                HealBot_Aura_RaidTargetUpdate(xButton,0)
            end
        end
        for _,xButton in pairs(HealBot_Pet_Button) do
            if xButton.icon.extra.targeticon>0 then
                HealBot_Aura_RaidTargetUpdate(xButton,0)
            end
        end
        for _,xButton in pairs(HealBot_Vehicle_Button) do
            if xButton.icon.extra.targeticon>0 then
                HealBot_Aura_RaidTargetUpdate(xButton,0)
            end
        end
    end
      --HealBot_setCall("HealBot_RaidTargetToggle")
end

function HealBot_FocusChanged()
    if UnitExists("focus") then
        C_Timer.After(0.05, function() HealBot_nextRecalcParty(4) end)
    else
        HealBot_nextRecalcParty(4)
    end
end

function HealBot_OnEvent_FocusChanged(self)
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["STATE"] then
        local xButton=HealBot_Extra_Button["focus"]
        if xButton then
            if HealBot_luVars["FocusNeedReset"] then
                HealBot_FocusChanged()
            elseif not HealBot_Data["UILOCK"] then
                if HealBot_Panel_validFocus() then
                    HealBot_Action_ShowHideFrames(xButton)
                elseif HealBot_Action_FrameIsVisible(9) then 
                    HealBot_Action_HidePanel(9)
                end
            end
            xButton.status.update=true
            xButton.status.change=true
        else
            HealBot_FocusChanged()
        end
    elseif HealBot_Action_FrameIsVisible(9) then
        HealBot_FocusChanged()
    end
      --HealBot_setCall("HealBot_OnEvent_FocusChanged")
end

function HealBot_Player_TalentsChanged()
    _,xButton,pButton = HealBot_UnitID("player")
    if xButton then xButton.spec = " " end
    if pButton then pButton.spec = " " end
    HealBot_setOptions_Timer(200)
      --HealBot_setCall("HealBot_OnEvent_TalentsChanged")
end

function HealBot_OnEvent_SpellsChanged(self, arg1)
    if arg1==0 then return; end
    if UnitIsDeadOrGhost("player") then return end
    HealBot_setOptions_Timer(5)
      --HealBot_setCall("HealBot_OnEvent_SpellsChanged")
end

function HealBot_stopTimers()
    HealBot_luVars["runTimers"]=false
end

function HealBot_startTimers()
    HealBot_luVars["runTimers"]=true
    HealBot_luVars["ProcessRefresh"]=false
    HealBot_luVars["invCheck"]=false
    HealBot_Text_setLuVars("FluidTextAlphaInUse", false)
    HealBot_Aux_setLuVars("AuxFluidBarAlphaInUse", false)
    HealBot_Aux_setLuVars("AuxCastBarInUse", false)
    HealBot_Aux_setLuVars("AuxFluidBarInUse", false)
    HealBot_Aux_setLuVars("AuxFlashBarsInUse", false)
    HealBot_Action_setLuVars("DeleteMarkedButtonsActive", false)
    HealBot_Action_setLuVars("FluidBarAlphaInUse", false)
    HealBot_Action_setLuVars("FluidBarInUse", false)
    HealBot_Update_FastTimer()
    HealBot_setOptions_Timer(9992)
end

function HealBot_OnEvent_PlayerEnteringWorld()
    HealBot_startTimers()
    HealBot_luVars["DropCombat"]=true
    if HealBot_Action_FrameIsVisible(8) then
        HealBot_PlayerTargetChanged()
    end
    if HealBot_Action_FrameIsVisible(9) then
        HealBot_FocusChanged()
    end
    if HealBot_Action_FrameIsVisible(7) then
        HealBot_nextRecalcParty(2)
    end
    if HealBot_Action_FrameIsVisible(6) then
        HealBot_nextRecalcParty(1)
    end
    HealBot_setOptions_Timer(8888)
    HealBot_setOptions_Timer(190)
    --HealBot_SetResetFlag("QUICK") 
    --if HealBot_luVars["Loaded"] then HealBot_Register_Events() end
    HealBot_luVars["qaFRNext"]=TimeNow+5
    
    HealBot_setOptions_Timer(200)
    --HealBot_Load("PlayerEnteringWorld")
      --HealBot_setCall("HealBot_OnEvent_PlayerEnteringWorld")
end

function HealBot_OnEvent_PlayerLeavingWorld(self)
    HealBot_stopTimers()
    HealBot_luVars["qaFRNext"]=TimeNow+90
    if HealBot_Config.Profile==2 then
        HealBot_Options_hbProfile_saveClass()
    end
    HealBot_setOptions_Timer(9951)
    --HealBot_UnRegister_Events();
      --HealBot_setCall("HealBot_OnEvent_PlayerLeavingWorld")
end

HealBot_luVars["massRes"]=false
HealBot_luVars["massResTime"]=0
HealBot_luVars["massResUnit"]="-nil"
HealBot_luVars["massResAltTime"]=0
HealBot_luVars["massResAltUnit"]="-nil"

function HealBot_UpdateMassRes()
    if HealBot_luVars["massResTime"]>TimeNow or HealBot_luVars["massResAltTime"]>TimeNow then
        HealBot_luVars["massRes"]=true
    else
        HealBot_luVars["massRes"]=false
    end
end

function HealBot_DoUnitSummonsUpdate(button, state)
    if button.status.current==HealBot_Unit_Status["SUMMONED"] then
        if not state then
            button.status.current=HealBot_Unit_Status["CHECK"]
            HealBot_SummonsTracker[button.guid]=nil
            button.text.nameupdate=true
            HealBot_Text_UpdateText(button)
        end
    elseif button.status.current<HealBot_Unit_Status["SUMMONED"] and state then
        --button.status.current=HealBot_Unit_Status["SUMMONED"]
        --button.text.nameupdate=true
        --HealBot_Action_Refresh(button)
        --HealBot_Text_UpdateText(button)
    end
end

function HealBot_UnitSummonsUpdate(guid, state)
    _,xButton,pButton = HealBot_UnitID(xUnit, true)
    if xButton then HealBot_DoUnitSummonsUpdate(xButton, state) end
    if pButton then HealBot_DoUnitSummonsUpdate(pButton, state) end
end

function HealBot_OnEvent_IncomingSummons(unit)
    xGUID=UnitGUID(unit)
    if HealBot_Panel_RaidUnitGUID(xGUID) then
        if C_IncomingSummon.IncomingSummonStatus(unit)==1 then
            HealBot_UnitSummonsUpdate(xGUID, true)
        else
            HealBot_UnitSummonsUpdate(xGUID, false)
        end
    end
end

function HealBot_SummonsPending(guid)
    if HealBot_SummonsTracker[guid] then
        for cUnit,eTime in pairs(HealBot_SummonsTracker[guid]) do
            if eTime>TimeNow then
                return true
            end
        end
    end
    return false
end

local scName, scStartTime, scEndTime="",0,0
function HealBot_OnEvent_UnitSpellCastStart(button, unitTarget, castGUID, spellID)
    if HEALBOT_GAME_VERSION>1 and HealBot_AuxAssigns["CastBar"][button.frame] and button.status.unittype~=11 then
        scName, _, _, scStartTime, scEndTime = UnitCastingInfo(button.unit) 
        if scEndTime then
            button.status.castend=scEndTime
            HealBot_Aux_UpdateCastBar(button, scName, scStartTime, scEndTime, false)
        end
    end
    scName=GetSpellInfo(spellID) or spellID or "x"
    if HealBot_ResSpells[scName] then
        --HealBot_AddDebug("CastStart res "..scName, "Spell Cast", true)
        if HealBot_ResSpells[scName]==2 then
            if HealBot_luVars["massResTime"]<TimeNow then
                HealBot_luVars["massResUnit"]=button.unit
                HealBot_luVars["massResTime"]=TimeNow+10
                HealBot_UpdateMassRes()
            elseif HealBot_luVars["massResAltTime"]<TimeNow and HealBot_luVars["massResUnit"]~=button.unit then
                HealBot_luVars["massResAltUnit"]=button.unit
                HealBot_luVars["massResAltTime"]=TimeNow+10
                HealBot_UpdateMassRes()
            end
        end
    end
end

function HealBot_OnEvent_UnitSpellChanStart(button, unitTarget, castGUID, spellID)
    if HEALBOT_GAME_VERSION>1 and HealBot_AuxAssigns["CastBar"][button.frame] and button.status.unittype~=11 then
        scName, _, _, scStartTime, scEndTime = UnitChannelInfo(button.unit) 
        if scEndTime then
            button.status.castend=scEndTime
            HealBot_Aux_UpdateCastBar(button, scName, scStartTime, scEndTime, true)
        end
    end

    scName=GetSpellInfo(spellID) or spellID
    if scName==GetSpellInfo(698) then
        if UnitIsUnit(button.unit, unitTarget) then unitTarget=button.unit.."target" end
        if UnitExists(unitTarget) then
            xGUID=UnitGUID(unitTarget)
            if HealBot_Panel_RaidUnitGUID(xGUID) then
                if not HealBot_SummonsTracker[xGUID] then HealBot_SummonsTracker[xGUID]={} end               
                HealBot_SummonsTracker[xGUID][button.guid]=TimeNow+120
                HealBot_UnitSummonsUpdate(xGUID, true)
                HealBot_SummonsCaster[button.guid]=xGUID
            end
        end
    HealBot_AddDebug("ChanStart summons "..scName, "Spell Cast", true)
    HealBot_AddDebug(" - Start Caster="..UnitName(button.unit).."  Target="..UnitName(unitTarget) or "-nil", "Spell Cast", true)
    end
end

function HealBot_OnEvent_UnitSpellCastStop(button, unitTarget, castGUID, spellID)
    if castGUID==HealBot_luVars["overhealCastID"] then
        _,eButton,ePrivate = HealBot_UnitID(HealBot_luVars["overhealUnit"], true)
        HealBot_luVars["overhealUnit"]="-nil-"
        HealBot_luVars["overhealCastID"]="-nil-"
        if eButton and eButton.health.overheal>0 then
            eButton.health.overheal=0
            HealBot_Aux_ClearOverHealBar(eButton)
            HealBot_Text_setOverHealText(eButton)
        end
        if ePrivate and ePrivate.health.overheal>0 then
            ePrivate.health.overheal=0
            HealBot_Aux_ClearOverHealBar(ePrivate)
            HealBot_Text_setOverHealText(ePrivate)
        end
        HealBot_luVars["overhealAmount"]=0
    end
    if button.status.unittype~=11 and button.status.castend>0 then
        HealBot_Aux_ClearCastBar(button)
    end

    if HealBot_luVars["massResUnit"]==button.unit then HealBot_luVars["massResUnit"]="-nil" end
    if HealBot_luVars["massResAltUnit"]==button.unit then HealBot_luVars["massResAltUnit"]="-nil" end
    if HealBot_SummonsCaster[button.guid] then HealBot_SummonsCaster[button.guid]=nil end
end

function HealBot_OnEvent_UnitSpellCastComplete(button, unitTarget, castGUID, spellID)
    -- Only registered for the Player!
    --if UnitIsUnit(button.unit,"player") then
        if (HealBot_Config_Cures.IgnoreOnCooldownDebuffs and HealBot_Options_retIsDebuffSpell(spellID)) then
            HealBot_luVars["MaskAuraCheckDebuff"]=TimeNow
        elseif HealBot_Aura_IsBuffSpell(spellID) then  
            HealBot_luVars["MaskAuraCheckBuff"]=TimeNow
        end
    --end
end

function HealBot_OnEvent_UnitSpellCastFailed(button, unitTarget, castGUID, spellID)
    if HealBot_luVars["massResUnit"]==button.unit then
        HealBot_luVars["massResTime"]=0
        HealBot_luVars["massResUnit"]="-nil"
        HealBot_UpdateMassRes()
    elseif HealBot_luVars["massResAltUnit"]==button.unit then
        HealBot_luVars["massResAltTime"]=0
        HealBot_luVars["massResAltUnit"]="-nil"
        HealBot_UpdateMassRes()
    end
    if HealBot_SummonsCaster[button.guid] then
        if HealBot_SummonsTracker[HealBot_SummonsCaster[button.guid]] and HealBot_SummonsTracker[HealBot_SummonsCaster[button.guid]][button.guid] then
            HealBot_SummonsTracker[HealBot_SummonsCaster[button.guid]][button.guid]=0
        end
        HealBot_SummonsCaster[button.guid]=nil
    end
end

function HealBot_MassRes()
    return HealBot_luVars["massRes"]
end

local uscUnit, uscUnitName, uscSpellName=nil,false,false
function HealBot_OnEvent_UnitSpellCastSent(self,caster,unitName,castGUID,spellID)
    if caster=="player" then
        uscUnit=nil
        uscUnitName = HealBot_UnitNameOnly(unitName)
        uscSpellName = GetSpellInfo(spellID) or spellID
        
        if uscUnitName == HEALBOT_WORDS_UNKNOWN then
            uscUnitName = HealBot_GetCorpseName(uscUnitName)
        end
        
        if uscUnitName=="" then
            if spellID==HEALBOT_MENDPET and UnitExists("pet") then
                uscUnitName=HealBot_GetUnitName("pet")
                uscUnit="pet"
            end
        else
            uscUnit=HealBot_Panel_RaidUnitName(uscUnitName)
            if uscUnit and not UnitExists(uscUnit) then uscUnit=nil end
        end

        if uscUnit and uscUnitName then
            _,xButton,pButton=HealBot_UnitID(uscUnit)
            if (xButton and Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][xButton.frame]["OVERHEAL"]==2) or
               (pButton and Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][pButton.frame]["OVERHEAL"]==2) then
                HealBot_luVars["overhealUnit"]=uscUnit
                HealBot_luVars["overhealCastID"]=castGUID
                HealBot_luVars["overhealAmount"]=0
            end
        end
        if HealBot_luVars["ChatNOTIFY"]>1 then
            if HealBot_luVars["ChatRESONLY"] then
                if HealBot_ResSpells[uscSpellName] then
                    if HealBot_ResSpells[uscSpellName]==2 then           
                        HealBot_CastNotify(HEALBOT_OPTIONS_GROUPHEALS,uscSpellName,(uscUnit or ""))
                    elseif uscUnit and uscUnitName then
                        HealBot_CastNotify(uscUnitName,uscSpellName,uscUnit)
                    end
                end
            elseif HealBot_Spell_Names[uscSpellName] and uscUnit and uscUnitName then
                HealBot_CastNotify(uscUnitName,uscSpellName,uscUnit)
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
    local z = HealBot_luVars["ChatNOTIFY"];
    local s = gsub(HealBot_luVars["ChatMSG"],"#s",spell)
    s = gsub(s,"#l",GetSpellLink(spell, ""))
    s = gsub(s,"#n",unitName)
    local w=nil;
    if z==5 and not IsInRaid() then z = 4 end
    if z==4 and GetNumGroupMembers()==0 then z = 2 end
    if z==3 and UnitIsPlayer(unit) and UnitPlayerControlled(unit) and unit~="player" then
        s = gsub(s,unitName,HEALBOT_WORDS_YOU)
        SendChatMessage(s,"WHISPER",nil,unitName);
    elseif z==4 then
        local inInst=IsInInstance()
        if inInst and IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
            SendChatMessage(s,"INSTANCE_CHAT",nil,nil);
        else
            SendChatMessage(s,"PARTY",nil,nil);
        end
    elseif z==5 then
        local inInst=IsInInstance()
        if inInst and IsInRaid(LE_PARTY_CATEGORY_INSTANCE) then
            SendChatMessage(s,"INSTANCE_CHAT",nil,nil);
        else
            SendChatMessage(s,"RAID",nil,nil);
        end
    else
        HealBot_AddChat(s);
    end
      --HealBot_setCall("HealBot_CastNotify")
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
    HealBot_Init_Spells_Defaults();
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

if HealBot_Version_Target() and LDB11 then
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
                HealBot_TogglePanel(HealBot_Options, true)
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
            HealBot_TogglePanel(HealBot_Options, true)
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

function HealBot_ResetRange()
    for _,xButton in pairs(HealBot_Unit_Button) do
        xButton.status.range=-3
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        xButton.status.range=-3
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        xButton.status.range=-3
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        xButton.status.range=-3
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        xButton.status.range=-3
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        xButton.status.range=-3
    end
end

local oldRange=-99
function HealBot_UpdateUnitRange(button, doRefresh) 
    if UnitIsUnit("player",button.unit) then
        button.status.range=1
    elseif button.status.current<HealBot_Unit_Status["DC"] then
        oldRange=button.status.range
        button.status.range=HealBot_UnitInRange(button.unit, button.status.rangespell)
        if oldRange~=button.status.range then
            if HealBot_Action_IsUnitDead(button) then
                button.text.nameupdate=true
                HealBot_Text_UpdateText(button)
            else
                HealBot_Text_setNameTag(button)
            end
            if button.status.range<1 then
                button.health.updincoming=true
                button.health.updabsorbs=true
            end
            if button.status.enabled then  
                if button.status.range==1 then
                    button.status.alpha=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"], 1)
                else
                    button.status.alpha=HealBot_Action_BarColourAlpha(button, Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["ORA"], 1)
                end
                HealBot_Action_stateChange(button)
                HealBot_Action_UpdateHealthStatusBarColor(button)
            end
            if doRefresh then
                button.status.refresh=true
                button.aura.check=true
                if button.status.dirarrowshown>0 or button.status.range==0 then
                    HealBot_Action_ShowDirectionArrow(button, TimeNow)
                end
                if HealBot_Emerg_Button[button.id].state>0 then
                    HealBot_Action_EmergBarCheck(button, true)
                end
            --elseif button.status.current>HealBot_Unit_Status["DISABLED"] then
            --    button.status.refresh=true
            end
            if HealBot_AuxAssigns["OORBar"][button.frame] then
                if button.status.range==1 then
                    HealBot_Aux_ClearOORBar(button)
                else
                    HealBot_Aux_UpdateOORBar(button)
                end
            end
            if Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][button.frame]["OORLAST"] and (oldRange==1 or button.status.range==1) then
                if button.status.unittype<7 then 
                    HealBot_nextRecalcParty(6)
                elseif button.status.unittype<9 then
                    HealBot_nextRecalcParty(2)
                end
            end
        end
    else
        button.status.range=-3
    end
        --HealBot_setCall("HealBot_UpdateUnitRange")
end

local uRange=0
function HealBot_UnitInRange(unit, spellName) -- added by Diacono of Ursin
    uRange=0
    if not HealBot_UnitInPhase(unit) then 
        uRange = -2
    elseif not UnitIsVisible(unit) then 
        uRange = -1
    elseif CheckInteractDistance(unit, 4) then
        uRange = 1
    elseif IsSpellInRange(spellName, unit) then
        uRange = IsSpellInRange(spellName, unit)
    elseif IsItemInRange(spellName, unit) then
        uRange = IsItemInRange(spellName, unit)
    elseif UnitInRange(unit) then
        uRange = 1
    else
        uRange = 0
    end
    --HealBot_setCall("HealBot_UnitInRange")
    return uRange
end

local hbPi = math.pi
local hbaTan2 = math.atan2
local hbdMod = 108 / math.pi / 2;
local dcDirection, dcX, dcY = false,false,false
local dcPlayerX, dcPlayerY, dcPlayerFacing=false, false
local dcUnitX, dcUnitY=false,false
function HealBot_Direction_Check(unit) 
    dcDirection, dcX, dcY = false,false,false
    dcPlayerX, dcPlayerY = HealBot_getUnitCoords("player")
    if dcPlayerX then
        dcUnitX, dcUnitY = HealBot_getUnitCoords(unit)
        if dcUnitX then
            dcPlayerFacing = GetPlayerFacing();
            if dcPlayerFacing then
                dcPlayerFacing = dcPlayerFacing < 0 and dcPlayerFacing + hbPi * 2 or dcPlayerFacing;
                dcDirection = hbPi - hbaTan2(dcPlayerX - dcUnitX, dcUnitY - dcPlayerY) - dcPlayerFacing;
                dcDirection = floor(dcDirection * hbdMod + 0.5) % 108
                dcX, dcY = (dcDirection % 9) * 0.109375, floor(dcDirection / 9) * 0.08203125;
            end
        end
    end
      --HealBot_setCall("HealBot_Direction_Check")
    return dcX, dcY, dcDirection;
end

local gucUIMapID, gucPos=false,false
function HealBot_getUnitCoords(unit)
      --HealBot_setCall("HealBot_getUnitCoords")
    if UnitIsPlayer(unit) then
        gucUIMapID=C_Map.GetBestMapForUnit(unit)
        if gucUIMapID then
            gucPos=C_Map.GetPlayerMapPosition(gucUIMapID, unit)
            if gucPos and gucPos.x and gucPos.y and gucPos.x > 0 and gucPos.y > 0 then
                return gucPos.x, gucPos.y
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

function HealBot_NewVersionMessage(msgType)
    local msg=""
    if msgType==1 then
        msg="HealBot\n----------\n\nIf not preparing for this version\nyour settings will be at defaults\n\nTo restore settings, visit the forum on\n"..HEALBOT_ABOUT_URL.."\n"
    end
    StaticPopupDialogs["HEALBOT_NEWVERSIONMSG"] = {
        text = msg,
        button1 = HEALBOT_WORDS_OK,
        timeout = 0,
        whileDead = 1,
        hideOnEscape = 1
    };

    StaticPopup_Show ("HEALBOT_NEWVERSIONMSG");
      --HealBot_setCall("HealBot_NewVersionMessage")
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
    for x=1,2 do
        if x==1 then
            combo = HealBot_Config_Spells.EnabledKeyCombo;
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
    HealBot_setOptions_Timer(15)
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
    HealBot_Update_BuffsForSpec("Buff")
    HealBot_Options_ResetDoInittab(5)
    HealBot_Options_Init(5)
    HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_CONFIRMBUFFSRESET)
    HealBot_setOptions_Timer(11)
      --HealBot_setCall("HealBot_Reset_Buffs")
end

function HealBot_Reset_Cures()
    HealBot_DoReset_Cures(HealBot_Data["PCLASSTRIM"])
    HealBot_Config_Cures.SoundDebuffWarning=HealBot_Config_CuresDefaults.SoundDebuffWarning
    HealBot_Config_Cures.DebuffWatch=HealBot_Config_CuresDefaults.DebuffWatch
    HealBot_Config_Cures.IgnoreFastDurDebuffs=HealBot_Config_CuresDefaults.IgnoreFastDurDebuffs
    HealBot_Config_Cures.IgnoreFastDurDebuffsSecs=HealBot_Config_CuresDefaults.IgnoreFastDurDebuffsSecs
    HealBot_Config_Cures.IgnoreOnCooldownDebuffs=HealBot_Config_CuresDefaults.IgnoreOnCooldownDebuffs
    HealBot_Config_Cures.SoundDebuffPlay=HealBot_Config_CuresDefaults.SoundDebuffPlay
    HealBot_Config_Cures.DebuffWatchInCombat=HealBot_Config_CuresDefaults.DebuffWatchInCombat
    HealBot_Config_Cures.DebuffWatchWhenGrouped=HealBot_Config_CuresDefaults.DebuffWatchWhenGrouped
    HealBot_Config_Cures.ShowDebuffWarning=HealBot_Config_CuresDefaults.ShowDebuffWarning
    HealBot_Config_Cures.CDCshownHB=HealBot_Config_CuresDefaults.CDCshownHB
    HealBot_Update_BuffsForSpec("Debuff")
    HealBot_Options_ResetDoInittab(4)
    HealBot_Options_Init(4)
    HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_CONFIRMCURESRESET)
    HealBot_setOptions_Timer(12)
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
    HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_CONFIRMICONRESET)
      --HealBot_setCall("HealBot_Reset_Icons")
end

function HealBot_IsItemInBag(itemID)
      --HealBot_setCall("HealBot_IsItemInBag")
    if itemID then
        return HealBot_ItemsInBags[itemID]
    else
        return false
    end
end

function HealBot_runDefaults()
    HealBot_InitNewChar()
    HealBot_Update_BuffsForSpec()
    HealBot_Update_SpellCombos()
    HealBot_Aura_ClearAllBuffs()
    HealBot_Aura_ClearAllDebuffs()
      --HealBot_setCall("HealBot_runDefaults")
end

local castName, castStartTime, castEndTime = "",0,0
function HealBot_libCC_PlayerCastStart(button)
    castName, _, _, castStartTime, castEndTime = libCC:UnitCastingInfo(button.unit)
    if castEndTime then
        button.status.castend=castEndTime
        HealBot_Aux_UpdateCastBar(button, castName, castStartTime, castEndTime, false)
    else
        castName, _, _, castStartTime, castEndTime = libCC:UnitChannelInfo(button.unit)
        if castEndTime then
            button.status.castend=castEndTime
            HealBot_Aux_UpdateCastBar(button, castName, castStartTime, castEndTime, true)
        end
    end
end

function HealBot_libCC_EnemyCastStart(guid, chan)
    if not hbClassicEnemyCasts[guid] or not hbClassicEnemyCasts[guid].current then
        castName=string.gsub(castName,":","")
        if chan then
            addonMsg="V:"..guid.."~T~T~"..castName.."~"..(TimeNow*1000)-castStartTime.."~"..castEndTime-castStartTime
        else
            addonMsg="V:"..guid.."~T~F~"..castName.."~"..(TimeNow*1000)-castStartTime.."~"..castEndTime-castStartTime
        end
        HealBot_Comms_SendInstantAddonMsg(HEALBOT_HEALBOT, addonMsg)
    end
    HealBot_ClassicEnemyCasts(guid, true, chan, castName, castStartTime, castEndTime)
end

function HealBot_libCC_CastStart(self, unit, event, ...)
    if unit and UnitIsEnemy("player", unit) then
        castName, _, _, castStartTime, castEndTime = libCC:UnitCastingInfo(unit)
        if castEndTime then
            HealBot_libCC_EnemyCastStart(UnitGUID(unit), false)
        else
            castName, _, _, castStartTime, castEndTime = libCC:UnitChannelInfo(unit) 
            if castEndTime then
                HealBot_libCC_EnemyCastStart(UnitGUID(unit), true)
            end
        end
    else
        _,xButton,pButton = HealBot_UnitID(unit, true)
        if xButton and HealBot_AuxAssigns["CastBar"][xButton.frame] then HealBot_libCC_PlayerCastStart(xButton) end
        if pButton and HealBot_AuxAssigns["CastBar"][pButton.frame] then HealBot_libCC_PlayerCastStart(pButton) end
    end
end

function HealBot_libCC_CastStop(self, unit, event, ...)
    if unit then
        local guid=UnitGUID(unit)
        if hbClassicEnemyCasts[guid] and hbClassicEnemyCasts[guid].current then
            addonMsg="V:"..guid.."~F"
            HealBot_Comms_SendInstantAddonMsg(HEALBOT_HEALBOT, addonMsg)
            HealBot_ClassicEnemyCasts(guid, false, nil, nil, nil, nil)
        else
            _,xButton,pButton = HealBot_UnitID(unit, true)
            if xButton and xButton.status.castend>0 then HealBot_Aux_ClearCastBar(xButton) end
            if pButton and pButton.status.castend>0 then HealBot_Aux_ClearCastBar(pButton) end
        end
    end
end

local arg1,arg2,arg3,arg4,eButton,ePrivate = false,false,false,false,false,false
function HealBot_OnEvent(self, event, ...)
    arg1,arg2,arg3,arg4 = ...;
    if (event=="UNIT_SPELLCAST_SENT") then
        HealBot_OnEvent_UnitSpellCastSent(self,arg1,arg2,arg3,arg4);  
    elseif (event=="SPELL_UPDATE_COOLDOWN") then
        if HealBot_Data["TIPBUTTON"] then HealBot_Action_RefreshTooltip() end
    --elseif (event=="COMBAT_LOG_EVENT_UNFILTERED") then
    --    HealBot_OnEvent_Combat_Log(CombatLogGetCurrentEventInfo())
    elseif (event=="PLAYER_REGEN_DISABLED") then
        HealBot_OnEvent_PlayerRegenDisabled();
        HealBot_luVars["UILOCK"]=true
    elseif (event=="PLAYER_REGEN_ENABLED") then
        HealBot_luVars["UILOCK"]=false
    elseif (event=="GROUP_ROSTER_UPDATE") or (event=="RAID_ROSTER_UPDATE") then
        HealBot_OnEvent_PartyMembersChanged(self);
    elseif (event=="RAID_TARGET_UPDATE") then
        HealBot_OnEvent_RaidTargetUpdateAll()
    elseif (event=="PLAYER_TARGET_CHANGED") then
        HealBot_luVars["TargetNeedReset"]=true
        HealBot_OnEvent_PlayerTargetChanged();
    elseif (event=="PLAYER_FOCUS_CHANGED") then
        HealBot_OnEvent_FocusChanged(self);
    elseif (event=="MODIFIER_STATE_CHANGED") then
        if HealBot_Data["TIPBUTTON"] then 
            HealBot_Action_RefreshTooltip()
        elseif HealBot_Data["TIPICON"] then
            HealBot_Tooltip_UpdateIconTooltip()
        end
        if not HealBot_Data["UILOCK"] then HealBot_Action_ModKey() end
    elseif (event=="UNIT_PET") then
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["STATE"] then
            HealBot_nextRecalcParty(2)
        end
    elseif (event=="PLAYER_CONTROL_GAINED") or (event=="PLAYER_CONTROL_LOST") or (event=="PLAYER_UPDATE_RESTING") then
        HealBot_setOptions_Timer(4985)
    elseif (event=="ROLE_CHANGED_INFORM") then
        HealBot_ResetClassIconTexture()
    elseif (event=="INCOMING_SUMMON_CHANGED") then
        HealBot_OnEvent_IncomingSummons(arg1)
    elseif (event=="UNIT_ENTERED_VEHICLE") then
        HealBot_OnEvent_VehicleChange(self, arg1, true)
    elseif (event=="UNIT_EXITED_VEHICLE") then
        HealBot_OnEvent_VehicleChange(self, arg1, nil)
    elseif (event=="UNIT_EXITING_VEHICLE") then
        HealBot_OnEvent_LeavingVehicle(self, arg1)
    elseif (event=="PLAYER_ENTERING_WORLD") then
        HealBot_OnEvent_PlayerEnteringWorld();
    elseif (event=="PLAYER_LEAVING_WORLD") then
        HealBot_OnEvent_PlayerLeavingWorld(self);
    elseif (event=="INSPECT_READY") then
        if HealBot_Panel_RaidUnitGUID(arg1) then
            _,eButton,ePrivate = HealBot_UnitID(HealBot_Panel_RaidUnitGUID(arg1))
            if eButton then
                HealBot_GetTalentInfo(eButton) 
            end
            if ePrivate then
                HealBot_GetTalentInfo(ePrivate) 
            end
        end
    elseif (event=="ZONE_CHANGED_NEW_AREA") or (event=="ZONE_CHANGED")  or (event=="ZONE_CHANGED_INDOORS") then
        if (event=="ZONE_CHANGED_NEW_AREA") then
            HealBot_setOptions_Timer(120)
        end
    elseif (event=="CHAT_MSG_ADDON") then
        HealBot_OnEvent_AddonMsg(self,arg1,arg2,arg3,arg4);
    elseif (event=="BAG_UPDATE") then
        HealBot_OnEvent_InvChange()
    elseif (event=="PET_BATTLE_OPENING_START") or (event=="PET_BATTLE_OVER") then
        HealBot_luVars["lastPetBattleEvent"]=event
        HealBot_setOptions_Timer(190)
    elseif (event=="READY_CHECK") then
        HealBot_OnEvent_ReadyCheck(self,arg1,arg2);
    elseif (event=="READY_CHECK_CONFIRM") then
        HealBot_OnEvent_ReadyCheckConfirmed(self,arg1,arg2);
    elseif (event=="READY_CHECK_FINISHED") then
        HealBot_luVars["rcEnd"]=TimeNow
    elseif (event=="LEARNED_SPELL_IN_TAB") then
        HealBot_OnEvent_SpellsChanged(self,arg1);
        HealBot_setOptions_Timer(405)        
        HealBot_Player_TalentsChanged()
    elseif (event=="PLAYER_TALENT_UPDATE") or (event=="CHARACTER_POINTS_CHANGED") then
        HealBot_Player_TalentsChanged()
    elseif (event=="COMPANION_LEARNED") then
        HealBot_setOptions_Timer(405)
    elseif (event=="VARIABLES_LOADED") then
        HealBot_OnEvent_VariablesLoaded(self);
    elseif (event=="GET_ITEM_INFO_RECEIVED") then
        HealBot_OnEvent_ItemInfoReceived(self);
    else
        HealBot_AddDebug("Missing OnEvent (" .. event .. ")", "Events", false);
    end
end

