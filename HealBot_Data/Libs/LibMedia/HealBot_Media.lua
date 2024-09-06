local LSM=nil
local hbMediaRegister={}
local HealBot_Textures=nil
local HealBot_Fonts=nil
local HealBot_TexturesIndex={}
local HealBot_FontsIndex={}
local HealBot_Sounds=nil
local HealBot_Default_Texture=nil
local HealBot_Default_TextureName=nil
local HealBot_Default_Font=nil
local HealBot_Default_FontName=nil
local HealBot_Default_Sound=nil
local HealBot_Default_SoundName=nil
local HealBot_SoundsIndex={}
local HealBot_Media_luVars={}
HealBot_Media_luVars["Indexed"]=false
HealBot_Media_luVars["Registered"]=false
HealBot_Media_luVars["InitFontsRerun"]=0
HealBot_Media_luVars["DelayUpdateUsedMedia"]=false
HealBot_Media_luVars["pluginMedia"]=false

local HealBot_Font_Outline={
    [1]="",
    [2]="OUTLINE",
    [3]="THICKOUTLINE",
}

function HealBot_Media_PluginState(state)
	if HealBot_Media_luVars["pluginMedia"]~=state then
        HealBot_Media_luVars["pluginMedia"]=state
        HealBot_Media_PluginChange()
    elseif not HealBot_Media_luVars["Indexed"] then
        HealBot_Media_UpdateIndexes()    
    end
end

function HealBot_Media_PluginChange()
    HealBot_Media_UpdateIndexes()
    HealBot_Timers_Set("SKINS","ResetUpdate")
    HealBot_Plugin_Media_Summary()
end

local function HealBot_Default_Media()
    HealBot_Default_Texture=HealBot_Data_Default_Texture()
    HealBot_Default_TextureName=HealBot_Data_Default_TextureName()
    HealBot_Default_Font=HealBot_Data_Default_Font()
    HealBot_Default_FontName=HealBot_Data_Default_FontName()
    HealBot_Default_Sound=HealBot_Data_Default_Sound()
    HealBot_Default_SoundName=HealBot_Data_Default_SoundName()
end

function HealBot_Media_Register()
    LSM=HealBot_Libs_LSM()
    if not HealBot_Media_luVars["Registered"] then
        HealBot_Default_Media()
        if LSM then
            HealBot_Media_luVars["Registered"]=true
            for i=1, #HealBot_Supplied_Textures do
                LSM:Register("statusbar", HealBot_Supplied_Textures[i].name, HealBot_Supplied_Textures[i].file)
            end
            for i=1, #HealBot_Supplied_Sounds do
                LSM:Register("sound", HealBot_Supplied_Sounds[i].name, HealBot_Supplied_Sounds[i].file)
            end
            for i=1, #HealBot_Supplied_Fonts do
                LSM:Register("font", HealBot_Supplied_Fonts[i].name, HealBot_Supplied_Fonts[i].file)
            end
        end
    end
end

local function HealBot_Media_SetFonts(id)
      --HealBot_setCall("HealBot_Media_InitFonts")
    if id<=#HealBot_Fonts then
        local g=_G["UsedToInitFonts"]
        g:SetFont(LSM:Fetch('font', HealBot_Fonts[id]), 10, HealBot_Font_Outline[1])
        g:SetText("i"..id)
        C_Timer.After(0.1, function() HealBot_Media_SetFonts(id+1) end)
    elseif HealBot_Media_luVars["InitFontsRerun"]<3 then
        HealBot_Media_luVars["InitFontsRerun"]=HealBot_Media_luVars["InitFontsRerun"]+1
        HealBot_Media_luVars["InitFonts"]=false
        C_Timer.After(HealBot_Media_luVars["InitFontsRerun"]*3, HealBot_Media_InitFonts)
    else
        HealBot_Media_luVars["InitFonts"]=false
    end
end

function HealBot_Media_InitFonts()
    if not HealBot_Media_luVars["InitFonts"] then
        HealBot_Media_luVars["InitFonts"]=true
        C_Timer.After(1, function() HealBot_Media_SetFonts(1) end)
    else
        C_Timer.After(15, HealBot_Media_InitFonts)
    end
end

function HealBot_Media_UpdateDefaultFont(object, height, outline, caller)
    object:SetFont(HealBot_Default_Font, height, HealBot_Font_Outline[outline])
   -- HealBot_AddDebug("UpdateDefaultFont  Caller="..(caller or "nil"),"Media DefaultFont",true)
end

function HealBot_Media_UpdateFont(object, font, height, outline, caller)
    object:SetFont(LSM:Fetch('font', font), height, HealBot_Font_Outline[outline])
   -- HealBot_AddDebug("LSM Fetch Font "..font.."  Caller="..(caller or "nil"),"Media Font",true)
end

function HealBot_Media_UpdateDefaultTexture(object, caller)
    object:SetStatusBarTexture(HealBot_Default_Texture)
   -- HealBot_AddDebug("UpdateDefaultTexture  Caller="..(caller or "nil"),"Media DefaultTexture",true)
end

function HealBot_Media_UpdateTexture(object, texture, caller)
    object:SetStatusBarTexture(LSM:Fetch('statusbar', texture))
   -- HealBot_AddDebug("LSM Fetch Texture "..texture.."  Caller="..(caller or "nil"),"Media Texture",true)
end

function HealBot_Media_UpdateTextureRef(name, texture, caller)
    local g=_G[name]
    HealBot_Media_UpdateTexture(g, texture, caller)
end

function HealBot_Media_ReturnSound(name)
    return LSM:Fetch('sound', name)
end

local hbSounds={}
hbSounds["TimeNextPlay"]=0
hbSounds["TimeCallback"]=0
function HealBot_Media_PlaySound(name, channel)
    if not hbSounds[name] then hbSounds[name]=0 end
    if hbSounds[name]<HealBot_TimeNow then
        if hbSounds["TimeNextPlay"]<HealBot_TimeNow then
            hbSounds[name]=HealBot_TimeNow+1
            hbSounds["TimeNextPlay"]=HealBot_TimeNow+0.25
            PlaySoundFile(LSM:Fetch('sound',name), channel or "SFX")
        elseif hbSounds["TimeCallback"]<HealBot_TimeNow then
            hbSounds["TimeCallback"]=0.02+(hbSounds["TimeNextPlay"]-HealBot_TimeNow)
            C_Timer.After(hbSounds["TimeCallback"], function() HealBot_Media_PlaySound(name, channel) end)
        end
    end
end

function HealBot_Media_UpdateIndexes()
    HealBot_Media_luVars["Indexed"]=true
    for x,_ in pairs(HealBot_TexturesIndex) do
        HealBot_TexturesIndex[x]=nil
    end 
    for x,_ in pairs(HealBot_FontsIndex) do
        HealBot_FontsIndex[x]=nil
    end 
    for x,_ in pairs(HealBot_SoundsIndex) do
        HealBot_SoundsIndex[x]=nil
    end 
    
    if HealBot_Media_luVars["pluginMedia"] then
        HealBot_Textures=HealBot_Plugin_Media_TexturesEnabled()
        HealBot_Fonts=HealBot_Plugin_Media_FontsEnabled()
        HealBot_Sounds=HealBot_Plugin_Media_SoundsEnabled()
    else
        HealBot_Textures=LSM:List('statusbar')
        HealBot_Fonts=LSM:List('font')
        HealBot_Sounds=LSM:List('sound')
    end
    
    for i=1,#HealBot_Textures do
        HealBot_TexturesIndex[HealBot_Textures[i]]=i
    end
    for i=1,#HealBot_Fonts do
        HealBot_FontsIndex[HealBot_Fonts[i]]=i
    end
    for i=1,#HealBot_Sounds do
        HealBot_SoundsIndex[HealBot_Sounds[i]]=i
    end
end

function HealBot_Media_TextureIndex(texture)
    if texture and HealBot_TexturesIndex[texture] then
        return HealBot_TexturesIndex[texture]
    else
        return HealBot_TexturesIndex[HealBot_Default_TextureName] or 1
    end
end

function HealBot_Media_TextureName(index)
    if index and HealBot_Textures[index] then
        return HealBot_Textures[index]
    else
        return HealBot_Default_TextureName
    end
end

function HealBot_Media_TexturesCount()
    return #HealBot_Textures
end

function HealBot_Media_FontIndex(font)
    if font and HealBot_FontsIndex[font] then
        return HealBot_FontsIndex[font]
    else
        return HealBot_FontsIndex[HealBot_Default_FontName] or 1
    end
end

function HealBot_Media_FontName(index)
    if index and HealBot_Fonts[index] then
        return HealBot_Fonts[index]
    else
        return HealBot_Default_FontName
    end
end

function HealBot_Media_FontsCount()
    return #HealBot_Fonts
end

function HealBot_Media_SoundIndex(sound)
    if sound and HealBot_SoundsIndex[sound] then
        return HealBot_SoundsIndex[sound] 
    else
        return HealBot_SoundsIndex[HealBot_Default_SoundName] or 1
    end
end

function HealBot_Media_SoundName(index)
    if index and HealBot_Sounds[index] then
        return HealBot_Sounds[index] 
    else
        return HealBot_Default_SoundName
    end
end

function HealBot_Media_SoundsCount()
    return #HealBot_Sounds
end

function HealBot_Media_UpdateType(mType, frame, auxId)
      --HealBot_setCall("HealBot_Options_UpdateMedia")
    if HealBot_Options:IsVisible() then
        if mType == "Textures" then
            HealBot_Options_UpdateMediaTexture(HealBot_Options_SkinFrameAliasTextureS,HealBot_Skins_GetFrameVar("FrameAliasBar", "TEXTURE", frame))
            HealBot_Options_UpdateMediaTexture(HealBot_Options_BarTextureS,HealBot_Skins_GetFrameVar("HealBar", "TEXTURE", frame))
            HealBot_Options_UpdateMediaTexture(HealBot_Options_HeadTextureS,HealBot_Skins_GetFrameVar("HeadBar", "TEXTURE", frame))
            HealBot_Options_UpdateMediaTexture(HealBot_EmergBarTexture, HealBot_Skins_GetFrameVar("Emerg", "TEXTURE", frame))
        elseif mType == "Fonts" then
            HealBot_Options_UpdateMediaFont(HealBot_Options_HeadFontNameS,HealBot_Skins_GetFrameVar("HeadText", "FONT", frame))
            HealBot_Options_UpdateMediaFont(HealBot_Options_AliasFontName,HealBot_Skins_GetFrameVar("FrameAlias", "FONT", frame))
            HealBot_Options_UpdateMediaFont(HealBot_Options_HealthFontName,HealBot_Skins_GetFrameVar("BarText", "HFONT", frame))
            HealBot_Options_UpdateMediaFont(HealBot_Options_AggroFontName,HealBot_Skins_GetFrameVar("BarText", "AFONT", frame))
            HealBot_Options_UpdateMediaFont(HealBot_Options_AuxFontName,HealBot_Aux_GetBarTextVar("FONT", frame, auxId))
            HealBot_Options_UpdateMediaFont(HealBot_Options_StateFontName,HealBot_Skins_GetFrameVar("BarText", "SFONT", frame))
            HealBot_Options_UpdateMediaFont(HealBot_Options_ActionIconsFontName,HealBot_ActionIcons_GetVars("FONT", frame))
            HealBot_Options_UpdateMediaFont(HealBot_Options_ActionIconsFontCountName,HealBot_ActionIcons_GetVars("FONTCOUNT", frame))
            for z=1,3 do
                HealBot_Options_UpdateMediaFont(HealBot_BarButtonIconBuffFont,HealBot_Skins_GetIconTextVar("BUFFFONT", frame, z))
                HealBot_Options_UpdateMediaFont(HealBot_BarButtonIconFont, HealBot_Skins_GetIconTextVar("DBFONT", frame, z))
            end
            HealBot_Options_UpdateMediaFont(HealBot_Options_FontName, HealBot_Skins_GetFrameVar("BarText", "FONT", frame))
        else
            HealBot_Options_val_OnLoad(HealBot_Options_WarningSound,HEALBOT_OPTIONS_SOUND,1,#HealBot_Sounds,1,2)
            HealBot_Options_SetText(HealBot_Options_WarningSound,HEALBOT_OPTIONS_SOUND)
            HealBot_Options_SetSliderValue(HealBot_Options_WarningSound,HealBot_SoundsIndex[HealBot_Config_Cures.SoundDebuffPlay])
            HealBot_Options_val_OnLoad(HealBot_Options_BuffWarningSound,HEALBOT_OPTIONS_SOUND,1,#HealBot_Sounds,1,2)
            HealBot_Options_SetText(HealBot_Options_BuffWarningSound,HEALBOT_OPTIONS_SOUND)
            HealBot_Options_SetSliderValue(HealBot_Options_BuffWarningSound,HealBot_SoundsIndex[HealBot_Config_Buffs.SoundBuffPlay])
        end
    end
end

local function HealBot_Media_UpdateUsedTextures(button)
      --HealBot_setCall("HealBot_Media_UpdateUsedTextures", button)
    HealBot_Media_UpdateTexture(button.gref["Bar"], HealBot_Skins_GetFrameVar("HealBar", "TEXTURE", button.frame), "Media_UpdateUsedTextures - HealBar")
    HealBot_Media_UpdateTexture(button.gref["InHeal"], HealBot_Skins_GetFrameVar("HealBar", "TEXTURE", button.frame), "Media_UpdateUsedTextures - HealBar")
    for x=1,9 do
        HealBot_Media_UpdateTexture(button.gref.aux[x], HealBot_Skins_GetFrameVar("HealBar", "TEXTURE", button.frame), "Media_UpdateUsedTextures - HealBar")
    end
    HealBot_Media_UpdateTexture(button.gref["Absorb"], HealBot_Skins_GetFrameVar("HealBar", "TEXTURE", button.frame), "Media_UpdateUsedTextures - HealBar")
    button.gref["Bar"]:GetStatusBarTexture():SetHorizTile(false)
    button.gref["InHeal"]:GetStatusBarTexture():SetHorizTile(false)
    for x=1,9 do
        button.gref.aux[x]:GetStatusBarTexture():SetHorizTile(false)
    end
    button.gref["Absorb"]:GetStatusBarTexture():SetHorizTile(false)
    HealBot_Media_UpdateTexture(HealBot_Emerg_Button[button.id].bar, HealBot_Skins_GetFrameVar("Emerg", "TEXTURE", button.frame), "Media_UpdateUsedTextures - Emerg")
    HealBot_Emerg_Button[button.id].bar:GetStatusBarTexture():SetHorizTile(false)
end

local function HealBot_Media_UpdateUsedButtonText(button)
      --HealBot_setCall("HealBot_Media_UpdateUsedButtonText", button)
    HealBot_Media_UpdateFont(button.gref.txt["text"], 
                             HealBot_Skins_GetFrameVar("BarText", "FONT", button.frame), 
                             ceil(HealBot_Skins_GetFrameVar("BarText", "HEIGHT", button.frame)*HealBot_Skins_GetFrameVar("Frame", "SCALE", button.frame)), 
                             HealBot_Skins_GetFrameVar("BarText", "OUTLINE", button.frame),
                             "Media_UpdateUsedButtonText - BarText")
    HealBot_Media_UpdateFont(button.gref.txt["text2"], 
                             HealBot_Skins_GetFrameVar("BarText", "HFONT", button.frame), 
                             ceil(HealBot_Skins_GetFrameVar("BarText", "HHEIGHT", button.frame)*HealBot_Skins_GetFrameVar("Frame", "SCALE", button.frame)), 
                             HealBot_Skins_GetFrameVar("BarText", "HOUTLINE", button.frame),
                             "Media_UpdateUsedButtonText - BarText")
    HealBot_Media_UpdateFont(button.gref.txt["text3"], 
                             HealBot_Skins_GetFrameVar("BarText", "SFONT", button.frame), 
                             ceil(HealBot_Skins_GetFrameVar("BarText", "SHEIGHT", button.frame)*HealBot_Skins_GetFrameVar("Frame", "SCALE", button.frame)), 
                             HealBot_Skins_GetFrameVar("BarText", "SOUTLINE", button.frame),
                             "Media_UpdateUsedButtonText - BarText")
    HealBot_Media_UpdateFont(button.gref.txt["text4"], 
                             HealBot_Skins_GetFrameVar("BarText", "AFONT", button.frame), 
                             ceil(HealBot_Skins_GetFrameVar("BarText", "AHEIGHT", button.frame)*HealBot_Skins_GetFrameVar("Frame", "SCALE", button.frame)), 
                             HealBot_Skins_GetFrameVar("BarText", "AOUTLINE", button.frame),
                             "Media_UpdateUsedButtonText - BarText")
    if ceil(HealBot_Skins_GetFrameVar("BarText", "HHEIGHT", button.frame)*HealBot_Skins_GetFrameVar("Frame", "SCALE", button.frame))-HealBot_Globals.VehicleFontSizeReduction<2 then
        HealBot_Media_UpdateFont(button.gref.txt["text5"],
                                 HealBot_Skins_GetFrameVar("Frame", "HFONT", button.frame),
                                 2,
                                 HealBot_Skins_GetFrameVar("Frame", "HOUTLINE", button.frame),
                                 "Media_UpdateUsedButtonText - BarText")

    else
        HealBot_Media_UpdateFont(button.gref.txt["text5"], 
                                 HealBot_Skins_GetFrameVar("Frame", "HFONT", button.frame), 
                                 ceil(HealBot_Skins_GetFrameVar("BarText", "HHEIGHT", button.frame)*HealBot_Skins_GetFrameVar("Frame", "SCALE", button.frame))-HealBot_Globals.VehicleFontSizeReduction,
                                 HealBot_Skins_GetFrameVar("BarText", "HOUTLINE", button.frame),
                                 "Media_UpdateUsedButtonText - BarText")
    end
end

local function HealBot_Media_UpdateUsedAuxText(button)
      --HealBot_setCall("HealBot_Media_UpdateUsedAuxText")
    for x=1,9 do
        HealBot_Media_UpdateFont(button.gref.auxtxt[x],
                                 HealBot_Aux_GetBarTextVar("FONT", button.frame, x),
                                 ceil(HealBot_Aux_GetBarTextVar("HEIGHT", button.frame, x)*
                                      HealBot_Skins_GetFrameVar("Frame", "SCALE", button.frame)),
                                 HealBot_Aux_GetBarTextVar("OUTLINE", button.frame, x),
                                 "Media_UpdateUsedButtonText - AuxBarText")
    end
end

local hbUpdateDelay=0.2
local hbUpdateDelayType={}
local function HealBot_Media_DoUpdateUsedMedia(mediatype, frame)
    if HealBot_retLuVars("ClearReset") then
        if HealBot_Data["UILOCK"] then
            hbUpdateDelay=2
        else
            hbUpdateDelay=0.2
        end
        C_Timer.After(hbUpdateDelay, function() HealBot_Media_DoUpdateUsedMedia(mediatype, frame) end)
    else
        hbUpdateDelayType[mediatype..frame]=false
      --HealBot_setCall("HealBot_Media_DoUpdateUsedMedia")
        if mediatype == "statusbar" then
            local hFrames=HealBot_Panel_retHealBot_Header_Frames()
            for _,h in pairs(hFrames) do
                if h then
                    local bar=_G[h:GetName().."Bar"]
                    if bar then
                        HealBot_Media_UpdateTexture(bar, HealBot_Skins_GetFrameVar("HeadBar", "TEXTURE", frame), "Media_DoUpdateUsedMedia - HeadBar")
                        bar:GetStatusBarTexture():SetHorizTile(false)
                    end
                end
            end
            for _,xButton in pairs(HealBot_Unit_Button) do
                if xButton.frame == frame then
                    HealBot_Media_UpdateUsedTextures(xButton)
                end
            end
            for _,xButton in pairs(HealBot_Private_Button) do
                if xButton.frame == frame then
                    HealBot_Media_UpdateUsedTextures(xButton)
                end
            end 
            for _,xButton in pairs(HealBot_Pet_Button) do
                if xButton.frame == frame then
                    HealBot_Media_UpdateUsedTextures(xButton)
                end
            end 
            for _,xButton in pairs(HealBot_Vehicle_Button) do
                if xButton.frame == frame then
                    HealBot_Media_UpdateUsedTextures(xButton)
                end
            end 
            for _,xButton in pairs(HealBot_Enemy_Button) do
                if xButton.frame == frame then
                    HealBot_Media_UpdateUsedTextures(xButton)
                end
            end 
            for xUnit,xButton in pairs(HealBot_UnitTarget_Button) do
                if xButton.frame == frame then
                    HealBot_Media_UpdateUsedTextures(xButton)
                end
            end
            for xUnit,xButton in pairs(HealBot_PrivateTarget_Button) do
                if xButton.frame == frame then
                    HealBot_Media_UpdateUsedTextures(xButton)
                end
            end
            for _,xButton in pairs(HealBot_Extra_Button) do
                if xButton.frame == frame then
                    HealBot_Media_UpdateUsedTextures(xButton)
                end
            end
            for _,xButton in pairs(HealBot_Test_Button) do
                if xButton.frame == frame then
                    HealBot_Media_UpdateUsedTextures(xButton)
                end
            end
        elseif mediatype == "font" then
            local hFrames=HealBot_Panel_retHealBot_Header_Frames()
            for _,h in pairs(hFrames) do
                if h then
                    local bar=_G[h:GetName().."Bar_text"]
                    if bar then
                        HealBot_Media_UpdateFont(bar, 
                                                 HealBot_Skins_GetFrameVar("HeadText", "FONT", frame),
                                                 HealBot_Skins_GetFrameVar("HeadText", "HEIGHT", frame),
                                                 HealBot_Skins_GetFrameVar("HeadText", "OUTLINE", frame),
                                                 "Media_DoUpdateUsedMedia - HeadText")
                    end
                end
            end
            for _,xButton in pairs(HealBot_Unit_Button) do
                if xButton.frame == frame then
                    HealBot_Media_UpdateUsedButtonText(xButton)
                end
            end
            for _,xButton in pairs(HealBot_Private_Button) do
                if xButton.frame == frame then
                    HealBot_Media_UpdateUsedButtonText(xButton)
                end
            end      
            for _,xButton in pairs(HealBot_Pet_Button) do
                if xButton.frame == frame then
                    HealBot_Media_UpdateUsedButtonText(xButton)
                end
            end 
            for _,xButton in pairs(HealBot_Vehicle_Button) do
                if xButton.frame == frame then
                    HealBot_Media_UpdateUsedButtonText(xButton)
                end
            end 
            for _,xButton in pairs(HealBot_Enemy_Button) do
                if xButton.frame == frame then
                    HealBot_Media_UpdateUsedButtonText(xButton)
                end
            end 
            for xUnit,xButton in pairs(HealBot_UnitTarget_Button) do
                if xButton.frame == frame then
                    HealBot_Media_UpdateUsedButtonText(xButton)
                end
            end
            for xUnit,xButton in pairs(HealBot_PrivateTarget_Button) do
                if xButton.frame == frame then
                    HealBot_Media_UpdateUsedButtonText(xButton)
                end
            end
            for _,xButton in pairs(HealBot_Extra_Button) do
                if xButton.frame == frame then
                    HealBot_Media_UpdateUsedButtonText(xButton)
                end
            end
            for _,xButton in pairs(HealBot_Test_Button) do
                if xButton.frame == frame then
                    HealBot_Media_UpdateUsedButtonText(xButton)
                end
            end

            for _,xButton in pairs(HealBot_Unit_Button) do
                if xButton.frame == frame then
                    HealBot_Media_UpdateUsedAuxText(xButton)
                end
            end
            for _,xButton in pairs(HealBot_Private_Button) do
                 if xButton.frame == frame then
                    HealBot_Media_UpdateUsedAuxText(xButton)
                end
            end
            for _,xButton in pairs(HealBot_Enemy_Button) do
                if xButton.frame == frame then
                    HealBot_Media_UpdateUsedAuxText(xButton)
                end
            end
            for xUnit,xButton in pairs(HealBot_UnitTarget_Button) do
                if xButton.frame == frame then
                    HealBot_Media_UpdateUsedAuxText(xButton)
                end
            end
            for xUnit,xButton in pairs(HealBot_PrivateTarget_Button) do
                if xButton.frame == frame then
                    HealBot_Media_UpdateUsedAuxText(xButton)
                end
            end
            for _,xButton in pairs(HealBot_Pet_Button) do
                if xButton.frame == frame then
                    HealBot_Media_UpdateUsedAuxText(xButton)
                end
            end
            for _,xButton in pairs(HealBot_Vehicle_Button) do
                if xButton.frame == frame then
                    HealBot_Media_UpdateUsedAuxText(xButton)
                end
            end
            for _,xButton in pairs(HealBot_Extra_Button) do
                if xButton.frame == frame then
                    HealBot_Media_UpdateUsedAuxText(xButton)
                end
            end
            for _,xButton in pairs(HealBot_Test_Button) do
                if xButton.frame == frame then
                    HealBot_Media_UpdateUsedAuxText(xButton)
                end
            end
        end
    end
end

function HealBot_Media_UpdateUsedMedia(mediatype, frame)
      --HealBot_setCall("HealBot_Media_UpdateUsedMedia")
    if not hbUpdateDelayType[mediatype..frame] then
        hbUpdateDelayType[mediatype..frame]=true
        C_Timer.After(0.1, function() HealBot_Media_DoUpdateUsedMedia(mediatype, frame) end)
    end
end
