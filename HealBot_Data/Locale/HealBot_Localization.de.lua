-- German translator required

------------
-- GERMAN --
------------
--
-- Ä = \195\132
-- Ö = \195\150
-- Ü = \195\156
-- ß = \195\159
-- ä = \195\164
-- ö = \195\182
-- ü = \195\188
--


function HealBot_Lang_deDE()

-----------------
-- Translation --
-----------------=
-- Class
    HEALBOT_DRUID                           = "Druide";
    HEALBOT_HUNTER                          = "J\195\164ger";
    HEALBOT_MAGE                            = "Magier";
    HEALBOT_PALADIN                         = "Paladin";
    HEALBOT_PRIEST                          = "Priester";
    HEALBOT_ROGUE                           = "Schurke";
    HEALBOT_SHAMAN                          = "Schamane";
    HEALBOT_WARLOCK                         = "Hexenmeister";
    HEALBOT_WARRIOR                         = "Krieger";
    HEALBOT_DEATHKNIGHT                     = "Todesritter";

    HEALBOT_DISEASE                         = "Krankheit";   
    HEALBOT_MAGIC                           = "Magie";
    HEALBOT_CURSE                           = "Fluch";   
    HEALBOT_POISON                          = "Gift";

    HEALBOT_LOADED                          = " geladen.";

    HEALBOT_RANK   = {[1]="(Rang 1)", [2]="(Rang 2)", [3]="(Rang 3)", [4]="(Rang 4)", [5]="(Rang 5)", [6]="(Rang 6)", [7]="(Rang 7)",
                      [8]="(Rang 8)", [9]="(Rang 9)", [10]="(Rang 10)", [11]="(Rang 11)", [12]="(Rang 12)", [13]="(Rang 13)"}
                      
    HEALBOT_ACTION_OPTIONS                  = "Optionen";
    HEALBOT_OPTIONS_DEFAULTS                = "Standardeinstellungen";
    HEALBOT_OPTIONS_CLOSE                   = "Schlie\195\159en";
    HEALBOT_OPTIONS_TAB_GENERAL             = "Allgemein";
    HEALBOT_OPTIONS_TAB_SPELLS              = "Zauber";  
    HEALBOT_OPTIONS_TAB_HEALING             = "Heilung";

    HEALBOT_OPTIONS_BARALPHA                = "Balken Transparenz";
    HEALBOT_OPTIONS_BARALPHAINHEAL          = "Eingehende Heilungstransparenz";
    HEALBOT_OPTIONS_BARALPHABACK            = "Hintergrund Balkenopazit\195\164t";
    HEALBOT_OPTIONS_BARALPHAEOR             = "Transparenz wenn au\195\159er Reichweite";
    HEALBOT_OPTIONS_ACTIONLOCKED            = "Fenster fixieren";
    HEALBOT_OPTIONS_AUTOSHOW                = "Automatisch \195\182ffnen";
    HEALBOT_OPTIONS_PANELSOUNDS             = "Ton beim \195\150ffnen";
    HEALBOT_OPTIONS_HIDEOPTIONS             = "Kein Optionen-Knopf";
    HEALBOT_OPTIONS_PROTECTPVP              = "Vermeidung des PvP Flags";
    HEALBOT_OPTIONS_HEAL_CHATOPT            = "Chat-Optionen";

    HEALBOT_OPTIONS_FRAMESCALE              = "Rahmenausma\195\159"
    HEALBOT_OPTIONS_SKINTEXT                = "Benutze Skin";  
    HEALBOT_SKINS_STD                       = "Standard";
    HEALBOT_OPTIONS_SKINTEXTURE             = "Textur";  
    HEALBOT_OPTIONS_SKINHEIGHT              = "H\195\182he";  
    HEALBOT_OPTIONS_SKINWIDTH               = "Breite";   
    HEALBOT_OPTIONS_SKINNUMCOLS             = "Anzahl der Spalten";  
    HEALBOT_OPTIONS_SKINNUMHCOLS            = "Anzahl der Gruppen pro Spalte";
    HEALBOT_OPTIONS_SKINBRSPACE             = "Reihenabstand";   
    HEALBOT_OPTIONS_SKINBCSPACE             = "Spaltenabstand";  
    HEALBOT_OPTIONS_EXTRASORT               = "Sort. Extrabalken nach";  
    HEALBOT_SORTBY_CLASS                    = "Klasse";  
    HEALBOT_SORTBY_GROUP                    = "Gruppe";
    HEALBOT_SORTBY_MAXHEALTH                = "Max. Leben";
    HEALBOT_OPTIONS_NEWDEBUFFTEXT           = "Neuer Debuff"   
    HEALBOT_OPTIONS_DELSKIN                 = "L\195\182schen"; 
    HEALBOT_OPTIONS_NEWSKINTEXT             = "Neuer Skin"; 
    HEALBOT_OPTIONS_SAVESKIN                = "Speichern";
    HEALBOT_OPTIONS_SKINBARS                = "Balken-Optionen";
    HEALBOT_SKIN_ENTEXT                     = "Aktiv"; 
    HEALBOT_SKIN_DISTEXT                    = "Inaktiv";
    HEALBOT_SKIN_BACKTEXT                   = "Hintergrund"; 
    HEALBOT_SKIN_BORDERTEXT                 = "Rand"; 
    HEALBOT_OPTIONS_SKINFONT                = "Schriftart"
    HEALBOT_OPTIONS_SKINFHEIGHT             = "Schriftgr\195\182\195\159e";
    HEALBOT_OPTIONS_SKINFOUTLINE            = "Schriftart Umriss"
    HEALBOT_OPTIONS_BARALPHADIS             = "Inaktiv-Transparenz";
    HEALBOT_OPTIONS_SHOWHEADERS             = "\195\156berschriften anzeigen";

    HEALBOT_OPTIONS_ITEMS                   = "Gegenst\195\164nde";

    HEALBOT_OPTIONS_COMBOCLASS              = "Tastenkombinationen f\195\188r";
    HEALBOT_OPTIONS_CLICK                   = "Klick";
    HEALBOT_OPTIONS_SHIFT                   = "Shift";
    HEALBOT_OPTIONS_CTRL                    = "Strg";
    HEALBOT_OPTIONS_ENABLEHEALTHY           = "Auch unverletzte Ziele heilen";

    HEALBOT_OPTIONS_CASTNOTIFY1             = "Keine Benachrichtigungen";
    HEALBOT_OPTIONS_CASTNOTIFY2             = "Nachricht an mich selbst";
    HEALBOT_OPTIONS_CASTNOTIFY3             = "Nachricht ans Ziel";
    HEALBOT_OPTIONS_CASTNOTIFY4             = "Nachricht an die Gruppe";
    HEALBOT_OPTIONS_CASTNOTIFY5             = "Nachricht an den Raid ";
    HEALBOT_OPTIONS_CASTNOTIFYRESONLY       = "Benachrichtigung nur bei Wiederbelebung";

    HEALBOT_OPTIONS_CDCBARS                 = "Balkenfarben";   
    HEALBOT_OPTIONS_CDCSHOWHBARS            = "Lebensbalkenfarbe \195\164ndern";
    HEALBOT_OPTIONS_CDCSHOWABARS            = "Aggrobalkenfarbe \195\164ndern";
    HEALBOT_OPTIONS_CDCWARNINGS             = "Warnung bei Debuffs";
    HEALBOT_OPTIONS_SHOWDEBUFFICON          = "Debuff anzeigen";
    HEALBOT_OPTIONS_SHOWDEBUFFWARNING       = "Warnung bei Debuff anzeigen";
    HEALBOT_OPTIONS_SOUNDDEBUFFWARNING      = "Spiele Ton bei Debuff"; 
    HEALBOT_OPTIONS_SOUND                   = "Ton";  

    HEALBOT_OPTIONS_HEAL_BUTTONS            = "Heilungsbalken f\195\188r";
    HEALBOT_OPTIONS_SELFHEALS               = "Selbst";
    HEALBOT_OPTIONS_PETHEALS                = "Begleiter";
    HEALBOT_OPTIONS_GROUPHEALS              = "Gruppe";
    HEALBOT_OPTIONS_MAINASSIST              = "Hauptassistent";
    HEALBOT_OPTIONS_PRIVATETANKS            = "Eigene Maintanks";
    HEALBOT_OPTIONS_TARGETHEALS             = "Ziele";
    HEALBOT_OPTIONS_ALERTLEVEL              = "Alarmstufe";
    HEALBOT_OPTIONS_EMERGFILTER             = "Notfall-Optionen f\195\188r";
    HEALBOT_OPTIONS_EMERGFCLASS             = "Klassenauswahl nach";
    HEALBOT_OPTIONS_COMBOBUTTON             = "Maustaste";  
    HEALBOT_OPTIONS_BUTTONLEFT              = "Links";  
    HEALBOT_OPTIONS_BUTTONMIDDLE            = "Mitte";  
    HEALBOT_OPTIONS_BUTTONRIGHT             = "Rechts"; 
    HEALBOT_OPTIONS_BUTTON4                 = "Taste4";  
    HEALBOT_OPTIONS_BUTTON5                 = "Taste5";  
    HEALBOT_OPTIONS_BUTTON6                 = "Taste6";
    HEALBOT_OPTIONS_BUTTON7                 = "Taste7";
    HEALBOT_OPTIONS_BUTTON8                 = "Taste8";
    HEALBOT_OPTIONS_BUTTON9                 = "Taste9";
    HEALBOT_OPTIONS_BUTTON10                = "Taste10";
    HEALBOT_OPTIONS_BUTTON11                = "Taste11";
    HEALBOT_OPTIONS_BUTTON12                = "Taste12";
    HEALBOT_OPTIONS_BUTTON13                = "Taste13";
    HEALBOT_OPTIONS_BUTTON14                = "Taste14";
    HEALBOT_OPTIONS_BUTTON15                = "Taste15";

    HEALBOT_CLASSES_ALL                     = "Alle Klassen";
    HEALBOT_CLASSES_MELEE                   = "Nahkampf";
    HEALBOT_CLASSES_RANGES                  = "Fernkampf";
    HEALBOT_CLASSES_HEALERS                 = "Heiler";
    HEALBOT_CLASSES_CUSTOM                  = "Pers\195\182nlich";

    HEALBOT_OPTIONS_SHOWTOOLTIP             = "Tooltips anzeigen"; 
    HEALBOT_OPTIONS_SHOWDETTOOLTIP          = "Detaillierte Spruchinfos anzeigen";
    HEALBOT_OPTIONS_SHOWCDTOOLTIP           = "Zauber-Abklingzeit anzeigen";
    HEALBOT_OPTIONS_SHOWUNITTOOLTIP         = "Zielinfos anzeigen";  
    HEALBOT_OPTIONS_SHOWRECTOOLTIP          = "Empf. Sofortzauber anzeigen";
    HEALBOT_TOOLTIP_POSDEFAULT              = "Standardposition";  
    HEALBOT_TOOLTIP_POSLEFT                 = "Links von Healbot";  
    HEALBOT_TOOLTIP_POSRIGHT                = "Rechts von Healbot";   
    HEALBOT_TOOLTIP_POSABOVE                = "\195\156ber Healbot";  
    HEALBOT_TOOLTIP_POSBELOW                = "Unter Healbot";   
    HEALBOT_TOOLTIP_POSCURSOR               = "Neben Mauszeiger";
    HEALBOT_TOOLTIP_RECOMMENDTEXT           = "Sofortzauber-Empfehlung";
    HEALBOT_TOOLTIP_NONE                    = "nicht verf\195\188gbar";
    HEALBOT_TOOLTIP_CORPSE                  = "Leichnam von "
    HEALBOT_WORDS_SEC                       = "Sek";
    HEALBOT_WORDS_CAST                      = "Zauber";
    HEALBOT_WORDS_UNKNOWN                   = "Unbekannt";
    HEALBOT_WORDS_YES                       = "Ja";
    HEALBOT_WORDS_NO                        = "Nein";
    HEALBOT_WORDS_THIN                      = "D\195\188nn";
    HEALBOT_WORDS_THICK                     = "Dick";

    HEALBOT_WORDS_NONE                      = "Nichts";
    HEALBOT_DISABLED_TARGET                 = "Ziel";
    HEALBOT_OPTIONS_SHOWCLASSONBAR          = "Klasse auf Balken anzeigen";
    HEALBOT_OPTIONS_SHOWHEALTHONBAR         = "Leben auf Balken anzeigen";
    HEALBOT_OPTIONS_BARHEALTHINCHEALS       = "Ankommende Heilung anzeigen";
    HEALBOT_OPTIONS_BARHEALTHSEPHEALS       = "Getrennte ankommende Heilung";
    HEALBOT_OPTIONS_BARHEALTHINCALL         = "Kommende Heilungen und Absorbs miteinbeziehen"
    HEALBOT_OPTIONS_BARHEALTHSEPALL         = "Kommende Heilungen und Absorbs trennen"
    HEALBOT_OPTIONS_BARHEALTH1              = "Defizit";
    HEALBOT_OPTIONS_BARHEALTH2              = "Prozentual";
    HEALBOT_OPTIONS_TIPTEXT                 = "Tooltip-Anzeige";
    HEALBOT_OPTIONS_POSTOOLTIP              = "Tooltip-Position";
    HEALBOT_OPTIONS_SHOWNAMEONBAR           = "mit Namen";
    HEALBOT_OPTIONS_BARTEXTCLASSCOLOUR1     = "Text in Klassenfarben";
    HEALBOT_OPTIONS_EMERGFILTERGROUPS       = "in Gruppe";

    HEALBOT_OPTIONS_SETDEFAULTS             = "Setze Standard-Einstellungen";
    HEALBOT_OPTIONS_SETDEFAULTSMSG          = "Stelle alle Optionen auf Standard zur\195\188ck";
    HEALBOT_OPTIONS_RIGHTBOPTIONS           = "Panel-Rechtsklick \195\182ffnet Optionen";

    HEALBOT_OPTIONS_HEADEROPTTEXT           = "\195\156berschriften-Optionen"; 
    HEALBOT_OPTIONS_ICONOPTTEXT             = "Symbol-Optionen";
    HEALBOT_SKIN_HEADERBARCOL               = "Balkenfarbe"; 
    HEALBOT_SKIN_HEADERTEXTCOL              = "Textfarbe"; 
    HEALBOT_OPTIONS_BUFFSTEXT1              = "Buff-Typ";
    HEALBOT_OPTIONS_BUFFSTEXT2              = "auf Mitglieder"; 
    HEALBOT_OPTIONS_BUFFSTEXT3              = "Balkenfarbe"; 
    HEALBOT_OPTIONS_BUFF                    = "Buff "; 
    HEALBOT_OPTIONS_BUFFSELF                = "nur selbst"; 
    HEALBOT_OPTIONS_BUFFPARTY               = "f\195\188r Gruppe"; 
    HEALBOT_OPTIONS_BUFFRAID                = "f\195\188r Raid"; 
    HEALBOT_OPTIONS_MONITORBUFFS            = "\195\156berwachung fehlender Buffs"; 
    HEALBOT_OPTIONS_MONITORBUFFSC           = "auch im Kampf"; 
    HEALBOT_OPTIONS_ENABLESMARTCAST         = "SmartCast au\195\159erhalb des Kampfs"; 
    HEALBOT_OPTIONS_SMARTCASTSPELLS         = "Inclusive Spr\195\188che"; 
    HEALBOT_OPTIONS_SMARTCASTDISPELL        = "Entferne Debuffs"; 
    HEALBOT_OPTIONS_SMARTCASTBUFF           = "Buffen"; 
    HEALBOT_OPTIONS_SMARTCASTHEAL           = "Heilen"; 
    HEALBOT_OPTIONS_BAR2SIZE                = "Manabalken-Gr\195\182\195\159e"; 
    HEALBOT_OPTIONS_SETSPELLS               = "Setze Zauber f\195\188r"; 
    HEALBOT_OPTIONS_ENABLEDBARS             = "Aktive Balken zu jeder Zeit"; 
    HEALBOT_OPTIONS_DISABLEDBARS            = "Inaktive Balken au\195\159erhalb des Kampfes"; 
    HEALBOT_OPTIONS_MONITORDEBUFFS          = "Debuff-\195\188berwachung"; 
    HEALBOT_OPTIONS_DEBUFFTEXT1             = "Zauber zum Entfernen des Debuffs"; 

    HEALBOT_OPTIONS_IGNOREDEBUFF            = "Ignoriere Debuffs:"; 
    HEALBOT_OPTIONS_IGNOREDEBUFFCLASS       = "Nach Klassen"; 
    HEALBOT_OPTIONS_IGNOREDEBUFFMOVEMENT    = "Verlangsamung"; 
    HEALBOT_OPTIONS_IGNOREDEBUFFDURATION    = "Kurzer Effekt"; 
    HEALBOT_OPTIONS_IGNOREDEBUFFNOHARM      = "Kein negativer Effekt"; 
    HEALBOT_OPTIONS_IGNOREDEBUFFCOOLDOWN    = "Wenn Kurierungsspruch's Abklingzeit > 1.5 Sekunden (GCD)";
    HEALBOT_OPTIONS_IGNOREDEBUFFFRIEND      = "Wenn Verzauberer als Freund bekannt ist";

    HEALBOT_OPTIONS_RANGECHECKFREQ          = "Reichweite, Aura und Aggro \195\156berpr\195\188fungs-Frequenz";

    HEALBOT_OPTIONS_HIDEPARTYFRAMES         = "Gruppenportraits verstecken";
    HEALBOT_OPTIONS_HIDEPLAYERTARGET        = "Spieler- und Zielportraits ausblenden";
    HEALBOT_OPTIONS_DISABLEHEALBOT          = "HealBot deaktivieren";

    HEALBOT_ASSIST                          = "Helfen";
    HEALBOT_FOCUS                           = "Fokus";
    HEALBOT_MENU                            = "Men\195\188";
    HEALBOT_STOP                            = "Stop";
    HEALBOT_TELL                            = "Sagen";

    HEALBOT_OPTIONS_SHOWMINIMAPBUTTON       = "Minimap-Button anzeigen";
    HEALBOT_OPTIONS_BARBUTTONSHOWHOT        = "HoT anzeigen";
    HEALBOT_OPTIONS_BARBUTTONSHOWRAIDICON   = "Schlachtzugssymbole anzeigen";
    HEALBOT_OPTIONS_HOTONBAR                = "auf Balken";
    HEALBOT_OPTIONS_HOTOFFBAR               = "neben Balken";
    HEALBOT_OPTIONS_HOTBARRIGHT             = "rechte Seite";
    HEALBOT_OPTIONS_HOTBARLEFT              = "linke Seite";

    HEALBOT_ZONE_AB                         = "Arathibecken";
    HEALBOT_ZONE_AV                         = "Alteractal";
    HEALBOT_ZONE_ES                         = "Auge des Sturms";
    HEALBOT_ZONE_IC                         = "Insel der Eroberung";
    HEALBOT_ZONE_SA                         = "Strand der Uralten";

    HEALBOT_OPTION_AGGROTRACK               = "Aggro \195\156berwachung"; 
    HEALBOT_OPTION_AGGROBAR                 = "Aufblitzen"; 
    HEALBOT_OPTION_AGGROTXT                 = ">> Zeige Text <<"; 
    HEALBOT_OPTION_AGGROIND                 = "Indikator"
    HEALBOT_OPTION_BARUPDFREQ               = "Balken-Aktualisierungsfrequenz";
    HEALBOT_OPTION_USEFLUIDBARS             = "'flie\195\159ende' Balken";
    HEALBOT_OPTION_CPUPROFILE               = "CPU-Profiler verwenden (Addons CPU usage Info)"
    HEALBOT_OPTIONS_RELOADUIMSG             = "Diese Option ben\195\182tigt einen UI Reload, jetzt neu laden?"

    HEALBOT_OPTIONS_ANCHOR                  = "Rahmen Anker"
    HEALBOT_OPTIONS_BARSANCHOR              = "Balken Anker"
    HEALBOT_OPTIONS_TOPLEFT                 = "Oben Links"
    HEALBOT_OPTIONS_BOTTOMLEFT              = "Unten Links"
    HEALBOT_OPTIONS_TOPRIGHT                = "Oben Rechts"
    HEALBOT_OPTIONS_BOTTOMRIGHT             = "Unten Rechts"
    HEALBOT_OPTIONS_TOP                     = "Oben"
    HEALBOT_OPTIONS_BOTTOM                  = "Unten"


    HEALBOT_WORDS_REMOVEFROM                = "Entferne von";
    HEALBOT_WORDS_ADDTO                     = "Hinzuf\195\188gen";
    HEALBOT_WORDS_INCLUDE                   = "f\195\188r";

    HEALBOT_OPTIONS_TTALPHA                 = "Transparenz"
    HEALBOT_TOOLTIP_TARGETBAR               = "Ziel-Balken"
    HEALBOT_OPTIONS_MYTARGET                = "meine Ziele"

    HEALBOT_OPTIONS_SHOWUNITBUFFTIME        = "meine Buffs anzeigen";
    HEALBOT_OPTIONS_TOOLTIPUPDATE           = "St\195\164ndig updaten";
    HEALBOT_OPTIONS_BUFFSTEXTTIMER          = "Buffs anzeigen, bevor sie auslaufen";
    HEALBOT_OPTIONS_SHORTBUFFTIMER          = "Kurze Buffs"
    HEALBOT_OPTIONS_LONGBUFFTIMER           = "Lange Buffs"

    HEALBOT_OPTIONS_NOTIFY_MSG              = "Nachricht"
    HEALBOT_WORDS_YOU                       = "dir/dich";
    HEALBOT_NOTIFYOTHERMSG                  = "Wirke #s auf #n";

    HEALBOT_OPTIONS_HOTPOSITION             = "Symbol Position";
    HEALBOT_OPTIONS_HOTSHOWTEXT             = "Symboltext anzeigen";
    HEALBOT_OPTIONS_HOTTEXTCOUNT            = "Z\195\164hler";
    HEALBOT_OPTIONS_HOTTEXTDURATION         = "Dauer";
    HEALBOT_OPTIONS_ICONSCALE               = "Symbol Ma\195\159stab"
    HEALBOT_OPTIONS_ICONTEXTSCALE           = "Symboltext Ma\195\159stab"

    HEALBOT_OPTIONS_AGGROBARSIZE            = "Gr\195\182\195\159e des Aggrobalkens";
    HEALBOT_OPTIONS_DOUBLETEXTLINES         = "Zweifache Textzeilen";
    HEALBOT_OPTIONS_TEXTALIGNMENT           = "Text-Ausrichtung";
    HEALBOT_VEHICLE                         = "Fahrzeug"
    HEALBOT_WORDS_ERROR                     = "Fehler"
    HEALBOT_SPELL_NOT_FOUND                 = "Zauber nicht gefunden"
    HEALBOT_OPTIONS_DISABLETOOLTIPINCOMBAT  = "Kein Tooltipp w\195\164hrend eines Kampfes"
    HEALBOT_OPTIONS_ENABLELIBQH             = "libFastHealth einschalten";

    HEALBOT_OPTIONS_BUFFNAMED               = "Eingabe der Spielernamen f\195\188r\n\n"
    HEALBOT_WORD_ALWAYS                     = "Immer";
    HEALBOT_WORD_NEVER                      = "Nie";
    HEALBOT_SHOW_CLASS_AS_ICON              = "als Symbol";
    HEALBOT_SHOW_CLASS_AS_TEXT              = "als Text";
    HEALBOT_SHOW_ROLE                       = "Rolle anzeigen";

    HEALBOT_SHOW_INCHEALS                   = "Ankommende Heilung anzeigen";

HEALBOT_HELP={  [1] = "[HealBot] /hb h -- Hilfe anzeigen",
                [2] = "[HealBot] /hb o -- Optionen umschalten",
   [3] = "[HealBot] /hb ri -- Reset HealBot",
                [4] = "[HealBot] /hb t -- Zwischen Healbot aktiviert/deaktiviert umschalten",
                [5] = "[HealBot] /hb bt -- Zwischen Buff Monitor aktiviert/deaktiviert umschalten",
                [6] = "[HealBot] /hb dt -- Zwischen Debuff Monitor aktiviert/deaktiviert umschalten",
                [7] = "[HealBot] /hb skin <skinName> -- wechselt Skins",
                [8] = "[HealBot] /hb ui -- UI neu laden",
   [9] = "[HealBot] /hb hs -- Weitere Slash-Kommandos anzeigen",
              }

HEALBOT_HELP2={ [1] = "[HealBot] /hb d -- Optionen auf Standard zur\195\188cksetzen",
    [2] = "[HealBot] /hb aggro 2 <n> -- Set aggro level 2 on threat percentage <n>",
    [3] = "[HealBot] /hb aggro 3 <n> -- Set aggro level 3 on threat percentage <n>",
                [4] = "[HealBot] /hb tr <Role> -- Setze h\195\182chste Rollenpriorit\195\164t f\195\188r Untersortierung nach Rolle. G\195\188ltige Rollen sind 'TANK', 'HEALER' oder 'DPS'",
                [5] = "[HealBot] /hb use10 -- Benutze automatisch Ingenieurskunst Slot 10",
                [6] = "[HealBot] /hb pcs <n> -- Anpassen der Gr\195\182\195\159e der Heilige Kraft Ladungsanzeige um <n>, Standardwert ist 7 ",
                [7] = "[HealBot] /hb spt -- zwischen eigenen Begleiter aktiviert/deaktiviert umschalten",
                [8] = "[HealBot] /hb ws -- Umschalten zwischen Verstecken/Zeigen des Geschw\195\164chte Seele Symbols anstatt MW:S mit einem -",
   [9] = "[HealBot] /hb rld <n> -- In Sekunden, wie lange der Spielername gr\195\188n bleibt nach einer Wiederbelebung",
   [10] = "[HealBot] /hb flb -- Toggle frame lock bypass (frame always moves with Ctrl+Alt+Left click)",
   [11] = "[HealBot] /hb rtb -- Toggle restrict target bar to Left=SmartCast and Right=add/remove to/from My Targets",
              }
              
    HEALBOT_OPTION_HIGHLIGHTACTIVEBAR       = "Mouseover hervorheben"
    HEALBOT_OPTION_HIGHLIGHTTARGETBAR       = "Ziel hervorheben"
    HEALBOT_OPTIONS_TESTBARS                = "Test Balken"
    HEALBOT_OPTION_NUMBARS                  = "Anzahl Balken"
    HEALBOT_OPTION_NUMTANKS                 = "Anzahl Tanks"
    HEALBOT_OPTION_NUMMYTARGETS             = "Anzahl meiner Ziele"
    HEALBOT_OPTION_NUMPETS                  = "Anzahl der Begleiter"
    HEALBOT_WORD_OFF                        = "Aus";
    HEALBOT_WORD_ON                         = "An";

    HEALBOT_OPTIONS_TAB_PROTECTION          = "Schutz"
    HEALBOT_OPTIONS_TAB_HEADERS             = "\195\156berschriften"
    HEALBOT_OPTIONS_TAB_BARS                = "Balken"
    HEALBOT_OPTIONS_TAB_ICONS               = "Symbole"
    HEALBOT_OPTIONS_TAB_WARNING             = "Warnung"
    HEALBOT_OPTIONS_SKINDEFAULTFOR          = "Standardskin f\195\188r"
    HEALBOT_OPTIONS_INCHEAL                 = "Ankommende Heilungen"
    HEALBOT_WORD_BATTLEGROUND               = "Schlachtfeld"
    HEALBOT_OPTIONS_TEXTOPTIONS             = "Text Optionen"
    HEALBOT_WORD_PARTY                      = "Gruppe"
        HEALBOT_OPTIONS_COMBOAUTOTARGET         = "Auto Ziel"
    HEALBOT_OPTIONS_COMBOAUTOTRINKET        = "Auto Schmuck"
    HEALBOT_OPTIONS_GROUPSPERCOLUMN         = "Benutze Gruppen pro Spalte"

    HEALBOT_OPTIONS_MAINSORT                = "Hauptsortierung"
    HEALBOT_OPTIONS_SUBSORT                 = "Untersortierung"
    HEALBOT_OPTIONS_SUBSORTINC              = "Ebenfalls sortieren"

    HEALBOT_OPTIONS_BUTTONCASTMETHOD        = "Wirke beim"
    HEALBOT_OPTIONS_BUTTONCASTPRESSED       = "dr\195\188cken"
    HEALBOT_OPTIONS_BUTTONCASTRELEASED      = "loslassen"

    HEALBOT_WORD_HEALER                     = "Heiler"
HEALBOT_WORD_DAMAGER                    = "Damager"

    HEALBOT_WORD_STAR                       = "Stern"
    HEALBOT_WORD_CIRCLE                     = "Kreis"
    HEALBOT_WORD_DIAMOND                    = "Diamant"
    HEALBOT_WORD_TRIANGLE                   = "Dreieck"
    HEALBOT_WORD_MOON                       = "Mond"
    HEALBOT_WORD_SQUARE                     = "Viereck"
    HEALBOT_WORD_CROSS                      = "Kreuz"
    HEALBOT_WORD_SKULL                      = "Totenkopf"

    HEALBOT_OPTIONS_ACCEPTSKINMSG           = "Akzeptiere [HealBot] Skin: "
    HEALBOT_OPTIONS_ACCEPTSKINMSGFROM       = " von "
    HEALBOT_OPTIONS_BUTTONSHARESKIN         = "Teile mit"

    HEALBOT_CHAT_NEWVERSION1                = "Eine neuere Version ist unter"
    HEALBOT_CHAT_NEWVERSION2                = HEALBOT_ABOUT_URL.." verf\195\188gbar"
    HEALBOT_CHAT_SHARESKINERR1              = " Skin zum Teilen nicht gefunden"
    HEALBOT_CHAT_SHARESKINERR3              = " nicht gefunden zum Skin Teilen"
    HEALBOT_CHAT_SHARESKINACPT              = "Geteilte Skin akzeptiert von "
    HEALBOT_CHAT_CONFIRMSKINDEFAULTS        = "Skins auf Standard gesetzt"
    HEALBOT_CHAT_CONFIRMCUSTOMDEFAULTS      = "Pers\195\182nliche Debuffs zur\195\188ckgesetzt"
    HEALBOT_CHAT_CHANGESKINERR1             = "Unbekanntes skin: /hb skin "
    HEALBOT_CHAT_CHANGESKINERR2             = "G\195\188ltige skins:  "
    HEALBOT_CHAT_CONFIRMSPELLCOPY           = "Aktuelle Spr\195\188che f\195\188r in alle Skillungen \195\188bernommen"
    HEALBOT_CHAT_UNKNOWNCMD                 = "Unbekanntes Kommandozeilenbefehl: /hb "
    HEALBOT_CHAT_ENABLED                    = "Status jetzt aktiviert"
    HEALBOT_CHAT_DISABLED                   = "Status jetzt deaktiviert"
    HEALBOT_CHAT_SOFTRELOAD                 = "Healbot Reload angefragt"
    HEALBOT_CHAT_HARDRELOAD                 = "UI Reload angefragt"
    HEALBOT_CHAT_CONFIRMSPELLRESET          = "Spr\195\188che wurden zur\195\188ckgesetzt"
    HEALBOT_CHAT_CONFIRMCURESRESET          = "Heilung wurde zur\195\188ckgesetzt"
    HEALBOT_CHAT_CONFIRMBUFFSRESET          = "Buffs wurde zur\195\188ckgesetzt"
    HEALBOT_CHAT_POSSIBLEMISSINGMEDIA       = "Es ist nicht m\195\182glich alle Skin-Einstellungen zu empfangen - evtl. fehlen SharedMedia-Daten."
    HEALBOT_CHAT_MACROSOUNDON               = "Ton wird nicht unterdr\195\188ckt, wenn Auto Schmuck benutzt wird"
    HEALBOT_CHAT_MACROSOUNDOFF              = "Ton wird unterdr\195\188ckt, wenn Auto Schmuck benutzt wird"
    HEALBOT_CHAT_MACROERRORON               = "Fehler werden nicht unterdr\195\188ckt, wenn Auto Schmuck benutzt wird"
    HEALBOT_CHAT_MACROERROROFF              = "Fehler werden unterdr\195\188ckt, wenn Auto Schmuck benutzt wird"
    HEALBOT_CHAT_ACCEPTSKINON               = "Teile Skin - Zeige Akzeptiere-Skin-Popup wenn jemand ein Skin mit dir teilen m\195\182chte"
    HEALBOT_CHAT_ACCEPTSKINOFF              = "Teile Skin - Skin Teilen von allen immer ignorieren"
    HEALBOT_CHAT_USE10ON                    = "Auto Schmuck - Use10 ist eingeschaltet - Damit use10 funktioniert muss ein Auto Schmuck aktiviert sein"
    HEALBOT_CHAT_USE10OFF                   = "Auto Schmuck - Use10 ist ausgeschaltet"
    HEALBOT_CHAT_SKINREC                    = " Skin erhalten von " 

    HEALBOT_OPTIONS_SELFCASTS               = "Nur eigene Zauber"
    HEALBOT_OPTIONS_HOTSHOWICON             = "Symbol anzeigen"
    HEALBOT_OPTIONS_ALLSPELLS               = "Alle Spr\195\188che"
    HEALBOT_OPTIONS_DOUBLEROW               = "zweizeilig"
    HEALBOT_OPTIONS_HOTBELOWBAR             = "unter Balken"
    HEALBOT_OPTIONS_OTHERSPELLS             = "andere Spr\195\188che"
    HEALBOT_WORD_MACROS                     = "Makros"
    HEALBOT_WORD_SELECT                     = "Ausw\195\164hlen"
    HEALBOT_WORD_CANCEL                     = "Abbrechen"
    HEALBOT_WORD_COMMANDS                   = "Kommandos"
    HEALBOT_OPTIONS_BARHEALTH3              = "als Gesundheit";
    HEALBOT_SORTBY_ROLE                     = "Rolle"
    HEALBOT_CHAT_TOPROLEERR                 = " Rolle in diesem Zusammenhang nicht g\195\188ltig - benutze 'TANK', 'DPS' oder 'HEALER'"
    HEALBOT_CHAT_NEWTOPROLE                 = "H\195\188chste obere Rolle ist jetzt "
    HEALBOT_CHAT_SUBSORTPLAYER1             = "Spieler wird in Untersortierung als erstes gesetzt"
    HEALBOT_CHAT_SUBSORTPLAYER2             = "Spieler wird in Untersortierung normal gesetzt"
    HEALBOT_OPTIONS_SHOWREADYCHECK          = "Bereitschaftscheck anzeigen";
    HEALBOT_OPTIONS_SUBSORTSELFFIRST        = "Selbst zuerst"
    HEALBOT_OPTION_AGGROPCTBAR              = "Bew. Balken"
    HEALBOT_OPTION_AGGROPCTTXT              = "Text anzeigen"
    HEALBOT_OPTION_AGGROPCTTRACK            = "Prozentual verfolgen" 
    HEALBOT_OPTIONS_ALERTAGGROLEVEL1        = "1 - hat hohe Bedrohung und tankt nichts"
    HEALBOT_OPTIONS_ALERTAGGROLEVEL2        = "2 - unsicher ob tankt, nicht die h\195\182chste Bedrohung am Gegner"
    HEALBOT_OPTIONS_ALERTAGGROLEVEL3        = "3 - tankt sicher mindestens einen Gegner"
    HEALBOT_OPTIONS_AGGROALERT              = "Balken Alarmstufe"
    HEALBOT_OPTIONS_TOOLTIPSHOWHOT          = "Aktiv verfolgte HoT Details anzeigen"
    HEALBOT_CHAT_SELFPETSON                 = "Eigenen Begleiter anschalten"
    HEALBOT_CHAT_SELFPETSOFF                = "Eigenen Begleiter ausschalten"
    HEALBOT_WORD_PRIORITY                   = "Priorit\195\164t"
    HEALBOT_VISIBLE_RANGE                   = "Innerhalb 100 Metern"
    HEALBOT_SPELL_RANGE                     = "In Zauberreichweite"
HEALBOT_WORD_RESET                      = "Zur\195\188cksetzen"
    HEALBOT_HBMENU                          = "HBmen\195\188"
    HEALBOT_ACTION_HBFOCUS                  = "Linksklick um Ziel als\nFokus zu setzen"
    HEALBOT_WORD_CLEAR                      = "L\195\182schen"
    HEALBOT_WORD_SET                        = "Setzen"
    HEALBOT_WORD_HBFOCUS                    = "HealBot Fokus"
    HEALBOT_WORD_OUTSIDE                    = "Au\195\159erhalb"
    HEALBOT_WORD_ALLZONE                    = "Alle Zonen"
    HEALBOT_OPTIONS_TAB_SORT                = "Sortieren"
HEALBOT_OPTIONS_TAB_HIDE                = "Verstecken"
HEALBOT_OPTIONS_TAB_ICONTEXT            = "Symboltext"
    HEALBOT_OPTIONS_TAB_TEXT                = "Balkentext"
    HEALBOT_OPTIONS_AGGRO3COL               = "Tankt\nsicher"
    HEALBOT_OPTIONS_AGGROFLASHFREQ          = "Aufblitz-Frequenz"
    HEALBOT_OPTIONS_AGGROFLASHALPHA         = "Aufblitz-Durchsichtigkeit"
    HEALBOT_OPTIONS_SHOWDURATIONFROM        = "Zeige Dauer ab"
    HEALBOT_OPTIONS_SHOWDURATIONWARN        = "Dauer Warnung ab"
    HEALBOT_CMD_RESETCUSTOMDEBUFFS          = "pers\195\182nliche Debuffs zur\195\188cksetzen"
HEALBOT_CMD_RESETSKINS                  = "Skins zur\195\188cksetzen"
    HEALBOT_CMD_CLEARBLACKLIST              = "L\195\182sche BlackList"
    HEALBOT_CMD_TOGGLEACCEPTSKINS           = "Umschalten Akzeptieren von Skins Anderer"
    HEALBOT_CMD_COPYSPELLS                  = "\195\156bernehme aktuelle Spr\195\188che f\195\188r alle Skillungen"
    HEALBOT_CMD_RESETSPELLS                 = "Spr\195\188che zur\195\188cksetzen"
    HEALBOT_CMD_RESETCURES                  = "Heilungen zur\195\188cksetzen"
    HEALBOT_CMD_RESETBUFFS                  = "Buffs zur\195\188cksetzen"
    HEALBOT_CMD_RESETBARS                   = "Balken Positionen zur\195\188cksetzen"
    HEALBOT_CMD_SUPPRESSSOUND               = "Umschalten der Tonunterdr\195\188ckung, wenn Auto Schmuck benutzt wird"
    HEALBOT_CMD_SUPPRESSERRORS              = "Umschalten der Fehlerunterdr\195\188ckung, wenn Auto Schmuck benutzt wird"
    HEALBOT_OPTIONS_COMMANDS                = "HealBot Kommandos"
    HEALBOT_WORD_RUN                        = "Ausf\195\188hren"
    HEALBOT_OPTIONS_MOUSEWHEEL              = "Aktiviere Men\195\188 auf Mausrad"
HEALBOT_OPTIONS_MOUSEUP                 = "Mausrad nach oben"
HEALBOT_OPTIONS_MOUSEDOWN               = "Mausrad nach unten"
    HEALBOT_CMD_DELCUSTOMDEBUFF10           = "L\195\182sche pers\195\182nliche Debuffs mit Priorit\195\164t 10"
    HEALBOT_ACCEPTSKINS                     = "Akzeptiere Skins von Anderen"
    HEALBOT_SUPPRESSSOUND                   = "Auto Schmuck: Unterdr\195\188cke Ton"
    HEALBOT_SUPPRESSERROR                   = "Auto Schmuck: Unterdr\195\188cke Fehler"
HEALBOT_OPTIONS_CRASHPROT               = "Crash Schutz"
    HEALBOT_CP_MACRO_LEN                    = "Makro Name muss zwischen 1 und 14 Zeichen lang sein"
    HEALBOT_CP_MACRO_BASE                   = "Grund-Makro Name"
    HEALBOT_CP_MACRO_SAVE                   = "Zuletzt gespeichert um: "
    HEALBOT_CP_STARTTIME                    = "Schutzdauer beim Einloggen"
    HEALBOT_WORD_RESERVED                   = "Reserviert"
HEALBOT_OPTIONS_COMBATPROT              = "Kampf Schutz"
    HEALBOT_COMBATPROT_PARTYNO              = "Anzahl der Balken f\195\188r Gruppe reserviert"
    HEALBOT_COMBATPROT_RAIDNO               = "Anzahl der Balken f\195\188r Raid reserviert"

    HEALBOT_WORD_HEALTH                     = "Gesundheit"
    HEALBOT_OPTIONS_DONT_SHOW               = "nicht zeigen"
    HEALBOT_OPTIONS_SAME_AS_HLTH_CURRENT    = "wie die jetzige Gesundheit"
    HEALBOT_OPTIONS_SAME_AS_HLTH_FUTURE     = "wie die zuk\195\188nftige Gesundheit"
    HEALBOT_OPTIONS_FUTURE_HLTH             = "zuk\195\188nftige Gesundheit"
    HEALBOT_SKIN_HEALTHBARCOL_TEXT          = "Lebensbalken Farbe";
HEALBOT_SKIN_HEALTHBACKCOL_TEXT         = "Hintergrundbalken";
    HEALBOT_SKIN_INCHEALBARCOL_TEXT         = "Ankomm. Heilung Farbe";
    HEALBOT_OPTIONS_ALWAYS_SHOW_TARGET      = "Ziel: Immer anzeigen"
    HEALBOT_OPTIONS_ALWAYS_SHOW_FOCUS       = "Fokus: Immer anzeigen"
HEALBOT_OPTIONS_GROUP_PETS_BY_FIVE      = "Begleiter: F\195\188nfergruppen"
    HEALBOT_OPTIONS_USEGAMETOOLTIP          = "Benutze Spiel Tooltip"
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER        = "Kraft Z\195\164hler anzeigen"
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER_PALA   = "Heilige Kraft anzeigen"
HEALBOT_OPTIONS_SHOWPOWERCOUNTER_MONK   = "Chi Kraft anzeigen"
HEALBOT_OPTIONS_CUSTOMDEBUFF_REVDUR     = "Dauer umkehren"
HEALBOT_OPTIONS_DISABLEHEALBOTSOLO      = "Nur wenn allein"
HEALBOT_OPTIONS_CUSTOM_ALLDISEASE       = "Alle Krankheiten"
HEALBOT_OPTIONS_CUSTOM_ALLMAGIC         = "Alle Magie"
HEALBOT_OPTIONS_CUSTOM_ALLCURSE         = "Alle Fl195\188che"
HEALBOT_OPTIONS_CUSTOM_ALLPOISON        = "Alle Gifte"
HEALBOT_OPTIONS_CUSTOM_CASTBY           = "verzaubert von"

HEALBOT_BLIZZARD_MENU                   = "Blizzard Men195\188"
HEALBOT_HB_MENU                         = "Healbot Men195\188"
HEALBOT_FOLLOW                          = "Folgen"
HEALBOT_TRADE                           = "Handel"
HEALBOT_PROMOTE_RA                      = "zum Raid Assistent bef\195\182rdern"
HEALBOT_DEMOTE_RA                       = "zum Raid Assistent zur\195\188ckstufen"
HEALBOT_RESET_BAR                       = "Balken zur\195\188ckstellen"
HEALBOT_HIDE_BARS                       = "Verstecke Balken die mehr als 100m weit weg sind"
HEALBOT_RANDOMMOUNT                     = "Zuf\195\164lliges Reittier"
HEALBOT_RANDOMGOUNDMOUNT                = "Zuf\195\164lliges Boden Reittier"
HEALBOT_RANDOMPET                       = "Zuf\195\164lliger Begleiter"

HEALBOT_OPTIONS_LOWMANAINDICATOR        = "Niedrige Mana Indikator"
HEALBOT_OPTIONS_LOWMANAINDICATOR1       = "Nicht anzeigen"

HEALBOT_OPTION_IGNORE_AURA_RESTED       = "Ignoriere Aura-events beim Ausruhen"

HEALBOT_WORD_ENABLE                     = "Aktivieren"
HEALBOT_WORD_DISABLE                    = "Deaktivieren"

HEALBOT_OPTIONS_MYCLASS                 = "Meine Klasse"

HEALBOT_OPTIONS_CONTENT_ABOUT           = "        \195\156ber Healbot"
HEALBOT_OPTIONS_CONTENT_GENERAL         = "        " .. HEALBOT_OPTIONS_TAB_GENERAL
HEALBOT_OPTIONS_CONTENT_SPELLS          = "        " .. HEALBOT_OPTIONS_TAB_SPELLS
HEALBOT_OPTIONS_CONTENT_SKINS           = "        " .. HEALBOT_OPTIONS_TAB_SKIN
HEALBOT_OPTIONS_CONTENT_CURE            = "        " .. HEALBOT_OPTIONS_TAB_CDC
HEALBOT_OPTIONS_CONTENT_BUFFS           = "        " .. HEALBOT_OPTIONS_TAB_BUFFS
HEALBOT_OPTIONS_CONTENT_TIPS            = "        " .. HEALBOT_OPTIONS_TAB_TIPS
HEALBOT_OPTIONS_CONTENT_MOUSEWHEEL      = "        Mausrad"
HEALBOT_OPTIONS_CONTENT_USAGE           = "        Benutzung"
HEALBOT_OPTIONS_REFRESH                 = "Auffrischen"

HEALBOT_CUSTOM_CATEGORY                 = "Kategorie"
HEALBOT_CUSTOM_CAT_CUSTOM               = "Pers\195\182nlich"

HEALBOT_CUSTOM_CASTBY_EVERYONE          = "Alle"
HEALBOT_CUSTOM_CASTBY_ENEMY             = "Feind"
HEALBOT_CUSTOM_CASTBY_FRIEND            = "Freund"

HEALBOT_ABOUT_CATH                     = "Kategorie:"
HEALBOT_ABOUT_LOCALH                   = "Localisationen:"
HEALBOT_ABOUT_FAQ_QUESTION             = "Frage"
HEALBOT_ABOUT_FAQ_ANSWER               = "Antwort"

HEALBOT_ABOUT_FAQ_QUESTIONS = {   [1]   = "Buffs - Alle Balken sind weiss, was ist passiert",
                                  [2]   = "Zaubern - manchmal ist der Maus Kursor blau und ich kann nichts machen",
                                  [3]   = "Makros - Hast du irgendwelche Makro Beispiele",
                                  [4]   = "Makros - Hast du irgendwelche Zauberspruch Beispiele",
                                  [5]   = "Maus - Wie benutze ich meine mouseover Makros mit meinem Mausrad",
                                  [6]   = "Optionen - K\195\182nnen Balken per Gruppe sortiert werden, also zum Beispiel 2 Gruppen pro Reihe",
                                  [7]   = "Optionen - Kann ich alle Balken verstecken und nur die anzeigen, die einen debuff Entfernung brauchen",
                                  [8]   = "Optionen - Kann ich die ankommenden Heilungen verstecken",
                                  [9]   = "Optionen - Healbot speichert meine Optionen nicht wenn ich ein- oder auslogge",
                                  [10]   = "Optionen - Wie stelle ich den immer aktiviert Zustand ein",
                                  [11]  = "Optionen - Wie kann ich Healbot automatisch ausschalten",
                                  [12]  = "Optionen - Wie bekomme ich es hin die Balken in eine andere Richtung beim Heilen wachsen zu lassen",
                                  [13]  = "Optionen - Wie stelle ich 'Meine Ziele' ein",
                                  [14]  = "Optionen - Wie stelle ich 'Pers\195\182nliche bzw private Tanks' ein'",
                                  [15]  = "Optionen - Kreiert Healbot einen Balken f\195\188r ein NPC",
                                  [16]  = "Reichweite - Ich kann nicht sehen wenn Leute au\195\159er Reichweite sind, wie behebe ich das",
                                  [17]  = "Spr\195\188che - Healbot zaubert einen anderen Spruch als ich eingestellt habe",
                                  [18]  = "Spr\195\188che - Ich kann keine Spr\195\188che mehr auf unverletzte Ziele zaubern",
                              }

HEALBOT_ABOUT_FAQ_SPELLS_ANSWER01       = "Das kommt durch eine Einstellung in der Spr195\188che tab. \n" ..
                                          "Versuche das Folgende zu \195\164ndern und teste: \n\n" ..
                                          "     1: Im Spr\195\188che tab: Schalte Immer Aktiviert Benutzen ein \n" ..
                                          "     2: Im Spr\195\188che tab: SmartCast ausschalten \n\n" ..
                                          "Notiz: H\195\164ufig wollen die meisten Benutzer \n"..
                                          "          den SmartCast wiedereinschalten. \n\n" ..
                                          "Notiz: H\195\164ufig wollen erfahrene Benutzer \n" ..
                                          "          den Immer Aktiviert Benutzen Zustand ausschalten \n" ..
                                          "          und stelle die Spr\195\188che f\195\188r deaktivierte Balken ein"
                                          
HEALBOT_ABOUT_FAQ_ANSWERS = {     [1]   = "Du \195\188berwachst fehlende Buffs. \n\n" .. 
                                          "Es kann in der Buffs tab ausgeschaltet werden. \n" ..
                                          "Alternativ kannst du auf den Balken klicken und du buffst automatisch.",
                                  [2]   = "Es ist eine Blizzard Funktionalit\195\164t, nicht von Healbot. \n\n" .. 
                                          "Wenn du die Standard Blizzard Rahmen benutzt, \n" ..
                                          "versuche einen Spruch zu zaubern, der noch abklingt. \n" ..
                                          "Sieh wie der Mauskursor blau wird. \n\n" ..
                                          "Notiz: Es kann nichts gemacht werden w\195\164hrend du \n" ..
                                          "in einem Kampf verwickelt bist, seit WoW 2.0 hat Blizzard den UI \n" ..
                                          "w\195\164hrend des Kampfes festgesetzt, und stoppt somit alle Addons \n" ..
                                          "Spr\195\188che oder Ziele zu wechseln, die schon vorher gestartet wurden. \n\n" ..
                                          "Es k\195\182nnte helfen die Abklingzeit in den tooltips zu \195\188berwachen.",
                                  [3]   = "Ja \n\n"..
                                          "Paladin Hand der Erl\195\182sung Abklingzeit Makro Beispiel: \n\n" ..
                                          "    #show Hand der Erl\195\182sung \n" ..
                                          '    /script local n=UnitName("hbtarget"); ' .. "\n" ..
                                          '    if GetSpellCooldown("Hand der Erl\195\182sung")==0 then ' .. " \n" ..
                                          '        SendChatMessage("Hand der Erl\195\182sung on "..n,"YELL") ' .. "\n" ..
                                          '        SendChatMessage("Hand der Erl\195\182sung!","WHISPER",nil,n) ' .. "\n" ..
                                          "    end; \n" ..
                                          "    /cast [@hbtarget] Hand der Erl\195\182sung",
                                  [4]   = "Ja \n\n"..
                                          "Priester Blitzheilung, Beispiel benutzt beide Schmuckst\195\188cke: \n\n" ..
                                          "    #show Blitzheilung \n" ..
                                          "    /script UIErrorsFrame:Hide() \n" ..
                                          "    /console Sound_EnableSFX 0 \n" ..
                                          "    /use 13 \n" ..
                                          "    /use 14 \n" ..
                                          "    /console Sound_EnableSFX 1 \n" ..
                                          "    /cast [@hbtarget] Blitzheilung \n" ..
                                          "    /script UIErrorsFrame:Clear(); UIErrorsFrame:Show()",
                                  [5]   = "1: Im Mausrad tab: schalte Aktiviere Men\195\188 auf Mausrad aus. \n" ..
                                          "2: Verbinde deine Makros mit Blizzard's Tastaturbelegung und mit [@mouseover] \n\n\n" ..
                                          "Makrobeispiel: \n\n" ..
                                          "    #showtooltip Blitzheilung \n" ..
                                          "    /cast [@mouseover] Blitzheilung \n",
                                  [6]   = "Ja \n\n\n"..
                                          "Mit \195\156berschriften: \n" ..
                                          "     1: Im Skins>\195\156berschriften tab, schalte \195\156berschriften Anzeigen an \n" ..
                                          "     2: Im Skins>Balken tab, stelle Anzahl der Gruppen pro Spalte ein \n\n" ..
                                          "Ohne \195\156berschriften: \n" ..
                                          "     1: Im Skins>Balken tab, schalte Benutze Gruppen pro Spalte an \n" ..
                                          "     2: Im Skins>Balken tab, schalte Anzahl der Gruppen pro Spalte an",
                                  [7]   = "Ja \n\n"..
                                          "1: Im Skins>Heilung>Alert tab, schalte Alert Level auf 0 \n" ..
                                          "2: Im Skins>Aggro tab, stelle Aggro \195\156berwachung aus \n" .. 
                                          "3: Im Skins>Balken tab, stelle Deaktivierte Opazit\195\164t auf 0 \n" ..
                                          "4: Im Skins>Balken tab, stelle Hintergrund Opazit\195\164t auf 0 \n" ..
                                          "5: Im Skins>Balkentext tab, klicke auf den Deaktiviert Balken \n" ..
                                          "     und setze die Deaktivierte Textopazit\195\164t auf 0 \n" ..
                                          "6: Im Skins>Allgemein tab, klicke auf den Hintergrund Balken \n" ..
                                          "     und setze die Hintergrundsopazit\195\164t auf 0 \n" ..
                                          "7: On the Cure tab, schalte Debuff \195\156berwachung ein",
                                  [8]   = "Ja \n\n"..
                                          "1: Im Skins>Balken tab, setze Ankommende Heilungen auf Nicht Anzeigen \n" ..
                                          "2: Im Skins>Balkenext tab, \n" ..
                                          "          setze Leben auf Balken Anzeigen auf Keine Ankommende Heilungen",
                                  [9]   = "Dieses Problem ist present seit einer \195\132nderung in WoW 3.2, \n" ..
                                          "es kann Auswirkungen auf Charaktere mit seltsamen Buchstaben haben \n\n" ..
                                          "Falls du Vista oder Win7 benutzt, versuche dies: \n"..
                                          "     change system locale to English (for non-unicode programs) \n" ..
                                          "     in Control Panel > Region and Language > Administrative Tab",

                                  [10]   = "Im Spr\195\188che tab schalte Immer Aktiviert Benutzen an \n\n" ..
                                          "Mancheiner m\195\182chte auch den Alert Level auf 100 setzen \n" ..
                                          "Das kann man im Skins>Heilung>Alert tab machen",
                                  [11]  = "F\195\188r einen Charakter deaktivieren: \n\n" ..
                                          "     1: \195\150ffne den Allgemein tab \n" ..
                                          "     2: Schalte die Deaktiviert Option an \n\n\n" ..
                                          "Deaktiviere wenn allein: \n\n" ..
                                          "     1: \195\150ffne den Allgemein tab \n" ..
                                          "     2: Rechts von der Deaktiviert Option, w\195\164hle Nur wenn allein \n" ..
                                          "     3: Schalte die Deaktiviert Option an",
                                  [12]  = "\195\132ndere die Balken Anker Einstellungen im Skins>Allgemein tab  \n\n" ..
                                          "     Oben Rechts:        die Balken werden nach unten und nach links wachsen \n" ..
                                          "     Oben Links:          die Balken werden nach unten und nach rechts wachsen \n" ..
                                          "     Unten Rechts:  die Balken werden nach oben und nach links wachsen \n" ..
                                          "     Unten Links:     die Balken werden nach oben und nach rechts wachsen",
                                  [13]  = "Meine Ziele erlaubt es dir eine Ziel-Liste zu kreieren die du \n" ..
                                          "getrennt von anderen gruppieren willst, \195\164hnlich wie in der MainTank Gruppe \n\n" ..
                                          "Die folgenden Optionen gibt es f195\188r das \n" .. 
                                          "hHinzuf195\188gen/Entfernen von Leuten zur/von der Meine Ziele Gruppe \n\n" ..
                                          "     - Shift+Strg+Alt+Rechts Klick auf den Balken r \n" ..
                                          '     - Benutze das Healbot Men195\188, enter "hbmenu" on the spells tab ' .. "\n" ..
                                          "     - Benutze das Mausrad, set on the Mouse Wheel tab",
                                  [14]  = "Private Tanks k\195\182nnen zu den Main Tanks hinzugef195\188gt werden, \n" ..
                                          "die Privaten Tanks sind nur in deinem Healbot zu sehen \n" ..
                                          "und es hat keinen Effekt auf andere Spieler oder Addons \n\n" ..
                                          "Die folgenden Optionen gibt es f195\188r das \n" ..
                                          "hHinzuf195\188gen/Entfernen von Leuten zur/von der Tanks Liste \n\n" ..
                                          '     - Benutze das Healbot Men195\188, enter "hbmenu" on the spells tab ' .. "\n" ..
                                          "     - Benutze das Mausrad, set on the Mouse Wheel tab",
                                  
                                  [15]  = "Ja \n\n"..
                                          "     1: Im Skins>Heilung tab, schalte Fokus ein \n" ..
                                          "     2: stelle deinen Fokus auf ein NPC (oder Spieler der nicht in der Raid/Gruppe ist) \n" ..
                                          "          Healbot wird einen Balken in deiner Meine Ziele Liste kreieren \n\n" ..
                                          "Notiz: Falls du in einer Kampfsituation bist, in der du in- und aus'zone'st w\195\164hrend \n" ..
                                          "          due in einem Kampf verwickelt bist und deinen Fokus zur\195\188ckstellen musst \n" ..
                                          "          Im Skins>Heilung tab setze Fokus auf: Immer Anzeigen \n" ..
                                          "          Das wird den Balken auch während des Kampfes aktiviert halten. \n\n" ..
                                          "Notiz: Das HealBot Men\195\188 hat die Option 'HealBot Focus einstellen' \n" ..
                                          "          Das kann die Fokus Einstellung auf NPCs einfach machen und \n" ..
                                          "          dient als eine Erinnerung den Fokus zu setzen. \n\n" ..
                                          "          Enter 'hbmenu' on the spells tab to use HealBot Menu \n" ..
                                          "          or use the Mouse Wheel tab to and set HealBot Menu",
                                  [16]  = "1:  Im Skins>Balken tab, passe die Deaktivierte Balkenopazit\195\164t an \n" ..
                                          "2:  Im Skins>Balkentext tab, passe die Deaktivierte Textopazit\195\164t an \n" ..
                                          "       Um das zu tun, klicke auf den Balken der 'Deaktiviert' heisst. \n\n" ..
                                          "Manche wollen auch den Alert Level auf 100 stellen \n" ..
                                          "Das kann man im Skins>Heilung>Alert tab machen",
                                  [17]  = "Eigentlich zaubert Healbot nur Spr\195\188che, die du so eingestellt hast. \n\n" .. HEALBOT_ABOUT_FAQ_SPELLS_ANSWER01,
                                  [18]  = HEALBOT_ABOUT_FAQ_SPELLS_ANSWER01,
                              }

HEALBOT_OPTIONS_SKINAUTHOR              = "Skin Autor:"
HEALBOT_OPTIONS_AVOIDBLUECURSOR         = "Vermeide\nBlauen Kursor"
HEALBOT_PLAYER_OF_REALM                 = "von"
    
    HEALBOT_OPTIONS_LANG                    = "Sprache"
    HEALBOT_OPTIONS_LANG_ZHCN               = "Chinesisch (zhCN)"
    HEALBOT_OPTIONS_LANG_ENUK               = "Englisch (enUK)"
    HEALBOT_OPTIONS_LANG_ENUS               = "Englisch (enUS)"
    HEALBOT_OPTIONS_LANG_FRFR               = "Franz\195\182sisch (frFR)"
    HEALBOT_OPTIONS_LANG_DEDE               = "Deutsch (deDE)"
    HEALBOT_OPTIONS_LANG_GRGR               = "Greek (grGR)"
    HEALBOT_OPTIONS_LANG_HUHU               = "Ungarisch (huHU)"
    HEALBOT_OPTIONS_LANG_KRKR               = "Koreanisch (krKR)"
    HEALBOT_OPTIONS_LANG_ITIT               = "Italienisch (itIT)"
    HEALBOT_OPTIONS_LANG_PTBR               = "Portugiesisch (ptBR)"
    HEALBOT_OPTIONS_LANG_RURU               = "Russisch (ruRU)"
    HEALBOT_OPTIONS_LANG_ESES               = "Spanisch (esES)"
    HEALBOT_OPTIONS_LANG_TWTW               = "Taiwanesisch (twTW)"
    
    HEALBOT_OPTIONS_LANG_ADDON_FAIL1        = "Laden des Addons f\195\188r Lokalisation ist fehlgeschlagen"
    HEALBOT_OPTIONS_LANG_ADDON_FAIL2        = "Grund des Fehlschlags ist:"
    HEALBOT_OPTIONS_LANG_ADDON_FAIL3        = "In der momentanen Version ist es die einzige Warnung f195\188r"
    
    HEALBOT_OPTIONS_ADDON_FAIL              = "Laden des Healbots Addon fehlgeschlagen"
    
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
    
    HEALBOT_SKIN_ABSORBCOL_TEXT             = "Absorb Effekte";
    HEALBOT_OPTIONS_BARALPHAABSORB          = "Absorb Effekte Opazit\195\164t";
    HEALBOT_OPTIONS_FRAME                   = "Rahmen"
    HEALBOT_OPTIONS_CONTENT_SKINS_FRAMES    = "    " .. "Rahmen"
    HEALBOT_OPTIONS_FRAMESOPTTEXT           = "Rahmen Optionen"
    HEALBOT_OPTIONS_SETTOOLTIP_POSITION     = "Stelle Tooltip Position ein"
    HEALBOT_OPTIONS_FRAME_ALIAS             = "Rahmen Titel"
    HEALBOT_OPTIONS_FRAME_ALIAS_SHOW        = "Titel anzeigen"
    HEALBOT_OPTIONS_GROW_DIRECTION          = "Wachstumsrichtung"
    HEALBOT_OPTIONS_BARSORIENTATION         = "Balkenorientierung"
    HEALBOT_OPTIONS_GROW_HORIZONTAL         = "Horizontal"
    HEALBOT_OPTIONS_GROW_VERTICAL           = "Vertikal"
    HEALBOT_OPTIONS_FONT_OFFSET             = "Schriftart Abstand"
    HEALBOT_OPTIONS_SET_FRAME_HEALGROUPS    = "Heilgruppen festlegen"
    HEALBOT_OPTION_EXCLUDEMOUNT_ON          = "Nun Reittier ausschlie\195\159en"
    HEALBOT_OPTION_EXCLUDEMOUNT_OFF         = "Nicht mehr Reittier ausschlie\195\159en"
    HEALBOT_CMD_TOGGLEEXCLUDEMOUNT          = "Toggel Reittier ausschlie\195\159en"
    HEALBOT_OPTIONS_HIDEMINIBOSSFRAMES      = "Verstecke Mini Boss Rahmen";
    HEALBOT_OPTIONS_HIDERAIDFRAMES          = "Verstecke Raid Rahmen";
    HEALBOT_OPTIONS_CONTENT_SKINS_HEALGROUP = "        " .. "Heilgruppen"
    HEALBOT_OPTIONS_CONTENT_SKINS_BARCOLOUR = "        " .. "Balkenfarben";
    HEALBOT_OPTIONS_SET_ALL_FRAMES          = "\195\156bertrage tab Einstellungen auf alle Rahmen"
    HEALBOT_SHARE_SCREENSHOT                = "ScreenShot gemacht"
    HEALBOT_SHARE_INSTRUCTION               = "Gehe zur Webseite f\195\188r Instruktionen wie man Skins teilt "..HEALBOT_ABOUT_URL
    HEALBOT_ENEMY_USE_FRAME                 = "Rahmen Benutzen"
    HEALBOT_ENEMY_INCLUDE_SELF              = "Mein Ziel miteinbeziehen"
    HEALBOT_ENEMY_INCLUDE_TANKS             = "Tanks Ziele miteinbeziehen"
    HEALBOT_OPTIONS_ENEMY_OPT               = "Feind Optionen";
    HEALBOT_OPTIONS_SHARE_OPT               = "Teilen Optionen";
    HEALBOT_OPTIONS_CONTENT_SKINS_SHARE     = "    " .. "Teilen"
    HEALBOT_OPTIONS_CONTENT_SKINS_ENEMY     = "    " .. "Feind"
    HEALBOT_OPTIONS_BUTTONLOADSKIN          = "Skin Laden"
    HEALBOT_ENEMY_NO_TARGET                 = "Kein Ziel"
    HEALBOT_OPTIONS_ENEMYBARS               = "Feind Balken jederzeit";
    HEALBOT_OPTIONS_HARMFUL_SPELLS          = "Sch\195\164dliche Spr195\188che"
    HEALBOT_ENEMY_INCLUDE_MYTARGETS         = "Mein Ziel's Ziel miteinbeziehen"
    HEALBOT_ENEMY_NUMBER_BOSSES             = "Anzahl der Bosse"
    HEALBOT_ENEMY_HIDE_OUTOFCOMBAT          = "Verstecke Balken au\195\159erhalb eines Kampfes"
    HEALBOT_ENEMY_EXISTS_SHOW               = "Entering combat only".."\n".."show when exists"
    HEALBOT_ENEMY_EXISTS_SHOW_PTARGETS      = "Spieler Ziel-Balken"
    HEALBOT_ENEMY_EXISTS_SHOW_BOSSES        = "Boss Balken"
    HEALBOT_OPTIONS_TARGET_ONLY_FRIEND      = "Ziel: Nur Freundliche anzeigen"
    HEALBOT_OPTIONS_FOCUS_ONLY_FRIEND       = "Fokus: Nur Freundliche anzeigen"
    HEALBOT_OPTIONS_PROFILE                 = "Profil"
    HEALBOT_OPTIONS_PROFILE_CHARACTER       = "Charakter"
    HEALBOT_OPTIONS_PROFILE_CLASS           = "Klasse"
    HEALBOT_OPTIONS_INCOMBATALERTLEVEL      = "Alarmstufe - in einer Kampfentwicklung";
    HEALBOT_OPTIONS_OUTCOMBATALERTLEVEL     = "Alarmstufe - ausserhalb eines Kampfes";
    HEALBOT_OPTION_NUMENEMYS                = "Nummer der Feinde"
    HEALBOT_OPTIONS_SHOWDIRECTION           = "Richtung der au\195\159erhalb der Reichweite anzeigen"
    HEALBOT_OPTIONS_SHOWDIRECTIONMOUSE      = "Nur beim Mausüberfahren"
    HEALBOT_LDB_LEFT_TOOLTIP                = "|cffffff00 Linksklick:|r HealBot Optionenpanel feststellen";
    HEALBOT_LDB_SHIFTLEFT_TOOLTIP           = "|cffffff00 Shift-Linksklick:|r Durch HealBot Skins gehen";
    HEALBOT_LDB_RIGHT_TOOLTIP               = "|cffffff00 Rechtsklick:|r HealBot zurücksetzen";
    HEALBOT_LDB_SHIFTRIGHT_TOOLTIP          = "|cffffff00 Shift-Rechtsklick:|r HealBot An/Aus toggeln";
    HEALBOT_WORD_PETBATTLE                  = "Haustierkampf"
    HEALBOT_ENEMY_INCLUDE_ARENA             = "Arena Gegner anzeigen"
    HEALBOT_ENEMY_INCLUDE_ARENAPETS         = "Begleiter anzeigen"
    HEALBOT_ENEMY_EXISTS_SHOW_ARENA         = "Arena Gegner Balken"
end
