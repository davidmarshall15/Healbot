local xButton={}
local pButton={}

function HealBot_Plugin_ThreatUpdate(guid)
      --HealBot_setCall("HealBot_Plugin_ThreatUpdate", nil, guid)
    xButton,pButton=HealBot_Panel_RaidPetUnitButton(guid)
    if xButton and xButton.status.plugin then
        HealBot_CalcThreat(xButton)
        HealBot_Plugin_Threat_UnitUpdate(xButton)
    elseif pButton and pButton.status.plugin then
        HealBot_CalcThreat(pButton)
        HealBot_Plugin_Threat_UnitUpdate(pButton)
    else
        HealBot_Plugin_ThreatRemoveUnit(guid)
    end
end

function HealBot_Plugin_TTDUpdate(guid)
      --HealBot_setCall("HealBot_Plugin_TTDUpdate", nil, guid)
    xButton,pButton=HealBot_Panel_RaidPetUnitButton(guid)
    if xButton and xButton.status.plugin then
        HealBot_Plugin_TimeToDie_UnitUpdate(xButton, xButton.health.current)
    elseif pButton and pButton.status.plugin then
        HealBot_Plugin_TimeToDie_UnitUpdate(pButton, pButton.health.current)
    else
        HealBot_Plugin_TTDRemoveUnit(guid)
    end
end

function HealBot_Plugin_Options_SetupFrame(frame, hide, tall)
	frame:SetBackdrop({
		bgFile="Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile="Interface\\Tooltips\\UI-Tooltip-Border",
        tile=true, tileSize=12, edgeSize=12,
        insets={ left=2, right=2, top=2, bottom=2, },
	})
	frame:SetBackdropColor(0,0,0,0);
    if tall then
        frame:SetPoint("TOPLEFT", -5, -80)
        frame:SetSize(600,510)
    else
        frame:SetPoint("TOPLEFT", -5, -120)
        frame:SetSize(600,470)
    end
	if hide then
		frame:Hide()
	end
    frame.Txt=frame:CreateFontString()
    frame.Txt:SetFontObject(GameFontNormal)
    frame.Txt:SetPoint("BOTTOMRIGHT", -5 , 5)
end

function HealBot_Plugin_Options_SetupDropDown(dropdown, width, point, x, y, text, txtPoint, txtX, txtY)
	dropdown:SetPoint(point, x, y)
	UIDropDownMenu_SetWidth(dropdown, width)
    if text then
        dropdown.Txt=dropdown:CreateFontString()
        dropdown.Txt:SetFontObject(GameFontNormal)
        dropdown.Txt:SetPoint(txtPoint, txtX, txtY)
        dropdown.Txt:SetText(text)
    end
end

function HealBot_Plugin_Options_SetupSlider(slider, point, width, x, y)
	slider:SetSize(width, 15)
	slider:SetOrientation('HORIZONTAL')
	slider:SetPoint(point, x, y)
end

function HealBot_Plugin_Options_SetLabel(object, text)
	local r,g,b,a=HealBot_Options_OptionsThemeCols()
	object:SetText(text)
	object:SetTextColor(r,g,b,a)
end

function HealBot_Plugin_Options_SetupStatusBar(bar, width, height, x, y, text, txtCenter)
	bar:SetSize(width, height)
	bar:SetPoint("TOP", x, y)
	bar:SetStatusBarTexture("Interface\\Addons\\HealBot\\Images\\bar8.tga")
	bar.Text=bar:CreateFontString()
	bar.Text:SetFontObject(GameFontNormal)
    if txtCenter then
        bar.Text:SetPoint("CENTER")
    else
        bar.Text:SetPoint("TOP", 0, 15)
    end
    bar.Text:SetText(text)
end

function HealBot_Plugin_Options_SetupStatusBarButton(bar, width, x, text, y)
	bar:SetSize(width, 22)
	bar:SetPoint("TOP", x, y or -85)
	bar:SetStatusBarTexture("Interface\\Addons\\HealBot\\Images\\textures\\tukuibar.tga")
	bar.Text=bar:CreateFontString()
	bar.Text:SetFontObject(GameFontNormal)
    bar.Text:SetPoint("CENTER")
    bar.Text:SetText(text)
end

function HealBot_Plugin_Options_SetupPlayButton(button, x, y)
    button:SetPoint("TOP", x, y)
    button:SetNormalTexture([[Interface\Common\VoiceChat-Speaker]])
    button:SetHighlightTexture([[Interface\Common\VoiceChat-On]])
    button:SetPushedTexture([[Interface\Common\VoiceChat-On]])
    button:SetSize(20, 20)
end

function HealBot_Plugin_Options_SetupButton(button, width, x, y, text)
    button:SetPoint("TOP", x, y)
    button:SetWidth(width)
    button:SetHeight(20)
    button:SetNormalFontObject("GameFontNormal")
    button:SetText(text)
end

function HealBot_Plugin_Options_Setup_EditBox(editbox, parent, point, x, y, width, headertext, text, txtTop, incHdr)
	editbox:SetPoint(point,parent,x,y)
	editbox:SetTextInsets(2, 2, 2, 2)
	editbox:SetMaxLetters(30)
	editbox:SetWidth(width)
	editbox.Txt=editbox:CreateFontString()
	editbox.Txt:SetFontObject(GameFontNormal)
    if txtTop then
        editbox.Txt:SetPoint("TOPLEFT", 0 , 12)
    else
        editbox.Txt:SetPoint("RIGHT", editbox, "LEFT", -15, 0)
    end
    editbox.Txt:SetText(headertext)
	editbox:SetText(text)
    if incHdr then
        editbox.Hdr=editbox:CreateFontString()
        editbox.Hdr:SetFontObject(GameFontNormalSmall)
        editbox.Hdr:SetPoint("TOP", 0, 12)
        editbox.Hdr:SetText(headertext)
    end
end