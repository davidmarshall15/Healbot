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
local backBarsSize={[1]={["HEIGHT"]=0, ["WIDTH"]=0, ["RMARGIN"]=0, ["CMARGIN"]=0, ["HEADHEIGHT"]=0, ["HEADWIDTH"]=0},
                    [2]={["HEIGHT"]=0, ["WIDTH"]=0, ["RMARGIN"]=0, ["CMARGIN"]=0, ["HEADHEIGHT"]=0, ["HEADWIDTH"]=0},
                    [3]={["HEIGHT"]=0, ["WIDTH"]=0, ["RMARGIN"]=0, ["CMARGIN"]=0, ["HEADHEIGHT"]=0, ["HEADWIDTH"]=0},
                    [4]={["HEIGHT"]=0, ["WIDTH"]=0, ["RMARGIN"]=0, ["CMARGIN"]=0, ["HEADHEIGHT"]=0, ["HEADWIDTH"]=0},
                    [5]={["HEIGHT"]=0, ["WIDTH"]=0, ["RMARGIN"]=0, ["CMARGIN"]=0, ["HEADHEIGHT"]=0, ["HEADWIDTH"]=0},
                    [6]={["HEIGHT"]=0, ["WIDTH"]=0, ["RMARGIN"]=0, ["CMARGIN"]=0, ["HEADHEIGHT"]=0, ["HEADWIDTH"]=0},
                    [7]={["HEIGHT"]=0, ["WIDTH"]=0, ["RMARGIN"]=0, ["CMARGIN"]=0, ["HEADHEIGHT"]=0, ["HEADWIDTH"]=0},
                    [8]={["HEIGHT"]=0, ["WIDTH"]=0, ["RMARGIN"]=0, ["CMARGIN"]=0, ["HEADHEIGHT"]=0, ["HEADWIDTH"]=0},
                    [9]={["HEIGHT"]=0, ["WIDTH"]=0, ["RMARGIN"]=0, ["CMARGIN"]=0, ["HEADHEIGHT"]=0, ["HEADWIDTH"]=0},
                   [10]={["HEIGHT"]=0, ["WIDTH"]=0, ["RMARGIN"]=0, ["CMARGIN"]=0, ["HEADHEIGHT"]=0, ["HEADWIDTH"]=0}}
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
local HealBot_cpName={}
local HealBot_cpData={}
local HealBot_cpOn=false
local _
local nraid=0
local hbOptionOn=0
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
local grpNo=1
local tHeader={}
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
local HealBot_Panel_luVars={}
HealBot_Panel_luVars["SaveCrashProtection"]=GetTime()
HealBot_Panel_luVars["SelfPets"]=false
HealBot_Panel_luVars["TanksOn"]=false
HealBot_Panel_luVars["HealsOn"]=false
HealBot_Panel_luVars["TestBarsDelAll"]=true
HealBot_Panel_luVars["MAPID"]=0
HealBot_Panel_luVars["cpCOMBATRAID"]=false
HealBot_Panel_luVars["cpCOMBATPARTY"]=false
HealBot_Panel_luVars["cpCOMBAT"]=false
HealBot_Panel_luVars["cpMACRONAME"]="hbCombatProt"
HealBot_Panel_luVars["cpCRASH"]=false
HealBot_Panel_luVars["NumPrivate"]=0
HealBot_Panel_luVars["NumPets"]=0
HealBot_Panel_luVars["TankHealth"]=0

function HealBot_Panel_retLuVars(vName)
    return HealBot_Panel_luVars[vName]
end

function HealBot_Panel_setLuVars(vName, vValue)
    HealBot_Panel_luVars[vName]=vValue
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
        if UnitIsUnit(unit, "player") then unit="player" end
        if UnitIsUnit(unit, "pet") then unit="pet" end
        local dsGUID=UnitGUID(unit) or unit
        local dsName=HealBot_GetUnitName(unit) or unit
        if isPlayer then
            hbPanel_dataNames[dsName]=unit
            hbPanel_dataGUIDs[dsGUID]=unit
            hbPanel_dataUnits[unit]=dsGUID
        else
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
            if hbPanel_dataRoles[unit]==HEALBOT_WORDS_UNKNOWN then
                if hbCombatRole and (hbCombatRole=="HEALER" or hbCombatRole=="TANK") then
                    hbFRole = hbCombatRole
                elseif hbRRole and (string.lower(hbRRole)=="mainassist" or string.lower(hbRRole)=="maintank") then
                    hbFRole="TANK"
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
        HealBot_ClearPlayerButtonCache()
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
    HealBot_setOptions_Timer(595)
end

function HealBot_Panel_AddBlackList(unit)
    xGUID=UnitGUID(unit)
    if xGUID then
        HealBot_Panel_BlackList[xGUID]=true;
        HealBot_setOptions_Timer(595)
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
    HealBot_nextRecalcParty(6)
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
    HealBot_Panel_buildDataStore(true, true)
    HealBot_setOptions_Timer(595)
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
    HealBot_Panel_buildDataStore(true, true)
    HealBot_setOptions_Timer(595)
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

function HealBot_Panel_UnitRole(unit, guid)
    if guid and hbPanel_dataGUIDs[guid] then unit=hbPanel_dataGUIDs[guid] end
    local role = hbPanel_dataRoles[unit]
    if role==HEALBOT_WORDS_UNKNOWN then 
        if HEALBOT_GAME_VERSION>3 then 
            role=UnitGroupRolesAssigned(unit) or HEALBOT_WORDS_UNKNOWN
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
            unitRole=HealBot_Panel_UnitRole(button.unit, button.guid)
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
       -- elseif hhb.frame~=hbCurFrame then
       --     hhb:ClearAllPoints()
       --     hhb:SetParent(hp)
        end
		hhb.frame=0
        HealBot_ActiveHeaders[0]=freeId+1
        return hhb
    else
        return nil
    end
end

function HealBot_Panel_ResetHeaders()
    for _,xButton in pairs(HealBot_Header_Frames) do
        xButton.frame=0
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
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][button.frame]["BARS"]==1 or
           Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][button.frame]["BARS"]==3 then
            backFrame:SetPoint("TOPLEFT",relButton,"BOTTOMLEFT",0,-backBarsSize[button.frame]["RMARGIN"])
        else
            backFrame:SetPoint("BOTTOMLEFT",relButton,"TOPLEFT",0,backBarsSize[button.frame]["RMARGIN"])
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
function HealBot_Panel_PositionButton(button,xHeader,relButton,newColumn)
    if xHeader then
        local vPosParentHF=HealBot_Header_Frames[xHeader]
        if not vPosParentHF then
            vPosParentHF=HealBot_Panel_CreateHeader(button.frame)
            HealBot_Header_Frames[xHeader]=vPosParentHF
        end
        local backFrame=_G[vPosParentHF:GetName().."Bar5"]
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
        return backFrame
    else
        HealBot_Panel_AnchorButton(button, button.gref["Back"], relButton, newColumn)
        
        if HealBot_SpecialUnit[button.unit] then
            local eGUID=UnitGUID(button.unit.."target") or button.unit.."target"
            local eButton=HealBot_Action_SetHealButton(button.unit.."target",eGUID,10,11,false,3) 
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
        local xUnit=b.unit
        HealBot_Action_MarkDeleteButton(b)
        HealBot_Action_DeleterCallsUnit(xUnit)
        HealBot_TestBarsActive[x]=nil
        HealBot_Action_DeleteMarkedButtons()
    end
end

function HealBot_Panel_ToggleTestBars()
    if HealBot_setTestBars then
        HealBot_setTestBars=false
        HealBot_Panel_TestBarsOff()
        HealBot_Options_TestBarsButton:SetText(HEALBOT_OPTIONS_TURNTESTBARSON)
        for j=1,10 do
            HealBot_Action_HidePanel(j)
        end
        HealBot_Action_setLuVars("TestBarsOn", false)
        HealBot_setLuVars("TestBarsOn", false)
        HealBot_setTestCols={}
    else
        HealBot_Action_setLuVars("TestBarsOn", true)
        HealBot_setLuVars("TestBarsOn", true)
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
function HealBot_Panel_PositionBars()
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
        elseif xUnitType>6 and xUnitType<9 then
            vPosButton=HealBot_Pet_Button[xUnit] or "nil"
        else
            vPosButton=HealBot_Unit_Button[xUnit] or "nil"
        end
        if vPosButton~="nil" and hbBarsPerFrame[vPosButton.frame] then
			vPosButton.group=HealBot_UnitGroups[vPosButton.unit]
            vFrame=vPosButton.frame
            rowNo[vFrame]=rowNo[vFrame]+1
            vBar[vFrame]["BUTTON"]=vPosButton
            barNo[vFrame]=barNo[vFrame]+1
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
						vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vBar[vFrame]["BUTTON"],HeaderPos[vFrame][barNo[vFrame]],false,sameCol)
						vBar[vFrame]["PREVCOL"]=vBar[vFrame]["PREVROW"]
					elseif headerNo[vFrame]>Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][vFrame]["NUMCOLS"] then
						vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vBar[vFrame]["BUTTON"],HeaderPos[vFrame][barNo[vFrame]],vBar[vFrame]["PREVCOL"],newCol)
						maxCols[vFrame]=maxCols[vFrame]+1
						vBar[vFrame]["PREVCOL"]=vBar[vFrame]["PREVROW"]
						headerNo[vFrame]=1
						rowNo[vFrame]=1
					else
						vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vBar[vFrame]["BUTTON"],HeaderPos[vFrame][barNo[vFrame]],vBar[vFrame]["PREVROW"],sameCol)
					end
				end
				if rowNo[vFrame]>maxRows[vFrame] then
					maxRows[vFrame]=rowNo[vFrame]
				end
				if headerNo[vFrame]>maxHeaders[vFrame] then
					maxHeaders[vFrame]=headerNo[vFrame]
				end
				vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vBar[vFrame]["BUTTON"],false,vBar[vFrame]["PREVROW"],sameCol)
			elseif Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][vFrame]["GRPCOLS"] then
				if HeaderPos[vFrame][barNo[vFrame]] then
					headerNo[vFrame]=headerNo[vFrame]+1
				end
				if barNo[vFrame]==1 then
					vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vBar[vFrame]["BUTTON"],false,false,sameCol)
					vBar[vFrame]["PREVCOL"]=vBar[vFrame]["PREVROW"]
				elseif headerNo[vFrame]>Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][vFrame]["NUMCOLS"] then
					vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vBar[vFrame]["BUTTON"],false,vBar[vFrame]["PREVCOL"],newCol)
					vBar[vFrame]["PREVCOL"]=vBar[vFrame]["PREVROW"]
					headerNo[vFrame]=1
					maxCols[vFrame]=maxCols[vFrame]+1
					rowNo[vFrame]=1
				else
					vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vBar[vFrame]["BUTTON"],false,vBar[vFrame]["PREVROW"],sameCol)
				end
				if rowNo[vFrame]>maxRows[vFrame] then
					maxRows[vFrame]=rowNo[vFrame]
				end
			else
				if barNo[vFrame]==1 or rowNo[vFrame]>maxRows[vFrame] then
					if barNo[vFrame]==1 then
						vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vBar[vFrame]["BUTTON"],false,false,sameCol)
					else
						vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vBar[vFrame]["BUTTON"],false,vBar[vFrame]["PREVCOL"],newCol)
						maxCols[vFrame]=maxCols[vFrame]+1
					end
					vBar[vFrame]["PREVCOL"]=vBar[vFrame]["PREVROW"]
					rowNo[vFrame]=1
				else
					vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vBar[vFrame]["BUTTON"],false,vBar[vFrame]["PREVROW"],sameCol)
				end
			end
        end
    end)
end

function HealBot_Panel_SetupExtraBars(frame)
    if Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][frame]["SHOW"] or
       Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][frame]["GRPCOLS"] then
        maxRows[frame]=0
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
    HealBot_Panel_PositionBars()

    for xHeader,xButton in pairs(HealBot_Header_Frames) do
        if xButton.frame==frame and not HealBot_Track_Headers[xHeader] then
            HealBot_Panel_DeleteHeader(xButton.id, xHeader)
        end
    end
    
    if hbBarsPerFrame[frame]>0 then
        if HealBot_Config.DisabledNow==0 then
            HealBot_Action_SetHeightWidth(maxRows[frame],maxCols[frame],maxHeaders[frame],frame)
            if HealBot_setTestBars or (Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][frame]["AUTOCLOSE"]==false or HealBot_Data["UILOCK"]) then
                HealBot_Action_ShowPanel(frame)
            end
        else
            HealBot_Action_HidePanel(frame)
        end	
    else
        HealBot_Action_HidePanel(frame)
    end
end

local vSetupBarsOptionsFrame=nil
function HealBot_Panel_SetupBars()
    for j=1,5 do
        if hbBarsPerFrame[j] and hbBarsPerFrame[j]>0 then
            if Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][j]["SHOW"] or
               Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j]["GRPCOLS"] then
                maxRows[j]=0
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

    HealBot_Panel_PositionBars()

    for xHeader,xButton in pairs(HealBot_Header_Frames) do
        if xButton.frame<6 and not HealBot_Track_Headers[xHeader] then
            HealBot_Panel_DeleteHeader(xButton.id, xHeader)
        end
    end

    local vSetupBarsFrame=0
    for j=1,5 do
        if hbBarsPerFrame[j]>0 and vSetupBarsFrame==0 then 
            vSetupBarsFrame=j
            break
        end
    end
    if HealBot_Globals.HideOptions then
        if vSetupBarsOptionsFrame and hbOptionOn>0 then
            vSetupBarsOptionsFrame:Hide()
            hbOptionOn=0
        end
    elseif vSetupBarsFrame>0 then
        local vSetupBarsOptionsParent=_G["f"..vSetupBarsFrame.."_HealBot_Action"]
        vSetupBarsOptionsFrame=_G["HealBot_Action_OptionsButton"]
        if not vSetupBarsOptionsFrame then 
            vSetupBarsOptionsFrame=CreateFrame("Button", "HealBot_Action_OptionsButton", vSetupBarsOptionsParent, "HealBotOptionsButtonTemplate") 
            local bar = _G[vSetupBarsOptionsFrame:GetName().."Bar"]
            bar:SetStatusBarColor(0.1,0.1,0.4,0);
            bar:SetMinMaxValues(0,100);
            bar:SetValue(0);
            vSetupBarsOptionsFrame.frame=vSetupBarsFrame
            bar.txt = _G[bar:GetName().."_text"];
            bar.txt:SetTextColor(0.8,0.8,0.2,0.85);
            bar.txt:SetText(HEALBOT_ACTION_OPTIONS);
            bar:UnregisterAllEvents()
            bar = _G[vSetupBarsOptionsFrame:GetName().."Bar5"]
            bar:SetStatusBarColor(0.1,0.1,0.4,0);
            bar:SetMinMaxValues(0,100);
            bar:SetValue(0);
            bar:UnregisterAllEvents()
        elseif vSetupBarsOptionsFrame.frame~=vSetupBarsFrame then
            vSetupBarsOptionsFrame:Hide()
            vSetupBarsOptionsFrame:ClearAllPoints()
            vSetupBarsOptionsFrame:SetParent(vSetupBarsOptionsParent)
            vSetupBarsOptionsFrame.frame=vSetupBarsFrame
        end
        if vSetupBarsOptionsFrame then
            vSetupBarsOptionsFrame:ClearAllPoints()
            if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][vSetupBarsFrame]["BARS"]==2 or Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][vSetupBarsFrame]["BARS"]==4 then
                vSetupBarsOptionsFrame:SetPoint("TOP",vSetupBarsOptionsParent,"TOP",0,-10);
            else
                vSetupBarsOptionsFrame:SetPoint("BOTTOM",vSetupBarsOptionsParent,"BOTTOM",0,10);
            end
            vSetupBarsOptionsFrame:Show();
            hbOptionOn=vSetupBarsFrame
            --MaxOffsetY[vSetupBarsFrame] = MaxOffsetY[vSetupBarsFrame]+30;
        end
    elseif hbOptionOn>0 and vSetupBarsOptionsFrame then
        vSetupBarsOptionsFrame:Hide()
        hbOptionOn=0
    end
    
    for j=1,5 do
        if hbBarsPerFrame[j]>0 then	
            if HealBot_Config.DisabledNow==0 then
                HealBot_Action_SetHeightWidth(maxRows[j],maxCols[j],maxHeaders[j],j)
                if HealBot_setTestBars or (Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][j]["AUTOCLOSE"]==false or HealBot_Data["UILOCK"]) then
                    HealBot_Action_ShowPanel(j)
                end
            else
                HealBot_Action_HidePanel(j)
            end
        else
            HealBot_Action_HidePanel(j)
        end
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
    end
    for x,_ in pairs(HealBot_Action_HealButtons) do
        HealBot_Action_HealButtons[x]=nil;
    end 
    for xHeader,xButton in pairs(HealBot_Header_Frames) do
        HealBot_Panel_DeleteHeader(xButton.id, xHeader)
    end
    for x,b in pairs(HealBot_TestBarsActive) do
        HealBot_TestBarsActive[x]=nil
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
            if healGroups[gl]["STATE"] and HealBot_Globals.TestBars["PROFILE"]>1 and xRaidBars>0 then
                if Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["RAIDORDER"]==3 then
                    if xRaidBars<5 then
                        HealBot_Panel_testAddButton(HEALBOT_OPTIONS_EMERGENCYHEALS.." "..HEALBOT_OPTIONS_GROUPHEALS.." "..grpNo,HEALBOT_OPTIONS_EMERGENCYHEALS,1,xRaidBars)
                    else
                        HealBot_Panel_testAddButton(HEALBOT_OPTIONS_EMERGENCYHEALS.." "..HEALBOT_OPTIONS_GROUPHEALS.." "..grpNo,HEALBOT_OPTIONS_EMERGENCYHEALS,1,5)
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
                else
                    HealBot_Panel_testAddButton(HEALBOT_OPTIONS_EMERGENCYHEALS.." "..HEALBOT_OPTIONS_GROUPHEALS.." "..grpNo,HEALBOT_OPTIONS_EMERGENCYHEALS,1,xRaidBars)
                end
            end
        end
    end
    
    HealBot_Panel_SetupBars()
    
    if healGroups[10]["STATE"] then
        hbCurrentFrame=9
        for x,_ in pairs(HealBot_Action_HealButtons) do
            HealBot_Action_HealButtons[x]=nil;
        end 
        HealBot_Panel_testAddButton(HEALBOT_FOCUS,HEALBOT_FOCUS,1,1)
        HealBot_Panel_SetupExtraBars(9)
    else
        HealBot_Action_HidePanel(9)
    end
    
    if healGroups[9]["STATE"] then
        hbCurrentFrame=8
        for x,_ in pairs(HealBot_Action_HealButtons) do
            HealBot_Action_HealButtons[x]=nil;
        end 
        HealBot_Panel_testAddButton(HEALBOT_OPTIONS_TARGETHEALS,HEALBOT_OPTIONS_TARGETHEALS,1,1)
        HealBot_Panel_SetupExtraBars(8)
    else
        HealBot_Action_HidePanel(8)
    end
    
    if HealBot_Globals.TestBars["PETS"]>0 and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["FRAME"]==7 and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["STATE"] then
        hbCurrentFrame=7
        for x,_ in pairs(HealBot_Action_HealButtons) do
            HealBot_Action_HealButtons[x]=nil;
        end 
        HealBot_Panel_testAddButton(HEALBOT_OPTIONS_PETHEALS,HEALBOT_OPTIONS_PETHEALS,1,HealBot_Globals.TestBars["PETS"])
        HealBot_Panel_SetupExtraBars(7)
    else
        HealBot_Action_HidePanel(7)
    end
    
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["FRAME"]==6 and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["STATE"] then
        hbCurrentFrame=6
        for x,_ in pairs(HealBot_Action_HealButtons) do
            HealBot_Action_HealButtons[x]=nil;
        end 
        HealBot_Panel_testAddButton(HEALBOT_VEHICLE,HEALBOT_VEHICLE,1,2)
        HealBot_Panel_SetupExtraBars(6)
    else
        HealBot_Action_HidePanel(6)
    end
    
    if healGroups[11]["STATE"] then
        hbCurrentFrame=10
        for x,_ in pairs(HealBot_Action_HealButtons) do
            HealBot_Action_HealButtons[x]=nil;
        end 
        HealBot_Panel_testAddButton(HEALBOT_CUSTOM_CASTBY_ENEMY,HEALBOT_CUSTOM_CASTBY_ENEMY,1,HealBot_Globals.TestBars["ENEMY"],HEALBOT_CUSTOM_CASTBY_ENEMY)
        HealBot_Panel_SetupExtraBars(10)
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
end

function HealBot_Panel_resetTestCols(force)
    if HealBot_setTestBars then
        if force then HealBot_setTestCols={} end
        HealBot_nextRecalcParty(0)
    end
end

function HealBot_cpsUnit(unit,sUnit)
    local xUnit=nil
    if unit then
        if unit=="player" then
            xUnit="p"
        elseif strsub(unit,1,5)=="party" then
            xUnit="g"..strsub(unit,6)
        elseif strsub(unit,1,4)=="raid" then
            xUnit=strsub(unit,5)
        elseif unit=="focus" then
            xUnit="f"
        end
    elseif sUnit then
        if sUnit=="p" then
            xUnit="player"
        elseif strsub(sUnit,1,1)=="g" then
            xUnit="party"..strsub(sUnit,2)
        elseif sUnit=="f" then
            xUnit="focus"
        else
            xUnit="raid"..sUnit
        end
    end
    return xUnit
end

function HealBot_Panel_cpSort(unitName, unit, hbGUID, hbCurFrame)
    if unitName and unit and hbGUID then
        unit=HealBot_cpsUnit(nil,unit)
        if not HealBot_TrackUnit[unit] then
            hbGUID="0x"..hbGUID
            local frameNo=tonumber(hbCurFrame) or 1
            local setButton=HealBot_Action_SetHealButton(unit,hbGUID,frameNo,1,false,3);
            if setButton then
                hbHealButtonsConcat[1]=unit
                hbHealButtonsConcat[3]="1"
                table.insert(HealBot_Action_HealButtons,table.concat(hbHealButtonsConcat))
                HealBot_cpName[unit]=unitName
                HealBot_TrackUnit[unit]=true
                hbBarsPerFrame[frameNo]=hbBarsPerFrame[frameNo]+1
            end
        end
    end
end

function HealBot_Panel_enemyBar(eUnit)
    i[hbCurrentFrame]=i[hbCurrentFrame]+1
    table.insert(units,eUnit)
    if Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["ENEMYTARGET"] then
        HealBot_SpecialUnit[eUnit]=1
        HealBot_SpecialUnit[eUnit.."target"]=2
    else
        HealBot_SpecialUnit[eUnit]=nil
        HealBot_SpecialUnit[eUnit.."target"]=nil
    end
end

function HealBot_Panel_checkEnemyBar(eUnit, pUnit, existsShow)
    if Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["HIDE"] then
        if HealBot_Data["UILOCK"] then
            if existsShow then
                if UnitExists(eUnit) and UnitExists(pUnit) then
                    HealBot_Panel_enemyBar(eUnit)
                end
            else
                HealBot_Panel_enemyBar(eUnit)
            end
        end
    else
        HealBot_Panel_enemyBar(eUnit)
    end
end

local vSubSortUnit,vSubSortGUID,vExists,vDup,vRole="","",false,false,3
function HealBot_Panel_SubSort(doSubSort,unitType)
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
            if HealBot_Action_SetHealButton(vSubSortUnit,vSubSortGUID,hbCurrentFrame,unitType,vDup,vRole) then
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
            vSubOrderKey = 19+(HealBot_UnitGroups[unit] or 1)
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

function HealBot_Panel_addUnit(unit, unitType, hbGUID, isRaidGroup)
    local vAddUnitSubGroup=HealBot_UnitGroups[unit] or 0;
    if (vAddUnitSubGroup==0 or Healbot_Config_Skins.IncludeGroup[Healbot_Config_Skins.Current_Skin][hbCurrentFrame][vAddUnitSubGroup]) and 
       (Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["INCCLASSES"]==1 or HealBot_Options_retEmergInc(HealBot_Panel_classEN(unit), hbCurrentFrame)) then
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
            if not UnitIsVisible(xUnit) or not Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["HIDEOOR"] then
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

local vMainSortIndex,vMainSortKey=0,""
function HealBot_Panel_MainSort(doMainSort,unitType)
    if #units>0 then
        if doMainSort and Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["RAIDORDER"]<6 then
            vMainSortIndex=0
            table.sort(units,function (a,b)
                if order[a]<order[b] then return true end
                if order[a]>order[b] then return false end
                return a<b
            end)
            vMainSortKey=order[units[1]]
            for j=1,#units do
                if vMainSortKey~=order[units[j]] then
                    HealBot_Panel_SubSort(true, unitType)
                    vMainSortIndex=j
                    vMainSortKey=order[units[j]]
                end
                HealBot_Panel_insSort(units[j], false)
            end
            if not j or vMainSortIndex<j then
                HealBot_Panel_SubSort(true, unitType)
            end
        else
            for j=1,#units do
                HealBot_Panel_insSort(units[j], false)
            end
            HealBot_Panel_SubSort(true, unitType)
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

function HealBot_Panel_addUnits(doMainSort,unitType,hText,k)
    HealBot_Panel_MainSort(doMainSort,unitType)
    HeaderPos[hbCurrentFrame][k+1] = hText 
      --HealBot_setCall("HealBot_Panel_addUnits")
end

local vEnemyIndex,vEnemyLocation,vEnemyBossNum,vEnemyBossExist=0,"",0,false
function HealBot_Panel_enemyTargets()
    HeaderPos[hbCurrentFrame][i[hbCurrentFrame]+1] = HEALBOT_OPTIONS_TARGETHEALS
    vEnemyIndex=i[hbCurrentFrame]
    if Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCSELF"] then
        HealBot_Panel_checkEnemyBar("playertarget", "player", Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["EXISTSHOWPTAR"])
    end
    _,vEnemyLocation = IsInInstance()
    if vEnemyLocation == "arena" then
        if Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCARENA"] then
            for j=1,5 do
                xUnit="arena"..j;
                HealBot_Panel_checkEnemyBar(xUnit, xUnit, Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["EXISTSHOWARENA"])
            end
        end
        if Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCARENAPETS"] then
            for j=1,5 do
                xUnit="arenapet"..j;
                HealBot_Panel_checkEnemyBar(xUnit, xUnit, Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["EXISTSHOWARENA"])
            end
        end
    end
    if Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCTANKS"] then
        for _,xUnit in pairs(HealBot_MainTanks) do
            HealBot_Panel_checkEnemyBar(xUnit.."target", xUnit, Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["EXISTSHOWPTAR"])
        end
    end
    if Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCMYTAR"] then
        table.foreach(HealBot_MyHealTargets, function (index,xGUID)
            xUnit=hbPanel_dataGUIDs[xGUID] or hbPanel_dataPetGUIDs[xGUID] or "unknown"
            HealBot_Panel_checkEnemyBar(xUnit.."target", xUnit, Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["EXISTSHOWPTAR"])
        end)
    end
    
    if HEALBOT_GAME_VERSION>3 then
        vEnemyBossNum=Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["NUMBOSS"]
        vEnemyBossExist=Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["EXISTSHOWBOSS"]
        if HealBot_Panel_luVars["MAPID"]==953 then
            if UnitExists("boss1") then
                if vEnemyBossNum<3 then vEnemyBossNum=3 end
                vEnemyBossExist=false
            end
        end
        
        if vEnemyBossNum>0 then
            for bi=1,vEnemyBossNum do
                xUnit="boss"..bi
                HealBot_Panel_checkEnemyBar(xUnit, xUnit, vEnemyBossExist)
            end
        end
    end

    if i[hbCurrentFrame]>vEnemyIndex then 
        HealBot_Panel_addUnits(false,11,HEALBOT_CUSTOM_CASTBY_ENEMY,vEnemyIndex)
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
        if not UnitIsVisible("target") or not Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["HIDEOOR"] then
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
        HealBot_Panel_SubSort(false,9)
        HeaderPos[hbCurrentFrame][i[hbCurrentFrame]] = HEALBOT_OPTIONS_TARGETHEALS
    end
end

local vVehiclePlayerUnit,vVehicleUnit,vVehicleIndex="","",0
function HealBot_Panel_vehicleHeals()
    if HEALBOT_GAME_VERSION>3 then
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
            HealBot_Panel_addUnits(true, 7,HEALBOT_VEHICLE,vVehicleIndex)
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
function HealBot_Panel_petHeals()
    HeaderPos[hbCurrentFrame][i[hbCurrentFrame]+1] = HEALBOT_OPTIONS_PETHEALS
    vPetGrp5ID=0
    vPetIndex=i[hbCurrentFrame]
    vPetUnit="pet"
    vPetPlayerUnit="player"
    vPetPlayerInVehicle=false
    vPetRole=HealBot_Panel_petRole(vPetUnit)
    if vPetRole~="TANK" and vPetRole~="HEALER" then
        if HEALBOT_GAME_VERSION>3 then vPetPlayerInVehicle=UnitUsingVehicle(vPetPlayerUnit) end
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
                    if HEALBOT_GAME_VERSION>3 then vPetPlayerInVehicle=UnitUsingVehicle(vPetPlayerUnit) end
                    if UnitExists(vPetPlayerUnit) and not vPetPlayerInVehicle then
                        HealBot_Panel_addUnit(vPetUnit, 8, hbPanel_dataPetUnits[vPetUnit], false)
                    end
                    if Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["GROUPPETS"] then
                        if i[hbCurrentFrame]-vPetIndex == 6 then 
                            vPetGrp5ID=vPetGrp5ID+1
                            HeaderPos[hbCurrentFrame][i[hbCurrentFrame]-5] = HEALBOT_OPTIONS_PETHEALS.." "..vPetGrp5ID
                        end
                        if i[hbCurrentFrame]>vPetIndex and ((i[hbCurrentFrame]-vPetIndex)%5 == 0) then                           
                            HealBot_Panel_MainSort(true,8)        
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
                    if HEALBOT_GAME_VERSION>3 then vPetPlayerInVehicle=UnitUsingVehicle(vPetPlayerUnit) end
                    if UnitExists(vPetPlayerUnit) and not vPetPlayerInVehicle then 
                        HealBot_Panel_addUnit(vPetUnit, 8, hbPanel_dataPetUnits[vPetUnit], false)
                    end
                end
            end
        end
    end
    if i[hbCurrentFrame]>vPetIndex then
        HealBot_Panel_MainSort(true,8)        
        if not Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["GROUPPETS"] then
            HeaderPos[hbCurrentFrame][vPetIndex+1] = HEALBOT_OPTIONS_PETHEALS
        elseif nraid==0 or (not HeaderPos[hbCurrentFrame][vPetIndex+1] and (i[hbCurrentFrame]-vPetIndex)%5>0) then 
            vPetGrp5ID=vPetGrp5ID+1
            HeaderPos[hbCurrentFrame][vPetIndex+1] = HEALBOT_OPTIONS_PETHEALS.." "..vPetGrp5ID
        end
    end
end

local vRaidTargetNum,vRaidUnit,vRaidIndex=0,"",0
local vRaidPrevSort,vRaidHeadSort,vRaidSubSort,vRaidShowHeader="","","init",false
function HealBot_Panel_raidHeals()
    vRaidIndex=i[hbCurrentFrame]
    if Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["RAIDORDER"]==1 or Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["RAIDORDER"]==5 then
        HeaderPos[hbCurrentFrame][i[hbCurrentFrame]+1] = HEALBOT_OPTIONS_EMERGENCYHEALS
    end
    
    vRaidTargetNum = nraid
    if HealBot_Panel_luVars["cpCOMBAT"] and nraid>0 and HealBot_Panel_luVars["cpCOMBATRAID"] then 
        if vRaidTargetNum<11 then
            vRaidTargetNum=10
        elseif vRaidTargetNum<16 then
            vRaidTargetNum=15
        elseif vRaidTargetNum<26 then
            vRaidTargetNum=25
        else
            vRaidTargetNum=40
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
            elseif HealBot_Panel_luVars["cpCOMBAT"] and HealBot_Panel_luVars["cpCOMBATRAID"] then 
                HealBot_Panel_addUnit(vRaidUnit, 5, vRaidUnit, true)
            end
        end
    else
        for _,xUnit in ipairs(HealBot_Action_HealGroup) do
            if hbPanel_dataUnits[xUnit] then
                HealBot_Panel_addUnit(xUnit, 5, hbPanel_dataUnits[xUnit], true)
            elseif HealBot_Panel_luVars["cpCOMBAT"] and IsInGroup() and HealBot_Panel_luVars["cpCOMBATPARTY"] then 
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
                HealBot_Panel_SubSort(true, 5)
                vRaidSubSort=order[vRaidUnit]
                vRaidPrevSort=vRaidHeadSort
            end
        end
        HealBot_Panel_insSort(vRaidUnit, false)
    end
    if #units>0 then
        HealBot_Panel_SubSort(true, 5)
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
        elseif not UnitIsVisible("focus") or not Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["HIDEOOR"] then
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
        HealBot_Panel_SubSort(false, 10)
        HeaderPos[hbCurrentFrame][i[hbCurrentFrame]] = HEALBOT_FOCUS
    end
end

local vMyTargetsIndex,vMyTargetsUnit=0,"unknown"
function HealBot_Panel_myHeals()
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
        HealBot_Panel_addUnits(true, 4,HEALBOT_OPTIONS_MYTARGET,vMyTargetsIndex)
    end
end

local vGroupIndex=0
function HealBot_Panel_groupHeals()
    vGroupIndex=i[hbCurrentFrame]
    for _,xUnit in ipairs(HealBot_Action_HealGroup) do
        if UnitExists(xUnit) and UnitGUID(xUnit) and hbPanel_dataGUIDs[UnitGUID(xUnit)] then
            if nraid>0 and not UnitIsUnit(xUnit, "player") then 
                xUnit=hbPanel_dataGUIDs[UnitGUID(xUnit)] or xUnit
            end
            HealBot_Panel_addUnit(xUnit, 6, hbPanel_dataUnits[xUnit], false)
        elseif nraid==0 and HealBot_Panel_luVars["cpCOMBAT"] and IsInGroup() and HealBot_Panel_luVars["cpCOMBATPARTY"] then
            HealBot_UnitGroups[xUnit]=1
            HealBot_Panel_addUnit(xUnit, 6, xUnit, false)
        end
    end
    if i[hbCurrentFrame]>vGroupIndex then 
        HealBot_Panel_addUnits(true, 6,HEALBOT_OPTIONS_GROUPHEALS,vGroupIndex)
        MyGroup["GROUP"]=vGroupIndex+1
        MyGroup["FRAME"]=hbCurrentFrame
    else
        MyGroup["GROUP"]=0
    end
end

local vHealIndex=0
function HealBot_Panel_healerHeals()
    vHealIndex=i[hbCurrentFrame]
    for xGUID,xUnit in pairs(HealBot_MainHealers) do
        HealBot_Panel_addUnit(xUnit, 2, xGUID, false)
    end
    if i[hbCurrentFrame]>vHealIndex then 
        HealBot_Panel_addUnits(true, 2,HEALBOT_CLASSES_HEALERS,vHealIndex)
    end
end

local vTankIndex=0
function HealBot_Panel_tankHeals()
    vTankIndex=i[hbCurrentFrame]
    for xGUID,xUnit in pairs(HealBot_MainTanks) do
        HealBot_Panel_addUnit(xUnit, 1, xGUID, false)
    end
    if i[hbCurrentFrame]>vTankIndex then
        HealBot_Panel_addUnits(true, 1, HEALBOT_OPTIONS_TANKHEALS,vTankIndex)
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
        HealBot_Panel_addUnits(false, 3, HEALBOT_OPTIONS_SELFHEALS,vSelfIndex)
    end
end

function HealBot_Panel_VehicleChanged()
    hbCurrentFrame=6
    hbBarsPerFrame[hbCurrentFrame]=0
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["STATE"]then
        i[hbCurrentFrame]=0
        HeaderPos[hbCurrentFrame]={};
        HealBot_Panel_vehicleHeals()
        for xUnit,xButton in pairs(HealBot_Pet_Button) do
            if xButton.status.unittype==7 then
                if HealBot_TrackUnit[xUnit] then
                    HealBot_Action_UpdateBackgroundButton(xButton)
                    xButton:Show()
                else
                    HealBot_Action_MarkDeleteButton(xButton)
                end
            end
        end
        HealBot_Panel_SetupExtraBars(hbCurrentFrame)
    else
        for xUnit,xButton in pairs(HealBot_Pet_Button) do
            if xButton.status.unittype==7 then
                HealBot_Action_MarkDeleteButton(xButton)
            end
        end
        HealBot_Action_HidePanel(hbCurrentFrame)
    end
end

local vPetsChangedRole=""
function HealBot_Panel_PetsChanged()
    hbCurrentFrame=7
    hbBarsPerFrame[hbCurrentFrame]=0
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["STATE"] then
        i[hbCurrentFrame]=0
        HeaderPos[hbCurrentFrame]={};
        HealBot_Panel_petHeals()
		HealBot_Panel_luVars["NumPets"]=0
        for xUnit,xButton in pairs(HealBot_Pet_Button) do
            if xButton.status.unittype==8 then
                vPetsChangedRole=HealBot_Panel_petRole(xUnit)
                if HealBot_TrackUnit[xUnit] or vPetsChangedRole=="TANK" or vPetsChangedRole=="HEALER" then
                    HealBot_Action_UpdateBackgroundButton(xButton)
                    xButton:Show()
					HealBot_Panel_luVars["NumPets"]=HealBot_Panel_luVars["NumPets"]+1
                elseif xButton.unit~="pet" or not HealBot_Panel_luVars["SelfPets"] then
                    HealBot_Action_MarkDeleteButton(xButton)
                end
            end
        end
        HealBot_Panel_SetupExtraBars(hbCurrentFrame)
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
        vTargetButton = HealBot_Unit_Button["target"]
        if vTargetButton then
            if HealBot_TrackUnit[vTargetButton.unit] and not HealBot_Panel_BlackList[vTargetButton.guid] then
                HealBot_setLuVars("TargetNeedReset", false)
                HealBot_Action_UpdateBackgroundButton(vTargetButton)
                vTargetButton:Show()
                HealBot_Panel_TargetChangedCheckFocus()
            else
                HealBot_Action_HidePanel(hbCurrentFrame)
            end
        end
        HealBot_Panel_SetupExtraBars(hbCurrentFrame)
    else
        vTargetButton = HealBot_Unit_Button["target"]
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
        local tButton=HealBot_Unit_Button["target"]
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
    if HEALBOT_GAME_VERSION>3 then 
        hbCurrentFrame=9
        hbBarsPerFrame[hbCurrentFrame]=0
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["STATE"] then
            i[hbCurrentFrame]=0
            HeaderPos[hbCurrentFrame]={};
            HealBot_Panel_focusHeals(preCombat)
            vFocusButton = HealBot_Unit_Button["focus"]
            if vFocusButton then
                if HealBot_TrackUnit[vFocusButton.unit] and not HealBot_Panel_BlackList[vFocusButton.guid] then
                    HealBot_setLuVars("FocusNeedReset", false)
                    HealBot_Action_UpdateBackgroundButton(vFocusButton)
                    vFocusButton:Show()
                else
                    HealBot_Action_HidePanel(hbCurrentFrame)
                end
            end
            HealBot_Panel_SetupExtraBars(hbCurrentFrame)
        else
            vFocusButton = HealBot_Unit_Button["focus"]
            if vFocusButton then
                HealBot_Action_MarkDeleteButton(vFocusButton)
            end
            HealBot_Action_HidePanel(hbCurrentFrame)
        end
    elseif Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["STATE"] then
        Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["STATE"]=false
    end
end

function HealBot_Panel_EnemyChanged()
    hbCurrentFrame=10
    hbBarsPerFrame[hbCurrentFrame]=0
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][11]["STATE"] then
        i[hbCurrentFrame]=0
        HeaderPos[hbCurrentFrame]={};
        HealBot_Panel_enemyTargets()
        for xUnit,xButton in pairs(HealBot_Enemy_Button) do
            if HealBot_TrackUnit[xUnit] then
                HealBot_Action_UpdateBackgroundButton(xButton)
                xButton:Show()
            else
                HealBot_Action_MarkDeleteButton(xButton)
            end
        end
        HealBot_Panel_SetupExtraBars(hbCurrentFrame)
    else
        for xUnit,xButton in pairs(HealBot_Enemy_Button) do
            HealBot_Action_MarkDeleteButton(xButton)
        end
        HealBot_Action_HidePanel(hbCurrentFrame)
    end
end

function HealBot_Panel_setCrashProt()
    if HealBot_Globals.OverrideProt["USE"]==1 then
        HealBot_Panel_luVars["cpMACRONAME"]=HealBot_Config.CrashProtMacroName
        HealBot_Panel_luVars["cpCRASH"]=Healbot_Config_Skins.Protection[Healbot_Config_Skins.Current_Skin]["CRASH"]
    else
        HealBot_Panel_luVars["cpMACRONAME"]=HealBot_Globals.OverrideProt["MACRONAME"]
        HealBot_Panel_luVars["cpCRASH"]=HealBot_Globals.OverrideProt["CRASH"]
    end
end

local vIsCrashProt,vPetsWithPlayers=false,false
function HealBot_Panel_PlayersChanged()
    nraid=GetNumGroupMembers();
    TempMaxH=9;
    
    if not IsInRaid() then nraid=0 end;

    for gl=1,5 do
        HeaderPos[gl]={};
        hbBarsPerFrame[gl]=0
        i[gl]=0
    end
    
    for x,_ in pairs(HealBot_cpName) do
        HealBot_cpName[x]=nil
    end 

    vIsCrashProt=false
    if HealBot_Panel_luVars["cpCRASH"] and HealBot_retLuVars("cpLoadTime")>GetTime() then
        if nraid==0 and not UnitExists("player") then
            HealBot_cpData["mName"]=HealBot_Panel_luVars["cpMACRONAME"]
            HealBot_cpData["body0"]=GetMacroBody(HealBot_cpData["mName"].."_0")
            if HealBot_cpData["body0"] and strsub(HealBot_cpData["body0"],1,5)~="Clean" then
                local t=tonumber(strsub(HealBot_cpData["body0"],1,1))
                if t>0 and t<6 then
                    vIsCrashProt=true
                    HealBot_cpData["numMacros"]=t
                    for j=1,t do
                        HealBot_cpData["body"..j]=GetMacroBody(HealBot_cpData["mName"].."_"..j)
                        if not HealBot_cpData["body"..j] or strlen(HealBot_cpData["body"..j])<14 then
                            vIsCrashProt=false
                        end
                    end
                end
            end
        end
    end

    if vIsCrashProt then -- Crash Protection
        for j=1,tonumber(HealBot_cpData["numMacros"]) do
            local u1n,u1u,u1g,u1f,u2n,u2u,u2g,u2f,u3n,u3u,u3g,u3f,u4n,u4u,u4g,u4f,
                  u5n,u5u,u5g,u5f,u6n,u6u,u6g,u6f,u7n,u7u,u7g,u7f,u8n,u8u,u8g,u8f = string.split(":", HealBot_cpData["body"..j])
            HealBot_Panel_cpSort(u1n, u1u, u1g, u1f)
            HealBot_Panel_cpSort(u2n, u2u, u2g, u2f)
            HealBot_Panel_cpSort(u3n, u3u, u3g, u3f)
            HealBot_Panel_cpSort(u4n, u4u, u4g, u4f)
            HealBot_Panel_cpSort(u5n, u5u, u5g, u5f)
            HealBot_Panel_cpSort(u6n, u6u, u6g, u6f)
            HealBot_Panel_cpSort(u7n, u7u, u7g, u7f)
            HealBot_Panel_cpSort(u8n, u8u, u8g, u8f)
        end
        local _,c1,h1f,h1p,h1n,h2f,h2p,h2n,h3f,h3p,h3n,h4f,h4p,h4n,h5f,h5p,h5n,h6f,h6p,h6n,h7f,h7p,h7n,h8f,h8p,h8n,
              h9f,h9p,h9n,h10f,h10p,h10n,h11f,h11p,h11n,h12f,h12p,h12n,h13f,h13p,h13n,h14f,h14p,h14n,h15f,h15p,h15n = string.split(":", HealBot_cpData["body0"])
        if c1=="H" then
            if tonumber(h1f) and tonumber(h1f)>0 and tonumber(h1f)<11 and h1p and h1n then HeaderPos[tonumber(h1f)][tonumber(h1p)] = h1n end
            if tonumber(h2f) and tonumber(h2f)>0 and tonumber(h2f)<11 and h2p and h2n then HeaderPos[tonumber(h2f)][tonumber(h2p)] = h2n end
            if tonumber(h3f) and tonumber(h3f)>0 and tonumber(h3f)<11 and h3p and h3n then HeaderPos[tonumber(h3f)][tonumber(h3p)] = h3n end
            if tonumber(h4f) and tonumber(h4f)>0 and tonumber(h4f)<11 and h4p and h4n then HeaderPos[tonumber(h4f)][tonumber(h4p)] = h4n end
            if tonumber(h5f) and tonumber(h5f)>0 and tonumber(h5f)<11 and h5p and h5n then HeaderPos[tonumber(h5f)][tonumber(h5p)] = h5n end
            if tonumber(h6f) and tonumber(h6f)>0 and tonumber(h6f)<11 and h6p and h6n then HeaderPos[tonumber(h6f)][tonumber(h6p)] = h6n end
            if tonumber(h7f) and tonumber(h7f)>0 and tonumber(h7f)<11 and h7p and h7n then HeaderPos[tonumber(h7f)][tonumber(h7p)] = h7n end
            if tonumber(h8f) and tonumber(h8f)>0 and tonumber(h8f)<11 and h8p and h8n then HeaderPos[tonumber(h8f)][tonumber(h8p)] = h8n end
            if tonumber(h9f) and tonumber(h9f)>0 and tonumber(h9f)<11 and h9p and h9n then HeaderPos[tonumber(h9f)][tonumber(h9p)] = h9n end
            if tonumber(h10f) and tonumber(h10f)>0 and tonumber(h10f)<11 and h10p and h10n then HeaderPos[tonumber(h10f)][tonumber(h10p)] = h10n end
            if tonumber(h11f) and tonumber(h11f)>0 and tonumber(h11f)<11 and h11p and h11n then HeaderPos[tonumber(h11f)][tonumber(h11p)] = h11n end
            if tonumber(h12f) and tonumber(h12f)>0 and tonumber(h12f)<11 and h12p and h12n then HeaderPos[tonumber(h12f)][tonumber(h12p)] = h12n end
            if tonumber(h13f) and tonumber(h13f)>0 and tonumber(h13f)<11 and h13p and h13n then HeaderPos[tonumber(h13f)][tonumber(h13p)] = h13n end
            if tonumber(h14f) and tonumber(h14f)>0 and tonumber(h14f)<11 and h14p and h14n then HeaderPos[tonumber(h14f)][tonumber(h14p)] = h14n end
            if tonumber(h15f) and tonumber(h15f)>0 and tonumber(h15f)<11 and h15p and h15n then HeaderPos[tonumber(h15f)][tonumber(h15p)] = h15n end
        end
        HealBot_cpOn=true
    else
        HealBot_cpOn=false
        vPetsWithPlayers=false
        HealBot_Panel_luVars["TanksOn"]=false
        HealBot_Panel_luVars["HealsOn"]=false
        if HealBot_Config.DisabledNow==1 then
            hbCurrentFrame=1
            HealBot_Panel_selfHeals()
        else
            MyGroup["GROUP"]=0
			HealBot_Data["PLAYERGROUP"]=1
            for gl=1,8 do
                if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["STATE"] then
                    hbCurrentFrame=Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["FRAME"]
                    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["NAME"]==HEALBOT_OPTIONS_EMERGENCYHEALS_en then
                        HealBot_Panel_raidHeals()
                    elseif Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["NAME"]==HEALBOT_OPTIONS_GROUPHEALS_en then
                        HealBot_Panel_groupHeals()
                    elseif Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["NAME"]==HEALBOT_OPTIONS_TANKHEALS_en then
                        HealBot_Panel_tankHeals()
                        HealBot_Panel_luVars["TanksOn"]=true
                    elseif Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["NAME"]==HEALBOT_CLASSES_HEALERS_en then
                        HealBot_Panel_healerHeals()
                        HealBot_Panel_luVars["HealsOn"]=true
                    elseif Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["NAME"]==HEALBOT_OPTIONS_SELFHEALS_en then
                        HealBot_Panel_selfHeals()
                    elseif Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["NAME"]==HEALBOT_OPTIONS_MYTARGET_en then
                        HealBot_Panel_myHeals()
                    elseif Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["NAME"]==HEALBOT_OPTIONS_PETHEALS_en and hbCurrentFrame<6 then
                        HealBot_Panel_petHeals()
                        vPetsWithPlayers=true
                    elseif Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["NAME"]==HEALBOT_VEHICLE_en and hbCurrentFrame<6 then
                        HealBot_Panel_vehicleHeals()
                        vPetsWithPlayers=true
                    end
                end
            end
        end   
        
		HealBot_Panel_luVars["MarkClearDown"]=false
        for xUnit,xButton in pairs(HealBot_Unit_Button) do
            if xButton.status.unittype>4 and xButton.status.unittype<7 then
                if HealBot_TrackUnit[xUnit] and not HealBot_Panel_BlackList[xButton.guid] then
                    HealBot_Action_UpdateBackgroundButton(xButton)
                    xButton:Show()
                else
                    HealBot_Action_MarkDeleteButton(xButton)
					HealBot_Panel_luVars["MarkClearDown"]=true
                end
            elseif xButton.status.unittype<5 or xButton.status.unittype>10 then
                HealBot_Unit_Button[xUnit]=nil
            end
        end
		HealBot_Panel_luVars["NumPrivate"]=0
        for xUnit,xButton in pairs(HealBot_Private_Button) do
            if xButton.status.unittype<5 then
                if HealBot_TrackPrivateUnit[xUnit] and not HealBot_Panel_BlackList[xButton.guid] then
                    HealBot_Action_UpdateBackgroundButton(xButton)
                    xButton:Show()
					HealBot_Panel_luVars["NumPrivate"]=HealBot_Panel_luVars["NumPrivate"]+1
                else
                    HealBot_Action_MarkDeleteButton(xButton)
					HealBot_Panel_luVars["MarkClearDown"]=true
                end
            else
                HealBot_Private_Button[xUnit]=nil
            end
        end
        if vPetsWithPlayers then
			HealBot_Panel_luVars["NumPets"]=0
            for xUnit,xButton in pairs(HealBot_Pet_Button) do
                if HealBot_TrackUnit[xUnit] then
                    HealBot_Action_UpdateBackgroundButton(xButton)
                    xButton:Show()
					HealBot_Panel_luVars["NumPets"]=HealBot_Panel_luVars["NumPets"]+1
                else
                    HealBot_Action_MarkDeleteButton(xButton)
                end
            end
        end

        if HealBot_Panel_luVars["cpCRASH"] and not HealBot_Data["UILOCK"] and HealBot_Panel_luVars["SaveCrashProtection"]<=GetTime() then
            HealBot_Panel_luVars["SaveCrashProtection"]=GetTime()+5
            HealBot_cpData["mName"]=HealBot_Panel_luVars["cpMACRONAME"]
            local j=0
            local k=1
            local t=HealBot_cpData["body1"]
            HealBot_cpData["body1"]=""
            table.foreach(HealBot_Action_HealButtons, function (_,xUnitData)
                local xUnit,xUnitType=string.split("~", xUnitData)
                local xButton=HealBot_Unit_Button[xUnit] or HealBot_Private_Button[xUnit]
                if xButton then
                    local uName=HealBot_GetUnitName(xUnit)
                    if uName then
                        j=j+1
                        if j>8 then 
                            if HealBot_cpData["body"..k]~=t then HealBot_Panel_cpSave(k) end
                            j=1 
                            k=k+1
                            t=HealBot_cpData["body"..k]
                            HealBot_cpData["body"..k]=""
                        end
                        if k<6 then
                            local lUnit=HealBot_cpsUnit(xUnit,nil)
                            if lUnit then
                                HealBot_cpData["body"..k]=HealBot_cpData["body"..k]..strsub(uName,1,5)..":"..lUnit..":"..strsub(xButton.guid,3)..":"..xButton.frame..":"
                            end
                        end
                    end
                end
            end)
            if HealBot_cpData["body"..k]~=t then HealBot_Panel_cpSave(k) end
            t=HealBot_cpData["body0"]
            showHeaders=false
            HealBot_cpData["body0"]=k..":H:"
            for bFrame=1,5 do
                if Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][bFrame]["SHOW"] then
                    showHeaders=true
                    for j=1,(k*10)+j do
                        if HeaderPos[bFrame][j] then 
                            HealBot_cpData["body0"]=HealBot_cpData["body0"]..bFrame..":"..j..":"..HeaderPos[bFrame][j]..":"
                        end
                    end
                end
            end
            if not showHeaders then
                HealBot_cpData["body0"]=k..":N"
            end
            if HealBot_cpData["body0"]~=t then HealBot_Panel_cpSave(0) end
        end

    end
    HealBot_Panel_SetupBars()
	if HealBot_Panel_luVars["MarkClearDown"] then
		if HealBot_retLuVars("pluginTimeToDie") then HealBot_Plugin_TimeToDie_MarkClearDown() end
		if HealBot_retLuVars("pluginTimeToLive") then HealBot_Plugin_TimeToLive_MarkClearDown() end
		if HealBot_retLuVars("pluginThreat") then HealBot_Plugin_Threat_MarkClearDown() end
	end
end

function HealBot_Panel_clearcpData()
    HealBot_cpData={}
end

function HealBot_Panel_cpSave(mNum)
    HealBot_cpSave(HealBot_cpData["mName"].."_"..mNum, HealBot_cpData["body"..mNum])
end

function HealBot_RetUnitGroups(unit)
    return HealBot_UnitGroups[unit]
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
    if changeType>5 then
        HealBot_Panel_PlayersChanged()
    elseif changeType==2 and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["FRAME"]==7 then
        HealBot_Panel_PetsChanged()
    elseif changeType==3 then
        HealBot_Panel_TargetChanged(preCombat)
    elseif changeType==5 then
        HealBot_Panel_EnemyChanged()
    elseif changeType==4 then
        HealBot_Panel_FocusChanged(preCombat)
    elseif changeType==1 and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["FRAME"]==6 then
        HealBot_Panel_VehicleChanged()
    end
end

function HealBot_Panel_PartyChanged(preCombat, changeType)
    if HealBot_setTestBars and not HealBot_Data["UILOCK"] then
        HealBot_Panel_TestBarsOn()
    else
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
            HealBot_Panel_DoPartyChanged(preCombat, 6)
            if preCombat then
                HealBot_Panel_DoPartyChanged(preCombat, 5)
                if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["FRAME"]==6 then 
                    HealBot_Panel_buildDataStore(false, true)
                    HealBot_Panel_DoPartyChanged(preCombat, 1)
                end
                if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["FRAME"]==7 then 
                    HealBot_Panel_buildDataStore(false, true)
                    HealBot_Panel_DoPartyChanged(preCombat, 2)
                end
            else
                if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["FRAME"]==6 then HealBot_nextRecalcParty(1) end
                if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["FRAME"]==7 then HealBot_nextRecalcParty(2) end
                HealBot_nextRecalcParty(5)
            end
			HealBot_Panel_DoPartyChanged(preCombat, 3)
			HealBot_Panel_DoPartyChanged(preCombat, 4)
        end 
    end
	local nMembers=(GetNumGroupMembers()+HealBot_Panel_luVars["NumPrivate"]+HealBot_Panel_luVars["NumPets"])+5
    if nMembers>HealBot_Globals.AutoCacheSize then	
		HealBot_Globals.AutoCacheSize=nMembers
	end
	HealBot_setLuVars("UnitSlowUpdateFreq",HealBot_Comm_round((20/nMembers),4))
	HealBot_Update_FastEveryFrame(5)
      --HealBot_setCall("HealBot_Panel_PartyChanged")
end
