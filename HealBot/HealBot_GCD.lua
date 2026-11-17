-- Optional global cooldown sweep over each bar, toggled with /hb gcd.

local GCD_SPELL=61304
local sweeps={}
local gcdStart, gcdDuration=0, 0
local gcdSecret=false

local function IsEnabled()
    return HealBot_Globals and HealBot_Globals.ShowGCDSweep
end

-- Secret values can't be compared, so a secret GCD is always passed through to the sweep
local function GCDRunning()
    return gcdSecret or gcdDuration>0
end

local function ApplyAll()
    for _, cd in pairs(sweeps) do
        if IsEnabled() and GCDRunning() then
            pcall(cd.SetCooldown, cd, gcdStart, gcdDuration)
        else
            cd:Clear()
        end
    end
end

local function Attach(button)
    if not IsEnabled() or sweeps[button] or not button.gref or not button.gref["Bar"] or button.frame>=10 then return end
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
    -- Above the health bar, below the bar text
    cd:SetFrameLevel(bar:GetFrameLevel()+2)
    sweeps[button]=cd
    if GCDRunning() then pcall(cd.SetCooldown, cd, gcdStart, gcdDuration) end
end

local function ReadGCD()
    if C_Spell and C_Spell.GetSpellCooldown then
        local info=C_Spell.GetSpellCooldown(GCD_SPELL)
        if info then return info.startTime, info.duration end
    elseif GetSpellCooldown then
        return GetSpellCooldown(GCD_SPELL)
    end
    return 0, 0
end

local function UpdateGCD()
    if not IsEnabled() then return end
    local ok, start, duration=pcall(ReadGCD)
    if not ok then return end
    if HealBot_issecretvalue(start) or HealBot_issecretvalue(duration) then
        gcdStart, gcdDuration, gcdSecret=start, duration, true
        ApplyAll()
        return
    end
    start, duration=start or 0, duration or 0
    if not gcdSecret and start==gcdStart and duration==gcdDuration then return end
    gcdSecret=false
    gcdStart, gcdDuration=start, duration
    ApplyAll()
end

function HealBot_GCD_Toggle()
    HealBot_Globals.ShowGCDSweep=not HealBot_Globals.ShowGCDSweep
    if IsEnabled() then
        UpdateGCD()
    else
        ApplyAll()
    end
    HealBot_AddChat("GCD sweep "..(IsEnabled() and "on" or "off"))
end

-- Bars are attached as HealBot sets them up or refreshes them
hooksecurefunc("HealBot_Action_RegisterUnitEvents", Attach)
hooksecurefunc("HealBot_Action_UpdateHealthButton", Attach)

local events=CreateFrame("Frame")
events:RegisterEvent("SPELL_UPDATE_COOLDOWN")
events:SetScript("OnEvent", UpdateGCD)
