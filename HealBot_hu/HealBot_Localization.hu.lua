-- Hungarian translator required

---------------
-- HUNGARIAN --
---------------
--
--
--
--

function HealBot_Lang_huHU()

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

    HEALBOT_DISEASE                         = "Disease/betegség";
    HEALBOT_MAGIC                           = "Magic/bübáj";
    HEALBOT_CURSE                           = "Curse/átok";
    HEALBOT_POISON                          = "Poison/mérgezés";

    HB_TOOLTIP_OFFLINE                      = "Offline";

    HEALBOT_HEALBOT                         = "HealBot";
    HEALBOT_ADDON                           = HEALBOT_HEALBOT .. " " .. HEALBOT_VERSION;
    HEALBOT_LOADED                          = " betölt.";
    HEALBOT_RANK   = {[1]="(Rank 1)", [2]="(Rank 2)", [3]="(Rank 3)", [4]="(Rank 4)", [5]="(Rank 5)", [6]="(Rank 6)", [7]="(Rank 7)",
                      [8]="(Rank 8)", [9]="(Rank 9)", [10]="(Rank 10)", [11]="(Rank 11)", [12]="(Rank 12)", [13]="(Rank 13)"}

    HEALBOT_ACTION_OPTIONS                  = "beállitások";
    HEALBOT_ACTION_UNLOCKED                 = "Unlocked";

    HEALBOT_OPTIONS_TITLE                   = HEALBOT_ADDON;
    HEALBOT_OPTIONS_DEFAULTS                = "alapértelmezés";
    HEALBOT_OPTIONS_LOCALDEFAULTS           = "Local Defaults";
    HEALBOT_OPTIONS_CLOSE                   = "bezár";
    HEALBOT_OPTIONS_HARDRESET               = "frissiti az UI-t"
    HEALBOT_OPTIONS_SOFTRESET               = "Reset HealBot"
    HEALBOT_OPTIONS_COPY                    = "Copy";
    HEALBOT_OPTIONS_TAB_GENERAL             = "általános";
    HEALBOT_OPTIONS_TAB_SPELLS              = "varázslatok";
    HEALBOT_OPTIONS_TAB_FRAMES              = "Frames";
    HEALBOT_OPTIONS_TAB_HEALING             = "gyogyitás";
    HEALBOT_OPTIONS_TAB_SKIN                = "kinézet/skin";
    HEALBOT_OPTIONS_TAB_TIPS                = "tippek";
    HEALBOT_OPTIONS_TAB_DEBUFFS             = "Debuffs"
    HEALBOT_OPTIONS_TAB_CUSTOM_DEBUFFS      = "Custom Debuffs";
    HEALBOT_OPTIONS_TAB_CUSTOM_BUFFS        = "Custom Buffs";
    HEALBOT_OPTIONS_TAB_BUFFS               = "Buff-ok"
    HEALBOT_OPTIONS_TAB_GENERALBUFFS        = "General Buffs"
    HEALBOT_OPTIONS_TAB_STATETEXT           = "State";
    HEALBOT_OPTIONS_TAB_NAMETEXT            = "Name";
    HEALBOT_OPTIONS_TAB_OVERRIDES           = "Overrides"
    HEALBOT_OPTIONS_TAB_EXTRAS              = "Extras"
    
    HEALBOT_STRING_MATCH_WELLFED            = "become well fed"

    HEALBOT_OPTIONS_GLOBAL                  = "Global"
    HEALBOT_OPTIONS_ALPHA                   = "Opacity";
    HEALBOT_OPTIONS_BARALPHA                = "átlászhatoság engedélyezése";
    HEALBOT_OPTIONS_BARALPHAINHEAL          = "bejövö heal átlászhatosága";
    HEALBOT_OPTIONS_BARALPHABACK            = "háttér bár átkászhatosága";
    HEALBOT_OPTIONS_BARALPHAEOR             = "távolságon túl átlászhatosága";
    HEALBOT_OPTIONS_ACTIONLOCKED            = "pozicio zárolása";
    HEALBOT_OPTIONS_UNITINCOMBAT            = "Group/Raid member enters combat"
    HEALBOT_OPTIONS_UNITINCOMBAT01          = "Do nothing"
    HEALBOT_OPTIONS_UNITINCOMBAT02          = "Show enemy frame"
    HEALBOT_OPTIONS_UNITINCOMBAT03          = "Lockdown HealBot"
    HEALBOT_OPTIONS_AUTOSHOW                = "automatikusan befejezödik";
    HEALBOT_OPTIONS_HIDEOPTIONS             = "elrejtö gomb beállitások";
    HEALBOT_OPTIONS_HIDEUNLOCKEDTAG         = "Hide unlocked tag"
    HEALBOT_OPTIONS_PROTECTPVP              = "Avoid PvP";
    HEALBOT_OPTIONS_HEAL_CHATOPT            = "Chat beállitások";
    HEALBOT_OPTIONS_BLIZZARD_FRAMES         = "Blizzard Frames";

    HEALBOT_OPTIONS_FRAMESCALE              = "Frame Scale"
    HEALBOT_OPTIONS_STICKFRAMEOFFSETH       = "Sticky frame horizontal offset"
    HEALBOT_OPTIONS_STICKFRAMEOFFSETV       = "Sticky frame vertical offset"
    HEALBOT_OPTIONS_SKINTEXT                = "használja a skin-t"
    HEALBOT_SKINS_STD                       = "Standard/alapvetö"
    HEALBOT_OPTIONS_SKINTEXTURE             = "Texture/struktúra"
    HEALBOT_OPTIONS_SKINHEIGHT              = "magasság"
    HEALBOT_OPTIONS_SKINWIDTH               = "szélesség"
    HEALBOT_OPTIONS_SKINNUMCOLS             = "oszlopok száma"
    HEALBOT_OPTIONS_SKINNUMHCOLS            = "csoportok száma oszloponként"
    HEALBOT_OPTIONS_SKINBRSPACE             = "sor távtarto/távolság"
    HEALBOT_OPTIONS_SKINBCSPACE             = "oszlop távtarto/távolság"
    HEALBOT_SORTBY_NAME                     = "név"
    HEALBOT_SORTBY_CLASS                    = "Class"
    HEALBOT_SORTBY_GROUP                    = "Group/csoport"
    HEALBOT_SORTBY_MAXHEALTH                = "Max health/élet"
    HEALBOT_SORTBY_UNITID                   = "Unit ID"
    HEALBOT_OPTIONS_NEWDEBUFFTEXT           = "új debuff"
    HEALBOT_OPTIONS_NEWHOTBUFFTEXT          = "New Buff"
    HEALBOT_OPTIONS_DELSKIN                 = "törlés"
    HEALBOT_OPTIONS_NEWSKINTEXT             = "új skin/felület"
    HEALBOT_OPTIONS_SAVESKIN                = "mentés"
    HEALBOT_OPTIONS_SKINBARS                = "Bar beállitások"
    HEALBOT_SKIN_ENTEXT                     = "engedélyezés"
    HEALBOT_SKIN_DISTEXT                    = "kikapcsol"
    HEALBOT_SKIN_DEBTEXT                    = "Debuff/átok"
    HEALBOT_SKIN_BACKTEXT                   = "háttér"
    HEALBOT_SKIN_BORDERTEXT                 = "szegély"
    HEALBOT_OPTIONS_SKINFONT                = "betütipus"
    HEALBOT_OPTIONS_SKINFHEIGHT             = "betütipus mérete"
    HEALBOT_OPTIONS_SKINFOUTLINE            = "betütipus körvonala"
    HEALBOT_OPTIONS_BARALPHADIS             = "átlászhatoság kikapcsolása"
    HEALBOT_OPTIONS_SHOWHEADERS             = "fejléc mutatása/megjelenitése"
    HEALBOT_OPTIONS_PRESETCOLOURBTN         = "*"
    HEALBOT_OPTIONS_PRESET                  = "Preset"
    HEALBOT_OPTIONS_ICONPOSITION            = "Icon Position"
    HEALBOT_OPTIONS_ICONANCHOR              = "Icon Anchor"

    HEALBOT_OPTIONS_ITEMS                   = "Items/tárgyak";

    HEALBOT_OPTIONS_COMBOCLASS              = "gomb kombináciok";
    HEALBOT_OPTIONS_CLICK                   = "Click/kattintás";
    HEALBOT_OPTIONS_SHIFT                   = "Shift";
    HEALBOT_OPTIONS_CTRL                    = "Ctrl";
    HEALBOT_OPTIONS_ENABLEHEALTHY           = "Mindig engedélyezve";
    HEALBOT_OPTIONS_FADEONEXPIRE            = "Fade on expire";
    HEALBOT_OPTIONS_FADESTARTTIME           = "Fade start time";

    HEALBOT_OPTIONS_CASTNOTIFY1             = "Nincsenek üzenetek";
    HEALBOT_OPTIONS_CASTNOTIFY2             = "csak nekem jelez engem értesit";
    HEALBOT_OPTIONS_CASTNOTIFY3             = "éretesiti a célpontot/target";
    HEALBOT_OPTIONS_CASTNOTIFY4             = "éretsiti a party-t";
    HEALBOT_OPTIONS_CASTNOTIFY5             = "éretsiti a raid-et";
    HEALBOT_OPTIONS_CASTNOTIFY6             = "éretesiti chan";
    HEALBOT_OPTIONS_CASTNOTIFYRESONLY       = "csak feltámasztásnál éretesit";
    HEALBOT_OPTIONS_EOC_OOM                 = "After combat warn when out of mana"
    HEALBOT_OPTIONS_EOC_OOM_VALUE           = "When mana below"

    HEALBOT_OPTIONS_CDCBARS                 = "Bar szinek/colours";
    HEALBOT_OPTIONS_CDCSHOWHBARS            = "változtasd meg a health bar szinét";
    HEALBOT_OPTIONS_CDCSHOWABARS            = "változtasd meg aggro bar szinét";
    HEALBOT_OPTIONS_CDCWARNINGS             = "Debuff figyelmeztetések";
    HEALBOT_OPTIONS_RAIDGROUPWARN           = "Raid filter";
    HEALBOT_OPTIONS_BUFFWARNINGS            = "Buff warnings";
    HEALBOT_OPTIONS_BUFFCUSTOM              = "Custom buffs";
    HEALBOT_OPTIONS_BUFFCUSTOMURL           = "Custom buffs are available at  "..HEALBOT_ABOUT_URL
    HEALBOT_OPTIONS_DEBUFFCUSTOM            = "Custom debuffs"
    HEALBOT_OPTIONS_DEBUFFCUSTOMURL         = "Raid and Instance custom debuffs are available at  "..HEALBOT_ABOUT_URL
    HEALBOT_OPTIONS_BUFFMISSING             = "Missing buffs";
    HEALBOT_OPTIONS_BUFFEXTRA               = "Extra Buffs";
    HEALBOT_OPTIONS_CHECKWELLFED            = "Check well fed";
    HEALBOT_OPTIONS_DEBUFFDISPELL           = "Dispellable debuffs";
    HEALBOT_OPTIONS_SHOWDEBUFFWARNING       = "mutatja debuff figyelmeztetést";
    HEALBOT_OPTIONS_SOUNDDEBUFFWARNING      = "hangot ad debuff-nál";
    HEALBOT_OPTIONS_SHOWBUFFWARNING         = "Display warning on buff";
    HEALBOT_OPTIONS_SOUNDBUFFWARNING        = "Play sound on buff";
    HEALBOT_OPTIONS_SOUND                   = "hangok/zenék"
    HEALBOT_OPTIONS_WARN_CLASSCOL           = "Unable to change text color when\nColor text by class is on"

    HEALBOT_OPTIONS_PLAYERVISIBILITY        = "Player and Pet Visibility";
    HEALBOT_OPTIONS_TARGETVISIBILITY        = "Target Visibility";
    HEALBOT_OPTIONS_FOCUSVISIBILITY         = "Focus Visibility";
    HEALBOT_OPTIONS_PLAYERSORT              = "Player Sort"
    HEALBOT_OPTIONS_VEHICLESORT             = "Vehicle Sort"
    HEALBOT_OPTIONS_PETSORT                 = "Pet Sort"
    HEALBOT_OPTIONS_ENEMYSORT               = "Enemy Sort"
    HEALBOT_OPTIONS_SELFHEALS               = "önmagad/self"
    HEALBOT_OPTIONS_PETHEALS                = "kisállat/Pets"
    HEALBOT_WORD_PET                        = "Pet"
    HEALBOT_OPTIONS_GROUPHEALS              = "csoport/Group";
    HEALBOT_OPTIONS_TANKHEALS               = "Main/Fö tank-ok";
    HEALBOT_OPTIONS_SINGLETANK              = "Single tank";
    HEALBOT_OPTIONS_PRIVATETANKS            = "saját fö tankok";
    HEALBOT_OPTIONS_PRIVATEHEALERS          = "Private healers";
    HEALBOT_OPTIONS_TARGETHEALS             = "Targets/célpont";
    HEALBOT_OPTIONS_EMERGENCYHEALS          = "Raid";
    HEALBOT_OPTIONS_RAID10                  = HEALBOT_OPTIONS_EMERGENCYHEALS.." 10";
    HEALBOT_OPTIONS_RAID20                  = HEALBOT_OPTIONS_EMERGENCYHEALS.." 20";
    HEALBOT_OPTIONS_RAID25                  = HEALBOT_OPTIONS_EMERGENCYHEALS.." 25";
    HEALBOT_OPTIONS_RAID40                  = HEALBOT_OPTIONS_EMERGENCYHEALS.." 40";
    HEALBOT_OPTIONS_EMERGFILTER             = "raid bárokat mutat";
    HEALBOT_OPTIONS_EMERGFCLASS             = "classes/osztályokat állit be";
    HEALBOT_OPTIONS_MODIFIER                = "Modifier key"
    HEALBOT_OPTIONS_MODIFIERKEYS            = "Modifier keys:"
    HEALBOT_OPTIONS_COMBOBUTTON             = "gomb";
    HEALBOT_OPTIONS_BUTTONANY               = "Any button";
    HEALBOT_OPTIONS_BUTTONLEFT              = "bal";
    HEALBOT_OPTIONS_BUTTONMIDDLE            = "középsö";
    HEALBOT_OPTIONS_BUTTONRIGHT             = "jobb";
    HEALBOT_OPTIONS_BUTTON4                 = "gomb4";
    HEALBOT_OPTIONS_BUTTON5                 = "gomb5";
    HEALBOT_OPTIONS_BUTTON6                 = "gomb6";
    HEALBOT_OPTIONS_BUTTON7                 = "gomb7";
    HEALBOT_OPTIONS_BUTTON8                 = "gomb8";
    HEALBOT_OPTIONS_BUTTON9                 = "gomb9";
    HEALBOT_OPTIONS_BUTTON10                = "gomb10";
    HEALBOT_OPTIONS_BUTTON11                = "gomb11";
    HEALBOT_OPTIONS_BUTTON12                = "gomb12";
    HEALBOT_OPTIONS_BUTTON13                = "gomb13";
    HEALBOT_OPTIONS_BUTTON14                = "gomb14";
    HEALBOT_OPTIONS_BUTTON15                = "gomb15";

    HEALBOT_CLASSES_ALL                     = "összes class/osztály";
    HEALBOT_CLASSES_MELEE                   = "Melee";
    HEALBOT_CLASSES_RANGES                  = "Ranged";
    HEALBOT_CLASSES_HEALERS                 = "Healers";
    HEALBOT_CLASSES_CUSTOM                  = "egyéni/Custom";

    HEALBOT_OPTIONS_DEBUFFNAME              = "Debuff Name"
    HEALBOT_OPTIONS_DEBUFFAUTOTOCUSTOM      = "Add to custom list"
    HEALBOT_OPTIONS_SHOWTOOLTIP             = "eszköztippek mutatása";
    HEALBOT_OPTIONS_SHOWDETTOOLTIP          = "Mutatja a részletes spell informáciot";
    HEALBOT_OPTIONS_SHOWCDTOOLTIP           = "mutatja a spell cooldown-t";
    HEALBOT_OPTIONS_IGNOREGCDTOOLTIP        = "Ignore spell global cooldown";
    HEALBOT_OPTIONS_SHOWMOUSEWHEELTOOLTIP   = "Show mouse wheel commands"
    HEALBOT_OPTIONS_SHOWUNITTOOLTIP         = "mutatja a target/célpont informáciot";
    HEALBOT_OPTIONS_SHOWRECTOOLTIP          = "mutatja a heal idöbeli ajánlás/recommendation";
    HEALBOT_TOOLTIP_POSDEFAULT              = "alapértelmezett hely";
    HEALBOT_TOOLTIP_POSLEFT                 = "balra a Healbot-tol";
    HEALBOT_TOOLTIP_POSRIGHT                = "jobra a Healbot-tol";
    HEALBOT_TOOLTIP_POSABOVE                = "Healbot felett";
    HEALBOT_TOOLTIP_POSBELOW                = "Healbot alatt";
    HEALBOT_TOOLTIP_POSCURSOR               = "Kurzor mellett";
    HEALBOT_TOOLTIP_RECOMMENDTEXT           = "Heal over time Recommendation";
    HEALBOT_TOOLTIP_NONE                    = "nem elérhetö";
    HEALBOT_TOOLTIP_CORPSE                  = "holtteste a ";
    HEALBOT_TOOLTIP_CD                      = " (CD ";
    HEALBOT_TOOLTIP_SECS                    = "s)";
    HEALBOT_TOOLTIP_MINS                    = " min)";
    HEALBOT_WORDS_SMALL                     = "Small"
    HEALBOT_WORDS_MEDIUM                    = "Medium"
    HEALBOT_WORDS_LARGE                     = "Large"
    HEALBOT_WORDS_SEC                       = "sec";
    HEALBOT_WORDS_CAST                      = "Cast";
    HEALBOT_WORDS_UNKNOWN                   = "ismeretlen";
    HEALBOT_WORDS_YES                       = "Yes/igen";
    HEALBOT_WORDS_NO                        = "No/nem";
    HEALBOT_WORDS_OK                        = "OK";
    HEALBOT_WORDS_THIN                      = "vékony";
    HEALBOT_WORDS_THICK                     = "vastag";

    HEALBOT_WORDS_NONE                      = "None/egyik sem";
    HEALBOT_OPTIONS_ALT                     = "Alt";
    HEALBOT_OPTIONS_LOCKOFF                 = "Always Unlocked";
    HEALBOT_OPTIONS_LOCKON                  = "Always Locked";
    HEALBOT_OPTIONS_LOCKCTRL                = "Unlock with Ctrl";
    HEALBOT_OPTIONS_LOCKALT                 = "Unlock with Alt";
    HEALBOT_OPTIONS_LOCKCTRLALT             = "Unlock with Ctrl + Alt";
    HEALBOT_DISABLED_TARGET                 = "Target/célpont";
    HEALBOT_OPTIONS_SHOWCLASSONBAR          = "mutasd a class-t a báron";
    HEALBOT_OPTIONS_SHOWHEALTHONBAR         = "mutasd az életet/health báron";
    HEALBOT_OPTIONS_SHOWTEXT                = "Show text";
    HEALBOT_OPTIONS_IGNOREINCOMINGONFULL    = "On full health ignore all incoming heals and "..HEALBOT_classicABSORBHOT.."s";
    HEALBOT_OPTIONS_TEXTONLYTIP             = "Only show in tooltip";
    HEALBOT_OPTIONS_TEXTSTATENAMEFONT       = "Use name font string";
    HEALBOT_OPTIONS_BARHEALTHINCHEALS       = "beleszámolja a bejövö heals";
    HEALBOT_OPTIONS_BARHEALTHSEPHEALS       = "elkülöniti a bejövö heals";
    HEALBOT_OPTIONS_BARHEALTHINCABSORBS     = "Include "..HEALBOT_classicABSORBHOT.."s"
    HEALBOT_OPTIONS_BARHEALTHSEPABSORBS     = "Separate "..HEALBOT_classicABSORBHOT.."s"
    HEALBOT_OPTIONS_BARHEALTHMYOVERHEALS    = "Show my overheals";
    HEALBOT_OPTIONS_BARHEALTHALLOVERHEALS   = "Show all overheals";
    HEALBOT_OPTIONS_BARHEALTH1              = "deltában";
    HEALBOT_OPTIONS_BARHEALTH2              = "százalékban";
    HEALBOT_OPTIONS_TIPTEXT                 = "gyorstipp information";
    HEALBOT_OPTIONS_POSTOOLTIP              = "Position gyorstipp";
    HEALBOT_OPTIONS_SHOWNAMEONBAR           = "mutatja a neveket a báron";
    HEALBOT_OPTIONS_BARTEXTCLASSCOLOUR1     = "class/osztályonkénti szines szöveg";
    HEALBOT_OPTIONS_EMERGFILTERGROUPS       = "beleveszi a raid groups";
    HEALBOT_OPTIONS_PLAYERPET               = "Players and Pets"

    HEALBOT_ONE                             = "1";
    HEALBOT_TWO                             = "2";
    HEALBOT_THREE                           = "3";
    HEALBOT_FOUR                            = "4";
    HEALBOT_FIVE                            = "5";
    HEALBOT_SIX                             = "6";
    HEALBOT_SEVEN                           = "7";
    HEALBOT_EIGHT                           = "8";

    HEALBOT_OPTIONS_SETDEFAULTS             = "alapértelmezett beállitás";
    HEALBOT_OPTIONS_SETDEFAULTSMSG          = "mindet visszaállyit az alapértelmezetre";
    HEALBOT_OPTIONS_SETLOCALDEFAULTSMSG     = "Reset spells/buffs/debuffs for this character\nto default values";
    HEALBOT_OPTIONS_RIGHTBOPTIONS           = "jobb click megnyitja az options/beállitásokat";

    HEALBOT_OPTIONS_BARHEADEROPTTEXT        = "Bar Header options";
    HEALBOT_OPTIONS_FRAMEHEADEROPTTEXT      = "Frame Header options";
    HEALBOT_OPTIONS_ICONBUFFOPTTEXT         = "Buff icon options";
    HEALBOT_OPTIONS_ICONDEBUFFOPTTEXT       = "Debuff icon options";
    HEALBOT_OPTIONS_ICONOPTCLASSROLEBUTTON  = "Class / Role"
    HEALBOT_OPTIONS_ICONOPTCLASSROLE        = "Class / Role icon options";
    HEALBOT_OPTIONS_ICONOPTRAIDTARGETBUTTON = "Raid Target"
    HEALBOT_OPTIONS_ICONOPTRAIDTARGET       = "Raid Target icon options";
    HEALBOT_OPTIONS_ICONOPTREADYCHECKBUTTON = "Ready Check"
    HEALBOT_OPTIONS_ICONOPTREADYCHECK       = "Ready Check icon options";
    HEALBOT_OPTIONS_ICONOPTOORARROW         = "Out of Range Arrow icon options";
    HEALBOT_OPTIONS_ICONOPTOORARROWBUTTON   = "OOR Arrow";
    HEALBOT_OPTIONS_STATEOPTTEXT            = "State text options";
    HEALBOT_OPTIONS_NAMEOPTTEXT             = "Name text options";
    HEALBOT_OPTIONS_HEALTHOPTTEXT           = "Health text options";
    HEALBOT_OPTIONS_AGGROOPTTEXT            = "Aggro text options";
    HEALBOT_OPTIONS_EXTRAHOPTOVERHEAL       = "Overheals options";
    HEALBOT_OPTIONS_EXTRAHOPTINHEAL         = "Incoming heals options";
    HEALBOT_OPTIONS_AUXOPTTEXT              = "Aux text options";
    HEALBOT_OPTIONS_TABNOTAVAIL             = "Tab not available with current frame";
    HEALBOT_OPTIONS_STATEOPTCOLOUR          = "State color options";
    HEALBOT_OPTIONS_NAMEOPTCOLOUR           = "Name color options";
    HEALBOT_OPTIONS_HEALTHOPTCOLOUR         = "Health color options";
    HEALBOT_OPTIONS_AGGROOPTCOLOUR          = "Aggro color options";
    HEALBOT_OPTIONS_AUXOPTCOLOUR            = "Aux color options";
    HEALBOT_OPTIONS_HEALTHTEXTANCHOR        = "Health text anchor";
    HEALBOT_OPTIONS_AGGROTEXTANCHOR         = "Aggro text anchor";
    HEALBOT_OPTIONS_STATETEXTANCHOR         = "State text anchor";
    HEALBOT_OPTIONS_AGGROINDTEXT            = "Aggro indicator on name";
    HEALBOT_OPTIONS_OVERHEALFORMAT          = "Overheals format";
    HEALBOT_OPTIONS_OVERHEALCOLOUR          = "Overheals color"
    HEALBOT_OPTIONS_SEPARATEFORMAT          = "Separate format";
    HEALBOT_OPTIONS_SEPARATECOLOUR          = "Separate color"
    HEALBOT_OPTIONS_PERCENTAGEFORMAT        = "Percentage format";
    HEALBOT_SKIN_HEADERBARCOL               = "Bar szinek";
    HEALBOT_SKIN_HEADERTEXTCOL              = "szöveg szinek";
    HEALBOT_OPTIONS_BUFFSTEXT1              = "Spell to buff";
    HEALBOT_OPTIONS_BUFFSTEXTWE             = "Weapon enchants";
    HEALBOT_OPTIONS_BUFFSTEXTWEMAIN         = "Main hand / 2H";
    HEALBOT_OPTIONS_BUFFSTEXTWEOFF          = "Off hand";
    HEALBOT_OPTIONS_ITEMNAME                = "Item name";
    HEALBOT_OPTIONS_BUFFSTEXT2              = "tagok ellenörzése";
    HEALBOT_OPTIONS_BUFFSTEXT3              = "bar szinek";
    HEALBOT_OPTIONS_EMERGCOLS               = "Emergency colors";
    HEALBOT_OPTIONS_EMERGGENERAL            = "Emergency general";
    HEALBOT_OPTIONS_EMERGSPELLS             = "Emergency spells";
    HEALBOT_OPTIONS_ICONSCMD                = "Icon commands";
    HEALBOT_OPTIONS_BUFF                    = "Buff ";
    HEALBOT_OPTIONS_BUFFSELF                = "on self/saját magadra";
    HEALBOT_OPTIONS_BUFFPARTY               = "on party/partira";
    HEALBOT_OPTIONS_BUFFRAID                = "on raid/raidre";
    HEALBOT_OPTIONS_MONITORBUFFS            = "figyelje a nem talált/missing buffs";
    HEALBOT_OPTIONS_MONITORBUFFSC           = "also/szintén in combat";
    HEALBOT_OPTIONS_ENABLESMARTCAST         = "Smart/gyors Cast harcon kivül";
    HEALBOT_OPTIONS_SMARTCASTSPELLS         = "Include spells";
    HEALBOT_OPTIONS_SMARTCASTDISPELL        = "Remove/eltávolitja debuffs";
    HEALBOT_OPTIONS_SMARTCASTBUFF           = "Add/hozzáad buffs";
    HEALBOT_OPTIONS_SMARTCASTHEAL           = "Healing varázslatok";
    HEALBOT_OPTIONS_BAR2SIZE                = "Power bar méret";
    HEALBOT_OPTIONS_SETSPELLS               = "varázylatokat állit be";
    HEALBOT_OPTIONS_USEICONCMDS             = "Use icon commands";
    HEALBOT_OPTIONS_ENABLEDBARS             = "mindekor mutajta a bárokat";
    HEALBOT_OPTIONS_EMERGBARS               = "Emergency Bars - All spells on all characters";
    HEALBOT_OPTIONS_ICONS                   = "Icons: Commands that can be used on icons";
    HEALBOT_OPTIONS_MONITORDEBUFFS          = "figyeli az eltávolitott debuff-okat";
    HEALBOT_OPTIONS_DEBUFFTEXT1             = "Spell-el eltávolitott debuffok";
    
    HEALBOT_OPTIONS_POWER                   = "Power"
    HEALBOT_OPTIONS_CASTBAR                 = "Cast bar"
    
    HEALBOT_OPTIONS_HLTHTXTANCHORINDL       = "Independent Left"
    HEALBOT_OPTIONS_HLTHTXTANCHORINDC       = "Independent Center"
    HEALBOT_OPTIONS_HLTHTXTANCHORINDR       = "Independent Right"
    HEALBOT_OPTIONS_HLTHTXTANCHORRIGHT      = "Right of Name Text"
    HEALBOT_OPTIONS_HLTHTXTANCHORLEFT       = "Left of Name Text"
    HEALBOT_OPTIONS_HLTHTXTANCHORBELOW      = "Below Name Text"
    HEALBOT_OPTIONS_HLTHTXTANCHORABOVE      = "Above Name Text"
    HEALBOT_OPTIONS_AGGROTXTANCHORRIGHT     = "Right of Health Text"
    HEALBOT_OPTIONS_AGGROTXTANCHORBELOW     = "Below Health Text"
    HEALBOT_OPTIONS_AGGROTXTANCHORABOVE     = "Above Health Text"
    
    HEALBOT_OPTIONS_AUXBARANCHOR            = "Anchor"
    HEALBOT_OPTIONS_AUXBARANCHOR01          = "Below Health Bar"
    HEALBOT_OPTIONS_AUXBARANCHOR02          = "Above Health Bar"
    HEALBOT_OPTIONS_AUXBARANCHOR03          = "Left of Health Bar"
    HEALBOT_OPTIONS_AUXBARANCHOR04          = "Right of Health Bar"
    HEALBOT_OPTIONS_AUXBARANCHOR05          = "Below"
    HEALBOT_OPTIONS_AUXBARANCHOR06          = "Above"
    HEALBOT_OPTIONS_AUXBARANCHOR07          = "Left"
    HEALBOT_OPTIONS_AUXBARANCHOR08          = "Right"
    
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
    
    HEALBOT_OPTIONS_IGNOREDEBUFF            = "Ignore/mellözött debuffok:";
    HEALBOT_OPTIONS_IGNOREDEBUFFDURATION    = "Rövid idötartamú";
    HEALBOT_OPTIONS_IGNOREDEBUFFCOOLDOWN    = "mikor a gyogyito spell CoolDown > 2 secs";
    HEALBOT_OPTIONS_IGNOREDEBUFFFRIEND      = "ha a caster ismeri a barátját/friend";

    HEALBOT_OPTIONS_OPTIONSOPACITY          = "Options opacity";

    HEALBOT_OPTIONS_HIDEPARTYFRAMES         = "rejtsds el a party keretet/frames";
    HEALBOT_OPTIONS_HIDEPLAYERTARGET        = "Include player and target";
    HEALBOT_OPTIONS_DISABLEHEALBOT          = "kikapcsolja a HealBot-ot";
    
    HEALBOT_OPTIONS_STICKYFRAMES            = "Sticky Frames"
    HEALBOT_OPTIONS_STICKYSENSITIVITY       = "Sticky Sensitivity"
    HEALBOT_WORD_VLOW                       = "Very Low"
    HEALBOT_WORD_LOW                        = "Low"
    HEALBOT_WORD_NORMAL                     = "Normal"
    HEALBOT_WORD_HIGH                       = "High"
    HEALBOT_WORD_EXTREME                    = "Extreme"
    HEALBOT_WORD_CASTER                     = "Caster"
    HEALBOT_WORD_TYPE                       = "Type"

    HEALBOT_ASSIST                          = "Assist";
    HEALBOT_FOCUS                           = "Focus";
    HEALBOT_MENU                            = "Menu";
    HEALBOT_MAINTANK                        = "FöTank";

    HEALBOT_STOP                            = "Stop";
    HEALBOT_TELL                            = "Tell";
    HEALBOT_IGNOREAURAALL                   = "Disable - Ignore in all zones";
    HEALBOT_ICONRAISEPRIO1                  = "Priority raise x1";
    HEALBOT_ICONRAISEPRIO3                  = "Priority raise x3";
    HEALBOT_ICONLOWERPRIO1                  = "Priority lower x1";
    HEALBOT_ICONLOWERPRIO3                  = "Priority lower x3";
    HEALBOT_ICONRAISESCALE                  = "Scale increase";
    HEALBOT_ICONLOWERSCALE                  = "Scale decrease";
    HEALBOT_ICONBARCOLOURON                 = "Bar color on"
    HEALBOT_ICONBARCOLOUROFF                = "Bar color off"
    
    HEALBOT_OPTIONS_SHOWMINIMAPBUTTON       = "engedélyez a minimapon egy gyorsgombot";
    HEALBOT_OPTIONS_BARBUTTONSHOWRAIDICON   = "mutaasd a Raid Target";
    HEALBOT_OPTIONS_HOTONBAR                = "On bar/báron";
    HEALBOT_OPTIONS_HOTOFFBAR               = "Off bar/bár mellett";

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

    HEALBOT_OPTION_AGGROTRACK               = "figyeld az Aggrot"
    HEALBOT_OPTION_AGGROBAR                 = "Bar"
    HEALBOT_OPTION_AGGROTXT                 = ">> Text <<"
    HEALBOT_OPTION_AGGROIND                 = "Indicator"
    HEALBOT_OPTION_MANAONLY                 = "Show mana only"
    HEALBOT_OPTION_BARUPDFREQ               = "Refresh Multiplier"
    HEALBOT_OPTION_USEFLUIDBARS             = "Use fluid/folyadék bars"
    HEALBOT_OPTION_USEFOCUSGROUPS           = "Use focus groups"
    HEALBOT_OPTION_FOCUSGROUPDIMMING        = "Unfocused groups - Opacity reduction"
    HEALBOT_OPTION_FLUIDBARS                = "Fluid Bars"
    HEALBOT_OPTIONS_RELOADUIMSG             = "Ez az opcio igényei az UI újrebetöltését! újratöltöd a képernyöt most?"

    HEALBOT_BUFF_PVP                        = "PvP"
    HEALBOT_BUFF_PVE						= "PvE"
    HEALBOT_OPTIONS_ANCHOR                  = "Frame anchor"
    HEALBOT_OPTIONS_BARSANCHOR              = "Bars anchor"
    HEALBOT_OPTIONS_TOPLEFT                 = "Bal felsö"
    HEALBOT_OPTIONS_BOTTOMLEFT              = "bal also"
    HEALBOT_OPTIONS_TOPRIGHT                = "Jobb felsö"
    HEALBOT_OPTIONS_BOTTOMRIGHT             = "Jobb also"
    HEALBOT_OPTIONS_TOP                     = "felül"
    HEALBOT_OPTIONS_BOTTOM                  = "alul"

    HEALBOT_PANEL_BLACKLIST                 = "Feketelista"

    HEALBOT_WORDS_REMOVEFROM                = "távolitsa el";
    HEALBOT_WORDS_ADDTO                     = "Add hozzá";
    HEALBOT_WORDS_INCLUDE                   = "Include/tartalmaz";
    HEALBOT_WORDS_UNSET                     = "Unset";
    HEALBOT_WORDS_SETAS                     = "Set as";
    HEALBOT_OPTIONS_MAXSECS                 = "Maximum seconds"
    HEALBOT_WORDS_REQUIRED                  = "Required";
    HEALBOT_WORDS_PENDING                   = "Pending";
    HEALBOT_WORD_STATUS                     = "Status"
    HEALBOT_WORD_TIME                       = "Time"
    HEALBOT_WORD_SUMMONS                    = "Summons"
    HEALBOT_WORD_RESURRECTION               = "Resurrection"

    HEALBOT_OPTIONS_TTALPHA                 = "Opacity/áttetszöség"
    HEALBOT_TOOLTIP_TARGETBAR               = "Target Bar"
    HEALBOT_OPTIONS_MYTARGET                = "My Targets"
    HEALBOT_OPTIONS_MYFRIEND                = "My Friend"

    HEALBOT_DISCONNECTED_TEXT               = "Disconnected"
    HEALBOT_DISCONNECTED_TAG                = "DC-"
    HEALBOT_DEAD_LABEL                      = "Dead"
    HEALBOT_DEAD_TAG                        = "RIP-"
    HEALBOT_RES_TAG                         = "RES-"
    HEALBOT_SUMMONS_TAG                     = "SUM-"
    HEALBOT_OUTOFRANGE_LABEL                = "Out Of Range"
    HEALBOT_RANGE30                         = "In Range 30"
    HEALBOT_RECENTHEALS                     = "Your recent heals"
    HEALBOT_OUTOFRANGE_TAG                  = "OOR-"
    HEALBOT_RESERVED_LABEL                  = "Reserved"
    HEALBOT_RESERVED_TAG                    = "R-"
    
    HEALBOT_OPTIONS_SHOWUNITBUFFTIME        = "mutasd az én buffjaimat";
    HEALBOT_OPTIONS_BUFFSTEXTTIMER          = "a buff mutatása mielött lejárna";
    HEALBOT_OPTIONS_SHORTBUFFTIMER          = "Rövid buffok"
    HEALBOT_OPTIONS_LONGBUFFTIMER           = "Hosszú buffok"

    HEALBOT_OPTIONS_NOTIFY_MSG              = "üzenet"
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

    HEALBOT_OPTIONS_HOTPOSITION             = "Icon pozicio"
    HEALBOT_OPTIONS_HOTSHOWTEXT             = "mutasd az icon feliratot"
    HEALBOT_OPTIONS_HOTTEXTCOUNT            = "számlálo"
    HEALBOT_OPTIONS_HOTTEXTDURATION         = "idötartalom/duration"
    HEALBOT_OPTIONS_ICONSCALE               = "Icon méretezés"
    HEALBOT_OPTIONS_MAXICONS                = "Max Icons"
    HEALBOT_OPTIONS_ICONSPACER              = "Icon Spacer"
    HEALBOT_OPTIONS_EMERGBUTTONUSE          = "Use the Emergency Bar"

    HEALBOT_OPTIONS_AGGROBARSIZE            = "Aggro bar size/nagysága"
    HEALBOT_OPTIONS_DOUBLETEXTLINES         = "Kettös szövegsorral"
    HEALBOT_OPTIONS_TEXTALIGNMENT           = "szöveg igazitása"
    HEALBOT_OPTIONS_TEXTOFFSET              = "Vertical Offset"
    HEALBOT_OPTIONS_TEXTHOROFFSET           = "Horizontal Offset"
    HEALBOT_OPTIONS_EMERGINJTRIG            = "Injured threshold"
    HEALBOT_OPTIONS_EMERGCRITTRIG           = "Critical threshold"
    HEALBOT_OPTIONS_CUSTOMCOLHEALTH         = "Health bar custom col"..HEALBOT_enWORD_COLOUR_SUFFIX.."s"
    HEALBOT_OPTIONS_CUSTOMCOLBACK           = "Background bar custom col"..HEALBOT_enWORD_COLOUR_SUFFIX.."s"
    HEALBOT_OPTIONS_CUSTOMCOLINHEAL         = "Incoming heals bar custom col"..HEALBOT_enWORD_COLOUR_SUFFIX.."s"
    HEALBOT_OPTIONS_CUSTOMCOLABSORB         = "Absorb effects bar custom col"..HEALBOT_enWORD_COLOUR_SUFFIX.."s"
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
    HEALBOT_VEHICLE                         = "Vehicle/jármü"
    HEALBOT_WORDS_ERROR                     = "Error/Hiba"
    HEALBOT_SPELL_NOT_FOUND	                = "A Spell nem találhato"
    HEALBOT_OPTIONS_DISABLETOOLTIPINCOMBAT  = "rejtsd el a gyorstippeket in Combat"

    HEALBOT_OPTIONS_BUFFNAMED               = "irja be a játékos nevét figyelése érdekében\n\n"
    HEALBOT_WORD_ALWAYS                     = "mindig";
    HEALBOT_WORD_SOLO                       = "Solo";
    HEALBOT_WORD_NEVER                      = "soha";
    HEALBOT_SHOW_CLASS_AS_ICON              = "ikonként";
    HEALBOT_SHOW_CLASS_AS_TEXT              = "szövegként";
    HEALBOT_SHOW_ROLE                       = "show role when set";

    HEALBOT_SHOW_INCHEALS                   = "mutasd a bejövö heals";

    HEALBOT_FORHELP    = "For help use: "
    HEALBOT_HELP={ [1] = "[HealBot] /hb h -- Súgo megjelenitése",
                   [2] = "[HealBot] /hb o -- Váltás lehetöségek",
                   [3] = "[HealBot] /hb ri -- Reset HealBot",
                   [4] = "[HealBot] /hb t -- váltás Healbot között tiltott és engedélyezett",
                   [5] = "[HealBot] /hb bt -- váltás Buff Monitor között tiltott és engedélyezett",
                   [6] = "[HealBot] /hb dt -- váltás Debuff Monitor között tiltott és engedélyezett",
                   [7] = "[HealBot] /hb skin <skinName> -- kapcsolo Skins",
                   [8] = "[HealBot] /hb ui -- Reload UI",
                   [9] = "[HealBot] /hb hs -- További slash parancsokat mutat be a kijelzön",
                  }

    HEALBOT_HELP2={ [1] = "[HealBot] /hb d -- Újrainditás opciok alapértelmezésbe",
                    [2] = "[HealBot] /hb aggro 2 <n> -- állitsa be az aggro 2 szintü fenyegetés százalékban <n>",
                    [3] = "[HealBot] /hb aggro 3 <n> -- Set aggro level 3 on threat percentage <n>",
                    [4] = "[HealBot] /hb tr <Role> -- Állitsa be a legmagasabb role prioritást SubSort role-hoz. érvényes Roles are 'TANK', 'HEALER' or 'DPS'",
                    [5] = "[HealBot] /hb use10 -- Automatikusan használja Engineering slot 10",
                    [6] = "[HealBot] /hb pcs <n> -- Állitsa be a méretét a Holy power töltést jelzö által <n>, Az alapértelmezett érték a 7 ",
                    [7] = "[HealBot] /hb spt -- Saját Pet váltogatása",
                    [8] = "[HealBot] /hb ws -- Váltás elrejtése/megjelenitése Weaken soul ikon helyett a PW:S with a -",
                    [9] = "[HealBot] /hb rld <n> -- másodpercekben mennyi ideig legyen zöld a játékos neve az újraélesztést követöen ",
                    [10] = "[HealBot] /hb flb --Váltás a frame zár bypass (frame mindig mozog a Ctrl + Alt + bal kattintásal)",
                    [11] = "[HealBot] /hb rtb -- váltogatás korlátozás target bar to Left=SmartCast and Right=hozzáadása/eltávolitása to/from az én Targets",
                  }
                  
    HEALBOT_OPTION_HIGHLIGHTACTIVEBAR       = "Jelölje ki az egér fölötte van"
    HEALBOT_OPTION_HIGHLIGHTTARGETBAR       = "Jelölje ki a célpont"
    HEALBOT_OPTIONS_TESTBARS                = "Test Bars"
    HEALBOT_OPTIONS_TURNTESTBARSON          = "Turn On"
    HEALBOT_OPTIONS_TURNTESTBARSOFF         = "Turn Off"
    HEALBOT_OPTION_NUMBARS                  = "Bárok száma"
    HEALBOT_OPTION_NUMTANKS                 = "tankok száma"
    HEALBOT_OPTION_NUMMYTARGETS             = "az én célpontjaim száma"
    HEALBOT_OPTION_NUMHEALERS               = "Number of Healers"
    HEALBOT_OPTION_NUMPETS                  = "petek száma"
    HEALBOT_WORD_TEST                       = "Test";
    HEALBOT_OPTION_TESTMODE                 = "Test mode";
    HEALBOT_WORD_TEXT                       = "Text";
    HEALBOT_WORD_OFF                        = "Off";
    HEALBOT_WORD_ON                         = "On";
    HEALBOT_WORD_ONWITHOUTSOUND             = "On without sound";
    HEALBOT_WORD_ONWITHSOUND                = "On with sound";

    HEALBOT_OPTIONS_TAB_CHAT                = "Chat"
    HEALBOT_OPTIONS_TAB_HEADERS             = "fejlécek"
    HEALBOT_OPTIONS_TAB_BARS                = "Bars"
    HEALBOT_OPTIONS_TAB_BUTTONS             = "Buttons"
    HEALBOT_OPTIONS_TAB_ICONS               = "Icons"
    HEALBOT_OPTIONS_TAB_INDICATORS          = "Indicators"
    HEALBOT_OPTIONS_TAB_AGGROINDICATORS     = "Aggro indicators"
    HEALBOT_OPTIONS_TAB_LOWMANAINDICATORS   = "Low mana indicators"
    HEALBOT_OPTIONS_TAB_SELFCASTINDICATORS  = "Self cast icon indicators"
    HEALBOT_OPTIONS_TAB_POWERINDICATORS     = "Power indicators"
    HEALBOT_OPTIONS_TAB_WARNING             = "Figyelmeztetés"
    HEALBOT_OPTIONS_SKINDEFAULTFOR          = "Skin alapértelmezett"
    HEALBOT_OPTIONS_INCHEAL                 = "Bejövö heals"
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
    HEALBOT_WORD_COLOURS                    = "Colors";
    HEALBOT_WORD_COLOUR                     = "Color"
    HEALBOT_OPTIONS_COMBOAUTOTARGET         = "Auto\nTarget"
    HEALBOT_OPTIONS_COMBOAUTOTRINKET        = "Auto Trinket"
    HEALBOT_OPTIONS_GROUPSPERCOLUMN         = "használd a partyk egy oszlopban"

    HEALBOT_OPTIONS_MAINSORT                = "Fö rendezés"
    HEALBOT_OPTIONS_SUBSORT                 = "al rendezés"
    HEALBOT_OPTIONS_SUBSORTINC              = "szintén al rendezés:"

    HEALBOT_OPTIONS_BUTTONCASTMETHOD        = "cast amikor"
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

    HEALBOT_OPTIONS_ACCEPTSKINMSG           = "elfogadott [HealBot] Skin: "
    HEALBOT_OPTIONS_ACCEPTSKINMSGFROM       = " -tol "
    HEALBOT_OPTIONS_EXPORTSKIN              = "Select Skin"
    HEALBOT_OPTIONS_EXTRASKINS              = "Extra Skins"
    HEALBOT_OPTIONS_BUTTONEXPORT            = "Export"
    HEALBOT_OPTIONS_BUTTONIMPORT            = "Import"
    HEALBOT_OPTIONS_BUTTONIMPORTMETHOD      = "Import Method"
    HEALBOT_IMPORT_OVERWRITEALL             = "Overwrite All (Delete existing then insert all)"
    HEALBOT_IMPORT_MERGEALL                 = "Merge All (Update existing and insert new)"
    HEALBOT_IMPORT_MERGENEW                 = "Merge New (Only insert new)"

    HEALBOT_CHAT_ADDONID                    = "[HealBot]  "
    HEALBOT_CHAT_NEWVERSION1                = "Egy újabb verzio érhetö el"
    HEALBOT_CHAT_NEWVERSION2                = "at "..HEALBOT_ABOUT_URL
    HEALBOT_CHAT_SHARESKINERR1              = "Skin not found for Sharing"
    HEALBOT_CHAT_SHARESKINERR3              = " Nem találtunk Skin megosztás"
    HEALBOT_CHAT_SHARESKINACPT              = "megosztott Skin elfogadása -tol "
    HEALBOT_CHAT_CONFIRMSKINDEFAULTS        = "Skins beállitva alapértelmezettnek"
    HEALBOT_CHAT_CONFIRMCUSTOMDEFAULTS      = "Egyéni debuffot alaphelyzetbe"
    HEALBOT_CHAT_CHANGESKINERR1             = "ismeretlen skin: /hb skin "
    HEALBOT_CHAT_CHANGESKINERR2             = "érvényes skins:  "
    HEALBOT_CHAT_CONFIRMSPELLCOPY           = "Aktuális spellek másolása összes specifikáciokra"
    HEALBOT_CHAT_UNKNOWNCMD                 = "ismeretlen slash parancs: /hb "
    HEALBOT_CHAT_ENABLED                    = "Bevitel engedélyezett állapotban"
    HEALBOT_CHAT_DISABLED                   = "Bevitel NEMengedélyezett állapotban"
    HEALBOT_CHAT_SOFTRELOAD                 = "healbot Újratöltése szükésges"
    HEALBOT_CHAT_HARDRELOAD                 = "UI Újratöltése szükésges"
    HEALBOT_CHAT_CONFIRMSPELLRESET          = "a Spellek alaphelyzetbe kerültek"
    HEALBOT_CHAT_CONFIRMCURESRESET          = "a gyogymodok alaphelyzetbe kerültekt"
    HEALBOT_CHAT_CONFIRMBUFFSRESET          = "aBuffok alaphelyzetbe kerültek"
    HEALBOT_CHAT_CONFIRMICONRESET           = "Icons have been reset"
    HEALBOT_CHAT_POSSIBLEMISSINGMEDIA       = "Nem sikerült átadni az összes Skin beállitásokat - Esetleg hiányzik SharedMedia, letölthetö curse.com"
    HEALBOT_CHAT_MACROSOUNDON               = "Hangot nem csökkentjük auto trinkets használata esetén"
    HEALBOT_CHAT_MACROSOUNDOFF              = "Hangot csökkentjük auto trinkets használata esetén"
    HEALBOT_CHAT_MACROERRORON               = "hibáknál nem nyomjuk el az éppen használt auto trinkets"
    HEALBOT_CHAT_MACROERROROFF              = "hibáknál elnyomjuk az éppen használt auto trinkets"

    HEALBOT_CHAT_USE10ON                    = "Auto Trinket - Use10 is on - You must enable an existing auto trinket for use10 to work"
    HEALBOT_CHAT_USE10OFF                   = "Auto Trinket - Use10 is off"
    HEALBOT_CHAT_SKINREC                    = " skint érkezett -töl: " 
    HEALBOT_CHAT_MAINASSISTOFF              = "Main Assist excluded from Tanks"
    HEALBOT_CHAT_MAINASSISTON               = "Main Assist included with Tanks"

    HEALBOT_OPTIONS_SELFCASTS               = "csak a saját Cast-ot"
    HEALBOT_OPTIONS_SELFINDICATOR           = "Self indicator"
    HEALBOT_OPTIONS_HOTSHOWICON             = "Show icon"
    HEALBOT_OPTIONS_ALLSPELLS               = "összes spells"
    HEALBOT_OPTIONS_BUFFNAME                = "Buff Name"
    HEALBOT_OPTIONS_DOUBLEROW               = "Dupla sor"
    HEALBOT_OPTIONS_HOTBELOWBAR             = "Below bar"
    HEALBOT_OPTIONS_OTHERSPELLS             = "másik spells"
    HEALBOT_WORD_MACROS                     = "Macros"
    HEALBOT_WORD_SELECT                     = "Select"
    HEALBOT_WORD_SELECT_ALL                 = "Select all"
    HEALBOT_WORD_SELECT_NONE                = "Select none"
    HEALBOT_OPTIONS_QUESTION                = "?"
    HEALBOT_WORD_CANCEL                     = "Cancel"
    HEALBOT_WORD_DONE                       = "Done"
    HEALBOT_WORD_COMMANDS                   = "parancsok"
    HEALBOT_OPTIONS_BARHEALTH3              = "as health";
    HEALBOT_SORTBY_ROLE                     = "Role"
    HEALBOT_WORD_DPS                        = "DPS"
    HEALBOT_CHAT_TOPROLEERR                 = " A választott role nem érvényes ebben az összefüggésben - válaszd a 'TANK', 'DPS' or 'HEALER'"
    HEALBOT_CHAT_NEWTOPROLE                 = "Highest top role is now "
    HEALBOT_CHAT_SUBSORTPLAYER1             = "a Játékosnak elsönek a SubSort lesz beállitva"
    HEALBOT_CHAT_SUBSORTPLAYER2             = "A Játékos lesz rendezve rendszerint SubSort"
    HEALBOT_OPTIONS_SHOWREADYCHECK          = "mutasd a Ready Check-et";
    HEALBOT_OPTIONS_SHOWCLASSICON           = "Show Class";
    HEALBOT_OPTIONS_SUBSORTSELFFIRST        = "Self First"
    HEALBOT_OPTION_AGGROPCTBAR              = "Move bar"
    HEALBOT_OPTION_AGGROPCTTRACK            = "Szám százalékban" 
    HEALBOT_OPTIONS_ALERTAGGROLEVEL1        = "1 - Alacsony fenyegetés"
    HEALBOT_OPTIONS_ALERTAGGROLEVEL2        = "2 - Nagy fenyegetés"
    HEALBOT_OPTIONS_ALERTAGGROLEVEL3        = "3 - Tankolás"
    HEALBOT_OPTIONS_AGGROALERT              = "Bar riasztási szint"
    HEALBOT_OPTIONS_AGGROINDALERT           = "Indikátor riasztási szint"
    HEALBOT_OPTIONS_TOOLTIPSHOWHOT          = "Mutasd jelnleg ellenörzött HoT további részleteit"
    HEALBOT_WORDS_MIN                       = "min"
    HEALBOT_WORDS_MAX                       = "max"
    HEALBOT_CHAT_SELFPETSON                 = "Saját Pet bekapcsolva"
    HEALBOT_CHAT_SELFPETSOFF                = "Saját Pet kikapcsolva"
    HEALBOT_WORD_PRIORITY                   = "Priority"
    HEALBOT_VISIBLE_RANGE                   = "100 méteren Belül"
    HEALBOT_SPELL_RANGE                     = "spell távolságon belül"
    HEALBOT_WORD_RESET                      = "Reset"
    HEALBOT_WOWMENU                         = "Blizzard Menu";
    HEALBOT_HBMENU                          = "HealBot Menu"
    HEALBOT_ACTION_HBFOCUS                  = "Bal kattintás beállitása \ nfocus a célon"
    HEALBOT_WORD_CLEAR                      = "Clear"
    HEALBOT_WORD_SET                        = "Set"
    HEALBOT_WORD_HBFOCUS                    = "HealBot Focus"
    HEALBOT_WORD_OUTSIDE                    = "kivül"
    HEALBOT_WORD_ALLZONE                    = "All zones"
    HEALBOT_OPTIONS_TAB_ALERT               = "riado"
    HEALBOT_OPTIONS_TAB_SORT                = "rendez"
    HEALBOT_OPTIONS_TAB_HIDE                = "Elrejtés"
    HEALBOT_OPTIONS_TAB_VISIBILITY          = "Visibility"
    HEALBOT_OPTIONS_TAB_AGGRO               = "Aggro"
    HEALBOT_OPTIONS_TAB_AUX                 = "Aux"
    HEALBOT_OPTIONS_TAB_ICONTEXT            = "Icon szöveg"
    HEALBOT_OPTIONS_TAB_DEBUFFICONTEXT      = "Debuff icon text"
    HEALBOT_OPTIONS_TAB_BUFFICONTEXT        = "Buff icon text"
    HEALBOT_OPTIONS_TAB_TEXT                = "Bar szöveg"
    HEALBOT_OPTIONS_AGGRO3COL               = "Aggro bar\ncolour"
    HEALBOT_OPTIONS_AGGROFLASHFREQ          = "Flash gyakorisága"
    HEALBOT_OPTIONS_WORD_FASTER             = "Faster"
    HEALBOT_OPTIONS_WORD_SLOWER             = "Slower"
    HEALBOT_OPTIONS_AGGROFLASHALPHA         = "Flash átteszhetösége"
    HEALBOT_OPTIONS_FOCUSGROUPS             = "Focus Groups"
    HEALBOT_OPTIONS_FOCUSGROUPS1            = "OFF"
    HEALBOT_OPTIONS_FOCUSGROUPS2            = "ON: Fade unfocused groups"
    HEALBOT_OPTIONS_FOCUSGROUPS3            = "ON: Hide unfocused groups"
    HEALBOT_OPTIONS_SHOWDURATIONFROM        = "Mutasd idötartama alapján"
    HEALBOT_OPTIONS_SHOWDURATIONWARN        = "Idötartam figyelmeztetö"
    HEALBOT_OPTIONS_GOTOAUXCONFIG           = "Set Aux Bar Opacity Type"
    HEALBOT_CMD_RESETCUSTOMDEBUFFS          = "állitsa vissza az alapértelmezett debuffot"
    HEALBOT_CMD_RESETSKINS                  = "Reset skins"
    HEALBOT_CMD_CLEARBLACKLIST              = "feketelista törlése"
    HEALBOT_CMD_TOGGLEDISLIKEMOUNT          = "váltás az utálatos mountra"
    HEALBOT_OPTION_DISLIKEMOUNT_ON          = "ez most jelenleg egy utálatos Mount"
    HEALBOT_CMD_DISMOUNT                    = "Dismount"
    HEALBOT_OPTION_DISLIKEMOUNT_OFF         = "Többé már nem utálatos mount"
    HEALBOT_CMD_COPYSPELLS                  = "Másolja rá a jelenlegi spelleket az összes specifikáciora"
    HEALBOT_CMD_RESETSPELLS                 = "spellek vissza alaphelyzetbe"
    HEALBOT_CMD_RESETCURES                  = "cures vissza alaphelyzetbe"
    HEALBOT_CMD_RESETBUFFS                  = "buffs vissza alaphelyzetbe"
    HEALBOT_CMD_RESETICONS                  = "Reset custom buffs"
    HEALBOT_CMD_RESETBARS                   = "bar position vissza alaphelyzetbe"
    HEALBOT_CMD_SUPPRESSSOUND               = "váltás suppress hangra ha használod auto trinkets"
    HEALBOT_CMD_SUPPRESSERRORS              = "váltás suppress hibákra when using auto trinkets"
    HEALBOT_OPTIONS_COMMANDS                = "HealBot parancsok"
    HEALBOT_WORD_RUN                        = "Run"
    HEALBOT_OPTIONS_MOUSEWHEEL              = "használd az egér görgetöjét"
    HEALBOT_OPTIONS_MOUSEUP                 = "görditsd fel"
    HEALBOT_OPTIONS_MOUSEDOWN               = "görditsd le"
    HEALBOT_CMD_DELCUSTOMDEBUFF9            = "Delete custom debuffs on priority 9"
    HEALBOT_CMD_DELCUSTOMDEBUFF10           = "Delete custom debuffs on priority 10"
    HEALBOT_CMD_DELCUSTOMDEBUFF11           = "Delete custom debuffs on priority 11"
    HEALBOT_CMD_DELCUSTOMDEBUFF12           = "Delete custom debuffs on priority 12"
    HEALBOT_ACCEPTSKINS                     = "Elfogad Skineket másoktol"
    HEALBOT_SUPPRESSSOUND                   = "Auto Trinket: Suppress sound"
    HEALBOT_SUPPRESSERROR                   = "Auto Trinket: Suppress errors"
    HEALBOT_PERFLEVEL                       = "Performance Level"
    HEALBOT_OPTIONS_USEGENERALMACRO         = "Use general macro slots"
    HEALBOT_CP_MACRO_LEN                    = "a Makro névnek 1 és 14 karakter között kell lennie"
    HEALBOT_CP_MACRO_BASE                   = "Alap makronév"
    HEALBOT_CP_MACRO_SAVE                   = "Utoljára mentve: "
    HEALBOT_CP_STARTTIME                    = "védett idötartamú bejelentkezés"
    HEALBOT_COMBATPROT_PARTYNO              = "bárok lefoglalva a partynak"
    HEALBOT_COMBATPROT_RAIDNO               = "bárok lefoglalva a raidnek"
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
    HEALBOT_OPTIONS_CPUUSAGE                = "CPU Usage"
    HEALBOT_OPTIONS_THEME                   = "Options theme"
    HEALBOT_OPTIONS_DONT_SHOW               = "Ne mutasd"
    HEALBOT_OPTIONS_SAME_AS_HLTH_CURRENT    = "Same as health (current health)"
    HEALBOT_OPTIONS_SAME_AS_HLTH_FUTURE     = "Same as health (future health)"
    HEALBOT_OPTIONS_FUTURE_HLTH             = "jövöbeli health"
    HEALBOT_OPTIONS_CLASSHLTHMIX            = "Class Health mix"
    HEALBOT_SKIN_HEALTHBARCOL_TEXT          = "Health bar";
    HEALBOT_SKIN_NAMETEXTCOL_TEXT           = "Text color"
    HEALBOT_SKIN_HEALTHBACKCOL_TEXT         = "háttér bar";
    HEALBOT_SKIN_INCHEALBARCOL_TEXT         = "bejövö heals";
    HEALBOT_OPTIONS_GROUP_PETS_BY_FIVE      = "Pets: ötös csoportokban"
    HEALBOT_OPTIONS_OWN_PET_WITH_SELF       = "Own pet: with self"
    HEALBOT_OPTIONS_USEGAMETOOLTIP          = "Használja a játék gyorstippjeit"
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER        = "Mutasd a power számlálot"
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER_PALA   = "mutasd a holy powert"
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER_ROGU   = "Show combo points"
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER_WARL   = "Show soul shards"
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER_MONK   = "mutasd a chi powert"
    HEALBOT_OPTIONS_DISABLEHEALBOTSOLO      = "csak akkor, ha egyéni"
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
    HEALBOT_FOLLOW                          = "Follow"
    HEALBOT_TRADE                           = "Trade"
    HEALBOT_PROMOTE_RA                      = "elöléptet raid assistant"
    HEALBOT_DEMOTE_RA                       = "lefokoz raid assistant"
    HEALBOT_TOGGLE_ENABLED                  = "Váltás az engedélyezett"
    HEALBOT_TOGGLE_MYTARGETS                = "Váltás My Targets"
    HEALBOT_WORD_PERMANENT                  = "Permanent"
    HEALBOT_TOGGLE_PRIVATETANKS             = "Váltás private tanks"
    HEALBOT_TOGGLE_PRIVATEHEALERS           = "Toggle private healers"
    HEALBOT_RESET_BAR                       = "Reset bar"
    HEALBOT_HIDE_BARS                       = "Elrejteni a bárt 100 méter fölött"
    HEALBOT_RANDOMMOUNT                     = "véletlen Mount"
    HEALBOT_RANDOMGOUNDMOUNT                = "véletlen Ground Mount"
    HEALBOT_RANDOMPET                       = "véletlen Pet"
    HEALBOT_RANDOMFAVMOUNT                  = "Random Favorite Mount"
    HEALBOT_RANDOMFAVPET                    = "Random Favorite Pet"        
    HEALBOT_EXTRASKINS_CAT_GROUP            = "Group"
    HEALBOT_EXTRASKINS_CAT_SRAID            = "Small Raid"
    HEALBOT_EXTRASKINS_CAT_LRAID            = "Large Raid"
    HEALBOT_MACRO                           = "Macro"
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
    HEALBOT_RESLAG_INDICATOR                = "tarts a nevét zölden ujraélesztés után, beállitása" 
    HEALBOT_CLASSIC_HOT_IHDUR               = "Classic HoT incoming heal duration set to" 
    HEALBOT_RESLAG_INDICATOR_ERROR          = "tartsd a nevét zölden ujraélesztés követöen zölden 1 és 30 között" 
    HEALBOT_RESTRICTTARGETBAR_ON            = "Korlátoz Target bar be van kapcsolva"
    HEALBOT_RESTRICTTARGETBAR_OFF           = "Korlátoz Target bar ki van kapcsolva"
    HEALBOT_AGGRO2_ERROR_MSG                = "To set aggro level 2, threat percentage must be between 25 and 95"
    HEALBOT_AGGRO3_ERROR_MSG                = "To set aggro level 3, threat percentage must be between 75 and 100"
    HEALBOT_AGGRO2_SET_MSG                  = "Aggro 2. szintü megállapitott fenyegetés százalékban "
    HEALBOT_AGGRO3_SET_MSG                  = "Aggro 3. szintü megállapitott fenyegetés százalékban "
    HEALBOT_WORD_THREAT                     = "fenyegetés"
    HEALBOT_AGGRO_ERROR_MSG                 = "érvénytelen aggro szint - használd: 2 vagy 3"
   
    HEALBOT_OPTIONS_LOWMANAINDICATOR        = "kevés Mana kijelzö"
    HEALBOT_OPTIONS_LOWMANA                 = "Low mana"
    HEALBOT_OPTIONS_LOWMANAINDICATOR1       = "Ne mutasd"
    HEALBOT_OPTIONS_LOWMANAINDICATOR2       = "*10% / **20% / ***30%"
    HEALBOT_OPTIONS_LOWMANAINDICATOR3       = "*15% / **30% / ***45%"
    HEALBOT_OPTIONS_LOWMANAINDICATOR4       = "*20% / **40% / ***60%"
    HEALBOT_OPTIONS_LOWMANAINDICATOR5       = "*25% / **50% / ***75%"
    HEALBOT_OPTIONS_LOWMANAINDICATOR6       = "*30% / **60% / ***90%"

    HEALBOT_OPTIONS_SELFCASTIND             = "Self cast"
    HEALBOT_OPTION_IGNORE_AURA_RESTED       = "pihenés alatt aura események Figyelmen kivül hagyása"

    HEALBOT_WORD_ENABLE                     = "engedélyez"
    HEALBOT_WORD_DISABLE                    = "letiltás"

    HEALBOT_OPTIONS_MYCLASS                 = "My Class"
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
    HEALBOT_OPTIONS_CONTENT_MOUSEWHEEL      = "        egér görgö"
    HEALBOT_OPTIONS_CONTENT_TEST            = "        Teszt"
    HEALBOT_OPTIONS_CONTENT_INOUT           = "        Import / Export"
    HEALBOT_OPTIONS_CONTENT_PLUGINS         = "        " .. HEALBOT_OPTIONS_PLUGINS
    HEALBOT_OPTIONS_REFRESH                 = "felfrissit"

    HEALBOT_CUSTOM_CATEGORY                 = "Category"
    HEALBOT_CUSTOM_CAT_CUSTOM               = "Custom"
    HEALBOT_CUSTOM_CAT_02                   = "A - B" 
    HEALBOT_CUSTOM_CAT_03                   = "C - D"
    HEALBOT_CUSTOM_CAT_04                   = "E - F"
    HEALBOT_CUSTOM_CAT_05                   = "G - H"
    HEALBOT_CUSTOM_CAT_06                   = "I - J"
    HEALBOT_CUSTOM_CAT_07                   = "K - L"
    HEALBOT_CUSTOM_CAT_08                   = "M - N"
    HEALBOT_CUSTOM_CAT_09                   = "O - P"
    HEALBOT_CUSTOM_CAT_10                   = "Q - R"
    HEALBOT_CUSTOM_CAT_11                   = "S - T"
    HEALBOT_CUSTOM_CAT_12                   = "U - V"
    HEALBOT_CUSTOM_CAT_13                   = "W - X"
    HEALBOT_CUSTOM_CAT_14                   = "Y - Z"

    HEALBOT_PLUGIN_THREAT                   = "HealBot Threat"
    HEALBOT_PLUGIN_TIMETODIE                = "HealBot TimeToDie"
    HEALBOT_PLUGIN_TIMETOLIVE               = "HealBot TimeToLive"
    HEALBOT_PLUGIN_EXTRABUTTONS             = "HealBot ExtraButtons"
    HEALBOT_PLUGIN_COMBATPROT               = "HealBot CombatProt"
    HEALBOT_PLUGIN_PERFORMANCE              = "HealBot Performance"
    HEALBOT_PLUGIN_EFFECTIVETANKS           = "HealBot EffectiveTanks"
    HEALBOT_PLUGIN_EFFICIENTHEALERS         = "HealBot EfficientHealers"
    HEALBOT_PLUGIN_THREATPCT                = "Minimum threat"
    HEALBOT_PLUGIN_THREATMOBBARCOL          = "Mob bar colour"
    HEALBOT_PLUGIN_THREATMOBTEXTCOL         = "Mob text colour"
    
    HEALBOT_CUSTOM_CASTBY_EVERYONE          = "mindenki"
    HEALBOT_CUSTOM_CASTBY_ENEMY             = "ellenség"
    HEALBOT_CUSTOM_CASTBY_FRIEND            = "barát"
    
    HEALBOT_CUSTOM_CAT_CUSTOM_AUTOMATIC     = "Automatic Debuffs"


    HEALBOT_ABOUT_DESC1                    = "panel Hozzáadása skinable bárok gyogyulás, decursive buffing, újraélesztö és aggro nyomon követése"
    HEALBOT_ABOUT_WEBSITE                  = "Website:"
    HEALBOT_ABOUT_AUTHORH                  = "szerzö:"
    HEALBOT_ABOUT_AUTHORD                  = "authord:"
    HEALBOT_ABOUT_CATH                     = "Category:"
    HEALBOT_ABOUT_CATD                     = "Unit Frames, Buffs and Debuffs, Combat:Healer"
    HEALBOT_ABOUT_CREDITH                  = "Credits:"
    HEALBOT_ABOUT_LOCALH                   = "lokalizáciok:"
    HEALBOT_ABOUT_LOCALD                   = "deDE, enUK, esES, frFR, huHU, koKR, ruRU, poBR, zhCN, zhTW"
    HEALBOT_ABOUT_FAQH                     = "Gyakran Ismételt Kérdések"
    HEALBOT_ABOUT_FAQ_QUESTION             = "kérdés"
    HEALBOT_ABOUT_FAQ_ANSWER               = "válasz"

    HEALBOT_ABOUT_FAQ_QUESTIONS = {   [1]   = "Buffs - All the bars are White, what happened",
                                      [2]   = "Casting - Elöfordul, hogy a kurzor szine kékre változik, és én nem tehetek semmit",
                                      [3]   = "Macros - nekünk van néhány cooldown példánk",
                                      [4]   = "Macros - nekünk van néhány spell casting példánk",
                                      [5]   = "Mouse - How do I use my mouseover macros with the mouse wheel",
                                      [6]   = "Options - tudod a bárokat csoportok szerint rendezni például van 2 csoport per oszlop",
                                      [7]   = "Options - Can I hide all the bars and only show those needing a debuff removed",
                                      [8]   = "Options - Can I hide the incoming heals",
                                      [9]   = "Options - Healbot does not save my options when i logout/logon",
                                      [10]   = "Options - How do I always use enabled settings",
                                      [11]  = "Options - How do I disable healbot automatically",
                                      [12]  = "Options - How do I make the bars grow a different direction",
                                      [13]  = "Options - Hogyan tudom beállitani 'My Targets'",
                                      [14]  = "Options - Hogyan tudom beállitani 'Private Tanks'",
                                      [15]  = "Options - Will Healbot create a bar for an NPC",
                                      [16]  = "Range - Nem látom, amikor az emberek a tartományon kivül esnek, hogyan tudom kijavitani ezt",
                                      [17]  = "Spells - Healbot casts egy eltérö varázslatot mint ami nekem be van állitva",
                                      [18]  = "Spells - én többé már nem tudom castolni healt az unwounded (letekert?) targets",
                                  }

    HEALBOT_ABOUT_FAQ_SPELLS_ANSWER01       = "Ennek oka az opciok beállitása a Spells lapon \n" ..
                                              "probálja megváltoztatni a következöket és tesztelje: \n\n" ..
                                              "     1: A spells lapon: Kapcsolja be mindig: a Engedélyezettet használja \n" ..
                                              "     2: A spells lapon: kapcsolja ki SmartCast \n\n" ..
                                              "Note: It is expected that most users will want to \n"..
                                              "          turn SmartCast back on \n\n" ..
                                              "Note: It is expected that experienced users will want to \n" ..
                                              "          turn off Always Use Enabled  \n" ..
                                              "          and set the spells for disabled bars"
                                              
    HEALBOT_ABOUT_FAQ_ANSWERS = {     [1]   = "Te nyomon követed hiányzo/misselt buffokat \n\n" .. 
                                              "Ezt ki lehet kapcsolni a buffok lapon \n" ..
                                              "Alternativaként kattintson a bárban és castolhatjuk a buffot",
                                      [2]   = "Ezek a Blizzard funkciok, nem Healboté \n\n" .. 
                                              "Using the standard blizzard frames, \n" ..
                                              "try casting a spell thats on Cooldown \n" ..
                                              "Notice how the cursor turns blue. \n\n" ..
                                              "Megjegyzés: Semmi sem lehet tenni, hogy megakadályozzák ezt, míg \n" ..
                                              "in combat, since WoW 2.0 Blizzard has locked down \n" ..
                                              "the ui while in combat stopping all addons from \n" ..
                                              "changing spells or targets from what has been predefined \n\n" ..
                                              "It may help to monitor the spell cooldown in the tooltips",
                                      [3]   = "Yes \n\n"..
                                              "Paladin Hand of Salvation cooldown macro example: \n\n" ..
                                              "    #show Hand of Salvation \n" ..
                                              '    /script local n=UnitName("hbtarget"); ' .. "\n" ..
                                              '    if GetSpellCooldown("Hand of Salvation")==0 then ' .. " \n" ..
                                              '        SendChatMessage("Hand of Salvation on "..n,"YELL") ' .. "\n" ..
                                              '        SendChatMessage("Hand of Salvation!","WHISPER",nil,n) ' .. "\n" ..
                                              "    end; \n" ..
                                              "    /cast [@hbtarget] Hand of Salvation",
                                      [4]   = "Yes \n\n"..
                                              "Preist Flash Heal, example using both trinkets: \n\n" ..
                                              "    #show Flash Heal \n" ..
                                              "    /script UIErrorsFrame:Hide() \n" ..
                                              "    /console Sound_EnableSFX 0 \n" ..
                                              "    /use 13 \n" ..
                                              "    /use 14 \n" ..
                                              "    /console Sound_EnableSFX 1 \n" ..
                                              "    /cast [@hbtarget] Flash Heal \n" ..
                                              "    /script UIErrorsFrame:Clear(); UIErrorsFrame:Show()",
                                      [5]   = "1: On the Mouse Wheel tab: Turn off Use Mouse Wheel \n" ..
                                              "2: Bind your macros to blizzard's bindings with [@mouseover] \n\n\n" ..
                                              "Eample macro: \n\n" ..
                                              "    #showtooltip Flash Heal \n" ..
                                              "    /cast [@mouseover] Flash Heal \n",
                                      [6]   = "Yes \n\n\n"..
                                              "With Headers: \n" ..
                                              "     1: On the Skins>Headers tab, switch on Show Headers \n" ..
                                              "     2: On the Skins>Bars tab, set Number of Groups per column \n\n" ..
                                              "Without Headers: \n" ..
                                              "     1: On the Skins>Bars tab, switch on Use Groups per Column \n" ..
                                              "     2: On the Skins>Bars tab, set Number of Groups per column ",
                                      [7]   = "Yes \n\n"..
                                              "1: On the Skins>Healing>Alert tab, set Alert Level to 0 \n" ..
                                              "2: On the Skins>Aggro tab, turn off the Aggro Monitor \n" .. 
                                              "3: On the Skins>Bars tab, set Disabled opacity to 0 \n" ..
                                              "4: On the Skins>Bars tab, set Background opacity to 0 \n" ..
                                              "5: On the Skins>Bar Text tab, click on the bar Disabled \n" ..
                                              "     and set the Disabled text opacity to 0 \n" ..
                                              "6: On the Skins>General tab, click on the bar Background \n" ..
                                              "     and set the Background opacity to 0 \n" ..
                                              "7: On the Cure tab, Turn on debuff monitoring",
                                      [8]   = "Yes \n\n"..
                                              "1: On the Skins>Bars tab, set Incoming Heals to Dont Show \n" ..
                                              "2: On the Skins>Bar Text tab, \n" ..
                                              "          set Show Health on Bar to No Incoming Heals",
                                      [9]   = "This has been present since a change in WoW 3.2, \n" ..
                                              "it can affects characters with weird letters in their name \n\n" ..
                                              "If your on Vista or Win7, try the follow: \n"..
                                              "     change system locale to English (for non-unicode programs) \n" ..
                                              "     in Control Panel > Region and Language > Administrative Tab",

                                      [10]   = "On the spells tab turn on Always Use Enabled \n\n" ..
                                              "Some my also want to set the Alert Level to 100 \n" ..
                                              "This can be done on the Skins>Healing>Alert tab",
                                      [11]  = "Disable for a character: \n\n" ..
                                              "     1: Open the General tab \n" ..
                                              "     2: Turn on the Disable option \n\n\n" ..
                                              "Disable when solo: \n\n" ..
                                              "     1: Open the General tab \n" ..
                                              "     2: To the right of the Disable option, Select only when solo \n" ..
                                              "     3: Turn on the Disable option",
                                      [12]  = "Change the Bars Anchor setting on the Skins>General tab  \n\n" ..
                                              "     Top Right:        the bars will grow Down and Left \n" ..
                                              "     Top Left:          the bars will grow Down and Right \n" ..
                                              "     Bottom Right:  the bars will grow Up and Left \n" ..
                                              "     Bottom Left:     the bars will grow Up and Right",
                                      [13]  = "My Targets allows you to create a list of Targets you want to \n" ..
                                              "group separately from others, similar to the MT group \n\n" ..
                                              "The following options are available for \n" .. 
                                              "adding/removing people to/from the My Targets group \n\n" ..
                                              "     - Shift+Ctrl+Alt+Right click on the bar \n" ..
                                              '     - Use the Healbot Menu, enter "hbmenu" on the spells tab ' .. "\n" ..
                                              "     - Use the Mouse Wheel, set on the Mouse Wheel tab",
                                      [14]  = "Private Tanks can be added to the Main Tanks list, \n" ..
                                              "the Private tanks are only visible in your Healbot \n" ..
                                              "and do not affect other players or addons \n\n" ..
                                              "The following options are available for \n" ..
                                              "adding/removing people to/from the Tanks list \n\n" ..
                                              '     - Use the Healbot Menu, enter "hbmenu" on the spells tab ' .. "\n" ..
                                              "     - Use the Mouse Wheel, set on the Mouse Wheel tab",
                                      
                                      [15]  = "Yes \n\n"..
                                              "     1: On the Skins>Healing tab, turn on Focus \n" ..
                                              "     2: set your focus on the NPC (or PC not in raid/party) \n" ..
                                              "          Healbot will create a bar in your My Targets list \n\n" ..
                                              "Note: If in a combat situation where you zone in and out while \n" ..
                                              "          in combat and need to reset focus on an NPC \n" ..
                                              "          on the Skins>Healing tab set Focus: always show to on \n" ..
                                              "          This will keep the bar available during combat. \n\n" ..
                                              "Note: The HealBot Menu has the option 'Set HealBot Focus' \n" ..
                                              "          This can make setting focus easy on NPC's and \n" ..
                                              "          serves as a reminder to set focus. \n\n" ..
                                              "          Enter 'hbmenu' on the spells tab to use HealBot Menu \n" ..
                                              "          or use the Mouse Wheel tab to and set HealBot Menu",
                                      [16]  = "1:  On the Skins>Bars tab, adjust the disabled bar opacity \n" ..
                                              "2:  On the Skins>Bars Text tab, adjust the disabled text opacity \n" ..
                                              "       To do this click on the bar labeled Disabled. \n\n" ..
                                              "Some my also want to set the Alert Level to 100 \n" ..
                                              "This can be done on the Skins>Healing>Alert tab",
                                      [17]  = "Actually Healbot is casting exacly as the setup. \n\n" .. HEALBOT_ABOUT_FAQ_SPELLS_ANSWER01,
                                      [18]  = HEALBOT_ABOUT_FAQ_SPELLS_ANSWER01,
                                  }


    HEALBOT_OPTIONS_SKINAUTHOR              = "Skin Author:"
    HEALBOT_OPTIONS_MORESKINSURL            = "Extra skins are available on the Import/Export > Skins tab"
    HEALBOT_OPTIONS_AVOIDBLUECURSOR         = "Avoid\nBlue Cursor"
    HEALBOT_PLAYER_OF_REALM                 = "of"
        
    HEALBOT_OPTIONS_OVERRIDE_EFFECTS        = "Override Effects"
    HEALBOT_OPTIONS_OVERRIDE_CHAT           = "Override Chat"
    HEALBOT_OPTIONS_OVERRIDE_FRAMES         = "Override Frames"
    HEALBOT_USE_OVERRIDE_NO                 = "Use current skin settings."
    HEALBOT_USE_OVERRIDE_YES                = "Always use overrides on this tab."
    
    HEALBOT_OPTIONS_LANG                    = "nyelv"

    HEALBOT_OPTIONS_LANG_ZHCN               = "Chinese (zhCN)"
    HEALBOT_OPTIONS_LANG_ENUK               = "English (enUK)"
    HEALBOT_OPTIONS_LANG_ENUS               = "English (enUS)"
    HEALBOT_OPTIONS_LANG_FRFR               = "French (frFR)"
    HEALBOT_OPTIONS_LANG_DEDE               = "Deutsch (deDE)"
    HEALBOT_OPTIONS_LANG_GRGR               = "Greek (grGR)"
    HEALBOT_OPTIONS_LANG_HUHU               = "Hungarian (huHU)"
    HEALBOT_OPTIONS_LANG_ITIT               = "Italian (itIT)"
    HEALBOT_OPTIONS_LANG_KRKR               = "Korean (krKR)"
    HEALBOT_OPTIONS_LANG_PTBR               = "Portuguese (ptBR)"
    HEALBOT_OPTIONS_LANG_RURU               = "Russian (ruRU)"
    HEALBOT_OPTIONS_LANG_ESES               = "Spanish (esES)"
    HEALBOT_OPTIONS_LANG_TWTW               = "Taiwanese (twTW)"
    HEALBOT_OPTIONS_LANG_ESMX               = "Mexican (esMX)"
    
    HEALBOT_OPTIONS_LANG_ADDON_FAIL1        = "Nem sikerült betölteni az addont lokalizálására"
    HEALBOT_OPTIONS_LANG_ADDON_FAIL2        = "A hiba oka az:"
    HEALBOT_OPTIONS_LANG_ADDON_FAIL3        = "Note in the current verison, this is the only warning for"
    HEALBOT_OPTIONS_IMPORT_FAIL1            = "Failed to Import"
    HEALBOT_OPTIONS_IMPORT_FAIL2            = "Reason for failure is:"
    
    HEALBOT_OPTIONS_ADDON_FAIL              = "Failed to load headbot addon"
        
    HEALBOT_OPTIONS_IN_A_GROUP              = "Only when in a Group or Raid"
    HEALBOT_OPTIONS_ALSO_WHEN_MOUNTED       = "also when mounted"
    HEALBOT_OPTIONS_PALADIN_BLESSINGS       = "View all my blessings as same"
    
    HEALBOT_OPTIONS_TAB_EFFECTS              = "Effects"
    HEALBOT_OPTIONS_TAB_EMERG                = "Emergency"
    HEALBOT_OPTIONS_CONTENT_SKINS_GENERAL   = "    " .. HEALBOT_OPTIONS_TAB_GENERAL
    HEALBOT_OPTIONS_CONTENT_SKINS_EFFECTS    = "    " .. HEALBOT_OPTIONS_TAB_EFFECTS
    HEALBOT_OPTIONS_CONTENT_SKINS_ENEMY      = "    " .. HEALBOT_CUSTOM_CASTBY_ENEMY
    HEALBOT_OPTIONS_CONTENT_SKINSF_GENERAL   = "        " .. HEALBOT_OPTIONS_TAB_GENERAL
    HEALBOT_OPTIONS_CONTENT_SKINS_HEALING   = "    " .. HEALBOT_OPTIONS_TAB_HEALING
    HEALBOT_OPTIONS_CONTENT_SKINS_HEADERS   = "        " .. HEALBOT_OPTIONS_TAB_HEADERS
    HEALBOT_OPTIONS_CONTENT_SKINS_BARS      = "        " .. HEALBOT_OPTIONS_TAB_BARS
    HEALBOT_OPTIONS_CONTENT_SKINS_ICONS     = "        " .. HEALBOT_OPTIONS_TAB_ICONS
    HEALBOT_OPTIONS_CONTENT_SKINS_INDICATORS = "        " .. HEALBOT_OPTIONS_TAB_INDICATORS
    HEALBOT_OPTIONS_CONTENT_SKINS_EMERG      = "        " .. HEALBOT_OPTIONS_TAB_EMERG
    HEALBOT_OPTIONS_CONTENT_SKINS_AGGRO     = "    " .. HEALBOT_OPTIONS_TAB_AGGRO
    HEALBOT_OPTIONS_CONTENT_SKINS_CHAT      = "    " .. HEALBOT_OPTIONS_TAB_CHAT
    HEALBOT_OPTIONS_CONTENT_SKINS_TEXT      = "        " .. HEALBOT_OPTIONS_TAB_TEXT
    HEALBOT_OPTIONS_CONTENT_SKINS_ICONTEXT  = "        " .. HEALBOT_OPTIONS_TAB_ICONTEXT

    HEALBOT_OPTIONS_CONTENT_CURE_DEBUFF     = "    " .. HEALBOT_SKIN_DEBTEXT
    HEALBOT_OPTIONS_CONTENT_CURE_CUSTOM     = "    " .. HEALBOT_CLASSES_CUSTOM
    HEALBOT_OPTIONS_CONTENT_CURE_WARNING    = "    " .. HEALBOT_OPTIONS_TAB_WARNING

    HEALBOT_OPTIONS_CONTENT_BUFFS_GENERAL   = "    " .. HEALBOT_OPTIONS_TAB_GENERAL
    HEALBOT_OPTIONS_CONTENT_BUFFS_HOTS      = "    " .. HEALBOT_CLASSES_CUSTOM

    HEALBOT_OPTIONS_CONTENT_INOUT_PRESETCOL = HEALBOT_OPTIONS_PRESET.." Colors"
    HEALBOT_OPTIONS_CONTENT_SKINS_FRAMES    = "    " .. HEALBOT_OPTIONS_TAB_FRAMES
    
    HEALBOT_SKIN_ABSORBCOL_TEXT             = "Absorb effects";
    HEALBOT_OPTIONS_BARALPHAABSORB          = "Absorb effects opacity";
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
    HEALBOT_OPTIONS_HIDEMINIBOSSFRAMES      = "Hide mini boss frames";
    HEALBOT_OPTIONS_HIDERAIDFRAMES          = "Hide raid frames";
    HEALBOT_OPTIONS_FRAME_ALIAS             = "Alias"
    HEALBOT_OPTIONS_CONTENT_SKINS_HEALGROUP = "        " .. "Heal Groups"
    HEALBOT_OPTIONS_CONTENT_SKINS_BARCOLOUR = "        " .. "Bar Colors";
    HEALBOT_OPTIONS_SET_ALL_FRAMES          = "Copy current frame and tabs to other frames"
    HEALBOT_OPTIONS_CURRENT_FRAME           = "Current frame: "
    HEALBOT_OPTIONS_COPY_TABS               = "Copy tabs"
    HEALBOT_OPTIONS_TO_FRAMES               = "To frames"
    HEALBOT_WORDS_PROFILE                   = "Profile"
    HEALBOT_WORDS_GLOBALPROFILE             = "Global profile"
    HEALBOT_SHARE_SCREENSHOT                = "ScreenShot taken"
    HEALBOT_SHARE_INSTRUCTION               = "Go to the website for instrunctions on sharing with "..HEALBOT_ABOUT_URL
    HEALBOT_INOUT_STATUS_SKINSINIT          = "Skins can be shared at "..HEALBOT_ABOUT_URL
    HEALBOT_INOUT_STATUS_CDEBUFFINIT        = "Custom Debuffs can be shared at "..HEALBOT_ABOUT_URL
    HEALBOT_INOUT_STATUS_BUFFINIT           = "Custom Buffs can be shared at "..HEALBOT_ABOUT_URL
    HEALBOT_INOUT_STATUS_SPELLINIT          = "Spells can be shared at "..HEALBOT_ABOUT_URL
    HEALBOT_INOUT_STATUS_PRESETCOLINIT      = HEALBOT_OPTIONS_PRESET.." Colors can be shared at "..HEALBOT_ABOUT_URL
    HEALBOT_ENEMY_USE_FRAME                 = "Use frame"
    HEALBOT_ENEMY_INCLUDE_SELF              = "Include my target"
    HEALBOT_ENEMY_INCLUDE_TANKS             = "Include tanks targets"
    HEALBOT_OPTIONS_ENEMY_OPT               = "Enemy Options";
    HEALBOT_OPTIONS_SHARE_OPT               = "Share Options";
    HEALBOT_OPTIONS_CONTENT_SKINS_SHARE     = "    " .. "Share"
    HEALBOT_OPTIONS_CONTENT_SKINS_ENEMY     = "    " .. "Enemy"

    HEALBOT_ENEMY_NO_TARGET                 = "No target"
    HEALBOT_OPTIONS_ENEMYBARS               = "Enemy bars at all times";
    HEALBOT_OPTIONS_HARMFUL_SPELLS          = "Harmful Spells"
    HEALBOT_ENEMY_INCLUDE_MYTARGETS         = "Include My Targets targets"
    HEALBOT_ENEMY_NUMBER_BOSSES             = "Number of Bosses"
    HEALBOT_ENEMY_HIDE_OUTOFCOMBAT          = "Hide bars out of combat"
    HEALBOT_ENEMY_SHOW_TARGET               = "Show enemy target"
    HEALBOT_ENEMY_DOUBLE_WIDTH              = "Double total bar width"
    HEALBOT_ENEMY_TARGET_SIZE               = "Enemy target size"
    HEALBOT_OPTIONS_SHOW_ONLY_FRIEND        = "Only show Friendly"
    HEALBOT_OPTIONS_EXCLUDE_RAID            = "Exclude Self, Group and Raid"
    HEALBOT_OPTIONS_PROFILE                 = "Profile for".."\n".."Spells/Buffs/Cures"
    HEALBOT_OPTIONS_PROFILE_CHARACTER       = "Character"
    HEALBOT_OPTIONS_PROFILE_CLASS           = "Class"
    HEALBOT_OPTIONS_INCOMBATALERTLEVEL      = "Alert Level - In Combat";
    HEALBOT_OPTIONS_OUTCOMBATALERTLEVEL     = "Alert Level - Out of Combat";
    HEALBOT_OPTIONS_SORTOORLAST             = "Sort out of range last"
    HEALBOT_OPTION_NUMENEMYS                = "Number of Enemies"
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
    HEALBOT_SKIN_RAIDBARCOL                 = "Raid color"
    HEALBOT_SKIN_TANKBARCOL                 = "Tank color"
    HEALBOT_SKIN_YOURBARCOL                 = "My color"
    HEALBOT_OPTIONS_MAXBARS                 = "Max bars"
    HEALBOT_OPTIONS_STATUS                  = "Status"
    HEALBOT_OPTIONS_TEXTCOL_DEBUFF          = "Use Custom on Debuff"
    HEALBOT_OPTIONS_ALWAYSHIDE              = "Always hide"
    HEALBOT_OPTIONS_NOCHANGE                = "No Change"
    HEALBOT_OPTIONS_ALWAYSSHOW              = "Always Show"
    HEALBOT_OPTIONS_PAGE                    = "Page"
    HEALBOT_OPTIONS_PREV                    = "<<"
    HEALBOT_OPTIONS_NEXT                    = ">>"
    HEALBOT_OPTIONS_PRESET_COLOUR           = HEALBOT_OPTIONS_PRESET.." Color"
    
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
end
