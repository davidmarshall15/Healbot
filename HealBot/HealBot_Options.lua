local HealBot_Options_ComboButtons_Button=1;
local HealBot_Options_Opened=false;
local HealBot_Options_SoftReset_flag=false;
local HealBot_buffbarcolr = {};
local HealBot_buffbarcolg = {};
local HealBot_buffbarcolb = {};
local HealBot_DebuffWatchTarget={}
local HealBot_BuffWatchTarget={}
local BuffTextClass=nil
local strtrim=strtrim
local strsub=strsub
local tonumber=tonumber
local floor=floor
local DoneInitTab={}
local hb_textures=nil
local texturesIndex={}
local fonts=nil
local fontsIndex={}
local sounds=nil
local soundsIndex={}
local updatingMedia=false
local LSM = HealBot_retLSM() --LibStub("LibSharedMedia-3.0")
local ClickedBuffGroupDD=nil
local hbCurSkin=""
local hbCurSkinSubFrameID=1001
local HealBot_Options_StorePrev={}
local _
local HealBot_DebuffSpell = {};
local HealBot_EmergInc = {[1]={}, [2]={}, [3]={}, [4]={}, [5]={}, [6]={}, [7]={}}

local HealBot_CDebuffCasyBy_List={}
local HealBot_CDebuffCasyBy_Indexed_List={}
local HealBot_CDebuffCat_List={}
local HealBot_Debuff_RangeWarning_List={}
local HealBot_Debuff_Item_List={}
local HealBot_Options_TooltipPos_List={}
local HealBot_Options_EmergencyFilter_List={}
local HealBot_Options_AggroIndAlertLevel_List={}
local HealBot_Options_AggroAlertLevel_List={}
local HealBot_Options_Class_HoTctlAction_List={}
local HealBot_Options_FilterHoTctl_List = {
        HEALBOT_CLASSES_ALL,
        HEALBOT_DEATHKNIGHT,
        HEALBOT_DEMONHUNTER,
        HEALBOT_DRUID,
        HEALBOT_PALADIN,
        HEALBOT_MONK,
        HEALBOT_PRIEST,
        HEALBOT_SHAMAN,
        HEALBOT_WARRIOR,
        HEALBOT_HUNTER,
        HEALBOT_MAGE,
        HEALBOT_ROGUE,
        HEALBOT_WARLOCK,
    }
local HealBot_Options_ManaIndicator_List={}
local HealBot_Options_BarsGrowDirection_List={}
local HealBot_Options_BarsOrientation_List={}
local HealBot_Options_ActionAnchor_List={}
local HealBot_Options_ActionBarsCombo_List={}
local HealBot_Options_Sort_List={}
local HealBot_Options_EmergencyFClass_List={}
local HealBot_Options_hbCommands_List={}
local HealBot_Options_hbProfile_List={}
local HealBot_Options_hbLangs_List={}
local HealBot_Options_TooltipFontSize_List={}
local HealBot_Options_MouseWheel_List={}
local HealBot_Options_EmoteCat_List={}
local HealBot_Options_EmoteCombat_List={}
local HealBot_Options_EmoteEmotion_List={}
local HealBot_Options_EmoteHappy_List={}
local HealBot_Options_EmoteGreet_List={}
local HealBot_Options_EmoteOther_List={}
local HealBot_Options_EmoteRespect_List={}
local HealBot_Options_EmoteUnhappy_List={}
local HealBot_Options_TestBarsProfile_List={}
local HealBot_Options_ButtonCastMethod_List={}
local HealBot_Options_CastButton_List={}
local HealBot_Options_BarHealthType_List={}
local HealBot_Options_AbsorbColour_List={}
local HealBot_Options_BarIncHealColour_List={}
local HealBot_Options_BarHealthColour_List={}
local HealBot_Options_BarHealthIncHeal_List={}
local HealBot_Options_FontOutline_List={}
local HealBot_Options_BuffTxt_List={}
local HealBot_Options_HealGroupsFrame_List={}
local HealBot_Options_TargetFocusInCombat_List={}
local hbOptionsTooltip = CreateFrame("GameTooltip", "hbOptionsTooltip", nil, "GameTooltipTemplate")

HealBot_Options_StorePrev["FramesSelFrame"]=1
HealBot_Options_StorePrev["customDebuffPriority"]=10
HealBot_Options_StorePrev["customBuffPriority"]=10

local HealBot_Debuff_Types = {}
local HealBot_Buff_Items_List = {}

local optionsPanel = CreateFrame("Frame")
optionsPanel.name = HEALBOT_HEALBOT
InterfaceOptions_AddCategory(optionsPanel)
local optionsTitle = optionsPanel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
optionsTitle:SetPoint("TOPLEFT", 16, -16)
optionsTitle:SetText(HEALBOT_HEALBOT)
local optionsText = optionsPanel:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
optionsText:SetPoint("TOPLEFT", optionsTitle, "BOTTOMLEFT", 0, -8)
optionsText:SetText(HEALBOT_ABOUT_DESC1)
local optionsButton = CreateFrame("Button", nil, optionsPanel, "UIPanelButtonTemplate")
optionsButton:SetText(HEALBOT_ACTION_OPTIONS)
optionsButton:SetWidth(100)
optionsButton:SetPoint("TOPLEFT", 14, -58)
optionsButton:SetScript('OnClick', function()
    HealBot_TogglePanel(HealBot_Options)
end)

function HealBot_Options_InitVars()
    if HEALBOT_GAME_VERSION<4 then 
        HealBot_Debuff_Types = {
            [HEALBOT_CLEANSE] = {HEALBOT_DISEASE_en, HEALBOT_POISON_en, HEALBOT_MAGIC_en},
            [HEALBOT_REMOVE_CURSE] = {HEALBOT_CURSE_en},
            [HBC_PURIFY] = {HEALBOT_POISON_en, HEALBOT_DISEASE_en},
            [HEALBOT_PURIFICATION_POTION] = {HEALBOT_CURSE_en, HEALBOT_DISEASE_en, HEALBOT_POISON_en},
            [HEALBOT_ANTI_VENOM] = {HEALBOT_POISON_en},
            [HEALBOT_POWERFUL_ANTI_VENOM] = {HEALBOT_POISON_en},
            [HEALBOT_STONEFORM] = {HEALBOT_DISEASE_en, HEALBOT_POISON_en},
            [HBC_SHAMAN_CURE_POISON] = {HEALBOT_POISON_en},
            [HBC_DRUID_CURE_POISON] = {HEALBOT_POISON_en},
            [HBC_DRUID_ABOLISH_POISON] = {HEALBOT_POISON_en},
            [HBC_DRUID_REMOVE_CURSE] = {HEALBOT_CURSE_en},
            [HBC_DISPELL_MAGIC] = {HEALBOT_MAGIC_en},
            [HBC_SHAMAN_CURE_DISEASE] = {HEALBOT_DISEASE_en},
            [HBC_PRIEST_CURE_DISEASE] = {HEALBOT_DISEASE_en},
            [HBC_PRIEST_ABOLISH_DISEASE] = {HEALBOT_DISEASE_en},
        }
    else
        HealBot_Buff_Items_List = {
            HEALBOT_ORALIUS_WHISPERING_CRYSTAL,
            HEALBOT_EVER_BLOOMING_FROND,
            HEALBOT_REPURPOSED_FEL_FOCUSER,
            HEALBOT_BATTLE_SCARRED_AUGMENT_RUNE,
            HEALBOT_TAILWIND_SAPPHIRE,
            HEALBOT_AMETHYST_OF_THE_SHADOW_KING,
        };
        HealBot_Debuff_Types = {
            [HEALBOT_CLEANSE] = {HEALBOT_DISEASE_en, HEALBOT_POISON_en, HEALBOT_MAGIC_en},
            [HEALBOT_REMOVE_CURSE] = {HEALBOT_CURSE_en},
            [HEALBOT_REMOVE_CORRUPTION] = {HEALBOT_CURSE_en, HEALBOT_POISON_en},
            [HEALBOT_NATURES_CURE] = {HEALBOT_MAGIC_en, HEALBOT_CURSE_en, HEALBOT_POISON_en},
            [HEALBOT_PURIFY_DISEASE] = {HEALBOT_DISEASE_en},
            [HEALBOT_PURIFY] = {HEALBOT_MAGIC_en, HEALBOT_DISEASE_en},
            [HEALBOT_PURIFICATION_POTION] = {HEALBOT_CURSE_en, HEALBOT_DISEASE_en, HEALBOT_POISON_en},
            [HEALBOT_ANTI_VENOM] = {HEALBOT_POISON_en},
            [HEALBOT_POWERFUL_ANTI_VENOM] = {HEALBOT_POISON_en},
            [HEALBOT_CLEANSE_TOXIN] = {HEALBOT_DISEASE_en, HEALBOT_POISON_en},
            [HEALBOT_ELIXIR_OF_POISON_RES] = {HEALBOT_POISON_en},
            [HEALBOT_STONEFORM] = {HEALBOT_DISEASE_en, HEALBOT_POISON_en},
            [HEALBOT_PURIFY_SPIRIT] = {HEALBOT_MAGIC_en, HEALBOT_CURSE_en},
            [HEALBOT_MASS_DISPEL] = {HEALBOT_MAGIC_en},
            [HEALBOT_CLEANSE_SPIRIT] = {HEALBOT_CURSE_en},
            [HEALBOT_DETOX] = {HEALBOT_DISEASE_en, HEALBOT_POISON_en},
        }
    end
end
function HealBot_Options_setLists()
    
    HealBot_Options_setClassEn()

    if HEALBOT_GAME_VERSION>3 then 
        HealBot_Options_BuffTxt_List = {
            HEALBOT_WORDS_NONE,
            HEALBOT_OPTIONS_BUFFSELF,
            HEALBOT_OPTIONS_BUFFPARTY,
            HEALBOT_OPTIONS_BUFFRAID,
            HEALBOT_DRUID,
            HEALBOT_HUNTER,
            HEALBOT_MAGE,
            HEALBOT_MONK,
            HEALBOT_PALADIN,
            HEALBOT_PRIEST,
            HEALBOT_ROGUE,
            HEALBOT_SHAMAN,
            HEALBOT_WARLOCK,
            HEALBOT_WARRIOR,
            HEALBOT_DEATHKNIGHT,
            HEALBOT_DEMONHUNTER,
            HEALBOT_CLASSES_MELEE,
            HEALBOT_CLASSES_RANGES,
            HEALBOT_CLASSES_HEALERS,
            HEALBOT_CLASSES_CUSTOM,
            HEALBOT_BUFF_PVP,
            HEALBOT_BUFF_PVE,
            HEALBOT_OPTIONS_TANKHEALS,
            HEALBOT_OPTIONS_MYTARGET,
            HEALBOT_FOCUS,
            HEALBOT_OPTIONS_MYFRIEND,
            HEALBOT_OPTIONS_SINGLETANK,
        }

        HealBot_Options_FilterHoTctl_List = {
            HEALBOT_CLASSES_ALL,
            HEALBOT_DEATHKNIGHT,
            HEALBOT_DEMONHUNTER,
            HEALBOT_DRUID,
            HEALBOT_PALADIN,
            HEALBOT_MONK,
            HEALBOT_PRIEST,
            HEALBOT_SHAMAN,
            HEALBOT_WARRIOR,
            HEALBOT_HUNTER,
            HEALBOT_MAGE,
            HEALBOT_ROGUE,
            HEALBOT_WARLOCK,
        }

        HealBot_Options_EmergencyFilter_List = {
            HEALBOT_CLASSES_ALL,
            HEALBOT_DEATHKNIGHT,
            HEALBOT_DEMONHUNTER,
            HEALBOT_DRUID,
            HEALBOT_HUNTER,
            HEALBOT_MAGE,
            HEALBOT_MONK,
            HEALBOT_PALADIN,
            HEALBOT_PRIEST,
            HEALBOT_ROGUE,
            HEALBOT_SHAMAN,
            HEALBOT_WARLOCK,
            HEALBOT_WARRIOR,
            HEALBOT_CLASSES_MELEE,
            HEALBOT_CLASSES_RANGES,
            HEALBOT_CLASSES_HEALERS,
            HEALBOT_CLASSES_CUSTOM,
        }

        HealBot_Options_MouseWheel_List = {
            HEALBOT_WORDS_NONE,
            HEALBOT_HB_MENU,
            HEALBOT_FOLLOW,
            HEALBOT_TRADE,
            HEALBOT_PROMOTE_RA,
            HEALBOT_DEMOTE_RA,
            HEALBOT_TOGGLE_ENABLED,
            HEALBOT_TOGGLE_MYTARGETS,
            HEALBOT_TOGGLE_PRIVATETANKS,
            HEALBOT_TOGGLE_PRIVATEHEALERS,
            HEALBOT_RESET_BAR,
            HEALBOT_RANDOMMOUNT,
            HEALBOT_RANDOMGOUNDMOUNT,
            HEALBOT_RANDOMPET,
            HEALBOT_RANDOMFAVMOUNT,
            HEALBOT_RANDOMFAVPET,
            HEALBOT_EMOTE,
        }
    else
        HealBot_Options_BuffTxt_List = {
            HEALBOT_WORDS_NONE,
            HEALBOT_OPTIONS_BUFFSELF,
            HEALBOT_OPTIONS_BUFFPARTY,
            HEALBOT_OPTIONS_BUFFRAID,
            HEALBOT_DRUID,
            HEALBOT_HUNTER,
            HEALBOT_MAGE,
            HEALBOT_PALADIN,
            HEALBOT_PRIEST,
            HEALBOT_ROGUE,
            HEALBOT_SHAMAN,
            HEALBOT_WARLOCK,
            HEALBOT_WARRIOR,
            HEALBOT_CLASSES_MELEE,
            HEALBOT_CLASSES_RANGES,
            HEALBOT_CLASSES_HEALERS,
            HEALBOT_CLASSES_CUSTOM,
            HEALBOT_BUFF_PVP,
            HEALBOT_BUFF_PVE,
            HEALBOT_OPTIONS_TANKHEALS,
            HEALBOT_OPTIONS_MYTARGET,
            HEALBOT_OPTIONS_MYFRIEND,
            HEALBOT_OPTIONS_SINGLETANK,
        }

        HealBot_Options_FilterHoTctl_List = {
            HEALBOT_CLASSES_ALL,
            HEALBOT_DRUID,
            HEALBOT_PALADIN,
            HEALBOT_PRIEST,
            HEALBOT_SHAMAN,
            HEALBOT_WARRIOR,
            HEALBOT_HUNTER,
            HEALBOT_MAGE,
            HEALBOT_ROGUE,
            HEALBOT_WARLOCK,
        }

        HealBot_Options_EmergencyFilter_List = {
            HEALBOT_CLASSES_ALL,
            HEALBOT_DRUID,
            HEALBOT_HUNTER,
            HEALBOT_MAGE,
            HEALBOT_PALADIN,
            HEALBOT_PRIEST,
            HEALBOT_ROGUE,
            HEALBOT_SHAMAN,
            HEALBOT_WARLOCK,
            HEALBOT_WARRIOR,
            HEALBOT_CLASSES_MELEE,
            HEALBOT_CLASSES_RANGES,
            HEALBOT_CLASSES_HEALERS,
            HEALBOT_CLASSES_CUSTOM,
        }

        HealBot_Options_MouseWheel_List = {
            HEALBOT_WORDS_NONE,
            HEALBOT_HB_MENU,
            HEALBOT_FOLLOW,
            HEALBOT_TRADE,
            HEALBOT_PROMOTE_RA,
            HEALBOT_DEMOTE_RA,
            HEALBOT_TOGGLE_ENABLED,
            HEALBOT_TOGGLE_MYTARGETS,
            HEALBOT_TOGGLE_PRIVATETANKS,
            HEALBOT_TOGGLE_PRIVATEHEALERS,
            HEALBOT_RESET_BAR,
            HEALBOT_EMOTE,
        }
    end
    
    HealBot_Options_TargetFocusInCombat_List = {
        HEALBOT_OPTIONS_ALWAYSHIDE,
        HEALBOT_OPTIONS_NOCHANGE,
        HEALBOT_OPTIONS_ALWAYSSHOW,
    }

    HealBot_Options_FontOutline_List = {
        HEALBOT_WORDS_NONE,
        HEALBOT_WORDS_THIN,
        HEALBOT_WORDS_THICK,
    }

    HealBot_Options_BarHealthIncHeal_List = {
        HEALBOT_WORDS_NO.." "..HEALBOT_OPTIONS_INCHEAL,
        HEALBOT_OPTIONS_BARHEALTHINCHEALS,
        HEALBOT_OPTIONS_BARHEALTHSEPHEALS,
        HEALBOT_OPTIONS_BARHEALTHALLINCHEALS,
        HEALBOT_OPTIONS_BARHEALTHALLSEPHEALS,
        HEALBOT_OPTIONS_BARHEALTHINCALL,
        HEALBOT_OPTIONS_BARHEALTHSEPALL,
        HEALBOT_OPTIONS_BARHEALTHALLINCALL,
        HEALBOT_OPTIONS_BARHEALTHALLSEPALL,
    }

    HealBot_Options_BarHealthColour_List = {
        HEALBOT_WORD_HEALTH,
        HEALBOT_SORTBY_CLASS,
        HEALBOT_CLASSES_CUSTOM,
    }

    HealBot_Options_BarIncHealColour_List = {
        HEALBOT_OPTIONS_DONT_SHOW,
        HEALBOT_OPTIONS_SAME_AS_HLTH_CURRENT,
        HEALBOT_OPTIONS_SAME_AS_HLTH_FUTURE,
        HEALBOT_OPTIONS_FUTURE_HLTH,
        HEALBOT_CLASSES_CUSTOM,
    }
    
    HealBot_Options_AbsorbColour_List = {
        HEALBOT_OPTIONS_DONT_SHOW,
        HEALBOT_WORD_HEALTH,
        HEALBOT_OPTIONS_FUTURE_HLTH,
        HEALBOT_CLASSES_CUSTOM,
    }

    HealBot_Options_BarHealthType_List = {
        HEALBOT_OPTIONS_BARHEALTH3,
        HEALBOT_OPTIONS_BARHEALTH1,
        HEALBOT_OPTIONS_BARHEALTH2,
    }

    HealBot_Options_CastButton_List = {
        HEALBOT_OPTIONS_BUTTONLEFT,
        HEALBOT_OPTIONS_BUTTONMIDDLE,
        HEALBOT_OPTIONS_BUTTONRIGHT,
        HEALBOT_OPTIONS_BUTTON4,
        HEALBOT_OPTIONS_BUTTON5,
        HEALBOT_OPTIONS_BUTTON6,
        HEALBOT_OPTIONS_BUTTON7,
        HEALBOT_OPTIONS_BUTTON8,
        HEALBOT_OPTIONS_BUTTON9,
        HEALBOT_OPTIONS_BUTTON10,
        HEALBOT_OPTIONS_BUTTON11,
        HEALBOT_OPTIONS_BUTTON12,
        HEALBOT_OPTIONS_BUTTON13,
        HEALBOT_OPTIONS_BUTTON14,
        HEALBOT_OPTIONS_BUTTON15,
    }

    HealBot_Options_ButtonCastMethod_List = {
        HEALBOT_OPTIONS_BUTTONCASTPRESSED,
        HEALBOT_OPTIONS_BUTTONCASTRELEASED,
    }
    
    HealBot_Options_TestBarsProfile_List = {
        HEALBOT_WORD_PARTY,
        HEALBOT_OPTIONS_EMERGENCYHEALS.." 10",
        HEALBOT_OPTIONS_EMERGENCYHEALS.." 25",
        HEALBOT_OPTIONS_EMERGENCYHEALS.." 40",
    }

    HealBot_Options_TooltipFontSize_List = {
        HEALBOT_WORDS_SMALL,
        HEALBOT_WORDS_MEDIUM,
        HEALBOT_WORDS_LARGE,
    }
    
    HealBot_Options_EmoteCat_List = {
        HEALBOT_EMOTE_CAT_COMBAT,
        HEALBOT_EMOTE_CAT_EMOTION,
        HEALBOT_EMOTE_CAT_HAPPY,
        HEALBOT_EMOTE_CAT_GREET,
        HEALBOT_EMOTE_CAT_OTHER,
        HEALBOT_EMOTE_CAT_RESPECT,
        HEALBOT_EMOTE_CAT_UNHAPPY,
    }
    
    HealBot_Options_EmoteCombat_List = {
        HEALBOT_EMOTE_ATTACKTARGET,
        HEALBOT_EMOTE_CHARGE,
        HEALBOT_EMOTE_DOOM,
        HEALBOT_EMOTE_FLEE,
        HEALBOT_EMOTE_FOLLOWME,
        HEALBOT_EMOTE_GROWL,
        HEALBOT_EMOTE_HEALME,
        HEALBOT_EMOTE_INCOMING,
        HEALBOT_EMOTE_INSULT,
        HEALBOT_EMOTE_OOM,
        HEALBOT_EMOTE_OPENFIRE,
        HEALBOT_EMOTE_ROAR,
        HEALBOT_EMOTE_RUDE,
        HEALBOT_EMOTE_SURRENDER,
        HEALBOT_EMOTE_TAUNT,
        HEALBOT_EMOTE_VICTORY,
        HEALBOT_EMOTE_WAIT,
    }
    
    HealBot_Options_EmoteEmotion_List = {
        HEALBOT_EMOTE_BASHFUL,
        HEALBOT_EMOTE_BLOW,
        HEALBOT_EMOTE_BLUSH,
        HEALBOT_EMOTE_FLIRT,
        HEALBOT_EMOTE_KISS,
        HEALBOT_EMOTE_SHY,
    }
    
    HealBot_Options_EmoteHappy_List = {
        HEALBOT_EMOTE_CACKLE,
        HEALBOT_EMOTE_CHUCKLE,
        HEALBOT_EMOTE_CLAP,
        HEALBOT_EMOTE_DANCE,
        HEALBOT_EMOTE_EXCITED,
        HEALBOT_EMOTE_GIGGLE,
        HEALBOT_EMOTE_LAUGH,
        HEALBOT_EMOTE_ROFL,
        HEALBOT_EMOTE_SILLY,
        HEALBOT_EMOTE_THANK,
        HEALBOT_EMOTE_TRAIN,
    }
    
    HealBot_Options_EmoteGreet_List = {
        HEALBOT_EMOTE_BYE,
        HEALBOT_EMOTE_GREET,
        HEALBOT_EMOTE_HELLO,
        HEALBOT_EMOTE_WAVE,
        HEALBOT_EMOTE_WELCOME,
    }
    
    HealBot_Options_EmoteOther_List = {
        HEALBOT_EMOTE_BOGGLE,
        HEALBOT_EMOTE_CURIOUS,
        HEALBOT_EMOTE_DRINK,
        HEALBOT_EMOTE_EAT,
        HEALBOT_EMOTE_FLEX,
        HEALBOT_EMOTE_GASP,
        HEALBOT_EMOTE_GUFFAW,
        HEALBOT_EMOTE_LAY,
        HEALBOT_EMOTE_NO,
        HEALBOT_EMOTE_NOD,
        HEALBOT_EMOTE_POINT,
        HEALBOT_EMOTE_PRAY,
        HEALBOT_EMOTE_PUZZLED,
        HEALBOT_EMOTE_RASP,
        HEALBOT_EMOTE_SHRUG,
        HEALBOT_EMOTE_SLEEP,
        HEALBOT_EMOTE_TALK,
    }
    
    HealBot_Options_EmoteRespect_List = {
        HEALBOT_EMOTE_APPLAUD,
        HEALBOT_EMOTE_BOW,
        HEALBOT_EMOTE_CHEER,
        HEALBOT_EMOTE_COMMEND,
        HEALBOT_EMOTE_CONGRATS,
        HEALBOT_EMOTE_CURTSEY,
        HEALBOT_EMOTE_HAIL,
        HEALBOT_EMOTE_KNEEL,
        HEALBOT_EMOTE_SALUTE,
    }
    
    HealBot_Options_EmoteUnhappy_List = {
        HEALBOT_EMOTE_ANGRY,
        HEALBOT_EMOTE_BEG,
        HEALBOT_EMOTE_BORED,
        HEALBOT_EMOTE_CONFUSED,
        HEALBOT_EMOTE_COWER,
        HEALBOT_EMOTE_CRY,
        HEALBOT_EMOTE_GLOAT,
        HEALBOT_EMOTE_GOLFCLAP,
        HEALBOT_EMOTE_GROVEL,
        HEALBOT_EMOTE_LOST,
        HEALBOT_EMOTE_MOURN,
        HEALBOT_EMOTE_ROLLEYES,
        HEALBOT_EMOTE_SIGH,
        HEALBOT_EMOTE_VIOLIN,
    }
    
    HealBot_Options_hbLangs_List = {
        HEALBOT_OPTIONS_LANG_ZHCN,
        HEALBOT_OPTIONS_LANG_ENUK,
        HEALBOT_OPTIONS_LANG_ENUS,
        HEALBOT_OPTIONS_LANG_FRFR,
        HEALBOT_OPTIONS_LANG_DEDE,
        HEALBOT_OPTIONS_LANG_GRGR,
        HEALBOT_OPTIONS_LANG_HUHU,
        HEALBOT_OPTIONS_LANG_ITIT,
        HEALBOT_OPTIONS_LANG_KRKR,
        HEALBOT_OPTIONS_LANG_ESMX,
        HEALBOT_OPTIONS_LANG_PTBR,
        HEALBOT_OPTIONS_LANG_RURU,
        HEALBOT_OPTIONS_LANG_ESES,
        HEALBOT_OPTIONS_LANG_TWTW,
    }
    
    HealBot_Options_hbProfile_List = {
        HEALBOT_OPTIONS_PROFILE_CHARACTER,
        HEALBOT_OPTIONS_PROFILE_CLASS,
    }
    
    HealBot_Options_hbCommands_List = {
        HEALBOT_WORDS_NONE,
        HEALBOT_CMD_CLEARBLACKLIST,
        HEALBOT_CMD_COPYSPELLS,
        HEALBOT_CMD_RESETICONS,
        HEALBOT_CMD_RESETBARS,
        HEALBOT_CMD_RESETBUFFS,
        HEALBOT_CMD_RESETCURES,
        HEALBOT_CMD_RESETCUSTOMDEBUFFS,
        HEALBOT_CMD_RESETSKINS,
        HEALBOT_CMD_RESETSPELLS,
        HEALBOT_CMD_TOGGLEDISLIKEMOUNT,
        HEALBOT_CMD_TOGGLEEXCLUDEMOUNT,
        HEALBOT_CMD_SUPPRESSERRORS,
        HEALBOT_CMD_SUPPRESSSOUND,
        HEALBOT_CMD_TOGGLECUSTOMCURECASTBY,
    }

    HealBot_Options_EmergencyFClass_List = {
        HEALBOT_CLASSES_MELEE,
        HEALBOT_CLASSES_RANGES,
        HEALBOT_CLASSES_HEALERS,
        HEALBOT_CLASSES_CUSTOM,
    }

    HealBot_Options_Sort_List = {
        HEALBOT_SORTBY_NAME,
        HEALBOT_SORTBY_CLASS,
        HEALBOT_SORTBY_GROUP,
        HEALBOT_SORTBY_MAXHEALTH,
        HEALBOT_SORTBY_ROLE,
        HEALBOT_WORDS_NONE,
    }

    HealBot_Options_ActionBarsCombo_List = {
        HEALBOT_OPTIONS_ENABLEDBARS,
        HEALBOT_OPTIONS_DISABLEDBARS,
        HEALBOT_OPTIONS_ENEMYBARS,
    }

    HealBot_Options_ActionAnchor_List = {
        HEALBOT_OPTIONS_TOPLEFT,
        HEALBOT_OPTIONS_BOTTOMLEFT,
        HEALBOT_OPTIONS_TOPRIGHT,
        HEALBOT_OPTIONS_BOTTOMRIGHT,
        HEALBOT_OPTIONS_TOP,
        HEALBOT_OPTIONS_BUTTONLEFT,
        HEALBOT_OPTIONS_BUTTONRIGHT,
        HEALBOT_OPTIONS_BOTTOM,
    }
    
    HealBot_Options_BarsGrowDirection_List = {
        HEALBOT_OPTIONS_GROW_HORIZONTAL,
        HEALBOT_OPTIONS_GROW_VERTICAL,
    }

    HealBot_Options_BarsOrientation_List = {
        HEALBOT_OPTIONS_GROW_HORIZONTAL,
        HEALBOT_OPTIONS_GROW_VERTICAL,
    }
    
    HealBot_Options_ManaIndicator_List = {
        HEALBOT_OPTIONS_LOWMANAINDICATOR1,
        HEALBOT_OPTIONS_LOWMANAINDICATOR2,
        HEALBOT_OPTIONS_LOWMANAINDICATOR3,
        HEALBOT_OPTIONS_LOWMANAINDICATOR4,
        HEALBOT_OPTIONS_LOWMANAINDICATOR5,
        HEALBOT_OPTIONS_LOWMANAINDICATOR6,
    }

    HealBot_Options_Class_HoTctlAction_List = {
        HEALBOT_WORDS_NONE,
        HEALBOT_OPTIONS_SELFHEALS,
        HEALBOT_OPTIONS_MYCLASS,
        HEALBOT_CUSTOM_CASTBY_FRIEND,
    }

    HealBot_Options_AggroAlertLevel_List = {
       -- HEALBOT_OPTIONS_ALERTAGGROLEVEL1,
        HEALBOT_OPTIONS_ALERTAGGROLEVEL2,
        HEALBOT_OPTIONS_ALERTAGGROLEVEL3,
    }
    

    HealBot_Options_AggroIndAlertLevel_List = {
        HEALBOT_OPTIONS_ALERTAGGROLEVEL1,
        HEALBOT_OPTIONS_ALERTAGGROLEVEL2,
        HEALBOT_OPTIONS_ALERTAGGROLEVEL3,
    }

    HealBot_Options_TooltipPos_List = {
        HEALBOT_TOOLTIP_POSDEFAULT,
        HEALBOT_TOOLTIP_POSLEFT,
        HEALBOT_TOOLTIP_POSRIGHT,
        HEALBOT_TOOLTIP_POSABOVE,
        HEALBOT_TOOLTIP_POSBELOW,
        HEALBOT_TOOLTIP_POSCURSOR,
    }

    HealBot_Debuff_Item_List = {
        HEALBOT_PURIFICATION_POTION,
        HEALBOT_ELIXIR_OF_POISON_RES,
        HEALBOT_ANTI_VENOM,
        HEALBOT_POWERFUL_ANTI_VENOM,
    }
    
    local iName = GetItemInfo(HEALBOT_PURIFICATION_POTION)
    iName = GetItemInfo(HEALBOT_ELIXIR_OF_POISON_RES)
    iName = GetItemInfo(HEALBOT_ANTI_VENOM)
    iName = GetItemInfo(HEALBOT_POWERFUL_ANTI_VENOM)

    HealBot_Debuff_RangeWarning_List = {
        HEALBOT_WORD_ALWAYS,
        HEALBOT_VISIBLE_RANGE,
        HEALBOT_SPELL_RANGE,
    }

    HealBot_CDebuffCat_List = {
        HEALBOT_CUSTOM_CAT_CUSTOM,
        HEALBOT_CUSTOM_CAT_02,
        HEALBOT_CUSTOM_CAT_03,
        HEALBOT_CUSTOM_CAT_04,
        HEALBOT_CUSTOM_CAT_05,
        HEALBOT_CUSTOM_CAT_06,
        HEALBOT_CUSTOM_CAT_07,
        HEALBOT_CUSTOM_CAT_08,
        HEALBOT_CUSTOM_CAT_09,
        HEALBOT_CUSTOM_CAT_10,
        HEALBOT_CUSTOM_CAT_11,
        HEALBOT_CUSTOM_CAT_12,
        HEALBOT_CUSTOM_CAT_13,
        HEALBOT_CUSTOM_CAT_14,
    }
    
    HealBot_Import_Methods_List = {
        HEALBOT_IMPORT_OVERWRITEALL,
        HEALBOT_IMPORT_MERGEALL,
        HEALBOT_IMPORT_MERGENEW,
    }
    
    HealBot_Options_FrameAliasList()
    HealBot_Options_setCDebuffCasyBy()
end

local function HealBot_Options_ObjectsShowHide(oName,oShow)
    local g=_G[oName]
    if oShow then
        g:Show()
    else
        g:Hide()
    end
end

function HealBot_Options_ObjectsEnableDisable(oName,oEnable)
    local g=_G[oName]
    if oEnable then
        g:SetAlpha(1)
        g:Enable()
    else
        g:SetAlpha(0.4)
        g:Disable()
    end
end

local function HealBot_Options_ButtonHighlight(oName,oHighlight)
    local g=_G[oName]
    if oHighlight then
        g:LockHighlight()
    else
        g:UnlockHighlight()
    end
end

function HealBot_Options_setCDebuffCasyBy()
    if HealBot_Globals.CureCustomDefaultCastBy=="ENEMY" then
        HealBot_CDebuffCasyBy_List = {
            HEALBOT_CUSTOM_CASTBY_ENEMY,
            HEALBOT_CUSTOM_CASTBY_FRIEND,
            HEALBOT_OPTIONS_SELFHEALS,
            HEALBOT_CUSTOM_CASTBY_EVERYONE,
        }
    else
        HealBot_CDebuffCasyBy_List = {
            HEALBOT_CUSTOM_CASTBY_EVERYONE,
            HEALBOT_CUSTOM_CASTBY_ENEMY,
            HEALBOT_CUSTOM_CASTBY_FRIEND,
            HEALBOT_OPTIONS_SELFHEALS,
        }
    end
    HealBot_Options_setCDebuffCasyByIndexed()
end

function HealBot_Options_framesChanged(frame)
    HealBot_setOptions_Timer(150) 
end

function HealBot_Options_setCDebuffCasyByIndexed()
    for j=1, getn(HealBot_CDebuffCasyBy_List), 1 do
        HealBot_CDebuffCasyBy_Indexed_List[HealBot_CDebuffCasyBy_List[j]] = j
    end
end

function HealBot_Options_getCDebuffCasyByIndexed()
    return HealBot_CDebuffCasyBy_Indexed_List
end

function HealBot_Options_ToggleCustomCuresCastBy()
    if HealBot_Globals.CureCustomDefaultCastBy=="ENEMY" then
        HealBot_Globals.CureCustomDefaultCastBy="ALL"
        for dName, CastBy in pairs (HealBot_Globals.FilterCustomDebuff) do
            CastBy=CastBy+1
            if CastBy==5 then CastBy=1 end
            HealBot_Globals.FilterCustomDebuff[dName]=CastBy
        end
    else
        HealBot_Globals.CureCustomDefaultCastBy="ENEMY"
        for dName, CastBy in pairs (HealBot_Globals.FilterCustomDebuff) do
            CastBy=CastBy-1
            if CastBy==0 then CastBy=4 end
            HealBot_Globals.FilterCustomDebuff[dName]=CastBy
        end
    end
    HealBot_Options_setCDebuffCasyBy()
    HealBot_Options_InitSub(404)
end

function HealBot_Options_setClassEn()
    HealBot_Class_En = { 
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
                    [HEALBOT_DEATHKNIGHT]="DEAT",
                    [HEALBOT_MONK]="MONK",
                    [HEALBOT_DEMONHUNTER]="DEMO",
    }
end
HealBot_Options_setClassEn()

function HealBot_Options_FrameAliasList()
    if HEALBOT_GAME_VERSION<4 then 
        if Healbot_Config_Skins.FrameAlias and Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin] then
            HealBot_Options_HealGroupsFrame_List = {
                Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][1]["ALIAS"] or HEALBOT_OPTIONS_FRAME.." 1",
                Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][2]["ALIAS"] or HEALBOT_OPTIONS_FRAME.." 2",
                Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][3]["ALIAS"] or HEALBOT_OPTIONS_FRAME.." 3",
                Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][4]["ALIAS"] or HEALBOT_OPTIONS_FRAME.." 4",
                Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][5]["ALIAS"] or HEALBOT_OPTIONS_FRAME.." 5",
                "--------",
                HEALBOT_OPTIONS_PETHEALS_en,
                HEALBOT_OPTIONS_TARGETHEALS_en,
                "--------",
                HEALBOT_CUSTOM_CASTBY_ENEMY_en,
            }
        else
            HealBot_Options_HealGroupsFrame_List = {
                HEALBOT_OPTIONS_FRAME.." 1",
                HEALBOT_OPTIONS_FRAME.." 2",
                HEALBOT_OPTIONS_FRAME.." 3",
                HEALBOT_OPTIONS_FRAME.." 4",
                HEALBOT_OPTIONS_FRAME.." 5",
                "--------",
                HEALBOT_OPTIONS_PETHEALS_en,
                HEALBOT_OPTIONS_TARGETHEALS_en,
                "--------",
                HEALBOT_CUSTOM_CASTBY_ENEMY_en,
            }
        end
    else
        if Healbot_Config_Skins.FrameAlias and Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin] then
            HealBot_Options_HealGroupsFrame_List = {
                Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][1]["ALIAS"] or HEALBOT_OPTIONS_FRAME.." 1",
                Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][2]["ALIAS"] or HEALBOT_OPTIONS_FRAME.." 2",
                Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][3]["ALIAS"] or HEALBOT_OPTIONS_FRAME.." 3",
                Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][4]["ALIAS"] or HEALBOT_OPTIONS_FRAME.." 4",
                Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][5]["ALIAS"] or HEALBOT_OPTIONS_FRAME.." 5",
                HEALBOT_VEHICLE_en,
                HEALBOT_OPTIONS_PETHEALS_en,
                HEALBOT_OPTIONS_TARGETHEALS_en,
                HEALBOT_FOCUS_en,
                HEALBOT_CUSTOM_CASTBY_ENEMY_en,
            }
        else
            HealBot_Options_HealGroupsFrame_List = {
                HEALBOT_OPTIONS_FRAME.." 1",
                HEALBOT_OPTIONS_FRAME.." 2",
                HEALBOT_OPTIONS_FRAME.." 3",
                HEALBOT_OPTIONS_FRAME.." 4",
                HEALBOT_OPTIONS_FRAME.." 5",
                HEALBOT_VEHICLE_en,
                HEALBOT_OPTIONS_PETHEALS_en,
                HEALBOT_OPTIONS_TARGETHEALS_en,
                HEALBOT_FOCUS_en,
                HEALBOT_CUSTOM_CASTBY_ENEMY_en,
            }
        end
    end
end

local HealBot_Buff_Spells_Class_List={}
local HealBot_Buff_Spells_List ={}

function HealBot_Options_InitBuffSpellsClassList(tClass)
    if tClass=="DEAT" then
        HealBot_Buff_Spells_Class_List = {
            HEALBOT_HORN_OF_WINTER,
            HEALBOT_BONE_SHIELD,
        }
    elseif tClass=="DEMO" then -- Demon Hunter
        HealBot_Buff_Spells_Class_List = {
        }
    elseif tClass=="DRUI" then
        HealBot_Buff_Spells_Class_List = {
            HEALBOT_MARK_OF_THE_WILD,
            HBC_GIFT_OF_THE_WILD,
            HBC_OMEN_OF_CLARITY,
            HEALBOT_BARKSKIN,
            HEALBOT_IRONBARK,
            HBC_THORNS,
            HBC_NATURE_GRASP,
        }
    elseif tClass=="HUNT" then
        HealBot_Buff_Spells_Class_List = {
            HEALBOT_A_CHEETAH,
            HEALBOT_A_PACK,
            HEALBOT_A_WILD,
            HEALBOT_TRAP_LAUNCHER,
            HEALBOT_LW_FEROCITY_OF_THE_RAPTOR ,
            HEALBOT_LW_FORTITUDE_OF_THE_BEAR,
            HEALBOT_LW_GRACE_OF_THE_CAT,
            HEALBOT_LW_HASTE_OF_THE_HYENA,
            HEALBOT_LW_POWER_OF_THE_PRIMATES,
            HEALBOT_LW_QUICKNESS_OF_THE_DRAGONHAWK,
            HEALBOT_LW_VERSATILITY_OF_THE_RAVAGER,
            HEALBOT_LW_WISDOM_OF_THE_SERPENT,
        }
    elseif tClass=="MAGE" then
        HealBot_Buff_Spells_Class_List = {
            HEALBOT_ARCANE_BRILLIANCE,
            HBC_ARCANE_BRILLIANCE,
            HBC_AMPLIFY_MAGIC,
            HEALBOT_DALARAN_BRILLIANCE,
            HEALBOT_EVOCATION,
            HEALBOT_MAGE_WARD,
            HBC_MAGE_ARMOR,
            HBC_MANA_SHIELD,
            HEALBOT_BLAZING_BARRIER,
            HEALBOT_PRISMATIC_BARRIER,
            HEALBOT_ARCANE_POWER,
            HEALBOT_SLOW_FALL,
            HEALBOT_FOCUS_MAGIC,
            HEALBOT_ICE_WARD,
            HEALBOT_ICE_BARRIER,
            HBC_DAMPEN_MAGIC,
            HBC_FROST_ARMOR,
            HBC_ICE_ARMOR,
        }
    elseif tClass=="MONK" then
        HealBot_Buff_Spells_Class_List = {
            HEALBOT_LEGACY_EMPEROR,
            HEALBOT_LEGACY_WHITETIGER,
            HEALBOT_RUSHING_JADE_WIND,
            HEALBOT_STANCE_MONK_TIGER,
            HEALBOT_STANCE_MONK_SERPENT,
            HEALBOT_STANCE_MONK_CRANE,
        }
    elseif tClass=="PALA" then
        HealBot_Buff_Spells_Class_List = {
            HEALBOT_BLESSING_OF_MIGHT,
            HBC_BLESSING_OF_MIGHT,
            HBC_GREATER_BLESSING_OF_MIGHT,
            HBC_BLESSING_OF_SANCTUARY,
            HBC_GREATER_BLESSING_OF_SANCTUARY,
            HEALBOT_BLESSING_OF_KINGS,
            HBC_BLESSING_OF_KINGS,
            HBC_GREATER_BLESSING_OF_KINGS,
            HBC_BLESSING_OF_LIGHT,
            HBC_GREATER_BLESSING_OF_LIGHT,
            HEALBOT_BLESSING_OF_WISDOM,
            HBC_BLESSING_OF_WISDOM,
            HBC_GREATER_BLESSING_OF_WISDOM,
            HEALBOT_HAND_OF_FREEDOM,
            HEALBOT_HAND_OF_PROTECTION,
            HEALBOT_HAND_OF_SALVATION,
            HBC_GREATER_BLESSING_OF_SALVATION,
            HEALBOT_RIGHTEOUS_FURY,
            HEALBOT_DEVOTION_AURA,
            HBC_RETRIBUTION_AURA,
            HBC_FIRE_RESISTANCE_AURA,
            HBC_FROST_RESISTANCE_AURA,
            HBC_SHADOW_RESISTANCE_AURA,
            HEALBOT_BEACON_OF_LIGHT,
            HEALBOT_BEACON_OF_VIRTUE,
            HEALBOT_SEAL_OF_RIGHTEOUSNESS,
            HEALBOT_SEAL_OF_INSIGHT,
            HEALBOT_SEAL_OF_JUSTICE,
            HEALBOT_SEAL_OF_COMMAND,
            HEALBOT_SEAL_OF_TRUTH,
            HBC_SEAL_OF_THE_CRUSADER,
            HEALBOT_SACRED_SHIELD,
        }
        if HEALBOT_GAME_VERSION>3 then
            local i = GetSpecialization()
            local specID = 0
            if i then specID = GetSpecializationInfo(i,false,false) end
            if specID==70 then
                table.insert(HealBot_Buff_Spells_Class_List,HEALBOT_SEAL_OF_JUSTICE)
            end
        end
    elseif tClass=="PRIE" then
        HealBot_Buff_Spells_Class_List = {
            HEALBOT_POWER_WORD_FORTITUDE,
            HBC_POWER_WORD_FORTITUDE,
            HBC_SHADOW_PROTECTION,
            HBC_TOUCH_OF_WEAKNESS,
            HBC_DIVINE_SPIRIT,
            HBC_PRAYER_OF_SHADOW_PROTECTION,
            HBC_PRAYER_OF_SPIRIT,
            HBC_INNER_FIRE,
            HEALBOT_FEAR_WARD,
            HBC_SHADOWGUARD,
            HEALBOT_SHADOWFORM,
            HEALBOT_LEVITATE,
        }
    elseif tClass=="ROGU" then
        HealBot_Buff_Spells_Class_List = {
        }
    elseif tClass=="SHAM" then
        HealBot_Buff_Spells_Class_List = {
            HEALBOT_LIGHTNING_SHIELD,
            HBC_LIGHTNING_SHIELD,
            HEALBOT_EARTH_SHIELD,
            HEALBOT_WATER_SHIELD,
            HEALBOT_WATER_WALKING,
            --HBC_ROCKBITER_WEAPON,
        }
    elseif tClass=="WARL" then
        HealBot_Buff_Spells_Class_List = {
            HEALBOT_DEMON_ARMOR,
            HBC_DEMON_ARMOR,
            HEALBOT_FEL_ARMOR,
            HEALBOT_UNENDING_BREATH,
            HEALBOT_DARK_INTENT,
            HEALBOT_SOUL_LINK,
        }
    elseif tClass=="WARR" then
        HealBot_Buff_Spells_Class_List = {
            HEALBOT_BATTLE_SHOUT,
            HEALBOT_COMMANDING_SHOUT,
            HEALBOT_VIGILANCE,
        }
    end
end

function HealBot_Options_InitBuffClassList()
    HealBot_Options_InitBuffSpellsClassList(HealBot_Data["PCLASSTRIM"])
    table.sort(HealBot_Buff_Spells_Class_List)
end

local HealBot_Buff_Items_Lookup={}
function HealBot_Options_retItemID(itemName)
    return HealBot_Buff_Items_Lookup[itemName]
end

function HealBot_Options_InitBuffList()
    HealBot_Buff_Spells_List ={}
    for j=1, getn(HealBot_Buff_Spells_Class_List), 1 do
        local spellName=HealBot_KnownSpell(HealBot_Buff_Spells_Class_List[j])
        if spellName then
            table.insert(HealBot_Buff_Spells_List,spellName)
        end
    end
    for x,_ in pairs(HealBot_Buff_Items_Lookup) do
        HealBot_Buff_Items_Lookup[x]=nil
    end 
    for j=1, getn(HealBot_Buff_Items_List), 1 do
        if IsUsableItem(HealBot_Buff_Items_List[j]) or HealBot_IsItemInBag(HealBot_Buff_Items_List[j]) then   
            local itemName=GetItemInfo(HealBot_Buff_Items_List[j])
            if itemName then 
                table.insert(HealBot_Buff_Spells_List,itemName) 
                HealBot_Buff_Items_Lookup[itemName]=HealBot_Buff_Items_List[j]
            end
        end
    end
end

function HealBot_Options_GetDebuffSpells_List(class)
    local HealBot_Debuff_Spells = {}
    if HEALBOT_GAME_VERSION<4 then 
        HealBot_Debuff_Spells = {
          ["DEAT"] = {},
          ["DEMO"] = {}, -- Demon Hunter
          ["DRUI"] = {HBC_DRUID_CURE_POISON, HBC_DRUID_ABOLISH_POISON, HBC_DRUID_REMOVE_CURSE, },
          ["HUNT"] = {},
          ["MAGE"] = {HEALBOT_REMOVE_CURSE,},
          ["MONK"] = {},
          ["PALA"] = {HEALBOT_CLEANSE, HBC_PURIFY},
          ["PRIE"] = {HBC_DISPELL_MAGIC, HBC_PRIEST_CURE_DISEASE, HBC_PRIEST_ABOLISH_DISEASE},
          ["ROGU"] = {},
          ["SHAM"] = {HBC_SHAMAN_CURE_POISON, HBC_SHAMAN_CURE_DISEASE},
          ["WARL"] = {},
          ["WARR"] = {},
        }
    else
        HealBot_Debuff_Spells = {
          ["DEAT"] = {},
          ["DEMO"] = {}, -- Demon Hunter
          ["DRUI"] = {HEALBOT_REMOVE_CORRUPTION, HEALBOT_NATURES_CURE,},
          ["HUNT"] = {},
          ["MAGE"] = {HEALBOT_REMOVE_CURSE,},
          ["MONK"] = {HEALBOT_DETOX,},
          ["PALA"] = {HEALBOT_CLEANSE, HEALBOT_CLEANSE_TOXIN},
          ["PRIE"] = {HEALBOT_PURIFY, HEALBOT_MASS_DISPEL, HEALBOT_PURIFY_DISEASE},
          ["ROGU"] = {},
          ["SHAM"] = {HEALBOT_PURIFY_SPIRIT, HEALBOT_CLEANSE_SPIRIT},
          ["WARL"] = {},
          ["WARR"] = {},
        }
    end
    --if (strsub(GetLocale(),1,2)~="en") then
    --    HealBot_Debuff_Spells["SHAM"] = {HEALBOT_CLEANSE_SPIRIT}
    --end
    return HealBot_Debuff_Spells[class]
end

function HealBot_Options_GetRacialDebuffSpells_List(race)
    local HealBot_Racial_Debuff_Spells = {
      ["Human"] = {},
      ["Dwarf"] = {HEALBOT_STONEFORM,},
      ["Night Elf"] = {},
      ["Gnome"] = {},
      ["Draenei"] = {HEALBOT_GIFT_OF_THE_NAARU,},
      ["Pandaren"] = {},
      ["Orc"] = {},
      ["Undead"] = {},
      ["Tauren"] = {},
      ["Troll"] = {}, 
      ["Blood Elf"] = {},
      ["Goblin"] = {},
      ["Worgen"] = {HEALBOT_DARKFLIGHT,},
      ["Highmountain Tauren"] = {},
      ["Void Elf"] = {},
      ["Lightforged Draenei"] = {},
      ["Nightborne"] = {},
    }
    local rArray = {}
    if HealBot_Racial_Debuff_Spells[race] then
        rArray = HealBot_Racial_Debuff_Spells[race]
    end
    return rArray
end



function HealBot_Options_setDebuffTypes()
    if HealBot_Data["PCLASSTRIM"]=="SHAM" then
        if HealBot_Config.CurrentSpec==3 then
            HealBot_Debuff_Types[HEALBOT_CLEANSE_SPIRIT]={HEALBOT_MAGIC_en, HEALBOT_CURSE_en}
            HealBot_Debuff_Types[HEALBOT_PURIFY_SPIRIT]={HEALBOT_MAGIC_en, HEALBOT_CURSE_en}
        else
            HealBot_Debuff_Types[HEALBOT_CLEANSE_SPIRIT]={HEALBOT_CURSE_en}
            HealBot_Debuff_Types[HEALBOT_PURIFY_SPIRIT]={HEALBOT_CURSE_en}
        end
    elseif HealBot_Data["PCLASSTRIM"]=="MONK" then
        if HealBot_Config.CurrentSpec==2 then
            HealBot_Debuff_Types[HEALBOT_DETOX]={HEALBOT_MAGIC_en, HEALBOT_DISEASE_en, HEALBOT_POISON_en}
        else
            HealBot_Debuff_Types[HEALBOT_DETOX]={HEALBOT_DISEASE_en, HEALBOT_POISON_en}
        end
    end
end

function HealBot_Options_ReloadUI(reason)
    local msg=HEALBOT_OPTIONS_RELOADUIMSG
    if reason then msg=reason.."\n"..msg end
    StaticPopupDialogs["HEALBOT_OPTIONS_RELOADUI"] = {
        text = msg,
        button1 = HEALBOT_WORDS_YES,
        button2 = HEALBOT_WORDS_NO,
        OnAccept = function()
            ReloadUI();
        end,
        timeout = 0,
        whileDead = 1,
        hideOnEscape = 1
    };

    StaticPopup_Show ("HEALBOT_OPTIONS_RELOADUI");
end

local hbOptGetSkinFrom=" "
local hbOptGetSkinName=" "

local function HealBot_Options_LangAddonFail(lang, reason)
                     
    StaticPopupDialogs["HEALBOT_OPTIONS_MISSINGLANG"] = {
        text = HEALBOT_OPTIONS_LANG_ADDON_FAIL1.." "..lang.."\n"..HEALBOT_OPTIONS_LANG_ADDON_FAIL2.." "..reason.."\n\n"..HEALBOT_OPTIONS_LANG_ADDON_FAIL3.." "..lang,
        button1 = CLOSE,
        timeout = 0,
        whileDead = 1,
        hideOnEscape = 1
    };
    StaticPopup_Show("HEALBOT_OPTIONS_MISSINGLANG");
end


local function HealBot_Options_ImportFail(import, reason)
                     
    StaticPopupDialogs["HEALBOT_OPTIONS_IMPORTFAIL"] = {
        text = HEALBOT_OPTIONS_IMPORT_FAIL1.." "..import.."\n\n"..HEALBOT_OPTIONS_IMPORT_FAIL2.."\n"..reason,
        button1 = CLOSE,
        timeout = 0,
        whileDead = 1,
        hideOnEscape = 1
    };
    StaticPopup_Show("HEALBOT_OPTIONS_IMPORTFAIL");
end

function HealBot_Options_retIsDebuffSpell(spellName)
    if HealBot_Debuff_Types[spellName] then
        return true
    end
    return nil
end

function HealBot_Options_retDebuffWatchTarget(debuffType)
    return HealBot_DebuffWatchTarget[debuffType]
end

function HealBot_Options_retDebuffCureSpell(debuffType)
    return HealBot_DebuffSpell[debuffType]
end

function HealBot_Options_retDebuffWatchTargetCD(debuffType)
    local remain=0
    if HealBot_DebuffSpell[debuffType] then
        local start, duration, _, _ = GetSpellCooldown(HealBot_DebuffSpell[debuffType]);
        if start and duration and duration>1 then 
            remain = duration-(GetTime()-start)
        end
    end
    return remain
end

function HealBot_Options_retBuffWatchTarget(buffName)
    return HealBot_BuffWatchTarget[buffName]
end

function HealBot_Options_retDebuffPriority(spellId, debuffType)
    return HealBot_Globals.HealBot_Custom_Debuffs[spellId] or 89, HealBot_Config_Cures.HealBotDebuffPriority[debuffType] or 88
end

function HealBot_Options_Pct_OnLoad(self,vText)
    self.text = vText;
    local g=_G[self:GetName().."Text"]
    g:SetText(vText);
    g=_G[self:GetName().."Low"]
    g:SetText("0%");
    g=_G[self:GetName().."High"]
    g:SetText("100%");
    self:SetMinMaxValues(0.00,1.00);
    self:SetValueStep(0.01);
    self:SetStepsPerPage(5);
end

function HealBot_Options_Pct_OnLoad_MinMax(self,vText,Min,Max,Step,pageStep)
    self.text = vText;
    local StepsPerPage=pageStep or 5
    local i=(Min*100).."%";
    local j=(Max*100).."%";

    local g=_G[self:GetName().."Text"]
    g:SetText(vText);
    g=_G[self:GetName().."Low"]
    g:SetText(i);
    g=_G[self:GetName().."High"]
    g:SetText(j);
    self:SetMinMaxValues(Min,Max);
    self:SetValueStep(Step);
    self:SetStepsPerPage(StepsPerPage);
end

function HealBot_Options_val_OnLoad(self,vText,Min,Max,Step,pageStep)
    self.text = vText;
    local StepsPerPage=pageStep or HealBot_Options_getStepsPerPage(Max,Step)
    local g=_G[self:GetName().."Text"]
    g:SetText(vText);
    g=_G[self:GetName().."Low"]
    g:SetText(Min);
    g=_G[self:GetName().."High"]
    g:SetText(Max);
    self:SetMinMaxValues(Min,Max);
    self:SetValueStep(Step);
    self:SetStepsPerPage(StepsPerPage);
end

function HealBot_Options_valNoCols_OnLoad(self,Min,Max)
    local g=_G[self:GetName().."Text"]
    g:SetText(HealBot_Options_SetNoColsText);
    g=_G[self:GetName().."Low"]
    g:SetText(Min);
    g=_G[self:GetName().."High"]
    g:SetText(Max);
    self:SetMinMaxValues(Min,Max);
    self:SetValueStep(1);
    self:SetStepsPerPage(2);
end

function HealBot_Options_val2_OnLoad(self,vText,Min,Max,Step,vDiv,pageStep)
    self.text = vText;
    local StepsPerPage=pageStep or HealBot_Options_getStepsPerPage(Max,Step)
    local g=_G[self:GetName().."Text"]
    g:SetText(vText);
    g=_G[self:GetName().."Low"]
    g:SetText(Min/vDiv);
    g=_G[self:GetName().."High"]
    g:SetText(Max/vDiv);
    self:SetMinMaxValues(Min,Max);
    self:SetValueStep(Step);
    self:SetStepsPerPage(StepsPerPage);
end

function HealBot_Options_sliderlabels_Init(self,vText,Min,Max,Step,pageStep,lowTxt,highTxt)
    self.text = vText;
    local StepsPerPage=pageStep or HealBot_Options_getStepsPerPage(Max,Step)
    local g=_G[self:GetName().."Text"]
    g:SetText(vText);
    g=_G[self:GetName().."Low"]
    g:SetText(lowTxt);
    g=_G[self:GetName().."High"]
    g:SetText(highTxt);
    self:SetMinMaxValues(Min,Max);
    self:SetValueStep(Step);
    self:SetStepsPerPage(StepsPerPage);
end

function HealBot_Options_valtime_OnLoad(self,vText,Min,Max,Step,secsOnly,pageStep)
    self.text = vText;
    local StepsPerPage=pageStep or 2 --HealBot_Options_getStepsPerPage(Max,Step)
    local g=_G[self:GetName().."Text"]
    g:SetText(vText);
    if secsOnly then
        g=_G[self:GetName().."Low"]
        g:SetText(Min);
        g=_G[self:GetName().."High"]
        g:SetText(Max);
    else
        g=_G[self:GetName().."Low"]
        g:SetText(Min/60);
        g=_G[self:GetName().."High"]
        g:SetText(Max/60);
    end
    self:SetMinMaxValues(Min,Max);
    self:SetValueStep(Step);
    self:SetStepsPerPage(StepsPerPage);
end

function HealBot_Options_getStepsPerPage(Max,Step)
    local i=ceil(Max/10)
    if i<Step then i=Step end
    if i>20 then
        i=10
    elseif i>5 then
        i=5
    elseif i>2 then
        i=2
    end
    return i
end

function HealBot_Options_SetText(self,vText)
    local g=_G[self:GetName().."Text"]
    g:SetText(vText);
end

function HealBot_Options_UIDropDownMenu_OnLoad(self, width)
    UIDropDownMenu_SetWidth(self,width)
end

function HealBot_Options_UIDropDownMenu_OnClick(varName, varValue)
    HealBot_Options_StorePrev[varName]=varValue
    HealBot_AddDebug(varName.."="..varValue)
end

function HealBot_Options_NotifyOtherMsg_OnTextChanged(self)
    Healbot_Config_Skins.Chat[Healbot_Config_Skins.Current_Skin]["MSG"] = self:GetText()
end

function HealBot_Options_SetNoColsText()
    if Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOW"] then
        HealBot_Options_BarNumGroupPerCol:Hide()
        return HEALBOT_OPTIONS_SKINNUMHCOLS;
    else
        HealBot_Options_BarNumGroupPerCol:Show()
        if Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["GRPCOLS"] then
            return HEALBOT_OPTIONS_SKINNUMHCOLS;
        else
            return HEALBOT_OPTIONS_SKINNUMCOLS;
        end
    end
end

function HealBot_Options_Pct_OnValueChanged(self)
    local pct = floor(self:GetValue()*100+0.5);
    local g=_G[self:GetName().."Text"]
    g:SetText(self.text .. " (" .. pct .. "%)");
    return self:GetValue();
end

function HealBot_Options_NewSkin_OnTextChanged(self)
    local text= self:GetText()
    if strlen(text)>0 then
        HealBot_Options_NewSkinb:Enable();
    else
        HealBot_Options_NewSkinb:Disable();
    end
end

function HealBot_Options_NewSkinb_OnClick(self)
    local skinName = HealBot_Options_NewSkin:GetText()
    if tonumber(skinName) then skinName='#'..skinName end
    HealBot_Options_setNewSkin(skinName)
end

function HealBot_Options_setNewSkin(newSkinName)
    Healbot_Config_Skins.HealBar[newSkinName]=HealBot_Options_copyTable(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin])
    Healbot_Config_Skins.BarTextCol[newSkinName] = HealBot_Options_copyTable(Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin])
    Healbot_Config_Skins.BarCol[newSkinName] = HealBot_Options_copyTable(Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin])
    Healbot_Config_Skins.BarIACol[newSkinName] = HealBot_Options_copyTable(Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin])
    Healbot_Config_Skins.Frame[newSkinName] = HealBot_Options_copyTable(Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin])
    Healbot_Config_Skins.StickyFrames[newSkinName] = HealBot_Options_copyTable(Healbot_Config_Skins.StickyFrames[Healbot_Config_Skins.Current_Skin])
    Healbot_Config_Skins.HeadBar[newSkinName] = HealBot_Options_copyTable(Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin])
    Healbot_Config_Skins.HeadText[newSkinName] = HealBot_Options_copyTable(Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin])
    Healbot_Config_Skins.General[newSkinName] = HealBot_Options_copyTable(Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin])
    Healbot_Config_Skins.BarHighlight[newSkinName] = HealBot_Options_copyTable(Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin])
    Healbot_Config_Skins.RaidIcon[newSkinName] = HealBot_Options_copyTable(Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin])
    Healbot_Config_Skins.Icons[newSkinName] = HealBot_Options_copyTable(Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin])
    Healbot_Config_Skins.BarAggro[newSkinName] = HealBot_Options_copyTable(Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin])
    Healbot_Config_Skins.BarText[newSkinName] = HealBot_Options_copyTable(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin])
    Healbot_Config_Skins.IconText[newSkinName] = HealBot_Options_copyTable(Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin])
    Healbot_Config_Skins.HealGroups[newSkinName] = HealBot_Options_copyTable(Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin])
    Healbot_Config_Skins.Healing[newSkinName] = HealBot_Options_copyTable(Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin])
    Healbot_Config_Skins.Chat[newSkinName] = HealBot_Options_copyTable(Healbot_Config_Skins.Chat[Healbot_Config_Skins.Current_Skin])
    Healbot_Config_Skins.Anchors[newSkinName] = HealBot_Options_copyTable(Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin])
    HealBot_Config.SkinDefault[newSkinName] = {[HEALBOT_WORD_SOLO]=false, 
                                               [HEALBOT_WORD_PARTY]=false, 
                                               [HEALBOT_OPTIONS_RAID10]=false, 
                                               [HEALBOT_OPTIONS_RAID25]=false, 
                                               [HEALBOT_OPTIONS_RAID40]=false,
                                               [HEALBOT_WORD_ARENA]=false, 
                                               [HEALBOT_WORD_BG10]=false, 
                                               [HEALBOT_WORD_BG15]=false, 
                                               [HEALBOT_WORD_BG40]=false, 
                                               [HEALBOT_WORD_PETBATTLE]=false}
    Healbot_Config_Skins.IncludeGroup[newSkinName] = HealBot_Options_copyTable(Healbot_Config_Skins.IncludeGroup[Healbot_Config_Skins.Current_Skin])
    Healbot_Config_Skins.Protection[newSkinName] = HealBot_Options_copyTable(Healbot_Config_Skins.Protection[Healbot_Config_Skins.Current_Skin])
    Healbot_Config_Skins.BarVisibility[newSkinName] = HealBot_Options_copyTable(Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin])
    Healbot_Config_Skins.FrameAlias[newSkinName] = HealBot_Options_copyTable(Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin])
    Healbot_Config_Skins.FrameAliasBar[newSkinName] = HealBot_Options_copyTable(Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin])
    Healbot_Config_Skins.Enemy[newSkinName] = HealBot_Options_copyTable(Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin])
    Healbot_Config_Skins.BarSort[newSkinName] = HealBot_Options_copyTable(Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin])
    Healbot_Config_Skins.Author[newSkinName] = HealBot_GetUnitName("Player").." "..HEALBOT_PLAYER_OF_REALM.." "..GetRealmName()
    local unique=true;
    table.foreach(Healbot_Config_Skins.Skins, function (index,skin)
        if skin==newSkinName then unique=false; end
    end)
    if unique then
        table.insert(Healbot_Config_Skins.Skins,2,newSkinName)
        Healbot_Config_Skins.Skin_ID = 2;
    end
    HealBot_Options_Set_Current_Skin(newSkinName)
    HealBot_Options_NewSkin:SetText("")
    HealBot_Options_SetSkins();
end

function HealBot_Options_copyTable(t)
    if t == nil then return nil end
    local nt = {}
    for k, v in pairs(t) do
        if type(v) == 'table' then
            nt[k] = HealBot_Options_copyTable(v)
        else
            nt[k] = v
        end
    end
    return nt
end

function HealBot_Options_DeleteSkin_OnClick(self)
    if Healbot_Config_Skins.Current_Skin~=HEALBOT_SKINS_STD then
        local hbDelSkinName=HealBot_Options_SkinsText:GetText()
        Healbot_Config_Skins.HealBar[hbDelSkinName] = nil
        Healbot_Config_Skins.BarTextCol[hbDelSkinName] = nil
        Healbot_Config_Skins.BarCol[hbDelSkinName] = nil
        Healbot_Config_Skins.BarIACol[hbDelSkinName] = nil
        Healbot_Config_Skins.Frame[hbDelSkinName] = nil
        Healbot_Config_Skins.StickyFrames[hbDelSkinName] = nil
        Healbot_Config_Skins.HeadBar[hbDelSkinName] = nil
        Healbot_Config_Skins.HeadText[hbDelSkinName] = nil
        Healbot_Config_Skins.General[hbDelSkinName] = nil
        Healbot_Config_Skins.BarHighlight[hbDelSkinName] = nil
        Healbot_Config_Skins.RaidIcon[hbDelSkinName] = nil
        Healbot_Config_Skins.Icons[hbDelSkinName] = nil
        Healbot_Config_Skins.BarAggro[hbDelSkinName] = nil
        Healbot_Config_Skins.BarText[hbDelSkinName] = nil
        Healbot_Config_Skins.IconText[hbDelSkinName] = nil
        Healbot_Config_Skins.HealGroups[hbDelSkinName] = nil
        Healbot_Config_Skins.Healing[hbDelSkinName] = nil
        Healbot_Config_Skins.BarVisibility[hbDelSkinName] = nil
        Healbot_Config_Skins.Chat[hbDelSkinName] = nil
        Healbot_Config_Skins.Anchors[hbDelSkinName] = nil
        HealBot_Config.SkinDefault[hbDelSkinName] = nil
        Healbot_Config_Skins.BarVisibility[hbDelSkinName] = nil
        Healbot_Config_Skins.Protection[hbDelSkinName] = nil
        Healbot_Config_Skins.Author[hbDelSkinName] = nil
        Healbot_Config_Skins.FrameAlias[hbDelSkinName] = nil
        Healbot_Config_Skins.FrameAliasBar[hbDelSkinName] = nil
        Healbot_Config_Skins.IncludeGroup[hbDelSkinName] = nil
        Healbot_Config_Skins.Enemy[hbDelSkinName] = nil
        table.remove(Healbot_Config_Skins.Skins,Healbot_Config_Skins.Skin_ID)
        local retryWithSkin = HealBot_getDefaultSkin()
        HealBot_Options_Set_Current_Skin(retryWithSkin)
        HealBot_Options_SetSkins();
    end
end

function HealBot_Options_ShowEnemyIncSelf_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCSELF"]=true
    else
        Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCSELF"]=false
    end
    HealBot_Options_framesChanged(10) 
end

function HealBot_Options_ShowEnemyIncTanks_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCTANKS"]=true
    else
        Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCTANKS"]=false
    end
    HealBot_Options_framesChanged(10) 
end

function HealBot_Options_ShowEnemyIncArena_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCARENA"]=true
    else
        Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCARENA"]=false
    end
    HealBot_Options_framesChanged(10) 
end

function HealBot_Options_ShowEnemyIncArenaPets_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCARENAPETS"]=true
    else
        Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCARENAPETS"]=false
    end
    HealBot_Options_framesChanged(10) 
end

function HealBot_Options_ShowEnemyIncMyTargets_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCMYTAR"]=true
    else
        Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCMYTAR"]=false
    end
    HealBot_Options_framesChanged(10) 
end

function HealBot_Options_HideEnemyOutOfCombat_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["HIDE"]=true
    else
        Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["HIDE"]=false
    end
    HealBot_Options_framesChanged(10) 
end

function HealBot_Options_EnemyExistsPlayerTargets_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["EXISTSHOWPTAR"]=true
    else
        Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["EXISTSHOWPTAR"]=false
    end
end

function HealBot_Options_EnemyExistsArena_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["EXISTSHOWARENA"]=true
    else
        Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["EXISTSHOWARENA"]=false
    end
end

function HealBot_Options_EnemyExistsBosses_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["EXISTSHOWBOSS"]=true
    else
        Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["EXISTSHOWBOSS"]=false
    end
end

function HealBot_Options_CrashProt_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Protection[Healbot_Config_Skins.Current_Skin]["CRASH"]=true
    else
        Healbot_Config_Skins.Protection[Healbot_Config_Skins.Current_Skin]["CRASH"]=false
    end
    HealBot_useCrashProtection()
    HealBot_Options_framesChanged(1)
end

function HealBot_Options_UseGeneralMacros_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Protection[Healbot_Config_Skins.Current_Skin]["GENERALMACRO"]=true
    else
        Healbot_Config_Skins.Protection[Healbot_Config_Skins.Current_Skin]["GENERALMACRO"]=false
    end
    DeleteMacro(HealBot_Config.CrashProtMacroName.."_0")
    DeleteMacro(HealBot_Config.CrashProtMacroName.."_1")
    DeleteMacro(HealBot_Config.CrashProtMacroName.."_2")
    DeleteMacro(HealBot_Config.CrashProtMacroName.."_3")
    DeleteMacro(HealBot_Config.CrashProtMacroName.."_4")
    HealBot_Options_cpMacroSave:SetText(HEALBOT_CP_MACRO_SAVE)
    HealBot_Options_SetcpMacroSave(HEALBOT_CP_MACRO_SAVE)
    HealBot_useCrashProtection()
    HealBot_Options_framesChanged(1)
end

function HealBot_Options_AfterCombatOOM_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Chat[Healbot_Config_Skins.Current_Skin]["EOCOOM"]=true
    else
        Healbot_Config_Skins.Chat[Healbot_Config_Skins.Current_Skin]["EOCOOM"]=false
    end
end

function HealBot_Options_CombatProt_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Protection[Healbot_Config_Skins.Current_Skin]["COMBAT"]=true
    else
        Healbot_Config_Skins.Protection[Healbot_Config_Skins.Current_Skin]["COMBAT"]=false
    end
    HealBot_Options_framesChanged(1)
end

function HealBot_Options_CombatPartyProt_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Protection[Healbot_Config_Skins.Current_Skin]["COMBATPARTY"]=true
    else
        Healbot_Config_Skins.Protection[Healbot_Config_Skins.Current_Skin]["COMBATPARTY"]=false
    end
    HealBot_Options_framesChanged(1)
end

function HealBot_Options_CombatRaidProt_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Protection[Healbot_Config_Skins.Current_Skin]["COMBATRAID"]=true
    else
        Healbot_Config_Skins.Protection[Healbot_Config_Skins.Current_Skin]["COMBATRAID"]=false
    end
    HealBot_Options_framesChanged(1)
end

function HealBot_Options_CrashProt_OnTextChanged(self)
    local text = self:GetText()
    if strlen(text)<1 or strlen(text)>14 then
        HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CP_MACRO_LEN)
        HealBot_Options_CrashProtEditBox:SetText(HealBot_Config.CrashProtMacroName)
    else
        if text~=HealBot_Config.CrashProtMacroName then
            DeleteMacro(HealBot_Config.CrashProtMacroName.."_0")
            DeleteMacro(HealBot_Config.CrashProtMacroName.."_1")
            DeleteMacro(HealBot_Config.CrashProtMacroName.."_2")
            DeleteMacro(HealBot_Config.CrashProtMacroName.."_3")
            DeleteMacro(HealBot_Config.CrashProtMacroName.."_4")
        end
        HealBot_Config.CrashProtMacroName = self:GetText()
    end
end

function HealBot_Options_CrashProtStartTime_OnValueChanged(self)
    local val=floor(self:GetValue()+0.5)
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        HealBot_Config.CrashProtStartTime = val;
        local g=_G[self:GetName().."Text"]
        g:SetText(self.text .. ": " .. val.." "..HEALBOT_WORDS_SEC);
    end
end

function HealBot_Options_ShowEnemyNumBoss_OnValueChanged(self)
    local val=floor(self:GetValue()+0.5)
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["NUMBOSS"] = val;
        local g=_G[self:GetName().."Text"]
        g:SetText(self.text .. ": " .. val);
        HealBot_Options_framesChanged(10)
    end
end

function HealBot_Options_ShowHeaders_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOW"] = true
    else
        Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOW"] = false
    end
    HealBot_Options_BarNumColsSText:SetText(HealBot_Options_SetNoColsText() .. ": " .. Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["NUMCOLS"]);
    HealBot_Panel_ClearBarArrays()
    HealBot_setOptions_Timer(150)
end
 
function HealBot_Options_PlayBuffSound_OnClick(self)
    PlaySoundFile(LSM:Fetch('sound',sounds[HealBot_Options_BuffWarningSound:GetValue()]));    
end
    
function HealBot_Options_PlaySound_OnClick(self)
    PlaySoundFile(LSM:Fetch('sound',sounds[HealBot_Options_WarningSound:GetValue()]));    
end
    
function HealBot_Options_WarningSound_OnValueChanged(self)
    local g=nil
    local v=floor(self:GetValue()+0.5)
    if v~=self:GetValue() then
        self:SetValue(v) 
    else
        if v > 0 and sounds then
            HealBot_Config_Cures.SoundDebuffPlay = sounds[v];
            g=_G[self:GetName().."Text"]
            g:SetText(self.text .. " ".. v..": " ..sounds[v]);
        else
            g=_G[self:GetName().."Text"]
            g:SetText(self.text);
        end
        if not DoneInitTab[4] and not updatingMedia then
            PlaySoundFile(LSM:Fetch('sound',HealBot_Config_Cures.SoundDebuffPlay));
        end
        updatingMedia=false;
    end
end
    
function HealBot_Options_BuffWarningSound_OnValueChanged(self)
    local g=nil
    local v=floor(self:GetValue()+0.5)
    if v~=self:GetValue() then
        self:SetValue(v) 
    else
        if v > 0 and sounds then
            HealBot_Config_Buffs.SoundBuffPlay = sounds[v];
            g=_G[self:GetName().."Text"]
            g:SetText(self.text .. " ".. v..": " ..sounds[v]);
        else
            g=_G[self:GetName().."Text"]
            g:SetText(self.text);
        end
        if not DoneInitTab[5] and not updatingMedia then
            PlaySoundFile(LSM:Fetch('sound',HealBot_Config_Buffs.SoundBuffPlay));
        end
        updatingMedia=false;
    end
end

function HealBot_Options_BarTextureS_OnValueChanged(self)
    local g=nil
    local v=floor(self:GetValue()+0.5)
    if v~=self:GetValue() then
        self:SetValue(v) 
    else
        if v > 0 and hb_textures then
            Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"] = hb_textures[v];
            g=_G[self:GetName().."Text"]
            g:SetText(self.text .. " "..v..": " .. hb_textures[v]);
        else
            g=_G[self:GetName().."Text"]
            g:SetText(self.text);
        end    
        if not updatingMedia then
            HealBot_setOptions_Timer(150)
            HealBot_setOptions_Timer(160)
        end
        updatingMedia=false;
    end
end

function HealBot_FrameStickyOffsetHorizontal_OnValueChanged(self)
    local val=floor(self:GetValue()+0.5)
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SFOFFSETH"] = val;
        local g=_G[self:GetName().."Text"]
        g:SetText(self.text .. ": " .. val);
        HealBot_setOptions_Timer(7000)
    end
end

function HealBot_FrameStickyOffsetVertical_OnValueChanged(self)
    local val=floor(self:GetValue()+0.5)
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SFOFFSETV"] = val;
        local g=_G[self:GetName().."Text"]
        g:SetText(self.text .. ": " .. val);
        HealBot_setOptions_Timer(7000)
    end
end

function HealBot_Options_AfterCombatOOMValue_OnValueChanged(self)
    local val=floor(self:GetValue()+0.5)
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        Healbot_Config_Skins.Chat[Healbot_Config_Skins.Current_Skin]["EOCOOMV"] = val;
        local g=_G[self:GetName().."Text"]
        g:SetText(self.text .. ": " .. val .. "%");
    end
end

function HealBot_FrameScale_OnValueChanged(self)
--    local val=floor(self:GetValue()+0.5)
    local val=HealBot_Comm_round(self:GetValue(), 1)
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        val=val/10;
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SCALE"] = val;
        local g=_G[self:GetName().."Text"]
        g:SetText(self.text .. ": " .. val);
        HealBot_setOptions_Timer(150)
    end
end

function HealBot_BarButtonMaxDebuffIcons_OnValueChanged(self)
    local val=floor(self:GetValue()+0.5)
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["MAXDICONS"] = val;
        local g=_G[self:GetName().."Text"]
        g:SetText(self.text .. ": " .. val);
    end
end

function HealBot_BarButtonMaxBuffIcons_OnValueChanged(self)
    local val=floor(self:GetValue()+0.5)
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["MAXBICONS"] = val;
        local g=_G[self:GetName().."Text"]
        g:SetText(self.text .. ": " .. val);
    end
end

function HealBot_BarButtonIconScale_OnValueChanged(self)
--    local val=floor(self:GetValue()+0.5)
    local val=HealBot_Comm_round(self:GetValue(), 1)
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        val=val/10;
        Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SCALE"] = val;
        local g=_G[self:GetName().."Text"]
        g:SetText(self.text .. ": " .. val);
        HealBot_setOptions_Timer(150)
    end
end

function HealBot_BarDebuffButtonIconScale_OnValueChanged(self)
--    local val=floor(self:GetValue()+0.5)
    local val=HealBot_Comm_round(self:GetValue(), 1)
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        val=val/10;
        Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["DSCALE"] = val;
        local g=_G[self:GetName().."Text"]
        g:SetText(self.text .. ": " .. val);
        HealBot_setOptions_Timer(150)
    end
end

function HealBot_BarButtonIconFadeStartTime_OnValueChanged(self)
    local val=HealBot_Comm_round(self:GetValue(), 0)
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["FADESECS"] = val;
        HealBot_setLuVars("FadeTimeDiv", (val*1.125))
        local g=_G[self:GetName().."Text"]
        g:SetText(self.text .. ": " .. val .. " " .. HEALBOT_WORDS_SEC);
    end
end

function HealBot_BarButtonIconTextScale_OnValueChanged(self)
--    local val=floor(self:GetValue()+0.5)
    local val=HealBot_Comm_round(self:GetValue(), 1)
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HEIGHT"] = val;
        local g=_G[self:GetName().."Text"]
        g:SetText(self.text .. ": " .. val);
        HealBot_setOptions_Timer(150)
    end
end

function HealBot_BarButtonIconTextDurationTime_OnValueChanged(self)
    local val=floor(self:GetValue()+0.5)
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["DURTHRH"]=val;
        local g=_G[self:GetName().."Text"]
        g:SetText(self.text .. ": " .. Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["DURTHRH"]);
    end
end

function HealBot_BarButtonIconTextDurationWarn_OnValueChanged(self)
    local val=floor(self:GetValue()+0.5)
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["DURWARN"]=val;
        local g=_G[self:GetName().."Text"]
        g:SetText(self.text .. ": " .. Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["DURWARN"]);
    end
end

function HealBot_Options_HeadTextureS_OnValueChanged(self)
    local g=nil
    local val=floor(self:GetValue()+0.5)
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        if val > 0 and hb_textures then
            Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"] = hb_textures[val];
            g=_G[self:GetName().."Text"]
            g:SetText(self.text .. " " .. val..": " .. hb_textures[val]);
        else
            g=_G[self:GetName().."Text"]
            g:SetText(self.text);
        end  
        if not updatingMedia then
            HealBot_setOptions_Timer(150)
        end
        updatingMedia=false;
        HealBot_setOptions_Timer(160)
    end
end

function HealBot_Options_SkinFrameAliasTextureS_OnValueChanged(self)
    local g=nil
    local val=floor(self:GetValue()+0.5)
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        if val > 0 and hb_textures then
            Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"] = hb_textures[val];
            g=_G[self:GetName().."Text"]
            g:SetText(self.text .. " " .. val..": " .. hb_textures[val]);
        else
            g=_G[self:GetName().."Text"]
            g:SetText(self.text);
        end  
        if not updatingMedia then
            HealBot_setOptions_Timer(150)
        end
        updatingMedia=false;
        HealBot_setOptions_Timer(160)
        HealBot_setOptions_Timer(415)
    end
end

function HealBot_Options_HeadFontNameS_OnValueChanged(self)
    local g=nil
    local val=floor(self:GetValue()+0.5)
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        if val > 0 and fonts then
            Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["FONT"] = fonts[val];
            g=_G[self:GetName().."Text"]
            g:SetText(self.text .. " ".. val..": " ..fonts[val]);
        else
            g=_G[self:GetName().."Text"]
            g:SetText(self.text);
        end   
        if not updatingMedia and  val > 0 then
            HealBot_setOptions_Timer(150)
        end
        updatingMedia=false;
        HealBot_setOptions_Timer(160)
    end
end

function HealBot_BarButtonIconFont_OnValueChanged(self)
    local g=nil
    local val=floor(self:GetValue()+0.5)
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        if val > 0 and fonts then
            Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["FONT"] = fonts[val];
            g=_G[self:GetName().."Text"]
            g:SetText(self.text .. " ".. val..": " ..fonts[val]);
        else
            g=_G[self:GetName().."Text"]
            g:SetText(self.text);
        end   
        if not updatingMedia and  val > 0 then
            HealBot_setOptions_Timer(150)
        end
        updatingMedia=false;
        HealBot_setOptions_Timer(160)
    end
end

function HealBot_Options_AliasFontName_OnValueChanged(self)
    local g=nil
    local val=floor(self:GetValue()+0.5)
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        if val > 0 and fonts then
            Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["FONT"] = fonts[val];
            g=_G[self:GetName().."Text"]
            g:SetText(self.text .. " ".. val..": " ..fonts[val]);
        else
            g=_G[self:GetName().."Text"]
            g:SetText(self.text);
        end   
        HealBot_setOptions_Timer(415)
        HealBot_setOptions_Timer(160)
    end
end

function HealBot_Options_HeadFontHeightS_OnValueChanged(self)
    local val=floor(self:GetValue()+0.5)
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HEIGHT"] = val;
        local g=_G[self:GetName().."Text"]
        g:SetText(self.text .. ": " .. val);
        HealBot_setOptions_Timer(150)
        HealBot_setOptions_Timer(160)
    end
end

function HealBot_Options_HeadFontOffset_OnValueChanged(self)
    local val=floor(self:GetValue()+0.5)
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["OFFSET"] = val;
        local g=_G[self:GetName().."Text"]
        g:SetText(self.text .. ": " .. val);
        HealBot_setOptions_Timer(150)
        HealBot_setOptions_Timer(160)
    end
end

function HealBot_Options_SkinFrameAliasHeightS_OnValueChanged(self)
    local val=floor(self:GetValue()+0.5)
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HEIGHT"] = val
        local g=_G[self:GetName().."Text"]
        g:SetText(self.text .. ": " .. val);
        HealBot_setOptions_Timer(415)
    end
end

function HealBot_Options_SkinFrameAliasWidthS_OnValueChanged(self)
    Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["WIDTH"] = HealBot_Comm_round(HealBot_Options_Pct_OnValueChanged(self),2);
    HealBot_setOptions_Timer(415)
end

function HealBot_Options_AliasFontHeight_OnValueChanged(self)
    local val=floor(self:GetValue()+0.5)
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SIZE"] = val;
        local g=_G[self:GetName().."Text"]
        g:SetText(self.text .. ": " .. val);
        HealBot_setOptions_Timer(415)
        HealBot_setOptions_Timer(160)
    end
end

function HealBot_Options_AliasFontOffset_OnValueChanged(self)
    local val=floor(self:GetValue()+0.5)
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["OFFSET"] = val;
        local g=_G[self:GetName().."Text"]
        g:SetText(self.text .. ": " .. val);
        HealBot_setOptions_Timer(415)
    end
end

function HealBot_Options_BarHeightS_OnValueChanged(self)
    local val=floor(self:GetValue()+0.5)
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HEIGHT"] = val;
        local g=_G[self:GetName().."Text"]
        g:SetText(self.text .. ": " .. val);
        HealBot_setOptions_Timer(150)
    end
end

function HealBot_Options_BarWidthS_OnValueChanged(self)
    local val=floor(self:GetValue()+0.5)
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["WIDTH"] = val;
        local g=_G[self:GetName().."Text"]
        g:SetText(self.text .. ": " .. val);
        HealBot_setOptions_Timer(150)
    end
end

function HealBot_Options_BarNumColsS_OnValueChanged(self)
    local val=floor(self:GetValue()+0.5)
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["NUMCOLS"] = val;
        local g=_G[self:GetName().."Text"]
        g:SetText(HealBot_Options_SetNoColsText() .. ": " .. val);
        HealBot_Options_framesChanged(HealBot_Options_StorePrev["FramesSelFrame"])
    end
end

function HealBot_Options_BarBRSpaceS_OnValueChanged(self)
    local val=floor(self:GetValue()+0.5)
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["RMARGIN"] = val;
        local g=_G[self:GetName().."Text"]
        g:SetText(self.text .. ": " .. val);
        HealBot_setOptions_Timer(150)
    end
end

function HealBot_Options_BarBCSpaceS_OnValueChanged(self)
    local val=floor(self:GetValue()+0.5)
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CMARGIN"] = val;
        local g=_G[self:GetName().."Text"]
        g:SetText(self.text .. ": " .. val);
        HealBot_setOptions_Timer(150)
    end
end

function HealBot_Options_FontName_OnValueChanged(self)
    local g=nil
    local val=floor(self:GetValue()+0.5)
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        if val > 0 and fonts then
            Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["FONT"] = fonts[val];
            g=_G[self:GetName().."Text"]
            g:SetText(self.text .. " ".. val..": " ..fonts[val]);
        else
            g=_G[self:GetName().."Text"]
            g:SetText(self.text);
        end       
        if not updatingMedia and  val > 0 then
            HealBot_setOptions_Timer(150)
        end
        updatingMedia=false;
        HealBot_setOptions_Timer(160)
    end
end

function HealBot_Options_FontOffset_OnValueChanged(self)
    local val=floor(self:GetValue()+0.5)
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["OFFSET"] = val;
        local g=_G[self:GetName().."Text"]
        g:SetText(self.text .. ": " .. val);
        HealBot_setOptions_Timer(150)
        HealBot_setOptions_Timer(160)
    end
end

function HealBot_Options_FontHeight_OnValueChanged(self)
    local val=floor(self:GetValue()+0.5)
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HEIGHT"] = val;
        local g=_G[self:GetName().."Text"]
        g:SetText(self.text .. ": " .. val);
        HealBot_setOptions_Timer(150)
        HealBot_setOptions_Timer(160)
    end
end

function HealBot_Options_AggroBarSize_OnValueChanged(self)
    local val=floor(self:GetValue()+0.5)
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["AGGROSIZE"] = val;
        local g=_G[self:GetName().."Text"]
        g:SetText(self.text .. ": " .. val);
        HealBot_setOptions_Timer(150)
    end
end

function HealBot_Options_Bar2Size_OnValueChanged(self)
    local val=floor(self:GetValue()+0.5)
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["POWERSIZE"] = val;
        local g=_G[self:GetName().."Text"]
        g:SetText(self.text .. ": " .. val);
        HealBot_setOptions_Timer(150)
        HealBot_Options_Energy()
    end
end

local HealBot_Alignment = { [1]=HEALBOT_OPTIONS_BUTTONLEFT, [2]=HEALBOT_OPTIONS_BUTTONMIDDLE, [3]=HEALBOT_OPTIONS_BUTTONRIGHT }
function HealBot_Options_TextAlign_OnValueChanged(self)
    local val=floor(self:GetValue()+0.5)
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        local g=_G[self:GetName().."Text"]
        g:SetText(self.text .. " ".. val..": " ..HealBot_Alignment[val]);
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["ALIGN"] ~= val then
            Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["ALIGN"] = val;
            HealBot_setOptions_Timer(150)
        end
    end
end

function HealBot_Options_MaxChars_OnValueChanged(self)
    local val=floor(self:GetValue()+0.5)
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        local g=_G[self:GetName().."Text"]
        if val==0 then
            g:SetText(self.text .. ": "..HEALBOT_WORD_AUTO)
        else
            g:SetText(self.text .. ": ".. val)
        end
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["MAXCHARS"] ~= val then
            Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["MAXCHARS"] = val
            HealBot_Action_setTextLen(HealBot_Options_StorePrev["FramesSelFrame"])
            HealBot_setOptions_Timer(80)
        end
    end
end

function HealBot_Options_ActionAlpha_OnValueChanged(self)
    Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BACKA"] = HealBot_Comm_round(HealBot_Options_Pct_OnValueChanged(self),2);
end

function HealBot_Options_BarAlpha_OnValueChanged(self)
    Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HA"] = HealBot_Comm_round(HealBot_Options_Pct_OnValueChanged(self),2);
    HealBot_setOptions_Timer(80)
end

function HealBot_Options_HeadWidthS_OnValueChanged(self)
    Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["WIDTH"] = HealBot_Comm_round(HealBot_Options_Pct_OnValueChanged(self),2);
    HealBot_setOptions_Timer(150)
end

function HealBot_Options_HeadHightS_OnValueChanged(self)
    local val=floor(self:GetValue()+0.5)
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HEIGHT"] = val
        local g=_G[self:GetName().."Text"]
        g:SetText(self.text .. ": " .. val);
        HealBot_setOptions_Timer(150)
    end
end

function HealBot_Options_BarAlphaInHeal_OnValueChanged(self)
    Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["IA"] = HealBot_Comm_round(HealBot_Options_Pct_OnValueChanged(self),2);
    HealBot_setOptions_Timer(80)
end

function HealBot_Options_BarAlphaAbsorb_OnValueChanged(self)
    Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["AA"] = HealBot_Comm_round(HealBot_Options_Pct_OnValueChanged(self),2);
    HealBot_setOptions_Timer(80)
end

function HealBot_Options_BarAlphaBackGround_OnValueChanged(self)
    Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BA"] = HealBot_Comm_round(HealBot_Options_Pct_OnValueChanged(self),2);
    HealBot_setOptions_Timer(80)
end

function HealBot_Options_BarOutlineBackGround_OnValueChanged(self)
    local val=floor(self:GetValue()+0.5)
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BOUT"] = val;
        local g=_G[self:GetName().."Text"]
        g:SetText(self.text .. ": " .. val);
        HealBot_setOptions_Timer(150)
    end
end

function HealBot_Options_BarAlphaDis_OnValueChanged(self)
    Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["DISA"] = HealBot_Comm_round(HealBot_Options_Pct_OnValueChanged(self),2);
    HealBot_setOptions_Timer(80)
end

function HealBot_Options_BarAlphaEor_OnValueChanged(self)
    Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["ORA"] = HealBot_Comm_round(HealBot_Options_Pct_OnValueChanged(self),2);
    HealBot_setOptions_Timer(80)
end

function HealBot_Options_TTAlpha_OnValueChanged(self)
    HealBot_Globals.ttalpha = HealBot_Options_Pct_OnValueChanged(self);
    HealBot_Tooltip:SetBackdropColor(0,0,0,HealBot_Globals.ttalpha)
    local x=HealBot_Globals.ttalpha+0.12
    if x>1 then x=1 end
    HealBot_Tooltip:SetBackdropBorderColor(0.32,0.32,0.4, x)
end

function HealBot_Options_ClassColours()
    StaticPopupDialogs["HEALBOT_OPTIONS_CLASSCOL"] = {
        text = HEALBOT_OPTIONS_WARN_CLASSCOL,
        button1 = CLOSE,
        timeout = 0,
        whileDead = 1,
        hideOnEscape = 1
    };
    StaticPopup_Show("HEALBOT_OPTIONS_CLASSCOL");
end

local HealBot_ColourObjWaiting=nil
function HealBot_SkinColorpick_OnClick(SkinType)
    HealBot_ColourObjWaiting=SkinType;

    if SkinType=="En" then
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CLASSCOL"]==false then
            HealBot_UseColourPick(Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["ER"],
                                  Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["EG"],
                                  Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["EB"],
                                  Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["EA"] or 1);
        else
            HealBot_Options_ClassColours()
        end
    elseif SkinType=="Dis" then
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CLASSCOL"]==false then
            HealBot_UseColourPick(Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["DR"],
                                  Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["DG"],
                                  Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["DB"],
                                  Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["DA"] or 1)
        else
            HealBot_Options_ClassColours()
        end
    elseif SkinType=="Debuff" then
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CLASSCOL"]==false then
            HealBot_UseColourPick(Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CR"],
                                  Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CG"],
                                  Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CB"],
                                  Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CA"] or 1)
        else
            HealBot_Options_ClassColours()
        end
    elseif SkinType=="Back" then
        HealBot_UseColourPick(Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BACKR"],
                              Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BACKG"],
                              Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BACKB"],
                              Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BACKA"] or 1)
    elseif SkinType=="Bor" then
        HealBot_UseColourPick(Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BORDERR"],
                              Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BORDERG"],
                              Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BORDERB"],
                              Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BORDERA"] or 1)
    elseif SkinType=="AliasT" then
        HealBot_UseColourPick(Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["R"],
                              Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["G"],
                              Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["B"],
                              Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["A"] or 1)
    elseif SkinType=="Alias" then
        HealBot_UseColourPick(Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["R"],
                              Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["G"],
                              Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["B"],
                              Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["A"] or 1)
    elseif SkinType=="HeadB" then
        HealBot_UseColourPick(Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["R"],
                              Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["G"],
                              Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["B"],
                              Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["A"] or 1)
    elseif SkinType=="HeadT" then
        HealBot_UseColourPick(Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["R"],
                              Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["G"],
                              Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["B"],
                              Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["A"] or 1)
    elseif SkinType=="CustomBar" then
        HealBot_UseColourPick(Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HR"],
                              Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HG"],
                              Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HB"])
    elseif SkinType=="CustomBackBar" then
        HealBot_UseColourPick(Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BR"],
                              Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BG"],
                              Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BB"])
    elseif SkinType=="CustomIHBar" then
        HealBot_UseColourPick(Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["IR"],
                              Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["IG"],
                              Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["IB"])
    elseif SkinType=="CustomAbsorbBar" then
        HealBot_UseColourPick(Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["AR"],
                              Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["AG"],
                              Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["AB"])
    elseif SkinType=="HighlightBar" then
        HealBot_UseColourPick(Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CR"],
                              Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CG"],
                              Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CB"])
    elseif SkinType=="HighlightTargetBar" then
        HealBot_UseColourPick(Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TR"],
                              Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TG"],
                              Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TB"])
    elseif SkinType=="Aggro" then
        HealBot_UseColourPick(Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["R"],
                              Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["G"],
                              Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["B"])
    end
end

function HealBot_BuffColorpick_OnClick(BuffID,id)
    HealBot_ColourObjWaiting=BuffID;
    local buffbarcolrClass = HealBot_Config_Buffs.HealBotBuffColR
    local buffbarcolgClass = HealBot_Config_Buffs.HealBotBuffColG
    local buffbarcolbClass = HealBot_Config_Buffs.HealBotBuffColB
    HealBot_UseColourPick(buffbarcolrClass[id],
                          buffbarcolgClass[id],
                          buffbarcolbClass[id]);
end

function HealBot_SetSkinColours()
    HealBot_EnTextColorpick:SetStatusBarColor(0,1,0,Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HA"]);
    HealBot_EnTextColorpickin:SetStatusBarColor(0,1,0,Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["IA"]);
    HealBot_DisTextColorpick:SetStatusBarColor(0,1,0,Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["DISA"]); 
    HealBot_Options_SetBarsTextColour()
    HealBot_HeadTextColorpickt:SetTextColor(
        Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["R"],
        Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["G"],
        Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["B"],
        Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["A"]);
    HealBot_HeadBarColorpick:SetStatusBarColor(
        Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["R"],
        Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["G"],
        Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["B"],
        Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["A"])
    HealBot_HeadTextColorpick:SetStatusBarColor(
        Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["R"],
        Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["G"],
        Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["B"],
        Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["A"])
    HealBot_FrameAliasColorpick:SetStatusBarColor(
        Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["R"],
        Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["G"],
        Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["B"],
        Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["A"])
    HealBot_FrameAliasTextColorpick:SetStatusBarColor(
        Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["R"],
        Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["G"],
        Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["B"],
        Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["A"])
    HealBot_BarCustomColour:SetStatusBarColor(
        Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HR"],
        Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HG"],
        Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HB"]);
    HealBot_Options_BarHealthBackColourS:SetStatusBarColor(
        Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BR"],
        Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BG"],
        Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BB"]);
    HealBot_BarIHCustomColour:SetStatusBarColor(
        Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["IR"],
        Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["IG"],
        Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["IB"]);
    HealBot_BarAbsorbCustomColour:SetStatusBarColor(
        Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["AR"],
        Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["AG"],
        Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["AB"]);
    HealBot_HighlightActiveBarColour:SetStatusBarColor(
        Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CR"],
        Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CG"],
        Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CB"]);
    HealBot_HighlightTargetBarColour:SetStatusBarColor(
        Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TR"],
        Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TG"],
        Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TB"]);
    for j=1,10 do
        local g=_G["f"..j.."_HealBot_Action"]
        g:SetBackdropColor(
            Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][j]["BACKR"],
            Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][j]["BACKG"],
            Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][j]["BACKB"], 
            Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][j]["BACKA"]);
        g:SetBackdropBorderColor(
            Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][j]["BORDERR"],
            Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][j]["BORDERG"],
            Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][j]["BORDERB"],
            Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][j]["BORDERA"]);
        if Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][j] then
            HealBot_Action_SetAlias(j)
            HealBot_Action_SetAliasFontSize(j)
        end
    end
    HealBot_Aggro3Colorpick:SetStatusBarColor(
        Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["R"],
        Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["G"],
        Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["B"]);
    HealBot_Options_SetFrameCols()
end

function HealBot_Options_SetFrameCols()
    HealBot_BackgroundColorpick:SetStatusBarColor(
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BACKR"],
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BACKG"],
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BACKB"],
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BACKA"]);
    HealBot_BorderColorpick:SetStatusBarColor(
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BORDERR"],
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BORDERG"],
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BORDERB"],
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BORDERA"]);
    HealBot_FrameAliasTextColorpickt:SetTextColor(
        Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["R"],
        Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["G"],
        Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["B"],
        Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["A"]);
    HealBot_Options_framesChanged(HealBot_Options_StorePrev["FramesSelFrame"])
end

function HealBot_Options_SetBarsTextColour()
    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CLASSCOL"]==false then
        HealBot_EnTextColorpickt:SetTextColor(
            Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["ER"],
            Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["EG"],
            Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["EB"],
            Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["EA"]);
        HealBot_DisTextColorpickt:SetTextColor(
            Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["DR"],
            Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["DG"],
            Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["DB"],
            Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["DA"]);
        HealBot_DebTextColorpickt:SetTextColor(
            Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CR"],
            Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CG"],
            Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CB"],
            Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CA"]);
    else
        local sbR, sbG, sbB = HealBot_Action_ClassColour("player")
        HealBot_EnTextColorpickt:SetTextColor(
            sbR,
            sbG,
            sbB,
            Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["EA"]);
        HealBot_DisTextColorpickt:SetTextColor(
            sbR,
            sbG,
            sbB,
            Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["DA"]);
        HealBot_DebTextColorpickt:SetTextColor(
            sbR,
            sbG,
            sbB,
            Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CA"]);
    end
end

function HealBot_Options_AlertLevelIC_OnValueChanged(self)
    Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["ALERTIC"] = HealBot_Comm_round(HealBot_Options_Pct_OnValueChanged(self),2);
    HealBot_setOptions_Timer(80)
end

function HealBot_Options_AlertLevelOC_OnValueChanged(self)
    Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["ALERTOC"] = HealBot_Comm_round(HealBot_Options_Pct_OnValueChanged(self),2);
    HealBot_setOptions_Timer(80)
end

function HealBot_Options_AggroFlashFreq_OnValueChanged(self)
    local val=HealBot_Comm_round(self:GetValue(),1)
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        val=val/100;
        Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["FREQ"] = val;
    end
end

function HealBot_Options_AggroFlashAlphaMin_OnValueChanged(self)
    Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["MINA"] = HealBot_Comm_round(HealBot_Options_Pct_OnValueChanged(self),2);
    if Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["MINA"]>=Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["MAXA"] then
        Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["MAXA"]=Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["MINA"]+0.05
        HealBot_Options_AggroFlashAlphaMax:SetValue(Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["MAXA"])
    end
end

function HealBot_Options_AggroFlashAlphaMax_OnValueChanged(self)
    Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["MAXA"] = HealBot_Comm_round(HealBot_Options_Pct_OnValueChanged(self),2);
    if Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["MAXA"]<=Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["MINA"] then
        Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["MINA"]=Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["MAXA"]-0.05
        HealBot_Options_AggroFlashAlphaMin:SetValue(Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["MINA"])
    end
end

function HealBot_Options_MaxBarCache_OnValueChanged(self)
    local val=HealBot_Comm_round(self:GetValue())
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        HealBot_Globals.MaxBarsCache = val
        local g=_G[self:GetName().."Text"]
        g:SetText(self.text .. ": " .. val)
    end
end

function HealBot_Options_RangeCheckFreq_OnValueChanged(self)
    local val=HealBot_Comm_round(self:GetValue())
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        val=val/10;
        HealBot_Globals.RangeCheckFreq = val;
        --local g=_G[self:GetName().."Text"]
        --g:SetText(self.text .. ": " .. val);
        HealBot_setOptions_Timer(9999)
    end
end

function HealBot_Options_BuffTimer_OnValueChanged(self,bufftype)
    --local val=HealBot_Comm_round(self:GetValue(), -1)
    local val=floor(self:GetValue()+0.5)
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        if bufftype=="SHORT" then
            HealBot_Config_Buffs.ShortBuffTimer = val;
        else
            HealBot_Config_Buffs.LongBuffTimer = val;
        end
        local mins,secs=HealBot_ReturnMinsSecs(val)
        local g=nil
        if mins<1 then
            g=_G[self:GetName().."Text"]
            g:SetText(self.text .. ": " .. secs .." secs");
        else
            val=val/60;
            g=_G[self:GetName().."Text"]
            g:SetText(self.text .. ": " .. mins ..":".. secs .." mins");
        end
        HealBot_setOptions_Timer(10)
    end
end

function HealBot_ReturnMinsSecs(s)
    local mins=floor(s/60)
    local secs=floor(s-(mins*60))
  --  mins=mins+1
    if secs<10 then secs="0"..secs end
    return mins,secs
end

function HealBot_Options_StickyFramesSensitivity_OnValueChanged(self)
    local val=floor(self:GetValue()+0.5)
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["STICKYSENSITIVITY"] = val;
    end
end

function HealBot_Options_BarFreq_OnValueChanged(self)
    local val=floor(self:GetValue()+0.5)
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        val=val/10;
        Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["FLUIDFREQ"] = val;
    end
end

function HealBot_Options_NumTestBars_OnValueChanged(self)
    local v=floor(self:GetValue()+0.5)
    if v~=self:GetValue() then
        self:SetValue(v) 
    else
        HealBot_Globals.TestBars["BARS"] = v;
        local g=_G[self:GetName().."Text"]
        g:SetText(self.text .. ": " .. v);
        HealBot_Panel_SetNumBars(HealBot_Globals.TestBars["BARS"])
        HealBot_nextRecalcParty(6)
    end
end

function HealBot_Options_NumTestTanks_OnValueChanged(self)
    local v=floor(self:GetValue()+0.5)
    if v~=self:GetValue() then
        self:SetValue(v) 
    else
        HealBot_Globals.TestBars["TANKS"] = v;
        local g=_G[self:GetName().."Text"]
        g:SetText(self.text .. ": " .. v);
        HealBot_nextRecalcParty(6)
    end
end

function HealBot_Options_NumberTestHealers_OnValueChanged(self)
    local v=floor(self:GetValue()+0.5)
    if v~=self:GetValue() then
        self:SetValue(v) 
    else
        HealBot_Globals.TestBars["HEALERS"] = v;
        local g=_G[self:GetName().."Text"]
        g:SetText(self.text .. ": " .. v);
        HealBot_nextRecalcParty(6)
    end
end

function HealBot_Options_NumTestMyTargets_OnValueChanged(self)
    local v=floor(self:GetValue()+0.5)
    if v~=self:GetValue() then
        self:SetValue(v) 
    else
        HealBot_Globals.TestBars["TARGETS"] = v;
        local g=_G[self:GetName().."Text"]
        g:SetText(self.text .. ": " .. v);
        HealBot_nextRecalcParty(6)
    end
end

function HealBot_Options_NumTestPets_OnValueChanged(self)
    local v=floor(self:GetValue()+0.5)
    if v~=self:GetValue() then
        self:SetValue(v) 
    else
        HealBot_Globals.TestBars["PETS"] = v;
        local g=_G[self:GetName().."Text"]
        g:SetText(self.text .. ": " .. v);
        HealBot_nextRecalcParty(6)
    end
end


function HealBot_Options_NumberTestEnemy_OnValueChanged(self)
    local v=floor(self:GetValue()+0.5)
    if v~=self:GetValue() then
        self:SetValue(v) 
    else
        HealBot_Globals.TestBars["ENEMY"] = v;
        local g=_G[self:GetName().."Text"]
        g:SetText(self.text .. ": " .. v);
        HealBot_nextRecalcParty(6)
    end
end

function HealBot_Options_AutoShow_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["AUTOCLOSE"] = true
    else
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["AUTOCLOSE"] = false
    end
    HealBot_setOptions_Timer(80)
    HealBot_Options_framesChanged(HealBot_Options_StorePrev["FramesSelFrame"])
end

function HealBot_Options_IgnoreDebuffsClass_OnClick(self)
    if self:GetChecked() then
        HealBot_Config_Cures.IgnoreClassDebuffs = true
    else
        HealBot_Config_Cures.IgnoreClassDebuffs = false
    end
end

function HealBot_Options_IgnoreDebuffsNoHarm_OnClick(self)
    if self:GetChecked() then
        HealBot_Config_Cures.IgnoreNonHarmfulDebuffs = true
    else
        HealBot_Config_Cures.IgnoreNonHarmfulDebuffs = false
    end
end

function HealBot_Options_IgnoreDebuffsDuration_OnClick(self)
    if self:GetChecked() then
        HealBot_Config_Cures.IgnoreFastDurDebuffs = true
    else
        HealBot_Config_Cures.IgnoreFastDurDebuffs = false
    end
end

function HealBot_Options_IgnoreDebuffsCoolDown_OnClick(self)
    if self:GetChecked() then
        HealBot_Config_Cures.IgnoreOnCooldownDebuffs = true
    else
        HealBot_Config_Cures.IgnoreOnCooldownDebuffs = false
    end
end

function HealBot_Options_IgnoreDebuffsFriend_OnClick(self)
    if self:GetChecked() then
        HealBot_Config_Cures.IgnoreFriendDebuffs = true
    else
        HealBot_Config_Cures.IgnoreFriendDebuffs = false
    end
end

function HealBot_Options_IgnoreDebuffsDurationSecs_OnValueChanged(self)
    local v=floor(self:GetValue()+0.5)
    if v~=self:GetValue() then
        self:SetValue(v) 
    else
        HealBot_Config_Cures.IgnoreFastDurDebuffsSecs = v;
        local g=_G[self:GetName().."Text"]
        g:SetText(self.text .. ": " .. v.." secs");
    end
end

function HealBot_Options_IgnoreDebuffsMovement_OnClick(self)
    if self:GetChecked() then
        HealBot_Config_Cures.IgnoreMovementDebuffs = true
    else
        HealBot_Config_Cures.IgnoreMovementDebuffs = false
    end
end

function HealBot_Options_CastNotifyResOnly_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Chat[Healbot_Config_Skins.Current_Skin]["RESONLY"] = true
    else
        Healbot_Config_Skins.Chat[Healbot_Config_Skins.Current_Skin]["RESONLY"] = false
    end
end

function HealBot_Options_BarNumGroupPerCol_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["GRPCOLS"] = true
    else
        Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["GRPCOLS"] = false
    end
    HealBot_Options_BarNumColsSText:SetText(HealBot_Options_SetNoColsText() .. ": " .. Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["NUMCOLS"]);
    HealBot_Panel_ClearBarArrays()
    HealBot_setOptions_Timer(150)
    HealBot_Options_framesChanged(HealBot_Options_StorePrev["FramesSelFrame"])
end

function HealBot_Options_ShowPowerCounter_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["POWERCNT"] = true
    else
        Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["POWERCNT"] = false
    end
    HealBot_Action_setpcClass()
    HealBot_Options_Energy()
end

function HealBot_Options_Energy()
    local regPower=false
    for j=1,10 do
        if Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j]["POWERSIZE"]>0 then 
            regPower=true
        elseif Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][j]["POWERCNT"] and 
           (HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_PALADIN] or HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_MONK]) then
            regPower=true
        end
    end
    if regPower then
        HealBot_Register_Mana() 
    else
        HealBot_UnRegister_Mana()
    end
    HealBot_setEnemyBars()
end

function HealBot_Options_ShowTooltipMyBuffs_OnClick(self)
    if self:GetChecked() then
        HealBot_Globals.Tooltip_ShowMyBuffs = true
    else
        HealBot_Globals.Tooltip_ShowMyBuffs = false
    end
end

function HealBot_Options_ShowClassOnBar_OnClick(self)
    HealBot_RaidTargetToggle(nil)
    if self:GetChecked() then
        Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CLASSONBAR"] = true
    else
        Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CLASSONBAR"] = false
    end
    HealBot_ResetClassIconTexture()
    HealBot_Options_framesChanged(HealBot_Options_StorePrev["FramesSelFrame"])
end

function HealBot_Options_ShowNameOnBar_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["NAMEONBAR"] = true
    else
        Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["NAMEONBAR"] = false
    end
    HealBot_setOptions_Timer(80)
end

function HealBot_Options_libUTF8_OnClick(self)
    if self:GetChecked() then
        HealBot_Globals.useUTF8 = true
    else
        HealBot_Globals.useUTF8 = false
    end
end

function HealBot_Options_UseStickyFrames_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["STICKYFRAME"] = true
    else
        Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["STICKYFRAME"] = false
        HealBot_Action_StickyFrameClearStuck()
        HealBot_Options_ActionAnchor_SetAlpha(HealBot_Options_StorePrev["FramesSelFrame"])
    end
    HealBot_setOptions_Timer(7000)
end


function HealBot_Options_PartyFrames_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["HIDEPARTYF"] = true
    else
        Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["HIDEPARTYF"] = false
    end
    HealBot_MessageReloadUI(15)
    HealBot_setOptions_Timer(180)
end

function HealBot_Options_MiniBossFrames_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["HIDEBOSSF"] = true
    else
        Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["HIDEBOSSF"] = false
    end
    HealBot_MessageReloadUI(15)
    HealBot_setOptions_Timer(185)
end

function HealBot_Options_RaidFrames_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["HIDERAIDF"] = true
    else
        Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["HIDERAIDF"] = false
    end
    HealBot_MessageReloadUI(15)
    HealBot_setOptions_Timer(188)
end

function HealBot_Options_AggroTrack_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOW"] = true
        HealBot_Register_Aggro()
    else
        Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOW"] = false
        HealBot_UnRegister_Aggro()
    end
    HealBot_setOptions_Timer(150)
    HealBot_setOptions_Timer(80)
end

function HealBot_Options_HighlightActiveBar_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CBAR"] = true
    else
        Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CBAR"] = false
    end
    HealBot_setOptions_Timer(150)
end

function HealBot_Options_HighlightTargetBar_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TBAR"] = true
    else
        Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TBAR"] = false
    end
    HealBot_setOptions_Timer(150)
end

function HealBot_Options_HighlightActiveBarInCombat_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CBARCOMBAT"] = true
    else
        Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CBARCOMBAT"] = false
    end
end

function HealBot_Options_HighlightTargetBarInCombat_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TBARCOMBAT"] = true
    else
        Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TBARCOMBAT"] = false
    end
end

function HealBot_Options_UseFluidBars_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["FLUIDBARS"] = true
    else
        Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["FLUIDBARS"] = false
    end
    HealBot_setOptions_Timer(80)
end

function HealBot_Options_EnableLibQuickHealth_OnClick(self)
    local reason=HEALBOT_OPTIONS_ENABLELIBQH
    if self:GetChecked() then
        HealBot_Globals.EnLibQuickHealth=true
        reason=reason.." - "..HEALBOT_WORD_ON
    else
        HealBot_Globals.EnLibQuickHealth=false
        reason=reason.." - "..HEALBOT_WORD_OFF
    end
    HealBot_Options_ReloadUI(reason)
end

function HealBot_Options_EnableAutoCombat_OnClick(self)
    if self:GetChecked() then
        HealBot_Globals.EnAutoCombat=true
    else
        HealBot_Globals.EnAutoCombat=false
    end
end


function HealBot_Options_AggroBar_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOWBARS"] = true
    else
        Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOWBARS"] = false
    end
    HealBot_setOptions_Timer(150)
    HealBot_setOptions_Timer(80)
end

function HealBot_Options_AggroTxt_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOWTEXT"] = true
    else
        Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOWTEXT"] = false
    end
    HealBot_setOptions_Timer(80)
end

function HealBot_Options_AggroInd_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOWIND"] = true
    else
        Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOWIND"] = false
    end
    HealBot_setOptions_Timer(80)
end

function HealBot_Options_AggroBarPct_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOWBARSPCT"] = true
    else
        Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOWBARSPCT"] = false
    end
end

function HealBot_Options_AggroTxtPct_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOWTEXTPCT"] = true
    else
        Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOWTEXTPCT"] = false
    end
    HealBot_setOptions_Timer(80)
end

function HealBot_Options_PlayerTargetFrames_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["HIDEPTF"] = true
    else
        Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["HIDEPTF"] = false
    end
    HealBot_MessageReloadUI(15)
    HealBot_setOptions_Timer(180)
end

function HealBot_Options_MonitorBuffs_OnClick(self)
    if self:GetChecked() then
        HealBot_Config_Buffs.BuffWatch = true
    else
        HealBot_Config_Buffs.BuffWatch = false
    end
    HealBot_Options_MonitorBuffs_Toggle()
end

function HealBot_Options_MonitorBuffs_Toggle()
    HealBot_setOptions_Timer(40)
end

function HealBot_Options_MonitorDebuffs_OnClick(self)
    if self:GetChecked() then
        HealBot_Config_Cures.DebuffWatch = true
    else
        HealBot_Config_Cures.DebuffWatch = false
    end
    HealBot_Options_MonitorDebuffs_Toggle()
end

function HealBot_Options_MonitorDebuffs_Toggle()
    HealBot_setOptions_Timer(20)
end

function HealBot_Options_MonitorBuffsInCombat_OnClick(self)
    if self:GetChecked() then
        HealBot_Config_Buffs.BuffWatchInCombat = true
    else
        HealBot_Config_Buffs.BuffWatchInCombat = false
    end
    HealBot_setOptions_Timer(40)
end

function HealBot_Options_MonitorBuffsWhenGrouped_OnClick(self)
    if self:GetChecked() then
        HealBot_Config_Buffs.BuffWatchWhenGrouped = true
    else
        HealBot_Config_Buffs.BuffWatchWhenGrouped = false
    end
    HealBot_setOptions_Timer(40)
end

function HealBot_Options_MonitorBuffsPalaBlessing_OnClick(self)
    if self:GetChecked() then
        HealBot_Config_Buffs.PalaBlessingsAsOne = true
    else
        HealBot_Config_Buffs.PalaBlessingsAsOne = false
    end
    HealBot_setOptions_Timer(40)
end

function HealBot_Options_SkinDefault_OnClick(self, gType)
    if self:GetChecked() then
        HealBot_Config.SkinDefault[Healbot_Config_Skins.Current_Skin][gType] = true
        for x in pairs (Healbot_Config_Skins.Skins) do
            if Healbot_Config_Skins.Skins[x]~=Healbot_Config_Skins.Current_Skin and HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]][gType] then
                HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]][gType]=false
            end
        end
    else
        HealBot_Config.SkinDefault[Healbot_Config_Skins.Current_Skin][gType] = false
    end
end

function HealBot_Options_ManaIndicatorInCombat_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["LOWMANACOMBAT"] = true
    else
        Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["LOWMANACOMBAT"] = false
    end
end

function HealBot_Options_MonitorDebuffsInCombat_OnClick(self)
    if self:GetChecked() then
        HealBot_Config_Cures.DebuffWatchInCombat = true
    else
        HealBot_Config_Cures.DebuffWatchInCombat = false
    end
    HealBot_setOptions_Timer(50)
end

function HealBot_Options_MonitorDebuffsWhenGrouped_OnClick(self)
    if self:GetChecked() then
        HealBot_Config_Cures.DebuffWatchWhenGrouped = true
    else
        HealBot_Config_Cures.DebuffWatchWhenGrouped = false
    end
    HealBot_setOptions_Timer(50)
end

function HealBot_Options_CDCCol_ShowOnHealthBar_OnClick(self)
    if self:GetChecked() then
        HealBot_Config_Cures.CDCshownHB = true
    else
        HealBot_Config_Cures.CDCshownHB = false
    end
end

function HealBot_Options_BuffCol_ShowOnHealthBar_OnClick(self)
    if self:GetChecked() then
        HealBot_Config_Buffs.CBshownHB = true
    else
        HealBot_Config_Buffs.CBshownHB = false
    end
    HealBot_ClearAllBuffs()
    HealBot_setOptions_Timer(30)
end


function HealBot_Options_CDCCol_OnOff_OnClick(self)
    if HealBot_Options_StorePrev["CDebuffcustomName"] then
        if self:GetChecked() then
            HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[HealBot_Options_StorePrev["CDebuffcustomName"]] = true
        else
            HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[HealBot_Options_StorePrev["CDebuffcustomName"]] = false
        end
        for xUnit,xButton in pairs(HealBot_Unit_Button) do
            if xButton.aura.debuff and xButton.aura.debuff.name then
                xButton.aura.debuff.check=true
            end
        end
    end
end

function HealBot_Options_CustomBuffCol_OnOff_OnClick(self)
    local sId=HealBot_Options_CDebuffGetId(HealBot_Options_StorePrev["HoTname"])
    if sId then
        if self:GetChecked() then
            HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[sId] = true
        else
            HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[sId] = false
        end
        for xUnit,xButton in pairs(HealBot_Unit_Button) do
            if xButton.aura.buff and xButton.aura.buff.name then
                xButton.aura.buff.check=true
            end
        end
    end
end

function HealBot_Options_CDCCol_ShowOnAggroBar_OnClick(self)
    if self:GetChecked() then
        HealBot_Config_Cures.CDCshownAB = true
    else
        HealBot_Config_Cures.CDCshownAB = false
        HealBot_ClearAllDebuffs()
        HealBot_SetResetFlag("SOFT")
    end
end

function HealBot_Options_BuffCol_ShowOnAggroBar_OnClick(self)
    if self:GetChecked() then
        HealBot_Config_Buffs.CBshownAB = true
    else
        HealBot_Config_Buffs.CBshownAB = false
        HealBot_SetResetFlag("SOFT")
    end
    HealBot_ClearAllBuffs()
    HealBot_setOptions_Timer(30)
end

function HealBot_Options_PanelSounds_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["OPENSOUND"] = true
    else
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["OPENSOUND"] = false
    end
end

function HealBot_Options_ActionLocked_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["LOCKED"] = true
    else
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["LOCKED"] = false
    end
end

function HealBot_Options_DisableHealBot_OnClick(self)
    local checkval=0
    if self:GetChecked() then checkval=1 end
    HealBot_Options_DisableHealBot(checkval)
end

function HealBot_Options_NoAuraWhenRested_OnClick(self)
    if self:GetChecked() then
        HealBot_Config_Buffs.NoAuraWhenRested=true
    else
        HealBot_Config_Buffs.NoAuraWhenRested=false
    end
    HealBot_SetResetFlag("SOFT")
end

function HealBot_Options_AdjustMaxHealth_OnClick(self)
    if self:GetChecked() then
        HealBot_Config.AdjustMaxHealth=true
    else
        HealBot_Config.AdjustMaxHealth=false
    end
    HealBot_SetResetFlag("SOFT")
end

function HealBot_Options_DisableHealBot(checkval)
    if checkval==1 then
        HealBot_Config.DisableHealBot=true
    else
        HealBot_Config.DisableHealBot=false
    end
    HealBot_Options_DisableCheck()
end

function HealBot_Options_DisableHealBotSolo_OnClick(self)
    if self:GetChecked() then
        HealBot_Config.DisableSolo=true
    else
        HealBot_Config.DisableSolo=false
    end
    HealBot_Options_DisableCheck()
end

function HealBot_Options_DisableCheck()
    local z=0
    if not HealBot_Config.DisableHealBot then
        z=0
    elseif not HealBot_Config.DisableSolo then
        z=1
    elseif GetNumGroupMembers()==0 then
        z=1
    end
    if HealBot_Config.DisabledNow~=z then
        if z==0 then 
            HealBot_Config.DisabledNow=0
            HealBot_setOptions_Timer(9999)
            HealBot_setOptions_Timer(200)
        end
        HealBot_setOptions_Timer(500+z)
        if z==1 then 
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_DISABLED)
        else
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_ENABLED)
        end
    end
end

function HealBot_Options_HealGroups_OnClick(self, id)
    if self:GetChecked() then
        Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][id]["STATE"] = true
    else
        Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][id]["STATE"] = false
    end
    HealBot_Options_framesChanged(id)
end

function HealBot_Options_HealGroupUp_OnClick(self, id)
    if id>1 and id<7 then
        local hbId = id-1
        HealBot_Options_HealGroupSwap(Healbot_Config_Skins.Current_Skin, hbId, id)
    end
end

function HealBot_Options_HealGroupDown_OnClick(self, id)
    if id>0 and id<6 then
        local hbId = id+1
        HealBot_Options_HealGroupSwap(Healbot_Config_Skins.Current_Skin, hbId, id)
    end
end

function HealBot_Options_HealGroupSwap(skinName, hbId, id)
    local hgName=Healbot_Config_Skins.HealGroups[skinName][id]["NAME"]
    local hgState=Healbot_Config_Skins.HealGroups[skinName][id]["STATE"]
    local hgFrame=Healbot_Config_Skins.HealGroups[skinName][id]["FRAME"]
    Healbot_Config_Skins.HealGroups[skinName][id]["STATE"] = Healbot_Config_Skins.HealGroups[skinName][hbId]["STATE"]
    Healbot_Config_Skins.HealGroups[skinName][id]["NAME"]  = Healbot_Config_Skins.HealGroups[skinName][hbId]["NAME"]
    Healbot_Config_Skins.HealGroups[skinName][id]["FRAME"] = Healbot_Config_Skins.HealGroups[skinName][hbId]["FRAME"]
    Healbot_Config_Skins.HealGroups[skinName][hbId]["STATE"] = hgState
    Healbot_Config_Skins.HealGroups[skinName][hbId]["NAME"]  = hgName
    Healbot_Config_Skins.HealGroups[skinName][hbId]["FRAME"] = hgFrame
    DoneInitTab[310]=nil
    HealBot_Options_InitSub(310) 
    HealBot_Options_framesChanged(1)
end

function HealBot_Options_SortOutOfRangeLast_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["OORLAST"] = true
    else
        Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["OORLAST"] = false
    end
    HealBot_nextRecalcParty(6)
    HealBot_nextRecalcParty(2)
end

function HealBot_Options_HideBar_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HIDEOOR"] = true
    else
        Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HIDEOOR"] = false
    end
    HealBot_Options_framesChanged(1)
end

function HealBot_Options_HideIncFocus_OnClick(self)

end

function HealBot_Options_HideIncGroup_OnClick(self)

end

function HealBot_Options_HideIncTank_OnClick(self)

end

function HealBot_Options_HideIncMyTargets_OnClick(self)

end

function HealBot_Options_FocusOnlyFriend_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["FONLYFRIEND"] = true
    else
        Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["FONLYFRIEND"] = false
    end
    HealBot_Options_framesChanged(9)
end

function HealBot_Options_FocusExcludeRaid_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["FEXRAID"] = true
    else
        Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["FEXRAID"] = false
    end
    HealBot_Options_framesChanged(9)
end

function HealBot_Options_TargetOnlyFriend_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TONLYFRIEND"] = true
    else
        Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TONLYFRIEND"] = false
    end
    HealBot_Options_framesChanged(8)
end

function HealBot_Options_TargetExcludeRaid_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TEXRAID"] = true
    else
        Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TEXRAID"] = false
    end
    HealBot_Options_framesChanged(8)
end

function HealBot_Options_GroupPetsByFive_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["GROUPPETS"] = true
    else
        Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["GROUPPETS"] = false
    end
    HealBot_Options_framesChanged(7)
end

function HealBot_Options_SelfPet_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["SELFPET"] = true
    else
        Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["SELFPET"] = false
    end
    HealBot_Options_framesChanged(7)
end

function HealBot_Options_EFGroup_OnClick(self,id)
    if self:GetChecked() then
        Healbot_Config_Skins.IncludeGroup[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]][id] = true;
    else
        Healbot_Config_Skins.IncludeGroup[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]][id] = false;
    end
    HealBot_Options_framesChanged(1)
end

function HealBot_Options_EFClass_OnClick(self)
    if HealBot_Globals.EmergencyFClass==1 then
        if HealBot_Options_EFClassDruid:GetChecked() then
            HealBot_Globals.EmergIncMelee[HEALBOT_DRUID] = true
        else
            HealBot_Globals.EmergIncMelee[HEALBOT_DRUID] = false
        end
        if HealBot_Options_EFClassHunter:GetChecked() then
            HealBot_Globals.EmergIncMelee[HEALBOT_HUNTER] = true
        else
            HealBot_Globals.EmergIncMelee[HEALBOT_HUNTER] = false
        end
        if HealBot_Options_EFClassMage:GetChecked() then
            HealBot_Globals.EmergIncMelee[HEALBOT_MAGE] = true
        else
            HealBot_Globals.EmergIncMelee[HEALBOT_MAGE] = false
        end
        if HealBot_Options_EFClassPaladin:GetChecked() then
            HealBot_Globals.EmergIncMelee[HEALBOT_PALADIN] = true
        else
            HealBot_Globals.EmergIncMelee[HEALBOT_PALADIN] = false
        end
        if HealBot_Options_EFClassPriest:GetChecked() then
            HealBot_Globals.EmergIncMelee[HEALBOT_PRIEST] = true
        else
            HealBot_Globals.EmergIncMelee[HEALBOT_PRIEST] = false
        end
        if HealBot_Options_EFClassRogue:GetChecked() then
            HealBot_Globals.EmergIncMelee[HEALBOT_ROGUE] = true
        else
            HealBot_Globals.EmergIncMelee[HEALBOT_ROGUE] = false
        end
        if HealBot_Options_EFClassShaman:GetChecked() then
            HealBot_Globals.EmergIncMelee[HEALBOT_SHAMAN] = true
        else
            HealBot_Globals.EmergIncMelee[HEALBOT_SHAMAN] = false
        end
        if HealBot_Options_EFClassWarlock:GetChecked() then
            HealBot_Globals.EmergIncMelee[HEALBOT_WARLOCK] = true
        else
            HealBot_Globals.EmergIncMelee[HEALBOT_WARLOCK] = false
        end
        if HealBot_Options_EFClassWarrior:GetChecked() then
            HealBot_Globals.EmergIncMelee[HEALBOT_WARRIOR] = true
        else
            HealBot_Globals.EmergIncMelee[HEALBOT_WARRIOR] = false
        end
        if HealBot_Options_EFClassDemonHunter:GetChecked() then
            HealBot_Globals.EmergIncMelee[HEALBOT_DEMONHUNTER] = true
        else
            HealBot_Globals.EmergIncMelee[HEALBOT_DEMONHUNTER] = false
        end
        if HealBot_Options_EFClassDeathKnight:GetChecked() then
            HealBot_Globals.EmergIncMelee[HEALBOT_DEATHKNIGHT] = true
        else
            HealBot_Globals.EmergIncMelee[HEALBOT_DEATHKNIGHT] = false
        end
        if HealBot_Options_EFClassMonk:GetChecked() then
            HealBot_Globals.EmergIncMelee[HEALBOT_MONK] = true
        else
            HealBot_Globals.EmergIncMelee[HEALBOT_MONK] = false
        end
    elseif HealBot_Globals.EmergencyFClass==2 then
        if HealBot_Options_EFClassDruid:GetChecked() then
            HealBot_Globals.EmergIncRange[HEALBOT_DRUID] = true
        else
            HealBot_Globals.EmergIncRange[HEALBOT_DRUID] = false
        end
        if HealBot_Options_EFClassHunter:GetChecked() then
            HealBot_Globals.EmergIncRange[HEALBOT_HUNTER] = true
        else
            HealBot_Globals.EmergIncRange[HEALBOT_HUNTER] = false
        end
        if HealBot_Options_EFClassMage:GetChecked() then
            HealBot_Globals.EmergIncRange[HEALBOT_MAGE] = true
        else
            HealBot_Globals.EmergIncRange[HEALBOT_MAGE] = false
        end
        if HealBot_Options_EFClassPaladin:GetChecked() then
            HealBot_Globals.EmergIncRange[HEALBOT_PALADIN] = true
        else
            HealBot_Globals.EmergIncRange[HEALBOT_PALADIN] = false
        end
        if HealBot_Options_EFClassPriest:GetChecked() then
            HealBot_Globals.EmergIncRange[HEALBOT_PRIEST] = true
        else
            HealBot_Globals.EmergIncRange[HEALBOT_PRIEST] = false
        end
        if HealBot_Options_EFClassRogue:GetChecked() then
            HealBot_Globals.EmergIncRange[HEALBOT_ROGUE] = true
        else
            HealBot_Globals.EmergIncRange[HEALBOT_ROGUE] = false
        end
        if HealBot_Options_EFClassShaman:GetChecked() then
            HealBot_Globals.EmergIncRange[HEALBOT_SHAMAN] = true
        else
            HealBot_Globals.EmergIncRange[HEALBOT_SHAMAN] = false
        end
        if HealBot_Options_EFClassWarlock:GetChecked() then
            HealBot_Globals.EmergIncRange[HEALBOT_WARLOCK] = true
        else
            HealBot_Globals.EmergIncRange[HEALBOT_WARLOCK] = false
        end
        if HealBot_Options_EFClassWarrior:GetChecked() then
            HealBot_Globals.EmergIncRange[HEALBOT_WARRIOR] = true
        else
            HealBot_Globals.EmergIncRange[HEALBOT_WARRIOR] = false
        end
        if HealBot_Options_EFClassDemonHunter:GetChecked() then
            HealBot_Globals.EmergIncRange[HEALBOT_DEMONHUNTER] = true
        else
            HealBot_Globals.EmergIncRange[HEALBOT_DEMONHUNTER] = false
        end
        if HealBot_Options_EFClassDeathKnight:GetChecked() then
            HealBot_Globals.EmergIncRange[HEALBOT_DEATHKNIGHT] = true
        else
            HealBot_Globals.EmergIncRange[HEALBOT_DEATHKNIGHT] = false
        end
        if HealBot_Options_EFClassMonk:GetChecked() then
            HealBot_Globals.EmergIncRange[HEALBOT_MONK] = true
        else
            HealBot_Globals.EmergIncRange[HEALBOT_MONK] = false
        end
    elseif HealBot_Globals.EmergencyFClass==3 then
        if HealBot_Options_EFClassDruid:GetChecked() then
            HealBot_Globals.EmergIncHealers[HEALBOT_DRUID] = true
        else
            HealBot_Globals.EmergIncHealers[HEALBOT_DRUID] = false
        end
        if HealBot_Options_EFClassHunter:GetChecked() then
            HealBot_Globals.EmergIncHealers[HEALBOT_HUNTER] = true
        else
            HealBot_Globals.EmergIncHealers[HEALBOT_HUNTER] = false
        end
        if HealBot_Options_EFClassMage:GetChecked() then
            HealBot_Globals.EmergIncHealers[HEALBOT_MAGE] = true
        else
            HealBot_Globals.EmergIncHealers[HEALBOT_MAGE] = false
        end
        if HealBot_Options_EFClassPaladin:GetChecked() then
            HealBot_Globals.EmergIncHealers[HEALBOT_PALADIN] = true
        else
            HealBot_Globals.EmergIncHealers[HEALBOT_PALADIN] = false
        end
        if HealBot_Options_EFClassPriest:GetChecked() then
            HealBot_Globals.EmergIncHealers[HEALBOT_PRIEST] = true
        else
            HealBot_Globals.EmergIncHealers[HEALBOT_PRIEST] = false
        end
        if HealBot_Options_EFClassRogue:GetChecked() then
            HealBot_Globals.EmergIncHealers[HEALBOT_ROGUE] = true
        else
            HealBot_Globals.EmergIncHealers[HEALBOT_ROGUE] = false
        end
        if HealBot_Options_EFClassShaman:GetChecked() then
            HealBot_Globals.EmergIncHealers[HEALBOT_SHAMAN] = true
        else
            HealBot_Globals.EmergIncHealers[HEALBOT_SHAMAN] = false
        end
        if HealBot_Options_EFClassWarlock:GetChecked() then
            HealBot_Globals.EmergIncHealers[HEALBOT_WARLOCK] = true
        else
            HealBot_Globals.EmergIncHealers[HEALBOT_WARLOCK] = false
        end
        if HealBot_Options_EFClassWarrior:GetChecked() then
            HealBot_Globals.EmergIncHealers[HEALBOT_WARRIOR] = true
        else
            HealBot_Globals.EmergIncHealers[HEALBOT_WARRIOR] = false
        end
        if HealBot_Options_EFClassDemonHunter:GetChecked() then
            HealBot_Globals.EmergIncHealers[HEALBOT_DEMONHUNTER] = true
        else
            HealBot_Globals.EmergIncHealers[HEALBOT_DEMONHUNTER] = false
        end
        if HealBot_Options_EFClassDeathKnight:GetChecked() then
            HealBot_Globals.EmergIncHealers[HEALBOT_DEATHKNIGHT] = true
        else
            HealBot_Globals.EmergIncHealers[HEALBOT_DEATHKNIGHT] = false
        end
        if HealBot_Options_EFClassMonk:GetChecked() then
            HealBot_Globals.EmergIncHealers[HEALBOT_MONK] = true
        else
            HealBot_Globals.EmergIncHealers[HEALBOT_MONK] = false
        end
    elseif HealBot_Globals.EmergencyFClass==4 then
        if HealBot_Options_EFClassDruid:GetChecked() then
            HealBot_Globals.EmergIncCustom[HEALBOT_DRUID] = true
        else
            HealBot_Globals.EmergIncCustom[HEALBOT_DRUID] = false
        end
        if HealBot_Options_EFClassHunter:GetChecked() then
            HealBot_Globals.EmergIncCustom[HEALBOT_HUNTER] = true
        else
            HealBot_Globals.EmergIncCustom[HEALBOT_HUNTER] = false
        end
        if HealBot_Options_EFClassMage:GetChecked() then
            HealBot_Globals.EmergIncCustom[HEALBOT_MAGE] = true
        else
            HealBot_Globals.EmergIncCustom[HEALBOT_MAGE] = false
        end
        if HealBot_Options_EFClassPaladin:GetChecked() then
            HealBot_Globals.EmergIncCustom[HEALBOT_PALADIN] = true
        else
            HealBot_Globals.EmergIncCustom[HEALBOT_PALADIN] = false
        end
        if HealBot_Options_EFClassPriest:GetChecked() then
            HealBot_Globals.EmergIncCustom[HEALBOT_PRIEST] = true
        else
            HealBot_Globals.EmergIncCustom[HEALBOT_PRIEST] = false
        end
        if HealBot_Options_EFClassRogue:GetChecked() then
            HealBot_Globals.EmergIncCustom[HEALBOT_ROGUE] = true
        else
            HealBot_Globals.EmergIncCustom[HEALBOT_ROGUE] = false
        end
        if HealBot_Options_EFClassShaman:GetChecked() then
            HealBot_Globals.EmergIncCustom[HEALBOT_SHAMAN] = true
        else
            HealBot_Globals.EmergIncCustom[HEALBOT_SHAMAN] = false
        end
        if HealBot_Options_EFClassWarlock:GetChecked() then
            HealBot_Globals.EmergIncCustom[HEALBOT_WARLOCK] = true
        else
            HealBot_Globals.EmergIncCustom[HEALBOT_WARLOCK] = false
        end
        if HealBot_Options_EFClassWarrior:GetChecked() then
            HealBot_Globals.EmergIncCustom[HEALBOT_WARRIOR] = true
        else
            HealBot_Globals.EmergIncCustom[HEALBOT_WARRIOR] = false
        end
        if HealBot_Options_EFClassDemonHunter:GetChecked() then
            HealBot_Globals.EmergIncCustom[HEALBOT_DEMONHUNTER] = true
        else
            HealBot_Globals.EmergIncCustom[HEALBOT_DEMONHUNTER] = false
        end
        if HealBot_Options_EFClassDeathKnight:GetChecked() then
            HealBot_Globals.EmergIncCustom[HEALBOT_DEATHKNIGHT] = true
        else
            HealBot_Globals.EmergIncCustom[HEALBOT_DEATHKNIGHT] = false
        end
        if HealBot_Options_EFClassMonk:GetChecked() then
            HealBot_Globals.EmergIncCustom[HEALBOT_MONK] = true
        else
            HealBot_Globals.EmergIncCustom[HEALBOT_MONK] = false
        end
    end
    HealBot_Options_framesChanged(1)
end

HealBot_Options_StorePrev["CastNotify"]=1
function HealBot_Options_CastNotify_OnClick(self,id)
    local g=nil
    if id>0 and id~=HealBot_Options_StorePrev["CastNotify"] then
        g=_G["HealBot_Options_CastNotify"..HealBot_Options_StorePrev["CastNotify"]]
        g:SetChecked(false);
        HealBot_Options_StorePrev["CastNotify"]=id
    end
    Healbot_Config_Skins.Chat[Healbot_Config_Skins.Current_Skin]["NOTIFY"] = id;
    if Healbot_Config_Skins.Chat[Healbot_Config_Skins.Current_Skin]["NOTIFY"]>0 then
        g=_G["HealBot_Options_CastNotify"..Healbot_Config_Skins.Chat[Healbot_Config_Skins.Current_Skin]["NOTIFY"]]
        g:SetChecked(true);
    end
end

function HealBot_Options_HideOptions_OnClick(self)
    if self:GetChecked() then
        HealBot_Globals.HideOptions = true
    else
        HealBot_Globals.HideOptions = false
    end
    HealBot_Options_framesChanged(1)
end

function HealBot_Options_RightButtonOptions_OnClick(self)
    if self:GetChecked() then
        HealBot_Globals.RightButtonOptions=true
    else
        HealBot_Globals.RightButtonOptions=false
    end
end

function HealBot_Options_ShowMinimapButton_OnClick(self)
    if self:GetChecked() then
        HealBot_Globals.MinimapIcon.hide=false  -- Reversed intentionally 
    else
        HealBot_Globals.MinimapIcon.hide=true
    end
    HealBot_MMButton_Toggle()
end

function HealBot_Options_QueryTalents_OnClick(self)
    if self:GetChecked() then
        HealBot_Globals.QueryTalents=true
    else
        HealBot_Globals.QueryTalents=false
    end
end

function HealBot_Options_ShowTooltip_OnClick(self)
    if self:GetChecked() then
        HealBot_Globals.ShowTooltip = true
        HealBot_Options_LoadTips()
    else
        HealBot_Globals.ShowTooltip = false
    end
end

function HealBot_Options_AddonFail(reason, addon)
    StaticPopupDialogs["HEALBOT_OPTIONS_ADDONFAIL"] = {
        text = HEALBOT_OPTIONS_ADDON_FAIL.." "..addon.."\n"..HEALBOT_OPTIONS_LANG_ADDON_FAIL2.." "..reason.."\n\n"..HEALBOT_OPTIONS_LANG_ADDON_FAIL3.." "..addon,
        button1 = CLOSE,
        timeout = 0,
        whileDead = 1,
        hideOnEscape = 1
    };
    StaticPopup_Show("HEALBOT_OPTIONS_ADDONFAIL");
end

function HealBot_Options_LoadTips()
    local loaded, reason = LoadAddOn("HealBot_Tips")
    if loaded then
        HealBot_Data["TIPUSE"]=true
        if HealBot_Config_Buffs.BuffWatch then
            HealBot_setOptions_Timer(40)
        end
    else
        HealBot_Data["TIPUSE"]=false
        local failreason = reason or HEALBOT_WORDS_UNKNOWN
        HealBot_AddChat("Unable to load addon HealBot_Tips - Reason: "..failreason)
        if not HealBot_Globals.OneTimeMsg["Tips"] then
            HealBot_Globals.OneTimeMsg["Tips"]=true
            HealBot_Options_AddonFail(failreason, "HealBot_Tips")
        end
    end
end

function HealBot_Options_ShowTooltipUpdate_OnClick(self)
    if self:GetChecked() then
        HealBot_Globals.TooltipUpdate = true
    else
        HealBot_Globals.TooltipUpdate = false
    end
end

function HealBot_Options_HideTooltipInCombat_OnClick(self)
    if self:GetChecked() then
        HealBot_Globals.DisableToolTipInCombat = true
    else
        HealBot_Globals.DisableToolTipInCombat = false
    end
end

function HealBot_Options_ShowTooltipTarget_OnClick(self)
    if self:GetChecked() then
        HealBot_Globals.Tooltip_ShowTarget = true
    else
        HealBot_Globals.Tooltip_ShowTarget = false
    end
end

function HealBot_Options_ShowTooltipSpellDetail_OnClick(self)
    if self:GetChecked() then
        HealBot_Globals.Tooltip_ShowSpellDetail = true
    else
        HealBot_Globals.Tooltip_ShowSpellDetail = false
    end
end

function HealBot_Options_ShowTooltipSpellCoolDown_OnClick(self)
    if self:GetChecked() then
        HealBot_Globals.Tooltip_ShowCD = true
    else
        HealBot_Globals.Tooltip_ShowCD = false
    end
    HealBot_setTooltipUpdateInterval()
end

function HealBot_Options_ShowTooltipMouseWheel_OnClick(self)
    if self:GetChecked() then
        HealBot_Globals.Tooltip_MouseWheel = true
    else
        HealBot_Globals.Tooltip_MouseWheel = false
    end
end

function HealBot_Options_ShowTooltipInstant_OnClick(self)
    if self:GetChecked() then
        HealBot_Globals.Tooltip_Recommend = true
    else
        HealBot_Globals.Tooltip_Recommend = false
    end
end

function HealBot_Options_ShowTooltipUseGameTip_OnClick(self)
    if self:GetChecked() then
        HealBot_Globals.UseGameTooltip = true
    else
        HealBot_Globals.UseGameTooltip = false
    end
end

function HealBot_Options_ShowTooltipShowHoT_OnClick(self)
    if self:GetChecked() then
        HealBot_Globals.Tooltip_ShowHoT = true
    else
        HealBot_Globals.Tooltip_ShowHoT = false
    end
end

function HealBot_Options_ShowDebuffWarning_OnClick(self)
    if self:GetChecked() then
        HealBot_Config_Cures.ShowDebuffWarning = true
    else
        HealBot_Config_Cures.ShowDebuffWarning = false
    end
end

function HealBot_Options_ShowBuffWarning_OnClick(self)
    if self:GetChecked() then
        HealBot_Config_Buffs.ShowBuffWarning = true
    else
        HealBot_Config_Buffs.ShowBuffWarning = false
    end
end

function HealBot_Options_ShowDebuffIcon_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOWDEBUFF"] = true
    else
        Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOWDEBUFF"] = false
    end
end

function HealBot_Options_SoundDebuffWarning_OnClick(self)
    if self:GetChecked() then
        HealBot_Config_Cures.SoundDebuffWarning = true
    else
        HealBot_Config_Cures.SoundDebuffWarning = false
    end
end

function HealBot_Options_SoundBuffWarning_OnClick(self)
    if self:GetChecked() then
        HealBot_Config_Buffs.SoundBuffWarning = true
    else
        HealBot_Config_Buffs.SoundBuffWarning = false
    end
end

function HealBot_Options_NumberTextLines_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["DOUBLE"] = true
    else
        Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["DOUBLE"] = false
    end
    HealBot_Action_setTextLen(HealBot_Options_StorePrev["FramesSelFrame"])
    HealBot_setOptions_Timer(80)
    HealBot_Panel_resetTestCols()
end

function HealBot_Options_BarTextInClassColour_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CLASSCOL"] = true
    else
        Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CLASSCOL"] = false
    end
    HealBot_setLuVars("ResetAllUnitStatus", GetTime()+2)
    HealBot_Options_SetBarsTextColour()
    HealBot_Panel_resetTestCols(true)
    HealBot_Options_framesChanged(HealBot_Options_StorePrev["FramesSelFrame"])
end

function HealBot_Options_BarButtonShowHoT_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOWBUFF"] = true
    else
        Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOWBUFF"] = false
    end
end

function HealBot_Options_BarButtonShowRaidIcon_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOW"] = true
    else
        Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOW"] = false
    end
    HealBot_setOptions_Timer(800)
end

function HealBot_Options_BarButtonShowRaidIconStar_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["STAR"] = true
    else
        Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["STAR"] = false
    end
    HealBot_setOptions_Timer(800)
end

function HealBot_Options_BarButtonShowRaidIconCircle_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CIRCLE"] = true
    else
        Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CIRCLE"] = false
    end
    HealBot_setOptions_Timer(800)
end

function HealBot_Options_BarButtonShowRaidIconDiamond_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["DIAMOND"] = true
    else
        Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["DIAMOND"] = false
    end
    HealBot_setOptions_Timer(800)
end

function HealBot_Options_BarButtonShowRaidIconTriangle_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TRIANGLE"] = true
    else
        Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TRIANGLE"] = false
    end
    HealBot_setOptions_Timer(800)
end

function HealBot_Options_BarButtonShowRaidIconMoon_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["MOON"] = true
    else
        Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["MOON"] = false
    end
    HealBot_setOptions_Timer(800)
end

function HealBot_Options_BarButtonShowRaidIconSquare_OnClick(self)
    if self:GetChecked() then
       Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SQUARE"] = true
    else
       Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SQUARE"] = false
    end
    HealBot_setOptions_Timer(800)
end

function HealBot_Options_BarButtonShowRaidIconCross_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CROSS"] = true
    else
        Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CROSS"] = false
    end
    HealBot_setOptions_Timer(800)
end

function HealBot_Options_BarButtonShowRaidIconSkull_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SKULL"] = true
    else
        Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SKULL"] = false
    end
    HealBot_setOptions_Timer(800)
end

function HealBot_Options_SubSortPlayerFirst_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SUBPF"] = true
    else
        Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SUBPF"] = false
    end
    HealBot_Options_framesChanged(1)
end

function HealBot_Options_ShowReadyCheck_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOWRC"] = true
    else
        Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOWRC"] = false
    end
    HealBot_Options_CheckReadyCheckEvent()
end

function HealBot_Options_ShowDirection_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOWDIR"] = true
    else
        Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOWDIR"] = false
    end
    HealBot_setLuVars("ResetAllUnitStatus", GetTime()+2)
end

function HealBot_Options_ShowDirectionMouseOver_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOWDIRMOUSE"] = true
    else
        Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOWDIRMOUSE"] = false
    end
    HealBot_setLuVars("ResetAllUnitStatus", GetTime()+2)
end

function HealBot_Options_CheckReadyCheckEvent()
    local noReadyCheck=true
    for h=1,10 do
        if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][h]["SHOWRC"] then
            noReadyCheck=false
        end
    end
    if noReadyCheck then
        HealBot_UnRegister_ReadyCheck()
    else
        HealBot_Register_ReadyCheck()
    end
end

function HealBot_Options_RaidTargetUpdate()
    local tVal=nil
    for j=1,10 do
        if Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][j]["SHOW"] then 
            tVal=true
        end
    end
    HealBot_RaidTargetToggle(tVal) 
end

function HealBot_BarButtonShowHoTTextCount_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SCNT"] = true
    else
        Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SCNT"] = false
    end
end

function HealBot_BarButtonShowHoTTextCountSelfCast_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SSCNT"] = true
    else
        Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SSCNT"] = false
    end
end

function HealBot_BarButtonShowHoTTextDuration_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SDUR"] = true
    else
        Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SDUR"] = false
    end
end

function HealBot_BarButtonShowHoTTextDurationSelfCast_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SSDUR"] = true
    else
        Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SSDUR"] = false
    end
end

function HealBot_Options_ShowHealthOnBar_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HLTHONBAR"] = true
    else
        Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HLTHONBAR"] = false
    end
    HealBot_setOptions_Timer(80)
end

function HealBot_HoTonBar_OnClick(self,id)
    local g=_G["HealBot_BarButtonShowHoTonBar1"]
    g:SetChecked(nil);
    g=_G["HealBot_BarButtonShowHoTonBar2"]
    g:SetChecked(nil);
    g=_G["HealBot_BarButtonShowHoTonBar3"]
    g:SetChecked(nil);
    Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["ONBAR"] = id;
    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["ONBAR"]>0 then
        g=_G["HealBot_BarButtonShowHoTonBar"..Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["ONBAR"]]
        g:SetChecked(1);
        HealBot_setOptions_Timer(150)
    end
end

function HealBot_HoTposBar_OnClick(self,id)
    local g=_G["HealBot_BarButtonShowHoTposBar1"]
    g:SetChecked(nil);
    g=_G["HealBot_BarButtonShowHoTposBar2"]
    g:SetChecked(nil);
    Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["POSITION"] = id;
    if Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["POSITION"]>0 then
        g=_G["HealBot_BarButtonShowHoTposBar"..Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["POSITION"]]
        g:SetChecked(1);
        HealBot_setOptions_Timer(150)
    end
end

function HealBot_HoTx2Bar_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["DOUBLE"] = true
    else
        Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["DOUBLE"] = false
    end
    HealBot_setOptions_Timer(150)
end

function HealBot_BarButtonIconAlwaysEnabled_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["I15EN"] = true
    else
        Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["I15EN"] = false
    end
    HealBot_setOptions_Timer(150)
end

function HealBot_BarButtonIconFadeOnExpire_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["FADE"] = true
    else
        Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["FADE"] = false
    end
    HealBot_setIconUpdateInterval()
    HealBot_setOptions_Timer(150)
end

function HealBot_Options_ShowClassOnBarType_OnClick(self,id)
    local g=_G["HealBot_Options_ShowClassOnBarType1"]
    g:SetChecked(nil);
    g=_G["HealBot_Options_ShowClassOnBarType2"]
    g:SetChecked(nil);
    Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CLASSTYPE"] = id;
    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CLASSTYPE"]>0 then
        g=_G["HealBot_Options_ShowClassOnBarType"..Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CLASSTYPE"]]
        g:SetChecked(1);
        HealBot_ResetClassIconTexture()
    end
    HealBot_Options_framesChanged(HealBot_Options_StorePrev["FramesSelFrame"])
end

function HealBot_Options_ProtectPvP_OnClick(self)
    if self:GetChecked() then
        HealBot_Globals.ProtectPvP = true
    else
        HealBot_Globals.ProtectPvP = false
    end
end

function HealBot_Options_ShowRoleOnBar_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOWROLE"] = true
    else
        Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOWROLE"] = false
    end
    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CLASSTYPE"]>0 then
        HealBot_ResetClassIconTexture()
    end
    HealBot_Options_framesChanged(HealBot_Options_StorePrev["FramesSelFrame"])
end

--------------------------------------------------------------------------------

function HealBot_Options_TargetInCombat_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    if HealBot_Options_StorePrev["FramesSelFrame"]~=8 then
        info.text = " "
        UIDropDownMenu_AddButton(info);
    else
        for j=1, getn(HealBot_Options_TargetFocusInCombat_List), 1 do
            info.text = HealBot_Options_TargetFocusInCombat_List[j];
            info.func = function(self)
                            Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TARGETINCOMBAT"] = self:GetID()
                            UIDropDownMenu_SetText(HealBot_Options_TargetInCombat,HealBot_Options_TargetFocusInCombat_List[Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TARGETINCOMBAT"]]) 
                            HealBot_Options_framesChanged(8)
                        end
            info.checked = false;
            if Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TARGETINCOMBAT"]==j then info.checked = true end
            UIDropDownMenu_AddButton(info);
        end
    end
end

function HealBot_Options_FocusInCombat_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    if HealBot_Options_StorePrev["FramesSelFrame"]~=9 then
        info.text = " "
        UIDropDownMenu_AddButton(info);
    else
        for j=1, getn(HealBot_Options_TargetFocusInCombat_List), 1 do
            info.text = HealBot_Options_TargetFocusInCombat_List[j];
            info.func = function(self)
                            Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["FOCUSINCOMBAT"] = self:GetID()
                            UIDropDownMenu_SetText(HealBot_Options_FocusInCombat,HealBot_Options_TargetFocusInCombat_List[Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["FOCUSINCOMBAT"]]) 
                            HealBot_Options_framesChanged(8)
                        end
            info.checked = false;
            if Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["FOCUSINCOMBAT"]==j then info.checked = true end
            UIDropDownMenu_AddButton(info);
        end
    end
end

--------------------------------------------------------------------------------

HealBot_Options_StorePrev["hbBarHealthNumFormatTxt"]="1,2K"

function HealBot_Options_BarHealthNumFormat_genList()
    local HealBot_Options_BarHealthNumFormat_List={}
    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HLTHTYPE"]==1 then
        local HealBot_Options_BarHealthNumFormat1h_List = {
            "1234",
            "1K",
            "1.2K",
            "1.23K",
            "1k",
            "1.2k",
            "1.23k",
            "1",
            "1.2",
            "1.23",
            HEALBOT_WORD_AUTO,
        }
        HealBot_Options_BarHealthNumFormat_List=HealBot_Options_BarHealthNumFormat1h_List
    elseif Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HLTHTYPE"]==2 then
        local HealBot_Options_BarHealthNumFormat1d_List = {
            "-4321",
            "-4K",
            "-4.3K",
            "-4.32K",
            "-4k",
            "-4.3k",
            "-4.32k",
            "-4",
            "-4.3",
            "-4.32",
            HEALBOT_WORD_AUTO,
        }
        HealBot_Options_BarHealthNumFormat_List=HealBot_Options_BarHealthNumFormat1d_List
    else
        local HealBot_Options_BarHealthNumFormat1p_List = {
            "88%",
            "88%",
            "88%",
            "88%",
            "88%",
            "88%",
            "88%",
            "88%",
            "88%",
            "88%",
            HEALBOT_WORD_AUTO,
        }
        HealBot_Options_BarHealthNumFormat_List=HealBot_Options_BarHealthNumFormat1p_List
    end
    HealBot_Options_StorePrev["hbBarHealthNumFormatTxt"]=HealBot_Options_BarHealthNumFormat_List[Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["NUMFORMAT1"]]
    return HealBot_Options_BarHealthNumFormat_List
end

function HealBot_Options_BarHealthNumFormat1_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    local HealBot_Options_BarHealthNumFormat1_List=HealBot_Options_BarHealthNumFormat_genList()
    for j=1, getn(HealBot_Options_BarHealthNumFormat1_List), 1 do
        info.text = HealBot_Options_BarHealthNumFormat1_List[j];
        info.func = function(self)
                        Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["NUMFORMAT1"] = self:GetID()
                        HealBot_Options_StorePrev["hbBarHealthNumFormatTxt"]=self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_BarHealthNumFormat1,HealBot_Options_BarHealthNumFormat1_List[Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["NUMFORMAT1"]]) 
                        DoneInitTab[303]=nil
                        HealBot_Options_InitSub(303)
                        HealBot_setOptions_Timer(80)
                    end
        info.checked = false;
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["NUMFORMAT1"]==j then
            HealBot_Options_StorePrev["hbBarHealthNumFormatTxt"]=HealBot_Options_BarHealthNumFormat1_List[j]
            info.checked = true
        end
        UIDropDownMenu_AddButton(info);
    end
end

--------------------------------------------------------------------------------

local HealBot_Options_BarHealthNumFormat2_List = {
    " ", " ",
    "(", ")",
    "[", "]",
    "{", "}",
    "<", ">",
    "~", " ",
    ":", ":",
    "*", "*",
}

function HealBot_Options_BarHealthNumFormat2_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    local i=0
    for j=1, getn(HealBot_Options_BarHealthNumFormat2_List), 2 do
        i=i+1
        local nFormat = HealBot_Options_BarHealthNumFormat2_List[j]..HealBot_Options_StorePrev["hbBarHealthNumFormatTxt"]..HealBot_Options_BarHealthNumFormat2_List[j+1];
        info.text = nFormat
        info.func = function(self)
                        Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["NUMFORMAT2"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_BarHealthNumFormat2,nFormat) 
                        HealBot_setOptions_Timer(80)
                    end
        info.checked = false;
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["NUMFORMAT2"]==i then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

--------------------------------------------------------------------------------

function HealBot_Options_BarHealthNumFormatAggro_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    local i=0
    for j=1, getn(HealBot_Options_BarHealthNumFormat2_List), 2 do
        i=i+1
        local nFormat = HealBot_Options_BarHealthNumFormat2_List[j].."77%"..HealBot_Options_BarHealthNumFormat2_List[j+1];
        info.text = nFormat
        info.func = function(self)
                        Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTFORMAT"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_BarHealthNumFormatAggro,nFormat) 
                        HealBot_setOptions_Timer(80)
                    end
        info.checked = false;
        if Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTFORMAT"]==i then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

--------------------------------------------------------------------------------
function HealBot_Options_HealGroups1Frame_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, 5, 1 do
        info.text = HealBot_Options_HealGroupsFrame_List[j];
        info.func = function(self)
                        Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][1]["FRAME"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_HealGroups1Frame,HealBot_Options_HealGroupsFrame_List[Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][1]["FRAME"]]) 
                        HealBot_Options_framesChanged(1)
                    end
        info.checked = false;
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][1]["FRAME"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_HealGroups2Frame_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, 5, 1 do
        info.text = HealBot_Options_HealGroupsFrame_List[j];
        info.func = function(self)
                        Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][2]["FRAME"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_HealGroups2Frame,HealBot_Options_HealGroupsFrame_List[Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][2]["FRAME"]]) 
                        HealBot_Options_framesChanged(1)
                    end
        info.checked = false;
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][2]["FRAME"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_HealGroups3Frame_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, 5, 1 do
        info.text = HealBot_Options_HealGroupsFrame_List[j];
        info.func = function(self)
                        Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][3]["FRAME"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_HealGroups3Frame,HealBot_Options_HealGroupsFrame_List[Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][3]["FRAME"]]) 
                        HealBot_Options_framesChanged(1)
                    end
        info.checked = false;
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][3]["FRAME"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_HealGroups4Frame_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, 5, 1 do
        info.text = HealBot_Options_HealGroupsFrame_List[j];
        info.func = function(self)
                        Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][4]["FRAME"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_HealGroups4Frame,HealBot_Options_HealGroupsFrame_List[Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][4]["FRAME"]]) 
                        HealBot_Options_framesChanged(1)
                    end
        info.checked = false;
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][4]["FRAME"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_HealGroups5Frame_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, 5, 1 do
        info.text = HealBot_Options_HealGroupsFrame_List[j];
        info.func = function(self)
                        Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][5]["FRAME"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_HealGroups5Frame,HealBot_Options_HealGroupsFrame_List[Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][5]["FRAME"]]) 
                        HealBot_Options_framesChanged(1)
                    end
        info.checked = false;
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][5]["FRAME"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_HealGroups6Frame_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, 5, 1 do
        info.text = HealBot_Options_HealGroupsFrame_List[j];
        info.func = function(self)
                        Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][6]["FRAME"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_HealGroups6Frame,HealBot_Options_HealGroupsFrame_List[Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][6]["FRAME"]]) 
                        HealBot_Options_framesChanged(1)
                    end
        info.checked = false;
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][6]["FRAME"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_HealGroups7Frame_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, 5, 1 do
        info.text = HealBot_Options_HealGroupsFrame_List[j];
        info.func = function(self)
                        Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["FRAME"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_HealGroups7Frame,HealBot_Options_HealGroupsFrame_List[Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["FRAME"]]) 
                        HealBot_Options_framesChanged(1)
                        HealBot_Options_framesChanged(6)
                    end
        info.checked = false;
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["FRAME"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
    info.text = HEALBOT_VEHICLE_en
    info.func = function(self)
                    Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["FRAME"] = 6
                    UIDropDownMenu_SetText(HealBot_Options_HealGroups7Frame,HEALBOT_VEHICLE_en) 
                    HealBot_Options_framesChanged(1)
                    HealBot_Options_framesChanged(6)
                end
    info.checked = false;
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["FRAME"]==6 then info.checked = true end
    UIDropDownMenu_AddButton(info);
end

function HealBot_Options_HealGroups8Frame_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, 5, 1 do
        info.text = HealBot_Options_HealGroupsFrame_List[j];
        info.func = function(self)
                        Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["FRAME"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_HealGroups8Frame,HealBot_Options_HealGroupsFrame_List[Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["FRAME"]]) 
                        HealBot_Options_framesChanged(1)
                        HealBot_Options_framesChanged(7)
                    end
        info.checked = false;
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["FRAME"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
    info.text = HEALBOT_OPTIONS_PETHEALS_en
    info.func = function(self)
                    Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["FRAME"] = 7
                    UIDropDownMenu_SetText(HealBot_Options_HealGroups8Frame,HEALBOT_OPTIONS_PETHEALS_en) 
                    HealBot_Options_framesChanged(1)
                    HealBot_Options_framesChanged(7)
                end
    info.checked = false;
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["FRAME"]==7 then info.checked = true end
    UIDropDownMenu_AddButton(info);
end

function HealBot_Options_HealGroups9Frame_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    info.text = HEALBOT_OPTIONS_TARGETHEALS_en
    info.checked = true;
    UIDropDownMenu_AddButton(info);
end

function HealBot_Options_HealGroups10Frame_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    info.text = HEALBOT_FOCUS_en
    info.checked = true;
    UIDropDownMenu_AddButton(info);
end

function HealBot_Options_HealGroups11Frame_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    info.text = HEALBOT_CUSTOM_CASTBY_ENEMY_en
    info.checked = true;
    UIDropDownMenu_AddButton(info);
end

--------------------------------------------------------------------------------

function HealBot_Options_FontOutline_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_FontOutline_List), 1 do
        info.text = HealBot_Options_FontOutline_List[j];
        info.func = function(self)
                        Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["OUTLINE"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_FontOutline,HealBot_Options_FontOutline_List[Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["OUTLINE"]]) 
                        HealBot_setOptions_Timer(150)
                        HealBot_setOptions_Timer(160)
                    end
        info.checked = false;
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["OUTLINE"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_AliasFontOutline_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_FontOutline_List), 1 do
        info.text = HealBot_Options_FontOutline_List[j];
        info.func = function(self)
                        Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["OUTLINE"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_AliasFontOutline,HealBot_Options_FontOutline_List[Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["OUTLINE"]]) 
                        HealBot_setOptions_Timer(415)
                        HealBot_setOptions_Timer(160)
                    end
        info.checked = false;
        if Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["OUTLINE"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

--------------------------------------------------------------------------------

function HealBot_Options_HeadFontOutline_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_FontOutline_List), 1 do
        info.text = HealBot_Options_FontOutline_List[j];
        info.func = function(self)
                        Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["OUTLINE"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_HeadFontOutline,HealBot_Options_FontOutline_List[Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["OUTLINE"]]) 
                        HealBot_setOptions_Timer(150)
                        HealBot_setOptions_Timer(160)
                    end
        info.checked = false;
        if Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["OUTLINE"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_IconFontOutline_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_FontOutline_List), 1 do
        info.text = HealBot_Options_FontOutline_List[j];
        info.func = function(self)
                        Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["OUTLINE"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_IconFontOutline,HealBot_Options_FontOutline_List[Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["OUTLINE"]]) 
                        HealBot_setOptions_Timer(150)
                        HealBot_setOptions_Timer(160)
                    end
        info.checked = false;
        if Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["OUTLINE"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

-------------------------------------------

function HealBot_Options_BarHealthIncHeal_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_BarHealthIncHeal_List), 1 do
        info.text = HealBot_Options_BarHealthIncHeal_List[j];
        info.func = function(self)
                        Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["INCHEALS"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_BarHealthIncHeal,HealBot_Options_BarHealthIncHeal_List[Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["INCHEALS"]]) 
                        HealBot_setOptions_Timer(80)
                    end
        info.checked = false;
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["INCHEALS"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

--------------------------------------------------------------------------------

function HealBot_Options_BarHealthColour_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_BarHealthColour_List), 1 do
        info.text = HealBot_Options_BarHealthColour_List[j];
        info.func = function(self)
                        Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HLTH"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_BarHealthColour,HealBot_Options_BarHealthColour_List[Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HLTH"]]) 
                        HealBot_setOptions_Timer(80)
                        HealBot_Panel_resetTestCols(true)
                    end
        info.checked = false;
        if Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HLTH"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_BarHealthBackColour_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_BarHealthColour_List), 1 do
        info.text = HealBot_Options_BarHealthColour_List[j];
        info.func = function(self)
                        Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BACK"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_BarHealthBackColour,HealBot_Options_BarHealthColour_List[Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BACK"]]) 
                        HealBot_setOptions_Timer(80)
                    end
        info.checked = false;
        if Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BACK"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

-------------------------------------------

function HealBot_Options_BarIncHealColour_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_BarIncHealColour_List), 1 do
        info.text = HealBot_Options_BarIncHealColour_List[j];
        info.func = function(self)
                        Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["IC"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_BarIncHealColour,HealBot_Options_BarIncHealColour_List[Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["IC"]]) 
                        HealBot_Options_CheckInHealsEvent()
                    end
        info.checked = false;
        if Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["IC"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

-------------------------------------------

function HealBot_Options_AbsorbColour_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_AbsorbColour_List), 1 do
        info.text = HealBot_Options_AbsorbColour_List[j];
        info.func = function(self)
                        Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["AC"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_AbsorbColour,HealBot_Options_AbsorbColour_List[Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["AC"]]) 
                        HealBot_Options_CheckInHealsEvent()
                    end
        info.checked = false;
        if Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["AC"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_CheckInHealsEvent()
    local noIncHeals=true
    for h=1,10 do
        if Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][h]["IC"]>1 or Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][h]["AC"]>1 then
            noIncHeals=false
        end
    end
    if noIncHeals then
        HealBot_UnRegister_IncHeals()
    else
        HealBot_Register_IncHeals()
    end
end

-------------------------------------------
local function HealBot_Options_BarHealthType_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_BarHealthType_List), 1 do
        info.text = HealBot_Options_BarHealthType_List[j];
        info.func = function(self)
                        Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HLTHTYPE"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_BarHealthType, HealBot_Options_BarHealthType_List[Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HLTHTYPE"]])
                        DoneInitTab[303]=nil
                        HealBot_Options_InitSub(303)
                        HealBot_setOptions_Timer(80)
                        HealBot_Panel_resetTestCols()
                    end
        info.checked = false;
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HLTHTYPE"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

--------------------------------------------------------------------------------

local function HealBot_Options_CastButton_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_CastButton_List), 1 do
        info.text = HealBot_Options_CastButton_List[j];
        info.func = function(self)
                        HealBot_Options_ComboButtons_Button = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_CastButton, HealBot_Options_CastButton_List[HealBot_Options_ComboButtons_Button])
                        HealBot_Options_ComboClass_Text()
                    end
        info.checked = false;
        if HealBot_Options_ComboButtons_Button==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

--------------------------------------------------------------------------------

function HealBot_Options_ButtonCastMethod_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_ButtonCastMethod_List), 1 do
        info.text = HealBot_Options_ButtonCastMethod_List[j];
        info.func = function(self)
                        local x=HealBot_Config_Spells.ButtonCastMethod
                        HealBot_Config_Spells.ButtonCastMethod = self:GetID()
                        if x~=HealBot_Config_Spells.ButtonCastMethod then 
                            UIDropDownMenu_SetText(HealBot_Options_ButtonCastMethod, HealBot_Options_ButtonCastMethod_List[HealBot_Config_Spells.ButtonCastMethod])
                            HealBot_setOptions_Timer(110)
                        end
                    end
        info.checked = false;
        if HealBot_Config_Spells.ButtonCastMethod==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end


--------------------------------------------------------------------------------

function HealBot_Options_TestBarsProfile_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_TestBarsProfile_List), 1 do
        info.text = HealBot_Options_TestBarsProfile_List[j];
        info.func = function(self)
                        local x=HealBot_Globals.TestBars["PROFILE"]
                        HealBot_Globals.TestBars["PROFILE"] = self:GetID()
                        if x~=HealBot_Globals.TestBars["PROFILE"] then 
                            UIDropDownMenu_SetText(HealBot_Options_TestBarsProfile, HealBot_Options_TestBarsProfile_List[HealBot_Globals.TestBars["PROFILE"]])
                            HealBot_Panel_resetTestCols(true)
                        end
                    end
        info.checked = false;
        if HealBot_Globals.TestBars["PROFILE"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

--------------------------------------------------------------------------------

function HealBot_Options_TooltipTextSize_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_TooltipFontSize_List), 1 do
        info.text = HealBot_Options_TooltipFontSize_List[j];
        info.func = function(self)
                        HealBot_Globals.Tooltip_TextSize = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_TooltipTextSize, HealBot_Options_TooltipFontSize_List[HealBot_Globals.Tooltip_TextSize])
                        HealBot_Tooltip_setLuVars("doInit", true)
                    end
        info.checked = false;
        if HealBot_Globals.Tooltip_TextSize == j then info.checked = true; end
        UIDropDownMenu_AddButton(info);
    end
end

--------------------------------------------------------------------------------

local function HealBot_Options_MouseWheelUpEmotes_Display()
    if HealBot_Globals.HealBot_MouseWheelTxt["NoneUp"]==HEALBOT_EMOTE then
        HealBot_Options_MouseWheelUpEmotes:Show()
    else
        HealBot_Options_MouseWheelUpEmotes:Hide()
    end
end

function HealBot_Options_MouseWheelUp_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_MouseWheel_List), 1 do
        info.text = HealBot_Options_MouseWheel_List[j];
        info.func = function(self)
                        HealBot_Globals.HealBot_MouseWheelIndex["NoneUp"] = self:GetID()
                        HealBot_Globals.HealBot_MouseWheelTxt["NoneUp"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelUp, HealBot_Options_MouseWheel_List[HealBot_Globals.HealBot_MouseWheelIndex["NoneUp"]])
                        HealBot_Options_MouseWheelUpEmotes_Display()
                    end
        info.checked = false;
        if HealBot_Globals.HealBot_MouseWheelIndex["NoneUp"] == j then info.checked = true; end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_MouseWheelUpEmotes_DropDown(self, level, menuList)
    local info = UIDropDownMenu_CreateInfo()
    if level == 1 then
        for j=1, getn(HealBot_Options_EmoteCat_List), 1 do
            info.text = HealBot_Options_EmoteCat_List[j];
            info.hasArrow = true
            info.menuList = HealBot_Options_EmoteCat_List[j], true, HealBot_Options_EmoteCat_List[j]
            UIDropDownMenu_AddButton(info)
        end
    elseif menuList == HEALBOT_EMOTE_CAT_COMBAT then
        for j=1, getn(HealBot_Options_EmoteCombat_List), 1 do
            info.text = HealBot_Options_EmoteCombat_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["NoneUp"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelUpEmotes, HealBot_Globals.HealBot_Emotes["NoneUp"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["NoneUp"] == HealBot_Options_EmoteCombat_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    elseif menuList == HEALBOT_EMOTE_CAT_EMOTION then
        for j=1, getn(HealBot_Options_EmoteEmotion_List), 1 do
            info.text = HealBot_Options_EmoteEmotion_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["NoneUp"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelUpEmotes, HealBot_Globals.HealBot_Emotes["NoneUp"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["NoneUp"] == HealBot_Options_EmoteEmotion_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    elseif menuList == HEALBOT_EMOTE_CAT_HAPPY then
        for j=1, getn(HealBot_Options_EmoteHappy_List), 1 do
            info.text = HealBot_Options_EmoteHappy_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["NoneUp"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelUpEmotes, HealBot_Globals.HealBot_Emotes["NoneUp"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["NoneUp"] == HealBot_Options_EmoteHappy_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    elseif menuList == HEALBOT_EMOTE_CAT_GREET then
        for j=1, getn(HealBot_Options_EmoteGreet_List), 1 do
            info.text = HealBot_Options_EmoteGreet_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["NoneUp"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelUpEmotes, HealBot_Globals.HealBot_Emotes["NoneUp"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["NoneUp"] == HealBot_Options_EmoteGreet_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    elseif menuList == HEALBOT_EMOTE_CAT_OTHER then
        for j=1, getn(HealBot_Options_EmoteOther_List), 1 do
            info.text = HealBot_Options_EmoteOther_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["NoneUp"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelUpEmotes, HealBot_Globals.HealBot_Emotes["NoneUp"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["NoneUp"] == HealBot_Options_EmoteOther_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    elseif menuList == HEALBOT_EMOTE_CAT_RESPECT then
        for j=1, getn(HealBot_Options_EmoteRespect_List), 1 do
            info.text = HealBot_Options_EmoteRespect_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["NoneUp"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelUpEmotes, HealBot_Globals.HealBot_Emotes["NoneUp"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["NoneUp"] == HealBot_Options_EmoteRespect_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    elseif menuList == HEALBOT_EMOTE_CAT_UNHAPPY then
        for j=1, getn(HealBot_Options_EmoteUnhappy_List), 1 do
            info.text = HealBot_Options_EmoteUnhappy_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["NoneUp"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelUpEmotes, HealBot_Globals.HealBot_Emotes["NoneUp"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["NoneUp"] == HealBot_Options_EmoteUnhappy_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    end
end

local function HealBot_Options_MouseWheelDownEmotes_Display()
    if HealBot_Globals.HealBot_MouseWheelTxt["NoneDown"]==HEALBOT_EMOTE then
        HealBot_Options_MouseWheelDownEmotes:Show()
    else
        HealBot_Options_MouseWheelDownEmotes:Hide()
    end
end

function HealBot_Options_MouseWheelDown_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_MouseWheel_List), 1 do
        info.text = HealBot_Options_MouseWheel_List[j];
        info.func = function(self)
                        HealBot_Globals.HealBot_MouseWheelIndex["NoneDown"] = self:GetID()
                        HealBot_Globals.HealBot_MouseWheelTxt["NoneDown"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelDown, HealBot_Options_MouseWheel_List[HealBot_Globals.HealBot_MouseWheelIndex["NoneDown"]])
                        HealBot_Options_MouseWheelDownEmotes_Display()
                    end
        info.checked = false;
        if HealBot_Globals.HealBot_MouseWheelIndex["NoneDown"] == j then info.checked = true; end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_MouseWheelDownEmotes_DropDown(self, level, menuList)
    local info = UIDropDownMenu_CreateInfo()
    if level == 1 then
        for j=1, getn(HealBot_Options_EmoteCat_List), 1 do
            info.text = HealBot_Options_EmoteCat_List[j];
            info.hasArrow = true
            info.menuList = HealBot_Options_EmoteCat_List[j], true, HealBot_Options_EmoteCat_List[j]
            UIDropDownMenu_AddButton(info)
        end
    elseif menuList == HEALBOT_EMOTE_CAT_COMBAT then
        for j=1, getn(HealBot_Options_EmoteCombat_List), 1 do
            info.text = HealBot_Options_EmoteCombat_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["NoneDown"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelDownEmotes, HealBot_Globals.HealBot_Emotes["NoneDown"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["NoneDown"] == HealBot_Options_EmoteCombat_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    elseif menuList == HEALBOT_EMOTE_CAT_EMOTION then
        for j=1, getn(HealBot_Options_EmoteEmotion_List), 1 do
            info.text = HealBot_Options_EmoteEmotion_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["NoneDown"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelDownEmotes, HealBot_Globals.HealBot_Emotes["NoneDown"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["NoneDown"] == HealBot_Options_EmoteEmotion_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    elseif menuList == HEALBOT_EMOTE_CAT_HAPPY then
        for j=1, getn(HealBot_Options_EmoteHappy_List), 1 do
            info.text = HealBot_Options_EmoteHappy_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["NoneDown"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelDownEmotes, HealBot_Globals.HealBot_Emotes["NoneDown"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["NoneDown"] == HealBot_Options_EmoteHappy_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    elseif menuList == HEALBOT_EMOTE_CAT_GREET then
        for j=1, getn(HealBot_Options_EmoteGreet_List), 1 do
            info.text = HealBot_Options_EmoteGreet_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["NoneDown"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelDownEmotes, HealBot_Globals.HealBot_Emotes["NoneDown"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["NoneDown"] == HealBot_Options_EmoteGreet_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    elseif menuList == HEALBOT_EMOTE_CAT_OTHER then
        for j=1, getn(HealBot_Options_EmoteOther_List), 1 do
            info.text = HealBot_Options_EmoteOther_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["NoneDown"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelDownEmotes, HealBot_Globals.HealBot_Emotes["NoneDown"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["NoneDown"] == HealBot_Options_EmoteOther_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    elseif menuList == HEALBOT_EMOTE_CAT_RESPECT then
        for j=1, getn(HealBot_Options_EmoteRespect_List), 1 do
            info.text = HealBot_Options_EmoteRespect_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["NoneDown"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelDownEmotes, HealBot_Globals.HealBot_Emotes["NoneDown"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["NoneDown"] == HealBot_Options_EmoteRespect_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    elseif menuList == HEALBOT_EMOTE_CAT_UNHAPPY then
        for j=1, getn(HealBot_Options_EmoteUnhappy_List), 1 do
            info.text = HealBot_Options_EmoteUnhappy_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["NoneDown"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelDownEmotes, HealBot_Globals.HealBot_Emotes["NoneDown"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["NoneDown"] == HealBot_Options_EmoteUnhappy_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    end
end

local function HealBot_Options_MouseWheelShiftUpEmotes_Display()
    if HealBot_Globals.HealBot_MouseWheelTxt["ShiftUp"]==HEALBOT_EMOTE then
        HealBot_Options_MouseWheelShiftUpEmotes:Show()
    else
        HealBot_Options_MouseWheelShiftUpEmotes:Hide()
    end
end

function HealBot_Options_MouseWheelShiftUp_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_MouseWheel_List), 1 do
        info.text = HealBot_Options_MouseWheel_List[j];
        info.func = function(self)
                        HealBot_Globals.HealBot_MouseWheelIndex["ShiftUp"] = self:GetID()
                        HealBot_Globals.HealBot_MouseWheelTxt["ShiftUp"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelShiftUp, HealBot_Options_MouseWheel_List[HealBot_Globals.HealBot_MouseWheelIndex["ShiftUp"]])
                        HealBot_Options_MouseWheelShiftUpEmotes_Display()
                    end
        info.checked = false;
        if HealBot_Globals.HealBot_MouseWheelIndex["ShiftUp"] == j then info.checked = true; end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_MouseWheelShiftUpEmotes_DropDown(self, level, menuList)
    local info = UIDropDownMenu_CreateInfo()
    if level == 1 then
        for j=1, getn(HealBot_Options_EmoteCat_List), 1 do
            info.text = HealBot_Options_EmoteCat_List[j];
            info.hasArrow = true
            info.menuList = HealBot_Options_EmoteCat_List[j], true, HealBot_Options_EmoteCat_List[j]
            UIDropDownMenu_AddButton(info)
        end
    elseif menuList == HEALBOT_EMOTE_CAT_COMBAT then
        for j=1, getn(HealBot_Options_EmoteCombat_List), 1 do
            info.text = HealBot_Options_EmoteCombat_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["ShiftUp"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelShiftUpEmotes, HealBot_Globals.HealBot_Emotes["ShiftUp"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["ShiftUp"] == HealBot_Options_EmoteCombat_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    elseif menuList == HEALBOT_EMOTE_CAT_EMOTION then
        for j=1, getn(HealBot_Options_EmoteEmotion_List), 1 do
            info.text = HealBot_Options_EmoteEmotion_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["ShiftUp"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelShiftUpEmotes, HealBot_Globals.HealBot_Emotes["ShiftUp"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["ShiftUp"] == HealBot_Options_EmoteEmotion_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    elseif menuList == HEALBOT_EMOTE_CAT_HAPPY then
        for j=1, getn(HealBot_Options_EmoteHappy_List), 1 do
            info.text = HealBot_Options_EmoteHappy_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["ShiftUp"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelShiftUpEmotes, HealBot_Globals.HealBot_Emotes["ShiftUp"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["ShiftUp"] == HealBot_Options_EmoteHappy_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    elseif menuList == HEALBOT_EMOTE_CAT_GREET then
        for j=1, getn(HealBot_Options_EmoteGreet_List), 1 do
            info.text = HealBot_Options_EmoteGreet_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["ShiftUp"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelShiftUpEmotes, HealBot_Globals.HealBot_Emotes["ShiftUp"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["ShiftUp"] == HealBot_Options_EmoteGreet_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    elseif menuList == HEALBOT_EMOTE_CAT_OTHER then
        for j=1, getn(HealBot_Options_EmoteOther_List), 1 do
            info.text = HealBot_Options_EmoteOther_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["ShiftUp"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelShiftUpEmotes, HealBot_Globals.HealBot_Emotes["ShiftUp"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["ShiftUp"] == HealBot_Options_EmoteOther_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    elseif menuList == HEALBOT_EMOTE_CAT_RESPECT then
        for j=1, getn(HealBot_Options_EmoteRespect_List), 1 do
            info.text = HealBot_Options_EmoteRespect_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["ShiftUp"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelShiftUpEmotes, HealBot_Globals.HealBot_Emotes["ShiftUp"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["ShiftUp"] == HealBot_Options_EmoteRespect_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    elseif menuList == HEALBOT_EMOTE_CAT_UNHAPPY then
        for j=1, getn(HealBot_Options_EmoteUnhappy_List), 1 do
            info.text = HealBot_Options_EmoteUnhappy_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["ShiftUp"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelShiftUpEmotes, HealBot_Globals.HealBot_Emotes["ShiftUp"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["ShiftUp"] == HealBot_Options_EmoteUnhappy_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    end
end

local function HealBot_Options_MouseWheelShiftDownEmotes_Display()
    if HealBot_Globals.HealBot_MouseWheelTxt["ShiftDown"]==HEALBOT_EMOTE then
        HealBot_Options_MouseWheelShiftDownEmotes:Show()
    else
        HealBot_Options_MouseWheelShiftDownEmotes:Hide()
    end
end

function HealBot_Options_MouseWheelShiftDown_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_MouseWheel_List), 1 do
        info.text = HealBot_Options_MouseWheel_List[j];
        info.func = function(self)
                        HealBot_Globals.HealBot_MouseWheelIndex["ShiftDown"] = self:GetID()
                        HealBot_Globals.HealBot_MouseWheelTxt["ShiftDown"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelShiftDown, HealBot_Options_MouseWheel_List[HealBot_Globals.HealBot_MouseWheelIndex["ShiftDown"]])
                        HealBot_Options_MouseWheelShiftDownEmotes_Display()
                    end
        info.checked = false;
        if HealBot_Globals.HealBot_MouseWheelIndex["ShiftDown"] == j then info.checked = true; end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_MouseWheelShiftDownEmotes_DropDown(self, level, menuList)
    local info = UIDropDownMenu_CreateInfo()
    if level == 1 then
        for j=1, getn(HealBot_Options_EmoteCat_List), 1 do
            info.text = HealBot_Options_EmoteCat_List[j];
            info.hasArrow = true
            info.menuList = HealBot_Options_EmoteCat_List[j], true, HealBot_Options_EmoteCat_List[j]
            UIDropDownMenu_AddButton(info)
        end
    elseif menuList == HEALBOT_EMOTE_CAT_COMBAT then
        for j=1, getn(HealBot_Options_EmoteCombat_List), 1 do
            info.text = HealBot_Options_EmoteCombat_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["ShiftDown"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelShiftDownEmotes, HealBot_Globals.HealBot_Emotes["ShiftDown"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["ShiftDown"] == HealBot_Options_EmoteCombat_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    elseif menuList == HEALBOT_EMOTE_CAT_EMOTION then
        for j=1, getn(HealBot_Options_EmoteEmotion_List), 1 do
            info.text = HealBot_Options_EmoteEmotion_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["ShiftDown"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelShiftDownEmotes, HealBot_Globals.HealBot_Emotes["ShiftDown"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["ShiftDown"] == HealBot_Options_EmoteEmotion_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    elseif menuList == HEALBOT_EMOTE_CAT_HAPPY then
        for j=1, getn(HealBot_Options_EmoteHappy_List), 1 do
            info.text = HealBot_Options_EmoteHappy_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["ShiftDown"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelShiftDownEmotes, HealBot_Globals.HealBot_Emotes["ShiftDown"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["ShiftDown"] == HealBot_Options_EmoteHappy_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    elseif menuList == HEALBOT_EMOTE_CAT_GREET then
        for j=1, getn(HealBot_Options_EmoteGreet_List), 1 do
            info.text = HealBot_Options_EmoteGreet_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["ShiftDown"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelShiftDownEmotes, HealBot_Globals.HealBot_Emotes["ShiftDown"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["ShiftDown"] == HealBot_Options_EmoteGreet_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    elseif menuList == HEALBOT_EMOTE_CAT_OTHER then
        for j=1, getn(HealBot_Options_EmoteOther_List), 1 do
            info.text = HealBot_Options_EmoteOther_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["ShiftDown"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelShiftDownEmotes, HealBot_Globals.HealBot_Emotes["ShiftDown"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["ShiftDown"] == HealBot_Options_EmoteOther_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    elseif menuList == HEALBOT_EMOTE_CAT_RESPECT then
        for j=1, getn(HealBot_Options_EmoteRespect_List), 1 do
            info.text = HealBot_Options_EmoteRespect_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["ShiftDown"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelShiftDownEmotes, HealBot_Globals.HealBot_Emotes["ShiftDown"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["ShiftDown"] == HealBot_Options_EmoteRespect_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    elseif menuList == HEALBOT_EMOTE_CAT_UNHAPPY then
        for j=1, getn(HealBot_Options_EmoteUnhappy_List), 1 do
            info.text = HealBot_Options_EmoteUnhappy_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["ShiftDown"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelShiftDownEmotes, HealBot_Globals.HealBot_Emotes["ShiftDown"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["ShiftDown"] == HealBot_Options_EmoteUnhappy_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    end
end

local function HealBot_Options_MouseWheelCtrlUpEmotes_Display()
    if HealBot_Globals.HealBot_MouseWheelTxt["CtrlUp"]==HEALBOT_EMOTE then
        HealBot_Options_MouseWheelCtrlUpEmotes:Show()
    else
        HealBot_Options_MouseWheelCtrlUpEmotes:Hide()
    end
end

function HealBot_Options_MouseWheelCtrlUp_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_MouseWheel_List), 1 do
        info.text = HealBot_Options_MouseWheel_List[j];
        info.func = function(self)
                        HealBot_Globals.HealBot_MouseWheelIndex["CtrlUp"] = self:GetID()
                        HealBot_Globals.HealBot_MouseWheelTxt["CtrlUp"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelCtrlUp, HealBot_Options_MouseWheel_List[HealBot_Globals.HealBot_MouseWheelIndex["CtrlUp"]])
                        HealBot_Options_MouseWheelCtrlUpEmotes_Display()
                    end
        info.checked = false;
        if HealBot_Globals.HealBot_MouseWheelIndex["CtrlUp"] == j then info.checked = true; end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_MouseWheelCtrlUpEmotes_DropDown(self, level, menuList)
    local info = UIDropDownMenu_CreateInfo()
    if level == 1 then
        for j=1, getn(HealBot_Options_EmoteCat_List), 1 do
            info.text = HealBot_Options_EmoteCat_List[j];
            info.hasArrow = true
            info.menuList = HealBot_Options_EmoteCat_List[j], true, HealBot_Options_EmoteCat_List[j]
            UIDropDownMenu_AddButton(info)
        end
    elseif menuList == HEALBOT_EMOTE_CAT_COMBAT then
        for j=1, getn(HealBot_Options_EmoteCombat_List), 1 do
            info.text = HealBot_Options_EmoteCombat_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["CtrlUp"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelCtrlUpEmotes, HealBot_Globals.HealBot_Emotes["CtrlUp"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["CtrlUp"] == HealBot_Options_EmoteCombat_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    elseif menuList == HEALBOT_EMOTE_CAT_EMOTION then
        for j=1, getn(HealBot_Options_EmoteEmotion_List), 1 do
            info.text = HealBot_Options_EmoteEmotion_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["CtrlUp"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelCtrlUpEmotes, HealBot_Globals.HealBot_Emotes["CtrlUp"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["CtrlUp"] == HealBot_Options_EmoteEmotion_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    elseif menuList == HEALBOT_EMOTE_CAT_HAPPY then
        for j=1, getn(HealBot_Options_EmoteHappy_List), 1 do
            info.text = HealBot_Options_EmoteHappy_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["CtrlUp"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelCtrlUpEmotes, HealBot_Globals.HealBot_Emotes["CtrlUp"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["CtrlUp"] == HealBot_Options_EmoteHappy_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    elseif menuList == HEALBOT_EMOTE_CAT_GREET then
        for j=1, getn(HealBot_Options_EmoteGreet_List), 1 do
            info.text = HealBot_Options_EmoteGreet_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["CtrlUp"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelCtrlUpEmotes, HealBot_Globals.HealBot_Emotes["CtrlUp"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["CtrlUp"] == HealBot_Options_EmoteGreet_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    elseif menuList == HEALBOT_EMOTE_CAT_OTHER then
        for j=1, getn(HealBot_Options_EmoteOther_List), 1 do
            info.text = HealBot_Options_EmoteOther_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["CtrlUp"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelCtrlUpEmotes, HealBot_Globals.HealBot_Emotes["CtrlUp"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["CtrlUp"] == HealBot_Options_EmoteOther_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    elseif menuList == HEALBOT_EMOTE_CAT_RESPECT then
        for j=1, getn(HealBot_Options_EmoteRespect_List), 1 do
            info.text = HealBot_Options_EmoteRespect_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["CtrlUp"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelCtrlUpEmotes, HealBot_Globals.HealBot_Emotes["CtrlUp"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["CtrlUp"] == HealBot_Options_EmoteRespect_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    elseif menuList == HEALBOT_EMOTE_CAT_UNHAPPY then
        for j=1, getn(HealBot_Options_EmoteUnhappy_List), 1 do
            info.text = HealBot_Options_EmoteUnhappy_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["CtrlUp"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelCtrlUpEmotes, HealBot_Globals.HealBot_Emotes["CtrlUp"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["CtrlUp"] == HealBot_Options_EmoteUnhappy_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    end
end

local function HealBot_Options_MouseWheelCtrlDownEmotes_Display()
    if HealBot_Globals.HealBot_MouseWheelTxt["CtrlDown"]==HEALBOT_EMOTE then
        HealBot_Options_MouseWheelCtrlDownEmotes:Show()
    else
        HealBot_Options_MouseWheelCtrlDownEmotes:Hide()
    end
end

function HealBot_Options_MouseWheelCtrlDown_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_MouseWheel_List), 1 do
        info.text = HealBot_Options_MouseWheel_List[j];
        info.func = function(self)
                        HealBot_Globals.HealBot_MouseWheelIndex["CtrlDown"] = self:GetID()
                        HealBot_Globals.HealBot_MouseWheelTxt["CtrlDown"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelCtrlDown, HealBot_Options_MouseWheel_List[HealBot_Globals.HealBot_MouseWheelIndex["CtrlDown"]])
                        HealBot_Options_MouseWheelCtrlDownEmotes_Display()
                    end
        info.checked = false;
        if HealBot_Globals.HealBot_MouseWheelIndex["CtrlDown"] == j then info.checked = true; end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_MouseWheelCtrlDownEmotes_DropDown(self, level, menuList)
    local info = UIDropDownMenu_CreateInfo()
    if level == 1 then
        for j=1, getn(HealBot_Options_EmoteCat_List), 1 do
            info.text = HealBot_Options_EmoteCat_List[j];
            info.hasArrow = true
            info.menuList = HealBot_Options_EmoteCat_List[j], true, HealBot_Options_EmoteCat_List[j]
            UIDropDownMenu_AddButton(info)
        end
    elseif menuList == HEALBOT_EMOTE_CAT_COMBAT then
        for j=1, getn(HealBot_Options_EmoteCombat_List), 1 do
            info.text = HealBot_Options_EmoteCombat_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["CtrlDown"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelCtrlDownEmotes, HealBot_Globals.HealBot_Emotes["CtrlDown"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["CtrlDown"] == HealBot_Options_EmoteCombat_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    elseif menuList == HEALBOT_EMOTE_CAT_EMOTION then
        for j=1, getn(HealBot_Options_EmoteEmotion_List), 1 do
            info.text = HealBot_Options_EmoteEmotion_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["CtrlDown"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelCtrlDownEmotes, HealBot_Globals.HealBot_Emotes["CtrlDown"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["CtrlDown"] == HealBot_Options_EmoteEmotion_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    elseif menuList == HEALBOT_EMOTE_CAT_HAPPY then
        for j=1, getn(HealBot_Options_EmoteHappy_List), 1 do
            info.text = HealBot_Options_EmoteHappy_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["CtrlDown"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelCtrlDownEmotes, HealBot_Globals.HealBot_Emotes["CtrlDown"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["CtrlDown"] == HealBot_Options_EmoteHappy_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    elseif menuList == HEALBOT_EMOTE_CAT_GREET then
        for j=1, getn(HealBot_Options_EmoteGreet_List), 1 do
            info.text = HealBot_Options_EmoteGreet_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["CtrlDown"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelCtrlDownEmotes, HealBot_Globals.HealBot_Emotes["CtrlDown"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["CtrlDown"] == HealBot_Options_EmoteGreet_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    elseif menuList == HEALBOT_EMOTE_CAT_OTHER then
        for j=1, getn(HealBot_Options_EmoteOther_List), 1 do
            info.text = HealBot_Options_EmoteOther_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["CtrlDown"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelCtrlDownEmotes, HealBot_Globals.HealBot_Emotes["CtrlDown"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["CtrlDown"] == HealBot_Options_EmoteOther_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    elseif menuList == HEALBOT_EMOTE_CAT_RESPECT then
        for j=1, getn(HealBot_Options_EmoteRespect_List), 1 do
            info.text = HealBot_Options_EmoteRespect_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["CtrlDown"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelCtrlDownEmotes, HealBot_Globals.HealBot_Emotes["CtrlDown"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["CtrlDown"] == HealBot_Options_EmoteRespect_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    elseif menuList == HEALBOT_EMOTE_CAT_UNHAPPY then
        for j=1, getn(HealBot_Options_EmoteUnhappy_List), 1 do
            info.text = HealBot_Options_EmoteUnhappy_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["CtrlDown"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelCtrlDownEmotes, HealBot_Globals.HealBot_Emotes["CtrlDown"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["CtrlDown"] == HealBot_Options_EmoteUnhappy_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    end
end

local function HealBot_Options_MouseWheelAltUpEmotes_Display()
    if HealBot_Globals.HealBot_MouseWheelTxt["AltUp"]==HEALBOT_EMOTE then
        HealBot_Options_MouseWheelAltUpEmotes:Show()
    else
        HealBot_Options_MouseWheelAltUpEmotes:Hide()
    end
end

function HealBot_Options_MouseWheelAltUp_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_MouseWheel_List), 1 do
        info.text = HealBot_Options_MouseWheel_List[j];
        info.func = function(self)
                        HealBot_Globals.HealBot_MouseWheelIndex["AltUp"] = self:GetID()
                        HealBot_Globals.HealBot_MouseWheelTxt["AltUp"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelAltUp, HealBot_Options_MouseWheel_List[HealBot_Globals.HealBot_MouseWheelIndex["AltUp"]])
                        HealBot_Options_MouseWheelAltUpEmotes_Display()
                    end
        info.checked = false;
        if HealBot_Globals.HealBot_MouseWheelIndex["AltUp"] == j then info.checked = true; end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_MouseWheelAltUpEmotes_DropDown(self, level, menuList)
    local info = UIDropDownMenu_CreateInfo()
    if level == 1 then
        for j=1, getn(HealBot_Options_EmoteCat_List), 1 do
            info.text = HealBot_Options_EmoteCat_List[j];
            info.hasArrow = true
            info.menuList = HealBot_Options_EmoteCat_List[j], true, HealBot_Options_EmoteCat_List[j]
            UIDropDownMenu_AddButton(info)
        end
    elseif menuList == HEALBOT_EMOTE_CAT_COMBAT then
        for j=1, getn(HealBot_Options_EmoteCombat_List), 1 do
            info.text = HealBot_Options_EmoteCombat_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["AltUp"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelAltUpEmotes, HealBot_Globals.HealBot_Emotes["AltUp"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["AltUp"] == HealBot_Options_EmoteCombat_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    elseif menuList == HEALBOT_EMOTE_CAT_EMOTION then
        for j=1, getn(HealBot_Options_EmoteEmotion_List), 1 do
            info.text = HealBot_Options_EmoteEmotion_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["AltUp"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelAltUpEmotes, HealBot_Globals.HealBot_Emotes["AltUp"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["AltUp"] == HealBot_Options_EmoteEmotion_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    elseif menuList == HEALBOT_EMOTE_CAT_HAPPY then
        for j=1, getn(HealBot_Options_EmoteHappy_List), 1 do
            info.text = HealBot_Options_EmoteHappy_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["AltUp"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelAltUpEmotes, HealBot_Globals.HealBot_Emotes["AltUp"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["AltUp"] == HealBot_Options_EmoteHappy_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    elseif menuList == HEALBOT_EMOTE_CAT_GREET then
        for j=1, getn(HealBot_Options_EmoteGreet_List), 1 do
            info.text = HealBot_Options_EmoteGreet_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["AltUp"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelAltUpEmotes, HealBot_Globals.HealBot_Emotes["AltUp"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["AltUp"] == HealBot_Options_EmoteGreet_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    elseif menuList == HEALBOT_EMOTE_CAT_OTHER then
        for j=1, getn(HealBot_Options_EmoteOther_List), 1 do
            info.text = HealBot_Options_EmoteOther_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["AltUp"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelAltUpEmotes, HealBot_Globals.HealBot_Emotes["AltUp"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["AltUp"] == HealBot_Options_EmoteOther_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    elseif menuList == HEALBOT_EMOTE_CAT_RESPECT then
        for j=1, getn(HealBot_Options_EmoteRespect_List), 1 do
            info.text = HealBot_Options_EmoteRespect_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["AltUp"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelAltUpEmotes, HealBot_Globals.HealBot_Emotes["AltUp"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["AltUp"] == HealBot_Options_EmoteRespect_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    elseif menuList == HEALBOT_EMOTE_CAT_UNHAPPY then
        for j=1, getn(HealBot_Options_EmoteUnhappy_List), 1 do
            info.text = HealBot_Options_EmoteUnhappy_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["AltUp"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelAltUpEmotes, HealBot_Globals.HealBot_Emotes["AltUp"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["AltUp"] == HealBot_Options_EmoteUnhappy_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    end
end

local function HealBot_Options_MouseWheelAltDownEmotes_Display()
    if HealBot_Globals.HealBot_MouseWheelTxt["AltDown"]==HEALBOT_EMOTE then
        HealBot_Options_MouseWheelAltDownEmotes:Show()
    else
        HealBot_Options_MouseWheelAltDownEmotes:Hide()
    end
end

function HealBot_Options_MouseWheelAltDown_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_MouseWheel_List), 1 do
        info.text = HealBot_Options_MouseWheel_List[j];
        info.func = function(self)
                        HealBot_Globals.HealBot_MouseWheelIndex["AltDown"] = self:GetID()
                        HealBot_Globals.HealBot_MouseWheelTxt["AltDown"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelAltDown, HealBot_Options_MouseWheel_List[HealBot_Globals.HealBot_MouseWheelIndex["AltDown"]])
                        HealBot_Options_MouseWheelAltDownEmotes_Display()
                    end
        info.checked = false;
        if HealBot_Globals.HealBot_MouseWheelIndex["AltDown"] == j then info.checked = true; end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_MouseWheelAltDownEmotes_DropDown(self, level, menuList)
    local info = UIDropDownMenu_CreateInfo()
    if level == 1 then
        for j=1, getn(HealBot_Options_EmoteCat_List), 1 do
            info.text = HealBot_Options_EmoteCat_List[j];
            info.hasArrow = true
            info.menuList = HealBot_Options_EmoteCat_List[j], true, HealBot_Options_EmoteCat_List[j]
            UIDropDownMenu_AddButton(info)
        end
    elseif menuList == HEALBOT_EMOTE_CAT_COMBAT then
        for j=1, getn(HealBot_Options_EmoteCombat_List), 1 do
            info.text = HealBot_Options_EmoteCombat_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["AltDown"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelAltDownEmotes, HealBot_Globals.HealBot_Emotes["AltDown"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["AltDown"] == HealBot_Options_EmoteCombat_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    elseif menuList == HEALBOT_EMOTE_CAT_EMOTION then
        for j=1, getn(HealBot_Options_EmoteEmotion_List), 1 do
            info.text = HealBot_Options_EmoteEmotion_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["AltDown"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelAltDownEmotes, HealBot_Globals.HealBot_Emotes["AltDown"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["AltDown"] == HealBot_Options_EmoteEmotion_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    elseif menuList == HEALBOT_EMOTE_CAT_HAPPY then
        for j=1, getn(HealBot_Options_EmoteHappy_List), 1 do
            info.text = HealBot_Options_EmoteHappy_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["AltDown"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelAltDownEmotes, HealBot_Globals.HealBot_Emotes["AltDown"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["AltDown"] == HealBot_Options_EmoteHappy_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    elseif menuList == HEALBOT_EMOTE_CAT_GREET then
        for j=1, getn(HealBot_Options_EmoteGreet_List), 1 do
            info.text = HealBot_Options_EmoteGreet_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["AltDown"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelAltDownEmotes, HealBot_Globals.HealBot_Emotes["AltDown"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["AltDown"] == HealBot_Options_EmoteGreet_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    elseif menuList == HEALBOT_EMOTE_CAT_OTHER then
        for j=1, getn(HealBot_Options_EmoteOther_List), 1 do
            info.text = HealBot_Options_EmoteOther_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["AltDown"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelAltDownEmotes, HealBot_Globals.HealBot_Emotes["AltDown"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["AltDown"] == HealBot_Options_EmoteOther_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    elseif menuList == HEALBOT_EMOTE_CAT_RESPECT then
        for j=1, getn(HealBot_Options_EmoteRespect_List), 1 do
            info.text = HealBot_Options_EmoteRespect_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["AltDown"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelAltDownEmotes, HealBot_Globals.HealBot_Emotes["AltDown"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["AltDown"] == HealBot_Options_EmoteRespect_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    elseif menuList == HEALBOT_EMOTE_CAT_UNHAPPY then
        for j=1, getn(HealBot_Options_EmoteUnhappy_List), 1 do
            info.text = HealBot_Options_EmoteUnhappy_List[j];
            info.func = function(self)
                        HealBot_Globals.HealBot_Emotes["AltDown"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelAltDownEmotes, HealBot_Globals.HealBot_Emotes["AltDown"])
                    end
            info.checked = false;
            if HealBot_Globals.HealBot_Emotes["AltDown"] == HealBot_Options_EmoteUnhappy_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info, level);
        end
    end
end
--------------------------------------------------------------------------------

HealBot_Options_StorePrev["hbLangs"] = 3

function HealBot_Options_hbLangs_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_hbLangs_List), 1 do
        info.text = HealBot_Options_hbLangs_List[j];
        info.func = function(self)
                        HealBot_Options_StorePrev["hbLangs"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_hbLangs, HealBot_Options_hbLangs_List[HealBot_Options_StorePrev["hbLangs"]])
                    end
        info.checked = false;
        if HealBot_Options_StorePrev["hbLangs"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_LangsButton_OnClick(self)
    if HealBot_Options_StorePrev["hbLangs"]==1 then
        HealBot_Options_Lang("zhCN")
    elseif HealBot_Options_StorePrev["hbLangs"]==2 then
        HealBot_Options_Lang("enUK")
    elseif HealBot_Options_StorePrev["hbLangs"]==3 then
        HealBot_Options_Lang("enUS")
    elseif HealBot_Options_StorePrev["hbLangs"]==4 then
        HealBot_Options_Lang("frFR")
    elseif HealBot_Options_StorePrev["hbLangs"]==5 then
        HealBot_Options_Lang("deDE")
    elseif HealBot_Options_StorePrev["hbLangs"]==6 then
        HealBot_Options_Lang("grGR")
    elseif HealBot_Options_StorePrev["hbLangs"]==7 then
        HealBot_Options_Lang("huHU")
    elseif HealBot_Options_StorePrev["hbLangs"]==8 then
        HealBot_Options_Lang("itIT")
    elseif HealBot_Options_StorePrev["hbLangs"]==9 then
        HealBot_Options_Lang("koKR")
    elseif HealBot_Options_StorePrev["hbLangs"]==10 then
        HealBot_Options_Lang("ptBR")
    elseif HealBot_Options_StorePrev["hbLangs"]==11 then
        HealBot_Options_Lang("ruRU")
    elseif HealBot_Options_StorePrev["hbLangs"]==12 then
        HealBot_Options_Lang("esES")
    elseif HealBot_Options_StorePrev["hbLangs"]==13 then
        HealBot_Options_Lang("zhTW")
	elseif HealBot_Options_StorePrev["hbLangs"]==14 then
        HealBot_Options_Lang("esMX")
    end
end

--------------------------------------------------------------------------------

HealBot_Options_StorePrev["hbCommands"] = 1

function HealBot_Options_hbCommands_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_hbCommands_List), 1 do
        info.text = HealBot_Options_hbCommands_List[j];
        info.func = function(self)
                        HealBot_Options_StorePrev["hbCommands"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_hbCommands, HealBot_Options_hbCommands_List[HealBot_Options_StorePrev["hbCommands"]])
                    end
        info.checked = false;
        if HealBot_Options_StorePrev["hbCommands"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_CommandsButton_OnClick(self)
    if HealBot_Options_StorePrev["hbCommands"]==2 then
        HealBot_Panel_ClearBlackList()
    elseif HealBot_Options_StorePrev["hbCommands"]==3 then
        HealBot_Copy_SpellCombos()
    elseif HealBot_Options_StorePrev["hbCommands"]==4 then
        HealBot_Reset_Icons()
    elseif HealBot_Options_StorePrev["hbCommands"]==5 then
        HealBot_Action_Reset()
    elseif HealBot_Options_StorePrev["hbCommands"]==6 then
        HealBot_Reset_Buffs()
    elseif HealBot_Options_StorePrev["hbCommands"]==7 then
        HealBot_Reset_Cures()
    elseif HealBot_Options_StorePrev["hbCommands"]==8 then
        HealBot_setResetFlagCode(2)
    elseif HealBot_Options_StorePrev["hbCommands"]==9 then
        HealBot_setResetFlagCode(3)
    elseif HealBot_Options_StorePrev["hbCommands"]==10 then
        HealBot_Reset_Spells()
    elseif HealBot_Options_StorePrev["hbCommands"]==11 then
        HealBot_MountsPets_DislikeMount("Dislike")
    elseif HealBot_Options_StorePrev["hbCommands"]==12 then
        HealBot_MountsPets_DislikeMount("Exclude")
    elseif HealBot_Options_StorePrev["hbCommands"]==13 then
        HealBot_ToggleSuppressSetting("error")
    elseif HealBot_Options_StorePrev["hbCommands"]==14 then
        HealBot_ToggleSuppressSetting("sound")
    elseif HealBot_Options_StorePrev["hbCommands"]==15 then
        HealBot_Options_ToggleCustomCuresCastBy()
    end
end

--------------------------------------------------------------------------------


HealBot_Options_StorePrev["hbProfile"] = 1

function HealBot_Options_hbProfile_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_hbProfile_List), 1 do
        info.text = HealBot_Options_hbProfile_List[j];
        info.func = function(self)
                        HealBot_Config.Profile = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_hbProfile, HealBot_Options_hbProfile_List[HealBot_Config.Profile])
                    end
        info.checked = false;
        if HealBot_Config.Profile==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_hbProfile_OnClick(self)
    if HealBot_Config.Profile==2 then
        HealBot_Options_hbProfile_setClass()
    end
end

function HealBot_Options_hbProfile_setClass()
    if not HealBot_Data["PCLASSTRIM"] then return end
    if HealBot_Class_Spells[HealBot_Data["PCLASSTRIM"]] then
        HealBot_Config_Spells=HealBot_Options_copyTable(HealBot_Class_Spells[HealBot_Data["PCLASSTRIM"]])
        table.foreach(HealBot_Config_SpellsDefaults, function (key,val)
            if HealBot_Config_Spells[key]==nil then
                HealBot_Config_Spells[key] = val;
            end
        end);
        HealBot_Options_ResetDoInittab(2)
    else
        HealBot_Options_hbProfile_saveClass("SPELLS")
    end
    if HealBot_Class_Buffs[HealBot_Data["PCLASSTRIM"]] then
        HealBot_Config_Buffs=HealBot_Options_copyTable(HealBot_Class_Buffs[HealBot_Data["PCLASSTRIM"]])
        table.foreach(HealBot_Config_BuffsDefaults, function (key,val)
            if HealBot_Config_Buffs[key]==nil then
                HealBot_Config_Buffs[key] = val;
            end
        end);        
        HealBot_Options_ResetDoInittab(5)
    else
        HealBot_Options_hbProfile_saveClass("BUFFS")
    end
    if HealBot_Class_Cures[HealBot_Data["PCLASSTRIM"]] then
        HealBot_Config_Cures=HealBot_Options_copyTable(HealBot_Class_Cures[HealBot_Data["PCLASSTRIM"]])
        table.foreach(HealBot_Config_CuresDefaults, function (key,val)
            if HealBot_Config_Cures[key]==nil then
                HealBot_Config_Cures[key] = val;
            end
        end);
        HealBot_Options_ResetDoInittab(4)
    else
        HealBot_Options_hbProfile_saveClass("CURES")
    end
end

function HealBot_Options_hbProfile_saveClass(cType)
    if not HealBot_Data["PCLASSTRIM"] then return end
    local sType=cType or "ALL"
    if sType=="SPELLS" or sType=="ALL" then HealBot_Class_Spells[HealBot_Data["PCLASSTRIM"]]=HealBot_Options_copyTable(HealBot_Config_Spells) end
    if sType=="BUFFS" or sType=="ALL" then HealBot_Class_Buffs[HealBot_Data["PCLASSTRIM"]]=HealBot_Options_copyTable(HealBot_Config_Buffs) end
    if sType=="CURES" or sType=="ALL" then HealBot_Class_Cures[HealBot_Data["PCLASSTRIM"]]=HealBot_Options_copyTable(HealBot_Config_Cures) end
end

--------------------------------------------------------------------------------

HealBot_Options_StorePrev["hbFAQ"]=1
function HealBot_Options_FAQ_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, #HEALBOT_ABOUT_FAQ_QUESTIONS, 1 do
        info.text = HEALBOT_ABOUT_FAQ_QUESTIONS[j];
        info.func = function(self)
                        HealBot_Options_StorePrev["hbFAQ"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_FAQ, HEALBOT_ABOUT_FAQ_QUESTIONS[HealBot_Options_StorePrev["hbFAQ"]])
                        local g=_G["HealBot_Options_FAQAnswerTextD"] 
                        g:SetText(HEALBOT_ABOUT_FAQ_ANSWERS[HealBot_Options_StorePrev["hbFAQ"]])
                    end
        info.checked = false;
        if HealBot_Options_StorePrev["hbFAQ"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

--------------------------------------------------------------------------------

function HealBot_Options_EmergencyFClass_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_EmergencyFClass_List), 1 do
        info.text = HealBot_Options_EmergencyFClass_List[j];
        info.func = function(self)
                        HealBot_Globals.EmergencyFClass = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_EmergencyFClass, HealBot_Options_EmergencyFClass_List[HealBot_Globals.EmergencyFClass])
                        HealBot_Options_EFClass_Reset()
                    end
        info.checked = false;
        if HealBot_Globals.EmergencyFClass==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_EFClass_Reset()
    if HealBot_Globals.EmergencyFClass==1 then
        HealBot_Options_EFClassDruid:SetChecked(HealBot_Globals.EmergIncMelee[HEALBOT_DRUID]);
        HealBot_Options_EFClassHunter:SetChecked(HealBot_Globals.EmergIncMelee[HEALBOT_HUNTER]);
        HealBot_Options_EFClassMage:SetChecked(HealBot_Globals.EmergIncMelee[HEALBOT_MAGE]);
        HealBot_Options_EFClassPaladin:SetChecked(HealBot_Globals.EmergIncMelee[HEALBOT_PALADIN]);
        HealBot_Options_EFClassPriest:SetChecked(HealBot_Globals.EmergIncMelee[HEALBOT_PRIEST]);
        HealBot_Options_EFClassRogue:SetChecked(HealBot_Globals.EmergIncMelee[HEALBOT_ROGUE]);
        HealBot_Options_EFClassShaman:SetChecked(HealBot_Globals.EmergIncMelee[HEALBOT_SHAMAN]);
        HealBot_Options_EFClassWarlock:SetChecked(HealBot_Globals.EmergIncMelee[HEALBOT_WARLOCK]);
        HealBot_Options_EFClassWarrior:SetChecked(HealBot_Globals.EmergIncMelee[HEALBOT_WARRIOR]);
        HealBot_Options_EFClassDemonHunter:SetChecked(HealBot_Globals.EmergIncMelee[HEALBOT_DEMONHUNTER]);
        HealBot_Options_EFClassDeathKnight:SetChecked(HealBot_Globals.EmergIncMelee[HEALBOT_DEATHKNIGHT]);
        HealBot_Options_EFClassMonk:SetChecked(HealBot_Globals.EmergIncMelee[HEALBOT_MONK]);
    elseif HealBot_Globals.EmergencyFClass==2 then
        HealBot_Options_EFClassDruid:SetChecked(HealBot_Globals.EmergIncRange[HEALBOT_DRUID]);
        HealBot_Options_EFClassHunter:SetChecked(HealBot_Globals.EmergIncRange[HEALBOT_HUNTER]);
        HealBot_Options_EFClassMage:SetChecked(HealBot_Globals.EmergIncRange[HEALBOT_MAGE]);
        HealBot_Options_EFClassPaladin:SetChecked(HealBot_Globals.EmergIncRange[HEALBOT_PALADIN]);
        HealBot_Options_EFClassPriest:SetChecked(HealBot_Globals.EmergIncRange[HEALBOT_PRIEST]);
        HealBot_Options_EFClassRogue:SetChecked(HealBot_Globals.EmergIncRange[HEALBOT_ROGUE]);
        HealBot_Options_EFClassShaman:SetChecked(HealBot_Globals.EmergIncRange[HEALBOT_SHAMAN]);
        HealBot_Options_EFClassWarlock:SetChecked(HealBot_Globals.EmergIncRange[HEALBOT_WARLOCK]);
        HealBot_Options_EFClassWarrior:SetChecked(HealBot_Globals.EmergIncRange[HEALBOT_WARRIOR]);
        HealBot_Options_EFClassDemonHunter:SetChecked(HealBot_Globals.EmergIncRange[HEALBOT_DEMONHUNTER]);
        HealBot_Options_EFClassDeathKnight:SetChecked(HealBot_Globals.EmergIncRange[HEALBOT_DEATHKNIGHT]);
        HealBot_Options_EFClassMonk:SetChecked(HealBot_Globals.EmergIncRange[HEALBOT_MONK]);
    elseif HealBot_Globals.EmergencyFClass==3 then
        HealBot_Options_EFClassDruid:SetChecked(HealBot_Globals.EmergIncHealers[HEALBOT_DRUID]);
        HealBot_Options_EFClassHunter:SetChecked(HealBot_Globals.EmergIncHealers[HEALBOT_HUNTER]);
        HealBot_Options_EFClassMage:SetChecked(HealBot_Globals.EmergIncHealers[HEALBOT_MAGE]);
        HealBot_Options_EFClassPaladin:SetChecked(HealBot_Globals.EmergIncHealers[HEALBOT_PALADIN]);
        HealBot_Options_EFClassPriest:SetChecked(HealBot_Globals.EmergIncHealers[HEALBOT_PRIEST]);
        HealBot_Options_EFClassRogue:SetChecked(HealBot_Globals.EmergIncHealers[HEALBOT_ROGUE]);
        HealBot_Options_EFClassShaman:SetChecked(HealBot_Globals.EmergIncHealers[HEALBOT_SHAMAN]);
        HealBot_Options_EFClassWarlock:SetChecked(HealBot_Globals.EmergIncHealers[HEALBOT_WARLOCK]);
        HealBot_Options_EFClassWarrior:SetChecked(HealBot_Globals.EmergIncHealers[HEALBOT_WARRIOR]);
        HealBot_Options_EFClassDemonHunter:SetChecked(HealBot_Globals.EmergIncHealers[HEALBOT_DEMONHUNTER]);
        HealBot_Options_EFClassDeathKnight:SetChecked(HealBot_Globals.EmergIncHealers[HEALBOT_DEATHKNIGHT]);
        HealBot_Options_EFClassMonk:SetChecked(HealBot_Globals.EmergIncHealers[HEALBOT_MONK]);
    elseif HealBot_Globals.EmergencyFClass==4 then
        HealBot_Options_EFClassDruid:SetChecked(HealBot_Globals.EmergIncCustom[HEALBOT_DRUID]);
        HealBot_Options_EFClassHunter:SetChecked(HealBot_Globals.EmergIncCustom[HEALBOT_HUNTER]);
        HealBot_Options_EFClassMage:SetChecked(HealBot_Globals.EmergIncCustom[HEALBOT_MAGE]);
        HealBot_Options_EFClassPaladin:SetChecked(HealBot_Globals.EmergIncCustom[HEALBOT_PALADIN]);
        HealBot_Options_EFClassPriest:SetChecked(HealBot_Globals.EmergIncCustom[HEALBOT_PRIEST]);
        HealBot_Options_EFClassRogue:SetChecked(HealBot_Globals.EmergIncCustom[HEALBOT_ROGUE]);
        HealBot_Options_EFClassShaman:SetChecked(HealBot_Globals.EmergIncCustom[HEALBOT_SHAMAN]);
        HealBot_Options_EFClassWarlock:SetChecked(HealBot_Globals.EmergIncCustom[HEALBOT_WARLOCK]);
        HealBot_Options_EFClassWarrior:SetChecked(HealBot_Globals.EmergIncCustom[HEALBOT_WARRIOR]);
        HealBot_Options_EFClassDemonHunter:SetChecked(HealBot_Globals.EmergIncCustom[HEALBOT_DEMONHUNTER]);
        HealBot_Options_EFClassDeathKnight:SetChecked(HealBot_Globals.EmergIncCustom[HEALBOT_DEATHKNIGHT]);
        HealBot_Options_EFClassMonk:SetChecked(HealBot_Globals.EmergIncCustom[HEALBOT_MONK]);
    end
    HealBot_Options_framesChanged(1)
end

--------------------------------------------------------------------------------

function HealBot_Options_ExtraSort_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_Sort_List), 1 do
        info.text = HealBot_Options_Sort_List[j];
        info.func = function(self)
                        Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["RAIDORDER"] = self:GetID();
                        UIDropDownMenu_SetText(HealBot_Options_ExtraSort,HealBot_Options_Sort_List[Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["RAIDORDER"]]) 
                        HealBot_Options_framesChanged(0)
                    end
        info.checked = false;
        if Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["RAIDORDER"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_ExtraSubSort_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_Sort_List), 1 do
        info.text = HealBot_Options_Sort_List[j];
        info.func = function(self)
                        Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SUBORDER"] = self:GetID();
                        UIDropDownMenu_SetText(HealBot_Options_ExtraSubSort,HealBot_Options_Sort_List[Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SUBORDER"]]) 
                        HealBot_Options_framesChanged(0)
                    end
        info.checked = false;
        if Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SUBORDER"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

--------------------------------------------------------------------------------

HealBot_Options_StorePrev["ActionBarsCombo"] = 1

function HealBot_Options_ActionBarsCombo_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_ActionBarsCombo_List), 1 do
        info.text = HealBot_Options_ActionBarsCombo_List[j];
        info.func = function(self)
                        HealBot_Options_StorePrev["ActionBarsCombo"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_ActionBarsCombo,HealBot_Options_ActionBarsCombo_List[HealBot_Options_StorePrev["ActionBarsCombo"]]) 
                        HealBot_Options_ComboClass_Text();
                    end
        info.checked = false;
        if HealBot_Options_StorePrev["ActionBarsCombo"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

local HealBot_Options_SCAC = { [1] = HEALBOT_WOWMENU,
                               [2] = HEALBOT_TOGGLE_ENABLED,
                               [3] = HEALBOT_HBMENU
                             }
function HealBot_Options_ComboClass_Text()
    local combo=nil
    local button = HealBot_Options_ComboClass_Button(HealBot_Options_ComboButtons_Button)
    if HealBot_Options_StorePrev["ActionBarsCombo"]==1 then
        combo="ENABLED"
    elseif HealBot_Options_StorePrev["ActionBarsCombo"]==2 then
        combo="DISABLED"
    else
        combo="ENEMY"
    end       
    HealBot_Options_Click:SetText(HealBot_Action_GetSpell(combo, button..HealBot_Config.CurrentSpec) or "")
    HealBot_Options_Shift:SetText(HealBot_Action_GetSpell(combo, "Shift"..button..HealBot_Config.CurrentSpec) or "")
    HealBot_Options_Ctrl:SetText(HealBot_Action_GetSpell(combo, "Ctrl"..button..HealBot_Config.CurrentSpec) or "")
    HealBot_Options_Alt:SetText(HealBot_Action_GetSpell(combo, "Alt"..button..HealBot_Config.CurrentSpec) or "")
    HealBot_Options_AltShift:SetText(HealBot_Action_GetSpell(combo, "Alt-Shift"..button..HealBot_Config.CurrentSpec) or "")
    HealBot_Options_CtrlShift:SetText(HealBot_Action_GetSpell(combo, "Ctrl-Shift"..button..HealBot_Config.CurrentSpec) or "")
    HealBot_Options_CtrlAlt:SetText(HealBot_Action_GetSpell(combo, "Alt-Ctrl"..button..HealBot_Config.CurrentSpec) or "")

    if HealBot_Options_StorePrev["ActionBarsCombo"]==1 then
        combo = HealBot_Config_Spells.EnabledSpellTarget;
    elseif HealBot_Options_StorePrev["ActionBarsCombo"]==2 then
        combo = HealBot_Config_Spells.DisabledSpellTarget;
    else
        combo = HealBot_Config_Spells.EnemySpellTarget;
    end
    if combo then
        HealBot_SpellAutoTarget:SetChecked(combo[button..HealBot_Config.CurrentSpec] or false)
        HealBot_ShiftSpellAutoTarget:SetChecked(combo["Shift"..button..HealBot_Config.CurrentSpec] or false)
        HealBot_CtrlSpellAutoTarget:SetChecked(combo["Ctrl"..button..HealBot_Config.CurrentSpec] or false)
        HealBot_AltSpellAutoTarget:SetChecked(combo["Alt"..button..HealBot_Config.CurrentSpec] or false)
        HealBot_AltShiftSpellAutoTarget:SetChecked(combo["Alt-Shift"..button..HealBot_Config.CurrentSpec] or false)
        HealBot_CtrlShiftSpellAutoTarget:SetChecked(combo["Ctrl-Shift"..button..HealBot_Config.CurrentSpec] or false)
        HealBot_CtrlAltSpellAutoTarget:SetChecked(combo["Alt-Ctrl"..button..HealBot_Config.CurrentSpec] or false)
    end
    if HealBot_Options_StorePrev["ActionBarsCombo"]==1 then
        combo = HealBot_Config_Spells.EnabledSpellTrinket1;
    elseif HealBot_Options_StorePrev["ActionBarsCombo"]==2 then
        combo = HealBot_Config_Spells.DisabledSpellTrinket1;
    else
        combo = HealBot_Config_Spells.EnemySpellTrinket1;
    end
    if combo then
        HealBot_SpellAutoTrinket1:SetChecked(combo[button..HealBot_Config.CurrentSpec] or false)
        HealBot_ShiftSpellAutoTrinket1:SetChecked(combo["Shift"..button..HealBot_Config.CurrentSpec] or false)
        HealBot_CtrlSpellAutoTrinket1:SetChecked(combo["Ctrl"..button..HealBot_Config.CurrentSpec] or false)
        HealBot_AltSpellAutoTrinket1:SetChecked(combo["Alt"..button..HealBot_Config.CurrentSpec] or false)
        HealBot_AltShiftSpellAutoTrinket1:SetChecked(combo["Alt-Shift"..button..HealBot_Config.CurrentSpec] or false)
        HealBot_CtrlShiftSpellAutoTrinket1:SetChecked(combo["Ctrl-Shift"..button..HealBot_Config.CurrentSpec] or false)
        HealBot_CtrlAltSpellAutoTrinket1:SetChecked(combo["Alt-Ctrl"..button..HealBot_Config.CurrentSpec] or false)
    end
    if HealBot_Options_StorePrev["ActionBarsCombo"]==1 then
        combo = HealBot_Config_Spells.EnabledSpellTrinket2;
    elseif HealBot_Options_StorePrev["ActionBarsCombo"]==2 then
        combo = HealBot_Config_Spells.DisabledSpellTrinket2;
    else
        combo = HealBot_Config_Spells.EnemySpellTrinket2;
    end
    if combo then
        HealBot_SpellAutoTrinket2:SetChecked(combo[button..HealBot_Config.CurrentSpec] or false)
        HealBot_ShiftSpellAutoTrinket2:SetChecked(combo["Shift"..button..HealBot_Config.CurrentSpec] or false)
        HealBot_CtrlSpellAutoTrinket2:SetChecked(combo["Ctrl"..button..HealBot_Config.CurrentSpec] or false)
        HealBot_AltSpellAutoTrinket2:SetChecked(combo["Alt"..button..HealBot_Config.CurrentSpec] or false)
        HealBot_AltShiftSpellAutoTrinket2:SetChecked(combo["Alt-Shift"..button..HealBot_Config.CurrentSpec] or false)
        HealBot_CtrlShiftSpellAutoTrinket2:SetChecked(combo["Ctrl-Shift"..button..HealBot_Config.CurrentSpec] or false)
        HealBot_CtrlAltSpellAutoTrinket2:SetChecked(combo["Alt-Ctrl"..button..HealBot_Config.CurrentSpec] or false)
    end
    if HealBot_Options_StorePrev["ActionBarsCombo"]==1 then
        combo = HealBot_Config_Spells.EnabledAvoidBlueCursor;
    elseif HealBot_Options_StorePrev["ActionBarsCombo"]==2 then
        combo = HealBot_Config_Spells.DisabledAvoidBlueCursor;
    else
        combo = HealBot_Config_Spells.EnemyAvoidBlueCursor;
    end
    if combo then
        HealBot_AvoidBlueCursor:SetChecked(combo[button..HealBot_Config.CurrentSpec] or false)
        HealBot_ShiftAvoidBlueCursor:SetChecked(combo["Shift"..button..HealBot_Config.CurrentSpec] or false)
        HealBot_CtrlAvoidBlueCursor:SetChecked(combo["Ctrl"..button..HealBot_Config.CurrentSpec] or false)
        HealBot_AltAvoidBlueCursor:SetChecked(combo["Alt"..button..HealBot_Config.CurrentSpec] or false)
        HealBot_AltShiftAvoidBlueCursor:SetChecked(combo["Alt-Shift"..button..HealBot_Config.CurrentSpec] or false)
        HealBot_CtrlShiftAvoidBlueCursor:SetChecked(combo["Ctrl-Shift"..button..HealBot_Config.CurrentSpec] or false)
        HealBot_CtrlAltAvoidBlueCursor:SetChecked(combo["Alt-Ctrl"..button..HealBot_Config.CurrentSpec] or false)
    end
    if HealBot_Options_ComboButtons_Button>3 then
        local g=_G["HealBot_Options_ShiftCntlAltClickHeader"] 
        g:SetText(" ")
        local g=_G["HealBot_Options_ShiftCntlAltClickDetail"] 
        g:SetText(" ")
    else
        local g=_G["HealBot_Options_ShiftCntlAltClickHeader"] 
        g:SetText(HEALBOT_OPTIONS_SHIFT.."+"..HEALBOT_OPTIONS_CTRL.."+"..HEALBOT_OPTIONS_ALT.."+"..HEALBOT_OPTIONS_CLICK..":")
        local g=_G["HealBot_Options_ShiftCntlAltClickDetail"] 
        g:SetText(HealBot_Options_SCAC[HealBot_Options_ComboButtons_Button])
    end
end

--------------------------------------------------------------------------------

HealBot_Options_StorePrev["HealSpellsComboID"] = 0

function HealBot_Options_FullHealSpellsCombo_list (sType)
    local HealBot_Options_SelectHealSpellsCombo_List = {}
    if sType==3 then
        HealBot_Options_SelectHealSpellsCombo_List = {
            HEALBOT_MINDBENDER,
            HEALBOT_SMITE,
            HEALBOT_DISPEL_MAGIC,
            HEALBOT_HOLY_WORD_CHASTISE,
            HEALBOT_HOLY_FIRE,
            HEALBOT_SHADOW_WORD_PAIN,
            HEALBOT_WRATH,
            HEALBOT_FAERIE_FIRE,
            HEALBOT_JAB,
            HEALBOT_TIGER_PALM,
            HEALBOT_CHI_BURST,
            HEALBOT_JUDGMENT,
            HEALBOT_SHIELD_OF_THE_RIGHTEOUS,
            HEALBOT_CRUSADER_STRIKE,
            HEALBOT_CHAIN_LIGHTNING,
            HEALBOT_ELEMENTAL_BLAST,
            HEALBOT_FLAME_SHOCK,
            HEALBOT_FROST_SHOCK,
            HEALBOT_MAGE_BOMB,
            HEALBOT_CONCUSSIVE_SHOT,
            HEALBOT_PLAGUE_STRIKE,
            HEALBOT_GOUGE,
            HEALBOT_CORRUPTION,
            HEALBOT_EXECUTE,
            HEALBOT_EARTH_SHOCK,
            HEALBOT_LAVA_BLAST,
            HEALBOT_LIGHTNING_BOLT,
            HEALBOT_FAERIE_SWARM,
            HEALBOT_MOONFIRE,
            HEALBOT_PRIMAL_STRIKE,
            HEALBOT_MIND_SEAR,
            HEALBOT_SHADOW_WORD_DEATH,
            HEALBOT_BLACKOUT_KICK,
            HEALBOT_TOUCH_OF_DEATH,
            HEALBOT_CRACKLING_JADE_LIGHTNING,
            HEALBOT_DENOUNCE,
            HEALBOT_HAMMER_OF_WRATH,
            HEALBOT_HOLY_SHOCK,
            HEALBOT_TAUNT,
            HEALBOT_FEAR,
            HEALBOT_THROW,
            HEALBOT_DEATH_COIL,
            HEALBOT_ARCANE_SHOT,
            HEALBOT_AIMED_SHOT,
            HEALBOT_FIRE_BLAST,
            HEALBOT_FROSTFIRE_BOLT,
        }
    else
        HealBot_Options_SelectHealSpellsCombo_List = {
            HEALBOT_BINDING_HEAL,
            HEALBOT_HOLY_NOVA,
            HEALBOT_CIRCLE_OF_HEALING,
            HEALBOT_DESPERATE_PRAYER,
            HEALBOT_CHAIN_HEAL,
            HEALBOT_SPIRIT_LINK_TOTEM,
            HEALBOT_FLASH_HEAL,
            HEALBOT_HOLY_WORD_SERENITY,
            HEALBOT_SURGING_MIST,
            HEALBOT_HOLY_WORD_SALVATION,
            HEALBOT_FLASH_OF_LIGHT,
            HEALBOT_GREATER_HEAL,
            HEALBOT_HEALING_TOUCH,
            HEALBOT_HEAL,
            HBC_HEAL,
            HEALBOT_HEALING_WAVE,
            HBC_HEALING_WAVE,
            HBC_LESSER_HEALING_WAVE,
            HEALBOT_HEALING_SURGE,
            HEALBOT_LIGHT_OF_DAWN,
            HEALBOT_HOLY_LIGHT,
            HBC_HOLY_LIGHT,
            HEALBOT_HOLY_RADIANCE,
            HEALBOT_HOLY_PRISM,
            HEALBOT_WORD_OF_GLORY,
            HEALBOT_DIVINE_LIGHT,
            HEALBOT_LAY_ON_HANDS,
            HEALBOT_TYRS_DELIVERANCE,
            HEALBOT_HOLY_SHOCK,
            HEALBOT_LIFEBLOOM,
            HEALBOT_HEALING_STREAM_TOTEM,
            HEALBOT_HEALING_TIDE_TOTEM,
            HEALBOT_PENANCE,
            HEALBOT_PRAYER_OF_HEALING,
            HEALBOT_PRAYER_OF_MENDING,
            HEALBOT_RIPTIDE,
            HEALBOT_WELLSPRING,
            HEALBOT_DOWNPOUR,
            HEALBOT_REGROWTH,
            HEALBOT_RENEW,
            HEALBOT_DIVINE_HYMN,
            HEALBOT_HEALING_RAIN,
            HEALBOT_REJUVENATION,
            HEALBOT_WILD_GROWTH,
            HEALBOT_SWIFTMEND,
            HEALBOT_TRANQUILITY,
            HEALBOT_GIFT_OF_THE_NAARU,
            HEALBOT_MENDPET,
            HEALBOT_HEALTH_FUNNEL,
            HEALBOT_SOOTHING_MIST,
            HEALBOT_ZEN_MEDITATION,
            HEALBOT_LIFE_COCOON,
            HEALBOT_ENVELOPING_MIST,
            HEALBOT_REVIVAL,
            HEALBOT_RENEWING_MIST,
            HEALBOT_UPLIFT,
            HEALBOT_SURGING_MIST,
            HEALBOT_CHI_WAVE,
            HEALBOT_ZEN_SPHERE,
            HEALBOT_CHI_BURST,
            HEALBOT_EXECUTION_SENTENCE,
            HEALBOT_CASCADE,
            HEALBOT_DIVINE_STAR,
            HEALBOT_HALO,               
            --HEALBOT_SAVING_GRACE,                    
            HEALBOT_CLARITY_OF_PURPOSE,
            HEALBOT_CENARION_WARD,
            HEALBOT_BREATH_OF_THE_SERPENT,
            HEALBOT_CHI_EXPLOSION,
            HEALBOT_RUSHING_JADE_WIND,              
            HEALBOT_CHI_TOROEDO,
            HEALBOT_BEACON_OF_LIGHT,
			--Legion Added
			HEALBOT_PLEA, --Priest                           
			HEALBOT_POWER_WORD_RADIANCE,            
			HEALBOT_SHADOW_COVENANT,                
			HEALBOT_SHADOW_MEND,
			HEALBOT_HOLY_WORD_SANCTIFY,              
			HEALBOT_BESTOW_FAITH, --Paladin                    
			HEALBOT_LIGHT_OF_THE_MARTYR, 
            HEALBOT_BEACON_OF_VIRTUE,     
            HEALBOT_HAND_OF_THE_PROTECTOR,   
            HEALBOT_ESSENCE_FONT,
            HEALBOT_LIGHT_OF_TUURE, --Priest          
        }
    end
    return HealBot_Options_SelectHealSpellsCombo_List
end

function HealBot_Options_SelectHealSpellsCombo_DDlist(sType)
    local tmpHealDDlist={}
    if HEALBOT_GAME_VERSION>3 then
        local fullHealDDlist=HealBot_Options_FullHealSpellsCombo_list(sType)
        for j=1, getn(fullHealDDlist), 1 do
            local spellName=HealBot_KnownSpell(fullHealDDlist[j])
            if spellName then
                table.insert(tmpHealDDlist, spellName)
            end
        end
    else
        local knownHealSpells=HealBot_Init_retFoundHealSpells()
        for sName,_ in pairs(HealBot_Spell_Names) do
            for kSpell,_ in pairs(knownHealSpells) do
                if string.find(sName, kSpell) then
                    table.insert(tmpHealDDlist, sName)
                    break
                end
            end
        end
    end
    table.sort(tmpHealDDlist)
    return tmpHealDDlist
end

local function HealBot_Options_SelectHealSpellsCombo_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    local hbHealDDlist=HealBot_Options_SelectHealSpellsCombo_DDlist(HealBot_Options_StorePrev["HealSpellsComboID"])
    if getn(hbHealDDlist)>0 then
        for j=1, getn(hbHealDDlist), 1 do
            info.text = hbHealDDlist[j];
            info.func = function(self)
                        HealBot_Options_StorePrev["hbHelpHealSelect"] = self:GetText()
                        HealBot_Options_StorePrev["HealSpellsComboID"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_SelectHealSpellsCombo,hbHealDDlist[HealBot_Options_StorePrev["HealSpellsComboID"]]) 
                    end
            info.checked = false;
            if HealBot_Options_StorePrev["HealSpellsComboID"]==j then info.checked = true end
            UIDropDownMenu_AddButton(info);
        end
    else
        info.text = HEALBOT_TOOLTIP_NONE
        info.func = function(self)
                        HealBot_Options_StorePrev["hbHelpHealSelect"] = nil
                        HealBot_Options_StorePrev["HealSpellsComboID"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_SelectHealSpellsCombo,HEALBOT_TOOLTIP_NONE) 
                    end
        info.checked = true;
        UIDropDownMenu_AddButton(info);
    end
end

--------------------------------------------------------------------------------

HealBot_Options_StorePrev["OtherSpellsComboID"] = 0

local function HealBot_Options_SelectOtherSpellsCombo_DDlist()
    local HealBot_Options_SelectOtherSpellsCombo_List = {}
    local tmpOtherDDlist={}
    if HealBot_Options_StorePrev["ActionBarsCombo"]==3 then
        HealBot_Options_SelectOtherSpellsCombo_List = {
            HEALBOT_HEX,
            HEALBOT_ENTANGLING_ROOTS,
            HEALBOT_GROWL,
            HEALBOT_SOOTHE,
            HEALBOT_MASS_ENTANGLEMENT,
            HEALBOT_PURGE,
            HEALBOT_WIND_SHEAR,
            HEALBOT_CYCLONE,
            HEALBOT_DOMINATE_MIND,
            HEALBOT_SHACKLE_UNDEAD,
            HEALBOT_PROVOKE,
            HEALBOT_DISABLE,
            HEALBOT_SPEAR_HAND_STRIKE,
            HEALBOT_PARALYSIS,
            HEALBOT_HAMMER_OF_JUSTICE,
            HEALBOT_REBUKE,
            HEALBOT_RECKONING,
            HEALBOT_REPENTANCE,
            HEALBOT_TURN_EVIL,
        }
        for j=1, getn(HealBot_Options_SelectOtherSpellsCombo_List), 1 do
            local spellName=HealBot_KnownSpell(HealBot_Options_SelectOtherSpellsCombo_List[j])
            if spellName then
                table.insert(tmpOtherDDlist,spellName)
            end
        end
    else
       HealBot_Options_SelectOtherSpellsCombo_List = {
            HEALBOT_STONEFORM,
            HEALBOT_DARKFLIGHT,
            HEALBOT_GIFT_OF_THE_NAARU,
            HEALBOT_POWER_WORD_SHIELD,
            HEALBOT_SPIRIT_SHELL,
			HEALBOT_REVIVE,
            HEALBOT_GUARDIAN_SPIRIT,
            HEALBOT_SHINING_FORCE,
            HEALBOT_PAIN_SUPPRESSION,
            HEALBOT_INTERVENE,
            HEALBOT_RESURRECTION,
            HEALBOT_REDEMPTION,
            HEALBOT_REBIRTH,
            HEALBOT_TREE_OF_LIFE,
            HEALBOT_INNERVATE,
            HEALBOT_ANCESTRALSPIRIT,
            HEALBOT_RESUSCITATE,
            HEALBOT_ABSOLUTION,
            HEALBOT_ANCESTRAL_VISION,
            HEALBOT_MASS_RESURRECTION,
            HEALBOT_REAWAKEN,
            HEALBOT_REVITALIZE,
            HEALBOT_CLEANSE,
            HEALBOT_REMOVE_CURSE,
            HEALBOT_CLEANSE_TOXIN,
            HEALBOT_REMOVE_CORRUPTION,
            HEALBOT_NATURES_CURE,
            HEALBOT_PURIFY_DISEASE,
            HEALBOT_PURIFY,
            HBC_PURIFY,
            HBC_SHAMAN_CURE_DISEASE,
            --HBC_PRIEST_CURE_DISEASE,
            HBC_DRUID_ABOLISH_POISON,
            HBC_PRIEST_ABOLISH_DISEASE,
            --HBC_DRUID_CURE_POISON,
            HBC_SHAMAN_CURE_POISON,
            --HBC_DISPELL_MAGIC,
            HEALBOT_CLEANSE_SPIRIT,
            HEALBOT_PURIFY_SPIRIT,
            HEALBOT_MASS_DISPEL,
            HEALBOT_LIFE_TAP,
            HEALBOT_DIVINE_SHIELD,
            HEALBOT_DIVINE_PROTECTION,
            HBC_DIVINE_INTERVENTION,
            HBC_DIVINE_FAVOR,
            HBC_DIVINE_FAVOR,
            HEALBOT_ANACESTRAL_SWIFTNESS,
            HEALBOT_LEAP_OF_FAITH,
            HEALBOT_UNLEASH_ELEMENTS,
            HEALBOT_DETOX,
            HEALBOT_SPEED_OF_LIGHT,
            HEALBOT_HAND_OF_PURITY,
            HEALBOT_THUNDER_FOCUS_TEA,
            HEALBOT_ASTRAL_SHIFT,
            HEALBOT_GUARDIAN_ANCIENT_KINGS,
            HEALBOT_UNLEASH_LIFE,
            HEALBOT_CLOUDBURST_TOTEM,
            HEALBOT_POWER_INFUSION,
            HEALBOT_VAMPIRIC_EMBRACE,
            HEALBOT_CLARITY_OF_WILL,
            HEALBOT_DETONATE_CHI,
            HEALBOT_BEACON_OF_FAITH,
            HEALBOT_BEACON_OF_INSIGHT,
			--Legion Added
			HEALBOT_RAPTURE,
			HEALBOT_APOTHEOSIS,
			HEALBOT_SYMBOL_OF_HOPE,
			HEALBOT_BODY_AND_MIND,
			HEALBOT_BLESSING_OF_SACRIFICE, --Paladin
            HEALBOT_HOLY_WARD,
        }
        for j=1, getn(HealBot_Options_SelectOtherSpellsCombo_List), 1 do
            local spellName=HealBot_KnownSpell(HealBot_Options_SelectOtherSpellsCombo_List[j])
            if spellName then
                table.insert(tmpOtherDDlist,spellName)
            end
        end
        for j=1, getn(HealBot_Buff_Spells_List), 1 do
            table.insert(tmpOtherDDlist,HealBot_Buff_Spells_List[j])
        end
    end
    table.sort(tmpOtherDDlist)
    return tmpOtherDDlist
end

function HealBot_Options_SelectOtherSpellsCombo_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    local hbOtherDDlist=HealBot_Options_SelectOtherSpellsCombo_DDlist()
    if getn(hbOtherDDlist)>0 then
        for j=1, getn(hbOtherDDlist), 1 do
            info.text = hbOtherDDlist[j];
            info.func = function(self)
                        HealBot_Options_StorePrev["hbHelpOtherSelect"] = self:GetText()
                        HealBot_Options_StorePrev["OtherSpellsComboID"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_SelectOtherSpellsCombo,hbOtherDDlist[HealBot_Options_StorePrev["OtherSpellsComboID"]]) 
                    end
            info.checked = false;
            if HealBot_Options_StorePrev["OtherSpellsComboID"]==j then info.checked = true end
            UIDropDownMenu_AddButton(info);
        end
    else
        info.text = HEALBOT_TOOLTIP_NONE
        info.func = function(self)
                        HealBot_Options_StorePrev["hbHelpOtherSelect"] = nil
                        HealBot_Options_StorePrev["OtherSpellsComboID"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_SelectOtherSpellsCombo,HEALBOT_TOOLTIP_NONE) 
                    end
        info.checked = true;
        UIDropDownMenu_AddButton(info);
    end
end

--------------------------------------------------------------------------------

HealBot_Options_StorePrev["MacrosComboID"] = 0

function HealBot_Options_SelectMacrosCombo_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    local numglobal,numperchar = GetNumMacros();
    local totalMacros=numglobal+numperchar
    local hbMacroName=nil
    if totalMacros>0 then
        for j=1, numglobal, 1 do
            hbMacroName=GetMacroInfo(j)
            if hbMacroName then
                local mgName = hbMacroName
                info.text = mgName
                info.func = function(self)
                                HealBot_Options_StorePrev["hbHelpMacroSelect"] = self:GetText()
                                HealBot_Options_StorePrev["MacrosComboID"] = self:GetID()
                                UIDropDownMenu_SetText(HealBot_Options_SelectMacrosCombo,mgName) 
                            end
                info.checked = false;
                if HealBot_Options_StorePrev["MacrosComboID"]==j then info.checked = true end
                UIDropDownMenu_AddButton(info);
            end
        end
        for j=MAX_ACCOUNT_MACROS+1, numperchar+MAX_ACCOUNT_MACROS, 1 do
            hbMacroName=GetMacroInfo(j)
            if hbMacroName and strsub(hbMacroName,1,strlen(HealBot_Config.CrashProtMacroName))~=HealBot_Config.CrashProtMacroName then
                local mpName = hbMacroName
                info.text = mpName
                info.func = function(self)
                                HealBot_Options_StorePrev["hbHelpMacroSelect"] = self:GetText()
                                HealBot_Options_StorePrev["MacrosComboID"] = self:GetID()
                                UIDropDownMenu_SetText(HealBot_Options_SelectMacrosCombo,mpName) 
                            end
                info.checked = false;
                if HealBot_Options_StorePrev["MacrosComboID"]==j then info.checked = true end
                UIDropDownMenu_AddButton(info);
            end
        end
    else
        info.text = HEALBOT_TOOLTIP_NONE
        info.func = function(self)
                        HealBot_Options_StorePrev["MacrosComboID"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_ManaIndicator,HEALBOT_TOOLTIP_NONE) 
                    end
        info.checked = true;
        UIDropDownMenu_AddButton(info);
        HealBot_Options_StorePrev["hbHelpMacroSelect"]=nil
    end
end

--------------------------------------------------------------------------------

function HealBot_Options_itemsByLevel()
    local hbLevel = UnitLevel("player")
    local hbItemsByLevel={}
    local hbTmpText1=nil
    if hbLevel <= 20 then
        hbTmpText1 = GetItemInfo(19004) or "Minor Healthstone"
        table.insert(hbItemsByLevel,hbTmpText1)
    elseif hbLevel <= 30 then
        hbTmpText1 = GetItemInfo(19007) or "Lesser Healthstone"
        table.insert(hbItemsByLevel,hbTmpText1)
    elseif hbLevel <= 40 then
        hbTmpText1 = GetItemInfo(19009) or "Healthstone"
        table.insert(hbItemsByLevel,hbTmpText1)
    elseif hbLevel <= 50 then
        hbTmpText1 = GetItemInfo(19011) or "Greater Healthstone"
        table.insert(hbItemsByLevel,hbTmpText1)
    elseif hbLevel <= 60 then
        hbTmpText1 = GetItemInfo(9421) or "Major Healthstone"
        table.insert(hbItemsByLevel,hbTmpText1)
    elseif hbLevel <= 70 then
        hbTmpText1 = GetItemInfo(19008) or "Master Healthstone"
        table.insert(hbItemsByLevel,hbTmpText1)
    elseif hbLevel <= 75 then
        hbTmpText1 = GetItemInfo(36892) or "Fel Healthstone"
        table.insert(hbItemsByLevel,hbTmpText1)
    else
        hbTmpText1 = GetItemInfo(36892) or "Fel Healthstone"
        table.insert(hbItemsByLevel,hbTmpText1)
    end
    return hbItemsByLevel
end
    
HealBot_Options_StorePrev["ItemsComboID"]=0


function HealBot_Options_SelectItemsCombo_DropDown()

    local info = UIDropDownMenu_CreateInfo()
    local HealBot_Options_SelectItemsCombo_List={}
    if HealBot_Options_StorePrev["ActionBarsCombo"]==3 then
        HealBot_Options_SelectItemsCombo_List={
            HEALBOT_WORDS_NONE,
        }
    else
        hbItemsIfExists = {
            [1] = HEALBOT_SILK_BANDAGE,
            [2] = HEALBOT_HEAVY_SILK_BANDAGE,
            [3] = HEALBOT_MAGEWEAVE_BANDAGE,
            [4] = HEALBOT_HEAVY_MAGEWEAVE_BANDAGE,
            [5] = HEALBOT_RUNECLOTH_BANDAGE,
            [6] = HEALBOT_HEAVY_RUNECLOTH_BANDAGE,
            [7] = HEALBOT_NETHERWEAVE_BANDAGE,
            [8] = HEALBOT_HEAVY_NETHERWEAVE_BANDAGE,
            [9] = HEALBOT_FROSTWEAVE_BANDAGE,
            [10] = HEALBOT_HEAVY_FROSTWEAVE_BANDAGE,
            [11] = HEALBOT_EMBERSILK_BANDAGE,
            [12] = HEALBOT_DENSE_EMBERSILK_BANDAGE,
            [13] = HEALBOT_MAJOR_HEALING_POTION,
            [14] = HEALBOT_SUPER_HEALING_POTION,
            [15] = HEALBOT_MAJOR_COMBAT_HEALING_POTION,
            [16] = HEALBOT_RUNIC_HEALING_POTION,
            [17] = HEALBOT_ENDLESS_HEALING_POTION,    
            [18] = HEALBOT_MAJOR_MANA_POTION,
            [19] = HEALBOT_SUPER_MANA_POTION,
            [20] = HEALBOT_MAJOR_COMBAT_MANA_POTION,
            [21] = HEALBOT_RUNIC_MANA_POTION,
            [22] = HEALBOT_ENDLESS_MANA_POTION,
            [23] = HEALBOT_PURIFICATION_POTION,
            [24] = HEALBOT_ANTI_VENOM,
            [25] = HEALBOT_POWERFUL_ANTI_VENOM,
            [26] = HEALBOT_ELIXIR_OF_POISON_RES,
            [27] = HEALBOT_HEAVY_WOOL_BANDAGE,
            [28] = HEALBOT_WOOL_BANDAGE,
            [29] = HEALBOT_HEAVY_LINEN_BANDAGE,
            [30] = HEALBOT_LINEN_BANDAGE,
            [31] = HEALBOT_HEAVY_EMBERSILK_BANDAGE,
            [32] = HEALBOT_WINDWOOL_BANDAGE,
            [33] = HEALBOT_HEAVY_WINDWOOL_BANDAGE,
            [34] = HEALBOT_ASHRAN_BANDAGE,
            [35] = HEALBOT_SILKWEAVE_BANDAGE,
            [36] = HEALBOT_DEEP_SEA_BANDAGE,
            [37] = HEALBOT_TIDESPRAY_LINEN_BANDAGE,
        }
        HealBot_Options_SelectItemsCombo_List=HealBot_Options_itemsByLevel()
        for j=1, getn(hbItemsIfExists), 1 do
            if IsUsableItem(hbItemsIfExists[j]) or HealBot_IsItemInBag(hbItemsIfExists[j]) then
                table.insert(HealBot_Options_SelectItemsCombo_List, hbItemsIfExists[j])
            end
        end
        local tID=nil
        local tName=nil
        for j=1,19 do 
            tID=GetInventoryItemID("player", j);
            if tID then 
                tName=GetItemInfo(tID) 
            else
                tName=nil
            end
            if tName and GetItemSpell(tName) then
                table.insert(HealBot_Options_SelectItemsCombo_List, tName)
            end
        end
    end
    table.sort(HealBot_Options_SelectItemsCombo_List)
    for j=1, getn(HealBot_Options_SelectItemsCombo_List), 1 do
        local iName = HealBot_Options_SelectItemsCombo_List[j];
        info.text = iName
        info.func = function(self)
                        HealBot_Options_StorePrev["hbHelpItemSelect"] = self:GetText()
                        HealBot_Options_StorePrev["ItemsComboID"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_SelectItemsCombo,iName) 
                    end
        info.checked = false;
        if HealBot_Options_StorePrev["ItemsComboID"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

--------------------------------------------------------------------------------

HealBot_Options_StorePrev["CmdsComboID"]=0

function HealBot_Options_SelectCmdsCombo_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    local HealBot_Options_SelectCmdsCombo_List={}
    if HealBot_Options_StorePrev["ActionBarsCombo"]==3 then
        HealBot_Options_SelectCmdsCombo_List = {
                HEALBOT_DISABLED_TARGET,
                HEALBOT_FOCUS,
            }
    else
        HealBot_Options_SelectCmdsCombo_List = {
                HEALBOT_DISABLED_TARGET,
                HEALBOT_ASSIST,
                HEALBOT_FOCUS,
                HEALBOT_MENU,
                HEALBOT_HBMENU,
                HEALBOT_STOP,
                HEALBOT_TELL.." ...",
            }
    end
    for j=1, getn(HealBot_Options_SelectCmdsCombo_List), 1 do
        info.text = HealBot_Options_SelectCmdsCombo_List[j];
        info.func = function(self)
                        HealBot_Options_StorePrev["hbHelpCmdsSelect"] = self:GetText()
                        HealBot_Options_StorePrev["CmdsComboID"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_SelectCmdsCombo,HealBot_Options_SelectCmdsCombo_List[HealBot_Options_StorePrev["CmdsComboID"]]) 
                    end
        info.checked = false;
        if HealBot_Options_StorePrev["CmdsComboID"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

--------------------------------------------------------------------------------

function HealBot_Options_SpellsSelect_OnClick(self, sType)
    if sType~="Cancel" then
        local hbTmpText1=nil
        if sType=="Heal" then
            hbTmpText1=HealBot_Options_StorePrev["hbHelpHealSelect"] or ""
        elseif sType=="Other" then
            hbTmpText1=HealBot_Options_StorePrev["hbHelpOtherSelect"] or ""
        elseif sType=="Macro" then
            hbTmpText1=HealBot_Options_StorePrev["hbHelpMacroSelect"] or ""
        elseif sType=="Item" then
            hbTmpText1=HealBot_Options_StorePrev["hbHelpItemSelect"] or ""
        else
            hbTmpText1=HealBot_Options_StorePrev["hbHelpCmdsSelect"] or ""
        end
        if hbTmpText1~=HEALBOT_TOOLTIP_NONE then
            if HealBot_Options_StorePrev["HealBot_Options_sLoc"]=="Click" then
                HealBot_Options_Click:SetText(hbTmpText1)
            elseif HealBot_Options_StorePrev["HealBot_Options_sLoc"]=="Shift" then
                HealBot_Options_Shift:SetText(hbTmpText1)
            elseif HealBot_Options_StorePrev["HealBot_Options_sLoc"]=="Ctrl" then
                HealBot_Options_Ctrl:SetText(hbTmpText1)
            elseif HealBot_Options_StorePrev["HealBot_Options_sLoc"]=="Alt" then
                HealBot_Options_Alt:SetText(hbTmpText1)
            elseif HealBot_Options_StorePrev["HealBot_Options_sLoc"]=="CtrlShift" then
                HealBot_Options_CtrlShift:SetText(hbTmpText1)
            elseif HealBot_Options_StorePrev["HealBot_Options_sLoc"]== "AltShift" then
                HealBot_Options_AltShift:SetText(hbTmpText1)
            else -- "AltCtrl"
                HealBot_Options_CtrlAlt:SetText(hbTmpText1)
            end
        end
    end
    HealBot_Options_SelectSpellsFrame:Hide()
    HealBot_Options_KeysFrame:Show()
end

function HealBot_Options_HelpSpellsSelect_OnClick(self, sLoc)
    HealBot_Options_Init(10)
    HealBot_Options_StorePrev["HealBot_Options_sLoc"]=sLoc
    local hbOptionText=nil
    if HealBot_Options_StorePrev["ActionBarsCombo"]==1 then
        hbOptionText=HEALBOT_OPTIONS_SETSPELLS..": "..HEALBOT_OPTIONS_ENABLEDBARS
    elseif HealBot_Options_StorePrev["ActionBarsCombo"]==2 then
        hbOptionText=HEALBOT_OPTIONS_SETSPELLS..": "..HEALBOT_OPTIONS_DISABLEDBARS
    else
        hbOptionText=HEALBOT_OPTIONS_SETSPELLS..": "..HEALBOT_OPTIONS_ENEMYBARS
    end
    HealBot_Options_SelectSpellsFrame_TextH1:SetText(hbOptionText)
    local _,hbTmpText1=HealBot_Options_ComboClass_Button(HealBot_Options_ComboButtons_Button)
    hbTmpText1=hbTmpText1.." "..HEALBOT_OPTIONS_CLICK
    if sLoc=="Click" then
        hbOptionText=HEALBOT_OPTIONS_COMBOCLASS..":  "..hbTmpText1
    elseif sLoc=="Shift" then
        hbOptionText=HEALBOT_OPTIONS_COMBOCLASS..":  "..HEALBOT_OPTIONS_SHIFT.."+"..hbTmpText1
    elseif sLoc=="Ctrl" then
        hbOptionText=HEALBOT_OPTIONS_COMBOCLASS..":  "..HEALBOT_OPTIONS_CTRL.."+"..hbTmpText1
    elseif sLoc=="Alt" then
        hbOptionText=HEALBOT_OPTIONS_COMBOCLASS..":  "..HEALBOT_OPTIONS_ALT.."+"..hbTmpText1
    elseif sLoc=="CtrlShift" then
        hbOptionText=HEALBOT_OPTIONS_COMBOCLASS..":  "..HEALBOT_OPTIONS_CTRL.."+"..HEALBOT_OPTIONS_SHIFT.."+"..hbTmpText1
    elseif sLoc=="AltShift" then
        hbOptionText=HEALBOT_OPTIONS_COMBOCLASS..":  "..HEALBOT_OPTIONS_ALT.."+"..HEALBOT_OPTIONS_SHIFT.."+"..hbTmpText1
    else -- "AltCtrl"
        hbOptionText=HEALBOT_OPTIONS_COMBOCLASS..":  "..HEALBOT_OPTIONS_CTRL.."+"..HEALBOT_OPTIONS_ALT.."+"..hbTmpText1
    end
    HealBot_Options_SelectSpellsFrame_TextH2:SetText(hbOptionText)
    HealBot_Options_KeysFrame:Hide()
    HealBot_Options_SelectSpellsFrame:Show()
end

--------------------------------------------------------------------------------
function HealBot_Options_ActionAnchor_UpdateDropDown()
    HealBot_Options_ActionAnchor.initialize = HealBot_Options_ActionAnchor_DropDown
    UIDropDownMenu_SetText(HealBot_Options_ActionAnchor, HealBot_Options_ActionAnchor_List[Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["FRAME"]])
end

function HealBot_Options_ActionAnchor_SetAlpha(hbCurFrame)
    if hbCurFrame==HealBot_Options_StorePrev["FramesSelFrame"] then
        if HealBot_Action_hbStickyFrameGetCoords(hbCurFrame) then
            HealBot_Options_ActionAnchor:SetAlpha(0.4)
        else
            HealBot_Options_ActionAnchor:SetAlpha(1)
        end
    end
end

function HealBot_Options_ActionAnchor_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_ActionAnchor_List), 1 do
        info.text = HealBot_Options_ActionAnchor_List[j];
        info.func = function(self)
                        Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["FRAME"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_ActionAnchor,HealBot_Options_ActionAnchor_List[Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["FRAME"]]) 
                        local g=_G["f"..HealBot_Options_StorePrev["FramesSelFrame"].."_HealBot_Action"]
                        HealBot_Action_setPoint(HealBot_Options_StorePrev["FramesSelFrame"])
                        HealBot_Panel_ClearBarArrays()
                    end
        info.checked = false;
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["FRAME"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_ActionBarsAnchor_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, 4, 1 do
        info.text = HealBot_Options_ActionAnchor_List[j];
        info.func = function(self)
                        Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BARS"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_ActionBarsAnchor,HealBot_Options_ActionAnchor_List[Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BARS"]]) 
                        local g=_G["f"..HealBot_Options_StorePrev["FramesSelFrame"].."_HealBot_Action"]
                        HealBot_Action_setPoint(HealBot_Options_StorePrev["FramesSelFrame"])
                        HealBot_Panel_ClearBarArrays()
                    end
        info.checked = false;
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BARS"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_BarsGrowDirection_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, 2, 1 do
        info.text = HealBot_Options_BarsGrowDirection_List[j];
        info.func = function(self)
                        Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["GROW"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_BarsGrowDirection,HealBot_Options_BarsGrowDirection_List[Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["GROW"]]) 
                        HealBot_Panel_ClearBarArrays()
                        HealBot_Options_framesChanged(HealBot_Options_StorePrev["FramesSelFrame"])
                    end
        info.checked = false;
        if Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["GROW"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_BarsOrientation_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, 2, 1 do
        info.text = HealBot_Options_BarsOrientation_List[j];
        info.func = function(self)
                        Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["OFIX"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_BarsOrientation,HealBot_Options_BarsOrientation_List[Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["OFIX"]]) 
                        HealBot_Panel_ClearBarArrays()
                        HealBot_setOptions_Timer(150)
                    end
        info.checked = false;
        if Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["OFIX"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

--------------------------------------------------------------------------------

function HealBot_Options_ShowBarsPanelVisibilityRaid(oShow)
    HealBot_Options_ObjectsEnableDisable("HealBot_Options_EFGroup1",oShow)
    HealBot_Options_ObjectsEnableDisable("HealBot_Options_EFGroup2",oShow)
    HealBot_Options_ObjectsEnableDisable("HealBot_Options_EFGroup3",oShow)
    HealBot_Options_ObjectsEnableDisable("HealBot_Options_EFGroup4",oShow)
    HealBot_Options_ObjectsEnableDisable("HealBot_Options_EFGroup5",oShow)
    HealBot_Options_ObjectsEnableDisable("HealBot_Options_EFGroup6",oShow)
    HealBot_Options_ObjectsEnableDisable("HealBot_Options_EFGroup7",oShow)
    HealBot_Options_ObjectsEnableDisable("HealBot_Options_EFGroup8",oShow)
    if oShow then
        HealBot_Options_EmergencyFilter:SetAlpha(1)
    else
        HealBot_Options_EmergencyFilter:SetAlpha(0.4)
    end
end

function HealBot_Options_ShowBarsPanelVisibilityFocus(oShow)
    HealBot_Options_ObjectsEnableDisable("HealBot_Options_FocusOnlyFriend",oShow)
    HealBot_Options_ObjectsEnableDisable("HealBot_Options_FocusExcludeRaid",oShow)
    if oShow then
        HealBot_Options_FocusInCombat:SetAlpha(1)
    else
        HealBot_Options_FocusInCombat:SetAlpha(0.4)
    end
end

function HealBot_Options_ShowBarsPanelVisibilityTargets(oShow)
    HealBot_Options_ObjectsEnableDisable("HealBot_Options_TargetOnlyFriend",oShow)
    HealBot_Options_ObjectsEnableDisable("HealBot_Options_TargetExcludeRaid",oShow)
    if oShow then
        HealBot_Options_TargetInCombat:SetAlpha(1)
    else
        HealBot_Options_TargetInCombat:SetAlpha(0.4)
    end
end

function HealBot_Options_FramesSelFrame_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1,10, 1 do
        info.text = HealBot_Options_HealGroupsFrame_List[j];
        info.func = function(self)
                        HealBot_Options_StorePrev["FramesSelFrame"]=self:GetID()
                        if HEALBOT_GAME_VERSION<4 then 
                            if HealBot_Options_StorePrev["FramesSelFrame"]==6 then HealBot_Options_StorePrev["FramesSelFrame"]=7 end
                            if HealBot_Options_StorePrev["FramesSelFrame"]==9 then HealBot_Options_StorePrev["FramesSelFrame"]=10 end
                        end
                        UIDropDownMenu_SetText(HealBot_Options_FramesSelFrame,HealBot_Options_HealGroupsFrame_List[HealBot_Options_StorePrev["FramesSelFrame"]]) 
                        HealBot_Options_Frame_initCurFrame()
                        if HealBot_Options_StorePrev["FramesSelFrame"]>5 then
                            g=_G["HealBot_Options_FrameAlias"] 
                            g:Hide()
                            g=_G["HealBot_Options_FrameAliasFixedFrame"] 
                            g:SetText(HealBot_Options_HealGroupsFrame_List[HealBot_Options_StorePrev["FramesSelFrame"]])
                            g:Show()
                        else
                            g=_G["HealBot_Options_FrameAliasFixedFrame"] 
                            g:Hide()
                            HealBot_Options_SetText(HealBot_Options_FrameAlias,HEALBOT_OPTIONS_FRAME_ALIAS)
                            g=_G["HealBot_Options_FrameAlias"] 
                            g:Show()
                        end
                        if HealBot_Options_StorePrev["FramesSelFrame"]>1 then
                            HealBot_Options_ObjectsEnableDisable("HealBot_FrameStickyOffsetHorizontal",true)
                            HealBot_Options_ObjectsEnableDisable("HealBot_FrameStickyOffsetVertical",true)
                        else
                            HealBot_Options_ObjectsEnableDisable("HealBot_FrameStickyOffsetHorizontal",false)
                            HealBot_Options_ObjectsEnableDisable("HealBot_FrameStickyOffsetVertical",false)
                        end
                        if HealBot_Options_StorePrev["FramesSelFrame"]>9 then
                            HealBot_Options_ManaIndicator:SetAlpha(0.4)
                            HealBot_Options_ObjectsEnableDisable("HealBot_Options_ManaIndicatorInCombat",false)
                        else
                            HealBot_Options_ManaIndicator:SetAlpha(1)
                            HealBot_Options_ObjectsEnableDisable("HealBot_Options_ManaIndicatorInCombat",true)
                        end
                        HealBot_setOptions_Timer(5000)
                        if HealBot_Options_StorePrev["FramesSelFrame"]>5 then
                            HealBot_Options_ObjectsEnableDisable("HealBot_Options_SubSortPlayerFirst",false)
                            if HealBot_Options_StorePrev["FramesSelFrame"]==7 then
                                HealBot_Options_ObjectsEnableDisable("HealBot_Options_GroupPetsByFive",true)
                                HealBot_Options_ObjectsEnableDisable("HealBot_Options_SelfPet",true)
                            else
                                HealBot_Options_ObjectsEnableDisable("HealBot_Options_GroupPetsByFive",false)
                                HealBot_Options_ObjectsEnableDisable("HealBot_Options_SelfPet",false)
                            end
                        else
                            HealBot_Options_ObjectsEnableDisable("HealBot_Options_SubSortPlayerFirst",true)
                            HealBot_Options_ObjectsEnableDisable("HealBot_Options_GroupPetsByFive",false)
                            HealBot_Options_ObjectsEnableDisable("HealBot_Options_SelfPet",false)
                        end
                        if HealBot_Options_StorePrev["FramesSelFrame"]<10 then
                            if HealBot_Options_StorePrev["FramesSelFrame"]==9 then  -- Focus Frame
                                HealBot_Options_ShowBarsPanelVisibilityTargets(false)
                                HealBot_Options_ShowBarsPanelVisibilityRaid(false)
                                HealBot_Options_ShowBarsPanelVisibilityFocus(true)
                            elseif HealBot_Options_StorePrev["FramesSelFrame"]==8 then  -- Target Frame
                                HealBot_Options_ShowBarsPanelVisibilityRaid(false)
                                HealBot_Options_ShowBarsPanelVisibilityFocus(false)
                                HealBot_Options_ShowBarsPanelVisibilityTargets(true)
                            else
                                HealBot_Options_ShowBarsPanelVisibilityFocus(false)
                                HealBot_Options_ShowBarsPanelVisibilityTargets(false)
                                HealBot_Options_ShowBarsPanelVisibilityRaid(true)
                            end
                        end
                        if HealBot_Options_StorePrev["CurrentSkinsBarsPanelButton"]=="HealBot_Options_SkinsFramesBarsVisibilityb" then
                            HealBot_Options_ShowBarsPanel("HealBot_Options_SkinsFramesBarsVisibility", "HealBot_Options_SkinsFramesBarsVisibilityb")
                        elseif HealBot_Options_StorePrev["CurrentSkinsBarsPanelButton"]=="HealBot_Options_SkinsFramesBarsSortb" then
                            HealBot_Options_ShowBarsPanel("HealBot_Options_SkinsFramesBarsSort", "HealBot_Options_SkinsFramesBarsSortb")
                        end
                        if HealBot_Options_StorePrev["FramesSelFrame"]>7 and HealBot_Options_StorePrev["FramesSelFrame"]<10 then
                            if HealBot_Options_StorePrev["CurrentSkinsBarsPanelButton"]=="HealBot_Options_SkinsFramesBarsSortb" then
                                HealBot_Options_ShowBarsPanel("HealBot_Options_SkinsFramesBarsGeneral", "HealBot_Options_SkinsFramesBarsGeneralb")
                            end
                            g=_G["HealBot_Options_SkinsFramesBarsSortb"] 
                            g:Disable()
                            g=_G["HealBot_Options_SkinsFramesBarsAggrob"] 
                            g:Enable()
                        else
                            if HealBot_Options_StorePrev["FramesSelFrame"]==10 then
                                if HealBot_Options_StorePrev["CurrentSkinsBarsPanelButton"]=="HealBot_Options_SkinsFramesBarsAggrob" then
                                    HealBot_Options_ShowBarsPanel("HealBot_Options_SkinsFramesBarsGeneral", "HealBot_Options_SkinsFramesBarsGeneralb")
                                end
                                g=_G["HealBot_Options_SkinsFramesBarsAggrob"] 
                                g:Disable()
                            else
                                g=_G["HealBot_Options_SkinsFramesBarsAggrob"] 
                                g:Enable()
                            end
                            g=_G["HealBot_Options_SkinsFramesBarsSortb"] 
                            g:Enable()
                        end
                    end
        info.checked = false;
        if HealBot_Options_StorePrev["FramesSelFrame"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_ApplyTab2Frames_OnClick()
    local s=Healbot_Config_Skins.Current_Skin
    local f=HealBot_Options_StorePrev["FramesSelFrame"]
    for j=1,10 do
        if j~=f then
            if hbCurSkinSubFrameID==1008 then
                Healbot_Config_Skins.Frame[s][j]["SCALE"]=Healbot_Config_Skins.Frame[s][f]["SCALE"]
                Healbot_Config_Skins.FrameAlias[s][j]["SIZE"]=Healbot_Config_Skins.FrameAlias[s][f]["SIZE"]
                Healbot_Config_Skins.FrameAlias[s][j]["OFFSET"]=Healbot_Config_Skins.FrameAlias[s][f]["OFFSET"]
                Healbot_Config_Skins.Frame[s][j]["LOCKED"]=Healbot_Config_Skins.Frame[s][f]["LOCKED"]
                Healbot_Config_Skins.Frame[s][j]["AUTOCLOSE"]=Healbot_Config_Skins.Frame[s][f]["AUTOCLOSE"]
                Healbot_Config_Skins.Frame[s][j]["OPENSOUND"]=Healbot_Config_Skins.Frame[s][f]["OPENSOUND"]
                Healbot_Config_Skins.Anchors[s][j]["GROW"]=Healbot_Config_Skins.Anchors[s][f]["GROW"]
                Healbot_Config_Skins.Anchors[s][j]["FRAME"]=Healbot_Config_Skins.Anchors[s][f]["FRAME"]
                Healbot_Config_Skins.Anchors[s][j]["BARS"]=Healbot_Config_Skins.Anchors[s][f]["BARS"]
                Healbot_Config_Skins.Frame[s][j]["TIPLOC"]=Healbot_Config_Skins.Frame[s][f]["TIPLOC"]
                Healbot_Config_Skins.Frame[s][j]["BACKR"]=Healbot_Config_Skins.Frame[s][f]["BACKR"]
                Healbot_Config_Skins.Frame[s][j]["BACKG"]=Healbot_Config_Skins.Frame[s][f]["BACKG"]
                Healbot_Config_Skins.Frame[s][j]["BACKB"]=Healbot_Config_Skins.Frame[s][f]["BACKB"]
                Healbot_Config_Skins.Frame[s][j]["BACKA"]=Healbot_Config_Skins.Frame[s][f]["BACKA"]
                Healbot_Config_Skins.Frame[s][j]["BORDERR"]=Healbot_Config_Skins.Frame[s][f]["BORDERR"]
                Healbot_Config_Skins.Frame[s][j]["BORDERG"]=Healbot_Config_Skins.Frame[s][f]["BORDERG"]
                Healbot_Config_Skins.Frame[s][j]["BORDERB"]=Healbot_Config_Skins.Frame[s][f]["BORDERB"]
                Healbot_Config_Skins.Frame[s][j]["BORDERA"]=Healbot_Config_Skins.Frame[s][f]["BORDERA"]
            elseif hbCurSkinSubFrameID==1010 then
                if HealBot_Options_StorePrev["CurrentSkinsHeaderPanel"]=="HealBot_Options_SkinsFrameHeadersBar" then
                    Healbot_Config_Skins.HeadBar[s][j]["TEXTURE"]=Healbot_Config_Skins.HeadBar[s][f]["TEXTURE"]
                    Healbot_Config_Skins.HeadBar[s][j]["WIDTH"]=Healbot_Config_Skins.HeadBar[s][f]["WIDTH"]
                    Healbot_Config_Skins.HeadBar[s][j]["HEIGHT"]=Healbot_Config_Skins.HeadBar[s][f]["HEIGHT"]
                    Healbot_Config_Skins.HeadText[s][j]["FONT"]=Healbot_Config_Skins.HeadText[s][f]["FONT"]
                    Healbot_Config_Skins.HeadText[s][j]["HEIGHT"]=Healbot_Config_Skins.HeadText[s][f]["HEIGHT"]
                    Healbot_Config_Skins.HeadBar[s][j]["SHOW"]=Healbot_Config_Skins.HeadBar[s][f]["SHOW"]
                    Healbot_Config_Skins.HeadBar[s][j]["R"]=Healbot_Config_Skins.HeadBar[s][f]["R"]
                    Healbot_Config_Skins.HeadBar[s][j]["G"]=Healbot_Config_Skins.HeadBar[s][f]["G"]
                    Healbot_Config_Skins.HeadBar[s][j]["B"]=Healbot_Config_Skins.HeadBar[s][f]["B"]
                    Healbot_Config_Skins.HeadBar[s][j]["A"]=Healbot_Config_Skins.HeadBar[s][f]["A"]
                    Healbot_Config_Skins.HeadText[s][j]["OUTLINE"]=Healbot_Config_Skins.HeadText[s][f]["OUTLINE"]
                    Healbot_Config_Skins.HeadText[s][j]["R"]=Healbot_Config_Skins.HeadText[s][f]["R"]
                    Healbot_Config_Skins.HeadText[s][j]["G"]=Healbot_Config_Skins.HeadText[s][f]["G"]
                    Healbot_Config_Skins.HeadText[s][j]["B"]=Healbot_Config_Skins.HeadText[s][f]["B"]
                    Healbot_Config_Skins.HeadText[s][j]["A"]=Healbot_Config_Skins.HeadText[s][f]["A"]
                else
                    Healbot_Config_Skins.FrameAlias[s][j]["SHOW"]=Healbot_Config_Skins.FrameAlias[s][f]["SHOW"]
                    Healbot_Config_Skins.FrameAlias[s][j]["FONT"]=Healbot_Config_Skins.FrameAlias[s][f]["FONT"]
                    Healbot_Config_Skins.FrameAlias[s][j]["OUTLINE"]=Healbot_Config_Skins.FrameAlias[s][f]["OUTLINE"]
                    Healbot_Config_Skins.FrameAlias[s][j]["R"]=Healbot_Config_Skins.FrameAlias[s][f]["R"]
                    Healbot_Config_Skins.FrameAlias[s][j]["G"]=Healbot_Config_Skins.FrameAlias[s][f]["G"]
                    Healbot_Config_Skins.FrameAlias[s][j]["B"]=Healbot_Config_Skins.FrameAlias[s][f]["B"]
                    Healbot_Config_Skins.FrameAlias[s][j]["A"]=Healbot_Config_Skins.FrameAlias[s][f]["A"]
                    Healbot_Config_Skins.FrameAliasBar[s][j]["TEXTURE"]=Healbot_Config_Skins.FrameAliasBar[s][f]["TEXTURE"]
                    Healbot_Config_Skins.FrameAliasBar[s][j]["WIDTH"]=Healbot_Config_Skins.FrameAliasBar[s][f]["WIDTH"]
                    Healbot_Config_Skins.FrameAliasBar[s][j]["HEIGHT"]=Healbot_Config_Skins.FrameAliasBar[s][f]["HEIGHT"]
                    Healbot_Config_Skins.FrameAliasBar[s][j]["R"]=Healbot_Config_Skins.FrameAliasBar[s][f]["R"]
                    Healbot_Config_Skins.FrameAliasBar[s][j]["G"]=Healbot_Config_Skins.FrameAliasBar[s][f]["G"]
                    Healbot_Config_Skins.FrameAliasBar[s][j]["B"]=Healbot_Config_Skins.FrameAliasBar[s][f]["B"]
                    Healbot_Config_Skins.FrameAliasBar[s][j]["A"]=Healbot_Config_Skins.FrameAliasBar[s][f]["A"]
                end
            elseif hbCurSkinSubFrameID==1011 then
                if HealBot_Options_StorePrev["CurrentSkinsBarsPanel"]=="HealBot_Options_SkinsFramesBarsGeneral" then
                    Healbot_Config_Skins.HealBar[s][j]["CMARGIN"]=Healbot_Config_Skins.HealBar[s][f]["CMARGIN"]
                    Healbot_Config_Skins.HealBar[s][j]["POWERSIZE"]=Healbot_Config_Skins.HealBar[s][f]["POWERSIZE"]
                    Healbot_Config_Skins.HealBar[s][j]["AGGROSIZE"]=Healbot_Config_Skins.HealBar[s][f]["AGGROSIZE"]
                    Healbot_Config_Skins.HealBar[s][j]["GRPCOLS"]=Healbot_Config_Skins.HealBar[s][f]["GRPCOLS"]
                    Healbot_Config_Skins.HealBar[s][j]["POWERCNT"]=Healbot_Config_Skins.HealBar[s][f]["POWERCNT"]
                    Healbot_Config_Skins.HealBar[s][j]["TEXTURE"]=Healbot_Config_Skins.HealBar[s][f]["TEXTURE"]
                    Healbot_Config_Skins.HealBar[s][j]["HEIGHT"]=Healbot_Config_Skins.HealBar[s][f]["HEIGHT"]
                    Healbot_Config_Skins.HealBar[s][j]["WIDTH"]=Healbot_Config_Skins.HealBar[s][f]["WIDTH"]
                    Healbot_Config_Skins.HealBar[s][j]["NUMCOLS"]=Healbot_Config_Skins.HealBar[s][f]["NUMCOLS"]
                    Healbot_Config_Skins.HealBar[s][j]["RMARGIN"]=Healbot_Config_Skins.HealBar[s][f]["RMARGIN"]
                elseif HealBot_Options_StorePrev["CurrentSkinsBarsPanel"]=="HealBot_Options_SkinsFramesBarsColours" then
                    Healbot_Config_Skins.BarCol[s][j]["DISA"]=Healbot_Config_Skins.BarCol[s][f]["DISA"]
                    Healbot_Config_Skins.BarCol[s][j]["ORA"]=Healbot_Config_Skins.BarCol[s][f]["ORA"]
                    Healbot_Config_Skins.BarCol[s][j]["HR"]=Healbot_Config_Skins.BarCol[s][f]["HR"]
                    Healbot_Config_Skins.BarCol[s][j]["HG"]=Healbot_Config_Skins.BarCol[s][f]["HG"]
                    Healbot_Config_Skins.BarCol[s][j]["HB"]=Healbot_Config_Skins.BarCol[s][f]["HB"]
                    Healbot_Config_Skins.BarCol[s][j]["HA"]=Healbot_Config_Skins.BarCol[s][f]["HA"]
                    Healbot_Config_Skins.BarIACol[s][j]["IR"]=Healbot_Config_Skins.BarIACol[s][f]["IR"]
                    Healbot_Config_Skins.BarIACol[s][j]["IG"]=Healbot_Config_Skins.BarIACol[s][f]["IG"]
                    Healbot_Config_Skins.BarIACol[s][j]["IB"]=Healbot_Config_Skins.BarIACol[s][f]["IB"]
                    Healbot_Config_Skins.BarIACol[s][j]["IA"]=Healbot_Config_Skins.BarIACol[s][f]["IA"]
                    Healbot_Config_Skins.BarIACol[s][j]["AR"]=Healbot_Config_Skins.BarIACol[s][f]["AR"]
                    Healbot_Config_Skins.BarIACol[s][j]["AG"]=Healbot_Config_Skins.BarIACol[s][f]["AG"]
                    Healbot_Config_Skins.BarIACol[s][j]["AB"]=Healbot_Config_Skins.BarIACol[s][f]["AB"]
                    Healbot_Config_Skins.BarIACol[s][j]["AA"]=Healbot_Config_Skins.BarIACol[s][f]["AA"]
                    Healbot_Config_Skins.BarCol[s][j]["BR"]=Healbot_Config_Skins.BarCol[s][f]["BR"]
                    Healbot_Config_Skins.BarCol[s][j]["BG"]=Healbot_Config_Skins.BarCol[s][f]["BG"]
                    Healbot_Config_Skins.BarCol[s][j]["BB"]=Healbot_Config_Skins.BarCol[s][f]["BB"]
                    Healbot_Config_Skins.BarCol[s][j]["BA"]=Healbot_Config_Skins.BarCol[s][f]["BA"]
                    Healbot_Config_Skins.BarCol[s][j]["BOUT"]=Healbot_Config_Skins.BarCol[s][f]["BOUT"]
                    Healbot_Config_Skins.BarIACol[s][j]["IC"]=Healbot_Config_Skins.BarIACol[s][f]["IC"]
                    Healbot_Config_Skins.BarCol[s][j]["HLTH"]=Healbot_Config_Skins.BarCol[s][f]["HLTH"]
                    Healbot_Config_Skins.BarCol[s][j]["BACK"]=Healbot_Config_Skins.BarCol[s][f]["BACK"]
                    Healbot_Config_Skins.BarIACol[s][j]["AC"]=Healbot_Config_Skins.BarIACol[s][f]["AC"]
                elseif HealBot_Options_StorePrev["CurrentSkinsBarsPanel"]=="HealBot_Options_SkinsFramesBarsText" then
                    Healbot_Config_Skins.BarText[s][j]["FONT"]=Healbot_Config_Skins.BarText[s][f]["FONT"]
                    Healbot_Config_Skins.BarText[s][j]["HEIGHT"]=Healbot_Config_Skins.BarText[s][f]["HEIGHT"]
                    Healbot_Config_Skins.BarText[s][j]["CLASSTYPE"]=Healbot_Config_Skins.BarText[s][f]["CLASSTYPE"]
                    Healbot_Config_Skins.BarText[s][j]["SHOWROLE"]=Healbot_Config_Skins.BarText[s][f]["SHOWROLE"]
                    Healbot_Config_Skins.BarText[s][j]["CLASSONBAR"]=Healbot_Config_Skins.BarText[s][f]["CLASSONBAR"]
                    Healbot_Config_Skins.BarText[s][j]["NAMEONBAR"]=Healbot_Config_Skins.BarText[s][f]["NAMEONBAR"]
                    Healbot_Config_Skins.BarText[s][j]["HLTHONBAR"]=Healbot_Config_Skins.BarText[s][f]["HLTHONBAR"]
                    Healbot_Config_Skins.BarText[s][j]["CLASSCOL"]=Healbot_Config_Skins.BarText[s][f]["CLASSCOL"]
                    Healbot_Config_Skins.BarText[s][j]["ALIGN"]=Healbot_Config_Skins.BarText[s][f]["ALIGN"]
                    Healbot_Config_Skins.BarText[s][j]["DOUBLE"]=Healbot_Config_Skins.BarText[s][f]["DOUBLE"]
                    Healbot_Config_Skins.BarText[s][j]["INCHEALS"]=Healbot_Config_Skins.BarText[s][f]["INCHEALS"]
                    Healbot_Config_Skins.BarText[s][j]["NUMFORMAT1"]=Healbot_Config_Skins.BarText[s][f]["NUMFORMAT1"]
                    Healbot_Config_Skins.BarText[s][j]["NUMFORMAT2"]=Healbot_Config_Skins.BarText[s][f]["NUMFORMAT2"]
                    Healbot_Config_Skins.BarText[s][j]["OUTLINE"]=Healbot_Config_Skins.BarText[s][f]["OUTLINE"]
                    Healbot_Config_Skins.BarText[s][j]["HLTHTYPE"]=Healbot_Config_Skins.BarText[s][f]["HLTHTYPE"]
                    Healbot_Config_Skins.BarText[s][j]["TAGDC"]=Healbot_Config_Skins.BarText[s][f]["TAGDC"]
                    Healbot_Config_Skins.BarText[s][j]["TAGRIP"]=Healbot_Config_Skins.BarText[s][f]["TAGRIP"]
                    Healbot_Config_Skins.BarText[s][j]["TAGOOR"]=Healbot_Config_Skins.BarText[s][f]["TAGOOR"]
                    Healbot_Config_Skins.BarText[s][j]["TAGR"]=Healbot_Config_Skins.BarText[s][f]["TAGR"]
                    Healbot_Config_Skins.BarText[s][j]["MAXCHARS"]=Healbot_Config_Skins.BarText[s][f]["MAXCHARS"]
                    Healbot_Config_Skins.BarText[s][j]["OFFSET"]=Healbot_Config_Skins.BarText[s][f]["OFFSET"]
                    Healbot_Config_Skins.BarTextCol[s][j]["ER"]=Healbot_Config_Skins.BarTextCol[s][f]["ER"]
                    Healbot_Config_Skins.BarTextCol[s][j]["EG"]=Healbot_Config_Skins.BarTextCol[s][f]["EG"]
                    Healbot_Config_Skins.BarTextCol[s][j]["EB"]=Healbot_Config_Skins.BarTextCol[s][f]["EB"]
                    Healbot_Config_Skins.BarTextCol[s][j]["EA"]=Healbot_Config_Skins.BarTextCol[s][f]["EA"]
                    Healbot_Config_Skins.BarTextCol[s][j]["DR"]=Healbot_Config_Skins.BarTextCol[s][f]["DR"]
                    Healbot_Config_Skins.BarTextCol[s][j]["DG"]=Healbot_Config_Skins.BarTextCol[s][f]["DG"]
                    Healbot_Config_Skins.BarTextCol[s][j]["DB"]=Healbot_Config_Skins.BarTextCol[s][f]["DB"]
                    Healbot_Config_Skins.BarTextCol[s][j]["DA"]=Healbot_Config_Skins.BarTextCol[s][f]["DA"]
                    Healbot_Config_Skins.BarTextCol[s][j]["CR"]=Healbot_Config_Skins.BarTextCol[s][f]["CR"]
                    Healbot_Config_Skins.BarTextCol[s][j]["CG"]=Healbot_Config_Skins.BarTextCol[s][f]["CG"]
                    Healbot_Config_Skins.BarTextCol[s][j]["CB"]=Healbot_Config_Skins.BarTextCol[s][f]["CB"]
                    Healbot_Config_Skins.BarTextCol[s][j]["CA"]=Healbot_Config_Skins.BarTextCol[s][f]["CA"]
                elseif HealBot_Options_StorePrev["CurrentSkinsBarsPanel"]=="HealBot_Options_SkinsFramesBarsSort" then
                    Healbot_Config_Skins.BarSort[s][j]["RAIDORDER"]=Healbot_Config_Skins.BarSort[s][f]["RAIDORDER"]
                    Healbot_Config_Skins.BarSort[s][j]["SUBORDER"]=Healbot_Config_Skins.BarSort[s][f]["SUBORDER"]
                    Healbot_Config_Skins.BarSort[s][j]["OORLAST"]=Healbot_Config_Skins.BarSort[s][f]["OORLAST"]
                    Healbot_Config_Skins.BarSort[s][j]["SUBPF"]=Healbot_Config_Skins.BarSort[s][f]["SUBPF"]
                elseif HealBot_Options_StorePrev["CurrentSkinsBarsPanel"]=="HealBot_Options_SkinsFramesBarsVisibility" then
                    Healbot_Config_Skins.BarVisibility[s][j]["HIDEOOR"]=Healbot_Config_Skins.BarVisibility[s][f]["HIDEOOR"]
                    Healbot_Config_Skins.BarVisibility[s][j]["INCCLASSES"]=Healbot_Config_Skins.BarVisibility[s][f]["INCCLASSES"]
                    Healbot_Config_Skins.BarVisibility[s][j]["ALERTIC"]=Healbot_Config_Skins.BarVisibility[s][f]["ALERTIC"]
                    Healbot_Config_Skins.BarVisibility[s][j]["ALERTOC"]=Healbot_Config_Skins.BarVisibility[s][f]["ALERTOC"]
                    Healbot_Config_Skins.IncludeGroup[s][j]=Healbot_Config_Skins.IncludeGroup[s][f]
                elseif HealBot_Options_StorePrev["CurrentSkinsBarsPanel"]=="HealBot_Options_SkinsFramesBarsAggro" then
                    Healbot_Config_Skins.BarAggro[s][j]["ALERT"]=Healbot_Config_Skins.BarAggro[s][f]["ALERT"]
                    Healbot_Config_Skins.BarAggro[s][j]["ALERTIND"]=Healbot_Config_Skins.BarAggro[s][f]["ALERTIND"]
                    Healbot_Config_Skins.BarAggro[s][j]["R"]=Healbot_Config_Skins.BarAggro[s][f]["R"]
                    Healbot_Config_Skins.BarAggro[s][j]["G"]=Healbot_Config_Skins.BarAggro[s][f]["G"]
                    Healbot_Config_Skins.BarAggro[s][j]["B"]=Healbot_Config_Skins.BarAggro[s][f]["B"]
                    Healbot_Config_Skins.BarAggro[s][j]["MAXA"]=Healbot_Config_Skins.BarAggro[s][f]["MAXA"]
                    Healbot_Config_Skins.BarAggro[s][j]["MINA"]=Healbot_Config_Skins.BarAggro[s][f]["MINA"]
                    Healbot_Config_Skins.BarAggro[s][j]["FREQ"]=Healbot_Config_Skins.BarAggro[s][f]["FREQ"]
                    Healbot_Config_Skins.BarAggro[s][j]["TEXTFORMAT"]=Healbot_Config_Skins.BarAggro[s][f]["TEXTFORMAT"]
                    Healbot_Config_Skins.BarAggro[s][j]["SHOWIND"]=Healbot_Config_Skins.BarAggro[s][f]["SHOWIND"]
                    Healbot_Config_Skins.BarAggro[s][j]["SHOW"]=Healbot_Config_Skins.BarAggro[s][f]["SHOW"]
                    Healbot_Config_Skins.BarAggro[s][j]["SHOWBARS"]=Healbot_Config_Skins.BarAggro[s][f]["SHOWBARS"]
                    Healbot_Config_Skins.BarAggro[s][j]["SHOWTEXT"]=Healbot_Config_Skins.BarAggro[s][f]["SHOWTEXT"]
                    Healbot_Config_Skins.BarAggro[s][j]["SHOWBARSPCT"]=Healbot_Config_Skins.BarAggro[s][f]["SHOWBARSPCT"]
                    Healbot_Config_Skins.BarAggro[s][j]["SHOWTEXTPCT"]=Healbot_Config_Skins.BarAggro[s][f]["SHOWTEXTPCT"]
                    Healbot_Config_Skins.BarHighlight[s][j]["CBAR"]=Healbot_Config_Skins.BarHighlight[s][f]["CBAR"]
                    Healbot_Config_Skins.BarHighlight[s][j]["CBARCOMBAT"]=Healbot_Config_Skins.BarHighlight[s][f]["CBARCOMBAT"]
                    Healbot_Config_Skins.BarHighlight[s][j]["TBAR"]=Healbot_Config_Skins.BarHighlight[s][f]["TBAR"]
                    Healbot_Config_Skins.BarHighlight[s][j]["TBARCOMBAT"]=Healbot_Config_Skins.BarHighlight[s][f]["TBARCOMBAT"]
                    Healbot_Config_Skins.BarHighlight[s][j]["CR"]=Healbot_Config_Skins.BarHighlight[s][f]["CR"]
                    Healbot_Config_Skins.BarHighlight[s][j]["CG"]=Healbot_Config_Skins.BarHighlight[s][f]["CG"]
                    Healbot_Config_Skins.BarHighlight[s][j]["CB"]=Healbot_Config_Skins.BarHighlight[s][f]["CB"]
                    Healbot_Config_Skins.BarHighlight[s][j]["TR"]=Healbot_Config_Skins.BarHighlight[s][f]["TR"]
                    Healbot_Config_Skins.BarHighlight[s][j]["TG"]=Healbot_Config_Skins.BarHighlight[s][f]["TG"]
                    Healbot_Config_Skins.BarHighlight[s][j]["TB"]=Healbot_Config_Skins.BarHighlight[s][f]["TB"]
                end
            elseif hbCurSkinSubFrameID==1014 then
                if HealBot_Options_StorePrev["CurrentSkinsIconsPanel"]=="HealBot_Options_SkinsFrameIconsGeneral" then
                    Healbot_Config_Skins.Icons[s][j]["ONBAR"]=Healbot_Config_Skins.Icons[s][f]["ONBAR"]
                    Healbot_Config_Skins.Icons[s][j]["POSITION"]=Healbot_Config_Skins.Icons[s][f]["POSITION"]
                    Healbot_Config_Skins.Icons[s][j]["DOUBLE"]=Healbot_Config_Skins.Icons[s][f]["DOUBLE"]
                    Healbot_Config_Skins.Icons[s][j]["SHOWDEBUFF"]=Healbot_Config_Skins.Icons[s][f]["SHOWDEBUFF"]
                    Healbot_Config_Skins.Icons[s][j]["SHOWRC"]=Healbot_Config_Skins.Icons[s][f]["SHOWRC"]
                    Healbot_Config_Skins.Icons[s][j]["SHOWDIR"]=Healbot_Config_Skins.Icons[s][f]["SHOWDIR"]
                    Healbot_Config_Skins.Icons[s][j]["SHOWDIRMOUSE"]=Healbot_Config_Skins.Icons[s][f]["SHOWDIRMOUSE"]
                    Healbot_Config_Skins.Icons[s][j]["SCALE"]=Healbot_Config_Skins.Icons[s][f]["SCALE"]
                    Healbot_Config_Skins.Icons[s][j]["DSCALE"]=Healbot_Config_Skins.Icons[s][f]["DSCALE"]
                    Healbot_Config_Skins.Icons[s][j]["I15EN"]=Healbot_Config_Skins.Icons[s][f]["I15EN"]
                    Healbot_Config_Skins.Icons[s][j]["SHOWBUFF"]=Healbot_Config_Skins.Icons[s][f]["SHOWBUFF"]
                    Healbot_Config_Skins.Icons[s][j]["FADE"]=Healbot_Config_Skins.Icons[s][f]["FADE"]
                    Healbot_Config_Skins.RaidIcon[s][j]["SHOW"]=Healbot_Config_Skins.RaidIcon[s][f]["SHOW"]
                    Healbot_Config_Skins.RaidIcon[s][j]["STAR"]=Healbot_Config_Skins.RaidIcon[s][f]["STAR"]
                    Healbot_Config_Skins.RaidIcon[s][j]["CIRCLE"]=Healbot_Config_Skins.RaidIcon[s][f]["CIRCLE"]
                    Healbot_Config_Skins.RaidIcon[s][j]["DIAMOND"]=Healbot_Config_Skins.RaidIcon[s][f]["DIAMOND"]
                    Healbot_Config_Skins.RaidIcon[s][j]["TRIANGLE"]=Healbot_Config_Skins.RaidIcon[s][f]["TRIANGLE"]
                    Healbot_Config_Skins.RaidIcon[s][j]["MOON"]=Healbot_Config_Skins.RaidIcon[s][f]["MOON"]
                    Healbot_Config_Skins.RaidIcon[s][j]["SQUARE"]=Healbot_Config_Skins.RaidIcon[s][f]["SQUARE"]
                    Healbot_Config_Skins.RaidIcon[s][j]["CROSS"]=Healbot_Config_Skins.RaidIcon[s][f]["CROSS"]
                    Healbot_Config_Skins.RaidIcon[s][j]["SKULL"]=Healbot_Config_Skins.RaidIcon[s][f]["SKULL"]
                elseif HealBot_Options_StorePrev["CurrentSkinsIconsPanel"]=="HealBot_Options_SkinsFrameIconsText" then
                    Healbot_Config_Skins.IconText[s][j]["SCNT"]=Healbot_Config_Skins.IconText[s][f]["SCNT"]
                    Healbot_Config_Skins.IconText[s][j]["SSCNT"]=Healbot_Config_Skins.IconText[s][f]["SSCNT"]
                    Healbot_Config_Skins.IconText[s][j]["SDUR"]=Healbot_Config_Skins.IconText[s][f]["SDUR"]
                    Healbot_Config_Skins.IconText[s][j]["SSDUR"]=Healbot_Config_Skins.IconText[s][f]["SSDUR"]
                    Healbot_Config_Skins.IconText[s][j]["HEIGHT"]=Healbot_Config_Skins.IconText[s][f]["HEIGHT"]
                    Healbot_Config_Skins.IconText[s][j]["FONT"]=Healbot_Config_Skins.IconText[s][f]["FONT"]
                    Healbot_Config_Skins.IconText[s][j]["OUTLINE"]=Healbot_Config_Skins.IconText[s][f]["OUTLINE"]
                    Healbot_Config_Skins.IconText[s][j]["DURTHRH"]=Healbot_Config_Skins.IconText[s][f]["DURTHRH"]
                    Healbot_Config_Skins.IconText[s][j]["DURWARN"]=Healbot_Config_Skins.IconText[s][f]["DURWARN"]
                end
            end
        end
    end
    HealBot_setOptions_Timer(150)
end

--------------------------------------------------------------------------------
local function HealBot_Options_ManaIndicator_DropDown(dropDown, level, menuList)
    local info = UIDropDownMenu_CreateInfo()
    if HealBot_Options_StorePrev["FramesSelFrame"]>9 then
        info.text = " "
        UIDropDownMenu_AddButton(info);
    else
        for j=1, getn(HealBot_Options_ManaIndicator_List), 1 do
            info.text = HealBot_Options_ManaIndicator_List[j];
         --   info.func = HealBot_Options_ManaIndicator_OnSelect;
            info.func = function(self)
                            Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["LOWMANA"] = self:GetID()
                            UIDropDownMenu_SetSelectedID(HealBot_Options_ManaIndicator,Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["LOWMANA"]) 
                            HealBot_setOptions_Timer(4910)
                        end
            info.checked = false;
            if Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["LOWMANA"]==j then info.checked = true end
            UIDropDownMenu_AddButton(info);
        end
    end
end

function HealBot_Options_DoManaIndicator_DropDown()
    HealBot_Options_ManaIndicator.initialize = HealBot_Options_ManaIndicator_DropDown
    if HealBot_Options_StorePrev["FramesSelFrame"]>9 then
        UIDropDownMenu_SetText(HealBot_Options_ManaIndicator, " ")
    else
        UIDropDownMenu_SetText(HealBot_Options_ManaIndicator, HealBot_Options_ManaIndicator_List[Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["LOWMANA"]])
    end
end
--------------------------------------------------------------------------------

HealBot_Options_StorePrev["FilterHoTctlName"]=HealBot_Options_FilterHoTctl_List[1]
HealBot_Options_StorePrev["FilterHoTctlNameTrim"]=HealBot_Class_En[HealBot_Options_StorePrev["FilterHoTctlName"]]
HealBot_Options_StorePrev["FilterHoTctlID"]=1
HealBot_Options_StorePrev["HoTindex"]=1
HealBot_Options_StorePrev["HoTname"]=""

function HealBot_Options_Class_HoTctlName_genList()
--    local class=nil
    local tmpHoTctlName_List={}

    local hbClassHoTwatch=HealBot_Globals.WatchHoT
    for xClass,_  in pairs(hbClassHoTwatch) do
        if HealBot_Class_En[HealBot_Options_StorePrev["FilterHoTctlName"]]==xClass then
            local HealBot_configClassHoTClass=HealBot_Globals.WatchHoT[xClass]
            for bId,_  in pairs(HealBot_configClassHoTClass) do
                local bName=HealBot_Options_CDebuffTextID(bId) or " "
                if tonumber(bName) == nil then
                    table.insert(tmpHoTctlName_List, bName)
                else
                    HealBot_Options_DeleteBuffHoT(xClass, bId)
                end
            end
        end
    end    
    table.sort(tmpHoTctlName_List)
    local x=nil
    for j=1, getn(tmpHoTctlName_List), 1 do
        if tmpHoTctlName_List[j]==HealBot_Options_StorePrev["HoTname"] then
            HealBot_Options_StorePrev["HoTindex"]=j
            x=true
            break
        end
    end
    if not x then HealBot_Options_StorePrev["HoTindex"]=1 end
    HealBot_Options_StorePrev["HoTname"]=tmpHoTctlName_List[HealBot_Options_StorePrev["HoTindex"]]
    return tmpHoTctlName_List
end

function HealBot_Options_SpellGetName(id)
    local sName=id
    local sId=HealBot_Options_CDebuffGetId(id)
    if sId then
        local name, _, _, _, _, _, spellId = GetSpellInfo(sId)
        if name and spellId then sName=name end
    end
    return sName
end

function HealBot_Options_ResetBuff()
    local sId=HealBot_Options_CDebuffGetId(HealBot_Options_StorePrev["HoTname"])
    if sId then
        local sName=HealBot_Options_SpellGetName(sId)
        HealBot_Options_DeleteBuffHoTBtn_OnClick()
        HealBot_Options_NewHoTBuffBtn_OnClick(sName)
        HealBot_Options_InitSub(502)
        HealBot_SetBuffBarColours();
    end
end

HealBot_Options_StorePrev["numCustomBuffs"]=0
function HealBot_Options_BuffCatNameUpdate()
    if HealBot_Options_StorePrev["numCustomBuffs"]>0 then
        HealBot_Options_DeleteBuffHoTBtn:Enable();
        HealBot_Options_ResetBuffBtn:Enable();
        HealBot_BuffCustomColorpickb:Enable()
        HealBot_Options_BuffHoTPresetColour:Enable()
        HealBot_Options_HoTctlActionCustom:Hide()
        HealBot_Options_BuffPriorityCustom:Hide()
        HealBot_Options_Class_HoTctlAction:Show()
        HealBot_Options_BuffPriorityC:Show()
        HealBot_Options_CustomBuffCol_OnOff:Show()
    else
        HealBot_Options_DeleteBuffHoTBtn:Disable();
        HealBot_Options_ResetBuffBtn:Disable();
        HealBot_BuffCustomColorpickb:Disable()
        HealBot_Options_BuffHoTPresetColour:Disable()
        HealBot_Options_Class_HoTctlAction:Hide()
        HealBot_Options_BuffPriorityC:Hide()
        HealBot_Options_CustomBuffCol_OnOff:Hide()
        HealBot_Options_HoTctlActionCustom:Show()
        HealBot_Options_BuffPriorityCustom:Show()
    end
end

function HealBot_Options_Class_HoTctlName_DropDown(self, level, menuList)
    local info = UIDropDownMenu_CreateInfo()
    local HoTctlName_List = HealBot_Options_Class_HoTctlName_genList()
    if getn(HoTctlName_List) > 10 then
        if level == 1 then
            for j=1, ceil(getn(HoTctlName_List)/10), 1 do
                local n=j*10
                if n > getn(HoTctlName_List) then n=getn(HoTctlName_List) end
                info.text = ((j*10)-9).." - "..n;
                info.hasArrow = true
                info.menuList = j, true, j
                UIDropDownMenu_AddButton(info)
            end
        else 
            local n=menuList*10
            if n > getn(HoTctlName_List) then n=getn(HoTctlName_List) end
            for j=((menuList*10)-9), n, 1 do
                info.text = HoTctlName_List[j];
                info.func = function(self)
                                HealBot_Options_StorePrev["HoTindex"] = self:GetID()
                                HealBot_Options_StorePrev["HoTname"] = self:GetText()
                                UIDropDownMenu_SetText(HealBot_Options_Class_HoTctlName, HealBot_Options_StorePrev["HoTname"])
                                HealBot_Options_InitSub(502)
                            end
                info.checked = false;
                if HealBot_Options_StorePrev["HoTname"]==HoTctlName_List[j] then info.checked = true; end
                UIDropDownMenu_AddButton(info, level);
            end
        end
    else
        for j=1, getn(HoTctlName_List), 1 do
            info.text = HoTctlName_List[j];
            info.func = function(self)
                            HealBot_Options_StorePrev["HoTindex"] = self:GetID()
                            HealBot_Options_StorePrev["HoTname"] = self:GetText()
                            UIDropDownMenu_SetText(HealBot_Options_Class_HoTctlName, HealBot_Options_StorePrev["HoTname"])
                            HealBot_Options_InitSub(502)
                        end
            info.checked = false;
            if HealBot_Options_StorePrev["HoTname"]==HoTctlName_List[j] then info.checked = true; end
            UIDropDownMenu_AddButton(info);
        end
    end
end

--------------------------------------------------------------------------------

function HealBot_Options_Class_HoTctlAction_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_Class_HoTctlAction_List), 1 do
        local hbText = nil
        if HealBot_Options_StorePrev["FilterHoTctlName"]~=HEALBOT_CLASSES_ALL then
            if j==4 then -- was 3
                hbText=HEALBOT_CUSTOM_CASTBY_FRIEND
            elseif j<3 then -- was 3
                hbText=HealBot_Options_Class_HoTctlAction_List[j];
            end
        else
            hbText=HealBot_Options_Class_HoTctlAction_List[j];
        end
        if hbText then
            info.text = hbText
            info.func = function(self)
                            local y=self:GetID()
                            if HealBot_Options_StorePrev["FilterHoTctlName"]~=HEALBOT_CLASSES_ALL and y==3 then y=4 end
                            
                            local sId=HealBot_Options_CDebuffGetId(HealBot_Options_StorePrev["HoTname"])
                            HealBot_Globals.WatchHoT[HealBot_Options_StorePrev["FilterHoTctlNameTrim"]][sId]=y 
                            UIDropDownMenu_SetText(HealBot_Options_Class_HoTctlAction,hbText) 
                            HealBot_setOptions_Timer(170)
                        end
            info.checked = false;
            if HealBot_Options_StorePrev["FilterHoTctlNameTrim"] and HealBot_Globals.WatchHoT[HealBot_Options_StorePrev["FilterHoTctlNameTrim"]] then
                local sId=HealBot_Options_CDebuffGetId(HealBot_Options_StorePrev["HoTname"])
                local x=HealBot_Globals.WatchHoT[HealBot_Options_StorePrev["FilterHoTctlNameTrim"]][sId] or 1
                if x==j then info.checked = true; end 
            end
            UIDropDownMenu_AddButton(info);
        end
    end
    HealBot_Options_BuffCatNameUpdate()
end

--------------------------------------------------------------------------------

function HealBot_Options_FilterHoTctl_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    table.sort(HealBot_Options_FilterHoTctl_List)
    for j=1, getn(HealBot_Options_FilterHoTctl_List), 1 do
        info.text = HealBot_Options_FilterHoTctl_List[j];
        info.func = function(self)
                        HealBot_Options_StorePrev["FilterHoTctlName"]=self.value
                        HealBot_Options_StorePrev["FilterHoTctlID"]=self:GetID()
                        HealBot_Options_StorePrev["FilterHoTctlNameTrim"]=HealBot_Class_En[HealBot_Options_StorePrev["FilterHoTctlName"]]
                        UIDropDownMenu_SetText(HealBot_Options_FilterHoTctl,HealBot_Options_StorePrev["FilterHoTctlName"]) 
                        HealBot_Options_InitSub(502)
                    end
        info.checked = false;
        if HealBot_Options_StorePrev["FilterHoTctlName"]==HealBot_Options_FilterHoTctl_List[j] then info.checked = true; end
        UIDropDownMenu_AddButton(info);
    end
end


HealBot_Options_StorePrev["custombufftextpage"]=1
function HealBot_Options_setCustomBuffList()
    local customPriority = {}
    local customListPos=0
    local textname=nil
    local cusPrio=nil
    local hbClassHoTwatch=HealBot_Globals.WatchHoT
    for xClass,_  in pairs(hbClassHoTwatch) do
        local HealBot_configClassHoTClass=HealBot_Globals.WatchHoT[xClass]
        for bID,_  in pairs(HealBot_configClassHoTClass) do
            local bName=HealBot_Options_CDebuffTextID(bID)
            if tonumber(bName) == nil then
                cusPrio=HealBot_Globals.HealBot_Custom_Buffs[bID] or 10
                if not customPriority[cusPrio] then customPriority[cusPrio]={} end
                customPriority[cusPrio][bID]=bID
            else
                HealBot_Options_DeleteBuffHoT(xClass, bID)
            end
        end
    end
    local startEntry=((HealBot_Options_StorePrev["custombufftextpage"]-1)*30)
    local endEntry=HealBot_Options_StorePrev["custombufftextpage"]*30
    local pageNext=false
    for j=1,20 do
        if customPriority[j] then
            for z, bName in pairs(customPriority[j]) do
                customListPos=customListPos+1
                bName=HealBot_Options_CDebuffTextID(bName) or " "
                if customListPos>startEntry and customListPos<endEntry+1 then
                    local r,g,b=0,0,0
                    textname=_G["HealBot_Options_CustomBuff_List"..(customListPos-startEntry)]
                    if j<10 then
                        textname:SetText("0"..j.." - "..bName)
                    else
                        textname:SetText(j.." - "..bName)
                    end
                    if HealBot_Globals.CustomBuffBarColour[z] then
                        r=HealBot_Globals.CustomBuffBarColour[z].R or 0.45
                        g=HealBot_Globals.CustomBuffBarColour[z].G or 0
                        b=HealBot_Globals.CustomBuffBarColour[z].B or 0.26
                    else
                        local customDebuffPriority=HEALBOT_CUSTOM_en.."Buff"
                        r=HealBot_Globals.CustomBuffBarColour[customDebuffPriority].R or 0.45
                        g=HealBot_Globals.CustomBuffBarColour[customDebuffPriority].G or 0
                        b=HealBot_Globals.CustomBuffBarColour[customDebuffPriority].B or 0.26
                    end
                    if r<0.2 and g<0.2 and b<0.2 then
                        r=r+0.4
                        g=g+0.4
                        b=b+0.4
                    elseif r<0.3 and g<0.3 and b<0.3 then
                        r=r+0.3
                        g=g+0.3
                        b=b+0.3
                    elseif r<0.4 and g<0.4 and b<0.4 then
                        r=r+0.2
                        g=g+0.2
                        b=b+0.2
                    elseif r<0.5 and g<0.5 and b<0.5 then
                        r=r+0.1
                        g=g+0.1
                        b=b+0.1
                    end
                    textname:SetTextColor(r,g,b,1)
                elseif customListPos>endEntry then
                    pageNext=true
                end
            end
        end
    end
    if pageNext then
        HealBot_Options_PageNextCBuffBtn:Enable()
    else
        HealBot_Options_PageNextCBuffBtn:Disable()
    end
    if HealBot_Options_StorePrev["custombufftextpage"]==1 then
        HealBot_Options_PagePrevCBuffBtn:Disable()
    end
    customListPos=customListPos+1
    for j=(customListPos-startEntry),30 do
        textname=_G["HealBot_Options_CustomBuff_List"..j]
        textname:SetText(" ")
    end

    g=_G["HealBot_Options_PageCBuff"]
    g:SetText(HEALBOT_OPTIONS_PAGE.." "..HealBot_Options_StorePrev["custombufftextpage"])
end

function HealBot_Options_PageNextCBuff()
    HealBot_Options_StorePrev["custombufftextpage"]=HealBot_Options_StorePrev["custombufftextpage"]+1
    HealBot_Options_PagePrevCBuffBtn:Enable()
    HealBot_Options_setCustomBuffList()
end

function HealBot_Options_PagePrevCBuff()
    if HealBot_Options_StorePrev["custombufftextpage"]>1 then
        HealBot_Options_StorePrev["custombufftextpage"]=HealBot_Options_StorePrev["custombufftextpage"]-1
    end
    HealBot_Options_setCustomBuffList()
end
--------------------------------------------------------------------------------

function HealBot_Options_AggroAlertLevel_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_AggroAlertLevel_List), 1 do
        info.text = HealBot_Options_AggroAlertLevel_List[j];
        info.func = function(self)
                        Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["ALERT"]=self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_AggroAlertLevel,HealBot_Options_AggroAlertLevel_List[Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["ALERT"]]) 
                    end
        info.checked = false;
        if Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["ALERT"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_AggroIndAlertLevel_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_AggroIndAlertLevel_List), 1 do
        info.text = HealBot_Options_AggroIndAlertLevel_List[j];
        info.func = function(self)
                        Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["ALERTIND"]=self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_AggroIndAlertLevel,HealBot_Options_AggroIndAlertLevel_List[Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["ALERTIND"]]) 
                    end
        info.checked = false;
        if Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["ALERTIND"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

--------------------------------------------------------------------------------

function HealBot_Options_EmergencyFilter_DropDown()
    local info = UIDropDownMenu_CreateInfo()    
    if HealBot_Options_StorePrev["FramesSelFrame"]>7 then
        info.text = " "
        UIDropDownMenu_AddButton(info);
    else
        for j=1, getn(HealBot_Options_EmergencyFilter_List), 1 do
            info.text = HealBot_Options_EmergencyFilter_List[j];
            info.func = function(self)
                            Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["INCCLASSES"] = self:GetID()
                            UIDropDownMenu_SetText(HealBot_Options_EmergencyFilter,HealBot_Options_EmergencyFilter_List[Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["INCCLASSES"]]) 
                            HealBot_setOptions_Timer(60)
                        end
            info.checked = false;
            if Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["INCCLASSES"]==j then info.checked = true end
            UIDropDownMenu_AddButton(info);
        end
    end
end

function HealBot_Options_DoVisibility_DropDowns()
    HealBot_Options_EmergencyFilter.initialize = HealBot_Options_EmergencyFilter_DropDown            
    HealBot_Options_FocusInCombat.initialize = HealBot_Options_FocusInCombat_DropDown
    HealBot_Options_TargetInCombat.initialize = HealBot_Options_TargetInCombat_DropDown
    if HealBot_Options_StorePrev["FramesSelFrame"]>7 then
        UIDropDownMenu_SetText(HealBot_Options_EmergencyFilter, " ")
        if HealBot_Options_StorePrev["FramesSelFrame"]==8 then
            UIDropDownMenu_SetText(HealBot_Options_TargetInCombat,HealBot_Options_TargetFocusInCombat_List[Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TARGETINCOMBAT"]]) 
        else
            UIDropDownMenu_SetText(HealBot_Options_TargetInCombat," ")
        end
        if HealBot_Options_StorePrev["FramesSelFrame"]==9 then
            UIDropDownMenu_SetText(HealBot_Options_FocusInCombat,HealBot_Options_TargetFocusInCombat_List[Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["FOCUSINCOMBAT"]]) 
        else
            UIDropDownMenu_SetText(HealBot_Options_FocusInCombat," ")
        end
    else
        UIDropDownMenu_SetText(HealBot_Options_EmergencyFilter, HealBot_Options_EmergencyFilter_List[Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["INCCLASSES"]])
        UIDropDownMenu_SetText(HealBot_Options_TargetInCombat," ")
        UIDropDownMenu_SetText(HealBot_Options_FocusInCombat," ")
    end
end

function HealBot_Options_EmergencyFilter_Reset()
    for j=1, 7 do 
        HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_DRUID]] = false;
        HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_HUNTER]] = false;
        HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_MAGE]] = false;
        HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_PALADIN]] = false;
        HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_PRIEST]] = false;
        HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_ROGUE]] = false;
        HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_SHAMAN]] = false;
        HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_WARLOCK]] = false;
        HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_WARRIOR]] = false;
        HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_DEATHKNIGHT]] = false;
        HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_DEMONHUNTER]] = false;
        if Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][j]["INCCLASSES"]==1 then
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_DRUID]] = true;
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_HUNTER]] = true;
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_MAGE]] = true;
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_PALADIN]] = true;
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_PRIEST]] = true;
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_ROGUE]] = true;
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_SHAMAN]] = true;
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_WARLOCK]] = true;
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_WARRIOR]] = true;
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_DEATHKNIGHT]] = true;
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_DEMONHUNTER]] = true;
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_MONK]] = true;
        elseif Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][j]["INCCLASSES"]==2 then
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_DEATHKNIGHT]] = true;
        elseif Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][j]["INCCLASSES"]==3 then
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_DRUID]] = true;
        elseif Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][j]["INCCLASSES"]==4 then
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_HUNTER]] = true;
        elseif Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][j]["INCCLASSES"]==5 then
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_MAGE]] = true;
        elseif Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][j]["INCCLASSES"]==6 then
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_MONK]] = true;
        elseif Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][j]["INCCLASSES"]==7 then
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_PALADIN]] = true;
        elseif Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][j]["INCCLASSES"]==8 then
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_PRIEST]] = true;
        elseif Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][j]["INCCLASSES"]==9 then
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_ROGUE]] = true;
        elseif Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][j]["INCCLASSES"]==10 then
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_SHAMAN]] = true;
        elseif Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][j]["INCCLASSES"]==11 then
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_WARLOCK]] = true;
        elseif Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][j]["INCCLASSES"]==12 then
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_WARRIOR]] = true;
        elseif Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][j]["INCCLASSES"]==13 then
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_DRUID]] = HealBot_Globals.EmergIncMelee[HEALBOT_DRUID];
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_HUNTER]] = HealBot_Globals.EmergIncMelee[HEALBOT_HUNTER];
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_MAGE]] = HealBot_Globals.EmergIncMelee[HEALBOT_MAGE];
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_PALADIN]] = HealBot_Globals.EmergIncMelee[HEALBOT_PALADIN];
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_PRIEST]] = HealBot_Globals.EmergIncMelee[HEALBOT_PRIEST];
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_ROGUE]] = HealBot_Globals.EmergIncMelee[HEALBOT_ROGUE];
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_SHAMAN]] = HealBot_Globals.EmergIncMelee[HEALBOT_SHAMAN];
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_WARLOCK]] = HealBot_Globals.EmergIncMelee[HEALBOT_WARLOCK];
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_WARRIOR]] = HealBot_Globals.EmergIncMelee[HEALBOT_WARRIOR];
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_DEATHKNIGHT]] = HealBot_Globals.EmergIncMelee[HEALBOT_DEATHKNIGHT];
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_DEMONHUNTER]] = HealBot_Globals.EmergIncMelee[HEALBOT_DEMONHUNTER];
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_MONK]] = HealBot_Globals.EmergIncMelee[HEALBOT_MONK];
        elseif Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][j]["INCCLASSES"]==14 then
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_DRUID]] = HealBot_Globals.EmergIncRange[HEALBOT_DRUID];
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_HUNTER]] = HealBot_Globals.EmergIncRange[HEALBOT_HUNTER];
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_MAGE]] = HealBot_Globals.EmergIncRange[HEALBOT_MAGE];
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_PALADIN]] = HealBot_Globals.EmergIncRange[HEALBOT_PALADIN];
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_PRIEST]] = HealBot_Globals.EmergIncRange[HEALBOT_PRIEST];
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_ROGUE]] = HealBot_Globals.EmergIncRange[HEALBOT_ROGUE];
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_SHAMAN]] = HealBot_Globals.EmergIncRange[HEALBOT_SHAMAN];
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_WARLOCK]] = HealBot_Globals.EmergIncRange[HEALBOT_WARLOCK];
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_WARRIOR]] = HealBot_Globals.EmergIncRange[HEALBOT_WARRIOR];
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_DEATHKNIGHT]] = HealBot_Globals.EmergIncRange[HEALBOT_DEATHKNIGHT];
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_DEMONHUNTER]] = HealBot_Globals.EmergIncRange[HEALBOT_DEMONHUNTER];
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_MONK]] = HealBot_Globals.EmergIncRange[HEALBOT_MONK];
        elseif Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][j]["INCCLASSES"]==15 then
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_DRUID]] = HealBot_Globals.EmergIncHealers[HEALBOT_DRUID];
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_HUNTER]] = HealBot_Globals.EmergIncHealers[HEALBOT_HUNTER];
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_MAGE]] = HealBot_Globals.EmergIncHealers[HEALBOT_MAGE];
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_PALADIN]] = HealBot_Globals.EmergIncHealers[HEALBOT_PALADIN];
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_PRIEST]] = HealBot_Globals.EmergIncHealers[HEALBOT_PRIEST];
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_ROGUE]] = HealBot_Globals.EmergIncHealers[HEALBOT_ROGUE];
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_SHAMAN]] = HealBot_Globals.EmergIncHealers[HEALBOT_SHAMAN];
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_WARLOCK]] = HealBot_Globals.EmergIncHealers[HEALBOT_WARLOCK];
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_WARRIOR]] = HealBot_Globals.EmergIncHealers[HEALBOT_WARRIOR];
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_DEATHKNIGHT]] = HealBot_Globals.EmergIncHealers[HEALBOT_DEATHKNIGHT];
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_DEMONHUNTER]] = HealBot_Globals.EmergIncHealers[HEALBOT_DEMONHUNTER];
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_MONK]] = HealBot_Globals.EmergIncHealers[HEALBOT_MONK];
        elseif Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][j]["INCCLASSES"]==16 then
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_DRUID]] = HealBot_Globals.EmergIncCustom[HEALBOT_DRUID];
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_HUNTER]] = HealBot_Globals.EmergIncCustom[HEALBOT_HUNTER];
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_MAGE]] = HealBot_Globals.EmergIncCustom[HEALBOT_MAGE];
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_PALADIN]] = HealBot_Globals.EmergIncCustom[HEALBOT_PALADIN];
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_PRIEST]] = HealBot_Globals.EmergIncCustom[HEALBOT_PRIEST];
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_ROGUE]] = HealBot_Globals.EmergIncCustom[HEALBOT_ROGUE];
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_SHAMAN]] = HealBot_Globals.EmergIncCustom[HEALBOT_SHAMAN];
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_WARLOCK]] = HealBot_Globals.EmergIncCustom[HEALBOT_WARLOCK];
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_WARRIOR]] = HealBot_Globals.EmergIncCustom[HEALBOT_WARRIOR];
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_DEATHKNIGHT]] = HealBot_Globals.EmergIncCustom[HEALBOT_DEATHKNIGHT];
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_DEMONHUNTER]] = HealBot_Globals.EmergIncCustom[HEALBOT_DEMONHUNTER];
            HealBot_EmergInc[j][HealBot_Class_En[HEALBOT_MONK]] = HealBot_Globals.EmergIncCustom[HEALBOT_MONK];
        end
    end
    HealBot_setOptions_Timer(580)
end

function HealBot_Options_retEmergInc(classTrim, frame)
    return HealBot_EmergInc[frame][classTrim]
end
--------------------------------------------------------------------------------

function HealBot_Options_Skins_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(Healbot_Config_Skins.Skins), 1 do
        info.text = Healbot_Config_Skins.Skins[j];
        info.func = function(self)
                        Healbot_Config_Skins.Skin_ID = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_Skins,Healbot_Config_Skins.Skins[Healbot_Config_Skins.Skin_ID])
                        if self:GetID()>=1 then HealBot_Options_Set_Current_Skin(self:GetText(), true) end
                    end
        info.checked = false;
        if Healbot_Config_Skins.Skin_ID==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_Set_Current_Skin(newSkin, ddRefresh, noCallback)
    if newSkin then
        HealBot_Panel_resetInitFrames()
        HealBot_Config.LastAutoSkinChangeTime=GetTime()+300
        local hbFoundSkin=nil
        local hbValidSkins=nil
        for j=1, getn(Healbot_Config_Skins.Skins), 1 do
            if newSkin==Healbot_Config_Skins.Skins[j] then
                hbFoundSkin=true
                Healbot_Config_Skins.Skin_ID = j
                Healbot_Config_Skins.Current_Skin = Healbot_Config_Skins.Skins[j]
                HealBot_RaidTargetToggle(nil) 
                HealBot_Panel_ClearBarArrays()
                HealBot_Action_ResetSkin("init")
                HealBot_Options_Frame_initCurFrame()
                local doRaidTargetToggle=false
                for gl=1,10 do
                    if Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][gl]["SHOW"] then 
                        doRaidTargetToggle=true
                    end
                end
                if doRaidTargetToggle then HealBot_RaidTargetToggle(true) end
            end
            if hbValidSkins then
                hbValidSkins=hbValidSkins.."  +  "..Healbot_Config_Skins.Skins[j]
            else
                hbValidSkins=Healbot_Config_Skins.Skins[j]
            end
        end
        if not hbFoundSkin then
            if newSkin~="_-none-_" then
                HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_CHANGESKINERR1..newSkin)
                if hbValidSkins then HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_CHANGESKINERR2..hbValidSkins) end
            end
            if not Healbot_Config_Skins.Author[Healbot_Config_Skins.Current_Skin] then 
                local retryWithSkin = HealBot_getDefaultSkin()
                if not noCallback then
                    HealBot_Options_Set_Current_Skin(retryWithSkin, nil, true)
                elseif newSkin~=HEALBOT_SKINS_STD then
                    HealBot_Options_Set_Current_Skin(HEALBOT_SKINS_STD, nil, true)
                end
            end
        else
            HealBot_setOptions_Timer(180)
            HealBot_setOptions_Timer(185)
            HealBot_setOptions_Timer(188)
            --HealBot_SetResetFlag("SOFT")
        end
    elseif not Healbot_Config_Skins.Author[Healbot_Config_Skins.Current_Skin] then 
        local retryWithSkin = HealBot_getDefaultSkin()
        if not noCallback then
            HealBot_Options_Set_Current_Skin(retryWithSkin, nil, true)
        elseif newSkin~=HEALBOT_SKINS_STD then
            HealBot_Options_Set_Current_Skin(HEALBOT_SKINS_STD, nil, true)
        end
    end
    if Healbot_Config_Skins.Author[Healbot_Config_Skins.Current_Skin] then
        HealBot_useCrashProtection()
        if not ddRefresh then
            DoneInitTab[305]=nil
            HealBot_Options_InitSub(305)
        end
        HealBot_Action_ResetrCalls()
        HealBot_setLuVars("TargetNeedReset", true)
        HealBot_setLuVars("FocusNeedReset", true)
        HealBot_nextRecalcParty(0)
        HealBot_AddDebug("Set_Current_Skin")
    else
        HealBot_setResetFlagCode(3)
    end
end

--------------------------------------------------------------------------------
HealBot_Options_StorePrev["InOutSkin"]=1
HealBot_Options_StorePrev["hbTempNumUnitNames"]=0
local hbMyGuildMates = {}
local hbMyFriends = {}

function HealBot_Options_setMyFriends(unitName)
    if hbMyGuildMates[unitName] or unitName==HealBot_Data["PNAME"] then return end
    hbMyFriends[unitName]=true
end

function HealBot_Options_setMyGuildMates(unitName)
    if hbMyFriends[unitName] or unitName==HealBot_Data["PNAME"] then return end
    hbMyGuildMates[unitName]=true
end

HealBot_Options_StorePrev["InOutSkin"]=1
function HealBot_Options_InOutSkin_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(Healbot_Config_Skins.Skins), 1 do
        info.text = Healbot_Config_Skins.Skins[j];
        info.func = function(self)
                        HealBot_Options_StorePrev["InOutSkin"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_InOutSkin,Healbot_Config_Skins.Skins[HealBot_Options_StorePrev["InOutSkin"]])
                    end
        info.checked = false;
        if HealBot_Options_StorePrev["InOutSkin"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

HealBot_Options_StorePrev["InMethodSpell"]=2
function HealBot_Options_ImportMethodSpells_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Import_Methods_List), 1 do
        info.text = HealBot_Import_Methods_List[j];
        info.func = function(self)
                        HealBot_Options_StorePrev["InMethodSpell"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_ImportMethodSpells,HealBot_Import_Methods_List[HealBot_Options_StorePrev["InMethodSpell"]])
                    end
        info.checked = false;
        if HealBot_Options_StorePrev["InMethodSpell"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

HealBot_Options_StorePrev["InMethodBuff"]=2
function HealBot_Options_ImportMethodBuffs_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Import_Methods_List), 1 do
        info.text = HealBot_Import_Methods_List[j];
        info.func = function(self)
                        HealBot_Options_StorePrev["InMethodBuff"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_ImportMethodBuffs,HealBot_Import_Methods_List[HealBot_Options_StorePrev["InMethodBuff"]])
                    end
        info.checked = false;
        if HealBot_Options_StorePrev["InMethodBuff"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

HealBot_Options_StorePrev["InMethodCDbuff"]=2
function HealBot_Options_ImportMethodCDebuff_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Import_Methods_List), 1 do
        info.text = HealBot_Import_Methods_List[j];
        info.func = function(self)
                        HealBot_Options_StorePrev["InMethodCDbuff"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_ImportMethodCDebuff,HealBot_Import_Methods_List[HealBot_Options_StorePrev["InMethodCDbuff"]])
                    end
        info.checked = false;
        if HealBot_Options_StorePrev["InMethodCDbuff"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_ShareSkinb_OnClick()
    HealBot_Options_BuildSkinSendMsg(Healbot_Config_Skins.Skins[HealBot_Options_StorePrev["InOutSkin"]])
end

function HealBot_Options_LoadSkinb_OnClick()
    HealBot_Options_ShareSkinLoad()
end

local hbWarnSharedMedia=false

function HealBot_Options_SharePresetColsb_OnClick()
    local ssStr="PresetCols\n"
    for x=1,10 do
        local alias=HealBot_Globals.PresetColoursAlias[x] or ""
        if strlen(alias)<1 then alias=HEALBOT_OPTIONS_PRESET.." "..x end
        ssStr=ssStr..alias.."~"
        ssStr=ssStr..HealBot_Globals.PresetColours[x]["R"]..","
        ssStr=ssStr..HealBot_Globals.PresetColours[x]["G"]..","
        ssStr=ssStr..HealBot_Globals.PresetColours[x]["B"]..","
        ssStr=ssStr..HealBot_Globals.PresetColours[x]["A"].."\n"
    end
    HealBot_Options_SharePresetColsExternalEditBox:SetText(ssStr)
end

function HealBot_Options_LoadPresetColsb_OnClick()
    local sStr=HealBot_Options_SharePresetColsExternalEditBox:GetText()
    local ssTab={}
    local i=0
    for l in string.gmatch(sStr, "[^\n]+") do
        local t=(string.gsub(l, "^%s*(.-)%s*$", "%1"))
        if string.len(t)>1 then
            i=i+1
            ssTab[i]=t
        end
    end
    if i>0 then
        if ssTab[1]~="PresetCols" then
            HealBot_Options_ImportFail("Preset Colours", "Header is incorrect - expecting PresetCols")
        else
            -- Test~0.2,0.2,0.902,1
            for e=2,#ssTab do 
                local x=e-1
                if x>10 then break end
                local alias,d = string.split("~", ssTab[e])
                local r,g,b,a=string.split(",", d)
                HealBot_Globals.PresetColoursAlias[x]=alias
                HealBot_Globals.PresetColours[x]["R"]=r
                HealBot_Globals.PresetColours[x]["G"]=g
                HealBot_Globals.PresetColours[x]["B"]=b
                HealBot_Globals.PresetColours[x]["A"]=a
            end
        end
    end
    DoneInitTab[103]=nil
    HealBot_Options_InitSub(103)
end

local hbInOut_SpellCmds={[HEALBOT_DISABLED_TARGET]=1,
                         [HEALBOT_ASSIST]=2,
                         [HEALBOT_FOCUS]=3,
                         [HEALBOT_MENU]=4,
                         [HEALBOT_HBMENU]=5,
                         [HEALBOT_STOP]=6,
                         [HEALBOT_TELL.." ..."]=7,}
local HealBot_Keys_List = {"","Shift","Ctrl","Alt","Alt-Shift","Ctrl-Shift","Alt-Ctrl"}

function HealBot_Options_ShareSpellsb_OnClick()
    local ssStr="Spells_v8202\n"
    local sName, sTar, sTrin1, sTrin2, AvoidBC, HB_button, HB_combo_prefix, sText, sId=nil,nil,nil,nil,nil,nil,nil,nil,nil
    for z=1,3 do
        for x=1,15 do
            HB_button = HealBot_Options_ComboClass_Button(x)
            -- Menu~1,1,7~2,4,false,false,false,false,
            for y=1, getn(HealBot_Keys_List), 1 do
                HB_combo_prefix = HealBot_Keys_List[y]..HB_button..HealBot_Config.CurrentSpec;
                if z==1 then
                    sName, sTar, sTrin1, sTrin2, AvoidBC = HealBot_Action_AttribSpellPattern(HB_combo_prefix)
                    sText = HealBot_Config_Spells.EnabledKeyCombo[HB_combo_prefix]
                elseif z==2 then
                    sName, sTar, sTrin1, sTrin2, AvoidBC = HealBot_Action_AttribDisSpellPattern(HB_combo_prefix)
                    sText = HealBot_Config_Spells.DisabledKeyCombo[HB_combo_prefix]
                else
                    sName, sTar, sTrin1, sTrin2, AvoidBC = HealBot_Action_AttribEnemySpellPattern(HB_combo_prefix)
                    sText = HealBot_Config_Spells.EnemyKeyCombo[HB_combo_prefix]
                end
                if sName and strlen(sName)>1 then
                    ssStr=ssStr..sName.."~"..z..","..x..","..y.."~"..sText..","
                    if sTar then
                        ssStr=ssStr.."true,"
                    else
                        ssStr=ssStr.."false,"
                    end
                    if sTrin1 then
                        ssStr=ssStr.."true,"
                    else
                        ssStr=ssStr.."false,"
                    end
                    if sTrin2 then
                        ssStr=ssStr.."true,"
                    else
                        ssStr=ssStr.."false,"
                    end
                    if AvoidBC then
                        ssStr=ssStr.."true,"
                    else
                        ssStr=ssStr.."false,"
                    end
                    ssStr=ssStr.."\n"
                end
            end
        end
    end
    HealBot_Options_ShareSpellsExternalEditBox:SetText(ssStr)
end

function HealBot_SpellAutoButton_Update(autoType, autoMod, ActionBarsCombo, Buttons_Button, isTrue)
    local combo=nil
    if ActionBarsCombo==1 then
        if autoType=="Target" then combo = HealBot_Config_Spells.EnabledSpellTarget;
        elseif autoType=="Trinket1" then combo = HealBot_Config_Spells.EnabledSpellTrinket1;
        elseif autoType=="Trinket2" then combo = HealBot_Config_Spells.EnabledSpellTrinket2; 
        else combo = HealBot_Config_Spells.EnabledAvoidBlueCursor; end
    elseif ActionBarsCombo==2 then
        if autoType=="Target" then combo = HealBot_Config_Spells.DisabledSpellTarget;
        elseif autoType=="Trinket1" then combo = HealBot_Config_Spells.DisabledSpellTrinket1;
        elseif autoType=="Trinket2" then combo = HealBot_Config_Spells.DisabledSpellTrinket2;
        else combo = HealBot_Config_Spells.DisabledAvoidBlueCursor; end
    else
        if autoType=="Target" then combo = HealBot_Config_Spells.EnemySpellTarget;
        elseif autoType=="Trinket1" then combo = HealBot_Config_Spells.EnemySpellTrinket1;
        elseif autoType=="Trinket2" then combo = HealBot_Config_Spells.EnemySpellTrinket2;
        else combo = HealBot_Config_Spells.EnemyAvoidBlueCursor; end
    end
    local button = HealBot_Options_ComboClass_Button(Buttons_Button)
    if isTrue=="true" then
        combo[autoMod..button..HealBot_Config.CurrentSpec] = true
    else
        combo[autoMod..button..HealBot_Config.CurrentSpec] = false
    end
end

function HealBot_Options_LoadSpellsb_OnClick()
    local sStr=HealBot_Options_ShareSpellsExternalEditBox:GetText()
    local ssTab={}
    local i=0
    for l in string.gmatch(sStr, "[^\n]+") do
        local t=(string.gsub(l, "^%s*(.-)%s*$", "%1"))
        if string.len(t)>1 then
            i=i+1
            ssTab[i]=t
        end
    end
    if i>0 then
        if ssTab[1]~="Spells_v8202" then
            HealBot_Options_ImportFail("Spells", "Header is incorrect - expecting Spells_v8202")
        else
            if HealBot_Options_StorePrev["InMethodSpell"]==1 then
                HealBot_Config_Spells.EnabledKeyCombo = {}
                HealBot_Config_Spells.DisabledKeyCombo = {}
                HealBot_Config_Spells.EnemyKeyCombo = {}
            end
            -- Flash Heal~1,1,1~1,2061,false,true,true,false,
            for e=2,#ssTab do 
                local _,c,d = string.split("~", ssTab[e])
                local ActionBarsCombo,Buttons_Button,KeyPress=string.split(",", c)
                local sName,sTar,sTrin1,sTrin2,AvoidBC=string.split(",", d)
                ActionBarsCombo=tonumber(ActionBarsCombo)
                Buttons_Button=tonumber(Buttons_Button)
                KeyPress=tonumber(KeyPress)
                local cType="ENEMY"
                if ActionBarsCombo==1 then
                    cType = "ENABLED"
                elseif ActionBarsCombo==2 then
                    cType = "DISABLED"
                end
                local button = HealBot_Options_ComboClass_Button(Buttons_Button)
                local cText=HealBot_Action_GetSpell(cType, HealBot_Keys_List[KeyPress]..button..HealBot_Config.CurrentSpec)
                if not cText or (cText and strlen(cText)<2) or HealBot_Options_StorePrev["InMethodSpell"]<3 then
                    HealBot_Action_SetSpell(cType, HealBot_Keys_List[KeyPress]..button..HealBot_Config.CurrentSpec, sName)
                    HealBot_Options_KnownSpellCheck(sName)
                    HealBot_SpellAutoButton_Update("Target", HealBot_Keys_List[KeyPress], ActionBarsCombo, Buttons_Button, sTar)
                    HealBot_SpellAutoButton_Update("Trinket1", HealBot_Keys_List[KeyPress], ActionBarsCombo, Buttons_Button, sTrin1)
                    HealBot_SpellAutoButton_Update("Trinket2", HealBot_Keys_List[KeyPress], ActionBarsCombo, Buttons_Button, sTrin2)
                    HealBot_SpellAutoButton_Update("AvoidBC", HealBot_Keys_List[KeyPress], ActionBarsCombo, Buttons_Button, AvoidBC)
                end
            end
            if HealBot_Config.Profile==2 then 
                HealBot_Class_Spells[HealBot_Data["PCLASSTRIM"]]=nil 
                HealBot_Options_hbProfile_setClass()
            end
            HealBot_Options_ResetDoInittab(2)
            HealBot_Options_Init(2)
            HealBot_Options_ComboClass_Text()
            HealBot_Action_SetAllAttribs()
        end
    end
end

function HealBot_Options_ShareBuffsb_OnClick()
    local ssStr="CustomBuffs\n"
    local hbClassHoTwatch=HealBot_Globals.WatchHoT
    for xClass,_  in pairs(hbClassHoTwatch) do
        local HealBot_configClassHoTClass=HealBot_Globals.WatchHoT[xClass]
        for bId,x  in pairs(HealBot_configClassHoTClass) do
            ssStr=ssStr..(GetSpellInfo(bId) or HEALBOT_WORDS_UNKNOWN).."~"
            ssStr=ssStr..xClass.."~"
            ssStr=ssStr..bId..","..(HealBot_Globals.HealBot_Custom_Buffs[bId] or 0)..","..x..","
            if HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[bId] then
                ssStr=ssStr.."true,"
            else
                ssStr=ssStr.."false,"
            end
            if HealBot_Globals.CustomBuffBarColour[bId] then
                ssStr=ssStr..(HealBot_Globals.CustomBuffBarColour[bId]["R"] or 0.25)..","
                ssStr=ssStr..(HealBot_Globals.CustomBuffBarColour[bId]["G"] or 0.58)..","
                ssStr=ssStr..(HealBot_Globals.CustomBuffBarColour[bId]["B"] or 0.8)..","
            else
                ssStr=ssStr..",,,"
            end
            if HealBot_Globals.IgnoreCustomBuff[bId] then
                for instName, _ in pairs(HealBot_Globals.IgnoreCustomBuff[bId]) do
                    ssStr=ssStr..(instName)..","
                end
            end
            ssStr=ssStr..",,,\n"
        end
    end
    HealBot_Options_ShareBuffsExternalEditBox:SetText(ssStr)
end

function HealBot_Options_LoadBuffsb_OnClick()
    local scbStr=HealBot_Options_ShareBuffsExternalEditBox:GetText()
    local ssTab={}
    local i=0
    for l in string.gmatch(scbStr, "[^\n]+") do
        local t=(string.gsub(l, "^%s*(.-)%s*$", "%1"))
        if string.len(t)>1 then
            i=i+1
            ssTab[i]=t
        end
    end
    if i>0 then
        if ssTab[1]~="CustomBuffs" then
            HealBot_Options_ImportFail("Buffs", "Header is incorrect - expecting CustomBuffs")
        else
            if HealBot_Options_StorePrev["InMethodBuff"]==1 then
                HealBot_Options_StorePrev["custombufftextpage"]=1
                HealBot_Globals.WatchHoT={ ["DRUI"]={}, ["HUNT"]={}, ["MAGE"]={}, ["PALA"]={}, ["PRIE"]={}, ["ROGU"]={}, ["SHAM"]={},
                                           ["WARL"]={}, ["WARR"]={}, ["DEAT"]={}, ["DEMO"]={}, ["MONK"]={}, ["ALL"]={} }
                HealBot_Globals.HealBot_Custom_Buffs={}
                HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol={}
                local r=HealBot_Globals.CustomBuffBarColour[HEALBOT_CUSTOM_en.."Buff"]["R"]
                local g=HealBot_Globals.CustomBuffBarColour[HEALBOT_CUSTOM_en.."Buff"]["G"]
                local b=HealBot_Globals.CustomBuffBarColour[HEALBOT_CUSTOM_en.."Buff"]["B"]
                HealBot_Globals.CustomBuffBarColour={ [HEALBOT_CUSTOM_en.."Buff"] = { ["R"] = r, ["G"] = g, ["B"] = b, }, }
                HealBot_Globals.IgnoreCustomBuff={}
            end
            for e=2,#ssTab do 
                local _,c,d = string.split("~", ssTab[e])
                local bId,prio,filter,show,r,g,b,i1,i2,i3,i4=string.split(",", d)
                bId=tonumber(bId) or bId
                prio=tonumber(prio)
                filter=tonumber(filter)
                r=tonumber(r)
                g=tonumber(g)
                b=tonumber(b)
                if not HealBot_Globals.WatchHoT[c][bId] or HealBot_Options_StorePrev["InMethodBuff"]<3 then
                    local bName=GetSpellInfo(bId) or bId
                    HealBot_Globals.WatchHoT[c][bId]=filter
                    if prio>0 then HealBot_Globals.HealBot_Custom_Buffs[bId]=prio end
                    if show=="true" then 
                        HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[bId]=true
                    else
                        HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[bId]=false
                    end
                    if r then
                        HealBot_Globals.CustomBuffBarColour[bId]={}
                        HealBot_Globals.CustomBuffBarColour[bId]["R"]=r
                        HealBot_Globals.CustomBuffBarColour[bId]["G"]=g
                        HealBot_Globals.CustomBuffBarColour[bId]["B"]=b
                    elseif HealBot_Globals.CustomBuffBarColour[bId] then
                        HealBot_Globals.CustomBuffBarColour[bId]=nil
                    end
                    if string.len(i1)>0 then 
                        if not HealBot_Globals.IgnoreCustomBuff[bId] then HealBot_Globals.IgnoreCustomBuff[bId]={} end
                        HealBot_Globals.IgnoreCustomBuff[bId][i1]=true 
                    end
                    if string.len(i2)>0 then
                        HealBot_Globals.IgnoreCustomBuff[bId][i2]=true 
                    end
                    if string.len(i3)>0 then
                        HealBot_Globals.IgnoreCustomBuff[bId][i3]=true 
                    end
                    if string.len(i4)>0 then
                        HealBot_Globals.IgnoreCustomBuff[bId][i4]=true 
                    end
                end
            end
            HealBot_Options_InitSub(502)
            HealBot_Options_setCustomBuffList()
        end
    end
end

function HealBot_Options_ShareCDebuffb_OnClick()
    local ssStr="CustomDebuffs\n"
    for dId, x in pairs(HealBot_Globals.HealBot_Custom_Debuffs) do
        if (HealBot_Globals.Custom_Debuff_Categories[dId] or 10)>1 then
            ssStr=ssStr..(GetSpellInfo(dId) or HEALBOT_WORDS_UNKNOWN).."~"
            ssStr=ssStr..(HealBot_Globals.Custom_Debuff_Categories[dId] or 10).."~"
            ssStr=ssStr..dId..","..x..","..(HealBot_Globals.FilterCustomDebuff[dId] or "")..","
            if HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[dId] then
                ssStr=ssStr.."true,"
            else
                ssStr=ssStr.."false,"
            end
            if HealBot_Globals.CDCBarColour[dId] then
                ssStr=ssStr..(HealBot_Globals.CDCBarColour[dId]["R"])..","
                ssStr=ssStr..(HealBot_Globals.CDCBarColour[dId]["G"])..","
                ssStr=ssStr..(HealBot_Globals.CDCBarColour[dId]["B"])..","
            else
                ssStr=ssStr..",,,"
            end
            if HealBot_Globals.HealBot_Custom_Debuffs_RevDur[dId] then
                ssStr=ssStr.."true,"
            else
                ssStr=ssStr.."false,"
            end
            if HealBot_Globals.IgnoreCustomDebuff[dId] then
                for instName, _ in pairs(HealBot_Globals.IgnoreCustomDebuff[dId]) do
                    ssStr=ssStr..(instName)..","
                end
            end
            ssStr=ssStr..",,,\n"
        end
    end
    HealBot_Options_ShareCDebuffExternalEditBox:SetText(ssStr)
end

function HealBot_Options_LoadCDebuffb_OnClick()
    local scdStr=HealBot_Options_ShareCDebuffExternalEditBox:GetText()
    local ssTab={}
    local i=0
    for l in string.gmatch(scdStr, "[^\n]+") do
        local t=(string.gsub(l, "^%s*(.-)%s*$", "%1"))
        if string.len(t)>1 then
            i=i+1
            ssTab[i]=t
        end
    end
    if i>0 then
        if ssTab[1]~="CustomDebuffs" then
            HealBot_Options_ImportFail("Debuffs", "Header is incorrect - expecting CustomDebuffs")
        else
            if HealBot_Options_StorePrev["InMethodCDbuff"]==1 then
                HealBot_Options_StorePrev["customdebufftextpage"]=1
                HealBot_Globals.Custom_Debuff_Categories={ [HEALBOT_CUSTOM_CAT_CUSTOM_AUTOMATIC]  = 1, }
                HealBot_Globals.HealBot_Custom_Debuffs={ [HEALBOT_CUSTOM_CAT_CUSTOM_AUTOMATIC]     = 15, }
                HealBot_Globals.FilterCustomDebuff={}
                HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol={}
                HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[HEALBOT_CUSTOM_CAT_CUSTOM_AUTOMATIC]=true
                local r=HealBot_Globals.CDCBarColour[HEALBOT_CUSTOM_en.."15"]["R"]
                local g=HealBot_Globals.CDCBarColour[HEALBOT_CUSTOM_en.."15"]["G"]
                local b=HealBot_Globals.CDCBarColour[HEALBOT_CUSTOM_en.."15"]["B"]
                HealBot_Globals.CDCBarColour={ [HEALBOT_CUSTOM_en.."15"] = { ["R"] = r, ["G"] = g, ["B"] = b, }, }
                HealBot_Globals.HealBot_Custom_Debuffs_RevDur={}
                HealBot_Globals.IgnoreCustomDebuff={}
                HealBot_Globals.CatchAltDebuffIDs={}
            end
            for e=2,#ssTab do 
                local _,c,d = string.split("~", ssTab[e])
                local dId,prio,filter,show,r,g,b,revdur,i1,i2,i3,i4=string.split(",", d)
                c=tonumber(c)
                dId=tonumber(dId) or dId
                prio=tonumber(prio)
                filter=tonumber(filter)
                r=tonumber(r)
                g=tonumber(g)
                b=tonumber(b)
                if not HealBot_Globals.HealBot_Custom_Debuffs[dId] or HealBot_Options_StorePrev["InMethodCDbuff"]<3 then
                    local dName=GetSpellInfo(dId) or dId
                    if dName==dId then HealBot_Globals.CatchAltDebuffIDs[dName]=true end
                    HealBot_Globals.Custom_Debuff_Categories[dId]=c
                    HealBot_Globals.HealBot_Custom_Debuffs[dId]=prio
                    if filter then HealBot_Globals.FilterCustomDebuff[dId]=filter end
                    if show=="true" then
                        HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[dId]=true
                    else
                        HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[dId]=false
                    end
                    if r then
                        HealBot_Globals.CDCBarColour[dId]={}
                        HealBot_Globals.CDCBarColour[dId]["R"]=r
                        HealBot_Globals.CDCBarColour[dId]["G"]=g
                        HealBot_Globals.CDCBarColour[dId]["B"]=b
                    elseif HealBot_Globals.CDCBarColour[dId] then
                        HealBot_Globals.CDCBarColour[dId]=nil
                    end
                    if show=="revdur" then
                        HealBot_Globals.HealBot_Custom_Debuffs_RevDur[dId]=true
                    end
                    if string.len(i1)>0 then 
                        if not HealBot_Globals.IgnoreCustomDebuff[dId] then HealBot_Globals.IgnoreCustomDebuff[dId]={} end
                        HealBot_Globals.IgnoreCustomDebuff[dId][i1]=true 
                    end
                    if string.len(i2)>0 then
                        HealBot_Globals.IgnoreCustomDebuff[dId][i2]=true 
                    end
                    if string.len(i3)>0 then
                        HealBot_Globals.IgnoreCustomDebuff[dId][i3]=true 
                    end
                    if string.len(i4)>0 then
                        HealBot_Globals.IgnoreCustomDebuff[dId][i4]=true 
                    end
                end
            end
            HealBot_Options_InitSub(402)
            HealBot_Options_InitSub(403)
            HealBot_Options_InitSub(404)
            HealBot_Options_setCustomDebuffList()
        end
    end
end

function HealBot_Options_ShareSkinLoad()
    local ssStr=HealBot_Options_ShareExternalEditBox:GetText()
    local ssTab={}
    local i=0
    for l in string.gmatch(ssStr, "[^\n]+") do
        local t=(string.gsub(l, "^%s*(.-)%s*$", "%1"))
        if string.len(t)>1 then
            i=i+1
            ssTab[i]=t
        end
    end
    if i>40 then
        if ssTab[1]~="Skin" then
            HealBot_Options_ImportFail("Skin", "Header is incorrect - expecting Skin")
        else
            hbOptGetSkinName=ssTab[2]
            if tonumber(hbOptGetSkinName) then hbOptGetSkinName='#'..hbOptGetSkinName end
            for e=3,#ssTab do 
                local c,m = string.split("!", ssTab[e])
                HealBot_Options_BuildSkinRecMsg(hbOptGetSkinName, c, 0, m)
            end
            hbOptGetSkinFrom=HEALBOT_ABOUT_URL
            HealBot_Options_ShareSkinComplete()
        end
    end
end

function HealBot_Options_ShareSkinComplete()
    for j=1,10 do
        if not fontsIndex[Healbot_Config_Skins.BarText[hbOptGetSkinName][j]["FONT"]] then
            Healbot_Config_Skins.BarText[hbOptGetSkinName][j]["FONT"] = "Friz Quadrata TT"
        end
        if not fontsIndex[Healbot_Config_Skins.HeadText[hbOptGetSkinName][j]["FONT"]] then
            Healbot_Config_Skins.HeadText[hbOptGetSkinName][j]["FONT"] = "Friz Quadrata TT"
        end
        if not fontsIndex[Healbot_Config_Skins.FrameAlias[hbOptGetSkinName][j]["FONT"]] then
            Healbot_Config_Skins.FrameAlias[hbOptGetSkinName][j]["FONT"] = "Friz Quadrata TT"
        end
        if not texturesIndex[Healbot_Config_Skins.HeadBar[hbOptGetSkinName][j]["TEXTURE"]] then
            Healbot_Config_Skins.HeadBar[hbOptGetSkinName][j]["TEXTURE"]="Smooth"
        end
        if not texturesIndex[Healbot_Config_Skins.HealBar[hbOptGetSkinName][j]["TEXTURE"]] then
            Healbot_Config_Skins.HealBar[hbOptGetSkinName][j]["TEXTURE"]="Smooth"
        end
    end
    local unique=true;
    table.foreach(Healbot_Config_Skins.Skins, function (index,skin)
        if skin==hbOptGetSkinName then unique=false; end
    end)
    if unique then
        table.insert(Healbot_Config_Skins.Skins,2,hbOptGetSkinName)
        Healbot_Config_Skins.Skin_ID = 2;
    end
    Healbot_Config_Skins.Current_Skin = hbOptGetSkinName
    HealBot_Config.LastVersionSkinUpdate=HealBot_lastVerSkinUpdate
    HealBot_Check_Skin(hbOptGetSkinName)  
    HealBot_Options_SetSkins(true);
    HealBot_Options_NewSkin:SetText("")
    hbWarnSharedMedia=false
    HealBot_AddChat(HEALBOT_CHAT_ADDONID..hbOptGetSkinName..HEALBOT_CHAT_SKINREC..hbOptGetSkinFrom)
    HealBot_SetResetFlag("SOFT")
    DoneInitTab[305]=nil
    HealBot_Options_InitSub(305)
    --HealBot_nextRecalcParty(0)
end

function HealBot_Options_checkSkinName(skinName)
    local hbFoundSkin=nil
    table.foreach(Healbot_Config_Skins.Skins, function (index,skin)
        if skin==skinName then hbFoundSkin=true; end
    end)
    return hbFoundSkin
end

function HealBot_Options_val2str ( v )
  if "string" == type( v ) then
    v = string.gsub( v, "\n", "\\n" )
    if string.match( string.gsub(v,"[^'\"]",""), '^"+$' ) then
      return "'" .. v .. "'"
    end
    return '"' .. string.gsub(v,'"', '\\"' ) .. '"'
  else
    return "table" == type( v ) and HealBot_Options_tab2str( v ) or
      tostring( v )
  end
end

function HealBot_Options_key2str ( k )
  if "string" == type( k ) and string.match( k, "^[_%a][_%a%d]*$" ) then
    return k
  else
    return "[" .. HealBot_Options_val2str( k ) .. "]"
  end
end

function HealBot_Options_tab2str( tbl )
  local result, done = {}, {}
  for k, v in ipairs( tbl ) do
    local value = '"' .. HealBot_Options_val2str( v ) .. '"'
    if value~='"false"' and value~='"true"' then value=HealBot_Options_val2str( v ) end
    table.insert( result, value )
    done[ k ] = true
  end
  for k, v in pairs( tbl ) do
    if not done[ k ] then
      local value = '"' .. HealBot_Options_val2str( v ) .. '"'
      if value~='"false"' and value~='"true"' then value=HealBot_Options_val2str( v ) end
      table.insert( result,
        HealBot_Options_key2str( k ) .. "=" .. value )
    end
  end
  return "{" .. table.concat( result, "," ) .. "}"
end

function HealBot_Options_BuildSkinSendMsg(skinName)
    local SkinVars={'Author'}
    local SkinTabVars={'Chat', 'General', 'Healing', 'Protection', 'Enemy'}
    local SkinTabFrameVars={'IncludeGroup','FrameAlias', 'FrameAliasBar', 'Frame', 'StickyFrames', 'HealGroups', 'Anchors', 'HeadBar', 'HeadText', 'HealBar', 'BarCol', 'BarIACol', 'BarText', 'BarTextCol', 'Icons', 'RaidIcon', 'IconText', 'BarVisibility', 'BarSort', 'BarAggro', 'BarHighlight'}
    HealBot_ShareSkinSendMsg("Init", skinName)
    for j=1, getn(SkinVars), 1 do
        local varName=SkinVars[j]
        local tabStr=Healbot_Config_Skins[varName][skinName]
        HealBot_ShareSkinSendMsg(varName.."~v", tabStr)
    end
    for j=1, getn(SkinTabVars), 1 do
        local varName=SkinTabVars[j]
        local tabStr=HealBot_Options_tab2str(Healbot_Config_Skins[varName][skinName])
        HealBot_ShareSkinSendMsg(varName.."~t", tabStr)
    end
    for j=1, getn(SkinTabFrameVars), 1 do
        local varName=SkinTabFrameVars[j]
        local tabStr=""
        local dups=""
        local p={}
        for i=1,10 do
            tabStr=HealBot_Options_tab2str(Healbot_Config_Skins[varName][skinName][i])
            local isDup=true
            local lMsg=strsub(tabStr,2,string.len(tabStr)-1)
            local d={}
            d[1],d[2],d[3],d[4],d[5],d[6],d[7],d[8],d[9],d[10],d[11],d[12],d[13],d[14],d[15],d[16],d[17],d[18],d[19],d[20],d[21],d[22]=string.split(",", lMsg)
            for j=1,22 do
                if d[j] then
                    local var, dat=string.split("=", d[j])
                    if tonumber(dat) then dat=tonumber(dat) end
                    if not p[var] then p[var]="" end
                    if p[var]~=dat then
                        p[var]=dat
                        isDup=false
                    end
                end
            end
            if isDup then
                dups=dups..i.."~"
                if i==10 then
                    HealBot_ShareSkinSendMsg(varName.."~d", dups) 
                end
            else
                if string.len(dups)>1 then 
                    HealBot_ShareSkinSendMsg(varName.."~d", dups) 
                    dups=""
                end
                HealBot_ShareSkinSendMsg(varName.."~f~"..i, tabStr)
            end
        end
        if varName=="HealGroups" then
            tabStr=HealBot_Options_tab2str(Healbot_Config_Skins[varName][skinName][11])
            HealBot_ShareSkinSendMsg(varName.."~f~11", tabStr)
        end
    end
    HealBot_ShareSkinSendMsg("Complete", "")
end

local tmpRecParts={}
local lFrame=1
local skinBoolean ={["Chat"]          = {["RESONLY"]=true},
                    ["General"]       = {["HIDEPARTYF"]=true,["HIDEPTF"]=true,["HIDEBOSSF"]=true,["HIDERAIDF"]=true,["FLUIDBARS"]=true,["STICKYFRAME"]=true},
                    ["Healing"]       = {["GROUPPETS"]=true,["TONLYFRIEND"]=true,["FONLYFRIEND"]=true},
                    ["Protection"]    = {["CRASH"]=true,["COMBAT"]=true},
                    ["Enemy"]         = {["INCSELF"]=true,["INCTANKS"]=true,["INCMYTAR"]=true,["INCARENA"]=true,["INCARENAPETS"]=true,["HIDE"]=true,["EXISTSHOWPTAR"]=true,["EXISTSHOWBOSS"]=true,["EXISTSHOWARENA"]=true},
                   }
local skinFrameBoolean = {["FrameAlias"]    = {["SHOW"]=true},
                          ["Frame"]         = {["AUTOCLOSE"]=true,["OPENSOUND"]=true,["LOCKED"]=true},
                          ["BarSort"]       = {["OORLAST"]=true,["SUBPF"]=true},
                          ["BarHighlight"]  = {["CBAR"]=true,["CBARCOMBAT"]=true,["TBAR"]=true,["TBARCOMBAT"]=true},
                          ["BarAggro"]      = {["SHOW"]=true,["SHOWIND"]=true,["SHOWBARS"]=true,["SHOWTEXT"]=true,["SHOWBARSPCT"]=true,["SHOWTEXTPCT"]=true},
                          ["HealGroups"]    = {["STATE"]=true},
                          ["HeadBar"]       = {["SHOW"]=true},
                          ["HealBar"]       = {["GRPCOLS"]=true,["POWERCNT"]=true,["LOWMANACOMBAT"]=true},
                          ["BarText"]       = {["SHOWROLE"]=true,["CLASSONBAR"]=true,["NAMEONBAR"]=true,["HLTHONBAR"]=true,["CLASSCOL"]=true,["DOUBLE"]=true},
                          ["Icons"]         = {["SHOWBUFF"]=true,["SHOWDEBUFF"]=true,["SHOWRC"]=true,["SHOWDIR"]=true,["SHOWDIRMOUSE"]=true,["DOUBLE"]=true,["I15EN"]=true},
                          ["RaidIcon"]      = {["SHOW"]=true,["STAR"]=true,["CIRCLE"]=true,["DIAMOND"]=true,["TRIANGLE"]=true,["MOON"]=true,["SQUARE"]=true,["CROSS"]=true,["SKULL"]=true},
                          ["IconText"]      = {["SCNT"]=true,["SSCNT"]=true,["SDUR"]=true,["SSDUR"]=true},
                          ["BarVisibility"] = {["HIDEOOR"]=true},
                         }
                    
function HealBot_Options_BuildSkinRecMsg(skinName, cmd, parts, msg)
    local varName, vType, fNo = string.split("~", cmd)
    msg=string.gsub(msg,'\"', '' )
    if parts==1 then
        tmpRecParts[varName]=msg
        return
    elseif parts==2 then
        msg=tmpRecParts[varName]..msg
        tmpRecParts[varName]=nil
    end
    if vType=="f" and Healbot_Config_Skins[varName] then
        if tonumber(fNo) then fNo=tonumber(fNo) end
        if not Healbot_Config_Skins[varName][skinName] then Healbot_Config_Skins[varName][skinName]={} end
        for j=1,10 do
            if not Healbot_Config_Skins[varName][skinName][j] then Healbot_Config_Skins[varName][skinName][j]={} end
        end
        if varName=="HealGroups" then
            if not Healbot_Config_Skins[varName][skinName][11] then Healbot_Config_Skins[varName][skinName][11]={} end
        end
        if varName=="IncludeGroup" then
            local lMsg=strsub(msg,2,string.len(msg)-1)
            local d={}
            d[1],d[2],d[3],d[4],d[5],d[6],d[7],d[8]=string.split(",", lMsg)
            for j=1,8 do
                if d[j]=="true" then
                    Healbot_Config_Skins[varName][skinName][fNo][j]=true
                else
                    Healbot_Config_Skins[varName][skinName][fNo][j]=false
                end
            end
        elseif varName~="ExtraIncGroup" then
            local lMsg=strsub(msg,2,string.len(msg)-1)
            local d={}
            d[1],d[2],d[3],d[4],d[5],d[6],d[7],d[8],d[9],d[10],d[11],d[12],d[13],d[14],d[15],d[16],d[17],d[18],d[19],d[20],d[21],d[22]=string.split(",", lMsg)
            for j=1,22 do
                if d[j] then
                    local var, dat=string.split("=", d[j])
                    if tonumber(dat) then dat=tonumber(dat) end
                    if var and dat then
                        if dat=="false" then                
                            Healbot_Config_Skins[varName][skinName][fNo][var]=false 
                        elseif dat=="true" then
                            Healbot_Config_Skins[varName][skinName][fNo][var]=true 
                        elseif skinFrameBoolean[varName] and skinFrameBoolean[varName][var] then
                            if dat==1 then
                                Healbot_Config_Skins[varName][skinName][fNo][var]=true 
                            else
                                Healbot_Config_Skins[varName][skinName][fNo][var]=false
                            end
                        else
                            Healbot_Config_Skins[varName][skinName][fNo][var]=dat 
                        end
                    end
                    lFrame=fNo
                end
            end
        end
    elseif vType=="d" and Healbot_Config_Skins[varName] then
        local dups={}
        dups[9],dups[8],dups[7],dups[6],dups[5],dups[4],dups[3],dups[2],dups[1]=string.split("~", msg)
        for j=1,9 do
            if dups[j] then 
                local f=nil
                if tonumber(dups[j]) then f=tonumber(dups[j]) end
                if f then Healbot_Config_Skins[varName][skinName][f]=HealBot_Options_copyTable(Healbot_Config_Skins[varName][skinName][lFrame]) end
            end
        end
    elseif vType=="t" and Healbot_Config_Skins[varName] then
        if not Healbot_Config_Skins[varName][skinName] then Healbot_Config_Skins[varName][skinName]={} end
        local lMsg=strsub(msg,2,string.len(msg)-1)
        local d={}
        d[1],d[2],d[3],d[4],d[5],d[6],d[7],d[8],d[9],d[10],d[11],d[12],d[13],d[14],d[15],d[16],d[17],d[18],d[19],d[20],d[21],d[22]=string.split(",", lMsg)
        for j=1,22 do
            if d[j] then
                local var, dat=string.split("=", d[j])
                if tonumber(dat) then dat=tonumber(dat) end
                if var and dat then
                    if dat=="false" then                
                        Healbot_Config_Skins[varName][skinName][var]=false 
                    elseif dat=="true" then
                        Healbot_Config_Skins[varName][skinName][var]=true 
                    elseif skinBoolean[varName] and skinBoolean[varName][var] then
                        if dat==1 then
                            Healbot_Config_Skins[varName][skinName][var]=true 
                        else
                            Healbot_Config_Skins[varName][skinName][var]=false 
                        end
                    else
                        Healbot_Config_Skins[varName][skinName][var]=dat 
                    end
                end
            end
        end
    elseif vType=="v" and Healbot_Config_Skins[varName] then
        if tonumber(msg) then msg=tonumber(msg) end
        Healbot_Config_Skins[varName][skinName]=msg
    end
end

function HealBot_Option_WarnPossibleNoSharedMedia()
    if not hbWarnSharedMedia then
        HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_POSSIBLEMISSINGMEDIA)
        hbWarnSharedMedia=true
    end
end

--------------------------------------------------------------------------------

function HealBot_Options_TooltipPos_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_TooltipPos_List), 1 do
        info.text = HealBot_Options_TooltipPos_List[j];
        info.func = function(self)
                        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TIPLOC"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_TooltipPos,HealBot_Options_TooltipPos_List[Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TIPLOC"]]) 
                    end
        info.checked = false;
        if Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TIPLOC"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

--------------------------------------------------------------------------------

local function HealBot_Options_BuffTxt1_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    info.text = HEALBOT_WORDS_NONE;
    info.func = function(self)
                    BuffTextClass = HealBot_Config_Buffs.HealBotBuffText
                    BuffTextClass[HealBot_Options_getDropDownId_bySpec(1)] = self:GetText()
                    UIDropDownMenu_SetText(HealBot_Options_BuffTxt1,HEALBOT_WORDS_NONE)
                    HealBot_setOptions_Timer(40)
                end
    info.checked = false;
    if BuffTextClass[HealBot_Options_getDropDownId_bySpec(1)]==HEALBOT_WORDS_NONE then info.checked = true end
    UIDropDownMenu_AddButton(info);
    for j=1, getn(HealBot_Buff_Spells_List), 1 do
        local sName = HealBot_Buff_Spells_List[j];
        info.text = sName
        info.func = function(self)
                        BuffTextClass = HealBot_Config_Buffs.HealBotBuffText
                        BuffTextClass[HealBot_Options_getDropDownId_bySpec(1)] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_BuffTxt1,sName)
                        HealBot_setOptions_Timer(40)
                    end
        info.checked = false;
        if BuffTextClass[HealBot_Options_getDropDownId_bySpec(1)]==HealBot_Buff_Spells_List[j] then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

local function HealBot_Options_BuffTxt2_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    info.text = HEALBOT_WORDS_NONE;
    info.func = function(self)
                    BuffTextClass = HealBot_Config_Buffs.HealBotBuffText
                    BuffTextClass[HealBot_Options_getDropDownId_bySpec(2)] = self:GetText()
                    UIDropDownMenu_SetText(HealBot_Options_BuffTxt2,HEALBOT_WORDS_NONE)
                    HealBot_setOptions_Timer(40)
                end
    info.checked = false;
    if BuffTextClass[HealBot_Options_getDropDownId_bySpec(2)]==HEALBOT_WORDS_NONE then info.checked = true end
    UIDropDownMenu_AddButton(info);
    for j=1, getn(HealBot_Buff_Spells_List), 1 do
        local sName = HealBot_Buff_Spells_List[j];
        info.text = sName
        info.func = function(self)
                        BuffTextClass = HealBot_Config_Buffs.HealBotBuffText
                        BuffTextClass[HealBot_Options_getDropDownId_bySpec(2)] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_BuffTxt2,sName)
                        HealBot_setOptions_Timer(40)
                    end
        info.checked = false;
        if BuffTextClass[HealBot_Options_getDropDownId_bySpec(2)]==HealBot_Buff_Spells_List[j] then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

local function HealBot_Options_BuffTxt3_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    info.text = HEALBOT_WORDS_NONE;
    info.func = function(self)
                    BuffTextClass = HealBot_Config_Buffs.HealBotBuffText
                    BuffTextClass[HealBot_Options_getDropDownId_bySpec(3)] = self:GetText()
                    UIDropDownMenu_SetText(HealBot_Options_BuffTxt3,HEALBOT_WORDS_NONE)
                    HealBot_setOptions_Timer(40)
                end
    info.checked = false;
    if BuffTextClass[HealBot_Options_getDropDownId_bySpec(3)]==HEALBOT_WORDS_NONE then info.checked = true end
    UIDropDownMenu_AddButton(info);
    for j=1, getn(HealBot_Buff_Spells_List), 1 do
        local sName = HealBot_Buff_Spells_List[j];
        info.text = sName
        info.func = function(self)
                        BuffTextClass = HealBot_Config_Buffs.HealBotBuffText
                        BuffTextClass[HealBot_Options_getDropDownId_bySpec(3)] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_BuffTxt3,sName)
                        HealBot_setOptions_Timer(40)
                    end
        info.checked = false;
        if BuffTextClass[HealBot_Options_getDropDownId_bySpec(3)]==HealBot_Buff_Spells_List[j] then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

local function HealBot_Options_BuffTxt4_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    info.text = HEALBOT_WORDS_NONE;
    info.func = function(self)
                    BuffTextClass = HealBot_Config_Buffs.HealBotBuffText
                    BuffTextClass[HealBot_Options_getDropDownId_bySpec(4)] = self:GetText()
                    UIDropDownMenu_SetText(HealBot_Options_BuffTxt4,HEALBOT_WORDS_NONE)
                    HealBot_setOptions_Timer(40)
                end
    info.checked = false;
    if BuffTextClass[HealBot_Options_getDropDownId_bySpec(4)]==HEALBOT_WORDS_NONE then info.checked = true end
    UIDropDownMenu_AddButton(info);
    for j=1, getn(HealBot_Buff_Spells_List), 1 do
        local sName = HealBot_Buff_Spells_List[j];
        info.text = sName
        info.func = function(self)
                        BuffTextClass = HealBot_Config_Buffs.HealBotBuffText
                        BuffTextClass[HealBot_Options_getDropDownId_bySpec(4)] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_BuffTxt4,sName)
                        HealBot_setOptions_Timer(40)
                    end
        info.checked = false;
        if BuffTextClass[HealBot_Options_getDropDownId_bySpec(4)]==HealBot_Buff_Spells_List[j] then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

local function HealBot_Options_BuffTxt5_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    info.text = HEALBOT_WORDS_NONE;
    info.func = function(self)
                    BuffTextClass = HealBot_Config_Buffs.HealBotBuffText
                    BuffTextClass[HealBot_Options_getDropDownId_bySpec(5)] = self:GetText()
                    UIDropDownMenu_SetText(HealBot_Options_BuffTxt5,HEALBOT_WORDS_NONE)
                    HealBot_setOptions_Timer(40)
                end
    info.checked = false;
    if BuffTextClass[HealBot_Options_getDropDownId_bySpec(5)]==HEALBOT_WORDS_NONE then info.checked = true end
    UIDropDownMenu_AddButton(info);
    for j=1, getn(HealBot_Buff_Spells_List), 1 do
        local sName = HealBot_Buff_Spells_List[j];
        info.text = sName
        info.func = function(self)
                        BuffTextClass = HealBot_Config_Buffs.HealBotBuffText
                        BuffTextClass[HealBot_Options_getDropDownId_bySpec(5)] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_BuffTxt5,sName)
                        HealBot_setOptions_Timer(40)
                    end
        info.checked = false;
        if BuffTextClass[HealBot_Options_getDropDownId_bySpec(5)]==HealBot_Buff_Spells_List[j] then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

local function HealBot_Options_BuffTxt6_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    info.text = HEALBOT_WORDS_NONE;
    info.func = function(self)
                    BuffTextClass = HealBot_Config_Buffs.HealBotBuffText
                    BuffTextClass[HealBot_Options_getDropDownId_bySpec(6)] = self:GetText()
                    UIDropDownMenu_SetText(HealBot_Options_BuffTxt6,HEALBOT_WORDS_NONE)
                    HealBot_setOptions_Timer(40)
                end
    info.checked = false;
    if BuffTextClass[HealBot_Options_getDropDownId_bySpec(6)]==HEALBOT_WORDS_NONE then info.checked = true end
    UIDropDownMenu_AddButton(info);
    for j=1, getn(HealBot_Buff_Spells_List), 1 do
        local sName = HealBot_Buff_Spells_List[j];
        info.text = sName
        info.func = function(self)
                        BuffTextClass = HealBot_Config_Buffs.HealBotBuffText
                        BuffTextClass[HealBot_Options_getDropDownId_bySpec(6)] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_BuffTxt6,sName)
                        HealBot_setOptions_Timer(40)
                    end
        info.checked = false;
        if BuffTextClass[HealBot_Options_getDropDownId_bySpec(6)]==HealBot_Buff_Spells_List[j] then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

local function HealBot_Options_BuffTxt7_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    info.text = HEALBOT_WORDS_NONE;
    info.func = function(self)
                    BuffTextClass = HealBot_Config_Buffs.HealBotBuffText
                    BuffTextClass[HealBot_Options_getDropDownId_bySpec(7)] = self:GetText()
                    UIDropDownMenu_SetText(HealBot_Options_BuffTxt7,HEALBOT_WORDS_NONE)
                    HealBot_setOptions_Timer(40)
                end
    info.checked = false;
    if BuffTextClass[HealBot_Options_getDropDownId_bySpec(7)]==HEALBOT_WORDS_NONE then info.checked = true end
    UIDropDownMenu_AddButton(info);
    for j=1, getn(HealBot_Buff_Spells_List), 1 do
        local sName = HealBot_Buff_Spells_List[j];
        info.text = sName
        info.func = function(self)
                        BuffTextClass = HealBot_Config_Buffs.HealBotBuffText
                        BuffTextClass[HealBot_Options_getDropDownId_bySpec(7)] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_BuffTxt7,sName)
                        HealBot_setOptions_Timer(40)
                    end
        info.checked = false;
        if BuffTextClass[HealBot_Options_getDropDownId_bySpec(7)]==HealBot_Buff_Spells_List[j] then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

local function HealBot_Options_BuffTxt8_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    info.text = HEALBOT_WORDS_NONE;
    info.func = function(self)
                    BuffTextClass = HealBot_Config_Buffs.HealBotBuffText
                    BuffTextClass[HealBot_Options_getDropDownId_bySpec(8)] = self:GetText()
                    UIDropDownMenu_SetText(HealBot_Options_BuffTxt8,HEALBOT_WORDS_NONE)
                    HealBot_setOptions_Timer(40)
                end
    info.checked = false;
    if BuffTextClass[HealBot_Options_getDropDownId_bySpec(8)]==HEALBOT_WORDS_NONE then info.checked = true end
    UIDropDownMenu_AddButton(info);
    for j=1, getn(HealBot_Buff_Spells_List), 1 do
        local sName = HealBot_Buff_Spells_List[j];
        info.text = sName
        info.func = function(self)
                        BuffTextClass = HealBot_Config_Buffs.HealBotBuffText
                        BuffTextClass[HealBot_Options_getDropDownId_bySpec(8)] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_BuffTxt8,sName)
                        HealBot_setOptions_Timer(40)
                    end
        info.checked = false;
        if BuffTextClass[HealBot_Options_getDropDownId_bySpec(8)]==HealBot_Buff_Spells_List[j] then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

local function HealBot_Options_BuffGroups1_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    local BuffDropDownClass = HealBot_Config_Buffs.HealBotBuffDropDown
    for j=1, getn(HealBot_Options_BuffTxt_List), 1 do
        info.text = HealBot_Options_BuffTxt_List[j];
        info.func = function(self)
                        BuffDropDownClass = HealBot_Config_Buffs.HealBotBuffDropDown
                        BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(1)] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_BuffGroups1,HealBot_Options_BuffTxt_List[BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(1)]]) 
                        ClickedBuffGroupDD=1
                        HealBot_setOptions_Timer(40)
                    end
        info.checked = false;
        if BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(1)]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

local function HealBot_Options_BuffGroups2_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    local BuffDropDownClass = HealBot_Config_Buffs.HealBotBuffDropDown
    for j=1, getn(HealBot_Options_BuffTxt_List), 1 do
        info.text = HealBot_Options_BuffTxt_List[j];
        info.func = function(self)
                        BuffDropDownClass = HealBot_Config_Buffs.HealBotBuffDropDown
                        BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(2)] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_BuffGroups2,HealBot_Options_BuffTxt_List[BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(2)]]) 
                        ClickedBuffGroupDD=2
                        HealBot_setOptions_Timer(40)
                    end
        info.checked = false;
        if BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(2)]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

local function HealBot_Options_BuffGroups3_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    local BuffDropDownClass = HealBot_Config_Buffs.HealBotBuffDropDown
    for j=1, getn(HealBot_Options_BuffTxt_List), 1 do
        info.text = HealBot_Options_BuffTxt_List[j];
        info.func = function(self)
                        BuffDropDownClass = HealBot_Config_Buffs.HealBotBuffDropDown
                        BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(3)] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_BuffGroups3,HealBot_Options_BuffTxt_List[BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(3)]]) 
                        ClickedBuffGroupDD=3
                        HealBot_setOptions_Timer(40)
                    end
        info.checked = false;
        if BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(3)]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

local function HealBot_Options_BuffGroups4_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    local BuffDropDownClass = HealBot_Config_Buffs.HealBotBuffDropDown
    for j=1, getn(HealBot_Options_BuffTxt_List), 1 do
        info.text = HealBot_Options_BuffTxt_List[j];
        info.func = function(self)
                        BuffDropDownClass = HealBot_Config_Buffs.HealBotBuffDropDown
                        BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(4)] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_BuffGroups4,HealBot_Options_BuffTxt_List[BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(4)]]) 
                        ClickedBuffGroupDD=4
                        HealBot_setOptions_Timer(40)
                    end
        info.checked = false;
        if BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(4)]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

local function HealBot_Options_BuffGroups5_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    local BuffDropDownClass = HealBot_Config_Buffs.HealBotBuffDropDown
    for j=1, getn(HealBot_Options_BuffTxt_List), 1 do
        info.text = HealBot_Options_BuffTxt_List[j];
        info.func = function(self)
                        BuffDropDownClass = HealBot_Config_Buffs.HealBotBuffDropDown
                        BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(5)] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_BuffGroups5,HealBot_Options_BuffTxt_List[BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(5)]]) 
                        ClickedBuffGroupDD=5
                        HealBot_setOptions_Timer(40)
                    end
        info.checked = false;
        if BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(5)]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

local function HealBot_Options_BuffGroups6_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    local BuffDropDownClass = HealBot_Config_Buffs.HealBotBuffDropDown
    for j=1, getn(HealBot_Options_BuffTxt_List), 1 do
        info.text = HealBot_Options_BuffTxt_List[j];
        info.func = function(self)
                        BuffDropDownClass = HealBot_Config_Buffs.HealBotBuffDropDown
                        BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(6)] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_BuffGroups6,HealBot_Options_BuffTxt_List[BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(6)]]) 
                        ClickedBuffGroupDD=6
                        HealBot_setOptions_Timer(40)
                    end
        info.checked = false;
        if BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(6)]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

local function HealBot_Options_BuffGroups7_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    local BuffDropDownClass = HealBot_Config_Buffs.HealBotBuffDropDown
    for j=1, getn(HealBot_Options_BuffTxt_List), 1 do
        info.text = HealBot_Options_BuffTxt_List[j];
        info.func = function(self)
                        BuffDropDownClass = HealBot_Config_Buffs.HealBotBuffDropDown
                        BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(7)] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_BuffGroups7,HealBot_Options_BuffTxt_List[BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(7)]]) 
                        ClickedBuffGroupDD=7
                        HealBot_setOptions_Timer(40)
                    end
        info.checked = false;
        if BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(7)]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

local function HealBot_Options_BuffGroups8_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    local BuffDropDownClass = HealBot_Config_Buffs.HealBotBuffDropDown
    for j=1, getn(HealBot_Options_BuffTxt_List), 1 do
        info.text = HealBot_Options_BuffTxt_List[j];
        info.func = function(self)
                        BuffDropDownClass = HealBot_Config_Buffs.HealBotBuffDropDown
                        BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(8)] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_BuffGroups8,HealBot_Options_BuffTxt_List[BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(8)]]) 
                        ClickedBuffGroupDD=8
                        HealBot_setOptions_Timer(40)
                    end
        info.checked = false;
        if BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(8)]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end


function HealBot_Options_BuffWarnRange1_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Debuff_RangeWarning_List), 1 do
        info.text = HealBot_Debuff_RangeWarning_List[j];
        info.func = function(self)
                        HealBot_Config_Buffs.HealBot_CBWarnRange_Bar = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_BuffWarnRange1,HealBot_Debuff_RangeWarning_List[HealBot_Config_Buffs.HealBot_CBWarnRange_Bar]) 
                    end
        info.checked = false;
        if HealBot_Config_Buffs.HealBot_CBWarnRange_Bar==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_BuffWarnRange2_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Debuff_RangeWarning_List), 1 do
        info.text = HealBot_Debuff_RangeWarning_List[j];
        info.func = function(self)
                        HealBot_Config_Buffs.HealBot_CBWarnRange_Aggro = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_BuffWarnRange2,HealBot_Debuff_RangeWarning_List[HealBot_Config_Buffs.HealBot_CBWarnRange_Aggro]) 
                    end
        info.checked = false;
        if HealBot_Config_Buffs.HealBot_CBWarnRange_Aggro==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_BuffWarnRange3_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Debuff_RangeWarning_List), 1 do
        info.text = HealBot_Debuff_RangeWarning_List[j];
        info.func = function(self)
                        HealBot_Config_Buffs.HealBot_CBWarnRange_Screen = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_BuffWarnRange3,HealBot_Debuff_RangeWarning_List[HealBot_Config_Buffs.HealBot_CBWarnRange_Screen]) 
                    end
        info.checked = false;
        if HealBot_Config_Buffs.HealBot_CBWarnRange_Screen==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_BuffWarnRange4_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Debuff_RangeWarning_List), 1 do
        info.text = HealBot_Debuff_RangeWarning_List[j];
        info.func = function(self)
                        HealBot_Config_Buffs.HealBot_CBWarnRange_Sound = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_BuffWarnRange4,HealBot_Debuff_RangeWarning_List[HealBot_Config_Buffs.HealBot_CBWarnRange_Sound]) 
                    end
        info.checked = false;
        if HealBot_Config_Buffs.HealBot_CBWarnRange_Sound==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

--------------------------------------------------------------------------------

function HealBot_Options_CDCTxt1_DropDown()
    local DebuffSpells_List = HealBot_Options_GetDebuffSpells_List(HealBot_Data["PCLASSTRIM"])
    local RacialDebuffSpells_List = HealBot_Options_GetRacialDebuffSpells_List(HealBot_Data["PRACE_EN"])
    local info = UIDropDownMenu_CreateInfo()
    info.text = HEALBOT_WORDS_NONE;
    info.func = function(self)
                    HealBot_Config_Cures.HealBotDebuffText[HealBot_Options_getDropDownId_bySpec(1)] = self:GetText()
                    HealBot_setOptions_Timer(50)
                    UIDropDownMenu_SetText(HealBot_Options_CDCTxt1,HEALBOT_WORDS_NONE)
                end
    info.checked = false;
    if HealBot_Config_Cures.HealBotDebuffText[HealBot_Options_getDropDownId_bySpec(1)]==HEALBOT_WORDS_NONE then info.checked = true end
    UIDropDownMenu_AddButton(info);
    for j=1, getn(DebuffSpells_List), 1 do
        local sName=HealBot_KnownSpell(DebuffSpells_List[j])
        if sName then
            info.text = sName;
            info.func = function(self)
                            HealBot_Config_Cures.HealBotDebuffText[HealBot_Options_getDropDownId_bySpec(1)] = self:GetText()
                            HealBot_setOptions_Timer(50)
                            UIDropDownMenu_SetText(HealBot_Options_CDCTxt1,sName)
                        end
            info.checked = false;
            if HealBot_Config_Cures.HealBotDebuffText[HealBot_Options_getDropDownId_bySpec(1)]==sName then info.checked = true end
            UIDropDownMenu_AddButton(info);
        end
    end
    for j=1, getn(RacialDebuffSpells_List), 1 do
        local rName = HealBot_KnownSpell(RacialDebuffSpells_List[j]);
        info.text = rName
        info.func = function(self)
                        HealBot_Config_Cures.HealBotDebuffText[HealBot_Options_getDropDownId_bySpec(1)] = self:GetText()
                        HealBot_setOptions_Timer(50)
                        UIDropDownMenu_SetText(HealBot_Options_CDCTxt1,rName)
                    end
        info.checked = false;
        if HealBot_Config_Cures.HealBotDebuffText[HealBot_Options_getDropDownId_bySpec(1)]==rName then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
    for j=1, getn(HealBot_Debuff_Item_List), 1 do
        local iName = GetItemInfo(HealBot_Debuff_Item_List[j]);
        if iName then
            info.text = iName
            info.func = function(self)
                            HealBot_Config_Cures.HealBotDebuffText[HealBot_Options_getDropDownId_bySpec(1)] = self:GetText()
                            HealBot_setOptions_Timer(50)
                            UIDropDownMenu_SetText(HealBot_Options_CDCTxt1,iName)
                        end
            info.checked = false;
            if HealBot_Config_Cures.HealBotDebuffText[HealBot_Options_getDropDownId_bySpec(1)]==iName then info.checked = true end
            UIDropDownMenu_AddButton(info);
        end
    end
end

function HealBot_Options_CDCTxt2_DropDown()
    local DebuffSpells_List = HealBot_Options_GetDebuffSpells_List(HealBot_Data["PCLASSTRIM"])
    local RacialDebuffSpells_List = HealBot_Options_GetRacialDebuffSpells_List(HealBot_Data["PRACE_EN"])
    local info = UIDropDownMenu_CreateInfo()
    info.text = HEALBOT_WORDS_NONE;
    info.func = function(self)
                    HealBot_Config_Cures.HealBotDebuffText[HealBot_Options_getDropDownId_bySpec(2)] = self:GetText()
                    HealBot_setOptions_Timer(50)
                    UIDropDownMenu_SetText(HealBot_Options_CDCTxt2,HEALBOT_WORDS_NONE)
                end
    info.checked = false;
    if HealBot_Config_Cures.HealBotDebuffText[HealBot_Options_getDropDownId_bySpec(2)]==HEALBOT_WORDS_NONE then info.checked = true end
    UIDropDownMenu_AddButton(info);
    for j=1, getn(DebuffSpells_List), 1 do
        local sName=HealBot_KnownSpell(DebuffSpells_List[j])
        if sName then
            info.text = sName;
            info.func = function(self)
                            HealBot_Config_Cures.HealBotDebuffText[HealBot_Options_getDropDownId_bySpec(2)] = self:GetText()
                            HealBot_setOptions_Timer(50)
                            UIDropDownMenu_SetText(HealBot_Options_CDCTxt2,sName)
                        end
            info.checked = false;
            if HealBot_Config_Cures.HealBotDebuffText[HealBot_Options_getDropDownId_bySpec(2)]==sName then info.checked = true end
            UIDropDownMenu_AddButton(info);
        end
    end
    for j=1, getn(RacialDebuffSpells_List), 1 do
        local rName = HealBot_KnownSpell(RacialDebuffSpells_List[j]);
        info.text = rName
        info.func = function(self)
                        HealBot_Config_Cures.HealBotDebuffText[HealBot_Options_getDropDownId_bySpec(2)] = self:GetText()
                        HealBot_setOptions_Timer(50)
                        UIDropDownMenu_SetText(HealBot_Options_CDCTxt2,rName)
                    end
        info.checked = false;
        if HealBot_Config_Cures.HealBotDebuffText[HealBot_Options_getDropDownId_bySpec(2)]==rName then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
    for j=1, getn(HealBot_Debuff_Item_List), 1 do
        local iName = GetItemInfo(HealBot_Debuff_Item_List[j]);
        if iName then
            info.text = iName
            info.func = function(self)
                            HealBot_Config_Cures.HealBotDebuffText[HealBot_Options_getDropDownId_bySpec(2)] = self:GetText()
                            HealBot_setOptions_Timer(50)
                            UIDropDownMenu_SetText(HealBot_Options_CDCTxt2,iName)
                        end
            info.checked = false;
            if HealBot_Config_Cures.HealBotDebuffText[HealBot_Options_getDropDownId_bySpec(2)]==iName then info.checked = true end
            UIDropDownMenu_AddButton(info);
        end
    end
end

function HealBot_Options_CDCTxt3_DropDown()
    local DebuffSpells_List = HealBot_Options_GetDebuffSpells_List(HealBot_Data["PCLASSTRIM"])
    local RacialDebuffSpells_List = HealBot_Options_GetRacialDebuffSpells_List(HealBot_Data["PRACE_EN"])
    local info = UIDropDownMenu_CreateInfo()
    info.text = HEALBOT_WORDS_NONE;
    info.func = function(self)
                    HealBot_Config_Cures.HealBotDebuffText[HealBot_Options_getDropDownId_bySpec(3)] = self:GetText()
                    HealBot_setOptions_Timer(50)
                    UIDropDownMenu_SetText(HealBot_Options_CDCTxt3,HEALBOT_WORDS_NONE)
                end
    info.checked = false;
    if HealBot_Config_Cures.HealBotDebuffText[HealBot_Options_getDropDownId_bySpec(3)]==HEALBOT_WORDS_NONE then info.checked = true end
    UIDropDownMenu_AddButton(info);
    for j=1, getn(DebuffSpells_List), 1 do
        local sName=HealBot_KnownSpell(DebuffSpells_List[j])
        if sName then
            info.text = sName;
            info.func = function(self)
                            HealBot_Config_Cures.HealBotDebuffText[HealBot_Options_getDropDownId_bySpec(3)] = self:GetText()
                            HealBot_setOptions_Timer(50)
                            UIDropDownMenu_SetText(HealBot_Options_CDCTxt3,sName)
                        end
            info.checked = false;
            if HealBot_Config_Cures.HealBotDebuffText[HealBot_Options_getDropDownId_bySpec(3)]==sName then info.checked = true end
            UIDropDownMenu_AddButton(info);
        end
    end
    for j=1, getn(RacialDebuffSpells_List), 1 do
        local rName = HealBot_KnownSpell(RacialDebuffSpells_List[j]);
        info.text = rName
        info.func = function(self)
                        HealBot_Config_Cures.HealBotDebuffText[HealBot_Options_getDropDownId_bySpec(3)] = self:GetText()
                        HealBot_setOptions_Timer(50)
                        UIDropDownMenu_SetText(HealBot_Options_CDCTxt3,rName)
                    end
        info.checked = false;
        if HealBot_Config_Cures.HealBotDebuffText[HealBot_Options_getDropDownId_bySpec(3)]==rName then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
    for j=1, getn(HealBot_Debuff_Item_List), 1 do
        local iName = GetItemInfo(HealBot_Debuff_Item_List[j]);
        if iName then
            info.text = iName
            info.func = function(self)
                            HealBot_Config_Cures.HealBotDebuffText[HealBot_Options_getDropDownId_bySpec(3)] = self:GetText()
                            HealBot_setOptions_Timer(50)
                            UIDropDownMenu_SetText(HealBot_Options_CDCTxt3,iName)
                        end
            info.checked = false;
            if HealBot_Config_Cures.HealBotDebuffText[HealBot_Options_getDropDownId_bySpec(3)]==iName then info.checked = true end
            UIDropDownMenu_AddButton(info);
        end
    end
end

function HealBot_Options_CDCGroups1_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_BuffTxt_List), 1 do
        info.text = HealBot_Options_BuffTxt_List[j];
        info.func = function(self)
                        HealBot_Config_Cures.HealBotDebuffDropDown[HealBot_Options_getDropDownId_bySpec(1)] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_CDCGroups1,HealBot_Options_BuffTxt_List[HealBot_Config_Cures.HealBotDebuffDropDown[HealBot_Options_getDropDownId_bySpec(1)]]) 
                        ClickedBuffGroupDD=1
                        HealBot_setOptions_Timer(50)
                    end
        info.checked = false;
        if HealBot_Config_Cures.HealBotDebuffDropDown[HealBot_Options_getDropDownId_bySpec(1)]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_CDCGroups2_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_BuffTxt_List), 1 do
        info.text = HealBot_Options_BuffTxt_List[j];
        info.func = function(self)
                        HealBot_Config_Cures.HealBotDebuffDropDown[HealBot_Options_getDropDownId_bySpec(2)] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_CDCGroups2,HealBot_Options_BuffTxt_List[HealBot_Config_Cures.HealBotDebuffDropDown[HealBot_Options_getDropDownId_bySpec(2)]]) 
                        ClickedBuffGroupDD=2
                        HealBot_setOptions_Timer(50)
                    end
        info.checked = false;
        if HealBot_Config_Cures.HealBotDebuffDropDown[HealBot_Options_getDropDownId_bySpec(2)]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_CDCGroups3_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_BuffTxt_List), 1 do
        info.text = HealBot_Options_BuffTxt_List[j];
        info.func = function(self)
                        HealBot_Config_Cures.HealBotDebuffDropDown[HealBot_Options_getDropDownId_bySpec(3)] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_CDCGroups3,HealBot_Options_BuffTxt_List[HealBot_Config_Cures.HealBotDebuffDropDown[HealBot_Options_getDropDownId_bySpec(3)]]) 
                        ClickedBuffGroupDD=3
                        HealBot_setOptions_Timer(50)
                    end
        info.checked = false;
        if HealBot_Config_Cures.HealBotDebuffDropDown[HealBot_Options_getDropDownId_bySpec(3)]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_CDCPriority1_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, 20, 1 do
        info.text = j;
        info.func = function(self)
                        HealBot_Config_Cures.HealBotDebuffPriority[HEALBOT_DISEASE_en] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_CDCPriority1,HealBot_Config_Cures.HealBotDebuffPriority[HEALBOT_DISEASE_en]) 
                        HealBot_Options_setCustomDebuffList()
                    end
        info.checked = false;
        if HealBot_Config_Cures.HealBotDebuffPriority[HEALBOT_DISEASE_en]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_CDCPriority2_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, 20, 1 do
        info.text = j;
        info.func = function(self)
                        HealBot_Config_Cures.HealBotDebuffPriority[HEALBOT_MAGIC_en] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_CDCPriority2,HealBot_Config_Cures.HealBotDebuffPriority[HEALBOT_MAGIC_en]) 
                        HealBot_Options_setCustomDebuffList()
                    end
        info.checked = false;
        if HealBot_Config_Cures.HealBotDebuffPriority[HEALBOT_MAGIC_en]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_CDCPriority3_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, 20, 1 do
        info.text = j;
        info.func = function(self)
                        HealBot_Config_Cures.HealBotDebuffPriority[HEALBOT_POISON_en] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_CDCPriority3,HealBot_Config_Cures.HealBotDebuffPriority[HEALBOT_POISON_en]) 
                        HealBot_Options_setCustomDebuffList()
                    end
        info.checked = false;
        if HealBot_Config_Cures.HealBotDebuffPriority[HEALBOT_POISON_en]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_CDCPriority4_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, 20, 1 do
        info.text = j;
        info.func = function(self)
                        HealBot_Config_Cures.HealBotDebuffPriority[HEALBOT_CURSE_en] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_CDCPriority4,HealBot_Config_Cures.HealBotDebuffPriority[HEALBOT_CURSE_en]) 
                        HealBot_Options_setCustomDebuffList()
                    end
        info.checked = false;
        if HealBot_Config_Cures.HealBotDebuffPriority[HEALBOT_CURSE_en]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_CDCPriorityC_DropDown()
    local s,e=1,20
    local info = UIDropDownMenu_CreateInfo()
--    if HealBot_Options_StorePrev["CDebuffcustomNameDefault"]==HEALBOT_CUSTOM_CAT_CUSTOM_AUTOMATIC then
--        s,e=15,15
--    end
    for j=s, e, 1 do
        info.text = j;
        info.func = function(self)
                        local x=self:GetID()
                        if HealBot_Options_StorePrev["CDebuffcustomName"] then
                            cName=HealBot_Options_StorePrev["CDebuffcustomName"]
                            HealBot_Globals.HealBot_Custom_Debuffs[cName] = x
                            HealBot_Options_CDC_checkStatus(cName)
                            HealBot_ClearDebuffCache(cName)
                            HealBot_CheckAllActiveDebuffs()
                        end
                        UIDropDownMenu_SetSelectedID(HealBot_Options_CDCPriorityC,x) 
                        HealBot_Options_setCustomDebuffList()
                    end
        info.checked = false;
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_BuffPriorityC_DropDown()
    local s,e=1,20
    local info = UIDropDownMenu_CreateInfo()
--    if HealBot_Options_StorePrev["CDebuffcustomNameDefault"]==HEALBOT_CUSTOM_CAT_CUSTOM_AUTOMATIC then
--        s,e=15,15
--    end
    for j=s, e, 1 do
        info.text = j;
        info.func = function(self)
                        local x=self:GetID()
                        if HealBot_Options_StorePrev["HoTname"] then
                            local sId=HealBot_Options_CDebuffGetId(HealBot_Options_StorePrev["HoTname"])
                            HealBot_Globals.HealBot_Custom_Buffs[sId] = x
                            HealBot_Options_StorePrev["customBuffPriority"]=x
                            HealBot_Options_CustomBuffs_checkStatus(sId)
                        end
                        UIDropDownMenu_SetSelectedID(HealBot_Options_BuffPriorityC,x) 
                        HealBot_Options_setCustomBuffList()
                    end
        info.checked = false;
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_CustomBuffs_checkStatus(spellId)
    if not HealBot_Globals.CustomBuffBarColour[spellId] then
        HealBot_Globals.CustomBuffBarColour[spellId]={}
        HealBot_Globals.CustomBuffBarColour[spellId].R = HealBot_Globals.CustomBuffBarColour[HEALBOT_CUSTOM_en.."Buff"].R
        HealBot_Globals.CustomBuffBarColour[spellId].G = HealBot_Globals.CustomBuffBarColour[HEALBOT_CUSTOM_en.."Buff"].G
        HealBot_Globals.CustomBuffBarColour[spellId].B = HealBot_Globals.CustomBuffBarColour[HEALBOT_CUSTOM_en.."Buff"].B
        HealBot_SetCustomBuffBarColours()
    end
end

function HealBot_Options_CDC_checkStatus(cName)
    if not cName then return end
    
    if (HealBot_GlobalsDefaults.HealBot_Custom_Debuffs[cName] or 0)~=HealBot_Globals.HealBot_Custom_Debuffs[cName] then
        if not HealBot_Globals.CDCBarColour[cName] then
            HealBot_Globals.CDCBarColour[cName]={}
            HealBot_Globals.CDCBarColour[cName].R = HealBot_Globals.CDCBarColour[HEALBOT_CUSTOM_en.."15"].R
            HealBot_Globals.CDCBarColour[cName].G = HealBot_Globals.CDCBarColour[HEALBOT_CUSTOM_en.."15"].G
            HealBot_Globals.CDCBarColour[cName].B = HealBot_Globals.CDCBarColour[HEALBOT_CUSTOM_en.."15"].B
            HealBot_SetCDCBarColours()
        end
    end
end

function HealBot_Options_CDCWarnRange1_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Debuff_RangeWarning_List), 1 do
        info.text = HealBot_Debuff_RangeWarning_List[j];
        info.func = function(self)
                        HealBot_Config_Cures.HealBot_CDCWarnRange_Bar = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_CDCWarnRange1,HealBot_Debuff_RangeWarning_List[HealBot_Config_Cures.HealBot_CDCWarnRange_Bar]) 
                    end
        info.checked = false;
        if HealBot_Config_Cures.HealBot_CDCWarnRange_Bar==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_CDCWarnRange2_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Debuff_RangeWarning_List), 1 do
        info.text = HealBot_Debuff_RangeWarning_List[j];
        info.func = function(self)
                        HealBot_Config_Cures.HealBot_CDCWarnRange_Aggro = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_CDCWarnRange2,HealBot_Debuff_RangeWarning_List[HealBot_Config_Cures.HealBot_CDCWarnRange_Aggro]) 
                    end
        info.checked = false;
        if HealBot_Config_Cures.HealBot_CDCWarnRange_Aggro==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_CDCWarnRange3_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Debuff_RangeWarning_List), 1 do
        info.text = HealBot_Debuff_RangeWarning_List[j];
        info.func = function(self)
                        HealBot_Config_Cures.HealBot_CDCWarnRange_Screen = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_CDCWarnRange3,HealBot_Debuff_RangeWarning_List[HealBot_Config_Cures.HealBot_CDCWarnRange_Screen]) 
                    end
        info.checked = false;
        if HealBot_Config_Cures.HealBot_CDCWarnRange_Screen==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_CDCWarnRange4_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Debuff_RangeWarning_List), 1 do
        info.text = HealBot_Debuff_RangeWarning_List[j];
        info.func = function(self)
                        HealBot_Config_Cures.HealBot_CDCWarnRange_Sound = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_CDCWarnRange4,HealBot_Debuff_RangeWarning_List[HealBot_Config_Cures.HealBot_CDCWarnRange_Sound]) 
                    end
        info.checked = false;
        if HealBot_Config_Cures.HealBot_CDCWarnRange_Sound==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

HealBot_Options_StorePrev["CDebuffCatID"] = 2

function HealBot_Options_CDebuffTextID(dName)
    local cdName=dName
    local name, _, _, _, _, _, spellId = GetSpellInfo(dName)
    if name and spellId then cdName=name.." ("..spellId..")" end
    return cdName
end

function HealBot_Options_CDebuffCat_genList()
    local tmpCDebuffCat_List={}
    local j=0
    local dText=""
    for dID,x in pairs(HealBot_Globals.Custom_Debuff_Categories) do
        if HealBot_Options_StorePrev["CDebuffCatID"]==x and HealBot_Globals.HealBot_Custom_Debuffs[dID] then
            local dName=HealBot_Options_CDebuffTextID(dID)
            if tonumber(dName) == nil then
                table.insert(tmpCDebuffCat_List, dName)
                j=j+1
            else
                HealBot_Options_DeleteCDebuff(dID)
            end
        end
    end
    local x=nil
    if j>0 then
        table.sort(tmpCDebuffCat_List)
        for j=1, getn(tmpCDebuffCat_List), 1 do
            dText=HealBot_Options_CDebuffGetId(tmpCDebuffCat_List[j])
            if dText==HealBot_Options_StorePrev["CDebuffcustomName"] then
                HealBot_Options_StorePrev["CDebuffcustomID"]=j
                x=true
                break
            end
        end
    end
    if not x then 
        HealBot_Options_StorePrev["CDebuffcustomID"]=1 
        dText=HealBot_Options_CDebuffGetId(tmpCDebuffCat_List[HealBot_Options_StorePrev["CDebuffcustomID"]])
        HealBot_Options_StorePrev["CDebuffcustomNameDefault"]=dText
        HealBot_Options_CDebuffCatNameUpdate()
    end
    dText=HealBot_Options_CDebuffGetId(tmpCDebuffCat_List[HealBot_Options_StorePrev["CDebuffcustomID"]])
    HealBot_Options_StorePrev["CDebuffcustomName"]=dText
    return tmpCDebuffCat_List
end

function HealBot_Options_CDebuffCat_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_CDebuffCat_List), 1 do
        info.text = HealBot_CDebuffCat_List[j];
        info.func = function(self)
                        HealBot_Options_StorePrev["CDebuffCatID"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_CDebuffCat,HealBot_CDebuffCat_List[HealBot_Options_StorePrev["CDebuffCatID"]]) 
                        HealBot_Options_StorePrev["CDebuffcustomNameDefault"]=HealBot_Options_StorePrev["CDebuffcustomName"]       
                        local CDebuffCat_List = HealBot_Options_CDebuffCat_genList()
                        HealBot_Options_StorePrev["numCustomDebuffs"]=#CDebuffCat_List
                        HealBot_Options_CDebuffCatNameUpdate()
                        HealBot_SetCDCBarColours();
                        HealBot_Options_InitSub(402)
                        HealBot_Options_InitSub(403)
                        HealBot_Options_InitSub(404)
                        --if HealBot_Options_StorePrev["CDebuffCatID"]==1 then
                        --    HealBot_Options_NewCDebuffBtn:Disable();
                        --end
                    end
        info.checked = false;
        if HealBot_Options_StorePrev["CDebuffCatID"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_CDebuffGetId(cdText)
    local rText=cdText
    if cdText then
        local s=string.find(cdText, "%(")
        local e=string.find(cdText, "%)")
        if s and e then
            rText=tonumber(string.sub(cdText,s+1,e-1))
        end
    end
    return rText
end

function HealBot_Options_CDebuffTxt1_DropDown(self, level, menuList)
    local info = UIDropDownMenu_CreateInfo()
    local CDebuffCat_List = HealBot_Options_CDebuffCat_genList()
    if getn(CDebuffCat_List) > 10 then
        if level == 1 then
            for j=1, ceil(getn(CDebuffCat_List)/10), 1 do
                local n=j*10
                if n > getn(CDebuffCat_List) then n=getn(CDebuffCat_List) end
                info.text = ((j*10)-9).." - "..n;
                info.hasArrow = true
                info.menuList = j, true, j
                UIDropDownMenu_AddButton(info)
            end
        else 
            local n=menuList*10
            local dText=nil
            if n > getn(CDebuffCat_List) then n=getn(CDebuffCat_List) end
            for j=((menuList*10)-9), n, 1 do
                info.text = CDebuffCat_List[j];
                info.func = function(self)
                                HealBot_Options_StorePrev["CDebuffcustomID"] = self:GetID()
                                local cdText=self.value
                                dText=HealBot_Options_CDebuffGetId(cdText)
                                HealBot_Options_StorePrev["CDebuffcustomName"] = dText
                                HealBot_Options_StorePrev["CDebuffcustomNameDefault"]=dText
                                UIDropDownMenu_SetText(HealBot_Options_CDebuffTxt1,cdText) 
                                HealBot_Options_InitSub(403)
                                HealBot_Options_InitSub(404)
                                HealBot_SetCDCBarColours();
                            end
                info.checked = false;
                dText=HealBot_Options_CDebuffGetId(CDebuffCat_List[j])
                if HealBot_Options_StorePrev["CDebuffcustomName"]==dText then info.checked = true end
                UIDropDownMenu_AddButton(info, level);
            end
        end
    else
        local dText=nil
        for j=1, getn(CDebuffCat_List), 1 do
            info.text = CDebuffCat_List[j];
            info.func = function(self)
                            HealBot_Options_StorePrev["CDebuffcustomID"] = self:GetID()
                            local cdText=self.value
                            dText=HealBot_Options_CDebuffGetId(cdText)
                            HealBot_Options_StorePrev["CDebuffcustomName"] = dText
                            HealBot_Options_StorePrev["CDebuffcustomNameDefault"]=dText
                            UIDropDownMenu_SetText(HealBot_Options_CDebuffTxt1,cdText) 
                            HealBot_Options_InitSub(403)
                            HealBot_Options_InitSub(404)
                            HealBot_SetCDCBarColours();
                        end
            info.checked = false;
            dText=HealBot_Options_CDebuffGetId(CDebuffCat_List[j])
            if HealBot_Options_StorePrev["CDebuffcustomName"]==dText then info.checked = true end
            UIDropDownMenu_AddButton(info);
        end
    end
    HealBot_Options_StorePrev["numCustomDebuffs"]=#CDebuffCat_List
    HealBot_Options_CDebuffCatNameUpdate()
end

HealBot_Options_StorePrev["numCustomDebuffs"]=0
function HealBot_Options_CDebuffCatNameUpdate()
    if HealBot_Options_StorePrev["CDebuffCatID"]==1 or HealBot_Options_StorePrev["numCustomDebuffs"]==0 then
        HealBot_Options_StorePrev["customDebuffPriority"]=15
        --HealBot_Options_StorePrev["CDebuffcustomName"]=nil
        local g=_G["HealBot_Options_CDCPriorityCustomText"]
        g:SetText(HealBot_Options_StorePrev["customDebuffPriority"]);
        HealBot_Options_DeleteCDebuffBtn:Disable();
        HealBot_Options_ResetCDebuffBtn:Disable();
        HealBot_Options_NewCDebuffBtn:Disable();
        HealBot_Options_CDCReverseDurC:Hide()
        HealBot_Options_CDCCastBy:Hide();
        HealBot_Options_CDCCastByCustom:Show()
        HealBot_Options_CDCPriorityCustom:Show()
        HealBot_Options_CDCPriorityC:Hide()
        if HealBot_Options_StorePrev["CDebuffCatID"]>1 then
            HealBot_CustomColorpickb:Disable();
            HealBot_Options_CustomDebuffPresetColour:Disable();
            HealBot_Options_CDCCol_OnOff:Hide();
        else
            HealBot_CustomColorpickb:Enable();
            HealBot_Options_CustomDebuffPresetColour:Enable();
            HealBot_Options_CDCCol_OnOff:Show();
        end
    else
        if HealBot_GlobalsDefaults.HealBot_Custom_Debuffs[HealBot_Options_StorePrev["CDebuffcustomNameDefault"]] then
            HealBot_Options_StorePrev["customDebuffPriority"]=HealBot_GlobalsDefaults.HealBot_Custom_Debuffs[HealBot_Options_StorePrev["CDebuffcustomNameDefault"]]
        end
        HealBot_Options_CDCReverseDurC:Show()
        HealBot_Options_CDCCastByCustom:Hide()
        HealBot_Options_CDCPriorityCustom:Hide()
        HealBot_Options_CDCCastBy:Show();
        HealBot_Options_CDCPriorityC:Show();        
        HealBot_Options_DeleteCDebuffBtn:Enable();
        HealBot_Options_ResetCDebuffBtn:Enable();
        HealBot_CustomColorpickb:Enable();
        HealBot_Options_CustomDebuffPresetColour:Enable();
        HealBot_Options_CDCCol_OnOff:Show();
    end
end

function HealBot_Options_CDCCastByCustom_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    info.text = HEALBOT_CUSTOM_CASTBY_EVERYONE
    info.checked = true;
    UIDropDownMenu_AddButton(info);
end

function HealBot_Options_CDCCastBy_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    local cby = nil
    if HealBot_Globals.CureCustomDefaultCastBy=="ALL" then
        cby = HEALBOT_CUSTOM_CASTBY_EVERYONE
    elseif HealBot_Globals.CureCustomDefaultCastBy=="ENEMY" then
        cby = HEALBOT_CUSTOM_CASTBY_ENEMY
    end
    for j=1, getn(HealBot_CDebuffCasyBy_List), 1 do
        info.text = HealBot_CDebuffCasyBy_List[j];
        info.func = function(self)
                        HealBot_Options_StorePrev["CDebuffcustomCastBy"] = self:GetText()
                        if HealBot_Options_StorePrev["CDebuffcustomName"] and self:GetID()>=1 and cby~=HealBot_CDebuffCasyBy_List[j] then
                            HealBot_Globals.FilterCustomDebuff[HealBot_Options_StorePrev["CDebuffcustomName"]]=self:GetID()
                        elseif HealBot_Options_StorePrev["CDebuffcustomName"] then
                            HealBot_Globals.FilterCustomDebuff[HealBot_Options_StorePrev["CDebuffcustomName"]]=nil
                        end
                        UIDropDownMenu_SetText(HealBot_Options_CDCCastBy,HealBot_Options_StorePrev["CDebuffcustomCastBy"]) 
                        HealBot_setOptions_Timer(20)
                    end
        info.checked = false;
        if HealBot_Options_StorePrev["CDebuffcustomName"] then
            local x=HealBot_Globals.FilterCustomDebuff[HealBot_Options_StorePrev["CDebuffcustomName"]] or 0
            if x==0 then
                if cby and cby==HealBot_CDebuffCasyBy_List[j] then x=j; end
            end
            if x==j then info.checked = true; end 
        end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_NewCDebuff_OnTextChanged(self)
    local text = strtrim(self:GetText())
    if strlen(text)>0 and HealBot_Options_StorePrev["CDebuffCatID"]>1 then
        HealBot_Options_NewCDebuffBtn:Enable();
    else
        HealBot_Options_NewCDebuffBtn:Disable();
    end
end

function HealBot_Options_NewHoTBuff_OnTextChanged(self)
    local text = strtrim(self:GetText())
    if strlen(text)>0 then
        HealBot_Options_NewBuffHoTBtn:Enable();
    else
        HealBot_Options_NewBuffHoTBtn:Disable();
    end
end

function HealBot_Options_BuffResetList()
    HealBot_Options_InitSub(502)
    local BuffCat_List = HealBot_Options_Class_HoTctlName_genList()
    HealBot_Options_StorePrev["numCustomBuffs"]=#BuffCat_List
    HealBot_Options_BuffCatNameUpdate()
end

function HealBot_Options_CDebuffResetList()
    HealBot_Options_InitSub(402)
    HealBot_Options_InitSub(403)
    HealBot_Options_InitSub(404)
end

function HealBot_Options_NewCDebuffBtn_OnClick(NewCDebuffTxt)
    local name, _, _, _, _, _, spellId = GetSpellInfo(NewCDebuffTxt)
    local useId=NewCDebuffTxt
    if spellId then useId=spellId end
    if not name then name=NewCDebuffTxt end
    local unique=true;
    for k, _ in pairs(HealBot_Globals.HealBot_Custom_Debuffs) do
        if k==useId then unique=false; end
    end
    if unique then
        HealBot_Globals.HealBot_Custom_Debuffs[useId]=10;
        HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[useId]=true;
    end
    HealBot_Globals.Custom_Debuff_Categories[useId]=HealBot_Options_StorePrev["CDebuffCatID"]
    HealBot_Options_StorePrev["CDebuffcustomName"]=useId
    HealBot_Options_NewCDebuff:SetText("")
    HealBot_Options_CDC_checkStatus(useId)
  --  UIDropDownMenu_SetSelectedValue(HealBot_Options_CDebuffTxt1, useId);
    HealBot_setOptions_Timer(20) 
    HealBot_Options_CDebuffResetList()
    HealBot_Globals.CatchAltDebuffIDs[name]=true
end

function HealBot_Options_NewHoTBuffBtn_OnClick(NewHoTBuffTxt)
    local name, _, _, _, _, _, spellId = GetSpellInfo(NewHoTBuffTxt)
    local useId=NewHoTBuffTxt
    if spellId then useId=spellId end
    if not name then name=NewHoTBuffTxt end
    local unique=true;
    local hbClassHoTwatch=HealBot_Globals.WatchHoT
    for xClass,_  in pairs(hbClassHoTwatch) do
        local HealBot_configClassHoTClass=HealBot_Globals.WatchHoT[xClass]
        for bId,x  in pairs(HealBot_configClassHoTClass) do
            if bIdk==useId then unique=false; end
        end
    end
    if unique then
        HealBot_Globals.WatchHoT[HealBot_Options_StorePrev["FilterHoTctlNameTrim"]][useId]=2
    end
    HealBot_Options_NewBuffHoT:SetText("")
    HealBot_Options_StorePrev["HoTname"]=HealBot_Options_CDebuffTextID(useId)
    HealBot_setOptions_Timer(170)
    HealBot_Options_BuffResetList()
end

function HealBot_Options_ConfirmNewCDebuff()
    local NewCDebuffTxt=strtrim(HealBot_Options_NewCDebuff:GetText())
    local name, _, _, _, _, _, _ = GetSpellInfo(NewCDebuffTxt)
    if not name then name=NewCDebuffTxt end
    if NewCDebuffTxt and NewCDebuffTxt~="" then
        StaticPopupDialogs["HEALBOT_OPTIONS_NEWCDEBUFF"] = {
            text = HEALBOT_OPTIONS_SAVESKIN..": "..(name or NewCDebuffTxt),
            button1 = HEALBOT_WORDS_YES,
            button2 = HEALBOT_WORDS_NO,
            OnAccept = function()
                HealBot_Options_NewCDebuffBtn_OnClick(NewCDebuffTxt)
            end,
            timeout = 0,
            whileDead = 1,
            hideOnEscape = 1
        };
    
        StaticPopup_Show ("HEALBOT_OPTIONS_NEWCDEBUFF", NewCDebuffTxt);
    else
            StaticPopupDialogs["HEALBOT_OPTIONS_ERROR"] = {
                text = HEALBOT_WORDS_ERROR..": %s",
                button1 = OKAY,
                showAlert = 1,
                timeout = 0,
                whileDead = 1,
                hideOnEscape = 1
            };
        
            StaticPopup_Show ("HEALBOT_OPTIONS_ERROR", HEALBOT_SPELL_NOT_FOUND);
    end
end

function HealBot_Options_ConfirmNewHoTBuff()
    local NewHoTBuffTxt=strtrim(HealBot_Options_NewBuffHoT:GetText())
    local name, _, _, _, _, _, _ = GetSpellInfo(NewHoTBuffTxt)
    if not name then name=NewHoTBuffTxt end
    if NewHoTBuffTxt and NewHoTBuffTxt~="" then
        StaticPopupDialogs["HEALBOT_OPTIONS_NEWCDEBUFF"] = {
            text = HEALBOT_OPTIONS_SAVESKIN..": "..name,
            button1 = HEALBOT_WORDS_YES,
            button2 = HEALBOT_WORDS_NO,
            OnAccept = function()
                HealBot_Options_NewHoTBuffBtn_OnClick(NewHoTBuffTxt)
            end,
            timeout = 0,
            whileDead = 1,
            hideOnEscape = 1
        };
    
        StaticPopup_Show ("HEALBOT_OPTIONS_NEWCDEBUFF", NewHoTBuffTxt);
    else
            StaticPopupDialogs["HEALBOT_OPTIONS_ERROR"] = {
                text = HEALBOT_WORDS_ERROR..": %s",
                button1 = OKAY,
                showAlert = 1,
                timeout = 0,
                whileDead = 1,
                hideOnEscape = 1
            };
        
            StaticPopup_Show ("HEALBOT_OPTIONS_ERROR", HEALBOT_SPELL_NOT_FOUND);
    end
end

function HealBot_Options_DeleteCDebuff(dId)
    HealBot_Globals.Custom_Debuff_Categories[dId]=nil;
    HealBot_Globals.HealBot_Custom_Debuffs[dId]=nil;
    if HealBot_Globals.CDCBarColour[dId] then HealBot_Globals.CDCBarColour[dId]=nil end
    HealBot_Globals.HealBot_Custom_Debuffs_RevDur[dId]=nil
    HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[dId]=nil
    if HealBot_Globals.FilterCustomDebuff[dId] then HealBot_Globals.FilterCustomDebuff[dId]=nil end
    HealBot_Globals.IgnoreCustomDebuff[dId]=nil
    HealBot_Options_InitSub(402)
    HealBot_Options_InitSub(403)
    HealBot_Options_InitSub(404)
    HealBot_SetCDCBarColours();
    HealBot_Options_CDebuffResetList()
    HealBot_ClearDebuffCache(dId)
    HealBot_CheckAllActiveDebuffs()
end

function HealBot_Options_DeleteCDebuffBtn_OnClick()
    local sName=HealBot_Options_SpellGetName(HealBot_Options_StorePrev["CDebuffcustomName"])
    HealBot_Globals.CatchAltDebuffIDs[sName]=nil
    HealBot_Options_DeleteCDebuff(HealBot_Options_StorePrev["CDebuffcustomName"])
end

function HealBot_Options_DeleteBuffHoT(classTr, sId)
    HealBot_Globals.WatchHoT[classTr][sId]=nil
    HealBot_Globals.IgnoreCustomBuff[sId]=nil
    HealBot_Globals.HealBot_Custom_Buffs[sId]=nil
    HealBot_Globals.CustomBuffBarColour[sId]=nil
    HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[sId]=nil
    HealBot_setOptions_Timer(169)
    HealBot_setOptions_Timer(170)
end

function HealBot_Options_DeleteBuffHoTBtn_OnClick()
    local sId=HealBot_Options_CDebuffGetId(HealBot_Options_StorePrev["HoTname"])
    HealBot_Options_DeleteBuffHoT(HealBot_Options_StorePrev["FilterHoTctlNameTrim"], sId)
end

function HealBot_Options_EnableDisableCDBtn_OnClick(self)
    local InstName=HealBot_retLuVars("hbInsName")
    if HealBot_Globals.IgnoreCustomDebuff[HealBot_Options_StorePrev["CDebuffcustomName"]] and HealBot_Globals.IgnoreCustomDebuff[HealBot_Options_StorePrev["CDebuffcustomName"]][InstName] then
        HealBot_Globals.IgnoreCustomDebuff[HealBot_Options_StorePrev["CDebuffcustomName"]][InstName]=nil
    else
        if not HealBot_Globals.IgnoreCustomDebuff[HealBot_Options_StorePrev["CDebuffcustomName"]] then
            HealBot_Globals.IgnoreCustomDebuff[HealBot_Options_StorePrev["CDebuffcustomName"]]={}
        end
        HealBot_Globals.IgnoreCustomDebuff[HealBot_Options_StorePrev["CDebuffcustomName"]][InstName]=true
    end
    HealBot_Options_SetEnableDisableCDBtn()
    HealBot_ClearDebuffCache(HealBot_Options_StorePrev["CDebuffcustomName"])
    HealBot_setOptions_Timer(20)
end

function HealBot_Options_SetEnableDisableCDBtn()
    local InstName=HealBot_retLuVars("hbInsName")
    HealBot_Options_EnableDisableCDBtn:Enable()
    local dName=HealBot_Options_CDebuffTextID(HealBot_Options_StorePrev["CDebuffcustomName"])
    if HealBot_Globals.IgnoreCustomDebuff[HealBot_Options_StorePrev["CDebuffcustomName"]] and HealBot_Globals.IgnoreCustomDebuff[HealBot_Options_StorePrev["CDebuffcustomName"]][InstName] then
        HealBot_Options_EnableDisableCDText:SetTextColor(0.88,0.1,0.1)
        HealBot_Options_EnableDisableCDText:SetText(InstName..": "..dName.." "..HEALBOT_SKIN_DISTEXT)
        HealBot_Options_EnableDisableCDBtn:SetText(HEALBOT_WORD_ENABLE)
    elseif HealBot_Options_StorePrev["CDebuffcustomName"] and HealBot_Options_StorePrev["CDebuffCatID"]>1 then
        HealBot_Options_EnableDisableCDText:SetTextColor(0.1,1,0.1)
        HealBot_Options_EnableDisableCDText:SetText(InstName..": "..dName.." "..HEALBOT_SKIN_ENTEXT)
        HealBot_Options_EnableDisableCDBtn:SetText(HEALBOT_WORD_DISABLE)
    else
        HealBot_Options_EnableDisableCDText:SetTextColor(0.7,0.7,0)
        HealBot_Options_EnableDisableCDText:SetText(" ")
        HealBot_Options_EnableDisableCDBtn:SetText(HEALBOT_WORD_DISABLE)
        HealBot_Options_EnableDisableCDBtn:Disable()
    end
end

function HealBot_Options_EnableDisableBuffBtn_OnClick(self)
    local InstName=HealBot_retLuVars("hbInsName")
    local sId=HealBot_Options_CDebuffGetId(HealBot_Options_StorePrev["HoTname"])
    if HealBot_Globals.IgnoreCustomBuff[sId] and HealBot_Globals.IgnoreCustomBuff[sId][InstName] then
        HealBot_Globals.IgnoreCustomBuff[sId][InstName]=nil
    else
        if not HealBot_Globals.IgnoreCustomBuff[sId] then
            HealBot_Globals.IgnoreCustomBuff[sId]={}
        end
        HealBot_Globals.IgnoreCustomBuff[sId][InstName]=true
    end
    HealBot_Options_SetEnableDisableBuffBtn()
end

function HealBot_Options_SetEnableDisableBuffBtn()
    local InstName=HealBot_retLuVars("hbInsName")
    HealBot_Options_EnableDisableBuffBtn:Enable()
    local bName=HealBot_Options_CDebuffTextID(HealBot_Options_StorePrev["HoTname"])
    local sId=HealBot_Options_CDebuffGetId(HealBot_Options_StorePrev["HoTname"])
    if HealBot_Globals.IgnoreCustomBuff[sId] and HealBot_Globals.IgnoreCustomBuff[sId][InstName] then
        HealBot_Options_EnableDisableBuffText:SetTextColor(0.88,0.1,0.1)
        HealBot_Options_EnableDisableBuffText:SetText(InstName..": "..bName.." "..HEALBOT_SKIN_DISTEXT)
        HealBot_Options_EnableDisableBuffBtn:SetText(HEALBOT_WORD_ENABLE)
    elseif bName then
        HealBot_Options_EnableDisableBuffText:SetTextColor(0.1,1,0.1)
        HealBot_Options_EnableDisableBuffText:SetText(InstName..": "..bName.." "..HEALBOT_SKIN_ENTEXT)
        HealBot_Options_EnableDisableBuffBtn:SetText(HEALBOT_WORD_DISABLE)
    else
        HealBot_Options_EnableDisableBuffText:SetTextColor(0.88,0.1,0)
        HealBot_Options_EnableDisableBuffText:SetText("")
        HealBot_Options_EnableDisableBuffBtn:SetText(HEALBOT_WORD_ENABLE)
        HealBot_Options_EnableDisableBuffBtn:Disable()
    end
    HealBot_Options_BuffCatNameUpdate()
end

function HealBot_Options_RevDurCDebuffBtn_OnClick(self)
    if self:GetChecked() then
        if HealBot_Options_StorePrev["CDebuffcustomName"] and HealBot_Options_StorePrev["CDebuffCatID"]>1 then
            HealBot_Globals.HealBot_Custom_Debuffs_RevDur[HealBot_Options_StorePrev["CDebuffcustomName"]] = true
        else
            HealBot_Options_CDCReverseDurC:SetChecked(0)
        end
    else
        if HealBot_Options_StorePrev["CDebuffcustomName"] then
            HealBot_Globals.HealBot_Custom_Debuffs_RevDur[HealBot_Options_StorePrev["CDebuffcustomName"]] = nil
        end
    end
end

function HealBot_Options_CDCAll_OnClick(self, debuffType)
    if self:GetChecked() then
        HealBot_Config_Cures.HealBot_Custom_Defuffs_All[debuffType]=true
    else
        HealBot_Config_Cures.HealBot_Custom_Defuffs_All[debuffType]=false
    end
end

function HealBot_Options_CDCAllBoss_OnClick(self, debuffType)
    if self:GetChecked() then
        HealBot_Config_Cures.AlwaysShowBoss=true
    else
        HealBot_Config_Cures.AlwaysShowBoss=false
    end
end

function HealBot_Options_CDCAllBossStrict_OnClick(self, debuffType)
    if self:GetChecked() then
        HealBot_Config_Cures.AlwaysShowBossStrict=true
    else
        HealBot_Config_Cures.AlwaysShowBossStrict=false
    end
end

function HealBot_Options_ResetCDebuff()
    local sName=HealBot_Options_SpellGetName(HealBot_Options_StorePrev["CDebuffcustomName"])
    HealBot_Options_DeleteCDebuffBtn_OnClick()
    HealBot_Options_NewCDebuffBtn_OnClick(sName)
    HealBot_Options_InitSub(402)
    HealBot_Options_InitSub(403)
    HealBot_Options_InitSub(404)
    HealBot_SetCDCBarColours();
    HealBot_Globals.CatchAltDebuffIDs[sName]=true
end

HealBot_Options_StorePrev["customdebufftextpage"]=1
function HealBot_Options_setCustomDebuffList()
    local customPriority = {}
    local customListPos=0
    local textname=nil
    for dID, x in pairs(HealBot_Globals.HealBot_Custom_Debuffs) do
        local dName=HealBot_Options_CDebuffTextID(dID)
        if tonumber(dName) == nil then
            if not customPriority[x] then customPriority[x]={} end
            customPriority[x][dID]=dName
        else
            HealBot_Options_DeleteCDebuff(dID)
        end
    end
    local x=HealBot_Config_Cures.HealBotDebuffPriority[HEALBOT_DISEASE_en]
    if not customPriority[x] then customPriority[x]={} end
    customPriority[x][HEALBOT_DISEASE_en]=HEALBOT_DISEASE
    x=HealBot_Config_Cures.HealBotDebuffPriority[HEALBOT_MAGIC_en]
    if not customPriority[x] then customPriority[x]={} end
    customPriority[x][HEALBOT_MAGIC_en]=HEALBOT_MAGIC
    x=HealBot_Config_Cures.HealBotDebuffPriority[HEALBOT_CURSE_en]
    if not customPriority[x] then customPriority[x]={} end
    customPriority[x][HEALBOT_CURSE_en]=HEALBOT_CURSE
    x=HealBot_Config_Cures.HealBotDebuffPriority[HEALBOT_POISON_en]
    if not customPriority[x] then customPriority[x]={} end
    customPriority[x][HEALBOT_POISON_en]=HEALBOT_POISON
    local startEntry=((HealBot_Options_StorePrev["customdebufftextpage"]-1)*30)
    local endEntry=HealBot_Options_StorePrev["customdebufftextpage"]*30
    local pageNext=false
    for j=1,20 do
        if customPriority[j] then
            for z, dName in pairs(customPriority[j]) do
                customListPos=customListPos+1
                dName=HealBot_Options_CDebuffTextID(dName) or " "
                if customListPos>startEntry and customListPos<endEntry+1 then
                    local r,g,b=0,0,0
                    textname=_G["HealBot_Options_CustomDebuff_List"..(customListPos-startEntry)]
                    if j<10 then
                        textname:SetText("0"..j.." - "..dName)
                    else
                        textname:SetText(j.." - "..dName)
                    end
                    if HealBot_Globals.CDCBarColour[z] then
                        r=HealBot_Globals.CDCBarColour[z].R or 0.45
                        g=HealBot_Globals.CDCBarColour[z].G or 0
                        b=HealBot_Globals.CDCBarColour[z].B or 0.26
                    elseif HealBot_Config_Cures.CDCBarColour[z] then
                        r=HealBot_Config_Cures.CDCBarColour[z].R or 0.7
                        g=HealBot_Config_Cures.CDCBarColour[z].G or 0.2
                        b=HealBot_Config_Cures.CDCBarColour[z].B or 0.5
                    else
                        local customDebuffPriority=HEALBOT_CUSTOM_en.."15"
                        r=HealBot_Globals.CDCBarColour[customDebuffPriority].R or 0.45
                        g=HealBot_Globals.CDCBarColour[customDebuffPriority].G or 0
                        b=HealBot_Globals.CDCBarColour[customDebuffPriority].B or 0.26
                    end
                    if r<0.2 and g<0.2 and b<0.2 then
                        r=r+0.4
                        g=g+0.4
                        b=b+0.4
                    elseif r<0.3 and g<0.3 and b<0.3 then
                        r=r+0.3
                        g=g+0.3
                        b=b+0.3
                    elseif r<0.4 and g<0.4 and b<0.4 then
                        r=r+0.2
                        g=g+0.2
                        b=b+0.2
                    elseif r<0.5 and g<0.5 and b<0.5 then
                        r=r+0.1
                        g=g+0.1
                        b=b+0.1
                    end
                    textname:SetTextColor(r,g,b,1)
                elseif customListPos>endEntry then
                    pageNext=true
                end
            end
        end
    end
    if pageNext then
        HealBot_Options_PageNextCDebuffBtn:Enable()
    else
        HealBot_Options_PageNextCDebuffBtn:Disable()
    end
    if HealBot_Options_StorePrev["customdebufftextpage"]==1 then
        HealBot_Options_PagePrevCDebuffBtn:Disable()
    end
    customListPos=customListPos+1
    for j=(customListPos-startEntry),30 do
        textname=_G["HealBot_Options_CustomDebuff_List"..j]
        textname:SetText(" ")
    end

    g=_G["HealBot_Options_PageCDebuff"]
    g:SetText(HEALBOT_OPTIONS_PAGE.." "..HealBot_Options_StorePrev["customdebufftextpage"])
end

function HealBot_Options_PageNextCDebuff()
    HealBot_Options_StorePrev["customdebufftextpage"]=HealBot_Options_StorePrev["customdebufftextpage"]+1
    HealBot_Options_PagePrevCDebuffBtn:Enable()
    HealBot_Options_setCustomDebuffList()
end

function HealBot_Options_PagePrevCDebuff()
    if HealBot_Options_StorePrev["customdebufftextpage"]>1 then
        HealBot_Options_StorePrev["customdebufftextpage"]=HealBot_Options_StorePrev["customdebufftextpage"]-1
    end
    HealBot_Options_setCustomDebuffList()
end
----------------------------------------------------------------------------------

function HealBot_Options_getDropDownId_bySpec(ddId)
    return HealBot_Config.CurrentSpec..ddId
end

function HealBot_Options_ComboClass_Button(bNo)
    local button, lButton=nil, nil
    if bNo==2 then 
        button = "Middle"
        lButton = HEALBOT_OPTIONS_BUTTONMIDDLE
    elseif bNo==3 then 
        button = "Right"
        lButton = HEALBOT_OPTIONS_BUTTONRIGHT
    elseif bNo==4 then 
        button = "Button4"
        lButton = HEALBOT_OPTIONS_BUTTON4
    elseif bNo==5 then 
        button = "Button5"
        lButton = HEALBOT_OPTIONS_BUTTON5
    elseif bNo==6 then 
        button = "Button6"
        lButton = HEALBOT_OPTIONS_BUTTON6
    elseif bNo==7 then 
        button = "Button7"
        lButton = HEALBOT_OPTIONS_BUTTON7
    elseif bNo==8 then 
        button = "Button8"
        lButton = HEALBOT_OPTIONS_BUTTON8
    elseif bNo==9 then 
        button = "Button9"
        lButton = HEALBOT_OPTIONS_BUTTON9
    elseif bNo==10 then 
        button = "Button10"
        lButton = HEALBOT_OPTIONS_BUTTON10
    elseif bNo==11 then
        button = "Button11"
        lButton = HEALBOT_OPTIONS_BUTTON11
    elseif bNo==12 then
        button = "Button12"
        lButton = HEALBOT_OPTIONS_BUTTON12
    elseif bNo==13 then
        button = "Button13"
        lButton = HEALBOT_OPTIONS_BUTTON13
    elseif bNo==14 then
        button = "Button14"
        lButton = HEALBOT_OPTIONS_BUTTON14
    elseif bNo==15 then
        button = "Button15"
        lButton = HEALBOT_OPTIONS_BUTTON15
    else 
        button = "Left"
        lButton = HEALBOT_OPTIONS_BUTTONLEFT
    end
    return button, lButton;
end

local tIDs={ [1]=1,   [2]=2,   [3]=3,   [4]=4,   [5]=5, 
             [6]=6,   [7]=7,   [8]=9,   [9]=10, [10]=11,
            [11]=12, [12]=13, [13]=14, [14]=17, [15]=18, 
            [16]=19, [17]=20, [18]=21, [19]=22, [20]=23,
            [21]=24, [22]=26, [23]=27 }
local function HealBot_Options_DecodeDDClass(id, k)
    local newID=id
    if HEALBOT_GAME_VERSION<4 then
        newID=tIDs[id]
    end
    return newID
end

local FirstDebuffLoad=true
local function HealBot_Options_DoDebuff_Reset()
    HealBot_Options_setDebuffTypes()
    HealBot_DebuffWatchTarget[HEALBOT_DISEASE_en] = {HEALBOT_DISEASE_en = {}};
    HealBot_DebuffWatchTarget[HEALBOT_POISON_en] = {HEALBOT_POISON_en = {}};
    HealBot_DebuffWatchTarget[HEALBOT_MAGIC_en] = {HEALBOT_MAGIC_en = {}};
    HealBot_DebuffWatchTarget[HEALBOT_CURSE_en] = {HEALBOT_CURSE_en = {}};
    HealBot_DebuffWatchTarget[HEALBOT_CUSTOM_en] = {HEALBOT_CUSTOM_en = {}}; -- added by Diacono
    for x,_ in pairs(HealBot_DebuffSpell) do
        HealBot_DebuffSpell[x]=nil;
    end
    local DebuffTextClass = HealBot_Config_Cures.HealBotDebuffText
    local DebuffDropDownClass = HealBot_Config_Cures.HealBotDebuffDropDown
    
    for k=1,3 do
        if DebuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)] and DebuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]>1 then
            local dropdownID=HealBot_Options_DecodeDDClass(DebuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)])
            local sName = DebuffTextClass[HealBot_Options_getDropDownId_bySpec(k)]
            if HealBot_Debuff_Types[sName] then
                table.foreach(HealBot_Debuff_Types[sName], function (i,dName)

                    if not HealBot_DebuffSpell[dName] then
                        HealBot_DebuffSpell[dName]=sName;
                    end
                    local HealBot_DebuffWatchTargetSpell=HealBot_DebuffWatchTarget[dName];

                    if dropdownID==2 then
                        HealBot_DebuffWatchTargetSpell["Self"]=true;
                    elseif dropdownID==3 then
                        HealBot_DebuffWatchTargetSpell["Party"]=true;
                    elseif dropdownID==4 then
                        HealBot_DebuffWatchTargetSpell["Raid"]=true;
                    elseif dropdownID==5 then
                        HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_DRUID]]=true;
                    elseif dropdownID==6 then
                        HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_HUNTER]]=true;
                    elseif dropdownID==7 then
                        HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_MAGE]]=true;
                    elseif dropdownID==8 then
                        HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_MONK]]=true;
                    elseif dropdownID==9 then
                        HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_PALADIN]]=true;
                    elseif dropdownID==10 then
                        HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_PRIEST]]=true;
                    elseif dropdownID==11 then
                        HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_ROGUE]]=true;
                    elseif dropdownID==12 then
                        HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_SHAMAN]]=true;
                    elseif dropdownID==13 then
                        HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_WARLOCK]]=true;
                    elseif dropdownID==14 then
                        HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_WARRIOR]]=true;
                    elseif dropdownID==15 then
                        HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_DEATHKNIGHT]]=true;
                    elseif dropdownID==16 then
                        HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_DEMONHUNTER]]=true;
                    elseif dropdownID==17 then
                        if HealBot_Globals.EmergIncMelee[HEALBOT_DRUID] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_DRUID]]=true;
                        end
                        if HealBot_Globals.EmergIncMelee[HEALBOT_HUNTER] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_HUNTER]]=true;
                        end
                        if HealBot_Globals.EmergIncMelee[HEALBOT_MAGE] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_MAGE]]=true;
                        end
                        if HealBot_Globals.EmergIncMelee[HEALBOT_PALADIN] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_PALADIN]]=true;
                        end
                        if HealBot_Globals.EmergIncMelee[HEALBOT_PRIEST] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_PRIEST]]=true;
                        end
                        if HealBot_Globals.EmergIncMelee[HEALBOT_ROGUE] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_ROGUE]]=true;
                        end
                        if HealBot_Globals.EmergIncMelee[HEALBOT_SHAMAN] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_SHAMAN]]=true;
                        end
                        if HealBot_Globals.EmergIncMelee[HEALBOT_WARLOCK] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_WARLOCK]]=true;
                        end
                        if HealBot_Globals.EmergIncMelee[HEALBOT_WARRIOR] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_WARRIOR]]=true;
                        end
                        if HealBot_Globals.EmergIncMelee[HEALBOT_DEATHKNIGHT] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_DEATHKNIGHT]]=true;
                        end
                        if HealBot_Globals.EmergIncMelee[HEALBOT_DEMONHUNTER] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_DEMONHUNTER]]=true;
                        end
                        if HealBot_Globals.EmergIncMelee[HEALBOT_MONK] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_MONK]]=true;
                        end
                    elseif dropdownID==18 then
                        if HealBot_Globals.EmergIncRange[HEALBOT_DRUID] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_DRUID]]=true;
                        end
                        if HealBot_Globals.EmergIncRange[HEALBOT_HUNTER] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_HUNTER]]=true;
                        end
                        if HealBot_Globals.EmergIncRange[HEALBOT_MAGE] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_MAGE]]=true;
                        end
                        if HealBot_Globals.EmergIncRange[HEALBOT_PALADIN] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_PALADIN]]=true;
                        end
                        if HealBot_Globals.EmergIncRange[HEALBOT_PRIEST] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_PRIEST]]=true;
                        end
                        if HealBot_Globals.EmergIncRange[HEALBOT_ROGUE] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_ROGUE]]=true;
                        end
                        if HealBot_Globals.EmergIncRange[HEALBOT_SHAMAN] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_SHAMAN]]=true;
                        end
                        if HealBot_Globals.EmergIncRange[HEALBOT_WARLOCK] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_WARLOCK]]=true;
                        end
                        if HealBot_Globals.EmergIncRange[HEALBOT_WARRIOR] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_WARRIOR]]=true;
                        end
                        if HealBot_Globals.EmergIncRange[HEALBOT_DEATHKNIGHT] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_DEATHKNIGHT]]=true;
                        end
                        if HealBot_Globals.EmergIncRange[HEALBOT_DEMONHUNTER] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_DEMONHUNTER]]=true;
                        end
                        if HealBot_Globals.EmergIncRange[HEALBOT_MONK] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_MONK]]=true;
                        end
                    elseif dropdownID==19 then
                        if HealBot_Globals.EmergIncHealers[HEALBOT_DRUID] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_DRUID]]=true;
                        end
                        if HealBot_Globals.EmergIncHealers[HEALBOT_HUNTER] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_HUNTER]]=true;
                        end
                        if HealBot_Globals.EmergIncHealers[HEALBOT_MAGE] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_MAGE]]=true;
                        end
                        if HealBot_Globals.EmergIncHealers[HEALBOT_PALADIN] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_PALADIN]]=true;
                        end
                        if HealBot_Globals.EmergIncHealers[HEALBOT_PRIEST] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_PRIEST]]=true;
                        end
                        if HealBot_Globals.EmergIncHealers[HEALBOT_ROGUE] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_ROGUE]]=true;
                        end
                        if HealBot_Globals.EmergIncHealers[HEALBOT_SHAMAN] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_SHAMAN]]=true;
                        end
                        if HealBot_Globals.EmergIncHealers[HEALBOT_WARLOCK] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_WARLOCK]]=true;
                        end
                        if HealBot_Globals.EmergIncHealers[HEALBOT_WARRIOR] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_WARRIOR]]=true;
                        end
                        if HealBot_Globals.EmergIncHealers[HEALBOT_DEATHKNIGHT] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_DEATHKNIGHT]]=true;
                        end
                        if HealBot_Globals.EmergIncHealers[HEALBOT_DEMONHUNTER] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_DEMONHUNTER]]=true;
                        end
                        if HealBot_Globals.EmergIncHealers[HEALBOT_MONK] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_MONK]]=true;
                        end
                    elseif dropdownID==20 then
                        if HealBot_Globals.EmergIncCustom[HEALBOT_DRUID] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_DRUID]]=true;
                        end
                        if HealBot_Globals.EmergIncCustom[HEALBOT_HUNTER] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_HUNTER]]=true;
                        end
                        if HealBot_Globals.EmergIncCustom[HEALBOT_MAGE] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_MAGE]]=true;
                        end
                        if HealBot_Globals.EmergIncCustom[HEALBOT_PALADIN] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_PALADIN]]=true;
                        end
                        if HealBot_Globals.EmergIncCustom[HEALBOT_PRIEST] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_PRIEST]]=true;
                        end
                        if HealBot_Globals.EmergIncCustom[HEALBOT_ROGUE] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_ROGUE]]=true;
                        end
                        if HealBot_Globals.EmergIncCustom[HEALBOT_SHAMAN] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_SHAMAN]]=true;
                        end
                        if HealBot_Globals.EmergIncCustom[HEALBOT_WARLOCK] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_WARLOCK]]=true;
                        end
                        if HealBot_Globals.EmergIncCustom[HEALBOT_WARRIOR] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_WARRIOR]]=true;
                        end
                        if HealBot_Globals.EmergIncCustom[HEALBOT_DEATHKNIGHT] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_DEATHKNIGHT]]=true;
                        end
                        if HealBot_Globals.EmergIncCustom[HEALBOT_DEMONHUNTER] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_DEMONHUNTER]]=true;
                        end
                        if HealBot_Globals.EmergIncCustom[HEALBOT_MONK] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_MONK]]=true;
                        end
                    elseif dropdownID==21 then
                        HealBot_DebuffWatchTargetSpell["PvP"]=true
                    elseif dropdownID==22 then
                        HealBot_DebuffWatchTargetSpell["PvE"]=true
                    elseif dropdownID==23 then
                        HealBot_DebuffWatchTargetSpell["MainTanks"]=true
                    elseif dropdownID==24 then
                        HealBot_DebuffWatchTargetSpell["MyTargets"]=true
                    elseif dropdownID==25 then
                        HealBot_DebuffWatchTargetSpell["Focus"]=true
                    elseif dropdownID==26 then
                        HealBot_DebuffWatchTargetSpell["Name"]=true
                    end        
                end)
            end
        end
    end
    HealBot_setOptions_Timer(20)
    FirstDebuffLoad=nil
end


local spells={}
local FirstBuffLoad=true
local function HealBot_Options_DoBuff_Reset()
    HealBot_Options_setDebuffTypes()
    BuffTextClass = HealBot_Config_Buffs.HealBotBuffText
    local BuffDropDownClass = HealBot_Config_Buffs.HealBotBuffDropDown
    local buffbarcolrClass = HealBot_Config_Buffs.HealBotBuffColR
    local buffbarcolgClass = HealBot_Config_Buffs.HealBotBuffColG
    local buffbarcolbClass = HealBot_Config_Buffs.HealBotBuffColB
    for x,_ in pairs(spells) do
        spells[x]=nil;
    end
    HealBot_Clear_BuffWatch()
    for x,_ in pairs(HealBot_BuffWatchTarget) do
        HealBot_BuffWatchTarget[x]=nil;
    end
    for x,_ in pairs(HealBot_buffbarcolr) do
        HealBot_buffbarcolr[x]=nil;
    end
    for x,_ in pairs(HealBot_buffbarcolg) do
        HealBot_buffbarcolg[x]=nil;
    end
    for x,_ in pairs(HealBot_buffbarcolb) do
        HealBot_buffbarcolb[x]=nil;
    end
    if HealBot_Data["TIPUSE"] then HealBot_Tooltip_Clear_CheckBuffs() end
    HealBot_Clear_CheckBuffs()
    
    for k=1,8 do
        if BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)] and BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]>1 then
            local dropdownID=HealBot_Options_DecodeDDClass(BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)], k)
            local sName=BuffTextClass[HealBot_Options_getDropDownId_bySpec(k)]
            if HealBot_Spell_Names[sName] or IsUsableItem(sName) then  
           
                if not spells[sName] then
                    spells[sName]=true;
                    HealBot_Set_BuffWatch(sName, k)
                    HealBot_BuffWatchTarget[sName] = {sName = {}};
                end

                local HealBot_BuffWatchTargetSpell=HealBot_BuffWatchTarget[sName];
                if HealBot_Data["TIPUSE"] then HealBot_Tooltip_CheckBuffs(sName) end
                HealBot_Set_CheckBuffs(sName)
        
                if dropdownID==2 then
                    HealBot_BuffWatchTargetSpell["Self"]=true;
                elseif dropdownID==3 then
                    HealBot_BuffWatchTargetSpell["Party"]=true;
                elseif dropdownID==4 then
                    HealBot_BuffWatchTargetSpell["Raid"]=true;
                elseif dropdownID==5 then
                    HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_DRUID]]=true;
                elseif dropdownID==6 then
                    HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_HUNTER]]=true;
                elseif dropdownID==7 then
                    HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_MAGE]]=true;
                elseif dropdownID==8 then
                    HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_MONK]]=true;
                elseif dropdownID==9 then
                    HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_PALADIN]]=true;
                elseif dropdownID==10 then
                    HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_PRIEST]]=true;
                elseif dropdownID==11 then
                    HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_ROGUE]]=true;
                elseif dropdownID==12 then
                    HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_SHAMAN]]=true;
                elseif dropdownID==13 then
                    HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_WARLOCK]]=true;
                elseif dropdownID==14 then
                    HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_WARRIOR]]=true;
                elseif dropdownID==15 then
                    HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_DEATHKNIGHT]]=true;
                elseif dropdownID==16 then
                    HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_DEMONHUNTER]]=true;
                elseif dropdownID==17 then
                    if HealBot_Globals.EmergIncMelee[HEALBOT_DRUID] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_DRUID]]=true;
                    end
                    if HealBot_Globals.EmergIncMelee[HEALBOT_HUNTER] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_HUNTER]]=true;
                    end
                    if HealBot_Globals.EmergIncMelee[HEALBOT_MAGE] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_MAGE]]=true;
                    end
                    if HealBot_Globals.EmergIncMelee[HEALBOT_PALADIN] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_PALADIN]]=true;
                    end
                    if HealBot_Globals.EmergIncMelee[HEALBOT_PRIEST] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_PRIEST]]=true;
                    end
                    if HealBot_Globals.EmergIncMelee[HEALBOT_ROGUE] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_ROGUE]]=true;
                    end
                    if HealBot_Globals.EmergIncMelee[HEALBOT_SHAMAN] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_SHAMAN]]=true;
                    end
                    if HealBot_Globals.EmergIncMelee[HEALBOT_WARLOCK] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_WARLOCK]]=true;
                    end
                    if HealBot_Globals.EmergIncMelee[HEALBOT_WARRIOR] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_WARRIOR]]=true;
                    end
                    if HealBot_Globals.EmergIncMelee[HEALBOT_DEATHKNIGHT] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_DEATHKNIGHT]]=true;
                    end
                    if HealBot_Globals.EmergIncMelee[HEALBOT_DEMONHUNTER] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_DEMONHUNTER]]=true;
                    end
                    if HealBot_Globals.EmergIncMelee[HEALBOT_MONK] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_MONK]]=true;
                    end
                elseif dropdownID==18 then
                    if HealBot_Globals.EmergIncRange[HEALBOT_DRUID] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_DRUID]]=true;
                    end
                    if HealBot_Globals.EmergIncRange[HEALBOT_HUNTER] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_HUNTER]]=true;
                    end
                    if HealBot_Globals.EmergIncRange[HEALBOT_MAGE] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_MAGE]]=true;
                    end
                    if HealBot_Globals.EmergIncRange[HEALBOT_PALADIN] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_PALADIN]]=true;
                    end
                    if HealBot_Globals.EmergIncRange[HEALBOT_PRIEST] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_PRIEST]]=true;
                    end
                    if HealBot_Globals.EmergIncRange[HEALBOT_ROGUE] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_ROGUE]]=true;
                    end
                    if HealBot_Globals.EmergIncRange[HEALBOT_SHAMAN] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_SHAMAN]]=true;
                    end
                    if HealBot_Globals.EmergIncRange[HEALBOT_WARLOCK] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_WARLOCK]]=true;
                    end
                    if HealBot_Globals.EmergIncRange[HEALBOT_WARRIOR] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_WARRIOR]]=true;
                    end
                    if HealBot_Globals.EmergIncRange[HEALBOT_DEATHKNIGHT] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_DEATHKNIGHT]]=true;
                    end
                    if HealBot_Globals.EmergIncRange[HEALBOT_DEMONHUNTER] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_DEMONHUNTER]]=true;
                    end
                    if HealBot_Globals.EmergIncRange[HEALBOT_MONK] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_MONK]]=true;
                    end
                elseif dropdownID==19 then
                    if HealBot_Globals.EmergIncHealers[HEALBOT_DRUID] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_DRUID]]=true;
                    end
                    if HealBot_Globals.EmergIncHealers[HEALBOT_HUNTER] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_HUNTER]]=true;
                    end
                    if HealBot_Globals.EmergIncHealers[HEALBOT_MAGE] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_MAGE]]=true;
                    end
                    if HealBot_Globals.EmergIncHealers[HEALBOT_PALADIN] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_PALADIN]]=true;
                    end
                    if HealBot_Globals.EmergIncHealers[HEALBOT_PRIEST] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_PRIEST]]=true;
                    end
                    if HealBot_Globals.EmergIncHealers[HEALBOT_ROGUE] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_ROGUE]]=true;
                    end
                    if HealBot_Globals.EmergIncHealers[HEALBOT_SHAMAN] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_SHAMAN]]=true;
                    end
                    if HealBot_Globals.EmergIncHealers[HEALBOT_WARLOCK] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_WARLOCK]]=true;
                    end
                    if HealBot_Globals.EmergIncHealers[HEALBOT_WARRIOR] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_WARRIOR]]=true;
                    end
                    if HealBot_Globals.EmergIncHealers[HEALBOT_DEATHKNIGHT] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_DEATHKNIGHT]]=true;
                    end
                    if HealBot_Globals.EmergIncHealers[HEALBOT_DEMONHUNTER] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_DEMONHUNTER]]=true;
                    end
                    if HealBot_Globals.EmergIncHealers[HEALBOT_MONK] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_MONK]]=true;
                    end
                elseif dropdownID==20 then
                    if HealBot_Globals.EmergIncCustom[HEALBOT_DRUID] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_DRUID]]=true;
                    end
                    if HealBot_Globals.EmergIncCustom[HEALBOT_HUNTER] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_HUNTER]]=true;
                    end
                    if HealBot_Globals.EmergIncCustom[HEALBOT_MAGE] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_MAGE]]=true;
                    end
                    if HealBot_Globals.EmergIncCustom[HEALBOT_PALADIN] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_PALADIN]]=true;
                    end
                    if HealBot_Globals.EmergIncCustom[HEALBOT_PRIEST] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_PRIEST]]=true;
                    end
                    if HealBot_Globals.EmergIncCustom[HEALBOT_ROGUE] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_ROGUE]]=true;
                    end
                    if HealBot_Globals.EmergIncCustom[HEALBOT_SHAMAN] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_SHAMAN]]=true;
                    end
                    if HealBot_Globals.EmergIncCustom[HEALBOT_WARLOCK] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_WARLOCK]]=true;
                    end
                    if HealBot_Globals.EmergIncCustom[HEALBOT_WARRIOR] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_WARRIOR]]=true;
                    end
                    if HealBot_Globals.EmergIncCustom[HEALBOT_DEATHKNIGHT] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_DEATHKNIGHT]]=true;
                    end
                    if HealBot_Globals.EmergIncCustom[HEALBOT_DEMONHUNTER] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_DEMONHUNTER]]=true;
                    end
                    if HealBot_Globals.EmergIncCustom[HEALBOT_MONK] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_MONK]]=true;
                    end
                elseif dropdownID==21 then
                    HealBot_BuffWatchTargetSpell["PvP"]=true
                elseif dropdownID==22 then
                    HealBot_BuffWatchTargetSpell["PvE"]=true
                elseif dropdownID==23 then
                    HealBot_BuffWatchTargetSpell["MainTanks"]=true
                elseif dropdownID==24 then
                    HealBot_BuffWatchTargetSpell["MyTargets"]=true
                elseif dropdownID==25 then
                    HealBot_BuffWatchTargetSpell["Focus"]=true
                elseif dropdownID==26 then
                    HealBot_BuffWatchTargetSpell["Name"]=true
                elseif dropdownID==27 then
                    HealBot_BuffWatchTargetSpell["SingleTank"]=true
                end
                HealBot_buffbarcolr[sName]=buffbarcolrClass[k];
                HealBot_buffbarcolg[sName]=buffbarcolgClass[k];
                HealBot_buffbarcolb[sName]=buffbarcolbClass[k];
            end
        end
    end
    HealBot_setOptions_Timer(30)
    FirstBuffLoad=nil
end

function HealBot_Options_BuffDebuff_Reset(aType)
    if aType=="debuff" then
        HealBot_Options_DoDebuff_Reset()
    else
        HealBot_Options_DoBuff_Reset()
    end
end

function HealBot_Options_RetBuffRGB(button)
    if button.aura.buff.name==HEALBOT_CUSTOM_en then
        if HealBot_Globals.CustomBuffBarColour[button.aura.buff.id] then
            return HealBot_Globals.CustomBuffBarColour[button.aura.buff.id]["R"],HealBot_Globals.CustomBuffBarColour[button.aura.buff.id]["G"],HealBot_Globals.CustomBuffBarColour[button.aura.buff.id]["B"]
        else 
            return HealBot_Globals.CustomBuffBarColour[HEALBOT_CUSTOM_en.."Buff"]["R"],HealBot_Globals.CustomBuffBarColour[HEALBOT_CUSTOM_en.."Buff"]["G"],HealBot_Globals.CustomBuffBarColour[HEALBOT_CUSTOM_en.."Buff"]["B"]
        end
    else
        return HealBot_buffbarcolr[button.aura.buff.name],HealBot_buffbarcolg[button.aura.buff.name],HealBot_buffbarcolb[button.aura.buff.name];
    end
end

function HealBot_Options_RetBuffRGBName(spellName)
    return HealBot_buffbarcolr[spellName],HealBot_buffbarcolg[spellName],HealBot_buffbarcolb[spellName];
end

function HealBot_Options_PresetColours_AliasSave(self,id)
    HealBot_Globals.PresetColoursAlias[id]=self:GetText()
end

function HealBot_Options_PresetColourClick(self)
    HealBot_Options_StorePrev["PresetColourCaller"]=self:GetName()
    if HealBot_Options_StorePrev["PresetColourCaller"]=="HealBot_Options_BuffHoTPresetColour" then
        HealBot_Options_Panel5:Hide()
        HealBot_Options_PresetColours:Show()
    elseif strsub(HealBot_Options_StorePrev["PresetColourCaller"],1,20)=="HealBot_Options_Buff" then
        local id=tonumber(strsub(HealBot_Options_StorePrev["PresetColourCaller"] ,33));
        HealBot_Options_StorePrev["PresetColourCaller"]="Buff"..id
        HealBot_Options_Panel5:Hide()
        HealBot_Options_PresetColours:Show()
    elseif HealBot_Options_StorePrev["PresetColourCaller"]=="HealBot_Options_CustomDebuffPresetColour" then
        HealBot_Options_Panel4:Hide()
        HealBot_Options_PresetColours:Show()
    elseif strsub(HealBot_Options_StorePrev["PresetColourCaller"],1,22)=="HealBot_Options_Debuff" then
        HealBot_Options_Panel4:Hide()
        HealBot_Options_PresetColours:Show()
    elseif strsub(HealBot_Options_StorePrev["PresetColourCaller"],1,20)=="HealBot_Options_Skin" then
        if strsub(HealBot_Options_StorePrev["PresetColourCaller"],1,27)=="HealBot_Options_SkinBarText" then
            if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CLASSCOL"] then
                HealBot_Options_ClassColours()
            else
                HealBot_Options_Panel3:Hide()
                HealBot_Options_PresetColours:Show()
            end
        else
            HealBot_Options_Panel3:Hide()
            HealBot_Options_PresetColours:Show()
        end
    end
end

function HealBot_Colorpick_OnClick(CDCType)
    if CDCType==HEALBOT_CUSTOM_en then
        local customDebuffPriority=HEALBOT_CUSTOM_en.."15"
        HealBot_ColourObjWaiting=customDebuffPriority
        if HealBot_Options_StorePrev["CDebuffcustomName"] and HealBot_Options_StorePrev["CDebuffcustomName"]~=HEALBOT_CUSTOM_CAT_CUSTOM_AUTOMATIC then
            HealBot_ColourObjWaiting=HealBot_Options_StorePrev["CDebuffcustomName"]
            if not HealBot_Globals.CDCBarColour[HealBot_Options_StorePrev["CDebuffcustomName"]] then 
                HealBot_Globals.CDCBarColour[HealBot_Options_StorePrev["CDebuffcustomName"]]={}
                HealBot_UseColourPick(HealBot_Globals.CDCBarColour[customDebuffPriority].R,HealBot_Globals.CDCBarColour[customDebuffPriority].G,HealBot_Globals.CDCBarColour[customDebuffPriority].B, nil)
            else
                HealBot_UseColourPick(HealBot_Globals.CDCBarColour[HealBot_Options_StorePrev["CDebuffcustomName"]].R,
                                      HealBot_Globals.CDCBarColour[HealBot_Options_StorePrev["CDebuffcustomName"]].G,
                                      HealBot_Globals.CDCBarColour[HealBot_Options_StorePrev["CDebuffcustomName"]].B, nil)
            end
        else
            HealBot_UseColourPick(HealBot_Globals.CDCBarColour[customDebuffPriority].R,HealBot_Globals.CDCBarColour[customDebuffPriority].G,HealBot_Globals.CDCBarColour[customDebuffPriority].B, nil)
        end
    elseif CDCType=="CustomBuff" then
        local customBuffPriority=HEALBOT_CUSTOM_en.."Buff"
        HealBot_ColourObjWaiting=customBuffPriority
        local sId=HealBot_Options_CDebuffGetId(HealBot_Options_StorePrev["HoTname"])
        if sId then
            HealBot_ColourObjWaiting=sId
            if not HealBot_Globals.CustomBuffBarColour[sId] then 
                HealBot_Globals.CustomBuffBarColour[sId]={}
                HealBot_UseColourPick(HealBot_Globals.CustomBuffBarColour[customBuffPriority].R,HealBot_Globals.CustomBuffBarColour[customBuffPriority].G,HealBot_Globals.CustomBuffBarColour[customBuffPriority].B, nil)
            else
                HealBot_UseColourPick(HealBot_Globals.CustomBuffBarColour[sId].R,
                                      HealBot_Globals.CustomBuffBarColour[sId].G,
                                      HealBot_Globals.CustomBuffBarColour[sId].B, nil)
            end
        else
            HealBot_UseColourPick(HealBot_Globals.CustomBuffBarColour[customBuffPriority].R,HealBot_Globals.CustomBuffBarColour[customBuffPriority].G,HealBot_Globals.CustomBuffBarColour[customBuffPriority].B, nil)
        end
    else
        HealBot_ColourObjWaiting=CDCType;
        HealBot_UseColourPick(HealBot_Config_Cures.CDCBarColour[CDCType].R,HealBot_Config_Cures.CDCBarColour[CDCType].G,HealBot_Config_Cures.CDCBarColour[CDCType].B, nil)
    end
end

function HealBot_PresetColorpick_OnClick(id)
    HealBot_Options_StorePrev["PresetColoursID"]=id
    HealBot_ColourObjWaiting="Preset"
    HealBot_UseColourPick(HealBot_Globals.PresetColours[id].R,HealBot_Globals.PresetColours[id].G,HealBot_Globals.PresetColours[id].B, HealBot_Globals.PresetColours[id].A)
end

local function HealBot_Returned_Colours(R, G, B, A, preset)
  --R, G, B = ColorPickerFrame:GetColorRGB(); -- added by Diacono
  --A = OpacitySliderFrame:GetValue();
    if A and not preset then
        A = ((0-A)+1);
        A=HealBot_Comm_round(A,2)
    end
    R=HealBot_Comm_round(R,3)
    G=HealBot_Comm_round(G,3)
    B=HealBot_Comm_round(B,3)
    local setskincols=true;
    local sId=HealBot_Options_CDebuffGetId(HealBot_Options_StorePrev["HoTname"])
    if HealBot_ColourObjWaiting=="En" then
        Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["ER"],
        Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["EG"],
        Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["EB"], 
        Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["EA"] = R, G, B, A;
    elseif HealBot_ColourObjWaiting=="Dis" then
        Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["DR"],
        Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["DG"],
        Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["DB"],
        Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["DA"] = R, G, B, A;
    elseif HealBot_ColourObjWaiting=="Debuff" then
        Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CR"],
        Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CG"],
        Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CB"],
        Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CA"] = R, G, B, A;
    elseif HealBot_ColourObjWaiting=="Back" then
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BACKR"],
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BACKG"],
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BACKB"],
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BACKA"] = R, G, B, A;
    elseif HealBot_ColourObjWaiting=="Bor" then
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BORDERR"],
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BORDERG"],
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BORDERB"],
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BORDERA"] = R, G, B, A;
    elseif HealBot_ColourObjWaiting=="AliasT" then
        Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["R"],
        Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["G"],
        Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["B"],
        Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["A"] = R, G, B, A;
    elseif HealBot_ColourObjWaiting=="Alias" then
        Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["R"],
        Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["G"],
        Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["B"],
        Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["A"] = R, G, B, A;
    elseif HealBot_ColourObjWaiting=="HeadB" then
        Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["R"],
        Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["G"],
        Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["B"],
        Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["A"] = R, G, B, A;
        HealBot_setOptions_Timer(150)
    elseif HealBot_ColourObjWaiting=="HeadT" then
        Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["R"],
        Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["G"],
        Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["B"],
        Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["A"] = R, G, B, A;
        HealBot_setOptions_Timer(150)
    elseif HealBot_ColourObjWaiting=="CustomBar" then
        Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HR"],
        Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HG"],
        Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HB"] = R, G, B;
        HealBot_setLuVars("ResetAllUnitStatus", GetTime()+2)
    elseif HealBot_ColourObjWaiting=="CustomBackBar" then
        Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BR"],
        Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BG"],
        Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BB"] = R, G, B;
        HealBot_setOptions_Timer(150)
    elseif HealBot_ColourObjWaiting=="CustomIHBar" then
        Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["IR"],
        Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["IG"],
        Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["IB"] = R, G, B;
    elseif HealBot_ColourObjWaiting=="CustomAbsorbBar" then
        Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["AR"],
        Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["AG"],
        Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["AB"] = R, G, B;
    elseif HealBot_ColourObjWaiting=="HighlightBar" then
        Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CR"],
        Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CG"],
        Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CB"] = R, G, B;
        HealBot_Action_SetHightlightAggroCols()
    elseif HealBot_ColourObjWaiting=="HighlightTargetBar" then
        Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TR"],
        Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TG"],
        Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TB"] = R, G, B;
        HealBot_Action_SetHightlightTargetAggroCols()
    elseif HealBot_ColourObjWaiting=="Aggro" then
        Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["R"],
        Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["G"],
        Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["B"] = R, G, B;
        HealBot_Action_SetAggroCols()
    elseif strsub(HealBot_ColourObjWaiting ,1,4)=="Buff" then
        local id=tonumber(strsub(HealBot_ColourObjWaiting ,5));
        local buffbarcolrClass = HealBot_Config_Buffs.HealBotBuffColR
        local buffbarcolgClass = HealBot_Config_Buffs.HealBotBuffColG
        local buffbarcolbClass = HealBot_Config_Buffs.HealBotBuffColB
        buffbarcolrClass[id],
        buffbarcolgClass[id],
        buffbarcolbClass[id] = R, G, B;
        HealBot_setOptions_Timer(100)
        setskincols=false;
    elseif HealBot_ColourObjWaiting==HEALBOT_CUSTOM_en.."15" or HealBot_ColourObjWaiting==HealBot_Options_StorePrev["CDebuffcustomName"] then
        HealBot_Globals.CDCBarColour[HealBot_ColourObjWaiting].R,
        HealBot_Globals.CDCBarColour[HealBot_ColourObjWaiting].G,
        HealBot_Globals.CDCBarColour[HealBot_ColourObjWaiting].B = R, G, B;
        HealBot_SetCDCBarColours();
        setskincols=false;
    elseif HealBot_ColourObjWaiting==HEALBOT_CUSTOM_en.."Buff" or HealBot_ColourObjWaiting==sId then
        HealBot_Globals.CustomBuffBarColour[HealBot_ColourObjWaiting].R,
        HealBot_Globals.CustomBuffBarColour[HealBot_ColourObjWaiting].G,
        HealBot_Globals.CustomBuffBarColour[HealBot_ColourObjWaiting].B = R, G, B;
        HealBot_SetCustomBuffBarColours();
        HealBot_Options_setCustomBuffList()
        setskincols=false;
    elseif HealBot_Config_Cures.CDCBarColour[HealBot_ColourObjWaiting] then
        HealBot_Config_Cures.CDCBarColour[HealBot_ColourObjWaiting].R,
        HealBot_Config_Cures.CDCBarColour[HealBot_ColourObjWaiting].G,
        HealBot_Config_Cures.CDCBarColour[HealBot_ColourObjWaiting].B = R, G, B;
        HealBot_SetCDCBarColours();
        setskincols=false;
    elseif HealBot_ColourObjWaiting=="Preset" then
        HealBot_Globals.PresetColours[HealBot_Options_StorePrev["PresetColoursID"]].R,
        HealBot_Globals.PresetColours[HealBot_Options_StorePrev["PresetColoursID"]].G,
        HealBot_Globals.PresetColours[HealBot_Options_StorePrev["PresetColoursID"]].B,
        HealBot_Globals.PresetColours[HealBot_Options_StorePrev["PresetColoursID"]].A = R, G, B, A;
        g=_G["HealBot_PresetColourpick"..HealBot_Options_StorePrev["PresetColoursID"]]
        g:SetStatusBarColor(HealBot_Globals.PresetColours[HealBot_Options_StorePrev["PresetColoursID"]].R, 
                            HealBot_Globals.PresetColours[HealBot_Options_StorePrev["PresetColoursID"]].G, 
                            HealBot_Globals.PresetColours[HealBot_Options_StorePrev["PresetColoursID"]].B, 
                            HealBot_Globals.PresetColours[HealBot_Options_StorePrev["PresetColoursID"]].A) 
        setskincols=false;
    end
    if setskincols then
        HealBot_setOptions_Timer(90)
    end
end

function HealBot_Options_PresetColourSelect_OnClick(id,cancel)
    if HealBot_Options_StorePrev["PresetColourCaller"]=="HealBot_Options_BuffHoTPresetColour" then
        local sId=HealBot_Options_CDebuffGetId(HealBot_Options_StorePrev["HoTname"])
        if sId and HealBot_Globals.CustomBuffBarColour[sId] then
            HealBot_ColourObjWaiting=sId
        else
            HealBot_ColourObjWaiting=HEALBOT_CUSTOM_en.."Buff"
        end
        HealBot_Options_PresetColours:Hide()
        HealBot_Options_Panel5:Show()
    elseif strsub(HealBot_Options_StorePrev["PresetColourCaller"] ,1,4)=="Buff" then
        HealBot_ColourObjWaiting=HealBot_Options_StorePrev["PresetColourCaller"]
        HealBot_Options_PresetColours:Hide()
        HealBot_Options_Panel5:Show()
    elseif HealBot_Options_StorePrev["PresetColourCaller"]=="HealBot_Options_CustomDebuffPresetColour" then
        if HealBot_Options_StorePrev["CDebuffcustomName"] and HealBot_Globals.CDCBarColour[HealBot_Options_StorePrev["CDebuffcustomName"]] then
            HealBot_ColourObjWaiting=HealBot_Options_StorePrev["CDebuffcustomName"]
        else
            HealBot_ColourObjWaiting=HEALBOT_CUSTOM_en.."15"
        end
        HealBot_Options_PresetColours:Hide()
        HealBot_Options_Panel4:Show()
    elseif strsub(HealBot_Options_StorePrev["PresetColourCaller"],1,22)=="HealBot_Options_Debuff" then
        if HealBot_Options_StorePrev["PresetColourCaller"]=="HealBot_Options_DebuffCursePresetColour" then
            HealBot_ColourObjWaiting=HEALBOT_CURSE_en
        elseif HealBot_Options_StorePrev["PresetColourCaller"]=="HealBot_Options_DebuffPoisonPresetColour" then
            HealBot_ColourObjWaiting=HEALBOT_POISON_en
        elseif HealBot_Options_StorePrev["PresetColourCaller"]=="HealBot_Options_DebuffMagicPresetColour" then
            HealBot_ColourObjWaiting=HEALBOT_MAGIC_en
        elseif HealBot_Options_StorePrev["PresetColourCaller"]=="HealBot_Options_DebuffDiseasePresetColour" then
            HealBot_ColourObjWaiting=HEALBOT_DISEASE_en
        end
        HealBot_Options_PresetColours:Hide()
        HealBot_Options_Panel4:Show()
    elseif strsub(HealBot_Options_StorePrev["PresetColourCaller"],1,20)=="HealBot_Options_Skin" then
        if HealBot_Options_StorePrev["PresetColourCaller"]=="HealBot_Options_SkinBarAbsorbPresetColour" then
            HealBot_ColourObjWaiting="CustomAbsorbBar"
        elseif HealBot_Options_StorePrev["PresetColourCaller"]=="HealBot_Options_SkinBarIncomingPresetColour" then
            HealBot_ColourObjWaiting="CustomIHBar"
        elseif HealBot_Options_StorePrev["PresetColourCaller"]=="HealBot_Options_SkinBarBackPresetColour" then
            HealBot_ColourObjWaiting="CustomBackBar"
        elseif HealBot_Options_StorePrev["PresetColourCaller"]=="HealBot_Options_SkinBarHealthPresetColour" then
            HealBot_ColourObjWaiting="CustomBar"
        elseif HealBot_Options_StorePrev["PresetColourCaller"]=="HealBot_Options_SkinBarTextDebPresetColour" then
            HealBot_ColourObjWaiting="Debuff"
        elseif HealBot_Options_StorePrev["PresetColourCaller"]=="HealBot_Options_SkinBarTextDisPresetColour" then
            HealBot_ColourObjWaiting="Dis"
        elseif HealBot_Options_StorePrev["PresetColourCaller"]=="HealBot_Options_SkinBarTextEnPresetColour" then
            HealBot_ColourObjWaiting="En"
        elseif HealBot_Options_StorePrev["PresetColourCaller"]=="HealBot_Options_SkinBarAggroPresetColour" then
            HealBot_ColourObjWaiting="Aggro"
        elseif HealBot_Options_StorePrev["PresetColourCaller"]=="HealBot_Options_SkinBarHighlightPresetColour" then
            HealBot_ColourObjWaiting="HighlightBar"
        elseif HealBot_Options_StorePrev["PresetColourCaller"]=="HealBot_Options_SkinBarTargetPresetColour" then
            HealBot_ColourObjWaiting="HighlightTargetBar"
        elseif HealBot_Options_StorePrev["PresetColourCaller"]=="HealBot_Options_SkinHeaderBarPresetColour" then
            HealBot_ColourObjWaiting="HeadB"
        elseif HealBot_Options_StorePrev["PresetColourCaller"]=="HealBot_Options_SkinHeaderTextPresetColour" then
            HealBot_ColourObjWaiting="HeadT"
        elseif HealBot_Options_StorePrev["PresetColourCaller"]=="HealBot_Options_SkinFrameAliasTextPresetColour" then
            HealBot_ColourObjWaiting="AliasT"
        elseif HealBot_Options_StorePrev["PresetColourCaller"]=="HealBot_Options_SkinFrameAliasPresetColour" then
            HealBot_ColourObjWaiting="Alias"
        elseif HealBot_Options_StorePrev["PresetColourCaller"]=="HealBot_Options_SkinFrameBackPresetColour" then
            HealBot_ColourObjWaiting="Back"
        elseif HealBot_Options_StorePrev["PresetColourCaller"]=="HealBot_Options_SkinFrameBorderPresetColour" then
            HealBot_ColourObjWaiting="Bor"
        end
        HealBot_Options_PresetColours:Hide()
        HealBot_Options_Panel3:Show()
    end
    if not cancel then
        HealBot_Returned_Colours(HealBot_Globals.PresetColours[id].R, HealBot_Globals.PresetColours[id].G, 
                                 HealBot_Globals.PresetColours[id].B, HealBot_Globals.PresetColours[id].A, true)
    end
end

HealBot_Options_StorePrev["prevR"] = nil
HealBot_Options_StorePrev["prevG"] = nil
HealBot_Options_StorePrev["prevB"] = nil
HealBot_Options_StorePrev["prevA"] = nil
function HealBot_UseColourPick(R, G, B, A)
    if not R then R=1 end
    if not G then G=1 end
    if not B then B=1 end
    HealBot_Options_StorePrev["prevR"], HealBot_Options_StorePrev["prevG"], HealBot_Options_StorePrev["prevB"], HealBot_Options_StorePrev["prevA"] = R, G, B, A;
    if ColorPickerFrame:IsVisible() then 
        ColorPickerFrame:Hide();
    elseif A then
        ColorPickerFrame.hasOpacity = true;
        ColorPickerFrame.opacity = 1-A;
        ColorPickerFrame.func = function() local lR,lG,lB=ColorPickerFrame:GetColorRGB(); local lA=OpacitySliderFrame:GetValue() HealBot_Returned_Colours(lR,lG,lB,lA); end;
        ColorPickerFrame.opacityFunc = function() local lR,lG,lB=ColorPickerFrame:GetColorRGB(); local lA=OpacitySliderFrame:GetValue() HealBot_Returned_Colours(lR,lG,lB,lA); end;
        ColorPickerFrame.cancelFunc = function() HealBot_Returned_Colours(HealBot_Options_StorePrev["prevR"], HealBot_Options_StorePrev["prevG"], HealBot_Options_StorePrev["prevB"], 1-HealBot_Options_StorePrev["prevA"]); end; --added by Diacono
        ColorPickerFrame:ClearAllPoints();
        ColorPickerFrame:SetPoint("TOPLEFT","HealBot_Options","TOPRIGHT",0,-152);
        OpacitySliderFrame:SetValue(1-A);
        ColorPickerFrame:SetColorRGB(R, G, B);
        ColorPickerFrame:Show();
    else
        ColorPickerFrame.hasOpacity = false;
        ColorPickerFrame.func = function() HealBot_Returned_Colours(ColorPickerFrame:GetColorRGB()); end;
        ColorPickerFrame.cancelFunc = function() HealBot_Returned_Colours(HealBot_Options_StorePrev["prevR"], HealBot_Options_StorePrev["prevG"], HealBot_Options_StorePrev["prevB"]); end; --added by Diacono
        ColorPickerFrame:ClearAllPoints();
        ColorPickerFrame:SetPoint("TOPLEFT","HealBot_Options","TOPRIGHT",0,-152);
        ColorPickerFrame:SetColorRGB(R, G, B);
        ColorPickerFrame:Show();
    end
    HealBot_Options_framesChanged(0)
    return ColorPickerFrame:GetColorRGB();
end

function HealBot_SetCustomBuffBarColours()
    local sId=HealBot_Options_CDebuffGetId(HealBot_Options_StorePrev["HoTname"])
    if sId and HealBot_Globals.CustomBuffBarColour[sId] then
        HealBot_BuffCustomColorpick:SetStatusBarColor(HealBot_Globals.CustomBuffBarColour[sId].R or 0.45,
                                                 HealBot_Globals.CustomBuffBarColour[sId].G or 0,
                                                 HealBot_Globals.CustomBuffBarColour[sId].B or 0.26,
                                                 Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HA"]);
    else
        local customDebuffPriority=HEALBOT_CUSTOM_en.."Buff"
        HealBot_BuffCustomColorpick:SetStatusBarColor(HealBot_Globals.CustomBuffBarColour[customDebuffPriority].R or 0.45,
                                                 HealBot_Globals.CustomBuffBarColour[customDebuffPriority].G or 0,
                                                 HealBot_Globals.CustomBuffBarColour[customDebuffPriority].B or 0.26,
                                                 Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HA"]);
    end
end

function HealBot_SetCDCBarColours()
    HealBot_DiseaseColorpick:SetStatusBarColor(HealBot_Config_Cures.CDCBarColour[HEALBOT_DISEASE_en].R or 0.55,
                                               HealBot_Config_Cures.CDCBarColour[HEALBOT_DISEASE_en].G or 0.19,
                                               HealBot_Config_Cures.CDCBarColour[HEALBOT_DISEASE_en].B or 0.7,
                                               Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HA"]);
    HealBot_MagicColorpick:SetStatusBarColor(HealBot_Config_Cures.CDCBarColour[HEALBOT_MAGIC_en].R or 0.26,
                                             HealBot_Config_Cures.CDCBarColour[HEALBOT_MAGIC_en].G or 0.33,
                                             HealBot_Config_Cures.CDCBarColour[HEALBOT_MAGIC_en].B or 0.83,
                                             Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HA"]);
    HealBot_PoisonColorpick:SetStatusBarColor(HealBot_Config_Cures.CDCBarColour[HEALBOT_POISON_en].R or 0.12,
                                              HealBot_Config_Cures.CDCBarColour[HEALBOT_POISON_en].G or 0.46,
                                              HealBot_Config_Cures.CDCBarColour[HEALBOT_POISON_en].B or 0.24,
                                              Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HA"]);
    HealBot_CurseColorpick:SetStatusBarColor(HealBot_Config_Cures.CDCBarColour[HEALBOT_CURSE_en].R or 0.83,
                                             HealBot_Config_Cures.CDCBarColour[HEALBOT_CURSE_en].G or 0.43,
                                             HealBot_Config_Cures.CDCBarColour[HEALBOT_CURSE_en].B or 0.09,
                                             Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HA"]);
    if HealBot_Options_StorePrev["CDebuffcustomName"] and HealBot_Globals.CDCBarColour[HealBot_Options_StorePrev["CDebuffcustomName"]] then
        HealBot_CustomColorpick:SetStatusBarColor(HealBot_Globals.CDCBarColour[HealBot_Options_StorePrev["CDebuffcustomName"]].R or 0.45,
                                                 HealBot_Globals.CDCBarColour[HealBot_Options_StorePrev["CDebuffcustomName"]].G or 0,
                                                 HealBot_Globals.CDCBarColour[HealBot_Options_StorePrev["CDebuffcustomName"]].B or 0.26,
                                                 Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HA"]);
    else
        local customDebuffPriority=HEALBOT_CUSTOM_en.."15"
        HealBot_CustomColorpick:SetStatusBarColor(HealBot_Globals.CDCBarColour[customDebuffPriority].R or 0.45,
                                                 HealBot_Globals.CDCBarColour[customDebuffPriority].G or 0,
                                                 HealBot_Globals.CDCBarColour[customDebuffPriority].B or 0.26,
                                                 Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HA"]);
    end
    HealBot_DebTextColorpick:SetStatusBarColor(HealBot_Config_Cures.CDCBarColour[HEALBOT_DISEASE_en].R or 0.1,
                                               HealBot_Config_Cures.CDCBarColour[HEALBOT_DISEASE_en].G or 0.05,
                                               HealBot_Config_Cures.CDCBarColour[HEALBOT_DISEASE_en].B or 0.2,
                                               Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HA"]);
    HealBot_Action_SetDebuffAggroCols()
    HealBot_Options_setCustomDebuffList()
end

function HealBot_SetBuffBarColours()
    local buffbarcolrClass = HealBot_Config_Buffs.HealBotBuffColR
    local buffbarcolgClass = HealBot_Config_Buffs.HealBotBuffColG
    local buffbarcolbClass = HealBot_Config_Buffs.HealBotBuffColB

    for k=1,8 do
        local bar=_G["HealBot_Buff"..k.."Colour"]
        if bar then
            bar:SetStatusBarColor(buffbarcolrClass[k],
                                  buffbarcolgClass[k],
                                  buffbarcolbClass[k],
                                  Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HA"]);
        end
    end
    HealBot_setOptions_Timer(40)
end
--------------------------------------------------------------------------------

function HealBot_Options_FrameAlias_AfterTextChange()
    HealBot_Options_InitSub(102)
    DoneInitTab[310]=nil
    HealBot_Options_InitSub(310)
end

function HealBot_Options_FrameAlias_OnTextChanged(self)
    Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["ALIAS"] = self:GetText()
    HealBot_setOptions_Timer(4920)
end
function HealBot_Options_FrameAlias_initFrameSel()
    HealBot_Options_InitSub(102)
end

function HealBot_Options_Frame_initCurFrame()
    DoneInitTab[301]=nil
    DoneInitTab[102]=nil
    DoneInitTab[303]=nil
    DoneInitTab[309]=nil
    DoneInitTab[302]=nil
    DoneInitTab[308]=nil
    DoneInitTab[310]=nil
    DoneInitTab[318]=nil
    DoneInitTab[1008]=nil
    DoneInitTab[1009]=nil
    DoneInitTab[1010]=nil
    DoneInitTab[1011]=nil
    DoneInitTab[1014]=nil
    HealBot_Options_SetSkins(true)
end

function HealBot_Options_FrameTitle_OnTextChanged(self)
    Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["NAME"] = self:GetText()
    if Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOW"] then
        HealBot_setOptions_Timer(415)
    end
end

function HealBot_Options_FrameAliasShow_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOW"] = true
    else
        Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOW"] = false
    end
    HealBot_setOptions_Timer(415)
end

function HealBot_SpellAutoButton_OnClick(self, autoType, autoMod)
    if self:GetChecked() then
        HealBot_SpellAutoButton_Update(autoType, autoMod, HealBot_Options_StorePrev["ActionBarsCombo"], HealBot_Options_ComboButtons_Button, "true")
    else
        HealBot_SpellAutoButton_Update(autoType, autoMod, HealBot_Options_StorePrev["ActionBarsCombo"], HealBot_Options_ComboButtons_Button, "false")
    end
    HealBot_Action_SetAllAttribs()
end

function HealBot_Options_KnownSpellCheck(sName)
    if HealBot_Spell_Names[sName] or GetMacroIndexByName(sName) or IsUsableItem(sName) then
        HealBot_Action_SetAllAttribs()
    end
end

local spellText=nil
local function HealBot_Options_DoOnTextChanged(self, key)
    local cType="ENEMY"
    if HealBot_Options_StorePrev["ActionBarsCombo"]==1 then
        cType="ENABLED"
    elseif HealBot_Options_StorePrev["ActionBarsCombo"]==2 then
        cType="DISABLED"
    end
    local button = HealBot_Options_ComboClass_Button(HealBot_Options_ComboButtons_Button)
    spellText = strtrim(self:GetText())
    HealBot_Action_SetSpell(cType, key..button..HealBot_Config.CurrentSpec, spellText)
    HealBot_Options_KnownSpellCheck(spellText)
    HealBot_Options_SoftReset_flag=true
end

function HealBot_Options_Click_OnTextChanged(self)
    HealBot_Options_DoOnTextChanged(self, "")
end

function HealBot_Options_Shift_OnTextChanged(self)
    HealBot_Options_DoOnTextChanged(self, "Shift")
end

function HealBot_Options_Ctrl_OnTextChanged(self)
    HealBot_Options_DoOnTextChanged(self, "Ctrl")
end

function HealBot_Options_Alt_OnTextChanged(self)
    HealBot_Options_DoOnTextChanged(self, "Alt")
end

function HealBot_Options_CtrlShift_OnTextChanged(self)
    HealBot_Options_DoOnTextChanged(self, "Ctrl-Shift")
end

function HealBot_Options_AltShift_OnTextChanged(self)
    HealBot_Options_DoOnTextChanged(self, "Alt-Shift")
end

function HealBot_Options_CtrlAlt_OnTextChanged(self)
    HealBot_Options_DoOnTextChanged(self, "Alt-Ctrl")
end

function HealBot_Options_DisconnectedTag_OnTextChanged(self)
    Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TAGDC"] = self:GetText()
end

function HealBot_Options_UnitDeadTag_OnTextChanged(self)
    Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TAGRIP"] = self:GetText()
end

function HealBot_Options_OutOfRangeTag_OnTextChanged(self)
    Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TAGOOR"] = self:GetText()
end

function HealBot_Options_ReserverTag_OnTextChanged(self)
    Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TAGR"] = self:GetText()
end

function HealBot_Options_EnableHealthy_OnClick(self)
    if self:GetChecked() then
        HealBot_Config.EnableHealthy = true
    else
        HealBot_Config.EnableHealthy = false
    end
    HealBot_setLuVars("ResetAllUnitStatus", GetTime()+2)
end

function HealBot_Options_EnableMouseWheel_OnClick(self)
    if self:GetChecked() then
        HealBot_Globals.HealBot_Enable_MouseWheel = true
        HealBot_setOptions_Timer(25)
    else
        HealBot_Globals.HealBot_Enable_MouseWheel = false
        HealBot_Options_ReloadUI(HEALBOT_OPTIONS_MOUSEWHEEL.." - "..HEALBOT_WORD_OFF)
    end
end

function HealBot_Options_EnableSmartCast_OnClick(self)
    if self:GetChecked() then
        HealBot_Globals.SmartCast = true
    else
        HealBot_Globals.SmartCast = false
    end
end

function HealBot_Options_SmartCastDisspell_OnClick(self)
    if self:GetChecked() then
        HealBot_Globals.SmartCastDebuff = true
    else
        HealBot_Globals.SmartCastDebuff = false
    end
end

function HealBot_Options_SmartCastBuff_OnClick(self)
    if self:GetChecked() then
        HealBot_Globals.SmartCastBuff = true
    else
        HealBot_Globals.SmartCastBuff = false
    end
end

function HealBot_Options_SmartCastHeal_OnClick(self)
    if self:GetChecked() then
        HealBot_Globals.SmartCastHeal = true
    else
        HealBot_Globals.SmartCastHeal = false
    end
end

function HealBot_Options_SmartCastRes_OnClick(self)
    if self:GetChecked() then
        HealBot_Globals.SmartCastRes = true
    else
        HealBot_Globals.SmartCastRes = false
    end
end

--------------------------------------------------------------------------------

function HealBot_Options_Defaults_OnClick(self)
    StaticPopupDialogs["HEALBOT_OPTIONS_SETDEFAULTS"] = {
        text = HEALBOT_OPTIONS_SETDEFAULTSMSG,
        button1 = HEALBOT_WORDS_YES,
        button2 = HEALBOT_WORDS_NO,
        OnAccept = function()
            HealBot_Options_SetDefaults();
        end,
        timeout = 0,
        whileDead = 1,
        hideOnEscape = 1
    };

    StaticPopup_Show ("HEALBOT_OPTIONS_SETDEFAULTS");
end

function HealBot_Options_Reset_OnClick(self,mode)
    HealBot_SetResetFlag(mode)
end

function HealBot_Options_SetDefaults()
    HealBot_Config = HealBot_ConfigDefaults;
    HealBot_Globals = HealBot_GlobalsDefaults;
    if Healbot_Config_Skins.Chat[Healbot_Config_Skins.Current_Skin]["NOTIFY"] then HealBot_Options_CastNotify_OnClick(nil,0); end
    table.foreach(HealBot_Config_SkinsDefaults, function (key,val)
        if Healbot_Config_Skins[key]==nil then
            Healbot_Config_Skins[key] = val;
        end
    end);
    table.foreach(HealBot_Config_SpellsDefaults, function (key,val)
        if HealBot_Config_Spells[key]==nil then
            HealBot_Config_Spells[key] = val;
        end
    end);
    table.foreach(HealBot_Config_BuffsDefaults, function (key,val)
        if HealBot_Config_Buffs[key]==nil then
            HealBot_Config_Buffs[key] = val;
        end
    end);
    table.foreach(HealBot_Config_CuresDefaults, function (key,val)
        if HealBot_Config_Cures[key]==nil then
            HealBot_Config_Cures[key] = val;
        end
    end);
    
    HealBot_Config.CurrentSpec=1
    HealBot_runDefaults()
    HealBot_Options_Opened=false;
    HealBot_Action_Reset();
    HealBot_Action_SetAllAttribs()
    HealBot_Options:Hide()
    DoneInitTab={}
    HealBot_setOptions_Timer(8000)
end

function HealBot_Options_OnLoad(self, panelNum)
    DoneInitTab={}
  -- Tabs
    local g=_G["HealBot_Options_FramesSkinsFrame"]
    g:Hide()
    g=_G["HealBot_Options_HeadersSkinsFrame"]
    g:Hide()
    g=_G["HealBot_Options_IconsSkinsFrame"]
    g:Hide()
    g=_G["HealBot_Options_ProtSkinsFrame"]
    g:Hide()
    g=_G["HealBot_Options_ChatSkinsFrame"]
    g:Hide()
    g=_G["HealBot_Options_BarsSkinsFrame"]
    g:Hide()
    g=_G["HealBot_Options_HealGroupsSkinsFrame"]
    g:Hide()
    g=_G["HealBot_Options_BuffIconFrame"]
    g:Hide()
    g=_G["HealBot_Options_SkinsFrameIconsText"]
    g:Hide()
    g=_G["HealBot_Options_SkinsFrameHeadersFrame"]
    g:Hide()
    g=_G["HealBot_Options_FramesSelFrame"]
    g:Hide()
    g=_G["HealBot_Options_ApplyTab2Frames"]
    g:Hide()
    g=_G["HealBot_Options_CustomCureFrame"]
    g:Hide()
    g=_G["HealBot_Options_WarningCureFrame"]
    g:Hide()
   -- g=_G["HealBot_SkinsSubFrameSelectHealRaidFramef"]
   -- g:SetTextColor(1,1,1,1)
   -- g=_G["HealBot_SkinsSubFrameSelectHealSortFramef"]
   -- g:SetTextColor(1,1,0,0.92)
   -- g=_G["HealBot_SkinsSubFrameSelectHealHideFramef"]
   -- g:SetTextColor(1,1,0,0.92)
    
    g=_G["HealBot_Contents_ButtonT0"]
    g:SetStatusBarColor(0.2,0.2,0.2,0.55)
    g=_G["HealBot_Contents_ButtonT0Txt"]
    g:SetTextColor(1,1,1,1)
    g=_G["HealBot_Contents_ButtonT1"]
    g:SetStatusBarColor(0.2,0.2,0.2,0)
    g=_G["HealBot_Contents_ButtonT1Txt"]
    g:SetTextColor(1,1,0,0.9)
    g=_G["HealBot_Contents_ButtonT2"]
    g:SetStatusBarColor(0.2,0.2,0.2,0)
    g=_G["HealBot_Contents_ButtonT2Txt"]
    g:SetTextColor(1,1,0,0.9)
    g=_G["HealBot_Contents_ButtonT3"]
    g:SetStatusBarColor(0.2,0.2,0.2,0)
    g=_G["HealBot_Contents_ButtonT3Txt"]
    g:SetTextColor(1,1,0,0.9)
    g=_G["HealBot_Contents_ButtonT301Txt"]
    g:SetTextColor(1,1,0,0.9)
    g=_G["HealBot_Contents_ButtonT305Txt"]
    g:SetTextColor(1,1,0,0.9)
    g=_G["HealBot_Contents_ButtonT307Txt"]
    g:SetTextColor(1,1,0,0.9)
    g=_G["HealBot_Contents_ButtonT308Txt"]
    g:SetTextColor(1,1,0,0.9)
    g=_G["HealBot_Contents_ButtonT309Txt"]
    g:SetTextColor(1,1,0,0.9)
    g=_G["HealBot_Contents_ButtonT310Txt"]
    g:SetTextColor(1,1,0,0.9)
    g=_G["HealBot_Contents_ButtonT311Txt"]
    g:SetTextColor(1,1,0,0.9)
    g=_G["HealBot_Contents_ButtonT312Txt"]
    g:SetTextColor(1,1,0,0.9)
    g=_G["HealBot_Contents_ButtonT314Txt"]
    g:SetTextColor(1,1,0,0.9)
    g=_G["HealBot_Contents_ButtonT4"]
    g:SetStatusBarColor(0.2,0.2,0.2,0)
    g=_G["HealBot_Contents_ButtonT4Txt"]
    g:SetTextColor(1,1,0,0.9)
    g=_G["HealBot_Contents_ButtonT41Txt"]
    g:SetTextColor(1,1,0,0.9)
    g=_G["HealBot_Contents_ButtonT42Txt"]
    g:SetTextColor(1,1,0,0.9)
    g=_G["HealBot_Contents_ButtonT43Txt"]
    g:SetTextColor(1,1,0,0.9)
    g=_G["HealBot_Contents_ButtonT5"]
    g:SetStatusBarColor(0.2,0.2,0.2,0)
    g=_G["HealBot_Contents_ButtonT5Txt"]
    g:SetTextColor(1,1,0,0.9)
    g=_G["HealBot_Contents_ButtonT51Txt"]
    g:SetTextColor(1,1,0,0.9)
    g=_G["HealBot_Contents_ButtonT52Txt"]
    g:SetTextColor(1,1,0,0.9)
    g=_G["HealBot_Contents_ButtonT53Txt"]
    g:SetTextColor(1,1,0,0.9)
    g=_G["HealBot_Contents_ButtonT6"]
    g:SetStatusBarColor(0.2,0.2,0.2,0)
    g=_G["HealBot_Contents_ButtonT6Txt"]
    g:SetTextColor(1,1,0,0.9)
    g=_G["HealBot_Contents_ButtonT7"]
    g:SetStatusBarColor(0.2,0.2,0.2,0)
    g=_G["HealBot_Contents_ButtonT7Txt"]
    g:SetTextColor(1,1,0,0.9)
    g=_G["HealBot_Contents_ButtonT8"]
    g:SetStatusBarColor(0.2,0.2,0.2,0)
    g=_G["HealBot_Contents_ButtonT9"]
    g:SetStatusBarColor(0.2,0.2,0.2,0)
    g=_G["HealBot_Contents_ButtonT8Txt"]
    g:SetTextColor(1,1,0,0.9)
    g=_G["HealBot_Contents_ButtonT9Txt"]
    g:SetTextColor(1,1,0,0.9)
    g=_G["HealBot_Contents_ButtonT91Txt"]
    g:SetTextColor(1,1,0,0.9)
    g=_G["HealBot_Contents_ButtonT92Txt"]
    g:SetTextColor(1,1,0,0.9)
    g=_G["HealBot_Contents_ButtonT93Txt"]
    g:SetTextColor(1,1,0,0.9)
    g=_G["HealBot_Contents_ButtonT94Txt"]
    g:SetTextColor(1,1,0,0.9)
    g=_G["HealBot_Contents_ButtonT95Txt"]
    g:SetTextColor(1,1,0,0.9)
    g=_G["HealBot_SkinsAggroAlphaText"]
    g:SetTextColor(1,1,1,1)
    g=_G["HealBot_Options_Contents"]
    g:SetBackdropColor(0,0,0,0.7);
    g=_G["HealBot_Options_MainFrame"]
    g:SetBackdropColor(0,0,0,0.7);
    g=_G["HealBot_About_AuthorH"]
    g:SetTextColor(1,1,1,1);
    g=_G["HealBot_About_URLH"]
    g:SetTextColor(1,1,1,1);
    g=_G["HealBot_About_CatH"]
    g:SetTextColor(1,1,1,1);
    g=_G["HealBot_About_CreditH"]
    g:SetTextColor(1,1,1,1);
    g=_G["HealBot_About_LocalH"]
    g:SetTextColor(1,1,1,1);    
    g=_G["HealBot_About_Desc1"]
    g:SetTextColor(1,1,1,1);    
    g=_G["HealBot_Options_SkinAuthorName"]
    g:SetTextColor(1,1,1,1);  
    g=_G["HealBot_Options_ShiftCntlAltClickDetail"]
    g:SetTextColor(1,1,1,1);  
    HealBot_Options_CDCCastByCustom:Disable()    
    HealBot_Options_CDCPriorityCustom:Disable()
end

HealBot_Options_StorePrev["TabNo"] = 0;

function HealBot_Options_OnShow(self)
    HealBot_Options_ShowPanel(self, HealBot_Options_StorePrev["TabNo"])
end

function HealBot_Options_Close()
    if HealBot_Options_SoftReset_flag then
        HealBot_Options_SoftReset_flag=false
        HealBot_Action_SetAllAttribs()
    end
end

function HealBot_Options_idleInit()
    if not DoneInitTab[0] then
        DoneInitTab[0]=100
    elseif DoneInitTab[0]>0 then
        if not UIDROPDOWNMENU_OPEN_MENU then
            DoneInitTab[0]=DoneInitTab[0]+1
            if DoneInitTab[0]>103 and DoneInitTab[0]<199 then
                DoneInitTab[0]=200
            elseif DoneInitTab[0]>201 and DoneInitTab[0]<299 then
                DoneInitTab[0]=300
            elseif DoneInitTab[0]>311 and DoneInitTab[0]<399 then
                DoneInitTab[0]=400
            elseif DoneInitTab[0]>406 and DoneInitTab[0]<499 then
                DoneInitTab[0]=500
            elseif DoneInitTab[0]>502 and DoneInitTab[0]<599 then
                DoneInitTab[0]=600
            elseif DoneInitTab[0]>601 and DoneInitTab[0]<699 then
                DoneInitTab[0]=700
            elseif DoneInitTab[0]>701 and DoneInitTab[0]<799 then
                DoneInitTab[0]=800
            elseif DoneInitTab[0]>801 and DoneInitTab[0]<899 then
                DoneInitTab[0]=900
            elseif DoneInitTab[0]>901 then
                DoneInitTab[0]=0
            end
            HealBot_Options_InitSub(DoneInitTab[0])
        end
    else
        HealBot_setLuVars("TargetNeedReset", true)
        HealBot_setLuVars("FocusNeedReset", true)
        return nil
    end
    return true
end

function HealBot_Options_Lang(region)
    local validCode = true
    local loaded, reason = nil,nil
    if region=="ptBR" then
        loaded, reason = LoadAddOn("HealBot_br")
        if loaded then
            HealBot_Lang_ptBR()
            HealBot_AddChat("Switching Lang to ptBR")
            HealBot_Options_StorePrev["hbLangs"]=10
        else
            HealBot_AddChat("Unable to load ptBR (Addon: HealBot_br) - Reason: "..reason)
            validCode=false
        end
    elseif region=="zhCN" then
        loaded, reason = LoadAddOn("HealBot_cn")
        if loaded then
            HealBot_Lang_zhCN()
            HealBot_AddChat("Switching Lang to zhCN")
            HealBot_Options_StorePrev["hbLangs"]=1
        else
            HealBot_AddChat("Unable to load zhCN (Addon: HealBot_cn) - Reason: "..reason)
            validCode=false
        end
    elseif region=="deDE" then
        loaded, reason = LoadAddOn("HealBot_de")
        if loaded then
            HealBot_Lang_deDE()
            HealBot_AddChat("Switching Lang to deDE")
            HealBot_Options_StorePrev["hbLangs"]=5
        else
            HealBot_AddChat("Unable to load deDE (Addon: HealBot_de) - Reason: "..reason)
            validCode=false
        end
    elseif region=="esES" then
        loaded, reason = LoadAddOn("HealBot_es")
        if loaded then
            HealBot_Lang_esES()
            HealBot_AddChat("Switching Lang to esES")
            HealBot_Options_StorePrev["hbLangs"]=12
        else
            HealBot_AddChat("Unable to load esES (Addon: HealBot_es) - Reason: "..reason)
            validCode=false
        end  
	elseif region=="esMX" then
        loaded, reason = LoadAddOn("HealBot_es")
        if loaded then
            HealBot_Lang_esMX()
            HealBot_AddChat("Switching Lang to esMX")
            HealBot_Options_StorePrev["hbLangs"]=14
        else
            HealBot_AddChat("Unable to load esMX (Addon: HealBot_es) - Reason: "..reason)
            validCode=false
        end  
    elseif region=="frFR" then
        loaded, reason = LoadAddOn("HealBot_fr")
        if loaded then
            HealBot_Lang_frFR()
            HealBot_AddChat("Switching Lang to frFR")
            HealBot_Options_StorePrev["hbLangs"]=4
        else
            HealBot_AddChat("Unable to load frFR (Addon: HealBot_fr) - Reason: "..reason)
            validCode=false
        end
    elseif region=="huHU" then
        loaded, reason = LoadAddOn("HealBot_hu")
        if loaded then
            HealBot_Lang_huHU()
            HealBot_AddChat("Switching Lang to huHU")
            HealBot_Options_StorePrev["hbLangs"]=7
        else
            HealBot_AddChat("Unable to load huHU (Addon: HealBot_hu) - Reason: "..reason)
            validCode=false
        end  
    elseif region=="koKR" then
        loaded, reason = LoadAddOn("HealBot_kr")
        if loaded then
            HealBot_Lang_koKR()
            HealBot_AddChat("Switching Lang to koKR")
            HealBot_Options_StorePrev["hbLangs"]=9
        else
            HealBot_AddChat("Unable to load koKR (Addon: HealBot_kr) - Reason: "..reason)
            validCode=false
        end  
    elseif region=="ruRU" then
        loaded, reason = LoadAddOn("HealBot_ru")
        if loaded then
            HealBot_Lang_ruRU()
            HealBot_AddChat("Switching Lang to ruRU")
            HealBot_Options_StorePrev["hbLangs"]=11
        else
            HealBot_AddChat("Unable to load ruRU (Addon: HealBot_ru) - Reason: "..reason)
            validCode=false
        end  
    elseif region=="zhTW" then
        loaded, reason = LoadAddOn("HealBot_tw")
        if loaded then
            HealBot_Lang_zhTW()
            HealBot_AddChat("Switching Lang to zhTW")
            HealBot_Options_StorePrev["hbLangs"]=13
        else
            HealBot_AddChat("Unable to load zhTW (Addon: HealBot_tw) - Reason: "..reason)
            validCode=false
        end  
    elseif region=="itIT" then
        loaded, reason = LoadAddOn("HealBot_it")
        if loaded then
            HealBot_Lang_itIT()
            HealBot_AddChat("Switching Lang to itIT")
            HealBot_Options_StorePrev["hbLangs"]=8
        else
            HealBot_AddChat("Unable to load itIT (Addon: HealBot_it) - Reason: "..reason)
            validCode=false
        end  
    elseif region=="grGR" then
        loaded, reason = LoadAddOn("HealBot_gr")
        if loaded then
            HealBot_Lang_grGR()
            HealBot_AddChat("Switching Lang to grGR")
            HealBot_Options_StorePrev["hbLangs"]=6
        else
            HealBot_AddChat("Unable to load grGR (Addon: HealBot_gr) - Reason: "..reason)
            validCode=false
        end  
    elseif region=="enUK" then
        HealBot_Lang_enUK()
        HealBot_AddChat("Switching Lang to enUK")
        HealBot_Options_StorePrev["hbLangs"]=2
    elseif region=="enUS" then
        HealBot_Lang_enUS()
        HealBot_AddChat("Switching Lang to enUS")
        HealBot_Options_StorePrev["hbLangs"]=3
    else
        validCode=nil
        HealBot_AddChat("Invalid Region code "..region)
    end
    if not validCode then
        if region and not HealBot_Globals.OneTimeMsg[region] then
            HealBot_Globals.OneTimeMsg[region]=true
            local failreason = reason or HEALBOT_WORDS_UNKNOWN
            HealBot_Options_LangAddonFail(region, failreason)
        end
    elseif region~=(HealBot_Options_StorePrev["hbrCode"] or "nil") then
        HealBot_HealGroupsTrans = { [HEALBOT_OPTIONS_SELFHEALS_en] = HEALBOT_OPTIONS_SELFHEALS,
                                    [HEALBOT_OPTIONS_TANKHEALS_en] = HEALBOT_OPTIONS_TANKHEALS,
                                    [HEALBOT_CLASSES_HEALERS_en] = HEALBOT_CLASSES_HEALERS,
                                    [HEALBOT_OPTIONS_GROUPHEALS_en] = HEALBOT_OPTIONS_GROUPHEALS,
                                    [HEALBOT_OPTIONS_MYTARGET_en] = HEALBOT_OPTIONS_MYTARGET,
                                    [HEALBOT_FOCUS_en] = HEALBOT_FOCUS,
                                    [HEALBOT_OPTIONS_EMERGENCYHEALS_en] = HEALBOT_OPTIONS_EMERGENCYHEALS,
                                    [HEALBOT_OPTIONS_PETHEALS_en] = HEALBOT_OPTIONS_PETHEALS,
                                    [HEALBOT_VEHICLE_en] = HEALBOT_VEHICLE,
                                    [HEALBOT_OPTIONS_TARGETHEALS_en] = HEALBOT_OPTIONS_TARGETHEALS,
                                    [HEALBOT_CUSTOM_CASTBY_ENEMY_en] = HEALBOT_CUSTOM_CASTBY_ENEMY,
                                    }
        HealBot_Options_StorePrev["hbrCode"]=region
        HealBot_Options_ResetDoInittabAll()
        HealBot_Options_Init(1)
        HealBot_Options_SetSkins()
        local g=_G["HealBot_Contents_ButtonT0Txt"] 
        g:SetText(HEALBOT_OPTIONS_CONTENT_ABOUT)
        g=_G["HealBot_Contents_ButtonT1Txt"] 
        g:SetText(HEALBOT_OPTIONS_CONTENT_GENERAL)
        g=_G["HealBot_Contents_ButtonT2Txt"] 
        g:SetText(HEALBOT_OPTIONS_CONTENT_SPELLS)
        g=_G["HealBot_Contents_ButtonT3Txt"] 
        g:SetText(HEALBOT_OPTIONS_CONTENT_SKINS)
        g=_G["HealBot_Contents_ButtonT301Txt"]
        g:SetText(HEALBOT_OPTIONS_CONTENT_SKINS_GENERAL)
        g=_G["HealBot_Contents_ButtonT305Txt"]
        g:SetText(HEALBOT_OPTIONS_CONTENT_SKINS_PROT)
        g=_G["HealBot_Contents_ButtonT307Txt"]
        g:SetText(HEALBOT_OPTIONS_CONTENT_SKINS_CHAT)
        g=_G["HealBot_Contents_ButtonT308Txt"]
        g:SetText(HEALBOT_OPTIONS_CONTENT_SKINS_FRAMES)
        g=_G["HealBot_Contents_ButtonT309Txt"]
        g:SetText(HEALBOT_OPTIONS_CONTENT_GENERAL)
        g=_G["HealBot_Contents_ButtonT310Txt"]
        g:SetText(HEALBOT_OPTIONS_CONTENT_SKINS_HEALGROUP)
        g=_G["HealBot_Contents_ButtonT311Txt"]
        g:SetText(HEALBOT_OPTIONS_CONTENT_SKINS_HEADERS)
        g=_G["HealBot_Contents_ButtonT312Txt"]
        g:SetText(HEALBOT_OPTIONS_CONTENT_SKINS_BARS)
        g=_G["HealBot_Contents_ButtonT314Txt"]
        g:SetText(HEALBOT_OPTIONS_CONTENT_SKINS_ICONS)
        g=_G["HealBot_Contents_ButtonT4Txt"] 
        g:SetText(HEALBOT_OPTIONS_CONTENT_CURE)
        g=_G["HealBot_Contents_ButtonT41Txt"]
        g:SetText(HEALBOT_OPTIONS_CONTENT_CURE_DEBUFF)
        g=_G["HealBot_Contents_ButtonT42Txt"]
        g:SetText(HEALBOT_OPTIONS_CONTENT_CURE_CUSTOM)
        g=_G["HealBot_Contents_ButtonT43Txt"]
        g:SetText(HEALBOT_OPTIONS_CONTENT_CURE_WARNING)
        g=_G["HealBot_Contents_ButtonT5Txt"] 
        g:SetText(HEALBOT_OPTIONS_CONTENT_BUFFS)
        g=_G["HealBot_Contents_ButtonT51Txt"] 
        g:SetText(HEALBOT_OPTIONS_CONTENT_BUFFS_GENERAL)
        g=_G["HealBot_Contents_ButtonT52Txt"] 
        g:SetText(HEALBOT_OPTIONS_CONTENT_BUFFS_HOTS)
        g=_G["HealBot_Contents_ButtonT53Txt"] 
        g:SetText(HEALBOT_OPTIONS_CONTENT_CURE_WARNING)
        g=_G["HealBot_Contents_ButtonT6Txt"] 
        g:SetText(HEALBOT_OPTIONS_CONTENT_TIPS)
        g=_G["HealBot_Contents_ButtonT7Txt"] 
        g:SetText(HEALBOT_OPTIONS_CONTENT_MOUSEWHEEL)
        g=_G["HealBot_Contents_ButtonT8Txt"] 
        g:SetText(HEALBOT_OPTIONS_CONTENT_TEST)
        g=_G["HealBot_Contents_ButtonT9Txt"] 
        g:SetText(HEALBOT_OPTIONS_CONTENT_INOUT)
        g=_G["HealBot_Contents_ButtonT91Txt"] 
        g:SetText(HEALBOT_OPTIONS_CONTENT_INOUT_SKINS)
        g=_G["HealBot_Contents_ButtonT92Txt"] 
        g:SetText(HEALBOT_OPTIONS_CONTENT_INOUT_CDEBUFF)
        g=_G["HealBot_Contents_ButtonT93Txt"] 
        g:SetText(HEALBOT_OPTIONS_CONTENT_INOUT_BUFF)
        g=_G["HealBot_Contents_ButtonT94Txt"] 
        g:SetText(HEALBOT_OPTIONS_CONTENT_INOUT_SPELLS)
        g=_G["HealBot_Contents_ButtonT95Txt"] 
        g:SetText(HEALBOT_OPTIONS_CONTENT_INOUT_PRESETCOL)
        g=_G["HealBot_Options_CloseButton"] 
        g:SetText(HEALBOT_OPTIONS_CLOSE)
        g=_G["HealBot_Options_Defaults"] 
        g:SetText(HEALBOT_OPTIONS_DEFAULTS)
        g=_G["HealBot_Options_Reload"] 
        g:SetText(HEALBOT_OPTIONS_HARDRESET)
        g=_G["HealBot_Options_Reset"] 
        g:SetText(HEALBOT_OPTIONS_SOFTRESET)
        g=_G["HealBot_Options_TooltipPosSettings"] 
        g:SetText(HEALBOT_OPTIONS_SETTOOLTIP_POSITION)
        g=_G["HealBot_Options_FramesHealGroupSettings"] 
        g:SetText(HEALBOT_OPTIONS_SET_FRAME_HEALGROUPS)
        g=_G["HealBot_Options_SkinsFrameIconsGeneralb"] 
        g:SetText(HEALBOT_OPTIONS_TAB_GENERAL)
        g=_G["HealBot_Options_SkinsFrameIconsTextb"] 
        g:SetText(HEALBOT_WORD_TEXT)
        g=_G["HealBot_Options_SkinsFramesBarsGeneralb"] 
        g:SetText(HEALBOT_OPTIONS_TAB_GENERAL)
        g=_G["HealBot_Options_SkinsFramesBarsColoursb"] 
        g:SetText(HEALBOT_WORD_COLOUR)
        g=_G["HealBot_Options_SkinsFramesBarsTextb"] 
        g:SetText(HEALBOT_WORD_TEXT)
        g=_G["HealBot_Options_SkinsFramesBarsSortb"] 
        g:SetText(HEALBOT_OPTIONS_TAB_SORT)
        g=_G["HealBot_Options_SkinsFramesBarsVisibilityb"] 
        g:SetText(HEALBOT_OPTIONS_TAB_VISIBILITY)
        g=_G["HealBot_Options_SkinsFramesBarsAggrob"] 
        g:SetText(HEALBOT_OPTIONS_TAB_AGGRO)
        g=_G["HealBot_Options_ShiftCntlAltClickHeader"] 
        g:SetText(HEALBOT_OPTIONS_SHIFT.."+"..HEALBOT_OPTIONS_CTRL.."+"..HEALBOT_OPTIONS_ALT.."+"..HEALBOT_OPTIONS_CLICK..":")
        HealBot_Options_SetText(HealBot_Options_FrameTitle,HEALBOT_OPTIONS_FRAME_TITLE)
        HealBot_Options_SetText(HealBot_Options_FrameAlias,HEALBOT_OPTIONS_FRAME_ALIAS)
        HealBot_Options_SetText(HealBot_Options_FrameAliasShow,HEALBOT_OPTIONS_FRAME_TITLE_SHOW)
        g=_G["HealBot_Options_FrameAliasFixedFrame"] 
        g:Hide()
        if GetLocale()~=region then
            HealBot_Globals.localLang=region
        else
            HealBot_Globals.localLang=nil
        end
    end
end

function HealBot_Options_ResetDoInittabAll()
    HealBot_Options_setLists()
    HealBot_Options_ResetDoInittab(1)
    HealBot_Options_ResetDoInittab(2)
    HealBot_Options_ResetDoInittab(3)
    HealBot_Options_ResetDoInittab(4)
    HealBot_Options_ResetDoInittab(5)
    HealBot_Options_ResetDoInittab(6)
    HealBot_Options_ResetDoInittab(7)
    HealBot_Options_ResetDoInittab(40)
    HealBot_Options_ResetDoInittab(50)
    HealBot_Options_ResetDoInittab(8)
end

function HealBot_Options_ResetDoInittab(tabNo)
    if tabNo==1 then
        DoneInitTab[1]=nil
        DoneInitTab[101]=nil
        DoneInitTab[102]=nil
        if DoneInitTab[0] and (DoneInitTab[0]==0 or DoneInitTab[0]>100) then DoneInitTab[0]=100 end
        HealBot_setOptions_Timer(8000)
    elseif tabNo==2 then
        DoneInitTab[2]=nil
        DoneInitTab[21]=nil
        DoneInitTab[201]=nil
        if DoneInitTab[0] and (DoneInitTab[0]==0 or DoneInitTab[0]>200) then DoneInitTab[0]=200 end
        HealBot_setOptions_Timer(8000)
    elseif tabNo==3 then
        DoneInitTab[3]=nil
        DoneInitTab[102]=nil
        DoneInitTab[301]=nil
        DoneInitTab[302]=nil
        DoneInitTab[303]=nil
        DoneInitTab[306]=nil
        DoneInitTab[307]=nil
        DoneInitTab[308]=nil
        DoneInitTab[309]=nil
        DoneInitTab[310]=nil
        DoneInitTab[311]=nil
        DoneInitTab[1001]=nil
        DoneInitTab[1002]=nil
        DoneInitTab[1003]=nil
        DoneInitTab[1004]=nil
        DoneInitTab[1005]=nil
        DoneInitTab[1007]=nil
        DoneInitTab[1008]=nil
        DoneInitTab[1009]=nil
        DoneInitTab[1010]=nil
        DoneInitTab[1011]=nil
        DoneInitTab[1014]=nil
        if DoneInitTab[0] and (DoneInitTab[0]==0 or DoneInitTab[0]>300) then DoneInitTab[0]=300 end
        HealBot_setOptions_Timer(8000)
    elseif tabNo==4 then
        DoneInitTab[4]=nil
        DoneInitTab[405]=nil
        DoneInitTab[406]=nil
        DoneInitTab[499]=nil
        if DoneInitTab[0] and (DoneInitTab[0]==0 or DoneInitTab[0]>403) then DoneInitTab[0]=403 end
        HealBot_setOptions_Timer(8000)
    elseif tabNo==5 then
        DoneInitTab[5]=nil
        DoneInitTab[501]=nil
        if DoneInitTab[0] and (DoneInitTab[0]==0 or DoneInitTab[0]>500) then DoneInitTab[0]=500 end
        HealBot_setOptions_Timer(8000)
    elseif tabNo==6 then
        DoneInitTab[6]=nil
        DoneInitTab[601]=nil
    elseif tabNo==7 then
        DoneInitTab[7]=nil
        DoneInitTab[701]=nil
        if DoneInitTab[0] and (DoneInitTab[0]==0 or DoneInitTab[0]>700) then DoneInitTab[0]=700 end
        HealBot_setOptions_Timer(8000)
    elseif tabNo==40 then
        DoneInitTab[4]=nil
        DoneInitTab[405]=nil
        if DoneInitTab[0] and (DoneInitTab[0]==0 or DoneInitTab[0]>403) then DoneInitTab[0]=403 end
        HealBot_setOptions_Timer(8000)
    elseif tabNo==50 then
        DoneInitTab[5]=nil
        DoneInitTab[501]=nil
        if DoneInitTab[0] and (DoneInitTab[0]==0 or DoneInitTab[0]>500) then DoneInitTab[0]=500 end
        HealBot_setOptions_Timer(8000)
    else
        DoneInitTab[10]=nil
        HealBot_Options_SelectSpellsFrame:Hide()
        HealBot_Options_KeysFrame:Show()
        DoneInitTab[201]=nil
        DoneInitTab[801]=nil
        DoneInitTab[99]=nil
        DoneInitTab[8]=nil
        if DoneInitTab[0] and (DoneInitTab[0]==0 or DoneInitTab[0]>800) then DoneInitTab[0]=800 end
        HealBot_setOptions_Timer(8000)
    end
    if HealBot_Options:IsVisible() then
        HealBot_Options_Init(tabNo)
    end
end

HealBot_Options_StorePrev["selSpellsType"]=1
function HealBot_Options_Init(tabNo)
    local g=nil
    if tabNo==0 then
        if not DoneInitTab[99] then            
            HealBot_Options_InitSub(801)
            DoneInitTab[99]=true
        end
        HealBot_Comms_About()
    elseif tabNo==9 then
        if not DoneInitTab[9] then
            HealBot_Options_ShareSkinb:SetText(HEALBOT_OPTIONS_BUTTONEXPORT)
            HealBot_Options_ShareCDebuffb:SetText(HEALBOT_OPTIONS_BUTTONEXPORT)
            HealBot_Options_InOutSkint:SetText(HEALBOT_OPTIONS_EXPORTSKIN)
            HealBot_Options_LoadSkinb:SetText(HEALBOT_OPTIONS_BUTTONIMPORT)
            HealBot_Options_LoadCDebuffb:SetText(HEALBOT_OPTIONS_BUTTONIMPORT)
            HealBot_Options_ImportMethodCDebufft:SetText(HEALBOT_OPTIONS_BUTTONIMPORTMETHOD)
            --HealBot_Options_ImportMethodBuffs:SetText(HEALBOT_OPTIONS_BUTTONIMPORTMETHOD)
            DoneInitTab[9]=true
        end
    elseif tabNo==1 then
        if not DoneInitTab[1] then
            HealBot_Options_EFClass_Reset()
            HealBot_Options_InitSub(102)
            HealBot_Options_InitSub(101)
            DoneInitTab[1]=true
        end
    elseif tabNo==2 then
        if not DoneInitTab[21] then
            HealBot_Options_InitSub(201)
            DoneInitTab[21]=true
        end
        if not DoneInitTab[2] then
            HealBot_Options_ComboClass_Text()
            DoneInitTab[2]=true
        end
    elseif tabNo==4 then
        if not DoneInitTab[499] then
            HealBot_Options_InitSub(401)
            HealBot_Options_InitSub(402)
            HealBot_Options_InitSub(403)
            HealBot_Options_InitSub(404)
            HealBot_Options_InitSub(405)
            HealBot_SetCDCBarColours()
            DoneInitTab[499]=true
        end
        if not DoneInitTab[4] then
            HealBot_Options_InitSub(405)
            HealBot_Options_InitSub(406)
            DoneInitTab[4]=true
        end
    elseif tabNo==3 then
        if not DoneInitTab[3] then
            HealBot_Options_InitSub(311)
            HealBot_Options_InitSub(306)
            HealBot_Options_InitSub(303)
            DoneInitTab[3]=true
            if HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_PALADIN] then
                HealBot_Options_ShowPowerCounter:Show()
                HealBot_Options_ShowPowerCounterText:SetText(HEALBOT_OPTIONS_SHOWPOWERCOUNTER_PALA)
            elseif HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_MONK] then
                HealBot_Options_ShowPowerCounter:Show()
                HealBot_Options_ShowPowerCounterText:SetText(HEALBOT_OPTIONS_SHOWPOWERCOUNTER_MONK)
            else
                HealBot_Options_ShowPowerCounter:Hide()
            end
            g=_G["HealBot_Options_FramesSelFrameFontStr"]
            g:SetText(HEALBOT_OPTIONS_FRAME)
        end
    elseif tabNo==6 then
        if not DoneInitTab[6] then
            HealBot_Options_InitSub(601)
            DoneInitTab[6]=true
        end
    elseif tabNo==5 then
        if not DoneInitTab[5] then
            HealBot_Options_InitSub(501)
            HealBot_Options_InitSub(502)
            DoneInitTab[5]=true
        end
    elseif tabNo==7 then
        if not DoneInitTab[7] then
            HealBot_Options_InitSub(701)
            DoneInitTab[7]=true
        end
    elseif tabNo==8 then
        if not DoneInitTab[8] then
            HealBot_Options_val_OnLoad(HealBot_Options_NumberTestBars,HEALBOT_OPTION_NUMBARS,5,50,1)
            HealBot_Options_NumberTestBars:SetValue(HealBot_Globals.TestBars["BARS"])
            HealBot_Options_NumberTestBarsText:SetText(HEALBOT_OPTION_NUMBARS..": "..HealBot_Globals.TestBars["BARS"])
            HealBot_Options_val_OnLoad(HealBot_Options_NumberTestTanks,HEALBOT_OPTION_NUMTANKS,0,5,1)
            HealBot_Options_NumberTestTanks:SetValue(HealBot_Globals.TestBars["TANKS"])
            HealBot_Options_NumberTestTanksText:SetText(HEALBOT_OPTION_NUMTANKS..": "..HealBot_Globals.TestBars["TANKS"])
            HealBot_Options_val_OnLoad(HealBot_Options_NumberTestHealers,HEALBOT_OPTION_NUMHEALERS,0,8,1)
            HealBot_Options_NumberTestHealers:SetValue(HealBot_Globals.TestBars["HEALERS"])
            HealBot_Options_NumberTestHealersText:SetText(HEALBOT_OPTION_NUMHEALERS..": "..HealBot_Globals.TestBars["HEALERS"])
            HealBot_Options_val_OnLoad(HealBot_Options_NumberTestMyTargets,HEALBOT_OPTION_NUMMYTARGETS,0,7,1)
            HealBot_Options_NumberTestMyTargets:SetValue(HealBot_Globals.TestBars["TARGETS"])
            HealBot_Options_NumberTestMyTargetsText:SetText(HEALBOT_OPTION_NUMMYTARGETS..": "..HealBot_Globals.TestBars["TARGETS"])
            HealBot_Options_val_OnLoad(HealBot_Options_NumberTestPets,HEALBOT_OPTION_NUMPETS,0,10,1)
            HealBot_Options_NumberTestPets:SetValue(HealBot_Globals.TestBars["PETS"])
            HealBot_Options_NumberTestPetsText:SetText(HEALBOT_OPTION_NUMPETS..": "..HealBot_Globals.TestBars["PETS"])
            HealBot_Options_val_OnLoad(HealBot_Options_NumberTestEnemy,HEALBOT_OPTION_NUMENEMYS,0,10,1)
            HealBot_Options_NumberTestEnemy:SetValue(HealBot_Globals.TestBars["ENEMY"])
            HealBot_Options_NumberTestEnemyText:SetText(HEALBOT_OPTION_NUMENEMYS..": "..HealBot_Globals.TestBars["ENEMY"])
            HealBot_Options_TestBarsButton:SetText(HEALBOT_OPTIONS_TESTBARS.." "..HEALBOT_WORD_OFF)
            HealBot_Options_TestBarsProfile.initialize = HealBot_Options_TestBarsProfile_DropDown
            UIDropDownMenu_SetText(HealBot_Options_TestBarsProfile, HealBot_Options_TestBarsProfile_List[HealBot_Globals.TestBars["PROFILE"]])
            g=_G["HealBot_Options_TestBarsProfileTxt"]
            g:SetText(HEALBOT_WORDS_PROFILE)
            DoneInitTab[8]=true
        end
    elseif tabNo==11 then
        if not DoneInitTab[11] then
            HealBot_Options_DisableHealBotOpt:SetChecked(HealBot_Config.DisableHealBot)
            HealBot_Options_DisableHealBotSolo:SetChecked(HealBot_Config.DisableSolo)
            HealBot_Options_MonitorDebuffs:SetChecked(HealBot_Config_Cures.DebuffWatch)
            HealBot_Options_MonitorBuffs:SetChecked(HealBot_Config_Buffs.BuffWatch)
            DoneInitTab[11]=true
            HealBot_Options_SelectSpellsFrame:Hide()
            LSM.RegisterCallback(HEALBOT_HEALBOT, "LibSharedMedia_Registered", function(event, mediatype, key) HealBot_UpdateUsedMedia(event, mediatype, key) end)  
            LSM.RegisterCallback(HEALBOT_HEALBOT, "LibSharedMedia_SetGlobal", function(event, mediatype, key) HealBot_UpdateUsedMedia(event, mediatype, key) end)
        end
    elseif tabNo==10 then
        if HealBot_Options_StorePrev["ActionBarsCombo"]>2 then
            if HealBot_Options_StorePrev["selSpellsType"]<3 then
                DoneInitTab[201]=nil
                g=_G["healbotspellshelphealfontstr"]
                g:SetText(HEALBOT_OPTIONS_HARMFUL_SPELLS)
            end
        else
            if HealBot_Options_StorePrev["selSpellsType"]>2 then
                DoneInitTab[201]=nil
                g=_G["healbotspellshelphealfontstr"]
                g:SetText(HEALBOT_OPTIONS_SMARTCASTHEAL)
            end
        end
        HealBot_Options_InitSub(201)
        HealBot_Options_StorePrev["selSpellsType"]=HealBot_Options_StorePrev["ActionBarsCombo"]
    end
    if not HealBot_Options_Opened then
        HealBot_setOptions_Timer(100)
        HealBot_Options_Opened=true
        HealBot_HighlightActiveBarColour:SetStatusBarTexture(LSM:Fetch('statusbar',HealBot_Default_Textures[16].name));
        HealBot_HighlightTargetBarColour:SetStatusBarTexture(LSM:Fetch('statusbar',HealBot_Default_Textures[16].name));
        HealBot_Aggro3Colorpick:SetStatusBarTexture(LSM:Fetch('statusbar',HealBot_Default_Textures[16].name));
    end
end

function HealBot_Options_ResetSpellsHealperDropdown(ddType)
    if ddType=="SPELLS" then
        DoneInitTab[201]=nil
        HealBot_Options_InitSub(201)
        HealBot_Action_SetAllAttribs()
    end
end

function HealBot_Options_InitSub(subNo)
    if subNo<400 then
        HealBot_Options_InitSub1(subNo)
    else
        HealBot_Options_InitSub2(subNo)
    end
end

function HealBot_Options_InitSub1(subNo)
    local g=nil
    if subNo==101 then
        if not DoneInitTab[101] then
            HealBot_Options_hbCommands.initialize = HealBot_Options_hbCommands_DropDown
            UIDropDownMenu_SetText(HealBot_Options_hbCommands, HealBot_Options_hbCommands_List[HealBot_Options_StorePrev["hbCommands"]])
            HealBot_Options_EmergencyFClass.initialize = HealBot_Options_EmergencyFClass_DropDown
            UIDropDownMenu_SetText(HealBot_Options_EmergencyFClass, HealBot_Options_EmergencyFClass_List[HealBot_Globals.EmergencyFClass])
            HealBot_Options_hbLangs.initialize = HealBot_Options_hbLangs_DropDown
            UIDropDownMenu_SetText(HealBot_Options_hbLangs, HealBot_Options_hbLangs_List[HealBot_Options_StorePrev["hbLangs"]])
            HealBot_Options_NoAuraWhenRested:SetChecked(HealBot_Config_Buffs.NoAuraWhenRested)
            HealBot_Options_SetText(HealBot_Options_NoAuraWhenRested,HEALBOT_OPTION_IGNORE_AURA_RESTED)
            HealBot_Options_AdjustMaxHealth:SetChecked(HealBot_Config.AdjustMaxHealth)
            HealBot_Options_SetText(HealBot_Options_AdjustMaxHealth,HEALBOT_OPTION_ADJUST_MAX_HEALTH)
            local mmButtonShown=false
            if HealBot_Globals.MinimapIcon.hide==false then mmButtonShown=true end
            HealBot_Options_ShowMinimapButton:SetChecked(mmButtonShown)
            HealBot_Options_SetText(HealBot_Options_ShowMinimapButton,HEALBOT_OPTIONS_SHOWMINIMAPBUTTON)
            HealBot_Options_QueryTalents:SetChecked(HealBot_Globals.QueryTalents)
            HealBot_Options_SetText(HealBot_Options_QueryTalents,HEALBOT_OPTIONS_QUERYTALENTS)
            HealBot_Options_HideOptions:SetChecked(HealBot_Globals.HideOptions)
            HealBot_Options_SetText(HealBot_Options_HideOptions,HEALBOT_OPTIONS_HIDEOPTIONS)
            HealBot_Options_RightButtonOptions:SetChecked(HealBot_Globals.RightButtonOptions)
            HealBot_Options_SetText(HealBot_Options_RightButtonOptions,HEALBOT_OPTIONS_RIGHTBOPTIONS)
            HealBot_Options_EnableLibQuickHealth:SetChecked(HealBot_Globals.EnLibQuickHealth)
            HealBot_Options_SetText(HealBot_Options_EnableLibQuickHealth,HEALBOT_OPTIONS_ENABLELIBQH)
            HealBot_Options_EnableAutoCombat:SetChecked(HealBot_Globals.EnAutoCombat)
            HealBot_Options_SetText(HealBot_Options_EnableAutoCombat,HEALBOT_OPTIONS_ENABLEAUTOCOMBAT)
            HealBot_Options_val_OnLoad(HealBot_Options_MaxBarCache,HEALBOT_OPTIONS_MAXBARCACHE,5,40,1,5)
            HealBot_Options_MaxBarCache:SetValue(HealBot_Globals.MaxBarsCache or 20)
            HealBot_Options_MaxBarCacheText:SetText(HEALBOT_OPTIONS_MAXBARCACHE .. ": " .. HealBot_Globals.MaxBarsCache)
            HealBot_Options_sliderlabels_Init(HealBot_Options_RangeCheckFreq,HEALBOT_OPTIONS_RANGECHECKFREQ,1.0,10.0,0.5,2,HEALBOT_WORDS_MORECPU,HEALBOT_WORDS_LESSCPU)
            HealBot_Options_RangeCheckFreq:SetValue((HealBot_Globals.RangeCheckFreq or 0.5)*10)
            HealBot_Options_RangeCheckFreqText:SetText(HEALBOT_OPTIONS_RANGECHECKFREQ)-- .. ": " .. HealBot_Globals.RangeCheckFreq)
            HealBot_Options_SetText(HealBot_Options_DisableHealBotOpt,HEALBOT_OPTIONS_DISABLEHEALBOT)
            HealBot_Options_SetText(HealBot_Options_DisableHealBotSolo,HEALBOT_OPTIONS_DISABLEHEALBOTSOLO)
            g=_G["healbotcmdfontstr"]
            g:SetText(HEALBOT_OPTIONS_COMMANDS)
            HealBot_Options_CommandsButton:SetText(HEALBOT_WORD_RUN)
            HealBot_Options_SetText(HealBot_Options_EFClassDruid,HEALBOT_DRUID)
            HealBot_Options_SetText(HealBot_Options_EFClassHunter,HEALBOT_HUNTER)
            HealBot_Options_SetText(HealBot_Options_EFClassMage,HEALBOT_MAGE)
            HealBot_Options_SetText(HealBot_Options_EFClassPaladin,HEALBOT_PALADIN)
            HealBot_Options_SetText(HealBot_Options_EFClassPriest,HEALBOT_PRIEST)
            HealBot_Options_SetText(HealBot_Options_EFClassRogue,HEALBOT_ROGUE)
            HealBot_Options_SetText(HealBot_Options_EFClassShaman,HEALBOT_SHAMAN)
            HealBot_Options_SetText(HealBot_Options_EFClassWarlock,HEALBOT_WARLOCK)
            HealBot_Options_SetText(HealBot_Options_EFClassWarrior,HEALBOT_WARRIOR)
            HealBot_Options_SetText(HealBot_Options_EFClassDeathKnight,HEALBOT_DEATHKNIGHT)
            HealBot_Options_SetText(HealBot_Options_EFClassDemonHunter,HEALBOT_DEMONHUNTER)
            HealBot_Options_SetText(HealBot_Options_EFClassMonk,HEALBOT_MONK)
            g=_G["healbotlangfontstr"]
            g:SetText(HEALBOT_OPTIONS_LANG)
            HealBot_Options_LangsButton:SetText(HEALBOT_WORD_SET)
            g=_G["healbotcrolesfontstr"]
            g:SetText(HEALBOT_OPTIONS_EMERGFCLASS)
            HealBot_Options_hbProfileButtonText:SetText(HEALBOT_WORD_SET)
            g=_G["healbotprofilefontstr"]
            g:SetText(HEALBOT_OPTIONS_PROFILE)
            HealBot_Options_hbProfile.initialize = HealBot_Options_hbProfile_DropDown
            UIDropDownMenu_SetText(HealBot_Options_hbProfile, HealBot_Options_hbProfile_List[HealBot_Config.Profile])
            if HEALBOT_GAME_VERSION<4 then 
                HealBot_Options_EFClassDeathKnight:Hide()
                HealBot_Options_EFClassDemonHunter:Hide()
                HealBot_Options_EFClassMonk:Hide()
                HealBot_Options_EFClassDruid:ClearAllPoints()
                HealBot_Options_EFClassDruid:SetPoint("TOPLEFT","HealBot_Options_EmergencyFClass","BOTTOMLEFT",-135,-10)
                HealBot_Options_EFClassMage:ClearAllPoints()
                HealBot_Options_EFClassMage:SetPoint("TOPLEFT","HealBot_Options_EFClassHunter","TOPRIGHT",120,0)
                HealBot_Options_EFClassPaladin:ClearAllPoints()
                HealBot_Options_EFClassPaladin:SetPoint("TOPLEFT","HealBot_Options_EFClassDruid","BOTTOMLEFT",0,-7)
                HealBot_Options_EFClassRogue:ClearAllPoints()
                HealBot_Options_EFClassRogue:SetPoint("TOPLEFT","HealBot_Options_EFClassPriest","TOPRIGHT",120,0)
                HealBot_Options_EFClassShaman:ClearAllPoints()
                HealBot_Options_EFClassShaman:SetPoint("TOPLEFT","HealBot_Options_EFClassPaladin","BOTTOMLEFT",0,-7)
            end
            DoneInitTab[101]=true
        end
    elseif subNo==102 then -- These need to be called before the 300's
        --if not DoneInitTab[102] then
            HealBot_Options_FrameAliasList()
            g=_G["HealBot_HealButtons_FramesFrameText"]
            g:SetText(HEALBOT_OPTIONS_FRAMESOPTTEXT)
            HealBot_Options_FramesSelFrame.initialize = HealBot_Options_FramesSelFrame_DropDown
            UIDropDownMenu_SetText(HealBot_Options_FramesSelFrame, HealBot_Options_HealGroupsFrame_List[HealBot_Options_StorePrev["FramesSelFrame"]])
            --DoneInitTab[102]=true
        --end
    elseif subNo==103 then
        if not DoneInitTab[103] then
            for id=1,10 do
                g=_G["HealBot_PresetColourAlias"..id]
                g:SetText(HealBot_Globals.PresetColoursAlias[id])
                g=_G["HealBot_PresetColourpick"..id]
                g:SetStatusBarColor(HealBot_Globals.PresetColours[id].R, 
                                    HealBot_Globals.PresetColours[id].G, 
                                    HealBot_Globals.PresetColours[id].B, 
                                    HealBot_Globals.PresetColours[id].A) 
            end
            g=_G["HealBot_PresetColours_AliasHeader"]
            g:SetText(HEALBOT_OPTIONS_FRAME_ALIAS)
            g=_G["HealBot_PresetColours_BarHeader"]
            g:SetText(HEALBOT_OPTIONS_PRESET_COLOUR)
            DoneInitTab[103]=true
        end
    elseif subNo==201 then
        if not DoneInitTab[201] then
            HealBot_Options_CastButton.initialize = HealBot_Options_CastButton_DropDown
            UIDropDownMenu_SetText(HealBot_Options_CastButton, HealBot_Options_CastButton_List[HealBot_Options_ComboButtons_Button])
            HealBot_Options_SetText(HealBot_Options_CtrlShift,HEALBOT_OPTIONS_SHIFT.."+"..HEALBOT_OPTIONS_CTRL.."+"..HEALBOT_OPTIONS_CLICK)
            HealBot_Options_SetText(HealBot_Options_AltShift,HEALBOT_OPTIONS_SHIFT.."+"..HEALBOT_OPTIONS_ALT.."+"..HEALBOT_OPTIONS_CLICK)
            HealBot_Options_SetText(HealBot_Options_CtrlAlt,HEALBOT_OPTIONS_CTRL.."+"..HEALBOT_OPTIONS_ALT.."+"..HEALBOT_OPTIONS_CLICK)
            g=_G["HealBot_Options_HealSpellsSelect"]
            g:SetText(HEALBOT_WORD_SELECT)
            g=_G["healbotspellshelpotherfontstr"]
            g:SetText(HEALBOT_OPTIONS_OTHERSPELLS)
            g=_G["HealBot_Options_OtherSpellsSelect"]
            g:SetText(HEALBOT_WORD_SELECT)
            g=_G["healbotspellshelpmacrofontstr"]
            g:SetText(HEALBOT_WORD_MACROS)
            g=_G["HealBot_Options_MacrosSelect"]
            g:SetText(HEALBOT_WORD_SELECT)
            g=_G["healbotspellshelpitemsfontstr"]
            g:SetText(HEALBOT_OPTIONS_ITEMS)
            g=_G["HealBot_Options_ItemsSelect"]
            g:SetText(HEALBOT_WORD_SELECT)
            g=_G["healbotspellshelpcmdsfontstr"]
            g:SetText(HEALBOT_WORD_COMMANDS)
            g=_G["HealBot_Options_CmdsSelect"]
            g:SetText(HEALBOT_WORD_SELECT)
            g=_G["HealBot_Options_CancelHelpSelect"]
            g:SetText(HEALBOT_WORD_CANCEL)
            g=_G["HealBot_Options_SmartCastSpellTxt"]
            g:SetText(HEALBOT_OPTIONS_SMARTCASTSPELLS)
            HealBot_Options_ButtonCastMethod.initialize = HealBot_Options_ButtonCastMethod_DropDown
            UIDropDownMenu_SetText(HealBot_Options_ButtonCastMethod, HealBot_Options_ButtonCastMethod_List[HealBot_Config_Spells.ButtonCastMethod])
            HealBot_Options_ActionBarsCombo.initialize = HealBot_Options_ActionBarsCombo_DropDown
            UIDropDownMenu_SetText(HealBot_Options_ActionBarsCombo, HealBot_Options_ActionBarsCombo_List[HealBot_Options_StorePrev["ActionBarsCombo"]])
            HealBot_Options_EnableHealthy:SetChecked(HealBot_Config.EnableHealthy)
            HealBot_Options_SetText(HealBot_Options_EnableHealthy,HEALBOT_OPTIONS_ENABLEHEALTHY)
            HealBot_Options_SmartCastBuff:SetChecked(HealBot_Globals.SmartCastBuff)
            HealBot_Options_SetText(HealBot_Options_SmartCastBuff,HEALBOT_OPTIONS_SMARTCASTBUFF)
            HealBot_Options_SmartCastHeal:SetChecked(HealBot_Globals.SmartCastHeal)
            HealBot_Options_SetText(HealBot_Options_SmartCastHeal,HEALBOT_OPTIONS_SMARTCASTHEAL)
            HealBot_Options_SmartCastRes:SetChecked(HealBot_Globals.SmartCastRes)
            HealBot_Options_SetText(HealBot_Options_SmartCastRes,GetSpellInfo(HEALBOT_RESURRECTION))
            HealBot_Options_SmartCastDisspell:SetChecked(HealBot_Globals.SmartCastDebuff)
            HealBot_Options_SetText(HealBot_Options_SmartCastDisspell,HEALBOT_OPTIONS_SMARTCASTDISPELL)
            HealBot_Options_ProtectPvP:SetChecked(HealBot_Globals.ProtectPvP)
            HealBot_Options_SetText(HealBot_Options_ProtectPvP,HEALBOT_OPTIONS_PROTECTPVP)
            HealBot_Options_EnableSmartCast:SetChecked(HealBot_Globals.SmartCast)
            HealBot_Options_SetText(HealBot_Options_EnableSmartCast,HEALBOT_OPTIONS_ENABLESMARTCAST)
            g=_G["healbotspellshelphealfontstr"]
            g:SetText(HEALBOT_OPTIONS_SMARTCASTHEAL)
            g=_G["healbotsetspellsfontstr"]
            g:SetText(HEALBOT_OPTIONS_SETSPELLS)
            g=_G["HealBot_AutoTarget_ButtonText"]
            g:SetText(HEALBOT_OPTIONS_COMBOAUTOTARGET)
            g=_G["HealBot_AutoTrinket_ButtonText"]
            g:SetText(HEALBOT_OPTIONS_COMBOAUTOTRINKET)
            g=_G["HealBot_AvoidBC_ButtonText"]
            g:SetText(HEALBOT_OPTIONS_AVOIDBLUECURSOR)
            g=_G["HealBot_AvoidBC_ButtonText"]
            g:SetText(HEALBOT_OPTIONS_AVOIDBLUECURSOR)
            g=_G["healbotcombobuttonfontstr"]
            g:SetText(HEALBOT_OPTIONS_COMBOBUTTON)
            g=_G["healbotcastmethodfontstr"]
            g:SetText(HEALBOT_OPTIONS_BUTTONCASTMETHOD)
            HealBot_Options_SetText(HealBot_Options_Click,HEALBOT_OPTIONS_CLICK)
            HealBot_Options_SetText(HealBot_Options_Shift,HEALBOT_OPTIONS_SHIFT.."+"..HEALBOT_OPTIONS_CLICK)
            HealBot_Options_SetText(HealBot_Options_Ctrl,HEALBOT_OPTIONS_CTRL.."+"..HEALBOT_OPTIONS_CLICK)
            HealBot_Options_SetText(HealBot_Options_Alt,HEALBOT_OPTIONS_ALT.."+"..HEALBOT_OPTIONS_CLICK)
            HealBot_Options_SelectHealSpellsCombo.numButtons = 0;
            HealBot_Options_SelectHealSpellsCombo.initialize = HealBot_Options_SelectHealSpellsCombo_DropDown
            if HealBot_Options_StorePrev["ActionBarsCombo"]>2 then
                UIDropDownMenu_SetText(HealBot_Options_SelectHealSpellsCombo, HEALBOT_OPTIONS_HARMFUL_SPELLS)
            else
                UIDropDownMenu_SetText(HealBot_Options_SelectHealSpellsCombo, HEALBOT_OPTIONS_SMARTCASTHEAL)
            end
            HealBot_Options_SelectOtherSpellsCombo.numButtons = 0;
            HealBot_Options_SelectOtherSpellsCombo.initialize = HealBot_Options_SelectOtherSpellsCombo_DropDown
            UIDropDownMenu_SetText(HealBot_Options_SelectOtherSpellsCombo, HEALBOT_OPTIONS_OTHERSPELLS)
            HealBot_Options_SelectMacrosCombo.numButtons = 0;
            HealBot_Options_SelectMacrosCombo.initialize = HealBot_Options_SelectMacrosCombo_DropDown
            UIDropDownMenu_SetText(HealBot_Options_SelectMacrosCombo, HEALBOT_WORD_MACROS)
            HealBot_Options_SelectItemsCombo.numButtons = 0;
            HealBot_Options_SelectItemsCombo.initialize = HealBot_Options_SelectItemsCombo_DropDown
            UIDropDownMenu_SetText(HealBot_Options_SelectItemsCombo, HEALBOT_OPTIONS_ITEMS)
            HealBot_Options_SelectCmdsCombo.numButtons = 0;
            HealBot_Options_SelectCmdsCombo.initialize = HealBot_Options_SelectCmdsCombo_DropDown
            UIDropDownMenu_SetText(HealBot_Options_SelectCmdsCombo, HEALBOT_WORD_COMMANDS)
            DoneInitTab[201]=true
        end
    elseif subNo==301 then
        if not DoneInitTab[301] then
            HealBot_Options_ActionAnchor.initialize = HealBot_Options_ActionAnchor_DropDown
            if not Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin] or not Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]] or not
                Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["FRAME"] then
                    Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]] = {["FRAME"]=1,["BARS"]=1}
            end
            UIDropDownMenu_SetText(HealBot_Options_ActionAnchor, HealBot_Options_ActionAnchor_List[Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["FRAME"]])
            HealBot_Options_ActionBarsAnchor.initialize = HealBot_Options_ActionBarsAnchor_DropDown
            if not Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin] or not Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]] or not
                Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BARS"] then
                    Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]] = {["FRAME"]=1,["BARS"]=1}
            end
            UIDropDownMenu_SetText(HealBot_Options_ActionBarsAnchor, HealBot_Options_ActionAnchor_List[Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BARS"]])
            HealBot_Options_TooltipPos.initialize = HealBot_Options_TooltipPos_DropDown
            UIDropDownMenu_SetText(HealBot_Options_TooltipPos, HealBot_Options_TooltipPos_List[Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TIPLOC"]])
            g=_G["healbotframeanchorfontstr"]
            g:SetText(HEALBOT_OPTIONS_ANCHOR)
            g=_G["healbotbarsanchorfontstr"]
            g:SetText(HEALBOT_OPTIONS_BARSANCHOR)
            g=_G["healbotbarsgrowdirectionfontstr"]
            g:SetText(HEALBOT_OPTIONS_GROW_DIRECTION)
            g=_G["healbotbarsorientationfontstr"]
            g:SetText(HEALBOT_OPTIONS_BARSORIENTATION)
            HealBot_Options_val2_OnLoad(HealBot_FrameScale,HEALBOT_OPTIONS_FRAMESCALE,2.5,30,0.5,10)
            HealBot_FrameScale:SetValue((Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SCALE"])*10)
            HealBot_FrameScaleText:SetText(HEALBOT_OPTIONS_FRAMESCALE..": "..Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SCALE"])
            HealBot_Options_val_OnLoad(HealBot_FrameStickyOffsetHorizontal,HEALBOT_OPTIONS_STICKFRAMEOFFSETH,-10,15,1,2)
            HealBot_FrameStickyOffsetHorizontal:SetValue(Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SFOFFSETH"])
            HealBot_FrameStickyOffsetHorizontalText:SetText(HEALBOT_OPTIONS_STICKFRAMEOFFSETH..": "..Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SFOFFSETH"])
            HealBot_Options_val_OnLoad(HealBot_FrameStickyOffsetVertical,HEALBOT_OPTIONS_STICKFRAMEOFFSETV,-10,15,1,2)
            HealBot_FrameStickyOffsetVertical:SetValue(Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SFOFFSETV"])
            HealBot_FrameStickyOffsetVerticalText:SetText(HEALBOT_OPTIONS_STICKFRAMEOFFSETV..": "..Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SFOFFSETV"])
            HealBot_Options_SetFrameCols()
            HealBot_Options_ActionLocked:SetChecked(Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["LOCKED"])
            HealBot_Options_SetText(HealBot_Options_ActionLocked,HEALBOT_OPTIONS_ACTIONLOCKED)
            HealBot_Options_AutoShow:SetChecked(Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["AUTOCLOSE"])
            HealBot_Options_SetText(HealBot_Options_AutoShow,HEALBOT_OPTIONS_AUTOSHOW)
            HealBot_Options_PanelSounds:SetChecked(Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["OPENSOUND"])
            HealBot_Options_SetText(HealBot_Options_PanelSounds,HEALBOT_OPTIONS_PANELSOUNDS)
            HealBot_Options_TooltipPosTxt:SetText(HEALBOT_OPTIONS_POSTOOLTIP)
            HealBot_Options_SetText(HealBot_Options_FrameAlias,HEALBOT_OPTIONS_FRAME_ALIAS)
            if Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["ALIAS"] and
               string.len(Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["ALIAS"])>0 then
                HealBot_Options_FrameAlias:SetText(Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["ALIAS"])
            else
                HealBot_Options_FrameAlias:SetText(HEALBOT_OPTIONS_FRAME.." "..HealBot_Options_StorePrev["FramesSelFrame"])
            end
            HealBot_Options_BarsGrowDirection.initialize = HealBot_Options_BarsGrowDirection_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BarsGrowDirection, HealBot_Options_BarsGrowDirection_List[Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["GROW"]])
            HealBot_Options_BarsOrientation.initialize = HealBot_Options_BarsOrientation_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BarsOrientation, HealBot_Options_BarsOrientation_List[Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["OFIX"]])
            HealBot_Options_ActionAnchor_SetAlpha(HealBot_Options_StorePrev["FramesSelFrame"])
            DoneInitTab[301]=true
        end
    elseif subNo==302 then
        if not DoneInitTab[302] then
            HealBot_Options_DoVisibility_DropDowns()
            HealBot_Options_HideBars:SetChecked(Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HIDEOOR"])
            HealBot_Options_SetText(HealBot_Options_HideBars,HEALBOT_HIDE_BARS)
            HealBot_Options_Pct_OnLoad(HealBot_Options_AlertLevelIC,HEALBOT_OPTIONS_INCOMBATALERTLEVEL)
            HealBot_Options_AlertLevelIC:SetValue(Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["ALERTIC"])
            HealBot_Options_Pct_OnValueChanged(HealBot_Options_AlertLevelIC)
            HealBot_Options_Pct_OnLoad(HealBot_Options_AlertLevelOC,HEALBOT_OPTIONS_OUTCOMBATALERTLEVEL)
            HealBot_Options_AlertLevelOC:SetValue(Healbot_Config_Skins.BarVisibility[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["ALERTOC"])
            HealBot_Options_Pct_OnValueChanged(HealBot_Options_AlertLevelOC)
            HealBot_Options_SubSortPlayerFirst:SetChecked(Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SUBPF"])
            HealBot_Options_SortOutOfRangeLast:SetChecked(Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["OORLAST"])            HealBot_Options_ExtraSubSort.initialize = HealBot_Options_ExtraSubSort_DropDown
            UIDropDownMenu_SetText(HealBot_Options_ExtraSubSort, HealBot_Options_Sort_List[Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SUBORDER"]])
            HealBot_Options_ExtraSort.initialize = HealBot_Options_ExtraSort_DropDown
            UIDropDownMenu_SetText(HealBot_Options_ExtraSort, HealBot_Options_Sort_List[Healbot_Config_Skins.BarSort[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["RAIDORDER"]])
            g=_G["HealBot_HealButtons_Text"]
            if HealBot_Options_StorePrev["FramesSelFrame"]<8 then
                g:SetText(HEALBOT_OPTIONS_PLAYERVISIBILITY)
            elseif HealBot_Options_StorePrev["FramesSelFrame"]==8 then
                g:SetText(HEALBOT_OPTIONS_TARGETVISIBILITY)
            elseif HealBot_Options_StorePrev["FramesSelFrame"]==9 then
                g:SetText(HEALBOT_OPTIONS_FOCUSVISIBILITY)
            end
            g=_G["HealBot_SortButtons_Text"]
            if HealBot_Options_StorePrev["FramesSelFrame"]<6 then
                g:SetText(HEALBOT_OPTIONS_PLAYERSORT)
            elseif HealBot_Options_StorePrev["FramesSelFrame"]==6 then
                g:SetText(HEALBOT_OPTIONS_VEHICLESORT)
            elseif HealBot_Options_StorePrev["FramesSelFrame"]==7 then
                g:SetText(HEALBOT_OPTIONS_PETSORT)
            elseif HealBot_Options_StorePrev["FramesSelFrame"]==10 then
                g:SetText(HEALBOT_OPTIONS_ENEMYSORT)
            end
            HealBot_Options_val_OnLoad(HealBot_Options_BarBCSpaceS,HEALBOT_OPTIONS_SKINBCSPACE,0,15,1)
            HealBot_Options_BarBCSpaceS:SetValue(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CMARGIN"])
            HealBot_Options_BarBCSpaceSText:SetText(HEALBOT_OPTIONS_SKINBCSPACE..": "..Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CMARGIN"])
            HealBot_Options_val_OnLoad(HealBot_Options_Bar2Size,HEALBOT_OPTIONS_BAR2SIZE,0,15,1)
            HealBot_Options_Bar2Size:SetValue(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["POWERSIZE"])
            HealBot_Options_Bar2SizeText:SetText(HEALBOT_OPTIONS_BAR2SIZE..": "..Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["POWERSIZE"])
            HealBot_Options_val_OnLoad(HealBot_Options_AggroBarSize,HEALBOT_OPTIONS_AGGROBARSIZE,0,15,1)
            HealBot_Options_AggroBarSize:SetValue(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["AGGROSIZE"])
            HealBot_Options_AggroBarSizeText:SetText(HEALBOT_OPTIONS_AGGROBARSIZE..": "..Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["AGGROSIZE"])
            HealBot_Options_BarNumGroupPerCol:SetChecked(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["GRPCOLS"])
            HealBot_Options_SetText(HealBot_Options_BarNumGroupPerCol,HEALBOT_OPTIONS_GROUPSPERCOLUMN)
            HealBot_Options_ShowPowerCounter:SetChecked(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["POWERCNT"])
            HealBot_Options_SetText(HealBot_Options_ShowPowerCounter,HEALBOT_OPTIONS_SHOWPOWERCOUNTER)
            HealBot_Options_BarTextureS:SetValue(texturesIndex[Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]] or 1)
            HealBot_Options_val_OnLoad(HealBot_Options_BarHeightS,HEALBOT_OPTIONS_SKINHEIGHT,10,80,1)
            HealBot_Options_BarHeightS:SetValue(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HEIGHT"])
            HealBot_Options_BarHeightSText:SetText(HEALBOT_OPTIONS_SKINHEIGHT..": "..Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HEIGHT"])
            HealBot_Options_val_OnLoad(HealBot_Options_BarWidthS,HEALBOT_OPTIONS_SKINWIDTH,20,225,1)
            HealBot_Options_BarWidthS:SetValue(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["WIDTH"])
            HealBot_Options_BarWidthSText:SetText(HEALBOT_OPTIONS_SKINWIDTH..": "..Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["WIDTH"])
            HealBot_Options_BarNumColsS:SetValue(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["NUMCOLS"] or 2)
            HealBot_Options_BarNumColsS_OnValueChanged(HealBot_Options_BarNumColsS)
            HealBot_Options_val_OnLoad(HealBot_Options_BarBRSpaceS,HEALBOT_OPTIONS_SKINBRSPACE,0,10,1)
            HealBot_Options_BarBRSpaceS:SetValue(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["RMARGIN"])
            HealBot_Options_BarBRSpaceSText:SetText(HEALBOT_OPTIONS_SKINBRSPACE..": "..Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["RMARGIN"])
            g=_G["HealBot_Options_ScaleFrameText3"]
            g:SetText(HEALBOT_OPTIONS_SKINBARS)
            HealBot_Options_DoManaIndicator_DropDown()
            HealBot_Options_BarIncHealColour.initialize = HealBot_Options_BarIncHealColour_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BarIncHealColour, HealBot_Options_BarIncHealColour_List[Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["IC"]])
            HealBot_Options_BarHealthColour.initialize = HealBot_Options_BarHealthColour_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BarHealthColour, HealBot_Options_BarHealthColour_List[Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HLTH"]])
            HealBot_Options_BarHealthIncHeal.initialize = HealBot_Options_BarHealthIncHeal_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BarHealthIncHeal, HealBot_Options_BarHealthIncHeal_List[Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["INCHEALS"]])
            HealBot_Options_BarHealthBackColour.initialize = HealBot_Options_BarHealthBackColour_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BarHealthBackColour, HealBot_Options_BarHealthColour_List[Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BACK"]])
            HealBot_Options_AbsorbColour.initialize = HealBot_Options_AbsorbColour_DropDown
            UIDropDownMenu_SetText(HealBot_Options_AbsorbColour, HealBot_Options_AbsorbColour_List[Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["AC"]])
            HealBot_Options_FrameAliasList()
            HealBot_Options_ShowEnemyIncSelf:SetChecked(Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCSELF"])
            HealBot_Options_SetText(HealBot_Options_ShowEnemyIncSelf,HEALBOT_ENEMY_INCLUDE_SELF)
            HealBot_Options_ShowEnemyIncTanks:SetChecked(Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCTANKS"])
            HealBot_Options_SetText(HealBot_Options_ShowEnemyIncTanks,HEALBOT_ENEMY_INCLUDE_TANKS)
            HealBot_Options_ShowEnemyIncArena:SetChecked(Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCARENA"])
            HealBot_Options_SetText(HealBot_Options_ShowEnemyIncArena,HEALBOT_ENEMY_INCLUDE_ARENA)
            HealBot_Options_ShowEnemyIncArenaPets:SetChecked(Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCARENAPETS"])
            HealBot_Options_SetText(HealBot_Options_ShowEnemyIncArenaPets,HEALBOT_ENEMY_INCLUDE_ARENAPETS)
            HealBot_Options_ShowEnemyIncMyTargets:SetChecked(Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCMYTAR"])
            HealBot_Options_SetText(HealBot_Options_ShowEnemyIncMyTargets,HEALBOT_ENEMY_INCLUDE_MYTARGETS)
            HealBot_Options_val_OnLoad(HealBot_Options_ShowEnemyNumBoss,HEALBOT_ENEMY_NUMBER_BOSSES,0,4,1)
            HealBot_Options_ShowEnemyNumBoss:SetValue(Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["NUMBOSS"])
            HealBot_Options_ShowEnemyNumBossText:SetText(HEALBOT_ENEMY_NUMBER_BOSSES..": "..Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["NUMBOSS"])
            HealBot_Options_HideEnemyOutOfCombat:SetChecked(Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["HIDE"])
            HealBot_Options_SetText(HealBot_Options_HideEnemyOutOfCombat,HEALBOT_ENEMY_HIDE_OUTOFCOMBAT)
            HealBot_Options_EnemyExistsPlayerTargets:SetChecked(Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["EXISTSHOWPTAR"])
            HealBot_Options_SetText(HealBot_Options_EnemyExistsPlayerTargets,HEALBOT_ENEMY_EXISTS_SHOW_PTARGETS)
            HealBot_Options_EnemyExistsBosses:SetChecked(Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["EXISTSHOWBOSS"])
            HealBot_Options_SetText(HealBot_Options_EnemyExistsBosses,HEALBOT_ENEMY_EXISTS_SHOW_BOSSES)
            HealBot_EnemySkinsFrameTxt:SetText(HEALBOT_OPTIONS_ENEMY_OPT)
            HealBot_Options_EnemyExistsArena:SetChecked(Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["EXISTSHOWARENA"])
            HealBot_Options_SetText(HealBot_Options_EnemyExistsArena,HEALBOT_ENEMY_EXISTS_SHOW_ARENA)
            g=_G["HealBot_Options_EnemyExistsTxt"]
            g:SetText(HEALBOT_ENEMY_EXISTS_SHOW)
            HealBot_Options_Pct_OnLoad(HealBot_Options_BarAlphaDis,HEALBOT_OPTIONS_BARALPHADIS)
            HealBot_Options_BarAlphaDis:SetValue(Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["DISA"])
            HealBot_Options_Pct_OnValueChanged(HealBot_Options_BarAlphaDis)
            HealBot_Options_Pct_OnLoad(HealBot_Options_BarAlphaEor,HEALBOT_OPTIONS_BARALPHAEOR)
            HealBot_Options_BarAlphaEor:SetValue(Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["ORA"])
            HealBot_Options_Pct_OnValueChanged(HealBot_Options_BarAlphaEor)
            HealBot_Options_Pct_OnLoad_MinMax(HealBot_Options_BarAlpha,HEALBOT_OPTIONS_BARALPHA,0.25,1,0.01)
            HealBot_Options_BarAlpha:SetValue(Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HA"] or 95);
            HealBot_Options_Pct_OnValueChanged(HealBot_Options_BarAlpha)
            HealBot_Options_Pct_OnLoad_MinMax(HealBot_Options_BarAlphaInHeal,HEALBOT_OPTIONS_TTALPHA,0,0.90,0.01)
            HealBot_Options_BarAlphaInHeal:SetValue(Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["IA"]);
            HealBot_Options_Pct_OnValueChanged(HealBot_Options_BarAlphaInHeal)
            HealBot_Options_Pct_OnLoad_MinMax(HealBot_Options_BarAlphaAbsorb,HEALBOT_OPTIONS_TTALPHA,0,0.90,0.01)
            HealBot_Options_BarAlphaAbsorb:SetValue(Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["AA"] or 50);
            HealBot_Options_Pct_OnValueChanged(HealBot_Options_BarAlphaAbsorb)
            HealBot_Options_Pct_OnLoad_MinMax(HealBot_Options_BarAlphaBackGround,HEALBOT_OPTIONS_TTALPHA,0,0.75,0.01)
            HealBot_Options_BarAlphaBackGround:SetValue(Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BA"]);
            HealBot_Options_Pct_OnValueChanged(HealBot_Options_BarAlphaBackGround)
            HealBot_Options_val_OnLoad(HealBot_Options_BarOutlineBackGround,HEALBOT_OPTIONS_OUTLINE,0,10,1)
            HealBot_Options_BarOutlineBackGround:SetValue(Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BOUT"]);
            HealBot_Options_BarOutlineBackGroundText:SetText(HEALBOT_OPTIONS_OUTLINE..": "..Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BOUT"])
            g=_G["HealBot_BarHealthColourt"]
            g:SetText(HEALBOT_SKIN_HEALTHBARCOL_TEXT)
            g=_G["HealBot_BarCustomColourt"]
            g:SetText(HEALBOT_CUSTOM_CAT_CUSTOM)
            g=_G["HealBot_Options_BarHealthBackColourt"]
            g:SetText(HEALBOT_SKIN_HEALTHBACKCOL_TEXT)
            g=_G["HealBot_Options_BarHealthBackColourSt"]
            g:SetText(HEALBOT_CUSTOM_CAT_CUSTOM)
            g=_G["HealBot_BarIncHealColourt"]
            g:SetText(HEALBOT_SKIN_INCHEALBARCOL_TEXT)
            g=_G["HealBot_BarIHCustomColourt"]
            g:SetText(HEALBOT_CUSTOM_CAT_CUSTOM)
            g=_G["HealBot_BarAbsorbCustomColourt"]
            g:SetText(HEALBOT_CUSTOM_CAT_CUSTOM)
            g=_G["HealBot_AbsorbColourt"]
            g:SetText(HEALBOT_SKIN_ABSORBCOL_TEXT)
            g=_G["HealBot_Options_BarColorsOptionsText3"]
            g:SetText(HEALBOT_OPTIONS_CDCBARS)
            HealBot_Options_FontName:SetValue(fontsIndex[Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["FONT"]] or 0)
            HealBot_Options_val_OnLoad(HealBot_Options_FontHeight,HEALBOT_OPTIONS_SKINFHEIGHT,7,18,1)
            HealBot_Options_FontHeight:SetValue(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HEIGHT"])
            HealBot_Options_FontHeightText:SetText(HEALBOT_OPTIONS_SKINFHEIGHT..": "..Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HEIGHT"])
            HealBot_Options_val_OnLoad(HealBot_Options_FontOffset,HEALBOT_OPTIONS_TEXTOFFSET,-10,25,1)
            HealBot_Options_FontOffset:SetValue(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["OFFSET"])
            HealBot_Options_FontOffsetText:SetText(HEALBOT_OPTIONS_TEXTOFFSET..": "..Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["OFFSET"])
            HealBot_Options_ShowClassOnBarType_OnClick(nil,Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CLASSTYPE"] or 2)
            HealBot_Options_ShowRoleOnBar:SetChecked(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOWROLE"])
            HealBot_Options_SetText(HealBot_Options_ShowRoleOnBar,HEALBOT_SHOW_ROLE)
            HealBot_Options_ShowClassOnBar:SetChecked(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CLASSONBAR"])
            HealBot_Options_SetText(HealBot_Options_ShowClassOnBar,HEALBOT_OPTIONS_SHOWCLASSONBAR)
            HealBot_Options_ShowNameOnBar:SetChecked(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["NAMEONBAR"])
            HealBot_Options_SetText(HealBot_Options_ShowNameOnBar,HEALBOT_OPTIONS_SHOWNAMEONBAR)
            HealBot_Options_TextlibUTF8:SetChecked(HealBot_Globals.useUTF8)
            HealBot_Options_SetText(HealBot_Options_TextlibUTF8,HEALBOT_OPTIONS_ENABLELIBUTF8)
            HealBot_Options_ShowHealthOnBar:SetChecked(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HLTHONBAR"])
            HealBot_Options_SetText(HealBot_Options_ShowHealthOnBar,HEALBOT_OPTIONS_SHOWHEALTHONBAR)
            HealBot_Options_BarTextInClassColour:SetChecked(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CLASSCOL"])
            HealBot_Options_SetText(HealBot_Options_BarTextInClassColour,HEALBOT_OPTIONS_BARTEXTCLASSCOLOUR1)
            HealBot_Options_val_OnLoad(HealBot_Options_TextAlign,HEALBOT_OPTIONS_TEXTALIGNMENT,1,3,1)
            HealBot_Options_TextAlign:SetValue(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["ALIGN"])
            HealBot_Options_val_OnLoad(HealBot_Options_MaxChars,HEALBOT_OPTIONS_MAXCHARS,0,20,1)
            HealBot_Options_MaxChars:SetValue(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["MAXCHARS"])
            g=_G["HealBot_Options_MaxCharsText"]
            if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["MAXCHARS"]==0 then
                g:SetText(HEALBOT_OPTIONS_MAXCHARS .. ": "..HEALBOT_WORD_AUTO)
            else
                g:SetText(HEALBOT_OPTIONS_MAXCHARS .. ": ".. Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["MAXCHARS"])
            end
            HealBot_Options_TextAlignText:SetText(HEALBOT_OPTIONS_TEXTALIGNMENT..": "..Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["ALIGN"])
            HealBot_Options_NumberTextLines:SetChecked(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["DOUBLE"])
            HealBot_Options_SetText(HealBot_Options_NumberTextLines,HEALBOT_OPTIONS_DOUBLETEXTLINES)
            HealBot_EnTextColorpickt:SetText(HEALBOT_SKIN_ENTEXT);
            HealBot_DisTextColorpickt:SetText(HEALBOT_SKIN_DISTEXT);
            HealBot_DebTextColorpickt:SetText(HEALBOT_SKIN_DEBTEXT);
            HealBot_Options_SetText(HealBot_Options_ShowClassOnBarType1,HEALBOT_SHOW_CLASS_AS_ICON)
            HealBot_Options_SetText(HealBot_Options_ShowClassOnBarType2,HEALBOT_SHOW_CLASS_AS_TEXT)
            g=_G["HealBot_Options_TextSkins_FontStr"]
            g:SetText(HEALBOT_OPTIONS_TEXTOPTIONS)
            g=_G["healbotskinbarsfoutlinefStr"]
            g:SetText(HEALBOT_OPTIONS_SKINFOUTLINE)
            HealBot_Options_SetText(HealBot_Options_DisconnectedTag,HEALBOT_DISCONNECTED_LABEL)
            HealBot_Options_SetText(HealBot_Options_UnitDeadTag,HEALBOT_DEAD_LABEL)
            HealBot_Options_SetText(HealBot_Options_OutOfRangeTag,HEALBOT_OUTOFRANGE_LABEL)
            HealBot_Options_SetText(HealBot_Options_ReserverTag,HEALBOT_RESERVED_LABEL)
            HealBot_Options_DisconnectedTag:SetText(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TAGDC"])
            HealBot_Options_UnitDeadTag:SetText(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TAGRIP"])
            HealBot_Options_OutOfRangeTag:SetText(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TAGOOR"])
            HealBot_Options_ReserverTag:SetText(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TAGR"])
            HealBot_Options_HighlightActiveBarInCombat:SetChecked(Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CBARCOMBAT"])
            HealBot_Options_SetText(HealBot_Options_HighlightActiveBarInCombat,HEALBOT_OPTIONS_MONITORBUFFSC)
            HealBot_Options_HighlightTargetBarInCombat:SetChecked(Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TBARCOMBAT"])
            HealBot_Options_SetText(HealBot_Options_HighlightTargetBarInCombat,HEALBOT_OPTIONS_MONITORBUFFSC)
            HealBot_Options_Pct_OnLoad_MinMax(HealBot_Options_AggroFlashAlphaMax,HEALBOT_WORDS_MAX,0.2,1,0.05,2)
            HealBot_Options_AggroFlashAlphaMax:SetValue(Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["MAXA"])
            HealBot_Options_Pct_OnValueChanged(HealBot_Options_AggroFlashAlphaMax)
            HealBot_Options_Pct_OnLoad_MinMax(HealBot_Options_AggroFlashAlphaMin,HEALBOT_WORDS_MIN,0,0.8,0.05,2)
            HealBot_Options_AggroFlashAlphaMin:SetValue(Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["MINA"])
            HealBot_Options_Pct_OnValueChanged(HealBot_Options_AggroFlashAlphaMin)
            HealBot_Options_sliderlabels_Init(HealBot_Options_AggroFlashFreq,HEALBOT_OPTIONS_AGGROFLASHFREQ,0.5,10,0.5,5,HEALBOT_OPTIONS_WORD_SLOWER,HEALBOT_OPTIONS_WORD_FASTER)
            HealBot_Options_AggroFlashFreq:SetValue(Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["FREQ"]*100)
            HealBot_Options_AggroFlashFreqText:SetText(HEALBOT_OPTIONS_AGGROFLASHFREQ) --..": "..Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["FREQ"])
            g=_G["HealBot_AggroBars_FontStr"]
            g:SetText(HEALBOT_OPTIONS_TAB_AGGRO)
            g=_G["HealBot_SkinsAggroAlphaText"]
            g:SetText(HEALBOT_OPTIONS_AGGROFLASHALPHA)
            g=_G["healbotaggropcttrackfontstr"]
            g:SetText(HEALBOT_OPTION_AGGROPCTTRACK)
            g=_G["healbotaggroindalertfontstr"]
            g:SetText(HEALBOT_OPTIONS_AGGROINDALERT)
            g=_G["healbotaggroalertfontstr"]
            g:SetText(HEALBOT_OPTIONS_AGGROALERT)
            g=_G["healbotaggro3colfontstr"]
            g:SetText(HEALBOT_OPTIONS_AGGRO3COL)
            HealBot_Options_AggroTrack:SetChecked(Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOW"])
            HealBot_Options_SetText(HealBot_Options_AggroTrack,HEALBOT_OPTION_AGGROTRACK)
            HealBot_Options_AggroBar:SetChecked(Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOWBARS"])
            HealBot_Options_SetText(HealBot_Options_AggroBar,HEALBOT_OPTION_AGGROBAR)
            HealBot_Options_AggroTxt:SetChecked(Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOWTEXT"])
            HealBot_Options_SetText(HealBot_Options_AggroTxt,HEALBOT_OPTION_AGGROTXT)
            HealBot_Options_AggroInd:SetChecked(Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOWIND"])
            HealBot_Options_SetText(HealBot_Options_AggroInd,HEALBOT_OPTION_AGGROIND)
            HealBot_Options_AggroBarPct:SetChecked(Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOWBARSPCT"])
            HealBot_Options_SetText(HealBot_Options_AggroBarPct,HEALBOT_OPTION_AGGROPCTBAR)
            HealBot_Options_AggroTxtPct:SetChecked(Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOWTEXTPCT"])
            HealBot_Options_SetText(HealBot_Options_AggroTxtPct,HEALBOT_OPTION_AGGROPCTTXT)
            HealBot_Options_HighlightActiveBar:SetChecked(Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CBAR"])
            HealBot_Options_SetText(HealBot_Options_HighlightActiveBar,HEALBOT_OPTION_HIGHLIGHTACTIVEBAR)
            HealBot_Options_HighlightTargetBar:SetChecked(Healbot_Config_Skins.BarHighlight[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TBAR"])
            HealBot_Options_SetText(HealBot_Options_HighlightTargetBar,HEALBOT_OPTION_HIGHLIGHTTARGETBAR)            
            HealBot_Options_AggroIndAlertLevel.initialize = HealBot_Options_AggroIndAlertLevel_DropDown
            UIDropDownMenu_SetText(HealBot_Options_AggroIndAlertLevel, HealBot_Options_AggroIndAlertLevel_List[Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["ALERTIND"]])
            HealBot_Options_AggroAlertLevel.initialize = HealBot_Options_AggroAlertLevel_DropDown
            UIDropDownMenu_SetText(HealBot_Options_AggroAlertLevel, HealBot_Options_AggroAlertLevel_List[Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["ALERT"]])
            local i=Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTFORMAT"]
            if i>1 then i=(i*2)-1 end
            HealBot_Options_BarHealthNumFormatAggro.initialize = HealBot_Options_BarHealthNumFormatAggro_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BarHealthNumFormatAggro, HealBot_Options_BarHealthNumFormat2_List[i].."77%"..HealBot_Options_BarHealthNumFormat2_List[i+1])
            HealBot_Options_TargetOnlyFriend:SetChecked(Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TONLYFRIEND"])
            HealBot_Options_SetText(HealBot_Options_TargetOnlyFriend,HEALBOT_OPTIONS_SHOW_ONLY_FRIEND)
            HealBot_Options_TargetExcludeRaid:SetChecked(Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TEXRAID"])
            HealBot_Options_SetText(HealBot_Options_TargetExcludeRaid,HEALBOT_OPTIONS_EXCLUDE_RAID)
            HealBot_Options_FocusOnlyFriend:SetChecked(Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["FONLYFRIEND"])
            HealBot_Options_SetText(HealBot_Options_FocusOnlyFriend,HEALBOT_OPTIONS_SHOW_ONLY_FRIEND)
            HealBot_Options_FocusExcludeRaid:SetChecked(Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["FEXRAID"])
            HealBot_Options_SetText(HealBot_Options_FocusExcludeRaid,HEALBOT_OPTIONS_EXCLUDE_RAID)
            HealBot_Options_GroupPetsByFive:SetChecked(Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["GROUPPETS"])
            HealBot_Options_SetText(HealBot_Options_GroupPetsByFive,HEALBOT_OPTIONS_GROUP_PETS_BY_FIVE)
            HealBot_Options_SelfPet:SetChecked(Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["SELFPET"])
            HealBot_Options_SetText(HealBot_Options_SelfPet,HEALBOT_OPTIONS_OWN_PET_WITH_SELF)
            HealBot_Options_SetText(HealBot_Options_SortOutOfRangeLast,HEALBOT_OPTIONS_SORTOORLAST)
            HealBot_Options_SetText(HealBot_Options_SubSortPlayerFirst,HEALBOT_OPTIONS_SUBSORTSELFFIRST)
            g=_G["HealBot_TargetOutOfCombat_Text"]
            g:SetText(HEALBOT_OPTIONS_OUTOFCOMBAT)
            g=_G["HealBot_FocusOutOfCombat_Text"]
            g:SetText(HEALBOT_OPTIONS_OUTOFCOMBAT)
            g=_G["healbotraidfilterfontstr"]
            g:SetText(HEALBOT_OPTIONS_EMERGFILTER)
            g=_G["healbotraidfiltergrpsfontstr"]
            g:SetText(HEALBOT_OPTIONS_EMERGFILTERGROUPS)
            g=_G["healbotmainsortfontstr"]
            g:SetText(HEALBOT_OPTIONS_MAINSORT)
            g=_G["healbotsubsortfontstr"]
            g:SetText(HEALBOT_OPTIONS_SUBSORT)
            g=_G["healbotraidfilterplayeypetstr"]
            g:SetText(HEALBOT_OPTIONS_PLAYERPET)
            g:SetTextColor(1,1,1,1)
            g=_G["healbotfocusincombatfontstr"]
            g:SetText(HEALBOT_FOCUS)
            g:SetTextColor(1,1,1,1)
            g=_G["healbottargetincombatfontstr"]
            g:SetText(HEALBOT_DISABLED_TARGET)
            g:SetTextColor(1,1,1,1)
            if HEALBOT_GAME_VERSION<4 then 
                HealBot_Options_FocusInCombat:Hide()
                HealBot_Options_FocusOnlyFriend:Hide()
                HealBot_FocusOutOfCombat_Text:Hide()
                HealBot_Options_FocusExcludeRaid:Hide()
                HealBot_Options_TargetInCombat:ClearAllPoints()
                HealBot_Options_TargetInCombat:SetPoint("BOTTOM",0,85)
            end
            DoneInitTab[302]=true
        end
    elseif subNo==303 then
        if not DoneInitTab[303] then
            local tmpBarHealthNumFormat1_List=HealBot_Options_BarHealthNumFormat_genList()
            HealBot_Options_BarHealthNumFormat1.initialize = HealBot_Options_BarHealthNumFormat1_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BarHealthNumFormat1, tmpBarHealthNumFormat1_List[Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["NUMFORMAT1"]])
            local i=Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["NUMFORMAT2"]
            if i>1 then i=(i*2)-1 end
            HealBot_Options_BarHealthNumFormat2.initialize = HealBot_Options_BarHealthNumFormat2_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BarHealthNumFormat2, HealBot_Options_BarHealthNumFormat2_List[i]..HealBot_Options_StorePrev["hbBarHealthNumFormatTxt"]..HealBot_Options_BarHealthNumFormat2_List[i+1])
            HealBot_Options_FontOutline.initialize = HealBot_Options_FontOutline_DropDown
            UIDropDownMenu_SetText(HealBot_Options_FontOutline, HealBot_Options_FontOutline_List[Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["OUTLINE"]])
            if (Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HLTHTYPE"] or 0)<1 then Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HLTHTYPE"]=1 end
            HealBot_Options_BarHealthType.initialize = HealBot_Options_BarHealthType_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BarHealthType, HealBot_Options_BarHealthType_List[Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HLTHTYPE"]])
            HealBot_Options_PartyFrames:SetChecked(Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["HIDEPARTYF"])
            HealBot_Options_SetText(HealBot_Options_PartyFrames,HEALBOT_OPTIONS_HIDEPARTYFRAMES)
            HealBot_Options_UseStickyFrames:SetChecked(Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["STICKYFRAME"])
            HealBot_Options_SetText(HealBot_Options_UseStickyFrames,HEALBOT_OPTIONS_STICKYFRAMES)
            HealBot_Options_PlayerTargetFrames:SetChecked(Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["HIDEPTF"])
            HealBot_Options_SetText(HealBot_Options_PlayerTargetFrames,HEALBOT_OPTIONS_HIDEPLAYERTARGET)
            HealBot_Options_MiniBossFrames:SetChecked(Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["HIDEBOSSF"])
            HealBot_Options_SetText(HealBot_Options_MiniBossFrames,HEALBOT_OPTIONS_HIDEMINIBOSSFRAMES)
            HealBot_Options_RaidFrames:SetChecked(Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["HIDERAIDF"])
            HealBot_Options_SetText(HealBot_Options_RaidFrames,HEALBOT_OPTIONS_HIDERAIDFRAMES)
            HealBot_Options_SkinDefaultSolo:SetChecked(HealBot_Config.SkinDefault[Healbot_Config_Skins.Current_Skin][HEALBOT_WORD_SOLO] or false)
            HealBot_Options_SetText(HealBot_Options_SkinDefaultSolo,HEALBOT_WORD_SOLO)
            HealBot_Options_SkinDefaultParty:SetChecked(HealBot_Config.SkinDefault[Healbot_Config_Skins.Current_Skin][HEALBOT_WORD_PARTY])
            HealBot_Options_SetText(HealBot_Options_SkinDefaultParty,HEALBOT_WORD_PARTY)
            HealBot_Options_SkinDefaultRaid10:SetChecked(HealBot_Config.SkinDefault[Healbot_Config_Skins.Current_Skin][HEALBOT_OPTIONS_RAID10])
            HealBot_Options_SetText(HealBot_Options_SkinDefaultRaid10,HEALBOT_OPTIONS_RAID10)
            HealBot_Options_SkinDefaultRaid25:SetChecked(HealBot_Config.SkinDefault[Healbot_Config_Skins.Current_Skin][HEALBOT_OPTIONS_RAID25])
            HealBot_Options_SetText(HealBot_Options_SkinDefaultRaid25,HEALBOT_OPTIONS_RAID25)
            HealBot_Options_SkinDefaultRaid40:SetChecked(HealBot_Config.SkinDefault[Healbot_Config_Skins.Current_Skin][HEALBOT_OPTIONS_RAID40])
            HealBot_Options_SetText(HealBot_Options_SkinDefaultRaid40,HEALBOT_OPTIONS_RAID40)
            HealBot_Options_SkinDefaultArena:SetChecked(HealBot_Config.SkinDefault[Healbot_Config_Skins.Current_Skin][HEALBOT_WORD_ARENA])
            HealBot_Options_SetText(HealBot_Options_SkinDefaultArena,HEALBOT_WORD_ARENA)
            HealBot_Options_SkinDefaultBG10:SetChecked(HealBot_Config.SkinDefault[Healbot_Config_Skins.Current_Skin][HEALBOT_WORD_BG10])
            HealBot_Options_SetText(HealBot_Options_SkinDefaultBG10,HEALBOT_WORD_BG10)
            HealBot_Options_SkinDefaultBG15:SetChecked(HealBot_Config.SkinDefault[Healbot_Config_Skins.Current_Skin][HEALBOT_WORD_BG15])
            HealBot_Options_SetText(HealBot_Options_SkinDefaultBG15,HEALBOT_WORD_BG15)
            HealBot_Options_SkinDefaultBG40:SetChecked(HealBot_Config.SkinDefault[Healbot_Config_Skins.Current_Skin][HEALBOT_WORD_BG40])
            HealBot_Options_SetText(HealBot_Options_SkinDefaultBG40,HEALBOT_WORD_BG40)
            HealBot_Options_SkinDefaultPet:SetChecked(HealBot_Config.SkinDefault[Healbot_Config_Skins.Current_Skin][HEALBOT_WORD_PETBATTLE])
            HealBot_Options_SetText(HealBot_Options_SkinDefaultPet,HEALBOT_WORD_PETBATTLE)
            HealBot_Options_ManaIndicatorInCombat:SetChecked(Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["LOWMANACOMBAT"])
            HealBot_Options_SetText(HealBot_Options_ManaIndicatorInCombat,HEALBOT_OPTIONS_MONITORBUFFSC)
            HealBot_Options_UseFluidBars:SetChecked(Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["FLUIDBARS"])
            HealBot_Options_SetText(HealBot_Options_UseFluidBars,HEALBOT_OPTION_USEFLUIDBARS)
            HealBot_Options_sliderlabels_Init(HealBot_Options_StickyFramesSensitivity,HEALBOT_OPTIONS_STICKYSENSITIVITY,15,75,1,5,HEALBOT_WORK_HIGH,HEALBOT_WORD_LOW)
            HealBot_Options_StickyFramesSensitivity:SetValue(Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["STICKYSENSITIVITY"])
            HealBot_Options_StickyFramesSensitivityText:SetText(HEALBOT_OPTIONS_STICKYSENSITIVITY)
            HealBot_Options_sliderlabels_Init(HealBot_Options_BarUpdateFreq,HEALBOT_OPTION_BARUPDFREQ,10,100,10,2,HEALBOT_OPTIONS_WORD_SLOWER,HEALBOT_OPTIONS_WORD_FASTER)
            HealBot_Options_BarUpdateFreq:SetValue((Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["FLUIDFREQ"] or 2)*10)
            HealBot_Options_BarUpdateFreqText:SetText(HEALBOT_OPTION_BARUPDFREQ)
            g=_G["HealBot_GeneralSkin_FontStr"]
            g:SetText(HEALBOT_OPTIONS_TAB_GENERAL)
            g=_G["healbotlowmanaindfontstr"]
            g:SetText(HEALBOT_OPTIONS_LOWMANAINDICATOR)
            g=_G["healbotbacktextfontstr"]
            g:SetText(HEALBOT_SKIN_BACKTEXT)
            g=_G["healbotbordertextfontstr"]
            g:SetText(HEALBOT_SKIN_BORDERTEXT)
            DoneInitTab[303]=true
        end
    elseif subNo==304 then -- Always run
        HealBot_Options_InOutSkin.initialize = HealBot_Options_InOutSkin_DropDown
        UIDropDownMenu_SetText(HealBot_Options_InOutSkin, Healbot_Config_Skins.Skins[HealBot_Options_StorePrev["InOutSkin"]])
    elseif subNo==305 then
        if not DoneInitTab[305] then
            HealBot_Options_Skins.initialize = HealBot_Options_Skins_DropDown
            UIDropDownMenu_SetText(HealBot_Options_Skins, Healbot_Config_Skins.Skins[Healbot_Config_Skins.Skin_ID])
            DoneInitTab[305]=true
        end
    elseif subNo==306 then
        if not DoneInitTab[306] then
            HealBot_Options_CastNotify_OnClick(nil,Healbot_Config_Skins.Chat[Healbot_Config_Skins.Current_Skin]["NOTIFY"])
            HealBot_Options_NotifyOtherMsg:SetText(Healbot_Config_Skins.Chat[Healbot_Config_Skins.Current_Skin]["MSG"])   
            HealBot_Options_CastNotifyResOnly:SetChecked(Healbot_Config_Skins.Chat[Healbot_Config_Skins.Current_Skin]["RESONLY"])
            HealBot_Options_SetText(HealBot_Options_CastNotifyResOnly,HEALBOT_OPTIONS_CASTNOTIFYRESONLY)
            HealBot_Options_SetText(HealBot_Options_CastNotify1,HEALBOT_OPTIONS_CASTNOTIFY1)
            HealBot_Options_SetText(HealBot_Options_CastNotify2,HEALBOT_OPTIONS_CASTNOTIFY2)
            HealBot_Options_SetText(HealBot_Options_CastNotify3,HEALBOT_OPTIONS_CASTNOTIFY3)
            HealBot_Options_SetText(HealBot_Options_CastNotify4,HEALBOT_OPTIONS_CASTNOTIFY4)
            HealBot_Options_SetText(HealBot_Options_CastNotify5,HEALBOT_OPTIONS_CASTNOTIFY5)
            HealBot_Options_SetText(HealBot_Options_CastNotify6,HEALBOT_OPTIONS_CASTNOTIFY6)
            HealBot_Options_NotifyOtherMsgTxt:SetText(HEALBOT_OPTIONS_NOTIFY_MSG.."  ("..HEALBOT_OPTIONS_CASTNOTIFYTAGS..")")
            HealBot_HealButtons_ChatFrameTxt:SetText(HEALBOT_OPTIONS_HEAL_CHATOPT)
            HealBot_Options_AfterCombatOOM:SetChecked(Healbot_Config_Skins.Chat[Healbot_Config_Skins.Current_Skin]["EOCOOM"])
            HealBot_Options_SetText(HealBot_Options_AfterCombatOOM,HEALBOT_OPTIONS_EOC_OOM)
            HealBot_Options_val_OnLoad(HealBot_Options_AfterCombatOOMValue,HEALBOT_OPTIONS_EOC_OOM_VALUE,1,50,1,5)
            HealBot_Options_AfterCombatOOMValue:SetValue(Healbot_Config_Skins.Chat[Healbot_Config_Skins.Current_Skin]["EOCOOMV"] or 20)
            HealBot_Options_AfterCombatOOMValueText:SetText(HEALBOT_OPTIONS_EOC_OOM_VALUE..": "..Healbot_Config_Skins.Chat[Healbot_Config_Skins.Current_Skin]["EOCOOMV"].."%")
            DoneInitTab[306]=true
        end
    elseif subNo==307 then
        if not DoneInitTab[307] then
            HealBot_Options_CrashProt:SetChecked(Healbot_Config_Skins.Protection[Healbot_Config_Skins.Current_Skin]["CRASH"])
            HealBot_Options_SetText(HealBot_Options_CrashProt,HEALBOT_OPTIONS_CRASHPROT)
            HealBot_Options_UseGeneralMacros:SetChecked(Healbot_Config_Skins.Protection[Healbot_Config_Skins.Current_Skin]["GENERALMACRO"])
            HealBot_Options_SetText(HealBot_Options_UseGeneralMacros,HEALBOT_OPTIONS_USEGENERALMACRO)
            HealBot_Options_CombatProt:SetChecked(Healbot_Config_Skins.Protection[Healbot_Config_Skins.Current_Skin]["COMBAT"])
            HealBot_Options_SetText(HealBot_Options_CombatProt,HEALBOT_OPTIONS_COMBATPROT)
            HealBot_Options_CombatPartyProt:SetChecked(Healbot_Config_Skins.Protection[Healbot_Config_Skins.Current_Skin]["COMBATPARTY"])
            HealBot_Options_SetText(HealBot_Options_CombatPartyProt,HEALBOT_OPTIONS_GROUPHEALS)
            HealBot_Options_CombatRaidProt:SetChecked(Healbot_Config_Skins.Protection[Healbot_Config_Skins.Current_Skin]["COMBATRAID"])
            HealBot_Options_SetText(HealBot_Options_CombatRaidProt,HEALBOT_OPTIONS_EMERGENCYHEALS)
            HealBot_Options_CrashProtEditBox:SetText(HealBot_Config.CrashProtMacroName)
            HealBot_Options_val_OnLoad(HealBot_Options_CrashProtStartTime,HEALBOT_CP_STARTTIME,1,3,1)
            HealBot_Options_CrashProtStartTime:SetValue(HealBot_Config.CrashProtStartTime)
            HealBot_Options_CrashProtStartTimeText:SetText(HEALBOT_CP_STARTTIME..": "..HealBot_Config.CrashProtStartTime.."sec")
            local cpMacroSaveStr = HealBot_Options_StorePrev["cpMacroSave"] or HEALBOT_CP_MACRO_SAVE
            g=_G["HealBot_Options_cpMacroSave"]
            g:SetText(cpMacroSaveStr)
            g=_G["HealBot_Options_cpMacroName"]
            g:SetText(HEALBOT_CP_MACRO_BASE)
            g=_G["HealBot_ProtSkin_FontStr"]
            g:SetText(HEALBOT_OPTIONS_TAB_PROTECTION)
            DoneInitTab[307]=true
        end
    elseif subNo==308 then
        if not DoneInitTab[308] then
            HealBot_Options_UpdateMedia(3)
            HealBot_HoTonBar_OnClick(nil,Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["ONBAR"] or 1)
            HealBot_HoTposBar_OnClick(nil,Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["POSITION"] or 1)
            HealBot_BarButtonShowHoTx2Bar:SetChecked(Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["DOUBLE"])
            HealBot_Options_SetText(HealBot_BarButtonShowHoTx2Bar,HEALBOT_OPTIONS_DOUBLEROW)
            HealBot_Options_ShowDebuffIcon:SetChecked(Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOWDEBUFF"])
            HealBot_Options_SetText(HealBot_Options_ShowDebuffIcon,HEALBOT_OPTIONS_SHOWDEBUFFICON)
            HealBot_Options_ShowReadyCheck:SetChecked(Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOWRC"])
            HealBot_Options_SetText(HealBot_Options_ShowReadyCheck,HEALBOT_OPTIONS_SHOWREADYCHECK)
            HealBot_Options_ShowDirection:SetChecked(Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOWDIR"])
            HealBot_Options_SetText(HealBot_Options_ShowDirection,HEALBOT_OPTIONS_SHOWDIRECTION)
            HealBot_Options_ShowDirectionMouseOver:SetChecked(Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOWDIRMOUSE"])
            HealBot_Options_SetText(HealBot_Options_ShowDirectionMouseOver,HEALBOT_OPTIONS_SHOWDIRECTIONMOUSE)
            HealBot_Options_val_OnLoad(HealBot_BarButtonMaxDeuffIcons,HEALBOT_OPTIONS_MAXICONS,1,5,1)
            HealBot_BarButtonMaxDeuffIcons:SetValue(Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["MAXDICONS"] or 3)
            HealBot_BarButtonMaxDeuffIconsText:SetText(HEALBOT_OPTIONS_MAXICONS..": "..Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["MAXDICONS"])
            HealBot_Options_val_OnLoad(HealBot_BarButtonMaxBuffIcons,HEALBOT_OPTIONS_MAXICONS,1,10,1)
            HealBot_BarButtonMaxBuffIcons:SetValue(Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["MAXBICONS"] or 8)
            HealBot_BarButtonMaxBuffIconsText:SetText(HEALBOT_OPTIONS_MAXICONS..": "..Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["MAXBICONS"])
            HealBot_Options_val2_OnLoad(HealBot_BarButtonIconScale,HEALBOT_OPTIONS_ICONSCALE,2.5,10,0.5,10)
            HealBot_BarButtonIconScale:SetValue((Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SCALE"] or 7.5)*10)
            HealBot_BarButtonIconScaleText:SetText(HEALBOT_OPTIONS_ICONSCALE..": "..Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SCALE"])
            HealBot_Options_val_OnLoad(HealBot_BarButtonIconFadeStartTime,HEALBOT_OPTIONS_FADESTARTTIME,5,30,1,3)
            HealBot_BarButtonIconFadeStartTime:SetValue(Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["FADESECS"])
            HealBot_setLuVars("FadeTimeDiv", (Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["FADESECS"]*1.125))
            HealBot_BarButtonIconFadeStartTimeText:SetText(HEALBOT_OPTIONS_FADESTARTTIME..": "..Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["FADESECS"].." "..HEALBOT_WORDS_SEC)
            HealBot_Options_val2_OnLoad(HealBot_BarButtonDebuffIconScale,HEALBOT_OPTIONS_DEBUFFICONSCALE,2.5,10,0.5,10)
            HealBot_BarButtonDebuffIconScale:SetValue((Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["DSCALE"] or 7.5)*10)
            HealBot_BarButtonDebuffIconScaleText:SetText(HEALBOT_OPTIONS_DEBUFFICONSCALE..": "..Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["DSCALE"])
            HealBot_BarButtonIconAlwaysEnabled:SetChecked(Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["I15EN"])
            HealBot_Options_SetText(HealBot_BarButtonIconAlwaysEnabled,HEALBOT_OPTIONS_TTALPHA..": "..HEALBOT_OPTIONS_ENABLEHEALTHY)
            HealBot_BarButtonIconFadeOnExpire:SetChecked(Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["FADE"])
            HealBot_Options_SetText(HealBot_BarButtonIconFadeOnExpire,HEALBOT_OPTIONS_TTALPHA..": "..HEALBOT_OPTIONS_FADEONEXPIRE)
            HealBot_Options_SetText(HealBot_BarButtonShowHoTonBar1,HEALBOT_OPTIONS_HOTONBAR)
            HealBot_Options_SetText(HealBot_BarButtonShowHoTonBar2,HEALBOT_OPTIONS_HOTOFFBAR)
            HealBot_Options_SetText(HealBot_BarButtonShowHoTonBar3,HEALBOT_OPTIONS_HOTBELOWBAR)
            HealBot_Options_SetText(HealBot_BarButtonShowHoTposBar1,HEALBOT_OPTIONS_HOTBARLEFT)
            HealBot_Options_SetText(HealBot_BarButtonShowHoTposBar2,HEALBOT_OPTIONS_HOTBARRIGHT)
            HealBot_Options_Class_HoTctlNameTxt:SetText(HEALBOT_OPTIONS_ALLSPELLS);
            HealBot_Options_Class_HoTctlActionTxt:SetText(HEALBOT_OPTIONS_CUSTOM_CASTBY);
            g=_G["HealBot_Options_Skins_HoTs2Txt"]
            g:SetText(HEALBOT_OPTIONS_ICONOPTTEXT)
            g=_G["HealBot_Options_Skins_HoTs2Text3"]
            g:SetText(HEALBOT_OPTIONS_HOTPOSITION)
            g=_G["HealBot_Options_Class_HoTctlFilterNameTxt"]
            g:SetText(HEALBOT_CUSTOM_CATEGORY)
            HealBot_BarButtonShowHoTTextCount:SetChecked(Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SCNT"])
            HealBot_BarButtonShowHoTTextCountSelfCast:SetChecked(Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SSCNT"])
            HealBot_BarButtonShowHoTTextDuration:SetChecked(Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SDUR"])
            HealBot_BarButtonShowHoTTextDurationSelfCast:SetChecked(Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SSDUR"])
            HealBot_Options_val_OnLoad(HealBot_BarButtonIconTextScale,HEALBOT_OPTIONS_SKINFHEIGHT,4,32,1)
            HealBot_BarButtonIconTextScale:SetValue(Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HEIGHT"])
            HealBot_Options_IconFontOutline.initialize = HealBot_Options_IconFontOutline_DropDown
            UIDropDownMenu_SetText(HealBot_Options_IconFontOutline, HealBot_Options_FontOutline_List[Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["OUTLINE"]])
            HealBot_BarButtonIconTextScaleText:SetText(HEALBOT_OPTIONS_SKINFHEIGHT..": "..Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HEIGHT"])
            HealBot_Options_val_OnLoad(HealBot_BarButtonIconTextDurationTime,HEALBOT_OPTIONS_SHOWDURATIONFROM,9,99,1)
            HealBot_BarButtonIconTextDurationTime:SetValue(Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["DURTHRH"])
            HealBot_BarButtonIconTextDurationTimeText:SetText(HEALBOT_OPTIONS_SHOWDURATIONFROM..": "..Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["DURTHRH"])
            HealBot_Options_val_OnLoad(HealBot_BarButtonIconTextDurationWarn,HEALBOT_OPTIONS_SHOWDURATIONWARN,1,9,1)
            HealBot_BarButtonIconTextDurationWarn:SetValue(Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["DURWARN"])
            HealBot_BarButtonIconTextDurationWarnText:SetText(HEALBOT_OPTIONS_SHOWDURATIONWARN..": "..Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["DURWARN"])
            g=_G["HealBot_IconText_FontStr"]
            g:SetText(HEALBOT_OPTIONS_TAB_ICONTEXT)
            g=_G["HealBot_Options_Skins_HoTs2Text2"]
            g:SetText(HEALBOT_OPTIONS_HOTSHOWTEXT)
            HealBot_Options_SetText(HealBot_BarButtonShowHoTTextCount,HEALBOT_OPTIONS_HOTTEXTCOUNT)
            HealBot_Options_SetText(HealBot_BarButtonShowHoTTextCountSelfCast,HEALBOT_OPTIONS_SELFCASTS)
            HealBot_Options_SetText(HealBot_BarButtonShowHoTTextDuration,HEALBOT_OPTIONS_HOTTEXTDURATION)
            HealBot_Options_SetText(HealBot_BarButtonShowHoTTextDurationSelfCast,HEALBOT_OPTIONS_SELFCASTS)
            HealBot_Options_BarButtonShowHoT:SetChecked(Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOWBUFF"])
            HealBot_Options_SetText(HealBot_Options_BarButtonShowHoT,HEALBOT_OPTIONS_BARBUTTONSHOWHOT)
            HealBot_Options_BarButtonShowRaidIcon:SetChecked(Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOW"])
            HealBot_Options_SetText(HealBot_Options_BarButtonShowRaidIcon,HEALBOT_OPTIONS_BARBUTTONSHOWRAIDICON)
            HealBot_Options_BarButtonShowRaidIconStar:SetChecked(Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["STAR"])
            HealBot_Options_SetText(HealBot_Options_BarButtonShowRaidIconStar,HEALBOT_WORD_STAR)
            HealBot_Options_BarButtonShowRaidIconCircle:SetChecked(Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CIRCLE"])
            HealBot_Options_SetText(HealBot_Options_BarButtonShowRaidIconCircle,HEALBOT_WORD_CIRCLE)
            HealBot_Options_BarButtonShowRaidIconDiamond:SetChecked(Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["DIAMOND"])
            HealBot_Options_SetText(HealBot_Options_BarButtonShowRaidIconDiamond,HEALBOT_WORD_DIAMOND)
            HealBot_Options_BarButtonShowRaidIconTriangle:SetChecked(Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TRIANGLE"])
            HealBot_Options_SetText(HealBot_Options_BarButtonShowRaidIconTriangle,HEALBOT_WORD_TRIANGLE)
            HealBot_Options_BarButtonShowRaidIconMoon:SetChecked(Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["MOON"])
            HealBot_Options_SetText(HealBot_Options_BarButtonShowRaidIconMoon,HEALBOT_WORD_MOON)
            HealBot_Options_BarButtonShowRaidIconSquare:SetChecked(Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SQUARE"])
            HealBot_Options_SetText(HealBot_Options_BarButtonShowRaidIconSquare,HEALBOT_WORD_SQUARE)
            HealBot_Options_BarButtonShowRaidIconCross:SetChecked(Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CROSS"])
            HealBot_Options_SetText(HealBot_Options_BarButtonShowRaidIconCross,HEALBOT_WORD_CROSS)
            HealBot_Options_BarButtonShowRaidIconSkull:SetChecked(Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SKULL"])
            HealBot_Options_SetText(HealBot_Options_BarButtonShowRaidIconSkull,HEALBOT_WORD_SKULL)
            DoneInitTab[308]=true
        end
    elseif subNo==309 then
        if not DoneInitTab[309] then
            HealBot_Options_UpdateMedia(3)
           -- HealBot_Options_val_OnLoad(HealBot_Options_HeadTextureS,HEALBOT_OPTIONS_SKINTEXTURE,1,100,1)
            HealBot_Options_HeadTextureS:SetValue(texturesIndex[Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]] or 0)
            HealBot_Options_Pct_OnLoad_MinMax(HealBot_Options_HeadWidthS,HEALBOT_OPTIONS_SKINWIDTH,0.25,1,0.01)
            HealBot_Options_HeadWidthS:SetValue(Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["WIDTH"])
            HealBot_Options_Pct_OnValueChanged(HealBot_Options_HeadWidthS)
            HealBot_Options_val_OnLoad(HealBot_Options_HeadHightS,HEALBOT_OPTIONS_SKINHEIGHT,5,80,1)
            HealBot_Options_HeadHightS:SetValue(Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HEIGHT"])
            HealBot_Options_HeadHightSText:SetText(HEALBOT_OPTIONS_SKINHEIGHT..": "..Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HEIGHT"])
            HealBot_Options_val_OnLoad(HealBot_Options_SkinFrameAliasHeightS,HEALBOT_OPTIONS_SKINHEIGHT,5,80,1)
            HealBot_Options_SkinFrameAliasHeightS:SetValue(Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HEIGHT"])
            HealBot_Options_SkinFrameAliasHeightSText:SetText(HEALBOT_OPTIONS_SKINHEIGHT..": "..Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HEIGHT"])
            HealBot_Options_Pct_OnLoad_MinMax(HealBot_Options_SkinFrameAliasWidthS,HEALBOT_OPTIONS_SKINWIDTH,0.25,1,0.01)
            HealBot_Options_SkinFrameAliasWidthS:SetValue(Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["WIDTH"])
            HealBot_Options_Pct_OnValueChanged(HealBot_Options_SkinFrameAliasWidthS)
            HealBot_Options_SetText(HealBot_Options_FrameTitle,HEALBOT_OPTIONS_FRAME_TITLE)
            HealBot_Options_FrameTitle:SetText(Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["NAME"])
           -- HealBot_Options_val_OnLoad(HealBot_Options_HeadFontNameS,HEALBOT_OPTIONS_SKINFONT,1,100,1) 
            HealBot_Options_HeadFontNameS:SetValue(fontsIndex[Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["FONT"]] or 0)
            HealBot_Options_val_OnLoad(HealBot_Options_HeadFontHeightS,HEALBOT_OPTIONS_SKINFHEIGHT,7,18,1)
            HealBot_Options_HeadFontHeightS:SetValue(Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HEIGHT"])
            HealBot_Options_HeadFontHeightSText:SetText(HEALBOT_OPTIONS_SKINFHEIGHT..": "..Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HEIGHT"])
            HealBot_Options_val_OnLoad(HealBot_Options_HeadFontOffset,HEALBOT_OPTIONS_FONT_OFFSET,-10,25,1)
            HealBot_Options_HeadFontOffset:SetValue(Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["OFFSET"])
            HealBot_Options_HeadFontOffsetText:SetText(HEALBOT_OPTIONS_FONT_OFFSET..": "..Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["OFFSET"])
            HealBot_Options_ShowHeaders:SetChecked(Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOW"])
            HealBot_Options_SetText(HealBot_Options_ShowHeaders,HEALBOT_OPTIONS_SHOWHEADERS)
            g=_G["HealBot_HeadBarColorpickt"]
            g:SetText(HEALBOT_SKIN_HEADERBARCOL)
            g=_G["HealBot_HeadTextColorpickt"]
            g:SetText(HEALBOT_SKIN_HEADERTEXTCOL)
            g=_G["HealBot_FrameAliasColorpickt"]
            g:SetText(HEALBOT_SKIN_HEADERBARCOL)
            g=_G["HealBot_FrameAliasTextColorpickt"]
            g:SetText(HEALBOT_SKIN_HEADERTEXTCOL)
            g=_G["healbotskinfontoutlinefontstr"]
            g:SetText(HEALBOT_OPTIONS_SKINFOUTLINE)
            g=_G["HealBot_Options_Skins_fhbTxt"]
            g:SetText(HEALBOT_OPTIONS_BARHEADEROPTTEXT)
            g=_G["HealBot_Options_Skins_fhfTxt"]
            g:SetText(HEALBOT_OPTIONS_FRAMEHEADEROPTTEXT)
            HealBot_Options_HeadFontOutline.initialize = HealBot_Options_HeadFontOutline_DropDown
            UIDropDownMenu_SetText(HealBot_Options_HeadFontOutline, HealBot_Options_FontOutline_List[Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["OUTLINE"]])
            HealBot_Options_AliasFontOutline.initialize = HealBot_Options_AliasFontOutline_DropDown
            UIDropDownMenu_SetText(HealBot_Options_AliasFontOutline, HealBot_Options_FontOutline_List[Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["OUTLINE"]])
            HealBot_Options_SetText(HealBot_Options_FrameAliasShow,HEALBOT_OPTIONS_FRAME_TITLE_SHOW)
            HealBot_Options_FrameAliasShow:SetChecked(Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOW"])
            HealBot_Options_AliasFontName:SetValue(fontsIndex[Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["FONT"]] or 0)
            HealBot_Options_val_OnLoad(HealBot_Options_AliasFontHeight,HEALBOT_OPTIONS_SKINFHEIGHT,7,18,1)
            HealBot_Options_AliasFontHeight:SetValue(Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SIZE"])
            HealBot_Options_AliasFontHeightText:SetText(HEALBOT_OPTIONS_SKINFHEIGHT..": "..Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SIZE"])
            HealBot_Options_val_OnLoad(HealBot_Options_AliasFontOffset,HEALBOT_OPTIONS_FONT_OFFSET,-10,25,1)
            HealBot_Options_AliasFontOffset:SetValue(Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["OFFSET"])
            HealBot_Options_AliasFontOffsetText:SetText(HEALBOT_OPTIONS_FONT_OFFSET..": "..Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["OFFSET"])
            g=_G["healbotaliasfontoutlinestr"]
            g:SetText(HEALBOT_OPTIONS_SKINFOUTLINE)
            DoneInitTab[309]=true
        end
    elseif subNo==310 then
        if not DoneInitTab[310] then
            HealBot_Options_FrameAliasList()
            for id=1,11 do
                g=_G["HealBot_Options_HealGroups"..id]
                g:SetChecked(Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][id]["STATE"])
                local n=id
                if HEALBOT_GAME_VERSION<4 then 
                    if n>9 then n=n-1 end
                    if n>6 then n=n-1 end
                end
                g=_G["HealBot_Options_HealGroups"..id.."Text"]
                g:SetText(n..": "..HealBot_HealGroupsTrans[Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][id]["NAME"]]);
            end
            HealBot_Options_HealGroups1Frame.initialize = HealBot_Options_HealGroups1Frame_DropDown
            UIDropDownMenu_SetText(HealBot_Options_HealGroups1Frame, HealBot_Options_HealGroupsFrame_List[Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][1]["FRAME"]])
            HealBot_Options_HealGroups2Frame.initialize = HealBot_Options_HealGroups2Frame_DropDown
            UIDropDownMenu_SetText(HealBot_Options_HealGroups2Frame, HealBot_Options_HealGroupsFrame_List[Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][2]["FRAME"]])
            HealBot_Options_HealGroups3Frame.initialize = HealBot_Options_HealGroups3Frame_DropDown
            UIDropDownMenu_SetText(HealBot_Options_HealGroups3Frame, HealBot_Options_HealGroupsFrame_List[Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][3]["FRAME"]])
            HealBot_Options_HealGroups4Frame.initialize = HealBot_Options_HealGroups4Frame_DropDown
            UIDropDownMenu_SetText(HealBot_Options_HealGroups4Frame, HealBot_Options_HealGroupsFrame_List[Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][4]["FRAME"]])
            HealBot_Options_HealGroups5Frame.initialize = HealBot_Options_HealGroups5Frame_DropDown
            UIDropDownMenu_SetText(HealBot_Options_HealGroups5Frame, HealBot_Options_HealGroupsFrame_List[Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][5]["FRAME"]])
            g=_G["HealBot_HealButtonsGroups1_Text"]
            g:SetText(HEALBOT_OPTIONS_GROUPHEALS)
            HealBot_Options_HealGroups6Frame.initialize = HealBot_Options_HealGroups6Frame_DropDown
            UIDropDownMenu_SetText(HealBot_Options_HealGroups6Frame, HealBot_Options_HealGroupsFrame_List[Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][6]["FRAME"]])
            HealBot_Options_HealGroups7Frame.initialize = HealBot_Options_HealGroups7Frame_DropDown
            UIDropDownMenu_SetText(HealBot_Options_HealGroups7Frame, HealBot_Options_HealGroupsFrame_List[Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["FRAME"]])
            HealBot_Options_HealGroups8Frame.initialize = HealBot_Options_HealGroups8Frame_DropDown
            UIDropDownMenu_SetText(HealBot_Options_HealGroups8Frame, HealBot_Options_HealGroupsFrame_List[Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["FRAME"]])
            HealBot_Options_HealGroups9Frame.initialize = HealBot_Options_HealGroups9Frame_DropDown
            UIDropDownMenu_SetText(HealBot_Options_HealGroups9Frame, HealBot_Options_HealGroupsFrame_List[Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][9]["FRAME"]])
            HealBot_Options_HealGroups10Frame.initialize = HealBot_Options_HealGroups10Frame_DropDown
            UIDropDownMenu_SetText(HealBot_Options_HealGroups10Frame, HealBot_Options_HealGroupsFrame_List[Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["FRAME"]])
            HealBot_Options_HealGroups11Frame.initialize = HealBot_Options_HealGroups11Frame_DropDown
            UIDropDownMenu_SetText(HealBot_Options_HealGroups11Frame, HealBot_Options_HealGroupsFrame_List[Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][11]["FRAME"]])
            g=_G["HealBot_HealButtonsFrames1_Text"]
            g:SetText(HEALBOT_OPTIONS_FRAME)
            if HEALBOT_GAME_VERSION<4 then 
                HealBot_Options_HealGroups7:Hide()
                HealBot_Options_HealGroups7Frame:Hide()
                HealBot_Options_HealGroups8:ClearAllPoints()
                HealBot_Options_HealGroups8:SetPoint("TOPLEFT",HealBot_Options_HealGroups6,"TOPLEFT",0,-40)
                HealBot_Options_HealGroups10:Hide()
                HealBot_Options_HealGroups10Frame:Hide()
                HealBot_Options_HealGroups11:ClearAllPoints()
                HealBot_Options_HealGroups11:SetPoint("TOPLEFT",HealBot_Options_HealGroups9,"TOPLEFT",0,-40)
            end
            DoneInitTab[310]=true
        end
    elseif subNo==311 then
        if not DoneInitTab[311] then
            HealBot_Options_UpdateMedia(3)
            HealBot_Options_NewSkinb:Disable()
            g=_G["HealBot_Options_ScaleFrameText"]
            g:SetText(HEALBOT_OPTIONS_SKINTEXT)
            HealBot_Options_DeleteSkin:SetText(HEALBOT_OPTIONS_DELSKIN)
            g=_G["HealBot_Options_ScaleFrameText2"]
            g:SetText(HEALBOT_OPTIONS_NEWSKINTEXT)
            HealBot_Options_NewSkinb:SetText(HEALBOT_OPTIONS_SAVESKIN)
            HealBot_Options_ApplyTab2Frames:SetText(HEALBOT_OPTIONS_SET_ALL_FRAMES)
            DoneInitTab[311]=true
        end
    end
end

function HealBot_Options_InitSub2(subNo)
    local g=nil
    if subNo==401 then
        if not DoneInitTab[401] then
            HealBot_Options_UpdateMedia(4)
            HealBot_Options_CDCPriority1.initialize = HealBot_Options_CDCPriority1_DropDown
            UIDropDownMenu_SetText(HealBot_Options_CDCPriority1, HealBot_Config_Cures.HealBotDebuffPriority[HEALBOT_DISEASE_en])
            HealBot_Options_CDCPriority2.initialize = HealBot_Options_CDCPriority2_DropDown
            UIDropDownMenu_SetText(HealBot_Options_CDCPriority2, HealBot_Config_Cures.HealBotDebuffPriority[HEALBOT_MAGIC_en])
            HealBot_Options_CDCPriority3.initialize = HealBot_Options_CDCPriority3_DropDown
            UIDropDownMenu_SetText(HealBot_Options_CDCPriority3, HealBot_Config_Cures.HealBotDebuffPriority[HEALBOT_POISON_en])
            HealBot_Options_CDCPriority4.initialize = HealBot_Options_CDCPriority4_DropDown
            UIDropDownMenu_SetText(HealBot_Options_CDCPriority4, HealBot_Config_Cures.HealBotDebuffPriority[HEALBOT_CURSE_en])
            DoneInitTab[401]=true
        end
    elseif subNo==402 then  -- Always run this
        local _ = HealBot_Options_CDebuffCat_genList()
        HealBot_Options_CDebuffTxt1.numButtons = 0;
        HealBot_Options_CDebuffTxt1.initialize = HealBot_Options_CDebuffTxt1_DropDown
        local cdName=HealBot_Options_CDebuffTextID(HealBot_Options_StorePrev["CDebuffcustomName"]) 
        UIDropDownMenu_SetText(HealBot_Options_CDebuffTxt1, cdName)
        HealBot_Options_CDCReverseDurC:SetChecked(HealBot_Globals.HealBot_Custom_Debuffs_RevDur[HealBot_Options_StorePrev["CDebuffcustomName"]] or false)
        local cdcBarCol=HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[HealBot_Options_StorePrev["CDebuffcustomName"]]
        HealBot_Options_CDCCol_OnOff:SetChecked(cdcBarCol)
        HealBot_Options_SetEnableDisableCDBtn()
        local CDebuffCat_List = HealBot_Options_CDebuffCat_genList()
        HealBot_Options_StorePrev["numCustomDebuffs"]=#CDebuffCat_List
        HealBot_Options_CDebuffCatNameUpdate()
    elseif subNo==403 then -- Always run this
        local x=HealBot_Options_StorePrev["customDebuffPriority"] or 10
        if HealBot_Options_StorePrev["CDebuffcustomName"] then
            if not HealBot_Globals.HealBot_Custom_Debuffs[HealBot_Options_StorePrev["CDebuffcustomName"]] then HealBot_Globals.HealBot_Custom_Debuffs[HealBot_Options_StorePrev["CDebuffcustomName"]]=x end;
            x=HealBot_Globals.HealBot_Custom_Debuffs[HealBot_Options_StorePrev["CDebuffcustomName"]]
            HealBot_Options_CDCReverseDurC:SetChecked(HealBot_Globals.HealBot_Custom_Debuffs_RevDur[HealBot_Options_StorePrev["CDebuffcustomName"]] or false)
            local cdcBarCol=HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[HealBot_Options_StorePrev["CDebuffcustomName"]]
            HealBot_Options_CDCCol_OnOff:SetChecked(cdcBarCol)
            HealBot_Options_SetEnableDisableCDBtn()
        end
        HealBot_Options_CDCPriorityC.initialize = HealBot_Options_CDCPriorityC_DropDown
        UIDropDownMenu_SetSelectedID(HealBot_Options_CDCPriorityC, x)
        UIDropDownMenu_SetText(HealBot_Options_CDCPriorityC, x)
    elseif subNo==404 then -- Always Run
        HealBot_Options_CDCCastBy.initialize = HealBot_Options_CDCCastBy_DropDown
        local castBy=HEALBOT_CUSTOM_CASTBY_EVERYONE
        if HealBot_Globals.CureCustomDefaultCastBy=="ENEMY" then
            castBy=HEALBOT_CUSTOM_CASTBY_ENEMY
        end
        if HealBot_Options_StorePrev["CDebuffcustomName"] and HealBot_Globals.FilterCustomDebuff[HealBot_Options_StorePrev["CDebuffcustomName"]] then
            castBy=HealBot_CDebuffCasyBy_List[HealBot_Globals.FilterCustomDebuff[HealBot_Options_StorePrev["CDebuffcustomName"]]]
        end
        UIDropDownMenu_SetText(HealBot_Options_CDCCastBy, castBy)
        if not DoneInitTab[404] then
            HealBot_Options_CDCCastByCustom.initialize = HealBot_Options_CDCCastByCustom_DropDown
            UIDropDownMenu_SetText(HealBot_Options_CDCCastByCustom, HEALBOT_CUSTOM_CASTBY_ENEMY)
            DoneInitTab[404]=true
        end
    elseif subNo==405 then
        if not DoneInitTab[405] then
            HealBot_Options_CDebuffCat.initialize = HealBot_Options_CDebuffCat_DropDown
            UIDropDownMenu_SetText(HealBot_Options_CDebuffCat, HealBot_CDebuffCat_List[HealBot_Options_StorePrev["CDebuffCatID"]])
            HealBot_Options_CDCTxt1.initialize = HealBot_Options_CDCTxt1_DropDown
            UIDropDownMenu_SetText(HealBot_Options_CDCTxt1, HealBot_Config_Cures.HealBotDebuffText[HealBot_Options_getDropDownId_bySpec(1)])
            HealBot_Options_CDCGroups1.initialize = HealBot_Options_CDCGroups1_DropDown
            UIDropDownMenu_SetText(HealBot_Options_CDCGroups1, HealBot_Options_BuffTxt_List[HealBot_Config_Cures.HealBotDebuffDropDown[HealBot_Options_getDropDownId_bySpec(1)]])
            HealBot_Options_CDCTxt2.initialize = HealBot_Options_CDCTxt2_DropDown
            UIDropDownMenu_SetText(HealBot_Options_CDCTxt2, HealBot_Config_Cures.HealBotDebuffText[HealBot_Options_getDropDownId_bySpec(2)])
            HealBot_Options_CDCGroups2.initialize = HealBot_Options_CDCGroups2_DropDown
            UIDropDownMenu_SetText(HealBot_Options_CDCGroups2, HealBot_Options_BuffTxt_List[HealBot_Config_Cures.HealBotDebuffDropDown[HealBot_Options_getDropDownId_bySpec(2)]])
            HealBot_Options_CDCTxt3.initialize = HealBot_Options_CDCTxt3_DropDown
            UIDropDownMenu_SetText(HealBot_Options_CDCTxt3, HealBot_Config_Cures.HealBotDebuffText[HealBot_Options_getDropDownId_bySpec(3)])
            HealBot_Options_CDCGroups3.initialize = HealBot_Options_CDCGroups3_DropDown
            UIDropDownMenu_SetText(HealBot_Options_CDCGroups3, HealBot_Options_BuffTxt_List[HealBot_Config_Cures.HealBotDebuffDropDown[HealBot_Options_getDropDownId_bySpec(3)]])
            HealBot_Options_CDCWarnRange1.initialize = HealBot_Options_CDCWarnRange1_DropDown
            UIDropDownMenu_SetText(HealBot_Options_CDCWarnRange1, HealBot_Debuff_RangeWarning_List[HealBot_Config_Cures.HealBot_CDCWarnRange_Bar])
            HealBot_Options_CDCWarnRange2.initialize = HealBot_Options_CDCWarnRange2_DropDown
            UIDropDownMenu_SetText(HealBot_Options_CDCWarnRange2, HealBot_Debuff_RangeWarning_List[HealBot_Config_Cures.HealBot_CDCWarnRange_Aggro])
            HealBot_Options_CDCWarnRange3.initialize = HealBot_Options_CDCWarnRange3_DropDown
            UIDropDownMenu_SetText(HealBot_Options_CDCWarnRange3, HealBot_Debuff_RangeWarning_List[HealBot_Config_Cures.HealBot_CDCWarnRange_Screen])
            HealBot_Options_CDCWarnRange4.initialize = HealBot_Options_CDCWarnRange4_DropDown
            UIDropDownMenu_SetText(HealBot_Options_CDCWarnRange4, HealBot_Debuff_RangeWarning_List[HealBot_Config_Cures.HealBot_CDCWarnRange_Sound])
            DoneInitTab[405]=true
        end
    elseif subNo==406 then
        if not DoneInitTab[406] then
           -- HealBot_Options_val_OnLoad(HealBot_Options_WarningSound,HEALBOT_OPTIONS_SOUND,1,100,1)
            HealBot_Options_IgnoreDebuffsDuration:SetChecked(HealBot_Config_Cures.IgnoreFastDurDebuffs)
            HealBot_Options_SetText(HealBot_Options_IgnoreDebuffsDuration,HEALBOT_OPTIONS_IGNOREDEBUFFDURATION)
            HealBot_Options_IgnoreDebuffsMovement:SetChecked(HealBot_Config_Cures.IgnoreMovementDebuffs)
            HealBot_Options_SetText(HealBot_Options_IgnoreDebuffsMovement,HEALBOT_OPTIONS_IGNOREDEBUFFMOVEMENT)
            HealBot_Options_valtime_OnLoad(HealBot_Options_IgnoreDebuffsDurationSecs,HEALBOT_OPTIONS_HOTTEXTDURATION,1,5,1,true,1)
            HealBot_Options_IgnoreDebuffsDurationSecs:SetValue(HealBot_Config_Cures.IgnoreFastDurDebuffsSecs)
            HealBot_Options_IgnoreDebuffsDurationSecs_OnValueChanged(HealBot_Options_IgnoreDebuffsDurationSecs)
            HealBot_Options_IgnoreDebuffsNoHarm:SetChecked(HealBot_Config_Cures.IgnoreNonHarmfulDebuffs)
            HealBot_Options_SetText(HealBot_Options_IgnoreDebuffsNoHarm,HEALBOT_OPTIONS_IGNOREDEBUFFNOHARM)
            HealBot_Options_IgnoreDebuffsClass:SetChecked(HealBot_Config_Cures.IgnoreClassDebuffs)
            HealBot_Options_SetText(HealBot_Options_IgnoreDebuffsClass,HEALBOT_OPTIONS_IGNOREDEBUFFCLASS)
            HealBot_Options_IgnoreDebuffsCoolDown:SetChecked(HealBot_Config_Cures.IgnoreOnCooldownDebuffs)
            HealBot_Options_SetText(HealBot_Options_IgnoreDebuffsCoolDown,HEALBOT_OPTIONS_IGNOREDEBUFFCOOLDOWN)
            HealBot_Options_IgnoreDebuffsFriend:SetChecked(HealBot_Config_Cures.IgnoreFriendDebuffs)
            HealBot_Options_SetText(HealBot_Options_IgnoreDebuffsFriend,HEALBOT_OPTIONS_IGNOREDEBUFFFRIEND)
            HealBot_Options_MonitorDebuffsInCombat:SetChecked(HealBot_Config_Cures.DebuffWatchInCombat)
            HealBot_Options_SetText(HealBot_Options_MonitorDebuffsInCombat,HEALBOT_OPTIONS_MONITORBUFFSC)
            HealBot_Options_MonitorDebuffsWhenGrouped:SetChecked(HealBot_Config_Cures.DebuffWatchWhenGrouped)
            HealBot_Options_SetText(HealBot_Options_MonitorDebuffsWhenGrouped,HEALBOT_OPTIONS_IN_A_GROUP)
            HealBot_Options_ShowDebuffWarning:SetChecked(HealBot_Config_Cures.ShowDebuffWarning)
            HealBot_Options_SetText(HealBot_Options_ShowDebuffWarning,HEALBOT_OPTIONS_SHOWDEBUFFWARNING)
            HealBot_Options_SoundDebuffWarning:SetChecked(HealBot_Config_Cures.SoundDebuffWarning)
            HealBot_Options_SetText(HealBot_Options_SoundDebuffWarning,HEALBOT_OPTIONS_SOUNDDEBUFFWARNING)
            HealBot_Options_WarningSound:SetValue(soundsIndex[HealBot_Config_Cures.SoundDebuffPlay] or 0);
            HealBot_Options_CDCCol_ShowOnAggroBar:SetChecked(HealBot_Config_Cures.CDCshownAB)
            HealBot_Options_SetText(HealBot_Options_CDCCol_ShowOnAggroBar,HEALBOT_OPTIONS_CDCSHOWABARS)
            HealBot_Options_CDCCol_ShowOnHealthBar:SetChecked(HealBot_Config_Cures.CDCshownHB)
            HealBot_Options_SetText(HealBot_Options_CDCCol_ShowOnHealthBar,HEALBOT_OPTIONS_CDCSHOWHBARS)
            HealBot_Options_MonitorDebuffs:SetChecked(HealBot_Config_Cures.DebuffWatch)
            HealBot_Options_SetText(HealBot_Options_MonitorDebuffs,HEALBOT_OPTIONS_MONITORDEBUFFS)
            HealBot_Options_CDCAllDisease:SetChecked(HealBot_Config_Cures.HealBot_Custom_Defuffs_All[HEALBOT_DISEASE_en])
            HealBot_Options_SetText(HealBot_Options_CDCAllDisease,HEALBOT_OPTIONS_CUSTOM_ALLDISEASE)
            HealBot_Options_CDCAllMagic:SetChecked(HealBot_Config_Cures.HealBot_Custom_Defuffs_All[HEALBOT_MAGIC_en])
            HealBot_Options_SetText(HealBot_Options_CDCAllMagic,HEALBOT_OPTIONS_CUSTOM_ALLMAGIC)
            HealBot_Options_CDCAllPoison:SetChecked(HealBot_Config_Cures.HealBot_Custom_Defuffs_All[HEALBOT_POISON_en])
            HealBot_Options_SetText(HealBot_Options_CDCAllPoison,HEALBOT_OPTIONS_CUSTOM_ALLPOISON)
            HealBot_Options_CDCAllCurse:SetChecked(HealBot_Config_Cures.HealBot_Custom_Defuffs_All[HEALBOT_CURSE_en])
            HealBot_Options_SetText(HealBot_Options_CDCAllCurse,HEALBOT_OPTIONS_CUSTOM_ALLCURSE)
            HealBot_Options_CDCAllBoss:SetChecked(HealBot_Config_Cures.AlwaysShowBoss)
            HealBot_Options_SetText(HealBot_Options_CDCAllBoss,HEALBOT_OPTIONS_CUSTOM_ALLBOSS)
            HealBot_Options_CDCAllBossStrict:SetChecked(HealBot_Config_Cures.AlwaysShowBossStrict)
            HealBot_Options_SetText(HealBot_Options_CDCAllBossStrict,HEALBOT_OPTIONS_CUSTOM_ALLBOSSSTRICT)
            HealBot_Options_SetText(HealBot_Options_CDCReverseDurC,HEALBOT_OPTIONS_CUSTOMDEBUFF_REVDUR)
            HealBot_Options_DeleteCDebuffBtn:SetText(HEALBOT_OPTIONS_DELSKIN)
            HealBot_Options_NewCDebuffBtn:SetText(HEALBOT_OPTIONS_SAVESKIN)
            HealBot_Options_NewBuffHoTBtn:SetText(HEALBOT_OPTIONS_SAVESKIN)
            HealBot_Options_SetText(HealBot_Options_CDCCol_OnOff,HEALBOT_SKIN_HEADERBARCOL)
            HealBot_Options_ResetCDebuffBtn:SetText(HEALBOT_WORD_RESET)
            HealBot_Options_SetEnableDisableCDBtn()
            g=_G["HealBot_Options_Panel4_3"]
            g:SetText(HEALBOT_WORD_PRIORITY)
            g=_G["HealBot_CDCCol_Text"]
            g:SetText(HEALBOT_OPTIONS_CDCBARS)
            g=_G["HealBot_Options_Panel4_1"]
            g:SetText(HEALBOT_OPTIONS_DEBUFFTEXT1)
            g=_G["HealBot_Options_Panel4_2"]
            g:SetText(HEALBOT_OPTIONS_BUFFSTEXT2)
            g=_G["HealBot_Options_IgnoreDebuffsTxt"]
            g:SetText(HEALBOT_OPTIONS_IGNOREDEBUFF)
            g=_G["HealBot_Options_DebuffDisease_FontStr"]
            g:SetText(HEALBOT_DISEASE)
            g=_G["HealBot_Options_DebuffMagic_FontStr"]
            g:SetText(HEALBOT_MAGIC)
            g=_G["HealBot_Options_DebuffPoison_FontStr"]
            g:SetText(HEALBOT_POISON)
            g=_G["HealBot_Options_DebuffCurse_FontStr"]
            g:SetText(HEALBOT_CURSE)
            g=_G["HealBot_Options_PrioDebuffDisease_FontStr"]
            g:SetText(HEALBOT_DISEASE)
            g=_G["HealBot_Options_PrioDebuffMagic_FontStr"]
            g:SetText(HEALBOT_MAGIC)
            g=_G["HealBot_Options_PrioDebuffPoison_FontStr"]
            g:SetText(HEALBOT_POISON)
            g=_G["HealBot_Options_PrioDebuffCurse_FontStr"]
            g:SetText(HEALBOT_CURSE)
            g=_G["HealBot_Options_CDebuffText"]
            g:SetText(HEALBOT_CUSTOM_CATEGORY)
            g=_G["HealBot_Options_CDebuffCustomText"]
            g:SetText(HEALBOT_CLASSES_CUSTOM)
            g=_G["HealBot_Options_CustomDebuff_CastByText"]
            g:SetText(HEALBOT_OPTIONS_CUSTOM_CASTBY)
            g=_G["HealBot_Options_CDebuffText2"]
            g:SetText(HEALBOT_OPTIONS_NEWDEBUFFTEXT)
            g=_G["HealBot_Options_CustomDebuff_PriorityText"]
            g:SetText(HEALBOT_WORD_PRIORITY)
            g=_G["HealBot_Options_CustomBuff_PriorityText"]
            g:SetText(HEALBOT_WORD_PRIORITY)
            g=_G["healbotcustomdebuffclassfontstr"]
            g:SetText(HEALBOT_CLASSES_CUSTOM)
            g=_G["healbotcustombuffclassfontstr"]
            g:SetText(HEALBOT_CLASSES_CUSTOM)
            g=_G["HealBot_CDCWarn_Text"]
            g:SetText(HEALBOT_OPTIONS_CDCWARNINGS)
            g=_G["HealBot_Options_CustomAuto"]
            g:SetText(HEALBOT_CUSTOM_CAT_CUSTOM_AUTOMATIC)
            g:SetTextColor(1,1,1,1)
            g=_G["HealBot_Options_PageCDebuff"]
            g:SetText(HEALBOT_OPTIONS_PAGE)
            g=_G["HealBot_BuffWarn_Text"]
            g:SetText(HEALBOT_OPTIONS_BUFFWARNINGS)
            g=_G["HealBot_BuffMissing_Text"]
            g:SetText(HEALBOT_OPTIONS_BUFFMISSING)
            g=_G["HealBot_BuffCustom_Text"]
            g:SetText(HEALBOT_OPTIONS_BUFFCUSTOM)
            g=_G["HealBot_DebuffCustom_Text"]
            g:SetText(HEALBOT_OPTIONS_DEBUFFCUSTOM)
            DoneInitTab[406]=true
        end
    elseif subNo==501 then
        if not DoneInitTab[501] then
            HealBot_Options_UpdateMedia(5)
            HealBot_Options_BuffWarningSound:SetValue(soundsIndex[HealBot_Config_Buffs.SoundBuffPlay] or 0);
            local BuffTextClass = HealBot_Config_Buffs.HealBotBuffText
            if not BuffTextClass[HealBot_Options_getDropDownId_bySpec(1)] then BuffTextClass[HealBot_Options_getDropDownId_bySpec(1)]=HEALBOT_WORDS_NONE  end;
            HealBot_Options_BuffTxt1.numButtons = 0;
            HealBot_Options_BuffTxt1.initialize = HealBot_Options_BuffTxt1_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BuffTxt1, BuffTextClass[HealBot_Options_getDropDownId_bySpec(1)])
            local BuffDropDownClass = HealBot_Config_Buffs.HealBotBuffDropDown
            if not BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(1)] then BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(1)]=1 end;
            HealBot_Options_BuffGroups1.initialize = HealBot_Options_BuffGroups1_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BuffGroups1, HealBot_Options_BuffTxt_List[BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(1)]])
            BuffTextClass = HealBot_Config_Buffs.HealBotBuffText
            if not BuffTextClass[HealBot_Options_getDropDownId_bySpec(2)] then BuffTextClass[HealBot_Options_getDropDownId_bySpec(2)]=HEALBOT_WORDS_NONE  end;
            HealBot_Options_BuffTxt2.numButtons = 0;
            HealBot_Options_BuffTxt2.initialize = HealBot_Options_BuffTxt2_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BuffTxt2, BuffTextClass[HealBot_Options_getDropDownId_bySpec(2)])
            BuffDropDownClass = HealBot_Config_Buffs.HealBotBuffDropDown
            if not BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(2)] then BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(2)]=1 end;
            HealBot_Options_BuffGroups2.initialize = HealBot_Options_BuffGroups2_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BuffGroups2, HealBot_Options_BuffTxt_List[BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(2)]])
            BuffTextClass = HealBot_Config_Buffs.HealBotBuffText
            if not BuffTextClass[HealBot_Options_getDropDownId_bySpec(3)] then BuffTextClass[HealBot_Options_getDropDownId_bySpec(3)]=HEALBOT_WORDS_NONE  end;
            HealBot_Options_BuffTxt3.numButtons = 0;
            HealBot_Options_BuffTxt3.initialize = HealBot_Options_BuffTxt3_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BuffTxt3, BuffTextClass[HealBot_Options_getDropDownId_bySpec(3)])
            BuffDropDownClass = HealBot_Config_Buffs.HealBotBuffDropDown
            if not BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(3)] then BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(3)]=1 end;
            HealBot_Options_BuffGroups3.initialize = HealBot_Options_BuffGroups3_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BuffGroups3, HealBot_Options_BuffTxt_List[BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(3)]])
            BuffTextClass = HealBot_Config_Buffs.HealBotBuffText
            if not BuffTextClass[HealBot_Options_getDropDownId_bySpec(4)] then BuffTextClass[HealBot_Options_getDropDownId_bySpec(4)]=HEALBOT_WORDS_NONE  end;
            HealBot_Options_BuffTxt4.numButtons = 0;
            HealBot_Options_BuffTxt4.initialize = HealBot_Options_BuffTxt4_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BuffTxt4, BuffTextClass[HealBot_Options_getDropDownId_bySpec(4)])
            BuffDropDownClass = HealBot_Config_Buffs.HealBotBuffDropDown
            if not BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(4)] then BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(4)]=1 end;
            HealBot_Options_BuffGroups4.initialize = HealBot_Options_BuffGroups4_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BuffGroups4, HealBot_Options_BuffTxt_List[BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(4)]])
            BuffTextClass = HealBot_Config_Buffs.HealBotBuffText
            if not BuffTextClass[HealBot_Options_getDropDownId_bySpec(5)] then BuffTextClass[HealBot_Options_getDropDownId_bySpec(5)]=HEALBOT_WORDS_NONE  end;
            HealBot_Options_BuffTxt5.numButtons = 0;
            HealBot_Options_BuffTxt5.initialize = HealBot_Options_BuffTxt5_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BuffTxt5, BuffTextClass[HealBot_Options_getDropDownId_bySpec(5)])
            BuffDropDownClass = HealBot_Config_Buffs.HealBotBuffDropDown
            if not BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(5)] then BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(5)]=1 end;
            HealBot_Options_BuffGroups5.initialize = HealBot_Options_BuffGroups5_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BuffGroups5, HealBot_Options_BuffTxt_List[BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(5)]])
            BuffTextClass = HealBot_Config_Buffs.HealBotBuffText
            if not BuffTextClass[HealBot_Options_getDropDownId_bySpec(6)] then BuffTextClass[HealBot_Options_getDropDownId_bySpec(6)]=HEALBOT_WORDS_NONE  end;
            HealBot_Options_BuffTxt6.numButtons = 0;
            HealBot_Options_BuffTxt6.initialize = HealBot_Options_BuffTxt6_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BuffTxt6, BuffTextClass[HealBot_Options_getDropDownId_bySpec(6)])
            BuffDropDownClass = HealBot_Config_Buffs.HealBotBuffDropDown
            if not BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(6)] then BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(6)]=1 end;
            HealBot_Options_BuffGroups6.initialize = HealBot_Options_BuffGroups6_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BuffGroups6, HealBot_Options_BuffTxt_List[BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(6)]])
            BuffTextClass = HealBot_Config_Buffs.HealBotBuffText
            if not BuffTextClass[HealBot_Options_getDropDownId_bySpec(7)] then BuffTextClass[HealBot_Options_getDropDownId_bySpec(7)]=HEALBOT_WORDS_NONE  end;
            HealBot_Options_BuffTxt7.numButtons = 0;
            HealBot_Options_BuffTxt7.initialize = HealBot_Options_BuffTxt7_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BuffTxt7, BuffTextClass[HealBot_Options_getDropDownId_bySpec(7)])
            BuffDropDownClass = HealBot_Config_Buffs.HealBotBuffDropDown
            if not BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(7)] then BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(7)]=1 end;
            HealBot_Options_BuffGroups7.initialize = HealBot_Options_BuffGroups7_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BuffGroups7, HealBot_Options_BuffTxt_List[BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(7)]])
            BuffTextClass = HealBot_Config_Buffs.HealBotBuffText
            if not BuffTextClass[HealBot_Options_getDropDownId_bySpec(8)] then BuffTextClass[HealBot_Options_getDropDownId_bySpec(8)]=HEALBOT_WORDS_NONE  end;
            HealBot_Options_BuffTxt8.numButtons = 0;
            HealBot_Options_BuffTxt8.initialize = HealBot_Options_BuffTxt8_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BuffTxt8, BuffTextClass[HealBot_Options_getDropDownId_bySpec(8)])
            BuffDropDownClass = HealBot_Config_Buffs.HealBotBuffDropDown
            if not BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(8)] then BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(8)]=1 end;
            HealBot_Options_BuffGroups8.initialize = HealBot_Options_BuffGroups8_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BuffGroups8, HealBot_Options_BuffTxt_List[BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(8)]])
            HealBot_Options_MonitorBuffsInCombat:SetChecked(HealBot_Config_Buffs.BuffWatchInCombat)
            HealBot_Options_SetText(HealBot_Options_MonitorBuffsInCombat,HEALBOT_OPTIONS_MONITORBUFFSC)
            HealBot_Options_MonitorBuffsWhenGrouped:SetChecked(HealBot_Config_Buffs.BuffWatchWhenGrouped)
            HealBot_Options_SetText(HealBot_Options_MonitorBuffsWhenGrouped,HEALBOT_OPTIONS_IN_A_GROUP)
            HealBot_Options_MonitorBuffsPalaBlessing:SetChecked(HealBot_Config_Buffs.PalaBlessingsAsOne)
            HealBot_Options_SetText(HealBot_Options_MonitorBuffsPalaBlessing,HEALBOT_OPTIONS_PALADIN_BLESSINGS)
            HealBot_Options_valtime_OnLoad(HealBot_Options_LongBuffTimer,HEALBOT_OPTIONS_LONGBUFFTIMER,0,300,15)
            HealBot_Options_LongBuffTimer:SetValue(HealBot_Config_Buffs.LongBuffTimer)
            HealBot_Options_BuffTimer_OnValueChanged(HealBot_Options_LongBuffTimer,"LONG")
            HealBot_Options_valtime_OnLoad(HealBot_Options_ShortBuffTimer,HEALBOT_OPTIONS_SHORTBUFFTIMER,0,120,5)
            HealBot_Options_ShortBuffTimer:SetValue(HealBot_Config_Buffs.ShortBuffTimer)
            HealBot_Options_BuffTimer_OnValueChanged(HealBot_Options_ShortBuffTimer,"SHORT")
            HealBot_Options_MonitorBuffs:SetChecked(HealBot_Config_Buffs.BuffWatch)
            HealBot_Options_SetText(HealBot_Options_MonitorBuffs,HEALBOT_OPTIONS_MONITORBUFFS)
            HealBot_Options_ResetBuffBtn:SetText(HEALBOT_WORD_RESET)
            g=_G["HealBot_Options_Panel5_1"]
            g:SetText(HEALBOT_OPTIONS_BUFFSTEXT1)
            g=_G["HealBot_Options_Panel5_2"]
            g:SetText(HEALBOT_OPTIONS_BUFFSTEXT2)
            g=_G["HealBot_Options_Panel5_3"]
            g:SetText(HEALBOT_OPTIONS_BUFFSTEXT3)
            g=_G["HealBot_Options_Panel5_4"]
            g:SetText(HEALBOT_OPTIONS_BUFFSTEXTTIMER)
            HealBot_Options_SetText(HealBot_Options_CustomBuffCol_OnOff,HEALBOT_SKIN_HEADERBARCOL)
            HealBot_Options_BuffCol_ShowOnHealthBar:SetChecked(HealBot_Config_Buffs.CBshownHB)
            HealBot_Options_SetText(HealBot_Options_BuffCol_ShowOnHealthBar,HEALBOT_OPTIONS_CDCSHOWHBARS)
            HealBot_Options_BuffCol_ShowOnAggroBar:SetChecked(HealBot_Config_Buffs.CBshownAB)
            HealBot_Options_SetText(HealBot_Options_BuffCol_ShowOnAggroBar,HEALBOT_OPTIONS_CDCSHOWABARS)
            HealBot_Options_ShowBuffWarning:SetChecked(HealBot_Config_Buffs.ShowBuffWarning)
            HealBot_Options_SetText(HealBot_Options_ShowBuffWarning,HEALBOT_OPTIONS_SHOWBUFFWARNING)
            HealBot_Options_SoundBuffWarning:SetChecked(HealBot_Config_Buffs.SoundBuffWarning)
            HealBot_Options_SetText(HealBot_Options_SoundBuffWarning,HEALBOT_OPTIONS_SOUNDBUFFWARNING)
            HealBot_Options_BuffWarnRange1.initialize = HealBot_Options_BuffWarnRange1_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BuffWarnRange1, HealBot_Debuff_RangeWarning_List[HealBot_Config_Buffs.HealBot_CBWarnRange_Bar])
            HealBot_Options_BuffWarnRange2.initialize = HealBot_Options_BuffWarnRange2_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BuffWarnRange2, HealBot_Debuff_RangeWarning_List[HealBot_Config_Buffs.HealBot_CBWarnRange_Aggro])
            HealBot_Options_BuffWarnRange3.initialize = HealBot_Options_BuffWarnRange3_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BuffWarnRange3, HealBot_Debuff_RangeWarning_List[HealBot_Config_Buffs.HealBot_CBWarnRange_Screen])
            HealBot_Options_BuffWarnRange4.initialize = HealBot_Options_BuffWarnRange4_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BuffWarnRange4, HealBot_Debuff_RangeWarning_List[HealBot_Config_Buffs.HealBot_CBWarnRange_Sound])
            HealBot_Options_HoTctlActionCustom:Disable()
            HealBot_Options_BuffPriorityCustom:Disable()
            DoneInitTab[501]=true
        end
    elseif subNo==502 then
        --if not DoneInitTab[502] then
            HealBot_Options_StorePrev["FilterHoTctlName"]=HealBot_Options_FilterHoTctl_List[HealBot_Options_StorePrev["FilterHoTctlID"]]
            HealBot_Options_FilterHoTctl.initialize = HealBot_Options_FilterHoTctl_DropDown
            UIDropDownMenu_SetText(HealBot_Options_FilterHoTctl, HealBot_Options_StorePrev["FilterHoTctlName"])
            local HoTctlName_List = HealBot_Options_Class_HoTctlName_genList()
            local sId=HealBot_Options_CDebuffGetId(HealBot_Options_StorePrev["HoTname"])
            --if HealBot_Options_StorePrev["FilterHoTctlNameTrim"] and HealBot_Globals.WatchHoT[HealBot_Options_StorePrev["FilterHoTctlNameTrim"]] and not
            --   HealBot_Globals.WatchHoT[HealBot_Options_StorePrev["FilterHoTctlNameTrim"]][sId] then HealBot_Options_StorePrev["HoTname"]=HoTctlName_List[1] end
            HealBot_Options_Class_HoTctlName.initialize = HealBot_Options_Class_HoTctlName_DropDown
            UIDropDownMenu_SetText(HealBot_Options_Class_HoTctlName, HealBot_Options_StorePrev["HoTname"])
            HealBot_Options_Class_HoTctlAction.initialize = HealBot_Options_Class_HoTctlAction_DropDown
            local x=HealBot_Globals.WatchHoT[HealBot_Options_StorePrev["FilterHoTctlNameTrim"]][sId] or 1
            UIDropDownMenu_SetText(HealBot_Options_Class_HoTctlAction, HealBot_Options_Class_HoTctlAction_List[x])
            x=HealBot_Globals.HealBot_Custom_Buffs[sId] or 10
            HealBot_Options_BuffPriorityC.initialize = HealBot_Options_BuffPriorityC_DropDown
            UIDropDownMenu_SetSelectedID(HealBot_Options_BuffPriorityC, x)
            UIDropDownMenu_SetText(HealBot_Options_BuffPriorityC, x)
            HealBot_Options_StorePrev["numCustomBuffs"]=#HoTctlName_List
            HealBot_Options_BuffCatNameUpdate()
            HealBot_Options_SetEnableDisableBuffBtn()
            HealBot_SetCustomBuffBarColours()
            HealBot_Options_setCustomBuffList()
            local cbBarCol=HealBot_Globals.HealBot_Custom_Buffs_ShowBarCol[sId]
            HealBot_Options_CustomBuffCol_OnOff:SetChecked(cbBarCol)
        --end
    elseif subNo==601 then
        if not DoneInitTab[601] then
            HealBot_Options_ShowTooltip:SetChecked(HealBot_Globals.ShowTooltip)
            HealBot_Options_SetText(HealBot_Options_ShowTooltip,HEALBOT_OPTIONS_SHOWTOOLTIP)
            HealBot_Options_ShowTooltipUpdate:SetChecked(HealBot_Globals.TooltipUpdate)
            HealBot_Options_SetText(HealBot_Options_ShowTooltipUpdate,HEALBOT_OPTIONS_TOOLTIPUPDATE)
            HealBot_Options_HideTooltipInCombat:SetChecked(HealBot_Globals.DisableToolTipInCombat)
            HealBot_Options_SetText(HealBot_Options_HideTooltipInCombat,HEALBOT_OPTIONS_DISABLETOOLTIPINCOMBAT)
            HealBot_Options_ShowTooltipTarget:SetChecked(HealBot_Globals.Tooltip_ShowTarget)
            HealBot_Options_SetText(HealBot_Options_ShowTooltipTarget,HEALBOT_OPTIONS_SHOWUNITTOOLTIP)
            HealBot_Options_ShowTooltipMyBuffs:SetChecked(HealBot_Globals.Tooltip_ShowMyBuffs)
            HealBot_Options_SetText(HealBot_Options_ShowTooltipMyBuffs,HEALBOT_OPTIONS_SHOWUNITBUFFTIME)
            HealBot_Options_ShowTooltipSpellDetail:SetChecked(HealBot_Globals.Tooltip_ShowSpellDetail)
            HealBot_Options_SetText(HealBot_Options_ShowTooltipSpellDetail,HEALBOT_OPTIONS_SHOWDETTOOLTIP)
            HealBot_Options_ShowTooltipSpellCoolDown:SetChecked(HealBot_Globals.Tooltip_ShowCD)
            HealBot_Options_SetText(HealBot_Options_ShowTooltipSpellCoolDown,HEALBOT_OPTIONS_SHOWCDTOOLTIP)
            HealBot_Options_ShowTooltipMouseWheel:SetChecked(HealBot_Globals.Tooltip_MouseWheel)
            HealBot_Options_SetText(HealBot_Options_ShowTooltipMouseWheel,HEALBOT_OPTIONS_SHOWMOUSEWHEELTOOLTIP)
            HealBot_Options_ShowTooltipInstant:SetChecked(HealBot_Globals.Tooltip_Recommend)
            HealBot_Options_SetText(HealBot_Options_ShowTooltipInstant,HEALBOT_OPTIONS_SHOWRECTOOLTIP)
            HealBot_Options_ShowTooltipUseGameTip:SetChecked(HealBot_Globals.UseGameTooltip)
            HealBot_Options_SetText(HealBot_Options_ShowTooltipUseGameTip,HEALBOT_OPTIONS_USEGAMETOOLTIP)
            HealBot_Options_ShowTooltipShowHoT:SetChecked(HealBot_Globals.Tooltip_ShowHoT)
            HealBot_Options_SetText(HealBot_Options_ShowTooltipShowHoT,HEALBOT_OPTIONS_TOOLTIPSHOWHOT)
            HealBot_Options_Pct_OnLoad(HealBot_Options_TTAlpha,HEALBOT_OPTIONS_TTALPHA)
            HealBot_Options_TTAlpha:SetValue(HealBot_Globals.ttalpha)
            HealBot_Options_TooltipTextSize.initialize = HealBot_Options_TooltipTextSize_DropDown
            UIDropDownMenu_SetText(HealBot_Options_TooltipTextSize, HealBot_Options_TooltipFontSize_List[HealBot_Globals.Tooltip_TextSize])
            g=_G["HealBot_Options_Panel6_1"]
            g:SetText(HEALBOT_OPTIONS_TIPTEXT)
            DoneInitTab[601]=true
        end
    elseif subNo==701 then
        if not DoneInitTab[701] then
            if not HealBot_Globals.HealBot_MouseWheelIndex["NoneUp"] then HealBot_Globals.HealBot_MouseWheelIndex["NoneUp"]=1 end
            HealBot_Options_MouseWheelUp.initialize = HealBot_Options_MouseWheelUp_DropDown
            UIDropDownMenu_SetText(HealBot_Options_MouseWheelUp, HealBot_Options_MouseWheel_List[HealBot_Globals.HealBot_MouseWheelIndex["NoneUp"]])
            HealBot_Options_MouseWheelUpEmotes.initialize = HealBot_Options_MouseWheelUpEmotes_DropDown
            UIDropDownMenu_SetText(HealBot_Options_MouseWheelUpEmotes, HealBot_Globals.HealBot_Emotes["NoneUp"])
            if not HealBot_Globals.HealBot_MouseWheelIndex["NoneDown"] then HealBot_Globals.HealBot_MouseWheelIndex["NoneDown"]=1 end
            HealBot_Options_MouseWheelDown.initialize = HealBot_Options_MouseWheelDown_DropDown
            UIDropDownMenu_SetText(HealBot_Options_MouseWheelDown, HealBot_Options_MouseWheel_List[HealBot_Globals.HealBot_MouseWheelIndex["NoneDown"]])
            HealBot_Options_MouseWheelDownEmotes.initialize = HealBot_Options_MouseWheelDownEmotes_DropDown
            UIDropDownMenu_SetText(HealBot_Options_MouseWheelDownEmotes, HealBot_Globals.HealBot_Emotes["NoneDown"])
            if not HealBot_Globals.HealBot_MouseWheelIndex["ShiftUp"] then HealBot_Globals.HealBot_MouseWheelIndex["ShiftUp"]=1 end
            HealBot_Options_MouseWheelShiftUp.initialize = HealBot_Options_MouseWheelShiftUp_DropDown
            UIDropDownMenu_SetText(HealBot_Options_MouseWheelShiftUp, HealBot_Options_MouseWheel_List[HealBot_Globals.HealBot_MouseWheelIndex["ShiftUp"]])
            HealBot_Options_MouseWheelShiftUpEmotes.initialize = HealBot_Options_MouseWheelShiftUpEmotes_DropDown
            UIDropDownMenu_SetText(HealBot_Options_MouseWheelShiftUpEmotes, HealBot_Globals.HealBot_Emotes["ShiftUp"])
            if not HealBot_Globals.HealBot_MouseWheelIndex["ShiftDown"] then HealBot_Globals.HealBot_MouseWheelIndex["ShiftDown"]=1 end
            HealBot_Options_MouseWheelShiftDown.initialize = HealBot_Options_MouseWheelShiftDown_DropDown
            UIDropDownMenu_SetText(HealBot_Options_MouseWheelShiftDown, HealBot_Options_MouseWheel_List[HealBot_Globals.HealBot_MouseWheelIndex["ShiftDown"]])
            HealBot_Options_MouseWheelShiftDownEmotes.initialize = HealBot_Options_MouseWheelShiftDownEmotes_DropDown
            UIDropDownMenu_SetText(HealBot_Options_MouseWheelShiftDownEmotes, HealBot_Globals.HealBot_Emotes["ShiftDown"])
            if not HealBot_Globals.HealBot_MouseWheelIndex["CtrlUp"] then HealBot_Globals.HealBot_MouseWheelIndex["CtrlUp"]=1 end
            HealBot_Options_MouseWheelCtrlUp.initialize = HealBot_Options_MouseWheelCtrlUp_DropDown
            UIDropDownMenu_SetText(HealBot_Options_MouseWheelCtrlUp, HealBot_Options_MouseWheel_List[HealBot_Globals.HealBot_MouseWheelIndex["CtrlUp"]])
            HealBot_Options_MouseWheelCtrlUpEmotes.initialize = HealBot_Options_MouseWheelCtrlUpEmotes_DropDown
            UIDropDownMenu_SetText(HealBot_Options_MouseWheelCtrlUpEmotes, HealBot_Globals.HealBot_Emotes["CtrlUp"])
            if not HealBot_Globals.HealBot_MouseWheelIndex["CtrlDown"] then HealBot_Globals.HealBot_MouseWheelIndex["CtrlDown"]=1 end
            HealBot_Options_MouseWheelCtrlDown.initialize = HealBot_Options_MouseWheelCtrlDown_DropDown
            UIDropDownMenu_SetText(HealBot_Options_MouseWheelCtrlDown, HealBot_Options_MouseWheel_List[HealBot_Globals.HealBot_MouseWheelIndex["CtrlDown"]])
            HealBot_Options_MouseWheelCtrlDownEmotes.initialize = HealBot_Options_MouseWheelCtrlDownEmotes_DropDown
            UIDropDownMenu_SetText(HealBot_Options_MouseWheelCtrlDownEmotes, HealBot_Globals.HealBot_Emotes["CtrlDown"])
            if not HealBot_Globals.HealBot_MouseWheelIndex["AltUp"] then HealBot_Globals.HealBot_MouseWheelIndex["AltUp"]=1 end
            HealBot_Options_MouseWheelAltUp.initialize = HealBot_Options_MouseWheelAltUp_DropDown
            UIDropDownMenu_SetText(HealBot_Options_MouseWheelAltUp, HealBot_Options_MouseWheel_List[HealBot_Globals.HealBot_MouseWheelIndex["AltUp"]])
            HealBot_Options_MouseWheelAltUpEmotes.initialize = HealBot_Options_MouseWheelAltUpEmotes_DropDown
            UIDropDownMenu_SetText(HealBot_Options_MouseWheelAltUpEmotes, HealBot_Globals.HealBot_Emotes["AltUp"])
            if not HealBot_Globals.HealBot_MouseWheelIndex["AltDown"] then HealBot_Globals.HealBot_MouseWheelIndex["AltDown"]=1 end
            HealBot_Options_MouseWheelAltDown.initialize = HealBot_Options_MouseWheelAltDown_DropDown
            UIDropDownMenu_SetText(HealBot_Options_MouseWheelAltDown, HealBot_Options_MouseWheel_List[HealBot_Globals.HealBot_MouseWheelIndex["AltDown"]])
            HealBot_Options_MouseWheelAltDownEmotes.initialize = HealBot_Options_MouseWheelAltDownEmotes_DropDown
            UIDropDownMenu_SetText(HealBot_Options_MouseWheelAltDownEmotes, HealBot_Globals.HealBot_Emotes["AltDown"])
            HealBot_Options_MouseWheelUpEmotes_Display()
            HealBot_Options_MouseWheelDownEmotes_Display()
            HealBot_Options_MouseWheelShiftUpEmotes_Display()
            HealBot_Options_MouseWheelShiftDownEmotes_Display()
            HealBot_Options_MouseWheelCtrlUpEmotes_Display()
            HealBot_Options_MouseWheelCtrlDownEmotes_Display()
            HealBot_Options_MouseWheelAltUpEmotes_Display()
            HealBot_Options_MouseWheelAltDownEmotes_Display()
            HealBot_Options_EnableMouseWheel:SetChecked(HealBot_Globals.HealBot_Enable_MouseWheel)
            HealBot_Options_SetText(HealBot_Options_EnableMouseWheel,HEALBOT_OPTIONS_MOUSEWHEEL)
            g=_G["healbotmwmouseupfontstr"]
            g:SetText(HEALBOT_OPTIONS_MOUSEUP)
            g=_G["healbotmwnonefontstr"]
            g:SetText(HEALBOT_WORDS_NONE)
            g=_G["healbotmwmousedownfontstr"]
            g:SetText(HEALBOT_OPTIONS_MOUSEDOWN)
            g=_G["healbotmwmouseshiftfontstr"]
            g:SetText(HEALBOT_OPTIONS_SHIFT)
            g=_G["healbotmwmousectrlfontstr"]
            g:SetText(HEALBOT_OPTIONS_CTRL)
            g=_G["healbotmwmousealtfontstr"]
            g:SetText(HEALBOT_OPTIONS_ALT)
            DoneInitTab[701]=true
        end
    elseif subNo==801 then
        if not DoneInitTab[801] then
            HealBot_Options_FAQ.initialize = HealBot_Options_FAQ_DropDown
            UIDropDownMenu_SetText(HealBot_Options_FAQ, HEALBOT_ABOUT_FAQ_QUESTIONS[1])
            g=_G["HealBot_Options_FAQAnswerTextD"]
            g:SetTextColor(1,1,1,1);    
            g:SetText(HEALBOT_ABOUT_FAQ_ANSWERS[HealBot_Options_StorePrev["hbFAQ"]])
            g=_G["HealBot_About_Desc1"] 
            g:SetText(HEALBOT_ABOUT_DESC1)
            g=_G["HealBot_Info_SuppressSounds"] 
            g:SetText(HEALBOT_SUPPRESSSOUND)
            g=_G["HealBot_Info_SuppressErrors"] 
            g:SetText(HEALBOT_SUPPRESSERROR)
            g=_G["HealBot_About_AuthorH"] 
            g:SetText(HEALBOT_ABOUT_AUTHORH)
            g=_G["HealBot_About_AuthorD"] 
            g:SetText(HEALBOT_ABOUT_AUTHORD)
            g=_G["HealBot_About_URLH"] 
            g:SetText(HEALBOT_ABOUT_WEBSITE)
            g=_G["HealBot_About_URLD"] 
            g:SetText(HEALBOT_ABOUT_URL)
            g=_G["HealBot_About_CatH"] 
            g:SetText(HEALBOT_ABOUT_CATH)
            g=_G["HealBot_About_CatD"] 
            g:SetText(HEALBOT_ABOUT_CATD)
            g=_G["HealBot_About_CreditH"] 
            g:SetText(HEALBOT_ABOUT_CREDITH)
            g=_G["HealBot_About_CreditD"] 
            g:SetText(HEALBOT_ABOUT_CREDITD)
            g=_G["HealBot_About_LocalH"] 
            g:SetText(HEALBOT_ABOUT_LOCALH)
            g=_G["HealBot_About_LocalD"] 
            g:SetText(HEALBOT_ABOUT_LOCALD)
            g=_G["HealBot_About_FAQH"] 
            g:SetText(HEALBOT_ABOUT_FAQH)
            g=_G["HealBot_Options_FAQTxt"] 
            g:SetText(HEALBOT_ABOUT_FAQ_QUESTION)
            g=_G["HealBot_Options_FAQAnswerTextH"] 
            g:SetText(HEALBOT_ABOUT_FAQ_ANSWER)
            g=_G["HBIncHealsColHeader1"] 
            g:SetText(HEALBOT_WORD_HEALER)
            g=_G["HBIncHealsColHeader2"] 
            g:SetText(HEALBOT_WORD_VERSION)
            DoneInitTab[801]=true
        end
    elseif subNo==901 then
        if not DoneInitTab[901] then
            HealBot_Options_ImportMethodCDebuff.initialize = HealBot_Options_ImportMethodCDebuff_DropDown
            UIDropDownMenu_SetText(HealBot_Options_ImportMethodCDebuff, HealBot_Import_Methods_List[HealBot_Options_StorePrev["InMethodCDbuff"]])
            HealBot_Options_ImportMethodBuffs.initialize = HealBot_Options_ImportMethodBuffs_DropDown
            UIDropDownMenu_SetText(HealBot_Options_ImportMethodBuffs, HealBot_Import_Methods_List[HealBot_Options_StorePrev["InMethodBuff"]])
            HealBot_Options_ImportMethodSpells.initialize = HealBot_Options_ImportMethodSpells_DropDown
            UIDropDownMenu_SetText(HealBot_Options_ImportMethodSpells, HealBot_Import_Methods_List[HealBot_Options_StorePrev["InMethodSpell"]])
            
        end
    end
end

function HealBot_Options_SetEFGroups()
    local g=nil
    for x=1,8 do
        if Healbot_Config_Skins.IncludeGroup[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]][x] then 
            g=_G["HealBot_Options_EFGroup"..x]
            g:SetChecked(1)
        else
            g=_G["HealBot_Options_EFGroup"..x]
            g:SetChecked(nil)
        end
    end
end

function HealBot_Options_RegAggro()
    local regAggro=false
    for j=1,10 do
        if Healbot_Config_Skins.BarAggro[Healbot_Config_Skins.Current_Skin][j]["SHOW"] then
            regAggro=true
            break
        end
    end
    if regAggro then
        HealBot_Register_Aggro()
    else
        HealBot_UnRegister_Aggro()
    end
end

local HealBot_disabledState=-1
function HealBot_Options_SetSkins(force)
    if hbCurSkin~=Healbot_Config_Skins.Current_Skin or force then
        if hbCurSkin~=Healbot_Config_Skins.Current_Skin then 
            HealBot_Panel_resetInitFrames()
            HealBot_Options_ResetDoInittab(3) 
            HealBot_Options_InitSub(102)
        end
        HealBot_SetSkinColours()
        HealBot_Action_SetHightlightAggroCols()
        HealBot_Action_SetHightlightTargetAggroCols()
        HealBot_Options_SetSkinBars()
        if Healbot_Config_Skins.Current_Skin==HEALBOT_SKINS_STD then
            HealBot_Options_DeleteSkin:Disable();
        else
            HealBot_Options_DeleteSkin:Enable();
        end
        HealBot_Options_Energy()
        HealBot_Options_RegAggro()
        HealBot_Options_RaidTargetUpdate()
        HealBot_Options_CheckReadyCheckEvent()
        HealBot_Options_CheckInHealsEvent()
        hbCurSkin=Healbot_Config_Skins.Current_Skin
    end
    if HealBot_Options:IsVisible() then
        if hbCurSkinSubFrameID==1001 then
            if not DoneInitTab[1001] then
                HealBot_Options_InitSub(303)
                DoneInitTab[1001]=true
            end
        elseif hbCurSkinSubFrameID==1005 then
            if not DoneInitTab[1005] then
                HealBot_Options_InitSub(307)  
                DoneInitTab[1005]=true
            end
        elseif hbCurSkinSubFrameID==1007 then
            if not DoneInitTab[1007] then
                HealBot_Options_InitSub(306)        
                DoneInitTab[1007]=true
            end
        elseif hbCurSkinSubFrameID==1008 then
            if not DoneInitTab[1008] then
                HealBot_Options_InitSub(301)
                DoneInitTab[1008]=true
            end
        elseif hbCurSkinSubFrameID==1009 then
            if not DoneInitTab[1009] then
                HealBot_Options_InitSub(310)
                DoneInitTab[1009]=true
            end
        elseif hbCurSkinSubFrameID==1010 then
            if not DoneInitTab[1010] then
                HealBot_Options_InitSub(309)
                DoneInitTab[1010]=true
            end
        elseif hbCurSkinSubFrameID==1011 then
            if not DoneInitTab[1011] then
                HealBot_Options_InitSub(302)
                HealBot_Options_SetEFGroups()
                DoneInitTab[1011]=true
            end
        elseif hbCurSkinSubFrameID==1014 then
            if not DoneInitTab[1014] then
                HealBot_Options_InitSub(308)
                DoneInitTab[1014]=true  
            end
        end
    end
end

function HealBot_Options_SetcpMacroSave(txtStr)
    HealBot_Options_StorePrev["cpMacroSave"]=txtStr
end

function HealBot_Options_SetSkinBars()
    local btextoutline=Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["OUTLINE"];
    HealBot_HeadBarColorpickt:SetFont(LSM:Fetch('font',Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["FONT"]),
                                       Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HEIGHT"],
                                       HealBot_Font_Outline[Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["OUTLINE"]]);
    HealBot_HeadTextColorpickt:SetFont(LSM:Fetch('font',Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["FONT"]),
                                       Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HEIGHT"],
                                       HealBot_Font_Outline[Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["OUTLINE"]]);
    HealBot_FrameAliasColorpickt:SetFont(LSM:Fetch('font',Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["FONT"]),
                                       Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SIZE"],
                                       HealBot_Font_Outline[Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["OUTLINE"]]);
    HealBot_FrameAliasTextColorpickt:SetFont(LSM:Fetch('font',Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["FONT"]),
                                       Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SIZE"],
                                       HealBot_Font_Outline[Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["OUTLINE"]]);
    HealBot_EnTextColorpickt:SetFont(LSM:Fetch('font',Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["FONT"]),
                                     Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HEIGHT"],
                                     HealBot_Font_Outline[btextoutline]);
    HealBot_DisTextColorpickt:SetFont(LSM:Fetch('font',Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["FONT"]),
                                      Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HEIGHT"],
                                      HealBot_Font_Outline[btextoutline]);
    HealBot_DebTextColorpickt:SetFont(LSM:Fetch('font',Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["FONT"]),
                                      Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HEIGHT"],
                                      HealBot_Font_Outline[btextoutline]);
    HealBot_BarCustomColourt:SetFont(LSM:Fetch('font',Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["FONT"]),
                                     Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HEIGHT"],
                                     HealBot_Font_Outline[btextoutline]);
    HealBot_Options_BarHealthBackColourSt:SetFont(LSM:Fetch('font',Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["FONT"]),
                                          Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HEIGHT"],
                                          HealBot_Font_Outline[btextoutline]);
    HealBot_BarIHCustomColourt:SetFont(LSM:Fetch('font',Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["FONT"]),
                                       Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HEIGHT"],
                                       HealBot_Font_Outline[btextoutline]);
    HealBot_BarAbsorbCustomColourt:SetFont(LSM:Fetch('font',Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["FONT"]),
                                           Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HEIGHT"],
                                           HealBot_Font_Outline[btextoutline]);
    HealBot_DiseaseColorpick:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]));
    HealBot_MagicColorpick:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]));
    HealBot_PoisonColorpick:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]));
    HealBot_CurseColorpick:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]));
    HealBot_CustomColorpick:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]));
    HealBot_BuffCustomColorpick:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]));
    HealBot_PresetColourpick1:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]));
    HealBot_PresetColourpick2:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]));
    HealBot_PresetColourpick3:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]));
    HealBot_PresetColourpick4:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]));
    HealBot_PresetColourpick5:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]));
    HealBot_PresetColourpick6:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]));
    HealBot_PresetColourpick7:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]));
    HealBot_PresetColourpick8:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]));
    HealBot_PresetColourpick9:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]));
    HealBot_PresetColourpick10:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]));
    HealBot_EnTextColorpick:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]));
    HealBot_EnTextColorpickin:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]));
    HealBot_DisTextColorpick:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]));
    HealBot_DebTextColorpick:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]));
    HealBot_HeadBarColorpick:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]));
    HealBot_HeadTextColorpick:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]));
    HealBot_FrameAliasColorpick:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]));
    HealBot_FrameAliasTextColorpick:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]));
    HealBot_Buff1Colour:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]));
    HealBot_Buff2Colour:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]));
    HealBot_Buff3Colour:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]));
    HealBot_Buff4Colour:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]));
    HealBot_Buff5Colour:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]));
    HealBot_Buff6Colour:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]));
    HealBot_Buff7Colour:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]));
    HealBot_Buff8Colour:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]));
    HealBot_BarCustomColour:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]));
    HealBot_Options_BarHealthBackColourS:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]));
    HealBot_BarIHCustomColour:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]));
    HealBot_BarAbsorbCustomColour:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]));
    local g=_G["HealBot_Options_SkinAuthorName"]
    g:SetText(Healbot_Config_Skins.Author[Healbot_Config_Skins.Current_Skin])
    HealBot_DiseaseColorpick:GetStatusBarTexture():SetHorizTile(false)
    HealBot_MagicColorpick:GetStatusBarTexture():SetHorizTile(false)
    HealBot_PoisonColorpick:GetStatusBarTexture():SetHorizTile(false)
    HealBot_CurseColorpick:GetStatusBarTexture():SetHorizTile(false)
    HealBot_CustomColorpick:GetStatusBarTexture():SetHorizTile(false)
    HealBot_BuffCustomColorpick:GetStatusBarTexture():SetHorizTile(false)
    HealBot_PresetColourpick1:GetStatusBarTexture():SetHorizTile(false)
    HealBot_PresetColourpick2:GetStatusBarTexture():SetHorizTile(false)
    HealBot_PresetColourpick3:GetStatusBarTexture():SetHorizTile(false)
    HealBot_PresetColourpick4:GetStatusBarTexture():SetHorizTile(false)
    HealBot_PresetColourpick5:GetStatusBarTexture():SetHorizTile(false)
    HealBot_PresetColourpick6:GetStatusBarTexture():SetHorizTile(false)
    HealBot_PresetColourpick7:GetStatusBarTexture():SetHorizTile(false)
    HealBot_PresetColourpick8:GetStatusBarTexture():SetHorizTile(false)
    HealBot_PresetColourpick9:GetStatusBarTexture():SetHorizTile(false)
    HealBot_PresetColourpick10:GetStatusBarTexture():SetHorizTile(false)
    HealBot_EnTextColorpick:GetStatusBarTexture():SetHorizTile(false)
    HealBot_EnTextColorpickin:GetStatusBarTexture():SetHorizTile(false)
    HealBot_DisTextColorpick:GetStatusBarTexture():SetHorizTile(false)
    HealBot_DebTextColorpick:GetStatusBarTexture():SetHorizTile(false)
    HealBot_HeadBarColorpick:GetStatusBarTexture():SetHorizTile(false)
    HealBot_HeadTextColorpick:GetStatusBarTexture():SetHorizTile(false)
    HealBot_FrameAliasColorpick:GetStatusBarTexture():SetHorizTile(false)
    HealBot_FrameAliasTextColorpick:GetStatusBarTexture():SetHorizTile(false)
    HealBot_Buff1Colour:GetStatusBarTexture():SetHorizTile(false)
    HealBot_Buff2Colour:GetStatusBarTexture():SetHorizTile(false)
    HealBot_Buff3Colour:GetStatusBarTexture():SetHorizTile(false)
    HealBot_Buff4Colour:GetStatusBarTexture():SetHorizTile(false)
    HealBot_Buff5Colour:GetStatusBarTexture():SetHorizTile(false)
    HealBot_Buff6Colour:GetStatusBarTexture():SetHorizTile(false)
    HealBot_Buff7Colour:GetStatusBarTexture():SetHorizTile(false)
    HealBot_Buff8Colour:GetStatusBarTexture():SetHorizTile(false)
    HealBot_BarCustomColour:GetStatusBarTexture():SetHorizTile(false)
    HealBot_Options_BarHealthBackColourS:GetStatusBarTexture():SetHorizTile(false)
    HealBot_BarIHCustomColour:GetStatusBarTexture():SetHorizTile(false)
    HealBot_BarAbsorbCustomColour:GetStatusBarTexture():SetHorizTile(false)
    HealBot_HighlightActiveBarColour:GetStatusBarTexture():SetHorizTile(false)
    HealBot_HighlightTargetBarColour:GetStatusBarTexture():SetHorizTile(false)
    HealBot_Aggro3Colorpick:GetStatusBarTexture():SetHorizTile(false)
    local barScale = HealBot_EnTextColorpick:GetScale();
    HealBot_EnTextColorpick:SetScale(barScale + 0.01);
    HealBot_EnTextColorpick:SetScale(barScale);
    HealBot_DisTextColorpick:SetScale(barScale + 0.01);
    HealBot_DisTextColorpick:SetScale(barScale);
    HealBot_DebTextColorpick:SetScale(barScale + 0.01);
    HealBot_DebTextColorpick:SetScale(barScale);
    HealBot_BarCustomColour:SetScale(barScale + 0.01);
    HealBot_BarCustomColour:SetScale(barScale);
    HealBot_Options_BarHealthBackColourS:SetScale(barScale + 0.01);
    HealBot_Options_BarHealthBackColourS:SetScale(barScale);
    HealBot_BarIHCustomColour:SetScale(barScale + 0.01);
    HealBot_BarIHCustomColour:SetScale(barScale);
    HealBot_BarAbsorbCustomColour:SetScale(barScale + 0.01);
    HealBot_BarAbsorbCustomColour:SetScale(barScale);
    HealBot_Options_framesChanged(0)
end

function HealBot_Options_ShowPanel(self, tabNo, subTabNo)
    local g=nil
    HealBot_Options_PresetColours:Hide()
    if tabNo==0 then
        HealBot_Comms_Print_Supports()
    end
    if HealBot_Options_StorePrev["PrevTabNo"] and HealBot_Options_StorePrev["PrevTabNo"]~=tabNo then
        g=_G["HealBot_Options_Panel"..HealBot_Options_StorePrev["PrevTabNo"]]
        g:Hide();
        g=_G["HealBot_Contents_ButtonT"..HealBot_Options_StorePrev["PrevTabNo"]]
        g:SetStatusBarColor(0.2,0.2,0.2,0)
        g=_G["HealBot_Contents_ButtonT"..HealBot_Options_StorePrev["PrevTabNo"].."Txt"]
        g:SetTextColor(1,1,0,0.9)
    end
    if HealBot_Options_StorePrev["subTabNo3"] then
        g=_G["HealBot_Contents_ButtonT"..HealBot_Options_StorePrev["subTabNo3"].."Txt"]
        g:SetTextColor(1,1,0,0.9)
    end
    if HealBot_Options_StorePrev["subTabNo4"] then
        g=_G["HealBot_Contents_ButtonT"..HealBot_Options_StorePrev["subTabNo4"].."Txt"]
        g:SetTextColor(1,1,0,0.9)
    end
    if HealBot_Options_StorePrev["subTabNo5"] then
        g=_G["HealBot_Contents_ButtonT"..HealBot_Options_StorePrev["subTabNo5"].."Txt"]
        g:SetTextColor(1,1,0,0.9)
    end
    if HealBot_Options_StorePrev["subTabNo9"] then
        g=_G["HealBot_Contents_ButtonT"..HealBot_Options_StorePrev["subTabNo9"].."Txt"]
        g:SetTextColor(1,1,0,0.9)
    end
    if tabNo==3 and not subTabNo and not HealBot_Options_StorePrev["subTabNo3"] then subTabNo=301 end
    if tabNo==4 and not subTabNo and not HealBot_Options_StorePrev["subTabNo4"] then subTabNo=41 end
    if tabNo==5 and not subTabNo and not HealBot_Options_StorePrev["subTabNo5"] then subTabNo=51 end
    if tabNo==9 and not subTabNo and not HealBot_Options_StorePrev["subTabNo5"] then subTabNo=91 end
    HealBot_Options_StorePrev["TabNo"] = tabNo;
    
    if subTabNo then 
        if tabNo==3 then
            HealBot_Options_StorePrev["subTabNo3"]=subTabNo
        elseif tabNo==4 then
            HealBot_Options_StorePrev["subTabNo4"]=subTabNo
        elseif tabNo==5 then
            HealBot_Options_StorePrev["subTabNo5"]=subTabNo
        elseif tabNo==9 then
            HealBot_Options_StorePrev["subTabNo9"]=subTabNo
        end
        if subTabNo==51 then
            HealBot_Options_MonitorBuffsInCombat:Show()
            HealBot_Options_MonitorBuffsWhenGrouped:Show()
            if HealBot_Data["PCLASSTRIM"]==HealBot_Class_En[HEALBOT_PALADIN] and HEALBOT_GAME_VERSION<4 then
                HealBot_Options_MonitorBuffsPalaBlessing:Show()
            else
                HealBot_Options_MonitorBuffsPalaBlessing:Hide()
            end
        elseif subTabNo>51 and subTabNo<54 then
            HealBot_Options_MonitorBuffsInCombat:Hide()
            HealBot_Options_MonitorBuffsWhenGrouped:Hide()
            HealBot_Options_MonitorBuffsPalaBlessing:Hide()
        end
    end;
    
    HealBot_Options_Init(tabNo)
    g=_G["HealBot_Options_Panel"..tabNo]
    g:Show();
    g=_G["HealBot_Contents_ButtonT"..tabNo]
    g:SetStatusBarColor(0.2,0.2,0.2,0.55)
    g=_G["HealBot_Contents_ButtonT"..tabNo.."Txt"]
    g:SetTextColor(1,1,1,1)
    
    if subTabNo and subTabNo>308 and subTabNo<399 then
        g=_G["HealBot_Contents_ButtonT308Txt"]
        g:SetTextColor(1,1,1,1)
    else
        g=_G["HealBot_Contents_ButtonT308Txt"]
        g:SetTextColor(1,1,0,0.9)
    end
    HealBot_Options_StorePrev["PrevTabNo"] = tabNo;
    if subTabNo then
        g=_G["HealBot_Contents_ButtonT"..subTabNo.."Txt"]
        g:SetTextColor(1,1,1,1)
    elseif tabNo==3 then
        if HealBot_Options_StorePrev["subTabNo3"] then
            g=_G["HealBot_Contents_ButtonT"..HealBot_Options_StorePrev["subTabNo3"].."Txt"]
            g:SetTextColor(1,1,1,1)
        else
            g=_G["HealBot_Contents_ButtonT301Txt"]
            g:SetTextColor(1,1,1,1)
        end
    elseif tabNo==4 then
        if HealBot_Options_StorePrev["subTabNo4"] then
            g=_G["HealBot_Contents_ButtonT"..HealBot_Options_StorePrev["subTabNo4"].."Txt"]
            g:SetTextColor(1,1,1,1)
        else
            g=_G["HealBot_Contents_ButtonT41Txt"]
            g:SetTextColor(1,1,1,1)
        end
    elseif tabNo==5 then
        if HealBot_Options_StorePrev["subTabNo5"] then
            g=_G["HealBot_Contents_ButtonT"..HealBot_Options_StorePrev["subTabNo5"].."Txt"]
            g:SetTextColor(1,1,1,1)
        else
            g=_G["HealBot_Contents_ButtonT51Txt"]
            g:SetTextColor(1,1,1,1)
        end
    elseif tabNo==9 then
        if HealBot_Options_StorePrev["subTabNo9"] then
            g=_G["HealBot_Contents_ButtonT"..HealBot_Options_StorePrev["subTabNo9"].."Txt"]
            g:SetTextColor(1,1,1,1)
        else
            g=_G["HealBot_Contents_ButtonT91Txt"]
            g:SetTextColor(1,1,1,1)
        end
    end
end

HealBot_Options_StorePrev["CurrentInOutPanel"]="HealBot_Options_InOut_SkinFrame"
function HealBot_Options_ShowInOutPanel(frameName, hbFrameID)
    local g=_G[HealBot_Options_StorePrev["CurrentInOutPanel"]]
    g:Hide()
    g=_G[frameName]
    g:Show()
    HealBot_Options_StorePrev["CurrentInOutPanel"]=frameName
    if frameName=="HealBot_Options_InOut_SkinFrame" then
        HealBot_Options_ShareSkinStatusf:SetText(HEALBOT_INOUT_STATUS_SKINSINIT)
        HealBot_Options_ShareSkinStatusf:SetTextColor(1,1,1,1)
    elseif frameName=="HealBot_Options_InOut_CDbuffsFrame" then
        HealBot_Options_ShareCDbuffStatusf:SetText(HEALBOT_INOUT_STATUS_CDEBUFFINIT)
        HealBot_Options_ShareCDbuffStatusf:SetTextColor(1,1,1,1)
    elseif frameName=="HealBot_Options_InOut_BuffsFrame" then
        HealBot_Options_ShareBuffsStatusf:SetText(HEALBOT_INOUT_STATUS_BUFFINIT)
        HealBot_Options_ShareBuffsStatusf:SetTextColor(1,1,1,1)
    elseif frameName=="HealBot_Options_InOut_SpellsFrame" then
        HealBot_Options_ShareSpellsStatusf:SetText(HEALBOT_INOUT_STATUS_SPELLINIT)
        HealBot_Options_ShareSpellsStatusf:SetTextColor(1,1,1,1)
    elseif frameName=="HealBot_Options_InOut_PresetColsFrame" then
        HealBot_Options_SharePresetColsStatusf:SetText(HEALBOT_INOUT_STATUS_PRESETCOLINIT)
        HealBot_Options_SharePresetColsStatusf:SetTextColor(1,1,1,1)
    end
end

HealBot_Options_StorePrev["CurrentSkinsPanel"]="HealBot_Options_GeneralSkinsFrame"
function HealBot_Options_ShowSkinsPanel(frameName, hbFrameID)
    hbCurSkinSubFrameID=hbFrameID
    local g=_G[HealBot_Options_StorePrev["CurrentSkinsPanel"]]
    g:Hide()
    g=_G[frameName]
    g:Show()
    HealBot_Options_StorePrev["CurrentSkinsPanel"]=frameName
    HealBot_Options_SetSkins()
    g=_G["HealBot_Options_FramesSelFrame"]
    if hbCurSkinSubFrameID==1008 or hbCurSkinSubFrameID>1009 then
        HealBot_Options_InitSub(102)
        g:Show()
        g=_G["HealBot_Options_ApplyTab2Frames"]
        g:Show()
    else
        g:Hide()
        g=_G["HealBot_Options_ApplyTab2Frames"]
        g:Hide()
    end
end

HealBot_Options_StorePrev["CurrentCurePanel"]="HealBot_Options_CureDispelCleanse"
function HealBot_Options_ShowCurePanel(frameName)
    local g=_G[HealBot_Options_StorePrev["CurrentCurePanel"]]
    g:Hide()
    g=_G[frameName]
    g:Show()
    HealBot_Options_StorePrev["CurrentCurePanel"]=frameName
end

HealBot_Options_StorePrev["CurrentBuffPanel"]="HealBot_Options_BuffsPanel"
function HealBot_Options_ShowBuffPanel(frameName)
    local g=_G[HealBot_Options_StorePrev["CurrentBuffPanel"]]
    g:Hide()
    g=_G[frameName]
    g:Show()
    HealBot_Options_StorePrev["CurrentBuffPanel"]=frameName
end


HealBot_Options_StorePrev["CurrentSkinsHeaderPanel"]="HealBot_Options_SkinsFrameHeadersBar"
HealBot_Options_StorePrev["CurrentSkinsHeaderPanelButton"]="HealBot_Options_SkinsFrameHeadersBarb"
function HealBot_Options_ShowHeaderPanel(frameName, buttonName)
    HealBot_Options_ObjectsShowHide(HealBot_Options_StorePrev["CurrentSkinsHeaderPanel"],false)
    HealBot_Options_ObjectsShowHide(frameName,true)
    HealBot_Options_ButtonHighlight(HealBot_Options_StorePrev["CurrentSkinsHeaderPanelButton"],false)
    HealBot_Options_ButtonHighlight(buttonName,true)
    HealBot_Options_StorePrev["CurrentSkinsHeaderPanel"]=frameName
    HealBot_Options_StorePrev["CurrentSkinsHeaderPanelButton"]=buttonName
end

HealBot_Options_StorePrev["CurrentSkinsIconsPanel"]="HealBot_Options_SkinsFrameIconsGeneral"
HealBot_Options_StorePrev["CurrentSkinsIconsPanelButton"]="HealBot_Options_SkinsFrameIconsGeneralb"
function HealBot_Options_ShowIconPanel(frameName, buttonName)
    HealBot_Options_ObjectsShowHide(HealBot_Options_StorePrev["CurrentSkinsIconsPanel"],false)
    HealBot_Options_ObjectsShowHide(frameName,true)
    HealBot_Options_ButtonHighlight(HealBot_Options_StorePrev["CurrentSkinsIconsPanelButton"],false)
    HealBot_Options_ButtonHighlight(buttonName,true)
    HealBot_Options_StorePrev["CurrentSkinsIconsPanel"]=frameName
    HealBot_Options_StorePrev["CurrentSkinsIconsPanelButton"]=buttonName
end

HealBot_Options_StorePrev["CurrentSkinsBarsPanel"]="HealBot_Options_SkinsFramesBarsGeneral"
HealBot_Options_StorePrev["CurrentSkinsBarsPanelButton"]="HealBot_Options_SkinsFramesBarsGeneralb"
function HealBot_Options_ShowBarsPanel(frameName, buttonName)
    if frameName=="HealBot_Options_SkinsFramesBarsVisibility" then
        if HealBot_Options_StorePrev["FramesSelFrame"]==10 then
            frameName="HealBot_Options_SkinsFramesBarsVisibilityEnemy"
        end
    end
    HealBot_Options_ObjectsShowHide(HealBot_Options_StorePrev["CurrentSkinsBarsPanel"],false)
    HealBot_Options_ObjectsShowHide(frameName,true)
    HealBot_Options_ButtonHighlight(HealBot_Options_StorePrev["CurrentSkinsBarsPanelButton"],false)
    HealBot_Options_ButtonHighlight(buttonName,true)
    HealBot_Options_StorePrev["CurrentSkinsBarsPanel"]=frameName
    HealBot_Options_StorePrev["CurrentSkinsBarsPanelButton"]=buttonName
end

function HealBot_Options_OnMouseDown(self)
    HealBot_StartMoving(self);
end

function HealBot_Options_OnMouseUp(self)
    HealBot_StopMoving(self);
end

function HealBot_Options_OnDragStart(self)
    HealBot_StartMoving(self);
end

function HealBot_Options_OnDragStop(self)
    HealBot_StopMoving(self);
end

function HealBot_Options_DisablePlayerFrame()
    if not InCombatLockdown() then
        HealBot_Options_UnitFrameDisable(PlayerFrame)
    else
        HealBot_setOptions_Timer(180)
    end
end

function HealBot_Options_DisablePetFrame()
    if not InCombatLockdown() then
        HealBot_Options_UnitFrameDisable(PetFrame)
    else
        HealBot_setOptions_Timer(180)
    end
end

function HealBot_Options_DisablePartyFrame()
    if not InCombatLockdown() then
        for x = 1, 4 do
            local f = _G["PartyMemberFrame"..x]
            HealBot_Options_UnitFrameDisable(f)
        end
    else
        HealBot_setOptions_Timer(180)
    end
end

function HealBot_Options_DisableMiniBossFrame()
    if not InCombatLockdown() then
        for x = 1, MAX_BOSS_FRAMES do
            local f = _G["Boss"..x.."TargetFrame"]
            f:Hide()
            f:UnregisterAllEvents()
            f:SetScript("OnShow", function(self) 
                self:Hide();
                self:UnregisterAllEvents()
            end)
        end
    else
        HealBot_setOptions_Timer(185)
    end
end

function HealBot_Options_DisableRaidFrame()
    if Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["HIDERAIDF"] then
        if HealBot_Globals.RaidHideMethod==0 then
            if CompactRaidFrameManager then
                CompactRaidFrameManager:UnregisterAllEvents() 
                CompactRaidFrameContainer:UnregisterAllEvents() 
                if not InCombatLockdown() then
                    CompactRaidFrameManager:Hide() 
                    local shown = CompactRaidFrameManager_GetSetting("IsShown")
                    if( shown and shown ~= "0" ) then
                        CompactRaidFrameManager_SetSetting("IsShown", "0")
                    end
                    CompactRaidFrameManager:SetScript("OnShow", function(self) 
                        if not InCombatLockdown() then
                            self:Hide();
                            self:UnregisterAllEvents()
                        else
                            HealBot_setOptions_Timer(188)
                        end
                    end)
                    CompactRaidFrameContainer:Hide()
                    CompactRaidFrameContainer:SetScript("OnShow", function(self)
                        if not InCombatLockdown() then
                            self:Hide();
                            self:UnregisterAllEvents()
                        else
                            HealBot_setOptions_Timer(188)
                        end
                    end)
                else
                    HealBot_setOptions_Timer(188)
                end
            end
        else
            if not InCombatLockdown() then
                local _, _, _, enabledCRF, _, _, _ = GetAddOnInfo("Blizzard_CompactRaidFrames")
                local _, _, _, enabledCUF, _, _, _ = GetAddOnInfo("Blizzard_CUFProfiles")
                if enabledCRF or enabledCUF then 
                    DisableAddOn("Blizzard_CompactRaidFrames")
                    DisableAddOn("Blizzard_CUFProfiles")
                    HealBot_Globals.RaidHideMethod=2
                    HealBot_Options_ReloadUI(HEALBOT_OPTIONS_HIDERAIDFRAMES.." - "..HEALBOT_WORD_ON)
                end
            else
                HealBot_setOptions_Timer(188)
            end
        end
    else
        HealBot_setOptions_Timer(188)
    end
end

function HealBot_Options_DisableTargetFrame()
    if not InCombatLockdown() then
        HealBot_Options_UnitFrameDisable(TargetFrame)
    else
        HealBot_setOptions_Timer(180)
    end
end

function HealBot_Options_UnitFrameDisable(f)
    UnregisterUnitWatch(f)
    f:UnregisterAllEvents()
    f:Hide()
    f:ClearAllPoints()
    f:SetPoint("BOTTOMLEFT", UIParent, "TOPLEFT", -500, 500)
    local HealthBar = _G[f:GetName().."HealthBar"]
    if HealthBar then
        HealthBar:UnregisterAllEvents()
    end
    local ManaBar = _G[f:GetName().."ManaBar"]
    if ManaBar then
        ManaBar:UnregisterAllEvents()
    end
    local ToTFrame=_G[f:GetName().."ToT"]
    if ToTFrame then
        ToTFrame:UnregisterAllEvents()
        ToTFrame:Hide()
        ToTFrame:ClearAllPoints()
        ToTFrame:SetPoint("BOTTOMLEFT", UIParent, "TOPLEFT", -500, 500)
    end
end

function HealBot_Options_SetSliderValue(slider,value,updating)
    updatingMedia = updating
    slider:SetValue(-1) -- Pre change value so that text gets updated if value does not change but media does
    updatingMedia = updating
    slider:SetValue(value or 0)
end

function HealBot_Options_UpdateMedia(panel)
    if panel == 3 then
        hb_textures = LSM:List('statusbar');
        for x,_ in pairs(texturesIndex) do
            texturesIndex[x]=nil
        end 
        for i=1,#hb_textures do
            texturesIndex[hb_textures[i]] = i
        end
        fonts = LSM:List('font');
        for x,_ in pairs(fontsIndex) do
            fontsIndex[x]=nil
        end 
        for i=1,#fonts do
            fontsIndex[fonts[i]] = i
        end
        HealBot_Options_val_OnLoad(HealBot_Options_HeadTextureS,HEALBOT_OPTIONS_SKINTEXTURE,1,#hb_textures,1)
        HealBot_Options_val_OnLoad(HealBot_Options_SkinFrameAliasTextureS,HEALBOT_OPTIONS_SKINTEXTURE,1,#hb_textures,1)
        HealBot_Options_val_OnLoad(HealBot_Options_HeadFontNameS,HEALBOT_OPTIONS_SKINFONT,1,#fonts,1)
        HealBot_Options_val_OnLoad(HealBot_Options_AliasFontName,HEALBOT_OPTIONS_SKINFONT,1,#fonts,1)            
        HealBot_Options_val_OnLoad(HealBot_BarButtonIconFont,HEALBOT_OPTIONS_SKINFONT,1,#fonts,1)
        HealBot_Options_SetSliderValue(HealBot_BarButtonIconFont,fontsIndex[Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["FONT"]],true)
        HealBot_Options_SetSliderValue(HealBot_Options_HeadTextureS,texturesIndex[Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]],true)
        HealBot_Options_SetSliderValue(HealBot_Options_HeadFontNameS,fontsIndex[Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["FONT"]],true)
        HealBot_Options_SetSliderValue(HealBot_Options_SkinFrameAliasTextureS,texturesIndex[Healbot_Config_Skins.FrameAliasBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]],true)
        HealBot_Options_SetSliderValue(HealBot_Options_AliasFontName,fontsIndex[Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["FONT"]],true)
        HealBot_Options_val_OnLoad(HealBot_Options_BarTextureS,HEALBOT_OPTIONS_SKINTEXTURE,1,#hb_textures,1)
        HealBot_Options_val_OnLoad(HealBot_Options_FontName,HEALBOT_OPTIONS_SKINFONT,1,#fonts,1)
        HealBot_Options_SetSliderValue(HealBot_Options_BarTextureS,texturesIndex[Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]],true)
        HealBot_Options_SetSliderValue(HealBot_Options_FontName,fontsIndex[Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["FONT"]],true)
    elseif panel == 4 or panel == 5 then
        sounds = LSM:List('sound');
        for x,_ in pairs(soundsIndex) do
            soundsIndex[x]=nil
        end 
        for i=1,#sounds do
            soundsIndex[sounds[i]] = i
        end
        HealBot_Options_val_OnLoad(HealBot_Options_WarningSound,HEALBOT_OPTIONS_SOUND,1,#sounds,1)
        HealBot_Options_SetSliderValue(HealBot_Options_WarningSound,soundsIndex[HealBot_Config_Cures.SoundDebuffPlay],true)
        HealBot_Options_val_OnLoad(HealBot_Options_BuffWarningSound,HEALBOT_OPTIONS_SOUND,1,#sounds,1)
        HealBot_Options_SetSliderValue(HealBot_Options_BuffWarningSound,soundsIndex[HealBot_Config_Buffs.SoundBuffPlay],true)
    end
end

function HealBot_UpdateUsedMedia(event, mediatype, key)
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
                local bar = _G["HealBot_Action_HealUnit"..xButton.id.."Bar"]
                local bar2 = _G["HealBot_Action_HealUnit"..xButton.id.."Bar2"]
                local bar3 = _G["HealBot_Action_HealUnit"..xButton.id.."Bar3"]
                local bar6 = _G["HealBot_Action_HealUnit"..xButton.id.."Bar6"]
                if bar then
                    bar:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][xButton.frame]["TEXTURE"]));
                    bar2:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][xButton.frame]["TEXTURE"]));
                    bar3:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][xButton.frame]["TEXTURE"]));
                    bar6:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][xButton.frame]["TEXTURE"]));
                    bar:GetStatusBarTexture():SetHorizTile(false)
                    bar2:GetStatusBarTexture():SetHorizTile(false)
                    bar3:GetStatusBarTexture():SetHorizTile(false)
                    bar6:GetStatusBarTexture():SetHorizTile(false)
                end
            end 
            for _,xButton in pairs(HealBot_Enemy_Button) do
                local bar = _G["HealBot_Action_HealUnit"..xButton.id.."Bar"]
                local bar2 = _G["HealBot_Action_HealUnit"..xButton.id.."Bar2"]
                local bar3 = _G["HealBot_Action_HealUnit"..xButton.id.."Bar3"]
                local bar6 = _G["HealBot_Action_HealUnit"..xButton.id.."Bar6"]
                if bar then
                    bar:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][xButton.frame]["TEXTURE"]));
                    bar2:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][xButton.frame]["TEXTURE"]));
                    bar3:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][xButton.frame]["TEXTURE"]));
                    bar6:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][xButton.frame]["TEXTURE"]));
                    bar:GetStatusBarTexture():SetHorizTile(false)
                    bar2:GetStatusBarTexture():SetHorizTile(false)
                    bar3:GetStatusBarTexture():SetHorizTile(false)
                    bar6:GetStatusBarTexture():SetHorizTile(false)
                end
            end 
        end
    elseif mediatype == "font" then
        if Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin] then
            local hFrames=HealBot_Panel_retHealBot_Header_Frames()
            for _,h in pairs(hFrames) do
                if h["GetName"] then
                    local bar = _G[h:GetName().."Bar"]
                    if bar then
                        bar.txt = _G[bar:GetName().."_text"];
                        bar.txt:SetFont(LSM:Fetch('font',Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][h.frame]["FONT"]),
                                        Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][h.frame]["HEIGHT"],
                                        HealBot_Font_Outline[Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][h.frame]["OUTLINE"]]);
                    end
                end
            end
        end
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin] then
            for _,xButton in pairs(HealBot_Unit_Button) do
                local bar = _G["HealBot_Action_HealUnit"..xButton.id.."Bar"]
                if bar then
                    bar.txt = _G[bar:GetName().."_text"];
                    bar.txt:SetFont(LSM:Fetch('font',Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][xButton.frame]["FONT"]),
                                    Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][xButton.frame]["HEIGHT"],
                                    HealBot_Font_Outline[Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][xButton.frame]["OUTLINE"]]);
                end
            end   
            for _,xButton in pairs(HealBot_Enemy_Button) do
                local bar = _G["HealBot_Action_HealUnit"..xButton.id.."Bar"]
                if bar then
                    bar.txt = _G[bar:GetName().."_text"];
                    bar.txt:SetFont(LSM:Fetch('font',Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][xButton.frame]["FONT"]),
                                    Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][xButton.frame]["HEIGHT"],
                                    HealBot_Font_Outline[Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][xButton.frame]["OUTLINE"]]);
                end
            end 
        end
    end
end

function HealBot_Options_Show_Help(index,show)
    if HealBot_Data["TIPUSE"] then
        if show then
            HealBot_Tooltip_OptionsHelp(HEALBOT_OPTIONS_HELP_TITLES[index],HEALBOT_OPTIONS_HELP_TEXT[index])
        else
            HealBot_Tooltip_OptionsHide()
        end
    end
end