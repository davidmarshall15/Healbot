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
    HEALBOT_MONK                            = "Monk";

    HEALBOT_DISEASE                         = "Disease/betegség";
    HEALBOT_MAGIC                           = "Magic/bübáj";
    HEALBOT_CURSE                           = "Curse/átok";
    HEALBOT_POISON                          = "Poison/mérgezés";

    HB_TOOLTIP_OFFLINE                      = "Offline";
    HB_OFFLINE                              = "offline"; -- has gone offline msg
    HB_ONLINE                               = "online"; -- has come online msg

    HEALBOT_HEALBOT                         = "HealBot";
    HEALBOT_ADDON                           = HEALBOT_HEALBOT .. " " .. HEALBOT_VERSION;
    HEALBOT_LOADED                          = " betölt.";

    HEALBOT_ACTION_OPTIONS                  = "beállitások";

    HEALBOT_OPTIONS_TITLE                   = HEALBOT_ADDON;
    HEALBOT_OPTIONS_DEFAULTS                = "alapértelmezés";
    HEALBOT_OPTIONS_CLOSE                   = "bezár";
    HEALBOT_OPTIONS_HARDRESET               = "frissiti az UI-t"
    HEALBOT_OPTIONS_SOFTRESET               = "ResetHB"
    HEALBOT_OPTIONS_TAB_GENERAL             = "általános";
    HEALBOT_OPTIONS_TAB_SPELLS              = "varázslatok";
    HEALBOT_OPTIONS_TAB_HEALING             = "gyogyitás";
    HEALBOT_OPTIONS_TAB_CDC                 = "Cure";
    HEALBOT_OPTIONS_TAB_SKIN                = "kinézet/skin";
    HEALBOT_OPTIONS_TAB_TIPS                = "tippek";
    HEALBOT_OPTIONS_TAB_BUFFS               = "Buff-ok"

    HEALBOT_OPTIONS_BARALPHA                = "átlászhatoság engedélyezése";
    HEALBOT_OPTIONS_BARALPHAINHEAL          = "bejövö heal átlászhatosága";
    HEALBOT_OPTIONS_BARALPHABACK            = "háttér bár átkászhatosága";
    HEALBOT_OPTIONS_BARALPHAEOR             = "távolságon túl átlászhatosága";
    HEALBOT_OPTIONS_ACTIONLOCKED            = "pozicio zárolása";
    HEALBOT_OPTIONS_AUTOSHOW                = "automatikusan befejezödik";
    HEALBOT_OPTIONS_PANELSOUNDS             = "lejátszik egy hangot ha nyitva van";
    HEALBOT_OPTIONS_HIDEOPTIONS             = "elrejtö gomb beállitások";
    HEALBOT_OPTIONS_PROTECTPVP              = "Avoid PvP";
    HEALBOT_OPTIONS_HEAL_CHATOPT            = "Chat beállitások";

    HEALBOT_OPTIONS_FRAMESCALE              = "Frame Scale"
    HEALBOT_OPTIONS_SKINTEXT                = "használja a skin-t"
    HEALBOT_SKINS_STD                       = "Standard/alapvetö"
    HEALBOT_OPTIONS_SKINTEXTURE             = "Texture/struktúra"
    HEALBOT_OPTIONS_SKINHEIGHT              = "magasság"
    HEALBOT_OPTIONS_SKINWIDTH               = "szélesség"
    HEALBOT_OPTIONS_SKINNUMCOLS             = "oszlopok száma"
    HEALBOT_OPTIONS_SKINNUMHCOLS            = "csoportok száma oszloponként"
    HEALBOT_OPTIONS_SKINBRSPACE             = "sor távtarto/távolság"
    HEALBOT_OPTIONS_SKINBCSPACE             = "oszlop távtarto/távolság"
    HEALBOT_OPTIONS_EXTRASORT               = "Raid bárokat rendez"
    HEALBOT_SORTBY_NAME                     = "név"
    HEALBOT_SORTBY_CLASS                    = "Class"
    HEALBOT_SORTBY_GROUP                    = "Group/csoport"
    HEALBOT_SORTBY_MAXHEALTH                = "Max health/élet"
    HEALBOT_OPTIONS_NEWDEBUFFTEXT           = "új debuff"
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

    HEALBOT_OPTIONS_ITEMS                   = "Items/tárgyak";

    HEALBOT_OPTIONS_COMBOCLASS              = "gomb kombináciok";
    HEALBOT_OPTIONS_CLICK                   = "Click/kattintás";
    HEALBOT_OPTIONS_SHIFT                   = "Shift";
    HEALBOT_OPTIONS_CTRL                    = "Ctrl";
    HEALBOT_OPTIONS_ENABLEHEALTHY           = "Mindig engedélyezve";

    HEALBOT_OPTIONS_CASTNOTIFY1             = "Nincsenek üzenetek";
    HEALBOT_OPTIONS_CASTNOTIFY2             = "csak nekem jelez engem értesit";
    HEALBOT_OPTIONS_CASTNOTIFY3             = "éretesiti a célpontot/target";
    HEALBOT_OPTIONS_CASTNOTIFY4             = "éretsiti a party-t";
    HEALBOT_OPTIONS_CASTNOTIFY5             = "éretsiti a raid-et";
    HEALBOT_OPTIONS_CASTNOTIFY6             = "éretesiti chan";
    HEALBOT_OPTIONS_CASTNOTIFYRESONLY       = "csak feltámasztásnál éretesit";

    HEALBOT_OPTIONS_CDCBARS                 = "Bar szinek/colours";
    HEALBOT_OPTIONS_CDCSHOWHBARS            = "változtasd meg a health bar szinét";
    HEALBOT_OPTIONS_CDCSHOWABARS            = "változtasd meg aggro bar szinét";
    HEALBOT_OPTIONS_CDCWARNINGS             = "Debuff figyelmeztetések";
    HEALBOT_OPTIONS_SHOWDEBUFFICON          = "mutasd a debuff-ot";
    HEALBOT_OPTIONS_SHOWDEBUFFWARNING       = "mutatja debuff figyelmeztetést";
    HEALBOT_OPTIONS_SOUNDDEBUFFWARNING      = "hangot ad debuff-nál";
    HEALBOT_OPTIONS_SOUND                   = "hangok/zenék"

    HEALBOT_OPTIONS_HEAL_BUTTONS            = "Healing/gyogyito bárok";
    HEALBOT_OPTIONS_SELFHEALS               = "önmagad/self"
    HEALBOT_OPTIONS_PETHEALS                = "kisállat/Pets"
    HEALBOT_OPTIONS_GROUPHEALS              = "csoport/Group";
    HEALBOT_OPTIONS_TANKHEALS               = "Main/Fö tank-ok";
    HEALBOT_OPTIONS_MAINASSIST              = "Main/fö assist/segitö";
    HEALBOT_OPTIONS_PRIVATETANKS            = "saját fö tankok";
    HEALBOT_OPTIONS_TARGETHEALS             = "Targets/célpont";
    HEALBOT_OPTIONS_EMERGENCYHEALS          = "Raid";
    HEALBOT_OPTIONS_ALERTLEVEL              = "riasztási szint";
    HEALBOT_OPTIONS_EMERGFILTER             = "raid bárokat mutat";
    HEALBOT_OPTIONS_EMERGFCLASS             = "classes/osztályokat állit be";
    HEALBOT_OPTIONS_COMBOBUTTON             = "gomb";
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

    HEALBOT_OPTIONS_SHOWTOOLTIP             = "eszköztippek mutatása";
    HEALBOT_OPTIONS_SHOWDETTOOLTIP          = "Mutatja a részletes spell informáciot";
    HEALBOT_OPTIONS_SHOWCDTOOLTIP           = "mutatja a spell cooldown-t";
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
    HEALBOT_WORDS_SEC                       = "sec";
    HEALBOT_WORDS_CAST                      = "Cast";
    HEALBOT_WORDS_UNKNOWN                   = "ismeretlen";
    HEALBOT_WORDS_YES                       = "Yes/igen";
    HEALBOT_WORDS_NO                        = "No/nem";
    HEALBOT_WORDS_THIN                      = "vékony";
    HEALBOT_WORDS_THICK                     = "vastag";

    HEALBOT_WORDS_NONE                      = "None/egyik sem";
    HEALBOT_OPTIONS_ALT                     = "Alt";
    HEALBOT_DISABLED_TARGET                 = "Target/célpont";
    HEALBOT_OPTIONS_SHOWCLASSONBAR          = "mutasd a class-t a báron";
    HEALBOT_OPTIONS_SHOWHEALTHONBAR         = "mutasd az életet/health báron";
    HEALBOT_OPTIONS_BARHEALTHINCHEALS       = "beleszámolja a bejövö heals";
    HEALBOT_OPTIONS_BARHEALTHSEPHEALS       = "elkülöniti a bejövö heals";
    HEALBOT_OPTIONS_BARHEALTH1              = "deltában";
    HEALBOT_OPTIONS_BARHEALTH2              = "százalékban";
    HEALBOT_OPTIONS_TIPTEXT                 = "gyorstipp information";
    HEALBOT_OPTIONS_POSTOOLTIP              = "Position gyorstipp";
    HEALBOT_OPTIONS_SHOWNAMEONBAR           = "mutatja a neveket a báron";
    HEALBOT_OPTIONS_BARTEXTCLASSCOLOUR1     = "class/osztályonkénti szines szöveg";
    HEALBOT_OPTIONS_EMERGFILTERGROUPS       = "beleveszi a raid groups";

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
    HEALBOT_OPTIONS_RIGHTBOPTIONS           = "jobb click megnyitja az options/beállitásokat";

    HEALBOT_OPTIONS_HEADEROPTTEXT           = "Fejléc beállitások";
    HEALBOT_OPTIONS_ICONOPTTEXT             = "Icon beállitások";
    HEALBOT_SKIN_HEADERBARCOL               = "Bar szinek";
    HEALBOT_SKIN_HEADERTEXTCOL              = "szöveg szinek";
    HEALBOT_OPTIONS_BUFFSTEXT1              = "Spell to buff";
    HEALBOT_OPTIONS_BUFFSTEXT2              = "tagok ellenörzése";
    HEALBOT_OPTIONS_BUFFSTEXT3              = "bar szinek";
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
    HEALBOT_OPTIONS_ENABLEDBARS             = "mindekor mutajta a bárokat";
    HEALBOT_OPTIONS_DISABLEDBARS            = "elrejti a bárokat harcon kivül";
    HEALBOT_OPTIONS_MONITORDEBUFFS          = "figyeli az eltávolitott debuff-okat";
    HEALBOT_OPTIONS_DEBUFFTEXT1             = "Spell-el eltávolitott debuffok";

    HEALBOT_OPTIONS_IGNOREDEBUFF            = "Ignore/mellözött debuffok:";
    HEALBOT_OPTIONS_IGNOREDEBUFFCLASS       = "By class";
    HEALBOT_OPTIONS_IGNOREDEBUFFMOVEMENT    = "Lassú mozgás";
    HEALBOT_OPTIONS_IGNOREDEBUFFDURATION    = "Rövid idötartamú";
    HEALBOT_OPTIONS_IGNOREDEBUFFNOHARM      = "Nem káros";
    HEALBOT_OPTIONS_IGNOREDEBUFFCOOLDOWN    = "mikor a gyogyito spell CoolDown > 1.5 secs (GCD)";
    HEALBOT_OPTIONS_IGNOREDEBUFFFRIEND      = "ha a caster ismeri a barátját/friend";

    HEALBOT_OPTIONS_RANGECHECKFREQ          = "Range/hatotávolság, Aura and Aggro: ellenörzés gyakorisága";

    HEALBOT_OPTIONS_HIDEPARTYFRAMES         = "rejtsds el a party keretet/frames";
    HEALBOT_OPTIONS_HIDEPLAYERTARGET        = "Include player and target";
    HEALBOT_OPTIONS_DISABLEHEALBOT          = "kikapcsolja a HealBot-ot";

    HEALBOT_ASSIST                          = "Assist";
    HEALBOT_FOCUS                           = "Focus";
    HEALBOT_MENU                            = "Menu";
    HEALBOT_MAINTANK                        = "FöTank";
    HEALBOT_MAINASSIST                      = "FöAssist";
    HEALBOT_STOP                            = "Stop";
    HEALBOT_TELL                            = "Tell";

    HEALBOT_OPTIONS_SHOWMINIMAPBUTTON       = "engedélyez a minimapon egy gyorsgombot";
    HEALBOT_OPTIONS_BARBUTTONSHOWHOT        = "mutasd HoT";
    HEALBOT_OPTIONS_BARBUTTONSHOWRAIDICON   = "mutaasd a Raid Target";
    HEALBOT_OPTIONS_HOTONBAR                = "On bar/báron";
    HEALBOT_OPTIONS_HOTOFFBAR               = "Off bar/bár mellett";
    HEALBOT_OPTIONS_HOTBARRIGHT             = "Jobb oldali";
    HEALBOT_OPTIONS_HOTBARLEFT              = "Bal oldali";

    HEALBOT_ZONE_AB                         = "Arathi Basin";
    HEALBOT_ZONE_AV                         = "Alterac Valley";
    HEALBOT_ZONE_ES                         = "Eye of the Storm";
    HEALBOT_ZONE_IC                         = "Isle of Conquest";
    HEALBOT_ZONE_SA                         = "Strand of the Ancients";

    HEALBOT_OPTION_AGGROTRACK               = "figyeld az Aggrot"
    HEALBOT_OPTION_AGGROBAR                 = "Bar"
    HEALBOT_OPTION_AGGROTXT                 = ">> Text <<"
    HEALBOT_OPTION_AGGROIND                 = "Indicator"
    HEALBOT_OPTION_BARUPDFREQ               = "Refresh Multiplier"
    HEALBOT_OPTION_USEFLUIDBARS             = "Use fluid/folyadék bars"
    HEALBOT_OPTION_CPUPROFILE               = "CPU profilelemzöt használ (Addons CPU használat Info)"
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

    HEALBOT_OPTIONS_TTALPHA                 = "Opacity/áttetszöség"
    HEALBOT_TOOLTIP_TARGETBAR               = "Target Bar"
    HEALBOT_OPTIONS_MYTARGET                = "My Targets"

    HEALBOT_DISCONNECTED_TEXT               = "<DC>"
    HEALBOT_OPTIONS_SHOWUNITBUFFTIME        = "mutasd az én buffjaimat";
    HEALBOT_OPTIONS_TOOLTIPUPDATE           = "Folyamatosan frissiteni";
    HEALBOT_OPTIONS_BUFFSTEXTTIMER          = "a buff mutatása mielött lejárna";
    HEALBOT_OPTIONS_SHORTBUFFTIMER          = "Rövid buffok"
    HEALBOT_OPTIONS_LONGBUFFTIMER           = "Hosszú buffok"

    HEALBOT_OPTIONS_NOTIFY_MSG              = "üzenet"
    HEALBOT_WORDS_YOU                       = "you";
    HEALBOT_NOTIFYOTHERMSG                  = "Casting #s on #n";

    HEALBOT_OPTIONS_HOTPOSITION             = "Icon pozicio"
    HEALBOT_OPTIONS_HOTSHOWTEXT             = "mutasd az icon feliratot"
    HEALBOT_OPTIONS_HOTTEXTCOUNT            = "számlálo"
    HEALBOT_OPTIONS_HOTTEXTDURATION         = "idötartalom/duration"
    HEALBOT_OPTIONS_ICONSCALE               = "Icon méretezés"
    HEALBOT_OPTIONS_ICONTEXTSCALE           = "Icon szöveg méretezés"

    HEALBOT_OPTIONS_AGGROBARSIZE            = "Aggro bar size/nagysága"
    HEALBOT_OPTIONS_DOUBLETEXTLINES         = "Kettös szövegsorral"
    HEALBOT_OPTIONS_TEXTALIGNMENT           = "szöveg igazitása"
    HEALBOT_VEHICLE                         = "Vehicle/jármü"
    HEALBOT_WORDS_ERROR                     = "Error/Hiba"
    HEALBOT_SPELL_NOT_FOUND	                = "A Spell nem találhato"
    HEALBOT_OPTIONS_DISABLETOOLTIPINCOMBAT  = "rejtsd el a gyorstippeket in Combat"
    HEALBOT_OPTIONS_ENABLELIBQH             = "Enable HealBot fastHealth"

    HEALBOT_OPTIONS_BUFFNAMED               = "irja be a játékos nevét figyelése érdekében\n\n"
    HEALBOT_WORD_ALWAYS                     = "mindig";
    HEALBOT_WORD_SOLO                       = "Solo";
    HEALBOT_WORD_NEVER                      = "soha";
    HEALBOT_SHOW_CLASS_AS_ICON              = "ikonként";
    HEALBOT_SHOW_CLASS_AS_TEXT              = "szövegként";
    HEALBOT_SHOW_ROLE                       = "show role when set";

    HEALBOT_SHOW_INCHEALS                   = "mutasd a bejövö heals";

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
    HEALBOT_OPTION_NUMBARS                  = "Bárok száma"
    HEALBOT_OPTION_NUMTANKS                 = "tankok száma"
    HEALBOT_OPTION_NUMMYTARGETS             = "az én célpontjaim száma"
    HEALBOT_OPTION_NUMPETS                  = "petek száma"
    HEALBOT_WORD_TEST                       = "Test";
    HEALBOT_WORD_OFF                        = "Off";
    HEALBOT_WORD_ON                         = "On";

    HEALBOT_OPTIONS_TAB_PROTECTION          = "védelem"
    HEALBOT_OPTIONS_TAB_CHAT                = "Chat"
    HEALBOT_OPTIONS_TAB_HEADERS             = "fejlécek"
    HEALBOT_OPTIONS_TAB_BARS                = "Bars"
    HEALBOT_OPTIONS_TAB_ICONS               = "Icons"
    HEALBOT_OPTIONS_TAB_WARNING             = "Figyelmeztetés"
    HEALBOT_OPTIONS_SKINDEFAULTFOR          = "Skin alapértelmezett"
    HEALBOT_OPTIONS_INCHEAL                 = "Bejövö heals"
    HEALBOT_WORD_ARENA                      = "Arena"
    HEALBOT_WORD_BATTLEGROUND               = "Battle Ground"
    HEALBOT_OPTIONS_TEXTOPTIONS             = "szöveg beállitásai"
    HEALBOT_WORD_PARTY                      = "Party"
    HEALBOT_OPTIONS_COMBOAUTOTARGET         = "Auto\nTarget"
    HEALBOT_OPTIONS_COMBOAUTOTRINKET        = "Auto Trinket"
    HEALBOT_OPTIONS_GROUPSPERCOLUMN         = "használd a partyk egy oszlopban"

    HEALBOT_OPTIONS_MAINSORT                = "Fö rendezés"
    HEALBOT_OPTIONS_SUBSORT                 = "al rendezés"
    HEALBOT_OPTIONS_SUBSORTINC              = "szintén al rendezés:"

    HEALBOT_OPTIONS_BUTTONCASTMETHOD        = "cast amikor"
    HEALBOT_OPTIONS_BUTTONCASTPRESSED       = "Pressed"
    HEALBOT_OPTIONS_BUTTONCASTRELEASED      = "Released"

    HEALBOT_INFO_ADDONCPUUSAGE              = "==Addon CPU felhasználás másodpercben =="
    HEALBOT_INFO_ADDONCOMMUSAGE             = "== Addon Comms Usage =="
    HEALBOT_WORD_HEALER                     = "Healer"
    HEALBOT_WORD_DAMAGER                    = "Damager"
    HEALBOT_WORD_TANK                       = "Tank"
    HEALBOT_WORD_LEADER                     = "Leader"
    HEALBOT_WORD_VERSION                    = "Version"
    HEALBOT_WORD_CLIENT                     = "Client"
    HEALBOT_WORD_ADDON                      = "Addon"
    HEALBOT_INFO_CPUSECS                    = "CPU Secs"
    HEALBOT_INFO_MEMORYMB                   = "Memory MB"
    HEALBOT_INFO_COMMS                      = "Comms KB"

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
    HEALBOT_OPTIONS_BUTTONSHARESKIN         = "Megosztás"

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
    HEALBOT_CHAT_POSSIBLEMISSINGMEDIA       = "Nem sikerült átadni az összes Skin beállitásokat - Esetleg hiányzik SharedMedia, letölthetö curse.com"
    HEALBOT_CHAT_MACROSOUNDON               = "Hangot nem csökkentjük auto trinkets használata esetén"
    HEALBOT_CHAT_MACROSOUNDOFF              = "Hangot csökkentjük auto trinkets használata esetén"
    HEALBOT_CHAT_MACROERRORON               = "hibáknál nem nyomjuk el az éppen használt auto trinkets"
    HEALBOT_CHAT_MACROERROROFF              = "hibáknál elnyomjuk az éppen használt auto trinkets"
    HEALBOT_CHAT_ACCEPTSKINON               = "megosztott Skin - Elfogadom a skin Ablakot, ha valaki megosztja a skint velem"
    HEALBOT_CHAT_ACCEPTSKINOFF              = "megosztott Skin - automatikusan mindig elutasitom a ha valaki megakarja osztani a skinjét velem."
    HEALBOT_CHAT_USE10ON                    = "Auto Trinket - Use10 is on - You must enable an existing auto trinket for use10 to work"
    HEALBOT_CHAT_USE10OFF                   = "Auto Trinket - Use10 is off"
    HEALBOT_CHAT_SKINREC                    = " skint érkezett -töl: " 

    HEALBOT_OPTIONS_SELFCASTS               = "csak a saját Cast-ot"
    HEALBOT_OPTIONS_HOTSHOWICON             = "Show icon"
    HEALBOT_OPTIONS_ALLSPELLS               = "összes spells"
    HEALBOT_OPTIONS_DOUBLEROW               = "Dupla sor"
    HEALBOT_OPTIONS_HOTBELOWBAR             = "Below bar"
    HEALBOT_OPTIONS_OTHERSPELLS             = "másik spells"
    HEALBOT_WORD_MACROS                     = "Macros"
    HEALBOT_WORD_SELECT                     = "Select"
    HEALBOT_OPTIONS_QUESTION                = "?"
    HEALBOT_WORD_CANCEL                     = "Cancel"
    HEALBOT_WORD_COMMANDS                   = "parancsok"
    HEALBOT_OPTIONS_BARHEALTH3              = "as health";
    HEALBOT_SORTBY_ROLE                     = "Role"
    HEALBOT_WORD_DPS                        = "DPS"
    HEALBOT_CHAT_TOPROLEERR                 = " A választott role nem érvényes ebben az összefüggésben - válaszd a 'TANK', 'DPS' or 'HEALER'"
    HEALBOT_CHAT_NEWTOPROLE                 = "Highest top role is now "
    HEALBOT_CHAT_SUBSORTPLAYER1             = "a Játékosnak elsönek a SubSort lesz beállitva"
    HEALBOT_CHAT_SUBSORTPLAYER2             = "A Játékos lesz rendezve rendszerint SubSort"
    HEALBOT_OPTIONS_SHOWREADYCHECK          = "mutasd a Ready Check-et";
    HEALBOT_OPTIONS_SUBSORTSELFFIRST        = "Self First"
    HEALBOT_WORD_FILTER                     = "Szürés"
    HEALBOT_OPTION_AGGROPCTBAR              = "Move bar"
    HEALBOT_OPTION_AGGROPCTTXT              = "szöveg megjelenitése"
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
    HEALBOT_HBMENU                          = "HBmenu"
    HEALBOT_ACTION_HBFOCUS                  = "Bal kattintás beállitása \ nfocus a célon"
    HEALBOT_WORD_CLEAR                      = "Clear"
    HEALBOT_WORD_SET                        = "Set"
    HEALBOT_WORD_HBFOCUS                    = "HealBot Focus"
    HEALBOT_WORD_OUTSIDE                    = "kivül"
    HEALBOT_WORD_ALLZONE                    = "All zones"
    HEALBOT_OPTIONS_TAB_ALERT               = "riado"
    HEALBOT_OPTIONS_TAB_SORT                = "rendez"
    HEALBOT_OPTIONS_TAB_HIDE                = "Elrejtés"
    HEALBOT_OPTIONS_TAB_AGGRO               = "Aggro"
    HEALBOT_OPTIONS_TAB_ICONTEXT            = "Icon szöveg"
    HEALBOT_OPTIONS_TAB_TEXT                = "Bar szöveg"
    HEALBOT_OPTIONS_AGGRO3COL               = "Aggro bar\ncolour"
    HEALBOT_OPTIONS_AGGROFLASHFREQ          = "Flash gyakorisága"
    HEALBOT_OPTIONS_AGGROFLASHALPHA         = "Flash átteszhetösége"
    HEALBOT_OPTIONS_SHOWDURATIONFROM        = "Mutasd idötartama alapján"
    HEALBOT_OPTIONS_SHOWDURATIONWARN        = "Idötartam figyelmeztetö"
    HEALBOT_CMD_RESETCUSTOMDEBUFFS          = "állitsa vissza az alapértelmezett debuffot"
    HEALBOT_CMD_RESETSKINS                  = "Reset skins"
    HEALBOT_CMD_CLEARBLACKLIST              = "feketelista törlése"
    HEALBOT_CMD_TOGGLEACCEPTSKINS           = "Váltása másoktol Elfogadott Skinre"
    HEALBOT_CMD_TOGGLEDISLIKEMOUNT          = "váltás az utálatos mountra"
    HEALBOT_OPTION_DISLIKEMOUNT_ON          = "ez most jelenleg egy utálatos Mount"
    HEALBOT_OPTION_DISLIKEMOUNT_OFF         = "Többé már nem utálatos mount"
    HEALBOT_CMD_COPYSPELLS                  = "Másolja rá a jelenlegi spelleket az összes specifikáciora"
    HEALBOT_CMD_RESETSPELLS                 = "spellek vissza alaphelyzetbe"
    HEALBOT_CMD_RESETCURES                  = "cures vissza alaphelyzetbe"
    HEALBOT_CMD_RESETBUFFS                  = "buffs vissza alaphelyzetbe"
    HEALBOT_CMD_RESETBARS                   = "bar position vissza alaphelyzetbe"
    HEALBOT_CMD_SUPPRESSSOUND               = "váltás suppress hangra ha használod auto trinkets"
    HEALBOT_CMD_SUPPRESSERRORS              = "váltás suppress hibákra when using auto trinkets"
    HEALBOT_OPTIONS_COMMANDS                = "HealBot parancsok"
    HEALBOT_WORD_RUN                        = "Run"
    HEALBOT_OPTIONS_MOUSEWHEEL              = "használd az egér görgetöjét"
    HEALBOT_OPTIONS_MOUSEUP                 = "görditsd fel"
    HEALBOT_OPTIONS_MOUSEDOWN               = "görditsd le"
    HEALBOT_CMD_DELCUSTOMDEBUFF10           = "Delete custom debuffs on priority 10"
    HEALBOT_ACCEPTSKINS                     = "Elfogad Skineket másoktol"
    HEALBOT_SUPPRESSSOUND                   = "Auto Trinket: Suppress sound"
    HEALBOT_SUPPRESSERROR                   = "Auto Trinket: Suppress errors"
    HEALBOT_OPTIONS_CRASHPROT               = "Összeomlás védelem"
    HEALBOT_OPTIONS_USEGENERALMACRO         = "Use general macro slots"
    HEALBOT_CP_MACRO_LEN                    = "a Makro névnek 1 és 14 karakter között kell lennie"
    HEALBOT_CP_MACRO_BASE                   = "Alap makronév"
    HEALBOT_CP_MACRO_SAVE                   = "Utoljára mentve: "
    HEALBOT_CP_STARTTIME                    = "védett idötartamú bejelentkezés"
    HEALBOT_WORD_RESERVED                   = "foglalt"
    HEALBOT_OPTIONS_COMBATPROT              = "harci védelem"
    HEALBOT_COMBATPROT_PARTYNO              = "bárok lefoglalva a partynak"
    HEALBOT_COMBATPROT_RAIDNO               = "bárok lefoglalva a raidnek"

    HEALBOT_WORD_HEALTH                     = "Health"
    HEALBOT_OPTIONS_DONT_SHOW               = "Ne mutasd"
    HEALBOT_OPTIONS_SAME_AS_HLTH_CURRENT    = "Same as health (current health)"
    HEALBOT_OPTIONS_SAME_AS_HLTH_FUTURE     = "Same as health (future health)"
    HEALBOT_OPTIONS_FUTURE_HLTH             = "jövöbeli health"
    HEALBOT_SKIN_HEALTHBARCOL_TEXT          = "Health bar";
    HEALBOT_SKIN_HEALTHBACKCOL_TEXT         = "háttér bar";
    HEALBOT_SKIN_INCHEALBARCOL_TEXT         = "bejövö heals";
    HEALBOT_OPTIONS_ALWAYS_SHOW_TARGET      = "Target: Mindig mutassa"
    HEALBOT_OPTIONS_ALWAYS_SHOW_FOCUS       = "Focus: Mindig mutassa"
    HEALBOT_OPTIONS_GROUP_PETS_BY_FIVE      = "Pets: ötös csoportokban"
    HEALBOT_OPTIONS_USEGAMETOOLTIP          = "Használja a játék gyorstippjeit"
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER        = "Mutasd a power számlálot"
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER_PALA   = "mutasd a holy powert"
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER_MONK   = "mutasd a chi powert"
    HEALBOT_OPTIONS_CUSTOMDEBUFF_REVDUR     = "Forditott Idötartam"
    HEALBOT_OPTIONS_DISABLEHEALBOTSOLO      = "csak akkor, ha egyéni"
    HEALBOT_OPTIONS_CUSTOM_ALLDISEASE       = "All Disease"
    HEALBOT_OPTIONS_CUSTOM_ALLMAGIC         = "All Magic"
    HEALBOT_OPTIONS_CUSTOM_ALLCURSE         = "All Curse"
    HEALBOT_OPTIONS_CUSTOM_ALLPOISON        = "All Poison"
    HEALBOT_OPTIONS_CUSTOM_CASTBY           = "Cast By"

    HEALBOT_BLIZZARD_MENU                   = "Blizzard menu"
    HEALBOT_HB_MENU                         = "Healbot menu"
    HEALBOT_FOLLOW                          = "Follow"
    HEALBOT_TRADE                           = "Trade"
    HEALBOT_PROMOTE_RA                      = "elöléptet raid assistant"
    HEALBOT_DEMOTE_RA                       = "lefokoz raid assistant"
    HEALBOT_TOGGLE_ENABLED                  = "Váltás az engedélyezett"
    HEALBOT_TOGGLE_MYTARGETS                = "Váltás My Targets"
    HEALBOT_TOGGLE_PRIVATETANKS             = "Váltás private tanks"
    HEALBOT_RESET_BAR                       = "Reset bar"
    HEALBOT_HIDE_BARS                       = "Elrejteni a bárt 100 méter fölött"
    HEALBOT_RANDOMMOUNT                     = "véletlen Mount"
    HEALBOT_RANDOMGOUNDMOUNT                = "véletlen Ground Mount"
    HEALBOT_RANDOMPET                       = "véletlen Pet"
    HEALBOT_ZONE_AQ40                       = "Ahn'Qiraj"
    HEALBOT_ZONE_VASHJIR1                   = "Kelp'thar Forest"
    HEALBOT_ZONE_VASHJIR2                   = "Shimmering Expanse"
    HEALBOT_ZONE_VASHJIR3                   = "Abyssal Depths"
    HEALBOT_ZONE_VASHJIR                    = "Vashj'ir"
    HEALBOT_RESLAG_INDICATOR                = "tarts a nevét zölden ujraélesztés után, beállitása" 
    HEALBOT_RESLAG_INDICATOR_ERROR          = "tartsd a nevét zölden ujraélesztés követöen zölden 1 és 30 között" 
    HEALBOT_FRAMELOCK_BYPASS_OFF            = "Frame lock bypass ki van kapcsolva"
    HEALBOT_FRAMELOCK_BYPASS_ON             = "Frame lock bypass (Ctl+Alt+Left) be van kapcsolva"
    HEALBOT_RESTRICTTARGETBAR_ON            = "Korlátoz Target bar be van kapcsolva"
    HEALBOT_RESTRICTTARGETBAR_OFF           = "Korlátoz Target bar ki van kapcsolva"
    HEALBOT_PRELOADOPTIONS_ON               = "PreLoad Options be van kapcsolva"
    HEALBOT_PRELOADOPTIONS_OFF              = "PreLoad Options ki van kapcsolva"
    HEALBOT_AGGRO2_ERROR_MSG                = "To set aggro level 2, threat percentage must be between 25 and 95"
    HEALBOT_AGGRO3_ERROR_MSG                = "To set aggro level 3, threat percentage must be between 75 and 100"
    HEALBOT_AGGRO2_SET_MSG                  = "Aggro 2. szintü megállapitott fenyegetés százalékban "
    HEALBOT_AGGRO3_SET_MSG                  = "Aggro 3. szintü megállapitott fenyegetés százalékban "
    HEALBOT_WORD_THREAT                     = "fenyegetés"
    HEALBOT_AGGRO_ERROR_MSG                 = "érvénytelen aggro szint - használd: 2 vagy 3"

    HEALBOT_OPTIONS_QUERYTALENTS            = "Lekérdezés talnet adatok"       
    HEALBOT_OPTIONS_LOWMANAINDICATOR        = "kevés Mana kijelzö"
    HEALBOT_OPTIONS_LOWMANAINDICATOR1       = "Ne mutasd"
    HEALBOT_OPTIONS_LOWMANAINDICATOR2       = "*10% / **20% / ***30%"
    HEALBOT_OPTIONS_LOWMANAINDICATOR3       = "*15% / **30% / ***45%"
    HEALBOT_OPTIONS_LOWMANAINDICATOR4       = "*20% / **40% / ***60%"
    HEALBOT_OPTIONS_LOWMANAINDICATOR5       = "*25% / **50% / ***75%"
    HEALBOT_OPTIONS_LOWMANAINDICATOR6       = "*30% / **60% / ***90%"

    HEALBOT_OPTION_IGNORE_AURA_RESTED       = "pihenés alatt aura események Figyelmen kivül hagyása"
    HEALBOT_OPTION_ADJUST_MAX_HEALTH        = "Adjust unit max health"

    HEALBOT_WORD_ENABLE                     = "engedélyez"
    HEALBOT_WORD_DISABLE                    = "letiltás"

    HEALBOT_OPTIONS_MYCLASS                 = "My Class"

    HEALBOT_OPTIONS_CONTENT_ABOUT           = "        About"
    HEALBOT_OPTIONS_CONTENT_GENERAL         = "        " .. HEALBOT_OPTIONS_TAB_GENERAL
    HEALBOT_OPTIONS_CONTENT_SPELLS          = "        " .. HEALBOT_OPTIONS_TAB_SPELLS
    HEALBOT_OPTIONS_CONTENT_SKINS           = "        " .. HEALBOT_OPTIONS_TAB_SKIN
    HEALBOT_OPTIONS_CONTENT_CURE            = "        " .. HEALBOT_OPTIONS_TAB_CDC
    HEALBOT_OPTIONS_CONTENT_BUFFS           = "        " .. HEALBOT_OPTIONS_TAB_BUFFS
    HEALBOT_OPTIONS_CONTENT_TIPS            = "        " .. HEALBOT_OPTIONS_TAB_TIPS
    HEALBOT_OPTIONS_CONTENT_MOUSEWHEEL      = "        egér görgö"
    HEALBOT_OPTIONS_CONTENT_TEST            = "        Teszt"
    HEALBOT_OPTIONS_CONTENT_USAGE           = "        használat"
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

    HEALBOT_CUSTOM_CASTBY_EVERYONE          = "mindenki"
    HEALBOT_CUSTOM_CASTBY_ENEMY             = "ellenség"
    HEALBOT_CUSTOM_CASTBY_FRIEND            = "barát"

    HEALBOT_ABOUT_DESC1                    = "panel Hozzáadása skinable bárok gyogyulás, decursive buffing, újraélesztö és aggro nyomon követése"
    HEALBOT_ABOUT_WEBSITE                  = "Website:"
    HEALBOT_ABOUT_AUTHORH                  = "szerzö:"
    HEALBOT_ABOUT_AUTHORD                  = "authord:"
    HEALBOT_ABOUT_CATH                     = "Category:"
    HEALBOT_ABOUT_CATD                     = "Unit Frames, Buffs and Debuffs, Combat:Healer"
    HEALBOT_ABOUT_CREDITH                  = "Credits:"
    HEALBOT_ABOUT_CREDITD                  = "Acirac, Kubik, Von, Aldetal, Brezza, CT, Moonlight Han Xing"  -- Anyone taking on translations (if required), feel free to add yourself here.
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
    HEALBOT_OPTIONS_AVOIDBLUECURSOR         = "Avoid\nBlue Cursor"
    HEALBOT_PLAYER_OF_REALM                 = "of"
    
    HEALBOT_OPTIONS_LANG                    = "nyelv"
    HEALBOT_OPTIONS_LANG_ZHCN               = "Chinese (zhCN)"
    HEALBOT_OPTIONS_LANG_ENUK               = "English (enUK)"
    HEALBOT_OPTIONS_LANG_ENUS               = "English (enUS)"
    HEALBOT_OPTIONS_LANG_FRFR               = "French (frFR)"
    HEALBOT_OPTIONS_LANG_DEDE               = "Deutsch (deDE)"
    HEALBOT_OPTIONS_LANG_HUHU               = "Hungarian (huHU)"
    HEALBOT_OPTIONS_LANG_ITIT               = "Italian (itIT)"
    HEALBOT_OPTIONS_LANG_KRKR               = "Korean (krKR)"
    HEALBOT_OPTIONS_LANG_PTBR               = "Portuguese (ptBR)"
    HEALBOT_OPTIONS_LANG_RURU               = "Russian (ruRU)"
    HEALBOT_OPTIONS_LANG_ESES               = "Spanish (esES)"
    HEALBOT_OPTIONS_LANG_TWTW               = "Taiwanese (twTW)"
    
    HEALBOT_OPTIONS_LANG_ADDON_FAIL1        = "Nem sikerült betölteni az addont lokalizálására"
    HEALBOT_OPTIONS_LANG_ADDON_FAIL2        = "A hiba oka az:"
    HEALBOT_OPTIONS_LANG_ADDON_FAIL3        = "Note in the current verison, this is the only warning for"
    
    HEALBOT_OPTIONS_ADDON_FAIL              = "Failed to load headbot addon"
    
    HEALBOT_OPTIONS_CONTENT_SKINS_GENERAL   = "    " .. HEALBOT_OPTIONS_TAB_GENERAL
    HEALBOT_OPTIONS_CONTENT_SKINS_HEALING   = "    " .. HEALBOT_OPTIONS_TAB_HEALING
    HEALBOT_OPTIONS_CONTENT_SKINS_HEADERS   = "        " .. HEALBOT_OPTIONS_TAB_HEADERS
    HEALBOT_OPTIONS_CONTENT_SKINS_BARS      = "        " .. HEALBOT_OPTIONS_TAB_BARS
    HEALBOT_OPTIONS_CONTENT_SKINS_ICONS     = "        " .. HEALBOT_OPTIONS_TAB_ICONS
    HEALBOT_OPTIONS_CONTENT_SKINS_AGGRO     = "    " .. HEALBOT_OPTIONS_TAB_AGGRO
    HEALBOT_OPTIONS_CONTENT_SKINS_PROT      = "    " .. HEALBOT_OPTIONS_TAB_PROTECTION
    HEALBOT_OPTIONS_CONTENT_SKINS_CHAT      = "    " .. HEALBOT_OPTIONS_TAB_CHAT
    HEALBOT_OPTIONS_CONTENT_SKINS_TEXT      = "        " .. HEALBOT_OPTIONS_TAB_TEXT
    HEALBOT_OPTIONS_CONTENT_SKINS_ICONTEXT  = "        " .. HEALBOT_OPTIONS_TAB_ICONTEXT

    HEALBOT_OPTIONS_CONTENT_CURE_DEBUFF     = "    " .. HEALBOT_SKIN_DEBTEXT
    HEALBOT_OPTIONS_CONTENT_CURE_CUSTOM     = "    " .. HEALBOT_CLASSES_CUSTOM
    HEALBOT_OPTIONS_CONTENT_CURE_WARNING    = "    " .. HEALBOT_OPTIONS_TAB_WARNING
    
    HEALBOT_SKIN_ABSORBCOL_TEXT             = "Absorb effects";
    HEALBOT_OPTIONS_BARALPHAABSORB          = "Absorb effects opacity";
    HEALBOT_OPTIONS_OUTLINE                 = "Outline"
    HEALBOT_OPTIONS_FRAME                   = "Frame"
    HEALBOT_OPTIONS_CONTENT_SKINS_FRAMES    = "    " .. "Frames"
    HEALBOT_OPTIONS_FRAMESOPTTEXT           = "Frames options"
    HEALBOT_OPTIONS_SETTOOLTIP_POSITION     = "Set Tooltip Position"
    HEALBOT_OPTIONS_FRAME_ALIAS             = "Frame Title"
    HEALBOT_OPTIONS_FRAME_ALIAS_SHOW        = "Show Title"
    HEALBOT_OPTIONS_GROW_DIRECTION          = "Grow Direction"
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
    HEALBOT_OPTIONS_SET_ALL_FRAMES          = "Apply current tab settings to all Frames"
    HEALBOT_WORDS_PROFILE                   = "Profile"
    HEALBOT_SHARE_SCREENSHOT                = "ScreenShot taken"
    HEALBOT_SHARE_INSTRUCTION               = "Go to the website for instrunctions on sharing with "..HEALBOT_ABOUT_URL
    HEALBOT_ENEMY_USE_FRAME                 = "Use frame"
    HEALBOT_ENEMY_INCLUDE_SELF              = "Include my target"
    HEALBOT_ENEMY_INCLUDE_TANKS             = "Include tanks targets"
    HEALBOT_OPTIONS_ENEMY_OPT               = "Enemy Options";
    HEALBOT_OPTIONS_SHARE_OPT               = "Share Options";
    HEALBOT_OPTIONS_CONTENT_SKINS_SHARE     = "    " .. "Share"
    HEALBOT_OPTIONS_CONTENT_SKINS_ENEMY     = "    " .. "Enemy"
    HEALBOT_OPTIONS_BUTTONLOADSKIN          = "Load skin"
    HEALBOT_ENEMY_NO_TARGET                 = "No target"
    HEALBOT_OPTIONS_ENEMYBARS               = "Enemy bars at all times";
    HEALBOT_OPTIONS_HARMFUL_SPELLS          = "Harmful Spells"
    HEALBOT_ENEMY_INCLUDE_MYTARGETS         = "Include My Targets targets"
    HEALBOT_ENEMY_NUMBER_BOSSES             = "Number of Bosses"
    HEALBOT_ENEMY_HIDE_OUTOFCOMBAT          = "Hide bars out of combat"
    HEALBOT_ENEMY_EXISTS_SHOW               = "Entering combat only".."\n".."show when exists"
    HEALBOT_ENEMY_EXISTS_SHOW_PTARGETS      = "Player targets"
    HEALBOT_ENEMY_EXISTS_SHOW_BOSSES        = "Boss bars"
    HEALBOT_OPTIONS_TARGET_ONLY_FRIEND      = "Target: Only show Friendly"
    HEALBOT_OPTIONS_FOCUS_ONLY_FRIEND       = "Focus: Only show Friendly"
    HEALBOT_OPTIONS_PROFILE                 = "Profile for".."\n".."Spells/Buffs/Cures"
    HEALBOT_OPTIONS_PROFILE_CHARACTER       = "Character"
    HEALBOT_OPTIONS_PROFILE_CLASS           = "Class"
    HEALBOT_OPTIONS_INCOMBATALERTLEVEL      = "Alert Level - In Combat";
    HEALBOT_OPTIONS_OUTCOMBATALERTLEVEL     = "Alert Level - Out of Combat";
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
end
