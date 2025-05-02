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
HealBot_Media_luVars["DelayUpdateUsedMedia"]=false
HealBot_Media_luVars["pluginMedia"]=false

local HealBot_Font_Outline={
    [1]="",
    [2]="OUTLINE",
    [3]="THICKOUTLINE",
}

local roleTextures={}
local classTextures={}
local rankTextures={}
local targetTextures={}
local currentSet={["CLASS"]=0, ["ROLE"]=0, ["RANK"]=0, ["TARGET"]=0, }
function HealBot_Media_setClassRoleIcons()
    local iSet=hbv_Skins_GetVar("IconSet", "CLASS")
    classTextures["DEAT"]="Interface\\Addons\\HealBot\\Images\\class\\" .. iSet .. "\\Deathknight.tga"
    classTextures["DEMO"]="Interface\\Addons\\HealBot\\Images\\class\\" .. iSet .. "\\Demonhunter.tga"
    classTextures["DRUI"]="Interface\\Addons\\HealBot\\Images\\class\\" .. iSet .. "\\Druid.tga"
    classTextures["HUNT"]="Interface\\Addons\\HealBot\\Images\\class\\" .. iSet .. "\\Hunter.tga"
    classTextures["MAGE"]="Interface\\Addons\\HealBot\\Images\\class\\" .. iSet .. "\\Mage.tga"
    classTextures["MONK"]="Interface\\Addons\\HealBot\\Images\\class\\" .. iSet .. "\\Monk.tga"
    classTextures["PALA"]="Interface\\Addons\\HealBot\\Images\\class\\" .. iSet .. "\\Paladin.tga"
    classTextures["PRIE"]="Interface\\Addons\\HealBot\\Images\\class\\" .. iSet .. "\\Priest.tga"
    classTextures["ROGU"]="Interface\\Addons\\HealBot\\Images\\class\\" .. iSet .. "\\Rogue.tga"
    classTextures["SHAM"]="Interface\\Addons\\HealBot\\Images\\class\\" .. iSet .. "\\Shaman.tga"
    classTextures["WARL"]="Interface\\Addons\\HealBot\\Images\\class\\" .. iSet .. "\\Warlock.tga"
    classTextures["WARR"]="Interface\\Addons\\HealBot\\Images\\class\\" .. iSet .. "\\Warrior.tga"
    classTextures["EVOK"]="Interface\\Addons\\HealBot\\Images\\class\\" .. iSet .. "\\Evoker.tga"
    if currentSet["CLASS"] ~= iSet then
        HealBot_IconClassRole_UpdateIcons()
        HealBot_Timers_Set("AURA","ResetClassIconTexture",true)
        currentSet["CLASS"]=iSet
    end
    
    iSet=hbv_Skins_GetVar("IconSet", "ROLE")
    roleTextures["DAMAGER"]="Interface\\Addons\\HealBot\\Images\\role\\" .. iSet .. "\\dps.tga"
    roleTextures["TANK"]="Interface\\Addons\\HealBot\\Images\\role\\" .. iSet .. "\\tank.tga"
    roleTextures["HEALER"]="Interface\\Addons\\HealBot\\Images\\role\\" .. iSet .. "\\healer.tga"
    if currentSet["ROLE"] ~= iSet then
        HealBot_IconClassRole_UpdateIcons()
        HealBot_Timers_Set("AURA","ResetClassIconTexture",true)
        currentSet["ROLE"]=iSet
    end
end

function HealBot_Media_setRankIcons()
    local iSet=hbv_Skins_GetVar("IconSet", "RANK")
    rankTextures[1]="Interface\\Addons\\HealBot\\Images\\rank\\" .. iSet .. "\\leader.tga"
    rankTextures[2]="Interface\\Addons\\HealBot\\Images\\rank\\" .. iSet .. "\\assist.tga"
    rankTextures[3]="Interface\\Addons\\HealBot\\Images\\rank\\" .. iSet .. "\\looter.tga"
    rankTextures[4]="Interface\\Addons\\HealBot\\Images\\rank\\" .. iSet .. "\\leader.tga"
    rankTextures[5]="Interface\\Addons\\HealBot\\Images\\rank\\" .. iSet .. "\\tank.tga"
    if currentSet["RANK"] ~= iSet then
        HealBot_IconRank_UpdateIcons()
        HealBot_Timers_Set("AURA","IconUpdAllRank",true)
        currentSet["RANK"]=iSet
    end
end

function HealBot_Media_setTargetIcons()
    local iSet=hbv_Skins_GetVar("IconSet", "TARGET")
    targetTextures[1]="Interface\\Addons\\HealBot\\Images\\target\\" .. iSet .. "\\Star.tga"
    targetTextures[2]="Interface\\Addons\\HealBot\\Images\\target\\" .. iSet .. "\\Circle.tga"
    targetTextures[3]="Interface\\Addons\\HealBot\\Images\\target\\" .. iSet .. "\\Diamond.tga"
    targetTextures[4]="Interface\\Addons\\HealBot\\Images\\target\\" .. iSet .. "\\Triangle.tga"
    targetTextures[5]="Interface\\Addons\\HealBot\\Images\\target\\" .. iSet .. "\\Moon.tga"
    targetTextures[6]="Interface\\Addons\\HealBot\\Images\\target\\" .. iSet .. "\\Square.tga"
    targetTextures[7]="Interface\\Addons\\HealBot\\Images\\target\\" .. iSet .. "\\Cross.tga"
    targetTextures[8]="Interface\\Addons\\HealBot\\Images\\target\\" .. iSet .. "\\Skull.tga"
    if currentSet["TARGET"] ~= iSet then
        HealBot_IconTarget_UpdateIcons()
        HealBot_Timers_Set("SKINS","IconUpdAllTarget",true)
        currentSet["TARGET"]=iSet
    end
end

function HealBot_Media_retClassRoleIcon(id)
      --HealBot_setCall("HealBot_Media_retClassRoleIcon")
    return classTextures[id] or roleTextures[id] or false
end

function HealBot_Media_retRankIcon(id)
    return rankTextures[id]
end

function HealBot_Media_retTargetIcon(id)
    return targetTextures[id]
end

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
    HealBot_Default_Texture=hbv_Default_TextureFile()
    HealBot_Default_TextureName=hbv_Default_TextureName()
    HealBot_Default_Font=hbv_Default_FontFile()
    HealBot_Default_FontName=hbv_Default_FontName()
    HealBot_Default_Sound=hbv_Default_SoundFile()
    HealBot_Default_SoundName=hbv_Default_SoundName()
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
    if HealBot_Fonts then
        if id<=#HealBot_Fonts then
            local g=_G["UsedToInitFonts"]
            g:SetFont(LSM:Fetch('font', HealBot_Fonts[id]), 10, HealBot_Font_Outline[1])
            g:SetText("i"..id)
            C_Timer.After(0.1, function() HealBot_Media_SetFonts(id+1) end)
        end
    else
        HealBot_Media_UpdateIndexes()
        C_Timer.After(1, function() HealBot_Media_SetFonts(1) end)
    end
end

function HealBot_Media_InitFonts()
    if not HealBot_Media_luVars["InitFonts"] then
        HealBot_Media_luVars["InitFonts"]=true
        C_Timer.After(1, function() HealBot_Media_SetFonts(1) end)
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
local hbSoundChan={[1]="Master",[2]="SFX",[3]="Ambience",[4]="Dialog"}
function HealBot_Media_PlaySound(name, channel)
    if not hbSounds[name] then hbSounds[name]=0 end
    if hbSounds[name]<HealBot_TimeNow then
        if hbSounds["TimeNextPlay"]<HealBot_TimeNow then
            hbSounds[name]=HealBot_TimeNow+1
            hbSounds["TimeNextPlay"]=HealBot_TimeNow+0.25
            PlaySoundFile(LSM:Fetch('sound',name), hbSoundChan[channel])
        elseif hbSounds["TimeCallback"]<HealBot_TimeNow then
            hbSounds["TimeCallback"]=0.02+(hbSounds["TimeNextPlay"]-HealBot_TimeNow)
            C_Timer.After(hbSounds["TimeCallback"], function() HealBot_Media_PlaySound(name, channel) end)
        end
    end
end

function HealBot_Media_UpdateIndexes(callback)
    if not LSM then
        HealBot_Media_Register()
        if not callback then
            HealBot_Media_UpdateIndexes(true)
        end
    end
    if LSM then
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
    else
        C_Timer.After(1, HealBot_Media_UpdateIndexes)
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
            HealBot_Options_UpdateMediaTexture(HealBot_Options_SkinFrameAliasTextureS,hbv_Skins_GetFrameVar("FrameAliasBar", "TEXTURE", frame))
            HealBot_Options_UpdateMediaTexture(HealBot_Options_BarTextureS,hbv_Skins_GetFrameVar("HealBar", "TEXTURE", frame))
            HealBot_Options_UpdateMediaTexture(HealBot_Options_HeadTextureS,hbv_Skins_GetFrameVar("HeadBar", "TEXTURE", frame))
            HealBot_Options_UpdateMediaTexture(HealBot_EmergBarTexture, hbv_Skins_GetFrameVar("Emerg", "TEXTURE", frame))
        elseif mType == "Fonts" then
            HealBot_Options_UpdateMediaFont(HealBot_Options_HeadFontNameS,hbv_Skins_GetFrameVar("HeadText", "FONT", frame))
            HealBot_Options_UpdateMediaFont(HealBot_Options_AliasFontName,hbv_Skins_GetFrameVar("FrameAlias", "FONT", frame))
            HealBot_Options_UpdateMediaFont(HealBot_Options_HealthFontName,hbv_Skins_GetFrameVar("BarText", "HFONT", frame))
            HealBot_Options_UpdateMediaFont(HealBot_Options_AggroFontName,hbv_Skins_GetFrameVar("BarText", "AFONT", frame))
            HealBot_Options_UpdateMediaFont(HealBot_Options_AuxFontName,hbv_Aux_GetBarTextVar("FONT", frame, auxId))
            HealBot_Options_UpdateMediaFont(HealBot_Options_StateFontName,hbv_Skins_GetFrameVar("BarText", "SFONT", frame))
            HealBot_Options_UpdateMediaFont(HealBot_Options_ActionIconsFontName,hbv_ActionIcons_GetVars("FONT", frame))
            HealBot_Options_UpdateMediaFont(HealBot_Options_ActionIconsFontCountName,hbv_ActionIcons_GetVars("FONTCOUNT", frame))
            for z=1,3 do
                HealBot_Options_UpdateMediaFont(HealBot_BarButtonIconBuffFont,hbv_Skins_GetIconTextVar("BUFFFONT", frame, z))
                HealBot_Options_UpdateMediaFont(HealBot_BarButtonIconFont, hbv_Skins_GetIconTextVar("DBFONT", frame, z))
            end
            HealBot_Options_UpdateMediaFont(HealBot_Options_FontName, hbv_Skins_GetFrameVar("BarText", "FONT", frame))
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
    HealBot_Media_UpdateTexture(button.gref["Bar"], hbv_Skins_GetFrameVar("HealBar", "TEXTURE", button.frame), "Media_UpdateUsedTextures - HealBar")
    HealBot_Media_UpdateTexture(button.gref["InHeal"], hbv_Skins_GetFrameVar("HealBar", "TEXTURE", button.frame), "Media_UpdateUsedTextures - HealBar")
    for x=1,9 do
        HealBot_Media_UpdateTexture(button.gref.aux[x], hbv_Skins_GetFrameVar("HealBar", "TEXTURE", button.frame), "Media_UpdateUsedTextures - HealBar")
    end
    HealBot_Media_UpdateTexture(button.gref["Absorb"], hbv_Skins_GetFrameVar("HealBar", "TEXTURE", button.frame), "Media_UpdateUsedTextures - HealBar")
    button.gref["Bar"]:GetStatusBarTexture():SetHorizTile(false)
    button.gref["InHeal"]:GetStatusBarTexture():SetHorizTile(false)
    for x=1,9 do
        button.gref.aux[x]:GetStatusBarTexture():SetHorizTile(false)
    end
    button.gref["Absorb"]:GetStatusBarTexture():SetHorizTile(false)
    HealBot_Media_UpdateTexture(HealBot_Emerg_Button[button.id].bar, hbv_Skins_GetFrameVar("Emerg", "TEXTURE", button.frame), "Media_UpdateUsedTextures - Emerg")
    HealBot_Emerg_Button[button.id].bar:GetStatusBarTexture():SetHorizTile(false)
end

local function HealBot_Media_UpdateUsedButtonText(button)
      --HealBot_setCall("HealBot_Media_UpdateUsedButtonText", button)
    HealBot_Media_UpdateFont(button.gref.txt["text"], 
                             hbv_Skins_GetFrameVar("BarText", "FONT", button.frame), 
                             ceil(hbv_Skins_GetFrameVar("BarText", "HEIGHT", button.frame)*hbv_Skins_GetFrameVar("Frame", "SCALE", button.frame)), 
                             hbv_Skins_GetFrameVar("BarText", "OUTLINE", button.frame),
                             "Media_UpdateUsedButtonText - BarText")
    HealBot_Media_UpdateFont(button.gref.txt["text2"], 
                             hbv_Skins_GetFrameVar("BarText", "HFONT", button.frame), 
                             ceil(hbv_Skins_GetFrameVar("BarText", "HHEIGHT", button.frame)*hbv_Skins_GetFrameVar("Frame", "SCALE", button.frame)), 
                             hbv_Skins_GetFrameVar("BarText", "HOUTLINE", button.frame),
                             "Media_UpdateUsedButtonText - BarText")
    HealBot_Media_UpdateFont(button.gref.txt["text3"], 
                             hbv_Skins_GetFrameVar("BarText", "SFONT", button.frame), 
                             ceil(hbv_Skins_GetFrameVar("BarText", "SHEIGHT", button.frame)*hbv_Skins_GetFrameVar("Frame", "SCALE", button.frame)), 
                             hbv_Skins_GetFrameVar("BarText", "SOUTLINE", button.frame),
                             "Media_UpdateUsedButtonText - BarText")
    HealBot_Media_UpdateFont(button.gref.txt["text4"], 
                             hbv_Skins_GetFrameVar("BarText", "AFONT", button.frame), 
                             ceil(hbv_Skins_GetFrameVar("BarText", "AHEIGHT", button.frame)*hbv_Skins_GetFrameVar("Frame", "SCALE", button.frame)), 
                             hbv_Skins_GetFrameVar("BarText", "AOUTLINE", button.frame),
                             "Media_UpdateUsedButtonText - BarText")
    if ceil(hbv_Skins_GetFrameVar("BarText", "HHEIGHT", button.frame)*hbv_Skins_GetFrameVar("Frame", "SCALE", button.frame))-HealBot_Globals.VehicleFontSizeReduction<2 then
        HealBot_Media_UpdateFont(button.gref.txt["text5"],
                                 hbv_Skins_GetFrameVar("Frame", "HFONT", button.frame),
                                 2,
                                 hbv_Skins_GetFrameVar("Frame", "HOUTLINE", button.frame),
                                 "Media_UpdateUsedButtonText - BarText")

    else
        HealBot_Media_UpdateFont(button.gref.txt["text5"], 
                                 hbv_Skins_GetFrameVar("Frame", "HFONT", button.frame), 
                                 ceil(hbv_Skins_GetFrameVar("BarText", "HHEIGHT", button.frame)*hbv_Skins_GetFrameVar("Frame", "SCALE", button.frame))-HealBot_Globals.VehicleFontSizeReduction,
                                 hbv_Skins_GetFrameVar("BarText", "HOUTLINE", button.frame),
                                 "Media_UpdateUsedButtonText - BarText")
    end
end

local function HealBot_Media_UpdateUsedAuxText(button)
      --HealBot_setCall("HealBot_Media_UpdateUsedAuxText")
    for x=1,9 do
        HealBot_Media_UpdateFont(button.gref.auxtxt[x],
                                 hbv_Aux_GetBarTextVar("FONT", button.frame, x),
                                 ceil(hbv_Aux_GetBarTextVar("HEIGHT", button.frame, x)*
                                      hbv_Skins_GetFrameVar("Frame", "SCALE", button.frame)),
                                 hbv_Aux_GetBarTextVar("OUTLINE", button.frame, x),
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
                        HealBot_Media_UpdateTexture(bar, hbv_Skins_GetFrameVar("HeadBar", "TEXTURE", frame), "Media_DoUpdateUsedMedia - HeadBar")
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
                                                 hbv_Skins_GetFrameVar("HeadText", "FONT", frame),
                                                 hbv_Skins_GetFrameVar("HeadText", "HEIGHT", frame),
                                                 hbv_Skins_GetFrameVar("HeadText", "OUTLINE", frame),
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
