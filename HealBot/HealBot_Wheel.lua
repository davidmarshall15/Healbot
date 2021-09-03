local HealBot_MouseWheelCmd=nil
local HealBot_GMount = {}
local HealBot_PrevGMounts = {}
local HealBot_FMount = {}
local HealBot_PrevFMounts = {}
local HealBot_SMount = {}
local HealBot_mountData = {}
local HealBot_MountIndex = {}
local hbLastButton=false

function HealBot_MountsPets_lastbutton(button)
    hbLastButton=button
end

function HealBot_MountsPets_FavMount()
    if not InCombatLockdown() then
        C_MountJournal.SummonByID(0)
    end
end

function HealBot_MountsPets_RandomPet(isFav)
    if not InCombatLockdown() then
        C_PetJournal.SummonRandomPet(isFav)
    end
end

function HealBot_MountsPets_Mount(mount)
    if HealBot_MountIndex[mount] then 
        if not InCombatLockdown() then
            C_MountJournal.SummonByID(HealBot_MountIndex[mount]) 
        end
    else
        HealBot_setOptions_Timer(405)
        HealBot_AddChat(HEALBOT_OPTION_EXCLUDEMOUNT_ON.." "..mount)
    end
end

local vToggleMountIndex=0
function HealBot_MountsPets_ToggelMount(mountType)
    if IsMounted() then
        Dismount()
    elseif HEALBOT_GAME_VERSION>3 and CanExitVehicle() then    
        VehicleExit()
    elseif HealBot_mountData["ValidUse"] and IsOutdoors() and not HealBot_IsFighting then
        local mount = nil
        vToggleMountIndex=0
        if mountType=="all" and not IsSwimming() and IsFlyableArea() and #HealBot_FMount>0 then
            for x=1,20 do
                vToggleMountIndex = math.random(1, #HealBot_FMount);
                mount = HealBot_FMount[vToggleMountIndex];
                if not HealBot_Globals.dislikeMount[mount] then
                    break
                else
                    if HealBot_Globals.dislikeMount[mount]>0 then
                        HealBot_Globals.dislikeMount[mount]=HealBot_Globals.dislikeMount[mount]-1
                    else
                        HealBot_Globals.dislikeMount[mount]=500
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
        elseif IsSwimming() and #HealBot_SMount>0 then
            vToggleMountIndex = math.random(1, #HealBot_SMount);
            mount = HealBot_SMount[vToggleMountIndex];
        elseif #HealBot_GMount>0 then
            for x=1,20 do
                vToggleMountIndex = math.random(1, #HealBot_GMount);
                mount = HealBot_GMount[vToggleMountIndex];
                if not HealBot_Globals.dislikeMount[mount] then
                    break
                else
                    if HealBot_Globals.dislikeMount[mount]>0 then
                        HealBot_Globals.dislikeMount[mount]=HealBot_Globals.dislikeMount[mount]-1
                    else
                        HealBot_Globals.dislikeMount[mount]=500
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

function HealBot_Action_DoHealUnit_Wheel(self, delta)
    --local xButton=hbLastButton
    if hbLastButton and hbLastButton.status.current<HealBot_Unit_Status["DC"] then
        --local xUnit=xButton.unit
        local y="None"
        if IsShiftKeyDown() then
            if not IsControlKeyDown() and not IsAltKeyDown() then 
                y="Shift" 
            else
                y=""
            end
        elseif IsControlKeyDown() then
            if not IsShiftKeyDown() and not IsAltKeyDown() then 
                y="Ctrl" 
            else
                y=""
            end
        elseif IsAltKeyDown() then
            if not IsControlKeyDown() and not IsShiftKeyDown() then 
                y="Alt" 
            else
                y=""
            end
        end    
        if delta>0 then
            y=y.."Up"
        else
            y=y.."Down"
        end
        if HealBot_Globals.HealBot_MouseWheelTxt[y] then
            HealBot_MouseWheelCmd=HealBot_Globals.HealBot_MouseWheelTxt[y]
        else
            HealBot_MouseWheelCmd=HEALBOT_WORDS_NONE
        end
        if HealBot_MouseWheelCmd==HEALBOT_HB_MENU then
            local HBFriendsDropDown = CreateFrame("Frame", "HealBot_Action_hbmenuFrame_DropDown", UIParent, "UIDropDownMenuTemplate");
            HBFriendsDropDown.unit = hbLastButton.unit
            HBFriendsDropDown.name = HealBot_GetUnitName(hbLastButton.unit, hbLastButton.guid)
            HBFriendsDropDown.initialize = HealBot_Action_hbmenuFrame_DropDown_Initialize
            HBFriendsDropDown.displayMode = "MENU"
            ToggleDropDownMenu(1, nil, HBFriendsDropDown, "cursor", 10, -8)
        elseif HealBot_MouseWheelCmd==HEALBOT_FOLLOW then
            FollowUnit(hbLastButton.unit)
        elseif HealBot_MouseWheelCmd==HEALBOT_TRADE then
            InitiateTrade(hbLastButton.unit)
        elseif HealBot_MouseWheelCmd==HEALBOT_PROMOTE_RA then
            PromoteToAssistant(hbLastButton.unit)
        elseif HealBot_MouseWheelCmd==HEALBOT_DEMOTE_RA then
            DemoteAssistant(hbLastButton.unit)
        elseif HealBot_MouseWheelCmd==HEALBOT_TOGGLE_ENABLED then
            HealBot_Action_Toggle_Enabled(hbLastButton.unit)
        elseif HealBot_MouseWheelCmd==HEALBOT_TOGGLE_MYTARGETS then
            HealBot_Panel_ToggelHealTarget(hbLastButton.unit)
        elseif HealBot_MouseWheelCmd==HEALBOT_TOGGLE_PRIVATETANKS then
            HealBot_Panel_ToggelPrivateTanks(hbLastButton.unit, false)
        elseif HealBot_MouseWheelCmd==HEALBOT_TOGGLE_PRIVATEHEALERS then
            HealBot_Panel_ToggelPrivateHealers(hbLastButton.unit, false)
        elseif HealBot_MouseWheelCmd==HEALBOT_RESET_BAR then
            HealBot_Reset_Unit(hbLastButton.unit)
        elseif HealBot_MouseWheelCmd==HEALBOT_RANDOMMOUNT and UnitIsUnit(hbLastButton.unit,"player") and not UnitAffectingCombat("player") then
            HealBot_MountsPets_ToggelMount("all")
        elseif HealBot_MouseWheelCmd==HEALBOT_RANDOMGOUNDMOUNT and UnitIsUnit(hbLastButton.unit,"player") and not UnitAffectingCombat("player") then
            HealBot_MountsPets_ToggelMount("ground")
        elseif HealBot_MouseWheelCmd==HEALBOT_RANDOMPET and UnitIsUnit(hbLastButton.unit,"player") then
            HealBot_MountsPets_RandomPet(false)   
        elseif HealBot_MouseWheelCmd==HEALBOT_RANDOMFAVMOUNT and UnitIsUnit(hbLastButton.unit,"player") then
            HealBot_MountsPets_FavMount()   
        elseif HealBot_MouseWheelCmd==HEALBOT_RANDOMFAVPET and UnitIsUnit(hbLastButton.unit,"player") then
            HealBot_MountsPets_RandomPet(true)   
        elseif HealBot_MouseWheelCmd==HEALBOT_EMOTE then
            DoEmote(HealBot_Globals.HealBot_Emotes[y], hbLastButton.unit)
        end
    end
end

                                  
function HealBot_Action_HealUnit_Wheel(self, delta)
    HealBot_Action_DoHealUnit_Wheel(self, delta)
end

function HealBot_MountsPets_InitUse()
    if HealBot_Globals.HealBot_Enable_MouseWheel and HEALBOT_GAME_VERSION>3 then
        HealBot_setOptions_Timer(410)
    end
end

function HealBot_MountsPets_InitMount()
    --SetMapToCurrentZone()
    for z,_ in pairs(HealBot_GMount) do
        HealBot_GMount[z]=nil;
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
    HealBot_mountData["IncFlying"]=false
    
    HealBot_mountData["playerFaction"]=0 -- Horde
    local _,raceId = UnitRace("player");
    if raceId=="Dwarf" or raceId=="Draenei" or raceId=="Gnome" or raceId=="Human" or raceId=="NightElf" or raceId=="Worgen" then
        HealBot_mountData["playerFaction"]=1
    elseif raceId=="Pandaren" then
        if UnitFactionGroup("player")=="Alliance" then
            HealBot_mountData["playerFaction"]=1
        end
    end

    local mapC = 3 --GetCurrentMapContinent();
    if UnitLevel("player")>59 and (mapC==3 or mapC==5) or (mapC == 4 and IsSpellKnown(54197)) or (mapC<3 and IsSpellKnown(90267)) 
        or (mapC == 6 and IsSpellKnown(115913)) then --or (mapC == 7 and IsSpellKnown(nnnnnn)) then
        HealBot_mountData["IncFlying"]=true
    end
    
    local x = C_MountJournal.GetNumMounts()
    for z=1,x do
        local mount, sID, _, _, isUsable, _, _, _, faction, _, isCollected = C_MountJournal.GetMountInfoByID(z)
        if faction and isUsable and isCollected then
            local englishFaction = UnitFactionGroup("player")
            if (faction~=HealBot_mountData["playerFaction"]) then
                isUsable=nil
            end
        end
        
        if isUsable and isCollected and not HealBot_Globals.excludeMount[mount] then
            local _, _, _, _, mountType = C_MountJournal.GetMountInfoExtraByID(z)
            if (mountType==248 or mountType==247 or mountType==242) then
                if HealBot_mountData["IncFlying"] then
                    table.insert(HealBot_FMount, mount);
                    HealBot_MountIndex[mount]=z
                end
            elseif (mountType==232 or mountType==254) then
                table.insert(HealBot_SMount, mount);
                HealBot_MountIndex[mount]=z
            elseif (mountType==230 or mountType==231 or mountType==241) then
                table.insert(HealBot_GMount, mount);
                HealBot_MountIndex[mount]=z
            end
        end
    end   
    
    if #HealBot_FMount<4 then
        HealBot_mountData["PrevFlying#"]=0
    else
        HealBot_mountData["PrevFlying#"]=ceil(#HealBot_FMount/3) 
    end
    if #HealBot_GMount<4 then
        HealBot_mountData["PrevGround#"]=0
    else
        HealBot_mountData["PrevGround#"]=ceil(#HealBot_GMount/3) 
    end

    if #HealBot_GMount==0 and #HealBot_FMount==0 then
        HealBot_mountData["ValidUse"]=false
    else
        HealBot_mountData["ValidUse"]=true
    end
end

function HealBot_MountsPets_DislikeMount(action)
    local z = C_MountJournal.GetNumMounts()
    local mount=nil
    for i=1,z do
         local creatureName, sID, _, active, isUsable, _, _, _, _, _, isCollected = C_MountJournal.GetMountInfoByID(i)
         if active then
             mount=creatureName
            break
         end
     end
    if mount then
        if action=="Exclude" then
            if HealBot_Globals.excludeMount[mount] then
                HealBot_AddChat(HEALBOT_OPTION_EXCLUDEMOUNT_OFF.." "..mount)
                HealBot_Globals.excludeMount[mount]=nil
            else
                HealBot_AddChat(HEALBOT_OPTION_EXCLUDEMOUNT_ON.." "..mount)
                HealBot_Globals.excludeMount[mount]=true
            end
            HealBot_setOptions_Timer(405)
        else
            if HealBot_Globals.dislikeMount[mount] then
                HealBot_AddChat(HEALBOT_OPTION_DISLIKEMOUNT_OFF.." "..mount)
                HealBot_Globals.dislikeMount[mount]=nil
            else
                HealBot_AddChat(HEALBOT_OPTION_DISLIKEMOUNT_ON.." "..mount)
                HealBot_Globals.dislikeMount[mount]=275
            end
        end
    end
end