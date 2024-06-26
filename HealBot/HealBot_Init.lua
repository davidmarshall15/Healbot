local SmartCast_Res=nil;
local SmartCast_MassRes=nil;
local HealBot_Heal_Names={}
local HealBot_Buff_Names={}
local HealBot_KnownHeal_Names={}
local HealBot_Spell_Ranks={}
local HealBot_Buff_Ranks={}
local _

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

function HealBot_Init_TalentLookupImproved(callback)
      --HealBot_setCall("HealBot_Init_TalentLookupImproved")
    if HEALBOT_GAME_VERSION>9 then 
        local pattern=false
        local improved=false
        if HealBot_Data["PCLASSTRIM"]=="PRIE" then
            pattern=HEALBOT_IMPROVEDPURIFY
        elseif HealBot_Data["PCLASSTRIM"]=="PALA" then
            pattern=HEALBOT_IMPROVEDCLEANSE
        elseif HealBot_Data["PCLASSTRIM"]=="SHAM" then
            pattern=HEALBOT_IMPROVEDPURIFY_SPIRIT
        elseif HealBot_Data["PCLASSTRIM"]=="DRUI" then
            pattern=HEALBOT_IMPROVEDNATURES_CURE
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
                    elseif HealBot_Data["PCLASSTRIM"]=="DRUI" then
                        if improved then
                            HealBot_Options_setLuVars("DruidImprovedNaturesCure", true)
                        else
                            HealBot_Options_setLuVars("DruidImprovedNaturesCure", false)
                        end
                    end
                elseif not callback then
                    HealBot_Timers_Set("LAST","TalentsLookupImprovedCallback",15)
                end
            elseif not callback then
                HealBot_Timers_Set("LAST","TalentsLookupImprovedCallback",15)
            end
        end
    elseif HEALBOT_GAME_VERSION>3 then
        if HealBot_Data["PCLASSTRIM"]=="SHAM" then
            local _, _, _, _, rank = GetTalentInfo(3, 12)
            if rank>0 then
                HealBot_Options_setLuVars("ShamanImprovedCleanseSpirit", true)
            else
                HealBot_Options_setLuVars("ShamanImprovedCleanseSpirit", false)
            end
        elseif HealBot_Data["PCLASSTRIM"]=="DRUI" then
            local _, _, _, _, rank = GetTalentInfo(3, 15)
            if rank>0 then
                HealBot_Options_setLuVars("DruidImprovedNaturesCure", true)
            else
                HealBot_Options_setLuVars("DruidImprovedNaturesCure", false)
            end
        elseif HealBot_Data["PCLASSTRIM"]=="PALA" then
            local _, _, _, _, rank = GetTalentInfo(1, 14)
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
    if spellBookId then
        if manaCost==0 then
            if not tipSet then
                HealBot_SetToolTip(HealBot_ScanTooltip)
                HealBot_ScanTooltip:SetSpellBookItem(spellBookId, BOOKTYPE_SPELL);
            end
            local ttText = getglobal("HealBot_ScanTooltipTextLeft2");
            if (ttText:GetText()) then
                local line = ttText:GetText();
                if line then 
                    manaCost = tonumber((gsub(line, "%D", "")))
                end
                if manaCost==0 then
                    ttText = getglobal("HealBot_ScanTooltipTextLeft3")
                    line = ttText:GetText()
                    if line then 
                        manaCost = tonumber((gsub(line, "%D", "")))
                    end
                end
            end
        end
    end
    if not manaCost or type(manaCost)~="number" then manaCost=0 end
    return manaCost
end

local HealBot_Spell_Ranges={}
local HealBot_Spell_RangesPref={}
local function HealBot_Init_Spell_RangesPref()
    HealBot_Spell_Ranges={}
    if HealBot_Data["PCLASSTRIM"]=="DRUI" then
        HealBot_Spell_RangesPref[HEALBOT_WRATH]=true
        HealBot_Spell_RangesPref[HEALBOT_HURRICANE]=true
        HealBot_Spell_RangesPref[HEALBOT_REJUVENATION]=true
        HealBot_Spell_RangesPref[HEALBOT_HEALING_TOUCH]=true
    elseif HealBot_Data["PCLASSTRIM"]=="MAGE" then
        HealBot_Spell_RangesPref[HEALBOT_FROSTFIRE_BOLT]=true
        HealBot_Spell_RangesPref[HEALBOT_FIRE_BLAST]=true
    elseif HealBot_Data["PCLASSTRIM"]=="PALA" then
        HealBot_Spell_RangesPref[HEALBOT_HOLY_SHOCK]=true
        HealBot_Spell_RangesPref[HEALBOT_JUDGMENT]=true
        HealBot_Spell_RangesPref[HEALBOT_FLASH_OF_LIGHT]=true
        HealBot_Spell_RangesPref[HEALBOT_HOLY_LIGHT]=true
        HealBot_Spell_RangesPref[HBC_HOLY_LIGHT]=true
    elseif HealBot_Data["PCLASSTRIM"]=="PRIE" then
        HealBot_Spell_RangesPref[HEALBOT_SMITE]=true
        HealBot_Spell_RangesPref[HEALBOT_SHADOW_WORD_PAIN]=true
        HealBot_Spell_RangesPref[HEALBOT_FLASH_HEAL]=true
        HealBot_Spell_RangesPref[HEALBOT_RENEW]=true
    elseif HealBot_Data["PCLASSTRIM"]=="SHAM" then
        HealBot_Spell_RangesPref[HEALBOT_LIGHTNING_BOLT]=true
        HealBot_Spell_RangesPref[HBC_LIGHTNING_BOLT]=true
        HealBot_Spell_RangesPref[HEALBOT_HEALING_WAVE]=true
        HealBot_Spell_RangesPref[HEALBOT_HEALING_SURGE]=true
        HealBot_Spell_RangesPref[HBC_HEALING_WAVE]=true
    elseif HealBot_Data["PCLASSTRIM"]=="MONK" then
        HealBot_Spell_RangesPref[HEALBOT_CRACKLING_JADE_LIGHTNING]=true
        HealBot_Spell_RangesPref[HEALBOT_SOOTHING_MIST]=true
    elseif HealBot_Data["PCLASSTRIM"]=="WARL" then
        HealBot_Spell_RangesPref[HEALBOT_CORRUPTION]=true
        HealBot_Spell_RangesPref[HEALBOT_FEAR]=true
    elseif HealBot_Data["PCLASSTRIM"]=="WARR" then
        HealBot_Spell_RangesPref[HEALBOT_TAUNT]=true
    elseif HealBot_Data["PCLASSTRIM"]=="HUNT" then
        HealBot_Spell_RangesPref[HEALBOT_ARCANE_SHOT]=true
        HealBot_Spell_RangesPref[HEALBOT_CONCUSSIVE_SHOT]=true
        HealBot_Spell_RangesPref[HEALBOT_AIMED_SHOT]=true
        HealBot_Spell_RangesPref[HEALBOT_MENDPET]=true
    elseif HealBot_Data["PCLASSTRIM"]=="ROGU" then
        HealBot_Spell_RangesPref[HEALBOT_THROW]=true
        HealBot_Spell_RangesPref[HEALBOT_GOUGE]=true
    elseif HealBot_Data["PCLASSTRIM"]=="DEAT" then
        HealBot_Spell_RangesPref[HEALBOT_DEATH_COIL]=true
        HealBot_Spell_RangesPref[HEALBOT_PLAGUE_STRIKE]=true
    elseif HealBot_Data["PCLASSTRIM"]=="DEMO" then
        HealBot_Spell_RangesPref[185123]=true
        HealBot_Spell_RangesPref[185245]=true
    elseif HealBot_Data["PCLASSTRIM"]=="EVOK" then
        HealBot_Spell_RangesPref[361469]=true
        HealBot_Spell_RangesPref[362969]=true
        HealBot_Spell_RangesPref[HEALBOT_LIVING_FLAME]=true
        HealBot_Spell_RangesPref[HEALBOT_ECHO]=true
    end
end

function HealBot_Init_SetRangeSpells(sType, spellName, spellId)
    if HealBot_Spell_RangesPref[spellId] then
        HealBot_Range_InitSpell(sType, spellName)
        if (HealBot_Spell_Ranges[sType] or "z")~="Set" then HealBot_AddDebug("["..sType.."] Init range for "..spellName.." is Preferred | id="..spellId, "Init Range Spell",true) end
        HealBot_Spell_Ranges[sType]="Set"
    elseif not HealBot_Spell_Ranges[sType] then
        HealBot_Spell_Ranges[sType]=spellName
    end
end

function HealBot_Init_SetSpellRange(id, spellName, range)
    HealBot_Spell_IDs[id].range=range
    if range==30 then
        if HealBot_WoWAPI_HelpfulSpell(spellName) then 
            HealBot_Init_SetRangeSpells("HEAL30", spellName, id)
        --    HealBot_AddDebug("[HEAL30] Init range for "..spellName.." is "..range,"Range Helpful 30",true)
        elseif IsHarmfulSpell(spellName) then
            HealBot_Init_SetRangeSpells("HARM30", spellName, id)
            --HealBot_AddDebug("[HARM30] Init range for "..spellName.." is "..range,"Range Harmful 30",true)
        end
    elseif range==40 then 
        if HealBot_WoWAPI_HelpfulSpell(spellName) then
            HealBot_Init_SetRangeSpells("HEAL", spellName, id)
            --HealBot_AddDebug([HEAL] "Init range for "..spellName.." is "..range,"Range Helpful 40",true)
        elseif IsHarmfulSpell(spellName) then 
            HealBot_Init_SetRangeSpells("HARM", spellName, id)
            --HealBot_AddDebug([HARM] "Init range for "..spellName.." is "..range,"Range Harmful 40",true)
        end
    end
end

function HealBot_Init_FindSpellRangeCast(id, spellName, spellBookId)
      --HealBot_setCall("HealBot_Init_FindSpellRangeCast")
    local cRank=false
    if ( not id ) then return false; end

    local spell, _, texture, msCast, _, hbRange = HealBot_WoWAPI_SpellInfo(id);
    local cooldown = GetSpellBaseCooldown(id)

    if ( not spell ) then return false; end
    if not spellName then spellName=spell end
    
    if spellBookId then HealBot_SetToolTip(HealBot_ScanTooltip); HealBot_ScanTooltip:SetSpellBookItem(spellBookId, BOOKTYPE_SPELL) end
    if HealBot_Data["PCLASSTRIM"]=="PRIE" then
        if spellName==HEALBOT_PURIFY then 
            if spellBookId and EnumerateTooltipLines_helper(HEALBOT_DISEASE, HealBot_ScanTooltip:GetRegions()) then
                HealBot_Options_setLuVars("PriestImprovedPurify", true)
            else
                HealBot_Timers_Set("LAST","TalentsLookupImproved",1)
            end
        end
    elseif HealBot_Data["PCLASSTRIM"]=="PALA" then
        if spellName==HEALBOT_CLEANSE then
            if HEALBOT_GAME_VERSION>9 then
                if spellBookId and EnumerateTooltipLines_helper(HEALBOT_DISEASE, HealBot_ScanTooltip:GetRegions()) or EnumerateTooltipLines_helper(HEALBOT_POISON, HealBot_ScanTooltip:GetRegions()) then
                    HealBot_Options_setLuVars("PaladinImprovedCleanse", true)
                else
                    HealBot_Timers_Set("LAST","TalentsLookupImproved",1)
                end
            else
                if spellBookId and HealBot_Config.CurrentSpec==1 and EnumerateTooltipLines_helper(HEALBOT_MAGIC, HealBot_ScanTooltip:GetRegions()) then
                    HealBot_Options_setLuVars("PaladinImprovedCleanse", true)
                else
                    HealBot_Timers_Set("LAST","TalentsLookupImproved",1)
                end
            end
        end
    elseif HealBot_Data["PCLASSTRIM"]=="SHAM" then
        if spellName==HEALBOT_PURIFY_SPIRIT then
            if spellBookId and EnumerateTooltipLines_helper(HEALBOT_CURSE, HealBot_ScanTooltip:GetRegions()) then
                HealBot_Options_setLuVars("ShamanImprovedPurifySpirit", true)
            else
                HealBot_Timers_Set("LAST","TalentsLookupImproved",1)
            end
        elseif spellName==HEALBOT_CLEANSE_SPIRIT then
            if spellBookId and HealBot_Config.CurrentSpec==3 and EnumerateTooltipLines_helper(HEALBOT_MAGIC, HealBot_ScanTooltip:GetRegions()) then
                HealBot_Options_setLuVars("ShamanImprovedCleanseSpirit", true)
            else
                HealBot_Timers_Set("LAST","TalentsLookupImproved",1)
            end
        end
    elseif HealBot_Data["PCLASSTRIM"]=="DRUI" then
        if spellName==HEALBOT_NATURES_CURE then
            if spellBookId and EnumerateTooltipLines_helper(HEALBOT_POISON, HealBot_ScanTooltip:GetRegions()) then
                HealBot_Options_setLuVars("DruidImprovedNaturesCure", true)
            else
                HealBot_Timers_Set("LAST","TalentsLookupImproved",1)
            end
        elseif spellName==HBC_DRUID_REMOVE_CURSE then
            if spellBookId and HealBot_Config.CurrentSpec==3 and EnumerateTooltipLines_helper(HEALBOT_MAGIC, HealBot_ScanTooltip:GetRegions()) then
                HealBot_Options_setLuVars("DruidImprovedNaturesCure", true)
            else
                HealBot_Timers_Set("LAST","TalentsLookupImproved",1)
            end
        end
    elseif HealBot_Data["PCLASSTRIM"]=="MONK" then
        --HealBot_Timers_Set("LAST","TalentsLookupImproved",1)
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
    HealBot_Init_SetSpellRange(id, spellName, hbRange)
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
        HealBot_Init_FindSpellRangeCast(spellId, spellName, spellBookId)
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

-- Temporary workaround for TWW spellbook
local TWWFixList={
    HEALBOT_MINDBENDER,
    HEALBOT_SMITE,
    HEALBOT_HOLY_WORD_CHASTISE,
    HEALBOT_HOLY_FIRE,
    HEALBOT_SHADOW_WORD_PAIN,
    HEALBOT_WRATH,
    HEALBOT_FAERIE_FIRE,
    HEALBOT_JAB,
    HEALBOT_TIGER_PALM,
    HEALBOT_CHI_BURST,
    HEALBOT_JUDGMENT,
    HEALBOT_SHIELD_OF_THE_RIGHTEOUS,
    HEALBOT_CRUSADER_STRIKE,
    HEALBOT_CHAIN_LIGHTNING,
    HEALBOT_ELEMENTAL_BLAST,
    HEALBOT_FLAME_SHOCK,
    HBC_FLAME_SHOCK,
    HEALBOT_FROST_SHOCK,
    HEALBOT_MAGE_BOMB,
    HEALBOT_CONCUSSIVE_SHOT,
    HEALBOT_PLAGUE_STRIKE,
    HEALBOT_GOUGE,
    HEALBOT_CORRUPTION,
    HEALBOT_EXECUTE,
    HEALBOT_EARTH_SHOCK,
    HEALBOT_LAVA_BLAST,
    HEALBOT_LIGHTNING_BOLT,
    HBC_LIGHTNING_BOLT,
    HEALBOT_FAERIE_SWARM,
    HEALBOT_MOONFIRE,
    HEALBOT_PRIMAL_STRIKE,
    HEALBOT_MIND_SEAR,
    HEALBOT_SHADOW_WORD_DEATH,
    HEALBOT_BLACKOUT_KICK,
    HEALBOT_TOUCH_OF_DEATH,
    HEALBOT_CRACKLING_JADE_LIGHTNING,
    HEALBOT_DENOUNCE,
    HEALBOT_HAMMER_OF_WRATH,
    HEALBOT_HOLY_SHOCK,
    HEALBOT_TAUNT,
    HEALBOT_FEAR,
    HEALBOT_THROW,
    HEALBOT_DEATH_COIL,
    HEALBOT_ARCANE_SHOT,
    HEALBOT_AIMED_SHOT,
    HEALBOT_FIRE_BLAST,
    HEALBOT_FROSTFIRE_BOLT,
    HEALBOT_BINDING_HEAL,
    HEALBOT_HOLY_NOVA,
    HEALBOT_UNHOLY_HOVA,
    HEALBOT_CIRCLE_OF_HEALING,
    HEALBOT_DESPERATE_PRAYER,
    HEALBOT_CHAIN_HEAL,
    HEALBOT_SPIRIT_LINK_TOTEM,
    HEALBOT_FLASH_HEAL,
    HEALBOT_POWER_WORD_LIFE,
    HEALBOT_HOLY_WORD_SERENITY,
    HBC_HOLY_WORD_SERENITY,
    HEALBOT_SURGING_MIST,
    HEALBOT_HOLY_WORD_SALVATION,
    HEALBOT_FLASH_OF_LIGHT,
    HEALBOT_GREATER_HEAL,
    HEALBOT_HEALING_TOUCH,
    HEALBOT_HEAL,
    HBC_HEAL,
    HBC_HOLY_NOVA,
    HEALBOT_HEALING_WAVE,
    HBC_HEALING_WAVE,
    HBC_LESSER_HEALING_WAVE,
    HBC_RU_LESSER_HEALING_WAVE,
    HEALBOT_HEALING_SURGE,
    HEALBOT_LIGHT_OF_DAWN,
    HEALBOT_HOLY_LIGHT,
    HBC_HOLY_LIGHT,
    HEALBOT_HOLY_RADIANCE,
    HEALBOT_HOLY_PRISM,
    HEALBOT_WORD_OF_GLORY,
    HEALBOT_DIVINE_LIGHT,
    HEALBOT_LAY_ON_HANDS,
    HEALBOT_TYRS_DELIVERANCE,
    HEALBOT_LIFEBLOOM,
    HEALBOT_HEALING_STREAM_TOTEM,
    HEALBOT_HEALING_TIDE_TOTEM,
    HEALBOT_PENANCE,
    HEALBOT_PRAYER_OF_HEALING,
    HEALBOT_PRAYER_OF_MENDING,
    HEALBOT_RIPTIDE,
    HEALBOT_PRIMORDIAL_WAVE,
    HEALBOT_WELLSPRING,
    HEALBOT_DOWNPOUR,
    HEALBOT_REGROWTH,
    HEALBOT_NOURISH,
    HBC_NOURISH,
    HEALBOT_RENEW,
    HEALBOT_DIVINE_HYMN,
    HEALBOT_HEALING_RAIN,
    HEALBOT_REJUVENATION,
    HEALBOT_OVERGROWTH,
    HEALBOT_WILD_GROWTH,
    HEALBOT_SWIFTMEND,
    HEALBOT_TRANQUILITY,
    HEALBOT_GIFT_OF_THE_NAARU,
    HEALBOT_MENDPET,
    HEALBOT_HEALTH_FUNNEL,
    HEALBOT_SOOTHING_MIST,
    HEALBOT_ZEN_MEDITATION,
    HEALBOT_LIFE_COCOON,
    HEALBOT_ENVELOPING_MIST,
    HEALBOT_REVIVAL,
    HEALBOT_RENEWING_MIST,
    HEALBOT_UPLIFT,
    HEALBOT_CHI_WAVE,
    HEALBOT_ZEN_SPHERE,
    HEALBOT_EXECUTION_SENTENCE,
    HEALBOT_CASCADE,
    HEALBOT_DIVINE_STAR,
    HEALBOT_HALO,                               
    HEALBOT_CLARITY_OF_PURPOSE,
    HEALBOT_CENARION_WARD,
    HEALBOT_BREATH_OF_THE_SERPENT,
    HEALBOT_CHI_EXPLOSION,
    HEALBOT_RUSHING_JADE_WIND,              
    HEALBOT_CHI_TOROEDO,
    HEALBOT_BEACON_OF_LIGHT,
    HEALBOT_PLEA,                       
    HEALBOT_POWER_WORD_RADIANCE,            
    HEALBOT_SHADOW_COVENANT,                
    HEALBOT_SHADOW_MEND,
    HEALBOT_HOLY_WORD_SANCTIFY,              
    HEALBOT_BESTOW_FAITH,                 
    HEALBOT_LIGHT_OF_THE_MARTYR, 
    HEALBOT_BEACON_OF_VIRTUE,     
    HEALBOT_HAND_OF_THE_PROTECTOR,   
    HEALBOT_ESSENCE_FONT,
    HEALBOT_LIGHT_OF_TUURE,   
    HEALBOT_LIVING_FLAME,
    HEALBOT_EMERALD_BLOSSOM,
    HEALBOT_ECHO,
    HEALBOT_DREAM_FLIGHT,
    HEALBOT_REVERSION,
    HEALBOT_REWIND,
    HEALBOT_DREAM_BREATH,
    HEALBOT_SPIRITBLOOM,
    HEALBOT_VERDANT_EMBRACE,
    HEALBOT_RENEWING_BLAZE,
    HEALBOT_DREAM_PROJECTION,
    HEALBOT_EMERALD_COMMUNION,
    HEALBOT_HEX,
    HEALBOT_ENTANGLING_ROOTS,
    HEALBOT_GROWL,
    HEALBOT_SOOTHE,
    HEALBOT_MASS_ENTANGLEMENT,
    HEALBOT_PURGE,
    HEALBOT_WIND_SHEAR,
    HEALBOT_CYCLONE,
    HEALBOT_DOMINATE_MIND,
    HEALBOT_SHACKLE_UNDEAD,
    HEALBOT_DISPELL_MAGIC,
    HEALBOT_PROVOKE,
    HEALBOT_DISABLE,
    HEALBOT_EXPEL_HARM,
    HEALBOT_SPEAR_HAND_STRIKE,
    HEALBOT_PARALYSIS,
    HEALBOT_HAMMER_OF_JUSTICE,
    HEALBOT_REBUKE,
    HEALBOT_RECKONING,
    HEALBOT_REPENTANCE,
    HEALBOT_TURN_EVIL,
    HEALBOT_STONEFORM,
    HEALBOT_DARKFLIGHT,
    HEALBOT_POWER_WORD_SHIELD,
    HEALBOT_SPIRIT_SHELL,
    HEALBOT_REVIVE,
    HEALBOT_INTERCESSION,
    HEALBOT_GUARDIAN_SPIRIT,
    HEALBOT_SHINING_FORCE,
    HEALBOT_PAIN_SUPPRESSION,
    HEALBOT_INTERVENE,
    HEALBOT_RESURRECTION,
    HEALBOT_REDEMPTION,
    HEALBOT_REBIRTH,
    HEALBOT_TREE_OF_LIFE,
    HEALBOT_INNERVATE,
    HEALBOT_ANCESTRALSPIRIT,
    HEALBOT_RESUSCITATE,
    HEALBOT_ABSOLUTION,
    HEALBOT_ANCESTRAL_VISION,
    HEALBOT_MASS_RESURRECTION,
    HEALBOT_MASS_RETURN,
    HEALBOT_RETURN,
    HEALBOT_REAWAKEN,
    HEALBOT_REVITALIZE,
    HEALBOT_CLEANSE,
    HEALBOT_REMOVE_CURSE,
    HEALBOT_CLEANSE_TOXIN,
    HEALBOT_REMOVE_CORRUPTION,
    HEALBOT_NATURALIZE,
    HEALBOT_CAUTERIZING_FLAME,
    HEALBOT_EXPUNGE,
    HEALBOT_NATURES_CURE,
    HEALBOT_PURIFY_DISEASE,
    HEALBOT_PURIFY,
    HBC_PURIFY,
    HBC_SHAMAN_CURE_DISEASE,
    HBC_DRUID_ABOLISH_POISON,
    HBC_PRIEST_ABOLISH_DISEASE,
    HBC_DRUID_CURE_POISON,
    HBC_SHAMAN_CURE_POISON,
    HEALBOT_BLOODLUST,
    HEALBOT_HEROISM,
    HBC_DISPELL_MAGIC,
    HEALBOT_CLEANSE_SPIRIT,
    HEALBOT_PURIFY_SPIRIT,
    HEALBOT_MASS_DISPEL,
    HEALBOT_LIFE_TAP,
    HEALBOT_DIVINE_SHIELD,
    HEALBOT_DIVINE_PROTECTION,
    HBC_DIVINE_INTERVENTION,
    HBC_DIVINE_FAVOR,
    HEALBOT_ANACESTRAL_SWIFTNESS,
    HEALBOT_LEAP_OF_FAITH,
    HEALBOT_UNLEASH_ELEMENTS,
    HEALBOT_DETOX,
    HEALBOT_SPEED_OF_LIGHT,
    HEALBOT_HAND_OF_PURITY,
    HEALBOT_THUNDER_FOCUS_TEA,
    HEALBOT_ASTRAL_SHIFT,
    HEALBOT_GUARDIAN_ANCIENT_KINGS,
    HEALBOT_UNLEASH_LIFE,
    HEALBOT_CLOUDBURST_TOTEM,
    HEALBOT_POWER_INFUSION,
    HEALBOT_VAMPIRIC_EMBRACE,
    HEALBOT_CLARITY_OF_WILL,
    HEALBOT_DETONATE_CHI,
    HEALBOT_BEACON_OF_FAITH,
    HEALBOT_BEACON_OF_INSIGHT,
    HEALBOT_RAPTURE,
    HEALBOT_APOTHEOSIS,
    HEALBOT_SYMBOL_OF_HOPE,
    HEALBOT_BODY_AND_MIND,
    HEALBOT_BLESSING_OF_SACRIFICE,
    HEALBOT_HOLY_WARD,
    HEALBOT_RESCUE,
    HEALBOT_ZEPHYR,
    HEALBOT_OBSIDIAN_SCALES,
    HEALBOT_TIME_DILATION,
    HEALBOT_TIME_STOP,
    HEALBOT_STASIS,
    HEALBOT_FURY_OF_THE_ASPECTS,
    HEALBOT_VISAGE,
    HEALBOT_TEMPRAL_ANOMALY,
    HEALBOT_NULLIFYING_SHROUD,
}

local TWWSpellList={}
local TWWNoDups={}
function HealBot_Init_Spells_TWWFix()
    local sID, sName
    for x,_ in pairs(TWWSpellList) do
        TWWSpellList[x]=nil
    end
    for x,_ in pairs(TWWNoDups) do
        TWWNoDups[x]=nil
    end
    for j=1, getn(TWWFixList), 1 do
        if type(TWWFixList[j])=="number" then
            sID=TWWFixList[j]
            sName=HealBot_Spells_KnownByID(sID)
        else
            sName=TWWFixList[j]
            sID=HealBot_Spells_KnownByName(sName)
        end
        if sID and sName and not TWWNoDups[sName] then
            TWWNoDups[sName]=true
            TWWSpellList[sID]=sName
        end
    end
end

function HealBot_Init_Spells_CataPriest(spellID, spellName, spellTexture)
    local _, _, _, _, _, hbRange = HealBot_WoWAPI_SpellInfo(spellID)
    local cooldown = GetSpellBaseCooldown(spellID)
    local hbCooldown=tonumber(cooldown or 25);
    if not HealBot_Spell_IDs[spellID] then HealBot_Spell_IDs[spellID]={} end
    
    HealBot_Spell_IDs[spellID].CastTime=0;
    HealBot_Spell_IDs[spellID].Mana=HealBot_Init_ManaCost(spellID)
    if HealBot_Spell_IDs[spellID].Mana==0 then HealBot_Spell_IDs[spellID].Mana=1544 end
    HealBot_Spell_IDs[spellID].texture=spellTexture
    HealBot_Spell_IDs[spellID].name=spellName
    HealBot_Spell_IDs[spellID].cooldown=hbCooldown
    HealBot_Spell_Names[spellName]=spellID
    
    HealBot_Init_SetSpellRange(spellID, spellName, hbRange)
end

function HealBot_Init_Spells_Defaults()
      --HealBot_setCall("HealBot_Init_Spells_Defaults")
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
    if HEALBOT_GAME_VERSION>10 then
        HealBot_Init_Spells_TWWFix()
        for sID,sName in pairs(TWWSpellList) do
            HealBot_Init_Spells_addSpell(sID, sName)
        end
    else
        for j=1,nTabs do
            local _, _, offset, numEntries, _, offspecID = HealBot_WoWAPI_SpellTabInfo(j)
            if not offspecID then offspecID=1 end
            --HealBot_AddDebug("offset="..offset.."  numEntries"..numEntries.."  offspecID="..offspecID,"Init Spells",true)
            if offspecID==0 then
                for s=offset+1,offset+numEntries do
                    --HealBot_AddDebug("Tabinfo slot="..s,"Init Spells",true)
                    local sName, cRank = HealBot_WoWAPI_SpellBookItemName(s, BOOKTYPE_SPELL)
                    local sType, sId = HealBot_WoWAPI_SpellBookItemInfo(s, BOOKTYPE_SPELL)
                    --local sName, cRank = HealBot_WoWAPI_SpellInfo(sId)
                    if not cRank then cRank="" end
                    if sType == "SPELL" and not HealBot_WoWAPI_IsSpellPassive(sId) and HealBot_Spells_KnownByName(sName) and not string.find(sName," Rune Ability") then -- and (string.len(cRank)<1 or string.find(cRank,"Rank")) 
                        HealBot_Init_Spells_addSpell(sId, sName, s, cRank)
                    elseif sType == "FLYOUT" then
                        local _, _, numFlyoutSlots, flyoutKnown = GetFlyoutInfo(sId)
                        if flyoutKnown then
                            for f=1,numFlyoutSlots do
                                local fId, _, fKnown, fName = GetFlyoutSlotInfo(sId, f)
                                if fKnown and not HealBot_WoWAPI_IsSpellPassive(fId) and HealBot_Spells_KnownByName(fName) then
                                    HealBot_Init_Spells_addSpell(fId, fName, s, cRank)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    if HEALBOT_GAME_VERSION<3 then 
        HealBot_InitValidateRanks()
        HealBot_Timers_Set("LAST","ClassicSpellRanks",1)
    elseif HEALBOT_GAME_VERSION==4 and HealBot_Data["PCLASSTRIM"]=="PRIE" then
        HealBot_Init_Spells_CataPriest(HEALBOT_HOLY_WORD_CHASTISE, HEALBOT_SPELL_HOLYWORDCHASTISE, 135886)
        HealBot_Init_Spells_CataPriest(HBC_HOLY_WORD_SERENITY, HEALBOT_SPELL_HOLYWORDSERENITY, 135937)
    end
    if HealBot_Spell_Ranges["HEAL30"] and HealBot_Spell_Ranges["HEAL30"]~="Set" then 
        HealBot_Range_InitSpell("HEAL30", HealBot_Spell_Ranges["HEAL30"])
        HealBot_AddDebug("[HEAL30] Init range for "..HealBot_Spell_Ranges["HEAL30"], "Init Range Spell",true)
    end
    if HealBot_Spell_Ranges["HARM30"] and HealBot_Spell_Ranges["HARM30"]~="Set" then 
        HealBot_Range_InitSpell("HARM30", HealBot_Spell_Ranges["HARM30"])
        HealBot_AddDebug("[HARM30] Init range for "..HealBot_Spell_Ranges["HARM30"], "Init Range Spell",true)
    end
    if HealBot_Spell_Ranges["HEAL"] and HealBot_Spell_Ranges["HEAL"]~="Set" then 
        HealBot_Range_InitSpell("HEAL", HealBot_Spell_Ranges["HEAL"])
        HealBot_AddDebug("[HEAL] Init range for "..HealBot_Spell_Ranges["HEAL"], "Init Range Spell",true)
    end
    if HealBot_Spell_Ranges["HARM"] and HealBot_Spell_Ranges["HARM"]~="Set" then 
        HealBot_Range_InitSpell("HARM", HealBot_Spell_Ranges["HARM"])
        HealBot_AddDebug("[HARM] Init range for "..HealBot_Spell_Ranges["HARM"], "Init Range Spell",true)
    end
    HealBot_AddDebug("-- ", "Init Range Spell",true)
end

function HealBot_Init_ClassicSpellRanks()
      --HealBot_setCall("HealBot_Init_ClassicSpellRanks")
    for hSpell,_ in pairs(HealBot_KnownHeal_Names) do
        if HealBot_Ranks[hSpell] and HealBot_Ranks[hSpell]>1 then
            for f=1, HealBot_Ranks[hSpell]-1, 1 do
                local sNameRank=HealBot_Init_retRank(hSpell, f) --hSpell.."(Rank "..f..")"
                if sNameRank then
                    local _, _, _, _, _, _, spellId = HealBot_WoWAPI_SpellInfo(sNameRank)
                    if spellId then
                        local _, _, texture, msCast, _, hbRange = HealBot_WoWAPI_SpellInfo(spellId);
                        local cooldown = GetSpellBaseCooldown(spellId)
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
    if HealBot_Data["PCLASSTRIM"]=="PRIE" then
        rName=HealBot_WoWAPI_SpellName(HEALBOT_MASS_RESURRECTION) or HealBot_WoWAPI_SpellName(HBC_MASS_RESURRECTION)
        if rName and HealBot_Spells_KnownByName(rName) then SmartCast_MassRes=rName end
        rName=HealBot_WoWAPI_SpellName(HEALBOT_RESURRECTION)
        if rName and HealBot_Spells_KnownByName(rName) then SmartCast_Res=rName end
    elseif HealBot_Data["PCLASSTRIM"]=="DRUI" then
        rName=HealBot_WoWAPI_SpellName(HEALBOT_REVITALIZE)
        if rName and HealBot_Spells_KnownByName(rName) then SmartCast_MassRes=rName end
        rName=HealBot_WoWAPI_SpellName(HEALBOT_REVIVE) or HealBot_WoWAPI_SpellName(HBC_REVIVE)
        if rName and HealBot_Spells_KnownByName(rName) then 
            SmartCast_Res=rName
        else
            rName=HealBot_WoWAPI_SpellName(HEALBOT_REBIRTH)
            if rName and HealBot_Spells_KnownByName(rName) then SmartCast_Res=rName end
        end
    elseif HealBot_Data["PCLASSTRIM"]=="MONK" then
        rName=HealBot_WoWAPI_SpellName(HEALBOT_REAWAKEN)
        if rName and HealBot_Spells_KnownByName(rName) then SmartCast_MassRes=rName end
        rName=HealBot_WoWAPI_SpellName(HEALBOT_RESUSCITATE)
        if rName and HealBot_Spells_KnownByName(rName) then SmartCast_Res=rName end
    elseif HealBot_Data["PCLASSTRIM"]=="PALA" then
        rName=HealBot_WoWAPI_SpellName(HEALBOT_ABSOLUTION)
        if rName and HealBot_Spells_KnownByName(rName) then SmartCast_MassRes=rName end
        rName=HealBot_WoWAPI_SpellName(HEALBOT_REDEMPTION)
        if rName and HealBot_Spells_KnownByName(rName) then SmartCast_Res=rName end
    elseif HealBot_Data["PCLASSTRIM"]=="SHAM" then
        rName=HealBot_WoWAPI_SpellName(HEALBOT_ANCESTRAL_VISION)
        if rName and HealBot_Spells_KnownByName(rName) then SmartCast_MassRes=rName end
        rName=HealBot_WoWAPI_SpellName(HEALBOT_ANCESTRALSPIRIT)
        if rName and HealBot_Spells_KnownByName(rName) then SmartCast_Res=rName end
    elseif HealBot_Data["PCLASSTRIM"]=="EVOK" then
        rName=HealBot_WoWAPI_SpellName(HEALBOT_MASS_RETURN)
        if rName and HealBot_Spells_KnownByName(rName) then SmartCast_MassRes=rName end
        rName=HealBot_WoWAPI_SpellName(HEALBOT_RETURN)
        if rName and HealBot_Spells_KnownByName(rName) then SmartCast_Res=rName end
    end
end

local HealBot_Spec = {}
function HealBot_Init_ClassicSpecs()
      --HealBot_setCall("HealBot_Init_ClassicSpecs")
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
      --HealBot_setCall("HealBot_Init_retSpec")
    if HealBot_Spec[class] and HealBot_Spec[class][tab] then
        return HealBot_Spec[class][tab]
    end
    return nil
end
