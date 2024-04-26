local LSM = HealBot_Libs_LSM()
local hbMediaRegister={}
local HealBot_Bar_Textures=nil
local HealBot_Fonts=nil
local HealBot_Bar_TexturesIndex={}
local HealBot_FontsIndex={}
local HealBot_Sounds=nil
local HealBot_SoundsIndex={}
local HealBot_Media_luVars={}
HealBot_Media_luVars["Registered"]=false
HealBot_Media_luVars["InitFontsRerun"]=false
HealBot_Media_luVars["DelayUpdateUsedMedia"]=false

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
function HealBot_Media_UpdateFont(object, font, height, outline, callback)
    object:SetFont(LSM:Fetch('font', font), height, HealBot_Font_Outline[outline])
end

function HealBot_Media_UpdateTexture(object, texture)
    object:SetStatusBarTexture(LSM:Fetch('statusbar', texture))
end

function HealBot_Media_ReturnSound(name)
    return LSM:Fetch('sound',name)
end

function HealBot_Media_PlaySound(name)
    PlaySoundFile(LSM:Fetch('sound',name))
end

function HealBot_Media_UpdateIndexes()
    HealBot_Bar_Textures = LSM:List('statusbar');
    for x,_ in pairs(HealBot_Bar_TexturesIndex) do
        HealBot_Bar_TexturesIndex[x]=nil
    end 
    for i=1,#HealBot_Bar_Textures do
        HealBot_Bar_TexturesIndex[HealBot_Bar_Textures[i]] = i
    end
    HealBot_Fonts = LSM:List('font');
    for x,_ in pairs(HealBot_FontsIndex) do
        HealBot_FontsIndex[x]=nil
    end 
    for i=1,#HealBot_Fonts do
        HealBot_FontsIndex[HealBot_Fonts[i]] = i
    end
    HealBot_Sounds = LSM:List('sound');
    for x,_ in pairs(HealBot_SoundsIndex) do
        HealBot_SoundsIndex[x]=nil
    end 
    for i=1,#HealBot_Sounds do
        HealBot_SoundsIndex[HealBot_Sounds[i]] = i
    end
end

function HealBot_Media_ReturnTextureIndex(texture)
    return HealBot_Bar_TexturesIndex[texture] or HealBot_Bar_TexturesIndex[HealBot_Default_Textures[20].name] or 1
end

function HealBot_Media_ReturnTextureName(index)
    return HealBot_Bar_Textures[index] or HealBot_Bar_Textures[HealBot_Media_ReturnTextureIndex(HealBot_Default_Textures[20].name)]
end

function HealBot_Media_ReturnTextureCount()
    return #HealBot_Bar_Textures
end

function HealBot_Media_ReturnFontsIndex(font)
    return HealBot_FontsIndex[font] or HealBot_FontsIndex[HealBot_Default_Fonts[15].name] or 1
end

function HealBot_Media_ReturnFontsName(index)
    return HealBot_Fonts[index] or HealBot_Fonts[HealBot_Media_ReturnTextureIndex(HealBot_Default_Fonts[15].name)]
end

function HealBot_Media_ReturnFontsCount()
    return #HealBot_Fonts
end

function HealBot_Media_ReturnSoundsIndex(sound)
    return HealBot_SoundsIndex[sound] or HealBot_SoundsIndex[HealBot_Default_Sounds[1].name] or 1
end

function HealBot_Media_ReturnSoundsName(index)
    return HealBot_Sounds[index] or HealBot_Sounds[HealBot_Media_ReturnTextureIndex(HealBot_Default_Sounds[1].name)]
end

function HealBot_Media_ReturnSoundsCount()
    return #HealBot_Sounds
end

function HealBot_Media_UpdateType(mType, frame, auxId)
      --HealBot_setCall("HealBot_Options_UpdateMedia")
    if mType == "Textures" then
        HealBot_Options_UpdateMediaTexture(HealBot_Options_SkinFrameAliasTextureS,HealBot_Bar_TexturesIndex[Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][frame]["TEXTURE"]],true)
        HealBot_Options_UpdateMediaTexture(HealBot_Options_BarTextureS,HealBot_Bar_TexturesIndex[Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][frame]["TEXTURE"]],true)
        HealBot_Options_UpdateMediaTexture(HealBot_Options_HeadTextureS,HealBot_Bar_TexturesIndex[Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][frame]["TEXTURE"]],true)
        HealBot_Options_UpdateMediaTexture(HealBot_EmergBarTexture, HealBot_Bar_TexturesIndex[Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][frame]["TEXTURE"]])
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
    button.gref["Bar"]:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["TEXTURE"]));
    button.gref["InHeal"]:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["TEXTURE"]));
    for x=1,9 do
        button.gref.aux[x]:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["TEXTURE"]))
    end
    button.gref["Absorb"]:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][button.frame]["TEXTURE"]));
    button.gref["Bar"]:GetStatusBarTexture():SetHorizTile(false)
    button.gref["InHeal"]:GetStatusBarTexture():SetHorizTile(false)
    for x=1,9 do
        button.gref.aux[x]:GetStatusBarTexture():SetHorizTile(false)
    end
    button.gref["Absorb"]:GetStatusBarTexture():SetHorizTile(false)
    HealBot_Emerg_Button[button.id].bar:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.Emerg[Healbot_Config_Skins.Current_Skin][button.frame]["TEXTURE"]));
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
function HealBot_Media_DoUpdateUsedMedia(mediatype)
    if HealBot_retLuVars("ClearReset") then
        if HealBot_Data["UILOCK"] then
            hbUpdateDelay=2
        else
            hbUpdateDelay=0.2
        end
        C_Timer.After(hbUpdateDelay, function() hbUpdateDelayType[mediatype]=false; HealBot_Media_UpdateUsedMedia(mediatype, key) end)
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
                            bar:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][h.frame]["TEXTURE"]));
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
        C_Timer.After(0.05, function() HealBot_Media_DoUpdateUsedMedia(mediatype, key) end)
    end
end
