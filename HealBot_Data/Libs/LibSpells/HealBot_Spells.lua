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
        if HEALBOT_GAME_VERSION==1 then
            ksID=HealBot_WoWAPI_SpellId(spellName)
            if string.find((HealBot_WoWAPI_SpellName(ksID) or "x")," Rune Ability") then
                return spellName
            else
                return HealBot_Spell_Names[spellName] or HealBot_Init_knownClassicHealSpell(spellName) or ksID
            end
        else
            return HealBot_Spell_Names[spellName] or HealBot_WoWAPI_SpellId(spellName)
        end
    else
        return nil
    end
end
