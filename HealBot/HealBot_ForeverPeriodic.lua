if not HEALBOT_FOREVER then return end
local _, class=UnitClass("player")
if class~="PRIEST" then return end

local buttons={}
local casts={}
local renews={}
local shieldCasts={}
local shieldLockouts={}
local shieldRanks={[17]=true,[592]=true,[600]=true,[3747]=true,[6065]=true,
    [6066]=true,[10898]=true,[10899]=true,[10900]=true,[10901]=true,[25217]=true,[25218]=true}
local lockoutDuration=15
local mendingByUnit={}
local mendingAmount, mendingUntil
local mendingBase={[401859]=172,[1240826]=298,[1240827]=413}
local mendingAuras={[401863]=true,[401877]=true,[41635]=true}
local channel, pendingPenance
local channelStarts=0
local clickedButton, clickedAt
local secret=HealBot_issecretvalue
local enabled=false
local installed=false
local sent, detected, drawn=0,0,0
local detail="waiting for a cast"
local renewBase={[139]=45,[6074]=75,[6075]=125,[6076]=160,[6077]=205,[6078]=270,
    [10927]=370,[10928]=510,[10929]=670,[25315]=830}
local penanceBase={[402174]=134,[1240720]=200,[1240721]=268,[1316995]=425}
-- Forever uses separate spell records for the cast and its channel.
local penanceChannel={[402261]=true,[402277]=true,[1240732]=true,[1240734]=true,
    [1240733]=true,[1240736]=true,[1316992]=true,[1316994]=true}

local function Disable()
    enabled=false
    for button in pairs(buttons) do
        if button.foreverPeriodic then button.foreverPeriodic:Hide() end
    end
    wipe(casts)
    wipe(renews)
    wipe(shieldCasts)
    wipe(shieldLockouts)
    wipe(mendingByUnit)
    mendingAmount,mendingUntil=nil,nil
    channel=nil
    pendingPenance=nil
    clickedButton=nil
end

local function Safe(callback,...)
    if not enabled then return end
    local ok, err=pcall(callback,...)
    if not ok then
        Disable()
        print("HealBot Penance/Renew disabled: "..tostring(err))
    end
end

local function PublicString(value)
    return not secret(value) and type(value)=="string" and value~=""
end

local function UnitIdentity(button)
    local unit=button.unit
    local guid=UnitGUID(unit)
    if PublicString(guid) then return guid end
    if PublicString(button.guid) and button.guid~="nil" then return button.guid end
    local name, realm=UnitFullName(unit)
    if PublicString(name) and not secret(realm) then
        return "name:"..name.."-"..(realm or "")
    end
    if unit=="player" or unit:match("^party%d+$") or unit:match("^raid%d+$") then
        return "unit:"..unit
    end
end

local function MatchesName(button, name)
    local short, realm=UnitFullName(button.unit)
    if PublicString(short) then
        if short==name or (PublicString(realm) and short.."-"..realm==name) then return true end
    end
    return PublicString(button.name) and button.name==name
end

local function ResolveTarget(name)
    local click=clickedButton
    if click and (not buttons[click] or GetTime()-clickedAt>0.5) then click=nil end
    if PublicString(name) then
        local unit=HealBot_Panel_RaidUnitName(name)
        if not unit then unit=HealBot_Panel_RaidUnitName(name:match("^[^-]+") or name) end
        local guid
        for button in pairs(buttons) do
            if button.unit==unit or MatchesName(button,name) then
                local candidate=UnitIdentity(button)
                if not candidate or (guid and candidate~=guid) then
                    return click and MatchesName(click,name) and UnitIdentity(click) or nil
                end
                guid=candidate
            end
        end
        if guid then return guid end
    end
    if click then return UnitIdentity(click) end
end

local function Estimate(spellID)
    local name=C_Spell.GetSpellName(spellID)
    local readableName=PublicString(name)
    local isRenew=renewBase[spellID] or (readableName and name==C_Spell.GetSpellName(139))
    local isPenance=penanceBase[spellID] or (readableName and name==C_Spell.GetSpellName(402174))
    if not isRenew and not isPenance then return end
    local description=C_Spell.GetSpellDescription(spellID)
    if not PublicString(description) then description="" end
    if isRenew then
        local total, duration=description:match("([%d,]+) damage over (%d+) sec")
        if not total then
            total, duration=description:match("([%d%s]+) points de vie en (%d+)")
        end
        if total then
            duration=tonumber(duration)
            local ticks=math.floor(duration/3)
            if ticks>0 then return "renew", tonumber((total:gsub("%D","")))/ticks, ticks end
        end
        if renewBase[spellID] then return "renew",renewBase[spellID]/5,5 end
    else
        local tick=description:match("([%d,]+) healing to an ally")
            or description:match("([%d%s]+) points de vie à un allié")
        if tick then return "penance", tonumber((tick:gsub("%D",""))), 2 end
        if penanceBase[spellID] then return "penance",penanceBase[spellID],2 end
    end
end

local function Remaining(effect, now, interval, horizon)
    if not effect then return 0 end
    local passed=math.max(0,math.floor((now-effect.start)/interval+0.001))
    local within=math.floor((now-effect.start+horizon)/interval+0.001)
    return math.max(0,math.min(effect.ticks,within)-passed)*effect.amount
end

local function Update(button)
    if not enabled then return end
    local periodic=button.foreverPeriodic
    local guid=button.status.events and button.status.enabled and button.frame<10
        and button.status.current<HealBot_Unit_Status.DEAD and UnitIdentity(button)
    local amount=0
    if guid and hbv_Skins_GetFrameVar("BarIACol","IC",button.frame)>1 then
        local now=GetTime()
        amount=Remaining(renews[guid],now,3,6)
        if mendingAmount and now<mendingUntil and mendingByUnit[button.unit] then
            amount=amount+mendingAmount
        end
        if channel and channel.target==guid then amount=amount+Remaining(channel,now,1,2) end
    end
    if amount<=0 then
        if periodic then periodic:Hide() end
        return
    end

    local health=button.gref.Bar
    if not periodic then
        -- Clip estimates at full health and place them under native incoming heals.
        local clip=CreateFrame("Frame",nil,button)
        clip:SetAllPoints(health)
        clip:SetClipsChildren(true)
        clip:SetFrameLevel(math.max(0,button.gref.InHeal:GetFrameLevel()-1))
        periodic=CreateFrame("StatusBar",nil,clip)
        periodic:EnableMouse(false)
        button.foreverPeriodic=periodic
    end
    local texture=health:GetStatusBarTexture()
    local vertical=health:GetOrientation()=="VERTICAL"
    local reverse=health:GetReverseFill()
    periodic:ClearAllPoints()
    periodic:SetSize(health:GetWidth(),health:GetHeight())
    periodic:SetOrientation(health:GetOrientation())
    periodic:SetReverseFill(reverse)
    if vertical and reverse then periodic:SetPoint("TOPLEFT",texture,"BOTTOMLEFT")
    elseif vertical then periodic:SetPoint("BOTTOMLEFT",texture,"TOPLEFT")
    elseif reverse then periodic:SetPoint("TOPRIGHT",texture,"TOPLEFT")
    else periodic:SetPoint("TOPLEFT",texture,"TOPRIGHT") end
    periodic:SetFrameLevel(periodic:GetParent():GetFrameLevel())
    HealBot_Media_UpdateTexture(periodic,hbv_Skins_GetFrameVar("HealBar","TEXTURE",button.frame),"Forever periodic heals")
    periodic:GetStatusBarTexture():SetHorizTile(false)
    periodic:SetMinMaxValues(0,UnitHealthMax(button.unit))
    periodic:SetValue(amount)
    local alpha=hbv_Skins_GetFrameVar("BarIACol","IA",button.frame)*button.status.alpha
    if button.range.current<=0 then alpha=alpha/3 end
    -- Use the RGB selected by HealBot's incoming-heal renderer for this bar.
    local r,g,b=button.health.inhealr,button.health.inhealg,button.health.inhealb
    periodic:SetStatusBarColor(r,g,b,HealBot_Action_BarColourAlpha(button,alpha,2))
    periodic:Show()
    drawn=drawn+1
    detail="rendered "..math.floor(amount+0.5).." estimated healing"
end

local function Refresh(guid)
    for button in pairs(buttons) do
        if UnitIdentity(button)==guid then Safe(Update,button) end
    end
end

local function Schedule(effect, interval, isRenew)
    for tick=1,effect.ticks do
        C_Timer.After(tick*interval+0.02,function()
            if isRenew then
                if renews[effect.target]~=effect then return end
            elseif channel~=effect then
                return
            end
            if tick==effect.ticks then
                if isRenew then renews[effect.target]=nil else channel=nil end
            end
            Refresh(effect.target)
        end)
    end
    Refresh(effect.target)
end

local function EndChannel(castGUID)
    if channel and channel.castGUID==castGUID then
        local target=channel.target
        channel=nil
        Refresh(target)
    end
end

local function RefreshMendingUnit(unit)
    if not mendingAmount or not C_UnitAuras or not C_UnitAuras.GetAuraDataByIndex then return end
    local index=1
    local hasMending=false
    local spellName=C_Spell.GetSpellName(401859)
    while GetTime()<mendingUntil do
        local ok,aura=pcall(C_UnitAuras.GetAuraDataByIndex,unit,index,"HELPFUL|PLAYER")
        if not ok or secret(aura) or not aura then break end
        local id, name=aura.spellId,aura.name
        if (not secret(id) and (mendingAuras[id] or mendingBase[id]))
            or (PublicString(spellName) and PublicString(name) and spellName==name) then
            hasMending=true
            break
        end
        index=index+1
    end
    if hasMending==not not mendingByUnit[unit] then return end
    mendingByUnit[unit]=hasMending or nil
    for button in pairs(buttons) do
        if button.unit==unit then Safe(Update,button) end
    end
end

local function StartMending(spellID)
    local bonus=GetSpellBonusHealing and GetSpellBonusHealing()
    if secret(bonus) or type(bonus)~="number" then bonus=0 end
    mendingAmount=mendingBase[spellID]+bonus*0.429
    mendingUntil=GetTime()+180
    local scanned={}
    for button in pairs(buttons) do
        if not scanned[button.unit] then
            scanned[button.unit]=true
            RefreshMendingUnit(button.unit)
        end
        if mendingByUnit[button.unit] then Safe(Update,button) end
    end
end

local function ShieldSpell(spellID)
    if secret(spellID) or type(spellID)~="number" then return false end
    if shieldRanks[spellID] then return true end
    local name=C_Spell.GetSpellName(spellID)
    local shieldName=C_Spell.GetSpellName(17)
    return PublicString(name) and PublicString(shieldName) and name==shieldName
end

function HealBot_Forever_GetShieldLockout(button)
    local start=shieldLockouts[UnitIdentity(button)]
    if start and GetTime()<start+lockoutDuration then return start,lockoutDuration end
end

local function RefreshShieldLockouts(target)
    for button in pairs(buttons) do
        if button.event and UnitIdentity(button)==target then HealBot_Events_UnitDebuff(button) end
    end
end

local function TrackShieldCast(event,first,second,third)
    if event=="UNIT_SPELLCAST_SENT" and ShieldSpell(third) then
        if PublicString(second) then
            local identity=ResolveTarget(first)
            if identity then
                local cast={target=identity}
                shieldCasts[second]=cast
                C_Timer.After(5,function() if shieldCasts[second]==cast then shieldCasts[second]=nil end end)
            end
        end
        clickedButton=nil
        return true
    end
    if not PublicString(first) then return false end
    local cast=shieldCasts[first]
    if not cast then return false end
    if event=="UNIT_SPELLCAST_SUCCEEDED" then
        shieldCasts[first]=nil
        if ShieldSpell(second) then
            local start=GetTime()
            shieldLockouts[cast.target]=start
            RefreshShieldLockouts(cast.target)
            C_Timer.After(lockoutDuration,function()
                if shieldLockouts[cast.target]==start then
                    shieldLockouts[cast.target]=nil
                    RefreshShieldLockouts(cast.target)
                end
            end)
        end
        return true
    elseif event=="UNIT_SPELLCAST_FAILED" or event=="UNIT_SPELLCAST_INTERRUPTED" then
        shieldCasts[first]=nil
        return true
    end
    return false
end

local function OnEvent(_,event,_,first,second,third)
    if TrackShieldCast(event,first,second,third) then return end
    if event=="UNIT_SPELLCAST_SUCCEEDED" and not secret(second) and mendingBase[second] then
        StartMending(second)
        return
    end
    if event=="UNIT_SPELLCAST_SENT" then
        pendingPenance=nil
        local target, castGUID, spellID=first,second,third
        sent=sent+1
        if not PublicString(castGUID) or secret(spellID) or type(spellID)~="number" then
            detail="spell or cast ID unavailable"
            return
        end
        local kind, amount, ticks=Estimate(spellID)
        if not kind or not amount then
            detail="no estimate for spell "..spellID
            return
        end
        detected=detected+1
        local guid=ResolveTarget(target)
        clickedButton=nil
        if not guid then
            detail=kind..": could not identify target"
            return
        end
        detail=kind..": waiting for confirmation"
        local cast={kind=kind,amount=amount,ticks=ticks,target=guid,castGUID=castGUID}
        casts[castGUID]=cast
        if kind=="penance" then
            cast.sentAt=GetTime()
            pendingPenance=cast
        end
        C_Timer.After(5,function() if casts[castGUID]==cast then casts[castGUID]=nil end end)
        return
    end
    local castGUID=PublicString(first) and first or nil
    local cast=castGUID and casts[castGUID]
    if event=="UNIT_SPELLCAST_CHANNEL_START" then
        channelStarts=channelStarts+1
        local spellID=second
        if not cast and pendingPenance and GetTime()-pendingPenance.sentAt<=1.5
            and not secret(spellID) and type(spellID)=="number" and (penanceChannel[spellID] or Estimate(spellID)=="penance") then
            cast=pendingPenance
        end
        if not cast or cast.kind~="penance" then
            if pendingPenance then detail="Penance channel could not be matched to its cast" end
            return
        end
        pendingPenance=nil
        casts[cast.castGUID]=nil
        if channel then EndChannel(channel.castGUID) end
        detail="penance confirmed; waiting for a visible heal bar"
        cast.castGUID=castGUID
        cast.start=GetTime()
        channel=cast
        Schedule(cast,1,false)
    elseif event=="UNIT_SPELLCAST_CHANNEL_STOP" then
        if channel then EndChannel(channel.castGUID) end
    elseif not castGUID then
        return
    elseif event=="UNIT_SPELLCAST_SUCCEEDED" and cast and cast.kind=="renew" then
        casts[castGUID]=nil
        detail="renew confirmed; waiting for a visible heal bar"
        cast.start=GetTime()
        renews[cast.target]=cast
        Schedule(cast,3,true)
    elseif event=="UNIT_SPELLCAST_INTERRUPTED" or event=="UNIT_SPELLCAST_FAILED" then
        if pendingPenance==cast then pendingPenance=nil end
        casts[castGUID]=nil
        EndChannel(castGUID)
    end
end

local function Install()
    local events=CreateFrame("Frame")
    events:RegisterEvent("UNIT_SPELLCAST_SENT")
    for _, event in ipairs({"UNIT_SPELLCAST_SUCCEEDED","UNIT_SPELLCAST_CHANNEL_START",
        "UNIT_SPELLCAST_CHANNEL_STOP","UNIT_SPELLCAST_INTERRUPTED","UNIT_SPELLCAST_FAILED"}) do
        events:RegisterUnitEvent(event,"player")
    end
    events:RegisterEvent("GROUP_ROSTER_UPDATE")
    events:RegisterEvent("UNIT_AURA")
    events:SetScript("OnEvent",function(_,event,unit,...)
        if event=="UNIT_AURA" then
            if enabled and mendingAmount and not secret(unit) then
                for button in pairs(buttons) do
                    if button.unit==unit then Safe(RefreshMendingUnit,unit); break end
                end
            end
            return
        end
        if event=="GROUP_ROSTER_UPDATE" then
            for target in pairs(shieldLockouts) do
                if target:match("^unit:") then
                    shieldLockouts[target]=nil
                    RefreshShieldLockouts(target)
                end
            end
            for id,cast in pairs(shieldCasts) do
                if cast.target:match("^unit:") then shieldCasts[id]=nil end
            end
            for unit in pairs(mendingByUnit) do Safe(RefreshMendingUnit,unit) end
            for target in pairs(renews) do
                if target:match("^unit:") then renews[target]=nil; Refresh(target) end
            end
            for id, cast in pairs(casts) do
                if cast.target:match("^unit:") then casts[id]=nil end
            end
            if pendingPenance and pendingPenance.target:match("^unit:") then pendingPenance=nil end
            if channel and channel.target:match("^unit:") then EndChannel(channel.castGUID) end
            return
        end
        if not secret(unit) and unit=="player" then Safe(OnEvent,nil,event,unit,...) end
    end)

    hooksecurefunc("HealBot_Action_ButtonPreClick",function(_,_,button)
        if enabled and button and button.frame and button.frame<10 and button.status.events then
            buttons[button]=true
            clickedButton,clickedAt=button,GetTime()
        end
    end)
    hooksecurefunc("HealBot_Action_RegisterUnitEvents",function(button)
        if button.frame<10 then buttons[button]=true end
    end)
    hooksecurefunc("HealBot_Action_UnregisterUnitEvents",function(button)
        buttons[button]=nil
        if button.foreverPeriodic then button.foreverPeriodic:Hide() end
    end)
    hooksecurefunc("HealBot_Action_UpdateHealthButton",function(button)
        if button.foreverPeriodic then Safe(Update,button) end
    end)
    hooksecurefunc("HealBot_Skins_ResetSkin",function(kind,button)
        if kind=="bar" and button.foreverPeriodic then Safe(Update,button) end
    end)
    for _, button in pairs(HealBot_Buttons or {}) do
        if button.frame and button.frame<10 and button.status.events then buttons[button]=true end
    end
    installed=true
end

SLASH_HBPERIODIC1="/hbperiodic"
SlashCmdList.HBPERIODIC=function(msg)
    if msg=="status" then
        print("HealBot Penance/Renew: "..(enabled and "on" or "off")..
              ", casts="..sent..", recognized="..detected..", channels="..channelStarts..", draws="..drawn.."; "..detail)
    elseif enabled then
        Disable()
        print("HealBot Penance/Renew disabled.")
    else
        enabled=true
        if not installed then Safe(Install) end
        if enabled then print("HealBot Penance/Renew enabled for this session.") end
    end
end

enabled=true
Safe(Install)
