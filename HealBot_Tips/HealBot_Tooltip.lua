local HealBot_CheckBuffs={}
local xUnit=nil
local xGUID=nil
local xButton=nil
local _
local powerCols={["r"]=1,["g"]=1,["b"]=1}
local playerPowerCols={["r"]=1,["g"]=1,["b"]=1}
local customDebuffPriority=hbv_GetStatic("cDebuff")
local hbCommands={ [strlower(HEALBOT_DISABLED_TARGET)]=true,
                   [strlower(HEALBOT_ASSIST)]=true,
                   [strlower(HEALBOT_WORD_FOCUS)]=true,
                   [strlower(HEALBOT_MENU)]=true,
                   [strlower(HEALBOT_HBMENU)]=true,
                   [strlower(HEALBOT_STOP)]=true,
                   [strlower(HEALBOT_IGNOREAURAALL)]=true,
                   [strlower(HEALBOT_CANCELPLUGINALERT)]=true,
                   [strlower(HEALBOT_MOUSELOOK)]=true,
                   [strlower(HEALBOT_TOGGLE_MYTARGETS)]=true,
                   [strlower(HEALBOT_TOGGLE_PRIVTANKS)]=true,
                   [strlower(HEALBOT_TOGGLE_PRIVHEALS)]=true,
                   [strlower(HEALBOT_TOGGLE_PRIVDPS)]=true,
                   [strlower(HEALBOT_TOGGLE_PERMPRIVLISTS)]=true,
                   [strlower(HEALBOT_TOGGLE_PERMPRIVTANKS)]=true,
                   [strlower(HEALBOT_TOGGLE_PERMPRIVHEALS)]=true,
                   [strlower(HEALBOT_TOGGLE_PERMPRIVDPS)]=true,
                  }
local hbPlayerCommands={}
if HEALBOT_GAME_VERSION>3 then
    hbPlayerCommands={ [strlower(HEALBOT_MOUNTSPETS)]=true,
                       [strlower(HEALBOT_FAVMOUNT)]=true,
                       [strlower(HEALBOT_RANDOMMOUNT)]=true,
                       [strlower(HEALBOT_RANDOMGOUNDMOUNT)]=true,
                       [strlower(HEALBOT_FAVPET)]=true,
                       [strlower(HEALBOT_TARGETVEHICLE)]=true,
                     }
elseif HEALBOT_GAME_VERSION>2 then
    hbPlayerCommands={ [strlower(HEALBOT_MOUNTS)]=true,
                       [strlower(HEALBOT_FAVMOUNT)]=true,
                       [strlower(HEALBOT_RANDOMMOUNT)]=true,
                       [strlower(HEALBOT_RANDOMGOUNDMOUNT)]=true,
                       [strlower(HEALBOT_TARGETVEHICLE)]=true,
                     }
end
local hbTip=HealBot_GameTooltip
HealBot_Data["TIPTYPE"]="Enabled" -- Initialize
local hbCustomTipAnchor=nil
local hbCustomTipAnchorText={}
local hbCustomTipAnchorObjects={}
local HealBot_Tooltip_luVars={}
HealBot_Tooltip_luVars["uGroup"]=false
HealBot_Tooltip_luVars["doInit"]=true
HealBot_Tooltip_luVars["debug"]=false

function HealBot_Tooltip_setLuVars(vName, vValue)
      --HealBot_setCall("HealBot_Tooltip_setLuVars - "..vName)
    HealBot_Tooltip_luVars[vName]=vValue
end

function HealBot_Tooltip_Clear_CheckBuffs()
      --HealBot_setCall("HealBot_Tooltip_Clear_CheckBuffs")
    for x,_ in pairs(HealBot_CheckBuffs) do
        HealBot_CheckBuffs[x]=nil;
    end
end

function HealBot_Tooltip_CheckBuffs(buff)
      --HealBot_setCall("HealBot_Tooltip_CheckBuffs")
    HealBot_CheckBuffs[buff]=true;
end

function HealBot_Tooltip_ReturnMinsSecs(s)
      --HealBot_setCall("HealBot_Tooltip_ReturnMinsSecs")
    local mins=floor(s/60)
    local secs=floor(s-(mins*60))
  --  mins=mins+1
    if secs<10 then secs="0"..secs end
    return mins,secs
end

function HealBot_Tooltip_GetHealSpell(button,sName)
      --HealBot_setCall("HealBot_Tooltip_GetHealSpell", button)
    if not HealBot_Spells_KnownByName(sName) then
        if sName then
            if not HealBot_IsKnownItem(sName) then
                return nil, 1, 0.2, 0, false, false
            else
                if not button.player then
                    if HealBot_WoWAPI_UsableItem(sName) and HealBot_Range_Unit(button.unit, button.guid) then
                        return sName, 0.2, 0.5, 1, true, true
                    else
                        return sName, 0.1, 0.25, 0.7, true, false
                    end
                else
                    return sName, 0.2, 0.5, 1, true, true
                end
            end
        else
            return nil, 1, 0.2, 0
        end
    end

    if not HealBot_Range_SpellInRange(button,sName) then
        return sName, 1, 0.2, 0, false, false
    end

    return sName, 1, 1, 1, false, true
end

function HealBot_Tooltip_GCDV1()
      --HealBot_setCall("HealBot_Tooltip_GCDV1")
    return 1.5
end

local gcdDUR=0
function HealBot_Tooltip_GCDV4()
      --HealBot_setCall("HealBot_Tooltip_GCDV4")
    _, gcdDUR=HealBot_WoWAPI_SpellCooldown(61304) -- GCD
    return gcdDUR
end

local HealBot_Tooltip_GCD=HealBot_Tooltip_GCDV1
if HEALBOT_GAME_VERSION>3 then
    HealBot_Tooltip_GCD=HealBot_Tooltip_GCDV4
end
function HealBot_Tooltip_getSpellCD(validSpellName, isMacro)
      --HealBot_setCall("HealBot_Tooltip_getSpellCD")
    local z, x=HealBot_WoWAPI_SpellCooldown(validSpellName);
    local gcd=0
    if HealBot_Globals.Tooltip_IgnoreGCD then
        gcd=HealBot_Tooltip_GCD()
    end
    if HealBot_Globals.Tooltip_ShowCD and x and x>gcd then
        z=HealBot_Util_Round(x-(GetTime()-z),0)
        local u=HEALBOT_TOOLTIP_SECS
        if z>59 then
            z=ceil(z/60)
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
      --HealBot_setCall("HealBot_Tooltip_setspellName", button)
    if spellName and string.len(spellName)>0 then
        local validSpellName=spellName
        local spellType=HEALBOT_OPTIONS_SPELL
        local spellAR,spellAG,spellAB=1,1,1
        if hbCommands[strlower(spellName)] or (button.player and hbPlayerCommands[strlower(spellName)]) then
            spellAR,spellAG,spellAB=1,1,0
            spellType=HEALBOT_WORD_COMMAND
        else
            local e,t=string.split("=", spellName)
            if e and e == HEALBOT_EMOTE and t then
                if button.status.range<1 then
                    spellAR,spellAG,spellAB=0.7,0.3,0
                else
                    spellAR,spellAG,spellAB=1,0.58,0
                end
                validSpellName=t
                spellType=HEALBOT_EMOTE
            else
                local mIdx=GetMacroIndexByName(spellName)
                if mIdx == 0 then
                    validSpellName, spellAR, spellAG, spellAB, isItem, inRange=HealBot_Tooltip_GetHealSpell(button,spellName)
                    if validSpellName and not isItem then
                        if inRange then
                            validSpellName,spellAR,spellAG,spellAB=HealBot_Tooltip_getSpellCD(validSpellName, false)
                        end
                    else
                        spellType=HEALBOT_OPTIONS_ITEM
                    end
                else
                    if validSpellName and GetMacroIndexByName(validSpellName)>0 then
                        local _,_,mText=GetMacroInfo(GetMacroIndexByName(validSpellName))
                        local _,s=string.find(mText, "#showtooltip ")
                        if s and s>0 then
                            local e,_=string.find(mText, "\n")
                            if e and e>0 then
                                 local mSpellName=strtrim((string.sub(mText, s+1, e-1)) or "")
                                 if string.len(mSpellName)>0 then
                                    validSpellName=mSpellName
                                end
                            end
                        end
                    end
                    validSpellName,spellAR,spellAG,spellAB=HealBot_Tooltip_getSpellCD(validSpellName, true)
                    spellType=HEALBOT_MACRO
                end
            end
        end
        return validSpellName, spellAR, spellAG, spellAB, spellType
    else
        return nil
    end
end

local function HealBot_Tooltip_SetFont(line,font,size)
      --HealBot_setCall("HealBot_Tooltip_SetFont")
    HealBot_Tooltip_SetLine(" ",1,1,1,0," ",1,1,1,0)
    local l=_G["HealBot_GameTooltipTextLeft"..line]
    local r=_G["HealBot_GameTooltipTextRight"..line]
    HealBot_Media_UpdateFont(l, font, size, 1, "Tooltip_SetFont")
    HealBot_Media_UpdateFont(r, font, size, 1, "Tooltip_SetFont")
end

function HealBot_Tooltip_SetScale()
      --HealBot_setCall("HealBot_Tooltip_SetScale")
    hbTip:SetScale(HealBot_Globals.Tooltip_Scale)
end

local hbUnitRanks={}
local hbUnitRoles={}
function HealBot_Tooltip_Init()
      --HealBot_setCall("HealBot_Tooltip_Init")
    if HealBot_Globals.Tooltip_UseGameTooltip then
        hbTip=GameTooltip
    else
        hbTip=HealBot_GameTooltip
        HealBot_Tooltip_SetFont(1,HealBot_Globals.Tooltip_HeaderFont,HealBot_Globals.Tooltip_HeaderFontSize)
        for x=2,50 do
            HealBot_Tooltip_SetFont(x,HealBot_Globals.Tooltip_DetailFont,HealBot_Globals.Tooltip_DetailFontSize)
        end
        HealBot_Tooltip_SetScale()
    end
    HealBot_Tooltip_luVars["doInit"]=false
    hbUnitRanks={[0]="",
                    [1]=HEALBOT_WORD_RAIDASSISTANT.." ",
                    [2]=HEALBOT_WORD_RAIDLEADER.." ",
                    [3]=HEALBOT_WORD_MASTERLOOTER.." ",
                    [4]=HEALBOT_WORD_GROUPLEADER.." ",
                   }
    hbUnitRoles={[0]=" ",
                    [1]=HEALBOT_WORD_MAINTANK.." ",
                    [2]=HEALBOT_WORD_TANK.." ",
                    [3]=HEALBOT_WORD_HEALER.." ",
                    [4]=HEALBOT_WORD_PRIVATETANK.." ",
                    [5]=HEALBOT_WORD_PRIVATEHEALER.." ",
                    [6]=HEALBOT_WORD_DAMAGER.." ",
                    [7]=HEALBOT_WORD_RAIDER.." ",
                   }
    if HealBot_Globals.DebugOut and not HealBot_Tooltip_luVars["TipsFirstLoad"] then
        HealBot_Tooltip_luVars["debug"]=true
        HealBot_Tooltip_luVars["TipsFirstLoad"]=true
    end
end

local tipsRequests={}
function HealBot_Tooltip_Requests(guid, buff, text, r, g, b)
      --HealBot_setCall("HealBot_Tooltip_Requests", nil, guid)
    if buff then
        tipsRequests[guid]="      Requested "..buff.." ("..text..")"
        tipsRequests.r=r
        tipsRequests.g=g
        tipsRequests.b=b
    else
        tipsRequests[guid]=nil
    end
    if HealBot_Data["TIPBUTTON"] and hbTip:IsVisible() then HealBot_Action_RefreshTooltip() end
end

function HealBot_Tooltip_RequestsClear()
      --HealBot_setCall("HealBot_Tooltip_RequestsClear")
    tipsRequests={}
end

local tipsAuraWatch={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={}}
function HealBot_Tooltip_AuraWatch(guid, index, buff, r, g, b)
      --HealBot_setCall("HealBot_Tooltip_AuraWatch", nil, guid)
    if buff then
        tipsAuraWatch[index][guid]="      Ready for "..buff
        tipsAuraWatch[index].r=r
        tipsAuraWatch[index].g=g
        tipsAuraWatch[index].b=b
    else
        tipsAuraWatch[index][guid]=nil
    end
    if HealBot_Data["TIPBUTTON"] and hbTip:IsVisible() then HealBot_Action_RefreshTooltip() end
end

function HealBot_Tooltip_AuraWatchClear()
      --HealBot_setCall("HealBot_Tooltip_AuraWatchClear")
    tipsAuraWatch={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={}}
end

local tipsHealthWatch={}
function HealBot_Tooltip_HealthWatch(guid, buff, r, g, b)
      --HealBot_setCall("HealBot_Tooltip_HealthWatch", nil, guid)
    if buff then
        tipsHealthWatch[guid]="      Health Low"
        tipsHealthWatch.r=r
        tipsHealthWatch.g=g
        tipsHealthWatch.b=b
    else
        tipsHealthWatch[guid]=nil
    end
    if HealBot_Data["TIPBUTTON"] and hbTip:IsVisible() then HealBot_Action_RefreshTooltip() end
end

function HealBot_Tooltip_HealthWatchClear()
      --HealBot_setCall("HealBot_Tooltip_HealthWatchClear")
    tipsHealthWatch={}
end

local tipsManaWatch={}
function HealBot_Tooltip_ManaWatch(guid, buff, r, g, b)
      --HealBot_setCall("HealBot_Tooltip_ManaWatch", nil, guid)
    if buff then
        tipsManaWatch[guid]="      Mana Low"
        tipsManaWatch.r=r
        tipsManaWatch.g=g
        tipsManaWatch.b=b
    else
        tipsManaWatch[guid]=nil
    end
    if HealBot_Data["TIPBUTTON"] and hbTip:IsVisible() then HealBot_Action_RefreshTooltip() end
end

function HealBot_Tooltip_ManaWatchClear()
      --HealBot_setCall("HealBot_Tooltip_ManaWatchClear")
    tipsManaWatch={}
end

function HealBot_Tooltip_SetLine(lText,lR,lG,lB,la,rText,rR,rG,rB,ra)
      --HealBot_setCall("HealBot_Tooltip_SetLine")
    if rText then
        hbTip:AddDoubleLine(lText,rText,lR,lG,lB,rR,rG,rB)
    else
        hbTip:AddLine(lText,lR,lG,lB)
    end
end

function HealBot_Tooltip_SetWrappedLine(lText,lR,lG,lB,la)
    hbTip:AddLine(lText,lR,lG,lB,true)
end

local HealBot_Tooltip_Power=9
local HealBot_Tooltip_PowerDesc={[0]="Mana",
                                 [1]="Rage",
                                 [2]="Focus",
                                 [3]="Energy",
                                 [4]="Happiness",
                                 [5]="Runes",
                                 [6]="Runic Power",
                                 [7]="Soul Shards",
                                 [8]="Eclipse",
                                 [9]="Holy Power"}

function HealBot_Tooltip_SpellSummary(spellName, spellType)
      --HealBot_setCall("HealBot_Tooltip_SpellSummary")
    local ret_val="  "
    if HealBot_Spell_Names[spellName] then
        if HealBot_Data["POWERTYPE"] == 0 and HealBot_Spell_IDs[HealBot_Spell_Names[spellName]].Mana<HealBot_Tooltip_Power then
            ret_val=" -  "..HealBot_Spell_IDs[HealBot_Spell_Names[spellName]].Mana.." Power"
        else
            ret_val=" -  "..HealBot_Spell_IDs[HealBot_Spell_Names[spellName]].Mana.." "..HealBot_Tooltip_PowerDesc[HealBot_Data["POWERTYPE"]]
        end
    else
        ret_val=" - "..spellType
    end
    return ret_val;
end

local UnitBuffIcons=nil
local UnitDebuffIcons=nil
local ttCaster,ttHoTd,ttHoTc,ttHoTright,ttName=nil,nil,nil,nil,HEALBOT_WORDS_UNKNOWN
local hbHoTline1,ttHoTdt=true,0
function HealBot_ToolTip_ShowHoT(button)
      --HealBot_setCall("HealBot_ToolTip_ShowHoT", button)
    if HealBot_Globals.Tooltip_ShowHoT then
        hbHoTline1=true
        UnitBuffIcons=HealBot_Aura_ReturnHoTdetails(button.id)
        if UnitBuffIcons then
            for i=1,12 do
                if UnitBuffIcons[i].current and UnitBuffIcons[i].unitCaster and UnitBuffIcons[i].spellId>0 then
                    ttCaster=UnitName(UnitBuffIcons[i].unitCaster)
                    ttName=HealBot_Aura_ReturnHoTdetailsname(UnitBuffIcons[i].spellId)
                    if ttCaster and ttName then
                        ttHoTd=nil
                        if hbHoTline1 then
                            hbHoTline1=false
                            HealBot_Tooltip_SetLine(" ",0,0,0,0)
                        end
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
                            HealBot_Tooltip_SetLine("   "..ttCaster.." "..strlower(HEALBOT_WORDS_CAST).." "..ttName.." ",0.4,1,1,1,ttHoTright,0.7,1,0.7,1)
                        else
                            HealBot_Tooltip_SetLine("   "..ttCaster.." "..strlower(HEALBOT_WORDS_CAST).." "..ttName.." ",0.4,1,1,1)
                        end
                    end
                end
            end
        end
    end
end

local hbTipDebugText={}
local hbStates={[0]="Disabled",
                [2]="Check",
                [3]="Enabled OOR",
                [4]="Enabled IR",
                [5]="Buff No Col",
                [6]="Buff Bar Col",
                [7]="Debuff No Col",
                [8]="Debuff Bar Col",
               [15]="Plugin Bar Col",
               [18]="Dead",
               [19]="Res",
               [50]="DC",
               [99]="Reserved",
               }
function HealBot_ToolTip_ShowDebug(button)
      --HealBot_setCall("HealBot_ToolTip_ShowDebug", button)
    HealBot_Tooltip_SetLine("  ",0,0,0,0)
    HealBot_Tooltip_SetLine("Debug On - Turn off in Tip with /hb debugtip",1,1,1,1)
    hbTipDebugText["player"]="False"
    hbTipDebugText["isPlayer"]="False"
    hbTipDebugText["isSpecial"]="False"
    hbTipDebugText["isGroupRaid"]="False"
    hbTipDebugText["debugtrack"]="False"
    hbTipDebugText["range40"]=-99
    hbTipDebugText["status"]="Unknown"
    hbTipDebugText["debugtime"]="Unset"
    hbTipDebugText["duplicate"]="False"
    if button then
        hbTipDebugText["playerTarget"]=HealBot_Panel_isSpecialPlayerUnit(button.unit)
        if hbTipDebugText["playerTarget"]<0 then hbTipDebugText["playerTarget"]="No" end
        if button.status.duplicate then hbTipDebugText["duplicate"]="True" end
        HealBot_Tooltip_SetLine("Button ID: "..button.id,0.4,1,1,1,"Unit ID: "..button.unit)
        HealBot_Tooltip_SetLine("Player target: "..hbTipDebugText["playerTarget"],0.4,1,1,1,"Duplicate: "..hbTipDebugText["duplicate"])
        HealBot_Tooltip_SetLine("Button Name: "..button.bName,0.4,1,1,1,"Frame: "..button.frame)
        HealBot_Tooltip_SetLine("Height: "..button.height,0.4,1,1,1,"Width: "..button.width)
        if UnitExists(button.unit) then
            if UnitIsFriend("player",button.unit) then
                HealBot_Tooltip_SetLine("UnitExists is True",0.4,1,1,1,"UnitIsFriend is True")
            else
                HealBot_Tooltip_SetLine("UnitExists is True",0.4,1,1,1,"UnitIsFriend is False")
            end
        else
            HealBot_Tooltip_SetLine("UnitExists is False",0.4,1,1,1)
        end
        hbTipDebugText["range40"]=button.status.range
        hbTipDebugText["status"]=hbStates[button.status.current] or ("Unknown ("..button.status.current..")")
        if button.player then hbTipDebugText["player"]="True" end
        if button.isplayer then hbTipDebugText["isPlayer"]="True" end
        if button.special.unit then hbTipDebugText["isSpecial"]="True" end
        if button.isgroupraid then hbTipDebugText["isGroupRaid"]="True" end
        if button.debug.track then
            hbTipDebugText["debugtrack"]="True"
            hbTipDebugText["debugtime"]=button.debug.updtime or "Unset"
        end
    else
        HealBot_Tooltip_SetLine("No button found for unit",1,0.25,0.25,1)
    end
    HealBot_Tooltip_SetLine("Button Player is "..hbTipDebugText["player"],0.4,1,1,1,"Button isPlayer is "..hbTipDebugText["isPlayer"])
    HealBot_Tooltip_SetLine("Button special unit is "..hbTipDebugText["isSpecial"],0.4,1,1,1,"Button isGroupRaid is "..hbTipDebugText["isGroupRaid"])
    HealBot_Tooltip_SetLine("Debug track is "..hbTipDebugText["debugtrack"],0.4,1,1,1,"Debug time is "..hbTipDebugText["debugtime"])
    HealBot_Tooltip_SetLine("Range state is "..hbTipDebugText["range40"],0.4,1,1,1,"Current status="..hbTipDebugText["status"])
    if button then
        HealBot_Tooltip_SetLine("unitType is "..button.status.unittype,0.4,1,1,1,"Column is "..(button.Column or "nil"))
        local GlobalDimmingFrame, GlobalDimmingFrameID=HealBot_Action_DebugFrameActive(button.frame)
        if GlobalDimmingFrame then
            GlobalDimmingFrame="true"
        else
            GlobalDimmingFrame="false"
        end
        HealBot_Tooltip_SetLine("GlobalDimmingFrame is "..GlobalDimmingFrame,0.4,1,1,1,"GlobalDimmingFrame ID is "..GlobalDimmingFrameID)
        HealBot_Tooltip_SetLine("Button Text Name is "..(button.text.name or "nil"),0.4,1,1,1,"Button Text Nameonly is "..(button.text.nameonly or "nil"))
    end
end

function HealBot_ToolTip_ToggleDebug()
      --HealBot_setCall("HealBot_ToolTip_ToggleDebug")
    if HealBot_Tooltip_luVars["debug"] then
        HealBot_Tooltip_luVars["debug"]=false
    else
        HealBot_Tooltip_luVars["debug"]=true
    end
end

local hbtPosFrm, hbtPosTop, hbtPosX, hbtPosY="",0,0,0
function HealBot_ToolTip_SetTooltipPos(frame)
      --HealBot_setCall("HealBot_ToolTip_SetTooltipPos")
    hbtPosFrm=_G["f"..frame.."_HealBot_Action"]
    hbtPosTop=hbtPosFrm:GetTop();
    hbtPosX, hbtPosY=GetCursorPosition();
    if hbv_Skins_GetFrameVar("Frame", "TIPLOC", frame)>1 then
        if hbv_Skins_GetFrameVar("Frame", "TIPLOC", frame) == 2 then
            hbtPosY=hbtPosY/UIParent:GetScale();
            hbTip:SetOwner(hbtPosFrm, "ANCHOR_LEFT", 0, 0-(hbtPosTop-(hbtPosY-50)))
        elseif hbv_Skins_GetFrameVar("Frame", "TIPLOC", frame) == 3 then
            hbtPosY=hbtPosY/UIParent:GetScale();
            hbTip:SetOwner(hbtPosFrm, "ANCHOR_RIGHT", 0, 0-(hbtPosTop-(hbtPosY-50)))
        elseif hbv_Skins_GetFrameVar("Frame", "TIPLOC", frame) == 4 then
           hbTip:SetOwner(hbtPosFrm, "ANCHOR_TOP")
        elseif hbv_Skins_GetFrameVar("Frame", "TIPLOC", frame) == 5 then
           hbTip:SetOwner(hbtPosFrm, "ANCHOR_BOTTOM")
        elseif hbv_Skins_GetFrameVar("Frame", "TIPLOC", frame) == 6 then
            hbtPosX=hbtPosX/UIParent:GetScale();
            hbtPosY=hbtPosY/UIParent:GetScale();
            hbTip:SetOwner(hbtPosFrm, "ANCHOR_NONE")
            hbTip:SetPoint("TOPLEFT","WorldFrame","BOTTOMLEFT",hbtPosX+25,hbtPosY-20);
        else
            hbTip:SetOwner(hbtPosFrm, "ANCHOR_NONE")
            hbTip:SetPoint(HealBot_Tooltip_GetVar("ANCHORPOINT"), "UIParent", HealBot_Tooltip_GetVar("ANCHORPOINT"), HealBot_Tooltip_GetVar("ANCHORX"), HealBot_Tooltip_GetVar("ANCHORY"))
        end
    else
        hbTip:SetOwner(hbtPosFrm, "ANCHOR_NONE")
        hbTip:SetPoint("BOTTOMRIGHT", "UIParent", "BOTTOMRIGHT", -CONTAINER_OFFSET_X - 13, CONTAINER_OFFSET_Y)
    end
end

function HealBot_Action_GetTimeOffline(button)
      --HealBot_setCall("HealBot_Action_GetTimeOffline", button)
    local timeOffline=nil
    local offlineStart=HealBot_Action_getGuidData(button.guid, "OFFLINE")
    if offlineStart then
        timeOffline=HealBot_TimeNow - offlineStart;
        local seconds=math.floor(timeOffline % 60)
        local minutes=math.floor(timeOffline / 60) % 60
        local hours=math.floor(timeOffline / 3600)
        timeOffline="";
        if hours > 0 then
            if hours == 1 then
                timeOffline=hours.." hour ";
            else
                timeOffline=hours.." hours ";
            end
        end
        if minutes > 0 then
            if minutes == 1 then
                timeOffline=timeOffline..minutes.." min ";
            else
                timeOffline=timeOffline..minutes.." mins ";
            end
        end
        if seconds > 0 then
            if seconds == 1 then
                timeOffline=timeOffline..seconds.." sec";
            else
                timeOffline=timeOffline..seconds.." secs";
            end
        end
    end
    return timeOffline;
end

local function HealBot_Tooltip_addPlayerDebuffLine(uName, debuffId, debuffName)
      --HealBot_setCall("HealBot_Tooltip_addPlayerDebuffLine")
    if not HealBot_Tooltip_luVars["CrDebuffLine"] then
        HealBot_Tooltip_luVars["CrDebuffLine"]=true
        HealBot_Tooltip_SetLine("  ",0,0,0,0)
    end
    if HealBot_Globals.CDCBarColour[debuffId] then
        HealBot_Tooltip_SetLine(uName.." suffers from "..debuffName,
                                    (HealBot_Globals.CDCBarColour[debuffId].R or 0.4)+0.2,
                                    (HealBot_Globals.CDCBarColour[debuffId].G or 0.05)+0.2,
                                    (HealBot_Globals.CDCBarColour[debuffId].B or 0.2)+0.2,
                                    1," ",0,0,0,0)
    elseif HealBot_Globals.CDCBarColour[debuffName] then
        HealBot_Tooltip_SetLine(uName.." suffers from "..debuffName,
                                    (HealBot_Globals.CDCBarColour[debuffName].R or 0.4)+0.2,
                                    (HealBot_Globals.CDCBarColour[debuffName].G or 0.05)+0.2,
                                    (HealBot_Globals.CDCBarColour[debuffName].B or 0.2)+0.2,
                                    1," ",0,0,0,0)
    else
        local DebuffType=HealBot_Aura_retDebufftype(debuffId)
        if HealBot_Config_Cures.CDCBarColour[DebuffType] then
            HealBot_Tooltip_SetLine(uName.." suffers from "..debuffName,
                                        (HealBot_Config_Cures.CDCBarColour[DebuffType].R or 0.5)+0.2,
                                        (HealBot_Config_Cures.CDCBarColour[DebuffType].G or 0.2)+0.2,
                                        (HealBot_Config_Cures.CDCBarColour[DebuffType].B or 0.4)+0.2,
                                        1," ",0,0,0,0)
        else
            HealBot_Tooltip_SetLine(uName.." suffers from "..debuffName,
                                        (HealBot_Globals.CDCBarColour[customDebuffPriority].R or 0.5)+0.2,
                                        (HealBot_Globals.CDCBarColour[customDebuffPriority].G or 0.2)+0.2,
                                        (HealBot_Globals.CDCBarColour[customDebuffPriority].B or 0.4)+0.2,
                                        1," ",0,0,0,0)
        end
    end
end

function HealBot_Tooltip_setPlayerPowerCols(r,g,b)
      --HealBot_setCall("HealBot_Tooltip_setPlayerPowerCols")
    playerPowerCols.r,playerPowerCols.g,playerPowerCols.b=r+0.34,g+0.34,b+0.34
end

function HealBot_Action_setSpellInfo(button)
    if HealBot_Action_ValidComboTypes(HealBot_Data["TIPTYPE"]) then
        local bId, bName, sName, sType, sDisplayName, bR, bG, bB
        for x=1,HealBot_Globals.Tooltip_MaxButtons do
            bId, bName=HealBot_Options_ComboClass_Button(x)
            sName=HealBot_Action_SpellPattern(bId, string.upper(HealBot_Data["TIPTYPE"]))
            if x == 1 and HealBot_Globals.SmartCast and button.status.current<HealBot_Unit_Status["DC"] and not IsModifierKeyDown() and UnitIsFriend("player",button.unit) and not HealBot_Data["UILOCK"] then
                sName=HealBot_Action_SmartCast(button) or sName
            end
            sDisplayName, bR, bG, bB, sType=HealBot_Tooltip_setspellName(button, sName)
            if sDisplayName then
                if HealBot_Globals.Tooltip_ShowSpellExtra then
                    HealBot_Tooltip_SetLine(bName..": "..sDisplayName, bR, bG, bB,1,HealBot_Tooltip_SpellSummary(sName, sType),playerPowerCols.r,playerPowerCols.g,playerPowerCols.b,1)
                else
                    HealBot_Tooltip_SetLine(bName..": "..sDisplayName, bR, bG, bB,1)
                end
            end
        end
    end
end

function HealBot_Action_DoRefreshTooltip()
    if HealBot_Globals.ShowTooltip == false then return end
    if HealBot_Globals.DisableToolTipInCombat and HealBot_Data["UILOCK"] then return end
    if not HealBot_Globals.Tooltip_ShowTarget and not HealBot_Globals.Tooltip_ShowSpellInfo then return end
    xButton=HealBot_Data["TIPBUTTON"]

      --HealBot_setCall("HealBot_Action_DoRefreshTooltip", xButton)
    if not xButton then
        return
    else
        HealBot_Tooltip_luVars["button"]=xButton
    end
    xUnit=xButton.unit
    xGUID=UnitGUID(xUnit)
    local uName=""
    if HealBot_Globals.Tooltip_ShowTitle then
        uName=UnitPVPName(xButton.unit) or xButton.text.nameonly or UnitName(xUnit)
    else
        uName=xButton.text.nameonly or UnitName(xUnit)
    end
    if HealBot_Tooltip_luVars["doInit"] then
        HealBot_Tooltip_Init()
    end
    HealBot_ToolTip_SetTooltipPos(xButton.frame);
    if xGUID and uName and UnitExists(xUnit) then
        if HealBot_Data["TIPTYPE"] == "WoWUnit" then
            hbTip:SetUnit(xUnit)
        else
            local hlth=xButton.health.current
            local maxhlth=xButton.health.max
            local mana=xButton.mana.current
            local maxmana=xButton.mana.max
            powerCols.r,powerCols.g,powerCols.b=xButton.mana.r+0.34,xButton.mana.g+0.34,xButton.mana.b+0.34

            if hlth>maxhlth then hlth=maxhlth end

            local UnitOffline=HealBot_Action_GetTimeOffline(xButton); --added by Diacono
            local UnitTag=xButton.text.tag
            if UnitOffline then UnitTag="" end
            local DebuffType=xButton.aura.debuff.type;

            hbTip:ClearLines()

            if HealBot_Globals.Tooltip_ShowTarget then
                if uName then
                    local r,g,b=xButton.text.r,xButton.text.g,xButton.text.b
                    local uLvl=xButton.level
                    if HealBot_Globals.Tooltip_ShowLevel then
                        if uLvl<1 then
                            uLvl=nil
                        else
                            uLvl="Level "..uLvl
                        end
                        if HealBot_UnitClassification(xUnit) then
                            if uLvl then
                                uLvl=HealBot_UnitClassification(xUnit).." "..uLvl
                            else
                                uLvl="Boss"
                            end
                        elseif not uLvl then
                            uLvl=""
                        end
                    else
                        uLvl=""
                    end
                    local uClass=UnitCreatureFamily(xUnit) or UnitClass(xUnit) or UnitCreatureType(xUnit)
                    if uClass == uName then uClass=UnitCreatureType(xUnit) or "" end
                    if not uClass or uClass == "" then
                        if strfind(xUnit,"pet") then
                            uClass=HEALBOT_WORD_PET
                        else
                            uClass=HEALBOT_WORDS_UNKNOWN
                        end
                    end
                    local uSpec=" "
                    if HealBot_Globals.Tooltip_ShowSpec then
                        if HealBot_Panel_RaidUnitButtonCheck(xButton.guid) then
                            uSpec=HealBot_Action_getGuidData(xButton.guid, "SPEC")
                        else
                            uSpec=xButton.spec
                        end
                        if uSpec == " " and xButton.isplayer then
                            HealBot_SpecUpdate(xButton, HealBot_TimeNow)
                        end
                    else
                        uSpec=" "
                    end
                    HealBot_Tooltip_luVars["uGroup"]=0
                    if IsInRaid() then
                        HealBot_Tooltip_luVars["uGroup"]=xButton.group
                    end
                    local uGuild=""
                    if HealBot_Globals.Tooltip_ShowGuild and xButton.guild then
                        uGuild="<"..xButton.guild..">"
                        if HealBot_Globals.Tooltip_ShowGuildTitle then
                            uGuild=uGuild.." "..xButton.guildtitle
                        end
                        if HealBot_Globals.Tooltip_ShowGuildRank then
                            uGuild=uGuild.." ("..xButton.guildrank..")"
                        end
                    end
                    if HealBot_Globals.Tooltip_ShowRank or HealBot_Globals.Tooltip_ShowRole then
                        local uRankIdx=xButton.rank
                        local uRoleIdx=xButton.role
                        if not HealBot_Globals.Tooltip_ShowRank then uRankIdx=0 end
                        if not HealBot_Globals.Tooltip_ShowRole then uRoleIdx=0 end
                        local uRace=" "..(UnitRace(xButton.unit) or "")
                        local uRank=hbUnitRanks[uRankIdx]
                        if uRankIdx>0 then
                            if HealBot_Globals.Tooltip_HideRoleWhenRank then
                                uRoleIdx=0
                            end
                        else
                            if HealBot_Panel_RaidUnitButtonCheck(xButton.guid) then
                                if uRoleIdx == 0 then
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
                        if mana and maxmana>0 and not UnitOffline and HealBot_Tooltip_luVars["uGroup"]>0 and string.len(UnitTag)>0 then
                            HealBot_Tooltip_SetLine(uName.." - "..UnitTag,r,g,b,1,uSpec..uClass,r,g,b,1)
                        elseif string.len(uGuild)>0 then
                            HealBot_Tooltip_SetLine(uName.." - "..uGuild,r,g,b,1,uSpec..uClass,r,g,b,1)
                        else
                            HealBot_Tooltip_SetLine(uName,r,g,b,1,uSpec..uClass,r,g,b,1)
                        end
                        local uRole=hbUnitRoles[uRoleIdx] or ""
                        if uRank == HEALBOT_CUSTOM_CASTBY_ENEMY then
                            HealBot_Tooltip_SetLine(uRank..uRole,1,0.25,0.25,1,uLvl..uRace,1,0.25,0.25,1)
                        else
                            HealBot_Tooltip_SetLine(uRank..uRole,r,g,b,1,uLvl..uRace,r,g,b,1)
                        end
                    elseif string.len(uGuild)>0 then
                        local uRace=" "..(UnitRace(xButton.unit) or "")
                        if mana and maxmana>0 and not UnitOffline and HealBot_Tooltip_luVars["uGroup"]>0 and string.len(UnitTag)>0 then
                            HealBot_Tooltip_SetLine(uName.." - "..UnitTag,r,g,b,1,uSpec..uClass,r,g,b,1)
                        else
                            HealBot_Tooltip_SetLine(uName,r,g,b,1,uSpec..uClass,r,g,b,1)
                        end
                        HealBot_Tooltip_SetLine(uGuild,r,g,b,1,uLvl..uRace,r,g,b,1)
                    else
                        if mana and maxmana>0 and not UnitOffline and HealBot_Tooltip_luVars["uGroup"]>0 and string.len(UnitTag)>0 then
                            HealBot_Tooltip_SetLine(uName.." - "..UnitTag,r,g,b,1,uLvl..uSpec..uClass,r,g,b,1)
                        else
                            HealBot_Tooltip_SetLine(uName,r,g,b,1,uLvl..uSpec..uClass,r,g,b,1)
                        end
                    end

                    local zone=HealBot_UnitZone(xButton)

                    if UnitOffline then
                        HealBot_Tooltip_SetLine(HB_TOOLTIP_OFFLINE,1,0.5,0,1,UnitOffline,1,1,1,1)
                    else
                        if HealBot_Globals.Tooltip_ShowHealth and hlth and maxhlth then
                            local hPct=100
                            if maxhlth>0 then
                                hPct=floor((hlth/maxhlth)*100)
                            end
                            hlth=HealBot_Text_readNumber(hlth)
                            maxhlth=HealBot_Text_readNumber(maxhlth)
                            local vUnit=HealBot_retIsInVehicle(xUnit)
                            local pZone=" "
                            if zone and not strfind(zone,"Level") then
                                pZone=zone
                            end
                            if vUnit and UnitExists(vUnit) then
                                local lr,lg,lb=HealBot_Action_ClassColour(xButton.unit, xButton.text.classtrim)
                                HealBot_Tooltip_SetLine(UnitName(vUnit),lr,lg,lb,1,hlth.."/"..maxhlth.." ("..hPct.."%)",xButton.health.rcol,xButton.health.gcol,0,1)
                                hlth,maxhlth=UnitHealth(xButton.unit),UnitHealthMax(xButton.unit)
                                hPct=floor((hlth/maxhlth)*100)
                                hlth=HealBot_Text_readNumber(hlth)
                                maxhlth=HealBot_Text_readNumber(maxhlth)
                                pZone="  "..uName
                            end
                            HealBot_Tooltip_SetLine(pZone,1,1,1,1,hlth.."/"..maxhlth.." ("..hPct.."%)",xButton.health.rcol,xButton.health.gcol,0,1)
                        end
                        if HealBot_Globals.Tooltip_ShowMana then
                            if xButton.aggro.threatpct>0 or mana or HealBot_Tooltip_luVars["uGroup"]>0 or string.len(UnitTag)>0 then
                                if not mana or (maxmana and maxmana == 0) then
                                    if xButton.aggro.threatpct>0 then
                                        HealBot_Tooltip_SetLine(HEALBOT_WORD_THREAT.." "..xButton.aggro.threatpct.."%",1,0.1,0.1,1,UnitTag,xButton.text.sr,xButton.text.sg,xButton.text.sb,1)
                                        local threatvalue=HealBot_Text_readNumber(xButton.aggro.threatvalue)
                                        HealBot_Tooltip_SetLine(xButton.aggro.mobname.." ("..threatvalue..")",1,0.1,0.1,1,UnitTag,xButton.text.sr,xButton.text.sg,xButton.text.sb,1)
                                    elseif HealBot_Tooltip_luVars["uGroup"]>0 then
                                        HealBot_Tooltip_SetLine(HEALBOT_SORTBY_GROUP.." "..HealBot_Tooltip_luVars["uGroup"],1,1,1,1,UnitTag,xButton.text.sr,xButton.text.sg,xButton.text.sb,1)
                                    elseif string.len(UnitTag)>0 then
                                        HealBot_Tooltip_SetLine(UnitTag,xButton.text.sr,xButton.text.sg,xButton.text.sb,1," ",0,0,0,0)
                                    end
                                else
                                    local mPct=xButton.mana.pct
                                    mana=HealBot_Text_readNumber(mana)
                                    maxmana=HealBot_Text_readNumber(maxmana)
                                    if xButton.aggro.threatpct<1 then
                                        if HealBot_Tooltip_luVars["uGroup"]>0 then
                                            HealBot_Tooltip_SetLine(HEALBOT_SORTBY_GROUP.." "..HealBot_Tooltip_luVars["uGroup"],1,1,1,1,mana.."/"..maxmana.." ("..mPct.."%)",powerCols.r,powerCols.g,powerCols.b,1)
                                        elseif string.len(UnitTag)>0 then
                                            HealBot_Tooltip_SetLine(UnitTag,xButton.text.sr,xButton.text.sg,xButton.text.sb,1,mana.."/"..maxmana.." ("..mPct.."%)",powerCols.r,powerCols.g,powerCols.b,1)
                                        else
                                            HealBot_Tooltip_SetLine(" ",0,0,0,0,mana.."/"..maxmana.." ("..mPct.."%)",powerCols.r,powerCols.g,powerCols.b,1)
                                        end
                                    else
                                        HealBot_Tooltip_SetLine(HEALBOT_WORD_THREAT.." "..xButton.aggro.threatpct.."%",1,0.1,0.1,1,mana.."/"..maxmana.." ("..mPct.."%)",powerCols.r,powerCols.g,powerCols.b,1)
                                        local threatvalue=HealBot_Text_readNumber(xButton.aggro.threatvalue)
                                        HealBot_Tooltip_SetLine(xButton.aggro.mobname.." ("..threatvalue..")",1,0.1,0.1,1," ",UnitTag,xButton.text.sr,xButton.text.sg,xButton.text.sb,1)
                                    end
                                end
                            end
                        end
                    end

                    if HealBot_Globals.Tooltip_ShowDebuffs then
                        UnitDebuffIcons=HealBot_Aura_ReturnDebuffdetails(xButton.id)
                        if UnitDebuffIcons then
                            HealBot_Tooltip_luVars["CrDebuffLine"]=false
                            for i=51,hbv_Skins_GetIconVar("MAXDICONS", xButton.frame, 1)+50 do
                                if UnitDebuffIcons[i].current then
                                    ttName=HealBot_Aura_ReturnDebuffdetailsname(UnitDebuffIcons[i].spellId)
                                    if ttName then
                                        HealBot_Tooltip_addPlayerDebuffLine(uName, UnitDebuffIcons[i].spellId, ttName)
                                    end
                                else
                                    break
                                end
                            end
                            for i=56,hbv_Skins_GetIconVar("MAXDICONS", xButton.frame, 2)+55 do
                                if UnitDebuffIcons[i].current then
                                    ttName=HealBot_Aura_ReturnDebuffdetailsname(UnitDebuffIcons[i].spellId)
                                    if ttName then
                                        HealBot_Tooltip_addPlayerDebuffLine(uName, UnitDebuffIcons[i].spellId, ttName)
                                    end
                                else
                                    break
                                end
                            end
                            for i=58,hbv_Skins_GetIconVar("MAXDICONS", xButton.frame, 3)+57 do
                                if UnitDebuffIcons[i].current then
                                    ttName=HealBot_Aura_ReturnDebuffdetailsname(UnitDebuffIcons[i].spellId)
                                    if ttName then
                                        HealBot_Tooltip_addPlayerDebuffLine(uName, UnitDebuffIcons[i].spellId, ttName)
                                    end
                                else
                                    break
                                end
                            end
                        end
                    end
                    if xButton.aura.buff.name and xButton.aura.buff.missingbuff and HealBot_Globals.Tooltip_ShowRequiredBuffs then
                        HealBot_Tooltip_SetLine("  ",0,0,0,0)
                        local br,bg,bb=HealBot_Options_RetBuffRGB(xButton)
                        HealBot_Tooltip_SetLine("  Requires "..xButton.aura.buff.name,br,bg,bb,1," ",0,0,0,0)
                    end
                    if tipsRequests[xButton.guid] then
                        HealBot_Tooltip_SetLine("  ",0,0,0,0)
                        HealBot_Tooltip_SetLine(tipsRequests[xButton.guid],tipsRequests.r,tipsRequests.g,tipsRequests.b,1," ",0,0,0,0)
                    end
                    HealBot_Tooltip_luVars["incSpace"]=true
                    for x=1,8 do
                        if tipsAuraWatch[x][xButton.guid] then
                            if HealBot_Tooltip_luVars["incSpace"] then
                                HealBot_Tooltip_SetLine("  ",0,0,0,0)
                                HealBot_Tooltip_luVars["incSpace"]=false
                            end
                            HealBot_Tooltip_SetLine(tipsAuraWatch[x][xButton.guid],tipsAuraWatch[x].r,tipsAuraWatch[x].g,tipsAuraWatch[x].b,1," ",0,0,0,0)
                        end
                    end
                    local d=false
                    if HealBot_Globals.Tooltip_ShowMyBuffs then
                        for x,_ in pairs(HealBot_CheckBuffs) do
                            local z=HealBot_Aura_RetMyBuffTime(xButton,x)
                            if z and z>GetTime() then
                                d=true
                                z=z-GetTime()
                                local mins,secs=HealBot_Tooltip_ReturnMinsSecs(z)
                                local br,bg,bb=HealBot_Options_RetBuffRGBName(x)
                                if mins>1 then
                                    HealBot_Tooltip_SetLine("    "..x.."  "..mins.." mins",br,bg,bb,1," ",0,0,0,0)
                                elseif tonumber(secs)>=0 then
                                    HealBot_Tooltip_SetLine("    "..x.."  "..secs.." secs",br,bg,bb,1," ",0,0,0,0)
                                else
                                      HealBot_Queue_MyBuffsCheck(xGUID, xUnit)
                                end
                            end
                        end
                    end
                    HealBot_Tooltip_SetLine("  ",0,0,0,0)
                    if HealBot_Globals.ProtectPvP and UnitIsPVP(xUnit) and not UnitIsPVP("player") then
                        HealBot_Tooltip_SetLine("    ----- PVP -----",1,0.5,0.5,1,"----- PVP -----    ",1,0.5,0.5,1)
                    end
                end
            else
                HealBot_Tooltip_SetLine(HEALBOT_OPTIONS_TAB_SPELLS,1,1,1,1," ",0,0,0,0)
                HealBot_Tooltip_SetLine("  ",0,0,0,0)
            end

            if HealBot_Globals.Tooltip_ShowSpellInfo then
                HealBot_Action_setSpellInfo(xButton)
            end

            HealBot_ToolTip_ShowHoT(xButton)

            if HealBot_Tooltip_luVars["debug"] then
                HealBot_ToolTip_ShowDebug(xButton)
            end
        end
    elseif xUnit then
        HealBot_Tooltip_SetLine(HEALBOT_RESERVED_LABEL,1,1,1,1,xUnit,1,1,1,1)
    else
        return
    end
    HealBot_Tooltip_Show()
end

function HealBot_Action_RefreshTooltip()
    HealBot_Action_DoRefreshTooltip()
end

function HealBot_Tooltip_Wrap(str, limit)
      --HealBot_setCall("HealBot_Tooltip_Wrap")
  limit=limit or 72
  local here=1
  local buf=""
  local t={}
  str:gsub("(%s*)()(%S+)()",
  function(sp, st, word, fi)
        if fi-here > limit then
            --# Break the line
            here=st
            table.insert(t, buf)
            buf=word
        elseif string.len(buf)>1 then
            buf=buf.." "..word  --# Append
        else
            buf=word
        end
  end)
  --# Tack on any leftovers
  if(buf ~= "") then
        table.insert(t, buf)
  end
  return t
end

local tipDesc={["item"]={},["spell"]={},["macro"]={}}
local function EnumerateTooltipLines_helper(td, ...)
    for i=1, select("#", ...) do
        local region=select(i, ...)
        if region and region:GetObjectType() == "FontString" then
            td.dl[i]=region:GetText()
            td.desc=i
        end
    end
end

function HealBot_Tooltip_DebugActionIconCondition(icon, index, cond)
      --HealBot_setCall("HealBot_Tooltip_DebugActionIconCondition")
    local cond=hbv_ActionIcons_GetData("AlertFilter", icon.frame, icon.id, index)
    if cond>1 then
        if cond<6 then
            if cond == 3 then
                HealBot_Tooltip_SetLine("Condition "..index.." is "..HealBot_Options_RetActionIconsAlertFilter(cond),1,1,1,1,hbv_ActionIcons_GetData("AlertBuffTag", icon.frame, icon.id, index))
                if HealBot_ActionIcons_CurrentBuffTag(icon.frame, icon.id, index) then
                    HealBot_Tooltip_SetLine("Buff exists with tag",0.4,1,1,1,"TRUE",0.25,1,0.25,1)
                else
                    HealBot_Tooltip_SetLine("Buff exists with tag",0.4,1,1,1,"FALSE",1,0.25,0.25,1)
                end
            else
                HealBot_Tooltip_SetLine("Condition "..index.." is "..HealBot_Options_RetActionIconsAlertFilter(cond),1,1,1,1,icon.buff[index])
                if cond == 2 then
                    if HealBot_ActionIcons_CurrentBuff(icon.frame, icon.id, index) then
                        HealBot_Tooltip_SetLine("Buff exists",0.4,1,1,1,"TRUE",0.25,1,0.25,1)
                        if (icon.auraIsSelf[index] or not hbv_ActionIcons_GetBooleanData("AlertBuffSelf", icon.frame, icon.id, index)) and
                            icon.auraStacks[index]>=hbv_ActionIcons_GetData("AlertBuffMinStacks", icon.frame, icon.id, index) and
                            icon.auraStacks[index]<=hbv_ActionIcons_GetData("AlertBuffMaxStacks", icon.frame, icon.id, index) then
                            HealBot_Tooltip_SetLine("Buff cast conditions met",0.4,1,1,1,"TRUE",0.25,1,0.25,1)
                        else
                            HealBot_Tooltip_SetLine("Buff cast conditions met",0.4,1,1,1,"FALSE",1,0.25,0.25,1)
                        end
                    else
                        HealBot_Tooltip_SetLine("Buff exists",0.4,1,1,1,"FALSE",1,0.25,0.25,1)
                    end
                elseif cond == 4 then
                    if HealBot_ActionIcons_CurrentBuff(icon.frame, icon.id, index) then
                        HealBot_Tooltip_SetLine("Buff exists",0.4,1,1,1,"TRUE",0.25,1,0.25,1)
                        if (icon.auraIsSelf[index] or not hbv_ActionIcons_GetBooleanData("AlertBuffSelf", icon.frame, icon.id, index)) and
                             icon.auraStacks[index]>=hbv_ActionIcons_GetData("AlertBuffMinStacks", icon.frame, icon.id, index) and
                            icon.auraStacks[index]<=hbv_ActionIcons_GetData("AlertBuffMaxStacks", icon.frame, icon.id, index) then
                            HealBot_Tooltip_SetLine("Buff cast conditions met",0.4,1,1,1,"TRUE",0.25,1,0.25,1)
                        else
                            HealBot_Tooltip_SetLine("Buff cast conditions met",0.4,1,1,1,"FALSE",1,0.25,0.25,1)
                        end
                    else
                        HealBot_Tooltip_SetLine("Buff exists",0.4,1,1,1,"FALSE",0.25,1,0.25,1)
                    end
                else
                    if HealBot_ActionIcons_CurrentBuff(icon.frame, icon.id, index) then
                        HealBot_Tooltip_SetLine("Buff exists",0.4,1,1,1,"TRUE",1,0.25,0.25,1)
                    else
                        HealBot_Tooltip_SetLine("Buff exists",0.4,1,1,1,"FALSE",0.25,1,0.25,1)
                    end
                end
            end
        elseif cond<10 then
            if cond == 7 then
                HealBot_Tooltip_SetLine("Condition "..index.." is "..HealBot_Options_RetActionIconsAlertFilter(cond),1,1,1,1,hbv_ActionIcons_GetData("AlertDebuffTag", icon.frame, icon.id, index))
                if HealBot_ActionIcons_CurrentDebuffTag(icon.frame, icon.id, index) then
                    HealBot_Tooltip_SetLine("Debuff exists with tag",0.4,1,1,1,"TRUE",0.25,1,0.25,1)
                else
                    HealBot_Tooltip_SetLine("Debuff exists with tag",0.4,1,1,1,"FALSE",1,0.25,0.25,1)
                end
            else
                HealBot_Tooltip_SetLine("Condition "..index.." is "..HealBot_Options_RetActionIconsAlertFilter(cond),1,1,1,1,icon.debuff[index])
                if cond == 6 then
                    if HealBot_ActionIcons_CurrentDebuff(icon.frame, icon.id, index) then
                        HealBot_Tooltip_SetLine("Debuff exists",0.4,1,1,1,"TRUE",0.25,1,0.25,1)
                        if (icon.auraIsSelf[index] or not hbv_ActionIcons_GetBooleanData("AlertDebuffSelf", icon.frame, icon.id, index)) and
                            icon.auraStacks[index]>=hbv_ActionIcons_GetData("AlertDebuffMinStacks", icon.frame, icon.id, index) and
                            icon.auraStacks[index]<=hbv_ActionIcons_GetData("AlertDebuffMaxStacks", icon.frame, icon.id, index) then
                            HealBot_Tooltip_SetLine("Debuff cast conditions met",0.4,1,1,1,"TRUE",0.25,1,0.25,1)
                        else
                            HealBot_Tooltip_SetLine("Debuff cast conditions met",0.4,1,1,1,"FALSE",1,0.25,0.25,1)
                        end
                    else
                        HealBot_Tooltip_SetLine("Debuff exists",0.4,1,1,1,"FALSE",1,0.25,0.25,1)
                    end
                elseif cond == 8 then
                    if HealBot_ActionIcons_CurrentDebuff(icon.frame, icon.id, index) then
                        HealBot_Tooltip_SetLine("Debuff exists",0.4,1,1,1,"TRUE",0.25,1,0.25,1)
                        if (icon.auraIsSelf[index] or not hbv_ActionIcons_GetBooleanData("AlertDebuffSelf", icon.frame, icon.id, index)) and
                            icon.auraStacks[index]>=hbv_ActionIcons_GetData("AlertDebuffMinStacks", icon.frame, icon.id, index) and
                            icon.auraStacks[index]<=hbv_ActionIcons_GetData("AlertDebuffMaxStacks", icon.frame, icon.id, index) then
                            HealBot_Tooltip_SetLine("Debuff cast conditions met",0.4,1,1,1,"TRUE",0.25,1,0.25,1)
                        else
                            HealBot_Tooltip_SetLine("Debuff cast conditions met",0.4,1,1,1,"FALSE",1,0.25,0.25,1)
                        end
                    else
                        HealBot_Tooltip_SetLine("Debuff exists",0.4,1,1,1,"FALSE",0.25,1,0.25,1)
                    end
                else
                    if HealBot_ActionIcons_CurrentDebuff(icon.frame, icon.id, index) then
                        HealBot_Tooltip_SetLine("Debuff exists",0.4,1,1,1,"TRUE",1,0.25,0.25,1)
                    else
                        HealBot_Tooltip_SetLine("Debuff exists",0.4,1,1,1,"FALSE",0.25,1,0.25,1)
                    end
                end
            end
        elseif cond == 10 or cond == 11 then
            if cond == 10 then
                HealBot_Tooltip_SetLine("Condition "..index.." is "..HealBot_Options_RetActionIconsAlertFilter(cond),1,1,1,1,hbv_ActionIcons_GetData("AlertHealth", icon.frame, icon.id))
                if icon.health<=hbv_ActionIcons_GetData("AlertHealth", icon.frame, icon.id) then
                    HealBot_Tooltip_SetLine("icon.health is ",0.4,1,1,1,icon.health,0.25,1,0.25,1)
                else
                    HealBot_Tooltip_SetLine("icon.health is ",0.4,1,1,1,icon.health,1,0.25,0.25,1)
                end
            else
                HealBot_Tooltip_SetLine("Condition "..index.." is "..HealBot_Options_RetActionIconsAlertFilter(cond),1,1,1,1,hbv_ActionIcons_GetData("AlertHealthAbove", icon.frame, icon.id))
                if icon.health>=hbv_ActionIcons_GetData("AlertHealthAbove", icon.frame, icon.id) then
                    HealBot_Tooltip_SetLine("icon.health is ",0.4,1,1,1,icon.health,0.25,1,0.25,1)
                else
                    HealBot_Tooltip_SetLine("icon.health is ",0.4,1,1,1,icon.health,1,0.25,0.25,1)
                end
            end
        elseif cond == 12 or cond == 13 then
            if cond == 12 then
                HealBot_Tooltip_SetLine("Condition "..index.." is "..HealBot_Options_RetActionIconsAlertFilter(cond),1,1,1,1,hbv_ActionIcons_GetData("AlertMana", icon.frame, icon.id))
                if icon.mana<=hbv_ActionIcons_GetData("AlertMana", icon.frame, icon.id) then
                    HealBot_Tooltip_SetLine("icon.mana is ",0.4,1,1,1,icon.mana,0.25,1,0.25,1)
                else
                    HealBot_Tooltip_SetLine("icon.mana is ",0.4,1,1,1,icon.mana,1,0.25,0.25,1)
                end
            else
                HealBot_Tooltip_SetLine("Condition "..index.." is "..HealBot_Options_RetActionIconsAlertFilter(cond),1,1,1,1,hbv_ActionIcons_GetData("AlertManaAbove", icon.frame, icon.id))
                if icon.mana>=hbv_ActionIcons_GetData("AlertManaAbove", icon.frame, icon.id) then
                    HealBot_Tooltip_SetLine("icon.mana is ",0.4,1,1,1,icon.mana,0.25,1,0.25,1)
                else
                    HealBot_Tooltip_SetLine("icon.mana is ",0.4,1,1,1,icon.mana,1,0.25,0.25,1)
                end
            end
        elseif cond == 14 then
            HealBot_Tooltip_SetLine("Condition "..index.." is "..HealBot_Options_RetActionIconsAlertFilter(cond),1,1,1,1,hbv_ActionIcons_GetData("AlertAggro", icon.frame, icon.id))
            if icon.aggro>=hbv_ActionIcons_GetData("AlertAggro", icon.frame, icon.id) then
                HealBot_Tooltip_SetLine("icon.aggro is ",0.4,1,1,1,icon.aggro,0.25,1,0.25,1)
            else
                HealBot_Tooltip_SetLine("icon.aggro is ",0.4,1,1,1,icon.aggro,1,0.25,0.25,1)
            end
        elseif cond == 15 then
            HealBot_Tooltip_SetLine("Condition "..index.." is "..HealBot_Options_RetActionIconsAlertFilter(cond),1,1,1,1)
            if icon.falling then
                HealBot_Tooltip_SetLine("icon.falling is ",0.4,1,1,1,"TRUE",0.25,1,0.25,1)
            else
                HealBot_Tooltip_SetLine("icon.falling is ",0.4,1,1,1,"FALSE",1,0.25,0.25,1)
            end
        elseif cond == 16 then
            HealBot_Tooltip_SetLine("Condition "..index.." is "..HealBot_Options_RetActionIconsAlertFilter(cond),1,1,1,1)
            if icon.swimming then
                HealBot_Tooltip_SetLine("icon.swimming is ",0.4,1,1,1,"TRUE",0.25,1,0.25,1)
            else
                HealBot_Tooltip_SetLine("icon.swimming is ",0.4,1,1,1,"FALSE",1,0.25,0.25,1)
            end
        elseif cond == 17 then
            HealBot_Tooltip_SetLine("Condition "..index.." is "..HealBot_Options_RetActionIconsAlertFilter(cond),1,1,1,1)
            if icon.grouphealth then
                HealBot_Tooltip_SetLine("icon.grouphealth is ",0.4,1,1,1,"TRUE",0.25,1,0.25,1)
            else
                HealBot_Tooltip_SetLine("icon.grouphealth is ",0.4,1,1,1,"FALSE",1,0.25,0.25,1)
            end
        end
    else
        HealBot_Tooltip_SetLine("Condition "..index.." is "..HealBot_Options_RetActionIconsAlertFilter(cond),1,1,1,1,"PASS",0.25,1,0.25,1)
    end
    HealBot_Tooltip_SetLine("  ",0,0,0,0)
end

function HealBot_Tooltip_DisplayActionIconTooltip(icon, target)
      --HealBot_setCall("HealBot_Tooltip_DisplayActionIconTooltip")
    if HealBot_Tooltip_luVars["doInit"] then
        HealBot_Tooltip_Init()
    end
    HealBot_ToolTip_SetTooltipPos(icon.frame);
    hbTip:ClearLines()

    if icon.infoType == "spell" then
        hbTip:SetSpellByID(icon.infoID, false, true)
    elseif icon.infoType == "item" then
        local itemLoc=HealBot_IsItemInBag(icon.infoID)
        if itemLoc then
            hbTip:SetBagItem(itemLoc.bag, itemLoc.slot)
        end
    elseif GetMacroInfo(icon.infoID) then
        HealBot_Tooltip_SetLine(GetMacroInfo(icon.infoID),1,1,1,1)
    elseif icon.info and HealBot_ActionIcons_GetSpell(icon.info) then
        HealBot_Tooltip_SetLine(HealBot_ActionIcons_GetSpell(icon.info),1,1,1,1)
    end
    if icon.name then
        HealBot_Tooltip_SetLine(" ",1,1,1,0,"@"..icon.name,1,1,1,1)
    elseif target then
        HealBot_Tooltip_SetLine(" ",1,1,1,0,target,1,0.1,0.1,1)
    else
        HealBot_Tooltip_SetLine(" ",1,1,1,0,HEALBOT_WORDS_UNSET,1,0.5,0.3,1)
    end
    if bind then
        HealBot_Tooltip_SetLine(" ",1,1,1,0,"["..bind.."]",0.5,0.75,1,1)
    end

    if HealBot_Tooltip_luVars["debug"] then
        _, xButton, pButton=HealBot_UnitID(icon.unit or "x")
        if xButton then
            HealBot_ToolTip_ShowDebug(xButton)
        elseif pButton then
            HealBot_ToolTip_ShowDebug(pButton)
        else
            HealBot_ToolTip_ShowDebug()
            HealBot_Tooltip_SetLine("  ",0,0,0,0)
            HealBot_Tooltip_SetLine("icon.name="..(icon.name or "nil"),1,0.25,0.25,1)
            HealBot_Tooltip_SetLine("icon.unit="..(icon.unit or "nil"),1,0.25,0.25,1)
            HealBot_Tooltip_SetLine("target="..(target or "nil"),1,0.25,0.25,1)
        end
        if icon.range<1 then
            HealBot_Tooltip_SetLine("icon SpellRangeNeeds 0",1,1,1,1)
        elseif icon.range<35 then
            HealBot_Tooltip_SetLine("icon SpellRangeNeeds 30",1,1,1,1)
        elseif icon.range<45 then
            HealBot_Tooltip_SetLine("icon SpellRangeNeeds 40",1,1,1,1)
        else
            HealBot_Tooltip_SetLine("icon SpellRangeNeeds 100",1,1,1,1)
        end
        HealBot_Tooltip_SetLine("icon.infoType="..(icon.infoType or "nil"),0.25,1,0.25,1)
        HealBot_Tooltip_SetLine("icon.infoID="..(icon.infoID or "nil"),0.25,1,0.25,1)
        HealBot_Tooltip_SetLine("icon.infoName="..(icon.infoName or "nil"),0.25,1,0.25,1)
        HealBot_Tooltip_SetLine("icon.info="..(icon.info or "nil"),0.25,1,0.25,1)
        HealBot_Tooltip_SetLine("  ",0,0,0,0)
        if not icon.guid then
            HealBot_Tooltip_SetLine("icon.guid not valid",1,0.25,0.25,1)
        else
            hbTipDebugText["abilityValid"], hbTipDebugText["onCD"]=HealBot_ActionIcons_DebugHighlightIconAbility(icon.frame, icon.id)
            if not hbTipDebugText["abilityValid"] then
                HealBot_Tooltip_SetLine("Ability not valid",1,0.25,0.25,1)
            elseif hbTipDebugText["onCD"] then
                HealBot_Tooltip_SetLine("Ability valid",1,1,1,1,"On Cooldown",1,0.25,0.25,1)
            else
                HealBot_Tooltip_SetLine("Ability valid",1,1,1,1,"Not on cooldown",1,1,1,1)
            end
            if icon.valid then
                HealBot_Tooltip_SetLine("icon.valid is ",0.4,1,1,1,"TRUE",0.25,1,0.25,1)
            else
                HealBot_Tooltip_SetLine("icon.valid is ",0.4,1,1,1,"FALSE",1,0.25,0.25,1)
            end
            if HealBot_ActionIcons_CheckValidTarget(icon.frame, icon.id) then
                HealBot_Tooltip_SetLine("target valid is ",0.4,1,1,1,"TRUE",0.25,1,0.25,1)
            else
                HealBot_Tooltip_SetLine("target valid is ",0.4,1,1,1,"FALSE",1,0.25,0.25,1)
            end
            HealBot_Tooltip_SetLine("  ",0,0,0,0)
            local gCond, r1, r2, r3, r4 = HealBot_ActionIcons_DebugAlertState(icon.frame, icon.id)
            if not gCond then
                HealBot_Tooltip_SetLine("Global conditions not met",1,0.25,0.25,1)
                if r1 then HealBot_Tooltip_SetLine(r1,1,0.25,0.25,1) end
                if r2 then HealBot_Tooltip_SetLine(r2,1,0.25,0.25,1) end
                if r3 then HealBot_Tooltip_SetLine(r3,1,0.25,0.25,1) end
                if r4 then HealBot_Tooltip_SetLine(r4,1,0.25,0.25,1) end
                HealBot_Tooltip_SetLine(" ")
            end
            for x=1,3 do
                HealBot_Tooltip_DebugActionIconCondition(icon, x)
            end
        end
    end
    HealBot_Tooltip_Show()
end

function HealBot_Tooltip_DisplayIconTooltipInit(frame, details, name, aType, r, g, b)
    if HealBot_Tooltip_luVars["doInit"] then
        HealBot_Tooltip_Init()
    end
    HealBot_ToolTip_SetTooltipPos(frame);
    hbTip:ClearLines()
    if details.debuffType and details.debuffType~="nil" then
        HealBot_Tooltip_SetLine(name,r,g,b,1,details.debuffType.." ("..aType..")",r,g,b,1)
    else
        HealBot_Tooltip_SetLine(name,r,g,b,1,aType,r,g,b,1)
    end
end

function HealBot_Tooltip_DisplayCompactIconTooltip(frame, details, name, aType, r, g, b, l2, l3)
    HealBot_Tooltip_DisplayIconTooltipInit(frame, details, name, aType, r, g, b)
    if l2 then HealBot_Tooltip_SetWrappedLine(l2,1,1,1,1) end
    if l3 then HealBot_Tooltip_SetWrappedLine(l3) end
    HealBot_Tooltip_Show()
end

function HealBot_Tooltip_DisplayIconTooltip(frame, details, name, aType, desc, r, g, b, id)
      --HealBot_setCall("HealBot_Tooltip_DisplayIconTooltip")
    HealBot_Tooltip_DisplayIconTooltipInit(frame, details, name, aType, r, g, b)

    if details.unitCaster and UnitName(details.unitCaster) then
        if not UnitIsFriend("player",details.unitCaster) then
            HealBot_Tooltip_SetLine(HEALBOT_WORD_CASTER,1,1,1,1,UnitName(details.unitCaster),1,0.5,0.2,1)
        else
            HealBot_Tooltip_SetLine(HEALBOT_WORD_CASTER,1,1,1,1,UnitName(details.unitCaster),0.2,1,0.5,1)
        end
    end
    if details.type and string.len(details.type)>1 then
        HealBot_Tooltip_SetLine(HEALBOT_WORD_TYPE,1,1,1,1,details.type,1,1,0,1)
    end
    if details.count>0 then
        HealBot_Tooltip_SetLine(HEALBOT_OPTIONS_HOTTEXTCOUNT,1,1,1,1,details.count,1,1,0,1)
    end

    local eTime=ceil(details.expirationTime-GetTime())
    if eTime>90 then
        eTime=ceil(eTime/60)
        HealBot_Tooltip_SetLine(HEALBOT_OPTIONS_HOTTEXTDURATION,1,1,1,1,eTime.." mins",1,1,0,1)
    elseif eTime>1 then
        HealBot_Tooltip_SetLine(HEALBOT_OPTIONS_HOTTEXTDURATION,1,1,1,1,eTime.." secs",1,1,0,1)
    end
    HealBot_Tooltip_SetLine(HEALBOT_OPTIONS_CUSTOM_IDMETHODSID,1,1,1,1,details.spellId,1,1,0,1)
    if desc and string.len(desc)>1 then
        local desc_lines=HealBot_Tooltip_Wrap(desc,40)
        for x=1,#desc_lines do
            HealBot_Tooltip_SetLine(desc_lines[x],1,1,0,1)
        end
    end

    HealBot_Tooltip_SetLine(" ",0,0,0,0," ",0,0,0,0)
    local aPrio, bPrio=20, 20
    local aCol=1
    local iSet=1
    local iGlow=1
    local iScale=1
    if aType == "Buff" then
        aPrio=HealBot_Globals.CustomBuffs[details.spellId] or HealBot_Globals.CustomBuffs[name] or 20
        aCol=HealBot_Globals.CustomBuffsShowBarCol[name] or HealBot_Globals.CustomBuffsShowBarCol[details.spellId] or 1
        iGlow=HealBot_Globals.CustomBuffsIconGlow[name] or HealBot_Globals.CustomBuffsIconGlow[details.spellId] or 1
        if id<9 then
            iScale=hbv_Skins_GetIconVar("BSCALE", frame, 1)
        elseif id<13 then
            iScale=hbv_Skins_GetIconVar("BSCALE", frame, 2)
            iSet=2
        else
            iScale=hbv_Skins_GetIconVar("BSCALE", frame, 3)
            iSet=3
        end
    else
        aPrio, bPrio=HealBot_Options_retDebuffPriority(details.spellId, name, details.debuffType)
        if bPrio<aPrio then aPrio=bPrio end
        aCol=HealBot_Globals.CustomDebuffsShowBarCol[details.spellId] or HealBot_Globals.CustomDebuffsShowBarCol[name] or 4
        iGlow=HealBot_Globals.CustomDebuffsIconGlow[name] or HealBot_Globals.CustomDebuffsIconGlow[details.spellId] or 1
        if id<59 then
            iScale=hbv_Skins_GetIconVar("DSCALE", frame, 1)
        elseif id<63 then
            iScale=hbv_Skins_GetIconVar("DSCALE", frame, 2)
            iSet=2
        else
            iScale=hbv_Skins_GetIconVar("DSCALE", frame, 3)
            iSet=3
        end
    end
    HealBot_Tooltip_SetLine(HEALBOT_WORD_PRIORITY,1,1,1,1,aPrio,1,1,0,1)
    HealBot_Tooltip_SetLine(HEALBOT_SKIN_HEADERBARCOL,1,1,1,1,HealBot_Options_retAuraBarCol(aCol),1,1,0,1)
    HealBot_Tooltip_SetLine(HEALBOT_SKIN_ICONSET,1,1,1,1,iSet,1,1,0,1)
    HealBot_Tooltip_SetLine(HEALBOT_SKIN_ICONGLOW,1,1,1,1,HealBot_Options_retAuraIconGlow(iGlow),1,1,0,1)
    HealBot_Tooltip_SetLine(HEALBOT_OPTIONS_ICONSCALE,1,1,1,1,iScale,1,1,0,1)
    HealBot_Tooltip_SetLine(" ",0,0,0,0," ",0,0,0,0)

    if HealBot_Globals.UseIconCommands then
        local spellLeft=HealBot_Action_IconSpellPattern("Left");
        local spellMiddle=HealBot_Action_IconSpellPattern("Middle");
        local spellRight=HealBot_Action_IconSpellPattern("Right");
        local spellButton4=HealBot_Action_IconSpellPattern("Button4");
        local spellButton5=HealBot_Action_IconSpellPattern("Button5");

        if aType == "Auto Debuff" then
            HealBot_Tooltip_SetLine(HEALBOT_OPTIONS_BUTTONANY,1,1,1,1,HEALBOT_OPTIONS_DEBUFFAUTOTOCUSTOM,1,1,0,1)
        end
        if spellLeft then
            HealBot_Tooltip_SetLine(HEALBOT_OPTIONS_BUTTONLEFT,1,1,1,1,spellLeft,1,1,0,1)
        end
        if spellMiddle then
            HealBot_Tooltip_SetLine(HEALBOT_OPTIONS_BUTTONMIDDLE,1,1,1,1,spellMiddle,1,1,0,1)
        end
        if spellRight then
            HealBot_Tooltip_SetLine(HEALBOT_OPTIONS_BUTTONRIGHT,1,1,1,1,spellRight,1,1,0,1)
        end
        if spellButton4 then
            HealBot_Tooltip_SetLine(HEALBOT_OPTIONS_BUTTON4,1,1,1,1,spellButton4,1,1,0,1)
        end
        if spellButton5 then
            HealBot_Tooltip_SetLine(HEALBOT_OPTIONS_BUTTON5,1,1,1,1,spellButton5,1,1,0,1)
        end
    elseif HealBot_Globals.Tooltip_ShowSpellInfo and HealBot_Tooltip_luVars["button"] then
        HealBot_Action_setSpellInfo(HealBot_Tooltip_luVars["button"])
    end
    HealBot_Tooltip_Show()
end

local hbIconTip={}
local GetSpellDescription=(C_Spell and C_Spell.GetSpellDescription) or GetSpellDescription
function HealBot_Tooltip_AuraUpdateIconTooltip(frame, details, name, aType, r, g, b, id)
      --HealBot_setCall("HealBot_Tooltip_AuraUpdateIconTooltip")
    local spell=Spell:CreateFromSpellID(details.spellId)
    spell:ContinueOnSpellLoad(function()
        local desc=spell:GetSpellDescription()
        HealBot_Tooltip_DisplayIconTooltip(frame, details, name, aType, desc, r, g, b, id)
    end)
end

function HealBot_Tooltip_DebuffIconTooltip(button, id)
      --HealBot_setCall("HealBot_Tooltip_DebuffIconTooltip", button)
    if HealBot_Globals.UseIconCommands or HealBot_Globals.Tooltip_ShowDebuffIconInfo then
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
                hbIconTip["id"]=id
                if HealBot_Globals.Tooltip_ShowDebuffIconCompact then
                    HealBot_ScanTooltip:SetUnitDebuff(button.unit, UnitDebuffIcons[id].gSlot)
                    HealBot_Tooltip_DisplayCompactIconTooltip(hbIconTip["frame"],
                                                              hbIconTip["details"],
                                                              hbIconTip["name"],
                                                              hbIconTip["type"],
                                                              hbIconTip["r"],
                                                              hbIconTip["g"],
                                                              hbIconTip["b"],
                                                              HealBot_ScanTooltipTextLeft2:GetText(),
                                                              HealBot_ScanTooltipTextLeft3:GetText())
                else
                    HealBot_Tooltip_AuraUpdateIconTooltip(hbIconTip["frame"],
                                                          hbIconTip["details"],
                                                          hbIconTip["name"],
                                                          hbIconTip["type"],
                                                          hbIconTip["r"],
                                                          hbIconTip["g"],
                                                          hbIconTip["b"],
                                                          hbIconTip["id"])
                end
                HealBot_Data["TIPICON"]=button
            end
        end
    end
end

function HealBot_Tooltip_BuffIconTooltip(button, id)
      --HealBot_setCall("HealBot_Tooltip_BuffIconTooltip", button)
    if HealBot_Globals.UseIconCommands or HealBot_Globals.Tooltip_ShowBuffIconInfo then
        if HealBot_Globals.DisableToolTipInCombat and HealBot_Data["UILOCK"] then return end
        local r,g,b=1,1,1
        UnitBuffIcons=HealBot_Aura_ReturnHoTdetails(button.id)
        if UnitBuffIcons and UnitBuffIcons[id].current and UnitBuffIcons[id].spellId>0 then
            ttName=HealBot_Aura_ReturnHoTdetailsname(UnitBuffIcons[id].spellId)
            if ttName then
                if HealBot_Globals.CustomBuffBarColour[UnitBuffIcons[id].spellId] then
                    r=HealBot_Globals.CustomBuffBarColour[UnitBuffIcons[id].spellId].R
                    g=HealBot_Globals.CustomBuffBarColour[UnitBuffIcons[id].spellId].G
                    b=HealBot_Globals.CustomBuffBarColour[UnitBuffIcons[id].spellId].B
                elseif HealBot_Globals.CustomBuffBarColour[ttName] then
                    r=HealBot_Globals.CustomBuffBarColour[ttName].R
                    g=HealBot_Globals.CustomBuffBarColour[ttName].G
                    b=HealBot_Globals.CustomBuffBarColour[ttName].B
                elseif HealBot_Globals.CustomBuffBarColour[HEALBOT_CUSTOM_CAT_CUSTOM_AUTOBUFFS] then
                    r=HealBot_Globals.CustomBuffBarColour[HEALBOT_CUSTOM_CAT_CUSTOM_AUTOBUFFS].R
                    g=HealBot_Globals.CustomBuffBarColour[HEALBOT_CUSTOM_CAT_CUSTOM_AUTOBUFFS].G
                    b=HealBot_Globals.CustomBuffBarColour[HEALBOT_CUSTOM_CAT_CUSTOM_AUTOBUFFS].B
                else
                    r=0.25
                    g=0.58
                    b=0.8
                end
                hbIconTip["frame"]=button.frame
                hbIconTip["details"]=UnitBuffIcons[id]
                hbIconTip["name"]=ttName
                hbIconTip["type"]="Buff"
                hbIconTip["r"]=r
                hbIconTip["g"]=g
                hbIconTip["b"]=b
                hbIconTip["id"]=id
                if HealBot_Globals.Tooltip_ShowBuffIconCompact then
                    HealBot_ScanTooltip:SetUnitBuff(button.unit, UnitBuffIcons[id].gSlot)
                    HealBot_Tooltip_DisplayCompactIconTooltip(hbIconTip["frame"],
                                                              hbIconTip["details"],
                                                              hbIconTip["name"],
                                                              hbIconTip["type"],
                                                              hbIconTip["r"],
                                                              hbIconTip["g"],
                                                              hbIconTip["b"],
                                                              HealBot_ScanTooltipTextLeft2:GetText(),
                                                              HealBot_ScanTooltipTextLeft3:GetText())
                else
                    HealBot_Tooltip_AuraUpdateIconTooltip(hbIconTip["frame"],
                                                          hbIconTip["details"],
                                                          hbIconTip["name"],
                                                          hbIconTip["type"],
                                                          hbIconTip["r"],
                                                          hbIconTip["g"],
                                                          hbIconTip["b"],
                                                          hbIconTip["id"])
                end
                HealBot_Data["TIPICON"]=button
            end
        end
    end
end

function HealBot_Tooltip_UpdateIconTooltip()
      --HealBot_setCall("HealBot_Tooltip_UpdateIconTooltip")
    if hbIconTip["type"] == "Buff" then
        HealBot_Tooltip_BuffIconTooltip(HealBot_Data["TIPICON"], hbIconTip["id"])
    else
        HealBot_Tooltip_DebuffIconTooltip(HealBot_Data["TIPICON"], hbIconTip["id"])
    end
end

local tLine={}
function HealBot_Tooltip_OptionsHelp(title,text,top)
      --HealBot_setCall("HealBot_Tooltip_OptionsHelp")
    if title and text then
        if HealBot_Tooltip_luVars["doInit"] then
            HealBot_Tooltip_Init()
        end
        hbTip:ClearLines()
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
        local x, y=GetCursorPosition();
        if not HealBot_Globals.Tooltip_UseGameTooltip then
            x=(x/UIParent:GetScale())/HealBot_Globals.Tooltip_Scale
            y=(y/UIParent:GetScale())/HealBot_Globals.Tooltip_Scale
        else
            x=x/UIParent:GetScale()
            y=y/UIParent:GetScale()
        end
        local g=_G["HealBot_Options"]
        hbTip:SetOwner(g, "ANCHOR_NONE")
        hbTip:AddLine(title,1,1,1)
        hbTip:AddLine("    ",1,1,1)
        for l=1,#tLine do
            hbTip:AddLine(tLine[l],0.8,0.8,0.8)
        end
        HealBot_Tooltip_Show()
        if top then
            hbTip:SetPoint("TOPLEFT","WorldFrame","BOTTOMLEFT",x,y+20+hbTip:GetHeight())
        else
            hbTip:SetPoint("TOPLEFT","WorldFrame","BOTTOMLEFT",x,y-30)
        end
    end
end

function HealBot_Tooltip_Show()
      --HealBot_setCall("HealBot_Tooltip_Show")
    hbTip:Show()
    if not HealBot_Globals.Tooltip_UseGameTooltip then
        hbTip:SetAlpha(HealBot_Globals.Tooltip_Alpha)
    end
end

function HealBot_Tooltip_Hide()
      --HealBot_setCall("HealBot_Tooltip_Hide")
    hbTip:Hide()
end

function HealBot_Tooltip_ClearGUID(guid)
      --HealBot_setCall("HealBot_Tooltip_ClearGUID", nil, guid)
    tipsRequests[guid]=nil
    for x=1,8 do
        tipsAuraWatch[x][guid]=nil
    end
    tipsHealthWatch[guid]=nil
    tipsManaWatch[guid]=nil
end

local function HealBot_Tooltip_CustomAnchor_SetPoint()
      --HealBot_setCall("HealBot_Tooltip_CustomAnchor_SetPoint")
    local fScale=1
    if not HealBot_Globals.Tooltip_UseGameTooltip then
        fScale=HealBot_Globals.Tooltip_Scale
    end
	local fY=HealBot_Tooltip_GetVar("ANCHORY")
	local fX=HealBot_Tooltip_GetVar("ANCHORX")
    local fPoint=HealBot_Tooltip_GetVar("ANCHORPOINT")
    local fWidth=hbCustomTipAnchor:GetWidth()
    local fHeight=hbCustomTipAnchor:GetHeight()
    if fPoint == "BOTTOMLEFT" then
        if fY>floor(GetScreenHeight()/fScale)-fHeight then
            fY=floor(GetScreenHeight()/fScale)-fHeight
        end
        if fX>floor(GetScreenWidth()/fScale)-fWidth then
            fX=floor(GetScreenWidth()/fScale)-fWidth
        end
    elseif fPoint == "BOTTOMRIGHT" then
        if fY>floor(GetScreenHeight()/fScale)-fHeight then
            fY=floor(GetScreenHeight()/fScale)-fHeight
        end
        if fX<0-floor(GetScreenWidth()/fScale)+fWidth then
            fX=0-floor(GetScreenWidth()/fScale)+fWidth
        end
    elseif fPoint == "TOPLEFT" then
        if fY<0-floor(GetScreenHeight()/fScale)+fHeight then
            fY=0-floor(GetScreenHeight()/fScale)+fHeight
        end
        if fX>floor(GetScreenWidth()/fScale)-fWidth then
            fX=floor(GetScreenWidth()/fScale)-fWidth
        end
    elseif fPoint == "TOPRIGHT" then
        if fY<0-floor(GetScreenHeight()/fScale)+fHeight then
            fY=0-floor(GetScreenHeight()/fScale)+fHeight
        end
        if fX<0-floor(GetScreenWidth()/fScale)+fWidth then
            fX=0-floor(GetScreenWidth()/fScale)+fWidth
        end
    end
    HealBot_Tooltip_SetVar(ceil(fY), "ANCHORY")
    HealBot_Tooltip_SetVar(ceil(fX), "ANCHORX")
    HealBot_Tooltip_SetVar(fPoint, "ANCHORPOINT")
	hbCustomTipAnchor:ClearAllPoints()
	hbCustomTipAnchor:SetPoint(fPoint,"WorldFrame",fPoint,fX,fY);
end

local function HealBot_Tooltip_CustomAnchor_OnMouseDown(self, button)
      --HealBot_setCall("HealBot_Tooltip_CustomAnchor_OnMouseDown")
    if button == "LeftButton" and not hbCustomTipAnchor.isMoving then
        hbCustomTipAnchor:StartMoving();
        hbCustomTipAnchor.isMoving=true;
    end
end

local function HealBot_Tooltip_CustomAnchor_SetAnchorText()
      --HealBot_setCall("HealBot_Tooltip_CustomAnchor_SetAnchorText")
    hbCustomTipAnchorText["AP1"]:SetText(HEALBOT_OPTIONS_TTCUSTOMANCHOR_POINT..": "..HealBot_Tooltip_GetVar("ANCHORPOINT"))
    hbCustomTipAnchorText["AX2"]:SetText(HealBot_Tooltip_GetVar("ANCHORX"))
    hbCustomTipAnchorText["AY2"]:SetText(HealBot_Tooltip_GetVar("ANCHORY"))
end

local function HealBot_Tooltip_CustomAnchor_SavePoints()
      --HealBot_setCall("HealBot_Tooltip_CustomAnchor_SavePoints")
    local fX, fY=0, 0
    local fScale=1
    if not HealBot_Globals.Tooltip_UseGameTooltip then
        fScale=HealBot_Globals.Tooltip_Scale
    end
    if HealBot_Tooltip_GetVar("ANCHORPOINT") == "BOTTOMRIGHT" then
        fX=hbCustomTipAnchor:GetRight()-floor(GetScreenWidth()/fScale)
        fY=hbCustomTipAnchor:GetBottom()
        if fX>0 then fX=0 end
        if fY<0 then fY=0 end
    elseif HealBot_Tooltip_GetVar("ANCHORPOINT") == "TOPRIGHT" then
        fX=hbCustomTipAnchor:GetRight()-floor(GetScreenWidth()/fScale)
        fY=hbCustomTipAnchor:GetTop()-floor(GetScreenHeight()/fScale)
        if fX>0 then fX=0 end
        if fY>0 then fY=0 end
    elseif HealBot_Tooltip_GetVar("ANCHORPOINT") == "BOTTOMLEFT" then
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
    HealBot_Tooltip_SetVar(ceil(fY), "ANCHORY")
    HealBot_Tooltip_SetVar(ceil(fX), "ANCHORX")
    HealBot_Tooltip_CustomAnchor_SetAnchorText()
    HealBot_Tooltip_CustomAnchor_SetPoint()
end

local function HealBot_Tooltip_CustomAnchor_OnMouseUp(self, button)
      --HealBot_setCall("HealBot_Tooltip_CustomAnchor_OnMouseUp")
    if button == "LeftButton" and hbCustomTipAnchor.isMoving then
		hbCustomTipAnchor:StopMovingOrSizing();
		hbCustomTipAnchor.isMoving=false;
        HealBot_Tooltip_CustomAnchor_SavePoints()
    end
end

local function HealBot_Tooltip_CustomAnchor_SetText()
      --HealBot_setCall("HealBot_Tooltip_CustomAnchor_SetText")
	hbCustomTipAnchorText["SKIN1"]:SetText(HEALBOT_OPTIONS_SKIN..": "..Healbot_Config_Skins.Current_Skin)
    HealBot_Tooltip_CustomAnchor_SetAnchorText()
end

local function HealBot_Tooltip_CustomAnchor_CreateText()
      --HealBot_setCall("HealBot_Tooltip_CustomAnchor_CreateText")
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
      --HealBot_setCall("HealBot_Tooltip_CustomAnchor_SetAnchor")
    HealBot_Tooltip_SetVar(loc, "ANCHORPOINT")
    hbCustomTipAnchorObjects["TOPLEFT"]:SetChecked(false)
    hbCustomTipAnchorObjects["TOPRIGHT"]:SetChecked(false)
    hbCustomTipAnchorObjects["BOTTOMLEFT"]:SetChecked(false)
    hbCustomTipAnchorObjects["BOTTOMRIGHT"]:SetChecked(false)
    hbCustomTipAnchorObjects[loc]:SetChecked(true)
    HealBot_Tooltip_CustomAnchor_SavePoints()
end

function HealBot_Tooltip_CustomAnchor_Hide()
      --HealBot_setCall("HealBot_Tooltip_CustomAnchor_Hide")
    if hbCustomTipAnchor then
        hbCustomTipAnchor:Hide()
    end
end

function HealBot_Tooltip_ResetCustomAnchor()
      --HealBot_setCall("HealBot_Tooltip_ResetCustomAnchor")
    if Healbot_Config_Skins.ToolTip[Healbot_Config_Skins.Current_Skin] then
        HealBot_Tooltip_NilVar("ANCHORY")
        HealBot_Tooltip_NilVar("ANCHORX")
        HealBot_Tooltip_NilVar("ANCHORPOINT")
        if hbCustomTipAnchor then
            HealBot_Tooltip_CustomAnchor_SetAnchor("BOTTOMRIGHT")
        end
    end
end

function HealBot_Tooltip_ShowCustomAnchor()
      --HealBot_setCall("HealBot_Tooltip_ShowCustomAnchor")
    if not hbCustomTipAnchor then
		hbCustomTipAnchor=CreateFrame("Frame", "HealBot_Custom_Anchor_Frame", UIParent, BackdropTemplateMixin and "BackdropTemplate")
		hbCustomTipAnchor:SetBackdrop({
			bgFile="Interface\\Addons\\HealBot\\Images\\frame\\WhiteLine.tga",
			edgeFile="Interface\\Addons\\HealBot\\Images\\frame\\border.tga",
			tile=true,
			tileSize=8,
			edgeSize=8,
			insets={ left=3, right=3, top=3, bottom=3, },
		})
		hbCustomTipAnchor:SetMovable(true)
		hbCustomTipAnchor:EnableMouse(true)
		hbCustomTipAnchor:SetScript("OnMouseDown", function(self, button) HealBot_Tooltip_CustomAnchor_OnMouseDown(self, button) end)
		hbCustomTipAnchor:SetScript("OnMouseUp", function(self, button) HealBot_Tooltip_CustomAnchor_OnMouseUp(self, button) end)

		hbCustomTipAnchor:SetWidth(220)
        hbCustomTipAnchor:SetHeight(120)
        hbCustomTipAnchor:SetBackdropColor(0.2,0.2,0.2,0.8)
        hbCustomTipAnchor:SetBackdropBorderColor(0.4,0.4,0.4,0.9)

        hbCustomTipAnchorObjects["TOPLEFT"]=CreateFrame("CheckButton", "HealBot_Custom_Anchor_TOPLEFT", hbCustomTipAnchor, "SendMailRadioButtonTemplate")
		hbCustomTipAnchorObjects["TOPLEFT"]:SetPoint("TOPLEFT", 5, -5)
		hbCustomTipAnchorObjects["TOPLEFT"]:SetScript("OnClick", function() HealBot_Tooltip_CustomAnchor_SetAnchor("TOPLEFT"); end)
        hbCustomTipAnchorObjects["TOPRIGHT"]=CreateFrame("CheckButton", "HealBot_Custom_Anchor_TOPRIGHT", hbCustomTipAnchor, "SendMailRadioButtonTemplate")
		hbCustomTipAnchorObjects["TOPRIGHT"]:SetPoint("TOPRIGHT", -5, -5)
		hbCustomTipAnchorObjects["TOPRIGHT"]:SetScript("OnClick", function() HealBot_Tooltip_CustomAnchor_SetAnchor("TOPRIGHT"); end)
        hbCustomTipAnchorObjects["BOTTOMLEFT"]=CreateFrame("CheckButton", "HealBot_Custom_Anchor_BOTTOMLEFT", hbCustomTipAnchor, "SendMailRadioButtonTemplate")
		hbCustomTipAnchorObjects["BOTTOMLEFT"]:SetPoint("BOTTOMLEFT", 5, 5)
		hbCustomTipAnchorObjects["BOTTOMLEFT"]:SetScript("OnClick", function() HealBot_Tooltip_CustomAnchor_SetAnchor("BOTTOMLEFT"); end)
        hbCustomTipAnchorObjects["BOTTOMRIGHT"]=CreateFrame("CheckButton", "HealBot_Custom_Anchor_BOTTOMRIGHT", hbCustomTipAnchor, "SendMailRadioButtonTemplate")
		hbCustomTipAnchorObjects["BOTTOMRIGHT"]:SetPoint("BOTTOMRIGHT", -5, 5)
		hbCustomTipAnchorObjects["BOTTOMRIGHT"]:SetScript("OnClick", function() HealBot_Tooltip_CustomAnchor_SetAnchor("BOTTOMRIGHT"); end)

        hbCustomTipAnchorObjects["CloseBtn"]=CreateFrame("Button", "HealBot_Custom_Anchor_CloseBtn", hbCustomTipAnchor, "UIPanelButtonTemplate")
        hbCustomTipAnchorObjects["CloseBtn"]:SetPoint("BOTTOM", 0, 7)
        hbCustomTipAnchorObjects["CloseBtn"]:SetWidth(120)
        hbCustomTipAnchorObjects["CloseBtn"]:SetHeight(22)
        hbCustomTipAnchorObjects["CloseBtn"]:SetNormalFontObject("GameFontNormal")
        hbCustomTipAnchorObjects["CloseBtn"]:SetText(HEALBOT_OPTIONS_CLOSE)
        hbCustomTipAnchorObjects["CloseBtn"]:SetScript("OnMouseDown", function() HealBot_Tooltip_CustomAnchor_Hide(); end)

        HealBot_Tooltip_CustomAnchor_CreateText()
    end
    if not HealBot_Globals.Tooltip_UseGameTooltip then
        hbCustomTipAnchor:SetScale(HealBot_Globals.Tooltip_Scale)
    else
        hbCustomTipAnchor:SetScale(1)
    end
    hbCustomTipAnchorObjects["TOPLEFT"]:SetChecked(false)
    hbCustomTipAnchorObjects["TOPRIGHT"]:SetChecked(false)
    hbCustomTipAnchorObjects["BOTTOMLEFT"]:SetChecked(false)
    hbCustomTipAnchorObjects["BOTTOMRIGHT"]:SetChecked(false)
    hbCustomTipAnchorObjects[HealBot_Tooltip_GetVar("ANCHORPOINT")]:SetChecked(true)
    HealBot_Tooltip_CustomAnchor_SetPoint()
    HealBot_Tooltip_CustomAnchor_SetText()
    hbCustomTipAnchor:Show()
end


local hbDefaultTips={["ANCHORY"]=175, ["ANCHORX"]=-275, ["ANCHORPOINT"]="BOTTOMRIGHT"}
function HealBot_Tooltip_GetVar(key)
    if Healbot_Config_Skins.ToolTip[Healbot_Config_Skins.Current_Skin] then
        return Healbot_Config_Skins.ToolTip[Healbot_Config_Skins.Current_Skin][key] or hbDefaultTips[key]
    end
    return hbDefaultTips[key]
end

function HealBot_Tooltip_SetVar(value, key)
    if value == hbDefaultTips[key] then
        HealBot_Tooltip_NilVar(key)
    else
        if not Healbot_Config_Skins.ToolTip[Healbot_Config_Skins.Current_Skin] then Healbot_Config_Skins.ToolTip[Healbot_Config_Skins.Current_Skin]={} end
        Healbot_Config_Skins.ToolTip[Healbot_Config_Skins.Current_Skin][key]=value
    end
end

function HealBot_Tooltip_NilVar(key)
    if Healbot_Config_Skins.ToolTip[Healbot_Config_Skins.Current_Skin] then Healbot_Config_Skins.ToolTip[Healbot_Config_Skins.Current_Skin][key]=nil end
    HealBot_Util_EmptyTable(Healbot_Config_Skins.ToolTip, Healbot_Config_Skins.Current_Skin)
end    
