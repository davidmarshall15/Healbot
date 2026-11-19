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
-- The native debuff row is combat-only.
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
local priestBuffIDs={}
for _, id in ipairs({
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
}) do priestBuffIDs[id]=true end

-- Route rank and group variants with their corresponding entry in Custom Buffs.
local buffFamily={}
for base, ranks in pairs({
    [1243]={1244,1245,2791,10937,10938,21562,21564,25389,25392},
    [588]={7128,602,1006,10951,10952},
    [139]={6074,6075,6076,6077,6078,10927,10928,10929,25315},
    [17]={592,600,3747,6065,6066,10898,10899,10900,10901},
}) do
    for _, id in ipairs(ranks) do buffFamily[id]=base end
end

local buffStart={1,9,11}
local buffEnd={8,10,12}
local buffFilters, buffSignature
local function HBCA_PriestFilters(g)
    if not HEALBOT_FOREVER then return end
    local _, class=UnitClass("player")
    if class~="PRIEST" then return end
    local sets=g.CustomBuffsIconSet or {}
    local include={{},{},{}}
    local moved, signature={},{}
    local excluded={}
    for id in pairs(priestBuffIDs) do
        local set=sets[HealBot_BuffIconSetKey(id)] or sets[buffFamily[id]] or 1
        if set~=2 and set~=3 then set=1 end
        include[set][id]=true
        if set>1 then
            moved[id]=true
            signature[#signature+1]=id..":"..set
        end
    end
    -- Share the legacy renderer's ID/name and zone exclusion rules.
    local candidates={}
    for id in pairs(priestBuffIDs) do candidates[id]=true end
    for id in pairs(g.IgnoreCustomBuff or {}) do
        if type(id)=="number" then candidates[id]=true end
    end
    for id in pairs(candidates) do
        if HealBot_Aura_CustomBuffDisabled(id, HealBot_WoWAPI_SpellName(id)) then
            excluded[id]=true
            signature[#signature+1]="disabled:"..id
        end
    end
    table.sort(signature)
    local key=tostring(g.CombatAurasPriestOnly~=false)..":"..table.concat(signature,",")
    if key==buffSignature then return buffFilters, false end
    buffSignature=key
    buffFilters={}
    if g.CombatAurasPriestOnly~=false then
        buffFilters[1]={includeSpellIDs=include[1]}
    elseif next(moved) then
        buffFilters[1]={excludeSpellIDs=moved}
    end
    for set=2,3 do
        if next(include[set]) then buffFilters[set]={includeSpellIDs=include[set]} end
    end
    for set=1,3 do
        buffFilters[set]=buffFilters[set] or (set==1 and {} or nil)
        if buffFilters[set] then
            local omit=buffFilters[set].excludeSpellIDs or {}
            for id in pairs(excluded) do omit[id]=true end
            if next(omit) then buffFilters[set].excludeSpellIDs=omit end
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
    -- Enable countdowns once for existing Forever profiles as well as new ones.
    -- Later changes made with /hbca nums remain saved.
    if HEALBOT_FOREVER and not HealBot_Globals.CombatAurasNumsMigrated then
        HealBot_Globals.CombatAurasNums=true
        HealBot_Globals.CombatAurasNumsMigrated=true
    elseif HealBot_Globals.CombatAurasNums==nil then
        HealBot_Globals.CombatAurasNums=not not HEALBOT_FOREVER
    end
    -- Forever includes long buffs such as Fortitude by default.
    -- Migrate the old default once so later /hbca maxdur changes are kept.
    local defaultMaxDur=HEALBOT_FOREVER and 0 or 120
    if HEALBOT_FOREVER and not HealBot_Globals.CombatAurasDurationMigrated then
        if HealBot_Globals.CombatAurasMaxDur==120 then
            HealBot_Globals.CombatAurasMaxDur=defaultMaxDur
        end
        HealBot_Globals.CombatAurasDurationMigrated=true
    end
    if HealBot_Globals.CombatAurasMaxDur==nil then
        HealBot_Globals.CombatAurasMaxDur=defaultMaxDur
    end
    return HealBot_Globals
end

local function HBCA_Enabled()
    local g=HBCA_Defaults()
    return g and g.CombatAurasOn and HEALBOT_MIDNIGHT
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
                    HealBot_Media_UpdateFont(countdown,placement.font,placement.fontSize,placement.fontOutline,"Aura duration")
                elseif btn.SetDurationText and not btn.hbcaDuration then
                    local duration=btn:CreateFontString(nil,"OVERLAY","GameFontNormal")
                    duration:SetPoint("CENTER",btn,"CENTER")
                    HealBot_Media_UpdateFont(duration,placement.font,placement.fontSize,placement.fontOutline,"Aura duration")
                    local bound=pcall(btn.SetDurationText,btn,duration,{})
                    if bound then
                        btn.hbcaDuration=duration
                        if cd and cd.SetHideCountdownNumbers then cd:SetHideCountdownNumbers(true) end
                    end
                end
            end
            if placement.font and placement.showCount and btn.SetApplicationCount and not btn.hbcaCount then
                local count=btn:CreateFontString(nil,"OVERLAY","GameFontNormal")
                count:SetPoint("BOTTOMRIGHT",btn,"BOTTOMRIGHT",0,0)
                HealBot_Media_UpdateFont(count,placement.font,placement.fontSize,placement.fontOutline,"Aura count")
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
    local icon=button.gref and button.gref.icon and button.gref.icon[hot and buffStart[set] or 51]
    local g=HBCA_Defaults()
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
        local prefix=hot and "BUFF" or "DB"
        layout.font=hbv_Skins_GetIconTextVar(prefix.."FONT",button.frame,set)
        layout.fontSize=hbv_Skins_GetIconTextVar(prefix.."HEIGHT",button.frame,set)
        layout.fontOutline=hbv_Skins_GetIconTextVar(prefix.."OUTLINE",button.frame,set)
        layout.showCount=not not hbv_Skins_GetIconTextBoolean(prefix.."SCNT",button.frame,set)
        layout.showDuration=not not hbv_Skins_GetIconTextBoolean(prefix.."SDUR",button.frame,set)
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
        if key~="dispelTypes" and a[key]~=value then return false end
    end
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
        maxN=placement.limit
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
    local cf=nil
    if side=="hot" and (g.CombatAurasMaxDur or 0)>0 then
        -- native candidate filter: seconds of TOTAL duration; finite cap also
        -- rejects permanent auras (technique per DandersFrames)
        cf={ maxDuration=g.CombatAurasMaxDur }
    end
    if spellFilter then
        cf=cf or {}
        cf.includeDispelTypes=spellFilter.includeDispelTypes
        cf.includeSpellIDs=spellFilter.includeSpellIDs
        cf.excludeSpellIDs=spellFilter.excludeSpellIDs
    end
    local showNumbers=g.CombatAurasNums and placement.showDuration~=false
    local ready, err=pcall(function()
        c:SetUnit(button.unit)
        c:AddAuraGroup("hbca"..side, filter,
            { maxFrameCount=maxN, initializeFrame=HBCA_MakeInit(size, placement, showNumbers),
              layout=HBCA_Layout(size, placement.spacing), candidateFilters=cf })
        c:SetEnabled(true)
    end)
    if not ready then
        c:Hide()
        lastError=tostring(err)
        return nil
    end
    return c
end

-- Reserve rows use the same native icon factory and filters as normal bars.
function HealBot_Forever_SkinArrivalAuras(row, donor)
    if InCombatLockdown() then return end
    if not HBCA_Enabled() then
        for _, item in ipairs(row.arrivalAuras or {}) do item.container:Hide() end
        return
    end
    local plans,key={},{}
    local filters=HBCA_PriestFilters(HBCA_Defaults())
    local starts={1,9,11}
    local cx,cy=donor.gref.Bar:GetCenter()
    if not cx or not cy then return end
    for set=1,3 do
        if set==1 or (filters and filters[set]) then
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
                key[#key+1]=tostring(filters and filters[set])
                local fields={}
                for field,value in pairs(layout) do fields[#fields+1]=field.."="..tostring(value) end
                table.sort(fields)
                key[#key+1]=table.concat(fields,",")
            end
        end
    end
    key=table.concat(key,";")
    if row.arrivalAuraKey==key then return end
    row.arrivalAuraKey=key
    for _, item in ipairs(row.arrivalAuras or {}) do item.container:Hide() end
    row.arrivalAuras={}
    for _,plan in ipairs(plans) do
        local container=HBCA_BuildOne(row,"hot",plan.layout,plan.set,plan.filter)
        if container then row.arrivalAuras[#row.arrivalAuras+1]={container=container} end
    end
end

function HealBot_Forever_UpdateArrivalAuras(row)
    local show=HBCA_Enabled() and UnitExists(row.unit) and UnitIsConnected(row.unit) and HealBot_Forever_BuffsEnabled()
    for _, item in ipairs(row.arrivalAuras or {}) do
        item.container:SetShown(not not show)
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

local function HBCA_HideButton(button)
    local a=attached[button]
    if not a then return end
    if a.hot then pcall(function() a.hot:Hide() end) end
    if a.db then pcall(function() a.db:Hide() end) end
    a.dbShown=false
    if a.weakenedSoul then pcall(a.weakenedSoul.Hide,a.weakenedSoul) end
    a.weakenedSoulShown=false
    HBCA_SetLegacyBuffsShown(button, true)
    for set,row in pairs(a.extra) do
        row:Hide()
        HBCA_SetLegacyBuffsShown(button, true, set)
    end
end

-- Retarget only rows that exist. Reuse native widgets during combat; if the
-- client rejects a unit change, never display auras belonging to the old unit.
local function HBCA_SetButtonShown(button, show)
    local a=attached[button]
    if not a then return end
    local vis=not not (show and HBCA_Enabled() and button.unit and button.frame and button.frame<10 and
                       button.status and button.status.events and (HEALBOT_FOREVER or button:IsShown()))
    if HEALBOT_FOREVER and vis and not UnitIsConnected(button.unit) then vis=false end
    if vis and button.unit~=a.unit then
        local okH=not a.hot or pcall(a.hot.SetUnit, a.hot, button.unit)
        local okD=not a.db or pcall(a.db.SetUnit, a.db, button.unit)
        for _, row in pairs(a.extra) do
            if not pcall(row.SetUnit,row,button.unit) then okH=false end
        end
        local okW=not a.weakenedSoul or pcall(a.weakenedSoul.SetUnit,a.weakenedSoul,button.unit)
        if okH and okD and okW then
            a.unit=button.unit
        else
            vis=false
            deferred[button]=true
        end
    end
    local buffsEnabled=not HEALBOT_FOREVER or HealBot_Forever_BuffsEnabled()
    local hotVisible=not not (vis and buffsEnabled and not a.buffDirty)
    local hotShown=false
    if a.hot then
        local ok=pcall(function()
            a.hot:SetShown(hotVisible)
            if hotVisible and a.hot.UpdateAllAuras then a.hot:UpdateAllAuras() end
        end)
        hotShown=ok and hotVisible
    end
    HBCA_SetLegacyBuffsShown(button, buffsEnabled and not hotShown)
    for set,row in pairs(a.extra) do
        local ok=pcall(function()
            row:SetShown(hotVisible)
            if hotVisible and row.UpdateAllAuras then row:UpdateAllAuras() end
        end)
        HBCA_SetLegacyBuffsShown(button, buffsEnabled and not (ok and hotVisible), set)
    end
    if a.weakenedSoul then
        local showShieldLockout=vis and inCombat
        local ok=pcall(function()
            a.weakenedSoul:SetShown(showShieldLockout)
            if showShieldLockout and not a.weakenedSoulShown and a.weakenedSoul.UpdateAllAuras then
                a.weakenedSoul:UpdateAllAuras()
            end
        end)
        a.weakenedSoulShown=ok and showShieldLockout
    end
    local dbShown=vis and inCombat
    if HEALBOT_FOREVER then
        dbShown=dbShown and not a.dbDirty and HealBot_Forever_DebuffsEnabled()
    end
    dbShown=not not dbShown
    if a.db then
        pcall(function()
            a.db:SetShown(dbShown)
            if dbShown and not a.dbShown and a.db.UpdateAllAuras then a.db:UpdateAllAuras() end
        end)
        a.dbShown=dbShown
    end
end

-- Tear down = hide + forget. Container groups are add-only, so a filter/size
-- change abandons the old container (hidden containers are dormant) and builds
-- a fresh one. Cheap enough at settings-change frequency.
local function HBCA_DropButton(button)
    HBCA_HideButton(button)
    attached[button]=nil
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
    local filters=HBCA_PriestFilters(HBCA_Defaults())
    local a=attached[button]
    local hotLayout, dbLayout=HBCA_SkinLayout(button, "hot"), HBCA_SkinLayout(button, "db")
    if HEALBOT_FOREVER then
        local types, signature=HealBot_Forever_GetDebuffTypes()
        dbLayout.dispelSignature=signature
        dbLayout.dispelTypes=types
    end
    local extraLayouts={}
    for set=2,3 do
        if filters and filters[set] then
            local layout=HBCA_SkinLayout(button,"hot",set)
            layout.limit=hbv_Skins_GetIconVar("MAXBICONS",button.frame,set) or 2
            extraLayouts[set]=layout
        end
    end
    if a then
        local same=a.filters==filters and HBCA_SameLayout(a.hotLayout,hotLayout)
            and HBCA_SameLayout(a.dbLayout,dbLayout)
        for set=2,3 do
            if extraLayouts[set] and not HBCA_SameLayout(a.extraLayouts[set],extraLayouts[set]) then same=false end
        end
        if same then
            a.buffDirty=false
            a.dbDirty=false
            HBCA_SetButtonShown(button, inCombat or HEALBOT_FOREVER)
            return
        end
        HBCA_DropButton(button)
    end
    local hot=HBCA_BuildOne(button,"hot",hotLayout,1,filters and filters[1])
    local db
    if not HEALBOT_FOREVER or dbLayout.dispelSignature~="" then
        local dbFilter=HEALBOT_FOREVER and {includeDispelTypes=dbLayout.dispelTypes,excludeSpellIDs={[6788]=true}} or nil
        db=HBCA_BuildOne(button,"db",dbLayout,1,dbFilter)
    end
    local weakenedSoul
    if HEALBOT_FOREVER then
        local layout={}
        for key,value in pairs(dbLayout) do layout[key]=value end
        local size=layout.size or HBCA_Defaults().CombatAurasSize
        local direction=layout.point:find("BOTTOM",1,true) and -1 or 1
        layout.y=layout.y+direction*(size+layout.spacing)
        layout.double=false
        weakenedSoul=HBCA_BuildOne(button,"weakenedSoul",layout,1,{includeSpellIDs={[6788]=true}})
    end
    a={hot=hot, weakenedSoul=weakenedSoul,
       db=db, extra={}, extraLayouts=extraLayouts,
       hotLayout=hotLayout, dbLayout=dbLayout, filters=filters, unit=button.unit}
    for set,layout in pairs(extraLayouts) do
        a.extra[set]=HBCA_BuildOne(button,"hot",layout,set,filters[set])
    end
    attached[button]=a
    if inCombat or HEALBOT_FOREVER then HBCA_SetButtonShown(button, true) end
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
    for button in pairs(attached) do HBCA_HideButton(button) end
    attached={}
    deferred={}
    -- re-attach everything we have ever seen (builds run now or at next regen)
    for button in pairs(known) do deferred[button]=true end
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
    elseif event=="PLAYER_REGEN_ENABLED" then
        inCombat=false
        HBCA_SetAllShown(HEALBOT_FOREVER)
        HBCA_AttachDeferred()
    elseif event=="PLAYER_LOGIN" then
        if HEALBOT_MIDNIGHT then HBCA_Probe() end
    end
end)

-- Buttons announce their unit binding through these two; hooksecurefunc keeps
-- us clear of HealBot's own call paths.
if type(hooksecurefunc)=="function" then
    if HEALBOT_FOREVER then
        hooksecurefunc("HealBot_SetUnitDisconnectChange", function(button)
            pcall(HBCA_SetButtonShown, button, true)
        end)
        function HealBot_Forever_RefreshBuffExclusions()
            local g=HBCA_Defaults()
            if not g then return end
            local _, changed=HBCA_PriestFilters(g)
            if not changed then return end
            if InCombatLockdown() then
                for button, rows in pairs(attached) do
                    rows.buffDirty=true
                    deferred[button]=true
                    HBCA_SetButtonShown(button, true)
                end
            else
                HBCA_DropAll()
            end
        end
        hooksecurefunc("HealBot_Options_EnableDisableBuffBtn_OnClick", function()
            HealBot_Aura_setCustomBuffFilterDisabled()
        end)
        hooksecurefunc("HealBot_Aura_setLuVars", function(key)
            if key=="mapName" then HealBot_Forever_RefreshBuffExclusions() end
        end)
        hooksecurefunc("HealBot_Aura_SetAuraCheckFlags", function()
            for button in pairs(attached) do pcall(HBCA_SetButtonShown,button,true) end
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
            if key~="BUFFSCNT" and key~="BUFFSDUR" and key~="DBSCNT" and key~="DBSDUR" then return end
            for button in pairs(known) do
                if button.frame==frame then pcall(HBCA_Attach,button) end
            end
        end)
        hooksecurefunc("HealBot_Aura_ConfigClassHoT", function()
            local g=HBCA_Defaults()
            if not g then return end
            local _, changed=HBCA_PriestFilters(g)
            if changed and HBCA_Enabled() then
                if InCombatLockdown() then
                    for button in pairs(known) do deferred[button]=true end
                else
                    HBCA_DropAll()
                end
            end
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

SLASH_HBCOMBATAURAS1="/hbca"
SlashCmdList["HBCOMBATAURAS"]=function(msg)
    local g=HBCA_Defaults()
    if not g then return end
    msg=string.lower(msg or "")
    local cmd, arg=string.match(msg, "^(%S*)%s*(%S*)")
    local function say(t) print("|cff00ff88HealBot CombatAuras:|r "..t) end
    if cmd=="on" then
        g.CombatAurasOn=true
        HBCA_DropAll()
        say(HEALBOT_FOREVER and "on - buffs always visible; debuffs in combat" or "on - icons appear in combat")
    elseif cmd=="priest" and (arg=="on" or arg=="off") then
        g.CombatAurasPriestOnly=arg=="on"
        HBCA_DropAll()
        say("priest spell filter "..arg.." (rebuilds out of combat)")
    elseif cmd=="off" then
        g.CombatAurasOn=false
        HBCA_SetAllShown(false)
        say("off")
    elseif cmd=="size" and arg=="skin" then
        g.CombatAurasMatchSkinSize=true
        HBCA_DropAll()
        say("icon size follows the skin (rebuilds out of combat)")
    elseif cmd=="size" and tonumber(arg) then
        g.CombatAurasMatchSkinSize=false
        g.CombatAurasSize=math.max(8, math.min(40, tonumber(arg)))
        HBCA_DropAll()
        say("icon size "..g.CombatAurasSize.." (rebuilds out of combat)")
    elseif cmd=="hots" and tonumber(arg) then
        g.CombatAurasHots=math.max(0, math.min(8, tonumber(arg)))
        HBCA_DropAll()
        say("max HoT icons "..g.CombatAurasHots.." (rebuilds out of combat)")
    elseif cmd=="debuffs" and tonumber(arg) then
        g.CombatAurasDebuffs=math.max(0, math.min(8, tonumber(arg)))
        HBCA_DropAll()
        say("max debuff icons "..g.CombatAurasDebuffs.." (rebuilds out of combat)")
    elseif cmd=="nums" then
        g.CombatAurasNums=not g.CombatAurasNums
        HBCA_DropAll()
        say("countdown numbers "..(g.CombatAurasNums and "on" or "off").." (rebuilds out of combat)")
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
        g.CombatAurasMaxDur=math.max(0, math.min(3600, tonumber(arg)))
        HBCA_DropAll()
        say("HoT row hides buffs longer than "..g.CombatAurasMaxDur.."s (0 = show all; rebuilds out of combat)")
    else
        local n, hots, debuffs=0,0,0
        for _, row in pairs(attached) do
            n=n+1
            if row.hot then hots=hots+1 end
            if row.db then debuffs=debuffs+1 end
        end
        say((g.CombatAurasOn and "on" or "off").."  size="..(g.CombatAurasSize or 12)
            .."  hots="..(g.CombatAurasHots or 4).."  debuffs="..(g.CombatAurasDebuffs or 3)
            .."  maxdur="..g.CombatAurasMaxDur.."s"
            .."  nums="..tostring(g.CombatAurasNums).."  bars="..n
            .."  native rows="..hots.."/"..debuffs.."  supported="..tostring(supported))
        if lastError then say("last native aura error: "..lastError) end
        say("size mode: "..(g.CombatAurasMatchSkinSize and "skin" or "manual"))
        say("usage: /hbca on|off | size skin|N | hots N | debuffs N | maxdur N | nums")
    end
end
