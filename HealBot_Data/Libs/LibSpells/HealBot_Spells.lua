local ksName=false
local ksID=0
function HealBot_Spells_KnownByID(spellID)
      --HealBot_setCall("HealBot_KnownSpell")
    --if not spellID then return nil end
    if HealBot_Spell_IDs[spellID] then   
        return HealBot_Spell_IDs[spellID].name; 
    else
        ksName=HealBot_WoWAPI_SpellName(spellID) or false
        if ksName and HealBot_Spells_KnownByName(ksName) then
            return ksName
        end
    end
    return nil;
end

function HealBot_Spells_KnownByName(spellName)
    if spellName then
        if HEALBOT_GAME_VERSION == 1 then
            ksID=HealBot_WoWAPI_SpellId(spellName)
            if string.find((HealBot_WoWAPI_SpellName(ksID) or "x")," Rune Ability") then
                return spellName
            else
                return HealBot_Spell_Names[spellName] or HealBot_Init_knownClassicHealSpell(spellName) or ksID
            end
        elseif HealBot_Config.CurrentSpec == 4 and HealBot_Data["PCLASSTRIM"] == "DRUI" and spellName == HEALBOT_REMOVE_CORRUPTION then
            return nil
        else
            return HealBot_Spell_Names[spellName] or HealBot_WoWAPI_SpellId(spellName)
        end
    else
        return nil
    end
end

function HealBot_Spells_Reset(pClassTrim)
      --HealBot_setCall("HealBot_Spells_Reset")
    HealBot_Config_Spells.EnabledKeyCombo={}
    HealBot_Config_Spells.EnemyKeyCombo={}
    HealBot_Config_Spells.EnabledSpellTarget={}
    HealBot_Config_Spells.EnemySpellTarget={}
    HealBot_Config_Spells.EmergSpellTarget={}
    HealBot_Config_Spells.EnabledSpellTrinket1={}
    HealBot_Config_Spells.EnemySpellTrinket1={}
    HealBot_Config_Spells.EmergSpellTrinket1={}
    HealBot_Config_Spells.EnabledSpellTrinket2={}
    HealBot_Config_Spells.EnemySpellTrinket2={}
    HealBot_Config_Spells.EmergSpellTrinket2={}
    HealBot_Config_Spells.EnabledAvoidBlueCursor={}
    HealBot_Config_Spells.EnemyAvoidBlueCursor={}
    HealBot_Config_Spells.EmergAvoidBlueCursor={}
    local bandage=HealBot_GetBandageType() or ""
    local x=""
    if pClassTrim == "DRUI" then
        HealBot_Action_SetSpell("ENABLED", "Left", HealBot_WoWAPI_SpellName(HEALBOT_REGROWTH))
        HealBot_Action_SetSpell("ENABLED", "CtrlLeft", HealBot_WoWAPI_SpellName(HEALBOT_REMOVE_CORRUPTION))
        HealBot_Action_SetSpell("ENABLED", "Right", HealBot_WoWAPI_SpellName(HEALBOT_HEALING_TOUCH))
        HealBot_Action_SetSpell("ENABLED", "CtrlRight", HealBot_WoWAPI_SpellName(HEALBOT_NATURES_CURE))
        if HealBot_Spells_KnownByName(HEALBOT_NATURES_CURE) then
            HealBot_Action_SetSpell("ENABLED", "CtrlRight", HealBot_WoWAPI_SpellName(HEALBOT_NATURES_CURE))
        elseif HealBot_Spells_KnownByName(HEALBOT_IMPROVED_NATURES_CURE) then
            HealBot_Action_SetSpell("ENABLED", "CtrlRight", HealBot_WoWAPI_SpellName(HEALBOT_IMPROVED_NATURES_CURE))
        end
        HealBot_Action_SetSpell("ENABLED", "Middle", HealBot_WoWAPI_SpellName(HEALBOT_REJUVENATION))
        HealBot_Action_SetSpell("ENABLED", "CtrlMiddle", HealBot_WoWAPI_SpellName(HEALBOT_NOURISH))
        HealBot_Action_SetSpell("ENABLED", "CtrlMiddle", HealBot_WoWAPI_SpellName(HBC_NOURISH))
    elseif pClassTrim == "MONK" then
        HealBot_Action_SetSpell("ENABLED", "Left", HealBot_WoWAPI_SpellName(HEALBOT_SOOTHING_MIST))
        HealBot_Action_SetSpell("ENABLED", "ShiftLeft", HealBot_WoWAPI_SpellName(HEALBOT_SURGING_MIST))
        HealBot_Action_SetSpell("ENABLED", "ShiftRight", HealBot_WoWAPI_SpellName(HEALBOT_REVIVAL))
        HealBot_Action_SetSpell("ENABLED", "CtrlLeft", HealBot_WoWAPI_SpellName(HEALBOT_DETOX))
        HealBot_Action_SetSpell("ENABLED", "Right", HealBot_WoWAPI_SpellName(HEALBOT_SOOTHING_MIST))
        HealBot_Action_SetSpell("ENABLED", "Middle", HealBot_WoWAPI_SpellName(HEALBOT_RENEWING_MIST))
        HealBot_Action_SetSpell("ENABLED", "ShiftMiddle", HealBot_WoWAPI_SpellName(HEALBOT_UPLIFT))
        HealBot_Action_SetSpell("ENABLED", "CtrlMiddle", HealBot_WoWAPI_SpellName(HEALBOT_LIFE_COCOON))
        HealBot_Action_SetSpell("ENABLED", "AltMiddle", HealBot_WoWAPI_SpellName(HEALBOT_ZEN_MEDITATION))
    elseif pClassTrim == "EVOK" then
        HealBot_Action_SetSpell("ENABLED", "Left", HealBot_WoWAPI_SpellName(HEALBOT_LIVING_FLAME))
        HealBot_Action_SetSpell("ENABLED", "ShiftLeft", HealBot_WoWAPI_SpellName(HEALBOT_REVERSION))
        HealBot_Action_SetSpell("ENABLED", "ShiftRight", HealBot_WoWAPI_SpellName(HEALBOT_REWIND))
        HealBot_Action_SetSpell("ENABLED", "CtrlLeft", HealBot_WoWAPI_SpellName(HEALBOT_NATURALIZE))
        HealBot_Action_SetSpell("ENABLED", "CtrlRight", HealBot_WoWAPI_SpellName(HEALBOT_CAUTERIZING_FLAME))
        HealBot_Action_SetSpell("ENABLED", "Right", HealBot_WoWAPI_SpellName(HEALBOT_SPIRITBLOOM))
        HealBot_Action_SetSpell("ENABLED", "Middle", HealBot_WoWAPI_SpellName(HEALBOT_ECHO))
        HealBot_Action_SetSpell("ENABLED", "ShiftMiddle", HealBot_WoWAPI_SpellName(HEALBOT_EMERALD_BLOSSOM))
    elseif pClassTrim == "PALA" then
        HealBot_Action_SetSpell("ENABLED", "Left", HealBot_WoWAPI_SpellName(HEALBOT_FLASH_OF_LIGHT))
        HealBot_Action_SetSpell("ENABLED", "ShiftRight", HealBot_WoWAPI_SpellName(HEALBOT_LIGHT_OF_DAWN))
        HealBot_Action_SetSpell("ENABLED", "CtrlLeft", HealBot_WoWAPI_SpellName(HEALBOT_CLEANSE))
        HealBot_Action_SetSpell("ENABLED", "Middle", HealBot_WoWAPI_SpellName(HEALBOT_WORD_OF_GLORY))
        HealBot_Action_SetSpell("ENABLED", "ShiftMiddle", HealBot_WoWAPI_SpellName(HEALBOT_HOLY_RADIANCE))
        if HEALBOT_GAME_VERSION>3 then
            HealBot_Action_SetSpell("ENABLED", "Right", HealBot_WoWAPI_SpellName(HEALBOT_HOLY_LIGHT))
        else
            HealBot_Action_SetSpell("ENABLED", "Right", HealBot_WoWAPI_SpellName(HBC_HOLY_LIGHT))
        end
    elseif pClassTrim == "PRIE" then
        HealBot_Action_SetSpell("ENABLED", "Left", HealBot_WoWAPI_SpellName(HEALBOT_FLASH_HEAL))
        HealBot_Action_SetSpell("ENABLED", "ShiftLeft", HealBot_WoWAPI_SpellName(HEALBOT_BINDING_HEAL))
        HealBot_Action_SetSpell("ENABLED", "CtrlLeft", HealBot_WoWAPI_SpellName(HEALBOT_PURIFY))
        if HEALBOT_GAME_VERSION>3 or HealBot_Data["PLEVEL"]<40 then
            HealBot_Action_SetSpell("ENABLED", "ShiftRight", HealBot_WoWAPI_SpellName(HEALBOT_HOLY_WORD_SERENITY))
        else
            HealBot_Action_SetSpell("ENABLED", "ShiftRight", HealBot_WoWAPI_SpellName(HBC_HEAL))
        end
        if HEALBOT_GAME_VERSION>3 then
            HealBot_Action_SetSpell("ENABLED", "CtrlRight", HealBot_WoWAPI_SpellName(HEALBOT_MASS_DISPEL))
        else
            HealBot_Action_SetSpell("ENABLED", "CtrlRight", HealBot_WoWAPI_SpellName(HBC_PRIEST_ABOLISH_DISEASE))
        end
        HealBot_Action_SetSpell("ENABLED", "Middle", HealBot_WoWAPI_SpellName(HEALBOT_RENEW))
        HealBot_Action_SetSpell("ENABLED", "ShiftMiddle", HealBot_WoWAPI_SpellName(HEALBOT_PRAYER_OF_MENDING))
        HealBot_Action_SetSpell("ENABLED", "AltMiddle", HealBot_WoWAPI_SpellName(HEALBOT_PRAYER_OF_HEALING))
        HealBot_Action_SetSpell("ENABLED", "CtrlMiddle", HealBot_WoWAPI_SpellName(HEALBOT_DIVINE_HYMN))
        if HEALBOT_GAME_VERSION>3 or HealBot_Data["PLEVEL"]>39 then
            HealBot_Action_SetSpell("ENABLED", "Right", HealBot_WoWAPI_SpellName(HEALBOT_HEAL))
        else
            HealBot_Action_SetSpell("ENABLED", "Right", HealBot_WoWAPI_SpellName(HBC_HEAL))
        end
    elseif pClassTrim == "SHAM" then
        if HealBot_Config.CurrentSpec == 3 then
            x=HealBot_WoWAPI_SpellName(HEALBOT_PURIFY_SPIRIT);
        else
            x=HealBot_WoWAPI_SpellName(HEALBOT_CLEANSE_SPIRIT);
        end
        HealBot_Action_SetSpell("ENABLED", "Right", HealBot_WoWAPI_SpellName(HEALBOT_HEALING_SURGE))
        HealBot_Action_SetSpell("ENABLED", "Middle", HealBot_WoWAPI_SpellName(HEALBOT_HEALING_RAIN))
        HealBot_Action_SetSpell("ENABLED", "CtrlLeft", x)
        HealBot_Action_SetSpell("ENABLED", "CtrlRight", x)
        HealBot_Action_SetSpell("ENABLED", "ShiftLeft", HealBot_WoWAPI_SpellName(HEALBOT_CHAIN_HEAL))
        HealBot_Action_SetSpell("ENABLED", "ShiftMiddle", HealBot_WoWAPI_SpellName(HEALBOT_HEALING_STREAM_TOTEM))
        if HEALBOT_GAME_VERSION>3 then
            HealBot_Action_SetSpell("ENABLED", "Left", HealBot_WoWAPI_SpellName(HEALBOT_HEALING_WAVE))
        else
            HealBot_Action_SetSpell("ENABLED", "Left", HealBot_WoWAPI_SpellName(HBC_HEALING_WAVE))
        end
    elseif pClassTrim == "MAGE" then
        HealBot_Action_SetSpell("ENABLED", "Left", HealBot_WoWAPI_SpellName(HEALBOT_REMOVE_CURSE))
    end
    HealBot_Action_SetSpell("ENABLED", "ShiftButton4", HEALBOT_DISABLED_TARGET)
    HealBot_Action_SetSpell("ENABLED", "ShiftButton5", HEALBOT_ASSIST)
    HealBot_Action_SetSpell("ENABLED", "Button4", HEALBOT_MENU)
    HealBot_Action_SetSpell("ENABLED", "Button5", HEALBOT_HBMENU)
end

function HealBot_Spells_ResetCures(pClassTrim)
      --HealBot_setCall("HealBot_Spells_ResetCures")
    HealBot_Config_Cures.HealBotDebuffText={[1]=HEALBOT_WORDS_NONE,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE,[4]=HEALBOT_WORDS_NONE}
    HealBot_Config_Cures.HealBotDebuffDropDown={[1]=4,[2]=4,[3]=4,[4]=4}
    local i=1
    if pClassTrim == "DRUI" then
        if HEALBOT_GAME_VERSION<4 then
            if HealBot_Spells_KnownByName(HBC_DRUID_REMOVE_CURSE) then
                HealBot_Config_Cures.HealBotDebuffText[i]=HBC_DRUID_REMOVE_CURSE
                i=i+1
            end
            if HealBot_Spells_KnownByName(HBC_DRUID_ABOLISH_POISON) then
                HealBot_Config_Cures.HealBotDebuffText[i]=HBC_DRUID_ABOLISH_POISON
            elseif HealBot_Spells_KnownByName(HBC_DRUID_CURE_POISON) then
                HealBot_Config_Cures.HealBotDebuffText[i]=HBC_DRUID_CURE_POISON
            end
        else
            if HealBot_Spells_KnownByName(HEALBOT_NATURES_CURE) then
                if HealBot_Spells_KnownByName(HEALBOT_REMOVE_CORRUPTION) then
                    HealBot_Config_Cures.HealBotDebuffText={[1]=HEALBOT_REMOVE_CORRUPTION,[2]=HEALBOT_NATURES_CURE,[3]=HEALBOT_WORDS_NONE}
                else
                    HealBot_Config_Cures.HealBotDebuffText={[1]=HEALBOT_NATURES_CURE,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
                end
            elseif HealBot_Spells_KnownByName(HEALBOT_IMPROVED_NATURES_CURE) then
                if HealBot_Spells_KnownByName(HEALBOT_REMOVE_CORRUPTION) then
                    HealBot_Config_Cures.HealBotDebuffText={[1]=HEALBOT_REMOVE_CORRUPTION,[2]=HEALBOT_IMPROVED_NATURES_CURE,[3]=HEALBOT_WORDS_NONE}
                else
                    HealBot_Config_Cures.HealBotDebuffText={[1]=HEALBOT_IMPROVED_NATURES_CURE,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
                end
            elseif HealBot_Spells_KnownByName(HEALBOT_REMOVE_CORRUPTION) then
                HealBot_Config_Cures.HealBotDebuffText={[1]=HEALBOT_REMOVE_CORRUPTION,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
            end
        end
    elseif pClassTrim == "MONK" then
        if HealBot_Spells_KnownByName(HEALBOT_DETOX) then
            HealBot_Config_Cures.HealBotDebuffText={[1]=HEALBOT_DETOX,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
        end
    elseif pClassTrim == "PALA" then
        if HEALBOT_GAME_VERSION<4 then
            if HealBot_Spells_KnownByName(HEALBOT_CLEANSE) then
                HealBot_Config_Cures.HealBotDebuffText[i]=HEALBOT_CLEANSE
                i=i+1
            end
            if HealBot_Spells_KnownByName(HBC_PURIFY) then
                HealBot_Config_Cures.HealBotDebuffText[i]=HBC_PURIFY
            end
        else
            if HealBot_Spells_KnownByName(HEALBOT_CLEANSE) then
                HealBot_Config_Cures.HealBotDebuffText={[1]=HEALBOT_CLEANSE,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
            elseif HealBot_Spells_KnownByName(HEALBOT_CLEANSE_TOXIN) then
                HealBot_Config_Cures.HealBotDebuffText={[1]=HEALBOT_CLEANSE_TOXIN,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
            end
        end
    elseif pClassTrim == "PRIE" then
        if HealBot_Spells_KnownByName(HEALBOT_PURIFY) then
            if HealBot_Spells_KnownByName(HBC_PRIEST_ABOLISH_DISEASE) then
                HealBot_Config_Cures.HealBotDebuffText={[1]=HEALBOT_PURIFY,[2]=HBC_PRIEST_ABOLISH_DISEASE,[3]=HEALBOT_WORDS_NONE}
            elseif HealBot_Spells_KnownByName(HEALBOT_MASS_DISPEL) then
                if HealBot_Spells_KnownByName(HEALBOT_PURIFY_DISEASE) then
                    HealBot_Config_Cures.HealBotDebuffText={[1]=HEALBOT_PURIFY,[2]=HEALBOT_MASS_DISPEL,[3]=HEALBOT_PURIFY_DISEASE}
                else
                    HealBot_Config_Cures.HealBotDebuffText={[1]=HEALBOT_PURIFY,[2]=HEALBOT_MASS_DISPEL,[3]=HEALBOT_WORDS_NONE}
                end
            elseif HealBot_Spells_KnownByName(HEALBOT_PURIFY_DISEASE) then
                HealBot_Config_Cures.HealBotDebuffText={[1]=HEALBOT_PURIFY,[2]=HEALBOT_PURIFY_DISEASE,[3]=HEALBOT_WORDS_NONE}
            else
                HealBot_Config_Cures.HealBotDebuffText={[1]=HEALBOT_PURIFY,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
            end
        elseif HealBot_Spells_KnownByName(HEALBOT_MASS_DISPEL) then
            if HealBot_Spells_KnownByName(HEALBOT_PURIFY_DISEASE) then
                HealBot_Config_Cures.HealBotDebuffText={[1]=HEALBOT_MASS_DISPEL,[2]=HEALBOT_PURIFY_DISEASE,[3]=HEALBOT_WORDS_NONE}
            else
                HealBot_Config_Cures.HealBotDebuffText={[1]=HEALBOT_MASS_DISPEL,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
            end
        elseif HealBot_Spells_KnownByName(HEALBOT_PURIFY_DISEASE) then
            HealBot_Config_Cures.HealBotDebuffText={[1]=HEALBOT_PURIFY_DISEASE,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
        end
    elseif pClassTrim == "SHAM" then
        if HEALBOT_GAME_VERSION<3 then
            if HealBot_Spells_KnownByName(HBC_SHAMAN_CURE_POISON) then
                if HealBot_Spells_KnownByName(HBC_SHAMAN_CURE_DISEASE) then
                    HealBot_Config_Cures.HealBotDebuffText={[1]=HBC_SHAMAN_CURE_POISON,[2]=HBC_SHAMAN_CURE_DISEASE,[3]=HEALBOT_WORDS_NONE}
                else
                    HealBot_Config_Cures.HealBotDebuffText={[1]=HBC_SHAMAN_CURE_POISON,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
                end
            elseif HealBot_Spells_KnownByName(HBC_SHAMAN_CURE_DISEASE) then
                HealBot_Config_Cures.HealBotDebuffText={[1]=HBC_SHAMAN_CURE_DISEASE,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
            end
        elseif HEALBOT_GAME_VERSION<4 then
            if HealBot_Spells_KnownByName(HBC_SHAMAN_CURE_POISON) then
                if HealBot_Spells_KnownByName(HEALBOT_CLEANSE_SPIRIT) then
                    HealBot_Config_Cures.HealBotDebuffText={[1]=HBC_SHAMAN_CURE_POISON,[2]=HEALBOT_CLEANSE_SPIRIT,[3]=HEALBOT_WORDS_NONE}
                else
                    HealBot_Config_Cures.HealBotDebuffText={[1]=HBC_SHAMAN_CURE_POISON,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
                end
            elseif HealBot_Spells_KnownByName(HEALBOT_CLEANSE_SPIRIT) then
                HealBot_Config_Cures.HealBotDebuffText={[1]=HEALBOT_CLEANSE_SPIRIT,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
            end
        else
            if HealBot_Spells_KnownByName(HEALBOT_PURIFY_SPIRIT) then
                HealBot_Config_Cures.HealBotDebuffText={[1]=HEALBOT_PURIFY_SPIRIT,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
            elseif HealBot_Spells_KnownByName(HEALBOT_CLEANSE_SPIRIT) then
                HealBot_Config_Cures.HealBotDebuffText={[1]=HEALBOT_CLEANSE_SPIRIT,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
            end
        end
    elseif pClassTrim == "MAGE" then
        if HealBot_Spells_KnownByName(HEALBOT_REMOVE_CURSE) then
            HealBot_Config_Cures.HealBotDebuffText={[1]=HEALBOT_REMOVE_CURSE,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
        end
    elseif pClassTrim == "EVOK" then
        if HealBot_Spells_KnownByName(HEALBOT_NATURALIZE) then
            if HealBot_Spells_KnownByName(HEALBOT_CAUTERIZING_FLAME) then
                HealBot_Config_Cures.HealBotDebuffText={[1]=HEALBOT_NATURALIZE,[2]=HEALBOT_CAUTERIZING_FLAME,[3]=HEALBOT_WORDS_NONE}
            else
                HealBot_Config_Cures.HealBotDebuffText={[1]=HEALBOT_NATURALIZE,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
            end
        elseif HealBot_Spells_KnownByName(HEALBOT_EXPUNGE) then
            HealBot_Config_Cures.HealBotDebuffText={[1]=HEALBOT_EXPUNGE,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE}
        end
    end
end

function HealBot_Spells_ResetBuffs(pClassTrim)
      --HealBot_setCall("HealBot_Spells_ResetBuffs")
    HealBot_Config_Buffs.HealBotBuffText={[1]=HEALBOT_WORDS_NONE,[2]=HEALBOT_WORDS_NONE,[3]=HEALBOT_WORDS_NONE,[4]=HEALBOT_WORDS_NONE,[5]=HEALBOT_WORDS_NONE,
                                      [6]=HEALBOT_WORDS_NONE,[7]=HEALBOT_WORDS_NONE,[8]=HEALBOT_WORDS_NONE,[9]=HEALBOT_WORDS_NONE,[10]=HEALBOT_WORDS_NONE}
    HealBot_Config_Buffs.HealBotBuffDropDown={[1]=4,[2]=4,[3]=4,[4]=4,[5]=4,[6]=4,[7]=4,[8]=4,[9]=2,[10]=2}
    if pClassTrim == "DRUI" then
        if HealBot_Spells_KnownByID(HEALBOT_MARK_OF_THE_WILD) then
            HealBot_Config_Buffs.HealBotBuffText[1]=HealBot_Spells_KnownByID(HEALBOT_MARK_OF_THE_WILD)
        end
        if HealBot_Spells_KnownByID(HBC_GIFT_OF_THE_WILD) then
            HealBot_Config_Buffs.HealBotBuffText[2]=HealBot_Spells_KnownByID(HBC_GIFT_OF_THE_WILD)
            HealBot_Config_Buffs.HealBotBuffDropDown[1]=2
        end
        if HealBot_Spells_KnownByID(HBC_THORNS) then
            HealBot_Config_Buffs.HealBotBuffText[3]=HealBot_Spells_KnownByID(HBC_THORNS)
            HealBot_Config_Buffs.HealBotBuffDropDown[3]=15
        end
    elseif pClassTrim == "MONK" then
        local i=1
        if HealBot_Spells_KnownByID(HEALBOT_LEGACY_EMPEROR) and HealBot_Config.CurrentSpec == 3 then
            HealBot_Config_Buffs.HealBotBuffText[1]=HealBot_Spells_KnownByID(HEALBOT_LEGACY_EMPEROR)
            i=i+1
        elseif HealBot_Spells_KnownByID(HEALBOT_LEGACY_WHITETIGER) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_Spells_KnownByID(HEALBOT_LEGACY_WHITETIGER)
        end
    elseif pClassTrim == "PALA" then
        local i=1
        if HealBot_Spells_KnownByID(HEALBOT_BLESSING_OF_KINGS) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_Spells_KnownByID(HEALBOT_BLESSING_OF_KINGS)
            HealBot_Config_Buffs.HealBotBuffDropDown[i]=1
            i=i+1
        elseif HealBot_Spells_KnownByID(HBC_GREATER_BLESSING_OF_KINGS) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_Spells_KnownByID(HBC_GREATER_BLESSING_OF_KINGS)
            HealBot_Config_Buffs.HealBotBuffDropDown[i]=1
            i=i+1
        elseif HealBot_Spells_KnownByID(HBC_BLESSING_OF_KINGS) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_Spells_KnownByID(HBC_BLESSING_OF_KINGS)
            HealBot_Config_Buffs.HealBotBuffDropDown[i]=1
            i=i+1
        end
        if HealBot_Spells_KnownByID(HEALBOT_BLESSING_OF_MIGHT) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_Spells_KnownByID(HEALBOT_BLESSING_OF_MIGHT)
            HealBot_Config_Buffs.HealBotBuffDropDown[i]=1
            i=i+1
        elseif HealBot_Spells_KnownByID(HBC_GREATER_BLESSING_OF_MIGHT) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_Spells_KnownByID(HBC_GREATER_BLESSING_OF_MIGHT)
            HealBot_Config_Buffs.HealBotBuffDropDown[i]=1
            i=i+1
        elseif HealBot_Spells_KnownByID(HBC_BLESSING_OF_MIGHT) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_Spells_KnownByID(HBC_BLESSING_OF_MIGHT)
            HealBot_Config_Buffs.HealBotBuffDropDown[i]=1
            i=i+1
        end
        if HealBot_Spells_KnownByID(HEALBOT_BLESSING_OF_WISDOM) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_Spells_KnownByID(HEALBOT_BLESSING_OF_WISDOM)
            HealBot_Config_Buffs.HealBotBuffDropDown[i]=1
        elseif HealBot_Spells_KnownByID(HBC_GREATER_BLESSING_OF_WISDOM) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_Spells_KnownByID(HBC_GREATER_BLESSING_OF_WISDOM)
            HealBot_Config_Buffs.HealBotBuffDropDown[i]=1
        elseif HealBot_Spells_KnownByID(HBC_BLESSING_OF_WISDOM) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_Spells_KnownByID(HBC_BLESSING_OF_WISDOM)
            HealBot_Config_Buffs.HealBotBuffDropDown[i]=1
        end
    elseif pClassTrim == "PRIE" then
        if HealBot_Spells_KnownByID(HBC_POWER_WORD_FORTITUDE) then
            HealBot_Config_Buffs.HealBotBuffText[1]=HealBot_Spells_KnownByID(HBC_POWER_WORD_FORTITUDE)
        elseif HealBot_Spells_KnownByID(HEALBOT_POWER_WORD_FORTITUDE) then
            HealBot_Config_Buffs.HealBotBuffText[1]=HealBot_Spells_KnownByID(HEALBOT_POWER_WORD_FORTITUDE)
        end
        local i=2
        if HealBot_Spells_KnownByID(HEALBOT_FEAR_WARD) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_Spells_KnownByID(HEALBOT_FEAR_WARD)
            HealBot_Config_Buffs.HealBotBuffDropDown[i]=15
            i=i+1
        end
        if HealBot_Spells_KnownByID(HBC_INNER_FIRE) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_Spells_KnownByID(HBC_INNER_FIRE)
            HealBot_Config_Buffs.HealBotBuffDropDown[i]=2
            i=i+1
        end
        if HealBot_Spells_KnownByID(HBC_INNER_WILL) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_Spells_KnownByID(HBC_INNER_WILL)
            HealBot_Config_Buffs.HealBotBuffDropDown[i]=2
            i=i+1
        end
        if HealBot_Spells_KnownByID(HBC_DIVINE_SPIRIT) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_Spells_KnownByID(HBC_DIVINE_SPIRIT)
            i=i+1
        end
        if HealBot_Spells_KnownByID(HBC_PRAYER_OF_SPIRIT) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_Spells_KnownByID(HBC_PRAYER_OF_SPIRIT)
            HealBot_Config_Buffs.HealBotBuffDropDown[i-1]=2
            i=i+1
        end
        if HealBot_Spells_KnownByID(HBC_SHADOW_PROTECTION) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_Spells_KnownByID(HBC_SHADOW_PROTECTION)
            i=i+1
        elseif HealBot_Spells_KnownByID(HEALBOT_SHADOW_PROTECTION) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_Spells_KnownByID(HEALBOT_SHADOW_PROTECTION)
            i=i+1
        end
        if HealBot_Spells_KnownByID(HBC_PRAYER_OF_SHADOW_PROTECTION) then
            HealBot_Config_Buffs.HealBotBuffText[i]=HealBot_Spells_KnownByID(HBC_PRAYER_OF_SHADOW_PROTECTION)
            HealBot_Config_Buffs.HealBotBuffDropDown[i-1]=2
            i=i+1
        end
    elseif pClassTrim == "SHAM" then
        if HealBot_Spells_KnownByID(HEALBOT_WATER_SHIELD) then
            HealBot_Config_Buffs.HealBotBuffText[1]=HealBot_Spells_KnownByID(HEALBOT_WATER_SHIELD)
            HealBot_Config_Buffs.HealBotBuffDropDown[1]=2
        end
        if HealBot_Spells_KnownByID(HEALBOT_EARTH_SHIELD) then
            HealBot_Config_Buffs.HealBotBuffText[2]=HealBot_Spells_KnownByID(HEALBOT_EARTH_SHIELD)
            HealBot_Config_Buffs.HealBotBuffDropDown[2]=15
        elseif HealBot_Spells_KnownByID(HBC_EARTH_SHIELD) then
            HealBot_Config_Buffs.HealBotBuffText[2]=HealBot_Spells_KnownByID(HBC_EARTH_SHIELD)
            HealBot_Config_Buffs.HealBotBuffDropDown[2]=15
        end
        if HealBot_Spells_KnownByID(HEALBOT_SPIRIT_OF_THE_ALPHA) then
            HealBot_Config_Buffs.HealBotBuffText[3]=HealBot_Spells_KnownByID(HEALBOT_SPIRIT_OF_THE_ALPHA)
            HealBot_Config_Buffs.HealBotBuffDropDown[3]=1
        end
    elseif pClassTrim == "MAGE" then
        if HealBot_Spells_KnownByID(HEALBOT_ARCANE_BRILLIANCE) then
            HealBot_Config_Buffs.HealBotBuffText[1]=HealBot_Spells_KnownByID(HEALBOT_ARCANE_BRILLIANCE)
        end
        if HealBot_Spells_KnownByID(HBC_ARCANE_BRILLIANCE) then
            HealBot_Config_Buffs.HealBotBuffText[2]=HealBot_Spells_KnownByID(HBC_ARCANE_BRILLIANCE)
            HealBot_Config_Buffs.HealBotBuffDropDown[1]=2
        end
    elseif pClassTrim == "WARR" then
        if HealBot_Spells_KnownByID(HEALBOT_COMMANDING_SHOUT) then
            HealBot_Config_Buffs.HealBotBuffText[1]=HealBot_Spells_KnownByID(HEALBOT_COMMANDING_SHOUT)
        end
        if HealBot_Spells_KnownByID(HEALBOT_VIGILANCE) then
            HealBot_Config_Buffs.HealBotBuffText[2]=HealBot_Spells_KnownByID(HEALBOT_VIGILANCE)
            HealBot_Config_Buffs.HealBotBuffDropDown[2]=2
        end
    elseif pClassTrim == "WARL" then
        if HealBot_Spells_KnownByID(HEALBOT_DARK_INTENT) then
            HealBot_Config_Buffs.HealBotBuffText[1]=HealBot_Spells_KnownByID(HEALBOT_DARK_INTENT)
        end
    elseif pClassTrim == "EVOK" then
    end
end

local hbDefaultBind=1
function HealBot_SpellBinds_GetData(id)
    if HealBot_Config_Spells.Binds then
        return HealBot_Config_Spells.Binds[id] or hbDefaultBind
    end
    return hbDefaultBind
end

function HealBot_SpellBinds_SetData(value, id)
    if hbDefaultBind == value then
        HealBot_SpellBinds_NilData(id)
    else
        if not HealBot_Config_Spells.Binds then HealBot_Config_Spells.Binds={} end
        HealBot_Config_Spells.Binds[id]=value
    end
end

function HealBot_SpellBinds_NilData(id)
    if HealBot_Config_Spells.Binds then
        HealBot_Config_Spells.Binds[id]=nil
        HealBot_Util_EmptyTable(HealBot_Config_Spells, Binds)
    end
end
