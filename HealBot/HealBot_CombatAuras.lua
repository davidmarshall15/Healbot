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
local function HBCA_ConfiguredBuffFilters(g)
    if not HEALBOT_FOREVER then return end
    local _, class=UnitClass("player")
    local broad=class~="PRIEST" and g.CombatAurasPriestOnly==true
    local sets=g.CustomBuffsIconSet or {}
    local methods=g.CustomBuffIDMethod or {}
    local effective=type(HealBot_Watch_HoT)=="table" and HealBot_Watch_HoT or {}
    local candidates,names,registrations={},{},{}
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
        local name=PublicCall(HealBot_WoWAPI_SpellName,id)
        if not HBCA_BuffName(name) then
            local cache=HealBot_AuraBuffCache and HealBot_AuraBuffCache[id]
            if HBCA_PublicBuffValue(cache) and type(cache)=="table" and HBCA_BuffName(cache.name) then name=cache.name end
        end
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
    for id in pairs(HealBot_AuraBuffCache or {}) do AddCandidate(id) end
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
    for _,registration in ipairs(registrations) do
        if registration.id and not exact[registration.id] then exact[registration.id]=registration end
        if registration.method~=1 then
            if registration.name and not families[registration.name] then families[registration.name]=registration end
            local family=registration.id and Family(registration.id)
            if family and not variants[family] then variants[family]=registration end
        end
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
            local caster=HBCA_BuffSetting(effective,name) or HBCA_BuffSetting(effective,id)
            if caster~="S" and caster~="C" and caster~="A" then
                caster=PublicCall(HealBot_Aura_CustomBuffCaster,id,name)
            end
            if caster~="S" and caster~="C" and caster~="A" then caster=registration.caster end
            local set=FirstSetting(sets,Canonical(id),id) or registration.route or HBCA_BuffSetting(sets,name) or 1
            if set~=2 and set~=3 then set=1 end
            include[set][id]=true
            if caster=="A" then everyoneIDs[set][id]=true else selfIDs[set][id]=true end
            signature[#signature+1]=id..":"..set..":"..caster
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
    local key=table.concat(signature,",")
    if key==buffSignature then return buffFilters, false end
    buffSignature=key
    buffFilters={}
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

local function HBCA_WeakenedSoulWanted()
    local g=HBCA_Defaults()
    if not g or not g.CombatAurasNativeWeakenedSoul then return false end
    local choice
    if type(HealBot_Aura_GetDebuffIconPreference)=="function" then
        choice=HealBot_Aura_GetDebuffIconPreference(weakenedSoulSpellID,true)
    end
    return choice==true or (choice~=false and HealBot_Forever_WatchesWeakenedSoul())
end

local function HBCA_DebuffExclusions()
    local excluded={ [weakenedSoulSpellID]=true }
    if type(HealBot_Aura_GetHiddenDebuffIcons)=="function" then
        for spellID, hidden in pairs(HealBot_Aura_GetHiddenDebuffIcons(true) or {}) do
            if type(spellID)=="number" and hidden then excluded[spellID]=true end
        end
    end
    local ids={}
    for spellID in pairs(excluded) do ids[#ids+1]=spellID end
    table.sort(ids)
    return excluded, table.concat(ids,",")
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
    local point=isCount and "TOPLEFT" or "BOTTOMRIGHT"
    local fontLimit=math.max(1,math.floor(size*(isCount and 0.45 or 0.40)))
    local fontSize=math.min(placement.fontSize or 9,fontLimit)
    text:ClearAllPoints()
    text:SetPoint(point,icon,point,0,0)
    text:SetWidth(size)
    text:SetJustifyH(isCount and "LEFT" or "RIGHT")
    text:SetWordWrap(false)
    HealBot_Media_UpdateFont(text,placement.font,fontSize,placement.fontOutline,"Combat aura text")
end

-- Style one Blizzard-created button: click-through (clicks must reach the heal
-- bar beneath), our own icon Texture + Cooldown, bound via the native inbound
-- setters so Blizzard paints the secret aura into them.
local function HBCA_MakeInit(size, placement, showNumbers)
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

            if placement.font and showNumbers then
                local cd=btn.hbcaCD
                local countdown=cd and cd.GetCountdownFontString and cd:GetCountdownFontString()
                if countdown then
                    pcall(HBCA_StyleAuraText,countdown,btn,size,placement,false)
                elseif btn.SetDurationText and not btn.hbcaDuration then
                    local duration=btn:CreateFontString(nil,"OVERLAY","GameFontNormal")
                    HBCA_StyleAuraText(duration,btn,size,placement,false)
                    local bound=pcall(btn.SetDurationText,btn,duration,{})
                    if bound then
                        btn.hbcaDuration=duration
                        if cd and cd.SetHideCountdownNumbers then cd:SetHideCountdownNumbers(true) end
                    end
                end
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

local function HBCA_Layout(size, spacing)
    return { elementWidth=size, elementHeight=size,
             elementSpacing=spacing, lineSpacing=spacing, groupSpacing=0,   -- 68914+
             elementSpacingX=spacing, elementSpacingY=spacing, gapX=0 }     -- pre-68914 twins
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
        -- The first native row must obey the same icon limit as its skin,
        -- including zero. Extra buff sets already use their own limits.
        layout.limit=hbv_Skins_GetIconVar(hot and "MAXBICONS" or "MAXDICONS",button.frame,set)
        local prefix=hot and "BUFF" or "DB"
        layout.font=hbv_Skins_GetIconTextVar(prefix.."FONT",button.frame,set)
        layout.fontSize=hbv_Skins_GetIconTextVar(prefix.."HEIGHT",button.frame,set)
        layout.fontOutline=hbv_Skins_GetIconTextVar(prefix.."OUTLINE",button.frame,set)
        layout.showCount=not not hbv_Skins_GetIconTextBoolean(prefix.."SCNT",button.frame,set)
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
        occupied=hbv_Skins_GetIconVar("MAXDICONS",button.frame,1) or 0
        if dbLayout.dispelSignature~="" then occupied=math.max(occupied,g.CombatAurasDebuffs) end
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

local function HBCA_BuffRowPolicy(spellFilter, g, limit)
    local own=HBCA_CopyFilter(spellFilter and spellFilter.selfSpellFilter
        or spellFilter or {includeSpellIDs={}})
    local everyone=HBCA_CopyFilter(spellFilter and spellFilter.everyoneSpellFilter
        or {includeSpellIDs={}})
    -- These are addon settings, not aura identities/counts from native widgets.
    own.selfSpellFilter,own.everyoneSpellFilter,own.casterSignature=nil,nil,nil
    local duration=(g.CombatAurasMaxDur or 0)>0 and g.CombatAurasMaxDur or nil
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
    local own,everyone,ownLimit,everyoneLimit,wanted=HBCA_BuffRowPolicy(spellFilter,g,row.hbcaBuffLimit)
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
    if not ok then lastError=tostring(err); return false end
    row.hbcaHasBuffs=wanted
    return true
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
        return nil
    end
    c:Hide()
    pcall(function()
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
                c:SetFlowLayoutMaximumLineSize(size*2+placement.spacing)
            end
        end
    end)
    pcall(function()
        c:SetFrameLevel((button:GetFrameLevel() or 1)+25)
        if c.SetMouseClickEnabled then pcall(c.SetMouseClickEnabled, c, false) end
        if c.SetMouseMotionEnabled then pcall(c.SetMouseMotionEnabled, c, false) end
    end)
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
    local showNumbers=placement.numbers
    local initializeFrame=HBCA_MakeInit(size, placement, showNumbers)
    local ready, err=pcall(function()
        c:SetUnit(button.unit)
        if side=="hot" and HEALBOT_FOREVER then
            assert(type(c.SetAuraGroupCandidateFilters)=="function" and
                type(c.SetAuraGroupMaxFrameCount)=="function","native buff filter updates unavailable")
            local own,everyone,ownLimit,everyoneLimit,wanted=HBCA_BuffRowPolicy(spellFilter,g,maxN)
            c:AddAuraGroup(helpfulGroup,"HELPFUL|PLAYER",
                {maxFrameCount=ownLimit, initializeFrame=initializeFrame,
                 layout=HBCA_Layout(size,placement.spacing),candidateFilters=own})
            local everyonePlacement={}
            for key,value in pairs(placement) do everyonePlacement[key]=value end
            -- An Everyone row can show other casters; never paint a fixed Self marker.
            everyonePlacement.markerTexture=nil
            c:AddAuraGroup(everyoneGroup,"HELPFUL",
                {maxFrameCount=everyoneLimit,initializeFrame=HBCA_MakeInit(size,everyonePlacement,showNumbers),
                 layout=HBCA_Layout(size,placement.spacing),candidateFilters=everyone})
            c.hbcaBuffLimit,c.hbcaHasBuffs=maxN,wanted
        else
            c:AddAuraGroup("hbca"..side, filter,
                { maxFrameCount=maxN, initializeFrame=initializeFrame,
                  layout=HBCA_Layout(size, placement.spacing), candidateFilters=cf })
        end
        c:SetEnabled(true)
    end)
    if not ready then
        c:Hide()
        lastError=tostring(err)
        return nil
    end
    return c
end

local function HBCA_BuildWeakenedSoulSlot(button, layout)
    local g=HBCA_Defaults()
    local size=layout.size or g.CombatAurasSize
    local initialize=HBCA_MakeInit(size,layout,layout.numbers)
    local container
    local ok, err=pcall(function()
        container=CreateFrame("AuraContainer",nil,button,"CustomAuraContainerTemplate")
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
                auraButton:SetPoint("CENTER",container,"CENTER")
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
function HealBot_Forever_SkinArrivalAuras(row, donor)
    arrivalDonors[row]=donor
    if InCombatLockdown() then return end
    if not HBCA_Enabled() then
        for _, item in ipairs(row.arrivalAuras or {}) do item.container:Hide() end
        return
    end
    local plans,key={},{}
    local filters=HBCA_ConfiguredBuffFilters(HBCA_Defaults())
    local starts={1,9,11}
    local cx,cy=donor.gref.Bar:GetCenter()
    if not cx or not cy then return end
    key[#key+1]="hots:"..tostring(HBCA_Defaults().CombatAurasHots)
    for set=1,3 do
        if HEALBOT_FOREVER or (not filters and set==1) or (filters and filters[set]) then
            local source=donor.gref.icon[starts[set]]
            local x,y=source:GetCenter()
            if x and y then
                local layout=HBCA_SkinLayout(donor,"hot",set)
                local point=layout.point
                local dx=point:find("RIGHT") and source:GetWidth()/2 or (point:find("LEFT") and -source:GetWidth()/2 or 0)
                local dy=point:find("TOP") and source:GetHeight()/2 or (point:find("BOTTOM") and -source:GetHeight()/2 or 0)
                layout.relative=row.healthBar
                layout.relativePoint="CENTER"
                layout.x,layout.y=x-cx+dx,y-cy+dy
                layout.limit=hbv_Skins_GetIconVar("MAXBICONS",row.frame,set)
                plans[#plans+1]={layout=layout,set=set,filter=filters and filters[set]}
                local fields={}
                for field,value in pairs(layout) do fields[#fields+1]=field.."="..tostring(value) end
                table.sort(fields)
                key[#key+1]=table.concat(fields,",")
            end
        end
    end
    key=table.concat(key,";")
    if row.arrivalAuraKey==key then
        for _,item in ipairs(row.arrivalAuras or {}) do
            if HEALBOT_FOREVER then HBCA_UpdateBuffRow(item.container,filters and filters[item.set],HBCA_Defaults()) end
        end
        return
    end
    row.arrivalAuraKey=key
    for _, item in ipairs(row.arrivalAuras or {}) do item.container:Hide() end
    row.arrivalAuras={}
    for _,plan in ipairs(plans) do
        local container=HBCA_BuildOne(row,"hot",plan.layout,plan.set,plan.filter)
        if container then row.arrivalAuras[#row.arrivalAuras+1]={container=container,set=plan.set} end
    end
end

function HealBot_Forever_UpdateArrivalAuras(row)
    local show=HBCA_Enabled() and UnitExists(row.unit) and UnitIsConnected(row.unit) and HealBot_Forever_BuffsEnabled()
    for _, item in ipairs(row.arrivalAuras or {}) do
        item.container:SetShown(not not (show and item.container.hbcaHasBuffs~=false))
    end
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

-- Both anchors are configured out of combat. Only visibility changes in combat.
local function HBCA_ShowDebuffRow(a, reserve)
    local row
    if a.dbShown then row=(reserve and a.dbAfterShield) or a.db end
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

local function HBCA_RefreshShieldLockout(button)
    local a=attached[button]
    local icon=a and a.shieldLockout
    if not a then return end
    if HBCA_SetNativeSlotShown(button,a,a.shieldLockoutVisible and a.unit==button.unit
            and InCombatLockdown() and HBCA_WeakenedSoulWanted()) then
        HBCA_ShowDebuffRow(a,false)
        if icon then icon:Hide() end
        return
    end
    if not icon then return end
    local start,duration
    if a.shieldLockoutVisible and a.unit==button.unit and InCombatLockdown()
        and HealBot_Aura_GetDebuffIconPreference(6788,true)~=false then
        start,duration=HealBot_Forever_GetShieldLockout(button)
    end
    local set=start and HealBot_Aura_GetTrackedDebuffIconSet(button,6788)
    local slots=set and hbv_Skins_GetIconVar("MAXDICONS",button.frame,set)
    if not slots or slots<1 then
        HBCA_ShowDebuffRow(a,false)
        icon:Hide()
        return
    end
    HBCA_ShowDebuffRow(a,set==1)
    local debuffs=button.icon and button.icon.debuff
    if set==1 and a.dbAfterShield then
        slots=0
    elseif set==1 and a.db then
        slots=HBCA_Defaults().CombatAurasDebuffs or 3
    else
        slots=debuffs and debuffs.count and debuffs.count[set] or 0
    end
    local layout=HBCA_SkinLayout(button,"db",set)
    layout.slots=slots
    local g=HBCA_Defaults()
    if not HBCA_SameLayout(icon.layout,layout) then
        local size=layout.size or g.CombatAurasSize or 12
        local stride=size+layout.spacing
        local xDirection=layout.point:find("RIGHT",1,true) and -1 or 1
        local yDirection=layout.point:find("BOTTOM",1,true) and 1 or -1
        local column=layout.double and math.floor(slots/2) or slots
        local line=layout.double and slots%2 or 0
        icon:SetSize(size,size)
        icon:ClearAllPoints()
        icon:SetPoint(layout.point,layout.relative,layout.relativePoint,
                      layout.x+column*stride*xDirection,layout.y+line*stride*yDirection)
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

local function HBCA_SetButtonShown(button, show)
    local a=attached[button]
    if not a then return end
    local vis=not not ((show or HBCA_Defaults().CombatAurasPersistDebuffs) and HBCA_Enabled() and button.unit and button.frame and button.frame<10 and
                       button.status and button.status.events and (HEALBOT_FOREVER or button:IsShown()))
    if HEALBOT_FOREVER and vis and not UnitIsConnected(button.unit) then vis=false end
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
    local hotVisible=not not (vis and buffsEnabled and not a.buffDirty and (not HEALBOT_FOREVER or inCombat))
    local hotShown=a.hot and HBCA_SetBuffRowShown(a.hot,hotVisible and a.hot.hbcaHasBuffs~=false,retargeted)
    HBCA_SetLegacyBuffsShown(button, buffsEnabled and not hotShown)
    for set,row in pairs(a.extra) do
        local rowShown=HBCA_SetBuffRowShown(row,hotVisible and row.hbcaHasBuffs~=false,retargeted)
        HBCA_SetLegacyBuffsShown(button,buffsEnabled and not rowShown,set)
    end
    local dbShown=vis and (not HealBot_Aura_DebuffsEnabled or HealBot_Aura_DebuffsEnabled()) and (inCombat or HBCA_Defaults().CombatAurasPersistDebuffs)
    if HEALBOT_FOREVER then
        -- Outside combat the legacy icons apply the separate rest preferences.
        dbShown=dbShown and inCombat and not a.dbDirty and HealBot_Forever_DebuffsEnabled()
    end
    dbShown=not not dbShown
    a.dbShown=dbShown
    a.shieldLockoutVisible=dbShown
    if a.shieldLockout or a.weakenedSoul then
        HBCA_RefreshShieldLockout(button)
    else
        HBCA_ShowDebuffRow(a,false)
    end
    HBCA_SetNativeDebuffs(button, not HEALBOT_FOREVER and a.visibleDebuffRow~=nil
        and HBCA_Defaults().CombatAurasPersistDebuffs)
end

-- Tear down = hide + forget. Container groups are add-only, so a filter/size
-- change abandons the old container (hidden containers are dormant) and builds
-- a fresh one. Cheap enough at settings-change frequency.
local function HBCA_DropButton(button)
    HBCA_HideButton(button)
    attached[button]=nil
    button.foreverShieldLockoutIcon=nil
end

local function HBCA_UpdateButtonBuffRows(button, rows, filters)
    local complete=true
    for set=1,3 do
        local row=set==1 and rows.hot or rows.extra[set]
        if row then
            if not HBCA_UpdateBuffRow(row,filters and filters[set],HBCA_Defaults()) then complete=false end
        elseif (set==1 and (rows.hotLayout.limit or 0)>0 and HBCA_Defaults().CombatAurasHots>0)
            or (set>1 and rows.extraLayouts[set] and (rows.extraLayouts[set].limit or 0)>0) then
            complete=false
        end
    end
    if complete then rows.filters=filters end
    -- A pending structural rebuild must not hide other usable prepared rows.
    rows.buffDirty=false
    if not complete then deferred[button]=true end
    return complete
end

local function HBCA_Attach(button)
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
    local filters=HBCA_ConfiguredBuffFilters(g)
    local a=attached[button]
    local hotLayout, dbLayout=HBCA_SkinLayout(button, "hot"), HBCA_SkinLayout(button, "db")
    local weakenedSoulLayout
    if HEALBOT_FOREVER then
        local types, signature=HealBot_Forever_GetDebuffTypes()
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
            if HEALBOT_FOREVER then HBCA_UpdateButtonBuffRows(button,a,filters) end
            a.buffDirty=false
            a.dbDirty=false
            HBCA_SetButtonShown(button, inCombat or HEALBOT_FOREVER)
            return
        end
        HBCA_DropButton(button)
    end
    local hot
    if HEALBOT_FOREVER or not filters or filters[1] then
        hot=HBCA_BuildOne(button,"hot",hotLayout,1,filters and filters[1])
    end
    local db,dbAfterShield
    if not HEALBOT_FOREVER or dbLayout.dispelSignature~="" then
        local dbFilter=HEALBOT_FOREVER and {includeDispelTypes=dbLayout.dispelTypes,excludeSpellIDs=dbLayout.excludedSpellIDs} or nil
        db=HBCA_BuildOne(button,"db",dbLayout,1,dbFilter)
        if db and HEALBOT_FOREVER and HealBot_Forever_GetShieldLockout and select(2,UnitClass("player"))=="PRIEST" then
            local shifted={}
            for key,value in pairs(dbLayout) do shifted[key]=value end
            local size=shifted.size or HBCA_Defaults().CombatAurasSize or 12
            local direction=shifted.point:find("RIGHT",1,true) and -1 or 1
            shifted.x=shifted.x+(size+shifted.spacing)*direction
            dbAfterShield=HBCA_BuildOne(button,"db",shifted,1,dbFilter)
        end
    end
    local slot=weakenedSoulLayout and HBCA_BuildWeakenedSoulSlot(button,weakenedSoulLayout)
    a={hot=hot, weakenedSoul=slot, weakenedSoulUnit=button.unit, weakenedSoulLayout=weakenedSoulLayout,
       db=db, dbAfterShield=dbAfterShield, extra={}, extraLayouts=extraLayouts,
       hotLayout=hotLayout, dbLayout=dbLayout, filters=filters, unit=button.unit}
    for set,layout in pairs(extraLayouts) do
        a.extra[set]=HBCA_BuildOne(button,"hot",layout,set,filters and filters[set])
    end
    if HEALBOT_FOREVER and HealBot_Forever_GetShieldLockout then
        a.shieldLockout=HBCA_CreateShieldLockout(button)
        button.foreverShieldLockoutIcon=a.shieldLockout
    end
    attached[button]=a
    HBCA_SetButtonShown(button, inCombat or HEALBOT_FOREVER)
end

local function HBCA_AttachDeferred()
    if InCombatLockdown() then return end
    for button in pairs(deferred) do
        deferred[button]=nil
        HBCA_Attach(button)
    end
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
    HBCA_AttachDeferred()
    if not InCombatLockdown() then
        for row,donor in pairs(arrivalDonors) do
            HealBot_Forever_SkinArrivalAuras(row,donor)
            HealBot_Forever_UpdateArrivalAuras(row)
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
        if rows.filters~=filters then
            if canUpdate then HBCA_UpdateButtonBuffRows(button,rows,filters)
            else deferred[button]=true end
        end
        HBCA_SetButtonShown(button,true)
    end
    if canUpdate then
        for row,donor in pairs(arrivalDonors) do
            if not combat then HealBot_Forever_SkinArrivalAuras(row,donor) end
            for _,item in ipairs(row.arrivalAuras or {}) do
                if item.set then HBCA_UpdateBuffRow(item.container,filters and filters[item.set],g) end
            end
            HealBot_Forever_UpdateArrivalAuras(row)
        end
    end
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
    if not HEALBOT_FOREVER or not HBCA_Enabled() then return end
    local _, signature=HBCA_DebuffExclusions()
    for button, rows in pairs(attached) do
        if rows.dbLayout.exclusionSignature~=signature then deferred[button]=true end
    end
    HBCA_SetAllShown(true)
    HBCA_AttachDeferred()
end

-- ---------- wiring ----------

local ev=CreateFrame("Frame")
ev:RegisterEvent("PLAYER_LOGIN")
ev:RegisterEvent("PLAYER_REGEN_DISABLED")
ev:RegisterEvent("PLAYER_REGEN_ENABLED")
ev:SetScript("OnEvent", function(_, event)
    if event=="PLAYER_REGEN_DISABLED" then
        inCombat=true
        if HBCA_Enabled() then HBCA_SetAllShown(true) end
        if HEALBOT_FOREVER and HealBot_Aura_RefreshDebuffIconVisibility then
            HealBot_Aura_RefreshDebuffIconVisibility()
        end
    elseif event=="PLAYER_REGEN_ENABLED" then
        inCombat=false
        HBCA_SetAllShown(HEALBOT_FOREVER)
        HBCA_AttachDeferred()
        if HEALBOT_FOREVER and HealBot_Aura_RefreshDebuffIconVisibility then
            HealBot_Aura_RefreshDebuffIconVisibility()
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
        hooksecurefunc("HealBot_Aura_CheckUnitDebuffs",HBCA_RefreshShieldLockout)
        hooksecurefunc("HealBot_SetUnitDisconnectChange", function(button)
            pcall(HBCA_SetButtonShown, button, true)
        end)
        function HealBot_Forever_RefreshBuffExclusions()
            HBCA_RefreshBuffRows()
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
        hooksecurefunc("HealBot_Options_setDebuffPriority",HealBot_Forever_RefreshDebuffIconPreferences)
        hooksecurefunc("HealBot_Aura_ConfigDebuffs",function()
            local g=HBCA_Defaults()
            if not g or not g.CombatAurasNativeWeakenedSoul then return end
            for button in pairs(attached) do pcall(HBCA_Attach,button) end
        end)
        hooksecurefunc("HealBot_Aura_SetAuraCheckFlags", function()
            HBCA_RefreshBuffRows()
        end)
        hooksecurefunc("HealBot_Options_Debuff_Reset", function()
            local _, signature=HealBot_Forever_GetDebuffTypes()
            for button, rows in pairs(attached) do
                if rows.dbLayout.dispelSignature~=signature then
                    rows.dbDirty=true
                    pcall(HBCA_Attach,button)
                end
            end
        end)
        hooksecurefunc("hbv_Skins_SetIconTextVar", function(_, key, frame)
            if key~="BUFFSCNT" and key~="BUFFSDUR" and key~="DBSCNT" and key~="DBSDUR"
                and key~="BUFFFONT" and key~="BUFFHEIGHT" and key~="BUFFOUTLINE"
                and key~="DBFONT" and key~="DBHEIGHT" and key~="DBOUTLINE" then return end
            for button in pairs(known) do
                if button.frame==frame then pcall(HBCA_Attach,button) end
            end
        end)
        hooksecurefunc("hbv_Skins_SetIconVar", function(_, key, frame)
            if key~="MAXBICONS" and key~="MAXDICONS" then return end
            for button in pairs(known) do
                if button.frame==frame then pcall(HBCA_Attach,button) end
            end
        end)
        hooksecurefunc("HealBot_Aura_ConfigClassHoT", function()
            HBCA_RefreshBuffRows()
        end)
    end
    hooksecurefunc("HealBot_Action_RegisterUnitEvents", function(button)
        pcall(HBCA_Attach, button)
    end)
    hooksecurefunc("HealBot_Action_UnregisterUnitEvents", function(button)
        pcall(HBCA_HideButton, button)
    end)
    hooksecurefunc("HealBot_Skins_ResetSkin", function(barType, button)
        if barType=="bar" and known[button] then pcall(HBCA_Attach, button) end
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
