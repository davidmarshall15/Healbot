-- English maintained by Strife.

-------------
-- ENGLISH --
-------------
--
--
--
--
--
--
--
--
--

function HealBot_Lang_enUK()
    HEALBOT_enWORD_COLOUR_SUFFIX = "our"
    HealBot_Lang_enALL()
    HEALBOT_WORDS_CUSTOMNAME                = "Customise name"
    HealBot_Lang_Options_enALL()
end

function HealBot_Lang_enUS()
    HEALBOT_enWORD_COLOUR_SUFFIX = "or"
    HealBot_Lang_enALL()
    HEALBOT_WORDS_CUSTOMNAME                = "Customize name"
    HealBot_Lang_Options_enALL()
end

function HealBot_Lang_enALL()

    -----------------
    -- Translation --
    -----------------

    -- Class
    HEALBOT_DRUID                           = "Druid";
    HEALBOT_HUNTER                          = "Hunter";
    HEALBOT_MAGE                            = "Mage";
    HEALBOT_PALADIN                         = "Paladin";
    HEALBOT_PRIEST                          = "Priest";
    HEALBOT_ROGUE                           = "Rogue";
    HEALBOT_SHAMAN                          = "Shaman";
    HEALBOT_WARLOCK                         = "Warlock";
    HEALBOT_WARRIOR                         = "Warrior";
    HEALBOT_DEATHKNIGHT                     = "Death Knight";
    HEALBOT_DEMONHUNTER                     = "Demon Hunter";
    HEALBOT_MONK                            = "Monk";

    HEALBOT_DISEASE                         = "Disease";
    HEALBOT_MAGIC                           = "Magic";
    HEALBOT_CURSE                           = "Curse";
    HEALBOT_POISON                          = "Poison";

    HB_TOOLTIP_OFFLINE                      = "Offline";
    HB_OFFLINE                              = "offline"; -- has gone offline msg
    HB_ONLINE                               = "online"; -- has come online msg

    HEALBOT_HEALBOT                         = "HealBot";
    HEALBOT_ADDON                           = HEALBOT_HEALBOT .. " " .. HEALBOT_VERSION;
    HEALBOT_LOADED                          = " loaded.";

    HEALBOT_ACTION_OPTIONS                  = "Options";

    HEALBOT_OPTIONS_TITLE                   = HEALBOT_ADDON;
    HEALBOT_OPTIONS_DEFAULTS                = "Defaults";
    HEALBOT_OPTIONS_CLOSE                   = "Close";
    HEALBOT_OPTIONS_HARDRESET               = "ReloadUI"
    HEALBOT_OPTIONS_SOFTRESET               = "ResetHB"
    HEALBOT_OPTIONS_TAB_GENERAL             = "General";
    HEALBOT_OPTIONS_TAB_SPELLS              = "Spells";
    HEALBOT_OPTIONS_TAB_FRAMES              = "Frames";
    HEALBOT_OPTIONS_TAB_HEALING             = "Healing";
    HEALBOT_OPTIONS_TAB_SKIN                = "Skins";
    HEALBOT_OPTIONS_TAB_TIPS                = "Tips";
    HEALBOT_OPTIONS_TAB_DEBUFFS             = "Debuffs"
    HEALBOT_OPTIONS_TAB_CUSTOM_DEBUFFS      = "Custom Debuffs";
    HEALBOT_OPTIONS_TAB_CUSTOM_BUFFS        = "Custom Buffs";
    HEALBOT_OPTIONS_TAB_BUFFS               = "Buffs"

    HEALBOT_OPTIONS_BARALPHA                = "Enabled opacity";
    HEALBOT_OPTIONS_BARALPHAINHEAL          = "Incoming heals opacity";
    HEALBOT_OPTIONS_BARALPHABACK            = "Background bar opacity";
    HEALBOT_OPTIONS_BARALPHAEOR             = "Out of range opacity";
    HEALBOT_OPTIONS_ACTIONLOCKED            = "Lock position";
    HEALBOT_OPTIONS_AUTOSHOW                = "Close automatically";
    HEALBOT_OPTIONS_PANELSOUNDS             = "Play sound on open";
    HEALBOT_OPTIONS_HIDEOPTIONS             = "Hide options button";
    HEALBOT_OPTIONS_PROTECTPVP              = "Avoid PvP";
    HEALBOT_OPTIONS_HEAL_CHATOPT            = "Chat Options";

    HEALBOT_OPTIONS_FRAMESCALE              = "Frame scale"
    HEALBOT_OPTIONS_STICKFRAMEOFFSETH       = "Sticky frame horizontal offset"
    HEALBOT_OPTIONS_STICKFRAMEOFFSETV       = "Sticky frame vertical offset"
    HEALBOT_OPTIONS_SKINTEXT                = "Use skin"
    HEALBOT_SKINS_STD                       = "Standard"
    HEALBOT_OPTIONS_SKINTEXTURE             = "Texture"
    HEALBOT_OPTIONS_SKINHEIGHT              = "Height"
    HEALBOT_OPTIONS_SKINWIDTH               = "Width"
    HEALBOT_OPTIONS_SKINNUMCOLS             = "No. columns"
    HEALBOT_OPTIONS_SKINNUMHCOLS            = "No. groups per column"
    HEALBOT_OPTIONS_SKINBRSPACE             = "Row spacer"
    HEALBOT_OPTIONS_SKINBCSPACE             = "Column spacer"
    HEALBOT_SORTBY_NAME                     = "Name"
    HEALBOT_SORTBY_CLASS                    = "Class"
    HEALBOT_SORTBY_GROUP                    = "Group"
    HEALBOT_SORTBY_MAXHEALTH                = "Max health"
    HEALBOT_OPTIONS_NEWDEBUFFTEXT           = "New Bebuff"
    HEALBOT_OPTIONS_NEWHOTBUFFTEXT          = "New Buff/HoT"
    HEALBOT_OPTIONS_DELSKIN                 = "Delete"
    HEALBOT_OPTIONS_NEWSKINTEXT             = "New skin"
    HEALBOT_OPTIONS_SAVESKIN                = "Save"
    HEALBOT_OPTIONS_SKINBARS                = "Bar options"
    HEALBOT_SKIN_ENTEXT                     = "Enabled"
    HEALBOT_SKIN_DISTEXT                    = "Disabled"
    HEALBOT_SKIN_DEBTEXT                    = "Debuff"
    HEALBOT_SKIN_BACKTEXT                   = "Background"
    HEALBOT_SKIN_BORDERTEXT                 = "Border"
    HEALBOT_OPTIONS_SKINFONT                = "Font"
    HEALBOT_OPTIONS_SKINFHEIGHT             = "Font Size"
    HEALBOT_OPTIONS_SKINFOUTLINE            = "Font Outline"
    HEALBOT_OPTIONS_BARALPHADIS             = "Disabled opacity"
    HEALBOT_OPTIONS_SHOWHEADERS             = "Show headers"
    HEALBOT_OPTIONS_PRESETCOLOURBTN         = "*"
    HEALBOT_OPTIONS_PRESET                  = "Preset"

    HEALBOT_OPTIONS_ITEMS                   = "Items";

    HEALBOT_OPTIONS_COMBOCLASS              = "Key combos for";
    HEALBOT_OPTIONS_CLICK                   = "Click";
    HEALBOT_OPTIONS_SHIFT                   = "Shift";
    HEALBOT_OPTIONS_CTRL                    = "Ctrl";
    HEALBOT_OPTIONS_ENABLEHEALTHY           = "Always use enabled";
    HEALBOT_OPTIONS_FADEONEXPIRE            = "Fade on expire";
    HEALBOT_OPTIONS_FADESTARTTIME           = "Fade start time";

    HEALBOT_OPTIONS_CASTNOTIFY1             = "No messages";
    HEALBOT_OPTIONS_CASTNOTIFY2             = "Notify self";
    HEALBOT_OPTIONS_CASTNOTIFY3             = "Notify target";
    HEALBOT_OPTIONS_CASTNOTIFY4             = "Notify party";
    HEALBOT_OPTIONS_CASTNOTIFY5             = "Notify raid";
    HEALBOT_OPTIONS_CASTNOTIFY6             = "General channel";
    HEALBOT_OPTIONS_CASTNOTIFYRESONLY       = "Notify for resurrection only";
    HEALBOT_OPTIONS_EOC_OOM                 = "After combat warn when out of mana"
    HEALBOT_OPTIONS_EOC_OOM_VALUE           = "When mana below"

    HEALBOT_OPTIONS_CDCBARS                 = "Bar col"..HEALBOT_enWORD_COLOUR_SUFFIX.."s";
    HEALBOT_OPTIONS_CDCSHOWHBARS            = "Change health bar col"..HEALBOT_enWORD_COLOUR_SUFFIX;
    HEALBOT_OPTIONS_CDCSHOWABARS            = "Change aggro bar col"..HEALBOT_enWORD_COLOUR_SUFFIX;
    HEALBOT_OPTIONS_CDCWARNINGS             = "Debuff warnings";
    HEALBOT_OPTIONS_BUFFWARNINGS            = "Buff warnings";
    HEALBOT_OPTIONS_BUFFCUSTOM              = "Custom buffs";
    HEALBOT_OPTIONS_DEBUFFCUSTOM            = "Custom debuffs"
    HEALBOT_OPTIONS_BUFFMISSING             = "Missing buffs";
    HEALBOT_OPTIONS_DEBUFFDISPELL           = "Dispellable debuffs";
    HEALBOT_OPTIONS_SHOWDEBUFFICON          = "Show debuff";
    HEALBOT_OPTIONS_SHOWDEBUFFWARNING       = "Display warning on debuff";
    HEALBOT_OPTIONS_SOUNDDEBUFFWARNING      = "Play sound on debuff";
    HEALBOT_OPTIONS_SHOWBUFFWARNING       = "Display warning on buff";
    HEALBOT_OPTIONS_SOUNDBUFFWARNING      = "Play sound on buff";
    HEALBOT_OPTIONS_SOUND                   = "Sound"
    HEALBOT_OPTIONS_WARN_CLASSCOL           = "Unable to change text col"..HEALBOT_enWORD_COLOUR_SUFFIX.." when\nCol"..HEALBOT_enWORD_COLOUR_SUFFIX.." text by class is on"

    HEALBOT_OPTIONS_PLAYERVISIBILITY        = "Player and Pet Visibility";
    HEALBOT_OPTIONS_TARGETVISIBILITY        = "Target Visibility";
    HEALBOT_OPTIONS_FOCUSVISIBILITY         = "Focus Visibility";
    HEALBOT_OPTIONS_PLAYERSORT              = "Player Sort"
    HEALBOT_OPTIONS_VEHICLESORT             = "Vehicle Sort"
    HEALBOT_OPTIONS_PETSORT                 = "Pet Sort"
    HEALBOT_OPTIONS_ENEMYSORT               = "Enemy Sort"
    HEALBOT_OPTIONS_SELFHEALS               = "Self"
    HEALBOT_OPTIONS_PETHEALS                = "Pets"
    HEALBOT_WORD_PET                        = "Pet"
    HEALBOT_OPTIONS_GROUPHEALS              = "Group";
    HEALBOT_OPTIONS_TANKHEALS               = "Main tanks";
    HEALBOT_OPTIONS_SINGLETANK              = "Single tank";
    HEALBOT_OPTIONS_PRIVATETANKS            = "Private tanks";
    HEALBOT_OPTIONS_PRIVATEHEALERS          = "Private healers";
    HEALBOT_OPTIONS_TARGETHEALS             = "Target";
    HEALBOT_OPTIONS_EMERGENCYHEALS          = "Raid";
    HEALBOT_OPTIONS_RAID10                  = HEALBOT_OPTIONS_EMERGENCYHEALS.." 10";
    HEALBOT_OPTIONS_RAID25                  = HEALBOT_OPTIONS_EMERGENCYHEALS.." 25";
    HEALBOT_OPTIONS_RAID40                  = HEALBOT_OPTIONS_EMERGENCYHEALS.." 40";
    HEALBOT_OPTIONS_EMERGFILTER             = "Show bars for";
    HEALBOT_OPTIONS_EMERGFCLASS             = "Configure classes for";
    HEALBOT_OPTIONS_COMBOBUTTON             = "Button";
    HEALBOT_OPTIONS_BUTTONLEFT              = "Left";
    HEALBOT_OPTIONS_BUTTONMIDDLE            = "Middle";
    HEALBOT_OPTIONS_BUTTONRIGHT             = "Right";
    HEALBOT_OPTIONS_BUTTON4                 = "Button4";
    HEALBOT_OPTIONS_BUTTON5                 = "Button5";
    HEALBOT_OPTIONS_BUTTON6                 = "Button6";
    HEALBOT_OPTIONS_BUTTON7                 = "Button7";
    HEALBOT_OPTIONS_BUTTON8                 = "Button8";
    HEALBOT_OPTIONS_BUTTON9                 = "Button9";
    HEALBOT_OPTIONS_BUTTON10                = "Button10";
    HEALBOT_OPTIONS_BUTTON11                = "Button11";
    HEALBOT_OPTIONS_BUTTON12                = "Button12";
    HEALBOT_OPTIONS_BUTTON13                = "Button13";
    HEALBOT_OPTIONS_BUTTON14                = "Button14";
    HEALBOT_OPTIONS_BUTTON15                = "Button15";

    HEALBOT_CLASSES_ALL                     = "All classes";
    HEALBOT_CLASSES_MELEE                   = "Melee";
    HEALBOT_CLASSES_RANGES                  = "Ranged";
    HEALBOT_CLASSES_HEALERS                 = "Healers";
    HEALBOT_CLASSES_CUSTOM                  = "Custom";

    HEALBOT_OPTIONS_SHOWTOOLTIP             = "Show tooltips";
    HEALBOT_OPTIONS_SHOWDETTOOLTIP          = "Show detailed spell information";
    HEALBOT_OPTIONS_SHOWCDTOOLTIP           = "Show spell cooldown";
    HEALBOT_OPTIONS_SHOWMOUSEWHEELTOOLTIP   = "Show mouse wheel commands"
    HEALBOT_OPTIONS_SHOWUNITTOOLTIP         = "Show target information";
    HEALBOT_OPTIONS_SHOWRECTOOLTIP          = "Show heal over time recommendation";
    HEALBOT_TOOLTIP_POSDEFAULT              = "Default location";
    HEALBOT_TOOLTIP_POSLEFT                 = "Left of Healbot";
    HEALBOT_TOOLTIP_POSRIGHT                = "Right of Healbot";
    HEALBOT_TOOLTIP_POSABOVE                = "Above Healbot";
    HEALBOT_TOOLTIP_POSBELOW                = "Below Healbot";
    HEALBOT_TOOLTIP_POSCURSOR               = "Next to Cursor";
    HEALBOT_TOOLTIP_RECOMMENDTEXT           = "Heal over time Recommendation";
    HEALBOT_TOOLTIP_NONE                    = "none available";
    HEALBOT_TOOLTIP_CORPSE                  = "Corpse of ";
    HEALBOT_TOOLTIP_CD                      = " (CD ";
    HEALBOT_TOOLTIP_SECS                    = " sec)";
    HEALBOT_TOOLTIP_MINS                    = " min)";
    HEALBOT_WORDS_SMALL                     = "Small"
    HEALBOT_WORDS_MEDIUM                    = "Medium"
    HEALBOT_WORDS_LARGE                     = "Large"
    HEALBOT_WORDS_SEC                       = "sec";
    HEALBOT_WORDS_CAST                      = "Cast";
    HEALBOT_WORDS_UNKNOWN                   = "Unknown";
    HEALBOT_WORDS_YES                       = "Yes";
    HEALBOT_WORDS_NO                        = "No";
    HEALBOT_WORDS_THIN                      = "Thin";
    HEALBOT_WORDS_THICK                     = "Thick";

    HEALBOT_WORDS_NONE                      = "None";
    HEALBOT_OPTIONS_ALT                     = "Alt";
    HEALBOT_DISABLED_TARGET                 = "Target";
    HEALBOT_OPTIONS_SHOWCLASSONBAR          = "Show class on bar";
    HEALBOT_OPTIONS_SHOWHEALTHONBAR         = "Show health on bar";
    HEALBOT_OPTIONS_BARHEALTHINCHEALS       = "Include incoming heals";
    HEALBOT_OPTIONS_BARHEALTHSEPHEALS       = "Separate incoming heals";
    HEALBOT_OPTIONS_BARHEALTHALLINCHEALS    = "Always Include incoming heals";
    HEALBOT_OPTIONS_BARHEALTHALLSEPHEALS    = "Always Separate incoming heals";
    HEALBOT_OPTIONS_BARHEALTHINCALL         = "Include incoming heals and absorbs"
    HEALBOT_OPTIONS_BARHEALTHSEPALL         = "Separate incoming heals and absorbs"
    HEALBOT_OPTIONS_BARHEALTHALLINCALL      = "Always include incoming heals and absorbs"
    HEALBOT_OPTIONS_BARHEALTHALLSEPALL      = "Always separate incoming heals and absorbs"
    HEALBOT_OPTIONS_BARHEALTH1              = "as delta";
    HEALBOT_OPTIONS_BARHEALTH2              = "as percentage";
    HEALBOT_OPTIONS_TIPTEXT                 = "Tooltip information";
    HEALBOT_OPTIONS_POSTOOLTIP              = "Position tooltip";
    HEALBOT_OPTIONS_SHOWNAMEONBAR           = "Show name on bar";
    HEALBOT_OPTIONS_BARTEXTCLASSCOLOUR1     = "Col"..HEALBOT_enWORD_COLOUR_SUFFIX.." text by class";
    HEALBOT_OPTIONS_EMERGFILTERGROUPS       = "Include groups";
    HEALBOT_OPTIONS_PLAYERPET               = "Players and Pets"

    HEALBOT_ONE                             = "1";
    HEALBOT_TWO                             = "2";
    HEALBOT_THREE                           = "3";
    HEALBOT_FOUR                            = "4";
    HEALBOT_FIVE                            = "5";
    HEALBOT_SIX                             = "6";
    HEALBOT_SEVEN                           = "7";
    HEALBOT_EIGHT                           = "8";

    HEALBOT_OPTIONS_SETDEFAULTS             = "Set defaults";
    HEALBOT_OPTIONS_SETDEFAULTSMSG          = "Reset all options to default values";
    HEALBOT_OPTIONS_RIGHTBOPTIONS           = "Right click opens options";

    HEALBOT_OPTIONS_BARHEADEROPTTEXT        = "Bar Header options";
    HEALBOT_OPTIONS_FRAMEHEADEROPTTEXT      = "Frame Header options";
    HEALBOT_OPTIONS_ICONOPTTEXT             = "Icon options";
    HEALBOT_SKIN_HEADERBARCOL               = "Bar col"..HEALBOT_enWORD_COLOUR_SUFFIX;
    HEALBOT_SKIN_HEADERTEXTCOL              = "Text col"..HEALBOT_enWORD_COLOUR_SUFFIX;
    HEALBOT_OPTIONS_BUFFSTEXT1              = "Spell to buff";
    HEALBOT_OPTIONS_BUFFSTEXT2              = "check members";
    HEALBOT_OPTIONS_BUFFSTEXT3              = "bar col"..HEALBOT_enWORD_COLOUR_SUFFIX.."s";
    HEALBOT_OPTIONS_BUFF                    = "Buff ";
    HEALBOT_OPTIONS_BUFFSELF                = "on self";
    HEALBOT_OPTIONS_BUFFPARTY               = "on party";
    HEALBOT_OPTIONS_BUFFRAID                = "on raid";
    HEALBOT_OPTIONS_MONITORBUFFS            = "Monitor for buffs";
    HEALBOT_OPTIONS_MONITORBUFFSC           = "also in combat";
    HEALBOT_OPTIONS_ENABLESMARTCAST         = "SmartCast out of combat";
    HEALBOT_OPTIONS_SMARTCASTSPELLS         = "Include spells";
    HEALBOT_OPTIONS_SMARTCASTDISPELL        = "Remove debuffs";
    HEALBOT_OPTIONS_SMARTCASTBUFF           = "Add buffs";
    HEALBOT_OPTIONS_SMARTCASTHEAL           = "Healing spells";
    HEALBOT_OPTIONS_BAR2SIZE                = "Power bar size";
    HEALBOT_OPTIONS_SETSPELLS               = "Set spells for";
    HEALBOT_OPTIONS_ENABLEDBARS             = "Enabled bars at all times";
    HEALBOT_OPTIONS_DISABLEDBARS            = "Disabled bars when out of combat";
    HEALBOT_OPTIONS_MONITORDEBUFFS          = "Monitor for debuffs";
    HEALBOT_OPTIONS_DEBUFFTEXT1             = "Spell to remove debuffs";

    HEALBOT_OPTIONS_IGNOREDEBUFF            = "Ignore debuffs:";
    HEALBOT_OPTIONS_IGNOREDEBUFFCLASS       = "By class";
    HEALBOT_OPTIONS_IGNOREDEBUFFMOVEMENT    = "Slow movement";
    HEALBOT_OPTIONS_IGNOREDEBUFFDURATION    = "Short duration";
    HEALBOT_OPTIONS_IGNOREDEBUFFNOHARM      = "Non harmful";
    HEALBOT_OPTIONS_IGNOREDEBUFFCOOLDOWN    = "When cure spell CoolDown > 1.5 secs (GCD)";
    HEALBOT_OPTIONS_IGNOREDEBUFFFRIEND      = "When caster is known as friend";


    HEALBOT_OPTIONS_MAXBARCACHE             = "Maximum bars to pre cache";
    HEALBOT_OPTIONS_RANGECHECKFREQ          = "Internal Timers and Updates";

    HEALBOT_OPTIONS_HIDEPARTYFRAMES         = "Hide party frames";
    HEALBOT_OPTIONS_HIDEPLAYERTARGET        = "Include player and target";
    HEALBOT_OPTIONS_DISABLEHEALBOT          = "Disable HealBot";
    
    HEALBOT_OPTIONS_STICKYFRAMES            = "Sticky Frames"
    HEALBOT_OPTIONS_STICKYSENSITIVITY       = "Sticky Sensitivity"
    HEALBOT_WORD_LOW                        = "Low"
    HEALBOT_WORK_HIGH                       = "High"

    HEALBOT_ASSIST                          = "Assist";
    HEALBOT_FOCUS                           = "Focus";
    HEALBOT_MENU                            = "Menu";
    HEALBOT_MAINTANK                        = "MainTank";
    HEALBOT_STOP                            = "Stop";
    HEALBOT_TELL                            = "Tell";

    HEALBOT_OPTIONS_SHOWMINIMAPBUTTON       = "Show minimap button";
    HEALBOT_OPTIONS_BARBUTTONSHOWHOT        = "Show HoT";
    HEALBOT_OPTIONS_BARBUTTONSHOWRAIDICON   = "Show Raid Target";
    HEALBOT_OPTIONS_HOTONBAR                = "On bar";
    HEALBOT_OPTIONS_HOTOFFBAR               = "Off bar";
    HEALBOT_OPTIONS_HOTBARRIGHT             = "Right side";
    HEALBOT_OPTIONS_HOTBARLEFT              = "Left side";

    if HEALBOT_GAME_VERSION>7 then
        HEALBOT_ZONE_AB                     = C_Map.GetMapInfo(93).name or "Arathi Basin";
        HEALBOT_ZONE_AV                     = C_Map.GetMapInfo(91).name or "Alterac Valley";
        HEALBOT_ZONE_ES                     = C_Map.GetMapInfo(121).name or "Eye of the Storm";
        HEALBOT_ZONE_IC                     = C_Map.GetMapInfo(169).name or "Isle of Conquest";
        HEALBOT_ZONE_SA                     = C_Map.GetMapInfo(128).name or "Strand of the Ancients";
    else
        HEALBOT_ZONE_AB                     = "Arathi Basin";
        HEALBOT_ZONE_AV                     = "Alterac Valley";
        HEALBOT_ZONE_ES                     = "Eye of the Storm";
        HEALBOT_ZONE_IC                     = "Isle of Conquest";
        HEALBOT_ZONE_SA                     = "Strand of the Ancients";
    end

    HEALBOT_OPTION_AGGROTRACK               = "Monitor Aggro"
    HEALBOT_OPTION_AGGROBAR                 = "Bar"
    HEALBOT_OPTION_AGGROTXT                 = ">> Text <<"
    HEALBOT_OPTION_AGGROIND                 = "Indicator"
    HEALBOT_OPTION_BARUPDFREQ               = "Refresh Speed"
    HEALBOT_OPTION_USEFLUIDBARS             = "Use fluid bars"
    HEALBOT_OPTIONS_RELOADUIMSG             = "This option requires a UI Reload, Reload now?"

    HEALBOT_BUFF_PVP                        = "PvP"
    HEALBOT_BUFF_PVE						= "PvE"
    HEALBOT_OPTIONS_ANCHOR                  = "Frame anchor"
    HEALBOT_OPTIONS_BARSANCHOR              = "Bars anchor"
    HEALBOT_OPTIONS_TOPLEFT                 = "Top Left"
    HEALBOT_OPTIONS_BOTTOMLEFT              = "Bottom Left"
    HEALBOT_OPTIONS_TOPRIGHT                = "Top Right"
    HEALBOT_OPTIONS_BOTTOMRIGHT             = "Bottom Right"
    HEALBOT_OPTIONS_TOP                     = "Top"
    HEALBOT_OPTIONS_BOTTOM                  = "Bottom"

    HEALBOT_PANEL_BLACKLIST                 = "BlackList"

    HEALBOT_WORDS_REMOVEFROM                = "Remove from";
    HEALBOT_WORDS_ADDTO                     = "Add to";
    HEALBOT_WORDS_INCLUDE                   = "Include";
    HEALBOT_WORDS_UNSET                     = "Unset";
    HEALBOT_WORDS_SETAS                     = "Set as";

    HEALBOT_OPTIONS_TTALPHA                 = "Opacity"
    HEALBOT_TOOLTIP_TARGETBAR               = "Target Bar"
    HEALBOT_OPTIONS_MYTARGET                = "My Targets"
    HEALBOT_OPTIONS_MYFRIEND                = "My Friend"

    HEALBOT_DISCONNECTED_LABEL              = "Disconnected"
    HEALBOT_DISCONNECTED_TAG                = "[ DC ] "
    HEALBOT_DEAD_LABEL                      = "Dead"
    HEALBOT_DEAD_TAG                        = "[ RIP ] "
    HEALBOT_OUTOFRANGE_LABEL                = "Out Of Range"
    HEALBOT_OUTOFRANGE_TAG                  = "[ OOR ] "
    HEALBOT_RESERVED_LABEL                  = "Reserved"
    HEALBOT_RESERVED_TAG                    = "[ R ] "
    HEALBOT_TAGS                            = "Tags"
    
    HEALBOT_OPTIONS_SHOWUNITBUFFTIME        = "Show my buffs";
    HEALBOT_OPTIONS_TOOLTIPUPDATE           = "Constantly update";
    HEALBOT_OPTIONS_BUFFSTEXTTIMER          = "Show buff before it expires";
    HEALBOT_OPTIONS_SHORTBUFFTIMER          = "Short buffs"
    HEALBOT_OPTIONS_LONGBUFFTIMER           = "Long buffs"

    HEALBOT_OPTIONS_NOTIFY_MSG              = "Message"
    HEALBOT_OPTIONS_CASTNOTIFYTAGS          = " #s=spell name  -  #n=players name "
    HEALBOT_WORDS_YOU                       = "you";
    HEALBOT_WORDS_MORECPU                   = "More CPU";
    HEALBOT_WORDS_LESSCPU                   = "Less CPU";
    HEALBOT_NOTIFYOTHERMSG                  = "Casting #s on #n";

    HEALBOT_OPTIONS_HOTPOSITION             = "Icon position"
    HEALBOT_OPTIONS_HOTSHOWTEXT             = "Show icon text"
    HEALBOT_OPTIONS_HOTTEXTCOUNT            = "Count"
    HEALBOT_OPTIONS_HOTTEXTDURATION         = "Duration"
    HEALBOT_OPTIONS_ICONSCALE               = "Buff Icon Scale"
    HEALBOT_OPTIONS_DEBUFFICONSCALE         = "Debuff Icon Scale"
    HEALBOT_OPTIONS_MAXICONS                = "Max Icons"
    

    HEALBOT_OPTIONS_AGGROBARSIZE            = "Aggro bar size"
    HEALBOT_OPTIONS_DOUBLETEXTLINES         = "Double text lines"
    HEALBOT_OPTIONS_TEXTALIGNMENT           = "Horizontal Alignment"
    HEALBOT_OPTIONS_TEXTOFFSET              = "Vertical Offset"
    HEALBOT_OPTIONS_MAXCHARS                = "Max Characters"
    HEALBOT_VEHICLE                         = "Vehicle"
    HEALBOT_WORDS_ERROR                     = "Error"
    HEALBOT_SPELL_NOT_FOUND	                = "Spell Not Found"
    HEALBOT_OPTIONS_DISABLETOOLTIPINCOMBAT  = "Hide Tooltip in Combat"
    HEALBOT_OPTIONS_ENABLELIBQH             = "Enable HealBot fastHealth"

    HEALBOT_OPTIONS_BUFFNAMED               = "Enter the player names to watch for\n\n"
    HEALBOT_WORD_ALWAYS                     = "Always";
    HEALBOT_WORD_SOLO                       = "Solo";
    HEALBOT_WORD_NEVER                      = "Never";
    HEALBOT_SHOW_CLASS_AS_ICON              = "as icon";
    HEALBOT_SHOW_CLASS_AS_TEXT              = "as text";
    HEALBOT_SHOW_ROLE                       = "show role when set";

    HEALBOT_SHOW_INCHEALS                   = "Show incoming heals";

    HEALBOT_HELP={ [1] = "[HealBot] /hb h -- Display help",
                   [2] = "[HealBot] /hb o -- Toggles options",
                   [3] = "[HealBot] /hb t -- Toggle Healbot between disabled and enabled",
                   [4] = "[HealBot] /hb bt -- Toggle Buff Monitor between disabled and enabled",
                   [5] = "[HealBot] /hb dt -- Toggle Debuff Monitor between disabled and enabled",
                   [6] = "[HealBot] /hb skin <skinName> -- Switch Skins",
                   [7] = "[HealBot] /hb d -- Reset options to default",
                   [8] = "[HealBot] /hb spt -- Self Pet toggle",
                   [9] = "[HealBot] /hb flb -- Toggle frame lock bypass (frame always moves with Ctrl+Alt+Left click)",
                   [10] = "[HealBot] /hb hs -- Display additional slash commands",
                   [11] = "[HealBot] - All commands are listed on the HealBot website "..HEALBOT_ABOUT_URL,
                  }

    HEALBOT_HELP2={ [1] = "[HealBot] /hb rtb -- Toggle restrict target bar to Left=SmartCast and Right=add/remove to/from My Targets",
                    [2] = "[HealBot] /hb aggro 2 <n> -- Set aggro level 2 on threat percentage <n>",
                    [3] = "[HealBot] /hb aggro 3 <n> -- Set aggro level 3 on threat percentage <n>",
                    [4] = "[HealBot] /hb tr <Role> -- Set highest role priority for SubSort by Role. Valid Roles are 'TANK', 'HEALER' or 'DPS'",
                    [5] = "[HealBot] /hb use10 -- Automatically use Engineering slot 10",
                    [6] = "[HealBot] /hb pcs <n> -- Adjust the size of the Holy power charge indicator by <n>, Default value is 7 ",
                    [7] = "[HealBot] /hb hrfm -- Toggle method for hiding Blizzard raid frames, disable completly or just hide",
                    [8] = "[HealBot] /hb ws -- Toggle Hide/Show the Weaken Soul icon instead of the PW:S with a -",
                    [9] = "[HealBot] /hb rld <n> -- In seconds, how long the players name stays green after a res",
                    [10] = "[HealBot] /hb shhp <n> -- Show HYMN OF HOPE Buff only when mana is below <n>",
                    [11] = "[HealBot] - Also see Commands on the General tab in Options",
                  }
                  
    HEALBOT_OPTION_HIGHLIGHTACTIVEBAR       = "Highlight mouseover"
    HEALBOT_OPTION_HIGHLIGHTTARGETBAR       = "Highlight target"
    HEALBOT_OPTIONS_TESTBARS                = "Test Bars"
    HEALBOT_OPTION_NUMBARS                  = "Number of Bars"
    HEALBOT_OPTION_NUMTANKS                 = "Number of Tanks"
    HEALBOT_OPTION_NUMMYTARGETS             = "Number of MyTargets"
    HEALBOT_OPTION_NUMHEALERS               = "Number of Healers"
    HEALBOT_OPTION_NUMPETS                  = "Number of Pets"
    HEALBOT_WORD_TEST                       = "Test";
    HEALBOT_WORD_TEXT                       = "Text";
    HEALBOT_WORD_OFF                        = "Off";
    HEALBOT_WORD_ON                         = "On";

    HEALBOT_OPTIONS_TAB_PROTECTION          = "Protection"
    HEALBOT_OPTIONS_TAB_CHAT                = "Chat"
    HEALBOT_OPTIONS_TAB_HEADERS             = "Headers"
    HEALBOT_OPTIONS_TAB_BARS                = "Bars"
    HEALBOT_OPTIONS_TAB_ICONS               = "Icons"
    HEALBOT_OPTIONS_TAB_WARNING             = "Warning"
    HEALBOT_OPTIONS_SKINDEFAULTFOR          = "Skin default for"
    HEALBOT_OPTIONS_INCHEAL                 = "Incoming heals"
    HEALBOT_WORD_ARENA                      = "Arena"
    HEALBOT_WORD_BATTLEGROUND               = "Battle Ground"
    HEALBOT_WORD_BG10                       = "BG 10"; 
    HEALBOT_WORD_BG15                       = "BG 15";
    HEALBOT_WORD_BG40                       = "BG 40";     
    HEALBOT_OPTIONS_TEXTOPTIONS             = "Bar Text"
    HEALBOT_WORD_PARTY                      = "Party"
    HEALBOT_WORD_COLOUR                     = "Col"..HEALBOT_enWORD_COLOUR_SUFFIX.."s";
    HEALBOT_OPTIONS_COMBOAUTOTARGET         = "Auto\nTarget"
    HEALBOT_OPTIONS_COMBOAUTOTRINKET        = "Auto Trinket"
    HEALBOT_OPTIONS_GROUPSPERCOLUMN         = "Use Groups per Column"

    HEALBOT_OPTIONS_MAINSORT                = "Main sort"
    HEALBOT_OPTIONS_SUBSORT                 = "Sub sort"
    HEALBOT_OPTIONS_SUBSORTINC              = "Also sub sort:"

    HEALBOT_OPTIONS_BUTTONCASTMETHOD        = "cast when"
    HEALBOT_OPTIONS_BUTTONCASTPRESSED       = "Pressed"
    HEALBOT_OPTIONS_BUTTONCASTRELEASED      = "Released"

    HEALBOT_WORD_HEALER                     = "Healer"
    HEALBOT_WORD_DAMAGER                    = "Damager"
    HEALBOT_WORD_TANK                       = "Tank"
    HEALBOT_WORD_LEADER                     = "Leader"
    HEALBOT_WORD_VERSION                    = "Version"
    HEALBOT_WORD_CLIENT                     = "Client"

    HEALBOT_WORD_STAR                       = "Star"
    HEALBOT_WORD_CIRCLE                     = "Circle"
    HEALBOT_WORD_DIAMOND                    = "Diamond"
    HEALBOT_WORD_TRIANGLE                   = "Triangle"
    HEALBOT_WORD_MOON                       = "Moon"
    HEALBOT_WORD_SQUARE                     = "Square"
    HEALBOT_WORD_CROSS                      = "Cross"
    HEALBOT_WORD_SKULL                      = "Skull"

    HEALBOT_OPTIONS_ACCEPTSKINMSG           = "Accept [HealBot] Skin: "
    HEALBOT_OPTIONS_ACCEPTSKINMSGFROM       = " from "
    HEALBOT_OPTIONS_EXPORTSKIN              = "Select Skin"
    HEALBOT_OPTIONS_BUTTONEXPORT            = "Export"
    HEALBOT_OPTIONS_BUTTONIMPORT            = "Import"
    HEALBOT_OPTIONS_BUTTONIMPORTMETHOD      = "Import Method"
    HEALBOT_IMPORT_OVERWRITEALL             = "Overwrite All (Delete existing then insert all)"
    HEALBOT_IMPORT_MERGEALL                 = "Merge All (Update existing and insert new)"
    HEALBOT_IMPORT_MERGENEW                 = "Merge New (Only insert new)"

    HEALBOT_CHAT_ADDONID                    = "[HealBot]  "
    HEALBOT_CHAT_NEWVERSION1                = "A newer version is available"
    HEALBOT_CHAT_NEWVERSION2                = "at "..HEALBOT_ABOUT_URL
    HEALBOT_CHAT_SHARESKINERR1              = " Skin not found for Sharing"
    HEALBOT_CHAT_SHARESKINERR3              = " not found for Skin Sharing"
    HEALBOT_CHAT_SHARESKINACPT              = "Share Skin accepted from "
    HEALBOT_CHAT_CONFIRMSKINDEFAULTS        = "Skins set to Defaults"
    HEALBOT_CHAT_CONFIRMCUSTOMDEFAULTS      = "Custom Debuffs reset"
    HEALBOT_CHAT_CHANGESKINERR1             = "Unknown skin: /hb skin "
    HEALBOT_CHAT_CHANGESKINERR2             = "Valid skins:  "
    HEALBOT_CHAT_CONFIRMSPELLCOPY           = "Current spells copied for all specs"
    HEALBOT_CHAT_UNKNOWNCMD                 = "Unknown slash command: /hb "
    HEALBOT_CHAT_ENABLED                    = "Entering enabled state"
    HEALBOT_CHAT_DISABLED                   = "Entering disabled state"
    HEALBOT_CHAT_SOFTRELOAD                 = "Reload healbot requested"
    HEALBOT_CHAT_HARDRELOAD                 = "Reload UI requested"
    HEALBOT_CHAT_CONFIRMSPELLRESET          = "Spells have been reset"
    HEALBOT_CHAT_CONFIRMCURESRESET          = "Cures have been reset"
    HEALBOT_CHAT_CONFIRMBUFFSRESET          = "Buffs have been reset"
    HEALBOT_CHAT_CONFIRMICONRESET           = "Icons have been reset"
    HEALBOT_CHAT_POSSIBLEMISSINGMEDIA       = "Unable to receive all Skin settings - Possibly missing SharedMedia, download from curse.com"
    HEALBOT_CHAT_MACROSOUNDON               = "Sound not suppressed when using auto trinkets"
    HEALBOT_CHAT_MACROSOUNDOFF              = "Sound suppressed when using auto trinkets"
    HEALBOT_CHAT_MACROERRORON               = "Errors not suppressed when using auto trinkets"
    HEALBOT_CHAT_MACROERROROFF              = "Errors suppressed when using auto trinkets"
    HEALBOT_CHAT_ACCEPTSKINON               = "Share Skin - Show accept skin popup when someone shares a skin with you"
    HEALBOT_CHAT_ACCEPTSKINOFF              = "Share Skin - Always ignore share skins from everyone"
    HEALBOT_CHAT_USE10ON                    = "Auto Trinket - Use10 is on - You must enable an existing auto trinket for use10 to work"
    HEALBOT_CHAT_USE10OFF                   = "Auto Trinket - Use10 is off"
    HEALBOT_CHAT_SKINREC                    = " skin received from " 

    HEALBOT_OPTIONS_SELFCASTS               = "Self casts only"
    HEALBOT_OPTIONS_HOTSHOWICON             = "Show icon"
    HEALBOT_OPTIONS_ALLSPELLS               = "Buffs / HoTs"
    HEALBOT_OPTIONS_DOUBLEROW               = "Double row"
    HEALBOT_OPTIONS_HOTBELOWBAR             = "Below bar"
    HEALBOT_OPTIONS_OTHERSPELLS             = "Other spells"
    HEALBOT_WORD_MACROS                     = "Macros"
    HEALBOT_WORD_SELECT                     = "Select"
    HEALBOT_OPTIONS_QUESTION                = "?"
    HEALBOT_WORD_CANCEL                     = "Cancel"
    HEALBOT_WORD_COMMANDS                   = "Commands"
    HEALBOT_OPTIONS_BARHEALTH3              = "as health";
    HEALBOT_SORTBY_ROLE                     = "Role"
    HEALBOT_WORD_DPS                        = "DPS"
    HEALBOT_CHAT_TOPROLEERR                 = " role not valid in this context - use 'TANK', 'DPS' or 'HEALER'"
    HEALBOT_CHAT_NEWTOPROLE                 = "Highest top role is now "
    HEALBOT_CHAT_SUBSORTPLAYER1             = "Player will be set to first in SubSort"
    HEALBOT_CHAT_SUBSORTPLAYER2             = "Player will be sorted normally in SubSort"
    HEALBOT_OPTIONS_SHOWREADYCHECK          = "Show Ready Check";
    HEALBOT_OPTIONS_SUBSORTSELFFIRST        = "Sub Sort - Self First"
    HEALBOT_OPTION_AGGROPCTBAR              = "Move bar"
    HEALBOT_OPTION_AGGROPCTTXT              = "Show text"
    HEALBOT_OPTION_AGGROPCTTRACK            = "Track percentage" 
    HEALBOT_OPTIONS_ALERTAGGROLEVEL1        = "1 - Low threat"
    HEALBOT_OPTIONS_ALERTAGGROLEVEL2        = "2 - High threat"
    HEALBOT_OPTIONS_ALERTAGGROLEVEL3        = "3 - Tanking"
    HEALBOT_OPTIONS_AGGROALERT              = "Bar alert level"
    HEALBOT_OPTIONS_AGGROINDALERT           = "Indicator alert level"
    HEALBOT_OPTIONS_TOOLTIPSHOWHOT          = "Show active monitored HoT details"
    HEALBOT_WORDS_MIN                       = "min"
    HEALBOT_WORDS_MAX                       = "max"
    HEALBOT_CHAT_SELFPETSON                 = "Self Pet switched on"
    HEALBOT_CHAT_SELFPETSOFF                = "Self Pet switched off"
    HEALBOT_WORD_PRIORITY                   = "Priority"
    HEALBOT_VISIBLE_RANGE                   = "Within 100 yards"
    HEALBOT_SPELL_RANGE                     = "Within spell range"
    HEALBOT_WORD_RESET                      = "Reset"
    HEALBOT_WOWMENU                         = "Blizzard Menu";
    HEALBOT_HBMENU                          = "HealBot Menu"
    HEALBOT_ACTION_HBFOCUS                  = "Left click to set\nfocus on target"
    HEALBOT_WORD_CLEAR                      = "Clear"
    HEALBOT_WORD_SET                        = "Set"
    HEALBOT_WORD_HBFOCUS                    = "HealBot Focus"
    HEALBOT_WORD_OUTSIDE                    = "Outside"
    HEALBOT_WORD_ALLZONE                    = "All zones"
    HEALBOT_OPTIONS_TAB_ALERT               = "Alert"
    HEALBOT_OPTIONS_TAB_SORT                = "Sort"
    HEALBOT_OPTIONS_TAB_HIDE                = "Hide"
    HEALBOT_OPTIONS_TAB_VISIBILITY          = "Visibility"
    HEALBOT_OPTIONS_TAB_AGGRO               = "Aggro"
    HEALBOT_OPTIONS_TAB_ICONTEXT            = "Icon text"
    HEALBOT_OPTIONS_TAB_TEXT                = "Bar text"
    HEALBOT_OPTIONS_AGGRO3COL               = "Aggro bar\ncol"..HEALBOT_enWORD_COLOUR_SUFFIX
    HEALBOT_OPTIONS_AGGROFLASHFREQ          = "Flash frequency"
    HEALBOT_OPTIONS_WORD_FASTER             = "Faster"
    HEALBOT_OPTIONS_WORD_SLOWER             = "Slower"
    HEALBOT_OPTIONS_AGGROFLASHALPHA         = "Flash opacity"
    HEALBOT_OPTIONS_SHOWDURATIONFROM        = "Show duration from"
    HEALBOT_OPTIONS_SHOWDURATIONWARN        = "Duration warning from"
    HEALBOT_CMD_RESETCUSTOMDEBUFFS          = "Reset custom debuffs"
    HEALBOT_CMD_RESETSKINS                  = "Reset skins"
    HEALBOT_CMD_CLEARBLACKLIST              = "Clear BlackList"
    HEALBOT_CMD_TOGGLEDISLIKEMOUNT          = "Toggle Dislike Mount"
    HEALBOT_OPTION_DISLIKEMOUNT_ON          = "Now Dislike Mount"
    HEALBOT_OPTION_DISLIKEMOUNT_OFF         = "No longer Dislike Mount"
    HEALBOT_CMD_COPYSPELLS                  = "Copy current spells to all specs"
    HEALBOT_CMD_RESETSPELLS                 = "Reset spells"
    HEALBOT_CMD_RESETCURES                  = "Reset debuffs"
    HEALBOT_CMD_RESETBUFFS                  = "Reset buffs"
    HEALBOT_CMD_RESETICONS                  = "Reset custom buffs"
    HEALBOT_CMD_RESETBARS                   = "Reset bar position"
    HEALBOT_CMD_SUPPRESSSOUND               = "Toggle suppress sound when using auto trinkets"
    HEALBOT_CMD_SUPPRESSERRORS              = "Toggle suppress errors when using auto trinkets"
    HEALBOT_OPTIONS_COMMANDS                = "HealBot Commands"
    HEALBOT_WORD_RUN                        = "Run"
    HEALBOT_OPTIONS_MOUSEWHEEL              = "Use mouse wheel"
    HEALBOT_OPTIONS_MOUSEUP                 = "Wheel up"
    HEALBOT_OPTIONS_MOUSEDOWN               = "Wheel down"
    HEALBOT_CMD_DELCUSTOMDEBUFF9            = "Delete custom debuffs on priority 9"
	HEALBOT_CMD_DELCUSTOMDEBUFF10           = "Delete custom debuffs on priority 10"
	HEALBOT_CMD_DELCUSTOMDEBUFF11           = "Delete custom debuffs on priority 11"
	HEALBOT_CMD_DELCUSTOMDEBUFF12           = "Delete custom debuffs on priority 12"
    HEALBOT_ACCEPTSKINS                     = "Accept Skins from others"
    HEALBOT_SUPPRESSSOUND                   = "Auto Trinket: Suppress sound"
    HEALBOT_SUPPRESSERROR                   = "Auto Trinket: Suppress errors"
    HEALBOT_OPTIONS_CRASHPROT               = "Crash Protection"
    HEALBOT_OPTIONS_USEGENERALMACRO         = "Use general macro slots"
    HEALBOT_CP_MACRO_LEN                    = "Macro name must be between 1 and 14 characters"
    HEALBOT_CP_MACRO_BASE                   = "Base macro name"
    HEALBOT_CP_MACRO_SAVE                   = "Last saved at: "
    HEALBOT_CP_STARTTIME                    = "Protect duration on logon"
    HEALBOT_OPTIONS_COMBATPROT              = "Combat Protection"
    HEALBOT_COMBATPROT_PARTYNO              = "bars Reserved for Party"
    HEALBOT_COMBATPROT_RAIDNO               = "bars Reserved for Raid"
    HEALBOT_SKIN_CHECK_DONE                 = "Integrity check of skins complete"

    HEALBOT_WORD_HEALTH                     = "Health"
    HEALBOT_OPTIONS_DONT_SHOW               = "Don't show"
    HEALBOT_OPTIONS_SAME_AS_HLTH_CURRENT    = "Same as health (current health)"
    HEALBOT_OPTIONS_SAME_AS_HLTH_FUTURE     = "Same as health (future health)"
    HEALBOT_OPTIONS_FUTURE_HLTH             = "Future health"
    HEALBOT_SKIN_HEALTHBARCOL_TEXT          = "Health bar";
    HEALBOT_SKIN_HEALTHBACKCOL_TEXT         = "Background bar";
    HEALBOT_SKIN_INCHEALBARCOL_TEXT         = "Incoming heals";
    HEALBOT_OPTIONS_GROUP_PETS_BY_FIVE      = "Pets: Groups of five"
    HEALBOT_OPTIONS_OWN_PET_WITH_SELF       = "Own pet: with self"
    HEALBOT_OPTIONS_USEGAMETOOLTIP          = "Use Game Tooltip"
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER        = "Show power counter"
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER_PALA   = "Show holy power"
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER_MONK   = "Show chi power"
    HEALBOT_OPTIONS_CUSTOMDEBUFF_REVDUR     = "Reverse Duration"
    HEALBOT_OPTIONS_DISABLEHEALBOTSOLO      = "only when solo"
    HEALBOT_OPTIONS_CUSTOM_ALLDISEASE       = "All Disease"
    HEALBOT_OPTIONS_CUSTOM_ALLMAGIC         = "All Magic"
    HEALBOT_OPTIONS_CUSTOM_ALLCURSE         = "All Curse"
    HEALBOT_OPTIONS_CUSTOM_ALLPOISON        = "All Poison"
    HEALBOT_OPTIONS_CUSTOM_ALLBOSS          = "All Boss"
    HEALBOT_OPTIONS_CUSTOM_ALLBOSSSTRICT    = "Strict Mode"
    HEALBOT_OPTIONS_CUSTOM_CASTBY           = "Cast By"

    HEALBOT_BLIZZARD_MENU                   = "Blizzard menu"
    HEALBOT_HB_MENU                         = "Healbot menu"
    HEALBOT_FOLLOW                          = "Follow"
    HEALBOT_TRADE                           = "Trade"
    HEALBOT_PROMOTE_RA                      = "Promote raid assistant"
    HEALBOT_DEMOTE_RA                       = "Demote raid assistant"
    HEALBOT_TOGGLE_ENABLED                  = "Toggle enabled"
    HEALBOT_TOGGLE_MYTARGETS                = "Toggle My Targets"
    HEALBOT_WORD_PERMANENT                  = "Permanent"
    HEALBOT_TOGGLE_PRIVATETANKS             = "Toggle private tanks"
    HEALBOT_TOGGLE_PRIVATEHEALERS           = "Toggle private healers"
    HEALBOT_RESET_BAR                       = "Reset bar"
    HEALBOT_HIDE_BARS                       = "Hide bars over 100 yards"
    HEALBOT_RANDOMMOUNT                     = "Random Mount"
    HEALBOT_RANDOMGOUNDMOUNT                = "Random Ground Mount"
    HEALBOT_RANDOMPET                       = "Random Pet"
    HEALBOT_RANDOMFAVMOUNT                  = "Random Favorite Mount"
    HEALBOT_RANDOMFAVPET                    = "Random Favorite Pet"
    HEALBOT_EMOTE                           = "Emote"
    HEALBOT_EMOTE_CAT_COMBAT                = "Combat"
    HEALBOT_EMOTE_CAT_EMOTION               = "Emotion"
    HEALBOT_EMOTE_CAT_HAPPY                 = "Happy"
    HEALBOT_EMOTE_CAT_GREET                 = "Greeting"
    HEALBOT_EMOTE_CAT_OTHER                 = "Other"
    HEALBOT_EMOTE_CAT_RESPECT               = "Respect"
    HEALBOT_EMOTE_CAT_UNHAPPY               = "Unhappy"
    HEALBOT_EMOTE_ANGRY                     = "Angry"
    HEALBOT_EMOTE_APPLAUD                   = "Applaud"
    HEALBOT_EMOTE_ATTACKTARGET              = "AttackTarget"
    HEALBOT_EMOTE_BASHFUL                   = "Bashful"
    HEALBOT_EMOTE_BEG                       = "Beg"
    HEALBOT_EMOTE_BLOW                      = "Blow"
    HEALBOT_EMOTE_BLUSH                     = "Blush"
    HEALBOT_EMOTE_BOGGLE                    = "Boggle"
    HEALBOT_EMOTE_BORED                     = "Bored"
    HEALBOT_EMOTE_BOW                       = "Bow"
    HEALBOT_EMOTE_BYE                       = "Bye"
    HEALBOT_EMOTE_CACKLE                    = "Cackle"
    HEALBOT_EMOTE_CHARGE                    = "Charge"
    HEALBOT_EMOTE_CHEER                     = "Cheer"
    HEALBOT_EMOTE_CHUCKLE                   = "Chuckle"
    HEALBOT_EMOTE_CLAP                      = "Clap"
    HEALBOT_EMOTE_COMMEND                   = "Commend"
    HEALBOT_EMOTE_CONFUSED                  = "Confused"
    HEALBOT_EMOTE_CONGRATS                  = "Congrats"
    HEALBOT_EMOTE_COWER                     = "Cower"
    HEALBOT_EMOTE_CRY                       = "Cry"
    HEALBOT_EMOTE_CURIOUS                   = "Curious"
    HEALBOT_EMOTE_CURTSEY                   = "Curtsey"
    HEALBOT_EMOTE_DANCE                     = "Dance"
    HEALBOT_EMOTE_DOOM                      = "Doom"
    HEALBOT_EMOTE_DRINK                     = "Drink"
    HEALBOT_EMOTE_EAT                       = "Eat"
    HEALBOT_EMOTE_EXCITED                   = "Excited"
    HEALBOT_EMOTE_FLEE                      = "Flee"
    HEALBOT_EMOTE_FLEX                      = "Flex"
    HEALBOT_EMOTE_FLIRT                     = "Flirt"
    HEALBOT_EMOTE_FOLLOWME                  = "FollowMe"
    HEALBOT_EMOTE_GASP                      = "Gasp"
    HEALBOT_EMOTE_GIGGLE                    = "Giggle"
    HEALBOT_EMOTE_GLOAT                     = "Gloat"
    HEALBOT_EMOTE_GOLFCLAP                  = "GolfClap"
    HEALBOT_EMOTE_GREET                     = "Greet"
    HEALBOT_EMOTE_GROVEL                    = "Grovel"
    HEALBOT_EMOTE_GROWL                     = "Growl"
    HEALBOT_EMOTE_GUFFAW                    = "Guffaw"
    HEALBOT_EMOTE_HAIL                      = "Hail"
    HEALBOT_EMOTE_HEALME                    = "HealMe"
    HEALBOT_EMOTE_HELLO                     = "Hello"
    HEALBOT_EMOTE_INCOMING                  = "Incoming"
    HEALBOT_EMOTE_INSULT                    = "Insult"
    HEALBOT_EMOTE_KISS                      = "Kiss"
    HEALBOT_EMOTE_KNEEL                     = "Kneel"
    HEALBOT_EMOTE_LAUGH                     = "Laugh"
    HEALBOT_EMOTE_LAY                       = "Lay"
    HEALBOT_EMOTE_LOST                      = "Lost"
    HEALBOT_EMOTE_MOURN                     = "Mourn"
    HEALBOT_EMOTE_NO                        = "No"
    HEALBOT_EMOTE_NOD                       = "Nod"
    HEALBOT_EMOTE_OOM                       = "oom"
    HEALBOT_EMOTE_OPENFIRE                  = "OpenFire"
    HEALBOT_EMOTE_POINT                     = "Point"
    HEALBOT_EMOTE_PRAY                      = "Pray"
    HEALBOT_EMOTE_PUZZLED                   = "Puzzled"
    HEALBOT_EMOTE_RASP                      = "Rasp"
    HEALBOT_EMOTE_ROAR                      = "Roar"
    HEALBOT_EMOTE_ROFL                      = "rofl"
    HEALBOT_EMOTE_ROLLEYES                  = "RollEyes"
    HEALBOT_EMOTE_RUDE                      = "Rude"
    HEALBOT_EMOTE_SALUTE                    = "Salute"
    HEALBOT_EMOTE_SHRUG                     = "Shrug"
    HEALBOT_EMOTE_SHY                       = "Shy"
    HEALBOT_EMOTE_SIGH                      = "Sigh"
    HEALBOT_EMOTE_SILLY                     = "Silly"
    HEALBOT_EMOTE_SLEEP                     = "Sleep"
    HEALBOT_EMOTE_SURRENDER                 = "Surrender"
    HEALBOT_EMOTE_TALK                      = "Talk"
    HEALBOT_EMOTE_TAUNT                     = "Taunt"
    HEALBOT_EMOTE_THANK                     = "Thank"
    HEALBOT_EMOTE_TRAIN                     = "Train"
    HEALBOT_EMOTE_VICTORY                   = "Victory"
    HEALBOT_EMOTE_VIOLIN                    = "Violin"
    HEALBOT_EMOTE_WAIT                      = "Wait"
    HEALBOT_EMOTE_WAVE                      = "Wave"
    HEALBOT_EMOTE_WELCOME                   = "Welcome"
    HEALBOT_ZONE_AQ40                       = "Ahn'Qiraj"
    HEALBOT_ZONE_VASHJIR1                   = "Kelp'thar Forest"
    HEALBOT_ZONE_VASHJIR2                   = "Shimmering Expanse"
    HEALBOT_ZONE_VASHJIR3                   = "Abyssal Depths"
    HEALBOT_ZONE_VASHJIR                    = "Vashj'ir"
    HEALBOT_RESLAG_INDICATOR                = "Keep name green after res set to" 
    HEALBOT_RESLAG_INDICATOR_ERROR          = "Keep name green after res must be between 1 and 30" 
    HEALBOT_FRAMELOCK_BYPASS_OFF            = "Frame lock bypass turned Off"
    HEALBOT_FRAMELOCK_BYPASS_ON             = "Frame lock bypass (Ctl+Alt+Left) turned On"
    HEALBOT_RESTRICTTARGETBAR_ON            = "Restrict Target bar turned On"
    HEALBOT_RESTRICTTARGETBAR_OFF           = "Restrict Target bar turned Off"
    HEALBOT_AGGRO2_ERROR_MSG                = "To set aggro level 2, threat percentage must be between 25 and 95"
    HEALBOT_AGGRO3_ERROR_MSG                = "To set aggro level 3, threat percentage must be between 75 and 100"
    HEALBOT_AGGRO2_SET_MSG                  = "Aggro level 2 set at threat percentage "
    HEALBOT_AGGRO3_SET_MSG                  = "Aggro level 3 set at threat percentage "
    HEALBOT_WORD_THREAT                     = "Threat"
    HEALBOT_AGGRO_ERROR_MSG                 = "Invalid aggro level - use 2 or 3"

    HEALBOT_OPTIONS_QUERYTALENTS            = "Query talent data"       
    HEALBOT_OPTIONS_LOWMANAINDICATOR        = "Low Mana indicator"
    HEALBOT_OPTIONS_LOWMANAINDICATOR1       = "Don't show"
    HEALBOT_OPTIONS_LOWMANAINDICATOR2       = "*10% / **20% / ***30%"
    HEALBOT_OPTIONS_LOWMANAINDICATOR3       = "*15% / **30% / ***45%"
    HEALBOT_OPTIONS_LOWMANAINDICATOR4       = "*20% / **40% / ***60%"
    HEALBOT_OPTIONS_LOWMANAINDICATOR5       = "*25% / **50% / ***75%"
    HEALBOT_OPTIONS_LOWMANAINDICATOR6       = "*30% / **60% / ***90%"

    HEALBOT_OPTION_IGNORE_AURA_RESTED       = "Ignore aura events when resting"
    HEALBOT_OPTION_ADJUST_MAX_HEALTH        = "Adjust unit max health"

    HEALBOT_WORD_ENABLE                     = "Enable"
    HEALBOT_WORD_DISABLE                    = "Disable"

    HEALBOT_OPTIONS_MYCLASS                 = "My Class"

    HEALBOT_OPTIONS_CONTENT_ABOUT           = "        About"
    HEALBOT_OPTIONS_CONTENT_GENERAL         = "        " .. HEALBOT_OPTIONS_TAB_GENERAL
    HEALBOT_OPTIONS_CONTENT_SPELLS          = "        " .. HEALBOT_OPTIONS_TAB_SPELLS
    HEALBOT_OPTIONS_CONTENT_SKINS           = "        " .. HEALBOT_OPTIONS_TAB_SKIN
    HEALBOT_OPTIONS_CONTENT_CURE            = "        " .. HEALBOT_OPTIONS_TAB_DEBUFFS
    HEALBOT_OPTIONS_CONTENT_BUFFS           = "        " .. HEALBOT_OPTIONS_TAB_BUFFS
    HEALBOT_OPTIONS_CONTENT_TIPS            = "        " .. HEALBOT_OPTIONS_TAB_TIPS
    HEALBOT_OPTIONS_CONTENT_MOUSEWHEEL      = "        Mouse Wheel"
    HEALBOT_OPTIONS_CONTENT_TEST            = "        Test"
    HEALBOT_OPTIONS_CONTENT_INOUT           = "        Import / Export"
    HEALBOT_OPTIONS_REFRESH                 = "Refresh"

    HEALBOT_CUSTOM_CATEGORY                 = "Category"
    HEALBOT_CUSTOM_CAT_CUSTOM               = "Custom"
    HEALBOT_CUSTOM_CAT_02                   = "A-B" 
    HEALBOT_CUSTOM_CAT_03                   = "C-D"
    HEALBOT_CUSTOM_CAT_04                   = "E-F"
    HEALBOT_CUSTOM_CAT_05                   = "G-H"
    HEALBOT_CUSTOM_CAT_06                   = "I-J"
    HEALBOT_CUSTOM_CAT_07                   = "K-L"
    HEALBOT_CUSTOM_CAT_08                   = "M-N"
    HEALBOT_CUSTOM_CAT_09                   = "O-P"
    HEALBOT_CUSTOM_CAT_10                   = "Q-R"
    HEALBOT_CUSTOM_CAT_11                   = "S-T"
    HEALBOT_CUSTOM_CAT_12                   = "U-V"
    HEALBOT_CUSTOM_CAT_13                   = "W-X"
    HEALBOT_CUSTOM_CAT_14                   = "Y-Z"

    HEALBOT_CUSTOM_CASTBY_EVERYONE          = "Everyone"
    HEALBOT_CUSTOM_CASTBY_ENEMY             = "Enemy"
    HEALBOT_CUSTOM_CASTBY_FRIEND            = "Friend"
    
    HEALBOT_CUSTOM_CAT_CUSTOM_AUTOMATIC     = "Automatic Debuffs"
    HEALBOT_CUSTOM_DEBUFF_CATS = {}

    HEALBOT_ABOUT_DESC1                    = "Add frames with skinable bars for healing, decursive, buffing, ressing, aggro tracking"
    HEALBOT_ABOUT_WEBSITE                  = "Website:"
    HEALBOT_ABOUT_AUTHORH                  = "Author:"
    HEALBOT_ABOUT_AUTHORD                  = "Strife"
    HEALBOT_ABOUT_CATH                     = "Category:"
    HEALBOT_ABOUT_CATD                     = "Unit Frames, Buffs and Debuffs, Combat:Healer"
    HEALBOT_ABOUT_CREDITH                  = "Credits:"
    HEALBOT_ABOUT_CREDITD                  = "Acirac, Kubik, Von, Aldetal, Brezza, Moonlight Han Xing, CTShammy, Hermis, Ariá, Snaomi"  -- Anyone taking on translations (if required), feel free to add yourself here.
    HEALBOT_ABOUT_LOCALH                   = "Localizations:"
    HEALBOT_ABOUT_LOCALD                   = "deDE, enUK, esES, esMX, frFR, huHU, itIT, koKR, poBR, ruRU, zhCN, zhTW"
    HEALBOT_ABOUT_FAQH                     = "Frequently Asked Questions"
    HEALBOT_ABOUT_FAQ_QUESTION             = "Question"
    HEALBOT_ABOUT_FAQ_ANSWER               = "Answer"

    HEALBOT_ABOUT_FAQ_QUESTIONS = {   [1]   = "Buffs - All the bars are White, what happened",
									  [2]   = "Casting - Sometimes the cursor turns blue and I can't do anything",
                                      [3]   = "Macros - Do you have any cooldown examples",
                                      [4]   = "Macros - Do you have any spell casting examples",
                                      [5]   = "Mouse - How do I use my mouseover macros with the mouse wheel",
                                      [6]   = "Options - Can bars be sorted by groups, for example have 2 groups per column",
                                      [7]   = "Options - Can I hide all the bars and only show those needing a debuff removed",
                                      [8]   = "Options - Can I hide the incoming heals",
                                      [9]   = "Options - Healbot does not save my options when i logout/logon",
                                      [10]  = "Options - How do I always use enabled settings",
                                      [11]  = "Options - How do I disable healbot automatically",
                                      [12]  = "Options - How do I make the bars grow a different direction",
                                      [13]  = "Options - How do I setup 'My Targets'",
                                      [14]  = "Options - How do I setup 'Private Tanks'",
                                      [15]  = "Options - Will Healbot create a bar for an NPC",
                                      [16]  = "Range - I can't see when people are out of range, how do I fix this",
                                      [17]  = "Spells - Healbot casts a different spell to my setup",
                                      [18]  = "Spells - I can no longer cast heals on unwounded targets",
                                  }

    HEALBOT_ABOUT_FAQ_SPELLS_ANSWER01       = "This is due to options set on the Spells tab \n" ..
                                              "try changing the following and testing: \n\n" ..
                                              "1: On the spells tab: Turn on Always Use Enabled \n" ..
                                              "2: On the spells tab: Turn off SmartCast \n\n" ..
                                              "Note: It is expected that most users will want to \n"..
                                              "turn SmartCast back on \n\n" ..
                                              "Note: It is expected that experienced users will want to \n" ..
                                              "turn off Always Use Enabled  \n" ..
                                              "and set the spells for disabled bars"
                                              
    HEALBOT_ABOUT_FAQ_ANSWERS = {     [1]   = "You are monitoring for missing buffs \n\n" .. 
                                              "This can be turned off on the buffs tab \n" ..
                                              "Alternatively click on the bar and cast the buff",
                                      [2]   = "This is blizzard functionality, not Healbot \n\n" .. 
                                              "Using the standard blizzard frames, \n" ..
                                              "try casting a spell thats on Cooldown \n" ..
                                              "Notice how the cursor turns blue. \n\n" ..
                                              "On the spells tab, use Avoid Blue Cursor",
									  [3]   = "Yes \n\n"..
                                              "Paladin Hand of Salvation cooldown macro example: \n\n" ..
                                              "#show Hand of Salvation \n" ..
                                              '/script local n=UnitName("hbtarget"); ' .. "\n" ..
                                              'if GetSpellCooldown("Hand of Salvation")==0 then ' .. " \n" ..
                                              'SendChatMessage("Hand of Salvation on "..n,"YELL") ' .. "\n" ..
                                              'SendChatMessage("Hand of Salvation!","WHISPER",nil,n) ' .. "\n" ..
                                              "end; \n" ..
                                              "/cast [@hbtarget] Hand of Salvation",
                                      [4]   = "Yes \n\n"..
											  "Preist Flash Heal, example using both trinkets: \n\n" ..
                                              "#show Flash Heal \n" ..
                                              "/script UIErrorsFrame:Hide() \n" ..
                                              "/console Sound_EnableSFX 0 \n" ..
                                              "/use 13 \n" ..
                                              "/use 14 \n" ..
                                              "/console Sound_EnableSFX 1 \n" ..
                                              "/cast [@hbtarget] Flash Heal \n" ..
                                              "/script UIErrorsFrame:Clear(); UIErrorsFrame:Show()",
                                      [5]   = "1: On the Mouse Wheel tab: Turn off Use Mouse Wheel \n" ..
                                              "2: Bind your macros to blizzard's bindings with\n[@mouseover] \n\n\n" ..
                                              "Eample macro: \n\n" ..
                                              "#showtooltip Flash Heal \n" ..
                                              "/cast [@mouseover] Flash Heal \n",
                                      [6]   = "Yes \n\n\n"..
                                              "With Headers: \n" ..
                                              "1: On the Skins>Headers tab, switch on Show Headers \n" ..
                                              "2: On the Skins>Bars tab, set Number of Groups per\ncolumn \n\n" ..
                                              "Without Headers: \n" ..
                                              "1: On the Skins>Bars tab, switch on Use Groups per\nColumn \n" ..
                                              "2: On the Skins>Bars tab, set Number of Groups per\ncolumn ",
                                      [7]   = "Yes \n\n"..
                                              "1: On the Skins>Healing>Alert tab, set Alert Level to 0 \n" ..
                                              "2: On the Skins>Aggro tab, turn off the Aggro Monitor \n" .. 
                                              "3: On the Skins>Bars tab, set Disabled opacity to 0 \n" ..
                                              "4: On the Skins>Bars tab, set Background opacity to 0 \n" ..
                                              "5: On the Skins>Bar Text tab, click on the bar Disabled \n" ..
                                              "and set the Disabled text opacity to 0 \n" ..
                                              "6: On the Skins>General tab, click on the bar\n" ..
                                              "Background and set the Background opacity to 0 \n" ..
                                              "7: On the Cure tab, Turn on debuff monitoring",
                                      [8]   = "Yes \n\n"..
                                              "1: On the Skins>Bars tab, set Incoming Heals to Dont\nShow\n" ..
                                              "2: On the Skins>Bar Text tab, \n" ..
                                              "set Show Health on Bar to No Incoming Heals",
                                      [9]   = "This has been present since a change in WoW 3.2, \n" ..
                                              "it can affects characters with weird letters in their name \n\n" ..
                                              "If your on Vista or Win7, try the follow: \n"..
                                              "change system locale to English\n(for non-unicode programs) \n" ..
                                              "in Control Panel > Region and Language >\nAdministrative Tab",
                                      [10]   = "On the spells tab turn on Always Use Enabled \n\n" ..
                                              "Some my also want to set the Alert Level to 100 \n" ..
                                              "This can be done on the Skins>Healing>Alert tab",
                                      [11]  = "Disable for a character: \n\n" ..
                                              "1: Open the General tab \n" ..
                                              "2: Turn on the Disable option \n\n\n" ..
                                              "Disable when solo: \n\n" ..
                                              "1: Open the General tab \n" ..
                                              "2: To the right of the Disable option, Select only when\nsolo \n" ..
                                              "3: Turn on the Disable option",
                                      [12]  = "Change the Bars Anchor setting on the Skins>General\ntab  \n\n" ..
                                              "Top Right: the bars will grow Down and Left \n" ..
                                              "Top Left: the bars will grow Down and Right \n" ..
                                              "Bottom Right: the bars will grow Up and Left \n" ..
                                              "Bottom Left: the bars will grow Up and Right",
                                      [13]  = "My Targets allows you to create a list of Targets you \n" ..
                                              "want to group separately from others, similar to the\nMT group \n\n" ..
                                              "The following options are available for \n" .. 
                                              "adding/removing people to/from the My Targets group \n\n" ..
                                              "- Shift+Ctrl+Alt+Right click on the bar \n" ..
                                              '- Use the Healbot Menu, enter "hbmenu" on the spells\ntab ' .. "\n" ..
                                              "- Use the Mouse Wheel, set on the Mouse Wheel tab",
                                      [14]  = "Private Tanks can be added to the Main Tanks list, \n" ..
                                              "the Private tanks are only visible in your Healbot \n" ..
                                              "and do not affect other players or addons \n\n" ..
                                              "The following options are available for \n" ..
                                              "adding/removing people to/from the Tanks list \n\n" ..
                                              '- Use the Healbot Menu, enter "hbmenu" on the spells\ntab ' .. "\n" ..
                                              "- Use the Mouse Wheel, set on the Mouse Wheel tab",                                     
                                      [15]  = "Yes \n\n"..
                                              "1: On the Skins>Healing tab, turn on Focus \n" ..
                                              "2: set your focus on the NPC (or PC not in raid/party) \n" ..
                                              "Healbot will create a bar in your My Targets list \n\n" ..
                                              "Note: If in a combat situation where you zone in and out\nwhile \n" ..
                                              "in combat and need to reset focus on an NPC \n" ..
                                              "on the Skins>Healing tab set Focus: always show to on \n" ..
                                              "This will keep the bar available during combat. \n\n" ..
                                              "Note: The HealBot Menu has the option\n'Set HealBot Focus' \n" ..
                                              "This can make setting focus easy on NPC's and \n" ..
                                              "serves as a reminder to set focus. \n\n" ..
                                              "Enter 'hbmenu' on the spells tab to use HealBot Menu \n" ..
                                              "or use the Mouse Wheel tab to and set HealBot Menu",
                                      [16]  = "1: On the Skins>Bars tab, adjust the disabled bar\nopacity \n" ..
                                              "2: On the Skins>Bars Text tab, adjust the disabled text \n" ..
                                              "opacity to do this click on the bar labeled Disabled. \n\n" ..
                                              "Some my also want to set the Alert Level to 100 \n" ..
                                              "This can be done on the Skins>Healing>Alert tab",
                                      [17]  = "Actually Healbot is casting exacly as the setup. \n\n" .. HEALBOT_ABOUT_FAQ_SPELLS_ANSWER01,
                                      [18]  = HEALBOT_ABOUT_FAQ_SPELLS_ANSWER01,
                                  }

    HEALBOT_OPTIONS_SKINAUTHOR              = "Skin Author"
    HEALBOT_OPTIONS_AVOIDBLUECURSOR         = "Avoid\nBlue Cursor"
    HEALBOT_PLAYER_OF_REALM                 = "of"
    
    HEALBOT_OPTIONS_LANG                    = "Language"
    
    HEALBOT_OPTIONS_LANG_ZHCN               = "Chinese (zhCN)"
    HEALBOT_OPTIONS_LANG_ENUK               = "English (enUK)"
    HEALBOT_OPTIONS_LANG_ENUS               = "English (enUS)"
    HEALBOT_OPTIONS_LANG_FRFR               = "French (frFR)"
    HEALBOT_OPTIONS_LANG_DEDE               = "German (deDE)"
    HEALBOT_OPTIONS_LANG_GRGR               = "Greek (grGR)"
    HEALBOT_OPTIONS_LANG_HUHU               = "Hungarian (huHU)"
    HEALBOT_OPTIONS_LANG_KRKR               = "Korean (krKR)"
    HEALBOT_OPTIONS_LANG_ITIT               = "Italian (itIT)"
    HEALBOT_OPTIONS_LANG_PTBR               = "Portuguese (ptBR)"
    HEALBOT_OPTIONS_LANG_RURU               = "Russian (ruRU)"
    HEALBOT_OPTIONS_LANG_ESES               = "Spanish (esES)"
    HEALBOT_OPTIONS_LANG_TWTW               = "Taiwanese (twTW)"
    HEALBOT_OPTIONS_LANG_ESMX               = "Mexican (esMX)"
    
    HEALBOT_OPTIONS_LANG_ADDON_FAIL1        = "Failed to load addon for localization"
    HEALBOT_OPTIONS_LANG_ADDON_FAIL2        = "Reason for failure is:"
    HEALBOT_OPTIONS_LANG_ADDON_FAIL3        = "Note in the current version, this is the only warning for"
    HEALBOT_OPTIONS_IMPORT_FAIL1            = "Failed to Import"
    HEALBOT_OPTIONS_IMPORT_FAIL2            = "Reason for failure is:"
    
    HEALBOT_OPTIONS_ADDON_FAIL              = "Failed to load headbot addon"
    
    HEALBOT_OPTIONS_IN_A_GROUP              = "Only when in a Group or Raid"
    HEALBOT_OPTIONS_PALADIN_BLESSINGS       = "View all my blessings as same"
    
    HEALBOT_OPTIONS_CONTENT_SKINS_GENERAL   = "    " .. HEALBOT_OPTIONS_TAB_GENERAL
    HEALBOT_OPTIONS_CONTENT_SKINSF_GENERAL  = "        " .. HEALBOT_OPTIONS_TAB_GENERAL
    HEALBOT_OPTIONS_CONTENT_SKINS_HEALING   = "    " .. HEALBOT_OPTIONS_TAB_HEALING
    HEALBOT_OPTIONS_CONTENT_SKINS_HEADERS   = "        " .. HEALBOT_OPTIONS_TAB_HEADERS
    HEALBOT_OPTIONS_CONTENT_SKINS_BARS      = "        " .. HEALBOT_OPTIONS_TAB_BARS
    HEALBOT_OPTIONS_CONTENT_SKINS_ICONS     = "        " .. HEALBOT_OPTIONS_TAB_ICONS
    HEALBOT_OPTIONS_CONTENT_SKINS_AGGRO     = "    " .. HEALBOT_OPTIONS_TAB_AGGRO
    HEALBOT_OPTIONS_CONTENT_SKINS_PROT      = "    " .. HEALBOT_OPTIONS_TAB_PROTECTION
    HEALBOT_OPTIONS_CONTENT_SKINS_CHAT      = "    " .. HEALBOT_OPTIONS_TAB_CHAT
    HEALBOT_OPTIONS_CONTENT_SKINS_TEXT      = "        " .. HEALBOT_OPTIONS_TAB_TEXT
    HEALBOT_OPTIONS_CONTENT_SKINS_ICONTEXT  = "        " .. HEALBOT_OPTIONS_TAB_ICONTEXT

    HEALBOT_OPTIONS_CONTENT_CURE_DEBUFF     = "    " .. HEALBOT_OPTIONS_TAB_GENERAL
    HEALBOT_OPTIONS_CONTENT_CURE_CUSTOM     = "    " .. HEALBOT_CLASSES_CUSTOM
    HEALBOT_OPTIONS_CONTENT_CURE_WARNING    = "    " .. HEALBOT_OPTIONS_TAB_WARNING

    HEALBOT_OPTIONS_CONTENT_BUFFS_GENERAL   = "    " .. HEALBOT_OPTIONS_TAB_GENERAL
    HEALBOT_OPTIONS_CONTENT_BUFFS_HOTS      = "    " .. HEALBOT_CLASSES_CUSTOM

    HEALBOT_OPTIONS_CONTENT_INOUT_SKINS     = "    " .. HEALBOT_OPTIONS_TAB_SKIN
    HEALBOT_OPTIONS_CONTENT_INOUT_CDEBUFF   = "    " .. HEALBOT_OPTIONS_TAB_CUSTOM_DEBUFFS
    HEALBOT_OPTIONS_CONTENT_INOUT_BUFF      = "    " .. HEALBOT_OPTIONS_TAB_CUSTOM_BUFFS
    HEALBOT_OPTIONS_CONTENT_INOUT_SPELLS    = "    " .. HEALBOT_OPTIONS_TAB_SPELLS
    HEALBOT_OPTIONS_CONTENT_INOUT_PRESETCOL = "    " .. HEALBOT_OPTIONS_PRESET.." Col"..HEALBOT_enWORD_COLOUR_SUFFIX.."s"
    HEALBOT_OPTIONS_CONTENT_SKINS_FRAMES    = "    " .. HEALBOT_OPTIONS_TAB_FRAMES
    
    HEALBOT_SKIN_ABSORBCOL_TEXT             = "Absorb effects";
    HEALBOT_OPTIONS_BARALPHAABSORB          = "Absorb effects opacity";
    HEALBOT_OPTIONS_OUTLINE                 = "Outline"
    HEALBOT_OPTIONS_FRAME                   = "Frame"
    HEALBOT_OPTIONS_FRAMESOPTTEXT           = "Frames options"
    HEALBOT_OPTIONS_SETTOOLTIP_POSITION     = "Set Tooltip Position"
    HEALBOT_OPTIONS_FRAME_TITLE             = "Frame Title"
    HEALBOT_OPTIONS_FRAME_TITLE_SHOW        = "Show Header"
    HEALBOT_OPTIONS_GROW_DIRECTION          = "Grow Direction"
    HEALBOT_OPTIONS_BARSORIENTATION         = "Bar Orientation"
    HEALBOT_OPTIONS_GROW_HORIZONTAL         = "Horizontal"
    HEALBOT_OPTIONS_GROW_VERTICAL           = "Vertical"
    HEALBOT_OPTIONS_FONT_OFFSET             = "Font Offset"
    HEALBOT_OPTIONS_SET_FRAME_HEALGROUPS    = "Assign Heal Groups"
    HEALBOT_OPTION_EXCLUDEMOUNT_ON          = "Now Excluding Mount"
    HEALBOT_OPTION_EXCLUDEMOUNT_OFF         = "No longer Excluding Mount"
    HEALBOT_CMD_TOGGLEEXCLUDEMOUNT          = "Toggle Exclude Mount"
    HEALBOT_OPTIONS_HIDEMINIBOSSFRAMES      = "Hide mini boss frames";
    HEALBOT_OPTIONS_HIDERAIDFRAMES          = "Hide raid frames";
    HEALBOT_OPTIONS_FRAME_ALIAS             = "Alias"
    HEALBOT_OPTIONS_CONTENT_SKINS_HEALGROUP = "        " .. "Heal Groups"
    HEALBOT_OPTIONS_CONTENT_SKINS_BARCOLOUR = "        " .. "Bar Col"..HEALBOT_enWORD_COLOUR_SUFFIX.."s"
    HEALBOT_OPTIONS_SET_ALL_FRAMES          = "Apply current tab settings to all Frames"
    HEALBOT_WORDS_PROFILE                   = "Profile"
    HEALBOT_SHARE_SCREENSHOT                = "ScreenShot taken"
    HEALBOT_SHARE_INSTRUCTION               = "Go to the website for instructions on sharing with "..HEALBOT_ABOUT_URL
    HEALBOT_INOUT_STATUS_SKINSINIT          = "Skins can be shared at "..HEALBOT_ABOUT_URL
    HEALBOT_INOUT_STATUS_CDEBUFFINIT        = "Custom Debuffs can be shared at "..HEALBOT_ABOUT_URL
    HEALBOT_INOUT_STATUS_BUFFINIT           = "Custom Buffs can be shared at "..HEALBOT_ABOUT_URL
    HEALBOT_INOUT_STATUS_SPELLINIT          = "Spells can be shared at "..HEALBOT_ABOUT_URL
    HEALBOT_INOUT_STATUS_PRESETCOLINIT      = HEALBOT_OPTIONS_PRESET.." Col"..HEALBOT_enWORD_COLOUR_SUFFIX.."s can be shared at "..HEALBOT_ABOUT_URL
    HEALBOT_ENEMY_USE_FRAME                 = "Use frame"
    HEALBOT_ENEMY_INCLUDE_SELF              = "Include my target"
    HEALBOT_ENEMY_INCLUDE_TANKS             = "Include tanks targets"
    HEALBOT_OPTIONS_ENEMY_OPT               = "Enemy Visibility";
    HEALBOT_OPTIONS_SHARE_OPT               = "Share Options";
    HEALBOT_OPTIONS_CONTENT_SKINS_SHARE     = "    " .. "Share"
    HEALBOT_OPTIONS_CONTENT_SKINS_ENEMY     = "    " .. "Enemy"
    HEALBOT_ENEMY_NO_TARGET                 = "No target"
    HEALBOT_OPTIONS_ENEMYBARS               = "Enemy bars at all times";
    HEALBOT_OPTIONS_HARMFUL_SPELLS          = "Harmful Spells"
    HEALBOT_ENEMY_INCLUDE_MYTARGETS         = "Include My Targets targets"
    HEALBOT_ENEMY_NUMBER_BOSSES             = "Number of Bosses"
    HEALBOT_ENEMY_HIDE_OUTOFCOMBAT          = "Hide bars out of combat"
    HEALBOT_ENEMY_EXISTS_SHOW               = "Entering combat only".."\n".."show when exists"
    HEALBOT_ENEMY_EXISTS_SHOW_PTARGETS      = "Player target bars"
    HEALBOT_ENEMY_EXISTS_SHOW_BOSSES        = "Boss bars"
    HEALBOT_OPTIONS_SHOW_ONLY_FRIEND        = "Only show Friendly"
    HEALBOT_OPTIONS_EXCLUDE_RAID            = "Exclude Self, Group and Raid"
    HEALBOT_OPTIONS_PROFILE                 = "Profile for".."\n".."Spells/Buffs/Debuffs"
    HEALBOT_OPTIONS_PROFILE_CHARACTER       = "Character"
    HEALBOT_OPTIONS_PROFILE_CLASS           = "Class"
    HEALBOT_OPTIONS_INCOMBATALERTLEVEL      = "Alert Level - In Combat";
    HEALBOT_OPTIONS_OUTCOMBATALERTLEVEL     = "Alert Level - Out of Combat";
    HEALBOT_OPTIONS_SORTOORLAST             = "Sort out of range last"
    HEALBOT_OPTION_NUMENEMYS                = "Number of Enemies"
    HEALBOT_WORD_AUTO                       = "Auto"
	HEALBOT_OPTIONS_ENABLEAUTOCOMBAT        = "Enable HealBot autoCombat"
    HEALBOT_WORDS_REMOVETEMPCUSTOMNAME      = "Remove temporary custom name"
    HEALBOT_WORDS_REMOVEPERMCUSTOMNAME      = "Remove permanent custom name"
    HEALBOT_WORDS_ADDTEMPCUSTOMNAME         = "Add temporary custom name"
    HEALBOT_WORDS_ADDPERMCUSTOMNAME         = "Add permanent custom name"
    HEALBOT_OPTIONS_ENABLELIBUTF8           = "Enable UTF8 library"
    HEALBOT_OPTIONS_SHOWDIRECTION           = "Show Out of Range Direction"
    HEALBOT_OPTIONS_SHOWDIRECTIONMOUSE      = "Only on Mouse Over"
    HEALBOT_LDB_LEFT_TOOLTIP                = "|cffffff00 Left Click:|r Toggle HealBot options panel";
    HEALBOT_LDB_SHIFTLEFT_TOOLTIP           = "|cffffff00 Shift-Left Click:|r Cycle through HealBot Skins";
    HEALBOT_LDB_RIGHT_TOOLTIP               = "|cffffff00 Right Click:|r Reset HealBot";
    HEALBOT_LDB_SHIFTRIGHT_TOOLTIP          = "|cffffff00 Shift-Right Click:|r Toggle HealBot On/Off";
    HEALBOT_WORD_PETBATTLE                  = "Pet Battle"
    HEALBOT_ENEMY_INCLUDE_ARENA             = "Include Arena opponents"
    HEALBOT_ENEMY_INCLUDE_ARENAPETS         = "Including Pets"
    HEALBOT_ENEMY_EXISTS_SHOW_ARENA         = "Arena opponent bars"
    HEALBOT_CMD_TOGGLECUSTOMCURECASTBY      = "Toggle Custom Cures - Default Cast By"
    HEALBOT_OPTIONS_ENTERINGCOMBAT          = "When entering combat"
    HEALBOT_OPTIONS_OUTOFCOMBAT             = "When out of combat"
    HEALBOT_OPTIONS_ALWAYSHIDE              = "Always Hide"
    HEALBOT_OPTIONS_NOCHANGE                = "No Change"
    HEALBOT_OPTIONS_ALWAYSSHOW              = "Always Show"
    HEALBOT_OPTIONS_PAGE                    = "Page"
    HEALBOT_OPTIONS_PREV                    = "<<"
    HEALBOT_OPTIONS_NEXT                    = ">>"
    HEALBOT_OPTIONS_PRESET_COLOUR           = HEALBOT_OPTIONS_PRESET.." Col"..HEALBOT_enWORD_COLOUR_SUFFIX
    
    HEALBOT_WORD_SUPPORTERS                 = "Supporters"
    HEALBOT_SUPPORTERS_PEOPLE = {  [01] = "Mythagos - Draenor",  -- Mythago
                                   [02] = "Nerak - Cenarion Circle",  -- Noobrak
                                   [03] = "Slayybelle",
                                   [04] = "SUNET",
                                   [05] = "Daskills",
                                   [06] = "killerdavy",
                                   [07] = "zathrain",
                                   [08] = "warhead0",
                                   [09] = "Droodibaby",
                                   [10] = "Byset",
                                   [11] = "Redemption",
                                   [12] = "Jaiseck",
                                   [13] = "xtacie",
                                   [14] = "bkwildlifecntrl",
                                   [15] = "mlharg",
                                   [16] = "Yuriusha",
                                   [17] = "spicy_squid",
                                   [18] = "Ameralanna_675",
                                   [19] = "ninjoism",
                                }
                               
end

function HealBot_Lang_InitVars()
    HEALBOT_CUSTOM_DEBUFF_CATS = {
         -- Defaults
        [HEALBOT_CUSTOM_CAT_CUSTOM_AUTOMATIC]  = 1,

        --Class Profession & Harmful Debuffs
        --[HEALBOT_DEBUFF_SAVING_GRACE]      = 11, --Priest
        --[HEALBOT_DARK_BARGAIN]             = 3, --Warlock
        [HEALBOT_SHROUD_OF_PURGATORY]      = 11, --Death Knight
        [HEALBOT_DEBUFF_ROCKET_FUEL_LEAK]  = 10, --Engineering
        
        [HEALBOT_DEBUFF_FORBEARANCE]              = 4,
        [HEALBOT_DEBUFF_WEAKENED_SOUL]            = 13,
        [HEALBOT_SHADOW_TOUCHED]                  = 11,

    --[[
	A-B 2
	C-D 3
	E-F 4
	G-H 5
	I-J 6
	K-L 7
	M-N 8
	O-P 9
	Q-R 10
	S-T 11
	U-V 12
	W-X 13
	Y-Z 14
	]]

	}
end

function HealBot_Lang_Options_enALL()
    HEALBOT_OPTIONS_HELP_TITLES={
                        -- Preset Colours
                                 ["PRESETCOLS"]="Prefix Col"..HEALBOT_enWORD_COLOUR_SUFFIX,
                                 ["PRESETCOLALIAS"]="Prefix Col"..HEALBOT_enWORD_COLOUR_SUFFIX.." Alias",
                                 ["PRESETCOLSET"]="Preset Col"..HEALBOT_enWORD_COLOUR_SUFFIX,
                                 ["PRESETCOLSELECT"]="Preset Col"..HEALBOT_enWORD_COLOUR_SUFFIX.." Select",
                                 ["PRESETCOLCANCEL"]="Preset Col"..HEALBOT_enWORD_COLOUR_SUFFIX.." Cancel",
                        -- General tab
                                 ["HIDEOPTIONBUTTON"]=HEALBOT_OPTIONS_HIDEOPTIONS,
                                 ["RIGHTTOOPENOPTIONS"]=HEALBOT_OPTIONS_RIGHTBOPTIONS,
                                 ["SHOWMINIMAPBUTTON"]=HEALBOT_OPTIONS_SHOWMINIMAPBUTTON,
                                 ["QUERYTALENTS"]=HEALBOT_OPTIONS_QUERYTALENTS,
                                 ["ENABLEFASTHEALTH"]=HEALBOT_OPTIONS_ENABLELIBQH,
                                 ["ENABLEAUTOCOMBAT"]=HEALBOT_OPTIONS_ENABLEAUTOCOMBAT,
                                 ["IGNOREAURAEVENTS"]=HEALBOT_OPTION_IGNORE_AURA_RESTED,
                                 ["DISABLEHEALBOT"]=HEALBOT_OPTIONS_DISABLEHEALBOT,
                                 ["DISABLEHEALBOTSOLO"]=HEALBOT_OPTIONS_DISABLEHEALBOT,
                                 ["ADJUSTMAXHLTH"]=HEALBOT_OPTION_ADJUST_MAX_HEALTH,
                                 ["MAXBARCACHE"]=HEALBOT_OPTIONS_MAXBARCACHE,
                                 ["INTERNALTIMERS"]=HEALBOT_OPTIONS_RANGECHECKFREQ,
                                 ["LANG"]=HEALBOT_OPTIONS_LANG,
                                 ["SETLANG"]=HEALBOT_OPTIONS_LANG,
                                 ["CMDS"]=HEALBOT_OPTIONS_COMMANDS,
                                 ["RUNCMDS"]=HEALBOT_OPTIONS_COMMANDS,
                                 ["PROFILE"]="Profile",
                                 ["SETPROFILE"]="Profile",
                                 ["CLASSTYPES"]="Class type configuration",
                        -- Spells tab
                                 ["SETSPELLSFOR"]=HEALBOT_OPTIONS_SETSPELLS,
                                 ["ALWAYSUSEENABLED"]=HEALBOT_OPTIONS_ENABLEHEALTHY,
                                 ["SPELLSBUTTON"]=HEALBOT_OPTIONS_COMBOBUTTON,
                                 ["SPELLSBUTTONCAST"]=HEALBOT_OPTIONS_BUTTONCASTMETHOD,
                                 ["SPELLSAVOIDBLUE"]="Avoid Blue Cursor",
                                 ["SPELLSAUTOTARGET"]="Auto Target",
                                 ["SPELLSAUTOTRINKET"]=HEALBOT_OPTIONS_COMBOAUTOTRINKET,
                                 ["SPELLSBUTTONCLICK"]=HEALBOT_OPTIONS_CLICK,
                                 ["SPELLSBUTTONSHIFTCLICK"]=HEALBOT_OPTIONS_SHIFT.." "..HEALBOT_OPTIONS_CLICK,
                                 ["SPELLSBUTTONCTRLCLICK"]=HEALBOT_OPTIONS_CTRL.." "..HEALBOT_OPTIONS_CLICK,
                                 ["SPELLSBUTTONALTCLICK"]=HEALBOT_OPTIONS_ALT.." "..HEALBOT_OPTIONS_CLICK,
                                 ["SPELLSBUTTONSHIFTCTRLCLICK"]=HEALBOT_OPTIONS_SHIFT.." "..HEALBOT_OPTIONS_CTRL.." "..HEALBOT_OPTIONS_CLICK,
                                 ["SPELLSBUTTONSHIFTALTCLICK"]=HEALBOT_OPTIONS_SHIFT.." "..HEALBOT_OPTIONS_ALT.." "..HEALBOT_OPTIONS_CLICK,
                                 ["SPELLSBUTTONCTRLALTCLICK"]=HEALBOT_OPTIONS_CTRL.." "..HEALBOT_OPTIONS_ALT.." "..HEALBOT_OPTIONS_CLICK,
                                 ["SPELLSHELPSELECT"]="Spell Selector",
                                 ["SPELLSSELECTSPELL"]=HEALBOT_OPTIONS_TAB_SPELLS,
                                 ["SPELLSSELECTMACRO"]=HEALBOT_WORD_MACROS,
                                 ["SPELLSSELECTITEMS"]=HEALBOT_OPTIONS_ITEMS,
                                 ["SPELLSSELECTCMDS"]=HEALBOT_WORD_COMMANDS,
                                 ["SPELLSSELECTCANCEL"]=HEALBOT_WORD_CANCEL,
                                 ["SMARTCAST"]=HEALBOT_OPTIONS_ENABLESMARTCAST,
                                 ["SMARTCASTAVOIDPVP"]=HEALBOT_OPTIONS_PROTECTPVP,
                                 ["SMARTCASTDEBUFF"]=HEALBOT_OPTIONS_SMARTCASTDISPELL,
                                 ["SMARTCASTBUFF"]=HEALBOT_OPTIONS_SMARTCASTBUFF,
                                 ["SMARTCASTHEAL"]=HEALBOT_OPTIONS_SMARTCASTHEAL,
                                 ["SMARTCASTRES"]="Cast resurrection",
                        -- Skins top
                                 ["SELECTSKIN"]=HEALBOT_OPTIONS_EXPORTSKIN,
                                 ["DELSKIN"]="Delete Skin",
                                 ["NEWSKIN"]=HEALBOT_OPTIONS_NEWSKINTEXT,
                                 ["SAVENEWSKIN"]="Save new skin",
                                 ["SELECTFRAME"]="Select Frame",
                                 ["FRAMEAPPLYTAB"]=HEALBOT_OPTIONS_SET_ALL_FRAMES,
                        -- Skins General tab
                                 ["SKINDEFAULTFOR"]=HEALBOT_OPTIONS_SKINDEFAULTFOR,
                                 ["STICKFRAMES"]=HEALBOT_OPTIONS_STICKYFRAMES,
                                 ["STICKSENSITIVITY"]=HEALBOT_OPTIONS_STICKYFRAMES.." Sensitivity",
                                 ["HIDEBLIZPARTYFRAMES"]=HEALBOT_OPTIONS_HIDEPARTYFRAMES,
                                 ["HIDEBLIZBOSSFRAMES"]=HEALBOT_OPTIONS_HIDEMINIBOSSFRAMES,
                                 ["HIDEBLIZRAIDFRAMES"]=HEALBOT_OPTIONS_HIDERAIDFRAMES,
                                 ["USEFLUIDBARS"]=HEALBOT_OPTION_USEFLUIDBARS,
                                 ["FLUIDBARSREFRESHSPEED"]=HEALBOT_OPTION_BARUPDFREQ,
                        -- Skins Protection tab
                                 ["USECRASHPROT"]=HEALBOT_OPTIONS_CRASHPROT,
                                 ["USECRASHPROTGENERALMACRO"]=HEALBOT_OPTIONS_USEGENERALMACRO,
                                 ["USECRASHPROTBASEMACRO"]=HEALBOT_CP_MACRO_BASE,
                                 ["USECRASHPROTLOGONDURATION"]=HEALBOT_CP_STARTTIME,
                                 ["USECOMBATPROT"]=HEALBOT_OPTIONS_COMBATPROT,
                                 ["USECOMBATPROTGROUP"]=HEALBOT_OPTIONS_COMBATPROT,
                                 ["USECOMBATPROTRAID"]=HEALBOT_OPTIONS_COMBATPROT,
                        -- Skins Chat tab
                                 ["CHATNONE"]=HEALBOT_OPTIONS_CASTNOTIFY1,
                                 ["CHATSELF"]=HEALBOT_OPTIONS_CASTNOTIFY2,
                                 ["CHATTARGET"]=HEALBOT_OPTIONS_CASTNOTIFY3,
                                 ["CHATPARTY"]=HEALBOT_OPTIONS_CASTNOTIFY4,
                                 ["CHATRAID"]=HEALBOT_OPTIONS_CASTNOTIFY5,
                                 ["CHATCHAN"]=HEALBOT_OPTIONS_CASTNOTIFY6,
                                 ["CHATRESONLY"]=HEALBOT_OPTIONS_CASTNOTIFYRESONLY,
                                 ["CHATMSG"]=HEALBOT_OPTIONS_NOTIFY_MSG,
                                 ["EOCOOM"]=HEALBOT_OPTIONS_EOC_OOM,
                        -- Skins Frames General tab
                                 ["GOTOHEALGROUPS"]=HEALBOT_OPTIONS_SET_FRAME_HEALGROUPS,
                                 ["FRAMEALIAS"]=HEALBOT_OPTIONS_FRAME_ALIAS,
                                 ["FRAMELOCKED"]="Lock Frame",
                                 ["FRAMEAUTOSHOW"]=HEALBOT_OPTIONS_AUTOSHOW,
                                 ["FRAMEAUTOSHOWSOUND"]=HEALBOT_OPTIONS_PANELSOUNDS,
                                 ["FRAMEANCHOR"]=HEALBOT_OPTIONS_ANCHOR,
                                 ["BARANCHOR"]=HEALBOT_OPTIONS_BARSANCHOR,
                                 ["BARGROWDIRECTION"]=HEALBOT_OPTIONS_GROW_DIRECTION,
                                 ["BARORIENTATION"]=HEALBOT_OPTIONS_BARSORIENTATION,
                                 ["FRAMESCALE"]=HEALBOT_OPTIONS_FRAMESCALE,
                                 ["SFOFFSETH"]=HEALBOT_OPTIONS_STICKFRAMEOFFSETH,
                                 ["SFOFFSETV"]=HEALBOT_OPTIONS_STICKFRAMEOFFSETV,
                                 ["FRAMEBACKCOL"]="Frame Background",
                                 ["FRAMEBORDERCOL"]="Frame Border",
                                 ["TOOLTIPPOSITION"]=HEALBOT_OPTIONS_SETTOOLTIP_POSITION,
                        -- Skins Frames Heal Groups tab
                                 ["SELECTFRAMEFORGROUP"]=HEALBOT_OPTIONS_FRAME,
                                 ["ENABLEHEALGROUP"]=HEALBOT_OPTIONS_FRAME,
                                 ["HEALGROUPDOWN"]="Heal Group Down",
                                 ["HEALGROUPUP"]="Heal Group Up",
                        -- Skins Frames Headers Bars tab
                                 ["BARHEADERS"]="Bar Headers",
                                 ["HEADERBARSSHOW"]=HEALBOT_OPTIONS_SHOWHEADERS,
                                 ["HEADERBARSBARCOL"]="Header Bar Col"..HEALBOT_enWORD_COLOUR_SUFFIX..".",
                                 ["HEADERBARSTEXTCOL"]="Header Text Col"..HEALBOT_enWORD_COLOUR_SUFFIX..".",
                                 ["HEADERBARSTEXTURE"]=HEALBOT_OPTIONS_SKINTEXTURE,
                                 ["HEADERBARSHEIGHT"]=HEALBOT_OPTION_AGGROBAR.." "..HEALBOT_OPTIONS_SKINHEIGHT,
                                 ["HEADERBARSWIDTH"]=HEALBOT_OPTION_AGGROBAR.." "..HEALBOT_OPTIONS_SKINWIDTH,
                                 ["HEADERBARSFONTNAME"]=HEALBOT_OPTIONS_SKINFONT,
                                 ["HEADERBARSFONTHEIGHT"]=HEALBOT_OPTIONS_SKINFHEIGHT,
                                 ["HEADERBARSFONTOUTLINE"]=HEALBOT_OPTIONS_SKINFOUTLINE,
                                 ["HEADERBARSFONTOFFSET"]=HEALBOT_OPTIONS_FONT_OFFSET,
                        -- Skins Frames Headers Frames tab
                                 ["FRAMEHEADERS"]="Frame Headers",
                                 ["HEADERFRAMESTITLE"]=HEALBOT_OPTIONS_FRAME_TITLE,
                                 ["HEADERFRAMESSHOW"]=HEALBOT_OPTIONS_SHOWHEADERS,
                                 ["HEADERFRAMESBARCOL"]="Header Bar Col"..HEALBOT_enWORD_COLOUR_SUFFIX,
                                 ["HEADERFRAMESTEXTCOL"]="Header Text Col"..HEALBOT_enWORD_COLOUR_SUFFIX,
                                 ["HEADERFRAMESTEXTURE"]=HEALBOT_OPTIONS_SKINTEXTURE,
                                 ["HEADERFRAMESHEIGHT"]=HEALBOT_OPTION_AGGROBAR.." "..HEALBOT_OPTIONS_SKINHEIGHT,
                                 ["HEADERFRAMESWIDTH"]=HEALBOT_OPTION_AGGROBAR.." "..HEALBOT_OPTIONS_SKINWIDTH,
                                 ["HEADERFRAMESFONTNAME"]=HEALBOT_OPTIONS_SKINFONT,
                                 ["HEADERFRAMESFONTHEIGHT"]=HEALBOT_OPTIONS_SKINFHEIGHT,
                                 ["HEADERFRAMESFONTOUTLINE"]=HEALBOT_OPTIONS_SKINFOUTLINE,
                                 ["HEADERFRAMESFONTOFFSET"]=HEALBOT_OPTIONS_FONT_OFFSET,
                        -- Skins Frames Bars General tab
                                 ["BARSGENERAL"]="Bars General",
                                 ["HEALBARSTEXTURE"]=HEALBOT_OPTIONS_SKINTEXTURE,
                                 ["HEALBARSNUMCOLS"]=HEALBOT_OPTIONS_SKINNUMCOLS,
                                 ["HEALBARSGRPSPERCOLS"]=HEALBOT_OPTIONS_GROUPSPERCOLUMN,
                                 ["HEALBARSHEIGHT"]=HEALBOT_OPTION_AGGROBAR.." "..HEALBOT_OPTIONS_SKINHEIGHT,
                                 ["HEALBARSWIDTH"]=HEALBOT_OPTION_AGGROBAR.." "..HEALBOT_OPTIONS_SKINWIDTH,
                                 ["HEALBARSBRSPACE"]=HEALBOT_OPTIONS_SKINBRSPACE,
                                 ["HEALBARSBCSPACE"]=HEALBOT_OPTIONS_SKINBCSPACE,
                                 ["HEALBARSAGGROSIZE"]=HEALBOT_OPTIONS_AGGROBARSIZE,
                                 ["HEALBARSPOWERSIZE"]=HEALBOT_OPTIONS_BAR2SIZE,
                                 ["HEALBARSPOWERCOUNT"]=HEALBOT_OPTIONS_SHOWPOWERCOUNTER,
                                 ["HEALBARSLOWMANA"]=HEALBOT_OPTIONS_LOWMANAINDICATOR,
                                 ["HEALBARSLOWMANAIC"]=HEALBOT_OPTIONS_MONITORBUFFSC,
                        -- Skins Frames Bars Colours tab
                                 ["BARSCOLOUR"]="Bars Col"..HEALBOT_enWORD_COLOUR_SUFFIX.."s",
                                 ["HEALBARSCOLHEALTHTYPE"]=HEALBOT_SKIN_HEALTHBARCOL_TEXT,
                                 ["HEALBARSCOLHEALTH"]="Heal Bar Custom Col"..HEALBOT_enWORD_COLOUR_SUFFIX,
                                 ["HEALBARSCOLALPHA"]=HEALBOT_OPTIONS_BARALPHA,
                                 ["HEALBARSBACKCOLTYPE"]=HEALBOT_SKIN_HEALTHBACKCOL_TEXT,
                                 ["HEALBARSBACKCOL"]="Background Bar Custom Col"..HEALBOT_enWORD_COLOUR_SUFFIX,
                                 ["HEALBARSBACKOUTLINE"]=HEALBOT_OPTIONS_OUTLINE,
                                 ["HEALBARSBACKALPHA"]=HEALBOT_OPTIONS_BARALPHABACK,
                                 ["HEALBARSICCOLTYPE"]=HEALBOT_OPTIONS_INCHEAL,
                                 ["HEALBARSICCOL"]="Incoming Heals Custom Col"..HEALBOT_enWORD_COLOUR_SUFFIX,
                                 ["HEALBARSICALPHA"]=HEALBOT_OPTIONS_BARALPHAINHEAL,
                                 ["HEALBARSAECOLTYPE"]=HEALBOT_SKIN_ABSORBCOL_TEXT,
                                 ["HEALBARSAECOL"]="Absorb Effects Custom Col"..HEALBOT_enWORD_COLOUR_SUFFIX,
                                 ["HEALBARSAECOLALPHA"]=HEALBOT_OPTIONS_BARALPHAABSORB,
                                 ["HEALBARSALPHAOOR"]=HEALBOT_OPTIONS_BARALPHAEOR,
                                 ["HEALBARSALPHADIS"]=HEALBOT_OPTIONS_BARALPHADIS,
                        -- Skins Frames Bars Text tab
                                 ["BARSTEXT"]="Bars Text",
                                 ["HEALBARSTXTENCOL"]=HEALBOT_SKIN_ENTEXT,
                                 ["HEALBARSTXTDISCOL"]=HEALBOT_SKIN_DISTEXT,
                                 ["HEALBARSTXTDEBUFFCOL"]=HEALBOT_SKIN_DEBTEXT,
                                 ["HEALBARSTXTCLASSCOL"]=HEALBOT_OPTIONS_BARTEXTCLASSCOLOUR1,
                                 ["HEALBARSTXTSHOWCLASS"]=HEALBOT_OPTIONS_SHOWCLASSONBAR,
                                 ["HEALBARSTXTSHOWROLE"]=HEALBOT_SHOW_ROLE,
                                 ["HEALBARSTXTSHOWCLASSICON"]=HEALBOT_SHOW_CLASS_AS_ICON,
                                 ["HEALBARSTXTSHOWCLASSTEXT"]=HEALBOT_SHOW_CLASS_AS_TEXT,
                                 ["HEALBARSTXTSHOWNAME"]=HEALBOT_OPTIONS_SHOWNAMEONBAR,
                                 ["HEALBARSTXTUTF8"]=HEALBOT_OPTIONS_ENABLELIBUTF8,
                                 ["HEALBARSTXTLINES"]=HEALBOT_OPTIONS_DOUBLETEXTLINES,
                                 ["HEALBARSTXTMAXCHARS"]=HEALBOT_OPTIONS_MAXCHARS,
                                 ["HEALBARSTXTSHOWHEALTH"]=HEALBOT_OPTIONS_SHOWHEALTHONBAR,
                                 ["HEALBARSTXTHEALTHICOPTION"]="Incoming Heals Options",
                                 ["HEALBARSTXTHEALTHTYPE"]="Display Type",
                                 ["HEALBARSTXTHEALTHFORMAT"]="Format Dropdowns",
                                 ["HEALBARSTXTTAGDC"]=HEALBOT_DISCONNECTED_LABEL.." Tag",
                                 ["HEALBARSTXTTAGRIP"]=HEALBOT_DEAD_LABEL.." Tag",
                                 ["HEALBARSTXTTAGOOR"]=HEALBOT_OUTOFRANGE_LABEL.." Tag",
                                 ["HEALBARSTXTTAGR"]=HEALBOT_RESERVED_LABEL.." Tag",
                                 ["HEALBARSTXTFONT"]=HEALBOT_OPTIONS_SKINFONT,
                                 ["HEALBARSTXTFONTHEIGHT"]=HEALBOT_OPTIONS_SKINFHEIGHT,
                                 ["HEALBARSTXTFONTOFFSET"]=HEALBOT_OPTIONS_FONT_OFFSET,
                                 ["HEALBARSTXTFONTALIGN"]=HEALBOT_OPTIONS_TEXTALIGNMENT,
                                 ["HEALBARSTXTFONTOUTLINE"]=HEALBOT_OPTIONS_SKINFOUTLINE,
                        -- Skins Frames Bars Sort tab
                                 ["BARSSORT"]="Bars Sort",
                                 ["HEALBARSSORTSELF"]=HEALBOT_OPTIONS_SUBSORTSELFFIRST,
                                 ["HEALBARSSORTOOR"]=HEALBOT_OPTIONS_SORTOORLAST,
                                 ["HEALBARSSORTMAIN"]=HEALBOT_OPTIONS_MAINSORT,
                                 ["HEALBARSSORTSUB"]=HEALBOT_OPTIONS_SUBSORT,
                                 ["HEALBARSSELFPET"]=HEALBOT_OPTIONS_OWN_PET_WITH_SELF,
                                 ["HEALBARSPETGROUP"]=HEALBOT_OPTIONS_GROUP_PETS_BY_FIVE,
                        -- Skins Frames Bars Visibility tab
                                 ["BARSVISIBILITY"]="Bars Visibility",
                                 ["HEALBARSVISALERTIC"]=HEALBOT_OPTIONS_INCOMBATALERTLEVEL,
                                 ["HEALBARSVISALERTOC"]=HEALBOT_OPTIONS_OUTCOMBATALERTLEVEL,
                                 ["HEALBARSVISHIDE100"]=HEALBOT_HIDE_BARS,
                                 ["HEALBARSVISTARGETIC"]=HEALBOT_DISABLED_TARGET.." "..HEALBOT_OPTIONS_ENTERINGCOMBAT,
                                 ["HEALBARSVISFOCUSIC"]=HEALBOT_FOCUS.." "..HEALBOT_OPTIONS_ENTERINGCOMBAT,
                                 ["HEALBARSVISTARGETFRIEND"]=HEALBOT_OPTIONS_SHOW_ONLY_FRIEND,
                                 ["HEALBARSVISEXCLUDERAID"]=HEALBOT_OPTIONS_EXCLUDE_RAID,
                                 ["HEALBARSVISFOCUSFRIEND"]=HEALBOT_OPTIONS_SHOW_ONLY_FRIEND,
                                 ["HEALBARSVISFILTER"]=HEALBOT_OPTIONS_EMERGFILTER,
                                 ["HEALBARSVISFILTERGROUPS"]=HEALBOT_OPTIONS_EMERGFILTERGROUPS,
                                 ["HEALBARSVISENEMYINCSELF"]=HEALBOT_ENEMY_INCLUDE_SELF,
                                 ["HEALBARSVISENEMYINCTANKS"]=HEALBOT_ENEMY_INCLUDE_TANKS,
                                 ["HEALBARSVISENEMYINCARENA"]=HEALBOT_ENEMY_INCLUDE_ARENA,
                                 ["HEALBARSVISENEMYINCARENAPETS"]=HEALBOT_ENEMY_INCLUDE_ARENAPETS,
                                 ["HEALBARSVISENEMYINCMYTARGETS"]=HEALBOT_ENEMY_INCLUDE_MYTARGETS,
                                 ["HEALBARSVISENEMYNUMBOSSES"]=HEALBOT_ENEMY_NUMBER_BOSSES,
                                 ["HEALBARSVISENEMYHIDEOC"]=HEALBOT_ENEMY_HIDE_OUTOFCOMBAT,
                                 ["HEALBARSVISENEMYSHOWSELF"]=HEALBOT_ENEMY_EXISTS_SHOW_PTARGETS,
                                 ["HEALBARSVISENEMYSHOWARENA"]=HEALBOT_ENEMY_EXISTS_SHOW_ARENA,
                                 ["HEALBARSVISENEMYSHOWBOSSES"]=HEALBOT_ENEMY_EXISTS_SHOW_BOSSES,
                        -- Skins Frames Bars Aggro tab
                                 ["BARSAGGRO"]="Bars Aggro",
                                 ["HEALBARSAGGROSHOW"]=HEALBOT_OPTION_AGGROTRACK,
                                 ["HEALBARSAGGROSHOWBAR"]=HEALBOT_OPTION_AGGROBAR,
                                 ["HEALBARSAGGROSHOWTEXT"]=HEALBOT_OPTION_AGGROTXT,
                                 ["HEALBARSAGGROSHOWIND"]=HEALBOT_OPTION_AGGROIND,
                                 ["HEALBARSAGGROPCTBAR"]=HEALBOT_OPTION_AGGROPCTTRACK.." "..HEALBOT_OPTION_AGGROPCTBAR,
                                 ["HEALBARSAGGROPCTTXT"]=HEALBOT_OPTION_AGGROPCTTRACK.." "..HEALBOT_OPTION_AGGROPCTTXT,
                                 ["HEALBARSAGGROINDALERT"]=HEALBOT_OPTIONS_AGGROINDALERT,
                                 ["HEALBARSAGGROBARALERT"]=HEALBOT_OPTIONS_AGGROALERT,
                                 ["HEALBARSAGGROBARCOL"]="Aggro Bar Col"..HEALBOT_enWORD_COLOUR_SUFFIX,
                                 ["HEALBARSAGGROBARFLASHFREQ"]=HEALBOT_OPTIONS_AGGROFLASHFREQ,
                                 ["HEALBARSAGGROBARFLASHMIN"]=HEALBOT_OPTIONS_AGGROFLASHALPHA.." "..HEALBOT_WORDS_MIN,
                                 ["HEALBARSAGGROBARFLASHMAX"]=HEALBOT_OPTIONS_AGGROFLASHALPHA.." "..HEALBOT_WORDS_MAX,
                                 ["HEALBARSAGGROHIGHBAR"]=HEALBOT_OPTION_HIGHLIGHTACTIVEBAR,
                                 ["HEALBARSAGGROHIGHBARIC"]=HEALBOT_OPTIONS_MONITORBUFFSC,
                                 ["HEALBARSAGGROHIGHBARCOL"]=HEALBOT_SKIN_HEADERBARCOL,
                                 ["HEALBARSAGGROTARGETBAR"]=HEALBOT_OPTION_HIGHLIGHTTARGETBAR,
                                 ["HEALBARSAGGROTARGETBARIC"]=HEALBOT_OPTIONS_MONITORBUFFSC,
                                 ["HEALBARSAGGROTARGETBARCOL"]=HEALBOT_SKIN_HEADERBARCOL,
                        -- Skins Frames Icons General tab
                                 ["ICONSGENERAL"]="Icons General",
                                 ["ICONSHOWHOT"]=HEALBOT_OPTIONS_BARBUTTONSHOWHOT,
                                 ["ICONNUMHOT"]=HEALBOT_OPTIONS_ALLSPELLS.." "..HEALBOT_OPTIONS_MAXICONS,
                                 ["ICONSHOWDEBUFF"]=HEALBOT_OPTIONS_SHOWDEBUFFICON,
                                 ["ICONNUMDEBUFF"]=HEALBOT_OPTIONS_TAB_DEBUFFS.." "..HEALBOT_OPTIONS_MAXICONS,
                                 ["ICONSHOWDIR"]=HEALBOT_OPTIONS_SHOWDIRECTION,
                                 ["ICONSHOWDIRMO"]=HEALBOT_OPTIONS_SHOWDIRECTIONMOUSE,
                                 ["ICONSHOWRC"]=HEALBOT_OPTIONS_SHOWREADYCHECK,
                                 ["ICONSHOWRT"]=HEALBOT_OPTIONS_BARBUTTONSHOWRAIDICON,
                                 ["ICONONBAR"]=HEALBOT_OPTIONS_HOTPOSITION.." "..HEALBOT_OPTIONS_HOTONBAR,
                                 ["ICONOFFBAR"]=HEALBOT_OPTIONS_HOTPOSITION.." "..HEALBOT_OPTIONS_HOTOFFBAR,
                                 ["ICONBELOWBAR"]=HEALBOT_OPTIONS_HOTPOSITION.." "..HEALBOT_OPTIONS_HOTBELOWBAR,
                                 ["ICONLEFTSIDE"]=HEALBOT_OPTIONS_HOTPOSITION.." "..HEALBOT_OPTIONS_HOTBARLEFT,
                                 ["ICONRIGHTSIDE"]=HEALBOT_OPTIONS_HOTPOSITION.." "..HEALBOT_OPTIONS_HOTBARRIGHT,
                                 ["ICONDOUBLE"]=HEALBOT_OPTIONS_DOUBLEROW,
                                 ["ICONSCALEBUFF"]=HEALBOT_OPTIONS_ICONSCALE,
                                 ["ICONSCALEDEBUFF"]=HEALBOT_OPTIONS_DEBUFFICONSCALE,
                                 ["ICONALWAYSEN"]=HEALBOT_OPTIONS_TTALPHA.." "..HEALBOT_OPTIONS_ENABLEHEALTHY,
                                 ["ICONFADE"]=HEALBOT_OPTIONS_FADEONEXPIRE,
                                 ["ICONFADESTART"]=HEALBOT_OPTIONS_FADESTARTTIME,
                        -- Skins Frames Icons Text tab
                                 ["ICONSTEXT"]="Icons Text",
                                 ["ICONTXTSHOWCOUNT"]=HEALBOT_OPTIONS_HOTSHOWTEXT.." "..HEALBOT_OPTIONS_HOTTEXTCOUNT,
                                 ["ICONTXTSHOWDUR"]=HEALBOT_OPTIONS_HOTSHOWTEXT.." "..HEALBOT_OPTIONS_HOTTEXTDURATION,
                                 ["ICONTXTDURTIME"]=HEALBOT_OPTIONS_SHOWDURATIONFROM,
                                 ["ICONTXTDURWARNTIME"]=HEALBOT_OPTIONS_SHOWDURATIONWARN,
                                 ["ICONTXTFONT"]=HEALBOT_OPTIONS_SKINFONT,
                                 ["ICONTXTFONTSIZE"]=HEALBOT_OPTIONS_SKINFHEIGHT,
                                 ["ICONTXTFONTOUTLINE"]=HEALBOT_OPTIONS_SKINFOUTLINE,
                        -- Debuffs General tab
                                 ["MONITORDEBUFFS"]=HEALBOT_OPTIONS_MONITORDEBUFFS,
                                 ["MONITORDEBUFFSIC"]=HEALBOT_OPTIONS_MONITORBUFFSC,
                                 ["MONITORDEBUFFSGROUPED"]=HEALBOT_OPTIONS_IN_A_GROUP,
                                 ["DEBUFFSSPELLTOCURE"]=HEALBOT_OPTIONS_DEBUFFTEXT1,
                                 ["DEBUFFSSPELLCHECKMEMBERS"]=HEALBOT_OPTIONS_BUFFSTEXT2,
                                 ["DEBUFFSIGNOREDEBUFFS"]="Ignore Debuffs",
                                 ["DEBUFFSTYPEPRIORITY"]=HEALBOT_WORD_PRIORITY,
                                 ["DEBUFFSTYPECOLOUR"]=HEALBOT_OPTIONS_BUFFSTEXT3,
                        -- Debuffs Custom tab
                                 ["DEBUFFSCUSTOMCAT"]=HEALBOT_CUSTOM_CATEGORY,
                                 ["DEBUFFSCUSTOMDEBUFF"]=HEALBOT_OPTIONS_TAB_CUSTOM_DEBUFFS,
                                 ["DEBUFFSCUSTOMCASTBY"]=HEALBOT_OPTIONS_CUSTOM_CASTBY,
                                 ["DEBUFFSCUSTOMREVDUR"]=HEALBOT_OPTIONS_CUSTOMDEBUFF_REVDUR,
                                 ["DEBUFFSCUSTOMDELETE"]=HEALBOT_OPTIONS_DELSKIN,
                                 ["DEBUFFSCUSTOMNEWNAME"]=HEALBOT_OPTIONS_NEWDEBUFFTEXT,
                                 ["DEBUFFSCUSTOMNEWSAVE"]=HEALBOT_OPTIONS_SAVESKIN,
                                 ["DEBUFFSCUSTOMENDIS"]=HEALBOT_WORD_DISABLE,
                                 ["DEBUFFSCUSTOMPRIORITY"]=HEALBOT_WORD_PRIORITY,
                                 ["DEBUFFSCUSTOMCOLOUR"]=HEALBOT_SKIN_HEADERBARCOL,
                                 ["DEBUFFSCUSTOMCOLOURSHOW"]=HEALBOT_SKIN_HEADERBARCOL,
                                 ["DEBUFFSCUSTOMRESET"]=HEALBOT_WORD_RESET,
                                 ["DEBUFFSCUSTOMPAGE"]="Page",
                                 ["DEBUFFSCUSTOMALLDISEASE"]=HEALBOT_OPTIONS_CUSTOM_ALLDISEASE,
                                 ["DEBUFFSCUSTOMALLMAGIC"]=HEALBOT_OPTIONS_CUSTOM_ALLMAGIC,
                                 ["DEBUFFSCUSTOMALLPOISON"]=HEALBOT_OPTIONS_CUSTOM_ALLPOISON,
                                 ["DEBUFFSCUSTOMALLCURSE"]=HEALBOT_OPTIONS_CUSTOM_ALLCURSE,
                                 ["DEBUFFSCUSTOMALLBOSS"]=HEALBOT_OPTIONS_CUSTOM_ALLBOSS,
                                 ["DEBUFFSCUSTOMALLBOSSSTRICT"]=HEALBOT_OPTIONS_CUSTOM_ALLBOSSSTRICT,
                        -- Debuffs Warning tab
                                 ["DEBUFFSWARNINGBAR"]=HEALBOT_OPTIONS_CDCSHOWHBARS,
                                 ["DEBUFFSWARNINGBARRANGE"]="Range",
                                 ["DEBUFFSWARNINGAGGRO"]=HEALBOT_OPTIONS_CDCSHOWABARS,
                                 ["DEBUFFSWARNINGAGGRORANGE"]="Range",
                                 ["DEBUFFSWARNINGSHOW"]=HEALBOT_OPTIONS_SHOWDEBUFFWARNING,
                                 ["DEBUFFSWARNINGSHOWRANGE"]="Range",
                                 ["DEBUFFSWARNINGSOUND"]=HEALBOT_OPTIONS_SOUNDDEBUFFWARNING,
                                 ["DEBUFFSWARNINGSOUNDRANGE"]="Range",
                                 ["DEBUFFSWARNINGSOUNDSELECT"]=HEALBOT_OPTIONS_SOUND,
                                 ["DEBUFFSWARNINGSOUNDPREVIEW"]=HEALBOT_OPTIONS_SOUND,
                        -- Buffs General tab
                                 ["MONITORBUFFS"]=HEALBOT_OPTIONS_MONITORBUFFS,
                                 ["MONITORBUFFSIC"]=HEALBOT_OPTIONS_MONITORBUFFSC,
                                 ["MONITORBUFFSGROUPED"]=HEALBOT_OPTIONS_IN_A_GROUP,
                                 ["BUFFSSPELL"]=HEALBOT_OPTIONS_BUFFSTEXT1,
                                 ["BUFFSMEMBERS"]=HEALBOT_OPTIONS_BUFFSTEXT2,
                                 ["BUFFSBARS"]=HEALBOT_OPTIONS_CDCBARS,
                                 ["BUFFSTIMER"]=HEALBOT_OPTIONS_BUFFSTEXTTIMER,
                        -- Buffs Custom tab
                                 ["BUFFSCUSTOMCAT"]=HEALBOT_CUSTOM_CATEGORY,
                                 ["BUFFSCUSTOMBUFF"]=HEALBOT_OPTIONS_ALLSPELLS,
                                 ["BUFFSCUSTOMCASTBY"]=HEALBOT_OPTIONS_CUSTOM_CASTBY,
                                 ["BUFFSCUSTOMDELETE"]=HEALBOT_OPTIONS_DELSKIN,
                                 ["BUFFSCUSTOMNEWNAME"]=HEALBOT_OPTIONS_NEWHOTBUFFTEXT,
                                 ["BUFFSCUSTOMNEWSAVE"]=HEALBOT_OPTIONS_SAVESKIN,
                                 ["BUFFSCUSTOMENDIS"]=HEALBOT_WORD_DISABLE,
                                 ["BUFFSCUSTOMPRIORITY"]=HEALBOT_WORD_PRIORITY,
                                 ["BUFFSCUSTOMCOLOUR"]=HEALBOT_SKIN_HEADERBARCOL,
                                 ["BUFFSCUSTOMCOLOURSHOW"]=HEALBOT_SKIN_HEADERBARCOL,
                                 ["BUFFSCUSTOMRESET"]=HEALBOT_WORD_RESET,
                                 ["BUFFSCUSTOMPAGE"]="Page",
                        -- Buffs Warning tab
                                 ["BUFFSWARNINGBAR"]=HEALBOT_OPTIONS_CDCSHOWHBARS,
                                 ["BUFFSWARNINGBARRANGE"]="Range",
                                 ["BUFFSWARNINGAGGRO"]=HEALBOT_OPTIONS_CDCSHOWABARS,
                                 ["BUFFSWARNINGAGGRORANGE"]="Range",
                                 ["BUFFSWARNINGSHOW"]=HEALBOT_OPTIONS_SHOWBUFFWARNING,
                                 ["BUFFSWARNINGSHOWRANGE"]="Range",
                                 ["BUFFSWARNINGSOUND"]=HEALBOT_OPTIONS_SOUNDBUFFWARNING,
                                 ["BUFFSWARNINGSOUNDRANGE"]="Range",
                                 ["BUFFSWARNINGSOUNDSELECT"]=HEALBOT_OPTIONS_SOUND,
                                 ["BUFFSWARNINGSOUNDPREVIEW"]=HEALBOT_OPTIONS_SOUND,
                        -- Tips tab
                                 ["TOOLTIPSHOW"]=HEALBOT_OPTIONS_SHOWTOOLTIP,
                                 ["TOOLTIPUPDATE"]=HEALBOT_OPTIONS_TOOLTIPUPDATE,
                                 ["TOOLTIPHIDEIC"]=HEALBOT_OPTIONS_DISABLETOOLTIPINCOMBAT,
                                 ["TOOLTIPTARGETINFO"]=HEALBOT_OPTIONS_SHOWUNITTOOLTIP,
                                 ["TOOLTIPMYBUFFS"]=HEALBOT_OPTIONS_SHOWUNITBUFFTIME,
                                 ["TOOLTIPSPELLDETAIL"]=HEALBOT_OPTIONS_SHOWDETTOOLTIP,
                                 ["TOOLTIPSPELLCD"]=HEALBOT_OPTIONS_SHOWCDTOOLTIP,
                                 ["TOOLTIPWHEELCMD"]=HEALBOT_OPTIONS_SHOWMOUSEWHEELTOOLTIP,
                                 ["TOOLTIPHOTREC"]=HEALBOT_OPTIONS_SHOWRECTOOLTIP,
                                 ["TOOLTIPGAMETIP"]=HEALBOT_OPTIONS_USEGAMETOOLTIP,
                                 ["TOOLTIPMONBUFFS"]=HEALBOT_OPTIONS_TOOLTIPSHOWHOT,
                                 ["TOOLTIPFONTSIZE"]=HEALBOT_OPTIONS_SKINFHEIGHT,
                                 ["TOOLTIPPOSITION"]=HEALBOT_OPTIONS_SETTOOLTIP_POSITION,
                                 ["TOOLTIPALPHA"]=HEALBOT_OPTIONS_TTALPHA,
                        -- Mouse Wheel tab
                                 ["BUFFSMOUSEWHEELUSE"]=HEALBOT_OPTIONS_MOUSEWHEEL,
                                 ["BUFFSMOUSEWHEELCMD"]="Mouse Wheel Commands",
                                 ["BUFFSMOUSEWHEELEMOTE"]="Mouse Wheel Emotes",
                        -- Test tab
                                 ["TESTUSE"]=HEALBOT_OPTIONS_TESTBARS,
                                 ["TESTPROFILE"]=HEALBOT_WORDS_PROFILE,
                                 ["TESTNUMTOTAL"]=HEALBOT_OPTION_NUMBARS,
                                 ["TESTNUMTANKS"]=HEALBOT_OPTION_NUMTANKS,
                                 ["TESTNUMHEALS"]=HEALBOT_OPTION_NUMHEALERS,
                                 ["TESTNUMMYTARGETS"]=HEALBOT_OPTION_NUMMYTARGETS,
                                 ["TESTNUMPETS"]=HEALBOT_OPTION_NUMPETS,
                                 ["TESTNUMENEMY"]=HEALBOT_OPTION_NUMENEMYS,
                        -- Import/Export Skins tab
                                 ["INOUTSELECTSKIN"]=HEALBOT_OPTIONS_EXPORTSKIN,
                                 ["INOUTEXPORTSKIN"]=HEALBOT_OPTIONS_BUTTONEXPORT,
                                 ["INOUTIMPORTSKIN"]=HEALBOT_OPTIONS_BUTTONIMPORT,
                        -- Import/Export Custom Debuffs tab
                                 ["INOUTEXPORTCDEBUFF"]=HEALBOT_OPTIONS_BUTTONEXPORT,
                                 ["INOUTIMPORTCDEBUFFMETHOD"]=HEALBOT_OPTIONS_BUTTONIMPORTMETHOD,
                                 ["INOUTIMPORTCDEBUFF"]=HEALBOT_OPTIONS_BUTTONIMPORT,
                        -- Import/Export Custom Buffs tab
                                 ["INOUTEXPORTCBUFF"]=HEALBOT_OPTIONS_BUTTONEXPORT,
                                 ["INOUTIMPORTCBUFFMETHOD"]=HEALBOT_OPTIONS_BUTTONIMPORTMETHOD,
                                 ["INOUTIMPORTCBUFF"]=HEALBOT_OPTIONS_BUTTONIMPORT,
                        -- Import/Export Spells tab
                                 ["INOUTEXPORTSPELLS"]=HEALBOT_OPTIONS_BUTTONEXPORT,
                                 ["INOUTIMPORTSPELLSMETHOD"]=HEALBOT_OPTIONS_BUTTONIMPORTMETHOD,
                                 ["INOUTIMPORTSPELLS"]=HEALBOT_OPTIONS_BUTTONIMPORT,
                        -- Import/Export Preset Colours tab
                                 ["INOUTEXPORTPRESETCOLS"]=HEALBOT_OPTIONS_BUTTONEXPORT,
                                 ["INOUTIMPORTPRESETCOLS"]=HEALBOT_OPTIONS_BUTTONIMPORT,
                              }
    HEALBOT_OPTIONS_HELP_TEXT={
                        -- Preset Colours
                               ["PRESETCOLS"]="Select a Prefix Col"..HEALBOT_enWORD_COLOUR_SUFFIX..".\nUp to 10 Prefix Col"..HEALBOT_enWORD_COLOUR_SUFFIX.."s can be defined.",
                               ["PRESETCOLALIAS"]="Set a meaningful name for the Prefix Col"..HEALBOT_enWORD_COLOUR_SUFFIX..".",
                               ["PRESETCOLSET"]="Click to set the Preset Col"..HEALBOT_enWORD_COLOUR_SUFFIX..".",
                               ["PRESETCOLSELECT"]="Click to select the Preset Col"..HEALBOT_enWORD_COLOUR_SUFFIX..".",
                               ["PRESETCOLCANCEL"]="Click to leave without selecting a Preset Col"..HEALBOT_enWORD_COLOUR_SUFFIX..".",
                        -- General tab
                               ["HIDEOPTIONBUTTON"]="Hide the options button that is\nshown at the bottom of the 1st frame.",
                               ["RIGHTTOOPENOPTIONS"]="Right click on the edge of\na frame will open options.",
                               ["SHOWMINIMAPBUTTON"]="Show a button on the minimap\nthat will open options.",
                               ["QUERYTALENTS"]="Query talent information when\nthe mouse moves over a bar.\nNOTE: This is only used by tooltips.",
                               ["ENABLEFASTHEALTH"]="Monitor combat log and\nupdate health when required.",
                               ["ENABLEAUTOCOMBAT"]="Put healbot into lockdown combat mode when\nanyone in the group/raid goes into combat.",
                               ["IGNOREAURAEVENTS"]="Ignore required buffs when resting.",
                               ["DISABLEHEALBOT"]="Put Healbot into a deep sleep.",
                               ["DISABLEHEALBOTSOLO"]="Healbot is only sleeping when\nnot in a group or raid.",
                               ["ADJUSTMAXHLTH"]="Check for boss debuffs that alters healing\neffects and adjust max health to reflect.",
                               ["MAXBARCACHE"]="Bars within frames can be initialized and cached before joining a group or raid.\n--\nRecommended settings:\n- [5] - You never raid.\n- [10] - You only join 10 man raids.\n- [20-25] - You regularly join 25 man raids.\n- [25-40] - You regularly join 40 man raids.\n--\nNOTE: This is a pre-cache and once a bar is initialized, it is never destroyed\nIf you pre-cache 5 bars and join a 25 man raid, you will end up with a pool of 25+ reusable bars\nHaving a large pool of bars is far more valuable than saving a tiny amount of memory.",
                               ["INTERNALTIMERS"]="This combined with your FPS sets how\nquickly the following are updated:\n- Range checking\n- Buff checking\n- Debuff checking\n- fastHealth updates\n- Aggro updates\n- Enemy bar updates\n- Fluid bars update frequency\n- Aggro bars flash frequency\n- General checks and out of combat updates",
                               ["LANG"]="Select the language used by healbot options.\nThis can be independent to the UI.",
                               ["SETLANG"]="Set the language selected.",
                               ["CMDS"]="Select a command to run.\nMany commands allow for resetting parts of\nhealbot without the need to reset to defaults.",
                               ["RUNCMDS"]="Run the command selected.",
                               ["PROFILE"]="Select to use Class or Character for saving\nsettings related to Spells, Buffs and Debuffs.",
                               ["SETPROFILE"]="Set the profile selected.",
                               ["CLASSTYPES"]="Classes can be grouped as Melee, Ranged, Healers and Custom.\nGroups of classes are available in options:\n- Bars Visibility\n- General Debuffs\n- General Buffs\n--\nThese settings date back to Classic and have little use in today's WoW.\nThey have near zero overhead and so are kept as some might find them useful.",
                        -- Spells tab
                               ["SETSPELLSFOR"]="Set spells that can be used in different states:\n* Enabled - Always when in combat and any time the bar is in an enabled state.\n* Disabled - Only when out of combat and the bar is in a disabled state.\n* Enemy - Allows for harmful spells to be set and used on enemy bars.",
                               ["ALWAYSUSEENABLED"]="Use this option to always cast enabled\nspells regardless of the bar state.",
                               ["SPELLSBUTTON"]="The button press to cast a spell.",
                               ["SPELLSBUTTONCAST"]="Timing of the spell cast\nCast when the button is Pressed or Released.",
                               ["SPELLSAVOIDBLUE"]="Cast Binding Heal on yourself and ended up\nwith a blue cursor? this option is your friend.",
                               ["SPELLSAUTOTARGET"]="Set the healers target to the player/npc\nreceiving the current spell cast.",
                               ["SPELLSAUTOTRINKET"]="Attempt to use trinkets automatically when casting spells.",
                               ["SPELLSBUTTONCLICK"]="Spell to cast on button click.",
                               ["SPELLSBUTTONSHIFTCLICK"]="Spell to cast on button click\nwith the SHIFT key held down.",
                               ["SPELLSBUTTONCTRLCLICK"]="Spell to cast on button click\nwith the CTRL key held down.",
                               ["SPELLSBUTTONALTCLICK"]="Spell to cast on button click\nwith the ALT key held down.",
                               ["SPELLSBUTTONSHIFTCTRLCLICK"]="Spell to cast on button click with\nthe SHIFT and CTRL key held down.",
                               ["SPELLSBUTTONSHIFTALTCLICK"]="Spell to cast on button click with\nthe SHIFT and ALT key held down.",
                               ["SPELLSBUTTONCTRLALTCLICK"]="Spell to cast on button click with\nthe CTRL and ALT key held down.",
                               ["SPELLSHELPSELECT"]="Displays dropdowns for selecting various\nspells, macros and other commands.",
                               ["SPELLSSELECTSPELL"]="Select a spell for the spells tab.",
                               ["SPELLSSELECTMACRO"]="Select a macro for the spells tab.",
                               ["SPELLSSELECTITEMS"]="Select an item for the spells tab.",
                               ["SPELLSSELECTCMDS"]="Select a command for the spells tab.",
                               ["SPELLSSELECTCANCEL"]="Do not select anything and\nreturn to the spells tab.",
                               ["SMARTCAST"]="Select and cast an appropriate spell for the situation.\nThis only works out of combat.",
                               ["SMARTCASTAVOIDPVP"]="Do not use SmartCast\non PVP flagged players.",
                               ["SMARTCASTDEBUFF"]="Use SmartCast to remove debuffs.",
                               ["SMARTCASTBUFF"]="Use SmartCast to apply buffs.",
                               ["SMARTCASTHEAL"]="Use SmartCast to cast healing type spells.",
                               ["SMARTCASTRES"]="Use SmartCast to cast resurrection type spells.",
                        -- Skins top
                               ["SELECTSKIN"]="Select the skin you want to use.",
                               ["DELSKIN"]="Delete the current skin.\nNote: The standard skin cannot be deleted.",
                               ["NEWSKIN"]="Enter a name for a new skin that will\nbe based on the currently selected skin.",
                               ["SAVENEWSKIN"]="Create a new skin based on the currently selected skin.",
                               ["SELECTFRAME"]="Select from a list of 10 frames.\nFrame options will be displayed and\ncan be updated for the current selected frame",
                               ["FRAMEAPPLYTAB"]="An easy way to set the current tab options to all frames.",
                        -- Skins General tab
                               ["SKINDEFAULTFOR"]="Set when the skin is displayed.\nNote: This setting is Per Character.",
                               ["STICKFRAMES"]="When turned on a frame will stick to\nanother frame higher up in the list.\nLocked frames will remain stuck.\nUnlocked frames can be moved away.\n--\nTIP: Use the 1st frame as your main frame\nmove other frames to your main frame\nand when stuck lock them.",
                               ["STICKSENSITIVITY"]="The higher the sensitivity the closer you need to get for a frame to stick to another frame.\n--\nTIP: Use test bars to see if the sensitivity is correct for your frames.\nTurn On/Off/On test bars to see if the frames remain in place.\n- High sensitivity can lead to frames becoming unstuck on reload/logon\n- Low sensitivity can lead to a frame attaching to a different frame on reload/logon\n* Start with a high sensitivity and lower if required.",
                               ["HIDEBLIZPARTYFRAMES"]="Hide the standard Blizzard party frames\noptionally include the player and pet frames.\nNote: Changing this setting requires a UI Reload.",
                               ["HIDEBLIZBOSSFRAMES"]="Hide the standard Blizzard boss frames.\nNote: Changing this setting requires a UI Reload.",
                               ["HIDEBLIZRAIDFRAMES"]="Hide the standard Blizzard raid frames.\nNote: Changing this setting requires a UI Reload.",
                               ["USEFLUIDBARS"]="Bar updates due to health changes are done in a fluid motion.",
                               ["FLUIDBARSREFRESHSPEED"]="Controls how fast the bar updates.\nSlower is smoother as Faster skips steps.\nTIP: For a smooth yet fast fluid update:\nFirst increse Internal Timers and Updates on the General tab.",
                        -- Skins Protection tab
                               ["USECRASHPROT"]="Crash protection guards against the negative\neffects of a healbot user disconnecting during combat.\nA small number of macro slots will store current\ngroup/raid data that can be used on logon during combat.",
                               ["USECRASHPROTGENERALMACRO"]="Use global macro slots rather than per character.\nTo reduce overall usage this option is recommended\nwhen using Healbot on multiple characters.",
                               ["USECRASHPROTBASEMACRO"]="Set a common text string to be\nused at the start of the macro names.",
                               ["USECRASHPROTLOGONDURATION"]="Set how long protection data is valid after logon.",
                               ["USECOMBATPROT"]="Combat protection reserves bars to guard against random\nmembers leaving/joining the group/raid during combat.\nThis option will reserve bars to make up\nthe numbers to standard group or raid sizes.",
                               ["USECOMBATPROTGROUP"]="Use Combat Protection in Groups.",
                               ["USECOMBATPROTRAID"]="Use Combat Protection in Raids.",
                        -- Skins Chat tab
                               ["CHATNONE"]="Do not send chat messages.",
                               ["CHATSELF"]="Send chat messages only to yourself, good for testing.",
                               ["CHATTARGET"]="Send whisper to the target.",
                               ["CHATPARTY"]="Send chat message to the group channel.",
                               ["CHATRAID"]="Send chat message to the raid channel.",
                               ["CHATCHAN"]="Send chat message to your own general channel.",
                               ["CHATRESONLY"]="Send chat messages only when casting resurrection type spells.",
                               ["CHATMSG"]="The format of the message to send.\n#s is substituted with the spell name.\n#n is substituted with the players name.",
                               ["EOCOOM"]="When enabled and mana drops below the select amount.\nAt the end of combat emote Out of Mana.",
                        -- Skins Frames General tab
                               ["GOTOHEALGROUPS"]="Go to the Heal Groups tab.",
                               ["FRAMEALIAS"]="Give the frame a meaningful alias.\nAliases are shown on the Heal Groups tab",
                               ["FRAMELOCKED"]="Lock the frame at the current position.\nNote: If the frame is locked and stuck to another frame\nthe frame will remain stuck and cannot be unstuck.",
                               ["FRAMEAUTOSHOW"]="Hide the frame when out of combat and\nnone of the bars are in an enabled state.",
                               ["FRAMEAUTOSHOWSOUND"]="Play a bell sound when opening the frame.",
                               ["FRAMEANCHOR"]="The position of the frame anchor relative to the screen.\nNote: When the frame is stuck to another frame\nthis setting is automatically updated\nand used to store the frames location.",
                               ["BARANCHOR"]="The position of the bars anchor relative to the frame.",
                               ["BARGROWDIRECTION"]="The direction the bars grow away from the bars anchor.",
                               ["BARORIENTATION"]="The direction each bar will shrink/grow depending on the players health.",
                               ["FRAMESCALE"]="The scale of the current frame.",
                               ["SFOFFSETH"]="Set the horizontal offset of this frame\nwhen this frame is stuck to another frame.",
                               ["SFOFFSETV"]="Set the vertical offset of this frame\nwhen this frame is stuck to another frame.",
                               ["FRAMEBACKCOL"]="Set the background col"..HEALBOT_enWORD_COLOUR_SUFFIX.." for the frame.",
                               ["FRAMEBORDERCOL"]="Set the border for the frame.",
                               ["TOOLTIPPOSITION"]="The location of the tooltip relative to the frame.",
                        -- Skins Frames Heal Groups tab
                               ["SELECTFRAMEFORGROUP"]="Select a frame for the group.",
                               ["ENABLEHEALGROUP"]="Include/Exclude the heal group.",
                               ["HEALGROUPDOWN"]="Move the heal group down.\nHeal Groups sharing frames are initially\nsorted by the order of this list.",
                               ["HEALGROUPUP"]="Move the heal group up.\nHeal Groups sharing frames are initially\nsorted by the order of this list.",
                        -- Skins Frames Headers Bars tab
                               ["BARHEADERS"]="Show the Skins Frames Headers Bars tab.",
                               ["HEADERBARSSHOW"]="Turn On/Off displaying the bars headers.\n- For the raid heal group the header is based on main sort.\n- For other heal groups the header is the heal group name.",
                               ["HEADERBARSBARCOL"]="Set the bar col"..HEALBOT_enWORD_COLOUR_SUFFIX.." for the header bars.",
                               ["HEADERBARSTEXTCOL"]="Set the text col"..HEALBOT_enWORD_COLOUR_SUFFIX.." shown on the header bars.",
                               ["HEADERBARSTEXTURE"]="Set the texture for the header bars.",
                               ["HEADERBARSHEIGHT"]="Set the height for the header bars.",
                               ["HEADERBARSWIDTH"]="Set the width for the header bars.\nThis is based on the bars width.",
                               ["HEADERBARSFONTNAME"]="Set the font for the text\ndisplayed on the header bars.",
                               ["HEADERBARSFONTHEIGHT"]="Set the font size for the text\ndisplayed on the header bars.",
                               ["HEADERBARSFONTOUTLINE"]="Set the font outline for the text\ndisplayed on the header bars.",
                               ["HEADERBARSFONTOFFSET"]="Vertically offset the header text.",
                        -- Skins Frames Headers Frames tab
                               ["FRAMEHEADERS"]="Show the Skins Frames Headers Frames tab.",
                               ["HEADERFRAMESTITLE"]="Set the text to be displayed for the frame.",
                               ["HEADERFRAMESSHOW"]="Turn On/Off displaying the frames headers.",
                               ["HEADERFRAMESBARCOL"]="Set the bar col"..HEALBOT_enWORD_COLOUR_SUFFIX.." for the frames header.",
                               ["HEADERFRAMESTEXTCOL"]="Set the text col"..HEALBOT_enWORD_COLOUR_SUFFIX.." shown on the frames header.",
                               ["HEADERFRAMESTEXTURE"]="Set the texture for the frames header.",
                               ["HEADERFRAMESHEIGHT"]="Set the height for the frames header.",
                               ["HEADERFRAMESWIDTH"]="Set the width for the frames header.\nThis is based on the frames width.",
                               ["HEADERFRAMESFONTNAME"]="Set the font for the text\ndisplayed on the frames header.",
                               ["HEADERFRAMESFONTHEIGHT"]="Set the font size for the text\ndisplayed on the frames header.",
                               ["HEADERFRAMESFONTOUTLINE"]="Set the font outline for the text\ndisplayed on the frames header.",
                               ["HEADERFRAMESFONTOFFSET"]="Vertically offset the header text.",
                        -- Skins Frames Bars General tab
                               ["BARSGENERAL"]="Show the Skins Frames Bars General tab.\nNote: Some options are dependant on the frame selected.\n- Low mana indicator settings are not available when the Enemy frame is selected.",
                               ["HEALBARSTEXTURE"]="Set the texture for the heal bars.",
                               ["HEALBARSNUMCOLS"]="Controls how many columns will be displayed.",
                               ["HEALBARSGRPSPERCOLS"]="Sets using the number of groups for each column.",
                               ["HEALBARSHEIGHT"]="Set the height for the heal bars.",
                               ["HEALBARSWIDTH"]="Set the width for the heal bars.",
                               ["HEALBARSBRSPACE"]="Set the space between each row.",
                               ["HEALBARSBCSPACE"]="Set the space between each column.",
                               ["HEALBARSAGGROSIZE"]="Set the size of the aggro bars\ndisplayed above and below the heal bar.",
                               ["HEALBARSPOWERSIZE"]="Set the size of the power/mana\nbar displayed below the heal bar.",
                               ["HEALBARSPOWERCOUNT"]="Show power indicator at\nthe bottom of the heal bar.",
                               ["HEALBARSLOWMANA"]="Set if and when indicators are\ndisplayed to show a player is low on mana.",
                               ["HEALBARSLOWMANAIC"]="Turn On/Off displaying the low\nmana indicator while in combat.",
                        -- Skins Frames Bars Colours tab
                               ["BARSCOLOUR"]="Show the Skins Frames Bars col"..HEALBOT_enWORD_COLOUR_SUFFIX.." tab.",
                               ["HEALBARSCOLHEALTHTYPE"]="Set the col"..HEALBOT_enWORD_COLOUR_SUFFIX.." of the heal bar.\nWhen custom is used click on the custom bar to set the col"..HEALBOT_enWORD_COLOUR_SUFFIX..".",
                               ["HEALBARSCOLHEALTH"]="Set the custom bar col"..HEALBOT_enWORD_COLOUR_SUFFIX.." for the heal bars.",
                               ["HEALBARSCOLALPHA"]="Set the transparency of the\nheal bar when in an enabled state.",
                               ["HEALBARSBACKCOLTYPE"]="Set the col"..HEALBOT_enWORD_COLOUR_SUFFIX.." of the background bar.\nWhen custom is used click on the custom bar to set the col"..HEALBOT_enWORD_COLOUR_SUFFIX..".",
                               ["HEALBARSBACKCOL"]="Set the custom bar col"..HEALBOT_enWORD_COLOUR_SUFFIX.." for the background bars.",
                               ["HEALBARSBACKOUTLINE"]="Set the background bar to be slightly larger than the heal bar.",
                               ["HEALBARSBACKALPHA"]="Set the transparency of the background bar.",
                               ["HEALBARSICCOLTYPE"]="Set the col"..HEALBOT_enWORD_COLOUR_SUFFIX.." of the incoming heals.\nWhen custom is used click on the custom bar to set the col"..HEALBOT_enWORD_COLOUR_SUFFIX..".",
                               ["HEALBARSICCOL"]="Set the custom col"..HEALBOT_enWORD_COLOUR_SUFFIX.." for incoming heals.",
                               ["HEALBARSICALPHA"]="Set the transparency of incoming heals.",
                               ["HEALBARSAECOLTYPE"]="Set the col"..HEALBOT_enWORD_COLOUR_SUFFIX.." of the absorb effects.\nWhen custom is used click on the custom bar to set the col"..HEALBOT_enWORD_COLOUR_SUFFIX..".",
                               ["HEALBARSAECOL"]="Set the custom col"..HEALBOT_enWORD_COLOUR_SUFFIX.." for absorb effects.",
                               ["HEALBARSAECOLALPHA"]="Set the transparency of absorb effects.",
                               ["HEALBARSALPHAOOR"]="Set the transparency of the heal bars when the bar\nis in an enabled state and the player is out of range.",
                               ["HEALBARSALPHADIS"]="Set the transparency of the heal bar\nwhen the bar is in an disabled state.",
                        -- Skins Frames Bars Text tab
                               ["BARSTEXT"]="Show the Skins Frames Bars Text tab.",
                               ["HEALBARSTXTENCOL"]="Set the font col"..HEALBOT_enWORD_COLOUR_SUFFIX.." on enabled bars.\nNote: this option is not available when Col"..HEALBOT_enWORD_COLOUR_SUFFIX.." text by class is selected.",
                               ["HEALBARSTXTDISCOL"]="Set the font col"..HEALBOT_enWORD_COLOUR_SUFFIX.." on disabled bars.\nNote: this option is not available when Col"..HEALBOT_enWORD_COLOUR_SUFFIX.." text by class is selected.",
                               ["HEALBARSTXTDEBUFFCOL"]="Set the font col"..HEALBOT_enWORD_COLOUR_SUFFIX.." on debuff bars.\nNote: this option is not available when Col"..HEALBOT_enWORD_COLOUR_SUFFIX.." text by class is selected.",
                               ["HEALBARSTXTCLASSCOL"]="The text col"..HEALBOT_enWORD_COLOUR_SUFFIX.." will always be col"..HEALBOT_enWORD_COLOUR_SUFFIX.."ed by class.\nNote: this option disables the 3 bars at the bottom of the tab.",
                               ["HEALBARSTXTSHOWCLASS"]="Include the class on the bar.",
                               ["HEALBARSTXTSHOWROLE"]="Show the players role in the group/raid when available.\nNote: This replaces the class.",
                               ["HEALBARSTXTSHOWCLASSICON"]="Show the class/role as an icon.",
                               ["HEALBARSTXTSHOWCLASSTEXT"]="Show the class/role as text.",
                               ["HEALBARSTXTSHOWNAME"]="Show the players name on the bar.",
                               ["HEALBARSTXTUTF8"]="Improve compatibility with international characters.\nNote: when on an English only server it is recommended to turn this off.",
                               ["HEALBARSTXTLINES"]="Use 2 lines for text, this is generally\nthe name on the 1st line and health on the 2nd.",
                               ["HEALBARSTXTMAXCHARS"]="Set the maximum number of characters shown on the heal bar.\nAuto will generally calculate the maximum number of characters\nto fit within the bar when standard fonts are used.",
                               ["HEALBARSTXTSHOWHEALTH"]="Show the players health on the bar.",
                               ["HEALBARSTXTHEALTHICOPTION"]="Various options for incoming heals and absorbs.\n- No Incoming Heals - Never show incoming heals and absorbs\n- Include incoming heals - Include incoming heals in the health text when health is below 100%\n- Separate incoming heals - Show incoming heals next to the health text when health is below 100%\n- Always Include incoming heals - Always incoming heals in the health text\n- Always Separate incoming heals - Always show incoming heals next to the health text\n- Include incoming heals and absorbs - Include incoming heals and absorbs in the health text when health is below 100%\n- Separate incoming heals and absorbs - Show incoming heals and absorbs next to the health text when health is below 100%\n- Always include incoming heals and absorbs - Always incoming heals and absorbs in the health text\n- Always separate incoming heals and absorbs - Always show incoming heals and absorbs next to the health text",
                               ["HEALBARSTXTHEALTHTYPE"]="Various options on how the health is displayed.",
                               ["HEALBARSTXTHEALTHFORMAT"]="Various options on the number format for health.",
                               ["HEALBARSTXTTAGDC"]="Display a tag before the characters name when the player is "..HEALBOT_DISCONNECTED_LABEL..".",
                               ["HEALBARSTXTTAGRIP"]="Display a tag before the characters name when the player is "..HEALBOT_DEAD_LABEL..".",
                               ["HEALBARSTXTTAGOOR"]="Display a tag before the characters name when the player is "..HEALBOT_OUTOFRANGE_LABEL..".",
                               ["HEALBARSTXTTAGR"]="Display a tag before the characters name when the bar is "..HEALBOT_RESERVED_LABEL..".",
                               ["HEALBARSTXTFONT"]="Set the font for the text\ndisplayed on the heal bar.",
                               ["HEALBARSTXTFONTHEIGHT"]="Set the font size for the text\ndisplayed on the heal bars.",
                               ["HEALBARSTXTFONTOFFSET"]="Vertically offset the bar text.",
                               ["HEALBARSTXTFONTALIGN"]="Horizontally set the bar text.",
                               ["HEALBARSTXTFONTOUTLINE"]="Set the font outline for the text\ndisplayed on the heal bars.",
                        -- Skins Frames Bars Sort tab
                               ["BARSSORT"]="Show the Skins Frames Bars Sort tab.\nNote: Some options are dependant on the frame selected.\n- Sub sort - self first is only available when one of the User frames is selected.\n- Own pet: with self and Pets: Groups of five are only available when the Pets frame is selected.\n- This tab is not available when the Target frame or Focus frame is selected.",
                               ["HEALBARSSORTSELF"]="Sub sort self to the top of the list.\nNote: also applies to Main sort when sorting by Name or Max health.",
                               ["HEALBARSSORTOOR"]="This option is good for raids that split players, by sorting the out of range last.",
                               ["HEALBARSSORTMAIN"]="Organise how bars are sorted in the Heal Groups.",
                               ["HEALBARSSORTSUB"]="Organise how bars are sub sorted in the Main Sort.",
                               ["HEALBARSSELFPET"]="Place your own pet in the Self heal group.\nEnsure Self is turned on and high up in the Heal Groups list.",
                               ["HEALBARSPETGROUP"]="Treat pets as being in groups of five.",
                        -- Skins Frames Bars Visibility tab
                               ["BARSVISIBILITY"]="Show the Skins Frames Bars Visibility tab.\nNote: Some options are dependant on the frame selected.\n- Target settings are only available when the Target frame is selected.\n- Focus settings are only available when the Focus frame is selected.\n- Enemy settings are only displayed when the Enemy frame is selected.",
                               ["HEALBARSVISALERTIC"]="While in combat and when health is at or\nbelow this setting, the bar will become enabled.",
                               ["HEALBARSVISALERTOC"]="While out of combat and when health is at or\nbelow this setting, the bar will become enabled.",
                               ["HEALBARSVISHIDE100"]="Hide bars for players who are over 100 yards\ngenerally when not in visible in plain sight.",
                               ["HEALBARSVISTARGETIC"]="Always Show/No Change/Always Hide\nthe target frame when entering combat.\nNote: select the target frame to enable these settings.",
                               ["HEALBARSVISFOCUSIC"]="Always Show/No Change/Always Hide\nthe focus frame when entering combat.\nNote: select the focus frame to enable these settings.",
                               ["HEALBARSVISTARGETFRIEND"]="Do not show hostile targets when out of combat.",
                               ["HEALBARSVISEXCLUDERAID"]="Do not show yourself or members of your group/raid when out of combat.",
                               ["HEALBARSVISFOCUSFRIEND"]="Do not show hostile focus when out of combat.",
                               ["HEALBARSVISFILTER"]="Various classes and types can be filtered out using the dropdown.",
                               ["HEALBARSVISFILTERGROUPS"]="Groups can be filtered out using these check boxes.",
                               ["HEALBARSVISENEMYINCSELF"]="Include an enemy bar for your targets.",
                               ["HEALBARSVISENEMYINCTANKS"]="Include enemy bars for all tanks targets.",
                               ["HEALBARSVISENEMYINCARENA"]="Include enemy bars for player opponents in an arena.",
                               ["HEALBARSVISENEMYINCARENAPETS"]="Include enemy bars for pet opponents in an arena.",
                               ["HEALBARSVISENEMYINCMYTARGETS"]="Include enemy bars for all of My Targets targets.",
                               ["HEALBARSVISENEMYNUMBOSSES"]="Maximum number of bars to show for bosses.",
                               ["HEALBARSVISENEMYHIDEOC"]="Hide the bars when out of combat as they will often be empty and reserved.",
                               ["HEALBARSVISENEMYSHOWSELF"]="On entering combat only display bars when an enemy exists.\nAllows filtering of bars that will not likely turn up during combat.\n--\nPlayer target bars - Only display your target as an enemy if the target is hostile at the start of combat.",
                               ["HEALBARSVISENEMYSHOWARENA"]="On entering combat only display bars when an enemy exists.\nAllows filtering of bars that will not likely turn up during combat.\n--\nArena opponent bars - Only display bars for existing opponents at the start of combat.",
                               ["HEALBARSVISENEMYSHOWBOSSES"]="On entering combat only display bars when an enemy exists.\nAllows filtering of bars that will not likely turn up during combat.\n--\nBoss bars - Only display bars for existing bosses at the start of combat.",
                        -- Skins Frames Bars Aggro tab
                               ["BARSAGGRO"]="Show the Skins Frames Aggro Sort tab.\nNote: This tab is not available when the Enemy frame is selected.",
                               ["HEALBARSAGGROSHOW"]="Turn On/Off monitoring aggro.",
                               ["HEALBARSAGGROSHOWBAR"]="Display aggro bars when a player has aggro.",
                               ["HEALBARSAGGROSHOWTEXT"]="Display » text « when a player has aggro.",
                               ["HEALBARSAGGROSHOWIND"]="Display small round icons on the bar when a player has aggro.",
                               ["HEALBARSAGGROPCTBAR"]="Track percentage - Display the amount of aggro a player has.\nMove bar - Increase the aggro bar size when aggro increases.",
                               ["HEALBARSAGGROPCTTXT"]="Track percentage - Display the amount of aggro a player has.\nShow text - Display text using the format selected in the dropdown.",
                               ["HEALBARSAGGROINDALERT"]="When using the indicator.\nDisplay when the treat reaches the level selected in the dropdown.",
                               ["HEALBARSAGGROBARALERT"]="When using the aggro bars.\nDisplay when the treat reaches the level selected in the dropdown.",
                               ["HEALBARSAGGROBARCOL"]="Set the colour of the aggro bars when the player has aggro.",
                               ["HEALBARSAGGROBARFLASHFREQ"]="Set the speed the aggro bars flash.\nNote: faster means skipping steps in the update.\nFor a faster and smoother update first increase Internal Timers and Updates on the General Tab.",
                               ["HEALBARSAGGROBARFLASHMIN"]="To give the effect of flashing, aggro bars increase and decrease transparency in steps.\nMin - The minimum opacity.",
                               ["HEALBARSAGGROBARFLASHMAX"]="To give the effect of flashing, aggro bars increase and decrease transparency in steps.\nMax - The maximum opacity.",
                               ["HEALBARSAGGROHIGHBAR"]="Turn On/Off displaying the aggro bars when the mouse moves over the bar.",
                               ["HEALBARSAGGROHIGHBARIC"]="Turn On/Off highlighting mouseover when in combat.",
                               ["HEALBARSAGGROHIGHBARCOL"]="Set the colour of the aggro bars for mouseover.",
                               ["HEALBARSAGGROTARGETBAR"]="Turn On/Off displaying the aggro bars on the current target.",
                               ["HEALBARSAGGROTARGETBARIC"]="Turn On/Off highlighting the current target when in combat.",
                               ["HEALBARSAGGROTARGETBARCOL"]="Set the colour of the aggro bars for target.",
                        -- Skins Frames Icons General tab
                               ["ICONSGENERAL"]="Show the Skins Frames Icons General tab.",
                               ["ICONSHOWHOT"]="Show heal over time icons that\nare defined on the Buffs Custom tab.",
                               ["ICONNUMHOT"]="Select the maximum number\nof buff and HoT icons to show.",
                               ["ICONSHOWDEBUFF"]="Show debuff icons that are\ndefined on the Debuff Custom tab.",
                               ["ICONNUMDEBUFF"]="Select the maximum number of debuff\nand Role/Class, Target Marker icons to show.",
                               ["ICONSHOWDIR"]="Show a direction arrow pointing at players out of range.\nNote: This only works outside.",
                               ["ICONSHOWDIRMO"]="Only show the direction arrow\nwhen the mouse is over the bar.",
                               ["ICONSHOWRC"]="Shows the ready check status.",
                               ["ICONSHOWRT"]="Show the raid target when assigned to a player.\nThe target types can be individually filtered.",
                               ["ICONONBAR"]="Set the position of icons relative to the bar.\nOn bar - Position icons on the bar.",
                               ["ICONOFFBAR"]="Set the position of icons relative to the bar.\nOff bar - Position icons to the sides of the bar.",
                               ["ICONBELOWBAR"]="Set the position of icons relative to the bar.\nBelow bar - Position icons below the bar.",
                               ["ICONLEFTSIDE"]="Set the position of icons relative to the bar.\nLeft side - Position helpful icons on the left side\nand harmful/information icons on the right.",
                               ["ICONRIGHTSIDE"]="Set the position of icons relative to the bar.\nRight side - Position helpful icons on the right side\nand harmful/information icons on the left.",
                               ["ICONDOUBLE"]="Show 2 rows of icons taking less horizontal space.\nNote: Icon scale is halved when using this setting.",
                               ["ICONSCALEBUFF"]="The buff icon scale relative to the bar.\nNote: The scale is halved when using Double row.",
                               ["ICONSCALEDEBUFF"]="The debuff icon scale relative to the bar.\nNote: The scale is halved when using Double row.",
                               ["ICONALWAYSEN"]="Always use enabled bar opacity setting even\nwhen the bar is using a different setting.",
                               ["ICONFADE"]="Fade the icon as it begins to expire.",
                               ["ICONFADESTART"]="The number of seconds before expiry when the icon fades.\n--\nNOTE: The fade is gradual and generally not noticeable for the first few seconds.",
                        -- Skins Frames Icons Text tab
                               ["ICONSTEXT"]="Show the Skins Frames Icons Text tab.",
                               ["ICONTXTSHOWCOUNT"]="Set the type of text and conditions met to show text on the icon.\nCount - Show the number of stacks, for all casters or own casts if Self casts only is on.",
                               ["ICONTXTSHOWDUR"]="Set the type of text and conditions met to show text on the icon.\nDuration - Show the duration remaining, for all casters or own casts if Self casts only is on.",
                               ["ICONTXTDURTIME"]="Only show the duration when the remaining\nduration is under the slider amount.",
                               ["ICONTXTDURWARNTIME"]="Change the text colour to red for buffs and green for debuffs\nwhen the remaining duration is under the slider amount.",
                               ["ICONTXTFONT"]="Set the font for the text\ndisplayed on the icons.",
                               ["ICONTXTFONTSIZE"]="Set the font size for the\ntext displayed on the icons.",
                               ["ICONTXTFONTOUTLINE"]="Set the font outline for the\ntext displayed on the icons.",
                        -- Debuffs General tab
                               ["MONITORDEBUFFS"]="Turn on/off debuff monitoring.",
                               ["MONITORDEBUFFSIC"]="Turn on/off monitoring for debuffs in combat.",
                               ["MONITORDEBUFFSGROUPED"]="Do not monitor debuffs when solo.",
                               ["DEBUFFSSPELLTOCURE"]="The spell to use.\nDebuffs displayed will only be those that the spell can remove.",
                               ["DEBUFFSSPELLCHECKMEMBERS"]="The members to monitor.",
                               ["DEBUFFSIGNOREDEBUFFS"]="Debuffs with little or no effect can be ignored.\n- By class - Ignore debuffs that have no effect to the class\n- Non harmful - Ignore all non harmful debuff\n- Slow movement - Ignore debuffs that slows movement\n- Short duration - Ignore debuffs that last for less time than the Duration slider\n- When cure spell CoolDown > 1.5secs (GCD) - Ignore debuffs when its not possible to cast while the spell is on cooldown\n- When caster is known as friend - When the caster of the debuff is friendly",
                               ["DEBUFFSTYPEPRIORITY"]="Priority by debuff types.\nHighest priority is 1 and lowest is 20, highest priority is always displayed first.",
                               ["DEBUFFSTYPECOLOUR"]="Bars are changed to defined col"..HEALBOT_enWORD_COLOUR_SUFFIX.."s by debuff types. Click to change.\nWhen the player has a debuff and settings on the Debuff Warning tab apply.",
                        -- Debuffs Custom tab
                               ["DEBUFFSCUSTOMCAT"]="Custom defaults and A-Z debuff categories\ncan be selected using the category dropdown.",
                               ["DEBUFFSCUSTOMDEBUFF"]="Lists custom default settings or individual\ndebuffs depending on the Category selected.",
                               ["DEBUFFSCUSTOMCASTBY"]="Sets a filter on debuffs displayed\nby checking the caster of the debuff.",
                               ["DEBUFFSCUSTOMREVDUR"]="Debuff duration count starts at 0 and increases.",
                               ["DEBUFFSCUSTOMDELETE"]="Delete the selected custom debuff.",
                               ["DEBUFFSCUSTOMNEWNAME"]="Add a new debuff to the current category.\nNote: The Spell Name or Spell ID can be used.\nUsing Spell ID is recommended.",
                               ["DEBUFFSCUSTOMNEWSAVE"]="Save the new custom debuff.",
                               ["DEBUFFSCUSTOMENDIS"]="Disable the selected custom debuff in the current zone.",
                               ["DEBUFFSCUSTOMPRIORITY"]="Priority of the selected custom debuff.\nHighest priority is 1 and lowest is 20, highest priority is always displayed first.",
                               ["DEBUFFSCUSTOMCOLOUR"]="Click on the custom bar to set the col"..HEALBOT_enWORD_COLOUR_SUFFIX..".",
                               ["DEBUFFSCUSTOMCOLOURSHOW"]="Turn on/off changing the bar col"..HEALBOT_enWORD_COLOUR_SUFFIX.." for the selected custom debuff.",
                               ["DEBUFFSCUSTOMRESET"]="Reset settings to defaults for the selected custom debuff.",
                               ["DEBUFFSCUSTOMPAGE"]="Page though the custom debuffs.",
                               ["DEBUFFSCUSTOMALLDISEASE"]="Always show disease type debuffs.",
                               ["DEBUFFSCUSTOMALLMAGIC"]="Always show magic type debuffs.",
                               ["DEBUFFSCUSTOMALLPOISON"]="Always show poison type debuffs.",
                               ["DEBUFFSCUSTOMALLCURSE"]="Always show curse type debuffs.",
                               ["DEBUFFSCUSTOMALLBOSS"]="Always show debuffs cast by bosses.",
                               ["DEBUFFSCUSTOMALLBOSSSTRICT"]="A boss must exist.\nAvoid bizzard api reporting boss debuffs from lesser mobs.",
                        -- Debuffs Warning tab
                               ["DEBUFFSWARNINGBAR"]="Change the health bar col"..HEALBOT_enWORD_COLOUR_SUFFIX.." to the settings defined.\nThis applies to all General and Custom debuffs.",
                               ["DEBUFFSWARNINGBARRANGE"]="Set the range when the health bar col"..HEALBOT_enWORD_COLOUR_SUFFIX.." is changed.",
                               ["DEBUFFSWARNINGAGGRO"]="Change the aggro bars col"..HEALBOT_enWORD_COLOUR_SUFFIX.." to the settings defined.\nThis applies to all General and Custom debuffs.",
                               ["DEBUFFSWARNINGAGGRORANGE"]="Set the range when the aggro bars col"..HEALBOT_enWORD_COLOUR_SUFFIX.." is changed.",
                               ["DEBUFFSWARNINGSHOW"]="Display a text warning on screen.\nThis applies to all General and Custom debuffs.",
                               ["DEBUFFSWARNINGSHOWRANGE"]="Set the range when the on screen text is displayed.",
                               ["DEBUFFSWARNINGSOUND"]="Play a sound.\nThis applies to all General and Custom debuffs.",
                               ["DEBUFFSWARNINGSOUNDRANGE"]="Set the range when the sound is played.",
                               ["DEBUFFSWARNINGSOUNDSELECT"]="Select the sound to play.",
                               ["DEBUFFSWARNINGSOUNDPREVIEW"]="Test playing the sound.",
                        -- Buffs General tab
                               ["MONITORBUFFS"]="Turn on/off buff monitoring.",
                               ["MONITORBUFFSIC"]="Turn on/off monitoring for buffs in combat.",
                               ["MONITORBUFFSGROUPED"]="Do not monitor buffs when solo.",
                               ["BUFFSSPELL"]="Select the spell to monitor and cast.",
                               ["BUFFSMEMBERS"]="The members to monitor.",
                               ["BUFFSBARS"]="Bars are changed to defined col"..HEALBOT_enWORD_COLOUR_SUFFIX..". Click to change.\nWhen the player is missing a buff and settings on the Buff Warning tab apply.",
                               ["BUFFSTIMER"]="Alert when a buff is required n mins/secs before it expires.\n- Show buffs - These are buffs with a duration of a few minutes or less.\n- Long buffs - These are buffs with a duration usually in the 10's of minutes or more.",
                        -- Buffs Custom tab
                               ["BUFFSCUSTOMCAT"]="Custom class categories can be selected using the category dropdown.",
                               ["BUFFSCUSTOMBUFF"]="Lists custom buffs depending on the Category selected.",
                               ["BUFFSCUSTOMCASTBY"]="Sets a filter on buffs displayed\nby checking the caster of the buff.",
                               ["BUFFSCUSTOMDELETE"]="Delete the selected custom buff.",
                               ["BUFFSCUSTOMNEWNAME"]="Add a new buff to the current category.\nNote: The Spell Name or Spell ID can be used.\nUsing Spell ID is recommended.",
                               ["BUFFSCUSTOMNEWSAVE"]="Save the new custom buff.",
                               ["BUFFSCUSTOMENDIS"]="Disable the selected custom buff in the current zone.",
                               ["BUFFSCUSTOMPRIORITY"]="Priority of the selected custom buff.\nHighest priority is 1 and lowest is 20, highest priority is always displayed first.",
                               ["BUFFSCUSTOMCOLOUR"]="Click on the custom bar to set the col"..HEALBOT_enWORD_COLOUR_SUFFIX..".",
                               ["BUFFSCUSTOMCOLOURSHOW"]="Turn on/off changing the bar col"..HEALBOT_enWORD_COLOUR_SUFFIX.." for the selected custom buff.",
                               ["BUFFSCUSTOMRESET"]="Reset settings to defaults for the selected custom buff.",
                               ["BUFFSCUSTOMPAGE"]="Page though the custom buffs.",
                        -- Buffs Warning tab
                               ["BUFFSWARNINGBAR"]="Change the health bar col"..HEALBOT_enWORD_COLOUR_SUFFIX.." to the settings defined.\nThis applies to all General and Custom buffs.",
                               ["BUFFSWARNINGBARRANGE"]="Set the range when the health bar col"..HEALBOT_enWORD_COLOUR_SUFFIX.." is changed.",
                               ["BUFFSWARNINGAGGRO"]="Change the aggro bars col"..HEALBOT_enWORD_COLOUR_SUFFIX.." to the settings defined.\nThis applies to all General and Custom buffs.",
                               ["BUFFSWARNINGAGGRORANGE"]="Set the range when the aggro bars col"..HEALBOT_enWORD_COLOUR_SUFFIX.." is changed.",
                               ["BUFFSWARNINGSHOW"]="Display a text warning on screen.\nThis applies to all General and Custom buffs.",
                               ["BUFFSWARNINGSHOWRANGE"]="Set the range when the on screen text is displayed.",
                               ["BUFFSWARNINGSOUND"]="Play a sound.\nThis applies to all General and Custom buffs.",
                               ["BUFFSWARNINGSOUNDRANGE"]="Set the range when the sound is played.",
                               ["BUFFSWARNINGSOUNDSELECT"]="Select the sound to play.",
                               ["BUFFSWARNINGSOUNDPREVIEW"]="Test playing the sound.",
                        -- Tips tab
                               ["TOOLTIPSHOW"]="Show tooltip information on the\ncurrent bar the mouse is over.",
                               ["TOOLTIPUPDATE"]="Keep updating the tooltip while\nthe mouse in stationary over a bar.",
                               ["TOOLTIPHIDEIC"]="Hide the tooltip when in combat.",
                               ["TOOLTIPTARGETINFO"]="Show the name, class and spec if relevant,\nlocation, health and mana/power.",
                               ["TOOLTIPMYBUFFS"]="Show buffs and duration cast by you.",
                               ["TOOLTIPSPELLDETAIL"]="Show the cast time of the spell.",
                               ["TOOLTIPSPELLCD"]="Show the cooldown remaining on the spell.",
                               ["TOOLTIPWHEELCMD"]="Show the commands defined on the Mouse Wheel tab.",
                               ["TOOLTIPHOTREC"]="Show best HoT depending on current circumstances.",
                               ["TOOLTIPGAMETIP"]="Use the game tooltip, this includes tooltip addons.",
                               ["TOOLTIPMONBUFFS"]="On all monitored Buffs / HoT's\nshow who cast the spell and duration left.",
                               ["TOOLTIPFONTSIZE"]="Set the size using Blizzards standard font sizes.",
                               ["TOOLTIPPOSITION"]="Links to the Skins Frame General tab,\nallowing for different positions per frame.",
                               ["TOOLTIPALPHA"]="Set the transparency of the tooltip.",
                        -- Mouse Wheel tab
                               ["BUFFSMOUSEWHEELUSE"]="Turn On/Off usage of the mouse wheel.\nNote: When this is on mouse over macros will not work on HealBot bars",
                               ["BUFFSMOUSEWHEELCMD"]="Set a command to run with an optional key press\nand mouse wheel up or down combination.",
                               ["BUFFSMOUSEWHEELEMOTE"]="Select the emote to be used on mouse wheel scroll.",
                        -- Test tab
                               ["TESTUSE"]="The button shows the current state of test bars, click on it to change the state.",
                               ["TESTPROFILE"]="Profile limits the total number of bars for Groups or Raids.",
                               ["TESTNUMTOTAL"]="Fine tune the total number of bars for selected profile.",
                               ["TESTNUMTANKS"]="Set the number of bars to represent Tanks.",
                               ["TESTNUMHEALS"]="Set the number of bars to represent Healers.",
                               ["TESTNUMMYTARGETS"]="Set the number of bars to represent your Private Targets.",
                               ["TESTNUMPETS"]="Set the number of bars to represent Pets.",
                               ["TESTNUMENEMY"]="Set the number of bars to represent the Enemy.",
                        -- Import/Export Skins tab
                               ["INOUTSELECTSKIN"]="Select the skin to be exported.",
                               ["INOUTEXPORTSKIN"]="Export populates the large text box with data for the selected skin.\nThis can then be copied and saved outside the game.",
                               ["INOUTIMPORTSKIN"]="Import reads the text from the large text box and sets the skin.\nNote: This will overwrite any existing skin with the same name.",
                        -- Import/Export Custom Debuffs tab
                               ["INOUTEXPORTCDEBUFF"]="Export populates the large text box with data of all current custom debuffs.\nThis can then be copied and saved outside the game.",
                               ["INOUTIMPORTCDEBUFFMETHOD"]="On Import the following methods can be used.\n- Overwrite All - Delete all existing custom debuffs, then load and insert custom debuffs.\n- Merge All - Insert missing custom debuffs and update existing custom debuffs.\n- Merge New - Only insert missing custom debuffs, no updates to existing custom debuffs.",
                               ["INOUTIMPORTCDEBUFF"]="Import loads in the data from the large text box\nusing the import method selected above.",
                        -- Import/Export Custom Buffs tab
                               ["INOUTEXPORTCBUFF"]="Export populates the large text box with data of all current custom buffs.\nThis can then be copied and saved outside the game.",
                               ["INOUTIMPORTCBUFFMETHOD"]="On Import the following methods can be used.\n- Overwrite All - Delete all existing custom buffs, then load and insert custom buffs.\n- Merge All - Insert missing custom buffs and update existing custom buffs.\n- Merge New - Only insert missing custom buffs, no updates to existing custom buffs.",
                               ["INOUTIMPORTCBUFF"]="Import loads in the data from the large text box\nusing the import method selected above.",
                        -- Import/Export Spells tab
                               ["INOUTEXPORTSPELLS"]="Export populates the large text box with data of all current spells.\nThis can then be copied and saved outside the game.",
                               ["INOUTIMPORTSPELLSMETHOD"]="On Import the following methods can be used.\n- Overwrite All - Delete all existing spells, then load and insert spells.\n- Merge All - Insert missing spells and update existing spells.\n- Merge New - Only insert missing spells, no updates to existing spells.",
                               ["INOUTIMPORTSPELLS"]="Import loads in the data from the large text box\nusing the import method selected above.",
                        -- Import/Export Preset Colours tab
                               ["INOUTEXPORTPRESETCOLS"]="Export populates the large text box with data of all preset col"..HEALBOT_enWORD_COLOUR_SUFFIX.."s.\nThis can then be copied and saved outside the game.",
                               ["INOUTIMPORTPRESETCOLS"]="Import loads in the data from the large text box.",
                              }
end

if (GetLocale() == "enUK") then
    HealBot_Lang_enUK()
else
    HealBot_Lang_enUS()
end
