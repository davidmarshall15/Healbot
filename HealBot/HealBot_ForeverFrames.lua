if not HEALBOT_FOREVER then return end

local active={}
local auraError

local function CreateIncomingBar(button)
    if not CreateUnitHealPredictionCalculator or not UnitGetDetailedHealPrediction then return end
    local calculator=CreateUnitHealPredictionCalculator()
    calculator:SetIncomingHealClampMode(Enum.UnitIncomingHealClampMode.MissingHealth)
    calculator:SetIncomingHealOverflowPercent(1)
    local bar=CreateFrame("StatusBar", nil, button)
    bar:EnableMouse(false)
    bar:Hide()
    button.foreverIncoming={bar=bar, calculator=calculator}
end

function HealBot_Forever_UpdateIncomingHeals(button)
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
    button.health.incoming=amount
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

local function DebuffColors()
    local colors={}
    for _, name in ipairs({"Magic", "Curse", "Disease", "Poison", "Bleed"}) do
        local color=HealBot_Config_Cures.CDCBarColour[name]
        if color then colors[name]=CreateColor(color.R, color.G, color.B) end
    end
    return colors
end

local function CreateDebuffOverlay(button, filter)
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
            candidateFilters={includeDispelTypes={Magic=true, Curse=true, Disease=true, Poison=true, Bleed=true}},
            initializeFrame=function(frame)
                frame:SetSize(1,1)
                frame:SetMouseClickEnabled(false)
                frame:SetMouseMotionEnabled(false)
                local texture=frame:CreateTexture(nil, "ARTWORK")
                texture:SetAllPoints(button.gref["Bar"]:GetStatusBarTexture())
                texture:SetColorTexture(1,1,1,1)
                local options={style=Enum.CustomAuraButtonDispelTypeTextureStyle.PreserveAsset,
                               customDispelColorMap=DebuffColors()}
                if frame.AddDispelTypeTexture then
                    frame:AddDispelTypeTexture(texture, options)
                else
                    frame:SetAuraBorder(texture, options)
                end
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

function HealBot_Forever_UpdateDebuffOverlay(button)
    local overlays=button.foreverDebuffs
    if not overlays then return end
    local cures=HealBot_Config_Cures
    local barMode=HealBot_Globals.CustomDebuffsShowBarCol.DEFAULT or 4
    local enabled=button.status.events and button.foreverDebuffUnit==button.unit and InCombatLockdown() and
        HealBot_Aura_DebuffsEnabled() and cures.CDCshownHB and
        (barMode==3 or barMode==4) and not button.special.unit and
        button.status.current<HealBot_Unit_Status["PLUGINBARCOL"] and
        HealBot_Range_WarnInRange(button, nil, cures.WarnRange_Bar)
    local dispelOnly=cures.CDCshownHBDispelOnly or cures.IgnoreCannotDispell
    local selected=dispelOnly and "dispel" or "all"
    for key, container in pairs(overlays) do
        local show=not not (enabled and key==selected)
        container:SetAlpha(button.status.alpha)
        container:SetShown(show)
        if show and not container.foreverShown then container:UpdateAllAuras() end
        container.foreverShown=show
    end
end

local function Attach(button)
    if button.frame>=10 then return end
    active[button]=true
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
    if not button.foreverIncoming then CreateIncomingBar(button) end
    if not button.foreverDebuffs and not auraError then
        local overlays={}
        local ok, err=pcall(function()
            overlays.all=CreateDebuffOverlay(button, "HARMFUL")
            overlays.dispel=CreateDebuffOverlay(button, "HARMFUL|RAID")
        end)
        if ok then
            button.foreverDebuffs=overlays
        else
            for _, container in pairs(overlays) do container:Hide() end
            auraError=tostring(err)
        end
    end
    if button.foreverDebuffs then
        for _, container in pairs(button.foreverDebuffs) do container:SetUnit(button.unit) end
        button.foreverDebuffUnit=button.unit
    end
    HealBot_Forever_UpdateIncomingHeals(button)
    HealBot_Forever_UpdateDebuffOverlay(button)
end

local function Detach(button)
    active[button]=nil
    if button.foreverIncoming then button.foreverIncoming.bar:Hide() end
    if button.foreverDebuffs then
        for _, container in pairs(button.foreverDebuffs) do
            container:Hide()
            container.foreverShown=false
        end
    end
end

local function UpdateAll()
    for button in pairs(active) do
        HealBot_Forever_UpdateIncomingHeals(button)
        HealBot_Forever_UpdateDebuffOverlay(button)
    end
end

hooksecurefunc("HealBot_Action_RegisterUnitEvents", Attach)
hooksecurefunc("HealBot_Action_UnregisterUnitEvents", Detach)
hooksecurefunc("HealBot_Action_UpdateHealthButton", HealBot_Forever_UpdateDebuffOverlay)
hooksecurefunc("HealBot_Aura_SetAuraCheckFlags", UpdateAll)
hooksecurefunc("HealBot_Skins_ResetSkin", function(_, button)
    if active[button] then
        HealBot_Forever_UpdateIncomingHeals(button)
        HealBot_Forever_UpdateDebuffOverlay(button)
    end
end)

local events=CreateFrame("Frame")
events:RegisterEvent("PLAYER_REGEN_DISABLED")
events:RegisterEvent("PLAYER_REGEN_ENABLED")
events:SetScript("OnEvent", function(_, event)
    if event=="PLAYER_REGEN_ENABLED" then
        for button in pairs(active) do Attach(button) end
    else
        UpdateAll()
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
