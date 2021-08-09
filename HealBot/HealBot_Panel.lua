local TempMaxH=0;
local HealBot_TrackNames={};
local HealBot_TrackPrivateNames={}
local i={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,[6]=0,[7]=0,[8]=0,[9]=0,[10]=0}
local order = {};
local units = {};
local suborder = {};
local subunits = {};
local MyGroup={["GROUP"]=0,["FRAME"]=1}
local HeaderPos={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
local HealBot_ActiveHeaders={[0]=1}
local HealBot_TrackUnit={}
local HealBot_SpecialUnit={}
local HealBot_TrackPrivateUnit={}
local HealBot_Panel_BlackList={};
local backBarsSize={[1]={["HEIGHT"]=0, ["WIDTH"]=0, ["RMARGIN"]=0, ["CMARGIN"]=0, ["HEADHEIGHT"]=0, ["HEADWIDTH"]=0},["S2WIDTH"]=0,
                    [2]={["HEIGHT"]=0, ["WIDTH"]=0, ["RMARGIN"]=0, ["CMARGIN"]=0, ["HEADHEIGHT"]=0, ["HEADWIDTH"]=0},["S2WIDTH"]=0,
                    [3]={["HEIGHT"]=0, ["WIDTH"]=0, ["RMARGIN"]=0, ["CMARGIN"]=0, ["HEADHEIGHT"]=0, ["HEADWIDTH"]=0},["S2WIDTH"]=0,
                    [4]={["HEIGHT"]=0, ["WIDTH"]=0, ["RMARGIN"]=0, ["CMARGIN"]=0, ["HEADHEIGHT"]=0, ["HEADWIDTH"]=0},["S2WIDTH"]=0,
                    [5]={["HEIGHT"]=0, ["WIDTH"]=0, ["RMARGIN"]=0, ["CMARGIN"]=0, ["HEADHEIGHT"]=0, ["HEADWIDTH"]=0},["S2WIDTH"]=0,
                    [6]={["HEIGHT"]=0, ["WIDTH"]=0, ["RMARGIN"]=0, ["CMARGIN"]=0, ["HEADHEIGHT"]=0, ["HEADWIDTH"]=0},["S2WIDTH"]=0,
                    [7]={["HEIGHT"]=0, ["WIDTH"]=0, ["RMARGIN"]=0, ["CMARGIN"]=0, ["HEADHEIGHT"]=0, ["HEADWIDTH"]=0},["S2WIDTH"]=0,
                    [8]={["HEIGHT"]=0, ["WIDTH"]=0, ["RMARGIN"]=0, ["CMARGIN"]=0, ["HEADHEIGHT"]=0, ["HEADWIDTH"]=0},["S2WIDTH"]=0,
                    [9]={["HEIGHT"]=0, ["WIDTH"]=0, ["RMARGIN"]=0, ["CMARGIN"]=0, ["HEADHEIGHT"]=0, ["HEADWIDTH"]=0},["S2WIDTH"]=0,
                   [10]={["HEIGHT"]=0, ["WIDTH"]=0, ["RMARGIN"]=0, ["CMARGIN"]=0, ["HEADHEIGHT"]=0, ["HEADWIDTH"]=0},["S2WIDTH"]=0,}
local HealBot_MyHealTargets={}
local HealBot_MyPrivateTanks={}
local HealBot_MyPrivateHealers={}
local HealBot_MainTanks={};
local HealBot_MainHealers={};
local HealBot_UnitGroups={}
local HealBot_TestBarsActive={}
local hbBarsPerFrame={}
local hbCurrentFrame=1
local HealBot_unitRole={}
local _
local nraid=0
local hbOptionOn=0
local hbMoveMe=0
local hbFocusOn=0
local HealBot_Header_Frames={}
local HealBot_Track_Headers={}
local HealBot_PanelVars={}
local hbPanel_dataUnits={}
local hbPanel_dataNames={}
local hbPanel_dataGUIDs={}
local hbPanel_dataRoles={}
local hbPanel_dataPetUnits={}
local hbPanel_dataPetNames={}
local hbPanel_dataPetGUIDs={}
local hbPanel_enemyUnits={}
local grpNo=1
local tHeader={}
local erButton=nil
local hbRole={ [HEALBOT_MAINTANK]=3,
               [HEALBOT_WORD_HEALER]=5,
               [HEALBOT_WORD_DPS]=7,
               [HEALBOT_WORDS_UNKNOWN]=9,
      }
local HealBot_randomN=random(11)
local prevCol=0
local HealBot_randomClCol = {   [1] = { [1] = 0.77, [2] = 0.12, [3] = 0.23, [4]="DEAT"},  
                                [2] = { [1] = 0.78, [2] = 0.61, [3] = 0.43, [4]="WARR"},  
                                [3] = { [1] = 1.0,  [2] = 0.49, [3] = 0.04, [4]="DRUI"},   
                                [4] = { [1] = 0,    [2] = 1.0,  [3] = 0.59, [4]="MONK"}, 
                                [5] = { [1] = 0.96, [2] = 0.55, [3] = 0.73, [4]="PALA"},
                                [6] = { [1] = 1.0,  [2] = 1.0,  [3] = 1.0,  [4]="PRIE"},
                                [7] = { [1] = 0,    [2] = 0.44, [3] = 0.87, [4]="SHAM"},
                                [8] = { [1] = 0.53, [2] = 0.53, [3] = 0.93, [4]="WARL"},
                                [9] = { [1] = 0.67, [2] = 0.83, [3] = 0.45, [4]="HUNT"},
                               [10] = { [1] = 0.25, [2] = 0.78, [3] = 0.92, [4]="MAGE"},
                               [11] = { [1] = 1.0,  [2] = 0.96, [3] = 0.41, [4]="ROGU"},
                            }
local HealBot_Action_HealGroup = {
    "player",
    "party1",
    "party2",
    "party3",
    "party4",
};
local HealBot_Action_HealGroupPets = {
    "pet",
    "partypet1",
    "partypet2",
    "partypet3",
    "partypet4",
};
local HealBot_colIndex= {}
local HealBot_Action_HealButtons = {};
local hbPanelShowhbFocus=nil
local hbPanelNoCols={[1]=1,[2]=1,[3]=1,[4]=1,[5]=1,[6]=1,[7]=1,[8]=1,[9]=1,[10]=1}
local hbPanelNoRows={[1]=1,[2]=1,[3]=1,[4]=1,[5]=1,[6]=1,[7]=1,[8]=1,[9]=1,[10]=1}
local HealBot_Panel_luVars={}
HealBot_Panel_luVars["SelfPets"]=false
HealBot_Panel_luVars["OptionsShown"]=false
HealBot_Panel_luVars["TanksOn"]=false
HealBot_Panel_luVars["HealsOn"]=false
HealBot_Panel_luVars["TestBarsDelAll"]=true
HealBot_Panel_luVars["MAPID"]=0
HealBot_Panel_luVars["NumPrivate"]=0
HealBot_Panel_luVars["NumPets"]=0
HealBot_Panel_luVars["TankHealth"]=0
HealBot_Panel_luVars["cpUse"]=false
HealBot_Panel_luVars["cpGroup"]=false
HealBot_Panel_luVars["cpRaid"]=false

function HealBot_Panel_retLuVars(vName)
    return HealBot_Panel_luVars[vName]
end

function HealBot_Panel_setLuVars(vName, vValue)
    HealBot_Panel_luVars[vName]=vValue
      --HealBot_setCall("HealBot_Panel_setLuVars - "..vName)
end

function HealBot_Panel_retNoCols(frame)
    return hbPanelNoCols[frame]
end

function HealBot_Panel_retHeadersCols(frame)
    return ceil(hbPanelNoRows[frame]/5)
end

function HealBot_Panel_setCP(cpType, useCP)
    if cpType=="MAIN" then
        HealBot_Panel_luVars["cpUse"]=useCP
    elseif cpType=="GROUP" then
        HealBot_Panel_luVars["cpGroup"]=useCP
    else
        HealBot_Panel_luVars["cpRaid"]=useCP
    end
    HealBot_nextRecalcParty(6)
end

function HealBot_Panel_isSpecialUnit(unit)
    return HealBot_SpecialUnit[unit] or 0
end

function HealBot_Panel_TankRole(unit,guid)
    HealBot_unitRole[unit]=hbRole[HEALBOT_MAINTANK]
    HealBot_MainTanks[guid]=unit
    if UnitHealth(unit)>HealBot_Panel_luVars["TankHealth"] then
        HealBot_Panel_luVars["TankHealth"]=UnitHealth(unit)
        HealBot_setLuVars("TankUnit", unit)
        HealBot_Aura_setLuVars("TankUnit", unit)
    end
end
 
function HealBot_Panel_HealerRole(unit,guid)
    HealBot_unitRole[unit]=hbRole[HEALBOT_WORD_HEALER]
    HealBot_MainHealers[guid]=unit
end

local aRole = nil
function HealBot_Panel_SetRole(unit,guid)
    aRole = HealBot_Panel_UnitRole(unit)
    if aRole=="TANK" then
        HealBot_Panel_TankRole(unit,guid)
    elseif aRole=="HEALER" then
        HealBot_Panel_HealerRole(unit,guid)
    elseif aRole=="DAMAGER" then
        HealBot_unitRole[unit]=hbRole[HEALBOT_WORD_DPS]
    else
        HealBot_unitRole[unit]=hbRole[HEALBOT_WORDS_UNKNOWN]
    end
end

function HealBot_Panel_addDataStore(unit, nRaidID, isPlayer)
    if UnitExists(unit) then
        local dsGUID=UnitGUID(unit) or unit
        local dsName=HealBot_GetUnitName(unit)
        if isPlayer then
            if UnitIsUnit(unit, "player") then unit="player" end
            hbPanel_dataNames[dsName]=unit
            hbPanel_dataGUIDs[dsGUID]=unit
            hbPanel_dataUnits[unit]=dsGUID
        else
            if UnitIsUnit(unit, "pet") then unit="pet" end
            hbPanel_dataPetNames[dsName]=unit
            hbPanel_dataPetGUIDs[dsGUID]=unit
            hbPanel_dataPetUnits[unit]=dsGUID
        end
        hbPanel_dataRoles[unit]=HEALBOT_WORDS_UNKNOWN
        if HealBot_MyPrivateTanks[dsGUID] or HealBot_Globals.HealBot_PermPrivateTanks[dsGUID] then
            hbPanel_dataRoles[unit]="TANK"
        elseif HealBot_MyPrivateHealers[dsGUID] or HealBot_Globals.HealBot_PermPrivateHealers[dsGUID] then
            hbPanel_dataRoles[unit]="HEALER"
        end
        if nRaidID>0 then
            local hbFRole=nil
            local _, _, hbSubgroup, _, _, _, _, _, _, hbRRole, _, hbCombatRole = GetRaidRosterInfo(nRaidID);
            HealBot_UnitGroups[unit]=hbSubgroup
            if isPlayer then
                if hbPanel_dataRoles[unit]==HEALBOT_WORDS_UNKNOWN then
                    if hbCombatRole and (hbCombatRole=="HEALER" or hbCombatRole=="TANK") then
                        hbFRole = hbCombatRole
                    elseif hbRRole and (string.lower(hbRRole)=="maintank" or (HealBot_Globals.IncMainAssist and string.lower(hbRRole)=="mainassist")) then
                        hbFRole="TANK"
                    end
                end
            end
            if not hbFRole then
                HealBot_Panel_SetRole(unit,dsGUID)
            else
                hbPanel_dataRoles[unit]=hbFRole
                if hbFRole=="TANK" then
                    HealBot_Panel_TankRole(unit,dsGUID)
                elseif hbFRole=="HEALER" then 
                    HealBot_Panel_HealerRole(unit,dsGUID)
                end
            end
        else
            HealBot_UnitGroups[unit]=1
            HealBot_Panel_SetRole(unit,dsGUID)
        end
    end
end

function HealBot_Panel_buildDataStore(doPlayers, doPets)
    if doPlayers then
        HealBot_setLuVars("pluginClearDown", true)
        for x,_ in pairs(hbPanel_dataNames) do
            hbPanel_dataNames[x]=nil
        end
        for x,_ in pairs(hbPanel_dataGUIDs) do
            HealBot_MainTanks[x]=nil
            HealBot_MainHealers[x]=nil
            hbPanel_dataGUIDs[x]=nil
        end
        for x,_ in pairs(hbPanel_dataUnits) do
            HealBot_unitRole[x]=9
            hbPanel_dataUnits[x]=false
        end
        HealBot_setLuVars("TankUnit", "x")
        HealBot_Aura_setLuVars("TankUnit", "x")
        HealBot_Panel_luVars["TankHealth"]=0
        HealBot_Panel_addDataStore("player", 0, true)
        if HealBot_Config.DisabledNow==0 then
            local nGroupMembers=GetNumGroupMembers()
            if nGroupMembers>0 then
                if IsInRaid() then
                    for j=1,nGroupMembers do
                        HealBot_Panel_addDataStore("raid"..j, j, true)
                    end
                else
                    for j=1,nGroupMembers do
                        HealBot_Panel_addDataStore("party"..j, 0, true)
                    end
                end
            end
        end
    end
    if doPets then
        HealBot_Panel_luVars["NumPets"]=0
        for x,_ in pairs(hbPanel_dataPetNames) do
            hbPanel_dataPetNames[x]=nil;
        end
        for x,_ in pairs(hbPanel_dataPetGUIDs) do
            HealBot_MainTanks[x]=nil
            HealBot_MainHealers[x]=nil
            hbPanel_dataPetGUIDs[x]=nil
        end
        for x,_ in pairs(hbPanel_dataPetUnits) do
            HealBot_unitRole[x]=9
            hbPanel_dataPetUnits[x]=false
        end
        if HealBot_Config.DisabledNow==0 then
            HealBot_Panel_addDataStore("pet", 0, false)
            local nGroupMembers=GetNumGroupMembers()
            if nGroupMembers>0 then
                if IsInRaid() then
                    for j=1,nGroupMembers do
                        HealBot_Panel_addDataStore("raidpet"..j, j, false)
                    end
                else
                    for j=1,nGroupMembers do
                        HealBot_Panel_addDataStore("partypet"..j, 0, false)
                    end
                end
            end
        end
    end
end

function HealBot_Panel_clickToFocus(status)
    if status=="Show" then
        hbPanelShowhbFocus=true
    else
        hbPanelShowhbFocus=false
    end
end

function HealBot_GetMyHealTargets()
    return HealBot_MyHealTargets
end

function HealBot_Panel_IsTank(xGUID)
    return HealBot_MainTanks[xGUID]
end

function HealBot_Panel_SethbTopRole(Role)
    if not Role then return end
    Role=strupper(strtrim(Role))
    if Role=="TANK" then
        hbRole[HEALBOT_MAINTANK]=2
        hbRole[HEALBOT_WORD_HEALER]=5
        hbRole[HEALBOT_WORD_DPS]=7
    elseif Role=="DPS" then
        hbRole[HEALBOT_MAINTANK]=3
        hbRole[HEALBOT_WORD_HEALER]=5
        hbRole[HEALBOT_WORD_DPS]=2
    elseif Role=="HEALER" then
        hbRole[HEALBOT_MAINTANK]=3
        hbRole[HEALBOT_WORD_HEALER]=2
        hbRole[HEALBOT_WORD_DPS]=7
    else
        HealBot_AddChat(HEALBOT_CHAT_ADDONID..Role..HEALBOT_CHAT_TOPROLEERR)
        return
    end
    if HealBot_Globals.TopRole~=Role then
        HealBot_Globals.TopRole=Role
        HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_NEWTOPROLE..Role)
    end
end

function HealBot_Panel_ClearBlackList()
    for x,_ in pairs(HealBot_Panel_BlackList) do
        HealBot_Panel_BlackList[x]=nil
    end 
    HealBot_setOptions_Timer(185)
end

function HealBot_Panel_AddBlackList(unit)
    xGUID=UnitGUID(unit)
    if xGUID then
        HealBot_Panel_BlackList[xGUID]=true;
        HealBot_setOptions_Timer(185)
    end
end

function HealBot_Panel_ClearHealTargets()
    HealBot_MyHealTargets = {}
end

function HealBot_Panel_ToggelHealTarget(unit, perm)
    if unit=="target" then return end
    local xGUID=UnitGUID(unit)
    if perm then
        if HealBot_Globals.HealBot_PermMyTargets[xGUID] then
            HealBot_Globals.HealBot_PermMyTargets[xGUID]=nil
        else
            HealBot_Globals.HealBot_PermMyTargets[xGUID]=HealBot_GetUnitName(unit, xGUID) or "unKnown"
        end
    else
        local mti=0
        for j=1, #HealBot_MyHealTargets do
            if xGUID==HealBot_MyHealTargets[j] then
                mti=j
                break;
            end
        end
        if mti>0 then
            table.remove(HealBot_MyHealTargets,mti)
        else
            table.insert(HealBot_MyHealTargets,xGUID)
        end
    end
    HealBot_setOptions_Timer(185)
    --HealBot_nextRecalcParty(0)
end

function HealBot_Panel_ToggelPrivateTanks(unit, perm)
    if unit=="target" then return end
    local xGUID=UnitGUID(unit)
    if perm then
        if HealBot_Globals.HealBot_PermPrivateTanks[xGUID] then
            HealBot_Globals.HealBot_PermPrivateTanks[xGUID]=nil
        else
            HealBot_Globals.HealBot_PermPrivateTanks[xGUID]=HealBot_GetUnitName(unit, xGUID) or "unKnown"
        end
    else
        if HealBot_MyPrivateTanks[xGUID] then
            HealBot_MyPrivateTanks[xGUID]=nil
        else
            HealBot_MyPrivateTanks[xGUID]=true
        end
    end
    --HealBot_Panel_buildDataStore(true, true)
    HealBot_setOptions_Timer(185)
    --HealBot_nextRecalcParty(0)
end

function HealBot_Panel_ToggelPrivateHealers(unit, perm)
    if unit=="target" then return end
    local xGUID=UnitGUID(unit)
    if perm then
        if HealBot_Globals.HealBot_PermPrivateHealers[xGUID] then
            HealBot_Globals.HealBot_PermPrivateHealers[xGUID]=nil
        else
            HealBot_Globals.HealBot_PermPrivateHealers[xGUID]=HealBot_GetUnitName(unit, xGUID) or "unKnown"
        end
    else
        if HealBot_MyPrivateHealers[xGUID] then
            HealBot_MyPrivateHealers[xGUID]=nil
        else
            HealBot_MyPrivateHealers[xGUID]=true
        end
    end
    --HealBot_Panel_buildDataStore(true, true)
    HealBot_setOptions_Timer(185)
    --HealBot_nextRecalcParty(0)
end

function HealBot_Panel_RetMyHealTarget(unit, perm)
    local xGUID=UnitGUID(unit) or unit
    local mti=0
    if perm then
        if HealBot_Globals.HealBot_PermMyTargets[xGUID] then
            mti=1
        end
    else
        for j=1, #HealBot_MyHealTargets do
            if xGUID==HealBot_MyHealTargets[j] then
                mti=j
                break;
            end
        end
    end
    if mti>0 then
        return true
    else
        return false
    end
end

function HealBot_Panel_RetPrivateTanks(unit, perm)
    local xGUID=UnitGUID(unit) or unit
    if perm then
        return HealBot_Globals.HealBot_PermPrivateTanks[xGUID]
    else
        return HealBot_MyPrivateTanks[xGUID]
    end
end

function HealBot_Panel_RetPrivateHealers(unit, perm)
    local xGUID=UnitGUID(unit) or unit
    if perm then
        return HealBot_Globals.HealBot_PermPrivateHealers[xGUID]
    else
        return HealBot_MyPrivateHealers[xGUID]
    end
end

local role_tex_file = "Interface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES.blp"
local role_t = "\124T"..role_tex_file..":%d:%d:"
local role_tex = {
   DAMAGER = role_t.."0:0:64:64:20:39:22:41\124t",
   HEALER  = role_t.."0:0:64:64:20:39:1:20\124t",
   TANK    = role_t.."0:0:64:64:0:19:22:41\124t",
   LEADER  = role_t.."0:0:64:64:0:19:1:20\124t",
   NONE    = ""
}

local roleTextures={
    ["DAMAGER"]="Interface\\Addons\\HealBot\\Images\\dps.tga",
    ["TANK"]="Interface\\Addons\\HealBot\\Images\\tank.tga",
    ["HEALER"]="Interface\\Addons\\HealBot\\Images\\healer.tga",
    }
    
local classTextures={
    ["DEAT"]="Interface\\Addons\\HealBot\\Images\\Deathknight",
    ["DEMO"]="Interface\\Addons\\HealBot\\Images\\Demonhunter",
    ["DRUI"]="Interface\\Addons\\HealBot\\Images\\Druid",
    ["HUNT"]="Interface\\Addons\\HealBot\\Images\\Hunter",
    ["MAGE"]="Interface\\Addons\\HealBot\\Images\\Mage",
    ["MONK"]="Interface\\Addons\\HealBot\\Images\\Monk",
    ["PALA"]="Interface\\Addons\\HealBot\\Images\\Paladin",
    ["PRIE"]="Interface\\Addons\\HealBot\\Images\\Priest",
    ["ROGU"]="Interface\\Addons\\HealBot\\Images\\Rogue",
    ["SHAM"]="Interface\\Addons\\HealBot\\Images\\Shaman",
    ["WARL"]="Interface\\Addons\\HealBot\\Images\\Warlock",
    ["WARR"]="Interface\\Addons\\HealBot\\Images\\Warrior",
    }

function HealBot_Panel_retClassRoleIcon(id)
    return classTextures[id] or roleTextures[id]
end

function HealBot_Panel_classEN(unit)
    local _,classEN = UnitClass(unit)
    if classEN then 
        return strsub(classEN,1,4)
    else
        return HealBot_Class_En[HEALBOT_WARRIOR]
    end
end

function HealBot_Panel_UnitRole(unit)
    local role = hbPanel_dataRoles[unit]
    if role==HEALBOT_WORDS_UNKNOWN then 
        if HEALBOT_GAME_VERSION>3 then 
            role=UnitGroupRolesAssigned(unit) or "DAMAGER"
        else
            role="DAMAGER" 
        end
        hbPanel_dataRoles[unit]=role
    end
    return role
end

function HealBot_Action_SetClassIconTexture(button)
    if UnitExists(button.unit) and Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWCLASS"] then
        local setRole=false
        local unitRole=HEALBOT_WORDS_UNKNOWN
        if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWROLE"] then
            unitRole=HealBot_Panel_UnitRole(button.unit)
        end
        if roleTextures[unitRole] then
            HealBot_Aura_ClassUpdate(button, roleTextures[unitRole])
        else
            HealBot_Aura_ClassUpdate(button, classTextures[HealBot_Panel_classEN(button.unit)])
        end
    else
        HealBot_Aura_ClassUpdate(button, false)
    end
end

HealBot_Panel_luVars["HealerHWM"]=1
function HealBot_Panel_CreateHeader(hbCurFrame)
    if HealBot_ActiveHeaders[0]>99 then HealBot_ActiveHeaders[0]=1 end
    local tryId,freeId=HealBot_ActiveHeaders[0],nil
    if not HealBot_ActiveHeaders[tryId] then
        freeId=tryId
    else
        for j=1,99 do
            if not HealBot_ActiveHeaders[j] then
                freeId=j
                break
            end
        end
    end
    if freeId then 
        HealBot_ActiveHeaders[freeId]=true 
        local hn="HealBot_Action_Header"..freeId
        local hp=_G["f"..hbCurFrame.."_HealBot_Action"]
        local hhb=_G[hn]
        if not hhb then 
            hhb=CreateFrame("Button", hn, hp, "HealingButtonTemplate3") 
            hhb.id=freeId
        end
        if freeId>HealBot_Panel_luVars["HealerHWM"] then
            HealBot_Panel_luVars["HealerHWM"]=freeId
        end
        hhb.frame=0
        HealBot_ActiveHeaders[0]=freeId+1
        return hhb
    else
        return nil
    end
end

function HealBot_Panel_ResetHeaders()
    for i=1,HealBot_Panel_luVars["HealerHWM"] do
        local hhb=_G["HealBot_Action_Header"..i]
        if hhb then hhb.frame=0 end
    end
end

function HealBot_Panel_DeleteHeader(hdrID, xHeader)
    local hg=_G["HealBot_Action_Header"..hdrID]
    if hdrID<HealBot_ActiveHeaders[0] then HealBot_ActiveHeaders[0]=hdrID end
    hg:Hide();
    HealBot_ActiveHeaders[hdrID]=nil
    HealBot_Header_Frames[xHeader]=nil
end

function HealBot_Panel_retHealBot_Header_Frames(hbCurFrame)
    return HealBot_Options_copyTable(HealBot_Header_Frames)
end

function HealBot_Panel_Anchor2ParentFrame(button, backFrame)
    local vPostFrameBF=_G["f"..button.frame.."_HealBot_Action"]
    if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][button.frame]["BARS"]==1 then
        backFrame:SetPoint("TOPLEFT",vPostFrameBF,"TOPLEFT",5,-5);
    elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][button.frame]["BARS"]==2 then
        backFrame:SetPoint("BOTTOMLEFT",vPostFrameBF,"BOTTOMLEFT",5,5);
    elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][button.frame]["BARS"]==3 then
        backFrame:SetPoint("TOPRIGHT",vPostFrameBF,"TOPRIGHT",-5,-5);
    else
        backFrame:SetPoint("BOTTOMRIGHT",vPostFrameBF,"BOTTOMRIGHT",-5,5);
    end
end

function HealBot_Panel_AnchorSpecialFrame(button, backFrame, relButton, newColumn, child)
    if child then
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][button.frame]["BARS"]<3 then
            backFrame:SetPoint("LEFT",relButton,"RIGHT",backBarsSize[button.frame]["CMARGIN"],0)
        else
            backFrame:SetPoint("RIGHT",relButton,"LEFT",-backBarsSize[button.frame]["CMARGIN"],0)
        end
    elseif newColumn==2 then
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][button.frame]["BARS"]==1 then
            backFrame:SetPoint("TOPLEFT",relButton,"BOTTOMLEFT",0,-backBarsSize[button.frame]["RMARGIN"])
        elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][button.frame]["BARS"]==2 then
            backFrame:SetPoint("BOTTOMLEFT",relButton,"TOPLEFT",0,backBarsSize[button.frame]["RMARGIN"])
        elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][button.frame]["BARS"]==3 then
            backFrame:SetPoint("TOPRIGHT",relButton,"BOTTOMRIGHT",0,-backBarsSize[button.frame]["RMARGIN"])
        else
            backFrame:SetPoint("BOTTOMRIGHT",relButton,"TOPRIGHT",0,backBarsSize[button.frame]["RMARGIN"])
        end
    else
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][button.frame]["BARS"]<3 then
            backFrame:SetPoint("LEFT",relButton,"RIGHT",backBarsSize[button.frame]["S2WIDTH"]+backBarsSize[button.frame]["CMARGIN"],0)
        else
            backFrame:SetPoint("RIGHT",relButton,"LEFT",-(backBarsSize[button.frame]["S2WIDTH"]+backBarsSize[button.frame]["CMARGIN"]),0)
        end
    end
end

function HealBot_Panel_AnchorFrame(button, backFrame, relButton, newColumn)
    if newColumn==2 then
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][button.frame]["BARS"]==1 or
           Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][button.frame]["BARS"]==3 then
            backFrame:SetPoint("TOPLEFT",relButton,"BOTTOMLEFT",0,-backBarsSize[button.frame]["RMARGIN"])
        else
            backFrame:SetPoint("BOTTOMLEFT",relButton,"TOPLEFT",0,backBarsSize[button.frame]["RMARGIN"])
        end
    else
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][button.frame]["BARS"]<3 then
            backFrame:SetPoint("LEFT",relButton,"RIGHT",backBarsSize[button.frame]["CMARGIN"],0)
        else
            backFrame:SetPoint("RIGHT",relButton,"LEFT",-backBarsSize[button.frame]["CMARGIN"],0)
        end
    end
end

function HealBot_Panel_AnchorButton(button, backFrame, relButton, newColumn, child)
    backFrame:ClearAllPoints()
    if not relButton then
        HealBot_Panel_Anchor2ParentFrame(button, backFrame)
    elseif HealBot_SpecialUnit[button.unit] then
        HealBot_Panel_AnchorSpecialFrame(button, backFrame, relButton, newColumn, child)
    else
        HealBot_Panel_AnchorFrame(button, backFrame, relButton, newColumn)
    end
end

local vSpecialAnchor={}
function HealBot_Panel_PositionButton(button,xHeader,relButton,newColumn,preCombat)
    if xHeader then
        local vPosParentHF=HealBot_Header_Frames[xHeader]
        if not vPosParentHF then
            vPosParentHF=HealBot_Panel_CreateHeader(button.frame)
            HealBot_Header_Frames[xHeader]=vPosParentHF
        end
        local backFrame=_G[vPosParentHF:GetName().."Bar5"]
        if backFrame~=relButton then
            if vPosParentHF.frame~=button.frame then
                local vPosFrameHF=_G["f"..button.frame.."_HealBot_Action"]
                vPosParentHF:ClearAllPoints()
                vPosParentHF:SetParent(vPosFrameHF)
                vPosParentHF.frame=button.frame
                HealBot_Skins_ResetSkin("header",vPosParentHF)
                if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][button.frame]["GROW"]==1 then
                    backFrame:SetHeight(backBarsSize[button.frame]["HEIGHT"])
                else
                    backFrame:SetWidth(backBarsSize[button.frame]["WIDTH"])
                end
            end
            HealBot_Track_Headers[xHeader]=true
            HealBot_Panel_AnchorButton(button, backFrame, relButton, newColumn)
            local vPosFrameHB = _G[vPosParentHF:GetName().."Bar_text"]
            vPosFrameHB:SetText(xHeader);
            vPosParentHF:Show();
        end
        return backFrame
    else
        HealBot_Panel_AnchorButton(button, button.gref["Back"], relButton, newColumn)
        
        if HealBot_SpecialUnit[button.unit] then
            local eGUID=UnitGUID(button.unit.."target") or button.unit.."target"
            local eButton=HealBot_Action_SetHealButton(button.unit.."target",eGUID,10,11,false,3,preCombat) 
            if eButton then
                HealBot_TrackUnit[eButton.unit]=true
                HealBot_Panel_AnchorButton(eButton, eButton.gref["Back"], button.gref["Back"], 1, true)        
                eButton:ClearAllPoints()
                eButton:SetPoint("CENTER",eButton.gref["Bar"],"CENTER",0,0)
                eButton:Show()
            end
        end

        button:ClearAllPoints()
        button:SetPoint("CENTER",button.gref["Bar"],"CENTER",0,0)
        return button.gref["Back"]
    end
end

function HealBot_Action_SetBackBarHeightWidth(frame, height, width)
    local vSetAddHWScale = Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][frame]["SCALE"]
    backBarsSize[frame]["HEIGHT"]=height
    backBarsSize[frame]["WIDTH"]=width
    backBarsSize[frame]["RMARGIN"]=ceil(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][frame]["RMARGIN"]*vSetAddHWScale)
    backBarsSize[frame]["CMARGIN"]=ceil(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][frame]["CMARGIN"]*vSetAddHWScale)
end

function HealBot_Action_SetBackSpecialWidth(frame, width)
    backBarsSize[frame]["S2WIDTH"]=width
end

function HealBot_Action_SetBackHeaderHeightWidth(frame, height, width)
    backBarsSize[frame]["HEADHEIGHT"]=height
    backBarsSize[frame]["HEADWIDTH"]=width
end

local HealBot_Panel_initFrame={[1]=true,[2]=true,[3]=true,[4]=true,[5]=true,[6]=true,[7]=true,[8]=true,[9]=true,[10]=true}
function HealBot_Panel_resetInitFrames()
    for j=1,10 do
        HealBot_Panel_initFrame[j]=true
    end
end

local vSetHWFrame,vSetHWextraHeight,vSetHWextraWidth="",0,0
function HealBot_Action_SetHeightWidth(numRows,numCols,numHeaders,hbCurFrame)
    vSetHWFrame = _G["f"..hbCurFrame.."_HealBot_Action"]
    vSetHWextraHeight=10
    vSetHWextraWidth=10
    if hbOptionOn==hbCurFrame then
        vSetHWextraHeight=vSetHWextraHeight+30
    end
    if hbMoveMe==hbCurFrame then
        vSetHWextraHeight=vSetHWextraHeight+20
    end
    if hbFocusOn==hbCurFrame then
        vSetHWextraHeight=vSetHWextraHeight+10+ceil(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][hbCurFrame]["HEIGHT"]*Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][hbCurFrame]["SCALE"])
    end
    if numHeaders>0 then
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["GROW"]==1 then
            vSetHWextraWidth=vSetHWextraWidth+(backBarsSize[hbCurFrame]["HEADWIDTH"]*numHeaders)
        else
            vSetHWextraHeight=vSetHWextraHeight+(backBarsSize[hbCurFrame]["HEADHEIGHT"]*numHeaders)
        end
    end
    if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["GROW"]==1 then
        vSetHWFrame:SetHeight(vSetHWextraHeight+(backBarsSize[hbCurFrame]["HEIGHT"]*numCols)+(backBarsSize[hbCurFrame]["RMARGIN"]*(numCols-1)))
        vSetHWFrame:SetWidth(vSetHWextraWidth+(backBarsSize[hbCurFrame]["WIDTH"]*numRows)+(backBarsSize[hbCurFrame]["CMARGIN"]*(numRows-1)))
    else
        vSetHWFrame:SetHeight(vSetHWextraHeight+(backBarsSize[hbCurFrame]["HEIGHT"]*numRows)+(backBarsSize[hbCurFrame]["RMARGIN"]*(numRows-1)))
        vSetHWFrame:SetWidth(vSetHWextraWidth+(backBarsSize[hbCurFrame]["WIDTH"]*numCols)+(backBarsSize[hbCurFrame]["CMARGIN"]*(numCols-1)))
    end
    if HealBot_Panel_initFrame[hbCurFrame] then
        HealBot_Panel_initFrame[hbCurFrame]=false
        HealBot_Action_FrameSetPoint(hbCurFrame, vSetHWFrame)
    end
    HealBot_Action_setPoint(hbCurFrame)
end

local HealBot_noBars=25
local HealBot_setTestCols={}
local HealBot_setTestBars=false
function HealBot_Panel_SetNumBars(numTestBars)
    if numTestBars>HealBot_noBars and HealBot_setTestBars then
        HealBot_Panel_resetTestCols()
    end
    HealBot_noBars=numTestBars
end

function HealBot_Panel_TestBarsOff()
    for x,b in pairs(HealBot_TestBarsActive) do
        HealBot_Action_DeleterCallsUnit(b.unit)
        HealBot_Action_MarkDeleteButton(b)
        b.icon.reset=true
        b.skinreset=true
        b.indreset=true
        HealBot_TestBarsActive[x]=nil
    end
    HealBot_Action_DeleteMarkedButtons()
end

function HealBot_Panel_ToggleTestBars()
    HealBot_Options_framesChanged(true, true, true)
    if HealBot_setTestBars then
        HealBot_setTestBars=false
        HealBot_Panel_TestBarsOff()
        HealBot_Options_TestBarsButton:SetText(HEALBOT_OPTIONS_TURNTESTBARSON)
        for j=1,10 do
            HealBot_Action_HidePanel(j)
        end
        HealBot_Action_setLuVars("TestBarsOn", false)
        HealBot_setLuVars("TestBarsOn", false)
        HealBot_Options_setLuVars("TestBarsOn", false)
        HealBot_Skins_isTestBars(false)
        HealBot_setTestCols={}
    else
        HealBot_Action_setLuVars("TestBarsOn", true)
        HealBot_setLuVars("TestBarsOn", true)
        HealBot_Options_setLuVars("TestBarsOn", true)
        HealBot_Skins_isTestBars(true)
        HealBot_setTestBars=true
        HealBot_Panel_luVars["TestBarsDelAll"]=true
        HealBot_Options_TestBarsButton:SetText(HEALBOT_OPTIONS_TURNTESTBARSOFF)
    end
end

local vBar={[1]={["BUTTON"]="",["PREVROW"]="",["PREVCOL"]=""},
            [2]={["BUTTON"]="",["PREVROW"]="",["PREVCOL"]=""},
            [3]={["BUTTON"]="",["PREVROW"]="",["PREVCOL"]=""},
            [4]={["BUTTON"]="",["PREVROW"]="",["PREVCOL"]=""},
            [5]={["BUTTON"]="",["PREVROW"]="",["PREVCOL"]=""},
            [6]={["BUTTON"]="",["PREVROW"]="",["PREVCOL"]=""},
            [7]={["BUTTON"]="",["PREVROW"]="",["PREVCOL"]=""},
            [8]={["BUTTON"]="",["PREVROW"]="",["PREVCOL"]=""},
            [9]={["BUTTON"]="",["PREVROW"]="",["PREVCOL"]=""},
           [10]={["BUTTON"]="",["PREVROW"]="",["PREVCOL"]=""},}
local vPosButton,vFrame="",0
local maxRows={[1]=1,[2]=1,[3]=1,[4]=1,[5]=1,[6]=1,[7]=1,[8]=1,[9]=1,[10]=1}
local maxCols={[1]=1,[2]=1,[3]=1,[4]=1,[5]=1,[6]=1,[7]=1,[8]=1,[9]=1,[10]=1}
local maxHeaders={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,[6]=0,[7]=0,[8]=0,[9]=0,[10]=0}
local rowNo={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,[6]=0,[7]=0,[8]=0,[9]=0,[10]=0}
local barNo={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,[6]=0,[7]=0,[8]=0,[9]=0,[10]=0}
local headerNo={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,[6]=0,[7]=0,[8]=0,[9]=0,[10]=0}
function HealBot_Panel_PositionBars(preCombat)
    local newCol=1
    local sameCol=2
    local emtarPrev=false
    table.foreach(HealBot_Action_HealButtons, function (x,xUnitData)
        local xUnit,xUnitType=string.split("~", xUnitData)
        xUnitType=tonumber(xUnitType)
        if xUnitType<5 then
            vPosButton=HealBot_Private_Button[xUnit] or "nil"
        elseif xUnitType>10 then
            vPosButton=HealBot_Enemy_Button[xUnit] or "nil"
        elseif xUnitType==8 then
            vPosButton=HealBot_Pet_Button[xUnit] or "nil"
        elseif xUnitType==7 then
            vPosButton=HealBot_Vehicle_Button[xUnit] or "nil"
        elseif xUnitType>8 then
            vPosButton=HealBot_Extra_Button[xUnit] or "nil"
        else
            vPosButton=HealBot_Unit_Button[xUnit] or "nil"
        end
        if vPosButton~="nil" and hbBarsPerFrame[vPosButton.frame] then
            vPosButton.group=HealBot_UnitGroups[vPosButton.unit] or 1
            vFrame=vPosButton.frame
            rowNo[vFrame]=rowNo[vFrame]+1
            barNo[vFrame]=barNo[vFrame]+1
            vBar[vFrame]["BUTTON"]=vPosButton
            if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][vFrame]["GROW"]==1 then
                newCol=2
                sameCol=1
            else
                newCol=1
                sameCol=2
            end
            if Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][vFrame]["SHOW"] then 
                if HeaderPos[vFrame][barNo[vFrame]] then
                    headerNo[vFrame]=headerNo[vFrame]+1
                    if barNo[vFrame]==1 then
                        vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vBar[vFrame]["BUTTON"],HeaderPos[vFrame][barNo[vFrame]],false,sameCol,preCombat)
                        vBar[vFrame]["PREVCOL"]=vBar[vFrame]["PREVROW"]
                    elseif headerNo[vFrame]>Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][vFrame]["NUMCOLS"] then
                        vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vBar[vFrame]["BUTTON"],HeaderPos[vFrame][barNo[vFrame]],vBar[vFrame]["PREVCOL"],newCol,preCombat)
                        maxCols[vFrame]=maxCols[vFrame]+1
                        vBar[vFrame]["PREVCOL"]=vBar[vFrame]["PREVROW"]
                        headerNo[vFrame]=1
                        rowNo[vFrame]=1
                    else
                        vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vBar[vFrame]["BUTTON"],HeaderPos[vFrame][barNo[vFrame]],vBar[vFrame]["PREVROW"],sameCol,preCombat)
                    end
                end
                if rowNo[vFrame]>maxRows[vFrame] then
                    maxRows[vFrame]=rowNo[vFrame]
                end
                if headerNo[vFrame]>maxHeaders[vFrame] then
                    maxHeaders[vFrame]=headerNo[vFrame]
                end
                vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vBar[vFrame]["BUTTON"],false,vBar[vFrame]["PREVROW"],sameCol,preCombat)
            elseif Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][vFrame]["GRPCOLS"] then
                if HeaderPos[vFrame][barNo[vFrame]] then
                    headerNo[vFrame]=headerNo[vFrame]+1
                end
                if barNo[vFrame]==1 then
                    vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vBar[vFrame]["BUTTON"],false,false,sameCol,preCombat)
                    vBar[vFrame]["PREVCOL"]=vBar[vFrame]["PREVROW"]
                elseif headerNo[vFrame]>Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][vFrame]["NUMCOLS"] then
                    vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vBar[vFrame]["BUTTON"],false,vBar[vFrame]["PREVCOL"],newCol,preCombat)
                    vBar[vFrame]["PREVCOL"]=vBar[vFrame]["PREVROW"]
                    headerNo[vFrame]=1
                    maxCols[vFrame]=maxCols[vFrame]+1
                    rowNo[vFrame]=1
                else
                    vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vBar[vFrame]["BUTTON"],false,vBar[vFrame]["PREVROW"],sameCol,preCombat)
                end
                if rowNo[vFrame]>maxRows[vFrame] then
                    maxRows[vFrame]=rowNo[vFrame]
                end
            else
                if barNo[vFrame]==1 or rowNo[vFrame]>maxRows[vFrame] then
                    if barNo[vFrame]==1 then
                        vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vBar[vFrame]["BUTTON"],false,false,sameCol,preCombat)
                    else
                        vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vBar[vFrame]["BUTTON"],false,vBar[vFrame]["PREVCOL"],newCol,preCombat)
                        maxCols[vFrame]=maxCols[vFrame]+1
                    end
                    vBar[vFrame]["PREVCOL"]=vBar[vFrame]["PREVROW"]
                    rowNo[vFrame]=1
                else
                    vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vBar[vFrame]["BUTTON"],false,vBar[vFrame]["PREVROW"],sameCol,preCombat)
                end
            end
        end
    end)
end

function HealBot_Panel_SetupExtraBars(frame, preCombat)
    if Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][frame]["SHOW"] or
       Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][frame]["GRPCOLS"] then
        maxRows[frame]=1
    else
        maxRows[frame]=ceil(hbBarsPerFrame[frame]/Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][frame]["NUMCOLS"])
    end
    barNo[frame]=0
    rowNo[frame]=0
    headerNo[frame]=0
    maxHeaders[frame]=0
    maxCols[frame]=1
    vBar[frame]["BUTTON"]=nil
    vBar[frame]["PREVROW"]=nil
    vBar[frame]["PREVCOL"]=nil
    HealBot_Panel_PositionBars(preCombat)
    
    hbPanelNoCols[frame]=maxCols[frame]
    hbPanelNoRows[frame]=maxRows[frame]

    for xHeader,xButton in pairs(HealBot_Header_Frames) do
        if xButton.frame==frame and not HealBot_Track_Headers[xHeader] then
            HealBot_Panel_DeleteHeader(xButton.id, xHeader)
        end
    end
    if hbBarsPerFrame[frame]>0 then
        HealBot_Text_setTextLen(frame)
        hbMoveMe=0
        vSetupBarsOptionsParent=_G["f"..frame.."_HealBot_Action"]
        vSetupFrameTag=_G[vSetupBarsOptionsParent:GetName().."_UnlockTxt"]
        if not preCombat and HealBot_Action_CanMove(frame) then
            hbMoveMe=frame
            vSetupFrameTag:ClearAllPoints()
            if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][frame]["BARS"]==2 or Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][frame]["BARS"]==4 then
                vSetupFrameTag:SetPoint("TOP",vSetupBarsOptionsParent,"TOP",0,-8)
            else
                vSetupFrameTag:SetPoint("BOTTOM",vSetupBarsOptionsParent,"BOTTOM",0,8)
            end
            vSetupFrameTag:SetText(HEALBOT_ACTION_UNLOCKED)
        else
            vSetupFrameTag:SetText("")
        end
        if HealBot_Config.DisabledNow==0 then
            HealBot_Action_SetHeightWidth(maxRows[frame],maxCols[frame],maxHeaders[frame],frame)
            if HealBot_setTestBars or (Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][frame]["AUTOCLOSE"]==1 or preCombat) then
                HealBot_Action_ShowPanel(frame)
            --else
            --    HealBot_Action_HidePanel(frame)
            end
        else
            HealBot_Action_HidePanel(frame)
        end
        if Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][frame]["AUTOCLOSE"]>1 then
            HealBot_CheckActiveFrames(frame, true)
        else
            HealBot_CheckActiveFrames(frame, false)
        end
    else
        HealBot_Action_HidePanel(frame)
        HealBot_CheckActiveFrames(frame, false)
    end
end

local vSetupBarsOptionsFrame, vSetupBarsOptionsParent, vSetupFrameTag=nil, nil, nil
function HealBot_Panel_SetupBars(preCombat)
    for j=1,5 do
        if hbBarsPerFrame[j] and hbBarsPerFrame[j]>0 then
            if Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][j]["SHOW"] or
               Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j]["GRPCOLS"] then
                maxRows[j]=1
            else
                maxRows[j]=ceil(hbBarsPerFrame[j]/Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j]["NUMCOLS"])
            end
        end
    end
    for j=1,5 do
        barNo[j]=0
        rowNo[j]=0
        headerNo[j]=0
        maxHeaders[j]=0
        maxCols[j]=1
        vBar[j]["BUTTON"]=nil
        vBar[j]["PREVROW"]=nil
        vBar[j]["PREVCOL"]=nil
    end 

    HealBot_Panel_PositionBars(preCombat)

    for j=1,5 do
        hbPanelNoCols[j]=maxCols[j]
        hbPanelNoRows[j]=maxRows[j]
    end 
    
    for xHeader,xButton in pairs(HealBot_Header_Frames) do
        if xButton.frame<6 and not HealBot_Track_Headers[xHeader] then
            HealBot_Panel_DeleteHeader(xButton.id, xHeader)
        end
    end

    local vSetupBarsFrame=0
    hbMoveMe=0
    for j=1,5 do
        if hbBarsPerFrame[j]>0 then
            vSetupBarsOptionsParent=_G["f"..j.."_HealBot_Action"]
            vSetupFrameTag=_G[vSetupBarsOptionsParent:GetName().."_UnlockTxt"]
            if not preCombat and HealBot_Action_CanMove(j) then
                hbMoveMe=j
                vSetupFrameTag:ClearAllPoints()
                if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][j]["BARS"]==2 or Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][j]["BARS"]==4 then
                    vSetupFrameTag:SetPoint("TOP",vSetupBarsOptionsParent,"TOP",0,-8)
                else
                    vSetupFrameTag:SetPoint("BOTTOM",vSetupBarsOptionsParent,"BOTTOM",0,8)
                end
                vSetupFrameTag:SetText(HEALBOT_ACTION_UNLOCKED)
            else
                vSetupFrameTag:SetText("")
            end
            if vSetupBarsFrame==0 then 
                vSetupBarsFrame=j
            end
            if Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][j]["AUTOCLOSE"]>1 then
                HealBot_CheckActiveFrames(j, true)
            else
                HealBot_CheckActiveFrames(j, false)
            end
        else
            HealBot_CheckActiveFrames(j, false)
        end
    end

    if HealBot_Globals.HideOptions then
        if vSetupBarsOptionsFrame and hbOptionOn>0 then
            vSetupBarsOptionsFrame:Hide()
            hbOptionOn=0
        end
    elseif vSetupBarsFrame>0 and vSetupBarsOptionsFrame then
        vSetupBarsOptionsParent=_G["f"..vSetupBarsFrame.."_HealBot_Action"]
        if vSetupBarsOptionsFrame.frame~=vSetupBarsFrame then
            vSetupBarsOptionsFrame:Hide()
            vSetupBarsOptionsFrame:ClearAllPoints()
            vSetupBarsOptionsFrame:SetParent(vSetupBarsOptionsParent)
            vSetupBarsOptionsFrame.frame=vSetupBarsFrame
        end
        vSetupBarsOptionsFrame:ClearAllPoints()
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][vSetupBarsFrame]["BARS"]==2 or Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][vSetupBarsFrame]["BARS"]==4 then
            if hbMoveMe==vSetupBarsFrame then
                vSetupBarsOptionsFrame:SetPoint("TOP",vSetupBarsOptionsParent,"TOP",0,-30);
            else
                vSetupBarsOptionsFrame:SetPoint("TOP",vSetupBarsOptionsParent,"TOP",0,-10);
            end
        else
            if hbMoveMe==vSetupBarsFrame then
                vSetupBarsOptionsFrame:SetPoint("BOTTOM",vSetupBarsOptionsParent,"BOTTOM",0,30);
            else
                vSetupBarsOptionsFrame:SetPoint("BOTTOM",vSetupBarsOptionsParent,"BOTTOM",0,10);
            end
        end
        vSetupBarsOptionsFrame:Show();
        hbOptionOn=vSetupBarsFrame
    elseif hbOptionOn>0 and vSetupBarsOptionsFrame then
        vSetupBarsOptionsFrame:Hide()
        hbOptionOn=0
    end
    
    for j=1,5 do
        if hbBarsPerFrame[j]>0 then
            if HealBot_Config.DisabledNow==0 then
                HealBot_Text_setTextLen(j)
                if HealBot_setTestBars or (Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][j]["AUTOCLOSE"]==1 or preCombat) then
                    HealBot_Action_ShowPanel(j)
                end
                HealBot_Action_SetHeightWidth(maxRows[j],maxCols[j],maxHeaders[j],j)
            else
                HealBot_Action_HidePanel(j)
            end
        else
            HealBot_Action_HidePanel(j)
        end
    end
end

function HealBot_Panel_InitOptBars()
    vSetupBarsOptionsFrame=_G["HealBot_Action_OptionsButton"]
    if not vSetupBarsOptionsFrame then
        vSetupBarsOptionsParent=_G["f1_HealBot_Action"]
        vSetupBarsOptionsFrame=CreateFrame("Button", "HealBot_Action_OptionsButton", vSetupBarsOptionsParent, "HealBotOptionsButtonTemplate") 
        local bar = _G[vSetupBarsOptionsFrame:GetName().."Bar"]
        bar:SetStatusBarColor(0.1,0.1,0.4,0);
        bar:SetMinMaxValues(0,100);
        bar:SetValue(0);
        bar:UnregisterAllEvents()
        vSetupBarsOptionsFrame.frame=1
        bar.txt = _G[bar:GetName().."_text"];
        bar.txt:SetTextColor(0.8,0.8,0.2,0.85);
        bar.txt:SetText(HEALBOT_ACTION_OPTIONS);
        bar = _G[vSetupBarsOptionsFrame:GetName().."Bar5"]
        bar:SetStatusBarColor(0.1,0.1,0.4,0);
        bar:SetMinMaxValues(0,100);
        bar:SetValue(0);
        bar:UnregisterAllEvents()
        vSetupBarsOptionsFrame:Hide()
    end
end

function HealBot_Panel_RandomClassColour(tRole)
    local newCol=1
    while newCol>0 do
        if not tRole then
            HealBot_randomN=random(11)
        elseif tRole==HEALBOT_WORD_HEALER then
            HealBot_randomN=random(3,7)
        else
            HealBot_randomN=random(1,5)
        end
        if HealBot_randomN~=prevCol then
            prevCol=HealBot_randomN
            newCol=0
        end
    end
    return HealBot_randomClCol[HealBot_randomN][1],
           HealBot_randomClCol[HealBot_randomN][2],
           HealBot_randomClCol[HealBot_randomN][3],
           HealBot_randomClCol[HealBot_randomN][4]
end

local hbHealButtonsConcat={[1]="", [2]="~", [3]="1"}
function HealBot_Panel_TestBarShow(index,button,tRole,r,g,b)
    hbHealButtonsConcat[1]=button.unit
    hbHealButtonsConcat[3]="5"
    table.insert(HealBot_Action_HealButtons,table.concat(hbHealButtonsConcat))
    HealBot_TrackUnit[button.unit]=true
    HealBot_TestBarsActive[index]=button
    local HealBot_keepClass=false
    local HealBot_keepClass2=false
    local HealBot_showName=false
    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["NAMEONBAR"] or 
       Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["CLASSONBAR"] then
        HealBot_showName=true
    end
    if not HealBot_setTestCols[index] then
        button.text.r,button.text.g,button.text.b=r,g,b
        if (Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HLTH"] >= 2) then
            if (Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HLTH"] == 2) then
                HealBot_colIndex["hcr"..index],HealBot_colIndex["hcg"..index],HealBot_colIndex["hcb"..index] = r,g,b
                if Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NAME"]==2 then
                    HealBot_keepClass=true
                    HealBot_colIndex["hctr"..index],HealBot_colIndex["hctg"..index],HealBot_colIndex["hctb"..index] = HealBot_colIndex["hcr"..index],HealBot_colIndex["hcg"..index],HealBot_colIndex["hcb"..index]
                end
                if Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["HLTH"]==2 then
                    HealBot_keepClass2=true
                    HealBot_colIndex["hctr2"..index],HealBot_colIndex["hctg2"..index],HealBot_colIndex["hctb2"..index] = HealBot_colIndex["hcr"..index],HealBot_colIndex["hcg"..index],HealBot_colIndex["hcb"..index]
                end
            else
                HealBot_colIndex["hcr"..index]=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HR"]
                HealBot_colIndex["hcg"..index]=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HG"]
                HealBot_colIndex["hcb"..index]=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HB"]
            end
        else
            HealBot_colIndex["hcr"..index],HealBot_colIndex["hcg"..index],HealBot_colIndex["hcb"..index] = 0,1,0
        end
        if not HealBot_keepClass then
            if Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NAME"]==2 then
                HealBot_colIndex["hctr"..index],HealBot_colIndex["hctg"..index],HealBot_colIndex["hctb"..index] = r,g,b
                if Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["HLTH"]==2 then
                    HealBot_keepClass2=true
                    HealBot_colIndex["hctr2"..index],HealBot_colIndex["hctg2"..index],HealBot_colIndex["hctb2"..index] = HealBot_colIndex["hctr"..index],HealBot_colIndex["hctg"..index],HealBot_colIndex["hctb"..index]
                end
            elseif Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NAME"]==1 then
                HealBot_colIndex["hctr"..index],HealBot_colIndex["hctg"..index],HealBot_colIndex["hctb"..index] = 0,1,0
            else
                HealBot_colIndex["hctr"..index] = Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NCR"]
                HealBot_colIndex["hctg"..index] = Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NCG"]
                HealBot_colIndex["hctb"..index] = Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NCB"]
            end
        end
        if not HealBot_keepClass2 then
            if Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["HLTH"]==2 then
                HealBot_colIndex["hctr2"..index],HealBot_colIndex["hctg2"..index],HealBot_colIndex["hctb2"..index] = r,g,b
            elseif Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["HLTH"]==1 then
                HealBot_colIndex["hctr2"..index],HealBot_colIndex["hctg2"..index],HealBot_colIndex["hctb2"..index] = 0,1,0
            else
                HealBot_colIndex["hctr2"..index] = Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["HCR"]
                HealBot_colIndex["hctg2"..index] = Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["HCG"]
                HealBot_colIndex["hctb2"..index] = Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["HCB"]
            end
        end
        button.gref["Bar"]:SetValue(1000)
        button.gref["Bar"]:SetStatusBarColor(HealBot_colIndex["hcr"..index],HealBot_colIndex["hcg"..index],HealBot_colIndex["hcb"..index],Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"]);
        HealBot_setTestCols[index]=true
    end
    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHONBAR"] then
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTYPE"]==1 then
            button.gref.txt["text2"]:SetText("10K");
        elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTYPE"]==2 then
            button.gref.txt["text2"]:SetText("(0)");
        else
            button.gref.txt["text2"]:SetText("(100%)");
        end
    else
        button.gref.txt["text2"]:SetText("")
    end
    if HealBot_showName then
        button.gref.txt["text"]:SetText(button.unit)
        button.gref.txt["text"]:SetTextColor(HealBot_colIndex["hctr"..index],HealBot_colIndex["hctg"..index],HealBot_colIndex["hctb"..index],Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["NCA"]);
    else
        button.gref.txt["text"]:SetText("")
        button.gref.txt["text"]:SetTextColor(0,0,0,0);
    end
    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHONBAR"] then
        button.gref.txt["text2"]:SetTextColor(HealBot_colIndex["hctr2"..index],HealBot_colIndex["hctg2"..index],HealBot_colIndex["hctb2"..index],Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["HCA"]);
    else
        button.gref.txt["text2"]:SetTextColor(0,0,0,0)
    end
    button:Show()
    if button.frame<10 and Healbot_Config_Skins.Spells[Healbot_Config_Skins.Current_Skin][button.frame]["USE"] then
        HealBot_Emerg_Button[button.id]:Show()
    end
end

function HealBot_Panel_testAddButton(gName,bName,minBar,maxBar,tRole)
    local k=i[hbCurrentFrame]
    for j=minBar,maxBar do
        if noBars>0 then
            local tcR,tcG,tcB,tcC=HealBot_Panel_RandomClassColour(tRole)
            local tstb=HealBot_Action_SetTestButton(hbCurrentFrame, HEALBOT_WORD_TEST.." "..bName.." "..j,tRole,tcC)
            if tstb then 
                local bIndex=tstb.id
                HealBot_Panel_TestBarShow(bIndex,tstb,tRole,tcR,tcG,tcB)
                noBars=noBars-1
                i[hbCurrentFrame]=i[hbCurrentFrame]+1
                hbBarsPerFrame[tstb.frame]=hbBarsPerFrame[tstb.frame]+1
            end
        end
    end
    if i[hbCurrentFrame]>k and not tHeader[gName] then
        HeaderPos[hbCurrentFrame][k+1] = gName
        tHeader[gName]=true
        if bName==HEALBOT_OPTIONS_EMERGENCYHEALS or bName==HEALBOT_OPTIONS_GROUPHEALS then
            grpNo=grpNo+1
        end
    end
end

function HealBot_Panel_TestBarsOn()
    HealBot_Action_resetTestBarsCounters()
    if HealBot_Panel_luVars["TestBarsDelAll"] then
        HealBot_Panel_luVars["TestBarsDelAll"]=false
        for _,xButton in pairs(HealBot_Unit_Button) do
            HealBot_Action_MarkDeleteButton(xButton)
        end
        for _,xButton in pairs(HealBot_Private_Button) do
            HealBot_Action_MarkDeleteButton(xButton)
        end
        for _,xButton in pairs(HealBot_Enemy_Button) do
            HealBot_Action_MarkDeleteButton(xButton)
        end
        for _,xButton in pairs(HealBot_Pet_Button) do
            HealBot_Action_MarkDeleteButton(xButton)
        end
        for _,xButton in pairs(HealBot_Extra_Button) do
            HealBot_Action_MarkDeleteButton(xButton)
        end
        for xHeader,xButton in pairs(HealBot_Header_Frames) do
            HealBot_Panel_DeleteHeader(xButton.id, xHeader)
        end
    end
    for x,_ in pairs(HealBot_Action_HealButtons) do
        HealBot_Action_HealButtons[x]=nil;
    end 
    for x,b in pairs(HealBot_TestBarsActive) do
        HealBot_TestBarsActive[x]=nil
    end
    for xHeader in pairs(HealBot_Track_Headers) do
        HealBot_Track_Headers[xHeader]=false
    end
    for x,_ in pairs(tHeader) do
        tHeader[x]=nil
    end
    for gl=1,10 do
        HeaderPos[gl]={};
        hbBarsPerFrame[gl]=0
    end
    noBars=tonumber(HealBot_noBars)
    for gl=1,10 do
        i[gl]=0
    end
    grpNo=1
    local gNo=5
    local healGroups=Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin]
    local xRaidBars=40
    if HealBot_Globals.TestBars["PROFILE"]==3 then xRaidBars=25 end
    if HealBot_Globals.TestBars["PROFILE"]==2 then xRaidBars=10 end
    if HealBot_Globals.TestBars["PROFILE"]==1 then xRaidBars=5 end

    for gl=1,11 do
        hbCurrentFrame=healGroups[gl]["FRAME"]
        if HealBot_Action_hasPowerCounter(gl)>0 then
            HealBot_Action_setLuVars("showTestPowerIndicator", HealBot_Action_hasPowerCounter(gl))
        end
        if healGroups[gl]["NAME"]==HEALBOT_OPTIONS_SELFHEALS_en then
            if healGroups[gl]["STATE"] then
                HealBot_Panel_testAddButton(HEALBOT_OPTIONS_SELFHEALS,HEALBOT_OPTIONS_SELFHEALS,1,1,"HEALER")
                gNo=4
                if not Healbot_Config_Skins.DuplicateBars[Healbot_Config_Skins.Current_Skin] then
                    xRaidBars=xRaidBars-1
                end
            end
        elseif healGroups[gl]["NAME"]==HEALBOT_OPTIONS_TANKHEALS_en then
            local nTanks=HealBot_Globals.TestBars["TANKS"]
            if HealBot_Globals.TestBars["PROFILE"]==1 then nTanks=1 end
            if nTanks>0 and healGroups[gl]["STATE"] then
                HealBot_Panel_testAddButton(HEALBOT_OPTIONS_TANKHEALS,HEALBOT_WORD_TANK,1,nTanks,"TANK")
                if not Healbot_Config_Skins.DuplicateBars[Healbot_Config_Skins.Current_Skin] then
                    xRaidBars=xRaidBars-nTanks
                end
            end
        elseif healGroups[gl]["NAME"]==HEALBOT_CLASSES_HEALERS_en then
            local nHealers=HealBot_Globals.TestBars["HEALERS"]
            if HealBot_Globals.TestBars["PROFILE"]==1 then nHealers=1 end
            if nHealers>0 and healGroups[gl]["STATE"] then
                HealBot_Panel_testAddButton(HEALBOT_CLASSES_HEALERS,HEALBOT_WORD_HEALER,1,nHealers,"HEALER")
                if not Healbot_Config_Skins.DuplicateBars[Healbot_Config_Skins.Current_Skin] then
                    xRaidBars=xRaidBars-nHealers
                end
            end
        elseif healGroups[gl]["NAME"]==HEALBOT_OPTIONS_GROUPHEALS_en then
            if gNo>xRaidBars then gNo=xRaidBars end
            if healGroups[gl]["STATE"] and gNo>0 then
                HealBot_Panel_testAddButton(HEALBOT_OPTIONS_GROUPHEALS.." "..grpNo,HEALBOT_OPTIONS_GROUPHEALS,1,gNo)
                xRaidBars=xRaidBars-gNo
            end
        elseif healGroups[gl]["NAME"]==HEALBOT_OPTIONS_MYTARGET_en then
            if HealBot_Globals.TestBars["TARGETS"]>0 and healGroups[gl]["STATE"] then
                --HealBot_Panel_testAddButton(HEALBOT_OPTIONS_MYTARGET,HEALBOT_DISABLED_TARGET,1,HealBot_Globals.TestBars["TARGETS"])
                HealBot_Panel_testAddButton(HEALBOT_OPTIONS_MYTARGET,HEALBOT_OPTIONS_MYTARGET,1,HealBot_Globals.TestBars["TARGETS"])
                if not Healbot_Config_Skins.DuplicateBars[Healbot_Config_Skins.Current_Skin] then
                    xRaidBars=xRaidBars-HealBot_Globals.TestBars["TARGETS"]
                end
            end
        elseif healGroups[gl]["NAME"]==HEALBOT_OPTIONS_PETHEALS_en and hbCurrentFrame<6 then
            if HealBot_Globals.TestBars["PETS"]>0 and healGroups[gl]["STATE"] then
                HealBot_Panel_testAddButton(HEALBOT_OPTIONS_PETHEALS,HEALBOT_WORD_PET,1,HealBot_Globals.TestBars["PETS"])
                xRaidBars=xRaidBars-HealBot_Globals.TestBars["TARGETS"]
            end
        elseif healGroups[gl]["NAME"]==HEALBOT_OPTIONS_EMERGENCYHEALS_en then
            if healGroups[gl]["STATE"] and xRaidBars>0 then
                if Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["RAIDORDER"]==3 then
                    if xRaidBars<5 then
                        if HealBot_Globals.TestBars["PROFILE"]>1 then
                            HealBot_Panel_testAddButton(HEALBOT_OPTIONS_EMERGENCYHEALS.." "..HEALBOT_OPTIONS_GROUPHEALS.." "..grpNo,HEALBOT_OPTIONS_EMERGENCYHEALS,1,xRaidBars)
                        else
                            HealBot_Panel_testAddButton(HEALBOT_OPTIONS_GROUPHEALS.." "..grpNo,HEALBOT_OPTIONS_GROUPHEALS,1,xRaidBars)
                        end
                    else
                        if HealBot_Globals.TestBars["PROFILE"]>1 then
                            HealBot_Panel_testAddButton(HEALBOT_OPTIONS_EMERGENCYHEALS.." "..HEALBOT_OPTIONS_GROUPHEALS.." "..grpNo,HEALBOT_OPTIONS_EMERGENCYHEALS,1,5)
                        else
                            HealBot_Panel_testAddButton(HEALBOT_OPTIONS_GROUPHEALS.." "..grpNo,HEALBOT_OPTIONS_GROUPHEALS,1,5)
                        end
                    end
                    if xRaidBars>5 then
                        if xRaidBars<10 then
                            HealBot_Panel_testAddButton(HEALBOT_OPTIONS_EMERGENCYHEALS.." "..HEALBOT_OPTIONS_GROUPHEALS.." "..grpNo,HEALBOT_OPTIONS_EMERGENCYHEALS,6,xRaidBars)
                        else
                            HealBot_Panel_testAddButton(HEALBOT_OPTIONS_EMERGENCYHEALS.." "..HEALBOT_OPTIONS_GROUPHEALS.." "..grpNo,HEALBOT_OPTIONS_EMERGENCYHEALS,6,10)
                        end
                    end
                    if xRaidBars>10 then
                        if xRaidBars<15 then
                            HealBot_Panel_testAddButton(HEALBOT_OPTIONS_EMERGENCYHEALS.." "..HEALBOT_OPTIONS_GROUPHEALS.." "..grpNo,HEALBOT_OPTIONS_EMERGENCYHEALS,11,xRaidBars)
                        else
                            HealBot_Panel_testAddButton(HEALBOT_OPTIONS_EMERGENCYHEALS.." "..HEALBOT_OPTIONS_GROUPHEALS.." "..grpNo,HEALBOT_OPTIONS_EMERGENCYHEALS,11,15)
                        end
                    end
                    if xRaidBars>15 then
                        if xRaidBars<20 then
                            HealBot_Panel_testAddButton(HEALBOT_OPTIONS_EMERGENCYHEALS.." "..HEALBOT_OPTIONS_GROUPHEALS.." "..grpNo,HEALBOT_OPTIONS_EMERGENCYHEALS,16,xRaidBars)
                        else
                            HealBot_Panel_testAddButton(HEALBOT_OPTIONS_EMERGENCYHEALS.." "..HEALBOT_OPTIONS_GROUPHEALS.." "..grpNo,HEALBOT_OPTIONS_EMERGENCYHEALS,16,20)
                        end
                    end
                    if xRaidBars>20 then
                        if xRaidBars<25 then
                            HealBot_Panel_testAddButton(HEALBOT_OPTIONS_EMERGENCYHEALS.." "..HEALBOT_OPTIONS_GROUPHEALS.." "..grpNo,HEALBOT_OPTIONS_EMERGENCYHEALS,21,xRaidBars)
                        else
                            HealBot_Panel_testAddButton(HEALBOT_OPTIONS_EMERGENCYHEALS.." "..HEALBOT_OPTIONS_GROUPHEALS.." "..grpNo,HEALBOT_OPTIONS_EMERGENCYHEALS,21,25)
                        end
                    end
                    if xRaidBars>25 then
                        if xRaidBars<30 then
                            HealBot_Panel_testAddButton(HEALBOT_OPTIONS_EMERGENCYHEALS.." "..HEALBOT_OPTIONS_GROUPHEALS.." "..grpNo,HEALBOT_OPTIONS_EMERGENCYHEALS,26,xRaidBars)
                        else
                            HealBot_Panel_testAddButton(HEALBOT_OPTIONS_EMERGENCYHEALS.." "..HEALBOT_OPTIONS_GROUPHEALS.." "..grpNo,HEALBOT_OPTIONS_EMERGENCYHEALS,26,30)
                        end
                    end
                    if xRaidBars>30 then
                        if xRaidBars<35 then
                            HealBot_Panel_testAddButton(HEALBOT_OPTIONS_EMERGENCYHEALS.." "..HEALBOT_OPTIONS_GROUPHEALS.." "..grpNo,HEALBOT_OPTIONS_EMERGENCYHEALS,31,xRaidBars)
                        else
                            HealBot_Panel_testAddButton(HEALBOT_OPTIONS_EMERGENCYHEALS.." "..HEALBOT_OPTIONS_GROUPHEALS.." "..grpNo,HEALBOT_OPTIONS_EMERGENCYHEALS,31,35)
                        end
                    end
                    if xRaidBars>35 then
                        HealBot_Panel_testAddButton(HEALBOT_OPTIONS_EMERGENCYHEALS.." "..HEALBOT_OPTIONS_GROUPHEALS.." "..grpNo,HEALBOT_OPTIONS_EMERGENCYHEALS,36,xRaidBars)
                    end
                elseif HealBot_Globals.TestBars["PROFILE"]>1 then
                    HealBot_Panel_testAddButton(HEALBOT_OPTIONS_EMERGENCYHEALS.." "..HEALBOT_OPTIONS_GROUPHEALS.." "..grpNo,HEALBOT_OPTIONS_EMERGENCYHEALS,1,xRaidBars)
                else
                    HealBot_Panel_testAddButton(HEALBOT_OPTIONS_GROUPHEALS.." "..grpNo,HEALBOT_OPTIONS_GROUPHEALS,1,xRaidBars)
                end
            end
        end
        HealBot_Action_setLuVars("showTestPowerIndicator", 0)
    end
    
    HealBot_Panel_SetupBars(true)
    
    if healGroups[10]["STATE"] then
        hbCurrentFrame=9
        for x,_ in pairs(HealBot_Action_HealButtons) do
            HealBot_Action_HealButtons[x]=nil;
        end 
        HealBot_Panel_testAddButton(HEALBOT_FOCUS,HEALBOT_FOCUS,1,1)
        HealBot_Panel_SetupExtraBars(9, true)
    else
        HealBot_Action_HidePanel(9)
    end
    
    if healGroups[9]["STATE"] then
        hbCurrentFrame=8
        for x,_ in pairs(HealBot_Action_HealButtons) do
            HealBot_Action_HealButtons[x]=nil;
        end 
        HealBot_Panel_testAddButton(HEALBOT_OPTIONS_TARGETHEALS,HEALBOT_OPTIONS_TARGETHEALS,1,1)
        HealBot_Panel_SetupExtraBars(8, true)
    else
        HealBot_Action_HidePanel(8)
    end
    
    if HealBot_Globals.TestBars["PETS"]>0 and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["FRAME"]==7 and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["STATE"] then
        hbCurrentFrame=7
        for x,_ in pairs(HealBot_Action_HealButtons) do
            HealBot_Action_HealButtons[x]=nil;
        end 
        HealBot_Panel_testAddButton(HEALBOT_OPTIONS_PETHEALS,HEALBOT_WORD_PET,1,HealBot_Globals.TestBars["PETS"])
        HealBot_Panel_SetupExtraBars(7, true)
    else
        HealBot_Action_HidePanel(7)
    end
    
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["FRAME"]==6 and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["STATE"] then
        hbCurrentFrame=6
        for x,_ in pairs(HealBot_Action_HealButtons) do
            HealBot_Action_HealButtons[x]=nil;
        end 
        HealBot_Panel_testAddButton(HEALBOT_VEHICLE,HEALBOT_VEHICLE,1,2)
        HealBot_Panel_SetupExtraBars(6, true)
    else
        HealBot_Action_HidePanel(6)
    end
    
    if healGroups[11]["STATE"] then
        hbCurrentFrame=10
        for x,_ in pairs(HealBot_Action_HealButtons) do
            HealBot_Action_HealButtons[x]=nil;
        end 
        HealBot_Panel_testAddButton(HEALBOT_CUSTOM_CASTBY_ENEMY,HEALBOT_CUSTOM_CASTBY_ENEMY,1,HealBot_Globals.TestBars["ENEMY"],HEALBOT_CUSTOM_CASTBY_ENEMY)
        HealBot_Panel_SetupExtraBars(10, true)
    else
        HealBot_Action_HidePanel(10)
    end
    for _,xButton in pairs(HealBot_Unit_Button) do
        if not HealBot_TestBarsActive[xButton.id] then
            HealBot_setTestCols[xButton.id]=false
            HealBot_Action_MarkDeleteButton(xButton)
        end
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        if not HealBot_TestBarsActive[xButton.id] then
            HealBot_setTestCols[xButton.id]=false
            HealBot_Action_MarkDeleteButton(xButton)
        end
    end
    for _,xButton in pairs(HealBot_Enemy_Button) do
        if not HealBot_TestBarsActive[xButton.id] then
            HealBot_setTestCols[xButton.id]=false
            HealBot_Action_MarkDeleteButton(xButton)
        end
    end
    for _,xButton in pairs(HealBot_Pet_Button) do
        if not HealBot_TestBarsActive[xButton.id] then
            HealBot_setTestCols[xButton.id]=false
            HealBot_Action_MarkDeleteButton(xButton)
        end
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        if not HealBot_TestBarsActive[xButton.id] then
            HealBot_setTestCols[xButton.id]=false
            HealBot_Action_MarkDeleteButton(xButton)
        end
    end
    for xHeader,xButton in pairs(HealBot_Header_Frames) do
        if not HealBot_Track_Headers[xHeader] then
            HealBot_Panel_DeleteHeader(xButton.id, xHeader)
        end
    end
end

function HealBot_Panel_resetTestCols(force)
    if HealBot_setTestBars then
        if force then HealBot_setTestCols={} end
        HealBot_nextRecalcParty(0)
    end
end

function HealBot_Panel_enemyBar(eUnit, pUnit)
    i[hbCurrentFrame]=i[hbCurrentFrame]+1
    table.insert(units,eUnit)
    hbPanel_enemyUnits[pUnit]=true
    if Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["ENEMYTARGET"] then
        HealBot_SpecialUnit[eUnit]=1
        HealBot_SpecialUnit[eUnit.."target"]=2
    else
        HealBot_SpecialUnit[eUnit]=nil
        HealBot_SpecialUnit[eUnit.."target"]=nil
    end
end

function HealBot_Panel_checkEnemyBar(eUnit, pUnit, preCombat, existsShow, preCombatShow)
    if preCombat then
        if preCombatShow==2 then
            if UnitExists(pUnit) and UnitExists(eUnit) and not UnitIsUnit(pUnit,eUnit) then
                HealBot_Panel_enemyBar(eUnit, pUnit)
            end
        else
            HealBot_Panel_enemyBar(eUnit, pUnit)
        end
    elseif existsShow>1 then
        if existsShow==2 then
            if HealBot_ValidLivingEnemy(pUnit, eUnit) then
                HealBot_Panel_enemyBar(eUnit, pUnit)
            end
        else
            HealBot_Panel_enemyBar(eUnit, pUnit)
        end
    end
end

local vSubSortUnit,vSubSortGUID,vExists,vDup,vRole="","",false,false,3
function HealBot_Panel_SubSort(doSubSort,unitType, preCombat)
    if doSubSort and Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["SUBORDER"]<6 then
        table.sort(subunits,function (a,b)
            if not suborder[a] or not suborder[b] then
                return false
            else
                if suborder[a]<suborder[b] then return true end
                if suborder[a]>suborder[b] then return false end
                return a<b
            end
        end)
    end
    for j=1,#subunits do
        vSubSortUnit=subunits[j] or "x";
        vSubSortGUID=UnitGUID(vSubSortUnit) or vSubSortUnit
        vExists=false
        vDup=false
        if Healbot_Config_Skins.DuplicateBars[Healbot_Config_Skins.Current_Skin] then
            if unitType<5 then
                if HealBot_TrackPrivateUnit[vSubSortUnit] then vExists=true end
                if HealBot_TrackUnit[vSubSortUnit] then vDup=true end
            else
                if HealBot_TrackUnit[vSubSortUnit] then vExists=true end
                if HealBot_TrackPrivateUnit[vSubSortUnit] then vDup=true end
            end
        elseif HealBot_TrackUnit[vSubSortUnit] or HealBot_TrackPrivateUnit[vSubSortUnit] then
            vExists=true
        end
        if not vExists and not HealBot_Panel_BlackList[vSubSortGUID] then
            vRole=3
            if HealBot_MainTanks[vSubSortGUID] then 
                vRole=1 
            elseif HealBot_MainHealers[vSubSortGUID] then 
                vRole=2
            end
            if HealBot_Action_SetHealButton(vSubSortUnit,vSubSortGUID,hbCurrentFrame,unitType,vDup,vRole,preCombat) then
                if unitType<5 then
                    HealBot_TrackPrivateUnit[vSubSortUnit]=true
                else
                    HealBot_TrackUnit[vSubSortUnit]=true
                end
                hbHealButtonsConcat[1]=vSubSortUnit
                hbHealButtonsConcat[3]=unitType
                table.insert(HealBot_Action_HealButtons,table.concat(hbHealButtonsConcat))
                --if (not HealBot_SpecialUnit[vSubSortUnit] or HealBot_SpecialUnit[vSubSortUnit]==1) then
                    hbBarsPerFrame[hbCurrentFrame]=hbBarsPerFrame[hbCurrentFrame]+1
                --end
            end
        end
    end
    for x,_ in pairs(suborder) do
        suborder[x]=nil;
    end
    for x,_ in pairs(subunits) do
        subunits[x]=nil;
    end
end

local vSubOrderKey,allowOOR=99,true
function HealBot_Panel_sortOrder(unit, barOrder, mainSort)
    vSubOrderKey=99
    if mainSort and Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["SHOW"] then
        allowOOR=false
    else
        allowOOR=true
    end
    if barOrder==1 then
        if unit == "player" then
            if Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["SUBPF"] then
                vSubOrderKey = "!";
            else
                vSubOrderKey = UnitName(unit) or unit
            end
        elseif UnitExists(unit) then
            if Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["OORLAST"] and not UnitInRange(unit) then
                vSubOrderKey = "ÿÿÿþ"..(UnitName(unit) or unit)
            else
                vSubOrderKey = UnitName(unit) or unit
            end
        else
            vSubOrderKey = "ÿÿÿÿ"..unit
        end
    elseif barOrder==2 then
        if unit == "player" then
            if not mainSort and Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["SUBPF"] then
                vSubOrderKey = "!";
            else
                vSubOrderKey = HealBot_Panel_classEN(unit)
            end
        elseif UnitExists(unit) then
            if allowOOR and Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["OORLAST"] and not UnitInRange(unit) then
                vSubOrderKey = "ÿÿÿþ"..HealBot_Panel_classEN(unit)
            else
                vSubOrderKey = HealBot_Panel_classEN(unit)
            end
        else
            vSubOrderKey = "ÿÿÿÿ"..unit
        end
    elseif barOrder==3 then
        if unit == "player" then 
            if not mainSort and Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["SUBPF"] then
                vSubOrderKey = -1
            else
                vSubOrderKey = HealBot_UnitGroups[unit] or 1
            end 
        elseif UnitExists(unit) then
            if allowOOR and Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["OORLAST"] and not UnitInRange(unit) then
                vSubOrderKey = 9+(HealBot_UnitGroups[unit] or 1)
            else
                vSubOrderKey = HealBot_UnitGroups[unit] or 1
            end
        else
            vSubOrderKey = (HealBot_UnitGroups[unit] or 1)
        end
    elseif barOrder==4 then
        if unit == "player" then
            if Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["SUBPF"] then
                vSubOrderKey = -99999999
            else
                vSubOrderKey = 0-UnitHealthMax(unit)
            end
        elseif UnitExists(unit) then
            if Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["OORLAST"] and not UnitInRange(unit) then
                vSubOrderKey = 9999999-UnitHealthMax(unit)
            else
                vSubOrderKey = 0-UnitHealthMax(unit)
            end
        else
            vSubOrderKey = 99999999
        end
        if UnitIsPlayer(unit) and UnitHealthMax(unit)>TempMaxH then TempMaxH=UnitHealthMax(unit); end
    elseif barOrder==5 then
        if unit == "player" then 
            if not mainSort and Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["SUBPF"] then
                vSubOrderKey = -1
            else 
                vSubOrderKey = HealBot_unitRole[unit] or 9
            end
        elseif UnitExists(unit) then
            if allowOOR and Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["OORLAST"] and not UnitInRange(unit) then
                vSubOrderKey = 59+(HealBot_unitRole[unit] or 9)
            else
                vSubOrderKey = HealBot_unitRole[unit] or 9
            end
        else
            vSubOrderKey = 99+(HealBot_unitRole[unit] or 9)
        end
    end
    return vSubOrderKey
end

function HealBot_Panel_insSort(unit, mainSort)
    if unit then
        if mainSort then 
            if Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["RAIDORDER"]<6 then
                order[unit] = HealBot_Panel_sortOrder(unit, Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["RAIDORDER"], mainSort)
            end
            table.insert(units,unit)
        else
            if Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["SUBORDER"]<6 then
                suborder[unit] = HealBot_Panel_sortOrder(unit, Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["SUBORDER"], mainSort)
            end
            table.insert(subunits,unit)
        end
    end
end

function HealBot_Panel_SetFocusGroups()
    if HealBot_Globals.OverrideEffects["USE"]==2 then
        HealBot_Panel_luVars["FocusGroups"]=HealBot_Globals.OverrideEffects["FOCUSGROUPS"]
        HealBot_Panel_luVars["FGroups"]=HealBot_Globals.OverrideFocusGroups
    else
        HealBot_Panel_luVars["FocusGroups"]=Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["FOCUSGROUPS"]
        HealBot_Panel_luVars["FGroups"]=Healbot_Config_Skins.FocusGroups[Healbot_Config_Skins.Current_Skin]
    end
end

function HealBot_Panel_addUnit(unit, unitType, hbGUID, isRaidGroup)
    if HealBot_Panel_luVars["FocusGroups"]<3 or unitType~=5 or HealBot_Panel_luVars["FGroups"][HealBot_UnitGroups[unit]] then
        local uExists=false
        if Healbot_Config_Skins.DuplicateBars[Healbot_Config_Skins.Current_Skin] then
            if unitType<5 then
                if HealBot_TrackPrivateNames[hbGUID] then uExists=true end
            else
                if HealBot_TrackNames[hbGUID] then uExists=true end
            end
        elseif HealBot_TrackNames[hbGUID] or HealBot_TrackPrivateNames[hbGUID] then
            uExists=true
        end
        if not uExists then
            if UnitIsVisible(unit) or not Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["HIDEOOR"] then
                if not isRaidGroup then i[hbCurrentFrame] = i[hbCurrentFrame]+1; end
                if unitType<5 then
                    HealBot_TrackPrivateNames[hbGUID]=true
                else
                    HealBot_TrackNames[hbGUID]=true;
                end
                HealBot_Panel_insSort(unit, true)
            elseif isRaidGroup then
                HealBot_setNotVisible(unit,6)
            else
                HealBot_setNotVisible(unit,0)
            end
        end
    end
end

--local vMainSortIndex,vMainSortKey=0,""
local vMainSortKey=""
function HealBot_Panel_MainSort(doMainSort,unitType, preCombat)
    if #units>0 then
        if doMainSort and Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["RAIDORDER"]<6 then
            --vMainSortIndex=0
            table.sort(units,function (a,b)
                if order[a]<order[b] then return true end
                if order[a]>order[b] then return false end
                return a<b
            end)
            vMainSortKey=order[units[1]]
            for j=1,#units do
                if vMainSortKey~=order[units[j]] then
                    HealBot_Panel_SubSort(true, unitType, preCombat)
                    --vMainSortIndex=j
                    vMainSortKey=order[units[j]]
                end
                HealBot_Panel_insSort(units[j], false)
            end
            --if vMainSortIndex<#units then
                HealBot_Panel_SubSort(true, unitType, preCombat)
            --end
        else
            for j=1,#units do
                HealBot_Panel_insSort(units[j], false)
            end
            HealBot_Panel_SubSort(true, unitType, preCombat)
        end
    end
    for x,_ in pairs(order) do
        order[x]=nil;
    end
    for x,_ in pairs(units) do
        units[x]=nil;
    end
      --HealBot_setCall("HealBot_Panel_MainSort")
end

function HealBot_Panel_addUnits(doMainSort,unitType,hText,k, preCombat)
    HealBot_Panel_MainSort(doMainSort,unitType, preCombat)
    HeaderPos[hbCurrentFrame][k+1] = hText 
      --HealBot_setCall("HealBot_Panel_addUnits")
end

local vEnemyIndex,vEnemyLocation,vEnemyBossNum,vEnemyBossExist=0,"",0,1
function HealBot_Panel_enemyTargets(preCombat)
    HeaderPos[hbCurrentFrame][i[hbCurrentFrame]+1] = HEALBOT_OPTIONS_TARGETHEALS
    vEnemyIndex=i[hbCurrentFrame]
    if Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCSELF"] then
        HealBot_Panel_checkEnemyBar("playertarget", "player", preCombat, 
                                    Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["EXISTSHOWPTAR"],
                                    Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCOMBATSHOWSELF"])
    end
    _,vEnemyLocation = IsInInstance()
    if vEnemyLocation == "arena" then
        if Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCARENA"] then
            for j=1,GetNumGroupMembers() do
                xUnit="arena"..j;
                HealBot_Panel_checkEnemyBar(xUnit, "player", preCombat, 
                                            Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["EXISTSHOWARENA"],
                                            Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCOMBATSHOWSELF"])
            end
        end
        if Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCARENAPETS"] then
            for j=1,GetNumGroupMembers() do
                xUnit="arenapet"..j;
                HealBot_Panel_checkEnemyBar(xUnit, "player", preCombat, 
                                            Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["EXISTSHOWARENA"],
                                            Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCOMBATSHOWSELF"])
            end
        end
    end
    if Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCTANKS"] then
        for _,xUnit in pairs(HealBot_MainTanks) do
            HealBot_Panel_checkEnemyBar(xUnit.."target", xUnit, preCombat, 
                                        Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["EXISTSHOWTANK"],
                                        Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCOMBATSHOWTANK"])
        end
    end
    if Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCMYTAR"] then
        table.foreach(HealBot_MyHealTargets, function (index,xGUID)
            xUnit=hbPanel_dataGUIDs[xGUID] or hbPanel_dataPetGUIDs[xGUID] or "unknown"
            HealBot_Panel_checkEnemyBar(xUnit.."target", xUnit, preCombat, 
                                        Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["EXISTSHOWMYTAR"],
                                        Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCOMBATSHOWLIST"])
        end)
    end
    
    if HEALBOT_GAME_VERSION>1 then
        vEnemyBossNum=Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["NUMBOSS"]
        if Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["EXISTSHOWBOSS"] then
            vEnemyBossExist=2
        else
            vEnemyBossExist=1
        end
        if HealBot_Panel_luVars["MAPID"]==953 then
            if UnitExists("boss1") then
                if vEnemyBossNum<3 then vEnemyBossNum=3 end
                vEnemyBossExist=1
            end
        end
        
        if vEnemyBossNum>0 then
            for bi=1,vEnemyBossNum do
                xUnit="boss"..bi
                HealBot_Panel_checkEnemyBar(xUnit, "player", preCombat, vEnemyBossExist, vEnemyBossExist)
            end
        end
    end

    if i[hbCurrentFrame]>vEnemyIndex then 
        HealBot_Panel_addUnits(false,11,HEALBOT_CUSTOM_CASTBY_ENEMY,vEnemyIndex, preCombat)
    end
end

local vTargetValid, vTargetGUID=false,"target"
function HealBot_Panel_validTarget(unit)
    if UnitExists("target") then
        vTargetValid=true
        vTargetGUID=UnitGUID("target") or "target"
        if HealBot_Panel_BlackList[vTargetGUID] then 
            vTargetValid=false
        elseif Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TONLYFRIEND"] and not UnitIsFriend("player","target") then 
            vTargetValid=false
        elseif Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TEXRAID"] and 
              (UnitIsUnit("target", "player") or UnitInParty("target") or UnitInRaid("target")) then
            vTargetValid=false
        end
    else
        vTargetValid=false
    end
    return vTargetValid
end

local vTargetIndex=0
function HealBot_Panel_targetHeals(preCombat)
    vTargetIndex=i[hbCurrentFrame]
    if UnitExists("target") and (not preCombat or Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TARGETINCOMBAT"]>1) then
        if UnitIsVisible("target") or not Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["HIDEOOR"] then
            if preCombat or HealBot_Panel_validTarget() then
                i[hbCurrentFrame] = i[hbCurrentFrame]+1;
                table.insert(subunits,"target")
            end
        end
    elseif preCombat and Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TARGETINCOMBAT"]==3 then
        i[hbCurrentFrame] = i[hbCurrentFrame]+1;
        table.insert(subunits,"target")
    end
    if i[hbCurrentFrame]>vTargetIndex then 
        HealBot_Panel_SubSort(false,9, preCombat)
        HeaderPos[hbCurrentFrame][i[hbCurrentFrame]] = HEALBOT_OPTIONS_TARGETHEALS
    end
end

local vVehiclePlayerUnit,vVehicleUnit,vVehicleIndex="","",0
function HealBot_Panel_vehicleHeals(preCombat)
    if HEALBOT_GAME_VERSION>2 then
        vVehicleIndex=i[hbCurrentFrame]
        vVehicleUnit="pet"
        vVehiclePlayerUnit="player"
        if hbPanel_dataPetUnits[vVehicleUnit] and UnitUsingVehicle(vVehiclePlayerUnit) and UnitName(vVehicleUnit) then
            HealBot_Panel_addUnit(vVehicleUnit, 7, hbPanel_dataPetUnits[vVehicleUnit], false)
        end
        if nraid>0 then
            for j=1,nraid do
                vVehicleUnit="raidpet"..j;
                vVehiclePlayerUnit="raid"..j;
                if hbPanel_dataPetUnits[vVehicleUnit] and UnitExists(vVehiclePlayerUnit) and UnitUsingVehicle(vVehiclePlayerUnit) and UnitName(vVehicleUnit) then
                    HealBot_Panel_addUnit(vVehicleUnit, 7, hbPanel_dataPetUnits[vVehicleUnit], false)
                end
            end
        else
            for j=1,4 do
                vVehicleUnit="partypet"..j;
                vVehiclePlayerUnit="party"..j;
                if hbPanel_dataPetUnits[vVehicleUnit] and UnitExists(vVehiclePlayerUnit) and UnitUsingVehicle(vVehiclePlayerUnit) and UnitName(vVehicleUnit) then
                    HealBot_Panel_addUnit(vVehicleUnit, 7, hbPanel_dataPetUnits[vVehicleUnit], false)
                end
            end
        end
        if i[hbCurrentFrame]>vVehicleIndex then 
            HealBot_Panel_addUnits(true, 7,HEALBOT_VEHICLE,vVehicleIndex, preCombat)
        end
    elseif Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["STATE"] then
        Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["STATE"]=false
    end
end

local vPanelPetRole,vPanelPetRoleReturn="",""
function HealBot_Panel_petRole(unit)
    vPanelPetRoleReturn="x"
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["FRAME"]>5 then
        vPanelPetRole=hbPanel_dataRoles[unit] or "x"
        if vPanelPetRole=="TANK" and HealBot_Panel_luVars["TanksOn"] then vPanelPetRoleReturn="TANK" end
        if vPanelPetRole=="HEALER" and HealBot_Panel_luVars["HealsOn"] then vPanelPetRoleReturn="HEALER" end
    end
    return vPanelPetRoleReturn
end

local vPetPlayerUnit,vPetUnit,vPetIndex,vPetPlayerInVehicle,vPetRole,vPetGrp5ID="","",0,false,"",0
function HealBot_Panel_petHeals(preCombat)
    HeaderPos[hbCurrentFrame][i[hbCurrentFrame]+1] = HEALBOT_OPTIONS_PETHEALS
    vPetGrp5ID=0
    vPetIndex=i[hbCurrentFrame]
    vPetUnit="pet"
    vPetPlayerUnit="player"
    vPetPlayerInVehicle=false
    vPetRole=HealBot_Panel_petRole(vPetUnit)
    if vPetRole~="TANK" or vPetRole~="HEALER" then
        if HEALBOT_GAME_VERSION>2 then vPetPlayerInVehicle=UnitUsingVehicle(vPetPlayerUnit) end
        if hbPanel_dataPetUnits[vPetUnit] and not vPetPlayerInVehicle and not HealBot_Panel_luVars["SelfPets"] then
            HealBot_Panel_addUnit(vPetUnit, 8, hbPanel_dataPetUnits[vPetUnit], false)
        end
    end
    if nraid>0 then
        for j=1,nraid do
            vPetUnit="raidpet"..j;
            if hbPanel_dataPetUnits[vPetUnit] then
                vPetRole=HealBot_Panel_petRole(vPetUnit)
                if vPetRole~="TANK" and vPetRole~="HEALER" then
                    vPetPlayerUnit="raid"..j;
                    if HEALBOT_GAME_VERSION>2 then vPetPlayerInVehicle=UnitUsingVehicle(vPetPlayerUnit) end
                    if UnitExists(vPetPlayerUnit) and not vPetPlayerInVehicle then
                        HealBot_Panel_addUnit(vPetUnit, 8, hbPanel_dataPetUnits[vPetUnit], false)
                    end
                    if Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["GROUPPETS"] then
                        if i[hbCurrentFrame]-vPetIndex == 6 then 
                            vPetGrp5ID=vPetGrp5ID+1
                            HeaderPos[hbCurrentFrame][i[hbCurrentFrame]-5] = HEALBOT_OPTIONS_PETHEALS.." "..vPetGrp5ID
                        end
                        if i[hbCurrentFrame]>vPetIndex and ((i[hbCurrentFrame]-vPetIndex)%5 == 0) then                           
                            HealBot_Panel_MainSort(true,8, preCombat)        
                            vPetGrp5ID=vPetGrp5ID+1
                            HeaderPos[hbCurrentFrame][i[hbCurrentFrame]+1] = HEALBOT_OPTIONS_PETHEALS.." "..vPetGrp5ID
                        end
                    end
                end
            end
        end
        if not HeaderPos[hbCurrentFrame][vPetIndex+1] and Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["GROUPPETS"] and i[hbCurrentFrame]-vPetIndex == 5 then
            vPetGrp5ID=vPetGrp5ID+1
            HeaderPos[hbCurrentFrame][vPetIndex+1] = HEALBOT_OPTIONS_PETHEALS.." "..vPetGrp5ID
        end
    else
        for j=1,4 do
            vPetUnit="partypet"..j;
            if hbPanel_dataPetUnits[vPetUnit] then
                vPetRole=HealBot_Panel_petRole(vPetUnit)
                if vPetRole~="TANK" and vPetRole~="HEALER" then
                    vPetPlayerUnit="party"..j;
                    if HEALBOT_GAME_VERSION>2 then vPetPlayerInVehicle=UnitUsingVehicle(vPetPlayerUnit) end
                    if UnitExists(vPetPlayerUnit) and not vPetPlayerInVehicle then 
                        HealBot_Panel_addUnit(vPetUnit, 8, hbPanel_dataPetUnits[vPetUnit], false)
                    end
                end
            end
        end
    end
    if i[hbCurrentFrame]>vPetIndex then
        HealBot_Panel_MainSort(true,8, preCombat)        
        if not Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["GROUPPETS"] then
            HeaderPos[hbCurrentFrame][vPetIndex+1] = HEALBOT_OPTIONS_PETHEALS
        elseif nraid==0 or (not HeaderPos[hbCurrentFrame][vPetIndex+1] and (i[hbCurrentFrame]-vPetIndex)%5>0) then 
            vPetGrp5ID=vPetGrp5ID+1
            HeaderPos[hbCurrentFrame][vPetIndex+1] = HEALBOT_OPTIONS_PETHEALS.." "..vPetGrp5ID
        end
    end
end

local vRaidTargetNum,vCPGroup,vRaidUnit,vRaidIndex=0,1,"",0
local vRaidPrevSort,vRaidHeadSort,vRaidSubSort,vRaidShowHeader="","","init",false
function HealBot_Panel_raidHeals(preCombat)
    vRaidIndex=i[hbCurrentFrame]
    if Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["RAIDORDER"]==1 or Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["RAIDORDER"]==5 then
        HeaderPos[hbCurrentFrame][i[hbCurrentFrame]+1] = HEALBOT_OPTIONS_EMERGENCYHEALS
    end
    
    vRaidTargetNum = nraid
    if HealBot_Panel_luVars["cpUse"] and nraid>0 and HealBot_Panel_luVars["cpRaid"] then 
        if vRaidTargetNum<11 then
            vRaidTargetNum=10
            vCPGroup=2
        elseif vRaidTargetNum<16 then
            vRaidTargetNum=15
            vCPGroup=3
        elseif vRaidTargetNum<26 then
            vRaidTargetNum=25
            vCPGroup=5
        else
            vRaidTargetNum=40
            vCPGroup=8
        end
    end

    if nraid>0 then
        for j=1,vRaidTargetNum do
            vRaidUnit = "raid"..j;
            if UnitIsUnit(vRaidUnit,"player") then
                vRaidUnit="player"
                local _, _, subgroup = GetRaidRosterInfo(j);
                if MyGroup["GROUP"]>0 then
                    HeaderPos[MyGroup["FRAME"]][MyGroup["GROUP"]] = HEALBOT_OPTIONS_GROUPHEALS.." "..subgroup;
                end
                HealBot_Data["PLAYERGROUP"]=subgroup
            end
            if hbPanel_dataUnits[vRaidUnit] then
                HealBot_Panel_addUnit(vRaidUnit, 5, hbPanel_dataUnits[vRaidUnit], true)
            elseif HealBot_Panel_luVars["cpUse"] and HealBot_Panel_luVars["cpRaid"] then 
                HealBot_UnitGroups[vRaidUnit]=vCPGroup
                HealBot_Panel_addUnit(vRaidUnit, 5, vRaidUnit, true)
            end
        end
    else
        for _,xUnit in ipairs(HealBot_Action_HealGroup) do
            if hbPanel_dataUnits[xUnit] then
                HealBot_Panel_addUnit(xUnit, 5, hbPanel_dataUnits[xUnit], true)
            elseif HealBot_Panel_luVars["cpUse"] and IsInGroup() and HealBot_Panel_luVars["cpGroup"] then
                HealBot_UnitGroups[xUnit]=1
                HealBot_Panel_addUnit(xUnit, 5, xUnit, true)
            end
        end
    end

    if Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["RAIDORDER"]<6 then
        table.sort(units,function (a,b)
            if order[a]<order[b] then return true end
            if order[a]>order[b] then return false end
            return a<b
        end)
    end
    vRaidPrevSort,vRaidHeadSort,vRaidSubSort,vRaidShowHeader="","","init",false
    if Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["RAIDORDER"]==2 or
           Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["RAIDORDER"]==3 or
           Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["RAIDORDER"]==5 then
        vRaidShowHeader=true
    end

    for j=1,#units do
        vRaidUnit=units[j];
        i[hbCurrentFrame] = i[hbCurrentFrame]+1;
        if Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["RAIDORDER"]<6 then
            if vRaidSubSort~=order[vRaidUnit] then
                if vRaidShowHeader then
                    if Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["RAIDORDER"]==2 then
                        vRaidHeadSort=UnitClass(vRaidUnit) or HEALBOT_WARRIOR
                    elseif Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["RAIDORDER"]==3 then
                        vRaidHeadSort=HEALBOT_OPTIONS_GROUPHEALS.." "..order[vRaidUnit]
                    elseif Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["RAIDORDER"]==5 then
                        vRaidHeadSort=HealBot_unitRole[vRaidUnit] or hbRole[HEALBOT_WORD_DPS]
                    end
                    HeaderPos[hbCurrentFrame][i[hbCurrentFrame]] = vRaidHeadSort
                end
                HealBot_Panel_SubSort(true, 5, preCombat)
                vRaidSubSort=order[vRaidUnit]
                vRaidPrevSort=vRaidHeadSort
            end
        end
        HealBot_Panel_insSort(vRaidUnit, false)
    end
    if #units>0 then
        HealBot_Panel_SubSort(true, 5, preCombat)
    end
            
    for x,_ in pairs(order) do
        order[x]=nil;
    end
    for x,_ in pairs(units) do
        units[x]=nil;
    end
end

local vFocusUnitValid,vFocusGUID=false,"focus"
function HealBot_Panel_validFocus()
    if UnitExists("focus") then
        vFocusUnitValid=true
        vFocusGUID=UnitGUID("focus") or "focus"
        if HealBot_Panel_BlackList[vFocusGUID] then 
            vFocusUnitValid=false
        elseif Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["FONLYFRIEND"] and not UnitIsFriend("player","focus") then 
            vFocusUnitValid=false
        elseif Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["FEXRAID"] and 
               (UnitIsUnit("focus", "player") or UnitInParty("focus") or UnitInRaid("focus")) then
            vFocusUnitValid=false
        end
    else
        vFocusUnitValid=false
    end
    return vFocusUnitValid
end

local vFocusIndex=0
function HealBot_Panel_focusHeals(preCombat)
    vFocusIndex=i[hbCurrentFrame]
    if UnitExists("focus") and (not preCombat or Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["FOCUSINCOMBAT"]>1) then
        if preCombat then
            i[hbCurrentFrame] = i[hbCurrentFrame]+1;
            table.insert(subunits,"focus")
        elseif UnitIsVisible("focus") or not Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["HIDEOOR"] then
            if HealBot_Panel_validFocus() then
                i[hbCurrentFrame] = i[hbCurrentFrame]+1;
                table.insert(subunits,"focus")
            end
        else
            HealBot_setNotVisible("focus",4)
        end
    elseif preCombat and Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["FOCUSINCOMBAT"]==3 then 
        i[hbCurrentFrame] = i[hbCurrentFrame]+1;
        table.insert(subunits,"focus")
    end
    if i[hbCurrentFrame]>vFocusIndex then 
        HealBot_Panel_SubSort(false, 10, preCombat)
        HeaderPos[hbCurrentFrame][i[hbCurrentFrame]] = HEALBOT_FOCUS
    end
end

local vMyTargetsIndex,vMyTargetsUnit=0,"unknown"
function HealBot_Panel_myHeals(preCombat)
    vMyTargetsIndex=i[hbCurrentFrame]
    table.foreach(HealBot_MyHealTargets, function (index,xGUID)
        vMyTargetsUnit=hbPanel_dataGUIDs[xGUID] or hbPanel_dataPetGUIDs[xGUID] or "unknown"
        if UnitExists(vMyTargetsUnit) then
            HealBot_Panel_addUnit(vMyTargetsUnit, 4, xGUID, false)
        elseif HealBot_Private_Button[vMyTargetsUnit] then
            HealBot_Panel_ToggelHealTarget(vMyTargetsUnit)
        end
    end)
    for xGUID,_ in pairs(HealBot_Globals.HealBot_PermMyTargets) do
        vMyTargetsUnit=hbPanel_dataGUIDs[xGUID] or hbPanel_dataPetGUIDs[xGUID] or "unknown"
        if UnitExists(vMyTargetsUnit) then  
            HealBot_Panel_addUnit(vMyTargetsUnit, 4, xGUID, false)
        end
    end
    if i[hbCurrentFrame]>vMyTargetsIndex then 
        HealBot_Panel_addUnits(true, 4,HEALBOT_OPTIONS_MYTARGET,vMyTargetsIndex, preCombat)
    end
end

local vGroupIndex=0
function HealBot_Panel_groupHeals(preCombat)
    vGroupIndex=i[hbCurrentFrame]
    for _,xUnit in ipairs(HealBot_Action_HealGroup) do
        if UnitExists(xUnit) and UnitGUID(xUnit) and hbPanel_dataGUIDs[UnitGUID(xUnit)] then
            if nraid>0 and not UnitIsUnit(xUnit, "player") then 
                xUnit=hbPanel_dataGUIDs[UnitGUID(xUnit)] or xUnit
            end
            HealBot_Panel_addUnit(xUnit, 6, hbPanel_dataUnits[xUnit], false)
        elseif nraid==0 and HealBot_Panel_luVars["cpUse"] and IsInGroup() and HealBot_Panel_luVars["cpGroup"] then
            HealBot_UnitGroups[xUnit]=1
            HealBot_Panel_addUnit(xUnit, 6, xUnit, false)
        end
    end
    if i[hbCurrentFrame]>vGroupIndex then 
        HealBot_Panel_addUnits(true, 6,HEALBOT_OPTIONS_GROUPHEALS,vGroupIndex, preCombat)
        MyGroup["GROUP"]=vGroupIndex+1
        MyGroup["FRAME"]=hbCurrentFrame
    else
        MyGroup["GROUP"]=0
    end
end

local vHealIndex=0
function HealBot_Panel_healerHeals(preCombat)
    vHealIndex=i[hbCurrentFrame]
    for xGUID,xUnit in pairs(HealBot_MainHealers) do
        HealBot_Panel_addUnit(xUnit, 2, xGUID, false)
    end
    if i[hbCurrentFrame]>vHealIndex then 
        HealBot_Panel_addUnits(true, 2,HEALBOT_CLASSES_HEALERS,vHealIndex, preCombat)
    end
end

local vTankIndex=0
function HealBot_Panel_tankHeals(preCombat)
    vTankIndex=i[hbCurrentFrame]
    for xGUID,xUnit in pairs(HealBot_MainTanks) do
        HealBot_Panel_addUnit(xUnit, 1, xGUID, false)
    end
    if i[hbCurrentFrame]>vTankIndex then
        HealBot_Panel_addUnits(true, 1, HEALBOT_OPTIONS_TANKHEALS,vTankIndex, preCombat)
    end
end

local vSelfIndex,vSelfPetIndex,vSelfUnit,vSelfPetUnit=0,0,"player","pet"
function HealBot_Panel_selfHeals()
    vSelfIndex=i[hbCurrentFrame]
    HealBot_Panel_luVars["SelfPets"]=false
    HealBot_Panel_addUnit(vSelfUnit, 3, HealBot_Data["PGUID"], false)
    if i[hbCurrentFrame]>vSelfIndex then
        if Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["SELFPET"] and hbPanel_dataPetUnits[vSelfPetUnit] and HealBot_Config.DisabledNow==0 then
            vSelfPetIndex=i[hbCurrentFrame]
            HealBot_Panel_addUnit(vSelfPetUnit, 3, hbPanel_dataPetUnits[vSelfPetUnit], false)
            if i[hbCurrentFrame]>vSelfPetIndex then HealBot_Panel_luVars["SelfPets"]=true end
        end
        HealBot_Panel_addUnits(false, 3, HEALBOT_OPTIONS_SELFHEALS,vSelfIndex, preCombat)
    end
end

function HealBot_Panel_VehicleChanged(preCombat)
    hbCurrentFrame=6
    hbBarsPerFrame[hbCurrentFrame]=0
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["STATE"]then
        i[hbCurrentFrame]=0
        HeaderPos[hbCurrentFrame]={};
        HealBot_Panel_vehicleHeals(preCombat)
        for xUnit,xButton in pairs(HealBot_Vehicle_Button) do
            if xButton.status.unittype==7 then
                if HealBot_TrackUnit[xUnit] then
                    xButton:Show()
                    if Healbot_Config_Skins.Spells[Healbot_Config_Skins.Current_Skin][xButton.frame]["USE"] then
                        HealBot_Emerg_Button[xButton.id]:Show()
                    end
                else
                    HealBot_Action_MarkDeleteButton(xButton)
                end
            end
        end
        HealBot_Panel_SetupExtraBars(hbCurrentFrame, preCombat)
    else
        for xUnit,xButton in pairs(HealBot_Vehicle_Button) do
            if xButton.status.unittype==7 then
                HealBot_Action_MarkDeleteButton(xButton)
            end
        end
        HealBot_Action_HidePanel(hbCurrentFrame)
    end
end

local vPetsChangedRole=""
function HealBot_Panel_PetsChanged(preCombat)
    hbCurrentFrame=7
    hbBarsPerFrame[hbCurrentFrame]=0
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["STATE"] then
        i[hbCurrentFrame]=0
        HeaderPos[hbCurrentFrame]={};
        HealBot_Panel_petHeals(preCombat)
        for xUnit,xButton in pairs(HealBot_Pet_Button) do
            if xButton.status.unittype==8 then
                vPetsChangedRole=HealBot_Panel_petRole(xUnit)
                if HealBot_TrackUnit[xUnit] or vPetsChangedRole=="TANK" or vPetsChangedRole=="HEALER" then
                    xButton:Show()
                    if Healbot_Config_Skins.Spells[Healbot_Config_Skins.Current_Skin][xButton.frame]["USE"] then
                        HealBot_Emerg_Button[xButton.id]:Show()
                    end
                    HealBot_Panel_luVars["NumPets"]=HealBot_Panel_luVars["NumPets"]+1
                elseif xButton.unit~="pet" or not HealBot_Panel_luVars["SelfPets"] then
                    HealBot_Action_MarkDeleteButton(xButton)
                end
            end
        end
        HealBot_Panel_SetupExtraBars(hbCurrentFrame, preCombat)
    else
        for xUnit,xButton in pairs(HealBot_Pet_Button) do
            if xButton.status.unittype==8 then
                HealBot_Action_MarkDeleteButton(xButton)
            end
        end
        HealBot_Action_HidePanel(hbCurrentFrame)
    end
end

local vTargetButton=""
function HealBot_Panel_TargetChanged(preCombat)
    hbCurrentFrame=8
    hbBarsPerFrame[hbCurrentFrame]=0
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][9]["STATE"] then
        i[hbCurrentFrame]=0
        HeaderPos[hbCurrentFrame]={};
        HealBot_Panel_targetHeals(preCombat)        
        vTargetButton = HealBot_Extra_Button["target"]
        if vTargetButton then
            if HealBot_TrackUnit[vTargetButton.unit] and not HealBot_Panel_BlackList[vTargetButton.guid] then
                HealBot_setLuVars("TargetNeedReset", false)
                vTargetButton:Show()
                if Healbot_Config_Skins.Spells[Healbot_Config_Skins.Current_Skin][vTargetButton.frame]["USE"] then
                    HealBot_Emerg_Button[vTargetButton.id]:Show()
                end
                HealBot_Panel_TargetChangedCheckFocus()
            else
                HealBot_Action_HidePanel(hbCurrentFrame)
            end
        end
        HealBot_Panel_SetupExtraBars(hbCurrentFrame, preCombat)
    else
        vTargetButton = HealBot_Extra_Button["target"]
        if vTargetButton then
            HealBot_Action_MarkDeleteButton(vTargetButton)
        end
        HealBot_Action_HidePanel(hbCurrentFrame)
    end
        --HealBot_setCall("HealBot_Panel_TargetChanged")
end

local vFocusParent, vFocusFrame="",""
function HealBot_Panel_TargetChangedCheckFocus()
    if hbPanelShowhbFocus then
        local tButton=HealBot_Extra_Button["target"]
        if tButton then
            vFocusFrame=_G["HealBot_Action_HealUnit999"]
            local vFocusParent=_G["f8_HealBot_Action"]
            if not vFocusFrame then
                vFocusFrame=CreateFrame("Button", "HealBot_Action_HealUnit999", vFocusParent, "HealBotFocusButtonTemplate") 
                local bar = _G[vFocusFrame:GetName().."Bar"]
                bar:SetMinMaxValues(0,100);
                bar:SetValue(100);
                bar:UnregisterAllEvents()
                HealBot_Action_SethbFocusButtonAttrib(vFocusFrame)
                vFocusFrame.id=999
                vFocusFrame.frame=8
                HealBot_Action_OnLoad(vFocusFrame) 
                vFocusFrame:RegisterForClicks("LeftButtonUp", "RightButtonUp")
            end
            if not HealBot_Data["UILOCK"] and UnitExists("target") and HealBot_Globals.FocusMonitor[HealBot_GetUnitName("target")] then
                if UnitExists("focus") and HealBot_Globals.FocusMonitor[HealBot_GetUnitName("focus")] then
                    vFocusFrame:Hide()
                else
                    HealBot_Skins_ResetSkin("hbfocus",vFocusFrame,Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][8]["NUMCOLS"])
                    vFocusFrame:ClearAllPoints()
                    if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][8]["BARS"]==2 or Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][8]["BARS"]==4 then
                        vFocusFrame:SetPoint("BOTTOM",tButton.gref["Back"],"TOP",0,9);
                    else
                        vFocusFrame:SetPoint("TOP",tButton.gref["Back"],"BOTTOM",0,-9);
                    end
                    vFocusFrame:Show();
                    hbFocusOn=vFocusFrame.frame
                end
            end
        elseif hbFocusOn>0 then
            if vFocusFrame then
                vFocusFrame:Hide();
            end
            hbFocusOn=0
        end
    elseif hbFocusOn>0 then
        if vFocusFrame then
            vFocusFrame:Hide();
        end
        hbFocusOn=0
    end
end

local vFocusButton=""
function HealBot_Panel_FocusChanged(preCombat)
    if HEALBOT_GAME_VERSION>1 then 
        hbCurrentFrame=9
        hbBarsPerFrame[hbCurrentFrame]=0
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["STATE"] then
            i[hbCurrentFrame]=0
            HeaderPos[hbCurrentFrame]={};
            HealBot_Panel_focusHeals(preCombat)
            vFocusButton = HealBot_Extra_Button["focus"]
            if vFocusButton then
                if HealBot_TrackUnit[vFocusButton.unit] and not HealBot_Panel_BlackList[vFocusButton.guid] then
                    HealBot_setLuVars("FocusNeedReset", false)
                    vFocusButton:Show()
                    if Healbot_Config_Skins.Spells[Healbot_Config_Skins.Current_Skin][vFocusButton.frame]["USE"] then
                        HealBot_Emerg_Button[vFocusButton.id]:Show()
                    end
                else
                    HealBot_Action_HidePanel(hbCurrentFrame)
                end
            end
            HealBot_Panel_SetupExtraBars(hbCurrentFrame, preCombat)
        else
            vFocusButton = HealBot_Extra_Button["focus"]
            if vFocusButton then
                HealBot_Action_MarkDeleteButton(vFocusButton)
            end
            HealBot_Action_HidePanel(hbCurrentFrame)
        end
    elseif Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["STATE"] then
        Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["STATE"]=false
    end
end

function HealBot_Panel_IsTargetingEnemy(unit)
    return hbPanel_enemyUnits[unit]
end

function HealBot_Panel_EnemyChanged(preCombat)
    hbCurrentFrame=10
    hbBarsPerFrame[hbCurrentFrame]=0
    for x,_ in pairs(hbPanel_enemyUnits) do
        hbPanel_enemyUnits[x]=nil;
    end
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][11]["STATE"] then
        i[hbCurrentFrame]=0
        HeaderPos[hbCurrentFrame]={};
        HealBot_Panel_enemyTargets(preCombat)
        for xUnit,xButton in pairs(HealBot_Enemy_Button) do
            if HealBot_TrackUnit[xUnit] then
                xButton:Show()
            else
                HealBot_Action_MarkDeleteButton(xButton)
            end
        end
        HealBot_Panel_SetupExtraBars(hbCurrentFrame, preCombat)
    else
        for xUnit,xButton in pairs(HealBot_Enemy_Button) do
            HealBot_Action_MarkDeleteButton(xButton)
        end
        HealBot_Action_HidePanel(hbCurrentFrame)
    end
end

local vPetsWithPlayers,vVehicleWithPlayers=false,false
function HealBot_Panel_PlayersChanged(preCombat)
    TempMaxH=9;
    
    if not IsInRaid() then 
        nraid=0
        HealBot_Action_setLuVars("InRaid", false)
        HealBot_Aura_setLuVars("InRaid", false)
    else
        nraid=GetNumGroupMembers();
        HealBot_Action_setLuVars("InRaid", true)
        HealBot_Aura_setLuVars("InRaid", true)
    end

    for gl=1,5 do
        HeaderPos[gl]={};
        hbBarsPerFrame[gl]=0
        i[gl]=0
    end

    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["FRAME"]<6 then
        vPetsWithPlayers=true
    else
        vPetsWithPlayers=false
    end
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["FRAME"]<6 then
        vVehicleWithPlayers=true
    else
        vVehicleWithPlayers=false
    end
    
    HealBot_Panel_luVars["TanksOn"]=false
    HealBot_Panel_luVars["HealsOn"]=false
    if HealBot_Config.DisabledNow==1 then
        hbCurrentFrame=1
        HealBot_Panel_selfHeals(preCombat)
    else
        MyGroup["GROUP"]=0
        HealBot_Data["PLAYERGROUP"]=1
        for gl=1,8 do
            if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["STATE"] then
                for x,_ in pairs(order) do
                    order[x]=nil;
                end
                for x,_ in pairs(units) do
                    units[x]=nil;
                end
                for x,_ in pairs(suborder) do
                    suborder[x]=nil;
                end
                for x,_ in pairs(subunits) do
                    subunits[x]=nil;
                end
                hbCurrentFrame=Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["FRAME"]
                if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["NAME"]==HEALBOT_OPTIONS_EMERGENCYHEALS_en then
                    HealBot_Panel_raidHeals(preCombat)
                elseif Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["NAME"]==HEALBOT_OPTIONS_GROUPHEALS_en then
                    HealBot_Panel_groupHeals(preCombat)
                elseif Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["NAME"]==HEALBOT_OPTIONS_TANKHEALS_en then
                    HealBot_Panel_tankHeals(preCombat)
                    HealBot_Panel_luVars["TanksOn"]=true
                elseif Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["NAME"]==HEALBOT_CLASSES_HEALERS_en then
                    HealBot_Panel_healerHeals(preCombat)
                    HealBot_Panel_luVars["HealsOn"]=true
                elseif Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["NAME"]==HEALBOT_OPTIONS_SELFHEALS_en then
                    HealBot_Panel_selfHeals(preCombat)
                elseif Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["NAME"]==HEALBOT_OPTIONS_MYTARGET_en then
                    HealBot_Panel_myHeals(preCombat)
                elseif Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["NAME"]==HEALBOT_OPTIONS_PETHEALS_en and hbCurrentFrame<6 then
                    HealBot_Panel_petHeals(preCombat)
                elseif Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["NAME"]==HEALBOT_VEHICLE_en and hbCurrentFrame<6 then
                    HealBot_Panel_vehicleHeals(preCombat)
                end
            end
        end
    end   
    
    for xUnit,xButton in pairs(HealBot_Unit_Button) do
        if xButton.status.unittype>4 and xButton.status.unittype<7 then
            if HealBot_TrackUnit[xUnit] and not HealBot_Panel_BlackList[xButton.guid] then
                xButton:Show()
                if Healbot_Config_Skins.Spells[Healbot_Config_Skins.Current_Skin][xButton.frame]["USE"] then
                    HealBot_Emerg_Button[xButton.id]:Show()
                end
            else
                HealBot_Action_MarkDeleteButton(xButton)
            end
        elseif xButton.status.unittype<5 or xButton.status.unittype>8 then
            HealBot_Unit_Button[xUnit]=nil
        end
    end
    HealBot_Panel_luVars["NumPrivate"]=0
    for xUnit,xButton in pairs(HealBot_Private_Button) do
        if xButton.status.unittype<5 then
            if HealBot_TrackPrivateUnit[xUnit] and not HealBot_Panel_BlackList[xButton.guid] then
                xButton:Show()
                if Healbot_Config_Skins.Spells[Healbot_Config_Skins.Current_Skin][xButton.frame]["USE"] then
                    HealBot_Emerg_Button[xButton.id]:Show()
                end
                HealBot_Panel_luVars["NumPrivate"]=HealBot_Panel_luVars["NumPrivate"]+1
            else
                HealBot_Action_MarkDeleteButton(xButton)
            end
        else
            HealBot_Private_Button[xUnit]=nil
        end
    end
    if vPetsWithPlayers then
        for xUnit,xButton in pairs(HealBot_Pet_Button) do
            if HealBot_TrackUnit[xUnit] then
                xButton:Show()
                if Healbot_Config_Skins.Spells[Healbot_Config_Skins.Current_Skin][xButton.frame]["USE"] then
                    HealBot_Emerg_Button[xButton.id]:Show()
                end
                HealBot_Panel_luVars["NumPets"]=HealBot_Panel_luVars["NumPets"]+1
            else
                HealBot_Action_MarkDeleteButton(xButton)
            end
        end
    end
    if vVehicleWithPlayers then
        for xUnit,xButton in pairs(HealBot_Vehicle_Button) do
            if HealBot_TrackUnit[xUnit] then
                xButton:Show()
                if Healbot_Config_Skins.Spells[Healbot_Config_Skins.Current_Skin][xButton.frame]["USE"] then
                    HealBot_Emerg_Button[xButton.id]:Show()
                end
                HealBot_Panel_luVars["NumPets"]=HealBot_Panel_luVars["NumPets"]+1
            else
                HealBot_Action_MarkDeleteButton(xButton)
            end
        end
    end
        
    HealBot_Panel_SetupBars(preCombat)
end

function HealBot_RetUnitGroups(unit)
    return HealBot_UnitGroups[unit] or 1
end

local focusHeal=true
function HealBot_Panel_focusHeal(isOn)
    focusHeal=isOn
end

function HealBot_Panel_RaidUnitGUID(guid)
    return hbPanel_dataGUIDs[guid] or hbPanel_dataPetGUIDs[guid] 
end

function HealBot_Panel_RaidUnitName(uName)
    return hbPanel_dataNames[uName] or hbPanel_dataPetNames[uName]
end

function HealBot_Panel_DoPartyChanged(preCombat, changeType)
    for xHeader in pairs(HealBot_Track_Headers) do
        HealBot_Track_Headers[xHeader]=false
    end
    for x,_ in pairs(HealBot_TrackUnit) do
        HealBot_TrackUnit[x]=nil
    end 
    for x,_ in pairs(HealBot_TrackPrivateUnit) do
        HealBot_TrackPrivateUnit[x]=nil
    end 
    for x,_ in pairs(HealBot_TrackNames) do
        HealBot_TrackNames[x]=nil;
    end
    for x,_ in pairs(HealBot_TrackPrivateNames) do
        HealBot_TrackPrivateNames[x]=nil;
    end
    for xGUID,_ in pairs(HealBot_Panel_BlackList) do
        HealBot_TrackNames[xGUID]=true
        HealBot_TrackPrivateNames[xGUID]=true
    end 
    for x,_ in pairs(HealBot_Action_HealButtons) do
        HealBot_Action_HealButtons[x]=nil;
    end
    if changeType>5 then
        HealBot_Panel_PlayersChanged(preCombat)
    else
        for x,_ in pairs(order) do
            order[x]=nil;
        end
        for x,_ in pairs(units) do
            units[x]=nil;
        end
        for x,_ in pairs(suborder) do
            suborder[x]=nil;
        end
        for x,_ in pairs(subunits) do
            subunits[x]=nil;
        end
        if changeType==2 and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["FRAME"]==7 then
            HealBot_Panel_PetsChanged(preCombat)
        elseif changeType==3 then
            HealBot_Panel_TargetChanged(preCombat)
        elseif changeType==5 then
            HealBot_Panel_EnemyChanged(preCombat)
        elseif changeType==4 then
            HealBot_Panel_FocusChanged(preCombat)
        elseif changeType==1 and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["FRAME"]==6 then
            HealBot_Panel_VehicleChanged(preCombat)
        end
    end
end

function HealBot_Panel_PrePartyChanged(preCombat, changeType)
    if changeType>0 then
        if changeType>5 then
            if (Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["STATE"] and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["FRAME"]<6) or
               (Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["STATE"] and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["FRAME"]<6) then
                HealBot_Panel_buildDataStore(true, true)
            else
                HealBot_Panel_buildDataStore(true, false)
            end
        elseif changeType==2 and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["FRAME"]==7 then
            HealBot_Panel_buildDataStore(false, true)
        elseif changeType==1 and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["FRAME"]==6 then
            HealBot_Panel_buildDataStore(false, true)
        end
        HealBot_Panel_DoPartyChanged(preCombat, changeType)
    else
        if (Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["STATE"] and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["FRAME"]<6) or
           (Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["STATE"] and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["FRAME"]<6) then
            HealBot_Panel_buildDataStore(true, true)
        else
            HealBot_Panel_buildDataStore(true, false)
        end
        HealBot_Panel_DoPartyChanged(preCombat, 4)
        if preCombat then
            if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["FRAME"]==6 or Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["FRAME"]==7 then 
                HealBot_Panel_buildDataStore(false, true)
                if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["FRAME"]==6 then
                    HealBot_Panel_DoPartyChanged(preCombat, 1)
                end
                if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["FRAME"]==7 then 
                    HealBot_Panel_DoPartyChanged(preCombat, 2)
                end
            end
            HealBot_Panel_DoPartyChanged(preCombat, 3)
            HealBot_Panel_DoPartyChanged(preCombat, 5)
            HealBot_Panel_DoPartyChanged(preCombat, 6)
        else
            if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["FRAME"]==6 then HealBot_nextRecalcParty(1) end
            if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["FRAME"]==7 then HealBot_nextRecalcParty(2) end
            HealBot_nextRecalcParty(3)
            HealBot_nextRecalcParty(5)
            HealBot_nextRecalcParty(6)
        end
    end 
end

function HealBot_Panel_PartyChanged(preCombat, changeType)
    if HealBot_setTestBars then
        if not preCombat then
            HealBot_Panel_TestBarsOn()
        else
            HealBot_Panel_ToggleTestBars() 
            HealBot_Panel_PrePartyChanged(preCombat, 0)
        end
    else
        HealBot_Panel_PrePartyChanged(preCombat, changeType)
    end
    if not HealBot_Data["UILOCK"] then 
        local nMembers=(GetNumGroupMembers()+HealBot_Panel_luVars["NumPrivate"]+HealBot_Panel_luVars["NumPets"])+14
        if nMembers>HealBot_Globals.AutoCacheSize then    
            HealBot_Globals.AutoCacheSize=nMembers
        end
        HealBot_fastUpdateEveryFrame(2)
    end
      --HealBot_setCall("HealBot_Panel_PartyChanged")
end
