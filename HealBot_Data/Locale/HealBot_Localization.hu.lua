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

    HEALBOT_DISEASE                         = "Disease/betegség";
    HEALBOT_MAGIC                           = "Magic/bübáj";
    HEALBOT_CURSE                           = "Curse/átok";
    HEALBOT_POISON                          = "Poison/mérgezés";

    HEALBOT_LOADED                          = " betölt.";
    HEALBOT_RANK   = {[1]="(Rank 1)", [2]="(Rank 2)", [3]="(Rank 3)", [4]="(Rank 4)", [5]="(Rank 5)", [6]="(Rank 6)", [7]="(Rank 7)",
                      [8]="(Rank 8)", [9]="(Rank 9)", [10]="(Rank 10)", [11]="(Rank 11)", [12]="(Rank 12)", [13]="(Rank 13)"}

    HEALBOT_ACTION_OPTIONS                  = "beállitások";

    HEALBOT_OPTIONS_DEFAULTS                = "alapértelmezés";
    HEALBOT_OPTIONS_CLOSE                   = "bezár";
    HEALBOT_OPTIONS_HARDRESET               = "frissiti az UI-t"
    HEALBOT_OPTIONS_TAB_GENERAL             = "általános";
    HEALBOT_OPTIONS_TAB_SPELLS              = "varázslatok";
    HEALBOT_OPTIONS_TAB_HEALING             = "gyogyitás";
    HEALBOT_OPTIONS_TAB_SKIN                = "kinézet/skin";
    HEALBOT_OPTIONS_TAB_TIPS                = "tippek";

    HEALBOT_OPTIONS_BARALPHA                = "átlászhatoság engedélyezése";
    HEALBOT_OPTIONS_BARALPHAINHEAL          = "bejövö heal átlászhatosága";
    HEALBOT_OPTIONS_BARALPHABACK            = "háttér bár átkászhatosága";
    HEALBOT_OPTIONS_BARALPHAEOR             = "távolságon túl átlászhatosága";
    HEALBOT_OPTIONS_ACTIONLOCKED            = "pozicio zárolása";
    HEALBOT_OPTIONS_AUTOSHOW                = "automatikusan befejezödik";
    HEALBOT_OPTIONS_HIDEOPTIONS             = "elrejtö gomb beállitások";
    HEALBOT_OPTIONS_HEAL_CHATOPT            = "Chat beállitások";

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
    HEALBOT_OPTIONS_SHOWDEBUFFWARNING       = "mutatja debuff figyelmeztetést";
    HEALBOT_OPTIONS_SOUNDDEBUFFWARNING      = "hangot ad debuff-nál";
    HEALBOT_OPTIONS_SOUND                   = "hangok/zenék"

    HEALBOT_OPTIONS_SELFHEALS               = "önmagad/self"
    HEALBOT_OPTIONS_PETHEALS                = "kisállat/Pets"
    HEALBOT_OPTIONS_GROUPHEALS              = "csoport/Group";
    HEALBOT_OPTIONS_TANKHEALS               = "Main/Fö tank-ok";
    HEALBOT_OPTIONS_PRIVATETANKS            = "saját fö tankok";
    HEALBOT_OPTIONS_PRIVATEHEALERS          = "Private healers";
    HEALBOT_OPTIONS_TARGETHEALS             = "Targets/célpont";
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
    HEALBOT_TOOLTIP_NONE                    = "nem elérhetö";
    HEALBOT_TOOLTIP_CORPSE                  = "holtteste a ";
    HEALBOT_WORDS_UNKNOWN                   = "ismeretlen";
    HEALBOT_WORDS_YES                       = "Yes/igen";
    HEALBOT_WORDS_NO                        = "No/nem";
    HEALBOT_WORDS_THIN                      = "vékony";
    HEALBOT_WORDS_THICK                     = "vastag";

    HEALBOT_WORDS_NONE                      = "None/egyik sem";
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

    HEALBOT_OPTIONS_SETDEFAULTS             = "alapértelmezett beállitás";
    HEALBOT_OPTIONS_SETDEFAULTSMSG          = "mindet visszaállyit az alapértelmezetre";
    HEALBOT_OPTIONS_SETLOCALDEFAULTSMSG     = "Reset spells/buffs/debuffs for this character\nto default values";
    HEALBOT_OPTIONS_RIGHTBOPTIONS           = "jobb click megnyitja az options/beállitásokat";

    HEALBOT_SKIN_HEADERBARCOL               = "Bar szinek";
    HEALBOT_SKIN_HEADERTEXTCOL              = "szöveg szinek";
    HEALBOT_OPTIONS_BUFFSTEXT2              = "tagok ellenörzése";
    HEALBOT_OPTIONS_BUFFSTEXT3              = "bar szinek";
    HEALBOT_OPTIONS_BUFFSELF                = "on self/saját magadra";
    HEALBOT_OPTIONS_BUFFPARTY               = "on party/partira";
    HEALBOT_OPTIONS_BUFFRAID                = "on raid/raidre";
    HEALBOT_OPTIONS_MONITORBUFFS            = "figyelje a nem talált/missing buffs";
    HEALBOT_OPTIONS_MONITORBUFFSC           = "also/szintén in combat";
    HEALBOT_OPTIONS_ENABLESMARTCAST         = "Smart/gyors Cast harcon kivül";
    HEALBOT_OPTIONS_SMARTCASTDISPELL        = "Remove/eltávolitja debuffs";
    HEALBOT_OPTIONS_SMARTCASTBUFF           = "Add/hozzáad buffs";
    HEALBOT_OPTIONS_SMARTCASTHEAL           = "Healing varázslatok";
    HEALBOT_OPTIONS_BAR2SIZE                = "Power bar méret";
    HEALBOT_OPTIONS_SETSPELLS               = "varázylatokat állit be";
    HEALBOT_OPTIONS_USEICONCMDS             = "Use icon commands";
    HEALBOT_OPTIONS_ENABLEDBARS             = "mindekor mutajta a bárokat";
    HEALBOT_OPTIONS_MONITORDEBUFFS          = "figyeli az eltávolitott debuff-okat";
    HEALBOT_OPTIONS_DEBUFFTEXT1             = "Spell-el eltávolitott debuffok";
    
    HEALBOT_OPTIONS_IGNOREDEBUFF            = "Ignore/mellözött debuffok:";
    HEALBOT_OPTIONS_IGNOREDEBUFFDURATION    = "Rövid idötartamú";
    HEALBOT_OPTIONS_IGNOREDEBUFFCOOLDOWN    = "mikor a gyogyito spell CoolDown > 2 secs";
    HEALBOT_OPTIONS_IGNOREDEBUFFFRIEND      = "ha a caster ismeri a barátját/friend";

    HEALBOT_OPTIONS_HIDEPARTYFRAMES         = "rejtsds el a party keretet/frames";
    HEALBOT_OPTIONS_HIDEPLAYERTARGET        = "Include player and target";
    HEALBOT_OPTIONS_DISABLEHEALBOT          = "kikapcsolja a HealBot-ot";

    HEALBOT_MAINTANK                        = "FöTank";
    
    HEALBOT_OPTIONS_SHOWMINIMAPBUTTON       = "engedélyez a minimapon egy gyorsgombot";
    HEALBOT_OPTIONS_BARBUTTONSHOWRAIDICON   = "mutaasd a Raid Target";
    HEALBOT_OPTIONS_HOTONBAR                = "On bar/báron";
    HEALBOT_OPTIONS_HOTOFFBAR               = "Off bar/bár mellett";

    HEALBOT_OPTION_AGGROTRACK               = "figyeld az Aggrot"
    HEALBOT_OPTION_USEFLUIDBARS             = "Use fluid/folyadék bars"
    HEALBOT_OPTIONS_RELOADUIMSG             = "Ez az opcio igényei az UI újrebetöltését! újratöltöd a képernyöt most?"

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
    
    HEALBOT_OPTIONS_SHOWUNITBUFFTIME        = "mutasd az én buffjaimat";
    HEALBOT_OPTIONS_BUFFSTEXTTIMER          = "a buff mutatása mielött lejárna";
    HEALBOT_OPTIONS_SHORTBUFFTIMER          = "Rövid buffok"
    HEALBOT_OPTIONS_LONGBUFFTIMER           = "Hosszú buffok"


    HEALBOT_OPTIONS_HOTPOSITION             = "Icon pozicio"
    HEALBOT_OPTIONS_HOTSHOWTEXT             = "mutasd az icon feliratot"
    HEALBOT_OPTIONS_HOTTEXTCOUNT            = "számlálo"
    HEALBOT_OPTIONS_HOTTEXTDURATION         = "idötartalom/duration"
    HEALBOT_OPTIONS_ICONSCALE               = "Icon méretezés"

    HEALBOT_OPTIONS_AGGROBARSIZE            = "Aggro bar size/nagysága"
    HEALBOT_OPTIONS_DOUBLETEXTLINES         = "Kettös szövegsorral"
    HEALBOT_OPTIONS_TEXTALIGNMENT           = "szöveg igazitása"
    HEALBOT_VEHICLE                         = "Vehicle/jármü"
    HEALBOT_WORDS_ERROR                     = "Error/Hiba"
    HEALBOT_SPELL_NOT_FOUND	                = "A Spell nem találhato"
    HEALBOT_OPTIONS_DISABLETOOLTIPINCOMBAT  = "rejtsd el a gyorstippeket in Combat"

    HEALBOT_OPTIONS_BUFFNAMED               = "irja be a játékos nevét figyelése érdekében\n\n"
    HEALBOT_WORD_ALWAYS                     = "mindig";
    HEALBOT_WORD_NEVER                      = "soha";
    HEALBOT_SHOW_CLASS_AS_ICON              = "ikonként";
    HEALBOT_SHOW_CLASS_AS_TEXT              = "szövegként";

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
    HEALBOT_OPTION_NUMBARS                  = "Bárok száma"
    HEALBOT_OPTION_NUMTANKS                 = "tankok száma"
    HEALBOT_OPTION_NUMMYTARGETS             = "az én célpontjaim száma"
    HEALBOT_OPTION_NUMPETS                  = "petek száma"

    HEALBOT_OPTIONS_TAB_HEADERS             = "fejlécek"
    HEALBOT_OPTIONS_TAB_WARNING             = "Figyelmeztetés"
    HEALBOT_OPTIONS_SKINDEFAULTFOR          = "Skin alapértelmezett"
    HEALBOT_OPTIONS_INCHEAL                 = "Bejövö heals"

    HEALBOT_OPTIONS_GROUPSPERCOLUMN         = "használd a partyk egy oszlopban"

    HEALBOT_OPTIONS_MAINSORT                = "Fö rendezés"
    HEALBOT_OPTIONS_SUBSORT                 = "al rendezés"
    HEALBOT_OPTIONS_SUBSORTINC              = "szintén al rendezés:"

    HEALBOT_OPTIONS_BUTTONCASTMETHOD        = "cast amikor"

    HEALBOT_OPTIONS_ACCEPTSKINMSG           = "elfogadott [HealBot] Skin: "
    HEALBOT_OPTIONS_ACCEPTSKINMSGFROM       = " -tol "
    
    HEALBOT_CHAT_NEWVERSION1                = "Egy újabb verzio érhetö el"
    HEALBOT_CHAT_NEWVERSION2                = "at "..HEALBOT_ABOUT_URL
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

    HEALBOT_CHAT_SKINREC                    = " skint érkezett -töl: " 

    HEALBOT_OPTIONS_SELFCASTS               = "csak a saját Cast-ot"
    HEALBOT_OPTIONS_ALLSPELLS               = "összes spells"
    HEALBOT_OPTIONS_DOUBLEROW               = "Dupla sor"
    HEALBOT_OPTIONS_OTHERSPELLS             = "másik spells"
    HEALBOT_WORD_COMMANDS                   = "parancsok"
    HEALBOT_CHAT_TOPROLEERR                 = " A választott role nem érvényes ebben az összefüggésben - válaszd a 'TANK', 'DPS' or 'HEALER'"
    HEALBOT_CHAT_SUBSORTPLAYER1             = "a Játékosnak elsönek a SubSort lesz beállitva"
    HEALBOT_CHAT_SUBSORTPLAYER2             = "A Játékos lesz rendezve rendszerint SubSort"
    HEALBOT_OPTIONS_SHOWREADYCHECK          = "mutasd a Ready Check-et";
    HEALBOT_OPTION_AGGROPCTTRACK            = "Szám százalékban" 
    HEALBOT_OPTIONS_ALERTAGGROLEVEL1        = "1 - Alacsony fenyegetés"
    HEALBOT_OPTIONS_ALERTAGGROLEVEL2        = "2 - Nagy fenyegetés"
    HEALBOT_OPTIONS_ALERTAGGROLEVEL3        = "3 - Tankolás"
    HEALBOT_OPTIONS_AGGROALERT              = "Bar riasztási szint"
    HEALBOT_OPTIONS_AGGROINDALERT           = "Indikátor riasztási szint"
    HEALBOT_OPTIONS_TOOLTIPSHOWHOT          = "Mutasd jelnleg ellenörzött HoT további részleteit"
    HEALBOT_CHAT_SELFPETSON                 = "Saját Pet bekapcsolva"
    HEALBOT_CHAT_SELFPETSOFF                = "Saját Pet kikapcsolva"
    HEALBOT_VISIBLE_RANGE                   = "100 méteren Belül"
    HEALBOT_SPELL_RANGE                     = "spell távolságon belül"
    HEALBOT_ACTION_HBFOCUS                  = "Bal kattintás beállitása \ nfocus a célon"
    HEALBOT_WORD_OUTSIDE                    = "kivül"
    HEALBOT_OPTIONS_TAB_ALERT               = "riado"
    HEALBOT_OPTIONS_TAB_SORT                = "rendez"
    HEALBOT_OPTIONS_TAB_HIDE                = "Elrejtés"
    HEALBOT_OPTIONS_TAB_ICONTEXT            = "Icon szöveg"
    HEALBOT_OPTIONS_TAB_TEXT                = "Bar szöveg"
    HEALBOT_OPTIONS_AGGRO3COL               = "Aggro bar\ncolour"
    HEALBOT_OPTIONS_AGGROFLASHFREQ          = "Flash gyakorisága"
    HEALBOT_OPTIONS_AGGROFLASHALPHA         = "Flash átteszhetösége"
    HEALBOT_OPTIONS_SHOWDURATIONFROM        = "Mutasd idötartama alapján"
    HEALBOT_OPTIONS_SHOWDURATIONWARN        = "Idötartam figyelmeztetö"
    HEALBOT_CMD_RESETCUSTOMDEBUFFS          = "állitsa vissza az alapértelmezett debuffot"
    HEALBOT_CMD_CLEARBLACKLIST              = "feketelista törlése"
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
    HEALBOT_OPTIONS_MOUSEWHEEL              = "használd az egér görgetöjét"
    HEALBOT_OPTIONS_MOUSEUP                 = "görditsd fel"
    HEALBOT_OPTIONS_MOUSEDOWN               = "görditsd le"
    HEALBOT_ACCEPTSKINS                     = "Elfogad Skineket másoktol"
    HEALBOT_CP_MACRO_LEN                    = "a Makro névnek 1 és 14 karakter között kell lennie"
    HEALBOT_CP_MACRO_BASE                   = "Alap makronév"
    HEALBOT_CP_MACRO_SAVE                   = "Utoljára mentve: "
    HEALBOT_CP_STARTTIME                    = "védett idötartamú bejelentkezés"
    HEALBOT_COMBATPROT_PARTYNO              = "bárok lefoglalva a partynak"
    HEALBOT_COMBATPROT_RAIDNO               = "bárok lefoglalva a raidnek"
    
    HEALBOT_OPTIONS_DONT_SHOW               = "Ne mutasd"
    HEALBOT_OPTIONS_FUTURE_HLTH             = "jövöbeli health"
    HEALBOT_SKIN_HEALTHBACKCOL_TEXT         = "háttér bar";
    HEALBOT_SKIN_INCHEALBARCOL_TEXT         = "bejövö heals";
    HEALBOT_OPTIONS_GROUP_PETS_BY_FIVE      = "Pets: ötös csoportokban"
    HEALBOT_OPTIONS_USEGAMETOOLTIP          = "Használja a játék gyorstippjeit"
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER        = "Mutasd a power számlálot"
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER_PALA   = "mutasd a holy powert"
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER_MONK   = "mutasd a chi powert"
    HEALBOT_OPTIONS_DISABLEHEALBOTSOLO      = "csak akkor, ha egyéni"

    HEALBOT_PROMOTE_RA                      = "elöléptet raid assistant"
    HEALBOT_DEMOTE_RA                       = "lefokoz raid assistant"
    HEALBOT_TOGGLE_ENABLED                  = "Váltás az engedélyezett"
    HEALBOT_TOGGLE_MYTARGETS                = "Váltás My Targets"
    
    HEALBOT_HIDE_BARS                       = "Elrejteni a bárt 100 méter fölött"
    HEALBOT_RANDOMMOUNT                     = "véletlen Mount"
    HEALBOT_RANDOMGOUNDMOUNT                = "véletlen Ground Mount"
    HEALBOT_RANDOMPET                       = "véletlen Pet"
    HEALBOT_ZONE_VASHJIR                    = "Vashj'ir"
    HEALBOT_RESLAG_INDICATOR                = "tarts a nevét zölden ujraélesztés után, beállitása" 
    HEALBOT_CLASSIC_HOT_IHDUR               = "Classic HoT incoming heal duration set to" 
    HEALBOT_RESLAG_INDICATOR_ERROR          = "tartsd a nevét zölden ujraélesztés követöen zölden 1 és 30 között" 
    HEALBOT_RESTRICTTARGETBAR_ON            = "Korlátoz Target bar be van kapcsolva"
    HEALBOT_RESTRICTTARGETBAR_OFF           = "Korlátoz Target bar ki van kapcsolva"
    HEALBOT_AGGRO2_SET_MSG                  = "Aggro 2. szintü megállapitott fenyegetés százalékban "
    HEALBOT_AGGRO3_SET_MSG                  = "Aggro 3. szintü megállapitott fenyegetés százalékban "
    HEALBOT_WORD_THREAT                     = "fenyegetés"
    HEALBOT_AGGRO_ERROR_MSG                 = "érvénytelen aggro szint - használd: 2 vagy 3"
   
    HEALBOT_OPTIONS_LOWMANAINDICATOR        = "kevés Mana kijelzö"
    HEALBOT_OPTIONS_LOWMANAINDICATOR1       = "Ne mutasd"

    HEALBOT_OPTION_IGNORE_AURA_RESTED       = "pihenés alatt aura események Figyelmen kivül hagyása"

    HEALBOT_WORD_ENABLE                     = "engedélyez"
    HEALBOT_WORD_DISABLE                    = "letiltás"
    
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
    
    HEALBOT_CUSTOM_CASTBY_EVERYONE          = "mindenki"
    HEALBOT_CUSTOM_CASTBY_ENEMY             = "ellenség"
    HEALBOT_CUSTOM_CASTBY_FRIEND            = "barát"

    HEALBOT_ABOUT_DESC1                    = "panel Hozzáadása skinable bárok gyogyulás, decursive buffing, újraélesztö és aggro nyomon követése"
    HEALBOT_ABOUT_AUTHORH                  = "szerzö:"
    HEALBOT_ABOUT_AUTHORD                  = "authord:"
    HEALBOT_ABOUT_LOCALH                   = "lokalizáciok:"
    HEALBOT_ABOUT_FAQH                     = "Gyakran Ismételt Kérdések"
    HEALBOT_ABOUT_FAQ_QUESTION             = "kérdés"
    HEALBOT_ABOUT_FAQ_ANSWER               = "válasz"
    HEALBOT_OPTIONS_LANG                    = "nyelv"
    
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

end

if (GetLocale() == "huHU") then
    HealBot_Lang_huHU()
end
