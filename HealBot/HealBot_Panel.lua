local TempMaxH=0;
local HealBot_TrackNames={};
local HealBot_TrackPrivateNames={}
local i={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,[6]=0,[7]=0,[8]=0,[9]=0,[10]=0}
local order={};
local units={};
local suborder={};
local subunits={};
local MyGroup={["GROUP"]=0,["FRAME"]=1}
local HeaderPos={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
local HealBot_ActiveHeaders={[0]=1}
local HealBot_AutoCloseFrame={[1]=1,[2]=1,[3]=1,[4]=1,[5]=1,[6]=1,[7]=1,[8]=1,[9]=1,[10]=1}
local HealBot_EnemyUnits={}
local HealBot_UnitTargets={}
local HealBot_TrackUnit={}
local HealBot_TrackPrivateUnit={}
HealBot_TrackUnit[hbv_GetUnitType(HEALBOT_RAID)]={}
HealBot_TrackUnit[hbv_GetUnitType(HEALBOT_GROUP)]={}
HealBot_TrackUnit[hbv_GetUnitType(HEALBOT_PRIVATELIST)]={}
HealBot_TrackUnit[hbv_GetUnitType(HEALBOT_VEHICLE)]={}
HealBot_TrackUnit[hbv_GetUnitType(HEALBOT_PET)]={}
HealBot_TrackUnit[hbv_GetUnitType(HEALBOT_TARGET)]={}
HealBot_TrackUnit[hbv_GetUnitType(HEALBOT_TOT)]={}
HealBot_TrackUnit[hbv_GetUnitType(HEALBOT_TOF)]={}
--HealBot_TrackUnit[hbv_GetUnitType(HEALBOT_PRIVFOCUSTOT)]={}
HealBot_TrackUnit[hbv_GetUnitType(HEALBOT_FOCUS)]={}
HealBot_TrackUnit[hbv_GetUnitType(HEALBOT_ENEMY)]={}
HealBot_TrackUnit[hbv_GetUnitType(HEALBOT_PLAYERTARGET)]={}
HealBot_TrackUnit[hbv_GetUnitType(HEALBOT_PRIVATETARGET)]={}
HealBot_TrackPrivateUnit[hbv_GetUnitType(HEALBOT_TANK)]={}
HealBot_TrackPrivateUnit[hbv_GetUnitType(HEALBOT_HEALER)]={}
HealBot_TrackPrivateUnit[hbv_GetUnitType(HEALBOT_SELF)]={}
HealBot_TrackPrivateUnit[hbv_GetUnitType(HEALBOT_PRIVATELIST)]={}
HealBot_TrackPrivateUnit[hbv_GetUnitType(HEALBOT_PRIVATEFOCUS)]={}
HealBot_TrackPrivateUnit[hbv_GetUnitType(HEALBOT_PRIVFOCUSTOT)]={}
local HealBot_Panel_BlackList={};
local backBarsSize={}
for x=1,10 do
    backBarsSize[x]={["HEIGHT"]=0, ["WIDTH"]=0, ["HEADERWIDTH"]=0, ["MINWIDTH"]=0, ["MINHEADERWIDTH"]=0, ["SKINRESET"]=true,
                     ["RMARGIN"]=0, ["CMARGIN"]=0, ["HEADHEIGHT"]=0, ["HEADWIDTH"]=0, ["S2WIDTH"]=0, ["PAD"]=0}
end
local HealBot_MyHealTargets={}
local HealBot_MyPrivateTanks={}
local HealBot_MyPrivateHealers={}
local HealBot_MyPrivateDamagers={}
local HealBot_MainTanks={};
local HealBot_MainHealers={};
local HealBot_UnitGroups={}
local HealBot_TestBarsActive={}
local hbBarsPerFrame={}
local hbCurrentFrame=1
local hbCurrentHealGroup=1
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
local hbPanel_dataRanks={}
local hbPanel_dataPlayerRoles={}
local hbPanel_dataPetUnits={}
local hbPanel_dataPetNames={}
local hbPanel_dataPetGUIDs={}
local hbPanel_enemyUnits={}
local hbPanel_enemyUnits={}
local hbPanel_buttonGUIDs={}
local hbPanel_buttonpGUIDs={}
local hbPanel_buttonPetGUIDs={}
local hbPanel_buttonExtraGUIDs={}
local grpNo=1
local tHeader={}
local erButton=nil
local xButton, pButton, aButton
local xUnit=""
local xGUID=""
local hbRole={ [HEALBOT_MAINTANK]=3,
               [HEALBOT_OFFTANK]=4,
               [HEALBOT_WORD_HEALER]=5,
               [HEALBOT_WORD_DPS]=7,
               [HEALBOT_WORDS_UNKNOWN]=9,
      }
local HealBot_randomN=random(11)
local prevCol=0
local HealBot_randomClCol={}
local HealBot_randomClNames={}
local HealBot_Action_HealGroup={["player"]=1,["party1"]=2,["party2"]=3,["party3"]=4,["party4"]=5};
local HealBot_colIndex= {}
local HealBot_Action_HealButtons={};
local hbPanelShowhbFocus=nil
local hbPanelNoCols={[1]=1,[2]=1,[3]=1,[4]=1,[5]=1,[6]=1,[7]=1,[8]=1,[9]=1,[10]=1}
local hbPanelNoRows={[1]=1,[2]=1,[3]=1,[4]=1,[5]=1,[6]=1,[7]=1,[8]=1,[9]=1,[10]=1}
local hbPanelEnemyWidths={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
local HealBot_noBars=100
local HealBot_setTestCols={}
local HealBot_setTestBars=false
local HealBot_RoleIDs={[HEALBOT_MAINTANK]=1, [HEALBOT_WORD_HEALER]=2, [HEALBOT_WORD_DPS]=3}
local hbPanelResetRequired={}
local hbPlayersTargetsHealGroupCount={}
local hbHealGroupFrames={}
for x=1,10 do
    hbPanelResetRequired[x]=true
    hbPlayersTargetsHealGroupCount[x]=0
    hbHealGroupFrames[x]=1
end
hbPlayersTargetsHealGroupCount[11]=0
hbHealGroupFrames[11]=10
local HealBot_Panel_luVars={}
HealBot_Panel_luVars["SelfPets"]=false
HealBot_Panel_luVars["OptionsShown"]=false
HealBot_Panel_luVars["TestBarsDelAll"]=true
HealBot_Panel_luVars["MAPID"]=0
HealBot_Panel_luVars["NumPrivate"]=0
HealBot_Panel_luVars["NumPets"]=0
HealBot_Panel_luVars["TankHealth"]=0
HealBot_Panel_luVars["cpGroup"]=false
HealBot_Panel_luVars["cpRaid"]=false
HealBot_Panel_luVars["FocusGroups"]=1
HealBot_Panel_luVars["cpMacro"]="HealBot-CrashProt"
HealBot_Panel_luVars["cpCrash"]=false
HealBot_Panel_luVars["FGroups"]={[1]=true,[2]=true,[3]=true,[4]=true,[5]=true,[6]=true,[7]=true,[8]=true}

local hbRoleOnes={}
local hbTANK1=1
local hbTANK2=2
local hbHEALER=3
local hbDPS=4
local hbDPSC=5
local hbRoleRef={[hbTANK1]="TankGUID1",[hbTANK2]="TankGUID2",[hbHEALER]="HealerGUID",[hbDPS]="DPSGUID",[hbDPSC]="DPSGUIDCaster"}
for x=1,5 do
    hbRoleOnes[x]={}
    hbRoleOnes[x].guid=""
    hbRoleOnes[x].prevguid="x"
    hbRoleOnes[x].health=0
end
--local hbClassOnes={}

local tClass={["WARR"]=true,["PALA"]=true,["DRUI"]=true,["DEAT"]=true}
function HealBot_Panel_retLuVars(vName)
      --HealBot_setCall("HealBot_Panel_retLuVars - "..vName)
    return HealBot_Panel_luVars[vName]
end

function HealBot_Panel_setLuVars(vName, vValue)
      --HealBot_setCall("HealBot_Panel_setLuVars - "..vName)
    HealBot_Panel_luVars[vName]=vValue
end

function HealBot_Panel_retNoCols(frame)
      --HealBot_setCall("HealBot_Panel_retNoCols")
    return hbPanelNoCols[frame]
end

function HealBot_Panel_retHeadersCols(frame)
      --HealBot_setCall("HealBot_Panel_retHeadersCols")
    return ceil(hbPanelNoRows[frame]/5)
end

function HealBot_Panel_setAutoClose(frame)
      --HealBot_setCall("HealBot_Panel_setAutoClose")
    HealBot_AutoCloseFrame[frame]=hbv_Skins_GetFrameVar("Frame", "AUTOCLOSE", frame)
end

function HealBot_Panel_setCP(cpType, useCP)
      --HealBot_setCall("HealBot_Panel_setCP")
    if cpType == "GROUP" then
        HealBot_Panel_luVars["cpGroup"]=useCP
    elseif cpType == "RAID" then
        HealBot_Panel_luVars["cpRaid"]=useCP
    end
end

function HealBot_Panel_isSpecialUnit(unit)
      --HealBot_setCall("HealBot_Panel_isSpecialUnit")
    return HealBot_EnemyUnits[unit] or -1
end

function HealBot_Panel_isSpecialPlayerUnit(unit)
      --HealBot_setCall("HealBot_Panel_isSpecialPlayerUnit")
    return HealBot_UnitTargets[unit] or -1
end

function HealBot_Panel_TankRole(unit, guid, isPlayer, offtank)
      --HealBot_setCall("HealBot_Panel_TankRole")
    if offtank then
        HealBot_unitRole[unit]=hbRole[HEALBOT_OFFTANK]
    else
        HealBot_unitRole[unit]=hbRole[HEALBOT_MAINTANK]
    end
    HealBot_MainTanks[guid]=unit
    if isPlayer then
        if UnitHealthMax(unit)>hbRoleOnes[hbTANK1].health then
            if hbRoleOnes[hbTANK1].health>0 then
                if hbRoleOnes[hbTANK2].guid == guid then
                    hbRoleOnes[hbTANK2].health=0
                    hbRoleOnes[hbTANK2].guid="x"
                else
                    hbRoleOnes[hbTANK2].health=hbRoleOnes[hbTANK1].health
                    hbRoleOnes[hbTANK2].guid=hbRoleOnes[hbTANK1].guid
                end
            end
            hbRoleOnes[hbTANK1].health=UnitHealthMax(unit)
            hbRoleOnes[hbTANK1].guid=guid
        elseif UnitHealthMax(unit)>hbRoleOnes[hbTANK2].health then
            hbRoleOnes[hbTANK2].health=UnitHealthMax(unit)
            hbRoleOnes[hbTANK2].guid=guid
        end
    end
    if hbPanel_dataPlayerRoles[guid] == 0 or hbPanel_dataPlayerRoles[guid]>5 then hbPanel_dataPlayerRoles[guid]=2 end
end

function HealBot_Panel_HealerRole(unit, guid, isPlayer)
      --HealBot_setCall("HealBot_Panel_HealerRole")
    HealBot_unitRole[unit]=hbRole[HEALBOT_WORD_HEALER]
    HealBot_MainHealers[guid]=unit
    if isPlayer and UnitHealthMax(unit)>hbRoleOnes[hbHEALER].health then
        hbRoleOnes[hbHEALER].health=UnitHealthMax(unit)
        hbRoleOnes[hbHEALER].guid=guid
    end
    if hbPanel_dataPlayerRoles[guid] == 0 or hbPanel_dataPlayerRoles[guid]>5 then hbPanel_dataPlayerRoles[guid]=3 end
end

local hbClassCasterPrefBonus={}
if HEALBOT_GAME_VERSION<4 then
    hbClassCasterPrefBonus={["WARLOCK"]=2.1, ["MAGE"]=2, ["HUNTER"]=2, ["SHAMAN"]=1.9, ["DRUID"]=1.5, ["PALADIN"]=1}
else
    hbClassCasterPrefBonus={["WARLOCK"]=2.1, ["MAGE"]=2, ["SHAMAN"]=1.9, ["DRUID"]=1.5, ["PALADIN"]=1}
end

function HealBot_Panel_DamagerRole(unit, guid, isPlayer)
      --HealBot_setCall("HealBot_Panel_DamagerRole")
    HealBot_unitRole[unit]=hbRole[HEALBOT_WORD_DPS]
    if isPlayer then
        if UnitHealthMax(unit)>hbRoleOnes[hbDPS].health then
            hbRoleOnes[hbDPS].health=UnitHealthMax(unit)
            hbRoleOnes[hbDPS].guid=guid
        end
        if (UnitPowerType(unit) or 1) == 0 then
            local _, uuUnitClassEN=UnitClass(unit) or "X"
            local maxHealth=UnitHealthMax(unit)
            if hbClassCasterPrefBonus[uuUnitClassEN] then
                maxHealth=maxHealth*hbClassCasterPrefBonus[uuUnitClassEN]
            end
            if maxHealth>hbRoleOnes[hbDPSC].health then
                hbRoleOnes[hbDPSC].health=maxHealth
                hbRoleOnes[hbDPSC].guid=guid
            end
        end
    end
end

local aRole=nil
function HealBot_Panel_SetRole(unit, guid, isPlayer)
      --HealBot_setCall("HealBot_Panel_SetRole")
    aRole=HealBot_Panel_UnitRole(unit, guid, isPlayer)
    if aRole == "TANK" then
        HealBot_Panel_TankRole(unit, guid, isPlayer)
    elseif aRole == "OFFTANK" then
        HealBot_Panel_TankRole(unit, guid, isPlayer, true)
    elseif aRole == "HEALER" then
        HealBot_Panel_HealerRole(unit, guid, isPlayer)
    elseif aRole == "DAMAGER" then
        HealBot_Panel_DamagerRole(unit, guid, isPlayer)
    else
        HealBot_unitRole[unit]=hbRole[HEALBOT_WORDS_UNKNOWN]
    end
end

function HealBot_Panel_updDataStore(button)
      --HealBot_setCall("HealBot_Panel_updDataStore")
    button.reset=true
    if hbPanel_dataUnits[button.unit] then
        hbPanel_dataNames[button.name]=button.unit
        hbPanel_dataGUIDs[button.guid]=button.unit
        hbPanel_dataUnits[button.unit]=button.guid
        button.roletxt=HealBot_Panel_UnitRoleDefault(button.guid)
        button.rank=HealBot_Panel_RetUnitRank(button.guid, button.frame)
        if button.role~=hbPanel_dataPlayerRoles[button.guid] then
            button.role=hbPanel_dataPlayerRoles[button.guid]
            HealBot_setLuVars("pluginClearDown", 1)
        end
        if button.status.unittype<10 then
            hbPanel_buttonpGUIDs[button.guid]=button
        else
            hbPanel_buttonGUIDs[button.guid]=button
        end
        HealBot_Timers_Set("OOC","RefreshPartyNextRecalcPlayers",true)
    elseif hbPanel_dataPetUnits[button.unit] then
        hbPanel_dataPetNames[button.name]=button.unit
        hbPanel_dataPetGUIDs[button.guid]=button.unit
        hbPanel_dataPetUnits[button.unit]=button.guid
        hbPanel_buttonPetGUIDs[button.guid]=button
        if hbv_IsUnitType(button.status.unittype, HEALBOT_VEHICLE) then
            HealBot_Timers_Set("OOC","RefreshPartyNextRecalcVehicle",true)
        else
            HealBot_Timers_Set("OOC","RefreshPartyNextRecalcPets",true)
        end
    elseif button.status.unittype>30 then
        hbPanel_buttonExtraGUIDs[button.guid]=button
    end
    if HealBot_Config.PrivFocus == button.guid then
        HealBot_Panel_luVars["PrivFocusUnit"]=button.unit
    end
end

function HealBot_Panel_SetPermPrivateData(unit, guid, focus)
    if focus then
        HealBot_Config.PrivData["NAME"]=UnitName(unit) or HEALBOT_WORDS_UNKNOWN
        HealBot_Config.PrivData["CLASS"]=UnitClass(unit) or HEALBOT_WORDS_UNKNOWN
        HealBot_Config.PrivData["TIME"]=GetServerTime()
    else
        if not HealBot_Globals.PermPrivateData[guid] then
            HealBot_Globals.PermPrivateData[guid]={}
            HealBot_Globals.PermPrivateData[guid]["NAME"]=UnitName(unit) or HEALBOT_WORDS_UNKNOWN
            HealBot_Globals.PermPrivateData[guid]["CLASS"]=UnitClass(unit) or HEALBOT_WORDS_UNKNOWN
            HealBot_Globals.PermPrivateData[guid]["TIME"]=GetServerTime()
            aButton=HealBot_Panel_AllButton(guid)
            if aButton then 
                HealBot_Globals.PermPrivateData[guid]["CLASSTRIM"]=aButton.text.classtrim
            else
                HealBot_Globals.PermPrivateData[guid]["CLASSTRIM"]=""
            end
            HealBot_Globals.PermPrivateData[guid]["PFACTION"]=HealBot_Data["PFACTION"]
        end
    end
end

function HealBot_Panel_CleanPermPrivateData()
    for guid in pairs(HealBot_Globals.PermPrivateData) do
        if not HealBot_Globals.PermMyTargets[guid] and 
           not HealBot_Globals.PermPrivateTanks[guid] and 
           not HealBot_Globals.PermPrivateHealers[guid] and 
           not HealBot_Globals.PermPrivateDamagers[guid] then
            HealBot_Globals.PermPrivateData[guid]=nil
        end
    end
end

function HealBot_Panel_addDataStore(unit, nRaidID, isPlayer, nPartyID)
      --HealBot_setCall("HealBot_Panel_addDataStore")
    if UnitExists(unit) then
        local dsGUID=UnitGUID(unit)
        local dsName=UnitName(unit)
        if dsGUID then
            if HealBot_Config.PrivFocus == dsGUID then
                HealBot_Panel_SetPrivFocus(unit)
            end
            hbPanel_dataRanks[dsGUID]=0
            hbPanel_dataPlayerRoles[dsGUID]=0
            if isPlayer then
                --if UnitIsUnit(unit, "player") then unit="player" end
                hbPanel_dataNames[dsName]=unit
                hbPanel_dataGUIDs[dsGUID]=unit
                hbPanel_dataUnits[unit]=dsGUID
            else
                --if UnitIsUnit(unit, "pet") then unit="pet" end
                hbPanel_dataPetNames[dsName]=unit
                hbPanel_dataPetGUIDs[dsGUID]=unit
                hbPanel_dataPetUnits[unit]=dsGUID
            end
            if HealBot_MyPrivateTanks[dsGUID] or HealBot_Globals.PermPrivateTanks[dsGUID] then
                hbPanel_dataRoles[dsGUID]="TANK"
                hbPanel_dataPlayerRoles[dsGUID]=4
                if HealBot_Globals.PermPrivateTanks[dsGUID] then HealBot_Panel_SetPermPrivateData(unit, dsGUID) end
            elseif HealBot_MyPrivateHealers[dsGUID] or HealBot_Globals.PermPrivateHealers[dsGUID] then
                hbPanel_dataRoles[dsGUID]="HEALER"
                hbPanel_dataPlayerRoles[dsGUID]=5
                if HealBot_Globals.PermPrivateHealers[dsGUID] then HealBot_Panel_SetPermPrivateData(unit, dsGUID) end
            elseif HealBot_MyPrivateDamagers[dsGUID] or  HealBot_Globals.PermPrivateDamagers[dsGUID] then
                hbPanel_dataRoles[dsGUID]="DAMAGER"
                if HealBot_Globals.PermPrivateDamagers[dsGUID] then HealBot_Panel_SetPermPrivateData(unit, dsGUID) end
            else
                hbPanel_dataRoles[dsGUID]=HEALBOT_WORDS_UNKNOWN
            end
            if nRaidID>0 then
                local hbFRole=false
                local _, rank, hbSubgroup, _, _, _, _, _, _, hbRRole, isML, hbCombatRole=GetRaidRosterInfo(nRaidID);
                HealBot_UnitGroups[unit]=hbSubgroup
                if isPlayer then
                    if UnitIsUnit(unit, "player") then
                        HealBot_Data["PGROUP"]=hbSubgroup or 1
                    end
                    if hbPanel_dataPlayerRoles[dsGUID] == 0 then hbPanel_dataPlayerRoles[dsGUID]=7 end
                    if hbPanel_dataRoles[dsGUID] == HEALBOT_WORDS_UNKNOWN then
                        if hbRRole and (string.lower(hbRRole) == "maintank" or (HealBot_Globals.IncMainAssist and string.lower(hbRRole) == "mainassist")) then
                            if string.lower(hbRRole) == "maintank" then 
                                hbFRole="TANK"
                                hbPanel_dataPlayerRoles[dsGUID]=1 
                            else
                                hbFRole="OFFTANK"
                            end
                        elseif hbCombatRole and (hbCombatRole == "HEALER" or hbCombatRole == "TANK") then
                            hbFRole=hbCombatRole
                        end
                    end
                    if HEALBOT_GAME_VERSION>3 and rank>0 and GetLFGMode(LE_LFG_CATEGORY_LFR) then
                        if UnitIsGroupLeader(unit) then
                            hbPanel_dataRanks[dsGUID]=2
                        end
                    elseif isML then
                        hbPanel_dataRanks[dsGUID]=3
                    elseif rank>0 then
                        hbPanel_dataRanks[dsGUID]=rank
                    end
                end
                if not hbFRole then
                    HealBot_Panel_SetRole(unit, dsGUID, isPlayer)
                else
                    hbPanel_dataRoles[dsGUID]=hbFRole
                    if hbFRole == "TANK" then
                        HealBot_Panel_TankRole(unit, dsGUID, isPlayer)
                    elseif hbFRole == "OFFTANK" then
                        HealBot_Panel_TankRole(unit, dsGUID, isPlayer, true)
                    elseif hbFRole == "HEALER" then
                        HealBot_Panel_HealerRole(unit, dsGUID, isPlayer)
                    elseif hbFRole == "DAMAGER" then
                        HealBot_Panel_DamagerRole(unit, dsGUID, isPlayer)
                    end
                end
            else
                HealBot_UnitGroups[unit]=1
                HealBot_Data["PGROUP"]=1
                HealBot_Panel_SetRole(unit, dsGUID, isPlayer)
                if IsInGroup() then
                    if UnitIsGroupLeader(unit) then 
                        hbPanel_dataRanks[dsGUID]=4
                    end
                    if hbPanel_dataPlayerRoles[dsGUID] == 0 then hbPanel_dataPlayerRoles[dsGUID]=6 end
                end
            end
        end
    end
end

local hbPlayerRaidID=0
function HealBot_Panel_buildDataStore(doPlayers, doPets)
      --HealBot_setCall("HealBot_Panel_buildDataStore")
    if doPlayers then
        for x,_ in pairs(hbPanel_buttonGUIDs) do
            hbPanel_buttonGUIDs[x]=nil
        end
        for x,_ in pairs(hbPanel_buttonpGUIDs) do
            hbPanel_buttonpGUIDs[x]=nil
        end
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
        hbPlayerRaidID=0
        for x=1,5 do
            hbRoleOnes[x].health=0
            hbRoleOnes[x].guid="x"
        end
        if HealBot_Config.DisabledNow == 0 then
            local nGroupMembers=GetNumGroupMembers()
            if nGroupMembers>0 then
                if IsInRaid() then
                    for j=1,nGroupMembers do
                        HealBot_Panel_addDataStore("raid"..j, j, true)
                        if UnitIsUnit("raid"..j, "player") then
                            hbPlayerRaidID=j
                        end
                    end
                else
                    for j=1,nGroupMembers do
                        HealBot_Panel_addDataStore("party"..j, 0, true, j)
                    end
                end
            end
        end
        HealBot_Panel_addDataStore("player", hbPlayerRaidID, true)
        for x=1,5 do
            if hbRoleOnes[x].prevguid~=hbRoleOnes[x].guid then
                hbRoleOnes[x].prevguid=hbRoleOnes[x].guid
                HealBot_setLuVars(hbRoleRef[x], hbRoleOnes[x].guid)
                HealBot_Aura_setLuVars(hbRoleRef[x], hbRoleOnes[x].guid)
                HealBot_ActionIcons_setLuVars(hbRoleRef[x], hbRoleOnes[x].guid)
                HealBot_setLuVars("pluginClearDown", 1)
            end
        end
    end
    if doPets then
        HealBot_Panel_luVars["NumPets"]=0
        for x,_ in pairs(hbPanel_buttonPetGUIDs) do
            hbPanel_buttonPetGUIDs[x]=nil
        end
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
        if HealBot_Config.DisabledNow == 0 then
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
      --HealBot_setCall("HealBot_Panel_clickToFocus")
    if status == "Show" then
        hbPanelShowhbFocus=true
    else
        hbPanelShowhbFocus=false
    end
end

function HealBot_Panel_IsMyTarget(guid)
      --HealBot_setCall("HealBot_Panel_IsMyTarget", nil, guid)
    return HealBot_MyHealTargets[guid] or HealBot_Globals.PermMyTargets[guid]
end

function HealBot_Panel_IsTank(guid)
      --HealBot_setCall("HealBot_Panel_IsTank", nil, guid)
    return HealBot_MainTanks[guid]
end

function HealBot_Panel_IsHealer(guid)
      --HealBot_setCall("HealBot_Panel_IsHealer", nil, guid)
    return HealBot_MainHealers[guid]
end

function HealBot_Panel_SethbTopRole(Role)
      --HealBot_setCall("HealBot_Panel_SethbTopRole")
    if not Role then return end
    Role=strupper(strtrim(Role))
    if Role == "TANK" then
        hbRole[HEALBOT_MAINTANK]=2
        hbRole[HEALBOT_OFFTANK]=3
        hbRole[HEALBOT_WORD_HEALER]=5
        hbRole[HEALBOT_WORD_DPS]=7
    elseif Role == "DPS" then
        hbRole[HEALBOT_MAINTANK]=3
        hbRole[HEALBOT_OFFTANK]=4
        hbRole[HEALBOT_WORD_HEALER]=5
        hbRole[HEALBOT_WORD_DPS]=2
    elseif Role == "HEALER" then
        hbRole[HEALBOT_MAINTANK]=3
        hbRole[HEALBOT_OFFTANK]=4
        hbRole[HEALBOT_WORD_HEALER]=2
        hbRole[HEALBOT_WORD_DPS]=7
    else
        HealBot_AddChat(Role..HEALBOT_CHAT_TOPROLEERR)
        return
    end
    if HealBot_Globals.TopRole~=Role then
        HealBot_Globals.TopRole=Role
        HealBot_AddChat(HEALBOT_CHAT_NEWTOPROLE..Role)
        HealBot_Timers_Set("OOC","RefreshPartyNextRecalcAll")
    end
end

function HealBot_Panel_ClearBlackList()
      --HealBot_setCall("HealBot_Panel_ClearBlackList")
    for x,_ in pairs(HealBot_Panel_BlackList) do
        HealBot_Panel_BlackList[x]=nil
    end
    HealBot_Timers_Set("OOC","RefreshPartyNextRecalcAll")
end

function HealBot_Panel_AddBlackList(unit)
      --HealBot_setCall("HealBot_Panel_AddBlackList", nil, nil, unit)
    xGUID=UnitGUID(unit)
    if xGUID then
        HealBot_Panel_BlackList[xGUID]=true;
        HealBot_Timers_Set("OOC","RefreshPartyNextRecalcAll")
    end
end

function HealBot_Panel_SetPrivFocus(unit)
    if (HealBot_Panel_luVars["PrivFocusUnit"] or "x") ~= unit then
        HealBot_Panel_luVars["PrivFocusUnit"]=unit
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["STATE"] and UnitExists(unit) then
            HealBot_Events_FrameUnit("PRIVFOCUS", true, unit)
        end
    end
end

function HealBot_Panel_RetPrivFocus()
    return HealBot_Panel_luVars["PrivFocusUnit"] or "x"
end

function HealBot_Panel_ToggelPrivFocus(unit, recall)
      --HealBot_setCall("HealBot_Panel_ToggelPrivFocus")
    if unit == "player" or unit == "pet" or string.find(unit, "raid") or string.find(unit, "party") then
        xGUID=UnitGUID(unit)
        if not xGUID or HealBot_Config.PrivFocus == xGUID then
            if HealBot_Config.PrivFocus ~= "x" then
                HealBot_Timers_Set("OOC","RefreshPartyNextRecalcPlayers")
            end
            HealBot_Config.PrivFocus="x"
            HealBot_Panel_luVars["PrivFocusUnit"]=false
        else
            HealBot_Config.PrivFocus=xGUID
            HealBot_Panel_SetPermPrivateData(unit, xGUID, true)
            HealBot_Panel_SetPrivFocus(unit)
            aButton=HealBot_Panel_AllButton(xGUID)
            if aButton then
                HealBot_Events_UnitBuff(aButton)
            end
            HealBot_Timers_Set("OOC","RefreshPartyNextRecalcPlayers")
        end
        HealBot_Timers_Set("OOC","UpdateTargetMyFriend")
    elseif not recall and UnitExists(unit) then
        xGUID=UnitGUID(unit) or "x"
        xUnit=HealBot_Panel_PlayerUnitGUID(xGUID) or HealBot_Panel_PetUnitGUID(xGUID)
        if xUnit then HealBot_Panel_ToggelPrivFocus(xUnit, true) end
    else
        HealBot_AddChat("Invalid Unit "..unit)
        HealBot_AddChat("Unit must be in group or raid")
    end
end

function HealBot_Panel_ClearHealTargets()
      --HealBot_setCall("HealBot_Panel_ClearHealTargets")
    HealBot_MyHealTargets={}
end

function HealBot_Panel_PrivateListUpdate()
      --HealBot_setCall("HealBot_Panel_PrivateListUpdate")
    HealBot_Timers_Set("OOC","RefreshPartyNextRecalcPlayers")
    HealBot_Timers_Set("OOC","RefreshPartyNextRecalcPets")
    HealBot_Timers_Set("AURA","CheckUnits",true)
    HealBot_Timers_Set("LAST","PluginTweaksRefresh",true)
end

function HealBot_Panel_ToggelHealTarget(unit, perm)
      --HealBot_setCall("HealBot_Panel_ToggelHealTarget", nil, nil, unit)
    local xGUID=UnitGUID(unit)
    if perm then
        if HealBot_Globals.PermMyTargets[xGUID] then
            HealBot_Globals.PermMyTargets[xGUID]=nil
        else
            HealBot_Globals.PermMyTargets[xGUID]=UnitName(unit) or "unKnown"
            HealBot_Panel_SetPermPrivateData(unit, xGUID)
        end
    else
        if HealBot_MyHealTargets[xGUID] then
            HealBot_MyHealTargets[xGUID]=nil
        else
            HealBot_MyHealTargets[xGUID]=true
        end
    end
    HealBot_Timers_Set("LAST","PrivateListUpdate",true)
    --HealBot_Timers_Set("OOC","RefreshPartyNextRecalcAll")
end

function HealBot_Panel_ToggelPrivateTanks(unit, perm)
      --HealBot_setCall("HealBot_Panel_ToggelPrivateTanks", nil, nil, unit)
    local xGUID=UnitGUID(unit)
    if perm then
        if HealBot_Globals.PermPrivateTanks[xGUID] then
            HealBot_Globals.PermPrivateTanks[xGUID]=nil
        else
            HealBot_Globals.PermPrivateTanks[xGUID]=UnitName(unit) or "unKnown"
            HealBot_Panel_SetPermPrivateData(unit, xGUID)
        end
    else
        if HealBot_MyPrivateTanks[xGUID] then
            HealBot_MyPrivateTanks[xGUID]=nil
        else
            HealBot_MyPrivateTanks[xGUID]=true
        end
    end
    HealBot_Timers_Set("LAST","PrivateListUpdate")
    HealBot_Timers_setLuVars("ResetClassRank", true)
    --HealBot_Timers_Set("OOC","RefreshPartyNextRecalcAll")
end

function HealBot_Panel_ToggelPrivateHealers(unit, perm)
      --HealBot_setCall("HealBot_Panel_ToggelPrivateHealers", nil, nil, unit)
    local xGUID=UnitGUID(unit)
    if perm then
        if HealBot_Globals.PermPrivateHealers[xGUID] then
            HealBot_Globals.PermPrivateHealers[xGUID]=nil
        else
            HealBot_Globals.PermPrivateHealers[xGUID]=UnitName(unit) or "unKnown"
            HealBot_Panel_SetPermPrivateData(unit, xGUID)
        end
    else
        if HealBot_MyPrivateHealers[xGUID] then
            HealBot_MyPrivateHealers[xGUID]=nil
        else
            HealBot_MyPrivateHealers[xGUID]=true
        end
    end
    HealBot_Timers_Set("LAST","PrivateListUpdate")
    HealBot_Timers_setLuVars("ResetClassRank", true)
    --HealBot_Timers_Set("OOC","RefreshPartyNextRecalcAll")
end

function HealBot_Panel_ToggelPrivateDamagers(unit, perm)
      --HealBot_setCall("HealBot_Panel_ToggelPrivateDamagers", nil, nil, unit)
    local xGUID=UnitGUID(unit)
    if perm then
        if HealBot_Globals.PermPrivateDamagers[xGUID] then
            HealBot_Globals.PermPrivateDamagers[xGUID]=nil
        else
            HealBot_Globals.PermPrivateDamagers[xGUID]=UnitName(unit) or "unKnown"
            HealBot_Panel_SetPermPrivateData(unit, xGUID)
        end
    else
        if HealBot_MyPrivateDamagers[xGUID] then
            HealBot_MyPrivateDamagers[xGUID]=nil
        else
            HealBot_MyPrivateDamagers[xGUID]=true
        end
    end
    HealBot_Timers_Set("LAST","PrivateListUpdate",true)
    --HealBot_Timers_Set("OOC","RefreshPartyNextRecalcAll")
end

function HealBot_Panel_IsPrivateList(guid)
    return HealBot_MyHealTargets[guid] or HealBot_Globals.PermMyTargets[guid]
end

function HealBot_Panel_RetMyHealTarget(unit, perm)
      --HealBot_setCall("HealBot_Panel_RetMyHealTarget", nil, nil, unit)
    local xGUID=UnitGUID(unit) or unit
    if perm then
        return HealBot_Globals.PermMyTargets[xGUID]
    else
        return HealBot_MyHealTargets[xGUID]
    end
end

function HealBot_Panel_IsPrivateTank(guid)
    return HealBot_MyPrivateTanks[guid] or HealBot_Globals.PermPrivateTanks[guid]
end

function HealBot_Panel_RetPrivateTanks(unit, perm)
      --HealBot_setCall("HealBot_Panel_RetPrivateTanks", nil, nil, unit)
    local xGUID=UnitGUID(unit) or unit
    if perm then
        return HealBot_Globals.PermPrivateTanks[xGUID]
    else
        return HealBot_MyPrivateTanks[xGUID]
    end
end

function HealBot_Panel_IsPrivateHealer(guid)
    return HealBot_MyPrivateHealers[guid] or HealBot_Globals.PermPrivateHealers[guid]
end

function HealBot_Panel_RetPrivateHealers(unit, perm)
      --HealBot_setCall("HealBot_Panel_RetPrivateHealers", nil, nil, unit)
    local xGUID=UnitGUID(unit) or unit
    if perm then
        return HealBot_Globals.PermPrivateHealers[xGUID]
    else
        return HealBot_MyPrivateHealers[xGUID]
    end
end

function HealBot_Panel_IsPrivateDamager(guid)
    return HealBot_MyPrivateDamagers[guid] or HealBot_Globals.PermPrivateDamagers[guid]
end

function HealBot_Panel_RetPrivateDamagers(unit, perm)
      --HealBot_setCall("HealBot_Panel_RetPrivateDamagers", nil, nil, unit)
    local xGUID=UnitGUID(unit) or unit
    if perm then
        return HealBot_Globals.PermPrivateDamagers[xGUID]
    else
        return HealBot_MyPrivateDamagers[xGUID]
    end
end

function HealBot_Panel_retClassRoleIcon(id)
-- This can be removed post 11.1
      --HealBot_setCall("HealBot_Panel_retClassRoleIcon")
    return HealBot_Media_retClassRoleIcon(id)
end

function HealBot_Panel_classEN(unit)
      --HealBot_setCall("HealBot_Panel_classEN", nil, nil, unit)
    local classEN=HealBot_EnClass(unit)
    if classEN then
        return strsub(classEN,1,4)
    else
        return hbv_GetClass("En", HEALBOT_WARRIOR)
    end
end

function HealBot_Panel_CheckRole(unit)
      --HealBot_setCall("HealBot_Panel_CheckRole", nil, nil, unit)
    local classEN=HealBot_EnClass(unit)
    if classEN and not tClass[strsub(classEN,1,4)] then
        return "DAMAGER"
    end
    return "TANK"
end

function HealBot_Panel_UnitRole(unit, guid, isPlayer)
      --HealBot_setCall("HealBot_Panel_UnitRole", nil, guid)
    local role=hbPanel_dataRoles[guid]
    if role == HEALBOT_WORDS_UNKNOWN then
        --if HEALBOT_GAME_VERSION>2 then
            role=UnitGroupRolesAssigned(unit) or HEALBOT_WORDS_UNKNOWN
        --end
        hbPanel_dataRoles[guid]=role
    end
    if role == HEALBOT_WORDS_UNKNOWN then -- and isPlayer then
        role="DAMAGER"
    end
    return role
end

function HealBot_Panel_UnitRoleDefault(guid)
      --HealBot_setCall("HealBot_Panel_UnitRoleDefault", nil, guid)
    if hbPanel_dataRoles[guid] and (hbPanel_dataRoles[guid] == "TANK" or hbPanel_dataRoles[guid] == "HEALER") then
        return hbPanel_dataRoles[guid]
    else
        return "DAMAGER"
    end
end

function HealBot_Action_SetClassIconTexture(button)
      --HealBot_setCall("HealBot_Action_SetClassIconTexture", button)
    if UnitExists(button.unit) and hbv_Skins_GetFrameBoolean("Icons", "SHOWCLASS", button.frame) then
        local setRole=false
        local unitRole=HEALBOT_WORDS_UNKNOWN
        if hbv_Skins_GetFrameBoolean("Icons", "SHOWROLE", button.frame) then
            unitRole=HealBot_Panel_UnitRole(button.unit, button.guid, button.isplayer)
            if not HealBot_Media_retClassRoleIcon(unitRole) then
                unitRole="DAMAGER"
            end
            if HealBot_MainTanks[button.guid] or not hbv_Skins_GetFrameBoolean("Icons", "SHOWMTONLY", button.frame) then
                HealBot_Aura_ClassUpdate(button, unitRole)
            else
                HealBot_Aura_ClassUpdate(button, false)
            end
        elseif HealBot_MainTanks[button.guid] or not hbv_Skins_GetFrameBoolean("Icons", "SHOWMTONLY", button.frame) then
            HealBot_Aura_ClassUpdate(button, HealBot_Panel_classEN(button.unit))
        else
            HealBot_Aura_ClassUpdate(button, false)
        end
    else
        HealBot_Aura_ClassUpdate(button, false)
    end
end

HealBot_Panel_luVars["HealerHWM"]=1
function HealBot_Panel_CreateHeader(frame)
      --HealBot_setCall("HealBot_Panel_CreateHeader")
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
        local hhb=_G[hn]
        if not hhb then
            local hp=_G["f"..frame.."_HealBot_Action"]
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
      --HealBot_setCall("HealBot_Panel_ResetHeaders")
    for i=1,HealBot_Panel_luVars["HealerHWM"] do
        local hhb=_G["HealBot_Action_Header"..i]
        if hhb then hhb.frame=0 end
    end
end

function HealBot_Panel_DeleteHeader(hdrID, xHeader)
      --HealBot_setCall("HealBot_Panel_DeleteHeader")
    local hg=_G["HealBot_Action_Header"..hdrID]
    if hdrID<HealBot_ActiveHeaders[0] then HealBot_ActiveHeaders[0]=hdrID end
    hg:Hide();
    HealBot_ActiveHeaders[hdrID]=nil
    HealBot_Header_Frames[xHeader]=nil
end

function HealBot_Panel_retHealBot_Header_Frames()
      --HealBot_setCall("HealBot_Panel_retHealBot_Header_Frames")
    return HealBot_Header_Frames
end

local vPostFrameBF={}
function HealBot_Panel_ParentFrameID(frame)
      --HealBot_setCall("HealBot_Panel_ParentFrameID")
    vPostFrameBF[frame]=_G["f"..frame.."_HealBot_Action"]
end

function HealBot_Panel_InitFrame(frame, healGroup)
    hbCurrentFrame=frame
    hbCurrentHealGroup=healGroup
    hbPlayersTargetsHealGroupCount[healGroup]=0
    hbHealGroupFrames[healGroup]=frame
    if hbPanelResetRequired[frame] then
        hbPanelResetRequired[frame]=false
        HealBot_Panel_ResetBarHeightWidth(frame)
        for x,_ in pairs(hbPanelEnemyWidths[frame]) do
            hbPanelEnemyWidths[frame][x]=nil;
        end
        hbPanelEnemyWidths[frame][0]=0
    end
end

function HealBot_Panel_Anchor2ParentFrame(button, backFrame)
      --HealBot_setCall("HealBot_Panel_Anchor2ParentFrame", button)
    if hbv_Skins_GetFrameVar("Anchors", "BARS", button.frame) == 1 then
        backFrame:SetPoint("TOPLEFT",vPostFrameBF[button.frame],"TOPLEFT",5+backBarsSize[button.frame]["PAD"],-5+(0-backBarsSize[button.frame]["PAD"]));
    elseif hbv_Skins_GetFrameVar("Anchors", "BARS", button.frame) == 2 then
        backFrame:SetPoint("BOTTOMLEFT",vPostFrameBF[button.frame],"BOTTOMLEFT",5+backBarsSize[button.frame]["PAD"],5+backBarsSize[button.frame]["PAD"]);
    elseif hbv_Skins_GetFrameVar("Anchors", "BARS", button.frame) == 3 then
        backFrame:SetPoint("TOPRIGHT",vPostFrameBF[button.frame],"TOPRIGHT",-5+(0-backBarsSize[button.frame]["PAD"]),-5+(0-backBarsSize[button.frame]["PAD"]));
    else
        backFrame:SetPoint("BOTTOMRIGHT",vPostFrameBF[button.frame],"BOTTOMRIGHT",-5+(0-backBarsSize[button.frame]["PAD"]),5+backBarsSize[button.frame]["PAD"]);
    end
end

function HealBot_Panel_AnchorSpecialFrame(button, backFrame, relButton, newColumn, child)
      --HealBot_setCall("HealBot_Panel_AnchorSpecialFrame", button)
    if child then
        if hbv_Skins_GetFrameVar("Anchors", "BARS", button.frame)<3 then
            backFrame:SetPoint("LEFT",relButton,"RIGHT",backBarsSize[button.frame]["CMARGIN"],0)
        else
            backFrame:SetPoint("RIGHT",relButton,"LEFT",-backBarsSize[button.frame]["CMARGIN"],0)
        end
    elseif newColumn == 2 then
        if hbv_Skins_GetFrameVar("Anchors", "BARS", button.frame) == 1 then
            backFrame:SetPoint("TOPLEFT",relButton,"BOTTOMLEFT",0,-backBarsSize[button.frame]["RMARGIN"])
        elseif hbv_Skins_GetFrameVar("Anchors", "BARS", button.frame) == 2 then
            backFrame:SetPoint("BOTTOMLEFT",relButton,"TOPLEFT",0,backBarsSize[button.frame]["RMARGIN"])
        elseif hbv_Skins_GetFrameVar("Anchors", "BARS", button.frame) == 3 then
            backFrame:SetPoint("TOPRIGHT",relButton,"BOTTOMRIGHT",0,-backBarsSize[button.frame]["RMARGIN"])
        else
            backFrame:SetPoint("BOTTOMRIGHT",relButton,"TOPRIGHT",0,backBarsSize[button.frame]["RMARGIN"])
        end
    else
        if hbv_Skins_GetFrameVar("Anchors", "BARS", button.frame)<3 then
            backFrame:SetPoint("LEFT",relButton,"RIGHT",backBarsSize[button.frame]["S2WIDTH"]+backBarsSize[button.frame]["CMARGIN"],0)
        else
            backFrame:SetPoint("RIGHT",relButton,"LEFT",-(backBarsSize[button.frame]["S2WIDTH"]+backBarsSize[button.frame]["CMARGIN"]),0)
        end
    end
end

function HealBot_Panel_AnchorFrame(button, backFrame, relButton, newColumn, aWidth)
      --HealBot_setCall("HealBot_Panel_AnchorFrame")
    if newColumn == 2 then
        if hbv_Skins_GetFrameVar("Anchors", "BARS", button.frame) == 1 or
           hbv_Skins_GetFrameVar("Anchors", "BARS", button.frame) == 3 then
            backFrame:SetPoint("TOPLEFT",relButton,"BOTTOMLEFT",0,-backBarsSize[button.frame]["RMARGIN"])
        else
            backFrame:SetPoint("BOTTOMLEFT",relButton,"TOPLEFT",0,backBarsSize[button.frame]["RMARGIN"])
        end
    else
        if hbv_Skins_GetFrameVar("Anchors", "BARS", button.frame)<3 then
            backFrame:SetPoint("LEFT",relButton,"RIGHT",backBarsSize[button.frame]["CMARGIN"]+aWidth,0)
        else
            backFrame:SetPoint("RIGHT",relButton,"LEFT",0-(backBarsSize[button.frame]["CMARGIN"]+aWidth),0)
        end
    end
end

function HealBot_Panel_AnchorButton(button, backFrame, relButton, newColumn, child, aWidth)
      --HealBot_setCall("HealBot_Panel_AnchorButton", button)
    if not relButton then
        HealBot_Panel_Anchor2ParentFrame(button, backFrame)
    elseif backFrame~=relButton then
        if HealBot_EnemyUnits[button.unit] and HealBot_EnemyUnits[button.unit]>0 then
            HealBot_Panel_AnchorSpecialFrame(button, backFrame, relButton, newColumn, child)
        else
            HealBot_Panel_AnchorFrame(button, backFrame, relButton, newColumn, aWidth)
        end
    else
        HealBot_Panel_Anchor2ParentFrame(button, backFrame)
        HealBot_Timers_Set("OOC","RefreshPartyNextRecalcAll",true)
    end
end

function HealBot_Panel_UpdateHeadersOpacity()
      --HealBot_setCall("HealBot_Panel_UpdateHeadersOpacity")
    for _,header in pairs(HealBot_Header_Frames) do
        HealBot_Action_UpdateHeaderOpacity(header)
    end
end

local vSpecialAnchor={}
local eGUID,eButton,eFrame
function HealBot_Panel_PositionExtraButton(button, preCombat, frame, parent, pTarget, tot)
    eGUID=UnitGUID(button.unit.."target") or button.unit.."target"
    if pTarget then
        eFrame=frame
        if not tot and hbv_Skins_GetBoolean("Enemy", "TARUSEENEMYCOLS") then eFrame=10 end
        if tot and hbv_Skins_GetBoolean("Enemy", "TOTUSEENEMYCOLS") then eFrame=10 end
    else
        eFrame=10
    end
    if pTarget then
        if Healbot_Config_Skins.DuplicateBars[Healbot_Config_Skins.Current_Skin] and button.status.duplicate then
            eButton=HealBot_Action_SetHealButton(button.unit.."target",eGUID,frame,hbv_GetUnitType(HEALBOT_PRIVATETARGET),true,3,preCombat,eFrame)
        else
            eButton=HealBot_Action_SetHealButton(button.unit.."target",eGUID,frame,hbv_GetUnitType(HEALBOT_PLAYERTARGET),false,3,preCombat,eFrame)
        end
    else
        eButton=HealBot_Action_SetHealButton(button.unit.."target",eGUID,frame,hbv_GetUnitType(HEALBOT_ENEMY),false,3,preCombat,eFrame)
    end
    if eButton then
        --HealBot_TrackUnit[eButton.status.unittype][eButton.unit]=true
        HealBot_Panel_AnchorButton(eButton, eButton.gref["Back"], parent, 1, true, 0)
        eButton:ClearAllPoints()
        eButton:SetPoint("CENTER",eButton.gref["Bar"],"CENTER",0,0)
        HealBot_Panel_UnitShow(eButton, false, preCombat)
    end
    return eButton
end

function HealBot_Panel_PositionButton(button,xHeader,relButton,newColumn,preCombat,col)
      --HealBot_setCall("HealBot_Panel_PositionButton", button)
    if not hbPanelEnemyWidths[button.frame][col] then hbPanelEnemyWidths[button.frame][col]=0 end
    if xHeader then
        local vPosParentHF=HealBot_Header_Frames[xHeader]
        if not vPosParentHF then
            vPosParentHF=HealBot_Panel_CreateHeader(button.frame)
            HealBot_Header_Frames[xHeader]=vPosParentHF
            vPosParentHF.back=_G[vPosParentHF:GetName().."Bar5"]
            vPosParentHF.bar=_G[vPosParentHF:GetName().."Bar"]
            vPosParentHF.bar.txt=_G[vPosParentHF.bar:GetName().."_text"]
            vPosParentHF.bar.txt2=_G[vPosParentHF.bar:GetName().."_text2"]
        end
        if vPosParentHF.frame~=button.frame then
            vPosParentHF.parent=_G["f"..button.frame.."_HealBot_Action"]
            vPosParentHF:ClearAllPoints()
            vPosParentHF:SetParent(vPosParentHF.parent)
            vPosParentHF.frame=button.frame
            HealBot_Skins_ResetSkin("header",vPosParentHF)
        elseif HealBot_setTestBars then
            HealBot_Skins_ResetSkin("header",vPosParentHF)
        end
        if hbv_Skins_GetFrameVar("Anchors", "GROW", button.frame) == 1 then
            vPosParentHF.back:SetHeight(backBarsSize[button.frame]["HEIGHT"])
        else
            vPosParentHF.back:SetWidth(backBarsSize[button.frame]["HEADERWIDTH"])
        end
        HealBot_Track_Headers[xHeader]=true
        vPosParentHF.back:ClearAllPoints()
        if button.frame == 10 then
            HealBot_Panel_AnchorButton(button, vPosParentHF.back, relButton, newColumn, false, 0)
        else
            HealBot_Panel_AnchorButton(button, vPosParentHF.back, relButton, newColumn, false, hbPanelEnemyWidths[button.frame][col-1])
        end
        vPosParentHF.bar.txt:SetText(xHeader);
        vPosParentHF:Show();
        return vPosParentHF.back
    else

        button.Column=col
        if button.frame == 10 then
            HealBot_Panel_AnchorButton(button, button.gref["Back"], relButton, newColumn, false, 0)
            if HealBot_EnemyUnits[button.unit] and HealBot_EnemyUnits[button.unit]>0 then
                HealBot_Panel_PositionExtraButton(button, preCombat, 10, button.gref["Back"])
            end
        else
            if hbv_Skins_GetFrameBoolean("HeadBar", "SHOW", button.frame) then
                HealBot_Panel_AnchorButton(button, button.gref["Back"], relButton, newColumn, false, 0)
            else
                HealBot_Panel_AnchorButton(button, button.gref["Back"], relButton, newColumn, false, hbPanelEnemyWidths[button.frame][col-1])
               -- HealBot_AddDebug("Col "..col.." adj="..hbPanelEnemyWidths[button.frame][col-1].."  for id "..button.id,"Enemy",true)
            end
            if HealBot_UnitTargets[button.unit] then --and HealBot_UnitTargets[button.unit]>0 then
                xButton=HealBot_Panel_PositionExtraButton(button, preCombat, button.frame, button.gref["Back"], true, false)
                if xButton then
                    if HealBot_Skins_retColWidth(xButton.frame, xButton.id)>hbPanelEnemyWidths[button.frame][col] then
                        hbPanelEnemyWidths[button.frame][col]=HealBot_Skins_retColWidth(xButton.frame, xButton.id)
                    end
                    hbPlayersTargetsHealGroupCount[hbCurrentHealGroup]=hbPlayersTargetsHealGroupCount[hbCurrentHealGroup]+1
                    if HealBot_UnitTargets[xButton.unit] == 3 then
                        HealBot_Panel_PositionExtraButton(xButton, preCombat, xButton.frame, xButton.gref["Back"], true, true)
                    elseif HealBot_UnitTarget_Button[xButton.unit.."target"] or HealBot_PrivateTarget_Button[xButton.unit.."target"] then
                        HealBot_Panel_PlayersTargetsDelToTFrames(xButton.unit.."target")
                    end
                end
            end
        end

        button:ClearAllPoints()
        button:SetPoint("CENTER",button.gref["Bar"],"CENTER",0,0)
        return button.gref["Back"]
    end
end

function HealBot_Panel_SkinResetFrame(frame)
    backBarsSize[frame]["SKINRESET"]=true
end

function HealBot_Panel_SkinReset()
    for x=1,10 do
        HealBot_Panel_SkinResetFrame(x)
    end
end

function HealBot_Panel_ResetBarHeightWidth(frame)
    if backBarsSize[frame]["SKINRESET"] then
        backBarsSize[frame]["SKINRESET"]=false
        backBarsSize[frame]["MINWIDTH"]=0
        backBarsSize[frame]["MINHEADERWIDTH"]=0
    end
end

local EnemyPlayerTargetsInFrame=0
function HealBot_Action_SetBackBarHeightWidth(frame, height, width, pad, headerWidth)
      --HealBot_setCall("HealBot_Action_SetBackBarHeightWidth")
    local vSetAddHWScale=hbv_Skins_GetFrameVar("Frame", "SCALE", frame)
    backBarsSize[frame]["RMARGIN"]=ceil(hbv_Skins_GetFrameVar("HealBar", "RMARGIN", frame) * vSetAddHWScale)
    backBarsSize[frame]["CMARGIN"]=ceil(hbv_Skins_GetFrameVar("HealBar", "CMARGIN", frame) * vSetAddHWScale)
    if backBarsSize[frame]["HEIGHT"]~=height or backBarsSize[frame]["WIDTH"]~=width or backBarsSize[frame]["PAD"]~=pad or backBarsSize[frame]["HEADERWIDTH"]~=headerWidth then
        EnemyPlayerTargetsInFrame=0
        for x=1,10 do
            if hbHealGroupFrames[x] == frame then
                EnemyPlayerTargetsInFrame=EnemyPlayerTargetsInFrame+hbPlayersTargetsHealGroupCount[x]
            end
        end
        if backBarsSize[frame]["MINHEADERWIDTH"]<headerWidth or EnemyPlayerTargetsInFrame == 0 then
            backBarsSize[frame]["MINHEADERWIDTH"]=headerWidth
            backBarsSize[frame]["HEADERWIDTH"]=headerWidth
        end
        if backBarsSize[frame]["HEIGHT"]~=height or backBarsSize[frame]["WIDTH"]~=width or backBarsSize[frame]["PAD"]~=pad then
              --  HealBot_AddDebug("MINWIDTH="..backBarsSize[frame]["MINWIDTH"].."  WIDTH="..backBarsSize[frame]["WIDTH"].."  width="..width,"Enemy",true)
            if backBarsSize[frame]["MINWIDTH"]<width or EnemyPlayerTargetsInFrame == 0 then
                backBarsSize[frame]["MINWIDTH"]=width
                backBarsSize[frame]["WIDTH"]=width
            end
            backBarsSize[frame]["HEIGHT"]=height
            backBarsSize[frame]["PAD"]=pad
            return true
        else
            return false
        end
    else
        return false
    end
end

function HealBot_Action_SetBackSpecialWidth(frame, width)
      --HealBot_setCall("HealBot_Action_SetBackSpecialWidth")
    backBarsSize[frame]["S2WIDTH"]=width
end

function HealBot_Action_SetBackHeaderHeightWidth(frame, height, width)
      --HealBot_setCall("HealBot_Action_SetBackHeaderHeightWidth")
    backBarsSize[frame]["HEADHEIGHT"]=height
    backBarsSize[frame]["HEADWIDTH"]=width
end

local HealBot_Panel_initFrame={[1]=true,[2]=true,[3]=true,[4]=true,[5]=true,[6]=true,[7]=true,[8]=true,[9]=true,[10]=true}
function HealBot_Panel_resetInitFrames()
      --HealBot_setCall("HealBot_Panel_resetInitFrames")
    for j=1,10 do
        HealBot_Panel_initFrame[j]=true
    end
end

local vSetHWFrame,vSetHWextraHeight,vSetHWextraWidth="",0,0
function HealBot_Action_SetHeightWidth(numRows,numCols,numHeaders,frame)
      --HealBot_setCall("HealBot_Action_SetHeightWidth")
    vSetHWFrame=_G["f"..frame.."_HealBot_Action"]
    vSetHWextraHeight=10
    vSetHWextraWidth=10
    if hbOptionOn == frame then
        vSetHWextraHeight=vSetHWextraHeight+30
    end
    if hbMoveMe == frame then
        vSetHWextraHeight=vSetHWextraHeight+20
    end
    if hbFocusOn == frame then
        vSetHWextraHeight=vSetHWextraHeight+10+ceil(hbv_Skins_GetFrameVar("HealBar", "HEIGHT", frame)*hbv_Skins_GetFrameVar("Frame", "SCALE", frame))
    end
    if numHeaders>0 then
        if hbv_Skins_GetFrameVar("Anchors", "GROW", frame) == 1 then
            vSetHWextraWidth=vSetHWextraWidth+(backBarsSize[frame]["HEADWIDTH"]*numHeaders)
        else
            vSetHWextraHeight=vSetHWextraHeight+(backBarsSize[frame]["HEADHEIGHT"]*numHeaders)
        end
    end
    --HealBot_AddDebug("backBarsSize WIDTH for frame"..frame.." is "..backBarsSize[frame]["WIDTH"],"Enemy",true)
    vSetHWextraHeight=vSetHWextraHeight+(hbv_Skins_GetFrameVar("Frame", "PADDING", frame)*2)
    vSetHWextraWidth=vSetHWextraWidth+(hbv_Skins_GetFrameVar("Frame", "PADDING", frame)*2)
    if hbv_Skins_GetFrameVar("Anchors", "GROW", frame) == 1 then
        vSetHWFrame:SetHeight(vSetHWextraHeight+(backBarsSize[frame]["HEIGHT"]*numCols)+(backBarsSize[frame]["RMARGIN"]*(numCols-1)))
        vSetHWFrame:SetWidth(vSetHWextraWidth+(backBarsSize[frame]["WIDTH"]*numRows)+(backBarsSize[frame]["CMARGIN"]*((numHeaders+numRows-1))))
    else
        vSetHWFrame:SetHeight(vSetHWextraHeight+(backBarsSize[frame]["HEIGHT"]*numRows)+(backBarsSize[frame]["RMARGIN"]*((numHeaders+numRows-1))))
        vSetHWFrame:SetWidth(vSetHWextraWidth+(backBarsSize[frame]["WIDTH"]*numCols)+(backBarsSize[frame]["CMARGIN"]*(numCols-1)))
    end
    if HealBot_Panel_initFrame[frame] then
        HealBot_Panel_initFrame[frame]=false
        HealBot_Action_FrameSetPoint(frame, vSetHWFrame)
    end
    HealBot_Action_setPoint(frame)
end

function HealBot_Panel_TestBarsOff()
      --HealBot_setCall("HealBot_Panel_TestBarsOff")
    for x,b in pairs(HealBot_TestBarsActive) do
        for id=1,12 do
            HealBot_Action_ClearTestIcon(b, id)
        end
        for id=51,60 do
            HealBot_Action_ClearTestIcon(b, id)
        end
        b:Hide()
        HealBot_Emerg_Button[b.id]:Hide()
        HealBot_TestBarsActive[x]=nil
    end
end

function HealBot_Panel_ToggleTestBars(preCombat)
      --HealBot_setCall("HealBot_Panel_ToggleTestBars")
    if preCombat or HealBot_setTestBars then
        HealBot_setTestBars=false
        for j=1,10 do
            HealBot_Action_HidePanel(j, true)
        end
        HealBot_Panel_TestBarsOff()
        HealBot_Options_TestBarsButton:SetText(HEALBOT_OPTIONS_TURNTESTBARSON)
        HealBot_Action_setLuVars("TestBarsOn", false)
        HealBot_Text_setLuVars("TestBarsOn", false)
        HealBot_Aux_setLuVars("TestBarsOn", false)
        HealBot_Aura_setLuVars("TestBarsOn", false)
        HealBot_Update_setLuVars("TestBarsOn", false)
        HealBot_TestBarsState(false)
        HealBot_Options_setLuVars("TestBarsOn", false)
        HealBot_Skins_isTestBars(false)
        HealBot_Timers_Set("AURA","ClearAllBuffs")
        HealBot_Timers_Set("AURA","ClearAllDebuffs")
        HealBot_Timers_Set("LAST","CheckAutoClose",true)
        --HealBot_setTestCols={}
    else
        HealBot_Action_setLuVars("TestBarsOn", true)
        HealBot_Text_setLuVars("TestBarsOn", true)
        HealBot_Aux_setLuVars("TestBarsOn", true)
        HealBot_Aura_setLuVars("TestBarsOn", true)
        HealBot_Update_setLuVars("TestBarsOn", true)
        HealBot_TestBarsState(true)
        HealBot_Options_setLuVars("TestBarsOn", true)
        HealBot_Skins_isTestBars(true)
        HealBot_setTestBars=true
        HealBot_Panel_luVars["TestBarsDelAll"]=true
        HealBot_Options_TestBarsButton:SetText(HEALBOT_OPTIONS_TURNTESTBARSOFF)
    end
    --HealBot_Options_framesChanged(true, true, true, true, true)
    HealBot_Timers_Set("AUX","UpdateAllAuxByType")
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
local maxRows={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}
local maxCols={[1]=1,[2]=1,[3]=1,[4]=1,[5]=1,[6]=1,[7]=1,[8]=1,[9]=1,[10]=1}
local maxHeaders={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,[6]=0,[7]=0,[8]=0,[9]=0,[10]=0}
local rowNo={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,[6]=0,[7]=0,[8]=0,[9]=0,[10]=0}
local barNo={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,[6]=0,[7]=0,[8]=0,[9]=0,[10]=0}
local headerNo={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,[6]=0,[7]=0,[8]=0,[9]=0,[10]=0}
local hbAnchoredButtons={}
function HealBot_Panel_PositionBars(preCombat)
      --HealBot_setCall("HealBot_Panel_PositionBars")
    local newCol=1
    local sameCol=2
    local emtarPrev=false
    for x,_ in pairs(hbAnchoredButtons) do
        hbAnchoredButtons[x]=nil
    end
    table.foreach(HealBot_Action_HealButtons, function (x,xUnitData)
        local xUnit,xUnitType=string.split("~", xUnitData)
        xUnitType=tonumber(xUnitType)
        if HealBot_setTestBars then
            vPosButton=HealBot_Test_Button[xUnit] or "nil"
        elseif xUnitType<10 then
            vPosButton=HealBot_Private_Button[xUnit] or "nil"
        elseif hbv_IsUnitType(xUnitType, HEALBOT_PRIVATETARGET) then
            vPosButton=HealBot_PrivateTarget_Button[xUnit] or "nil"
        elseif hbv_IsUnitType(xUnitType, HEALBOT_PLAYERTARGET) then
            vPosButton=HealBot_UnitTarget_Button[xUnit] or "nil"
        elseif hbv_IsUnitType(xUnitType, HEALBOT_ENEMY) then
            vPosButton=HealBot_Enemy_Button[xUnit] or "nil"
        elseif hbv_IsUnitType(xUnitType, HEALBOT_PET) then
            vPosButton=HealBot_Pet_Button[xUnit] or "nil"
        elseif hbv_IsUnitType(xUnitType, HEALBOT_VEHICLE) then
            vPosButton=HealBot_Vehicle_Button[xUnit] or "nil"
        elseif xUnitType>30 then
            vPosButton=HealBot_Extra_Button[xUnit] or "nil"
        else
            vPosButton=HealBot_Unit_Button[xUnit] or "nil"
        end
        if vPosButton~="nil" and hbBarsPerFrame[vPosButton.frame] and not hbAnchoredButtons[vPosButton.id] then
            hbAnchoredButtons[vPosButton.id]=true
            vFrame=vPosButton.frame
            rowNo[vFrame]=rowNo[vFrame]+1
            barNo[vFrame]=barNo[vFrame]+1
            if hbv_Skins_GetFrameVar("Anchors", "GROW", vFrame) == 1 then
                newCol=2
                sameCol=1
            else
                newCol=1
                sameCol=2
            end
            if hbv_Skins_GetFrameBoolean("HeadBar", "SHOW", vFrame) then
                if HeaderPos[vFrame][barNo[vFrame]] then
                    headerNo[vFrame]=headerNo[vFrame]+1
                    if barNo[vFrame] == 1 then
                        if hbv_Skins_GetFrameVar("Anchors", "GROW", vFrame) == 1 then
                            vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vPosButton,HeaderPos[vFrame][barNo[vFrame]],false,sameCol,preCombat, rowNo[vFrame])
                        else
                            vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vPosButton,HeaderPos[vFrame][barNo[vFrame]],false,sameCol,preCombat, maxCols[vFrame])
                        end
                        vBar[vFrame]["PREVCOL"]=vBar[vFrame]["PREVROW"]
                    elseif headerNo[vFrame]>hbv_Skins_GetFrameVar("HealBar", "NUMCOLS", vFrame) then
                        maxCols[vFrame]=maxCols[vFrame]+1
                        headerNo[vFrame]=1
                        rowNo[vFrame]=1
                        if hbv_Skins_GetFrameVar("Anchors", "GROW", vFrame) == 1 then
                            vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vPosButton,HeaderPos[vFrame][barNo[vFrame]],vBar[vFrame]["PREVCOL"],newCol,preCombat, rowNo[vFrame])
                        else
                            vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vPosButton,HeaderPos[vFrame][barNo[vFrame]],vBar[vFrame]["PREVCOL"],newCol,preCombat, maxCols[vFrame])
                        end
                        vBar[vFrame]["PREVCOL"]=vBar[vFrame]["PREVROW"]
                    elseif hbv_Skins_GetFrameVar("Anchors", "GROW", vFrame) == 1 then
                            vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vPosButton,HeaderPos[vFrame][barNo[vFrame]],vBar[vFrame]["PREVROW"],sameCol,preCombat, rowNo[vFrame])
                    else
                        vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vPosButton,HeaderPos[vFrame][barNo[vFrame]],vBar[vFrame]["PREVROW"],sameCol,preCombat, maxCols[vFrame])
                    end
                end
                if rowNo[vFrame]>maxRows[vFrame][1] then
                    maxRows[vFrame][1]=rowNo[vFrame]
                end
                if headerNo[vFrame]>maxHeaders[vFrame] then
                    maxHeaders[vFrame]=headerNo[vFrame]
                end
                if hbv_Skins_GetFrameVar("Anchors", "GROW", vFrame) == 1 then
                    vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vPosButton,false,vBar[vFrame]["PREVROW"],sameCol,preCombat, rowNo[vFrame])
                else
                    vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vPosButton,false,vBar[vFrame]["PREVROW"],sameCol,preCombat, maxCols[vFrame])
                end
            elseif hbv_Skins_GetFrameBoolean("HealBar", "GRPCOLS", vFrame) then
                if HeaderPos[vFrame][barNo[vFrame]] then
                    headerNo[vFrame]=headerNo[vFrame]+1
                end
                if barNo[vFrame] == 1 then
                    if hbv_Skins_GetFrameVar("Anchors", "GROW", vFrame) == 1 then
                        vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vPosButton,false,false,sameCol,preCombat, rowNo[vFrame])
                    else
                        vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vPosButton,false,false,sameCol,preCombat, maxCols[vFrame])
                    end
                    vBar[vFrame]["PREVCOL"]=vBar[vFrame]["PREVROW"]
                elseif headerNo[vFrame]>hbv_Skins_GetFrameVar("HealBar", "NUMCOLS", vFrame) then
                    maxCols[vFrame]=maxCols[vFrame]+1
                    headerNo[vFrame]=1
                    rowNo[vFrame]=1
                    if hbv_Skins_GetFrameVar("Anchors", "GROW", vFrame) == 1 then
                        vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vPosButton,false,vBar[vFrame]["PREVCOL"],newCol,preCombat, rowNo[vFrame])
                    else
                        vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vPosButton,false,vBar[vFrame]["PREVCOL"],newCol,preCombat, maxCols[vFrame])
                    end
                    vBar[vFrame]["PREVCOL"]=vBar[vFrame]["PREVROW"]
                elseif hbv_Skins_GetFrameVar("Anchors", "GROW", vFrame) == 1 then
                    vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vPosButton,false,vBar[vFrame]["PREVROW"],sameCol,preCombat, rowNo[vFrame])
                else
                    vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vPosButton,false,vBar[vFrame]["PREVROW"],sameCol,preCombat, maxCols[vFrame])
                end
                if rowNo[vFrame]>maxRows[vFrame][1] then
                    maxRows[vFrame][1]=rowNo[vFrame]
                end
            else
                if barNo[vFrame] == 1 or rowNo[vFrame]>(maxRows[vFrame][maxCols[vFrame]] or rowNo[vFrame]) then
                    rowNo[vFrame]=1
                    if barNo[vFrame] == 1 then
                        if hbv_Skins_GetFrameVar("Anchors", "GROW", vFrame) == 1 then
                            vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vPosButton,false,false,sameCol,preCombat, rowNo[vFrame])
                        else
                            vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vPosButton,false,false,sameCol,preCombat, maxCols[vFrame])
                        end
                    else
                        maxCols[vFrame]=maxCols[vFrame]+1
                        if hbv_Skins_GetFrameVar("Anchors", "GROW", vFrame) == 1 then
                            vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vPosButton,false,vBar[vFrame]["PREVCOL"],newCol,preCombat, rowNo[vFrame])
                        else
                            vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vPosButton,false,vBar[vFrame]["PREVCOL"],newCol,preCombat, maxCols[vFrame])
                        end
                    end
                    vBar[vFrame]["PREVCOL"]=vBar[vFrame]["PREVROW"]
                elseif hbv_Skins_GetFrameVar("Anchors", "GROW", vFrame) == 1 then
                    vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vPosButton,false,vBar[vFrame]["PREVROW"],sameCol,preCombat, rowNo[vFrame])
                else
                    vBar[vFrame]["PREVROW"]=HealBot_Panel_PositionButton(vPosButton,false,vBar[vFrame]["PREVROW"],sameCol,preCombat, maxCols[vFrame])
                end
            end
        elseif vPosButton.id and hbAnchoredButtons[vPosButton.id] then
            HealBot_Timers_Set("OOC","RefreshPartyNextRecalcAll",true)
            HealBot_AddDebug("AnchorButton button and relButton as the same - unit="..(xUnit or "nil"), "Panel", true)
        end
    end)
end

local vSetupFrameTag, vSetupBarsOptionsParent, vSetupBarsMaxRows, vSetupBarsOverflow=nil, nil, 1, 0
function HealBot_Panel_SetupExtraBars(frame, preCombat)
      --HealBot_setCall("HealBot_Panel_SetupExtraBars")
    if hbv_Skins_GetFrameBoolean("HeadBar", "SHOW", frame) or
       hbv_Skins_GetFrameBoolean("HealBar", "GRPCOLS", frame) then
        maxRows[frame][1]=1
    else
        vSetupBarsMaxRows=floor(hbBarsPerFrame[frame]/hbv_Skins_GetFrameVar("HealBar", "NUMCOLS", frame))
        vSetupBarsOverflow=hbBarsPerFrame[frame]-(vSetupBarsMaxRows*hbv_Skins_GetFrameVar("HealBar", "NUMCOLS", frame))
        for x=1,hbv_Skins_GetFrameVar("HealBar", "NUMCOLS", frame) do
            if x<=vSetupBarsOverflow then
                maxRows[frame][x]=vSetupBarsMaxRows+1
            else
                maxRows[frame][x]=vSetupBarsMaxRows
            end
        end
    end
    barNo[frame]=0
    rowNo[frame]=0
    headerNo[frame]=0
    maxHeaders[frame]=0
    maxCols[frame]=1
    vBar[frame]["PREVROW"]=nil
    vBar[frame]["PREVCOL"]=nil
    HealBot_Panel_PositionBars(preCombat)

    hbPanelNoCols[frame]=maxCols[frame]
    hbPanelNoRows[frame]=maxRows[frame][1]

    for xHeader,xButton in pairs(HealBot_Header_Frames) do
        if xButton.frame == frame and not HealBot_Track_Headers[xHeader] then
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
            if hbv_Skins_GetFrameVar("Anchors", "BARS", frame) == 2 or hbv_Skins_GetFrameVar("Anchors", "BARS", frame) == 4 then
                vSetupFrameTag:SetPoint("TOP",vSetupBarsOptionsParent,"TOP",0,-8)
            else
                vSetupFrameTag:SetPoint("BOTTOM",vSetupBarsOptionsParent,"BOTTOM",0,8)
            end
            vSetupFrameTag:SetText(HEALBOT_ACTION_UNLOCKED)
        else
            vSetupFrameTag:SetText("")
        end
        if HealBot_Config.DisabledNow == 0 then
            HealBot_Action_SetHeightWidth(maxRows[frame][1],maxCols[frame],maxHeaders[frame],frame)
            if HealBot_setTestBars or (HealBot_AutoCloseFrame[frame] == 1 or preCombat) then
                HealBot_Action_ShowPanel(frame)
            end
            HealBot_Action_setFrameHeader(frame)
        else
            HealBot_Action_HidePanel(frame)
        end
        if not HealBot_setTestBars then
            if HealBot_AutoCloseFrame[frame]>1 then
                HealBot_CheckActiveFrames(frame, true)
            else
                HealBot_CheckActiveFrames(frame, false)
            end
        end
    else
        HealBot_Action_HidePanel(frame)
        if not HealBot_setTestBars then
            HealBot_CheckActiveFrames(frame, false)
        end
    end
end

local vSetupBarsOptionsFrame=nil
function HealBot_Panel_SetupBars(preCombat)
      --HealBot_setCall("HealBot_Panel_SetupBars")
    for j=1,5 do
        if hbBarsPerFrame[j] and hbBarsPerFrame[j]>0 then
            if hbv_Skins_GetFrameBoolean("HeadBar", "SHOW", j) or
               hbv_Skins_GetFrameBoolean("HealBar", "GRPCOLS", j) then
                maxRows[j][1]=1
            else
                vSetupBarsMaxRows=floor(hbBarsPerFrame[j]/hbv_Skins_GetFrameVar("HealBar", "NUMCOLS", j))
                vSetupBarsOverflow=hbBarsPerFrame[j]-(vSetupBarsMaxRows*hbv_Skins_GetFrameVar("HealBar", "NUMCOLS", j))
                for x=1,hbv_Skins_GetFrameVar("HealBar", "NUMCOLS", j) do
                    if x<=vSetupBarsOverflow then
                        maxRows[j][x]=vSetupBarsMaxRows+1
                    else
                        maxRows[j][x]=vSetupBarsMaxRows
                    end
                end
            end
        end
    end
    for j=1,5 do
        barNo[j]=0
        rowNo[j]=0
        headerNo[j]=0
        maxHeaders[j]=0
        maxCols[j]=1
        vBar[j]["PREVROW"]=nil
        vBar[j]["PREVCOL"]=nil
    end

    HealBot_Panel_PositionBars(preCombat)

    for j=1,5 do
        hbPanelNoCols[j]=maxCols[j]
        hbPanelNoRows[j]=maxRows[j][1]
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
                if hbv_Skins_GetFrameVar("Anchors", "BARS", j) == 2 or hbv_Skins_GetFrameVar("Anchors", "BARS", j) == 4 then
                    vSetupFrameTag:SetPoint("TOP",vSetupBarsOptionsParent,"TOP",0,-8)
                else
                    vSetupFrameTag:SetPoint("BOTTOM",vSetupBarsOptionsParent,"BOTTOM",0,8)
                end
                vSetupFrameTag:SetText(HEALBOT_ACTION_UNLOCKED)
            else
                vSetupFrameTag:SetText("")
            end
            if vSetupBarsFrame == 0 then
                vSetupBarsFrame=j
            end
            if not HealBot_setTestBars then
                if HealBot_AutoCloseFrame[j]>1 then
                    HealBot_CheckActiveFrames(j, true)
                else
                    HealBot_CheckActiveFrames(j, false)
                end
            end
        elseif not HealBot_setTestBars then
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
        vSetupBarsOptionsFrame:ClearAllPoints()
        if vSetupBarsOptionsFrame.frame~=vSetupBarsFrame then
            vSetupBarsOptionsFrame:Hide()
            vSetupBarsOptionsFrame:SetParent(vSetupBarsOptionsParent)
            vSetupBarsOptionsFrame.frame=vSetupBarsFrame
            local oWidth=ceil(backBarsSize[vSetupBarsFrame]["WIDTH"]*0.95)
            if oWidth>70 then oWidth=70 end
            vSetupBarsOptionsFrame:SetWidth(oWidth)
            vSetupBarsOptionsFrame:SetHeight(25)
        end
        if hbv_Skins_GetFrameVar("Anchors", "BARS", vSetupBarsFrame) == 2 or hbv_Skins_GetFrameVar("Anchors", "BARS", vSetupBarsFrame) == 4 then
            if hbMoveMe == vSetupBarsFrame then
                vSetupBarsOptionsFrame:SetPoint("TOP",vSetupBarsOptionsParent,"TOP",0,-22);
            else
                vSetupBarsOptionsFrame:SetPoint("TOP",vSetupBarsOptionsParent,"TOP",0,-2);
            end
        else
            if hbMoveMe == vSetupBarsFrame then
                vSetupBarsOptionsFrame:SetPoint("BOTTOM",vSetupBarsOptionsParent,"BOTTOM",0,27);
            else
                vSetupBarsOptionsFrame:SetPoint("BOTTOM",vSetupBarsOptionsParent,"BOTTOM",0,7);
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
            if HealBot_Config.DisabledNow == 0 then
                HealBot_Text_setTextLen(j)
                if HealBot_setTestBars or (HealBot_AutoCloseFrame[j] == 1 or preCombat) then
                    HealBot_Action_ShowPanel(j)
                end
                HealBot_Action_SetHeightWidth(maxRows[j][1],maxCols[j],maxHeaders[j],j)
                HealBot_Action_setFrameHeader(j)
            else
                HealBot_Action_HidePanel(j)
            end
        else
            HealBot_Action_HidePanel(j)
        end
    end
end

function HealBot_Panel_InitOptBars()
      --HealBot_setCall("HealBot_Panel_InitOptBars")
    vSetupBarsOptionsFrame=_G["HealBot_Action_OptionsButton"]
    if not vSetupBarsOptionsFrame then
        vSetupBarsOptionsParent=_G["f1_HealBot_Action"]
        vSetupBarsOptionsFrame=CreateFrame("Button", "HealBot_Action_OptionsButton", vSetupBarsOptionsParent, "HealBotOptionsButtonTemplate")
        local bar=_G[vSetupBarsOptionsFrame:GetName().."Bar"]
        bar:SetStatusBarColor(0.1,0.1,0.4,0);
        bar:SetMinMaxValues(0,100);
        bar:SetValue(0);
        bar:UnregisterAllEvents()
        vSetupBarsOptionsFrame.frame=0
        bar.txt=_G[bar:GetName().."_text"];
        HealBot_Media_UpdateDefaultFont(bar.txt, 12, 1, "Panel_InitOptBars")
        bar.txt:SetPoint("CENTER",0,-2)
        bar.txt:SetTextColor(0.8,0.8,0.2,0.85);
        bar.txt:SetText(HEALBOT_ACTION_OPTIONS);
        bar=_G[vSetupBarsOptionsFrame:GetName().."Bar5"]
        bar:SetStatusBarColor(0.1,0.1,0.4,0);
        bar:SetMinMaxValues(0,100);
        bar:SetValue(0);
        bar:UnregisterAllEvents()
        vSetupBarsOptionsFrame:Hide()
    end
end

function HealBot_Panel_RandomClassColour(tRole,bClass)
      --HealBot_setCall("HealBot_Panel_RandomClassColour")
    if bClass then
        HealBot_randomN=bClass
    else
        local newCol=1
        while newCol>0 do
            if not tRole then
                HealBot_randomN=random(HealBot_randomClCol[0]["MAX"])
            elseif tRole == HEALBOT_WORD_HEALER then
                HealBot_randomN=random(HealBot_randomClCol[0]["HS"],HealBot_randomClCol[0]["HE"])
            else
                HealBot_randomN=random(1,HealBot_randomClCol[0]["TE"])
            end
            if HealBot_randomN~=prevCol then
                prevCol=HealBot_randomN
                newCol=0
            end
        end
    end
    return HealBot_randomClCol[HealBot_randomN][1],
           HealBot_randomClCol[HealBot_randomN][2],
           HealBot_randomClCol[HealBot_randomN][3],
           HealBot_randomClCol[HealBot_randomN][4],
           HealBot_randomClCol[HealBot_randomN][5],
           HealBot_randomClCol[HealBot_randomN][6],
           HealBot_randomClCol[HealBot_randomN][7]
end

local RandomClassesAdj={}
local rndClasses={}
local curClass,tRnd=1,0
local numNotSet=0
function HealBot_Panel_RandomClassesRun()
      --HealBot_setCall("HealBot_Panel_RandomClassesRun")
    for z=1,numNotSet do
        if numNotSet>0 then
            tRnd=random(5)
            local tClass=random(HealBot_randomClCol[0]["MAX"])
            if tRnd>RandomClassesAdj[tClass] then
                rndClasses[tClass]=rndClasses[tClass]+1
                numNotSet=numNotSet-1
                if RandomClassesAdj[tClass]<4 then
                    RandomClassesAdj[tClass]=RandomClassesAdj[tClass]+2
                else
                    RandomClassesAdj[tClass]=5
                end
            elseif RandomClassesAdj[tClass]>1 then
                RandomClassesAdj[tClass]=RandomClassesAdj[tClass]-1
            end
        else
            break
        end
    end
end

function HealBot_Panel_RandomClasses(nUnits)
      --HealBot_setCall("HealBot_Panel_RandomClasses")
    for z=1,HealBot_randomClCol[0]["MAX"] do
        RandomClassesAdj[z]=3
        rndClasses[z]=0
    end
    curClass=1
    numNotSet=nUnits
    for x=1,20 do
        if numNotSet>0 then
            HealBot_Panel_RandomClassesRun()
        else
            break
        end
    end
    return rndClasses
end

function HealBot_Panel_TestBarColUpdate(button)
      --HealBot_setCall("HealBot_Panel_TestBarColUpdate")
    --for _,xButton in pairs(HealBot_Test_Button) do
        button.gref["Bar"]:SetStatusBarColor(HealBot_colIndex["hcr"..button.id],HealBot_colIndex["hcg"..button.id],HealBot_colIndex["hcb"..button.id],1);
        button.gref.txt["text"]:SetTextColor(HealBot_colIndex["hctr"..button.id],HealBot_colIndex["hctg"..button.id],HealBot_colIndex["hctb"..button.id],1);
        button.gref.txt["text2"]:SetTextColor(HealBot_colIndex["hctr2"..button.id],HealBot_colIndex["hctg2"..button.id],HealBot_colIndex["hctb2"..button.id],1);
        button.gref.txt["text3"]:SetTextColor(HealBot_colIndex["hctr3"..button.id],HealBot_colIndex["hctg3"..button.id],HealBot_colIndex["hctb3"..button.id],1)
        button.gref.txt["text4"]:SetTextColor(HealBot_colIndex["hctr4"..button.id],HealBot_colIndex["hctg4"..button.id],HealBot_colIndex["hctb4"..button.id],1)
        button.gref.txt["text5"]:SetTextColor(HealBot_colIndex["hctr2"..button.id],HealBot_colIndex["hctg2"..button.id],HealBot_colIndex["hctb2"..button.id],1);
    --end
end

local hbCustomRoleCols={["TANK"]={}, ["HEALER"]={}, ["DAMAGER"]={}}
function HealBot_Panel_SetCustomRoleCols()
      --HealBot_setCall("HealBot_Panel_SetCustomRoleCols")
    hbCustomRoleCols["TANK"].r,hbCustomRoleCols["TANK"].g, hbCustomRoleCols["TANK"].b=hbv_Skins_GetRoleCol("TANK", HealBot_Globals.OverrideColours["USEROLE"])
    hbCustomRoleCols["HEALER"].r,hbCustomRoleCols["HEALER"].g, hbCustomRoleCols["HEALER"].b=hbv_Skins_GetRoleCol("HEALER", HealBot_Globals.OverrideColours["USEROLE"])
    hbCustomRoleCols["DAMAGER"].r,hbCustomRoleCols["DAMAGER"].g, hbCustomRoleCols["DAMAGER"].b=hbv_Skins_GetRoleCol("DAMAGER", HealBot_Globals.OverrideColours["USEROLE"])
end

local hbHealButtonsConcat={[1]="", [2]="~", [3]="1"}
function HealBot_Panel_TestBarShow(index,button,tRole,r,g,b,tpR,tpG,tpB)
      --HealBot_setCall("HealBot_Panel_TestBarShow")
    hbHealButtonsConcat[1]=button.unit
    hbHealButtonsConcat[3]="5"
    table.insert(HealBot_Action_HealButtons,table.concat(hbHealButtonsConcat))
    --HealBot_TrackUnit[hbv_GetUnitType(HEALBOT_RAID)][button.unit]=true
    HealBot_TestBarsActive[index]=button
    if not HealBot_setTestCols[index] or button.reset then
        HealBot_setTestCols[index]=true
        if button.reset then
            button.text.r,button.text.g,button.text.b=r,g,b
            HealBot_colIndex["hctr5"..index],HealBot_colIndex["hctg5"..index],HealBot_colIndex["hctb5"..index]=tpR,tpG,tpB
        else
            r,g,b=button.text.r,button.text.g,button.text.b
            HealBot_colIndex["hctr5"..index]=HealBot_colIndex["hctr5"..index] or tpR
            HealBot_colIndex["hctg5"..index]=HealBot_colIndex["hctg5"..index] or tpG
            HealBot_colIndex["hctb5"..index]=HealBot_colIndex["hctb5"..index] or tpB
        end
        button.reset=false
        if not hbCustomRoleCols[button.roletxt] then button.roletxt="DAMAGER" end

        if hbv_Skins_GetFrameVar("BarCol", "HLTH", button.frame) == 2 or
           hbv_Skins_GetFrameVar("BarCol", "HLTH", button.frame) == 5 then
            HealBot_colIndex["hcr"..index],HealBot_colIndex["hcg"..index],HealBot_colIndex["hcb"..index]=r,g,b
        elseif hbv_Skins_GetFrameVar("BarCol", "HLTH", button.frame) == 1 then
            HealBot_colIndex["hcr"..index],HealBot_colIndex["hcg"..index],HealBot_colIndex["hcb"..index]=0,1,0
        elseif hbv_Skins_GetFrameVar("BarCol", "HLTH", button.frame) == 4 then
            HealBot_colIndex["hcr"..index]=hbv_Skins_GetFrameVar("BarCol", "HR", button.frame)
            HealBot_colIndex["hcg"..index]=hbv_Skins_GetFrameVar("BarCol", "HG", button.frame)
            HealBot_colIndex["hcb"..index]=hbv_Skins_GetFrameVar("BarCol", "HB", button.frame)
        else
            HealBot_colIndex["hcr"..index]=hbCustomRoleCols[button.roletxt].r
            HealBot_colIndex["hcg"..index]=hbCustomRoleCols[button.roletxt].g
            HealBot_colIndex["hcb"..index]=hbCustomRoleCols[button.roletxt].b
        end

        if hbv_Skins_GetFrameVar("BarTextCol", "NAME", button.frame) == 2 or
           hbv_Skins_GetFrameVar("BarTextCol", "NAME", button.frame) == 5 then
            HealBot_colIndex["hctr"..index],HealBot_colIndex["hctg"..index],HealBot_colIndex["hctb"..index]=r,g,b
        elseif hbv_Skins_GetFrameVar("BarTextCol", "NAME", button.frame) == 1 then
            HealBot_colIndex["hctr"..index],HealBot_colIndex["hctg"..index],HealBot_colIndex["hctb"..index]=0,1,0
        elseif hbv_Skins_GetFrameVar("BarTextCol", "NAME", button.frame) == 4 then
            HealBot_colIndex["hctr"..index]=hbv_Skins_GetFrameVar("BarTextCol", "NCR", button.frame)
            HealBot_colIndex["hctg"..index]=hbv_Skins_GetFrameVar("BarTextCol", "NCG", button.frame)
            HealBot_colIndex["hctb"..index]=hbv_Skins_GetFrameVar("BarTextCol", "NCB", button.frame)
        else
            HealBot_colIndex["hctr"..index]=hbCustomRoleCols[button.roletxt].r
            HealBot_colIndex["hctg"..index]=hbCustomRoleCols[button.roletxt].g
            HealBot_colIndex["hctb"..index]=hbCustomRoleCols[button.roletxt].b
        end
        button.text.r,button.text.g,button.text.b=r,g,b

        if hbv_Skins_GetFrameVar("BarTextCol", "HLTH", button.frame) == 2 or
           hbv_Skins_GetFrameVar("BarTextCol", "HLTH", button.frame) == 5 then
            HealBot_colIndex["hctr2"..index],HealBot_colIndex["hctg2"..index],HealBot_colIndex["hctb2"..index]=r,g,b
        elseif hbv_Skins_GetFrameVar("BarTextCol", "HLTH", button.frame) == 1 then
            HealBot_colIndex["hctr2"..index],HealBot_colIndex["hctg2"..index],HealBot_colIndex["hctb2"..index]=0,1,0
        elseif hbv_Skins_GetFrameVar("BarTextCol", "HLTH", button.frame) == 4 then
            HealBot_colIndex["hctr2"..index]=hbv_Skins_GetFrameVar("BarTextCol", "HCR", button.frame)
            HealBot_colIndex["hctg2"..index]=hbv_Skins_GetFrameVar("BarTextCol", "HCG", button.frame)
            HealBot_colIndex["hctb2"..index]=hbv_Skins_GetFrameVar("BarTextCol", "HCB", button.frame)
        else
            HealBot_colIndex["hctr2"..index]=hbCustomRoleCols[button.roletxt].r
            HealBot_colIndex["hctg2"..index]=hbCustomRoleCols[button.roletxt].g
            HealBot_colIndex["hctb2"..index]=hbCustomRoleCols[button.roletxt].b
        end

        if hbv_Skins_GetFrameVar("BarTextCol", "STATE", button.frame) == 2 or
           hbv_Skins_GetFrameVar("BarTextCol", "STATE", button.frame) == 5 then
            HealBot_colIndex["hctr3"..index],HealBot_colIndex["hctg3"..index],HealBot_colIndex["hctb3"..index]=r,g,b
        elseif hbv_Skins_GetFrameVar("BarTextCol", "STATE", button.frame) == 1 then
            HealBot_colIndex["hctr3"..index],HealBot_colIndex["hctg3"..index],HealBot_colIndex["hctb3"..index]=0,1,0
        elseif hbv_Skins_GetFrameVar("BarTextCol", "STATE", button.frame) == 4 then
            HealBot_colIndex["hctr3"..index]=hbv_Skins_GetFrameVar("BarTextCol", "SCR", button.frame)
            HealBot_colIndex["hctg3"..index]=hbv_Skins_GetFrameVar("BarTextCol", "SCG", button.frame)
            HealBot_colIndex["hctb3"..index]=hbv_Skins_GetFrameVar("BarTextCol", "SCB", button.frame)
        else
            HealBot_colIndex["hctr3"..index]=hbCustomRoleCols[button.roletxt].r
            HealBot_colIndex["hctg3"..index]=hbCustomRoleCols[button.roletxt].g
            HealBot_colIndex["hctb3"..index]=hbCustomRoleCols[button.roletxt].b
        end

        if hbv_Skins_GetFrameVar("BarTextCol", "AGGRO", button.frame) == 2 or
           hbv_Skins_GetFrameVar("BarTextCol", "AGGRO", button.frame) == 5 then
            HealBot_colIndex["hctr4"..index],HealBot_colIndex["hctg4"..index],HealBot_colIndex["hctb4"..index]=r,g,b
        elseif hbv_Skins_GetFrameVar("BarTextCol", "AGGRO", button.frame) == 1 then
            HealBot_colIndex["hctr4"..index],HealBot_colIndex["hctg4"..index],HealBot_colIndex["hctb4"..index]=0,1,0
        elseif hbv_Skins_GetFrameVar("BarTextCol", "AGGRO", button.frame) == 4 then
            HealBot_colIndex["hctr4"..index]=hbv_Skins_GetFrameVar("BarTextCol", "ACR", button.frame)
            HealBot_colIndex["hctg4"..index]=hbv_Skins_GetFrameVar("BarTextCol", "ACG", button.frame)
            HealBot_colIndex["hctb4"..index]=hbv_Skins_GetFrameVar("BarTextCol", "ACB", button.frame)
        else
            HealBot_colIndex["hctr4"..index]=hbCustomRoleCols[button.roletxt].r
            HealBot_colIndex["hctg4"..index]=hbCustomRoleCols[button.roletxt].g
            HealBot_colIndex["hctb4"..index]=hbCustomRoleCols[button.roletxt].b
        end

        button.gref["Bar"]:SetValue(1000)
        button.health.mixcolr,button.health.mixcolg,button.health.mixcolb=button.text.r,button.text.g,button.text.b
        button.mana.r,button.mana.g,button.mana.b=HealBot_colIndex["hctr5"..index],HealBot_colIndex["hctg5"..index],HealBot_colIndex["hctb5"..index]
        button.health.rcol,button.health.gcol=0,1
        button.health.pct=1000
        HealBot_Panel_TestBarColUpdate(button)
    end
    button:Show()
    HealBot_Action_UpdateBackground(button)
    if button.frame<10 and hbv_Skins_GetFrameBoolean("Emerg", "USE", button.frame) then
        if hbv_Skins_GetFrameVar("Emerg", "BARCOL", button.frame) == 2 or hbv_Skins_GetFrameVar("Emerg", "BARCOL", button.frame) == 5 then
            HealBot_Emerg_Button[button.id].bar:SetStatusBarColor(button.text.r,button.text.g,button.text.b,1)
        elseif hbv_Skins_GetFrameVar("Emerg", "BARCOL", button.frame) == 3 or hbv_Skins_GetFrameVar("Emerg", "BARCOL", button.frame) == 6 then
            HealBot_Emerg_Button[button.id].bar:SetStatusBarColor(hbCustomRoleCols[button.roletxt].r,hbCustomRoleCols[button.roletxt].g,hbCustomRoleCols[button.roletxt].b,1)
        elseif hbv_Skins_GetFrameVar("Emerg", "BARCOL", button.frame) == 4 then
            HealBot_Emerg_Button[button.id].bar:SetStatusBarColor(hbv_Skins_GetFrameVar("Emerg", "HR", button.frame),
                                                                  hbv_Skins_GetFrameVar("Emerg", "HG", button.frame),
                                                                  hbv_Skins_GetFrameVar("Emerg", "HB", button.frame),1)
        else
            HealBot_Emerg_Button[button.id].bar:SetStatusBarColor(0,1,0,1)
        end
        HealBot_Emerg_Button[button.id]:Show()
    else
        HealBot_Emerg_Button[button.id]:Hide()
    end
end

local noBars=100
function HealBot_Panel_testAddButton(gName,bName,minBar,maxBar,tRole,bClass)
      --HealBot_setCall("HealBot_Panel_testAddButton")
    local k=i[hbCurrentFrame]
    for j=minBar,maxBar do
        if noBars>0 then
            if not tRole then tRole="DAMAGER" end
            local tcR,tcG,tcB,tcC,tpR,tpG,tpB=HealBot_Panel_RandomClassColour(tRole, bClass)
            local tstb=HealBot_Action_SetTestButton(hbCurrentFrame, bName..j,tRole,tcC)
            if tstb then
                local bIndex=tstb.id
                HealBot_Panel_TestBarShow(bIndex,tstb,tRole,tcR,tcG,tcB,tpR,tpG,tpB)
                noBars=noBars-1
                i[hbCurrentFrame]=i[hbCurrentFrame]+1
                hbBarsPerFrame[tstb.frame]=hbBarsPerFrame[tstb.frame]+1
            end
        end
    end
    if i[hbCurrentFrame]>k and not tHeader[gName] then
        HeaderPos[hbCurrentFrame][k+1]=gName
        tHeader[gName]=true
        if not bClass and (bName == HEALBOT_OPTIONS_EMERGENCYHEALS or bName == HEALBOT_SORTBY_GROUP) then
            grpNo=grpNo+1
        end
    end
end

function HealBot_Panel_TestBarsOn()
      --HealBot_setCall("HealBot_Panel_TestBarsOn")
    HealBot_Action_resetTestBarsCounters()
    if HealBot_Panel_luVars["TestBarsDelAll"] then
        HealBot_Panel_luVars["TestBarsDelAll"]=false
        for xHeader,xButton in pairs(HealBot_Header_Frames) do
            HealBot_Panel_DeleteHeader(xButton.id, xHeader)
        end
    end
    HealBot_Update_ResetInitButtons()
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
        i[gl]=0
    end
    noBars=tonumber(HealBot_noBars)
    grpNo=1
    local gNo=5
    local healGroups=Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin]
    local xRaidBars=40
    if HealBot_Globals.TestBars["PROFILE"] == 3 then
        xRaidBars=25
    elseif HealBot_Globals.TestBars["PROFILE"] == 2 then
        xRaidBars=10
    elseif HealBot_Globals.TestBars["PROFILE"] == 1 then
        xRaidBars=5
    end
    local vRaidBars=xRaidBars
    local gFrame,rFrame=0,0
    local gID=0
    local nTanks=HealBot_Globals.TestBars["TANKS"]
    if HealBot_Globals.TestBars["PROFILE"] == 1 then nTanks=1 end
    local nHealers=HealBot_Globals.TestBars["HEALERS"]
    if HealBot_Globals.TestBars["PROFILE"] == 1 then nHealers=1 end
    if not Healbot_Config_Skins.DuplicateBars[Healbot_Config_Skins.Current_Skin] then
        for gl=1,7 do
            if healGroups[gl]["NAME"] == HEALBOT_OPTIONS_GROUPHEALS_en then
                if healGroups[gl]["STATE"] then
                    gFrame=Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["FRAME"]
                    gID=gl
                end
            elseif healGroups[gl]["NAME"] == HEALBOT_OPTIONS_EMERGENCYHEALS_en then
                if healGroups[gl]["STATE"] then
                    rFrame=Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["FRAME"]
                end
            end
        end
        for gl=1,14 do
            if healGroups[gl]["NAME"] == HEALBOT_OPTIONS_SELFHEALS_en then
                if healGroups[gl]["STATE"] then
                    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["FRAME"] == gFrame then gNo=gNo-1 end
                    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["FRAME"] == rFrame then xRaidBars=xRaidBars-1 end
                end
            elseif healGroups[gl]["NAME"] == HEALBOT_OPTIONS_PRIVFOCUS_en then
                if healGroups[gl]["STATE"] then
                    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["FRAME"] == gFrame then gNo=gNo-1 end
                    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["FRAME"] == rFrame then xRaidBars=xRaidBars-1 end
                end
            elseif healGroups[gl]["NAME"] == HEALBOT_OPTIONS_TANKHEALS_en then
                if healGroups[gl]["STATE"] then
                    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["FRAME"] == gFrame then gNo=gNo-nTanks end
                    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["FRAME"] == rFrame then xRaidBars=xRaidBars-nTanks end
                end
            elseif healGroups[gl]["NAME"] == HEALBOT_CLASSES_HEALERS_en then
                if healGroups[gl]["STATE"] then
                    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["FRAME"] == gFrame then gNo=gNo-nHealers end
                    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["FRAME"] == rFrame then xRaidBars=xRaidBars-nHealers end
                end
            elseif healGroups[gl]["NAME"] == HEALBOT_OPTIONS_MYTARGET_en then
                if HealBot_Globals.TestBars["TARGETS"]>0 and healGroups[gl]["STATE"] then
                    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["FRAME"] == gFrame then gNo=gNo-HealBot_Globals.TestBars["TARGETS"] end
                    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["FRAME"] == rFrame then xRaidBars=xRaidBars-HealBot_Globals.TestBars["TARGETS"] end
                end
            end
        end
    end
    if gID>0 and gNo>0 then
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gID]["FRAME"] == rFrame then xRaidBars=xRaidBars-gNo end
    end
    --if gNo>xRaidBars then gNo=xRaidBars end
    for gl=1,15 do
        HealBot_Panel_InitFrame(healGroups[gl]["FRAME"],gl)
        if HealBot_Action_hasPowerCounter(gl)>0 then
            HealBot_Action_setLuVars("showTestPowerIndicator", HealBot_Action_hasPowerCounter(gl))
        end
        if healGroups[gl]["NAME"] == HEALBOT_OPTIONS_SELFHEALS_en then
            if healGroups[gl]["STATE"] then
                HealBot_Panel_testAddButton(HEALBOT_OPTIONS_SELFHEALS,HEALBOT_OPTIONS_SELFHEALS,1,1,"HEALER")
            end
        elseif healGroups[gl]["NAME"] == HEALBOT_OPTIONS_PRIVFOCUS_en then
            if healGroups[gl]["STATE"] then
                HealBot_Panel_testAddButton(HEALBOT_OPTIONS_PRIVFOCUS,HEALBOT_OPTIONS_PRIVFOCUS,1,1)
            end
        elseif healGroups[gl]["NAME"] == HEALBOT_OPTIONS_TARGETOFPRIVFOCUSTARGET_en then
            if healGroups[gl]["STATE"] then
                HealBot_Panel_testAddButton(HEALBOT_OPTIONS_TARGETOFPRIVFOCUSTAR,HEALBOT_OPTIONS_TARGETOFPRIVFOCUSTAR,1,1)
            end
        elseif healGroups[gl]["NAME"] == HEALBOT_OPTIONS_TANKHEALS_en then
            if nTanks>0 and healGroups[gl]["STATE"] then
                HealBot_Panel_testAddButton(HEALBOT_OPTIONS_TANKHEALS,HEALBOT_WORD_TANK,1,nTanks,"TANK")
            end
        elseif healGroups[gl]["NAME"] == HEALBOT_CLASSES_HEALERS_en then
            if nHealers>0 and healGroups[gl]["STATE"] then
                HealBot_Panel_testAddButton(HEALBOT_CLASSES_HEALERS,HEALBOT_WORD_HEALER,1,nHealers,"HEALER")
            end
        elseif healGroups[gl]["NAME"] == HEALBOT_OPTIONS_GROUPHEALS_en then
            if healGroups[gl]["STATE"] and gNo>0 then
                HealBot_Panel_testAddButton(HEALBOT_SORTBY_GROUP.." "..grpNo,HEALBOT_SORTBY_GROUP,1,gNo)
            end
        elseif healGroups[gl]["NAME"] == HEALBOT_OPTIONS_MYTARGET_en then
            if HealBot_Globals.TestBars["TARGETS"]>0 and healGroups[gl]["STATE"] then
                --HealBot_Panel_testAddButton(HEALBOT_OPTIONS_MYTARGET,HEALBOT_DISABLED_TARGET,1,HealBot_Globals.TestBars["TARGETS"])
                HealBot_Panel_testAddButton(HEALBOT_OPTIONS_MYTARGET,HEALBOT_OPTIONS_MYTARGET,1,HealBot_Globals.TestBars["TARGETS"])
            end
        elseif healGroups[gl]["NAME"] == HEALBOT_OPTIONS_PETHEALS_en and hbCurrentFrame<6 then
            if HealBot_Globals.TestBars["PETS"]>0 and healGroups[gl]["STATE"] then
                if hbv_Skins_GetBoolean("Healing", "GROUPPETS") and HealBot_Globals.TestBars["PETS"]>5 then
                    HealBot_Panel_testAddButton(HEALBOT_OPTIONS_PETHEALS.." 1",HEALBOT_WORD_PET,1,5)
                    HealBot_Panel_testAddButton(HEALBOT_OPTIONS_PETHEALS.." 2",HEALBOT_WORD_PET,6,HealBot_Globals.TestBars["PETS"])
                else
                    HealBot_Panel_testAddButton(HEALBOT_OPTIONS_PETHEALS,HEALBOT_WORD_PET,1,HealBot_Globals.TestBars["PETS"])
                end
            end
        elseif healGroups[gl]["NAME"] == HEALBOT_OPTIONS_TARGETHEALS_en and hbCurrentFrame<6 then
            if healGroups[gl]["STATE"] then
                HealBot_Panel_testAddButton(HEALBOT_OPTIONS_TARGETHEALS,HEALBOT_OPTIONS_TARGETHEALS,1,1)
            end
        elseif healGroups[gl]["NAME"] == HEALBOT_OPTIONS_TARGETOFTARGET_en and hbCurrentFrame<6 then
            if healGroups[gl]["STATE"] then
                HealBot_Panel_testAddButton(HEALBOT_OPTIONS_TAB_TARGETOFTARGET,HEALBOT_OPTIONS_TAB_TARGETOFTARGET,1,1)
            end
        elseif healGroups[gl]["NAME"] == HEALBOT_FOCUS_en and hbCurrentFrame<6 then
            if healGroups[gl]["STATE"] and HEALBOT_GAME_VERSION>1 then
                HealBot_Panel_testAddButton(HEALBOT_WORD_FOCUS,HEALBOT_WORD_FOCUS,1,1)
            end
        elseif healGroups[gl]["NAME"] == HEALBOT_OPTIONS_TARGETOFFOCUS_en and hbCurrentFrame<6 then
            if healGroups[gl]["STATE"] and HEALBOT_GAME_VERSION>1 then
                HealBot_Panel_testAddButton(HEALBOT_OPTIONS_TARGETOFFOCUS,HEALBOT_OPTIONS_TARGETOFFOCUS,1,1)
            end
        elseif healGroups[gl]["NAME"] == HEALBOT_OPTIONS_EMERGENCYHEALS_en then
            if healGroups[gl]["STATE"] and xRaidBars>0 then
                if HealBot_Globals.TestBars["PROFILE"]>1 then
                    if hbv_Skins_GetFrameVar("BarSort", "RAIDORDER", hbCurrentFrame) == 3 then
                        for x=1,8 do
                            if xRaidBars>(5*(x-1)) then
                                if xRaidBars<(5*x) then
                                    HealBot_Panel_testAddButton(HEALBOT_OPTIONS_EMERGENCYHEALS.." "..HEALBOT_SORTBY_GROUP.." "..grpNo,HEALBOT_OPTIONS_EMERGENCYHEALS,(5*x)-4,xRaidBars)
                                else
                                    HealBot_Panel_testAddButton(HEALBOT_OPTIONS_EMERGENCYHEALS.." "..HEALBOT_SORTBY_GROUP.." "..grpNo,HEALBOT_OPTIONS_EMERGENCYHEALS,(5*x)-4,(5*x))
                                end
                            end
                        end
                    elseif hbv_Skins_GetFrameVar("BarSort", "RAIDORDER", hbCurrentFrame) == 2 then
                        local rndClass=HealBot_Panel_RandomClasses(xRaidBars)
                        local curBar=1
                        for x=1,HealBot_randomClCol[0]["MAX"] do
                            if rndClass[x]>0 then
                                HealBot_Panel_testAddButton(HealBot_randomClNames[x],HEALBOT_OPTIONS_EMERGENCYHEALS,curBar,curBar+(rndClass[x]-1),nil,x)
                                curBar=curBar+rndClass[x]
                            end
                        end
                    else
                        HealBot_Panel_testAddButton(HEALBOT_OPTIONS_EMERGENCYHEALS.." "..HEALBOT_SORTBY_GROUP.." "..grpNo,HEALBOT_OPTIONS_EMERGENCYHEALS,1,xRaidBars)
                    end
                else
                    HealBot_Panel_testAddButton(HEALBOT_SORTBY_GROUP.." "..grpNo,HEALBOT_SORTBY_GROUP,1,xRaidBars)
                end
                xRaidBars=0
            end
        end
        HealBot_Action_setLuVars("showTestPowerIndicator", 0)
    end

    HealBot_Panel_SetupBars(true)

    if HEALBOT_GAME_VERSION>1 and ((healGroups[13]["STATE"] and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][13]["FRAME"] == 9) or
                                   (healGroups[14]["STATE"] and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][14]["FRAME"] == 9)) then
        HealBot_Panel_InitFrame(9,10)
            for x,_ in pairs(HealBot_Action_HealButtons) do
                HealBot_Action_HealButtons[x]=nil;
            end
        if healGroups[13]["STATE"] and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][13]["FRAME"] == 9 then
            HealBot_Panel_testAddButton(HEALBOT_WORD_FOCUS,HEALBOT_WORD_FOCUS,1,1)
        end
        if healGroups[14]["STATE"] and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][14]["FRAME"] == 9 then
            HealBot_Panel_testAddButton(HEALBOT_OPTIONS_TARGETOFFOCUS,HEALBOT_OPTIONS_TARGETOFFOCUS,1,1)
        end
        HealBot_Panel_SetupExtraBars(9, true)
    else
        HealBot_Action_HidePanel(9)
    end

    if (healGroups[11]["STATE"] and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][11]["FRAME"] == 8) or
       (healGroups[12]["STATE"] and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][12]["FRAME"] == 8) then
        HealBot_Panel_InitFrame(8,9)
        for x,_ in pairs(HealBot_Action_HealButtons) do
            HealBot_Action_HealButtons[x]=nil;
        end
        if healGroups[11]["STATE"] and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][11]["FRAME"] == 8 then
            HealBot_Panel_testAddButton(HEALBOT_OPTIONS_TARGETHEALS,HEALBOT_OPTIONS_TARGETHEALS,1,1)
        end
        if healGroups[12]["STATE"] and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][12]["FRAME"] == 8 then
            HealBot_Panel_testAddButton(HEALBOT_OPTIONS_TAB_TARGETOFTARGET,HEALBOT_OPTIONS_TAB_TARGETOFTARGET,1,1)
        end
        HealBot_Panel_SetupExtraBars(8, true)
    else
        HealBot_Action_HidePanel(8)
    end

    if HealBot_Globals.TestBars["PETS"]>0 and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["FRAME"] == 7 and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["STATE"] then
        HealBot_Panel_InitFrame(7,8)
        for x,_ in pairs(HealBot_Action_HealButtons) do
            HealBot_Action_HealButtons[x]=nil;
        end
        if hbv_Skins_GetBoolean("Healing", "GROUPPETS") and HealBot_Globals.TestBars["PETS"]>5 then
            HealBot_Panel_testAddButton(HEALBOT_OPTIONS_PETHEALS.." 1",HEALBOT_WORD_PET,1,5)
            HealBot_Panel_testAddButton(HEALBOT_OPTIONS_PETHEALS.." 2",HEALBOT_WORD_PET,6,HealBot_Globals.TestBars["PETS"])
        else
            HealBot_Panel_testAddButton(HEALBOT_OPTIONS_PETHEALS,HEALBOT_WORD_PET,1,HealBot_Globals.TestBars["PETS"])
        end
        HealBot_Panel_SetupExtraBars(7, true)
    else
        HealBot_Action_HidePanel(7)
    end

    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][9]["FRAME"] == 6 and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][9]["STATE"] then
        HealBot_Panel_InitFrame(6,7)
        for x,_ in pairs(HealBot_Action_HealButtons) do
            HealBot_Action_HealButtons[x]=nil;
        end
        HealBot_Panel_testAddButton(HEALBOT_WORD_VEHICLE,HEALBOT_WORD_VEHICLE,1,vRaidBars)
        HealBot_Panel_SetupExtraBars(6, true)
    else
        HealBot_Action_HidePanel(6)
    end

    if healGroups[15]["STATE"] then
        HealBot_Panel_InitFrame(10,11)
        for x,_ in pairs(HealBot_Action_HealButtons) do
            HealBot_Action_HealButtons[x]=nil;
        end
        HealBot_Panel_testAddButton(HEALBOT_CUSTOM_CASTBY_ENEMY,HEALBOT_CUSTOM_CASTBY_ENEMY,1,HealBot_Globals.TestBars["ENEMY"],HEALBOT_CUSTOM_CASTBY_ENEMY)
        HealBot_Panel_SetupExtraBars(10, true)
    else
        HealBot_Action_HidePanel(10)
    end
    for _,xButton in pairs(HealBot_Test_Button) do
        if not HealBot_TestBarsActive[xButton.id] then
           -- HealBot_setTestCols[xButton.id]=false
            xButton:Hide()
            HealBot_Emerg_Button[xButton.id]:Hide()
        end
    end
    for xHeader,xButton in pairs(HealBot_Header_Frames) do
        if not HealBot_Track_Headers[xHeader] then
            HealBot_Panel_DeleteHeader(xButton.id, xHeader)
        end
    end
    --HealBot_Timers_Set("SKINS","TextUpdateHealth")
end

function HealBot_Panel_resetTestCols(force)
      --HealBot_setCall("HealBot_Panel_resetTestCols")
    if HealBot_setTestBars then
        if force then HealBot_setTestCols={} end
        HealBot_Timers_nextRecalcAll()
    end
end

function HealBot_Panel_resetTestColsButton(index)
      --HealBot_setCall("HealBot_Panel_resetTestColsButton")
    if HealBot_setTestCols[index] then HealBot_setTestCols[index]=false end
end


function HealBot_Panel_enemyBar(eUnit, pUnit)
      --HealBot_setCall("HealBot_Panel_enemyBar")
    i[hbCurrentFrame]=i[hbCurrentFrame]+1
    table.insert(units,eUnit)
    hbPanel_enemyUnits[pUnit]=true
    if hbv_Skins_GetBoolean("Enemy", "ENEMYTARGET") then
        HealBot_EnemyUnits[eUnit]=1
        HealBot_EnemyUnits[eUnit.."target"]=2
    else
        HealBot_EnemyUnits[eUnit]=nil
        HealBot_EnemyUnits[eUnit.."target"]=nil
    end
end

function HealBot_Panel_PlayersTargets(eUnit, pUnit, state, caller)
    if not HealBot_UnitTargets[pUnit] then
        --if string.find(pUnit, "target") then
        --    HealBot_AddDebug("pUnit has target - caller="..caller,"Enemy",true)
        --end
        HealBot_UnitTargets[pUnit]=1
        if hbv_Skins_GetVar("Enemy", "ENEMYTARGETPLAYERFRAMES") then
            HealBot_UnitTargets[eUnit]=3
            HealBot_UnitTargets[eUnit.."target"]=4
        else
            HealBot_UnitTargets[eUnit]=2
            HealBot_UnitTargets[eUnit.."target"]=nil
        end
        return true
    else
        return state
    end
end

function HealBot_Panel_PlayersTargetsDelToTFrames(unit)
    if HealBot_UnitTarget_Button[unit] then
        HealBot_Action_MarkDeleteButton(HealBot_UnitTarget_Button[unit])
        HealBot_UnitTargets[unit]=nil
    end
    if HealBot_PrivateTarget_Button[unit] then
        HealBot_Action_MarkDeleteButton(HealBot_PrivateTarget_Button[unit])
        HealBot_UnitTargets[unit]=nil
    end
end

function HealBot_Panel_PlayersTargetsResetSkins()
    HealBot_Panel_luVars["PlayersTargetsQueue"]=false
    if HealBot_Panel_luVars["RecalcOnZeroEnemy"] then
        HealBot_Panel_luVars["RecalcOnZeroEnemy"]=false
        HealBot_setLuVars("resetOnNoTargetFrames", true)
    end
    HealBot_Timers_setLuVars("ResetEnemySkins", true)
    HealBot_Timers_Set("OOC","RefreshPartyNextRecalcPlayers")
    HealBot_Timers_Set("OOC","RefreshPartyNextRecalcTarget")
   -- HealBot_AddDebug("PlayersTargetsResetSkins","Enemy",true)
end

function HealBot_Panel_PlayersTargetsQueueResetSkins(delay)
    if not HealBot_Panel_luVars["PlayersTargetsQueue"] then
        HealBot_Panel_luVars["PlayersTargetsQueue"]=true
        HealBot_Timers_Set("OOC","PlayersTargetsResetSkins",true)
    end
end

function HealBot_Panel_PlayersTargetsDelFrames(unit)
    if not HealBot_Data["UILOCK"] then
        --if HealBot_UnitTarget_Button[unit] then HealBot_Action_MarkDeleteEnemyButton(HealBot_UnitTarget_Button[unit]) end
        --if HealBot_PrivateTarget_Button[unit] then HealBot_Action_MarkDeleteEnemyButton(HealBot_PrivateTarget_Button[unit]) end
        if HealBot_UnitTarget_Button[unit.."target"] then HealBot_Action_MarkDeleteEnemyButton(HealBot_UnitTarget_Button[unit.."target"]) end
        if HealBot_PrivateTarget_Button[unit.."target"] then HealBot_Action_MarkDeleteEnemyButton(HealBot_PrivateTarget_Button[unit.."target"]) end
        HealBot_UnitTargets[unit]=nil
        HealBot_UnitTargets[unit.."target"]=nil
        HealBot_Panel_PlayersTargetsDelToTFrames(unit.."targettarget")
    else
        HealBot_Timers_Set("OOC","CheckPlayersTargets",true,true)
    end
end

function HealBot_Panel_PlayersTargetsDelAll()
    for xUnit,_ in pairs(HealBot_Unit_Button) do
        if HealBot_UnitTargets[xUnit] then
            HealBot_Panel_PlayersTargetsDelFrames(xUnit, true)
        end
    end
    for xUnit,_ in pairs(HealBot_Private_Button) do
        if HealBot_UnitTargets[xUnit] then
            HealBot_Panel_PlayersTargetsDelFrames(xUnit, true)
        end
    end
end

function HealBot_Panel_validateEnemyPlayerFramesUnit(unit, guid)
    if unit == "player" and hbv_Skins_GetBoolean("Enemy", "INCSELF") and hbv_Skins_GetVar("Enemy", "SELFUSEFRAME") == 2 then
        -- Nothing to do
    elseif HealBot_MyHealTargets[guid] and hbv_Skins_GetBoolean("Enemy", "INCMYTAR") and hbv_Skins_GetVar("Enemy", "PRIVATELISTUSEFRAME") == 2 then
        -- Nothing to do
    elseif HealBot_MainTanks[guid] and hbv_Skins_GetBoolean("Enemy", "INCTANKS") and hbv_Skins_GetVar("Enemy", "TANKUSEFRAME") == 2 then
        -- Nothing to do
    elseif HealBot_Action_HealGroup[unit] and hbv_Skins_GetVar("Enemy", "INCGROUP") and hbv_Skins_GetVar("Enemy", "GROUPUSEFRAME") == 2 then
        -- Nothing to do
    elseif hbv_Skins_GetVar("Enemy", "INCRAID") and IsInRaid() and strsub(unit,1,4) == "raid" and hbv_Skins_GetVar("Enemy", "RAIDUSEFRAME") == 2 then
        -- Nothing to do
    elseif HealBot_UnitTargets[unit] then
        HealBot_Panel_PlayersTargetsDelFrames(unit, true)
    end
end

function HealBot_Panel_validateEnemyPlayerFrames()
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Panel_validateEnemyPlayerFramesUnit(xButton.unit, xButton.guid)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Panel_validateEnemyPlayerFramesUnit(xButton.unit, xButton.guid)
    end
    for _,xButton in pairs(HealBot_Extra_Button) do
        HealBot_Panel_validateEnemyPlayerFramesUnit(xButton.unit, xButton.guid)
    end
    HealBot_Panel_PlayersTargetsQueueResetSkins()
    HealBot_Timers_setLuVars("ResetSkins", true)
    HealBot_Timers_Set("OOC","UpdateEnemyFrames",true)
end

function HealBot_Panel_EnemyTargetsWithPlayersSelfUpdate()
    return HealBot_Panel_checkEnemyBar("playertarget", "player", false,
                                        hbv_Skins_GetVar("Enemy", "EXISTSHOWPTAR"),
                                        hbv_Skins_GetVar("Enemy", "INCOMBATSHOWSELF"),
                                        2, false, "EnemyTargetsWithPlayersUpdate - self")
end

local hbValidRaidIds={}
for x=1,40 do
    hbValidRaidIds["Raid"..x]=true
end
function HealBot_Panel_EnemyTargetsWithPlayersUpdate(unit, guid)
    if not HealBot_Data["UILOCK"] and not HealBot_Panel_luVars["PlayersTargetsQueue"] then
        if unit == "player" and hbv_Skins_GetBoolean("Enemy", "INCSELF") and hbv_Skins_GetVar("Enemy", "EXISTSHOWPTAR")<3 and hbv_Skins_GetVar("Enemy", "SELFUSEFRAME") == 2 then
            if HealBot_Panel_EnemyTargetsWithPlayersSelfUpdate() then
                HealBot_Panel_PlayersTargetsQueueResetSkins()
            end
        elseif HealBot_MyHealTargets[guid] and hbv_Skins_GetBoolean("Enemy", "INCMYTAR") and hbv_Skins_GetVar("Enemy", "EXISTSHOWMYTAR")<3 and hbv_Skins_GetVar("Enemy", "PRIVATELISTUSEFRAME") == 2 then
            if HealBot_Panel_checkEnemyBar(unit.."target", unit, false,
                                           hbv_Skins_GetVar("Enemy", "EXISTSHOWMYTAR"),
                                           hbv_Skins_GetVar("Enemy", "INCOMBATSHOWLIST"),
                                           2, false, "EnemyTargetsWithPlayersUpdate - list") then
                HealBot_Panel_PlayersTargetsQueueResetSkins()
            end
        elseif HealBot_MainTanks[guid] and hbv_Skins_GetBoolean("Enemy", "INCTANKS") and hbv_Skins_GetVar("Enemy", "EXISTSHOWTANK")<3 and hbv_Skins_GetVar("Enemy", "TANKUSEFRAME") == 2 then
            if HealBot_Panel_checkEnemyBar(unit.."target", unit, false,
                                           hbv_Skins_GetVar("Enemy", "EXISTSHOWTANK"),
                                           hbv_Skins_GetVar("Enemy", "INCOMBATSHOWTANK"),
                                           2, false, "EnemyTargetsWithPlayersUpdate - tanks") then
                HealBot_Panel_PlayersTargetsQueueResetSkins()
            end
        elseif HealBot_Action_HealGroup[unit] and hbv_Skins_GetVar("Enemy", "INCGROUP") and hbv_Skins_GetVar("Enemy", "EXISTSHOWGROUP")<3 and hbv_Skins_GetVar("Enemy", "GROUPUSEFRAME") == 2 then
            if HealBot_Panel_checkEnemyBar(unit.."target", unit, false,
                                           hbv_Skins_GetVar("Enemy", "EXISTSHOWGROUP"),
                                           hbv_Skins_GetVar("Enemy", "INCOMBATSHOWGROUP"),
                                           2, false, "EnemyTargetsWithPlayersUpdate - group") then
                HealBot_Panel_PlayersTargetsQueueResetSkins()
            end
        elseif hbv_Skins_GetVar("Enemy", "INCRAID") and IsInRaid() and hbValidRaidIds[unit] and hbv_Skins_GetVar("Enemy", "EXISTSHOWRAID")<3 and hbv_Skins_GetVar("Enemy", "RAIDUSEFRAME") == 2 then
            if HealBot_Panel_checkEnemyBar(unit.."target", unit, false,
                                           hbv_Skins_GetVar("Enemy", "EXISTSHOWRAID"),
                                           hbv_Skins_GetVar("Enemy", "INCOMBATSHOWRAID"),
                                           2, false, "EnemyTargetsWithPlayersUpdate - raid") then
                HealBot_Panel_PlayersTargetsQueueResetSkins()
            end
        end
    end
end

function HealBot_Panel_checkEnemyBar(eUnit, pUnit, preCombat, existsShow, preCombatShow, useFrame, state, caller)
      --HealBot_setCall("HealBot_Panel_checkEnemyBar")
    if UnitExists(pUnit) then
        if preCombat then
            if preCombatShow == 2 then
                if UnitExists(eUnit) then
                    if useFrame == 1 then
                        HealBot_Panel_enemyBar(eUnit, pUnit)
                    else
                        state=HealBot_Panel_PlayersTargets(eUnit, pUnit, state, caller)
                    end
                end
            elseif preCombatShow == 1 or not UnitExists("boss1") then
                if useFrame == 1 then
                    HealBot_Panel_enemyBar(eUnit, pUnit)
                else
                    state=HealBot_Panel_PlayersTargets(eUnit, pUnit, state, caller)
                end
            end
        elseif existsShow>1 then
            if existsShow == 2 then
                if UnitExists(eUnit) then
                    if useFrame == 1 then
                        HealBot_Panel_enemyBar(eUnit, pUnit)
                    else
                        state=HealBot_Panel_PlayersTargets(eUnit, pUnit, state, caller)
                    end
                elseif useFrame == 2 then
                    HealBot_Panel_PlayersTargetsDelFrames(pUnit, false)
                end
            elseif useFrame == 1 then
                HealBot_Panel_enemyBar(eUnit, pUnit)
            else
                state=HealBot_Panel_PlayersTargets(eUnit, pUnit, state, caller)
            end
        elseif useFrame == 2 then
            HealBot_Panel_PlayersTargetsDelFrames(pUnit, false)
        end
    end
    return state
end

local vSubSortUnit,vSubSortGUID,vExists,vDup,vRole="","",false,false,3
function HealBot_Panel_SubSort(doSubSort, unitType, preCombat)
      --HealBot_setCall("HealBot_Panel_SubSort")
    if doSubSort then --and hbv_Skins_GetFrameVar("BarSort", "SUBORDER", hbCurrentFrame)<6 then
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
        vSubSortUnit=subunits[j]
        if vSubSortUnit then
            vSubSortGUID=UnitGUID(vSubSortUnit) or vSubSortUnit
            vExists=false
            vDup=false
            if Healbot_Config_Skins.DuplicateBars[Healbot_Config_Skins.Current_Skin] then
                if unitType<10 and (unitType ~= hbv_GetUnitType(HEALBOT_PRIVATELIST) or Healbot_Config_Skins.DupBarsPrivList[Healbot_Config_Skins.Current_Skin]) then
                    if HealBot_TrackPrivateUnit[unitType][vSubSortUnit] then
                        vExists=true
                    elseif HealBot_TrackUnit[hbv_GetUnitType(HEALBOT_RAID)][vSubSortUnit] or 
                           HealBot_TrackUnit[hbv_GetUnitType(HEALBOT_GROUP)][vSubSortUnit] then
                        vDup=true
                    end
                else
                    if HealBot_TrackUnit[unitType][vSubSortUnit] then
                        vExists=true
                    elseif HealBot_TrackPrivateUnit[hbv_GetUnitType(HEALBOT_TANK)][vSubSortUnit] or 
                           HealBot_TrackPrivateUnit[hbv_GetUnitType(HEALBOT_HEALER)][vSubSortUnit] or 
                           HealBot_TrackPrivateUnit[hbv_GetUnitType(HEALBOT_SELF)][vSubSortUnit] or 
                           HealBot_TrackPrivateUnit[hbv_GetUnitType(HEALBOT_PRIVATEFOCUS)][vSubSortUnit] then
                        vDup=true
                    elseif Healbot_Config_Skins.DupBarsPrivList[Healbot_Config_Skins.Current_Skin] and
                           HealBot_TrackPrivateUnit[hbv_GetUnitType(HEALBOT_PRIVATELIST)][vSubSortUnit] then
                        vDup=true
                    end
                end
            elseif (unitType>10 and HealBot_TrackUnit[unitType][vSubSortUnit]) or (unitType<10 and HealBot_TrackPrivateUnit[unitType][vSubSortUnit]) then
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
                    if unitType<10 then
                        HealBot_TrackPrivateUnit[unitType][vSubSortUnit]=true
                    else
                        HealBot_TrackUnit[unitType][vSubSortUnit]=true
                    end
                    hbHealButtonsConcat[1]=vSubSortUnit
                    hbHealButtonsConcat[3]=unitType
                    table.insert(HealBot_Action_HealButtons,table.concat(hbHealButtonsConcat))
                    --if (not HealBot_EnemyUnits[vSubSortUnit] or HealBot_EnemyUnits[vSubSortUnit] == 1) then
                        hbBarsPerFrame[hbCurrentFrame]=hbBarsPerFrame[hbCurrentFrame]+1
                    --end
                end
            end
        else
            HealBot_Timers_Set("LAST","ResetAllButtonsRecalcAll",true)
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
      --HealBot_setCall("HealBot_Panel_sortOrder")
    vSubOrderKey=99
    if mainSort and hbv_Skins_GetFrameBoolean("HeadBar", "SHOW", hbCurrentFrame) then
        allowOOR=false
    else
        allowOOR=true
    end
    if barOrder == 1 then
        if UnitIsUnit(unit, "player") then
            if hbv_Skins_GetFrameBoolean("BarSort", "SUBPF", hbCurrentFrame) then
                vSubOrderKey="!";
            else
                vSubOrderKey=UnitName(unit) or unit
            end
        elseif UnitExists(unit) then
            if hbv_Skins_GetFrameBoolean("BarSort", "OORLAST", hbCurrentFrame) and not HealBot_Range_UnitGUID(unit) then
                vSubOrderKey="ÿÿÿþ"..(UnitName(unit) or unit)
            else
                vSubOrderKey=UnitName(unit) or unit
            end
        else
            vSubOrderKey="ÿÿÿÿ"..unit
        end
    elseif barOrder == 2 then
        if UnitIsUnit(unit, "player") then
            if not mainSort and hbv_Skins_GetFrameBoolean("BarSort", "SUBPF", hbCurrentFrame) then
                vSubOrderKey="!";
            else
                vSubOrderKey=HealBot_Panel_classEN(unit)
            end
        elseif UnitExists(unit) then
            if allowOOR and hbv_Skins_GetFrameBoolean("BarSort", "OORLAST", hbCurrentFrame) and not HealBot_Range_UnitGUID(unit) then
                vSubOrderKey="ÿÿÿþ"..HealBot_Panel_classEN(unit)
            else
                vSubOrderKey=HealBot_Panel_classEN(unit)
            end
        else
            vSubOrderKey="ÿÿÿÿ"..unit
        end
    elseif barOrder == 3 then
        if UnitIsUnit(unit, "player") then
            if not mainSort and hbv_Skins_GetFrameBoolean("BarSort", "SUBPF", hbCurrentFrame) then
                vSubOrderKey=-1
            else
                vSubOrderKey=HealBot_UnitGroups[unit] or 1
            end
        elseif UnitExists(unit) then
            if allowOOR and hbv_Skins_GetFrameBoolean("BarSort", "OORLAST", hbCurrentFrame) and not HealBot_Range_UnitGUID(unit) then
                vSubOrderKey=9+(HealBot_UnitGroups[unit] or 1)
            else
                vSubOrderKey=HealBot_UnitGroups[unit] or 1
            end
        else
            vSubOrderKey=(HealBot_UnitGroups[unit] or 1)
        end
    elseif barOrder == 4 then
        if UnitIsUnit(unit, "player") then
            if hbv_Skins_GetFrameBoolean("BarSort", "SUBPF", hbCurrentFrame) then
                vSubOrderKey=-99999999
            else
                vSubOrderKey=0-UnitHealthMax(unit)
            end
        elseif UnitExists(unit) then
            if hbv_Skins_GetFrameBoolean("BarSort", "OORLAST", hbCurrentFrame) and not HealBot_Range_UnitGUID(unit) then
                vSubOrderKey=9999999-UnitHealthMax(unit)
            else
                vSubOrderKey=0-UnitHealthMax(unit)
            end
        else
            vSubOrderKey=99999999
        end
        if UnitIsPlayer(unit) and UnitHealthMax(unit)>TempMaxH then TempMaxH=UnitHealthMax(unit); end
    elseif barOrder == 5 then
        if UnitIsUnit(unit, "player") then
            if not mainSort and hbv_Skins_GetFrameBoolean("BarSort", "SUBPF", hbCurrentFrame) then
                vSubOrderKey=-1
            else
                vSubOrderKey=HealBot_unitRole[unit] or 9
            end
        elseif UnitExists(unit) then
            if allowOOR and hbv_Skins_GetFrameBoolean("BarSort", "OORLAST", hbCurrentFrame) and not HealBot_Range_UnitGUID(unit) then
                vSubOrderKey=59+(HealBot_unitRole[unit] or 9)
            else
                vSubOrderKey=HealBot_unitRole[unit] or 9
            end
        else
            vSubOrderKey=99+(HealBot_unitRole[unit] or 9)
        end
    end
    return vSubOrderKey
end

function HealBot_Panel_insSort(unit, mainSort)
      --HealBot_setCall("HealBot_Panel_insSort")
    if unit then
        if mainSort then
            if hbv_Skins_GetFrameVar("BarSort", "RAIDORDER", hbCurrentFrame)<6 then
                order[unit]=HealBot_Panel_sortOrder(unit, hbv_Skins_GetFrameVar("BarSort", "RAIDORDER", hbCurrentFrame), mainSort)
            else
                if hbv_Skins_GetFrameBoolean("BarSort", "SUBPF", hbCurrentFrame) and UnitIsUnit(unit, "player") then
                    order[unit]="!"
                else
                    order[unit]=unit
                end
            end
            table.insert(units,unit)
        else
            if hbv_Skins_GetFrameVar("BarSort", "SUBORDER", hbCurrentFrame)<6 then
                suborder[unit]=HealBot_Panel_sortOrder(unit, hbv_Skins_GetFrameVar("BarSort", "SUBORDER", hbCurrentFrame), mainSort)
            else
                if hbv_Skins_GetFrameBoolean("BarSort", "SUBPF", hbCurrentFrame) and UnitIsUnit(unit, "player") then
                    suborder[unit]="!"
                else
                    suborder[unit]=unit
                end
            end
            table.insert(subunits,unit)
        end
    end
end

function HealBot_Panel_SetFocusGroups()
      --HealBot_setCall("HealBot_Panel_SetFocusGroups")
    if HealBot_Globals.OverrideEffects["USEBARS"] == 2 then
        HealBot_Panel_luVars["FocusGroups"]=HealBot_Globals.OverrideEffects["FOCUSGROUPS"]
        HealBot_Panel_luVars["FGroups"]=HealBot_Globals.OverrideFocusGroups
        HealBot_Panel_luVars["FGroupsRaidOnly"]=HealBot_Globals.OverrideEffects["FGRAIDONLY"]
    else
        HealBot_Panel_luVars["FocusGroups"]=hbv_Skins_GetVar("General", "FOCUSGROUPS")
        for x=1, 8 do
            HealBot_Panel_luVars["FGroups"][x]=hbv_Skins_GetFocusGroup(x)
        end
        HealBot_Panel_luVars["FGroupsRaidOnly"]=hbv_Skins_GetBoolean("General", "FGRAIDONLY")
    end
end

function HealBot_Panel_addUnit(unit, unitType, hbGUID, isRaidGroup)
      --HealBot_setCall("HealBot_Panel_addUnit")
    if HealBot_Panel_luVars["FocusGroups"]<3 or 
     ((HealBot_Panel_luVars["FGroupsRaidOnly"] and hbv_IsNotUnitType(unitType, HEALBOT_RAID)) or (not HealBot_Panel_luVars["FGroupsRaidOnly"] and unitType<30)) or 
       HealBot_Panel_luVars["FGroups"][HealBot_UnitGroups[unit]] then
        local uExists=false
        if Healbot_Config_Skins.DuplicateBars[Healbot_Config_Skins.Current_Skin] then
            if unitType<10 and (unitType ~= hbv_GetUnitType(HEALBOT_PRIVATELIST) or Healbot_Config_Skins.DupBarsPrivList[Healbot_Config_Skins.Current_Skin]) then
                if HealBot_TrackPrivateNames[hbGUID] then uExists=true end
            else
                if HealBot_TrackNames[hbGUID] then uExists=true end
            end
        elseif HealBot_TrackNames[hbGUID] or HealBot_TrackPrivateNames[hbGUID] then
            uExists=true
        end
        if not uExists then
            if UnitIsVisible(unit) or not hbv_Skins_GetFrameBoolean("BarVisibility", "HIDEOOR", hbCurrentFrame) then
                if not isRaidGroup then i[hbCurrentFrame]=i[hbCurrentFrame]+1; end
                if unitType<10 and (unitType ~= hbv_GetUnitType(HEALBOT_PRIVATELIST) or Healbot_Config_Skins.DupBarsPrivList[Healbot_Config_Skins.Current_Skin]) then
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
      --HealBot_setCall("HealBot_Panel_MainSort")
    if #units>0 then
        if doMainSort then --and hbv_Skins_GetFrameVar("BarSort", "RAIDORDER", hbCurrentFrame)<6 then
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
end

function HealBot_Panel_addUnits(doMainSort, unitType, hText, k, preCombat)
      --HealBot_setCall("HealBot_Panel_addUnits")
    HealBot_Panel_MainSort(doMainSort, unitType, preCombat)
    HeaderPos[hbCurrentFrame][k+1]=hText
end

local vEnemyIndex,vEnemyLocation,vEnemyBossNum,vEnemyBossExist,vPlayerState=0,"",0,1,false
local vEnemyUnit={}
function HealBot_Panel_enemyPlayerTargets(preCombat, playerFrame)
    vPlayerState=false
    if playerFrame == 1 or (preCombat or not HealBot_Panel_luVars["PlayersTargetsQueue"]) then
        for x,_ in pairs(vEnemyUnit) do
            vEnemyUnit[x]=false;
        end
        if hbv_Skins_GetBoolean("Enemy", "INCSELF") and hbv_Skins_GetVar("Enemy", "SELFUSEFRAME") == playerFrame then
            vEnemyUnit["player"]=true
            vPlayerState=HealBot_Panel_checkEnemyBar("playertarget", "player", preCombat,
                                                      hbv_Skins_GetVar("Enemy", "EXISTSHOWPTAR"),
                                                      hbv_Skins_GetVar("Enemy", "INCOMBATSHOWSELF"),
                                                      playerFrame, vPlayerState, "enemyPlayerTargets - self")
        end
        if hbv_Skins_GetBoolean("Enemy", "INCMYTAR") and hbv_Skins_GetVar("Enemy", "PRIVATELISTUSEFRAME") == playerFrame and (playerFrame == 1 or not vPlayerState) then
            for xGUID,_ in pairs(HealBot_MyHealTargets) do
                xUnit=hbPanel_dataGUIDs[xGUID]
                if xUnit and not vEnemyUnit[xUnit] and UnitIsPlayer(xUnit) then
                    vEnemyUnit[xUnit]=true
                    vPlayerState=HealBot_Panel_checkEnemyBar(xUnit.."target", xUnit, preCombat,
                                                             hbv_Skins_GetVar("Enemy", "EXISTSHOWMYTAR"),
                                                             hbv_Skins_GetVar("Enemy", "INCOMBATSHOWLIST"),
                                                             playerFrame, vPlayerState, "enemyPlayerTargets - list")
                end
            end
            for xGUID,_ in pairs(HealBot_Globals.PermMyTargets) do
                xUnit=hbPanel_dataGUIDs[xGUID]
                if xUnit and not vEnemyUnit[xUnit] then
                    vEnemyUnit[xUnit]=true
                    vPlayerState=HealBot_Panel_checkEnemyBar(xUnit.."target", xUnit, preCombat,
                                                             hbv_Skins_GetVar("Enemy", "EXISTSHOWMYTAR"),
                                                             hbv_Skins_GetVar("Enemy", "INCOMBATSHOWLIST"),
                                                             playerFrame, vPlayerState, "enemyPlayerTargets - list")
                end
            end
        end
        if hbv_Skins_GetBoolean("Enemy", "INCTANKS") and hbv_Skins_GetVar("Enemy", "TANKUSEFRAME") == playerFrame and (playerFrame == 1 or not vPlayerState) then
            for _,xUnit in pairs(HealBot_MainTanks) do
                if not vEnemyUnit[xUnit] and UnitIsPlayer(xUnit) then
                    vEnemyUnit[xUnit]=true
                    vPlayerState=HealBot_Panel_checkEnemyBar(xUnit.."target", xUnit, preCombat,
                                                             hbv_Skins_GetVar("Enemy", "EXISTSHOWTANK"),
                                                             hbv_Skins_GetVar("Enemy", "INCOMBATSHOWTANK"),
                                                             playerFrame, vPlayerState, "enemyPlayerTargets - tanks")
                end
            end
        end
        if hbv_Skins_GetVar("Enemy", "INCGROUP") and hbv_Skins_GetVar("Enemy", "GROUPUSEFRAME") == playerFrame and (playerFrame == 1 or not vPlayerState) then
            for xUnit,_ in pairs(HealBot_Action_HealGroup) do
                if not vEnemyUnit[xUnit] then
                    vEnemyUnit[xUnit]=true
                    vPlayerState=HealBot_Panel_checkEnemyBar(xUnit.."target", xUnit, preCombat,
                                                             hbv_Skins_GetVar("Enemy", "EXISTSHOWGROUP"),
                                                             hbv_Skins_GetVar("Enemy", "INCOMBATSHOWGROUP"),
                                                             playerFrame, vPlayerState, "enemyPlayerTargets - group")
                end
            end
        end
        if hbv_Skins_GetVar("Enemy", "INCRAID") and IsInRaid() and hbv_Skins_GetVar("Enemy", "RAIDUSEFRAME") == playerFrame and (playerFrame == 1 or not vPlayerState) then
            for j=1,GetNumGroupMembers() do
                xUnit="raid"..j
                if not vEnemyUnit[xUnit] then
                    vEnemyUnit[xUnit]=true
                    vPlayerState=HealBot_Panel_checkEnemyBar(xUnit.."target", xUnit, preCombat,
                                                             hbv_Skins_GetVar("Enemy", "EXISTSHOWRAID"),
                                                             hbv_Skins_GetVar("Enemy", "INCOMBATSHOWRAID"),
                                                             playerFrame, vPlayerState, "enemyPlayerTargets - raid")
                end
            end
        end
    end
    return vPlayerState
end

function HealBot_Panel_enemyTargets(preCombat)
        --HealBot_setCall("HealBot_Panel_enemyTargets")
    HeaderPos[hbCurrentFrame][i[hbCurrentFrame]+1]=HEALBOT_OPTIONS_TARGETHEALS
    vEnemyIndex=i[hbCurrentFrame]
    if HEALBOT_GAME_VERSION>1 and hbv_Skins_GetBoolean("Enemy", "INCFOCUS") then
        HealBot_Panel_checkEnemyBar("focus", "player", preCombat,
                                    hbv_Skins_GetVar("Enemy", "EXISTSHOWFOCUS"),
                                    hbv_Skins_GetVar("Enemy", "INCOMBATSHOWFOCUS"),
                                    1, false, "enemyTargets")
    end
    _,vEnemyLocation=IsInInstance()
    if vEnemyLocation == "arena" then
        if hbv_Skins_GetBoolean("Enemy", "INCARENA") then
            for j=1,GetNumGroupMembers() do
                xUnit="arena"..j;
                HealBot_Panel_checkEnemyBar(xUnit, "player", preCombat,
                                            hbv_Skins_GetVar("Enemy", "EXISTSHOWARENA"),
                                            hbv_Skins_GetVar("Enemy", "INCOMBATSHOWARENA"),
                                            1, false, "enemyTargets")
            end
        end
        if hbv_Skins_GetBoolean("Enemy", "INCARENAPETS") then
            for j=1,GetNumGroupMembers() do
                xUnit="arenapet"..j;
                HealBot_Panel_checkEnemyBar(xUnit, "player", preCombat,
                                            hbv_Skins_GetVar("Enemy", "EXISTSHOWARENA"),
                                            hbv_Skins_GetVar("Enemy", "INCOMBATSHOWARENA"),
                                            1, false, "enemyTargets")
            end
        end
    end

    if HEALBOT_GAME_VERSION>2 then
        vEnemyBossNum=hbv_Skins_GetVar("Enemy", "NUMBOSS")
        if hbv_Skins_GetBoolean("Enemy", "EXISTSHOWBOSS") then
            vEnemyBossExist=2
        else
            vEnemyBossExist=1
        end
        if HealBot_Panel_luVars["MAPID"] == 953 then
            if UnitExists("boss1") then
                if vEnemyBossNum<3 then vEnemyBossNum=3 end
                vEnemyBossExist=1
            end
        end

        if vEnemyBossNum>0 then
            for bi=1,vEnemyBossNum do
                xUnit="boss"..bi
                HealBot_Panel_checkEnemyBar(xUnit, "player", preCombat, vEnemyBossExist, vEnemyBossExist, 1, false, "enemyTargets")
            end
        end
    end

    HealBot_Panel_enemyPlayerTargets(preCombat, 1)

    if i[hbCurrentFrame]>vEnemyIndex then
        HealBot_Panel_addUnits(false, hbv_GetUnitType(HEALBOT_ENEMY), HEALBOT_CUSTOM_CASTBY_ENEMY,vEnemyIndex, preCombat)
    end
end

local vTargetValid, vTargetGUID=false,"target"
function HealBot_Panel_validTarget(unit)
        --HealBot_setCall("HealBot_Panel_validTarget", nil, nil, unit)
    if UnitExists(unit) then
        vTargetValid=true
        vTargetGUID=UnitGUID(unit) or unit
        if HealBot_Panel_BlackList[vTargetGUID] then
            vTargetValid=false
        end
    else
        vTargetValid=false
    end
    return vTargetValid
end

local vTargetIndex=0
function HealBot_Panel_targetHeals(preCombat)
        --HealBot_setCall("HealBot_Panel_targetHeals")
    vTargetIndex=i[hbCurrentFrame]
    if UnitExists("target") and (not preCombat or hbv_Skins_GetVar("Healing", "TARGETINCOMBAT")>1) then
        if UnitIsVisible("target") or not hbv_Skins_GetFrameBoolean("BarVisibility", "HIDEOOR", hbCurrentFrame) then
            if preCombat or HealBot_Panel_validTarget("target") then
                i[hbCurrentFrame]=i[hbCurrentFrame]+1;
                table.insert(subunits,"target")
            end
        end
    elseif preCombat and hbv_Skins_GetVar("Healing", "TARGETINCOMBAT") == 3 then
        i[hbCurrentFrame]=i[hbCurrentFrame]+1;
        table.insert(subunits,"target")
    end
    if i[hbCurrentFrame]>vTargetIndex then
        HealBot_Panel_SubSort(false,hbv_GetUnitType(HEALBOT_TARGET), preCombat)
        HeaderPos[hbCurrentFrame][i[hbCurrentFrame]]=HEALBOT_OPTIONS_TARGETHEALS
    end
end

function HealBot_Panel_totHeals(preCombat)
        --HealBot_setCall("HealBot_Panel_targetHeals")
    vTargetIndex=i[hbCurrentFrame]
    if UnitExists("targettarget") and (not preCombat or hbv_Skins_GetVar("Healing", "TOTINCOMBAT")>1) then
        if UnitIsVisible("targettarget") or not hbv_Skins_GetFrameBoolean("BarVisibility", "HIDEOOR", hbCurrentFrame) then
            if preCombat or HealBot_Panel_validTarget("targettarget") then
                i[hbCurrentFrame]=i[hbCurrentFrame]+1;
                table.insert(subunits,"targettarget")
            end
        end
    elseif preCombat and hbv_Skins_GetVar("Healing", "TOTINCOMBAT") == 3 then
        i[hbCurrentFrame]=i[hbCurrentFrame]+1;
        table.insert(subunits,"targettarget")
    end
    if i[hbCurrentFrame]>vTargetIndex then
        HealBot_Panel_SubSort(false,hbv_GetUnitType(HEALBOT_TOT), preCombat)
        HeaderPos[hbCurrentFrame][i[hbCurrentFrame]]=HEALBOT_OPTIONS_TAB_TARGETOFTARGET
    end
end

function HealBot_Panel_UnitUsingVehicle()
        --HealBot_setCall("HealBot_Panel_UnitUsingVehicle")
    return false
end

local HealBot_UnitUsingVehicle=_G["UnitUsingVehicle"] or _G["HealBot_Panel_UnitUsingVehicle"]
local vVehiclePlayerUnit,vVehicleUnit,vVehicleIndex="","",0
function HealBot_Panel_vehicleHeals(preCombat)
        --HealBot_setCall("HealBot_Panel_vehicleHeals")
    if HEALBOT_GAME_VERSION>2 then
        vVehicleIndex=i[hbCurrentFrame]
        if nraid>0 then
            for j=1,nraid do
                vVehicleUnit="raidpet"..j;
                vVehiclePlayerUnit="raid"..j;
                if hbPanel_dataPetUnits[vVehicleUnit] and UnitExists(vVehiclePlayerUnit) and HealBot_UnitUsingVehicle(vVehiclePlayerUnit) and UnitExists(vVehicleUnit) then
                    HealBot_Panel_addUnit(vVehicleUnit, hbv_GetUnitType(HEALBOT_VEHICLE), hbPanel_dataPetUnits[vVehicleUnit], false)
                elseif preCombat and hbv_Skins_GetBoolean("Healing", "VEHICLEINCOMBAT") and hbPanel_dataUnits[vVehiclePlayerUnit] then
                    HealBot_Panel_addUnit(vVehicleUnit, hbv_GetUnitType(HEALBOT_VEHICLE), vVehicleUnit, false)
                end
            end
        else
            vVehicleUnit="pet"
            vVehiclePlayerUnit="player"
            if hbPanel_dataPetUnits[vVehicleUnit] and HealBot_UnitUsingVehicle(vVehiclePlayerUnit) then
                HealBot_Panel_addUnit(vVehicleUnit, hbv_GetUnitType(HEALBOT_VEHICLE), hbPanel_dataPetUnits[vVehicleUnit], false)
            elseif preCombat and hbv_Skins_GetBoolean("Healing", "VEHICLEINCOMBAT") and hbPanel_dataUnits[vVehiclePlayerUnit] then
                HealBot_Panel_addUnit(vVehicleUnit, hbv_GetUnitType(HEALBOT_VEHICLE), vVehicleUnit, false)
            end
            for j=1,4 do
                vVehicleUnit="partypet"..j;
                vVehiclePlayerUnit="party"..j;
                if hbPanel_dataPetUnits[vVehicleUnit] and UnitExists(vVehiclePlayerUnit) and HealBot_UnitUsingVehicle(vVehiclePlayerUnit) and UnitExists(vVehicleUnit) then
                    HealBot_Panel_addUnit(vVehicleUnit, hbv_GetUnitType(HEALBOT_VEHICLE), hbPanel_dataPetUnits[vVehicleUnit], false)
                elseif preCombat and hbv_Skins_GetBoolean("Healing", "VEHICLEINCOMBAT") and hbPanel_dataUnits[vVehiclePlayerUnit] then
                    HealBot_Panel_addUnit(vVehicleUnit, hbv_GetUnitType(HEALBOT_VEHICLE), vVehicleUnit, false)
                end
            end
        end
        if i[hbCurrentFrame]>vVehicleIndex then
            HealBot_Panel_addUnits(true, hbv_GetUnitType(HEALBOT_VEHICLE), HEALBOT_WORD_VEHICLE,vVehicleIndex, preCombat)
        end
    elseif Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][9]["STATE"] then
        Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][9]["STATE"]=false
    end
end

local vPetPlayerUnit,vPetUnit,vPetIndex,vPetGrp5ID="","",0,0
function HealBot_Panel_petHeals(preCombat)
        --HealBot_setCall("HealBot_Panel_petHeals")
    HeaderPos[hbCurrentFrame][i[hbCurrentFrame]+1]=HEALBOT_OPTIONS_PETHEALS
    vPetGrp5ID=0
    vPetIndex=i[hbCurrentFrame]
    if nraid>0 then
        for j=1,nraid do
            vPetUnit="raidpet"..j;
            vPetPlayerUnit="raid"..j;
            if UnitExists(vPetUnit) and hbPanel_dataPetUnits[vPetUnit] and not HealBot_UnitUsingVehicle(vPetPlayerUnit) then
                HealBot_Panel_addUnit(vPetUnit, hbv_GetUnitType(HEALBOT_PET), hbPanel_dataPetUnits[vPetUnit], false)
            elseif preCombat and hbv_Skins_GetBoolean("Healing", "MYPETINCOMBAT") and UnitIsUnit(vPetPlayerUnit, "player") then
                HealBot_Panel_addUnit(vPetUnit, hbv_GetUnitType(HEALBOT_PET), vPetUnit, false)
            end
            if hbv_Skins_GetBoolean("Healing", "GROUPPETS") then
                if i[hbCurrentFrame]-vPetIndex == 6 then
                    vPetGrp5ID=vPetGrp5ID+1
                    HeaderPos[hbCurrentFrame][i[hbCurrentFrame]-5]=HEALBOT_OPTIONS_PETHEALS.." "..vPetGrp5ID
                end
                if i[hbCurrentFrame]>vPetIndex and ((i[hbCurrentFrame]-vPetIndex)%5 == 0) then
                    HealBot_Panel_MainSort(true, hbv_GetUnitType(HEALBOT_PET), preCombat)
                    vPetGrp5ID=vPetGrp5ID+1
                    HeaderPos[hbCurrentFrame][i[hbCurrentFrame]+1]=HEALBOT_OPTIONS_PETHEALS.." "..vPetGrp5ID
                end
            end
        end
        if not HeaderPos[hbCurrentFrame][vPetIndex+1] and hbv_Skins_GetBoolean("Healing", "GROUPPETS") and i[hbCurrentFrame]-vPetIndex == 5 then
            vPetGrp5ID=vPetGrp5ID+1
            HeaderPos[hbCurrentFrame][vPetIndex+1]=HEALBOT_OPTIONS_PETHEALS.." "..vPetGrp5ID
        end
    else
        vPetUnit="pet"
        vPetPlayerUnit="player"
        if UnitExists(vPetUnit) and hbPanel_dataPetUnits[vPetUnit] and not HealBot_UnitUsingVehicle(vPetPlayerUnit) and not HealBot_Panel_luVars["SelfPets"] then
            HealBot_Panel_addUnit(vPetUnit, hbv_GetUnitType(HEALBOT_PET), hbPanel_dataPetUnits[vPetUnit], false)
        elseif preCombat and hbv_Skins_GetBoolean("Healing", "MYPETINCOMBAT") then
            HealBot_Panel_addUnit(vPetUnit, hbv_GetUnitType(HEALBOT_PET), vPetUnit, false)
        end
        for j=1,4 do
            vPetUnit="partypet"..j;
            vPetPlayerUnit="party"..j;
            if UnitExists(vPetUnit) and hbPanel_dataPetUnits[vPetUnit] and not HealBot_UnitUsingVehicle(vPetPlayerUnit) then
                HealBot_Panel_addUnit(vPetUnit, hbv_GetUnitType(HEALBOT_PET), hbPanel_dataPetUnits[vPetUnit], false)
            end
        end
    end
    if i[hbCurrentFrame]>vPetIndex then
        HealBot_Panel_MainSort(true, hbv_GetUnitType(HEALBOT_PET), preCombat)
        if not hbv_Skins_GetBoolean("Healing", "GROUPPETS") then
            HeaderPos[hbCurrentFrame][vPetIndex+1]=HEALBOT_OPTIONS_PETHEALS
        elseif nraid == 0 or (not HeaderPos[hbCurrentFrame][vPetIndex+1] and (i[hbCurrentFrame]-vPetIndex)%5>0) then
            vPetGrp5ID=vPetGrp5ID+1
            HeaderPos[hbCurrentFrame][vPetIndex+1]=HEALBOT_OPTIONS_PETHEALS.." "..vPetGrp5ID
        end
    end
end

local vRaidTargetNum,vRaidTargetGroup,vRaidUnit,vRaidIndex,vCrashProtData,vCrashProtTmp=0,8,"",0,"1","0"
local vRaidPrevSort,vRaidHeadSort,vRaidSubSort,vRaidShowHeader="","","init",false
function HealBot_Panel_raidHeals(preCombat)
        --HealBot_setCall("HealBot_Panel_raidHeals")
    vRaidIndex=i[hbCurrentFrame]
    if hbv_Skins_GetFrameVar("BarSort", "RAIDORDER", hbCurrentFrame) == 1 or hbv_Skins_GetFrameVar("BarSort", "RAIDORDER", hbCurrentFrame) == 5 then
        HeaderPos[hbCurrentFrame][i[hbCurrentFrame]+1]=HEALBOT_OPTIONS_EMERGENCYHEALS
    end

    vRaidTargetNum=nraid
    if preCombat and nraid>0 and HealBot_Panel_luVars["cpRaid"] then
        if vRaidTargetNum<11 then
            vRaidTargetNum=10
            vRaidTargetGroup=2
        elseif vRaidTargetNum<16 then
            vRaidTargetNum=15
            vRaidTargetGroup=3
        elseif vRaidTargetNum<26 then
            vRaidTargetNum=25
            vRaidTargetGroup=5
        else
            vRaidTargetNum=40
            vRaidTargetGroup=8
        end
    end

    if nraid>0 then
        for j=1,vRaidTargetNum do
            vRaidUnit="raid"..j;
            if UnitIsUnit(vRaidUnit,"player") then
                HealBot_Data["PUNIT"]=vRaidUnit
                if MyGroup["GROUP"]>0 then
                    local _, _, subgroup=GetRaidRosterInfo(j);
                    HeaderPos[MyGroup["FRAME"]][MyGroup["GROUP"]]=HEALBOT_SORTBY_GROUP.." "..subgroup
                end
            end
            if hbPanel_dataUnits[vRaidUnit] then
                HealBot_Panel_addUnit(vRaidUnit, hbv_GetUnitType(HEALBOT_RAID), hbPanel_dataUnits[vRaidUnit], true)
            elseif preCombat and (HealBot_Panel_luVars["cpCrash"] or HealBot_Panel_luVars["cpRaid"]) then
                HealBot_UnitGroups[vRaidUnit]=vRaidTargetGroup
                HealBot_Panel_addUnit(vRaidUnit, hbv_GetUnitType(HEALBOT_RAID), vRaidUnit, true)
            end
        end
    else
        for xUnit,n in pairs(HealBot_Action_HealGroup) do
            if hbPanel_dataUnits[xUnit] then
                HealBot_Panel_addUnit(xUnit, hbv_GetUnitType(HEALBOT_RAID), hbPanel_dataUnits[xUnit], true)
            elseif preCombat then
                if (IsInGroup() and HealBot_Panel_luVars["cpGroup"]) or
                   (HealBot_Panel_luVars["cpCrash"] and HealBot_Panel_luVars["cpCrashType"] == "g" and n<=HealBot_Panel_luVars["cpCrashNum"]) then
                    HealBot_UnitGroups[xUnit]=1
                    HealBot_Panel_addUnit(xUnit, hbv_GetUnitType(HEALBOT_RAID), xUnit, true)
                end
            end
        end
    end

    --if hbv_Skins_GetFrameVar("BarSort", "RAIDORDER", hbCurrentFrame)<6 then
        table.sort(units,function (a,b)
            if order[a]<order[b] then return true end
            if order[a]>order[b] then return false end
            return a<b
        end)
    --end
    vRaidPrevSort,vRaidHeadSort,vRaidSubSort,vRaidShowHeader="","","init",false
    if hbv_Skins_GetFrameVar("BarSort", "RAIDORDER", hbCurrentFrame) == 2 or
           hbv_Skins_GetFrameVar("BarSort", "RAIDORDER", hbCurrentFrame) == 3 or
           hbv_Skins_GetFrameVar("BarSort", "RAIDORDER", hbCurrentFrame) == 5 then
        vRaidShowHeader=true
    end

    for j=1,#units do
        vRaidUnit=units[j];
        i[hbCurrentFrame]=i[hbCurrentFrame]+1;
        if hbv_Skins_GetFrameVar("BarSort", "RAIDORDER", hbCurrentFrame)<6 then
            if vRaidSubSort~=order[vRaidUnit] then
                if vRaidShowHeader then
                    if hbv_Skins_GetFrameVar("BarSort", "RAIDORDER", hbCurrentFrame) == 2 then
                        vRaidHeadSort=UnitClass(vRaidUnit) or HEALBOT_WARRIOR
                    elseif hbv_Skins_GetFrameVar("BarSort", "RAIDORDER", hbCurrentFrame) == 3 then
                        vRaidHeadSort=HEALBOT_SORTBY_GROUP.." "..order[vRaidUnit]
                    elseif hbv_Skins_GetFrameVar("BarSort", "RAIDORDER", hbCurrentFrame) == 5 then
                        vRaidHeadSort=HealBot_unitRole[vRaidUnit] or hbRole[HEALBOT_WORD_DPS]
                    end
                    HeaderPos[hbCurrentFrame][i[hbCurrentFrame]]=vRaidHeadSort
                end
                HealBot_Panel_SubSort(true, hbv_GetUnitType(HEALBOT_RAID), preCombat)
                vRaidSubSort=order[vRaidUnit]
                vRaidPrevSort=vRaidHeadSort
            end
        end
        HealBot_Panel_insSort(vRaidUnit, false)
    end
    if #units>0 then
        HealBot_Panel_SubSort(true, hbv_GetUnitType(HEALBOT_RAID), preCombat)
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
        --HealBot_setCall("HealBot_Panel_validFocus")
    if UnitExists("focus") then
        vFocusUnitValid=true
        vFocusGUID=UnitGUID("focus") or "focus"
        if HealBot_Panel_BlackList[vFocusGUID] then
            vFocusUnitValid=false
        end
    else
        vFocusUnitValid=false
    end
    return vFocusUnitValid
end

local vFocusIndex=0
function HealBot_Panel_focusHeals(preCombat)
        --HealBot_setCall("HealBot_Panel_focusHeals")
    vFocusIndex=i[hbCurrentFrame]
    if UnitExists("focus") and (not preCombat or hbv_Skins_GetVar("Healing", "FOCUSINCOMBAT")>1) then
        if preCombat then
            i[hbCurrentFrame]=i[hbCurrentFrame]+1;
            table.insert(subunits,"focus")
        elseif UnitIsVisible("focus") or not hbv_Skins_GetFrameBoolean("BarVisibility", "HIDEOOR", hbCurrentFrame) then
            if HealBot_Panel_validFocus() then
                i[hbCurrentFrame]=i[hbCurrentFrame]+1;
                table.insert(subunits,"focus")
            end
        else
            HealBot_setNotVisible("focus",4)
        end
    elseif preCombat and hbv_Skins_GetVar("Healing", "FOCUSINCOMBAT") == 3 then
        i[hbCurrentFrame]=i[hbCurrentFrame]+1;
        table.insert(subunits,"focus")
    end
    if i[hbCurrentFrame]>vFocusIndex then
        HealBot_Panel_SubSort(false, hbv_GetUnitType(HEALBOT_FOCUS), preCombat)
        HeaderPos[hbCurrentFrame][i[hbCurrentFrame]]=HEALBOT_WORD_FOCUS
    end
end

function HealBot_Panel_tofHeals(preCombat)
        --HealBot_setCall("HealBot_Panel_tofHeals")
    vFocusIndex=i[hbCurrentFrame]
    if UnitExists("focustarget") and (not preCombat or hbv_Skins_GetVar("Healing", "TOFINCOMBAT")>1) then
        if preCombat then
            i[hbCurrentFrame]=i[hbCurrentFrame]+1;
            table.insert(subunits,"focustarget")
        elseif UnitIsVisible("focustarget") or not hbv_Skins_GetFrameBoolean("BarVisibility", "HIDEOOR", hbCurrentFrame) then
            if HealBot_Panel_validFocus() then
                i[hbCurrentFrame]=i[hbCurrentFrame]+1;
                table.insert(subunits,"focustarget")
            end
        else
            HealBot_setNotVisible("focustarget",4)
        end
    elseif preCombat and hbv_Skins_GetVar("Healing", "TOFINCOMBAT") == 3 then
        i[hbCurrentFrame]=i[hbCurrentFrame]+1;
        table.insert(subunits,"focustarget")
    end
    if i[hbCurrentFrame]>vFocusIndex then
        HealBot_Panel_SubSort(false, hbv_GetUnitType(HEALBOT_FOCUS), preCombat)
        HeaderPos[hbCurrentFrame][i[hbCurrentFrame]]=HEALBOT_WORD_FOCUS
    end
end

local vMyTargetsIndex,vMyTargetsUnit=0,"unknown"
function HealBot_Panel_privList(preCombat)
        --HealBot_setCall("HealBot_Panel_privList")
    vMyTargetsIndex=i[hbCurrentFrame]
    for xGUID,_ in pairs(HealBot_MyHealTargets) do
        vMyTargetsUnit=hbPanel_dataGUIDs[xGUID] or hbPanel_dataPetGUIDs[xGUID] or "unknown"
        if UnitExists(vMyTargetsUnit) then
            HealBot_Panel_addUnit(vMyTargetsUnit, hbv_GetUnitType(HEALBOT_PRIVATELIST), xGUID, false)
        end
    end
    for xGUID,_ in pairs(HealBot_Globals.PermMyTargets) do
        vMyTargetsUnit=hbPanel_dataGUIDs[xGUID] or hbPanel_dataPetGUIDs[xGUID] or "unknown"
        if UnitExists(vMyTargetsUnit) then
            HealBot_Panel_addUnit(vMyTargetsUnit, hbv_GetUnitType(HEALBOT_PRIVATELIST), xGUID, false)
            HealBot_Panel_SetPermPrivateData(vMyTargetsUnit, xGUID)
        end
    end
    if i[hbCurrentFrame]>vMyTargetsIndex then
        HealBot_Panel_addUnits(true, hbv_GetUnitType(HEALBOT_PRIVATELIST), HEALBOT_OPTIONS_MYTARGET,vMyTargetsIndex, preCombat)
    end
end

function HealBot_Panel_privFocus(preCombat)
    if HealBot_Panel_luVars["PrivFocusUnit"] then
        vMyTargetsIndex=i[hbCurrentFrame]
        vMyTargetsUnit=HealBot_Panel_luVars["PrivFocusUnit"]
        if UnitExists(vMyTargetsUnit) and (not preCombat or hbv_Skins_GetVar("Healing", "PRIVFOCUSINCOMBAT")>1) then
            if HealBot_Config.PrivFocus == UnitGUID(vMyTargetsUnit) then
                HealBot_Panel_addUnit(vMyTargetsUnit, hbv_GetUnitType(HEALBOT_PRIVATEFOCUS), HealBot_Config.PrivFocus, false)
                HealBot_Panel_SetPermPrivateData(vMyTargetsUnit, HealBot_Config.PrivFocus, true)
            end
        elseif preCombat and hbv_Skins_GetVar("Healing", "PRIVFOCUSINCOMBAT") == 3 then
            HealBot_Panel_addUnit(vMyTargetsUnit, hbv_GetUnitType(HEALBOT_PRIVATEFOCUS), HealBot_Config.PrivFocus, false)
        end
        if i[hbCurrentFrame]>vMyTargetsIndex then
            HealBot_Panel_addUnits(true, hbv_GetUnitType(HEALBOT_PRIVATEFOCUS), HEALBOT_OPTIONS_PRIVFOCUS, vMyTargetsIndex, preCombat)
        end
    end
end

function HealBot_Panel_privFocusToT(preCombat)
    if HealBot_Panel_luVars["PrivFocusUnit"] and HealBot_Config.PrivFocus == UnitGUID(HealBot_Panel_luVars["PrivFocusUnit"]) then
        vMyTargetsIndex=i[hbCurrentFrame]
        vMyTargetsUnit=HealBot_Panel_luVars["PrivFocusUnit"].."targettarget"
        if UnitExists(vMyTargetsUnit) and (not preCombat or hbv_Skins_GetVar("Healing", "PRIVFOCUSINCOMBAT")>1) then
            HealBot_Panel_addUnit(vMyTargetsUnit, hbv_GetUnitType(HEALBOT_PRIVFOCUSTOT), UnitGUID(vMyTargetsUnit), false)
        elseif preCombat and hbv_Skins_GetVar("Healing", "PRIVFOCUSINCOMBAT") == 3 then
            HealBot_Panel_addUnit(vMyTargetsUnit, hbv_GetUnitType(HEALBOT_PRIVFOCUSTOT), vMyTargetsUnit, false)
        end
        if i[hbCurrentFrame]>vMyTargetsIndex then
            HealBot_Panel_addUnits(true, hbv_GetUnitType(HEALBOT_PRIVFOCUSTOT), HEALBOT_OPTIONS_TARGETOFPRIVFOCUSTAR, vMyTargetsIndex, preCombat)
        end
    end
end

local vGroupIndex=0
function HealBot_Panel_groupHeals(preCombat)
        --HealBot_setCall("HealBot_Panel_groupHeals")
    vGroupIndex=i[hbCurrentFrame]
    for xUnit,n in pairs(HealBot_Action_HealGroup) do
        if UnitExists(xUnit) and UnitGUID(xUnit) and hbPanel_dataGUIDs[UnitGUID(xUnit)] then
            if nraid>0 then
                xUnit=hbPanel_dataGUIDs[UnitGUID(xUnit)] or xUnit
            end
            HealBot_Panel_addUnit(xUnit, hbv_GetUnitType(HEALBOT_GROUP), hbPanel_dataUnits[xUnit], false)
        elseif nraid == 0 and preCombat then
            if (IsInGroup() and HealBot_Panel_luVars["cpGroup"]) or
               (HealBot_Panel_luVars["cpCrash"] and HealBot_Panel_luVars["cpCrashType"] == "g" and n<=HealBot_Panel_luVars["cpCrashNum"]) then
                HealBot_UnitGroups[xUnit]=1
                HealBot_Panel_addUnit(xUnit, hbv_GetUnitType(HEALBOT_GROUP), xUnit, false)
            end
        end
    end
    if i[hbCurrentFrame]>vGroupIndex then
        HealBot_Panel_addUnits(true, hbv_GetUnitType(HEALBOT_GROUP), HEALBOT_SORTBY_GROUP,vGroupIndex, preCombat)
        MyGroup["GROUP"]=vGroupIndex+1
        MyGroup["FRAME"]=hbCurrentFrame
    else
        MyGroup["GROUP"]=0
    end
end

local vHealIndex=0
function HealBot_Panel_healerHeals(preCombat)
        --HealBot_setCall("HealBot_Panel_healerHeals")
    vHealIndex=i[hbCurrentFrame]
    for xGUID,xUnit in pairs(HealBot_MainHealers) do
        HealBot_Panel_addUnit(xUnit, hbv_GetUnitType(HEALBOT_HEALER), xGUID, false)
    end
    if i[hbCurrentFrame]>vHealIndex then
        HealBot_Panel_addUnits(true, hbv_GetUnitType(HEALBOT_HEALER), HEALBOT_CLASSES_HEALERS,vHealIndex, preCombat)
    end
end

local vTankIndex=0
function HealBot_Panel_tankHeals(preCombat)
        --HealBot_setCall("HealBot_Panel_tankHeals")
    vTankIndex=i[hbCurrentFrame]
    for xGUID,xUnit in pairs(HealBot_MainTanks) do
        HealBot_Panel_addUnit(xUnit, hbv_GetUnitType(HEALBOT_TANK), xGUID, false)
    end
    if i[hbCurrentFrame]>vTankIndex then
        HealBot_Panel_addUnits(true, hbv_GetUnitType(HEALBOT_TANK), HEALBOT_OPTIONS_TANKHEALS,vTankIndex, preCombat)
    end
end

local vSelfIndex,vSelfPetIndex,vSelfUnit,vSelfPetUnit=0,0,"player","pet"
function HealBot_Panel_selfHeals(preCombat)
        --HealBot_setCall("HealBot_Panel_selfHeals")
    vSelfIndex=i[hbCurrentFrame]
    HealBot_Panel_luVars["SelfPets"]=false
    HealBot_Panel_addUnit(vSelfUnit, hbv_GetUnitType(HEALBOT_SELF), HealBot_Data["PGUID"], false)
    if i[hbCurrentFrame]>vSelfIndex then
        if hbv_Skins_GetBoolean("Healing", "SELFPET") and hbPanel_dataPetUnits[vSelfPetUnit] and HealBot_Config.DisabledNow == 0 then
            vSelfPetIndex=i[hbCurrentFrame]
            HealBot_Panel_addUnit(vSelfPetUnit, hbv_GetUnitType(HEALBOT_SELF), hbPanel_dataPetUnits[vSelfPetUnit], false)
            if i[hbCurrentFrame]>vSelfPetIndex then HealBot_Panel_luVars["SelfPets"]=true end
        end
        HealBot_Panel_addUnits(false, hbv_GetUnitType(HEALBOT_SELF), HEALBOT_OPTIONS_SELFHEALS,vSelfIndex, preCombat)
    end
end

local hbShowButtons={}
function HealBot_Panel_ButtonHide(button)
    hbShowButtons[button.id]=nil
    button:Hide()
    button.status.active=false
    if HealBot_Emerg_Button[button.id] then HealBot_Emerg_Button[button.id]:Hide() end
    button.status.enabled=false
end

function HealBot_Panel_ButtonShow(button, incEmerg)
    hbShowButtons[button.id]=nil
    button:Show()
    if incEmerg and hbv_Skins_GetFrameBoolean("Emerg", "USE", button.frame) then
        HealBot_Emerg_Button[button.id]:Show()
    end
end

function HealBot_Panel_ButtonShowNow()
    for id,incEmerg in pairs(hbShowButtons) do
        if incEmerg == 1 then
            HealBot_Panel_ButtonShow(HealBot_Buttons[id], false)
        else
            HealBot_Panel_ButtonShow(HealBot_Buttons[id], true)
        end
    end
end

function HealBot_Panel_DoUnitShow(button, incEmerg)
        --HealBot_setCall("HealBot_Panel_DoUnitShow", button)
    if hbShowButtons[button.id] then
        HealBot_Panel_ButtonShow(button, incEmerg)
    end
end

function HealBot_Panel_UnitShow(button, incEmerg, preCombat)
        --HealBot_setCall("HealBot_Panel_UnitShow", button)
    if preCombat then
        HealBot_Panel_ButtonShow(button, incEmerg)
    else
        if incEmerg then
            hbShowButtons[button.id]=2
        else
            hbShowButtons[button.id]=1
        end
        C_Timer.After(0.125, function() HealBot_Panel_DoUnitShow(button, incEmerg) end)
    end
end

function HealBot_Panel_PetVehicleShow(button, preCombat)
        --HealBot_setCall("HealBot_Panel_PetVehicleShow", button)
    HealBot_Panel_UnitShow(button, true, preCombat)
    HealBot_Panel_luVars["NumPets"]=HealBot_Panel_luVars["NumPets"]+1
end

function HealBot_Panel_VehicleChanged(preCombat)
        --HealBot_setCall("HealBot_Panel_VehicleChanged")
    HealBot_Panel_InitFrame(6,7)
    hbBarsPerFrame[hbCurrentFrame]=0
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][9]["STATE"] then
        i[hbCurrentFrame]=0
        HeaderPos[hbCurrentFrame]={};
        HealBot_Panel_vehicleHeals(preCombat)
        for xUnit,xButton in pairs(HealBot_Vehicle_Button) do
            if hbv_IsUnitType(xButton.status.unittype, HEALBOT_VEHICLE) then
                if HealBot_TrackUnit[xButton.status.unittype][xUnit] then
                    HealBot_Panel_PetVehicleShow(xButton, preCombat)
                else
                    HealBot_Action_MarkDeleteButton(xButton)
                end
            end
        end
        HealBot_Panel_SetupExtraBars(hbCurrentFrame, preCombat)
    else
        for xUnit,xButton in pairs(HealBot_Vehicle_Button) do
            if hbv_IsUnitType(xButton.status.unittype, HEALBOT_VEHICLE) then
                HealBot_Action_MarkDeleteButton(xButton)
            end
        end
        HealBot_Action_HidePanel(hbCurrentFrame)
    end
end

function HealBot_Panel_PetsChanged(preCombat)
        --HealBot_setCall("HealBot_Panel_PetsChanged")
    HealBot_Panel_InitFrame(7,8)
    hbBarsPerFrame[hbCurrentFrame]=0
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["STATE"] then
        i[hbCurrentFrame]=0
        HeaderPos[hbCurrentFrame]={};
        HealBot_Panel_petHeals(preCombat)
        for xUnit,xButton in pairs(HealBot_Pet_Button) do
            if hbv_IsUnitType(xButton.status.unittype, HEALBOT_PET) then
                if HealBot_TrackUnit[xButton.status.unittype][xUnit] then
                    HealBot_Panel_PetVehicleShow(xButton, preCombat)
                elseif not UnitIsUnit(xButton.unit,"pet") or not HealBot_Panel_luVars["SelfPets"] then
                    HealBot_Action_MarkDeleteButton(xButton)
                end
            end
        end
        HealBot_Panel_SetupExtraBars(hbCurrentFrame, preCombat)
        if HealBot_Panel_luVars["NumPets"]>HealBot_retLuVars("NumPetUnits") then
            HealBot_setLuVars("NumPetUnits", HealBot_Panel_luVars["NumPets"])
        end
    else
        for xUnit,xButton in pairs(HealBot_Pet_Button) do
            if hbv_IsUnitType(xButton.status.unittype, HEALBOT_PET) then
                HealBot_Action_MarkDeleteButton(xButton)
            end
        end
        HealBot_Action_HidePanel(hbCurrentFrame)
    end
end

function HealBot_Panel_TargetShow(button, preCombat)
        --HealBot_setCall("HealBot_Panel_TargetShow", button)
    HealBot_setLuVars("TargetNeedReset", false)
    HealBot_Panel_UnitShow(button, true, preCombat)
    HealBot_Panel_TargetChangedCheckFocus()
end

local vTargetButton=""
function HealBot_Panel_TargetChanged(preCombat)
        --HealBot_setCall("HealBot_Panel_TargetChanged")
    HealBot_Panel_InitFrame(8,9)
    hbBarsPerFrame[hbCurrentFrame]=0
    i[hbCurrentFrame]=0
    HeaderPos[hbCurrentFrame]={}
    
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][11]["STATE"] then
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][11]["FRAME"] == 8 then
            HealBot_Panel_targetHeals(preCombat)
            vTargetButton=HealBot_Extra_Button["target"]
            if vTargetButton then
                if HealBot_TrackUnit[vTargetButton.status.unittype][vTargetButton.unit] and not HealBot_Panel_BlackList[vTargetButton.guid] then
                    HealBot_Panel_TargetShow(vTargetButton, preCombat)
                else
                    HealBot_Action_MarkDeleteButton(vTargetButton)
                end
            end
        end
    elseif HealBot_Extra_Button["target"] then
        HealBot_Action_MarkDeleteButton(HealBot_Extra_Button["target"])
    end
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][12]["STATE"] then
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][12]["FRAME"] == 8 then
            HealBot_Panel_totHeals(preCombat)
            vTargetButton=HealBot_Extra_Button["targettarget"]
            if vTargetButton then
                if HealBot_TrackUnit[vTargetButton.status.unittype][vTargetButton.unit] and not HealBot_Panel_BlackList[vTargetButton.guid] then
                    HealBot_Panel_TargetShow(vTargetButton, preCombat)
                else
                    HealBot_Action_MarkDeleteButton(vTargetButton)
                end
            end
        end
    elseif HealBot_Extra_Button["targettarget"] then
        HealBot_Action_MarkDeleteButton(HealBot_Extra_Button["targettarget"])
    end
    if i[hbCurrentFrame]>0 then
        HealBot_Panel_SetupExtraBars(hbCurrentFrame, preCombat)
    else
        HealBot_Action_HidePanel(hbCurrentFrame)
    end
end

local vFocusParent, vFocusFrame="",""
function HealBot_Panel_TargetChangedCheckFocus()
      --HealBot_setCall("HealBot_Panel_TargetChangedCheckFocus")
    if hbPanelShowhbFocus then
        local tButton=HealBot_Extra_Button["target"]
        if tButton then
            vFocusFrame=_G["hbExtra_HealUnit999"]
            local vFocusParent=_G["f8_HealBot_Action"]
            if not vFocusFrame then
                vFocusFrame=CreateFrame("Button", "hbExtra_HealUnit999", vFocusParent, "HealBotFocusButtonTemplate")
                local bar=_G[vFocusFrame:GetName().."Bar"]
                bar:SetMinMaxValues(0,100);
                bar:SetValue(100);
                bar:UnregisterAllEvents()
                HealBot_Media_UpdateDefaultTexture(bar, "Panel_TargetChangedCheckFocus")
                bar:GetStatusBarTexture():SetHorizTile(false)
                bar:SetStatusBarColor(1,1,1,1);
                HealBot_Action_SethbFocusButtonAttrib(vFocusFrame)
                vFocusFrame.id=999
                vFocusFrame.name="hbExtra_HealUnit999"
                vFocusFrame.frame=8
                HealBot_Action_OnLoad(vFocusFrame)
                vFocusFrame:RegisterForClicks("LeftButtonUp", "RightButtonUp")
                bar.txt=_G[bar:GetName().."_text"]
                bar.txt2=_G[bar:GetName().."_text2"]
                HealBot_Media_UpdateDefaultFont(bar.txt,11,1,"Panel_TargetChangedCheckFocus")
                bar.txt:SetTextColor(0,0,0,1);
                HealBot_Media_UpdateDefaultFont(bar.txt2,11,1,"Panel_TargetChangedCheckFocus")
                bar.txt2:SetTextColor(0,0,0,1);
                bar.txt:SetText(HEALBOT_ACTION_HBFOCUS)
            end
            if not HealBot_Data["UILOCK"] and UnitExists("target") and HealBot_Globals.FocusMonitor[UnitName("target")] then
                if UnitExists("focus") and HealBot_Globals.FocusMonitor[UnitName("focus")] then
                    vFocusFrame:Hide()
                else
                    HealBot_Skins_ResetSkin("hbfocus",vFocusFrame,hbv_Skins_GetFrameVar("HealBar", "NUMCOLS", 8))
                    vFocusFrame:ClearAllPoints()
                    if hbv_Skins_GetFrameVar("Anchors", "BARS", 8) == 2 or hbv_Skins_GetFrameVar("Anchors", "BARS", 8) == 4 then
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

function HealBot_Panel_FocusShow(button, preCombat)
      --HealBot_setCall("HealBot_Panel_FocusShow", button)
    HealBot_setLuVars("FocusNeedReset", false)
    HealBot_Panel_UnitShow(button, true, preCombat)
end

local vFocusButton=""
function HealBot_Panel_FocusChanged(preCombat)
      --HealBot_setCall("HealBot_Panel_FocusChanged")
    if HEALBOT_GAME_VERSION>1 then
        HealBot_Panel_InitFrame(9,10)
        hbBarsPerFrame[hbCurrentFrame]=0
        i[hbCurrentFrame]=0
        HeaderPos[hbCurrentFrame]={}
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][13]["STATE"] then
            if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][13]["FRAME"] == 9 then
                HealBot_Panel_focusHeals(preCombat)
                vFocusButton=HealBot_Extra_Button["focus"]
                if vFocusButton then
                    if HealBot_TrackUnit[vFocusButton.status.unittype][vFocusButton.unit] and not HealBot_Panel_BlackList[vFocusButton.guid] then
                        HealBot_Panel_FocusShow(vFocusButton, preCombat)
                    else
                        HealBot_Action_MarkDeleteButton(vFocusButton)
                    end
                end
            end
        elseif HealBot_Extra_Button["focus"] then
            HealBot_Action_MarkDeleteButton(HealBot_Extra_Button["focus"])
        end
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][14]["STATE"] then
            if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][14]["FRAME"] == 9 then
                HealBot_Panel_tofHeals(preCombat)
                vFocusButton=HealBot_Extra_Button["focustarget"]
                if vFocusButton then
                    if HealBot_TrackUnit[vFocusButton.status.unittype][vFocusButton.unit] and not HealBot_Panel_BlackList[vFocusButton.guid] then
                        HealBot_Panel_FocusShow(vFocusButton, preCombat)
                    else
                        HealBot_Action_MarkDeleteButton(vFocusButton)
                    end
                end
            end
        elseif HealBot_Extra_Button["focustarget"] then
            HealBot_Action_MarkDeleteButton(HealBot_Extra_Button["focustarget"])
        end
        if hbBarsPerFrame[hbCurrentFrame]>0 then
            HealBot_Panel_SetupExtraBars(hbCurrentFrame, preCombat)
        else
            HealBot_Action_HidePanel(hbCurrentFrame)
        end
    else
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][13]["STATE"] then Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][13]["STATE"]=false end
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][14]["STATE"] then Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][14]["STATE"]=false end
    end
end

function HealBot_Panel_IsTargetingEnemy(unit)
      --HealBot_setCall("HealBot_Panel_IsTargetingEnemy", nil, nil, unit)
    return hbPanel_enemyUnits[unit]
end

function HealBot_Panel_EnemyChanged(preCombat)
      --HealBot_setCall("HealBot_Panel_EnemyChanged")
    HealBot_Panel_InitFrame(10,11)
    hbBarsPerFrame[hbCurrentFrame]=0
    for x,_ in pairs(hbPanel_enemyUnits) do
        hbPanel_enemyUnits[x]=nil;
    end
    --for _,xButton in pairs(HealBot_Enemy_Button) do
    --    HealBot_Action_MarkDeleteButton(xButton)
    --end
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][15]["STATE"] then
        i[hbCurrentFrame]=0
        HeaderPos[hbCurrentFrame]={};
        HealBot_Panel_enemyTargets(preCombat)
        for xUnit,xButton in pairs(HealBot_Enemy_Button) do
            if HealBot_TrackUnit[xButton.status.unittype][xUnit] then
                HealBot_Panel_UnitShow(xButton, false, preCombat)
            else--if not HealBot_UnitTargets[xUnit] then
                HealBot_Action_MarkDeleteButton(xButton)
            end
        end
        HealBot_Panel_SetupExtraBars(hbCurrentFrame, preCombat)
    else
        for xUnit,xButton in pairs(HealBot_Enemy_Button) do
            --if not HealBot_UnitTargets[xUnit] then
                HealBot_Action_MarkDeleteButton(xButton)
            --end
        end
        HealBot_Action_HidePanel(hbCurrentFrame)
    end
end

local vPetsWithPlayers,vVehicleWithPlayers,vTargetWithPlayers,vToTWithPlayers,vFocusWithPlayers,vToFWithPlayers=false,false,false,false,false,false
local vActiveFrames={}
function HealBot_Panel_PlayersChanged(preCombat)
      --HealBot_setCall("HealBot_Panel_PlayersChanged")
    TempMaxH=9;
    HealBot_Data["PUNIT"]="player"
    if HealBot_Panel_luVars["cpCrash"] and HealBot_Panel_luVars["cpCrashType"] == "r" then
        nraid=HealBot_Panel_luVars["cpCrashNum"]
    elseif not IsInRaid() then
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
        vActiveFrames[gl]=false
    end

    if HealBot_Config.DisabledNow == 1 then
        HealBot_Panel_InitFrame(1,1)
        HealBot_Panel_selfHeals(preCombat)
    else
        MyGroup["GROUP"]=0
        for gl=1,14 do
            HealBot_Panel_InitFrame(Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["FRAME"], gl)
            if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["STATE"] then
                vActiveFrames[hbCurrentFrame]=true
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
                if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["NAME"] == HEALBOT_OPTIONS_EMERGENCYHEALS_en then
                    HealBot_Panel_raidHeals(preCombat)
                elseif Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["NAME"] == HEALBOT_OPTIONS_GROUPHEALS_en then
                    HealBot_Panel_groupHeals(preCombat)
                elseif Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["NAME"] == HEALBOT_OPTIONS_TANKHEALS_en then
                    HealBot_Panel_tankHeals(preCombat)
                elseif Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["NAME"] == HEALBOT_CLASSES_HEALERS_en then
                    HealBot_Panel_healerHeals(preCombat)
                elseif Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["NAME"] == HEALBOT_OPTIONS_SELFHEALS_en then
                    HealBot_Panel_selfHeals(preCombat)
                elseif Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["NAME"] == HEALBOT_OPTIONS_MYTARGET_en then
                    HealBot_Panel_privList(preCombat)
                elseif Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["NAME"] == HEALBOT_OPTIONS_PRIVFOCUS_en then
                    HealBot_Panel_privFocus(preCombat)
                elseif Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["NAME"] == HEALBOT_OPTIONS_TARGETOFPRIVFOCUSTARGET_en then
                    HealBot_Panel_privFocusToT(preCombat)
                elseif hbCurrentFrame<6 then
                    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["NAME"] == HEALBOT_OPTIONS_PETHEALS_en then
                        HealBot_Panel_petHeals(preCombat)
                    elseif Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["NAME"] == HEALBOT_VEHICLE_en then
                        HealBot_Panel_vehicleHeals(preCombat)
                    elseif Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["NAME"] == HEALBOT_OPTIONS_TARGETHEALS_en then
                        HealBot_Panel_targetHeals(preCombat)
                    elseif Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["NAME"] == HEALBOT_OPTIONS_TARGETOFTARGET_en then
                        HealBot_Panel_totHeals(preCombat)
                    elseif HEALBOT_GAME_VERSION>1 then
                        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["NAME"] == HEALBOT_FOCUS_en then
                            HealBot_Panel_focusHeals(preCombat)
                        elseif Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][gl]["NAME"] == HEALBOT_OPTIONS_TARGETOFFOCUS_en then
                            HealBot_Panel_tofHeals(preCombat)
                        end
                    end
                end
            end
        end
    end
    HealBot_Panel_SetupBars(preCombat)

    for xUnit,xButton in pairs(HealBot_Unit_Button) do
        if xButton.status.unittype>10 and xButton.status.unittype<20 then
            if HealBot_TrackUnit[xButton.status.unittype] and HealBot_TrackUnit[xButton.status.unittype][xUnit] and not HealBot_Panel_BlackList[xButton.guid] then
                HealBot_Panel_UnitShow(xButton, true, preCombat)
            else
                if HealBot_UnitTargets[xUnit] then --and HealBot_UnitTargets[xUnit]>0 then
                    HealBot_Panel_PlayersTargetsDelFrames(xUnit, true)
                end
                HealBot_Action_MarkDeleteButton(xButton)
            end
        elseif xButton.status.unittype<10 or xButton.status.unittype>30 then
            HealBot_Action_MarkDeleteButton(xButton)
        end
    end
    HealBot_Panel_luVars["NumPrivate"]=0
    for xUnit,xButton in pairs(HealBot_Private_Button) do
        if xButton.status.unittype>0 and xButton.status.unittype<10 then
            if HealBot_TrackPrivateUnit[xButton.status.unittype] and HealBot_TrackPrivateUnit[xButton.status.unittype][xUnit] and not HealBot_Panel_BlackList[xButton.guid] then
                HealBot_Panel_UnitShow(xButton, true, preCombat)
                HealBot_Panel_luVars["NumPrivate"]=HealBot_Panel_luVars["NumPrivate"]+1
            else
                if HealBot_UnitTargets[xUnit] then --and HealBot_UnitTargets[xUnit]>0 then
                    HealBot_Panel_PlayersTargetsDelFrames(xUnit, true)
                end
                HealBot_Action_MarkDeleteButton(xButton)
            end
        else
            HealBot_Action_MarkDeleteButton(xButton)
        end
    end
    if HealBot_Panel_luVars["NumPrivate"]>HealBot_retLuVars("NumPrivateUnits") then
        HealBot_setLuVars("NumPrivateUnits", HealBot_Panel_luVars["NumPrivate"])
    end
    if vPetsWithPlayers then
        for xUnit,xButton in pairs(HealBot_Pet_Button) do
            if HealBot_TrackUnit[xButton.status.unittype] and HealBot_TrackUnit[xButton.status.unittype][xUnit] then
                HealBot_Panel_PetVehicleShow(xButton, preCombat)
            else
                HealBot_Action_MarkDeleteButton(xButton)
            end
        end
    end
    if vVehicleWithPlayers then
        for xUnit,xButton in pairs(HealBot_Vehicle_Button) do
            if HealBot_TrackUnit[xButton.status.unittype] and HealBot_TrackUnit[xButton.status.unittype][xUnit] then
                HealBot_Panel_PetVehicleShow(xButton, preCombat)
            else
                HealBot_Action_MarkDeleteButton(xButton)
            end
        end
    end
    if HealBot_Panel_luVars["NumPets"]>HealBot_retLuVars("NumPetUnits") then
        HealBot_setLuVars("NumPetUnits", HealBot_Panel_luVars["NumPets"])
    end
    if vTargetWithPlayers then
        vTargetButton=HealBot_Extra_Button["target"]
        if vTargetButton then
            if HealBot_TrackUnit[vTargetButton.status.unittype] and HealBot_TrackUnit[vTargetButton.status.unittype][vTargetButton.unit] and not HealBot_Panel_BlackList[vTargetButton.guid] then
                HealBot_Panel_TargetShow(vTargetButton, preCombat)
            else
                HealBot_Action_MarkDeleteButton(vTargetButton)
            end
        end
    end
    if vToTWithPlayers then
        vTargetButton=HealBot_Extra_Button["targettarget"]
        if vTargetButton then
            if HealBot_TrackUnit[vTargetButton.status.unittype] and HealBot_TrackUnit[vTargetButton.status.unittype][vTargetButton.unit] and not HealBot_Panel_BlackList[vTargetButton.guid] then
                HealBot_Panel_TargetShow(vTargetButton, preCombat)
            else
                HealBot_Action_MarkDeleteButton(vTargetButton)
            end
        end
    end
    if vFocusWithPlayers then
        vFocusButton=HealBot_Extra_Button["focus"]
        if vFocusButton then
            if HealBot_TrackUnit[vFocusButton.status.unittype] and HealBot_TrackUnit[vFocusButton.status.unittype][vFocusButton.unit] and not HealBot_Panel_BlackList[vFocusButton.guid] then
                HealBot_Panel_FocusShow(vFocusButton, preCombat)
            else
                HealBot_Action_MarkDeleteButton(vFocusButton)
            end
        end
    end
    if vToFWithPlayers then
        vFocusButton=HealBot_Extra_Button["focustarget"]
        if vFocusButton then
            if HealBot_TrackUnit[vFocusButton.status.unittype] and HealBot_TrackUnit[vFocusButton.status.unittype][vFocusButton.unit] and not HealBot_Panel_BlackList[vFocusButton.guid] then
                HealBot_Panel_FocusShow(vFocusButton, preCombat)
            else
                HealBot_Action_MarkDeleteButton(vFocusButton)
            end
        end
    end
    for gl=1,5 do
        HealBot_ActionIcons_UpdateActiveFrame(gl, vActiveFrames[gl])
    end
end

function HealBot_Panel_RetUnitGroups(unit)
      --HealBot_setCall("HealBot_Panel_RetUnitGroups", nil, nil, unit)
    return HealBot_UnitGroups[unit] or 1
end

function HealBot_Panel_RetUnitRank(guid, frame)
      --HealBot_setCall("HealBot_Panel_RetUnitRank", nil, guid)
    return hbPanel_dataRanks[guid] or 0
end

function HealBot_Panel_RetUnitPlayerRole(guid)
      --HealBot_setCall("HealBot_Panel_RetUnitPlayerRole", nil, guid)
    return hbPanel_dataPlayerRoles[guid] or 0
end

local focusHeal=true
function HealBot_Panel_focusHeal(isOn)
      --HealBot_setCall("HealBot_Panel_focusHeal")
    focusHeal=isOn
end

function HealBot_Panel_PlayerGUIDUnit(unit)
      --HealBot_setCall("HealBot_Panel_PlayerGUIDUnit")
    return hbPanel_dataUnits[unit]
end

function HealBot_Panel_PlayerUnitGUID(guid)
      --HealBot_setCall("HealBot_Panel_PlayerUnitGUID")
    return hbPanel_dataGUIDs[guid]
end

function HealBot_Panel_PetGUIDUnit(unit)
      --HealBot_setCall("HealBot_Panel_PlayerGUIDUnit")
    return hbPanel_dataPetUnits[unit]
end

function HealBot_Panel_PetUnitGUID(guid)
      --HealBot_setCall("HealBot_Panel_PetUnitGUID")
    return hbPanel_dataPetGUIDs[guid]
end

function HealBot_Panel_setButtonGUID(button)
    hbPanel_buttonGUIDs[button.guid]=button
end

function HealBot_Panel_setButtonpGUID(button)
    hbPanel_buttonpGUIDs[button.guid]=button
end

function HealBot_Panel_setButtonPetGUID(button)
    hbPanel_buttonPetGUIDs[button.guid]=button
end

function HealBot_Panel_RaidUnitButton(guid)
    return hbPanel_buttonGUIDs[guid], hbPanel_buttonpGUIDs[guid]
end

function HealBot_Panel_RaidButton(guid)
    xButton, pButton=HealBot_Panel_RaidUnitButton(guid)
    return xButton or pButton
end

function HealBot_Panel_RaidUnitButtonCheck(guid)
    return hbPanel_buttonGUIDs[guid] or hbPanel_buttonpGUIDs[guid]
end

function HealBot_Panel_RaidPetUnitButton(guid)
    return hbPanel_buttonGUIDs[guid] or hbPanel_buttonPetGUIDs[guid], hbPanel_buttonpGUIDs[guid]
end

function HealBot_Panel_RaidPetButton(guid)
    xButton, pButton=HealBot_Panel_RaidPetUnitButton(guid)
    return xButton or pButton
end

function HealBot_Panel_RaidPetUnitButtonCheck(guid)
    return hbPanel_buttonGUIDs[guid] or hbPanel_buttonpGUIDs[guid] or hbPanel_buttonPetGUIDs[guid]
end

function HealBot_Panel_AllUnitButton(guid)
    return hbPanel_buttonGUIDs[guid] or hbPanel_buttonPetGUIDs[guid] or hbPanel_buttonExtraGUIDs[guid], hbPanel_buttonpGUIDs[guid]
end

function HealBot_Panel_AllButton(guid)
    xButton, pButton=HealBot_Panel_AllUnitButton(guid)
    return xButton or pButton
end

function HealBot_Panel_AllUnitButtonCheck(guid)
    return hbPanel_buttonGUIDs[guid] or hbPanel_buttonpGUIDs[guid] or hbPanel_buttonPetGUIDs[guid] or hbPanel_buttonExtraGUIDs[guid]
end

function HealBot_Panel_RaidUnitName(uName)
      --HealBot_setCall("HealBot_Panel_RaidUnitName")
    return hbPanel_dataNames[uName] or hbPanel_dataPetNames[uName]
end

function HealBot_Panel_RaidUnitNameGetPlayerButton(uName)
      --HealBot_setCall("HealBot_Panel_RaidUnitNameGetPlayerButton")
    if hbPanel_dataNames[uName] and hbPanel_dataUnits[hbPanel_dataNames[uName]] then
        return HealBot_Panel_RaidUnitButton(hbPanel_dataUnits[hbPanel_dataNames[uName]])
    else
        return nil
    end
end

function HealBot_Panel_RaidUnitNameGetPlayerGUID(uName)
      --HealBot_setCall("HealBot_Panel_RaidUnitNameGetPlayerGUID")
    if hbPanel_dataNames[uName] then
        return hbPanel_dataUnits[hbPanel_dataNames[uName]]
    else
        return nil
    end
end

function HealBot_Panel_resetCrashProt()
      --HealBot_setCall("HealBot_Panel_resetCrashProt")
    vCrashProtTmp=""
end

function HealBot_Panel_DoPartyChanged(preCombat, changeType)
      --HealBot_setCall("HealBot_Panel_DoPartyChanged")
    for xHeader in pairs(HealBot_Track_Headers) do
        HealBot_Track_Headers[xHeader]=false
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
    for x=1,10 do
        hbPanelResetRequired[x]=true
    end

    local uType=hbv_GetUnitType(HEALBOT_PET)
    if changeType>5 then
        for z=11,19 do
            if HealBot_TrackUnit[z] then
                for x,_ in pairs(HealBot_TrackUnit[z]) do
                    HealBot_TrackUnit[z][x]=nil
                end
            end
        end
        for z=1,9 do
            if HealBot_TrackPrivateUnit[z] then
                for x,_ in pairs(HealBot_TrackPrivateUnit[z]) do
                    HealBot_TrackPrivateUnit[z][x]=nil
                end
            end
        end
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["FRAME"]<6 then
            vPetsWithPlayers=true
            for x,_ in pairs(HealBot_TrackUnit[uType]) do
                HealBot_TrackUnit[uType][x]=nil
            end
        else
            vPetsWithPlayers=false
        end
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][9]["FRAME"]<6 then
            vVehicleWithPlayers=true
            uType=hbv_GetUnitType(HEALBOT_VEHICLE)
            for x,_ in pairs(HealBot_TrackUnit[uType]) do
                HealBot_TrackUnit[uType][x]=nil
            end
        else
            vVehicleWithPlayers=false
        end
        vTargetWithPlayers=false
        vToTWithPlayers=false
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][11]["FRAME"]<6 or Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][12]["FRAME"]<6 then
            if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][11]["FRAME"]<6 then
                vTargetWithPlayers=true
                uType=hbv_GetUnitType(HEALBOT_TARGET)
                for x,_ in pairs(HealBot_TrackUnit[uType]) do
                    HealBot_TrackUnit[uType][x]=nil
                end
            end
            if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][12]["FRAME"]<6 then
                vToTWithPlayers=true
                uType=hbv_GetUnitType(HEALBOT_TOT)
                for x,_ in pairs(HealBot_TrackUnit[uType]) do
                    HealBot_TrackUnit[uType][x]=nil
                end
            end
        end
        vFocusWithPlayers=false
        vToFWithPlayers=false
        if HEALBOT_GAME_VERSION>1 then
            if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][13]["FRAME"]<6 or Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][14]["FRAME"]<6 then
                if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][13]["FRAME"]<6 then
                    vFocusWithPlayers=true
                    uType=hbv_GetUnitType(HEALBOT_FOCUS)
                    for x,_ in pairs(HealBot_TrackUnit[uType]) do
                        HealBot_TrackUnit[uType][x]=nil
                    end
                end
                if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][14]["FRAME"]<6 then
                    vToFWithPlayers=true
                    uType=hbv_GetUnitType(HEALBOT_TOF)
                    for x,_ in pairs(HealBot_TrackUnit[uType]) do
                        HealBot_TrackUnit[uType][x]=nil
                    end
                end
            end
        end

        if HealBot_Globals.UseCrashProt and not HealBot_retLuVars("Loaded") then
            HealBot_Panel_luVars["cpCrash"]=true
            local mbody=GetMacroBody(HealBot_Panel_luVars["cpMacro"]) or "Solo:0"
            HealBot_Panel_luVars["cpCrashType"],HealBot_Panel_luVars["cpCrashNum"]=string.split(":", mbody)
            --HealBot_Panel_luVars["cpCrashType"],HealBot_Panel_luVars["cpCrashNum"]="r","25"
            if not preCombat or HealBot_Panel_luVars["cpCrashType"] == "Solo" then
                HealBot_Panel_luVars["cpCrash"]=false
            else
                HealBot_Panel_luVars["cpCrashNum"]=tonumber(HealBot_Panel_luVars["cpCrashNum"])
            end
        end
        HealBot_Panel_PlayersChanged(preCombat)
        if not preCombat and HealBot_Globals.UseCrashProt then
            if nraid>0 then
                vCrashProtTmp="r:"..nraid
            elseif IsInGroup() then
                vCrashProtTmp="g:"..GetNumGroupMembers()
            else
                vCrashProtTmp="Solo:0"
            end
            if vCrashProtTmp~=vCrashProtData then
                vCrashProtData=vCrashProtTmp
                local z=GetMacroIndexByName(HealBot_Panel_luVars["cpMacro"])
                if (z or 0) == 0 then
                    if GetNumMacros()<120 then
                        z=CreateMacro(HealBot_Panel_luVars["cpMacro"], "Spell_Holy_SealOfSacrifice", vCrashProtData, false)
                    end
                else
                    z=EditMacro(z, HealBot_Panel_luVars["cpMacro"], "Spell_Holy_SealOfSacrifice", vCrashProtData)
                end
            end
        end
    else
        if changeType == 2 then
            if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["FRAME"] == 7 then
                for x,_ in pairs(HealBot_TrackUnit[uType]) do
                    HealBot_TrackUnit[uType][x]=nil
                end
                HealBot_Panel_PetsChanged(preCombat)
                if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["STATE"] then
                    HealBot_ActionIcons_UpdateActiveFrame(7, true)
                else
                    HealBot_ActionIcons_UpdateActiveFrame(7, false)
                end
            else
                HealBot_ActionIcons_UpdateActiveFrame(7, false)
            end
        elseif changeType == 3 then
            if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][11]["FRAME"] == 8 then
                uType=hbv_GetUnitType(HEALBOT_TARGET)
                for x,_ in pairs(HealBot_TrackUnit[uType]) do
                    HealBot_TrackUnit[uType][x]=nil
                end
            end
            if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][12]["FRAME"] == 8 then
                uType=hbv_GetUnitType(HEALBOT_TOT)
                for x,_ in pairs(HealBot_TrackUnit[uType]) do
                    HealBot_TrackUnit[uType][x]=nil
                end
            end
            HealBot_Panel_TargetChanged(preCombat)
            if i[hbCurrentFrame]>0 then
                HealBot_ActionIcons_UpdateActiveFrame(8, true)
            else
                HealBot_ActionIcons_UpdateActiveFrame(8, false)
            end
        elseif changeType == 4 then
            if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][13]["FRAME"] == 9 then
                uType=hbv_GetUnitType(HEALBOT_FOCUS)
                for x,_ in pairs(HealBot_TrackUnit[uType]) do
                    HealBot_TrackUnit[uType][x]=nil
                end
            end
            if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][14]["FRAME"] == 9 then
                uType=hbv_GetUnitType(HEALBOT_TOF)
                for x,_ in pairs(HealBot_TrackUnit[uType]) do
                    HealBot_TrackUnit[uType][x]=nil
                end
            end
            HealBot_Panel_FocusChanged(preCombat)
            if i[hbCurrentFrame]>0 then
                HealBot_ActionIcons_UpdateActiveFrame(9, true)
            else
                HealBot_ActionIcons_UpdateActiveFrame(9, false)
            end
        elseif changeType == 1 then
            if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][9]["FRAME"] == 6 then
                uType=hbv_GetUnitType(HEALBOT_VEHICLE)
                for x,_ in pairs(HealBot_TrackUnit[uType]) do
                    HealBot_TrackUnit[uType][x]=nil
                end
                HealBot_Panel_VehicleChanged(preCombat)
                if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][9]["STATE"] then
                    HealBot_ActionIcons_UpdateActiveFrame(6, true)
                else
                    HealBot_ActionIcons_UpdateActiveFrame(6, false)
                end
            else
                HealBot_ActionIcons_UpdateActiveFrame(6, false)
            end
        elseif changeType == 5 then
            uType=hbv_GetUnitType(HEALBOT_ENEMY)
            for x,_ in pairs(HealBot_TrackUnit[uType]) do
                HealBot_TrackUnit[uType][x]=nil
            end
            HealBot_Panel_EnemyChanged(preCombat)
            if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][15]["STATE"] then
                HealBot_ActionIcons_UpdateActiveFrame(10, true)
            else
                HealBot_ActionIcons_UpdateActiveFrame(10, false)
            end
        end
        if changeType>2 then
            for x,_ in pairs(hbPanel_buttonExtraGUIDs) do
                hbPanel_buttonExtraGUIDs[x]=nil
            end
            for xUnit,xButton in pairs(HealBot_Enemy_Button) do
                hbPanel_buttonExtraGUIDs[xButton.guid]=xButton
            end
            for xUnit,xButton in pairs(HealBot_UnitTarget_Button) do
                hbPanel_buttonExtraGUIDs[xButton.guid]=xButton
            end
            for xUnit,xButton in pairs(HealBot_PrivateTarget_Button) do
                hbPanel_buttonExtraGUIDs[xButton.guid]=xButton
            end
            for xUnit,xButton in pairs(HealBot_Extra_Button) do
                hbPanel_buttonExtraGUIDs[xButton.guid]=xButton
            end
        end
    end
end

function HealBot_Panel_PrePartyChanged(preCombat, changeType)
      --HealBot_setCall("HealBot_Panel_PrePartyChanged")
    if changeType>0 then
        if changeType>5 then
            if (Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][9]["STATE"] and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][9]["FRAME"]<6) or
               (Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["STATE"] and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["FRAME"]<6) then
                HealBot_Panel_buildDataStore(true, true)
            else
                HealBot_Panel_buildDataStore(true, false)
            end
        elseif changeType == 2 and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["FRAME"] == 7 then
            HealBot_Panel_buildDataStore(false, true)
        elseif changeType == 1 and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][9]["FRAME"] == 6 then
            HealBot_Panel_buildDataStore(false, true)
        end
        HealBot_Panel_DoPartyChanged(preCombat, changeType)
    else
        if (Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][9]["STATE"] and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][9]["FRAME"]<6) or
           (Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["STATE"] and Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["FRAME"]<6) then
            HealBot_Panel_buildDataStore(true, true)
        else
            HealBot_Panel_buildDataStore(true, false)
        end
        HealBot_Panel_DoPartyChanged(preCombat, 6)
        if preCombat then
            if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][9]["FRAME"] == 6 or Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["FRAME"] == 7 then
                HealBot_Panel_buildDataStore(false, true)
                if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][9]["FRAME"] == 6 then HealBot_Panel_DoPartyChanged(preCombat, 1) end
                if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["FRAME"] == 7 then HealBot_Panel_DoPartyChanged(preCombat, 2) end
            end
            if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][11]["FRAME"] == 8 then HealBot_Panel_DoPartyChanged(preCombat, 3) end
            if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][12]["FRAME"] == 8 then HealBot_Panel_DoPartyChanged(preCombat, 3) end
            if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][13]["FRAME"] == 9 then HealBot_Panel_DoPartyChanged(preCombat, 4) end
            if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][14]["FRAME"] == 9 then HealBot_Panel_DoPartyChanged(preCombat, 4) end
            HealBot_Panel_DoPartyChanged(preCombat, 5)
        else
            if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][9]["FRAME"] == 6 then HealBot_nextRecalcParty(1) end
            if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["FRAME"] == 7 then HealBot_nextRecalcParty(2) end
            if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][11]["FRAME"] == 8 then HealBot_nextRecalcParty(3) end
            if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][12]["FRAME"] == 8 then HealBot_nextRecalcParty(3) end
            if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][13]["FRAME"] == 9 then HealBot_nextRecalcParty(4) end
            if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][14]["FRAME"] == 9 then HealBot_nextRecalcParty(4) end
            HealBot_nextRecalcParty(5)
        end
    end
end

function HealBot_Panel_PartyChanged(preCombat, changeType)
      --HealBot_setCall("HealBot_Panel_PartyChanged")
    --HealBot_Action_setLuVars("CreatedButtons",0)
    --HealBot_Action_setLuVars("PartyChangedType",changeType)
    if HealBot_setTestBars then
        if not preCombat then
            HealBot_Panel_TestBarsOn()
        else
            HealBot_Panel_ToggleTestBars(preCombat)
            HealBot_Action_ResetSkinAllElements()
            HealBot_Panel_PrePartyChanged(preCombat, 0)
        end
    else
        HealBot_Panel_PrePartyChanged(preCombat, changeType)
    end
end

function HealBot_Panel_Init()
      --HealBot_setCall("HealBot_Panel_Init")
    if HEALBOT_GAME_VERSION>5 then
        HealBot_randomClCol={ [0]= { ["MAX"]=11, ["TE"]=5, ["HS"]=3, ["HE"]=7}, -- Correct mana colour for 12 and 13 before setting MAX=13 - Move Evoker to 8 and set HE=8
                              [1]= { [1]= 0.77, [2]= 0.12, [3]= 0.23, [4]="DEAT", [5]=1, [6]=0, [7]=0},
                              [2]= { [1]= 0.78, [2]= 0.61, [3]= 0.43, [4]="WARR", [5]=1, [6]=0, [7]=0},
                              [3]= { [1]= 1,    [2]= 0.49, [3]= 0.04, [4]="DRUI", [5]=0, [6]=0, [7]=1},
                              [4]= { [1]= 0,    [2]= 1,    [3]= 0.59, [4]="MONK", [5]=1, [6]=1, [7]=0},
                              [5]= { [1]= 0.96, [2]= 0.55, [3]= 0.73, [4]="PALA", [5]=0, [6]=0, [7]=1},
                              [6]= { [1]= 1,    [2]= 1,    [3]= 1,    [4]="PRIE", [5]=0, [6]=0, [7]=1},
                              [7]= { [1]= 0,    [2]= 0.44, [3]= 0.87, [4]="SHAM", [5]=0, [6]=0, [7]=1},
                              [8]= { [1]= 0.53, [2]= 0.53, [3]= 0.93, [4]="WARL", [5]=0, [6]=0, [7]=1},
                              [9]= { [1]= 0.67, [2]= 0.83, [3]= 0.45, [4]="HUNT", [5]=1, [6]=0.5, [7]=0.25},
                             [10]= { [1]= 0.25, [2]= 0.78, [3]= 0.92, [4]="MAGE", [5]=0, [6]=0, [7]=1},
                             [11]= { [1]= 1,    [2]= 0.96, [3]= 0.41, [4]="ROGU", [5]=1, [6]=1, [7]=0},
                             [12]= { [1]= 0.8,  [2]= 0.1,  [3]= 0.8,  [4]="DEMO", [5]=0, [6]=0, [7]=1},
                             [13]= { [1]= 0.22, [2]= 0.59, [3]= 0.49, [4]="EVOK", [5]=0, [6]=0, [7]=1},
                            }
        HealBot_randomClNames={ [1]=HEALBOT_DEATHKNIGHT,
                                [2]=HEALBOT_WARRIOR,
                                [3]=HEALBOT_DRUID,
                                [4]=HEALBOT_MONK,
                                [5]=HEALBOT_PALADIN,
                                [6]=HEALBOT_PRIEST,
                                [7]=HEALBOT_SHAMAN,
                                [8]=HEALBOT_WARLOCK,
                                [9]=HEALBOT_HUNTER,
                               [10]=HEALBOT_MAGE,
                               [11]=HEALBOT_ROGUE,
                               [12]=HEALBOT_DEMONHUNTER,
                               [13]=HEALBOT_EVOKER,
                              }
    elseif HEALBOT_GAME_VERSION>2 then
        HealBot_randomClCol={ [0]={ ["MAX"]=10, ["TE"]=4, ["HS"]=3, ["HE"]=6},
                              [1]={ [1]= 0.77, [2]= 0.12, [3]= 0.23, [4]="DEAT", [5]=1, [6]=0, [7]=0},
                              [2]={ [1]= 0.78, [2]= 0.61, [3]= 0.43, [4]="WARR", [5]=1, [6]=0, [7]=0},
                              [3]={ [1]= 1.0,  [2]= 0.49, [3]= 0.04, [4]="DRUI", [5]=0, [6]=0, [7]=1},
                              [4]={ [1]= 0.96, [2]= 0.55, [3]= 0.73, [4]="PALA", [5]=0, [6]=0, [7]=1},
                              [5]={ [1]= 1.0,  [2]= 1.0,  [3]= 1.0,  [4]="PRIE", [5]=0, [6]=0, [7]=1},
                              [6]={ [1]= 0,    [2]= 0.44, [3]= 0.87, [4]="SHAM", [5]=0, [6]=0, [7]=1},
                              [7]={ [1]= 0.53, [2]= 0.53, [3]= 0.93, [4]="WARL", [5]=0, [6]=0, [7]=1},
                              [8]={ [1]= 0.67, [2]= 0.83, [3]= 0.45, [4]="HUNT", [5]=0, [6]=0, [7]=1},
                              [9]={ [1]= 0.25, [2]= 0.78, [3]= 0.92, [4]="MAGE", [5]=0, [6]=0, [7]=1},
                             [10]={ [1]= 1.0,  [2]= 0.96, [3]= 0.41, [4]="ROGU", [5]=1, [6]=1, [7]=0},
                            }
        HealBot_randomClNames={ [1]=HEALBOT_DEATHKNIGHT,
                                [2]=HEALBOT_WARRIOR,
                                [3]=HEALBOT_DRUID,
                                [4]=HEALBOT_PALADIN,
                                [5]=HEALBOT_PRIEST,
                                [6]=HEALBOT_SHAMAN,
                                [7]=HEALBOT_WARLOCK,
                                [8]=HEALBOT_HUNTER,
                                [9]=HEALBOT_MAGE,
                               [10]=HEALBOT_ROGUE,
                              }
    else
        HealBot_randomClCol={ [0]={ ["MAX"]=9, ["TE"]=3, ["HS"]=2, ["HE"]=5},
                              [1]={ [1]=0.78, [2]=0.61, [3]=0.43, [4]="WARR", [5]=1, [6]=0, [7]=0},
                              [2]={ [1]=1.0,  [2]=0.49, [3]=0.04, [4]="DRUI", [5]=0, [6]=0, [7]=1},
                              [3]={ [1]=0.96, [2]=0.55, [3]=0.73, [4]="PALA", [5]=0, [6]=0, [7]=1},
                              [4]={ [1]=1.0,  [2]=1.0,  [3]=1.0,  [4]="PRIE", [5]=0, [6]=0, [7]=1},
                              [5]={ [1]=0,    [2]=0.44, [3]=0.87, [4]="SHAM", [5]=0, [6]=0, [7]=1},
                              [6]={ [1]=0.53, [2]=0.53, [3]=0.93, [4]="WARL", [5]=0, [6]=0, [7]=1},
                              [7]={ [1]=0.67, [2]=0.83, [3]=0.45, [4]="HUNT", [5]=0, [6]=0, [7]=1},
                              [8]={ [1]=0.25, [2]=0.78, [3]=0.92, [4]="MAGE", [5]=0, [6]=0, [7]=1},
                              [9]={ [1]=1.0,  [2]=0.96, [3]=0.41, [4]="ROGU", [5]=1, [6]=1, [7]=0},
                            }
        HealBot_randomClNames={ [1]=HEALBOT_WARRIOR,
                                [2]=HEALBOT_DRUID,
                                [3]=HEALBOT_PALADIN,
                                [4]=HEALBOT_PRIEST,
                                [5]=HEALBOT_SHAMAN,
                                [6]=HEALBOT_WARLOCK,
                                [7]=HEALBOT_HUNTER,
                                [8]=HEALBOT_MAGE,
                                [9]=HEALBOT_ROGUE,
                              }
    end
end

function HealBot_Panel_ClearGUID(guid)
      --HealBot_setCall("HealBot_Panel_ClearGUID", nil, guid)
    hbPanel_dataRoles[guid]=nil
    hbPanel_dataPlayerRoles[guid]=nil
    hbPanel_dataRanks[guid]=nil
    hbPanel_buttonGUIDs[guid]=nil
    hbPanel_buttonPetGUIDs[guid]=nil
    hbPanel_buttonExtraGUIDs[guid]=nil
    hbPanel_buttonpGUIDs[guid]=nil
end
