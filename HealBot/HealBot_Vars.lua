-- Default Media
function hbv_Default_TextureFile()
    return 'Interface\\Addons\\HealBot\\Images\\textures\\Smoothv2.tga'
end

function hbv_Default_TextureName()
    return "Smooth v2"
end

function hbv_Default_SoundFile()
    return 566558
end

function hbv_Default_SoundName()
    return "Elf Bell Toll"
end

function hbv_Default_FontFile()
    return [[Interface\AddOns\HealBot\Fonts\Roboto-Medium.ttf]]
end

function hbv_Default_FontName()
    return "Roboto Medium"
end

-- Skin Default
function hbv_SkinDefault_GetData(skin, id)
    if HealBot_Config.SkinDefault[skin] then
        return HealBot_Config.SkinDefault[skin][id] or false
    end
    return false
end

function hbv_SkinDefault_SetData(value, skin, id)
    if value == false then
        hbv_SkinDefault_NilData(skin, id)
    else
        if not HealBot_Config.SkinDefault[skin] then HealBot_Config.SkinDefault[skin]={} end
        HealBot_Config.SkinDefault[skin][id]=value
    end
end

function hbv_SkinDefault_NilData(skin, id)
    HealBot_Config.SkinDefault[skin][id]=nil
end

-- Vardefaults
local sVars={["cBuff"]=HEALBOT_CUSTOM_en.."Buff",
             ["cDebuff"]=HEALBOT_CUSTOM_en.."15",
             ["rcWAITING"]=0,
             ["rcREADY"]=1,
             ["rcNOTREADY"]=2,}
function hbv_GetStatic(name)
    return sVars[name]
end

-- UnitType
local hbUnitTypes={[HEALBOT_TANK]=1,
                   [HEALBOT_HEALER]=2,
                   [HEALBOT_SELF]=3,
                   [HEALBOT_PRIVATELIST]=4,
                   [HEALBOT_PRIVATEFOCUS]=5,
                   [HEALBOT_RAID]=11,
                   [HEALBOT_GROUP]=12,
                   [HEALBOT_VEHICLE]=21,
                   [HEALBOT_PET]=22,
                   [HEALBOT_TARGET]=31,
                   [HEALBOT_TOT]=32,
                   [HEALBOT_TOF]=33,
                   [HEALBOT_PRIVFOCUSTOT]=8,
                   [HEALBOT_FOCUS]=38,
                   [HEALBOT_ENEMY]=41,
                   [HEALBOT_PLAYERTARGET]=42,
                   [HEALBOT_PRIVATETARGET]=43,}
                   
function hbv_GetUnitType(uType)
    return hbUnitTypes[uType]
end       
            
function hbv_IsUnitType(uType, tType)
    if uType == hbUnitTypes[tType] then
        return true
    end
    return false
end
            
function hbv_IsNotUnitType(uType, tType)
    if uType ~= hbUnitTypes[tType] then
        return true
    end
    return false
end

-- Class
local hbClass={}
function hbv_SetClass()
    hbClass["En"]={
                    [HEALBOT_CLASSES_ALL]="ALL",
                    [HEALBOT_DRUID]="DRUI",
                    [HEALBOT_HUNTER]="HUNT",
                    [HEALBOT_MAGE]="MAGE",
                    [HEALBOT_PALADIN]="PALA",
                    [HEALBOT_PRIEST]="PRIE",
                    [HEALBOT_ROGUE]="ROGU",
                    [HEALBOT_SHAMAN]="SHAM",
                    [HEALBOT_WARLOCK]="WARL",
                    [HEALBOT_WARRIOR]="WARR",
                    [HEALBOT_EVOKER]="EVOK",
                    [HEALBOT_DEATHKNIGHT]="DEAT",
                    [HEALBOT_MONK]="MONK",
                    [HEALBOT_DEMONHUNTER]="DEMO",
    }
    hbClass["Disc"]={
                    ["ALL"]=HEALBOT_CLASSES_ALL,
                    ["DRUI"]=HEALBOT_DRUID,
                    ["HUNT"]=HEALBOT_HUNTER,
                    ["MAGE"]=HEALBOT_MAGE,
                    ["PALA"]=HEALBOT_PALADIN,
                    ["PRIE"]=HEALBOT_PRIEST,
                    ["ROGU"]=HEALBOT_ROGUE,
                    ["SHAM"]=HEALBOT_SHAMAN,
                    ["WARL"]=HEALBOT_WARLOCK,
                    ["WARR"]=HEALBOT_WARRIOR,
                    ["EVOK"]=HEALBOT_EVOKER,
                    ["DEAT"]=HEALBOT_DEATHKNIGHT,
                    ["MONK"]=HEALBOT_MONK,
                    ["DEMO"]=HEALBOT_DEMONHUNTER,
    }
end
hbv_SetClass()
function hbv_GetClass(ctype, key)
    return hbClass[ctype][key] or "ALL"
end

-- Aux

local hbAuxBarDefaults={["COLOUR"]=1, ["ANCHOR"]=1, ["OFFSET"]=1, 
                        ["DEPTH"]=5, ["SIZE"]=1, ["USE"]=1,
                        ["R"]=1, ["G"]=1, ["B"]=1, ["A"]=1,
                        ["OTYPE"]=1, ["TEXT"]=false,
                        ["MANAONLY"]=false, ["HEALERSMANAONLY"]=false,
                       }

function hbv_Aux_BarHasDefault(key)
    if hbAuxBarDefaults[key] or hbAuxBarDefaults[key] == false then
        return true
    else
        return false
    end
end

function hbv_Aux_GetBarBoolean(key, frame, id)
    if Healbot_Config_Aux.Bar[Healbot_Config_Skins.Current_Skin][frame] and Healbot_Config_Aux.Bar[Healbot_Config_Skins.Current_Skin][frame][id] then
        if Healbot_Config_Aux.Bar[Healbot_Config_Skins.Current_Skin][frame][id][key] == false then
            return false
        else
            return Healbot_Config_Aux.Bar[Healbot_Config_Skins.Current_Skin][frame][id][key] or hbAuxBarDefaults[key]
        end
    end
    return hbAuxBarDefaults[key]
end

function hbv_Aux_GetBarVar(key, frame, id)
    if Healbot_Config_Aux.Bar[Healbot_Config_Skins.Current_Skin][frame] and Healbot_Config_Aux.Bar[Healbot_Config_Skins.Current_Skin][frame][id] then
        return Healbot_Config_Aux.Bar[Healbot_Config_Skins.Current_Skin][frame][id][key] or hbAuxBarDefaults[key]
    end
    return hbAuxBarDefaults[key]
end

function hbv_Aux_GetBarSkin(skin, key, frame, id)
    if Healbot_Config_Aux.Bar[skin][frame] and Healbot_Config_Aux.Bar[skin][frame][id] then
        return Healbot_Config_Aux.Bar[skin][frame][id][key] or hbAuxBarDefaults[key]
    end
    return hbAuxBarDefaults[key]
end

function hbv_Aux_SetBarSkin(value, skin, key, frame, id)
    if hbAuxBarDefaults[key] == value then
        hbv_Aux_NilBarSkin(skin, key, frame, id)
    else
        if not Healbot_Config_Aux.Bar[skin][frame] then Healbot_Config_Aux.Bar[skin][frame]={} end
        if not Healbot_Config_Aux.Bar[skin][frame][id] then Healbot_Config_Aux.Bar[skin][frame][id]={} end
        Healbot_Config_Aux.Bar[skin][frame][id][key]=value
    end
end

function hbv_Data_AuxSetBarVar(value, key, frame, id)
    hbv_Aux_SetBarSkin(value, Healbot_Config_Skins.Current_Skin, key, frame, id)
end

function hbv_Aux_NilBarSkin(skin, key, frame, id)
    if Healbot_Config_Aux.Bar[skin][frame] and Healbot_Config_Aux.Bar[skin][frame][id] then
        Healbot_Config_Aux.Bar[skin][frame][id][key]=nil
        HealBot_Util_EmptyTable(Healbot_Config_Aux.Bar[skin][frame], id)
        if not Healbot_Config_Aux.Bar[skin][frame][id] then
            HealBot_Util_EmptyTable(Healbot_Config_Aux.Bar[skin], frame)
        end
    end
end

local hbAuxBarTextDefaults={["FONT"]=hbv_Default_FontName(),
                            ["HEIGHT"]=9, ["OUTLINE"]=1, ["MAXCHARS"]=0,
                            ["OFFSET"]=0, ["HOFFSET"]=0, ["ALIGN"]=2,
                            ["COLR"]=1, ["COLG"]=1, ["COLB"]=1,
                            ["COLTYPE"]=1, ["COLDA"]=0.5, ["COLOA"]=0.75, ["COLA"]=1,
                           }

function hbv_Aux_BarTextHasDefault(key)
    if hbAuxBarTextDefaults[key] or hbAuxBarTextDefaults[key] == false then
        return true
    else
        return false
    end
end

function hbv_Aux_GetBarTextVar(key, frame, id)
    if Healbot_Config_Aux.BarText[Healbot_Config_Skins.Current_Skin][frame] and Healbot_Config_Aux.BarText[Healbot_Config_Skins.Current_Skin][frame][id] then
        return Healbot_Config_Aux.BarText[Healbot_Config_Skins.Current_Skin][frame][id][key] or hbAuxBarTextDefaults[key]
    end
    return hbAuxBarTextDefaults[key]
end

function hbv_Aux_SetBarTextSkin(value, skin, key, frame, id)
    if hbAuxBarTextDefaults[key] == value then
        hbv_Aux_NilBarTextSkin(skin, key, frame, id)
    else
        if not Healbot_Config_Aux.BarText[skin][frame] then Healbot_Config_Aux.BarText[skin][frame]={} end
        if not Healbot_Config_Aux.BarText[skin][frame][id] then Healbot_Config_Aux.BarText[skin][frame][id]={} end
        Healbot_Config_Aux.BarText[skin][frame][id][key]=value
    end
end

function hbv_Aux_SetBarTextVar(value, key, frame, id)
    hbv_Aux_SetBarTextSkin(value, Healbot_Config_Skins.Current_Skin, key, frame, id)
end

function hbv_Aux_NilBarTextSkin(skin, key, frame, id)
    if Healbot_Config_Aux.BarText[skin][frame] and Healbot_Config_Aux.BarText[skin][frame][id] then
        Healbot_Config_Aux.BarText[skin][frame][id][key]=nil
        HealBot_Util_EmptyTable(Healbot_Config_Aux.BarText[skin][frame], id)
        if not Healbot_Config_Aux.BarText[skin][frame][id] then
            HealBot_Util_EmptyTable(Healbot_Config_Aux.BarText[skin], frame)
        end
    end
end

local hbAuxOverlayDefaults={["OVERLAP"]=1,
                            ["OVERLAYBUFF"]=false, ["OVERLAYOOR"]=false, 
                            ["OVERLAYTARGET"]=false, ["OVERLAYHIGHLIGHT"]=false, 
                            ["OVERLAYDEBUFF"]=false, ["OVERLAYAGGRO"]=false, 
                            ["OVERLAYHEALTHDROP"]=false, ["OVERLAYRECENTHEALS"]=false, 
                           }

function hbv_Aux_OverlayHasDefault(key)
    if hbAuxOverlayDefaults[key] or hbAuxOverlayDefaults[key] == false then
        return true
    else
        return false
    end
end

function hbv_Aux_GetOverlayBoolean(key, frame)
    if Healbot_Config_Aux.Overlay[Healbot_Config_Skins.Current_Skin][frame] then
        if Healbot_Config_Aux.Overlay[Healbot_Config_Skins.Current_Skin][frame][key] == false then
            return false
        else
            return Healbot_Config_Aux.Overlay[Healbot_Config_Skins.Current_Skin][frame][key] or hbAuxOverlayDefaults[key]
        end
    end
    return hbAuxOverlayDefaults[key]
end

function hbv_Aux_GetOverlayVar(key, frame)
    if Healbot_Config_Aux.Overlay[Healbot_Config_Skins.Current_Skin][frame] then
        return Healbot_Config_Aux.Overlay[Healbot_Config_Skins.Current_Skin][frame][key] or hbAuxOverlayDefaults[key]
    end
    return hbAuxOverlayDefaults[key]
end

function hbv_Aux_SetOverlaySkin(value, skin, key, frame)
    if hbAuxOverlayDefaults[key] == value then
        hbv_Aux_NilOverlaySkin(skin, key, frame)
    else
        if not Healbot_Config_Aux.Overlay[skin][frame] then Healbot_Config_Aux.Overlay[skin][frame]={} end
        Healbot_Config_Aux.Overlay[skin][frame][key]=value
    end
end

function hbv_Aux_SetOverlayVar(value, key, frame)
    hbv_Aux_SetOverlaySkin(value, Healbot_Config_Skins.Current_Skin, key, frame)
end

function hbv_Aux_NilOverlaySkin(skin, key, frame)
    if Healbot_Config_Aux.Overlay[skin][frame] then
        Healbot_Config_Aux.Overlay[skin][frame][key]=nil
        HealBot_Util_EmptyTable(Healbot_Config_Aux.Overlay[skin], frame)
    end
end

-- Skins

local hbRoleCols= {
          ["TANK"]=    {r=0.85, g=0.65,  b=0.50, },
          ["HEALER"]=  {r=0.30, g=0.90,  b=0.99, },
          ["DAMAGER"]= {r=1.0,  g=0.45,  b=0.05, },
      }
function hbv_Skins_SetRoleInit(SkinName, role, override)
      --HealBot_setCall("hbv_Skins_SetRoleCol")
    if override then
        HealBot_Globals.OverrideColours[role]=nil
    else
        Healbot_Config_Skins.CustomCols[SkinName][role]=nil
    end
end

function hbv_Skins_CheckRoleCol(skin, role, override)
    if override then
        if HealBot_Globals.OverrideColours[role] then
            if (HealBot_Globals.OverrideColours[role].r or 99) == hbRoleCols[role].r then HealBot_Globals.OverrideColours[role].r=nil end
            if (HealBot_Globals.OverrideColours[role].g or 99) == hbRoleCols[role].g then HealBot_Globals.OverrideColours[role].g=nil end
            if (HealBot_Globals.OverrideColours[role].b or 99) == hbRoleCols[role].b then HealBot_Globals.OverrideColours[role].b=nil end
            HealBot_Util_EmptyTable(HealBot_Globals.OverrideColours, role)
        end
    else
        if Healbot_Config_Skins.CustomCols[skin][role] then
            if (Healbot_Config_Skins.CustomCols[skin][role].r or 99) == hbRoleCols[role].r then Healbot_Config_Skins.CustomCols[skin][role].r=nil end
            if (Healbot_Config_Skins.CustomCols[skin][role].g or 99) == hbRoleCols[role].g then Healbot_Config_Skins.CustomCols[skin][role].g=nil end
            if (Healbot_Config_Skins.CustomCols[skin][role].b or 99) == hbRoleCols[role].b then Healbot_Config_Skins.CustomCols[skin][role].b=nil end
            HealBot_Util_EmptyTable(Healbot_Config_Skins.CustomCols[skin], role)
        end
    end
end

function hbv_Skins_GetRoleCol(role, override)
    if override>1 then
        if HealBot_Globals.OverrideColours[role] then
            return HealBot_Globals.OverrideColours[role].r or hbRoleCols[role].r,
                   HealBot_Globals.OverrideColours[role].g or hbRoleCols[role].g,
                   HealBot_Globals.OverrideColours[role].b or hbRoleCols[role].b
        end
    elseif Healbot_Config_Skins.CustomCols[Healbot_Config_Skins.Current_Skin][role] then
        return Healbot_Config_Skins.CustomCols[Healbot_Config_Skins.Current_Skin][role].r or hbRoleCols[role].r,
               Healbot_Config_Skins.CustomCols[Healbot_Config_Skins.Current_Skin][role].g or hbRoleCols[role].g,
               Healbot_Config_Skins.CustomCols[Healbot_Config_Skins.Current_Skin][role].b or hbRoleCols[role].b
    end
    return hbRoleCols[role].r, hbRoleCols[role].g, hbRoleCols[role].b
end

function hbv_Skins_SetRoleColSkin(value, skin, role, key, override)
    if hbRoleCols[role][key] == value then
        hbv_Skins_NilRoleCol(skin, role, key, override)
    elseif override then
        if not HealBot_Globals.OverrideColours[role] then HealBot_Globals.OverrideColours[role]={} end
        HealBot_Globals.OverrideColours[role][key]=value
    else
        if not Healbot_Config_Skins.CustomCols[skin][role] then Healbot_Config_Skins.CustomCols[skin][role]={} end
        Healbot_Config_Skins.CustomCols[skin][role][key]=value
    end
end

function hbv_Skins_SetRoleCol(value, role, key, override)
    hbv_Skins_SetRoleColSkin(value, Healbot_Config_Skins.Current_Skin, role, key, override)
end

function hbv_Skins_NilRoleCol(skin, role, key, override)
    if override then
        if HealBot_Globals.OverrideColours[role] then
            HealBot_Globals.OverrideColours[role][key]=nil
            HealBot_Util_EmptyTable(HealBot_Globals.OverrideColours, role)
        end
    elseif Healbot_Config_Skins.CustomCols[skin][role] then
        Healbot_Config_Skins.CustomCols[skin][role][key]=nil
        HealBot_Util_EmptyTable(Healbot_Config_Skins.CustomCols[skin], role)
    end
end

local hbClassCols={
          ["DEAT"]={r=0.78, g=0.04, b=0.04, },
          ["DEMO"]={r=0.8,  g=0.1,  b=0.8, },
          ["DRUI"]={r=1.0,  g=0.49, b=0.04, },
          ["EVOK"]={r=0.22, g=0.59, b=0.49, },
          ["HUNT"]={r=0.67, g=0.83, b=0.45, },
          ["MAGE"]={r=0.41, g=0.8,  b=0.94, },
          ["MONK"]={r=0.0,  g=1.0,  b=0.59, },
          ["PALA"]={r=0.96, g=0.55, b=0.73, },
          ["PRIE"]={r=1.0,  g=1.0,  b=1.0,  },
          ["ROGU"]={r=1.0,  g=0.96, b=0.41, },
          ["SHAM"]={r=0.14, g=0.35, b=1.0,  },
          ["WARL"]={r=0.58, g=0.51, b=0.79, },
          ["WARR"]={r=0.78, g=0.61, b=0.43, },
      }
function hbv_Skins_SetClassColInit(SkinName, class, override)
      --HealBot_setCall("hbv_Skins_SetClassColInit")
    if override then
        HealBot_Globals.OverrideColours[class]=nil
    else
        Healbot_Config_Skins.CustomCols[SkinName][class]=nil
    end
end

function hbv_Skins_CheckClassCol(skin, class, override)
    if override then
        if HealBot_Globals.OverrideColours[class] then
            if (HealBot_Globals.OverrideColours[class].r or 99) == hbClassCols[class].r then HealBot_Globals.OverrideColours[class].r=nil end
            if (HealBot_Globals.OverrideColours[class].g or 99) == hbClassCols[class].g then HealBot_Globals.OverrideColours[class].g=nil end
            if (HealBot_Globals.OverrideColours[class].b or 99) == hbClassCols[class].b then HealBot_Globals.OverrideColours[class].b=nil end
            HealBot_Util_EmptyTable(HealBot_Globals.OverrideColours, class)
        end
    else
        if Healbot_Config_Skins.CustomCols[skin][class] then
            if (Healbot_Config_Skins.CustomCols[skin][class].r or 99) == hbClassCols[class].r then Healbot_Config_Skins.CustomCols[skin][class].r=nil end
            if (Healbot_Config_Skins.CustomCols[skin][class].g or 99) == hbClassCols[class].g then Healbot_Config_Skins.CustomCols[skin][class].g=nil end
            if (Healbot_Config_Skins.CustomCols[skin][class].b or 99) == hbClassCols[class].b then Healbot_Config_Skins.CustomCols[skin][class].b=nil end
            HealBot_Util_EmptyTable(Healbot_Config_Skins.CustomCols[skin], class)
        end
    end
end

function hbv_Skins_GetClassCol(class, override)
    if override>1 then
        if HealBot_Globals.OverrideColours[class] then
            return HealBot_Globals.OverrideColours[class].r or hbClassCols[class].r,
                   HealBot_Globals.OverrideColours[class].g or hbClassCols[class].g,
                   HealBot_Globals.OverrideColours[class].b or hbClassCols[class].b
        end
    elseif Healbot_Config_Skins.CustomCols[Healbot_Config_Skins.Current_Skin][class] then
        return Healbot_Config_Skins.CustomCols[Healbot_Config_Skins.Current_Skin][class].r or hbClassCols[class].r,
               Healbot_Config_Skins.CustomCols[Healbot_Config_Skins.Current_Skin][class].g or hbClassCols[class].g,
               Healbot_Config_Skins.CustomCols[Healbot_Config_Skins.Current_Skin][class].b or hbClassCols[class].b
    end
    return hbClassCols[class].r, hbClassCols[class].g, hbClassCols[class].b
end

function hbv_Skins_SetClassColSkin(value, skin, class, key, override)
    if hbClassCols[class][key] == value then
        hbv_Skins_NilClassCol(skin, class, key, override)
    elseif override then
        if not HealBot_Globals.OverrideColours[class] then HealBot_Globals.OverrideColours[class]={} end
        HealBot_Globals.OverrideColours[class][key]=value
    else
        if not Healbot_Config_Skins.CustomCols[skin][class] then Healbot_Config_Skins.CustomCols[skin][class]={} end
        Healbot_Config_Skins.CustomCols[skin][class][key]=value
    end
end

function hbv_Skins_SetClassCol(value, class, key, override)
    hbv_Skins_SetClassColSkin(value, Healbot_Config_Skins.Current_Skin, class, key, override)
end

function hbv_Skins_NilClassCol(skin, class, key, override)
    if override then
        if HealBot_Globals.OverrideColours[class] then
            HealBot_Globals.OverrideColours[class][key]=nil
            HealBot_Util_EmptyTable(HealBot_Globals.OverrideColours, class)
        end
    elseif Healbot_Config_Skins.CustomCols[skin][class] then
        Healbot_Config_Skins.CustomCols[skin][class][key]=nil
        HealBot_Util_EmptyTable(Healbot_Config_Skins.CustomCols[skin], class)
    end
end

function HealBot_Skins_RetClassCol(class)
    return hbClassCols[class]
end

local hbPowerCols= {
          ["ENERGY"]=      {r=1.0,  g=1.0,  b=0.0, },
          ["FOCUS"]=       {r=1.0,  g=0.5,  b=0.25, },
          ["FURY"]=        {r=0.79, g=0.26, b=0.99, },
          ["INSANITY"]=    {r=0.4,  g=0.0,  b=0.8, },
          ["LUNAR_POWER"]= {r=0.3,  g=0.52, b=0.9, },
          ["MAELSTROM"]=   {r=0.0,  g=0.5,  b=1.0, },
          ["MANA"]=        {r=0.0,  g=0.0,  b=1.0, },
          ["RAGE"]=        {r=1.0,  g=0.0,  b=0.0, },
          ["RUNIC_POWER"]= {r=0.0,  g=0.82, b=1.0,  },
      }
function hbv_Skins_SetPowerColInit(SkinName, powerType, override)
      --HealBot_setCall("hbv_Skins_SetPowerCol")
    if override then
        HealBot_Globals.OverrideColours[powerType]=nil
    else
        Healbot_Config_Skins.CustomCols[SkinName][powerType]=nil
    end
end

function hbv_Skins_CheckPowerCol(skin, powerType, override)
    if override then
        if HealBot_Globals.OverrideColours[powerType] then
            if (HealBot_Globals.OverrideColours[powerType].r or 99) == hbPowerCols[powerType].r then HealBot_Globals.OverrideColours[powerType].r=nil end
            if (HealBot_Globals.OverrideColours[powerType].g or 99) == hbPowerCols[powerType].g then HealBot_Globals.OverrideColours[powerType].g=nil end
            if (HealBot_Globals.OverrideColours[powerType].b or 99) == hbPowerCols[powerType].b then HealBot_Globals.OverrideColours[powerType].b=nil end
            HealBot_Util_EmptyTable(HealBot_Globals.OverrideColours, powerType)
        end
    else
        if Healbot_Config_Skins.CustomCols[skin][powerType] then
            if (Healbot_Config_Skins.CustomCols[skin][powerType].r or 99) == hbPowerCols[powerType].r then Healbot_Config_Skins.CustomCols[skin][powerType].r=nil end
            if (Healbot_Config_Skins.CustomCols[skin][powerType].g or 99) == hbPowerCols[powerType].g then Healbot_Config_Skins.CustomCols[skin][powerType].g=nil end
            if (Healbot_Config_Skins.CustomCols[skin][powerType].b or 99) == hbPowerCols[powerType].b then Healbot_Config_Skins.CustomCols[skin][powerType].b=nil end
            HealBot_Util_EmptyTable(Healbot_Config_Skins.CustomCols[skin], powerType)
        end
    end
end

function hbv_Skins_GetPowerCol(powerType, override)
    if override>1 then
        if HealBot_Globals.OverrideColours[powerType] then
            return HealBot_Globals.OverrideColours[powerType].r or hbPowerCols[powerType].r,
                   HealBot_Globals.OverrideColours[powerType].g or hbPowerCols[powerType].g,
                   HealBot_Globals.OverrideColours[powerType].b or hbPowerCols[powerType].b
        end
    elseif Healbot_Config_Skins.CustomCols[Healbot_Config_Skins.Current_Skin][powerType] then
        return Healbot_Config_Skins.CustomCols[Healbot_Config_Skins.Current_Skin][powerType].r or hbPowerCols[powerType].r,
               Healbot_Config_Skins.CustomCols[Healbot_Config_Skins.Current_Skin][powerType].g or hbPowerCols[powerType].g,
               Healbot_Config_Skins.CustomCols[Healbot_Config_Skins.Current_Skin][powerType].b or hbPowerCols[powerType].b
    end
    return hbPowerCols[powerType].r, hbPowerCols[powerType].g, hbPowerCols[powerType].b
end

function hbv_Skins_SetPowerColSkin(value, skin, powerType, key, override)
    if hbPowerCols[powerType][key] == value then
        hbv_Skins_NilPowerCol(skin, powerType, key, override)
    elseif override then
        if not HealBot_Globals.OverrideColours[powerType] then HealBot_Globals.OverrideColours[powerType]={} end
        HealBot_Globals.OverrideColours[powerType][key]=value
    else
        if not Healbot_Config_Skins.CustomCols[skin][powerType] then Healbot_Config_Skins.CustomCols[skin][powerType]={} end
        Healbot_Config_Skins.CustomCols[skin][powerType][key]=value
    end
end

function hbv_Skins_SetPowerCol(value, powerType, key, override)
    hbv_Skins_SetPowerColSkin(value, Healbot_Config_Skins.Current_Skin, powerType, key, override)
end

function hbv_Skins_NilPowerCol(skin, powerType, key, override)
    if override then
        if HealBot_Globals.OverrideColours[powerType] then
            HealBot_Globals.OverrideColours[powerType][key]=nil
            HealBot_Util_EmptyTable(HealBot_Globals.OverrideColours, powerType)
        end
    elseif Healbot_Config_Skins.CustomCols[skin][powerType] then
        Healbot_Config_Skins.CustomCols[skin][powerType][key]=nil
        HealBot_Util_EmptyTable(Healbot_Config_Skins.CustomCols[skin], powerType)
    end
end

--          ["AMMOSLOT"]      ={r=0.8,  g=0.6,  b=0.0, },
--          ["ARCANE_CHARGES"]={r=0.1,  g=0.1,  b=0.98, },
--          ["CHI"]           ={r=0.71, g=1.0,  b=0.92, },
--          ["ECLIPSE"]       ={r=0.3,  g=0.52, b=0.9,  },
--          ["FUEL"]          ={r=0.0,  g=0.55, b=0.5, },
--          ["HAPPINESS"]     ={r=1.0,  g=0.96, b=0.41, },
--          ["HOLY_POWER"]    ={r=0.95, g=0.9,  b=0.6, },
--          ["PAIN"]          ={r=1.0,  g=0.61, b=0.0, },
--          ["RUNES"]         ={r=0.5,  g=0.5,  b=0.5, },
--          ["SOUL_SHARDS"]   ={r=0.5,  g=0.32, b=0.55, },
--          ["STAGGER"]       ={r=0.1,  g=0.98, b=0.72, },

local hbSkinColsDefaults={["AdaptiveCol"]={["RecentHeals"]={["R"]=0.1, ["G"]=1,    ["B"]=0.2,},
                                                ["Threat"]={["R"]=1,   ["G"]=0.49, ["B"]=0.04,},
                                                 ["Aggro"]={["R"]=1,   ["G"]=0,    ["B"]=0,},
                                             ["Highlight"]={["R"]=0.4, ["G"]=1,    ["B"]=1,},
                                                ["Target"]={["R"]=1,   ["G"]=0.9,  ["B"]=0.2,},
                                                   ["OOR"]={["R"]=0,   ["G"]=0,    ["B"]=0.2,},
                                             ["Overheals"]={["R"]=1,   ["G"]=0.2,  ["B"]=0.2,},
                                               ["Absorbs"]={["R"]=1,   ["G"]=1,    ["B"]=1,},
                                          },
}

function hbv_Skins_ColHasDefault(cat, key)
    if hbSkinColsDefaults[cat] and hbSkinColsDefaults[cat][key] or hbSkinColsDefaults[cat][key] == false then
        return true
    else
        return false
    end
end

function hbv_Skins_GetColVar(cat, key, c)
    if Healbot_Config_Skins[cat][Healbot_Config_Skins.Current_Skin][key] then
        return Healbot_Config_Skins[cat][Healbot_Config_Skins.Current_Skin][key][c] or hbSkinColsDefaults[cat][key][c]
    end
    return hbSkinColsDefaults[cat][key][c]
end

function hbv_Skins_SetColVarSkin(value, skin, cat, key, c)
    if hbSkinColsDefaults[cat][key][c] == value then
        hbv_Skins_NilColVarSkin(skin, cat, key, c)
    else
        if not Healbot_Config_Skins[cat][skin][key] then Healbot_Config_Skins[cat][skin][key]={} end
        Healbot_Config_Skins[cat][skin][key][c]=value
    end
end

function hbv_Skins_SetColVar(value, cat, key, c)
    hbv_Skins_SetColVarSkin(value, Healbot_Config_Skins.Current_Skin, cat, key, c)
end

function hbv_Skins_NilColVarSkin(skin, cat, key, c)
    if Healbot_Config_Skins[cat][skin][key] and Healbot_Config_Skins[cat][skin][key][c] then
        Healbot_Config_Skins[cat][skin][key][c]=nil
        HealBot_Util_EmptyTable(Healbot_Config_Skins[cat][skin], key)
    end
end

function hbv_Skins_SetColArray(value, skin, cat, key, c, override)
    if hbSkinColsDefaults[cat] then
        hbv_Skins_SetColVarSkin(value, skin, cat, key, c)
    elseif hbPowerCols[key] then
        hbv_Skins_SetPowerColSkin(value, skin, key, c, override)
    elseif hbClassCols[key] then
        hbv_Skins_SetClassColSkin(value, skin, key, c, override)
    elseif hbRoleCols[key] then
        hbv_Skins_SetRoleColSkin(value, skin, key, c, override)
    end
end

local hbSkinDefaults={["Enemy"]={["INCSELF"]=true, ["INCTANKS"]=true, ["INCFOCUS"]=false, ["INCGROUP"]=false,
                                 ["INCMYTAR"]=false, ["INCARENA"]=false, ["INCARENAPETS"]=false, ["INCRAID"]=false,
                                 ["SHOWDEBUFFS"]=false, ["SHOWDEBUFFSPLAYERFRAMES"]=false,
                                 ["NUMBOSS"]=8, ["SELFDEBUFFS"]=false, ["SELFDEBUFFSPLAYERFRAMES"]=false,
                                 ["SHOWBUFFS"]=false, ["SHOWBUFFSPLAYERFRAMES"]=false, 
                                 ["SELFBUFFS"]=false, ["SELFBUFFSPLAYERFRAMES"]=false, ["EXISTSHOWGROUP"]=1,
                                 ["EXISTSHOWRAID"]=1, ["EXISTSHOWBOSS"]=true, ["ENEMYTARGET"]=false,
                                 ["TARUSEENEMYCOLS"]=false, ["TOTUSEENEMYCOLS"]=false, ["ENEMYTARGETSIZE"]=0.4,
                                 ["ENEMYTARGETSIZEPLAYERFRAMES"]=0.4, ["PLAYERTARGETSIZE"]=0.5, ["INCOMBATSHOWSELF"]=2,
                                 ["INCOMBATSHOWFOCUS"]=2, ["INCOMBATSHOWTANK"]=3, ["INCOMBATSHOWGROUP"]=2,
                                 ["INCOMBATSHOWRAID"]=2, ["SELFUSEFRAME"]=1, ["PRIVATELISTUSEFRAME"]=1,
                                 ["TANKUSEFRAME"]=1, ["GROUPUSEFRAME"]=1, ["RAIDUSEFRAME"]=1,
                                 ["INCOMBATSHOWLIST"]=2, ["INCOMBATSHOWARENA"]=2, ["EXISTSHOWPTAR"]=1,
                                 ["EXISTSHOWFOCUS"]=1, ["EXISTSHOWARENA"]=2, ["EXISTSHOWMYTAR"]=1, ["EXISTSHOWTANK"]=1,
                                },
                    ["General"]={["HIDEPARTYF"]=false, ["RUNBLIZZEVENTS"]=false, ["HIDEPTF"]=false,
                                 ["HIDEBOSSF"]=false, ["HIDEFOCUSF"]=false, ["STICKYFRAME"]=false,
                                 ["HIDERAIDF"]=true, ["FLUIDBARS"]=false, ["HEALTHDROP"]=false,
                                 ["HEALTHDROPPCT"]=400, ["UNITINCOMBAT"]=2, ["HEALTHDROPCANCEL"]=200,
                                 ["HEALTHDROPTIME"]=3, ["FLUIDFREQ"]=10, ["HOTBARHLTH"]=0,
                                 ["HOTBARDEBUFF"]=1, ["HBDIMMING"]=2.2, ["FOCUSGROUPS"]=1,
                                 ["FGDIMMING"]=2.5, ["HAZARDFREQ"]=0.3, ["HAZARDMINALPHA"]=0.25,
                                 ["GLOBALDIMMING"]=1, ["OFREQ"]=0.2, ["OMIN"]=0.1, ["OMAX"]=0.95,
                                 ["HAZARDFREQ"]=0.3, ["HAZARDMINALPHA"]=0.25, ["VC"]=0, ["FGRAIDONLY"]=false,
                                 ["GHDIMMING"]=0, ["GHTHRESHOLD"]=50, ["GHMINUNITS"]=5, ["GHRANGE"]=1,
                                },
                    ["Healing"]={["GROUPPETS"]=true, ["SELFPET"]=false, ["TARGETINCOMBAT"]=2, ["FOCUSINCOMBAT"]=2,
                                 ["PRIVFOCUSINCOMBAT"]=2, ["TOTINCOMBAT"]=3, ["TOFINCOMBAT"]=3,
                                 ["PRIVFOCUSTOTINCOMBAT"]=3, ["MYPETINCOMBAT"]=false, ["VEHICLEINCOMBAT"]=false,
                                },
                   ["Adaptive"]={["Plugin"]=true, ["RecentHeals"]=false, ["Threat"]=false, ["Debuffs"]=true,
                                 ["Aggro"]=true, ["Highlight"]=false, ["Target"]=false, ["OOR"]=false,
                                 ["Buffs"]=true, ["Overheals"]=false, ["Absorbs"]=false,
                                },
                       ["Chat"]={["NOTIFY"]=1, ["MSG"]=HEALBOT_NOTIFYOTHERMSG, ["RESONLY"]=true, ["EOCOOM"]=false, ["EOCOOMV"]=20,
                                },
                    ["IconSet"]={["CLASS"]=1, ["ROLE"]=1, ["TARGET"]=1, ["STATE"]=1, ["RANK"]=1, ["RC"]=1, ["COMBAT"]=1,
                                },
}

function hbv_Skins_HasDefault(cat, key)
    if hbSkinDefaults[cat][key] or hbSkinDefaults[cat][key] == false then
        return true
    else
        return false
    end
end

function hbv_Skins_GetBoolean(cat, key)
    if Healbot_Config_Skins[cat][Healbot_Config_Skins.Current_Skin][key] == false then
        return false
    else
        return Healbot_Config_Skins[cat][Healbot_Config_Skins.Current_Skin][key] or hbSkinDefaults[cat][key]
    end
end

function hbv_Skins_GetVar(cat, key)
    if Healbot_Config_Skins[cat] and Healbot_Config_Skins[cat][Healbot_Config_Skins.Current_Skin] then
        return Healbot_Config_Skins[cat][Healbot_Config_Skins.Current_Skin][key] or hbSkinDefaults[cat][key]
    else
        return hbSkinDefaults[cat][key]
    end
end

function hbv_Skins_SetVarSkin(value, skin, cat, key)
    if hbSkinDefaults[cat] and hbSkinDefaults[cat][key] == value then
        hbv_Skins_NilVarSkin(skin, cat, key)
    else
        if not Healbot_Config_Skins[cat] then Healbot_Config_Skins[cat]={} end
        if not Healbot_Config_Skins[cat][skin] then Healbot_Config_Skins[cat][skin]={} end
        Healbot_Config_Skins[cat][skin][key]=value
    end
end

function hbv_Skins_SetVar(value, cat, key)
    hbv_Skins_SetVarSkin(value, Healbot_Config_Skins.Current_Skin, cat, key)
end

function hbv_Skins_NilVarSkin(skin, cat, key)
    Healbot_Config_Skins[cat][skin][key]=nil
end


local hbSkinFrameDefaults={["BarCol"]={["HLTH"]=5, ["BACK"]=1, ["BORDER"]=1,
                                       ["HR"]=0.4, ["HG"]=0.7, ["HB"]=0.7, ["HA"]=1,
                                       ["HRE"]=0.8, ["HGE"]=0.3, ["HBE"]=0.3,
                                       ["HIR"]=0.4, ["HIG"]=0.7, ["HIB"]=0.7, 
                                       ["HIRE"]=0.8, ["HIGE"]=0.3, ["HIBE"]=0.3,
                                       ["HCR"]=0.4, ["HCG"]=0.7, ["HCB"]=0.7,
                                       ["HCRE"]=0.8, ["HCGE"]=0.3, ["HCBE"]=0.3,
                                       ["HCT"]=0.4, ["HIT"]=0.7, ["ORA"]=0.4, ["DISA"]=0.1,
                                       ["BR"]=0.4, ["BG"]=0.7, ["BB"]=0.7, ["BA"]=0,
                                       ["BRE"]=0.8, ["BGE"]=0.3, ["BBE"]=0.3,
                                       ["BIR"]=0.4, ["BIG"]=0.7, ["BIB"]=0.7,
                                       ["BIRE"]=0.8, ["BIGE"]=0.3, ["BIBE"]=0.3,
                                       ["BCR"]=0.4, ["BCG"]=0.7, ["BCB"]=0.7,
                                       ["BCRE"]=0.8, ["BCGE"]=0.3, ["BCBE"]=0.3,
                                       ["BCT"]=0.4, ["BIT"]=0.7, ["BOUT"]=1,
                                       ["BORR"]=0.1, ["BORG"]=0.1, ["BORB"]=0.3, ["BORA"]=1,
                                       ["BORRE"]=0.8, ["BORGE"]=0.3, ["BORBE"]=0.3,
                                       ["BORIR"]=0.1, ["BORIG"]=0.1, ["BORIB"]=0.3,
                                       ["BORIRE"]=0.8, ["BORIGE"]=0.3, ["BORIBE"]=0.3,
                                       ["BORCR"]=0.1, ["BORCG"]=0.1, ["BORCB"]=0.3,
                                       ["BORCRE"]=0.8, ["BORCGE"]=0.3, ["BORCBE"]=0.3,
                                       ["BORCT"]=0.4, ["BORIT"]=0.7, ["BORSIZE"]=2,
                                      },
                       ["Indicators"]={["ACOL"]=1, ["AANCHOR"]=1, ["AVOFF"]=-2, ["AHOFF"]=1, 
                                       ["ASIZE"]=3, ["ASPACE"]=0, ["MCOL"]=1, ["MANCHOR"]=1,
                                       ["MVOFF"]=-2, ["MHOFF"]=0, ["MSIZE"]=3, ["MSPACE"]=1, 
                                       ["SCOL"]=1, ["SANCHOR"]=1, ["SVOFF"]=1, ["SHOFF"]=1,
                                       ["SSIZE"]=4, ["PCOL"]=1, ["PANCHOR"]=2, ["PVOFF"]=0,
                                       ["PHOFF"]=0, ["PSIZE"]=4, ["PSPACE"]=1,
                                      },
                          ["HeadBar"]={["SHOW"]=false, ["WIDTH"]=0.7, ["HEIGHT"]=20,
                                       ["TEXTURE"]="HealBot 10",
                                       ["R"]=0.1, ["G"]=0.7, ["B"]=0.1, ["A"]=0.4,
                                      },
                          ["BarSort"]={["RAIDORDER"]=3, ["SUBORDER"]=1, ["OORLAST"]=false, ["SUBPF"]=true,
                                      },
                    ["FrameAliasBar"]={["TEXTURE"]=hbv_Default_TextureName(),
                                       ["WIDTH"]=0.99, ["HEIGHT"]=14, ["OFFSET"]=-4,
                                       ["R"]=0.102, ["G"]=0.102, ["B"]=0.102, ["A"]=0.7,
                                      },
                          ["Anchors"]={["FRAME"]=1, ["BARS"]=1, ["GROW"]=2, ["RealFixed"]=false,
                                       ["X"]=0, ["Y"]=0, ["RealX"]=0, ["RealY"]=0,
                                       ["TOP"]=nil, ["LEFT"]=nil, ["BOTTOM"]=nil, ["RIGHT"]=nil,
                                      },
                         ["BarAggro"]={["ALERT"]=2, ["ALERTIND"]=2, ["TEXTFORMAT"]=3, ["SHOWBARSPCT"]=false,
                                       ["R"]=1, ["G"]=0, ["B"]=0, ["SHOWTEXT"]=1, ["SHOWIND"]=true,
                                       ["SHOWBARS"]=true, ["SHOW"]=true, ["HAZARD"]=false, ["TARGETED"]=true, ["TARBOSSONLY"]=false,
                                      },
                            ["Frame"]={["TIPLOC"]=5, ["LOCKED"]=1, ["SCALE"]=1, ["GLOW"]=3, ["PADDING"]=1, 
                                       ["ICONGLOW"]=2, ["AUTOCLOSE"]=1, ["SFOFFSETH"]=0, ["SFOFFSETV"]=0, 
                                       ["BACKR"]=0.2, ["BACKG"]=0.2, ["BACKB"]=0.7, ["BACKA"]=0.1,
                                       ["BORDERR"]=0.2, ["BORDERG"]=0.2, ["BORDERB"]=0.2, ["BORDERA"]=0.4,
                                      },
                       ["BarTextCol"]={["NCR"]=0, ["NCG"]=1, ["NCB"]=0, ["NICR"]=0, ["NICG"]=1, ["NICB"]=0, ["NCCR"]=0, ["NCCG"]=1, ["NCCB"]=0, ["NCRE"]=0, ["NCGE"]=1, ["NCBE"]=0, ["NICRE"]=0, ["NICGE"]=1, ["NICBE"]=0, ["NCCRE"]=0, ["NCCGE"]=1, ["NCCBE"]=0,
                                       ["NIT"]=70, ["NCT"]=40, ["NCA"]=0.95, ["NCOA"]=0.75, ["NCDA"]=0.5, ["NDCR"]=1, ["NDCG"]=0.2, ["NDCB"]=0.2, ["NRCR"]=0.2, ["NRCG"]=1, ["NRCB"]=0.2,
                                       ["NSCR"]=0.4, ["NSCG"]=0.02, ["NSCB"]=0.4, ["SCR"]=1, ["SCG"]=1, ["SCB"]=0, ["SCA"]=0.95, ["SICR"]=1, ["SICG"]=1, ["SICB"]=0, ["SCRE"]=1, ["SCGE"]=1, ["SCBE"]=0, ["SICRE"]=1, ["SICGE"]=1, ["SICBE"]=0,
                                       ["SCCR"]=1, ["SCCG"]=1, ["SCCB"]=0, ["SIT"]=70, ["SCT"]=40, ["SCOA"]=0.75, ["SCDA"]=0.5, ["SDCR"]=1, ["SDCG"]=0.2, ["SDCB"]=0.2, ["SRCR"]=0.2, ["SRCG"]=1, ["SRCB"]=0.2, ["SCCRE"]=1, ["SCCGE"]=1, ["SCCBE"]=0,
                                       ["SSCR"]=0.4, ["SSCG"]=0.02, ["SSCB"]=0.4, ["NAME"]=2, ["STATE"]=2, ["HECR"]=0, ["HECG"]=1, ["HECB"]=0, ["HCR"]=0, ["HCG"]=1, ["HCB"]=0, ["HCA"]=0.95, ["HCRE"]=0, ["HCGE"]=1, ["HCBE"]=0,
                                       ["HICR"]=0, ["HICG"]=1, ["HICB"]=0, ["HCCR"]=0, ["HCCG"]=1, ["HCCB"]=0, ["HIT"]=70, ["HCT"]=40, ["HCOA"]=0.75, ["HCDA"]=0.5, ["OCR"]=0.1, ["OCG"]=1, ["OCB"]=0.1, ["HICRE"]=0, ["HICGE"]=1, ["HICBE"]=0, ["HCCRE"]=0, ["HCCGE"]=1, ["HCCBE"]=0,
                                       ["ICR"]=0.1, ["ICG"]=1, ["ICB"]=0.1, ["ACR"]=1, ["ACG"]=0.1, ["ACB"]=0.1, ["ACA"]=0.95,
                                       ["AIT"]=70, ["ACT"]=40, ["ACOA"]=0.75, ["ACDA"]=0.5, ["HLTH"]=2, ["AGGRO"]=2,
                                       ["NDEBUFF"]=false, ["HDEBUFF"]=false, ["RIP"]=true, ["RES"]=true, ["SUM"]=false, ["SRIP"]=true, ["SRES"]=true, ["SSUM"]=false,
                                      },
                          ["HealBar"]={["CMARGIN"]=2, ["TEXTURE"]=hbv_Default_TextureName(), 
                                       ["HEIGHT"]=30, ["WIDTH"]=80, ["NUMCOLS"]=1, ["RMARGIN"]=1, ["GRPCOLS"]=true,
                                       ["OFIX"]=1, ["LOWMANA"]=1, ["LOWMANACOMBAT"]=true, ["POWERCNT"]=true,
                                      },
                       ["FrameAlias"]={["SHOW"]=false, ["FONT"]=hbv_Default_FontName(),
                                       ["NAME"]="", ["SIZE"]=12, ["OUTLINE"]=1, ["OFFSET"]=0,
                                       ["R"]=1, ["G"]=1, ["B"]=1, ["A"]=1, ["ALIAS"]="",
                                      },
                          ["BarText"]={["NAMEONBAR"]=true, ["HLTHONBAR"]=true, ["SHOWROLE"]=true, ["CLASSONBAR"]=false, ["HLTHINVEHSHOWPLAYER"]=true, ["IGNOREONFULL"]=true,
                                       ["TAGAGGROONLYTIP"]=true, ["TAGSTATEONLYTIP"]=true, ["FONT"]=hbv_Default_FontName(), ["HFONT"]=hbv_Default_FontName(),
                                       ["SFONT"]=hbv_Default_FontName(), ["AFONT"]=hbv_Default_FontName(), ["HEIGHT"]=10, ["HLTHINCPTC"]=false,
                                       ["HHEIGHT"]=10, ["SHEIGHT"]=10, ["AHEIGHT"]=10, ["OFFSET"]=0, ["OFFSET2"]=0, ["SOFFSET"]=0, ["AOFFSET"]=0,
                                       ["AOFFSET2"]=0, ["HOFFSET"]=0, ["HOFFSET2"]=0, ["SOFFSET2"]=0, ["ALIGN"]=2, ["INCHEALS"]=2, ["INCABSORBS"]=1,
                                       ["OVERHEAL"]=1, ["OVERHEALFORMAT"]=2, ["OVERHEALCOL"]=1, ["SEPARATEFORMAT"]=3, ["SEPARATECOL"]=1, ["HEALEXTRACOL"]=1, ["HLTHTXTANCHOR"]=2,
                                       ["STATETXTANCHOR"]=1, ["AGGROTXTANCHOR"]=3, ["NUMFORMAT1"]=11, ["NUMFORMAT2"]=1, ["OUTLINE"]=1, ["HOUTLINE"]=1, ["SOUTLINE"]=1,
                                       ["AOUTLINE"]=1, ["HLTHTYPE"]=1, ["MAXCHARS"]=0, ["HMAXCHARS"]=0, ["TAGDC"]=HEALBOT_DISCONNECTED_TAG, ["TAGRIP"]=HEALBOT_DEAD_TAG,
                                       ["TAGOOR"]=HEALBOT_OUTOFRANGE_TAG, ["TAGR"]=HEALBOT_RESERVED_TAG, ["TAGDEBUFF"]=HEALBOT_WORD_DISPEL.." #n",
                                       ["TAGBUFF"]=HEALBOT_WORD_MISSING.." #n", ["TAGGROUP"]=HEALBOT_SORTBY_GROUP.." #g", ["TAGRES"]=HEALBOT_RES_TAG, ["TAGSUM"]=HEALBOT_SUMMONS_TAG,
                                       ["ROLETANK"]=HEALBOT_WORD_TANK, ["ROLEHEAL"]=HEALBOT_WORD_HEALER, ["ROLEDPS"]=HEALBOT_WORD_DAMAGER,
                                      },
                         ["BarIACol"]={["IC"]=3, ["IR"]=0.2, ["IG"]=1, ["IB"]=0.2, ["IIR"]=0.2, ["IIG"]=1, ["IIB"]=0.2, ["ICR"]=0.2, ["ICG"]=1, ["ICB"]=0.2,
                                       ["IRE"]=0.8, ["IGE"]=0.3, ["IBE"]=0.3, ["IIRE"]=0.8, ["IIGE"]=0.3, ["IIBE"]=0.3, ["ICRE"]=0.8, ["ICGE"]=0.3, ["ICBE"]=0.3,
                                       ["IIT"]=0.7, ["ICT"]=0.4, ["IA"]=0.82, ["AC"]=3, ["AR"]=1, ["AG"]=1, ["AB"]=1, ["AIR"]=1, ["AIG"]=1, ["AIB"]=1, ["ACR"]=1, 
                                       ["ACG"]=1, ["ACB"]=1, ["AIT"]=0.7, ["ACT"]=0.4, ["AA"]=0.78, ["ARE"]=0.8, ["AGE"]=0.3, ["ABE"]=0.3, ["AIRE"]=0.8,
                                       ["AIGE"]=0.3, ["AIBE"]=0.3, ["ACRE"]=0.8, ["ACGE"]=0.3, ["ACBE"]=0.3, ["OSHIELD"]=true,
                                      },
                            ["Emerg"]={["USE"]=false, ["TEXTURE"]=hbv_Default_TextureName(), ["ANCHOR"]=3, ["VOFFSET"]=0, ["DEBUFFBARCOL"]=false,
                                       ["A"]=1, ["OA"]=0.5, ["DA"]=0.2, ["CRITICAL"]=0.25, ["INJURED"]=0.5, ["BUFFBARCOL"]=false, ["DEBUFFBARCOL"]=false,
                                       ["CR"]=1, ["CG"]=0.1, ["CB"]=0.1, ["IR"]=0.9, ["IG"]=0.9, ["IB"]=0.1, ["HR"]=0, ["HG"]=0.9, ["HB"]=0, ["HOFFSET"]=0,
                                       ["BARCOL"]=5, ["BUFFGLOW"]=1, ["DEBUFFGLOW"]=1, ["HEIGHT"]=0.25, ["WIDTH"]=0.1, ["BUFFGLOWONLYMISSING"]=false,
                                      },
                     ["StickyFrames"]={["STUCK"]=false, ["STUCKTO"]=0, ["STUCKPOINT"]="NONE", ["STUCKTOPOINT"]="NONE",
                                      },
                         ["HeadText"]={["FONT"]=hbv_Default_FontName(), ["OUTLINE"]=1, ["HEIGHT"]=9,
                                       ["OFFSET"]=0, ["R"]=1, ["G"]=1, ["B"]=0.1, ["A"]=0.7,
                                      },
                    ["BarVisibility"]={["ALERTIC"]=0.98, ["ALERTOC"]=0.9, ["HIDEOOR"]=false,
                                      },
                            ["Icons"]={["SHOWRC"]=true, ["SHOWCOMBAT"]=false, ["SHOWHOSTILE"]=false, ["SHOWRESTING"]=false, 
                                       ["SHOWDIR"]=false, ["SHOWDIRMOUSE"]=false, ["SHOWCLASS"]=false, ["SHOWROLE"]=false, ["SHOWMTONLY"]=false,
                                       ["CLASSEN"]=false, ["RANKEN"]=false, ["TARGETEN"]=false, ["COMBATEN"]=false, ["RCEN"]=false, ["OOREN"]=false, ["CLASSONBAR"]=1, ["RANKONBAR"]=1,
                                       ["COMBATONBAR"]=1, ["TARGETONBAR"]=1, ["RCONBAR"]=1, ["OORONBAR"]=1, ["CLASSANCHOR"]=1, ["TARGETANCHOR"]=1, ["RANKANCHOR"]=1,
                                       ["COMBATANCHOR"]=1, ["RCANCHOR"]=1, ["OORANCHOR"]=1, ["CLASSVOFFSET"]=0, ["CLASSHOFFSET"]=0, ["CLASSSCALE"]=0.5, ["CLASSZOOM"]=0.05, 
                                       ["RANKVOFFSET"]=0, ["RANKHOFFSET"]=0, ["RANKSCALE"]=0.5, ["RANKZOOM"]=0, ["TARGETVOFFSET"]=0, ["TARGETHOFFSET"]=0,
                                       ["TARGETSCALE"]=0.5, ["TARGETZOOM"]=0.05, ["COMBATVOFFSET"]=0, ["COMBATHOFFSET"]=0, ["COMBATSCALE"]=0.5, ["COMBATZOOM"]=0.05,
                                       ["RCVOFFSET"]=0, ["RCHOFFSET"]=0, ["RCSCALE"]=0.5, ["RCZOOM"]=0.05, ["SHOWAFK"]=false,
                                       ["OORVOFFSET"]=0, ["OORHOFFSET"]=0, ["OORSCALE"]=0.5, ["OORZOOM"]=0.05, ["SHOWRANK"]=false, ["SHOWRANKMT"]=false,
                                      },
                         ["RaidIcon"]={["SHOW"]=true, ["STAR"]=true, ["MOON"]=true, ["CROSS"]=true, ["SKULL"]=true,
                                       ["CIRCLE"]=true, ["DIAMOND"]=true, ["TRIANGLE"]=true, ["SQUARE"]=true,
                                      },
                          ["IconText"]={["SELFIND"]=false,
                                      },
}

function hbv_Skins_FrameHasDefault(cat, key)
    if hbSkinFrameDefaults[cat][key] or hbSkinFrameDefaults[cat][key] == false then
        return true
    else
        return false
    end
end

function hbv_Skins_GetFrameBoolean(cat, key, frame)
    if Healbot_Config_Skins[cat] and Healbot_Config_Skins[cat][Healbot_Config_Skins.Current_Skin] and Healbot_Config_Skins[cat][Healbot_Config_Skins.Current_Skin][frame] then
        if Healbot_Config_Skins[cat][Healbot_Config_Skins.Current_Skin][frame][key] == false then
            return false
        else
            return Healbot_Config_Skins[cat][Healbot_Config_Skins.Current_Skin][frame][key] or hbSkinFrameDefaults[cat][key]
        end
    end
    return hbSkinFrameDefaults[cat][key]
end

function hbv_Skins_GetFrameVar(cat, key, frame)
    if Healbot_Config_Skins[cat][Healbot_Config_Skins.Current_Skin][frame] then
        return Healbot_Config_Skins[cat][Healbot_Config_Skins.Current_Skin][frame][key] or hbSkinFrameDefaults[cat][key]
    end
    return hbSkinFrameDefaults[cat][key]
end

function hbv_Skins_SetFrameVarSkin(value, skin, cat, key, frame)
    if hbSkinFrameDefaults[cat] and hbSkinFrameDefaults[cat][key] == value then
        hbv_Skins_NilFrameVarSkin(skin, cat, key, frame)
    else
        if not Healbot_Config_Skins[cat] then Healbot_Config_Skins[cat]={} end
        if not Healbot_Config_Skins[cat][skin] then Healbot_Config_Skins[cat][skin]={} end
        if not Healbot_Config_Skins[cat][skin][frame] then Healbot_Config_Skins[cat][skin][frame]={} end
        Healbot_Config_Skins[cat][skin][frame][key]=value
    end
end

function hbv_Skins_SetFrameVar(value, cat, key, frame)
    hbv_Skins_SetFrameVarSkin(value, Healbot_Config_Skins.Current_Skin, cat, key, frame)
end

function hbv_Skins_NilFrameVarSkin(skin, cat, key, frame)
    if Healbot_Config_Skins[cat][skin][frame] then
        Healbot_Config_Skins[cat][skin][frame][key]=nil
        HealBot_Util_EmptyTable(Healbot_Config_Skins[cat][skin], frame)
    end
end


local hbSkinIconDefaults={[1]={["DEBUFFONBAR"]=1, ["BUFFONBAR"]=1, ["DEBUFFDOUBLE"]=false, ["BUFFDOUBLE"]=false, ["BSCALE"]=0.3,
                               ["DSCALE"]=0.3, ["DI15EN"]=true, ["BUFFI15EN"]=true, ["DEBUFFANCHOR"]=1, ["BUFFANCHOR"]=2,
                               ["DFADE"]=false, ["BUFFFADE"]=false, ["DFADESECS"]=15, ["BUFFFADESECS"]=15, ["MAXDICONS"]=4,
                               ["MAXBICONS"]=4, ["BICONSPACER"]=0, ["DICONSPACER"]=0, ["DVOFFSET"]=0, ["DHOFFSET"]=0,
                               ["BVOFFSET"]=0, ["BHOFFSET"]=0, ["BZOOM"]=0.05, ["DZOOM"]=0.05,
                              },
                          [2]={["DEBUFFONBAR"]=1, ["BUFFONBAR"]=1, ["DEBUFFDOUBLE"]=false, ["BUFFDOUBLE"]=false, ["BSCALE"]=0.4,
                               ["DSCALE"]=0.4, ["DI15EN"]=true, ["BUFFI15EN"]=true, ["DEBUFFANCHOR"]=3, ["BUFFANCHOR"]=4,
                               ["DFADE"]=false, ["BUFFFADE"]=false, ["DFADESECS"]=15, ["BUFFFADESECS"]=15, ["MAXDICONS"]=1,
                               ["MAXBICONS"]=1, ["BICONSPACER"]=0, ["DICONSPACER"]=0, ["DVOFFSET"]=0, ["DHOFFSET"]=0,
                               ["BVOFFSET"]=0, ["BHOFFSET"]=0, ["BZOOM"]=0.05, ["DZOOM"]=0.05,
                              },
                          [3]={["DEBUFFONBAR"]=1, ["BUFFONBAR"]=1, ["DEBUFFDOUBLE"]=false, ["BUFFDOUBLE"]=false, ["BSCALE"]=0.4,
                               ["DSCALE"]=0.4, ["DI15EN"]=true, ["BUFFI15EN"]=true, ["DEBUFFANCHOR"]=7, ["BUFFANCHOR"]=8,
                               ["DFADE"]=false, ["BUFFFADE"]=false, ["DFADESECS"]=15, ["BUFFFADESECS"]=15, ["MAXDICONS"]=1,
                               ["MAXBICONS"]=1, ["BICONSPACER"]=0, ["DICONSPACER"]=0, ["DVOFFSET"]=0, ["DHOFFSET"]=0,
                               ["BVOFFSET"]=0, ["BHOFFSET"]=0, ["BZOOM"]=0.05, ["DZOOM"]=0.05,
                              }
}

function hbv_Skins_IconHasDefault(key)
    if hbSkinIconDefaults[1][key] or hbSkinIconDefaults[1][key] == false then
        return true
    else
        return false
    end
end

function hbv_Skins_GetIconBoolean(key, frame, set)
    if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][frame] and Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][frame][set] then
        if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][frame][set][key] == false then
            return false
        else
            return Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][frame][set][key] or hbSkinIconDefaults[set][key]
        end
    end
    return hbSkinIconDefaults[set][key]
end

function hbv_Skins_GetIconVar(key, frame, set)
    if Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][frame] and Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][frame][set] then
        return Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin][frame][set][key] or hbSkinIconDefaults[set][key]
    end
    return hbSkinIconDefaults[set][key]
end

function hbv_Skins_SetIconVarSkin(value, skin, key, frame, set)
    if hbSkinIconDefaults[set][key] == value then
        hbv_Skins_NilIconVarSkin(skin, key, frame, set)
    else
        if not Healbot_Config_Skins.IconSets[skin][frame] then Healbot_Config_Skins.IconSets[skin][frame]={} end
        if not Healbot_Config_Skins.IconSets[skin][frame][set] then Healbot_Config_Skins.IconSets[skin][frame][set]={} end
        Healbot_Config_Skins.IconSets[skin][frame][set][key]=value
    end
end

function hbv_Skins_SetIconVar(value, key, frame, set)
    hbv_Skins_SetIconVarSkin(value, Healbot_Config_Skins.Current_Skin, key, frame, set)
end

function hbv_Skins_NilIconVarSkin(skin, key, frame, set)
    if Healbot_Config_Skins.IconSets[skin][frame] and Healbot_Config_Skins.IconSets[skin][frame][set] then
        Healbot_Config_Skins.IconSets[skin][frame][set][key]=nil
        HealBot_Util_EmptyTable(Healbot_Config_Skins.IconSets[skin][frame], set)
        if not Healbot_Config_Skins.IconSets[skin][frame][set] then
            HealBot_Util_EmptyTable(Healbot_Config_Skins.IconSets[skin], frame)
        end
    end
end


local hbSkinIconTextDefaults={["DBDURTHRH"]=9, ["BUFFDURTHRH"]=9, ["DBDURWARN"]=3,
                              ["BUFFDURWARN"]=3, ["DBSCNT"]=true, ["BUFFSCNT"]=true,
                              ["BUFFSSCNT"]=false, ["DBSDUR"]=false, ["BUFFSDUR"]=true, 
                              ["BUFFSSDUR"]=false, ["DBFONT"]=hbv_Default_FontName(),
                              ["BUFFFONT"]=hbv_Default_FontName(), ["DBOUTLINE"]=2,
                              ["BUFFOUTLINE"]=2, ["DBHEIGHT"]=9, ["BUFFHEIGHT"]=9,
                             }

function hbv_Skins_IconTextHasDefault(key)
    if hbSkinIconTextDefaults[key] or hbSkinIconTextDefaults[key] == false then
        return true
    else
        return false
    end
end

function hbv_Skins_GetIconTextBoolean(key, frame, set)
    if Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][frame] and Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][frame][set] then
        if Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][frame][set][key] == false then
            return false
        else
            return Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][frame][set][key] or hbSkinIconTextDefaults[key]
        end
    end
    return hbSkinIconTextDefaults[key]
end

function hbv_Skins_GetIconTextVar(key, frame, set)
    if Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][frame] and Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][frame][set] then
        return Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin][frame][set][key] or hbSkinIconTextDefaults[key]
    end
    return hbSkinIconTextDefaults[key]
end

function hbv_Skins_SetIconTextVarSkin(value, skin, key, frame, set)
    if hbSkinIconTextDefaults[key] == value then
        hbv_Skins_NilIconTextVarSkin(skin, key, frame, set)
    else
        if not Healbot_Config_Skins.IconSetsText[skin][frame] then Healbot_Config_Skins.IconSetsText[skin][frame]={} end
        if not Healbot_Config_Skins.IconSetsText[skin][frame][set] then Healbot_Config_Skins.IconSetsText[skin][frame][set]={} end
        Healbot_Config_Skins.IconSetsText[skin][frame][set][key]=value
    end
end

function hbv_Skins_SetIconTextVar(value, key, frame, set)
    hbv_Skins_SetIconTextVarSkin(value, Healbot_Config_Skins.Current_Skin, key, frame, set)
end

function hbv_Skins_NilIconTextVarSkin(skin, key, frame, set)
    if Healbot_Config_Skins.IconSetsText[skin][frame] and Healbot_Config_Skins.IconSetsText[skin][frame][set] then
        Healbot_Config_Skins.IconSetsText[skin][frame][set][key]=nil
        HealBot_Util_EmptyTable(Healbot_Config_Skins.IconSetsText[skin][frame], set)
        if not Healbot_Config_Skins.IconSetsText[skin][frame][set] then
            HealBot_Util_EmptyTable(Healbot_Config_Skins.IconSetsText[skin], frame)
        end
    end
end

-- Focus Groups
function hbv_Skins_GetFocusGroup(id)
    if Healbot_Config_Skins.FocusGroups[Healbot_Config_Skins.Current_Skin][id] == false then
        return false
    else
        return true
    end
end

function hbv_Skins_SetFocusGroupSkin(value, skin, id)
    if value then
        hbv_Skins_NilFocusGroup(skin, id)
    else
        Healbot_Config_Skins.FocusGroups[skin][id]=false
    end
end

function hbv_Skins_SetFocusGroup(value, id)
    hbv_Skins_SetFocusGroupSkin(value, Healbot_Config_Skins.Current_Skin, id)
end

function hbv_Skins_NilFocusGroup(skin, id)
    Healbot_Config_Skins.FocusGroups[skin][id]=nil
end

-- Action Icons
local hbVarsDefaults={["NUMICONS"]=0, ["FONT"]=hbv_Default_FontName(),
                      ["FONTCOUNT"]=hbv_Default_FontName(), ["FONTSIZE"]=18,
                      ["FONTOUTLINE"]=2, ["FONTCOUNTHOFFSET"]=0, ["FONTCOUNTVOFFSET"]=0,
                      ["FONTHOFFSET"]=0, ["FONTVOFFSET"]=0, ["FONTCOUNTOUTLINE"]=2,
                      ["FONTCOUNTSIZE"]=12, ["HIGHLIGHT"]=1, ["FADE"]=0.2,
                      ["GLOWSIZE"]=3, ["LOCK"]=3, ["HIDETEXT"]=false,
                      ["HIDECOUNTTEXT"]=false, ["DOUBLEROW"]=false, ["ANCHOR"]=2,
                      ["OFFSETY"]=0, ["OFFSETX"]=0, ["SPACE"]=4, ["SIZE"]=28,
                      }

function hbv_ActionIcons_GetBoolean(key, frame)
    if HealBot_Skins_ActionIcons[Healbot_Config_Skins.Current_Skin][frame] then
        if HealBot_Skins_ActionIcons[Healbot_Config_Skins.Current_Skin][frame][key] == false then
            return false
        else
            return HealBot_Skins_ActionIcons[Healbot_Config_Skins.Current_Skin][frame][key] or hbVarsDefaults[key]
        end
    end
    return hbVarsDefaults[key]
end

function hbv_ActionIcons_GetVars(key, frame)
    if HealBot_Skins_ActionIcons[Healbot_Config_Skins.Current_Skin][frame] then
        return HealBot_Skins_ActionIcons[Healbot_Config_Skins.Current_Skin][frame][key] or hbVarsDefaults[key]
    end
    return hbVarsDefaults[key]
end

function hbv_ActionIcons_SetVars(value, key, frame)
    if hbVarsDefaults[key] == value then
        hbv_ActionIcons_NilVars(key, frame)
    else
        if not HealBot_Skins_ActionIcons[Healbot_Config_Skins.Current_Skin][frame] then HealBot_Skins_ActionIcons[Healbot_Config_Skins.Current_Skin][frame]={} end
        HealBot_Skins_ActionIcons[Healbot_Config_Skins.Current_Skin][frame][key]=value
    end
end

function hbv_ActionIcons_NilVars(key, frame)
    if HealBot_Skins_ActionIcons[Healbot_Config_Skins.Current_Skin][frame] then
        HealBot_Skins_ActionIcons[Healbot_Config_Skins.Current_Skin][frame][key]=nil
        HealBot_Util_EmptyTable(HealBot_Skins_ActionIcons[Healbot_Config_Skins.Current_Skin], frame)
    end
end

function hbv_ActionIcons_GetColVars(key, frame)
    if HealBot_Skins_ActionIcons[Healbot_Config_Skins.Current_Skin][frame] and HealBot_Skins_ActionIcons[Healbot_Config_Skins.Current_Skin][frame][key] then
        return HealBot_Skins_ActionIcons[Healbot_Config_Skins.Current_Skin][frame][key]["R"] or 1,
               HealBot_Skins_ActionIcons[Healbot_Config_Skins.Current_Skin][frame][key]["G"] or 1,
               HealBot_Skins_ActionIcons[Healbot_Config_Skins.Current_Skin][frame][key]["B"] or 1,
               HealBot_Skins_ActionIcons[Healbot_Config_Skins.Current_Skin][frame][key]["A"] or 1
    end
    return 1,1,1,1
end

function hbv_ActionIcons_SetColVars(r, g, b, a, key, frame)
    if r == 1 and g == 1 and b == 1 and a == 1 then
        hbv_ActionIcons_NilVars(key, frame)
    else
        if not HealBot_Skins_ActionIcons[Healbot_Config_Skins.Current_Skin][frame] then HealBot_Skins_ActionIcons[Healbot_Config_Skins.Current_Skin][frame]={} end
        if not HealBot_Skins_ActionIcons[Healbot_Config_Skins.Current_Skin][frame][key] then HealBot_Skins_ActionIcons[Healbot_Config_Skins.Current_Skin][frame][key]={} end
        HealBot_Skins_ActionIcons[Healbot_Config_Skins.Current_Skin][frame][key]["R"]=r
        HealBot_Skins_ActionIcons[Healbot_Config_Skins.Current_Skin][frame][key]["G"]=g
        HealBot_Skins_ActionIcons[Healbot_Config_Skins.Current_Skin][frame][key]["B"]=b
        HealBot_Skins_ActionIcons[Healbot_Config_Skins.Current_Skin][frame][key]["A"]=a
    end
end

local hbDataDefaults={["Ability"]="", ["Target"]=HEALBOT_WORDS_UNSET, ["bKey"]="", ["Bind"]="",
                      ["AlertGlowCol"]=nil, ["AlertGlowTimeout"]=60, ["HighlightFilter"]=1,
                      ["AlertFilter"]=1, ["AlertBuffTag"]="", ["AlertDebuffTag"]="",
                      ["AlertBuff"]="", ["AlertDebuff"]="", ["AlertBuffSelf"]=false,
                      ["AlertDebuffSelf"]=false, ["AlertBuffMinStacks"]=1, ["AlertBuffMaxStacks"]=21,
                      ["AlertDebuffMinStacks"]=1, ["AlertDebuffMaxStacks"]=21, ["AlertGlowStyle"]=1,
                      ["inCombat"]=false, ["inGroup"]=false, ["inInst"]=false, ["AlertHealth"]=50,
                      ["AlertHealthAbove"]=50, ["AlertMana"]=50, ["AlertManaAbove"]=50, ["AlertAggro"]=2,
                      }

function hbv_ActionIcons_DataExists(key, frame, id, cNo)
    if HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame] and HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame][id] then
        if HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame][id][key] then
            --if cNo then
            --    if HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame][id][key][cNo] then
            --        return true
            --    end
            --else
                return true
            --end
        end
    end
    return false
end

function hbv_ActionIcons_GetBooleanData(key, frame, id, cNo)
    if HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame] and HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame][id] then
        if cNo then
            if HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame][id][key] then
                if HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame][id][key][cNo] == false then
                    return false
                else
                    return HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame][id][key][cNo] or hbDataDefaults[key]
                end
            else
                return hbDataDefaults[key]
            end
        elseif HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame][id][key] == false then
            return false
        else
            return HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame][id][key] or hbDataDefaults[key]
        end
    end
    return hbDataDefaults[key]
end

function hbv_ActionIcons_GetData(key, frame, id, cNo)
    if HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame] and HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame][id] then
        if cNo then
            if HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame][id][key] then
                return HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame][id][key][cNo] or hbDataDefaults[key]
            else
                return hbDataDefaults[key]
            end
        else
            return HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame][id][key] or hbDataDefaults[key]
        end
    end
    return hbDataDefaults[key]
end

function hbv_ActionIcons_SetData(value, key, frame, id, cNo)
    if hbDataDefaults[key] == value then
        hbv_ActionIcons_NilData(key, frame, id, cNo)
    else
        if not HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame] then HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame]={} end
        if not HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame][id] then HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame][id]={} end
        if cNo then
            if not HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame][id][key] then HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame][id][key]={} end
            HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame][id][key][cNo]=value
        else
            HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame][id][key]=value
        end
    end
end

function hbv_ActionIcons_NilData(key, frame, id, cNo)
    if HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame] and HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame][id] then
        if cNo then
            if HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame][id][key] then
                HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame][id][key][cNo]=nil
                HealBot_Util_EmptyTable(HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame][id], key)
                if not HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame][id][key] then
                    HealBot_Util_EmptyTable(HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame], id)
                end
            end
        else
            HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame][id][key]=nil
            HealBot_Util_EmptyTable(HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame], id)
        end
        if not HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame][id] then
            HealBot_Util_EmptyTable(HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin], frame)
        end
    end
end

function hbv_ActionIcons_GetColData(key, frame, id)
    if HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame] and 
       HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame][id] and 
       HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame][id][key] then
        return HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame][id][key]["R"] or 1,
               HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame][id][key]["G"] or 0,
               HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame][id][key]["B"] or 0,
               HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame][id][key]["A"] or 1
    end
    return 1,0,0,1
end

function hbv_ActionIcons_SetColData(r, g, b, a, key, frame, id)
    if r == 1 and g == 0 and b == 0 and a == 1 then
        hbv_ActionIcons_NilData(key, frame, id)
    else
        if not HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame] then HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame]={} end
        if not HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame][id] then HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame][id]={} end
        if not HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame][id][key] then HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame][id][key]={} end
        HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame][id][key]["R"]=r
        HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame][id][key]["G"]=g
        HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame][id][key]["B"]=b
        HealBot_Skins_ActionIconsData[Healbot_Config_Skins.Current_Skin][frame][id][key]["A"]=a
    end
end

function hbv_Skins_VarsHasSkin()
    table.foreach(hbSkinDefaults, function (cat)
        if not Healbot_Config_Skins[cat][Healbot_Config_Skins.Current_Skin] then
            Healbot_Config_Skins[cat][Healbot_Config_Skins.Current_Skin]={}
        end
    end)
    table.foreach(hbSkinFrameDefaults, function (cat)
        if not Healbot_Config_Skins[cat][Healbot_Config_Skins.Current_Skin] then
            Healbot_Config_Skins[cat][Healbot_Config_Skins.Current_Skin]={}
        end
    end)
    if not Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin] then
        Healbot_Config_Skins.IconSets[Healbot_Config_Skins.Current_Skin]={}
    end
    if not Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin] then
        Healbot_Config_Skins.IconSetsText[Healbot_Config_Skins.Current_Skin]={}
    end
end