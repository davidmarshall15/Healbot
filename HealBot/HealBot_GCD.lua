-- Optional global cooldown sweep over each bar, toggled with /hb gcd.

local GCD_SPELL=61304
local sweeps={}
local gcdStart, gcdDuration, gcdEnd=0, 0, 0
local lastSource="none yet"
local lastCastGUID

local function IsEnabled()
    return HealBot_Globals and HealBot_Globals.ShowGCDSweep
end

-- HealBot re-layers its bars on skin resets, so keep the sweep above the health bar each time it starts
local function Relevel(cd)
    cd:SetFrameLevel(cd.hbBar:GetFrameLevel()+2)
end

local function ClearAll()
    for _, cd in pairs(sweeps) do cd:Clear() end
end

local function StartAll(start, duration)
    for _, cd in pairs(sweeps) do
        Relevel(cd)
        cd:SetCooldown(start, duration)
    end
end

-- Every bar HealBot has set up, so switching the sweep on reaches bars that already exist
local bars={}

local function Attach(button)
    if not button.gref or not button.gref["Bar"] or button.frame>=10 then return end
    bars[button]=true
    if not IsEnabled() or sweeps[button] then return end
    local bar=button.gref["Bar"]
    local cd=CreateFrame("Cooldown", nil, bar, "CooldownFrameTemplate")
    cd:SetAllPoints(bar)
    cd:EnableMouse(false)
    if cd.SetMouseClickEnabled then cd:SetMouseClickEnabled(false) end
    if cd.SetMouseMotionEnabled then cd:SetMouseMotionEnabled(false) end
    cd:SetDrawEdge(false)
    cd:SetDrawBling(false)
    cd:SetHideCountdownNumbers(true)
    cd:SetSwipeColor(0, 0, 0, 0.6)
    cd.hbBar=bar
    -- Above the health bar, below the bar text
    Relevel(cd)
    sweeps[button]=cd
    if GetTime()<gcdEnd then cd:SetCooldown(gcdStart, gcdDuration) end
end

local function AttachAll()
    for button in pairs(bars) do Attach(button) end
end

local function ReadCooldown(spellID)
    if C_Spell and C_Spell.GetSpellCooldown then
        local info=C_Spell.GetSpellCooldown(spellID)
        if info then return info.startTime, info.duration end
    elseif GetSpellCooldown then
        return GetSpellCooldown(spellID)
    end
end

local function IsSecret(start, duration)
    return HealBot_issecretvalue(start) or HealBot_issecretvalue(duration)
end

local function Running(start, duration)
    return start and duration and not IsSecret(start, duration) and duration>0
end

local function SpellHaste()
    local haste=UnitSpellHaste and UnitSpellHaste("player")
    if haste and not HealBot_issecretvalue(haste) then return haste end
end

-- Last resort when the client hides or doesn't report the GCD
local function EstimateGCD()
    local haste=SpellHaste()
    if haste and haste>0 then
        return math.max(1.5/(1+haste/100), 0.75), format("estimate from %.0f%% haste", haste)
    end
    return 1.5, "estimate 1.5s"
end

local function Show(start, duration, source)
    gcdStart, gcdDuration, gcdEnd=start, duration, start+duration
    lastSource=source..format(" %.2fs", duration)
    StartAll(start, duration)
end

local function OnCast(castGUID, spellID)
    -- A cast-time spell fires START then SUCCEEDED; its GCD began at START
    if castGUID and castGUID==lastCastGUID then return end
    lastCastGUID=castGUID
    AttachAll()
    local ok, start, duration=pcall(ReadCooldown, GCD_SPELL)
    if ok and Running(start, duration) then return Show(start, duration, "game GCD") end
    local hidden=ok and IsSecret(start, duration)
    if spellID then
        -- The spell just cast reports the GCD lockout as its cooldown
        local ok2, s2, d2=pcall(ReadCooldown, spellID)
        if ok2 and Running(s2, d2) and d2<=1.5 then return Show(s2, d2, "spell lockout") end
    end
    if hidden then
        -- The cooldown frame can show values Lua isn't allowed to read
        local shown=pcall(StartAll, start, duration)
        if shown then
            gcdEnd=0
            lastSource="game GCD (hidden value)"
            return
        end
    end
    local estimate, source=EstimateGCD()
    Show(GetTime(), estimate, source)
end

-- The client's GCD can arrive after the cast event; prefer it over an estimate
local function OnCooldownUpdate()
    local ok, start, duration=pcall(ReadCooldown, GCD_SPELL)
    if ok and Running(start, duration) and (start~=gcdStart or duration~=gcdDuration) then
        Show(start, duration, "game GCD")
    end
end

function HealBot_GCD_Toggle(arg)
    if arg=="test" then
        -- Force a 5 second sweep on every bar to check it can be seen
        if not IsEnabled() then HealBot_Globals.ShowGCDSweep=true end
        AttachAll()
        local count=0
        for _ in pairs(sweeps) do count=count+1 end
        StartAll(GetTime(), 5)
        local haste=SpellHaste()
        HealBot_AddChat("GCD test sweep (5 sec) on "..count.." bars - last GCD: "..lastSource..
            ", spell haste: "..(haste and format("%.1f%%", haste) or "unreadable"))
        return
    end
    HealBot_Globals.ShowGCDSweep=not HealBot_Globals.ShowGCDSweep
    if IsEnabled() then AttachAll() else ClearAll() end
    local count=0
    for _ in pairs(sweeps) do count=count+1 end
    HealBot_AddChat("GCD sweep "..(IsEnabled() and "on" or "off").." - bars: "..count..", last GCD: "..lastSource)
end

-- Bars are attached as HealBot sets them up or refreshes them
hooksecurefunc("HealBot_Action_RegisterUnitEvents", Attach)
hooksecurefunc("HealBot_Action_UpdateHealthButton", Attach)

local events=CreateFrame("Frame")
events:RegisterEvent("SPELL_UPDATE_COOLDOWN")
events:RegisterUnitEvent("UNIT_SPELLCAST_START", "player")
events:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "player")
events:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_START", "player")
events:SetScript("OnEvent", function(_, event, _, castGUID, spellID)
    if not IsEnabled() then return end
    if event=="SPELL_UPDATE_COOLDOWN" then
        OnCooldownUpdate()
    else
        if HealBot_issecretvalue(castGUID) then castGUID=nil end
        if HealBot_issecretvalue(spellID) then spellID=nil end
        pcall(OnCast, castGUID, spellID)
    end
end)
