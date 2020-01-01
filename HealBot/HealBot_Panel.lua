local TempMaxH=0;
local bwidth={}
local bheight={}
local bcspace={}
local brspace={}
local cols={}
local HealBot_TrackNames={};
local i={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,[6]=0,[7]=0,[8]=0,[9]=0,[10]=0}
local order = {};
local units = {};
local suborder = {};
local subunits = {};
local MyGroup={["GROUP"]=0,["FRAME"]=1}
local HeaderPos={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
local OffsetY = {[1]=10,[2]=10,[3]=10,[4]=10,[5]=10,[6]=10,[7]=10,[8]=10,[9]=10,[10]=10};
local OffsetX = {[1]=10,[2]=10,[3]=10,[4]=10,[5]=10,[6]=10,[7]=10,[8]=10,[9]=10,[10]=10};
local MaxOffsetY={};
local MaxOffsetX={};
local HealBot_ActiveHeaders={[0]=1}
local HealBot_MultiColHoToffset=0;
local HealBot_MultiRowHoToffset=0;
local HealBot_OutlineOffset={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,[6]=0,[7]=0,[8]=0,[9]=0,[10]=0}
local HealBot_TrackUnit={}
local HealBot_Panel_BlackList={};
local HealBot_AddHeight={  ["BOTH"]={[1]=4,[2]=4,[3]=4,[4]=4,[5]=4,[6]=4,[7]=4,[8]=4,[9]=4,[10]=4},
                         ["BOTTOM"]={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,[6]=0,[7]=0,[8]=0,[9]=0,[10]=0},
                           ["BAR2"]={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,[6]=0,[7]=0,[8]=0,[9]=0,[10]=0}};
local HealBot_AddWidth={  ["BOTH"]={[1]=4,[2]=4,[3]=4,[4]=4,[5]=4,[6]=4,[7]=4,[8]=4,[9]=4,[10]=4},
                          ["SIDE"]={[1]=4,[2]=4,[3]=4,[4]=4,[5]=4,[6]=4,[7]=4,[8]=4,[9]=4,[10]=4}};
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
local HealBot_BottomAnchors={[1]=false,[2]=false,[3]=false,[4]=false,[5]=false,[6]=false,[7]=false,[8]=false,[9]=false,[10]=false};
local HealBot_cpName={}
local HealBot_cpData={}
local HealBot_cpOn=false
local _
local nraid=0
local hbOptionOn=nil
local hbFocusOn=nil
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
local HealBot_randomClCol = {   [1] = { [1] = 0.78, [2] = 0.04, [3] = 0.04, },  
                                [2] = { [1] = 0.78, [2] = 0.61, [3] = 0.43, },  
                                [3] = { [1] = 1.0, [2] = 0.49, [3] = 0.04, },   
                                [4] = { [1] = 0, [2] = 1.0, [3] = 0.59, }, 
                                [5] = { [1] = 0.96, [2] = 0.55, [3] = 0.73, },
                                [6] = { [1] = 1.0, [2] = 1.0, [3] = 1.0, },
                                [7] = { [1] = 0.14, [2] = 0.35, [3] = 1.0, },
                                [8] = { [1] = 0.58, [2] = 0.51, [3] = 0.79, },
                                [9] = { [1] = 0.67, [2] = 0.83, [3] = 0.45, },
                                [10] = { [1] = 0.41, [2] = 0.8, [3] = 0.94, },
                                [11] = { [1] = 1.0, [2] = 0.96, [3] = 0.41, },
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

function HealBot_Panel_retLuVars(vName)
    return HealBot_Panel_luVars[vName]
end

function HealBot_Panel_setLuVars(vName, vValue)
    HealBot_Panel_luVars[vName]=vValue
end

local function HealBot_Panel_TankRole(unit,guid)
    HealBot_unitRole[unit]=hbRole[HEALBOT_MAINTANK]
    HealBot_MainTanks[guid]=unit
    HealBot_setLuVars("TankUnit", unit)
    HealBot_Aura_setLuVars("TankUnit", unit)
end
 
local function HealBot_Panel_HealerRole(unit,guid)
    HealBot_unitRole[unit]=hbRole[HEALBOT_WORD_HEALER]
    HealBot_MainHealers[guid]=unit
end

local aRole = nil
local function HealBot_Panel_SetRole(unit,guid)
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

local function HealBot_Panel_addDataStore(unit, nRaidID, isPlayer)
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

local function HealBot_Panel_buildDataStore(doPlayers, doPets)
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
    HealBot_setOptions_Timer(596)
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
    local xGUID=UnitGUID(unit)
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
  
function HealBot_Panel_SetMultiColHoToffset(nx)
    HealBot_MultiColHoToffset=nx
    for j=1,10 do
        HealBot_OutlineOffset[j] = ceil(Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][j]["BOUT"]*Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][j]["SCALE"]);
    end
    HealBot_Action_SetAddHeightWidth()
end
  
function HealBot_Panel_SetMultiRowHoToffset(nx)
    HealBot_MultiRowHoToffset=nx
    HealBot_Action_SetAddHeightWidth()
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
    if UnitExists(button.unit) and Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["CLASSONBAR"] then
        local setRole=false
        local unitRole=HEALBOT_WORDS_UNKNOWN
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["SHOWROLE"] then
            unitRole=HealBot_Panel_UnitRole(button.unit, button.guid)
        end
        if roleTextures[unitRole] then
            button.icon.debuff.classtexture=roleTextures[unitRole];
        else
            button.icon.debuff.classtexture=classTextures[HealBot_Panel_classEN(button.unit)];
        end
    else
        button.icon.debuff.classtexture=false
    end
    button.aura.check=true
end

local HealBot_ResetHeaderSkinDone={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}};
function HealBot_Panel_clearResetHeaderSkinDone()
    HealBot_ResetHeaderSkinDone={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}};
end

local function HealBot_Panel_CreateHeader(hbCurFrame)
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
            hhb.frame=hbCurFrame
        elseif hhb.frame~=hbCurFrame then
            hhb:ClearAllPoints()
            hhb:SetParent(hp)
            hhb.frame=hbCurFrame
        end
        HealBot_ActiveHeaders[0]=freeId+1
        return hhb
    else
        return nil
    end
end

local function HealBot_Panel_DeleteHeader(hdrID, xHeader)
    local hg=_G["HealBot_Action_Header"..hdrID]
    if hdrID<HealBot_ActiveHeaders[0] then HealBot_ActiveHeaders[0]=hdrID end
    hg:Hide();
    HealBot_ActiveHeaders[hdrID]=nil
    HealBot_Header_Frames[xHeader]=nil
end

function HealBot_Panel_retHealBot_Header_Frames(hbCurFrame)
    return HealBot_Options_copyTable(HealBot_Header_Frames)
end

local vPosFrameHX,vPosFrameHY,vPosFrameHH,vPosFrameHF,vPosParentHF,vPosFrameHW,vPosFrameHB,vPostFrameBF=0,0,0,"","",0,"",""
local function HealBot_Action_PositionButton(button,OsetX,OsetY,bWidth,bHeight,xHeader,hbCurFrame,bcSpace,brSpace)
    if xHeader then
        vPosFrameHX,vPosFrameHY=0,0
        vPosFrameHH = ceil(Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][hbCurFrame]["HEIGHT"]*Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][hbCurFrame]["SCALE"])
        vPosParentHF=HealBot_Header_Frames[xHeader]
        if not vPosParentHF then
            vPosParentHF=HealBot_Panel_CreateHeader(hbCurFrame)
            HealBot_Header_Frames[xHeader]=vPosParentHF
        end
        vPosFrameHF=_G["f"..hbCurFrame.."_HealBot_Action"]
        if vPosParentHF.frame~=hbCurFrame then
            vPosParentHF:ClearAllPoints()
            vPosParentHF:SetParent(vPosFrameHF)
            vPosParentHF.frame=hbCurFrame
            HealBot_ResetHeaderSkinDone[hbCurFrame][vPosParentHF.id]=nil
        end
        HealBot_Track_Headers[xHeader]=true
        if not HealBot_ResetHeaderSkinDone[hbCurFrame][vPosParentHF.id] then
            HealBot_Skins_ResetSkin("header",vPosParentHF)
            HealBot_ResetHeaderSkinDone[hbCurFrame][vPosParentHF.id]=true
        end
        vPosFrameHW=bWidth*Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][hbCurFrame]["WIDTH"]
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["GROW"]==1 then
            vPosFrameHX=OsetX-floor(HealBot_AddWidth["BOTH"][hbCurFrame]/2)+floor(bcSpace/2)+2
            vPosFrameHY=OsetY+floor(((bHeight+HealBot_AddHeight["BAR2"][hbCurFrame])-vPosFrameHH)/2)
        else
            vPosFrameHX=OsetX+floor((bWidth-vPosFrameHW)/2)
            vPosFrameHY=OsetY-floor(HealBot_AddHeight["BOTH"][hbCurFrame]/2)+brSpace+2
        end
        vPosParentHF:ClearAllPoints();
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["BARS"]==1 then
            vPosParentHF:SetPoint("TOPLEFT",vPosFrameHF,"TOPLEFT",vPosFrameHX,-vPosFrameHY);
        elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["BARS"]==2 then
            vPosParentHF:SetPoint("BOTTOMLEFT",vPosFrameHF,"BOTTOMLEFT",vPosFrameHX,vPosFrameHY);
        elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["BARS"]==3 then
            vPosParentHF:SetPoint("TOPRIGHT",vPosFrameHF,"TOPRIGHT",-vPosFrameHX,-vPosFrameHY);
        else
            vPosParentHF:SetPoint("BOTTOMRIGHT",vPosFrameHF,"BOTTOMRIGHT",-vPosFrameHX,vPosFrameHY);
        end
        vPosFrameHB = _G[vPosParentHF:GetName().."Bar_text"]
        vPosFrameHB:SetText(xHeader);
        vPosParentHF:Show();
        
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["GROW"]==1 then
            OsetY = vPosFrameHY+vPosFrameHH+(HealBot_AddHeight["BOTH"][hbCurFrame]/2)
            OsetX = vPosFrameHX+vPosFrameHW+ceil(HealBot_AddWidth["BOTH"][hbCurFrame]/2)+4
        else
            OsetY = vPosFrameHY+vPosFrameHH+HealBot_AddHeight["BOTTOM"][hbCurFrame]+3
            OsetX = vPosFrameHX+vPosFrameHW+HealBot_AddWidth["SIDE"][hbCurFrame]
        end
    else

        button:ClearAllPoints();
        vPostFrameBF=_G["f"..hbCurFrame.."_HealBot_Action"]
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["BARS"]==1 then
            button:SetPoint("TOPLEFT",vPostFrameBF,"TOPLEFT",OsetX,-OsetY);
        elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["BARS"]==2 then
            button:SetPoint("BOTTOMLEFT",vPostFrameBF,"BOTTOMLEFT",OsetX,OsetY);
        elseif Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["BARS"]==3 then
            button:SetPoint("TOPRIGHT",vPostFrameBF,"TOPRIGHT",-OsetX,-OsetY);
        else
            button:SetPoint("BOTTOMRIGHT",vPostFrameBF,"BOTTOMRIGHT",-OsetX,OsetY);
        end

        OsetY = OsetY+bHeight+HealBot_AddHeight["BOTH"][hbCurFrame]+HealBot_AddHeight["BOTTOM"][hbCurFrame]
        OsetX = OsetX+bWidth+HealBot_AddWidth["BOTH"][hbCurFrame]+HealBot_AddWidth["SIDE"][hbCurFrame]
    end
    return OsetX, OsetY;
end

local addsHeight={}
local HealBot_addsHeightSize={}
local addsHeightSize={}
local vSetAddHWScale=0
function HealBot_Action_SetAddHeightWidth()
    for j=1,10 do
        addsHeight[j]=0
        vSetAddHWScale = Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][j]["SCALE"];
        if Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][j]["SHOW"]==false and 
           Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][j]["CBAR"]==false and
           Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][j]["TBAR"]==false then        
            addsHeight[j]=0
        else
            addsHeight[j]=Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j]["AGGROSIZE"]
        end
        HealBot_addsHeightSize[j]=addsHeight[j]
        if Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][j]["BOUT"]>addsHeight[j] then
            HealBot_addsHeightSize[j]=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][j]["BOUT"]
        end
        addsHeightSize[j]=HealBot_addsHeightSize[j]*2
        HealBot_AddHeight["BOTH"][j]=ceil(addsHeightSize[j]*vSetAddHWScale)
        HealBot_AddHeight["BOTTOM"][j]=Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j]["POWERSIZE"]+Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j]["RMARGIN"]
        HealBot_AddHeight["BOTTOM"][j]=ceil((HealBot_AddHeight["BOTTOM"][j]+HealBot_MultiRowHoToffset)*vSetAddHWScale);
        HealBot_AddHeight["BAR2"][j]=ceil(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j]["POWERSIZE"]*vSetAddHWScale);

        HealBot_AddWidth["BOTH"][j]=ceil((Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][j]["BOUT"]*2)*vSetAddHWScale)
        HealBot_AddWidth["SIDE"][j]=ceil((Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j]["CMARGIN"]+HealBot_MultiColHoToffset)*vSetAddHWScale)
        bwidth[j] = ceil(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j]["WIDTH"]*vSetAddHWScale);
        bheight[j] = ceil(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j]["HEIGHT"]*vSetAddHWScale);
        bcspace[j] = ceil((Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j]["CMARGIN"]+
                           Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][j]["BOUT"])*vSetAddHWScale);
        brspace[j] = ceil(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j]["RMARGIN"]*vSetAddHWScale);
        cols[j]=Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j]["NUMCOLS"] or 1;
    end
end

local HealBot_Panel_initFrame={[1]=true,[2]=true,[3]=true,[4]=true,[5]=true,[6]=true,[7]=true,[8]=true,[9]=true,[10]=true}
function HealBot_Panel_resetInitFrames()
    for j=1,10 do
        HealBot_Panel_initFrame[j]=true
    end
end

local vSetHWFrame=""
local function HealBot_Action_SetHeightWidth(width,height,bWidth,bHeight,hbCurFrame)
    vSetHWFrame = _G["f"..hbCurFrame.."_HealBot_Action"]
    if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurFrame]["GROW"]==1 then
        vSetHWFrame:SetHeight(height+bHeight+HealBot_AddHeight["BOTH"][hbCurFrame]);
        vSetHWFrame:SetWidth(width)
    else
        vSetHWFrame:SetHeight(height);
        vSetHWFrame:SetWidth(width+bWidth+HealBot_OutlineOffset[hbCurFrame]) --+HealBot_AddWidth["BOTH"][hbCurFrame])
    end
    if HealBot_Panel_initFrame[hbCurFrame] then
        HealBot_Panel_initFrame[hbCurFrame]=false
        HealBot_Action_FrameSetPoint(hbCurFrame, vSetHWFrame)
        HealBot_Action_DelayCheckFrameSetPoint(hbCurFrame, true)
    else
        HealBot_Action_setPoint(hbCurFrame)
    end
    --vSetHWFrame:Show()
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

local function HealBot_Panel_TestBarsOff()
    for x,b in pairs(HealBot_TestBarsActive) do
        local xUnit=b.unit
        HealBot_Action_MarkDeleteButton(b)
        HealBot_Action_DeleterCallsUnit(xUnit)
        HealBot_TestBarsActive[x]=nil
    end
end

function HealBot_Panel_ToggleTestBars()
    if HealBot_setTestBars then
        HealBot_setTestBars=false
        HealBot_Panel_TestBarsOff()
        HealBot_Options_TestBarsButton:SetText(HEALBOT_OPTIONS_TESTBARS.." "..HEALBOT_WORD_OFF)
        for j=1,10 do
            HealBot_Action_HidePanel(j)
        end
        HealBot_setTestCols={}
    else
        HealBot_setTestBars=true
        HealBot_Panel_luVars["TestBarsDelAll"]=true
        HealBot_Options_TestBarsButton:SetText(HEALBOT_OPTIONS_TESTBARS.." "..HEALBOT_WORD_ON)
    end
end

function HealBot_Panel_retTestBars()
    return HealBot_setTestBars
end

local vPosButton=""
local function HealBot_Panel_PositionBars(OffsetY, OffsetX, MaxOffsetY, MaxOffsetX, h, z, newHeader)
    table.foreach(HealBot_Action_HealButtons, function (x,xUnit)
        vPosButton=HealBot_Unit_Button[xUnit] or HealBot_Pet_Button[xUnit] or HealBot_Enemy_Button[xUnit] or "nil"
        if vPosButton~="nil" then
            if hbBarsPerFrame[vPosButton.frame] and z[vPosButton.frame] then 
                if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][vPosButton.frame]["GROW"]==1 then
                    if Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][vPosButton.frame]["SHOW"] then 
                        if not newHeader["H"][vPosButton.frame] then
                            if HealBot_BottomAnchors[vPosButton.frame] then 
                                newHeader["H"][vPosButton.frame]=1
                            else
                                newHeader["H"][vPosButton.frame]=0
                            end
                        end
                        h[vPosButton.frame]=h[vPosButton.frame]+1
                        if HeaderPos[vPosButton.frame][h[vPosButton.frame]] then
                            newHeader["H"][vPosButton.frame]=newHeader["H"][vPosButton.frame]+1;
                            if HealBot_BottomAnchors[vPosButton.frame] then 
                                OffsetX[vPosButton.frame], _ = HealBot_Action_PositionButton(nil,OffsetX[vPosButton.frame],OffsetY[vPosButton.frame],bwidth[vPosButton.frame],bheight[vPosButton.frame],HeaderPos[vPosButton.frame][h[vPosButton.frame]],vPosButton.frame,bcspace[vPosButton.frame],brspace[vPosButton.frame])
                            end
                            if newHeader["H"][vPosButton.frame]>cols[vPosButton.frame] then
                                newHeader["H"][vPosButton.frame]=1
                                if MaxOffsetY[vPosButton.frame]<OffsetY[vPosButton.frame] then MaxOffsetY[vPosButton.frame] = OffsetY[vPosButton.frame]; end
                                if MaxOffsetX[vPosButton.frame]<OffsetX[vPosButton.frame] then MaxOffsetX[vPosButton.frame] = OffsetX[vPosButton.frame]; end
                                OffsetY[vPosButton.frame] = OffsetY[vPosButton.frame] + bheight[vPosButton.frame] + HealBot_AddHeight["BOTH"][vPosButton.frame] + HealBot_AddHeight["BOTTOM"][vPosButton.frame]
                                OffsetX[vPosButton.frame] = 6 + ceil(HealBot_AddWidth["BOTH"][vPosButton.frame]/2)
                            end
                            if not HealBot_BottomAnchors[vPosButton.frame] then 
                                OffsetX[vPosButton.frame], _ = HealBot_Action_PositionButton(nil,OffsetX[vPosButton.frame],OffsetY[vPosButton.frame],bwidth[vPosButton.frame],bheight[vPosButton.frame],HeaderPos[vPosButton.frame][h[vPosButton.frame]],vPosButton.frame,bcspace[vPosButton.frame],brspace[vPosButton.frame])
                            end
                            OffsetX[vPosButton.frame], _ = HealBot_Action_PositionButton(vPosButton,OffsetX[vPosButton.frame],OffsetY[vPosButton.frame],bwidth[vPosButton.frame],bheight[vPosButton.frame],nil,vPosButton.frame,bcspace[vPosButton.frame],brspace[vPosButton.frame])
                        else
                            OffsetX[vPosButton.frame], _ = HealBot_Action_PositionButton(vPosButton,OffsetX[vPosButton.frame],OffsetY[vPosButton.frame],bwidth[vPosButton.frame],bheight[vPosButton.frame],nil,vPosButton.frame,bcspace[vPosButton.frame],brspace[vPosButton.frame])
                        end
                    elseif Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][vPosButton.frame]["GRPCOLS"] then
                        h[vPosButton.frame]=h[vPosButton.frame]+1
                        if not newHeader["G"][vPosButton.frame] then
                            if HealBot_BottomAnchors[vPosButton.frame] then 
                                newHeader["G"][vPosButton.frame]=1
                            else
                                newHeader["G"][vPosButton.frame]=0
                            end
                        end
                        if HeaderPos[vPosButton.frame][h[vPosButton.frame]] then
                            newHeader["G"][vPosButton.frame]=newHeader["G"][vPosButton.frame]+1;
                            if newHeader["G"][vPosButton.frame]>cols[vPosButton.frame] then
                                if MaxOffsetY[vPosButton.frame]<OffsetY[vPosButton.frame] then MaxOffsetY[vPosButton.frame] = OffsetY[vPosButton.frame]; end
                                if MaxOffsetX[vPosButton.frame]<OffsetX[vPosButton.frame] then MaxOffsetX[vPosButton.frame] = OffsetX[vPosButton.frame]; end
                                OffsetY[vPosButton.frame] = OffsetY[vPosButton.frame] + bheight[vPosButton.frame] + HealBot_AddHeight["BOTH"][vPosButton.frame] + HealBot_AddHeight["BOTTOM"][vPosButton.frame]
                                OffsetX[vPosButton.frame] = 6 + ceil(HealBot_AddWidth["BOTH"][vPosButton.frame]/2)
                                newHeader["G"][vPosButton.frame]=1;
                            end
                        end
                        OffsetX[vPosButton.frame], _ = HealBot_Action_PositionButton(vPosButton,OffsetX[vPosButton.frame],OffsetY[vPosButton.frame],bwidth[vPosButton.frame],bheight[vPosButton.frame],nil,vPosButton.frame,bcspace[vPosButton.frame],brspace[vPosButton.frame])
                    else
                        if not newHeader["C"][vPosButton.frame] then newHeader["C"][vPosButton.frame]=1 end
                        --if not z[vPosButton.frame] then z[vPosButton.frame]=1 end
                        OffsetX[vPosButton.frame], _ = HealBot_Action_PositionButton(vPosButton,OffsetX[vPosButton.frame],OffsetY[vPosButton.frame],bwidth[vPosButton.frame],bheight[vPosButton.frame],nil,vPosButton.frame,bcspace[vPosButton.frame],brspace[vPosButton.frame])
                        if newHeader["C"][vPosButton.frame]==ceil((hbBarsPerFrame[vPosButton.frame])/cols[vPosButton.frame]) and z[vPosButton.frame]<hbBarsPerFrame[vPosButton.frame] then
                            newHeader["C"][vPosButton.frame]=0;
                            if MaxOffsetY[vPosButton.frame]<OffsetY[vPosButton.frame] then MaxOffsetY[vPosButton.frame] = OffsetY[vPosButton.frame]; end
                            if MaxOffsetX[vPosButton.frame]<OffsetX[vPosButton.frame] then MaxOffsetX[vPosButton.frame] = OffsetX[vPosButton.frame]; end
                            OffsetY[vPosButton.frame] = OffsetY[vPosButton.frame] + bheight[vPosButton.frame] + HealBot_AddHeight["BOTH"][vPosButton.frame] + HealBot_AddHeight["BOTTOM"][vPosButton.frame]
                            OffsetX[vPosButton.frame] = 6 + ceil(HealBot_AddWidth["BOTH"][vPosButton.frame]/2)
                        end
                        z[vPosButton.frame]=z[vPosButton.frame]+1
                        newHeader["C"][vPosButton.frame]=newHeader["C"][vPosButton.frame]+1;
                    end
                else
                    if Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][vPosButton.frame]["SHOW"] then 
                        if not newHeader["H"][vPosButton.frame] then
                            if HealBot_BottomAnchors[vPosButton.frame] then 
                                newHeader["H"][vPosButton.frame]=1
                            else
                                newHeader["H"][vPosButton.frame]=0
                            end
                        end
                        h[vPosButton.frame]=h[vPosButton.frame]+1
                        if HeaderPos[vPosButton.frame][h[vPosButton.frame]] then
                            newHeader["H"][vPosButton.frame]=newHeader["H"][vPosButton.frame]+1;
                            if HealBot_BottomAnchors[vPosButton.frame] then 
                                _, OffsetY[vPosButton.frame] = HealBot_Action_PositionButton(nil,OffsetX[vPosButton.frame],OffsetY[vPosButton.frame],bwidth[vPosButton.frame],bheight[vPosButton.frame],HeaderPos[vPosButton.frame][h[vPosButton.frame]],vPosButton.frame,bcspace[vPosButton.frame],brspace[vPosButton.frame])
                            end
                            if newHeader["H"][vPosButton.frame]>cols[vPosButton.frame] then
                                newHeader["H"][vPosButton.frame]=1
                                if MaxOffsetY[vPosButton.frame]<OffsetY[vPosButton.frame] then MaxOffsetY[vPosButton.frame] = OffsetY[vPosButton.frame]; end
                                if MaxOffsetX[vPosButton.frame]<OffsetX[vPosButton.frame] then MaxOffsetX[vPosButton.frame] = OffsetX[vPosButton.frame]; end
                                OffsetY[vPosButton.frame] = 4 + ceil(HealBot_AddHeight["BOTH"][vPosButton.frame]/2)
                                OffsetX[vPosButton.frame] = OffsetX[vPosButton.frame] + bwidth[vPosButton.frame] + HealBot_AddWidth["BOTH"][vPosButton.frame] + HealBot_AddWidth["SIDE"][vPosButton.frame]
                            end
                            if not HealBot_BottomAnchors[vPosButton.frame] then 
                                _, OffsetY[vPosButton.frame] = HealBot_Action_PositionButton(nil,OffsetX[vPosButton.frame],OffsetY[vPosButton.frame],bwidth[vPosButton.frame],bheight[vPosButton.frame],HeaderPos[vPosButton.frame][h[vPosButton.frame]],vPosButton.frame,bcspace[vPosButton.frame],brspace[vPosButton.frame])
                            end
                            _, OffsetY[vPosButton.frame] = HealBot_Action_PositionButton(vPosButton,OffsetX[vPosButton.frame],OffsetY[vPosButton.frame],bwidth[vPosButton.frame],bheight[vPosButton.frame],nil,vPosButton.frame,bcspace[vPosButton.frame],brspace[vPosButton.frame])
                        else
                            _, OffsetY[vPosButton.frame] = HealBot_Action_PositionButton(vPosButton,OffsetX[vPosButton.frame],OffsetY[vPosButton.frame],bwidth[vPosButton.frame],bheight[vPosButton.frame],nil,vPosButton.frame,bcspace[vPosButton.frame],brspace[vPosButton.frame])
                        end
                    elseif Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][vPosButton.frame]["GRPCOLS"] then
                        h[vPosButton.frame]=h[vPosButton.frame]+1
                        if not newHeader["G"][vPosButton.frame] then
                            if HealBot_BottomAnchors[vPosButton.frame] then 
                                newHeader["G"][vPosButton.frame]=1
                            else
                                newHeader["G"][vPosButton.frame]=0
                            end
                        end
                        if HeaderPos[vPosButton.frame][h[vPosButton.frame]] then
                            newHeader["G"][vPosButton.frame]=newHeader["G"][vPosButton.frame]+1;
                            if newHeader["G"][vPosButton.frame]>cols[vPosButton.frame] then
                                if MaxOffsetY[vPosButton.frame]<OffsetY[vPosButton.frame] then MaxOffsetY[vPosButton.frame] = OffsetY[vPosButton.frame]; end
                                if MaxOffsetX[vPosButton.frame]<OffsetX[vPosButton.frame] then MaxOffsetX[vPosButton.frame] = OffsetX[vPosButton.frame]; end
                                OffsetY[vPosButton.frame] = 4 + ceil(HealBot_AddHeight["BOTH"][vPosButton.frame]/2)
                                OffsetX[vPosButton.frame] = OffsetX[vPosButton.frame] + bwidth[vPosButton.frame] + HealBot_AddWidth["BOTH"][vPosButton.frame] + HealBot_AddWidth["SIDE"][vPosButton.frame]
                                newHeader["G"][vPosButton.frame]=1;
                            end
                        end
                        _, OffsetY[vPosButton.frame] = HealBot_Action_PositionButton(vPosButton,OffsetX[vPosButton.frame],OffsetY[vPosButton.frame],bwidth[vPosButton.frame],bheight[vPosButton.frame],nil,vPosButton.frame,bcspace[vPosButton.frame],brspace[vPosButton.frame])
                    else
                        if not newHeader["C"][vPosButton.frame] then newHeader["C"][vPosButton.frame]=1 end
                        _, OffsetY[vPosButton.frame] = HealBot_Action_PositionButton(vPosButton,OffsetX[vPosButton.frame],OffsetY[vPosButton.frame],bwidth[vPosButton.frame],bheight[vPosButton.frame],nil,vPosButton.frame,bcspace[vPosButton.frame],brspace[vPosButton.frame])
                        if newHeader["C"][vPosButton.frame]==ceil((hbBarsPerFrame[vPosButton.frame])/cols[vPosButton.frame]) and z[vPosButton.frame]<hbBarsPerFrame[vPosButton.frame] then
                            newHeader["C"][vPosButton.frame]=0;
                            if MaxOffsetY[vPosButton.frame]<OffsetY[vPosButton.frame] then MaxOffsetY[vPosButton.frame] = OffsetY[vPosButton.frame]; end
                            if MaxOffsetX[vPosButton.frame]<OffsetX[vPosButton.frame] then MaxOffsetX[vPosButton.frame] = OffsetX[vPosButton.frame]; end
                            OffsetY[vPosButton.frame] = 4 + ceil(HealBot_AddHeight["BOTH"][vPosButton.frame]/2)
                            OffsetX[vPosButton.frame] = OffsetX[vPosButton.frame] + bwidth[vPosButton.frame] + HealBot_AddWidth["BOTH"][vPosButton.frame] + HealBot_AddWidth["SIDE"][vPosButton.frame]
                        end
                        z[vPosButton.frame]=z[vPosButton.frame]+1
                        newHeader["C"][vPosButton.frame]=newHeader["C"][vPosButton.frame]+1;
                    end
                end
            end
        end
    end)
end

local cols={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,[6]=0,[7]=0,[8]=0,[9]=0,[10]=0}
local rows={[1]=1,[2]=1,[3]=1,[4]=1,[5]=1,[6]=1,[7]=1,[8]=1,[9]=1,[10]=1}
local newHeader={["H"]={},["G"]={},["C"]={}}
local function HealBot_Panel_SetupExtraBars(frame)
    OffsetY[frame] = 4 + ceil(HealBot_AddHeight["BOTH"][frame]/2)
    OffsetX[frame] = 6 + ceil(HealBot_AddWidth["BOTH"][frame]/2)
    MaxOffsetY[frame]=0
    MaxOffsetX[frame]=0
    cols[frame]=0
    rows[frame]=1
    newHeader["H"]={}
    newHeader["G"]={}
    newHeader["C"]={}
    
    HealBot_Panel_PositionBars(OffsetY, OffsetX, MaxOffsetY, MaxOffsetX, cols, rows, newHeader)

    for xHeader,xButton in pairs(HealBot_Header_Frames) do
        if xButton.frame==frame and not HealBot_Track_Headers[xHeader] then
            HealBot_Panel_DeleteHeader(xButton.id, xHeader)
        end
    end
    
    if hbBarsPerFrame[frame]>0 then
        if MaxOffsetY[frame]<OffsetY[frame] then MaxOffsetY[frame] = OffsetY[frame]; end
        if MaxOffsetX[frame]<OffsetX[frame] then MaxOffsetX[frame] = OffsetX[frame]; end
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][frame]["GROW"]==1 then
            MaxOffsetY[frame]=MaxOffsetY[frame]-ceil(HealBot_AddHeight["BOTH"][frame]/2)+HealBot_AddHeight["BAR2"][frame]+4
            MaxOffsetX[frame]=MaxOffsetX[frame]-ceil((HealBot_AddWidth["BOTH"][frame]/2)+HealBot_AddWidth["SIDE"][frame])+6
        else
            MaxOffsetY[frame]=MaxOffsetY[frame]+5-(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][frame]["RMARGIN"]+ceil(HealBot_AddHeight["BOTH"][frame]/2))
            MaxOffsetX[frame]=MaxOffsetX[frame]+6
        end
        if HealBot_Config.DisabledNow==0 then
            HealBot_Action_SetHeightWidth(MaxOffsetX[frame], MaxOffsetY[frame], bwidth[frame], bheight[frame], frame);
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

local vSetupBarsFrame,vSetupBarsOptionsParent,vSetupBarsOptionsFrame=0,"",""
local function HealBot_Panel_SetupBars()
    for j=1,5 do
        OffsetY[j] = 4 + ceil(HealBot_AddHeight["BOTH"][j]/2)
        OffsetX[j] = 6 + ceil(HealBot_AddWidth["BOTH"][j]/2)
        MaxOffsetY[j]=0
        MaxOffsetX[j]=0
        cols[j]=0
        rows[j]=1
    end
    newHeader["H"]={}
    newHeader["G"]={}
    newHeader["C"]={}

    HealBot_Panel_PositionBars(OffsetY, OffsetX, MaxOffsetY, MaxOffsetX, cols, rows, newHeader)
    
    for xHeader,xButton in pairs(HealBot_Header_Frames) do
        if xButton.frame<6 and not HealBot_Track_Headers[xHeader] then
            HealBot_Panel_DeleteHeader(xButton.id, xHeader)
        end
    end

    vSetupBarsFrame=0
    for j=1,5 do
        if hbBarsPerFrame[j]>0 then
            if vSetupBarsFrame==0 then vSetupBarsFrame=j end
            if MaxOffsetY[j]<OffsetY[j] then MaxOffsetY[j] = OffsetY[j]; end
            if MaxOffsetX[j]<OffsetX[j] then MaxOffsetX[j] = OffsetX[j]; end
            if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][j]["GROW"]==1 then
                MaxOffsetY[j]=MaxOffsetY[j]-ceil(HealBot_AddHeight["BOTH"][j]/2)+HealBot_AddHeight["BAR2"][j]+4
                MaxOffsetX[j]=MaxOffsetX[j]-ceil((HealBot_AddWidth["BOTH"][j]/2)+HealBot_AddWidth["SIDE"][j])+6
            else
                MaxOffsetY[j]=MaxOffsetY[j]+5-(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j]["RMARGIN"]+ceil(HealBot_AddHeight["BOTH"][j]/2))
                MaxOffsetX[j]=MaxOffsetX[j]+6
            end
        end
    end
    if HealBot_Globals.HideOptions and vSetupBarsFrame>0 then
        if hbOptionOn then
            hbOptionOn:Hide()
            hbOptionOn=nil
        end
    else
        if vSetupBarsFrame==0 then vSetupBarsFrame=1 end
        vSetupBarsOptionsParent=_G["f"..vSetupBarsFrame.."_HealBot_Action"]
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
        elseif vSetupBarsOptionsFrame.frame~=vSetupBarsFrame then
            vSetupBarsOptionsFrame:Hide()
            vSetupBarsOptionsFrame:ClearAllPoints()
            vSetupBarsOptionsFrame:SetParent(vSetupBarsOptionsParent)
            vSetupBarsOptionsFrame.frame=vSetupBarsFrame
        end
        if hbOptionOn and hbOptionOn~=vSetupBarsOptionsFrame then hbOptionOn:Hide() end
        hbOptionOn=vSetupBarsOptionsFrame
        if hbOptionOn then
            hbOptionOn:ClearAllPoints()
            if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][vSetupBarsFrame]["BARS"]==2 or Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][vSetupBarsFrame]["BARS"]==4 then
                hbOptionOn:SetPoint("TOP",vSetupBarsOptionsParent,"TOP",0,-10);
            else
                hbOptionOn:SetPoint("BOTTOM",vSetupBarsOptionsParent,"BOTTOM",0,10);
            end
            hbOptionOn:Show();
            MaxOffsetY[vSetupBarsFrame] = MaxOffsetY[vSetupBarsFrame]+30;
        end
    end
    
    for j=1,5 do
        if hbBarsPerFrame[j]>0 then
            if HealBot_Config.DisabledNow==0 then
                HealBot_Action_SetHeightWidth(MaxOffsetX[j], MaxOffsetY[j], bwidth[j], bheight[j], j);
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
          
local function HealBot_Panel_RandomClassColour(tRole)
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
    return HealBot_randomClCol[HealBot_randomN][1],HealBot_randomClCol[HealBot_randomN][2],HealBot_randomClCol[HealBot_randomN][3]
end

local function HealBot_Panel_TestBarShow(index,button,tRole)
    table.insert(HealBot_Action_HealButtons,button.unit)
    HealBot_TrackUnit[button.unit]=true
    HealBot_TestBarsActive[index]=button
    local bar=_G["HealBot_Action_HealUnit"..button.id.."Bar"]
    local HealBot_keepClass=false
    if not HealBot_setTestCols[index] then
        if (Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HLTH"] >= 2) then
            if (Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HLTH"] == 2) then
                HealBot_colIndex["hcr"..index],HealBot_colIndex["hcg"..index],HealBot_colIndex["hcb"..index] = HealBot_Panel_RandomClassColour(tRole)
                if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["CLASSCOL"] then
                    HealBot_keepClass=true
                end
            else
                HealBot_colIndex["hcr"..index]=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HR"]
                HealBot_colIndex["hcg"..index]=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HG"]
                HealBot_colIndex["hcb"..index]=Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HB"]
            end
        else
            HealBot_colIndex["hcr"..index],HealBot_colIndex["hcg"..index],HealBot_colIndex["hcb"..index] = 0,1,0
        end
        if HealBot_keepClass then
            HealBot_colIndex["hctr"..index],HealBot_colIndex["hctg"..index],HealBot_colIndex["hctb"..index] = HealBot_colIndex["hcr"..index],HealBot_colIndex["hcg"..index],HealBot_colIndex["hcb"..index]
        else
            if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["CLASSCOL"] then
                HealBot_colIndex["hctr"..index],HealBot_colIndex["hctg"..index],HealBot_colIndex["hctb"..index] = HealBot_Panel_RandomClassColour(tRole)
            else
                HealBot_colIndex["hctr"..index] = Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["ER"]
                HealBot_colIndex["hctg"..index] = Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["EG"]
                HealBot_colIndex["hctb"..index] = Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["EB"]
            end
        end
        bar:SetValue(100)
        bar:SetStatusBarColor(HealBot_colIndex["hcr"..index],HealBot_colIndex["hcg"..index],HealBot_colIndex["hcb"..index],Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][button.frame]["HA"]);
        HealBot_setTestCols[index]=true
    end
    bar.txt = _G[bar:GetName().."_text"];
    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHONBAR"] then
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["DOUBLE"]==false then
            if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTYPE"]==1 then
                bar.txt:SetText(button.unit.." 100K");
            elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTYPE"]==2 then
                bar.txt:SetText(button.unit.." (0)");
            else
                bar.txt:SetText(button.unit.." (100%)");
            end
        else
            if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTYPE"]==1 then
                bar.txt:SetText(button.unit.."\n100K");
            elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HLTHTYPE"]==2 then
                bar.txt:SetText(button.unit.."\n(0)");
            else
                bar.txt:SetText(button.unit.."\n(100%)");
            end
        end
    else
        bar.txt:SetText(button.unit)
    end
    bar.txt:SetTextColor(HealBot_colIndex["hctr"..index],HealBot_colIndex["hctg"..index],HealBot_colIndex["hctb"..index],Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][button.frame]["EA"]);
    button:Show()
end

local function HealBot_Panel_testAddButton(gName,bName,minBar,maxBar,tRole)
    local k=i[hbCurrentFrame]
    for j=minBar,maxBar do
        if noBars>0 then
            local tstb=HealBot_Action_SetTestButton(hbCurrentFrame, HEALBOT_WORD_TEST.." "..bName.." "..j)
            if tstb then 
                local bIndex=tstb.id
                HealBot_Panel_TestBarShow(bIndex,tstb,tRole)
                noBars=noBars-1
                i[hbCurrentFrame]=i[hbCurrentFrame]+1
                hbBarsPerFrame[tstb.frame]=hbBarsPerFrame[tstb.frame]+1
            end
        end
    end
    if i[hbCurrentFrame]>k and not tHeader[gName] then
        if HealBot_BottomAnchors[hbCurrentFrame] then 
            HeaderPos[hbCurrentFrame][i[hbCurrentFrame]+1] = gName 
        else
            HeaderPos[hbCurrentFrame][k+1] = gName
        end
        tHeader[gName]=true
        if bName==HEALBOT_OPTIONS_EMERGENCYHEALS or bName==HEALBOT_OPTIONS_GROUPHEALS then
            grpNo=grpNo+1
        end
    end
end

local function HealBot_Panel_TestBarsOn()
    if HealBot_Panel_luVars["TestBarsDelAll"] then
        HealBot_Panel_luVars["TestBarsDelAll"]=false
        for _,xButton in pairs(HealBot_Unit_Button) do
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
    for j=1,10 do
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][j]["BARS"]==2 or Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][j]["BARS"]==4 then
            HealBot_BottomAnchors[j]=true
        else
            HealBot_BottomAnchors[j]=false
        end
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
                HealBot_Panel_testAddButton(HEALBOT_OPTIONS_SELFHEALS,HEALBOT_OPTIONS_SELFHEALS,1,1,HEALBOT_WORD_HEALER)
                gNo=4
                xRaidBars=xRaidBars-1
            end
        elseif healGroups[gl]["NAME"]==HEALBOT_OPTIONS_TANKHEALS_en then
            local nTanks=HealBot_Globals.TestBars["TANKS"]
            if HealBot_Globals.TestBars["PROFILE"]==1 then nTanks=1 end
            if nTanks>0 and healGroups[gl]["STATE"] then
                HealBot_Panel_testAddButton(HEALBOT_OPTIONS_TANKHEALS,HEALBOT_WORD_TANK,1,nTanks,HEALBOT_WORD_TANK)
                xRaidBars=xRaidBars-nTanks
            end
        elseif healGroups[gl]["NAME"]==HEALBOT_CLASSES_HEALERS_en then
            local nHealers=HealBot_Globals.TestBars["HEALERS"]
            if HealBot_Globals.TestBars["PROFILE"]==1 then nHealers=1 end
            if nHealers>0 and healGroups[gl]["STATE"] then
                HealBot_Panel_testAddButton(HEALBOT_CLASSES_HEALERS,HEALBOT_WORD_HEALER,1,nHealers,HEALBOT_WORD_HEALER)
                xRaidBars=xRaidBars-nHealers
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
                xRaidBars=xRaidBars-HealBot_Globals.TestBars["TARGETS"]
            end
        elseif healGroups[gl]["NAME"]==HEALBOT_OPTIONS_PETHEALS_en and hbCurrentFrame<6 then
            if HealBot_Globals.TestBars["PETS"]>0 and healGroups[gl]["STATE"] then
                HealBot_Panel_testAddButton(HEALBOT_OPTIONS_PETHEALS,HEALBOT_OPTIONS_PETHEALS,1,HealBot_Globals.TestBars["PETS"],HEALBOT_OPTIONS_PETHEALS)
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
        HealBot_Panel_testAddButton(HEALBOT_OPTIONS_PETHEALS,HEALBOT_OPTIONS_PETHEALS,1,HealBot_Globals.TestBars["PETS"],HEALBOT_OPTIONS_PETHEALS)
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

local function HealBot_cpsUnit(unit,sUnit)
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

local function HealBot_Panel_cpSort(unitName, unit, hbGUID, hbCurFrame)
    if unitName and unit and hbGUID then
        unit=HealBot_cpsUnit(nil,unit)
        if not HealBot_TrackUnit[unit] then
            hbGUID="0x"..hbGUID
            local frameNo=tonumber(hbCurFrame) or 1
            local setButton=HealBot_Action_SetHealButton(unit,hbGUID,frameNo,1);
            if setButton then
                table.insert(HealBot_Action_HealButtons,unit)
                HealBot_cpName[unit]=unitName
                HealBot_TrackUnit[unit]=true
                hbBarsPerFrame[frameNo]=hbBarsPerFrame[frameNo]+1
            end
        end
    end
end

local function HealBot_Panel_enemyBar(eUnit)
    i[hbCurrentFrame]=i[hbCurrentFrame]+1;
    table.insert(units,eUnit)
end

local function HealBot_Panel_checkEnemyBar(eUnit, pUnit, existsShow)
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

local vSubSortUnit,vSubSortGUID="",""
local function HealBot_Panel_SubSort(doSubSort,unitType)
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
        if not HealBot_TrackUnit[vSubSortUnit] and not HealBot_Panel_BlackList[vSubSortGUID] then
            if HealBot_Action_SetHealButton(vSubSortUnit,vSubSortGUID,hbCurrentFrame,unitType) then
                HealBot_TrackUnit[vSubSortUnit]=true
                table.insert(HealBot_Action_HealButtons,vSubSortUnit)
                hbBarsPerFrame[hbCurrentFrame]=hbBarsPerFrame[hbCurrentFrame]+1
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

local vSubOrderKey,vSubOrderName,vSubOrderGroup,vSubOrderRole=99,"",0,""
local function HealBot_Panel_sortOrder(unit, barOrder, mainSort)
    vSubOrderKey=99
    if barOrder==1 then
        if unit == "player" and Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["SUBPF"] then
            vSubOrderKey = "!";
        elseif UnitExists(unit) then
            vSubOrderName=UnitName(unit) or unit
            if Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["OORLAST"] and not UnitInRange(unit) then
                vSubOrderKey = "ÿÿÿþ"..vSubOrderName
            else
                vSubOrderKey = vSubOrderName
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
            if Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["OORLAST"] and not UnitInRange(unit) then
                vSubOrderKey = "ÿÿÿþ"..HealBot_Panel_classEN(unit)
            else
                vSubOrderKey = HealBot_Panel_classEN(unit)
            end
        else
            vSubOrderKey = "ÿÿÿÿ"..unit
        end
    elseif barOrder==3 then
        vSubOrderGroup=HealBot_UnitGroups[unit] or 1
        if unit == "player" then 
            if not mainSort and Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["SUBPF"] then
                vSubOrderKey = -1
            else
                vSubOrderKey = vSubOrderGroup
            end 
        elseif UnitExists(unit) then
            if Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["OORLAST"] and not UnitInRange(unit) then
                vSubOrderKey = 9+vSubOrderGroup
            else
                vSubOrderKey = vSubOrderGroup
            end
        else
            vSubOrderKey = 19+vSubOrderGroup
        end
    elseif barOrder==4 then
        if unit == "player" and Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["SUBPF"] then
            vSubOrderKey = -99999999
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
        vSubOrderRole=HealBot_unitRole[unit] or 9
        if unit == "player" then 
            if not mainSort and Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["SUBPF"] then
                vSubOrderKey = -1
            else 
                vSubOrderKey = vSubOrderRole
            end
        elseif UnitExists(unit) then
            if Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["OORLAST"] and not UnitInRange(unit) then
                vSubOrderKey = 59+vSubOrderRole
            else
                vSubOrderKey = vSubOrderRole
            end
        else
            vSubOrderKey = 99+vSubOrderRole
        end
    end
    return vSubOrderKey
end

local function HealBot_Panel_insSort(unit, mainSort)
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

local vAddUnitSubGroup=0
local function HealBot_Panel_addUnit(unit, hbGUID, isRaidGroup)
    vAddUnitSubGroup=HealBot_UnitGroups[unit] or 0;
    if (vAddUnitSubGroup==0 or Healbot_Config_Skins.IncludeGroup[Healbot_Config_Skins.Current_Skin][hbCurrentFrame][vAddUnitSubGroup]) and 
       (Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["INCCLASSES"]==1 or HealBot_Options_retEmergInc(HealBot_Panel_classEN(unit), hbCurrentFrame)) then
        if not HealBot_TrackNames[hbGUID] then
            if not UnitIsVisible(xUnit) or not Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["HIDEOOR"] then
                if not isRaidGroup then i[hbCurrentFrame] = i[hbCurrentFrame]+1; end
                HealBot_TrackNames[hbGUID]=true;
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
local function HealBot_Panel_MainSort(doMainSort,unitType)
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

local function HealBot_Panel_addUnits(doMainSort,unitType,hText,k)
    HealBot_Panel_MainSort(doMainSort,unitType)
    if HealBot_BottomAnchors[hbCurrentFrame] then 
        HeaderPos[hbCurrentFrame][i[hbCurrentFrame]+1] = hText
    else
        HeaderPos[hbCurrentFrame][k+1] = hText 
    end
    --HealBot_setCall("HealBot_Panel_addUnits")
end

local vEnemyIndex,vEnemyLocation,vEnemyBossNum,vEnemyBossExist=0,"",0,false
local function HealBot_Panel_enemyTargets()
    if not HealBot_BottomAnchors[hbCurrentFrame] then HeaderPos[hbCurrentFrame][i[hbCurrentFrame]+1] = HEALBOT_OPTIONS_TARGETHEALS end
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

    if i[hbCurrentFrame]>vEnemyIndex then 
        HealBot_Panel_addUnits(false,9,HEALBOT_CUSTOM_CASTBY_ENEMY,vEnemyIndex)
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

local vTargetIndex,vTargetUnit=0,"target"
local function HealBot_Panel_targetHeals(preCombat)
    vTargetUnit="target";
    vTargetIndex=i[hbCurrentFrame]
    if UnitExists(vTargetUnit) and (not preCombat or Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TARGETINCOMBAT"]>1) then
        if not UnitIsVisible(vTargetUnit) or not Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["HIDEOOR"] then
            if HealBot_Panel_validTarget() then
                i[hbCurrentFrame] = i[hbCurrentFrame]+1;
                table.insert(subunits,vTargetUnit)
            end
        end
    elseif preCombat and Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TARGETINCOMBAT"]==3 then
        i[hbCurrentFrame] = i[hbCurrentFrame]+1;
        table.insert(subunits,vTargetUnit)
    end
    if i[hbCurrentFrame]>vTargetIndex then 
        HealBot_Panel_SubSort(false,4)
        if HealBot_BottomAnchors[hbCurrentFrame] then
            HeaderPos[hbCurrentFrame][i[hbCurrentFrame]+1] = HEALBOT_OPTIONS_TARGETHEALS
        else
            HeaderPos[hbCurrentFrame][vTargetIndex+1] = HEALBOT_OPTIONS_TARGETHEALS 
        end
    end
end

local vVehiclePlayerUnit,vVehicleUnit,vVehicleIndex="","",0
local function HealBot_Panel_vehicleHeals()
    if HEALBOT_GAME_VERSION>3 then
        vVehicleIndex=i[hbCurrentFrame]
        vVehicleUnit="pet"
        vVehiclePlayerUnit="player"
        if hbPanel_dataPetUnits[vVehicleUnit] and UnitUsingVehicle(vVehiclePlayerUnit) and UnitName(vVehicleUnit) then
            HealBot_Panel_addUnit(vVehicleUnit, hbPanel_dataPetUnits[vVehicleUnit], false)
        end
        if nraid>0 then
            for j=1,nraid do
                vVehicleUnit="raidpet"..j;
                vVehiclePlayerUnit="raid"..j;
                if hbPanel_dataPetUnits[vVehicleUnit] and UnitExists(vVehiclePlayerUnit) and UnitUsingVehicle(vVehiclePlayerUnit) and UnitName(vVehicleUnit) then
                    HealBot_Panel_addUnit(vVehicleUnit, hbPanel_dataPetUnits[vVehicleUnit], false)
                end
            end
        else
            for j=1,4 do
                vVehicleUnit="partypet"..j;
                vVehiclePlayerUnit="party"..j;
                if hbPanel_dataPetUnits[vVehicleUnit] and UnitExists(vVehiclePlayerUnit) and UnitUsingVehicle(vVehiclePlayerUnit) and UnitName(vVehicleUnit) then
                    HealBot_Panel_addUnit(vVehicleUnit, hbPanel_dataPetUnits[vVehicleUnit], false)
                end
            end
        end
        if i[hbCurrentFrame]>vVehicleIndex then 
            HealBot_Panel_addUnits(true, 2,HEALBOT_VEHICLE,vVehicleIndex)
        end
    elseif Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["STATE"] then
        Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["STATE"]=false
    end
end

local vPanelPetRole,vPanelPetRoleReturn="",""
local function HealBot_Panel_petRole(unit)
    vPanelPetRoleReturn="x"
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["FRAME"]>5 then
        vPanelPetRole=hbPanel_dataRoles[unit] or "x"
        if vPanelPetRole=="TANK" and HealBot_Panel_luVars["TanksOn"] then vPanelPetRoleReturn="TANK" end
        if vPanelPetRole=="HEALER" and HealBot_Panel_luVars["HealsOn"] then vPanelPetRoleReturn="HEALER" end
    end
    return vPanelPetRoleReturn
end

local vPetPlayerUnit,vPetUnit,vPetIndex,vPetPlayerInVehicle,vPetRole="","",0,false,""
local function HealBot_Panel_petHeals()
    if not HealBot_BottomAnchors[hbCurrentFrame] then HeaderPos[hbCurrentFrame][i[hbCurrentFrame]+1] = HEALBOT_OPTIONS_PETHEALS end
    vPetIndex=i[hbCurrentFrame]
    vPetUnit="pet"
    vPetPlayerUnit="player"
    vPetPlayerInVehicle=false
    vPetRole=HealBot_Panel_petRole(vPetUnit)
    if vPetRole~="TANK" and vPetRole~="HEALER" then
        if HEALBOT_GAME_VERSION>3 then vPetPlayerInVehicle=UnitUsingVehicle(vPetPlayerUnit) end
        if hbPanel_dataPetUnits[vPetUnit] and not vPetPlayerInVehicle and not HealBot_Panel_luVars["SelfPets"] then
            HealBot_Panel_addUnit(vPetUnit, hbPanel_dataPetUnits[vPetUnit], false)
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
                        HealBot_Panel_addUnit(vPetUnit, hbPanel_dataPetUnits[vPetUnit], false)
                    end
                    if Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["GROUPPETS"] then
                        if not HealBot_BottomAnchors[hbCurrentFrame] and i[hbCurrentFrame]-vPetIndex == 6 then HeaderPos[hbCurrentFrame][i[hbCurrentFrame]-5] = HEALBOT_OPTIONS_PETHEALS.." 1" end
                        if i[hbCurrentFrame]>vPetIndex and ((i[hbCurrentFrame]-vPetIndex)%5 == 0) then                           
                            HealBot_Panel_MainSort(true,3)        
                            HeaderPos[hbCurrentFrame][i[hbCurrentFrame]+1] = HEALBOT_OPTIONS_PETHEALS.." "..((i[hbCurrentFrame]-vPetIndex)/5)+(HealBot_BottomAnchors[hbCurrentFrame] and 0 or 1)
                        end
                    end
                end
            end
        end
        if Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["GROUPPETS"] and HealBot_BottomAnchors[hbCurrentFrame] and i[hbCurrentFrame]-vPetIndex == 5 then 
            HeaderPos[hbCurrentFrame][i[hbCurrentFrame]+1] = HEALBOT_OPTIONS_PETHEALS 
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
                        HealBot_Panel_addUnit(vPetUnit, hbPanel_dataPetUnits[vPetUnit], false)
                    end
                end
            end
        end
    end
    if i[hbCurrentFrame]>vPetIndex then
        HealBot_Panel_MainSort(true,3)        
        --if HealBot_BottomAnchors[hbCurrentFrame] then HeaderPos[hbCurrentFrame][i[hbCurrentFrame]+1] = HEALBOT_OPTIONS_PETHEALS end
        if HealBot_BottomAnchors[hbCurrentFrame] then
            if not Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["GROUPPETS"] then
                HeaderPos[hbCurrentFrame][i[hbCurrentFrame]+1] = HEALBOT_OPTIONS_PETHEALS
            elseif nraid==0 or (i[hbCurrentFrame]-vPetIndex)%5>0 then 
                HeaderPos[hbCurrentFrame][i[hbCurrentFrame]+1] = HEALBOT_OPTIONS_PETHEALS..(i[hbCurrentFrame]-vPetIndex>5 and " "..ceil((i[hbCurrentFrame]-vPetIndex)/5) or "")
            end
        end
    end
end

local vRaidTargetNum,vRaidUnit,vRaidIndex=0,"",0
local vRaidPrevSort,vRaidHeadSort,vRaidSubSort,vRaidShowHeader="","","init",false
local function HealBot_Panel_raidHeals()
    vRaidIndex=i[hbCurrentFrame]
    if Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["RAIDORDER"]==1 or Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["RAIDORDER"]==5 then
        if not HealBot_BottomAnchors[hbCurrentFrame] then HeaderPos[hbCurrentFrame][i[hbCurrentFrame]+1] = HEALBOT_OPTIONS_EMERGENCYHEALS end
    end
    
    vRaidTargetNum = nraid
    if Healbot_Config_Skins.Protection[Healbot_Config_Skins.Current_Skin]["COMBAT"] and nraid>0 and 
       Healbot_Config_Skins.Protection[Healbot_Config_Skins.Current_Skin]["COMBATRAID"] then 
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
                if MyGroup["GROUP"]>0 then
                    local _, _, subgroup = GetRaidRosterInfo(j);
                    HeaderPos[MyGroup["FRAME"]][MyGroup["GROUP"]] = HEALBOT_OPTIONS_GROUPHEALS.." "..subgroup;
                end
            end
            if hbPanel_dataUnits[vRaidUnit] then
                HealBot_Panel_addUnit(vRaidUnit, hbPanel_dataUnits[vRaidUnit], true)
            elseif Healbot_Config_Skins.Protection[Healbot_Config_Skins.Current_Skin]["COMBAT"] and 
                   Healbot_Config_Skins.Protection[Healbot_Config_Skins.Current_Skin]["COMBATRAID"] then 
                HealBot_Panel_addUnit(vRaidUnit, vRaidUnit, true)
            end
        end
    else
        for _,xUnit in ipairs(HealBot_Action_HealGroup) do
            if hbPanel_dataUnits[xUnit] then
                HealBot_Panel_addUnit(xUnit, hbPanel_dataUnits[xUnit], true)
            elseif Healbot_Config_Skins.Protection[Healbot_Config_Skins.Current_Skin]["COMBAT"] and IsInGroup() and 
                   Healbot_Config_Skins.Protection[Healbot_Config_Skins.Current_Skin]["COMBATPARTY"] then 
                HealBot_Panel_addUnit(xUnit, xUnit, true)
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
                    if HealBot_BottomAnchors[hbCurrentFrame] then 
                        if vRaidSubSort~="init" then
                            HeaderPos[hbCurrentFrame][i[hbCurrentFrame]] = vRaidPrevSort
                        end
                    else
                        HeaderPos[hbCurrentFrame][i[hbCurrentFrame]] = vRaidHeadSort
                    end
                end
                HealBot_Panel_SubSort(true, 1)
                vRaidSubSort=order[vRaidUnit]
                vRaidPrevSort=vRaidHeadSort
            end
        end
        HealBot_Panel_insSort(vRaidUnit, false)
    end
    if #units>0 then
        if vRaidShowHeader and HealBot_BottomAnchors[hbCurrentFrame] then
            HeaderPos[hbCurrentFrame][i[hbCurrentFrame]+1] = vRaidPrevSort           
        end
        HealBot_Panel_SubSort(true, 1)
    end
            
    for x,_ in pairs(order) do
        order[x]=nil;
    end
    for x,_ in pairs(units) do
        units[x]=nil;
    end
    
    if i[hbCurrentFrame]==vRaidIndex+1 and not HealBot_BottomAnchors[hbCurrentFrame] then
        HeaderPos[hbCurrentFrame][i[hbCurrentFrame]+1] = nil 
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

local vFocusIndex,vFocusUnit=0,"focus"
local function HealBot_Panel_focusHeals(preCombat)
    vFocusIndex=i[hbCurrentFrame]
    local uExists=false
    if HealBot_Panel_validFocus() and (not preCombat or Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["FOCUSINCOMBAT"]>1) then
        if not UnitIsVisible(vFocusUnit) or not Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["HIDEOOR"] then
            i[hbCurrentFrame] = i[hbCurrentFrame]+1;
            table.insert(subunits,vFocusUnit)
        else
            HealBot_setNotVisible(vFocusUnit,4)
        end
    elseif preCombat and Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["FOCUSINCOMBAT"]==3 then 
        i[hbCurrentFrame] = i[hbCurrentFrame]+1;
        table.insert(subunits,vFocusUnit)
    end
 
    if i[hbCurrentFrame]>vFocusIndex then 
        HealBot_Panel_SubSort(false, 5)
        if HealBot_BottomAnchors[hbCurrentFrame] then 
            HeaderPos[hbCurrentFrame][i[hbCurrentFrame]+1] = HEALBOT_FOCUS
        else
            HeaderPos[hbCurrentFrame][vFocusIndex+1] = HEALBOT_FOCUS 
        end
    end
end

local vMyTargetsIndex,vMyTargetsUnit=0,"unknown"
local function HealBot_Panel_myHeals()
    vMyTargetsIndex=i[hbCurrentFrame]
    table.foreach(HealBot_MyHealTargets, function (index,xGUID)
        vMyTargetsUnit=hbPanel_dataGUIDs[xGUID] or hbPanel_dataPetGUIDs[xGUID] or "unknown"
        if UnitExists(vMyTargetsUnit) then
            HealBot_Panel_addUnit(vMyTargetsUnit, xGUID, false)
        elseif HealBot_Unit_Button[vMyTargetsUnit] then
            HealBot_Panel_ToggelHealTarget(vMyTargetsUnit)
        end
    end)
    for xGUID,_ in pairs(HealBot_Globals.HealBot_PermMyTargets) do
        vMyTargetsUnit=hbPanel_dataGUIDs[xGUID] or hbPanel_dataPetGUIDs[xGUID] or "unknown"
        if UnitExists(vMyTargetsUnit) then  
            HealBot_Panel_addUnit(vMyTargetsUnit, xGUID, false)
        end
    end
    if i[hbCurrentFrame]>vMyTargetsIndex then 
        HealBot_Panel_addUnits(true, 1,HEALBOT_OPTIONS_MYTARGET,vMyTargetsIndex)
    end
end

local vGroupIndex=0
local function HealBot_Panel_groupHeals()
    vGroupIndex=i[hbCurrentFrame]
    for _,xUnit in ipairs(HealBot_Action_HealGroup) do
        if UnitExists(xUnit) and UnitGUID(xUnit) and hbPanel_dataGUIDs[UnitGUID(xUnit)] then
            if nraid>0 and not UnitIsUnit(xUnit, "player") then 
                xUnit=hbPanel_dataGUIDs[UnitGUID(xUnit)] or xUnit
            end
            HealBot_Panel_addUnit(xUnit, hbPanel_dataUnits[xUnit], false)
        elseif nraid==0 and Healbot_Config_Skins.Protection[Healbot_Config_Skins.Current_Skin]["COMBAT"] and IsInGroup() and Healbot_Config_Skins.Protection[Healbot_Config_Skins.Current_Skin]["COMBATPARTY"] then
            HealBot_UnitGroups[xUnit]=1
            HealBot_Panel_addUnit(xUnit, xUnit, false)
        end
    end
    if i[hbCurrentFrame]>vGroupIndex then 
        HealBot_Panel_addUnits(true, 1,HEALBOT_OPTIONS_GROUPHEALS,vGroupIndex)
        if HealBot_BottomAnchors[hbCurrentFrame] then 
            MyGroup["GROUP"]=i[hbCurrentFrame]+1
        else
            MyGroup["GROUP"]=vGroupIndex+1
        end
        MyGroup["FRAME"]=hbCurrentFrame
    else
        MyGroup["GROUP"]=0
    end
end

local vHealIndex=0
local function HealBot_Panel_healerHeals()
    vHealIndex=i[hbCurrentFrame]
    for xGUID,xUnit in pairs(HealBot_MainHealers) do
        HealBot_Panel_addUnit(xUnit, xGUID, false)
    end
    if i[hbCurrentFrame]>vHealIndex then 
        HealBot_Panel_addUnits(true, 1,HEALBOT_CLASSES_HEALERS,vHealIndex)
    end
end

local vTankIndex=0
local function HealBot_Panel_tankHeals()
    vTankIndex=i[hbCurrentFrame]
    for xGUID,xUnit in pairs(HealBot_MainTanks) do
        HealBot_Panel_addUnit(xUnit, xGUID, false)
    end
    if i[hbCurrentFrame]>vTankIndex then
        HealBot_Panel_addUnits(true, 1, HEALBOT_OPTIONS_TANKHEALS,vTankIndex)
    end
end

local vSelfIndex,vSelfUnit,vSelfPetUnit=0,"player","pet"
local function HealBot_Panel_selfHeals()
    vSelfIndex=i[hbCurrentFrame]
    HealBot_Panel_luVars["SelfPets"]=false
    if not HealBot_TrackNames[HealBot_Data["PGUID"]] then
        i[hbCurrentFrame] = i[hbCurrentFrame]+1;
        HealBot_TrackNames[HealBot_Data["PGUID"]]=true;
        table.insert(subunits,vSelfUnit)
        HealBot_Panel_SubSort(false, 1)
        if Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["SELFPET"] and HealBot_Config.DisabledNow==0 then
            if hbPanel_dataPetUnits[vSelfPetUnit] and not HealBot_TrackNames[hbPanel_dataPetUnits[vSelfPetUnit]] then
                i[hbCurrentFrame] = i[hbCurrentFrame]+1;
                HealBot_TrackNames[hbPanel_dataPetUnits[vSelfPetUnit]]=true;
                table.insert(subunits,vSelfPetUnit)
                HealBot_Panel_SubSort(false, 1)
                HealBot_Panel_luVars["SelfPets"]=true
            end
        end
    end
    if i[hbCurrentFrame]>vSelfIndex then 
        if HealBot_BottomAnchors[hbCurrentFrame] then 
            HeaderPos[hbCurrentFrame][i[hbCurrentFrame]+1] = HEALBOT_OPTIONS_SELFHEALS 
        else
            HeaderPos[hbCurrentFrame][vSelfIndex+1] = HEALBOT_OPTIONS_SELFHEALS 
        end
    end
end

local function HealBot_Panel_VehicleChanged()
    hbCurrentFrame=6
    if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["BARS"]==2 or Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["BARS"]==4 then
        HealBot_BottomAnchors[hbCurrentFrame]=true
    else
        HealBot_BottomAnchors[hbCurrentFrame]=false
    end
    hbBarsPerFrame[hbCurrentFrame]=0
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["STATE"]then
        HeaderPos[hbCurrentFrame]={};
        i[hbCurrentFrame]=0
        HealBot_Panel_vehicleHeals()
        for xUnit,xButton in pairs(HealBot_Pet_Button) do
            if xButton.status.unittype==2 then
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
        HealBot_Action_HidePanel(hbCurrentFrame)
    end
end

local vPetsChangedRole=""
local function HealBot_Panel_PetsChanged()
    hbCurrentFrame=7
    if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["BARS"]==2 or Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["BARS"]==4 then
        HealBot_BottomAnchors[hbCurrentFrame]=true
    else
        HealBot_BottomAnchors[hbCurrentFrame]=false
    end
    hbBarsPerFrame[hbCurrentFrame]=0
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["STATE"] then
        HeaderPos[hbCurrentFrame]={};
        i[hbCurrentFrame]=0
        HealBot_Panel_petHeals()
        for xUnit,xButton in pairs(HealBot_Pet_Button) do
            if xButton.status.unittype==3 then
                vPetsChangedRole=HealBot_Panel_petRole(xUnit)
                if HealBot_TrackUnit[xUnit] or vPetsChangedRole=="TANK" or vPetsChangedRole=="HEALER" then
                    HealBot_Action_UpdateBackgroundButton(xButton)
                    xButton:Show()
                elseif xButton.unit~="pet" or not HealBot_Panel_luVars["SelfPets"] then
                    HealBot_Action_MarkDeleteButton(xButton)
                end
            end
        end
        HealBot_Panel_SetupExtraBars(hbCurrentFrame)
    else
        HealBot_Action_HidePanel(hbCurrentFrame)
    end
end

local vTargetButton=""
local function HealBot_Panel_TargetChanged(preCombat)
    hbCurrentFrame=8
    if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["BARS"]==2 or Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["BARS"]==4 then
        HealBot_BottomAnchors[hbCurrentFrame]=true
    else
        HealBot_BottomAnchors[hbCurrentFrame]=false
    end
    hbBarsPerFrame[hbCurrentFrame]=0
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][9]["STATE"] then
        HeaderPos[hbCurrentFrame]={};
        i[hbCurrentFrame]=0
        HealBot_Panel_targetHeals(preCombat)        
        vTargetButton = HealBot_Unit_Button["target"]
        if vTargetButton then
            if HealBot_TrackUnit[vTargetButton.unit] and not HealBot_Panel_BlackList[vTargetButton.guid] then
                HealBot_setLuVars("TargetNeedReset", false)
                --HealBot_Action_UpdateBackgroundButton(vTargetButton)
                vTargetButton:Show()
                HealBot_Panel_SetupExtraBars(hbCurrentFrame)
                HealBot_Panel_TargetChangedCheckFocus()
            else
                HealBot_Action_HidePanel(hbCurrentFrame)
            end
        end
    else
        HealBot_Action_HidePanel(hbCurrentFrame)
    end
      --HealBot_setCall("HealBot_Panel_TargetChanged")
end

local vFocusParent, vFocusFrame="",""
function HealBot_Panel_TargetChangedCheckFocus()
    if hbPanelShowhbFocus then
        vFocusParent=_G["f8_HealBot_Action"]
        vFocusFrame=_G["HealBot_Action_HealUnit999"]
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
        if hbFocusOn and hbFocusOn~=vFocusFrame then hbFocusOn:Hide() end
        hbFocusOn=vFocusFrame
        if not HealBot_Data["UILOCK"] and UnitExists("target") and HealBot_Globals.FocusMonitor[HealBot_GetUnitName("target")] then
            if UnitExists("focus") and HealBot_Globals.FocusMonitor[HealBot_GetUnitName("focus")] then
                hbFocusOn:Hide()
            else
                HealBot_Skins_ResetSkin("hbfocus",hbFocusOn,Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][hbFocusOn.frame]["NUMCOLS"])
                hbFocusOn:ClearAllPoints()
                hbFocusOn:SetPoint("TOP",vFocusParent,"BOTTOM",0,0);
                MaxOffsetY[8] = MaxOffsetY[8]+bheight[8]+15;
                hbFocusOn:Show();
            end
        end
    elseif hbFocusOn then
        hbFocusOn:Hide();
        hbFocusOn=nil
    end
end

local vFocusButton=""
local function HealBot_Panel_FocusChanged(preCombat)
    if HEALBOT_GAME_VERSION>3 then 
        hbCurrentFrame=9
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["BARS"]==2 or Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["BARS"]==4 then
            HealBot_BottomAnchors[hbCurrentFrame]=true
        else
            HealBot_BottomAnchors[hbCurrentFrame]=false
        end
        hbBarsPerFrame[hbCurrentFrame]=0
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["STATE"] then
            HeaderPos[hbCurrentFrame]={};
            i[hbCurrentFrame]=0
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
            HealBot_Action_HidePanel(hbCurrentFrame)
        end
    elseif Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["STATE"] then
        Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["STATE"]=false
    end
end

local function HealBot_Panel_EnemyChanged()
    hbCurrentFrame=10
    if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["BARS"]==2 or Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][hbCurrentFrame]["BARS"]==4 then
        HealBot_BottomAnchors[hbCurrentFrame]=true
    else
        HealBot_BottomAnchors[hbCurrentFrame]=false
    end
    hbBarsPerFrame[hbCurrentFrame]=0
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][11]["STATE"] then
        HeaderPos[hbCurrentFrame]={};
        i[hbCurrentFrame]=0
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
        HealBot_Action_HidePanel(hbCurrentFrame)
    end
end

local vIsCrashProt,vPetsWithPlayers=false,false
local function HealBot_Panel_PlayersChanged()
    hbBarsPerFrame[1]=0
    hbBarsPerFrame[2]=0
    hbBarsPerFrame[3]=0
    hbBarsPerFrame[4]=0
    hbBarsPerFrame[5]=0
    for j=1,5 do
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][j]["BARS"]==2 or Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][j]["BARS"]==4 then
            HealBot_BottomAnchors[j]=true
        else
            HealBot_BottomAnchors[j]=false
        end
    end
    nraid=GetNumGroupMembers();
    TempMaxH=9;
    
    if not IsInRaid() then nraid=0 end;

    for gl=1,5 do
        HeaderPos[gl]={};
    end
    
    for x,_ in pairs(HealBot_cpName) do
        HealBot_cpName[x]=nil
    end 

    i[1]=0
    i[2]=0
    i[3]=0
    i[4]=0
    i[5]=0
    vIsCrashProt=false
    if HealBot_retLuVars("UseCrashProtection") and Healbot_Config_Skins.Protection[Healbot_Config_Skins.Current_Skin]["CRASH"] then
        if nraid==0 and not UnitExists("player") then
            HealBot_cpData["mName"]=HealBot_Config.CrashProtMacroName
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
        
        for xUnit,xButton in pairs(HealBot_Unit_Button) do
            if xButton.status.unittype==1 then
                if HealBot_TrackUnit[xUnit] and not HealBot_Panel_BlackList[xButton.guid] then
                    HealBot_Action_UpdateBackgroundButton(xButton)
                    xButton:Show()
                else
                    HealBot_Action_MarkDeleteButton(xButton)
                end
            end
        end
        if vPetsWithPlayers then
            for xUnit,xButton in pairs(HealBot_Pet_Button) do
                if HealBot_TrackUnit[xUnit] then
                    HealBot_Action_UpdateBackgroundButton(xButton)
                    xButton:Show()
                else
                    HealBot_Action_MarkDeleteButton(xButton)
                end
            end
        end

        if Healbot_Config_Skins.Protection[Healbot_Config_Skins.Current_Skin]["CRASH"] and not HealBot_Data["UILOCK"] and HealBot_Panel_luVars["SaveCrashProtection"]<GetTime() then
            HealBot_Panel_luVars["SaveCrashProtection"]=GetTime()+15
            HealBot_cpData["mName"]=HealBot_Config.CrashProtMacroName
            local j=0
            local k=1
            local t=HealBot_cpData["body1"]
            HealBot_cpData["body1"]=""
            table.foreach(HealBot_Action_HealButtons, function (_,xUnit)
                local xButton=HealBot_Unit_Button[xUnit]
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

local function HealBot_Panel_DoPartyChanged(preCombat, changeType)
    for xHeader in pairs(HealBot_Track_Headers) do
        HealBot_Track_Headers[xHeader]=false
    end
    for x,_ in pairs(HealBot_TrackUnit) do
        HealBot_TrackUnit[x]=nil
    end 
    for x,_ in pairs(HealBot_TrackNames) do
        HealBot_TrackNames[x]=nil;
    end
    for xGUID,_ in pairs(HealBot_Panel_BlackList) do
        HealBot_TrackNames[xGUID]=true
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
                HealBot_Panel_DoPartyChanged(preCombat, 3)
                HealBot_Panel_DoPartyChanged(preCombat, 4)
            else
                HealBot_nextRecalcParty(3)
                if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["FRAME"]==6 then HealBot_nextRecalcParty(1) end
                HealBot_nextRecalcParty(4)
                if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["FRAME"]==7 then HealBot_nextRecalcParty(2) end
                HealBot_nextRecalcParty(5)
            end
        end 
    end
    --HealBot_setCall("HealBot_Panel_PartyChanged")
end
