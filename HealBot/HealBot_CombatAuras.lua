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
--   * HoTs you cast   filter "HELPFUL|PLAYER"  right side, grows left
--   * Debuffs         filter "HARMFUL"         left side, grows right
-- Rows are HIDDEN out of combat (HealBot's own icon engine still works there)
-- and SHOWN in combat, where HealBot's engine is blind.
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

local supported=nil          -- nil = not probed yet
local attached={}            -- [button] = { hot=container, db=container, unit=unit }
local deferred={}            -- [button] = true, build queued until out of combat
local known={}               -- every button ever handed to us; survives DropAll so
                             -- settings changes and /hbca on can re-attach them all
local inCombat=InCombatLockdown() or false

local function HBCA_Defaults()
    if type(HealBot_Globals)~="table" then return nil end
    if HealBot_Globals.CombatAurasOn==nil       then HealBot_Globals.CombatAurasOn=true end
    if HealBot_Globals.CombatAurasSize==nil     then HealBot_Globals.CombatAurasSize=12 end
    if HealBot_Globals.CombatAurasHots==nil     then HealBot_Globals.CombatAurasHots=4 end
    if HealBot_Globals.CombatAurasDebuffs==nil  then HealBot_Globals.CombatAurasDebuffs=3 end
    if HealBot_Globals.CombatAurasNums==nil     then HealBot_Globals.CombatAurasNums=false end
    -- HoT row: hide buffs whose TOTAL duration exceeds this (seconds); also hides
    -- permanent auras. Keeps hour-long raid buffs off the bars. 0 = show all.
    if HealBot_Globals.CombatAurasMaxDur==nil   then HealBot_Globals.CombatAurasMaxDur=120 end
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
local function HBCA_MakeInit(size)
    return function(btn)
        pcall(function()
            if not btn then return end
            if btn.SetMouseClickEnabled then btn:SetMouseClickEnabled(false) end
            if btn.SetMouseMotionEnabled then btn:SetMouseMotionEnabled(false) end
            btn:SetSize(size, size)
            if not btn.hbcaIcon then
                local t=btn:CreateTexture(nil, "ARTWORK")
                t:SetAllPoints(btn)
                t:SetTexCoord(0.08, 0.92, 0.08, 0.92)
                btn.hbcaIcon=t
                local cd=CreateFrame("Cooldown", nil, btn, "CooldownFrameTemplate")
                cd:SetAllPoints(btn)
                cd:SetReverse(true)
                cd:SetDrawEdge(false)
                btn.hbcaCD=cd
            end
            local g=HBCA_Defaults()
            if btn.hbcaCD and btn.hbcaCD.SetHideCountdownNumbers then
                btn.hbcaCD:SetHideCountdownNumbers(not (g and g.CombatAurasNums))
            end
            if btn.SetIcon and not btn.hbcaBoundIcon then
                btn.hbcaBoundIcon=true
                btn:SetIcon(btn.hbcaIcon)
            end
            if btn.SetDurationCooldown and not btn.hbcaBoundCD then
                btn.hbcaBoundCD=true
                btn:SetDurationCooldown(btn.hbcaCD)
            end
        end)
    end
end

local function HBCA_Layout(size)
    return { elementWidth=size, elementHeight=size,
             elementSpacing=1, lineSpacing=1, groupSpacing=0,   -- 68914+
             elementSpacingX=1, elementSpacingY=1, gapX=0 }     -- pre-68914 twins
end

-- Build one container on a HealBot button. side="hot" (right, grows left) or
-- "db" (left, grows right). Out-of-combat only; caller gates.
local function HBCA_BuildOne(button, side)
    local g=HBCA_Defaults()
    if not g then return nil end
    local size=g.CombatAurasSize or 16
    local filter=(side=="hot") and "HELPFUL|PLAYER" or "HARMFUL"
    local maxN=(side=="hot") and (g.CombatAurasHots or 4) or (g.CombatAurasDebuffs or 3)
    if maxN<1 then return nil end
    local ok, c=pcall(CreateFrame, "AuraContainer", nil, button, "CustomAuraContainerTemplate")
    if not ok or not c then return nil end
    pcall(function()
        c:ClearAllPoints()
        -- Grow INWARD from the bar edge, single line, never wrap (no
        -- SetFlowLayoutMaximumLineSize call: nil = no-wrap). Growth direction
        -- names resolve against AnchorUtil.FlowDirection (per DandersFrames).
        local growH
        if side=="hot" then
            c:SetPoint("RIGHT", button, "RIGHT", -1, 0)
            if c.SetFlowLayoutAnchorPoint then pcall(c.SetFlowLayoutAnchorPoint, c, "TOPRIGHT") end
            growH="Left"
        else
            c:SetPoint("LEFT", button, "LEFT", 1, 0)
            if c.SetFlowLayoutAnchorPoint then pcall(c.SetFlowLayoutAnchorPoint, c, "TOPLEFT") end
            growH="Right"
        end
        if c.SetFlowLayoutGrowthDirection and AnchorUtil and AnchorUtil.FlowDirection then
            local h, v=AnchorUtil.FlowDirection[growH], AnchorUtil.FlowDirection["Down"]
            if h~=nil and v~=nil then pcall(c.SetFlowLayoutGrowthDirection, c, h, v) end
        end
        c:SetFrameLevel((button:GetFrameLevel() or 1)+25)
        if c.SetMouseClickEnabled then pcall(c.SetMouseClickEnabled, c, false) end
        if c.SetMouseMotionEnabled then pcall(c.SetMouseMotionEnabled, c, false) end
    end)
    local okU=pcall(function() c:SetUnit(button.unit) end)
    if not okU then pcall(function() c:Hide() end) return nil end
    local cf=nil
    if side=="hot" and (g.CombatAurasMaxDur or 0)>0 then
        -- native candidate filter: seconds of TOTAL duration; finite cap also
        -- rejects permanent auras (technique per DandersFrames)
        cf={ maxDuration=g.CombatAurasMaxDur }
    end
    local okG=pcall(function()
        c:AddAuraGroup("hbca"..side, filter,
            { maxFrameCount=maxN, initializeFrame=HBCA_MakeInit(size), layout=HBCA_Layout(size),
              candidateFilters=cf })
    end)
    if not okG then pcall(function() c:Hide() end) return nil end
    pcall(function() c:SetEnabled(true) end)   -- LAST - gates aura-event registration
    c:SetShown(inCombat)
    if inCombat then pcall(function() if c.UpdateAllAuras then c:UpdateAllAuras() end end) end
    return c
end

local function HBCA_HideButton(button)
    local a=attached[button]
    if not a then return end
    if a.hot then pcall(function() a.hot:Hide() end) end
    if a.db then pcall(function() a.db:Hide() end) end
end

-- Tear down = hide + forget. Container groups are add-only, so a filter/size
-- change abandons the old container (hidden containers are dormant) and builds
-- a fresh one. Cheap enough at settings-change frequency.
local function HBCA_DropButton(button)
    HBCA_HideButton(button)
    attached[button]=nil
end

local function HBCA_Attach(button)
    if not button or not button.unit or not button.frame or button.frame>=10 then return end
    known[button]=true
    if not HBCA_Enabled() then return end
    if InCombatLockdown() or not HBCA_Probe() then
        if supported~=false then deferred[button]=true end
        return
    end
    deferred[button]=nil
    local a=attached[button]
    if a and a.unit==button.unit then return end
    if a then
        -- unit retarget on standing containers
        local okH=a.hot and pcall(function() a.hot:SetUnit(button.unit) end)
        local okD=a.db and pcall(function() a.db:SetUnit(button.unit) end)
        if okH~=false and okD~=false then
            a.unit=button.unit
            return
        end
        HBCA_DropButton(button)
    end
    attached[button]={ hot=HBCA_BuildOne(button, "hot"), db=HBCA_BuildOne(button, "db"), unit=button.unit }
end

local function HBCA_AttachDeferred()
    if InCombatLockdown() then return end
    for button in pairs(deferred) do
        deferred[button]=nil
        HBCA_Attach(button)
    end
end

local function HBCA_SetAllShown(show)
    for button, a in pairs(attached) do
        -- resync unit before revealing; a mismatch we cannot fix stays hidden
        local mismatch=false
        if show and button.unit~=a.unit then
            if pcall(function() a.hot:SetUnit(button.unit); a.db:SetUnit(button.unit) end) then
                a.unit=button.unit
            else
                mismatch=true
            end
        end
        local vis=show and not mismatch and HBCA_Enabled() and button:IsShown()
        if a.hot then pcall(function() a.hot:SetShown(vis); if vis and a.hot.UpdateAllAuras then a.hot:UpdateAllAuras() end end) end
        if a.db then pcall(function() a.db:SetShown(vis); if vis and a.db.UpdateAllAuras then a.db:UpdateAllAuras() end end) end
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
        HBCA_SetAllShown(false)
        HBCA_AttachDeferred()
    elseif event=="PLAYER_LOGIN" then
        if HEALBOT_MIDNIGHT then HBCA_Probe() end
    end
end)

-- Buttons announce their unit binding through these two; hooksecurefunc keeps
-- us clear of HealBot's own call paths.
if type(hooksecurefunc)=="function" then
    hooksecurefunc("HealBot_Action_RegisterUnitEvents", function(button)
        pcall(HBCA_Attach, button)
    end)
    hooksecurefunc("HealBot_Action_UnregisterUnitEvents", function(button)
        pcall(HBCA_HideButton, button)
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
        say("on - icons appear in combat (Blizzard-driven; HoTs right, debuffs left)")
    elseif cmd=="off" then
        g.CombatAurasOn=false
        HBCA_SetAllShown(false)
        say("off")
    elseif cmd=="size" and tonumber(arg) then
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
        local n=0
        for _ in pairs(attached) do n=n+1 end
        say((g.CombatAurasOn and "on" or "off").."  size="..(g.CombatAurasSize or 12)
            .."  hots="..(g.CombatAurasHots or 4).."  debuffs="..(g.CombatAurasDebuffs or 3)
            .."  maxdur="..(g.CombatAurasMaxDur or 120).."s"
            .."  nums="..tostring(g.CombatAurasNums).."  bars="..n
            .."  supported="..tostring(supported))
        say("usage: /hbca on|off | size N | hots N | debuffs N | maxdur N | nums")
    end
end
