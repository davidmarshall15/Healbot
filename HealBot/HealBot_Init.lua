local SmartCast_Res=nil;
local SmartCast_MassRes=nil;
local tonumber=tonumber
local strmatch=strmatch
local _
local MANA_COST_PATTERN = gsub(MANA_COST, "%%d", "([%%d%.,]+)")

function HealBot_Init_retSmartCast_Res()
    return SmartCast_Res
end

function HealBot_Init_retSmartCast_MassRes()
    return SmartCast_MassRes
end

function HealBot_FindSpellRangeCast(id, spellName, spellBookId)

    if ( not id ) then return nil; end

    local spell, _, _, msCast, _, _ = HealBot_GetSpellInfo(id);
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
                hbMana = strmatch(line, MANA_COST_PATTERN) 
                hbMana = hbMana and tonumber((gsub(hbMana, "%D", "")))
            end
        end
    end
    
    local hbCastTime=tonumber(msCast or 0);
    if hbCastTime>999 then hbCastTime=HealBot_Comm_round(hbCastTime/1000,2) end
    
    HealBot_Spells[spellName]={}
    HealBot_Spells[spellName].CastTime=hbCastTime;
    HealBot_Spells[spellName].Mana=hbMana or 0

    return true
end

function HealBot_Init_Spells_Defaults()
    local i = GetSpecialization()
    local specID = 0
    if i then specID = GetSpecializationInfo(i,false,false) end
    HealBot_Spells={}
    
    local nTabs=GetNumSpellTabs()
    for j=1,nTabs do
        local _, _, offset, numEntries, _, offspecID = GetSpellTabInfo(j)
        if offspecID==0 then
            for s=offset+1,offset+numEntries do
                local sName = GetSpellBookItemName(s, BOOKTYPE_SPELL)
                local sType, sId = GetSpellBookItemInfo(s, BOOKTYPE_SPELL)
                if sType == "SPELL" and not IsPassiveSpell(sId) then
                    HealBot_Init_Spells_addSpell(sId, sName, s)
                elseif spellType == "FLYOUT" then
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
    if HealBot_Data["PCLASSTRIM"]=="PALA" then
        HealBot_GreaterBlessingSpells()
    end
end

function HealBot_Init_Spells_addSpell(spellId, spellName, spellBookId)
    local skipSpells={ [HEALBOT_BLESSING_OF_MIGHT]=true}
    if not skipSpells[spellName] then
        if HealBot_FindSpellRangeCast(spellId, spellName, spellBookId) then
            HealBot_Spells[spellName].id=spellId
            HealBot_Spells[spellName].known=IsSpellKnown(spellId)
        end
    end
end

function HealBot_Init_SmartCast()
    if HealBot_Data["PCLASSTRIM"]=="PRIE" then
        SmartCast_MassRes=HEALBOT_MASS_RESURRECTION;
        SmartCast_Res=HEALBOT_RESURRECTION;
    elseif HealBot_Data["PCLASSTRIM"]=="DRUI" then
        SmartCast_MassRes=HEALBOT_REVITALIZE;
        SmartCast_Res=HEALBOT_REVIVE;
    elseif HealBot_Data["PCLASSTRIM"]=="MONK" then
        SmartCast_MassRes=HEALBOT_REAWAKEN;
        SmartCast_Res=HEALBOT_RESUSCITATE;
    elseif HealBot_Data["PCLASSTRIM"]=="PALA" then
        SmartCast_MassRes=HEALBOT_ABSOLUTION;
        SmartCast_Res=HEALBOT_REDEMPTION;
    elseif HealBot_Data["PCLASSTRIM"]=="SHAM" then
        SmartCast_MassRes=HEALBOT_ANCESTRAL_VISION;
        SmartCast_Res=HEALBOT_ANCESTRALSPIRIT;
    end
end
