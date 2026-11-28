-- ============================================================
-- HealBot_CombatAuras
--
-- WoW 12.1 seals READING aura data in combat, but DISPLAYING it is allowed
-- through the native AuraContainer/AuraButton widgets: the addon creates a
-- container, hands Blizzard a filter string, supplies its own Texture/Cooldown
-- regions per button, and Blizzard's secure code fills and drives them. The
-- addon never sees the data. (Technique per DandersFrames' AuraContainer
-- factory, MIT-style open source - github.com/DanderBot/DandersFrames.)
--
-- This module puts two such rows on every HealBot player bar:
--   * HoTs you cast   filter "HELPFUL|PLAYER"  buff icon-set 1 placement
--   * Debuffs         filter "HARMFUL"         debuff icon-set 1 placement
-- Forever keeps the native buff row visible out of combat as well.
-- Persistent native debuffs also remain visible outside combat.
--
-- Hard rules learned from DandersFrames (proven live on 12.1):
--   * NEVER create or SetEnabled a container in combat - hard client error
--     that pcall cannot catch. All builds defer to PLAYER_REGEN_ENABLED.
--   * Build order: CreateFrame -> anchor -> SetUnit -> AddAuraGroup -> SetEnabled LAST.
--   * Show/Hide of the (insecure) container is fine in combat; visibility
--     gates processing, so poke UpdateAllAuras() after Show.
--   * Never read anything back from the buttons (all secret). Never branch on it.
--   * Filter change = rebuild; unit change = SetUnit (pcall, hide on failure).
--
-- Slash: /hbca  (on | off | size N | hots N | debuffs N | nums | status)
-- Forever test mode: /hbca ws native|off
-- ============================================================

local pcall, type, pairs, ipairs = pcall, type, pairs, ipairs
local CreateFrame, InCombatLockdown = CreateFrame, InCombatLockdown

local lastError
local supported=nil          -- nil = not probed yet
local attached={}            -- [button] = { hot=container, db=container, unit=unit }
local deferred={}            -- [button] = true, build queued until out of combat
local known={}               -- every button ever handed to us; survives DropAll so
                             -- settings changes and /hbca on can re-attach them all
local inCombat=InCombatLockdown() or false

-- Buff aura spell IDs, including lower ranks and triggered auras.
local knownBuffIDs={}
for _, id in ipairs({
    408514,16177,29206, -- Earth Shield, Ancestral Fortitude, Healing Way
    1044,6940,20216,425600, -- Freedom, Sacrifice, Divine Favor, Horn of Lordaeron
    408120,409824, -- Wild Growth and Lifebloom
    139,6074,6075,6076,6077,6078,10927,10928,10929,25315,7001, -- Renew and Lightwell Renew
    1243,1244,1245,2791,10937,10938,21562,21564,25389,25392, -- Fortitude
    17,592,600,3747,6065,6066,10898,10899,10900,10901, -- Power Word: Shield
    14752,14818,14819,27841,27681,25312,32999, -- Divine Spirit and Prayer of Spirit
    976,10957,10958,27683, -- Shadow Protection
    588,7128,602,1006,10951,10952, -- Inner Fire
    6346,10060,14751,1706,586,9578,9579,9592,10941,10942, -- Fear Ward, PI, Inner Focus, Levitate, Fade
    14893,15357,15359,15286,15473,27827, -- Inspiration, Vampiric Embrace, Shadowform, Spirit of Redemption
    2652,19261,19262,19264,19265,19266,2651, -- Touch of Weakness, Elune's Grace
    18137,19308,19309,19310,19311,19312, -- Shadowguard
    13896,19271,19273,19274,19275, -- Feedback
    552, -- Abolish Disease
    33076,41635, -- Prayer of Mending
    1277462,1277634,1277638,1277639,1277640, -- Contingency Plan ward
    1277463,1277464,1277465,1277467,1277466, -- Contingency Plan absorb
    1277456,1277457,1277458,1277459,1277460, -- Contingency Plan HoT
}) do knownBuffIDs[id]=true end

-- Route rank and group variants with their corresponding entry in Custom Buffs.
local buffFamily={}
for base, ranks in pairs({
    [401859]={1240826,1240827,401863,401877,1240848,1240849,33076,41635}, -- Prayer of Mending cast ranks and applied/jumping auras
    [1310911]={1311590,1311595,1310909,1311593,1311597}, -- Light's Vigil and its friendly aura
    [408521]={1239242,1239243}, -- Riptide
    [19740]={19834,19835,19836,19837,19838,25291,25782,25916}, -- Might
    [19742]={19850,19852,19853,19854,25290,25894,25918}, -- Wisdom
    [19977]={19978,19979,25890}, -- Light
    [20217]={25898}, -- Kings
    [20911]={20912,20913,20914,25899}, -- Sanctuary
    [1022]={5599,10278}, -- Protection
    [774]={1058,1430,2090,2091,3627,8910,9839,9840,9841,25299}, -- Rejuvenation
    [8936]={8938,8939,8940,8941,9750,9856,9857,9858}, -- Regrowth
    [1243]={1244,1245,2791,10937,10938,21562,21564,25389,25392},
    [588]={7128,602,1006,10951,10952},
    [139]={6074,6075,6076,6077,6078,10927,10928,10929,25315},
    [17]={592,600,3747,6065,6066,10898,10899,10900,10901},
}) do
    knownBuffIDs[base]=true
    for _, id in ipairs(ranks) do
        buffFamily[id]=base
        knownBuffIDs[id]=true
    end
end

local buffStart={1,9,11}
local buffEnd={8,10,12}
local debuffStart={51,57,59}
local buffFilters, buffSignature
local watchedRankNames
local function HBCA_PublicBuffValue(value)
    return not HealBot_issecretvalue or not HealBot_issecretvalue(value)
end
local function HBCA_BuffID(value)
    return HBCA_PublicBuffValue(value) and type(value)=="number" and value>0
        and value<math.huge and value==math.floor(value)
end
local function HBCA_BuffName(value)
    return HBCA_PublicBuffValue(value) and type(value)=="string" and value~=""
end
local function HBCA_BuffSetting(mapping,key)
    if type(mapping)~="table" or not (HBCA_BuffID(key) or HBCA_BuffName(key)) then return end
    local value=mapping[key]
    if HBCA_PublicBuffValue(value) then return value end
end
-- Spell/rank/trigger relationships are public metadata. The same compiler
-- handles every registered family; no live aura inspection is involved.
function HealBot_Forever_RegisterAuraFamily(base, variants)
    if not HBCA_BuffID(base) or type(variants)~="table" then return false end
    for _,id in ipairs(variants) do if not HBCA_BuffID(id) then return false end end
    knownBuffIDs[base]=true
    for _,id in ipairs(variants) do knownBuffIDs[id]=true; buffFamily[id]=base end
    if type(HealBot_Forever_RefreshBuffExclusions)=="function" then HealBot_Forever_RefreshBuffExclusions() end
    return true
end

local function HBCA_ConfiguredBuffFilters(g)
    if not HEALBOT_FOREVER then return end
    if HealBot_Config_Buffs and HealBot_Config_Buffs.BuffWatch==false then
        -- Keep empty rows ready for combat toggles and stop watching for new ranks.
        if buffSignature==false then return buffFilters, false end
        watchedRankNames=nil
        buffSignature,buffFilters=false,{}
        return buffFilters, true
    end
    local _, class=UnitClass("player")
    local broad=class~="PRIEST" and g.CombatAurasPriestOnly==true
    local sets=g.CustomBuffsIconSet or {}
    local methods=g.CustomBuffIDMethod or {}
    local candidates,names,registrations={},{},{}
    local cachedNames,targetRules={},{}
    local exact,families,variants={},{},{}
    local function AddCandidate(id)
        if HBCA_BuffID(id) then candidates[id]=true end
    end
    local function PublicCall(fn,...)
        if type(fn)~="function" then return end
        local ok,value=pcall(fn,...)
        if ok and HBCA_PublicBuffValue(value) then return value end
    end
    local function Name(id)
        if names[id]~=nil then return names[id] or nil end
        local name=cachedNames[id] or PublicCall(HealBot_WoWAPI_SpellName,id)
        names[id]=HBCA_BuffName(name) and name or false
        return names[id] or nil
    end
    local function Canonical(id)
        local key=PublicCall(HealBot_BuffIconSetKey,id)
        return (HBCA_BuffID(key) or HBCA_BuffName(key)) and key or id
    end
    local function Family(id)
        return buffFamily[id] or Canonical(id)
    end
    local function FirstSetting(mapping,...)
        for index=1,select("#",...) do
            local value=HBCA_BuffSetting(mapping,select(index,...))
            if value~=nil then return value end
        end
    end
    local function Disabled(id,name)
        local ok,value=pcall(HealBot_Aura_CustomBuffDisabled,id,name)
        return not ok or not HBCA_PublicBuffValue(value) or not not value
    end
    local function Caster(value)
        if value==1 or value=="S" then return "S" end
        if value==2 or value=="C" then return "C" end
        return "A"
    end
    for id in pairs(knownBuffIDs) do AddCandidate(id) end
    -- These are public configuration caches, not live/protected aura queries.
    for id in pairs(HealBot_Spell_IDs or {}) do AddCandidate(id) end
    if HealBot_Aura_VisitKnownBuffs then
        HealBot_Aura_VisitKnownBuffs(function(id,name)
            if HBCA_BuffName(name) then cachedNames[id]=name end
        end)
    end
    for _, spells in pairs(g.WatchHoT or {}) do
        if HBCA_PublicBuffValue(spells) and type(spells)=="table" then
            for spell,value in pairs(spells) do
                if HBCA_PublicBuffValue(value) and value~=false and (HBCA_BuffID(spell) or HBCA_BuffName(spell)) then
                    local id=HBCA_BuffID(spell) and spell or PublicCall(HealBot_WoWAPI_SpellId,spell)
                    if not HBCA_BuffID(id) then id=nil end
                    local name=HBCA_BuffName(spell) and spell or id and Name(id)
                    local method=FirstSetting(methods,spell,id,name)==1 and 1 or 2
                    local registration={id=id,name=name,entry=spell,method=method,caster=Caster(value)}
                    registration.route=FirstSetting(sets,id and Canonical(id),id,spell,name)
                    registrations[#registrations+1]=registration
                    AddCandidate(id)
                end
            end
        end
    end
    table.sort(registrations,function(a,b)
        local aid,bid=a.id or math.huge,b.id or math.huge
        if aid~=bid then return aid<bid end
        if a.method~=b.method then return a.method<b.method end
        if type(a.entry)~=type(b.entry) then return type(a.entry)=="number" end
        if tostring(a.entry)~=tostring(b.entry) then return tostring(a.entry)<tostring(b.entry) end
        return a.caster<b.caster
    end)
    local function AddNameCandidate(id,name)
        cachedNames[id]=name
        AddCandidate(id)
    end
    for _,registration in ipairs(registrations) do
        if registration.id and not exact[registration.id] then exact[registration.id]=registration end
        if registration.method~=1 then
            if registration.name and HealBot_Forever_VisitSpellNameIDs then
                HealBot_Forever_VisitSpellNameIDs(registration.id,registration.name,AddNameCandidate)
            end
            if registration.name and not families[registration.name] then families[registration.name]=registration end
            local family=registration.id and Family(registration.id)
            if family and not variants[family] then variants[family]=registration end
        end
    end
    -- An observed aura can supply another rank of a configured name. Other
    -- unrelated cache entries need no spell lookups or native policy work.
    for id,name in pairs(cachedNames) do
        if families[name] then AddCandidate(id) end
    end
    local include,selfIDs,everyoneIDs={{},{},{}},{{},{},{}},{{},{},{}}
    local excluded={}
    if broad and type(HealBot_Aura_NativeBuffExclusions)=="function" then
        for id,disabled in pairs(HealBot_Aura_NativeBuffExclusions() or {}) do
            if disabled and HBCA_BuffID(id) then excluded[id]=true; AddCandidate(id) end
        end
    end
    local signature={}
    for id in pairs(candidates) do
        local name=Name(id)
        local registration=exact[id] or (name and families[name]) or variants[Family(id)]
        local disabled=excluded[id] or Disabled(id,name)
        if broad and disabled then excluded[id]=true end
        if registration and not disabled and not (registration.method~=1 and Disabled(registration.id,registration.name)) then
            -- Admission follows the configured identify method above. Caster
            -- precedence matches the legacy name-first resolved WatchHoT table.
            local caster=PublicCall(HealBot_Aura_CustomBuffCaster,id,name)
            if caster~="S" and caster~="C" and caster~="A" then caster=registration.caster end
            local set=FirstSetting(sets,Canonical(id),id) or registration.route or HBCA_BuffSetting(sets,name) or 1
            if set~=2 and set~=3 then set=1 end
            include[set][id]=true
            if caster=="A" then everyoneIDs[set][id]=true else selfIDs[set][id]=true end
            signature[#signature+1]=id..":"..set..":"..caster
            if HealBot_Aura_GetBuffTargetFilter then
                local rule=HealBot_Aura_GetBuffTargetFilter(id,name)
                if not rule and registration.method~=1 then
                    rule=HealBot_Aura_GetBuffTargetFilter(registration.id,registration.name)
                end
                if type(rule)=="number" and rule>=2 and rule<=14 and rule==math.floor(rule) then
                    targetRules[rule]=targetRules[rule] or {}
                    targetRules[rule][#targetRules[rule]+1]=id
                    signature[#signature+1]="target:"..id..":"..rule
                end
            end
        end
    end
    local ownExcluded={}
    local allExcluded={}
    if broad then
        for id in pairs(excluded) do ownExcluded[id]=true; allExcluded[id]=true end
        for set=1,3 do
            for id in pairs(include[set]) do
                if set~=1 then ownExcluded[id]=true; allExcluded[id]=true
                elseif everyoneIDs[set][id] then ownExcluded[id]=true end
            end
        end
        signature[#signature+1]="broad"
        for id in pairs(excluded) do signature[#signature+1]="exclude:"..id end
    else
        signature[#signature+1]="configured"
    end
    table.sort(signature)
    -- A newly observed public rank only matters when its name is watched.
    watchedRankNames=families
    local key=table.concat(signature,",")
    if key==buffSignature then return buffFilters, false end
    buffSignature=key
    buffFilters={}
    if next(targetRules) then buffFilters.targetRules=targetRules end
    for set=1,3 do
        if set==1 or next(include[set]) then
            buffFilters[set]={includeSpellIDs=include[set]}
            buffFilters[set].selfSpellFilter={includeSpellIDs=selfIDs[set]}
            buffFilters[set].everyoneSpellFilter={includeSpellIDs=everyoneIDs[set]}
            if set==1 and broad then
                buffFilters[set].includeSpellIDs=nil
                buffFilters[set].excludeSpellIDs=allExcluded
                buffFilters[set].selfSpellFilter={excludeSpellIDs=ownExcluded}
            end
        end
    end
    return buffFilters, true
end

local function HBCA_Defaults()
    if type(HealBot_Globals)~="table" then return nil end
    if HealBot_Globals.CombatAurasOn==nil       then HealBot_Globals.CombatAurasOn=true end
    if HealBot_Globals.CombatAurasSize==nil     then HealBot_Globals.CombatAurasSize=12 end
    if HealBot_Globals.CombatAurasMatchSkinSize==nil then HealBot_Globals.CombatAurasMatchSkinSize=true end
    if HealBot_Globals.CombatAurasHots==nil     then HealBot_Globals.CombatAurasHots=4 end
    if HealBot_Globals.CombatAurasDebuffs==nil  then HealBot_Globals.CombatAurasDebuffs=3 end
    if HealBot_Globals.CombatAurasPersistDebuffs==nil then
        HealBot_Globals.CombatAurasPersistDebuffs=not not HEALBOT_FOREVER
    end
    -- Migrate the old false default to skin settings; retain an enabled override.
    if HealBot_Globals.CombatAurasNumsFollowSkin==nil then
        HealBot_Globals.CombatAurasNumsFollowSkin=not HealBot_Globals.CombatAurasNums
    end
    if HealBot_Globals.CombatAurasMaxDur==nil then
        HealBot_Globals.CombatAurasMaxDur=HEALBOT_FOREVER and 0 or 120
    end
    return HealBot_Globals
end

local function HBCA_Enabled()
    local g=HBCA_Defaults()
    return g and g.CombatAurasOn and HEALBOT_MIDNIGHT
end

local weakenedSoulSpellID=6788
local function HBCA_NativeBuffContext()
    if not HEALBOT_FOREVER or inCombat then return true end
    if type(IsInInstance)=="function" then
        local _,instanceType=IsInInstance()
        return instanceType=="pvp" or instanceType=="arena"
    end
    return false
end

local buffScanGeneration=0
function HealBot_CombatAuras_PublicBuffContext(button)
    if not HEALBOT_FOREVER or not attached[button]
        or not buffFilters or not buffFilters[1] or not buffFilters[1].includeSpellIDs
        or not C_Secrets or not C_Secrets.ShouldAurasBeSecret or not UnitGUID or not UnitIsVisible
        or not HBCA_NativeBuffContext() then return end
    local ok,restricted=pcall(C_Secrets.ShouldAurasBeSecret)
    if not ok or HealBot_issecretvalue(restricted) or restricted~=false then return end
    local unit=button.unit
    local visible=UnitIsVisible(unit)
    local connected=UnitIsConnected(unit)
    if HealBot_issecretvalue(visible) or not visible or HealBot_issecretvalue(connected) or not connected then return end
    local guid=UnitGUID(unit)
    if not HealBot_issecretvalue(guid) and type(guid)=="string" and guid~="" then
        return buffScanGeneration,guid,buffFilters
    end
end

function HealBot_CombatAuras_LegacyBuffMatches(id,name)
    -- A triggered or alternate-rank aura can be known exclusively to the
    -- native policy. Preserve that row if the legacy watch list cannot match.
    for set=1,3 do
        local filter=buffFilters and buffFilters[set]
        if filter and filter.includeSpellIDs and filter.includeSpellIDs[id] then
            return HealBot_Aura_CustomBuffCaster and HealBot_Aura_CustomBuffCaster(id,name)
        end
    end
    return true
end

local function HBCA_PublicBuffsReady(button)
    local state=button.aura and button.aura.buff
    if not state or not state.publicRendered or state.publicGeneration~=buffScanGeneration or state.publicPolicy~=buffFilters
        or state.publicUnit~=button.unit or state.scanIncomplete or state.update then return false end
    local gen,guid=HealBot_CombatAuras_PublicBuffContext(button)
    return gen~=nil and state.publicGuid==guid
end

local weakenedSoulCandidates={
    excludeDispelTypes={Magic=true, Curse=true, Disease=true, Poison=true, Bleed=true, Enrage=true},
    maxDuration=15,
    isBossOrRoleAura=false,
    isFromPlayerOrPlayerPet=true,
}

local function HBCA_WeakenedSoulMode(g)
    if not HEALBOT_FOREVER or not g.CombatAurasNativeWeakenedSoul then return false end
    local neverSecret=Enum and Enum.SecrecyLevel and Enum.SecrecyLevel.NeverSecret
    if neverSecret~=nil and C_Secrets and C_Secrets.GetSpellAuraSecrecy then
        local ok, secrecy=pcall(C_Secrets.GetSpellAuraSecrecy,weakenedSoulSpellID)
        if ok and not HealBot_issecretvalue(secrecy) and secrecy==neverSecret then return "exact" end
    end
    return "properties"
end

local function HBCA_WeakenedSoulWanted(button,combat)
    local g=HBCA_Defaults()
    if not g or not g.CombatAurasNativeWeakenedSoul then return false end
    local choice
    if type(HealBot_Aura_GetDebuffIconPreference)=="function" then
        if combat==nil then combat=InCombatLockdown() end
        choice=HealBot_Aura_GetDebuffIconPreference(weakenedSoulSpellID,combat)
    end
    if choice==false or (choice~=true and not HealBot_Forever_WatchesWeakenedSoul()) then return false end
    if button and type(HealBot_Aura_GetTrackedDebuffIconSet)=="function" then
        local ok,set=pcall(HealBot_Aura_GetTrackedDebuffIconSet,button,weakenedSoulSpellID)
        return ok and not HealBot_issecretvalue(set) and set~=nil
    end
    return true
end

local debuffPolicies={}
local function HBCA_DebuffExclusions()
    local state=InCombatLockdown() and "combat" or "rest"
    local cached=debuffPolicies[state]
    if cached then return cached.ids,cached.signature end
    local excluded={ [weakenedSoulSpellID]=true }
    if type(HealBot_Aura_GetHiddenDebuffIcons)=="function" then
        for spellID, hidden in pairs(HealBot_Aura_GetHiddenDebuffIcons(state=="combat") or {}) do
            if type(spellID)=="number" and hidden then excluded[spellID]=true end
        end
    end
    local ids={}
    for spellID in pairs(excluded) do ids[#ids+1]=spellID end
    table.sort(ids)
    local signature=table.concat(ids,",")
    debuffPolicies[state]={ids=excluded,signature=signature}
    return excluded,signature
end

-- One-time capability probe. Must never run in combat: probing creates a live
-- container, and in-lockdown creation is a hard client error.
local function HBCA_Probe()
    if supported~=nil then return supported end
    if InCombatLockdown() then return false end
    local ok, f=pcall(CreateFrame, "AuraContainer", nil, UIParent, "CustomAuraContainerTemplate")
    supported=(ok and f and type(f.AddAuraGroup)=="function") or false
    if ok and f then f:Hide() end
    return supported
end

local function HBCA_StyleAuraText(text, icon, size, placement, isCount)
    local prefix=isCount and "count" or "duration"
    local point=placement[prefix.."Point"] or (isCount and "TOPLEFT" or "BOTTOMRIGHT")
    local fontLimit=math.max(1,math.floor(size*(isCount and 0.45 or 0.40)))
    local fontSize=HEALBOT_FOREVER and (placement.fontSize or 9) or math.min(placement.fontSize or 9,fontLimit)
    text:ClearAllPoints()
    text:SetPoint(point,icon,placement[prefix.."RelativePoint"] or point,
        placement[prefix.."X"] or 0,placement[prefix.."Y"] or 0)
    -- Legacy timer/count FontStrings have one anchor and no fixed width. A
    -- fixed icon-width box shifts centered digits and clips larger fonts.
    text:SetWidth(HEALBOT_FOREVER and 0 or size)
    text:SetJustifyH(placement[prefix.."Justify"] or (isCount and "LEFT" or "RIGHT"))
    text:SetWordWrap(false)
    HealBot_Media_UpdateFont(text,placement.font,fontSize,placement.fontOutline,"Combat aura text")
end

-- The client evaluates these curves against its own remaining-duration clock.
-- Share each public skin policy across all icons that use it.
local durationPolicies=setmetatable({}, {__mode="v"})
local secondsFormatter
local function HBCA_DurationPolicy(placement)
    if not placement.durationThreshold or not C_CurveUtil or not C_CurveUtil.CreateColorCurve
        or not CreateColor or not Enum or not Enum.LuaCurveType or not Enum.DurationTextBindingProperty then return end
    local key=placement.durationThreshold..":"..placement.durationWarning..":"..placement.durationWarningColor
    if durationPolicies[key] then return durationPolicies[key] end
    local curve=C_CurveUtil.CreateColorCurve()
    curve:SetType(Enum.LuaCurveType.Step)
    local warning=placement.durationWarningColor
    local r,g=1,1
    if warning=="helpful" then g=0.5
    elseif warning=="harmful" then r=0
    elseif warning=="hostile" then g=0 end
    curve:AddPoint(0,CreateColor(r,g,warning=="neutral" and 1 or 0,1))
    -- Legacy compares floor(remaining - 0.5) to each inclusive threshold.
    if placement.durationWarning<placement.durationThreshold then
        curve:AddPoint(placement.durationWarning+1.5,CreateColor(1,1,1,1))
    end
    curve:AddPoint(placement.durationThreshold+1.5,CreateColor(1,1,1,0))
    local policy={textColor={curve=curve,property=Enum.DurationTextBindingProperty.RemainingDuration}}
    if C_StringUtil and C_StringUtil.CreateNumericRuleFormatter and Enum.NumericRuleFormatRounding then
        if secondsFormatter==nil then
            local ok,formatter=pcall(function()
                local value=C_StringUtil.CreateNumericRuleFormatter()
                if HEALBOT_FOREVER and value.SetBreakpoints and value.FormatNumber then
                    -- Legacy shows max(0, floor(seconds - 0.5)). Native
                    -- formatters have no subtraction operator. Supply the
                    -- display breakpoints once for the skin's 0..99 range.
                    local rules={{threshold=0,format="0"}}
                    for seconds=1,99 do
                        rules[#rules+1]={threshold=seconds+0.5,format=tostring(seconds)}
                    end
                    rules[#rules+1]={threshold=100.5,step=1,rounding=Enum.NumericRuleFormatRounding.Down,min=0,format="%d"}
                    local matched,valid=pcall(function()
                        value:SetBreakpoints(rules)
                        return value:FormatNumber(1.49)=="0" and value:FormatNumber(1.5)=="1"
                            and value:FormatNumber(99.5)=="99"
                    end)
                    if matched and valid then return value end
                    value=C_StringUtil.CreateNumericRuleFormatter()
                end
                value:AddBreakpoint({threshold=0,step=1,rounding=Enum.NumericRuleFormatRounding.Down,min=0,format="%d"})
                return value
            end)
            secondsFormatter=ok and formatter or false
        end
        if secondsFormatter then policy.textFormatter=secondsFormatter end
    end
    durationPolicies[key]=policy
    return policy
end

local function HBCA_SetRowIconOpacity(row,button)
    local art=row and row.hbcaOpacity
    if not art then return end
    local status=button.status
    local alpha=button.hbcaArrivalAlpha
    if status then alpha=status.alpha end
    if type(alpha)~="number" or HealBot_issecretvalue(alpha) then return end
    if hbv_Skins_GetIconBoolean(art.key,button.frame,art.set) then
        if status and button.framecol then
            alpha=HealBot_Action_BarColourAlpha(button,hbv_Skins_GetFrameVar("BarCol","HA",button.framecol),1)
        else
            alpha=button.hbcaArrivalEnabledAlpha or alpha
        end
    end
    if art.alpha==alpha then return end
    art.alpha=alpha
    for texture in pairs(art.icons) do texture:SetAlpha(alpha) end
end

local function HBCA_CreateRowIconOpacity(row,button,side,set)
    if not HEALBOT_FOREVER then return end
    -- Only the textures created by this addon are registered. Blizzard owns
    -- the aura selection, visibility, cooldown and bound text.
    row.hbcaOpacity={icons={},alpha=1,key=side=="hot" and "BUFFI15EN" or "DI15EN",set=set or 1}
    HBCA_SetRowIconOpacity(row,button)
    return row.hbcaOpacity
end

-- Style one Blizzard-created button: click-through (clicks must reach the heal
-- bar beneath), our own icon Texture + Cooldown, bound via the native inbound
-- setters so Blizzard paints the secret aura into them.
local function HBCA_MakeInit(size, placement, showNumbers, opacity)
    local durationPolicy
    return function(btn)
        local ok, err=pcall(function()
            btn:SetSize(size, size)
            if btn.SetMouseClickEnabled then btn:SetMouseClickEnabled(false) end
            if btn.SetMouseMotionEnabled then btn:SetMouseMotionEnabled(false) end
            if not btn.hbcaIcon then
                local icon=btn:CreateTexture(nil, "ARTWORK")
                icon:SetAllPoints(btn)
                icon:SetTexCoord(placement.zoom, 1-placement.zoom, placement.zoom, 1-placement.zoom)
                btn.hbcaIcon=icon
            end
            if not btn.hbcaBoundIcon then
                btn:SetIcon(btn.hbcaIcon)
                btn.hbcaBoundIcon=true
            end
            if opacity and not opacity.icons[btn.hbcaIcon] then
                opacity.icons[btn.hbcaIcon]=true
                if opacity.alpha~=1 then btn.hbcaIcon:SetAlpha(opacity.alpha) end
            end

            if placement.markerTexture and not btn.hbcaMarker then
                local marker=btn:CreateTexture(nil, "OVERLAY", nil, 7)
                marker:SetTexture(placement.markerTexture)
                marker:SetSize(placement.markerWidth, placement.markerHeight)
                marker:SetPoint(placement.markerPoint, btn, placement.markerAnchor, placement.markerX, placement.markerY)
                btn.hbcaMarker=marker
            end

            if btn.SetDurationCooldown and not btn.hbcaBoundCD then
                if not btn.hbcaCD then
                    local cd=CreateFrame("Cooldown", nil, btn, "CooldownFrameTemplate")
                    cd:SetAllPoints(btn)
                    cd:SetReverse(true)
                    cd:SetDrawEdge(false)
                    if cd.SetHideCountdownNumbers then cd:SetHideCountdownNumbers(not showNumbers) end
                    btn.hbcaCD=cd
                end
                btn:SetDurationCooldown(btn.hbcaCD)
                btn.hbcaBoundCD=true
            end

            if placement.font and showNumbers and not btn.hbcaDuration then
                local cd=btn.hbcaCD
                local countdown=cd and cd.GetCountdownFontString and cd:GetCountdownFontString()
                if btn.SetDurationText and durationPolicy==nil then
                    local okPolicy,policy=pcall(HBCA_DurationPolicy,placement)
                    durationPolicy=okPolicy and policy or false
                end
                if btn.SetDurationText and not btn.hbcaDurationRejected and (durationPolicy or not countdown) then
                    local duration=btn:CreateFontString(nil,"OVERLAY","GameFontNormal")
                    HBCA_StyleAuraText(duration,btn,size,placement,false)
                    local bound=pcall(btn.SetDurationText,btn,duration,durationPolicy or {})
                    if not bound and durationPolicy and durationPolicy.textFormatter then
                        bound=pcall(btn.SetDurationText,btn,duration,{textColor=durationPolicy.textColor})
                    end
                    if not bound and durationPolicy and not countdown then
                        bound=pcall(btn.SetDurationText,btn,duration,{})
                    end
                    if bound then
                        btn.hbcaDuration=duration
                        if cd and cd.SetHideCountdownNumbers then cd:SetHideCountdownNumbers(true) end
                    else
                        btn.hbcaDurationRejected=true
                        pcall(duration.Hide,duration)
                    end
                end
                if countdown and not btn.hbcaDuration then pcall(HBCA_StyleAuraText,countdown,btn,size,placement,false) end
            end
            if placement.font and placement.showCount and btn.SetApplicationCount and not btn.hbcaCount then
                local count=btn:CreateFontString(nil,"OVERLAY","GameFontNormal")
                HBCA_StyleAuraText(count,btn,size,placement,true)
                btn:SetApplicationCount(count,{})
                btn.hbcaCount=count
            end
        end)
        if not ok then lastError=tostring(err) end
    end
end

local function HBCA_Layout(size, placement)
    local horizontal,vertical=placement.spacing,placement.verticalSpacing or placement.spacing
    return { elementWidth=size, elementHeight=size,
             elementSpacing=placement.double and vertical or horizontal,
             lineSpacing=placement.double and horizontal or vertical,groupSpacing=0,
             elementSpacingX=horizontal,elementSpacingY=vertical,gapX=0 }
end

-- Read only ordinary HealBot skin geometry, never native aura button data.
-- Copy the first icon's anchor so offsets, inside/outside placement and the
-- selected corner match out of combat, even when that icon is hidden.
local function HBCA_SkinLayout(button, side, set)
    set=set or 1
    local hot=side=="hot"
    local point=hot and "BOTTOMRIGHT" or "BOTTOMLEFT"
    local layout={point=point, relative=button, relativePoint=point,
                  x=hot and -1 or 1, y=1, spacing=1, double=false, zoom=0.08}
    local icon=button.gref and button.gref.icon and button.gref.icon[hot and buffStart[set] or debuffStart[set]]
    local g=HBCA_Defaults()
    layout.numbers=g and g.CombatAurasNums
    if g and g.CombatAurasNumsFollowSkin then
        layout.numbers=type(hbv_Skins_GetIconTextBoolean)=="function" and
            hbv_Skins_GetIconTextBoolean(hot and "BUFFSDUR" or "DBSDUR", button.frame, set) or false
    end
    if g and g.CombatAurasMatchSkinSize and icon and icon.GetWidth then
        local size=icon:GetWidth()
        if size and size>0 then layout.size=size end
    end
    if icon and icon.GetPoint then
        local p, relative, rp, x, y=icon:GetPoint(1)
        if p then
            if g.CombatAurasMatchSkinSize then
                local size=icon:GetWidth()
                if size and size>0 then layout.size=size end
            end
            layout.point=p
            layout.relative=relative or button
            layout.relativePoint=rp or p
            layout.x=x or 0
            layout.y=y or 0
        end
    end
    if type(hbv_Skins_GetIconVar)=="function" then
        layout.spacing=hbv_Skins_GetIconVar(hot and "BICONSPACER" or "DICONSPACER", button.frame, set) or 1
        if HEALBOT_FOREVER then
            layout.zoom=hbv_Skins_GetIconVar(hot and "BZOOM" or "DZOOM", button.frame, set) or layout.zoom
        end
    end
    if type(hbv_Skins_GetIconBoolean)=="function" then
        layout.double=hbv_Skins_GetIconBoolean(hot and "BUFFDOUBLE" or "DEBUFFDOUBLE", button.frame, set) or false
    end
    if HEALBOT_FOREVER then
        -- Skins_setIconSpacer signs offsets by the configured corner.
        -- Outside the bar the icon is anchored by the opposite edge on one
        -- axis. Native flow measures spacing in the direction of growth.
        local point,relative=layout.point,layout.relativePoint
        local spacing=layout.spacing
        if point:find("RIGHT",1,true) and relative:find("LEFT",1,true)
            or point:find("LEFT",1,true) and relative:find("RIGHT",1,true) then
            layout.spacing=-spacing
        end
        if point:find("TOP",1,true) and relative:find("BOTTOM",1,true)
            or point:find("BOTTOM",1,true) and relative:find("TOP",1,true) then
            layout.verticalSpacing=-spacing
        else
            layout.verticalSpacing=spacing
        end
        -- The first native row must obey the same icon limit as its skin,
        -- including zero. Extra buff sets already use their own limits.
        layout.limit=hbv_Skins_GetIconVar(hot and "MAXBICONS" or "MAXDICONS",button.frame,set)
        local prefix=hot and "BUFF" or "DB"
        layout.font=hbv_Skins_GetIconTextVar(prefix.."FONT",button.frame,set)
        layout.fontSize=hbv_Skins_GetIconTextVar(prefix.."HEIGHT",button.frame,set)
        layout.fontOutline=hbv_Skins_GetIconTextVar(prefix.."OUTLINE",button.frame,set)
        local threshold=hbv_Skins_GetIconTextVar(prefix.."DURTHRH",button.frame,set)
        local warning=hbv_Skins_GetIconTextVar(prefix.."DURWARN",button.frame,set)
        -- The explicit "Always show" override uses the client's unrestricted
        -- countdown visibility. Skin thresholds belong to "Follow skin".
        layout.durationThreshold=g.CombatAurasNumsFollowSkin and type(threshold)=="number" and math.max(0,threshold) or false
        layout.durationWarning=type(warning)=="number" and math.max(0,warning) or 0
        layout.durationWarningColor="neutral"
        if layout.numbers and layout.durationThreshold and UnitIsFriend and button.unit then
            local friendly=UnitIsFriend("player",button.unit)
            if not HealBot_issecretvalue(friendly) and friendly~=nil then
                layout.durationWarningColor=friendly and (hot and "helpful" or "harmful") or "hostile"
            end
        end
        layout.showCount=not not hbv_Skins_GetIconTextBoolean(prefix.."SCNT",button.frame,set)
        local refs=button.gref and button.gref.txt
        local index=hot and buffStart[set] or debuffStart[set]
        for _,kind in ipairs({"duration","count"}) do
            local texts=refs and refs[kind=="duration" and "expire" or "count"]
            local text=texts and texts[index]
            if text and text.GetPoint then
                local point,relative,relativePoint,x,y=text:GetPoint(1)
                -- Copy only the legacy text anchored to this icon, never a
                -- native aura frame or another frame's coordinate space.
                if point and relative==icon then
                    layout[kind.."Point"]=point
                    layout[kind.."RelativePoint"]=relativePoint or point
                    layout[kind.."X"],layout[kind.."Y"]=x or 0,y or 0
                    if text.GetJustifyH then layout[kind.."Justify"]=text:GetJustifyH() end
                end
            end
        end
    end
    if HEALBOT_FOREVER and hot and hbv_Skins_GetFrameBoolean("IconText", "SELFIND", button.frame) then
        local indicators=button.gref and button.gref.indicator
        local marker=indicators and indicators.selfcast and indicators.selfcast[buffStart[set]]
        if marker then
            local p, relative, anchor, x, y=marker:GetPoint(1)
            if p and relative==icon then
                layout.markerTexture=marker:GetTexture()
                layout.markerPoint=p
                layout.markerAnchor=anchor or p
                layout.markerX=x or 0
                layout.markerY=y or 0
                layout.markerWidth=marker:GetWidth()
                layout.markerHeight=marker:GetHeight()
            end
        end
    end
    return layout
end

local function HBCA_SameLayout(a, b)
    if not a or a.size~=b.size or a.markerTexture~=b.markerTexture then return false end
    for key, value in pairs(b) do
        if key~="dispelTypes" and key~="excludedSpellIDs" and a[key]~=value then return false end
    end
    return true
end

local function HBCA_WeakenedSoulLayout(button, g, dbLayout)
    local mode=HBCA_WeakenedSoulMode(g)
    if not mode or g.CombatAurasDebuffs<1 then return end

    local sets=g.CustomDebuffsIconSet or {}
    local name=HealBot_WoWAPI_SpellName(weakenedSoulSpellID)
    if HealBot_issecretvalue(name) then name=nil end
    local set=sets[weakenedSoulSpellID] or sets[name]
    if set~=2 and set~=3 then set=1 end
    local limit=hbv_Skins_GetIconVar("MAXDICONS",button.frame,set) or 0
    if limit<1 then return end

    local layout=HBCA_SkinLayout(button,"db",set)
    layout.weakenedSoulMode=mode
    layout.iconSet=set
    local sharesMain=set==1 or (layout.point==dbLayout.point and layout.relative==dbLayout.relative
        and layout.relativePoint==dbLayout.relativePoint and layout.x==dbLayout.x and layout.y==dbLayout.y)
    local rowLayout, rowSet, occupied=layout,set,0
    if sharesMain then
        rowLayout,rowSet=dbLayout,1
        -- A configured cap is not an occupied row. When no native dispel
        -- group exists, start at the configured anchor rather than leaving
        -- an entire invisible row ahead of this slot.
        if dbLayout.dispelSignature~="" then
            occupied=math.min(hbv_Skins_GetIconVar("MAXDICONS",button.frame,1) or 0,g.CombatAurasDebuffs)
        end
    else
        for spellID, assigned in pairs(sets) do
            if assigned==set and spellID~=weakenedSoulSpellID and spellID~=name then
                occupied=limit
                break
            end
        end
    end
    if occupied>0 then
        -- Leave room for regular icons along the selected row's horizontal growth.
        local icon=button.gref and button.gref.icon and button.gref.icon[debuffStart[rowSet]]
        local width=math.max(rowLayout.size or g.CombatAurasSize,icon and icon:GetWidth() or 0)
        local columns=math.ceil(occupied/(rowLayout.double and 2 or 1))
        local direction=rowLayout.point:find("RIGHT",1,true) and -1 or 1
        layout.x=layout.x+direction*columns*(width+rowLayout.spacing)
    end
    return layout
end

local helpfulGroup="hbcahot"
local everyoneGroup="hbcahotEveryone"
local arrivalDonors=setmetatable({}, {__mode="k"})

local function HBCA_CopyFilter(source)
    local copy={}
    for key,value in pairs(source or {}) do
        if type(value)=="table" then
            local values={}
            for id,enabled in pairs(value) do values[id]=enabled end
            copy[key]=values
        else
            copy[key]=value
        end
    end
    return copy
end

local buttonBuffPolicies=setmetatable({}, {__mode="k"})
local function HBCA_ButtonBuffFilters(button, filters)
    local rules=filters and filters.targetRules
    if not rules then return filters end
    -- Score each distinct configured target predicate once per unit. All ranks
    -- and triggered IDs using that predicate share the same result.
    local deniedMask=0
    for rule in pairs(rules) do
        local ok,allowed=pcall(HealBot_Aura_BuffTargetMatches,button,rule)
        if not ok or not HBCA_PublicBuffValue(allowed) or not allowed then deniedMask=deniedMask+2^rule end
    end
    if deniedMask==0 then return filters end
    local cached=buttonBuffPolicies[button]
    if cached and cached.base==filters and cached.mask==deniedMask then return cached.filters end
    local function Restrict(scope)
        local copy=HBCA_CopyFilter(scope)
        for rule,ids in pairs(rules) do
            if math.floor(deniedMask/2^rule)%2==1 then
                for _,id in ipairs(ids) do
                    if copy.includeSpellIDs then copy.includeSpellIDs[id]=nil
                    else
                        copy.excludeSpellIDs=copy.excludeSpellIDs or {}
                        copy.excludeSpellIDs[id]=true
                    end
                end
            end
        end
        return copy
    end
    local filtered={}
    for set=1,3 do
        local row=filters[set]
        if row then
            local copy=Restrict(row)
            copy.selfSpellFilter=Restrict(row.selfSpellFilter)
            copy.everyoneSpellFilter=Restrict(row.everyoneSpellFilter)
            filtered[set]=copy
        end
    end
    buttonBuffPolicies[button]={base=filters,mask=deniedMask,filters=filtered}
    return filtered
end

local function HBCA_BuffRowDuration(g)
    return (g.CombatAurasMaxDur or 0)>0 and g.CombatAurasMaxDur or nil
end

local function HBCA_BuffRowPolicyCurrent(row, spellFilter, g)
    local applied=row.hbcaBuffPolicy
    -- ConfiguredBuffFilters retains its addon-owned filter tables until their
    -- signature changes. This compares policy metadata, never native aura data.
    return applied and applied.filter==spellFilter and applied.limit==row.hbcaBuffLimit
        and applied.duration==HBCA_BuffRowDuration(g)
end

local function HBCA_BuffRowPolicy(spellFilter, g, limit)
    local own=HBCA_CopyFilter(spellFilter and spellFilter.selfSpellFilter
        or spellFilter or {includeSpellIDs={}})
    local everyone=HBCA_CopyFilter(spellFilter and spellFilter.everyoneSpellFilter
        or {includeSpellIDs={}})
    -- These are addon settings, not aura identities/counts from native widgets.
    own.selfSpellFilter,own.everyoneSpellFilter,own.casterSignature=nil,nil,nil
    local duration=HBCA_BuffRowDuration(g)
    own.maxDuration,everyone.maxDuration=duration,duration
    local hasOwn=own.includeSpellIDs==nil or next(own.includeSpellIDs)~=nil
    local hasEveryone=next(everyone.includeSpellIDs or {})~=nil
    local ownLimit,everyoneLimit=0,0
    if hasOwn and hasEveryone then
        -- Blizzard caps each group separately. Reserve shares of the existing
        -- row limit rather than doubling it or reading forbidden frame counts.
        everyoneLimit=math.ceil(limit/2)
        ownLimit=limit-everyoneLimit
    elseif hasEveryone then everyoneLimit=limit
    elseif hasOwn then ownLimit=limit end
    return own,everyone,ownLimit,everyoneLimit,hasOwn or hasEveryone
end

local function HBCA_UpdateBuffRow(row, spellFilter, g)
    if not row or not row.hbcaBuffLimit then return false end
    if HBCA_BuffRowPolicyCurrent(row,spellFilter,g) then return true end
    local own,everyone,ownLimit,everyoneLimit,wanted=HBCA_BuffRowPolicy(spellFilter,g,row.hbcaBuffLimit)
    -- A setter may fail after clearing/changing only part of a row. Forget the
    -- old success before any write so even reverting its settings must retry.
    row.hbcaBuffPolicy=nil
    local ok,err=pcall(function()
        -- Clear old memberships first: moving a spell between scopes must not
        -- expose a stale broad filter or temporarily duplicate an own cast.
        row:SetAuraGroupCandidateFilters(helpfulGroup,{includeSpellIDs={}})
        row:SetAuraGroupCandidateFilters(everyoneGroup,{includeSpellIDs={}})
        row:SetAuraGroupMaxFrameCount(helpfulGroup,ownLimit)
        row:SetAuraGroupMaxFrameCount(everyoneGroup,everyoneLimit)
        row:SetAuraGroupCandidateFilters(helpfulGroup,own)
        row:SetAuraGroupCandidateFilters(everyoneGroup,everyone)
    end)
    if not ok then
        lastError=tostring(err)
        row.hbcaHasBuffs=false
        if pcall(row.Hide,row) then row.hbcaShown=false end
        return false
    end
    row.hbcaHasBuffs=wanted
    row.hbcaBuffPolicy={filter=spellFilter,limit=row.hbcaBuffLimit,duration=HBCA_BuffRowDuration(g)}
    return true
end

-- A failed native group can already have allocated its icon batch. Allow one
-- immediate retry, then space out attempts for the same unit and configuration.
local function HBCA_BuildRetry(previous,unit,filters)
    local delay=0
    if previous and previous.unit==unit and previous.filters==filters then
        delay=math.min(60,math.max(1,previous.delay*2))
    end
    return {unit=unit,filters=filters,delay=delay,at=(GetTime and GetTime() or 0)+delay}
end

local function HBCA_RetryDue(retry,unit,filters)
    return retry and (retry.unit~=unit or retry.filters~=filters or retry.at<=(GetTime and GetTime() or 0))
end

-- Build one container on a HealBot button. Out-of-combat only; caller gates.
local function HBCA_BuildOne(button, side, placement, set, spellFilter)
    local g=HBCA_Defaults()
    if not g then return nil end
    local size=placement.size or g.CombatAurasSize or 12
    local filter=(side=="hot") and "HELPFUL|PLAYER" or "HARMFUL"
    local maxN=(side=="hot") and (g.CombatAurasHots or 4) or (g.CombatAurasDebuffs or 3)
    if side=="weakenedSoul" then
        maxN=1
    elseif placement.limit~=nil then
        maxN=(set==1) and math.min(maxN,placement.limit) or placement.limit
    end
    if maxN<1 then return nil end
    local ok, c=pcall(CreateFrame, "AuraContainer", nil, button, "CustomAuraContainerTemplate")
    if not ok or not c then
        lastError=tostring(c)
        return nil,true
    end
    c:Hide()
    local positioned,positionError=pcall(function()
        c:ClearAllPoints()
        c:SetPoint(placement.point, placement.relative, placement.relativePoint, placement.x, placement.y)
        if c.SetFlowLayoutAnchorPoint then c:SetFlowLayoutAnchorPoint(placement.point) end
        local growH=string.find(placement.point, "RIGHT") and "Left" or "Right"
        local growV=string.find(placement.point, "BOTTOM") and "Up" or "Down"
        if c.SetFlowLayoutGrowthDirection and AnchorUtil and AnchorUtil.FlowDirection then
            local h, v=AnchorUtil.FlowDirection[growH], AnchorUtil.FlowDirection[growV]
            if h~=nil and v~=nil then pcall(c.SetFlowLayoutGrowthDirection, c, h, v) end
        end
        -- HealBot's double layout fills a column of two, then grows across.
        if c.SetFlowLayoutAxis and AnchorUtil and AnchorUtil.FlowLayoutAxis then
            c:SetFlowLayoutAxis(AnchorUtil.FlowLayoutAxis[placement.double and "Vertical" or "Horizontal"])
            if placement.double and c.SetFlowLayoutMaximumLineSize then
                c:SetFlowLayoutMaximumLineSize(size*2+(placement.verticalSpacing or placement.spacing))
            end
        end
    end)
    if not positioned then
        lastError=tostring(positionError)
        return nil,true
    end
    pcall(function()
        c:SetFrameLevel((button:GetFrameLevel() or 1)+25)
        if c.SetMouseClickEnabled then pcall(c.SetMouseClickEnabled, c, false) end
        if c.SetMouseMotionEnabled then pcall(c.SetMouseMotionEnabled, c, false) end
    end)
    local showNumbers=placement.numbers
    local opacity=HBCA_CreateRowIconOpacity(c,button,side,set)
    local initializeFrame=HBCA_MakeInit(size, placement, showNumbers, opacity)
    local ready, err=pcall(function()
        c:SetUnit(button.unit)
        if side=="hot" and HEALBOT_FOREVER then
            assert(type(c.SetAuraGroupCandidateFilters)=="function" and
                type(c.SetAuraGroupMaxFrameCount)=="function","native buff filter updates unavailable")
            local own,everyone,ownLimit,everyoneLimit,wanted=HBCA_BuffRowPolicy(spellFilter,g,maxN)
            c:AddAuraGroup(helpfulGroup,"HELPFUL|PLAYER",
                {maxFrameCount=ownLimit, initializeFrame=initializeFrame,
                 layout=HBCA_Layout(size,placement),candidateFilters=own})
            local everyonePlacement={}
            for key,value in pairs(placement) do everyonePlacement[key]=value end
            -- An Everyone row can show other casters; never paint a fixed Self marker.
            everyonePlacement.markerTexture=nil
            c:AddAuraGroup(everyoneGroup,"HELPFUL",
                {maxFrameCount=everyoneLimit,initializeFrame=HBCA_MakeInit(size,everyonePlacement,showNumbers,opacity),
                 layout=HBCA_Layout(size,placement),candidateFilters=everyone})
            c.hbcaBuffLimit,c.hbcaHasBuffs=maxN,wanted
            c.hbcaBuffPolicy={filter=spellFilter,limit=maxN,duration=HBCA_BuffRowDuration(g)}
        else
            local cf=side=="hot" and HealBot_Aura_NativeBuffExclusions and {excludeSpellIDs=HealBot_Aura_NativeBuffExclusions()} or nil
            if side=="hot" and (g.CombatAurasMaxDur or 0)>0 then
                -- native candidate filter: seconds of TOTAL duration; finite cap also
                -- rejects permanent auras (technique per DandersFrames)
                cf=cf or {}
                cf.maxDuration=g.CombatAurasMaxDur
            end
            if spellFilter then
                cf=cf or {}
                cf.includeDispelTypes=spellFilter.includeDispelTypes
                cf.includeSpellIDs=spellFilter.includeSpellIDs
                cf.excludeSpellIDs=spellFilter.excludeSpellIDs or cf.excludeSpellIDs
            end
            c:AddAuraGroup("hbca"..side, filter,
                { maxFrameCount=maxN, initializeFrame=initializeFrame,
                  layout=HBCA_Layout(size,placement), candidateFilters=cf })
        end
        c:SetEnabled(true)
    end)
    if not ready then
        c:Hide()
        lastError=tostring(err)
        return nil,true
    end
    return c
end

local function HBCA_BuildWeakenedSoulSlot(button, layout)
    local g=HBCA_Defaults()
    local size=layout.size or g.CombatAurasSize
    local container
    local ok, err=pcall(function()
        container=CreateFrame("AuraContainer",nil,button,"CustomAuraContainerTemplate")
        local opacity=HBCA_CreateRowIconOpacity(container,button,"db",layout.iconSet)
        local initialize=HBCA_MakeInit(size,layout,layout.numbers,opacity)
        container:Hide()
        container:SetSize(size,size)
        container:SetPoint(layout.point,layout.relative,layout.relativePoint,
            layout.x,layout.y)
        container:SetFrameLevel((button:GetFrameLevel() or 1)+25)
        if container.SetMouseClickEnabled then container:SetMouseClickEnabled(false) end
        if container.SetMouseMotionEnabled then container:SetMouseMotionEnabled(false) end
        container:SetUnit(button.unit)
        -- The native slot draws the matched aura's own icon and remaining time.
        -- Only NeverSecret harmful auras support identity filters on allies.
        local candidates=weakenedSoulCandidates
        if layout.weakenedSoulMode=="exact" then
            candidates={includeSpellIDs={ [weakenedSoulSpellID]=true }}
        end
        container:AddAuraSlot("hbcaweakenedSoul","HARMFUL",{
            candidateFilters=candidates,
            initializeFrame=function(auraButton)
                auraButton:ClearAllPoints()
                -- Slots do not contribute to the container's flow size. A
                -- slot-only container may become 0x0 after native layout, so
                -- centering against it moves half the icon off its configured
                -- anchor. Preserve the same anchor point at both levels.
                auraButton:SetPoint(layout.point,container,layout.point,0,0)
                initialize(auraButton)
            end,
        })
        container:SetEnabled(true)
    end)
    if not ok then
        if container then pcall(container.Hide,container) end
        lastError=tostring(err)
        return nil
    end
    return container
end

-- Reserve rows use the same native icon factory and filters as normal bars.
-- Share public configuration within one synchronous pass, never across events.
function HealBot_Forever_PrepareArrivalAuraContext()
    if InCombatLockdown() or not HBCA_Enabled() then return {} end
    return {filters=HBCA_ConfiguredBuffFilters(HBCA_Defaults())}
end

-- A roster pass uses one visible donor to skin many unoccupied slots. Read
-- that donor's geometry once. The row, unit and caster policy stay per slot.
local function HBCA_ArrivalAnchor(layout,source,cx,cy)
    local x,y=source:GetCenter()
    if not x or not y then return false end
    local point=layout.point
    local dx=point:find("RIGHT") and source:GetWidth()/2 or (point:find("LEFT") and -source:GetWidth()/2 or 0)
    local dy=point:find("TOP") and source:GetHeight()/2 or (point:find("BOTTOM") and -source:GetHeight()/2 or 0)
    local _,_,_,baseX,baseY=source:GetPoint(1)
    -- A dedicated slot can be offset from its skin's first icon.
    layout.x=x-cx+dx+layout.x-(baseX or layout.x)
    layout.y=y-cy+dy+layout.y-(baseY or layout.y)
    layout.relative=nil
    layout.relativePoint="CENTER"
    return true
end

local function HBCA_ArrivalDebuffPlans(donor,cx,cy)
    local plans={}
    local g=HBCA_Defaults()
    local cures=HealBot_Config_Cures
    if not HEALBOT_FOREVER or g.CombatAurasDebuffs<1 or
        (cures and (not cures.DebuffWatch or not cures.DebuffWatchInCombat)) then return plans end
    local types,signature,scoped=HealBot_Forever_GetDebuffTypes()
    local wantsSlot=g.CombatAurasNativeWeakenedSoul and HBCA_WeakenedSoulWanted(nil,true)
    if signature=="" and not wantsSlot then return plans end
    local db=HBCA_SkinLayout(donor,"db",1)
    db.dispelSignature=signature
    local slot=wantsSlot and HBCA_WeakenedSoulLayout(donor,g,db)
    local function Add(kind,layout,set,filter)
        local icon=donor.gref.icon[debuffStart[set]]
        if not icon or not HBCA_ArrivalAnchor(layout,icon,cx,cy) then return end
        local fields={}
        for key,value in pairs(layout) do
            if key~="x" and key~="y" then fields[#fields+1]=key.."="..tostring(value) end
        end
        table.sort(fields)
        plans[kind]={layout=layout,key=table.concat(fields,","),filter=filter,scoped=kind=="db" and scoped}
    end
    if signature~="" and db.limit and db.limit>0 then
        local exclusions,exclusionSignature=HBCA_DebuffExclusions()
        db.exclusionSignature=exclusionSignature
        db.limit=math.min(g.CombatAurasDebuffs,db.limit)
        db.scoped=not not scoped
        Add("db",db,1,{includeDispelTypes=scoped and {} or types,excludeSpellIDs=exclusions})
    end
    if slot then Add("slot",slot,slot.iconSet) end
    return plans
end

local function HBCA_ArrivalLayout(donor, frame, context)
    local previous=context.arrivalLayout
    if previous and previous.donor==donor and previous.frame==frame then return previous end
    local plans,bySet,key,signatureFields={},{},{},{}
    local filters=context.filters
    local cx,cy=donor.gref.Bar:GetCenter()
    if not cx or not cy then return end
    local hots=HBCA_Defaults().CombatAurasHots or 4
    key[#key+1]="hots:"..tostring(hots)
    for set=1,3 do
        if HEALBOT_FOREVER or (not filters and set==1) or (filters and filters[set]) then
            local source=donor.gref.icon[buffStart[set]]
            local layout=HBCA_SkinLayout(donor,"hot",set)
            if HBCA_ArrivalAnchor(layout,source,cx,cy) then
                layout.limit=hbv_Skins_GetIconVar("MAXBICONS",frame,set)
                local fields={}
                -- Screen-space offsets can change as the donor grid moves.
                -- Reanchor existing containers for position-only changes;
                -- their native groups and icon factories are unchanged.
                for field,value in pairs(layout) do
                    if field~="x" and field~="y" then
                        local valueString=tostring(value)
                        fields[#fields+1]=field.."="..valueString
                        signatureFields[set..":"..field]=valueString
                    end
                end
                table.sort(fields)
                local limit=layout.limit or hots
                if set==1 then limit=math.min(limit,hots) end
                local planKey=set..":"..limit..":"..table.concat(fields,",")
                key[#key+1]=planKey
                if limit>0 then
                    local plan={layout=layout,set=set,key=planKey}
                    plans[#plans+1]=plan
                    bySet[set]=plan
                end
            end
        end
    end
    local result={donor=donor,frame=frame,plans=plans,bySet=bySet,key=table.concat(key,";"),fields=signatureFields}
    result.debuffs=HBCA_ArrivalDebuffPlans(donor,cx,cy)
    context.arrivalLayout=result
    return result
end

local function HBCA_RefreshArrivalIconOpacity(row)
    if row.arrivalAuras then
        for _,item in ipairs(row.arrivalAuras) do HBCA_SetRowIconOpacity(item.container,row) end
    end
    if row.arrivalDebuffs then
        for _,item in pairs(row.arrivalDebuffs) do HBCA_SetRowIconOpacity(item.container,row) end
    end
end

function HealBot_Forever_SetArrivalIconOpacity(row,alpha,enabledAlpha)
    if row.hbcaArrivalAlpha==alpha and row.hbcaArrivalEnabledAlpha==enabledAlpha then return end
    row.hbcaArrivalAlpha,row.hbcaArrivalEnabledAlpha=alpha,enabledAlpha
    HBCA_RefreshArrivalIconOpacity(row)
end

local function HBCA_UpdateArrivalAnchor(row,item,layout)
    if not item.anchorFailed and item.x==layout.x and item.y==layout.y and item.relative==row.healthBar then return end
    local ok,err=pcall(function()
        item.container:ClearAllPoints()
        item.container:SetPoint(layout.point,row.healthBar,layout.relativePoint,layout.x,layout.y)
    end)
    item.anchorFailed=not ok
    if ok then item.x,item.y,item.relative=layout.x,layout.y,row.healthBar
    else
        lastError=tostring(err)
        item.container:Hide()
        item.container.hbcaShown=false
    end
end

local pendingRetirement={}
local function RetireAuraContainer(container)
    if not container then return end
    if InCombatLockdown() then
        pendingRetirement[container]=true
        return
    end
    local ok,err=pcall(container.SetEnabled,container,false)
    if ok then
        pendingRetirement[container]=nil
    else
        lastError=tostring(err)
        pendingRetirement[container]=true
    end
end

local function HBCA_SkinArrivalDebuffs(row,plans)
    local items=row.arrivalDebuffs
    if not items and not next(plans) then return end
    if not items then items={}; row.arrivalDebuffs=items end
    local retry=row.arrivalDebuffRetry
    if retry then
        for kind in pairs(retry) do if not plans[kind] then retry[kind]=nil end end
    end
    for kind,item in pairs(items) do
        if not plans[kind] or plans[kind].key~=item.key then
            item.container:Hide()
            pcall(item.container.SetEnabled,item.container,false)
            items[kind]=nil
        end
    end
    for kind,plan in pairs(plans) do
        if items[kind] then
            HBCA_UpdateArrivalAnchor(row,items[kind],plan.layout)
            if items[kind].anchorFailed then items[kind].shown=false end
        elseif not retry or not retry[kind] or HBCA_RetryDue(retry[kind],row.unit,plan.key) then
            local layout={}
            for k,v in pairs(plan.layout) do layout[k]=v end
            layout.relative=row.healthBar
            local container
            if kind=="slot" then container=HBCA_BuildWeakenedSoulSlot(row,layout)
            else container=HBCA_BuildOne(row,"db",layout,1,plan.filter) end
            if container then
                items[kind]={container=container,key=plan.key,x=layout.x,y=layout.y,relative=row.healthBar,
                    scoped=plan.scoped,filter=plan.filter,shown=false}
                if retry then retry[kind]=nil end
            else
                if not retry then retry={}; row.arrivalDebuffRetry=retry end
                retry[kind]=HBCA_BuildRetry(retry[kind],row.unit,plan.key)
            end
        end
    end
end

function HealBot_Forever_SkinArrivalAuras(row, donor, context)
    arrivalDonors[row]=donor
    if InCombatLockdown() then return end
    if not HBCA_Enabled() then
        for _, item in ipairs(row.arrivalAuras or {}) do
            item.container:Hide()
            item.container.hbcaShown=false
        end
        if row.arrivalDebuffs then HBCA_SkinArrivalDebuffs(row,{}) end
        return
    end
    context=context or HealBot_Forever_PrepareArrivalAuraContext()
    local geometry=HBCA_ArrivalLayout(donor,row.frame,context)
    if not geometry then return end
    HBCA_SkinArrivalDebuffs(row,geometry.debuffs)
    local plans,key,signatureFields=geometry.plans,geometry.key,geometry.fields
    local filters=HBCA_ButtonBuffFilters(row,context.filters)
    local previousRetry=row.arrivalAuraKey==key and row.arrivalBuffRetry
    if row.arrivalAuraKey==key and not HBCA_RetryDue(previousRetry,row.unit,filters) then
        for _,item in ipairs(row.arrivalAuras or {}) do
            HBCA_UpdateArrivalAnchor(row,item,geometry.bySet[item.set].layout)
            if HEALBOT_FOREVER then HBCA_UpdateBuffRow(item.container,filters and filters[item.set],HBCA_Defaults()) end
        end
        return
    end
    if type(HealBot_Forever_RecordArrivalRebuild)=="function" then
        local reasons={}
        local previous=row.arrivalAuraSignatureFields
        if not row.arrivalAuraKey then reasons.newRow=true
        elseif not previous then reasons.noPriorSignature=true
        else
            if row.arrivalAuraHots~=HBCA_Defaults().CombatAurasHots then reasons.hots=true end
            for field,value in pairs(signatureFields) do
                if previous[field]~=value then reasons[field:match(":(.+)$")]=true end
            end
            for field in pairs(previous) do
                if signatureFields[field]==nil then reasons[field:match(":(.+)$")]=true end
            end
        end
        HealBot_Forever_RecordArrivalRebuild(reasons)
    end
    row.arrivalAuraSignatureFields=signatureFields
    row.arrivalAuraHots=HBCA_Defaults().CombatAurasHots
    row.arrivalAuraKey=key
    local retained={}
    for _,item in ipairs(row.arrivalAuras or {}) do
        local plan=geometry.bySet[item.set]
        if plan and plan.key==item.key then
            retained[item.set]=item
        else
            item.container:Hide()
            RetireAuraContainer(item.container)
        end
    end
    row.arrivalAuras={}
    row.arrivalBuffRetry=nil
    for _,plan in ipairs(plans) do
        local item=retained[plan.set]
        if item then
            HBCA_UpdateArrivalAnchor(row,item,plan.layout)
            if HEALBOT_FOREVER then HBCA_UpdateBuffRow(item.container,filters and filters[plan.set],HBCA_Defaults()) end
        else
            local layout={}
            for field,value in pairs(plan.layout) do layout[field]=value end
            layout.relative=row.healthBar
            local container=HBCA_BuildOne(row,"hot",layout,plan.set,filters and filters[plan.set])
            if container then
                item={container=container,set=plan.set,key=plan.key,x=layout.x,y=layout.y,relative=layout.relative}
            else
                row.arrivalBuffRetry=row.arrivalBuffRetry or HBCA_BuildRetry(previousRetry,row.unit,filters)
            end
        end
        if item then row.arrivalAuras[#row.arrivalAuras+1]=item end
    end
end

local function HBCA_ShowArrivalAuras(row,refreshTargets)
    local available=HBCA_Enabled() and UnitExists(row.unit) and UnitIsConnected(row.unit)
    local show=available and HealBot_Forever_BuffsEnabled()
    for _, item in ipairs(row.arrivalAuras or {}) do
        local container=item.container
        local visible=not not (show and not item.anchorFailed and container.hbcaHasBuffs~=false)
        if container.hbcaShown~=visible then
            container:SetShown(visible)
            container.hbcaShown=visible
        end
    end
    if row.arrivalDebuffs then
        local debuffs=available and InCombatLockdown() and HealBot_Forever_DebuffsEnabled()
        for kind,item in pairs(row.arrivalDebuffs) do
            local visible=not not (debuffs and not item.anchorFailed)
            if visible and kind=="slot" then
                if refreshTargets~=false or item.targetAllowed==nil then
                    item.targetAllowed=HBCA_WeakenedSoulWanted(row,true)
                end
                visible=item.targetAllowed
            elseif visible and item.scoped then
                if refreshTargets~=false or not item.targetSignature then
                    local types,signature=HealBot_Forever_GetDebuffTypes(row)
                    if item.targetSignature~=signature then
                        local policy={includeDispelTypes=types,excludeSpellIDs=item.exclusions or item.filter.excludeSpellIDs}
                        local ok=pcall(item.container.SetAuraGroupCandidateFilters,item.container,"hbcadb",policy)
                        item.targetSignature=ok and signature or nil
                    end
                end
                visible=item.targetSignature~=nil and item.targetSignature~=""
            elseif not available then
                item.targetAllowed=nil
                item.targetSignature=nil
            end
            if item.shown~=visible then
                item.container:SetShown(visible)
                item.shown=visible
                if visible and item.container.UpdateAllAuras then item.container:UpdateAllAuras() end
            end
        end
    end
end

-- Structural changes wait for the next out-of-combat roster pass. Prepared
-- groups can apply new public target and exclusion rules immediately.
function HealBot_Forever_RefreshArrivalDebuffPolicy()
    local exclusions=HBCA_DebuffExclusions()
    for row in pairs(arrivalDonors) do
        local item=row.arrivalDebuffs and row.arrivalDebuffs.db
        if item then
            item.scoped,item.targetSignature,item.exclusions=true,nil,exclusions
        end
        if row.arrivalDebuffs then HBCA_ShowArrivalAuras(row,true) end
    end
end

function HealBot_Forever_UpdateArrivalAuras(row,refreshTargets)
    if buffFilters and buffFilters.targetRules and UnitExists(row.unit) and
       (not InCombatLockdown() or HealBot_Config_Buffs and HealBot_Config_Buffs.BuffCustomWatchInCombat==true) then
        local filters=HBCA_ButtonBuffFilters(row,buffFilters)
        local g=HBCA_Defaults()
        for _,item in ipairs(row.arrivalAuras or {}) do HBCA_UpdateBuffRow(item.container,filters[item.set],g) end
    end
    HBCA_ShowArrivalAuras(row,refreshTargets)
end

local function HBCA_SetLegacyBuffsShown(button, shown, set)
    set=set or 1
    if not HEALBOT_FOREVER then return end
    local hidden=not shown
    button.hbcaLegacyBuffsHidden=button.hbcaLegacyBuffsHidden or {}
    if (button.hbcaLegacyBuffsHidden[set] or false)==hidden then return end
    button.hbcaLegacyBuffsHidden[set]=hidden
    local refs=button.gref
    for i=buffStart[set],buffEnd[set] do
        refs.icon[i]:SetShown(shown)
        refs.iconf[i]:SetShown(shown)
        refs.txt.expire[i]:SetShown(shown)
        refs.txt.count[i]:SetShown(shown)
        refs.indicator.selfcast[i]:SetShown(shown)
    end
end

-- Native artwork stays at the skin's original anchor. Public artwork uses
-- the already prepared icon indices after the native group's confirmed budget.
local function HBCA_SetDebuffBudget(row,maximum,wanted)
    local current=row.hbcaDebuffBudget or maximum
    if current==wanted then return current end
    local combat=not not InCombatLockdown()
    local now=GetTime and GetTime() or 0
    if row.hbcaBudgetFailure==combat and (combat or now<(row.hbcaBudgetRetry or 0)) then return current end
    local ok=pcall(row.SetAuraGroupMaxFrameCount,row,"hbcadb",wanted)
    if ok then
        row.hbcaDebuffBudget=wanted
        row.hbcaBudgetFailure=nil
        return wanted
    end
    row.hbcaBudgetFailure=combat
    row.hbcaBudgetRetry=now+2
    return current
end

function HealBot_CombatAuras_GetMixedDebuffSlots(button,limit,wanted)
    local a=attached[button]
    local state=button.aura and button.aura.debuff
    if not HEALBOT_FOREVER or not a or not a.db or not a.dbShown or a.dbDirty
        or a.unit~=button.unit or not state or state.scanUnit~=button.unit
        or state.scanCombat~=(not not InCombatLockdown()) or state.publicUnit==button.unit then return 0,limit end
    if a.dbLayout.scoped and select(2,HealBot_Forever_GetDebuffTypes(button))=="" then return 0,limit end
    local maximum=math.min(a.dbLayout.limit or 6,HBCA_Defaults().CombatAurasDebuffs or 3)
    local budget=HBCA_SetDebuffBudget(a.db,maximum,math.max(1,maximum-wanted))
    return budget,math.max(0,math.min(limit,maximum)-budget)
end

local function HBCA_ShowDebuffRow(a, reserve)
    local row
    if a.dbShown and not a.publicDebuffs and not a.dbPolicyDirty and not a.dbScopeEmpty then
        row=(reserve and a.dbAfterShield) or a.db
    end
    if row and HEALBOT_FOREVER and (not a.mixedPublicCount or a.mixedPublicCount==0) and row.hbcaDebuffBudget then
        local maximum=math.min(a.dbLayout.limit or 6,HBCA_Defaults().CombatAurasDebuffs or 3)
        HBCA_SetDebuffBudget(row,maximum,maximum)
    end
    if row==a.visibleDebuffRow then return end
    if a.visibleDebuffRow then a.visibleDebuffRow:Hide() end
    a.visibleDebuffRow=row
    if row then
        row:Show()
        if row.UpdateAllAuras then row:UpdateAllAuras() end
    end
end

local function HBCA_SetNativeSlotShown(button,a,show)
    local row=a.weakenedSoul
    if row then
        show=not not show
        local ok,err=pcall(function()
            local refresh=not button.hbcaNativeDebuffs
            if show and a.weakenedSoulUnit~=button.unit then
                row:SetUnit(button.unit)
                a.weakenedSoulUnit=button.unit
                refresh=true
            end
            if refresh or not show then row:SetShown(show) end
            if show and refresh and row.UpdateAllAuras then row:UpdateAllAuras() end
        end)
        if not ok then
            lastError=tostring(err)
            pcall(row.Hide,row)
        end
        show=ok and show
    else
        show=false
    end
    if (button.hbcaNativeDebuffs or false)~=show then
        button.hbcaNativeDebuffs=show
        if button.aura and button.aura.debuff then
            button.aura.debuff.update=true
            HealBot_Timers_Set("AURA","CheckDebuffs")
        end
    end
    return show
end

local function HBCA_UpdateDebuffRowPolicy(button,a,publicDispels)
    if not HEALBOT_FOREVER or not a.dbShown or not a.db or a.publicDebuffs then return end
    local excluded,signature=HBCA_DebuffExclusions()
    local types,typeSignature=a.dbLayout.dispelTypes,a.dbLayout.dispelSignature
    if a.dbLayout.scoped then types,typeSignature=HealBot_Forever_GetDebuffTypes(button) end
    a.dbScopeEmpty=typeSignature==""
    if a.dbScopeEmpty then return end
    if not a.dbPolicyDirty and signature==a.dbLayout.exclusionSignature and a.publicDispels==publicDispels
        and (a.appliedDispelSignature or a.dbLayout.dispelSignature)==typeSignature then return end
    local ids=excluded
    if publicDispels then
        ids={}
        for id in pairs(excluded) do ids[id]=true end
        -- Blizzard applies these exclusions where it permits identity matching.
        for id in pairs(publicDispels) do ids[id]=true end
    end
    local filter={includeDispelTypes=types,excludeSpellIDs=ids}
    local ok=pcall(a.db.SetAuraGroupCandidateFilters,a.db,"hbcadb",filter)
    if ok and a.dbAfterShield then
        ok=pcall(a.dbAfterShield.SetAuraGroupCandidateFilters,a.dbAfterShield,"hbcadb",filter)
    end
    if ok then
        a.dbLayout.excludedSpellIDs,a.dbLayout.exclusionSignature=excluded,signature
        a.publicDispels=publicDispels
        a.appliedDispelSignature=typeSignature
        a.dbPolicyDirty=nil
    else
        a.dbPolicyDirty=true
        deferred[button]=true
    end
end

local function HBCA_InvalidateDebuffScan(button)
    local state=button.aura and button.aura.debuff
    if not state then return end
    state.scanUnit=nil
    state.update=true
    if button.status.events and HealBot_Events_UnitDebuff then HealBot_Events_UnitDebuff(button) end
end

local function HBCA_RefreshShieldLockout(button)
    local a=attached[button]
    local icon=a and a.shieldLockout
    if not a then return end
    local state=button.aura and button.aura.debuff
    local current=state and state.scanUnit==button.unit and state.scanCombat==(not not InCombatLockdown())
    a.publicDebuffs=current and state.publicUnit==button.unit
    local publicDispels=current and state.publicDispels
    if current and state.sortedPublicIcons then publicDispels=state.visibleDispels end
    local icons=button.icon and button.icon.debuff
    a.mixedPublicCount=current and not a.publicDebuffs and icons and icons.count and icons.count[1] or 0
    HBCA_UpdateDebuffRowPolicy(button,a,publicDispels)
    if a.publicDebuffs or (current and state.publicShield) then
        HBCA_SetNativeSlotShown(button,a,false)
        HBCA_ShowDebuffRow(a,false)
        if icon then icon:Hide() end
        return
    end
    if HBCA_SetNativeSlotShown(button,a,a.shieldLockoutVisible and a.unit==button.unit
            and HBCA_NativeBuffContext() and HBCA_WeakenedSoulWanted(button)) then
        HBCA_ShowDebuffRow(a,false)
        if icon then icon:Hide() end
        return
    end
    if not icon then HBCA_ShowDebuffRow(a,false); return end
    local start,duration
    if a.shieldLockoutVisible and a.unit==button.unit and HBCA_NativeBuffContext()
        and HealBot_Aura_GetDebuffIconPreference(6788,InCombatLockdown())~=false then
        start,duration=HealBot_Forever_GetShieldLockout(button)
    end
    local set=start and HealBot_Aura_GetTrackedDebuffIconSet(button,6788)
    local slots=set and hbv_Skins_GetIconVar("MAXDICONS",button.frame,set)
    if not slots or slots<1 then
        HBCA_ShowDebuffRow(a,false)
        icon:Hide()
        return
    end
    local reserve=set==1 and a.mixedPublicCount==0
    HBCA_ShowDebuffRow(a,reserve)
    local debuffs=button.icon and button.icon.debuff
    if reserve and a.dbAfterShield then
        slots=0
    elseif set==1 and a.db then
        slots=math.min(a.dbLayout.limit or 6,HBCA_Defaults().CombatAurasDebuffs or 3)
    else
        slots=debuffs and debuffs.count and debuffs.count[set] or 0
    end
    local layout=HBCA_SkinLayout(button,"db",set)
    layout.slots=slots
    local g=HBCA_Defaults()
    if not HBCA_SameLayout(icon.layout,layout) then
        local size=layout.size or g.CombatAurasSize or 12
        local strideX=size+layout.spacing
        local strideY=size+(layout.verticalSpacing or layout.spacing)
        local xDirection=layout.point:find("RIGHT",1,true) and -1 or 1
        local yDirection=layout.point:find("BOTTOM",1,true) and 1 or -1
        local column=layout.double and math.floor(slots/2) or slots
        local line=layout.double and slots%2 or 0
        icon:SetSize(size,size)
        icon:ClearAllPoints()
        icon:SetPoint(layout.point,layout.relative,layout.relativePoint,
                      layout.x+column*strideX*xDirection,layout.y+line*strideY*yDirection)
        icon.texture:SetTexCoord(layout.zoom,1-layout.zoom,layout.zoom,1-layout.zoom)
        if icon.cooldown.SetHideCountdownNumbers then
            icon.cooldown:SetHideCountdownNumbers(not layout.numbers)
        end
        local countdown=icon.cooldown.GetCountdownFontString and icon.cooldown:GetCountdownFontString()
        if countdown and layout.font then
            pcall(HBCA_StyleAuraText,countdown,icon,size,layout,false)
        end
        icon.layout=layout
    end
    if icon.start~=start then
        icon.cooldown:SetCooldown(start,duration)
        icon.start=start
    end
    icon:Show()
end

function HealBot_Forever_RebindDebuffScan(button)
    HBCA_InvalidateDebuffScan(button)
    HBCA_RefreshShieldLockout(button)
end

local function HBCA_CreateShieldLockout(button)
    local icon=CreateFrame("Frame",nil,button)
    icon:SetFrameLevel(button:GetFrameLevel()+26)
    icon.texture=icon:CreateTexture(nil,"ARTWORK")
    icon.texture:SetAllPoints()
    icon.texture:SetTexture(HealBot_WoWAPI_SpellTexture(6788))
    icon.cooldown=CreateFrame("Cooldown",nil,icon,"CooldownFrameTemplate")
    icon.cooldown:SetAllPoints()
    icon.cooldown:SetDrawEdge(false)
    icon:Hide()
    return icon
end

-- Only icon-set 1 belongs to this row. Keep HealBot's debuff scanning, cure
-- warnings and custom icon sets 2/3; suppress overlapping legacy artwork.
function HealBot_CombatAuras_UsesNativeDebuffs(button)
    local a=attached[button]
    return not not (a and a.nativeDebuffs and a.unit==button.unit and
                    button.status and button.status.events)
end

local function HBCA_SetNativeDebuffs(button, active)
    local a=attached[button]
    active=not not active
    if not a or active==(not not a.nativeDebuffs) then return end
    a.nativeDebuffs=active
    if active then
        if HealBot_Aura_RemoveIcon then
            for i=51,56 do
                if button.gref and button.gref.icon and button.gref.icon[i] then
                    HealBot_Aura_RemoveIcon(button, i)
                end
            end
        end
    elseif button.status and button.status.events and button.aura and button.aura.debuff then
        -- Restore the ordinary icons even if no new UNIT_AURA event arrives.
        button.aura.debuff.update=true
        if HealBot_Events_UnitDebuff then HealBot_Events_UnitDebuff(button) end
    end
end

local function HBCA_HideButton(button)
    local a=attached[button]
    if not a then return end
    if a.hot then pcall(function() a.hot:Hide() end); a.hot.hbcaShown=false end
    HBCA_SetNativeDebuffs(button, false)
    a.dbShown=false
    HBCA_ShowDebuffRow(a,false)
    a.shieldLockoutVisible=false
    HBCA_SetNativeSlotShown(button,a,false)
    if a.shieldLockout then a.shieldLockout:Hide() end
    HBCA_SetLegacyBuffsShown(button, true)
    for set,row in pairs(a.extra) do
        row:Hide()
        row.hbcaShown=false
        HBCA_SetLegacyBuffsShown(button, true, set)
    end
end

-- Retarget only rows that exist. Reuse native widgets during combat; if the
-- client rejects a unit change, never display auras belonging to the old unit.
local function HBCA_SetBuffRowShown(row, shown, refresh)
    local ok=pcall(function()
        local wasShown=row.hbcaShown
        if wasShown~=shown then
            row:SetShown(shown)
            row.hbcaShown=shown
        end
        if shown and (not wasShown or refresh) and row.UpdateAllAuras then row:UpdateAllAuras() end
    end)
    return ok and shown
end

local function HBCA_RefreshButtonIconOpacity(button)
    local a=attached[button]
    if not a then return end
    HBCA_SetRowIconOpacity(a.hot,button)
    HBCA_SetRowIconOpacity(a.db,button)
    HBCA_SetRowIconOpacity(a.dbAfterShield,button)
    HBCA_SetRowIconOpacity(a.weakenedSoul,button)
    for _,row in pairs(a.extra) do HBCA_SetRowIconOpacity(row,button) end
end

local function HBCA_SetButtonShown(button, show)
    local a=attached[button]
    if not a then return end
    local vis=not not ((show or HBCA_Defaults().CombatAurasPersistDebuffs) and HBCA_Enabled() and button.unit and button.frame and button.frame<10 and
                       button.status and button.status.events and (HEALBOT_FOREVER or button:IsShown()))
    if HEALBOT_FOREVER and vis and not UnitIsConnected(button.unit) then vis=false end
    if a.db and a.db.hbcaBudgetFailure and not InCombatLockdown() then a.db.hbcaBudgetFailure=nil end
    local retargeted=vis and button.unit~=a.unit
    if retargeted then
        local okH=not a.hot or pcall(a.hot.SetUnit, a.hot, button.unit)
        local okD=not a.db or pcall(a.db.SetUnit, a.db, button.unit)
        local okShifted=not a.dbAfterShield or pcall(a.dbAfterShield.SetUnit,a.dbAfterShield,button.unit)
        for _, row in pairs(a.extra) do
            if not pcall(row.SetUnit,row,button.unit) then okH=false end
        end
        if okH and okD and okShifted then
            a.unit=button.unit
        else
            vis=false
            deferred[button]=true
        end
    end
    local buffsEnabled=(not HealBot_Aura_BuffsEnabled or HealBot_Aura_BuffsEnabled()) and (not HEALBOT_FOREVER or HealBot_Forever_BuffsEnabled())
    a.publicBuffs=HBCA_PublicBuffsReady(button)
    local hotVisible=not not (vis and buffsEnabled and not a.buffDirty and not a.publicBuffs and HBCA_NativeBuffContext())
    local hotShown=a.hot and HBCA_SetBuffRowShown(a.hot,hotVisible and a.hot.hbcaHasBuffs~=false,retargeted)
    HBCA_SetLegacyBuffsShown(button, buffsEnabled and not hotShown)
    for set,row in pairs(a.extra) do
        local rowShown=HBCA_SetBuffRowShown(row,hotVisible and row.hbcaHasBuffs~=false,retargeted)
        HBCA_SetLegacyBuffsShown(button,buffsEnabled and not rowShown,set)
    end
    local dbShown=vis and (not HealBot_Aura_DebuffsEnabled or HealBot_Aura_DebuffsEnabled()) and (inCombat or HBCA_Defaults().CombatAurasPersistDebuffs)
    if HEALBOT_FOREVER then
        -- Outside combat the legacy icons apply the separate rest preferences.
        dbShown=dbShown and HBCA_NativeBuffContext() and not a.dbDirty and HealBot_Forever_DebuffsEnabled()
    end
    dbShown=not not dbShown
    a.dbShown=dbShown
    a.shieldLockoutVisible=dbShown
    HBCA_RefreshShieldLockout(button)
    HBCA_SetNativeDebuffs(button, not HEALBOT_FOREVER and a.visibleDebuffRow~=nil
        and HBCA_Defaults().CombatAurasPersistDebuffs)
end

local function HBCA_DropButton(button)
    local a=attached[button]
    if not a then return end
    HBCA_HideButton(button)
    -- Hidden is a presentation state. Retire the old unit's native processing
    -- when replacing an add-only group. Never disable containers in lockdown.
    RetireAuraContainer(a.hot)
    for _,row in pairs(a.extra) do RetireAuraContainer(row) end
    RetireAuraContainer(a.db)
    RetireAuraContainer(a.dbAfterShield)
    RetireAuraContainer(a.weakenedSoul)
    attached[button]=nil
    button.foreverShieldLockoutIcon=nil
end

local function HBCA_UpdateButtonBuffRows(button, rows, filters)
    local complete,failed=true,false
    local g=HBCA_Defaults()
    for set=1,3 do
        local row=set==1 and rows.hot or rows.extra[set]
        if row then
            if not HBCA_UpdateBuffRow(row,filters and filters[set],g) then complete,failed=false,true end
        elseif (set==1 and (rows.hotLayout.limit or 0)>0 and g.CombatAurasHots>0)
            or (set>1 and rows.extraLayouts[set] and (rows.extraLayouts[set].limit or 0)>0) then
            complete=false
        end
    end
    if complete then rows.filters=filters end
    -- Missing structural rows must not hide usable prepared rows. A failed
    -- native write, however, leaves an unconfirmed partial policy until retry.
    rows.buffDirty=failed
    if not complete then deferred[button]=true end
    return complete
end

-- Out-of-combat creation and recovery share one path. A partial native build
-- may leave two usable sets and one missing set. Retry only the missing one.
local function HBCA_PrepareButtonRows(button,a,filters)
    local previous=a.buildFailed
    a.buildFailed=nil
    local function build(side,layout,set,filter)
        local container,failed=HBCA_BuildOne(button,side,layout,set,filter)
        if failed then a.buildFailed=a.buildFailed or HBCA_BuildRetry(previous,button.unit,filters) end
        return container
    end
    if not a.hot and (HEALBOT_FOREVER or not filters or filters[1]) then
        a.hot=build("hot",a.hotLayout,1,filters and filters[1])
    end
    local dbLayout=a.dbLayout
    if not HEALBOT_FOREVER or dbLayout.dispelSignature~="" then
        local dbFilter=HEALBOT_FOREVER and {includeDispelTypes=dbLayout.dispelTypes,excludeSpellIDs=dbLayout.excludedSpellIDs} or nil
        if not a.db then a.db=build("db",dbLayout,1,dbFilter) end
        if a.db and not a.dbAfterShield and HEALBOT_FOREVER and HealBot_Forever_GetShieldLockout and select(2,UnitClass("player"))=="PRIEST" then
            local shifted={}
            for key,value in pairs(dbLayout) do shifted[key]=value end
            local size=shifted.size or HBCA_Defaults().CombatAurasSize or 12
            local direction=shifted.point:find("RIGHT",1,true) and -1 or 1
            shifted.x=shifted.x+(size+shifted.spacing)*direction
            a.dbAfterShield=build("db",shifted,1,dbFilter)
        end
    end
    if a.weakenedSoulLayout and not a.weakenedSoul then
        a.weakenedSoul=HBCA_BuildWeakenedSoulSlot(button,a.weakenedSoulLayout)
        if a.weakenedSoul then a.weakenedSoulUnit=button.unit
        else a.buildFailed=a.buildFailed or HBCA_BuildRetry(previous,button.unit,filters) end
    end
    for set,layout in pairs(a.extraLayouts) do
        if not a.extra[set] then a.extra[set]=build("hot",layout,set,filters and filters[set]) end
    end
    if a.buildFailed then deferred[button]=true end
end

local function HBCA_Attach(button, context)
    if not button then return end
    if not button.unit or not button.frame or button.frame>=10 or not button.status or not button.status.events then
        deferred[button]=nil
        HBCA_HideButton(button)
        return
    end
    known[button]=true
    if not HBCA_Enabled() then return end
    if InCombatLockdown() then
        deferred[button]=true
        HBCA_SetButtonShown(button, true)
        return
    end
    -- RegisterUnitEvents can fire before ResetSkin lays out the textures.
    -- Let the ResetSkin hook attach the first row using the final geometry.
    if HEALBOT_FOREVER and button.icon and button.icon.reset then return end
    if not HBCA_Probe() then
        if supported~=false then deferred[button]=true end
        return
    end
    deferred[button]=nil
    local g=HBCA_Defaults()
    local filters
    if context and not context.needsFilters then
        filters=context.filters
    else
        filters=HBCA_ConfiguredBuffFilters(g)
        if context then context.filters,context.needsFilters=filters,nil end
    end
    filters=HBCA_ButtonBuffFilters(button,filters)
    local a=attached[button]
    local hotLayout, dbLayout=HBCA_SkinLayout(button, "hot"), HBCA_SkinLayout(button, "db")
    local weakenedSoulLayout
    if HEALBOT_FOREVER then
        local types, signature, scoped=HealBot_Forever_GetDebuffTypes()
        dbLayout.scoped=scoped
        dbLayout.dispelSignature=signature
        dbLayout.dispelTypes=types
        dbLayout.excludedSpellIDs, dbLayout.exclusionSignature=HBCA_DebuffExclusions()
        weakenedSoulLayout=HBCA_WeakenedSoulLayout(button,g,dbLayout)
    end
    local extraLayouts={}
    for set=2,3 do
        if HEALBOT_FOREVER or (filters and filters[set]) then
            local layout=HBCA_SkinLayout(button,"hot",set)
            layout.limit=hbv_Skins_GetIconVar("MAXBICONS",button.frame,set) or 2
            extraLayouts[set]=layout
        end
    end
    if a then
        local same=(HEALBOT_FOREVER or a.filters==filters) and HBCA_SameLayout(a.hotLayout,hotLayout)
            and HBCA_SameLayout(a.dbLayout,dbLayout)
            and (weakenedSoulLayout and HBCA_SameLayout(a.weakenedSoulLayout,weakenedSoulLayout)
                or not weakenedSoulLayout and not a.weakenedSoulLayout)
        for set=2,3 do
            if (extraLayouts[set]~=nil)~=(a.extraLayouts[set]~=nil)
                or (extraLayouts[set] and not HBCA_SameLayout(a.extraLayouts[set],extraLayouts[set])) then same=false end
        end
        if same then
            if HBCA_RetryDue(a.buildFailed,button.unit,filters) then HBCA_PrepareButtonRows(button,a,filters)
            elseif a.buildFailed then deferred[button]=true end
            if HEALBOT_FOREVER then HBCA_UpdateButtonBuffRows(button,a,filters) end
            if not HEALBOT_FOREVER then a.buffDirty=false end
            a.dbDirty=false
            HBCA_SetButtonShown(button, inCombat or HEALBOT_FOREVER)
            return
        end
        HBCA_DropButton(button)
    end
    a={weakenedSoulLayout=weakenedSoulLayout,extra={},extraLayouts=extraLayouts,
       hotLayout=hotLayout, dbLayout=dbLayout, filters=filters, unit=button.unit}
    HBCA_PrepareButtonRows(button,a,filters)
    if HEALBOT_FOREVER and HealBot_Forever_GetShieldLockout then
        a.shieldLockout=HBCA_CreateShieldLockout(button)
        button.foreverShieldLockoutIcon=a.shieldLockout
    end
    attached[button]=a
    HBCA_SetButtonShown(button, inCombat or HEALBOT_FOREVER)
end

local function HBCA_AttachDeferred()
    if InCombatLockdown() then return end
    local context
    for button in pairs(deferred) do
        context=context or HealBot_Forever_PrepareArrivalAuraContext()
        deferred[button]=nil
        HBCA_Attach(button,context)
    end
    return context
end

local function HBCA_SetAllShown(show)
    for button in pairs(attached) do
        HBCA_SetButtonShown(button, show)
    end
end

local function HBCA_DropAll()
    for button in pairs(attached) do HBCA_DropButton(button) end
    attached={}
    deferred={}
    -- re-attach everything we have ever seen (builds run now or at next regen)
    for button in pairs(known) do deferred[button]=true end
    local context=HBCA_AttachDeferred()
    if not InCombatLockdown() then
        for row,donor in pairs(arrivalDonors) do
            context=context or HealBot_Forever_PrepareArrivalAuraContext()
            HealBot_Forever_SkinArrivalAuras(row,donor,context)
            HBCA_ShowArrivalAuras(row)
        end
    end
end

local function HBCA_RefreshBuffRows()
    local g=HBCA_Defaults()
    if not HEALBOT_FOREVER or not g then return end
    local filters=HBCA_ConfiguredBuffFilters(g)
    local combat=InCombatLockdown()
    local canUpdate=not combat or (HealBot_Config_Buffs and HealBot_Config_Buffs.BuffCustomWatchInCombat==true)
    for button,rows in pairs(attached) do
        if canUpdate then
            -- The per-row success cache also covers duration changes and retries
            -- after a partial write, even when the configured IDs are unchanged.
            HBCA_UpdateButtonBuffRows(button,rows,HBCA_ButtonBuffFilters(button,filters))
        else
            for set=1,3 do
                local row=set==1 and rows.hot or rows.extra[set]
                if row and not HBCA_BuffRowPolicyCurrent(row,filters and filters[set],g) then
                    deferred[button]=true
                    break
                end
            end
        end
        HBCA_SetButtonShown(button,true)
    end
    if canUpdate then
        for row,donor in pairs(arrivalDonors) do
            local rowFilters=HBCA_ButtonBuffFilters(row,filters)
            -- Monitoring/combat flags change policy and visibility, not skin
            -- geometry. Roster/skin refreshes prepare structural rows through
            -- SkinExtras; reskinning here made a flags event rebuild an entire
            -- reserve grid synchronously after harmless donor layout changes.
            for _,item in ipairs(row.arrivalAuras or {}) do
                if item.set then HBCA_UpdateBuffRow(item.container,rowFilters and rowFilters[item.set],g) end
            end
            HBCA_ShowArrivalAuras(row)
        end
    end
end

-- Optional timing access; inactive unless /hbperf is explicitly started.
function HealBot_Forever_VisitAuraPerfScopes(visit)
    HBCA_ConfiguredBuffFilters=visit("Aura.ConfiguredBuffFilters",HBCA_ConfiguredBuffFilters)
    HBCA_RefreshBuffRows=visit("Aura.RefreshBuffRows",HBCA_RefreshBuffRows)
    HBCA_UpdateBuffRow=visit("Aura.UpdateBuffRow",HBCA_UpdateBuffRow)
    HBCA_SetButtonShown=visit("Aura.SetButtonShown",HBCA_SetButtonShown)
    HBCA_BuildOne=visit("Aura.BuildOne",HBCA_BuildOne)
end

function HealBot_Forever_SetWeakenedSoulNativeEnabled(enabled)
    local g=HBCA_Defaults()
    if not HEALBOT_FOREVER or not g then return false end
    enabled=not not enabled
    if (g.CombatAurasNativeWeakenedSoul or false)==enabled then return true end
    g.CombatAurasNativeWeakenedSoul=enabled
    for button in pairs(known) do deferred[button]=true end
    if InCombatLockdown() then
        HBCA_SetAllShown(true)
    else
        HBCA_AttachDeferred()
    end
    return true
end

function HealBot_Forever_RefreshDebuffIconPreferences()
    debuffPolicies={}
    if not HEALBOT_FOREVER or not HBCA_Enabled() then return end
    HBCA_SetAllShown(true)
    HBCA_AttachDeferred()
end

-- ---------- wiring ----------

local ev=CreateFrame("Frame")
ev:RegisterEvent("PLAYER_LOGIN")
ev:RegisterEvent("PLAYER_ENTERING_WORLD")
ev:RegisterEvent("PLAYER_REGEN_DISABLED")
ev:RegisterEvent("PLAYER_REGEN_ENABLED")
if HEALBOT_FOREVER and C_RestrictedActions then pcall(ev.RegisterEvent,ev,"ADDON_RESTRICTION_STATE_CHANGED") end
ev:SetScript("OnEvent", function(_, event)
    if event~="PLAYER_LOGIN" then buffScanGeneration=buffScanGeneration+1 end
    if event=="PLAYER_REGEN_DISABLED" then
        inCombat=true
        if HBCA_Enabled() then HBCA_SetAllShown(true) end
        if HEALBOT_FOREVER and HealBot_Aura_RefreshDebuffIconVisibility then
            HealBot_Aura_RefreshDebuffIconVisibility()
        end
    elseif event=="PLAYER_REGEN_ENABLED" then
        inCombat=false
        for container in pairs(pendingRetirement) do RetireAuraContainer(container) end
        HBCA_SetAllShown(HEALBOT_FOREVER)
        HBCA_AttachDeferred()
        if HEALBOT_FOREVER and HealBot_Aura_RefreshDebuffIconVisibility then
            HealBot_Aura_RefreshDebuffIconVisibility()
        end
    elseif event=="PLAYER_ENTERING_WORLD" or event=="ADDON_RESTRICTION_STATE_CHANGED" then
        -- The same party/raid token can cross a visibility boundary while
        -- personal combat stays unchanged. Re-evaluate its harmful scan too.
        if HEALBOT_FOREVER then
            for button in pairs(known) do HBCA_InvalidateDebuffScan(button) end
        end
        HBCA_SetAllShown(HEALBOT_FOREVER or inCombat)
        if HEALBOT_FOREVER and not InCombatLockdown() and HBCA_NativeBuffContext() and HealBot_Events_UnitBuff then
            for button in pairs(attached) do
                if button.status.events and button.aura and button.aura.buff then
                    button.aura.buff.update=true
                    HealBot_Events_UnitBuff(button)
                end
            end
        end
    elseif event=="PLAYER_LOGIN" then
        if HEALBOT_MIDNIGHT then HBCA_Probe() end
    end
end)

-- Buttons announce their unit binding through these two; hooksecurefunc keeps
-- us clear of HealBot's own call paths.
if type(hooksecurefunc)=="function" then
    if not HEALBOT_FOREVER then
        hooksecurefunc("HealBot_Aura_setCustomBuffFilterDisabled", HBCA_DropAll)
        hooksecurefunc("HealBot_Aura_SetAuraCheckFlags", function() HBCA_SetAllShown(inCombat) end)
    end
    if HEALBOT_FOREVER then
        hooksecurefunc("HealBot_Aura_Update_AllIcons",HBCA_RefreshButtonIconOpacity)
        hooksecurefunc("HealBot_Aura_CheckUnitBuffs",function(button)
            local rows=attached[button]
            if not rows then return end
            local refresh=rows.publicBuffs~=HBCA_PublicBuffsReady(button)
            if buffFilters and buffFilters.targetRules and (not InCombatLockdown() or HealBot_Config_Buffs and HealBot_Config_Buffs.BuffCustomWatchInCombat==true) then
                local filters=HBCA_ButtonBuffFilters(button,buffFilters)
                if rows.filters~=filters or rows.buffDirty then
                    HBCA_UpdateButtonBuffRows(button,rows,filters)
                    refresh=true
                end
            end
            if refresh then HBCA_SetButtonShown(button,true) end
        end)
        hooksecurefunc("HealBot_Aura_CheckUnitDebuffs",HBCA_RefreshShieldLockout)
        hooksecurefunc("HealBot_UpdateUnitGUIDChange",HealBot_Forever_RebindDebuffScan)
        hooksecurefunc("HealBot_SetUnitDisconnectChange", function(button)
            HBCA_InvalidateDebuffScan(button)
            pcall(HBCA_SetButtonShown, button, true)
        end)
        function HealBot_Forever_RefreshBuffExclusions()
            HBCA_RefreshBuffRows()
        end
        local rankRefreshQueued=false
        function HealBot_Forever_ObserveBuffRank(id,name)
            if rankRefreshQueued or not watchedRankNames or not watchedRankNames[name]
                or not C_Timer or not C_Timer.After then return end
            for set=1,3 do
                local row=buffFilters[set]
                if row and ((row.includeSpellIDs and row.includeSpellIDs[id])
                    or row.everyoneSpellFilter.includeSpellIDs[id]) then return end
            end
            -- The public aura cache has just learned a watched rank. Let the
            -- scan finish, then compile all newly seen ranks in one pass.
            rankRefreshQueued=true
            C_Timer.After(0,function()
                rankRefreshQueued=false
                HealBot_Forever_RefreshBuffExclusions()
            end)
        end
        hooksecurefunc("HealBot_Options_EnableDisableBuffBtn_OnClick", function()
            HealBot_Aura_setCustomBuffFilterDisabled()
        end)
        hooksecurefunc("HealBot_Aura_setLuVars", function(key)
            if key=="mapName" then
                HealBot_Forever_RefreshBuffExclusions()
                HealBot_Forever_RefreshDebuffIconPreferences()
            end
        end)
        hooksecurefunc("HealBot_Aura_setCustomDebuffFilterDisabled",HealBot_Forever_RefreshDebuffIconPreferences)
        hooksecurefunc("HealBot_Aura_RefreshDebuffIconVisibility",function()
            HBCA_SetAllShown(true)
        end)
        hooksecurefunc("HealBot_Options_setDebuffPriority",HealBot_Forever_RefreshDebuffIconPreferences)
        hooksecurefunc("HealBot_Aura_ConfigDebuffs",function()
            local g=HBCA_Defaults()
            if not g or not g.CombatAurasNativeWeakenedSoul then return end
            local pass={needsFilters=true}
            for button in pairs(attached) do pcall(HBCA_Attach,button,pass) end
        end)
        hooksecurefunc("HealBot_Aura_SetAuraCheckFlags", function()
            HBCA_RefreshBuffRows()
        end)
        hooksecurefunc("HealBot_Options_Debuff_Reset", function()
            local _, signature, scoped=HealBot_Forever_GetDebuffTypes()
            local pass={needsFilters=true}
            for button, rows in pairs(attached) do
                if rows.dbLayout.dispelSignature~=signature then
                    rows.dbDirty=true
                    pcall(HBCA_Attach,button,pass)
                else
                    rows.dbLayout.scoped=scoped
                    HBCA_SetButtonShown(button,true)
                end
            end
        end)
        local function refreshFrame(frame)
            local pass={needsFilters=true}
            for button in pairs(known) do
                if button.frame==frame then pcall(HBCA_Attach,button,pass) end
            end
        end
        hooksecurefunc("hbv_Skins_SetIconTextVar", function(_, key, frame)
            if key~="BUFFSCNT" and key~="BUFFSDUR" and key~="DBSCNT" and key~="DBSDUR"
                and key~="BUFFFONT" and key~="BUFFHEIGHT" and key~="BUFFOUTLINE"
                and key~="BUFFDURTHRH" and key~="BUFFDURWARN" and key~="DBDURTHRH" and key~="DBDURWARN"
                and key~="DBFONT" and key~="DBHEIGHT" and key~="DBOUTLINE" then return end
            refreshFrame(frame)
        end)
        hooksecurefunc("hbv_Skins_SetIconVar", function(_, key, frame)
            if key=="BUFFI15EN" or key=="DI15EN" then
                for button in pairs(attached) do
                    if button.frame==frame then HBCA_RefreshButtonIconOpacity(button) end
                end
                for row in pairs(arrivalDonors) do
                    if row.frame==frame then HBCA_RefreshArrivalIconOpacity(row) end
                end
                return
            end
            if key~="MAXBICONS" and key~="MAXDICONS" then return end
            refreshFrame(frame)
        end)
        hooksecurefunc("HealBot_Aura_ConfigClassHoT", function()
            HBCA_RefreshBuffRows()
        end)
    end
    hooksecurefunc("HealBot_Action_RegisterUnitEvents", function(button)
        pcall(HBCA_Attach, button)
    end)
    hooksecurefunc("HealBot_Action_UnregisterUnitEvents", function(button)
        if button.aura and button.aura.buff then button.aura.buff.publicGeneration=nil end
        if button.aura and button.aura.debuff then button.aura.debuff.scanUnit=nil end
        pcall(HBCA_HideButton, button)
    end)
    hooksecurefunc("HealBot_Skins_ResetSkin", function(barType, button)
        if barType=="bar" and known[button] then
            pcall(HBCA_Attach,button)
            if HEALBOT_FOREVER then HBCA_RefreshButtonIconOpacity(button) end
        end
    end)
end

-- ---------- slash ----------

-- UI and slash commands share validation, persistence and native-row lifecycle.
function HealBot_CombatAuras_GetOptions()
    return HBCA_Defaults()
end

function HealBot_CombatAuras_SetOption(option, value)
    local g=HBCA_Defaults()
    if not g then return false end
    local key, changed
    local booleans={enabled="CombatAurasOn",persist="CombatAurasPersistDebuffs",
        priest="CombatAurasPriestOnly",skinSize="CombatAurasMatchSkinSize"}
    local numeric={size={"CombatAurasSize",8,40},hots={"CombatAurasHots",0,8},
        debuffs={"CombatAurasDebuffs",0,8},maxdur={"CombatAurasMaxDur",0,3600}}
    if booleans[option] then
        if type(value)~="boolean" then return false end
        key=booleans[option]
    elseif numeric[option] then
        local spec=numeric[option]
        value=tonumber(value)
        if not value or value~=value then return false end
        value=math.floor(math.max(spec[2],math.min(spec[3],value)))
        key=spec[1]
        if option=="size" then
            changed=g.CombatAurasMatchSkinSize
            g.CombatAurasMatchSkinSize=false
        end
    elseif option=="nums" then
        if value~="skin" and value~="on" and value~="off" then return false end
        local follow=value=="skin"
        local numbers=value=="on"
        if follow then numbers=nil end
        changed=g.CombatAurasNumsFollowSkin~=follow or g.CombatAurasNums~=numbers
        g.CombatAurasNumsFollowSkin=follow
        g.CombatAurasNums=numbers
    else
        return false
    end
    if key then
        changed=changed or g[key]~=value
        g[key]=value
    end
    if changed then
        if option=="enabled" and not value then HBCA_SetAllShown(false)
        else HBCA_DropAll() end
        if option=="persist" and HealBot_Forever_UpdateDebuffOverlay then
            for button in pairs(known) do HealBot_Forever_UpdateDebuffOverlay(button) end
        end
    end
    if HealBot_Options_NativeAuras_Refresh then HealBot_Options_NativeAuras_Refresh() end
    return true
end

SLASH_HBCOMBATAURAS1="/hbca"
SlashCmdList["HBCOMBATAURAS"]=function(msg)
    local g=HBCA_Defaults()
    if not g then return end
    msg=string.lower(msg or "")
    local cmd, arg=string.match(msg, "^(%S*)%s*(%S*)")
    local function say(t) print("|cff00ff88HealBot CombatAuras:|r "..t) end
    if cmd=="on" then
        HealBot_CombatAuras_SetOption("enabled",true)
        say(HEALBOT_FOREVER and "on - buffs and debuffs in combat" or "on - icons appear in combat")
    elseif cmd=="priest" and (arg=="on" or arg=="off") then
        HealBot_CombatAuras_SetOption("priest",arg=="on")
        say("priest spell filter "..arg.." (rebuilds out of combat)")
    elseif cmd=="ws" and HEALBOT_FOREVER and (arg=="native" or arg=="off") then
        if InCombatLockdown() then
            say("change Weakened Soul mode outside combat")
            return
        end
        HealBot_Forever_SetWeakenedSoulNativeEnabled(arg=="native")
        say("native Weakened Soul: "..(HBCA_WeakenedSoulMode(g) or "off"))
    elseif cmd=="off" then
        HealBot_CombatAuras_SetOption("enabled",false)
        say("off")
    elseif cmd=="persist" and (arg=="on" or arg=="off") then
        HealBot_CombatAuras_SetOption("persist",arg=="on")
        say("debuffs outside combat "..arg)
    elseif cmd=="size" and arg=="skin" then
        HealBot_CombatAuras_SetOption("skinSize",true)
        say("icon size follows the skin (rebuilds out of combat)")
    elseif cmd=="size" and tonumber(arg) then
        HealBot_CombatAuras_SetOption("size",arg)
        say("icon size "..g.CombatAurasSize.." (rebuilds out of combat)")
    elseif cmd=="hots" and tonumber(arg) then
        HealBot_CombatAuras_SetOption("hots",arg)
        say("max HoT icons "..g.CombatAurasHots.." (rebuilds out of combat)")
    elseif cmd=="debuffs" and tonumber(arg) then
        HealBot_CombatAuras_SetOption("debuffs",arg)
        say("max debuff icons "..g.CombatAurasDebuffs.." (rebuilds out of combat)")
    elseif cmd=="nums" then
        if arg~="skin" and arg~="on" and arg~="off" then arg=g.CombatAurasNums and "off" or "on" end
        HealBot_CombatAuras_SetOption("nums",arg)
        say("countdown numbers "..(g.CombatAurasNums==nil and "skin" or (g.CombatAurasNums and "on" or "off")).." (rebuilds out of combat)")
    elseif cmd=="rt" then
        -- diagnostic: what does the raid-marker chain see for each bar?
        local function scan(t, label)
            if type(t)~="table" then return end
            for _,b in pairs(t) do
                if type(b)=="table" and b.unit and b.frame then
                    local idx=GetRaidTargetIndex(b.unit)
                    local idxTxt=HealBot_issecretvalue(idx) and "SECRET" or tostring(idx)
                    local show="?"
                    if type(hbv_Skins_GetFrameBoolean)=="function" then
                        show=tostring(hbv_Skins_GetFrameBoolean("RaidIcon", "SHOW", b.frame))
                    end
                    say(label.." unit="..tostring(b.unit).." frame="..tostring(b.frame)
                        .." status="..tostring(b.status and b.status.current)
                        .." marker="..idxTxt.." iconShow="..show)
                end
            end
        end
        scan(HealBot_Unit_Button, "player")
        scan(HealBot_Private_Button, "npc")
    elseif cmd=="range" then
        -- diagnostic: what do the range APIs return for each bar right now?
        local function sv(v)
            if HealBot_issecretvalue(v) then return "SECRET" end
            return tostring(v)
        end
        local spell="?"
        if type(HealBot_Range_Spell)=="function" then spell=HealBot_Range_Spell("HEAL") or "?" end
        say("rangespell="..tostring(spell).."  incombat="..tostring(InCombatLockdown()))
        local function scan(t, label)
            if type(t)~="table" then return end
            for _,b in pairs(t) do
                if type(b)=="table" and b.unit and b.frame then
                    local okU, ir, cr=pcall(UnitInRange, b.unit)
                    if not okU then ir, cr="ERR","ERR" end
                    local sr="n/a"
                    if C_Spell and C_Spell.IsSpellInRange then
                        local okS, r=pcall(C_Spell.IsSpellInRange, spell, b.unit)
                        sr=okS and r or "ERR"
                    end
                    local okV, vis=pcall(UnitIsVisible, b.unit)
                    if not okV then vis="ERR" end
                    say(label.." "..tostring(b.unit).." cur="..sv(b.range and b.range.current)
                        .." UnitInRange="..sv(ir)..","..sv(cr).." SpellInRange="..sv(sr)
                        .." vis="..sv(vis).." phase="..sv(b.range and b.range.inphase)
                        .." eventIn="..sv(b.range and b.range.eventIn))
                end
            end
        end
        scan(HealBot_Unit_Button, "player")
        scan(HealBot_Private_Button, "npc")
    elseif cmd=="maxdur" and tonumber(arg) then
        HealBot_CombatAuras_SetOption("maxdur",arg)
        say("HoT row hides buffs longer than "..g.CombatAurasMaxDur.."s (0 = show all; rebuilds out of combat)")
    else
        local n, hots, debuffs, testRows, activeTestRows=0,0,0,0,0
        for button, row in pairs(attached) do
            n=n+1
            if row.hot then hots=hots+1 end
            if row.db then debuffs=debuffs+1 end
            if row.weakenedSoul then testRows=testRows+1 end
            if button.hbcaNativeDebuffs then activeTestRows=activeTestRows+1 end
        end
        say((g.CombatAurasOn and "on" or "off").."  size="..(g.CombatAurasSize or 12)
            .."  hots="..(g.CombatAurasHots or 4).."  debuffs="..(g.CombatAurasDebuffs or 3)
            .."  maxdur="..g.CombatAurasMaxDur.."s"
            .."  nums="..tostring(g.CombatAurasNums).."  bars="..n
            .."  native rows="..hots.."/"..debuffs.."  supported="..tostring(supported))
        if lastError then say("last native aura error: "..lastError) end
        say("size mode: "..(g.CombatAurasMatchSkinSize and "skin" or "manual"))
        if HEALBOT_FOREVER then
            say("Weakened Soul indicator: "..(HBCA_WeakenedSoulMode(g) or "off")
                .."  monitored="..tostring(HBCA_WeakenedSoulWanted())
                .."  native slots="..testRows.."  active="..activeTestRows.."  /hbca ws native|off")
        end
        say("usage: /hbca on|off | persist on|off | size skin|N | hots N | debuffs N | maxdur N | nums skin|on|off | ws native|off")
    end
end
