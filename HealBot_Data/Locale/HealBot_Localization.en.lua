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


HEALBOT_classicABSORBHOT="absorb"
HEALBOT_classicABSORBHOTUP="Absorb"
    
function HealBot_Lang_enUK()
    HEALBOT_enWORD_COLOUR_SUFFIX = "our"
    HEALBOT_WORDS_CUSTOMNAME     = "Customise name"
    HealBot_Lang_enALL()
end

function HealBot_Lang_enUS()
    HEALBOT_enWORD_COLOUR_SUFFIX = "or"
    HEALBOT_WORDS_CUSTOMNAME     = "Customize name"
    HealBot_Lang_enALL()
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
    HEALBOT_EVOKER                          = "Evoker"

    HEALBOT_BALANCE       = "Balance"
    HEALBOT_FERAL         = "Feral"
    HEALBOT_RESTORATION   = "Restoration"
    HEALBOT_SHAMAN_RESTORATION = "Restoration"
    HEALBOT_ARCANE        = "Arcane"
    HEALBOT_FIRE          = "Fire"
    HEALBOT_FROST         = "Frost"
    HEALBOT_DISCIPLINE    = "Discipline"
    HEALBOT_HOLY          = "Holy"
    HEALBOT_SHADOW        = "Shadow"
    HEALBOT_ASSASSINATION = "Assassination"
    HEALBOT_COMBAT        = "Combat"
    HEALBOT_SUBTLETY      = "Subtlety"
    HEALBOT_ARMS          = "Arms"
    HEALBOT_FURY          = "Fury"
    HEALBOT_PROTECTION    = "Protection"
    HEALBOT_BEASTMASTERY  = "Beast Mastery"
    HEALBOT_MARKSMANSHIP  = "Marksmanship"
    HEALBOT_SURVIVAL      = "Survival"
    HEALBOT_RETRIBUTION   = "Retribution"
    HEALBOT_ELEMENTAL     = "Elemental"
    HEALBOT_ENHANCEMENT   = "Enhancement"
    HEALBOT_AFFLICTION    = "Affliction"
    HEALBOT_DEMONOLOGY    = "Demonology"
    HEALBOT_DESTRUCTION   = "Destruction"
    HEALBOT_BLOOD         = "Blood"
    HEALBOT_UNHOLY        = "Unholy"

    HEALBOT_DISEASE                         = "Disease";
    HEALBOT_MAGIC                           = "Magic";
    HEALBOT_CURSE                           = "Curse";
    HEALBOT_POISON                          = "Poison";

    HB_TOOLTIP_OFFLINE                      = "Offline";

    HEALBOT_HEALBOT                         = "HealBot";
    HEALBOT_ADDON                           = HEALBOT_HEALBOT .. " " .. HEALBOT_VERSION;
    HEALBOT_LOADED                          = " loaded.";

    HEALBOT_RANK   = {[1]="(Rank 1)", [2]="(Rank 2)", [3]="(Rank 3)", [4]="(Rank 4)", [5]="(Rank 5)", [6]="(Rank 6)", [7]="(Rank 7)",
                      [8]="(Rank 8)", [9]="(Rank 9)", [10]="(Rank 10)", [11]="(Rank 11)", [12]="(Rank 12)", [13]="(Rank 13)"}

    HEALBOT_ACTION_OPTIONS                  = "Options";
    HEALBOT_ACTION_UNLOCKED                 = "Unlocked";

    HEALBOT_OPTIONS_TITLE                   = HEALBOT_HEALBOT;
    HEALBOT_OPTIONS_DEFAULTS                = "Global Defaults";
    HEALBOT_OPTIONS_LOCALDEFAULTS           = "Local Defaults";
    HEALBOT_OPTIONS_CLOSE                   = "Close";
    HEALBOT_OPTIONS_HARDRESET               = "Reload UI"
    HEALBOT_OPTIONS_SOFTRESET               = "Reset HealBot"
    HEALBOT_OPTIONS_COPY                    = "Copy";
    HEALBOT_OPTIONS_TAB_GENERAL             = "General";
    HEALBOT_OPTIONS_TAB_SPELLS              = "Spells";
    HEALBOT_OPTIONS_TAB_FRAMES              = "Frames";
    HEALBOT_OPTIONS_TAB_HEALING             = "Healing";
    HEALBOT_OPTIONS_TAB_SKIN                = "Skins";
    HEALBOT_OPTIONS_TAB_TIPS                = "Tips";
    HEALBOT_OPTIONS_TAB_DEBUFFS             = "Debuffs"
    HEALBOT_OPTIONS_TAB_CUSTOM_DEBUFFS      = "Custom Debuffs";
    HEALBOT_OPTIONS_TAB_CUSTOM_BUFFS        = "Custom Buffs";
    HEALBOT_OPTIONS_CDEBUFFS_DISCORD        = "Custom debuffs can be shared on discord in the #share channel";
    HEALBOT_OPTIONS_CBUFFS_DISCORD          = "Custom buffs can be shared on discord in the #share channel";
    HEALBOT_OPTIONS_SKINS_DISCORD           = "Skins can be shared on discord in the #share channel";
    HEALBOT_OPTIONS_SPELLS_DISCORD          = "Spells can be shared on discord in the #share channel";
    HEALBOT_OPTIONS_PRECOLS_DISCORD         = "Preset col"..HEALBOT_enWORD_COLOUR_SUFFIX.."s can be shared on discord in the #share channel";
    HEALBOT_OPTIONS_TAB_BUFFS               = "Buffs"
    HEALBOT_OPTIONS_TAB_GENERALBUFFS        = "General Buffs"
    HEALBOT_OPTIONS_TAB_STATETEXT           = "State";
    HEALBOT_OPTIONS_TAB_NAMETEXT            = "Name";
    HEALBOT_OPTIONS_TAB_OVERRIDES           = "Overrides"
    HEALBOT_OPTIONS_TAB_EXTRAS              = "Extras"
    
    HEALBOT_STRING_MATCH_WELLFED            = "become well fed"
    HEALBOT_STRING_MATCH_RESTOREMANA        = "(%d+)(%%*) (%u*)(%l*)ana over (%d+) sec"
    HEALBOT_STRING_MATCH_EXTRABUFFS         = {"Flask", "Elixir", "Scroll", "Potion", "Rune$"}
    HEALBOT_WELL_FED                        = "Well Fed"
    HEALBOT_MANA_DRINK                      = "Mana Drink"
    HEALBOT_MANA_LOWTHRESHOLD               = "Low mana threshold"

    HEALBOT_OPTIONS_GLOBAL                  = "Global"
    HEALBOT_OPTIONS_ALPHA                   = "Opacity";
    HEALBOT_OPTIONS_MINALPHA                = "Min opacity";
    HEALBOT_OPTIONS_MAXALPHA                = "Max opacity";
    HEALBOT_OPTIONS_BARALPHA                = "Enabled opacity";
    HEALBOT_OPTIONS_BARALPHAINHEAL          = "Incoming heals opacity";
    HEALBOT_OPTIONS_BARALPHABACK            = "Background bar opacity";
    HEALBOT_OPTIONS_BARALPHABOR             = "Background border opacity";
    HEALBOT_OPTIONS_BARALPHAEOR             = "Out of range opacity";
    HEALBOT_OPTIONS_ACTIONLOCKED            = "Lock frame";
    HEALBOT_OPTIONS_UNITINCOMBAT            = "Group/Raid member enters combat"
    HEALBOT_OPTIONS_UNITINCOMBAT01          = "Do nothing"
    HEALBOT_OPTIONS_UNITINCOMBAT02          = "Show enemy frame"
    HEALBOT_OPTIONS_UNITINCOMBAT03          = "Lockdown HealBot"
    HEALBOT_OPTIONS_AUTOSHOW                = "Close automatically";
    HEALBOT_OPTIONS_FRAMEGLOWSIZE           = "Bar glow size";
    HEALBOT_OPTIONS_HIDEOPTIONS             = "Hide options button";
    HEALBOT_OPTIONS_HIDEUNLOCKEDTAG         = "Hide unlocked tag"
    HEALBOT_OPTIONS_PROTECTPVP              = "Avoid PvP";
    HEALBOT_OPTIONS_HEAL_CHATOPT            = "Chat Options";
    HEALBOT_OPTIONS_BLIZZARD_FRAMES         = "Blizzard Frames";

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
    HEALBOT_SORTBY_UNITID                   = "Unit ID"
    HEALBOT_OPTIONS_NEWDEBUFFTEXT           = "New Debuff"
    HEALBOT_OPTIONS_NEWHOTBUFFTEXT          = "New Buff"
    HEALBOT_WORD_TAG                        = "Tag"
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
    HEALBOT_OPTIONS_ICONPOSITION            = "Icon Position"
    HEALBOT_OPTIONS_ICONANCHOR              = "Icon Anchor"

    HEALBOT_OPTIONS_ITEMS                   = "Items";
    HEALBOT_OPTIONS_ITEM                    = "Item";
    HEALBOT_OPTIONS_SPELL                   = "Spell";

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
    HEALBOT_OPTIONS_RAIDGROUPWARN           = "Raid filter";
    HEALBOT_OPTIONS_BUFFWARNINGS            = "Buff warnings";
    HEALBOT_OPTIONS_BUFFCUSTOM              = "Custom buffs";
    HEALBOT_OPTIONS_DEBUFFCUSTOM            = "Custom debuffs"
    HEALBOT_OPTIONS_BUFFMISSING             = "Missing buffs";
    HEALBOT_OPTIONS_BUFFEXTRA               = "Extra Buffs";
    HEALBOT_OPTIONS_CHECKWELLFED            = "Check well fed";
    HEALBOT_OPTIONS_CHECKLOWMANA            = "Check low mana"
    HEALBOT_OPTIONS_DEBUFFDISPELL           = "Dispellable debuffs";
    HEALBOT_OPTIONS_SHOWDEBUFFWARNING       = "Display warning on debuff";
    HEALBOT_OPTIONS_SOUNDDEBUFFWARNING      = "Play sound on debuff";
    HEALBOT_OPTIONS_SHOWBUFFWARNING         = "Display warning on buff";
    HEALBOT_OPTIONS_SOUNDBUFFWARNING        = "Play sound on buff";
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
    HEALBOT_OPTIONS_PRIVATEDAMAGERS         = "Private damagers";
    HEALBOT_OPTIONS_TARGETHEALS             = "Target";
    HEALBOT_OPTIONS_EMERGENCYHEALS          = "Raid";
    HEALBOT_OPTIONS_RAID10                  = HEALBOT_OPTIONS_EMERGENCYHEALS.." 10";
    HEALBOT_OPTIONS_RAID20                  = HEALBOT_OPTIONS_EMERGENCYHEALS.." 20";
    HEALBOT_OPTIONS_RAID25                  = HEALBOT_OPTIONS_EMERGENCYHEALS.." 25";
    HEALBOT_OPTIONS_RAID40                  = HEALBOT_OPTIONS_EMERGENCYHEALS.." 40";
    HEALBOT_OPTIONS_EMERGFILTER             = "Show bars for";
    HEALBOT_OPTIONS_EMERGFCLASS             = "Configure classes for";
    HEALBOT_OPTIONS_MODIFIER                = "Modifier key"
    HEALBOT_OPTIONS_MODIFIERKEYS            = "Modifier keys:"
    HEALBOT_OPTIONS_COMBOBUTTON             = "Button";
    HEALBOT_OPTIONS_BUTTONANY               = "Any button";
    HEALBOT_OPTIONS_BUTTONLEFT              = "Left";
    HEALBOT_OPTIONS_BUTTONMIDDLE            = "Middle";
    HEALBOT_OPTIONS_BUTTONRIGHT             = "Right";
    HEALBOT_OPTIONS_BUTTON4                 = "Button 4";
    HEALBOT_OPTIONS_BUTTON5                 = "Button 5";
    HEALBOT_OPTIONS_BUTTON6                 = "Button 6";
    HEALBOT_OPTIONS_BUTTON7                 = "Button 7";
    HEALBOT_OPTIONS_BUTTON8                 = "Button 8";
    HEALBOT_OPTIONS_BUTTON9                 = "Button 9";
    HEALBOT_OPTIONS_BUTTON10                = "Button 10";
    HEALBOT_OPTIONS_BUTTON11                = "Button 11";
    HEALBOT_OPTIONS_BUTTON12                = "Button 12";
    HEALBOT_OPTIONS_BUTTON13                = "Button 13";
    HEALBOT_OPTIONS_BUTTON14                = "Button 14";
    HEALBOT_OPTIONS_BUTTON15                = "Button 15";
    HEALBOT_OPTIONS_BUTTON16                = "Button 16";
    HEALBOT_OPTIONS_BUTTON17                = "Button 17";
    HEALBOT_OPTIONS_BUTTON18                = "Button 18";
    HEALBOT_OPTIONS_BUTTON19                = "Button 19";
    HEALBOT_OPTIONS_BUTTON20                = "Button 20";
    
    HEALBOT_OPTIONS_BINDKEYTOCLICK          = "Bind a key to a Button Click"

    HEALBOT_CLASSES_ALL                     = "All (Non class specific)";
    HEALBOT_CLASSES_MELEE                   = "Melee";
    HEALBOT_CLASSES_RANGES                  = "Ranged";
    HEALBOT_CLASSES_HEALERS                 = "Healers";
    HEALBOT_CLASSES_CUSTOM                  = "Custom";

    HEALBOT_OPTIONS_DEBUFFNAME              = "Debuff Name"
    HEALBOT_OPTIONS_DEBUFFAUTOTOCUSTOM      = "Add to custom list"
    HEALBOT_OPTIONS_SHOWTOOLTIP             = "Show tooltips";
    HEALBOT_OPTIONS_SHOWDETTOOLTIP          = "Show detailed spell information";
    HEALBOT_OPTIONS_SHOWCDTOOLTIP           = "Show spell cooldown";
    HEALBOT_OPTIONS_IGNOREGCDTOOLTIP        = "Ignore spell global cooldown";
    HEALBOT_OPTIONS_SHOWMOUSEWHEELTOOLTIP   = "Show mouse wheel commands"
    HEALBOT_OPTIONS_SHOWUNITTOOLTIP         = "Show target information";
    HEALBOT_OPTIONS_SHOWRECTOOLTIP          = "Show heal over time recommendation";
    HEALBOT_TOOLTIP_POSDEFAULT              = "Default location";
    HEALBOT_TOOLTIP_POSLEFT                 = "Left of Frame";
    HEALBOT_TOOLTIP_POSRIGHT                = "Right of Frame";
    HEALBOT_TOOLTIP_POSABOVE                = "Above Frame";
    HEALBOT_TOOLTIP_POSBELOW                = "Below Frame";
    HEALBOT_TOOLTIP_POSCURSOR               = "Next to Cursor";
    HEALBOT_TOOLTIP_RECOMMENDTEXT           = "Heal over time Recommendation";
    HEALBOT_TOOLTIP_NONE                    = "none available";
    HEALBOT_TOOLTIP_CORPSE                  = "Corpse of ";
    HEALBOT_TOOLTIP_CD                      = "  (";
    HEALBOT_TOOLTIP_SECS                    = " sec)";
    HEALBOT_TOOLTIP_MINS                    = " min)";
    HEALBOT_TOOLTIP_HEADERFONT              = "Header font";
    HEALBOT_TOOLTIP_DETAILFONT              = "Detail font";
    HEALBOT_TOOLTIP_HEADERFONTSIZE          = "Header font size";
    HEALBOT_TOOLTIP_DETAILFONTSIZE          = "Detail font size";
    HEALBOT_TOOLTIP_SHOWASSIGNEDSPELLS      = "Show assigned spells"
    HEALBOT_TOOLTIP_SHOWSPELLEXTRA          = "Show additional info"
    HEALBOT_TOOLTIP_SHOWHEALTH              = "Show health"
    HEALBOT_TOOLTIP_SHOWMANA                = "Show mana"
    HEALBOT_TOOLTIP_SHOWLEVEL               = "Show level"
    HEALBOT_TOOLTIP_SHOWSPEC                = "Show spec"
    HEALBOT_WORDS_COOLDOWN                  = "Cooldown"
    HEALBOT_WORDS_TINY                      = "Tiny"
    HEALBOT_WORDS_SMALL                     = "Small"
    HEALBOT_WORDS_MEDIUM                    = "Medium"
    HEALBOT_WORDS_LARGE                     = "Large"
    HEALBOT_WORDS_HUGE                      = "Huge"
    HEALBOT_WORDS_SHORT                     = "Short";
    HEALBOT_WORDS_LONG                      = "Long";
    HEALBOT_WORDS_SEC                       = "sec";
    HEALBOT_WORDS_CAST                      = "Cast";
    HEALBOT_WORDS_UNKNOWN                   = "Unknown";
    HEALBOT_WORDS_YES                       = "Yes";
    HEALBOT_WORDS_NO                        = "No";
    HEALBOT_WORDS_OK                        = "OK";
    HEALBOT_WORDS_THIN                      = "Thin";
    HEALBOT_WORDS_THICK                     = "Thick";

    HEALBOT_WORDS_NONE                      = "None";
    HEALBOT_OPTIONS_ALT                     = "Alt";
    HEALBOT_OPTIONS_LOCKOFF                 = "Always Unlocked";
    HEALBOT_OPTIONS_LOCKON                  = "Always Locked";
    HEALBOT_OPTIONS_LOCKCTRL                = "Unlock with Ctrl";
    HEALBOT_OPTIONS_LOCKALT                 = "Unlock with Alt";
    HEALBOT_OPTIONS_LOCKCTRLALT             = "Unlock with Ctrl + Alt";
    HEALBOT_DISABLED_TARGET                 = "Target";
    HEALBOT_OPTIONS_SHOWCLASSONBAR          = "Show class on bar";
    HEALBOT_OPTIONS_SHOWHEALTHONBAR         = "Show health on bar";
    HEALBOT_OPTIONS_HEALTHINCPERCENT        = "Include percent";
    HEALBOT_OPTIONS_HEALTHINVEHSHOWPLAYER   = "When in vehicle also show player";
    HEALBOT_OPTIONS_SHOWTEXT                = "Show text";
    HEALBOT_OPTIONS_IGNOREINCOMINGONFULL    = "On full health ignore all incoming heals and "..HEALBOT_classicABSORBHOT.."s";
    HEALBOT_OPTIONS_TEXTONLYTIP             = "Only show in tooltip";
    HEALBOT_OPTIONS_TEXTSTATENAMEFONT       = "Use name font string";
    HEALBOT_OPTIONS_BARHEALTHINCHEALS       = "Include incoming heals";
    HEALBOT_OPTIONS_BARHEALTHSEPHEALS       = "Separate incoming heals";
    HEALBOT_OPTIONS_BARHEALTHINCABSORBS     = "Include "..HEALBOT_classicABSORBHOT.."s"
    HEALBOT_OPTIONS_BARHEALTHSEPABSORBS     = "Separate "..HEALBOT_classicABSORBHOT.."s"
    HEALBOT_OPTIONS_BARHEALTHMYOVERHEALS    = "Show my overheals";
    HEALBOT_OPTIONS_BARHEALTHALLOVERHEALS   = "Show all overheals";
    HEALBOT_OPTIONS_BARHEALTH1              = "as delta";
    HEALBOT_OPTIONS_BARHEALTH2              = "as percentage";
    HEALBOT_OPTIONS_TIPTEXT                 = "Tooltip General";
    HEALBOT_OPTIONS_TIPTEXT2                = "Tooltip Unit Information";
    HEALBOT_OPTIONS_TIPTEXT3                = "Tooltip Spell Information";
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
    HEALBOT_OPTIONS_SETDEFAULTSMSG          = "Reset all options on all characters\nto default values";
    HEALBOT_OPTIONS_SETLOCALDEFAULTSMSG     = "Reset spells/buffs/debuffs for this character\nto default values";
    HEALBOT_OPTIONS_RIGHTBOPTIONS           = "Right click opens options";

    HEALBOT_OPTIONS_BARHEADEROPTTEXT        = "Bar Header options";
    HEALBOT_OPTIONS_FRAMEHEADEROPTTEXT      = "Frame Header options";
    HEALBOT_OPTIONS_ICONBUFFOPTTEXT         = "Buff icon options";
    HEALBOT_OPTIONS_ICONDEBUFFOPTTEXT       = "Debuff icon options";
    HEALBOT_OPTIONS_ICONOPTCLASSROLEBUTTON  = "Class / Role"
    HEALBOT_OPTIONS_ICONOPTCLASSROLE        = "Class / Role icon options";
    HEALBOT_OPTIONS_ICONOPTRAIDTARGETBUTTON = "Raid Target"
    HEALBOT_OPTIONS_ICONOPTRAIDTARGET       = "Raid Target icon options";
    HEALBOT_OPTIONS_ICONOPTREADYCHECK       = "State icon options";
    HEALBOT_OPTIONS_ICONOPTOORARROW         = "Out of Range Arrow icon options";
    HEALBOT_OPTIONS_ICONOPTOORARROWBUTTON   = "OOR Arrow";
    HEALBOT_OPTIONS_NAMEROLELABELTEXT       = "Role label text";
    HEALBOT_OPTIONS_STATEOPTTEXT            = "State text options";
    HEALBOT_OPTIONS_NAMEOPTTEXT             = "Name text options";
    HEALBOT_OPTIONS_HEALTHOPTTEXT           = "Health text options";
    HEALBOT_OPTIONS_AGGROOPTTEXT            = "Aggro text options";
    HEALBOT_OPTIONS_EXTRAHOPTOVERHEAL       = "Overheals options";
    HEALBOT_OPTIONS_EXTRAHOPTINHEAL         = "Incoming heals options";
    HEALBOT_OPTIONS_AUXOPTTEXT              = "Aux text options";
    HEALBOT_OPTIONS_TABNOTAVAIL             = "Tab not available with current frame";
    HEALBOT_OPTIONS_STATEOPTCOLOUR          = "State col"..HEALBOT_enWORD_COLOUR_SUFFIX.." options";
    HEALBOT_OPTIONS_NAMEOPTCOLOUR           = "Name col"..HEALBOT_enWORD_COLOUR_SUFFIX.." options";
    HEALBOT_OPTIONS_HEALTHOPTCOLOUR         = "Health col"..HEALBOT_enWORD_COLOUR_SUFFIX.." options";
    HEALBOT_OPTIONS_AGGROOPTCOLOUR          = "Aggro col"..HEALBOT_enWORD_COLOUR_SUFFIX.." options";
    HEALBOT_OPTIONS_AUXOPTCOLOUR            = "Aux col"..HEALBOT_enWORD_COLOUR_SUFFIX.." options";
    HEALBOT_OPTIONS_HEALTHTEXTANCHOR        = "Health text anchor";
    HEALBOT_OPTIONS_AGGROTEXTANCHOR         = "Aggro text anchor";
    HEALBOT_OPTIONS_STATETEXTANCHOR         = "State text anchor";
    HEALBOT_OPTIONS_AGGROINDTEXT            = "Aggro indicator on name";
    HEALBOT_OPTIONS_OVERHEALFORMAT          = "Overheals format";
    HEALBOT_OPTIONS_OVERHEALCOLOUR          = "Overheals col"..HEALBOT_enWORD_COLOUR_SUFFIX;
    HEALBOT_OPTIONS_SEPARATEFORMAT          = "Separate format";
    HEALBOT_OPTIONS_SEPARATECOLOUR          = "Separate col"..HEALBOT_enWORD_COLOUR_SUFFIX;
    HEALBOT_OPTIONS_PERCENTAGEFORMAT        = "Percentage format";
    HEALBOT_SKIN_HEADERBARCOL               = "Bar col"..HEALBOT_enWORD_COLOUR_SUFFIX;
    HEALBOT_SKIN_HEADERTEXTCOL              = "Text col"..HEALBOT_enWORD_COLOUR_SUFFIX;
    HEALBOT_SKIN_ICONGLOW                   = "Icon glow";
    HEALBOT_SKIN_ICONSET                    = "Icon set";
    HEALBOT_SKIN_ICONBUFFSET01              = "Buff icon set 1";
    HEALBOT_SKIN_ICONBUFFSET02              = "Buff icon set 2";
    HEALBOT_SKIN_ICONBUFFSET03              = "Buff icon set 3";
    HEALBOT_SKIN_ICONDEBUFFSET01            = "Debuff icon set 1";
    HEALBOT_SKIN_ICONDEBUFFSET02            = "Debuff icon set 2";
    HEALBOT_SKIN_ICONDEBUFFSET03            = "Debuff icon set 3";
    HEALBOT_OPTIONS_BUFFSTEXT1              = "Spell to buff";
    HEALBOT_OPTIONS_BUFFSTEXTWE             = "Weapon enchants";
    HEALBOT_OPTIONS_BUFFSTEXTWEMAIN         = "Main hand / 2H";
    HEALBOT_OPTIONS_BUFFSTEXTWEOFF          = "Off hand";
    HEALBOT_OPTIONS_ITEMNAME                = "Item name";
    HEALBOT_OPTIONS_PRIMARYITEM             = "Primary Item";
    HEALBOT_OPTIONS_BACKUPITEM              = "Backup Item";
    HEALBOT_OPTIONS_BUFFSTEXT2              = "check members";
    HEALBOT_OPTIONS_BUFFSTEXT3              = "bar col"..HEALBOT_enWORD_COLOUR_SUFFIX.."s";
    HEALBOT_OPTIONS_EMERGCOLS               = "Emergency col"..HEALBOT_enWORD_COLOUR_SUFFIX.."s";
    HEALBOT_OPTIONS_EMERGGENERAL            = "Emergency general";
    HEALBOT_OPTIONS_EMERGSPELLS             = "Emergency spells";
    HEALBOT_OPTIONS_ICONSCMD                = "Icon commands";
    HEALBOT_OPTIONS_BUFF                    = "Buff ";
    HEALBOT_OPTIONS_BUFFSELF                = "on self";
    HEALBOT_OPTIONS_BUFFPARTY               = "on party";
    HEALBOT_OPTIONS_BUFFRAID                = "on raid";
    HEALBOT_OPTIONS_MONITORBUFFS            = "Monitor buffs";
    HEALBOT_OPTIONS_MONITORBUFFSC           = "also in combat";
    HEALBOT_OPTIONS_ENABLESMARTCAST         = "SmartCast out of combat";
    HEALBOT_OPTIONS_SMARTCASTSPELLS         = "Include spells";
    HEALBOT_OPTIONS_SMARTCASTDISPELL        = "Remove debuffs";
    HEALBOT_OPTIONS_SMARTCASTBUFF           = "Add buffs";
    HEALBOT_OPTIONS_SMARTCASTHEAL           = "Healing spells";
    HEALBOT_OPTIONS_BAR2SIZE                = "Power bar size";
    HEALBOT_OPTIONS_SETSPELLS               = "Set spells for";
    HEALBOT_OPTIONS_USEICONCMDS             = "Use icon commands";
    HEALBOT_OPTIONS_ENABLEDBARS             = "Health Bars - Helpful spells on friendly characters";
    HEALBOT_OPTIONS_EMERGBARS               = "Emergency Bars - All spells on all characters";
    HEALBOT_OPTIONS_ICONS                   = "Icons: Commands that can be used on icons";
    HEALBOT_OPTIONS_MONITORDEBUFFS          = "Monitor debuffs";
    HEALBOT_OPTIONS_DEBUFFTEXT1             = "Spell to remove debuffs";
    
    HEALBOT_OPTIONS_POWER                   = "Power"
    HEALBOT_OPTIONS_CASTBAR                 = "Cast bar"
    
    HEALBOT_OPTIONS_HLTHTXTANCHORINDL       = "Independent Left"
    HEALBOT_OPTIONS_HLTHTXTANCHORINDC       = "Independent Center"
    HEALBOT_OPTIONS_HLTHTXTANCHORINDR       = "Independent Right"
    HEALBOT_OPTIONS_HLTHTXTANCHORRIGHT      = "Right of Name Text"
    HEALBOT_OPTIONS_HLTHTXTANCHORLEFT       = "Left of Name Text"
    HEALBOT_OPTIONS_HLTHTXTANCHORBELOW      = "Below Name Text"
    HEALBOT_OPTIONS_HLTHTXTANCHORABOVE      = "Above Name Text"
    HEALBOT_OPTIONS_STATECOLNOTAVAIL        = "State col"..HEALBOT_enWORD_COLOUR_SUFFIX.." options are inherited from the Name text\nwhen "..HEALBOT_OPTIONS_STATETEXTANCHOR.." is set to "..HEALBOT_OPTIONS_HLTHTXTANCHORLEFT;

    HEALBOT_OPTIONS_AUXBARANCHOR            = "Anchor"
    HEALBOT_OPTIONS_AUXBARANCHOR01          = "Below Health Bar"
    HEALBOT_OPTIONS_AUXBARANCHOR02          = "Above Health Bar"
    HEALBOT_OPTIONS_AUXBARANCHOR03          = "Left of Health Bar"
    HEALBOT_OPTIONS_AUXBARANCHOR04          = "Right of Health Bar"
    HEALBOT_OPTIONS_AUXBARANCHOR05          = "Below Health Bar Left side"
    HEALBOT_OPTIONS_AUXBARANCHOR06          = "Below Health Bar Right side"
    HEALBOT_OPTIONS_AUXBARANCHOR07          = "Above Health Bar Left side"
    HEALBOT_OPTIONS_AUXBARANCHOR08          = "Above Health Bar Right side"
    HEALBOT_OPTIONS_AUXBARANCHOR11          = "Below"
    HEALBOT_OPTIONS_AUXBARANCHOR12          = "Above"
    HEALBOT_OPTIONS_AUXBARANCHOR13          = "Left"
    HEALBOT_OPTIONS_AUXBARANCHOR14          = "Right"
    HEALBOT_OPTIONS_AUXBARANCHOR15          = "Below Left"
    HEALBOT_OPTIONS_AUXBARANCHOR16          = "Below Right"
    HEALBOT_OPTIONS_AUXBARANCHOR17          = "Above Left"
    HEALBOT_OPTIONS_AUXBARANCHOR18          = "Above Right"
    
    HEALBOT_OPTIONS_ICONEXTRAANCHOR01       = "Left"
    HEALBOT_OPTIONS_ICONEXTRAANCHOR02       = "Right"
    HEALBOT_OPTIONS_ICONEXTRAANCHOR03       = "Top"
    HEALBOT_OPTIONS_ICONEXTRAANCHOR04       = "Bottom"
    
    HEALBOT_OPTIONS_ICONBELOWANCHOR01       = "Left"
    HEALBOT_OPTIONS_ICONBELOWANCHOR02       = "Right"
    HEALBOT_OPTIONS_ICONBELOWANCHOR03       = "Center"
    
    HEALBOT_OPTIONS_ICONOFFBARANCHOR01      = "Bottom Left"
    HEALBOT_OPTIONS_ICONOFFBARANCHOR02      = "Bottom Right"
    HEALBOT_OPTIONS_ICONOFFBARANCHOR03      = "Top Left"
    HEALBOT_OPTIONS_ICONOFFBARANCHOR04      = "Top Right"
    
    HEALBOT_OPTIONS_ICONONBARANCHOR01       = "Bottom Left"
    HEALBOT_OPTIONS_ICONONBARANCHOR02       = "Bottom Right"
    HEALBOT_OPTIONS_ICONONBARANCHOR03       = "Top Left"
    HEALBOT_OPTIONS_ICONONBARANCHOR04       = "Top Right"
    HEALBOT_OPTIONS_ICONONBARANCHOR05       = "Bottom Center Grow Left"
    HEALBOT_OPTIONS_ICONONBARANCHOR06       = "Bottom Center Grow Right"
    HEALBOT_OPTIONS_ICONONBARANCHOR07       = "Top Center Grow Left"
    HEALBOT_OPTIONS_ICONONBARANCHOR08       = "Top Center Grow Right"
    
    HEALBOT_OPTIONS_IGNOREDEBUFF            = "Ignore debuffs:";
    HEALBOT_OPTIONS_IGNOREDEBUFFDURATION    = "Short duration";
    HEALBOT_OPTIONS_IGNOREDEBUFFCOOLDOWN    = "When cure spell CoolDown > 2 seconds";
    HEALBOT_OPTIONS_IGNOREDEBUFFFRIEND      = "When caster is known as friend";

    HEALBOT_OPTIONS_OPTIONSOPACITY          = "Options opacity";

    HEALBOT_OPTIONS_ALWAYRUNEVENTS          = "Always run events";
    HEALBOT_OPTIONS_HIDEPARTYFRAMES         = "Hide party frames";
    HEALBOT_OPTIONS_HIDEPLAYERTARGET        = "Include player and target";
    HEALBOT_OPTIONS_DISABLEHEALBOT          = "Disable HealBot";
    
    HEALBOT_OPTIONS_STICKYFRAMES            = "Sticky Frames"
    HEALBOT_OPTIONS_STICKYSENSITIVITY       = "Sticky Sensitivity"
    HEALBOT_WORD_VLOW                       = "Very Low"
    HEALBOT_WORD_LOW                        = "Low"
    HEALBOT_WORD_NORMAL                     = "Normal"
    HEALBOT_WORD_HIGH                       = "High"
    HEALBOT_WORD_EXTREME                    = "Extreme"
    HEALBOT_WORD_CASTER                     = "Caster"
    HEALBOT_WORD_TYPE                       = "Type"
    HEALBOT_WORD_FROM                       = "From"
    

    HEALBOT_ASSIST                          = "Assist";
    HEALBOT_FOCUS                           = "Focus";
    HEALBOT_MENU                            = "Menu";
    HEALBOT_MAINTANK                        = "MainTank";
    HEALBOT_STOP                            = "Stop";
    HEALBOT_CANCELPLUGINALERT               = "Cancel Plugin Alert";
    HEALBOT_IGNOREAURAALL                   = "Disable - Ignore in all zones";
    HEALBOT_ICONRAISEPRIO1                  = "Priority raise x1";
    HEALBOT_ICONRAISEPRIO3                  = "Priority raise x3";
    HEALBOT_ICONLOWERPRIO1                  = "Priority lower x1";
    HEALBOT_ICONLOWERPRIO3                  = "Priority lower x3";
    HEALBOT_ICONRAISESCALE                  = "Scale increase";
    HEALBOT_ICONLOWERSCALE                  = "Scale decrease";
    HEALBOT_ICONBARCOLOURON                 = "Bar col"..HEALBOT_enWORD_COLOUR_SUFFIX.." on"
    HEALBOT_ICONBARCOLOUROFF                = "Bar col"..HEALBOT_enWORD_COLOUR_SUFFIX.." off"
    HEALBOT_ICONBARCOLOURCYCLE              = "Bar col"..HEALBOT_enWORD_COLOUR_SUFFIX.." cycle"
    HEALBOT_ICONGLOWON                      = "Icon glow on"
    HEALBOT_ICONGLOWOFF                     = "Icon glow off"
    HEALBOT_ICONGLOWCYCLE                   = "Icon glow cycle"
    HEALBOT_ICONNEXTSET                     = "Icon set next";
    HEALBOT_ICONPREVSET                     = "Icon set prev";
    
    HEALBOT_OPTIONS_SHOWMINIMAPBUTTON       = "Show minimap button";
    HEALBOT_OPTIONS_BARBUTTONSHOWRAIDICON   = "Show Raid Target";
    HEALBOT_OPTIONS_HOTONBAR                = "On bar";
    HEALBOT_OPTIONS_HOTOFFBAR               = "Off bar";

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
    HEALBOT_OPTION_AGGROHAZARD              = "Show border hazard on tanking"
    HEALBOT_OPTION_AGGROBAR                 = "Bar"
    HEALBOT_OPTION_AGGROTXT                 = ">> Text <<"
    HEALBOT_OPTION_AGGROIND                 = "Show indicator"
    HEALBOT_OPTION_MANAONLY                 = "Show mana only"
    HEALBOT_OPTION_HEALERSMANAONLY          = "Healers only"
    HEALBOT_OPTION_BARUPDFREQ               = "Refresh Speed"
    HEALBOT_OPTION_USEFLUIDBARS             = "Use fluid bars"
    HEALBOT_OPTION_FLUIDBARSINCALPHA        = "Include col"..HEALBOT_enWORD_COLOUR_SUFFIX.." and alpha"
    HEALBOT_OPTION_HEALTHDROP               = "Health drop"
    HEALBOT_OPTION_USEHEALTHDROP            = "Show on Health bar"
    HEALBOT_OPTION_HEALTHDROPPCT            = "Alert threshold "
    HEALBOT_OPTION_HOTBARHEALTHPCT          = "Min Health+Absorbs threshold "
    HEALBOT_OPTION_HEALTHDROPSPEED          = "Flash speed"
    HEALBOT_OPTION_USEFOCUSGROUPS           = "Use focus groups"
    HEALBOT_OPTION_FOCUSGROUPDIMMING        = "Unfocused groups - Opacity reduction"
    HEALBOT_OPTION_NONHOTBARSDIMMING        = "Non Hot Bars - Opacity reduction"
    HEALBOT_OPTION_GLOBALDIMMING            = "Mouse not over frames - Opacity reduction"
    HEALBOT_OPTION_FLUIDBARS                = "Fluid Bars"
    HEALBOT_OPTION_HEALTHDROPALERT          = "Health Drop Alert"
    HEALBOT_OPTION_HOTBARS                  = "Hot Bars"
    HEALBOT_OPTION_HOTBARSDEBUFFPRIO        = "Debuff Priority threshold"           
    HEALBOT_OPTIONS_RELOADUIMSG             = "This option requires a UI Reload, Reload now?"
    HEALBOT_OPTION_USE                      = "Use"
    HEALBOT_OPTION_TOOLTIPSCALE             = "Scale"

    HEALBOT_BUFF_PVP                        = "PvP"
    HEALBOT_BUFF_PVE                        = "PvE"
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
    HEALBOT_OPTIONS_MAXSECS                 = "Maximum seconds"
    HEALBOT_WORDS_REQUIRED                  = "Required";
    HEALBOT_WORDS_PENDING                   = "Pending";
    HEALBOT_WORD_STATUS                     = "Status"
    HEALBOT_WORD_TIME                       = "Time"
    HEALBOT_WORD_SUMMONS                    = "Summons"
    HEALBOT_WORD_RESURRECTION               = "Resurrection"

    HEALBOT_OPTIONS_TTALPHA                 = "Opacity"
    HEALBOT_OPTIONS_TTMAXBUTTONS            = "Max buttons"
    HEALBOT_TOOLTIP_TARGETBAR               = "Target Bar"
    HEALBOT_OPTIONS_MYTARGET                = "Private List"
    HEALBOT_OPTIONS_MYFRIEND                = "My Friend"

    HEALBOT_DISCONNECTED_LABEL              = "Disconnected"
    HEALBOT_DISCONNECTED_TAG                = "DC "
    HEALBOT_DEAD_LABEL                      = "Dead"
    HEALBOT_DEAD_TAG                        = "RIP "
    HEALBOT_RES_TAG                         = "RES "
    HEALBOT_SUMMONS_TAG                     = "SUM "
    HEALBOT_OUTOFRANGE_LABEL                = "Out of range"
    HEALBOT_RANGE30                         = "In Range 27"
    HEALBOT_RECENTHEALS                     = "Recent heals"
    HEALBOT_OUTOFRANGE_TAG                  = "OOR-"
    HEALBOT_RESERVED_LABEL                  = "Reserved"
    HEALBOT_RESERVED_TAG                    = "R-"
    
    HEALBOT_OPTIONS_SHOWUNITBUFFTIME        = "Show my buffs";
    HEALBOT_OPTIONS_SHOWUNITBUFFREQUIRED    = "Show required buffs";
    HEALBOT_OPTIONS_BUFFSTEXTTIMER          = "Show buff before it expires";
    HEALBOT_OPTIONS_SHORTBUFFTIMER          = "Short buffs"
    HEALBOT_OPTIONS_LONGBUFFTIMER           = "Long buffs"
    
    HEALBOT_OPTIONS_NOTIFY_MSG              = "Message"
    HEALBOT_OPTIONS_CASTNOTIFYTAGS          = " #s=spell name  -  #l=spell link  -  #n=players name "
    HEALBOT_WORDS_YOU                       = "you";
    HEALBOT_WORDS_MOREMEM                   = "More Memory";
    HEALBOT_WORDS_LESSMEM                   = "Less Memory";
    HEALBOT_WORDS_MORECPU                   = "More CPU";
    HEALBOT_WORDS_LESSCPU                   = "Less CPU";
    HEALBOT_WORDS_CRITICAL                  = "Critical";
    HEALBOT_WORDS_INJURED                   = "Injured";
    HEALBOT_WORDS_HEALTHY                   = "Healthy";
    HEALBOT_NOTIFYOTHERMSG                  = "Casting #s on #n";

    HEALBOT_OPTIONS_HOTPOSITION             = "Icon position"
    HEALBOT_OPTIONS_HOTSHOWTEXT             = "Show icon text"
    HEALBOT_OPTIONS_HOTTEXTCOUNT            = "Count"
    HEALBOT_OPTIONS_HOTTEXTDURATION         = "Duration"
    HEALBOT_OPTIONS_ICONSCALE               = "Icon Scale"
    HEALBOT_OPTIONS_MAXICONS                = "Max Icons"
    HEALBOT_OPTIONS_ICONSPACER              = "Icon Spacer"
    HEALBOT_OPTIONS_EMERGBUTTONUSE          = "Use the Emergency Bar"
    HEALBOT_OPTIONS_BUFFSAUTOTIMED          = "Timed Buffs"
    HEALBOT_OPTIONS_BUFFSAUTOALL            = "All Buffs"

    HEALBOT_OPTIONS_AGGROBARSIZE            = "Aggro bar size"
    HEALBOT_OPTIONS_DOUBLETEXTLINES         = "Double text lines"
    HEALBOT_OPTIONS_TEXTALIGNMENT           = "Horizontal Alignment"
    HEALBOT_OPTIONS_TEXTOFFSET              = "Vertical Offset"
    HEALBOT_OPTIONS_TEXTHOROFFSET           = "Horizontal Offset"
    HEALBOT_OPTIONS_EMERGINJTRIG            = "Injured threshold"
    HEALBOT_OPTIONS_EMERGCRITTRIG           = "Critical threshold"
    HEALBOT_OPTIONS_CUSTOMCOLHEALTH         = "Health bar custom col"..HEALBOT_enWORD_COLOUR_SUFFIX.."s"
    HEALBOT_OPTIONS_CUSTOMCOLBACK           = "Background bar custom col"..HEALBOT_enWORD_COLOUR_SUFFIX.."s"
    HEALBOT_OPTIONS_CUSTOMCOLINHEAL         = "Incoming heals bar custom col"..HEALBOT_enWORD_COLOUR_SUFFIX.."s"
    HEALBOT_OPTIONS_CUSTOMCOLABSORB         = "Absorb effects bar custom col"..HEALBOT_enWORD_COLOUR_SUFFIX.."s"
    HEALBOT_OPTIONS_CUSTOMCOLBACKBOR        = "Background border custom col"..HEALBOT_enWORD_COLOUR_SUFFIX.."s"
    HEALBOT_OPTIONS_CUSTOMTEXTCOLNAME       = "Name text custom col"..HEALBOT_enWORD_COLOUR_SUFFIX.."s"
    HEALBOT_OPTIONS_CUSTOMTEXTCOLHEALTH     = "Health text custom col"..HEALBOT_enWORD_COLOUR_SUFFIX.."s"
    HEALBOT_OPTIONS_CUSTOMTEXTCOLSTATE      = "State text bar custom col"..HEALBOT_enWORD_COLOUR_SUFFIX.."s"
    HEALBOT_OPTIONS_CUSTOMTEXTCOLAGGRO      = "Aggro text bar custom col"..HEALBOT_enWORD_COLOUR_SUFFIX.."s"
    HEALBOT_OPTIONS_TXTOFFSET               = "Offset"
    HEALBOT_OPTIONS_TXTDEPTH                = "Depth"
    HEALBOT_OPTIONS_TXTSIZE                 = "Size"
    HEALBOT_WORDS_SPACE                     = "Space"
    HEALBOT_OPTIONS_MAXCHARS                = "Max Characters"
    HEALBOT_OPTIONS_PLAYERMAXCHARS          = "Max Characters - Player Name"
    HEALBOT_OPTIONS_MOBMAXCHARS             = "Max Characters - Mob Name"
    HEALBOT_VEHICLE                         = "Vehicle"
    HEALBOT_WORDS_ERROR                     = "Error"
    HEALBOT_SPELL_NOT_FOUND                 = "Spell Not Found"
    HEALBOT_OPTIONS_DISABLETOOLTIPINCOMBAT  = "Hide Tooltip in Combat"

    HEALBOT_OPTIONS_BUFFNAMED               = "Enter the player names to watch for\n\n"
    HEALBOT_WORD_ALWAYS                     = "Always";
    HEALBOT_WORD_SOLO                       = "Solo";
    HEALBOT_WORD_NEVER                      = "Never";
    HEALBOT_SHOW_CLASS_AS_ICON              = "as icon";
    HEALBOT_SHOW_CLASS_AS_TEXT              = "as text";
    HEALBOT_SHOW_ROLE                       = "show role when set";
    HEALBOT_SHOW_PLAYERROLE                 = "Show role";
    HEALBOT_SHOW_RAIDRANK                   = "Show rank";
    HEALBOT_SHOW_HIDEROLEWHENRANK           = "Hide role when rank exists";

    HEALBOT_SHOW_INCHEALS                   = "Show incoming heals";
    
    HEALBOT_FORHELP    = "For options use: "
    HEALBOT_HELP={ [1] = "[HealBot] /hb h -- Display help",
                   [2] = "[HealBot] /hb o -- Toggles options",
                   [3] = "[HealBot] /hb t -- Toggle Healbot between disabled and enabled",
                   [4] = "[HealBot] /hb bt -- Toggle Buff Monitor between disabled and enabled",
                   [5] = "[HealBot] /hb dt -- Toggle Debuff Monitor between disabled and enabled",
                   [6] = "[HealBot] /hb skin <skinName> -- Switch Skins",
                   [7] = "[HealBot] /hb d -- Reset options to default",
                   [8] = "[HealBot] /hb spt -- Self Pet toggle",
                   [9] = "[HealBot] /hb hs -- Display additional slash commands",
                   [10] = "[HealBot] - All commands are listed on the HealBot website at "..HEALBOT_ABOUT_URL,
                  }

    HEALBOT_HELP2={ [1] = "[HealBot] /hb rtb -- Toggle restrict target bar to Left=SmartCast and Right=add/remove to/from Private List",
                    [2] = "[HealBot] /hb aggro 2 <n> -- Set aggro level 2 on threat percentage <n>",
                    [3] = "[HealBot] /hb aggro 3 <n> -- Set aggro level 3 on threat percentage <n>",
                    [4] = "[HealBot] /hb tr <Role> -- Set highest role priority for SubSort by Role. Valid Roles are 'TANK', 'HEALER' or 'DPS'",
                    [5] = "[HealBot] /hb use10 -- Automatically use Engineering slot 10",
                    [6] = "[HealBot] - Also see Commands on the General tab in Options",
                  }
                  
                  
    HEALBOT_OPTION_HIGHLIGHTACTIVEBAR       = "Highlight"
    HEALBOT_OPTION_HIGHLIGHTTARGETBAR       = "Highlight target"
    HEALBOT_OPTIONS_TESTBARS                = "Test Bars"
    HEALBOT_OPTIONS_TURNTESTBARSON          = "Turn On"
    HEALBOT_OPTIONS_TURNTESTBARSOFF         = "Turn Off"
    HEALBOT_OPTION_NUMBARS                  = "Number of Bars"
    HEALBOT_OPTION_NUMTANKS                 = "Number of Tanks"
    HEALBOT_OPTION_NUMMYTARGETS             = "Number of MyTargets"
    HEALBOT_OPTION_NUMHEALERS               = "Number of Healers"
    HEALBOT_OPTION_NUMPETS                  = "Number of Pets"
    HEALBOT_OPTION_DEBUFFICONS              = "Show debuff icons"
    HEALBOT_OPTION_BUFFICONS                = "Show buff icons"
    HEALBOT_OPTION_EXTRAICONS               = "Show extra icons"
    HEALBOT_WORD_TEST                       = "Test";
    HEALBOT_OPTION_TESTMODE                 = "Test mode";
    HEALBOT_WORD_TEXT                       = "Text";
    HEALBOT_WORD_OFF                        = "Off";
    HEALBOT_WORD_ON                         = "On";
    HEALBOT_WORD_ONWITHOUTSOUND             = "On without sound";
    HEALBOT_WORD_ONWITHSOUND                = "On with sound";
    HEALBOT_OPTION_FRAMEPADDING         = "Frame padding"

    HEALBOT_OPTIONS_TAB_CHAT                = "Chat"
    HEALBOT_OPTIONS_TAB_HEADERS             = "Headers"
    HEALBOT_OPTIONS_TAB_BARS                = "Bars"
    HEALBOT_OPTIONS_TAB_BUTTONS             = "Buttons"
    HEALBOT_OPTIONS_TAB_ICONS               = "Icons"
    HEALBOT_OPTIONS_TAB_INDICATORS          = "Indicators"
    HEALBOT_OPTIONS_AGGROADAPALERT          = "Adaptive alert level"
    HEALBOT_OPTIONS_TAB_AGGROINDICATORS     = "Aggro indicators"
    HEALBOT_OPTIONS_TAB_LOWMANAINDICATORS   = "Low mana indicators"
    HEALBOT_OPTIONS_TAB_SELFCASTINDICATORS  = "Self cast icon indicators"
    HEALBOT_OPTIONS_TAB_POWERINDICATORS     = "Power indicators"
    HEALBOT_OPTIONS_TAB_WARNING             = "Warning"
    HEALBOT_OPTIONS_SKINDEFAULTFOR          = "Skin default for"
    HEALBOT_OPTIONS_INCHEAL                 = "Incoming heals"
    HEALBOT_OPTIONS_INCABSORB               = HEALBOT_classicABSORBHOT.."s"
    HEALBOT_OPTIONS_NOOVERHEALS             = "No overheals"
    HEALBOT_WORD_OVERHEALS                  = "Overheals"
    HEALBOT_WORD_ARENA                      = "Arena"
    HEALBOT_WORD_BATTLEGROUND               = "Battle Ground"
    HEALBOT_WORD_BG10                       = "BG 10"; 
    HEALBOT_WORD_BG15                       = "BG 15";
    HEALBOT_WORD_BG40                       = "BG 40";     
    HEALBOT_OPTIONS_TEXTOPTIONS             = "Bar Text"
    HEALBOT_WORD_PARTY                      = "Party"
    HEALBOT_WORD_COLOURS                    = "Col"..HEALBOT_enWORD_COLOUR_SUFFIX.."s";
    HEALBOT_WORD_COLOUR                     = "Col"..HEALBOT_enWORD_COLOUR_SUFFIX
    HEALBOT_OPTIONS_COMBOAUTOTARGET         = "Auto\nTarget"
    HEALBOT_OPTIONS_COMBOAUTOTRINKET        = "Auto Trinket"
    HEALBOT_OPTIONS_COMBOBINDS              = "Binds"
    HEALBOT_OPTIONS_GROUPSPERCOLUMN         = "Use Groups per Column"
    HEALBOT_WORD_WHISPER                    = "Whisper"
    HEALBOT_WORD_GUILD                      = "Guild"

    HEALBOT_OPTIONS_MAINSORT                = "Main sort"
    HEALBOT_OPTIONS_SUBSORT                 = "Sub sort"
    HEALBOT_OPTIONS_SUBSORTINC              = "Also sub sort:"

    HEALBOT_OPTIONS_BUTTONCASTMETHOD        = "Cast when button"
    HEALBOT_OPTIONS_BUTTONCASTPRESSED       = "Pressed"
    HEALBOT_OPTIONS_BUTTONCASTRELEASED      = "Released"

    HEALBOT_WORD_EXPLORING                  = "Exploring"
    HEALBOT_WORD_INCOMBAT                   = "In Combat"
    HEALBOT_WORD_NEUTRAL                    = "Neutral"
    HEALBOT_WORD_RESTING                    = "Resting"
    HEALBOT_WORD_RAIDER                     = "Raider"
    HEALBOT_WORD_HEALER                     = "Healer"
    HEALBOT_WORD_DAMAGER                    = "Damager"
    HEALBOT_WORD_TANK                       = "Tank"
    HEALBOT_WORD_MAINTANK                   = "Main Tank"
    HEALBOT_WORD_PRIVATETANK                = "Private Tank"
    HEALBOT_WORD_PRIVATEHEALER              = "Private Healer"
    HEALBOT_WORD_GROUPLEADER                = "Group Leader"
    HEALBOT_WORD_RAIDLEADER                 = "Raid Leader"
    HEALBOT_WORD_RAIDASSISTANT              = "Raid Assistant"
    HEALBOT_WORD_MASTERLOOTER               = "Master Looter"
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
    HEALBOT_OPTIONS_EXTRASKINS              = "Extra Skins"
    HEALBOT_OPTIONS_BUTTONEXPORT            = "Export"
    HEALBOT_OPTIONS_BUTTONPOSTLINK          = "Post Link"
    HEALBOT_OPTIONS_BUTTONPOST              = "Post"
    HEALBOT_OPTIONS_BUTTONIMPORT            = "Import"
    HEALBOT_OPTIONS_BUTTONIMPORTMETHOD      = "Import Method"
    HEALBOT_IMPORT_OVERWRITEALL             = "Overwrite All"
    HEALBOT_IMPORT_MERGEALL                 = "Merge All"
    HEALBOT_IMPORT_MERGENEW                 = "Merge New"
    HEALBOT_IMPORT_CREATEORREPLACE          = "Create or Replace"

    HEALBOT_CHAT_ADDONID                    = "[HealBot] "
    HEALBOT_CHAT_NEWVERSION1                = "A new version is available"
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
    HEALBOT_CHAT_POSSIBLEMISSINGMEDIA       = "Unable to receive all Skin settings - Possibly missing SharedMedia"
    HEALBOT_CHAT_MACROSOUNDON               = "Sound not suppressed when using auto trinkets"
    HEALBOT_CHAT_MACROSOUNDOFF              = "Sound suppressed when using auto trinkets"
    HEALBOT_CHAT_MACROERRORON               = "Errors not suppressed when using auto trinkets"
    HEALBOT_CHAT_MACROERROROFF              = "Errors suppressed when using auto trinkets"
    HEALBOT_CHAT_USE10ON                    = "Auto Trinket - Use10 is on - You must enable an existing auto trinket for use10 to work"
    HEALBOT_CHAT_USE10OFF                   = "Auto Trinket - Use10 is off"
    HEALBOT_CHAT_SKINREC                    = " skin imported" 
    HEALBOT_CHAT_MAINASSISTOFF              = "Off Tanks excluded from Main Tanks"
    HEALBOT_CHAT_MAINASSISTON               = "Off Tanks included with Main Tanks"
    HEALBOT_OPTIONS_OFFTANKS                = "Include Off Tanks with Main Tanks"

    HEALBOT_OPTIONS_SELFCASTS               = "Self casts only"
    HEALBOT_OPTIONS_SELFINDICATOR           = "Self indicator"
    HEALBOT_OPTIONS_HOTSHOWICON             = "Show icon"
    HEALBOT_OPTIONS_ALLSPELLS               = "Buffs / HoTs"
    HEALBOT_OPTIONS_BUFFNAME                = "Buff Name"
    HEALBOT_OPTIONS_DOUBLEROW               = "Double row"
    HEALBOT_OPTIONS_HOTBELOWBAR             = "Below bar"
    HEALBOT_OPTIONS_OTHERSPELLS             = "Other spells"
    HEALBOT_WORD_MACROS                     = "Macros"
    HEALBOT_WORD_SELECT                     = "Select"
    HEALBOT_WORD_SELECT_ALL                 = "Select all"
    HEALBOT_WORD_SELECT_NONE                = "Select none"
    HEALBOT_OPTIONS_QUESTION                = "?"
    HEALBOT_WORD_CANCEL                     = "Cancel"
    HEALBOT_WORD_DONE                       = "Done"
    HEALBOT_WORD_COMMANDS                   = "Commands"
    HEALBOT_WORD_COMMAND                    = "Command"
    HEALBOT_OPTIONS_BARHEALTH3              = "as health";
    HEALBOT_SORTBY_ROLE                     = "Role"
    HEALBOT_WORD_DPS                        = "DPS"
    HEALBOT_CHAT_TOPROLEERR                 = " role not valid in this context - use 'TANK', 'DPS' or 'HEALER'"
    HEALBOT_CHAT_NEWTOPROLE                 = "Highest top role is now "
    HEALBOT_CHAT_SUBSORTPLAYER1             = "Player will be set to first in SubSort"
    HEALBOT_CHAT_SUBSORTPLAYER2             = "Player will be sorted normally in SubSort"
    HEALBOT_OPTIONS_SHOWREADYCHECK          = "Show Ready Check";
    HEALBOT_OPTIONS_SHOWCOMBATSTATE         = "Show Combat State";
    HEALBOT_OPTIONS_SHOWHOSTILE             = "Show Hostile";
    HEALBOT_OPTIONS_SHOWLEADER              = "Show Leader";
    HEALBOT_OPTIONS_SHOWAFK                 = "Show AFK";
    HEALBOT_OPTIONS_SHOWRESTING             = "Show Resting (Player only)";
    HEALBOT_OPTIONS_SHOWCLASSICON           = "Show Class";
    HEALBOT_OPTIONS_SUBSORTSELFFIRST        = "Sub Sort - Self First"
    HEALBOT_OPTION_AGGROPCTBAR              = "Move bar"
    HEALBOT_OPTION_AGGROPCTTRACK            = "Show aggro percentage" 
    HEALBOT_OPTIONS_ALERTAGGROLEVEL0        = "0 - Off"
    HEALBOT_OPTIONS_ALERTAGGROLEVEL1        = "1 - Low threat"
    HEALBOT_OPTIONS_ALERTAGGROLEVEL2        = "2 - High threat"
    HEALBOT_OPTIONS_ALERTAGGROLEVEL3        = "3 - Tanking"
    HEALBOT_OPTIONS_AGGROALERT              = "Aux bar alert level"
    HEALBOT_OPTIONS_AGGROINDALERT           = "Indicator alert level"
    HEALBOT_OPTIONS_TOOLTIPSHOWHOT          = "Show active monitored HoT details"
    HEALBOT_WORDS_MIN                       = "min"
    HEALBOT_WORDS_MAX                       = "max"
    HEALBOT_CHAT_SELFPETSON                 = "Self Pet switched on"
    HEALBOT_CHAT_SELFPETSOFF                = "Self Pet switched off"
    HEALBOT_CHAT_PLAYERROLESON              = "Allow player roles switched on"
    HEALBOT_CHAT_PLAYERROLESOFF             = "Allow player roles switched off"
    HEALBOT_ALLOWTALENTQUERYON              = "Allow querying player talents On"
    HEALBOT_ALLOWTALENTQUERYOFF             = "Allow querying player talents Off"
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
    HEALBOT_WORD_ZONE                       = "Zone"
    HEALBOT_WORD_SPEC                       = "Spec"
    HEALBOT_OPTIONS_TAB_ALERT               = "Alert"
    HEALBOT_OPTIONS_TAB_SORT                = "Sort"
    HEALBOT_OPTIONS_TAB_HIDE                = "Hide"
    HEALBOT_OPTIONS_TAB_VISIBILITY          = "Visibility"
    HEALBOT_OPTIONS_TAB_AGGRO               = "Aggro"
    HEALBOT_OPTIONS_TAB_AUX                 = "Aux"
    HEALBOT_OPTIONS_TAB_ICONTEXT            = "Icon text"
    HEALBOT_OPTIONS_TAB_DEBUFFICONTEXT      = "Debuff icon text"
    HEALBOT_OPTIONS_TAB_BUFFICONTEXT        = "Buff icon text"
    HEALBOT_OPTIONS_TAB_TEXT                = "Text"
    HEALBOT_OPTIONS_AGGRO3COL               = "Aggro bar\ncol"..HEALBOT_enWORD_COLOUR_SUFFIX
    HEALBOT_OPTIONS_AGGROFLASHFREQ          = "Flash frequency"
    HEALBOT_OPTIONS_WORD_FASTER             = "Faster"
    HEALBOT_OPTIONS_WORD_SLOWER             = "Slower"
    HEALBOT_OPTIONS_AGGROFLASHALPHA         = "Flash opacity"
    HEALBOT_OPTIONS_FOCUSGROUPS             = "Focus Groups"
    HEALBOT_OPTIONS_FOCUSGROUPS1            = "OFF"
    HEALBOT_OPTIONS_FOCUSGROUPS2            = "ON: Fade unfocused groups"
    HEALBOT_OPTIONS_FOCUSGROUPS3            = "ON: Hide unfocused groups"
    HEALBOT_OPTIONS_SHOWDURATIONFROM        = "Show duration from"
    HEALBOT_OPTIONS_SHOWDURATIONWARN        = "Duration warning from"
    HEALBOT_OPTIONS_GOTOAUXCONFIG           = "Set Aux Bar Type"
    HEALBOT_CMD_RESETCUSTOMDEBUFFS          = "Reset custom debuffs"
    HEALBOT_CMD_RESETSKINS                  = "Reset skins"
    HEALBOT_CMD_CLEARBLACKLIST              = "Clear BlackList"
    HEALBOT_CMD_TOGGLEDISLIKEMOUNT          = "Toggle Dislike Mount"
    HEALBOT_OPTION_DISLIKEMOUNT_ON          = "Dislike Current Mount"
    HEALBOT_CMD_DISMOUNT                    = "Dismount"
    HEALBOT_OPTION_DISLIKEMOUNT_OFF         = "No longer Dislike Current Mount"
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
    HEALBOT_OPTIONS_BINDTOCLICK             = "Bind to Click"
    HEALBOT_CMD_DELCUSTOMDEBUFF9            = "Delete custom debuffs on priority 9"
    HEALBOT_CMD_DELCUSTOMDEBUFF10           = "Delete custom debuffs on priority 10"
    HEALBOT_CMD_DELCUSTOMDEBUFF11           = "Delete custom debuffs on priority 11"
    HEALBOT_CMD_DELCUSTOMDEBUFF12           = "Delete custom debuffs on priority 12"
    HEALBOT_ACCEPTSKINS                     = "Accept Skins from others"
    HEALBOT_SUPPRESSSOUND                   = "Auto Trinket: Suppress sound"
    HEALBOT_SUPPRESSERROR                   = "Auto Trinket: Suppress errors"
    HEALBOT_PERFLEVEL                       = "Performance Level"
    HEALBOT_SKIN_CHECK_DONE                 = "Integrity check of skins complete"
    HEALBOT_ENABLE_CUSTOM_BUFFS             = "All custom buffs have been enabled"
    HEALBOT_ENABLE_CUSTOM_DEBUFFS           = "All custom debuffs have been enabled"
    HEALBOT_ALLOW_DUPLICATES                = "Allow Duplicates"
    HEALBOT_OPTIONS_AUXSETTINGS             = "Auxiliary Bars Settings"
    HEALBOT_OPTIONS_AUXASSIGN               = "Auxiliary Bars Assignments"
    HEALBOT_OPTIONS_AUXCONFIG               = "Auxiliary Bar Configuration"
    HEALBOT_OPTIONS_VISSTANDARD             = "Standard Frames"
    HEALBOT_OPTIONS_ENEMYFRAME              = "Enemy Frame"
    HEALBOT_OPTIONS_AUXFLASH                = "Variable Opacity"
    HEALBOT_WORD_ASSIGNMENT                 = "Assignment:"
    HEALBOT_WORD_ANCHOR                     = "Anchor:"
    HEALBOT_OPTIONS_AUXOVERLAP              = "Extend Aux bars size"
    HEALBOT_OPTIONS_AUXINDCONFIG            = "Individual Bar Configuration"
    HEALBOT_OPTIONS_AUX                     = "Aux Bar"
    HEALBOT_OPTIONS_FULLAUX                 = "Auxiliary Bar "
    HEALBOT_OPTIONS_AUXOPACITYTYPE          = "Opacity Type"
    HEALBOT_OPTIONS_AUXOPACITYTYPE1         = "Fixed"
    HEALBOT_OPTIONS_AUXOPACITYTYPE2         = "Variable"

    HEALBOT_WORD_HEALTH                     = "Health"
    HEALBOT_WORD_GOLD                       = "Gold"
    HEALBOT_WORD_SILVER                     = "Silver"
    HEALBOT_WORD_BLUE                       = "Blue"
    HEALBOT_WORD_RED                        = "Red"
    HEALBOT_WORD_GREEN                      = "Green"
    HEALBOT_WORD_AQUA                       = "Aqua"
    HEALBOT_WORD_WHITE                      = "White"
    HEALBOT_WORD_DARK                       = "Dark"
    HEALBOT_WORD_ORANGE                     = "Orange"
    HEALBOT_WORD_LIME                       = "Lime"
    HEALBOT_WORD_YELLOW                     = "Yellow"
    HEALBOT_WORD_FUCHSIA                    = "Fuchsia"
    HEALBOT_WORD_PURPLE                     = "Purple"
    HEALBOT_WORD_PINK                       = "Pink"
    HEALBOT_WORD_TEAL                       = "Teal"
    HEALBOT_WORD_BROWN                      = "Brown"
    HEALBOT_WORD_BLACK                      = "Black"
    HEALBOT_WORD_AND                        = "and"
    HEALBOT_WORD_PLAYERS                    = "Players"
    HEALBOT_WORD_PLAYER                     = "Player"
    HEALBOT_OPTIONS_CPUUSAGE                = "CPU Usage"
    HEALBOT_OPTIONS_THEME                   = "Options theme"
    HEALBOT_OPTIONS_DONT_SHOW               = "Don't show"
    HEALBOT_OPTIONS_HAZARDONLY              = "Hazard Only"
    HEALBOT_OPTIONS_SAME_AS_HLTH_CURRENT    = "Same as health (current health)"
    HEALBOT_OPTIONS_SAME_AS_HLTH_FUTURE     = "Same as health (future health)"
    HEALBOT_OPTIONS_FUTURE_HLTH             = "Future health"
    HEALBOT_OPTIONS_CLASSHLTHMIX            = "Class Health mix"
    HEALBOT_OPTIONS_ADAPTIVE                = "Adaptive"
    HEALBOT_OPTIONS_ADAPTIVECLASSMIX        = "Adaptive Class mix"
    HEALBOT_OPTIONS_ADAPTIVECUSTOMMIX       = "Adaptive Custom mix"
    HEALBOT_OPTIONS_ADAPTIVEONLY            = "Adaptive only"
    HEALBOT_OPTIONS_ADAPTIVEHEALTHBAR       = "Adaptive and Health bar"
    HEALBOT_OPTIONS_HEALTHBARONLY           = "Health bar only"
    HEALBOT_SKIN_HEALTHBARCOL_TEXT          = "Health bar"
    HEALBOT_SKIN_BORDER_HAZARD              = "Border hazard"
    HEALBOT_SKIN_BORDER_HAZARDU             = "Border Hazard"
    HEALBOT_SKIN_FRAME_GLOW                 = "Bar glow lines"
    HEALBOT_SKIN_FRAME_GLOWSTARS            = "Bar glow stars"
    HEALBOT_SKIN_FRAME_GLOWBLIZZ            = "Alt Blizzard glow"
    HEALBOT_SKIN_BORDER_COL                 = "Border col"..HEALBOT_enWORD_COLOUR_SUFFIX
    HEALBOT_SKIN_NAMETEXTCOL_TEXT           = "Text col"..HEALBOT_enWORD_COLOUR_SUFFIX
    HEALBOT_SKIN_OVERLAYCOL_TEXT            = "Overlay col"..HEALBOT_enWORD_COLOUR_SUFFIX
    HEALBOT_SKIN_HEALTHBACKCOL_TEXT         = "Background bar";
    HEALBOT_SKIN_BACKBORDERCOL_TEXT         = "Background border";
    HEALBOT_SKIN_INCHEALBARCOL_TEXT         = "Incoming heals";
    HEALBOT_OPTIONS_GROUP_PETS_BY_FIVE      = "Pets: Groups of five"
    HEALBOT_OPTIONS_OWN_PET_WITH_SELF       = "Own pet: with self"
    HEALBOT_OPTIONS_USEGAMETOOLTIP          = "Use game tooltip"
    HEALBOT_OPTIONS_SHOWWOWTOOLTIP          = "Show game tooltip information"
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER        = "Show power counter"
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER_PALA   = "Show holy power"
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER_ROGU   = "Show combo points"
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER_WARL   = "Show soul shards"
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER_MONK   = "Show chi power"
    HEALBOT_OPTIONS_DISABLEHEALBOTSOLO      = "only when solo"
    HEALBOT_OPTIONS_CUSTOM_ALLDISEASE       = "All Disease"
    HEALBOT_OPTIONS_CUSTOM_ALLMAGIC         = "All Magic"
    HEALBOT_OPTIONS_CUSTOM_ALLCURSE         = "All Curse"
    HEALBOT_OPTIONS_CUSTOM_ALLPOISON        = "All Poison"
    HEALBOT_OPTIONS_CUSTOM_ALLBOSS          = "All Bosses"
    HEALBOT_OPTIONS_CUSTOM_ALLTIMED         = "All Timed"
    HEALBOT_OPTIONS_CUSTOM_IDMETHOD         = "Identify By"
    HEALBOT_OPTIONS_CUSTOM_CASTBY           = "Cast By"
    HEALBOT_OPTIONS_CUSTOM_IDMETHODSID      = "Spell ID"
    HEALBOT_OPTIONS_CUSTOM_IDMETHODSNAME    = "Spell Name"
    HEALBOT_OPTIONS_CUSTOM_IDMETHODSBOTH    = "ID or Name"

    HEALBOT_BLIZZARD_MENU                   = "Blizzard menu"
    HEALBOT_HB_MENU                         = "Healbot menu"
    HEALBOT_TARGETVEHICLE                   = "Target Vehicle or Pet"
    HEALBOT_TOGGLE_ENABLED                  = "Toggle enabled"
    HEALBOT_TOGGLE_MYTARGETS                = "Toggle Private List"
    HEALBOT_WORD_PERMANENT                  = "Permanent"
    HEALBOT_TOGGLE_PRIVATETANKS             = "Toggle private tanks"
    HEALBOT_TOGGLE_PRIVATEHEALERS           = "Toggle private healers"
    HEALBOT_RESET_BAR                       = "Reset bar"
    HEALBOT_HIDE_BARS                       = "Hide bars when player not visible (over 100 yards)"
    HEALBOT_MOUNTSPETS                      = "Mounts and Pets menu"
    HEALBOT_FAVMOUNT                        = "Favourite Mount"
    HEALBOT_FAVPET                          = "Favourite Pet"
    HEALBOT_MOUNTS                          = "Mounts"
    HEALBOT_RANDOMMOUNT                     = "Random Mount"
    HEALBOT_RANDOMGOUNDMOUNT                = "Random Ground Mount"
    HEALBOT_RANDOMPET                       = "Random Pet"
    HEALBOT_RANDOMFAVMOUNT                  = "Random Favourite Mount"
    HEALBOT_RANDOMFAVPET                    = "Random Favourite Pet"        
    HEALBOT_EXTRASKINS_CAT_GROUP            = "Group"
    HEALBOT_EXTRASKINS_CAT_SRAID            = "Small Raid"
    HEALBOT_EXTRASKINS_CAT_LRAID            = "Large Raid"
    HEALBOT_MACRO                           = "Macro"
    HEALBOT_EMOTE                           = "Emote"
    HEALBOT_EMOTES                          = "Emotes"
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
    HEALBOT_CLASSIC_HOT_IHDUR               = "Classic HoT incoming heal duration set to" 
    HEALBOT_RESLAG_INDICATOR_ERROR          = "Invalid number - The number must be between 1 and 30" 
    HEALBOT_RESTRICTTARGETBAR_ON            = "Restrict Target bar turned On"
    HEALBOT_RESTRICTTARGETBAR_OFF           = "Restrict Target bar turned Off"
    HEALBOT_AGGRO2_ERROR_MSG                = "To set aggro level 2, threat percentage must be between 25 and 95"
    HEALBOT_AGGRO3_ERROR_MSG                = "To set aggro level 3, threat percentage must be between 75 and 100"
    HEALBOT_AGGRO2_SET_MSG                  = "Aggro level 2 set at threat percentage "
    HEALBOT_AGGRO3_SET_MSG                  = "Aggro level 3 set at threat percentage "
    HEALBOT_WORD_THREAT                     = "Threat"
    HEALBOT_AGGRO_ERROR_MSG                 = "Invalid aggro level - use 2 or 3"
  
    HEALBOT_OPTIONS_LOWMANAINDICATOR        = "Low mana indicator"
    HEALBOT_OPTIONS_LOWMANA                 = "Low mana"
    HEALBOT_OPTIONS_LOWMANAINDICATOR1       = "Don't show"
    HEALBOT_OPTIONS_LOWMANAINDICATOR2       = "*10% / **20% / ***30%"
    HEALBOT_OPTIONS_LOWMANAINDICATOR3       = "*15% / **30% / ***45%"
    HEALBOT_OPTIONS_LOWMANAINDICATOR4       = "*20% / **40% / ***60%"
    HEALBOT_OPTIONS_LOWMANAINDICATOR5       = "*25% / **50% / ***75%"
    HEALBOT_OPTIONS_LOWMANAINDICATOR6       = "*30% / **60% / ***90%"

    HEALBOT_OPTIONS_SELFCASTIND             = "Self cast"
    HEALBOT_OPTION_IGNORE_AURA_RESTED       = "Ignore aura events when resting"

    HEALBOT_WORD_ENABLE                     = "Enable"
    HEALBOT_WORD_DISABLE                    = "Disable"

    HEALBOT_OPTIONS_PLUGINS                 = "Plugins"
    HEALBOT_OPTIONS_PLUGIN_NA               = "Plugin not available"

    HEALBOT_OPTIONS_CONTENT_ABOUT           = "        About"
    HEALBOT_OPTIONS_CONTENT_OVERRIDES       = "        " .. HEALBOT_OPTIONS_TAB_OVERRIDES
    HEALBOT_OPTIONS_CONTENT_GENERAL         = "        " .. HEALBOT_OPTIONS_TAB_GENERAL
    HEALBOT_OPTIONS_CONTENT_SPELLS          = "        " .. HEALBOT_OPTIONS_TAB_SPELLS
    HEALBOT_OPTIONS_CONTENT_SKINS           = "        " .. HEALBOT_OPTIONS_TAB_SKIN
    HEALBOT_OPTIONS_CONTENT_CURE            = "        " .. HEALBOT_OPTIONS_TAB_DEBUFFS
    HEALBOT_OPTIONS_CONTENT_BUFFS           = "        " .. HEALBOT_OPTIONS_TAB_BUFFS
    HEALBOT_OPTIONS_CONTENT_TIPS            = "        " .. HEALBOT_OPTIONS_TAB_TIPS
    HEALBOT_OPTIONS_CONTENT_BINDS           = "        Binds"
    HEALBOT_OPTIONS_CONTENT_TEST            = "        Test"
    HEALBOT_OPTIONS_CONTENT_INOUT           = "        Import / Export"
    HEALBOT_OPTIONS_CONTENT_PLUGINS         = "        " .. HEALBOT_OPTIONS_PLUGINS
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

    HEALBOT_PLUGIN_THREAT                   = "HealBot Threat"
    HEALBOT_PLUGIN_TIMETODIE                = "HealBot TimeToDie"
    HEALBOT_PLUGIN_TIMETOLIVE               = "HealBot TimeToLive"
    HEALBOT_PLUGIN_EXTRABUTTONS             = "HealBot ExtraButtons"
    HEALBOT_PLUGIN_COMBATPROT               = "HealBot CombatProt"
    HEALBOT_PLUGIN_PERFORMANCE              = "HealBot Performance"
    HEALBOT_PLUGIN_MYCOOLDOWNS              = "HealBot MyCooldowns"
    HEALBOT_PLUGIN_TWEAKS                   = "HealBot Tweaks"
    HEALBOT_PLUGIN_REQUESTS                 = "HealBot Requests"
    HEALBOT_PLUGIN_AURAWATCH                = "HealBot AuraWatch"
    HEALBOT_PLUGIN_HEALTHWATCH              = "HealBot HealthWatch"
    HEALBOT_PLUGIN_MANAWATCH                = "HealBot ManaWatch"
    HEALBOT_PLUGIN_THREATPCT                = "Minimum threat"
    HEALBOT_PLUGIN_THREATMOBBARCOL          = "Mob bar colour"
    HEALBOT_PLUGIN_THREATMOBTEXTCOL         = "Mob text colour"
    HEALBOT_PLUGIN_COOLDOWNDURCOLS          = "Cooldown Duration Col"..HEALBOT_enWORD_COLOUR_SUFFIX.."s"
    HEALBOT_PLUGIN_SHORTDUR                 = "Short duration threshold (Secs)"
    HEALBOT_PLUGIN_MEDIUMDUR                = "Medium duration threshold (Secs)"
    HEALBOT_PLUGIN_ICONPOS                  = "Icons right side of frame"
    HEALBOT_PLUGIN_BARDIR                   = "Bars shrink from right to left"
    HEALBOT_PLUGIN_SHOWNAME                 = "Show spell name"
    HEALBOT_PLUGIN_SHOWTIME                 = "Show remaining time"
    HEALBOT_PLUGIN_BLACKLISTSESSION         = "Add for session"
    HEALBOT_PLUGIN_BLACKLISTPERM            = "Add permanently"
    HEALBOT_PLUGIN_BLACKLISTREMOVE          = "Remove"
    HEALBOT_PLUGIN_BLACKLISTED              = "Blacklisted"
    HEALBOT_PLUGIN_BLACKLISTEDHELP          = "(*) = Permanently blacklisted"
    HEALBOT_OPTIONS_USECP                   = "Use Crash and Combat Protection"
    HEALBOT_OPTIONS_USECPGROUP              = "Use Combat Protection in groups"
    HEALBOT_OPTIONS_USECPRAID               = "Use Combat Protection in raids"
    HEALBOT_OPTIONS_CPLOGONDURATION         = "Crash Protection duration after logon"
    HEALBOT_PLUGIN_EXTRABUTTONS_0610        = "Buttons 6 - 10"
    HEALBOT_PLUGIN_EXTRABUTTONS_1115        = "Buttons 11 - 15"
    HEALBOT_PLUGIN_EXTRABUTTONS_1620        = "Buttons 16 - 20"
    HEALBOT_PLUGIN_INTTIMER                 = "Internal timers and Range checks"
    HEALBOT_PLUGIN_FLUIDFREQ                = "Effects - Fuild Updates"
    HEALBOT_PLUGIN_FLASHFREQ                = "Effects - Flash Updates"
    HEALBOT_PLUGIN_STATEFREQ                = "Effects - State Updates"
    HEALBOT_PLUGIN_CPMACRO                  = "Macro name: "
    HEALBOT_PLUGIN_AGGRO2THRESHOLD          = "Aggro level 2 threshold"
    HEALBOT_PLUGIN_AGGRO3THRESHOLD          = "Aggro level 3 threshold"
    HEALBOT_PLUGIN_INHEALHOTTIME            = "Incoming heals HoT time"
    HEALBOT_PLUGIN_AUTOTIMEDBUFFDURATION    = "Custom buff - auto All Timed duration less than"
    HEALBOT_PLUGIN_AUTOTIMEDDURATION        = "Custom debuff - auto All Timed duration less than"
    HEALBOT_PLUGIN_SORTBYTOPROLE            = "Sort by role - Top role"
    HEALBOT_PLUGIN_USETRINKET10             = "Auto trinket includes gloves"
    HEALBOT_PLUGIN_CLASSICPLAYERROLES       = "Allow player roles in groups and raids"
    HEALBOT_PLUGIN_CLASSICNORANKS           = "Do not show ranks for Healing spells"
    HEALBOT_PLUGIN_REQUESTTEXT              = "Request text"
    HEALBOT_PLUGIN_FILTER                   = "Filter"
    HEALBOT_PLUGIN_NOFILTER                 = "No filter"
    HEALBOT_PLUGIN_REQUESTTABILITY          = "Request ability"
    HEALBOT_PLUGIN_REQUESTTTIMEOUT          = "Request timeout"
    HEALBOT_PLUGIN_BUFFCANCELSREQUEST       = "Buff cancels request"
    HEALBOT_PLUGIN_RANGECANCELSREQUEST      = "Player visible cancels request"
    HEALBOT_PLUGIN_DUPCANCELSREQUEST        = "Duplicate request cancels request"
    HEALBOT_PLUGIN_REQUEST                  = "Request"
    HEALBOT_PLUGIN_REQUESTTOOLTIP           = "Show in tooltip";
    HEALBOT_PLUGIN_REQUESTWARN              = "Show warning text";
    HEALBOT_PLUGIN_REQUESTCOL               = "Request col"..HEALBOT_enWORD_COLOUR_SUFFIX
    HEALBOT_PLUGIN_REQUESTSOUND             = "Play sound on request";
    HEALBOT_PLUGIN_AURAWATCHTARGETPLAYERS   = "Target players";
    HEALBOT_PLUGIN_AURAWATCHPLAYERSFILTER   = "Target players filter";
    HEALBOT_PLUGIN_BUFFWATCHONLYINCOMBAT    = "Only in combat";
    HEALBOT_PLUGIN_BUFFWATCHSELFBUFF        = "My spell";
    HEALBOT_PLUGIN_BUFFWATCHPLAYERSBUFF     = "Target players buff";
    HEALBOT_PLUGIN_BUFFWATCHPLAYERSTAG      = "Target players tag";
    HEALBOT_PLUGIN_BUFFWATCHPLAYERSDEBUFF   = "Target players debuff";
    HEALBOT_PLUGIN_BUFFWATCHSELFBUFFH       = "Alert when spell cooldown ends";
    HEALBOT_PLUGIN_BUFFWATCHSTATE1          = "Inactive"
    HEALBOT_PLUGIN_BUFFWATCHSTATE2          = "Wait on cooldown for "
    HEALBOT_PLUGIN_BUFFWATCHSTATE3          = "Wait on "
    HEALBOT_PLUGIN_BUFFWATCHSTATE5          = "Waiting on combat"
    HEALBOT_PLUGIN_BUFFWATCHTTIMEOUT        = "Alert timeout"
    HEALBOT_PLUGIN_BUFFWATCHCOL             = "Alert col"..HEALBOT_enWORD_COLOUR_SUFFIX
    HEALBOT_PLUGIN_BUFFWATCHSOUND           = "Play sound on alert";
    HEALBOT_PLUGIN_AURAWATCHT               = "Watch"
    HEALBOT_PLUGIN_AURAWATCHBUFFEXISTS      = "Buff exists"
    HEALBOT_PLUGIN_AURAWATCHBUFFEXISTSTAG   = "Buff exists with tag"
    HEALBOT_PLUGIN_AURAWATCHBUFFEXPIRE      = "Buff exists or not exists"
    HEALBOT_PLUGIN_AURAWATCHBUFFNOTEXIST    = "Buff does not exist"
    HEALBOT_PLUGIN_AURAWATCHDEBUFFEXISTS    = "Debuff exists"
    HEALBOT_PLUGIN_AURAWATCHDEBUFFEXISTSTAG = "Debuff exists with tag"
    HEALBOT_PLUGIN_AURAWATCHDEBUFFEXPIRE    = "Debuff exists or not exists"
    HEALBOT_PLUGIN_AURAWATCHDEBUFFNOTEXIST  = "Debuff does not exist"
    HEALBOT_PLUGIN_AURAWATCHHEALTHBELOW     = "Health below"
    HEALBOT_PLUGIN_AURAWATCHMANABELOW       = "Mana below"
    HEALBOT_PLUGIN_AURAWATCHAGGROLEVEL      = "Aggro level"
    HEALBOT_PLUGIN_TWEAKSDELETEALL          = "Delete All"
    HEALBOT_PLUGIN_TWEAKSENABLEALL          = "Enable All"
    HEALBOT_PLUGIN_TWEAKSDISABLEALL         = "Disable All"
    HEALBOT_PLUGIN_TWEAKSRESETALL           = "Reset All"
    HEALBOT_PLUGIN_TWEAKSCASTBYALL          = "Set Cast By to Everyone for all"
    HEALBOT_PLUGIN_TWEAKSCASTBYSELF         = "Set Cast By to Self for all"
    HEALBOT_PLUGIN_TWEAKSCOLOURNONE         = "Set Bar Col"..HEALBOT_enWORD_COLOUR_SUFFIX.." to None for all"
    HEALBOT_PLUGIN_TWEAKSCOLOURADAPTIVE     = "Set Bar Col"..HEALBOT_enWORD_COLOUR_SUFFIX.." to Adaptive Only for all"
    HEALBOT_PLUGIN_TWEAKSCOLOURADAPTBAR     = "Set Bar Col"..HEALBOT_enWORD_COLOUR_SUFFIX.." to Adaptive and Health Bar for all"
    HEALBOT_PLUGIN_TWEAKSCOLOURBARCOL       = "Set Bar Col"..HEALBOT_enWORD_COLOUR_SUFFIX.." to Bar Col"..HEALBOT_enWORD_COLOUR_SUFFIX.." Only for all"
    HEALBOT_PLUGIN_HEALTHALERTLEVEL         = "Health alert level"
    HEALBOT_PLUGIN_MANAALERTLEVEL           = "Mana alert level"
    HEALBOT_PLUGIN_ALERTMETHOD              = "Alert method"
    HEALBOT_PLUGIN_FORWARDTOHW              = "Forward to HealthWatch"
    HEALBOT_PLUGIN_FORWARDTOMW              = "Forward to ManaWatch"
    HEALBOT_PLUGIN_RETRYDURATION            = "Received from BuffWatch - Retry duration"
    HEALBOT_PLUGIN_REPEATONCD               = "Repeat after timeout";

    HEALBOT_CUSTOM_CASTBY_EVERYONE          = "Everyone"
    HEALBOT_CUSTOM_CASTBY_ENEMY             = "Enemy"
    HEALBOT_CUSTOM_CASTBY_FRIEND            = "Friend"
    HEALBOT_OPTIONS_MYCLASS                 = "My Class"
    HEALBOT_OPTIONS_CASTBYSELF              = "Cast by Self"
    HEALBOT_OPTIONS_CASTBYMYCLASS           = "Cast by My Class"
    HEALBOT_OPTIONS_CASTBYEVERYONE          = "Cast by Everyone"
    
    HEALBOT_CUSTOM_CAT_CUSTOM_AUTOMATIC     = "Automatic Debuffs"
    HEALBOT_CUSTOM_CAT_CUSTOM_AUTOBUFFS     = "Automatic Buffs"
    HEALBOT_CUSTOM_DEBUFF_CATS = {}

    HEALBOT_ABOUT_DESC1                    = "Add frames with skinable bars for healing, decursive, buffing, ressing, aggro tracking"
    HEALBOT_ABOUT_WEBSITE                  = "Website:"
    HEALBOT_ABOUT_AUTHORH                  = "Author:"
    HEALBOT_ABOUT_AUTHORD                  = "Strife"
    HEALBOT_ABOUT_CATH                     = "Discord:"
    HEALBOT_ABOUT_CATD                     = "discord.gg/gwa6rdCeZ4"
    HEALBOT_ABOUT_CREDITH                  = "Credits"
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
                                      [13]  = "Options - How do I setup 'Private List'",
                                      [14]  = "Options - How do I setup 'Private Tanks'",
                                      [15]  = "Options - Will Healbot create a bar for an NPC",
                                      [16]  = "Range - I can't see when players are out of range, how do I fix this",
                                      [17]  = "Spells - Healbot casts a different spell to my setup",
                                      [18]  = "Spells - I can no longer cast heals on unwounded targets",
                                      [19]  = "Skins - Are more skins available?",
                                      [20]  = "Frames - I am unable to move the frame, is it locked?",
                                  }

    HEALBOT_ABOUT_FAQ_SPELLS_ANSWER01       = "This is due to options set on the Spells tab \n" ..
                                              "try changing the following and testing: \n\n" ..
                                              "On the Spells tab: Turn off SmartCast \n\n" ..
                                              "Note: It is expected that most users will want to \n" ..
                                              "turn SmartCast back on"
                                              
    HEALBOT_ABOUT_FAQ_ANSWERS = {     [1]   = "You are monitoring for missing buffs \n\n" .. 
                                              "This can be turned off on the Buffs General tab \n" ..
                                              "Alternatively click on the bar and cast the buff",
                                      [2]   = "This is blizzard functionality, not Healbot \n\n" .. 
                                              "Using the standard blizzard frames, \n" ..
                                              "try casting a spell that is on Cooldown \n" ..
                                              "Notice how the cursor turns blue. \n\n" ..
                                              "Healbot has built in functionally to prevent \n" ..
                                              "this. on the Spells tab use Avoid Blue Cursor",
                                      [3]   = "Yes \n\n"..
                                              "Visit "..HEALBOT_ABOUT_URL.." for examples",
                                      [4]   = "Yes \n\n"..
                                              "Visit "..HEALBOT_ABOUT_URL.." for examples",
                                      [5]   = "Create a macro using [@mouseover] \n\n\n" ..
                                              "Eample macro: \n\n" ..
                                              "#showtooltip Flash Heal \n" ..
                                              "/cast [@mouseover] Flash Heal \n",
                                      [6]   = "Yes \n\n\n"..
                                              "With Headers: \n" ..
                                              "1: On the Skins>Headers>Bars tab, \nswitch on Show Headers \n" ..
                                              "2: On the Skins>Frames>Bars>General tab,  \n" ..
                                              "set Number of Groups per column \n\n Without Headers: \n" ..
                                              "1: On the Skins>Frames>Bars>General tab, \n" ..
                                              "switch on Use Groups per Column \n" ..
                                              "2: On the Skins>Frames>Bars>General tab, \n" ..
                                              "set Number of Groups per column ",
                                      [7]   = "Yes \n\n"..
                                              "1: On the Skins>Frame>Bars>Visibility tab, \nset Alert Levels to 0 \n" ..
                                              "2: On the Skins>Frame>Bars>Aggro tab, \nturn off Monitor Aggro \n" .. 
                                              "3: On the Skins>Frame>Bars>Col"..HEALBOT_enWORD_COLOUR_SUFFIX.." tab, \nset Disabled opacity to 0 \n" ..
                                              "4: On the Skins>Frame>Bars>Col"..HEALBOT_enWORD_COLOUR_SUFFIX.." tab, \nset Background opacity to 0 \n" ..
                                              "5: On the Skins>Frame>Bar Text tabs, \nset Disabled opacity to 0 \n" ..
                                              "6: On the Debuff tabs, Turn on debuff monitoring",
                                      [8]   = "Yes \n\n"..
                                              "1: On the Skins>Frame>Bars>Col"..HEALBOT_enWORD_COLOUR_SUFFIX.." tab, \nset Incoming Heals to Don't Show\n" ..
                                              "2: On the Skins>Frame>Bar Text>Health>Incoming Heals tab, \n" ..
                                              "Turn off Incoming Heals",
                                      [9]   = "This has been present since a change in WoW 3.2, \n" ..
                                              "it can affects characters with weird letters in their name \n\n" ..
                                              "If your on Win7 or Win10, try the follow: \n"..
                                              "change system locale to English\n(for non-unicode programs) \n" ..
                                              "in Control Panel > Region and Language >\nAdministrative Tab",
                                      [10]   = "Set Alert Levels to 100 on the \n" ..
                                              "Skins>Frame>Bars>Visibility tab",
                                      [11]  = "Disable for a character: \n\n" ..
                                              "1: Open the General tab \n" ..
                                              "2: Turn on the Disable option \n\n\n",
                                      [12]  = "Change the Bars Anchor setting on the \nSkins>Frames>General tab  \n\n" ..
                                              "Top Right: the bars will grow Down and Left \n" ..
                                              "Top Left: the bars will grow Down and Right \n" ..
                                              "Bottom Right: the bars will grow Up and Left \n" ..
                                              "Bottom Left: the bars will grow Up and Right",
                                      [13]  = "Private List allows you to create a list of Targets you \n" ..
                                              "want to group separately from others, similar to the\nTank group \n\n" ..
                                              "The following options are available to \n" .. 
                                              "add/remove players to/from the Private List \n\n" ..
                                              "- The Healbot Menu, enter 'HealBot Menu' on the Spells tab \n" ..
                                              "- Create a macro with text '/hb tpl hbtarget'",
                                      [14]  = "Private Tanks can be added to the Main Tanks list, \n" ..
                                              "the Private tanks are only visible in your Healbot \n" ..
                                              "and do not affect other players or addons \n\n" ..
                                              "The following options are available to \n" ..
                                              "add/remove players to/from the Tanks list \n\n" ..
                                              "- The Healbot Menu, enter 'HealBot Menu' on the Spells tab \n" ..
                                              "- Create a macro with text '/hb tpt hbtarget'",                                     
                                      [15]  = "Yes \n\n"..
                                              "1: On the Skins>Frames>Heal Group tab, turn on Focus \n" ..
                                              "2: Set your focus on the NPC \n" ..
                                              "Healbot will create a bar in a new frame \n\n" ..
                                              "Note: If in a combat situation where\nyou zone in and out while in combat \n" ..
                                              "and need to reset focus on an NPC \n\n" ..
                                              "On the Skins>Frame>Bars>Visibility tab \nset Focus When entering combat to Always Show \n" ..
                                              "This will keep the bar available during combat. \n\n" ..
                                              "Note: The HealBot Menu has the option\n'Set HealBot Focus' \n" ..
                                              "This can make setting focus easy on NPC's and \n" ..
                                              "serves as a reminder to set focus. \n\n" ..
                                              "Enter 'HealBot Menu' on the Spells tab to use HealBot Menu",
                                      [16]  = "1: On the Skins>Frame>Bars>Col"..HEALBOT_enWORD_COLOUR_SUFFIX.." tab, \nadjust the out of range bar opacity \n" ..
                                              "2: On the Skins>Frame>Bars Text tabs, \nadjust the disabled text opacity\n\n" ..
                                              "Also check out setting the Alert Levels to 100 \n" ..
                                              "on the Skins>Frame>Bars>Visibility tab",
                                      [17]  = "Actually Healbot is casting exactly as the setup. \n\n" .. HEALBOT_ABOUT_FAQ_SPELLS_ANSWER01,
                                      [18]  = HEALBOT_ABOUT_FAQ_SPELLS_ANSWER01,
                                      [19]  = "Yes\n\n" ..
                                              "On the Import/Export>Skins tab\nselect Extra Skins from the dropdown and Import\n\n" ..
                                              "Additional skins might have been\nshared at "..HEALBOT_ABOUT_CATD,
                                      [20]  = "Check if the frame is locked on\nthe Skins>Frames>General tab\n\n" ..
                                              "To move the frame, select near the edge of the frame\n\n" ..
                                              "To make moving frames easier\nthe following options are available\n\n" ..
                                              " - Turn on Test mode\n\n" ..
                                              " - On the General tab, turn off Hide unlocked tag\n\n",
                                  }

    HEALBOT_OPTIONS_SKINAUTHOR              = "Skin Author"
    HEALBOT_OPTIONS_MORESKINSURL            = "Extra skins are available on the Import/Export > Skins tab"
    HEALBOT_OPTIONS_AVOIDBLUECURSOR         = "Avoid\nBlue Cursor"
    HEALBOT_PLAYER_OF_REALM                 = "of"
    
    HEALBOT_OPTIONS_OVERRIDE_EFFECTS        = "Override Effects"
    HEALBOT_OPTIONS_OVERRIDE_CHAT           = "Override Chat"
    HEALBOT_OPTIONS_OVERRIDE_FRAMES         = "Override Frames"
    HEALBOT_USE_OVERRIDE_NO                 = "Use current skin settings."
    HEALBOT_USE_OVERRIDE_YES                = "Always use overrides on this tab."
    
    HEALBOT_OPTIONS_LANG                    = "Language"
    
    HEALBOT_OPTIONS_LANG_ZHCN               = "Chinese (zhCN)"
    HEALBOT_OPTIONS_LANG_ENUK               = "English (enUK)"
    HEALBOT_OPTIONS_LANG_ENUS               = "English (enUS)"
    HEALBOT_OPTIONS_LANG_FRFR               = "French (frFR)"
    HEALBOT_OPTIONS_LANG_DEDE               = "German (deDE)"
    HEALBOT_OPTIONS_LANG_GRGR               = "Greek (grGR)"
    HEALBOT_OPTIONS_LANG_HUHU               = "Hungarian (huHU)"
    HEALBOT_OPTIONS_LANG_ITIT               = "Italian (itIT)"
    HEALBOT_OPTIONS_LANG_KRKR               = "Korean (krKR)"
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
    HEALBOT_OPTIONS_IMPORT_VALID1           = "Valid Import"
    HEALBOT_OPTIONS_IMPORT_VALID2           = " data ready to be loaded\n\nContinue?"
    HEALBOT_OPTIONS_LINK_REQUEST_DENIED     = "Link Request Denied\n\nPlease wait a few seconds before sending another request."
    HEALBOT_OPTIONS_LINK_REQUEST1           = "HealBot Share Request"
    HEALBOT_OPTIONS_LINK_CREATELR           = "Create HealBot Share Request Link"
    HEALBOT_OPTIONS_LINK_REQUEST2           = "This is how your share request is presented."
    HEALBOT_OPTIONS_LINK_REQUESTSENDQ       = "Send Request?"
    HEALBOT_OPTIONS_LINK_WAITQUEUE          = "Waiting in queue";
    HEALBOT_OPTIONS_LINK_TRANSCOMPLETE      = "Transfer complete";
    HEALBOT_OPTIONS_LINK_TRANSSTARTED       = "Transfer started";
    HEALBOT_OPTIONS_LINK_TRANSINPROGRESS    = "Transfer in progress ";
    HEALBOT_OPTIONS_LINK_POSTCHANNEL        = "Post to channel";
    HEALBOT_OPTIONS_LINK_POSTWHISPER        = "Whisper other HealBot users.";
    HEALBOT_OPTIONS_LINK_CHAN1              = "Comms are sent using the addon channels. This means:"
    HEALBOT_OPTIONS_LINK_CHAN2              = "-  Only HealBot users will receive your link."
    HEALBOT_OPTIONS_LINK_CHAN3              = "-  Your link is displayed in their default chat channel."
    HEALBOT_OPTIONS_LINK_CHAN4              = "-  You can whisper yourself to see how this works."
    
    HEALBOT_OPTIONS_ADDON_FAIL              = "Failed to load headbot addon"
    
    HEALBOT_OPTIONS_IN_A_GROUP              = "Only in a Group or Raid"
    HEALBOT_OPTIONS_ALSO_WHEN_MOUNTED       = "also when mounted"
    HEALBOT_OPTIONS_PALADIN_BLESSINGS       = "View all my blessings as same"
    HEALBOT_OPTIONS_ONLY_IN_INSTANCE        = "Only in instance"
    
    HEALBOT_OPTIONS_TAB_EFFECTS              = "Effects"
    HEALBOT_OPTIONS_TAB_EMERG                = "Emergency"
    HEALBOT_OPTIONS_CONTENT_SKINS_GENERAL    = "    " .. HEALBOT_OPTIONS_TAB_GENERAL
    HEALBOT_OPTIONS_CONTENT_SKINS_EFFECTS    = "    " .. HEALBOT_OPTIONS_TAB_EFFECTS
    HEALBOT_OPTIONS_CONTENT_SKINS_ENEMY      = "    " .. HEALBOT_CUSTOM_CASTBY_ENEMY
    HEALBOT_OPTIONS_CONTENT_SKINSF_GENERAL   = "        " .. HEALBOT_OPTIONS_TAB_GENERAL
    HEALBOT_OPTIONS_CONTENT_SKINS_HEALING    = "    " .. HEALBOT_OPTIONS_TAB_HEALING
    HEALBOT_OPTIONS_CONTENT_SKINS_HEADERS    = "        " .. HEALBOT_OPTIONS_TAB_HEADERS
    HEALBOT_OPTIONS_CONTENT_SKINS_BARS       = "        " .. HEALBOT_OPTIONS_TAB_BARS
    HEALBOT_OPTIONS_CONTENT_SKINS_ICONS      = "        " .. HEALBOT_OPTIONS_TAB_ICONS
    HEALBOT_OPTIONS_CONTENT_SKINS_INDICATORS = "        " .. HEALBOT_OPTIONS_TAB_INDICATORS
    HEALBOT_OPTIONS_CONTENT_SKINS_EMERG      = "        " .. HEALBOT_OPTIONS_TAB_EMERG
    HEALBOT_OPTIONS_CONTENT_SKINS_AGGRO      = "    " .. HEALBOT_OPTIONS_TAB_AGGRO
    HEALBOT_OPTIONS_CONTENT_SKINS_CHAT       = "    " .. HEALBOT_OPTIONS_TAB_CHAT
    HEALBOT_OPTIONS_CONTENT_SKINS_TEXT       = "        " .. HEALBOT_OPTIONS_TEXTOPTIONS
    HEALBOT_OPTIONS_CONTENT_SKINS_ICONTEXT   = "        " .. HEALBOT_OPTIONS_TAB_ICONTEXT

    HEALBOT_OPTIONS_CONTENT_CURE_DEBUFF     = "    " .. HEALBOT_OPTIONS_TAB_GENERAL
    HEALBOT_OPTIONS_CONTENT_CURE_CUSTOM     = "    " .. HEALBOT_CLASSES_CUSTOM
    HEALBOT_OPTIONS_CONTENT_CURE_WARNING    = "    " .. HEALBOT_OPTIONS_TAB_WARNING

    HEALBOT_OPTIONS_CONTENT_BUFFS_GENERAL   = "    " .. HEALBOT_OPTIONS_TAB_GENERAL
    HEALBOT_OPTIONS_CONTENT_BUFFS_HOTS      = "    " .. HEALBOT_CLASSES_CUSTOM

    HEALBOT_OPTIONS_CONTENT_INOUT_PRESETCOL = HEALBOT_OPTIONS_PRESET.." Col"..HEALBOT_enWORD_COLOUR_SUFFIX.."s"
    HEALBOT_OPTIONS_CONTENT_SKINS_FRAMES    = "    " .. HEALBOT_OPTIONS_TAB_FRAMES
    
    HEALBOT_SKIN_ABSORBCOL_TEXT             = HEALBOT_classicABSORBHOTUP.." effects";
    HEALBOT_OPTIONS_BARALPHAABSORB          = HEALBOT_classicABSORBHOTUP.." effects opacity";
    HEALBOT_OPTIONS_OUTLINE                 = "Outline"
    HEALBOT_OPTIONS_FRAME                   = "Frame"
    HEALBOT_OPTIONS_FRAMESOPTTEXT           = "Frames options"
    HEALBOT_OPTIONS_SETTOOLTIP_POSITION     = "Set Tooltip Position"
    HEALBOT_OPTIONS_SETTOOLTIP_CUSTOMANCHOR = "Set Tooltip Custom Anchor"
    HEALBOT_OPTIONS_TTCUSTOMANCHOR_TITLE    = "Tips Custom Anchor"
    HEALBOT_OPTIONS_TTCUSTOMANCHOR_POINT    = "Anchor Point"
    HEALBOT_OPTIONS_SKIN                    = "Skin"
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
    HEALBOT_CMD_SETFAVMOUNT                 = "Set Favourite Mount"
    HEALBOT_OPTIONS_HIDEMINIBOSSFRAMES      = "Hide mini boss frames";
    HEALBOT_OPTIONS_HIDERAIDFRAMES          = "Hide raid frames";
    HEALBOT_OPTIONS_HIDEFOCUSFRAME          = "Hide focus frame";
    HEALBOT_OPTIONS_FRAME_ALIAS             = "Alias"
    HEALBOT_OPTIONS_CONTENT_SKINS_HEALGROUP = "        " .. "Heal Groups"
    HEALBOT_OPTIONS_CONTENT_SKINS_BARCOLOUR = "        " .. "Bar Col"..HEALBOT_enWORD_COLOUR_SUFFIX.."s"
    HEALBOT_OPTIONS_SET_ALL_FRAMES          = "Copy current frame and tabs to other frames"
    HEALBOT_OPTIONS_CURRENT_FRAME           = "Current frame: "
    HEALBOT_OPTIONS_COPY_TABS               = "Copy tabs"
    HEALBOT_OPTIONS_TO_FRAMES               = "To frames"
    HEALBOT_WORDS_PROFILE                   = "Profile"
    HEALBOT_WORDS_GLOBALPROFILE             = "Global profile"
    HEALBOT_SHARE_SCREENSHOT                = "ScreenShot taken"
    HEALBOT_SHARE_EXPORTED                  = "Successfully Exported"
    HEALBOT_ENEMY_USE_FRAME                 = "Use frame"
    HEALBOT_ENEMY_INCLUDE_SELF              = "Include Target"
    HEALBOT_ENEMY_INCLUDE_FOCUS             = "Include Focus"
    HEALBOT_ENEMY_INCLUDE_TANKS             = "Include Tank targets"
    HEALBOT_OPTIONS_ENEMY_OPT               = "Enemy Visibility";
    HEALBOT_OPTIONS_SHARE_OPT               = "Share Options";
    HEALBOT_OPTIONS_CONTENT_SKINS_SHARE     = "    " .. "Share"
    HEALBOT_OPTIONS_CONTENT_SKINS_ENEMY     = "    " .. "Enemy"

    HEALBOT_ENEMY_NO_TARGET                 = "No target"
    HEALBOT_OPTIONS_ENEMYBARS               = "Health Bars - Harmful spells on hostile characters";
    HEALBOT_OPTIONS_HARMFUL_SPELLS          = "Harmful Spells"
    HEALBOT_ENEMY_INCLUDE_MYTARGETS         = "Include Private List targets"
    HEALBOT_ENEMY_NUMBER_BOSSES             = "Number of Bosses"
    HEALBOT_ENEMY_HIDE_OUTOFCOMBAT          = "Hide bars out of combat"
    HEALBOT_ENEMY_SHOW_TARGET               = "Show enemy target"
    HEALBOT_ENEMY_DOUBLE_WIDTH              = "Double total bar width"
    HEALBOT_ENEMY_TARGET_SIZE               = "Enemy target size"
    HEALBOT_OPTIONS_SHOW_ONLY_FRIEND        = "Only show Friendly"
    HEALBOT_OPTIONS_EXCLUDE_RAID            = "Exclude Self, Group and Raid"
    HEALBOT_OPTIONS_PROFILE                 = "Profile for".."\n".."Spells/Buffs/Debuffs"
    HEALBOT_OPTIONS_PROFILE_CHARACTER       = "Character"
    HEALBOT_OPTIONS_PROFILE_CLASS           = "Class"
    HEALBOT_OPTIONS_INCOMBATALERTLEVEL      = "Alert Level - In Combat";
    HEALBOT_OPTIONS_OUTCOMBATALERTLEVEL     = "Alert Level - Out of Combat";
    HEALBOT_OPTIONS_SORTOORLAST             = "Sort out of range last"
    HEALBOT_OPTION_NUMENEMYS                = "Number of Enemies"
    HEALBOT_OPTION_COMPRESSEXPORT           = "Compress export"
    HEALBOT_WORD_AUTO                       = "Auto"
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
    HEALBOT_ENEMY_EXISTS_SHOW               = "Show when exists"
    HEALBOT_ENEMY_NOBOSS_SHOW               = "Show when not on boss"
    HEALBOT_CMD_TOGGLECUSTOMCURECASTBY      = "Toggle Custom Cures - Default Cast By"
    HEALBOT_CMD_TOGGLEMAINASSIST            = "Toggle include Main Assist with Tanks"
    HEALBOT_CMD_RESETSKINGROUP              = "Recover Group skin"
    HEALBOT_CMD_RESETSKINRAID25             = "Recover Raid 25 skin"
    HEALBOT_CMD_RESETSKINRAID40             = "Recover Raid 40 skin"
    HEALBOT_OPTIONS_ENTERINGCOMBAT          = "When entering combat"
    HEALBOT_OPTIONS_ALWAYSINCOMBAT          = "Always show"
    HEALBOT_OPTIONS_OUTOFCOMBAT             = "When out of combat"
    HEALBOT_OPTIONS_ONLYINGCOMBAT           = "Only show in combat"
    HEALBOT_OPTIONS_ONLYOUTOFCOMBAT         = "Only show out of combat"
    HEALBOT_OPTIONS_ONLYONDEMAND            = "Only show on demand"
    HEALBOT_SKIN_RAIDBARCOL                 = "Raid col"..HEALBOT_enWORD_COLOUR_SUFFIX
    HEALBOT_SKIN_TANKBARCOL                 = "Tank col"..HEALBOT_enWORD_COLOUR_SUFFIX
    HEALBOT_SKIN_YOURBARCOL                 = "My col"..HEALBOT_enWORD_COLOUR_SUFFIX
    HEALBOT_OPTIONS_MAXBARS                 = "Max bars"
    HEALBOT_OPTIONS_STATUS                  = "Status"
    HEALBOT_OPTIONS_TEXTCOL_DEBUFF          = "Use Custom on Debuff"
    HEALBOT_OPTIONS_ALWAYSHIDE              = "Always hide"
    HEALBOT_OPTIONS_NOCHANGE                = "No Change"
    HEALBOT_OPTIONS_ALWAYSSHOW              = "Always Show"
    HEALBOT_OPTIONS_PAGE                    = "Page"
    HEALBOT_OPTIONS_PREV                    = "<<"    
    HEALBOT_OPTIONS_NEXT                    = ">>"
    HEALBOT_OPTIONS_PRESET_COLOUR           = HEALBOT_OPTIONS_PRESET.." Col"..HEALBOT_enWORD_COLOUR_SUFFIX
    
    HEALBOT_WORD_SUPPORTERS                 = "Supporters"
    HEALBOT_CREDITS_PEOPLE = {  
                              [01] = "Acirac",
                              [02] = "CTShammy",
                              [03] = "Kubik",
                              [04] = "Von",
                              [05] = "Aldetal",
                              [06] = "Brezza",
                              [07] = "Moonlight",
                              [08] = "Han Xing",
                              [09] = "Hermis",
                              [10] = "Ariá",
                              [11] = "Snaomi",
                             }
                             
    HEALBOT_WORD_TOGGLE                    = "Toggle"
    BINDING_CATEGORY_HEALBOT = HEALBOT_HEALBOT
    BINDING_HEADER_HBBUTTONS = HEALBOT_HEALBOT
    _G["BINDING_NAME_HEALBOTTOGGLEOPTIONS"] = HEALBOT_WORD_TOGGLE.." "..HEALBOT_ACTION_OPTIONS
    _G["BINDING_NAME_HEALBOTTOGGLEENABLED"] = HEALBOT_WORD_TOGGLE.." "..HEALBOT_SKIN_ENTEXT
end

function HealBot_Lang_InitVars()
    HEALBOT_CUSTOM_DEBUFF_CATS = {
         -- Defaults
        [HEALBOT_CUSTOM_CAT_CUSTOM_AUTOMATIC]  = 1,
    }
end

if (GetLocale() == "enUK") then
    HealBot_Lang_enUK()
else
    HealBot_Lang_enUS()
end
