local HealBot_RangeSpells={}
local HealBot_RangeSpellsKeysFriendly={}
local HealBot_RangeSpellsKeysEnemy={}
local hbRangeRequests={}
local hbActionIconsInRange={}
local aButton={}
local HealBot_Range_luVars={}
HealBot_Range_luVars["modKeyUpdate"]=0
HealBot_Range_luVars["CurrentModKey"]=""
HealBot_RangeSpells["HEAL"]=""
HealBot_RangeSpells["HARM"]=""

local UnitInRange=UnitInRange
local UnitIsVisible=UnitIsVisible
local CheckInteractDistance=CheckInteractDistance
local GetInventoryItemID=GetInventoryItemID
local UnitPhaseReason=UnitPhaseReason

function HealBot_Range_setLuVars(vName, vValue)
	  --HealBot_setCall("HealBot_setLuVars - "..vName)
    HealBot_Range_luVars[vName]=vValue
end

function HealBot_Range_retLuVars(vName)
      --HealBot_setCall("HealBot_retLuVars - "..vName)
    return HealBot_Range_luVars[vName]
end

function HealBot_Range_InitSpell(key, spellName)
    HealBot_RangeSpells[key]=spellName
end

function HealBot_Range_Spell(key)
    return HealBot_RangeSpells[key]
end

function HealBot_Range_SetSpells()
      --HealBot_setCall("HealBot_Range_SetSpells")
    local x=HealBot_GetBandageType() or HEALBOT_LINEN_BANDAGE
    local y=GetInventoryItemID("player", INVSLOT_MAINHAND) or HEALBOT_WORDS_UNKNOWN
    if y~=HEALBOT_WORDS_UNKNOWN then y=HealBot_WoWAPI_ItemInfo(y) or y end
    if (HealBot_RangeSpells["HEAL"] or HEALBOT_WORDS_UNKNOWN) == HEALBOT_WORDS_UNKNOWN then HealBot_RangeSpells["HEAL"]=x end
    if (HealBot_RangeSpells["HARM"] or HEALBOT_WORDS_UNKNOWN) == HEALBOT_WORDS_UNKNOWN then HealBot_RangeSpells["HARM"]=y end
    if (HealBot_RangeSpells["HEAL30"] or HEALBOT_WORDS_UNKNOWN) == HEALBOT_WORDS_UNKNOWN then HealBot_RangeSpells["HEAL30"]=x end
    if (HealBot_RangeSpells["HARM30"] or HEALBOT_WORDS_UNKNOWN) == HEALBOT_WORDS_UNKNOWN then HealBot_RangeSpells["HARM30"]=y end

    local sName=""
    local HealBot_Keys_List=HealBot_Action_retComboKeysList()
    for y=1, getn(HealBot_Keys_List), 1 do
        sName=HealBot_Action_GetSpell("ENABLED", HealBot_Action_GetCombo(HealBot_Keys_List[y], "Left"))
        if not sName or not HealBot_Spell_Names[sName] then
            sName=HealBot_RangeSpells["HEAL"]
        end
        HealBot_RangeSpellsKeysFriendly[HealBot_Keys_List[y]]=sName
        sName=HealBot_Action_GetSpell("ENEMY", HealBot_Action_GetCombo(HealBot_Keys_List[y], "Left"))
        if not sName or not HealBot_Spell_Names[sName] then
            sName=HealBot_RangeSpells["HARM"]
        end
        HealBot_RangeSpellsKeysEnemy[HealBot_Keys_List[y]]=sName
    end
    hbPhaseShift=HealBot_WoWAPI_SpellName(HBC_PHASE_SHIFT)
end

local function HealBot_Range_ButtonSpellUpdate(button, rangespell)
      --HealBot_setCall("HealBot_Range_ButtonSpellUpdate", button)
    if button.status.hostile then
        button.status.rangespell=HealBot_RangeSpellsKeysEnemy[HealBot_Range_luVars["CurrentModKey"]]
    else
        button.status.rangespell=rangespell or HealBot_RangeSpellsKeysFriendly[HealBot_Range_luVars["CurrentModKey"]]
    end
end

local prevRangeSpell=""
function HealBot_Range_ButtonSpell(button, rangespell)
      --HealBot_setCall("HealBot_Range_ButtonSpell", button)
    prevRangeSpell=button.status.rangespell
    HealBot_Range_ButtonSpellUpdate(button, rangespell)
    if prevRangeSpell~=button.status.rangespell then
        HealBot_Range_UpdateUnit(button)
    end
end

local hbInPhase, hbPhaseShift=true,""
function HealBot_Range_UnitInPhase(unit, guid)
      --HealBot_setCall("HealBot_Range_UnitInPhase", button)
    if HEALBOT_GAME_VERSION<9 then
        if not HealBot_Data["UILOCK"] and HealBot_Aura_CurrentBuff(guid, hbPhaseShift) then
            hbInPhase=false
        else
            hbInPhase=UnitInPhase(unit)
        end
    elseif (UnitPhaseReason(unit) or 2)~=2 then
        hbInPhase=false
    else
        hbInPhase=true
    end
    return hbInPhase
end

function HealBot_Range_WarnInRange(button, spellName, warnRange)
    if warnRange == 3 then
        if HealBot_Range_SpellInRange(button, spellName) then
            return true
        else
            return false
        end
    elseif warnRange == 1 then
        return true
    elseif button.status.range>-1 then
        return true
    else
        return false
    end
end

local sRange=0
local function HealBot_Range_IsSpellInRange(button, spellName, limit, spellOnly)
    sRange=HealBot_WoWAPI_SpellInRange(spellName, button.unit)
    if sRange then
        if type(sRange) ~= "number" then sRange=1 end
        if sRange == 1 and HealBot_Spell_Names[spellName] and HealBot_Spell_IDs[HealBot_Spell_Names[spellName]].range<31 then
            sRange=2
        end
        return sRange
    elseif not spellOnly and HealBot_Range_Unit(button.unit, button.guid, limit) then
        return 1
    end
    return 0
end

local rSpellId=0
function HealBot_Range_SpellInRange(button, spellName)
    if button.player then
        return true
    elseif UnitIsVisible(button.unit) then
        spellName=spellName or HealBot_Range_Spell("HEAL")
        rSpellId=HealBot_Spell_Names[spellName]
        if rSpellId and HealBot_Spell_IDs[rSpellId].range then
            if HealBot_Spell_IDs[rSpellId].range>0 then
                if (HealBot_Spell_IDs[rSpellId].range>45 and button.status.range>-1) or
                   (HealBot_Spell_IDs[rSpellId].range>35 and button.status.range>0) or
                   (HealBot_Spell_IDs[rSpellId].range>25 and button.status.range>1) then
                    return true
                end
            end
            if HealBot_Range_IsSpellInRange(button, spellName, true, true)>0 then
                return true
            else
                return false
            end
        elseif button.status.range<1 or HealBot_Range_IsSpellInRange(button, spellName, false)<1 then
            return false
        else
            return true
        end
    else
        return false
    end
end

function HealBot_Range_InteractDistance(unit, range)
    if (not HealBot_Data["UILOCK"] or UnitIsEnemy(unit,"player")) and CheckInteractDistance(unit, range) then
        return true
    else
        return false
    end
end

local inRange, checkedRange=false,false
function HealBot_Range_Unit(unit, guid, limit)
    inRange, checkedRange=UnitInRange(unit)
    if checkedRange then
        return inRange
    elseif not limit then
        if not UnitIsVisible(unit) or not HealBot_Range_UnitInPhase(unit, guid) then
            return false
        elseif HealBot_Range_InteractDistance(unit, 1) then
            return true
        end
    end
    return false
end

function HealBot_Range_UnitGUID(unit)
    aButton=HealBot_Panel_AllButton(UnitGUID(unit) or "x")
    if aButton then
        return HealBot_Range_Unit(aButton.unit, aButton.guid)
    else
        return HealBot_Range_Unit(unit, UnitGUID(unit))
    end
end

local uRange=0
function HealBot_Range_UnitCurrent(button, spellName)
      --HealBot_setCall("HealBot_Range_UnitCurrent", button)
    if not UnitIsVisible(button.unit) then
        uRange=-1
    elseif not HealBot_Range_UnitInPhase(button.unit, button.guid) then
        uRange=-2
    elseif HealBot_Range_InteractDistance(button.unit, 1) then
        uRange=2
    elseif spellName and HealBot_Spell_Names[spellName] then
        uRange=HealBot_Range_IsSpellInRange(button, spellName, true)
    elseif HealBot_Range_Unit(button.unit, button.guid, true) then
        uRange=1
    else
        uRange=0
    end
    return uRange
end

local oldRange,newRange=-99,-98
function HealBot_Range_UpdateUnit(button)
      --HealBot_setCall("HealBot_Range_UpdateUnit", button)
    if button.player then
        button.status.range=2
    elseif button.status.current<HealBot_Unit_Status["DC"] then
        newRange=HealBot_Range_UnitCurrent(button, button.status.rangespell)
        if newRange~=button.status.range then
            oldRange=button.status.range
            button.status.range=newRange
            if button.status.enabled or button.status.range>0 or oldRange>0 then
                HealBot_Update_AuxRange(button)
                HealBot_RefreshUnit(button)
                HealBot_Update_TextPlayersAlphaButtonNow(button)
                if button.status.range<0 or oldRange<0 then
                    HealBot_HealsInUpdate(button)
                    HealBot_AbsorbsUpdate(button)
                end
                HealBot_Action_AdaptiveOORUpdate(button)
                HealBot_Update_InRangeBar(button)
                HealBot_Update_PluginsChange(button)
                if button.status.dirarrowshown>0 or (hbv_Skins_GetFrameBoolean("Icons", "SHOWDIR", button.frame) and button.status.range == 0) then
                    HealBot_Action_ShowDirectionArrow(button)
                end
                if HealBot_Emerg_Button[button.id].state>0 then
                    HealBot_Action_EmergBarCheck(button, true)
                end
                if button.status.isdead then
                    HealBot_Text_UpdateButton(button)
                end
                if HealBot_Text_TagInUse(button.framecol, "OOR") then
                    HealBot_Text_setNameTag(button)
                end
                if hbv_Skins_GetFrameBoolean("BarSort", "OORLAST", button.frame) then
                    if button.status.unittype<20 then
                        HealBot_Timers_Set("OOC","RefreshPartyNextRecalcPlayers")
                    elseif button.status.unittype<30 then
                        HealBot_Timers_Set("OOC","RefreshPartyNextRecalcPets")
                    end
                end
                HealBot_Action_UpdateHotBar(button)
                HealBot_Action_UpdateGroupHealth(button)
                if button.frame<10 then
                    if button.aura.buff.name then
                        HealBot_Aura_BuffWarnings(button, button.aura.buff.name, true)
                    end
                    if button.aura.debuff.name then
                        HealBot_Aura_DebuffWarnings(button, button.aura.debuff.name, true, 0)
                    end
                end
            end
            if hbRangeRequests[button.guid] and button.status.range>-1 then
                HealBot_Plugin_Requests_CancelGUID(button.guid)
                hbRangeRequests[button.guid]=nil
            end
            if HealBot_Range_luVars["pluginAuraWatch"] then
                HealBot_Plugin_AuraWatch_RangeUpdate(button)
            end
            if hbActionIconsInRange[button.guid] then
                HealBot_ActionIcons_UpdateRange(button)
            end
            if button.mouseover and HealBot_Data["TIPBUTTON"] then
                HealBot_setTooltipUpdateNow()
            end
        end
    else
        button.status.range=-3
    end
end

function HealBot_Range_ActionIcons(guid, state)
      --HealBot_setCall("HealBot_Range_ActionIcons", nil, guid)
    if state then
        hbActionIconsInRange[guid]=true
    else
        hbActionIconsInRange[guid]=nil
    end
end

function HealBot_Range_Requests(guid, state)
      --HealBot_setCall("HealBot_Requests", nil, guid)
    if state then
        hbRangeRequests[guid]=true
    else
        hbRangeRequests[guid]=nil
    end
end

function HealBot_Range_RequestsClearButton(button)
      --HealBot_setCall("HealBot_Range_RequestsClearButton", button)
    if button.request.colbar>0 then
        if button.request.colbar == 4 then
            HealBot_Action_DisableBorderHazardType(button, "PLUGIN")
        elseif button.request.colbar == 5 then
            HealBot_Action_DisableButtonGlowType(button, "PLUGIN", "R")
        end
        button.request.colbar=0
        HealBot_Action_UpdateRequestButton(button)
    end
end

function HealBot_Range_RequestsClear()
      --HealBot_setCall("HealBot_RequestsClear")
    hbRangeRequests={}
    for _,xButton in pairs(HealBot_Unit_Button) do
        HealBot_Range_RequestsClearButton(xButton)
    end
    for _,xButton in pairs(HealBot_Private_Button) do
        HealBot_Range_RequestsClearButton(xButton)
    end
end

local gucUIMapID, gucPos=false,false
local function HealBot_Range_getUnitCoords(unit)
      --HealBot_setCall("HealBot_Range_getUnitCoords", nil, nil, unit)
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

local hbPi=math.pi
local hbaTan2=math.atan2
local hbdMod=108 / math.pi / 2;
local dcDirection, dcX, dcY=false,false,false
local dcPlayerX, dcPlayerY, dcPlayerFacing=false, false, false
local dcUnitX, dcUnitY=false,false
function HealBot_Range_DirectionCheck(unit)
      --HealBot_setCall("HealBot_Range_DirectionCheck", nil, nil, unit)
    dcDirection, dcX, dcY=false,false,false
    dcPlayerX, dcPlayerY=HealBot_Range_getUnitCoords("player")
    if dcPlayerX then
        dcUnitX, dcUnitY=HealBot_Range_getUnitCoords(unit)
        if dcUnitX then
            dcPlayerFacing=GetPlayerFacing();
            if dcPlayerFacing then
                dcPlayerFacing=dcPlayerFacing < 0 and dcPlayerFacing + hbPi * 2 or dcPlayerFacing;
                dcDirection=hbPi - hbaTan2(dcPlayerX - dcUnitX, dcUnitY - dcPlayerY) - dcPlayerFacing;
                dcDirection=floor(dcDirection * hbdMod + 0.5) % 108
                dcX, dcY=(dcDirection % 9) * 0.109375, floor(dcDirection / 9) * 0.08203125;
            end
        end
    end
    return dcX, dcY, dcDirection;
end

function HealBot_Range_ClearGUID(guid)
    hbRangeRequests[guid]=nil
    hbActionIconsInRange[guid]=nil
end