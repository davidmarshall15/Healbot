local HealBot_GMount={}
local HealBot_PrevGMounts={}
local HealBot_FMount={}
local HealBot_PrevFMounts={}
local HealBot_SMount={}
local HealBot_AQMount={}
local HealBot_mountData={}
local HealBot_MountIndex={}
local HealBot_MountsPets_luVars={}
HealBot_MountsPets_luVars["dislikeRetry"]=75
local hbMountTypes={[230]="G",
                    [231]="G",
                    [232]="S",
                    [241]="AQ",
                    [242]="F",
                    [247]="F",
                    [248]="F",
                    [254]="S",
                    [269]="G",
                    [284]="F",
                    [398]="F",
                    [402]="F",
                    [407]="F",
                    [408]="F",
                    [412]="F",
                    [424]="F",
                    [428]="F",
                    [436]="F",
                    [444]="F",
                    }

local function HealBot_MountsPets_CanMount()
      --HealBot_setCall("HealBot_MountsPets_CanMount")
    if not HealBot_Data["UILOCK"] and not IsIndoors() then
        return true
    else
        return false
    end
end

function HealBot_MountsPets_Dismount()
      --HealBot_setCall("HealBot_MountsPets_Dismount")
    if IsMounted() then
        Dismount()
    elseif HEALBOT_GAME_VERSION>2 and CanExitVehicle() then
        VehicleExit()
    end
end

function HealBot_MountsPets_FavMount()
      --HealBot_setCall("HealBot_MountsPets_FavMount")
    if HealBot_MountsPets_CanMount() then
        if IsMounted() then
            Dismount()
        elseif HEALBOT_GAME_VERSION>2 and CanExitVehicle() then
            VehicleExit()
        else
            C_MountJournal.SummonByID(0)
        end
    end
end

function HealBot_MountsPets_RandomPet(isFav)
      --HealBot_setCall("HealBot_MountsPets_RandomPet")
    if not HealBot_Data["UILOCK"] then
        C_PetJournal.SummonRandomPet(isFav)
    end
end

function HealBot_MountsPets_Mount(mount)
      --HealBot_setCall("HealBot_MountsPets_Mount")
    if mount == 75207 then
        C_MountJournal.SummonByID(0)
    elseif HealBot_MountIndex[mount] then
        if HealBot_MountsPets_CanMount() then
            C_MountJournal.SummonByID(HealBot_MountIndex[mount])
        end
    else
        HealBot_Timers_Set("LAST","MountsPetsUse")
        HealBot_AddChat(HEALBOT_OPTION_EXCLUDEMOUNT_ON.." "..mount)
    end
end

local vToggleMountIndex=0
function HealBot_MountsPets_ToggelMount(mountType)
      --HealBot_setCall("HealBot_MountsPets_ToggelMount")
    if HealBot_MountsPets_CanMount() then
        if IsMounted() then
            Dismount()
        elseif HEALBOT_GAME_VERSION>2 and CanExitVehicle() then
            VehicleExit()
        elseif HealBot_mountData["ValidUse"] and IsOutdoors() then
            local mount=nil
            vToggleMountIndex=0
            if mountType == "all" and not IsSwimming() and HealBot_mountData["incFlying"] and #HealBot_FMount>0 then
                for x=1,20 do
                    vToggleMountIndex=math.random(1, #HealBot_FMount);
                    mount=HealBot_FMount[vToggleMountIndex];
                    if not HealBot_Globals.dislikeMount[mount] then
                        break
                    else
                        if HealBot_Globals.dislikeMount[mount]>0 then
                            HealBot_Globals.dislikeMount[mount]=HealBot_Globals.dislikeMount[mount]-1
                        else
                            HealBot_AddDebug("Mounting a disliked mount "..mount,"Mounts",true)
                            HealBot_Globals.dislikeMount[mount]=HealBot_MountsPets_luVars["dislikeRetry"]
                            break
                        end
                    end
                end
                if HealBot_mountData["PrevFlying#"]>0 then
                    table.insert(HealBot_PrevFMounts, HealBot_FMount[vToggleMountIndex]);
                    table.remove(HealBot_FMount,vToggleMountIndex)
                end
                if #HealBot_PrevFMounts>HealBot_mountData["PrevFlying#"] then
                    table.insert(HealBot_FMount, HealBot_PrevFMounts[1]);
                    table.remove(HealBot_PrevFMounts,1)
                end
            elseif IsSwimming() then
                if HealBot_mountData["incAbyseal"] then
                    mount=75207
                elseif #HealBot_SMount>0 then
                    vToggleMountIndex=math.random(1, #HealBot_SMount);
                    mount=HealBot_SMount[vToggleMountIndex];
                end
            elseif HealBot_mountData["incAQ"] then
                if #HealBot_AQMount>0 then
                    vToggleMountIndex=math.random(1, #HealBot_AQMount);
                    mount=HealBot_AQMount[vToggleMountIndex];
                end
            elseif #HealBot_GMount>0 then
                for x=1,20 do
                    vToggleMountIndex=math.random(1, #HealBot_GMount);
                    mount=HealBot_GMount[vToggleMountIndex];
                    if not HealBot_Globals.dislikeMount[mount] then
                        break
                    else
                        if HealBot_Globals.dislikeMount[mount]>0 then
                            HealBot_Globals.dislikeMount[mount]=HealBot_Globals.dislikeMount[mount]-1
                        else
                            HealBot_Globals.dislikeMount[mount]=HealBot_MountsPets_luVars["dislikeRetry"]
                            HealBot_AddDebug("Mounting a disliked mount "..mount,"Mounts",true)
                            break
                        end
                    end
                end
                if HealBot_mountData["PrevGround#"]>0 then
                    table.insert(HealBot_PrevGMounts, HealBot_GMount[vToggleMountIndex]);
                    table.remove(HealBot_GMount,vToggleMountIndex)
                end
                if #HealBot_PrevGMounts>HealBot_mountData["PrevGround#"] then
                    table.insert(HealBot_GMount, HealBot_PrevGMounts[1]);
                    table.remove(HealBot_PrevGMounts,1)
                end
            end
            if mount then HealBot_MountsPets_Mount(mount) end
        end
    end
end

function HealBot_MountsPets_InitUse()
      --HealBot_setCall("HealBot_MountsPets_InitUse")
    if HEALBOT_GAME_VERSION>2 then
        HealBot_Timers_Set("LAST","MountsPetsInit")
    end
end

function HealBot_MountsPets_ClassicDalaranCheck()
      --HealBot_setCall("HealBot_MountsPets_ClassicDalaranCheck")
    local mapPos=C_Map.GetPlayerMapPosition(125, "player")
    if mapPos then
        local x, y=mapPos:GetXY()
        if x>0.6 and y<0.5 then
            HealBot_mountData["incFlying"]=true
        else
            HealBot_mountData["incFlying"]=false
        end
    else
        HealBot_mountData["incFlying"]=false
    end
end

function HealBot_MountsPets_getContinent()
    local mapID=C_Map.GetBestMapForUnit("player")
    if(mapID) then
        local info=C_Map.GetMapInfo(mapID)
        if(info) then
            while(info['mapType'] and info['mapType'] > 2) do
                info=C_Map.GetMapInfo(info['parentMapID'])
            end
            if(info['mapType'] == 2) then
                return info['mapID']
            end
        end
    end
end

function HealBot_MountsPets_ZoneChange()
      --HealBot_setCall("HealBot_MountsPets_ZoneChange")
    HealBot_mountData["incAQ"]=false
    if IsFlyableArea() and HEALBOT_GAME_VERSION>1 then
        if HEALBOT_GAME_VERSION>4 then
            HealBot_mountData["incFlying"]=true
        else
            local Continent=HealBot_MountsPets_getContinent()
            if Continent == 113 and not IsSpellKnown(54197) then
                HealBot_mountData["incFlying"]=false
            elseif Continent == 1945 and not IsSpellKnown(34092) then
                HealBot_mountData["incFlying"]=false
            elseif Continent>1413 and Continent<1415 and not IsSpellKnown(90267) then
                HealBot_mountData["incFlying"]=false
            elseif Continent == 1415 then
                HealBot_mountData["incAbyseal"]=true
            else
                local mapAreaID=C_Map.GetBestMapForUnit("player") or 0
                if mapAreaID>0 then
                    if mapAreaID == 125 then
                        HealBot_Timers_Set("LAST","MountsPetsDalaran",true,true)
                    else
                        HealBot_mountData["incFlying"]=true
                    end
                end
            end
            --if HealBot_mountData["incFlying"] then
            --    HealBot_AddDebug("Zone mapAreaID="..mapAreaID.." Is Flyable","Mounts",true)
            --else
            --    HealBot_AddDebug("Zone mapAreaID="..mapAreaID.." Not Flyable","Mounts",true)
            --end
        end
    else
        HealBot_mountData["incFlying"]=false
        local _, _, _, _, _, _, _, instanceID=GetInstanceInfo()
        if instanceID == 531 then
            HealBot_mountData["incAQ"]=true
        end
        --HealBot_AddDebug("Zone Not Flyable","Mounts",true)
    end
end

function HealBot_MountsPets_InitMount()
      --HealBot_setCall("HealBot_MountsPets_InitMount")
    --SetMapToCurrentZone()
    local HealBot_SlowMount={}
    local HealBot_SlowFMount={}
    for z,_ in pairs(HealBot_GMount) do
        HealBot_GMount[z]=nil;
    end
    for z,_ in pairs(HealBot_AQMount) do
        HealBot_AQMount[z]=nil;
    end
    for z,_ in pairs(HealBot_FMount) do
        HealBot_FMount[z]=nil;
    end
    for z,_ in pairs(HealBot_SMount) do
        HealBot_SMount[z]=nil;
    end
    for z,_ in pairs(HealBot_PrevGMounts) do
        HealBot_PrevGMounts[z]=nil;
    end
    for z,_ in pairs(HealBot_PrevFMounts) do
        HealBot_PrevFMounts[z]=nil;
    end
    for z,_ in pairs(HealBot_MountIndex) do
        HealBot_MountIndex[z]=nil;
    end

    local mount, sID, isUsable, faction, isCollected, mountType
    if C_MountJournal then

        HealBot_mountData["playerFaction"]=0 -- Horde
        local _,raceId=UnitRace("player");
        if raceId == "Dwarf" or raceId == "Draenei" or raceId == "Gnome" or raceId == "Human" or raceId == "NightElf" or raceId == "Worgen" then
            HealBot_mountData["playerFaction"]=1
        elseif raceId == "Pandaren" then
            if UnitFactionGroup("player") == "Alliance" then
                HealBot_mountData["playerFaction"]=1
            end
        end

        for _, z in pairs(C_MountJournal.GetMountIDs()) do
            mount, sID, _, _, isUsable, _, _, _, faction, _, isCollected=C_MountJournal.GetMountInfoByID(z)
            _, _, _, _, mountType=C_MountJournal.GetMountInfoExtraByID(z)
            if faction and isUsable and isCollected then
                local englishFaction=UnitFactionGroup("player")
                if (faction~=HealBot_mountData["playerFaction"]) then
                    isUsable=nil
                end
            end

            if sID and isUsable and isCollected and not HealBot_Globals.excludeMount[mount] then
                if hbMountTypes[mountType] == "F" then
                    table.insert(HealBot_FMount, mount);
                    HealBot_MountIndex[mount]=z
                elseif hbMountTypes[mountType] == "S" then
                    table.insert(HealBot_SMount, mount);
                    HealBot_MountIndex[mount]=z
                elseif hbMountTypes[mountType] == "G" then
                    table.insert(HealBot_GMount, mount);
                    HealBot_MountIndex[mount]=z
                elseif hbMountTypes[mountType] == "AQ" then
                    table.insert(HealBot_AQMount, mount);
                    HealBot_MountIndex[mount]=z
                else
                    HealBot_AddDebug("unknown mount "..mount.."="..sID.." mountType="..(mountType or "nil"),"Mounts",true)
                end
                --HealBot_AddDebug("mount "..mount.."="..sID.." mountType="..(mountType or "nil"),"Mounts",true)
            elseif not sID then
                HealBot_AddDebug("No id for Name="..(mount or "NoName").."  z="..z,"Mounts",true)
            end
        end
    end

    if #HealBot_GMount == 0 and #HealBot_SlowMount>0 then
        for z,_ in pairs(HealBot_SlowMount) do
            HealBot_GMount[z]=HealBot_SlowMount[z]
        end
    end
    if #HealBot_FMount == 0 and #HealBot_SlowFMount>0 then
        for z,_ in pairs(HealBot_SlowFMount) do
            HealBot_FMount[z]=HealBot_SlowFMount[z]
        end
    end
    HealBot_mountData["PrevFlying#"]=floor(#HealBot_FMount/3)
    HealBot_mountData["PrevGround#"]=floor(#HealBot_GMount/3)

    if #HealBot_GMount == 0 and #HealBot_FMount == 0 then
        HealBot_mountData["ValidUse"]=false
    else
        HealBot_mountData["ValidUse"]=true
    end
    HealBot_Timers_Set("LAST","MountsPetsZone")
end

function HealBot_MountsPets_DislikeMount(action)
      --HealBot_setCall("HealBot_MountsPets_DislikeMount")
    if not IsMounted() then
        HealBot_AddChat("ERROR: Not Mounted\nMount first before toggling exclude mount")
    else
        local z=0
        local mount,creatureName,active=nil,nil,nil
        if HEALBOT_GAME_VERSION>3 then
            z=C_MountJournal.GetNumMounts()
        else
            z=GetNumCompanions("MOUNT")
        end
        for i=1,z do
            if HEALBOT_GAME_VERSION>3 then
                creatureName, _, _, active=C_MountJournal.GetMountInfoByID(i)
            else
                _, creatureName, _, _, active=GetCompanionInfo("MOUNT", i)
            end
            if active then
                mount=creatureName
                break
            end
        end
        if mount then
            if action == "Exclude" then
                if HealBot_Globals.excludeMount[mount] then
                    HealBot_AddChat(HEALBOT_OPTION_EXCLUDEMOUNT_OFF.." "..mount)
                    HealBot_Globals.excludeMount[mount]=nil
                else
                    HealBot_AddChat(HEALBOT_OPTION_EXCLUDEMOUNT_ON.." "..mount)
                    HealBot_Globals.excludeMount[mount]=true
                end
                HealBot_Timers_Set("LAST","MountsPetsUse")
            else
                if HealBot_Globals.dislikeMount[mount] then
                    HealBot_AddChat(HEALBOT_OPTION_DISLIKEMOUNT_OFF.." "..mount)
                    HealBot_Globals.dislikeMount[mount]=nil
                else
                    HealBot_AddChat(HEALBOT_OPTION_DISLIKEMOUNT_ON.." "..mount)
                    HealBot_Globals.dislikeMount[mount]=HealBot_MountsPets_luVars["dislikeRetry"]
                end
            end
        end
    end
end