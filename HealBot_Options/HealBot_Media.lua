local LSM = HealBot_Libs_LSM()
local hbMediaRegister={}
local HealBot_Textures=nil
local HealBot_Fonts=nil
local HealBot_TexturesIndex={}
local HealBot_FontsIndex={}
local HealBot_Sounds=nil
local HealBot_SoundsIndex={}
local HealBot_Media_luVars={}
HealBot_Media_luVars["Registered"]=false
HealBot_Media_luVars["InitFontsRerun"]=false
HealBot_Media_luVars["DelayUpdateUsedMedia"]=false
HealBot_Media_luVars["pluginMedia"]=false

function HealBot_Media_PluginState(state)
	if HealBot_Media_luVars["pluginMedia"]~=state then
        HealBot_Media_luVars["pluginMedia"]=state
        HealBot_Media_PluginChange()
    end
end

function HealBot_Media_PluginChange()
    HealBot_Media_UpdateIndexes()
    HealBot_Options_ResetUpdate()
    HealBot_Plugin_Media_Summary()
end

function HealBot_Media_Register()
    if not HealBot_Media_luVars["Registered"] and LSM then
        HealBot_Media_luVars["Registered"]=true
        for i = 1, #HealBot_Default_Textures do
            LSM:Register("statusbar", HealBot_Default_Textures[i].name, HealBot_Default_Textures[i].file)
        end
        for i = 1, #HealBot_Default_Sounds do
            LSM:Register("sound", HealBot_Default_Sounds[i].name, HealBot_Default_Sounds[i].file)
        end
        for i = 1, #HealBot_Default_Fonts do
            LSM:Register("font", HealBot_Default_Fonts[i].name, HealBot_Default_Fonts[i].file)
        end
        HealBot_Media_UpdateIndexes()
    end
end

function HealBot_Media_InitFonts(id)
      --HealBot_setCall("HealBot_Media_InitFonts")
    if id<=#HealBot_Fonts then
        local g=_G["UsedToInitFonts"]
        HealBot_Media_UpdateFont(g, HealBot_Fonts[id], 10, 1)
        g:SetText("i"..id)
        C_Timer.After(0.05, function() HealBot_Media_InitFonts(id+1) end)
    elseif not HealBot_Media_luVars["InitFontsRerun"] then
        HealBot_Timers_UpdateUsedMedia("Fonts")
        HealBot_Media_luVars["InitFontsRerun"]=true
        C_Timer.After(3, function() HealBot_Media_InitFonts(1) end)
    else
        HealBot_Timers_UpdateUsedMediaAll()
    end
end

local fontFile=""
function HealBot_Media_UpdateFont(object, font, height, outline)
    object:SetFont(LSM:Fetch('font', font), height, HealBot_Font_Outline[outline])
end

function HealBot_Media_UpdateTexture(object, texture)
    object:SetStatusBarTexture(LSM:Fetch('statusbar', texture))
end

function HealBot_Media_ReturnSound(name)
    return LSM:Fetch('sound',name)
end

local hbSounds={}
hbSounds["TIME"]=0
hbSounds["CALLBACKTIME"]=0
function HealBot_Media_PlaySound(name, channel)
    if hbSounds["TIME"]<HealBot_TimeNow then
        hbSounds["TIME"]=HealBot_TimeNow+0.5
        hbSounds["LASTID"]=name
        PlaySoundFile(LSM:Fetch('sound',name), channel or "SFX")
    elseif name~=hbSounds["LASTID"] and hbSounds["CALLBACKTIME"]<HealBot_TimeNow then
        hbSounds["DELAY"]=0.01+(hbSounds["TIME"]-HealBot_TimeNow)
        hbSounds["CALLBACKTIME"]=HealBot_TimeNow+hbSounds["DELAY"]
        C_Timer.After(hbSounds["DELAY"], function() HealBot_Media_PlaySound(id, channel) end)
    end
end

function HealBot_Media_UpdateIndexes()
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
        HealBot_Textures = HealBot_Plugin_Media_TexturesEnabled()
        HealBot_Fonts = HealBot_Plugin_Media_FontsEnabled()
        HealBot_Sounds = HealBot_Plugin_Media_SoundsEnabled()
    else
        HealBot_Textures = LSM:List('statusbar')
        HealBot_Fonts = LSM:List('font')
        HealBot_Sounds = LSM:List('sound')
    end
    
    for i=1,#HealBot_Textures do
        HealBot_TexturesIndex[HealBot_Textures[i]] = i
    end
    for i=1,#HealBot_Fonts do
        HealBot_FontsIndex[HealBot_Fonts[i]] = i
    end
    for i=1,#HealBot_Sounds do
        HealBot_SoundsIndex[HealBot_Sounds[i]] = i
    end
end

function HealBot_Media_TextureIndex(texture)
    if texture and HealBot_TexturesIndex[texture] then
        return HealBot_TexturesIndex[texture]
    else
        return HealBot_TexturesIndex[HealBot_Default_Texture] or 1
    end
end

function HealBot_Media_TextureName(index)
    if index and HealBot_Textures[index] then
        return HealBot_Textures[index]
    else
        return HealBot_Textures[HealBot_Media_TextureIndex(HealBot_Default_Texture)]
    end
end

function HealBot_Media_TexturesCount()
    return #HealBot_Textures
end

function HealBot_Media_FontIndex(font)
    if font and HealBot_FontsIndex[font] then
        return HealBot_FontsIndex[font]
    else
        return HealBot_FontsIndex[HealBot_Default_Font] or 1
    end
end

function HealBot_Media_FontName(index)
    if index and HealBot_Fonts[index] then
        return HealBot_Fonts[index]
    else
        return HealBot_Fonts[HealBot_Media_FontIndex(HealBot_Default_Font)]
    end
end

function HealBot_Media_FontsCount()
    return #HealBot_Fonts
end

function HealBot_Media_SoundIndex(sound)
    if sound and HealBot_SoundsIndex[sound] then
        return HealBot_SoundsIndex[sound] 
    else
        return HealBot_SoundsIndex[HealBot_Default_Sound] or 1
    end
end

function HealBot_Media_SoundName(index)
    if index and HealBot_Sounds[index] then
        return HealBot_Sounds[index] 
    else
        return HealBot_Sounds[HealBot_Media_SoundIndex(HealBot_Default_Sound)]
    end
end

function HealBot_Media_SoundsCount()
    return #HealBot_Sounds
end

function HealBot_Media_UpdateType(mType, frame, auxId)
      --HealBot_setCall("HealBot_Options_UpdateMedia")
    if mType == "Textures" then
        HealBot_Options_UpdateMediaTexture(HealBot_Options_SkinFrameAliasTextureS,HealBot_TexturesIndex[Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][frame]["TEXTURE"]],true)
        HealBot_Options_UpdateMediaTexture(HealBot_Options_BarTextureS,HealBot_TexturesIndex[Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][frame]["TEXTURE"]],true)
        HealBot_Options_UpdateMediaTexture(HealBot_Options_HeadTextureS,HealBot_TexturesIndex[Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][frame]["TEXTURE"]],true)
        HealBot_Options_UpdateMediaTexture(HealBot_EmergBarTexture, HealBot_TexturesIndex[Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][frame]["TEXTURE"]])
    elseif mType == "Fonts" then
        HealBot_Options_UpdateMediaFont(HealBot_Options_HeadFontNameS,HealBot_FontsIndex[Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][frame]["FONT"]])
        HealBot_Options_UpdateMediaFont(HealBot_Options_AliasFontName,HealBot_FontsIndex[Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][frame]["FONT"]])
        HealBot_Options_UpdateMediaFont(HealBot_Options_HealthFontName,HealBot_FontsIndex[Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][frame]["HFONT"]])
        HealBot_Options_UpdateMediaFont(HealBot_Options_AggroFontName,HealBot_FontsIndex[Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][frame]["AFONT"]])
        HealBot_Options_UpdateMediaFont(HealBot_Options_AuxFontName,HealBot_FontsIndex[Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][auxId][frame]["FONT"]])
        HealBot_Options_UpdateMediaFont(HealBot_Options_StateFontName,HealBot_FontsIndex[Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][frame]["SFONT"]])
        HealBot_Options_UpdateMediaFont(HealBot_Options_ActionIconsFontName,HealBot_FontsIndex[(Healbot_Config_Skins.ActionIcons[Healbot_Config_Skins.Current_Skin][frame]["FONT"] or HealBot_Default_Font)])
        HealBot_Options_UpdateMediaFont(HealBot_Options_ActionIconsFontCountName,HealBot_FontsIndex[(Healbot_Config_Skins.ActionIcons[Healbot_Config_Skins.Current_Skin][frame]["FONTCOUNT"] or HealBot_Default_Font)])
        for z=1,3 do
            HealBot_Options_UpdateMediaFont(HealBot_BarButtonIconBuffFont,HealBot_FontsIndex[Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][frame][z]["BUFFFONT"]])
            HealBot_Options_UpdateMediaFont(HealBot_BarButtonIconFont, HealBot_FontsIndex[Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][frame][z]["DBFONT"]])
        end
        HealBot_Options_UpdateMediaFont(HealBot_Options_FontName, HealBot_FontsIndex[Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][frame]["FONT"]])
    else
        HealBot_Options_val_OnLoad(HealBot_Options_WarningSound,HEALBOT_OPTIONS_SOUND,1,#HealBot_Sounds,1,2)
        HealBot_Options_SetText(HealBot_Options_WarningSound,HEALBOT_OPTIONS_SOUND)
        HealBot_Options_SetSliderValue(HealBot_Options_WarningSound,HealBot_SoundsIndex[HealBot_Config_Cures.SoundDebuffPlay])
        HealBot_Options_val_OnLoad(HealBot_Options_BuffWarningSound,HEALBOT_OPTIONS_SOUND,1,#HealBot_Sounds,1,2)
        HealBot_Options_SetText(HealBot_Options_BuffWarningSound,HEALBOT_OPTIONS_SOUND)
        HealBot_Options_SetSliderValue(HealBot_Options_BuffWarningSound,HealBot_SoundsIndex[HealBot_Config_Buffs.SoundBuffPlay])
    end
end

local function HealBot_Media_UpdateUsedTextures(button)
      --HealBot_setCall("HealBot_Media_UpdateUsedTextures", button)
    HealBot_Media_UpdateTexture(button.gref["Bar"], Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["TEXTURE"])
    HealBot_Media_UpdateTexture(button.gref["InHeal"], Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["TEXTURE"])
    for x=1,9 do
        HealBot_Media_UpdateTexture(button.gref.aux[x], Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["TEXTURE"])
    end
    HealBot_Media_UpdateTexture(button.gref["Absorb"], Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["TEXTURE"])
    button.gref["Bar"]:GetStatusBarTexture():SetHorizTile(false)
    button.gref["InHeal"]:GetStatusBarTexture():SetHorizTile(false)
    for x=1,9 do
        button.gref.aux[x]:GetStatusBarTexture():SetHorizTile(false)
    end
    button.gref["Absorb"]:GetStatusBarTexture():SetHorizTile(false)
    HealBot_Media_UpdateTexture(HealBot_Emerg_Button[button.id].bar, Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][button.frame]["TEXTURE"])
    HealBot_Emerg_Button[button.id].bar:GetStatusBarTexture():SetHorizTile(false)
end

local function HealBot_Media_UpdateUsedButtonText(button)
      --HealBot_setCall("HealBot_Media_UpdateUsedButtonText", button)
    HealBot_Media_UpdateFont(button.gref.txt["text"], 
                             Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["FONT"], 
                             ceil(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HEIGHT"]*
                                  Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][button.frame]["SCALE"]), 
                             Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["OUTLINE"])
    HealBot_Media_UpdateFont(button.gref.txt["text2"], 
                             Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HFONT"], 
                             ceil(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HHEIGHT"]*
                                  Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][button.frame]["SCALE"]), 
                             Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HOUTLINE"])
    HealBot_Media_UpdateFont(button.gref.txt["text3"], 
                             Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["SFONT"], 
                             ceil(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["SHEIGHT"]*
                                  Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][button.frame]["SCALE"]), 
                             Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["SOUTLINE"])
    HealBot_Media_UpdateFont(button.gref.txt["text4"], 
                             Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["AFONT"], 
                             ceil(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["AHEIGHT"]*
                                  Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][button.frame]["SCALE"]), 
                             Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["AOUTLINE"])
    if ceil(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HHEIGHT"]*Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][button.frame]["SCALE"])-HealBot_Globals.VehicleFontSizeReduction<2 then
        HealBot_Media_UpdateFont(button.gref.txt["text5"],
                                 Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HFONT"],
                                 2,
                                 Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HOUTLINE"])

    else
        HealBot_Media_UpdateFont(button.gref.txt["text5"], 
                                 Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HFONT"], 
                                 ceil(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HHEIGHT"]*
                                      Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][button.frame]["SCALE"])-HealBot_Globals.VehicleFontSizeReduction,
                                 Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][button.frame]["HOUTLINE"])
    end
end

local function HealBot_Media_UpdateUsedAuxText(button)
      --HealBot_setCall("HealBot_Media_UpdateUsedAuxText")
    for x=1,9 do
        HealBot_Media_UpdateFont(button.gref.auxtxt[x],
                                 Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][button.frame]["FONT"],
                                 ceil(Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][button.frame]["HEIGHT"]*
                                      Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][button.frame]["SCALE"]),
                                 Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin][x][button.frame]["OUTLINE"])
    end
end

local hbUpdateDelay=0.2
local hbUpdateDelayType={}
local function HealBot_Media_DoUpdateUsedMedia(mediatype)
    if HealBot_retLuVars("ClearReset") then
        if HealBot_Data["UILOCK"] then
            hbUpdateDelay=2
        else
            hbUpdateDelay=0.2
        end
        C_Timer.After(hbUpdateDelay, function() HealBot_Media_UpdateUsedMedia(mediatype, key) end)
    else
        hbUpdateDelayType[mediatype]=false
      --HealBot_setCall("HealBot_Media_DoUpdateUsedMedia")
        if mediatype == "statusbar" then
            if Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin] then
                local hFrames=HealBot_Panel_retHealBot_Header_Frames()
                for _,h in pairs(hFrames) do
                    if h["GetName"] then
                        local bar = _G[h:GetName().."Bar"]
                        if bar then
                            HealBot_Media_UpdateTexture(bar, Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][h.frame]["TEXTURE"])
                            bar:GetStatusBarTexture():SetHorizTile(false)
                        end
                    end
                end
            end
            if Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin] then 
                for _,xButton in pairs(HealBot_Unit_Button) do
                    HealBot_Media_UpdateUsedTextures(xButton)
                end
                for _,xButton in pairs(HealBot_Private_Button) do
                    HealBot_Media_UpdateUsedTextures(xButton)
                end 
                for _,xButton in pairs(HealBot_Pet_Button) do
                    HealBot_Media_UpdateUsedTextures(xButton)
                end 
                for _,xButton in pairs(HealBot_Vehicle_Button) do
                    HealBot_Media_UpdateUsedTextures(xButton)
                end 
                for _,xButton in pairs(HealBot_Enemy_Button) do
                    HealBot_Media_UpdateUsedTextures(xButton)
                end 
                for _,xButton in pairs(HealBot_Extra_Button) do
                    HealBot_Media_UpdateUsedTextures(xButton)
                end 
            end
        elseif mediatype == "font" then
            if Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin] then
                local hFrames=HealBot_Panel_retHealBot_Header_Frames()
                for _,h in pairs(hFrames) do
                    if h["GetName"] then
                        local bar = _G[h:GetName().."Bar_text"]
                        if bar then
                            HealBot_Media_UpdateFont(bar, 
                                                     Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][h.frame]["FONT"], 
                                                     Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][h.frame]["HEIGHT"],
                                                     Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][h.frame]["OUTLINE"])
                        end
                    end
                end
            end
            if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin] then
                for _,xButton in pairs(HealBot_Unit_Button) do
                    HealBot_Media_UpdateUsedButtonText(xButton)
                end
                for _,xButton in pairs(HealBot_Private_Button) do
                    HealBot_Media_UpdateUsedButtonText(xButton)
                end      
                for _,xButton in pairs(HealBot_Pet_Button) do
                    HealBot_Media_UpdateUsedButtonText(xButton)
                end 
                for _,xButton in pairs(HealBot_Vehicle_Button) do
                    HealBot_Media_UpdateUsedButtonText(xButton)
                end 
                for _,xButton in pairs(HealBot_Enemy_Button) do
                    HealBot_Media_UpdateUsedButtonText(xButton)
                end 
                for _,xButton in pairs(HealBot_Extra_Button) do
                    HealBot_Media_UpdateUsedButtonText(xButton)
                end
            end
            if Healbot_Config_Skins.AuxBarText[Healbot_Config_Skins.Current_Skin] then
                for _,xButton in pairs(HealBot_Unit_Button) do
                    HealBot_Media_UpdateUsedAuxText(xButton)
                end
                for _,xButton in pairs(HealBot_Private_Button) do
                    HealBot_Media_UpdateUsedAuxText(xButton)
                end
                for _,xButton in pairs(HealBot_Enemy_Button) do
                    HealBot_Media_UpdateUsedAuxText(xButton)
                end
                for _,xButton in pairs(HealBot_Pet_Button) do
                    HealBot_Media_UpdateUsedAuxText(xButton)
                end
                for _,xButton in pairs(HealBot_Vehicle_Button) do
                    HealBot_Media_UpdateUsedAuxText(xButton)
                end
                for _,xButton in pairs(HealBot_Extra_Button) do
                    HealBot_Media_UpdateUsedAuxText(xButton)
                end
            end
        end
    end
end

function HealBot_Media_UpdateUsedMedia(mediatype, key)
      --HealBot_setCall("HealBot_Media_UpdateUsedMedia")
    if not hbUpdateDelayType[mediatype] then
        hbUpdateDelayType[mediatype]=true
        C_Timer.After(0.1, function() HealBot_Media_DoUpdateUsedMedia(mediatype, key) end)
    end
end
