-- Regression fixture: unchanged functions from Blizzard's Forever UI source.
-- https://github.com/Gethe/wow-ui-source/blob/forever/Interface/AddOns/Blizzard_FrameXML/SecureTemplates.lua
-- Retrieved 2026-11-07. Export local conversion helper for isolated mock testing.
local PRESS_TYPE_DOWN, PRESS_TYPE_UP, PRESS_TYPE_HOLD_RELEASE = 1, 2, 3
local LOCAL_CHECK_Frame = GetFrameMetatable().__index
local BUTTON_LOOKUP_TABLE = {}
for n=4,31 do BUTTON_LOOKUP_TABLE['Button'..n]=tostring(n) end
ATTRIBUTE_NOOP = ''

function SecureUnitButton_OnClick(self, button, down)
	local type;

	if C_ClickBindings then -- NOTE: If Classic has ClickBindings someday, remove this.
		local modifiers = MakeModifiers();
		local bindingType = C_ClickBindings.GetBindingType(button, modifiers);

		local allowExecute = bindingType == Enum.ClickBindingType.Spell or
			bindingType == Enum.ClickBindingType.Macro or
			bindingType == Enum.ClickBindingType.PetAction;
		if allowExecute then
			local unit = SecureButton_GetModifiedUnit(self);
			C_ClickBindings.ExecuteBinding(unit, button, modifiers);
			return;
		end

		-- If this is an interaction binding, find the default button so that we can retrieve
		-- the desired 'type' from the frame attributes. We need the default because the
		-- attribute data is unaware of the click binding system.
		if bindingType == Enum.ClickBindingType.Interaction then
			button = C_ClickBindings.GetEffectiveInteractionButton(button, modifiers);
		end

		type = SecureButton_GetModifiedAttribute(self, "type", button);

		-- If the 'type' can correlate with any interaction, then it can only proceed if the
		-- interaction binding existed. If it doesn't exist, it's because another click cast
		-- binding unbound it in conflict.
		local expectBinding = type == "target" or type == "menu" or type == "togglemenu";
		if expectBinding and bindingType == Enum.ClickBindingType.None then
			return;
		end
	else
		 type = SecureButton_GetModifiedAttribute(self, "type", button);
	end

	if type == "menu" or type == "togglemenu" then
		if SpellIsTargeting() then
			SpellStopTargeting();
			return;
		end
	end

	local isKeyPress = false;
	OnActionButtonClick(self, button, down, isKeyPress);
end

function SecureActionButton_ShouldUseOnKeyDown(self)
	local useOnKeyDown = SecureButton_GetAttribute(self, "useOnKeyDown");

	if useOnKeyDown == nil then
		useOnKeyDown = GetCVarBool("ActionButtonUseKeyDown");
	end

	return useOnKeyDown;
end

function SecureActionButton_OnClick(self, inputButton, down, isKeyPress, isSecureAction)
	-- Why are we adding extra arguments, 'isKeyPress' and 'isSecureAction', to an _OnClick handler?
	-- We want to prevent mouse actions from triggering press-and-hold behavior for now, but we do want to allow AddOns
	-- to function as they did before. This is a problem since there's no difference between an AddOn's key press behavior
	-- and mouse click behavior. So if we don't know where this is coming from, it's from an AddOn and should be treated as
	-- a key press not a mouse press for 'useOnKeyDown' purposes.
	local isSecureMousePress = not isKeyPress and isSecureAction;
	local pressAndHoldAction = SecureButton_GetAttribute(self, "pressAndHoldAction");
	local useOnKeyDown = not isSecureMousePress and (SecureActionButton_ShouldUseOnKeyDown(self) or pressAndHoldAction);
	local clickAction = (down and useOnKeyDown) or (not down and not useOnKeyDown);
	local releasePressAndHoldAction = (not down) and (pressAndHoldAction or GetCVarBool("ActionButtonUseKeyHeldSpell"));

	if clickAction then
		-- Only treat a key down action as a key press. Treating key up actions as a key press will result in the held
		-- spell being cast indefinitely since there's no release to stop it.
		local treatAsKeyPress = down and isKeyPress;
		OnActionButtonClick(self, inputButton, down, treatAsKeyPress);
		return true;
	elseif releasePressAndHoldAction then
		OnActionButtonPressAndHoldRelease(self, inputButton);
		return true;
	end

	return false;
end

function GetConvertedButtonUnitAndActionType(self, button, pressType)
	if pressType == PRESS_TYPE_DOWN then
		-- remap the button if desired for up-down behaviors. This behavior may not be safe and has been deferred.
		button = SecureButton_GetModifiedAttribute(self, "downbutton", button) or button
	end

	-- Lookup the unit, based on the modifiers and button
	local unit = SecureButton_GetModifiedUnit(self, button);

	-- Remap button suffixes based on the disposition of the unit (contributed by Iriel and Cladhaire)
	if unit then
		local origButton = button;
		if UnitCanAttack("player", unit) then
			button = SecureButton_GetModifiedAttribute(self, "harmbutton", button) or button;
		elseif UnitCanAssist("player", unit) then
			button = SecureButton_GetModifiedAttribute(self, "helpbutton", button) or button;
		end

		-- The unit may have changed based on button remapping
		if ( button ~= origButton ) then
			unit = SecureButton_GetModifiedUnit(self, button);
		end
	end

	if type(button) ~= "string" then
		return nil;
	end

	if unit and unit ~= "none" and not UnitExists(unit) then
		return nil;
	end

	-- Lookup the action type, based on the modifiers and button
	local attributeName = (pressType == PRESS_TYPE_HOLD_RELEASE) and "typerelease" or "type";
	local actionType = SecureButton_GetModifiedAttribute(self, attributeName, button);

	return button, unit, actionType;
end

function SecureButton_GetModifierPrefix(frame)
    -- Handle optional frame modifiers attribute
    if ( frame ) then
        local modlist = LOCAL_CHECK_Frame.GetAttribute(frame, "modifiers");
        if ( modlist ) then
            local prefix = SecureButton_ParseModifierString(modlist);
            if ( prefix ) then
                return prefix .. "-";
            end
        end
    end

    local prefix = "";
    if ( IsShiftKeyDown() ) then
        prefix = "shift-"..prefix;
    end
    if ( IsControlKeyDown() ) then
        prefix = "ctrl-"..prefix;
    end
    if ( IsAltKeyDown() ) then
        prefix = "alt-"..prefix;
    end
    return prefix;
end

function SecureButton_GetButtonSuffix(button)
    if ( button == "LeftButton" ) then
        return "1";
    elseif ( button == "RightButton" ) then
        return "2";
    elseif ( button == "MiddleButton" ) then
        return "3";
    elseif (button and button ~= "") then
        local lookup = BUTTON_LOOKUP_TABLE[button];
        if ( lookup ) then
            return lookup
        else
            return "-" .. tostring(button);
        end
    end
    return "";
end

function SecureButton_GetModifiedAttribute(frame, name, button, prefix, suffix)
    if ( not prefix ) then
        prefix = SecureButton_GetModifierPrefix(frame);
    end
    if ( not suffix ) then
        suffix = SecureButton_GetButtonSuffix(button);
    end
    local value = LOCAL_CHECK_Frame.GetAttribute(frame, prefix, name, suffix);
    if ( not value and (LOCAL_CHECK_Frame.GetAttribute(frame, "useparent-"..name) or
                        LOCAL_CHECK_Frame.GetAttribute(frame, "useparent*")) ) then
        local parent = frame.bar or LOCAL_CHECK_Frame.GetParent(frame);
        if ( parent ) then
            value = SecureButton_GetModifiedAttribute(parent, name, button, prefix, suffix);
        end
    end
    if ( value == ATTRIBUTE_NOOP ) then
        value = nil;
    end
    return value;
end

function SecureButton_GetAttribute(frame, name)
    return SecureButton_GetModifiedAttribute(frame, name, nil, "", "");
end
