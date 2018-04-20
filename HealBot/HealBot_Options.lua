local HealBot_Options_ComboButtons_Button=1;
local HealBot_Options_Opened=false;
local HealBot_Options_SoftReset_flag=false;
local HealBot_buffbarcolr = {};
local HealBot_buffbarcolg = {};
local HealBot_buffbarcolb = {};
local HealBot_Skins = {};
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
local HealBot_EmergInc = {}

local HealBot_Options_Class_HoTctlName_List={}
local HealBot_CDebuffCasyBy_List={}
local HealBot_CDebuffCasyBy_Indexed_List={}
local HealBot_CDebuffCat_List={}
local HealBot_Debuff_RangeWarning_List={}
local HealBot_Debuff_Item_List={}
local HealBot_Options_TooltipPos_List={}
local HealBot_Options_EmergencyFilter_List={}
local HealBot_Options_AggroIndAlertLevel_List={}
local HealBot_Options_AggroAlertLevel_List={}
local HealBot_Options_SkinDefault_List={}
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
local HealBot_Options_ExtraSubSort_List={}
local HealBot_Options_ExtraSort_List={}
local HealBot_Options_EmergencyFClass_List={}
local HealBot_Options_hbCommands_List={}
local HealBot_Options_hbProfile_List={}
local HealBot_Options_hbLangs_List={}
local HealBot_Options_MouseWheel_List={}
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

HealBot_Options_StorePrev["FramesSelFrame"]=1
HealBot_Options_StorePrev["customDebuffPriority"]=10

local HealBot_Debuff_Types = {}
local HealBot_Buff_Items_List = {}

function HealBot_Options_InitVars()
    HealBot_Buff_Items_List = {
        HEALBOT_ORALIUS_WHISPERING_CRYSTAL,
        HEALBOT_EVER_BLOOMING_FROND,
        HEALBOT_REPURPOSED_FEL_FOCUSER,
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
function HealBot_Options_setLists()
    
    HealBot_Options_setClassEn()

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
        HEALBOT_SORTBY_NAME,
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
        HEALBOT_OPTIONS_BARHEALTHINCALL,
        HEALBOT_OPTIONS_BARHEALTHSEPALL,
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
    
    HealBot_Options_TestBarsProfile_List ={
        HEALBOT_WORD_PARTY,
        HEALBOT_OPTIONS_EMERGENCYHEALS.." 10",
        HEALBOT_OPTIONS_EMERGENCYHEALS.." 25",
        HEALBOT_OPTIONS_EMERGENCYHEALS.." 40",
    }

    HealBot_Options_MouseWheel_List = {
        HEALBOT_WORDS_NONE,
        HEALBOT_BLIZZARD_MENU,
        HEALBOT_HB_MENU,
        HEALBOT_FOLLOW,
        HEALBOT_TRADE,
        HEALBOT_PROMOTE_RA,
        HEALBOT_DEMOTE_RA,
        HEALBOT_TOGGLE_ENABLED,
        HEALBOT_TOGGLE_MYTARGETS,
        HEALBOT_TOGGLE_PRIVATETANKS,
        HEALBOT_RESET_BAR,
        HEALBOT_RANDOMMOUNT,
        HEALBOT_RANDOMGOUNDMOUNT,
        HEALBOT_RANDOMPET,
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
        HEALBOT_CMD_DELCUSTOMDEBUFF9,
        HEALBOT_CMD_DELCUSTOMDEBUFF10,
        HEALBOT_CMD_DELCUSTOMDEBUFF11,
        HEALBOT_CMD_DELCUSTOMDEBUFF12,
        HEALBOT_CMD_RESETBARS,
        HEALBOT_CMD_RESETBUFFS,
        HEALBOT_CMD_RESETCURES,
        HEALBOT_CMD_RESETCUSTOMDEBUFFS,
        HEALBOT_CMD_RESETSKINS,
        HEALBOT_CMD_RESETSPELLS,
        HEALBOT_CMD_TOGGLEACCEPTSKINS,
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

    HealBot_Options_ExtraSort_List = {
        HEALBOT_SORTBY_NAME,
        HEALBOT_SORTBY_CLASS,
        HEALBOT_SORTBY_GROUP,
        HEALBOT_SORTBY_MAXHEALTH,
        HEALBOT_WORDS_NONE,
    }

    HealBot_Options_ExtraSubSort_List = {
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

    HealBot_Options_Class_HoTctlAction_List = {
        HEALBOT_WORD_NEVER,
        HEALBOT_OPTIONS_SELFCASTS,
        HEALBOT_OPTIONS_MYCLASS,
        HEALBOT_WORD_ALWAYS,
    }

    HealBot_Options_SkinDefault_List = {
        HEALBOT_WORDS_NONE,
        HEALBOT_WORD_SOLO,
        HEALBOT_WORD_PARTY,
        HEALBOT_OPTIONS_EMERGENCYHEALS.." 10",
        HEALBOT_OPTIONS_EMERGENCYHEALS.." 25",
        HEALBOT_OPTIONS_EMERGENCYHEALS.." 40",
        HEALBOT_WORD_ARENA,
        HEALBOT_WORD_BATTLEGROUND.." 10",
        HEALBOT_WORD_BATTLEGROUND.." 15",
        HEALBOT_WORD_BATTLEGROUND.." 40",
        HEALBOT_WORD_PETBATTLE,
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
    
     HealBot_Options_Class_HoTctlName_List = {
        --All
        [HEALBOT_DARKFLIGHT]=HEALBOT_CLASSES_ALL,
        [HEALBOT_GIFT_OF_THE_NAARU]=HEALBOT_CLASSES_ALL,
        [HEALBOT_STONEFORM]=HEALBOT_CLASSES_ALL, 
        [HEALBOT_SHROUD_OF_THE_NAGLFAR]=HEALBOT_CLASSES_ALL,
        [HEALBOT_SPIRIT_FRAGMENT]=HEALBOT_CLASSES_ALL,
        [HEALBOT_NORGANNONS_FORESIGHT]=HEALBOT_CLASSES_ALL,
        [HEALBOT_VELENS_FUTURE_SIGHT]=HEALBOT_CLASSES_ALL,
        [HEALBOT_SEPHUZS_SECRET]=HEALBOT_CLASSES_ALL,
        [HEALBOT_DELICIOUS_CAKE]=HEALBOT_CLASSES_ALL,
        [HEALBOT_GUIDING_HAND]=HEALBOT_CLASSES_ALL,
        [HEALBOT_FRUITFUL_MACHINATIONS]=HEALBOT_CLASSES_ALL,
        [HEALBOT_OCEANS_EMBRACE]=HEALBOT_CLASSES_ALL,
        --[HEALBOT_AOF_INFUSION_OF_LIGHT]=HEALBOT_CLASSES_ALL,
        [HEALBOT_CONCORDANCE_OF_THE_LEGIONFALL]=HEALBOT_CLASSES_ALL,
        
        --Death Knight
        [HEALBOT_ICEBOUND_FORTITUDE]=HEALBOT_DEATHKNIGHT,
        [HEALBOT_SHROUD_OF_PURGATORY]=HEALBOT_DEATHKNIGHT,
        [HEALBOT_ANTIMAGIC_SHELL]=HEALBOT_DEATHKNIGHT,
        [HEALBOT_ARMY_OF_THE_DEAD]=HEALBOT_DEATHKNIGHT,
        [HEALBOT_LICHBORNE]=HEALBOT_DEATHKNIGHT,
        [HEALBOT_ANTIMAGIC_ZONE]=HEALBOT_DEATHKNIGHT,
        [HEALBOT_VAMPIRIC_BLOOD]=HEALBOT_DEATHKNIGHT,
        [HEALBOT_DANCING_RUNE_WEAPON]=HEALBOT_DEATHKNIGHT,
        
        --Demon Hunter
        [HEALBOT_DEMON_SPIKES]=HEALBOT_DEMONHUNTER,
        [HEALBOT_BLUR]=HEALBOT_DEMONHUNTER,
        [HEALBOT_EMPOWER_WARDS]=HEALBOT_DEMONHUNTER,
        [HEALBOT_METAMORPHOSIS]=HEALBOT_DEMONHUNTER,
        
        --Druid
        [HEALBOT_LIFEBLOOM]=HEALBOT_DRUID,
        [HEALBOT_REGROWTH]=HEALBOT_DRUID,
        [HEALBOT_REJUVENATION]=HEALBOT_DRUID,
        [HEALBOT_LIVING_SEED]=HEALBOT_DRUID,
        [HEALBOT_CENARION_WARD]=HEALBOT_DRUID,
        [HEALBOT_TRANQUILITY]=HEALBOT_DRUID,
        [HEALBOT_WILD_GROWTH]=HEALBOT_DRUID,
        [HEALBOT_BARKSKIN]=HEALBOT_DRUID,
        [HEALBOT_IRONBARK]=HEALBOT_DRUID,
        [HEALBOT_IRONFUR]=HEALBOT_DRUID,
        [HEALBOT_SURVIVAL_INSTINCTS]=HEALBOT_DRUID,
        [HEALBOT_FRENZIED_REGEN]=HEALBOT_DRUID,
        [HEALBOT_DRUID_CLEARCASTING]=HEALBOT_DRUID,
        --WoD Added
        [HEALBOT_NATURE_REJUVENATION_GERMINATION]=HEALBOT_DRUID, 
		--Legion Added
		[HEALBOT_SPRING_BLOSSOMS]=HEALBOT_DRUID,               
		[HEALBOT_CULTIVATION]=HEALBOT_DRUID,
        [HEALBOT_HARMONY]=HEALBOT_DRUID,
        [HEALBOT_INNERVATE]=HEALBOT_DRUID,
        [HEALBOT_ESSENCE_OF_GHANIR]=HEALBOT_DRUID,
		[HEALBOT_FOCUSED_GROWTH]=HEALBOT_DRUID,
        
        --Hunter
        [HEALBOT_MENDPET]=HEALBOT_HUNTER,
        [HEALBOT_DETERRENCE]=HEALBOT_HUNTER,
        
        --Mage
        [HEALBOT_EVOCATION]=HEALBOT_MAGE,
        [HEALBOT_TEMPORAL_SHIELD]=HEALBOT_MAGE,
        [HEALBOT_ICE_BARRIER]=HEALBOT_MAGE,
        [HEALBOT_INCANTERS_WARD]=HEALBOT_MAGE,
        [HEALBOT_ICE_BLOCK]=HEALBOT_MAGE,
        
        --Monk
        [HEALBOT_ENVELOPING_MIST]=HEALBOT_MONK,
        [HEALBOT_ZEN_SPHERE]=HEALBOT_MONK,
        [HEALBOT_LIFE_COCOON]=HEALBOT_MONK,
        [HEALBOT_THUNDER_FOCUS_TEA]=HEALBOT_MONK,
        [HEALBOT_ZEN_MEDITATION]=HEALBOT_MONK,
        [HEALBOT_SOOTHING_MIST]=HEALBOT_MONK,
        [HEALBOT_RENEWING_MIST]=HEALBOT_MONK,
        [HEALBOT_ELUSIVE_BREW]=HEALBOT_MONK,
        [HEALBOT_FORTIFYING_BREW]=HEALBOT_MONK,
        [HEALBOT_DAMPEN_HARM]=HEALBOT_MONK,
        [HEALBOT_DIFFUSE_MAGIC]=HEALBOT_MONK,
        [HEALBOT_EXTEND_LIFE]=HEALBOT_MONK,
        [HEALBOT_TOUCH_OF_KARMA]=HEALBOT_MONK,
		--Legion Added
        [HEALBOT_ESSENCE_FONT]=HEALBOT_MONK,
        
        --Paladin
        [HEALBOT_DIVINE_SHIELD]=HEALBOT_PALADIN,
        [HEALBOT_HAND_OF_SACRIFICE]=HEALBOT_PALADIN,
        [HEALBOT_INFUSION_OF_LIGHT]=HEALBOT_PALADIN,
        [HEALBOT_SPEED_OF_LIGHT]=HEALBOT_PALADIN,
        [HEALBOT_ETERNAL_FLAME]=HEALBOT_PALADIN,
        [HEALBOT_ARDENT_DEFENDER]=HEALBOT_PALADIN,
        [HEALBOT_BEACON_OF_LIGHT]=HEALBOT_PALADIN,
        [HEALBOT_HAND_OF_PROTECTION]=HEALBOT_PALADIN,
        [HEALBOT_FLASH_OF_LIGHT]=HEALBOT_PALADIN,
        [HEALBOT_LIGHT_BEACON]=HEALBOT_PALADIN,
        [HEALBOT_GUARDED_BY_THE_LIGHT]=HEALBOT_PALADIN,
        [HEALBOT_GUARDIAN_ANCIENT_KINGS]=HEALBOT_PALADIN,
        [HEALBOT_HAND_OF_FREEDOM]=HEALBOT_PALADIN,
        [HEALBOT_DIVINE_PROTECTION]=HEALBOT_PALADIN,
        --WoD Added
        [HEALBOT_BEACON_OF_FAITH]=HEALBOT_PALADIN,                               
		--Legion Added
		[HEALBOT_BLESSING_OF_SACRIFICE]=HEALBOT_PALADIN,
		[HEALBOT_BESTOW_FAITH]=HEALBOT_PALADIN,
        [HEALBOT_BEACON_OF_VIRTUE]=HEALBOT_PALADIN,
        [HEALBOT_TYRS_DELIVERANCE]=HEALBOT_PALADIN,
		[HEALBOT_SACRED_DAWN]=HEALBOT_PALADIN,
        [HEALBOT_LIGHTS_GRACE]=HEALBOT_PALADIN,
        
        --Priest        
        [HEALBOT_PRAYER_OF_MENDING]=HEALBOT_PRIEST,
        [HEALBOT_RENEW]=HEALBOT_PRIEST,
        [HEALBOT_DIVINE_HYMN]=HEALBOT_PRIEST,
        [HEALBOT_SERENDIPITY]=HEALBOT_PRIEST,
        [HEALBOT_TWIST_OF_FATE]=HEALBOT_PRIEST,
        [HEALBOT_GUARDIAN_SPIRIT]=HEALBOT_PRIEST,
        [HEALBOT_PAIN_SUPPRESSION]=HEALBOT_PRIEST,
        [HEALBOT_POWER_INFUSION]=HEALBOT_PRIEST,
        [HEALBOT_POWER_WORD_SHIELD]=HEALBOT_PRIEST,
        [HEALBOT_SPIRIT_SHELL]=HEALBOT_PRIEST,
        [HEALBOT_POWER_WORD_BARRIER]=HEALBOT_PRIEST,
        [HEALBOT_ECHO_OF_LIGHT]=HEALBOT_PRIEST,
        [HEALBOT_LEVITATE]=HEALBOT_PRIEST,
        [HEALBOT_DISPERSION]=HEALBOT_PRIEST,
        [HEALBOT_VAMPIRIC_EMBRACE]=HEALBOT_PRIEST,
        --WoD Added            
        [HEALBOT_SURGE_OF_DARKNESS]=HEALBOT_PRIEST,               
        [HEALBOT_SURGE_OF_LIGHT]=HEALBOT_PRIEST,                                         	
        [HEALBOT_CLARITY_OF_WILL]=HEALBOT_PRIEST,                                   
		--Legion Added
		[HEALBOT_RAPTURE]=HEALBOT_PRIEST, --Disc                        
		[HEALBOT_ATONEMENT]=HEALBOT_PRIEST,                                
		[HEALBOT_APOTHEOSIS]=HEALBOT_PRIEST, --Holy                      
		[HEALBOT_DIVINITY]=HEALBOT_PRIEST,                      
		[HEALBOT_SYMBOL_OF_HOPE]=HEALBOT_PRIEST,                  	
		[HEALBOT_BODY_AND_MIND]=HEALBOT_PRIEST, 	
        [HEALBOT_SUNDERING_SOUL]=HEALBOT_PRIEST,
        [HEALBOT_FOCUSED_WILL]=HEALBOT_PRIEST,
        [HEALBOT_LIGHT_OF_TUURE]=HEALBOT_PRIEST,
        [HEALBOT_BLESSING_OF_TUURE]=HEALBOT_PRIEST,
        [HEALBOT_POWER_OF_THE_NAARU]=HEALBOT_PRIEST,
        [HEALBOT_POWER_OF_THE_DARK_SIDE]=HEALBOT_PRIEST,
        [HEALBOT_ANGELIC_FEATHER]=HEALBOT_PRIEST,
        [HEALBOT_ALMAIESH_THE_CORD_OF_HOPE]=HEALBOT_PRIEST,
        [HEALBOT_VESTMANTS_OF_DISCIPLINE]=HEALBOT_PRIEST,
        [HEALBOT_RAMMALS_ULTERIOR_MOTIVE]=HEALBOT_PRIEST,
		[HEALBOT_SPIRIT_OF_REDEMPTION]=HEALBOT_PRIEST,
		[HEALBOT_RAY_OF_HOPE]=HEALBOT_PRIEST,
		
		--Rogue
        [HEALBOT_VANISH]=HEALBOT_ROGUE,
        [HEALBOT_EVASION]=HEALBOT_ROGUE,
        [HEALBOT_FEINT]=HEALBOT_ROGUE,
        [HEALBOT_CLOAK_OF_SHADOWS]=HEALBOT_ROGUE,
        
        --Shaman
        [HEALBOT_RIPTIDE]=HEALBOT_SHAMAN,
        [HEALBOT_SPIRITWALKERS_GRACE]=HEALBOT_SHAMAN,
        [HEALBOT_UNLEASH_LIFE]=HEALBOT_SHAMAN,
        [HEALBOT_ASTRAL_SHIFT]=HEALBOT_SHAMAN,
        [HEALBOT_ELEMENTAL_MASTERY]=HEALBOT_SHAMAN,
        [HEALBOT_FLAMETONGUE]=HEALBOT_SHAMAN,
        [HEALBOT_FROSTBRAND]=HEALBOT_SHAMAN,
        [HEALBOT_HEALING_RAIN]=HEALBOT_SHAMAN,
        [HEALBOT_ASCENDANCE]=HEALBOT_SHAMAN,
        [HEALBOT_ANACESTRAL_GUIDANCE]=HEALBOT_SHAMAN,
        [HEALBOT_TIDAL_WAVES]=HEALBOT_SHAMAN,
        --WoD Added
        [HEALBOT_CLOUDBURST_TOTEM]=HEALBOT_SHAMAN,
        --Legion Added
		
		--Warlock
        [HEALBOT_UNENDING_RESOLVE]=HEALBOT_WARLOCK,
        
        --Warrior
        [HEALBOT_VIGILANCE]=HEALBOT_WARRIOR,
        [HEALBOT_LAST_STAND]=HEALBOT_WARRIOR,
        [HEALBOT_SHIELD_WALL]=HEALBOT_WARRIOR,
    }
    
    HealBot_Options_FrameAliasList()
    HealBot_Options_setCDebuffCasyBy()
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
    HealBot_Options_InitSub(419)
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
    if Healbot_Config_Skins.FrameAlias and Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin] then
        HealBot_Options_HealGroupsFrame_List = {
            Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][1]["ALIAS"] or HEALBOT_OPTIONS_FRAME.." 1",
            Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][2]["ALIAS"] or HEALBOT_OPTIONS_FRAME.." 2",
            Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][3]["ALIAS"] or HEALBOT_OPTIONS_FRAME.." 3",
            Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][4]["ALIAS"] or HEALBOT_OPTIONS_FRAME.." 4",
            Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][5]["ALIAS"] or HEALBOT_OPTIONS_FRAME.." 5",
            Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][6]["ALIAS"] or HEALBOT_OPTIONS_FRAME.." 6",
            Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][7]["ALIAS"] or HEALBOT_OPTIONS_FRAME.." 7",
            Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][8]["ALIAS"] or HEALBOT_OPTIONS_FRAME.." 8",
            Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][9]["ALIAS"] or HEALBOT_OPTIONS_FRAME.." 9",
            Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][10]["ALIAS"] or HEALBOT_OPTIONS_FRAME.." 10",
        }
    else
        HealBot_Options_HealGroupsFrame_List = {
            HEALBOT_OPTIONS_FRAME.." 1",
            HEALBOT_OPTIONS_FRAME.." 2",
            HEALBOT_OPTIONS_FRAME.." 3",
            HEALBOT_OPTIONS_FRAME.." 4",
            HEALBOT_OPTIONS_FRAME.." 5",
            HEALBOT_OPTIONS_FRAME.." 6",
            HEALBOT_OPTIONS_FRAME.." 7",
            HEALBOT_OPTIONS_FRAME.." 8",
            HEALBOT_OPTIONS_FRAME.." 9",
            HEALBOT_OPTIONS_FRAME.." 10",
        }
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
            HEALBOT_BARKSKIN,
            HEALBOT_IRONBARK,
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
            HEALBOT_DALARAN_BRILLIANCE,
            HEALBOT_MAGE_WARD,
            HEALBOT_FOCUS_MAGIC,
            HEALBOT_ICE_WARD,
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
            HEALBOT_BLESSING_OF_KINGS,
            HEALBOT_BLESSING_OF_WISDOM,
            HEALBOT_HAND_OF_FREEDOM,
            HEALBOT_HAND_OF_PROTECTION,
            HEALBOT_HAND_OF_SACRIFICE,
            HEALBOT_HAND_OF_SALVATION,
            HEALBOT_RIGHTEOUS_FURY,
            HEALBOT_DEVOTION_AURA,
            HEALBOT_BEACON_OF_LIGHT,
            HEALBOT_BEACON_OF_VIRTUE,
            HEALBOT_SEAL_OF_RIGHTEOUSNESS,
            HEALBOT_SEAL_OF_INSIGHT,
            HEALBOT_SEAL_OF_COMMAND,
            HEALBOT_SEAL_OF_TRUTH,
            HEALBOT_SACRED_SHIELD,
        }
        local i = GetSpecialization()
        local specID = 0
        if i then specID = GetSpecializationInfo(i,false,false) end
        if specID==70 then
            table.insert(HealBot_Buff_Spells_Class_List,HEALBOT_SEAL_OF_JUSTICE)
        end
    elseif tClass=="PRIE" then
        HealBot_Buff_Spells_Class_List = {
            HEALBOT_POWER_WORD_FORTITUDE,
            HEALBOT_FEAR_WARD,
            HEALBOT_SHADOWFORM,
            HEALBOT_LEVITATE,
        }
    elseif tClass=="ROGU" then
        HealBot_Buff_Spells_Class_List = {
        }
    elseif tClass=="SHAM" then
        HealBot_Buff_Spells_Class_List = {
            HEALBOT_LIGHTNING_SHIELD,
            HEALBOT_EARTH_SHIELD,
            HEALBOT_WATER_SHIELD,
            HEALBOT_WATER_WALKING,
        }
    elseif tClass=="WARL" then
        HealBot_Buff_Spells_Class_List = {
            HEALBOT_DEMON_ARMOR,
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

function HealBot_Options_InitBuffList()
    table.sort(HealBot_Buff_Items_List)
    HealBot_Buff_Spells_List ={}
    for j=1, getn(HealBot_Buff_Spells_Class_List), 1 do
        local spellName=HealBot_Buff_Spells_Class_List[j]
        if HealBot_GetSpellId(spellName) then   
            table.insert(HealBot_Buff_Spells_List,spellName)
        end
    end
    for j=1, getn(HealBot_Buff_Items_List), 1 do
        local itemName=HealBot_Buff_Items_List[j]
        if IsUsableItem(itemName) or HealBot_IsItemInBag(itemName) then   
            table.insert(HealBot_Buff_Spells_List,itemName)
        end
    end
end

function HealBot_Options_GetDebuffSpells_List(class)
    local HealBot_Debuff_Spells = {
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
    --if (strsub(GetLocale(),1,2)~="en") then
    --    HealBot_Debuff_Spells["SHAM"] = {HEALBOT_CLEANSE_SPIRIT}
    --end
    return HealBot_Debuff_Spells[class]
end

function HealBot_Options_GetRacialDebuffSpells_List(race)
    local HealBot_Racial_Debuff_Spells = {
      ["Hum"] = {},
      ["Dwa"] = {HEALBOT_STONEFORM,},
      ["Nig"] = {},
      ["Gno"] = {},
      ["Dra"] = {HEALBOT_GIFT_OF_THE_NAARU,},
      ["Pan"] = {},
      ["Orc"] = {},
      ["Sco"] = {}, -- Undead
      ["Tau"] = {},
      ["Tro"] = {}, 
      ["Blo"] = {},
      ["Gob"] = {},
      ["Wor"] = {HEALBOT_DARKFLIGHT,},
      ["Hig"] = {}, -- Highmountain Tauren
      ["Voi"] = {}, -- Void Elf
    }
    return HealBot_Racial_Debuff_Spells[race]
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

function HealBot_Options_retIsDebuffSpell(spellName)
    if HealBot_Debuff_Types[spellName] then
        return true
    end
    return nil
end

function HealBot_Options_retDebuffWatchTarget(debuffType, hbGUID)
    if HealBot_DebuffSpell[debuffType] and HealBot_Config.HealBot_BuffWatchGUID[HealBot_DebuffSpell[debuffType]] then
        return HealBot_DebuffWatchTarget[debuffType], HealBot_Config.HealBot_BuffWatchGUID[HealBot_DebuffSpell[debuffType]][hbGUID]
    else
        return HealBot_DebuffWatchTarget[debuffType], nil
    end
end

function HealBot_Options_retDebuffCureSpell(debuffType)
    return HealBot_DebuffSpell[debuffType]
end

function HealBot_Options_retDebuffWatchTargetCD(debuffType)
    if HealBot_DebuffSpell[debuffType] then
        local z, x, _ = GetSpellCooldown(HealBot_DebuffSpell[debuffType]);
        if x and x>1 then 
            z = x-(GetTime()-z)
        else
            z=0
        end
        return z
    else
        return 0
    end
end

function HealBot_Options_retBuffWatchTarget(buffName, hbGUID)
    if HealBot_Config.HealBot_BuffWatchGUID[buffName] then
        return HealBot_BuffWatchTarget[buffName], HealBot_Config.HealBot_BuffWatchGUID[buffName][hbGUID]
    else
        return HealBot_BuffWatchTarget[buffName], nil
    end
end

function HealBot_Options_retDebuffPriority(debuffName, debuffType)
    return HealBot_Globals.HealBot_Custom_Debuffs[debuffName] or 89, HealBot_Config_Cures.HealBotDebuffPriority[debuffType] or 88
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
    local i=ceil(Max/5)
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
    HealBot_Options_setNewSkin(HealBot_Options_NewSkin:GetText())
end

function HealBot_Options_setNewSkin(newSkinName)
    Healbot_Config_Skins.HealBar[newSkinName]=HealBot_Options_copyTable(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin])
    Healbot_Config_Skins.BarTextCol[newSkinName] = HealBot_Options_copyTable(Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin])
    Healbot_Config_Skins.BarCol[newSkinName] = HealBot_Options_copyTable(Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin])
    Healbot_Config_Skins.BarIACol[newSkinName] = HealBot_Options_copyTable(Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin])
    Healbot_Config_Skins.Frame[newSkinName] = HealBot_Options_copyTable(Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin])
    Healbot_Config_Skins.HeadBar[newSkinName] = HealBot_Options_copyTable(Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin])
    Healbot_Config_Skins.HeadText[newSkinName] = HealBot_Options_copyTable(Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin])
    Healbot_Config_Skins.General[newSkinName] = HealBot_Options_copyTable(Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin])
    Healbot_Config_Skins.Highlight[newSkinName] = HealBot_Options_copyTable(Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin])
    Healbot_Config_Skins.RaidIcon[newSkinName] = HealBot_Options_copyTable(Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin])
    Healbot_Config_Skins.Sort[newSkinName] = HealBot_Options_copyTable(Healbot_Config_Skins.Sort[Healbot_Config_Skins.Current_Skin])
    Healbot_Config_Skins.Icons[newSkinName] = HealBot_Options_copyTable(Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin])
    Healbot_Config_Skins.Aggro[newSkinName] = HealBot_Options_copyTable(Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin])
    Healbot_Config_Skins.BarText[newSkinName] = HealBot_Options_copyTable(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin])
    Healbot_Config_Skins.IconText[newSkinName] = HealBot_Options_copyTable(Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin])
    Healbot_Config_Skins.HealGroups[newSkinName] = HealBot_Options_copyTable(Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin])
    Healbot_Config_Skins.Healing[newSkinName] = HealBot_Options_copyTable(Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin])
    Healbot_Config_Skins.EmergIncMonitor[newSkinName] = Healbot_Config_Skins.EmergIncMonitor[Healbot_Config_Skins.Current_Skin]
    Healbot_Config_Skins.Chat[newSkinName] = HealBot_Options_copyTable(Healbot_Config_Skins.Chat[Healbot_Config_Skins.Current_Skin])
    Healbot_Config_Skins.Anchors[newSkinName] = HealBot_Options_copyTable(Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin])
    if not HealBot_Config.SkinDefault[newSkinName] then HealBot_Config.SkinDefault[newSkinName] = 1 end
    Healbot_Config_Skins.ExtraIncGroup[newSkinName] = {[1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true}
    Healbot_Config_Skins.Protection[newSkinName] = HealBot_Options_copyTable(Healbot_Config_Skins.Protection[Healbot_Config_Skins.Current_Skin])
    Healbot_Config_Skins.BarsHide[newSkinName] = HealBot_Options_copyTable(Healbot_Config_Skins.BarsHide[Healbot_Config_Skins.Current_Skin])
    Healbot_Config_Skins.FrameAlias[newSkinName] = HealBot_Options_copyTable(Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin])
    Healbot_Config_Skins.Enemy[newSkinName] = HealBot_Options_copyTable(Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin])
    Healbot_Config_Skins.Author[newSkinName] = HealBot_GetUnitName("Player").." "..HEALBOT_PLAYER_OF_REALM.." "..GetRealmName()
    local unique=true;
    table.foreach(HealBot_Skins, function (index,skin)
        if skin==newSkinName then unique=false; end
    end)
    if unique then
        table.insert(HealBot_Skins,2,newSkinName)
        Healbot_Config_Skins.Skin_ID = 2;
        Healbot_Config_Skins.Skins = HealBot_Skins
    end
    Healbot_Config_Skins.Current_Skin = newSkinName
    HealBot_Options_SetSkins();
    HealBot_Options_NewSkin:SetText("")
    HealBot_Options_Set_Current_Skin(newSkinName)
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
        Healbot_Config_Skins.HeadBar[hbDelSkinName] = nil
        Healbot_Config_Skins.HeadText[hbDelSkinName] = nil
        Healbot_Config_Skins.General[hbDelSkinName] = nil
        Healbot_Config_Skins.Highlight[hbDelSkinName] = nil
        Healbot_Config_Skins.RaidIcon[hbDelSkinName] = nil
        Healbot_Config_Skins.Sort[hbDelSkinName] = nil
        Healbot_Config_Skins.Icons[hbDelSkinName] = nil
        Healbot_Config_Skins.Aggro[hbDelSkinName] = nil
        Healbot_Config_Skins.BarText[hbDelSkinName] = nil
        Healbot_Config_Skins.IconText[hbDelSkinName] = nil
        Healbot_Config_Skins.HealGroups[hbDelSkinName] = nil
        Healbot_Config_Skins.Healing[hbDelSkinName] = nil
        Healbot_Config_Skins.EmergIncMonitor[hbDelSkinName] = nil
        Healbot_Config_Skins.Chat[hbDelSkinName] = nil
        Healbot_Config_Skins.Anchors[hbDelSkinName] = nil
        HealBot_Config.SkinDefault[hbDelSkinName] = nil
        Healbot_Config_Skins.BarsHide[hbDelSkinName] = nil
        Healbot_Config_Skins.Protection[hbDelSkinName] = nil
        Healbot_Config_Skins.Author[hbDelSkinName] = nil
        Healbot_Config_Skins.FrameAlias[hbDelSkinName] = nil
        Healbot_Config_Skins.ExtraIncGroup[hbDelSkinName] = nil
        Healbot_Config_Skins.Enemy[hbDelSkinName] = nil
        table.remove(HealBot_Skins,Healbot_Config_Skins.Skin_ID)
        Healbot_Config_Skins.Skin_ID = 1;
        Healbot_Config_Skins.Skins = HealBot_Skins;  
        Healbot_Config_Skins.Current_Skin = HEALBOT_SKINS_STD;
        HealBot_Options_SetSkins();
        HealBot_Options_Set_Current_Skin(HEALBOT_SKINS_STD)
    end
end

function HealBot_Options_ShowEnemyIncSelf_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCSELF"]=true
    else
        Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCSELF"]=false
    end
    if HealBot_Data["REFRESH"]==0 then HealBot_Data["REFRESH"]=1; end
end

function HealBot_Options_ShowEnemyIncTanks_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCTANKS"]=true
    else
        Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCTANKS"]=false
    end
    if HealBot_Data["REFRESH"]==0 then HealBot_Data["REFRESH"]=1; end
end

function HealBot_Options_ShowEnemyIncArena_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCARENA"]=true
    else
        Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCARENA"]=false
    end
    if HealBot_Data["REFRESH"]==0 then HealBot_Data["REFRESH"]=1; end
end

function HealBot_Options_ShowEnemyIncArenaPets_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCARENAPETS"]=true
    else
        Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCARENAPETS"]=false
    end
    if HealBot_Data["REFRESH"]==0 then HealBot_Data["REFRESH"]=1; end
end

function HealBot_Options_ShowEnemyIncMyTargets_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCMYTAR"]=true
    else
        Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["INCMYTAR"]=false
    end
    if HealBot_Data["REFRESH"]==0 then HealBot_Data["REFRESH"]=1; end
end

function HealBot_Options_HideEnemyOutOfCombat_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["HIDE"]=true
    else
        Healbot_Config_Skins.Enemy[Healbot_Config_Skins.Current_Skin]["HIDE"]=false
    end
    if HealBot_Data["REFRESH"]==0 then HealBot_Data["REFRESH"]=1; end
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
    if HealBot_Data["REFRESH"]==0 then HealBot_Data["REFRESH"]=1; end
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
    if HealBot_Data["REFRESH"]==0 then HealBot_Data["REFRESH"]=1; end
end

function HealBot_Options_CombatProt_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Protection[Healbot_Config_Skins.Current_Skin]["COMBAT"]=true
    else
        Healbot_Config_Skins.Protection[Healbot_Config_Skins.Current_Skin]["COMBAT"]=false
    end
    if HealBot_Data["REFRESH"]<2 then HealBot_Data["REFRESH"]=2; end
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
        if HealBot_Data["REFRESH"]<2 then HealBot_Data["REFRESH"]=2; end
    end
end

function HealBot_Options_CombatPartyNo_OnValueChanged(self)
    local val=floor(self:GetValue()+0.5)
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        Healbot_Config_Skins.Protection[Healbot_Config_Skins.Current_Skin]["COMBATPARTY"] = val;
        local g=_G[self:GetName().."Text"]
        g:SetText(val.." "..self.text);
        if HealBot_Data["REFRESH"]<2 then HealBot_Data["REFRESH"]=2; end
    end
end

function HealBot_Options_CombatRaidNo_OnValueChanged(self)
    local val=floor(self:GetValue()+0.5)
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        Healbot_Config_Skins.Protection[Healbot_Config_Skins.Current_Skin]["COMBATRAID"] = val;
        local g=_G[self:GetName().."Text"]
        g:SetText(val.." "..self.text);
        if HealBot_Data["REFRESH"]<2 then HealBot_Data["REFRESH"]=2; end
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

function HealBot_BarButtonIconTextScale_OnValueChanged(self)
--    local val=floor(self:GetValue()+0.5)
    local val=HealBot_Comm_round(self:GetValue(), 1)
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        val=val/10;
        Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SCALE"] = val;
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
            HealBot_setOptions_Timer(160)
        end
        updatingMedia=false;
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
        local tst="UpdFrameAlias"..HealBot_Options_StorePrev["FramesSelFrame"]
        HealBot_Options_StorePrev[tst]="S"
        HealBot_setOptions_Timer(415)
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

function HealBot_Options_AliasFontHeight_OnValueChanged(self)
    local val=floor(self:GetValue()+0.5)
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SIZE"] = val;
        local g=_G[self:GetName().."Text"]
        g:SetText(self.text .. ": " .. val);
        local tst="UpdFrameAlias"..HealBot_Options_StorePrev["FramesSelFrame"]
        HealBot_Options_StorePrev[tst]="S"
        HealBot_setOptions_Timer(415)
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
        local tst="UpdFrameAlias"..HealBot_Options_StorePrev["FramesSelFrame"]
        HealBot_Options_StorePrev[tst]="S"
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
        if HealBot_Data["REFRESH"]<4 then HealBot_Data["REFRESH"]=4; end
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
    Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HEIGHT"] = HealBot_Comm_round(HealBot_Options_Pct_OnValueChanged(self),2);
    HealBot_setOptions_Timer(150)
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

local HealBot_ColourObjWaiting=nil
function HealBot_SkinColorpick_OnClick(SkinType)
    HealBot_ColourObjWaiting=SkinType;

    if SkinType=="En" then
        HealBot_UseColourPick(Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["ER"],
                              Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["EG"],
                              Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["EB"],
                              Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["EA"] or 1);
    elseif SkinType=="Dis" then
        HealBot_UseColourPick(Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["DR"],
                              Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["DG"],
                              Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["DB"],
                              Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["DA"] or 1)
    elseif SkinType=="Debuff" then
        HealBot_UseColourPick(Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CR"],
                              Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CG"],
                              Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CB"],
                              Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CA"] or 1)
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
    elseif SkinType=="Alias" then
        HealBot_UseColourPick(Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["R"],
                              Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["G"],
                              Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["B"],
                              Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["A"] or 1)
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
        HealBot_UseColourPick(Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["CR"],
                              Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["CG"],
                              Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["CB"])
    elseif SkinType=="HighlightTargetBar" then
        HealBot_UseColourPick(Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["TR"],
                              Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["TG"],
                              Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["TB"])
    elseif SkinType=="Aggro" then
        HealBot_UseColourPick(Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["R"],
                              Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["G"],
                              Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["B"])
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
    HealBot_BarOptTextColorpick:SetStatusBarColor(0,1,0,Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HA"]);
    HealBot_BarOptTextColorpickin:SetStatusBarColor(0,1,0,Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["IA"]);
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
        Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["CR"],
        Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["CG"],
        Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["CB"]);
    HealBot_HighlightTargetBarColour:SetStatusBarColor(
        Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["TR"],
        Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["TG"],
        Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["TB"]);
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
        Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["R"],
        Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["G"],
        Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["B"]);
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
    HealBot_FrameAliasColorpick:SetStatusBarColor(0,0,0,0)
    healbotframealiastextfontstr:SetTextColor(
        Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["R"],
        Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["G"],
        Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["B"],
        Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["A"]);
end

function HealBot_Options_SetBarsTextColour()
    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CLASSCOL"]==false then
        HealBot_BarOptTextColorpickt:SetTextColor(
            Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["ER"],
            Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["EG"],
            Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["EB"],
            Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["EA"]);
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
        HealBot_BarOptTextColorpickt:SetTextColor(
            sbR,
            sbG,
            sbB,
            Healbot_Config_Skins.BarTextCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["EA"]);
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
    Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["ALERTIC"] = HealBot_Comm_round(HealBot_Options_Pct_OnValueChanged(self),2);
    HealBot_setOptions_Timer(80)
end

function HealBot_Options_AlertLevelOC_OnValueChanged(self)
    Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["ALERTOC"] = HealBot_Comm_round(HealBot_Options_Pct_OnValueChanged(self),2);
    HealBot_setOptions_Timer(80)
end

function HealBot_Options_AggroFlashFreq_OnValueChanged(self)
    local val=HealBot_Comm_round(self:GetValue(),1)
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        val=val/100;
        Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["FREQ"] = val;
        local g=_G[self:GetName().."Text"]
        g:SetText(self.text .. ": " .. val);
        HealBot_Action_Set_Timers()
    end
end

function HealBot_Options_AggroFlashAlphaMin_OnValueChanged(self)
    Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["MINA"] = HealBot_Comm_round(HealBot_Options_Pct_OnValueChanged(self),2);
    if Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["MINA"]>=Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["MAXA"] then
        Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["MAXA"]=Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["MINA"]+0.05
        HealBot_Options_AggroFlashAlphaMax:SetValue(Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["MAXA"])
    end
end

function HealBot_Options_AggroFlashAlphaMax_OnValueChanged(self)
    Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["MAXA"] = HealBot_Comm_round(HealBot_Options_Pct_OnValueChanged(self),2);
    if Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["MAXA"]<=Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["MINA"] then
        Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["MINA"]=Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["MAXA"]-0.05
        HealBot_Options_AggroFlashAlphaMin:SetValue(Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["MINA"])
    end
end

function HealBot_Options_RangeCheckFreq_OnValueChanged(self)
    local val=HealBot_Comm_round(self:GetValue(), 1)
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        val=val/10;
        HealBot_Globals.RangeCheckFreq = val;
        local g=_G[self:GetName().."Text"]
        g:SetText(self.text .. ": " .. val);
        HealBot_Set_Timers()
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

function HealBot_Options_BarFreq_OnValueChanged(self)
    local val=floor(self:GetValue()+0.5)
    if val~=self:GetValue() then
        self:SetValue(val) 
    else
        val=val/10;
        Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["FLUIDFREQ"] = val;
        local g=_G[self:GetName().."Text"]
        g:SetText(self.text .. ": " .. val);
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
        if HealBot_Data["REFRESH"]<2 then HealBot_Data["REFRESH"]=2; end
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
        if HealBot_Data["REFRESH"]<2 then HealBot_Data["REFRESH"]=2; end
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
        if HealBot_Data["REFRESH"]<2 then HealBot_Data["REFRESH"]=2; end
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
        if HealBot_Data["REFRESH"]<2 then HealBot_Data["REFRESH"]=2; end
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
        if HealBot_Data["REFRESH"]<2 then HealBot_Data["REFRESH"]=2; end
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
        if HealBot_Data["REFRESH"]<2 then HealBot_Data["REFRESH"]=2; end
    end
end

function HealBot_Options_AutoShow_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["AUTOCLOSE"] = true
    else
        Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["AUTOCLOSE"] = false
    end
    HealBot_setOptions_Timer(80)
    if HealBot_Data["REFRESH"]<7 then HealBot_Data["REFRESH"]=7; end
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
    if HealBot_Data["REFRESH"]<4 then HealBot_Data["REFRESH"]=4; end
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
    HealBot_setOptions_Timer(150)
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

function HealBot_Options_PartyFrames_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["HIDEPARTYF"] = true
    else
        Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["HIDEPARTYF"] = false
    end
    HealBot_setOptions_Timer(180)
end

function HealBot_Options_MiniBossFrames_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["HIDEBOSSF"] = true
    else
        Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["HIDEBOSSF"] = false
    end
    HealBot_setOptions_Timer(185)
end

function HealBot_Options_RaidFrames_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["HIDERAIDF"] = true
    else
        Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["HIDERAIDF"] = false
    end
    HealBot_setOptions_Timer(188)
end

function HealBot_Options_AggroTrack_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["SHOW"] = true
        HealBot_Register_Aggro()
    else
        Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["SHOW"] = false
        HealBot_UnRegister_Aggro()
    end
    HealBot_setOptions_Timer(150)
    HealBot_setOptions_Timer(80)
    HealBot_Action_Set_Timers()
end

function HealBot_Options_HighlightActiveBar_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["CBAR"] = true
    else
        Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["CBAR"] = false
    end
    HealBot_setOptions_Timer(150)
end

function HealBot_Options_HighlightTargetBar_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["TBAR"] = true
    else
        Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["TBAR"] = false
    end
    HealBot_setOptions_Timer(150)
end

function HealBot_Options_HighlightActiveBarInCombat_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["CBARCOMBAT"] = true
    else
        Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["CBARCOMBAT"] = false
    end
end

function HealBot_Options_HighlightTargetBarInCombat_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["TBARCOMBAT"] = true
    else
        Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["TBARCOMBAT"] = false
    end
end

function HealBot_Options_UseFluidBars_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["FLUIDBARS"] = true
    else
        Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["FLUIDBARS"] = false
    end
    HealBot_setOptions_Timer(80)
    HealBot_Action_Set_Timers()
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
        Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["SHOWBARS"] = true
    else
        Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["SHOWBARS"] = false
    end
    HealBot_setOptions_Timer(150)
    HealBot_setOptions_Timer(80)
    HealBot_Action_Set_Timers()
end

function HealBot_Options_AggroTxt_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["SHOWTEXT"] = true
    else
        Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["SHOWTEXT"] = false
    end
    HealBot_setOptions_Timer(80)
end

function HealBot_Options_AggroInd_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["SHOWIND"] = true
    else
        Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["SHOWIND"] = false
    end
    HealBot_setOptions_Timer(80)
end

function HealBot_Options_AggroBarPct_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["SHOWBARSPCT"] = true
    else
        Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["SHOWBARSPCT"] = false
    end
end

function HealBot_Options_AggroTxtPct_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["SHOWTEXTPCT"] = true
    else
        Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["SHOWTEXTPCT"] = false
    end
    HealBot_setOptions_Timer(85)
end

function HealBot_Options_CPUProfiler_OnClick(self)
    local reason=HEALBOT_OPTION_CPUPROFILE
    if self:GetChecked() then
        reason=reason.." - "..HEALBOT_WORD_ON
        SetCVar("scriptProfile", true)
    else
        reason=reason.." - "..HEALBOT_WORD_OFF
        SetCVar("scriptProfile", false)
    end
    HealBot_Options_ReloadUI(reason)
end

function HealBot_Options_PlayerTargetFrames_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["HIDEPTF"] = true
    else
        Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["HIDEPTF"] = false
    end
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
    if HealBot_Config_Buffs.BuffWatch then
        HealBot_setOptions_Timer(40)
    else
        HealBot_SetAuraChecks()
    end
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
    if HealBot_Config_Cures.DebuffWatch then
        HealBot_setOptions_Timer(50)
    else
        HealBot_SetAuraChecks()
    end
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
    if HealBot_Config_Buffs.BuffWatchWhenGrouped and GetNumGroupMembers()==0 then
        HealBot_SetAuraChecks()
    else
        HealBot_setOptions_Timer(40)
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
    if HealBot_Config_Cures.DebuffWatchWhenGrouped and GetNumGroupMembers()==0 then
        HealBot_SetAuraChecks()
    else
        HealBot_setOptions_Timer(50)
    end
end

function HealBot_Options_CDCCol_ShowOnHealthBar_OnClick(self)
    if self:GetChecked() then
        HealBot_Config_Cures.CDCshownHB = true
    else
        HealBot_Config_Cures.CDCshownHB = false
    end
end

function HealBot_Options_CDCCol_OnOff_OnClick(self)
    if HealBot_Options_StorePrev["CDebuffcustomName"] then
        if self:GetChecked() then
            HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[HealBot_Options_StorePrev["CDebuffcustomName"]] = nil
        else
            HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[HealBot_Options_StorePrev["CDebuffcustomName"]] = false
        end
        for xUnit,xButton in pairs(HealBot_Unit_Button) do
            if xButton.debuff and xButton.debuff.spellId then
                HealBot_ClearDebuff(xButton,true)
                HealBot_CheckAllDebuffs(xUnit)
            end
        end
    end
end

function HealBot_Options_CDCCol_ShowOnAggroBar_OnClick(self)
    if self:GetChecked() then
        HealBot_Config_Cures.CDCshownAB = true
    else
        HealBot_Config_Cures.CDCshownAB = false
        HealBot_Action_ClearUnitDebuffStatus()
        HealBot_SetResetFlag("SOFT")
    end
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
        HealBot_SetResetFlag("SOFT")
    else
        HealBot_Config_Buffs.NoAuraWhenRested=false
        HealBot_setOptions_Timer(30) 
    end
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
    if HealBot_Config.DisableHealBot==false then
        z=0
    elseif HealBot_Config.DisableSolo==false then
        z=1
    elseif GetNumGroupMembers()==0 then
        z=1
    end
    if HealBot_Config.DisabledNow~=z then
        if z==0 then 
            HealBot_Config.DisabledNow=0
            HealBot_Set_Timers() 
            HealBot_OnEvent_TalentsChanged(nil)
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
    if HealBot_Data["REFRESH"]<1 then HealBot_Data["REFRESH"]=1; end
    if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][id]["NAME"]==HEALBOT_FOCUS_en then 
        HealBot_setFocusHeals(id)
    elseif Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][id]["NAME"]==HEALBOT_OPTIONS_PETHEALS_en then 
        HealBot_setPetHeals(id) 
    elseif Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][id]["NAME"]==HEALBOT_OPTIONS_TARGETHEALS_en then 
        HealBot_setTargetHeals(id) 
    elseif Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][id]["NAME"]==HEALBOT_CUSTOM_CASTBY_ENEMY_en then
        HealBot_setEnemyBars(id)
    end
end

function HealBot_Options_HealGroupUp_OnClick(self, id)
    if id>1 and id<12 then
        local hbId = id-1
        HealBot_Options_HealGroupSwap(hbId, id)
    end
end

function HealBot_Options_HealGroupDown_OnClick(self, id)
    if id>0 and id<11 then
        local hbId = id+1
        HealBot_Options_HealGroupSwap(hbId, id)
    end
end

function HealBot_Options_HealGroupSwap(hbId, id)
    local hgName=Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][id]["NAME"]
    local hgState=Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][id]["STATE"]
    local hgFrame=Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][id]["FRAME"]
    Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][id]["STATE"] = Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][hbId]["STATE"]
    Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][id]["NAME"]  = Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][hbId]["NAME"]
    Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][id]["FRAME"] = Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][hbId]["FRAME"]
    Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][hbId]["STATE"] = hgState
    Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][hbId]["NAME"]  = hgName
    Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][hbId]["FRAME"] = hgFrame
    --local g=_G["HealBot_Options_HealGroups"..id]
    --g:SetChecked(Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][id]["STATE"])
    --g=_G["HealBot_Options_HealGroups"..id.."Text"]
    --g:SetText(id..": "..HealBot_HealGroupsTrans[Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][id]["NAME"]])
    --g=_G["HealBot_Options_HealGroups"..hbId]
    --g:SetChecked(Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][hbId]["STATE"])
    --g=_G["HealBot_Options_HealGroups"..hbId.."Text"]
    --g:SetText(hbId..": "..HealBot_HealGroupsTrans[Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][hbId]["NAME"]])
    if id<6 or hbId<6 then 
        DoneInitTab[338]=nil
        HealBot_Options_InitSub(338) 
    end
    if id>5 or hbId>5 then 
        DoneInitTab[339]=nil
        HealBot_Options_InitSub(339) 
    end
    if HealBot_Data["REFRESH"]<1 then HealBot_Data["REFRESH"]=1; end
end

function HealBot_Options_TargetIncSelf_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TINCSELF"] = true
    else
        Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TINCSELF"] = false
    end
    if HealBot_Data["REFRESH"]<1 then HealBot_Data["REFRESH"]=1; end
end

function HealBot_Options_TargetIncGroup_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TINCGROUP"] = true
    else
        Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TINCGROUP"] = false
    end
    if HealBot_Data["REFRESH"]<1 then HealBot_Data["REFRESH"]=1; end
end

function HealBot_Options_TargetIncRaid_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TINCRAID"] = true
    else
        Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TINCRAID"] = false
    end
    if HealBot_Data["REFRESH"]<1 then HealBot_Data["REFRESH"]=1; end
end

function HealBot_Options_TargetIncPet_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TINCPET"] = true
    else
        Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TINCPET"] = false
    end
    if HealBot_Data["REFRESH"]<1 then HealBot_Data["REFRESH"]=1; end
end

function HealBot_Options_SubSortIncGroup_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Sort[Healbot_Config_Skins.Current_Skin]["SUBIG"] = true
    else
        Healbot_Config_Skins.Sort[Healbot_Config_Skins.Current_Skin]["SUBIG"] = false
    end
    if HealBot_Data["REFRESH"]<1 then HealBot_Data["REFRESH"]=1; end
end

function HealBot_Options_SubSortIncPet_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Sort[Healbot_Config_Skins.Current_Skin]["SUBIP"] = true
    else
        Healbot_Config_Skins.Sort[Healbot_Config_Skins.Current_Skin]["SUBIP"] = false
    end
    if HealBot_Data["REFRESH"]<1 then HealBot_Data["REFRESH"]=1; end
end

function HealBot_Options_SubSortIncVehicle_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Sort[Healbot_Config_Skins.Current_Skin]["SUBIV"] = true
    else
        Healbot_Config_Skins.Sort[Healbot_Config_Skins.Current_Skin]["SUBIV"] = false
    end
    if HealBot_Data["REFRESH"]<1 then HealBot_Data["REFRESH"]=1; end
end

function HealBot_Options_SubSortIncTanks_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Sort[Healbot_Config_Skins.Current_Skin]["SUBIT"] = true
    else
        Healbot_Config_Skins.Sort[Healbot_Config_Skins.Current_Skin]["SUBIT"] = false
    end
    if HealBot_Data["REFRESH"]<1 then HealBot_Data["REFRESH"]=1; end
end

function HealBot_Options_SubSortIncMyTargets_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Sort[Healbot_Config_Skins.Current_Skin]["SUBIMT"] = true
    else
        Healbot_Config_Skins.Sort[Healbot_Config_Skins.Current_Skin]["SUBIMT"] = false
    end
    if HealBot_Data["REFRESH"]<1 then HealBot_Data["REFRESH"]=1; end
end

function HealBot_Options_HideBar_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.BarsHide[Healbot_Config_Skins.Current_Skin]["STATE"] = true
    else
        Healbot_Config_Skins.BarsHide[Healbot_Config_Skins.Current_Skin]["STATE"] = false
    end
    if HealBot_Data["REFRESH"]<1 then HealBot_Data["REFRESH"]=1; end
end

function HealBot_Options_HideIncFocus_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.BarsHide[Healbot_Config_Skins.Current_Skin]["INCFOCUS"] = true
    else
        Healbot_Config_Skins.BarsHide[Healbot_Config_Skins.Current_Skin]["INCFOCUS"] = false
    end
    if HealBot_Data["REFRESH"]<1 then HealBot_Data["REFRESH"]=1; end
end

function HealBot_Options_HideIncGroup_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.BarsHide[Healbot_Config_Skins.Current_Skin]["INCGROUP"] = true
    else
        Healbot_Config_Skins.BarsHide[Healbot_Config_Skins.Current_Skin]["INCGROUP"] = false
    end
    if HealBot_Data["REFRESH"]<1 then HealBot_Data["REFRESH"]=1; end
end

function HealBot_Options_HideIncTank_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.BarsHide[Healbot_Config_Skins.Current_Skin]["INCTANK"] = true
    else
        Healbot_Config_Skins.BarsHide[Healbot_Config_Skins.Current_Skin]["INCTANK"] = false
    end
    if HealBot_Data["REFRESH"]<1 then HealBot_Data["REFRESH"]=1; end
end

function HealBot_Options_HideIncMyTargets_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.BarsHide[Healbot_Config_Skins.Current_Skin]["INCMYTARGETS"] = false
    else
        Healbot_Config_Skins.BarsHide[Healbot_Config_Skins.Current_Skin]["INCMYTARGETS"] = true
    end
    if HealBot_Data["REFRESH"]<1 then HealBot_Data["REFRESH"]=1; end
end

function HealBot_Options_FocusAlwaysShow_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["FALWAYSSHOW"] = true
    else
        Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["FALWAYSSHOW"] = false
    end
    if HealBot_Data["REFRESH"]<2 then HealBot_Data["REFRESH"]=2; end
end

function HealBot_Options_TargetAlwaysShow_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TALWAYSSHOW"] = true
    else
        Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TALWAYSSHOW"] = false
    end
    if HealBot_Data["REFRESH"]<2 then HealBot_Data["REFRESH"]=2; end
end

function HealBot_Options_FocusOnlyFriend_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["FONLYFRIEND"] = true
    else
        Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["FONLYFRIEND"] = false
    end
    if HealBot_Data["REFRESH"]<2 then HealBot_Data["REFRESH"]=2; end
end

function HealBot_Options_TargetOnlyFriend_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TONLYFRIEND"] = true
    else
        Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TONLYFRIEND"] = false
    end
    if HealBot_Data["REFRESH"]<2 then HealBot_Data["REFRESH"]=2; end
end

function HealBot_Options_GroupPetsByFive_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["GROUPPETS"] = true
    else
        Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["GROUPPETS"] = false
    end
    if HealBot_Data["REFRESH"]<2 then HealBot_Data["REFRESH"]=2; end
end

function HealBot_Options_EFGroup_OnClick(self,id)
    if self:GetChecked() then
        Healbot_Config_Skins.ExtraIncGroup[Healbot_Config_Skins.Current_Skin][id] = true;
    else
        Healbot_Config_Skins.ExtraIncGroup[Healbot_Config_Skins.Current_Skin][id] = false;
    end
    if HealBot_Data["REFRESH"]<2 then HealBot_Data["REFRESH"]=2; end
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
    if HealBot_Data["REFRESH"]==0 then 
        HealBot_Data["REFRESH"]=1; 
    end
end

HealBot_Options_StorePrev["CastNotify"]=1
function HealBot_Options_CastNotify_OnClick(self,id)
    local g=nil
    if id>0 and id~=HealBot_Options_StorePrev["CastNotify"] then
        g=_G["HealBot_Options_CastNotify"..HealBot_Options_StorePrev["CastNotify"]]
        g:SetChecked(nil);
        HealBot_Options_StorePrev["CastNotify"]=id
    end
    Healbot_Config_Skins.Chat[Healbot_Config_Skins.Current_Skin]["NOTIFY"] = id;
    if Healbot_Config_Skins.Chat[Healbot_Config_Skins.Current_Skin]["NOTIFY"]>0 then
        g=_G["HealBot_Options_CastNotify"..Healbot_Config_Skins.Chat[Healbot_Config_Skins.Current_Skin]["NOTIFY"]]
        g:SetChecked(1);
    end
end

function HealBot_Options_HideOptions_OnClick(self)
    if self:GetChecked() then
        HealBot_Globals.HideOptions = true
    else
        HealBot_Globals.HideOptions = false
    end
    if HealBot_Data["REFRESH"]==0 then 
        HealBot_Data["REFRESH"]=1; 
    end
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
        HealBot_Data["TIPUSE"]="YES"
        if HealBot_Config_Buffs.BuffWatch then
            HealBot_setOptions_Timer(40)
        end
    else
        HealBot_Data["TIPUSE"]="NO"
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

function HealBot_Options_NumberTextLines_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["DOUBLE"] = true
    else
        Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["DOUBLE"] = false
    end
    HealBot_setOptions_Timer(80)
    HealBot_Panel_resetTestCols()
end

function HealBot_Options_BarTextInClassColour_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CLASSCOL"] = true
    else
        Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CLASSCOL"] = false
    end
    HealBot_Action_ResetUnitStatus()
    HealBot_Options_SetBarsTextColour()
    HealBot_Panel_resetTestCols(true)
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
    HealBot_Options_RaidTargetUpdate()
end

function HealBot_Options_BarButtonShowRaidIconStar_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["STAR"] = true
    else
        Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["STAR"] = false
    end
    HealBot_Options_RaidTargetUpdate()
end

function HealBot_Options_BarButtonShowRaidIconCircle_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CIRCLE"] = true
    else
        Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CIRCLE"] = false
    end
    HealBot_Options_RaidTargetUpdate()
end

function HealBot_Options_BarButtonShowRaidIconDiamond_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["DIAMOND"] = true
    else
        Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["DIAMOND"] = false
    end
    HealBot_Options_RaidTargetUpdate()
end

function HealBot_Options_BarButtonShowRaidIconTriangle_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TRIANGLE"] = true
    else
        Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TRIANGLE"] = false
    end
    HealBot_Options_RaidTargetUpdate()
end

function HealBot_Options_BarButtonShowRaidIconMoon_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["MOON"] = true
    else
        Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["MOON"] = false
    end
    HealBot_Options_RaidTargetUpdate()
end

function HealBot_Options_BarButtonShowRaidIconSquare_OnClick(self)
    if self:GetChecked() then
       Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SQUARE"] = true
    else
       Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SQUARE"] = false
    end
    HealBot_Options_RaidTargetUpdate()
end

function HealBot_Options_BarButtonShowRaidIconCross_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CROSS"] = true
    else
        Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CROSS"] = false
    end
    HealBot_Options_RaidTargetUpdate()
end

function HealBot_Options_BarButtonShowRaidIconSkull_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SKULL"] = true
    else
        Healbot_Config_Skins.RaidIcon[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SKULL"] = false
    end
    HealBot_Options_RaidTargetUpdate()
end

function HealBot_Options_SubSortPlayerFirst_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Sort[Healbot_Config_Skins.Current_Skin]["SUBPF"] = true
    else
        Healbot_Config_Skins.Sort[Healbot_Config_Skins.Current_Skin]["SUBPF"] = false
    end
    if HealBot_Data["REFRESH"]<2 then HealBot_Data["REFRESH"]=2; end
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
    HealBot_Action_ResetUnitStatus()
end

function HealBot_Options_ShowDirectionMouseOver_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOWDIRMOUSE"] = true
    else
        Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOWDIRMOUSE"] = false
    end
    HealBot_Action_ResetUnitStatus()
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

function HealBot_Options_ShowClassOnBarType_OnClick(self,id)
    local g=_G["HealBot_Options_ShowClassOnBarType1"]
    g:SetChecked(nil);
    g=_G["HealBot_Options_ShowClassOnBarType2"]
    g:SetChecked(nil);
    Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CLASSTYPE"] = id;
    if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CLASSTYPE"]>0 then
        g=_G["HealBot_Options_ShowClassOnBarType"..Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CLASSTYPE"]]
        g:SetChecked(1);
        HealBot_setOptions_Timer(155)
    end
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
        HealBot_setOptions_Timer(155)
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
                        DoneInitTab[308]=nil
                        HealBot_Options_InitSub(308)
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
                        Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["TEXTFORMAT"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_BarHealthNumFormatAggro,nFormat) 
                        HealBot_setOptions_Timer(85)
                    end
        info.checked = false;
        if Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["TEXTFORMAT"]==i then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

--------------------------------------------------------------------------------

function HealBot_Options_HealGroups1Frame_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_HealGroupsFrame_List), 1 do
        info.text = HealBot_Options_HealGroupsFrame_List[j];
        info.func = function(self)
                        Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][1]["FRAME"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_HealGroups1Frame,HealBot_Options_HealGroupsFrame_List[Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][1]["FRAME"]]) 
                        if HealBot_Data["REFRESH"]<1 then HealBot_Data["REFRESH"]=1; end
                    end
        info.checked = false;
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][1]["FRAME"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_HealGroups2Frame_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_HealGroupsFrame_List), 1 do
        info.text = HealBot_Options_HealGroupsFrame_List[j];
        info.func = function(self)
                        Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][2]["FRAME"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_HealGroups2Frame,HealBot_Options_HealGroupsFrame_List[Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][2]["FRAME"]]) 
                        if HealBot_Data["REFRESH"]<1 then HealBot_Data["REFRESH"]=1; end
                    end
        info.checked = false;
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][2]["FRAME"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_HealGroups3Frame_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_HealGroupsFrame_List), 1 do
        info.text = HealBot_Options_HealGroupsFrame_List[j];
        info.func = function(self)
                        Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][3]["FRAME"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_HealGroups3Frame,HealBot_Options_HealGroupsFrame_List[Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][3]["FRAME"]]) 
                        if HealBot_Data["REFRESH"]<1 then HealBot_Data["REFRESH"]=1; end
                    end
        info.checked = false;
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][3]["FRAME"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_HealGroups4Frame_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_HealGroupsFrame_List), 1 do
        info.text = HealBot_Options_HealGroupsFrame_List[j];
        info.func = function(self)
                        Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][4]["FRAME"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_HealGroups4Frame,HealBot_Options_HealGroupsFrame_List[Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][4]["FRAME"]]) 
                        if HealBot_Data["REFRESH"]<1 then HealBot_Data["REFRESH"]=1; end
                    end
        info.checked = false;
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][4]["FRAME"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_HealGroups5Frame_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_HealGroupsFrame_List), 1 do
        info.text = HealBot_Options_HealGroupsFrame_List[j];
        info.func = function(self)
                        Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][5]["FRAME"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_HealGroups5Frame,HealBot_Options_HealGroupsFrame_List[Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][5]["FRAME"]]) 
                        if HealBot_Data["REFRESH"]<1 then HealBot_Data["REFRESH"]=1; end
                    end
        info.checked = false;
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][5]["FRAME"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_HealGroups6Frame_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_HealGroupsFrame_List), 1 do
        info.text = HealBot_Options_HealGroupsFrame_List[j];
        info.func = function(self)
                        Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][6]["FRAME"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_HealGroups6Frame,HealBot_Options_HealGroupsFrame_List[Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][6]["FRAME"]]) 
                        if HealBot_Data["REFRESH"]<1 then HealBot_Data["REFRESH"]=1; end
                    end
        info.checked = false;
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][6]["FRAME"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_HealGroups7Frame_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_HealGroupsFrame_List), 1 do
        info.text = HealBot_Options_HealGroupsFrame_List[j];
        info.func = function(self)
                        Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["FRAME"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_HealGroups7Frame,HealBot_Options_HealGroupsFrame_List[Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["FRAME"]]) 
                        if HealBot_Data["REFRESH"]<1 then HealBot_Data["REFRESH"]=1; end
                    end
        info.checked = false;
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][7]["FRAME"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_HealGroups8Frame_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_HealGroupsFrame_List), 1 do
        info.text = HealBot_Options_HealGroupsFrame_List[j];
        info.func = function(self)
                        Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["FRAME"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_HealGroups8Frame,HealBot_Options_HealGroupsFrame_List[Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["FRAME"]]) 
                        if HealBot_Data["REFRESH"]<1 then HealBot_Data["REFRESH"]=1; end
                    end
        info.checked = false;
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][8]["FRAME"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_HealGroups9Frame_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_HealGroupsFrame_List), 1 do
        info.text = HealBot_Options_HealGroupsFrame_List[j];
        info.func = function(self)
                        Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][9]["FRAME"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_HealGroups9Frame,HealBot_Options_HealGroupsFrame_List[Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][9]["FRAME"]]) 
                        if HealBot_Data["REFRESH"]<1 then HealBot_Data["REFRESH"]=1; end
                    end
        info.checked = false;
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][9]["FRAME"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_HealGroups10Frame_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_HealGroupsFrame_List), 1 do
        info.text = HealBot_Options_HealGroupsFrame_List[j];
        info.func = function(self)
                        Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["FRAME"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_HealGroups10Frame,HealBot_Options_HealGroupsFrame_List[Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["FRAME"]]) 
                        if HealBot_Data["REFRESH"]<1 then HealBot_Data["REFRESH"]=1; end
                    end
        info.checked = false;
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][10]["FRAME"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_HealGroups11Frame_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_HealGroupsFrame_List), 1 do
        info.text = HealBot_Options_HealGroupsFrame_List[j];
        info.func = function(self)
                        Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][11]["FRAME"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_HealGroups11Frame,HealBot_Options_HealGroupsFrame_List[Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][11]["FRAME"]]) 
                        if HealBot_Data["REFRESH"]<1 then HealBot_Data["REFRESH"]=1; end
                    end
        info.checked = false;
        if Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][11]["FRAME"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
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
                        local tst="UpdFrameAlias"..HealBot_Options_StorePrev["FramesSelFrame"]
                        HealBot_Options_StorePrev[tst]="S"
                        HealBot_setOptions_Timer(415)
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
                        DoneInitTab[307]=nil
                        HealBot_Options_InitSub(307)
                        DoneInitTab[308]=nil
                        HealBot_Options_InitSub(308)
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

function HealBot_Options_MouseWheelUp_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_MouseWheel_List), 1 do
        info.text = HealBot_Options_MouseWheel_List[j];
        info.func = function(self)
                        HealBot_Globals.HealBot_MouseWheelIndex["NoneUp"] = self:GetID()
                        HealBot_Globals.HealBot_MouseWheelTxt["NoneUp"] = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_MouseWheelUp, HealBot_Options_MouseWheel_List[HealBot_Globals.HealBot_MouseWheelIndex["NoneUp"]])
                        HealBot_setOptions_Timer(405)
                    end
        info.checked = false;
        if HealBot_Globals.HealBot_MouseWheelIndex["NoneUp"] == j then info.checked = true; end
        UIDropDownMenu_AddButton(info);
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
                        HealBot_setOptions_Timer(405)
                    end
        info.checked = false;
        if HealBot_Globals.HealBot_MouseWheelIndex["NoneDown"] == j then info.checked = true; end
        UIDropDownMenu_AddButton(info);
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
                        HealBot_setOptions_Timer(405)
                    end
        info.checked = false;
        if HealBot_Globals.HealBot_MouseWheelIndex["ShiftUp"] == j then info.checked = true; end
        UIDropDownMenu_AddButton(info);
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
                        HealBot_setOptions_Timer(405)
                    end
        info.checked = false;
        if HealBot_Globals.HealBot_MouseWheelIndex["ShiftDown"] == j then info.checked = true; end
        UIDropDownMenu_AddButton(info);
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
                        HealBot_setOptions_Timer(405)
                    end
        info.checked = false;
        if HealBot_Globals.HealBot_MouseWheelIndex["CtrlUp"] == j then info.checked = true; end
        UIDropDownMenu_AddButton(info);
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
                        HealBot_setOptions_Timer(405)
                    end
        info.checked = false;
        if HealBot_Globals.HealBot_MouseWheelIndex["CtrlDown"] == j then info.checked = true; end
        UIDropDownMenu_AddButton(info);
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
                        HealBot_setOptions_Timer(405)
                    end
        info.checked = false;
        if HealBot_Globals.HealBot_MouseWheelIndex["AltUp"] == j then info.checked = true; end
        UIDropDownMenu_AddButton(info);
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
                        HealBot_setOptions_Timer(405)
                    end
        info.checked = false;
        if HealBot_Globals.HealBot_MouseWheelIndex["AltDown"] == j then info.checked = true; end
        UIDropDownMenu_AddButton(info);
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
        HealBot_Options_delCustomPrio(9)
    elseif HealBot_Options_StorePrev["hbCommands"]==5 then
        HealBot_Options_delCustomPrio(10)
    elseif HealBot_Options_StorePrev["hbCommands"]==6 then
        HealBot_Options_delCustomPrio(11)
    elseif HealBot_Options_StorePrev["hbCommands"]==7 then
        HealBot_Options_delCustomPrio(12)
    elseif HealBot_Options_StorePrev["hbCommands"]==8 then
        HealBot_Action_Reset()
    elseif HealBot_Options_StorePrev["hbCommands"]==9 then
        HealBot_Reset_Buffs()
    elseif HealBot_Options_StorePrev["hbCommands"]==10 then
        HealBot_Reset_Cures()
    elseif HealBot_Options_StorePrev["hbCommands"]==11 then
        HealBot_setResetFlagCode(2)
    elseif HealBot_Options_StorePrev["hbCommands"]==12 then
        HealBot_setResetFlagCode(3)
    elseif HealBot_Options_StorePrev["hbCommands"]==13 then
        HealBot_Reset_Spells()
    elseif HealBot_Options_StorePrev["hbCommands"]==14 then
        HealBot_ToggleAcceptSkins()
    elseif HealBot_Options_StorePrev["hbCommands"]==15 then
        HealBot_MountsPets_DislikeMount("Dislike")
    elseif HealBot_Options_StorePrev["hbCommands"]==16 then
        HealBot_MountsPets_DislikeMount("Exclude")
    elseif HealBot_Options_StorePrev["hbCommands"]==17 then
        HealBot_ToggleSuppressSetting("error")
    elseif HealBot_Options_StorePrev["hbCommands"]==18 then
        HealBot_ToggleSuppressSetting("sound")
    elseif HealBot_Options_StorePrev["hbCommands"]==19 then
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
        HealBot_Options_EFClassDeathKnight:SetChecked(HealBot_Globals.EmergIncCustom[HEALBOT_DEATHKNIGHT]);
        HealBot_Options_EFClassMonk:SetChecked(HealBot_Globals.EmergIncCustom[HEALBOT_MONK]);
    end
    if HealBot_Data["REFRESH"]==0 then HealBot_Data["REFRESH"]=1; end
end

--------------------------------------------------------------------------------

function HealBot_Options_ExtraSort_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_ExtraSort_List), 1 do
        info.text = HealBot_Options_ExtraSort_List[j];
        info.func = function(self)
                        Healbot_Config_Skins.Sort[Healbot_Config_Skins.Current_Skin]["RAIDORDER"] = self:GetID();
                        UIDropDownMenu_SetText(HealBot_Options_ExtraSort,HealBot_Options_ExtraSort_List[Healbot_Config_Skins.Sort[Healbot_Config_Skins.Current_Skin]["RAIDORDER"]]) 
                        if HealBot_Data["REFRESH"]<2 then HealBot_Data["REFRESH"]=2; end
                    end
        info.checked = false;
        if Healbot_Config_Skins.Sort[Healbot_Config_Skins.Current_Skin]["RAIDORDER"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_ExtraSubSort_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_ExtraSubSort_List), 1 do
        info.text = HealBot_Options_ExtraSubSort_List[j];
        info.func = function(self)
                        Healbot_Config_Skins.Sort[Healbot_Config_Skins.Current_Skin]["SUBORDER"] = self:GetID();
                        UIDropDownMenu_SetText(HealBot_Options_ExtraSubSort,HealBot_Options_ExtraSubSort_List[Healbot_Config_Skins.Sort[Healbot_Config_Skins.Current_Skin]["SUBORDER"]]) 
                        if HealBot_Data["REFRESH"]<2 then HealBot_Data["REFRESH"]=2; end
                    end
        info.checked = false;
        if Healbot_Config_Skins.Sort[Healbot_Config_Skins.Current_Skin]["SUBORDER"]==j then info.checked = true end
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

function HealBot_Options_ComboClass_Text()
    local combo=nil
    local button = HealBot_Options_ComboClass_Button(HealBot_Options_ComboButtons_Button)
    if HealBot_Options_StorePrev["ActionBarsCombo"]==1 then
        combo = HealBot_Config_Spells.EnabledKeyCombo;
    elseif HealBot_Options_StorePrev["ActionBarsCombo"]==2 then
        combo = HealBot_Config_Spells.DisabledKeyCombo;
    else
        combo = HealBot_Config_Spells.EnemyKeyCombo;
    end
    if combo then
        HealBot_Options_Click:SetText(combo[button..HealBot_Config.CurrentSpec] or "")
        HealBot_Options_Shift:SetText(combo["Shift"..button..HealBot_Config.CurrentSpec] or "")
        HealBot_Options_Ctrl:SetText(combo["Ctrl"..button..HealBot_Config.CurrentSpec] or "")
        HealBot_Options_Alt:SetText(combo["Alt"..button..HealBot_Config.CurrentSpec] or "")
        HealBot_Options_AltShift:SetText(combo["Alt-Shift"..button..HealBot_Config.CurrentSpec] or "")
        HealBot_Options_CtrlShift:SetText(combo["Ctrl-Shift"..button..HealBot_Config.CurrentSpec] or "")
        HealBot_Options_CtrlAlt:SetText(combo["Alt-Ctrl"..button..HealBot_Config.CurrentSpec] or "")
    end
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
end

--------------------------------------------------------------------------------

HealBot_Options_StorePrev["HealSpellsComboID"] = 0

function HealBot_Options_SelectHealSpellsCombo_DDlist()
    local HealBot_Options_SelectHealSpellsCombo_List = {}
    if HealBot_Options_StorePrev["ActionBarsCombo"]==3 then
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
            HEALBOT_FLASH_HEAL,
            HEALBOT_HOLY_WORD_SERENITY,
            HEALBOT_FLASH_OF_LIGHT,
            HEALBOT_GREATER_HEAL,
            HEALBOT_HEALING_TOUCH,
            HEALBOT_HEAL,
            HEALBOT_HEALING_WAVE,
            HEALBOT_HEALING_SURGE,
            HEALBOT_LIGHT_OF_DAWN,
            HEALBOT_HOLY_LIGHT,
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
            HEALBOT_ETERNAL_FLAME,
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
    local tmpHealDDlist={}
    for j=1, getn(HealBot_Options_SelectHealSpellsCombo_List), 1 do
        local spellName=HealBot_Options_SelectHealSpellsCombo_List[j]
        if HealBot_GetSpellId(spellName) then
            table.insert(tmpHealDDlist, spellName)
        end
    end
    table.sort(tmpHealDDlist)
    return tmpHealDDlist
end

local function HealBot_Options_SelectHealSpellsCombo_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    local hbHealDDlist=HealBot_Options_SelectHealSpellsCombo_DDlist()
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
            local spellName=HealBot_Options_SelectOtherSpellsCombo_List[j]
            if HealBot_GetSpellId(spellName) then
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
            HEALBOT_PAIN_SUPPRESSION,
            HEALBOT_INTERVENE,
            HEALBOT_RESURRECTION,
            HEALBOT_REDEMPTION,
            HEALBOT_REBIRTH,
            HEALBOT_TREE_OF_LIFE,
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
            HEALBOT_CLEANSE_SPIRIT,
            HEALBOT_PURIFY_SPIRIT,
            HEALBOT_MASS_DISPEL,
            HEALBOT_LIFE_TAP,
            HEALBOT_DIVINE_SHIELD,
            HEALBOT_DIVINE_PROTECTION,
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
        }
        for j=1, getn(HealBot_Options_SelectOtherSpellsCombo_List), 1 do
            local spellName=HealBot_Options_SelectOtherSpellsCombo_List[j]
            if HealBot_GetSpellId(spellName) then
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
        }
        HealBot_Options_SelectItemsCombo_List=HealBot_Options_itemsByLevel()
        for j=1, getn(hbItemsIfExists), 1 do
            if IsUsableItem(hbItemsIfExists[j]) or HealBot_IsItemInBag(hbItemsIfExists[j]) then
                table.insert(HealBot_Options_SelectItemsCombo_List, hbItemsIfExists[j])
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

function HealBot_Options_ActionAnchor_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_ActionAnchor_List), 1 do
        info.text = HealBot_Options_ActionAnchor_List[j];
        info.func = function(self)
                        Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["FRAME"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_ActionAnchor,HealBot_Options_ActionAnchor_List[Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["FRAME"]]) 
                        local g=_G["f"..HealBot_Options_StorePrev["FramesSelFrame"].."_HealBot_Action"]
                        HealBot_CheckActionFrame(g,HealBot_Options_StorePrev["FramesSelFrame"])
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
                        HealBot_CheckActionFrame(g,HealBot_Options_StorePrev["FramesSelFrame"])
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
                        if HealBot_Data["REFRESH"]<2 then HealBot_Data["REFRESH"]=2; end
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

function HealBot_Options_FramesSelFrame_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1,10, 1 do
        info.text = HealBot_Options_HealGroupsFrame_List[j];
        info.func = function(self)
                        HealBot_Options_StorePrev["FramesSelFrame"]=self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_FramesSelFrame,HealBot_Options_HealGroupsFrame_List[HealBot_Options_StorePrev["FramesSelFrame"]]) 
                        HealBot_Options_Frame_initCurFrame()
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
                Healbot_Config_Skins.FrameAlias[s][j]["SHOW"]=Healbot_Config_Skins.FrameAlias[s][f]["SHOW"]
                Healbot_Config_Skins.FrameAlias[s][j]["FONT"]=Healbot_Config_Skins.FrameAlias[s][f]["FONT"]
                Healbot_Config_Skins.Anchors[s][j]["GROW"]=Healbot_Config_Skins.Anchors[s][f]["GROW"]
                Healbot_Config_Skins.FrameAlias[s][j]["OUTLINE"]=Healbot_Config_Skins.FrameAlias[s][f]["OUTLINE"]
                Healbot_Config_Skins.FrameAlias[s][j]["R"]=Healbot_Config_Skins.FrameAlias[s][f]["R"]
                Healbot_Config_Skins.FrameAlias[s][j]["G"]=Healbot_Config_Skins.FrameAlias[s][f]["G"]
                Healbot_Config_Skins.FrameAlias[s][j]["B"]=Healbot_Config_Skins.FrameAlias[s][f]["B"]
                Healbot_Config_Skins.FrameAlias[s][j]["A"]=Healbot_Config_Skins.FrameAlias[s][f]["A"]
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
            elseif hbCurSkinSubFrameID==1011 then
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
            elseif hbCurSkinSubFrameID==1012 then
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
            elseif hbCurSkinSubFrameID==1013 then
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
            elseif hbCurSkinSubFrameID==1014 then
                Healbot_Config_Skins.Icons[s][j]["ONBAR"]=Healbot_Config_Skins.Icons[s][f]["ONBAR"]
                Healbot_Config_Skins.Icons[s][j]["POSITION"]=Healbot_Config_Skins.Icons[s][f]["POSITION"]
                Healbot_Config_Skins.Icons[s][j]["DOUBLE"]=Healbot_Config_Skins.Icons[s][f]["DOUBLE"]
                Healbot_Config_Skins.Icons[s][j]["SHOWDEBUFF"]=Healbot_Config_Skins.Icons[s][f]["SHOWDEBUFF"]
                Healbot_Config_Skins.Icons[s][j]["SHOWRC"]=Healbot_Config_Skins.Icons[s][f]["SHOWRC"]
                Healbot_Config_Skins.Icons[s][j]["SHOWDIR"]=Healbot_Config_Skins.Icons[s][f]["SHOWDIR"]
                Healbot_Config_Skins.Icons[s][j]["SHOWDIRMOUSE"]=Healbot_Config_Skins.Icons[s][f]["SHOWDIRMOUSE"]
                Healbot_Config_Skins.Icons[s][j]["SCALE"]=Healbot_Config_Skins.Icons[s][f]["SCALE"]
                Healbot_Config_Skins.Icons[s][j]["I15EN"]=Healbot_Config_Skins.Icons[s][f]["I15EN"]
                Healbot_Config_Skins.Icons[s][j]["SHOWBUFF"]=Healbot_Config_Skins.Icons[s][f]["SHOWBUFF"]
                Healbot_Config_Skins.RaidIcon[s][j]["SHOW"]=Healbot_Config_Skins.RaidIcon[s][f]["SHOW"]
                Healbot_Config_Skins.RaidIcon[s][j]["STAR"]=Healbot_Config_Skins.RaidIcon[s][f]["STAR"]
                Healbot_Config_Skins.RaidIcon[s][j]["CIRCLE"]=Healbot_Config_Skins.RaidIcon[s][f]["CIRCLE"]
                Healbot_Config_Skins.RaidIcon[s][j]["DIAMOND"]=Healbot_Config_Skins.RaidIcon[s][f]["DIAMOND"]
                Healbot_Config_Skins.RaidIcon[s][j]["TRIANGLE"]=Healbot_Config_Skins.RaidIcon[s][f]["TRIANGLE"]
                Healbot_Config_Skins.RaidIcon[s][j]["MOON"]=Healbot_Config_Skins.RaidIcon[s][f]["MOON"]
                Healbot_Config_Skins.RaidIcon[s][j]["SQUARE"]=Healbot_Config_Skins.RaidIcon[s][f]["SQUARE"]
                Healbot_Config_Skins.RaidIcon[s][j]["CROSS"]=Healbot_Config_Skins.RaidIcon[s][f]["CROSS"]
                Healbot_Config_Skins.RaidIcon[s][j]["SKULL"]=Healbot_Config_Skins.RaidIcon[s][f]["SKULL"]
            elseif hbCurSkinSubFrameID==1015 then
                Healbot_Config_Skins.IconText[s][j]["SCNT"]=Healbot_Config_Skins.IconText[s][f]["SCNT"]
                Healbot_Config_Skins.IconText[s][j]["SSCNT"]=Healbot_Config_Skins.IconText[s][f]["SSCNT"]
                Healbot_Config_Skins.IconText[s][j]["SDUR"]=Healbot_Config_Skins.IconText[s][f]["SDUR"]
                Healbot_Config_Skins.IconText[s][j]["SSDUR"]=Healbot_Config_Skins.IconText[s][f]["SSDUR"]
                Healbot_Config_Skins.IconText[s][j]["SCALE"]=Healbot_Config_Skins.IconText[s][f]["SCALE"]
                Healbot_Config_Skins.IconText[s][j]["DURTHRH"]=Healbot_Config_Skins.IconText[s][f]["DURTHRH"]
                Healbot_Config_Skins.IconText[s][j]["DURWARN"]=Healbot_Config_Skins.IconText[s][f]["DURWARN"]
            end
        end
    end
    HealBot_setOptions_Timer(150)
end

--------------------------------------------------------------------------------
local function HealBot_Options_ManaIndicator_DropDown(dropDown, level, menuList)
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_ManaIndicator_List), 1 do
        info.text = HealBot_Options_ManaIndicator_List[j];
     --   info.func = HealBot_Options_ManaIndicator_OnSelect;
        info.func = function(self)
                        Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["LOWMANA"] = self:GetID()
                        UIDropDownMenu_SetSelectedID(HealBot_Options_ManaIndicator,Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["LOWMANA"]) 
                        HealBot_setOptions_Timer(4910)
                    end
        info.checked = false;
        if Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["LOWMANA"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

--------------------------------------------------------------------------------

HealBot_Options_StorePrev["FilterHoTctlName"]=HealBot_Options_FilterHoTctl_List[1]
HealBot_Options_StorePrev["FilterHoTctlNameTrim"]=HealBot_Class_En[HealBot_Options_StorePrev["FilterHoTctlName"]]
HealBot_Options_StorePrev["FilterHoTctlID"]=1

function HealBot_Options_Class_HoTctlName_genList()
    local class=nil
    local tmpHoTctlName_List={}

    for bName,class in pairs(HealBot_Options_Class_HoTctlName_List) do
        if HealBot_Options_StorePrev["FilterHoTctlName"]==class then
            table.insert(tmpHoTctlName_List, bName)
        end
    end
    table.sort(tmpHoTctlName_List)
    local x=nil
    for j=1, getn(tmpHoTctlName_List), 1 do
        if tmpHoTctlName_List[j]==HealBot_Globals.HoTname then
            HealBot_Globals.HoTindex=j
            x=true
            break
        end
    end
    if not x then HealBot_Globals.HoTindex=1 end
    HealBot_Globals.HoTname=tmpHoTctlName_List[HealBot_Globals.HoTindex]
    return tmpHoTctlName_List
end

function HealBot_Options_Class_HoTctlName_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    local HoTctlName_List = HealBot_Options_Class_HoTctlName_genList()
    for j=1, getn(HoTctlName_List), 1 do
        info.text = HoTctlName_List[j];
        info.func = function(self)
                        HealBot_Globals.HoTindex = self:GetID()
                        HealBot_Globals.HoTname = self:GetText()
                        UIDropDownMenu_SetText(HealBot_Options_Class_HoTctlName, HealBot_Globals.HoTname)
                        DoneInitTab[316]=nil
                        HealBot_Options_InitSub(316)
                    end
        info.checked = false;
        if HealBot_Globals.HoTname==HoTctlName_List[j] then info.checked = true; end
        UIDropDownMenu_AddButton(info);
    end
end

--------------------------------------------------------------------------------

function HealBot_Options_Class_HoTctlAction_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_Class_HoTctlAction_List), 1 do
        local hbText = nil
        if HealBot_Options_StorePrev["FilterHoTctlName"]~=HEALBOT_CLASSES_ALL then
            if j==4 then -- was 3
                hbText=HEALBOT_WORD_ALWAYS
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
                                
                            if y>1 then 
                                HealBot_Globals.WatchHoT[HealBot_Options_StorePrev["FilterHoTctlNameTrim"]][HealBot_Globals.HoTname]=y 
                            else
                                HealBot_Globals.WatchHoT[HealBot_Options_StorePrev["FilterHoTctlNameTrim"]][HealBot_Globals.HoTname]=nil
                            end
                            UIDropDownMenu_SetText(HealBot_Options_Class_HoTctlAction,hbText) 
                            HealBot_setOptions_Timer(170)
                        end
            info.checked = false;
            if HealBot_Options_StorePrev["FilterHoTctlNameTrim"] and HealBot_Globals.WatchHoT[HealBot_Options_StorePrev["FilterHoTctlNameTrim"]] then
                local x=HealBot_Globals.WatchHoT[HealBot_Options_StorePrev["FilterHoTctlNameTrim"]][HealBot_Globals.HoTname] or 1
                if x==j then info.checked = true; end 
            end
            UIDropDownMenu_AddButton(info);
        end
    end
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
                       -- HealBot_AddDebug("trim = "..HealBot_Options_StorePrev["FilterHoTctlName"])
                        UIDropDownMenu_SetText(HealBot_Options_FilterHoTctl,HealBot_Options_StorePrev["FilterHoTctlName"]) 
                        DoneInitTab[315]=nil
                        HealBot_Options_InitSub(315)
                        DoneInitTab[316]=nil
                        HealBot_Options_InitSub(316)
                    end
        info.checked = false;
        if HealBot_Options_StorePrev["FilterHoTctlName"]==HealBot_Options_FilterHoTctl_List[j] then info.checked = true; end
        UIDropDownMenu_AddButton(info);
    end
end

--------------------------------------------------------------------------------

HealBot_Options_StorePrev["hbSkinDefaultID"]=1

function HealBot_Options_SkinPartyRaidDefault_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_SkinDefault_List), 1 do
        info.text = HealBot_Options_SkinDefault_List[j];
        info.func = function(self)
                        HealBot_Options_StorePrev["hbSkinDefaultID"] = self:GetID()
                        if HealBot_Options_StorePrev["hbSkinDefaultID"]>1 then
                            for x in pairs (Healbot_Config_Skins.Skins) do
                                if HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]]==HealBot_Options_StorePrev["hbSkinDefaultID"] then HealBot_Config.SkinDefault[Healbot_Config_Skins.Skins[x]]=1 end
                            end
                        end
                        HealBot_Config.SkinDefault[Healbot_Config_Skins.Current_Skin]=HealBot_Options_StorePrev["hbSkinDefaultID"]
                        UIDropDownMenu_SetText(HealBot_Options_SkinPartyRaidDefault,HealBot_Options_SkinDefault_List[HealBot_Options_StorePrev["hbSkinDefaultID"]]) 
                    end
        info.checked = false;
        if HealBot_Config.SkinDefault[Healbot_Config_Skins.Current_Skin]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

--------------------------------------------------------------------------------

function HealBot_Options_AggroAlertLevel_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_AggroAlertLevel_List), 1 do
        info.text = HealBot_Options_AggroAlertLevel_List[j];
        info.func = function(self)
                        Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["ALERT"]=self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_AggroAlertLevel,HealBot_Options_AggroAlertLevel_List[Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["ALERT"]]) 
                    end
        info.checked = false;
        if Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["ALERT"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_AggroIndAlertLevel_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_AggroIndAlertLevel_List), 1 do
        info.text = HealBot_Options_AggroIndAlertLevel_List[j];
        info.func = function(self)
                        Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["ALERTIND"]=self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_AggroIndAlertLevel,HealBot_Options_AggroIndAlertLevel_List[Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["ALERTIND"]]) 
                    end
        info.checked = false;
        if Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["ALERTIND"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

--------------------------------------------------------------------------------

function HealBot_Options_EmergencyFilter_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Options_EmergencyFilter_List), 1 do
        info.text = HealBot_Options_EmergencyFilter_List[j];
        info.func = function(self)
                        Healbot_Config_Skins.EmergIncMonitor[Healbot_Config_Skins.Current_Skin] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_EmergencyFilter,HealBot_Options_EmergencyFilter_List[Healbot_Config_Skins.EmergIncMonitor[Healbot_Config_Skins.Current_Skin]]) 
                        HealBot_setOptions_Timer(60)
                    end
        info.checked = false;
        if Healbot_Config_Skins.EmergIncMonitor[Healbot_Config_Skins.Current_Skin]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_EmergencyFilter_Reset()
  
    HealBot_EmergInc[HealBot_Class_En[HEALBOT_DRUID]] = false;
    HealBot_EmergInc[HealBot_Class_En[HEALBOT_HUNTER]] = false;
    HealBot_EmergInc[HealBot_Class_En[HEALBOT_MAGE]] = false;
    HealBot_EmergInc[HealBot_Class_En[HEALBOT_PALADIN]] = false;
    HealBot_EmergInc[HealBot_Class_En[HEALBOT_PRIEST]] = false;
    HealBot_EmergInc[HealBot_Class_En[HEALBOT_ROGUE]] = false;
    HealBot_EmergInc[HealBot_Class_En[HEALBOT_SHAMAN]] = false;
    HealBot_EmergInc[HealBot_Class_En[HEALBOT_WARLOCK]] = false;
    HealBot_EmergInc[HealBot_Class_En[HEALBOT_WARRIOR]] = false;
    HealBot_EmergInc[HealBot_Class_En[HEALBOT_DEATHKNIGHT]] = false;
    HealBot_EmergInc[HealBot_Class_En[HEALBOT_DEMONHUNTER]] = false;
    if Healbot_Config_Skins.EmergIncMonitor[Healbot_Config_Skins.Current_Skin]==1 then
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_DRUID]] = true;
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_HUNTER]] = true;
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_MAGE]] = true;
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_PALADIN]] = true;
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_PRIEST]] = true;
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_ROGUE]] = true;
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_SHAMAN]] = true;
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_WARLOCK]] = true;
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_WARRIOR]] = true;
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_DEATHKNIGHT]] = true;
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_DEMONHUNTER]] = true;
    elseif Healbot_Config_Skins.EmergIncMonitor[Healbot_Config_Skins.Current_Skin]==2 then
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_DEATHKNIGHT]] = true;
    elseif Healbot_Config_Skins.EmergIncMonitor[Healbot_Config_Skins.Current_Skin]==3 then
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_DRUID]] = true;
    elseif Healbot_Config_Skins.EmergIncMonitor[Healbot_Config_Skins.Current_Skin]==4 then
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_HUNTER]] = true;
    elseif Healbot_Config_Skins.EmergIncMonitor[Healbot_Config_Skins.Current_Skin]==5 then
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_MAGE]] = true;
    elseif Healbot_Config_Skins.EmergIncMonitor[Healbot_Config_Skins.Current_Skin]==6 then
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_MONK]] = true;
    elseif Healbot_Config_Skins.EmergIncMonitor[Healbot_Config_Skins.Current_Skin]==7 then
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_PALADIN]] = true;
    elseif Healbot_Config_Skins.EmergIncMonitor[Healbot_Config_Skins.Current_Skin]==8 then
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_PRIEST]] = true;
    elseif Healbot_Config_Skins.EmergIncMonitor[Healbot_Config_Skins.Current_Skin]==9 then
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_ROGUE]] = true;
    elseif Healbot_Config_Skins.EmergIncMonitor[Healbot_Config_Skins.Current_Skin]==10 then
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_SHAMAN]] = true;
    elseif Healbot_Config_Skins.EmergIncMonitor[Healbot_Config_Skins.Current_Skin]==11 then
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_WARLOCK]] = true;
    elseif Healbot_Config_Skins.EmergIncMonitor[Healbot_Config_Skins.Current_Skin]==12 then
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_WARRIOR]] = true;
    elseif Healbot_Config_Skins.EmergIncMonitor[Healbot_Config_Skins.Current_Skin]==13 then
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_DRUID]] = HealBot_Globals.EmergIncMelee[HEALBOT_DRUID];
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_HUNTER]] = HealBot_Globals.EmergIncMelee[HEALBOT_HUNTER];
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_MAGE]] = HealBot_Globals.EmergIncMelee[HEALBOT_MAGE];
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_PALADIN]] = HealBot_Globals.EmergIncMelee[HEALBOT_PALADIN];
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_PRIEST]] = HealBot_Globals.EmergIncMelee[HEALBOT_PRIEST];
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_ROGUE]] = HealBot_Globals.EmergIncMelee[HEALBOT_ROGUE];
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_SHAMAN]] = HealBot_Globals.EmergIncMelee[HEALBOT_SHAMAN];
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_WARLOCK]] = HealBot_Globals.EmergIncMelee[HEALBOT_WARLOCK];
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_WARRIOR]] = HealBot_Globals.EmergIncMelee[HEALBOT_WARRIOR];
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_DEATHKNIGHT]] = HealBot_Globals.EmergIncMelee[HEALBOT_DEATHKNIGHT];
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_MONK]] = HealBot_Globals.EmergIncMelee[HEALBOT_MONK];
    elseif Healbot_Config_Skins.EmergIncMonitor[Healbot_Config_Skins.Current_Skin]==14 then
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_DRUID]] = HealBot_Globals.EmergIncRange[HEALBOT_DRUID];
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_HUNTER]] = HealBot_Globals.EmergIncRange[HEALBOT_HUNTER];
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_MAGE]] = HealBot_Globals.EmergIncRange[HEALBOT_MAGE];
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_PALADIN]] = HealBot_Globals.EmergIncRange[HEALBOT_PALADIN];
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_PRIEST]] = HealBot_Globals.EmergIncRange[HEALBOT_PRIEST];
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_ROGUE]] = HealBot_Globals.EmergIncRange[HEALBOT_ROGUE];
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_SHAMAN]] = HealBot_Globals.EmergIncRange[HEALBOT_SHAMAN];
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_WARLOCK]] = HealBot_Globals.EmergIncRange[HEALBOT_WARLOCK];
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_WARRIOR]] = HealBot_Globals.EmergIncRange[HEALBOT_WARRIOR];
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_DEATHKNIGHT]] = HealBot_Globals.EmergIncRange[HEALBOT_DEATHKNIGHT];
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_MONK]] = HealBot_Globals.EmergIncRange[HEALBOT_MONK];
    elseif Healbot_Config_Skins.EmergIncMonitor[Healbot_Config_Skins.Current_Skin]==15 then
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_DRUID]] = HealBot_Globals.EmergIncHealers[HEALBOT_DRUID];
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_HUNTER]] = HealBot_Globals.EmergIncHealers[HEALBOT_HUNTER];
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_MAGE]] = HealBot_Globals.EmergIncHealers[HEALBOT_MAGE];
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_PALADIN]] = HealBot_Globals.EmergIncHealers[HEALBOT_PALADIN];
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_PRIEST]] = HealBot_Globals.EmergIncHealers[HEALBOT_PRIEST];
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_ROGUE]] = HealBot_Globals.EmergIncHealers[HEALBOT_ROGUE];
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_SHAMAN]] = HealBot_Globals.EmergIncHealers[HEALBOT_SHAMAN];
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_WARLOCK]] = HealBot_Globals.EmergIncHealers[HEALBOT_WARLOCK];
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_WARRIOR]] = HealBot_Globals.EmergIncHealers[HEALBOT_WARRIOR];
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_DEATHKNIGHT]] = HealBot_Globals.EmergIncHealers[HEALBOT_DEATHKNIGHT];
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_MONK]] = HealBot_Globals.EmergIncHealers[HEALBOT_MONK];
    elseif Healbot_Config_Skins.EmergIncMonitor[Healbot_Config_Skins.Current_Skin]==16 then
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_DRUID]] = HealBot_Globals.EmergIncCustom[HEALBOT_DRUID];
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_HUNTER]] = HealBot_Globals.EmergIncCustom[HEALBOT_HUNTER];
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_MAGE]] = HealBot_Globals.EmergIncCustom[HEALBOT_MAGE];
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_PALADIN]] = HealBot_Globals.EmergIncCustom[HEALBOT_PALADIN];
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_PRIEST]] = HealBot_Globals.EmergIncCustom[HEALBOT_PRIEST];
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_ROGUE]] = HealBot_Globals.EmergIncCustom[HEALBOT_ROGUE];
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_SHAMAN]] = HealBot_Globals.EmergIncCustom[HEALBOT_SHAMAN];
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_WARLOCK]] = HealBot_Globals.EmergIncCustom[HEALBOT_WARLOCK];
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_WARRIOR]] = HealBot_Globals.EmergIncCustom[HEALBOT_WARRIOR];
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_DEATHKNIGHT]] = HealBot_Globals.EmergIncCustom[HEALBOT_DEATHKNIGHT];
        HealBot_EmergInc[HealBot_Class_En[HEALBOT_MONK]] = HealBot_Globals.EmergIncCustom[HEALBOT_MONK];
    end

    if HealBot_Data["REFRESH"]==0 then 
        HealBot_Data["REFRESH"]=1; 
    end
end

function HealBot_Options_retEmergInc(classTrim)
    return HealBot_EmergInc[classTrim]
end
--------------------------------------------------------------------------------

function HealBot_Options_Skins_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_Skins), 1 do
        info.text = HealBot_Skins[j];
        info.func = function(self)
                        Healbot_Config_Skins.Skin_ID = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_Skins,HealBot_Skins[Healbot_Config_Skins.Skin_ID])
                        if self:GetID()>=1 then HealBot_Options_Set_Current_Skin(self:GetText(), "n") end
                    end
        info.checked = false;
        if Healbot_Config_Skins.Skin_ID==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

HealBot_Options_StorePrev["HealBot_Options_notSet_Current_Skin"] = true
function HealBot_Options_Set_Current_Skin(newSkin, ddRefresh)
    if HealBot_Options_StorePrev["HealBot_Options_notSet_Current_Skin"] or newSkin then
        if HealBot_Options_StorePrev["HealBot_Options_notSet_Current_Skin"] then 
            HealBot_Skins = Healbot_Config_Skins.Skins
            HealBot_Options_StorePrev["HealBot_Options_notSet_Current_Skin"]=nil
        end
        if newSkin then
            local hbFoundSkin=nil
            local hbValidSkins=nil
            for j=1, getn(HealBot_Skins), 1 do
                if newSkin==HealBot_Skins[j] then
                    hbFoundSkin=true
                    HealBot_RaidTargetToggle(nil) 
                    Healbot_Config_Skins.Skin_ID = j
                    HealBot_Panel_ClearBarArrays()
                    Healbot_Config_Skins.Current_Skin = HealBot_Skins[j]
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
                    hbValidSkins=hbValidSkins.."  +  "..HealBot_Skins[j]
                else
                    hbValidSkins=HealBot_Skins[j]
                end
            end
            if not hbFoundSkin then
                HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_CHANGESKINERR1..newSkin)
                if hbValidSkins then HealBot_AddChat(HEALBOT_CHAT_ADDONID..HEALBOT_CHAT_CHANGESKINERR2..hbValidSkins) end
            end
            HealBot_setOptions_Timer(180)
            HealBot_setOptions_Timer(185)
            HealBot_setOptions_Timer(188)
           -- HealBot_SetResetFlag("SOFT")
        elseif HealBot_Config.Skin_ID>0 and HealBot_Config.Current_Skin then
            if HealBot_Config.Current_Skin then
	            Healbot_Config_Skins.Current_Skin = HealBot_Config.Current_Skin;
	            Healbot_Config_Skins.Skin_ID = HealBot_Config.Skin_ID;
            end
            if not Healbot_Config_Skins.Skins[HealBot_Config.Current_Skin] then 
                HealBot_Config.Current_Skin=Healbot_Config_Skins.Current_Skin
                HealBot_Config.Skin_ID = Healbot_Config_Skins.Skin_ID
            else
                Healbot_Config_Skins.Current_Skin = HealBot_Config.Current_Skin
                Healbot_Config_Skins.Skin_ID = HealBot_Config.Skin_ID
            end
        else
            if HealBot_Config.Current_Skin then
	            Healbot_Config_Skins.Current_Skin = HealBot_Config.Current_Skin;
	            Healbot_Config_Skins.Skin_ID = HealBot_Config.Skin_ID;
            end
            HealBot_Config.Current_Skin = Healbot_Config_Skins.Current_Skin
            HealBot_Config.Skin_ID = Healbot_Config_Skins.Skin_ID
        end
        HealBot_useCrashProtection()
        if not ddRefresh then 
            DoneInitTab[319]=nil
            HealBot_Options_InitSub(319)
        end
        if HealBot_Data["REFRESH"]<7 then HealBot_Data["REFRESH"]=7 end
    end
end

--------------------------------------------------------------------------------
HealBot_Options_StorePrev["hbShareSkin"]=1
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

function HealBot_Options_rethbTempUnitNames()
    local hbTempShareUnitNames={}
    HealBot_Options_StorePrev["hbTempNumUnitNames"]=0
    local x=GetNumFriends()
    if x>0 then
        for y=1,x do
            local uName, _, _, _, z = GetFriendInfo(y)
            if z and hbMyFriends[uName] then
                hbTempShareUnitNames[uName]="F"
                HealBot_Options_StorePrev["hbTempNumUnitNames"]=HealBot_Options_StorePrev["hbTempNumUnitNames"]+1
            end
        end
    end
    x=BNGetNumFriends()
    if x>0 then
        for y=1,x do
           local _, _, _, uName, _, _, isOnline = BNGetFriendInfo(y)
           if isOnline and hbMyFriends[uName] then
               hbTempShareUnitNames[uName]="B"
               HealBot_Options_StorePrev["hbTempNumUnitNames"]=HealBot_Options_StorePrev["hbTempNumUnitNames"]+1
           end
       end
    end 
    x=GetNumGuildMembers()
    if x>0 then
        for y=1,x do
            local uName, _, _, _, _, _, _, _, z = GetGuildRosterInfo(y)
            if z and hbMyGuildMates[uName] then
                hbTempShareUnitNames[uName]="G"
                HealBot_Options_StorePrev["hbTempNumUnitNames"]=HealBot_Options_StorePrev["hbTempNumUnitNames"]+1
            end
        end
    end
    local hbOptUsers=HealBot_GetInfo()
    for uName,_ in pairs(hbOptUsers) do
        if uName~=HealBot_Data["PNAME"] and not hbTempShareUnitNames[uName] then
            local xUnit=HealBot_Panel_RaidUnit(nil,uName)
            if xUnit then
                hbTempShareUnitNames[uName]="R"
                HealBot_Options_StorePrev["hbTempNumUnitNames"]=HealBot_Options_StorePrev["hbTempNumUnitNames"]+1
            end
        end
    end
    hbTempShareUnitNames[HEALBOT_ABOUT_URL]="X"
    HealBot_Options_StorePrev["hbTempNumUnitNames"]=HealBot_Options_StorePrev["hbTempNumUnitNames"]+1
  --  HealBot_AddDebug("Num ShareUnitNames="..HealBot_Options_StorePrev["hbTempNumUnitNames"])
    return hbTempShareUnitNames
end

HealBot_Options_StorePrev["hbCurUnitName"]=HEALBOT_WORDS_NONE
function HealBot_Options_ShareSkin_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    local hbShareUnitNames=HealBot_Options_rethbTempUnitNames()
    local i=1
    info.text = strlower(HEALBOT_WORDS_NONE);
    info.func = function(self)
                    HealBot_Options_StorePrev["hbShareSkin"] = self:GetID()
                    HealBot_Options_StorePrev["hbCurUnitName"] = self:GetText()
                    UIDropDownMenu_SetText(HealBot_Options_ShareSkin,HEALBOT_WORDS_NONE) 
                end
    info.checked = false;
    if HealBot_Options_StorePrev["hbShareSkin"]==i then info.checked = true end
    UIDropDownMenu_AddButton(info);
    if HealBot_Options_StorePrev["hbTempNumUnitNames"]>0 then
        for x,_ in pairs(hbShareUnitNames) do
            local pName = x
            i=i+1
            info.text = pName;
            info.func = function(self)
                            HealBot_Options_StorePrev["hbShareSkin"] = self:GetID()
                            HealBot_Options_StorePrev["hbCurUnitName"] = self:GetText()
                            UIDropDownMenu_SetText(HealBot_Options_ShareSkin,pName) 
                        end
            info.checked = false;
            if HealBot_Options_StorePrev["hbShareSkin"]==i then info.checked = true end
            UIDropDownMenu_AddButton(info);
        end
    end
end

function HealBot_Options_ShareSkinb_OnClick()
    if HealBot_Options_StorePrev["hbCurUnitName"] and HealBot_Options_StorePrev["hbCurUnitName"]==HEALBOT_ABOUT_URL then
        HealBot_Options_BuildSkinSendMsg(Healbot_Config_Skins.Current_Skin,HEALBOT_ABOUT_URL)
    elseif HealBot_Options_StorePrev["hbCurUnitName"] and HealBot_Options_StorePrev["hbCurUnitName"]~=strlower(HEALBOT_WORDS_NONE) then
        HealBot_Options_ShareSkinSend("A", Healbot_Config_Skins.Current_Skin, HealBot_Options_StorePrev["hbCurUnitName"])
    end
end

function HealBot_Options_LoadSkinb_OnClick()
    HealBot_Options_ShareSkinLoad()
end

function HealBot_Options_ShareSkinSend(status,skinName,unitName)
    local hbOptUsers=HealBot_GetInfo()
    if hbOptUsers and type(hbOptUsers)=="table" and hbOptUsers[unitName] then
        local hbFoundSkin=HealBot_Options_checkSkinName(skinName)
        if hbFoundSkin then
            if status=="A" then
                HealBot_Comms_SendAddonMsg("HealBot", "X:"..skinName, 4, unitName)
            else
                HealBot_Options_BuildSkinSendMsg(skinName,unitName)
            end
        else
            HealBot_AddChat(HEALBOT_CHAT_ADDONID..skinName..HEALBOT_CHAT_SHARESKINERR1);
        end
    else
        HealBot_AddChat(HEALBOT_CHAT_ADDONID..unitName..HEALBOT_CHAT_SHARESKINERR3);
    end
end

local hbAccpetedSkin="none"
local hbWarnSharedMedia=false
function HealBot_Options_ShareSkinRec(status, cmd, parts, msg)
    if status=="X" then
        hbOptGetSkinFrom, hbOptGetSkinName = string.split("!", cmd)
        if hbOptGetSkinFrom and hbOptGetSkinName then
            StaticPopupDialogs["HEALBOT_OPTIONS_ACCEPTSKIN"] = {
                text = HEALBOT_OPTIONS_ACCEPTSKINMSG.."%s",
                button1 = HEALBOT_WORDS_YES,
                button2 = HEALBOT_WORDS_NO,
                OnAccept = function()
                    HealBot_Options_ShareSkinAccept();
                end,
                timeout = 0,
                whileDead = 1,
                hideOnEscape = 1
            };
        
            StaticPopup_Show ("HEALBOT_OPTIONS_ACCEPTSKIN", " "..hbOptGetSkinName..HEALBOT_OPTIONS_ACCEPTSKINMSGFROM..hbOptGetSkinFrom);
        end
    elseif hbOptGetSkinName and hbAccpetedSkin==hbOptGetSkinFrom then
        HealBot_Options_BuildSkinRecMsg(hbOptGetSkinName, cmd, tonumber(parts), msg)
        if cmd=="Complete" then
            HealBot_Options_ShareSkinComplete()
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
        hbOptGetSkinName=ssTab[1]
        for e=2,#ssTab do 
            local c,m = string.split("!", ssTab[e])
            HealBot_Options_BuildSkinRecMsg(hbOptGetSkinName, c, 0, m)
        end
        hbOptGetSkinFrom=HEALBOT_ABOUT_URL
        HealBot_Options_ShareSkinComplete()
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
    table.foreach(HealBot_Skins, function (index,skin)
        if skin==hbOptGetSkinName then unique=false; end
    end)
    if unique then
        table.insert(HealBot_Skins,2,hbOptGetSkinName)
        Healbot_Config_Skins.Skin_ID = 2;
        Healbot_Config_Skins.Skins = HealBot_Skins
    end
    Healbot_Config_Skins.Current_Skin = hbOptGetSkinName
    HealBot_Config.LastVersionSkinUpdate=HealBot_lastVerSkinUpdate
    HealBot_Update_Skins()
    HealBot_Options_SetSkins();
    HealBot_Options_NewSkin:SetText("")
    hbAccpetedSkin="none"
    hbWarnSharedMedia=false
    HealBot_AddChat(HEALBOT_CHAT_ADDONID..hbOptGetSkinName..HEALBOT_CHAT_SKINREC..hbOptGetSkinFrom)
    HealBot_SetResetFlag("SOFT")
    if HealBot_Data["REFRESH"]<4 then HealBot_Data["REFRESH"]=4; end
end

function HealBot_Options_checkSkinName(skinName)
    local hbFoundSkin=nil
    for j=1, getn(HealBot_Skins), 1 do
        if skinName==HealBot_Skins[j] then
            hbFoundSkin=true
            break
        end
    end
    return hbFoundSkin
end

function HealBot_Options_ShareSkinAccept()
    HealBot_Comms_SendAddonMsg("HealBot", "Y:"..hbOptGetSkinName, 4, hbOptGetSkinFrom)
    hbAccpetedSkin=hbOptGetSkinFrom
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
    table.insert( result, HealBot_Options_val2str( v ) )
    done[ k ] = true
  end
  for k, v in pairs( tbl ) do
    if not done[ k ] then
      table.insert( result,
        HealBot_Options_key2str( k ) .. "=" .. HealBot_Options_val2str( v ) )
    end
  end
  return "{" .. table.concat( result, "," ) .. "}"
end

function HealBot_Options_BuildSkinSendMsg(skinName, unitName)
    local SkinVars={'Author', 'EmergIncMonitor'}
    local SkinTabVars={'ExtraIncGroup', 'Chat', 'Sort', 'General', 'Healing', 'Highlight', 'Aggro', 'Protection', 'BarsHide', 'Enemy'}
    local SkinTabFrameVars={'FrameAlias', 'Frame', 'HealGroups', 'Anchors', 'HeadBar', 'HeadText', 'HealBar', 'BarCol', 'BarIACol', 'BarText', 'BarTextCol', 'Icons', 'RaidIcon', 'IconText'}
    HealBot_ShareSkinSendMsg("Init", skinName, unitName)
    for j=1, getn(SkinVars), 1 do
        local varName=SkinVars[j]
        local tabStr=Healbot_Config_Skins[varName][skinName]
        HealBot_ShareSkinSendMsg(varName.."~v", tabStr, unitName)
    end
    for j=1, getn(SkinTabVars), 1 do
        local varName=SkinTabVars[j]
        local tabStr=HealBot_Options_tab2str(Healbot_Config_Skins[varName][skinName])
        HealBot_ShareSkinSendMsg(varName.."~t", tabStr, unitName)
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
            d[1],d[2],d[3],d[4],d[5],d[6],d[7],d[8],d[9],d[10],d[11],d[12],d[13],d[14],d[15],d[16],d[17],d[18]=string.split(",", lMsg)
            for j=1,18 do
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
                    HealBot_ShareSkinSendMsg(varName.."~d", dups, unitName) 
                end
            else
                if string.len(dups)>1 then 
                    HealBot_ShareSkinSendMsg(varName.."~d", dups, unitName) 
                    dups=""
                end
                HealBot_ShareSkinSendMsg(varName.."~f~"..i, tabStr, unitName)
            end
        end
        if varName=="HealGroups" then
            tabStr=HealBot_Options_tab2str(Healbot_Config_Skins[varName][skinName][11])
            HealBot_ShareSkinSendMsg(varName.."~f~11", tabStr, unitName)
        end
    end
    HealBot_ShareSkinSendMsg("Complete", "", unitName)
end

local tmpRecParts={}
local lFrame=1
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
    if vType=="f" then
        if not Healbot_Config_Skins[varName][skinName] then Healbot_Config_Skins[varName][skinName]={} end
        for j=1,10 do
            if not Healbot_Config_Skins[varName][skinName][j] then Healbot_Config_Skins[varName][skinName][j]={} end
        end
        if varName=="HealGroups" then
            if not Healbot_Config_Skins[varName][skinName][11] then Healbot_Config_Skins[varName][skinName][11]={} end
        end
        local lMsg=strsub(msg,2,string.len(msg)-1)
        local d={}
        d[1],d[2],d[3],d[4],d[5],d[6],d[7],d[8],d[9],d[10],d[11],d[12],d[13],d[14],d[15],d[16],d[17],d[18]=string.split(",", lMsg)
        for j=1,18 do
            if d[j] then
                local var, dat=string.split("=", d[j])
                if tonumber(dat) then dat=tonumber(dat) end
                if tonumber(fNo) then fNo=tonumber(fNo) end
                if var and dat then Healbot_Config_Skins[varName][skinName][fNo][var]=dat end
                lFrame=fNo
            end
        end
    elseif vType=="d" then
        local dups={}
        dups[9],dups[8],dups[7],dups[6],dups[5],dups[4],dups[3],dups[2],dups[1]=string.split("~", msg)
        for j=1,9 do
            if dups[j] then 
                local f=nil
                if tonumber(dups[j]) then f=tonumber(dups[j]) end
                if f then Healbot_Config_Skins[varName][skinName][f]=HealBot_Options_copyTable(Healbot_Config_Skins[varName][skinName][lFrame]) end
            end
        end
    elseif vType=="t" then
        if not Healbot_Config_Skins[varName][skinName] then Healbot_Config_Skins[varName][skinName]={} end
        if varName=="ExtraIncGroup" then
            local lMsg=strsub(msg,2,string.len(msg)-1)
            local d={}
            d[1],d[2],d[3],d[4],d[5],d[6],d[7],d[8]=string.split(",", lMsg)
            for j=1,8 do
                if d[j]=="true" then
                    Healbot_Config_Skins[varName][skinName][j]=true
                else
                    Healbot_Config_Skins[varName][skinName][j]=false
                end
            end
        else
            local lMsg=strsub(msg,2,string.len(msg)-1)
            local d={}
            d[1],d[2],d[3],d[4],d[5],d[6],d[7],d[8],d[9],d[10],d[11],d[12],d[13],d[14],d[15],d[16],d[17],d[18]=string.split(",", lMsg)
            for j=1,18 do
                if d[j] then
                    local var, dat=string.split("=", d[j])
                    if tonumber(dat) then dat=tonumber(dat) end
                    if var and dat then Healbot_Config_Skins[varName][skinName][var]=dat end
                end
            end
        end
    elseif vType=="v" then
        if tonumber(msg) then msg=tonumber(msg) end
        Healbot_Config_Skins[varName][skinName]=msg
    end
    --HealBot_AddDebug("ShareMsg cmd="..cmd)
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

--------------------------------------------------------------------------------

function HealBot_Options_CDCTxt1_DropDown()
    local DebuffSpells_List = HealBot_Options_GetDebuffSpells_List(HealBot_Data["PCLASSTRIM"])
    local RacialDebuffSpells_List = HealBot_Options_GetRacialDebuffSpells_List(HealBot_Data["PRACETRIM"])
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
        local sName=DebuffSpells_List[j]
        if HealBot_GetSpellId(sName) then
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
        local rName = RacialDebuffSpells_List[j];
        info.text = rName
        info.func = function(self)
                        HealBot_Config_Cures.HealBotDebuffText[HealBot_Options_getDropDownId_bySpec(1)] = self:GetText()
                        HealBot_setOptions_Timer(50)
                        UIDropDownMenu_SetText(HealBot_Options_CDCTxt1,rName)
                    end
        info.checked = false;
        if HealBot_Config_Cures.HealBotDebuffText[HealBot_Options_getDropDownId_bySpec(1)]==RacialDebuffSpells_List[j] then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
    for j=1, getn(HealBot_Debuff_Item_List), 1 do
        local iName = HealBot_Debuff_Item_List[j];
        info.text = iName
        info.func = function(self)
                        HealBot_Config_Cures.HealBotDebuffText[HealBot_Options_getDropDownId_bySpec(1)] = self:GetText()
                        HealBot_setOptions_Timer(50)
                        UIDropDownMenu_SetText(HealBot_Options_CDCTxt1,iName)
                    end
        info.checked = false;
        if HealBot_Config_Cures.HealBotDebuffText[HealBot_Options_getDropDownId_bySpec(1)]==HealBot_Debuff_Item_List[j] then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_CDCTxt2_DropDown()
    local DebuffSpells_List = HealBot_Options_GetDebuffSpells_List(HealBot_Data["PCLASSTRIM"])
    local RacialDebuffSpells_List = HealBot_Options_GetRacialDebuffSpells_List(HealBot_Data["PRACETRIM"])
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
        local sName=DebuffSpells_List[j]
        if HealBot_GetSpellId(sName) then
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
        local rName = RacialDebuffSpells_List[j];
        info.text = rName
        info.func = function(self)
                        HealBot_Config_Cures.HealBotDebuffText[HealBot_Options_getDropDownId_bySpec(2)] = self:GetText()
                        HealBot_setOptions_Timer(50)
                        UIDropDownMenu_SetText(HealBot_Options_CDCTxt2,rName)
                    end
        info.checked = false;
        if HealBot_Config_Cures.HealBotDebuffText[HealBot_Options_getDropDownId_bySpec(2)]==RacialDebuffSpells_List[j] then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
    for j=1, getn(HealBot_Debuff_Item_List), 1 do
        local iName = HealBot_Debuff_Item_List[j];
        info.text = iName
        info.func = function(self)
                        HealBot_Config_Cures.HealBotDebuffText[HealBot_Options_getDropDownId_bySpec(2)] = self:GetText()
                        HealBot_setOptions_Timer(50)
                        UIDropDownMenu_SetText(HealBot_Options_CDCTxt2,iName)
                    end
        info.checked = false;
        if HealBot_Config_Cures.HealBotDebuffText[HealBot_Options_getDropDownId_bySpec(2)]==HealBot_Debuff_Item_List[j] then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_CDCTxt3_DropDown()
    local DebuffSpells_List = HealBot_Options_GetDebuffSpells_List(HealBot_Data["PCLASSTRIM"])
    local RacialDebuffSpells_List = HealBot_Options_GetRacialDebuffSpells_List(HealBot_Data["PRACETRIM"])
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
        local sName=DebuffSpells_List[j]
        if HealBot_GetSpellId(sName) then
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
        local rName = RacialDebuffSpells_List[j];
        info.text = rName
        info.func = function(self)
                        HealBot_Config_Cures.HealBotDebuffText[HealBot_Options_getDropDownId_bySpec(3)] = self:GetText()
                        HealBot_setOptions_Timer(50)
                        UIDropDownMenu_SetText(HealBot_Options_CDCTxt3,rName)
                    end
        info.checked = false;
        if HealBot_Config_Cures.HealBotDebuffText[HealBot_Options_getDropDownId_bySpec(3)]==RacialDebuffSpells_List[j] then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
    for j=1, getn(HealBot_Debuff_Item_List), 1 do
        local iName = HealBot_Debuff_Item_List[j];
        info.text = iName
        info.func = function(self)
                        HealBot_Config_Cures.HealBotDebuffText[HealBot_Options_getDropDownId_bySpec(3)] = self:GetText()
                        HealBot_setOptions_Timer(50)
                        UIDropDownMenu_SetText(HealBot_Options_CDCTxt3,iName)
                    end
        info.checked = false;
        if HealBot_Config_Cures.HealBotDebuffText[HealBot_Options_getDropDownId_bySpec(3)]==HealBot_Debuff_Item_List[j] then info.checked = true end
        UIDropDownMenu_AddButton(info);
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
    if HealBot_Options_StorePrev["CDebuffcustomNameDefault"]==HEALBOT_CUSTOM_CAT_CUSTOM_IMPORTANT then
        s,e=9,9
    elseif HealBot_Options_StorePrev["CDebuffcustomNameDefault"]==HEALBOT_CUSTOM_CAT_CUSTOM_MISC then
        s,e=12,12
    elseif HealBot_Options_StorePrev["CDebuffcustomNameDefault"]==HEALBOT_CUSTOM_CAT_CUSTOM_EFFECT then
        s,e=11,11
    elseif HealBot_Options_StorePrev["CDebuffcustomNameDefault"]==HEALBOT_CUSTOM_CAT_CUSTOM_DAMAGE then
        s,e=10,10
    end
    for j=s, e, 1 do
        info.text = j;
        info.func = function(self)
                        local x=self:GetID()
                        if HealBot_Options_StorePrev["CDebuffcustomName"] then
                            cName=HealBot_Options_StorePrev["CDebuffcustomName"]
                            HealBot_Globals.HealBot_Custom_Debuffs[cName] = x
                            HealBot_Options_CDC_checkStatus(cName)
                        end
                        UIDropDownMenu_SetSelectedID(HealBot_Options_CDCPriorityC,x) 
                        HealBot_Options_setCustomDebuffList()
                    end
        info.checked = false;
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_CDC_checkStatus(cName)
    if not cName then return end
    
    if (HealBot_GlobalsDefaults.HealBot_Custom_Debuffs[cName] or 0)~=HealBot_Globals.HealBot_Custom_Debuffs[cName] then
        if not HealBot_Globals.CDCBarColour[cName] then
            cPriority=HealBot_Globals.HealBot_Custom_Debuffs[cName]
            if cPriority<9 then 
                cPriority=9 
            elseif cPriority>12 then 
                cPriority=12 
            end
            cPriority=HEALBOT_CUSTOM_en..cPriority
            HealBot_Globals.CDCBarColour[cName]={}
            HealBot_Globals.CDCBarColour[cName].R = HealBot_Globals.CDCBarColour[cPriority].R
            HealBot_Globals.CDCBarColour[cName].G = HealBot_Globals.CDCBarColour[cPriority].G
            HealBot_Globals.CDCBarColour[cName].B = HealBot_Globals.CDCBarColour[cPriority].B
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

function HealBot_Options_CDebuffCat_genList()
    local tmpCDebuffCat_List={}
    local j=0
    for dName,x in pairs(HealBot_Globals.Custom_Debuff_Categories) do
        if HealBot_Options_StorePrev["CDebuffCatID"]==x and HealBot_Globals.HealBot_Custom_Debuffs[dName] then
            table.insert(tmpCDebuffCat_List, dName)
            j=j+1
        end
    end
    local x=nil
    if j>0 then
        table.sort(tmpCDebuffCat_List)
        for j=1, getn(tmpCDebuffCat_List), 1 do
            if tmpCDebuffCat_List[j]==HealBot_Options_StorePrev["CDebuffcustomName"] then
                HealBot_Options_StorePrev["CDebuffcustomID"]=j
                x=true
                break
            end
        end
    end
    if not x then 
        HealBot_Options_StorePrev["CDebuffcustomID"]=1 
        HealBot_Options_StorePrev["CDebuffcustomNameDefault"]=tmpCDebuffCat_List[HealBot_Options_StorePrev["CDebuffcustomID"]]
        HealBot_Options_CDebuffCatNameUpdate()
    end
    HealBot_Options_StorePrev["CDebuffcustomName"]=tmpCDebuffCat_List[HealBot_Options_StorePrev["CDebuffcustomID"]]
    return tmpCDebuffCat_List
end

function HealBot_Options_CDebuffCat_DropDown()
    local info = UIDropDownMenu_CreateInfo()
    for j=1, getn(HealBot_CDebuffCat_List), 1 do
        info.text = HealBot_CDebuffCat_List[j];
        info.func = function(self)
                        HealBot_Options_StorePrev["CDebuffCatID"] = self:GetID()
                        UIDropDownMenu_SetText(HealBot_Options_CDebuffCat,HealBot_CDebuffCat_List[HealBot_Options_StorePrev["CDebuffCatID"]]) 
                        HealBot_Options_InitSub(407)
                        HealBot_Options_InitSub(408)
                        HealBot_Options_InitSub(419)
                        HealBot_Options_StorePrev["CDebuffcustomNameDefault"]=HealBot_Options_StorePrev["CDebuffcustomName"]
                        HealBot_Options_CDebuffCatNameUpdate()
                        HealBot_SetCDCBarColours();
                        --if HealBot_Options_StorePrev["CDebuffCatID"]==1 then
                        --    HealBot_Options_NewCDebuffBtn:Disable();
                        --end
                    end
        info.checked = false;
        if HealBot_Options_StorePrev["CDebuffCatID"]==j then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_CDebuffTxt1_DropDown() -- added by Diacono
    local info = UIDropDownMenu_CreateInfo()
    local CDebuffCat_List = HealBot_Options_CDebuffCat_genList()
    for j=1, getn(CDebuffCat_List), 1 do
        info.text = CDebuffCat_List[j];
        info.func = function(self)
                        HealBot_Options_StorePrev["CDebuffcustomID"] = self:GetID()
                        HealBot_Options_StorePrev["CDebuffcustomName"] = self.value
                        HealBot_Options_StorePrev["CDebuffcustomNameDefault"]=HealBot_Options_StorePrev["CDebuffcustomName"]
                        --UIDropDownMenu_SetSelectedID(HealBot_Options_CDebuffTxt1,HealBot_Options_StorePrev["CDebuffcustomID"]) 
                        UIDropDownMenu_SetText(HealBot_Options_CDebuffTxt1,HealBot_Options_StorePrev["CDebuffcustomName"]) 
                        HealBot_Options_CDebuffCatNameUpdate()
                        HealBot_Options_InitSub(408)
                        HealBot_Options_InitSub(419)
                        HealBot_SetCDCBarColours();
                    end
        info.checked = false;
        if HealBot_Options_StorePrev["CDebuffcustomNameDefault"]==CDebuffCat_List[j] then info.checked = true end
        UIDropDownMenu_AddButton(info);
    end
end

function HealBot_Options_CDebuffCatNameUpdate()
    if HealBot_Options_StorePrev["CDebuffCatID"]==1 then
        if HealBot_Options_StorePrev["CDebuffcustomNameDefault"]==HEALBOT_CUSTOM_CAT_CUSTOM_IMPORTANT then
            HealBot_Options_StorePrev["customDebuffPriority"]=9
        elseif HealBot_Options_StorePrev["CDebuffcustomNameDefault"]==HEALBOT_CUSTOM_CAT_CUSTOM_MISC then
            HealBot_Options_StorePrev["customDebuffPriority"]=12
        elseif HealBot_Options_StorePrev["CDebuffcustomNameDefault"]==HEALBOT_CUSTOM_CAT_CUSTOM_EFFECT then
            HealBot_Options_StorePrev["customDebuffPriority"]=11
        else
            --HEALBOT_CUSTOM_CAT_CUSTOM_DAMAGE
            HealBot_Options_StorePrev["customDebuffPriority"]=10
        end
        --HealBot_Options_StorePrev["CDebuffcustomName"]=nil
        --HealBot_Options_DeleteCDebuffBtn:Disable();
        HealBot_Options_ResetCDebuffBtn:Disable();
        HealBot_Options_NewCDebuffBtn:Disable();
        HealBot_Options_CDCCastBy:Hide();
        HealBot_Options_CDCCastByCustom:Show()
        --HealBot_Options_CDCPriorityC:Hide()
    else
        if HealBot_GlobalsDefaults.HealBot_Custom_Debuffs[HealBot_Options_StorePrev["CDebuffcustomNameDefault"]] then
            HealBot_Options_StorePrev["customDebuffPriority"]=HealBot_GlobalsDefaults.HealBot_Custom_Debuffs[HealBot_Options_StorePrev["CDebuffcustomNameDefault"]]
        end
        --HealBot_Options_DeleteCDebuffBtn:Enable();
        HealBot_Options_ResetCDebuffBtn:Enable();
        HealBot_Options_CDCCastByCustom:Hide()
        HealBot_Options_CDCCastBy:Show();
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

function HealBot_Options_GetSpellInfo_OnEnterPressed(self)
    local text = strtrim(self:GetText())
    if tonumber(text) then
        text = GetSpellInfo(text)
    end
    self:SetText(text or "")
end

function HealBot_Options_NewCDebuffBtn_OnClick(self)
    local NewCDebuffTxt=HealBot_Options_NewCDebuff:GetText()
    local unique=true;
    for k, _ in pairs(HealBot_Globals.HealBot_Custom_Debuffs) do
        if k==NewCDebuffTxt then unique=false; end
    end
    if unique then
        HealBot_Globals.HealBot_Custom_Debuffs[NewCDebuffTxt]=10;
    end
    HealBot_Globals.Custom_Debuff_Categories[NewCDebuffTxt]=HealBot_Options_StorePrev["CDebuffCatID"]
    HealBot_Options_StorePrev["CDebuffcustomName"]=NewCDebuffTxt
    HealBot_Options_NewCDebuff:SetText("")
    HealBot_Options_InitSub(407)
    HealBot_Options_InitSub(408)
    HealBot_Options_InitSub(419)
  --  UIDropDownMenu_SetSelectedValue(HealBot_Options_CDebuffTxt1, NewCDebuffTxt);
    HealBot_CheckAllDebuffs()
end

function HealBot_Options_ConfirmNewCDebuff()
    local NewCDebuffTxt=strtrim(HealBot_Options_NewCDebuff:GetText())
    HealBot_Options_NewCDebuff:SetText(NewCDebuffTxt)
    if tonumber(NewCDebuffTxt) then
        NewCDebuffTxt = GetSpellInfo(NewCDebuffTxt)
        if not NewCDebuffTxt then 
            StaticPopupDialogs["HEALBOT_OPTIONS_ERROR"] = {
                text = HEALBOT_WORDS_ERROR..": %s",
                button1 = OKAY,
                showAlert = 1,
                timeout = 0,
                whileDead = 1,
                hideOnEscape = 1
            };
        
            StaticPopup_Show ("HEALBOT_OPTIONS_ERROR", HEALBOT_SPELL_NOT_FOUND);
        else
            HealBot_Options_NewCDebuff:SetText(NewCDebuffTxt)
        end
    end
    if NewCDebuffTxt and NewCDebuffTxt ~= "" then
        StaticPopupDialogs["HEALBOT_OPTIONS_NEWCDEBUFF"] = {
            text = HEALBOT_OPTIONS_SAVESKIN..": %s",
            button1 = HEALBOT_WORDS_YES,
            button2 = HEALBOT_WORDS_NO,
            OnAccept = function()
                HealBot_Options_NewCDebuffBtn_OnClick(HealBot_Options_NewCDebuffBtn)
            end,
            timeout = 0,
            whileDead = 1,
            hideOnEscape = 1
        };
    
        StaticPopup_Show ("HEALBOT_OPTIONS_NEWCDEBUFF", NewCDebuffTxt);
    end
end

function HealBot_Options_DeleteCDebuffBtn_OnClick(self)
    if HealBot_Options_StorePrev["CDebuffCatID"]==1 then
        HealBot_Options_delCustomPrio(HealBot_Options_StorePrev["customDebuffPriority"])
    else
        HealBot_Globals.Custom_Debuff_Categories[HealBot_Options_StorePrev["CDebuffcustomName"]]=nil;
        HealBot_Globals.HealBot_Custom_Debuffs[HealBot_Options_StorePrev["CDebuffcustomName"]]=nil;
        if HealBot_Globals.CDCBarColour[HealBot_Options_StorePrev["CDebuffcustomName"]] then HealBot_Globals.CDCBarColour[HealBot_Options_StorePrev["CDebuffcustomName"]]=nil end
        HealBot_Globals.HealBot_Custom_Debuffs_RevDur[HealBot_Options_StorePrev["CDebuffcustomName"]]=nil
        HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[HealBot_Options_StorePrev["CDebuffcustomName"]]=nil
        if HealBot_Globals.FilterCustomDebuff[HealBot_Options_StorePrev["CDebuffcustomName"]] then HealBot_Globals.FilterCustomDebuff[HealBot_Options_StorePrev["CDebuffcustomName"]]=nil end
        HealBot_Options_InitSub(407)
        HealBot_Options_InitSub(408)
        HealBot_Options_InitSub(419)
        HealBot_SetCDCBarColours();
    end
end

function HealBot_Options_EnableDisableCDBtn_OnClick(self)
    local InstName=HealBot_rethbInsName()
    if HealBot_Globals.IgnoreCustomDebuff[HealBot_Options_StorePrev["CDebuffcustomName"]] and HealBot_Globals.IgnoreCustomDebuff[HealBot_Options_StorePrev["CDebuffcustomName"]][InstName] then
        HealBot_Globals.IgnoreCustomDebuff[HealBot_Options_StorePrev["CDebuffcustomName"]][InstName]=nil
    else
        if not HealBot_Globals.IgnoreCustomDebuff[HealBot_Options_StorePrev["CDebuffcustomName"]] then
            HealBot_Globals.IgnoreCustomDebuff[HealBot_Options_StorePrev["CDebuffcustomName"]]={}
        end
        HealBot_Globals.IgnoreCustomDebuff[HealBot_Options_StorePrev["CDebuffcustomName"]][InstName]=true
    end
    HealBot_Options_SetEnableDisableCDBtn()
end

function HealBot_Options_SetEnableDisableCDBtn()
    local InstName=HealBot_rethbInsName()
    HealBot_Options_EnableDisableCDBtn:Enable()
    if HealBot_Globals.IgnoreCustomDebuff[HealBot_Options_StorePrev["CDebuffcustomName"]] and HealBot_Globals.IgnoreCustomDebuff[HealBot_Options_StorePrev["CDebuffcustomName"]][InstName] then
        HealBot_Options_EnableDisableCDText:SetTextColor(0.88,0.1,0.1)
        HealBot_Options_EnableDisableCDText:SetText(InstName..": "..HealBot_Options_StorePrev["CDebuffcustomName"].." "..HEALBOT_SKIN_DISTEXT)
        HealBot_Options_EnableDisableCDBtn:SetText(HEALBOT_WORD_ENABLE)
    elseif HealBot_Options_StorePrev["CDebuffcustomName"] and HealBot_Options_StorePrev["CDebuffCatID"]>1 then
        HealBot_Options_EnableDisableCDText:SetTextColor(0.1,1,0.1)
        HealBot_Options_EnableDisableCDText:SetText(InstName..": "..HealBot_Options_StorePrev["CDebuffcustomName"].." "..HEALBOT_SKIN_ENTEXT)
        HealBot_Options_EnableDisableCDBtn:SetText(HEALBOT_WORD_DISABLE)
    else
        HealBot_Options_EnableDisableCDText:SetTextColor(0.7,0.7,0)
        HealBot_Options_EnableDisableCDText:SetText(" ")
        HealBot_Options_EnableDisableCDBtn:SetText(HEALBOT_WORD_DISABLE)
        HealBot_Options_EnableDisableCDBtn:Disable()
    end
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

function HealBot_Options_ResetCDebuff()
    local dName=HealBot_Options_StorePrev["CDebuffcustomName"]
    HealBot_Globals.HealBot_Custom_Debuffs[dName]=HealBot_GlobalsDefaults.HealBot_Custom_Debuffs[dName] or 10;
    if HealBot_Globals.CDCBarColour[dName] then HealBot_Globals.CDCBarColour[dName]=nil end
    HealBot_Options_InitSub(407)
    HealBot_Options_InitSub(408)
    HealBot_Options_InitSub(419)
    HealBot_SetCDCBarColours();
end

function HealBot_Options_delCustomPrio(priority)
    for dName, x in pairs(HealBot_Globals.HealBot_Custom_Debuffs) do
        if x==priority then
            HealBot_Globals.Custom_Debuff_Categories[dName]=nil;
            HealBot_Globals.HealBot_Custom_Debuffs[dName]=nil;
            if HealBot_Globals.CDCBarColour[dName] then HealBot_Globals.CDCBarColour[dName]=nil end
        end
    end
    HealBot_Options_InitSub(407)
    HealBot_Options_InitSub(408)
    HealBot_Options_InitSub(419)
    HealBot_SetCDCBarColours();
end

function HealBot_Options_setCustomDebuffList()
    local customPriority = {}
    local customDefaultImportantCnt=0
    local customDefaultDamageCnt=0
    local customDefaultEffectCnt=0
    local customDefaultMiscCnt=0
    local customListPos=0
    local textname=nil
    for dName, x in pairs(HealBot_Globals.HealBot_Custom_Debuffs) do
        if HealBot_Globals.CDCBarColour[dName] or not HealBot_GlobalsDefaults.HealBot_Custom_Debuffs[dName] then
            if not customPriority[x] then customPriority[x]={} end
            customPriority[x][dName]=dName
        elseif HealBot_GlobalsDefaults.HealBot_Custom_Debuffs[dName]==9 then
            customDefaultImportantCnt=customDefaultImportantCnt+1
        elseif HealBot_GlobalsDefaults.HealBot_Custom_Debuffs[dName]==12 then
            customDefaultMiscCnt=customDefaultMiscCnt+1
        elseif HealBot_GlobalsDefaults.HealBot_Custom_Debuffs[dName]==11 then
            customDefaultEffectCnt=customDefaultEffectCnt+1
        else
            customDefaultDamageCnt=customDefaultDamageCnt+1
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
    if customDefaultImportantCnt>0 then
        local customDefImpPrio=HealBot_Globals.HealBot_Custom_Debuffs[HEALBOT_CUSTOM_CAT_CUSTOM_IMPORTANT] or 9
        if not customPriority[customDefImpPrio] then customPriority[customDefImpPrio]={} end
        customPriority[customDefImpPrio][HEALBOT_CUSTOM_en.."9"]=HEALBOT_CUSTOM_CAT_CUSTOM_IMPORTANT.." (x"..customDefaultImportantCnt..")"
    end
    if customDefaultDamageCnt>0 then
        local customDefDmgPrio=HealBot_Globals.HealBot_Custom_Debuffs[HEALBOT_CUSTOM_CAT_CUSTOM_DAMAGE] or 10
        if not customPriority[customDefDmgPrio] then customPriority[customDefDmgPrio]={} end
        customPriority[customDefDmgPrio][HEALBOT_CUSTOM_en.."10"]=HEALBOT_CUSTOM_CAT_CUSTOM_DAMAGE.." (x"..customDefaultDamageCnt..")"
    end
    if customDefaultEffectCnt>0 then
        local customDefEffPrio=HealBot_Globals.HealBot_Custom_Debuffs[HEALBOT_CUSTOM_CAT_CUSTOM_EFFECT] or 11
        if not customPriority[customDefEffPrio] then customPriority[customDefEffPrio]={} end
        customPriority[customDefEffPrio][HEALBOT_CUSTOM_en.."11"]=HEALBOT_CUSTOM_CAT_CUSTOM_EFFECT.." (x"..customDefaultEffectCnt..")"
    end
    if customDefaultMiscCnt>0 then
        local customDefMiscPrio=HealBot_Globals.HealBot_Custom_Debuffs[HEALBOT_CUSTOM_CAT_CUSTOM_MISC] or 12
        if not customPriority[customDefMiscPrio] then customPriority[customDefMiscPrio]={} end
        customPriority[customDefMiscPrio][HEALBOT_CUSTOM_en.."12"]=HEALBOT_CUSTOM_CAT_CUSTOM_MISC.." (x"..customDefaultMiscCnt..")"
    end
    for j=1,20 do
        if customPriority[j] then
            for z, dName in pairs(customPriority[j]) do
                customListPos=customListPos+1
                if customListPos<31 then
                    local r,g,b=0,0,0
                    textname=_G["HealBot_Options_CustomDebuff_List"..customListPos]
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
                        local customDebuffPriority=HEALBOT_CUSTOM_en.."10"
                        if HealBot_GlobalsDefaults.HealBot_Custom_Debuffs[dName] then
                            customDebuffPriority=HEALBOT_CUSTOM_en..HealBot_GlobalsDefaults.HealBot_Custom_Debuffs[dName]
                        end
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
                end
            end
        end
    end
    customListPos=customListPos+1
    for j=customListPos,30 do
        textname=_G["HealBot_Options_CustomDebuff_List"..j]
        textname:SetText(" ")
    end
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

local FirstDebuffLoad=true
function HealBot_Options_Debuff_Reset()
    HealBot_Options_setDebuffTypes()
    HealBot_SetAuraChecks()
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
            local id=HealBot_GetSpellId(DebuffTextClass[HealBot_Options_getDropDownId_bySpec(k)]);
            local sName = HealBot_GetSpellInfo(id);
            if not sName then
                if IsUsableItem(DebuffTextClass[HealBot_Options_getDropDownId_bySpec(k)]) or HealBot_IsItemInBag(DebuffTextClass[HealBot_Options_getDropDownId_bySpec(k)]) then
                    sName=DebuffTextClass[HealBot_Options_getDropDownId_bySpec(k)];
                end
            end
            if HealBot_Debuff_Types[sName] then
                table.foreach(HealBot_Debuff_Types[sName], function (i,dName)

                    if not HealBot_DebuffSpell[dName] then
                        HealBot_DebuffSpell[dName]=sName;
                    end
                    local HealBot_DebuffWatchTargetSpell=HealBot_DebuffWatchTarget[dName];

                    if DebuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]==2 then
                        HealBot_DebuffWatchTargetSpell["Self"]=true;
                    elseif DebuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]==3 then
                        HealBot_DebuffWatchTargetSpell["Party"]=true;
                    elseif DebuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]==4 then
                        HealBot_DebuffWatchTargetSpell["Raid"]=true;
                    elseif DebuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]==5 then
                        HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_DRUID]]=true;
                    elseif DebuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]==6 then
                        HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_HUNTER]]=true;
                    elseif DebuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]==7 then
                        HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_MAGE]]=true;
                    elseif DebuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]==8 then
                        HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_MONK]]=true;
                    elseif DebuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]==9 then
                        HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_PALADIN]]=true;
                    elseif DebuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]==10 then
                        HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_PRIEST]]=true;
                    elseif DebuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]==11 then
                        HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_ROGUE]]=true;
                    elseif DebuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]==12 then
                        HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_SHAMAN]]=true;
                    elseif DebuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]==13 then
                        HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_WARLOCK]]=true;
                    elseif DebuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]==14 then
                        HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_WARRIOR]]=true;
                    elseif DebuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]==15 then
                        HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_DEATHKNIGHT]]=true;
                    elseif DebuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]==16 then
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
                        if HealBot_Globals.EmergIncMelee[HEALBOT_MONK] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_MONK]]=true;
                        end
                    elseif DebuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]==17 then
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
                        if HealBot_Globals.EmergIncRange[HEALBOT_MONK] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_MONK]]=true;
                        end
                    elseif DebuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]==18 then
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
                        if HealBot_Globals.EmergIncHealers[HEALBOT_MONK] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_MONK]]=true;
                        end
                    elseif DebuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]==19 then
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
                        if HealBot_Globals.EmergIncCustom[HEALBOT_MONK] then
                            HealBot_DebuffWatchTargetSpell[HealBot_Class_En[HEALBOT_MONK]]=true;
                        end
                    elseif DebuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]==20 then
                        HealBot_DebuffWatchTargetSpell["PvP"]=true
                    elseif DebuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]==21 then
                        HealBot_DebuffWatchTargetSpell["PvE"]=true
                    elseif DebuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]==22 then
                        HealBot_DebuffWatchTargetSpell["MainTanks"]=true
                    elseif DebuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]==23 then
                        HealBot_DebuffWatchTargetSpell["MyTargets"]=true
                    elseif DebuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]==24 then
                        HealBot_DebuffWatchTargetSpell["Focus"]=true
                    elseif DebuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]==25 then
                        HealBot_DebuffWatchTargetSpell["Name"]=true
                        if not FirstDebuffLoad then HealBot_Options_Get_deBuffWatchGUID(sName, "Debuff", k) end
                    end        
                end)
            end
        end
        HealBot_setOptions_Timer(20)
    end
    FirstDebuffLoad=nil
end


local spells={}
local FirstBuffLoad=true
function HealBot_Options_Buff_Reset()
    HealBot_Options_setDebuffTypes()
    HealBot_SetAuraChecks()
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
    if HealBot_Data["TIPUSE"]=="YES" then HealBot_Tooltip_Clear_CheckBuffs() end
    HealBot_Clear_CheckBuffs()
    
    for k=1,8 do
        if BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)] and BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]>1 then
            local sName=BuffTextClass[HealBot_Options_getDropDownId_bySpec(k)]
            if HealBot_GetSpellId(sName) or IsUsableItem(sName) or HealBot_IsItemInBag(sName) then  
           
                if not spells[sName] then
                    spells[sName]=sName;
                    HealBot_Set_BuffWatch(sName)
                    HealBot_BuffWatchTarget[sName] = {sName = {}};
                end

                local HealBot_BuffWatchTargetSpell=HealBot_BuffWatchTarget[sName];
                if HealBot_Data["TIPUSE"]=="YES" then HealBot_Tooltip_CheckBuffs(sName) end
                HealBot_Set_CheckBuffs(sName)
        
                if BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]==2 then
                    HealBot_BuffWatchTargetSpell["Self"]=true;
                elseif BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]==3 then
                    HealBot_BuffWatchTargetSpell["Party"]=true;
                elseif BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]==4 then
                    HealBot_BuffWatchTargetSpell["Raid"]=true;
                elseif BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]==5 then
                    HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_DRUID]]=true;
                elseif BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]==6 then
                    HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_HUNTER]]=true;
                elseif BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]==7 then
                    HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_MAGE]]=true;
                elseif BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]==8 then
                    HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_MONK]]=true;
                elseif BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]==9 then
                    HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_PALADIN]]=true;
                elseif BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]==10 then
                    HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_PRIEST]]=true;
                elseif BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]==11 then
                    HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_ROGUE]]=true;
                elseif BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]==12 then
                    HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_SHAMAN]]=true;
                elseif BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]==13 then
                    HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_WARLOCK]]=true;
                elseif BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]==14 then
                    HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_WARRIOR]]=true;
                elseif BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]==15 then
                    HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_DEATHKNIGHT]]=true;
                elseif BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]==16 then
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
                    if HealBot_Globals.EmergIncMelee[HEALBOT_MONK] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_MONK]]=true;
                    end
                elseif BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]==17 then
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
                    if HealBot_Globals.EmergIncRange[HEALBOT_MONK] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_MONK]]=true;
                    end
                elseif BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]==18 then
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
                    if HealBot_Globals.EmergIncHealers[HEALBOT_MONK] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_MONK]]=true;
                    end
                elseif BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]==19 then
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
                    if HealBot_Globals.EmergIncCustom[HEALBOT_MONK] then
                        HealBot_BuffWatchTargetSpell[HealBot_Class_En[HEALBOT_MONK]]=true;
                    end
                elseif BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]==20 then
                    HealBot_BuffWatchTargetSpell["PvP"]=true
                elseif BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]==21 then
                    HealBot_BuffWatchTargetSpell["PvE"]=true
                elseif BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]==22 then
                    HealBot_BuffWatchTargetSpell["MainTanks"]=true
                elseif BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]==23 then
                    HealBot_BuffWatchTargetSpell["MyTargets"]=true
                elseif BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]==24 then
                    HealBot_BuffWatchTargetSpell["Focus"]=true
                elseif BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(k)]==25 then
                    HealBot_BuffWatchTargetSpell["Name"]=true
                    if not FirstBuffLoad then HealBot_Options_Get_BuffWatchGUID(sName, "Buff") end
                end
                HealBot_buffbarcolr[sName]=buffbarcolrClass[k];
                HealBot_buffbarcolg[sName]=buffbarcolgClass[k];
                HealBot_buffbarcolb[sName]=buffbarcolbClass[k];
            end
            HealBot_setOptions_Timer(30)
        end
    end
    FirstBuffLoad=nil
end

local BuffWatchSpell=" "
function HealBot_Options_BUFFNAMEDTITLE_show()
    StaticPopupDialogs["HEALBOT_OPTIONS_BUFFNAMEDTITLE"] = {
        text = HEALBOT_OPTIONS_BUFFNAMED.."%s",
        button1 = ACCEPT,
        button2 = CANCEL,
        OnShow = function(self)
            local g=_G[self:GetName().."WideEditBox"] or _G[self:GetName().."EditBox"]
            g:SetText(HealBot_GuessName())
        end,
        OnAccept = function(self)
            local g=_G[self:GetName().."WideEditBox"] or _G[self:GetName().."EditBox"]
            HealBot_Options_Set_BuffWatchGUID(g:GetText())
        end,
        OnCancel = function()
            -- do nothing
        end,
        timeout = 0,
        whileDead = 1,
        hideOnEscape = 1,
        hasEditBox = 1,
        hasWideEditBox = 1,
    };
    
    StaticPopup_Show ("HEALBOT_OPTIONS_BUFFNAMEDTITLE", BuffWatchSpell);
end

function HealBot_GuessName()
    local gName=nil
    local gGUID=nil

    if HealBot_Config.HealBot_BuffWatchGUID[BuffWatchSpell] and (type(HealBot_Config.HealBot_BuffWatchGUID[BuffWatchSpell]) == "table") then
        local tGUID=HealBot_Config.HealBot_BuffWatchGUID[BuffWatchSpell]
        for uGUID,_ in pairs(tGUID) do
            if HealBot_UnitData[uGUID] then
                if gName then
                    gName=gName..","..HealBot_UnitData[uGUID]["NAME"]
                else
                    gName=HealBot_UnitData[uGUID]["NAME"]
                end
            end
        end
    end
    
    if not gName then
        if UnitExists("Target") and HealBot_Unit_Button["target"] then
            gName=HealBot_GetUnitName("Target")
        end
        local myTargets=HealBot_GetMyHealTargets()
        local x=true
        table.foreach(myTargets, function (i,myGUID)
            if HealBot_UnitData[myGUID] then
                if gName and x then 
                    gName=gName..","..HealBot_UnitData[myGUID]["NAME"]
                    x=nil
                elseif x then
                    gName=HealBot_UnitData[myGUID]["NAME"]
                end
            end  
        end)
        if gName then 
            gName=gName..","..HealBot_GetUnitName("Player")
        else
            gName=HealBot_GetUnitName("Player")
        end
    end
    
    gName=(gName or "")..","..HEALBOT_SORTBY_NAME

    return gName
end

local BuffWatchType=nil
function HealBot_Options_Set_BuffWatchGUID(unitName)
    
    if BuffWatchType=="Buff" and HealBot_Config.HealBot_BuffWatchGUID[BuffWatchSpell] then
        local tGUID=HealBot_Config.HealBot_BuffWatchGUID[BuffWatchSpell]
        if tGUID and type(tGUID)=="table" then
            for uGUID,_ in pairs(tGUID) do
                if HealBot_UnitData[uGUID] and HealBot_UnitData[uGUID]["UNIT"] then
                    xButton=HealBot_Unit_Button[HealBot_UnitData[uGUID]["UNIT"]]
                    if xButton and xButton.buff and xButton.buff==BuffWatchSpell then
                        HealBot_ClearBuff(xButton, true)
                    end
                end
            end
        elseif tGUID then
            if HealBot_UnitData[tGUID] and HealBot_UnitData[tGUID]["UNIT"] then
                xButton=HealBot_Unit_Button[HealBot_UnitData[tGUID]["UNIT"]]
                if xButton and xButton.buff and xButton.buff==BuffWatchSpell then
                    HealBot_ClearBuff(xButton, true)
                end
            end
        end
    end

    local tName=nil
    if strfind(unitName,",") then tName = HealBot_Split(unitName, ","); end
    local tGUID={}

    if tName and type(tName)=="table" then
        for _,uName in pairs(tName) do
            uName=HealBot_Options_CleanName(uName)
            local xGUID=HealBot_RetUnitNameGUIDs(uName)
            if xGUID then
                tinsert(tGUID, xGUID);
            end
        end
    elseif tName then
        tName=HealBot_Options_CleanName(tName)
        local xGUID=HealBot_RetUnitNameGUIDs(tName)
        if xGUID then
            tinsert(tGUID, xGUID);
        end
    end
    
    HealBot_Config.HealBot_BuffWatchGUID[BuffWatchSpell]={}
    
    for _,uGUID in pairs(tGUID) do
        if HealBot_UnitData[uGUID] then
            HealBot_Config.HealBot_BuffWatchGUID[BuffWatchSpell][uGUID]=uGUID 
            HealBot_Queue_MyBuffsCheck(uGUID)
        end
    end
end

function HealBot_Options_CleanName(unitName)
    local uName=strtrim(unitName)
    uName=strupper(strsub(uName, 1, 1))..strlower(strsub(uName, 2))
    return uName
end

function HealBot_Options_Get_BuffWatchGUID(spellName, BuffType)
    if not ClickedBuffGroupDD or ClickedBuffGroupDD~=ddID then return end
    BuffWatchSpell=spellName
    BuffWatchType=BuffType
    HealBot_Options_BUFFNAMEDTITLE_show()
    ClickedBuffGroupDD=nil
end

function HealBot_Options_Get_deBuffWatchGUID(spellName, BuffType)
    if not ClickedBuffGroupDD or ClickedBuffGroupDD~=ddID then return end
    BuffWatchSpell=spellName
    BuffWatchType=BuffType
    HealBot_Options_BUFFNAMEDTITLE_show()
    ClickedBuffGroupDD=nil
end

function HealBot_Options_RetBuffRGB(spellName)
    return HealBot_buffbarcolr[spellName],HealBot_buffbarcolg[spellName],HealBot_buffbarcolb[spellName];
end

function HealBot_Colorpick_OnClick(CDCType)
    if CDCType==HEALBOT_CUSTOM_en then
        local customDebuffPriority=HEALBOT_CUSTOM_en..HealBot_Options_StorePrev["customDebuffPriority"]
        HealBot_ColourObjWaiting=customDebuffPriority
        if HealBot_Options_StorePrev["CDebuffcustomName"] and HealBot_Options_StorePrev["CDebuffcustomName"]~=HEALBOT_CUSTOM_CAT_CUSTOM_IMPORTANT and HealBot_Options_StorePrev["CDebuffcustomName"]~=HEALBOT_CUSTOM_CAT_CUSTOM_MISC and 
           HealBot_Options_StorePrev["CDebuffcustomName"]~=HEALBOT_CUSTOM_CAT_CUSTOM_DAMAGE and HealBot_Options_StorePrev["CDebuffcustomName"]~=HEALBOT_CUSTOM_CAT_CUSTOM_EFFECT then
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
    else
        HealBot_ColourObjWaiting=CDCType;
        HealBot_UseColourPick(HealBot_Config_Cures.CDCBarColour[CDCType].R,HealBot_Config_Cures.CDCBarColour[CDCType].G,HealBot_Config_Cures.CDCBarColour[CDCType].B, nil)
    end
end

function HealBot_Returned_Colours(R, G, B, A)
  --R, G, B = ColorPickerFrame:GetColorRGB(); -- added by Diacono
  --A = OpacitySliderFrame:GetValue();
    if A then
        A = ((0-A)+1);
        A=HealBot_Comm_round(A,2)
    end
    R=HealBot_Comm_round(R,3)
    G=HealBot_Comm_round(G,3)
    B=HealBot_Comm_round(B,3)
    local setskincols=true;
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
    elseif HealBot_ColourObjWaiting=="Alias" then
        Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["R"],
        Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["G"],
        Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["B"],
        Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["A"] = R, G, B, A;
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
        HealBot_Action_ResetUnitStatus()
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
        Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["CR"],
        Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["CG"],
        Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["CB"] = R, G, B;
        HealBot_Action_SetHightlightAggroCols()
    elseif HealBot_ColourObjWaiting=="HighlightTargetBar" then
        Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["TR"],
        Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["TG"],
        Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["TB"] = R, G, B;
        HealBot_Action_SetHightlightTargetAggroCols()
    elseif HealBot_ColourObjWaiting=="Aggro" then
        Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["R"],
        Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["G"],
        Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["B"] = R, G, B;
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
    elseif HealBot_ColourObjWaiting==HEALBOT_CUSTOM_en.."9" or 
        HealBot_ColourObjWaiting==HEALBOT_CUSTOM_en.."10" or HealBot_ColourObjWaiting==HEALBOT_CUSTOM_en.."11" or 
        HealBot_ColourObjWaiting==HEALBOT_CUSTOM_en.."12" or HealBot_ColourObjWaiting==HealBot_Options_StorePrev["CDebuffcustomName"] then
        HealBot_Globals.CDCBarColour[HealBot_ColourObjWaiting].R,
        HealBot_Globals.CDCBarColour[HealBot_ColourObjWaiting].G,
        HealBot_Globals.CDCBarColour[HealBot_ColourObjWaiting].B = R, G, B;
        HealBot_SetCDCBarColours();
        setskincols=false;
    elseif HealBot_Config_Cures.CDCBarColour[HealBot_ColourObjWaiting] then
        HealBot_Config_Cures.CDCBarColour[HealBot_ColourObjWaiting].R,
        HealBot_Config_Cures.CDCBarColour[HealBot_ColourObjWaiting].G,
        HealBot_Config_Cures.CDCBarColour[HealBot_ColourObjWaiting].B = R, G, B;
        HealBot_SetCDCBarColours();
        setskincols=false;
    end
    if setskincols then
        HealBot_setOptions_Timer(90)
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
    return ColorPickerFrame:GetColorRGB();
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
        local customDebuffPriority=HEALBOT_CUSTOM_en..HealBot_Options_StorePrev["customDebuffPriority"]
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

function HealBot_Options_NotifyChan_OnTextChanged(self)
    Healbot_Config_Skins.Chat[Healbot_Config_Skins.Current_Skin]["CHAN"] = self:GetText()
end

function HealBot_Options_FrameAlias_OnTextChanged(self)
    Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["ALIAS"] = self:GetText()
    HealBot_setOptions_Timer(419)
end
function HealBot_Options_FrameAlias_initFrameSel()
    HealBot_Options_InitSub(106)
end

function HealBot_Options_Frame_initCurFrame()
    DoneInitTab[301]=nil
    DoneInitTab[302]=nil
    DoneInitTab[344]=nil
    DoneInitTab[334]=nil
    DoneInitTab[343]=nil
    DoneInitTab[317]=nil
    DoneInitTab[106]=nil
    DoneInitTab[336]=nil
    DoneInitTab[305]=nil
    DoneInitTab[335]=nil
    DoneInitTab[322]=nil
    DoneInitTab[323]=nil
    DoneInitTab[325]=nil
    DoneInitTab[342]=nil
    DoneInitTab[311]=nil
    DoneInitTab[309]=nil
    DoneInitTab[308]=nil
    DoneInitTab[307]=nil
    DoneInitTab[324]=nil
    DoneInitTab[332]=nil
    DoneInitTab[327]=nil
    DoneInitTab[333]=nil
    DoneInitTab[314]=nil
    DoneInitTab[315]=nil
    DoneInitTab[316]=nil
    DoneInitTab[326]=nil
    DoneInitTab[339]=nil
    DoneInitTab[338]=nil
    DoneInitTab[346]=nil
    DoneInitTab[1008]=nil
    DoneInitTab[1009]=nil
    DoneInitTab[1010]=nil
    DoneInitTab[1011]=nil
    DoneInitTab[1012]=nil
    DoneInitTab[1013]=nil
    DoneInitTab[1014]=nil
    DoneInitTab[1015]=nil
    HealBot_Options_SetSkins(true)
end

function HealBot_Options_FrameTitle_OnTextChanged(self)
    Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["NAME"] = self:GetText()
    if Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOW"] then
        local tst="UpdFrameAlias"..HealBot_Options_StorePrev["FramesSelFrame"]
        HealBot_Options_StorePrev[tst]="T"
        HealBot_setOptions_Timer(415)
    end
end

function HealBot_Options_FrameAliasShow_OnClick(self)
    if self:GetChecked() then
        Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOW"] = true
    else
        Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOW"] = false
    end
    local tst="UpdFrameAlias"..HealBot_Options_StorePrev["FramesSelFrame"]
    HealBot_Options_StorePrev[tst]="T"
    HealBot_setOptions_Timer(415)
end

function HealBot_Options_FrameAlias_retUpdates()
    local fNo, fType=nil, nil
    for j=1,10, 1 do
        local tst="UpdFrameAlias"..j
        if HealBot_Options_StorePrev[tst] then
            fType=HealBot_Options_StorePrev[tst]
            fNo=j
            HealBot_Options_StorePrev[tst]=nil
            break
        end
    end
    return fNo, fType
end

function HealBot_SpellAutoButton_OnClick(self, autoType, autoMod)
    local combo=nil
    if HealBot_Options_StorePrev["ActionBarsCombo"]==1 then
        if autoType=="Target" then combo = HealBot_Config_Spells.EnabledSpellTarget;
        elseif autoType=="Trinket1" then combo = HealBot_Config_Spells.EnabledSpellTrinket1;
        elseif autoType=="Trinket2" then combo = HealBot_Config_Spells.EnabledSpellTrinket2; 
        else combo = HealBot_Config_Spells.EnabledAvoidBlueCursor; end
    elseif HealBot_Options_StorePrev["ActionBarsCombo"]==2 then
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
    local button = HealBot_Options_ComboClass_Button(HealBot_Options_ComboButtons_Button)
    if self:GetChecked() then
        combo[autoMod..button..HealBot_Config.CurrentSpec] = true
    else
        combo[autoMod..button..HealBot_Config.CurrentSpec] = false
    end
    HealBot_setOptions_Timer(400)
end

local spellText=nil
function HealBot_Options_Click_OnTextChanged(self)
    local combo=nil
    if HealBot_Options_StorePrev["ActionBarsCombo"]==1 then
        combo = HealBot_Config_Spells.EnabledKeyCombo;
    elseif HealBot_Options_StorePrev["ActionBarsCombo"]==2 then
        combo = HealBot_Config_Spells.DisabledKeyCombo;
    else
        combo=HealBot_Config_Spells.EnemyKeyCombo;
    end
    local button = HealBot_Options_ComboClass_Button(HealBot_Options_ComboButtons_Button)
    spellText = strtrim(self:GetText())
    combo[button..HealBot_Config.CurrentSpec] = spellText
    if HealBot_GetSpellId(spellText) or GetMacroIndexByName(spellText) or IsUsableItem(spellText) or HealBot_IsItemInBag(spellText) then
        HealBot_setOptions_Timer(400)
    end
    HealBot_Options_SoftReset_flag=true
end

function HealBot_Options_Shift_OnTextChanged(self)
    local combo=nil
    if HealBot_Options_StorePrev["ActionBarsCombo"]==1 then
        combo = HealBot_Config_Spells.EnabledKeyCombo;
    elseif HealBot_Options_StorePrev["ActionBarsCombo"]==2 then
        combo = HealBot_Config_Spells.DisabledKeyCombo;
    else
        combo=HealBot_Config_Spells.EnemyKeyCombo;
    end
    local button = HealBot_Options_ComboClass_Button(HealBot_Options_ComboButtons_Button)
    spellText = strtrim(self:GetText())
    combo["Shift"..button..HealBot_Config.CurrentSpec] = spellText
    if HealBot_GetSpellId(spellText) or GetMacroIndexByName(spellText) or IsUsableItem(spellText) or HealBot_IsItemInBag(spellText) then
        HealBot_setOptions_Timer(400)
    end
    HealBot_Options_SoftReset_flag=true
end

function HealBot_Options_Ctrl_OnTextChanged(self)
    local combo=nil
    if HealBot_Options_StorePrev["ActionBarsCombo"]==1 then
        combo = HealBot_Config_Spells.EnabledKeyCombo;
    elseif HealBot_Options_StorePrev["ActionBarsCombo"]==2 then
        combo = HealBot_Config_Spells.DisabledKeyCombo;
    else
        combo=HealBot_Config_Spells.EnemyKeyCombo;
    end
    local button = HealBot_Options_ComboClass_Button(HealBot_Options_ComboButtons_Button)
    spellText = strtrim(self:GetText())
    combo["Ctrl"..button..HealBot_Config.CurrentSpec] = spellText
    if HealBot_GetSpellId(spellText) or GetMacroIndexByName(spellText) or IsUsableItem(spellText) or HealBot_IsItemInBag(spellText) then
        HealBot_setOptions_Timer(400)
    end
    HealBot_Options_SoftReset_flag=true
end

function HealBot_Options_Alt_OnTextChanged(self)
    local combo=nil
    if HealBot_Options_StorePrev["ActionBarsCombo"]==1 then
        combo = HealBot_Config_Spells.EnabledKeyCombo;
    elseif HealBot_Options_StorePrev["ActionBarsCombo"]==2 then
        combo = HealBot_Config_Spells.DisabledKeyCombo;
    else
        combo=HealBot_Config_Spells.EnemyKeyCombo;
    end
    local button = HealBot_Options_ComboClass_Button(HealBot_Options_ComboButtons_Button)
    spellText = strtrim(self:GetText())
    combo["Alt"..button..HealBot_Config.CurrentSpec] = spellText
    if HealBot_GetSpellId(spellText) or GetMacroIndexByName(spellText) or IsUsableItem(spellText) or HealBot_IsItemInBag(spellText) then
        HealBot_setOptions_Timer(400)
    end
    HealBot_Options_SoftReset_flag=true
end

function HealBot_Options_CtrlShift_OnTextChanged(self)
    local combo=nil
    if HealBot_Options_StorePrev["ActionBarsCombo"]==1 then
        combo = HealBot_Config_Spells.EnabledKeyCombo;
    elseif HealBot_Options_StorePrev["ActionBarsCombo"]==2 then
        combo = HealBot_Config_Spells.DisabledKeyCombo;
    else
        combo=HealBot_Config_Spells.EnemyKeyCombo;
    end
    local button = HealBot_Options_ComboClass_Button(HealBot_Options_ComboButtons_Button)
    spellText = strtrim(self:GetText())
    combo["Ctrl-Shift"..button..HealBot_Config.CurrentSpec] = spellText
    if HealBot_GetSpellId(spellText) or GetMacroIndexByName(spellText) or IsUsableItem(spellText) or HealBot_IsItemInBag(spellText) then
        HealBot_setOptions_Timer(400)
    end
    HealBot_Options_SoftReset_flag=true
end

function HealBot_Options_AltShift_OnTextChanged(self)
    local combo=nil
    if HealBot_Options_StorePrev["ActionBarsCombo"]==1 then
        combo = HealBot_Config_Spells.EnabledKeyCombo;
    elseif HealBot_Options_StorePrev["ActionBarsCombo"]==2 then
        combo = HealBot_Config_Spells.DisabledKeyCombo;
    else
        combo=HealBot_Config_Spells.EnemyKeyCombo;
    end
    local button = HealBot_Options_ComboClass_Button(HealBot_Options_ComboButtons_Button)
    spellText = strtrim(self:GetText())
    combo["Alt-Shift"..button..HealBot_Config.CurrentSpec] = spellText
    if HealBot_GetSpellId(spellText) or GetMacroIndexByName(spellText) or IsUsableItem(spellText) or HealBot_IsItemInBag(spellText) then
        HealBot_setOptions_Timer(400)
    end
    HealBot_Options_SoftReset_flag=true
end

function HealBot_Options_CtrlAlt_OnTextChanged(self)
    local combo=nil
    if HealBot_Options_StorePrev["ActionBarsCombo"]==1 then
        combo = HealBot_Config_Spells.EnabledKeyCombo;
    elseif HealBot_Options_StorePrev["ActionBarsCombo"]==2 then
        combo = HealBot_Config_Spells.DisabledKeyCombo;
    else
        combo=HealBot_Config_Spells.EnemyKeyCombo;
    end
    local button = HealBot_Options_ComboClass_Button(HealBot_Options_ComboButtons_Button)
    spellText = strtrim(self:GetText())
    combo["Alt-Ctrl"..button..HealBot_Config.CurrentSpec] = spellText
    if HealBot_GetSpellId(spellText) or GetMacroIndexByName(spellText) or IsUsableItem(spellText) or HealBot_IsItemInBag(spellText) then
        HealBot_setOptions_Timer(400)
    end
    HealBot_Options_SoftReset_flag=true
end

function HealBot_Options_EnableHealthy_OnClick(self)
    if self:GetChecked() then
        HealBot_Config.EnableHealthy = true
    else
        HealBot_Config.EnableHealthy = false
    end
    HealBot_Action_ResetUnitStatus();
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

function HealBot_Options_Info_OnClick(self)
    HealBot_Comms_Info()
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
    HealBot_InitNewChar()
    HealBot_Config.CurrentSpec=1
    HealBot_Update_SpellCombos()
    HealBot_Update_BuffsForSpec()
    HealBot_Options_Opened=false;
    HealBot_Action_Reset();
    HealBot_ClearAllBuffs()
    HealBot_ClearAllDebuffs()
    HealBot_Action_SetAllAttribs()
    HideUIPanel(HealBot_Options)
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
    g=_G["HealBot_Options_HealingSkinsFrame"]
    g:Hide()
    g=_G["HealBot_Options_ProtSkinsFrame"]
    g:Hide()
    g=_G["HealBot_Options_EnemySkinsFrame"]
    g:Hide()
    g=_G["HealBot_Options_ShareSkinsFrame"]
    g:Hide()
    g=_G["HealBot_Options_ChatSkinsFrame"]
    g:Hide()
    g=_G["HealBot_Options_BarsSkinsFrame"]
    g:Hide()
    g=_G["HealBot_Options_BarColoursSkinsFrame"]
    g:Hide()
    g=_G["HealBot_Options_HealGroupsSkinsFrame"]
    g:Hide()
    g=_G["HealBot_Options_TextSkinsFrame"]
    g:Hide()
    g=_G["HealBot_Options_AggroSkinsFrame"]
    g:Hide()
    g=_G["HealBot_Options_IconTextSkinsFrame"]
    g:Hide()
    g=_G["HealBot_Options_FramesSelFrame"]
    g:Hide()
    g=_G["HealBot_Options_ApplyTab2Frames"]
    g:Hide()
    g=_G["HealBot_Options_CustomCureFrame"]
    g:Hide()
    g=_G["HealBot_Options_WarningCureFrame"]
    g:Hide()
    g=_G["HealBot_Options_HealSortFrame"]
    g:Hide()
    g=_G["HealBot_Options_HealHideFrame"]
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
    g=_G["HealBot_Contents_ButtonT302Txt"]
    g:SetTextColor(1,1,0,0.9)
    g=_G["HealBot_Contents_ButtonT303Txt"]
    g:SetTextColor(1,1,0,0.9)
    g=_G["HealBot_Contents_ButtonT304Txt"]
    g:SetTextColor(1,1,0,0.9)
    g=_G["HealBot_Contents_ButtonT305Txt"]
    g:SetTextColor(1,1,0,0.9)
    g=_G["HealBot_Contents_ButtonT306Txt"]
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
    g=_G["HealBot_Contents_ButtonT313Txt"]
    g:SetTextColor(1,1,0,0.9)
    g=_G["HealBot_Contents_ButtonT314Txt"]
    g:SetTextColor(1,1,0,0.9)
    g=_G["HealBot_Contents_ButtonT315Txt"]
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
    g=_G["HealBot_Contents_ButtonT8Txt"]
    g:SetTextColor(1,1,0,0.9)
    g=_G["HealBot_Contents_ButtonT9"]
    g:SetStatusBarColor(0.2,0.2,0.2,0)
    g=_G["HealBot_Contents_ButtonT9Txt"]
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
end

HealBot_Options_StorePrev["TabNo"] = 0;

function HealBot_Options_OnShow(self)
    HealBot_Options_ShowPanel(self, HealBot_Options_StorePrev["TabNo"])
end

function HealBot_Options_Close()
    if HealBot_Options_SoftReset_flag then
        HealBot_Options_SoftReset_flag=false
        HealBot_setOptions_Timer(400)
    end
end

function HealBot_Options_idleInit()
    if not DoneInitTab[0] then
        DoneInitTab[0]=100
    elseif DoneInitTab[0]>0 then
        if not UIDROPDOWNMENU_OPEN_MENU then
            DoneInitTab[0]=DoneInitTab[0]+1
            if DoneInitTab[0]>107 and DoneInitTab[0]<199 then
                DoneInitTab[0]=200
            elseif DoneInitTab[0]>206 and DoneInitTab[0]<299 then
                DoneInitTab[0]=300
            elseif DoneInitTab[0]>346 and DoneInitTab[0]<399 then
                DoneInitTab[0]=400
            elseif DoneInitTab[0]>422 and DoneInitTab[0]<499 then
                DoneInitTab[0]=500
            elseif DoneInitTab[0]>517 and DoneInitTab[0]<599 then
                DoneInitTab[0]=600
            elseif DoneInitTab[0]>601 and DoneInitTab[0]<699 then
                DoneInitTab[0]=700
            elseif DoneInitTab[0]>709 and DoneInitTab[0]<799 then
                DoneInitTab[0]=800
            elseif DoneInitTab[0]>807 then
                DoneInitTab[0]=0
            end
            HealBot_Options_InitSub(DoneInitTab[0])
        end
    else
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
        g=_G["HealBot_Contents_ButtonT302Txt"]
        g:SetText(HEALBOT_OPTIONS_CONTENT_SKINS_HEALING)
        g=_G["HealBot_Contents_ButtonT303Txt"]
        g:SetText(HEALBOT_OPTIONS_CONTENT_SKINS_AGGRO)
        g=_G["HealBot_Contents_ButtonT304Txt"]
        g:SetText(HEALBOT_OPTIONS_CONTENT_SKINS_ENEMY)
        g=_G["HealBot_Contents_ButtonT305Txt"]
        g:SetText(HEALBOT_OPTIONS_CONTENT_SKINS_PROT)
        g=_G["HealBot_Contents_ButtonT306Txt"]
        g:SetText(HEALBOT_OPTIONS_CONTENT_SKINS_SHARE)
        g=_G["HealBot_Contents_ButtonT307Txt"]
        g:SetText(HEALBOT_OPTIONS_CONTENT_SKINS_CHAT)
        g=_G["HealBot_Contents_ButtonT308Txt"]
        g:SetText(HEALBOT_OPTIONS_CONTENT_SKINS_FRAMES)
        g=_G["HealBot_Contents_ButtonT309Txt"]
        g:SetText(HEALBOT_OPTIONS_CONTENT_SKINS_HEALGROUP)
        g=_G["HealBot_Contents_ButtonT310Txt"]
        g:SetText(HEALBOT_OPTIONS_CONTENT_SKINS_HEADERS)
        g=_G["HealBot_Contents_ButtonT311Txt"]
        g:SetText(HEALBOT_OPTIONS_CONTENT_SKINS_BARS)
        g=_G["HealBot_Contents_ButtonT312Txt"]
        g:SetText(HEALBOT_OPTIONS_CONTENT_SKINS_BARCOLOUR)
        g=_G["HealBot_Contents_ButtonT313Txt"]
        g:SetText(HEALBOT_OPTIONS_CONTENT_SKINS_TEXT)
        g=_G["HealBot_Contents_ButtonT314Txt"]
        g:SetText(HEALBOT_OPTIONS_CONTENT_SKINS_ICONS)
        g=_G["HealBot_Contents_ButtonT315Txt"]
        g:SetText(HEALBOT_OPTIONS_CONTENT_SKINS_ICONTEXT)
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
        g=_G["HealBot_Contents_ButtonT6Txt"] 
        g:SetText(HEALBOT_OPTIONS_CONTENT_TIPS)
        g=_G["HealBot_Contents_ButtonT7Txt"] 
        g:SetText(HEALBOT_OPTIONS_CONTENT_MOUSEWHEEL)
        g=_G["HealBot_Contents_ButtonT8Txt"] 
        g:SetText(HEALBOT_OPTIONS_CONTENT_TEST)
        g=_G["HealBot_Contents_ButtonT9Txt"] 
        g:SetText(HEALBOT_OPTIONS_CONTENT_USAGE)
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
        g=_G["HealBot_Options_HealingHealGroupSettings"] 
        g:SetText(HEALBOT_OPTIONS_SET_FRAME_HEALGROUPS)
        HealBot_Options_SetText(HealBot_Options_FrameTitle,HEALBOT_OPTIONS_FRAME_TITLE)
        HealBot_Options_SetText(HealBot_Options_FrameAlias,HEALBOT_OPTIONS_FRAME_ALIAS)
        HealBot_Options_SetText(HealBot_Options_FrameAliasShow,HEALBOT_OPTIONS_FRAME_TITLE_SHOW)
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
    HealBot_Options_ResetDoInittab(9)
    HealBot_Options_ResetDoInittab(40)
    HealBot_Options_ResetDoInittab(50)
    HealBot_Options_ResetDoInittab(8)
end

function HealBot_Options_ResetDoInittab(tabNo)
    if tabNo==1 then
        DoneInitTab[1]=nil
        DoneInitTab[101]=nil
        DoneInitTab[102]=nil
        DoneInitTab[103]=nil
        DoneInitTab[104]=nil
        DoneInitTab[105]=nil
        DoneInitTab[107]=nil
        DoneInitTab[108]=nil
        if DoneInitTab[0] and (DoneInitTab[0]==0 or DoneInitTab[0]>100) then DoneInitTab[0]=100 end
        HealBot_setOptions_Timer(8000)
    elseif tabNo==2 then
        DoneInitTab[2]=nil
        DoneInitTab[21]=nil
        DoneInitTab[201]=nil
        DoneInitTab[202]=nil
        DoneInitTab[203]=nil
        DoneInitTab[204]=nil
        DoneInitTab[205]=nil
        DoneInitTab[206]=nil
        if DoneInitTab[0] and (DoneInitTab[0]==0 or DoneInitTab[0]>200) then DoneInitTab[0]=200 end
        HealBot_setOptions_Timer(8000)
    elseif tabNo==3 then
        DoneInitTab[3]=nil
        DoneInitTab[106]=nil
        DoneInitTab[301]=nil
        DoneInitTab[302]=nil
        DoneInitTab[303]=nil
        DoneInitTab[304]=nil
        DoneInitTab[305]=nil
        DoneInitTab[306]=nil
        DoneInitTab[307]=nil
        DoneInitTab[308]=nil
        DoneInitTab[309]=nil
        DoneInitTab[310]=nil
        DoneInitTab[311]=nil
        DoneInitTab[312]=nil
        DoneInitTab[313]=nil
        DoneInitTab[314]=nil
        DoneInitTab[315]=nil
        DoneInitTab[316]=nil
        DoneInitTab[317]=nil
        DoneInitTab[319]=nil
        DoneInitTab[320]=nil
        DoneInitTab[321]=nil
        DoneInitTab[322]=nil
        DoneInitTab[323]=nil
        DoneInitTab[324]=nil
        DoneInitTab[325]=nil
        DoneInitTab[326]=nil
        DoneInitTab[327]=nil
        DoneInitTab[328]=nil
        DoneInitTab[329]=nil
        DoneInitTab[330]=nil
        DoneInitTab[331]=nil
        DoneInitTab[332]=nil
        DoneInitTab[333]=nil
        DoneInitTab[334]=nil
        DoneInitTab[335]=nil
        DoneInitTab[336]=nil
        DoneInitTab[337]=nil
        DoneInitTab[338]=nil
        DoneInitTab[339]=nil
        DoneInitTab[340]=nil
        DoneInitTab[341]=nil
        DoneInitTab[342]=nil
        DoneInitTab[343]=nil
        DoneInitTab[344]=nil
        DoneInitTab[345]=nil
        DoneInitTab[1001]=nil
        DoneInitTab[1002]=nil
        DoneInitTab[1003]=nil
        DoneInitTab[1004]=nil
        DoneInitTab[1005]=nil
        DoneInitTab[1006]=nil
        DoneInitTab[1007]=nil
        DoneInitTab[1008]=nil
        DoneInitTab[1009]=nil
        DoneInitTab[1010]=nil
        DoneInitTab[1011]=nil
        DoneInitTab[1012]=nil
        DoneInitTab[1013]=nil
        DoneInitTab[1014]=nil
        DoneInitTab[1015]=nil
        if DoneInitTab[0] and (DoneInitTab[0]==0 or DoneInitTab[0]>300) then DoneInitTab[0]=300 end
        HealBot_setOptions_Timer(8000)
    elseif tabNo==4 then
        DoneInitTab[4]=nil
        DoneInitTab[409]=nil
        DoneInitTab[410]=nil
        DoneInitTab[411]=nil
        DoneInitTab[412]=nil
        DoneInitTab[413]=nil
        DoneInitTab[414]=nil
        DoneInitTab[415]=nil
        DoneInitTab[416]=nil
        DoneInitTab[417]=nil
        DoneInitTab[418]=nil
        DoneInitTab[420]=nil
        DoneInitTab[421]=nil
        DoneInitTab[422]=nil
        DoneInitTab[499]=nil
        if DoneInitTab[0] and (DoneInitTab[0]==0 or DoneInitTab[0]>408) then DoneInitTab[0]=408 end
        HealBot_setOptions_Timer(8000)
    elseif tabNo==5 then
        DoneInitTab[5]=nil
        DoneInitTab[501]=nil
        DoneInitTab[502]=nil
        DoneInitTab[503]=nil
        DoneInitTab[504]=nil
        DoneInitTab[505]=nil
        DoneInitTab[506]=nil
        DoneInitTab[507]=nil
        DoneInitTab[508]=nil
        DoneInitTab[509]=nil
        DoneInitTab[510]=nil
        DoneInitTab[511]=nil
        DoneInitTab[512]=nil
        DoneInitTab[513]=nil
        DoneInitTab[514]=nil
        DoneInitTab[515]=nil
        DoneInitTab[516]=nil
        DoneInitTab[517]=nil
        if DoneInitTab[0] and (DoneInitTab[0]==0 or DoneInitTab[0]>500) then DoneInitTab[0]=500 end
        HealBot_setOptions_Timer(8000)
    elseif tabNo==6 then
        DoneInitTab[6]=nil
        DoneInitTab[601]=nil
    elseif tabNo==7 then
        DoneInitTab[7]=nil
        DoneInitTab[701]=nil
        DoneInitTab[702]=nil
        DoneInitTab[703]=nil
        DoneInitTab[704]=nil
        DoneInitTab[705]=nil
        DoneInitTab[706]=nil
        DoneInitTab[707]=nil
        DoneInitTab[708]=nil
        DoneInitTab[709]=nil
        if DoneInitTab[0] and (DoneInitTab[0]==0 or DoneInitTab[0]>700) then DoneInitTab[0]=700 end
        HealBot_setOptions_Timer(8000)
    elseif tabNo==9 then
        DoneInitTab[9]=nil
    elseif tabNo==40 then
        DoneInitTab[4]=nil
        DoneInitTab[410]=nil
        DoneInitTab[412]=nil
        DoneInitTab[414]=nil
        if DoneInitTab[0] and (DoneInitTab[0]==0 or DoneInitTab[0]>409) then DoneInitTab[0]=409 end
        HealBot_setOptions_Timer(8000)
    elseif tabNo==50 then
        DoneInitTab[5]=nil
        DoneInitTab[502]=nil
        DoneInitTab[504]=nil
        DoneInitTab[506]=nil
        DoneInitTab[508]=nil
        DoneInitTab[510]=nil
        DoneInitTab[512]=nil
        DoneInitTab[514]=nil
        DoneInitTab[516]=nil
        if DoneInitTab[0] and (DoneInitTab[0]==0 or DoneInitTab[0]>501) then DoneInitTab[0]=501 end
        HealBot_setOptions_Timer(8000)
    else
        DoneInitTab[10]=nil
        HealBot_Options_SelectSpellsFrame:Hide()
        HealBot_Options_KeysFrame:Show()
        DoneInitTab[801]=nil
        DoneInitTab[802]=nil
        DoneInitTab[803]=nil
        DoneInitTab[804]=nil
        DoneInitTab[805]=nil
        DoneInitTab[806]=nil
        DoneInitTab[807]=nil
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
            HealBot_Options_InitSub(806)
            HealBot_Options_InitSub(807)
            DoneInitTab[99]=true
        end
        HealBot_Comms_About()
    elseif tabNo==1 then
        if not DoneInitTab[1] then
            HealBot_Options_EFClass_Reset()
            HealBot_Options_InitSub(102)
            HealBot_Options_InitSub(101)
            HealBot_Options_InitSub(103)
            HealBot_Options_InitSub(104)
            HealBot_Options_InitSub(105)
            HealBot_Options_InitSub(107)
            DoneInitTab[1]=true
        end
    elseif tabNo==2 then
        if not DoneInitTab[21] then
            HealBot_Options_InitSub(201)
            HealBot_Options_InitSub(202)
            HealBot_Options_InitSub(203)
            HealBot_Options_InitSub(204)
            HealBot_Options_InitSub(205)
            HealBot_Options_InitSub(206)
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
            HealBot_Options_InitSub(407)
            HealBot_Options_InitSub(406)
            HealBot_Options_InitSub(408)
            HealBot_Options_InitSub(419)
            HealBot_Options_InitSub(415)
            HealBot_Options_InitSub(416)
            HealBot_Options_InitSub(417)
            HealBot_Options_InitSub(418)
            HealBot_Options_InitSub(419)
            HealBot_SetCDCBarColours()
            DoneInitTab[499]=true
        end
        if not DoneInitTab[4] then
            HealBot_Options_InitSub(409)
            HealBot_Options_InitSub(410)
            HealBot_Options_InitSub(411)
            HealBot_Options_InitSub(412)
            HealBot_Options_InitSub(413)
            HealBot_Options_InitSub(414)
            HealBot_Options_InitSub(420)
            HealBot_Options_InitSub(421)
            HealBot_Options_InitSub(422)
            DoneInitTab[4]=true
        end
    elseif tabNo==3 then
        if not DoneInitTab[3] then
            HealBot_Options_InitSub(341)
            HealBot_Options_InitSub(319)
            HealBot_Options_InitSub(340)
            HealBot_Options_InitSub(303)
            HealBot_Options_InitSub(310)
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
            HealBot_Options_InitSub(517)
            HealBot_Options_InitSub(501)
            HealBot_Options_InitSub(502)
            HealBot_Options_InitSub(503)
            HealBot_Options_InitSub(504)
            HealBot_Options_InitSub(505)
            HealBot_Options_InitSub(506)
            HealBot_Options_InitSub(507)
            HealBot_Options_InitSub(508)
            HealBot_Options_InitSub(509)
            HealBot_Options_InitSub(510)
            HealBot_Options_InitSub(511)
            HealBot_Options_InitSub(512)
            HealBot_Options_InitSub(513)
            HealBot_Options_InitSub(514)
            HealBot_Options_InitSub(515)
            HealBot_Options_InitSub(516)
            DoneInitTab[5]=true
        end
    elseif tabNo==7 then
        if not DoneInitTab[7] then
            HealBot_Options_InitSub(709)
            HealBot_Options_InitSub(701)
            HealBot_Options_InitSub(702)
            HealBot_Options_InitSub(703)
            HealBot_Options_InitSub(704)
            HealBot_Options_InitSub(705)
            HealBot_Options_InitSub(706)
            HealBot_Options_InitSub(707)
            HealBot_Options_InitSub(708)
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
    elseif tabNo==9 then
        local CPUProfiler=GetCVar("scriptProfile")
        HealBot_Options_CPUProfiler:SetChecked(CPUProfiler)
        if not DoneInitTab[9] then
            HealBot_Options_SetText(HealBot_Options_CPUProfiler,HEALBOT_OPTION_CPUPROFILE)
            HealBot_Options_ResetUsage:SetText(HEALBOT_OPTIONS_REFRESH)
            g=_G["HBAddonCPUHeader"]
            g:SetText(HEALBOT_INFO_ADDONCPUUSAGE)
            g=_G["HBAddonCommHeader"]
            g:SetText(HEALBOT_INFO_ADDONCOMMUSAGE)
            g=_G["HBAddonColHeader1"]
            g:SetText(HEALBOT_WORD_ADDON)
            g=_G["HBAddonColHeader2"]
            g:SetText(HEALBOT_INFO_CPUSECS)
            g=_G["HBAddonColHeader3"]
            g:SetText(HEALBOT_INFO_MEMORYMB)
            g=_G["HBAddonColHeader4"]
            g:SetText(HEALBOT_WORD_ADDON)
            g=_G["HBAddonColHeader5"]
            g:SetText(HEALBOT_INFO_COMMS)
            DoneInitTab[9]=true
        end
        HealBot_Comms_Info()
    elseif tabNo==11 then
        if not DoneInitTab[11] then
            HealBot_Options_DisableHealBotOpt:SetChecked(HealBot_Config.DisableHealBot)
            HealBot_Options_DisableHealBotSolo:SetChecked(HealBot_Config.DisableSolo)
            HealBot_Options_MonitorDebuffs:SetChecked(HealBot_Config_Cures.DebuffWatch)
            HealBot_Options_MonitorBuffs:SetChecked(HealBot_Config_Buffs.BuffWatch)
            DoneInitTab[11]=true
            HealBot_Options_SelectSpellsFrame:Hide()
            LSM.RegisterCallback("HealBot", "LibSharedMedia_Registered", function(event, mediatype, key) HealBot_UpdateUsedMedia(event, mediatype, key) end)  
            LSM.RegisterCallback("HealBot", "LibSharedMedia_SetGlobal", function(event, mediatype, key) HealBot_UpdateUsedMedia(event, mediatype, key) end)
        end
    elseif tabNo==10 then
        if HealBot_Options_StorePrev["ActionBarsCombo"]>2 then
            if HealBot_Options_StorePrev["selSpellsType"]<3 then
                DoneInitTab[801]=nil
                DoneInitTab[802]=nil
                DoneInitTab[804]=nil
                DoneInitTab[805]=nil
                g=_G["healbotspellshelphealfontstr"]
                g:SetText(HEALBOT_OPTIONS_HARMFUL_SPELLS)
            end
        else
            if HealBot_Options_StorePrev["selSpellsType"]>2 then
                DoneInitTab[801]=nil
                DoneInitTab[802]=nil
                DoneInitTab[804]=nil
                DoneInitTab[805]=nil
                g=_G["healbotspellshelphealfontstr"]
                g:SetText(HEALBOT_OPTIONS_SMARTCASTHEAL)
            end
        end
        HealBot_Options_InitSub(801)
        HealBot_Options_InitSub(802)
        HealBot_Options_InitSub(803)
        HealBot_Options_InitSub(804)
        HealBot_Options_InitSub(805)
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
        DoneInitTab[801]=nil
        HealBot_Options_InitSub(801)
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
            DoneInitTab[101]=true
        end
    elseif subNo==102 then
        if not DoneInitTab[102] then
            HealBot_Options_EmergencyFClass.initialize = HealBot_Options_EmergencyFClass_DropDown
            UIDropDownMenu_SetText(HealBot_Options_EmergencyFClass, HealBot_Options_EmergencyFClass_List[HealBot_Globals.EmergencyFClass])
            DoneInitTab[102]=true
        end
    elseif subNo==103 then
        if not DoneInitTab[103] then
            HealBot_Options_hbLangs.initialize = HealBot_Options_hbLangs_DropDown
            UIDropDownMenu_SetText(HealBot_Options_hbLangs, HealBot_Options_hbLangs_List[HealBot_Options_StorePrev["hbLangs"]])
            DoneInitTab[103]=true
        end
    elseif subNo==104 then
        if not DoneInitTab[104] then
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
            HealBot_Options_val2_OnLoad(HealBot_Options_RangeCheckFreq,HEALBOT_OPTIONS_RANGECHECKFREQ,0.5,4.0,0.5,10)
            HealBot_Options_RangeCheckFreq:SetValue((HealBot_Globals.RangeCheckFreq or 0.2)*10)
            HealBot_Options_RangeCheckFreqText:SetText(HEALBOT_OPTIONS_RANGECHECKFREQ .. ": " .. HealBot_Globals.RangeCheckFreq)
            HealBot_Options_SetText(HealBot_Options_DisableHealBotOpt,HEALBOT_OPTIONS_DISABLEHEALBOT)
            HealBot_Options_SetText(HealBot_Options_DisableHealBotSolo,HEALBOT_OPTIONS_DISABLEHEALBOTSOLO)
            g=_G["healbotcmdfontstr"]
            g:SetText(HEALBOT_OPTIONS_COMMANDS)
            DoneInitTab[104]=true
        end
    elseif subNo==105 then
        if not DoneInitTab[105] then
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
            HealBot_Options_SetText(HealBot_Options_EFClassMonk,HEALBOT_MONK)
            g=_G["healbotlangfontstr"]
            g:SetText(HEALBOT_OPTIONS_LANG)
            HealBot_Options_LangsButton:SetText(HEALBOT_WORD_SET)
            g=_G["healbotcrolesfontstr"]
            g:SetText(HEALBOT_OPTIONS_EMERGFCLASS)
            HealBot_Options_hbProfileButtonText:SetText(HEALBOT_WORD_SET)
            g=_G["healbotprofilefontstr"]
            g:SetText(HEALBOT_OPTIONS_PROFILE)
            DoneInitTab[105]=true
        end
    elseif subNo==106 then  -- These need to be called before the 300's
        --if not DoneInitTab[106] then
            HealBot_Options_FrameAliasList()
            g=_G["HealBot_HealButtons_FramesFrameText"]
            g:SetText(HEALBOT_OPTIONS_FRAMESOPTTEXT)
            HealBot_Options_FramesSelFrame.initialize = HealBot_Options_FramesSelFrame_DropDown
            UIDropDownMenu_SetText(HealBot_Options_FramesSelFrame, HealBot_Options_HealGroupsFrame_List[HealBot_Options_StorePrev["FramesSelFrame"]])
            --DoneInitTab[106]=true
        --end
    elseif subNo==107 then  
        if not DoneInitTab[107] then
            HealBot_Options_hbProfile.initialize = HealBot_Options_hbProfile_DropDown
            UIDropDownMenu_SetText(HealBot_Options_hbProfile, HealBot_Options_hbProfile_List[HealBot_Config.Profile])
            DoneInitTab[107]=true
        end
    elseif subNo==201 then
        if not DoneInitTab[201] then
            HealBot_Options_CastButton.initialize = HealBot_Options_CastButton_DropDown
            UIDropDownMenu_SetText(HealBot_Options_CastButton, HealBot_Options_CastButton_List[HealBot_Options_ComboButtons_Button])
            DoneInitTab[201]=true
        end
    elseif subNo==202 then
        if not DoneInitTab[202] then
            HealBot_Options_ButtonCastMethod.initialize = HealBot_Options_ButtonCastMethod_DropDown
            UIDropDownMenu_SetText(HealBot_Options_ButtonCastMethod, HealBot_Options_ButtonCastMethod_List[HealBot_Config_Spells.ButtonCastMethod])
            DoneInitTab[202]=true
        end
    elseif subNo==203 then
        if not DoneInitTab[203] then
            HealBot_Options_ActionBarsCombo.initialize = HealBot_Options_ActionBarsCombo_DropDown
            UIDropDownMenu_SetText(HealBot_Options_ActionBarsCombo, HealBot_Options_ActionBarsCombo_List[HealBot_Options_StorePrev["ActionBarsCombo"]])
            DoneInitTab[203]=true
        end
    elseif subNo==204 then
        if not DoneInitTab[204] then
            HealBot_Options_EnableHealthy:SetChecked(HealBot_Config.EnableHealthy)
            HealBot_Options_SetText(HealBot_Options_EnableHealthy,HEALBOT_OPTIONS_ENABLEHEALTHY)
            HealBot_Options_SmartCastBuff:SetChecked(HealBot_Globals.SmartCastBuff)
            HealBot_Options_SetText(HealBot_Options_SmartCastBuff,HEALBOT_OPTIONS_SMARTCASTBUFF)
            HealBot_Options_SmartCastHeal:SetChecked(HealBot_Globals.SmartCastHeal)
            HealBot_Options_SetText(HealBot_Options_SmartCastHeal,HEALBOT_OPTIONS_SMARTCASTHEAL)
            HealBot_Options_SmartCastRes:SetChecked(HealBot_Globals.SmartCastRes)
            HealBot_Options_SetText(HealBot_Options_SmartCastRes,HEALBOT_RESURRECTION)
            HealBot_Options_SmartCastDisspell:SetChecked(HealBot_Globals.SmartCastDebuff)
            HealBot_Options_SetText(HealBot_Options_SmartCastDisspell,HEALBOT_OPTIONS_SMARTCASTDISPELL)
            HealBot_Options_ProtectPvP:SetChecked(HealBot_Globals.ProtectPvP)
            HealBot_Options_SetText(HealBot_Options_ProtectPvP,HEALBOT_OPTIONS_PROTECTPVP)
            HealBot_Options_EnableSmartCast:SetChecked(HealBot_Globals.SmartCast)
            HealBot_Options_SetText(HealBot_Options_EnableSmartCast,HEALBOT_OPTIONS_ENABLESMARTCAST)
            DoneInitTab[204]=true
        end
    elseif subNo==205 then
        if not DoneInitTab[205] then
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
            DoneInitTab[205]=true
        end
    elseif subNo==206 then
        if not DoneInitTab[206] then
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
            DoneInitTab[206]=true
        end
    elseif subNo==301 then
        if not DoneInitTab[301] then
            HealBot_Options_ActionAnchor.initialize = HealBot_Options_ActionAnchor_DropDown
            if not Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin] or not Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]] or not
                Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["FRAME"] then
                    Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]] = {["FRAME"]=1,["BARS"]=1}
            end
            UIDropDownMenu_SetText(HealBot_Options_ActionAnchor, HealBot_Options_ActionAnchor_List[Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["FRAME"]])
            DoneInitTab[301]=true
        end
    elseif subNo==302 then
        if not DoneInitTab[302] then
            HealBot_Options_ActionBarsAnchor.initialize = HealBot_Options_ActionBarsAnchor_DropDown
            if not Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin] or not Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]] or not
                Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BARS"] then
                    Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]] = {["FRAME"]=1,["BARS"]=1}
            end
            UIDropDownMenu_SetText(HealBot_Options_ActionBarsAnchor, HealBot_Options_ActionAnchor_List[Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BARS"]])
            DoneInitTab[302]=true
        end
    elseif subNo==303 then
        if not DoneInitTab[303] then
            HealBot_Options_SkinPartyRaidDefault.initialize = HealBot_Options_SkinPartyRaidDefault_DropDown
            UIDropDownMenu_SetText(HealBot_Options_SkinPartyRaidDefault, HealBot_Options_SkinDefault_List[HealBot_Config.SkinDefault[Healbot_Config_Skins.Current_Skin]])
            DoneInitTab[303]=true
        end
    elseif subNo==304 then
        if not DoneInitTab[304] then
            HealBot_Options_EmergencyFilter.initialize = HealBot_Options_EmergencyFilter_DropDown
            UIDropDownMenu_SetText(HealBot_Options_EmergencyFilter, HealBot_Options_EmergencyFilter_List[Healbot_Config_Skins.EmergIncMonitor[Healbot_Config_Skins.Current_Skin]])
            DoneInitTab[304]=true
        end
    elseif subNo==305 then
        if not DoneInitTab[305] then
            HealBot_Options_HeadFontOutline.initialize = HealBot_Options_HeadFontOutline_DropDown
            UIDropDownMenu_SetText(HealBot_Options_HeadFontOutline, HealBot_Options_FontOutline_List[Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["OUTLINE"]])
            DoneInitTab[305]=true
        end
    elseif subNo==306 then
        if not DoneInitTab[306] then
            local i=Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["TEXTFORMAT"]
            if i>1 then i=(i*2)-1 end
            HealBot_Options_BarHealthNumFormatAggro.initialize = HealBot_Options_BarHealthNumFormatAggro_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BarHealthNumFormatAggro, HealBot_Options_BarHealthNumFormat2_List[i].."77%"..HealBot_Options_BarHealthNumFormat2_List[i+1])
            DoneInitTab[306]=true
        end
    elseif subNo==307 then
        if not DoneInitTab[307] then
            local tmpBarHealthNumFormat1_List=HealBot_Options_BarHealthNumFormat_genList()
            HealBot_Options_BarHealthNumFormat1.initialize = HealBot_Options_BarHealthNumFormat1_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BarHealthNumFormat1, tmpBarHealthNumFormat1_List[Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["NUMFORMAT1"]])
            DoneInitTab[307]=true
        end
    elseif subNo==308 then
        if not DoneInitTab[308] then
            local i=Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["NUMFORMAT2"]
            if i>1 then i=(i*2)-1 end
            HealBot_Options_BarHealthNumFormat2.initialize = HealBot_Options_BarHealthNumFormat2_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BarHealthNumFormat2, HealBot_Options_BarHealthNumFormat2_List[i]..HealBot_Options_StorePrev["hbBarHealthNumFormatTxt"]..HealBot_Options_BarHealthNumFormat2_List[i+1])
            DoneInitTab[308]=true
        end
    elseif subNo==309 then
        if not DoneInitTab[309] then
            HealBot_Options_FontOutline.initialize = HealBot_Options_FontOutline_DropDown
            UIDropDownMenu_SetText(HealBot_Options_FontOutline, HealBot_Options_FontOutline_List[Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["OUTLINE"]])
            DoneInitTab[309]=true
        end
    elseif subNo==310 then
        if not DoneInitTab[310] then
            HealBot_Options_ManaIndicator.initialize = HealBot_Options_ManaIndicator_DropDown
            UIDropDownMenu_SetText(HealBot_Options_ManaIndicator, HealBot_Options_ManaIndicator_List[Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["LOWMANA"]])
            DoneInitTab[310]=true
        end
    elseif subNo==311 then
        if not DoneInitTab[311] then
            if (Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HLTHTYPE"] or 0)<1 then Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HLTHTYPE"]=1 end
            HealBot_Options_BarHealthType.initialize = HealBot_Options_BarHealthType_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BarHealthType, HealBot_Options_BarHealthType_List[Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HLTHTYPE"]])
            DoneInitTab[311]=true
        end
    elseif subNo==312 then
        if not DoneInitTab[312] then
            HealBot_Options_ExtraSort.initialize = HealBot_Options_ExtraSort_DropDown
            UIDropDownMenu_SetText(HealBot_Options_ExtraSort, HealBot_Options_ExtraSort_List[Healbot_Config_Skins.Sort[Healbot_Config_Skins.Current_Skin]["RAIDORDER"]])
            DoneInitTab[312]=true
        end
    elseif subNo==313 then
        if not DoneInitTab[313] then
            HealBot_Options_ExtraSubSort.initialize = HealBot_Options_ExtraSubSort_DropDown
            UIDropDownMenu_SetText(HealBot_Options_ExtraSubSort, HealBot_Options_ExtraSubSort_List[Healbot_Config_Skins.Sort[Healbot_Config_Skins.Current_Skin]["SUBORDER"]])
            DoneInitTab[313]=true
        end
    elseif subNo==314 then
        if not DoneInitTab[314] then
            HealBot_Options_StorePrev["FilterHoTctlName"]=HealBot_Options_FilterHoTctl_List[HealBot_Options_StorePrev["FilterHoTctlID"]]
            HealBot_Options_FilterHoTctl.initialize = HealBot_Options_FilterHoTctl_DropDown
            UIDropDownMenu_SetText(HealBot_Options_FilterHoTctl, HealBot_Options_StorePrev["FilterHoTctlName"])
            DoneInitTab[314]=true
        end
    elseif subNo==315 then
        if not DoneInitTab[315] then
            local HoTctlName_List = HealBot_Options_Class_HoTctlName_genList()
            if HealBot_Options_StorePrev["FilterHoTctlNameTrim"] and HealBot_Globals.WatchHoT[HealBot_Options_StorePrev["FilterHoTctlNameTrim"]] and not
               HealBot_Globals.WatchHoT[HealBot_Options_StorePrev["FilterHoTctlNameTrim"]][HealBot_Globals.HoTname] then HealBot_Globals.HoTname=HoTctlName_List[1] end
            HealBot_Options_Class_HoTctlName.initialize = HealBot_Options_Class_HoTctlName_DropDown
            UIDropDownMenu_SetText(HealBot_Options_Class_HoTctlName, HealBot_Globals.HoTname)
            DoneInitTab[315]=true
        end
    elseif subNo==316 then
        if not DoneInitTab[316] then
            HealBot_Options_Class_HoTctlAction.initialize = HealBot_Options_Class_HoTctlAction_DropDown
            local x=HealBot_Globals.WatchHoT[HealBot_Options_StorePrev["FilterHoTctlNameTrim"]][HealBot_Globals.HoTname] or 1
            UIDropDownMenu_SetText(HealBot_Options_Class_HoTctlAction, HealBot_Options_Class_HoTctlAction_List[x])
            DoneInitTab[316]=true
        end
    elseif subNo==317 then
        if not DoneInitTab[317] then
            HealBot_Options_TooltipPos.initialize = HealBot_Options_TooltipPos_DropDown
            UIDropDownMenu_SetText(HealBot_Options_TooltipPos, HealBot_Options_TooltipPos_List[Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TIPLOC"]])
            DoneInitTab[317]=true
        end
    elseif subNo==318 then -- Always run
        HealBot_Options_ShareSkin.initialize = HealBot_Options_ShareSkin_DropDown
        UIDropDownMenu_SetText(HealBot_Options_ShareSkin, HealBot_Options_StorePrev["hbCurUnitName"])
    elseif subNo==319 then
        if not DoneInitTab[319] then
            HealBot_Options_Skins.initialize = HealBot_Options_Skins_DropDown
            UIDropDownMenu_SetText(HealBot_Options_Skins, HealBot_Skins[Healbot_Config_Skins.Skin_ID])
            DoneInitTab[319]=true
        end
    elseif subNo==320 then
        if not DoneInitTab[320] then
            HealBot_Options_AggroAlertLevel.initialize = HealBot_Options_AggroAlertLevel_DropDown
            UIDropDownMenu_SetText(HealBot_Options_AggroAlertLevel, HealBot_Options_AggroAlertLevel_List[Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["ALERT"]])
            DoneInitTab[320]=true
        end
    elseif subNo==321 then
        if not DoneInitTab[321] then
            HealBot_Options_AggroIndAlertLevel.initialize = HealBot_Options_AggroIndAlertLevel_DropDown
            UIDropDownMenu_SetText(HealBot_Options_AggroIndAlertLevel, HealBot_Options_AggroIndAlertLevel_List[Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["ALERTIND"]])
            DoneInitTab[321]=true
        end
    elseif subNo==322 then
        if not DoneInitTab[322] then
            HealBot_Options_BarIncHealColour.initialize = HealBot_Options_BarIncHealColour_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BarIncHealColour, HealBot_Options_BarIncHealColour_List[Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["IC"]])
            DoneInitTab[322]=true
        end
    elseif subNo==323 then
        if not DoneInitTab[323] then
            HealBot_Options_BarHealthColour.initialize = HealBot_Options_BarHealthColour_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BarHealthColour, HealBot_Options_BarHealthColour_List[Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HLTH"]])
            DoneInitTab[323]=true
        end
    elseif subNo==324 then
        if not DoneInitTab[324] then
            HealBot_Options_BarHealthIncHeal.initialize = HealBot_Options_BarHealthIncHeal_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BarHealthIncHeal, HealBot_Options_BarHealthIncHeal_List[Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["INCHEALS"]])
            DoneInitTab[324]=true
        end
    elseif subNo==325 then
        if not DoneInitTab[325] then
            HealBot_Options_BarHealthBackColour.initialize = HealBot_Options_BarHealthBackColour_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BarHealthBackColour, HealBot_Options_BarHealthColour_List[Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BACK"]])
            DoneInitTab[325]=true
        end
    elseif subNo==326 then
        if not DoneInitTab[326] then
            HealBot_BarButtonShowHoTTextCount:SetChecked(Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SCNT"])
            HealBot_BarButtonShowHoTTextCountSelfCast:SetChecked(Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SSCNT"])
            HealBot_BarButtonShowHoTTextDuration:SetChecked(Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SDUR"])
            HealBot_BarButtonShowHoTTextDurationSelfCast:SetChecked(Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SSDUR"])
            HealBot_Options_val2_OnLoad(HealBot_BarButtonIconTextScale,HEALBOT_OPTIONS_ICONTEXTSCALE,4,8,0.5,10)
            HealBot_BarButtonIconTextScale:SetValue((Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SCALE"] or 7.5)*10)
            HealBot_BarButtonIconTextScaleText:SetText(HEALBOT_OPTIONS_ICONTEXTSCALE..": "..Healbot_Config_Skins.IconText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SCALE"])
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
            DoneInitTab[326]=true
        end
    elseif subNo==327 then
        if not DoneInitTab[327] then
           -- HealBot_Options_val_OnLoad(HealBot_Options_FontName,HEALBOT_OPTIONS_SKINFONT,1,100,1)
            HealBot_Options_FontName:SetValue(fontsIndex[Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["FONT"]] or 0)
            HealBot_Options_val_OnLoad(HealBot_Options_FontHeight,HEALBOT_OPTIONS_SKINFHEIGHT,7,18,1)
            HealBot_Options_FontHeight:SetValue(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HEIGHT"])
            HealBot_Options_FontHeightText:SetText(HEALBOT_OPTIONS_SKINFHEIGHT..": "..Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HEIGHT"])
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
            HealBot_Options_TextAlignText:SetText(HEALBOT_OPTIONS_TEXTALIGNMENT..": "..Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["ALIGN"])
            HealBot_Options_NumberTextLines:SetChecked(Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["DOUBLE"])
            HealBot_Options_SetText(HealBot_Options_NumberTextLines,HEALBOT_OPTIONS_DOUBLETEXTLINES)
            HealBot_BarOptTextColorpickt:SetText(HEALBOT_SKIN_ENTEXT);
            HealBot_EnTextColorpickt:SetText(HEALBOT_SKIN_ENTEXT);
            HealBot_DisTextColorpickt:SetText(HEALBOT_SKIN_DISTEXT);
            HealBot_DebTextColorpickt:SetText(HEALBOT_SKIN_DEBTEXT);
            HealBot_Options_SetText(HealBot_Options_ShowClassOnBarType1,HEALBOT_SHOW_CLASS_AS_ICON)
            HealBot_Options_SetText(HealBot_Options_ShowClassOnBarType2,HEALBOT_SHOW_CLASS_AS_TEXT)
            g=_G["HealBot_Options_TextSkins_FontStr"]
            g:SetText(HEALBOT_OPTIONS_TEXTOPTIONS)
            g=_G["healbotskinbarsfoutlinefStr"]
            g:SetText(HEALBOT_OPTIONS_SKINFOUTLINE)
            DoneInitTab[327]=true
        end
    elseif subNo==328 then
        if not DoneInitTab[328] then
            HealBot_Options_CastNotify_OnClick(nil,Healbot_Config_Skins.Chat[Healbot_Config_Skins.Current_Skin]["NOTIFY"])
            HealBot_Options_NotifyChan:SetText(Healbot_Config_Skins.Chat[Healbot_Config_Skins.Current_Skin]["CHAN"])
            HealBot_Options_NotifyOtherMsg:SetText(Healbot_Config_Skins.Chat[Healbot_Config_Skins.Current_Skin]["MSG"])   
            HealBot_Options_CastNotifyResOnly:SetChecked(Healbot_Config_Skins.Chat[Healbot_Config_Skins.Current_Skin]["RESONLY"])
            HealBot_Options_SetText(HealBot_Options_CastNotifyResOnly,HEALBOT_OPTIONS_CASTNOTIFYRESONLY)
            HealBot_Options_SetText(HealBot_Options_CastNotify1,HEALBOT_OPTIONS_CASTNOTIFY1)
            HealBot_Options_SetText(HealBot_Options_CastNotify2,HEALBOT_OPTIONS_CASTNOTIFY2)
            HealBot_Options_SetText(HealBot_Options_CastNotify3,HEALBOT_OPTIONS_CASTNOTIFY3)
            HealBot_Options_SetText(HealBot_Options_CastNotify4,HEALBOT_OPTIONS_CASTNOTIFY4)
            HealBot_Options_SetText(HealBot_Options_CastNotify5,HEALBOT_OPTIONS_CASTNOTIFY5)
            HealBot_Options_SetText(HealBot_Options_CastNotify6,HEALBOT_OPTIONS_CASTNOTIFY6)
            HealBot_Options_NotifyOtherMsgTxt:SetText(HEALBOT_OPTIONS_NOTIFY_MSG) -- This is null > .."  ("..HEALBOT_OPTIONS_CASTNOTIFYTAGS..")")
            HealBot_HealButtons_ChatFrameTxt:SetText(HEALBOT_OPTIONS_HEAL_CHATOPT)
            DoneInitTab[328]=true
        end
    elseif subNo==329 then
        if not DoneInitTab[329] then
            HealBot_Options_CrashProt:SetChecked(Healbot_Config_Skins.Protection[Healbot_Config_Skins.Current_Skin]["CRASH"])
            HealBot_Options_SetText(HealBot_Options_CrashProt,HEALBOT_OPTIONS_CRASHPROT)
            HealBot_Options_UseGeneralMacros:SetChecked(Healbot_Config_Skins.Protection[Healbot_Config_Skins.Current_Skin]["GENERALMACRO"])
            HealBot_Options_SetText(HealBot_Options_UseGeneralMacros,HEALBOT_OPTIONS_USEGENERALMACRO)
            HealBot_Options_CombatProt:SetChecked(Healbot_Config_Skins.Protection[Healbot_Config_Skins.Current_Skin]["COMBAT"])
            HealBot_Options_SetText(HealBot_Options_CombatProt,HEALBOT_OPTIONS_COMBATPROT)
            HealBot_Options_val_OnLoad(HealBot_Options_CombatPartyNo,HEALBOT_COMBATPROT_PARTYNO,0,4,1)
            HealBot_Options_CombatPartyNo:SetValue(Healbot_Config_Skins.Protection[Healbot_Config_Skins.Current_Skin]["COMBATPARTY"])
            HealBot_Options_CombatPartyNoText:SetText(Healbot_Config_Skins.Protection[Healbot_Config_Skins.Current_Skin]["COMBATPARTY"].." "..HEALBOT_COMBATPROT_PARTYNO)
            HealBot_Options_val_OnLoad(HealBot_Options_CombatRaidNo,HEALBOT_COMBATPROT_RAIDNO,0,24,1)
            HealBot_Options_CombatRaidNo:SetValue(Healbot_Config_Skins.Protection[Healbot_Config_Skins.Current_Skin]["COMBATRAID"])
            HealBot_Options_CombatRaidNoText:SetText(Healbot_Config_Skins.Protection[Healbot_Config_Skins.Current_Skin]["COMBATRAID"].." "..HEALBOT_COMBATPROT_RAIDNO)
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
            DoneInitTab[329]=true
        end
    elseif subNo==330 then
        if not DoneInitTab[330] then
            HealBot_Options_HighlightActiveBarInCombat:SetChecked(Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["CBARCOMBAT"])
            HealBot_Options_SetText(HealBot_Options_HighlightActiveBarInCombat,HEALBOT_OPTIONS_MONITORBUFFSC)
            HealBot_Options_HighlightTargetBarInCombat:SetChecked(Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["TBARCOMBAT"])
            HealBot_Options_SetText(HealBot_Options_HighlightTargetBarInCombat,HEALBOT_OPTIONS_MONITORBUFFSC)
            HealBot_Options_Pct_OnLoad_MinMax(HealBot_Options_AggroFlashAlphaMax,HEALBOT_WORDS_MAX,0.2,1,0.05,2)
            HealBot_Options_AggroFlashAlphaMax:SetValue(Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["MAXA"])
            HealBot_Options_Pct_OnValueChanged(HealBot_Options_AggroFlashAlphaMax)
            HealBot_Options_Pct_OnLoad_MinMax(HealBot_Options_AggroFlashAlphaMin,HEALBOT_WORDS_MIN,0,0.8,0.05,2)
            HealBot_Options_AggroFlashAlphaMin:SetValue(Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["MINA"])
            HealBot_Options_Pct_OnValueChanged(HealBot_Options_AggroFlashAlphaMin)
            HealBot_Options_val2_OnLoad(HealBot_Options_AggroFlashFreq,HEALBOT_OPTIONS_AGGROFLASHFREQ,0.5,10,0.5,100)
            HealBot_Options_AggroFlashFreq:SetValue(Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["FREQ"]*100)
            HealBot_Options_AggroFlashFreqText:SetText(HEALBOT_OPTIONS_AGGROFLASHFREQ..": "..Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["FREQ"])
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
            DoneInitTab[330]=true
        end
    elseif subNo==331 then
        if not DoneInitTab[331] then
            HealBot_Options_AggroTrack:SetChecked(Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["SHOW"])
            HealBot_Options_SetText(HealBot_Options_AggroTrack,HEALBOT_OPTION_AGGROTRACK)
            HealBot_Options_AggroBar:SetChecked(Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["SHOWBARS"])
            HealBot_Options_SetText(HealBot_Options_AggroBar,HEALBOT_OPTION_AGGROBAR)
            HealBot_Options_AggroTxt:SetChecked(Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["SHOWTEXT"])
            HealBot_Options_SetText(HealBot_Options_AggroTxt,HEALBOT_OPTION_AGGROTXT)
            HealBot_Options_AggroInd:SetChecked(Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["SHOWIND"])
            HealBot_Options_SetText(HealBot_Options_AggroInd,HEALBOT_OPTION_AGGROIND)
            HealBot_Options_AggroBarPct:SetChecked(Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["SHOWBARSPCT"])
            HealBot_Options_SetText(HealBot_Options_AggroBarPct,HEALBOT_OPTION_AGGROPCTBAR)
            HealBot_Options_AggroTxtPct:SetChecked(Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["SHOWTEXTPCT"])
            HealBot_Options_SetText(HealBot_Options_AggroTxtPct,HEALBOT_OPTION_AGGROPCTTXT)
            HealBot_Options_HighlightActiveBar:SetChecked(Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["CBAR"])
            HealBot_Options_SetText(HealBot_Options_HighlightActiveBar,HEALBOT_OPTION_HIGHLIGHTACTIVEBAR)
            HealBot_Options_HighlightTargetBar:SetChecked(Healbot_Config_Skins.Highlight[Healbot_Config_Skins.Current_Skin]["TBAR"])
            HealBot_Options_SetText(HealBot_Options_HighlightTargetBar,HEALBOT_OPTION_HIGHLIGHTTARGETBAR)
            DoneInitTab[331]=true
        end
    elseif subNo==332 then
        if not DoneInitTab[332] then
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
            HealBot_Options_val2_OnLoad(HealBot_BarButtonIconScale,HEALBOT_OPTIONS_ICONSCALE,2.5,10,0.5,10)
            HealBot_BarButtonIconScale:SetValue((Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SCALE"] or 7.5)*10)
            HealBot_BarButtonIconScaleText:SetText(HEALBOT_OPTIONS_ICONSCALE..": "..Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SCALE"])
            HealBot_BarButtonIconAlwaysEnabled:SetChecked(Healbot_Config_Skins.Icons[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["I15EN"])
            HealBot_Options_SetText(HealBot_BarButtonIconAlwaysEnabled,HEALBOT_OPTIONS_TTALPHA..": "..HEALBOT_OPTIONS_ENABLEHEALTHY)
            HealBot_Options_SetText(HealBot_BarButtonShowHoTonBar1,HEALBOT_OPTIONS_HOTONBAR)
            HealBot_Options_SetText(HealBot_BarButtonShowHoTonBar2,HEALBOT_OPTIONS_HOTOFFBAR)
            HealBot_Options_SetText(HealBot_BarButtonShowHoTonBar3,HEALBOT_OPTIONS_HOTBELOWBAR)
            HealBot_Options_SetText(HealBot_BarButtonShowHoTposBar1,HEALBOT_OPTIONS_HOTBARLEFT)
            HealBot_Options_SetText(HealBot_BarButtonShowHoTposBar2,HEALBOT_OPTIONS_HOTBARRIGHT)
            HealBot_Options_Class_HoTctlTxt:SetText(UnitClass("player").." "..HEALBOT_ACTION_OPTIONS);
            HealBot_Options_Class_HoTctlNameTxt:SetText(HEALBOT_OPTIONS_ALLSPELLS);
            HealBot_Options_Class_HoTctlActionTxt:SetText(HEALBOT_OPTIONS_HOTSHOWICON);
            g=_G["HealBot_Options_Skins_HoTs2Txt"]
            g:SetText(HEALBOT_OPTIONS_ICONOPTTEXT)
            g=_G["HealBot_Options_Skins_HoTs2Text3"]
            g:SetText(HEALBOT_OPTIONS_HOTPOSITION)
            g=_G["HealBot_Options_Class_HoTctlFilterNameTxt"]
            g:SetText(HEALBOT_WORD_FILTER)
            DoneInitTab[332]=true
        end
    elseif subNo==333 then
        if not DoneInitTab[333] then
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
            DoneInitTab[333]=true
        end
    elseif subNo==334 then
        if not DoneInitTab[334] then
            HealBot_Options_val_OnLoad(HealBot_Options_BarBCSpaceS,HEALBOT_OPTIONS_SKINBCSPACE,0,15,1)
            HealBot_Options_BarBCSpaceS:SetValue(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CMARGIN"])
            HealBot_Options_BarBCSpaceSText:SetText(HEALBOT_OPTIONS_SKINBCSPACE..": "..Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["CMARGIN"])
            HealBot_Options_val_OnLoad(HealBot_Options_Bar2Size,HEALBOT_OPTIONS_BAR2SIZE,0,15,1)
            HealBot_Options_Bar2Size:SetValue(Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["POWERSIZE"])
            HealBot_Options_Bar2SizeText:SetText(HEALBOT_OPTIONS_BAR2SIZE..": "..Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["POWERSIZE"])
            HealBot_Options_val_OnLoad(HealBot_Options_AggroBarSize,HEALBOT_OPTIONS_AGGROBARSIZE,1,15,1)
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
            DoneInitTab[334]=true
        end
    elseif subNo==335 then
        if not DoneInitTab[335] then
            HealBot_Options_Pct_OnLoad(HealBot_Options_BarAlphaDis,HEALBOT_OPTIONS_BARALPHADIS)
            HealBot_Options_BarAlphaDis:SetValue(Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["DISA"])
            HealBot_Options_Pct_OnValueChanged(HealBot_Options_BarAlphaDis)
            HealBot_Options_Pct_OnLoad(HealBot_Options_BarAlphaEor,HEALBOT_OPTIONS_BARALPHAEOR)
            HealBot_Options_BarAlphaEor:SetValue(Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["ORA"])
            HealBot_Options_Pct_OnValueChanged(HealBot_Options_BarAlphaEor)
            HealBot_Options_Pct_OnLoad_MinMax(HealBot_Options_BarAlpha,HEALBOT_OPTIONS_BARALPHA,0.25,1,0.01)
            HealBot_Options_BarAlpha:SetValue(Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HA"] or 95);
            HealBot_Options_Pct_OnValueChanged(HealBot_Options_BarAlpha)
            HealBot_Options_Pct_OnLoad_MinMax(HealBot_Options_BarAlphaInHeal,HEALBOT_OPTIONS_TTALPHA,0,0.95,0.01)
            HealBot_Options_BarAlphaInHeal:SetValue(Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["IA"]);
            HealBot_Options_Pct_OnValueChanged(HealBot_Options_BarAlphaInHeal)
            HealBot_Options_Pct_OnLoad_MinMax(HealBot_Options_BarAlphaAbsorb,HEALBOT_OPTIONS_TTALPHA,0,0.95,0.01)
            HealBot_Options_BarAlphaAbsorb:SetValue(Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["AA"] or 50);
            HealBot_Options_Pct_OnValueChanged(HealBot_Options_BarAlphaAbsorb)
            HealBot_Options_Pct_OnLoad_MinMax(HealBot_Options_BarAlphaBackGround,HEALBOT_OPTIONS_TTALPHA,0,0.95,0.01)
            HealBot_Options_BarAlphaBackGround:SetValue(Healbot_Config_Skins.BarCol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["BA"]);
            HealBot_Options_Pct_OnValueChanged(HealBot_Options_BarAlphaBackGround)
            HealBot_Options_val_OnLoad(HealBot_Options_BarOutlineBackGround,HEALBOT_OPTIONS_OUTLINE,0,15,1)
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
            DoneInitTab[335]=true
        end
    elseif subNo==336 then
        if not DoneInitTab[336] then
           -- HealBot_Options_val_OnLoad(HealBot_Options_HeadTextureS,HEALBOT_OPTIONS_SKINTEXTURE,1,100,1)
            HealBot_Options_HeadTextureS:SetValue(texturesIndex[Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]] or 0)
            HealBot_Options_Pct_OnLoad_MinMax(HealBot_Options_HeadWidthS,HEALBOT_OPTIONS_SKINWIDTH,0.25,1,0.01)
            HealBot_Options_HeadWidthS:SetValue(Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["WIDTH"])
            HealBot_Options_Pct_OnValueChanged(HealBot_Options_HeadWidthS)
            HealBot_Options_Pct_OnLoad_MinMax(HealBot_Options_HeadHightS,HEALBOT_OPTIONS_SKINHEIGHT,0.25,1,0.01)
            HealBot_Options_HeadHightS:SetValue(Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HEIGHT"])
            HealBot_Options_Pct_OnValueChanged(HealBot_Options_HeadHightS)
           -- HealBot_Options_val_OnLoad(HealBot_Options_HeadFontNameS,HEALBOT_OPTIONS_SKINFONT,1,100,1)
            HealBot_Options_HeadFontNameS:SetValue(fontsIndex[Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["FONT"]] or 0)
            HealBot_Options_val_OnLoad(HealBot_Options_HeadFontHeightS,HEALBOT_OPTIONS_SKINFHEIGHT,7,18,1)
            HealBot_Options_HeadFontHeightS:SetValue(Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HEIGHT"])
            HealBot_Options_HeadFontHeightSText:SetText(HEALBOT_OPTIONS_SKINFHEIGHT..": "..Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HEIGHT"])
            HealBot_Options_ShowHeaders:SetChecked(Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOW"])
            HealBot_Options_SetText(HealBot_Options_ShowHeaders,HEALBOT_OPTIONS_SHOWHEADERS)
            g=_G["HealBot_HeadBarColorpickt"]
            g:SetText(HEALBOT_SKIN_HEADERBARCOL)
            g=_G["HealBot_HeadTextColorpickt"]
            g:SetText(HEALBOT_SKIN_HEADERTEXTCOL)
            g=_G["healbotskinfontoutlinefontstr"]
            g:SetText(HEALBOT_OPTIONS_SKINFOUTLINE)
            g=_G["HealBot_HealButtons_HeadersFrameText"]
            g:SetText(HEALBOT_OPTIONS_HEADEROPTTEXT)
            DoneInitTab[336]=true
        end
    elseif subNo==337 then
        if not DoneInitTab[337] then
            HealBot_Options_FocusAlwaysShow:SetChecked(Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["FALWAYSSHOW"])
            HealBot_Options_SetText(HealBot_Options_FocusAlwaysShow,HEALBOT_OPTIONS_ALWAYS_SHOW_FOCUS)
            HealBot_Options_TargetAlwaysShow:SetChecked(Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TALWAYSSHOW"])
            HealBot_Options_SetText(HealBot_Options_TargetAlwaysShow,HEALBOT_OPTIONS_ALWAYS_SHOW_TARGET)
            HealBot_Options_TargetOnlyFriend:SetChecked(Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TONLYFRIEND"])
            HealBot_Options_SetText(HealBot_Options_TargetOnlyFriend,HEALBOT_OPTIONS_TARGET_ONLY_FRIEND)
            HealBot_Options_FocusOnlyFriend:SetChecked(Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["FONLYFRIEND"])
            HealBot_Options_SetText(HealBot_Options_FocusOnlyFriend,HEALBOT_OPTIONS_FOCUS_ONLY_FRIEND)
            
            HealBot_Options_GroupPetsByFive:SetChecked(Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["GROUPPETS"])
            HealBot_Options_SetText(HealBot_Options_GroupPetsByFive,HEALBOT_OPTIONS_GROUP_PETS_BY_FIVE)
            HealBot_Options_Pct_OnLoad(HealBot_Options_AlertLevelIC,HEALBOT_OPTIONS_INCOMBATALERTLEVEL)
            HealBot_Options_AlertLevelIC:SetValue(Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["ALERTIC"])
            HealBot_Options_Pct_OnValueChanged(HealBot_Options_AlertLevelIC)
            HealBot_Options_Pct_OnLoad(HealBot_Options_AlertLevelOC,HEALBOT_OPTIONS_OUTCOMBATALERTLEVEL)
            HealBot_Options_AlertLevelOC:SetValue(Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["ALERTOC"])
            HealBot_Options_Pct_OnValueChanged(HealBot_Options_AlertLevelOC)
            HealBot_Options_SubSortIncGroup:SetChecked(Healbot_Config_Skins.Sort[Healbot_Config_Skins.Current_Skin]["SUBIG"])
            HealBot_Options_SetText(HealBot_Options_SubSortIncGroup,HEALBOT_OPTIONS_GROUPHEALS)
            HealBot_Options_SubSortIncPets:SetChecked(Healbot_Config_Skins.Sort[Healbot_Config_Skins.Current_Skin]["SUBIP"])
            HealBot_Options_SetText(HealBot_Options_SubSortIncPets,HEALBOT_OPTIONS_PETHEALS)
            HealBot_Options_SubSortIncVehicle:SetChecked(Healbot_Config_Skins.Sort[Healbot_Config_Skins.Current_Skin]["SUBIV"])
            HealBot_Options_SetText(HealBot_Options_SubSortIncVehicle,HEALBOT_VEHICLE)
            HealBot_Options_SubSortIncMainTanks:SetChecked(Healbot_Config_Skins.Sort[Healbot_Config_Skins.Current_Skin]["SUBIT"])
            HealBot_Options_SetText(HealBot_Options_SubSortIncMainTanks,HEALBOT_OPTIONS_TANKHEALS)
            HealBot_Options_SubSortIncMyTargets:SetChecked(Healbot_Config_Skins.Sort[Healbot_Config_Skins.Current_Skin]["SUBIMT"])
            HealBot_Options_SetText(HealBot_Options_SubSortIncMyTargets,HEALBOT_OPTIONS_MYTARGET)
            HealBot_Options_TargetIncSelf:SetChecked(Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TINCSELF"])
            HealBot_Options_SetText(HealBot_Options_TargetIncSelf,HEALBOT_OPTIONS_SELFHEALS)
            HealBot_Options_TargetIncGroup:SetChecked(Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TINCGROUP"])
            HealBot_Options_SetText(HealBot_Options_TargetIncGroup,HEALBOT_OPTIONS_GROUPHEALS)
            HealBot_Options_TargetIncRaid:SetChecked(Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TINCRAID"])
            HealBot_Options_SetText(HealBot_Options_TargetIncRaid,HEALBOT_OPTIONS_EMERGENCYHEALS)
            HealBot_Options_TargetIncPet:SetChecked(Healbot_Config_Skins.Healing[Healbot_Config_Skins.Current_Skin]["TINCPET"])
            HealBot_Options_SetText(HealBot_Options_TargetIncPet,HEALBOT_OPTIONS_PETHEALS)
            HealBot_Options_HideBars:SetChecked(Healbot_Config_Skins.BarsHide[Healbot_Config_Skins.Current_Skin]["STATE"])
            HealBot_Options_SetText(HealBot_Options_HideBars,HEALBOT_HIDE_BARS)
            HealBot_Options_HideIncFocus:SetChecked(Healbot_Config_Skins.BarsHide[Healbot_Config_Skins.Current_Skin]["INCFOCUS"])
            HealBot_Options_SetText(HealBot_Options_HideIncFocus,HEALBOT_FOCUS)
            HealBot_Options_HideIncGroup:SetChecked(Healbot_Config_Skins.BarsHide[Healbot_Config_Skins.Current_Skin]["INCGROUP"])
            HealBot_Options_SetText(HealBot_Options_HideIncGroup,HEALBOT_OPTIONS_GROUPHEALS)
            HealBot_Options_HideIncTank:SetChecked(Healbot_Config_Skins.BarsHide[Healbot_Config_Skins.Current_Skin]["INCTANK"])
            HealBot_Options_SetText(HealBot_Options_HideIncTank,HEALBOT_OPTIONS_TANKHEALS)
            HealBot_Options_HideIncMyTargets:SetChecked(Healbot_Config_Skins.BarsHide[Healbot_Config_Skins.Current_Skin]["INCMYTARGETS"])
            HealBot_Options_SetText(HealBot_Options_HideIncMyTargets,HEALBOT_OPTIONS_MYTARGET)
            HealBot_Options_SubSortPlayerFirst:SetChecked(Healbot_Config_Skins.Sort[Healbot_Config_Skins.Current_Skin]["SUBPF"])
            HealBot_Options_SetText(HealBot_Options_SubSortPlayerFirst,HEALBOT_OPTIONS_SUBSORTSELFFIRST)
            g=_G["HealBot_HealButtons_Text"]
            g:SetText(HEALBOT_OPTIONS_HEAL_BUTTONS)
            g=_G["HealBot_IncludeTargets_Text"]
            g:SetText(HEALBOT_OPTIONS_TARGETHEALS.." "..HEALBOT_WORDS_INCLUDE)
            g=_G["HealBot_SkinsSubFrameSelectHealRaidFrameb"]
            g:SetText(HEALBOT_OPTIONS_EMERGENCYHEALS)
            g=_G["HealBot_SkinsSubFrameSelectHealSortFrameb"]
            g:SetText(HEALBOT_OPTIONS_TAB_SORT)
            g=_G["HealBot_SkinsSubFrameSelectHealHideFrameb"]
            g:SetText(HEALBOT_OPTIONS_TAB_HIDE)
            g=_G["healbotraidfilterfontstr"]
            g:SetText(HEALBOT_OPTIONS_EMERGFILTER)
            g=_G["healbotraidfiltergrpsfontstr"]
            g:SetText(HEALBOT_OPTIONS_EMERGFILTERGROUPS)
            g=_G["healbotextrasorttopfontstr"]
            g:SetText(HEALBOT_OPTIONS_EXTRASORT)
            g=_G["healbotsubsortincfontstr"]
            g:SetText(HEALBOT_OPTIONS_SUBSORTINC)
            g=_G["healbotmainsortfontstr"]
            g:SetText(HEALBOT_OPTIONS_MAINSORT)
            g=_G["healbotsubsortfontstr"]
            g:SetText(HEALBOT_OPTIONS_SUBSORT)
            g=_G["HealBot_IncludeHide_Text"]
            g:SetText(HEALBOT_WORDS_INCLUDE)
            DoneInitTab[337]=true
        end
    elseif subNo==338 then
        if not DoneInitTab[338] then
            HealBot_Options_FrameAliasList()
            for id=1,5 do
                g=_G["HealBot_Options_HealGroups"..id]
                g:SetChecked(Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][id]["STATE"])
                g=_G["HealBot_Options_HealGroups"..id.."Text"]
                g:SetText(id..": "..HealBot_HealGroupsTrans[Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][id]["NAME"]]);
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
            g=_G["HealBot_HealGroupButtons_Text"]
            g:SetText(HEALBOT_OPTIONS_HEAL_BUTTONS)
            g=_G["HealBot_HealButtonsGroups1_Text"]
            g:SetText(HEALBOT_OPTIONS_GROUPHEALS)
            DoneInitTab[338]=true
        end
    elseif subNo==339 then
        if not DoneInitTab[339] then
            HealBot_Options_FrameAliasList()
            for id=6,11 do
                g=_G["HealBot_Options_HealGroups"..id]
                g:SetChecked(Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][id]["STATE"])
                g=_G["HealBot_Options_HealGroups"..id.."Text"]
                g:SetText(id..": "..HealBot_HealGroupsTrans[Healbot_Config_Skins.HealGroups[Healbot_Config_Skins.Current_Skin][id]["NAME"]]);
            end
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
            DoneInitTab[339]=true
        end
    elseif subNo==340 then
        if not DoneInitTab[340] then
            HealBot_Options_PartyFrames:SetChecked(Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["HIDEPARTYF"])
            HealBot_Options_SetText(HealBot_Options_PartyFrames,HEALBOT_OPTIONS_HIDEPARTYFRAMES)
            HealBot_Options_PlayerTargetFrames:SetChecked(Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["HIDEPTF"])
            HealBot_Options_SetText(HealBot_Options_PlayerTargetFrames,HEALBOT_OPTIONS_HIDEPLAYERTARGET)
            HealBot_Options_MiniBossFrames:SetChecked(Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["HIDEBOSSF"])
            HealBot_Options_SetText(HealBot_Options_MiniBossFrames,HEALBOT_OPTIONS_HIDEMINIBOSSFRAMES)
            HealBot_Options_RaidFrames:SetChecked(Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["HIDERAIDF"])
            HealBot_Options_SetText(HealBot_Options_RaidFrames,HEALBOT_OPTIONS_HIDERAIDFRAMES)
            HealBot_Options_ManaIndicatorInCombat:SetChecked(Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["LOWMANACOMBAT"])
            HealBot_Options_SetText(HealBot_Options_ManaIndicatorInCombat,HEALBOT_OPTIONS_MONITORBUFFSC)
            HealBot_Options_UseFluidBars:SetChecked(Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["FLUIDBARS"])
            HealBot_Options_SetText(HealBot_Options_UseFluidBars,HEALBOT_OPTION_USEFLUIDBARS)
            HealBot_Options_val2_OnLoad(HealBot_Options_BarUpdateFreq,HEALBOT_OPTION_BARUPDFREQ,10,100,5,10)
            HealBot_Options_BarUpdateFreq:SetValue((Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["FLUIDFREQ"] or 2)*10)
            HealBot_Options_BarUpdateFreqText:SetText(HEALBOT_OPTION_BARUPDFREQ..": "..Healbot_Config_Skins.General[Healbot_Config_Skins.Current_Skin]["FLUIDFREQ"])
            g=_G["HealBot_GeneralSkin_FontStr"]
            g:SetText(HEALBOT_OPTIONS_TAB_GENERAL)
            g=_G["healbotskindefaultfontstr"]
            g:SetText(HEALBOT_OPTIONS_SKINDEFAULTFOR)
            g=_G["healbotlowmanaindfontstr"]
            g:SetText(HEALBOT_OPTIONS_LOWMANAINDICATOR)
            g=_G["healbotbacktextfontstr"]
            g:SetText(HEALBOT_SKIN_BACKTEXT)
            g=_G["healbotbordertextfontstr"]
            g:SetText(HEALBOT_SKIN_BORDERTEXT)
            DoneInitTab[340]=true
        end
    elseif subNo==341 then
        if not DoneInitTab[341] then
            HealBot_Options_UpdateMedia(3)
            HealBot_Options_NewSkinb:Disable()
            g=_G["HealBot_Options_ScaleFrameText"]
            g:SetText(HEALBOT_OPTIONS_SKINTEXT)
            HealBot_Options_DeleteSkin:SetText(HEALBOT_OPTIONS_DELSKIN)
            g=_G["HealBot_Options_ScaleFrameText2"]
            g:SetText(HEALBOT_OPTIONS_NEWSKINTEXT)
            HealBot_Options_NewSkinb:SetText(HEALBOT_OPTIONS_SAVESKIN)
            HealBot_Options_ApplyTab2Frames:SetText(HEALBOT_OPTIONS_SET_ALL_FRAMES)
            DoneInitTab[341]=true
        end
    elseif subNo==342 then
        if not DoneInitTab[342] then
            HealBot_Options_AbsorbColour.initialize = HealBot_Options_AbsorbColour_DropDown
            UIDropDownMenu_SetText(HealBot_Options_AbsorbColour, HealBot_Options_AbsorbColour_List[Healbot_Config_Skins.BarIACol[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["AC"]])
            DoneInitTab[342]=true
        end
    elseif subNo==343 then
        if not DoneInitTab[343] then
            g=_G["healbotframeanchorfontstr"]
            g:SetText(HEALBOT_OPTIONS_ANCHOR)
            g=_G["healbotbarsanchorfontstr"]
            g:SetText(HEALBOT_OPTIONS_BARSANCHOR)
            g=_G["healbotbarsgrowdirectionfontstr"]
            g:SetText(HEALBOT_OPTIONS_GROW_DIRECTION)
            g=_G["healbotbarsorientationfontstr"]
            g:SetText(HEALBOT_OPTIONS_BARSORIENTATION)
            g=_G["healbotaliasfontoutlinestr"]
            g:SetText(HEALBOT_OPTIONS_SKINFOUTLINE)
            g=_G["healbotframealiastextfontstr"]
            g:SetText(HEALBOT_SKIN_HEADERTEXTCOL)
            DoneInitTab[343]=true
        end
    elseif subNo==344 then
        if not DoneInitTab[344] then
            HealBot_Options_val2_OnLoad(HealBot_FrameScale,HEALBOT_OPTIONS_FRAMESCALE,2.5,30,0.5,10)
            HealBot_FrameScale:SetValue((Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SCALE"])*10)
            HealBot_FrameScaleText:SetText(HEALBOT_OPTIONS_FRAMESCALE..": "..Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SCALE"])
            HealBot_Options_val_OnLoad(HealBot_Options_AliasFontHeight,HEALBOT_OPTIONS_SKINFHEIGHT,7,18,1)
            HealBot_Options_AliasFontHeight:SetValue(Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SIZE"])
            HealBot_Options_AliasFontHeightText:SetText(HEALBOT_OPTIONS_SKINFHEIGHT..": "..Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SIZE"])
            HealBot_Options_val_OnLoad(HealBot_Options_AliasFontOffset,HEALBOT_OPTIONS_FONT_OFFSET,-10,25,1)
            HealBot_Options_AliasFontOffset:SetValue(Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["OFFSET"])
            HealBot_Options_AliasFontOffsetText:SetText(HEALBOT_OPTIONS_FONT_OFFSET..": "..Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["OFFSET"])
            HealBot_Options_SetFrameCols()
            HealBot_Options_ActionLocked:SetChecked(Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["LOCKED"])
            HealBot_Options_SetText(HealBot_Options_ActionLocked,HEALBOT_OPTIONS_ACTIONLOCKED)
            HealBot_Options_AutoShow:SetChecked(Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["AUTOCLOSE"])
            HealBot_Options_SetText(HealBot_Options_AutoShow,HEALBOT_OPTIONS_AUTOSHOW)
            HealBot_Options_PanelSounds:SetChecked(Healbot_Config_Skins.Frame[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["OPENSOUND"])
            HealBot_Options_SetText(HealBot_Options_PanelSounds,HEALBOT_OPTIONS_PANELSOUNDS)
            HealBot_Options_TooltipPosTxt:SetText(HEALBOT_OPTIONS_POSTOOLTIP)
            HealBot_Options_SetText(HealBot_Options_FrameTitle,HEALBOT_OPTIONS_FRAME_TITLE)
            HealBot_Options_FrameTitle:SetText(Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["NAME"])
            HealBot_Options_SetText(HealBot_Options_FrameAlias,HEALBOT_OPTIONS_FRAME_ALIAS)
            if Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["ALIAS"] and
               string.len(Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["ALIAS"])>0 then
                HealBot_Options_FrameAlias:SetText(Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["ALIAS"])
            else
                HealBot_Options_FrameAlias:SetText(HEALBOT_OPTIONS_FRAME.." "..HealBot_Options_StorePrev["FramesSelFrame"])
            end
            HealBot_Options_SetText(HealBot_Options_FrameAliasShow,HEALBOT_OPTIONS_FRAME_TITLE_SHOW)
            HealBot_Options_FrameAliasShow:SetChecked(Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["SHOW"])
            HealBot_Options_AliasFontName:SetValue(fontsIndex[Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["FONT"]] or 0)
            HealBot_Options_BarsGrowDirection.initialize = HealBot_Options_BarsGrowDirection_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BarsGrowDirection, HealBot_Options_BarsGrowDirection_List[Healbot_Config_Skins.Anchors[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["GROW"]])
            HealBot_Options_BarsOrientation.initialize = HealBot_Options_BarsOrientation_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BarsOrientation, HealBot_Options_BarsOrientation_List[Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["OFIX"]])
            HealBot_Options_AliasFontOutline.initialize = HealBot_Options_AliasFontOutline_DropDown
            UIDropDownMenu_SetText(HealBot_Options_AliasFontOutline, HealBot_Options_FontOutline_List[Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["OUTLINE"]])
            DoneInitTab[344]=true
        end
    elseif subNo==345 then
        if not DoneInitTab[345] then
            HealBot_Options_ShareSkinb:SetText(HEALBOT_OPTIONS_BUTTONSHARESKIN)
            HealBot_Options_LoadSkinb:SetText(HEALBOT_OPTIONS_BUTTONLOADSKIN)
            HealBot_ShareSkinsFrameTxt:SetText(HEALBOT_OPTIONS_SHARE_OPT)
            DoneInitTab[345]=true
        end
    elseif subNo==346 then
        if not DoneInitTab[346] then
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
            DoneInitTab[346]=true
        end
    end
end

function HealBot_Options_InitSub2(subNo)
    local g=nil
    if subNo==401 then
        if not DoneInitTab[401] then
            HealBot_Options_UpdateMedia(4)
            DoneInitTab[401]=true
        end
    elseif subNo==402 then
        if not DoneInitTab[402] then
            HealBot_Options_CDCPriority1.initialize = HealBot_Options_CDCPriority1_DropDown
            UIDropDownMenu_SetText(HealBot_Options_CDCPriority1, HealBot_Config_Cures.HealBotDebuffPriority[HEALBOT_DISEASE_en])
            DoneInitTab[402]=true
        end
    elseif subNo==403 then
        if not DoneInitTab[403] then
            HealBot_Options_CDCPriority2.initialize = HealBot_Options_CDCPriority2_DropDown
            UIDropDownMenu_SetText(HealBot_Options_CDCPriority2, HealBot_Config_Cures.HealBotDebuffPriority[HEALBOT_MAGIC_en])
            DoneInitTab[403]=true
        end
    elseif subNo==404 then
        if not DoneInitTab[404] then
            HealBot_Options_CDCPriority3.initialize = HealBot_Options_CDCPriority3_DropDown
            UIDropDownMenu_SetText(HealBot_Options_CDCPriority3, HealBot_Config_Cures.HealBotDebuffPriority[HEALBOT_POISON_en])
            DoneInitTab[404]=true
        end
    elseif subNo==405 then
        if not DoneInitTab[405] then
            HealBot_Options_CDCPriority4.initialize = HealBot_Options_CDCPriority4_DropDown
            UIDropDownMenu_SetText(HealBot_Options_CDCPriority4, HealBot_Config_Cures.HealBotDebuffPriority[HEALBOT_CURSE_en])
            DoneInitTab[405]=true
        end
    elseif subNo==406 then
        if not DoneInitTab[406] then
            HealBot_Options_CDebuffCat.initialize = HealBot_Options_CDebuffCat_DropDown
            UIDropDownMenu_SetText(HealBot_Options_CDebuffCat, HealBot_CDebuffCat_List[HealBot_Options_StorePrev["CDebuffCatID"]])
            DoneInitTab[406]=true
        end
    elseif subNo==407 then  -- Always run this
        local _ = HealBot_Options_CDebuffCat_genList()
        HealBot_Options_CDebuffTxt1.numButtons = 0;
        HealBot_Options_CDebuffTxt1.initialize = HealBot_Options_CDebuffTxt1_DropDown
        UIDropDownMenu_SetText(HealBot_Options_CDebuffTxt1, HealBot_Options_StorePrev["CDebuffcustomName"])
        HealBot_Options_CDCReverseDurC:SetChecked(HealBot_Globals.HealBot_Custom_Debuffs_RevDur[HealBot_Options_StorePrev["CDebuffcustomName"]] or false)
        local cdcBarCol=HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[HealBot_Options_StorePrev["CDebuffcustomName"]]
        if cdcBarCol==nil then cdcBarCol=true end
        HealBot_Options_CDCCol_OnOff:SetChecked(cdcBarCol)
        HealBot_Options_SetEnableDisableCDBtn()
    elseif subNo==408 then -- Always run this
        local x=HealBot_Options_StorePrev["customDebuffPriority"] or 10
        if HealBot_Options_StorePrev["CDebuffcustomName"] then
            if not HealBot_Globals.HealBot_Custom_Debuffs[HealBot_Options_StorePrev["CDebuffcustomName"]] then HealBot_Globals.HealBot_Custom_Debuffs[HealBot_Options_StorePrev["CDebuffcustomName"]]=x end;
            x=HealBot_Globals.HealBot_Custom_Debuffs[HealBot_Options_StorePrev["CDebuffcustomName"]]
            HealBot_Options_CDCReverseDurC:SetChecked(HealBot_Globals.HealBot_Custom_Debuffs_RevDur[HealBot_Options_StorePrev["CDebuffcustomName"]] or false)
            local cdcBarCol=HealBot_Globals.HealBot_Custom_Debuffs_ShowBarCol[HealBot_Options_StorePrev["CDebuffcustomName"]]
            if cdcBarCol==nil then cdcBarCol=true end
            HealBot_Options_CDCCol_OnOff:SetChecked(cdcBarCol)
            HealBot_Options_SetEnableDisableCDBtn()
        end
        HealBot_Options_CDCPriorityC.initialize = HealBot_Options_CDCPriorityC_DropDown
        UIDropDownMenu_SetSelectedID(HealBot_Options_CDCPriorityC, x)
        UIDropDownMenu_SetText(HealBot_Options_CDCPriorityC, x)
    elseif subNo==409 then
        if not DoneInitTab[409] then
            HealBot_Options_CDCTxt1.initialize = HealBot_Options_CDCTxt1_DropDown
            UIDropDownMenu_SetText(HealBot_Options_CDCTxt1, HealBot_Config_Cures.HealBotDebuffText[HealBot_Options_getDropDownId_bySpec(1)])
            DoneInitTab[409]=true
        end
    elseif subNo==410 then
        if not DoneInitTab[410] then
            HealBot_Options_CDCGroups1.initialize = HealBot_Options_CDCGroups1_DropDown
            UIDropDownMenu_SetText(HealBot_Options_CDCGroups1, HealBot_Options_BuffTxt_List[HealBot_Config_Cures.HealBotDebuffDropDown[HealBot_Options_getDropDownId_bySpec(1)]])
            DoneInitTab[410]=true
        end
    elseif subNo==411 then
        if not DoneInitTab[411] then
            HealBot_Options_CDCTxt2.initialize = HealBot_Options_CDCTxt2_DropDown
            UIDropDownMenu_SetText(HealBot_Options_CDCTxt2, HealBot_Config_Cures.HealBotDebuffText[HealBot_Options_getDropDownId_bySpec(2)])
            DoneInitTab[411]=true
        end
    elseif subNo==412 then
        if not DoneInitTab[412] then
            HealBot_Options_CDCGroups2.initialize = HealBot_Options_CDCGroups2_DropDown
            UIDropDownMenu_SetText(HealBot_Options_CDCGroups2, HealBot_Options_BuffTxt_List[HealBot_Config_Cures.HealBotDebuffDropDown[HealBot_Options_getDropDownId_bySpec(2)]])
            DoneInitTab[412]=true
        end
    elseif subNo==413 then
        if not DoneInitTab[413] then
            HealBot_Options_CDCTxt3.initialize = HealBot_Options_CDCTxt3_DropDown
            UIDropDownMenu_SetText(HealBot_Options_CDCTxt3, HealBot_Config_Cures.HealBotDebuffText[HealBot_Options_getDropDownId_bySpec(3)])
            DoneInitTab[413]=true
        end
    elseif subNo==414 then
        if not DoneInitTab[414] then
            HealBot_Options_CDCGroups3.initialize = HealBot_Options_CDCGroups3_DropDown
            UIDropDownMenu_SetText(HealBot_Options_CDCGroups3, HealBot_Options_BuffTxt_List[HealBot_Config_Cures.HealBotDebuffDropDown[HealBot_Options_getDropDownId_bySpec(3)]])
            DoneInitTab[414]=true
        end
    elseif subNo==415 then
        if not DoneInitTab[415] then
            HealBot_Options_CDCWarnRange1.initialize = HealBot_Options_CDCWarnRange1_DropDown
            UIDropDownMenu_SetText(HealBot_Options_CDCWarnRange1, HealBot_Debuff_RangeWarning_List[HealBot_Config_Cures.HealBot_CDCWarnRange_Bar])
            DoneInitTab[415]=true
        end
    elseif subNo==416 then
        if not DoneInitTab[416] then
            HealBot_Options_CDCWarnRange2.initialize = HealBot_Options_CDCWarnRange2_DropDown
            UIDropDownMenu_SetText(HealBot_Options_CDCWarnRange2, HealBot_Debuff_RangeWarning_List[HealBot_Config_Cures.HealBot_CDCWarnRange_Aggro])
            DoneInitTab[416]=true
        end
    elseif subNo==417 then
        if not DoneInitTab[417] then
            HealBot_Options_CDCWarnRange3.initialize = HealBot_Options_CDCWarnRange3_DropDown
            UIDropDownMenu_SetText(HealBot_Options_CDCWarnRange3, HealBot_Debuff_RangeWarning_List[HealBot_Config_Cures.HealBot_CDCWarnRange_Screen])
            DoneInitTab[417]=true
        end
    elseif subNo==418 then
        if not DoneInitTab[418] then
            HealBot_Options_CDCWarnRange4.initialize = HealBot_Options_CDCWarnRange4_DropDown
            UIDropDownMenu_SetText(HealBot_Options_CDCWarnRange4, HealBot_Debuff_RangeWarning_List[HealBot_Config_Cures.HealBot_CDCWarnRange_Sound])
            DoneInitTab[418]=true
        end
    elseif subNo==419 then -- Always Run
        HealBot_Options_CDCCastBy.initialize = HealBot_Options_CDCCastBy_DropDown
        local castBy=HEALBOT_CUSTOM_CASTBY_EVERYONE
        if HealBot_Globals.CureCustomDefaultCastBy=="ENEMY" then
            castBy=HEALBOT_CUSTOM_CASTBY_ENEMY
        end
        if HealBot_Options_StorePrev["CDebuffcustomName"] and HealBot_Globals.FilterCustomDebuff[HealBot_Options_StorePrev["CDebuffcustomName"]] then
            castBy=HealBot_CDebuffCasyBy_List[HealBot_Globals.FilterCustomDebuff[HealBot_Options_StorePrev["CDebuffcustomName"]]]
        end
        UIDropDownMenu_SetText(HealBot_Options_CDCCastBy, castBy)
        if not DoneInitTab[419] then
            HealBot_Options_CDCCastByCustom.initialize = HealBot_Options_CDCCastByCustom_DropDown
            UIDropDownMenu_SetText(HealBot_Options_CDCCastByCustom, HEALBOT_CUSTOM_CASTBY_ENEMY)
            DoneInitTab[419]=true
        end
    elseif subNo==420 then
        if not DoneInitTab[420] then
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
            DoneInitTab[420]=true
        end
    elseif subNo==421 then
        if not DoneInitTab[421] then
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
            HealBot_Options_SetText(HealBot_Options_CDCReverseDurC,HEALBOT_OPTIONS_CUSTOMDEBUFF_REVDUR)
            HealBot_Options_DeleteCDebuffBtn:SetText(HEALBOT_OPTIONS_DELSKIN)
            HealBot_Options_NewCDebuffBtn:SetText(HEALBOT_OPTIONS_SAVESKIN)
            HealBot_Options_SetText(HealBot_Options_CDCCol_OnOff,HEALBOT_SKIN_HEADERBARCOL)
            HealBot_Options_ResetCDebuffBtn:SetText(HEALBOT_WORD_RESET)
            HealBot_Options_SetEnableDisableCDBtn()
            DoneInitTab[421]=true
        end
    elseif subNo==422 then
        if not DoneInitTab[422] then
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
            g=_G["healbotcustomdebuffclassfontstr"]
            g:SetText(HEALBOT_CLASSES_CUSTOM)
            g=_G["HealBot_CDCWarn_Text"]
            g:SetText(HEALBOT_OPTIONS_CDCWARNINGS)
            DoneInitTab[422]=true
        end
    elseif subNo==501 then
        if not DoneInitTab[501] then
            BuffTextClass = HealBot_Config_Buffs.HealBotBuffText
            if not BuffTextClass[HealBot_Options_getDropDownId_bySpec(1)] then BuffTextClass[HealBot_Options_getDropDownId_bySpec(1)]=HEALBOT_WORDS_NONE  end;
            HealBot_Options_BuffTxt1.numButtons = 0;
            HealBot_Options_BuffTxt1.initialize = HealBot_Options_BuffTxt1_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BuffTxt1, BuffTextClass[HealBot_Options_getDropDownId_bySpec(1)])
            DoneInitTab[501]=true
        end
    elseif subNo==502 then
        if not DoneInitTab[502] then
            local BuffDropDownClass = HealBot_Config_Buffs.HealBotBuffDropDown
            if not BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(1)] then BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(1)]=1 end;
            HealBot_Options_BuffGroups1.initialize = HealBot_Options_BuffGroups1_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BuffGroups1, HealBot_Options_BuffTxt_List[BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(1)]])
            DoneInitTab[502]=true
        end
    elseif subNo==503 then
        if not DoneInitTab[503] then
            BuffTextClass = HealBot_Config_Buffs.HealBotBuffText
            if not BuffTextClass[HealBot_Options_getDropDownId_bySpec(2)] then BuffTextClass[HealBot_Options_getDropDownId_bySpec(2)]=HEALBOT_WORDS_NONE  end;
            HealBot_Options_BuffTxt2.numButtons = 0;
            HealBot_Options_BuffTxt2.initialize = HealBot_Options_BuffTxt2_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BuffTxt2, BuffTextClass[HealBot_Options_getDropDownId_bySpec(2)])
            DoneInitTab[503]=true
        end
    elseif subNo==504 then
        if not DoneInitTab[504] then
            local BuffDropDownClass = HealBot_Config_Buffs.HealBotBuffDropDown
            if not BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(2)] then BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(2)]=1 end;
            HealBot_Options_BuffGroups2.initialize = HealBot_Options_BuffGroups2_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BuffGroups2, HealBot_Options_BuffTxt_List[BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(2)]])
            DoneInitTab[504]=true
        end
    elseif subNo==505 then
        if not DoneInitTab[505] then
            BuffTextClass = HealBot_Config_Buffs.HealBotBuffText
            if not BuffTextClass[HealBot_Options_getDropDownId_bySpec(3)] then BuffTextClass[HealBot_Options_getDropDownId_bySpec(3)]=HEALBOT_WORDS_NONE  end;
            HealBot_Options_BuffTxt3.numButtons = 0;
            HealBot_Options_BuffTxt3.initialize = HealBot_Options_BuffTxt3_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BuffTxt3, BuffTextClass[HealBot_Options_getDropDownId_bySpec(3)])
            DoneInitTab[505]=true
        end
    elseif subNo==506 then
        if not DoneInitTab[506] then
            local BuffDropDownClass = HealBot_Config_Buffs.HealBotBuffDropDown
            if not BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(3)] then BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(3)]=1 end;
            HealBot_Options_BuffGroups3.initialize = HealBot_Options_BuffGroups3_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BuffGroups3, HealBot_Options_BuffTxt_List[BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(3)]])
            DoneInitTab[506]=true
        end
    elseif subNo==507 then
        if not DoneInitTab[507] then
            BuffTextClass = HealBot_Config_Buffs.HealBotBuffText
            if not BuffTextClass[HealBot_Options_getDropDownId_bySpec(4)] then BuffTextClass[HealBot_Options_getDropDownId_bySpec(4)]=HEALBOT_WORDS_NONE  end;
            HealBot_Options_BuffTxt4.numButtons = 0;
            HealBot_Options_BuffTxt4.initialize = HealBot_Options_BuffTxt4_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BuffTxt4, BuffTextClass[HealBot_Options_getDropDownId_bySpec(4)])
            DoneInitTab[507]=true
        end
    elseif subNo==508 then
        if not DoneInitTab[508] then
            local BuffDropDownClass = HealBot_Config_Buffs.HealBotBuffDropDown
            if not BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(4)] then BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(4)]=1 end;
            HealBot_Options_BuffGroups4.initialize = HealBot_Options_BuffGroups4_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BuffGroups4, HealBot_Options_BuffTxt_List[BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(4)]])
            DoneInitTab[508]=true
        end
    elseif subNo==509 then
        if not DoneInitTab[509] then
            BuffTextClass = HealBot_Config_Buffs.HealBotBuffText
            if not BuffTextClass[HealBot_Options_getDropDownId_bySpec(5)] then BuffTextClass[HealBot_Options_getDropDownId_bySpec(5)]=HEALBOT_WORDS_NONE  end;
            HealBot_Options_BuffTxt5.numButtons = 0;
            HealBot_Options_BuffTxt5.initialize = HealBot_Options_BuffTxt5_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BuffTxt5, BuffTextClass[HealBot_Options_getDropDownId_bySpec(5)])
            DoneInitTab[509]=true
        end
    elseif subNo==510 then
        if not DoneInitTab[510] then
            local BuffDropDownClass = HealBot_Config_Buffs.HealBotBuffDropDown
            if not BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(5)] then BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(5)]=1 end;
            HealBot_Options_BuffGroups5.initialize = HealBot_Options_BuffGroups5_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BuffGroups5, HealBot_Options_BuffTxt_List[BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(5)]])
            DoneInitTab[510]=true
        end
    elseif subNo==511 then
        if not DoneInitTab[511] then
            BuffTextClass = HealBot_Config_Buffs.HealBotBuffText
            if not BuffTextClass[HealBot_Options_getDropDownId_bySpec(6)] then BuffTextClass[HealBot_Options_getDropDownId_bySpec(6)]=HEALBOT_WORDS_NONE  end;
            HealBot_Options_BuffTxt6.numButtons = 0;
            HealBot_Options_BuffTxt6.initialize = HealBot_Options_BuffTxt6_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BuffTxt6, BuffTextClass[HealBot_Options_getDropDownId_bySpec(6)])
            DoneInitTab[511]=true
        end
    elseif subNo==512 then
        if not DoneInitTab[512] then
            local BuffDropDownClass = HealBot_Config_Buffs.HealBotBuffDropDown
            if not BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(6)] then BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(6)]=1 end;
            HealBot_Options_BuffGroups6.initialize = HealBot_Options_BuffGroups6_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BuffGroups6, HealBot_Options_BuffTxt_List[BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(6)]])
            DoneInitTab[512]=true
        end
    elseif subNo==513 then
        if not DoneInitTab[513] then
            BuffTextClass = HealBot_Config_Buffs.HealBotBuffText
            if not BuffTextClass[HealBot_Options_getDropDownId_bySpec(7)] then BuffTextClass[HealBot_Options_getDropDownId_bySpec(7)]=HEALBOT_WORDS_NONE  end;
            HealBot_Options_BuffTxt7.numButtons = 0;
            HealBot_Options_BuffTxt7.initialize = HealBot_Options_BuffTxt7_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BuffTxt7, BuffTextClass[HealBot_Options_getDropDownId_bySpec(7)])
            DoneInitTab[513]=true
        end
    elseif subNo==514 then
        if not DoneInitTab[514] then
            local BuffDropDownClass = HealBot_Config_Buffs.HealBotBuffDropDown
            if not BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(7)] then BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(7)]=1 end;
            HealBot_Options_BuffGroups7.initialize = HealBot_Options_BuffGroups7_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BuffGroups7, HealBot_Options_BuffTxt_List[BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(7)]])
            DoneInitTab[514]=true
        end
    elseif subNo==515 then
        if not DoneInitTab[515] then
            BuffTextClass = HealBot_Config_Buffs.HealBotBuffText
            if not BuffTextClass[HealBot_Options_getDropDownId_bySpec(8)] then BuffTextClass[HealBot_Options_getDropDownId_bySpec(8)]=HEALBOT_WORDS_NONE  end;
            HealBot_Options_BuffTxt8.numButtons = 0;
            HealBot_Options_BuffTxt8.initialize = HealBot_Options_BuffTxt8_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BuffTxt8, BuffTextClass[HealBot_Options_getDropDownId_bySpec(8)])
            DoneInitTab[515]=true
        end
    elseif subNo==516 then
        if not DoneInitTab[516] then
            local BuffDropDownClass = HealBot_Config_Buffs.HealBotBuffDropDown
            if not BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(8)] then BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(8)]=1 end;
            HealBot_Options_BuffGroups8.initialize = HealBot_Options_BuffGroups8_DropDown
            UIDropDownMenu_SetText(HealBot_Options_BuffGroups8, HealBot_Options_BuffTxt_List[BuffDropDownClass[HealBot_Options_getDropDownId_bySpec(8)]])
            DoneInitTab[516]=true
        end
    elseif subNo==517 then
        if not DoneInitTab[517] then
            HealBot_Options_MonitorBuffsInCombat:SetChecked(HealBot_Config_Buffs.BuffWatchInCombat)
            HealBot_Options_SetText(HealBot_Options_MonitorBuffsInCombat,HEALBOT_OPTIONS_MONITORBUFFSC)
            HealBot_Options_MonitorBuffsWhenGrouped:SetChecked(HealBot_Config_Buffs.BuffWatchWhenGrouped)
            HealBot_Options_SetText(HealBot_Options_MonitorBuffsWhenGrouped,HEALBOT_OPTIONS_IN_A_GROUP)
            HealBot_Options_valtime_OnLoad(HealBot_Options_LongBuffTimer,HEALBOT_OPTIONS_LONGBUFFTIMER,0,300,15)
            HealBot_Options_LongBuffTimer:SetValue(HealBot_Config_Buffs.LongBuffTimer)
            HealBot_Options_BuffTimer_OnValueChanged(HealBot_Options_LongBuffTimer,"LONG")
            HealBot_Options_valtime_OnLoad(HealBot_Options_ShortBuffTimer,HEALBOT_OPTIONS_SHORTBUFFTIMER,0,120,5)
            HealBot_Options_ShortBuffTimer:SetValue(HealBot_Config_Buffs.ShortBuffTimer)
            HealBot_Options_BuffTimer_OnValueChanged(HealBot_Options_ShortBuffTimer,"SHORT")
            HealBot_Options_MonitorBuffs:SetChecked(HealBot_Config_Buffs.BuffWatch)
            HealBot_Options_SetText(HealBot_Options_MonitorBuffs,HEALBOT_OPTIONS_MONITORBUFFS)
            g=_G["HealBot_Options_Panel5_1"]
            g:SetText(HEALBOT_OPTIONS_BUFFSTEXT1)
            g=_G["HealBot_Options_Panel5_2"]
            g:SetText(HEALBOT_OPTIONS_BUFFSTEXT2)
            g=_G["HealBot_Options_Panel5_3"]
            g:SetText(HEALBOT_OPTIONS_BUFFSTEXT3)
            g=_G["HealBot_Options_Panel5_4"]
            g:SetText(HEALBOT_OPTIONS_BUFFSTEXTTIMER)
            DoneInitTab[517]=true
        end
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
            HealBot_Options_ShowTooltipInstant:SetChecked(HealBot_Globals.Tooltip_Recommend)
            HealBot_Options_SetText(HealBot_Options_ShowTooltipInstant,HEALBOT_OPTIONS_SHOWRECTOOLTIP)
            HealBot_Options_ShowTooltipUseGameTip:SetChecked(HealBot_Globals.UseGameTooltip)
            HealBot_Options_SetText(HealBot_Options_ShowTooltipUseGameTip,HEALBOT_OPTIONS_USEGAMETOOLTIP)
            HealBot_Options_ShowTooltipShowHoT:SetChecked(HealBot_Globals.Tooltip_ShowHoT)
            HealBot_Options_SetText(HealBot_Options_ShowTooltipShowHoT,HEALBOT_OPTIONS_TOOLTIPSHOWHOT)
            HealBot_Options_Pct_OnLoad(HealBot_Options_TTAlpha,HEALBOT_OPTIONS_TTALPHA)
            HealBot_Options_TTAlpha:SetValue(HealBot_Globals.ttalpha)
            g=_G["HealBot_Options_Panel6_1"]
            g:SetText(HEALBOT_OPTIONS_TIPTEXT)
            DoneInitTab[601]=true
        end
    elseif subNo==701 then
        if not DoneInitTab[701] then
            if not HealBot_Globals.HealBot_MouseWheelIndex["NoneUp"] then HealBot_Globals.HealBot_MouseWheelIndex["NoneUp"]=1 end
            HealBot_Options_MouseWheelUp.initialize = HealBot_Options_MouseWheelUp_DropDown
            UIDropDownMenu_SetText(HealBot_Options_MouseWheelUp, HealBot_Options_MouseWheel_List[HealBot_Globals.HealBot_MouseWheelIndex["NoneUp"]])
            DoneInitTab[701]=true
        end
    elseif subNo==702 then
        if not DoneInitTab[702] then
            if not HealBot_Globals.HealBot_MouseWheelIndex["NoneDown"] then HealBot_Globals.HealBot_MouseWheelIndex["NoneDown"]=1 end
            HealBot_Options_MouseWheelDown.initialize = HealBot_Options_MouseWheelDown_DropDown
            UIDropDownMenu_SetText(HealBot_Options_MouseWheelDown, HealBot_Options_MouseWheel_List[HealBot_Globals.HealBot_MouseWheelIndex["NoneDown"]])
            DoneInitTab[702]=true
        end
    elseif subNo==703 then
        if not DoneInitTab[703] then
            if not HealBot_Globals.HealBot_MouseWheelIndex["ShiftUp"] then HealBot_Globals.HealBot_MouseWheelIndex["ShiftUp"]=1 end
            HealBot_Options_MouseWheelShiftUp.initialize = HealBot_Options_MouseWheelShiftUp_DropDown
            UIDropDownMenu_SetText(HealBot_Options_MouseWheelShiftUp, HealBot_Options_MouseWheel_List[HealBot_Globals.HealBot_MouseWheelIndex["ShiftUp"]])
            DoneInitTab[703]=true
        end
    elseif subNo==704 then
        if not DoneInitTab[704] then
            if not HealBot_Globals.HealBot_MouseWheelIndex["ShiftDown"] then HealBot_Globals.HealBot_MouseWheelIndex["ShiftDown"]=1 end
            HealBot_Options_MouseWheelShiftDown.initialize = HealBot_Options_MouseWheelShiftDown_DropDown
            UIDropDownMenu_SetText(HealBot_Options_MouseWheelShiftDown, HealBot_Options_MouseWheel_List[HealBot_Globals.HealBot_MouseWheelIndex["ShiftDown"]])
            DoneInitTab[704]=true
        end
    elseif subNo==705 then
        if not DoneInitTab[705] then
            if not HealBot_Globals.HealBot_MouseWheelIndex["CtrlUp"] then HealBot_Globals.HealBot_MouseWheelIndex["CtrlUp"]=1 end
            HealBot_Options_MouseWheelCtrlUp.initialize = HealBot_Options_MouseWheelCtrlUp_DropDown
            UIDropDownMenu_SetText(HealBot_Options_MouseWheelCtrlUp, HealBot_Options_MouseWheel_List[HealBot_Globals.HealBot_MouseWheelIndex["CtrlUp"]])
            DoneInitTab[705]=true
        end
    elseif subNo==706 then
        if not DoneInitTab[706] then
            if not HealBot_Globals.HealBot_MouseWheelIndex["CtrlDown"] then HealBot_Globals.HealBot_MouseWheelIndex["CtrlDown"]=1 end
            HealBot_Options_MouseWheelCtrlDown.initialize = HealBot_Options_MouseWheelCtrlDown_DropDown
            UIDropDownMenu_SetText(HealBot_Options_MouseWheelCtrlDown, HealBot_Options_MouseWheel_List[HealBot_Globals.HealBot_MouseWheelIndex["CtrlDown"]])
            DoneInitTab[706]=true
        end
    elseif subNo==707 then
        if not DoneInitTab[707] then
            if not HealBot_Globals.HealBot_MouseWheelIndex["AltUp"] then HealBot_Globals.HealBot_MouseWheelIndex["AltUp"]=1 end
            HealBot_Options_MouseWheelAltUp.initialize = HealBot_Options_MouseWheelAltUp_DropDown
            UIDropDownMenu_SetText(HealBot_Options_MouseWheelAltUp, HealBot_Options_MouseWheel_List[HealBot_Globals.HealBot_MouseWheelIndex["AltUp"]])
            DoneInitTab[707]=true
        end
    elseif subNo==708 then
        if not DoneInitTab[708] then
            if not HealBot_Globals.HealBot_MouseWheelIndex["AltDown"] then HealBot_Globals.HealBot_MouseWheelIndex["AltDown"]=1 end
            HealBot_Options_MouseWheelAltDown.initialize = HealBot_Options_MouseWheelAltDown_DropDown
            UIDropDownMenu_SetText(HealBot_Options_MouseWheelAltDown, HealBot_Options_MouseWheel_List[HealBot_Globals.HealBot_MouseWheelIndex["AltDown"]])
            DoneInitTab[708]=true
        end
    elseif subNo==709 then
        if not DoneInitTab[709] then
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
            DoneInitTab[709]=true
        end
    elseif subNo==801 then
        if not DoneInitTab[801] then
            HealBot_Options_SelectHealSpellsCombo.numButtons = 0;
            HealBot_Options_SelectHealSpellsCombo.initialize = HealBot_Options_SelectHealSpellsCombo_DropDown
            if HealBot_Options_StorePrev["ActionBarsCombo"]>2 then
                UIDropDownMenu_SetText(HealBot_Options_SelectHealSpellsCombo, HEALBOT_OPTIONS_HARMFUL_SPELLS)
            else
                UIDropDownMenu_SetText(HealBot_Options_SelectHealSpellsCombo, HEALBOT_OPTIONS_SMARTCASTHEAL)
            end
            DoneInitTab[801]=true
        end
    elseif subNo==802 then
        if not DoneInitTab[802] then
            HealBot_Options_SelectOtherSpellsCombo.numButtons = 0;
            HealBot_Options_SelectOtherSpellsCombo.initialize = HealBot_Options_SelectOtherSpellsCombo_DropDown
            UIDropDownMenu_SetText(HealBot_Options_SelectOtherSpellsCombo, HEALBOT_OPTIONS_OTHERSPELLS)
            DoneInitTab[802]=true
        end
    elseif subNo==803 then
        if not DoneInitTab[803] then
            HealBot_Options_SelectMacrosCombo.numButtons = 0;
            HealBot_Options_SelectMacrosCombo.initialize = HealBot_Options_SelectMacrosCombo_DropDown
            UIDropDownMenu_SetText(HealBot_Options_SelectMacrosCombo, HEALBOT_WORD_MACROS)
            DoneInitTab[803]=true
        end
    elseif subNo==804 then
        if not DoneInitTab[804] then
            HealBot_Options_SelectItemsCombo.numButtons = 0;
            HealBot_Options_SelectItemsCombo.initialize = HealBot_Options_SelectItemsCombo_DropDown
            UIDropDownMenu_SetText(HealBot_Options_SelectItemsCombo, HEALBOT_OPTIONS_ITEMS)
            DoneInitTab[804]=true
        end
    elseif subNo==805 then
        if not DoneInitTab[805] then
            HealBot_Options_SelectCmdsCombo.numButtons = 0;
            HealBot_Options_SelectCmdsCombo.initialize = HealBot_Options_SelectCmdsCombo_DropDown
            UIDropDownMenu_SetText(HealBot_Options_SelectCmdsCombo, HEALBOT_WORD_COMMANDS)
            DoneInitTab[805]=true
        end
    elseif subNo==806 then
        if not DoneInitTab[806] then
            HealBot_Options_FAQ.initialize = HealBot_Options_FAQ_DropDown
            UIDropDownMenu_SetText(HealBot_Options_FAQ, HEALBOT_ABOUT_FAQ_QUESTIONS[1])
            g=_G["HealBot_Options_FAQAnswerTextD"]
            g:SetTextColor(1,1,1,1);    
            g:SetText(HEALBOT_ABOUT_FAQ_ANSWERS[HealBot_Options_StorePrev["hbFAQ"]])
            DoneInitTab[806]=true
        end
    elseif subNo==807 then
        if not DoneInitTab[807] then
            g=_G["HealBot_About_Desc1"] 
            g:SetText(HEALBOT_ABOUT_DESC1)
            g=_G["HealBot_Info_SuppressSounds"] 
            g:SetText(HEALBOT_SUPPRESSSOUND)
            g=_G["HealBot_Info_SuppressErrors"] 
            g:SetText(HEALBOT_SUPPRESSERROR)
            g=_G["HealBot_Info_AcceptSkins"] 
            g:SetText(HEALBOT_ACCEPTSKINS)
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
            DoneInitTab[807]=true
        end
    end
end

function HealBot_Options_SetEFGroups()
    local g=nil
    for x=1,8 do
        if Healbot_Config_Skins.ExtraIncGroup[Healbot_Config_Skins.Current_Skin][x] then 
            g=_G["HealBot_Options_EFGroup"..x]
            g:SetChecked(1)
        else
            g=_G["HealBot_Options_EFGroup"..x]
            g:SetChecked(nil)
        end
    end
end

local HealBot_disabledState=-1
function HealBot_Options_SetSkins(force)
    if hbCurSkin~=Healbot_Config_Skins.Current_Skin or force then
        if hbCurSkin~=Healbot_Config_Skins.Current_Skin then 
            HealBot_Options_ResetDoInittab(3) 
            HealBot_Options_InitSub(106)
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
        if Healbot_Config_Skins.Aggro[Healbot_Config_Skins.Current_Skin]["SHOW"] then
            HealBot_Register_Aggro()
        else
            HealBot_UnRegister_Aggro()
        end
        HealBot_Options_RaidTargetUpdate()
        HealBot_Options_CheckReadyCheckEvent()
        HealBot_Options_CheckInHealsEvent()
        HealBot_Config.Current_Skin = Healbot_Config_Skins.Current_Skin
        HealBot_Config.Skin_ID = Healbot_Config_Skins.Skin_ID
        hbCurSkin=Healbot_Config_Skins.Current_Skin
    end
    if HealBot_Options:IsVisible() then
        if hbCurSkinSubFrameID==1001 then
            if not DoneInitTab[1001] then
                HealBot_Options_InitSub(340)
                HealBot_Options_InitSub(303)
                HealBot_Options_InitSub(310)
                DoneInitTab[1001]=true
            end
        elseif hbCurSkinSubFrameID==1002 then
            if not DoneInitTab[1002] then
                HealBot_Options_InitSub(337)
                HealBot_Options_InitSub(304)
                HealBot_Options_InitSub(312)
                HealBot_Options_InitSub(313)
                HealBot_Options_SetEFGroups()
                DoneInitTab[1002]=true
            end
        elseif hbCurSkinSubFrameID==1003 then
            if not DoneInitTab[1003] then
                HealBot_Options_InitSub(330)
                HealBot_Options_InitSub(331)         
                HealBot_Options_InitSub(320)
                HealBot_Options_InitSub(321)
                HealBot_Options_InitSub(306)
                DoneInitTab[1003]=true
            end
        elseif hbCurSkinSubFrameID==1004 then  -- Enemy
            if not DoneInitTab[1004] then
                HealBot_Options_InitSub(346)
                DoneInitTab[1004]=true
            end
        elseif hbCurSkinSubFrameID==1005 then
            if not DoneInitTab[1005] then
                HealBot_Options_InitSub(329)  
                DoneInitTab[1005]=true
            end
        elseif hbCurSkinSubFrameID==1006 then -- Share
            if not DoneInitTab[1006] then
                HealBot_Options_InitSub(345)
                DoneInitTab[1006]=true
            end
            HealBot_Options_InitSub(318)
        elseif hbCurSkinSubFrameID==1007 then
            if not DoneInitTab[1007] then
                HealBot_Options_InitSub(328)        
                DoneInitTab[1007]=true
            end
        elseif hbCurSkinSubFrameID==1008 then
            if not DoneInitTab[1008] then
                HealBot_Options_InitSub(343)
                HealBot_Options_InitSub(344)
                HealBot_Options_InitSub(301)
                HealBot_Options_InitSub(302)
                HealBot_Options_InitSub(317)
                DoneInitTab[1008]=true
            end
        elseif hbCurSkinSubFrameID==1009 then
            if not DoneInitTab[1009] then
                HealBot_Options_InitSub(339)
                HealBot_Options_InitSub(338)
                DoneInitTab[1009]=true
            end
        elseif hbCurSkinSubFrameID==1010 then
            if not DoneInitTab[1010] then
                HealBot_Options_InitSub(336)
                HealBot_Options_InitSub(305)
                DoneInitTab[1010]=true
            end
        elseif hbCurSkinSubFrameID==1011 then
            if not DoneInitTab[1011] then
                HealBot_Options_InitSub(334)
                DoneInitTab[1011]=true
            end
        elseif hbCurSkinSubFrameID==1012 then
            if not DoneInitTab[1012] then
                HealBot_Options_InitSub(335)
                HealBot_Options_InitSub(322)
                HealBot_Options_InitSub(323)
                HealBot_Options_InitSub(325)
                HealBot_Options_InitSub(342)
                DoneInitTab[1012]=true
            end
        elseif hbCurSkinSubFrameID==1013 then
            if not DoneInitTab[1013] then
                HealBot_Options_InitSub(327)
                HealBot_Options_InitSub(324)
                HealBot_Options_InitSub(307)
                HealBot_Options_InitSub(308)
                HealBot_Options_InitSub(309)
                HealBot_Options_InitSub(311)
                DoneInitTab[1013]=true
            end
        elseif hbCurSkinSubFrameID==1014 then
            if not DoneInitTab[1014] then
                HealBot_Options_InitSub(332)
                HealBot_Options_InitSub(333)
                HealBot_Options_InitSub(314)
                HealBot_Options_InitSub(315)
                HealBot_Options_InitSub(316)
                DoneInitTab[1014]=true  
            end
        elseif hbCurSkinSubFrameID==1015 then
            if not DoneInitTab[1015] then
                HealBot_Options_InitSub(326)
                DoneInitTab[1015]=true
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
    HealBot_BarOptTextColorpickt:SetFont(LSM:Fetch('font',Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["FONT"]),
                                     Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["HEIGHT"],
                                     HealBot_Font_Outline[btextoutline]);
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
    HealBot_BarOptTextColorpick:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]));
    HealBot_BarOptTextColorpickin:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]));
    HealBot_EnTextColorpick:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]));
    HealBot_EnTextColorpickin:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]));
    HealBot_DisTextColorpick:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]));
    HealBot_DebTextColorpick:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]));
    HealBot_HeadBarColorpick:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]));
    HealBot_HeadTextColorpick:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]));
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
    HealBot_BarOptTextColorpick:GetStatusBarTexture():SetHorizTile(false)
    HealBot_BarOptTextColorpickin:GetStatusBarTexture():SetHorizTile(false)
    HealBot_EnTextColorpick:GetStatusBarTexture():SetHorizTile(false)
    HealBot_EnTextColorpickin:GetStatusBarTexture():SetHorizTile(false)
    HealBot_DisTextColorpick:GetStatusBarTexture():SetHorizTile(false)
    HealBot_DebTextColorpick:GetStatusBarTexture():SetHorizTile(false)
    HealBot_HeadBarColorpick:GetStatusBarTexture():SetHorizTile(false)
    HealBot_HeadTextColorpick:GetStatusBarTexture():SetHorizTile(false)
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
    HealBot_BarOptTextColorpick:SetScale(barScale + 0.01);
    HealBot_BarOptTextColorpick:SetScale(barScale);
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
end

function HealBot_Options_ShowPanel(self, tabNo, subTabNo)
    local g=nil
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
    if tabNo==3 and not subTabNo and not HealBot_Options_StorePrev["subTabNo3"] then subTabNo=301 end
    if tabNo==4 and not subTabNo and not HealBot_Options_StorePrev["subTabNo4"] then subTabNo=41 end
    HealBot_Options_StorePrev["TabNo"] = tabNo;
    
    if subTabNo then 
        if tabNo==3 then
            HealBot_Options_StorePrev["subTabNo3"]=subTabNo
        else
            HealBot_Options_StorePrev["subTabNo4"]=subTabNo
        end
    end;
    if (HealBot_Options_StorePrev["PrevTabNo"] or -1)~=tabNo then
        HealBot_Options_Init(tabNo)
        g=_G["HealBot_Options_Panel"..tabNo]
        g:Show();
        g=_G["HealBot_Contents_ButtonT"..tabNo]
        g:SetStatusBarColor(0.2,0.2,0.2,0.55)
        g=_G["HealBot_Contents_ButtonT"..tabNo.."Txt"]
        g:SetTextColor(1,1,1,1)
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
        HealBot_Options_InitSub(106)
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

HealBot_Options_StorePrev["CurrentHealPanel"]="HealBot_Options_HealRaidFrame"
HealBot_Options_StorePrev["CurrentHealButton"]="HealBot_SkinsSubFrameSelectHealRaidFrameb"

function HealBot_Options_ShowHealPanel(frameName, buttonName)
    local g=_G[HealBot_Options_StorePrev["CurrentHealPanel"]]
    g:Hide()
    g=_G[frameName]
    g:Show()
    g=_G[HealBot_Options_StorePrev["CurrentHealButton"]]
    g:UnlockHighlight()
    g=_G[buttonName]
    g:LockHighlight()
    HealBot_Options_StorePrev["CurrentHealPanel"]=frameName
    HealBot_Options_StorePrev["CurrentHealButton"]=buttonName
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
        HealBot_Options_val_OnLoad(HealBot_Options_HeadFontNameS,HEALBOT_OPTIONS_SKINFONT,1,#fonts,1)
        HealBot_Options_val_OnLoad(HealBot_Options_AliasFontName,HEALBOT_OPTIONS_SKINFONT,1,#fonts,1)
        HealBot_Options_SetSliderValue(HealBot_Options_HeadTextureS,texturesIndex[Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]],true)
        HealBot_Options_SetSliderValue(HealBot_Options_HeadFontNameS,fontsIndex[Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["FONT"]],true)
        HealBot_Options_SetSliderValue(HealBot_Options_AliasFontName,fontsIndex[Healbot_Config_Skins.FrameAlias[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["FONT"]],true)
        HealBot_Options_val_OnLoad(HealBot_Options_BarTextureS,HEALBOT_OPTIONS_SKINTEXTURE,1,#hb_textures,1)
        HealBot_Options_val_OnLoad(HealBot_Options_FontName,HEALBOT_OPTIONS_SKINFONT,1,#fonts,1)
        HealBot_Options_SetSliderValue(HealBot_Options_BarTextureS,texturesIndex[Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["TEXTURE"]],true)
        HealBot_Options_SetSliderValue(HealBot_Options_FontName,fontsIndex[Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][HealBot_Options_StorePrev["FramesSelFrame"]]["FONT"]],true)
    elseif panel == 4 then
        sounds = LSM:List('sound');
        for x,_ in pairs(soundsIndex) do
            soundsIndex[x]=nil
        end 
        for i=1,#sounds do
            soundsIndex[sounds[i]] = i
        end
        HealBot_Options_val_OnLoad(HealBot_Options_WarningSound,HEALBOT_OPTIONS_SOUND,1,#sounds,1)
        HealBot_Options_SetSliderValue(HealBot_Options_WarningSound,soundsIndex[HealBot_Config_Cures.SoundDebuffPlay],true)
    end
end

function HealBot_UpdateUsedMedia(event, mediatype, key)
    if mediatype == "statusbar" then
        if Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin] then
            local hFrames=HealBot_Panel_retHealBot_Header_Frames()
            for _,h in pairs(hFrames) do
                local bar = HealBot_Action_HealthBar(h);
                if bar then
                    bar:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HeadBar[Healbot_Config_Skins.Current_Skin][h.frame]["TEXTURE"]));
                    bar:GetStatusBarTexture():SetHorizTile(false)
                    bar.txt = _G[bar:GetName().."_text"];
                    bar.txt:SetFont(LSM:Fetch('font',Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][h.frame]["FONT"]),
                                    Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][h.frame]["HEIGHT"],
                                    HealBot_Font_Outline[Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][h.frame]["OUTLINE"]]);
                else
                    HealBot_OnEvent_PartyMembersChanged()
                end
            end
        end
        if Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin] then 
            for _,xButton in pairs(HealBot_Unit_Button) do
                local bar = HealBot_Action_HealthBar(xButton);
                local bar2 = HealBot_Action_HealthBar2(xButton);
                local bar3 = HealBot_Action_HealthBar3(xButton);
                local bar6 = HealBot_Action_HealthBar3(xButton);
                if bar then
                    bar:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][xButton.frame]["TEXTURE"]));
                    bar2:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][xButton.frame]["TEXTURE"]));
                    bar3:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][xButton.frame]["TEXTURE"]));
                    bar6:SetStatusBarTexture(LSM:Fetch('statusbar',Healbot_Config_Skins.HealBar[Healbot_Config_Skins.Current_Skin][xButton.frame]["TEXTURE"]));
                    bar:GetStatusBarTexture():SetHorizTile(false)
                    bar2:GetStatusBarTexture():SetHorizTile(false)
                    bar3:GetStatusBarTexture():SetHorizTile(false)
                    bar6:GetStatusBarTexture():SetHorizTile(false)
                else
                    HealBot_OnEvent_PartyMembersChanged()
                end
            end            
        end
    elseif mediatype == "font" then
        if Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin] then
            local hFrames=HealBot_Panel_retHealBot_Header_Frames()
            for _,h in pairs(hFrames) do
                local bar = HealBot_Action_HealthBar(h);
                if bar then
                    bar.txt = _G[bar:GetName().."_text"];
                    bar.txt:SetFont(LSM:Fetch('font',Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][h.frame]["FONT"]),
                                    Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][h.frame]["HEIGHT"],
                                    HealBot_Font_Outline[Healbot_Config_Skins.HeadText[Healbot_Config_Skins.Current_Skin][h.frame]["OUTLINE"]]);
                else
                    HealBot_OnEvent_PartyMembersChanged()
                end
            end
        end
        if Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin] then
            for _,xButton in pairs(HealBot_Unit_Button) do
                local bar = HealBot_Action_HealthBar(xButton);
                if bar then
                    bar.txt = _G[bar:GetName().."_text"];
                    bar.txt:SetFont(LSM:Fetch('font',Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][xButton.frame]["FONT"]),
                                    Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][xButton.frame]["HEIGHT"],
                                    HealBot_Font_Outline[Healbot_Config_Skins.BarText[Healbot_Config_Skins.Current_Skin][xButton.frame]["OUTLINE"]]);
                else
                    HealBot_OnEvent_PartyMembersChanged()
                end
            end        
        end
    end
end

function HealBot_Comms_SendAddonMsg(addon_id, msg, aType, pName)
    local inInst=IsInInstance()
    if aType==1 and inInst then
        SendAddonMessage(addon_id, msg, "INSTANCE_CHAT" );
    elseif aType==2 then
        if inInst then
            SendAddonMessage(addon_id, msg, "INSTANCE_CHAT" );
        else
            SendAddonMessage(addon_id, msg, "RAID" );
        end
    elseif aType==3 then
        if inInst then
            SendAddonMessage(addon_id, msg, "INSTANCE_CHAT" );
        else
            SendAddonMessage(addon_id, msg, "PARTY" );
        end
    elseif aType==4 and pName and UnitIsPlayer(HealBot_Panel_RaidUnit(nil,pName)) then
        SendAddonMessage(addon_id, msg, "WHISPER", pName );
    elseif aType==5 then
        SendAddonMessage(addon_id, msg, "GUILD" );
    end
end

function HealBot_Comms_GetChan(chan)
    if GetChannelName(chan)>0 then
        return GetChannelName(chan);
    else
        return nil;
    end
end

