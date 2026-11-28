if not HEALBOT_FOREVER then return end

local active={}
local targetButtons={target={},targettarget={},focus={}}
local targetUnits={}
local auraError

local function IndexTargetButton(button)
    button.foreverVitalsGUID=nil
    local previous=targetUnits[button]
    if previous then targetButtons[previous][button]=nil end
    local unit=button.unit
    if active[button] and button.frame<10 and targetButtons[unit] then
        targetButtons[unit][button]=true
        targetUnits[button]=unit
    else
        targetUnits[button]=nil
    end
end

local function RefreshTargetButtons(unit)
    for button in pairs(targetButtons[unit]) do
        if HealBot_Forever_RebindDebuffScan then HealBot_Forever_RebindDebuffScan(button) end
        HealBot_Forever_RefreshTarget(button)
    end
end

-- Target tokens can point at a different unit without changing the secure
-- button's unit attribute. A single-field update needs positive evidence that
-- the last full paint belongs to this occupant. Never compare opaque GUIDs.
function HealBot_Forever_RefreshTarget(button, field)
    if not InCombatLockdown() then return end
    local unit=button.unit
    if unit~="target" and unit~="targettarget" and unit~="focus" then return end
    if not UnitExists(unit) then
        button.foreverVitalsGUID=nil
        button.health.updhlth=false
        button.mana.update=false
        button.name=""
        button.health.current,button.health.max,button.health.pct,button.health.cpct,button.health.hpct=0,0,0,0,0
        button.text.namecomplete=""
        button.text.healthcomplete=""
        button.gref.txt.text:SetText("")
        button.gref.txt.text2:SetText("")
        button.gref.Bar:SetValue(0)
        button.mana.current,button.mana.max,button.mana.pct,button.mana.hpct=0,0,0,0
        HealBot_Aux_setPowerBars(button)
        button.mana.change=false
        return true
    end
    local guid
    if field and UnitGUID then
        local current=UnitGUID(unit)
        if not HealBot_issecretvalue(current) and type(current)=="string" and current~="" then guid=current end
    end
    local same=guid and guid==button.foreverVitalsGUID and unit==button.foreverVitalsUnit
    local full=not same or field=="both"
    if full then
        button.foreverVitalsGUID=nil
        button.name=UnitName(unit)
        button.text.namecomplete=button.name
        button.gref.txt.text:SetText(button.name)
    end
    if full or field=="health" then
        button.health.updhlth=false
        button.health.current,button.health.max,button.health.pct,button.health.cpct,
            button.health.hpct,button.health.rcol,button.health.gcol=HealBot_WoWAPI_UnitHealth(unit)
        button.gref.Bar:SetValue(button.health.hpct)
        HealBot_Text_DoSetHealthText(button, false, true)
    end
    if full or field=="power" then
        button.mana.update=false
        if full or button.mana.change then HealBot_Action_setButtonManaBarCol(button) end
        button.mana.current,button.mana.max,button.mana.pct,button.mana.hpct=
            HealBot_WoWAPI_UnitMana(unit, button.mana.type)
        HealBot_Aux_setPowerBars(button)
        button.mana.change=false
    end
    if full and guid and not HealBot_issecretvalue(button.name) and type(button.name)=="string" and button.name~="" then
        button.foreverVitalsUnit,button.foreverVitalsGUID=unit,guid
    end
    return true
end

local function CreateIncomingBar(button)
    if not CreateUnitHealPredictionCalculator or not UnitGetDetailedHealPrediction then return end
    local calculator=CreateUnitHealPredictionCalculator()
    calculator:SetIncomingHealClampMode(Enum.UnitIncomingHealClampMode.MissingHealth)
    calculator:SetIncomingHealOverflowPercent(1)
    local bar=CreateFrame("StatusBar", nil, button)
    bar:EnableMouse(false)
    bar:Hide()
    button.foreverIncoming={bar=bar, calculator=calculator}
    if HealBot_Forever_CreatePrediction then HealBot_Forever_CreatePrediction(button) end
end

function HealBot_Forever_UpdateIncomingHeals(button)
    if HealBot_Forever_UpdatePrediction and HealBot_Forever_UpdatePrediction(button) then return true end
    local incoming=button.foreverIncoming
    if not incoming then return false end
    local bar=incoming.bar
    local mode=hbv_Skins_GetFrameVar("BarIACol", "IC", button.frame)
    button.gref["InHeal"]:SetValue(0)
    if not button.status.events or button.frame>=10 or not button.status.enabled or
       button.status.current>=HealBot_Unit_Status["DEAD"] or mode<2 then
        bar:Hide()
        return true
    end

    local healthBar=button.gref["Bar"]
    local calculator=incoming.calculator
    UnitGetDetailedHealPrediction(button.unit, "player", calculator)
    -- The native calculator clamps to missing health; no secret arithmetic or
    -- comparisons are needed. The health texture supplies the starting point.
    bar:ClearAllPoints()
    bar:SetSize(healthBar:GetWidth(), healthBar:GetHeight())
    bar:SetOrientation(healthBar:GetOrientation())
    bar:SetReverseFill(healthBar:GetReverseFill())
    if healthBar:GetOrientation()=="VERTICAL" then
        if healthBar:GetReverseFill() then
            bar:SetPoint("TOPLEFT", healthBar:GetStatusBarTexture(), "BOTTOMLEFT")
        else
            bar:SetPoint("BOTTOMLEFT", healthBar:GetStatusBarTexture(), "TOPLEFT")
        end
    elseif healthBar:GetReverseFill() then
        bar:SetPoint("TOPRIGHT", healthBar:GetStatusBarTexture(), "TOPLEFT")
    else
        bar:SetPoint("TOPLEFT", healthBar:GetStatusBarTexture(), "TOPRIGHT")
    end
    bar:SetFrameLevel(button.gref["InHeal"]:GetFrameLevel())
    HealBot_Media_UpdateTexture(bar, hbv_Skins_GetFrameVar("HealBar", "TEXTURE", button.frame), "Forever incoming heals")
    bar:GetStatusBarTexture():SetHorizTile(false)
    bar:SetMinMaxValues(0, calculator:GetMaximumHealth())
    local amount=calculator:GetIncomingHeals()
    bar:SetValue(amount)
    -- Only the native bar can consume secret amounts. Legacy consumers compare
    -- this cache and perform arithmetic, so keep their value readable.
    if HealBot_issecretvalue(amount) then
        button.health.incoming=0
    else
        button.health.incoming=amount
    end
    if mode==3 then
        HealBot_Action_HealsInColourClass(button)
    elseif mode==4 then
        HealBot_Action_HealsInColourRole(button)
    elseif mode==6 then
        local suffix=button.status.hostile and "E" or ""
        button.health.inhealr=hbv_Skins_GetFrameVar("BarIACol", "IR"..suffix, button.frame)
        button.health.inhealg=hbv_Skins_GetFrameVar("BarIACol", "IG"..suffix, button.frame)
        button.health.inhealb=hbv_Skins_GetFrameVar("BarIACol", "IB"..suffix, button.frame)
    elseif mode==7 then
        HealBot_Action_HealsInColourClassHlthMix(button)
    elseif mode==8 then
        HealBot_Action_HealsInColourRoleHlthMix(button)
    else
        HealBot_Action_HealsInColourHealth(button)
    end
    local alpha=hbv_Skins_GetFrameVar("BarIACol", "IA", button.frame)*button.status.alpha
    if button.range.current<=0 then alpha=alpha/3 end
    bar:SetStatusBarColor(button.health.inhealr, button.health.inhealg, button.health.inhealb,
                         HealBot_Action_BarColourAlpha(button, alpha, 2))
    bar:Show()
    return true
end

local dispelNames={"Magic","Curse","Disease","Poison","Bleed"}
local dispelColors
local function RefreshDebuffColors()
    local configured=HealBot_Config_Cures.CDCBarColour
    if dispelColors then
        local changed=false
        for _,name in ipairs(dispelNames) do
            local old,color=dispelColors[name],configured[name]
            if color and (not old or old.r~=color.R or old.g~=color.G or old.b~=color.B)
                or (old and not color) then changed=true; break end
        end
        if not changed then return false end
    end
    local colors={}
    for _,name in ipairs(dispelNames) do
        local color=configured[name]
        if color then colors[name]=CreateColor(color.R, color.G, color.B) end
    end
    dispelColors=colors
    return true
end

local function CreateDebuffOverlay(button, filter, types)
    local container=CreateFrame("AuraContainer", nil, button, "CustomAuraContainerTemplate")
    container:Hide()
    container:SetPoint("TOPLEFT", button.gref["Bar"], "TOPLEFT")
    container:SetFrameLevel(button.gref["Bar"]:GetFrameLevel()+1)
    container:SetMouseClickEnabled(false)
    container:SetMouseMotionEnabled(false)
    container:SetUnit(button.unit)
    local ok, err=pcall(function()
        container:AddAuraGroup("debuffColor", filter, {
            maxFrameCount=1,
            sortMethod=AuraContainerSortMethod.UnitFrameDebuff,
            candidateFilters={includeDispelTypes=types},
            initializeFrame=function(frame)
                frame:SetSize(1,1)
                frame:SetMouseClickEnabled(false)
                frame:SetMouseMotionEnabled(false)
                local texture=frame:CreateTexture(nil, "ARTWORK")
                texture:SetAllPoints(button.gref["Bar"]:GetStatusBarTexture())
                texture:SetColorTexture(1,1,1,1)
                local options={style=Enum.CustomAuraButtonDispelTypeTextureStyle.PreserveAsset,
                               customDispelColorMap=dispelColors}
                if frame.AddDispelTypeTexture then
                    frame:AddDispelTypeTexture(texture, options)
                else
                    frame:SetAuraBorder(texture, options)
                end
                -- This group has one frame. Keep its output texture to reapply
                -- changed colors without allocating a replacement aura group.
                container.foreverColorFrame,container.foreverColorTexture=frame,texture
            end,
        })
        container:SetEnabled(true)
    end)
    if not ok then
        container:Hide()
        error(err)
    end
    return container
end

local function RefreshOverlayScope(button)
    if not button.foreverDebuffs then return end
    local types,signature=button.foreverDebuffTypes,button.foreverDebuffSignature
    if button.foreverDebuffScoped then types,signature=HealBot_Forever_GetDebuffTypes(button) end
    button.foreverDebuffScopeEmpty=signature==""
    if button.foreverDebuffScopeEmpty or (not button.foreverScopeDirty and signature==button.foreverScopeSignature) then return end
    for _,container in pairs(button.foreverDebuffs) do
        if not pcall(container.SetAuraGroupCandidateFilters,container,"debuffColor",{includeDispelTypes=types}) then
            button.foreverScopeDirty=true
            return
        end
    end
    button.foreverScopeDirty=nil
    button.foreverScopeSignature=signature
end

function HealBot_Forever_UpdateDebuffOverlay(button)
    local overlays=button.foreverDebuffs
    if not overlays then return end
    local inCombat=InCombatLockdown()
    -- Keep the native tint through the legacy handoff, but always re-evaluate
    -- monitoring, range and visibility settings. A handoff is not permission
    -- to keep a disabled overlay visible until another aura scan occurs.
    local cures=HealBot_Config_Cures
    local barMode=HealBot_Globals.CustomDebuffsShowBarCol.DEFAULT or 4
    local state=button.aura and button.aura.debuff
    local publicWinner=state and state.scanUnit==button.unit and state.scanCombat==(not not inCombat)
        and (state.publicUnit==button.unit or (not HealBot_issecretvalue(state.id) and type(state.id)=="number" and state.id>0))
    local enabled=button.status.events and not button.foreverDebuffDirty
        and not publicWinner and not button.foreverScopeDirty and not button.foreverDebuffScopeEmpty
        and button.foreverDebuffUnit==button.unit and (inCombat or HealBot_Globals.CombatAurasPersistDebuffs~=false)
        and HealBot_Forever_DebuffsEnabled() and cures.CDCshownHB and
        (barMode==3 or barMode==4) and not button.special.unit and
        button.status.current<HealBot_Unit_Status["PLUGINBARCOL"] and
        HealBot_Range_WarnInRange(button, nil, cures.WarnRange_Bar)
    local dispelOnly=cures.CDCshownHBDispelOnly or cures.IgnoreCannotDispell
    local selected=dispelOnly and "dispel" or "all"
    button.foreverDebuffHandoff=enabled and button.unit or nil
    local alpha=button.status.alpha
    local publicAlpha=not HealBot_issecretvalue(alpha)
    for key, container in pairs(overlays) do
        local show=not not (enabled and key==selected)
        if not publicAlpha or container.foreverAlpha~=alpha then
            container:SetAlpha(alpha)
            container.foreverAlpha=publicAlpha and alpha or nil
        end
        if container.foreverShown~=show then
            container:SetShown(show)
            if show then container:UpdateAllAuras() end
            container.foreverShown=show
        end
    end
end

local function RefreshDebuffOverlays(button)
    if not dispelColors then RefreshDebuffColors() end
    local types,signature,scoped=HealBot_Forever_GetDebuffTypes()
    button.foreverDebuffTypes,button.foreverDebuffScoped=types,scoped
    local rebuild=button.foreverDebuffSignature~=signature
    local recolor=button.foreverDebuffs and button.foreverColors~=dispelColors
    if InCombatLockdown() then
        button.foreverDebuffDirty=rebuild or recolor
        if not button.foreverDebuffDirty then RefreshOverlayScope(button) end
        return
    end
    if recolor and not rebuild then
        local options={style=Enum.CustomAuraButtonDispelTypeTextureStyle.PreserveAsset,customDispelColorMap=dispelColors}
        for _,container in pairs(button.foreverDebuffs) do
            local frame,texture=container.foreverColorFrame,container.foreverColorTexture
            if frame then
                local ok=pcall(function()
                    if frame.AddDispelTypeTexture then
                        frame:RemoveDispelTypeTexture(texture)
                        frame:AddDispelTypeTexture(texture,options)
                    else
                        frame:SetAuraBorder(texture,options)
                    end
                    container:UpdateAllAuras()
                end)
                if not ok then rebuild=true; break end
            end
        end
    end
    button.foreverColors=dispelColors
    if rebuild then
        for _,container in pairs(button.foreverDebuffs or {}) do
            container:Hide()
            container:SetEnabled(false)
        end
        button.foreverDebuffs=nil
        button.foreverDebuffSignature=signature
    end
    button.foreverDebuffDirty=false
    if signature~="" and not button.foreverDebuffs and not auraError then
        local overlays={}
        local ok, err=pcall(function()
            overlays.all=CreateDebuffOverlay(button, "HARMFUL", types)
            overlays.dispel=CreateDebuffOverlay(button, "HARMFUL|RAID", types)
        end)
        if ok then
            button.foreverDebuffs=overlays
            button.foreverScopeSignature=signature
            button.foreverScopeDirty=nil
        else
            for _, container in pairs(overlays) do container:Hide() end
            auraError=tostring(err)
        end
    end
    if button.foreverDebuffs then
        for _, container in pairs(button.foreverDebuffs) do container:SetUnit(button.unit) end
        button.foreverDebuffUnit=button.unit
        RefreshOverlayScope(button)
    end
end

local function Attach(button)
    if button.frame>=10 then
        IndexTargetButton(button)
        return
    end
    active[button]=true
    IndexTargetButton(button)
    if InCombatLockdown() then
        HealBot_Forever_UpdateIncomingHeals(button)
        HealBot_Forever_UpdateDebuffOverlay(button)
        return
    end
    -- Bar text is anchored to the health bar, but must render above native auras.
    for _, key in ipairs({"text", "text2", "text3", "text4", "text5"}) do
        button.gref.txt[key]:SetParent(button.gref["Top"])
        button.gref.txt[key]:SetDrawLayer("OVERLAY")
    end
    if not button.foreverIncoming then
        CreateIncomingBar(button)
    elseif HealBot_Forever_CreatePrediction then
        -- Retry interrupted prediction setup only on the out-of-combat path.
        HealBot_Forever_CreatePrediction(button)
    end
    RefreshDebuffOverlays(button)
    HealBot_Forever_UpdateIncomingHeals(button)
    HealBot_Forever_UpdateDebuffOverlay(button)
end

local function Detach(button)
    active[button]=nil
    IndexTargetButton(button)
    button.foreverDebuffHandoff=nil
    if button.foreverIncoming then button.foreverIncoming.bar:Hide() end
    if button.foreverIncoming and button.foreverIncoming.absorb then
        button.foreverIncoming.visible=false
        button.foreverIncoming.absorb:Hide()
        HealBot_Forever_UpdateOverShield(button)
        HealBot_Aux_ClearHealInBar(button)
        HealBot_Aux_ClearAbsorbBar(button)
    end
    if button.foreverDebuffs then
        for _, container in pairs(button.foreverDebuffs) do
            container:Hide()
            container.foreverShown=false
        end
    end
end

local function UpdateAll(refreshPredictions)
    for button in pairs(active) do
        if refreshPredictions then
            HealBot_Forever_UpdateIncomingHeals(button)
        elseif HealBot_Forever_UpdateOverShield then
            -- This tint also depends on UILOCK, which may change after the native combat event.
            HealBot_Forever_UpdateOverShield(button)
        end
        HealBot_Forever_UpdateDebuffOverlay(button)
    end
end

hooksecurefunc("hbv_Skins_SetFrameVar", function(_, section, _, frame)
    if section=="BarIACol" then
        for button in pairs(active) do
            if button.frame==frame then HealBot_Forever_UpdateIncomingHeals(button) end
        end
    end
end)

hooksecurefunc("HealBot_Action_RegisterUnitEvents", Attach)
hooksecurefunc("HealBot_Action_UnregisterUnitEvents", Detach)
-- SetHealButton can rebind an already registered bar without re-registering
-- events. This reset runs immediately after its unit token is assigned.
hooksecurefunc("HealBot_Action_ResetrCallsUnit", function(button)
    if active[button] then IndexTargetButton(button) end
end)
hooksecurefunc("HealBot_Action_UpdateHealthButton", HealBot_Forever_UpdateDebuffOverlay)
hooksecurefunc("HealBot_Aura_CheckUnitDebuffs",function(button)
    if not button.foreverDebuffs then return end
    RefreshOverlayScope(button)
    HealBot_Forever_UpdateDebuffOverlay(button)
end)
hooksecurefunc("HealBot_Aura_SetAuraCheckFlags", function() UpdateAll(false) end)
local function RefreshActiveDebuffOverlays()
    for button in pairs(active) do
        RefreshDebuffOverlays(button)
        HealBot_Forever_UpdateDebuffOverlay(button)
    end
end
hooksecurefunc("HealBot_Options_Debuff_Reset", function()
    RefreshDebuffColors()
    RefreshActiveDebuffOverlays()
end)
hooksecurefunc("HealBot_SetCDCBarColours", function()
    if RefreshDebuffColors() then RefreshActiveDebuffOverlays() end
end)
hooksecurefunc("HealBot_Skins_ResetSkin", function(_, button)
    if active[button] then
        HealBot_Forever_UpdateIncomingHeals(button)
        HealBot_Forever_UpdateDebuffOverlay(button)
    end
end)

local events=CreateFrame("Frame")
events:RegisterEvent("PLAYER_REGEN_DISABLED")
events:RegisterEvent("PLAYER_REGEN_ENABLED")
events:RegisterEvent("PLAYER_TARGET_CHANGED")
events:RegisterEvent("PLAYER_FOCUS_CHANGED")
-- Match the native target frame: let the client resolve target aliases before
-- delivering target-of-target changes instead of inspecting event payloads.
events:RegisterUnitEvent("UNIT_TARGET", "target")
events:SetScript("OnEvent", function(_, event)
    if event=="PLAYER_TARGET_CHANGED" or event=="PLAYER_FOCUS_CHANGED" or event=="UNIT_TARGET" then
        if not InCombatLockdown() then return end
        if event=="PLAYER_TARGET_CHANGED" then
            RefreshTargetButtons("target")
            RefreshTargetButtons("targettarget")
        elseif event=="PLAYER_FOCUS_CHANGED" then
            RefreshTargetButtons("focus")
        else
            RefreshTargetButtons("targettarget")
        end
        return
    end
    if event=="PLAYER_REGEN_ENABLED" then
        for button in pairs(active) do
            Attach(button)
            if button.foreverDebuffHandoff==button.unit then
                button.aura.debuff.update=true
                HealBot_Events_UnitDebuff(button)
            end
        end
    else
        UpdateAll(true)
    end
end)

function HealBot_Forever_FrameDiagnostics()
    local heals, debuffs=0,0
    for button in pairs(active) do
        if button.foreverIncoming then heals=heals+1 end
        if button.foreverDebuffs then debuffs=debuffs+1 end
    end
    print("Native frames: incoming="..heals.."; debuff colors="..debuffs)
    if auraError then print("Debuff colors: "..auraError) end
end

-- Optional timing for the still-reported target/death stutter after upstream PR92.
-- No native UI methods, aura data, settings or combat behavior are replaced.
do
    local enabled = false
    local timingRevision = "1.7"
    local shieldCounts
    local started
    local stats = {}
    local originals = {}
    local wrappers = {}
    local rebuildReasons={}
    local buildCalls,buildMs=0,0
    local frames, maxFrameMs, slowFrames = 0, 0, 0
    local contexts,context,maxFrameContext
    local hitches,pendingHitch,startedUtc,playerClass,clientBuild
    local traceEvents={"PLAYER_TARGET_CHANGED","PLAYER_DEAD","PLAYER_ALIVE","PLAYER_UNGHOST","LOADING_SCREEN_ENABLED","LOADING_SCREEN_DISABLED"}
    local recentEvents={}
    local sampler = CreateFrame("Frame")
    sampler:Hide()
    local contextEvents={"PLAYER_ENTERING_WORLD","ZONE_CHANGED_NEW_AREA","GROUP_ROSTER_UPDATE","PLAYER_REGEN_DISABLED","PLAYER_REGEN_ENABLED"}
    local instance,zone,rosterType,rosterSize,combat
    local function PublicText(value)
        if type(value)=="string" and not HealBot_issecretvalue(value) and value~="" then return value end
    end
    local function RefreshRoster()
        local category=LE_PARTY_CATEGORY_INSTANCE
        local instanceRaid=category and IsInRaid(category)
        local instanceGroup=instanceRaid or (category and IsInGroup(category))
        if not instanceGroup then category=LE_PARTY_CATEGORY_HOME end
        local raid=instanceRaid or (not instanceGroup and IsInRaid(category))
        if not raid and not instanceGroup and not IsInGroup(category) then
            rosterType,rosterSize="solo",1
            return
        end
        rosterType=(instanceGroup and "instance " or "")..(raid and "raid" or "party")
        local size=GetNumGroupMembers(category)
        rosterSize=type(size)=="number" and not HealBot_issecretvalue(size) and size>0 and size or nil
    end
    local function RefreshContext(_,event)
        if not event or event=="PLAYER_ENTERING_WORLD" or event=="ZONE_CHANGED_NEW_AREA" then
            instance=IsInInstance and PublicText(select(2,IsInInstance()))
            if not instance or instance=="none" then instance="world" end
            zone=GetRealZoneText and PublicText(GetRealZoneText())
            combat=InCombatLockdown()
            RefreshRoster()
        elseif event=="GROUP_ROSTER_UPDATE" then
            RefreshRoster()
        else
            combat=event=="PLAYER_REGEN_DISABLED"
        end
        local label=instance..(zone and " / "..zone or "").." / "..rosterType.." ("..(rosterSize or "?")..")"
            ..(combat and " / combat" or " / out of combat")
        context=contexts[label]
        if not context then
            context={label=label,rosterType=rosterType,rosterSize=rosterSize,frames=0,slowFrames=0,maxFrameMs=0,maxCallMs=0}
            contexts[label]=context
        end
    end
    local InstallTooltipScopes
    sampler:SetScript("OnEvent",function(self,event,addon)
        if event=="ADDON_LOADED" then
            if addon=="HealBot_Tips" then InstallTooltipScopes() end
            return
        end
        recentEvents[event]=GetTime()
        if event=="PLAYER_ENTERING_WORLD" or event=="ZONE_CHANGED_NEW_AREA" or event=="GROUP_ROSTER_UPDATE"
            or event=="PLAYER_REGEN_ENABLED" or event=="PLAYER_REGEN_DISABLED" then RefreshContext(self,event) end
    end)
    local phases={HealBot_Panel_buildDataStore=true,HealBot_Panel_PlayersChanged=true,
        HealBot_Panel_SetupBars=true,HealBot_Panel_PositionBars=true}
    local tooltipPhases={"HealBot_Action_DoRefreshTooltip","HealBot_Tooltip_DisplayIconTooltip",
        "HealBot_Tooltip_DisplayCompactIconTooltip"}
    local function NativeSample(fn,...)
        if not fn then return end
        local ok,value=pcall(fn,...)
        if ok and not HealBot_issecretvalue(value) then return value end
    end
    -- LastTime is a client tick sample. Keep it on this boundary and the next
    -- since the client may publish its counters after the Lua OnUpdate.
    local function Snapshot(ms,slowFrame)
        local before=debugprofilestop()
        local sample={wallMs=ms,context=context.label,frame=frames+1}
        -- The client refreshes realm latency periodically, independently of frame time.
        if slowFrame and GetNetStats then
            local ok,_,_,home,world=pcall(GetNetStats)
            if ok then
                if type(home)=="number" and not HealBot_issecretvalue(home) then sample.recentHomeLatencyMs=home end
                if type(world)=="number" and not HealBot_issecretvalue(world) then sample.recentWorldLatencyMs=world end
            end
        end
        local now=GetTime()
        for event,stamp in pairs(recentEvents) do
            if now-stamp<=1 then
                sample.recentEvents=sample.recentEvents or {}
                sample.recentEvents[event]=now-stamp
            end
        end
        for _,record in ipairs(stats) do
            if record.frame==frames then
                if not sample.heaviestMs or record.frameTotal>sample.heaviestMs then
                    sample.heaviestName,sample.heaviestMs,sample.heaviestCalls=record.name,record.frameTotal,record.frameCalls
                end
                if phases[record.name] then
                    sample.partyPhases=sample.partyPhases or {}
                    sample.partyPhases[record.name]={ms=record.frameTotal,calls=record.frameCalls,max=record.frameMax}
                elseif record.tooltip then
                    sample.tooltipPhases=sample.tooltipPhases or {}
                    sample.tooltipPhases[record.name]={ms=record.frameTotal,calls=record.frameCalls,max=record.frameMax}
                end
            end
        end
        local api=C_AddOnProfiler
        local metric=Enum and Enum.AddOnProfilerMetric and Enum.AddOnProfilerMetric.LastTime
        if api and metric then
            sample.addonsMs=NativeSample(api.GetOverallMetric,metric)
            sample.applicationMs=NativeSample(api.GetApplicationMetric,metric)
            sample.healBotMs=NativeSample(api.GetAddOnMetric,"HealBot",metric)
            local top=NativeSample(api.GetTopKAddOnsForMetric,metric,5)
            if type(top)=="table" and (not canaccesstable or canaccesstable(top)) then
                sample.topAddons={}
                for i=1,math.min(5,#top) do
                    local entry=top[i]
                    if type(entry)=="table" and not HealBot_issecretvalue(entry) and (not canaccesstable or canaccesstable(entry)) then
                        local name,value=PublicText(entry.addOnName),entry.metricValue
                        if name and type(value)=="number" and not HealBot_issecretvalue(value) then
                            sample.topAddons[#sample.topAddons+1]={name=name,ms=value}
                        end
                    end
                end
            end
        end
        sample.observerMs=debugprofilestop()-before
        return sample
    end
    sampler:SetScript("OnUpdate", function(_, elapsed)
        local ms = elapsed * 1000
        local keep=ms>=40 and (#hitches<12 or ms>hitches[12].boundary.wallMs)
        if pendingHitch or keep then
            local snapshot=Snapshot(ms,keep)
            if pendingHitch then pendingHitch.following=snapshot; pendingHitch=nil end
            if keep then
                local row={at=GetTime()-started,boundary=snapshot}
                -- Keep the longest 12 intervals, ordered by duration, even in long captures.
                local index=#hitches+1
                while index>1 and ms>hitches[index-1].boundary.wallMs do index=index-1 end
                table.insert(hitches,index,row)
                if #hitches>12 then hitches[13]=nil end
                pendingHitch=row
            end
        end
        frames = frames + 1
        context.frames=context.frames+1
        if ms>context.maxFrameMs then context.maxFrameMs=ms end
        if ms > maxFrameMs then maxFrameMs,maxFrameContext=ms,context.label end
        if ms >= 40 then slowFrames=slowFrames+1; context.slowFrames=context.slowFrames+1 end
    end)
    local names = {"HealBot_PlayerTargetChanged", "HealBot_TargetChanged", "HealBot_UnitExists",
        "HealBot_Panel_buildDataStore","HealBot_Panel_PlayersChanged","HealBot_Panel_SetupBars","HealBot_Panel_PositionBars",
        "HealBot_Panel_PartyChanged", "HealBot_Panel_EnemyTargetsWithPlayersSelfUpdate",
        "HealBot_Skins_ResetSkin", "HealBot_Aura_SetAuraCheckFlags",
        "HealBot_Aura_CheckUnitBuffs", "HealBot_Aura_CheckUnitDebuffs",
        "HealBot_Action_ResetrCallsUnit", "HealBot_Action_UpdateHealthButton",
        "HealBot_Forever_RefreshTarget", "HealBot_Forever_UpdateIncomingHeals",
        "HealBot_Forever_UpdateDebuffOverlay", "HealBot_Forever_UpdateArrivalAuras",
        "HealBot_Forever_SkinArrivalAuras", "HealBot_Forever_PrepareArrivalAuraContext",
        "HealBot_Action_setLuVars", "HealBot_Timers_Set",
        -- The secure frame retains its original OnUpdate. These are the
        -- actual runtime calls made by its fast, slow and final passes.
        "HealBot_UnitUpdateButton", "HealBot_UnitSlowUpdate", "HealBot_Update_Slow",
        "HealBot_Update_Final", "HealBot_Timers_Run", "HealBot_Timers_RunTimer"}
    local function Finish(record, before, priorBuildCalls, priorBuildMs, callContext, category, timer, ...)
        local elapsed = debugprofilestop() - before
        record.calls = record.calls + 1
        record.total = record.total + elapsed
        if record.frame~=frames then
            record.frame,record.frameCalls,record.frameTotal,record.frameMax=frames,1,elapsed,elapsed
        else
            record.frameCalls,record.frameTotal=record.frameCalls+1,record.frameTotal+elapsed
            if elapsed>record.frameMax then record.frameMax=elapsed end
        end
        if record.name=="Aura.BuildOne" then buildCalls=buildCalls+1; buildMs=buildMs+elapsed end
        if elapsed>callContext.maxCallMs then
            callContext.maxCallMs,callContext.maxCallName=elapsed,record.name
        end
        if elapsed > record.max then
            record.max = elapsed
            record.maxContext=callContext.label
            record.maxRosterType,record.maxRosterSize=callContext.rosterType,callContext.rosterSize
            if record.name=="HealBot_Timers_RunTimer" then
                record.maxTimerCategory,record.maxTimerName=PublicText(category),PublicText(timer)
            end
            if record.name=="Aura.RefreshBuffRows" then
                record.worstBuildCalls=buildCalls-priorBuildCalls
                record.worstBuildMs=buildMs-priorBuildMs
            end
        end
        return ...
    end
    local function Install(name, original, record, localScope)
        local wrapper = function(...)
            if not enabled then return original(...) end
            local before = debugprofilestop()
            local priorBuildCalls,priorBuildMs=buildCalls,buildMs
            local category,timer
            if name=="HealBot_Timers_RunTimer" then category,timer=... end
            return Finish(record,before,priorBuildCalls,priorBuildMs,context,category,timer,original(...))
        end
        originals[name], wrappers[name] = original, wrapper
        if not localScope then _G[name] = wrapper end
        return wrapper
    end
    InstallTooltipScopes=function()
        for _,name in ipairs(tooltipPhases) do
            local fn=_G[name]
            if type(fn)=="function" and not wrappers[name] then
                local record={name=name,calls=0,total=0,max=0,tooltip=true}
                stats[#stats+1]=record
                Install(name,fn,record)
            end
        end
    end
    local function Stop()
        enabled = false
        started=nil
        HealBot_Forever_ShieldPerf=nil
        sampler:Hide()
        sampler:UnregisterAllEvents()
        for name, wrapper in pairs(wrappers) do
            if _G[name] == wrapper then _G[name] = originals[name] end
        end
        local function Restore(name,current)
            if current==wrappers[name] then return originals[name] end
            return current
        end
        if HealBot_Forever_VisitAuraPerfScopes then HealBot_Forever_VisitAuraPerfScopes(Restore) end
        if HealBot_Forever_VisitPartyPerfScopes then HealBot_Forever_VisitPartyPerfScopes(Restore) end
        wipe(originals)
        wipe(wrappers)
    end
    local function Start()
        Stop()
        stats = {}
        -- Fixed counters only. Neither targets nor cast identifiers enter SavedVariables.
        shieldCounts={sent=0,targetMissing=0,castKeyMissing=0,matched=0,rankMismatch=0,unpaired=0,
            directClick=0,clickMatched=0,auraMatched=0,
            completeSeen=0,partialSeen=0,partialUnknown=0,completeMiss=0,missAfterSeen=0,
            selected=0,suppressed=0,painted=0,outOfRange=0,paintBlocked=0}
        HealBot_Forever_ShieldPerf=shieldCounts
        rebuildReasons={}
        buildCalls,buildMs=0,0
        frames, maxFrameMs, slowFrames = 0, 0, 0
        contexts,maxFrameContext={},nil
        hitches,pendingHitch={},nil
        wipe(recentEvents)
        startedUtc=GetServerTime and GetServerTime()
        playerClass=UnitClass and PublicText(select(2,UnitClass("player")))
        clientBuild=GetBuildInfo and select(2,GetBuildInfo())
        RefreshContext()
        for _,event in ipairs(contextEvents) do sampler:RegisterEvent(event) end
        for _,event in ipairs(traceEvents) do sampler:RegisterEvent(event) end
        sampler:RegisterEvent("ADDON_LOADED")
        InstallTooltipScopes()
        started = GetTime()
        for _, name in ipairs(names) do
            local original = _G[name]
            if type(original) == "function" then
                local record = {name = name, calls = 0, total = 0, max = 0}
                stats[#stats + 1] = record
                Install(name, original, record)
            end
        end
        local function InstallScope(name,original)
            local record={name=name,calls=0,total=0,max=0,scope=true}
            stats[#stats+1]=record
            return Install(name,original,record,true)
        end
        if HealBot_Forever_VisitAuraPerfScopes then HealBot_Forever_VisitAuraPerfScopes(InstallScope) end
        if HealBot_Forever_VisitPartyPerfScopes then HealBot_Forever_VisitPartyPerfScopes(InstallScope) end
        local observerName="HealBot_Forever_RecordArrivalRebuild"
        local previous=_G[observerName]
        originals[observerName]=previous
        local observer=function(reasons)
            if enabled then
                for reason in pairs(reasons) do rebuildReasons[reason]=(rebuildReasons[reason] or 0)+1 end
            end
            if type(previous)=="function" then return previous(reasons) end
        end
        wrappers[observerName]=observer
        _G[observerName]=observer
        enabled = true
        sampler:Show()
        print("HealBot timing "..timingRevision.." started. Use /hbperf report after the slowdown.")
    end
    SLASH_HEALBOTLIVEPERF1 = "/hbperf"
    SlashCmdList.HEALBOTLIVEPERF = function(arg)
        arg = (arg or ""):lower():match("^%s*(.-)%s*$")
        if arg == "on" then Start(); return end
        if arg == "off" then Stop(); print("HealBot timing stopped; original functions restored."); return end
        if arg ~= "report" or not started then
            print("HealBot timing "..timingRevision..": /hbperf on, /hbperf report, /hbperf off.")
            return
        end
        local duration = GetTime() - started
        Stop()
        table.sort(stats, function(a, b) return a.max > b.max end)
        for _,record in ipairs(stats) do record.frame,record.frameCalls,record.frameTotal,record.frameMax=nil,nil,nil,nil end
        local report = {revision = timingRevision, elapsed = duration, maxFrameMs = maxFrameMs,
            startedUtc=startedUtc,playerClass=playerClass,clientBuild=clientBuild,hitches=hitches,
            contexts=contexts,maxFrameContext=maxFrameContext,
            frames = frames, slowFrames = slowFrames, functions = stats,rebuildReasons=rebuildReasons,
            shield=shieldCounts}
        if maxFrameContext then
            report.maxFrameRosterType=contexts[maxFrameContext].rosterType
            report.maxFrameRosterSize=contexts[maxFrameContext].rosterSize
        end
        if type(HealBot_Globals) == "table" then HealBot_Globals.ForeverPerformanceReport = report end
        print(string.format("HealBot timing: %.1fs; %d frames; max frame %.1fms; frames >=40ms %d.",
            duration, frames, maxFrameMs, slowFrames))
        print(string.format("Shield: %d sent, %d matched, %d unresolved target names, %d missing cast keys, %d rank mismatches, %d unpaired at success.",
            shieldCounts.sent,shieldCounts.matched,shieldCounts.targetMissing,shieldCounts.castKeyMissing,
            shieldCounts.rankMismatch,shieldCounts.unpaired))
        print(string.format("Direct shield clicks: %d. Missing targets recovered by click: %d; by aura: %d.",
            shieldCounts.directClick,shieldCounts.clickMatched,shieldCounts.auraMatched))
        print(string.format("6788 scans: %d complete seen, %d partial seen, %d partial unknown, %d own-lockout misses (%d after seen). Warning selected/suppressed %d/%d. Paint/range/blocked %d/%d/%d.",
            shieldCounts.completeSeen,shieldCounts.partialSeen,
            shieldCounts.partialUnknown,shieldCounts.completeMiss,shieldCounts.missAfterSeen,
            shieldCounts.selected,shieldCounts.suppressed,shieldCounts.painted,shieldCounts.outOfRange,shieldCounts.paintBlocked))
        if maxFrameContext then print("Longest frame observed in "..maxFrameContext..".") end
        if hitches[1] then print("Saved the "..#hitches.." longest slow frames with surrounding addon CPU samples. HealBot phase times overlap.") end
        for index,entry in ipairs(stats) do
            if entry.calls>0 and (index<=6 or entry.scope or entry.name=="HealBot_Timers_RunTimer") then
                local owner=entry.maxTimerName and (" ["..(entry.maxTimerCategory or "?").."/"..entry.maxTimerName.."]") or ""
                print(string.format("%s%s: %d calls; max %.3fms (%s); inclusive total %.3fms.",
                    entry.name,owner,entry.calls,entry.max,entry.maxContext or "unknown",entry.total))
            end
            if entry.worstBuildCalls then
                print(string.format("Worst aura refresh included %d build calls taking %.3fms.",entry.worstBuildCalls,entry.worstBuildMs))
            end
        end
        local reasonNames={}
        for reason in pairs(rebuildReasons) do reasonNames[#reasonNames+1]=reason end
        table.sort(reasonNames)
        local reasonText={}
        for _,reason in ipairs(reasonNames) do reasonText[#reasonText+1]=reason.."="..rebuildReasons[reason] end
        print("Arrival rebuild reasons: "..(#reasonText>0 and table.concat(reasonText,", ") or "none recorded"))
        print("Timing stopped. Nested totals overlap; timings are diagnostic evidence, not a confirmed cause.")
    end
end
