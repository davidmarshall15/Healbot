local SmartCast_Res=nil;
local SmartCast_MassRes=nil;
local HealBot_Heal_Names={}
local HealBot_KnownHeal_Names={}
local HealBot_Spell_Ranks={}
local _
local MANA_COST_PATTERN = gsub(MANA_COST, "%%d", "([%%d%.,]+)")

function HealBot_Init_retSmartCast_Res()
    return SmartCast_Res
end

function HealBot_Init_retSmartCast_MassRes()
    return SmartCast_MassRes
end

function HealBot_Init_retFoundHealSpells()
    return HealBot_KnownHeal_Names
end

local cRank=false
function HealBot_Init_FindSpellRangeCast(id, spellName, spellBookId)

    if ( not id ) then return nil; end

    local spell, _, texture, msCast, _, _ = GetSpellInfo(id);
    if HEALBOT_GAME_VERSION<4 then 
        cRank = GetSpellSubtext(id)
    end
    if ( not spell ) then return nil; end
    if not spellName then spellName=spell end
   
    local hbMana=nil
    if spellBookId then
        HealBot_TooltipInit();
        HealBot_ScanTooltip:SetSpellBookItem(spellBookId, BOOKTYPE_SPELL);
        local ttText = getglobal("HealBot_ScanTooltipTextLeft2");
        if (ttText:GetText()) then
            line = ttText:GetText();
            if line then 
                hbMana = tonumber((gsub(line, "%D", "")))
            end
        end
    end

    local hbCastTime=tonumber(msCast or 0);
    if hbCastTime>999 then hbCastTime=HealBot_Comm_round(hbCastTime/1000,2) end
    
    HealBot_Spell_IDs[id]={}
    HealBot_Spell_IDs[id].CastTime=hbCastTime;
    HealBot_Spell_IDs[id].Mana=hbMana or 0
    HealBot_Spell_IDs[id].texture=texture
    return true
end

local skipSpells={}
function HealBot_Init_SkipSpells()
    skipSpells={[HEALBOT_BLESSING_OF_MIGHT]=true}
end

function HealBot_Init_Spells_addSpell(spellId, spellName, spellBookId)
    if not skipSpells[spellName] then
        if HealBot_Init_FindSpellRangeCast(spellId, spellName, spellBookId) then
            if HealBot_Heal_Names[spellName] and cRank then 
                HealBot_KnownHeal_Names[spellName]=true
                if not HealBot_Spell_Ranks[spellName] then
                    HealBot_Spell_Ranks[spellName]={}
                    HealBot_Spell_Ranks[spellName][0]=1
                else
                    HealBot_Spell_Ranks[spellName][0]=HealBot_Spell_Ranks[spellName][0]+1
                end
                local nRank=HealBot_Spell_Ranks[spellName][0]
                HealBot_Spell_Ranks[spellName][nRank]=strtrim(spellName).."("..cRank..")"
                spellName=strtrim(spellName).."("..cRank..")"
            end
            HealBot_Spell_IDs[spellId].name=spellName
            HealBot_Spell_IDs[spellId].known=IsSpellKnown(spellId)
            HealBot_Spell_Names[spellName]=spellId
        end
    end
end

function HealBot_Init_Spells_retRank(spellName, targetRank)
    local sName=spellName
    local sRank=targetRank
    if HealBot_Spell_Ranks[spellName] then
        if not HealBot_Spell_Ranks[spellName][targetRank] then
            sRank=HealBot_Spell_Ranks[spellName][0]
        end
        sName=HealBot_Spell_Ranks[spellName][sRank]
    end
    --HealBot_AddDebug("sName="..sName.." sRank="..sRank)
    return sName
end

function HealBot_Init_Spells_Defaults()
    for x,_ in pairs(HealBot_Spell_IDs) do
        HealBot_Spell_IDs[x]=nil
    end 
    for x,_ in pairs(HealBot_Spell_Names) do
        HealBot_Spell_Names[x]=nil
    end 
    for x,_ in pairs(HealBot_Heal_Names) do
        HealBot_Heal_Names[x]=nil
    end  
    for x,_ in pairs(HealBot_KnownHeal_Names) do
        HealBot_KnownHeal_Names[x]=nil
    end
    for x,_ in pairs(HealBot_Spell_Ranks) do
        HealBot_Spell_Ranks[x]=nil
    end
    local nTabs=GetNumSpellTabs()
    local hbHeallist=HealBot_Options_FullHealSpellsCombo_list(1)
    for j=1, getn(hbHeallist), 1 do
        if hbHeallist[j] and GetSpellInfo(hbHeallist[j]) then
            HealBot_Heal_Names[GetSpellInfo(hbHeallist[j])]=true
        end
    end
    HealBot_Init_SkipSpells()
    for j=1,nTabs do
        local _, _, offset, numEntries, _, offspecID = GetSpellTabInfo(j)
        if offspecID==0 then
            for s=offset+1,offset+numEntries do
                local sName = GetSpellBookItemName(s, BOOKTYPE_SPELL)
                local sType, sId = GetSpellBookItemInfo(s, BOOKTYPE_SPELL)
                if sType == "SPELL" and not IsPassiveSpell(sId) then
                    HealBot_Init_Spells_addSpell(sId, sName, s)
                elseif sType == "FLYOUT" then
                    local _, _, numFlyoutSlots, flyoutKnown = GetFlyoutInfo(sId)
                    if flyoutKnown then
                        for f=1,numFlyoutSlots do
                            local fId, _, fKnown, fName = GetFlyoutSlotInfo(sId, f)
                            if fKnown and not IsPassiveSpell(fId) then
                                HealBot_Init_Spells_addSpell(fId, fName, s)
                            end
                        end
                    end
                end
            end
        end
    end  
    HealBot_Options_InitBuffList()
    HealBot_setOptions_Timer(15)
    HealBot_setOptions_Timer(12)
    HealBot_setOptions_Timer(11)  
end

function HealBot_Init_SmartCast()
    if HealBot_Data["PCLASSTRIM"]=="PRIE" then
        if HealBot_Spell_IDs[HEALBOT_MASS_RESURRECTION] then SmartCast_MassRes=HealBot_Spell_IDs[HEALBOT_MASS_RESURRECTION].name end
        if HealBot_Spell_IDs[HEALBOT_RESURRECTION] then SmartCast_Res=HealBot_Spell_IDs[HEALBOT_RESURRECTION].name end
    elseif HealBot_Data["PCLASSTRIM"]=="DRUI" then
        if HealBot_Spell_IDs[HEALBOT_REVITALIZE] then SmartCast_MassRes=HealBot_Spell_IDs[HEALBOT_REVITALIZE].name end
        if HealBot_Spell_IDs[HEALBOT_REVIVE] then SmartCast_Res=HealBot_Spell_IDs[HEALBOT_REVIVE].name end
    elseif HealBot_Data["PCLASSTRIM"]=="MONK" then
        if HealBot_Spell_IDs[HEALBOT_REAWAKEN] then SmartCast_MassRes=HealBot_Spell_IDs[HEALBOT_REAWAKEN].name end
        if HealBot_Spell_IDs[HEALBOT_RESUSCITATE] then SmartCast_Res=HealBot_Spell_IDs[HEALBOT_RESUSCITATE].name end
    elseif HealBot_Data["PCLASSTRIM"]=="PALA" then
        if HealBot_Spell_IDs[HEALBOT_ABSOLUTION] then SmartCast_MassRes=HealBot_Spell_IDs[HEALBOT_ABSOLUTION].name end
        if HealBot_Spell_IDs[HEALBOT_REDEMPTION] then SmartCast_Res=HealBot_Spell_IDs[HEALBOT_REDEMPTION].name end
    elseif HealBot_Data["PCLASSTRIM"]=="SHAM" then
        if HealBot_Spell_IDs[HEALBOT_ANCESTRAL_VISION] then SmartCast_MassRes=HealBot_Spell_IDs[HEALBOT_ANCESTRAL_VISION].name end
        if HealBot_Spell_IDs[HEALBOT_ANCESTRALSPIRIT] then SmartCast_Res=HealBot_Spell_IDs[HEALBOT_ANCESTRALSPIRIT].name end
    end
end
