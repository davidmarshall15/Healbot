if not HEALBOT_FOREVER then return end

SLASH_HEALBOTFOREVER1="/hbforever"
SlashCmdList["HEALBOTFOREVER"]=function()
    local version, build, _, interface=GetBuildInfo()
    print("HealBot Forever: "..version.." ("..build.."), Interface "..interface)
    print("HealBot: "..tostring(C_AddOns.GetAddOnMetadata("HealBot", "Version")))
    local apis={
        {"C_Spell.GetSpellInfo", C_Spell and C_Spell.GetSpellInfo},
        {"C_SpellBook.GetSpellBookItemName", C_SpellBook and C_SpellBook.GetSpellBookItemName},
        {"C_UnitAuras.GetAuraDataByIndex", C_UnitAuras and C_UnitAuras.GetAuraDataByIndex},
        {"UnitHealthPercent", UnitHealthPercent},
        {"UnitPowerPercent", UnitPowerPercent},
        {"issecretvalue", issecretvalue},
        {"CreateUnitHealPredictionCalculator", CreateUnitHealPredictionCalculator},
        {"UnitGetDetailedHealPrediction", UnitGetDetailedHealPrediction},
    }
    for _, api in ipairs(apis) do
        print(api[1]..": "..(type(api[2])=="function" and "OK" or "MISSING"))
    end
    local spells=0
    for _ in pairs(HealBot_Spell_IDs or {}) do spells=spells+1 end
    print("Spells: "..spells.."; loaded: "..tostring(HealBot_retLuVars and HealBot_retLuVars("Loaded")))
    if HealBot_Forever_FrameDiagnostics then HealBot_Forever_FrameDiagnostics() end
end
