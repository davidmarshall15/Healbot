--[[ HealBot Continued ]]

local HealBot_DebugMsg={};
local HealBot_SpamCut={}
local HealBot_Vers={}
local TimeNow=GetTime()+1
--local strfind=strfind
local scName, scStartTime, scEndTime="",0,0
local arrg = {}
local LSM = HealBot_Libs_LSM()
local LDB11 = HealBot_Libs_LDB11()
local LDBIcon = HealBot_Libs_LDBIcon()
local libCHC = HealBot_Libs_CHC()
local HealBot_VehicleUnit={}
local HealBot_UnitInVehicle={}
local HealBot_BuffQueue={}
local HealBot_BuffQueueList={}
local HealBot_DebuffQueue={}
local HealBot_DebuffQueueList={}
local HealBot_RefreshQueue={}
local HealBot_RefreshQueueList={}
local HealBot_SlowUpdateQueue={}
local HealBot_UpdateQueue={}
local HealBot_SpecQueue={}
local HealBot_SpecQueueList={}
local HealBot_notVisible={}
local hbManaPlayers={}
local HealBot_customTempUserName={}
local HealBot_trackHiddenFrames={}
local HealBot_RefreshTypes={[0]=true,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false}
local HealBot_ResSpells={}
local HealBot_MobGUID={}
local HealBot_MobNames={}
local HealBot_CDQueue={}
local HealBot_LastSpellCD={}
local xUnit="x"
local xGUID="x"
local xButton={}
local pButton={}
local HealBot_ItemsInBags={}
local HealBot_AuxAssigns={}
local HealBot_ClearGUIDQueue={}
local hbLTfps={[1]="<10",[2]="<20",[3]="<30",[4]="<40",[5]="<55",[6]="<70",[7]="<85",
               [8]="<100",[9]=">100",[10]=">100",[11]=">100",[12]=">100",[13]=">100",[14]=">100",}
HealBot_AuxAssigns["CastBar"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
HealBot_AuxAssigns["OORBar"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
HealBot_AuxAssigns["Range30Bar"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
HealBot_AuxAssigns["RecentHeals"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
HealBot_AuxAssigns["HealthDrop"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
HealBot_AuxAssigns["NameOverlayRecentHeals"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
HealBot_AuxAssigns["NameOverlayHealthDrop"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
HealBot_AuxAssigns["NameOverlayTarget"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
HealBot_AuxAssigns["NameOverlayOOR"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
HealBot_AuxAssigns["HealthOverlayRecentHeals"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
HealBot_AuxAssigns["HealthOverlayHealthDrop"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
HealBot_AuxAssigns["HealthOverlayTarget"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
HealBot_AuxAssigns["HealthOverlayOOR"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}

local HealBot_luVars={}
HealBot_luVars["FPS"]={[0]=60,
                       [1]={[1]=60,[2]=60,[3]=60,[0]=60},
                       [2]={[1]=60,[2]=60,[3]=60,[0]=60},
                       [3]={[1]=60,[2]=60,[3]=60,[0]=60},}
HealBot_luVars["qaFRNext"]=TimeNow+45
HealBot_luVars["IsSolo"]=true
HealBot_luVars["MaskAuraReCheck"]=false
HealBot_luVars["ReloadUI"]=0
HealBot_luVars["MessageReloadUI"]=0
HealBot_luVars["slowSwitch"]=0
HealBot_luVars["fastSwitch"]=0
HealBot_luVars["iconSwitch"]=0
HealBot_luVars["ResetFlag"]=false
HealBot_luVars["MovingFrame"]=0
HealBot_luVars["TargetNeedReset"]=true
HealBot_luVars["FocusNeedReset"]=true
HealBot_luVars["TankUnit"]="x"
HealBot_luVars["healthFactor"]=1
HealBot_luVars["NextTipUpdate"]=TimeNow
HealBot_luVars["TipUpdateFreq"]=1
HealBot_luVars["EnableErrorSpeech"]=false
HealBot_luVars["EnableErrorText"]=false
HealBot_luVars["AllOutOfCombatCheck"]=TimeNow+1
HealBot_luVars["UpdateEnemyFrame"]=true
HealBot_luVars["NoSpamOOM"]=0
HealBot_luVars["AuraEventRegistered"]=false 
HealBot_luVars["TestBarsOn"]=false
HealBot_luVars["RaidTargetUpdate"]=false
HealBot_luVars["showReloadMsg"]=true
HealBot_luVars["overhealUnit"]="-nil-"
HealBot_luVars["overhealCastID"]="-nil-"
HealBot_luVars["ChatMSG"]=""
HealBot_luVars["ChatNOTIFY"]=0
HealBot_luVars["pluginThreat"]=false
HealBot_luVars["pluginTimeToDie"]=false
HealBot_luVars["adjMaxHealth"]=0
HealBot_luVars["slowUpdateID"]=1
HealBot_luVars["UpdateMaxUnits"]=5
HealBot_luVars["UpdateNumUnits"]=1
HealBot_luVars["prevNumUnits"]=0
HealBot_luVars["UpdateID"]=1
HealBot_luVars["UpdateAllAura"]=0
HealBot_luVars["CheckAuraFlags"]=true
HealBot_luVars["GetVersions"]=false
HealBot_luVars["MaxFastQueue"]=12
HealBot_luVars["fastQueueSwitch"]=0
HealBot_luVars["CheckFramesOnCombat"]=true
HealBot_luVars["UpdateSlowNext"]=TimeNow+1
HealBot_luVars["cpuAdj"]=0
HealBot_luVars["rangeCheckAdj"]=0.5
HealBot_luVars["pluginCDsCheckExisting"]=TimeNow+1
HealBot_luVars["HealthDropPct"]=999
HealBot_luVars["InInstance"]=false
HealBot_luVars["DoSendGuildVersion"]=true
HealBot_luVars["mapName"]=""
HealBot_luVars["NumPrivateUnits"]=0
HealBot_luVars["NumPetUnits"]=0
HealBot_luVars["DropCombat"]=0
HealBot_luVars["CurrentSpec"]=1
HealBot_luVars["talentUpdateFreq"]=0.2
HealBot_luVars["inspectGUID"]=""
HealBot_luVars["pluginClearDown"]=0
HealBot_luVars["pluginCDsCheckIncoming"]=TimeNow+1
if HEALBOT_GAME_VERSION<4 then HealBot_luVars["talentUpdateFreq"]=1 end

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

local hbSpecialInGeneralFrame={[2]=8, [1]=7, [3]=9, [4]=10}
function HealBot_nextRecalcParty(typeRequired)
    if hbSpecialInGeneralFrame[typeRequired] and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][hbSpecialInGeneralFrame[typeRequired]]["FRAME"]<6 then
        if not InCombatLockdown() and HealBot_Action_FrameIsVisible(hbSpecialInGeneralFrame[typeRequired]-1) then 
            HealBot_Action_HidePanel(hbSpecialInGeneralFrame[typeRequired]-1) 
        end
        typeRequired=6
    end
    if typeRequired==2 and Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["SELFPET"] then
        HealBot_Timers_Set("INIT","RefreshPartyNextRecalcPlayers")
    end
    HealBot_RefreshTypes[typeRequired]=true
    HealBot_Timer_FramesRefresh()
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
    for x,_ in pairs(HealBot_UpdateQueue) do
        HealBot_UpdateQueue[x]=nil
    end
    for x,_ in pairs(HealBot_SlowUpdateQueue) do
        HealBot_SlowUpdateQueue[x]=nil
    end
end

function HealBot_setNotVisible(unit,group)
    HealBot_notVisible[unit]=group
      --HealBot_setCall("HealBot_setNotVisible")
end

function HealBot_SetResetFlag(mode)
    HealBot_Timers_TurboOn(2)
    if mode=="HARD" then
        ReloadUI()
    elseif mode=="SOFT" and not HealBot_luVars["TestBarsOn"] then
        if HealBot_Config.DisabledNow==1 then
            HealBot_Options_DisableHealBotOpt:SetChecked(false)
            HealBot_Options_DisableHealBot(false)
        end
        C_Timer.After(0.01, function() HealBot_Timers_Set("RESET","Full") end)
    elseif mode=="FRAMES" then
        HealBot_Timers_Set("RESET","Frames")
    else
        HealBot_Timers_Set("RESET","Quick")
    end
      --HealBot_setCall("HealBot_SetResetFlag")
end

local uzText=""
function HealBot_UnitZone(button)
    if button.player or UnitIsVisible(button.unit) then
        uzText=GetRealZoneText();
    elseif IsInRaid() and button.isplayer and UnitInRaid(button.unit) then
        local raidID=UnitInRaid(button.unit)
        _, _, _, _, _, _, uzText, _, _ = GetRaidRosterInfo(raidID);
    else
        HealBot_ScanTooltip:SetUnit(button.unit)
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
        HealBot_SpamCut[HBmsg]=TimeNow+1
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

function HealBot_TalentQuery(button)
    local hbInspect=false
    local s=" "
    if HealBot_Panel_RaidUnitGUID(button.guid) then 
        s=HealBot_Action_getGuidData(button.guid, "TMPSPEC")
    end
    if s~=" " then
        if button.spec~=s then
            HealBot_Timers_Set("INIT","RefreshPartyNextRecalcPlayers",1.25)
        end
        button.specupdate=0
        button.spec=s
        --HealBot_AddDebug("Cache unit="..button.unit,"Talent",true)
    elseif button.isplayer and UnitExists(button.unit) and UnitIsConnected(button.unit) then
        if HealBot_Action_IsUnitDead(button) then
            button.specupdate=TimeNow+5
        elseif HEALBOT_GAME_VERSION>3 then
            if UnitIsVisible(button.unit) then 
                hbInspect=true 
            else
                button.specupdate=TimeNow+3
            end
        elseif HEALBOT_GAME_VERSION==3 and HealBot_Panel_RaidUnitGUID(button.guid) and not HealBot_Globals.DenyTalentQuery then
            if CheckInteractDistance(button.unit, 1) then
                local g,p,ip,t,tp,tpc="",false,false,false,false,false
                if _G["PaperDollFrame"] then g=_G["PaperDollFrame"]; p=g:IsVisible() end
                if _G["InspectPaperDollFrame"] then g=_G["InspectPaperDollFrame"]; ip=g:IsVisible() end
                if _G["TalentFrame"] then g=_G["TalentFrame"]; t=g:IsVisible() end
                if _G["InspectTalentFrame"] then g=_G["InspectTalentFrame"]; tp=g:IsVisible() end
                if _G["InspectTalentFrameScrollChildFrame"] then g=_G["InspectTalentFrameScrollChildFrame"]; tpc=g:IsVisible() end
                if not p and not ip and not t and not tp and not tpc then 
                    hbInspect=true 
                else
                    button.specupdate=TimeNow+5
                end
            elseif UnitIsVisible(button.unit) then 
                button.specupdate=TimeNow+1
            else
                button.specupdate=TimeNow+3
            end
        else
            button.specupdate=0
        end
    else
        button.specupdate=0
    end
    if hbInspect and CanInspect(button.unit) then
        HealBot_luVars["talentUpdate"]=TimeNow+3
        HealBot_luVars["inspectGUID"]=button.guid
        NotifyInspect(button.unit); 
        button.specupdate=0
        --HealBot_AddDebug("Query unit="..button.unit,"Talent",true)
    end
      --HealBot_setCall("HealBot_TalentQuery")
end

function HealBot_Reset_AutoUpdateSpellIDs()
    HealBot_Aura_ClearCustomDebuffsDone()
    HealBot_AddChat("Automatic Spell ID's Turned On")
end

local ubZ, buffSpellName=1, ""
function HealBot_UnitHasBuffV1(unit, spellName)
    ubZ=1
    while true do
        buffSpellName = UnitBuff(unit,ubZ)
        if buffSpellName then
            ubZ=ubZ+1
            if buffSpellName==spellName then return true end
        else
            break
        end
    end
    return false
end

function HealBot_UnitHasBuffV9(unit, spellName)
    return AuraUtil.FindAuraByName(spellName, unit)
end

local HealBot_UnitHasBuff=HealBot_UnitHasBuffV1
if HEALBOT_GAME_VERSION>8 then
    HealBot_UnitHasBuff=HealBot_UnitHasBuffV9
end

local hbInPhase, hbPhaseShift=true,""
function HealBot_UnitInPhase(unit)
    if HEALBOT_GAME_VERSION<9 then 
        if not HealBot_Data["UILOCK"] and HealBot_UnitHasBuff(unit, hbPhaseShift) then
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

function HealBot_ToggleHealBot()
    if HealBot_Config.DisabledNow==0 then
        HealBot_Options_DisableHealBotOpt:SetChecked(true)
        HealBot_Options_DisableHealBot(true)
    else
        HealBot_Options_DisableHealBotOpt:SetChecked(false)
        HealBot_Options_DisableHealBot(false)
    end
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
        HealBot_TogglePanel(HealBot_Options, true)
    elseif (HBcmd=="d" or HBcmd=="defaults") then
        HealBot_Options_Defaults_OnClick(HealBot_Options_Defaults, true);
    elseif (HBcmd=="ui") then
        HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_HARDRELOAD)
        HealBot_SetResetFlag("HARD")
    elseif (HBcmd=="ri" or (HBcmd=="reset" and x and string.lower(x)=="healbot")) then
        HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_SOFTRELOAD)
        HealBot_SetResetFlag("SOFT")
    elseif (HBcmd=="rc" or (HBcmd=="reset" and x and string.lower(x)=="customdebuffs")) then
        HealBot_Timers_Set("RESET","CustomDebuffs")
    elseif (HBcmd=="rs" or (HBcmd=="reset" and x and string.lower(x)=="skin")) then
        HealBot_Timers_Set("RESET","Skins")
    elseif (HBcmd=="show") then
        HealBot_SetResetFlag("FRAMES")
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
        HealBot_Update_Skins()
        HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_SKIN_CHECK_DONE)
    elseif (HBcmd=="disable") then
        HealBot_Options_DisableHealBotOpt:SetChecked(true)
        HealBot_Options_DisableHealBot(true)
    elseif (HBcmd=="enable") then
        HealBot_Options_DisableHealBotOpt:SetChecked(false)
        HealBot_Options_DisableHealBot(false)
    elseif (HBcmd=="eac" and x) then
        if x=="buff" then
            HealBot_Globals.IgnoreCustomBuff={}
            HealBot_Options_BuffIconUpdate()
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_ENABLE_CUSTOM_BUFFS)
        elseif x=="debuff" then
            HealBot_Globals.IgnoreCustomDebuff={}
            HealBot_Options_DebuffIconUpdate()
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_ENABLE_CUSTOM_DEBUFFS)
        end
    elseif (HBcmd=="tnr") and HEALBOT_GAME_VERSION<4 then
        if HealBot_Globals.NoRanks then
            HealBot_Globals.NoRanks=false
            HealBot_AddChat(HEALBOT_CHAT_ADDONID.."Ranks will be shown")
            HealBot_Options_ReloadUI()
        else
            HealBot_Globals.NoRanks=true
            HealBot_AddChat(HEALBOT_CHAT_ADDONID.."Ranks will not be shown")
            HealBot_AddChat(HEALBOT_CHAT_ADDONID.."WARNING: This is not recommanded")
            HealBot_Options_ReloadUI()
        end
    elseif (HBcmd=="t") then
        HealBot_ToggleHealBot()
    elseif (HBcmd=="help" or HBcmd=="h") then
        HealBot_luVars["HelpCnt1"]=0
        HealBot_luVars["Help"]=true
    elseif (HBcmd=="hs") then
        HealBot_luVars["HelpCnt2"]=0
        HealBot_luVars["Help"]=true
    elseif (HBcmd=="iht" and x) then
        if HEALBOT_GAME_VERSION<4 then
            if (tonumber(x)>2) and (tonumber(x)<22) then
                HealBot_Globals.ClassicHoTTime=tonumber(x)+0.5
                HealBot_AddChat("HoT Time set to "..x.."s")
            else
                HealBot_AddChat("Invalid Value for HoT Time. valid range from 3 to 21")
            end
        end
    elseif (HBcmd=="skin" and x) then
        if y then x=x.." "..y end
        if z then x=x.." "..z end
        HealBot_Options_Set_Current_Skin(x, nil, nil, true)
    elseif (HBcmd=="use10") then
        if HealBot_Config.MacroUse10 then
            HealBot_Config.MacroUse10=false
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_USE10OFF)
        else
            HealBot_Config.MacroUse10=true
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_USE10ON)
        end
        HealBot_Timers_Set("INIT","PrepSetAllAttribs",0.5)
    elseif (HBcmd=="suppress" and x) then
        x=string.lower(x)
        HealBot_ToggleSuppressSetting(x)
    elseif (HBcmd=="atd" and x) then
        if (tonumber(x)>3) and (tonumber(x)<62) then
            HealBot_Config_Cures.ShowTimeMaxDuration=tonumber(x)
            HealBot_Lang_Options_enALL()
            HealBot_AddChat("Auto Timed Debuff Duration set to "..x.."s")
        else
            HealBot_AddChat("Invalid Value for Auto Timed Debuff Duration. valid range from 4 to 61")
        end
    elseif (HBcmd=="atb" and x) then
        if (tonumber(x)>3) and (tonumber(x)<62) then
            HealBot_Config_Buffs.AutoBuffExpireTime=tonumber(x)
            HealBot_Lang_Options_enALL()
            HealBot_AddChat("Auto Timed Buff Duration set to "..x.."s")
        else
            HealBot_AddChat("Invalid Value for Auto Timed Buff Duration. valid range from 4 to 61")
        end
    elseif (HBcmd=="test") then
        HealBot_TestBars()
    elseif (HBcmd=="tr" and x) then
        HealBot_Panel_SethbTopRole(x)
    elseif (HBcmd=="tpr") then 
        if HEALBOT_GAME_VERSION<4 then
            if HealBot_Globals.AllowPlayerRoles then
                HealBot_Globals.AllowPlayerRoles=false
                HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_PLAYERROLESOFF)
            else
                HealBot_Globals.AllowPlayerRoles=true
                HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_PLAYERROLESON)
            end
            HealBot_Timers_Set("INIT","RefreshPartyNextRecalcAll")
        end
    elseif (HBcmd=="ttq") then 
        if HEALBOT_GAME_VERSION==3 then
            if HealBot_Globals.DenyTalentQuery then
                HealBot_Globals.DenyTalentQuery=nil
                HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_ALLOWTALENTQUERYON)
            else
                HealBot_Globals.DenyTalentQuery=true
                HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_ALLOWTALENTQUERYOFF)
            end
            HealBot_Timers_Set("INIT","RefreshPartyNextRecalcAll")
        end
    elseif (HBcmd=="spt") then
        if Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["SELFPET"] then
            Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["SELFPET"]=false
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_SELFPETSOFF)
        else
            Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["SELFPET"]=true
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_SELFPETSON)
        end
        HealBot_Timers_Set("INIT","RefreshPartyNextRecalcPlayers")
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
    elseif (HBcmd=="rtb") then
        if HealBot_Globals.TargetBarRestricted==1 then
            HealBot_Globals.TargetBarRestricted=0
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_RESTRICTTARGETBAR_OFF)
        else
            HealBot_Globals.TargetBarRestricted=1
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_RESTRICTTARGETBAR_ON)
        end
    elseif (HBcmd=="dm") then
        HealBot_MountsPets_DislikeMount("Dislike")
    elseif (HBcmd=="em") then
        HealBot_MountsPets_DislikeMount("Exclude")
    elseif (HBcmd=="fm") then
        if HEALBOT_GAME_VERSION==3 then
            HealBot_MountsPets_FavClassicMount()
        end
    elseif (HBcmd=="cpu") then
        if HealBot_luVars["CPUProfilerOn"] then
            HealBot_AddChat("WARNING: cpu profiling is ON, to disable type:")
            HealBot_AddChat("WARNING: /console scriptProfile 0")
            HealBot_AddChat("WARNING: /reload")
        end
        HealBot_AddChat("Out of combat FPS="..HealBot_luVars["FPS"][0].." CPU Level="..HealBot_Globals.CPUUsage)
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
    elseif (HBcmd=="tpd" and x) then
        if UnitExists(x) then
            HealBot_Panel_ToggelPrivateDamagers(x, false)
        else
            HealBot_AddChat(HEALBOT_CHAT_ADDONID.."Invalid Unit "..x)
        end
    elseif (HBcmd=="tpl" and x) then
        if UnitExists(x) then
            HealBot_Panel_ToggelHealTarget(x, false)
        else
            HealBot_AddChat(HEALBOT_CHAT_ADDONID.."Invalid Unit "..x)
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
        _,xButton,pButton = HealBot_UnitID("player")
        if xButton then
            xButton.health.init=false
            xButton.health.current=1
            xButton.gref["Bar"]:SetValue(0)
            HealBot_OnEvent_UnitHealth(xButton)
        end
        if pButton then
            pButton.health.init=false
            pButton.health.current=1
            pButton.gref["Bar"]:SetValue(0)
            HealBot_OnEvent_UnitHealth(pButton)
        end
    elseif (HBcmd=="zzz") then
        _,xButton,pButton = HealBot_UnitID("player")
        local button=xButton or pButton
        HealBot_AddDebug("#: UpdateMaxUnits="..HealBot_luVars["UpdateMaxUnits"].." UpdateNumUnits="..HealBot_luVars["UpdateNumUnits"].." MaxFastQueue="..HealBot_luVars["MaxFastQueue"].." nProcs="..HealBot_Timers_retLuVars("nProcs"))
        HealBot_AddDebug("health.hpct="..button.health.hpct.."  health.absorbspctc="..button.health.absorbspctc,"Hot",true)
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
        if HealBot_Globals.MacroSuppressSound then
            HealBot_Globals.MacroSuppressSound=false
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_MACROSOUNDON)
        else
            HealBot_Globals.MacroSuppressSound=true
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_MACROSOUNDOFF)
        end
        HealBot_Comms_MacroSuppressSound()
    elseif settingType=="error" then
        if HealBot_Globals.MacroSuppressError then
            HealBot_Globals.MacroSuppressError=false
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_MACROERRORON)
        else
            HealBot_Globals.MacroSuppressError=true
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_MACROERROROFF)
        end
        HealBot_Comms_MacroSuppressError()
    end
    HealBot_Timers_Set("INIT","PrepSetAllAttribs",0.2)
      --HealBot_setCall("HealBot_ToggleSuppressSetting")
end

function HealBot_TestBars()
    HealBot_Panel_ToggleTestBars()
    HealBot_Timers_nextRecalcAll()
      --HealBot_setCall("HealBot_TestBars")
end

local hbManaWatch={}
function HealBot_ManaWatch(guid, state)
    if state then
        hbManaWatch[guid]=true
    else
        hbManaWatch[guid]=nil
    end
end

local hbManaCurrent, hbManaMax, pLowManaDrinkNeed=0,0,false
function HealBot_OnEvent_UnitMana(button)
    if button.mana.change then HealBot_Action_setButtonManaBarCol(button) end
    if button.status.current<HealBot_Unit_Status["DEAD"] then
        hbManaCurrent=UnitPower(button.unit) or 0
        hbManaMax=UnitPowerMax(button.unit) or 0
        if button.mana.current~=hbManaCurrent or button.mana.max~=hbManaMax or button.mana.change then
            --if not HealBot_Data["UILOCK"] and HEALBOT_GAME_VERSION==3 and button.isplayer and not button.player and hbManaMax~=button.mana.max then --(hbManaMax>(button.mana.max*1.1) or hbManaMax<(button.mana.max*0.9)) then
            --    HealBot_OnEvent_SpecChange(button)
            --end
            button.mana.current=hbManaCurrent
            button.mana.max=hbManaMax
            if button.mana.max>0 then
                button.mana.pct=floor((button.mana.current/button.mana.max)*100)
                button.mana.pctc=button.mana.pct*10
            else
                button.mana.pct=0
                button.mana.pctc=0
            end
            if hbManaWatch[button.guid] then
                HealBot_Plugin_ManaWatch_UnitUpdate(button)
            end
            HealBot_Aux_setPowerBars(button)
            if button.mouseover and HealBot_Data["TIPBUTTON"] then HealBot_Action_RefreshTooltip() end
        end
        HealBot_Action_setPowerIndicators(button)
    elseif button.mana.current>0 or button.mana.max>0 then
        button.mana.current=0
        button.mana.max=0
        HealBot_Aux_setPowerBars(button)
        HealBot_Action_setPowerIndicators(button)
    end
    button.mana.lowcheck=true
      --HealBot_setCall("HealBot_OnEvent_UnitMana")
end

function HealBot_OnEvent_UnitManaUpdate(button)
    button.mana.change=true
    button.mana.nextcheck=TimeNow+5
    HealBot_OnEvent_UnitMana(button)
      --HealBot_setCall("HealBot_OnEvent_UnitManaUpdate")
end

function HealBot_UpdateAllRangeSpells()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Action_SetRangeSpell(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Action_SetRangeSpell(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Action_SetRangeSpell(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Action_SetRangeSpell(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Action_SetRangeSpell(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Action_SetRangeSpell(xButton)
    end
      --HealBot_setCall("HealBot_UpdateAllHotBars")
end

function HealBot_UpdateAllHotBarsButton(button)
    if HealBot_Action_retLuVars("HotBarsHealth")==0 then
        if button.hotbars.health then HealBot_Action_BarHotDisable(button, "HEALTH") end
    else
        HealBot_Action_UpdateHealthHotBar(button)
    end
    if button.aura.debuff.id>0 then HealBot_Aura_DebuffWarnings(button, button.aura.debuff.name, true) end
end

function HealBot_UpdateAllHotBars()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_UpdateAllHotBarsButton(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_UpdateAllHotBarsButton(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_UpdateAllHotBarsButton(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_UpdateAllHotBarsButton(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_UpdateAllHotBarsButton(xButton)
    end
      --HealBot_setCall("HealBot_UpdateAllHotBars")
end

function HealBot_UpdateAllAuxPowerBars()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_OnEvent_UnitManaUpdate(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_OnEvent_UnitManaUpdate(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_OnEvent_UnitManaUpdate(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_OnEvent_UnitManaUpdate(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_OnEvent_UnitManaUpdate(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_OnEvent_UnitManaUpdate(xButton)
    end
      --HealBot_setCall("HealBot_UpdateAllAuxPowerBars")
end

function HealBot_CheckAllAuxOverLays()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Aux_CheckOverLays(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Aux_CheckOverLays(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Aux_CheckOverLays(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Aux_CheckOverLays(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Aux_CheckOverLays(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Aux_CheckOverLays(xButton)
    end
      --HealBot_setCall("HealBot_CheckAllAuxOverLays")
end

function HealBot_ResetAllAuxText()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Aux_ResetNameBar(xButton)
        HealBot_Aux_ResetHealthBar(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Aux_ResetNameBar(xButton)
        HealBot_Aux_ResetHealthBar(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Aux_ResetNameBar(xButton)
        HealBot_Aux_ResetHealthBar(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Aux_ResetNameBar(xButton)
        HealBot_Aux_ResetHealthBar(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Aux_ResetNameBar(xButton)
        HealBot_Aux_ResetHealthBar(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Aux_ResetNameBar(xButton)
        HealBot_Aux_ResetHealthBar(xButton)
    end
      --HealBot_setCall("HealBot_ResetAllAuxText")
end

function HealBot_UpdateAllBackground()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Action_UpdateBackground(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Action_UpdateBackground(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Action_UpdateBackground(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Action_UpdateBackground(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Action_UpdateBackground(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Action_UpdateBackground(xButton)
    end
      --HealBot_setCall("HealBot_UpdateAllBackground")
end

function HealBot_UpdateAllAuxBars()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Aux_UpdBar(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Aux_UpdBar(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Aux_UpdBar(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Aux_UpdBar(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Aux_UpdBar(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Aux_UpdBar(xButton)
    end
      --HealBot_setCall("HealBot_UpdateAllAuxBars")
end

function HealBot_updAuxBuffBars(button)
    if button.aura.buff.name then
        HealBot_Aura_BuffWarnings(button, button.aura.buff.name, true)
    else
        HealBot_Aura_AuxClearAuraBuffBars(button)
    end
end

function HealBot_updAllAuxBuffBars()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_updAuxBuffBars(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_updAuxBuffBars(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_updAuxBuffBars(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_updAuxBuffBars(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_updAuxBuffBars(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_updAuxBuffBars(xButton)
    end
      --HealBot_setCall("HealBot_updAllAuxBuffBars")
end

function HealBot_updAllAuxOverHealsBars()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Aux_UpdateOverHealBar(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Aux_UpdateOverHealBar(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Aux_UpdateOverHealBar(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Aux_UpdateOverHealBar(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Aux_UpdateOverHealBar(xButton)
    end
      --HealBot_setCall("HealBot_updAllAuxOverHealsBars")
end

function HealBot_updAllAuxInHealsBars()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Aux_UpdateHealInBar(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Aux_UpdateHealInBar(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Aux_UpdateHealInBar(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Aux_UpdateHealInBar(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Aux_UpdateHealInBar(xButton)
    end
      --HealBot_setCall("HealBot_updAllAuxInHealsBars")
end

function HealBot_updAllAuxAbsorbBars()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Aux_UpdateAbsorbBar(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Aux_UpdateAbsorbBar(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Aux_UpdateAbsorbBar(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Aux_UpdateAbsorbBar(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Aux_UpdateAbsorbBar(xButton)
    end
      --HealBot_setCall("HealBot_updAllAuxAbsorbBars")
end

function HealBot_updAllAuxThreatBars()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Aux_UpdateThreatBar(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Aux_UpdateThreatBar(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Aux_UpdateThreatBar(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Aux_UpdateThreatBar(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Aux_UpdateThreatBar(xButton)
    end
      --HealBot_setCall("HealBot_updAllAuxThreatBars")
end

function HealBot_updAllStateIconAFK()
    for _,xButton in pairs(HealBot_Unit_Button) do
       HealBot_OnEvent_UnitFlagsChanged(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
       HealBot_OnEvent_UnitFlagsChanged(xButton)
    end
      --HealBot_setCall("HealBot_updAllStateIconNotInCombat")
end

function HealBot_updAllStateIconNotInCombat()
    for _,xButton in pairs(HealBot_Unit_Button) do
       HealBot_UnitAffectingCombat(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
       HealBot_UnitAffectingCombat(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
       HealBot_UnitAffectingCombat(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
       HealBot_UnitAffectingCombat(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
       HealBot_UnitAffectingCombat(xButton)
    end
      --HealBot_setCall("HealBot_updAllStateIconNotInCombat")
end

function HealBot_updAuxDebuffBars(button)
    if button.aura.debuff.id>0 then
        HealBot_Aura_DebuffWarnings(button, button.aura.debuff.name, true)
    else
        HealBot_Aura_AuxClearAuraDebuffBars(button)
    end
end

function HealBot_updAllAuxDebuffBars()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_updAuxDebuffBars(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_updAuxDebuffBars(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_updAuxDebuffBars(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_updAuxDebuffBars(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_updAuxDebuffBars(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_updAuxDebuffBars(xButton)
    end
      --HealBot_setCall("HealBot_updAllAuxDebuffBars")
end

function HealBot_updAllAuxRangeBars()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Update_OORBar(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Update_OORBar(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Update_OORBar(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Update_OORBar(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Update_OORBar(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Update_OORBar(xButton)
    end
      --HealBot_setCall("HealBot_updAllAuxRangeBars")
end

function HealBot_updAllAuxRange30Bars()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Update_Range30Bar(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Update_Range30Bar(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Update_Range30Bar(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Update_Range30Bar(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Update_Range30Bar(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Update_Range30Bar(xButton)
    end
      --HealBot_setCall("HealBot_updAllAuxRange30Bars")
end

function HealBot_UpdateAllUnitBars(playersOnly)
    for _,xButton in pairs(HealBot_Unit_Button) do
        xButton.status.update=true
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        xButton.status.update=true
    end
    if not playersOnly then
        for _,xButton in pairs(HealBot_Pet_Button) do
            xButton.status.update=true
        end
        for _,xButton in pairs(HealBot_Vehicle_Button) do
            xButton.status.update=true
        end
        for _,xButton in pairs(HealBot_Extra_Button) do
            xButton.status.update=true
        end
        for _,xButton in pairs(HealBot_Enemy_Button) do
            xButton.status.update=true
        end
    end
      --HealBot_setCall("HealBot_UpdateAllUnitBars")
end

function HealBot_CheckAllPartyGUIDs()
    for _,xButton in pairs(HealBot_Unit_Button) do
        if xButton.guid~=UnitGUID(xButton.unit) then
            HealBot_CheckUpdateUnitGUIDChange(xButton)
        end
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        if xButton.guid~=UnitGUID(xButton.unit) then
            HealBot_CheckUpdateUnitGUIDChange(xButton)
        end
    end
      --HealBot_setCall("HealBot_CheckAllPartyGUIDs")
end

function HealBot_CheckAllPetGUIDs()
    for _,xButton in pairs(HealBot_Pet_Button) do
        if xButton.guid~=UnitGUID(xButton.unit) then
            HealBot_CheckUpdateUnitGUIDChange(xButton)
        end
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        if xButton.guid~=UnitGUID(xButton.unit) then
            HealBot_CheckUpdateUnitGUIDChange(xButton)
        end
    end
      --HealBot_setCall("HealBot_CheckAllPetGUIDs")
end

function HealBot_CheckUnitStatus(button)
    button.status.nextcheck=TimeNow+3
    HealBot_SetUnitDisconnect(button)
    if button.status.current<HealBot_Unit_Status["DC"] then
        HealBot_Action_UpdateTheDeadButton(button, TimeNow)
        if button.health.current==0 then
            button.status.change=true
            button.status.update=true
        end
    end
      --HealBot_setCall("HealBot_CheckUnitStatus")
end

function HealBot_UpdateUnitClear(button)
    HealBot_Aura_ClearBuff(button)
    HealBot_Aura_ClearDebuff(button)
    HealBot_Aura_RemoveIcons(button)
    HealBot_Aux_clearAllBars(button)
    HealBot_Aggro_ClearUnitAggro(button)
    button.status.incombat=false
    button.status.hostile=false
    button.spec=" "
      --HealBot_setCall("HealBot_UpdateUnitClear")
end

local uuUnitClassEN="XXXX"
function HealBot_UpdateUnitNotExists(button, isSetHealButton)
    if button.unit=="target" and not isSetHealButton and not InCombatLockdown() then
        HealBot_PlayerTargetChanged()
    else
        HealBot_Action_setState(button, HealBot_Unit_Status["RESERVED"])
        button.status.update=true
        button.status.change=true
        HealBot_UpdateUnitClear(button)
        HealBot_OnEvent_UnitHealth(button)
        HealBot_Text_setNameTag(button)
        HealBot_Text_setNameText(button)
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTXTANCHOR"]~=4 then button.text.healthupdate=true end
        HealBot_Text_UpdateText(button)
        HealBot_Action_UpdateBackground(button)
        HealBot_Action_UpdateAllIndicators(button)
        HealBot_Action_EmergBarCheck(button, true)
        button.status.classknown=false
        button.guid=button.unit
        if not isSetHealButton then
            if button.status.unittype==7 and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["STATE"] then
                HealBot_Timers_Set("INIT","RefreshPartyNextRecalcVehicle")
            elseif button.status.unittype==8 and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["STATE"] then
                HealBot_Timers_Set("INIT","RefreshPartyNextRecalcPets")
            end
        end
        if button.status.dirarrowshown>0 then HealBot_Action_HideDirectionArrow(button) end
    end
      --HealBot_setCall("HealBot_UpdateUnitNotExists - c="..button.status.current)
end

function HealBot_UpdateUnit(button)
    if button.status.classknown then 
        button.status.update=false
        button.status.postupdate=true
        HealBot_OnEvent_UnitManaUpdate(button)
        HealBot_Aux_UpdBar(button)
        HealBot_OnEvent_ClassificationChanged(button)
        HealBot_UnitAffectingCombat(button)
        HealBot_Check_UnitAura(button)
        HealBot_Action_ResetUnitButtonOpacity(button)
        HealBot_OnEvent_UnitHealth(button)
        HealBot_Action_UpdateBackground(button)
        HealBot_Action_EmergBarCheck(button, true)
        button.level=UnitLevel(button.unit) or 1
    else
        button.guid=button.unit
    end
      --HealBot_setCall("HealBot_UpdateUnit")
end

function HealBot_UpdateUnitGUIDChange(button)
    HealBot_QueueClearGUID(button.guid)
    button.guid=UnitGUID(button.unit) or button.unit
    if button.status.current==HealBot_Unit_Status["RESERVED"] then button.status.current=HealBot_Unit_Status["CHECK"] end
    HealBot_UpdateUnitClear(button)
    HealBot_UnitClass(button)
    if button.status.classknown then
        HealBot_RefreshUnit(button)
        HealBot_QueueSpecUpdate(button)
        button.health.init=true
        button.mana.init=true
        button.status.update=true
        button.status.change=true
    end
      --HealBot_setCall("HealBot_UpdateUnitGUIDChange")
end

function HealBot_CheckUpdateUnitGUIDChange(button)
    if button.guid~=UnitGUID(button.unit) then
        HealBot_UpdateUnitGUIDChange(button)
    else
        button.status.change=true
        button.status.update=true
    end
end

local guName=false
function HealBot_UnitClass(button)
    if HealBot_Action_getGuidData(button.guid, "CLASSKNOWN") then
        button.player=HealBot_Action_getGuidData(button.guid, "PLAYER")
        button.isplayer=HealBot_Action_getGuidData(button.guid, "ISPLAYER")
        button.text.classtrim=HealBot_Action_getGuidData(button.guid, "CLASSTRIM")
        button.text.r=HealBot_Action_getGuidData(button.guid, "CLASSR")
        button.text.g=HealBot_Action_getGuidData(button.guid, "CLASSG")
        button.text.b=HealBot_Action_getGuidData(button.guid, "CLASSB")
        button.name=HealBot_Action_getGuidData(button.guid, "NAME")
        button.status.classknown=true
    else
        button.name=false
        if UnitIsUnit(button.unit, "player") then
            button.player=true
            button.isplayer=true
        else
            button.player=false
            if UnitIsPlayer(button.unit) then
                button.isplayer=true
            else
                button.isplayer=false
            end
        end
        _, uuUnitClassEN = UnitClass(button.unit);
        if uuUnitClassEN then
            button.status.classknown=true
            button.text.classtrim = strsub(uuUnitClassEN,1,4)
            button.text.r,button.text.g,button.text.b=HealBot_Action_ClassColour(button.unit, button.text.classtrim)
            if HealBot_Panel_RaidUnitGUID(button.guid) then
                guName=HealBot_customTempUserName[button.guid] or UnitName(button.unit) or false
                if guName and guName~=HEALBOT_WORDS_UNKNOWN then
                    button.name=guName
                    HealBot_Action_setGuidData(button, "CLASSKNOWN", true)
                    HealBot_Action_setGuidData(button, "PLAYER", button.player)
                    HealBot_Action_setGuidData(button, "ISPLAYER", button.isplayer)
                    HealBot_Action_setGuidData(button, "CLASSTRIM", button.text.classtrim)
                    HealBot_Action_setGuidData(button, "CLASSR", button.text.r)
                    HealBot_Action_setGuidData(button, "CLASSG", button.text.g)
                    HealBot_Action_setGuidData(button, "CLASSB", button.text.b)
                    HealBot_Action_setGuidData(button, "NAME", guName)
                end
            end 
        elseif button.isplayer then
            button.status.classknown=false
        else
            button.status.classknown=true
            button.text.r,button.text.g,button.text.b=HealBot_Action_ClassColour(button.unit)
        end
    end
    if button.health.hpct>890 then button.health.mixcolr, button.health.mixcolg, button.health.mixcolb=button.text.r, button.text.g, button.text.b end
        --HealBot_setCall("HealBot_UnitClass")
end

function HealBot_UpdateUnitExists(button)
    if button.status.current==HealBot_Unit_Status["RESERVED"] or not button.status.classknown then 
        button.guid=button.unit
    else
        button.status.change=false
        button.status.postchange=true
        if not button.status.duplicate and button.status.unittype<7 then 
            button.status.plugin=true
        else
            button.status.plugin=false
        end
        HealBot_Text_setNameTag(button)
        HealBot_Text_setNameText(button)
        button.text.health=""
        HealBot_Text_setHealthText(button)
        HealBot_UpdateUnit(button)
    end
        --HealBot_setCall("HealBot_UpdateUnitExists")
end

function HealBot_RecalcParty(changeType)
    HealBot_RefreshTypes[changeType]=false
    if changeType==5 and not HealBot_luVars["UpdateEnemyFrame"] then
        HealBot_Timers_Set("INIT","RefreshPartyNextRecalcEnemy")
    else
        HealBot_Action_resetShouldHealSomeFrames()
        HealBot_ClearPlayerButtonCache()
        HealBot_Panel_PartyChanged(HealBot_Data["UILOCK"], changeType)
        if not HealBot_luVars["TestBarsOn"] then
            HealBot_RefreshLists()
        end
    end
    --HealBot_setCall("HealBot_RecalcParty")
end

function HealBot_CheckZone()
    HealBot_Timers_AuraReset()
    HealBot_Timers_Set("LAST","ZoneUpdate")
    HealBot_Timers_Set("LAST","MountsPetsZone")
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
                if HEALBOT_GAME_VERSION>3 then
                    if sName == HEALBOT_NATURES_CURE and z ~= 4 then 
                        sName = HEALBOT_REMOVE_CORRUPTION
                    elseif sName == HEALBOT_REMOVE_CORRUPTION and z == 4 then 
                        sName = HEALBOT_NATURES_CURE
                    elseif sName == HEALBOT_PURIFY_SPIRIT and z ~= 3 then 
                        sName = HEALBOT_CLEANSE_SPIRIT
                    elseif sName == HEALBOT_CLEANSE_SPIRIT and z == 3 then 
                        sName = HEALBOT_PURIFY_SPIRIT
                    end
                end
                HealBot_Config_Cures.HealBotDebuffText[z..ddId]=sName
            elseif not HealBot_Config_Cures.HealBotDebuffText[z..ddId] then 
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

function HealBot_Update_SpellCombo(combo, maxButtons)
    if combo then
        for y=1,maxButtons do
            local button = HealBot_Options_ComboClass_Button(y)
            for z=1,4 do
                combo[button..z] = combo[button]
                combo["Shift"..button..z] = combo["Shift"..button]
                combo["Ctrl"..button..z] = combo["Ctrl"..button]
                combo["Alt"..button..z] = combo["Alt"..button]
                combo["Ctrl-Shift"..button..z] = combo["Ctrl-Shift"..button]
                combo["Alt-Shift"..button..z] = combo["Alt-Shift"..button]
                combo["Alt-Ctrl"..button..z] = combo["Alt-Ctrl"..button]
                combo["Alt-Ctrl-Shift"..button..z] = combo["Alt-Ctrl-Shift"..button]
            end
        end
    end
end
function HealBot_Update_SpellCombos()
    HealBot_Update_SpellCombo(HealBot_Config_Spells.EnabledKeyCombo, 20)
    HealBot_Update_SpellCombo(HealBot_Config_Spells.EnemyKeyCombo, 20)
    HealBot_Update_SpellCombo(HealBot_Config_Spells.EmergKeyCombo, 5)
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
        HealBot_Action_SetSpell("ENABLED", "CtrlMiddle", GetSpellInfo(HBC_NOURISH))
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
    elseif pClassTrim=="EVOK" then
        HealBot_Action_SetSpell("ENABLED", "Left", GetSpellInfo(HEALBOT_LIVING_FLAME))
        HealBot_Action_SetSpell("ENABLED", "ShiftLeft", GetSpellInfo(HEALBOT_REVERSION))
        HealBot_Action_SetSpell("ENABLED", "ShiftRight", GetSpellInfo(HEALBOT_REWIND))
        HealBot_Action_SetSpell("ENABLED", "CtrlLeft", GetSpellInfo(HEALBOT_NATURALIZE))
        HealBot_Action_SetSpell("ENABLED", "CtrlRight", GetSpellInfo(HEALBOT_CAUTERIZING_FLAME))
        HealBot_Action_SetSpell("ENABLED", "Right", GetSpellInfo(HEALBOT_SPIRITBLOOM))
        HealBot_Action_SetSpell("ENABLED", "Middle", GetSpellInfo(HEALBOT_ECHO))
        HealBot_Action_SetSpell("ENABLED", "ShiftMiddle", GetSpellInfo(HEALBOT_EMERALD_BLOSSOM))
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
        if HEALBOT_GAME_VERSION>3 or HealBot_Data["PLEVEL"]<40 then
            HealBot_Action_SetSpell("ENABLED", "ShiftRight", GetSpellInfo(HEALBOT_HOLY_WORD_SERENITY))
        else
            HealBot_Action_SetSpell("ENABLED", "ShiftRight", GetSpellInfo(HBC_HEAL))
        end
        if HEALBOT_GAME_VERSION>3 then
            HealBot_Action_SetSpell("ENABLED", "CtrlRight", GetSpellInfo(HEALBOT_MASS_DISPEL))
        else
            HealBot_Action_SetSpell("ENABLED", "CtrlRight", GetSpellInfo(HBC_PRIEST_ABOLISH_DISEASE))
        end
        HealBot_Action_SetSpell("ENABLED", "Middle", GetSpellInfo(HEALBOT_RENEW))
        HealBot_Action_SetSpell("ENABLED", "ShiftMiddle", GetSpellInfo(HEALBOT_PRAYER_OF_MENDING))
        HealBot_Action_SetSpell("ENABLED", "AltMiddle", GetSpellInfo(HEALBOT_PRAYER_OF_HEALING))
        HealBot_Action_SetSpell("ENABLED", "CtrlMiddle", GetSpellInfo(HEALBOT_DIVINE_HYMN))
        if HEALBOT_GAME_VERSION>3 or HealBot_Data["PLEVEL"]>39 then
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
    HealBot_Action_SetSpell("ENABLED", "ShiftButton4", HEALBOT_DISABLED_TARGET)
    HealBot_Action_SetSpell("ENABLED", "ShiftButton5", HEALBOT_ASSIST)
    HealBot_Action_SetSpell("ENABLED", "Button4", HEALBOT_MENU)
    HealBot_Action_SetSpell("ENABLED", "Button5", HEALBOT_HBMENU)
      --HealBot_setCall("HealBot_DoReset_Spells")
end

function HealBot_DoReset_Cures(pClassTrim)
    HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_WORDS_NONE,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
    HealBot_Config_Cures.HealBotDebuffDropDown = {[1]=4,[2]=4,[3]=4}
    local i=1
    if pClassTrim=="DRUI" then
        if HEALBOT_GAME_VERSION<4 then
            if HealBot_Spell_Names[HBC_DRUID_REMOVE_CURSE] and HealBot_KnownSpell(HealBot_Spell_Names[HBC_DRUID_REMOVE_CURSE]) then
                HealBot_Config_Cures.HealBotDebuffText[i]=HBC_DRUID_REMOVE_CURSE
                i=i+1
            end
            if HealBot_Spell_Names[HBC_DRUID_ABOLISH_POISON] and HealBot_KnownSpell(HealBot_Spell_Names[HBC_DRUID_ABOLISH_POISON]) then
                HealBot_Config_Cures.HealBotDebuffText[i]=HBC_DRUID_ABOLISH_POISON
            elseif HealBot_Spell_Names[HBC_DRUID_CURE_POISON] and HealBot_KnownSpell(HealBot_Spell_Names[HBC_DRUID_CURE_POISON]) then
                HealBot_Config_Cures.HealBotDebuffText[i]=HBC_DRUID_CURE_POISON
            end
        else
            if HealBot_Spell_Names[HEALBOT_NATURES_CURE] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_NATURES_CURE]) then
                if HealBot_Spell_Names[HEALBOT_REMOVE_CORRUPTION] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_REMOVE_CORRUPTION]) then
                    HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_REMOVE_CORRUPTION,[2]=HEALBOT_NATURES_CURE,[3]=HEALBOT_WORDS_NONE}
                else
                    HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_NATURES_CURE,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
                end
            elseif HealBot_Spell_Names[HEALBOT_REMOVE_CORRUPTION] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_REMOVE_CORRUPTION]) then
                HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_REMOVE_CORRUPTION,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
            end
        end
    elseif pClassTrim=="MONK" then
        if HealBot_Spell_Names[HEALBOT_DETOX] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_DETOX]) then
            HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_DETOX,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
        end
    elseif pClassTrim=="PALA" then
        if HEALBOT_GAME_VERSION<4 then
            if HealBot_Spell_Names[HEALBOT_CLEANSE] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_CLEANSE]) then
                HealBot_Config_Cures.HealBotDebuffText[i]=HEALBOT_CLEANSE
                i=i+1
            end
            if HealBot_Spell_Names[HBC_PURIFY] and HealBot_KnownSpell(HealBot_Spell_Names[HBC_PURIFY]) then
                HealBot_Config_Cures.HealBotDebuffText[i]=HBC_PURIFY
            end
        else
            if HealBot_Spell_Names[HEALBOT_CLEANSE] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_CLEANSE]) then
                HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_CLEANSE,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
            elseif HealBot_Spell_Names[HEALBOT_CLEANSE_TOXIN] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_CLEANSE_TOXIN]) then
                HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_CLEANSE_TOXIN,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
            end
        end
    elseif pClassTrim=="PRIE" then
        if HealBot_Spell_Names[HEALBOT_PURIFY] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_PURIFY]) then
            if HealBot_Spell_Names[HBC_PRIEST_ABOLISH_DISEASE] and HealBot_KnownSpell(HealBot_Spell_Names[HBC_PRIEST_ABOLISH_DISEASE]) then
                HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_PURIFY,[2]=HBC_PRIEST_ABOLISH_DISEASE,[3]=HEALBOT_WORDS_NONE}
            elseif HealBot_Spell_Names[HEALBOT_MASS_DISPEL] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_MASS_DISPEL]) then
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
        if HEALBOT_GAME_VERSION<3 then
            if HealBot_Spell_Names[HBC_SHAMAN_CURE_POISON] and HealBot_KnownSpell(HealBot_Spell_Names[HBC_SHAMAN_CURE_POISON]) then
                if HealBot_Spell_Names[HBC_SHAMAN_CURE_DISEASE] and HealBot_KnownSpell(HealBot_Spell_Names[HBC_SHAMAN_CURE_DISEASE]) then
                    HealBot_Config_Cures.HealBotDebuffText = {[1]=HBC_SHAMAN_CURE_POISON,[2]=HBC_SHAMAN_CURE_DISEASE,[3]=HEALBOT_WORDS_NONE}
                else
                    HealBot_Config_Cures.HealBotDebuffText = {[1]=HBC_SHAMAN_CURE_POISON,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
                end
            elseif HealBot_Spell_Names[HBC_SHAMAN_CURE_DISEASE] and HealBot_KnownSpell(HealBot_Spell_Names[HBC_SHAMAN_CURE_DISEASE]) then
                HealBot_Config_Cures.HealBotDebuffText = {[1]=HBC_SHAMAN_CURE_DISEASE,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
            end
        elseif HEALBOT_GAME_VERSION<4 then
            if HealBot_Spell_Names[HBC_SHAMAN_CURE_POISON] and HealBot_KnownSpell(HealBot_Spell_Names[HBC_SHAMAN_CURE_POISON]) then
                if HealBot_Spell_Names[HEALBOT_CLEANSE_SPIRIT] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_CLEANSE_SPIRIT]) then
                    HealBot_Config_Cures.HealBotDebuffText = {[1]=HBC_SHAMAN_CURE_POISON,[2]=HEALBOT_CLEANSE_SPIRIT,[3]=HEALBOT_WORDS_NONE}
                else
                    HealBot_Config_Cures.HealBotDebuffText = {[1]=HBC_SHAMAN_CURE_POISON,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
                end
            elseif HealBot_Spell_Names[HEALBOT_CLEANSE_SPIRIT] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_CLEANSE_SPIRIT]) then
                HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_CLEANSE_SPIRIT,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
            end
        else
            if HealBot_Spell_Names[HEALBOT_PURIFY_SPIRIT] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_PURIFY_SPIRIT]) then
                HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_PURIFY_SPIRIT,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
            elseif HealBot_Spell_Names[HEALBOT_CLEANSE_SPIRIT] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_CLEANSE_SPIRIT]) then
                HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_CLEANSE_SPIRIT,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
            end
        end
    elseif pClassTrim=="MAGE" then
        if HealBot_Spell_Names[HEALBOT_REMOVE_CURSE] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_REMOVE_CURSE]) then
            HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_REMOVE_CURSE,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
        end
    elseif pClassTrim=="EVOK" then
        if HealBot_Spell_Names[HEALBOT_NATURALIZE] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_NATURALIZE]) then
            if HealBot_Spell_Names[HEALBOT_CAUTERIZING_FLAME] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_CAUTERIZING_FLAME]) then
                HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_NATURALIZE,[2]=HEALBOT_CAUTERIZING_FLAME,[3]=HEALBOT_WORDS_NONE}
            else 
                HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_NATURALIZE,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
            end
        elseif HealBot_Spell_Names[HEALBOT_EXPUNGE] and HealBot_KnownSpell(HealBot_Spell_Names[HEALBOT_EXPUNGE]) then
            HealBot_Config_Cures.HealBotDebuffText = {[1]=HEALBOT_EXPUNGE,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
        end
    end
      --HealBot_setCall("HealBot_DoReset_Cures")
end

local HealBot_GetContainerNumSlots=GetContainerNumSlots
local HealBot_GetContainerItemID=GetContainerItemID
if C_Container then
    HealBot_GetContainerNumSlots=C_Container.GetContainerNumSlots or GetContainerNumSlots
    HealBot_GetContainerItemID=C_Container.GetContainerItemID or GetContainerItemID
end

local function HealBot_ItemIdsInBag(bag)
    local itemId=0
    local numSlots=HealBot_GetContainerNumSlots(bag)
    for slot = 1,numSlots do
        itemId=HealBot_GetContainerItemID(bag,slot) or 0
        if itemId>0 then
            HealBot_ItemsInBags[itemId]=true
        end
    end
    if bag<NUM_BAG_SLOTS then
        C_Timer.After(0.04, function() HealBot_ItemIdsInBag(bag+1) end)
    else
        C_Timer.After(0.04, HealBot_CheckWellFedItems)
    end
end

function HealBot_ItemIdsInBags()
    for x,_ in pairs(HealBot_ItemsInBags) do
        HealBot_ItemsInBags[x]=nil;
    end
    HealBot_ItemIdsInBag(0)
      --HealBot_setCall("HealBot_retItemIdsInBag")
end

function HealBot_DoReset_Buffs(pClassTrim)
    HealBot_Config_Buffs.HealBotBuffText = {[1]=HEALBOT_WORDS_NONE,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE,[4]=HEALBOT_WORDS_NONE,[5]=HEALBOT_WORDS_NONE,
                                      [6]=HEALBOT_WORDS_NONE,[7]=HEALBOT_WORDS_NONE,[8]=HEALBOT_WORDS_NONE,[9]=HEALBOT_WORDS_NONE,[10]=HEALBOT_WORDS_NONE}
    HealBot_Config_Buffs.HealBotBuffDropDown = {[1]=4,[2]=4,[3]=4,[4]=4,[5]=4,[6]=4,[7]=4,[8]=4,[9]=2,[10]=2}
    if pClassTrim=="DRUI" then
        if HealBot_KnownSpell(HEALBOT_MARK_OF_THE_WILD) then
            HealBot_Config_Buffs.HealBotBuffText[1]=HealBot_KnownSpell(HEALBOT_MARK_OF_THE_WILD)
        end
        if HealBot_KnownSpell(HBC_GIFT_OF_THE_WILD) then
            HealBot_Config_Buffs.HealBotBuffText[2]=HealBot_KnownSpell(HBC_GIFT_OF_THE_WILD)
            HealBot_Config_Buffs.HealBotBuffDropDown[1]=2
        end
        if HealBot_KnownSpell(HBC_THORNS) then
            HealBot_Config_Buffs.HealBotBuffText[3]=HealBot_KnownSpell(HBC_THORNS)
            HealBot_Config_Buffs.HealBotBuffDropDown[3]=15
        end
    elseif pClassTrim=="MONK" then
        local i=1
        if HealBot_KnownSpell(HEALBOT_LEGACY_EMPEROR) and HealBot_Config.CurrentSpec==3 then
            HealBot_Config_Buffs.HealBotBuffText[1]=HealBot_KnownSpell(HEALBOT_LEGACY_EMPEROR)
            i=i+1
        elseif HealBot_KnownSpell(HEALBOT_LEGACY_WHITETIGER) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_KnownSpell(HEALBOT_LEGACY_WHITETIGER)
        end
    elseif pClassTrim=="PALA" then
        local i=1
        if HealBot_KnownSpell(HEALBOT_BLESSING_OF_KINGS) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_KnownSpell(HEALBOT_BLESSING_OF_KINGS)
            HealBot_Config_Buffs.HealBotBuffDropDown[i]=1
            i=i+1 
        elseif HealBot_KnownSpell(HBC_GREATER_BLESSING_OF_KINGS) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_KnownSpell(HBC_GREATER_BLESSING_OF_KINGS)
            HealBot_Config_Buffs.HealBotBuffDropDown[i]=1
            i=i+1
        elseif HealBot_KnownSpell(HBC_BLESSING_OF_KINGS) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_KnownSpell(HBC_BLESSING_OF_KINGS)
            HealBot_Config_Buffs.HealBotBuffDropDown[i]=1
            i=i+1
        end
        if HealBot_KnownSpell(HEALBOT_BLESSING_OF_MIGHT) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_KnownSpell(HEALBOT_BLESSING_OF_MIGHT)
            HealBot_Config_Buffs.HealBotBuffDropDown[i]=1
            i=i+1
        elseif HealBot_KnownSpell(HBC_GREATER_BLESSING_OF_MIGHT) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_KnownSpell(HBC_GREATER_BLESSING_OF_MIGHT)
            HealBot_Config_Buffs.HealBotBuffDropDown[i]=1
            i=i+1
        elseif HealBot_KnownSpell(HBC_BLESSING_OF_MIGHT) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_KnownSpell(HBC_BLESSING_OF_MIGHT)
            HealBot_Config_Buffs.HealBotBuffDropDown[i]=1
            i=i+1
        end
        if HealBot_KnownSpell(HEALBOT_BLESSING_OF_WISDOM) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_KnownSpell(HEALBOT_BLESSING_OF_WISDOM)
            HealBot_Config_Buffs.HealBotBuffDropDown[i]=1
        elseif HealBot_KnownSpell(HBC_GREATER_BLESSING_OF_WISDOM) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_KnownSpell(HBC_GREATER_BLESSING_OF_WISDOM)
            HealBot_Config_Buffs.HealBotBuffDropDown[i]=1
        elseif HealBot_KnownSpell(HBC_BLESSING_OF_WISDOM) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_KnownSpell(HBC_BLESSING_OF_WISDOM)
            HealBot_Config_Buffs.HealBotBuffDropDown[i]=1
        end
    elseif pClassTrim=="PRIE" then
        if HealBot_KnownSpell(HBC_POWER_WORD_FORTITUDE) then
            HealBot_Config_Buffs.HealBotBuffText[1]=HealBot_KnownSpell(HBC_POWER_WORD_FORTITUDE)
        elseif HealBot_KnownSpell(HEALBOT_POWER_WORD_FORTITUDE) then
            HealBot_Config_Buffs.HealBotBuffText[1]=HealBot_KnownSpell(HEALBOT_POWER_WORD_FORTITUDE)
        end
        local i=2
        if HealBot_KnownSpell(HBC_POWER_WORD_FORTITUDE) and HealBot_KnownSpell(HEALBOT_POWER_WORD_FORTITUDE) then
            HealBot_Config_Buffs.HealBotBuffText[2]=HealBot_KnownSpell(HEALBOT_POWER_WORD_FORTITUDE)
            HealBot_Config_Buffs.HealBotBuffDropDown[1]=2
            i=i+1
        end
        if HealBot_KnownSpell(HEALBOT_FEAR_WARD) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_KnownSpell(HEALBOT_FEAR_WARD)
            HealBot_Config_Buffs.HealBotBuffDropDown[i]=15
            i=i+1
        end
        if HealBot_KnownSpell(HBC_INNER_FIRE) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_KnownSpell(HBC_INNER_FIRE)
            HealBot_Config_Buffs.HealBotBuffDropDown[i]=2
            i=i+1
        end
        if HealBot_KnownSpell(HBC_DIVINE_SPIRIT) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_KnownSpell(HBC_DIVINE_SPIRIT)
            i=i+1
        end
        if HealBot_KnownSpell(HBC_PRAYER_OF_SPIRIT) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_KnownSpell(HBC_PRAYER_OF_SPIRIT)
            HealBot_Config_Buffs.HealBotBuffDropDown[i-1]=2
            i=i+1
        end
        if HealBot_KnownSpell(HBC_SHADOW_PROTECTION) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_KnownSpell(HBC_SHADOW_PROTECTION)
            i=i+1
        end
        if HealBot_KnownSpell(HBC_PRAYER_OF_SHADOW_PROTECTION) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_KnownSpell(HBC_PRAYER_OF_SHADOW_PROTECTION)
            HealBot_Config_Buffs.HealBotBuffDropDown[i-1]=2
            i=i+1
        end
    elseif pClassTrim=="SHAM" then
        if HealBot_KnownSpell(HEALBOT_WATER_SHIELD) then
            HealBot_Config_Buffs.HealBotBuffText[1]=HealBot_KnownSpell(HEALBOT_WATER_SHIELD)
            HealBot_Config_Buffs.HealBotBuffDropDown[1]=2
        end
        if HealBot_KnownSpell(HEALBOT_EARTH_SHIELD) then
            HealBot_Config_Buffs.HealBotBuffText[2]=HealBot_KnownSpell(HEALBOT_EARTH_SHIELD)
            HealBot_Config_Buffs.HealBotBuffDropDown[2]=15
        elseif HealBot_KnownSpell(HBC_EARTH_SHIELD) then
            HealBot_Config_Buffs.HealBotBuffText[2]=HealBot_KnownSpell(HBC_EARTH_SHIELD)
            HealBot_Config_Buffs.HealBotBuffDropDown[2]=15
        end
    elseif pClassTrim=="MAGE" then
        if HealBot_KnownSpell(HEALBOT_ARCANE_BRILLIANCE) then
            HealBot_Config_Buffs.HealBotBuffText[1]=HealBot_KnownSpell(HEALBOT_ARCANE_BRILLIANCE)
        end
        if HealBot_KnownSpell(HBC_ARCANE_BRILLIANCE) then
            HealBot_Config_Buffs.HealBotBuffText[2]=HealBot_KnownSpell(HBC_ARCANE_BRILLIANCE)
            HealBot_Config_Buffs.HealBotBuffDropDown[1]=2
        end
    elseif pClassTrim=="WARR" then
        if HealBot_KnownSpell(HEALBOT_COMMANDING_SHOUT) then
            HealBot_Config_Buffs.HealBotBuffText[1]=HealBot_KnownSpell(HEALBOT_COMMANDING_SHOUT)
        end
        if HealBot_KnownSpell(HEALBOT_VIGILANCE) then
            HealBot_Config_Buffs.HealBotBuffText[2]=HealBot_KnownSpell(HEALBOT_VIGILANCE)
            HealBot_Config_Buffs.HealBotBuffDropDown[2]=2
        end
    elseif pClassTrim=="WARL" then
        if HealBot_KnownSpell(HEALBOT_DARK_INTENT) then
            HealBot_Config_Buffs.HealBotBuffText[1]=HealBot_KnownSpell(HEALBOT_DARK_INTENT)
        end
    elseif pClassTrim=="EVOK" then
    end
      --HealBot_setCall("HealBot_DoReset_Buffs")
end

function HealBot_InitNewChar()
    if not HealBot_Config_Spells.EnemyKeyCombo then
        HealBot_Config_Spells.EnemyKeyCombo={}
    end
    if HealBot_Config_Spells.EnabledKeyCombo["New"] then
        HealBot_DoReset_Spells(HealBot_Data["PCLASSTRIM"])
        HealBot_DoReset_Cures(HealBot_Data["PCLASSTRIM"])
        HealBot_DoReset_Buffs(HealBot_Data["PCLASSTRIM"])
        HealBot_Config_Buffs.HealBotBuffColR = {[1]=1,[2]=1,[3]=1,[4]=1,[5]=1,[6]=1,[7]=1,[8]=1,[9]=1,[10]=1,[11]=1,[12]=1,[13]=1,[14]=1}
        HealBot_Config_Buffs.HealBotBuffColG = {[1]=1,[2]=1,[3]=1,[4]=1,[5]=1,[6]=1,[7]=1,[8]=1,[9]=1,[10]=1,[11]=1,[12]=1,[13]=1,[14]=1}
        HealBot_Config_Buffs.HealBotBuffColB = {[1]=1,[2]=1,[3]=1,[4]=1,[5]=1,[6]=1,[7]=1,[8]=1,[9]=1,[10]=1,[11]=1,[12]=1,[13]=1,[14]=1}
    end
    if HealBot_Config.CurrentSpec==9 then
        HealBot_Config.CurrentSpec=1
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
            if HEALBOT_GAME_VERSION==3 then
                HealBot:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
            end
        end
        if HEALBOT_GAME_VERSION>3 then
            HealBot:RegisterEvent("PLAYER_TALENT_UPDATE");
            HealBot:RegisterEvent("COMPANION_LEARNED");
            HealBot:RegisterEvent("PET_BATTLE_OPENING_START");
            HealBot:RegisterEvent("PET_BATTLE_OVER");
            HealBot:RegisterEvent("INCOMING_SUMMON_CHANGED")
            HealBot:RegisterEvent("PLAYER_ROLES_ASSIGNED");
        end
        HealBot:RegisterEvent("PLAYER_MOUNT_DISPLAY_CHANGED")
        HealBot:RegisterEvent("SPELL_UPDATE_COOLDOWN")
        HealBot:RegisterEvent("PLAYER_REGEN_DISABLED");
        HealBot:RegisterEvent("PLAYER_REGEN_ENABLED");
        HealBot:RegisterEvent("PLAYER_TARGET_CHANGED");
        local regPower=false
        HealBot:RegisterEvent("LEARNED_SPELL_IN_TAB");
        HealBot:RegisterEvent("PLAYER_LEVEL_UP");
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
        HealBot:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
        HealBot:RegisterEvent("DISPLAY_SIZE_CHANGED")
        HealBot:RegisterEvent("UI_SCALE_CHANGED")
    end
    HealBot:RegisterEvent("GET_ITEM_INFO_RECEIVED");
    HealBot:RegisterEvent("GROUP_ROSTER_UPDATE");
    HealBot:RegisterEvent("RAID_ROSTER_UPDATE");
    HealBot:RegisterEvent("CHAT_MSG_ADDON");
    HealBot:RegisterEvent("PLAYER_ENTERING_WORLD");
    HealBot:RegisterEvent("PLAYER_LEAVING_WORLD");
    HealBot:RegisterEvent("ZONE_CHANGED_NEW_AREA");
    HealBot:RegisterEvent("ZONE_CHANGED");
    HealBot:RegisterEvent("ZONE_CHANGED_INDOORS");
    HealBot:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
      --HealBot_setCall("HealBot_Register_Events")
end

function HealBot_SetResSpells()
    HealBot_ResSpells={[GetSpellInfo(HEALBOT_MASS_RESURRECTION) or "x"]=2,
                       [GetSpellInfo(HEALBOT_MASS_RETURN) or "x"]=2,
                       [GetSpellInfo(HEALBOT_ABSOLUTION) or "x"]=2,
                       [GetSpellInfo(HEALBOT_ANCESTRAL_VISION) or "x"]=2,
                       [GetSpellInfo(HEALBOT_REAWAKEN) or "x"]=2,
                       [GetSpellInfo(HEALBOT_REVITALIZE) or "x"]=2,
                       [GetSpellInfo(HEALBOT_RESURRECTION) or "x"]=1,
                       [GetSpellInfo(HEALBOT_RETURN) or "x"]=1,
                       [GetSpellInfo(HEALBOT_ANCESTRALSPIRIT) or "x"]=1,
                       [GetSpellInfo(HEALBOT_REBIRTH) or "x"]=1,
                       [GetSpellInfo(HEALBOT_REDEMPTION) or "x"]=1,
                       [GetSpellInfo(HEALBOT_REVIVE) or "x"]=1,
                       [GetSpellInfo(HEALBOT_RESUSCITATE) or "x"]=1,
                       [GetSpellInfo(HEALBOT_INTERCESSION) or "x"]=1}
end

function HealBot_Load()
    if not HealBot_luVars["Loaded"] then
        HealBot_Timers_TurboOn(5)
        HealBot_Init_Spells_Defaults()
        HealBot_InitNewChar()
        HealBot_luVars["CurrentSpec"]=HealBot_Config.CurrentSpec
        for x=16,20 do  -- This can be remove when 9.2.x check are replace with defaults due to old version
            if not HealBot_Config_Spells.Binds[x] then HealBot_Config_Spells.Binds[x]=1 end
        end
        HealBot_Options_LoadProfile()
        if HealBot_Config.Profile>1 then
            for x=16,20 do  -- This can be remove when 9.2.x check are replace with defaults due to old version
                if not HealBot_Config_Spells.Binds[x] then HealBot_Config_Spells.Binds[x]=1 end
            end
        end
        hbPhaseShift=GetSpellInfo(HBC_PHASE_SHIFT)
        HealBot_Data["POWERTYPE"]=UnitPowerType("player") or 0
        if HealBot_Data["POWERTYPE"]<0 or HealBot_Data["POWERTYPE"]>9 then HealBot_Data["POWERTYPE"]=0 end
        HealBot_Skins_ResetSkin("init")
        if not HealBot_luVars["HelpNotice"] then
            HealBot_Timers_Set("LAST","HealBotLoaded")
            HealBot_luVars["HelpNotice"]=true
        end      
        HealBot_MMButton_Init()
        HealBot_Aura_SetAuraWarningFlags()
        HealBot_Options_Override_ChatUse_Toggle()
        HealBot_Options_Override_EffectsUse_Toggle()
        HealBot_Options_Override_FramesUse_Toggle()
        HealBot_Action_StickyFrameIndCols()
        HealBot_Register_IncHeals()
        HealBot_PartyUpdate_CheckSkin()
        HealBot_Timers_SetCurrentSkin()
        HealBot_Action_ResetGlobalDimming()
        HealBot_Vers[UnitName("player")]=HEALBOT_VERSION
        HealBot_Comms_PerfLevel(hbLTfps[HealBot_Globals.CPUUsage])
        HealBot_Timers_Set("INIT","CheckTalentInfo")
        HealBot_Timers_Set("INIT","SeparateInHealsAbsorbs")
        HealBot_Timers_InitSpells()
        HealBot_Timers_Set("INIT","InitPlugins")
        HealBot_Timers_Set("INIT","RegEvents")
        HealBot_Timers_Set("SKINS","RaidTargetUpdate")
        HealBot_Timers_Set("SKINS","TextExtraCustomCols")
        HealBot_Timers_Set("SKINS","UpdateIconFreq")
        HealBot_Timers_Set("SKINS","PowerIndicator")
        HealBot_Timers_Set("AURA","InitAuraData")
        HealBot_Timers_Set("AURA","ConfigClassHoT")
        HealBot_Timers_Set("LAST","LowManaTrig")
        HealBot_Timers_Set("LAST","CheckFramesOnCombat")
        HealBot_Timers_Set("LAST","LastLoad",0.5)
        HealBot_Timers_Set("LAST","UpdateMaxUnitsAdj",1)
        HealBot_luVars["UpdateSlowNext"]=TimeNow+1
        HealBot_Globals.FirstLoad=false
        HealBot_luVars["Loaded"]=true
    end
          --HealBot_setCall("HealBot_Load")
end

function HealBot_FullReload()
    HealBot_OnEvent_AddOnLoaded("HealBot", true)
    HealBot_VariablesLoaded()
    HealBot_Timers_Set("RESET","Full")
    HealBot_AddDebug("Full Reload","Reset",true)
end

function HealBot_Reload()
    HealBot_luVars["Loaded"]=false
    HealBot_Timers_Set("INIT","AddonLoaded")
    HealBot_Timers_Set("RESET","Quick")
    HealBot_AddDebug("Reload","Reset",true)
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
            if HEALBOT_GAME_VERSION==3 then
                HealBot:UnregisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
            end
        end
        if HEALBOT_GAME_VERSION>3 then
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
        HealBot:UnregisterEvent("PLAYER_EQUIPMENT_CHANGED");
    end
    if HEALBOT_GAME_VERSION>3 then
        HealBot:UnregisterEvent("PET_BATTLE_OPENING_START");
        HealBot:UnregisterEvent("PET_BATTLE_OVER");
    end
    HealBot:UnregisterEvent("SPELL_UPDATE_COOLDOWN")
    HealBot:UnregisterEvent("RAID_TARGET_UPDATE")
    HealBot:UnregisterEvent("LEARNED_SPELL_IN_TAB");
    HealBot:UnregisterEvent("PLAYER_LEVEL_UP");
    HealBot:UnregisterEvent("UNIT_SPELLCAST_SENT");
    HealBot:UnregisterEvent("INSPECT_READY");
    HealBot:UnregisterEvent("CHARACTER_POINTS_CHANGED");
    HealBot:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
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

function HealBot_Reset_Full()
    HealBot_luVars["Loaded"]=false
    HealBot_UnRegister_Events()
    HealBot_Panel_ClearBlackList()
    HealBot_Panel_ClearHealTargets()
    HealBot_Action_ResethbInitButtons()
    HealBot_EndAggro()  
    HealBot_Timers_Set("SKINS","AllFramesChanged")
    HealBot_Timers_Set("LAST","ZoneUpdate")
    HealBot_Timers_AuraReset()
    HealBot_Register_Events()
    HealBot_Options_SaveProfile()
    HealBot_Timers_Set("INIT","AddonLoaded")
      --HealBot_setCall("HealBot_Reset_Full")
end

function HealBot_Reset_Quick()
    HealBot_Aura_ClearAllBuffs()
    HealBot_Aura_ClearAllDebuffs()
    HealBot_Timers_Set("SKINS","AllFramesChanged")
end

local idGUID,idUnit,idButton,pidButton,eidButton=false,false,false,false,false
function HealBot_UnitID(unit, incEnemy)
    if UnitIsUnit(unit, "player") then
        if HealBot_Unit_Button[HealBot_Data["PUNIT"]] or HealBot_Private_Button[HealBot_Data["PUNIT"]] then
            unit=HealBot_Data["PUNIT"]
        end
        idButton=HealBot_Unit_Button[unit] or HealBot_Unit_Button["player"]
        pidButton=HealBot_Private_Button[unit] or HealBot_Private_Button["player"]
    else
        idButton=HealBot_Unit_Button[unit] or HealBot_Pet_Button[unit] or HealBot_Extra_Button[unit] or HealBot_Vehicle_Button[unit]
        pidButton=HealBot_Private_Button[unit]
    end
    if idButton or pidButton then
        return unit, idButton, pidButton
    end
    idUnit=HealBot_Panel_RaidUnitGUID(UnitGUID(unit) or "x")
    if idUnit and UnitIsUnit(unit,idUnit) then
        if HealBot_Unit_Button[idUnit] or HealBot_Private_Button[idUnit] then
            return idUnit, HealBot_Unit_Button[idUnit], HealBot_Private_Button[idUnit]
        elseif HealBot_Pet_Button[idUnit] then
            return idUnit, HealBot_Pet_Button[idUnit], false
        elseif HealBot_Vehicle_Button[idUnit] then
            return idUnit, HealBot_Vehicle_Button[idUnit], false
        end
    elseif incEnemy and HealBot_Enemy_Button[unit] then
        return unit, HealBot_Enemy_Button[unit], false
    end
      --HealBot_setCall("HealBot_UnitID")
    return false,false,false
end

function HealBot_OverHealText(button)
    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["OVERHEAL"]>1 then
        if button.status.current<HealBot_Unit_Status["ENABLEDOOR"] or button.status.current>HealBot_Unit_Status["PLUGINBARCOL"] or button.status.range<1 then
            button.health.overheal=0
        end
        HealBot_Text_setOverHealText(button)
    end
end

local hiuOverHeal,hiuPlayerInHeal=0
function HealBot_OverHeal(button)
    if HealBot_luVars["overhealUnit"]==button.unit then
        hiuPlayerInHeal=UnitGetIncomingHeals(button.unit, "player") or 0
        hiuOverHeal=(button.health.current+hiuPlayerInHeal)-button.health.max
        if hiuOverHeal<1 then hiuOverHeal=0 end
    elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["OVERHEAL"]==3 then
        hiuOverHeal=(button.health.current+button.health.auxincoming)-button.health.max
        if hiuOverHeal<1 then hiuOverHeal=0 end
    else
        hiuOverHeal=0
    end
    if button.health.overheal~=hiuOverHeal then
        button.health.overheal=hiuOverHeal
        button.health.auxoverheal=hiuOverHeal
        HealBot_OverHealText(button)
        HealBot_Aux_UpdateOverHealBar(button)
    end
      --HealBot_setCall("HealBot_OverHeal")
end

local hiuHealAmount=0
function HealBot_HealsInEnemyUpdate(button)
    button.health.updincoming=true
end

function HealBot_HealsInAmountV1(button)
    if button.status.current<HealBot_Unit_Status["DEAD"] then
        hiuHealAmount=(libCHC:GetHealAmount(button.guid, libCHC.ALL_HEALS, TimeNow+HealBot_Globals.ClassicHoTTime) or 0) * (libCHC:GetHealModifier(button.guid) or 1)
        --hiuHealAmount=(libCHC:GetHealAmount(button.guid, libCHC.HOT_HEALS) or 0) * (libCHC:GetHealModifier(button.guid) or 1)
        --hiuHealAmount=hiuHealAmount+(UnitGetIncomingHeals(button.unit) or 0)
    else
        hiuHealAmount=0
    end
end

function HealBot_HealsInAmountV4(button)
    if button.status.current<HealBot_Unit_Status["DEAD"] then
        hiuHealAmount=(UnitGetIncomingHeals(button.unit) or 0)
    else
        hiuHealAmount=0
    end
end

local HealBot_HealsInAmount=HealBot_HealsInAmountV4
if HEALBOT_GAME_VERSION<4 and libCHC then
    HealBot_HealsInAmount=HealBot_HealsInAmountV1
end

function HealBot_OnEvent_HealsInUpdate(button)
    button.health.updincoming=false
    HealBot_HealsInAmount(button)
    if button.status.current<HealBot_Unit_Status["DEAD"] and button.status.range>-1 then
        if button.health.incoming~=hiuHealAmount or (hiuHealAmount==0 and button.gref["InHeal"]:GetValue()>0) then
            button.health.incoming=hiuHealAmount
            HealBot_Action_UpdateHealsInButton(button)
            HealBot_Text_setInHealAbsorbsText(button)
        end
    elseif button.health.incoming>0 or button.gref["InHeal"]:GetValue()>0 then
        button.health.incoming=0
        HealBot_Text_setInHealAbsorbsText(button)
        button.gref["InHeal"]:SetValue(0)
        button.health.inheala=0
        HealBot_Action_UpdateInHealStatusBarColor(button)
    end
    button.health.auxincoming=hiuHealAmount
    HealBot_OverHeal(button)
    HealBot_Aux_UpdateHealInBar(button)
      --HealBot_setCall("HealBot_OnEvent_HealsInUpdate")
end

function HealBotClassic_HealsInDoUpdate(button)
    HealBot_OnEvent_HealsInUpdate(button)
    HealBot_OnEvent_AbsorbsUpdate(button)
end

local chiTargetGUID=false
function HealBotClassic_HealsInUpdate(spellId, ...)
    for i=1, select("#", ...) do
        chiTargetGUID = select(i, ...)
        if chiTargetGUID and HealBot_Panel_AllUnitGUID(chiTargetGUID) then
            xUnit,xButton,pButton = HealBot_UnitID(HealBot_Panel_AllUnitGUID(chiTargetGUID))
            if xUnit and HealBot_Extra_Button["target"] and xUnit~="target" and UnitExists("target") and UnitIsUnit("target", xUnit) then
                HealBotClassic_HealsInDoUpdate(HealBot_Extra_Button["target"])
            end
            if xButton then HealBotClassic_HealsInDoUpdate(xButton) end
            if pButton then HealBotClassic_HealsInDoUpdate(pButton) end
        end
    end
end

local abuAbsorbAmount=0
function HealBot_AbsorbsEnemyUpdate(button)
    button.health.updabsorbs=true
end

function HealBot_Classic_AbsorbsUpdate(button, amount)
    if button.health.absorbs>0 then 
        button.health.absorbs=button.health.absorbs-amount
        if button.health.absorbs<0 then button.health.absorbs=0 end
        button.health.auxabsorbs=button.health.absorbs
        HealBot_Action_UpdateAbsorbsButton(button)
        HealBot_Text_setInHealAbsorbsText(button)
        HealBot_Aux_UpdateAbsorbBar(button)
    end
end

function HealBot_AbsorbsAmountV1(button)
    if button.status.current>HealBot_Unit_Status["PLUGINBARCOL"] then
        button.health.auraabsorbs=0
    end
    abuAbsorbAmount=button.health.auraabsorbs
end

function HealBot_AbsorbsAmountV5(button)
    if button.status.current<HealBot_Unit_Status["DEAD"]  then
        abuAbsorbAmount=(UnitGetTotalAbsorbs(button.unit) or 0)
    else
        abuAbsorbAmount=0
    end
end

local HealBot_AbsorbsAmount=HealBot_AbsorbsAmountV1
if HEALBOT_GAME_VERSION>4 then
    HealBot_AbsorbsAmount=HealBot_AbsorbsAmountV5
end

function HealBot_OnEvent_AbsorbsUpdate(button)
    button.health.updabsorbs=false
    HealBot_AbsorbsAmount(button)
    if button.status.current<HealBot_Unit_Status["DEAD"] and button.status.range>-1 then
        if button.health.absorbs~=abuAbsorbAmount or (abuAbsorbAmount==0 and button.gref["Absorb"]:GetValue()>0) then
            button.health.absorbs=abuAbsorbAmount
            button.health.absorbspctc=floor((button.health.absorbs/button.health.max)*1000)
            HealBot_Action_UpdateHealthHotBar(button)
            HealBot_Action_UpdateAbsorbsButton(button)
            HealBot_Text_setInHealAbsorbsText(button)
        end
    elseif button.health.absorbs>0 or button.gref["Absorb"]:GetValue()>0 then
        button.health.absorbs=0
        button.health.absorbspctc=0
        HealBot_Text_setInHealAbsorbsText(button)
        button.health.absorba=0
        button.gref["Absorb"]:SetValue(0)
        HealBot_Action_UpdateAbsorbStatusBarColor(button)
    end
    button.health.auxabsorbs=abuAbsorbAmount
    HealBot_Aux_UpdateAbsorbBar(button)
      --HealBot_setCall("HealBot_OnEvent_AbsorbsUpdate")
end

function HealBot_ResetCustomDebuffs()
    HealBot_Globals.HealBot_Custom_Debuffs=HealBot_Options_copyTable(HealBot_GlobalsDefaults.HealBot_Custom_Debuffs)
    HealBot_Globals.Custom_Debuff_Categories=HealBot_Options_copyTable(HealBot_GlobalsDefaults.Custom_Debuff_Categories)
    HealBot_Globals.FilterCustomDebuff=HealBot_Options_copyTable(HealBot_GlobalsDefaults.FilterCustomDebuff)
    HealBot_Globals.CDCBarColour=HealBot_Options_copyTable(HealBot_GlobalsDefaults.CDCBarColour)
    HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol=HealBot_Options_copyTable(HealBot_GlobalsDefaults.HealBot_Custom_Debuffs_ShowBarCol)
    HealBot_Globals.IgnoreCustomDebuff=HealBot_Options_copyTable(HealBot_GlobalsDefaults.IgnoreCustomDebuff)
    HealBot_Options_NewCDebuff:SetText("")
    HealBot_Options_ResetUpdate()
    HealBot_SetCDCBarColours();
    HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_CONFIRMCUSTOMDEFAULTS)
    HealBot_Aura_ClearCustomDebuffsDone()
      --HealBot_setCall("HealBot_ResetCustomDebuffs")
end

function HealBot_ResetSkins()
    HealBot_Include_Skin(HEALBOT_OPTIONS_GROUPHEALS, true)
    HealBot_Include_Skin(HEALBOT_OPTIONS_RAID25, true)
    HealBot_Include_Skin(HEALBOT_OPTIONS_RAID40, true)
    HealBot_Include_Skin(HEALBOT_SKINS_STD, false)
    HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_CONFIRMSKINDEFAULTS)
    HealBot_Update_Skins()
      --HealBot_setCall("HealBot_ResetSkins")
end

function HealBot_Reset_Button(button)
    button.status.change=true
    button.status.update=true
    if HealBot_Action_AlwaysEnabled(button.guid) then HealBot_Action_Toggle_Enabled(button.unit); end
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
        button.health.auxincoming=0
        button.health.overheal=0
        button.health.auxoverheal=0
        HealBot_Aux_UpdateOverHealBar(button)
        HealBot_Action_UpdateHealsInButton(button)
        HealBot_Aux_UpdateHealInBar(button)
    end
    if button.health.absorbs>0 then
        button.health.absorbs=0
        button.health.auxabsorbs=0
        HealBot_Action_UpdateAbsorbsButton(button)
        HealBot_Aux_UpdateAbsorbBar(button)
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

function HealBot_OnLoad()
    HealBot:RegisterEvent("VARIABLES_LOADED");
    HealBot:RegisterEvent("ADDON_LOADED");
    HealBot:RegisterEvent("PLAYER_REGEN_DISABLED");
    HealBot:RegisterEvent("PLAYER_REGEN_ENABLED");
    SLASH_HEALBOT1 = "/healbot";
    SLASH_HEALBOT2 = "/hb";
    SlashCmdList["HEALBOT"] = function(msg)
        HealBot_SlashCmd(msg);
    end
      --HealBot_setCall("HealBot_OnLoad")
end

local prevCPU,prevCPUadj=0,99
function HealBot_Update_CPUUsage()
    prevCPU=HealBot_Globals.CPUUsage
    HealBot_luVars["FPS"][0]=ceil((HealBot_luVars["FPS"][1][0]+HealBot_luVars["FPS"][2][0]+HealBot_luVars["FPS"][3][0])/3) 
    if HealBot_luVars["CPUProfilerOn"] then
        if HealBot_luVars["FPS"][0]<20 then
            HealBot_Globals.CPUUsage=1
        elseif HealBot_luVars["FPS"][0]<40 then
            HealBot_Globals.CPUUsage=2
        elseif HealBot_luVars["FPS"][0]<70 then
            HealBot_Globals.CPUUsage=3
        else
            HealBot_Globals.CPUUsage=4
        end
        if HealBot_luVars["CPUProfilerOn"] and not HealBot_luVars["warnCPUProfiler"] then
            HealBot_AddDebug("CPUUsage="..HealBot_Globals.CPUUsage.." CPU profiler running", "Perf", true)
            HealBot_AddChat("WARNING: CPU profiler is running - FPS might be reduced.")
            HealBot_luVars["warnCPUProfiler"]=true
        end
    elseif HealBot_Globals.FPS~=HealBot_luVars["FPS"][0] or HealBot_luVars["cpuAdj"]~=prevCPUadj then
        prevCPUadj=HealBot_luVars["cpuAdj"]
        HealBot_Globals.FPS=HealBot_luVars["FPS"][0]
        if HealBot_Globals.FPS<10 then
            HealBot_Globals.CPUUsage=1
        elseif HealBot_Globals.FPS<20 then
            HealBot_Globals.CPUUsage=2
        elseif HealBot_Globals.FPS<30 then
            HealBot_Globals.CPUUsage=3
        elseif HealBot_Globals.FPS<40 then
            HealBot_Globals.CPUUsage=4
        elseif HealBot_Globals.FPS<55 then
            HealBot_Globals.CPUUsage=5
        elseif HealBot_Globals.FPS<70 then
            HealBot_Globals.CPUUsage=6
        elseif HealBot_Globals.FPS<85 then
            HealBot_Globals.CPUUsage=7
        elseif HealBot_Globals.FPS<100 then
            HealBot_Globals.CPUUsage=8
        else
            HealBot_Globals.CPUUsage=9
        end
        HealBot_Globals.CPUUsage=HealBot_Globals.CPUUsage+HealBot_luVars["cpuAdj"]
        if HealBot_Globals.CPUUsage<1 then 
            HealBot_Globals.CPUUsage=1
        elseif HealBot_Globals.CPUUsage>14 then
            HealBot_Globals.CPUUsage=14
        end
    end
    if prevCPU~=HealBot_Globals.CPUUsage then
        HealBot_AddDebug("CPUUsage="..HealBot_Globals.CPUUsage, "Perf", true)
        HealBot_Comms_PerfLevel(hbLTfps[HealBot_Globals.CPUUsage])
        HealBot_Timers_Set("SKINS","FluidFlashInUse")
        HealBot_Timers_Set("LAST","UpdateMaxUnitsAdj")
    end
end

function HealBot_UpdateMaxUnitsAdj()
    HealBot_luVars["UpdateMaxUnits"]=HealBot_Globals.CPUUsage-1
    if HealBot_luVars["UpdateMaxUnits"]<2 then
        HealBot_luVars["UpdateMaxUnits"]=2
    elseif HealBot_luVars["UpdateMaxUnits"]>7 then
        HealBot_luVars["UpdateMaxUnits"]=7
    end
    HealBot_UpdateNumUnits()
    HealBot_luVars["MaxFastQueue"]=(HealBot_Globals.CPUUsage*2)-2
    if HealBot_luVars["MaxFastQueue"]<5 then
        HealBot_luVars["MaxFastQueue"]=5
    elseif HealBot_luVars["MaxFastQueue"]>15 then 
        HealBot_luVars["MaxFastQueue"]=15
    end
    HealBot_Timers_TurboOff()
    HealBot_AddDebug("UpdateMaxUnits="..HealBot_luVars["UpdateMaxUnits"], "Perf", true)
    HealBot_AddDebug("MaxFastQueue="..HealBot_luVars["MaxFastQueue"], "Perf", true)
end

function HealBot_UpdateNumUnits()
    HealBot_luVars["UpdateNumUnits"]=ceil(#HealBot_UpdateQueue/4)
    if HealBot_luVars["UpdateNumUnits"]>HealBot_luVars["UpdateMaxUnits"] then
        HealBot_luVars["UpdateNumUnits"]=HealBot_luVars["UpdateMaxUnits"]
    end
end

function HealBot_PerfPlugin_adj(cpuAdj)
    HealBot_luVars["cpuAdj"]=cpuAdj
    HealBot_luVars["rangeCheckAdj"]=0.5-(cpuAdj/20)
    HealBot_Update_CPUUsage()
    HealBot_Timers_Set("LAST","UpdateMaxUnitsAdj")
end

local fpsRow,fpsCol=1,1
function HealBot_Set_FPS()
    if HealBot_luVars["qaFRNext"]<TimeNow then
        local fpsCurRate=GetFramerate()
        if fpsCurRate>150 then fpsCurRate=150 end
        if fpsCurRate<18 then fpsCurRate=18 end
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

function HealBot_runOptions_Timer(value)
    if value==3100 then
        HealBot_Plugin_Threat_TogglePanel()
    elseif value==3200 then
        HealBot_Plugin_TimeToDie_TogglePanel()
    elseif value==3300 then
        HealBot_Plugin_TimeToLive_TogglePanel()
    elseif value==3600 then
        HealBot_Plugin_ExtraButtons_Options_Timer()
    end
end

HealBot_luVars["WarnOutOfDatePlugin"]=0
HealBot_luVars["IncOutOfDateDelay"]=0.7
function HealBot_setOptions_Timer(value)
    if HealBot_luVars["WarnOutOfDatePlugin"]<TimeNow then
        HealBot_luVars["WarnOutOfDatePlugin"]=TimeNow+1
        HealBot_AddChat(HEALBOT_HEALBOT .. " " .. _G["ORANGE_FONT_COLOR_CODE"] .. "WARNING: Out of date plugin requires update.")
        C_Timer.After(0.7, function() HealBot_runOptions_Timer(value) end)
        HealBot_luVars["IncOutOfDateDelay"]=0.7
    else
        HealBot_luVars["IncOutOfDateDelay"]=HealBot_luVars["IncOutOfDateDelay"]+0.05
        C_Timer.After(HealBot_luVars["IncOutOfDateDelay"], function() HealBot_runOptions_Timer(value) end)
    end
end

function HealBot_Include_Skin(skinName, internal)
    if not Healbot_Config_Skins.Author[skinName] and HealBot_Config_SkinsData[skinName] then
        HealBot_Share_SkinLoad(HealBot_Config_SkinsData[skinName], internal)
    end
end

function HealBot_UpdateBuffItem(buff, item)
    if buff and item then
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
end

function HealBot_Update_Skins()
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
        HealBot_Options_Set_Current_Skin(retryWithSkin, nil, true, true)
    end
    if HealBot_Globals.CacheSize then HealBot_Globals.CacheSize=nil end
    if not HealBot_Globals.AutoCacheSize then HealBot_Globals.AutoCacheSize=25 end

    local tMajor, tMinor, tPatch, tHealbot = string.split(".", HealBot_Globals.LastVersionSkinUpdate)
    if not HealBot_luVars["ResetOld"] and tonumber(tMajor)<9 or (tonumber(tMajor)==9 and tonumber(tMinor)<2) or (tonumber(tMajor)==9 and tonumber(tMinor)==2 and tonumber(tPatch)<5) then
        HealBot_luVars["ResetOld"]=true
        HealBot_Options_SetDefaults(true);
    else
        HealBot_AddDebug("In HealBot_Update_Skins version="..HealBot_Globals.LastVersionSkinUpdate)
        if HealBot_Globals.LastVersionSkinUpdate~=HealBot_Global_Version() then
            HealBot_Globals.OneTimeMsg["VERSION"]=false
        end
        for x in pairs (Healbot_Config_Skins.Skins) do
            HealBot_Skins_Check_Skin(Healbot_Config_Skins.Skins[x])
        end
        if tonumber(tMajor)==9 then
            if not HealBot_Globals.OverrideEffects["FGDIMMING"] then HealBot_Globals.OverrideEffects["FGDIMMING"]=2.5 end
            if HealBot_Globals.OverrideEffects["HEALTHDROP"]==nil then HealBot_Globals.OverrideEffects["HEALTHDROP"]=false end
            if not HealBot_Globals.OverrideEffects["HEALTHDROPPCT"] then HealBot_Globals.OverrideEffects["HEALTHDROPPCT"]=350 end
            if not HealBot_Globals.OverrideEffects["HEALTHDROPSPEED"] then HealBot_Globals.OverrideEffects["HEALTHDROPSPEED"]=40 end
            if not HealBot_Globals.OverrideEffects["HOTBARHLTH"] then HealBot_Globals.OverrideEffects["HOTBARHLTH"]=0 end
            if not HealBot_Globals.OverrideEffects["HOTBARDEBUFF"] then HealBot_Globals.OverrideEffects["HOTBARDEBUFF"]=1 end
            if not HealBot_Globals.OverrideEffects["HBDIMMING"] then HealBot_Globals.OverrideEffects["HBDIMMING"]=2.2 end
            if HealBot_Globals.OverrideEffects["FLUIDALPHA"]==nil then HealBot_Globals.OverrideEffects["FLUIDALPHA"]=false end
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
            for dId, x in pairs(HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol) do
                if not HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[dId] then
                    HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[dId]=1
                elseif HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[dId]==true then
                    HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[dId]=3
                end
            end
            for bId, x in pairs(HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol) do
                if not HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[bId] then
                    HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[bId]=1
                elseif HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[bId]==true then
                    HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[bId]=3
                end
            end
            HealBot_Globals.ResLagDuration=nil

            if HEALBOT_GAME_VERSION==3 and not HealBot_Config.InitWotLKSpells then
                HealBot_Config.InitWotLKSpells=true
                HealBot_Copy_SpellCombos()
            end
            
            if HealBot_Globals.HealBot_Emotes then HealBot_Globals.HealBot_Emotes=nil end
            HealBot_Globals.Tooltip_MouseWheel=nil
            if HealBot_Config.MacroUse10==1 then
                HealBot_Config.MacroUse10=true
            elseif HealBot_Config.MacroUse10==0 then
                HealBot_Config.MacroUse10=false
            end
            if HealBot_Globals.MacroSuppressSound==1 then
                HealBot_Globals.MacroSuppressSound=true
            elseif HealBot_Globals.MacroSuppressSound==0 then
                HealBot_Globals.MacroSuppressSound=false
            end
            if HealBot_Globals.MacroSuppressError==1 then
                HealBot_Globals.MacroSuppressError=true
            elseif HealBot_Globals.MacroSuppressError==0 then
                HealBot_Globals.MacroSuppressError=false
            end
            HealBot_Globals.CatchAltDebuffIDs=nil
            local hbClassHoTwatch=HealBot_Globals.WatchHoT
            for xClass,_  in pairs(hbClassHoTwatch) do
                local HealBot_configClassHoTClass=HealBot_Globals.WatchHoT[xClass]
                for id,x  in pairs(HealBot_configClassHoTClass) do
                    if HealBot_configClassHoTClass[id]==4 then HealBot_configClassHoTClass[id]=3 end
                end
            end
            HealBot_Options_ResetSetting("ICONS")
        end
        if tonumber(tMajor)==10 and tonumber(tMinor)==0 and tonumber(tPatch)==0 and tonumber(tHealbot)<4 then
            if HealBot_Globals.Tooltip_SetScale==false then 
                HealBot_Globals.Tooltip_Scale=1
                HealBot_Globals.Tooltip_SetScale=nil
            end
            if HealBot_Globals.Tooltip_SetAlpha==false then 
                HealBot_Globals.Tooltip_Alpha=1
                HealBot_Globals.Tooltip_SetAlpha=nil
            else
                HealBot_Globals.Tooltip_Alpha=HealBot_Globals.Tooltip_SetAlphaValue or 1
            end
        end
        if not HealBot_Globals.WatchHoT["EVOK"] then HealBot_Globals.WatchHoT["EVOK"]={} end
        if not HealBot_Globals.WatchHoT["EVOK"][HEALBOT_REVERSION] then
            local HealBot_EvokHoTClass=HealBot_GlobalsDefaults.WatchHoT["EVOK"]
            for id,x  in pairs(HealBot_EvokHoTClass) do
                HealBot_Globals.WatchHoT["EVOK"][id]=x
            end
        end    
    end
    tMajor, tMinor, tPatch, tHealbot = string.split(".", HealBot_Config.LastVersionUpdate)
    if HealBot_Config.LastVersionUpdate~=HealBot_Global_Version() then 
        if HealBot_Config.ActionVisible then HealBot_Config.ActionVisible=nil end
        if HealBot_Config.CrashProtMacroName or HealBot_Globals.OverrideProt then 
            HealBot_Options_DeleteAllCpMacros()
            HealBot_Config.CrashProtMacroName=nil 
            HealBot_Globals.OverrideProt=nil
        end
        if HealBot_Config.CrashProtStartTime then HealBot_Config.CrashProtStartTime=nil end
        -- Character specific checks
    end
    HealBot_Globals.LastVersionSkinUpdate=HealBot_Global_Version()
    HealBot_Config.LastVersionUpdate=HealBot_Global_Version()
      --HealBot_setCall("HealBot_Update_Skins")
end

function HealBot_setTooltipUpdateInterval()
    if not HealBot_Data["TIPUSE"] then
        HealBot_luVars["TipUpdateFreq"]=900
    elseif HealBot_Globals.Tooltip_ShowCD then
        HealBot_luVars["TipUpdateFreq"]=0.95
    else
        HealBot_luVars["TipUpdateFreq"]=5
    end
      --HealBot_setCall("HealBot_setTooltipUpdateInterval")
end

function HealBot_SetPlayerData()
    local pClass, pClassEN=UnitClass("player")
    HealBot_Data["PCLASSTRIM"]=strsub(pClassEN,1,4)
    HealBot_Data["PLEVEL"]=UnitLevel("player")
    local pRace, pRaceEN=UnitRace("player")
    HealBot_Data["PRACE_EN"]=pRaceEN
    if UnitIsDeadOrGhost("player") and not UnitIsFeignDeath("player") then 
        HealBot_Data["PALIVE"]=false
    else
        HealBot_Data["PALIVE"]=true
    end
    HealBot_Data["PGUID"]=UnitGUID("player")
end

function HealBot_OnEvent_AddOnLoaded(addonName, reset)
    if addonName=="HealBot" and not HealBot_luVars["AddonLoaded"] then
        HealBot_globalVars()
        HealBot_Lang_InitVars()
        HealBot_Data_InitVars()
        HealBot_Panel_Init()
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
        HealBot_Action_InitFrames()
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
        for x=1,3 do
            for z=0,3 do
                HealBot_luVars["FPS"][x][z]=HealBot_Globals.FPS
            end
        end
        HealBot_luVars["FPS"][0]=HealBot_Globals.FPS
        HealBot_Options_setClassEn()
        HealBot_Options_setLists()
        HealBot_customTempUserName=HealBot_Options_copyTable(HealBot_Globals.HealBot_customPermUserName)
        HealBot_luVars["RunDate"]=tonumber(date("%y%m%d"))
        if HealBot_Globals.AutoCacheSize>25 and (HealBot_Globals.AutoCacheTime or 0)<HealBot_luVars["RunDate"] then
            HealBot_Globals.AutoCacheSize=HealBot_Globals.AutoCacheSize-1
            HealBot_Globals.AutoCacheTime=HealBot_luVars["RunDate"]
        end
        C_ChatInfo.RegisterAddonMessagePrefix(HEALBOT_HEALBOT)
        HealBot_Options_ObjectsEnableDisable("HealBot_FrameStickyOffsetHorizontal",false)
        HealBot_Options_ObjectsEnableDisable("HealBot_FrameStickyOffsetVertical",false)
        HealBot_Options_ObjectsEnableDisable("HealBot_Options_GroupPetsByFive",false)
        HealBot_Options_ObjectsEnableDisable("HealBot_Options_SelfPet",false)
        HealBot_setTooltipUpdateInterval()
        HealBot_Panel_InitOptBars()
        HealBot_luVars["AddonLoaded"]=true
    end
end

HealBot_luVars["WaitedOnAddonLoaded"]=false
function HealBot_OnEvent_VariablesLoaded()
    if HealBot_luVars["AddonLoaded"] then
        C_Timer.After(0.2, HealBot_VariablesLoaded)
    elseif not HealBot_luVars["WaitedOnAddonLoaded"] then
        HealBot_luVars["WaitedOnAddonLoaded"]=true
        C_Timer.After(0.5, HealBot_OnEvent_VariablesLoaded)
    else
        C_Timer.After(1, HealBot_FullReload)
    end
end

function HealBot_VariablesLoaded()
    if LSM then
        for i = 1, #HealBot_Default_Textures do
            LSM:Register("statusbar", HealBot_Default_Textures[i].name, HealBot_Default_Textures[i].file)
        end
        for i = 1, #HealBot_Default_Sounds do
            LSM:Register("sound", HealBot_Default_Sounds[i].name, HealBot_Default_Sounds[i].file)
        end
        for i = 1, #HealBot_Default_Fonts do
            LSM:Register("font", HealBot_Default_Fonts[i].name, HealBot_Default_Fonts[i].file)
        end
    end
    HealBot_globalVars()
    HealBot_Lang_InitVars()
    HealBot_Data_InitVars()
    HealBot_SetPlayerData()
    if HealBot_Globals.FirstLoad then
        HealBot_Include_Skin(HEALBOT_OPTIONS_GROUPHEALS, true)
        HealBot_Include_Skin(HEALBOT_OPTIONS_RAID25, true)
        HealBot_Include_Skin(HEALBOT_OPTIONS_RAID40, true)
    end
    HealBot_Include_Skin(HEALBOT_SKINS_STD, true)
    HealBot_Update_Skins()
    HealBot_Config.LastAutoSkinChangeTime=0
    HealBot_luVars["CPUProfilerOn"]=GetCVarBool("scriptProfile")
    HealBot_Options_InitVars()
    HealBot_Action_InitCacheButtons()
    HealBot_Panel_SethbTopRole(HealBot_Globals.TopRole)
    HealBot_Options_IgnoreDebuffsDuration_setAura()
    HealBot_Timers_ToggleBlizzardFrames()
    HealBot_Text_sethbNumberFormat()
    HealBot_Text_sethbAggroNumberFormat()
    HealBot_Options_SetFrames()
    HealBot_Init_ClassicSpecs()
    HealBot_Timers_Set("AURA","SetIconUpdateInterval")
    HealBot_Timers_Set("LAST","SetAutoClose", 12)
    HealBot_Timers_Set("LAST","LoadTips")
    HealBot_Load()
      --HealBot_setCall("HealBot_OnEvent_VariablesLoaded")
end

function HealBot_OnEvent_ItemInfoReceived(self, itemId)
    HealBot_luVars["ItemDataReady"]=true
    HealBot_Timers_Set("PLAYER","InitSmartCast",1)
end

function HealBot_CheckLowMana()
    for _,xButton in pairs(HealBot_Unit_Button) do
        xButton.mana.lowcheck=true
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        xButton.mana.lowcheck=true
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        xButton.mana.lowcheck=true
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        xButton.mana.lowcheck=true
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        xButton.mana.lowcheck=true
    end
      --HealBot_setCall("HealBot_CheckLowMana")
end

function HealBot_UpdateAllEmergBars()
    for _,xButton in pairs(HealBot_Unit_Button) do
        xButton.status.emergupd=true
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        xButton.status.emergupd=true
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        xButton.status.emergupd=true
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        xButton.status.emergupd=true
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        xButton.status.emergupd=true
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        xButton.status.emergupd=true
    end
      --HealBot_setCall("HealBot_CheckLowMana")
end

function HealBot_GetSpec(unit)
    local s,i=nil,nil
    if UnitExists(unit) then
        i = GetInspectSpecialization(unit)
        if i then
            _, s, _, _, _, _ = GetSpecializationInfoByID(i)
        end
    end
    return i,s
end

function HealBot_UpdateSpellsOnSpecChange(combo,maxButtons,cType)
    local button,key=nil,nil,nil,nil
    local HealBot_Keys_List=HealBot_Action_retComboKeysList()
    for z=1,maxButtons do
        button = HealBot_Options_ComboClass_Button(z)
        for y=1, getn(HealBot_Keys_List), 1 do
            newKey=HealBot_Keys_List[y]..button..(HealBot_luVars["CurrentSpec"] or 1)
            oldKey=HealBot_Keys_List[y]..button..(HealBot_Config.CurrentSpec or 1)
            if not combo[newKey] and combo[oldKey] and HealBot_Options_ProfileSpellCheck(combo[oldKey],cType) then
                combo[newKey]=combo[oldKey]
            end
        end
    end
end

function HealBot_ResetOnSpecChange()
    if HealBot_Config.CurrentSpec~=HealBot_luVars["CurrentSpec"] then
        HealBot_UpdateSpellsOnSpecChange(HealBot_Config_Spells.EnabledKeyCombo,20,"ENABLED")
        HealBot_UpdateSpellsOnSpecChange(HealBot_Config_Spells.EnemyKeyCombo,20,"ENEMY")
        HealBot_UpdateSpellsOnSpecChange(HealBot_Config_Spells.EmergKeyCombo,5,"EMERG")
        HealBot_Config.CurrentSpec=HealBot_luVars["CurrentSpec"] or 1
        if HealBot_Config.Profile==3 and HealBot_Class_Spells["GLOBAL"] then
            local globalSpells=HealBot_Class_Spells["GLOBAL"]
            HealBot_Options_hbProfile_setGlobalSpells(HealBot_Config_Spells.EnabledKeyCombo, globalSpells.EnabledKeyCombo, 20, "ENABLED")
            HealBot_Options_hbProfile_setGlobalSpells(HealBot_Config_Spells.EnemyKeyCombo, globalSpells.EnemyKeyCombo, 20, "ENEMY")
            HealBot_Options_hbProfile_setGlobalSpells(HealBot_Config_Spells.EmergKeyCombo, globalSpells.EmergKeyCombo, 5, "EMERG")
        end
    end
    HealBot_Data["PLEVEL"]=UnitLevel("player")
    HealBot_Timers_InitSpells()
    HealBot_Timers_Set("INIT","SpellsResetTabs")
    HealBot_Timers_Set("AURA","ConfigClassHoT")
    HealBot_Timers_InitExtraOptions()
    HealBot_Timers_AuraReset()
end

function HealBot_GetTalentInfo(button)
    local i,s=nil,nil
    if HEALBOT_GAME_VERSION>4 then
        if button.player then
            i = GetSpecialization()
            if i then
                _, s, _, _, _, _ = GetSpecializationInfo(i,false,false) 
            end
        elseif HealBot_luVars["inspectGUID"]==button.guid then
            i,s = HealBot_GetSpec(button.unit)
        end
    elseif HEALBOT_GAME_VERSION==3 then
        local tCount, mCount, isNotPlayer, canInspect= 0, 0, true, false
        if UnitIsUnit(button.unit, "player") then
            isNotPlayer=false
            canInspect=true
        elseif button.isplayer and UnitExists(button.unit) and CheckInteractDistance(button.unit, 1) and UnitGUID(button.unit)==button.guid and HealBot_luVars["inspectGUID"]==button.guid and CanInspect(button.unit) then
            canInspect=true
        end
        if canInspect then
            local group=GetActiveTalentGroup(isNotPlayer)
            for tab = 1, 3 do
                tCount = select(3, GetTalentTabInfo(tab,isNotPlayer,nil,group))
                if tCount > mCount then
                    i = tab
                    mCount = tCount
                end
            end
            if i then
                s=HealBot_Init_retSpec(button.text.classtrim,i)
            end
        end
    end
    if button.player then
        button.specupdate=0
        if i and HealBot_Config.CurrentSpec~=i or HealBot_Data["PLEVEL"]~=UnitLevel("player") then
            HealBot_luVars["CurrentSpec"]=i
            HealBot_Timers_Set("PLAYER","SpecUpdate",0.25)
        end
    else
        HealBot_luVars["talentUpdate"]=TimeNow
    end
    if s then
        if button.unit=="target" then
            button.spec = " "..s.." " 
            if button.mouseover and HealBot_Data["TIPBUTTON"] then HealBot_Action_RefreshTooltip() end
        elseif button.spec~=" "..s.." " then
            if HealBot_Panel_RaidUnitGUID(button.guid) then 
                HealBot_Action_setGuidSpec(button, s)
                HealBot_Comms_SendInstantAddonMsg("U:"..button.guid.."~"..s)
            else
                button.spec = " "..s.." "
            end
            HealBot_Action_setButtonManaBarCol(button)
            if button.mouseover and HealBot_Data["TIPBUTTON"] then HealBot_Action_RefreshTooltip() end
        end
    end
    HealBot_OnEvent_UnitMana(button)
      --HealBot_setCall("HealBot_GetTalentInfo")
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
        HealBot_Action_setLuVars("pluginThreat", true)
    else
        HealBot_Aggro_setLuVars("pluginThreat", false)
        HealBot_luVars["pluginThreat"]=false
        HealBot_Action_setLuVars("pluginThreat", false)
    end
    
    loaded, reason = LoadAddOn("HealBot_Plugin_TimeToDie")
    HealBot_luVars["pluginTimeToDieReason"]=reason or ""
    HealBot_luVars["pluginTimeToDieLoaded"]=loaded
    if loaded and HealBot_Globals.PluginTimeToDie then 
        HealBot_Plugin_TimeToDie_Init()
        HealBot_luVars["pluginTimeToDie"]=true
        HealBot_Action_setLuVars("pluginTimeToDie", true)
    else
        HealBot_luVars["pluginTimeToDie"]=false
        HealBot_Action_setLuVars("pluginTimeToDie", false)
    end
    
    loaded, reason = LoadAddOn("HealBot_Plugin_TimeToLive")
    HealBot_luVars["pluginTimeToLiveReason"]=reason or ""
    HealBot_luVars["pluginTimeToLiveLoaded"]=loaded
    if loaded and HealBot_Globals.PluginTimeToLive then 
        HealBot_Plugin_TimeToLive_Init()
        HealBot_luVars["pluginTimeToLive"]=true
        HealBot_Action_setLuVars("pluginTimeToLive", true)
    else
        HealBot_luVars["pluginTimeToLive"]=false
        HealBot_Action_setLuVars("pluginTimeToLive", false)
    end
        
    loaded, reason = LoadAddOn("HealBot_Plugin_ExtraButtons")
    HealBot_luVars["pluginExtraButtonsReason"]=reason or ""
    HealBot_luVars["pluginExtraButtonsLoaded"]=loaded
    if loaded and HealBot_Globals.PluginExtraButtons then 
        HealBot_luVars["pluginExtraButtons"]=true
        HealBot_Action_setLuVars("pluginExtraButtons", true)
        HealBot_Timers_Set("INIT","RegisterForClicks")
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
        HealBot_Globals.CrashProtTime=0
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
    
    loaded, reason = LoadAddOn("HealBot_Plugin_Tweaks")
    HealBot_luVars["pluginTweaksReason"]=reason or ""
    HealBot_luVars["pluginTweaksLoaded"]=loaded
    if loaded and HealBot_Globals.PluginTweaks then 
        HealBot_Plugin_Tweaks_Init()
        HealBot_luVars["pluginTweaks"]=true
    else
        HealBot_luVars["pluginTweaks"]=false
    end
    
    loaded, reason = LoadAddOn("HealBot_Plugin_Requests")
    HealBot_luVars["pluginRequestsReason"]=reason or ""
    HealBot_luVars["pluginRequestsLoaded"]=loaded
    if loaded and HealBot_Globals.PluginRequests then 
        HealBot_Plugin_Requests_Init()
        HealBot_luVars["pluginRequests"]=true
    else
        HealBot_luVars["pluginRequests"]=false
    end
    
    loaded, reason = LoadAddOn("HealBot_Plugin_BuffWatch")
    HealBot_luVars["pluginBuffWatchReason"]=reason or ""
    HealBot_luVars["pluginBuffWatchLoaded"]=loaded
    if loaded and HealBot_Globals.PluginBuffWatch then 
        HealBot_Plugin_BuffWatch_Init()
        HealBot_luVars["pluginBuffWatch"]=true
    else
        HealBot_luVars["pluginBuffWatch"]=false
    end
    
    loaded, reason = LoadAddOn("HealBot_Plugin_HealthWatch")
    HealBot_luVars["pluginHealthWatchReason"]=reason or ""
    HealBot_luVars["pluginHealthWatchLoaded"]=loaded
    if loaded and HealBot_Globals.PluginHealthWatch then 
        HealBot_Plugin_HealthWatch_Init()
        HealBot_Action_setLuVars("pluginHealthWatch", true)
        HealBot_luVars["pluginHealthWatch"]=true
    else
        HealBot_Action_setLuVars("pluginHealthWatch", false)
        HealBot_luVars["pluginHealthWatch"]=false
    end
    
    loaded, reason = LoadAddOn("HealBot_Plugin_ManaWatch")
    HealBot_luVars["pluginManaWatchReason"]=reason or ""
    HealBot_luVars["pluginManaWatchLoaded"]=loaded
    if loaded and HealBot_Globals.PluginManaWatch then 
        HealBot_Plugin_ManaWatch_Init()
        HealBot_luVars["pluginManaWatch"]=true
    else
        HealBot_luVars["pluginManaWatch"]=false
    end
    
    loaded, reason = LoadAddOn("HealBot_Plugin_MyCooldowns")
    HealBot_luVars["pluginMyCooldownsReason"]=reason or ""
    HealBot_luVars["pluginMyCooldownsLoaded"]=loaded
    if loaded and HealBot_Globals.PluginMyCooldowns then 
        HealBot_Plugin_MyCooldowns_Init()
        HealBot_luVars["pluginMyCooldowns"]=true
    else
        HealBot_luVars["pluginMyCooldowns"]=false
    end

    HealBot_Timers_Set("LAST","RegAggro")
end

function HealBot_Timer_FramesRefresh()
    if not HealBot_luVars["ProcessRefresh"] then
        HealBot_luVars["ProcessRefresh"]=true
        HealBot_ProcessRefreshTypes()
    end
end

function HealBot_Timer_TogglePartyFrames()
    if not InCombatLockdown() then
        if HealBot_luVars["HIDEPARTYF"] and HealBot_Config.DisabledNow==0 then
            HealBot_trackHiddenFrames["PARTY"]=true
            HealBot_Options_DisableEnablePartyFrame(false)
            HealBot_Options_PlayerTargetFrames:Enable()
            if HealBot_luVars["HIDEPTF"] then
                HealBot_trackHiddenFrames["PLAYER"]=true
                HealBot_Options_DisableEnablePlayerFrame(false)
                HealBot_Options_DisableEnablePetFrame(false)
                HealBot_Options_DisableEnableTargetFrame(false)
            elseif HealBot_trackHiddenFrames["PLAYER"] then 
                HealBot_trackHiddenFrames["PLAYER"]=false
                HealBot_Options_DisableEnablePlayerFrame(true)
                HealBot_Options_DisableEnablePetFrame(true)
                HealBot_Options_DisableEnableTargetFrame(true)
            end
        elseif HealBot_trackHiddenFrames["PARTY"] then
            HealBot_trackHiddenFrames["PARTY"]=false
            HealBot_Options_DisableEnablePartyFrame(true)
            HealBot_Options_PlayerTargetFrames:Disable()
            if HealBot_trackHiddenFrames["PLAYER"] then 
                HealBot_trackHiddenFrames["PLAYER"]=false
                HealBot_Options_DisableEnablePlayerFrame(true)
                HealBot_Options_DisableEnablePetFrame(true)
                HealBot_Options_DisableEnableTargetFrame(true)
            end
        end
    else
        HealBot_Timers_Set("SKINS","TogglePartyFrames")
    end
end

function HealBot_Timer_ToggleFocusFrame()
    if not InCombatLockdown() then
        if HealBot_luVars["HIDEFOCUSF"] and HealBot_Config.DisabledNow==0 then
            HealBot_trackHiddenFrames["FOCUS"]=true
            HealBot_Options_DisableEnableFocusFrame(false)
        elseif HealBot_trackHiddenFrames["FOCUS"] then
            HealBot_trackHiddenFrames["FOCUS"]=false
            HealBot_Options_DisableEnableFocusFrame(true)
        end
    else
        HealBot_Timers_Set("SKINS","ToggleFocusFrame")
    end
end

function HealBot_Timer_ToggleMiniBossFrames()
    if not InCombatLockdown() then
        if HealBot_luVars["HIDEBOSSF"] and HealBot_Config.DisabledNow==0 then
            HealBot_trackHiddenFrames["MINIBOSS"]=true
            HealBot_Options_DisableEnableMiniBossFrame(false)
        elseif HealBot_trackHiddenFrames["MINIBOSS"] then
            HealBot_trackHiddenFrames["MINIBOSS"]=false
            HealBot_Options_DisableEnableMiniBossFrame(true)
        end
    else
        HealBot_Timers_Set("SKINS","ToggleMiniBossFrames")
    end
end

function HealBot_Timer_ToggleRaidFrames()
    if not InCombatLockdown() then
        if HealBot_luVars["HIDERAIDF"] and HealBot_Config.DisabledNow==0 then
            HealBot_trackHiddenFrames["RAID"]=true
            HealBot_Options_DisableEnableRaidFrame(false)
        elseif HealBot_trackHiddenFrames["RAID"] then
            HealBot_trackHiddenFrames["RAID"]=false
            HealBot_Options_DisableEnableRaidFrame(true)
        end
    else
        HealBot_Timers_Set("SKINS","ToggleRaidFrames")
    end
end

function HealBot_CheckVersions()
    if not HealBot_luVars["GetVersions"] then HealBot_luVars["GetVersions"]=TimeNow+15 end
    HealBot_SendVersion()
    if HealBot_luVars["DoSendGuildVersion"] then
        HealBot_SendGuildVersion()
        HealBot_luVars["DoSendGuildVersion"]=false
    end
end

function HealBot_SendVersion()
    if not HealBot_luVars["SendVersion"] then HealBot_luVars["SendVersion"]=TimeNow+5 end
end

function HealBot_SendGuildVersion()
    if not HealBot_luVars["SendGuildVersion"] then HealBot_luVars["SendGuildVersion"]=TimeNow+5 end
end

function HealBot_Timer_ZoneUpdate()
    local inInst,inType = IsInInstance()
    if inInst==nil then inInst=false end
    if HealBot_luVars["InInstance"]~=inInst then
        HealBot_luVars["InInstance"]=inInst
        HealBot_Timers_Set("LAST","CheckVersions",5)
        if HealBot_Config_Buffs.ExtraBuffsOnlyInInstance then
            HealBot_Timers_Set("LAST","InitItemsData")
        end
    end
        
    local mapAreaID = C_Map.GetBestMapForUnit("player")
    local mapName=HEALBOT_WORD_OUTSIDE
    if mapAreaID and mapAreaID>0 then
        mapName=C_Map.GetMapInfo(mapAreaID).name or mapName
        if mapAreaID==662 then 
            HealBot_luVars["adjMaxHealth"]=mapAreaID 
        else
            HealBot_luVars["adjMaxHealth"]=0
        end
    elseif inType and inType=="arena" then 
        mapName="Arena"
    end
    if HealBot_luVars["mapName"]~=mapName then
        HealBot_luVars["mapName"]=mapName
        HealBot_Aura_setLuVars("mapName", mapName)
        HealBot_Options_setLuVars("mapName", mapName)
        HealBot_Options_SetEnableDisableCDBtn()
        HealBot_Options_SetEnableDisableBuffBtn()
        HealBot_Timers_Set("SKINS","PartyUpdateCheckSkin")
    end
    HealBot_Panel_setLuVars("MAPID", mapAreaID)
    HealBot_Timers_Set("PLAYER","PlayerCheck")
end

function HealBot_Timer_EmoteOOM()
    if HealBot_luVars["NoSpamOOM"]<TimeNow and 
      (((UnitPower("player", 0)/UnitPowerMax("player", 0))*100) < HealBot_luVars["EOCOOMV"]) then
        HealBot_luVars["NoSpamOOM"]=TimeNow+15
        DoEmote(HEALBOT_EMOTE_OOM)
    end
end

function HealBot_NoVehicle(unit)
    local HBvUnits=HealBot_VehicleUnit[unit]
    for xUnit,_ in pairs(HBvUnits) do
        if HealBot_UnitInVehicle[xUnit] then HealBot_UnitInVehicle[xUnit]=nil end
    end
    if HealBot_VehicleUnit[unit] then HealBot_VehicleUnit[unit]=nil end
      --HealBot_setCall("HealBot_NoVehicle")
end

local hbCombatState=false
function HealBot_UnitAffectingCombat(button)
    if button.isplayer and Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWCOMBAT"] then
        hbCombatState=UnitAffectingCombat(button.unit)
    else
        hbCombatState=false
    end
    if button.status.incombat~=hbCombatState then
        button.status.incombat=hbCombatState
        HealBot_Aura_UpdateState(button)
    end
end

function HealBot_ValidLivingEnemy(pUnit, eUnit)
    if UnitExists(pUnit) and UnitExists(eUnit) and not UnitIsFriend("player", eUnit) and UnitHealthMax(eUnit)>99 and
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

function HealBot_Clear_HealthDropAuxBar(button)
    if button.status.lasthealthdrop<TimeNow then
        HealBot_Aux_ClearHealthDropBar(button)
        if HealBot_AuxAssigns["NameOverlayHealthDrop"][button.frame] then
            HealBot_Aux_UpdateNameOverLay(button, 2, false)
        end
        if HealBot_AuxAssigns["HealthOverlayHealthDrop"][button.frame] then
            HealBot_Aux_UpdateHealthOverLay(button, 2, false)
        end
    else
        C_Timer.After((button.status.lasthealthdrop-TimeNow)+0.05, function() HealBot_Clear_HealthDropAuxBar(button) end)
    end
end

function HealBot_Update_HealthDropAuxBar(button)
    HealBot_luVars["HealthDropBarSetCTimerSet"]=false
    if HealBot_AuxAssigns["HealthDrop"][button.frame] then
        if button.status.lasthealthdrop<TimeNow then
            HealBot_Aux_UpdateHealthDropBar(button)
            HealBot_luVars["HealthDropBarSetCTimerSet"]=true
        end
    end
    if HealBot_AuxAssigns["NameOverlayHealthDrop"][button.frame] then
        if button.status.lasthealthdrop<TimeNow then
            HealBot_Aux_UpdateNameOverLay(button, 2, true)
            HealBot_luVars["HealthDropBarSetCTimerSet"]=true
        end
    end
    if HealBot_AuxAssigns["HealthOverlayHealthDrop"][button.frame] then
        if button.status.lasthealthdrop<TimeNow then
            HealBot_Aux_UpdateHealthOverLay(button, 2, true)
            HealBot_luVars["HealthDropBarSetCTimerSet"]=true
        end
    end
    
    if HealBot_luVars["HealthDropBarSetCTimerSet"] then
        C_Timer.After(0.75, function() HealBot_Clear_HealthDropAuxBar(button) end)
    end
    button.status.lasthealthdrop=TimeNow+0.7
end

function HealBot_EnglishClass(unit)
  local playerClass, englishClass = UnitClass(unit);
  return englishClass;
end

local hbHealthWatch={}
function HealBot_HealthWatch(guid, state)
    if state then
        hbHealthWatch[guid]=true
    else
        hbHealthWatch[guid]=nil
    end
end

function HealBot_HealthWatchClear()
    hbHealthWatch={}
end

local HealBot_Health80 = {
  ["DRUID"] = 12500,
  ["MAGE"] = 11500,
  ["HUNTER"] = 12500,
  ["PALADIN"] = 17500,
  ["PRIEST"] = 11500,
  ["ROGUE"] = 12000,
  ["SHAMAN"] = 11500,
  ["WARLOCK"] = 11500,
  ["WARRIOR"] = 18000,
  ["DEATHKNIGHT"] = 18000,
} 
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
            if healthMax==0 then healthMax=1 end
        else
            health,healthMax=UnitHealth(button.unit),UnitHealthMax(button.unit)
            if health==0 then health=1 end
            if healthMax==100 and (button.unit=="target" or button.unit=="focus" or not button.isplayer) then
                local class = HealBot_EnglishClass(button.unit)
                if HealBot_Health80[class] and button.level>0 then
                    if button.level<75 then
                        healthMax=math.floor((HealBot_Health80[class]/120)*(button.level+(button.level/10)))
                    else
                        healthMax=math.floor((HealBot_Health80[class]/80)*(button.level+0.5))
                    end
                    health=floor((healthMax/100)*health)
                end
            end
        end
        if health>healthMax then healthMax=health end
        if (health~=button.health.current) or (healthMax~=button.health.max) then
            if HealBot_luVars["pluginTimeToDie"] and button.status.plugin then 
                HealBot_Plugin_TimeToDie_UnitUpdate(button, health) 
            end
            if not HealBot_Data["UILOCK"] and button.isplayer then
                if HealBot_luVars["regAggro"] and health<button.health.current then
                    HealBot_OnEvent_UnitThreat(button)
                elseif HEALBOT_GAME_VERSION==3 and not button.player and healthMax>(button.health.max*1.2) then
                    HealBot_OnEvent_SpecChange(button)
                end
            end
            if button.frame<10 and button.health.current>health and HealBot_luVars["HealthDropPct"]<=(button.health.hpct-floor((health/healthMax)*1000)) then
                if HealBot_luVars["UseHealthDrop"] then
                    HealBot_Action_HealthDropAlertBarsAlpha(button)
                end
                HealBot_Update_HealthDropAuxBar(button)
            end
            button.health.current=health
            button.health.max=healthMax
            HealBot_Action_UpdateHealthButton(button, true)
            if hbHealthWatch[button.guid] then
                HealBot_Plugin_HealthWatch_UnitUpdate(button)
            end
            if button.status.current<HealBot_Unit_Status["DEAD"] then 
                if health>0 then
                    HealBot_OverHeal(button)
                else
                    HealBot_CheckUnitStatus(button)
                end
            elseif health>0 then
                HealBot_CheckUnitStatus(button)
            end
            if button.mouseover and HealBot_Data["TIPBUTTON"] then 
                HealBot_Action_RefreshTooltip() 
            end
        end
    elseif button.health.current>0 then
        button.health.current=0
        button.status.alpha=0
        button.gref["Bar"]:SetValue(0)
        --button.health.init=true
        HealBot_OnEvent_HealsInUpdate(button)
        HealBot_OnEvent_AbsorbsUpdate(button)
        if HealBot_luVars["pluginTimeToDie"] and button.status.plugin then 
            HealBot_Plugin_TimeToDie_UnitUpdate(button, 0) 
        end
    end
    if button.health.updincoming then HealBot_OnEvent_HealsInUpdate(button) end
    if button.health.updabsorbs then HealBot_OnEvent_AbsorbsUpdate(button) end
      --HealBot_setCall("HealBot_OnEvent_UnitHealth")
end

function HealBot_OnEvent_EnemyUnitHealth(button)
    button.health.updhlth=true
end

function HealBot_Plugin_TTDUpdate(guid)
    xButton,pButton = HealBot_Panel_RaidUnitButton(guid)
    if xButton and xButton.status.plugin then
        HealBot_Plugin_TimeToDie_UnitUpdate(xButton, xButton.health.current)
    elseif pButton and pButton.status.plugin then
        HealBot_Plugin_TimeToDie_UnitUpdate(pButton, pButton.health.current)
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
            _,xButton,pButton = HealBot_UnitID(vUnit)
            if not HealBot_VehicleUnit[vUnit] then HealBot_VehicleUnit[vUnit]={} end
            HealBot_VehicleUnit[vUnit][button.unit]=true
            HealBot_UnitInVehicle[button.unit]=vUnit
            if xButton then 
                HealBot_OnEvent_UnitHealth(xButton)
            end
            if pButton then 
                HealBot_OnEvent_UnitHealth(pButton)
            end
            doRefresh=true
        end
    elseif HealBot_UnitInVehicle[button.unit] then
        HealBot_NoVehicle(HealBot_UnitInVehicle[button.unit])
        doRefresh=true
    end
    if doRefresh then
        HealBot_RefreshUnit(button)
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["STATE"] then
            HealBot_Timers_Set("INIT","RefreshPartyNextRecalcVehicle")
        end
    end
end

function HealBot_OnEvent_VehicleChange(unit, enterVehicle)
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

local hbRaidTargetIconsChecked={[1]={[1]=true,[2]=true,[3]=true,[4]=true,[5]=true,[6]=true,[7]=true,[8]=true,},
                                [2]={[1]=true,[2]=true,[3]=true,[4]=true,[5]=true,[6]=true,[7]=true,[8]=true,},
                                [3]={[1]=true,[2]=true,[3]=true,[4]=true,[5]=true,[6]=true,[7]=true,[8]=true,},
                                [4]={[1]=true,[2]=true,[3]=true,[4]=true,[5]=true,[6]=true,[7]=true,[8]=true,},
                                [5]={[1]=true,[2]=true,[3]=true,[4]=true,[5]=true,[6]=true,[7]=true,[8]=true,},
                                [6]={[1]=true,[2]=true,[3]=true,[4]=true,[5]=true,[6]=true,[7]=true,[8]=true,},
                                [7]={[1]=true,[2]=true,[3]=true,[4]=true,[5]=true,[6]=true,[7]=true,[8]=true,},
                                [8]={[1]=true,[2]=true,[3]=true,[4]=true,[5]=true,[6]=true,[7]=true,[8]=true,},
                                [9]={[1]=true,[2]=true,[3]=true,[4]=true,[5]=true,[6]=true,[7]=true,[8]=true,},
                               [10]={[1]=true,[2]=true,[3]=true,[4]=true,[5]=true,[6]=true,[7]=true,[8]=true,},
                               }
function HealBot_setRaidTargetChecked()
    for x=1,10 do
        hbRaidTargetIconsChecked[x][1]=Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][x]["STAR"]
        hbRaidTargetIconsChecked[x][2]=Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][x]["CIRCLE"]
        hbRaidTargetIconsChecked[x][3]=Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][x]["DIAMOND"]
        hbRaidTargetIconsChecked[x][4]=Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][x]["TRIANGLE"]
        hbRaidTargetIconsChecked[x][5]=Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][x]["MOON"]
        hbRaidTargetIconsChecked[x][6]=Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][x]["SQUARE"]
        hbRaidTargetIconsChecked[x][7]=Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][x]["CROSS"]
        hbRaidTargetIconsChecked[x][8]=Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][x]["SKULL"]
    end
end

function HealBot_OnEvent_RaidTargetUpdate(button)
    if button.status.current<HealBot_Unit_Status["RESERVED"] and Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][button.frame]["SHOW"] then 
        local x=GetRaidTargetIndex(button.unit)
        if x and hbRaidTargetIconsChecked[button.frame][x] then
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
    local newSkinName=Healbot_Config_Skins.Current_Skin
    local skinFound=false
    if not HealBot_Options_checkSkinName(Healbot_Config_Skins.Current_Skin) then
        newSkinName=HEALBOT_SKINS_STD
    end
    if HealBot_Config.SkinZoneEnabled[HealBot_luVars["mapName"]] then
        for x in pairs (Healbot_Config_Skins.Skins) do
            if HealBot_Config.SkinZoneEnabled[HealBot_luVars["mapName"]]==Healbot_Config_Skins.Skins[x] then
                LastAutoSkinChangeType=HealBot_luVars["mapName"]
                newSkinName=Healbot_Config_Skins.Skins[x]
                skinFound=true
                break
            end
        end
    end
    if not skinFound then
        if z=="arena" then
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
    end
    return newSkinName,LastAutoSkinChangeType
end

function HealBot_PartyUpdate_CheckSolo()
    local PrevSolo=HealBot_luVars["IsSolo"]
    if IsInRaid() or IsInGroup() then
        if HealBot_luVars["IsSolo"] then
            HealBot_Timers_Set("LAST","CheckVersions",5)
        end
        HealBot_luVars["IsSolo"]=false
    else
        HealBot_luVars["IsSolo"]=true
    end
    if PrevSolo~=HealBot_luVars["IsSolo"] then
        HealBot_Timers_Set("AURA","PlayerCheckExtended")
        HealBot_Timers_Set("LAST","DisableCheck")
    end
end

function HealBot_PartyUpdate_CheckSkin()
    local newSkinName,LastAutoSkinChangeType=HealBot_getDefaultSkin()
    if LastAutoSkinChangeType~=HealBot_Config.LastAutoSkinChangeType or HealBot_Config.LastAutoSkinChangeTime<TimeNow then
        if newSkinName~=Healbot_Config_Skins.Current_Skin then
            HealBot_Options_Set_Current_Skin(newSkinName, nil, nil, true)
        end
        HealBot_Config.LastAutoSkinChangeType=LastAutoSkinChangeType
    end
    HealBot_Timers_Set("LAST","PartyUpdateCheckSolo")
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

function HealBot_AfterCombatCleanup()
    if HealBot_luVars["RegenDisabled"] then
        HealBot_luVars["RegenDisabled"]=false
        for guid in pairs(HealBot_MobGUID) do
            HealBot_MobGUID[guid]=nil
        end
        for name in pairs(HealBot_MobNames) do
            HealBot_MobNames[name]=nil
        end
        if HealBot_luVars["MessageReloadUI"]>0 then
            HealBot_MessageReloadUI(HealBot_luVars["MessageReloadUI"])
        end
        if HealBot_luVars["healthFactor"]~=1 then
            HealBot_luVars["healthFactor"]=1
            HealBot_Timers_Set("LAST","UpdateAllHealth")
        end
        HealBot_Timers_Set("LAST","ResetUnitStatus")
        HealBot_Timers_Set("SKINS","TextUpdateNames")
        HealBot_Timers_Set("LAST","EndAggro")
        if HealBot_luVars["CheckFramesOnCombat"] then HealBot_Timers_Set("LAST","CheckHideFrames") end
        HealBot_Timers_Set("LAST","CheckLowMana")
        HealBot_Timers_Set("PLAYER","PlayerTargetChanged")
        HealBot_Timers_Set("LAST","TargetFocusUpdate")
        HealBot_UnlockEnemyFrame()
        HealBot_Timers_Set("LAST","IconNotInCombat")
        HealBot_UpdateAllUnitBars(true)
        if HealBot_luVars["pluginThreat"] then HealBot_Plugin_Threat_TogglePanel() end
    elseif not HealBot_luVars["UpdateEnemyFrame"] then
        HealBot_UnlockEnemyFrame()
    end
end

function HealBot_UnlockEnemyFrame()
    HealBot_luVars["UpdateEnemyFrame"]=true
    HealBot_Timers_Set("INIT","RefreshPartyNextRecalcEnemy")
end

function HealBot_Not_Fighting()
    if not InCombatLockdown() then
        if HealBot_Data["UILOCK"] then
            HealBot_Data["UILOCK"]=false
            HealBot_luVars["CheckAuraFlags"]=true
            HealBot_PlayerCheck()
            HealBot_Timers_Set("INIT","HealthAlertLevel")
            if HealBot_Globals.DisableToolTipInCombat and HealBot_Data["TIPBUTTON"] then
                HealBot_Action_RefreshTooltip()
            end
            if HealBot_luVars["EOCOOM"] and HealBot_Data["POWERTYPE"]==0 then
                _,xButton,pButton = HealBot_UnitID("player")
                if xButton and xButton.status.current<HealBot_Unit_Status["DEAD"] then
                    HealBot_Timers_Set("PLAYER","EmoteOOM",0.2)
                elseif pButton and pButton.status.current<HealBot_Unit_Status["DEAD"] then
                    HealBot_Timers_Set("PLAYER","EmoteOOM",0.2)
                end
            end
            HealBot_luVars["TargetNeedReset"]=true
            HealBot_Timers_Set("LAST","AfterCombatCleanup")
            if HealBot_luVars["pluginTimeToLive"] then HealBot_Plugin_TimeToLive_TogglePanel() end
            if HealBot_luVars["pluginBuffWatch"] then C_Timer.After(0.025, function() HealBot_Plugin_BuffWatch_CombatState(false) end) end
            if HealBot_luVars["pluginHealthWatch"] then C_Timer.After(0.05, function() HealBot_Plugin_HealthWatch_CombatState(false) end) end
            if HealBot_luVars["pluginManaWatch"] then C_Timer.After(0.075, function() HealBot_Plugin_ManaWatch_CombatState(false) end) end
        elseif not HealBot_luVars["UpdateEnemyFrame"] then
            HealBot_UnlockEnemyFrame()
        end
    elseif HealBot_Data["UILOCK"] then
        HealBot_luVars["DropCombat"]=1
    end
      --HealBot_setCall("HealBot_Not_Fighting")
end

function HealBot_OnEvent_DoReadyCheckClear(button)
    button.icon.extra.readycheck=false
    HealBot_Aura_UpdateState(button)
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

function HealBot_SetUnitDisconnectChange(button, state)
    HealBot_Action_setState(button, state)
    HealBot_Text_setNameTag(button)
    button.status.change=true
    button.status.update=true
end

function HealBot_SetUnitCconnected(button, offlineStart)
    if offlineStart or button.status.current==HealBot_Unit_Status["DC"] then
        if offlineStart then
            HealBot_Action_setGuidData(button, "OFFLINE", false)
        end
        HealBot_SetUnitDisconnectChange(button, HealBot_Unit_Status["CHECK"])
    end
end

function HealBot_SetUnitDisconnect(button)
    if button.status.current<HealBot_Unit_Status["RESERVED"] then
        local offlineStart=HealBot_Action_getGuidData(button.guid, "OFFLINE")
        if button.isplayer then
            if UnitIsConnected(button.unit) then
                HealBot_SetUnitCconnected(button, offlineStart)
            elseif not offlineStart or button.status.current~=HealBot_Unit_Status["DC"] then
                if not offlineStart then
                    HealBot_Action_setGuidData(button, "OFFLINE", TimeNow)
                end
                HealBot_SetUnitDisconnectChange(button, HealBot_Unit_Status["DC"])
            end
        else
            HealBot_SetUnitCconnected(button, offlineStart)
        end
    end
end

function HealBot_UnitSlowUpdate(button)
    if button.status.current<HealBot_Unit_Status["RESERVED"] then
        if button.guid~=UnitGUID(button.unit) then
            HealBot_UpdateUnitGUIDChange(button)
        elseif button.status.postchange then
            button.status.postchange=false
            HealBot_CheckUnitStatus(button)
            HealBot_OnEvent_UnitHealth(button)
            HealBot_OnEvent_HealsInUpdate(button)
            HealBot_OnEvent_AbsorbsUpdate(button)
            HealBot_Update_AuxRange(button)
            HealBot_Aura_Update_AllIcons(button)
            HealBot_Aux_CheckOverLays(button)
        elseif button.specupdate>0 and button.specupdate<TimeNow and not HealBot_luVars["talentUpdate"] then
            if button.frame<10 then
                if button.player then
                    HealBot_GetTalentInfo(button)
                elseif button.isplayer then
                    HealBot_TalentQuery(button)
                else
                    button.specupdate=0
                end
            else
                button.specupdate=0
            end
        elseif button.status.postupdate then
            button.status.postupdate=false
            HealBot_OnEvent_UnitFlagsChanged(button)
            HealBot_Text_UpdateNameButton(button)
            button.text.health=""
            HealBot_Text_setHealthText(button)
            HealBot_ReadyCheckUnit(button)
            HealBot_OnEvent_RaidTargetUpdate(button)
            HealBot_Action_SetClassIconTexture(button)
            HealBot_Text_setNameTag(button)
        elseif button.frame<10 then
            if button.status.castend>0 and button.status.castend<(TimeNow*1000) then
                HealBot_Aux_ClearCastBar(button)
            elseif not HealBot_Data["UILOCK"] then
                if not HealBot_luVars["onTaxi"] and button.aura.buff.nextcheck and button.aura.buff.nextcheck<TimeNow then
                    if button.aura.buff.resetcheck then
                        HealBot_Aura_ResetCheckBuffsTime(button)
                    else
                        button.aura.buff.nextcheck=false
                        HealBot_Check_UnitBuff(button)
                    end
                elseif button.isplayer then
                    if button.status.summons and C_IncomingSummon.IncomingSummonStatus(button.unit)~=1 then
                        HealBot_UnitSummonsUpdate(button, false)
                    elseif button.status.nextcheck<TimeNow and (not UnitIsConnected(button.unit) or HealBot_Action_getGuidData(button.guid, "OFFLINE")) then 
                        HealBot_CheckUnitStatus(button)
                    elseif button.health.current<2 then
                        HealBot_OnEvent_UnitHealth(button)
                    elseif button.mana.nextcheck<TimeNow and button.mana.max==0 then
                        HealBot_OnEvent_UnitManaUpdate(button)
                    elseif button.status.incombat then
                        HealBot_UnitAffectingCombat(button)
                    end
                elseif button.health.current<2 then
                    HealBot_OnEvent_UnitHealth(button)
                end
            elseif button.aggro.threatpct>0 then 
                HealBot_CalcThreat(button)
            elseif not button.status.incombat then 
                HealBot_UnitAffectingCombat(button)
            end
            if button.status.emergupd then
                button.status.emergupd=false
                HealBot_Action_EmergBarCheck(button, true)
            elseif button.mana.lowcheck then
                button.mana.lowcheck=false
                HealBot_Action_CheckUnitLowMana(button)
            end
        end
    end
      --HealBot_setCall("HealBot_UnitSlowUpdate")
end

function HealBot_ProcessRefreshTypes()
      --HealBot_setCall("HealBot_ProcessRefreshTypes")
    if not InCombatLockdown() then
        if HealBot_RefreshTypes[0] then
            HealBot_RecalcParty(0)
        elseif HealBot_RefreshTypes[6] then
            HealBot_RecalcParty(6)
            if not HealBot_RefreshTypes[5] then
                HealBot_Timers_Set("INIT","RefreshPartyNextRecalcEnemy")
            end
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
        elseif HealBot_luVars["pluginClearDown"]>0 then
            if HealBot_luVars["pluginClearDown"]<2 and HealBot_luVars["pluginTimeToDie"] then 
                HealBot_Plugin_TimeToDie_Cleardown()
                HealBot_luVars["pluginClearDown"]=2
            elseif HealBot_luVars["pluginClearDown"]<3 and HealBot_luVars["pluginTimeToLive"] then 
                HealBot_Plugin_TimeToLive_Cleardown()
                HealBot_luVars["pluginClearDown"]=3
            elseif HealBot_luVars["pluginClearDown"]<4 and HealBot_luVars["pluginThreat"] then 
                HealBot_Plugin_Threat_Cleardown()
                HealBot_luVars["pluginClearDown"]=4
            elseif HealBot_luVars["pluginClearDown"]<5 and HealBot_luVars["pluginBuffWatch"] then 
                HealBot_Plugin_BuffWatch_Validate()
                HealBot_luVars["pluginClearDown"]=5
            elseif HealBot_luVars["pluginClearDown"]<6 and HealBot_luVars["pluginHealthWatch"] then 
                HealBot_Plugin_HealthWatch_Validate()
                HealBot_luVars["pluginClearDown"]=6
            elseif HealBot_luVars["pluginClearDown"]<7 and HealBot_luVars["pluginManaWatch"] then 
                HealBot_Plugin_ManaWatch_Validate()
                HealBot_luVars["pluginClearDown"]=7
            else
                HealBot_luVars["pluginClearDown"]=0
            end
        else
            HealBot_luVars["ProcessRefresh"]=false
            HealBot_Timers_Set("LAST","ProcCacheButtons",5)
            if HealBot_Panel_retLuVars("resetAuxText") then
                HealBot_Panel_setLuVars("resetAuxText", false)
                HealBot_Aux_ResetTextButtons()
            end
            if (GetNumGroupMembers()+HealBot_luVars["NumPrivateUnits"]+HealBot_luVars["NumPetUnits"]+5)>HealBot_Globals.AutoCacheSize then    
                HealBot_Globals.AutoCacheSize=(GetNumGroupMembers()+HealBot_luVars["NumPrivateUnits"]+HealBot_luVars["NumPetUnits"]+1)
            end
            if not HealBot_luVars["TestBarsOn"] then
                HealBot_Timers_Set("LAST","CheckHideUnusedFrames")
            end
            HealBot_Skins_setLuVars("AuxReset", false)
            return
        end
        C_Timer.After(0.02, HealBot_ProcessRefreshTypes)
    else
        HealBot_luVars["ProcessRefresh"]=false
        HealBot_Timers_Set("INIT","RefreshParty")
    end
end

function HealBot_QueueSpecUpdate(button)
    if button.frame<10 and HEALBOT_GAME_VERSION>2 and button.level>10 and button.isplayer and button.specupdate==0 and not HealBot_SpecQueueList[button.id] then
        HealBot_SpecQueueList[button.id]=true
        table.insert(HealBot_SpecQueue, button.id)
    end
end

function HealBot_Update_Slow()
    if not HealBot_Data["UILOCK"] then
        HealBot_luVars["slowSwitch"]=HealBot_luVars["slowSwitch"]+1
        HealBot_Set_FPS()
        if HealBot_luVars["slowSwitch"]<2 then
            if HealBot_luVars["GetVersions"] and HealBot_luVars["GetVersions"]<TimeNow then
                HealBot_Timers_Set("LAST","GetVersion")
                HealBot_luVars["GetVersions"]=false
            elseif HealBot_luVars["SendVersion"] and HealBot_luVars["SendVersion"]<TimeNow then
                HealBot_Timers_Set("LAST","SendVersion")
                HealBot_luVars["SendVersion"]=false
            elseif HealBot_luVars["SendGuildVersion"] and HealBot_luVars["SendGuildVersion"]<TimeNow then
                HealBot_Timers_Set("LAST","SendGuildVersion")
                HealBot_luVars["SendGuildVersion"]=false
            end
        elseif HealBot_luVars["slowSwitch"]<3 then
            if not HealBot_luVars["ProcessRefresh"] then
                for guid,_ in pairs(HealBot_ClearGUIDQueue) do
                    HealBot_ClearGUIDQueue[guid]=HealBot_ClearGUIDQueue[guid]+1
                    if HealBot_ClearGUIDQueue[guid]>2 then
                        HealBot_ClearGUID(guid)
                        HealBot_ClearGUIDQueue[guid]=nil
                        break
                    end
                end
            end
        else
            if HealBot_luVars["MaxCount"]>0 then
                HealBot_Debug_UpdateCalls()
                HealBot_AddDebug("#Calls active")
            end
            if HealBot_DebugMsg[1] then
                HealBot_AddChat(HealBot_DebugMsg[1])
                table.remove(HealBot_DebugMsg,1)
            end
            HealBot_Comms_SendAddonMessage()
            HealBot_luVars["slowSwitch"]=0
        end
        for xUnit,xGroup in pairs(HealBot_notVisible) do
            if UnitIsVisible(xUnit) then
                HealBot_nextRecalcParty(xGroup)
                HealBot_notVisible[xUnit]=nil
            end
        end
    elseif HealBot_luVars["DropCombat"]>0 then
        if HealBot_luVars["UILOCK"] then
            if not InCombatLockdown() then
                HealBot_luVars["DropCombat"]=HealBot_luVars["DropCombat"]+1
                if HealBot_luVars["DropCombat"]>2 then
                    HealBot_luVars["DropCombat"]=0
                    HealBot_luVars["UILOCK"]=false
                    HealBot_luVars["AllOutOfCombatCheck"]=TimeNow
                end
            else
                HealBot_luVars["DropCombat"]=1
            end
        else
            HealBot_luVars["DropCombat"]=0
            HealBot_luVars["AllOutOfCombatCheck"]=TimeNow
        end            
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
        HealBot_luVars["rcEnd"]=false
        HealBot_OnEvent_ReadyCheckClear(false)
    end
    if HealBot_luVars["UpdateAllAura"]>0 then
        HealBot_luVars["UpdateAllAura"]=HealBot_luVars["UpdateAllAura"]-1
        if HealBot_luVars["UpdateAllAura"]==1 then
            HealBot_Aura_setLuVars("updateAll", false)
        end
    end
      --HealBot_setCall("HealBot_Update_Slow")
end

local hbBuffWatch={}
function HealBot_BuffWatch(buff, state)
    if state then
        hbBuffWatch[buff]=true
    elseif hbBuffWatch[buff] then
        hbBuffWatch[buff]=false
    end
end

function HealBot_BuffWatchClear()
    hbBuffWatch={}
end

function HealBot_Queue_Cooldown(SpellId)
    if HealBot_luVars["pluginMyCooldowns"] or HealBot_luVars["pluginBuffWatch"] then
        scName=GetSpellInfo(SpellId)
        if scName then HealBot_CDQueue[scName]=SpellId end
    end
end

local LogSourceGUID, LogDestGUID, LogEvent, LogUnit, LogAbsorbAmount, Log12, Log14, Log15, Log17 = "","","","",0,"",0,"",0
function HealBot_OnEvent_Combat_Log()
    _, LogEvent, _, LogSourceGUID, _, _, _, LogDestGUID, _, _, _, Log12, _, Log14, Log15, _, Log17 = CombatLogGetCurrentEventInfo()
    if HEALBOT_GAME_VERSION<4 then
        if LogEvent=="SWING_MISSED" or LogEvent=="SPELL_MISSED" then
            if Log12=="ABSORB" then
                LogAbsorbAmount=Log14 or 0
            elseif Log15=="ABSORB" then
                LogAbsorbAmount=Log17 or 0
            else
                LogAbsorbAmount=0
            end
            if LogAbsorbAmount>0 then
                xButton,pButton = HealBot_Panel_RaidUnitButton(LogDestGUID)
                if xButton then HealBot_Classic_AbsorbsUpdate(xButton, LogAbsorbAmount) end
                if pButton then HealBot_Classic_AbsorbsUpdate(pButton, LogAbsorbAmount) end
            end
        end
    end
    
    if HealBot_Data["PGUID"]==LogSourceGUID then
        if LogEvent=="SPELL_HEAL" then
            xButton,pButton = HealBot_Panel_RaidUnitButton(LogDestGUID)
            if xButton then HealBot_Update_RecentHealsBar(xButton) end
            if pButton then HealBot_Update_RecentHealsBar(pButton) end
        end
        if type(Log12)=="number" then HealBot_Queue_Cooldown(Log12) end
    end

      --HealBot_setCall("HealBot_OnEvent_Combat_Log")
end

--local hbSpecialStates={[HealBot_Unit_Status["DEAD"]]=true, [HealBot_Unit_Status["RES"]]=true, [HealBot_Unit_Status["DC"]]=true}
function HealBot_UnitUpdateButton(button)
    if UnitExists(button.unit) then
        if button.guid~=UnitGUID(button.unit) then
            HealBot_UpdateUnitGUIDChange(button)
        elseif button.status.update then
            if button.status.change then
                HealBot_UpdateUnitExists(button)
            else
                HealBot_UpdateUnit(button)
            end
        else
            if not button.player then
                if button.status.rangenextcheck<TimeNow then
                    if button.status.range<1 or not CheckInteractDistance(button.unit, 4) then 
                        HealBot_UpdateUnitRange(button)
                    elseif not button.status.range30 then
                        button.status.range30=true
                        HealBot_Update_Range30Bar(button)
                    else
                        button.status.rangenextcheck=TimeNow+HealBot_luVars["rangeCheckAdj"]
                    end
                end
            end
            if button.status.resstart>0 or HealBot_Action_IsUnitDead(button) then
                HealBot_Action_UpdateTheDeadButton(button, TimeNow)
            elseif button.status.dirarrowshown>0 and button.status.dirarrowshown<TimeNow then 
                HealBot_Action_ShowDirectionArrow(button, TimeNow)
            end
        end
    elseif button.status.current<HealBot_Unit_Status["RESERVED"] then
        HealBot_UpdateUnitNotExists(button)
    end
end

local addonMsg=""
HealBot_luVars["updateEnemieGUID"]="ALL"
local euName, euStartTime, euEndTime, euChan="",0,false,false
function HealBot_EnemyUpdateAura(button)
    button.aura.update=false
    if UnitIsFriend("player",button.unit) then 
        if button.status.dirarrowshown>0 and button.status.dirarrowshown<TimeNow then HealBot_Action_ShowDirectionArrow(button, TimeNow) end
        if button.status.castend>0 then HealBot_Aux_ClearCastBar(button) end
    elseif HealBot_AuxAssigns["CastBar"][button.frame] then
        if button.status.unittype==11 then 
            euChan=false
            euName, _, _, euStartTime, euEndTime = UnitCastingInfo(button.unit) 
            if not euEndTime then
                euChan=true
                euName, _, _, euStartTime, euEndTime = UnitChannelInfo(button.unit) 
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
    HealBot_Aura_CheckUnitAuras(button)
end

function HealBot_EnemyUpdateButton(button, checkAura)
    if UnitExists(button.unit) then
        if button.status.rangenextcheck<TimeNow then
            if button.status.range<1 or not CheckInteractDistance(button.unit, 4) then
                HealBot_UpdateUnitRange(button)
            elseif not button.status.range30 then
                button.status.range30=true
                HealBot_Update_Range30Bar(button)
            else
                button.status.rangenextcheck=TimeNow+HealBot_luVars["rangeCheckAdj"]
            end
        end
        if button.guid~=UnitGUID(button.unit) then
            HealBot_UpdateUnitGUIDChange(button)
            HealBot_EnemyUpdateAura(button)
        elseif button.status.update then
            if button.status.change then
                HealBot_UpdateUnitExists(button)
            else
                HealBot_UpdateUnit(button)
            end
            HealBot_EnemyUpdateAura(button)
        elseif checkAura then
            if button.aura.update or button.status.unittype==11 then
                HealBot_EnemyUpdateAura(button)
            end
        elseif button.status.resstart>0 or HealBot_Action_IsUnitDead(button) then
            HealBot_Action_UpdateTheDeadButton(button, TimeNow)
        elseif button.status.unittype==11 then
            HealBot_OnEvent_UnitHealth(button)
            HealBot_OnEvent_HealsInUpdate(button)
            HealBot_OnEvent_AbsorbsUpdate(button)
            HealBot_OnEvent_UnitMana(button)
        else
            if button.health.updhlth then HealBot_OnEvent_UnitHealth(button) end
            if button.health.updincoming then HealBot_OnEvent_HealsInUpdate(button) end
            if button.health.updabsorbs then HealBot_OnEvent_AbsorbsUpdate(button) end
        end
    elseif button.status.current<HealBot_Unit_Status["RESERVED"] then
        HealBot_UpdateUnitNotExists(button)
    end
end

function HealBot_UpdateUnit_Button()
    HealBot_luVars["UpdateID"]=HealBot_luVars["UpdateID"]+1
    if HealBot_Buttons[HealBot_UpdateQueue[HealBot_luVars["UpdateID"]]] then
        HealBot_UnitUpdateButton(HealBot_Buttons[HealBot_UpdateQueue[HealBot_luVars["UpdateID"]]])
    elseif HealBot_luVars["UpdateID"]>#HealBot_UpdateQueue then
        HealBot_luVars["UpdateID"]=0
    end
end

function HealBot_UpdateUnit_Buttons()
    for u=1,HealBot_luVars["UpdateNumUnits"] do
        HealBot_UpdateUnit_Button()
    end
    HealBot_luVars["slowUpdateID"]=HealBot_luVars["slowUpdateID"]+1
    if HealBot_Buttons[HealBot_SlowUpdateQueue[HealBot_luVars["slowUpdateID"]]] then
        HealBot_UnitSlowUpdate(HealBot_Buttons[HealBot_SlowUpdateQueue[HealBot_luVars["slowUpdateID"]]])
    elseif HealBot_luVars["slowUpdateID"]>#HealBot_SlowUpdateQueue then
        HealBot_luVars["slowUpdateID"]=0
    end
end

function HealBot_Update_Fast04()
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_EnemyUpdateButton(xButton, true)
    end
end

function HealBot_Update_Fast08()
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_EnemyUpdateButton(xButton, false)
    end
    HealBot_Update_Fast99()
    HealBot_luVars["fastSwitch"]=0
end

function HealBot_Update_Fast09()
    HealBot_luVars["fastSwitch"]=0
end

HealBot_luVars["TestFramesRefresh"]=0
function HealBot_Update_Fast98()
    HealBot_luVars["TestFramesRefresh"]=HealBot_luVars["TestFramesRefresh"]+1
    if HealBot_luVars["TestFramesRefresh"]>11 then
        HealBot_Update_Fast99()
        HealBot_luVars["TestFramesRefresh"]=0
    end
end

function HealBot_MyCooldowns_PlayerUpdateAll()
    HealBot_luVars["pluginCDsCheckExisting"]=TimeNow+15
    HealBot_Plugin_MyCooldowns_PlayerUpdateAll()
end
    
function HealBot_Update_Fast99()
    if HealBot_luVars["MovingFrame"]>0 then
        HealBot_Action_CheckForStickyFrame(HealBot_luVars["MovingFrame"],false)
    elseif HealBot_luVars["NextTipUpdate"]<TimeNow then
        HealBot_luVars["NextTipUpdate"]=TimeNow+HealBot_luVars["TipUpdateFreq"]
        if HealBot_Data["TIPBUTTON"] then 
            HealBot_Action_RefreshTooltip()
        elseif HealBot_Data["TIPICON"] then
            HealBot_Tooltip_UpdateIconTooltip()
        end
    end
    if HealBot_luVars["pluginMyCooldowns"] or HealBot_luVars["pluginBuffWatch"] then
        if HealBot_luVars["pluginMyCooldowns"] and HealBot_luVars["pluginCDsCheckExisting"]<TimeNow then
            HealBot_MyCooldowns_PlayerUpdateAll()
        elseif HealBot_luVars["pluginCDsCheckIncoming"]<TimeNow then
            HealBot_luVars["pluginCDsCheckIncoming"]=TimeNow+0.25
            for spellName, spellId in pairs(HealBot_CDQueue) do
                if HealBot_luVars["pluginMyCooldowns"] then
                    HealBot_Plugin_MyCooldowns_PlayerUpdate(spellName, spellId)
                end
                if HealBot_luVars["pluginBuffWatch"] then
                    HealBot_Plugin_BuffWatch_SelfCD(spellName)
                end
                HealBot_CDQueue[spellName]=nil
            end
        end
    end
    if HealBot_luVars["talentUpdate"] then
        if HealBot_luVars["talentUpdate"]<(TimeNow-HealBot_luVars["talentUpdateFreq"]) then HealBot_luVars["talentUpdate"]=false end
    elseif HealBot_SpecQueue[1] then
        if HealBot_Buttons[HealBot_SpecQueue[1]] then
            HealBot_Buttons[HealBot_SpecQueue[1]].specupdate=TimeNow
        end
        HealBot_SpecQueueList[HealBot_SpecQueue[1]]=false
        table.remove(HealBot_SpecQueue,1)
    end
end
-- /dump GetSpellInfo(33076)
local hbFastFuncs={[1]=HealBot_UpdateUnit_Buttons, [2]=HealBot_UpdateUnit_Buttons, [3]=HealBot_UpdateUnit_Buttons, [4]=HealBot_Update_Fast04,
                   [5]=HealBot_UpdateUnit_Buttons, [6]=HealBot_UpdateUnit_Buttons, [7]=HealBot_UpdateUnit_Buttons, [8]=HealBot_Update_Fast08,
                   [9]=HealBot_Update_Fast09}

function HealBot_Update_Fast()
    HealBot_luVars["fastSwitch"]=HealBot_luVars["fastSwitch"]+1
    hbFastFuncs[HealBot_luVars["fastSwitch"]]()
    if HealBot_luVars["MaskAuraCheckDebuff"] and HealBot_luVars["MaskAuraCheckDebuff"]<TimeNow then
        HealBot_luVars["MaskAuraCheckDebuff"]=false
        HealBot_luVars["CheckAllActiveDebuffs"]=false
        HealBot_CheckAllDebuffs()
    elseif HealBot_luVars["CheckAllActiveDebuffs"] then
        HealBot_luVars["CheckAllActiveDebuffs"]=false
        HealBot_CheckAllActiveDebuffs()
    elseif HealBot_luVars["CheckAllActiveBuffs"] then
        HealBot_luVars["CheckAllActiveBuffs"]=false
        HealBot_CheckAllActiveBuffs()
    end
end

function HealBot_Update_ResetRefreshLists()
    for _,xButton in pairs(HealBot_Unit_Button) do
        table.insert(HealBot_SlowUpdateQueue,xButton.id)
        table.insert(HealBot_UpdateQueue,xButton.id)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        table.insert(HealBot_SlowUpdateQueue,xButton.id)
        table.insert(HealBot_UpdateQueue,xButton.id)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        table.insert(HealBot_SlowUpdateQueue,xButton.id)
        table.insert(HealBot_UpdateQueue,xButton.id)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        table.insert(HealBot_SlowUpdateQueue,xButton.id)
        table.insert(HealBot_UpdateQueue,xButton.id)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        table.insert(HealBot_SlowUpdateQueue,xButton.id)
        table.insert(HealBot_UpdateQueue,xButton.id)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        table.insert(HealBot_SlowUpdateQueue,xButton.id)
    end
    if HealBot_luVars["prevNumUnits"]~=#HealBot_UpdateQueue then
        HealBot_luVars["prevNumUnits"]=#HealBot_UpdateQueue
        HealBot_UpdateNumUnits()
    end
    HealBot_TestBarsState(HealBot_luVars["TestBarsOn"])
end

local hbFastCur=HealBot_Update_Fast
function HealBot_RefreshLists()
    hbFastCur=HealBot_Update_ResetRefreshLists
end

function HealBot_TestBarsState(state)
    if state then
        hbFastCur=HealBot_Update_Fast98
    else
        hbFastCur=HealBot_Update_Fast
    end
    HealBot_luVars["TestBarsOn"]=state
end

local ouNoneInCombat, ouQueueMax=true, 10
function HealBot_MaxQueue(qLen)
    if qLen>ouQueueMax then 
        qLen=ouQueueMax
        ouQueueMax=0
    else
        ouQueueMax=ouQueueMax-qLen
    end
    return qLen
end

function HealBot_FastDebuffQueue()
    for x=HealBot_MaxQueue(#HealBot_DebuffQueue),1,-1 do
        HealBot_DebuffQueueList[HealBot_DebuffQueue[x]]=false
        HealBot_Aura_CheckUnitAuras(HealBot_Buttons[HealBot_DebuffQueue[x]], true)
        table.remove(HealBot_DebuffQueue,x)
    end
end

function HealBot_FastBuffQueue()
    for x=HealBot_MaxQueue(#HealBot_BuffQueue),1,-1 do
        HealBot_BuffQueueList[HealBot_BuffQueue[x]]=false
        HealBot_Aura_CheckUnitAuras(HealBot_Buttons[HealBot_BuffQueue[x]], false)
        table.remove(HealBot_BuffQueue,x)
    end
end

function HealBot_FastRefreshQueue()
    for x=HealBot_MaxQueue(#HealBot_RefreshQueue),1,-1 do
        HealBot_RefreshQueueList[HealBot_RefreshQueue[x]]=false
        HealBot_Action_UpdateDebuffButton(HealBot_Buttons[HealBot_RefreshQueue[x]])
        table.remove(HealBot_RefreshQueue,x)
    end
end

function HealBot_OnUpdate(self, elapsed)
    if HealBot_luVars["AddonLoaded"] then
        TimeNow=GetTime()
        HealBot_Aura_TimeNow(TimeNow)
        if HealBot_luVars["UpdateSlowNext"]<TimeNow then
            HealBot_luVars["UpdateSlowNext"]=TimeNow+1
            HealBot_Update_Slow()
        else
            hbFastCur()
            if not HealBot_luVars["UILOCK"] then
                if (HealBot_Data["UILOCK"] or not HealBot_luVars["UpdateEnemyFrame"]) and HealBot_luVars["AllOutOfCombatCheck"]<=TimeNow then
                    ouNoneInCombat=true
                    for xUnit,xButton in pairs(HealBot_Private_Button) do
                        if xButton.status.current<HealBot_Unit_Status["DEAD"] and xButton.status.range>-1 and UnitAffectingCombat(xUnit) and 
                           HealBot_ValidLivingEnemy(xUnit, xUnit.."target") and UnitIsUnit(xButton.unit, xButton.unit.."targettarget") then
                            ouNoneInCombat=false
                            break
                        end
                    end  
                    if ouNoneInCombat then
                        for xUnit,xButton in pairs(HealBot_Unit_Button) do
                            if xButton.status.current<HealBot_Unit_Status["DEAD"] and xButton.status.range>-1 and UnitAffectingCombat(xUnit) and 
                               HealBot_ValidLivingEnemy(xUnit, xUnit.."target") and UnitIsUnit(xButton.unit, xButton.unit.."targettarget") then
                                ouNoneInCombat=false
                                break
                            end
                        end
                    end
                    if ouNoneInCombat then
                        HealBot_Not_Fighting()
                        HealBot_luVars["AllOutOfCombatCheck"]=TimeNow+1
                    else
                        HealBot_luVars["AllOutOfCombatCheck"]=TimeNow+0.2
                    end
                          --HealBot_setCall("HealBot_OnUpdate-CombatCheck")
                elseif HealBot_luVars["HealBot_RunTimers"] then
                    HealBot_Timers_Run()
                end
            end
            HealBot_luVars["fastQueueSwitch"]=HealBot_luVars["fastQueueSwitch"]+1
            ouQueueMax=HealBot_luVars["MaxFastQueue"]
            if HealBot_luVars["fastQueueSwitch"]<2 and #HealBot_DebuffQueue>0 then
                HealBot_FastDebuffQueue()
            elseif HealBot_luVars["fastQueueSwitch"]<3 and #HealBot_BuffQueue>0 then
                HealBot_FastBuffQueue()
            elseif #HealBot_RefreshQueue>0 then
                HealBot_FastRefreshQueue()
            else
                HealBot_luVars["fastQueueSwitch"]=0
            end
            if ouQueueMax>0 and #HealBot_DebuffQueue>0 then HealBot_FastDebuffQueue() end
            if ouQueueMax>0 and #HealBot_BuffQueue>0 then HealBot_FastBuffQueue() end
            if ouQueueMax>0 and #HealBot_RefreshQueue>0 then HealBot_FastRefreshQueue() end
        end
    end
end

function HealBot_Register_IncHeals()
    if HEALBOT_GAME_VERSION<4 then
        libCHC = libCHC or HealBot_Libs_CHC()
        if libCHC and not HealBot_luVars["LibCHCLoaded"] then
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
            
            HealBot_luVars["LibCHCLoaded"]=true
        end
    end
      --HealBot_setCall("HealBot_Register_IncHeals")
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
        elseif UnitThreatData["threatpct"]>=HealBot_Globals.aggro2pct then
            UnitThreatData["status"]=2
        elseif (UnitThreatData["threatpct"]>0 or UnitThreatData["threatvalue"]>0) then
            if UnitThreatData["status"]<1 then UnitThreatData["status"]=1 end
            if UnitThreatData["threatpct"]<1 then UnitThreatData["threatpct"]=1 end
            UnitThreatData["status"]=1
        else
            UnitThreatData["status"]=0
        end
        if not UnitThreatData["threatname"] then UnitThreatData["threatname"]="" end
        if UnitThreatData["status"]<1 then
            HealBot_Aggro_ClearUnitAggro(button)
        elseif button.aggro.status~=UnitThreatData["status"] or UnitThreatData["threatpct"]~=button.aggro.threatpct or UnitThreatData["threatvalue"]~=button.aggro.threatvalue or UnitThreatData["threatname"]~=button.aggro.mobname then
            HealBot_Aggro_UpdateUnit(button,true,UnitThreatData["status"],UnitThreatData["threatpct"],"",UnitThreatData["threatvalue"],UnitThreatData["threatname"])
        end
        if not button.status.incombat then HealBot_UnitAffectingCombat(button) end
    else
        HealBot_Aggro_ClearUnitAggro(button)
    end
      --HealBot_setCall("HealBot_CalcThreat")
end

function HealBot_Plugin_ThreatUpdate(guid)
    xButton,pButton = HealBot_Panel_RaidUnitButton(guid)
    if xButton and xButton.status.plugin then
        HealBot_CalcThreat(xButton)
        HealBot_Plugin_Threat_UnitUpdate(xButton)
    elseif pButton and pButton.status.plugin then
        HealBot_CalcThreat(pButton)
        HealBot_Plugin_Threat_UnitUpdate(pButton)
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
function HealBot_OnEvent_AddonMsg(addon_id,msg,distribution,sender_id)
    amSenderId = HealBot_UnitNameOnly(sender_id)
    if amSenderId and msg and addon_id==HEALBOT_HEALBOT then
        local datatype, datamsg = string.split(":", msg)
        if datatype then
            if datatype=="R" then
                if amSenderId~=UnitName("player") then
                    HealBot_AddDebug("AddonMsg="..datatype.." from "..amSenderId,"Comms",true)
                    HealBot_SendVersion()
                    if not HealBot_Vers[amSenderId] then
                        HealBot_Comms_SendAddonMsg("R", 2, amSenderId)
                        HealBot_Aura_SendClassicData(amSenderId)
                    end
                end
            elseif datatype=="G" then
                if amSenderId~=UnitName("player") then
                    HealBot_AddDebug("AddonMsg="..datatype.." from "..amSenderId,"Comms",true)
                    HealBot_SendGuildVersion()
                    if not HealBot_Vers[amSenderId] then
                        HealBot_Comms_SendAddonMsg("G", 2, amSenderId)
                        HealBot_Aura_SendClassicData(amSenderId)
                    end
                end
            elseif datatype=="S" then
                if datamsg then
                    HealBot_Vers[amSenderId]=datamsg
                    HealBot_AddDebug("AddonMsg="..datatype.." from "..amSenderId.." Version="..datamsg,"Comms",true)
                    HealBot_AddDebug(amSenderId..": "..datamsg, "Version", false);
                    HealBot_Comms_CheckVer(amSenderId, datamsg)
                end
            elseif datatype=="U" then
                if datamsg then
                    local guid,s=strsplit("~", datamsg)
                    if guid and s then
                        xButton,pButton = HealBot_Panel_RaidUnitButton(guid)
                        if xButton and xButton.spec~=" "..s.." " then
                            HealBot_Action_setGuidSpec(xButton, s)
                        elseif pButton and pButton.spec~=" "..s.." " then
                            HealBot_Action_setGuidSpec(pButton, s)
                        end
                    end
                end
            elseif datatype=="H" then
                HealBot_Aura_RecClassicData(datamsg)
            elseif datatype=="L" then
                HealBot_Share_LinkMsg(datamsg, amSenderId)
            end
        end
    end
      --HealBot_setCall("HealBot_OnEvent_AddonMsg")
end

function HealBot_GetInfo()
      --HealBot_setCall("HealBot_GetInfo")
    return HealBot_Vers
end

function HealBot_VehicleHealth(unit)
    xGUID=UnitGUID(unit)
    if not xGUID then
        HealBot_NoVehicle(unit)
        return 100,100
    end
      --HealBot_setCall("HealBot_VehicleHealth")
    return UnitHealth(unit), UnitHealthMax(unit)  
end

function HealBot_OnEvent_LeavingVehicle(unit)
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["STATE"] then
        HealBot_Timers_Set("INIT","RefreshPartyNextRecalcVehicle")
    end
      --HealBot_setCall("HealBot_OnEvent_LeavingVehicle")
end

function HealBot_retIsInVehicle(unit)
      --HealBot_setCall("HealBot_retIsInVehicle")
    return HealBot_UnitInVehicle[unit]
end

local HealBot_WellFedItems={}
local HealBot_ManaDrinkItems={}
local HealBot_BuffExtraItems={}

function HealBot_retWellFedItems()
    return HealBot_WellFedItems
end

function HealBot_retManaDrinkItems()
    return HealBot_ManaDrinkItems
end

function HealBot_retBuffExtraItems()
    return HealBot_BuffExtraItems
end

local function EnumerateTooltipLines_helper(pattern, ...)
    local prevText,region=nil,nil
    for i = 1, select("#", ...) do
        region = select(i, ...)
        if region and region:GetObjectType() == "FontString" then
            if region:GetText() then
                if string.find(region:GetText(), pattern) then
                    return prevText or region:GetText()
                elseif not prevText then
                    prevText=region:GetText()
                end
            end
        end
    end
    return false
end

function HealBot_BagScanBuffExtra(bag)
    local itemID=0
    local itemText=false
    local numSlots=HealBot_GetContainerNumSlots(bag)
    for slot = 1,numSlots do
        HealBot_ScanTooltip:SetBagItem(bag, slot)
        itemText=false
        for j=1, #HEALBOT_STRING_MATCH_EXTRABUFFS do
            if not itemText then
                itemText=EnumerateTooltipLines_helper(HEALBOT_STRING_MATCH_EXTRABUFFS[j], HealBot_ScanTooltip:GetRegions())
            end
        end
        if itemText then
            HealBot_BuffExtraItems[itemText]=true
        end
    end
    if bag<4 then
        C_Timer.After(0.04, function() HealBot_BagScanBuffExtra(bag+1) end)
    else
        HealBot_Options_SetBuffExtraItemText()
        HealBot_luVars["BagsScanned"]=true
        HealBot_Timers_Set("LAST","InitItemsData")
    end
end

function HealBot_CheckBuffExtraItems()
    for x,_ in pairs(HealBot_BuffExtraItems) do
        HealBot_BuffExtraItems[x]=nil
    end
    HealBot_BagScanBuffExtra(0)
end

function HealBot_BagScanManaDrink(bag)
    local itemID=0
    local itemText=""
    local numSlots=HealBot_GetContainerNumSlots(bag)
    for slot = 1,numSlots do
        HealBot_ScanTooltip:SetBagItem(bag, slot)
        itemText=EnumerateTooltipLines_helper(HEALBOT_STRING_MATCH_RESTOREMANA, HealBot_ScanTooltip:GetRegions())
        if itemText then
            HealBot_ManaDrinkItems[itemText]=true
        end
    end
    if bag<4 then
        C_Timer.After(0.04, function() HealBot_BagScanManaDrink(bag+1) end)
    else
        C_Timer.After(0.04, HealBot_CheckBuffExtraItems)
    end
end

function HealBot_CheckManaDrinkItems()
    for x,_ in pairs(HealBot_ManaDrinkItems) do
        HealBot_ManaDrinkItems[x]=nil
    end
    HealBot_BagScanManaDrink(0)
end

function HealBot_BagScanWellFed(bag)
    local itemID=0
    local itemText=""
    local numSlots=HealBot_GetContainerNumSlots(bag)
    for slot = 1,numSlots do
        HealBot_ScanTooltip:SetBagItem(bag, slot)
        itemText=EnumerateTooltipLines_helper(HEALBOT_STRING_MATCH_WELLFED, HealBot_ScanTooltip:GetRegions())
        if itemText then
            HealBot_WellFedItems[itemText]=true
        end
    end
    if bag<4 then
        C_Timer.After(0.04, function() HealBot_BagScanWellFed(bag+1) end)
    else
        C_Timer.After(0.04, HealBot_CheckManaDrinkItems)
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
    HealBot_luVars["BagsScanned"]=false
    HealBot_ItemIdsInBags()
end

function HealBot_OnEvent_InvChange()
    HealBot_Timers_Set("PLAYER","InvChange")
end

function HealBot_Player_InvChange()
    if HealBot_luVars["AddonLoaded"] then
        if not HealBot_luVars["invCheck"] then
            HealBot_luVars["invCheck"]=true
            C_Timer.After(0.25, HealBot_Player_InvCheck)
        end
    else
        HealBot_OnEvent_InvChange()
    end
end

function HealBot_RefreshUnit(button)
    if not HealBot_RefreshQueueList[button.id] then
        HealBot_RefreshQueueList[button.id]=true
        table.insert(HealBot_RefreshQueue, button.id)
    end
end

function HealBot_Check_UnitAura(button)
    HealBot_Check_UnitDebuff(button)
    HealBot_Check_UnitBuff(button)
end

function HealBot_Check_UnitDebuff(button)
    if not HealBot_DebuffQueueList[button.id] then
        HealBot_DebuffQueueList[button.id]=true
        table.insert(HealBot_DebuffQueue, button.id)
    end
end

function HealBot_Check_UnitBuff(button)
    if not HealBot_BuffQueueList[button.id] then
        HealBot_BuffQueueList[button.id]=true
        table.insert(HealBot_BuffQueue, button.id)
    end
end

function HealBot_EnemyCheck_UnitAura(button)
    button.aura.update=true
end

function HealBot_UpdateAllHealth()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_OnEvent_UnitHealth(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_OnEvent_UnitHealth(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_OnEvent_UnitHealth(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_OnEvent_UnitHealth(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_OnEvent_UnitHealth(xButton)
    end
      --HealBot_setCall("HealBot_UpdateAllHealth")
end

function HealBot_OnEvent_SpecChange(button)
    if button.player then
        HealBot_OnEvent_SpellsChanged(1)
        HealBot_Player_TalentsChanged()
    elseif button.isplayer and not HealBot_Action_IsUnitDead(button) then
        if HealBot_Panel_RaidUnitGUID(button.guid) then HealBot_Action_setGuidData(button, "TMPSPEC", " ") end
        HealBot_QueueSpecUpdate(button)
    end
end

local hbHostile=false
function HealBot_OnEvent_ClassificationChanged(button)
    hbHostile=false
    if not UnitIsFriend("player",button.unit) then
        if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWHOSTILE"] then
            hbHostile=true
        end
        HealBot_Action_SetRangeSpellType(button, true)
    else
        HealBot_Action_SetRangeSpellType(button, false)
    end
    if button.status.hostile~=hbHostile then
        button.status.hostile=hbHostile
        HealBot_Aura_UpdateState(button)
    end
end

local hbafk=false
function HealBot_OnEvent_UnitFlagsChanged(button)
    hbafk=false
    if UnitIsAFK(button.unit) and Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWAFK"] then
        hbafk=true
    end
    if button.status.afk~=hbafk then
        button.status.afk=hbafk
        HealBot_Aura_UpdateState(button)
    end
end

function HealBot_OnEvent_UnitTarget(button)
    if button.status.current<HealBot_Unit_Status["DC"] then
        HealBot_CalcThreat(button)           
        if not HealBot_Data["UILOCK"] and HealBot_Panel_IsTargetingEnemy(button.unit) then
            HealBot_nextRecalcParty(5)
        end
    else
        HealBot_CheckUnitStatus(button)
    end
end

local hbCurrentTargetButton={}
function HealBot_AuxSetTargetBar()
    if HealBot_luVars["AuxTargetInUse"] or HealBot_luVars["AuxTargetOverlayInUse"] then
        if UnitExists("target") then
            xButton, pButton=HealBot_Panel_AllUnitButton(UnitGUID("target"))
            if xButton then
                HealBot_Aux_UpdateTargetBar(xButton)
                if HealBot_AuxAssigns["NameOverlayTarget"][xButton.frame] then
                    HealBot_Aux_UpdateNameOverLay(xButton, 6, true)
                end
                if HealBot_AuxAssigns["HealthOverlayTarget"][xButton.frame] then
                    HealBot_Aux_UpdateHealthOverLay(xButton, 6, true)
                end
                hbCurrentTargetButton[xButton]=true
            end
            if pButton then
                HealBot_Aux_UpdateTargetBar(pButton)
                if HealBot_AuxAssigns["NameOverlayTarget"][pButton.frame] then
                    HealBot_Aux_UpdateNameOverLay(pButton, 6, true)
                end
                if HealBot_AuxAssigns["HealthOverlayTarget"][pButton.frame] then
                    HealBot_Aux_UpdateHealthOverLay(pButton, 6, true)
                end
                hbCurrentTargetButton[pButton]=true
            end
        end
    end
end

function HealBot_PlayerTargetChanged()
    if not HealBot_luVars["PlayerTargetChanged"] then
        HealBot_luVars["PlayerTargetChanged"]=true
        C_Timer.After(0.02, function() HealBot_nextRecalcParty(3) end)
    end
end

local function HealBot_AuxClearTargetBar(button)
    HealBot_Aux_ClearTargetBar(button)
    if HealBot_AuxAssigns["NameOverlayTarget"][button.frame] then
        HealBot_Aux_UpdateNameOverLay(button, 6, false)
    end
    if HealBot_AuxAssigns["HealthOverlayTarget"][button.frame] then
        HealBot_Aux_UpdateHealthOverLay(button, 6, false)
    end
end

HealBot_luVars["AuxTargetInUse"]=false
function HealBot_OnEvent_PlayerTargetChanged()
    if HealBot_luVars["AuxTargetInUse"] or HealBot_luVars["AuxTargetOverlayInUse"] then
        for xButton,_ in pairs(hbCurrentTargetButton) do
            HealBot_AuxClearTargetBar(xButton)
            hbCurrentTargetButton[xButton]=nil
        end
    end
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][9]["STATE"] then
        if HealBot_luVars["TargetNeedReset"] and not InCombatLockdown() then
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
        elseif UnitExists("target") and HealBot_Extra_Button["target"] then
            HealBot_UpdateUnitGUIDChange(HealBot_Extra_Button["target"])
        end
        HealBot_PlayerTargetChanged()
    end
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][11]["STATE"] and Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCSELF"] then
        HealBot_nextRecalcParty(5)
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

local prdCheckActiveFrames={[1]=false, [2]=false, [3]=false, [4]=false, [5]=false, [6]=false, [7]=false, [8]=false, [9]=false, [10]=false}
function HealBot_UnitInCombat()
    if HealBot_luVars["UpdateEnemyFrame"] then
        HealBot_luVars["UpdateEnemyFrame"]=false
        HealBot_luVars["AllOutOfCombatCheck"]=TimeNow+1
        HealBot_Panel_PartyChanged(true, 5)
    end
end

function HealBot_CheckFramesOnCombatFrame(frame)
    local check=true
    if (frame==8 and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][9]["FRAME"]==8
                 and Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TARGETINCOMBAT"]==1)
        or
       (frame==9 and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["FRAME"]==9
                 and Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["FOCUSINCOMBAT"]==1) then
        check=false
    end
    if check and prdCheckActiveFrames[frame] and Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][frame]["AUTOCLOSE"]>1 then
        HealBot_luVars["CheckFramesOnCombat"]=true
    end
end

function HealBot_CheckActiveFrames(frame, active)
    if prdCheckActiveFrames[frame]~=active then
        prdCheckActiveFrames[frame]=active
        HealBot_Timers_Set("LAST","CheckFramesOnCombat")
    end
end

function HealBot_CheckFramesOnCombat()
    HealBot_luVars["CheckFramesOnCombat"]=false
    for f=1,10 do
        HealBot_CheckFramesOnCombatFrame(f)
    end
end

function HealBot_OnEvent_PlayerRegenDisabled()
    HealBot_Data["UILOCK"]=true
    HealBot_luVars["RegenDisabled"]=true
    HealBot_Timers_PlayerRegenDisabled()
    HealBot_luVars["CheckAuraFlags"]=true
    HealBot_PlayerCheck()
    if HealBot_RefreshTypes[0] then
        HealBot_RefreshTypes[1]=true
        HealBot_RefreshTypes[2]=true
        HealBot_RefreshTypes[3]=true
        HealBot_RefreshTypes[4]=true
        HealBot_RefreshTypes[6]=true
        HealBot_RefreshTypes[0]=false
    end
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["STATE"] then
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["FRAME"]==9 then
            if Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["FOCUSINCOMBAT"]==1 then
                HealBot_Action_HidePanel(9)
            elseif not HealBot_Action_FrameIsVisible(9) and Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["FOCUSINCOMBAT"]==3 then
                HealBot_RefreshTypes[4]=true
            end
        elseif Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["FOCUSINCOMBAT"]~=2 then
            HealBot_RefreshTypes[6]=true
        end
    end
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][9]["STATE"] then
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][9]["FRAME"]==8 then
            if Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TARGETINCOMBAT"]==1 then
                HealBot_Action_HidePanel(8)
            elseif not HealBot_Action_FrameIsVisible(8) and Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TARGETINCOMBAT"]==3 then
                HealBot_RefreshTypes[3]=true
            end
        elseif Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TARGETINCOMBAT"]~=2 then
            HealBot_RefreshTypes[6]=true
        end
    end
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["STATE"] then
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["FRAME"]==6 then
            if Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["VEHICLEINCOMBAT"] then
                HealBot_RefreshTypes[1]=true
            end
        elseif Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["VEHICLEINCOMBAT"] then
            HealBot_RefreshTypes[6]=true
        end
    end
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["STATE"] then
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["FRAME"]==7 then
            if Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["PRIVLISTPETSINCOMBAT"] then
                HealBot_RefreshTypes[2]=true
            end
        elseif Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["PRIVLISTPETSINCOMBAT"] then
            HealBot_RefreshTypes[6]=true
        end
    end
    if HealBot_RefreshTypes[6] then HealBot_RecalcParty(6); end
    if HealBot_RefreshTypes[1] then HealBot_RecalcParty(1); end
    if HealBot_RefreshTypes[2] then HealBot_RecalcParty(2); end
    if HealBot_RefreshTypes[3] then HealBot_RecalcParty(3); end
    if HealBot_RefreshTypes[4] then HealBot_RecalcParty(4); end
    HealBot_UnitInCombat()
    HealBot_UpdateAllUnitBars(true)
    if HealBot_luVars["CheckFramesOnCombat"] then
        for f=1,10 do
            if prdCheckActiveFrames[f] and Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][f]["AUTOCLOSE"]>1 then
                if not HealBot_Action_FrameIsVisible(f) then
                    HealBot_Action_ShowPanel(f)
                end
            end
        end
    end
    HealBot_HealthAlertLevel(true)
    if HealBot_Globals.DisableToolTipInCombat and HealBot_Data["TIPBUTTON"] then
        HealBot_Action_HideTooltipFrame()
    end

    if not HealBot_luVars["hlPlayerBarsIC"] and HealBot_luVars["HighlightTarget"] then
        HealBot_OnEvent_PlayerTargetChanged()
    end
    if not Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["LOWMANACOMBAT"] then HealBot_ClearLowMana() end
    HealBot_Action_ResetUnitStatus()
    if HealBot_luVars["rcEnd"] then
        HealBot_luVars["rcEnd"]=false
        HealBot_OnEvent_ReadyCheckClear(true)
    end
    
    if HealBot_luVars["pluginTimeToLive"] then C_Timer.After(0.1, function() HealBot_Plugin_TimeToLive_EnteringCombat() end) end
    if HealBot_luVars["pluginBuffWatch"] then C_Timer.After(0.2, function() HealBot_Plugin_BuffWatch_CombatState(true) end) end
    if HealBot_luVars["pluginHealthWatch"] then C_Timer.After(0.3, function() HealBot_Plugin_HealthWatch_CombatState(true) end) end
    if HealBot_luVars["pluginManaWatch"] then C_Timer.After(0.4, function() HealBot_Plugin_ManaWatch_CombatState(true) end) end
    --HealBot_Options_RaidTargetUpdate()
      --HealBot_setCall("HealBot_OnEvent_PlayerRegenDisabled")
end

function HealBot_PlayerCheck()
    if HealBot_luVars["isResting"] then
        if not IsResting() then
            HealBot_luVars["isResting"]=false
            if HealBot_Config_Buffs.NoAuraWhenRested then HealBot_luVars["CheckAuraFlags"]=true end
            HealBot_Timers_Set("PLAYER","SetRestingState")
        end
    elseif IsResting() then
        HealBot_luVars["isResting"]=true
        if HealBot_Config_Buffs.NoAuraWhenRested then HealBot_luVars["CheckAuraFlags"]=true end
        HealBot_Timers_Set("PLAYER","SetRestingState")
    end
    if HealBot_luVars["onTaxi"] then
        if not UnitOnTaxi("player") then
            HealBot_luVars["onTaxi"]=false
            HealBot_luVars["CheckAuraFlags"]=true
        end
    elseif UnitOnTaxi("player") then
        HealBot_luVars["onTaxi"]=true
        HealBot_luVars["CheckAuraFlags"]=true
    end
    if not HealBot_Config_Cures.DebuffWatchWhenMounted then
        if HealBot_luVars["debuffMounted"] then
            if HealBot_Data["UILOCK"] or not IsMounted() then
                HealBot_luVars["debuffMounted"]=false
                HealBot_luVars["CheckAuraFlags"]=true
                HealBot_Aura_setLuVars("PlayerMounted", false)
            end
        elseif IsMounted() then
            HealBot_luVars["debuffMounted"]=true
            HealBot_luVars["CheckAuraFlags"]=true
            HealBot_Aura_setLuVars("PlayerMounted", true)
        end
    end
    if not HealBot_Config_Buffs.BuffWatchWhenMounted then
        if HealBot_luVars["buffMounted"] then
            if HealBot_Data["UILOCK"] or not IsMounted() then
                HealBot_luVars["buffMounted"]=false
                HealBot_luVars["CheckAuraFlags"]=true
                HealBot_Aura_setLuVars("PlayerMounted", false)
            end
        elseif IsMounted() then
            HealBot_luVars["buffMounted"]=true
            HealBot_luVars["CheckAuraFlags"]=true
            HealBot_Aura_setLuVars("PlayerMounted", true)
        end
    end
    if HealBot_luVars["CheckAuraFlags"] then
        HealBot_luVars["CheckAuraFlags"]=false
        HealBot_Aura_SetAuraCheckFlags(HealBot_luVars["debuffMounted"], HealBot_luVars["buffMounted"], HealBot_luVars["onTaxi"], HealBot_luVars["isResting"])
    end
end

function HealBot_PlayerCheckExtended()
    if HealBot_Config_Buffs.BuffWatchWhenMounted then
        HealBot_luVars["buffMounted"]=false
    end
    if HealBot_Config_Cures.DebuffWatchWhenMounted then
        HealBot_luVars["debuffMounted"]=false
    end
    HealBot_luVars["CheckAuraFlags"]=true
    HealBot_PlayerCheck()
end

function HealBot_AuraCheck()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Check_UnitAura(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Check_UnitAura(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Check_UnitAura(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Check_UnitAura(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Check_UnitAura(xButton)
    end
    --HealBot_setCall("HealBot_AuraCheck")
end

function HealBot_CheckAllDebuffs()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Check_UnitDebuff(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Check_UnitDebuff(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Check_UnitDebuff(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Check_UnitDebuff(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Check_UnitDebuff(xButton)
    end
        --HealBot_setCall("HealBot_CheckAllActiveDebuffs")
end

function HealBot_CheckAllActiveDebuffs()
    for _,xButton in pairs(HealBot_Unit_Button) do
        if xButton.aura.debuff.type then
            HealBot_Check_UnitDebuff(xButton)
        end
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        if xButton.aura.debuff.type then
            HealBot_Check_UnitDebuff(xButton)
        end
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        if xButton.aura.debuff.type then
            HealBot_Check_UnitDebuff(xButton)
        end
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        if xButton.aura.debuff.type then
            HealBot_Check_UnitDebuff(xButton)
        end
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        if xButton.aura.debuff.type then
            HealBot_Check_UnitDebuff(xButton)
        end
    end
        --HealBot_setCall("HealBot_CheckAllActiveDebuffs")
end

function HealBot_CheckAllActiveBuffs()
    for _,xButton in pairs(HealBot_Unit_Button) do
        if xButton.aura.buff.name then
            HealBot_Check_UnitBuff(xButton)
        end
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        if xButton.aura.buff.name then
            HealBot_Check_UnitBuff(xButton)
        end
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        if xButton.aura.buff.name then
            HealBot_Check_UnitBuff(xButton)
        end
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        if xButton.aura.buff.name then
            HealBot_Check_UnitBuff(xButton)
        end
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        if xButton.aura.buff.name then
            HealBot_Check_UnitBuff(xButton)
        end
    end
        --HealBot_setCall("HealBot_CheckAllActiveBuffs")
end

function HealBot_UpdateAllIconsAlpha()
    if not HealBot_luVars["TestBarsOn"] then
        for _,xButton in pairs(HealBot_Unit_Button) do
            HealBot_Aura_Update_AllIcons(xButton)
        end
        for _,xButton in pairs(HealBot_Private_Button) do
            HealBot_Aura_Update_AllIcons(xButton)
        end
        for _,xButton in pairs(HealBot_Pet_Button) do
            HealBot_Aura_Update_AllIcons(xButton)
        end
        for _,xButton in pairs(HealBot_Vehicle_Button) do
            HealBot_Aura_Update_AllIcons(xButton)
        end
        for _,xButton in pairs(HealBot_Extra_Button) do
            HealBot_Aura_Update_AllIcons(xButton)
        end
    end
end

function HealBot_GetUnitName(button)
    return button.name or UnitName(button.unit) or button.unit or HEALBOT_WORDS_UNKNOWN
end

function HealBot_SetUnitName(name, hbGUID)
    HealBot_customTempUserName[hbGUID]=name
    xButton,pButton = HealBot_Panel_RaidUnitButton(hbGUID)
    if xButton then
        xButton.name=name
        HealBot_Action_setGuidData(xButton, "NAME", name)
        HealBot_Text_setNameText(xButton)
    end
    if pButton then 
        pButton.name=name
        HealBot_Action_setGuidData(pButton, "NAME", name) 
        HealBot_Text_setNameText(pButton)
    end
end

function HealBot_DelUnitName(hbGUID)
    HealBot_customTempUserName[hbGUID]=nil
    xButton,pButton = HealBot_Panel_RaidUnitButton(hbGUID)
    if xButton and UnitExists(xButton.unit) then
        xButton.name=UnitName(xButton.unit)
        HealBot_Action_setGuidData(xButton, "NAME", xButton.name) 
        HealBot_Text_setNameText(xButton)
    end
    if pButton and UnitExists(pButton.unit) then
        pButton.name=UnitName(pButton.unit)
        HealBot_Action_setGuidData(pButton, "NAME", pButton.name) 
        HealBot_Text_setNameText(pButton)
    end
end

local upUnit=false
function HealBot_UnitPet(unit)
    upUnit=false
    if strsub(unit,1,4)=="raid" then
        upUnit="raidpet"..strsub(unit,5)
    elseif UnitIsUnit(unit,"player") then
        upUnit="pet"
    elseif strsub(unit,1,5)=="party" then
        upUnit="partypet"..strsub(unit,6)
    end
      --HealBot_setCall("HealBot_UnitPet")
    return upUnit
end

function HealBot_OnEvent_PartyMembersChanged()
    HealBot_Timers_Set("INIT","RefreshPartyNextRecalcPlayers")
    if HealBot_Data["UILOCK"] then 
        HealBot_CheckAllPartyGUIDs()
    end
      --HealBot_setCall("HealBot_OnEvent_PartyMembersChanged")
end

function HealBot_OnEvent_PetsChanged()
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["STATE"] then
        HealBot_Timers_Set("INIT","RefreshPartyNextRecalcPets")
    end
    if HealBot_Data["UILOCK"] then 
        HealBot_CheckAllPetGUIDs()
    end
end

function HealBot_retHighlightTarget()
      --HealBot_setCall("HealBot_retHighlightTarget")
    return HealBot_luVars["HighlightTarget"] or "nil"
end

function HealBot_retHbFocus(unit)
    local unitName=UnitName(unit)
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

function HealBot_OnEvent_ReadyCheckUpdate(button,response)
    if HealBot_luVars["rcEnd"] and button.isplayer and Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWRC"] then
        if response then
            button.icon.extra.readycheck=READY_CHECK_READY_TEXTURE
            HealBot_Aura_UpdateState(button)
        else
            button.icon.extra.readycheck=READY_CHECK_NOT_READY_TEXTURE
            HealBot_Aura_UpdateState(button)
        end
    end
      --HealBot_setCall("HealBot_OnEvent_ReadyCheckUpdate")
end

function HealBot_ReadyCheckUnit(button)
    if HealBot_luVars["rcEnd"] and button.isplayer and HealBot_luVars["rcEnd"]>TimeNow then
        button.icon.extra.readycheck=HealBot_Action_getGuidData(button.guid, "READYCHECK")
    else
        button.icon.extra.readycheck=false
    end
    HealBot_Aura_UpdateState(button)
end

function HealBot_ReadyCheck()
    if HealBot_luVars["rcEnd"] and HealBot_luVars["rcEnd"]>TimeNow then
        for _,xButton in pairs(HealBot_Unit_Button) do
            xButton.icon.extra.readycheck=HealBot_Action_getGuidData(xButton.guid, "READYCHECK")
            HealBot_Aura_UpdateState(xButton)
        end
        for _,xButton in pairs(HealBot_Private_Button) do
            xButton.icon.extra.readycheck=HealBot_Action_getGuidData(xButton.guid, "READYCHECK")
            HealBot_Aura_UpdateState(xButton)
        end
    end
end

function HealBot_OnEvent_ReadyCheck(unitName,timer)
    if HealBot_UnitNameOnly(unitName) then
        local lUnit=HealBot_Panel_RaidUnitName(HealBot_UnitNameOnly(unitName))
        HealBot_luVars["rcEnd"]=TimeNow+timer
        for _,xButton in pairs(HealBot_Unit_Button) do
            if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][xButton.frame]["SHOWRC"] then 
                xButton.icon.extra.readycheck=READY_CHECK_WAITING_TEXTURE
                HealBot_Aura_UpdateState(xButton)
            end
        end
        for _,xButton in pairs(HealBot_Private_Button) do
            if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][xButton.frame]["SHOWRC"] then
                xButton.icon.extra.readycheck=READY_CHECK_WAITING_TEXTURE
                HealBot_Aura_UpdateState(xButton)
            end
        end
        if lUnit then
            _,xButton,pButton = HealBot_UnitID(lUnit)
            if xButton then HealBot_OnEvent_ReadyCheckUpdate(xButton,true) end
            if pButton then HealBot_OnEvent_ReadyCheckUpdate(pButton,true) end
        end
    end
      --HealBot_setCall("HealBot_OnEvent_ReadyCheck")
end

function HealBot_OnEvent_ReadyCheckConfirmed(unit,response)
    _,xButton,pButton = HealBot_UnitID(unit)
    if xButton then HealBot_OnEvent_ReadyCheckUpdate(xButton,response) end
    if pButton then HealBot_OnEvent_ReadyCheckUpdate(pButton,response) end
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
        C_Timer.After(0.02, function() HealBot_nextRecalcParty(4) end)
    else
        HealBot_nextRecalcParty(4)
    end
end

function HealBot_OnEvent_FocusChanged()
    HealBot_FocusChanged()
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][11]["STATE"] and Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCFOCUS"] then
        HealBot_nextRecalcParty(5)
    end
    if HealBot_Data["UILOCK"] and UnitExists("focus") and HealBot_Extra_Button["focus"] then
        HealBot_UpdateUnitGUIDChange(HealBot_Extra_Button["focus"])
    end
      --HealBot_setCall("HealBot_OnEvent_FocusChanged")
end

function HealBot_Player_TalentsChanged()
    _,xButton,pButton = HealBot_UnitID("player")
    if xButton then xButton.spec = " " end
    if pButton then pButton.spec = " " end
    HealBot_Timers_Set("INIT","CheckTalentInfo")
    HealBot_Timers_Set("AURA","CheckPlayer")
      --HealBot_setCall("HealBot_OnEvent_TalentsChanged")
end

function HealBot_OnEvent_SpellsChanged(arg1)
    if arg1==0 then return; end
    HealBot_Timers_Set("LAST","InitLoadSpells",0.5)
      --HealBot_setCall("HealBot_OnEvent_SpellsChanged")
end

function HealBot_resetLuVars()
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
end

function HealBot_OnEvent_PlayerEnteringWorld()
    HealBot_resetLuVars()
    HealBot_luVars["CheckAuraFlags"]=true
    HealBot_luVars["DropCombat"]=1
    HealBot_Timers_Set("LAST","EnteringWorld")
    HealBot_luVars["qaFRNext"]=TimeNow+5
      --HealBot_setCall("HealBot_OnEvent_PlayerEnteringWorld")
end

function HealBot_OnEvent_PlayerLeavingWorld()
    HealBot_luVars["qaFRNext"]=TimeNow+90
    HealBot_Options_SaveProfile()
    HealBot_Timers_Set("LAST","EndAggro")
    --HealBot_UnRegister_Events();
      --HealBot_setCall("HealBot_OnEvent_PlayerLeavingWorld")
end

HealBot_luVars["massResTime"]=0
HealBot_luVars["massResUnit"]="-nil"
HealBot_luVars["massResAltTime"]=0
HealBot_luVars["massResAltUnit"]="-nil"

function HealBot_UnitSummonsUpdate(button, state)
    if button.status.summons and not state then
        button.status.summons=false
        HealBot_Text_setNameTag(button)
        HealBot_Aux_ClearSummonsBar(button)
    elseif not button.status.summons then
        button.status.summons=true
        HealBot_Text_setNameTag(button)
        HealBot_Aux_UpdateSummonsBar(button, HEALBOT_WORD_SUMMONS, TimeNow*1000, (TimeNow+120)*1000, true)
    end
end

function HealBot_OnEvent_IncomingSummons(unit)
    _,xButton,pButton = HealBot_UnitID(unit, true)
    if C_IncomingSummon.IncomingSummonStatus(unit)==1 then
        if xButton then HealBot_UnitSummonsUpdate(xButton, true) end
        if pButton then HealBot_UnitSummonsUpdate(pButton, true) end
    else
        if xButton then HealBot_UnitSummonsUpdate(xButton, false) end
        if pButton then HealBot_UnitSummonsUpdate(pButton, false) end
    end
end

function HealBot_OnEvent_UnitSpellCastStart(button, unitTarget, castGUID, spellID)
    if button.status.current<HealBot_Unit_Status["DC"] then
        if HealBot_AuxAssigns["CastBar"][button.frame] and button.status.unittype~=11 then
            scName, _, _, scStartTime, scEndTime = UnitCastingInfo(button.unit) 
            if scEndTime then
                button.status.castend=scEndTime
                HealBot_Aux_UpdateCastBar(button, scName, scStartTime, scEndTime, false)
            end
        else
            scName=GetSpellInfo(spellID) or spellID or "x"
        end
        if HealBot_ResSpells[scName] then
            --HealBot_AddDebug("CastStart res "..scName, "Spell Cast", true)
            if HealBot_ResSpells[scName]==2 then
                if HealBot_luVars["massResTime"]<TimeNow then
                    HealBot_luVars["massResUnit"]=button.unit
                    HealBot_luVars["massResTime"]=TimeNow+10
                elseif HealBot_luVars["massResAltTime"]<TimeNow and HealBot_luVars["massResUnit"]~=button.unit then
                    HealBot_luVars["massResAltUnit"]=button.unit
                    HealBot_luVars["massResAltTime"]=TimeNow+10
                end
            end
        end
    else
        HealBot_CheckUnitStatus(button)
    end
end

function HealBot_OnEvent_UnitSpellChanStart(button, unitTarget, castGUID, spellID)
    if HealBot_AuxAssigns["CastBar"][button.frame] and button.status.unittype~=11 then
        scName, _, _, scStartTime, scEndTime = UnitChannelInfo(button.unit) 
        if scEndTime then
            button.status.castend=scEndTime
            HealBot_Aux_UpdateCastBar(button, scName, scStartTime, scEndTime, true)
        end
    end
    if button.player then HealBot_Queue_Cooldown(spellID) end
end

function HealBot_OnEvent_UnitSpellCastStop(button, unitTarget, castGUID, spellID)
    if castGUID==HealBot_luVars["overhealCastID"] then
        _,xButton,pButton = HealBot_UnitID(HealBot_luVars["overhealUnit"], true)
        HealBot_luVars["overhealUnit"]="-nil-"
        HealBot_luVars["overhealCastID"]="-nil-"
        if xButton and xButton.health.auxoverheal>0 then
            xButton.health.overheal=0
            xButton.health.auxoverheal=0
            HealBot_Aux_UpdateOverHealBar(xButton)
            HealBot_OverHealText(xButton)
        end
        if pButton and pButton.health.auxoverheal>0 then
            pButton.health.overheal=0
            pButton.health.auxoverheal=0
            HealBot_Aux_UpdateOverHealBar(pButton)
            HealBot_OverHealText(pButton)
        end
    end
    if button.status.castend>0 and button.status.unittype~=11 then
        HealBot_Aux_ClearCastBar(button)
    end

    if HealBot_luVars["massResUnit"]==button.unit then HealBot_luVars["massResUnit"]="-nil" end
    if HealBot_luVars["massResAltUnit"]==button.unit then HealBot_luVars["massResAltUnit"]="-nil" end
    if button.player then HealBot_Queue_Cooldown(spellID) end
end

function HealBot_OnEvent_UnitSpellCastComplete(button, unitTarget, castGUID, spellID)
    -- Only registered for the Player!
    --if button.player then
        if (HealBot_Config_Cures.IgnoreOnCooldownDebuffs and HealBot_Options_retIsDebuffSpell(spellID)) then
            HealBot_luVars["CheckAllActiveDebuffs"]=true
        elseif HealBot_Aura_IsBuffSpell(spellID) then  
            HealBot_luVars["CheckAllActiveBuffs"]=true
        end
        HealBot_Queue_Cooldown(spellID)
    --end
end

function HealBot_OnEvent_UnitSpellCastFailed(button, unitTarget, castGUID, spellID)
    if HealBot_luVars["massResUnit"]==button.unit then
        HealBot_luVars["massResTime"]=0
        HealBot_luVars["massResUnit"]="-nil"
    elseif HealBot_luVars["massResAltUnit"]==button.unit then
        HealBot_luVars["massResAltTime"]=0
        HealBot_luVars["massResAltUnit"]="-nil"
    end
end

function HealBot_MassRes()
    if HealBot_luVars["massResTime"]>TimeNow or HealBot_luVars["massResAltTime"]>TimeNow then
        return true
    else
        return false
    end
end

local uscUnit, uscUnitName, uscSpellName=nil,false,false
function HealBot_OnEvent_UnitSpellCastSent(caster,unitName,castGUID,spellID)
    if UnitIsUnit("player",caster) then
        uscUnit=nil
        uscUnitName = HealBot_UnitNameOnly(unitName)
        uscSpellName = GetSpellInfo(spellID) or spellID
        
        if uscUnitName == HEALBOT_WORDS_UNKNOWN then
            uscUnitName = HealBot_GetCorpseName(uscUnitName)
        end
        
        if uscUnitName=="" then
            if spellID==HEALBOT_MENDPET and UnitExists("pet") then
                uscUnitName=UnitName("pet")
                uscUnit="pet"
            end
        else
            uscUnit=HealBot_Panel_RaidUnitName(uscUnitName)
            if uscUnit and not UnitExists(uscUnit) then uscUnit=nil end
        end

        if uscUnit and uscUnitName then
            _,xButton,pButton=HealBot_UnitID(uscUnit)
            if (xButton and Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][xButton.frame]["OVERHEAL"]<3) or
               (pButton and Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][pButton.frame]["OVERHEAL"]<3) then
                HealBot_luVars["overhealUnit"]=uscUnit
                HealBot_luVars["overhealCastID"]=castGUID
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
        HealBot_Queue_Cooldown(spellID)
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
    if z==3 and UnitIsPlayer(unit) and UnitPlayerControlled(unit) and not UnitIsUnit("player",unit) then
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
    local unitName=UnitName(unit)
    if HealBot_Globals.FocusMonitor[unitName] then
        if UnitExists("target") and unitName==UnitName("target") then HealBot_Panel_clickToFocus("hide") end
        HealBot_Globals.FocusMonitor[unitName] = nil
    else
        HealBot_Globals.FocusMonitor[unitName] = zone
        if UnitExists("target") and HealBot_Globals.FocusMonitor[UnitName("target")] then HealBot_Panel_clickToFocus("Show") end
    end
      --HealBot_setCall("HealBot_ToggelFocusMonitor")
end

function HealBot_PlaySound(id)
    PlaySoundFile(LSM:Fetch('sound',id));
      --HealBot_setCall("HealBot_PlaySound")
end

function HealBot_InitSmartCast()
    HealBot_SetResSpells()
    HealBot_Action_SetrSpell()
    HealBot_Init_SmartCast();
end

function HealBot_InitSpells()
    HealBot_Init_Spells_Defaults();
    HealBot_Options_InitDebuffTypes()
    HealBot_Timers_Set("PLAYER","InitSmartCast",1)
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
                HealBot_Timers_Set("LAST","DisableCheck")
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

function HealBot_Update_AuxRange(button)
    HealBot_Update_OORBar(button)
    HealBot_Update_Range30Bar(button)
end

function HealBot_AuxResetRange()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Update_AuxRange(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Update_AuxRange(xButton)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Update_AuxRange(xButton)
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        HealBot_Update_AuxRange(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Update_AuxRange(xButton)
    end
    for _,xButton in pairs(HealBot_Vehicle_Button) do
        HealBot_Update_AuxRange(xButton)
    end
end

function HealBot_Update_OORBar(button)
    if button.player or button.status.range==1 then
        if HealBot_AuxAssigns["OORBar"][button.frame] then
            HealBot_Aux_ClearOORBar(button)
        end
        if HealBot_AuxAssigns["NameOverlayOOR"][button.frame] then
            HealBot_Aux_UpdateNameOverLay(button, 7, false)
        end
        if HealBot_AuxAssigns["HealthOverlayOOR"][button.frame] then
            HealBot_Aux_UpdateHealthOverLay(button, 7, false)
        end
    else
        if HealBot_AuxAssigns["OORBar"][button.frame] then
            HealBot_Aux_UpdateOORBar(button)
        end
        if HealBot_AuxAssigns["NameOverlayOOR"][button.frame] then
            HealBot_Aux_UpdateNameOverLay(button, 7, true)
        end
        if HealBot_AuxAssigns["HealthOverlayOOR"][button.frame] then
            HealBot_Aux_UpdateHealthOverLay(button, 7, true)
        end
    end
end

function HealBot_Update_Range30Bar(button)
    if HealBot_AuxAssigns["Range30Bar"][button.frame] then
        if not button.player and button.status.range30 then
            HealBot_Aux_UpdateRange30Bar(button)
        else
            HealBot_Aux_ClearRange30Bar(button)
        end
    end
end

function HealBot_Clear_RecentHealsBar(button)
    if button.status.playerlastheal<TimeNow then
        HealBot_Aux_ClearRecentHealsBar(button)
        if HealBot_AuxAssigns["NameOverlayRecentHeals"][button.frame] then
            HealBot_Aux_UpdateNameOverLay(button, 1, false)
        end
        if HealBot_AuxAssigns["HealthOverlayRecentHeals"][button.frame] then
            HealBot_Aux_UpdateHealthOverLay(button, 1, false)
        end
    else
        C_Timer.After((button.status.playerlastheal-TimeNow)+0.05, function() HealBot_Clear_RecentHealsBar(button) end)
    end
end

function HealBot_Update_RecentHealsBar(button)
    HealBot_luVars["RecentHealsBarSetCTimerSet"]=false
    if HealBot_AuxAssigns["RecentHeals"][button.frame] then
        if button.status.playerlastheal<TimeNow then
            HealBot_Aux_UpdateRecentHealsBar(button)
            HealBot_luVars["RecentHealsBarSetCTimerSet"]=true
        end
    end
    if HealBot_AuxAssigns["NameOverlayRecentHeals"][button.frame] then
        if button.status.playerlastheal<TimeNow then
            HealBot_Aux_UpdateNameOverLay(button, 1, true)
            HealBot_luVars["RecentHealsBarSetCTimerSet"]=true
        end
    end
    if HealBot_AuxAssigns["HealthOverlayRecentHeals"][button.frame] then
        if button.status.playerlastheal<TimeNow then
            HealBot_Aux_UpdateHealthOverLay(button, 1, true)
            HealBot_luVars["RecentHealsBarSetCTimerSet"]=true
        end
    end
    
    if HealBot_luVars["RecentHealsBarSetCTimerSet"] then
        C_Timer.After(0.75, function() HealBot_Clear_RecentHealsBar(button) end)
    end
    button.status.playerlastheal=TimeNow+0.7
end

local uRange,sRange,sRange30=0,0,false
function HealBot_UnitInRangeInc30(button, spellName)
    if button.player then
        uRange = 1
        sRange30 = false
    elseif not HealBot_UnitInPhase(button.unit) then 
        uRange = -2
        sRange30 = false
    elseif not UnitIsVisible(button.unit) then 
        uRange = -1
        sRange30 = false
    elseif CheckInteractDistance(button.unit, 4) then
        uRange = 1
        sRange30 = true
    else
        sRange30=false
        if spellName then
            sRange=IsSpellInRange(spellName, button.unit) or IsItemInRange(spellName, button.unit)
        else
            sRange=false
        end
        if type(sRange)~="number" then
            if sRange or UnitInRange(button.unit) then
                uRange = 1
            else
                uRange = 0
            end
        else
            uRange = sRange
        end
    end
    --HealBot_setCall("HealBot_UnitInRange")
    return uRange,sRange30
end

function HealBot_UnitInRangeExc30(button, spellName)
    if button.player then
        uRange = 1
    elseif not HealBot_UnitInPhase(button.unit) then 
        uRange = -2
    elseif not UnitIsVisible(button.unit) then 
        uRange = -1
    elseif CheckInteractDistance(button.unit, 4) then
        uRange = 1
    else
        if spellName then
            sRange=IsSpellInRange(spellName, button.unit) or IsItemInRange(spellName, button.unit)
        else
            sRange=false
        end
        if type(sRange)~="number" then
            if sRange or UnitInRange(button.unit) then
                uRange = 1
            else
                uRange = 0
            end
        else
            uRange = sRange
        end
    end
    --HealBot_setCall("HealBot_UnitInRange")
    return uRange,true
end

local HealBot_UnitInRange=HealBot_UnitInRangeInc30
function HealBot_setFuncUnitInRange()
    if HealBot_luVars["AuxRange30InUse"] then
        HealBot_UnitInRange=HealBot_UnitInRangeInc30
    else
        HealBot_UnitInRange=HealBot_UnitInRangeExc30
    end
end

local hbRangeRequests={}
function HealBot_Requests(guid, state)
    if state then
        hbRangeRequests[guid]=true
    else
        hbRangeRequests[guid]=nil
    end
end

function HealBot_RequestsClearButton(button)
    if button.request.colbar>0 then
        if button.request.colbar==3 then HealBot_Action_DisableBorderHazardType(button, "PLUGIN") end
        button.request.colbar=0
        HealBot_Action_UpdateRequestButton(button)
    end
end

function HealBot_RequestsClear()
    hbRangeRequests={}
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_RequestsClearButton(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_RequestsClearButton(xButton)
    end
end

local newRange,oldRange,newRange30=-99,99,false
function HealBot_UpdateUnitRange(button) 
    if button.status.current<HealBot_Unit_Status["DC"] then
        newRange,newRange30=HealBot_UnitInRange(button, button.status.rangespell)
        button.status.rangenextcheck=TimeNow+HealBot_luVars["rangeCheckAdj"]
        if newRange~=button.status.range then
            oldRange=button.status.range
            button.status.range,button.status.range30=newRange,newRange30
            if button.status.range<0 or oldRange<0 then 
                HealBot_OnEvent_HealsInUpdate(button)
                HealBot_OnEvent_AbsorbsUpdate(button)
            end
            if hbRangeRequests[button.guid] and button.status.range>-1 then
                HealBot_Plugin_Requests_CancelGUID(button.guid)
                hbRangeRequests[button.guid]=nil
            end
            if button.status.enabled or button.status.range==1 or oldRange==1 then
                if button.status.dirarrowshown>0 or (Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWDIR"] and button.status.range==0) then
                    HealBot_Action_ShowDirectionArrow(button, TimeNow)
                end
                if HealBot_Emerg_Button[button.id].state>0 then
                    HealBot_Action_EmergBarCheck(button, true)
                end
                if HealBot_Action_IsUnitDead(button) then
                    HealBot_Text_UpdateButton(button)
                else
                    HealBot_Text_setNameTag(button)
                end
                if Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][button.frame]["OORLAST"] then
                    if button.status.unittype<7 then 
                        HealBot_Timers_Set("INIT","RefreshPartyNextRecalcPlayers")
                    elseif button.status.unittype<9 then
                        HealBot_Timers_Set("INIT","RefreshPartyNextRecalcPets")
                    end
                end
                if button.mouseover and HealBot_Data["TIPBUTTON"] then 
                    HealBot_Action_RefreshTooltip() 
                end
                HealBot_Action_UpdateHealthHotBar(button)
            end
            if button.frame<10 then 
                if button.aura.buff.name then 
                    HealBot_Aura_BuffWarnings(button, button.aura.buff.name, true) 
                end
                if button.aura.debuff.id>0 then 
                    HealBot_Aura_DebuffWarnings(button, button.aura.debuff.name, true) 
                end
            end
            HealBot_Update_AuxRange(button)
            HealBot_RefreshUnit(button)
        elseif newRange30~=button.status.range30 then
            button.status.range30=newRange30
            HealBot_Update_Range30Bar(button)
        end
    else
        button.status.range=-3
    end
        --HealBot_setCall("HealBot_UpdateUnitRange")
end

local hbPi = math.pi
local hbaTan2 = math.atan2
local hbdMod = 108 / math.pi / 2;
local dcDirection, dcX, dcY = false,false,false
local dcPlayerX, dcPlayerY, dcPlayerFacing=false, false, false
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

function HealBot_Options_ResetSetting(resetTab)
    if resetTab=="BUFF" then
        local msg="Healbot recommends resetting the buffs tab \n\n Continue?"
        StaticPopupDialogs["HEALBOT_OPTIONS_RESETSETTING"] = {
            text = msg,
            button1 = HEALBOT_WORDS_YES,
            button2 = HEALBOT_WORDS_NO,
            OnAccept = function()
                HealBot_Globals.VersionResetDone["BUFF"]="9.1.0.0"
                HealBot_Reset_Buffs()
            end,
            timeout = 0,
            whileDead = 1,
            hideOnEscape = 1
        };
    elseif resetTab=="CDEBUFF" then
        local msg="Healbot recommends resetting the custom debuffs tab \n\n Continue?"
        StaticPopupDialogs["HEALBOT_OPTIONS_RESETSETTING"] = {
            text = msg,
            button1 = HEALBOT_WORDS_YES,
            button2 = HEALBOT_WORDS_NO,
            OnAccept = function()
                HealBot_Globals.VersionResetDone["CDEBUFF"]="9.1.0.0"
                HealBot_ResetCustomDebuffs()
            end,
            timeout = 0,
            whileDead = 1,
            hideOnEscape = 1
        };
    elseif resetTab=="ICONS" then
        local msg="Healbot recommends resetting HoT/buff icons\n\n Continue?"
        StaticPopupDialogs["HEALBOT_OPTIONS_RESETSETTING"] = {
            text = msg,
            button1 = HEALBOT_WORDS_YES,
            button2 = HEALBOT_WORDS_NO,
            OnAccept = function()
                HealBot_Globals.VersionResetDone["ICONS"]="10.0.0.0"
                HealBot_Reset_Icons()
            end,
            timeout = 0,
            whileDead = 1,
            hideOnEscape = 1
        };
    end

    StaticPopup_Show ("HEALBOT_OPTIONS_RESETSETTING");
      --HealBot_setCall("HealBot_Options_ResetSetting")
end

function HealBot_Copy_SpellCombo(combo, maxButtons)
    if combo then
        for y=1,maxButtons do
            local button = HealBot_Options_ComboClass_Button(y)
            combo[button] = combo[button..HealBot_Config.CurrentSpec]
            combo["Shift"..button] = combo["Shift"..button..HealBot_Config.CurrentSpec]
            combo["Ctrl"..button] = combo["Ctrl"..button..HealBot_Config.CurrentSpec]
            combo["Alt"..button] = combo["Alt"..button..HealBot_Config.CurrentSpec]
            combo["Ctrl-Shift"..button] = combo["Ctrl-Shift"..button..HealBot_Config.CurrentSpec]
            combo["Alt-Shift"..button] = combo["Alt-Shift"..button..HealBot_Config.CurrentSpec]
            combo["Alt-Ctrl"..button] = combo["Alt-Ctrl"..button]
            combo["Alt-Ctrl-Shift"..button] = combo["Alt-Ctrl-Shift"..button]
        end
    end
end

function HealBot_Copy_SpellCombos()
    if HEALBOT_GAME_VERSION<3 then return end
    HealBot_Copy_SpellCombo(HealBot_Config_Spells.EnabledKeyCombo, 20)
    HealBot_Copy_SpellCombo(HealBot_Config_Spells.EnemyKeyCombo, 20)
    HealBot_Copy_SpellCombo(HealBot_Config_Spells.EmergKeyCombo, 5)
    HealBot_Update_SpellCombos()
    HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_CONFIRMSPELLCOPY)
      --HealBot_setCall("HealBot_Copy_SpellCombos")
end

function HealBot_Reset_Spells()
    HealBot_DoReset_Spells(HealBot_Data["PCLASSTRIM"])
    HealBot_Update_SpellCombos()
    HealBot_Timers_InitExtraOptions()
    HealBot_Timers_Set("INIT","SpellsTabText")
    HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_CONFIRMSPELLRESET)
      --HealBot_setCall("HealBot_Reset_Spells")
end

function HealBot_Reset_Buffs()
    HealBot_DoReset_Buffs(HealBot_Data["PCLASSTRIM"])
    HealBot_Config_Buffs.BuffWatch=HealBot_Config_BuffsDefaults.BuffWatch
    HealBot_Config_Buffs.BuffWatchInCombat=HealBot_Config_BuffsDefaults.BuffWatchInCombat
    HealBot_Config_Buffs.BuffWatchWhenGrouped=HealBot_Config_BuffsDefaults.BuffWatchWhenGrouped
    HealBot_Config_Buffs.BuffWatchWhenMounted=HealBot_Config_BuffsDefaults.BuffWatchWhenMounted
    HealBot_Config_Buffs.ExtraBuffsOnlyInInstance=HealBot_Config_BuffsDefaults.ExtraBuffsOnlyInInstance
    HealBot_Config_Buffs.ShortBuffTimer=HealBot_Config_BuffsDefaults.ShortBuffTimer
    HealBot_Config_Buffs.LongBuffTimer=HealBot_Config_BuffsDefaults.LongBuffTimer
    HealBot_Config_Buffs.SoundBuffWarning=HealBot_Config_BuffsDefaults.SoundBuffWarning
    HealBot_Config_Buffs.SoundBuffPlay=HealBot_Config_BuffsDefaults.SoundBuffPlay
    HealBot_Config_Buffs.ShowBuffWarning=HealBot_Config_BuffsDefaults.ShowBuffWarning
    HealBot_Config_Buffs.CBshownHB=HealBot_Config_BuffsDefaults.CBshownHB
    HealBot_Config_Buffs.CustomBuffCheck=HealBot_Config_BuffsDefaults.CustomBuffCheck
    HealBot_Config_Buffs.CustomBuffName=HealBot_Config_BuffsDefaults.CustomBuffName
    HealBot_Config_Buffs.CustomItemName=HealBot_Config_BuffsDefaults.CustomItemName
    HealBot_Update_BuffsForSpec("Buff")
    HealBot_Timers_InitExtraOptions()
    HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_CONFIRMBUFFSRESET)
    HealBot_Timers_Set("AURA","BuffReset")
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
    HealBot_Config_Cures.DebuffWatchWhenMounted=HealBot_Config_CuresDefaults.DebuffWatchWhenMounted
    HealBot_Config_Cures.ShowDebuffWarning=HealBot_Config_CuresDefaults.ShowDebuffWarning
    HealBot_Config_Cures.CDCshownHB=HealBot_Config_CuresDefaults.CDCshownHB
    HealBot_Update_BuffsForSpec("Debuff")
    HealBot_Timers_InitExtraOptions()
    HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_CONFIRMCURESRESET)
    HealBot_Timers_Set("AURA","DebuffReset")
      --HealBot_setCall("HealBot_Reset_Cures")
end

function HealBot_Reset_Icons()
    HealBot_Globals.IgnoreCustomBuff={}
    HealBot_Globals.HealBot_Custom_Buffs={}
    HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol={}
    HealBot_Globals.CustomBuffBarColour = {[HEALBOT_CUSTOM_en.."Buff"] = { R = 0.25, G = 0.58, B = 0.8, },}
    HealBot_Globals.WatchHoT=HealBot_Options_copyTable(HealBot_GlobalsDefaults.WatchHoT)
    HealBot_Timers_InitExtraOptions()
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
    HealBot_DoReset_Spells(HealBot_Data["PCLASSTRIM"])
    HealBot_Update_BuffsForSpec()
    HealBot_Update_SpellCombos()
    HealBot_Aura_ClearAllBuffs()
    HealBot_Aura_ClearAllDebuffs()
      --HealBot_setCall("HealBot_runDefaults")
end

function HealBot_ClearGUID(guid)
    if not HealBot_Panel_AllUnitGUID(guid) then
        HealBot_Action_ClearGUID(guid)
        HealBot_Aura_ClearGUID(guid)
        if HealBot_Data["TIPUSE"] then HealBot_Tooltip_ClearGUID(guid) end
    end
end

function HealBot_QueueClearGUID(guid)
    if string.len(guid)>12 then
        hbRangeRequests[guid]=nil
        hbHealthWatch[guid]=nil
        hbManaWatch[guid]=nil
        HealBot_ClearGUIDQueue[guid]=0
    end
end

local arg1,arg2,arg3,arg4,eButton,ePrivate,eUnit = false,false,false,false,false,false,false
function HealBot_OnEvent(self, event, ...)
    arg1,arg2,arg3,arg4 = ...;
    if (event=="UNIT_SPELLCAST_SENT") then
        HealBot_OnEvent_UnitSpellCastSent(arg1,arg2,arg3,arg4);  
    elseif (event=="SPELL_UPDATE_COOLDOWN") then
        if HealBot_Data["TIPBUTTON"] then HealBot_Action_RefreshTooltip() end
        if HealBot_luVars["pluginMyCooldowns"] then 
            HealBot_MyCooldowns_PlayerUpdateAll()
        end
    elseif (event=="COMBAT_LOG_EVENT_UNFILTERED") then
        HealBot_OnEvent_Combat_Log()
    elseif (event=="PLAYER_REGEN_DISABLED") then
        HealBot_OnEvent_PlayerRegenDisabled();
        HealBot_luVars["UILOCK"]=true
    elseif (event=="PLAYER_REGEN_ENABLED") then
        HealBot_luVars["UILOCK"]=false
        --HealBot_Timers_TurboOn(1)
    elseif (event=="GROUP_ROSTER_UPDATE") or (event=="RAID_ROSTER_UPDATE") then
        HealBot_Timers_Set("SKINS","PartyUpdateCheckSkin")
        HealBot_OnEvent_PartyMembersChanged();
    elseif (event=="RAID_TARGET_UPDATE") then
        HealBot_OnEvent_RaidTargetUpdateAll()
    elseif (event=="PLAYER_TARGET_CHANGED") then
        HealBot_luVars["TargetNeedReset"]=true
        HealBot_OnEvent_PlayerTargetChanged();
    elseif (event=="PLAYER_FOCUS_CHANGED") then
        HealBot_OnEvent_FocusChanged();
    elseif (event=="MODIFIER_STATE_CHANGED") then
        HealBot_Action_SetCurrentModKeys()
        if HealBot_Data["TIPBUTTON"] then 
            HealBot_Action_RefreshTooltip()
        elseif HealBot_Data["TIPICON"] then
            HealBot_Tooltip_UpdateIconTooltip()
        end
        if not HealBot_Data["UILOCK"] then HealBot_Action_ModKey() end
        HealBot_UpdateAllRangeSpells()
    elseif (event=="UNIT_PET") then
        HealBot_OnEvent_PetsChanged()
    elseif (event=="PLAYER_CONTROL_GAINED") or (event=="PLAYER_CONTROL_LOST") or (event=="PLAYER_UPDATE_RESTING") then
        HealBot_Timers_Set("AURA","PlayerCheckExtended")
    elseif (event=="ROLE_CHANGED_INFORM") or (event=="PLAYER_ROLES_ASSIGNED") then
        HealBot_OnEvent_PartyMembersChanged()
        HealBot_Timers_Set("AURA","ResetClassIconTexture")
    elseif (event=="INCOMING_SUMMON_CHANGED") then
        HealBot_OnEvent_IncomingSummons(arg1)
    elseif (event=="PLAYER_MOUNT_DISPLAY_CHANGED") then
        HealBot_Timers_Set("PLAYER","PlayerCheck")
    elseif (event=="UNIT_ENTERED_VEHICLE") then
        HealBot_OnEvent_VehicleChange(arg1, true)
    elseif (event=="UNIT_EXITED_VEHICLE") then
        HealBot_OnEvent_VehicleChange(arg1, nil)
    elseif (event=="UNIT_EXITING_VEHICLE") then
        HealBot_OnEvent_LeavingVehicle(arg1)
    elseif (event=="INSPECT_READY") then
        if HealBot_luVars["talentUpdate"] then
            eButton,ePrivate = HealBot_Panel_AllUnitButton(arg1)
            if eButton then
                HealBot_GetTalentInfo(eButton) 
            end
            if ePrivate then
                if eButton and HealBot_Panel_RaidUnitGUID(eButton.guid) then
                    ePrivate.specupdate=TimeNow+1
                else
                    HealBot_GetTalentInfo(ePrivate)
                end
            end
        end
    elseif (event=="ACTIVE_TALENT_GROUP_CHANGED") then
        _,eButton,ePrivate = HealBot_UnitID("player")
        if eButton then
            HealBot_OnEvent_SpecChange(eButton)
        end
        if ePrivate then
            HealBot_OnEvent_SpecChange(ePrivate) 
        end
    elseif (event=="ZONE_CHANGED_NEW_AREA") or (event=="ZONE_CHANGED")  or (event=="ZONE_CHANGED_INDOORS") then
        HealBot_Timers_Set("LAST","CheckZone")
    elseif (event=="CHAT_MSG_ADDON") then
        HealBot_OnEvent_AddonMsg(arg1,arg2,arg3,arg4);
    elseif (event=="BAG_UPDATE") or (event=="PLAYER_EQUIPMENT_CHANGED") then
        HealBot_OnEvent_InvChange()
    elseif (event=="PET_BATTLE_OPENING_START") or (event=="PET_BATTLE_OVER") then
        HealBot_luVars["lastPetBattleEvent"]=event
        HealBot_Timers_Set("SKINS","PartyUpdateCheckSkin")
    elseif (event=="READY_CHECK") then
        HealBot_OnEvent_ReadyCheck(arg1,arg2);
    elseif (event=="READY_CHECK_CONFIRM") then
        HealBot_OnEvent_ReadyCheckConfirmed(arg1,arg2);
    elseif (event=="READY_CHECK_FINISHED") then
        HealBot_luVars["rcEnd"]=TimeNow+3
    elseif (event=="PLAYER_ENTERING_WORLD") then
        HealBot_OnEvent_PlayerEnteringWorld();
    elseif (event=="PLAYER_LEAVING_WORLD") then
        HealBot_OnEvent_PlayerLeavingWorld();
    elseif (event=="LEARNED_SPELL_IN_TAB") or (event=="PLAYER_LEVEL_UP") then
        HealBot_OnEvent_SpellsChanged(arg1);
        HealBot_Timers_Set("LAST","MountsPetsUse")
        HealBot_Player_TalentsChanged()
    elseif (event=="PLAYER_TALENT_UPDATE") or (event=="CHARACTER_POINTS_CHANGED") then
        HealBot_OnEvent_SpellsChanged(1)
        HealBot_Player_TalentsChanged()
    elseif (event=="COMPANION_LEARNED") then
        HealBot_Timers_Set("LAST","MountsPetsUse")
    elseif (event=="VARIABLES_LOADED") then
        HealBot_OnEvent_VariablesLoaded()
    elseif (event=="ADDON_LOADED") then
        HealBot_OnEvent_AddOnLoaded(arg1)
    elseif (event=="GET_ITEM_INFO_RECEIVED") then
        HealBot_OnEvent_ItemInfoReceived(arg1);
    elseif (event=="DISPLAY_SIZE_CHANGED") or (event=="UI_SCALE_CHANGED") then
        HealBot_Timers_Set("SKINS","FramesSetPoint")
    else
        HealBot_AddDebug("Missing OnEvent (" .. event .. ")", "Events", false);
    end
end

