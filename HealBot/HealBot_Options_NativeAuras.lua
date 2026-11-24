-- Global native-aura options, hosted in Skins > Frames > Icons.
local labels={
    enUS={tab="Native auras",scope="Global settings for all frames and skins.",
        enabled="Enable native buff and debuff icons",persist="Keep debuffs visible outside combat",
        priest="Priest spell filter (priests only)",nums="Countdown numbers",skin="Follow skin",on="Always show",off="Always hide",
        skinSize="Use skin icon size",size="Icon size",hots="Buff icon cap",debuffs="Debuff icon cap",
        maxdur="Maximum buff duration (seconds)",unlimited="No limit",
        help="0 seconds includes long and permanent buffs; 120 keeps buffs up to two minutes. Icon caps also respect the skin's Max icons. Position, Duration and Count remain in the Buffs/Debuffs tabs.",
        combat="Changes requiring new icons will apply after combat.",ready="Changes are saved automatically.",
        unsupported="Native aura icons require a supported modern client, including Forever."},
    itIT={tab="Aure native",scope="Impostazioni globali per tutti i frame e le skin.",
        enabled="Abilita icone native di buff e debuff",persist="Mantieni i debuff visibili fuori combattimento",
        priest="Filtro incantesimi del sacerdote (solo sacerdoti)",nums="Numeri del conto alla rovescia",skin="Segui la skin",on="Mostra sempre",off="Nascondi sempre",
        skinSize="Usa dimensione della skin",size="Dimensione icone",hots="Limite icone buff",debuffs="Limite icone debuff",
        maxdur="Durata massima buff (secondi)",unlimited="Nessun limite",
        help="0 secondi include buff lunghi e permanenti; 120 limita i buff a due minuti. Vale anche Max icone della skin. Posizione, Durata e Conteggio restano nelle schede Buff/Debuff.",
        combat="Le modifiche che richiedono nuove icone saranno applicate dopo il combattimento.",ready="Le modifiche vengono salvate automaticamente.",
        unsupported="Le icone native richiedono un client moderno supportato, incluso Forever."},
    deDE={tab="Native Auren",scope="Globale Einstellungen für alle Rahmen und Skins.",
        enabled="Native Buff- und Debuff-Symbole aktivieren",persist="Debuffs außerhalb des Kampfes anzeigen",
        priest="Priesterzauber filtern (nur Priester)",nums="Countdown-Zahlen",skin="Skin verwenden",on="Immer anzeigen",off="Immer ausblenden",
        skinSize="Symbolgröße des Skins",size="Symbolgröße",hots="Buff-Symbollimit",debuffs="Debuff-Symbollimit",
        maxdur="Maximale Buff-Dauer (Sekunden)",unlimited="Unbegrenzt",
        help="0 Sekunden zeigt auch lange und permanente Buffs; 120 begrenzt Buffs auf zwei Minuten. Das Symbollimit des Skins gilt ebenfalls. Position, Dauer und Stapelzahl bleiben unter Buffs/Debuffs.",
        combat="Änderungen, die neue Symbole benötigen, werden nach dem Kampf angewendet.",ready="Änderungen werden automatisch gespeichert.",
        unsupported="Native Auren benötigen einen unterstützten modernen Client, einschließlich Forever."},
}
local L=labels.enUS
local controls
local refreshing=false
local panelName="HealBot_Options_SkinsFrameIconsNative"
local function Apply(option,value)
    if not refreshing and HealBot_CombatAuras_SetOption then
        HealBot_CombatAuras_SetOption(option,value)
    end
end

local function Build()
    if controls then return end
    local panel=_G[panelName]
    controls={}
    local function text(key,x,y,width)
        local region=panel:CreateFontString(nil,"OVERLAY","GameFontNormalSmall")
        region:SetPoint("TOPLEFT",panel,"TOPLEFT",x,-y)
        region:SetWidth(width)
        region:SetJustifyH("LEFT")
        controls[key]=region
    end
    local function check(key,x,y,width)
        local button=CreateFrame("CheckButton",panelName..key,panel,"HealBotUIPanelCheckButton")
        button:SetPoint("TOPLEFT",panel,"TOPLEFT",x,-y)
        button.Text:SetWidth(width)
        button.Text:SetJustifyH("LEFT")
        button:SetScript("OnClick",function(self) Apply(key,not not self:GetChecked()) end)
        controls[key]=button
    end
    local function slider(key,x,y,width)
        local slider=CreateFrame("Slider",panelName..key,panel,"HealBot_Options_SliderTemplate")
        slider:SetPoint("TOPLEFT",panel,"TOPLEFT",x,-y)
        slider:SetWidth(width)
        slider:SetObeyStepOnDrag(true)
        slider:SetScript("OnValueChanged",function(self,value) Apply(key,value) end)
        controls[key]=slider
    end
    text("scope",24,16,530)
    check("enabled",24,48,500)
    check("persist",24,80,500)
    check("priest",24,112,500)
    text("numsLabel",24,166,245)
    local dropdown=CreateFrame("Frame",panelName.."nums",panel,"UIDropDownMenuTemplate")
    dropdown:SetPoint("TOPLEFT",panel,"TOPLEFT",8,-184)
    UIDropDownMenu_SetWidth(dropdown,210)
    dropdown.initialize=function()
        local g=HealBot_CombatAuras_GetOptions()
        local selected=g.CombatAurasNumsFollowSkin and "skin" or (g.CombatAurasNums and "on" or "off")
        for _,mode in ipairs({"skin","on","off"}) do
            local info=UIDropDownMenu_CreateInfo()
            info.text=L[mode]
            info.checked=selected==mode
            info.func=function() Apply("nums",mode) end
            UIDropDownMenu_AddButton(info)
        end
    end
    controls.nums=dropdown
    check("skinSize",310,160,230)
    slider("size",320,224,215)
    slider("hots",32,290,225)
    slider("debuffs",320,290,215)
    slider("maxdur",32,356,385)
    local duration=CreateFrame("EditBox",panelName.."maxdurValue",panel,"HealBot_Options_EditBoxTemplate")
    duration:SetPoint("TOPLEFT",panel,"TOPLEFT",460,-344)
    duration:SetSize(70,24)
    duration:SetAutoFocus(false)
    duration:SetNumeric(true)
    duration:SetMaxLetters(4)
    local function saveDuration(self)
        Apply("maxdur",self:GetText())
        HealBot_Options_NativeAuras_Refresh()
    end
    duration:SetScript("OnEnterPressed",function(self) saveDuration(self); self:ClearFocus() end)
    duration:SetScript("OnEditFocusLost",saveDuration)
    duration:SetScript("OnEscapePressed",function(self)
        HealBot_Options_NativeAuras_Refresh()
        self:ClearFocus()
    end)
    controls.maxdurValue=duration
    text("help",24,390,530)
    text("status",24,454,530)
    panel:RegisterEvent("PLAYER_REGEN_DISABLED")
    panel:RegisterEvent("PLAYER_REGEN_ENABLED")
    panel:SetScript("OnEvent",function() HealBot_Options_NativeAuras_Refresh() end)
end

function HealBot_Options_NativeAuras_Refresh()
    local panel=_G[panelName]
    if not panel or not panel:IsShown() then return end
    Build()
    refreshing=true
    local g=HealBot_CombatAuras_GetOptions and HealBot_CombatAuras_GetOptions() or {}
    local supported=not not (HEALBOT_MIDNIGHT and HealBot_CombatAuras_SetOption)
    local enabled=supported and g.CombatAurasOn
    local _,class=UnitClass("player")
    local function availability(control,active)
        if active then control:Enable() else control:Disable() end
        control:SetAlpha(active and 1 or 0.5)
    end
    for key,value in pairs({enabled=not not g.CombatAurasOn,persist=not not g.CombatAurasPersistDebuffs,
        priest=g.CombatAurasPriestOnly==true,skinSize=not not g.CombatAurasMatchSkinSize}) do
        local control=controls[key]
        HealBot_Options_SetText(control,L[key])
        control:SetChecked(value)
        local active=(key=="enabled" and supported) or enabled
        if key=="priest" then active=enabled and HEALBOT_FOREVER and class=="PRIEST" end
        availability(control,active)
    end
    for key,spec in pairs({size={8,40,g.CombatAurasSize or 12},hots={0,8,g.CombatAurasHots or 4},
        debuffs={0,8,g.CombatAurasDebuffs or 3},maxdur={0,3600,g.CombatAurasMaxDur or 0}}) do
        local control=controls[key]
        HealBot_Options_val_OnLoad(control,L[key],spec[1],spec[2],1)
        control:SetValue(spec[3])
        HealBot_Options_SetText(control,L[key]..": "..(key=="maxdur" and spec[3]==0 and L.unlimited or spec[3]))
        availability(control,enabled and (key~="size" or not g.CombatAurasMatchSkinSize))
    end
    local mode=g.CombatAurasNumsFollowSkin and "skin" or (g.CombatAurasNums and "on" or "off")
    controls.maxdurValue:SetText(tostring(g.CombatAurasMaxDur or 0))
    controls.maxdurValue:SetEnabled(not not enabled)
    controls.maxdurValue:SetAlpha(enabled and 1 or 0.5)
    UIDropDownMenu_SetText(controls.nums,L[mode])
    if enabled then UIDropDownMenu_EnableDropDown(controls.nums)
    else UIDropDownMenu_DisableDropDown(controls.nums) end
    controls.scope:SetText(L.scope)
    controls.numsLabel:SetText(L.nums)
    controls.help:SetText(L.help)
    controls.status:SetText(not supported and L.unsupported or (InCombatLockdown() and L.combat or L.ready))
    refreshing=false
end

function HealBot_Options_NativeAuras_SetLanguage(region)
    L=labels[region] or labels.enUS
    local label=_G[panelName.."bTxt"]
    if label then label:SetText(L.tab) end
    HealBot_Options_NativeAuras_Refresh()
end

function HealBot_Options_SkinsFramesIconsNativeTab()
    Build()
    HealBot_Options_NativeAuras_Refresh()
end
