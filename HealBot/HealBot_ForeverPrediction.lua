if not HEALBOT_FOREVER then return end

local colourCurves={}
-- Keep the shield distinct from class/health colours: cerulean fill (#007BA7)
-- with a light-blue texture pattern (#80D8FF).
local shieldR,shieldG,shieldB=0,123/255,167/255

local function Readable(value)
    if HealBot_issecretvalue(value) then return 0 end
    return value
end

local function PredictionReady(incoming)
    return incoming and incoming.calculator and incoming.absorb and incoming.absorbOverlay and
           incoming.colourCalculator and incoming.remainingCalculator
end

function HealBot_Forever_CreatePrediction(button)
    local incoming=button.foreverIncoming
    if PredictionReady(incoming) then return true end
    if not incoming or not incoming.calculator then return false end
    if not incoming.calculator.GetDamageAbsorbs or not Enum.UnitDamageAbsorbClampMode then return end
    -- Publish only a complete renderer. If setup errors, incoming heals can
    -- still use their fallback and later refreshes cannot use a partial bar.
    local absorb=CreateFrame("StatusBar", nil, button)
    absorb:EnableMouse(false)
    absorb:Hide()
    -- Use the same tiled shield assets as Forever's compact unit frames.
    local fill=absorb:CreateTexture(nil,"ARTWORK")
    SetTextureWithAddressModeOptions(fill,"raidframe-shield-fill",TextureKitConstants.IgnoreAtlasSize,
                                    TextureKitConstants.AddressModeWrap,TextureKitConstants.AddressModeWrap)
    absorb:SetStatusBarTexture(fill)
    absorb.foreverShieldTexture=true
    local overlay=absorb:CreateTexture(nil,"OVERLAY")
    SetTextureWithAddressModeOptions(overlay,"RaidFrame-Shield-Overlay",TextureKitConstants.IgnoreAtlasSize,
                                    TextureKitConstants.AddressModeWrap,TextureKitConstants.AddressModeWrap)
    overlay:SetAllPoints(fill)
    overlay:SetBlendMode("BLEND")
    overlay:SetVertexColor(128/255,216/255,1)
    local colourCalculator=CreateUnitHealPredictionCalculator()
    local remainingCalculator=CreateUnitHealPredictionCalculator()
    if incoming.absorb then incoming.absorb:Hide() end
    incoming.absorb=absorb
    incoming.absorbOverlay=overlay
    incoming.colourCalculator=colourCalculator
    incoming.remainingCalculator=remainingCalculator
    return true
end

local function PredictionCurve(button, kind, mode)
    local suffix=button.status.hostile and "E" or ""
    local values={mode}
    if mode==6 then
        for _, key in ipairs({"IT","CT","R","G","B","IR","IG","IB","CR","CG","CB"}) do
            local ending=(key=="IT" or key=="CT") and "" or suffix
            values[#values+1]=hbv_Skins_GetFrameVar("BarIACol",kind..key..ending,button.frame)
        end
    end
    local signature=table.concat(values,":")
    local key=button.frame..kind..suffix
    local entry=colourCurves[key]
    if entry and entry.signature==signature then return entry.curve end
    local curve=C_CurveUtil.CreateColorCurve()
    if mode==6 then
        curve:SetType(Enum.LuaCurveType.Step)
        -- The input is the fraction still missing after prediction. Only skin
        -- thresholds are subtracted in Lua; health arithmetic stays native.
        curve:AddPoint(0,CreateColor(values[4],values[5],values[6]))
        if values[2]>values[3] then
            curve:AddPoint(1-values[2],CreateColor(values[7],values[8],values[9]))
        end
        curve:AddPoint(1-values[3],CreateColor(values[10],values[11],values[12]))
    else
        curve:SetType(Enum.LuaCurveType.Linear)
        curve:AddPoint(0,CreateColor(0,1,0))
        curve:AddPoint(0.02,CreateColor(0,1,0))
        curve:AddPoint(0.35,CreateColor(1,1,0))
        curve:AddPoint(0.69,CreateColor(1,0,0))
        curve:AddPoint(1,CreateColor(1,0,0))
    end
    colourCurves[key]={signature=signature,curve=curve}
    return curve
end

local function PredictionColour(button,kind,mode)
    local incoming=button.foreverIncoming
    local calculator=incoming.calculator
    local prefix=kind=="I" and "inheal" or "absorb"
    local functions=kind=="I" and "HealBot_Action_HealsInColour" or "HealBot_Action_AbsorbsColour"
    if (mode==5 or mode==6) and C_CurveUtil and C_CurveUtil.CreateColorCurve then
        local remaining=calculator:GetMaximumDamageAbsorbs()
        if kind=="A" then
            local amount=calculator:GetDamageAbsorbs()
            incoming.remainingCalculator:SetPredictedValues({health=amount,healthMax=remaining})
            remaining=incoming.remainingCalculator:GetMissingHealth()
        end
        incoming.colourCalculator:SetPredictedValues({health=remaining,healthMax=calculator:GetMaximumHealth()})
        local color=incoming.colourCalculator:EvaluateCurrentHealthPercent(PredictionCurve(button,kind,mode))
        button.health[prefix.."r"],button.health[prefix.."g"],button.health[prefix.."b"]=color:GetRGB()
    elseif mode==6 then
        local suffix=button.status.hostile and "E" or ""
        for _, component in ipairs({"r","g","b"}) do
            button.health[prefix..component]=hbv_Skins_GetFrameVar("BarIACol",kind..string.upper(component)..suffix,button.frame)
        end
    else
        local name=({[3]="Class",[4]="Role",[7]="ClassHlthMix",[8]="RoleHlthMix"})[mode] or "Health"
        _G[functions..name](button)
    end
end

local function PositionPrediction(button,bar,anchor,level)
    local healthBar=button.gref["Bar"]
    bar:ClearAllPoints()
    bar:SetSize(healthBar:GetWidth(),healthBar:GetHeight())
    bar:SetOrientation(healthBar:GetOrientation())
    bar:SetReverseFill(healthBar:GetReverseFill())
    if healthBar:GetOrientation()=="VERTICAL" then
        if healthBar:GetReverseFill() then bar:SetPoint("TOPLEFT",anchor,"BOTTOMLEFT")
        else bar:SetPoint("BOTTOMLEFT",anchor,"TOPLEFT") end
    elseif healthBar:GetReverseFill() then bar:SetPoint("TOPRIGHT",anchor,"TOPLEFT")
    else bar:SetPoint("TOPLEFT",anchor,"TOPRIGHT") end
    bar:SetFrameLevel(level)
    if not bar.foreverShieldTexture then
        HealBot_Media_UpdateTexture(bar,hbv_Skins_GetFrameVar("HealBar","TEXTURE",button.frame),"Forever prediction")
        bar:GetStatusBarTexture():SetHorizTile(false)
    end
end

function HealBot_Forever_UpdateOverShield(button)
    local incoming=button.foreverIncoming
    if not PredictionReady(incoming) then return false end
    local alpha=0
    if incoming.visible and hbv_Skins_GetFrameVar("BarIACol","AC",button.frame)>1 and
       HealBot_Data["UILOCK"] and hbv_Skins_GetFrameBoolean("BarIACol","OSHIELD",button.frame) and
       C_CurveUtil and C_CurveUtil.EvaluateColorValueFromBoolean then
        local _,clamped=incoming.calculator:GetDamageAbsorbs()
        alpha=C_CurveUtil.EvaluateColorValueFromBoolean(clamped,1,0)
    end
    button.gref["Shield"]:SetStatusBarColor(shieldR,shieldG,shieldB,alpha)
    return true
end

function HealBot_Forever_UpdatePrediction(button)
    local incoming=button.foreverIncoming
    if not PredictionReady(incoming) then
        if incoming and incoming.absorb then incoming.absorb:Hide() end
        return false
    end
    local calculator=incoming.calculator
    local mode=hbv_Skins_GetFrameVar("BarIACol","IC",button.frame)
    local visible=button.status.events and button.frame<10 and button.status.enabled and
                  button.status.current<HealBot_Unit_Status["DEAD"]
    incoming.visible=not not visible
    button.gref["InHeal"]:SetValue(0)
    button.gref["Absorb"]:SetValue(0)
    button.health.inhptc,button.health.abptc,button.health.absorbspctc=0,0,0
    if not visible then
        incoming.bar:Hide()
        incoming.absorb:Hide()
        button.health.incoming,button.health.auxincoming=0,0
        button.health.absorbs,button.health.auxabsorbs=0,0
        HealBot_Forever_UpdateOverShield(button)
        HealBot_Aux_ClearHealInBar(button)
        HealBot_Aux_ClearAbsorbBar(button)
        return true
    end
    UnitGetDetailedHealPrediction(button.unit,"player",calculator)
    calculator:SetDamageAbsorbClampMode(mode>1 and Enum.UnitDamageAbsorbClampMode.MissingHealth or
                                       Enum.UnitDamageAbsorbClampMode.MissingHealthWithoutIncomingHeals)
    local amount=calculator:GetIncomingHeals()
    button.health.incoming=Readable(amount)
    button.health.auxincoming=Readable(calculator:GetTotalIncomingHeals())
    PredictionColour(button,"I",mode)
    local alpha=hbv_Skins_GetFrameVar("BarIACol","IA",button.frame)*button.status.alpha
    if button.range.current<=0 then alpha=alpha/3 end
    PositionPrediction(button,incoming.bar,button.gref["Bar"]:GetStatusBarTexture(),button.gref["InHeal"]:GetFrameLevel())
    incoming.bar:SetMinMaxValues(0,calculator:GetMaximumHealth())
    incoming.bar:SetValue(amount)
    incoming.bar:SetStatusBarColor(button.health.inhealr,button.health.inhealg,button.health.inhealb,
                                  HealBot_Action_BarColourAlpha(button,alpha,2))
    incoming.bar:SetShown(mode>1)
    local absorbMode=hbv_Skins_GetFrameVar("BarIACol","AC",button.frame)
    local absorbAmount=calculator:GetDamageAbsorbs()
    button.health.absorbs=Readable(calculator:GetTotalDamageAbsorbs())
    button.health.auxabsorbs=button.health.absorbs
    PredictionColour(button,"A",absorbMode)
    local anchor=mode>1 and incoming.bar:GetStatusBarTexture() or button.gref["Bar"]:GetStatusBarTexture()
    PositionPrediction(button,incoming.absorb,anchor,button.gref["Absorb"]:GetFrameLevel())
    incoming.absorb:SetMinMaxValues(0,calculator:GetMaximumHealth())
    incoming.absorb:SetValue(absorbAmount)
    local absorbAlpha=hbv_Skins_GetFrameVar("BarIACol","AA",button.frame)*button.status.alpha
    if button.range.current<=0 then absorbAlpha=absorbAlpha/3 end
    incoming.absorbOverlay:SetAlpha(HealBot_Action_BarColourAlpha(button,absorbAlpha,2)*0.85)
    incoming.absorb:SetStatusBarColor(shieldR,shieldG,shieldB,
                                     HealBot_Action_BarColourAlpha(button,absorbAlpha,2))
    incoming.absorb:SetShown(absorbMode>1)
    HealBot_Forever_UpdateOverShield(button)
    HealBot_Aux_UpdateHealInBar(button)
    HealBot_Aux_UpdateAbsorbBar(button)
    return true
end

function HealBot_Forever_UpdateAbsorbs(button)
    return HealBot_Forever_UpdatePrediction(button)
end
