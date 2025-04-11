local SmartCast_Res=nil;
local SmartCast_MassRes=nil;
local HealBot_Heal_Names={}
local HealBot_Buff_Names={}
local HealBot_KnownHeal_Names={}
local HealBot_Spell_Ranks={}
local HealBot_Buff_Ranks={}
local _
local HealBot_Init_luVars={}

function HealBot_Init_setLuVars(vName, vValue)
      --HealBot_setCall("HealBot_Init_setLuVars - "..vName)
    HealBot_Init_luVars[vName]=vValue
end

function HealBot_Init_retLuVars(vName)
      --HealBot_setCall("HealBot_Init_retLuVars - "..vName)
    return HealBot_Init_luVars[vName]
end

function HealBot_Init_retSmartCast_Res()
      --HealBot_setCall("HealBot_Init_retSmartCast_Res")
    return SmartCast_Res
end

function HealBot_Init_retSmartCast_MassRes()
      --HealBot_setCall("HealBot_Init_retSmartCast_MassRes")
    return SmartCast_MassRes
end

function HealBot_Init_knownClassicHealSpell(sName)
      --HealBot_setCall("HealBot_Init_knownClassicHealSpell")
    return HealBot_KnownHeal_Names[sName]
end

function HealBot_Init_ClassicHealSpellMaxRank(sName)
      --HealBot_setCall("HealBot_Init_ClassicHealSpellMaxRank")
    if HealBot_Spell_Ranks[sName] then
        return HealBot_Spell_Ranks[sName][0]
    else
        return 0
    end
end

local function EnumerateTooltipLines_helper(pattern, ...)
    local region=nil
    for i=1, select("#", ...) do
        region=select(i, ...)
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

function HealBot_Init_TalentLookupImproved(callback)
      --HealBot_setCall("HealBot_Init_TalentLookupImproved")
    if HEALBOT_GAME_VERSION>9 then
        local pattern=false
        local improved=false
        if HealBot_Data["PCLASSTRIM"] == "PRIE" then
            pattern=HEALBOT_IMPROVEDPURIFY
        elseif HealBot_Data["PCLASSTRIM"] == "PALA" then
            pattern=HEALBOT_IMPROVEDCLEANSE
        elseif HealBot_Data["PCLASSTRIM"] == "SHAM" then
            pattern=HEALBOT_IMPROVEDPURIFY_SPIRIT
        elseif HealBot_Data["PCLASSTRIM"] == "DRUI" then
            pattern=HEALBOT_IMPROVEDNATURES_CURE
        end
        if pattern then
            local specID=PlayerUtil.GetCurrentSpecID()
            if specID then
                local configID=C_ClassTalents.GetLastSelectedSavedConfigID(specID) or C_ClassTalents.GetActiveConfigID() or HealBot_Config.LastLoadout
                local configInfo=C_Traits.GetConfigInfo(configID)
                if configInfo then
                    local treeID=configInfo.treeIDs[1]
                    local nodes=C_Traits.GetTreeNodes(treeID)
                    for _, nodeID in ipairs(nodes) do
                        local nodeInfo=C_Traits.GetNodeInfo(configID, nodeID)
                        if nodeInfo.currentRank and nodeInfo.currentRank > 0 then
                            local entryID=nodeInfo.activeEntry and nodeInfo.activeEntry.entryID and nodeInfo.activeEntry.entryID
                            local entryInfo=entryID and C_Traits.GetEntryInfo(configID, entryID)
                            local definitionInfo=entryInfo and entryInfo.definitionID and C_Traits.GetDefinitionInfo(entryInfo.definitionID)
                            if definitionInfo ~= nil and nodeInfo.activeRank > 0 then
                                local talentName=TalentUtil.GetTalentName(definitionInfo.overrideName, definitionInfo.spellID)
                                if talentName == pattern then
                                    improved=true
                                    break
                                end
                            end
                        end
                    end
                    if HealBot_Data["PCLASSTRIM"] == "PRIE" then
                        if improved then
                            HealBot_Options_setLuVars("PriestImprovedPurify", true)
                        else
                            HealBot_Options_setLuVars("PriestImprovedPurify", false)
                        end
                    elseif HealBot_Data["PCLASSTRIM"] == "PALA" then
                        if improved then
                            HealBot_Options_setLuVars("PaladinImprovedCleanse", true)
                        else
                            HealBot_Options_setLuVars("PaladinImprovedCleanse", false)
                        end
                    elseif HealBot_Data["PCLASSTRIM"] == "SHAM" then
                        if improved then
                            HealBot_Options_setLuVars("ShamanImprovedPurifySpirit", true)
                        else
                            HealBot_Options_setLuVars("ShamanImprovedPurifySpirit", false)
                        end
                    elseif HealBot_Data["PCLASSTRIM"] == "DRUI" then
                        if improved then
                            HealBot_Options_setLuVars("DruidImprovedNaturesCure", true)
                        else
                            HealBot_Options_setLuVars("DruidImprovedNaturesCure", false)
                        end
                    end
                elseif not callback then
                    HealBot_Timers_Set("LAST","TalentsLookupImprovedCallback",true,true)
                end
            elseif not callback then
                HealBot_Timers_Set("LAST","TalentsLookupImprovedCallback",true,true)
            end
        end
    elseif HEALBOT_GAME_VERSION>3 then
        if HealBot_Data["PCLASSTRIM"] == "SHAM" then
            local _, _, _, _, rank=GetTalentInfo(3, 12)
            if rank>0 then
                HealBot_Options_setLuVars("ShamanImprovedCleanseSpirit", true)
            else
                HealBot_Options_setLuVars("ShamanImprovedCleanseSpirit", false)
            end
        elseif HealBot_Data["PCLASSTRIM"] == "DRUI" then
            local _, _, _, _, rank=GetTalentInfo(3, 15)
            if rank>0 then
                HealBot_Options_setLuVars("DruidImprovedNaturesCure", true)
            else
                HealBot_Options_setLuVars("DruidImprovedNaturesCure", false)
            end
        elseif HealBot_Data["PCLASSTRIM"] == "PALA" then
            local _, _, _, _, rank=GetTalentInfo(1, 14)
            if rank>0 then
                HealBot_Options_setLuVars("PaladinImprovedCleanse", true)
            else
                HealBot_Options_setLuVars("PaladinImprovedCleanse", false)
            end
        end
    end
end

local function HealBot_Init_ManaCost(spellId, spellBookId, tipSet)
      --HealBot_setCall("HealBot_Init_ManaCost")
    local hbMana=HealBot_WoWAPI_SpellPowerCost(spellId)
    local manaCost=0
    if hbMana and hbMana[1] and hbMana[1].cost then
        manaCost=hbMana[1].cost
    end
    if spellBookId and manaCost == 0 then
        if not tipSet then
            HealBot_SetToolTip(HealBot_ScanTooltip)
            HealBot_ScanTooltip:SetSpellBookItem(spellBookId, BOOKTYPE_SPELL);
        end
        local ttText=getglobal("HealBot_ScanTooltipTextLeft2");
        if (ttText:GetText()) then
            local line=ttText:GetText();
            if line then
                manaCost=tonumber((gsub(line, "%D", "")))
            end
            if manaCost == 0 then
                ttText=getglobal("HealBot_ScanTooltipTextLeft3")
                line=ttText:GetText()
                if line then
                    manaCost=tonumber((gsub(line, "%D", "")))
                end
            end
        end
    end
    if not manaCost or type(manaCost)~="number" then manaCost=0 end
    return manaCost
end

local function HealBot_Init_Range(spellId, spellBookId, tipSet)
      --HealBot_setCall("HealBot_Init_ManaCost")
    local range=0
    if spellBookId then
        if not tipSet then
            HealBot_SetToolTip(HealBot_ScanTooltip)
            HealBot_ScanTooltip:SetSpellBookItem(spellBookId, BOOKTYPE_SPELL);
        end
        local ttText=getglobal("HealBot_ScanTooltipTextRight2");
        if (ttText:GetText()) then
            local line=ttText:GetText();
            if line then
                range=tonumber((gsub(line, "%D", "")))
            end
            if range == 0 then
                ttText=getglobal("HealBot_ScanTooltipTextRight3")
                line=ttText:GetText()
                if line then
                    range=tonumber((gsub(line, "%D", "")))
                end
            end
        end
    end
    if not range or type(range)~="number" then range=0 end
    return range
end

local HealBot_Spell_Ranges={}
local HealBot_Spell_RangesPref={}
local function HealBot_Init_Spell_RangesPref()
    HealBot_Spell_Ranges={}
    if HealBot_Data["PCLASSTRIM"] == "DRUI" then
        HealBot_Spell_RangesPref[HEALBOT_WRATH]=true
        HealBot_Spell_RangesPref[HEALBOT_HURRICANE]=true
        HealBot_Spell_RangesPref[HEALBOT_REJUVENATION]=true
        HealBot_Spell_RangesPref[HEALBOT_HEALING_TOUCH]=true
    elseif HealBot_Data["PCLASSTRIM"] == "MAGE" then
        HealBot_Spell_RangesPref[HEALBOT_FROSTFIRE_BOLT]=true
        HealBot_Spell_RangesPref[HEALBOT_FIRE_BLAST]=true
    elseif HealBot_Data["PCLASSTRIM"] == "PALA" then
        HealBot_Spell_RangesPref[HEALBOT_HOLY_SHOCK]=true
        HealBot_Spell_RangesPref[HEALBOT_JUDGMENT]=true
        HealBot_Spell_RangesPref[HEALBOT_FLASH_OF_LIGHT]=true
        HealBot_Spell_RangesPref[HEALBOT_HOLY_LIGHT]=true
        HealBot_Spell_RangesPref[HBC_HOLY_LIGHT]=true
    elseif HealBot_Data["PCLASSTRIM"] == "PRIE" then
        HealBot_Spell_RangesPref[HEALBOT_SMITE]=true
        HealBot_Spell_RangesPref[HEALBOT_SHADOW_WORD_PAIN]=true
        HealBot_Spell_RangesPref[HEALBOT_FLASH_HEAL]=true
        HealBot_Spell_RangesPref[HEALBOT_HEAL]=true
        HealBot_Spell_RangesPref[HBC_HEAL]=true
        HealBot_Spell_RangesPref[HEALBOT_RENEW]=true
    elseif HealBot_Data["PCLASSTRIM"] == "SHAM" then
        HealBot_Spell_RangesPref[HEALBOT_LIGHTNING_BOLT]=true
        HealBot_Spell_RangesPref[HBC_LIGHTNING_BOLT]=true
        HealBot_Spell_RangesPref[HEALBOT_HEALING_WAVE]=true
        HealBot_Spell_RangesPref[HEALBOT_HEALING_SURGE]=true
        HealBot_Spell_RangesPref[HBC_HEALING_WAVE]=true
    elseif HealBot_Data["PCLASSTRIM"] == "MONK" then
        HealBot_Spell_RangesPref[HEALBOT_CRACKLING_JADE_LIGHTNING]=true
        HealBot_Spell_RangesPref[HEALBOT_SOOTHING_MIST]=true
    elseif HealBot_Data["PCLASSTRIM"] == "WARL" then
        HealBot_Spell_RangesPref[HEALBOT_CORRUPTION]=true
        HealBot_Spell_RangesPref[HEALBOT_FEAR]=true
    elseif HealBot_Data["PCLASSTRIM"] == "WARR" then
        HealBot_Spell_RangesPref[HEALBOT_TAUNT]=true
    elseif HealBot_Data["PCLASSTRIM"] == "HUNT" then
        HealBot_Spell_RangesPref[HEALBOT_ARCANE_SHOT]=true
        HealBot_Spell_RangesPref[HEALBOT_CONCUSSIVE_SHOT]=true
        HealBot_Spell_RangesPref[HEALBOT_AIMED_SHOT]=true
        HealBot_Spell_RangesPref[HEALBOT_MENDPET]=true
    elseif HealBot_Data["PCLASSTRIM"] == "ROGU" then
        HealBot_Spell_RangesPref[HEALBOT_THROW]=true
        HealBot_Spell_RangesPref[HEALBOT_GOUGE]=true
    elseif HealBot_Data["PCLASSTRIM"] == "DEAT" then
        HealBot_Spell_RangesPref[HEALBOT_DEATH_COIL]=true
        HealBot_Spell_RangesPref[HEALBOT_PLAGUE_STRIKE]=true
    elseif HealBot_Data["PCLASSTRIM"] == "DEMO" then
        HealBot_Spell_RangesPref[185123]=true
        HealBot_Spell_RangesPref[185245]=true
    elseif HealBot_Data["PCLASSTRIM"] == "EVOK" then
        HealBot_Spell_RangesPref[361469]=true
        HealBot_Spell_RangesPref[362969]=true
        HealBot_Spell_RangesPref[HEALBOT_LIVING_FLAME]=true
        HealBot_Spell_RangesPref[HEALBOT_ECHO]=true
    end
end

function HealBot_Init_SetRangeSpells(sType, spellName, spellId)
    if HealBot_Spell_RangesPref[spellId] then
        HealBot_Range_InitSpell(sType, spellName)
        HealBot_Spell_Ranges[sType]="Set"
    elseif not HealBot_Spell_Ranges[sType] then
        HealBot_Spell_Ranges[sType]=spellName
    end
end

function HealBot_Init_SetSpellRange(id, spellName, range)
    HealBot_Spell_IDs[id].range=range
    if range > 27 and range < 33 then
        if HealBot_WoWAPI_HelpfulSpell(spellName) then
            HealBot_Init_SetRangeSpells("HEAL30", spellName, id)
        elseif IsHarmfulSpell(spellName) then
            HealBot_Init_SetRangeSpells("HARM30", spellName, id)
        end
    elseif range > 39 and range < 71 then
        if HealBot_WoWAPI_HelpfulSpell(spellName) then
            HealBot_Init_SetRangeSpells("HEAL", spellName, id)
        elseif IsHarmfulSpell(spellName) then
            HealBot_Init_SetRangeSpells("HARM", spellName, id)
        end
    end
end

function HealBot_Init_FindSpellRangeCast(id, spellName, spellBookId, cRank)
      --HealBot_setCall("HealBot_Init_FindSpellRangeCast")
    if ( not id ) then return false; end

    local spell, _, texture, msCast, _, hbRange=HealBot_WoWAPI_SpellInfo(id);
    local cooldown=GetSpellBaseCooldown(id)
    
    if ( not spell ) then return false; end
    if not spellName then spellName=spell end

    if spellBookId then
        HealBot_SetToolTip(HealBot_ScanTooltip);
        if HEALBOT_GAME_VERSION>10 then
            HealBot_ScanTooltip:SetSpellBookItem(spellBookId, Enum.SpellBookSpellBank.Player)
        else
            HealBot_ScanTooltip:SetSpellBookItem(spellBookId, BOOKTYPE_SPELL)
        end
    end
    if HealBot_Data["PCLASSTRIM"] == "PRIE" then
        if spellName == HEALBOT_PURIFY then
            if spellBookId and EnumerateTooltipLines_helper(HEALBOT_DISEASE, HealBot_ScanTooltip:GetRegions()) then
                HealBot_Options_setLuVars("PriestImprovedPurify", true)
            else
                HealBot_Timers_Set("LAST","TalentsLookupImproved",true)
            end
        end
    elseif HealBot_Data["PCLASSTRIM"] == "PALA" then
        if spellName == HEALBOT_CLEANSE then
            if HEALBOT_GAME_VERSION>9 then
                if spellBookId and EnumerateTooltipLines_helper(HEALBOT_DISEASE, HealBot_ScanTooltip:GetRegions()) or EnumerateTooltipLines_helper(HEALBOT_POISON, HealBot_ScanTooltip:GetRegions()) then
                    HealBot_Options_setLuVars("PaladinImprovedCleanse", true)
                else
                    HealBot_Timers_Set("LAST","TalentsLookupImproved",true)
                end
            else
                if spellBookId and HealBot_Config.CurrentSpec == 1 and EnumerateTooltipLines_helper(HEALBOT_MAGIC, HealBot_ScanTooltip:GetRegions()) then
                    HealBot_Options_setLuVars("PaladinImprovedCleanse", true)
                else
                    HealBot_Timers_Set("LAST","TalentsLookupImproved",true)
                end
            end
        end
    elseif HealBot_Data["PCLASSTRIM"] == "SHAM" then
        if spellName == HEALBOT_PURIFY_SPIRIT then
            if spellBookId and EnumerateTooltipLines_helper(HEALBOT_CURSE, HealBot_ScanTooltip:GetRegions()) then
                HealBot_Options_setLuVars("ShamanImprovedPurifySpirit", true)
            else
                HealBot_Timers_Set("LAST","TalentsLookupImproved",true)
            end
        elseif spellName == HEALBOT_CLEANSE_SPIRIT then
            if spellBookId and HealBot_Config.CurrentSpec == 3 and EnumerateTooltipLines_helper(HEALBOT_MAGIC, HealBot_ScanTooltip:GetRegions()) then
                HealBot_Options_setLuVars("ShamanImprovedCleanseSpirit", true)
            else
                HealBot_Timers_Set("LAST","TalentsLookupImproved",true)
            end
        end
    elseif HealBot_Data["PCLASSTRIM"] == "DRUI" then
        if spellName == HEALBOT_NATURES_CURE then
            if spellBookId and EnumerateTooltipLines_helper(HEALBOT_POISON, HealBot_ScanTooltip:GetRegions()) then
                HealBot_Options_setLuVars("DruidImprovedNaturesCure", true)
            else
                HealBot_Timers_Set("LAST","TalentsLookupImproved",true)
            end
        elseif spellName == HBC_DRUID_REMOVE_CURSE then
            if spellBookId and HealBot_Config.CurrentSpec == 3 and EnumerateTooltipLines_helper(HEALBOT_MAGIC, HealBot_ScanTooltip:GetRegions()) then
                HealBot_Options_setLuVars("DruidImprovedNaturesCure", true)
            else
                HealBot_Timers_Set("LAST","TalentsLookupImproved",true)
            end
        end
    elseif HealBot_Data["PCLASSTRIM"] == "MONK" then
        --HealBot_Timers_Set("LAST","TalentsLookupImproved",true)
    end

    if hbRange == 0 then
        hbRange=HealBot_Init_Range(id, spellBookId, true)
    end

    local hbCastTime=tonumber(msCast or 0);
    local hbCooldown=tonumber(cooldown or 0);
    if hbCastTime>999 then hbCastTime=HealBot_Util_Round(hbCastTime/1000,2) end
    if hbCooldown>999 then hbCooldown=HealBot_Util_Round(hbCooldown/1000,2) end

    HealBot_Spell_IDs[id]={}
    HealBot_Spell_IDs[id].CastTime=hbCastTime;
    HealBot_Spell_IDs[id].Mana=HealBot_Init_ManaCost(id, spellBookId, true)
    HealBot_Spell_IDs[id].texture=texture
    HealBot_Spell_IDs[id].cooldown=hbCooldown
    if cRank and string.len(cRank)>1 then
        HealBot_Init_SetSpellRange(id, spellName.."("..cRank..")", hbRange)
    else
        HealBot_Init_SetSpellRange(id, spellName, hbRange)
    end
end

local skipSpells={}
function HealBot_Init_SkipSpells()
      --HealBot_setCall("HealBot_Init_SkipSpells")
    skipSpells={[HEALBOT_BLESSING_OF_MIGHT]=true}
end

local HealBot_Ranks={}
function HealBot_Init_Spells_addSpell(spellId, spellName, spellBookId, cRank)
      --HealBot_setCall("HealBot_Init_Spells_addSpell")
    if not skipSpells[spellName] then
        HealBot_Init_FindSpellRangeCast(spellId, spellName, spellBookId, cRank)
        if cRank and string.len(cRank)>1 and not HealBot_Globals.NoRanks then
            if not HealBot_Ranks[spellName] then HealBot_Ranks[spellName]=0 end
            local rank=tonumber(string.match(cRank, "%d+")) or 0
            if HealBot_Ranks[spellName]<rank then HealBot_Ranks[spellName]=rank end
            if HealBot_Buff_Names[spellName] then
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
                HealBot_KnownHeal_Names[spellName]=spellId
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
                if HEALBOT_GAME_VERSION<3 then
                    spellName=spellName.."("..cRank..")"
                end
            end
        end
        HealBot_Spell_IDs[spellId].name=spellName
        HealBot_Spell_Names[spellName]=spellId
    end
end

local sOtherName=""
function HealBot_Init_Other_retRank(spellName, targetRank)
      --HealBot_setCall("HealBot_Init_Other_retRank")
    return HealBot_Init_Spells_retRank(spellName, targetRank)
end

local sBuffName=""
function HealBot_Init_Buffs_retRank(spellName, targetRank)
      --HealBot_setCall("HealBot_Init_Buffs_retRank")
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
      --HealBot_setCall("HealBot_Init_Spells_retRank")
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
      --HealBot_setCall("HealBot_Init_retRank")
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
      --HealBot_setCall("HealBot_InitValidateRanks")
    for sName,maxRank in pairs(HealBot_Ranks) do
        for x=1, maxRank do
            if HealBot_Buff_Ranks[sName] then
                if not HealBot_Buff_Ranks[sName][x] then
                    HealBot_Buff_Ranks[sName][x]=sName..HEALBOT_RANK[x]
                    if HealBot_Buff_Ranks[sName][0]<maxRank then
                        HealBot_Buff_Ranks[sName][0]=maxRank
                    end
                end
            else
                if not HealBot_Spell_Ranks[sName][x] then
                    HealBot_Spell_Ranks[sName][x]=sName..HEALBOT_RANK[x]
                    if HealBot_Spell_Ranks[sName][0]<maxRank then
                        HealBot_Spell_Ranks[sName][0]=maxRank
                    end
                end
            end
        end
    end
end

function HealBot_Init_Spells_CataPriest(spellID, spellName, spellTexture)
    local _, _, _, _, _, hbRange=HealBot_WoWAPI_SpellInfo(spellID)
    local cooldown=GetSpellBaseCooldown(spellID)
    local hbCooldown=tonumber(cooldown or 25);
    if not HealBot_Spell_IDs[spellID] then HealBot_Spell_IDs[spellID]={} end

    HealBot_Spell_IDs[spellID].CastTime=0;
    HealBot_Spell_IDs[spellID].Mana=HealBot_Init_ManaCost(spellID)
    if HealBot_Spell_IDs[spellID].Mana == 0 then HealBot_Spell_IDs[spellID].Mana=1544 end
    HealBot_Spell_IDs[spellID].texture=spellTexture
    HealBot_Spell_IDs[spellID].name=spellName
    HealBot_Spell_IDs[spellID].cooldown=hbCooldown
    HealBot_Spell_Names[spellName]=spellID

    HealBot_Init_SetSpellRange(spellID, spellName, hbRange)
end

local iSpellName, iSpellRank
local function HealBot_Init_CheckSpell(sType, s, sId, iSpellName, iSpellRank)
    --if sType then
        if sType == "SPELL" then
            if iSpellName and not HealBot_WoWAPI_IsSpellPassive(sId) and HealBot_Spells_KnownByName(iSpellName) and not string.find(iSpellName," Rune Ability") then -- and (string.len(iSpellRank)<1 or string.find(iSpellRank,"Rank"))
                HealBot_Init_Spells_addSpell(sId, iSpellName, s, iSpellRank)
            end
        elseif sType == "FLYOUT" then
            local _, _, numFlyoutSlots, flyoutKnown=GetFlyoutInfo(sId)
            if flyoutKnown then
                for f=1,numFlyoutSlots do
                    local fId, _, fKnown, fName=GetFlyoutSlotInfo(sId, f)
                    if fKnown and not HealBot_WoWAPI_IsSpellPassive(fId) and HealBot_Spells_KnownByName(fName) then
                        HealBot_Init_Spells_addSpell(fId, fName, s, iSpellRank)
                    end
                end
            end
        end
    --end
end

function HealBot_Init_Spells_Defaults()
      --HealBot_setCall("HealBot_Init_Spells_Defaults")
    if HealBot_Data["PCLASSTRIM"] then
        for x,_ in pairs(HealBot_Spell_IDs) do
            HealBot_Spell_IDs[x]=nil
        end
        for x,_ in pairs(HealBot_Spell_Names) do
            HealBot_Spell_Names[x]=nil
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
        for x,_ in pairs(HealBot_Ranks) do
            HealBot_Ranks[x]=nil
        end
        HealBot_Init_Spell_RangesPref()
        local nTabs=HealBot_WoWAPI_NumSpellTabs()

        local hbBufflist=HealBot_Options_InitBuffSpellsClassList(HealBot_Data["PCLASSTRIM"])
        for j=1, getn(hbBufflist), 1 do
            if hbBufflist[j] and HealBot_WoWAPI_SpellName(hbBufflist[j]) then
                HealBot_Buff_Names[HealBot_WoWAPI_SpellName(hbBufflist[j])]=true
            end
        end

        HealBot_Init_SkipSpells()

        for j=1,nTabs do
            local _, _, offset, numEntries, _, offspecID=HealBot_WoWAPI_SpellTabInfo(j)
            if offspecID == 0 then
                for s=offset+1,offset+numEntries do
                    --local sName, cRank=HealBot_WoWAPI_SpellBookItemName(s)
                    local sType, sId=HealBot_WoWAPI_SpellBookItemInfo(s)
                    if HEALBOT_GAME_VERSION>10 then
                        iSpellName=HealBot_WoWAPI_SpellName(sId)
                        iSpellRank=""
                    else
                        iSpellName, iSpellRank=HealBot_WoWAPI_SpellBookItemName(s)
                        if not iSpellRank then iSpellRank="" end
                    end
                    if not sType then sType="SPELL" end
                    HealBot_Init_CheckSpell(sType, s, sId, iSpellName, iSpellRank)
                end
            end
        end
        if HEALBOT_GAME_VERSION>10 then 
            if HealBot_Data["PCLASSTRIM"] == "SHAM" then
                HealBot_Init_CheckSpell("SPELL", nil, 77130, HEALBOT_PURIFY_SPIRIT, nil)
            --elseif HealBot_Data["PCLASSTRIM"] == "DRUI" then
            --    HealBot_Init_CheckSpell("SPELL", nil, 88423, HEALBOT_NATURES_CURE, nil)
            end
        end
        if HEALBOT_GAME_VERSION<3 then
            HealBot_InitValidateRanks()
            HealBot_Init_ClassicSpellRanks()
        elseif HEALBOT_GAME_VERSION == 4 and HealBot_Data["PCLASSTRIM"] == "PRIE" then
            HealBot_Init_Spells_CataPriest(HEALBOT_HOLY_WORD_CHASTISE, HEALBOT_SPELL_HOLYWORDCHASTISE, 135886)
            HealBot_Init_Spells_CataPriest(HBC_HOLY_WORD_SERENITY, HEALBOT_SPELL_HOLYWORDSERENITY, 135937)
            HealBot_Init_Spells_CataPriest(HEALBOT_HOLY_WORD_SANCTUARY, HEALBOT_SPELL_HOLYWORDSANCTUARY, 237541)
        end
        if HealBot_Spell_Ranges["HEAL30"] and HealBot_Spell_Ranges["HEAL30"]~="Set" then
            HealBot_Range_InitSpell("HEAL30", HealBot_Spell_Ranges["HEAL30"])
        end
        if HealBot_Spell_Ranges["HARM30"] and HealBot_Spell_Ranges["HARM30"]~="Set" then
            HealBot_Range_InitSpell("HARM30", HealBot_Spell_Ranges["HARM30"])
        end
        if HealBot_Spell_Ranges["HEAL"] and HealBot_Spell_Ranges["HEAL"]~="Set" then
            HealBot_Range_InitSpell("HEAL", HealBot_Spell_Ranges["HEAL"])
        end
        if HealBot_Spell_Ranges["HARM"] and HealBot_Spell_Ranges["HARM"]~="Set" then
            HealBot_Range_InitSpell("HARM", HealBot_Spell_Ranges["HARM"])
        end
    else
        HealBot_SetPlayerData()
        HealBot_Timers_Set("INIT","InitSpellsDefaults",true)
    end
end

function HealBot_Init_ClassicSpellRanks()
      --HealBot_setCall("HealBot_Init_ClassicSpellRanks")
    for hSpell,_ in pairs(HealBot_KnownHeal_Names) do
        if HealBot_Ranks[hSpell] and HealBot_Ranks[hSpell]>1 then
            for f=1, HealBot_Ranks[hSpell], 1 do
                local sNameRank=HealBot_Init_retRank(hSpell, f) --hSpell.."(Rank "..f..")"
                if sNameRank then
                    local _, _, _, _, _, _, spellId=HealBot_WoWAPI_SpellInfo(sNameRank)
                    if spellId then
                        local _, _, texture, msCast, _, hbRange=HealBot_WoWAPI_SpellInfo(spellId);
                        local cooldown=GetSpellBaseCooldown(spellId)
                        local hbCastTime=tonumber(msCast or 0);
                        local hbCooldown=tonumber(cooldown or 0);
                        if hbCastTime>999 then hbCastTime=HealBot_Util_Round(hbCastTime/1000,2) end
                        if hbCooldown>999 then hbCooldown=HealBot_Util_Round(hbCooldown/1000,2) end

                        if not HealBot_Spell_IDs[spellId] then HealBot_Spell_IDs[spellId]={} end
                        HealBot_Spell_IDs[spellId].CastTime=hbCastTime;
                        HealBot_Spell_IDs[spellId].Mana=HealBot_Init_ManaCost(spellId)
                        HealBot_Spell_IDs[spellId].texture=texture
                        HealBot_Spell_IDs[spellId].name=sNameRank
                        HealBot_Spell_IDs[spellId].cooldown=hbCooldown

                        HealBot_Init_SetSpellRange(spellId, sNameRank, hbRange)
                        HealBot_Spell_Names[sNameRank]=spellId
                    end
                end
            end
        end
    end
end

function HealBot_Init_SmartCast()
      --HealBot_setCall("HealBot_Init_SmartCast")
    local rName=""
    if HealBot_Data["PCLASSTRIM"] == "PRIE" then
        rName=HealBot_WoWAPI_SpellName(HEALBOT_MASS_RESURRECTION) or HealBot_WoWAPI_SpellName(HBC_MASS_RESURRECTION)
        if rName and HealBot_Spells_KnownByName(rName) then SmartCast_MassRes=rName end
        rName=HealBot_WoWAPI_SpellName(HEALBOT_RESURRECTION)
        if rName and HealBot_Spells_KnownByName(rName) then SmartCast_Res=rName end
    elseif HealBot_Data["PCLASSTRIM"] == "DRUI" then
        rName=HealBot_WoWAPI_SpellName(HEALBOT_REVITALIZE) or HealBot_WoWAPI_SpellName(HBC_REVITALIZE)
        if rName and HealBot_Spells_KnownByName(rName) then SmartCast_MassRes=rName end
        rName=HealBot_WoWAPI_SpellName(HEALBOT_REVIVE) or HealBot_WoWAPI_SpellName(HBC_REVIVE)
        if rName and HealBot_Spells_KnownByName(rName) then SmartCast_Res=rName end
    elseif HealBot_Data["PCLASSTRIM"] == "MONK" then
        rName=HealBot_WoWAPI_SpellName(HEALBOT_REAWAKEN)
        if rName and HealBot_Spells_KnownByName(rName) then SmartCast_MassRes=rName end
        rName=HealBot_WoWAPI_SpellName(HEALBOT_RESUSCITATE)
        if rName and HealBot_Spells_KnownByName(rName) then SmartCast_Res=rName end
    elseif HealBot_Data["PCLASSTRIM"] == "PALA" then
        rName=HealBot_WoWAPI_SpellName(HEALBOT_ABSOLUTION) or HealBot_WoWAPI_SpellName(HBC_ABSOLUTION)
        if rName and HealBot_Spells_KnownByName(rName) then SmartCast_MassRes=rName end
        rName=HealBot_WoWAPI_SpellName(HEALBOT_REDEMPTION)
        if rName and HealBot_Spells_KnownByName(rName) then SmartCast_Res=rName end
    elseif HealBot_Data["PCLASSTRIM"] == "SHAM" then
        rName=HealBot_WoWAPI_SpellName(HEALBOT_ANCESTRAL_VISION) or HealBot_WoWAPI_SpellName(HBC_ANCESTRAL_VISION)
        if rName and HealBot_Spells_KnownByName(rName) then SmartCast_MassRes=rName end
        rName=HealBot_WoWAPI_SpellName(HEALBOT_ANCESTRALSPIRIT)
        if rName and HealBot_Spells_KnownByName(rName) then SmartCast_Res=rName end
    elseif HealBot_Data["PCLASSTRIM"] == "EVOK" then
        rName=HealBot_WoWAPI_SpellName(HEALBOT_MASS_RETURN)
        if rName and HealBot_Spells_KnownByName(rName) then SmartCast_MassRes=rName end
        rName=HealBot_WoWAPI_SpellName(HEALBOT_RETURN)
        if rName and HealBot_Spells_KnownByName(rName) then SmartCast_Res=rName end
    end
end

local HealBot_Spec={}
function HealBot_Init_ClassicSpecs()
      --HealBot_setCall("HealBot_Init_ClassicSpecs")
    HealBot_Spec={
        ["DRUI"]={ [1]=HEALBOT_BALANCE,       [2]=HEALBOT_FERAL,        [3]=HEALBOT_RESTORATION, },
        ["MAGE"]={ [1]=HEALBOT_ARCANE,        [2]=HEALBOT_FIRE,         [3]=HEALBOT_FROST,       },
        ["PRIE"]={ [1]=HEALBOT_DISCIPLINE,    [2]=HEALBOT_HOLY,         [3]=HEALBOT_SHADOW,      },
        ["ROGU"]={ [1]=HEALBOT_ASSASSINATION, [2]=HEALBOT_COMBAT,       [3]=HEALBOT_SUBTLETY,    },
        ["WARR"]={ [1]=HEALBOT_ARMS,          [2]=HEALBOT_FURY,         [3]=HEALBOT_PROTECTION,  },
        ["HUNT"]={ [1]=HEALBOT_BEASTMASTERY,  [2]=HEALBOT_MARKSMANSHIP, [3]=HEALBOT_SURVIVAL,    },
        ["PALA"]={ [1]=HEALBOT_HOLY,          [2]=HEALBOT_PROTECTION,   [3]=HEALBOT_RETRIBUTION, },
        ["SHAM"]={ [1]=HEALBOT_ELEMENTAL,     [2]=HEALBOT_ENHANCEMENT,  [3]=HEALBOT_SHAMAN_RESTORATION, },
        ["WARL"]={ [1]=HEALBOT_AFFLICTION,    [2]=HEALBOT_DEMONOLOGY,   [3]=HEALBOT_DESTRUCTION, },
        ["DEAT"]={ [1]=HEALBOT_BLOOD,         [2]=HEALBOT_FROST,        [3]=HEALBOT_UNHOLY, },
        }
end

function HealBot_Init_retSpec(class,tab)
      --HealBot_setCall("HealBot_Init_retSpec")
    if HealBot_Spec[class] and HealBot_Spec[class][tab] then
        return HealBot_Spec[class][tab]
    end
    return nil
end

function HealBot_Init_Spells()
    if HealBot_Data["PCLASSTRIM"] then
        HealBot_Spells_Reset(HealBot_Data["PCLASSTRIM"])
        HealBot_Spells_ResetCures(HealBot_Data["PCLASSTRIM"])
        HealBot_Spells_ResetBuffs(HealBot_Data["PCLASSTRIM"])
    else
        HealBot_SetPlayerData()
        HealBot_Timers_Set("LAST","NewCharInitSpells",true)
    end
end

function HealBot_Init_NewChar()
      --HealBot_setCall("HealBot_InitNewChar")
    if not HealBot_Config_Spells.EnemyKeyCombo then
        HealBot_Config_Spells.EnemyKeyCombo={}
    end
    if HealBot_Config_Spells.EnabledKeyCombo["New"] then
        HealBot_Init_Spells()
        HealBot_Config_Buffs.HealBotBuffColR={[1]=1,[2]=1,[3]=1,[4]=1,[5]=1,[6]=1,[7]=1,[8]=1,[9]=1,[10]=1,[11]=1,[12]=1,[13]=1,[14]=1}
        HealBot_Config_Buffs.HealBotBuffColG={[1]=1,[2]=1,[3]=1,[4]=1,[5]=1,[6]=1,[7]=1,[8]=1,[9]=1,[10]=1,[11]=1,[12]=1,[13]=1,[14]=1}
        HealBot_Config_Buffs.HealBotBuffColB={[1]=1,[2]=1,[3]=1,[4]=1,[5]=1,[6]=1,[7]=1,[8]=1,[9]=1,[10]=1,[11]=1,[12]=1,[13]=1,[14]=1}
    end
    if HealBot_Config.CurrentSpec == 9 then
        HealBot_Config.CurrentSpec=1
        HealBot_Update_BuffsForSpec()
    end
end

function HealBot_Init_Plugins()
      --HealBot_setCall("HealBot_Init_Plugins")
    local loaded, reason=HealBot_WoWAPI_LoadAddOn("HealBot_Plugin_Media")
    HealBot_Init_luVars["pluginMediaReason"]=reason or ""
    HealBot_Init_luVars["pluginMediaLoaded"]=loaded
    if loaded and HealBot_Globals.PluginMedia then
        HealBot_Timers_setLuVars("pluginMedia", true)
        HealBot_Plugin_Media_Init()
        HealBot_Media_PluginState(true)
    else
        HealBot_Media_PluginState(false)
        HealBot_Timers_setLuVars("pluginMedia", false)
    end

    loaded, reason=HealBot_WoWAPI_LoadAddOn("HealBot_Plugin_Threat")
    HealBot_Init_luVars["pluginThreatReason"]=reason or ""
    HealBot_Init_luVars["pluginThreatLoaded"]=loaded
    if loaded and HealBot_Globals.PluginThreat then
        HealBot_Aggro_setLuVars("pluginThreat", true)
        HealBot_setLuVars("pluginThreat", true)
        HealBot_Action_setLuVars("pluginThreat", true)
        HealBot_Timers_setLuVars("pluginThreat", true)
        HealBot_Plugin_Threat_Init()
    else
        HealBot_Aggro_setLuVars("pluginThreat", false)
        HealBot_setLuVars("pluginThreat", false)
        HealBot_Action_setLuVars("pluginThreat", false)
        HealBot_Timers_setLuVars("pluginThreat", false)
    end

    loaded, reason=HealBot_WoWAPI_LoadAddOn("HealBot_Plugin_TimeToDie")
    HealBot_Init_luVars["pluginTimeToDieReason"]=reason or ""
    HealBot_Init_luVars["pluginTimeToDieLoaded"]=loaded
    if loaded and HealBot_Globals.PluginTimeToDie then
        HealBot_setLuVars("pluginTimeToDie", true)
        HealBot_Action_setLuVars("pluginTimeToDie", true)
        HealBot_Timers_setLuVars("pluginTimeToDie", true)
        HealBot_Plugin_TimeToDie_Init()
    else
        HealBot_setLuVars("pluginTimeToDie", false)
        HealBot_Action_setLuVars("pluginTimeToDie", false)
        HealBot_Timers_setLuVars("pluginTimeToDie", false)
    end

    loaded, reason=HealBot_WoWAPI_LoadAddOn("HealBot_Plugin_TimeToLive")
    HealBot_Init_luVars["pluginTimeToLiveReason"]=reason or ""
    HealBot_Init_luVars["pluginTimeToLiveLoaded"]=loaded
    if loaded and HealBot_Globals.PluginTimeToLive then
        HealBot_setLuVars("pluginTimeToLive", true)
        HealBot_Action_setLuVars("pluginTimeToLive", true)
        HealBot_Timers_setLuVars("pluginTimeToLive", true)
        HealBot_Plugin_TimeToLive_Init()
    else
        HealBot_setLuVars("pluginTimeToLive", false)
        HealBot_Action_setLuVars("pluginTimeToLive", false)
        HealBot_Timers_setLuVars("pluginTimeToLive", false)
    end

    loaded, reason=HealBot_WoWAPI_LoadAddOn("HealBot_Plugin_ExtraButtons")
    HealBot_Init_luVars["pluginExtraButtonsReason"]=reason or ""
    HealBot_Init_luVars["pluginExtraButtonsLoaded"]=loaded
    if loaded and HealBot_Globals.PluginExtraButtons then
        HealBot_Action_setLuVars("pluginExtraButtons", true)
        HealBot_Timers_Set("INIT","PrepSetAllAttribs",true)
    else
        HealBot_Action_setLuVars("pluginExtraButtons", false)
    end

    loaded, reason=HealBot_WoWAPI_LoadAddOn("HealBot_Plugin_CombatProt")
    HealBot_Init_luVars["pluginCombatProtReason"]=reason or ""
    HealBot_Init_luVars["pluginCombatProtLoaded"]=loaded
    if loaded and HealBot_Globals.PluginCombatProt then
        HealBot_Timers_setLuVars("pluginCombatProt", true)
        HealBot_Plugin_CombatProt_Init()
    else
        HealBot_Globals.UseCrashProt=false
        HealBot_Timers_setLuVars("pluginCombatProt", false)
    end

    loaded, reason=HealBot_WoWAPI_LoadAddOn("HealBot_Plugin_Performance")
    HealBot_Init_luVars["pluginPerformanceReason"]=reason or ""
    HealBot_Init_luVars["pluginPerformanceLoaded"]=loaded
    if loaded and HealBot_Globals.PluginPerformance then
        HealBot_Timers_setLuVars("pluginPerformance", true)
        HealBot_Plugin_Performance_Init()
    else
        HealBot_Timers_setLuVars("pluginPerformance", false)
    end

    loaded, reason=HealBot_WoWAPI_LoadAddOn("HealBot_Plugin_Tweaks")
    HealBot_Init_luVars["pluginTweaksReason"]=reason or ""
    HealBot_Init_luVars["pluginTweaksLoaded"]=loaded
    if loaded and HealBot_Globals.PluginTweaks then
        HealBot_Timers_setLuVars("pluginTweaks", true)
        HealBot_Panel_setLuVars("pluginTweaks", true)
        HealBot_Plugin_Tweaks_Init()
    else
        HealBot_Timers_setLuVars("pluginTweaks", false)
        HealBot_Panel_setLuVars("pluginTweaks", true)
    end

    loaded, reason=HealBot_WoWAPI_LoadAddOn("HealBot_Plugin_Requests")
    HealBot_Init_luVars["pluginRequestsReason"]=reason or ""
    HealBot_Init_luVars["pluginRequestsLoaded"]=loaded
    if loaded and HealBot_Globals.PluginRequests then
        HealBot_Action_setLuVars("pluginRequests", true)
        HealBot_Plugin_Requests_Init()
    else
        HealBot_Action_setLuVars("pluginRequests", false)
    end

    loaded, reason=HealBot_WoWAPI_LoadAddOn("HealBot_Plugin_AuraWatch")
    HealBot_Init_luVars["pluginAuraWatchReason"]=reason or ""
    HealBot_Init_luVars["pluginAuraWatchLoaded"]=loaded
    if loaded and HealBot_Globals.PluginAuraWatch then
        HealBot_Range_setLuVars("pluginAuraWatch", true)
        HealBot_setLuVars("pluginAuraWatch", true)
        HealBot_Action_setLuVars("pluginAuraWatch", true)
        HealBot_Events_setLuVars("pluginAuraWatch", true)
        HealBot_Plugin_AuraWatch_Init()
    else
        HealBot_Range_setLuVars("pluginAuraWatch", false)
        HealBot_setLuVars("pluginAuraWatch", false)
        HealBot_Action_setLuVars("pluginAuraWatch", false)
        HealBot_Events_setLuVars("pluginAuraWatch", false)
    end

    loaded, reason=HealBot_WoWAPI_LoadAddOn("HealBot_Plugin_HealthWatch")
    HealBot_Init_luVars["pluginHealthWatchReason"]=reason or ""
    HealBot_Init_luVars["pluginHealthWatchLoaded"]=loaded
    if loaded and HealBot_Globals.PluginHealthWatch then
        HealBot_Action_setLuVars("pluginHealthWatch", true)
        HealBot_setLuVars("pluginHealthWatch", true)
        HealBot_Timers_setLuVars("pluginHealthWatch", true)
        HealBot_Plugin_HealthWatch_Init()
    else
        HealBot_Action_setLuVars("pluginHealthWatch", false)
        HealBot_setLuVars("pluginHealthWatch", false)
        HealBot_Timers_setLuVars("pluginHealthWatch", false)
    end

    loaded, reason=HealBot_WoWAPI_LoadAddOn("HealBot_Plugin_ManaWatch")
    HealBot_Init_luVars["pluginManaWatchReason"]=reason or ""
    HealBot_Init_luVars["pluginManaWatchLoaded"]=loaded
    if loaded and HealBot_Globals.PluginManaWatch then
        HealBot_Action_setLuVars("pluginManaWatch", true)
        HealBot_setLuVars("pluginManaWatch", true)
        HealBot_Timers_setLuVars("pluginManaWatch", true)
        HealBot_Plugin_ManaWatch_Init()
    else
        HealBot_Action_setLuVars("pluginManaWatch", false)
        HealBot_setLuVars("pluginManaWatch", false)
        HealBot_Timers_setLuVars("pluginManaWatch", false)
    end

    loaded, reason=HealBot_WoWAPI_LoadAddOn("HealBot_Plugin_MyCooldowns")
    HealBot_Init_luVars["pluginMyCooldownsReason"]=reason or ""
    HealBot_Init_luVars["pluginMyCooldownsLoaded"]=loaded
    if loaded and HealBot_Globals.PluginMyCooldowns then
        HealBot_setLuVars("pluginMyCooldowns", true)
        HealBot_Timers_setLuVars("pluginMyCooldowns", true)
        HealBot_Events_setLuVars("pluginMyCooldowns", true)
        HealBot_Plugin_MyCooldowns_Init()
    else
        HealBot_setLuVars("pluginMyCooldowns", false)
        HealBot_Timers_setLuVars("pluginMyCooldowns", false)
        HealBot_Events_setLuVars("pluginMyCooldowns", false)
    end

    HealBot_Timers_Set("LAST","RegAggro")
end
