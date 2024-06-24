local ksName=false
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
        return HealBot_Spell_Names[spellName] or HealBot_Init_knownClassicHealSpell(spellName) or HealBot_WoWAPI_SpellInfo(spellName)
    else
        return nil
    end
end

