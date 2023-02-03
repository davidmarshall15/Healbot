local SmartCast_Res=nil;
local SmartCast_MassRes=nil;
local HealBot_Heal_Names={}
local HealBot_Buff_Names={}
local HealBot_KnownHeal_Names={}
local HealBot_Spell_Ranks={}
local HealBot_Buff_Ranks={}
local HealBot_Other_Ranks={}
local _

function HealBot_Init_retSmartCast_Res()
    return SmartCast_Res
end

function HealBot_Init_retSmartCast_MassRes()
    return SmartCast_MassRes
end

function HealBot_Init_retFoundHealSpells()
    return HealBot_KnownHeal_Names
end

function HealBot_Init_knownClassicHealSpell(sName)
    return HealBot_KnownHeal_Names[sName]
end

function HealBot_Init_ClassicHealSpellMaxRank(sName)
    if HealBot_Spell_Ranks[sName] then
        return HealBot_Spell_Ranks[sName][0]
    else
        return 0
    end
end

local function EnumerateTooltipLines_helper(pattern, ...)
    local region=nil
    for i = 1, select("#", ...) do
        region = select(i, ...)
        if region and region:GetObjectType() == "FontString" then
            if region:GetText() then
                if string.find(region:GetText(), pattern) then
                    return true
                end
            end
        end
    end
    return false
end

function HealBot_Init_TalentLookupImproved()
    if HEALBOT_GAME_VERSION>9 then 
        local pattern=false
        local improved=false
        if HealBot_Data["PCLASSTRIM"]=="PRIE" then
            pattern=HEALBOT_IMPROVEDPURIFY
        elseif HealBot_Data["PCLASSTRIM"]=="PALA" then
            pattern=HEALBOT_IMPROVEDCLEANSE
        elseif HealBot_Data["PCLASSTRIM"]=="SHAM" then
            pattern=HEALBOT_IMPROVEDPURIFY_SPIRIT
        end
        if pattern then
            local specID = PlayerUtil.GetCurrentSpecID()
            if specID then
                local configID = C_ClassTalents.GetLastSelectedSavedConfigID(specID) or C_ClassTalents.GetActiveConfigID() or HealBot_Config.LastLoadout
                local configInfo = C_Traits.GetConfigInfo(configID)
                if configInfo then
                    local treeID = configInfo.treeIDs[1]
                    local nodes = C_Traits.GetTreeNodes(treeID)
                    for _, nodeID in ipairs(nodes) do
                        local nodeInfo = C_Traits.GetNodeInfo(configID, nodeID)
                        if nodeInfo.currentRank and nodeInfo.currentRank > 0 then
                            local entryID = nodeInfo.activeEntry and nodeInfo.activeEntry.entryID and nodeInfo.activeEntry.entryID
                            local entryInfo = entryID and C_Traits.GetEntryInfo(configID, entryID)
                            local definitionInfo = entryInfo and entryInfo.definitionID and C_Traits.GetDefinitionInfo(entryInfo.definitionID)
                            if definitionInfo ~= nil and nodeInfo.activeRank > 0 then
                                local talentName = TalentUtil.GetTalentName(definitionInfo.overrideName, definitionInfo.spellID)
                                if talentName==pattern then
                                    improved=true
                                    break
                                end
                            end
                        end
                    end
                    if HealBot_Data["PCLASSTRIM"]=="PRIE" then
                        if improved then
                            HealBot_Options_setLuVars("PriestImprovedPurify", true)
                        else
                            HealBot_Options_setLuVars("PriestImprovedPurify", false)
                        end
                    elseif HealBot_Data["PCLASSTRIM"]=="PALA" then
                        if improved then
                            HealBot_Options_setLuVars("PaladinImprovedCleanse", true)
                        else
                            HealBot_Options_setLuVars("PaladinImprovedCleanse", false)
                        end
                    elseif HealBot_Data["PCLASSTRIM"]=="SHAM" then
                        if improved then
                            HealBot_Options_setLuVars("ShamanImprovedPurifySpirit", true)
                        else
                            HealBot_Options_setLuVars("ShamanImprovedPurifySpirit", false)
                        end
                    end
                else
                    HealBot_Timers_Set("LAST","TalentsLookupImproved",5)
                end
            else
                HealBot_Timers_Set("LAST","TalentsLookupImproved",5)
            end
        end
    end
end

function HealBot_Init_FindSpellRangeCast(id, spellName, spellBookId)
    local cRank=false
    if ( not id ) then return false; end

    local spell, _, texture, msCast, _, _ = GetSpellInfo(id);

    if ( not spell ) then return false; end
    if not spellName then spellName=spell end
   
    local hbMana=nil
    if spellBookId then
        HealBot_SetToolTip(HealBot_ScanTooltip)
        HealBot_ScanTooltip:SetSpellBookItem(spellBookId, BOOKTYPE_SPELL);
        local ttText = getglobal("HealBot_ScanTooltipTextLeft2");
        if (ttText:GetText()) then
            local line = ttText:GetText();
            if line then 
                hbMana = tonumber((gsub(line, "%D", "")))
            end
            if not hbMana then
                ttText = getglobal("HealBot_ScanTooltipTextLeft3")
                line = ttText:GetText()
                if line then 
                    hbMana = tonumber((gsub(line, "%D", "")))
                end
            end
        end
        if HEALBOT_GAME_VERSION<4 then 
            local _, rank = GetSpellBookItemName(spellBookId, BOOKTYPE_SPELL)
            cRank = rank
        elseif spellName==HEALBOT_PURIFY and HealBot_Data["PCLASSTRIM"]=="PRIE" then
            if EnumerateTooltipLines_helper(HEALBOT_DISEASE, HealBot_ScanTooltip:GetRegions()) then
                HealBot_Options_setLuVars("PriestImprovedPurify", true)
            else
                HealBot_Timers_Set("LAST","TalentsLookupImproved",1)
            end
        elseif spellName==HEALBOT_CLEANSE and HealBot_Data["PCLASSTRIM"]=="PALA" then
            if EnumerateTooltipLines_helper(HEALBOT_DISEASE, HealBot_ScanTooltip:GetRegions()) or EnumerateTooltipLines_helper(HEALBOT_POISON, HealBot_ScanTooltip:GetRegions()) then
                HealBot_Options_setLuVars("PaladinImprovedCleanse", true)
            else
                HealBot_Timers_Set("LAST","TalentsLookupImproved",1)
            end
        elseif spellName==HEALBOT_PURIFY_SPIRIT and HealBot_Data["PCLASSTRIM"]=="SHAM" then
            if EnumerateTooltipLines_helper(HEALBOT_CURSE, HealBot_ScanTooltip:GetRegions()) then
                HealBot_Options_setLuVars("ShamanImprovedPurifySpirit", true)
            else
                HealBot_Timers_Set("LAST","TalentsLookupImproved",1)
            end
        end
    end

    if HEALBOT_GAME_VERSION<4 and not cRank then 
        cRank = GetSpellSubtext(id)
    end
    local hbCastTime=tonumber(msCast or 0);
    if hbCastTime>999 then hbCastTime=HealBot_Comm_round(hbCastTime/1000,2) end
    
    HealBot_Spell_IDs[id]={}
    HealBot_Spell_IDs[id].CastTime=hbCastTime;
    HealBot_Spell_IDs[id].Mana=hbMana or 0
    HealBot_Spell_IDs[id].texture=texture
    return cRank
end

local skipSpells={}
function HealBot_Init_SkipSpells()
    skipSpells={[HEALBOT_BLESSING_OF_MIGHT]=true}
end

local HealBot_Ranks={}
function HealBot_Init_Spells_addSpell(spellId, spellName, spellBookId)
    if not skipSpells[spellName] then
        local cRank=HealBot_Init_FindSpellRangeCast(spellId, spellName, spellBookId)
        if cRank and not HealBot_Globals.NoRanks then
            if not HealBot_Ranks[spellName] then HealBot_Ranks[spellName]=0 end
            local rank=tonumber(string.match(cRank, "%d+")) or 0
            if HealBot_Ranks[spellName]<rank then HealBot_Ranks[spellName]=rank end
            if HealBot_Heal_Names[spellName] then 
                HealBot_KnownHeal_Names[spellName]=true
                if not HealBot_Spell_Ranks[spellName] then 
                    HealBot_Spell_Ranks[spellName]={} 
                    HealBot_Spell_Ranks[spellName][0]=1
                end
                if rank>0 and not HealBot_Spell_Ranks[spellName][rank] then
                    HealBot_Spell_Ranks[spellName][rank]=spellName.."("..cRank..")"
                    if rank>HealBot_Spell_Ranks[spellName][0] then
                        HealBot_Spell_Ranks[spellName][0]=rank
                    end
                end
                if HEALBOT_GAME_VERSION<3 then spellName=spellName.."("..cRank..")" end
            elseif HealBot_Buff_Names[spellName] then
                if not HealBot_Buff_Ranks[spellName] then 
                    HealBot_Buff_Ranks[spellName]={} 
                    HealBot_Buff_Ranks[spellName][0]=1
                end
                if rank>0 and not HealBot_Buff_Ranks[spellName][rank] then
                    HealBot_Buff_Ranks[spellName][rank]=spellName.."("..cRank..")"
                    if rank>HealBot_Buff_Ranks[spellName][0] then
                        HealBot_Buff_Ranks[spellName][0]=rank
                    end
                end
            else
                if not HealBot_Other_Ranks[spellName] then 
                    HealBot_Other_Ranks[spellName]={}
                    HealBot_Other_Ranks[spellName][0]=1
                end
                if rank>0 and not HealBot_Other_Ranks[spellName][rank] then
                    HealBot_Other_Ranks[spellName][rank]=spellName.."("..cRank..")"
                    if rank>HealBot_Other_Ranks[spellName][0] then
                        HealBot_Other_Ranks[spellName][0]=rank
                    end
                end
            end
        end
        HealBot_Spell_IDs[spellId].name=spellName
        HealBot_Spell_IDs[spellId].known=IsSpellKnown(spellId)
        HealBot_Spell_Names[spellName]=spellId
    end
end

local sOtherName=""
function HealBot_Init_Other_retRank(spellName, targetRank)
    sOtherName=false
    if HealBot_Other_Ranks[spellName] then
        if not HealBot_Other_Ranks[spellName][targetRank] then
            if targetRank<HealBot_Other_Ranks[spellName][0] then
                sOtherName=spellName..HEALBOT_RANK[targetRank]
            else
                sOtherName=spellName..HEALBOT_RANK[HealBot_Other_Ranks[spellName][0]]
            end
		else
			sOtherName=HealBot_Other_Ranks[spellName][targetRank]
        end
    end
    return sOtherName
end

local sBuffName=""
function HealBot_Init_Buffs_retRank(spellName, targetRank)
    sBuffName=false
    if HealBot_Buff_Ranks[spellName] then
        if not HealBot_Buff_Ranks[spellName][targetRank] then
            if targetRank<HealBot_Buff_Ranks[spellName][0] then
                sBuffName=spellName..HEALBOT_RANK[targetRank]
            else
                sBuffName=spellName..HEALBOT_RANK[HealBot_Buff_Ranks[spellName][0]]
            end
		else
			sBuffName=HealBot_Buff_Ranks[spellName][targetRank]
        end
    end
    return sBuffName
end

local sHealName=""
function HealBot_Init_Spells_retRank(spellName, targetRank)
    sHealName=false
    if HealBot_Spell_Ranks[spellName] then
        if not HealBot_Spell_Ranks[spellName][targetRank] then
            if targetRank<HealBot_Spell_Ranks[spellName][0] then
                sHealName=spellName..HEALBOT_RANK[targetRank]
            else
                sHealName=spellName..HEALBOT_RANK[HealBot_Spell_Ranks[spellName][0]]
            end
		else
			sHealName=HealBot_Spell_Ranks[spellName][targetRank]
        end
    end
    return sHealName
end

local sRankName=""
function HealBot_Init_retRank(spellName, targetRank)
    if HealBot_Ranks[spellName] then
        if HealBot_Init_Spells_retRank(spellName, targetRank) then
            sRankName=HealBot_Init_Spells_retRank(spellName, targetRank)
        elseif HealBot_Init_Buffs_retRank(spellName, targetRank) then
            sRankName=HealBot_Init_Buffs_retRank(spellName, targetRank)
        elseif HealBot_Init_Other_retRank(spellName, targetRank) then
            sRankName=HealBot_Init_Other_retRank(spellName, targetRank)
        else
            sRankName=spellName
        end
    else
        sRankName=spellName
    end
    return sRankName
end

function HealBot_InitValidateRanks()
    for sName,maxRank in pairs(HealBot_Ranks) do
        for x=1, maxRank do
            if HealBot_Spell_Ranks[sName] then
                if not HealBot_Spell_Ranks[sName][x] then
                    HealBot_Spell_Ranks[sName][x]=sName..HEALBOT_RANK[x]
                    if HealBot_Spell_Ranks[sName][0]<maxRank then
                        HealBot_Spell_Ranks[sName][0]=maxRank
                    end
                end
            elseif HealBot_Buff_Ranks[sName] then
                if not HealBot_Buff_Ranks[sName][x] then
                    HealBot_Buff_Ranks[sName][x]=sName..HEALBOT_RANK[x]
                    if HealBot_Buff_Ranks[sName][0]<maxRank then
                        HealBot_Buff_Ranks[sName][0]=maxRank
                    end
                end
            elseif HealBot_Other_Ranks[sName] then
                if not HealBot_Other_Ranks[sName][x] then
                    HealBot_Other_Ranks[sName][x]=sName..HEALBOT_RANK[x]
                    if HealBot_Other_Ranks[sName][0]<maxRank then
                        HealBot_Other_Ranks[sName][0]=maxRank
                    end
                end
            else
                HealBot_Other_Ranks[sName]={}
                HealBot_Other_Ranks[sName][0]=maxRank
                HealBot_Other_Ranks[sName][x]=sName..HEALBOT_RANK[x]
            end
        end
    end
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
    for x,_ in pairs(HealBot_Buff_Names) do
        HealBot_Buff_Names[x]=nil
    end  
    for x,_ in pairs(HealBot_KnownHeal_Names) do
        HealBot_KnownHeal_Names[x]=nil
    end
    for x,_ in pairs(HealBot_Spell_Ranks) do
        HealBot_Spell_Ranks[x]=nil
    end
    for x,_ in pairs(HealBot_Buff_Ranks) do
        HealBot_Buff_Ranks[x]=nil
    end
    for x,_ in pairs(HealBot_Other_Ranks) do
        HealBot_Other_Ranks[x]=nil
    end
    for x,_ in pairs(HealBot_Ranks) do
        HealBot_Ranks[x]=nil
    end
    local nTabs=GetNumSpellTabs()
    local hbHeallist=HealBot_Options_FullHealSpellsCombo_list(1)
    for j=1, getn(hbHeallist), 1 do
        if hbHeallist[j] and GetSpellInfo(hbHeallist[j]) then
            HealBot_Heal_Names[GetSpellInfo(hbHeallist[j])]=true
        end
    end
    local hbBufflist=HealBot_Options_InitBuffSpellsClassList(HealBot_Data["PCLASSTRIM"])
    for j=1, getn(hbBufflist), 1 do
        if hbBufflist[j] and GetSpellInfo(hbBufflist[j]) then
            HealBot_Buff_Names[GetSpellInfo(hbBufflist[j])]=true
        end
    end
	
    HealBot_Init_SkipSpells()
    for j=1,nTabs do
        local _, _, offset, numEntries, _, offspecID = GetSpellTabInfo(j)
        if offspecID==0 then
            for s=offset+1,offset+numEntries do
                local sName = GetSpellBookItemName(s, BOOKTYPE_SPELL)
                local sType, sId = GetSpellBookItemInfo(s, BOOKTYPE_SPELL)
                if sType == "SPELL" then --and not IsPassiveSpell(sId) then
                    HealBot_Init_Spells_addSpell(sId, sName, s)
                elseif sType == "FLYOUT" then
                    local _, _, numFlyoutSlots, flyoutKnown = GetFlyoutInfo(sId)
                    if flyoutKnown then
                        for f=1,numFlyoutSlots do
                            local fId, _, fKnown, fName = GetFlyoutSlotInfo(sId, f)
                            if fKnown then --and not IsPassiveSpell(fId) then
                                HealBot_Init_Spells_addSpell(fId, fName, s)
                            end
                        end
                    end
                end
            end
        end
    end
    if HEALBOT_GAME_VERSION<3 then 
        HealBot_InitValidateRanks()
    end
end

function HealBot_Init_SmartCast()
    local rName=""
    if HealBot_Data["PCLASSTRIM"]=="PRIE" then
        rName=GetSpellInfo(HEALBOT_MASS_RESURRECTION)
        if rName and HealBot_Spell_Names[rName] then SmartCast_MassRes=rName end
        rName=GetSpellInfo(HEALBOT_RESURRECTION)
        if rName and HealBot_Spell_Names[rName] then SmartCast_Res=rName end
        rName=GetSpellInfo(HEALBOT_SPIRIT_OF_REDEMPTION)
        if rName then HealBot_Action_SmartCast_SpellBlocker(rName) end
    elseif HealBot_Data["PCLASSTRIM"]=="DRUI" then
        rName=GetSpellInfo(HEALBOT_REVITALIZE)
        if rName and HealBot_Spell_Names[rName] then SmartCast_MassRes=rName end
        rName=GetSpellInfo(HEALBOT_REVIVE)
        if rName and HealBot_Spell_Names[rName] then 
            SmartCast_Res=rName
        else
            rName=GetSpellInfo(HEALBOT_REBIRTH)
            if rName and HealBot_Spell_Names[rName] then SmartCast_Res=rName end
        end
    elseif HealBot_Data["PCLASSTRIM"]=="MONK" then
        rName=GetSpellInfo(HEALBOT_REAWAKEN)
        if rName and HealBot_Spell_Names[rName] then SmartCast_MassRes=rName end
        rName=GetSpellInfo(HEALBOT_RESUSCITATE)
        if rName and HealBot_Spell_Names[rName] then SmartCast_Res=rName end
    elseif HealBot_Data["PCLASSTRIM"]=="PALA" then
        rName=GetSpellInfo(HEALBOT_ABSOLUTION)
        if rName and HealBot_Spell_Names[rName] then SmartCast_MassRes=rName end
        rName=GetSpellInfo(HEALBOT_REDEMPTION)
        if rName and HealBot_Spell_Names[rName] then SmartCast_Res=rName end
    elseif HealBot_Data["PCLASSTRIM"]=="SHAM" then
        rName=GetSpellInfo(HEALBOT_ANCESTRAL_VISION)
        if rName and HealBot_Spell_Names[rName] then SmartCast_MassRes=rName end
        rName=GetSpellInfo(HEALBOT_ANCESTRALSPIRIT)
        if rName and HealBot_Spell_Names[rName] then SmartCast_Res=rName end
    elseif HealBot_Data["PCLASSTRIM"]=="EVOK" then
        rName=GetSpellInfo(HEALBOT_MASS_RETURN)
        if rName and HealBot_Spell_Names[rName] then SmartCast_MassRes=rName end
        rName=GetSpellInfo(HEALBOT_RETURN)
        if rName and HealBot_Spell_Names[rName] then SmartCast_Res=rName end
    end
end

local HealBot_Spec = {}
function HealBot_Init_ClassicSpecs()
    HealBot_Spec = {
        ["DRUI"] = { [1] = HEALBOT_BALANCE,       [2] = HEALBOT_FERAL,        [3] = HEALBOT_RESTORATION, },
        ["MAGE"] = { [1] = HEALBOT_ARCANE,        [2] = HEALBOT_FIRE,         [3] = HEALBOT_FROST,       },
        ["PRIE"] = { [1] = HEALBOT_DISCIPLINE,    [2] = HEALBOT_HOLY,         [3] = HEALBOT_SHADOW,      },
        ["ROGU"] = { [1] = HEALBOT_ASSASSINATION, [2] = HEALBOT_COMBAT,       [3] = HEALBOT_SUBTLETY,    },
        ["WARR"] = { [1] = HEALBOT_ARMS,          [2] = HEALBOT_FURY,         [3] = HEALBOT_PROTECTION,  },
        ["HUNT"] = { [1] = HEALBOT_BEASTMASTERY,  [2] = HEALBOT_MARKSMANSHIP, [3] = HEALBOT_SURVIVAL,    },
        ["PALA"] = { [1] = HEALBOT_HOLY,          [2] = HEALBOT_PROTECTION,   [3] = HEALBOT_RETRIBUTION, },
        ["SHAM"] = { [1] = HEALBOT_ELEMENTAL,     [2] = HEALBOT_ENHANCEMENT,  [3] = HEALBOT_SHAMAN_RESTORATION, },
        ["WARL"] = { [1] = HEALBOT_AFFLICTION,    [2] = HEALBOT_DEMONOLOGY,   [3] = HEALBOT_DESTRUCTION, },
        ["DEAT"] = { [1] = HEALBOT_BLOOD,         [2] = HEALBOT_FROST,        [3] = HEALBOT_UNHOLY, },
        }
end

function HealBot_Init_retSpec(class,tab)
    if HealBot_Spec[class] and HealBot_Spec[class][tab] then
        return HealBot_Spec[class][tab]
    end
    return nil
end
