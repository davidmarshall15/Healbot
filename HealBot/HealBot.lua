--[[ HealBot Continued ]]

local HealBot_SmartCast_Spells={};
local HealBot_DebugMsg={};
local HealBot_SpamCut={}
local HealBot_Vers={}
local TimeNow=GetTime()
--local strfind=strfind
local arrg = {}
local LSM = HealBot_Libs_LSM() --LibStub and LibStub:GetLibrary("LibSharedMedia-3.0", true)
for i = 1, #HealBot_Default_Textures do
    LSM:Register("statusbar", HealBot_Default_Textures[i].name, HealBot_Default_Textures[i].file)
end
for i = 1, #HealBot_Default_Sounds do
    LSM:Register("sound", HealBot_Default_Sounds[i].name, HealBot_Default_Sounds[i].file)
end
for i = 1, #HealBot_Default_Fonts do
    LSM:Register("font", HealBot_Default_Fonts[i].name, HealBot_Default_Fonts[i].file)
end
local LDB11 = HealBot_Libs_LDB11()
local LDBIcon = HealBot_Libs_LDBIcon()
local HealBot_VehicleUnit={}
local HealBot_UnitInVehicle={}
local HealBot_notVisible={}
local hbManaPlayers={}
local HealBot_trackHiddenFrames={}
local HealBot_RefreshTypes={[0]=true,[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false}
local HealBot_Timers={["slowUpdate"]=TimeNow,["slowUpdateFreq"]=0.05,
                      ["fastUpdate"]=TimeNow,["fastUpdateFreq"]=0.01,
                      ["barsUpdate"]=TimeNow,["barsUpdateFreq"]=0.1,
                      ["CheckTimeMod"]=0.1}
local HealBot_luVars={}
local HealBot_Player_ButtonCache1={}
local HealBot_Player_ButtonCache2={}
local HealBot_Player_ButtonCache3={}
local HealBot_ResSpells={}
HealBot_luVars["TargetUnitID"]="player"
HealBot_luVars["qaFR"]=30
HealBot_luVars["qaFR1"]=30
HealBot_luVars["qaFR2"]=30
HealBot_luVars["qaFR3"]=30
HealBot_luVars["qaFR4"]=30
HealBot_luVars["qaFRNext"]=TimeNow+45
HealBot_luVars["IsSolo"]=true
HealBot_luVars["MaskAuraDCheck"]=TimeNow
HealBot_luVars["MaskAuraReCheck"]=false
HealBot_luVars["ReloadUI"]=0
HealBot_luVars["MessageReloadUI"]=0
HealBot_luVars["slowSwitch"]=0
HealBot_luVars["fastSwitch"]=0
HealBot_luVars["hbLoaded"]=false
HealBot_luVars["hbReady"]=false
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
HealBot_luVars["healthFactor"]=1
HealBot_luVars["PrevTipTime"]=TimeNow
HealBot_luVars["TipUpdateFreq"]=1
HealBot_luVars["reCheckActionFrames"]=false
HealBot_luVars["EnableErrorSpeech"]=false
HealBot_luVars["EnableErrorText"]=false
HealBot_luVars["DelayLockdownCheck"]=TimeNow
HealBot_luVars["addonMsgTh"]=TimeNow+20
HealBot_luVars["NoSpamOOM"]=0
HealBot_luVars["enTurbo"]=false
HealBot_luVars["enSlowMo"]=false
HealBot_luVars["AuraEventRegistered"]=false 
HealBot_luVars["RangeCheckFreq"]=0.02
HealBot_luVars["CacheSize"]=4
HealBot_luVars["fastUpdateEveryFrame"]=9
HealBot_luVars["TestBarsOn"]=false
HealBot_luVars["RaidTargetUpdate"]=false
HealBot_luVars["showReloadMsg"]=true
HealBot_luVars["overhealUnit"]="-nil-"
HealBot_luVars["overhealCastID"]="-nil-"
HealBot_luVars["overhealAmount"]=0
HealBot_luVars["FLUIDFREQ"]=20

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
    --HealBot_setCall("HealBot_nextRecalcParty"..typeRequired)
end

function HealBot_ClearPlayerButtonCache()
    for x,_ in pairs(HealBot_Player_ButtonCache1) do
        HealBot_Player_ButtonCache1[x]=nil
    end
    for x,_ in pairs(HealBot_Player_ButtonCache2) do
        HealBot_Player_ButtonCache2[x]=nil
    end
    for x,_ in pairs(HealBot_Player_ButtonCache3) do
        HealBot_Player_ButtonCache3[x]=nil
    end
end

function HealBot_AddPlayerButtonCache(unit, bucket)
    if bucket==1 then
        HealBot_Player_ButtonCache1[unit]=true
    elseif bucket==2 then
        HealBot_Player_ButtonCache2[unit]=true
    else
        HealBot_Player_ButtonCache3[unit]=true
    end
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
    --HealBot_setCall("HealBot_retLuVars"..vName)
    return HealBot_luVars[vName]
end

function HealBot_setNotVisible(unit,group)
    HealBot_notVisible[unit]=group
    --HealBot_setCall("HealBot_setNotVisible")
end

local cpSavePerChar, cpSaveZ=1, 0
function HealBot_cpSave(mName, mBody)
    if Healbot_Config_Skins.Protection[Healbot_Config_Skins.Current_Skin]["GENERALMACRO"] then
        cpSavePerChar = nil
    else
        cpSavePerChar = 1
    end
    cpSaveZ=GetMacroIndexByName(mName)
    if (cpSaveZ or 0) == 0 then
        cpSaveZ = CreateMacro(mName, "Spell_Holy_SealOfSacrifice", mBody, cpSavePerChar)
    else
        cpSaveZ = EditMacro(cpSaveZ, mName, "Spell_Holy_SealOfSacrifice", mBody)
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

local ubZ=1
local function HealBot_UnitHasBuff(unit, bName)
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
        if HealBot_Version_Target() then HealBot_TogglePanel(HealBot_Options); end
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
        HealBot_setOptions_Timer(596)
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
    elseif (HBcmd=="zzz") then
        HealBot_AddDebug("Timers: Fast="..HealBot_Timers["fastUpdateFreq"].." Bars="..HealBot_Timers["barsUpdateFreq"])
        HealBot_AddDebug("Timers: OFREQ[1]="..Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][1]["OFREQ"])
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
    if numBars and tonumber(numBars) and tonumber(numBars)>4 and tonumber(numBars)<71 then
        numBars=tonumber(numBars)
        HealBot_Panel_SetNumBars(numBars)
        HealBot_Panel_ToggleTestBars()
     elseif HealBot_luVars["TestBarsOn"] then
         HealBot_Panel_ToggleTestBars()
    end
    HealBot_nextRecalcParty(0)
    --HealBot_setCall("HealBot_TestBars")
end

local function HealBot_OnEvent_UnitMana(button)
    button.mana.update=false
    if UnitExists(button.unit) and button.status.unittype < 11 then
        button.mana.current=UnitPower(button.unit)
        button.mana.max=UnitPowerMax(button.unit)
        HealBot_Action_CheckUnitLowMana(button)
        HealBot_Action_setPowerBars(button)
    end
    --HealBot_setCall("HealBot_OnEvent_UnitMana")
end

local function HealBot_OnEvent_UnitManaUpdate(button, reset)
    if reset then
        button.mana.reset=false
        HealBot_Action_setButtonManaBarCol(button)
    end
    button.mana.update=true
end

local function HealBot_setAllPowerBars()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Action_setPowerBars(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Action_setPowerBars(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Action_setPowerBars(xButton)
    end
end

local function HealBot_ClearUnitAggro(button)
    button.aggro.threatpct = -5
    HealBot_Aggro_IndicatorUpdate(button)
    HealBot_Action_UpdateAggro(button,false,0,0,"")
    --HealBot_setCall("HealBot_ClearUnitAggro")
end

local uuUnitClassEN="XXXX"
function HealBot_UpdateUnit(button)
    if UnitExists(button.unit) and button.guid~=UnitGUID(button.unit) then
        button.reset=true
        if button.status.unittype<7 then
            HealBot_setOptions_Timer(596)
        elseif button.status.unittype==8 then
            HealBot_nextRecalcParty(2)
        elseif button.status.unittype==7 then
            HealBot_nextRecalcParty(1)
        end        
        HealBot_ClearUnitAggro(button)
        HealBot_Aura_RemoveIcons(button)
        HealBot_clearAllAuxBar(button)
    end
    button.guid=UnitGUID(button.unit)
    button.health.updincoming=true
    button.health.updabsorbs=true
    if UnitExists(button.unit) then
        _, uuUnitClassEN = UnitClass(button.unit);
        button.text.r,button.text.g,button.text.b=HealBot_Action_ClassColour(button.unit)
        button.text.classtrim = strsub(uuUnitClassEN or "XXXX",1,4)
        HealBot_Action_setButtonManaBarCol(button)
        HealBot_OnEvent_UnitHealth(button)
        HealBot_OnEvent_UnitMana(button);
        if button.status.dirarrowshown then HealBot_Action_ShowDirectionArrow(button) end
        HealBot_Action_CheckUnitLowMana(button)
        button.mana.reset=true
    else
        if button.status.unittype==7 and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["STATE"] then
            HealBot_nextRecalcParty(1)
        elseif button.status.unittype==8 and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["STATE"] then
            HealBot_nextRecalcParty(2)
        end
        if button.status.dirarrowshown then HealBot_Action_HideDirectionArrow(button) end
        HealBot_ClearUnitAggro(button)
        HealBot_Aura_RemoveIcons(button)
        HealBot_clearAllAuxBar(button)
        button.health.update=true
    end
    HealBot_clearAllAuxBar(button)
    --button.text.nameupdate=true
    --button.text.healthupdate=true
    HealBot_CheckAggroUnits(button)
    button.aura.check=true 
    HealBot_Text_setNameTag(button)
    HealBot_Text_setHealthText(button)
    HealBot_Text_setNameText(button)
    HealBot_Action_SetClassIconTexture(button)
    HealBot_OnEvent_RaidTargetUpdate(button)
    HealBot_Aura_CheckIcons(button)
    HealBot_Action_UpdateBackgroundButton(button)
    HealBot_Text_SetText(button)
    HealBot_Action_Refresh(button)
    --HealBot_setCall("HealBot_UpdateUnit")
end

local function HealBot_RecalcParty(changeType)
    HealBot_RefreshTypes[changeType]=false
    HealBot_Action_PartyChanged(changeType);
    --HealBot_setCall("HealBot_RecalcParty")
end

local function HealBot_CheckZone()
    HealBot_setOptions_Timer(405)
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
        HealBot_Config_Buffs.HealBotBuffText[7]=GetItemInfo(HEALBOT_EVER_BLOOMING_FROND)
    end
    if IsUsableItem(HEALBOT_ORALIUS_WHISPERING_CRYSTAL) or HealBot_IsItemInBag(HEALBOT_ORALIUS_WHISPERING_CRYSTAL) then
        HealBot_Config_Buffs.HealBotBuffText[6]=GetItemInfo(HEALBOT_ORALIUS_WHISPERING_CRYSTAL)
    end
    if IsUsableItem(HEALBOT_REPURPOSED_FEL_FOCUSER) or HealBot_IsItemInBag(HEALBOT_REPURPOSED_FEL_FOCUSER) then
        HealBot_Config_Buffs.HealBotBuffText[8]=GetItemInfo(HEALBOT_REPURPOSED_FEL_FOCUSER)
    end
    if IsUsableItem(HEALBOT_BATTLE_SCARRED_AUGMENT_RUNE) or HealBot_IsItemInBag(HEALBOT_BATTLE_SCARRED_AUGMENT_RUNE) then
        HealBot_Config_Buffs.HealBotBuffText[5]=GetItemInfo(HEALBOT_BATTLE_SCARRED_AUGMENT_RUNE)
    end
    if IsUsableItem(HEALBOT_TAILWIND_SAPPHIRE) or HealBot_IsItemInBag(HEALBOT_TAILWIND_SAPPHIRE) then
        HealBot_Config_Buffs.HealBotBuffText[8]=GetItemInfo(HEALBOT_TAILWIND_SAPPHIRE)
    end
    if IsUsableItem(HEALBOT_AMETHYST_OF_THE_SHADOW_KING) or HealBot_IsItemInBag(HEALBOT_AMETHYST_OF_THE_SHADOW_KING) then
        HealBot_Config_Buffs.HealBotBuffText[7]=GetItemInfo(HEALBOT_AMETHYST_OF_THE_SHADOW_KING)
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
    HealBot_setOptions_Timer(35)
    HealBot_Options_LoadTips()
	HealBot_setOptions_Timer(50)
    HealBot_Tooltip:SetBackdropColor(0,0,0,HealBot_Globals.ttalpha)
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
    if hbCaller~="playerEW" then
        HealBot_OnEvent_PlayerEnteringWorld("Load")
    end
    HealBot_setOptions_Timer(140)
    HealBot_MMButton_Init();
    --HealBot_setCall("HealBot_Load")
end

function HealBot_Register_AuraEvent()
    if not HealBot_luVars["AuraEventRegistered"] then
        HealBot_luVars["AuraEventRegistered"]=true
        HealBot:RegisterEvent("UNIT_AURA");
        HealBot_luVars["hbReady"]=true
    end
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
            if not libCD then
                libCD = HealBot_Libs_CD()
                if libCD then libCD:Register(HEALBOT_HEALBOT) end
            end
        end
        HealBot:RegisterEvent("UNIT_SPELLCAST_START");
        HealBot:RegisterEvent("UNIT_SPELLCAST_STOP");
        HealBot:RegisterEvent("UNIT_SPELLCAST_FAILED");
        HealBot:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED");
        HealBot:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED");
        HealBot:RegisterEvent("PLAYER_REGEN_DISABLED");
        HealBot:RegisterEvent("PLAYER_REGEN_ENABLED");
        HealBot:RegisterEvent("PLAYER_TARGET_CHANGED");
        HealBot:RegisterEvent("UNIT_HEALTH");
        HealBot:RegisterEvent("UNIT_MAXHEALTH");
        local regPower=false
        HealBot_Options_Energy()
        HealBot:RegisterEvent("LEARNED_SPELL_IN_TAB");
        HealBot:RegisterEvent("CHARACTER_POINTS_CHANGED");
        HealBot:RegisterEvent("UNIT_DISPLAYPOWER");
		HealBot:RegisterEvent("INSPECT_READY");
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
        HealBot:RegisterEvent("UPDATE_MACROS");
        HealBot:RegisterEvent("UNIT_CONNECTION");
        HealBot:RegisterEvent("PLAYER_CONTROL_GAINED");
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
            HealBot:UnregisterEvent("UPDATE_SHAPESHIFT_FORM");
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
        --HealBot:UnregisterEvent("UNIT_AURA");  -- Only registers once!
        HealBot_UnRegister_Aggro()
        HealBot:UnregisterEvent("UNIT_PET");
        HealBot:UnregisterEvent("UNIT_NAME_UPDATE");
		HealBot:UnregisterEvent("ROLE_CHANGED_INFORM");
        HealBot:UnregisterEvent("MODIFIER_STATE_CHANGED");
        HealBot:UnregisterEvent("PLAYER_CONTROL_GAINED");
        --HealBot:UnregisterEvent("UNIT_TARGET")
    end
    if HEALBOT_GAME_VERSION>3 then
        HealBot:UnregisterEvent("PLAYER_SPECIALIZATION_CHANGED");
        HealBot:UnregisterEvent("PET_BATTLE_OPENING_START");
        HealBot:UnregisterEvent("PET_BATTLE_OVER");
    end
    HealBot:UnregisterEvent("UNIT_SPELLCAST_START");
    HealBot:UnregisterEvent("UNIT_SPELLCAST_STOP");
    HealBot:UnregisterEvent("UNIT_SPELLCAST_FAILED");
    HealBot:UnregisterEvent("UNIT_SPELLCAST_INTERRUPTED");
    HealBot:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED");
    HealBot:UnregisterEvent("RAID_TARGET_UPDATE")
    HealBot:UnregisterEvent("LEARNED_SPELL_IN_TAB");
    HealBot:UnregisterEvent("UNIT_SPELLCAST_SENT");
	HealBot:UnregisterEvent("INSPECT_READY");
    HealBot:UnregisterEvent("CHARACTER_POINTS_CHANGED");
    HealBot:UnregisterEvent("UNIT_DISPLAYPOWER");
    HealBot:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
    --HealBot_setCall("HealBot_UnRegister_Events")
end

local function HealBot_EndAggro()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_ClearUnitAggro(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
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
        HealBot_setOptions_Timer(150)
        HealBot_Load("hbReset") 
        HealBot_setOptions_Timer(7950)
        HealBot_Register_Events()
        HealBot_setOptions_Timer(595)
    else
        for _,xButton in pairs(HealBot_Unit_Button) do
            HealBot_UpdateUnit(xButton)
        end
        for _,xButton in pairs(HealBot_Private_Button) do
            HealBot_UpdateUnit(xButton)
        end
        for _,xButton in pairs(HealBot_Pet_Button) do
            HealBot_UpdateUnit(xButton)
        end
    end
    --HealBot_setCall("HealBot_Reset")
end

local idGUID,idUnit,idButton,pidButton=false,false,false,false
local function HealBot_UnitID(unit, incEnemy)
    idButton=HealBot_Unit_Button[unit] or HealBot_Pet_Button[unit]
    pidButton=HealBot_Private_Button[unit]
    if idButton or pidButton then
        return unit, idButton, pidButton
    end
    idGUID=UnitGUID(unit) or false
    if idGUID then
        idUnit=HealBot_Panel_RaidUnitGUID(idGUID)
        if idUnit and UnitIsUnit(unit,idUnit) then
            if HealBot_Unit_Button[idUnit] or HealBot_Private_Button[idUnit] then
                return idUnit, HealBot_Unit_Button[idUnit], HealBot_Private_Button[idUnit]
            elseif HealBot_Pet_Button[idUnit] then
                return idUnit, HealBot_Pet_Button[idUnit], false
            end
        elseif incEnemy and HealBot_Enemy_Button[unit] then
            return unit, HealBot_Enemy_Button[unit], false
        end
    end
    --HealBot_setCall("HealBot_UnitID")
    return false,false,false
end

local hbAuxOverHealAssigned={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
function HealBot_clearAuxOverHealAssigned()
    for f=1,9 do
        hbAuxOverHealAssigned[f]={};
    end
end

function HealBot_setAuxOverHealAssigned(frame, id)
    table.insert(hbAuxOverHealAssigned[frame], id)
end

local function HealBot_UpdateAuxOverHealBar(button)
    table.foreach(hbAuxOverHealAssigned[button.frame], function (x,id)
        if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==1 then
            button.aux[id]["R"]=1
            button.aux[id]["G"]=0.2
            button.aux[id]["B"]=0.2
        end
        HealBot_setAuxBar(button, id, floor((button.health.overheal/button.health.incoming)*1000), true)
    end)
end

function HealBot_ClearAuxOverHealBar(button)
    table.foreach(hbAuxOverHealAssigned[button.frame], function (x,id)
        HealBot_clearAuxBar(button, id)
    end)
end

local hiuOverHeal=0
function HealBot_OverHeal(button)
    if button.status.current<9 then
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["OVERHEAL"]==3 then
            hiuOverHeal=(button.health.current+button.health.incoming)-button.health.max
        elseif HealBot_luVars["overhealUnit"]==button.unit then
            if HealBot_luVars["overhealAmount"]==0 then
                HealBot_luVars["overhealAmount"]=button.health.incoming
            elseif HealBot_luVars["overhealAmount"]>button.health.incoming then
                HealBot_luVars["overhealAmount"]=button.health.incoming
            end
            hiuOverHeal=(button.health.current+HealBot_luVars["overhealAmount"])-button.health.max
            --hiuOverHeal=(button.health.current+button.health.incoming)-button.health.max
        else
            hiuOverHeal=0
        end
        if hiuOverHeal<1 then
            hiuOverHeal=0
        end
    else
        hiuOverHeal=0
    end
    if button.health.overheal~=hiuOverHeal then
        button.health.overheal=hiuOverHeal
        button.text.healthupdate=true
        if hiuOverHeal>0 then
            HealBot_UpdateAuxOverHealBar(button)
        else
            HealBot_ClearAuxOverHealBar(button)
        end
    end
    --HealBot_setCall("HealBot_OverHeal")
end

local hiuHealAmount=0
function HealBot_HealsInUpdate(button)
    button.health.updincoming=false
    if button.status.current>3 and button.status.current<9 and button.status.range>0 and UnitExists(button.unit) then
        hiuHealAmount=0
        if HEALBOT_GAME_VERSION>3 then
            hiuHealAmount=(UnitGetIncomingHeals(button.unit) or 0)
        elseif libCHC then
            hiuHealAmount = (libCHC:GetHealAmount(button.guid, libCHC.DIRECT_HEALS) or 0) * (libCHC:GetHealModifier(button.guid) or 1)
        end
        if button.health.incoming~=hiuHealAmount or (hiuHealAmount==0 and button.gref["InHeal"]:GetValue()>0) then
            button.health.incoming=hiuHealAmount
            HealBot_Text_setHealthText(button)
            HealBot_Action_UpdateHealsInButton(button)
        end
        HealBot_OverHeal(button)
    elseif button.health.incoming>0 or button.gref["InHeal"]:GetValue()>0 then
        button.health.incoming=0
        button.health.overheal=0
        HealBot_ClearAuxOverHealBar(button)
        HealBot_Text_setHealthText(button)
        button.gref["InHeal"]:SetValue(0)
        button.gref["InHeal"]:SetStatusBarColor(0,0,0,0);
        HealBot_Action_ClearAuxHealInBar(button)
        HealBot_Text_SetText(button)
    end
    --HealBot_setCall("HealBot_HealsInUpdate")
end

local function HealBotClassic_HealsInDoUpdate(button, immediateUpdate)
    if immediateUpdate then
        HealBot_HealsInUpdate(button)
    else
        button.health.updincoming=true
    end
    HealBot_AbsorbsUpdate(button)
end

local chiTargetGUID, chiUnit, chixButton, chipButton=false,false,false
function HealBotClassic_HealsInUpdate(immediateUpdate, spellId, ...)
    for i=1, select("#", ...) do
        chiTargetGUID = select(i, ...)
        if chiTargetGUID and HealBot_Panel_RaidUnitGUID(chiTargetGUID) then
            chiUnit,chixButton,chipButton = HealBot_UnitID(HealBot_Panel_RaidUnitGUID(chiTargetGUID))
            if chixButton then HealBotClassic_HealsInDoUpdate(chixButton, immediateUpdate) end
            if chipButton then HealBotClassic_HealsInDoUpdate(chipButton, immediateUpdate) end
            if HealBot_Unit_Button["target"] and chiUnit~="target" and UnitExists("target") and UnitIsUnit("target", chiUnit) then
                HealBotClassic_HealsInDoUpdate(HealBot_Unit_Button["target"], immediateUpdate)
            end
        end
    end
end

local abuAbsorbAmount=0
function HealBot_AbsorbsUpdate(button)
    button.health.updabsorbs=false
    if button.status.current>3 and button.status.current<9 and button.status.range>0 and UnitExists(button.unit) then
        abuAbsorbAmount=0
        if HEALBOT_GAME_VERSION>3 then
            abuAbsorbAmount=(UnitGetTotalAbsorbs(button.unit) or 0)
        elseif libCHC then -- In Classic absorbs are not available from libhealcom but filtering HoT's is.
            abuAbsorbAmount = (libCHC:GetHealAmount(button.guid, libCHC.HOT_HEALS) or 0) * (libCHC:GetHealModifier(button.guid) or 1)
        end
        if button.health.absorbs~=abuAbsorbAmount or (abuAbsorbAmount==0 and button.gref["Absorb"]:GetValue()>0) then
            button.health.absorbs=abuAbsorbAmount
            HealBot_Text_setHealthText(button)
            HealBot_Action_UpdateAbsorbsButton(button)
        end
    elseif button.health.absorbs>0 or button.gref["Absorb"]:GetValue()>0 then
        button.health.absorbs=0
        HealBot_Text_setHealthText(button)
        button.gref["Absorb"]:SetValue(0)
        button.gref["Absorb"]:SetStatusBarColor(0,0,0,0);
        HealBot_Action_ClearAuxAbsorbBar(button)
        HealBot_Text_SetText(button)
    end
    --HealBot_setCall("HealBot_AbsorbsUpdate")
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

local function HealBot_Reset_Button(button)
    HealBot_UpdateUnit(button)
    if HealBot_Action_AlwaysEnabled(button.guid) then HealBot_Action_Toggle_Enabled(button); end
end

function HealBot_Reset_Unit(unit)
    local _,xButton,pButton = HealBot_UnitID(unit)
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

local ihretX, ihretY=0, 0
function HealBot_IncHeals_retHealsIn(unit, button)
    ihretX=button.health.incoming
    ihretY=button.health.absorbs
    if Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["AC"]<2 then ihretY=0 end
    if Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][button.frame]["IC"]<2 then ihretX=0 end
    --HealBot_setCall("HealBot_IncHeals_retHealsIn")
    return ihretX, ihretY
end

local function HealBot_IncHeals_ClearUnit(button)
    if button.health.incoming>0 then
        button.health.incoming=0
        button.health.overheal=0
        HealBot_ClearAuxOverHealBar(button)
        HealBot_Action_UpdateHealsInButton(button)
    end
    if button.health.absorbs>0 then
        button.health.absorbs=0
        HealBot_Action_UpdateAbsorbsButton(button)
    end
end

local function HealBot_IncHeals_ClearAll()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_IncHeals_ClearUnit(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_IncHeals_ClearUnit(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
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

function HealBot_Set_Timers()
    if HealBot_Config.DisabledNow==0 then
        local minBarsFreq=HealBot_Comm_round(1/(HealBot_luVars["qaFR"]/3),4)
        local minSlowFreq=HealBot_Comm_round(1/(HealBot_luVars["qaFR"]/12),4)
        local minFastFreq=HealBot_Comm_round(1/(HealBot_luVars["qaFR"]/1.2),4)
        HealBot_Timers["fastUpdateFreq"]=0.064-(0.05-(HealBot_Comm_round((HealBot_luVars["RangeCheckFreq"]/20), 3)))
        HealBot_Timers["barsUpdateFreq"]=(HealBot_luVars["RangeCheckFreq"]/10)-0.01
        if HealBot_luVars["enTurbo"] and HealBot_luVars["qaFR"]>50 then
            HealBot_Timers["slowUpdateFreq"]=(HealBot_Timers["fastUpdateFreq"]*8)
        elseif HealBot_luVars["enSlowMo"] then
            HealBot_Timers["slowUpdateFreq"]=(HealBot_Timers["fastUpdateFreq"]*20)
        else
            HealBot_Timers["slowUpdateFreq"]=(HealBot_Timers["fastUpdateFreq"]*12)
        end
        if HealBot_Timers["barsUpdateFreq"]<minBarsFreq then HealBot_Timers["barsUpdateFreq"]=minBarsFreq end
        if HealBot_Timers["slowUpdateFreq"]<minSlowFreq then HealBot_Timers["slowUpdateFreq"]=minSlowFreq end
        if HealBot_Timers["fastUpdateFreq"]<minFastFreq then HealBot_Timers["fastUpdateFreq"]=minFastFreq end
        --HealBot_AddDebug("qaFR="..HealBot_luVars["qaFR"].."  Fast="..HealBot_Timers["fastUpdateFreq"].."  Bars="..HealBot_Timers["barsUpdateFreq"])
    else
        HealBot_Timers["slowUpdateFreq"]=4
        HealBot_Timers["fastUpdateFreq"]=1
        HealBot_Timers["barsUpdateFreq"]=15
    end
end

local HealBot_Options_Timer={}
function HealBot_setOptions_Timer(value)
    if HealBot_Timers["slowUpdate"]>(TimeNow+0.1) then HealBot_Timers["slowUpdate"]=TimeNow+0.05 end
    HealBot_Timers["slowUpdateFreq"]=(HealBot_Timers["fastUpdateFreq"]*3)
    HealBot_luVars["HealBot_Options_Timer"]=true
    HealBot_Options_Timer[value]=true
    --HealBot_setCall("HealBot_setOptions_Timer")
    --HealBot_setCall("HealBot_setOptions_Timer-"..value)
end

local HealBot_ErrorNum=0

local function HealBot_setqaFR()
    HealBot_luVars["qaFR4"]=GetFramerate()
    if HealBot_luVars["qaFRNext"]<GetTime() and HealBot_luVars["qaFR4"]>(HealBot_luVars["qaFR"]/1.5) then
        if HealBot_luVars["qaFR4"]>(HealBot_luVars["qaFR"]*1.2) then HealBot_luVars["qaFR4"]=HealBot_luVars["qaFR"]*1.2 end 
        if HealBot_luVars["qaFR4"]>150 then HealBot_luVars["qaFR4"]=150 end
        if HealBot_luVars["qaFR4"]<25 then HealBot_luVars["qaFR4"]=25 end
        HealBot_luVars["qaFR3"]=HealBot_luVars["qaFR2"]
        HealBot_luVars["qaFR2"]=HealBot_luVars["qaFR1"]
        HealBot_luVars["qaFR1"]=HealBot_luVars["qaFR4"]
        HealBot_luVars["qaFR"]=HealBot_Comm_round((HealBot_luVars["qaFR1"]+HealBot_luVars["qaFR2"]+HealBot_luVars["qaFR3"])/3, 2) 
    end    
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
        Healbot_Config_Skins.AuxBar[skinName]=HealBot_Options_copyTable(HealBot_Config_SkinsDefaults.AuxBar[skinName])
        Healbot_Config_Skins.AuxBarFrame[skinName]=HealBot_Options_copyTable(HealBot_Config_SkinsDefaults.AuxBarFrame[skinName])
        table.insert(Healbot_Config_Skins.Skins,skinName)
        HealBot_Skins_Check_Skin(skinName)
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
            HealBot_Skins_Check_Skin(Healbot_Config_Skins.Skins[x])
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
            elseif tonumber(tMinor)==2 then
                if tonumber(tPatch)==0 and tonumber(tHealbot)<3 then
                    HealBot_setOptions_Timer(7990)
                end
                if tonumber(tPatch)==0 and tonumber(tHealbot)<5 then
                    HealBot_Globals.CatchAltBuffIDs=nil
                end
                if tonumber(tPatch)==0 and tonumber(tHealbot)<7 then
                    HealBot_Globals.v1BuffExpireTimes=nil
                end
            end
            if tonumber(tMinor)<3 then
                if tonumber(tPatch)<6 and tonumber(tHealbot)<6 then
                    HealBot_Globals.RangeCheckFreq=5
                    HealBot_Globals.CacheSize=5
                    if HealBot_Globals.MaxBarsCache then HealBot_Globals.MaxBarsCache=nil end
                    if HealBot_Globals.EnLibQuickHealth then HealBot_Globals.EnLibQuickHealth=false end
                end
                if tonumber(tPatch)<6 and tonumber(tHealbot)<7 then
                    HealBot_NewVersionMessage(1)
                end
                if tonumber(tPatch)<6 and tonumber(tHealbot)<10 then
                    HealBot_NewVersionMessage(2)
                end
                HealBot_Update_BuffsForSpec("Buff")
            elseif tonumber(tMinor)==3 then
                if tonumber(tPatch)==0 and tonumber(tHealbot)<3 then
                    HealBot_Update_BuffsForSpec("Buff")
                end
                if tonumber(tPatch)==0 and tonumber(tHealbot)<8 then
                    for x in pairs (Healbot_Config_Skins.Skins) do
                        for gl=1,10 do
                            if Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Skins[x]][gl]["IC"]>2 then
                                Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Skins[x]][gl]["IC"]=Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Skins[x]][gl]["IC"]-1
                            end
                        end
                    end
                end
            end
        end
        if HealBot_Globals.mapScale then HealBot_Globals.mapScale=nil end
        if HealBot_Globals.RangeCheckFreq>9 then HealBot_Globals.RangeCheckFreq=9 end
        if HealBot_Globals.RangeCheckFreq<1 then HealBot_Globals.RangeCheckFreq=5 end
        if HealBot_Globals.CureCustomDefaultCastBy=="ALL" then HealBot_Globals.CureCustomDefaultCastBy=1 end
        if HealBot_Globals.CureCustomDefaultCastBy=="ENEMY" then HealBot_Globals.CureCustomDefaultCastBy=2 end
        local customDebuffPriority=HEALBOT_CUSTOM_en.."15"
        if not HealBot_Globals.CDCBarColour[customDebuffPriority] then
            HealBot_Globals.CDCBarColour[customDebuffPriority]={}
            HealBot_Globals.CDCBarColour[customDebuffPriority]["R"] = 0.45
            HealBot_Globals.CDCBarColour[customDebuffPriority]["G"] = 0
            HealBot_Globals.CDCBarColour[customDebuffPriority]["B"] = 0.28
        end
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
end

function HealBot_setTooltipUpdateInterval()
    if HealBot_Globals.Tooltip_ShowCD then
        HealBot_luVars["TipUpdateFreq"]=0.1
    else
        HealBot_luVars["TipUpdateFreq"]=0.2
    end
    --HealBot_setCall("HealBot_setTooltipUpdateInterval")
end

function HealBot_IncorrentVersion()
    local msg=""
    if HEALBOT_GAME_VERSION>3 then
        msg="You have Healbot Classic in Retail\nHealbot Classic is not compatible with Retail\n\nTo use Healbot download Healbot Retail"
    else
        msg="You have Healbot Retail in Classic\nHealbot Retail is not compatible with Classic\n\nTo use Healbot download Healbot Classic"
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

local function HealBot_OnEvent_VariablesLoaded(self)
    if not HealBot_Version_Target() then
        HealBot_IncorrentVersion()
    else
        HealBot_Action_InitFrames()
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

        local pClass, pClassEN=UnitClass("player")
        HealBot_Data["PCLASSTRIM"]=strsub(pClassEN,1,4)

        HealBot_customTempUserName=HealBot_Options_copyTable(HealBot_Globals.HealBot_customPermUserName)
        HealBot_Update_Skins()  
        HealBot_Options_InitVars()
        HealBot_Options_setLists()
        
        if HealBot_Globals.localLang then
            HealBot_Options_Lang(HealBot_Globals.localLang)
        else
            HealBot_Options_Lang(GetLocale())
        end
        HealBot_Options_setClassEn()
        
        if HealBot_Config.Profile==2 then
            HealBot_Options_hbProfile_setClass()
        end
        local pRace, pRaceEN=UnitRace("player")
        HealBot_Data["PRACE_EN"]=pRaceEN
        HealBot_Data["PNAME"]=UnitName("player")
        HealBot_Data["PLEVEL"]=UnitLevel("player")
        C_ChatInfo.RegisterAddonMessagePrefix(HEALBOT_HEALBOT)
        HealBot_Options_InitBuffClassList()
        HealBot_Vers[HealBot_Data["PNAME"]]=HEALBOT_VERSION
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
        HealBot_Aura_InitData()
        HealBot_Options_EmergencyFilter_Reset()
        HealBot_Text_sethbNumberFormat()
        HealBot_Text_sethbAggroNumberFormat()
        HealBot:RegisterEvent("PLAYER_ENTERING_WORLD");
        HealBot:RegisterEvent("PLAYER_LEAVING_WORLD");
        g=_G["HealBot_Options_SkinsFrameIconsGeneralb"]
        g:LockHighlight()
        g=_G["HealBot_Options_SkinsFrameTextNameb"]
        g:LockHighlight()
        g=_G["HealBot_Options_SkinsFramesBarsGeneralb"]
        g:LockHighlight()
        g=_G["HealBot_Options_SkinsFrameHeadersBarb"]
        g:LockHighlight()
        g=_G["HealBot_Options_SkinsFramesBarsAuxAssignb"]
        g:LockHighlight()
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
        HealBot_Load("VarsLoaded")
        HealBot_Options_Set_Current_Skin(Healbot_Config_Skins.Current_Skin)
        HealBot_luVars["hbLoaded"]=true
        HealBot_luVars["CacheSize"]=HealBot_Globals.CacheSize*4
        HealBot_Options_Init(9995)
        HealBot_Options_clearAuxBars()
    end
    --HealBot_setCall("HealBot_OnEvent_VariablesLoaded")
end

local function HealBot_OnEvent_ItemInfoReceived(self)
    HealBot:UnregisterEvent("GET_ITEM_INFO_RECEIVED");
    HealBot_setOptions_Timer(10)
    --HealBot_setCall("HealBot_OnEvent_ItemInfoReceived")
end


local function HealBot_CheckLowMana()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Action_CheckUnitLowMana(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Action_CheckUnitLowMana(xButton)
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        HealBot_Action_CheckUnitLowMana(xButton)
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
                    --HealBot_Aura_ClearAllBuffs()
                    --HealBot_Aura_ClearAllDebuffs()
                    HealBot_setOptions_Timer(30)
                    HealBot_setOptions_Timer(50)
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
                    HealBot_setOptions_Timer(596)
                end
                button.spec = " "..s.." "
                HealBot_Action_setButtonManaBarCol(button)
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
        --HealBot_Aura_ClearAllBuffs()
        --HealBot_Aura_ClearAllDebuffs()
        HealBot_setOptions_Timer(30)
        HealBot_setOptions_Timer(50)
        HealBot_Action_SetAllAttribs()
    end
    if UnitIsUnit(button.unit, "player") then
        HealBot_Aura_ResetDebuffCache()
    end
    HealBot_Action_setPowerBars(button)
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
        HealBot_Action_SetClassIconTexture(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Action_SetClassIconTexture(xButton)
    end
end

local function HealBot_Options_Update()
    HealBot_Action_DeleteMarkedButtons()
    if HealBot_Options_Timer[2] then
        HealBot_OnEvent_PlayerEnteringWorld("OnUpdate")
        HealBot_Options_Timer[2]=nil
    elseif HealBot_Options_Timer[3] then
        HealBot_OnEvent_PlayerRegenDisabled()
        HealBot_Options_Timer[3]=nil
    elseif HealBot_Options_Timer[150] then
        HealBot_Skins_ResetSkin("init")
        HealBot_Options_Timer[150]=nil
    elseif HealBot_Options_Timer[5] then
        HealBot_Options_InitBuffList()
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
        HealBot_Options_Timer[15]=nil
    elseif  HealBot_Options_Timer[405] then
        HealBot_MountsPets_InitUse()
        HealBot_Options_Timer[405]=nil
    elseif  HealBot_Options_Timer[410] then
        HealBot_MountsPets_InitMount()
        HealBot_Options_Timer[410]=nil
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
    elseif HealBot_Options_Timer[35] then
        HealBot_Aura_SetUpdateIconFreq()
        HealBot_Options_Timer[35]=nil
    elseif HealBot_Options_Timer[60] then
        HealBot_Options_EmergencyFilter_Reset()
        HealBot_Options_Timer[60]=nil
    elseif HealBot_Options_Timer[80] then
        HealBot_Text_sethbNumberFormat()
        HealBot_Text_sethbAggroNumberFormat()
        HealBot_Action_ResetUnitStatus()
        HealBot_setOptions_Timer(595)
        HealBot_Options_Timer[80]=nil
    elseif HealBot_Options_Timer[85] then
        HealBot_Text_UpdateNames()
        HealBot_Action_ResetUnitStatus()
        HealBot_Options_Timer[85]=nil
    elseif HealBot_Options_Timer[90] then
        HealBot_SetSkinColours();
        HealBot_Options_Timer[90]=nil
    elseif HealBot_Options_Timer[95] then
        HealBot_Text_UpdateButtons()
        HealBot_Action_ResetUnitStatus()
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
        HealBot_AuraCheck()
        HealBot_Options_Timer[118]=nil
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
        HealBot_Aura_ConfigClassHoT()
        HealBot_setOptions_Timer(171)
        HealBot_Options_Timer[170]=nil
    elseif HealBot_Options_Timer[171] then
        HealBot_Aura_ResetBuffCache()
        HealBot_setOptions_Timer(30)
        HealBot_Options_Timer[171]=nil
    elseif HealBot_Options_Timer[172] then
        HealBot_Aura_setCustomBuffFilterDisabled()
        HealBot_setOptions_Timer(30)
        HealBot_Options_Timer[172]=nil
    elseif HealBot_Options_Timer[174] then
        HealBot_Options_setDebuffPriority()
        HealBot_setOptions_Timer(30)
        HealBot_Options_Timer[174]=nil
    elseif HealBot_Options_Timer[175] then
        HealBot_Aura_setCustomDebuffFilterCastBy()
        HealBot_setOptions_Timer(30)
        HealBot_Options_Timer[175]=nil
    elseif HealBot_Options_Timer[176] then
        HealBot_Aura_ResetDebuffCache()
        HealBot_setOptions_Timer(30)
        HealBot_Options_Timer[176]=nil
    elseif HealBot_Options_Timer[177] then
        HealBot_Aura_setCustomDebuffFilterDisabled()
        HealBot_setOptions_Timer(30)
        HealBot_Options_Timer[177]=nil
    elseif HealBot_Options_Timer[30] then
        HealBot_AuraCheck()
        HealBot_Options_Timer[30]=nil
    elseif HealBot_Options_Timer[50] then
        HealBot_Action_setpcClass()
        HealBot_Options_Timer[50]=nil
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
    elseif HealBot_Options_Timer[185] then
        if Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["HIDEBOSSF"] then
            HealBot_trackHiddenFrames["MINIBOSS"]=true
            HealBot_Options_DisableMiniBossFrame()
            if HealBot_luVars["ReloadUI"]>GetTime() and HealBot_luVars["showReloadMsg"] then
                HealBot_luVars["showReloadMsg"]=false
                HealBot_Options_ReloadUI(HEALBOT_OPTIONS_HIDEMINIBOSSFRAMES.." - "..HEALBOT_WORD_ON)
            end
        elseif HealBot_trackHiddenFrames["MINIBOSS"] and HealBot_luVars["showReloadMsg"] then
            HealBot_luVars["showReloadMsg"]=false
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
        local _,xButton,pButton = HealBot_UnitID("player")
        if xButton then
            HealBot_GetTalentInfo(xButton)
        end
        if pButton then
            HealBot_GetTalentInfo(pButton)
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
    elseif HealBot_Options_Timer[595] then
        HealBot_nextRecalcParty(0)
        HealBot_Options_Timer[595]=nil
    elseif HealBot_Options_Timer[596] then
        HealBot_nextRecalcParty(6)
        HealBot_Options_Timer[596]=nil
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
        HealBot_Aura_setLuVars("hbInsName", mapName)
        HealBot_Panel_setLuVars("MAPID", mapAreaID)
        HealBot_Options_SetEnableDisableCDBtn()
        HealBot_Options_SetEnableDisableBuffBtn()
        HealBot_SetAddonComms()
        HealBot_setOptions_Timer(7955)
        HealBot_setOptions_Timer(7960)
        HealBot_Options_Timer[7950]=nil
    elseif HealBot_Options_Timer[7955] then
        HealBot_Aura_SetBuffCheckFlags()
        HealBot_Options_Timer[7955]=nil
    elseif HealBot_Options_Timer[7960] then
        HealBot_setOptions_Timer(171)
        HealBot_setOptions_Timer(172)
        HealBot_setOptions_Timer(176)
        HealBot_setOptions_Timer(177)
        HealBot_Options_Timer[7960]=nil
    elseif HealBot_Options_Timer[7990] then
        HealBot_Options_Timer[7990]=nil
        HealBot_VersionUpdate_Spells()
    elseif HealBot_Options_Timer[8000] then
        HealBot_Options_Timer[8000]=HealBot_Options_idleInit()
        if HealBot_Options_Timer[8000] then
            HealBot_luVars["Timer8000"]=(HealBot_luVars["Timer8000"])+1
            HealBot_setqaFR()
        end
        if not HealBot_Options_Timer[8000] then
            HealBot_AddDebug("Timer 8000 called #"..HealBot_luVars["Timer8000"])
            HealBot_luVars["Timer8000"]=0
            HealBot_AuraCheck("player")
            HealBot_setOptions_Timer(595)
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
    elseif HealBot_Options_Timer[9930] then
        HealBot_Options_Timer[9930]=nil
        HealBot_Aura_ResetCache()
    elseif HealBot_Options_Timer[9940] then
        HealBot_Options_Timer[9940]=nil
        if HealBot_luVars["NoSpamOOM"]<TimeNow and 
          (((UnitPower("player", 0)/UnitPowerMax("player", 0))*100) < Healbot_Config_Skins.Chat[Healbot_Config_Skins.Current_Skin]["EOCOOMV"]) then
            HealBot_luVars["NoSpamOOM"]=TimeNow+75
            DoEmote(HEALBOT_EMOTE_OOM)
            --HealBot_AddDebug(HEALBOT_EMOTE_OOM.." - mPct="..((UnitPower("player", 0)/UnitPowerMax("player", 0))*100))
        end
    elseif HealBot_Options_Timer[9950] then
        HealBot_Options_Timer[9950]=nil
        HealBot_ResetClassIconTexture()
    elseif HealBot_Options_Timer[9960] then
        HealBot_Options_Timer[9960]=nil
        HealBot_Action_InitFrames()
        HealBot_ResetClassIconTexture()
    elseif HealBot_Options_Timer[9970] then
        HealBot_Options_Timer[9970]=nil
        HealBot_Options_BarFreq_setVars()
    elseif HealBot_Options_Timer[9980] then
        HealBot_Options_Timer[9980]=nil
        HealBot_nextRecalcParty(2)
    elseif HealBot_Options_Timer[9995] then
        HealBot_Options_Timer[9995]=nil
        HealBot_Options_RangeCheckFreq_setSession()
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

local utZ, utY=0,0
function HealBot_OnEvent_UnitThreat(button)
    if not UnitIsDeadOrGhost("player") and  UnitAffectingCombat(button.unit) then
        if not HealBot_Data["UILOCK"] then
            if HealBot_Panel_RaidUnitGUID(button.guid) and HealBot_Globals.EnAutoCombat and UnitIsVisible(button.unit) then
                utZ, utY=HealBot_CalcThreat(button)
                if (utY+utZ)>0 then 
                    HealBot_OnEvent_PlayerRegenDisabled()
                    if Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["SHOW"] then
                        HealBot_Action_UpdateAggro(button,true,utY,utZ,"")
                    end
                end
            end
        elseif Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][button.frame]["SHOW"] then
            HealBot_CheckAggroUnits(button)
        end
    end
    --HealBot_setCall("HealBot_OnEvent_UnitThreat")
end

local mhHealthPercent, mhHealthFactor=0,0
local function HealBot_MaxHealth()
    if UnitExists("boss1") then
        mhHealthPercent = select(15, UnitAura("boss1", HEALBOT_DEBUFF_AURA_OF_CONTEMPT))
        if mhHealthPercent then
            mhHealthFactor = mhHealthPercent / 100
            if mhHealthFactor~=HealBot_luVars["healthFactor"] then
                HealBot_luVars["healthFactor"]=mhHealthFactor
            end
        end
    end
end

local health,healthMax,bptc=0,0,0
function HealBot_OnEvent_UnitHealth(button)
    button.health.update=false
    button.health.updhealth=false
    if button.health.updincoming then HealBot_HealsInUpdate(button) end
    if button.health.updabsorbs then HealBot_AbsorbsUpdate(button) end
    if UnitExists(button.unit) then
        if UnitIsFeignDeath(button.unit) and UnitHealth(button.unit)==0 then
            health,healthMax=button.health.current,button.health.max
        elseif button.status.current<9 or not UnitIsDeadOrGhost(button.unit) then
            if HealBot_luVars["adjMaxHealth"] then HealBot_MaxHealth() end
            health,healthMax=UnitHealth(button.unit),(UnitHealthMax(button.unit) * HealBot_luVars["healthFactor"])
        else
            health=0
            healthMax=(UnitHealthMax(button.unit) * HealBot_luVars["healthFactor"])
        end
        if health>healthMax then health=healthMax end
        if (health~=button.health.current) or (healthMax~=button.health.max) then
            if HEALBOT_GAME_VERSION<4 then HealBot_OnEvent_UnitThreat(button) end
            if healthMax~=100 or not HealBot_Panel_RaidUnitGUID(button.guid) or button.health.max<200 then
                button.health.current=health
                button.health.max=healthMax
            end
            HealBot_OverHeal(button)
            HealBot_Action_UpdateHealthButton(button)
        elseif not Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["FLUIDBARS"] then
            bptc=floor((button.health.current/button.health.max)*100)
            if button.gref["Bar"]:GetValue()~=bptc then 
                HealBot_Action_UpdateHealthButton(button)
            end
        end
    end
    --HealBot_setCall("HealBot_OnEvent_UnitHealth")
end

local function HealBot_DoVehicleChange(button, enterVehicle)
    --HealBot_Text_setHealthText(button)
    local doRefresh=false
    if enterVehicle then
        local vUnit=HealBot_UnitPet(button.unit)
        if vUnit and UnitHasVehicleUI(button.unit) then
            local vButton=HealBot_Pet_Button[vUnit]
            if not HealBot_VehicleUnit[vUnit] then HealBot_VehicleUnit[vUnit]={} end
            HealBot_VehicleUnit[vUnit][button.unit]=true
            HealBot_UnitInVehicle[button.unit]=vUnit
            if vButton then 
                vButton.health.updhealth=true
                vButton.health.update=true 
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

local function HealBot_OnEvent_VehicleChange(self, unit, enterVehicle)
    local _,xButton,pButton = HealBot_UnitID(unit)
    if xButton then
        HealBot_DoVehicleChange(xButton, enterVehicle)
    end
    if pButton then
        HealBot_DoVehicleChange(pButton, enterVehicle)
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
    if HealBot_Data["UILOCK"] then HealBot_luVars["RaidTargetUpdate"]=true end
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
        HealBot_setOptions_Timer(30)
        HealBot_setOptions_Timer(7955)
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
    HealBot_Aura_SetBuffCheckFlags()
    HealBot_Action_CheckHideFrames()
    HealBot_Action_ResetActiveUnitStatus()
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["STATE"] then
        HealBot_setOptions_Timer(9980)
    end
    if HealBot_luVars["SoftResetAfterCombat"] then
        HealBot_luVars["SoftResetAfterCombat"]=false
        HealBot_setOptions_Timer(190)
        HealBot_SetResetFlag("QUICK")
    end
    if HealBot_Globals.DisableToolTipInCombat and HealBot_Data["TIPBUTTON"] then
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
    HealBot_EndInstanceEncounter()
    if Healbot_Config_Skins.Chat[Healbot_Config_Skins.Current_Skin]["EOCOOM"] then
        HealBot_setOptions_Timer(9940)
    end
    HealBot_OnEvent_PlayerTargetChanged(true)
    --HealBot_setCall("HealBot_Not_Fighting")
end

local function HealBot_OnEvent_DoReadyCheckClear(button, noAFK)
    if button.icon.debuff.readycheck then
        if noAFK then
            button.icon.debuff.readycheck=false
        elseif button.icon.debuff.readycheck == READY_CHECK_WAITING_TEXTURE then
            button.icon.debuff.readycheck = READY_CHECK_AFK_TEXTURE
        else
            button.icon.debuff.readycheck=false
        end
        button.aura.check=true
    end
end

local function HealBot_OnEvent_ReadyCheckClear(noAFK)
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_OnEvent_DoReadyCheckClear(xButton, noAFK)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_OnEvent_DoReadyCheckClear(xButton, noAFK)
    end
    --HealBot_setCall("HealBot_OnEvent_ReadyCheckClear")
end

local function HealBot_SetUnitDisconnect(button)
    if UnitIsConnected(button.unit) then
        button.status.offline=false
    elseif not button.status.offline then
        button.status.offline=TimeNow
    end
    HealBot_Text_setNameTag(button)
    HealBot_Action_Refresh(button)
end

local hbThrottleChecks={}
local hbThrottleCtl=TimeNow+0.1
HealBot_luVars["ThrottleFreq"]=HealBot_luVars["RangeCheckFreq"]
function HealBot_BumpThrottleCtl(button)
    if hbThrottleCtl<TimeNow+HealBot_luVars["ThrottleFreq"] then 
        hbThrottleCtl=TimeNow+HealBot_luVars["ThrottleFreq"]
    else
        hbThrottleCtl=hbThrottleCtl+HealBot_luVars["ThrottleFreq"]
    end
    button.status.throttle=hbThrottleCtl
end

local function HealBot_UnitSlowUpdateFriendly(button)
    HealBot_BumpThrottleCtl(button)
    if (button.status.offline and UnitIsConnected(button.unit)) or (not button.status.offline and not UnitIsConnected(button.unit)) then
        HealBot_SetUnitDisconnect(button)
    elseif not UnitOnTaxi("player") and button.aura.buff.nextcheck and button.aura.buff.nextcheck<TimeNow then
        if button.aura.buff.nextcheck==1 then
            HealBot_Aura_ResetCheckBuffsTime(button)
        else
            button.aura.check=true
            button.aura.buff.nextcheck=false
        end
    elseif button.mana.update then
        HealBot_OnEvent_UnitMana(button)
    elseif button.health.current<button.health.max then
        button.health.updhealth=true
        button.health.update=true
    end
end

local function HealBot_ProcessRefreshTypes()
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
end

local function HealBot_Update_Slow()
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
        elseif HealBot_luVars["HealBot_Options_Timer"] then
            HealBot_Options_Update()
        else
            HealBot_luVars["slowSwitch"]=HealBot_luVars["slowSwitch"]+1
            if HealBot_luVars["slowSwitch"]>3 then
                if HealBot_luVars["slowSwitch"]<5 then
                    HealBot_Action_DeleteMarkedButtons()
                elseif HealBot_luVars["slowSwitch"]<6 then
                    if HealBot_luVars["addonMsgTh"]<TimeNow then
                        HealBot_Comms_SendAddonMessage()
                        HealBot_luVars["addonMsgTh"]=TimeNow+2
                    end
                else
                    if not HealBot_luVars["onTaxi"] and UnitOnTaxi("player") then
                        HealBot_Aura_ClearAllBuffs()
                        HealBot_luVars["onTaxi"]=true
                    elseif HealBot_luVars["onTaxi"] and not UnitOnTaxi("player") then
                        HealBot_AuraCheck()
                        HealBot_luVars["onTaxi"]=false
                    else
                        HealBot_ProcessRefreshTypes()
                        HealBot_setqaFR()
                    end
                    HealBot_luVars["slowSwitch"]=0
                end     
            else
                if HealBot_luVars["slowSwitch"]<2 then
                    for xUnit,xGroup in pairs(HealBot_notVisible) do
                        if UnitIsVisible(xUnit) then
                            HealBot_nextRecalcParty(xGroup)
                            HealBot_notVisible[xUnit]=nil
                        end
                    end
                elseif HealBot_luVars["slowSwitch"]<3 then
                    if HealBot_luVars["rcEnd"] and HealBot_luVars["rcEnd"]<TimeNow then
                        HealBot_luVars["rcEnd"]=nil
                        HealBot_OnEvent_ReadyCheckClear(false)
                    elseif HealBot_DebugMsg[1] and (HealBot_luVars["nextDebugMsg"] or 0)<TimeNow then
                        HealBot_luVars["nextDebugMsg"]=TimeNow+1
                        HealBot_AddChat(HealBot_DebugMsg[1])
                        table.remove(HealBot_DebugMsg,1)
                    elseif HealBot_luVars["VersionRequest"] then
                        HealBot_Comms_SendAddonMsg(HEALBOT_HEALBOT, "S:"..HEALBOT_VERSION, HealBot_luVars["AddonMsgType"], HealBot_Data["PNAME"])
                        HealBot_luVars["VersionRequest"]=false;
                    end
                else
                    HealBot_Aura_BuffIdLookup()
                end
            end
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
    --HealBot_setCall("HealBot_Update_Slow")
end

local cau_z, cau_y=0,0
function HealBot_CheckAggroUnits(button)
    if UnitExists(button.unit) then
        cau_z, cau_y=HealBot_CalcThreat(button)
        if (cau_z+cau_y)==0 then
            HealBot_ClearUnitAggro(button)
        elseif cau_z~=button.aggro.threatpct then
            HealBot_Action_UpdateAggro(button,true,cau_y,cau_z,"")
        end
    else
        HealBot_ClearUnitAggro(button)
    end
    --HealBot_setCall("HealBot_CheckAggroUnits")
end

local hbCBLUevent, hbCBLUguid, hbCBLUnit, hbCBLbutton="","","",""
local function HealBot_ProcessCombatLog()
    if (hbCBLUevent=="SWING_DAMAGE" or hbCBLUevent=="SPELL_PERIODIC_DAMAGE" or hbCBLUevent=="SPELL_DAMAGE" or hbCBLUevent=="DAMAGE_SPLIT" or
        hbCBLUevent=="DAMAGE_SHIELD" or hbCBLUevent=="ENVIRONMENTAL_DAMAGE") and hbCBLbutton.health.current > 0 then
        hbCBLbutton.health.update=true
    elseif (hbCBLUevent=="SPELL_HEAL" or hbCBLUevent=="SPELL_PERIODIC_HEAL") and hbCBLbutton.health.current < hbCBLbutton.health.max then
        hbCBLbutton.health.update=true
    end
end

local function HealBot_OnEvent_Combat_Log()
    _, hbCBLUevent, _, _, _, _, _, hbCBLUguid = CombatLogGetCurrentEventInfo()
    hbCBLUnit=HealBot_Panel_RaidUnitGUID(hbCBLUguid)
    if hbCBLUnit then
        hbCBLbutton=HealBot_Unit_Button[hbCBLUnit]
        if hbCBLbutton and not hbCBLbutton.health.update then
            HealBot_ProcessCombatLog()
        end
        hbCBLbutton=HealBot_Private_Button[hbCBLUnit]
        if hbCBLbutton and not hbCBLbutton.health.update then
            HealBot_ProcessCombatLog()
        end
    end
  --HealBot_setCall("HealBot_OnEvent_Combat_Log")
end

local function HealBot_UnitUpdateButton(button)
    if UnitExists(button.unit) then
        if button.status.range<1 or not CheckInteractDistance(button.unit,1) then
            HealBot_UpdateUnitRange(button, true)
        end
        if button.guid~=UnitGUID(button.unit) or button.status.reserved or button.status.update then 
            button.status.reserved=false
            button.status.update=false
            HealBot_UpdateUnit(button) 
        elseif button.aura.check then
            HealBot_Aura_CheckUnitAuras(button)
        elseif button.health.update then
            HealBot_OnEvent_UnitHealth(button)
        elseif button.status.current==9 or UnitIsDeadOrGhost(button.unit) then
            HealBot_Action_UpdateTheDeadButton(button)
        elseif button.aggro.threatpct>0 then 
            HealBot_CheckAggroUnits(button) 
        elseif button.status.throttle<TimeNow then
            HealBot_UnitSlowUpdateFriendly(button)
        end
        if button.aura.buff.nextupdate<=TimeNow then HealBot_Aura_Update_UnitBuffIcons(button) end
        if button.aura.debuff.nextupdate<=TimeNow then HealBot_Aura_Update_UnitDebuffIcons(button) end
        if button.status.dirarrowshown then HealBot_Action_ShowDirectionArrow(button) end
    elseif not button.status.reserved then
        HealBot_UpdateUnit(button)
        button.status.reserved=true
    end
end

HealBot_luVars["aRefresh"]=false
local euName, euStartTime, euEndTime=false,0,0
local euDuration, euCast, euPct, euGUID=0,0,0, false
local function HealBot_EnemyUpdateButton(button)
    if UnitExists(button.unit) then
        euGUID=UnitGUID(button.unit) or button.unit
        if euGUID~=button.guid or button.status.reserved then
            button.guid=euGUID
            button.status.reserved=false
            HealBot_UpdateUnit(button)
        end
        if UnitIsDeadOrGhost(button.unit) then
            if UnitIsFriend("player",button.unit) then
                HealBot_Action_UpdateTheDeadButton(button)
            else
                button.health.current=0
                HealBot_Action_Refresh(button)
            end
        elseif HealBot_luVars["aRefresh"] then
            if HEALBOT_GAME_VERSION>3 and not UnitIsFriend("player",button.unit) then 
                euName, _, _, euStartTime, euEndTime = UnitCastingInfo(button.unit) 
                if euName and 1==0 then --Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][10]["POWERSIZE"]>0 then
                    if TimeNow+0.01>euEndTime and button.spells.castpct>-1 then
                        button.spells.castpct=-1
                        HealBot_Action_setPowerBars(button)
                    else
                        euDuration=euEndTime-euStartTime
                        euCast=((TimeNow*1000)-euStartTime)
                        euPct=ceil((euCast/euDuration)*1000)
                        if button.spells.castpct~=euPct then
                            button.spells.castpct=euPct
                            HealBot_Action_setPowerBars(button, euName)
                        end
                    end
                elseif button.spells.castpct>-1 then
                    button.spells.castpct = -1
                    HealBot_Action_setPowerBars(button)
                end
            end
            if button.status.unittype==11 then
                HealBot_OnEvent_UnitHealth(button)
                HealBot_HealsInUpdate(button)
                HealBot_AbsorbsUpdate(button)
            end
        else
            if HealBot_Config_Buffs.BuffWatch and Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWDEBUFF"] then
                if button.status.unittype==11 or button.aura.check then
                    if UnitIsFriend("player",button.unit) then
                        HealBot_Aura_CheckUnitAuras(button)
                    else
                        HealBot_Aura_RefreshEnemyAuras(button)
                    end
                end
            end
            if button.aura.debuff.nextupdate<=TimeNow then HealBot_Aura_Update_UnitDebuffIcons(button) end
            if UnitIsFriend("player",button.unit) then
                if button.aura.buff.nextupdate<=TimeNow then HealBot_Aura_Update_UnitBuffIcons(button) end
                if button.status.dirarrowshown then HealBot_Action_ShowDirectionArrow(button) end
            end
        end
        if HealBot_luVars["RaidTargetUpdate"] and button.status.unittype==11 then
            HealBot_OnEvent_RaidTargetUpdate(button)
        end
    elseif not button.status.reserved then
        HealBot_UpdateUnit(button)
        button.status.reserved=true
    end
end

function HealBot_Update_FastEveryFrame(numFrames)
    TimeNow=GetTime()
    HealBot_luVars["fastUpdateEveryFrame"]=numFrames
    if HealBot_Timers["fastUpdate"]>TimeNow then HealBot_Timers["fastUpdate"]=HealBot_Timers["fastUpdate"]-HealBot_Timers["fastUpdateFreq"] end
end

local function HealBot_Update_Fast()
    HealBot_luVars["fastSwitch"]=HealBot_luVars["fastSwitch"]+1
    if HealBot_luVars["fastSwitch"]<2 then
        for xUnit,_ in pairs(HealBot_Player_ButtonCache1) do
            if HealBot_Unit_Button[xUnit] then
                HealBot_UnitUpdateButton(HealBot_Unit_Button[xUnit])
            else
                HealBot_setOptions_Timer(596)
            end
        end
    elseif HealBot_luVars["fastSwitch"]<3 then
        for xUnit,_ in pairs(HealBot_Player_ButtonCache2) do
            if HealBot_Unit_Button[xUnit] then
                HealBot_UnitUpdateButton(HealBot_Unit_Button[xUnit])
            else
                HealBot_setOptions_Timer(596)
            end
        end
    elseif HealBot_luVars["fastSwitch"]<4 then
        for xUnit,_ in pairs(HealBot_Player_ButtonCache3) do
            if HealBot_Unit_Button[xUnit] then
                HealBot_UnitUpdateButton(HealBot_Unit_Button[xUnit])
            else
                HealBot_setOptions_Timer(596)
            end
        end
    elseif HealBot_luVars["fastSwitch"]<5 then
        for _,xButton in pairs(HealBot_Private_Button) do
            HealBot_UnitUpdateButton(xButton)
        end
    else
        for _,xButton in pairs(HealBot_Enemy_Button) do
            HealBot_EnemyUpdateButton(xButton)
        end
        for _,xButton in pairs(HealBot_Pet_Button) do
            HealBot_UnitUpdateButton(xButton)
        end
        HealBot_luVars["RaidTargetUpdate"]=false
        if HealBot_luVars["aRefresh"] then 
            HealBot_luVars["aRefresh"]=false
        else
            HealBot_luVars["aRefresh"]=true
        end
        HealBot_luVars["fastSwitch"]=0
    end
    if HealBot_luVars["MaskAuraReCheck"] then
        if HealBot_luVars["MaskAuraDCheck"]<=TimeNow then
            HealBot_luVars["MaskAuraReCheck"]=false
            HealBot_CheckAllActiveDebuffs()
            HealBot_Update_FastEveryFrame(4)
        elseif HealBot_Timers["fastUpdate"]>HealBot_luVars["MaskAuraDCheck"] then
            HealBot_Timers["fastUpdate"]=HealBot_luVars["MaskAuraDCheck"]
        end
    end
    --HealBot_setCall("HealBot_Update_Fast")
end

local auxAlpha={[1]=0.1,[2]=0.1,[3]=0.1,[4]=0.1,[5]=0.1,[6]=0.1,[7]=0.1,[8]=0.1,[9]=0.1,[10]=0.1}
local HealBot_Aux_Buttons={}
local HealBot_AuxStatic_Buttons={}
local HealBot_AuxFluid_Buttons={}
local sfabuActive=false
local function HealBot_UpdateFluidAuxBarsValue(button)  
    sfabuActive=false
    for x=1,9 do
        if button.aux[x]["FLUID"] then
            local barValue=button.gref.aux[x]:GetValue()
            if barValue>HealBot_AuxFluid_Buttons[button][x] then
                local setValue=barValue-HealBot_luVars["FLUIDFREQ"]
                if setValue<HealBot_AuxFluid_Buttons[button][x] then setValue=HealBot_AuxFluid_Buttons[button][x] end
                sfabuActive=true
                button.gref.aux[x]:SetValue(setValue)
            elseif barValue<HealBot_AuxFluid_Buttons[button][x] then
                local setValue=barValue+HealBot_luVars["FLUIDFREQ"]
                if setValue>HealBot_AuxFluid_Buttons[button][x] then setValue=HealBot_AuxFluid_Buttons[button][x] end
                sfabuActive=true
                button.gref.aux[x]:SetValue(setValue)
            else
                button.aux[x]["FLUID"]=false
            end
        end
    end
    --HealBot_setCall("HealBot_UpdateFluidAuxBarsValue")
    return sfabuActive
end

local sfabActive=false
local function HealBot_UpdateFluidAuxBars()
    sfabActive=false
    for xButton,_ in pairs(HealBot_AuxFluid_Buttons) do
        if not HealBot_UpdateFluidAuxBarsValue(xButton) then
            HealBot_AuxFluid_Buttons[xButton]=nil
        else
            sfabActive=true
        end
    end
    return sfabActive
end

function HealBot_setAuxBar(button, id, value, isFluid)
    if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["OTYPE"]==2 then
        button.aux[id]["A"]=auxAlpha[button.frame]
        button.aux[id]["FLASH"]=true
        HealBot_Aux_Buttons[button.unit]=button
    else
        if button.status.enabled then
            button.aux[id]["A"]=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"]
        else
            button.aux[id]["A"]=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["DISA"]
        end
        button.aux[id]["STATIC"]=true
        HealBot_AuxStatic_Buttons[button.unit]=button
    end
    if Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==2 then
        button.aux[id]["R"]=button.text.r
        button.aux[id]["G"]=button.text.g
        button.aux[id]["B"]=button.text.b
    elseif Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["COLOUR"]==3 then
        button.aux[id]["R"]=Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["R"]
        button.aux[id]["G"]=Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["G"]
        button.aux[id]["B"]=Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["B"]
        button.aux[id]["A"]=Healbot_Config_Skins.AuxBar[Healbot_Config_Skins.Current_Skin][id][button.frame]["A"]
    end
    if Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["FLUIDBARS"] and isFluid then
        button.aux[id]["FLUID"]=true
        if not HealBot_AuxFluid_Buttons[button] then HealBot_AuxFluid_Buttons[button]={} end
        HealBot_AuxFluid_Buttons[button][id]=value
    else
        button.gref.aux[id]:SetValue(value)
    end
    button.gref.aux[id]:SetStatusBarColor(button.aux[id]["R"], button.aux[id]["G"], button.aux[id]["B"], button.aux[id]["A"])
    --HealBot_setCall("HealBot_setAuxBar")
end

local hbStaticOn=false
function HealBot_UpdAuxBar(button)
    hbStaticOn=false
    for x=1,9 do
        if button.aux[x]["STATIC"] then
            hbStaticOn=true
            if button.status.enabled then
                button.aux[x]["A"]=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"]
            else
                button.aux[x]["A"]=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["DISA"]
            end
            button.gref.aux[x]:SetStatusBarColor(button.aux[x]["R"], button.aux[x]["G"], button.aux[x]["B"], button.aux[x]["A"])
        end
    end
    --HealBot_setCall("HealBot_DoUpdAuxBar")
    if not hbStaticOn and HealBot_AuxStatic_Buttons[button.unit] then
        HealBot_AuxStatic_Buttons[button.unit]=nil
    end
end

function HealBot_clearAuxBar(button, id)
    button.aux[id]["FLASH"]=false
    button.aux[id]["STATIC"]=false
    button.aux[id]["FLUID"]=false
    button.gref.aux[id]:SetStatusBarColor(1,1,1,0)
end

function HealBot_clearAllAuxBar(button)
    for x=1,9 do
        HealBot_clearAuxBar(button, x)
    end
    --HealBot_setCall("HealBot_clearAllAuxBar")
end

function HealBot_resetAllAuxBar()
    for _,xButton in pairs(HealBot_AuxStatic_Buttons) do
        for x=1,9 do
            if xButton.aux[x]["STATIC"] then
                xButton.aux[x]["STATIC"]=false
                xButton.gref.aux[x]:SetStatusBarColor(1,1,1,0)
            end
        end
    end
    for _,xButton in pairs(HealBot_Aux_Buttons) do
        for x=1,9 do
            if xButton.aux[x]["FLASH"] then
                xButton.aux[x]["FLASH"]=false
                xButton.gref.aux[x]:SetStatusBarColor(1,1,1,0)
            end
        end
    end
    for xButton,_ in pairs(HealBot_AuxFluid_Buttons) do
        for x=1,9 do
            if xButton.aux[x]["FLUID"] then
                xButton.aux[x]["FLUID"]=false
                xButton.gref.aux[x]:SetStatusBarColor(1,1,1,0)
            end
        end
    end
    --HealBot_setCall("HealBot_resetAllAuxBar")
end

local hbFlashOn=false
local function HealBot_DoUpdateVariableAuxBars(button)
    hbFlashOn=false
    for x=1,9 do
        if button.aux[x]["FLASH"] then
            button.gref.aux[x]:SetStatusBarColor(button.aux[x]["R"], button.aux[x]["G"], button.aux[x]["B"], auxAlpha[button.frame])
            hbFlashOn=true
        end
    end
    --HealBot_setCall("HealBot_DoUpdateVariableAuxBars")
    return hbFlashOn
end

local updateVariableAuxFrame={}
local updateVariableAux=false
local function HealBot_UpdateVariableAuxBars()
    for x=1,10 do
        updateVariableAuxFrame[x]=false
    end
    updateVariableAux=false
    for xUnit,xButton in pairs(HealBot_Aux_Buttons) do
        if HealBot_DoUpdateVariableAuxBars(xButton) then
            updateVariableAuxFrame[xButton.frame]=true
        else
            HealBot_Aux_Buttons[xUnit]=nil
        end
    end
    for x=1,10 do
        if updateVariableAuxFrame[x] then
            if HealBot_luVars["AuxAlphaUp"] then
                auxAlpha[x]=auxAlpha[x]+0.01+Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][x]["OFREQ"]
                if auxAlpha[x]>=Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][x]["OMAX"] then 
                    HealBot_luVars["AuxAlphaUp"]=false
                    auxAlpha[x]=Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][x]["OMAX"]
                end
            else
                auxAlpha[x]=auxAlpha[x]-0.01-Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][x]["OFREQ"]
                if auxAlpha[x]<=Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][x]["OMIN"] then
                    HealBot_luVars["AuxAlphaUp"]=true
                    auxAlpha[x]=Healbot_Config_Skins.AuxBarFrame[Healbot_Config_Skins.Current_Skin][x]["OMIN"]
                end
            end
            updateVariableAux=true
        end
    end
    return updateVariableAux
end

local ouRegenEnabled, ouZ, ouY=true,0,0
function HealBot_OnUpdate(self)
    if HealBot_luVars["hbReady"] then
        TimeNow=GetTime()
        if HealBot_Timers["barsUpdate"]<TimeNow and not HealBot_luVars["TestBarsOn"] then
            HealBot_UpdateVariableAuxBars()
            HealBot_Action_UpdateFluidBar()
            HealBot_UpdateFluidAuxBars()
            if HealBot_luVars["ouTipUpdate"] and HealBot_luVars["PrevTipTime"]<TimeNow then 
                HealBot_luVars["PrevTipTime"]=HealBot_luVars["PrevTipTime"]+HealBot_luVars["TipUpdateFreq"]
                HealBot_Action_RefreshTooltip()
            end
            HealBot_Timers["barsUpdate"]=TimeNow+HealBot_Timers["barsUpdateFreq"]
        elseif HealBot_Timers["slowUpdate"]<TimeNow then
            if HealBot_luVars["TestBarsOn"] then
                HealBot_Timers["slowUpdate"]=TimeNow+(HealBot_Timers["fastUpdateFreq"]*0.5)
            else
                HealBot_Timers["slowUpdate"]=TimeNow+HealBot_Timers["slowUpdateFreq"]
            end
            HealBot_Update_Slow()
        elseif HealBot_Timers["fastUpdate"]<TimeNow then
            if HealBot_luVars["fastUpdateEveryFrame"]>0 then
                HealBot_luVars["fastUpdateEveryFrame"]=HealBot_luVars["fastUpdateEveryFrame"]-1
            else
                HealBot_Timers["fastUpdate"]=HealBot_Timers["fastUpdate"]+HealBot_Timers["fastUpdateFreq"]
                if not InCombatLockdown() then
                    if HealBot_luVars["reCheckActionFrames"] then
                        HealBot_luVars["reCheckActionFrames"]=false
                        HealBot_Action_CheckFrameSetPoint()
                    else
                        HealBot_ProcessRefreshTypes()
                    end
                    if HealBot_Data["UILOCK"] then
                        if HealBot_luVars["DelayLockdownCheck"]<TimeNow then
                            ouRegenEnabled=true
                            if HealBot_Globals.EnAutoCombat then
                                for xUnit,xButton in pairs(HealBot_Private_Button) do
                                    if UnitIsVisible(xUnit) then
                                        HealBot_CheckAggroUnits(xButton)
                                        if xButton.aggro.threatpct>0 then 
                                            ouRegenEnabled=false
                                            break
                                        end
                                    end
                                end
                                if ouRegenEnabled then
                                    for xUnit,xButton in pairs(HealBot_Unit_Button) do
                                        if UnitIsVisible(xUnit) and not HealBot_Private_Button[xUnit] then
                                            HealBot_CheckAggroUnits(xButton)
                                            if xButton.aggro.threatpct>0 then 
                                                ouRegenEnabled=false
                                                break
                                            end
                                        end
                                    end
                                end
                            end
                            if ouRegenEnabled then
                                HealBot_Not_Fighting()
                            else
                                HealBot_luVars["DelayLockdownCheck"]=TimeNow+1
                            end
                        end
                    end
                end
            end
            if not HealBot_luVars["TestBarsOn"] then 
                HealBot_Update_Fast() 
            end
        end
    elseif HealBot_luVars["hbLoaded"] and not InCombatLockdown() then
        HealBot_Options_Update()
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
        libCTM = libCTM or HealBot_Libs_CTM()
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
        libCHC = libCHC or HealBot_Libs_CHC()
        
        if libCHC then
            libCHC.RegisterCallback(HEALBOT_HEALBOT, "HealComm_HealStarted", 
                function(event, casterGUID, spellID, healType, endTime, ...) 
                HealBotClassic_HealsInUpdate(true, spellID, ...) end)
                
            libCHC.RegisterCallback(HEALBOT_HEALBOT, "HealComm_HealUpdated", 
                function(event, casterGUID, spellID, healType, endTime, ...) 
                HealBotClassic_HealsInUpdate(true, spellID, ...) end)
                
            libCHC.RegisterCallback(HEALBOT_HEALBOT, "HealComm_HealDelayed", 
                function(event, casterGUID, spellID, healType, endTime, ...) 
                HealBotClassic_HealsInUpdate(true, spellID, ...) end)
                
            libCHC.RegisterCallback(HEALBOT_HEALBOT, "HealComm_HealStopped", 
                function(event, casterGUID, spellID, healType, interrupted, ...) 
                HealBotClassic_HealsInUpdate(interrupted, spellID, ...) end)

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
    HealBot:RegisterEvent("UNIT_POWER_FREQUENT")
    HealBot:RegisterEvent("UNIT_DISPLAYPOWER")
    HealBot:RegisterEvent("UNIT_MAXPOWER")
    --HealBot_setCall("HealBot_Register_Mana")
end

function HealBot_UnRegister_Mana()
    HealBot:UnregisterEvent("UNIT_POWER_UPDATE")
    HealBot:UnregisterEvent("UNIT_POWER_FREQUENT")
    HealBot:UnregisterEvent("UNIT_DISPLAYPOWER")
    HealBot:UnregisterEvent("UNIT_MAXPOWER")
    --HealBot_setCall("HealBot_UnRegister_Mana")
end

local ctZ, ctY, ctEnemyUnit=0,0,false
function HealBot_CalcThreat(button)
    ctZ,ctY,ctEnemyUnit=0,0,false
    if UnitIsFriend("player",button.unit) and button.status.current<9 then
        if UnitExists(button.unit.."target") and UnitIsEnemy(button.unit, button.unit.."target") then 
            if UnitIsUnit(button.unit, button.unit.."targettarget") then
                ctZ=100
            else
                ctEnemyUnit=button.unit.."target"
            end
        elseif UnitExists(HealBot_luVars["TankUnit"]) and UnitExists(HealBot_luVars["TankUnit"].."target") and 
               UnitIsEnemy(HealBot_luVars["TankUnit"], HealBot_luVars["TankUnit"].."target") then 
            if UnitIsUnit(button.unit, HealBot_luVars["TankUnit"].."targettarget") then
                ctZ=100
            else
                ctEnemyUnit=HealBot_luVars["TankUnit"].."target"
            end
        elseif UnitExists("target") and UnitIsEnemy("player", "target") then 
            if UnitIsUnit(button.unit, "playertargettarget") then
                ctZ=100
            else
                ctEnemyUnit="target"
            end
        elseif UnitExists("boss1") and UnitIsEnemy("player", "boss1") then 
            if UnitIsUnit(button.unit, "boss1target") then
                ctZ=100
            else
                ctEnemyUnit="boss1"
            end
        elseif UnitExists("boss2") and UnitIsEnemy("player", "boss2") then 
            if UnitIsUnit(button.unit, "boss2target") then
                ctZ=100
            else
                ctEnemyUnit="boss2"
            end
        end
        if ctEnemyUnit then
            if HEALBOT_GAME_VERSION>3 then
                _, _, ctZ, _, _ = UnitDetailedThreatSituation(button.unit, ctEnemyUnit)
                ctY = UnitThreatSituation(button.unit, ctEnemyUnit)
            elseif libCTM then
                _, _, ctZ, _, _ = libCTM:UnitDetailedThreatSituation(button.unit, ctEnemyUnit)
                ctY = libCTM:UnitThreatSituation(button.unit, ctEnemyUnit)
            end
            ctZ=floor(ctZ or 0)
        elseif ctZ==0 then
            if HEALBOT_GAME_VERSION>3 then
                ctY = UnitThreatSituation(button.unit)
            elseif libCTM then
                ctY = libCTM:UnitThreatSituation(button.unit, ctEnemyUnit)
            end
        end
        if not ctY then ctY=0 end
        if ctZ>=HealBot_Globals.aggro3pct then
            ctY=3
            if ctZ>100 then ctZ=100 end
        elseif ctZ>=HealBot_Globals.aggro2pct and ctY<2 then
            ctY=2 
        elseif ctZ>0 and ctY<1 then
            ctY=1
        end
    end
    --HealBot_setCall("HealBot_CalcThreat")
    return ctZ, ctY
end

local noName=false
local function HealBot_UnitNameOnly(unitName)
    local noName=false
    if unitName then
        noName=strtrim(string.match(unitName, "^[^-]*"))
    end
    --HealBot_setCall("HealBot_UnitNameOnly")
    return noName
end

local amIncMsg, amSenderId=false,false
local function HealBot_OnEvent_AddonMsg(self,addon_id,msg,distribution,sender_id)
    amIncMsg=msg
    amSenderId = HealBot_UnitNameOnly(sender_id)
    if amSenderId and amIncMsg and addon_id==HEALBOT_HEALBOT then
        local datatype, datamsg = string.split(":", amIncMsg)
        if datatype=="R" then
            HealBot_luVars["VersionRequest"]=amSenderId
        elseif datatype=="S" then
            HealBot_Vers[amSenderId]=datamsg
            HealBot_AddDebug("AddonMsg S="..amSenderId..":"..datamsg);
            HealBot_Comms_CheckVer(amSenderId, datamsg)
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
        elseif datatype=="H" then
            HealBot_Vers[amSenderId]=datamsg
            HealBot_AddDebug("AddonMsg H="..amSenderId..":"..datamsg);
            HealBot_Options_setMyGuildMates(amSenderId)
            HealBot_Comms_CheckVer(amSenderId, datamsg)
        elseif datatype=="C" then
            HealBot_Vers[amSenderId]=datamsg
            HealBot_AddDebug("AddonMsg C="..amSenderId..":"..datamsg);
            HealBot_Options_setMyFriends(amSenderId)
            HealBot_Comms_CheckVer(amSenderId, datamsg)
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
        local xUnit,xButton,pButton = HealBot_UnitID(unit)
        if xUnit and HealBot_UnitInVehicle[xUnit] then
            if xButton then HealBot_CheckAggroUnits(xButton) end
            if pButton then HealBot_CheckAggroUnits(pButton) end
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
    button.aura.check=true
    HealBot_Update_FastEveryFrame(4)
    --HealBot_setCall("HealBot_OnEvent_UnitAura")
end

local function HealBot_UpdateAllHealth()
    for _,xButton in pairs(HealBot_Unit_Button) do
        xButton.health.updhealth=true
        xButton.health.update=true
    end
    for _,xButton in pairs(HealBot_Private_Button) do
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
        if doRecalc then
            if not HealBot_Data["UILOCK"] then
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
            HealBot_RecalcParty(3)
        else
            local xButton=HealBot_Unit_Button["target"]
            if xButton then 
                if HealBot_luVars["TargetNeedReset"] then
                    HealBot_RecalcParty(3)
                elseif not InCombatLockdown() then
                    if UnitExists(xButton.unit) and HealBot_Panel_validTarget(xButton.unit) then
                        if not HealBot_FrameVisible[8] then HealBot_Action_ShowPanel(8) end
                    elseif HealBot_FrameVisible[8] then
                        HealBot_Action_HidePanel(8)
                    end
                end
                HealBot_UpdateUnit(xButton)
                if UnitExists(xButton.unit) and not HealBot_Player_ButtonCache1[xButton.unit] 
                                            and not HealBot_Player_ButtonCache2[xButton.unit]
                                            and not HealBot_Player_ButtonCache3[xButton.unit] then
                    HealBot_AddPlayerButtonCache(xButton.unit, 1)
                end
            else
                HealBot_RecalcParty(3)
            end
        end
    elseif HealBot_FrameVisible[8] then
        if not InCombatLockdown() then 
            HealBot_Action_HidePanel(8) 
        else
            HealBot_RecalcParty(3)
        end
    end
    --HealBot_setCall("HealBot_OnEvent_PlayerTargetChanged")
end

local function HealBot_DoClearLowMana(button)
    button.gref.icon["Icontm1"]:SetAlpha(0)
    button.gref.icon["Icontm2"]:SetAlpha(0)
    button.gref.icon["Icontm3"]:SetAlpha(0)
end

local function HealBot_ClearLowMana()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_DoClearLowMana(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_DoClearLowMana(xButton)
    end
    --HealBot_setCall("HealBot_ClearLowMana")
end

function HealBot_OnEvent_PlayerRegenDisabled()
    if not HealBot_Data["PGUID"] then
        HealBot_setOptions_Timer(3)  
        HealBot_luVars["SoftResetAfterCombat"]=true
    else
        HealBot_Data["UILOCK"]=true
        HealBot_luVars["DelayLockdownCheck"]=TimeNow+0.4
        if HealBot_RefreshTypes[0] then
                HealBot_RecalcParty(0)
        else
            if HealBot_RefreshTypes[6] then HealBot_RecalcParty(6); end
            if HealBot_RefreshTypes[1] then HealBot_RecalcParty(1); end
            if HealBot_RefreshTypes[2] then HealBot_RecalcParty(2); end
            HealBot_RecalcParty(5);
        end
        if HealBot_Globals.DisableToolTipInCombat and HealBot_Data["TIPBUTTON"] then
            HealBot_Action_HideTooltipFrame()
        end
        for xUnit,xButton in pairs(HealBot_Unit_Button) do
            if not HealBot_FrameVisible[xButton.frame] and UnitExists(xUnit) then
                HealBot_Action_ShowPanel(xButton.frame)
            end
        end
        for xUnit,xButton in pairs(HealBot_Private_Button) do
            if not HealBot_FrameVisible[xButton.frame] and UnitExists(xUnit) then
                HealBot_Action_ShowPanel(xButton.frame)
            end
        end
        for xUnit,xButton in pairs(HealBot_Pet_Button) do
            if not HealBot_FrameVisible[xButton.frame] and UnitExists(xUnit) then
                HealBot_Action_ShowPanel(xButton.frame)
            end
        end
        HealBot_Aura_SetBuffCheckFlags()
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["STATE"] then
            if Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["FOCUSINCOMBAT"]==1 then
                HealBot_Action_HidePanel(9)
            elseif HealBot_RefreshTypes[4] or Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["FOCUSINCOMBAT"]==3 then
                if HealBot_RefreshTypes[4] or not HealBot_Unit_Button["focus"] then
                    HealBot_RecalcParty(4)
                else
                    HealBot_Action_ShowPanel(9)
                end
            end
        elseif HealBot_FrameVisible[9] then
            HealBot_Action_HidePanel(9)
        end
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][9]["STATE"] then
            if Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TARGETINCOMBAT"]==1 then
                HealBot_Action_HidePanel(8)
            elseif HealBot_RefreshTypes[3] or Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TARGETINCOMBAT"]==3 then
                if HealBot_RefreshTypes[3] or not HealBot_Unit_Button["target"] then
                    HealBot_RecalcParty(3)
                else
                    HealBot_Action_ShowPanel(8)
                end
            end
        elseif HealBot_FrameVisible[8] then
            HealBot_Action_HidePanel(8)
        end
        if not HealBot_luVars["hlPlayerBarsIC"] and HealBot_luVars["HighlightTarget"] then
            HealBot_OnEvent_PlayerTargetChanged(false)
        end
        if not Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["LOWMANACOMBAT"] then HealBot_ClearLowMana() end
        HealBot_Action_ResetUnitStatus()
    end
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

function HealBot_AuraCheck(unit)
    if unit then
        local xButton = HealBot_Unit_Button[unit] or HealBot_Pet_Button[unit]
        if xButton then
            xButton.aura.check=true
        end
        xButton = HealBot_Private_Button[unit]
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
end

local guName, guGUID=false, 0
function HealBot_GetUnitName(unit, hbGUID)
    guName=false
    if unit and UnitExists(unit) then
        guGUID=hbGUID or "0"
        guName=HealBot_customTempUserName[xGUID] or UnitName(unit)
    end
    --HealBot_setCall("HealBot_GetUnitName")
    return guName
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
    HealBot_nextRecalcParty(6)
    if HealBot_Data["UILOCK"] then 
        HealBot_luVars["SoftResetAfterCombat"]=true 
        HealBot_setOptions_Timer(9950)
    else
        HealBot_setOptions_Timer(190)
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

local function HealBot_OnEvent_ReadyCheckDoUpdate(button,response)
    if HealBot_luVars["rcEnd"] and button and Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWRC"] then 
        if response then
            button.icon.debuff.readycheck=READY_CHECK_READY_TEXTURE --"Interface\\RAIDFRAME\\ReadyCheck-Ready"
        else
            button.icon.debuff.readycheck=READY_CHECK_NOT_READY_TEXTURE --"Interface\\RAIDFRAME\\ReadyCheck-NotReady"
        end
        button.aura.check=true
    end
end

local function HealBot_OnEvent_ReadyCheckUpdate(unit,response)
    if HealBot_Unit_Button[unit] then HealBot_OnEvent_ReadyCheckDoUpdate(HealBot_Unit_Button[unit],response) end
    if HealBot_Private_Button[unit] then HealBot_OnEvent_ReadyCheckDoUpdate(HealBot_Private_Button[unit],response) end
    --HealBot_setCall("HealBot_OnEvent_ReadyCheckUpdate")
end

function HealBot_OnEvent_ReadyCheck(self,unitName,timer)
    if HealBot_UnitNameOnly(unitName) then
        local lUnit=HealBot_Panel_RaidUnitName(HealBot_UnitNameOnly(unitName))
        HealBot_luVars["rcEnd"]=GetTime()+timer
        for _,xButton in pairs(HealBot_Unit_Button) do
            if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][xButton.frame]["SHOWRC"] then 
                xButton.icon.debuff.readycheck=READY_CHECK_WAITING_TEXTURE
                xButton.aura.check=true
            end
        end
        for _,xButton in pairs(HealBot_Private_Button) do
            if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][xButton.frame]["SHOWRC"] then 
                xButton.icon.debuff.readycheck=READY_CHECK_WAITING_TEXTURE
                xButton.aura.check=true
            end
        end
        if lUnit and (HealBot_Unit_Button[lUnit] or HealBot_Private_Button[lUnit]) then HealBot_OnEvent_ReadyCheckUpdate(lUnit,true) end
    end
    --HealBot_setCall("HealBot_OnEvent_ReadyCheck")
end

local function HealBot_OnEvent_ReadyCheckConfirmed(self,unit,response)
    local xUnit = HealBot_UnitID(unit)
    if HealBot_Unit_Button[xUnit] or HealBot_Private_Button[xUnit] then HealBot_OnEvent_ReadyCheckUpdate(xUnit,response) end
    --HealBot_setCall("HealBot_OnEvent_ReadyCheckConfirmed")
end

function HealBot_RaidTargetToggle(switch)
    if switch then
        HealBot:RegisterEvent("RAID_TARGET_UPDATE")
        HealBot_OnEvent_RaidTargetUpdateAll()
    else
        HealBot:UnregisterEvent("RAID_TARGET_UPDATE")
        for xUnit,xButton in pairs(HealBot_Unit_Button) do
            HealBot_Aura_RaidTargetUpdate(xButton,0)
        end
        for xUnit,xButton in pairs(HealBot_Private_Button) do
            HealBot_Aura_RaidTargetUpdate(xButton,0)
        end
        for xUnit,xButton in pairs(HealBot_Enemy_Button) do
            HealBot_Aura_RaidTargetUpdate(xButton,0)
        end
        for xUnit,xButton in pairs(HealBot_Pet_Button) do
            HealBot_Aura_RaidTargetUpdate(xButton,0)
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
            elseif not InCombatLockdown() then
                if HealBot_Panel_validFocus() then
                    if not HealBot_FrameVisible[9] then
                        HealBot_Action_ShowPanel(9)
                    end
                elseif HealBot_FrameVisible[9] then 
                    HealBot_Action_HidePanel(9)
                end
            end
            HealBot_UpdateUnit(xButton)
            if UnitExists(xButton.unit) and not HealBot_Player_ButtonCache1[xButton.unit] 
                                        and not HealBot_Player_ButtonCache2[xButton.unit]
                                        and not HealBot_Player_ButtonCache3[xButton.unit] then
                HealBot_AddPlayerButtonCache(xButton.unit, 2)
            end
        else
            HealBot_RecalcParty(4)
        end
    elseif HealBot_FrameVisible[9] then
        if InCombatLockdown() then
            HealBot_RecalcParty(4)
        else
            HealBot_Action_HidePanel(9)
        end
    end
    --HealBot_setCall("HealBot_OnEvent_FocusChanged")
end

function HealBot_OnEvent_TalentsChanged(button)
    button.spec = " "
    HealBot_GetTalentInfo(button)
    --HealBot_setCall("HealBot_OnEvent_TalentsChanged")
end

function HealBot_OnEvent_SpellsChanged(self, arg1)
    if arg1==0 then return; end
    if UnitIsDeadOrGhost("player") then return end
    HealBot_setOptions_Timer(550)
    --HealBot_setCall("HealBot_OnEvent_SpellsChanged")
end

function HealBot_OnEvent_PlayerEnteringWorld(hbCaller)
    TimeNow=GetTime()
    if HealBot_FrameVisible[8] then
        if InCombatLockdown() then
            HealBot_RecalcParty(3)
        else
            HealBot_Action_HidePanel(8)
        end
    end
    if HealBot_FrameVisible[9] then
        if InCombatLockdown() then
            HealBot_RecalcParty(4)
        else
            HealBot_Action_HidePanel(9)
        end
    end

    if hbCaller=="Event" then 
        HealBot_SetResetFlag("QUICK") 
        HealBot_luVars["qaFRNext"]=TimeNow+10
    end
    
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
    HealBot_setOptions_Timer(9930)
    HealBot_setOptions_Timer(595)
    if HealBot_luVars["AuraEventRegistered"] then HealBot_luVars["hbReady"]=true end
    collectgarbage()
    --HealBot_setCall("HealBot_OnEvent_PlayerEnteringWorld")
end

function HealBot_OnEvent_PlayerLeavingWorld(self)
    HealBot_luVars["qaFRNext"]=TimeNow+120
    if HealBot_Config.Profile==2 then
        HealBot_Options_hbProfile_saveClass()
    end
    HealBot_EndAggro() 
    HealBot_luVars["hbReady"]=false
    HealBot_UnRegister_Events();
    --HealBot_setCall("HealBot_OnEvent_PlayerLeavingWorld")
end

local HealBot_UnitIsRessing={}
local ucsButton,ucsPrivate=false,false
local function HealBot_OnEvent_UnitSpellCastStart(unit)
    if HealBot_UnitIsRessing[unit] then
        if HealBot_UnitIsRessing[unit]==HEALBOT_OPTIONS_GROUPHEALS then
            HealBot_Action_Refresh()
        else
            if HealBot_Unit_Button[HealBot_UnitIsRessing[unit]] then
                HealBot_Action_Refresh(HealBot_Unit_Button[HealBot_UnitIsRessing[unit]]) 
            end
            if HealBot_Private_Button[HealBot_UnitIsRessing[unit]] then
                HealBot_Action_Refresh(HealBot_Private_Button[HealBot_UnitIsRessing[unit]]) 
            end
        end
        --HealBot_AddDebug(unit.." is ressing "..HealBot_UnitIsRessing[unit])
        HealBot_UnitIsRessing[unit]=false
    elseif HEALBOT_GAME_VERSION<4 then
        local _,ucsButton,ucsPrivate = HealBot_UnitID(unit)
        if ucsButton then
            HealBot_OnEvent_UnitThreat(ucsButton)
        end
        if ucsPrivate then
            HealBot_OnEvent_UnitThreat(ucsPrivate)
        end
    end
end

local uscUnit, uscButton, uscUnitName, uscSpellName=false,false,false,false
local function HealBot_OnEvent_UnitSpellCastSent(self,caster,unitName,castGUID,spellID)
    uscUnit=false
    uscUnitName = HealBot_UnitNameOnly(unitName)
    uscSpellName = GetSpellInfo(spellID) or spellID

    if caster=="player" and uscUnitName == HEALBOT_WORDS_UNKNOWN then
        uscUnitName = HealBot_GetCorpseName(uscUnitName)
    end
    if uscUnitName=="" then
        if spellID==HEALBOT_MENDPET and UnitExists("pet") then
            uscUnitName=HealBot_GetUnitName("pet")
            uscUnit="pet"
        end
    elseif UnitExists(HealBot_luVars["TargetUnitID"]) and UnitName(HealBot_luVars["TargetUnitID"])==uscUnitName then
        uscUnit=HealBot_luVars["TargetUnitID"]
    else
        uscUnit=HealBot_Panel_RaidUnitName(HealBot_UnitNameOnly(uscUnitName))
    end
    if uscUnit and UnitExists(uscUnit) and uscUnitName then
        if caster=="player" then
            _,uscButton,uspButton=HealBot_UnitID(uscUnit)
            if uscButton and Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][uscButton.frame]["OVERHEAL"]<3 then
                HealBot_luVars["overhealUnit"]=uscUnit
                HealBot_luVars["overhealCastID"]=castGUID
                HealBot_luVars["overhealAmount"]=0
            elseif uspButton and Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][uspButton.frame]["OVERHEAL"]<3 then
                HealBot_luVars["overhealUnit"]=uscUnit
                HealBot_luVars["overhealCastID"]=castGUID
                HealBot_luVars["overhealAmount"]=0
            end
            if Healbot_Config_Skins.Chat[Healbot_Config_Skins.Current_Skin]["NOTIFY"]>1 then
                if Healbot_Config_Skins.Chat[Healbot_Config_Skins.Current_Skin]["RESONLY"] then
                    if HealBot_ResSpells[uscSpellName] then
                        if HealBot_ResSpells[uscSpellName]==2 then           
                            HealBot_CastNotify(HEALBOT_OPTIONS_GROUPHEALS,uscSpellName,uscUnit)
                            HealBot_UnitIsRessing[caster]=HEALBOT_OPTIONS_GROUPHEALS
                        else
                            HealBot_CastNotify(uscUnitName,uscSpellName,uscUnit)
                            HealBot_UnitIsRessing[caster]=uscUnit
                        end
                    end
                elseif HealBot_Spell_Names[uscSpellName] then
                    HealBot_CastNotify(uscUnitName,uscSpellName,uscUnit)
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
    for x,_ in pairs(HealBot_SmartCast_Spells) do
        HealBot_SmartCast_Spells[x]=nil;
    end
  
    HealBot_Init_Spells_Defaults();

    if HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_PRIEST] then
        if HealBot_KnownSpell(HEALBOT_HEAL) then
            HealBot_SmartCast_Spells[GetSpellInfo(HEALBOT_HEAL)]="L"
        elseif HealBot_KnownSpell(HBC_HEAL) then
            HealBot_SmartCast_Spells[GetSpellInfo(HBC_HEAL)]="L"
        end
        if HealBot_KnownSpell(HEALBOT_FLASH_HEAL) then
            HealBot_SmartCast_Spells[GetSpellInfo(HEALBOT_FLASH_HEAL)]="S"
        end
	elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_DRUID] then
        if HealBot_KnownSpell(HEALBOT_HEALING_TOUCH) then
            HealBot_SmartCast_Spells[GetSpellInfo(HEALBOT_HEALING_TOUCH)]="L"
        end
        if HealBot_KnownSpell(HEALBOT_REJUVENATION) then
            HealBot_SmartCast_Spells[GetSpellInfo(HEALBOT_REJUVENATION)]="S"
        end
    elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_PALADIN] then
        if HealBot_KnownSpell(HEALBOT_HOLY_LIGHT) then
            HealBot_SmartCast_Spells[GetSpellInfo(HEALBOT_HOLY_LIGHT)]="L"
        elseif HealBot_KnownSpell(HBC_HOLY_LIGHT) then
            HealBot_SmartCast_Spells[GetSpellInfo(HBC_HOLY_LIGHT)]="L"
        end
        if HealBot_KnownSpell(HEALBOT_FLASH_OF_LIGHT) then
            HealBot_SmartCast_Spells[GetSpellInfo(HEALBOT_FLASH_OF_LIGHT)]="S"
        end
    elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_SHAMAN] then
        if HealBot_KnownSpell(HEALBOT_HEALING_SURGE) then
            HealBot_SmartCast_Spells[GetSpellInfo(HEALBOT_HEALING_SURGE)]="S"
        elseif HealBot_KnownSpell(HBC_LESSER_HEALING_WAVE) then
            HealBot_SmartCast_Spells[GetSpellInfo(HBC_LESSER_HEALING_WAVE)]="S"
        end
        if HealBot_KnownSpell(HEALBOT_HEALING_WAVE) then
            HealBot_SmartCast_Spells[GetSpellInfo(HEALBOT_HEALING_WAVE)]="L"
        elseif HealBot_KnownSpell(HBC_HEALING_WAVE) then
            HealBot_SmartCast_Spells[GetSpellInfo(HBC_HEALING_WAVE)]="L"
        end
    elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_MONK] then
        if HealBot_KnownSpell(HEALBOT_ENVELOPING_MIST) then
            HealBot_SmartCast_Spells[GetSpellInfo(HEALBOT_ENVELOPING_MIST)]="L"
        end
        if HealBot_KnownSpell(HEALBOT_REVIVAL) then
            HealBot_SmartCast_Spells[GetSpellInfo(HEALBOT_REVIVAL)]="S"
        elseif HealBot_KnownSpell(HEALBOT_SOOTHING_MIST) then
            HealBot_SmartCast_Spells[GetSpellInfo(HEALBOT_SOOTHING_MIST)]="S"
        elseif HealBot_KnownSpell(HEALBOT_UPLIFT) then
            HealBot_SmartCast_Spells[GetSpellInfo(HEALBOT_UPLIFT)]="S"
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

function HealBot_SmartCast(hlthDelta)
    local s=nil
    if HEALBOT_GAME_VERSION>3 then
        for sName,sType in pairs(HealBot_SmartCast_Spells) do
            if hlthDelta>58 then
                if sType~="L" then
                    s=sName
                end
            else
                if sType=="L" then
                    s=sName
                elseif not s then
                    s=sName
                end
            end
        end
    else
        for sName,sType in pairs(HealBot_SmartCast_Spells) do
            if hlthDelta>58 then
                local sRank=floor((98-hlthDelta)/5)
                if sType~="L" then
                    if sRank==0 then sRank=1 end
                    s=HealBot_Init_Spells_retRank(sName, sRank)
                end
            else
                local sRank=floor((75-hlthDelta)/8)
                if sRank==0 then sRank=1 end
                if sType=="L" then
                    s=HealBot_Init_Spells_retRank(sName, sRank)
                elseif not s then
                    s=HealBot_Init_Spells_retRank(sName, sRank)
                end
            end
        end
    end
    --HealBot_setCall("HealBot_SmartCast")
    return s;
end

local oldRange=0
function HealBot_UpdateUnitRange(button, doRefresh) 
    if UnitIsUnit("player",button.unit) then
        button.status.range=1
    else
        oldRange=button.status.range
        button.status.range=HealBot_UnitInRange(button.unit, button.spells.rangecheck)
        if oldRange~=button.status.range then
            if button.status.current==9 then
                button.text.healthupdate=true
                button.text.nameupdate=true
                HealBot_Text_setNameText(button)
            else
                HealBot_Text_setNameTag(button)
            end
            if button.status.range<1 then
                HealBot_HealsInUpdate(button)
                HealBot_AbsorbsUpdate(button)
            end
            if doRefresh then
                HealBot_Action_Refresh(button)
                button.aura.check=true  
                if button.status.dirarrowshown or button.status.range==0 then
                    HealBot_Action_ShowDirectionArrow(button)
                end
            end
            if Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][button.frame]["OORLAST"] and (oldRange==1 or button.status.range==1) then
                if button.status.unittype<7 then 
                    HealBot_setOptions_Timer(596)
                elseif button.status.unittype<9 then
                    HealBot_nextRecalcParty(2)
                end
            end
        end
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
    elseif msgType==2 then
        msg="HealBot\n----------\n\nCustom Buffs and Custom Debuffs\nnow use Spell ID and Spell Name\n\nIndividual Buffs and Debuffs can be set\nto use only Spell ID or Spell Name on the\nBuffs>Custom and Debuffs>Custom tabs\n"
    end
    StaticPopupDialogs["HEALBOT_NEWVERSIONMSG"] = {
        text = msg,
        button1 = HEALBOT_WORDS_OK,
        timeout = 0,
        whileDead = 1,
        hideOnEscape = 1
    };

    StaticPopup_Show ("HEALBOT_NEWVERSIONMSG");
    --HealBot_setCall("HealBot_ReloadUI")
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
    HealBot_Aura_ClearAllBuffs()
    HealBot_Aura_ClearAllDebuffs()
    --HealBot_setCall("HealBot_runDefaults")
end

local arg1,arg2,arg3,arg4,eButton,ePrivate = false,false,false,false,false,false
function HealBot_OnEvent(self, event, ...)
    arg1,arg2,arg3,arg4 = ...;
    if (event=="COMBAT_LOG_EVENT_UNFILTERED") then
        HealBot_OnEvent_Combat_Log()
    elseif (event=="UNIT_AURA") then
        _,eButton,ePrivate = HealBot_UnitID(arg1, true)
        if eButton then
            HealBot_OnEvent_UnitAura(eButton);
        end
        if ePrivate then
            HealBot_OnEvent_UnitAura(ePrivate);
        end
    elseif (event=="UNIT_HEALTH") or (event=="UNIT_MAXHEALTH") then
        _,eButton,ePrivate = HealBot_UnitID(arg1, true)
        if eButton then
            HealBot_OnEvent_UnitHealth(eButton)
        end
        if ePrivate then
            HealBot_OnEvent_UnitHealth(ePrivate)
        end
    elseif (event=="UNIT_THREAT_SITUATION_UPDATE") or (event=="UNIT_THREAT_LIST_UPDATE") or (event=="UNIT_COMBAT") then
        _,eButton,ePrivate = HealBot_UnitID(arg1)
        if eButton then
            HealBot_OnEvent_UnitThreat(eButton) 
        end
        if ePrivate then
            HealBot_OnEvent_UnitThreat(ePrivate) 
        end
    elseif (event=="UNIT_HEAL_PREDICTION") then
        _,eButton,ePrivate = HealBot_UnitID(arg1, true)
        if eButton then
            HealBot_HealsInUpdate(eButton)
        end
        if ePrivate then
            HealBot_HealsInUpdate(ePrivate)
        end
    elseif (event=="UNIT_ABSORB_AMOUNT_CHANGED") then
        _,eButton,ePrivate = HealBot_UnitID(arg1, true)
        if eButton then
            HealBot_AbsorbsUpdate(eButton)
        end
        if ePrivate then
            HealBot_AbsorbsUpdate(ePrivate)
        end
    elseif (event=="UNIT_SPELLCAST_FAILED") or (event=="UNIT_SPELLCAST_INTERRUPTED") 
        or (event=="UNIT_SPELLCAST_STOP") or (event=="UNIT_SPELLCAST_SUCCEEDED") then
        if arg2==HealBot_luVars["overhealCastID"] then
            _,eButton,ePrivate = HealBot_UnitID(HealBot_luVars["overhealUnit"])
            HealBot_luVars["overhealUnit"]="-nil-"
            HealBot_luVars["overhealCastID"]="-nil-"
            if eButton and eButton.health.overheal>0 and 
              Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][eButton.frame]["OVERHEAL"]<3 then
                eButton.health.overheal=0
                HealBot_ClearAuxOverHealBar(eButton)
                HealBot_Text_setHealthText(eButton)
                HealBot_Text_SetText(eButton)
            end
            if ePrivate and ePrivate.health.overheal>0 and
              Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][ePrivate.frame]["OVERHEAL"]<3 then
                ePrivate.health.overheal=0
                HealBot_ClearAuxOverHealBar(ePrivate)
                HealBot_Text_setHealthText(ePrivate)
                HealBot_Text_SetText(ePrivate)
            end
            HealBot_luVars["overhealAmount"]=0
        end
        if HEALBOT_GAME_VERSION<4 then
            _,eButton,ePrivate = HealBot_UnitID(arg1)
            if eButton then
                HealBot_OnEvent_UnitThreat(eButton)
            end
            if ePrivate then
                HealBot_OnEvent_UnitThreat(ePrivate)
            end
        end    
    elseif (event=="UNIT_SPELLCAST_START") then
        HealBot_OnEvent_UnitSpellCastStart(arg1)
    elseif (event=="UNIT_SPELLCAST_SENT") then
        HealBot_OnEvent_UnitSpellCastSent(self,arg1,arg2,arg3,arg4);  
    elseif (event=="PLAYER_REGEN_DISABLED") then
        HealBot_OnEvent_PlayerRegenDisabled();
        if HealBot_luVars["rcEnd"] then
            HealBot_luVars["rcEnd"]=nil
            HealBot_OnEvent_ReadyCheckClear(true)
        end
    elseif (event=="PLAYER_REGEN_ENABLED") then
        HealBot_setOptions_Timer(9999)
    elseif (event=="INSTANCE_ENCOUNTER_ENGAGE_UNIT") then
        HealBot_OnEvent_InstanceEncounterEngageUnit(arg1,arg2,arg3,arg4)
    elseif (event=="UNIT_NAME_UPDATE") then
        _,eButton,ePrivate = HealBot_UnitID(arg1)
        if eButton then
            HealBot_UpdateUnit(eButton)
        end
        if ePrivate then
            HealBot_UpdateUnit(ePrivate)
        end
    elseif (event=="UNIT_POWER_UPDATE") or (event=="UNIT_MAXPOWER") then
        _,eButton,ePrivate = HealBot_UnitID(arg1)
        if eButton then
            HealBot_OnEvent_UnitMana(eButton)
        end
        if ePrivate then
            HealBot_OnEvent_UnitMana(ePrivate)
        end
    elseif (event=="GROUP_ROSTER_UPDATE") then
        HealBot_OnEvent_PartyMembersChanged(self);
    elseif (event=="RAID_TARGET_UPDATE") then
        HealBot_OnEvent_RaidTargetUpdateAll()
    elseif (event=="PLAYER_TARGET_CHANGED") then
        HealBot_OnEvent_PlayerTargetChanged(true);
    elseif (event=="PLAYER_FOCUS_CHANGED") then
        HealBot_OnEvent_FocusChanged(self);
    elseif (event=="MODIFIER_STATE_CHANGED") then
        if HealBot_Data["TIPBUTTON"] then
            HealBot_Action_RefreshTooltip();
        end
    elseif (event=="UNIT_PET") then
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["STATE"] then
            HealBot_nextRecalcParty(2)
        end
    elseif (event=="UNIT_POWER_FREQUENT") then
        _,eButton,ePrivate = HealBot_UnitID(arg1)
        if eButton then
            HealBot_OnEvent_UnitManaUpdate(eButton, eButton.mana.reset)
        end
        if ePrivate then
            HealBot_OnEvent_UnitManaUpdate(ePrivate, ePrivate.mana.reset)
        end
    elseif (event=="UNIT_DISPLAYPOWER") then
        _,eButton,ePrivate = HealBot_UnitID(arg1)
        if eButton then
            HealBot_OnEvent_UnitManaUpdate(eButton, true)
        end
        if ePrivate then
            HealBot_OnEvent_UnitManaUpdate(ePrivate, true)
        end
    elseif (event=="PLAYER_CONTROL_GAINED") then
        HealBot_AuraCheck();
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
        if HealBot_Panel_RaidUnitGUID(arg1) then
            _,eButton,ePrivate = HealBot_UnitID(HealBot_Panel_RaidUnitGUID(arg1))
            if eButton then
                HealBot_GetTalentInfo(eButton) 
            end
            if ePrivate then
                HealBot_GetTalentInfo(ePrivate) 
            end
        end
    elseif (event=="PLAYER_SPECIALIZATION_CHANGED") then
        _,eButton,ePrivate = HealBot_UnitID(arg1)
        if eButton then 
            HealBot_GetTalentInfo(eButton) 
            HealBot_setOptions_Timer(596)
        end
        if ePrivate then 
            HealBot_GetTalentInfo(ePrivate) 
            HealBot_setOptions_Timer(596)
        end
    elseif (event=="UNIT_CONNECTION") then
        _,eButton,ePrivate = HealBot_UnitID(arg1)
        if eButton then 
            HealBot_SetUnitDisconnect(eButton)
        end
        if ePrivate then 
            HealBot_SetUnitDisconnect(ePrivate)
        end
    elseif (event=="ZONE_CHANGED_NEW_AREA") or (event=="ZONE_CHANGED")  or (event=="ZONE_CHANGED_INDOORS") then
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
        _,eButton,ePrivate = HealBot_UnitID("player")
        if eButton then
            HealBot_OnEvent_TalentsChanged(eButton)
        end
        if ePrivate then
            HealBot_OnEvent_TalentsChanged(ePrivate)
        end
    elseif (event=="PLAYER_TALENT_UPDATE") or (event=="CHARACTER_POINTS_CHANGED") or (event=="UNIT_DISPLAYPOWER") then
        _,eButton,ePrivate = HealBot_UnitID("player")
        if eButton then
            HealBot_OnEvent_TalentsChanged(eButton)
        end
        if ePrivate then
            HealBot_OnEvent_TalentsChanged(ePrivate)
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

