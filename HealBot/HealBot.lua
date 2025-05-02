--[[ HealBot Continued ]]

local HealBot_DebugMsg={};
local HealBot_DebugMsgOnChange={}
local HealBot_SpamCut={}
--local strfind=strfind
local scName=""
local arrg={}
local LDB11=HealBot_Libs_LDB11()
local LDBIcon=HealBot_Libs_LDBIcon()
local libCHC=HealBot_Libs_CHC()
local HealBot_UnitInVehicle={}
local HealBot_RefreshList={}
local HealBot_UpdateQueue={}
local HealBot_CDQueue={}
local HealBot_RecalcQueue={}
local HealBot_BuffUpdate={}
local HealBot_BuffUpdateList={}
local HealBot_DebuffUpdate={}
local HealBot_DebuffUpdateList={}
local HealBot_notVisible={}
local hbManaPlayers={}
local HealBot_customTempUserName={}
local HealBot_trackHiddenFrames={}
local HealBot_RefreshTypes={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false}
local HealBot_MobGUID={}
local HealBot_MobNames={}
local HealBot_MobTarget={}
local xUnit="x"
local xGUID="x"
local xButton={}
local pButton={}
local aButton={}
local hbPrevGUIDs={}
local HealBot_ItemsInBags={}
local HealBot_AuxAssigns={}
local HealBot_ClearGUIDQueue={}
local HealBot_AuxAssigns={}
HealBot_AuxAssigns["CastBar"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
HealBot_AuxAssigns["OORBar"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
HealBot_AuxAssigns["InRangeBar"]={[0]=false,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false}
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
                       [1]={[1]=60,[2]=60,[3]=60,[4]=60,[5]=60,[0]=60},
                       [2]={[1]=60,[2]=60,[3]=60,[4]=60,[5]=60,[0]=60},
                       [3]={[1]=60,[2]=60,[3]=60,[4]=60,[5]=60,[0]=60},}
HealBot_luVars["IsSolo"]=true
HealBot_luVars["IsRaid"]=false
HealBot_luVars["MaskAuraReCheck"]=false
HealBot_luVars["slowSwitch"]=0
HealBot_luVars["fastSwitch"]=0
HealBot_luVars["iconSwitch"]=0
HealBot_luVars["ResetFlag"]=false
HealBot_luVars["MovingFrame"]=0
HealBot_luVars["TargetNeedReset"]=true
HealBot_luVars["FocusNeedReset"]=true
HealBot_luVars["TankGUID1"]="x"
HealBot_luVars["TankGUID2"]="x"
HealBot_luVars["healthFactor"]=1
HealBot_luVars["NextTipUpdate"]=HealBot_TimeNow
HealBot_luVars["TipUpdateFreq"]=1
HealBot_luVars["EnableErrorSpeech"]=false
HealBot_luVars["EnableErrorText"]=false
HealBot_luVars["AllOutOfCombatCheck"]=HealBot_TimeNow+1
HealBot_luVars["UpdateEnemyFrame"]=true
HealBot_luVars["NoSpamOOM"]=0
HealBot_luVars["AuraEventRegistered"]=false
HealBot_luVars["TestBarsOn"]=false
HealBot_luVars["RaidTargetUpdate"]=false
HealBot_luVars["showReloadMsg"]=true
HealBot_luVars["overhealUnit"]="-nil-"
HealBot_luVars["pluginThreat"]=false
HealBot_luVars["pluginTimeToDie"]=false
HealBot_luVars["mapAreaID"]=0
HealBot_luVars["slowUpdateID"]=1
HealBot_luVars["UpdateNumUnits"]=1
HealBot_luVars["NumUnitsInQueue"]=0
HealBot_luVars["NumEnemyUnitsInQueue"]=0
HealBot_luVars["UpdateID"]=1
HealBot_luVars["UpdateAllAura"]=0
HealBot_luVars["CheckAuraFlags"]=true
HealBot_luVars["GetVersions"]=false
HealBot_luVars["CheckFramesOnCombat"]=true
HealBot_luVars["UpdateSlowNext"]=HealBot_TimeNow+3
HealBot_luVars["cpuAdj"]=0
HealBot_luVars["updUnitsAdj"]=0.2
HealBot_luVars["HealthDropPct"]=999
HealBot_luVars["HealthDropCancelPct"]=100
HealBot_luVars["InInstance"]=false
HealBot_luVars["DoSendGuildVersion"]=true
HealBot_luVars["mapName"]=""
HealBot_luVars["DropCombat"]=0
HealBot_luVars["NumPrivateUnits"]=0
HealBot_luVars["NumPetUnits"]=0
HealBot_luVars["CurrentSpec"]=1
HealBot_luVars["pluginClearDown"]=0
HealBot_luVars["TalentQueryEnd"]=0
HealBot_luVars["NextWarnCallsActive"]=0
HealBot_luVars["debugButton1Min"]=true
HealBot_luVars["aggroCheckInterval"]=3
HealBot_luVars["statusCheckInterval"]=7
HealBot_luVars["healthCheckInterval"]=5
HealBot_luVars["newSkin"]=true
HealBot_luVars["BonusHealing"]=0
HealBot_luVars["BonusMinInHeal"]=0
HealBot_luVars["resetOnNoTargetFrames"]=false

local HealBot_Calls={}
local HealBot_FreqCalls={}
local HealBot_ButtonCalls={}
local HealBot_ButtonCallsLast400={}
local HealBot_ButtonCallsLast200sum={}
local hbRunTime="[]"
local hbPrevRunTime=nil
HealBot_luVars["MaxCount"]=0
HealBot_luVars["CurMem"]=0

function HealBot_setLuVars(vName, vValue)
	  --HealBot_setCall("HealBot_setLuVars - "..vName)
    HealBot_luVars[vName]=vValue
end

function HealBot_retLuVars(vName)
      --HealBot_setCall("HealBot_retLuVars - "..vName)
    return HealBot_luVars[vName]
end

function HealBot_setCall(Caller, button, guid, unit, freq)
    if freq then
        if not HealBot_FreqCalls[Caller] then
            HealBot_FreqCalls[Caller]=0
        end
        HealBot_FreqCalls[Caller]=HealBot_FreqCalls[Caller]+1
    else
        if not HealBot_Calls[Caller] then
            HealBot_Calls[Caller]=0
        end
        HealBot_Calls[Caller]=HealBot_Calls[Caller]+1
        if HealBot_luVars["MaxCount"]<HealBot_Calls[Caller] then
            HealBot_luVars["MaxCount"]=HealBot_Calls[Caller]
            HealBot_luVars["MaxCountName"]=Caller
        end
    end
    if not button then
        if guid then
            xButton, pButton=HealBot_Panel_AllUnitButton(guid)
            button=xButton or pButton
        elseif unit then
            _, xButton, pButton=HealBot_UnitID(unit, true)
            button=xButton or pButton
        end
    end
    if button and button.name and button.debug.track then
        if not HealBot_ButtonCallsLast400[button.guid] then HealBot_ButtonCallsLast400[button.guid]={} end
        if not HealBot_ButtonCallsLast200sum[button.guid] then HealBot_ButtonCallsLast200sum[button.guid]={} end

        if not freq then
            if not HealBot_ButtonCalls[button.guid] then HealBot_ButtonCalls[button.guid]={} end
            if not HealBot_ButtonCalls[button.guid][Caller] then HealBot_ButtonCalls[button.guid][Caller]=0 end
            HealBot_ButtonCalls[button.guid][Caller]=HealBot_ButtonCalls[button.guid][Caller]+1
            HealBot_Debug_UpdateButtonCalls(button)
        end

        hbRunTime="["..date("%H:%M", time()).."]"
        if not HealBot_ButtonCalls[button.name] then
            HealBot_ButtonCalls[button.name]={}
        end
        if not HealBot_ButtonCalls[button.name][hbRunTime] then
            HealBot_ButtonCalls[button.name][hbRunTime]={}
        end
        if not HealBot_ButtonCalls[button.name][hbRunTime][Caller] then
            HealBot_ButtonCalls[button.name][hbRunTime][Caller]=0
        end
        HealBot_ButtonCalls[button.name][hbRunTime][Caller]=HealBot_ButtonCalls[button.name][hbRunTime][Caller]+1
        if button.debug.updtime~=hbRunTime then
            if HealBot_ButtonCalls[button.name][button.debug.updtime] then
                for call,count in pairs(HealBot_ButtonCalls[button.name][button.debug.updtime]) do
                    if HealBot_luVars["debugButton1Min"] then
                        HealBot_Debug_UpdateButtonCalls(button, call, count)
                    end
                    table.insert(HealBot_ButtonCallsLast200sum[button.guid], button.debug.updtime.." "..call.." x"..count)
                    if #HealBot_ButtonCallsLast200sum[button.guid]>200 then
                        table.remove(HealBot_ButtonCallsLast200sum[button.guid],1)
                    end
                end
                HealBot_ButtonCalls[button.name][button.debug.updtime]=nil
            elseif HealBot_ButtonCalls[button.name][hbRunTime] then
                for call,count in pairs(HealBot_ButtonCalls[button.name][hbRunTime]) do
                    HealBot_Debug_UpdateButtonCalls(button, call, count)
                end
                HealBot_ButtonCalls[button.name][hbRunTime]=nil
            end
            button.debug.updtime=hbRunTime
        end
        if not freq then
            table.insert(HealBot_ButtonCallsLast400[button.guid], "["..date("%H:%M:%S", time()).."] "..Caller.." x"..HealBot_ButtonCalls[button.guid][Caller])
            if #HealBot_ButtonCallsLast400[button.guid]>400 then
                table.remove(HealBot_ButtonCallsLast400[button.guid],1)
            end
            if not HealBot_luVars["debugButton1Min"] then
                HealBot_Debug_UpdateButtonCalls(button, Caller, HealBot_ButtonCalls[button.guid][Caller])
            end
        end
    end
end

function HealBot_DumpButtonDebug(unit)
    _, xButton, pButton=HealBot_UnitID(unit)
    local tButton=xButton or pButton
    if tButton then
        local s=""
        if HealBot_ButtonCallsLast400[tButton.guid] then
            for x=1,#HealBot_ButtonCallsLast400[tButton.guid] do
                s=s..HealBot_ButtonCallsLast400[tButton.guid][x].."\n"
            end
            HealBot_Options_ShareSpellsExternalEditBox:SetText(s)
        end
        s=""
        if HealBot_ButtonCallsLast200sum[tButton.guid] then
            for x=1,#HealBot_ButtonCallsLast200sum[tButton.guid] do
                s=s..HealBot_ButtonCallsLast200sum[tButton.guid][x].."\n"
            end
            HealBot_Options_SharePresetColsExternalEditBox:SetText(s)
        end
    end
end

function HealBot_setAuxAssigns(vName, frame, vValue)
      --HealBot_setCall("HealBot_setAuxAssigns - "..vName)
    HealBot_AuxAssigns[vName][frame]=vValue
end

function HealBot_reportCalls()
    if HealBot_luVars["MaxCountName"] then HealBot_AddDebug("High Count:"..HealBot_luVars["MaxCountName"].."="..HealBot_luVars["MaxCount"]) end
end

function HealBot_retCalls(button, freq)
    if button then
        return HealBot_ButtonCalls[button.guid]
    elseif freq then
        return HealBot_FreqCalls
    else
        return HealBot_Calls
    end
end

function HealBot_AllRefreshTypes()
    HealBot_RefreshTypes[0]=true
end

function HealBot_nextRecalcParty(typeRequired,delay)
      --HealBot_setCall("HealBot_nextRecalcParty"..typeRequired)
    if typeRequired == 3 then
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][11]["STATE"] and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][11]["FRAME"]<6 then
            HealBot_nextRecalcParty(6,delay)
        end
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][12]["STATE"] and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][12]["FRAME"]<6 then
            HealBot_nextRecalcParty(6,delay)
        end
    elseif typeRequired == 4 then
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][13]["STATE"] and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][13]["FRAME"]<6 then
            HealBot_nextRecalcParty(6,delay)
        end
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][14]["STATE"] and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][14]["FRAME"]<6 then
            HealBot_nextRecalcParty(6,delay)
        end
    elseif typeRequired == 2 then
        if hbv_Skins_GetBoolean("Healing", "SELFPET") then
            HealBot_nextRecalcParty(6,delay)
        end
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["STATE"] and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["FRAME"]<6 then
            HealBot_nextRecalcParty(6,delay)
        end
    elseif typeRequired == 1 then
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][9]["STATE"] and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][9]["FRAME"]<6 then
            HealBot_nextRecalcParty(6)
        end
    end
    if not HealBot_RefreshTypes[typeRequired] then
        HealBot_RefreshTypes[typeRequired]=true
        HealBot_Timer_FramesRefresh()
    end
end

function HealBot_setNotVisible(unit,group)
      --HealBot_setCall("HealBot_setNotVisible", nil, nil, unit)
    HealBot_notVisible[unit]=group
end

function HealBot_SetResetFlag(mode)
      --HealBot_setCall("HealBot_SetResetFlag")
    HealBot_Timers_Set("OOC","SaveSpellsProfile")
    HealBot_Timers_Set("OOC","SaveActionIconsProfile")
    if mode == "HARD" then
        HealBot_Timers_Set("RESET","Reload",true)
    elseif mode == "SOFT" and not HealBot_luVars["TestBarsOn"] then
        if HealBot_Config.DisabledNow == 1 then
            HealBot_Options_DisableHealBotOpt:SetChecked(false)
            HealBot_Options_DisableHealBot(false)
        end
        HealBot_Timers_Set("RESET","Full",true)
    elseif mode == "FRAMES" then
        HealBot_Timers_Set("RESET","Frames",true)
    else
        HealBot_Timers_Set("RESET","Quick",true)
    end
    HealBot_Timers_TurboOn()
end

function HealBot_SetToolTip(tip)
      --HealBot_setCall("HealBot_SetToolTip")
    if not tip:IsOwned(HealBot) then
        tip:SetOwner(HealBot, 'ANCHOR_NONE')
    end
end

local uzText=""
function HealBot_UnitZone(button)
      --HealBot_setCall("HealBot_UnitZone", button)
    if button.player or UnitIsVisible(button.unit) then
        uzText=GetRealZoneText();
    elseif button.raidid>0 then
        _, _, _, _, _, _, uzText, _, _=GetRaidRosterInfo(button.raidid)
    else
        HealBot_ScanTooltip:SetUnit(button.unit)
        uzText=HealBot_ScanTooltipTextLeft3:GetText()
        if uzText == "PvP" then
            uzText=HealBot_ScanTooltipTextLeft4:GetText()
        end
    end
    return uzText
end

local hbUnitBosses={["boss1"]=true,["boss2"]=true,["boss3"]=true,["boss4"]=true,
                    ["boss5"]=true,["boss6"]=true,["boss7"]=true,["boss8"]=true}
function HealBot_UnitClassification(unit)
    local uClassify=UnitClassification(unit)
    if uClassify == "worldboss" or hbUnitBosses[unit] then
        uClassify="Boss"
    elseif uClassify == "rareelite" then
        uClassify="Rare Elite"
    elseif uClassify == "elite" then
        uClassify="Elite"
    elseif uClassify == "rare" then
        uClassify="Rare"
    else
        uClassify=nil
    end
    return uClassify
end

function HealBot_AddChat(HBmsg)
      --HealBot_setCall("HealBot_AddChat")
    DEFAULT_CHAT_FRAME:AddMessage(HEALBOT_CHAT_ADDONID..HBmsg, 0.7, 0.7, 1.0);
end

function HealBot_AddDebug(HBmsg, cat, incTime, changeKey)
      --HealBot_setCall("HealBot_AddDebug")
    if HealBot_Globals.DebugOut and HBmsg and (HealBot_SpamCut[HBmsg] or 0)<HealBot_TimeNow then
        HealBot_SpamCut[HBmsg]=HealBot_TimeNow+1
        if changeKey then
            if not HealBot_DebugMsgOnChange[changeKey] or HealBot_DebugMsgOnChange[changeKey]~=HBmsg then
                HealBot_DebugMsgOnChange[changeKey]=HBmsg
            else
                HBmsg=false
            end
        end
        if HBmsg then
            if cat then
                HealBot_Debug_Add(cat, HBmsg, incTime)
            else
                HBmsg="["..date("%H:%M", time()).."] DEBUG: "..HBmsg;
                table.insert(HealBot_DebugMsg,HBmsg)
            end
        end
    end
end

function HealBot_TogglePanel(HBpanel, sound)
      --HealBot_setCall("HealBot_TogglePanel")
    if not HBpanel then return end
    if ( HBpanel:IsVisible() ) then
        HBpanel:Hide();
        if sound then
            PlaySound(SOUNDKIT.IG_CHARACTER_INFO_CLOSE)
        end
        HealBot_Options_Close()
    else
        local fTop=HealBot_Util_Round(((HBpanel:GetTop()/GetScreenHeight())*100),2)
        local fLeft=HealBot_Util_Round(((HBpanel:GetLeft()/GetScreenWidth())*100),2)
        local fBottom=HealBot_Util_Round(((HBpanel:GetBottom()/GetScreenHeight())*100),2)
        local fRight=HealBot_Util_Round(((HBpanel:GetRight()/GetScreenWidth())*100),2)
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
end


function HealBot_StartMoving(HBframe, frame)
      --HealBot_setCall("HealBot_StartMoving")
    if not HBframe.isMoving then
        HBframe:StartMoving();
        HBframe.isMoving=true;
        if frame and hbv_Skins_GetBoolean("General", "STICKYFRAME") and frame>1 then HealBot_luVars["MovingFrame"]=frame end
    end
end

function HealBot_StopMoving(HBframe,frame)
      --HealBot_setCall("HealBot_StopMoving")
    if ( HBframe.isMoving ) then
        HBframe:StopMovingOrSizing();
        HBframe.isMoving=false;
        if HealBot_luVars["MovingFrame"]>1 then
            HealBot_luVars["MovingFrame"]=0
            HealBot_Action_StickyFrameCanStickTo(HBframe.id,0,0,0)
        end
    end
    if frame then
        HealBot_Action_StickyFrameClearStuck(frame)
        HealBot_Action_setPoint(frame, true)
    end
end

function HealBot_CheckFrameHorizontal(frame, aType)
    local Hcenter=GetScreenWidth()/2
    local wPct=HealBot_Util_Round(((hbv_Skins_GetFrameVar("HealBar", "WIDTH", frame)/GetScreenWidth())*100),2)
    local wAdj=Hcenter-hbv_Skins_GetFrameVar("HealBar", "WIDTH", frame)
    if aType == "LEFT" then
        if (hbv_Skins_GetFrameVar("Anchors", "RealX", frame)+Hcenter)<0 then
            hbv_Skins_SetFrameVar(0-Hcenter, "Anchors", "RealX", frame)
        elseif (hbv_Skins_GetFrameVar("Anchors", "RealX", frame)+wAdj)>GetScreenWidth() then
            hbv_Skins_SetFrameVar(wAdj, "Anchors", "RealX", frame)
        end
        if hbv_Skins_GetFrameVar("Anchors", "X", frame)<0.01 then
            hbv_Skins_SetFrameVar(0.01, "Anchors", "X", frame)
        elseif (hbv_Skins_GetFrameVar("Anchors", "X", frame)+wPct)>100 then
            hbv_Skins_SetFrameVar(100-wPct, "Anchors", "X", frame)
        end
    elseif aType == "RIGHT" then
        if (hbv_Skins_GetFrameVar("Anchors", "RealX", frame)+wAdj)<0 then
            hbv_Skins_SetFrameVar(0-wAdj, "Anchors", "RealX", frame)
        elseif (hbv_Skins_GetFrameVar("Anchors", "RealX", frame)+Hcenter)>GetScreenWidth() then
            hbv_Skins_SetFrameVar(Hcenter, "Anchors", "RealX", frame)
        end
        if hbv_Skins_GetFrameVar("Anchors", "X", frame)<wPct then
            hbv_Skins_SetFrameVar(wPct, "Anchors", "X", frame)
        elseif hbv_Skins_GetFrameVar("Anchors", "X", frame)>100 then
            hbv_Skins_SetFrameVar(100, "Anchors", "X", frame)
        end
    elseif aType == "CENTER" then
        if (hbv_Skins_GetFrameVar("Anchors", "RealX", frame)+Hcenter)<0 then
            hbv_Skins_SetFrameVar(0-Hcenter, "Anchors", "RealX", frame)
        elseif (hbv_Skins_GetFrameVar("Anchors", "RealX", frame)+Hcenter)>GetScreenWidth() then
            hbv_Skins_SetFrameVar(Hcenter, "Anchors", "RealX", frame)
        end
        if hbv_Skins_GetFrameVar("Anchors", "X", frame)<0.01 then
            hbv_Skins_SetFrameVar(0.01, "Anchors", "X", frame)
        elseif hbv_Skins_GetFrameVar("Anchors", "X", frame)>100 then
            hbv_Skins_SetFrameVar(100, "Anchors", "X", frame)
        end
    end
end

function HealBot_CheckFrameVertical(frame, aType)
    local Vcenter=GetScreenHeight()/2
    local hPct=HealBot_Util_Round(((hbv_Skins_GetFrameVar("HealBar", "HEIGHT", frame)/GetScreenHeight())*100),2)
    local hAdj=Vcenter-hbv_Skins_GetFrameVar("HealBar", "HEIGHT", frame)
    if aType == "TOP" then
        if (hbv_Skins_GetFrameVar("Anchors", "RealY", frame)+hAdj)<0 then
            hbv_Skins_SetFrameVar(0-hAdj, "Anchors", "RealY", frame)
        elseif (hbv_Skins_GetFrameVar("Anchors", "RealY", frame)+Vcenter)>GetScreenHeight() then
            hbv_Skins_SetFrameVar(Vcenter, "Anchors", "RealY", frame)
        end
        if hbv_Skins_GetFrameVar("Anchors", "Y", frame)<hPct then
            hbv_Skins_SetFrameVar(hPct, "Anchors", "Y", frame)
        elseif hbv_Skins_GetFrameVar("Anchors", "Y", frame)>100 then
            hbv_Skins_SetFrameVar(100, "Anchors", "Y", frame)
        end
    elseif aType == "BOTTOM" then
        if (hbv_Skins_GetFrameVar("Anchors", "RealY", frame)+Vcenter)<0 then
            hbv_Skins_SetFrameVar(0-Vcenter, "Anchors", "RealY", frame)
        elseif (hbv_Skins_GetFrameVar("Anchors", "RealY", frame)+Vcenter+hbv_Skins_GetFrameVar("HealBar", "HEIGHT", frame))>GetScreenHeight() then
            hbv_Skins_SetFrameVar(hAdj, "Anchors", "RealY", frame)
        end
        if hbv_Skins_GetFrameVar("Anchors", "Y", frame)<0.01 then
            hbv_Skins_SetFrameVar(0.01, "Anchors", "Y", frame)
        elseif (hbv_Skins_GetFrameVar("Anchors", "Y", frame)+hPct)>100 then
            hbv_Skins_SetFrameVar(100-hPct, "Anchors", "Y", frame)
        end
    elseif aType == "CENTER" then
        if (hbv_Skins_GetFrameVar("Anchors", "RealY", frame)+Vcenter)<0 then
            hbv_Skins_SetFrameVar(0-Vcenter, "Anchors", "RealY", frame)
        elseif (hbv_Skins_GetFrameVar("Anchors", "RealY", frame)+Vcenter)>GetScreenHeight() then
            hbv_Skins_SetFrameVar(Vcenter, "Anchors", "RealY", frame)
        end
        if hbv_Skins_GetFrameVar("Anchors", "Y", frame)<0.01 then
            hbv_Skins_SetFrameVar(0.01, "Anchors", "Y", frame)
        elseif hbv_Skins_GetFrameVar("Anchors", "Y", frame)>100 then
            hbv_Skins_SetFrameVar(100, "Anchors", "Y", frame)
        end
    end
end

function HealBot_CheckFrame(frame)
      --HealBot_setCall("HealBot_CheckFrame")
    if HealBot_Config.DisabledNow == 1 then return end
    if hbv_Skins_GetFrameVar("Anchors", "FRAME", frame) == 1 then
        HealBot_CheckFrameHorizontal(frame, "LEFT")
        HealBot_CheckFrameVertical(frame, "TOP")
    elseif hbv_Skins_GetFrameVar("Anchors", "FRAME", frame) == 2 then
        HealBot_CheckFrameHorizontal(frame, "LEFT")
        HealBot_CheckFrameVertical(frame, "BOTTOM")
    elseif hbv_Skins_GetFrameVar("Anchors", "FRAME", frame) == 3 then
        HealBot_CheckFrameHorizontal(frame, "RIGHT")
        HealBot_CheckFrameVertical(frame, "TOP")
    elseif hbv_Skins_GetFrameVar("Anchors", "FRAME", frame) == 4 then
        HealBot_CheckFrameHorizontal(frame, "RIGHT")
        HealBot_CheckFrameVertical(frame, "BOTTOM")
    elseif hbv_Skins_GetFrameVar("Anchors", "FRAME", frame) == 5 then
        HealBot_CheckFrameHorizontal(frame, "CENTER")
        HealBot_CheckFrameVertical(frame, "TOP")
    elseif hbv_Skins_GetFrameVar("Anchors", "FRAME", frame) == 6 then
        HealBot_CheckFrameHorizontal(frame, "LEFT")
        HealBot_CheckFrameVertical(frame, "CENTER")
    elseif hbv_Skins_GetFrameVar("Anchors", "FRAME", frame) == 7 then
        HealBot_CheckFrameHorizontal(frame, "RIGHT")
        HealBot_CheckFrameVertical(frame, "CENTER")
    elseif hbv_Skins_GetFrameVar("Anchors", "FRAME", frame) == 8 then
        HealBot_CheckFrameHorizontal(frame, "CENTER")
        HealBot_CheckFrameVertical(frame, "BOTTOM")
    end
end

HealBot_luVars["ClassicInteractDistance"]=2
--if HEALBOT_GAME_VERSION<3 then
--    HealBot_luVars["ClassicInteractDistance"]=2
--end

function HealBot_TalentQuery(button)
      --HealBot_setCall("HealBot_TalentQuery", button)
    if button.status.current<HealBot_Unit_Status["RESERVED"] then
        local hbInspect=false
        local s=" "
        if HealBot_Panel_RaidUnitButtonCheck(button.guid) then
            s=HealBot_Action_getGuidData(button.guid, "TMPSPEC")
        end
        if s~=" " then
            if button.spec~=s then
                HealBot_Timers_Set("OOC","RefreshPartyNextRecalcPlayers",true)
            else
                button.specupdate=0
            end
            button.spec=s
        elseif UnitExists(button.unit) then
            if CanInspect(button.unit) then
                if button.status.range<0 then
                    HealBot_SpecUpdate(button, HealBot_TimeNow+15)
                elseif HEALBOT_GAME_VERSION>5 then
                    if button.status.range>0 then
                        hbInspect=true
                    else
                        HealBot_SpecUpdate(button, HealBot_TimeNow+5)
                    end
                elseif HealBot_Range_InteractDistance(button.unit, HealBot_luVars["ClassicInteractDistance"]) then
                    local g,p,ip,t,tp,tpc="",false,false,false,false,false
                    if _G["PaperDollFrame"] then g=_G["PaperDollFrame"]; p=g:IsVisible() end
                    if _G["InspectPaperDollFrame"] then g=_G["InspectPaperDollFrame"]; ip=g:IsVisible() end
                    if _G["TalentFrame"] then g=_G["TalentFrame"]; t=g:IsVisible() end
                    if _G["InspectTalentFrame"] then g=_G["InspectTalentFrame"]; tp=g:IsVisible() end
                    if _G["InspectTalentFrameScrollChildFrame"] then g=_G["InspectTalentFrameScrollChildFrame"]; tpc=g:IsVisible() end
                    if not p and not ip and not t and not tp and not tpc then
                        hbInspect=true
                    else
                        HealBot_SpecUpdate(button, HealBot_TimeNow+10)
                    end
                else
                    HealBot_SpecUpdate(button, HealBot_TimeNow+5)
                end
                if hbInspect then
                    HealBot_luVars["TalentQueryEnd"]=HealBot_TimeNow+5
                    NotifyInspect(button.unit);
                    button.specupdate=0
                end
            else
                button.specupdate=0
            end
        end
    end
end

function HealBot_Reset_AutoUpdateSpellIDs()
      --HealBot_setCall("HealBot_Reset_AutoUpdateSpellIDs")
    HealBot_AddChat("Automatic Spell ID's Turned On")
end

function HealBot_ToggleHealBot()
      --HealBot_setCall("HealBot_ToggleHealBot")
    HealBot_Timers_Set("OOC","ToggleHealBot")
end

function HealBot_ToggleHealBotOOC()
      --HealBot_setCall("HealBot_ToggleHealBot")
    if HealBot_Config.DisabledNow == 0 then
        HealBot_Options_DisableHealBotOpt:SetChecked(true)
        HealBot_Options_DisableHealBot(true)
    else
        HealBot_Options_DisableHealBotOpt:SetChecked(false)
        HealBot_Options_DisableHealBot(false)
    end
end

function HealBot_SlashCmd(cmd)
      --HealBot_setCall("HealBot_SlashCmd")
    if not cmd then cmd="" end
    local HBcmd, x, y, z=string.split(" ", cmd)
    if type(HBcmd) == "string" then
        HBcmd=string.lower(HBcmd)
        if x and type(x) == "string" then x = string.lower(x) end
        if y and type(y) == "string" then y = string.lower(y) end
        if z and type(z) == "string" then z = string.lower(z) end
        if (HBcmd == "se1") then
            SetCVar("Sound_EnableErrorSpeech", "0");
        elseif (HBcmd == "se2") then
            HealBot_luVars["EnableErrorSpeech"]=true
        elseif (HBcmd == "se3") then
            UIErrorsFrame:Hide()
        elseif (HBcmd == "se4") then
            HealBot_luVars["EnableErrorText"]=true
        elseif (HBcmd == "" or HBcmd == "o" or HBcmd == "options" or HBcmd == "opt" or HBcmd == "config" or HBcmd == "cfg") then
            HealBot_Options_ShowHide()
        elseif (HBcmd == "d" or HBcmd == "defaults") then
            if HBcmd == "defaults" and x == "force" then
                HealBot_Options_SetDefaults(true)
            else
                HealBot_Options_Defaults_OnClick(HealBot_Options_Defaults, true);
            end
        elseif (HBcmd == "ui") then
            HealBot_AddChat(HEALBOT_CHAT_HARDRELOAD)
            HealBot_SetResetFlag("HARD")
        elseif (HBcmd == "ri" or (HBcmd == "reset" and (x or "") == "healbot")) then
            HealBot_AddChat(HEALBOT_CHAT_SOFTRELOAD)
            HealBot_SetResetFlag("SOFT")
        elseif (HBcmd == "rc" or (HBcmd == "reset" and (x or "") == "customdebuffs")) then
            HealBot_Timers_Set("RESET","CustomDebuffs")
        elseif (HBcmd == "rs" or (HBcmd == "reset" and (x or "") == "skin")) then
            HealBot_Timers_Set("RESET","Skins")
        elseif (HBcmd == "show") then
            HealBot_SetResetFlag("FRAMES")
        elseif (HBcmd == "cb") then
            HealBot_Panel_ClearBlackList()
        elseif (HBcmd == "cspells") then
            HealBot_Copy_SpellCombos()
        elseif (HBcmd == "rspells") then
            HealBot_Reset_Spells()
        elseif (HBcmd == "rcures") then
            HealBot_Reset_Cures()
        elseif (HBcmd == "rbuffs") then
            HealBot_Reset_Buffs()
        elseif (HBcmd == "ricons") then
            HealBot_Reset_Icons()
        elseif (HBcmd == "tma") then
            HealBot_Options_ToggleMainAssist()
        elseif (HBcmd == "cs") then
            HealBot_Update_Skins()
            HealBot_AddChat(HEALBOT_SKIN_CHECK_DONE)
        elseif (HBcmd == "disable") then
            HealBot_Options_DisableHealBotOpt:SetChecked(true)
            HealBot_Options_DisableHealBot(true)
        elseif (HBcmd == "enable") then
            HealBot_Options_DisableHealBotOpt:SetChecked(false)
            HealBot_Options_DisableHealBot(false)
        elseif (HBcmd == "eac" and x) then
            if x == "buff" then
                HealBot_Globals.IgnoreCustomBuff={}
                HealBot_Options_BuffIconUpdate()
                HealBot_AddChat(HEALBOT_ENABLE_CUSTOM_BUFFS)
            elseif x == "debuff" then
                HealBot_Globals.IgnoreCustomDebuff={}
                HealBot_Options_DebuffIconUpdate()
                HealBot_AddChat(HEALBOT_ENABLE_CUSTOM_DEBUFFS)
            end
        elseif (HBcmd == "tnr") and HEALBOT_GAME_VERSION<4 then
            if HealBot_Globals.NoRanks then
                HealBot_Globals.NoRanks=false
                HealBot_AddChat("Ranks will be shown")
                HealBot_Options_ReloadUI()
            else
                HealBot_Globals.NoRanks=true
                HealBot_AddChat("Ranks will not be shown")
                HealBot_AddChat("WARNING: This is not recommanded")
                HealBot_Options_ReloadUI()
            end
        elseif (HBcmd == "t") then
            HealBot_ToggleHealBot()
        elseif (HBcmd == "help" or HBcmd == "h") then
            HealBot_luVars["HelpCnt1"]=0
            HealBot_luVars["Help"]=true
        elseif (HBcmd == "hs") then
            HealBot_luVars["HelpCnt2"]=0
            HealBot_luVars["Help"]=true
        elseif (HBcmd == "iht" and x) then
            if HEALBOT_GAME_VERSION<4 then
                if (tonumber(x)>0) and (tonumber(x)<22) then
                    HealBot_Globals.ClassicHoTTime=tonumber(x)+0.5
                    HealBot_AddChat("HoT Time set to "..x.."s")
                else
                    HealBot_AddChat("Invalid Value for HoT Time. valid range from 1 to 21")
                end
            end
        elseif (HBcmd == "skin" and x) then
            if y then x=x.." "..y end
            if z then x=x.." "..z end
            for j=1, getn(Healbot_Config_Skins.Skins), 1 do
                if x == string.lower(Healbot_Config_Skins.Skins[j]) then
                    x=Healbot_Config_Skins.Skins[j]
                    break
                end
            end
            HealBot_Options_Set_Current_Skin(x, nil, nil, true)
        elseif (HBcmd == "use10") then
            if HealBot_Config.MacroUse10 then
                HealBot_Config.MacroUse10=false
                HealBot_AddChat(HEALBOT_CHAT_USE10OFF)
            else
                HealBot_Config.MacroUse10=true
                HealBot_AddChat(HEALBOT_CHAT_USE10ON)
            end
            HealBot_Timers_Set("INIT","PrepSetAllAttribs",true)
        elseif (HBcmd == "suppress" and x) then
            HealBot_Options_ToggleSuppressSetting(x)
        elseif (HBcmd == "atd" and x) then
            if (tonumber(x)>3) and (tonumber(x)<122) then
                HealBot_Config_Cures.ShowTimeMaxDuration=tonumber(x)
                HealBot_Lang_Options_enALL()
                HealBot_AddChat("Auto Timed Debuff Duration set to "..x.."s")
            else
                HealBot_AddChat("Invalid Value for Auto Timed Debuff Duration. valid range from 4 to 121")
            end
        elseif (HBcmd == "atb" and x) then
            if (tonumber(x)>3) and (tonumber(x)<122) then
                HealBot_Config_Buffs.AutoBuffExpireTime=tonumber(x)
                HealBot_Lang_Options_enALL()
                HealBot_AddChat("Auto Timed Buff Duration set to "..x.."s")
            else
                HealBot_AddChat("Invalid Value for Auto Timed Buff Duration. valid range from 4 to 121")
            end
        elseif (HBcmd == "test") then
            HealBot_TestBars()
        elseif (HBcmd == "tr" and x) then
            HealBot_Panel_SethbTopRole(x)
        elseif (HBcmd == "tci") then
            HealBot_Options_ToggleClearInspect()
        elseif (HBcmd == "spt") then
            if hbv_Skins_GetBoolean("Healing", "SELFPET") then
                hbv_Skins_SetVar(false, "Healing", "SELFPET")
                HealBot_AddChat(HEALBOT_CHAT_SELFPETSOFF)
            else
                hbv_Skins_SetVar(true, "Healing", "SELFPET")
                HealBot_AddChat(HEALBOT_CHAT_SELFPETSON)
            end
            HealBot_Timers_Set("OOC","RefreshPartyNextRecalcPlayers")
        elseif (HBcmd == "bt") then
            if HealBot_Config_Buffs.BuffWatch then
                HealBot_Config_Buffs.BuffWatch=false
            else
                HealBot_Config_Buffs.BuffWatch=true
            end
            HealBot_Options_MonitorBuffs:SetChecked(HealBot_Config_Buffs.BuffWatch)
            HealBot_Options_MonitorBuffs_Toggle()
        elseif (HBcmd == "dt") then
            if HealBot_Config_Cures.DebuffWatch then
                HealBot_Config_Cures.DebuffWatch=false
            else
                HealBot_Config_Cures.DebuffWatch=true
            end
            HealBot_Options_MonitorDebuffs:SetChecked(HealBot_Config_Cures.DebuffWatch)
            HealBot_Options_MonitorDebuffs_Toggle()
        elseif (HBcmd == "dm") then
            HealBot_MountsPets_DislikeMount("Dislike")
        elseif (HBcmd == "em") then
            HealBot_MountsPets_DislikeMount("Exclude")
        elseif (HBcmd == "rhg") then
            HealBot_Skins_ResetHealGroups(Healbot_Config_Skins.Current_Skin)
        elseif (HBcmd == "cpu") then
            if HealBot_luVars["CPUProfilerOn"] then
                if not HealBot_Data["UILOCK"] then
                    SetCVar("scriptProfile", "0");
                    ReloadUI()
                else
                    HealBot_AddChat("Not In Combat")
                end
            end
        elseif (HBcmd == "aggro" and x and y) then
            if tonumber(x) and tonumber(x) == 2 then
                if tonumber(y) and tonumber(y)>24 and tonumber(x)<96 then
                    HealBot_Globals.aggro2pct=tonumber(y)
                    HealBot_AddChat(HEALBOT_AGGRO2_SET_MSG..y)
                else
                    HealBot_AddChat(HEALBOT_AGGRO2_ERROR_MSG)
                end
            elseif tonumber(x) and tonumber(x) == 3 then
                if tonumber(y) and tonumber(y)>74 and tonumber(y)<101 then
                    HealBot_Globals.aggro3pct=tonumber(y)
                    HealBot_AddChat(HEALBOT_AGGRO3_SET_MSG..y)
                else
                    HealBot_AddChat(HEALBOT_AGGRO3_ERROR_MSG)
                end
            else
                HealBot_AddChat(HEALBOT_AGGRO_ERROR_MSG)
            end
        elseif (HBcmd == "lang" and x) then
            HealBot_Options_Lang(x, true)
        elseif (HBcmd == "cw") then  -- Clear Warnings
            HealBot_Globals.OneTimeMsg={}
        elseif (HBcmd == "rau") then
            HealBot_Reset_AutoUpdateSpellIDs()
        elseif (HBcmd == "tpt" and x) then
            if UnitExists(x) then
                HealBot_Panel_ToggelPrivateTanks(x, false)
            else
                HealBot_AddChat("Invalid Unit "..x)
            end
        elseif (HBcmd == "tph" and x) then
            if UnitExists(x) then
                HealBot_Panel_ToggelPrivateHealers(x, false)
            else
                HealBot_AddChat("Invalid Unit "..x)
            end
        elseif (HBcmd == "tpd" and x) then
            if UnitExists(x) then
                HealBot_Panel_ToggelPrivateDamagers(x, false)
            else
                HealBot_AddChat("Invalid Unit "..x)
            end
        elseif (HBcmd == "tpl" and x) then
            if UnitExists(x) then
                HealBot_Panel_ToggelHealTarget(x, false)
            else
                HealBot_AddChat("Invalid Unit "..x)
            end
        elseif (HBcmd == "tpf" and x) then
            if UnitExists(x) then
                HealBot_Panel_ToggelPrivFocus(x)
            else
                HealBot_AddChat("Invalid Unit "..x)
            end
        elseif (HBcmd == "debugtrack" and x) then
            if UnitExists(x) then
                _, xButton, pButton=HealBot_UnitID(x)
                local tButton=xButton or pButton
                if tButton then
                    if tButton.debug.track then
                        tButton.debug.track=false
                    else
                        tButton.debug.track=true
                    end
                end
            end
        elseif (HBcmd == "debugdump" and x) then
            HealBot_DumpButtonDebug(x)
        elseif  (HBcmd == "debug1min") then
            if HealBot_luVars["debugButton1Min"] then
                HealBot_luVars["debugButton1Min"]=false
                HealBot_AddChat("debug button over 1 minute turned OFF")
            else
                HealBot_luVars["debugButton1Min"]=true
                HealBot_AddChat("debug button over 1 minute turned ON")
            end
        elseif (HBcmd == "debugshow") then
            HealBot_Debug_HideShow()
        elseif (HBcmd == "perfshow") then
            HealBot_Debug_PerfHideShow()
        elseif (HBcmd == "debug") then
            if HealBot_Globals.DebugOut then
                HealBot_Globals.DebugOut=false
                HealBot_AddChat("Debug OFF")
            else
                HealBot_Globals.DebugOut=true
                HealBot_AddChat("Debug ON")
            end
        elseif (HBcmd == "debugtip") then
            if HealBot_Data["TIPUSE"] then
                HealBot_ToolTip_ToggleDebug()
            end
        elseif (HBcmd == "resetcalls") then
            HealBot_AddChat("Calls Reset")
            HealBot_Calls={}
            HealBot_ButtonCalls={}
        elseif (HBcmd == "ma" and x) then
            x=tonumber(x)
            if type(x) == "number" then
                if x>0 and x<21 then
                    HealBot_AddChat("Aux MAX Absorbs set to MaxHealth / "..x)
                    HealBot_Globals.AbsorbDiv=x
                    HealBot_Timers_Set("LAST", "SetInHealAbsorbMax")
                else
                    HealBot_AddChat("The MAX Absorbs divider must be between 1 and 20")
                end
            else
                HealBot_AddChat("The MAX Absorbs divider must be a number between 1 and 20")
            end
        elseif (HBcmd == "mi" and x) then
            x=tonumber(x)
            if type(x) == "number" then
                if x>0 and x<21 then
                    HealBot_AddChat("Aux MAX In Heals set to MaxHealth / "..x)
                    HealBot_Globals.InHealDiv=x
                    HealBot_Timers_Set("LAST", "SetInHealAbsorbMax")
                else
                    HealBot_AddChat("The MAX In Heals divider must be between 1 and 20")
                end
            else
                HealBot_AddChat("The MAX In Heals divider must be a number between 1 and 20")
            end
        elseif (HBcmd == "mt" and x) then
            x=tonumber(x)
            if type(x) == "number" then
                if x>4 and x<21 then
                    HealBot_AddChat("Aux MAX Total Heal Absorbs set to MaxHealth / "..x)
                    HealBot_Globals.HealAbsorbsDiv=x
                    HealBot_Timers_Set("LAST", "SetInHealAbsorbMax")
                else
                    HealBot_AddChat("The MAX Total Heal Absorbs divider must be between 5 and 20")
                end
            else
                HealBot_AddChat("The MAX Total Heal Absorbs divider must be a number between 5 and 20")
            end
        elseif (HBcmd == "trs") then
            xButton, pButton=HealBot_Panel_RaidUnitButton(HealBot_Data["PGUID"])
            if xButton then
                xButton.health.init=false
                xButton.health.current=1
                xButton.gref["Bar"]:SetValue(0)
                HealBot_UnitHealth(xButton)
            end
            if pButton then
                pButton.health.init=false
                pButton.health.current=1
                pButton.gref["Bar"]:SetValue(0)
                HealBot_UnitHealth(pButton)
            end
        elseif (HBcmd == "caf" and x) then
            if HEALBOT_GAME_VERSION<5 then
                x=tonumber(x)
                if x>-1 and x<2 then
                    HealBot_Config.ClassicAbsorbsFilter=x
                    HealBot_AddChat("ClassicAbsorbsFilter set to "..x)
                    HealBot_Timers_Set("AURA","InitAuraData")
                else
                    HealBot_AddChat("ClassicAbsorbsFilter: Invalid number entered")
                    HealBot_AddChat("0: All absorbs")
                    HealBot_AddChat("1: Illuminated Healing")
                    HealBot_AddChat("Current ClassicAbsorbsFilter is "..HealBot_Config.ClassicAbsorbsFilter)
                end
            end
        elseif (HBcmd == "zzz") then
            aButton=HealBot_Panel_RaidButton(HealBot_Data["PGUID"])

            --HealBot_Skins_Check_Aux("Standard")
            HealBot_AddDebug("#: UpdateNumUnits="..HealBot_luVars["UpdateNumUnits"].." nProcs="..HealBot_Timers_retLuVars("nProcs"))

            local k="CTRL-F4"
            local a=GetBindingByKey(k)
            HealBot_AddDebug(k.." is bound to "..(a or "nil"),"Bindings",true)
            
            --local z=(UnitGetTotalAbsorbs(aButton.unit) or 0)
            --local z=0
            --if HEALBOT_GAME_VERSION>1 then
            --    z=GetMastery()
            --    HealBot_AddDebug("Mastery="..z)
            --end
            --z=GetSpellBonusHealing()
            --HealBot_AddDebug("BonusHealing="..z)

            if HEALBOT_GAME_VERSION == 4 then
               --for x=1, 19 do
               --     local tTab, tIndex=3, x
               --     local name, iconTexture, tier, column, rank, maxRank, isExceptional, available, previewRank, previewAvailable=GetTalentInfo(tTab, tIndex)
               --     HealBot_AddDebug("Talent("..tTab..","..tIndex..") is "..name.." tier="..tier.." column="..column.." rank="..rank,"Talent",true)
               --- end
               --local Continent=HealBot_MountsPets_getContinent()
               --HealBot_AddDebug("Continent is "..Continent,"Zone",true)
            end
            
        else
            if x then HBcmd=HBcmd.." "..x end
            if y then HBcmd=HBcmd.." "..y end
            if z then HBcmd=HBcmd.." "..z end
            HealBot_AddChat(HEALBOT_CHAT_UNKNOWNCMD..HBcmd)
            HealBot_luVars["HelpCnt1"]=0
            HealBot_luVars["Help"]=true
        end
    end
end

function HealBot_TestBars()
      --HealBot_setCall("HealBot_TestBars")
    HealBot_Panel_ToggleTestBars(HealBot_Data["UILOCK"])
    HealBot_Timers_Set("SKINS","ResetSkinAllElements")
    HealBot_Timers_Set("SKINS","ResetFrameAlias")
    HealBot_Options_framesChanged(true, true, true, true, true)

end

local hbManaWatch={}
local hbAuraWatchMana={}
local hbActionManaWatch={}
local hbManaExtra={}
function HealBot_ManaExtra(guid, state)
      --HealBot_setCall("HealBot_ManaExtra", nil, guid)
    if state then
        hbManaExtra[guid]=true
    elseif not hbManaWatch[guid] and not hbAuraWatchMana[guid] and not hbActionManaWatch[guid] then
        hbManaExtra[guid]=nil
    end
end

function HealBot_ManaWatch(guid, state)
      --HealBot_setCall("HealBot_ManaWatch", nil, guid)
    if state then
        hbManaWatch[guid]=true
    else
        hbManaWatch[guid]=nil
    end
    HealBot_ManaExtra(guid, state)
end

function HealBot_AuraWatchMana(guid, state)
      --HealBot_setCall("HealBot_AuraWatchMana", nil, guid)
    if state then
        hbAuraWatchMana[guid]=true
    else
        hbAuraWatchMana[guid]=nil
    end
    HealBot_ManaExtra(guid, state)
end

function HealBot_ActionWatchMana(guid, state)
      --HealBot_setCall("HealBot_ManaWatchClear", nil, guid)
    if state then
        hbActionManaWatch[guid]=true
    else
        hbActionManaWatch[guid]=nil
    end
    HealBot_ManaExtra(guid, state)
end

function HealBot_ManaWatchClear()
      --HealBot_setCall("HealBot_ManaWatchClear")
    hbManaWatch={}
end

function HealBot_AuraWatchManaClear()
      --HealBot_setCall("HealBot_AuraWatchManaClear")
    hbAuraWatchMana={}
end

local hbManaCurrent, hbManaMax, pLowManaDrinkNeed=0,0,false
function HealBot_UnitMana(button)
      --HealBot_setCall("HealBot_UnitMana", button)
    button.mana.update=false
    if button.mana.change then HealBot_Action_setButtonManaBarCol(button) end
    if button.status.current<HealBot_Unit_Status["DEAD"] then
        hbManaCurrent=UnitPower(button.unit) or 0
        hbManaMax=UnitPowerMax(button.unit) or 0
        if button.mana.current~=hbManaCurrent or button.mana.max~=hbManaMax or button.mana.change then
            if not HealBot_Data["UILOCK"] and HEALBOT_GAME_VERSION<5 and button.isplayer and not button.player and (hbManaMax>(button.mana.max*1.25) or hbManaMax<(button.mana.max*0.75)) then
                HealBot_Events_SpecChange(button)
            end
            if hbManaCurrent < button.mana.current then
                button.mana.lowcheck=true
            end
            button.mana.current=hbManaCurrent
            button.mana.max=hbManaMax
            if button.mana.max>0 then
                button.mana.pct=floor((button.mana.current/button.mana.max)*100)
                button.mana.pctc=button.mana.pct*10
            else
                button.mana.pct=0
                button.mana.pctc=0
            end
            if hbManaExtra[button.guid] then
                if hbManaWatch[button.guid] then
                    HealBot_Plugin_ManaWatch_UnitUpdate(button)
                end
                if hbAuraWatchMana[button.guid] then
                    HealBot_Plugin_AuraWatch_ManaUpdate(button)
                end
                if hbActionManaWatch[button.guid] then
                    HealBot_ActionIcons_UpdateMana(button.guid, button.mana.pct)
                end
            end
            HealBot_Aux_setPowerBars(button)
            if button.mouseover and HealBot_Data["TIPBUTTON"] then HealBot_setTooltipUpdateNow() end
        end
        HealBot_Events_PowerIndicators(button)
    elseif button.mana.current>0 or button.mana.max>0 then
        button.mana.current=0
        button.mana.max=0
        HealBot_Aux_setPowerBars(button)
        HealBot_Events_PowerIndicators(button)
    end
end

function HealBot_GetUnitGuild(button)
      --HealBot_setCall("HealBot_GetUnitGuild", button)
    if button.isplayer and GetGuildInfo(button.unit) then
        button.guild, button.guildtitle, button.guildrank=GetGuildInfo(button.unit)
    else
        button.guild=false
    end
end

function HealBot_UpdateUnitClear(button, unitExists)
      --HealBot_setCall("HealBot_UpdateUnitClear", button)
    button.health.init=true
    button.mana.init=true
    button.spec=" "
    if not unitExists or (button.status.isdead and not button.status.isspirit) then
        HealBot_Aura_RemoveIcons(button)
        button.adaptive.current=12
        HealBot_ActionIcons_FadeUnitIcons(button.guid, button.unit)
        button.status.incombat=false
        button.status.hostile=false
        if not unitExists then
            button.player=false
            button.isplayer=false
            button.status.isdead=false
            button.status.isspirit=false
            button.guid=button.unit
        end
        HealBot_Aggro_ClearUnitAggro(button)
        HealBot_Aux_clearAllBars(button)
    else
        button.aura.buff.update=true
        HealBot_Events_UnitBuff(button)
        HealBot_CalcThreat(button)
        HealBot_UnitAffectingCombat(button)
        HealBot_Events_ClassificationChanged(button)
        HealBot_Aux_ResetByTypeById(button)
        if button.status.isdead then
            HealBot_Aura_RemoveDebuffIcons(button)
        else
            button.aura.debuff.update=true
            HealBot_Events_UnitDebuff(button)
        end
    end
    if HealBot_luVars["pluginAuraWatch"] then
        HealBot_Plugin_AuraWatch_ResetOnChangeNoIndex(button)
    end
    HealBot_Action_DisableButtonGlowType(button, "ALL")
    HealBot_Action_DisableBorderHazard(button)
    HealBot_Action_UpdateBackground(button)
    HealBot_RefreshUnit(button)
end

function HealBot_ClassNotKnown(button)
    button.player=false
    button.isplayer=false
    button.guid=button.unit
    HealBot_UpdateUnitClear(button, true)
end

local uuUnitClassEN="XXXX"
function HealBot_UpdateUnitNotExists(button, isSetHealButton)
      --HealBot_setCall("HealBot_UpdateUnitNotExists - c="..button.status.current, button)
    HealBot_Action_setState(button, HealBot_Unit_Status["RESERVED"])
    button.status.slowupdate=true
    button.status.update=true
    button.status.change=true
    HealBot_UpdateUnitClear(button)
    HealBot_UnitHealth(button, true)
    HealBot_Text_setNameTag(button)
    HealBot_Text_UpdateNameButton(button)
    if hbv_Skins_GetFrameVar("BarText", "HLTHTXTANCHOR", button.frame)~=4 then button.text.healthupdate=true end
    HealBot_Action_UpdateAllIndicators(button)
    HealBot_Action_EmergBarCheck(button, true)
    button.status.classknown=false
    if not isSetHealButton then
        if hbv_IsUnitType(button.status.unittype, HEALBOT_VEHICLE) and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][9]["STATE"] then
            HealBot_Timers_Set("OOC","RefreshPartyNextRecalcVehicle")
        elseif hbv_IsUnitType(button.status.unittype, HEALBOT_PET) and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["STATE"] then
            HealBot_Timers_Set("OOC","RefreshPartyNextRecalcPets")
        end
    end
    if button.status.dirarrowshown>0 then HealBot_Action_HideDirectionArrow(button) end
end

function HealBot_UpdateUnit(button)
      --HealBot_setCall("HealBot_UpdateUnit", button)
    if button.status.classknown then
        button.status.update=false
        button.status.slowupdate=true
        button.status.postupdate=true
        HealBot_Events_UnitManaUpdate(button)
        HealBot_Aux_UpdBar(button)
        HealBot_Events_ClassificationChanged(button)
        HealBot_UnitAffectingCombat(button)
        HealBot_Action_ResetUnitButtonOpacity(button)
        HealBot_UnitHealth(button)
        HealBot_Action_AdaptiveOORUpdate(button)
        HealBot_Action_UpdateBackground(button)
        HealBot_Action_EmergBarCheck(button, true)
        button.level=UnitLevel(button.unit) or 1
        HealBot_RefreshUnit(button)
		if button.status.guidupdate then
			button.status.guidupdate=false
			button.status.guidchange=true
		end
    else
        HealBot_ClassNotKnown(button)
    end
end

function HealBot_UpdateUnitGUIDChange(button, notRecalc)
      --HealBot_setCall("HealBot_UpdateUnitGUIDChange", button)
    HealBot_QueueClearGUID(button)
    button.guid=UnitGUID(button.unit) or button.unit
    HealBot_UnitClass(button)
    if button.status.classknown then
        HealBot_Range_UpdateUnit(button)
        if button.status.current == HealBot_Unit_Status["RESERVED"] then HealBot_Action_setState(button, HealBot_Unit_Status["CHECK"]) end
        HealBot_ClearGUIDQueue[button.guid]=nil
        HealBot_UpdateUnitClear(button, true)
        if notRecalc then
            HealBot_Panel_updDataStore(button)
        end
        button.status.slowupdate=true
        button.status.update=true
        button.status.change=true
        button.status.guidupdate=true
        HealBot_SpecUpdate(button, HealBot_TimeNow)
    else
        HealBot_ClassNotKnown(button)
    end
end

local hbAuraTargetWatch={}
function HealBot_TargetWatch(guid, enable)
      --HealBot_setCall("HealBot_TargetWatch", nil, guid)
    if enable then
        hbAuraTargetWatch[guid]=true
    else
        hbAuraTargetWatch[guid]=nil
    end
end

function HealBot_UnitExists(button)
    if UnitExists(button.unit) then
        if button.guid~=UnitGUID(button.unit) then
            HealBot_UpdateUnitGUIDChange(button, true)
            if hbAuraTargetWatch[button.guid] then
                HealBot_Plugin_AuraWatch_TargetUpdate(button)
            end
        end
        return true
    elseif button.status.current<HealBot_Unit_Status["RESERVED"] then
        HealBot_UpdateUnitNotExists(button)
    end
    return false
end

local guName=false
function HealBot_SetGuidData(button)
    _, uuUnitClassEN=UnitClass(button.unit);
    if uuUnitClassEN then
        button.status.classknown=true
        button.text.classtrim=strsub(uuUnitClassEN,1,4)
        button.text.r,button.text.g,button.text.b=HealBot_Action_ClassColour(button.unit, button.text.classtrim)
        if HealBot_Panel_RaidPetUnitButtonCheck(button.guid) then
            guName=HealBot_customTempUserName[button.guid] or UnitName(button.unit) or false
            if guName and guName~=HEALBOT_WORDS_UNKNOWN then
                button.name=guName
                HealBot_Action_SetGuidData(button, "CLASSKNOWN", true)
                HealBot_Action_SetGuidData(button, "PLAYER", button.player)
                HealBot_Action_SetGuidData(button, "ISPLAYER", button.isplayer)
                HealBot_Action_SetGuidData(button, "CLASSTRIM", button.text.classtrim)
                HealBot_Action_SetGuidData(button, "CLASSR", button.text.r)
                HealBot_Action_SetGuidData(button, "CLASSG", button.text.g)
                HealBot_Action_SetGuidData(button, "CLASSB", button.text.b)
                HealBot_Action_SetGuidData(button, "NAME", guName)
            end
        end
    elseif button.isplayer then
        button.status.classknown=false
    else
        button.status.classknown=true
        button.text.r,button.text.g,button.text.b=HealBot_Action_ClassColour(button.unit)
    end
end

function HealBot_UnitClass(button)
      --HealBot_setCall("HealBot_UnitClass", button)
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
        if UnitIsUnit(button.unit, "player") then
            button.player=true
            button.isplayer=true
            button.status.range=2
        else
            button.player=false
            if UnitIsPlayer(button.unit) then
                button.isplayer=true
            else
                button.isplayer=false
            end
        end
        button.name=false
        HealBot_SetGuidData(button)
    end
end

function HealBot_UpdateUnitExists(button)
      --HealBot_setCall("HealBot_UpdateUnitExists", button)
    if button.status.current == HealBot_Unit_Status["RESERVED"] then HealBot_Action_setState(button, HealBot_Unit_Status["CHECK"]) end
    if not button.status.classknown then
        HealBot_ClassNotKnown(button)
    else
        button.health.mixcolr, button.health.mixcolg, button.health.mixcolb=button.text.r, button.text.g, button.text.b
        button.status.change=false
        button.status.slowupdate=true
        button.status.postchange=true
        if not button.status.duplicate and button.status.unittype<20 then
            button.status.plugin=true
        else
            button.status.plugin=false
        end
        HealBot_Text_setNameTag(button)
        HealBot_Text_UpdateNameButton(button)
        HealBot_UpdateUnit(button)
    end
end

function HealBot_RecalcParty(changeType)
    --HealBot_setCall("HealBot_RecalcParty")
    HealBot_RefreshTypes[changeType]=false
    if changeType == 5 and not HealBot_luVars["UpdateEnemyFrame"] then
        HealBot_Timers_Set("OOC","RefreshPartyNextRecalcEnemy")
    else
        HealBot_Action_resetShouldHealSomeFrames()
        HealBot_Panel_PartyChanged(HealBot_Data["UILOCK"], changeType)
    end
end

function HealBot_CheckZone()
    --HealBot_setCall("HealBot_CheckZone")
    HealBot_Timers_Set("LAST","ZoneUpdate")
    HealBot_Timers_Set("LAST","MountsPetsZone")
end

function HealBot_CheckSubZone()
    --HealBot_setCall("HealBot_CheckSubZone")
    if HealBot_luVars["mapAreaID"] == 125 then
        HealBot_Timers_Set("LAST","MountsPetsZone")
    end
end

function HealBot_Update_BuffsForSpecDD(ddId,bType)
    --HealBot_setCall("HealBot_Update_BuffsForSpecDD")
    if bType == "Debuff" then
        for z=1,4 do
            if HealBot_Config_Cures.HealBotDebuffDropDown[ddId] and not HealBot_Config_Cures.HealBotDebuffDropDown[z..ddId] then
                HealBot_Config_Cures.HealBotDebuffDropDown[z..ddId]=HealBot_Config_Cures.HealBotDebuffDropDown[ddId]
            elseif not HealBot_Config_Cures.HealBotDebuffDropDown[z..ddId] then
                HealBot_Config_Cures.HealBotDebuffDropDown[z..ddId]=4
            end
            if HealBot_Config_Cures.HealBotDebuffText[ddId] and not HealBot_Config_Cures.HealBotDebuffText[z..ddId] then
                local sName=HealBot_Config_Cures.HealBotDebuffText[ddId]
                if HEALBOT_GAME_VERSION>3 then
                    if sName == (HEALBOT_NATURES_CURE or HEALBOT_IMPROVED_NATURES_CURE) and z ~= 4 then
                        sName=HEALBOT_REMOVE_CORRUPTION
                    elseif sName == HEALBOT_REMOVE_CORRUPTION and z == 4 then
                        if HealBot_Spells_KnownByName(HEALBOT_IMPROVED_NATURES_CURE) then
                            sName=HEALBOT_IMPROVED_NATURES_CURE
                        else
                            sName=HEALBOT_NATURES_CURE
                        end
                    elseif sName == HEALBOT_PURIFY_SPIRIT and z ~= 3 then
                        sName=HEALBOT_CLEANSE_SPIRIT
                    elseif sName == HEALBOT_CLEANSE_SPIRIT and z == 3 then
                        sName=HEALBOT_PURIFY_SPIRIT
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
end

function HealBot_Update_BuffsForSpec(buffType)
    --HealBot_setCall("HealBot_Update_BuffsForSpec")
    if buffType then
        if buffType == "Debuff" then
            for x=1,4 do
                HealBot_Update_BuffsForSpecDD(x,"Debuff")
            end
        else
            for x=1,8 do
                HealBot_Update_BuffsForSpecDD(x,"Buff")
            end
        end
    else
        for x=1,4 do
            HealBot_Update_BuffsForSpecDD(x,"Debuff")
        end
        for x=1,8 do
            HealBot_Update_BuffsForSpecDD(x,"Buff")
        end
    end
end

local HealBot_GetContainerNumSlots=GetContainerNumSlots
local HealBot_GetContainerItemID=GetContainerItemID
if C_Container then
    HealBot_GetContainerNumSlots=C_Container.GetContainerNumSlots or GetContainerNumSlots
    HealBot_GetContainerItemID=C_Container.GetContainerItemID or GetContainerItemID
end

local HealBot_WellFedItems={}
local HealBot_ManaDrinkItems={}
local HealBot_BuffExtraItems={}
local HealBot_ConsumableItems={}
local hbCacheItemIcons={}

function HealBot_retWellFedItems()
      --HealBot_setCall("HealBot_retWellFedItems")
    return HealBot_WellFedItems
end

function HealBot_retManaDrinkItems()
      --HealBot_setCall("HealBot_retManaDrinkItems")
    return HealBot_ManaDrinkItems
end

function HealBot_retBuffExtraItems()
      --HealBot_setCall("HealBot_retBuffExtraItems")
    return HealBot_BuffExtraItems
end

function HealBot_retConsumableItems()
      --HealBot_setCall("HealBot_retConsumableItems")
    return HealBot_ConsumableItems
end

function HealBot_retItemIcon(name)
      --HealBot_setCall("HealBot_retItemIcon")
    return hbCacheItemIcons[name]
end

local function EnumerateTooltipLines_helper(pattern, ...)
    local prevText,region=nil,nil
    for i=1, select("#", ...) do
        region=select(i, ...)
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

local hbBagScanExcludeItems={[82800]=true}
local hbBagScanIncludeItems={}
local hbCacheItemNames={}
local function HealBot_IncludeScanItem(id, name, iType)
      --HealBot_setCall("HealBot_IncludeScanItem")
    if not hbBagScanIncludeItems[id] then hbBagScanIncludeItems[id]={} end
    hbBagScanIncludeItems[id][iType]=name
end

local function HealBot_CacheItemIdsInBag(id, bag, slot)
      --HealBot_setCall("HealBot_CacheItemIdsInBag")
    HealBot_ItemsInBags[id]={}
    HealBot_ItemsInBags[id].bag=bag
    HealBot_ItemsInBags[id].slot=slot
    if not hbCacheItemNames[id] then
        local itemName, _, _, _, _, _, _, _, _, itemTexture, _, classID=HealBot_WoWAPI_ItemInfo(id)
        if itemName then
            hbCacheItemNames[id]=itemName
            hbCacheItemIcons[itemName]=itemTexture
            if HealBot_WoWAPI_ItemClassInfo(classID) == "Consumable" then
                HealBot_ConsumableItems[id]=itemName
            end
        end
    end
    if hbCacheItemNames[id] then
        HealBot_ItemsInBags[hbCacheItemNames[id]]=true
    end
end

function HealBot_ItemIdsInBag(slot)
      --HealBot_setCall("HealBot_ItemIdsInBag")
    if slot<=HealBot_luVars["MaxBagSlots"] then
        local itemId=HealBot_GetContainerItemID(HealBot_luVars["CurrentBag"],slot) or 0
        if itemId>0 then
            HealBot_CacheItemIdsInBag(itemId, HealBot_luVars["CurrentBag"], slot)
            if not hbBagScanExcludeItems[itemId] then
                if not hbBagScanIncludeItems[itemId] then
                    HealBot_SetToolTip(HealBot_ScanTooltip)
                    local itemText=""
                    HealBot_ScanTooltip:SetBagItem(HealBot_luVars["CurrentBag"], slot)
                    itemText=EnumerateTooltipLines_helper(HEALBOT_STRING_MATCH_WELLFED, HealBot_ScanTooltip:GetRegions())
                    if itemText and HealBot_ConsumableItems[itemId] then
                        HealBot_WellFedItems[itemText]=true
                        HealBot_IncludeScanItem(itemId, itemText, "WellFed")
                    end
                    itemText=EnumerateTooltipLines_helper(HEALBOT_STRING_MATCH_RESTOREMANA, HealBot_ScanTooltip:GetRegions())
                    if itemText and HealBot_ConsumableItems[itemId] then
                        HealBot_ManaDrinkItems[itemText]=true
                        HealBot_IncludeScanItem(itemId, itemText, "ManaDrink")
                    end
                    itemText=false
                    for j=1, #HEALBOT_STRING_MATCH_EXTRABUFFS do
                        if not itemText then
                            itemText=EnumerateTooltipLines_helper(HEALBOT_STRING_MATCH_EXTRABUFFS[j], HealBot_ScanTooltip:GetRegions())
                        end
                    end
                    if itemText and HealBot_ConsumableItems[itemId] then
                        HealBot_BuffExtraItems[itemText]=true
                        HealBot_IncludeScanItem(itemId, itemText, "Extra")
                    end
                    if not hbBagScanIncludeItems[itemId] and HealBot_luVars["InvReady"] then
                        hbBagScanExcludeItems[itemId]=true
                    end
                else
                    if hbBagScanIncludeItems[itemId]["WellFed"] then
                        HealBot_WellFedItems[hbBagScanIncludeItems[itemId]["WellFed"]]=true
                    end
                    if hbBagScanIncludeItems[itemId]["ManaDrink"] then
                        HealBot_ManaDrinkItems[hbBagScanIncludeItems[itemId]["ManaDrink"]]=true
                    end
                    if hbBagScanIncludeItems[itemId]["Extra"] then
                        HealBot_BuffExtraItems[hbBagScanIncludeItems[itemId]["Extra"]]=true
                    end
                end
            end
        end
        HealBot_ItemIdsInBag(slot+1)
    elseif HealBot_luVars["CurrentBag"]<NUM_BAG_SLOTS then
        HealBot_Timers_Set("PLAYER","ScanNextBag",true)
    else
        HealBot_luVars["BagsBeingScanned"]=false
        if not HealBot_luVars["InvFirstRunDone"] then
            HealBot_luVars["InvFirstRunDone"]=true
            HealBot_Timers_Set("PLAYER","InvChange",true)
        else
            HealBot_Options_SetBuffExtraItemText()
            HealBot_luVars["BagsScanned"]=true
            HealBot_Timers_Set("LAST","InitItemsData",true)
            HealBot_Timers_Set("LAST","ExtraBuffsTabInvUp",true)
            HealBot_Timers_Set("OOC","ActionIconsValidateItems",true)
        end
    end
end

function HealBot_ItemIdsInNextBag()
    HealBot_luVars["CurrentBag"]=HealBot_luVars["CurrentBag"]+1
    HealBot_luVars["MaxBagSlots"]=HealBot_GetContainerNumSlots(HealBot_luVars["CurrentBag"])
    HealBot_ItemIdsInBag(1)
end

function HealBot_ItemIdsInBags()
    if not HealBot_luVars["BagsBeingScanned"] then
        HealBot_luVars["BagsScanned"]=false
        HealBot_luVars["BagsBeingScanned"]=true
      --HealBot_setCall("HealBot_retItemIdsInBag")
        for x,_ in pairs(HealBot_ItemsInBags) do
            HealBot_ItemsInBags[x]=nil;
        end
        for x,_ in pairs(HealBot_WellFedItems) do
            HealBot_WellFedItems[x]=nil
        end
        for x,_ in pairs(HealBot_ManaDrinkItems) do
            HealBot_ManaDrinkItems[x]=nil
        end
        for x,_ in pairs(HealBot_BuffExtraItems) do
            HealBot_BuffExtraItems[x]=nil
        end
        HealBot_luVars["MaxBagSlots"]=HealBot_GetContainerNumSlots(0)
        HealBot_luVars["CurrentBag"]=0
        HealBot_ItemIdsInBag(1)
    else
        HealBot_Timers_Set("PLAYER","InvChange",true,true)
    end
end

function HealBot_InvReady()
    HealBot_luVars["InvReady"]=true
    HealBot_Timers_Set("PLAYER","InvChange")
    HealBot_Timers_Set("AURA","BuffsReset",true,true)
end

function HealBot_Register_Events()
      --HealBot_setCall("HealBot_Register_Events")
    if HealBot_Config.DisabledNow == 0 then
        if HEALBOT_GAME_VERSION>1 then
            HealBot:RegisterEvent("PLAYER_FOCUS_CHANGED");
        end
        if HEALBOT_GAME_VERSION>2 then
            HealBot:RegisterEvent("UNIT_ENTERED_VEHICLE");
            HealBot:RegisterEvent("UNIT_EXITED_VEHICLE");
            if HEALBOT_GAME_VERSION == 3 then
                HealBot:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
            end
        end
        if HEALBOT_GAME_VERSION>3 then
            HealBot:RegisterEvent("COMPANION_LEARNED");
            if HEALBOT_GAME_VERSION>9 then
                HealBot:RegisterEvent("INCOMING_SUMMON_CHANGED")
                HealBot:RegisterEvent("TRAIT_CONFIG_UPDATED")
            end
            if HEALBOT_GAME_VERSION>6 then
                HealBot:RegisterEvent("NEW_MOUNT_ADDED")
            end
            if HEALBOT_GAME_VERSION>4 then
                HealBot:RegisterEvent("PLAYER_TALENT_UPDATE");
                HealBot:RegisterEvent("PLAYER_ROLES_ASSIGNED");
                HealBot:RegisterEvent("PET_BATTLE_OPENING_START");
                HealBot:RegisterEvent("PET_BATTLE_OVER");
            end
        end
        HealBot:RegisterEvent("PLAYER_MOUNT_DISPLAY_CHANGED")
        HealBot:RegisterEvent("SPELL_UPDATE_COOLDOWN")
        HealBot:RegisterEvent("SPELL_UPDATE_CHARGES")
        HealBot:RegisterEvent("PLAYER_TARGET_CHANGED");
        local regPower=false
        if HEALBOT_GAME_VERSION>10 then
            HealBot:RegisterEvent("LEARNED_SPELL_IN_SKILL_LINE")
        else
            HealBot:RegisterEvent("LEARNED_SPELL_IN_TAB")
        end
        HealBot:RegisterEvent("PLAYER_LEVEL_UP");
        HealBot:RegisterEvent("CHARACTER_POINTS_CHANGED");
        HealBot:RegisterEvent("INSPECT_READY");
        HealBot:RegisterEvent("MODIFIER_STATE_CHANGED");
        HealBot:RegisterEvent("UNIT_PET");
        HealBot:RegisterEvent("CURSOR_CHANGED")

        HealBot:RegisterEvent("ROLE_CHANGED_INFORM");
        local regThis={}
        for j=1,10 do
            if hbv_Skins_GetFrameBoolean("RaidIcon", "SHOW", j) then regThis["RAIDTARGET"]=true end
            if hbv_Skins_GetFrameBoolean("Icons", "SHOWRC", j) then regThis["READYCHECK"]=true end
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
    HealBot:RegisterEvent("PLAYER_REGEN_DISABLED");
    HealBot:RegisterEvent("PLAYER_REGEN_ENABLED");
    HealBot:RegisterEvent("GET_ITEM_INFO_RECEIVED");
    HealBot:RegisterEvent("GROUP_ROSTER_UPDATE");
    HealBot:RegisterEvent("RAID_ROSTER_UPDATE");
    HealBot:RegisterEvent("CHAT_MSG_ADDON");
    HealBot:RegisterEvent("PLAYER_ENTERING_WORLD");
    HealBot:RegisterEvent("PLAYER_LEAVING_WORLD");
    HealBot:RegisterEvent("ZONE_CHANGED_NEW_AREA");
    HealBot:RegisterEvent("PLAYER_GUILD_UPDATE")
    if HEALBOT_GAME_VERSION>2 and HEALBOT_GAME_VERSION<9 then
        HealBot:RegisterEvent("ZONE_CHANGED");
        HealBot:RegisterEvent("ZONE_CHANGED_INDOORS");
    end
    HealBot:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
end

function HealBot_Load()
      --HealBot_setCall("HealBot_Load")
    if not HealBot_luVars["Loaded"] then
        HealBot_Data["PGROUP"]=1
        HealBot_Media_Register()
        HealBot_FastFuncsUpdate()
        HealBot_Init_Spells_Defaults()
        HealBot_SetPlayerData()
        HealBot_Init_NewChar()
        HealBot_luVars["CurrentSpec"]=HealBot_Config.CurrentSpec
        HealBot_Skins_ResetSkin("init")
        HealBot_Timers_InitSpells()
        HealBot_Text_tagWithName()
        HealBot_Action_SetCustomRoleCols()
        HealBot_Action_SetCustomPowerCols()
        HealBot_MMButton_Init()
        HealBot_Aura_SetAuraWarningFlags()
        HealBot_Options_Override_ChatUse_Toggle()
        HealBot_Options_Override_EffectsUse_Toggle()
        HealBot_Options_Override_FramesUse_Toggle()
        HealBot_Options_Override_ColoursClassUse_Toggle()
        HealBot_Options_Override_ColoursRoleUse_Toggle()
        HealBot_Options_Override_ColoursPowerUse_Toggle()
        HealBot_Options_Override_ColoursAdaptiveUse_Toggle()
        HealBot_Action_StickyFrameIndCols()
        HealBot_Register_IncHeals()
        HealBot_PartyUpdate_CheckSkin()
        HealBot_Timers_SetCurrentSkin()
        HealBot_Timers_Set("SKINS","ResetGlobalDimming")
        HealBot_Comms_PerfLevel()
        HealBot_Timers_Set("INIT","CheckTalentInfo")
        HealBot_Timers_Set("INIT","SeparateInHealsAbsorbs")
        HealBot_Timers_Set("INIT","RegEvents")
        HealBot_Timers_Set("PLAYER","LoadProfile")
        HealBot_Timers_Set("SKINS","RaidTargetUpdate")
        HealBot_Timers_Set("SKINS","TextExtraCustomCols")
        HealBot_Timers_Set("SKINS","PowerIndicator")
        HealBot_Timers_Set("AURA","InitAuraData")
        HealBot_Timers_Set("LAST","LowManaTrig")
        HealBot_Timers_Set("LAST","CheckFramesOnCombat")
        HealBot_Timers_Set("LAST","LastLoad")
        HealBot_luVars["UpdateSlowNext"]=HealBot_TimeNow+1
        HealBot_Debug_PerfUpdate("PerfLevel", HealBot_Globals.CPUUsage)
        HealBot:SetScript("OnUpdate", HealBot_OnUpdate)
        HealBot_Timers_TurboOn()
        HealBot_Globals.FirstLoad=false
    end
end

function HealBot_Loaded()
      --HealBot_setCall("HealBot_Loaded")
    HealBot_luVars["Loaded"]=true
    HealBot_Events_setLuVars("Loaded", true)
    C_Timer.After(5, function() HealBot_Timers_Set("PLAYER","InvReady") end)
end

function HealBot_FullReload()
      --HealBot_setCall("HealBot_FullReload")
    if not HealBot_luVars["UILOCK"] then
        HealBot_ReloadAddon()
    else
        HealBot_Timers_Set("OOC","FullReload")
    end
end

function HealBot_Reload()
      --HealBot_setCall("HealBot_Reload")
    HealBot_Timers_Set("RESET","Quick")
end

function HealBot_UnRegister_Events()
      --HealBot_setCall("HealBot_UnRegister_Events")
    if HealBot_Config.DisabledNow == 1 then
        if HEALBOT_GAME_VERSION>1 then
            HealBot:UnregisterEvent("PLAYER_FOCUS_CHANGED");
        end
        if HEALBOT_GAME_VERSION>2 then
            HealBot:UnregisterEvent("UNIT_ENTERED_VEHICLE");
            HealBot:UnregisterEvent("UNIT_EXITED_VEHICLE");
            if HEALBOT_GAME_VERSION == 3 then
                HealBot:UnregisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
            end
        end
        if HEALBOT_GAME_VERSION>3 then
            HealBot:UnregisterEvent("COMPANION_LEARNED");
            if HEALBOT_GAME_VERSION>9 then
                HealBot:UnregisterEvent("INCOMING_SUMMON_CHANGED")
                HealBot:UnregisterEvent("TRAIT_CONFIG_UPDATED")
            end
            if HEALBOT_GAME_VERSION>4 then
                HealBot:UnregisterEvent("PLAYER_TALENT_UPDATE");
            end
        end
        HealBot:UnregisterEvent("ZONE_CHANGED_NEW_AREA");
        if HEALBOT_GAME_VERSION>2 and HEALBOT_GAME_VERSION<9 then
            HealBot:UnregisterEvent("ZONE_CHANGED");
            HealBot:UnregisterEvent("ZONE_CHANGED_INDOORS");
        end
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
    if HEALBOT_GAME_VERSION>4 then
        HealBot:UnregisterEvent("PET_BATTLE_OPENING_START");
        HealBot:UnregisterEvent("PET_BATTLE_OVER");
        if HEALBOT_GAME_VERSION>6 then
            HealBot:UnregisterEvent("NEW_MOUNT_ADDED")
        end
    end
    HealBot:UnregisterEvent("SPELL_UPDATE_COOLDOWN")
    HealBot:UnregisterEvent("SPELL_UPDATE_CHARGES")
    HealBot:UnregisterEvent("RAID_TARGET_UPDATE")
    if HEALBOT_GAME_VERSION>10 then
        HealBot:UnregisterEvent("LEARNED_SPELL_IN_SKILL_LINE")
    else
        HealBot:UnregisterEvent("LEARNED_SPELL_IN_TAB")
    end
    HealBot:UnregisterEvent("PLAYER_LEVEL_UP");
    HealBot:UnregisterEvent("UNIT_SPELLCAST_SENT");
    HealBot:UnregisterEvent("INSPECT_READY");
    HealBot:UnregisterEvent("CHARACTER_POINTS_CHANGED");
    HealBot:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
end

function HealBot_Reset_Full()
      --HealBot_setCall("HealBot_Reset_Full")
    HealBot_UnRegister_Events()
    HealBot_Panel_ClearBlackList()
    HealBot_Panel_ClearHealTargets()
    HealBot_Update_ResetInitButtons()
    HealBot_Update_EndAggro()
    HealBot_Options_framesChanged(true, true, true, true, true)
    HealBot_Timers_Set("LAST","ZoneUpdate")
    HealBot_Timers_AuraReset()
    HealBot_Timers_Set("INIT","RegEvents")
    HealBot_Timers_Set("SKINS","ResetFrameAlias")
end

function HealBot_Reset_Quick()
      --HealBot_setCall("HealBot_Reset_Quick")
    HealBot_Timers_Set("AURA","ClearAllBuffs")
    HealBot_Timers_Set("AURA","ClearAllDebuffs")
    HealBot_Timers_Set("SKINS","ResetFrameAlias")
    HealBot_Options_framesChanged(true, true, true, true, true)
end

function HealBot_UnitID(unit, incEnemy)
      --HealBot_setCall("HealBot_UnitID")
    if UnitIsUnit(unit, "player") then
        if HealBot_Unit_Button[HealBot_Data["PUNIT"]] or HealBot_Private_Button[HealBot_Data["PUNIT"]] then
            unit=HealBot_Data["PUNIT"]
        end
        xButton=HealBot_Unit_Button[unit] or HealBot_Unit_Button["player"]
        pButton=HealBot_Private_Button[unit] or HealBot_Private_Button["player"]
    else
        xButton=HealBot_Unit_Button[unit] or HealBot_Pet_Button[unit] or HealBot_Extra_Button[unit] or HealBot_Vehicle_Button[unit]
        pButton=HealBot_Private_Button[unit]
    end
    if xButton or pButton then
        return unit, xButton, pButton
    end
    xButton, pButton=HealBot_Panel_RaidPetUnitButton(UnitGUID(unit) or "x")
    aButton=xButton or pButton
    if aButton and UnitIsUnit(aButton.unit, unit) then
        return aButton.unit, xButton, pButton
    elseif incEnemy and (HealBot_Enemy_Button[unit] or HealBot_UnitTarget_Button[unit] or HealBot_PrivateTarget_Button[unit]) then
        return unit, HealBot_Enemy_Button[unit] or HealBot_UnitTarget_Button[unit] or HealBot_PrivateTarget_Button[unit], false
    end
    return false,false,false
end

function HealBot_OverHealText(button)
      --HealBot_setCall("HealBot_OverHealText", button)
    if hbv_Skins_GetFrameVar("BarText", "OVERHEAL", button.frame)>1 then
        HealBot_Text_setOverHealText(button)
    end
end

local hiuOverHeal,hiuPlayerInHeal=0
function HealBot_OverHeal(button)
      --HealBot_setCall("HealBot_OverHeal", button)
    if HealBot_luVars["overhealUnit"] == button.unit then
        hiuPlayerInHeal=UnitGetIncomingHeals(button.unit, "player") or 0
        hiuOverHeal=(button.health.current+hiuPlayerInHeal)-button.health.max
        if hiuOverHeal<1 then hiuOverHeal=0 end
    else
        hiuOverHeal=(button.health.current+button.health.auxincoming)-button.health.max
        if hiuOverHeal<1 then hiuOverHeal=0 end
    end
    if button.health.overheal~=hiuOverHeal then
        button.health.overheal=hiuOverHeal
        HealBot_OverHealText(button)
        HealBot_Aux_UpdateOverHealBar(button)
        HealBot_Action_AdaptiveOverhealsUpdate(button)
    end
end

local hiuHealAmount=0
local hiuCHCAmount, hiuBlizzAmount=0,0
function HealBot_HealsInAmountV1(button)
      --HealBot_setCall("HealBot_HealsInAmountV1", button)
    if button.status.current<HealBot_Unit_Status["DEAD"] then
        --hiuHealAmount=(libCHC:GetHealAmount(button.guid, libCHC.ALL_HEALS, HealBot_TimeNow+HealBot_Globals.ClassicHoTTime) or 0) * (libCHC:GetHealModifier(button.guid) or 1)
        hiuHealAmount=(libCHC:GetHealAmount(button.guid, libCHC.HOT_HEALS+libCHC.BOMB_HEALS, HealBot_TimeNow+HealBot_Globals.ClassicHoTTime) or 0) * (libCHC:GetHealModifier(button.guid) or 1)
        hiuCHCAmount=(libCHC:GetHealAmount(button.guid, libCHC.CASTED_HEALS) or 0) * (libCHC:GetHealModifier(button.guid) or 1)
        hiuBlizzAmount=UnitGetIncomingHeals(button.unit) or 0
        if hiuBlizzAmount>HealBot_luVars["BonusMinInHeal"] then
            hiuBlizzAmount=hiuBlizzAmount+HealBot_luVars["BonusHealing"]
        end
        if hiuCHCAmount>hiuBlizzAmount then
            hiuHealAmount=hiuHealAmount+hiuCHCAmount
        else
            hiuHealAmount=hiuHealAmount+hiuBlizzAmount
        end
    else
        hiuHealAmount=0
    end
end

function HealBot_HealsInAmountV4(button)
      --HealBot_setCall("HealBot_HealsInAmountV4", button)
    if button.status.current<HealBot_Unit_Status["DEAD"] then
        hiuHealAmount=UnitGetIncomingHeals(button.unit) or 0
        if hiuHealAmount>HealBot_luVars["BonusMinInHeal"] then
            hiuHealAmount=hiuHealAmount+HealBot_luVars["BonusHealing"]
        end
    else
        hiuHealAmount=0
    end
end

local HealBot_HealsInAmount=HealBot_HealsInAmountV4
if HEALBOT_GAME_VERSION<4 and libCHC then
    HealBot_HealsInAmount=HealBot_HealsInAmountV1
end

function HealBot_HealsInUpdate(button)
      --HealBot_setCall("HealBot_HealsInUpdate", button)
    button.health.updinheal=false
    HealBot_HealsInAmount(button)
    if hiuHealAmount>0 and button.status.range>0 then
        if button.health.incoming~=hiuHealAmount then
            button.health.incoming=hiuHealAmount
            HealBot_Action_UpdateHealsInButton(button)
            HealBot_Text_setInHealAbsorbsText(button)
        end
    elseif button.health.incoming>0 or button.gref["InHeal"]:GetValue()>0 then
        button.health.incoming=0
        button.gref["InHeal"]:SetValue(0)
        button.health.inheala=0
        HealBot_Action_UpdateInHealStatusBarColor(button)
        HealBot_Text_setInHealAbsorbsText(button)
    end
    if button.health.auxincoming~=hiuHealAmount then
        button.health.auxincoming=hiuHealAmount
        HealBot_OverHeal(button)
        HealBot_Aux_UpdateHealInBar(button)
    end
end

function HealBotClassic_HealsInDoUpdate(button)
      --HealBot_setCall("HealBotClassic_HealsInDoUpdate", button)
    if HealBot_Extra_Button["target"] and button.unit~="target" and UnitExists("target") and UnitIsUnit("target", button.unit) then
        HealBotClassic_HealsInDoUpdate(HealBot_Extra_Button["target"])
    end
    HealBot_HealsInUpdate(button)
    HealBot_AbsorbsUpdate(button)
end

local chiTargetGUID=false
function HealBotClassic_HealsInUpdate(spellId, ...)
      --HealBot_setCall("HealBotClassic_HealsInUpdate")
    for i=1, select("#", ...) do
        chiTargetGUID=select(i, ...)
        if chiTargetGUID then
            xButton,pButton=HealBot_Panel_AllUnitButton(chiTargetGUID)
            if xButton then HealBotClassic_HealsInDoUpdate(xButton) end
            if pButton then HealBotClassic_HealsInDoUpdate(pButton) end
        end
    end
end

local abuAbsorbAmount=0
function HealBot_Classic_AbsorbsUpdate(button, amount)
      --HealBot_setCall("HealBot_Classic_AbsorbsUpdate", button)
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
      --HealBot_setCall("HealBot_AbsorbsAmountV1", button)
    if button.status.current<HealBot_Unit_Status["DEAD"] then
        abuAbsorbAmount=button.health.auraabsorbs
    else
        abuAbsorbAmount=0
    end
end

function HealBot_AbsorbsAmountV5(button)
      --HealBot_setCall("HealBot_AbsorbsAmountV5", button)
    if button.status.current<HealBot_Unit_Status["DEAD"] then
        abuAbsorbAmount=(UnitGetTotalAbsorbs(button.unit) or 0)
    else
        abuAbsorbAmount=0
    end
end

local HealBot_AbsorbsAmount=HealBot_AbsorbsAmountV1
if HEALBOT_GAME_VERSION>4 then
    HealBot_AbsorbsAmount=HealBot_AbsorbsAmountV5
end

function HealBot_AbsorbsUpdate(button)
      --HealBot_setCall("HealBot_AbsorbsUpdate", button)
    button.health.updabsorb=false
    HealBot_AbsorbsAmount(button)
    if button.status.range>0 and abuAbsorbAmount>0 then
        if button.health.absorbs~=abuAbsorbAmount then
            button.health.absorbs=abuAbsorbAmount
            button.health.absorbspctc=floor((button.health.absorbs/button.health.max)*1000)
            HealBot_Action_UpdateHotBar(button)
            HealBot_Action_UpdateAbsorbsButton(button)
            HealBot_Text_setInHealAbsorbsText(button)
            HealBot_Action_AdaptiveAbsorbsUpdate(button)
        end
    elseif button.health.absorbs>0 or button.gref["Absorb"]:GetValue()>0 then
        button.health.absorbs=0
        button.health.absorbspctc=0
        HealBot_Text_setInHealAbsorbsText(button)
        button.health.absorba=0
        button.gref["Absorb"]:SetValue(0)
        HealBot_Action_UpdateAbsorbStatusBarColor(button)
        HealBot_Action_AdaptiveAbsorbsUpdate(button)
    end
    if button.health.auxabsorbs~=abuAbsorbAmount then
        button.health.auxabsorbs=abuAbsorbAmount
        HealBot_Aux_UpdateAbsorbBar(button)
    end
    HealBot_Action_OverShield(button)
end

function HealBot_ResetCustomDebuffs()
      --HealBot_setCall("HealBot_ResetCustomDebuffs")
    HealBot_Globals.CustomDebuffs=HealBot_Options_copyTable(HealBot_GlobalsDefaults.CustomDebuffs)
    HealBot_Globals.Custom_Debuff_Categories=HealBot_Options_copyTable(HealBot_GlobalsDefaults.Custom_Debuff_Categories)
    HealBot_Globals.FilterCustomDebuff=HealBot_Options_copyTable(HealBot_GlobalsDefaults.FilterCustomDebuff)
    HealBot_Globals.CDCBarColour=HealBot_Options_copyTable(HealBot_GlobalsDefaults.CDCBarColour)
    HealBot_Globals.CustomDebuffsShowBarCol=HealBot_Options_copyTable(HealBot_GlobalsDefaults.CustomDebuffsShowBarCol)
    HealBot_Globals.IgnoreCustomDebuff=HealBot_Options_copyTable(HealBot_GlobalsDefaults.IgnoreCustomDebuff)
    HealBot_Globals.CDCTag=HealBot_Options_copyTable(HealBot_GlobalsDefaults.CDCTag)
    HealBot_Options_NewCDebuff:SetText("")
    HealBot_Options_setLuVars("customdebufftextpage", 1)
    HealBot_Timers_Set("SKINS","ResetUpdate")
    HealBot_SetCDCBarColours();
    HealBot_AddChat(HEALBOT_CHAT_CONFIRMCUSTOMDEFAULTS)
    HealBot_Timers_Set("AURA","CustomDebuffListPrep")
end

function HealBot_ResetSkins()
      --HealBot_setCall("HealBot_ResetSkins")
    HealBot_Share_SkinLoad(HealBot_Config_SkinsData[HEALBOT_SORTBY_GROUP], true)
    HealBot_Share_SkinLoad(HealBot_Config_SkinsData[HEALBOT_OPTIONS_RAID25], true)
    HealBot_Share_SkinLoad(HealBot_Config_SkinsData[HEALBOT_OPTIONS_RAID40], true)
    HealBot_Share_SkinLoad(HealBot_Config_SkinsData[HEALBOT_SKINS_STD], true)
    HealBot_AddChat(HEALBOT_CHAT_CONFIRMSKINDEFAULTS)
    HealBot_Update_Skins()
    HealBot_Timers_Set("SKINS","ResetSkinAllElements")
    HealBot_Timers_Set("SKINS","ResetFrameAlias")
    HealBot_Options_framesChanged(true, true, true, true, true)
end

function HealBot_Reset_Button(button)
      --HealBot_setCall("HealBot_Reset_Button", button)
    button.status.slowupdate=true
    button.status.change=true
    button.status.update=true
    if HealBot_Action_AlwaysEnabled(button.guid) then HealBot_Action_Toggle_Enabled(button.unit); end
end

function HealBot_Reset_Unit(unit)
      --HealBot_setCall("HealBot_Reset_Unit", nil, nil, unit)
    _,xButton,pButton=HealBot_UnitID(unit, true)
    if xButton then
        HealBot_Reset_Button(xButton)
    end
    if pButton then
        HealBot_Reset_Button(pButton)
    end
end

function HealBot_IncHeals_ClearUnit(button)
      --HealBot_setCall("HealBot_IncHeals_ClearUnit", button)
    if button.health.incoming>0 then
        button.health.incoming=0
        button.health.auxincoming=0
        button.health.overheal=0
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

function HealBot_OnLoad()
      --HealBot_setCall("HealBot_OnLoad")
    HealBot:RegisterEvent("VARIABLES_LOADED");
    HealBot:RegisterEvent("ADDON_LOADED");
    HealBot:RegisterEvent("PLAYER_REGEN_DISABLED");
    HealBot:RegisterEvent("PLAYER_REGEN_ENABLED");
    SLASH_HEALBOT1="/healbot";
    SLASH_HEALBOT2="/hb";
    SlashCmdList["HEALBOT"]=function(msg)
        HealBot_SlashCmd(msg);
    end
end

local prevCPU,prevCPUadj,prevFPS,prevLAG,lagCurWorld=0,99,0,0,0
function HealBot_Update_CPUUsage()
      --HealBot_setCall("HealBot_Update_CPUUsage")
    prevCPU=HealBot_Globals.CPUUsage
    prevFPS=HealBot_Globals.FPS
    prevLAG=HealBot_Globals.LAG
    _, _, _, lagCurWorld=GetNetStats()
    HealBot_Globals.LAG=lagCurWorld/1000
    HealBot_luVars["FPS"][0]=ceil((HealBot_luVars["FPS"][1][0]+HealBot_luVars["FPS"][2][0]+HealBot_luVars["FPS"][3][0])/3)
    if HealBot_luVars["CPUProfilerOn"] then
        HealBot_Globals.CPUUsage=ceil(HealBot_Globals.FPS*0.1)
        if HealBot_luVars["CPUProfilerOn"] and not HealBot_luVars["warnCPUProfiler"] then
            HealBot_Debug_PerfUpdate("PerfLevel", HealBot_Globals.CPUUsage.." profiler running")
            HealBot_AddChat("WARNING: CPU profiler is running - FPS might be reduced.")
            HealBot_luVars["warnCPUProfiler"]=true
        end
        if HealBot_Globals.CPUUsage<1 then
            HealBot_Globals.CPUUsage=1
        end
    elseif HealBot_Globals.FPS~=HealBot_luVars["FPS"][0] or HealBot_luVars["cpuAdj"]~=prevCPUadj then
        prevCPUadj=HealBot_luVars["cpuAdj"]
        HealBot_Globals.FPS=HealBot_luVars["FPS"][0]
        HealBot_Globals.CPUUsage=ceil(HealBot_Globals.FPS*0.25)
        HealBot_Globals.CPUUsage=HealBot_Globals.CPUUsage+HealBot_luVars["cpuAdj"]
        if HealBot_Globals.CPUUsage<2 then
            HealBot_Globals.CPUUsage=2
        end
        HealBot_Debug_PerfUpdate("fps", HealBot_Globals.FPS)
    end
    if prevLAG~=HealBot_Globals.LAG then
        HealBot_Events_setLag()
    end
    if prevCPU~=HealBot_Globals.CPUUsage then
        if HealBot_Timers_retLuVars("LoadComplete") then
            HealBot_Timers_Set("LAST","UpdateCheckInterval",true)
        end
        HealBot_Timers_Set("SKINS","FluidFlashInUse",true,true)
        HealBot_Comms_PerfLevel()
    elseif prevFPS~=HealBot_Globals.FPS then
        HealBot_Comms_PerfLevel()
    end
end

function HealBot_UpdateCheckInterval()
      --HealBot_setCall("HealBot_UpdateCheckInterval")
    if HealBot_luVars["CPUProfilerOn"] then
        HealBot_luVars["aggroCheckInterval"]=10
        HealBot_luVars["statusCheckInterval"]=15
        HealBot_luVars["healthCheckInterval"]=15
        HealBot_Action_setLuVars("deadCheckInterval", 2)
        HealBot_Aura_setLuVars("AuraUpdate", 0.98)
        HealBot_Debug_PerfUpdate("deadInt", 2)
    else
        HealBot_luVars["statusCheckInterval"]=HealBot_Util_PerfVal2(300)+1
        HealBot_luVars["aggroCheckInterval"]=HealBot_Util_PerfVal2(100)+2
        HealBot_luVars["healthCheckInterval"]=HealBot_Util_PerfVal2(50)+3

        if HealBot_luVars["statusCheckInterval"]<2 then
            HealBot_luVars["statusCheckInterval"]=2
        elseif HealBot_luVars["statusCheckInterval"]>9 then
            HealBot_luVars["statusCheckInterval"]=9
        end
        if HealBot_luVars["aggroCheckInterval"]<3 then
            HealBot_luVars["aggroCheckInterval"]=3
        elseif HealBot_luVars["aggroCheckInterval"]>12 then
            HealBot_luVars["aggroCheckInterval"]=12
        end
        if HealBot_luVars["healthCheckInterval"]<5 then
            HealBot_luVars["healthCheckInterval"]=5
        elseif HealBot_luVars["healthCheckInterval"]>15 then
            HealBot_luVars["healthCheckInterval"]=15
        end
        HealBot_Timers_Set("LAST","ActionCheckInterval",true)
    end
    HealBot_Timers_Set("LAST","DebugCheckInterval",true)
end

function HealBot_DebugCheckInterval()
    HealBot_Debug_PerfUpdate("aggroInt", HealBot_luVars["aggroCheckInterval"])
    HealBot_Debug_PerfUpdate("statusInt", HealBot_luVars["statusCheckInterval"])
    HealBot_Debug_PerfUpdate("healthInt", HealBot_luVars["healthCheckInterval"])
end

function HealBot_PerfPlugin_adj(adj)
      --HealBot_setCall("HealBot_PerfPlugin_adj")
    HealBot_luVars["cpuAdj"]=adj
    HealBot_luVars["updUnitsAdj"]=(adj/100)+0.2
    if HealBot_luVars["updUnitsAdj"]>0.5 then
        HealBot_luVars["updUnitsAdj"]=0.5
    elseif HealBot_luVars["updUnitsAdj"]<0.1 then
        HealBot_luVars["updUnitsAdj"]=0.1
    end
    HealBot_Update_CPUUsage()
    HealBot_Timers_Set("LAST","UpdateRefreshListFreq",true)
end

local fpsRow,fpsCol,fpsCurRate=1,1,1
function HealBot_Set_FPS()
      --HealBot_setCall("HealBot_Set_FPS", nil, nil, nil, true)
    fpsCurRate=floor(GetFramerate())
    if fpsCurRate>150 then fpsCurRate=150 end
    if fpsCurRate<15 then fpsCurRate=15 end
    HealBot_luVars["FPS"][fpsRow][fpsCol]=fpsCurRate
    fpsCol=fpsCol+1
    if fpsCol>5 then
        fpsCol=1
        fpsRow=fpsRow+1
        if fpsRow>3 then fpsRow=1 end
    elseif fpsCol == 5 then
        HealBot_luVars["FPS"][fpsRow][0]=HealBot_Util_Round((HealBot_luVars["FPS"][fpsRow][1]+
                                                             HealBot_luVars["FPS"][fpsRow][2]+
                                                             HealBot_luVars["FPS"][fpsRow][3]+
                                                             HealBot_luVars["FPS"][fpsRow][4]+
                                                             HealBot_luVars["FPS"][fpsRow][5])/5, 2)
        HealBot_Update_CPUUsage()
    end
end

function HealBot_Include_Skin(skinName, internal)
      --HealBot_setCall("HealBot_Include_Skin")
    if not Healbot_Config_Skins.Author[skinName] and HealBot_Config_SkinsData[skinName] then
        HealBot_Share_SkinLoad(HealBot_Config_SkinsData[skinName], internal)
    end
end

function HealBot_UpdateBuffItem(buff, item)
      --HealBot_setCall("HealBot_UpdateBuffItem")
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
        elseif string.len(HealBot_Config_Buffs.CustomBuffName[4])<3 and string.len(HealBot_Config_Buffs.CustomItemName[4])<3 then
            HealBot_Config_Buffs.CustomBuffName[4]=buff
            HealBot_Config_Buffs.CustomItemName[4]=item
            HealBot_Config_Buffs.CustomBuffCheck[4]=true
        end
    end
end

function HealBot_setTooltipUpdateNow()
    HealBot_luVars["NextTipUpdate"]=0
end

function HealBot_setTooltipUpdateInterval()
      --HealBot_setCall("HealBot_setTooltipUpdateInterval")
    if not HealBot_Data["TIPUSE"] then
        HealBot_luVars["TipUpdateFreq"]=900
    else
        HealBot_luVars["TipUpdateFreq"]=1
    end
end


function HealBot_IsUnitReallyDead(button)
    if (UnitIsDeadOrGhost(button.unit) or button.status.hasspirit) and not UnitIsFeignDeath(button.unit) then
        return true
    else
        return false
    end
end

function HealBot_IsUnitDead(button)
      --HealBot_setCall("HealBot_IsUnitDead", button)
    button.status.hasspirit=HealBot_Aura_CurrentBuff(button.guid, HEALBOT_SPIRIT_OF_REDEMPTION_NAME)

    if button.status.current<HealBot_Unit_Status["DC"] and HealBot_IsUnitReallyDead(button) then
        if not button.status.isdead then
            button.status.isdead=true
            button.health.init=true
            button.mana.init=true
        end
        if button.status.hasspirit then
            button.status.isspirit=true
        elseif button.status.isspirit then
            button.status.isspirit=false
            HealBot_Aura_RemoveIcons(button)
            button.text.healthupdate=true
            HealBot_Text_setHealthText(button)
        end
        return true
    else
        button.status.isdead=false
        button.status.isspirit=false
        return false
    end
end

function HealBot_SetPlayerData()
      --HealBot_setCall("HealBot_SetPlayerData")
    local pClass, pClassEN=UnitClass("player")
    if pClassEN then
        HealBot_Data["PCLASSTRIM"]=strsub(pClassEN,1,4)
        HealBot_Data["PLEVEL"]=UnitLevel("player")
        local pRace, pRaceEN=UnitRace("player")
        HealBot_Data["PRACE_EN"]=pRaceEN
        if UnitIsDeadOrGhost("player") and not UnitIsFeignDeath("player") then
            HealBot_Data["PALIVE"]=false
        else
            HealBot_Data["PALIVE"]=true
        end
        HealBot_Data["POWERTYPE"]=UnitPowerType("player") or 0
        if HealBot_Data["POWERTYPE"]<0 or HealBot_Data["POWERTYPE"]>9 then HealBot_Data["POWERTYPE"]=0 end
        HealBot_Data["PGUID"]=UnitGUID("player")
        HealBot_Data["PNAME"]=UnitName("player")
        HealBot_Data["PFACTION"]=UnitFactionGroup("player")
        if HealBot_Data["PGUID"] and HealBot_Data["PCLASSTRIM"] and HealBot_Data["PLEVEL"] and HealBot_Data["PRACE_EN"] and HealBot_Data["POWERTYPE"] then
            HealBot_Timers_Set("LAST", "SetInHealAbsorbMax")
            HealBot_Timers_Set("PLAYER","SaveProfile",true)
        else
            HealBot_Timers_Set("INIT","SetPlayerData",true)
        end
        if HEALBOT_GAME_VERSION>9 then
            HealBot_luVars["BonusHealing"]=GetSpellBonusHealing()
        else
            HealBot_luVars["BonusHealing"]=ceil(GetSpellBonusHealing()*0.5)
        end
        HealBot_luVars["BonusMinInHeal"]=500+(HealBot_Data["PLEVEL"]*100)
        HealBot_Comms_PlayerVersion(UnitName("player"), HEALBOT_VERSION)
        HealBot_AddDebug("BonusHealing="..HealBot_luVars["BonusHealing"].." MinInHeal="..HealBot_luVars["BonusMinInHeal"],"Load",true)
    else
        HealBot_Timers_Set("INIT","SetPlayerData",true,true)
    end
end

function HealBot_ReloadAddon()
      --HealBot_setCall("HealBot_ReloadAddon")
    if HealBot_luVars["VarsLoaded"] then
        HealBot_luVars["Loaded"]=false
        HealBot_luVars["VarsLoaded"]=false
        HealBot_Events_setLuVars("AddonLoaded", false)
        HealBot_Events_setLuVars("VarsLoaded", false)
        HealBot_Events_setLuVars("Loaded", false)
        HealBot_Events_AddOnLoaded("HealBot")
        HealBot_VariablesLoaded()
    else
        C_Timer.After(1, HealBot_ReloadAddon)
    end
end

function HealBot_LoadAddOn()
  --HealBot_setCall("HealBot_LoadAddOn")
end

function HealBot_VariablesLoaded()
      --HealBot_setCall("HealBot_VariablesLoaded")
    HealBot_Media_setClassRoleIcons()
    HealBot_Media_setRankIcons()
    HealBot_Media_setTargetIcons()
    HealBot_Global_MetaVersion()
    HealBot_WoWAPI_SetAll()
    HealBot_globalVars()
    HealBot_Data_InitVars()
    table.foreach(HealBot_ConfigDefaults, function (key,val)
        if HealBot_Config[key] == nil then
            HealBot_Config[key]=val;
        end
    end);
    table.foreach(HealBot_GlobalsDefaults, function (key,val)
        if HealBot_Globals[key] == nil then
            HealBot_Globals[key]=val;
        end
    end);
    table.foreach(HealBot_Config_SkinsDefaults, function (key,val)
        if Healbot_Config_Skins[key] == nil then
            Healbot_Config_Skins[key]=val;
        end
    end);
    table.foreach(Healbot_Config_AuxDefaults, function (key,val)
        if Healbot_Config_Aux[key] == nil then
            Healbot_Config_Aux[key]=val;
        end
    end);
    table.foreach(HealBot_Config_SpellsDefaults, function (key,val)
        if HealBot_Config_Spells[key] == nil then
            HealBot_Config_Spells[key]=val;
        end
    end);
    table.foreach(HealBot_Config_BuffsDefaults, function (key,val)
        if HealBot_Config_Buffs[key] == nil then
            HealBot_Config_Buffs[key]=val;
        end
    end);
    table.foreach(HealBot_Config_CuresDefaults, function (key,val)
        if HealBot_Config_Cures[key] == nil then
            HealBot_Config_Cures[key]=val;
        end
    end);
    
    if not HealBot_Globals.PrivLastSeenDate then HealBot_Globals.PrivLastSeenDate=GetServerTime() end
    if not Healbot_Config_Skins.Current_Skin then Healbot_Config_Skins.Current_Skin=HEALBOT_SKINS_STD end
    if type(Healbot_Config_Skins.Current_Skin) == "number" then Healbot_Config_Skins.Current_Skin="s"..Healbot_Config_Skins.Current_Skin end
    C_ChatInfo.RegisterAddonMessagePrefix(HEALBOT_HEALBOT)
    if HealBot_Config.MyFriend then
        HealBot_Config.PrivFocus=HealBot_Config.MyFriend
        HealBot_Config.MyFriend=nil
    end
    HealBot_Update_Skins()
    HealBot_Action_SetCustomClassCols(2)
    HealBot_Lang_InitVars()
    HealBot_Timers_Lang()
    HealBot_Options_InitVars()
    HealBot_Panel_Init()
    for x=1,3 do
        for z=0,5 do
            HealBot_luVars["FPS"][x][z]=HealBot_Globals.FPS
        end
    end
    HealBot_luVars["FPS"][0]=HealBot_Globals.FPS
    if HealBot_Config.LastLoadout == 0 then HealBot_Action_UpdateLoadoutId() end
    HealBot_Media_Register()
    HealBot_Action_InitFrames()
    HealBot_ActionIcons_InitFrames()
    HealBot_SetPlayerData()
    HealBot_Include_Skin(HEALBOT_SKINS_STD, true)
    if HealBot_Globals.FirstLoad then
        HealBot_Include_Skin(HEALBOT_SORTBY_GROUP, true)
        HealBot_Include_Skin(HEALBOT_OPTIONS_RAID25, true)
        HealBot_Include_Skin(HEALBOT_OPTIONS_RAID40, true)
    end
    HealBot_Timers_Set("LAST","SetAutoClose",true,true)
    HealBot_Timers_Set("LAST","LoadTips",true)
    HealBot_Options_SetOverrideGlowSize()
    HealBot_Action_SetCustomClassCols(HealBot_Globals.OverrideColours["USECLASS"])
    HealBot_Data["PGUID"]=UnitGUID("player") or "x"
    hbv_SetClass()
    HealBot_Options_setLists()
    HealBot_customTempUserName=HealBot_Options_copyTable(HealBot_Globals.PermUserName)
    HealBot_setTooltipUpdateInterval()
    HealBot_Panel_InitOptBars()
    HealBot_luVars["CPUProfilerOn"]=GetCVarBool("scriptProfile")
    HealBot_Panel_SethbTopRole(HealBot_Globals.TopRole)
    HealBot_Options_IgnoreDebuffsDuration_setAura()
    HealBot_Timers_ToggleBlizzardFrames()
    HealBot_Text_sethbNumberFormat()
    HealBot_Text_sethbAggroNumberFormat()
    HealBot_Options_SetFrames()
    HealBot_Init_ClassicSpecs()
    HealBot_SetToolTip(HealBot_ScanTooltip)
    local g
    for x=1,8 do
        HealBot_ScanTooltip:AddDoubleLine(" "," ",1,1,1,1,1,1)
        g=_G["HealBot_ScanTooltipTextLeft"..x]
        g:SetFont(HealBot_Supplied_Fonts[15].file, 12)
        g=_G["HealBot_ScanTooltipTextRight"..x]
        g:SetFont(HealBot_Supplied_Fonts[15].file, 12)
    end
    HealBot_Config.LastAutoSkinChangeTime=0
    HealBot_Load()
    HealBot_luVars["VarsLoaded"]=true
end

function HealBot_ResetOnSpecChange()
      --HealBot_setCall("HealBot_ResetOnSpecChange")
    if HealBot_Config.CurrentLoadout~=HealBot_Config.LastLoadout or HealBot_Config.CurrentSpec~=HealBot_luVars["CurrentSpec"] then
        HealBot_Config.CurrentSpec=HealBot_luVars["CurrentSpec"] or 1
        HealBot_Config.CurrentLoadout=HealBot_Config.LastLoadout
        HealBot_Timers_Set("PLAYER","LoadProfile")
        HealBot_Timers_Set("PLAYER","CheckSpellsValid",true)
        HealBot_Timers_Set("OOC","PartyUpdateCheckSkin",true)
        HealBot_Timers_Set("OOC","ActionIconsSpecChange",true)
    end
    HealBot_Data["PLEVEL"]=UnitLevel("player")
    HealBot_Timers_InitSpells()
    HealBot_Timers_Set("INIT","SpellsResetTabs")
    HealBot_Timers_Set("AURA","ConfigClassHoT")
    HealBot_Timers_AuraReset()
end

function HealBot_GetTalentInfo(button)
      --HealBot_setCall("HealBot_GetTalentInfo", button)
    local i,s=nil,nil
    if button.player or (button.isplayer and UnitExists(button.unit) and UnitGUID(button.unit) == button.guid and CanInspect(button.unit)) and not HealBot_Data["UILOCK"] then
        if HEALBOT_GAME_VERSION>5 then
            if button.player then
                i=GetSpecialization()
                if i then
                    _, s=GetSpecializationInfo(i,false,false)
                end
            elseif button.isplayer and button.status.range>-1 then
                i=GetInspectSpecialization(button.unit)
                if i then
                    _, s=GetSpecializationInfoByID(i)
                end
            end
        else
            local tCount, mCount, isInspect, canInspect= 0, 0, false, false
            if button.player then
                canInspect=true
            elseif button.isplayer and HealBot_Range_InteractDistance(button.unit, HealBot_luVars["ClassicInteractDistance"]) then
                canInspect=true
                isInspect=true
            end
            if canInspect then
                local group=GetActiveTalentGroup(isInspect)
                for tab=1, GetNumTalentTabs(isInspect) do
                    tCount=select(5, GetTalentTabInfo(tab,isInspect,nil,group))
                    if type(tCount)~="number" then tCount=0 end
                    if tCount > mCount then
                        i=tab
                        mCount=tCount
                    end
                end
                if i then
                    s=HealBot_Init_retSpec(button.text.classtrim,i)
                end
            end
        end
    end
    if button.player then
        if i then
            HealBot_Action_UpdateLoadoutId()
            if HealBot_Config.CurrentLoadout~=HealBot_Config.LastLoadout or HealBot_Config.CurrentSpec~=i or HealBot_Data["PLEVEL"]~=UnitLevel("player") then
                HealBot_luVars["CurrentSpec"]=i
                HealBot_Timers_Set("PLAYER","SpecUpdate",true)
            end
            if s and HealBot_Config.Spec ~= s then
                HealBot_Config.LastAutoSkinChangeTime=0
                HealBot_Config.Spec=s
                HealBot_Timers_Set("OOC","DisableCheck")
            end
        end
    else
        if i and HealBot_Globals.ClearInspect then ClearInspectPlayer() end
        HealBot_luVars["TalentQueryEnd"]=HealBot_TimeNow
    end
    if s then
        button.specupdate=0
        if button.spec~=" "..s.." " then
            button.spec=" "..s.." "
            if HealBot_Panel_RaidUnitButtonCheck(button.guid) then
                HealBot_Action_setGuidSpec(button, s)
                HealBot_Comms_SendInstantAddonMsg("U:"..button.guid.."~"..s)
            end
            HealBot_Action_setButtonManaBarCol(button)
            if button.mouseover and HealBot_Data["TIPBUTTON"] then HealBot_setTooltipUpdateNow() end
            HealBot_UnitMana(button)
        end
    end
end

function HealBot_Timer_FramesRefresh()
      --HealBot_setCall("HealBot_Timer_FramesRefresh")
    if not HealBot_luVars["ProcessRefresh"] and not HealBot_Data["UILOCK"] then
        HealBot_luVars["ProcessRefresh"]=true
        HealBot_luVars["checkEnemyPlayerTargets"]=true
        HealBot_Timers_Set("OOC","ProcessRefreshTypes")
    elseif HealBot_Data["UILOCK"] then
        HealBot_Timers_Set("OOC","FramesRefresh",true)
    end
end

function HealBot_Timer_TogglePartyFrames()
      --HealBot_setCall("HealBot_Timer_TogglePartyFrames")
    if not HealBot_luVars["UILOCK"] then
        if HealBot_luVars["HIDEPARTYF"] and HealBot_Config.DisabledNow == 0 then
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
        HealBot_Timers_Set("OOC","TogglePartyFrames")
    end
end

function HealBot_Timer_ToggleFocusFrame()
      --HealBot_setCall("HealBot_Timer_ToggleFocusFrame")
    if not HealBot_luVars["UILOCK"] then
        if HealBot_luVars["HIDEFOCUSF"] and HealBot_Config.DisabledNow == 0 then
            HealBot_trackHiddenFrames["FOCUS"]=true
            HealBot_Options_DisableEnableFocusFrame(false)
        elseif HealBot_trackHiddenFrames["FOCUS"] then
            HealBot_trackHiddenFrames["FOCUS"]=false
            HealBot_Options_DisableEnableFocusFrame(true)
        end
    else
        HealBot_Timers_Set("OOC","ToggleFocusFrame")
    end
end

function HealBot_Timer_ToggleMiniBossFrames()
      --HealBot_setCall("HealBot_Timer_ToggleMiniBossFrames")
    if not HealBot_luVars["UILOCK"] then
        if HealBot_luVars["HIDEBOSSF"] and HealBot_Config.DisabledNow == 0 then
            HealBot_trackHiddenFrames["MINIBOSS"]=true
            HealBot_Options_DisableEnableMiniBossFrame(false)
        elseif HealBot_trackHiddenFrames["MINIBOSS"] then
            HealBot_trackHiddenFrames["MINIBOSS"]=false
            HealBot_Options_DisableEnableMiniBossFrame(true)
        end
    else
        HealBot_Timers_Set("OOC","ToggleMiniBossFrames")
    end
end

function HealBot_Timer_ToggleRaidFrames()
      --HealBot_setCall("HealBot_Timer_ToggleRaidFrames")
    if not HealBot_luVars["UILOCK"] then
        if HealBot_luVars["HIDERAIDF"] and HealBot_Config.DisabledNow == 0 then
            HealBot_trackHiddenFrames["RAID"]=true
            HealBot_Options_DisableEnableRaidFrame(false)
        elseif HealBot_trackHiddenFrames["RAID"] then
            HealBot_trackHiddenFrames["RAID"]=false
            HealBot_Options_DisableEnableRaidFrame(true)
        end
    else
        HealBot_Timers_Set("OOC","ToggleRaidFrames")
    end
end

function HealBot_CheckVersions()
      --HealBot_setCall("HealBot_CheckVersions")
    if not HealBot_luVars["GetVersions"] then HealBot_luVars["GetVersions"]=HealBot_TimeNow+15 end
    HealBot_SendVersion()
    if HealBot_luVars["DoSendGuildVersion"] then
        HealBot_SendGuildVersion()
        HealBot_luVars["DoSendGuildVersion"]=false
    end
end

function HealBot_SendVersion()
      --HealBot_setCall("HealBot_SendVersion")
    if not HealBot_luVars["SendVersion"] then HealBot_luVars["SendVersion"]=HealBot_TimeNow+10 end
end

function HealBot_SendGuildVersion()
      --HealBot_setCall("HealBot_SendGuildVersion")
    if not HealBot_luVars["SendGuildVersion"] then HealBot_luVars["SendGuildVersion"]=HealBot_TimeNow+10 end
end

function HealBot_ZoneType()
      --HealBot_setCall("HealBot_ZoneType")
    local inInst,inType=IsInInstance()
    if inInst == nil then inInst=false end
    if not inType then inType="None" end
    return inInst,inType
end

function HealBot_Timer_ZoneUpdate()
      --HealBot_setCall("HealBot_Timer_ZoneUpdate")
    local inInst,inType=HealBot_ZoneType()
    HealBot_Comms_SendTo(inInst,inType)
    if HealBot_luVars["InInstance"]~=inInst then
        HealBot_luVars["InInstance"]=inInst
        HealBot_Timers_Set("LAST","CheckVersions",true,true)
        if HealBot_Config_Buffs.ExtraBuffsOnlyInInstance then
            HealBot_Timers_Set("LAST","InitItemsData")
        end
        HealBot_ActionIcons_InstanceState(inInst)
        if HealBot_luVars["auraWatchNotifyZone"] then HealBot_Plugin_AuraWatch_ValidateZone(inInst) end
    end
    if HEALBOT_GAME_VERSION<9 then
        HealBot_Aura_SetBossHealth(inInst)
    end

    local mapAreaID=C_Map.GetBestMapForUnit("player")
    local mapName=HEALBOT_WORD_OUTSIDE
    if mapAreaID and mapAreaID>0 then
        mapName=C_Map.GetMapInfo(mapAreaID).name or mapName
        HealBot_luVars["mapAreaID"]=mapAreaID
    elseif inType and inType == "arena" then
        mapName="Arena"
    end
    if HealBot_luVars["mapName"]~=mapName then
        HealBot_luVars["mapName"]=mapName
        HealBot_Aura_setLuVars("mapName", mapName)
        HealBot_Options_setLuVars("mapName", mapName)
        HealBot_Options_SetEnableDisableCDBtn()
        HealBot_Options_SetEnableDisableBuffBtn()
        HealBot_Timers_Set("OOC","PartyUpdateCheckSkin")
    end
    HealBot_Panel_setLuVars("MAPID", mapAreaID)
    HealBot_Timers_Set("PLAYER","PlayerCheck")
end

function HealBot_Timer_EmoteOOM()
      --HealBot_setCall("HealBot_Timer_EmoteOOM")
    if HealBot_luVars["NoSpamOOM"]<HealBot_TimeNow and
      (((UnitPower("player", 0)/UnitPowerMax("player", 0))*100) < HealBot_luVars["EOCOOMV"]) then
        HealBot_luVars["NoSpamOOM"]=HealBot_TimeNow+15
        DoEmote(HEALBOT_EMOTE_OOM)
    end
end

local hbCombatState=false
function HealBot_UnitAffectingCombat(button)
      --HealBot_setCall("HealBot_UnitAffectingCombat", button)
    if (button.isplayer or button.isgroupraid) and hbv_Skins_GetFrameBoolean("Icons", "SHOWCOMBAT", button.frame) then
        hbCombatState=UnitAffectingCombat(button.unit)
    else
        hbCombatState=false
    end
    if button.status.incombat~=hbCombatState then
        button.status.incombat=hbCombatState
        HealBot_Aura_UpdateCombat(button)
    end
end

function HealBot_ValidLivingEnemy(pUnit, eUnit)
      --HealBot_setCall("HealBot_ValidLivingEnemy", nil, nil, pUnit)
    if UnitExists(pUnit) and UnitExists(eUnit) and not UnitIsFriend("player", eUnit) and UnitHealthMax(eUnit)>99 and
       UnitHealth(eUnit)>(UnitHealthMax(eUnit)/20) then
        return true
    end
    return false
end

function HealBot_Clear_HealthDropAuxBar(button)
      --HealBot_setCall("HealBot_Clear_HealthDropAuxBar", button)
    if button.status.lasthealthdrop<HealBot_TimeNow then
        HealBot_Aux_ClearHealthDropBar(button)
        if HealBot_AuxAssigns["NameOverlayHealthDrop"][button.frame] then
            HealBot_Aux_UpdateNameOverLay(button, 2, false)
        end
        if HealBot_AuxAssigns["HealthOverlayHealthDrop"][button.frame] then
            HealBot_Aux_UpdateHealthOverLay(button, 2, false)
        end
    else
        C_Timer.After((button.status.lasthealthdrop-HealBot_TimeNow)+0.05, function() HealBot_Clear_HealthDropAuxBar(button) end)
    end
end

function HealBot_Update_HealthDropAuxBar(button)
      --HealBot_setCall("HealBot_Update_HealthDropAuxBar", button)
    HealBot_luVars["HealthDropBarSetCTimerSet"]=false
    if HealBot_AuxAssigns["HealthDrop"][button.frame] then
        if button.status.lasthealthdrop<HealBot_TimeNow then
            HealBot_Aux_UpdateHealthDropBar(button)
            HealBot_luVars["HealthDropBarSetCTimerSet"]=true
        end
    end
    if HealBot_AuxAssigns["NameOverlayHealthDrop"][button.frame] then
        if button.status.lasthealthdrop<HealBot_TimeNow then
            HealBot_Aux_UpdateNameOverLay(button, 2, true)
            HealBot_luVars["HealthDropBarSetCTimerSet"]=true
        end
    end
    if HealBot_AuxAssigns["HealthOverlayHealthDrop"][button.frame] then
        if button.status.lasthealthdrop<HealBot_TimeNow then
            HealBot_Aux_UpdateHealthOverLay(button, 2, true)
            HealBot_luVars["HealthDropBarSetCTimerSet"]=true
        end
    end

    if HealBot_luVars["HealthDropBarSetCTimerSet"] then
        C_Timer.After(0.75, function() HealBot_Clear_HealthDropAuxBar(button) end)
    end
    button.status.lasthealthdrop=HealBot_TimeNow+0.7
end

function HealBot_EnClass(unit)
      --HealBot_setCall("HealBot_EnClass", nil, nil, unit)
  local playerClass, enClass=UnitClass(unit);
  return enClass;
end

local hbHealthWatch={}
local hbAuraWatchHealth={}
local hbActionHealthWatch={}
local hbHealthExtra={}
function HealBot_HealthExtra(guid, state)
      --HealBot_setCall("HealBot_HealthExtra", nil, guid)
    if state then
        hbHealthExtra[guid]=true
    elseif not hbAuraWatchHealth[guid] and not hbActionHealthWatch[guid] and not hbHealthWatch[guid] then
        hbHealthExtra[guid]=nil
    end
end

function HealBot_HealthWatch(guid, state)
      --HealBot_setCall("HealBot_HealthWatch", nil, guid)
    if state then
        hbHealthWatch[guid]=true
    else
        hbHealthWatch[guid]=nil
    end
    HealBot_HealthExtra(guid, state)
end

function HealBot_AuraWatchHealth(guid, state)
      --HealBot_setCall("HealBot_AuraWatchHealth")
    if state then
        hbAuraWatchHealth[guid]=true
    else
        hbAuraWatchHealth[guid]=nil
    end
    HealBot_HealthExtra(guid, state)
end

function HealBot_ActionWatchHealth(guid, state)
      --HealBot_setCall("HealBot_ActionWatchHealth", nil, guid)
    if state then
        hbActionHealthWatch[guid]=true
    else
        hbActionHealthWatch[guid]=nil
    end
    HealBot_HealthExtra(guid, state)
end

function HealBot_HealthWatchClear()
      --HealBot_setCall("HealBot_HealthWatchClear")
    hbHealthWatch={}
end

function HealBot_AuraWatchClear()
      --HealBot_setCall("HealBot_AuraWatchClear")
    hbAuraWatchHealth={}
end

local HealBot_Health80={
  ["DRUID"]=15000,
  ["MAGE"]=14000,
  ["HUNTER"]=15000,
  ["PALADIN"]=24000,
  ["PRIEST"]=14000,
  ["ROGUE"]=15000,
  ["SHAMAN"]=14000,
  ["WARLOCK"]=14000,
  ["WARRIOR"]=25000,
  ["DEATHKNIGHT"]=25000,
}
local health,healthMax=0,0
function HealBot_UnitHealth(button, force)
      --HealBot_setCall("HealBot_UnitHealth", button)
    button.health.updhlth=false
    --button.health.nextcheck=HealBot_TimeNow+HealBot_luVars["healthCheckInterval"]
    if button.status.current<HealBot_Unit_Status["DC"] then
        if button.status.isdead then
            if HealBot_IsUnitReallyDead(button) then
                healthMax=button.health.max
                health=0
            elseif UnitIsFeignDeath(button.unit) then
                health=button.health.current
                healthMax=UnitHealthMax(button.unit)
            else
                health,healthMax=UnitHealth(button.unit),UnitHealthMax(button.unit)
            end
        else
            if HealBot_UnitInVehicle[button.unit] and UnitExists(HealBot_UnitInVehicle[button.unit]) then
                health,healthMax=UnitHealth(HealBot_UnitInVehicle[button.unit]),UnitHealthMax(HealBot_UnitInVehicle[button.unit])
            elseif UnitIsFeignDeath(button.unit) then
                health=button.health.current
                healthMax=UnitHealthMax(button.unit)
            else
                health,healthMax=UnitHealth(button.unit),UnitHealthMax(button.unit)
            end
            if healthMax == 100 and (button.unit == "target" or button.unit == "focus" or not button.isplayer) then
                local class=HealBot_EnClass(button.unit)
                if HealBot_Health80[class] and button.level>0 then
                    if button.level<75 then
                        healthMax=math.floor((HealBot_Health80[class]/150)*(button.level+(button.level/10)))
                    else
                        healthMax=math.floor((HealBot_Health80[class]/80)*(button.level+0.5))
                    end
                    health=floor((healthMax/100)*health)
                end
            end
        end
        if healthMax == 0 then healthMax=1 end
        if health>healthMax then healthMax=health end
        if health<0 then health=0 end
        if (health~=button.health.current) or (healthMax~=button.health.max) then
            if HealBot_luVars["pluginTimeToDie"] and button.status.plugin then
                HealBot_Plugin_TimeToDie_UnitUpdate(button, health)
            end
            if button.isplayer and not HealBot_Data["UILOCK"] then
                if HealBot_luVars["regAggro"] and health<button.health.current then
                    HealBot_Events_UnitThreat(button)
                end
                if healthMax>(button.health.max*1.25) or healthMax<(button.health.max*0.75) then
                    if button.player then 
                        HealBot_Timers_Set("LAST", "SetInHealAbsorbMax")
                    elseif HEALBOT_GAME_VERSION<5 then 
                        HealBot_Events_SpecChange(button) 
                    end
                end
            end
            if button.frame<10 and health<button.health.current and HealBot_luVars["HealthDropPct"]<=(button.health.hpct-floor((health/healthMax)*1000))
               and not button.health.init and health>0 and (button.status.unittype<20 or HealBot_luVars["UILOCK"]) then
                button.health.hlthdrop=true
            else
                button.health.hlthdrop=false
            end
            button.health.current=health
            button.health.max=healthMax
            if not button.status.isdead then
                if health>1 then
                    HealBot_OverHeal(button)
                else
                    HealBot_Action_UpdateTheDeadButton(button)
                end
            elseif health>1 then
                HealBot_Action_UpdateTheDeadButton(button)
            end
            HealBot_Action_UpdateHealthButton(button, true)
            if hbHealthExtra[button.guid] then
                if hbHealthWatch[button.guid] then
                    HealBot_Plugin_HealthWatch_UnitUpdate(button)
                end
                if hbAuraWatchHealth[button.guid] then
                    HealBot_Plugin_AuraWatch_HealthUpdate(button)
                end
                if hbActionHealthWatch[button.guid] then
                    HealBot_ActionIcons_UpdateHealth(button.guid, floor(button.health.pct*100))
                end
            end
            if button.mouseover and HealBot_Data["TIPBUTTON"] then
                HealBot_setTooltipUpdateNow()
            end
            if button.health.hlthdrop then
                if HealBot_luVars["UseHealthDrop"] then
                    button.hazard.hpct=button.health.hpct+HealBot_luVars["HealthDropCancelPct"]
                    if button.hazard.hpct>800 then button.hazard.hpct=800 end
                    HealBot_Action_EnableBorderHazardType(button, button.health.mixcolr, button.health.mixcolg, button.health.mixcolb, "HLTHDROP")
                end
                HealBot_Update_HealthDropAuxBar(button)
            elseif button.hazard.hlthdrop and (button.health.current == 0 or button.health.hpct>button.hazard.hpct) then
                HealBot_Action_DisableBorderHazardType(button, "HLTHDROP")
            end
        end
    elseif button.health.current>0 or force then
        button.health.current=0
        button.status.alpha=0
        button.gref["Bar"]:SetValue(0)
        HealBot_HealsInUpdate(button)
        HealBot_AbsorbsUpdate(button)
        if HealBot_luVars["pluginTimeToDie"] and button.status.plugin then
            HealBot_Plugin_TimeToDie_UnitUpdate(button, 0)
        end
        HealBot_Text_setHealthText(button)
        --HealBot_Text_UpdateText(button)
    end
end

function HealBot_CurrentPlayerHealth(guid)
    aButton=HealBot_Panel_RaidButton(guid)
    if aButton then
        return aButton.health.current
    else
        return 0
    end
end

function HealBot_MaxPlayerHealth(guid)
    aButton=HealBot_Panel_RaidButton(guid)
    if aButton then
        return aButton.health.max
    else
        return 0
    end
end

function HealBot_retIsInVehicle(unit)
      --HealBot_setCall("HealBot_retIsInVehicle", nil, nil, unit)
    return HealBot_UnitInVehicle[unit]
end

function HealBot_UnitInVehicleUpdate(button)
      --HealBot_setCall("HealBot_UnitInVehicleUpdate", button)
    if HEALBOT_GAME_VERSION>2 then
        local vUnit=HealBot_UnitPet(button.unit)
        if vUnit and UnitHasVehicleUI(button.unit) then
            if not HealBot_UnitInVehicle[button.unit] then
                HealBot_VehicleChange(button, true)
            end
        elseif HealBot_UnitInVehicle[button.unit] then
            HealBot_VehicleChange(button, nil)
        end
    end
end

function HealBot_VehicleChange(button, enterVehicle)
      --HealBot_setCall("HealBot_VehicleChange", button)
    --HealBot_Text_setHealthText(button)
    local doRefresh=false
    if enterVehicle then
        local vUnit=HealBot_UnitPet(button.unit)
        if vUnit and UnitHasVehicleUI(button.unit) then
            _,xButton,pButton=HealBot_UnitID(vUnit)
            if not HealBot_UnitInVehicle[unit] or HealBot_UnitInVehicle[unit]~=vUnit then
                HealBot_UnitInVehicle[button.unit]=vUnit
                doRefresh=true
            end
            if xButton then
                HealBot_UnitHealth(xButton)
            end
            if pButton then
                HealBot_UnitHealth(pButton)
            end
        end
    elseif HealBot_UnitInVehicle[button.unit] then
        HealBot_UnitInVehicle[button.unit]=nil
        doRefresh=true
    end
    if doRefresh then
        HealBot_UnitHealth(button)
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][9]["STATE"] then
            HealBot_Timers_Set("OOC","RefreshPartyNextRecalcVehicle")
        end
        if UnitIsUnit(button.unit,"player") then HealBot_PlayerCheck() end
    end
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
      --HealBot_setCall("HealBot_setRaidTargetChecked")
    for x=1,10 do
        hbRaidTargetIconsChecked[x][1]=hbv_Skins_GetFrameBoolean("RaidIcon", "STAR", x)
        hbRaidTargetIconsChecked[x][2]=hbv_Skins_GetFrameBoolean("RaidIcon", "CIRCLE", x)
        hbRaidTargetIconsChecked[x][3]=hbv_Skins_GetFrameBoolean("RaidIcon", "DIAMOND", x)
        hbRaidTargetIconsChecked[x][4]=hbv_Skins_GetFrameBoolean("RaidIcon", "TRIANGLE", x)
        hbRaidTargetIconsChecked[x][5]=hbv_Skins_GetFrameBoolean("RaidIcon", "MOON", x)
        hbRaidTargetIconsChecked[x][6]=hbv_Skins_GetFrameBoolean("RaidIcon", "SQUARE", x)
        hbRaidTargetIconsChecked[x][7]=hbv_Skins_GetFrameBoolean("RaidIcon", "CROSS", x)
        hbRaidTargetIconsChecked[x][8]=hbv_Skins_GetFrameBoolean("RaidIcon", "SKULL", x)
    end
end

function HealBot_RaidTargetUpdate(button)
      --HealBot_setCall("HealBot_RaidTargetUpdate", button)
    if button.status.current<HealBot_Unit_Status["RESERVED"] and hbv_Skins_GetFrameBoolean("RaidIcon", "SHOW", button.frame) then
        local x=GetRaidTargetIndex(button.unit)
        if x and hbRaidTargetIconsChecked[button.frame][x] then
            HealBot_Aura_RaidTargetUpdate(button, x)
        else
            HealBot_Aura_RaidTargetUpdate(button, 0)
        end
    else
        HealBot_Aura_RaidTargetUpdate(button, 0)
    end
end

function HealBot_getDefaultSkin(preCombat)
     --HealBot_setCall("HealBot_getDefaultSkin")
    local LastAutoSkinChangeType="None"
    local newSkinName=Healbot_Config_Skins.Current_Skin
    local skinFound=false
    if not HealBot_Options_checkSkinName(Healbot_Config_Skins.Current_Skin) then
        newSkinName=HEALBOT_SKINS_STD
    end
    if HEALBOT_GAME_VERSION>1 and HealBot_Config.SkinSpecEnabled[HealBot_Config.Spec] then
        for x in pairs (Healbot_Config_Skins.Skins) do
            if HealBot_Config.SkinSpecEnabled[HealBot_Config.Spec] == Healbot_Config_Skins.Skins[x] then
                LastAutoSkinChangeType=HealBot_Config.Spec
                newSkinName=Healbot_Config_Skins.Skins[x]
                skinFound=true
                break
            end
        end
    end
    if not skinFound and HealBot_Config.SkinZoneEnabled[HealBot_luVars["mapName"]] then
        for x in pairs (Healbot_Config_Skins.Skins) do
            if HealBot_Config.SkinZoneEnabled[HealBot_luVars["mapName"]] == Healbot_Config_Skins.Skins[x] then
                LastAutoSkinChangeType=HealBot_luVars["mapName"]
                newSkinName=Healbot_Config_Skins.Skins[x]
                skinFound=true
                break
            end
        end
    end
    if not skinFound then
        local _,z=IsInInstance()
        local numMembers=GetNumGroupMembers()
        local inRaid=IsInRaid()
        local inGroup=IsInGroup()
        if preCombat and HealBot_Globals.UseCrashProt and not HealBot_luVars["Loaded"] then
            local mName=HealBot_Panel_retLuVars("cpMacro")
            if mName then
                local mbody=GetMacroBody(mName) or "Solo:0"
                local cpCrashType, cpCrashNum=string.split(":", mbody)
                --cpCrashType, cpCrashNum="r","25"
                if cpCrashType~="Solo" then
                    numMembers=tonumber(cpCrashNum)
                    if numMembers>5 then
                        inRaid=true
                    else
                        inGroup=true
                    end
                    z="CrashProt"
                end
            end
        end
        if z == "arena" then
            for x in pairs (Healbot_Config_Skins.Skins) do
                if hbv_SkinDefault_GetData(Healbot_Config_Skins.Skins[x],HEALBOT_WORD_ARENA) then
                    LastAutoSkinChangeType="Arena"
                    newSkinName=Healbot_Config_Skins.Skins[x]
                    break
                end
            end
        elseif z == "pvp" then
            local y=GetRealZoneText()
            if numMembers>29 or y == HEALBOT_ZONE_AV or y == HEALBOT_ZONE_IC then
                for x in pairs (Healbot_Config_Skins.Skins) do
                    if hbv_SkinDefault_GetData(Healbot_Config_Skins.Skins[x],HEALBOT_WORD_BG40) then
                        LastAutoSkinChangeType="BG40"
                        newSkinName=Healbot_Config_Skins.Skins[x]
                        break
                    end
                end
            elseif numMembers>20 then
                for x in pairs (Healbot_Config_Skins.Skins) do
                    if hbv_SkinDefault_GetData(Healbot_Config_Skins.Skins[x],HEALBOT_WORD_BG25) then
                        LastAutoSkinChangeType="BG25"
                        newSkinName=Healbot_Config_Skins.Skins[x]
                        break
                    end
                end
            elseif numMembers>15 then
                for x in pairs (Healbot_Config_Skins.Skins) do
                    if hbv_SkinDefault_GetData(Healbot_Config_Skins.Skins[x],HEALBOT_WORD_BG20) then
                        LastAutoSkinChangeType="BG20"
                        newSkinName=Healbot_Config_Skins.Skins[x]
                        break
                    end
                end
            elseif numMembers>10 or y == HEALBOT_ZONE_SA or y == HEALBOT_ZONE_ES or y == HEALBOT_ZONE_AB then
                for x in pairs (Healbot_Config_Skins.Skins) do
                    if hbv_SkinDefault_GetData(Healbot_Config_Skins.Skins[x],HEALBOT_WORD_BG15) then
                        LastAutoSkinChangeType="BG15"
                        newSkinName=Healbot_Config_Skins.Skins[x]
                        break
                    end
                end
            else
                for x in pairs (Healbot_Config_Skins.Skins) do
                    if hbv_SkinDefault_GetData(Healbot_Config_Skins.Skins[x],HEALBOT_WORD_BG10) then
                        LastAutoSkinChangeType="BG10"
                        newSkinName=Healbot_Config_Skins.Skins[x]
                        break
                    end
                end
            end
        elseif inRaid then
            if numMembers>29 then
                for x in pairs (Healbot_Config_Skins.Skins) do
                    if hbv_SkinDefault_GetData(Healbot_Config_Skins.Skins[x],HEALBOT_OPTIONS_RAID40) then
                        LastAutoSkinChangeType="Raid40"
                        newSkinName=Healbot_Config_Skins.Skins[x]
                        break
                    end
                end
            elseif numMembers>20 then
                for x in pairs (Healbot_Config_Skins.Skins) do
                    if hbv_SkinDefault_GetData(Healbot_Config_Skins.Skins[x],HEALBOT_OPTIONS_RAID25) then
                        LastAutoSkinChangeType="Raid25"
                        newSkinName=Healbot_Config_Skins.Skins[x]
                        break
                    end
                end
            elseif numMembers>15 then
                for x in pairs (Healbot_Config_Skins.Skins) do
                    if hbv_SkinDefault_GetData(Healbot_Config_Skins.Skins[x],HEALBOT_OPTIONS_RAID20) then
                        LastAutoSkinChangeType="Raid20"
                        newSkinName=Healbot_Config_Skins.Skins[x]
                        break
                    end
                end
            elseif numMembers>10 then
                for x in pairs (Healbot_Config_Skins.Skins) do
                    if hbv_SkinDefault_GetData(Healbot_Config_Skins.Skins[x],HEALBOT_OPTIONS_RAID15) then
                        LastAutoSkinChangeType="Raid15"
                        newSkinName=Healbot_Config_Skins.Skins[x]
                        break
                    end
                end
            else
                for x in pairs (Healbot_Config_Skins.Skins) do
                    if hbv_SkinDefault_GetData(Healbot_Config_Skins.Skins[x],HEALBOT_OPTIONS_RAID10) then
                        LastAutoSkinChangeType="Raid10"
                        newSkinName=Healbot_Config_Skins.Skins[x]
                        break
                    end
                end
            end
        elseif inGroup and numMembers>0 then
            for x in pairs (Healbot_Config_Skins.Skins) do
                if hbv_SkinDefault_GetData(Healbot_Config_Skins.Skins[x],HEALBOT_WORD_PARTY) then
                    LastAutoSkinChangeType="Party"
                    newSkinName=Healbot_Config_Skins.Skins[x]
                    break
                end
            end
        elseif HEALBOT_GAME_VERSION>4 and C_PetBattles.IsInBattle() and HealBot_luVars["lastPetBattleEvent"]~="PET_BATTLE_OVER" then
            for x in pairs (Healbot_Config_Skins.Skins) do
                if hbv_SkinDefault_GetData(Healbot_Config_Skins.Skins[x],HEALBOT_WORD_PETBATTLE) then
                    LastAutoSkinChangeType="Pet"
                    newSkinName=Healbot_Config_Skins.Skins[x]
                    break
                end
            end
        else
            for x in pairs (Healbot_Config_Skins.Skins) do
                if hbv_SkinDefault_GetData(Healbot_Config_Skins.Skins[x],HEALBOT_WORD_SOLO) then
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
     --HealBot_setCall("HealBot_PartyUpdate_CheckSolo")
    local PrevSolo, PrevRaid=HealBot_luVars["IsSolo"],HealBot_luVars["IsRaid"]
    if IsInRaid() then
        HealBot_luVars["IsSolo"]=false
        HealBot_luVars["IsRaid"]=true
    elseif IsInGroup() then
        HealBot_luVars["IsSolo"]=false
        HealBot_luVars["IsRaid"]=false
    else
        HealBot_luVars["IsSolo"]=true
        HealBot_luVars["IsRaid"]=false
    end
    if PrevSolo~=HealBot_luVars["IsSolo"] or PrevRaid~=HealBot_luVars["IsRaid"] then
        local inInst,inType=HealBot_ZoneType()
        HealBot_Comms_SendTo(inInst,inType)
        if PrevSolo~=HealBot_luVars["IsSolo"] then
            HealBot_Timers_Set("OOC","DisableCheck")
            HealBot_ActionIcons_SoloState(HealBot_luVars["IsSolo"])
            if HealBot_luVars["auraWatchNotifySolo"] then HealBot_Plugin_AuraWatch_ValidateSolo(HealBot_luVars["IsSolo"]) end
        end
        if PrevRaid~=HealBot_luVars["IsRaid"] then
            HealBot_Timers_Set("SKINS","TextUpdateState")
        end
    end
end

function HealBot_PartyUpdate_CheckSkin(preCombat)
     --HealBot_setCall("HealBot_PartyUpdate_CheckSkin")
    local newSkinName,LastAutoSkinChangeType=HealBot_getDefaultSkin(preCombat)
    if preCombat or LastAutoSkinChangeType~=HealBot_Config.LastAutoSkinChangeType or HealBot_Config.LastAutoSkinChangeTime<HealBot_TimeNow then
        if preCombat or newSkinName~=Healbot_Config_Skins.Current_Skin then
            HealBot_Options_Set_Current_Skin(newSkinName, nil, nil, true)
        end
        HealBot_Config.LastAutoSkinChangeType=LastAutoSkinChangeType
    end
    HealBot_Timers_Set("LAST","PartyUpdateCheckSolo")
end

function HealBot_AfterCombatCleanup()
      --HealBot_setCall("HealBot_AfterCombatCleanup")
    if HealBot_luVars["RegenDisabled"] then
        HealBot_luVars["RegenDisabled"]=false
        for guid in pairs(HealBot_MobGUID) do
            HealBot_MobGUID[guid]=nil
        end
        for name in pairs(HealBot_MobNames) do
            HealBot_MobNames[name]=nil
        end
        for guid in pairs(HealBot_MobTarget) do
            HealBot_MobTarget[guid]=nil
        end
        if HealBot_luVars["healthFactor"]~=1 then
            HealBot_luVars["healthFactor"]=1
            HealBot_Timers_Set("LAST","UpdateAllHealth")
        end
        HealBot_Timers_Set("LAST","ResetUnitStatus")
        --HealBot_Timers_Set("SKINS","TextUpdateNames")
        HealBot_Timers_Set("LAST","EndAggro")
        if HealBot_luVars["CheckFramesOnCombat"] then HealBot_Timers_Set("LAST","CheckAutoClose") end
        HealBot_Timers_Set("LAST","CheckLowMana")
        HealBot_Timers_Set("PLAYER","PlayerTargetChanged")
        HealBot_Timers_Set("LAST","TargetFocusUpdate")
        HealBot_UnlockEnemyFrame()
        --HealBot_Timers_Set("LAST","IconNotInCombat")
        HealBot_Update_AllUnitBars(true)
        if HealBot_luVars["pluginThreat"] then HealBot_Plugin_Threat_TogglePanel() end
    elseif not HealBot_luVars["UpdateEnemyFrame"] then
        HealBot_UnlockEnemyFrame()
    end
end

function HealBot_UnlockEnemyFrame()
      --HealBot_setCall("HealBot_UnlockEnemyFrame")
    HealBot_luVars["UpdateEnemyFrame"]=true
    HealBot_Timers_Set("OOC","RefreshPartyNextRecalcEnemy")
end

function HealBot_Not_Fighting()
      --HealBot_setCall("HealBot_Not_Fighting")
    if not InCombatLockdown() then
        if HealBot_Data["UILOCK"] then
            HealBot_Data["UILOCK"]=false
            HealBot_luVars["CheckAuraFlags"]=true
            HealBot_luVars["HealBot_RunTimers"]=true
            HealBot_luVars["HealBot_RunDelayTimers"]=true
            HealBot_luVars["HealBot_RunLongDelayTimers"]=true
            HealBot_PlayerCheck()
            HealBot_Action_setAlertState()
            if HealBot_Globals.DisableToolTipInCombat and HealBot_Data["TIPBUTTON"] then
                HealBot_setTooltipUpdateNow()
            end
            if HealBot_Globals.FrameStrataIC ~= HealBot_Globals.FrameStrata then
                HealBot_Action_SetStrata()
            end
            if HealBot_luVars["EOCOOM"] and HealBot_Data["POWERTYPE"] == 0 then
                aButton=HealBot_Panel_RaidButton(HealBot_Data["PGUID"])
                if aButton and aButton.status.current<HealBot_Unit_Status["DEAD"] then
                    HealBot_Timers_Set("PLAYER","EmoteOOM")
                end
            end
            HealBot_luVars["TargetNeedReset"]=true
            HealBot_Timers_Set("LAST","AfterCombatCleanup")
            HealBot_Timers_Set("SKINS","OverShield")
            HealBot_ActionIcons_CombatState(false)
            if HealBot_luVars["pluginTimeToLive"] then HealBot_Plugin_TimeToLive_TogglePanel() end
            if HealBot_luVars["pluginAuraWatch"] then HealBot_Plugin_AuraWatch_CombatState(false) end
            if HealBot_luVars["pluginHealthWatch"] then HealBot_Plugin_HealthWatch_CombatState(false) end
            if HealBot_luVars["pluginManaWatch"] then HealBot_Plugin_ManaWatch_CombatState(false) end
        elseif not HealBot_luVars["UpdateEnemyFrame"] then
            HealBot_UnlockEnemyFrame()
        end
    elseif HealBot_Data["UILOCK"] then
        HealBot_luVars["DropCombat"]=1
    end
end

function HealBot_ReadyCheckClear(button)
      --HealBot_setCall("HealBot_ReadyCheckClear", button)
    button.icon.extra.readycheck=false
    HealBot_Aura_UpdateState(button)
end

function HealBot_SetUnitDisconnectChange(button, state)
      --HealBot_setCall("HealBot_SetUnitDisconnectChange", button)
    HealBot_Action_setState(button, state)
    HealBot_Text_setNameTag(button)
    button.status.slowupdate=true
    button.status.change=true
    button.status.update=true
end

function HealBot_SetUnitConnected(button, offlineStart)
      --HealBot_setCall("HealBot_SetUnitConnected", button)
    if offlineStart or button.status.current == HealBot_Unit_Status["DC"] then
        if offlineStart then
            HealBot_Action_SetGuidData(button, "OFFLINE", false)
        end
        HealBot_SetUnitDisconnectChange(button, HealBot_Unit_Status["CHECK"])
    end
end

function HealBot_SetUnitDisconnect(button)
      --HealBot_setCall("HealBot_SetUnitDisconnect", button)
    button.status.nextcheck=HealBot_TimeNow+HealBot_luVars["statusCheckInterval"]
    if button.status.current<HealBot_Unit_Status["RESERVED"] then
        local offlineStart=HealBot_Action_getGuidData(button.guid, "OFFLINE")
        if button.isplayer then
            if UnitIsConnected(button.unit) then
                HealBot_SetUnitConnected(button, offlineStart)
            elseif not offlineStart or button.status.current~=HealBot_Unit_Status["DC"] then
                if not offlineStart then
                    HealBot_Action_SetGuidData(button, "OFFLINE", HealBot_TimeNow)
                end
                HealBot_SetUnitDisconnectChange(button, HealBot_Unit_Status["DC"])
            end
        else
            HealBot_SetUnitConnected(button, offlineStart)
        end
    end
end

local hbActionFallWatch={}
local hbActionSwimWatch={}
function HealBot_ActionWatchFalling(guid, state)
      --HealBot_setCall("HealBot_ActionWatchFalling", nil, guid)
    if state then
        hbActionFallWatch[guid]=true
    else
        hbActionFallWatch[guid]=nil
    end
end

function HealBot_ActionWatchSwimming(guid, state)
      --HealBot_setCall("HealBot_ActionWatchSwimming", nil, guid)
    if state then
        hbActionSwimWatch[guid]=true
    else
        hbActionSwimWatch[guid]=nil
    end
end

function HealBot_CheckFalling(button, cTime)
      --HealBot_setCall("HealBot_CheckFalling", button)
    if button.status.fallstart and button.status.fallstart == cTime then
        button.status.fallstart=false
        button.status.falling=IsFalling(button.unit)
        HealBot_ActionIcons_UpdateFalling(button.guid, button.status.falling)
    end
end

function HealBot_UnitSlowUpdate(button)
      --HealBot_setCall("HealBot_UnitSlowUpdate", button, nil, nil, true)
    if HealBot_UnitExists(button) then
        if HealBot_CheckUnitRange(button) then
            HealBot_Range_UpdateUnit(button)
        end
        if button.status.slowupdate then
            if button.status.update then
                if button.status.change then
                    HealBot_UpdateUnitExists(button)
                else
                    HealBot_UpdateUnit(button)
                end
                if button.special.unit then HealBot_UnitUpdateAura(button) end
            elseif button.status.postchange then
                button.status.postchange=false
                HealBot_Events_UnitStatus(button)
                HealBot_UnitHealth(button)
                HealBot_HealsInUpdate(button)
                HealBot_AbsorbsUpdate(button)
                HealBot_Update_AuxRange(button)
                HealBot_Aura_Update_AllIcons(button)
                HealBot_Text_UpdateStateButton(button)
                HealBot_Text_UpdateNameButton(button)
                HealBot_Text_UpdateHealthButton(button)
                HealBot_ActionIcons_UnitChange(button.guid, button.unit)
                if HealBot_luVars["pluginAuraWatch"] then
                    HealBot_Plugin_AuraWatch_UpdateButton(button)
                end
                HealBot_Text_Update(button)
            elseif button.status.postupdate then
                button.status.postupdate=false
                HealBot_Events_UnitFlagsChanged(button)
                HealBot_ReadyCheckUnit(button)
                HealBot_RaidTargetUpdate(button)
                HealBot_Action_SetClassIconTexture(button)
                HealBot_Aux_CheckOverLays(button)
                HealBot_UnitInVehicleUpdate(button)
                if hbHealthWatch[button.guid] then
                    HealBot_Plugin_HealthWatch_UnitUpdate(button)
                end
                if hbManaWatch[button.guid] then
                    HealBot_Plugin_ManaWatch_UnitUpdate(button)
                end
                if hbActionHealthWatch[button.guid] then
                    HealBot_ActionIcons_UpdateHealth(button.guid, floor(button.health.pct*100))
                end
                if hbActionManaWatch[button.guid] then
                    HealBot_ActionIcons_UpdateMana(button.guid, button.mana.pct)
                end
                if hbActionFallWatch[button.guid] then
                    HealBot_ActionIcons_UpdateFalling(button.guid, button.status.falling)
                end
                if hbActionSwimWatch[button.guid] then
                    HealBot_ActionIcons_UpdateSwimming(button.guid, button.status.swimming)
                end
                if button.status.guidchange then
                    button.status.guidchange=false
                    HealBot_Events_UnitBuff(button)
                    HealBot_Events_UnitDebuff(button)
                    HealBot_GetUnitGuild(button)
                    HealBot_RefreshUnit(button)
                end
                if HealBot_Globals.PermPrivateData[button.guid] then
                    HealBot_Globals.PermPrivateData[button.guid]["CLASSTRIM"]=button.text.classtrim
                    HealBot_Globals.PermPrivateData[button.guid]["PFACTION"]=HealBot_Data["PFACTION"]
                    HealBot_Globals.PermPrivateData[button.guid]["TIME"]=GetServerTime()
                    HealBot_Timers_Set("LAST","PluginTweaksRefresh",true,true)
                end
                if HealBot_Config.PrivFocus == button.guid then
                    HealBot_Config.PrivData["CLASSTRIM"]=button.text.classtrim
                end
            else
                if button.specchange then
                    HealBot_SpecChange(button)
                end
                if button.aura.debuff.slowupd then
                    button.aura.debuff.slowupd=false
                    button.aura.debuff.update=true
                    HealBot_Events_UnitDebuff(button)
                end
                if button.aura.buff.slowupd then
                    button.aura.buff.slowupd=false
                    button.aura.buff.update=true
                    HealBot_Events_UnitBuff(button)
                end
                if button.health.slowupd then
                    button.health.slowupd=false
                    HealBot_UnitHealth(button)
                end
                if button.mana.slowupd then
                    button.mana.slowupd=false
                    HealBot_UnitMana(button)
                end
                if button.status.emergupd then
                    button.status.emergupd=false
                    HealBot_Action_EmergBarCheck(button, true)
                end
                if button.text.updatealpha then
                    HealBot_Update_TextPlayersAlphaButtonNow(button)
                end
                button.status.slowupdate=false
            end
        elseif not HealBot_Data["UILOCK"] and button.specupdate>0 and button.specupdate<HealBot_TimeNow and HealBot_luVars["TalentQueryEnd"]<HealBot_TimeNow then
            if button.frame<10 and button.level>9 and button.isplayer then
                if HEALBOT_GAME_VERSION<5 and not HealBot_Panel_RaidUnitButtonCheck(button.guid) then
                    button.specupdate=0
                elseif HealBot_Panel_AllUnitButtonCheck(button.guid) then
                    if button.player then
                        HealBot_GetTalentInfo(button)
                    else
                        HealBot_TalentQuery(button)
                    end
                else
                    button.specupdate=0
                end
            else
                button.specupdate=0
            end
        elseif button.frame<10 then
            if button.status.castend>0 and button.status.castend<(HealBot_TimeNow*1000) then
                HealBot_Aux_ClearCastBar(button)
            elseif hbActionSwimWatch[button.guid] and button.status.swimming~=IsSwimming(button.unit) then
                button.status.swimming=IsSwimming(button.unit)
                HealBot_ActionIcons_UpdateSwimming(button.guid, button.status.swimming)
            elseif button.health.initover then
                button.health.initover=false
                button.health.init=false
            elseif not HealBot_Data["UILOCK"] then
                if not HealBot_luVars["onTaxi"] and button.aura.buff.nextcheck and button.aura.buff.nextcheck<HealBot_TimeNow then
                    if button.aura.buff.resetcheck then
                        HealBot_Aura_ResetCheckBuffsTime(button)
                    else
                        button.aura.buff.nextcheck=false
                        HealBot_Events_UnitBuff(button)
                    end
                elseif button.isplayer or button.isgroupraid then
                    if button.aggro.status>0 then 
                        HealBot_Aggro_ClearUnitAggro(button)
                    elseif button.status.summons and C_IncomingSummon.IncomingSummonStatus(button.unit)~=1 then
                        HealBot_UnitSummonsUpdate(button, false)
                    elseif button.status.nextcheck<HealBot_TimeNow then
                        if (not UnitIsConnected(button.unit) or HealBot_Action_getGuidData(button.guid, "OFFLINE")) then
                            HealBot_Events_UnitStatus(button)
                        else
                            button.status.nextcheck=HealBot_TimeNow+HealBot_luVars["statusCheckInterval"]
                        end
                    --elseif button.health.current<2 and button.health.nextcheck<HealBot_TimeNow then
                    --    HealBot_UnitHealth(button)
                    --elseif button.mana.nextcheck<HealBot_TimeNow and button.mana.max == 0 then
                    --    HealBot_Events_UnitManaUpdate(button)
                    elseif button.status.incombat then
                        HealBot_UnitAffectingCombat(button)
                    end
                    if button.text.nameonly == "" then HealBot_Text_setNameText(button) end
                --elseif button.health.current<2 and button.health.nextcheck<HealBot_TimeNow then
                 --   HealBot_UnitHealth(button)
                end
            elseif button.aggro.nextcheck>0 and button.aggro.nextcheck<HealBot_TimeNow then
                HealBot_CalcThreat(button)
            elseif not button.status.incombat then
                HealBot_UnitAffectingCombat(button)
            end
            if button.mana.lowcheck then
                button.mana.lowcheck=false
                HealBot_Action_CheckUnitLowMana(button)
            end
        end
    end
end

function HealBot_PluginClearDown()
    if HealBot_luVars["pluginClearDown"]>0 then
        if HealBot_luVars["pluginClearDown"]<2 then
            HealBot_Timers_Set("SKINS","ActionIconsPlayerNames")
            HealBot_luVars["pluginClearDown"]=2
        elseif HealBot_luVars["pluginClearDown"]<3 then
            HealBot_Timers_Set("OOC","ActionIconsValidateTarget")
            HealBot_luVars["pluginClearDown"]=3
        elseif HealBot_luVars["pluginClearDown"]<4 and HealBot_luVars["pluginThreat"] then
            HealBot_Plugin_Threat_Cleardown()
            HealBot_luVars["pluginClearDown"]=4
        elseif HealBot_luVars["pluginClearDown"]<5 and HealBot_luVars["pluginAuraWatch"] then
            HealBot_Plugin_AuraWatch_Validate()
            HealBot_luVars["pluginClearDown"]=5
        elseif HealBot_luVars["pluginClearDown"]<6 and HealBot_luVars["pluginHealthWatch"] then
            HealBot_Plugin_HealthWatch_Validate()
            HealBot_luVars["pluginClearDown"]=6
        elseif HealBot_luVars["pluginClearDown"]<7 and HealBot_luVars["pluginManaWatch"] then
            HealBot_Plugin_ManaWatch_Validate()
            HealBot_luVars["pluginClearDown"]=7
        elseif HealBot_luVars["pluginClearDown"]<8 and HealBot_luVars["pluginTimeToLive"] then
            HealBot_Plugin_TimeToLive_Cleardown()
            HealBot_luVars["pluginClearDown"]=8
        elseif HealBot_luVars["pluginClearDown"]<9 and HealBot_luVars["pluginTimeToDie"] then
            HealBot_Plugin_TimeToDie_Cleardown()
            HealBot_luVars["pluginClearDown"]=9
        else
            HealBot_luVars["pluginClearDown"]=0
        end
        HealBot_Timers_Set("LAST","PluginClearDown", true)
    end
end

function HealBot_ResetOnEnemyChange()
    HealBot_Action_ResetEnemySkinAllButtons()
    HealBot_RefreshTypes[6]=true
    HealBot_RefreshTypes[3]=true
end

function HealBot_ProcessRefreshTypes()
      --HealBot_setCall("HealBot_ProcessRefreshTypes")
    if not InCombatLockdown() then
        if HealBot_luVars["checkEnemyPlayerTargets"] and HealBot_Panel_enemyPlayerTargets(false, 2) then
            HealBot_luVars["checkEnemyPlayerTargets"]=false
            HealBot_ResetOnEnemyChange()
        elseif HealBot_RefreshTypes[0] then
            HealBot_RecalcParty(0)
        elseif HealBot_RefreshTypes[1] then
            HealBot_RecalcParty(1)
        elseif HealBot_RefreshTypes[2] then
            HealBot_RecalcParty(2)
        elseif HealBot_RefreshTypes[3] then
            HealBot_RecalcParty(3)
        elseif HealBot_RefreshTypes[4] then
            HealBot_RecalcParty(4)
        elseif HealBot_RefreshTypes[6] then
            HealBot_RecalcParty(6)
            --if not HealBot_RefreshTypes[5] then
            --    HealBot_Timers_Set("OOC","RefreshPartyNextRecalcEnemy")
            --end
        elseif HealBot_RefreshTypes[5] then
            HealBot_RecalcParty(5)
        else
            if HealBot_luVars["resetOnNoTargetFrames"] and HealBot_luVars["NumEnemyUnitsInQueue"] == 0 then
                HealBot_luVars["resetOnNoTargetFrames"]=false
                HealBot_Panel_PlayersTargetsQueueResetSkins()
            end
            if HealBot_luVars["UpdateEnemy"] then
                HealBot_luVars["UpdateEnemy"]=false
                HealBot_Timers_Set("SKINS","TextUpdateEnemyNames",true)
                HealBot_Timers_Set("LAST","RefreshEnemyUnits",true)
            end
            if HealBot_luVars["ClearReset"] then
                HealBot_Timers_Set("SKINS","ClearReset")
            end
            HealBot_luVars["ProcessRefresh"]=false
            if HealBot_luVars["newSkin"] then
                HealBot_luVars["newSkin"]=false
                HealBot_Timers_Set("OOC","CheckHideUnusedFrames",true)
                HealBot_Timers_Set("OOC","ShowFramesOnSkinChange",true)
            end
            HealBot_Skins_setLuVars("AuxReset", false)
            HealBot_SetTargetBar()
            HealBot_PluginClearDown()
            if not HealBot_luVars["TestBarsOn"] then 
                HealBot_ResetRefreshLists()
            end
            return
        end
        HealBot_Timers_Set("OOC","ProcessRefreshTypes")
    else
        HealBot_Timers_Set("OOC","ProcessRefreshTypes",true)
    end
end

function HealBot_CheckPlayersTargets()
    HealBot_RecalcOnZeroEnemy()
    if HealBot_luVars["NumEnemyUnitsInQueue"] == 0 or HealBot_Panel_enemyPlayerTargets(false, 2) then
        HealBot_Panel_PlayersTargetsQueueResetSkins()
    end
end

function HealBot_RecalcOnZeroEnemy()
    if HealBot_luVars["NumEnemyUnitsInQueue"] == 0 then
        HealBot_nextRecalcParty(6)
    end
end

function HealBot_Update_Slow()
      --HealBot_setCall("HealBot_Update_Slow", nil, nil, nil, true)
    if HealBot_luVars["HealBot_RunLongDelayTimers"] and not HealBot_luVars["HealBot_RunTimers"] and not HealBot_luVars["HealBot_RunDelayTimers"] then
        HealBot_Timers_ProcLongDelay()
    end
    if not HealBot_Data["UILOCK"] then
        HealBot_luVars["slowSwitch"]=HealBot_luVars["slowSwitch"]+1
        if HealBot_luVars["slowSwitch"]<2 then
            if HealBot_luVars["GetVersions"] and HealBot_luVars["GetVersions"]<HealBot_TimeNow then
                HealBot_Timers_Set("LAST","GetVersion")
                HealBot_luVars["GetVersions"]=false
            elseif HealBot_luVars["SendVersion"] and HealBot_luVars["SendVersion"]<HealBot_TimeNow then
                HealBot_Timers_Set("LAST","SendVersion")
                HealBot_luVars["SendVersion"]=false
            elseif HealBot_luVars["SendGuildVersion"] and HealBot_luVars["SendGuildVersion"]<HealBot_TimeNow then
                HealBot_Timers_Set("LAST","SendGuildVersion")
                HealBot_luVars["SendGuildVersion"]=false
            end
        elseif HealBot_luVars["slowSwitch"]<3 then
            if HealBot_luVars["MaxCount"]>0 then
                HealBot_Debug_UpdateCalls()
                if HealBot_luVars["NextWarnCallsActive"]<HealBot_TimeNow then
                    HealBot_luVars["NextWarnCallsActive"]=HealBot_TimeNow+60
                end
            end
            if HealBot_DebugMsg[1] then
                HealBot_AddChat(HealBot_DebugMsg[1])
                table.remove(HealBot_DebugMsg,1)
            end
        else
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
                    HealBot_UpdateLocalUILock(false)
                    HealBot_luVars["AllOutOfCombatCheck"]=HealBot_TimeNow
                end
            else
                HealBot_luVars["DropCombat"]=1
            end
        else
            HealBot_luVars["DropCombat"]=0
            HealBot_luVars["AllOutOfCombatCheck"]=HealBot_TimeNow
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
    if HealBot_luVars["rcEnd"] and HealBot_luVars["rcEnd"]<HealBot_TimeNow then
        HealBot_luVars["rcEnd"]=false
        HealBot_Events_ReadyCheckClear(false)
    end
    if HealBot_luVars["UpdateAllAura"]>0 then
        HealBot_luVars["UpdateAllAura"]=HealBot_luVars["UpdateAllAura"]-1
        if HealBot_luVars["UpdateAllAura"] == 1 then
            HealBot_Aura_setLuVars("updateAll", false)
        end
    end
end

local HealBot_CDKnown={}
local hbStartTime, hbDuration, hbCDTime, hbCDEnd=0,0,0,0
function HealBot_SpellCooldown(spellName, spellId)
      --HealBot_setCall("HealBot_SpellCooldown")
    hbStartTime, hbDuration=HealBot_WoWAPI_SpellCooldown(spellName)
    hbCDEnd=(hbStartTime or 0)+(hbDuration or 0)
    hbCDTime=hbCDEnd-HealBot_TimeNow
    if hbCDTime>2 then
        if HealBot_luVars["pluginMyCooldowns"] then
            HealBot_Plugin_MyCooldowns_PlayerUpdate(spellName, spellId, hbStartTime, hbDuration)
        end
     --       HealBot_AddDebug("CD for spell "..spellName,"Cooldown",true)
     --       HealBot_AddDebug("Start="..(hbStartTime or "nil").."  hbCDEnd="..hbCDEnd.."  floor="..floor(hbCDEnd),"Cooldown",true)
        if HealBot_CDKnown[spellId] and HealBot_CDKnown[spellId]>0 then HealBot_AddDebug("CD for spell "..spellName.." found on HealBot_CDKnown[spellId] "..HealBot_CDKnown[spellId],"Cooldown",true) end
        if HealBot_Spell_IDs[spellId] and HealBot_Spell_IDs[spellId].cooldown>2 then HealBot_CDKnown[spellId]=0 end
    elseif HealBot_CDKnown[spellId] then
        if HealBot_CDKnown[spellId]<3 then
            HealBot_CDKnown[spellId]=HealBot_CDKnown[spellId]+1
            HealBot_Check_SpellCooldown(spellId, (0.25*HealBot_CDKnown[spellId]))
        else
            HealBot_AddDebug("CD for spell "..spellName.." NOT found on HealBot_CDKnown[spellId] "..HealBot_CDKnown[spellId],"Cooldown",true)
        end
    end
    if hbCDTime>0.4 then
        if HealBot_luVars["pluginAuraWatch"] then
            HealBot_Plugin_AuraWatch_SelfCD(spellName, hbCDTime, hbCDEnd)
        end
        HealBot_ActionIcons_SelfCD(spellName, hbCDTime, hbCDEnd)
    end
end

function HealBot_Check_SpellCooldown(spellId, delay)
      --HealBot_setCall("HealBot_Check_SpellCooldown")
    HealBot_CDQueue[spellId]=HealBot_TimeNow+delay
end

function HealBot_CheckUnitRange(button)
      --HealBot_setCall("HealBot_CheckUnitRange", button, nil, nil, true)
    if button.status.range<2 or not HealBot_Range_InteractDistance(button.unit, 1) then
        return true
    else
        return false
    end
end

local euName, euStartTime, euEndTime, euChan="",0,false,false
function HealBot_UnitUpdateAura(button)
      --HealBot_setCall("HealBot_Aura", button, nil, nil, true)
    if UnitIsFriend("player",button.unit) then
        if button.status.castend>0 then HealBot_Aux_ClearCastBar(button) end
    elseif HealBot_AuxAssigns["CastBar"][button.frame] then
        euChan=false
        euName, _, _, euStartTime, euEndTime=UnitCastingInfo(button.unit)
        if not euEndTime then
            euChan=true
            euName, _, _, euStartTime, euEndTime=UnitChannelInfo(button.unit)
        end
        if not euEndTime and button.status.castend>0 then
            HealBot_Aux_ClearCastBar(button)
        elseif euEndTime and floor(button.status.castend/1000)~=floor(euEndTime/1000) then
            button.status.castend=euEndTime
            HealBot_Aux_UpdateCastBar(button, euName, euStartTime, euEndTime, euChan)
        end
    elseif button.status.castend>0 then
        HealBot_Aux_ClearCastBar(button)
    end
    if button.special.auraupdate<HealBot_TimeNow then
        button.special.auraupdate=HealBot_TimeNow+0.25
        button.aura.debuff.update=true
        button.aura.buff.update=true
    end
    HealBot_Events_TimedUnitDebuff(button)
    HealBot_Events_TimedUnitBuff(button)
end

function HealBot_UnitUpdateButton(button)
      --HealBot_setCall("HealBot_UnitUpdateButton", button, nil, nil, true)
    if HealBot_UnitExists(button) then
        if button.status.isdead and button.status.deadnextcheck<HealBot_TimeNow then
            HealBot_Action_UpdateTheDeadButton(button)
       -- elseif button.status.refresh then
       --     button.status.refresh=false
       --     HealBot_Action_UpdateDebuffButton(button)
        else
            if button.special.unit then
                if button.awtarget then
                    button.awtarget=false
                    HealBot_Plugin_AuraWatch_TargetUpdate(button)
                elseif button.special.aura then
                    button.special.aura=false
                    HealBot_UnitUpdateAura(button)
                else
                    button.special.aura=true
                    HealBot_UnitHealth(button)
                    HealBot_HealsInUpdate(button)
                    HealBot_AbsorbsUpdate(button)
                    HealBot_UnitMana(button)
                end
            elseif button.event.aura then
                button.event.aura=false
                if button.event.buff then
                    HealBot_Events_TimedUnitBuff(button)
                end
                if button.event.debuff then
                    HealBot_Events_TimedUnitDebuff(button)
                end
            end
            if hbActionFallWatch[button.guid] and button.status.falling~=IsFalling(button.unit) then
                button.status.falling=IsFalling(button.unit)
                if not button.status.falling then
                    button.status.fallstart=false
                    HealBot_ActionIcons_UpdateFalling(button.guid, button.status.falling)
                elseif not button.status.fallstart then
                    local t=HealBot_TimeNow
                    button.status.fallstart=t
                    C_Timer.After(0.95, function() HealBot_CheckFalling(button, t) end)
                end
            elseif button.status.dirarrowshown>0 and button.status.dirarrowshown<HealBot_TimeNow then
                HealBot_Action_ShowDirectionArrow(button)
            end
        end
    end
end

function HealBot_UpdateAllEnemyAWTarget()
      --HealBot_setCall("HealBot_UpdateAllEnemyAWTarget")
    for _,xButton in pairs(HealBot_Enemy_Button) do
        xButton.awtarget=true
    end
    for xUnit,xButton in pairs(HealBot_UnitTarget_Button) do
        xButton.awtarget=true
    end
    for xUnit,xButton in pairs(HealBot_PrivateTarget_Button) do
        xButton.awtarget=true
    end
end

function HealBot_UpdateUnit_Buttons()
      --HealBot_setCall("HealBot_UpdateUnit_Buttons", nil, nil, nil, true)
    for u=1,HealBot_luVars["UpdateNumUnits"] do
        HealBot_luVars["UpdateID"]=HealBot_luVars["UpdateID"]+1
        if HealBot_Buttons[HealBot_UpdateQueue[HealBot_luVars["UpdateID"]]] then
            HealBot_UnitUpdateButton(HealBot_Buttons[HealBot_UpdateQueue[HealBot_luVars["UpdateID"]]])
        elseif HealBot_luVars["UpdateID"]>#HealBot_UpdateQueue then
            HealBot_luVars["UpdateID"]=0
        end
    end
    HealBot_luVars["slowUpdateID"]=HealBot_luVars["slowUpdateID"]+1
    if HealBot_Buttons[HealBot_UpdateQueue[HealBot_luVars["slowUpdateID"]]] then
        HealBot_UnitSlowUpdate(HealBot_Buttons[HealBot_UpdateQueue[HealBot_luVars["slowUpdateID"]]])
    elseif HealBot_luVars["slowUpdateID"]>#HealBot_UpdateQueue then
        HealBot_luVars["slowUpdateID"]=0
    end
    HealBot_UpdateTimers()
end

function HealBot_UpdateTimers(test)
      --HealBot_setCall("HealBot_UpdateTimers", nil, nil, nil, true)
    if HealBot_luVars["HealBot_RunTimers"] then
        HealBot_Timers_Run()
    end
end

function HealBot_UpdateLast()
    HealBot_luVars["fastSwitch"]=0
    HealBot_Update_Final()
end

HealBot_luVars["TestFramesRefresh"]=0
function HealBot_Update_Test()
      --HealBot_setCall("HealBot_Update_Test")
    if HealBot_luVars["TestFramesRefresh"]<HealBot_TimeNow then
        HealBot_luVars["TestFramesRefresh"]=HealBot_TimeNow+0.5
        --HealBot_Update_OutOfCombat()
        HealBot_Update_Final()
    else
        HealBot_UpdateTimers()
    end
end

function HealBot_Update_Final()
      --HealBot_setCall("HealBot_Update_Final", nil, nil, nil, true)
    if HealBot_luVars["MovingFrame"]>0 then
        HealBot_Action_CheckForStickyFrame(HealBot_luVars["MovingFrame"],false)
    elseif HealBot_luVars["NextTipUpdate"]<HealBot_TimeNow then
        HealBot_luVars["NextTipUpdate"]=HealBot_TimeNow+HealBot_luVars["TipUpdateFreq"]
        if HealBot_Data["TIPBUTTON"] then
            HealBot_Action_RefreshTooltip()
        elseif HealBot_Data["TIPICON"] then
            HealBot_Tooltip_UpdateIconTooltip()
        end
    end
    for spellId, qTime in pairs(HealBot_CDQueue) do
        if qTime<HealBot_TimeNow then
            scName=HealBot_WoWAPI_SpellName(spellId)
            if scName then
                HealBot_SpellCooldown(scName, spellId)
            end
            HealBot_CDQueue[spellId]=nil
        end
    end
    if not HealBot_luVars["ProcessRefresh"] then
        for guid,_ in pairs(HealBot_ClearGUIDQueue) do
            HealBot_ClearGUID(guid)
            HealBot_ClearGUIDQueue[guid]=nil
            break
        end
    end
    if HealBot_luVars["HealBot_RunDelayTimers"] and not HealBot_luVars["HealBot_RunTimers"] then
        HealBot_Timers_ProcDelayed()
    end
    HealBot_UpdateTimers()
end

local ouNoneInCombat=true
function HealBot_Update_OutOfCombat()
      --HealBot_setCall("HealBot_Update_OutOfCombat", nil, nil, nil, true)
    if HealBot_Config.DisabledNow == 1 and HealBot_Data["UILOCK"] then
        HealBot_Not_Fighting()
    elseif (HealBot_Data["UILOCK"] or not HealBot_luVars["UpdateEnemyFrame"]) and HealBot_luVars["AllOutOfCombatCheck"]<=HealBot_TimeNow then
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
            HealBot_luVars["AllOutOfCombatCheck"]=HealBot_TimeNow+1
        else
            HealBot_luVars["AllOutOfCombatCheck"]=HealBot_TimeNow+0.25
        end
    else
        HealBot_Set_FPS()
        HealBot_UpdateTimers()
    end
end

function HealBot_Update_Disabled()
    -- Do Nothing
end

local hbFastFuncs={}
for f=1,14 do
    hbFastFuncs[f]=HealBot_UpdateTimers
end
hbFastFuncs[15]=HealBot_UpdateLast
function HealBot_FastFuncs()
      --HealBot_setCall("HealBot_FastFuncs")
    if HealBot_luVars["UILOCK"] then
        HealBot_Options_CmdButtonsEnableDisable(false)
        hbFastFuncs[8]=hbFastFuncs[1]
    else
        HealBot_Options_CmdButtonsEnableDisable(true)
        hbFastFuncs[8]=HealBot_Update_OutOfCombat
    end
end

function HealBot_FastFuncsUpdate()
    if HealBot_Config.DisabledNow == 1 then
        for f=1,14 do
            hbFastFuncs[f]=HealBot_Update_Disabled
        end
    else
        for f=1,14 do
            hbFastFuncs[f]=HealBot_UpdateUnit_Buttons
        end
    end
    HealBot_FastFuncs()
end

function HealBot_UpdateLocalUILock(state)
      --HealBot_setCall("HealBot_UpdateLocalUILock")
    if HealBot_luVars["UILOCK"]~=state then
        HealBot_luVars["UILOCK"]=state
        HealBot_FastFuncs()
    end
end

function HealBot_Update_Fast()
      --HealBot_setCall("HealBot_Update_Fast", nil, nil, nil, true)
    HealBot_luVars["fastSwitch"]=HealBot_luVars["fastSwitch"]+1
    hbFastFuncs[HealBot_luVars["fastSwitch"]]()
end

HealBot_luVars["auraWatchIncEnemy"]=false
function HealBot_Add_RefreshList(id)
    if not HealBot_RefreshList[id] then
        HealBot_RefreshList[id]=true
        table.insert(HealBot_UpdateQueue,id)
        HealBot_Timers_Set("LAST","UpdateRefreshListFreq",true)
    end
end

function HealBot_Del_RefreshList(id)
    if HealBot_RefreshList[id] then
        for x=1,#HealBot_UpdateQueue do
            if HealBot_UpdateQueue[x] == id then
                table.remove(HealBot_UpdateQueue, x)
                break
            end
        end
        HealBot_RefreshList[id]=false
        HealBot_Timers_Set("LAST","UpdateRefreshListFreq",true)
    end
end

function HealBot_Update_RefreshListFreq()
    if HealBot_luVars["CPUProfilerOn"] then
        HealBot_luVars["UpdateNumUnits"]=ceil(#HealBot_UpdateQueue*0.05)
    else
        HealBot_luVars["UpdateNumUnits"]=ceil(#HealBot_UpdateQueue*HealBot_luVars["updUnitsAdj"])
    end
    HealBot_Debug_PerfUpdate("UpdateNumUnits", HealBot_luVars["UpdateNumUnits"].." ("..#HealBot_UpdateQueue..")")
    HealBot_Debug_PerfUpdate("updUnitsAdj", HealBot_luVars["updUnitsAdj"])
end

function HealBot_Update_RefreshList(button)
      --HealBot_setCall("HealBot_Update_RefreshList", button)
    if not hbPrevGUIDs[button.guid] then
        HealBot_luVars["pluginClearDown"]=1
        HealBot_Action_UpdateGlobalDimming(0)
        hbPrevGUIDs[button.guid]=true
    end
end

local hbFastCur=HealBot_Update_Fast
function HealBot_Update_ResetRefreshLists()
      --HealBot_setCall("HealBot_Update_ResetRefreshLists")
    HealBot_luVars["NumEnemyUnitsInQueue"]=0
    if HealBot_luVars["auraWatchIncEnemy"] then
        for guid,_ in pairs(hbPrevGUIDs) do
            if not HealBot_Panel_AllUnitButtonCheck(guid) then
                HealBot_luVars["pluginClearDown"]=1
                HealBot_Action_UpdateGlobalDimming(0)
                hbPrevGUIDs[guid]=nil
            end
        end
        for _,xButton in pairs(HealBot_Enemy_Button) do
            HealBot_Update_RefreshList(xButton)
            HealBot_luVars["NumEnemyUnitsInQueue"]=HealBot_luVars["NumEnemyUnitsInQueue"]+1
        end
        for _,xButton in pairs(HealBot_UnitTarget_Button) do
            HealBot_Update_RefreshList(xButton)
            HealBot_luVars["NumEnemyUnitsInQueue"]=HealBot_luVars["NumEnemyUnitsInQueue"]+1
        end
        for _,xButton in pairs(HealBot_PrivateTarget_Button) do
            HealBot_Update_RefreshList(xButton)
            HealBot_luVars["NumEnemyUnitsInQueue"]=HealBot_luVars["NumEnemyUnitsInQueue"]+1
        end
    else
        for guid,_ in pairs(hbPrevGUIDs) do
            if not HealBot_Panel_RaidUnitButtonCheck(guid) then
                HealBot_luVars["pluginClearDown"]=1
                hbPrevGUIDs[guid]=nil
            end
        end
        for _,xButton in pairs(HealBot_Enemy_Button) do
            HealBot_luVars["NumEnemyUnitsInQueue"]=HealBot_luVars["NumEnemyUnitsInQueue"]+1
        end
        for _,xButton in pairs(HealBot_UnitTarget_Button) do
            HealBot_luVars["NumEnemyUnitsInQueue"]=HealBot_luVars["NumEnemyUnitsInQueue"]+1
        end
        for _,xButton in pairs(HealBot_PrivateTarget_Button) do
            HealBot_luVars["NumEnemyUnitsInQueue"]=HealBot_luVars["NumEnemyUnitsInQueue"]+1
        end
    end
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Update_RefreshList(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Update_RefreshList(xButton)
    end
    HealBot_TestBarsState(HealBot_luVars["TestBarsOn"])
end

function HealBot_ResetRefreshLists()
    hbFastCur=HealBot_Update_ResetRefreshLists
end

function HealBot_TestBarsState(state)
      --HealBot_setCall("HealBot_TestBarsState")
    if state then
        hbFastCur=HealBot_Update_Test
    else
        hbFastCur=HealBot_Update_Fast
    end
    HealBot_luVars["TestBarsOn"]=state
end

function HealBot_OnUpdate()
      --HealBot_setCall("HealBot_OnUpdate", nil, nil, nil, true)
    HealBot_TimeNow=GetTime()
    if HealBot_luVars["UpdateSlowNext"]<HealBot_TimeNow then
        HealBot_luVars["UpdateSlowNext"]=HealBot_TimeNow+1
        HealBot_Update_Slow()
    else
        hbFastCur()
    end
end

function HealBot_Register_IncHeals(callback)
      --HealBot_setCall("HealBot_Register_IncHeals")
    if HEALBOT_GAME_VERSION<4 then
        if libCHC then 
            if not HealBot_luVars["LibCHCLoaded"] then
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
        elseif not callback then
            libCHC=HealBot_Libs_CHC()
            HealBot_Register_IncHeals(true)
        end
    end
end

function HealBot_Register_ReadyCheck()
      --HealBot_setCall("HealBot_Register_ReadyCheck")
    HealBot:RegisterEvent("READY_CHECK")
    HealBot:RegisterEvent("READY_CHECK_CONFIRM")
    HealBot:RegisterEvent("READY_CHECK_FINISHED")
end

function HealBot_UnRegister_ReadyCheck()
      --HealBot_setCall("HealBot_UnRegister_ReadyCheck")
    HealBot:UnregisterEvent("READY_CHECK")
    HealBot:UnregisterEvent("READY_CHECK_CONFIRM")
    HealBot:UnregisterEvent("READY_CHECK_FINISHED")
    HealBot_luVars["rcEnd"]=HealBot_TimeNow
end

function HealBot_UnitEnemyTargetUpdate(unit, guid)
    if HealBot_MobTarget[guid] and UnitExists(unit.."target") then
        aButton=HealBot_Panel_AllButton(UnitGUID(unit.."target"))
        if aButton and not aButton.special.unit and hbv_Skins_GetFrameVar("BarAggro", "TARGETED", aButton.frame) then
            if not hbv_Skins_GetFrameVar("BarAggro", "TARBOSSONLY", aButton.frame) or (HealBot_UnitClassification(unit) or "") == "Boss" then
                if HealBot_MobTarget[guid] ~= aButton.guid then
                    if HealBot_Panel_AllUnitButtonCheck(HealBot_MobTarget[guid]) then
                        HealBot_luVars["NoLongerTargets"]=true
                        for eGuid, pGuid in pairs(HealBot_MobTarget) do
                            if eGuid ~= guid and pGuid == HealBot_MobTarget[guid] then
                                HealBot_luVars["NoLongerTargets"]=false
                                break
                            end
                        end
                        if HealBot_luVars["NoLongerTargets"] then
                            HealBot_Aggro_PlayerNotTargeted(HealBot_MobTarget[guid])
                        end
                    end
                    HealBot_MobTarget[guid]=aButton.guid
                    HealBot_Aggro_PlayerTargeted(aButton, true, HealBot_MobGUID[guid])
                elseif aButton.aggro.status<3 then
                    HealBot_Aggro_PlayerTargeted(aButton, true, HealBot_MobGUID[guid])
                else
                    HealBot_Aggro_PlayerTargetedUpdate(aButton)
                end
            end
        end
    end
end

local ctEnemyUnit,ctTankUnit=false,""
local UnitThreatData={["status"]=0,["threatpct"]=0,["threatvalue"]=0,["threatname"]=false,["mobname"]=false,["mobGUID"]=false,["mobTargetGUID"]=false,["tmpstatus"]=0,["tmppct"]=0,["tmpvalue"]=0}
function HealBot_CalcThreat(button)
      --HealBot_setCall("HealBot_CalcThreat", button)
    UnitThreatData["threatpct"],UnitThreatData["status"],UnitThreatData["threatvalue"],ctEnemyUnit,UnitThreatData["threatname"]=0,0,0,false,""
    if button.status.current<HealBot_Unit_Status["DEAD"] and UnitIsFriend("player",button.unit) then
        ctTankUnit=HealBot_Panel_PlayerUnitGUID(HealBot_luVars["TankGUID1"])
        if HealBot_ValidLivingEnemy(button.unit, button.unit.."target") then
            ctEnemyUnit=button.unit.."target"
        elseif ctTankUnit and HealBot_ValidLivingEnemy(ctTankUnit, ctTankUnit.."target") then
            ctEnemyUnit=ctTankUnit.."target"
        elseif HealBot_ValidLivingEnemy(button.unit, "boss1") then
            ctEnemyUnit="boss1"
        elseif HealBot_ValidLivingEnemy(button.unit, "boss2") then
            ctEnemyUnit="boss2"
        elseif HealBot_ValidLivingEnemy("player", "target") then
            ctEnemyUnit="playertarget"
        end
        if ctEnemyUnit then
            _, UnitThreatData["tmpstatus"], UnitThreatData["tmppct"], _, UnitThreatData["tmpvalue"]=UnitDetailedThreatSituation(button.unit, ctEnemyUnit)
            UnitThreatData["threatpct"]=ceil(UnitThreatData["tmppct"] or 0)
            UnitThreatData["status"]=UnitThreatData["tmpstatus"] or 0
            UnitThreatData["threatvalue"]=UnitThreatData["tmpvalue"] or 0
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
                HealBot_MobTarget[UnitThreatData["mobGUID"]]=""
            end
            HealBot_UnitEnemyTargetUpdate(ctEnemyUnit, UnitThreatData["mobGUID"])
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
                UnitThreatData["threatname"]=button.aggro.mobname or ""
            end
        end
        if UnitThreatData["threatpct"]>=HealBot_Globals.aggro3pct or button.aggro.targeted>HealBot_TimeNow then
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
        if UnitThreatData["status"]<1 then
            button.aggro.nextcheck=0
            if button.aggro.status>0 then HealBot_Aggro_ClearUnitAggro(button) end
        else
            button.aggro.nextcheck=HealBot_TimeNow+HealBot_luVars["aggroCheckInterval"]
            if button.aggro.status~=UnitThreatData["status"] or UnitThreatData["threatpct"]~=button.aggro.threatpct or UnitThreatData["threatvalue"]~=button.aggro.threatvalue or UnitThreatData["threatname"]~=button.aggro.mobname then
                HealBot_Aggro_UpdateUnit(button,true,UnitThreatData)
            end
        end
        if not button.status.incombat then HealBot_UnitAffectingCombat(button) end
    else
        button.aggro.nextcheck=0
        if button.aggro.status>0 then HealBot_Aggro_ClearUnitAggro(button) end
    end
end

local hbNameOnly=false
function HealBot_UnitNameOnly(unitName)
      --HealBot_setCall("HealBot_UnitNameOnly")
    hbNameOnly=false
    if unitName then
        hbNameOnly=strtrim(string.match(unitName, "^[^-]*"))
    end
    return hbNameOnly
end

function HealBot_RefreshUnit(button)
      --HealBot_setCall("HealBot_RefreshUnit", button)
   -- button.status.refresh=true
    HealBot_Action_UpdateDebuffButton(button)
end

function HealBot_SpecChange(button)
          --HealBot_setCall("HealBot_SpecChange", button)
    button.specchange=false
    if button.player then
        HealBot_Timers_Set("PLAYER","TalentsChanged",true)
        HealBot_Events_SpellsChanged(1)
    else
        if HealBot_Panel_RaidUnitButtonCheck(button.guid) then HealBot_Action_SetGuidData(button, "TMPSPEC", " ") end
        HealBot_SpecUpdate(button, HealBot_TimeNow)
    end
end

function HealBot_SpecUpdate(button, upTime)
          --HealBot_setCall("HealBot_SpecUpdate", button)
    if button.specupdate<upTime and (button.player or HealBot_Globals.TalentInspect) then
        button.specupdate=upTime
    end
end

local hbCurrentTargetButton={}
function HealBot_SetTargetBar()
      --HealBot_setCall("HealBot_SetTargetBar")
    if UnitExists("target") then
        xButton, pButton=HealBot_Panel_AllUnitButton(UnitGUID("target"))
        if xButton and xButton.unit~="target" then
            if HealBot_luVars["AuxTargetInUse"] or HealBot_luVars["AuxTargetOverlayInUse"] then
                HealBot_Aux_UpdateTargetBar(xButton)
                if HealBot_AuxAssigns["NameOverlayTarget"][xButton.frame] then
                    HealBot_Aux_UpdateNameOverLay(xButton, 6, true)
                end
                if HealBot_AuxAssigns["HealthOverlayTarget"][xButton.frame] then
                    HealBot_Aux_UpdateHealthOverLay(xButton, 6, true)
                end
            end
            HealBot_Action_AdaptiveTargetEnable(xButton)
            hbCurrentTargetButton[xButton]=true
        end
        if pButton and pButton.unit~="target" then
            if HealBot_luVars["AuxTargetInUse"] or HealBot_luVars["AuxTargetOverlayInUse"] then
                HealBot_Aux_UpdateTargetBar(pButton)
                if HealBot_AuxAssigns["NameOverlayTarget"][pButton.frame] then
                    HealBot_Aux_UpdateNameOverLay(pButton, 6, true)
                end
                if HealBot_AuxAssigns["HealthOverlayTarget"][pButton.frame] then
                    HealBot_Aux_UpdateHealthOverLay(pButton, 6, true)
                end
            end
            HealBot_Action_AdaptiveTargetEnable(pButton)
            hbCurrentTargetButton[pButton]=true
        end
    else
        HealBot_ClearTargetBar()
    end
end

local function HealBot_AuxClearTargetBar(button)
      --HealBot_setCall("HealBot_AuxClearTargetBar", button)
    HealBot_Aux_ClearTargetBar(button)
    if HealBot_AuxAssigns["NameOverlayTarget"][button.frame] then
        HealBot_Aux_UpdateNameOverLay(button, 6, false)
    end
    if HealBot_AuxAssigns["HealthOverlayTarget"][button.frame] then
        HealBot_Aux_UpdateHealthOverLay(button, 6, false)
    end
end

function HealBot_ClearTargetBar()
      --HealBot_setCall("HealBot_ClearTargetBar")
    for xButton,_ in pairs(hbCurrentTargetButton) do
        if HealBot_luVars["AuxTargetInUse"] or HealBot_luVars["AuxTargetOverlayInUse"] then
            HealBot_AuxClearTargetBar(xButton)
        end
        HealBot_Action_AdaptiveTargetDisable(xButton)
        hbCurrentTargetButton[xButton]=nil
    end
end

function HealBot_UnitChanged(unit, HealGroupID, refreshID)
    if HealBot_Extra_Button[unit] then
        HealBot_UnitExists(HealBot_Extra_Button[unit])
    end
end

function HealBot_TargetChanged()
      --HealBot_setCall("HealBot_TargetChanged")
    if HealBot_luVars["UILOCK"] then
        HealBot_UnitChanged("target")
        HealBot_UnitChanged("targettarget")
    end
    HealBot_nextRecalcParty(3)
end

HealBot_luVars["AuxTargetInUse"]=false
function HealBot_PlayerTargetChanged()
      --HealBot_setCall("HealBot_PlayerTargetChanged")
    HealBot_ClearTargetBar()
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][11]["STATE"] then
        if HealBot_luVars["TargetNeedReset"] and not HealBot_luVars["UILOCK"] then
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
        end
    end
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][11]["STATE"] or Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][12]["STATE"] then
        HealBot_TargetChanged()
    end
    if hbv_Skins_GetBoolean("Enemy", "INCSELF") and hbv_Skins_GetVar("Enemy", "EXISTSHOWPTAR")<3 then
        if hbv_Skins_GetVar("Enemy", "SELFUSEFRAME") == 2 then
            if HealBot_Panel_EnemyTargetsWithPlayersSelfUpdate() then
                HealBot_Panel_PlayersTargetsQueueResetSkins()
            end
        elseif Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][15]["STATE"] then
            HealBot_nextRecalcParty(5)
        end
    end
    HealBot_Timers_Set("AUX","SetTargetBar")
    HealBot_Options_FramesActionIconsSetLists()
end

function HealBot_DoClearLowMana(button)
      --HealBot_setCall("HealBot_DoClearLowMana", button)
    button.gref.icon["Icontm1"]:SetAlpha(0)
    button.gref.icon["Icontm2"]:SetAlpha(0)
    button.gref.icon["Icontm3"]:SetAlpha(0)
end

local prdCheckActiveFrames={[1]=false, [2]=false, [3]=false, [4]=false, [5]=false, [6]=false, [7]=false, [8]=false, [9]=false, [10]=false}
function HealBot_UnitInCombat()
      --HealBot_setCall("HealBot_UnitInCombat")
    if HealBot_luVars["UpdateEnemyFrame"] then
        HealBot_luVars["UpdateEnemyFrame"]=false
        HealBot_luVars["AllOutOfCombatCheck"]=HealBot_TimeNow+1
        HealBot_Panel_PartyChanged(true, 5)
        if HealBot_luVars["pluginAuraWatch"] then HealBot_Plugin_AuraWatch_Validate() end
    end
end

function HealBot_CheckFramesOnCombatFrame(frame)
      --HealBot_setCall("HealBot_CheckFramesOnCombatFrame")
    local check=true
    if (frame == 8 and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][11]["FRAME"] == 8
                 and hbv_Skins_GetVar("Healing", "TARGETINCOMBAT") == 1)
        or
       (frame == 9 and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][13]["FRAME"] == 9
                 and hbv_Skins_GetVar("Healing", "FOCUSINCOMBAT") == 1) then
        check=false
    end
    if check and prdCheckActiveFrames[frame] and hbv_Skins_GetFrameVar("Frame", "AUTOCLOSE", frame)>1 then
        HealBot_luVars["CheckFramesOnCombat"]=true
    end
end

function HealBot_CheckActiveFrames(frame, active)
      --HealBot_setCall("HealBot_CheckActiveFrames")
    if prdCheckActiveFrames[frame]~=active then
        prdCheckActiveFrames[frame]=active
        HealBot_Timers_Set("LAST","CheckFramesOnCombat")
    end
end

function HealBot_CheckFramesOnCombat()
      --HealBot_setCall("HealBot_CheckFramesOnCombat")
    HealBot_luVars["CheckFramesOnCombat"]=false
    for f=1,10 do
        HealBot_CheckFramesOnCombatFrame(f)
    end
end

function HealBot_PlayerRegenDisabled()
      --HealBot_setCall("HealBot_PlayerRegenDisabled")
    HealBot_Data["UILOCK"]=true
    HealBot_luVars["RegenDisabled"]=true
    HealBot_luVars["CheckAuraFlags"]=true
    HealBot_PlayerCheck()
    if HealBot_Globals.FrameStrataIC ~= HealBot_Globals.FrameStrata then
        HealBot_Action_SetStrata(true)
    end
    if HealBot_Panel_enemyPlayerTargets(true, 2) then
        HealBot_ResetOnEnemyChange()
    end

    if HealBot_RecalcQueue[0] then HealBot_RecalcQueue[0]=false; HealBot_RefreshTypes[0]=true; end
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][13]["STATE"] and
       Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][13]["FRAME"] == 9 and
       hbv_Skins_GetVar("Healing", "FOCUSINCOMBAT") == 1 then
        HealBot_Action_HidePanel(9)
    end
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][11]["STATE"] and
       Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][11]["FRAME"] == 8 and
       hbv_Skins_GetVar("Healing", "TARGETINCOMBAT") == 1 then
        HealBot_Action_HidePanel(8)
    end

    if not HealBot_RefreshTypes[0] then
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][13]["STATE"] or Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][14]["STATE"] then
            if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][13]["FRAME"] == 9 then
                if not HealBot_Action_FrameIsVisible(9) and hbv_Skins_GetVar("Healing", "FOCUSINCOMBAT") == 3 then
                    HealBot_RefreshTypes[4]=true
                end
            elseif hbv_Skins_GetVar("Healing", "FOCUSINCOMBAT")~=2 then
                HealBot_RefreshTypes[6]=true
            end
            if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][14]["FRAME"] == 9 then
                if not HealBot_Action_FrameIsVisible(9) and hbv_Skins_GetVar("Healing", "TOFINCOMBAT") == 3 then
                    HealBot_RefreshTypes[4]=true
                end
            elseif hbv_Skins_GetVar("Healing", "TOFINCOMBAT")~=2 then
                HealBot_RefreshTypes[6]=true
            end
        end
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][11]["STATE"] or Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][12]["STATE"] then
            if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][11]["FRAME"] == 8 then
                if not HealBot_Action_FrameIsVisible(8) and hbv_Skins_GetVar("Healing", "TARGETINCOMBAT") == 3 then
                    HealBot_RefreshTypes[3]=true
                end
            elseif hbv_Skins_GetVar("Healing", "TARGETINCOMBAT")~=2 then
                HealBot_RefreshTypes[6]=true
            end
            if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][12]["FRAME"] == 8 then
                if not HealBot_Action_FrameIsVisible(8) and hbv_Skins_GetVar("Healing", "TOTINCOMBAT") == 3 then
                    HealBot_RefreshTypes[3]=true
                end
            elseif hbv_Skins_GetVar("Healing", "TOTINCOMBAT")~=2 then
                HealBot_RefreshTypes[6]=true
            end
        end
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][9]["STATE"] and hbv_Skins_GetBoolean("Healing", "VEHICLEINCOMBAT") then
            if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][9]["FRAME"] == 6 then
                HealBot_RefreshTypes[1]=true
            else
                HealBot_RefreshTypes[6]=true
            end
        end
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["STATE"] and hbv_Skins_GetBoolean("Healing", "MYPETINCOMBAT") then
            if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["FRAME"] == 7 then
                HealBot_RefreshTypes[2]=true
            else
                HealBot_RefreshTypes[6]=true
            end
        end

        if HealBot_RecalcQueue[6] then HealBot_RecalcQueue[6]=false; HealBot_RefreshTypes[6]=true; end
        if HealBot_RecalcQueue[1] then HealBot_RecalcQueue[1]=false; HealBot_RefreshTypes[1]=true; end
        if HealBot_RecalcQueue[2] then HealBot_RecalcQueue[2]=false; HealBot_RefreshTypes[2]=true; end
        if HealBot_RecalcQueue[3] then HealBot_RecalcQueue[3]=false; HealBot_RefreshTypes[3]=true; end
        if HealBot_RecalcQueue[4] then HealBot_RecalcQueue[4]=false; HealBot_RefreshTypes[4]=true; end

        if HealBot_RefreshTypes[6] then HealBot_RecalcParty(6); end
        if HealBot_RefreshTypes[1] then HealBot_RecalcParty(1); end
        if HealBot_RefreshTypes[2] then HealBot_RecalcParty(2); end
        if HealBot_RefreshTypes[3] then HealBot_RecalcParty(3); end
        if HealBot_RefreshTypes[4] then HealBot_RecalcParty(4); end
    else
        HealBot_RecalcParty(0)
    end
    HealBot_Panel_ButtonShowNow()

    HealBot_UnitInCombat()
    HealBot_Update_AllUnitBars(true)
    if HealBot_luVars["CheckFramesOnCombat"] then
        for f=1,10 do
            if prdCheckActiveFrames[f] and hbv_Skins_GetFrameVar("Frame", "AUTOCLOSE", f)>1 then
                if not HealBot_Action_FrameIsVisible(f) then
                    HealBot_Action_ShowPanel(f)
                end
            end
            if HealBot_Action_FrameIsVisible(f) and not hbv_Skins_GetFrameBoolean("HealBar", "LOWMANACOMBAT", f) then
                HealBot_Update_ClearLowMana(f)
            end
        end
    end
    HealBot_Action_setAlertState()
    if HealBot_Globals.DisableToolTipInCombat and HealBot_Data["TIPBUTTON"] then
        HealBot_Action_HideTooltipFrame()
    end

    if not HealBot_luVars["hlPlayerBarsIC"] and HealBot_luVars["HighlightTarget"] then
        HealBot_PlayerTargetChanged()
    end
    HealBot_ResetRefreshLists()
    
    HealBot_Timers_Set("SKINS","OverShield")
    HealBot_Timers_Set("LAST","ResetUnitStatus")
    if HealBot_luVars["rcEnd"] then
        HealBot_luVars["rcEnd"]=false
        HealBot_Events_ReadyCheckClear(true)
    end
    HealBot_ActionIcons_CombatState(true)
    if HealBot_luVars["pluginTimeToLive"] then HealBot_Plugin_TimeToLive_EnteringCombat() end
    if HealBot_luVars["pluginAuraWatch"] then HealBot_Plugin_AuraWatch_CombatState(true) end
    if HealBot_luVars["pluginHealthWatch"] then HealBot_Plugin_HealthWatch_CombatState(true) end
    if HealBot_luVars["pluginManaWatch"] then HealBot_Plugin_ManaWatch_CombatState(true) end
    --HealBot_Options_RaidTargetUpdate()
end

function HealBot_PlayerCheck()
      --HealBot_setCall("HealBot_PlayerCheck")
    if HealBot_luVars["isResting"] then
        if not IsResting() then
            HealBot_luVars["isResting"]=false
            HealBot_luVars["isAuraResting"]=false
            if HealBot_Config_Buffs.NoAuraWhenRested then HealBot_luVars["CheckAuraFlags"]=true end
            HealBot_Timers_Set("PLAYER","SetRestingState")
        end
    elseif IsResting() then
        if HealBot_Config_Buffs.NoAuraWhenRested then
            HealBot_luVars["isAuraResting"]=true
            HealBot_luVars["CheckAuraFlags"]=true
        end
        HealBot_luVars["isResting"]=true
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
    if HealBot_luVars["playerMounted"] then
        if not IsMounted() then
            HealBot_luVars["playerMounted"]=false
        end
    elseif IsMounted() then
        HealBot_luVars["playerMounted"]=true
    end
    if not HealBot_Config_Cures.DebuffWatchWhenMounted then
        if HealBot_luVars["debuffMounted"] then
            if not HealBot_luVars["playerMounted"] then
                HealBot_luVars["debuffMounted"]=false
                HealBot_luVars["CheckAuraFlags"]=true
                HealBot_Aura_setLuVars("PlayerMounted", false)
            end
        elseif HealBot_luVars["playerMounted"] then
            HealBot_luVars["debuffMounted"]=true
            HealBot_Aura_setLuVars("PlayerMounted", true)
            HealBot_luVars["CheckAuraFlags"]=true
        end
    end
    if not HealBot_Config_Buffs.BuffWatchWhenMounted then
        if HealBot_luVars["buffMounted"] then
            if not HealBot_luVars["playerMounted"] then
                HealBot_luVars["buffMounted"]=false
                HealBot_luVars["CheckAuraFlags"]=true
                HealBot_Aura_setLuVars("PlayerMounted", false)
            end
        elseif HealBot_luVars["playerMounted"] then
            HealBot_luVars["buffMounted"]=true
            HealBot_Aura_setLuVars("PlayerMounted", true)
            HealBot_luVars["CheckAuraFlags"]=true
        end
    end
    if HealBot_luVars["inVehicle"] then
        if not HealBot_UnitInVehicle["player"] then
            HealBot_luVars["inVehicle"]=false
            HealBot_luVars["CheckAuraFlags"]=true
        end
    elseif HealBot_UnitInVehicle["player"] then
        HealBot_luVars["inVehicle"]=true
        HealBot_luVars["CheckAuraFlags"]=true
    end
    if HealBot_luVars["CheckAuraFlags"] then
        HealBot_luVars["CheckAuraFlags"]=false
        HealBot_Aura_SetAuraCheckFlags(HealBot_luVars["debuffMounted"], HealBot_luVars["buffMounted"], HealBot_luVars["onTaxi"], HealBot_luVars["isAuraResting"], HealBot_luVars["inVehicle"])
    end
end

function HealBot_PlayerCheckExtended()
      --HealBot_setCall("HealBot_PlayerCheckExtended")
    if HealBot_Config_Buffs.BuffWatchWhenMounted then
        HealBot_luVars["buffMounted"]=false
    end
    if HealBot_Config_Cures.DebuffWatchWhenMounted then
        HealBot_luVars["debuffMounted"]=false
    end
    HealBot_luVars["isResting"]=false
    HealBot_luVars["isAuraResting"]=false
    HealBot_luVars["CheckAuraFlags"]=true
    HealBot_PlayerCheck()
end

function HealBot_BuffSlowUpdate(button)
      --HealBot_setCall("HealBot_BuffSlowUpdate", button)
    button.status.slowupdate=true
    button.aura.buff.slowupd=true
end

function HealBot_BuffThrottleUpdateButton(button)
      --HealBot_setCall("HealBot_BuffThrottleUpdateButton", button)
    if not HealBot_BuffUpdateList[button.id] then
        table.insert(HealBot_BuffUpdate, button.id)
        HealBot_BuffUpdateList[button.id]=true
        HealBot_Timers_Set("AURA","BuffThrottledUpdate",true)
    end
end

function HealBot_BuffThrottleUpdate()
      --HealBot_setCall("HealBot_BuffThrottleUpdate")
    if HealBot_BuffUpdate[1] then
        if HealBot_Buttons[HealBot_BuffUpdate[1]] then
            HealBot_BuffSlowUpdate(HealBot_Buttons[HealBot_BuffUpdate[1]])
        end
        HealBot_BuffUpdateList[HealBot_BuffUpdate[1]]=false
        table.remove(HealBot_BuffUpdate, 1)
        HealBot_Timers_Set("AURA","BuffThrottledUpdate",true)
    end
end

function HealBot_DebuffSlowUpdate(button)
      --HealBot_setCall("HealBot_DebuffSlowUpdate", button)
    button.status.slowupdate=true
    button.aura.debuff.slowupd=true
end

function HealBot_DebuffThrottleUpdateButton(button)
    if not HealBot_DebuffUpdateList[button.id] then
        table.insert(HealBot_DebuffUpdate, button.id)
        HealBot_DebuffUpdateList[button.id]=true
        HealBot_Timers_Set("AURA","DebuffThrottledUpdate",true)
    end
end

function HealBot_DebuffThrottleUpdate()
    if HealBot_DebuffUpdate[1] then
        if HealBot_Buttons[HealBot_DebuffUpdate[1]] then
            HealBot_DebuffSlowUpdate(HealBot_Buttons[HealBot_DebuffUpdate[1]])
        end
        HealBot_DebuffUpdateList[HealBot_DebuffUpdate[1]]=false
        table.remove(HealBot_DebuffUpdate, 1)
        HealBot_Timers_Set("AURA","DebuffThrottledUpdate",true)
    end
end

function HealBot_GetUnitName(button)
      --HealBot_setCall("HealBot_GetUnitName", button)
    return button.name or UnitName(button.unit) or button.unit or HEALBOT_WORDS_UNKNOWN
end

function HealBot_SetUnitName(name, guid)
      --HealBot_setCall("HealBot_SetUnitName", nil, guid)
    HealBot_customTempUserName[guid]=name
    xButton,pButton=HealBot_Panel_RaidPetUnitButton(guid)
    if xButton then
        xButton.name=name
        HealBot_Action_SetGuidData(xButton, "NAME", name)
        HealBot_Text_setNameText(xButton)
    end
    if pButton then
        pButton.name=name
        HealBot_Action_SetGuidData(pButton, "NAME", name)
        HealBot_Text_setNameText(pButton)
    end
end

function HealBot_DelUnitName(guid)
      --HealBot_setCall("HealBot_DelUnitName", nil, guid)
    HealBot_customTempUserName[guid]=nil
    xButton,pButton=HealBot_Panel_RaidPetUnitButton(guid)
    if xButton and UnitExists(xButton.unit) then
        xButton.name=UnitName(xButton.unit)
        HealBot_Action_SetGuidData(xButton, "NAME", xButton.name)
        HealBot_Text_setNameText(xButton)
    end
    if pButton and UnitExists(pButton.unit) then
        pButton.name=UnitName(pButton.unit)
        HealBot_Action_SetGuidData(pButton, "NAME", pButton.name)
        HealBot_Text_setNameText(pButton)
    end
end

local upUnit=false
function HealBot_UnitPet(unit)
      --HealBot_setCall("HealBot_UnitPet", nil, nil, unit)
    upUnit=false
    if strsub(unit,1,4) == "raid" then
        upUnit="raidpet"..strsub(unit,5)
    elseif UnitIsUnit(unit,"player") then
        upUnit="pet"
    elseif strsub(unit,1,5) == "party" then
        upUnit="partypet"..strsub(unit,6)
    end
    return upUnit
end

function HealBot_retHighlightTarget()
      --HealBot_setCall("HealBot_retHighlightTarget")
    return HealBot_luVars["HighlightTarget"] or "nil"
end

function HealBot_retHbFocus(unit)
      --HealBot_setCall("HealBot_retHbFocus", nil, nil, unit)
    local unitName=UnitName(unit)
    if HealBot_Globals.FocusMonitor[unitName] then
        if HealBot_Globals.FocusMonitor[unitName] == "all" then
            return true
        else
            local _,z=IsInInstance()
            if z == "pvp" or z == "arena" then
                if HealBot_Globals.FocusMonitor[unitName] == "bg" then
                    return true
                end
            elseif z == HealBot_Globals.FocusMonitor[unitName] then
                return true
            else
                z=GetRealZoneText()
                if z == HealBot_Globals.FocusMonitor[unitName] then
                    return true
                end
            end
        end
    end
    return false
end

function HealBot_ReadyCheckUpdate(button,response)
      --HealBot_setCall("HealBot_ReadyCheckUpdate", button)
    if HealBot_luVars["rcEnd"] and button.isplayer and hbv_Skins_GetFrameBoolean("Icons", "SHOWRC", button.frame) then
        if response then
            button.icon.extra.readycheck=hbv_GetStatic("rcREADY")
        else
            button.icon.extra.readycheck=hbv_GetStatic("rcNOTREADY")
        end
        HealBot_Aura_UpdateState(button)
    end
end

function HealBot_ReadyCheckUnit(button)
      --HealBot_setCall("HealBot_ReadyCheckUnit", button)
    if HealBot_luVars["rcEnd"] and button.isplayer and HealBot_Panel_RaidUnitButtonCheck(button.guid) and HealBot_luVars["rcEnd"]>HealBot_TimeNow then
        button.icon.extra.readycheck=HealBot_Action_getGuidData(button.guid, "READYCHECK")
    else
        button.icon.extra.readycheck=false
    end
    HealBot_Aura_UpdateState(button)
end

function HealBot_ReadyCheck()
      --HealBot_setCall("HealBot_ReadyCheck")
    if HealBot_luVars["rcEnd"] and HealBot_luVars["rcEnd"]>HealBot_TimeNow then
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

function HealBot_RaidTargetToggle(switch)
      --HealBot_setCall("HealBot_RaidTargetToggle")
    if switch then
        HealBot:RegisterEvent("RAID_TARGET_UPDATE")
        HealBot_Events_RaidTargetAll()
    else
        HealBot:UnregisterEvent("RAID_TARGET_UPDATE")
        HealBot_Update_RaidTarget()
    end
end

function HealBot_FocusChanged()
      --HealBot_setCall("HealBot_FocusChanged")
    if HealBot_luVars["UILOCK"] then
        HealBot_UnitChanged("focus")
        HealBot_UnitChanged("focustarget")
    end
    HealBot_nextRecalcParty(4)
end

function HealBot_Player_TalentsChanged()
      --HealBot_setCall("HealBot_OnEvent_TalentsChanged")
    xButton, pButton=HealBot_Panel_RaidUnitButton(HealBot_Data["PGUID"])
    if xButton then xButton.spec=" " end
    if pButton then pButton.spec=" " end
    HealBot_Timers_Set("INIT","CheckTalentInfo")
    HealBot_Timers_Set("AURA","CheckPlayer")
end

function HealBot_resetLuVars()
      --HealBot_setCall("HealBot_resetLuVars")
    HealBot_luVars["ProcessRefresh"]=false
    HealBot_Text_setLuVars("FluidTextAlphaInUse", false)
    HealBot_Aux_setLuVars("AuxFluidBarAlphaInUse", false)
    HealBot_Aux_setLuVars("AuxCastBarInUse", false)
    HealBot_Aux_setLuVars("AuxFluidBarInUse", false)
    HealBot_Aux_setLuVars("AuxFlashBarsInUse", false)
    HealBot_Action_setLuVars("DeleteMarkedButtonsActive", false)
    HealBot_Action_setLuVars("FluidBarAlphaInUse", false)
    HealBot_Action_setLuVars("FluidBarInUse", false)
end

function HealBot_UnitSummonsUpdate(button, state)
      --HealBot_setCall("HealBot_UnitSummonsUpdate", button)
    if button.status.summons and not state then
        button.status.summons=false
        HealBot_Text_setNameTag(button)
        HealBot_Aux_ClearSummonsBar(button)
    elseif not button.status.summons then
        button.status.summons=true
        HealBot_Text_setNameTag(button)
        HealBot_Aux_UpdateSummonsBar(button, HEALBOT_WORD_SUMMONS, HealBot_TimeNow*1000, (HealBot_TimeNow+120)*1000, true)
    end
end

function HealBot_GetCorpseName(cName)
      --HealBot_setCall("HealBot_GetCorpseName")
    local z=_G["GameTooltipTextLeft1"];
    local x=z:GetText();
    if (x) then
        cName=string.gsub(x, HEALBOT_TOOLTIP_CORPSE, "")
    end
    return cName
end

function HealBot_ToggelFocusMonitor(unit, zone)
      --HealBot_setCall("HealBot_ToggelFocusMonitor", nil, nil, unit)
    local unitName=UnitName(unit)
    if HealBot_Globals.FocusMonitor[unitName] then
        if UnitExists("target") and unitName == UnitName("target") then HealBot_Panel_clickToFocus("hide") end
        HealBot_Globals.FocusMonitor[unitName]=nil
    else
        HealBot_Globals.FocusMonitor[unitName]=zone
        if UnitExists("target") and HealBot_Globals.FocusMonitor[UnitName("target")] then HealBot_Panel_clickToFocus("Show") end
    end
end

function HealBot_InitSmartCast()
      --HealBot_setCall("HealBot_InitSmartCast")
    if HealBot_Data["PCLASSTRIM"] then
        HealBot_Events_SetResSpells()
        HealBot_Timers_Set("PLAYER","SetRangeSpells",true)
        HealBot_Init_SmartCast();
    else
        HealBot_SetPlayerData()
        HealBot_Timers_Set("PLAYER","InitSmartCast",true,true)
    end
end

function HealBot_InitSpells()
      --HealBot_setCall("HealBot_InitSpells")
    HealBot_Init_Spells_Defaults();
    HealBot_Options_InitDebuffTypes()
    HealBot_Timers_Set("PLAYER","InitSmartCast",true)
end

function HealBot_Cycle_Skins()
      --HealBot_setCall("HealBot_Cycle_Skins")
    local n=getn(Healbot_Config_Skins.Skins)
    if n == Healbot_Config_Skins.Skin_ID then
        n=1
    else
        n=Healbot_Config_Skins.Skin_ID+1
    end
    HealBot_Options_Set_Current_Skin(Healbot_Config_Skins.Skins[n])
end

local ldb=nil
function HealBot_MMButton_Init(callback)
      --HealBot_setCall("HealBot_MMButton_Init")
    if LDB11 and LDBIcon then
        ldb=LDB11:NewDataObject(HEALBOT_HEALBOT, {
            type="data source",
            label=HEALBOT_HEALBOT,
            icon="Interface\\AddOns\\HealBot\\Images\\HealBot",
        })
        if ldb then
            function ldb.OnClick(self, button)
                if button == "LeftButton" then
                    if IsShiftKeyDown() then
                        HealBot_Cycle_Skins()
                    else
                        HealBot_Options_ShowHide()
                    end
                elseif button == "RightButton" then
                    if IsShiftKeyDown() then
                        if HealBot_Config.DisableHealBot then
                            HealBot_Config.DisableHealBot=false
                        else
                            HealBot_Config.DisableHealBot=true
                        end
                        HealBot_Options_DisableHealBotOpt:SetChecked(HealBot_Config.DisableHealBot)
                        HealBot_Timers_Set("OOC","DisableCheck")
                    else
                        HealBot_SetResetFlag("SOFT")
                    end
                else
                    HealBot_Options_ShowHide()
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
            if not LDBIcon:IsRegistered(HEALBOT_HEALBOT) then
                LDBIcon:Register(HEALBOT_HEALBOT, ldb, HealBot_Globals.MinimapIcon)
                HealBot_MMButton_Toggle()
            end
        end
    elseif not callback then
        LDB11=HealBot_Libs_LDB11()
        LDBIcon=HealBot_Libs_LDBIcon()
        HealBot_MMButton_Init(true)
    end
end

function HealBot_MMButton_Toggle()
      --HealBot_setCall("HealBot_MMButton_Toggle")
    if LDBIcon then
        if not HealBot_Globals.MinimapIcon.hide then
            LDBIcon:Show(HEALBOT_HEALBOT)
        else
            LDBIcon:Hide(HEALBOT_HEALBOT)
        end
    end
end

function HealBot_Update_AuxRange(button)
      --HealBot_setCall("HealBot_Update_AuxRange", button)
    HealBot_Update_OORBar(button)
    HealBot_Update_InRangeBar(button)
end

function HealBot_Update_PluginsChange(button)
    if hbHealthWatch[button.guid] then HealBot_Plugin_HealthWatch_UnitUpdate(button) end
    if hbManaWatch[button.guid] then HealBot_Plugin_ManaWatch_UnitUpdate(button) end
end

function HealBot_Update_OORBar(button)
      --HealBot_setCall("HealBot_Update_OORBar", button)
    if button.status.range>0 then
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

function HealBot_Update_InRangeBar(button)
      --HealBot_setCall("HealBot_Update_InRangeBar", button)
    if HealBot_AuxAssigns["InRangeBar"][button.frame] then
        if not button.player and button.status.range>0 then
            HealBot_Aux_UpdateInRangeBar(button)
        else
            HealBot_Aux_ClearInRangeBar(button)
        end
    end
end

function HealBot_Clear_RecentHealsBar(button)
      --HealBot_setCall("HealBot_Clear_RecentHealsBar", button)
    if button.status.playerlastheal<HealBot_TimeNow then
        if HealBot_AuxAssigns["RecentHeals"][button.frame] then
            HealBot_Aux_ClearRecentHealsBar(button)
        end
        if HealBot_AuxAssigns["NameOverlayRecentHeals"][button.frame] then
            HealBot_Aux_UpdateNameOverLay(button, 1, false)
        end
        if HealBot_AuxAssigns["HealthOverlayRecentHeals"][button.frame] then
            HealBot_Aux_UpdateHealthOverLay(button, 1, false)
        end
        HealBot_Action_AdaptiveRecentHealsDisable(button)
    else
        C_Timer.After((button.status.playerlastheal-HealBot_TimeNow)+0.05, function() HealBot_Clear_RecentHealsBar(button) end)
    end
end

function HealBot_Update_RecentHealsBar(button)
      --HealBot_setCall("HealBot_Update_RecentHealsBar", button)
    if button.status.playerlastheal<HealBot_TimeNow then
        if HealBot_AuxAssigns["RecentHeals"][button.frame] then
            HealBot_Aux_UpdateRecentHealsBar(button)
        end
        if HealBot_AuxAssigns["NameOverlayRecentHeals"][button.frame] then
            HealBot_Aux_UpdateNameOverLay(button, 1, true)
        end
        if HealBot_AuxAssigns["HealthOverlayRecentHeals"][button.frame] then
            HealBot_Aux_UpdateHealthOverLay(button, 1, true)
        end
        HealBot_Action_AdaptiveRecentHealsEnable(button)
    end

    C_Timer.After(0.35, function() HealBot_Clear_RecentHealsBar(button) end)
    button.status.playerlastheal=HealBot_TimeNow+0.3
end

function HealBot_Copy_SpellCombo(combo, maxButtons)
      --HealBot_setCall("HealBot_Copy_SpellCombo")
    if combo then
        for y=1,maxButtons do
            local button=HealBot_Options_ComboClass_Button(y)
            combo[button]=combo[HealBot_Action_GetCombo("", button)]
            combo["Shift"..button]=combo[HealBot_Action_GetCombo("Shift", button)]
            combo["Ctrl"..button]=combo[HealBot_Action_GetCombo("Ctrl", button)]
            combo["Alt"..button]=combo[HealBot_Action_GetCombo("Alt", button)]
            combo["Ctrl-Shift"..button]=combo[HealBot_Action_GetCombo("Ctrl-Shift", button)]
            combo["Alt-Shift"..button]=combo[HealBot_Action_GetCombo("Alt-Shift", button)]
            combo["Alt-Ctrl"..button]=combo[HealBot_Action_GetCombo("Alt-Ctrl", button)]
            combo["Alt-Ctrl-Shift"..button]=combo[HealBot_Action_GetCombo("Alt-Ctrl-Shift", button)]
        end
    end
end

function HealBot_Copy_SpellCombos()
      --HealBot_setCall("HealBot_Copy_SpellCombos")
    HealBot_Copy_SpellCombo(HealBot_Config_Spells.EnabledKeyCombo, 20)
    HealBot_Copy_SpellCombo(HealBot_Config_Spells.EnemyKeyCombo, 20)
    HealBot_Copy_SpellCombo(HealBot_Config_Spells.EmergKeyCombo, 5)
    HealBot_AddChat(HEALBOT_CHAT_CONFIRMSPELLCOPY)
end

function HealBot_Reset_Spells()
      --HealBot_setCall("HealBot_Reset_Spells")
    if HealBot_Data["PCLASSTRIM"] then
        HealBot_Spells_Reset(HealBot_Data["PCLASSTRIM"])
        HealBot_Timers_InitExtraOptions()
        HealBot_Timers_Set("INIT","SpellsTabText")
        HealBot_AddChat(HEALBOT_CHAT_CONFIRMSPELLRESET)
        HealBot_Options_SaveSpellsProfile("SPELLS")
    else
        HealBot_SetPlayerData()
        HealBot_Timers_Set("LAST","ResetSpells",true,true)
    end
end

function HealBot_Reset_Buffs()
      --HealBot_setCall("HealBot_Reset_Buffs")
    if HealBot_Data["PCLASSTRIM"] then
        HealBot_Spells_ResetBuffs(HealBot_Data["PCLASSTRIM"])
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
        HealBot_AddChat(HEALBOT_CHAT_CONFIRMBUFFSRESET)
        HealBot_Timers_Set("AURA","BuffReset")
    else
        HealBot_SetPlayerData()
        HealBot_Timers_Set("LAST","ResetBuffs",true,true)
    end
end

function HealBot_Reset_Cures()
      --HealBot_setCall("HealBot_Reset_Cures")
    if HealBot_Data["PCLASSTRIM"] then
        HealBot_Spells_ResetCures(HealBot_Data["PCLASSTRIM"])
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
        HealBot_AddChat(HEALBOT_CHAT_CONFIRMCURESRESET)
        HealBot_Timers_Set("AURA","DebuffReset")
    else
        HealBot_SetPlayerData()
        HealBot_Timers_Set("LAST","ResetCures",true,true)
    end
end

function HealBot_Reset_Icons()
      --HealBot_setCall("HealBot_Reset_Icons")
    HealBot_Globals.IgnoreCustomBuff={}
    HealBot_Globals.CustomBuffs={}
    HealBot_Globals.CustomBuffsShowBarCol={}
    HealBot_Globals.CustomBuffBarColour={[hbv_GetStatic("cBuff")]={ R=0.25, G=0.58, B=0.8, },}
    HealBot_Globals.WatchHoT=HealBot_Options_copyTable(HealBot_GlobalsDefaults.WatchHoT)
    HealBot_Globals.CustomBuffTag=HealBot_Options_copyTable(HealBot_GlobalsDefaults.CustomBuffTag)
    HealBot_Timers_InitExtraOptions()
    HealBot_AddChat(HEALBOT_CHAT_CONFIRMICONRESET)
end

function HealBot_IsItemInBag(itemID)
      --HealBot_setCall("HealBot_IsItemInBag")
    if itemID then
        return HealBot_ItemsInBags[itemID]
    else
        return false
    end
end

function HealBot_IsKnownItem(name)
      --HealBot_setCall("HealBot_IsKnownItem")
    if name and HealBot_IsItemInBag(name) or HealBot_WoWAPI_UsableItem(name) then
        return true
    else
        return false
    end
end


function HealBot_runDefaults()
      --HealBot_setCall("HealBot_runDefaults")
    HealBot_Init_Spells()
    HealBot_Timers_Set("AURA","ClearAllBuffs")
    HealBot_Timers_Set("AURA","ClearAllDebuffs")
end

function HealBot_ClearGUID(guid)
      --HealBot_setCall("HealBot_ClearGUID", nil, guid)
    if guid and not HealBot_Panel_AllUnitButtonCheck(guid) then
        HealBot_Panel_ClearGUID(guid)
        HealBot_Action_ClearGUID(guid)
        HealBot_Aura_ClearGUID(guid)
        HealBot_Aggro_ClearGUID(guid)
        HealBot_ActionIcons_ClearGUID(guid)
        HealBot_Range_ClearGUID(guid)
        if HealBot_luVars["pluginAuraWatch"] then HealBot_Plugin_AuraWatch_ClearGUID(guid) end
        hbHealthWatch[guid]=nil
        hbManaWatch[guid]=nil
        hbActionHealthWatch[guid]=nil
        hbHealthExtra[guid]=nil
        hbActionManaWatch[guid]=nil
        hbAuraWatchMana[guid]=nil
        hbAuraWatchHealth[guid]=nil
        hbAuraTargetWatch[guid]=nil
        hbManaExtra[guid]=nil
        hbActionFallWatch[guid]=nil
        hbActionSwimWatch[guid]=nil
        if HealBot_Data["TIPUSE"] then HealBot_Tooltip_ClearGUID(guid) end
    end
end

function HealBot_QueueClearGUID(button)
      --HealBot_setCall("HealBot_QueueClearGUID", button)
    if string.len(button.guid)>12 then
        HealBot_ClearGUIDQueue[button.guid]=true
    end
end

local hbEventFuncs={["UNIT_SPELLCAST_SENT"]=HealBot_Events_UnitSpellCastSent,
                    ["SPELL_UPDATE_COOLDOWN"]=HealBot_Events_SpellCD,
                    ["SPELL_UPDATE_CHARGES"]=HealBot_Events_SpellCharges,
                    ["COMBAT_LOG_EVENT_UNFILTERED"]=HealBot_Events_Combat_Log,
                    ["PLAYER_REGEN_DISABLED"]=HealBot_Events_RegenDisabled,
                    ["PLAYER_REGEN_ENABLED"]=HealBot_Events_RegenEnabled,
                    ["GROUP_ROSTER_UPDATE"]=HealBot_Events_RosterUpdate,
                    ["RAID_ROSTER_UPDATE"]=HealBot_Events_RosterUpdate,
                    ["RAID_TARGET_UPDATE"]=HealBot_Events_RaidTargetAll,
                    ["PLAYER_TARGET_CHANGED"]=HealBot_Events_TargetUpdate,
                    ["PLAYER_FOCUS_CHANGED"]=HealBot_Events_FocusChanged,
                    ["MODIFIER_STATE_CHANGED"]=HealBot_Events_ModifierChange,
                    ["UNIT_PET"]=HealBot_Events_PetsChanged,
                    ["PLAYER_CONTROL_GAINED"]=HealBot_Events_PlayerCheck,
                    ["PLAYER_CONTROL_LOST"]=HealBot_Events_PlayerCheck,
                    ["PLAYER_UPDATE_RESTING"]=HealBot_Events_PlayerCheck,
                    ["CURSOR_CHANGED"]=HealBot_Events_CursorChanged,
                    ["ROLE_CHANGED_INFORM"]=HealBot_Events_UnitRoleChange,
                    ["PLAYER_ROLES_ASSIGNED"]=HealBot_Events_UnitRoleChange,
                    ["INCOMING_SUMMON_CHANGED"]=HealBot_Events_IncomingSummons,
                    ["PLAYER_MOUNT_DISPLAY_CHANGED"]=HealBot_Events_PlayerCheck,
                    ["UNIT_ENTERED_VEHICLE"]=HealBot_Events_UnitEnteredVehicle,
                    ["UNIT_EXITED_VEHICLE"]=HealBot_Events_UnitExitedVehicle,
                    ["INSPECT_READY"]=HealBot_Events_InspectReady,
                    ["ZONE_CHANGED_NEW_AREA"]=HealBot_Events_ZoneChange,
                    ["ZONE_CHANGED"]=HealBot_Events_SubZoneChange,
                    ["ZONE_CHANGED_INDOORS"]=HealBot_Events_SubZoneChange,
                    ["CHAT_MSG_ADDON"]=HealBot_Events_AddonMsg,
                    ["BAG_UPDATE"]=HealBot_Events_InvChange,
                    ["PLAYER_EQUIPMENT_CHANGED"]=HealBot_Events_EquipmentChange,
                    ["PET_BATTLE_OPENING_START"]=HealBot_Events_PetBattleStart,
                    ["PET_BATTLE_OVER"]=HealBot_Events_PetBattleOver,
                    ["READY_CHECK"]=HealBot_Events_ReadyCheck,
                    ["READY_CHECK_CONFIRM"]=HealBot_Events_ReadyCheckConfirmed,
                    ["READY_CHECK_FINISHED"]=HealBot_Events_ReadyCheckFinished,
                    ["PLAYER_ENTERING_WORLD"]=HealBot_Events_PlayerEnteringWorld,
                    ["PLAYER_LEAVING_WORLD"]=HealBot_Events_PlayerLeavingWorld,
                    ["LEARNED_SPELL_IN_TAB"]=HealBot_Events_PlayerLevelSpellChange,
                    ["LEARNED_SPELL_IN_SKILL_LINE"]=HealBot_Events_PlayerLevelSpellChange,
                    ["PLAYER_LEVEL_UP"]=HealBot_Events_PlayerLevelSpellChange,
                    ["PLAYER_TALENT_UPDATE"]=HealBot_Events_PlayerTalentUpdate,
                    ["CHARACTER_POINTS_CHANGED"]=HealBot_Events_PlayerTalentUpdate,
                    ["TRAIT_CONFIG_UPDATED"]=HealBot_Events_PlayerTalentUpdate,
                    ["ACTIVE_TALENT_GROUP_CHANGED"]=HealBot_Events_PlayerTalentUpdate,
                    ["COMPANION_LEARNED"]=HealBot_Events_CheckMount,
                    ["NEW_MOUNT_ADDED"]=HealBot_Events_CheckMount,
                    ["VARIABLES_LOADED"]=HealBot_Events_VariablesLoaded,
                    ["ADDON_LOADED"]=HealBot_Events_AddOnLoaded,
                    ["GET_ITEM_INFO_RECEIVED"]=HealBot_Events_ItemInfoReceived,
                    ["DISPLAY_SIZE_CHANGED"]=HealBot_Events_UIDisplayChange,
                    ["UI_SCALE_CHANGED"]=HealBot_Events_UIDisplayChange,
                    ["PLAYER_GUILD_UPDATE"]=HealBot_Events_UnitGuildUpdate,
                   }
function HealBot_OnEvent(self, event, ...)
    hbEventFuncs[event](...)
end
