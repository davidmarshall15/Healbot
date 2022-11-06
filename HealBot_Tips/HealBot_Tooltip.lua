local linenum=1
local HealBot_CheckBuffs = {}
local xUnit=nil
local xGUID=nil
local xButton=nil
local hbtMaxLines=0
local _
local powerCols={["r"]=1,["g"]=1,["b"]=1}
local playerPowerCols={["r"]=1,["g"]=1,["b"]=1}
local hbCommands = { [strlower(HEALBOT_DISABLED_TARGET)]=true,
                     [strlower(HEALBOT_ASSIST)]=true, 
                     [strlower(HEALBOT_FOCUS)]=true,
                     [strlower(HEALBOT_MENU)]=true,
                     [strlower(HEALBOT_HBMENU)]=true,
                     [strlower(HEALBOT_STOP)]=true,
                     [strlower(HEALBOT_IGNOREAURAALL)]=true,
                     [strlower(HEALBOT_CANCELREQUEST)]=true,
                    }  
local hbPlayerCommands = {}
if HEALBOT_GAME_VERSION>3 then
    hbPlayerCommands = { [strlower(HEALBOT_MOUNTSPETS)]=true,
                         [strlower(HEALBOT_FAVMOUNT)]=true,
                         [strlower(HEALBOT_RANDOMMOUNT)]=true,
                         [strlower(HEALBOT_RANDOMGOUNDMOUNT)]=true,
                         [strlower(HEALBOT_FAVPET)]=true,
                       }
elseif HEALBOT_GAME_VERSION>2 then
    hbPlayerCommands = { [strlower(HEALBOT_MOUNTS)]=true,
                         [strlower(HEALBOT_FAVMOUNT)]=true,
                         [strlower(HEALBOT_RANDOMMOUNT)]=true,
                         [strlower(HEALBOT_RANDOMGOUNDMOUNT)]=true,
                       }
end

local hbCustomTipAnchor=nil
local hbCustomTipAnchorText={}
local hbCustomTipAnchorObjects={}
local HealBot_Tooltip_luVars={}
HealBot_Tooltip_luVars["uGroup"]=false
HealBot_Tooltip_luVars["doInit"]=true

function HealBot_Tooltip_setLuVars(vName, vValue)
    HealBot_Tooltip_luVars[vName]=vValue
      --HealBot_setCall("HealBot_Tooltip_setLuVars - "..vName)
end

function HealBot_Tooltip_Clear_CheckBuffs()
    for x,_ in pairs(HealBot_CheckBuffs) do
        HealBot_CheckBuffs[x]=nil;
    end
end

function HealBot_Tooltip_CheckBuffs(buff)
    HealBot_CheckBuffs[buff]=true;
end

function HealBot_Tooltip_ReturnMinsSecs(s)
    local mins=floor(s/60)
    local secs=floor(s-(mins*60))
  --  mins=mins+1
    if secs<10 then secs="0"..secs end
    return mins,secs
end

function HealBot_Tooltip_GetHealSpell(button,sName)
    if not sName or not HealBot_Spell_Names[sName] then
        if sName then
            if not IsUsableItem(sName) then
                return nil, 1, 0.2, 0
            else
                if not button.player then
                    if IsItemInRange(sName,button.unit) then
                        return sName, 0.2, 0.5, 1, true
                    else
                        return sName, 0.1, 0.25, 0.7, true
                    end
                else
                    return sName, 0.2, 0.5, 1, true
                end
            end
        else
            return nil, 1, 0.2, 0
        end
    end

    if HealBot_UnitInRangeExc30(button,sName)<1 then
        return sName, 1, 0.2, 0
    end
 
    return sName, 1, 1, 1
end

function HealBot_Tooltip_GCDV1()
    return 1.5
end

local gcdDUR=0
function HealBot_Tooltip_GCDV4()
    _, gcdDUR = GetSpellCooldown(61304) -- GCD
    return gcdDUR
end

local HealBot_Tooltip_GCD=HealBot_Tooltip_GCDV1
if HEALBOT_GAME_VERSION>3 then
    HealBot_Tooltip_GCD=HealBot_Tooltip_GCDV4
end
function HealBot_Tooltip_getSpellCD(validSpellName, isMacro)
    local z, x, _ = GetSpellCooldown(validSpellName);
    local gcd=0
    if HealBot_Globals.Tooltip_IgnoreGCD then
        gcd=HealBot_Tooltip_GCD()
    end
    if HealBot_Globals.Tooltip_ShowCD and x and x>gcd then 
        z = HealBot_Comm_round(x-(GetTime()-z),0)
        local u=HEALBOT_TOOLTIP_SECS
        if z>59 then
            z = ceil(z/60)
            u=HEALBOT_TOOLTIP_MINS
        end                            
        validSpellName=validSpellName..HEALBOT_TOOLTIP_CD..z..u 
        if z>0 then return validSpellName,1,0.2,0 end
    elseif not isMacro and (x or 1)>gcd then
        return validSpellName,1,0.2,0
    end
    if isMacro then
        return validSpellName,0.5,1,0
    else
        return validSpellName,1,1,1
    end
end

function HealBot_Tooltip_setspellName(button, spellName)
    if spellName and string.len(spellName)>0 then
        local validSpellName=spellName
        local spellAR,spellAG,spellAB=1,1,1
        if hbCommands[strlower(spellName)] or (button.player and hbPlayerCommands[strlower(spellName)]) then
            spellAR,spellAG,spellAB=1,1,0
        else
            local e,t=string.split("=", spellName)
            if e and e==HEALBOT_EMOTE and t then
                if button.status.range<1 then
                    spellAR,spellAG,spellAB=0.7,0.3,0
                else
                    spellAR,spellAG,spellAB=1,0.58,0
                end
                validSpellName=t
            else
                local mIdx=GetMacroIndexByName(spellName)
                if mIdx==0 then 
                    validSpellName, spellAR, spellAG, spellAB, isItem = HealBot_Tooltip_GetHealSpell(button,spellName) 
                    if validSpellName and not isItem then
                        validSpellName,spellAR,spellAG,spellAB=HealBot_Tooltip_getSpellCD(validSpellName, false)
                    end
                else
                    if validSpellName and GetMacroIndexByName(validSpellName)>0 then
                        local _,_,mText=GetMacroInfo(GetMacroIndexByName(validSpellName))
                        local _,s=string.find(mText, "#showtooltip ")
                        if s and s>0 then
                            local e,_=string.find(mText, "\n")
                            if e and e>0 then
                                 validSpellName=(string.sub(mText, s+1, e-1)) or validSpellName
                            end
                        end
                    end
                    validSpellName,spellAR,spellAG,spellAB=HealBot_Tooltip_getSpellCD(validSpellName, true)
                end
            end
        end
        return validSpellName, spellAR, spellAG, spellAB
    else
        return nil
    end
end

local hbTipUnitRanks={}
local hbTipUnitRoles={}
function HealBot_Tooltip_Init()
    HealBot_Tooltip_luVars["doInit"]=false
    hbTipUnitRanks={[0]="",
                    [1]=HEALBOT_WORD_RAIDASSISTANT.." ",
                    [2]=HEALBOT_WORD_RAIDLEADER.." ",
                    [3]=HEALBOT_WORD_MASTERLOOTER.." ",
                    [4]=HEALBOT_WORD_GROUPLEADER.." ",
                   }
    hbTipUnitRoles={[0]=" ",
                    [1]=HEALBOT_WORD_MAINTANK.." ",
                    [2]=HEALBOT_WORD_TANK.." ",
                    [3]=HEALBOT_WORD_HEALER.." ",
                    [4]=HEALBOT_WORD_PRIVATETANK.." ",
                    [5]=HEALBOT_WORD_PRIVATEHEALER.." ",
                    [6]=HEALBOT_WORD_DAMAGER.." ",
                    [7]=HEALBOT_WORD_RAIDER.." ",
                   }
end

function HealBot_Tooltip_SetLine(lNo,lText,lR,lG,lB,la,rText,rR,rG,rB,ra)
    if rText then
        GameTooltip:AddDoubleLine(lText,rText,lR,lG,lB,rR,rG,rB)
    else
        GameTooltip:AddLine(lText,lR,lG,lB)
    end
end

local HealBot_Tooltip_Power = 9
local HealBot_Tooltip_PowerDesc = {[0]="Mana", 
                                   [1]="Rage", 
                                   [2]="Focus", 
                                   [3]="Energy", 
                                   [4]="Happiness", 
                                   [5]="Runes", 
                                   [6]="Runic Power", 
                                   [7]="Soul Shards", 
                                   [8]="Eclipse", 
                                   [9]="Holy Power"}

function HealBot_Tooltip_SpellSummary(spellName)
    local ret_val = "  "
    if HealBot_Spell_Names[spellName] then
        if HealBot_Data["POWERTYPE"]==0 and HealBot_Spell_IDs[HealBot_Spell_Names[spellName]].Mana<HealBot_Tooltip_Power then
            ret_val = " -  "..HealBot_Spell_IDs[HealBot_Spell_Names[spellName]].Mana.." Power"
        else
            ret_val = " -  "..HealBot_Spell_IDs[HealBot_Spell_Names[spellName]].Mana.." "..HealBot_Tooltip_PowerDesc[HealBot_Data["POWERTYPE"]]
        end
    else
        ret_val = " - "..spellName
    end
    return ret_val;
end

local UnitBuffIcons=nil
local UnitDebuffIcons=nil
local ttCaster,ttHoTd,ttHoTc,ttHoTright,ttName=nil,nil,nil,nil,HEALBOT_WORDS_UNKNOWN
local hbHoTline1,ttHoTdt=true,0
function HealBot_ToolTip_ShowHoT(buttonId, unit)
    if HealBot_Globals.Tooltip_ShowHoT then
        hbHoTline1=true
        UnitBuffIcons=HealBot_Aura_ReturnHoTdetails(buttonId)
        if linenum<43 and UnitBuffIcons then
            for i = 1,10 do
                if UnitBuffIcons[i].current and UnitBuffIcons[i].unitCaster and UnitBuffIcons[i].spellId>0 then
                    ttCaster=UnitName(UnitBuffIcons[i].unitCaster)
                    ttName=HealBot_Aura_ReturnHoTdetailsname(UnitBuffIcons[i].spellId)
                    if ttCaster and ttName and linenum<44 then
                        ttHoTd=nil
                        if hbHoTline1 then
                            hbHoTline1=false
                            linenum=linenum+1
                            HealBot_Tooltip_SetLine(linenum," ",0,0,0,0)
                        end
                        linenum=linenum+1
                        if UnitBuffIcons[i].expirationTime and UnitBuffIcons[i].expirationTime>0 then
                            ttHoTd=floor(UnitBuffIcons[i].expirationTime-GetTime())
                        end
                        ttHoTc=UnitBuffIcons[i].count or 0
                        ttHoTright=nil
                        if ttHoTd and ttHoTd>60 then
                            ttHoTdt=floor(ttHoTd/60)
                            if ttHoTdt>120 then
                                ttHoTd=nil
                            else
                                ttHoTd=ttHoTd - (ttHoTdt*60)
                                if ttHoTd<10 then ttHoTd="0"..ttHoTd end
                                ttHoTd=ttHoTdt.."m "..ttHoTd
                            end
                        end
                        if ttHoTd then 
                            ttHoTright=" "..HEALBOT_OPTIONS_HOTTEXTDURATION..": "..ttHoTd.."s   " 
                        else
                            ttHoTright=" "
                        end
                        if ttHoTc>0 then 
                            ttHoTright=ttHoTright..HEALBOT_OPTIONS_HOTTEXTCOUNT..": "..ttHoTc.."   " 
                        else
                            ttHoTright=ttHoTright.."   " 
                        end
                        if ttHoTright then 
                            HealBot_Tooltip_SetLine(linenum,"   "..ttCaster.." "..strlower(HEALBOT_WORDS_CAST).." "..ttName.." ",0.4,1,1,1,ttHoTright,0.7,1,0.7,1)
                        else
                            HealBot_Tooltip_SetLine(linenum,"   "..ttCaster.." "..strlower(HEALBOT_WORDS_CAST).." "..ttName.." ",0.4,1,1,1)
                        end
                    end
                end
            end
        end
    end
end

local hbtPosFrm, hbtPosTop, hbtPosX, hbtPosY="",0,0,0
function HealBot_ToolTip_SetTooltipPos(frame)
    hbtPosFrm = _G["f"..frame.."_HealBot_Action"]
    hbtPosTop = hbtPosFrm:GetTop();
    hbtPosX, hbtPosY = GetCursorPosition();
    if Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][frame]["TIPLOC"]>1 then
        if Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][frame]["TIPLOC"]==2 then
            hbtPosY=hbtPosY/UIParent:GetScale();
            GameTooltip:SetOwner(hbtPosFrm, "ANCHOR_LEFT", 0, 0-(hbtPosTop-(hbtPosY-50)))
        elseif Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][frame]["TIPLOC"]==3 then
            hbtPosY=hbtPosY/UIParent:GetScale();
            GameTooltip:SetOwner(hbtPosFrm, "ANCHOR_RIGHT", 0, 0-(hbtPosTop-(hbtPosY-50)))
        elseif Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][frame]["TIPLOC"]==4 then
           GameTooltip:SetOwner(hbtPosFrm, "ANCHOR_TOP")
        elseif Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][frame]["TIPLOC"]==5 then
           GameTooltip:SetOwner(hbtPosFrm, "ANCHOR_BOTTOM")
        elseif Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][frame]["TIPLOC"]==6 then
            hbtPosX=hbtPosX/UIParent:GetScale();
            hbtPosY=hbtPosY/UIParent:GetScale();
            GameTooltip:SetOwner(hbtPosFrm, "ANCHOR_NONE")
            GameTooltip:SetPoint("TOPLEFT","WorldFrame","BOTTOMLEFT",hbtPosX+25,hbtPosY-20);
        elseif Healbot_Config_Skins.ToolTip[Healbot_Config_Skins.Current_Skin] then
            GameTooltip:SetOwner(hbtPosFrm, "ANCHOR_NONE")
            GameTooltip:SetPoint(Healbot_Config_Skins.ToolTip[Healbot_Config_Skins.Current_Skin]["ANCHORPOINT"],
                                     "WorldFrame",
                                     Healbot_Config_Skins.ToolTip[Healbot_Config_Skins.Current_Skin]["ANCHORPOINT"],
                                     Healbot_Config_Skins.ToolTip[Healbot_Config_Skins.Current_Skin]["ANCHORX"],
                                     Healbot_Config_Skins.ToolTip[Healbot_Config_Skins.Current_Skin]["ANCHORY"])
        else
            GameTooltip:SetOwner(hbtPosFrm, "ANCHOR_NONE")
            GameTooltip:SetPoint("BOTTOMRIGHT","WorldFrame","BOTTOMRIGHT",-275,175);
        end
    else
        GameTooltip:SetOwner(hbtPosFrm, "ANCHOR_NONE")
        GameTooltip_SetDefaultAnchor(GameTooltip, HealBot_ScanTooltip)
    end
end

function HealBot_Action_GetTimeOffline(button)
    local timeOffline=nil
    local offlineStart=HealBot_Action_getGuidData(button.guid, "OFFLINE")
    if offlineStart then
        timeOffline = GetTime() - offlineStart;
        local seconds = math.floor(timeOffline % 60)
        local minutes = math.floor(timeOffline / 60) % 60
        local hours = math.floor(timeOffline / 3600)
        timeOffline = "";
        if hours > 0 then
            if hours == 1 then
                timeOffline = hours.." hour ";
            else
                timeOffline = hours.." hours ";
            end
        end
        if minutes > 0 then
            if minutes == 1 then
                timeOffline = timeOffline..minutes.." min ";
            else
                timeOffline = timeOffline..minutes.." mins ";
            end
        end
        if seconds > 0 then
            if seconds == 1 then
                timeOffline = timeOffline..seconds.." sec";
            else
                timeOffline = timeOffline..seconds.." secs";
            end
        end
    end      
    return timeOffline;
end

function HealBot_Tooltip_addPlayerDebuffLine(uName, debuffId, debuffName)
    linenum=linenum+1
    if HealBot_Globals.CDCBarColour[debuffId] then
        HealBot_Tooltip_SetLine(linenum,uName.." suffers from "..debuffName,
                                    (HealBot_Globals.CDCBarColour[debuffId].R or 0.4)+0.2,
                                    (HealBot_Globals.CDCBarColour[debuffId].G or 0.05)+0.2,
                                    (HealBot_Globals.CDCBarColour[debuffId].B or 0.2)+0.2,
                                    1," ",0,0,0,0)
    elseif HealBot_Globals.CDCBarColour[debuffName] then
        HealBot_Tooltip_SetLine(linenum,uName.." suffers from "..debuffName,
                                    (HealBot_Globals.CDCBarColour[debuffName].R or 0.4)+0.2,
                                    (HealBot_Globals.CDCBarColour[debuffName].G or 0.05)+0.2,
                                    (HealBot_Globals.CDCBarColour[debuffName].B or 0.2)+0.2,
                                    1," ",0,0,0,0)
    else
        local DebuffType=HealBot_Aura_retDebufftype(debuffId)
        if HealBot_Config_Cures.CDCBarColour[DebuffType] then
            HealBot_Tooltip_SetLine(linenum,uName.." suffers from "..debuffName,
                                        (HealBot_Config_Cures.CDCBarColour[DebuffType].R or 0.5)+0.2,
                                        (HealBot_Config_Cures.CDCBarColour[DebuffType].G or 0.2)+0.2,
                                        (HealBot_Config_Cures.CDCBarColour[DebuffType].B or 0.4)+0.2,
                                        1," ",0,0,0,0)
        else
            local customDebuffPriority=HEALBOT_CUSTOM_en.."15"
            HealBot_Tooltip_SetLine(linenum,uName.." suffers from "..debuffName,
                                        (HealBot_Globals.CDCBarColour[customDebuffPriority].R or 0.5)+0.2,
                                        (HealBot_Globals.CDCBarColour[customDebuffPriority].G or 0.2)+0.2,
                                        (HealBot_Globals.CDCBarColour[customDebuffPriority].B or 0.4)+0.2,
                                        1," ",0,0,0,0)
        end
    end
end

function HealBot_Tooltip_setPlayerPowerCols(r,g,b)
    playerPowerCols.r,playerPowerCols.g,playerPowerCols.b=r,g,b
end

function HealBot_Action_DoRefreshTooltip()
    if HealBot_Data["TIPTYPE"]=="NONE" then return end
    if HealBot_Globals.ShowTooltip==false then return end
    if HealBot_Globals.DisableToolTipInCombat and HealBot_Data["UILOCK"] then return end
    xButton=HealBot_Data["TIPBUTTON"]
    if not xButton then return end
    xUnit=xButton.unit
    xGUID=UnitGUID(xUnit)
    if not xGUID then return end
    local uName=xButton.text.nameonly
    if not uName then return end;

    if HealBot_Tooltip_luVars["doInit"] then
        HealBot_Tooltip_Init()
    end
    
    HealBot_ToolTip_SetTooltipPos(xButton.frame);

    if HealBot_Data["TIPTYPE"]=="WoWUnit" then
        GameTooltip:SetUnit(xUnit)
    else
        if xUnit=="target" and HealBot_Globals.TargetBarRestricted==1 then
            HealBot_Action_RefreshTargetTooltip(xButton)
            return
        end

        local hlth=xButton.health.current
        local maxhlth=xButton.health.max
        local mana=xButton.mana.current
        local maxmana=xButton.mana.max
        powerCols.r,powerCols.g,powerCols.b=xButton.mana.r,xButton.mana.g,xButton.mana.b
        if powerCols.r==0 and powerCols.g==0 then
            powerCols.r=0.28
            powerCols.g=0.28
        end
        if playerPowerCols.r==0 and playerPowerCols.g==0 then
            playerPowerCols.r=0.28
            playerPowerCols.g=0.28
        end

        if hlth>maxhlth then hlth=maxhlth end
      
        local UnitOffline=HealBot_Action_GetTimeOffline(xButton); --added by Diacono
        local UnitTag=xButton.text.tag
        if UnitOffline then UnitTag="" end
        local DebuffType=xButton.aura.debuff.type;
        linenum = 1

        GameTooltip:ClearLines()

        if HealBot_Globals.Tooltip_ShowTarget then
            if uName then
                local r,g,b=xButton.text.r,xButton.text.g,xButton.text.b
                local uLvl=xButton.level
                if uLvl<1 then 
                    uLvl=nil
                else
                    uLvl="Level "..uLvl
                end
                local uClassify=UnitClassification(xUnit) or " "
                if uClassify=="worldboss" or HealBot_UnitBosses(xUnit) then 
                    uClassify="Boss"
                elseif uClassify=="rareelite" then 
                    uClassify="Rare Elite"
                elseif uClassify=="elite" then 
                    uClassify="Elite"
                elseif uClassify=="rare" then 
                    uClassify="Rare"
                else
                    uClassify=nil
                end
                if uClassify then
                    if uLvl then
                        uLvl=uClassify.." "..uLvl
                    else
                        uLvl="Boss"
                    end
                elseif not uLvl then
                    uLvl=""
                end
                local uClass=UnitCreatureFamily(xUnit) or UnitClass(xUnit) or UnitCreatureType(xUnit)
                if uClass==uName then uClass=UnitCreatureType(xUnit) or "" end
                if not uClass or uClass=="" then
                    if strfind(xUnit,"pet") then
                        uClass=HEALBOT_WORD_PET 
                    else
                        uClass=HEALBOT_WORDS_UNKNOWN 
                    end
                end
                local uSpec=" "
                if HealBot_Panel_RaidUnitGUID(xButton.guid) then
                    uSpec=HealBot_Action_getGuidData(xButton.guid, "SPEC")
                else
                    uSpec=xButton.spec
                end
                if HEALBOT_GAME_VERSION>2 and uSpec==" " then
                    HealBot_OnEvent_SpecChange(xButton)
                end
                HealBot_Tooltip_luVars["uGroup"]=0
                if IsInRaid() then 
                    HealBot_Tooltip_luVars["uGroup"]=xButton.group
                end
                if HealBot_Globals.Tooltip_ShowRank or HealBot_Globals.Tooltip_ShowRole then
                    local uRankIdx=xButton.rank
                    local uRoleIdx=xButton.role
                    if not HealBot_Globals.Tooltip_ShowRank then uRankIdx=0 end
                    if not HealBot_Globals.Tooltip_ShowRole then uRoleIdx=0 end
                    local uRace=" "..(UnitRace(xButton.unit) or "")
                    local uRank=hbTipUnitRanks[uRankIdx]
                    if uRankIdx>0 then
                        if HealBot_Globals.Tooltip_HideRoleWhenRank then
                            uRoleIdx=0
                        end
                    else
                        if HealBot_Panel_RaidUnitGUID(xButton.guid) then
                            if uRoleIdx==0 then
                                if xButton.status.incombat then
                                    uRank=HEALBOT_WORD_INCOMBAT
                                elseif xButton.player then
                                    if IsResting() then
                                        uRank=HEALBOT_WORD_RESTING
                                    else
                                        uRank=HEALBOT_WORD_EXPLORING
                                    end
                                else
                                    uRank=HEALBOT_WORD_EXPLORING
                                end
                            end
                        else
                            if UnitIsFriend(xButton.unit,"player") then
                                uRank=HEALBOT_CUSTOM_CASTBY_FRIEND
                            elseif UnitIsEnemy(xButton.unit,"player") then
                                uRank=HEALBOT_CUSTOM_CASTBY_ENEMY
                            else
                                uRank=HEALBOT_WORD_NEUTRAL
                            end
                        end
                    end
                    local uRole=hbTipUnitRoles[uRoleIdx]
                    if uRank==HEALBOT_CUSTOM_CASTBY_ENEMY then
                        HealBot_Tooltip_SetLine(linenum,uRank..uRole,1,0.25,0.25,1,uLvl..uRace,1,0.25,0.25,1)
                    else
                        HealBot_Tooltip_SetLine(linenum,uRank..uRole,r,g,b,1,uLvl..uRace,r,g,b,1)
                    end
                    linenum=linenum+1
                    if mana and maxmana>0 and not UnitOffline and HealBot_Tooltip_luVars["uGroup"]>0 and string.len(UnitTag)>0 then
                        HealBot_Tooltip_SetLine(linenum,uName.." - "..UnitTag,r,g,b,1,uSpec..uClass,r,g,b,1)
                    else
                        HealBot_Tooltip_SetLine(linenum,uName,r,g,b,1,uSpec..uClass,r,g,b,1)
                    end
                else
                    if mana and maxmana>0 and not UnitOffline and HealBot_Tooltip_luVars["uGroup"]>0 and string.len(UnitTag)>0 then
                        HealBot_Tooltip_SetLine(linenum,uName.." - "..UnitTag,r,g,b,1,uLvl..uSpec..uClass,r,g,b,1)
                    else
                        HealBot_Tooltip_SetLine(linenum,uName,r,g,b,1,uLvl..uSpec..uClass,r,g,b,1)
                    end
                end
          
                local zone=HealBot_UnitZone(xButton)

                linenum=linenum+1
                if UnitOffline then
                    linenum=linenum+1
                    HealBot_Tooltip_SetLine(linenum,HB_TOOLTIP_OFFLINE,1,0.5,0,1,UnitOffline,1,1,1,1)
                else
                    if hlth and maxhlth then
                        local inHeal, inAbsorb = HealBot_IncHeals_retHealsIn(xUnit, xButton)
                        local hPct=100
                        if maxhlth>0 then
                            hPct=floor((hlth/maxhlth)*100)
                        end
                        hlth=HealBot_Text_readNumber(hlth)
                        maxhlth=HealBot_Text_readNumber(maxhlth)
                        if zone and not strfind(zone,"Level") then
                            HealBot_Tooltip_SetLine(linenum,zone,1,1,1,1,hlth.."/"..maxhlth.." ("..hPct.."%)",xButton.health.rcol,xButton.health.gcol,0,1)
                        else
                            HealBot_Tooltip_SetLine(linenum," ",1,1,1,1,hlth.."/"..maxhlth.." ("..hPct.."%)",xButton.health.rcol,xButton.health.gcol,0,1)
                        end
                        local vUnit=HealBot_retIsInVehicle(xUnit)
                        if vUnit then
                            linenum=linenum+1
                            local lr,lg,lb=HealBot_Action_ClassColour(vUnit)
                            hlth,maxhlth=HealBot_VehicleHealth(vUnit)
                            local hPct=floor((hlth/maxhlth)*100)
                            hlth=HealBot_Text_readNumber(hlth)
                            maxhlth=HealBot_Text_readNumber(maxhlth)
                            if UnitExists(vUnit) then
                                HealBot_Tooltip_SetLine(linenum,"  "..UnitName(vUnit),lr,lg,lb,1,hlth.."/"..maxhlth.." ("..hPct.."%)",xButton.health.rcol,xButton.health.gcol,0,1)
                            else
                                HealBot_Tooltip_SetLine(linenum,"  "..HEALBOT_VEHICLE,lr,lg,lb,1,hlth.."/"..maxhlth.." ("..hPct.."%)",xButton.health.rcol,xButton.health.gcol,0,1)
                            end
                        end
                    end
                    if xButton.aggro.threatpct>0 or mana or HealBot_Tooltip_luVars["uGroup"]>0 or string.len(UnitTag)>0 then
                        if not mana or (maxmana and maxmana==0) then
                            if xButton.aggro.threatpct>0 then
                                linenum=linenum+1
                                HealBot_Tooltip_SetLine(linenum,HEALBOT_WORD_THREAT.." "..xButton.aggro.threatpct.."%",1,0.1,0.1,1,UnitTag,xButton.text.sr,xButton.text.sg,xButton.text.sb,1)
                                linenum=linenum+1
                                local threatvalue=HealBot_Text_readNumber(xButton.aggro.threatvalue)
                                HealBot_Tooltip_SetLine(linenum,xButton.aggro.mobname.." ("..threatvalue..")",1,0.1,0.1,1,UnitTag,xButton.text.sr,xButton.text.sg,xButton.text.sb,1)
                            elseif HealBot_Tooltip_luVars["uGroup"]>0 then
                                linenum=linenum+1
                                HealBot_Tooltip_SetLine(linenum,HEALBOT_OPTIONS_GROUPHEALS.." "..HealBot_Tooltip_luVars["uGroup"],1,1,1,1,UnitTag,xButton.text.sr,xButton.text.sg,xButton.text.sb,1)
                            elseif string.len(UnitTag)>0 then
                                linenum=linenum+1
                                HealBot_Tooltip_SetLine(linenum,UnitTag,xButton.text.sr,xButton.text.sg,xButton.text.sb,1," ",0,0,0,0)
                            end
                        else
                            linenum=linenum+1
                            local mPct=xButton.mana.pct
                            mana=HealBot_Text_readNumber(mana)
                            maxmana=HealBot_Text_readNumber(maxmana)
                            if xButton.aggro.threatpct<1 then
                                if HealBot_Tooltip_luVars["uGroup"]>0 then
                                    HealBot_Tooltip_SetLine(linenum,HEALBOT_OPTIONS_GROUPHEALS.." "..HealBot_Tooltip_luVars["uGroup"],1,1,1,1,mana.."/"..maxmana.." ("..mPct.."%)",powerCols.r,powerCols.g,powerCols.b,1)
                                elseif string.len(UnitTag)>0 then
                                    HealBot_Tooltip_SetLine(linenum,UnitTag,xButton.text.sr,xButton.text.sg,xButton.text.sb,1,mana.."/"..maxmana.." ("..mPct.."%)",powerCols.r,powerCols.g,powerCols.b,1)
                                else
                                    HealBot_Tooltip_SetLine(linenum," ",0,0,0,0,mana.."/"..maxmana.." ("..mPct.."%)",powerCols.r,powerCols.g,powerCols.b,1)
                                end
                            else
                                HealBot_Tooltip_SetLine(linenum,HEALBOT_WORD_THREAT.." "..xButton.aggro.threatpct.."%",1,0.1,0.1,1,mana.."/"..maxmana.." ("..mPct.."%)",powerCols.r,powerCols.g,powerCols.b,1)
                                linenum=linenum+1
                                local threatvalue=HealBot_Text_readNumber(xButton.aggro.threatvalue)
                                HealBot_Tooltip_SetLine(linenum,xButton.aggro.mobname.." ("..threatvalue..")",1,0.1,0.1,1," ",UnitTag,xButton.text.sr,xButton.text.sg,xButton.text.sb,1)
                            end
                        end
                    end
                end

                UnitDebuffIcons=HealBot_Aura_ReturnDebuffdetails(xButton.id)
                if UnitDebuffIcons then
                    for i = 51,Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][xButton.frame]["MAXDICONS"]+50 do
                        if UnitDebuffIcons[i].current then
                            ttName=HealBot_Aura_ReturnDebuffdetailsname(UnitDebuffIcons[i].spellId)
                            if ttName then
                                HealBot_Tooltip_addPlayerDebuffLine(uName, UnitDebuffIcons[i].spellId, ttName)
                            end
                        else
                            break
                        end
                    end
                    if not UnitDebuffIcons[51].current and xButton.aura.debuff.id>0 then
                        HealBot_Tooltip_addPlayerDebuffLine(uName, xButton.aura.debuff.id, xButton.aura.debuff.name)
                    end
                end
                linenum=linenum+1
                if xButton.aura.buff.name and xButton.aura.buff.missingbuff then
                    linenum=linenum+1
                    local br,bg,bb=HealBot_Options_RetBuffRGB(xButton)
                    HealBot_Tooltip_SetLine(linenum,"  Requires "..xButton.aura.buff.name,br,bg,bb,1," ",0,0,0,0)
                end
                local d=false
                if HealBot_Globals.Tooltip_ShowMyBuffs then
                    for x,_ in pairs(HealBot_CheckBuffs) do
                        local z=HealBot_Aura_RetMyBuffTime(xButton,x)
                        if z and z>GetTime() then
                            d=true
                            z=z-GetTime()
                            local mins,secs=HealBot_Tooltip_ReturnMinsSecs(z)
                            linenum=linenum+1
                            local br,bg,bb=HealBot_Options_RetBuffRGBName(x)
                            if mins>1 then 
                                HealBot_Tooltip_SetLine(linenum,"    "..x.."  "..mins.." mins",br,bg,bb,1," ",0,0,0,0)
                            elseif tonumber(secs)>=0 then
                                HealBot_Tooltip_SetLine(linenum,"    "..x.."  "..secs.." secs",br,bg,bb,1," ",0,0,0,0)
                            else
                                linenum=linenum-1
                                HealBot_Queue_MyBuffsCheck(xGUID, xUnit)
                            end
                        end
                    end
                end
                if d then 
                    linenum=linenum+1 
                end
                HealBot_Tooltip_SetLine(linenum,"  ",0,0,0,0)
                if HealBot_Globals.ProtectPvP and UnitIsPVP(xUnit) and not UnitIsPVP("player") then 
                    HealBot_Tooltip_SetLine(linenum,"    ----- PVP -----",1,0.5,0.5,1,"----- PVP -----    ",1,0.5,0.5,1)
                    linenum=linenum+1;
                end
            end
        else
            HealBot_Tooltip_SetLine(linenum,HEALBOT_OPTIONS_TAB_SPELLS,1,1,1,1," ",0,0,0,0)
        end
        
        local bId, bName, sName, bR, bG, bB
        for x=1,HealBot_Globals.Tooltip_MaxButtons do
            bId, bName=HealBot_Options_ComboClass_Button(x)
            sName = HealBot_Action_SpellPattern(bId, string.upper(HealBot_Data["TIPTYPE"]))
            if x==1 and not HealBot_Data["UILOCK"] and HealBot_Globals.SmartCast and xButton.status.current<HealBot_Unit_Status["DC"] and not IsModifierKeyDown() and UnitIsFriend("player",xButton.unit) then 
                sName=HealBot_Action_SmartCast(xButton) or sName
            end
            sName, bR, bG, bB=HealBot_Tooltip_setspellName(xButton, sName)
            if sName then
                linenum=linenum+1
                HealBot_Tooltip_SetLine(linenum,bName..": "..sName, bR, bG, bB,1,HealBot_Tooltip_SpellSummary(sName),playerPowerCols.r,playerPowerCols.g,playerPowerCols.b,1)
            end
        end

        HealBot_ToolTip_ShowHoT(xButton.id, xUnit)
    end
    if HealBot_Globals.Tooltip_SetScale then 
        GameTooltip:SetScale(HealBot_Globals.Tooltip_Scale)
    end
    GameTooltip:Show()
    if HealBot_Globals.Tooltip_SetAlpha then 
        GameTooltip:SetAlpha(HealBot_Globals.Tooltip_SetAlphaValue)
    end
    hbtMaxLines=linenum
end

function HealBot_Action_DoRefreshTargetTooltip(button)
    HealBot_TooltipInit();
    GameTooltip:ClearLines()
    linenum=1
    local r,g,b=button.text.r,button.text.g,button.text.b

    if UnitClass(button.unit) then
        HealBot_Tooltip_SetLine(linenum,button.text.nameonly,r,g,b,1,"Level "..button.level..button.spec..UnitClass(button.unit),r,g,b,1)    
    else
        HealBot_Tooltip_SetLine(linenum,button.text.nameonly,r,g,b,1,rText,rR,rG,rB,ra)
    end
    linenum=linenum+1
    HealBot_Tooltip_SetLine(linenum,HEALBOT_TOOLTIP_TARGETBAR,1,1,0.5,1,HEALBOT_OPTIONS_TAB_SPELLS.." "..HEALBOT_SKIN_DISTEXT,1,1,0,1)
    linenum=linenum+2
    if HealBot_Globals.SmartCast then
        HealBot_Tooltip_SetLine(linenum," "..HEALBOT_OPTIONS_BUTTONLEFT..":",1,1,0.2,1,HEALBOT_TITAN_SMARTCAST.." ",1,1,1,1)
    end
    linenum=linenum+1
    HealBot_Tooltip_SetLine(linenum," "..HEALBOT_OPTIONS_BUTTONRIGHT..":",1,1,0.2,1)
    if HealBot_Panel_RetMyHealTarget(button.unit) then
        HealBot_Tooltip_SetLine(linenum," "..HEALBOT_OPTIONS_BUTTONRIGHT..":",1,1,0.2,1,HEALBOT_WORDS_REMOVEFROM.." "..HEALBOT_OPTIONS_MYTARGET.." ",1,1,1,1)
    else
        HealBot_Tooltip_SetLine(linenum," "..HEALBOT_OPTIONS_BUTTONRIGHT..":",1,1,0.2,1,HEALBOT_WORDS_ADDTO.." "..HEALBOT_OPTIONS_MYTARGET.." ",1,1,1,1)
    end
    GameTooltip:Show()
    hbtMaxLines=linenum
end

function HealBot_Action_RefreshTooltip()
    HealBot_Action_DoRefreshTooltip()
end

function HealBot_Tooltip_Wrap(str, limit)
  limit = limit or 72
  local here = 1
  local buf = ""
  local t = {}
  str:gsub("(%s*)()(%S+)()",
  function(sp, st, word, fi)
        if fi-here > limit then
            --# Break the line
            here = st
            table.insert(t, buf)
            buf = word
        elseif string.len(buf)>1 then
            buf = buf.." "..word  --# Append
        else 
            buf = word
        end
  end)
  --# Tack on any leftovers
  if(buf ~= "") then
        table.insert(t, buf)
  end
  return t
end

function HealBot_Tooltip_DisplayIconTooltip(frame, details, name, aType, desc, r, g, b)
    HealBot_ToolTip_SetTooltipPos(frame);
    linenum = 1
    GameTooltip:ClearLines()

    HealBot_Tooltip_SetLine(linenum,name,r,g,b,1,aType,r,g,b,1)
    linenum=linenum+1
    if details.unitCaster and UnitName(details.unitCaster) then
        linenum=linenum+1
        if not UnitIsFriend("player",details.unitCaster) then
            HealBot_Tooltip_SetLine(linenum,HEALBOT_WORD_CASTER,1,1,1,1,UnitName(details.unitCaster),1,0.5,0.2,1)
        else
            HealBot_Tooltip_SetLine(linenum,HEALBOT_WORD_CASTER,1,1,1,1,UnitName(details.unitCaster),0.2,1,0.5,1)
        end
    end
    if details.type and string.len(details.type)>1 then
        linenum=linenum+1
        HealBot_Tooltip_SetLine(linenum,HEALBOT_WORD_TYPE,1,1,1,1,details.type,1,1,0,1)
    end
    if details.count>0 then
        linenum=linenum+1
        HealBot_Tooltip_SetLine(linenum,HEALBOT_OPTIONS_HOTTEXTCOUNT,1,1,1,1,details.count,1,1,0,1)
    end
    
    local eTime=ceil(details.expirationTime-GetTime())
    if eTime>90 then
        eTime=ceil(eTime/60)
        linenum=linenum+1
        HealBot_Tooltip_SetLine(linenum,HEALBOT_OPTIONS_HOTTEXTDURATION,1,1,1,1,eTime.." mins",1,1,0,1)
    elseif eTime>1 then
        linenum=linenum+1
        HealBot_Tooltip_SetLine(linenum,HEALBOT_OPTIONS_HOTTEXTDURATION,1,1,1,1,eTime.." secs",1,1,0,1)
    end 
    linenum=linenum+1
    HealBot_Tooltip_SetLine(linenum,HEALBOT_OPTIONS_CUSTOM_IDMETHODSID,1,1,1,1,details.spellId,1,1,0,1)
    if desc and string.len(desc)>1 then
        local desc_lines=HealBot_Tooltip_Wrap(desc,40)
        linenum=linenum+1
        for x=1,#desc_lines do
            linenum=linenum+1
            HealBot_Tooltip_SetLine(linenum,desc_lines[x],1,1,0,1)
        end
    end

    linenum=linenum+2
    if aType=="Buff" then
        local bPrio=HealBot_Globals.HealBot_Custom_Buffs[details.spellId] or HealBot_Globals.HealBot_Custom_Buffs[name] or 99
        if bPrio==99 then
            local bId=HealBot_Options_MissingBuffPrio(details.spellId)
            bPrio=HealBot_Globals.HealBot_Custom_Buffs[bId] or 20
        end
        HealBot_Tooltip_SetLine(linenum,HEALBOT_WORD_PRIORITY,1,1,1,1,bPrio,1,1,0,1)
        linenum=linenum+1
        if HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[details.spellId]==3 or HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[name]==3 then
            HealBot_Tooltip_SetLine(linenum,HEALBOT_SKIN_HEADERBARCOL,1,1,1,1,HEALBOT_WORD_ON,0.2,1,0.5,1)
        else
            HealBot_Tooltip_SetLine(linenum,HEALBOT_SKIN_HEADERBARCOL,1,1,1,1,HEALBOT_WORD_OFF,1,0.5,0.2,1)
        end
        linenum=linenum+1
        HealBot_Tooltip_SetLine(linenum,HEALBOT_OPTIONS_ICONSCALE,1,1,1,1,Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][frame]["SCALE"],1,1,0,1)
    else
        HealBot_Tooltip_SetLine(linenum,HEALBOT_WORD_PRIORITY,1,1,1,1,HealBot_Options_retDebuffPriority(details.spellId, name, details.type) or 20,1,1,0,1)
        linenum=linenum+1
        if HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[details.spellId]==3 or HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[name]==3 then
            HealBot_Tooltip_SetLine(linenum,HEALBOT_SKIN_HEADERBARCOL,1,1,1,1,HEALBOT_WORD_ON,0.2,1,0.5,1)
        else
            HealBot_Tooltip_SetLine(linenum,HEALBOT_SKIN_HEADERBARCOL,1,1,1,1,HEALBOT_WORD_OFF,1,0.5,0.2,1)
        end
        linenum=linenum+1
        HealBot_Tooltip_SetLine(linenum,HEALBOT_OPTIONS_ICONSCALE,1,1,1,1,Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][frame]["DSCALE"],1,1,0,1)
    end

    local spellLeft = HealBot_Action_SpellPattern("Left", "ICON");
    local spellMiddle = HealBot_Action_SpellPattern("Middle", "ICON");
    local spellRight = HealBot_Action_SpellPattern("Right", "ICON");
    local spellButton4 = HealBot_Action_SpellPattern("Button4", "ICON");
    local spellButton5 = HealBot_Action_SpellPattern("Button5", "ICON");
    
    linenum=linenum+1
    if aType=="Auto Debuff" then
        linenum=linenum+1
        HealBot_Tooltip_SetLine(linenum,HEALBOT_OPTIONS_BUTTONANY,1,1,1,1,HEALBOT_OPTIONS_DEBUFFAUTOTOCUSTOM,1,1,0,1)
    end
    if spellLeft then
        linenum=linenum+1
        HealBot_Tooltip_SetLine(linenum,HEALBOT_OPTIONS_BUTTONLEFT,1,1,1,1,spellLeft,1,1,0,1)
    end
    if spellMiddle then
        linenum=linenum+1
        HealBot_Tooltip_SetLine(linenum,HEALBOT_OPTIONS_BUTTONMIDDLE,1,1,1,1,spellMiddle,1,1,0,1)
    end
    if spellRight then
        linenum=linenum+1
        HealBot_Tooltip_SetLine(linenum,HEALBOT_OPTIONS_BUTTONRIGHT,1,1,1,1,spellRight,1,1,0,1)
    end
    if spellButton4 then
        linenum=linenum+1
        HealBot_Tooltip_SetLine(linenum,HEALBOT_OPTIONS_BUTTON4,1,1,1,1,spellButton4,1,1,0,1)
    end
    if spellButton5 then
        linenum=linenum+1
        HealBot_Tooltip_SetLine(linenum,HEALBOT_OPTIONS_BUTTON5,1,1,1,1,spellButton5,1,1,0,1)
    end
    GameTooltip:Show()
    hbtMaxLines=linenum
end

local hbIconTip={}
function HealBot_Tooltip_AuraUpdateIconTooltip(frame, details, name, aType,  r, g, b)
    local spell = Spell:CreateFromSpellID(details.spellId)
    spell:ContinueOnSpellLoad(function()
        local desc = spell:GetSpellDescription()
        HealBot_Tooltip_DisplayIconTooltip(frame, details, name, aType, desc, r, g, b)
    end)
end

function HealBot_Tooltip_DebuffIconTooltip(button, id)
    if HealBot_Globals.DisableToolTipInCombat and HealBot_Data["UILOCK"] then return end
    local r,g,b=1,1,1
    UnitDebuffIcons=HealBot_Aura_ReturnDebuffdetails(button.id)
    if UnitDebuffIcons[id].current and UnitDebuffIcons[id].spellId>0 then
        ttName=HealBot_Aura_ReturnDebuffdetailsname(UnitDebuffIcons[id].spellId)
        if ttName then
            hbIconTip["type"]="Debuff"
            if HealBot_Globals.CDCBarColour[UnitDebuffIcons[id].spellId] then
                r=(HealBot_Globals.CDCBarColour[UnitDebuffIcons[id].spellId].R or 0.4)+0.2
                g=(HealBot_Globals.CDCBarColour[UnitDebuffIcons[id].spellId].G or 0.05)+0.2
                b=(HealBot_Globals.CDCBarColour[UnitDebuffIcons[id].spellId].B or 0.2)+0.2
            elseif HealBot_Globals.CDCBarColour[ttName] then
                r=(HealBot_Globals.CDCBarColour[ttName].R or 0.4)+0.2
                g=(HealBot_Globals.CDCBarColour[ttName].G or 0.05)+0.2
                b=(HealBot_Globals.CDCBarColour[ttName].B or 0.2)+0.2
            else
                local DebuffType=HealBot_Aura_retDebufftype(UnitDebuffIcons[id].spellId)
                if HealBot_Config_Cures.CDCBarColour[DebuffType] then
                    r=(HealBot_Config_Cures.CDCBarColour[DebuffType].R or 0.5)+0.2
                    g=(HealBot_Config_Cures.CDCBarColour[DebuffType].G or 0.2)+0.2
                    b=(HealBot_Config_Cures.CDCBarColour[DebuffType].B or 0.4)+0.2
                else
                    local customDebuffPriority=HEALBOT_CUSTOM_en.."15"
                    r=(HealBot_Globals.CDCBarColour[customDebuffPriority].R or 0.5)+0.2
                    g=(HealBot_Globals.CDCBarColour[customDebuffPriority].G or 0.2)+0.2
                    b=(HealBot_Globals.CDCBarColour[customDebuffPriority].B or 0.4)+0.2
                    hbIconTip["type"]="Auto Debuff"
                end
            end
            hbIconTip["frame"]=button.frame
            hbIconTip["details"]=UnitDebuffIcons[id]
            hbIconTip["name"]=ttName
            hbIconTip["r"]=r
            hbIconTip["g"]=g
            hbIconTip["b"]=b
            HealBot_Tooltip_AuraUpdateIconTooltip(hbIconTip["frame"], 
                                                  hbIconTip["details"], 
                                                  hbIconTip["name"],
                                                  hbIconTip["type"],
                                                  hbIconTip["r"], 
                                                  hbIconTip["g"], 
                                                  hbIconTip["b"])
            HealBot_Data["TIPICON"]="DEBUFF"
        end
    end
end

function HealBot_Tooltip_BuffIconTooltip(button, id)
    if HealBot_Globals.DisableToolTipInCombat and HealBot_Data["UILOCK"] then return end
    local r,g,b=1,1,1
    UnitBuffIcons=HealBot_Aura_ReturnHoTdetails(button.id)
    if UnitBuffIcons and UnitBuffIcons[id].current and UnitBuffIcons[id].spellId>0 then
        ttName=HealBot_Aura_ReturnHoTdetailsname(UnitBuffIcons[id].spellId)
        if ttName then
            hbIconTip["frame"]=button.frame
            hbIconTip["details"]=UnitBuffIcons[id]
            hbIconTip["name"]=ttName
            hbIconTip["type"]="Buff"
            hbIconTip["r"]=r
            hbIconTip["g"]=g
            hbIconTip["b"]=b
            HealBot_Tooltip_AuraUpdateIconTooltip(hbIconTip["frame"], 
                                                  hbIconTip["details"], 
                                                  hbIconTip["name"],
                                                  hbIconTip["type"],
                                                  hbIconTip["r"], 
                                                  hbIconTip["g"], 
                                                  hbIconTip["b"])
            HealBot_Data["TIPICON"]="BUFF"
        end
    end
end

function HealBot_Tooltip_UpdateIconTooltip()
    HealBot_Tooltip_AuraUpdateIconTooltip(hbIconTip["frame"], 
                                          hbIconTip["details"], 
                                          hbIconTip["name"],
                                          hbIconTip["type"],
                                          hbIconTip["r"], 
                                          hbIconTip["g"], 
                                          hbIconTip["b"])
end

function HealBot_Action_RefreshTargetTooltip(button)
    HealBot_Action_DoRefreshTargetTooltip(button)
end

local tLine={}
function HealBot_Tooltip_OptionsHelp(title,text)
    if title and text then
        GameTooltip:ClearLines()
        for x,_ in pairs(tLine) do
            tLine[x]=nil;
        end
        local i=0
        for l in string.gmatch(text, "[^\n]+") do
            local t=(string.gsub(l, "^%s*(.-)%s*$", "%1"))
            if string.len(t)>1 then
                i=i+1
                tLine[i]=t
            end
        end
        local linenum=1
        local x, y = GetCursorPosition();
        x=x/UIParent:GetScale();
        y=y/UIParent:GetScale();
        local g=_G["HealBot_Options"]
        GameTooltip:SetOwner(g, "ANCHOR_NONE")
        GameTooltip:SetPoint("TOPLEFT","WorldFrame","BOTTOMLEFT",x,y-30);
        GameTooltip:AddLine(title,1,1,1)
        GameTooltip:AddLine("    ",1,1,1)
        for l=1,#tLine do 
            GameTooltip:AddLine(tLine[l],0.8,0.8,0.8)
        end
        GameTooltip:Show()
        hbtMaxLines=linenum
    end
end

function HealBot_Tooltip_Hide()
    GameTooltip:Hide()
    if HealBot_Globals.Tooltip_SetScale then GameTooltip:SetScale(1) end
    if HealBot_Globals.Tooltip_SetAlpha then GameTooltip:SetAlpha(1) end
end

local function HealBot_Tooltip_CustomAnchor_SetPoint()    
    local fScale=1
    if HealBot_Globals.Tooltip_SetScale then 
        fScale=HealBot_Globals.Tooltip_Scale
    end
	local fY=Healbot_Config_Skins.ToolTip[Healbot_Config_Skins.Current_Skin]["ANCHORY"] or 175
	local fX=Healbot_Config_Skins.ToolTip[Healbot_Config_Skins.Current_Skin]["ANCHORX"] or -275
    local fPoint=Healbot_Config_Skins.ToolTip[Healbot_Config_Skins.Current_Skin]["ANCHORPOINT"] or "BOTTOMRIGHT"
    local fWidth=hbCustomTipAnchor:GetWidth()
    local fHeight=hbCustomTipAnchor:GetHeight()
    if fPoint=="BOTTOMLEFT" then
        if fY>floor(GetScreenHeight()/fScale)-fHeight then
            fY=floor(GetScreenHeight()/fScale)-fHeight
        end
        if fX>floor(GetScreenWidth()/fScale)-fWidth then
            fX=floor(GetScreenWidth()/fScale)-fWidth
        end
    elseif fPoint=="BOTTOMRIGHT" then
        if fY>floor(GetScreenHeight()/fScale)-fHeight then
            fY=floor(GetScreenHeight()/fScale)-fHeight
        end
        if fX<0-floor(GetScreenWidth()/fScale)+fWidth then
            fX=0-floor(GetScreenWidth()/fScale)+fWidth
        end
    elseif fPoint=="TOPLEFT" then
        if fY<0-floor(GetScreenHeight()/fScale)+fHeight then
            fY=0-floor(GetScreenHeight()/fScale)+fHeight
        end
        if fX>floor(GetScreenWidth()/fScale)-fWidth then
            fX=floor(GetScreenWidth()/fScale)-fWidth
        end
    elseif fPoint=="TOPRIGHT" then
        if fY<0-floor(GetScreenHeight()/fScale)+fHeight then
            fY=0-floor(GetScreenHeight()/fScale)+fHeight
        end
        if fX<0-floor(GetScreenWidth()/fScale)+fWidth then
            fX=0-floor(GetScreenWidth()/fScale)+fWidth
        end
    end
	Healbot_Config_Skins.ToolTip[Healbot_Config_Skins.Current_Skin]["ANCHORY"] = ceil(fY)
	Healbot_Config_Skins.ToolTip[Healbot_Config_Skins.Current_Skin]["ANCHORX"] = ceil(fX)
    Healbot_Config_Skins.ToolTip[Healbot_Config_Skins.Current_Skin]["ANCHORPOINT"]=fPoint
	hbCustomTipAnchor:ClearAllPoints()
	hbCustomTipAnchor:SetPoint(fPoint,"WorldFrame",fPoint,fX,fY);
end

local function HealBot_Tooltip_CustomAnchor_OnMouseDown(self, button)
    if button=="LeftButton" and not hbCustomTipAnchor.isMoving then
        hbCustomTipAnchor:StartMoving();
        hbCustomTipAnchor.isMoving = true;
    end
end

local function HealBot_Tooltip_CustomAnchor_SetAnchorText()
    hbCustomTipAnchorText["AP1"]:SetText(HEALBOT_OPTIONS_TTCUSTOMANCHOR_POINT..": "..Healbot_Config_Skins.ToolTip[Healbot_Config_Skins.Current_Skin]["ANCHORPOINT"])
    hbCustomTipAnchorText["AX2"]:SetText(Healbot_Config_Skins.ToolTip[Healbot_Config_Skins.Current_Skin]["ANCHORX"])
    hbCustomTipAnchorText["AY2"]:SetText(Healbot_Config_Skins.ToolTip[Healbot_Config_Skins.Current_Skin]["ANCHORY"])
end

local function HealBot_Tooltip_CustomAnchor_SavePoints()
    local fX, fY=0, 0    
    local fScale=1
    if HealBot_Globals.Tooltip_SetScale then 
        fScale=HealBot_Globals.Tooltip_Scale
    end
    if Healbot_Config_Skins.ToolTip[Healbot_Config_Skins.Current_Skin]["ANCHORPOINT"]=="BOTTOMRIGHT" then
        fX=hbCustomTipAnchor:GetRight()-floor(GetScreenWidth()/fScale)
        fY=hbCustomTipAnchor:GetBottom()
        if fX>0 then fX=0 end
        if fY<0 then fY=0 end
    elseif Healbot_Config_Skins.ToolTip[Healbot_Config_Skins.Current_Skin]["ANCHORPOINT"]=="TOPRIGHT" then
        fX=hbCustomTipAnchor:GetRight()-floor(GetScreenWidth()/fScale)
        fY=hbCustomTipAnchor:GetTop()-floor(GetScreenHeight()/fScale)
        if fX>0 then fX=0 end
        if fY>0 then fY=0 end
    elseif Healbot_Config_Skins.ToolTip[Healbot_Config_Skins.Current_Skin]["ANCHORPOINT"]=="BOTTOMLEFT" then
        fX=hbCustomTipAnchor:GetLeft()
        fY=hbCustomTipAnchor:GetBottom()
        if fX<0 then fX=0 end
        if fY<0 then fY=0 end
    else
        fX=hbCustomTipAnchor:GetLeft()
        fY=hbCustomTipAnchor:GetTop()-floor(GetScreenHeight()/fScale)
        if fX<0 then fX=0 end
        if fY>0 then fY=0 end
    end
    Healbot_Config_Skins.ToolTip[Healbot_Config_Skins.Current_Skin]["ANCHORY"] = ceil(fY)
    Healbot_Config_Skins.ToolTip[Healbot_Config_Skins.Current_Skin]["ANCHORX"] = ceil(fX)
    HealBot_Tooltip_CustomAnchor_SetAnchorText()
    HealBot_Tooltip_CustomAnchor_SetPoint()
end

local function HealBot_Tooltip_CustomAnchor_OnMouseUp(self, button)
    if button=="LeftButton" and hbCustomTipAnchor.isMoving then
		hbCustomTipAnchor:StopMovingOrSizing();
		hbCustomTipAnchor.isMoving = false;
        HealBot_Tooltip_CustomAnchor_SavePoints()
    end
end

local function HealBot_Tooltip_CustomAnchor_SetText()
	hbCustomTipAnchorText["SKIN1"]:SetText(HEALBOT_OPTIONS_SKIN..": "..Healbot_Config_Skins.Current_Skin)
    HealBot_Tooltip_CustomAnchor_SetAnchorText()
end

local function HealBot_Tooltip_CustomAnchor_CreateText()
	hbCustomTipAnchorText["TITLE"]=hbCustomTipAnchor:CreateFontString("HealBot_Custom_Anchor_FrameTitleText", "OVERLAY", "GameFontNormal")
	hbCustomTipAnchorText["TITLE"]:SetPoint("TOP", hbCustomTipAnchor, "TOP", 0, -8)
	hbCustomTipAnchorText["TITLE"]:SetText(HEALBOT_OPTIONS_TTCUSTOMANCHOR_TITLE)
    hbCustomTipAnchorText["TITLE"]:SetTextColor(1,1,1,1)
	hbCustomTipAnchorText["SKIN1"]=hbCustomTipAnchor:CreateFontString("HealBot_Custom_Anchor_FrameSkinText1", "OVERLAY", "GameFontNormal")
	hbCustomTipAnchorText["SKIN1"]:SetPoint("TOP", hbCustomTipAnchor, "TOP", 0, -35)
    hbCustomTipAnchorText["SKIN1"]:SetTextColor(1,1,0.2,1)
    hbCustomTipAnchorText["AP1"]=hbCustomTipAnchor:CreateFontString("HealBot_Custom_Anchor_FrameAnchorPointText1", "OVERLAY", "GameFontNormal")
	hbCustomTipAnchorText["AP1"]:SetPoint("TOP", hbCustomTipAnchor, "TOP", 0, -58)
    hbCustomTipAnchorText["AP1"]:SetTextColor(0.2,1,0.2,1)
    hbCustomTipAnchorText["AX1"]=hbCustomTipAnchor:CreateFontString("HealBot_Custom_Anchor_FrameAnchorXText1", "OVERLAY", "GameFontNormal")
	hbCustomTipAnchorText["AX1"]:SetPoint("TOPRIGHT", hbCustomTipAnchor, "TOPRIGHT", -150, -73)
	hbCustomTipAnchorText["AX1"]:SetText("X:")
    hbCustomTipAnchorText["AX1"]:SetTextColor(0.2,1,0.2,1)
    hbCustomTipAnchorText["AX2"]=hbCustomTipAnchor:CreateFontString("HealBot_Custom_Anchor_FrameAnchorXText2", "OVERLAY", "GameFontNormal")
	hbCustomTipAnchorText["AX2"]:SetPoint("LEFT", hbCustomTipAnchorText["AX1"], "RIGHT", 4, 0)
    hbCustomTipAnchorText["AX2"]:SetTextColor(0.2,1,0.2,1)
    hbCustomTipAnchorText["AY1"]=hbCustomTipAnchor:CreateFontString("HealBot_Custom_Anchor_FrameAnchorYText1", "OVERLAY", "GameFontNormal")
	hbCustomTipAnchorText["AY1"]:SetPoint("LEFT", hbCustomTipAnchorText["AX2"], "RIGHT", 12, 0)
	hbCustomTipAnchorText["AY1"]:SetText("Y:")
    hbCustomTipAnchorText["AY1"]:SetTextColor(0.2,1,0.2,1)
    hbCustomTipAnchorText["AY2"]=hbCustomTipAnchor:CreateFontString("HealBot_Custom_Anchor_FrameAnchorYText2", "OVERLAY", "GameFontNormal")
	hbCustomTipAnchorText["AY2"]:SetPoint("LEFT", hbCustomTipAnchorText["AY1"], "RIGHT", 4, 0)
    hbCustomTipAnchorText["AY2"]:SetTextColor(0.2,1,0.2,1)
end

local function HealBot_Tooltip_CustomAnchor_SetAnchor(loc)
    Healbot_Config_Skins.ToolTip[Healbot_Config_Skins.Current_Skin]["ANCHORPOINT"]=loc
    hbCustomTipAnchorObjects["TOPLEFT"]:SetChecked(false)
    hbCustomTipAnchorObjects["TOPRIGHT"]:SetChecked(false)
    hbCustomTipAnchorObjects["BOTTOMLEFT"]:SetChecked(false)
    hbCustomTipAnchorObjects["BOTTOMRIGHT"]:SetChecked(false)
    hbCustomTipAnchorObjects[loc]:SetChecked(true)
    HealBot_Tooltip_CustomAnchor_SavePoints()
end

function HealBot_Tooltip_CustomAnchor_Hide()
    if hbCustomTipAnchor then 
        hbCustomTipAnchor:Hide()
    end
end

function HealBot_Tooltip_ResetCustomAnchor()
    if Healbot_Config_Skins.ToolTip[Healbot_Config_Skins.Current_Skin] then
        Healbot_Config_Skins.ToolTip[Healbot_Config_Skins.Current_Skin]["ANCHORY"]=175
        Healbot_Config_Skins.ToolTip[Healbot_Config_Skins.Current_Skin]["ANCHORX"]=-275
        Healbot_Config_Skins.ToolTip[Healbot_Config_Skins.Current_Skin]["ANCHORPOINT"]="BOTTOMRIGHT"
        if hbCustomTipAnchor then 
            HealBot_Tooltip_CustomAnchor_SetAnchor("BOTTOMRIGHT")
        end
    end
end

function HealBot_Tooltip_ShowCustomAnchor()
    if not hbCustomTipAnchor then
		hbCustomTipAnchor=CreateFrame("Frame", "HealBot_Custom_Anchor_Frame", UIParent, BackdropTemplateMixin and "BackdropTemplate")
		hbCustomTipAnchor:SetBackdrop({
			bgFile = "Interface\\Addons\\HealBot\\Images\\WhiteLine",
			edgeFile = "Interface\\Addons\\HealBot\\Images\\border",
			tile = true,
			tileSize = 8,
			edgeSize = 8,
			insets = { left = 3, right = 3, top = 3, bottom = 3, },
		})
		hbCustomTipAnchor:SetMovable(true)
		hbCustomTipAnchor:EnableMouse(true)
		hbCustomTipAnchor:SetScript("OnMouseDown", function(self, button) HealBot_Tooltip_CustomAnchor_OnMouseDown(self, button) end)
		hbCustomTipAnchor:SetScript("OnMouseUp", function(self, button) HealBot_Tooltip_CustomAnchor_OnMouseUp(self, button) end)

		hbCustomTipAnchor:SetWidth(220)
        hbCustomTipAnchor:SetHeight(120)	
        hbCustomTipAnchor:SetBackdropColor(0.2,0.2,0.2,0.8)
        hbCustomTipAnchor:SetBackdropBorderColor(0.4,0.4,0.4,0.9)
        
        hbCustomTipAnchorObjects["TOPLEFT"] = CreateFrame("CheckButton", "HealBot_Custom_Anchor_TOPLEFT", hbCustomTipAnchor, "SendMailRadioButtonTemplate")
		hbCustomTipAnchorObjects["TOPLEFT"]:SetPoint("TOPLEFT", 5, -5)
		hbCustomTipAnchorObjects["TOPLEFT"]:SetScript("OnClick", function() HealBot_Tooltip_CustomAnchor_SetAnchor("TOPLEFT"); end)
        hbCustomTipAnchorObjects["TOPRIGHT"] = CreateFrame("CheckButton", "HealBot_Custom_Anchor_TOPRIGHT", hbCustomTipAnchor, "SendMailRadioButtonTemplate")
		hbCustomTipAnchorObjects["TOPRIGHT"]:SetPoint("TOPRIGHT", -5, -5)
		hbCustomTipAnchorObjects["TOPRIGHT"]:SetScript("OnClick", function() HealBot_Tooltip_CustomAnchor_SetAnchor("TOPRIGHT"); end)
        hbCustomTipAnchorObjects["BOTTOMLEFT"] = CreateFrame("CheckButton", "HealBot_Custom_Anchor_BOTTOMLEFT", hbCustomTipAnchor, "SendMailRadioButtonTemplate")
		hbCustomTipAnchorObjects["BOTTOMLEFT"]:SetPoint("BOTTOMLEFT", 5, 5)
		hbCustomTipAnchorObjects["BOTTOMLEFT"]:SetScript("OnClick", function() HealBot_Tooltip_CustomAnchor_SetAnchor("BOTTOMLEFT"); end)
        hbCustomTipAnchorObjects["BOTTOMRIGHT"] = CreateFrame("CheckButton", "HealBot_Custom_Anchor_BOTTOMRIGHT", hbCustomTipAnchor, "SendMailRadioButtonTemplate")
		hbCustomTipAnchorObjects["BOTTOMRIGHT"]:SetPoint("BOTTOMRIGHT", -5, 5)
		hbCustomTipAnchorObjects["BOTTOMRIGHT"]:SetScript("OnClick", function() HealBot_Tooltip_CustomAnchor_SetAnchor("BOTTOMRIGHT"); end)
        
        hbCustomTipAnchorObjects["CloseBtn"] = CreateFrame("Button", "HealBot_Custom_Anchor_CloseBtn", hbCustomTipAnchor, "UIPanelButtonTemplate")
        hbCustomTipAnchorObjects["CloseBtn"]:SetPoint("BOTTOM", 0, 7)
        hbCustomTipAnchorObjects["CloseBtn"]:SetWidth(120)
        hbCustomTipAnchorObjects["CloseBtn"]:SetHeight(22)
        hbCustomTipAnchorObjects["CloseBtn"]:SetNormalFontObject("GameFontNormal")
        hbCustomTipAnchorObjects["CloseBtn"]:SetText(HEALBOT_OPTIONS_CLOSE)
        hbCustomTipAnchorObjects["CloseBtn"]:SetScript("OnMouseDown", function() HealBot_Tooltip_CustomAnchor_Hide(); end)
        
        HealBot_Tooltip_CustomAnchor_CreateText()
    end
    if HealBot_Globals.Tooltip_SetScale then 
        hbCustomTipAnchor:SetScale(HealBot_Globals.Tooltip_Scale)
    else
        hbCustomTipAnchor:SetScale(1)
    end
    hbCustomTipAnchorObjects["TOPLEFT"]:SetChecked(false)
    hbCustomTipAnchorObjects["TOPRIGHT"]:SetChecked(false)
    hbCustomTipAnchorObjects["BOTTOMLEFT"]:SetChecked(false)
    hbCustomTipAnchorObjects["BOTTOMRIGHT"]:SetChecked(false)
    if not Healbot_Config_Skins.ToolTip[Healbot_Config_Skins.Current_Skin] then
        Healbot_Config_Skins.ToolTip[Healbot_Config_Skins.Current_Skin]={}
        hbCustomTipAnchorObjects["BOTTOMRIGHT"]:SetChecked(true)
    else
        hbCustomTipAnchorObjects[Healbot_Config_Skins.ToolTip[Healbot_Config_Skins.Current_Skin]["ANCHORPOINT"]]:SetChecked(true)
    end
    HealBot_Tooltip_CustomAnchor_SetPoint()
    HealBot_Tooltip_CustomAnchor_SetText()
    hbCustomTipAnchor:Show()
end