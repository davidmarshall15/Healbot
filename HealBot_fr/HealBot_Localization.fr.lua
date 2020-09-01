-- French translator required

------------
-- FRENCH --
------------
--
-- à = \195\160
-- â = \195\162
-- ç = \195\167
-- è = \195\168
-- é = \195\169
-- ê = \195\170
-- î = \195\174
-- ï = \195\175
-- ô = \195\180
-- û = \195\187
-- À = \195\128
-- È = \195\136
-- É = \195\137
-- Ê = \195\138
-- espace avant ':' (?) = \194\160



function HealBot_Lang_frFR()

-----------------
-- Translation --
-----------------
-- Class
    HEALBOT_DRUID       = "Druide";
    HEALBOT_HUNTER      = "Chasseur";
    HEALBOT_MAGE        = "Mage";
    HEALBOT_PALADIN     = "Paladin";
    HEALBOT_PRIEST      = "Pr\195\170tre";
    HEALBOT_ROGUE       = "Voleur";
    HEALBOT_SHAMAN      = "Chaman";
    HEALBOT_WARLOCK     = "D\195\169moniste";
    HEALBOT_WARRIOR     = "Guerrier";
    HEALBOT_DEATHKNIGHT = "Chevalier de la mort";
    HEALBOT_MONK        = "Moine";

    HEALBOT_DISEASE            = "Maladie";
    HEALBOT_MAGIC              = "Magie";
    HEALBOT_CURSE              = "Mal\195\169diction";
    HEALBOT_POISON             = "Poison";

    HB_TOOLTIP_OFFLINE         = "Hors ligne";
    HB_OFFLINE                 = "hors ligne"; -- has gone offline msg
    HB_ONLINE                  = "en ligne"; -- has come online msg

    HEALBOT_HEALBOT            = "HealBot";
    HEALBOT_ADDON              = HEALBOT_HEALBOT .. " " .. HEALBOT_VERSION;
    HEALBOT_LOADED             = " charg\195\169.";

HEALBOT_ACTION_OPTIONS     = "Options";

    HEALBOT_OPTIONS_TITLE         = HEALBOT_ADDON;
    HEALBOT_OPTIONS_DEFAULTS      = "D\195\169faut";
    HEALBOT_OPTIONS_CLOSE         = "Fermer";
HEALBOT_OPTIONS_HARDRESET     = "ReloadUI";
HEALBOT_OPTIONS_SOFTRESET     = "ResetHB";
    HEALBOT_OPTIONS_TAB_GENERAL   = "G\195\169n\195\169ral";
    HEALBOT_OPTIONS_TAB_SPELLS    = "Sorts";
    HEALBOT_OPTIONS_TAB_HEALING   = "Soins";
    HEALBOT_OPTIONS_TAB_CDC       = "Gu\195\169rison";
    HEALBOT_OPTIONS_TAB_SKIN      = "Skin";
    HEALBOT_OPTIONS_TAB_TIPS      = "Bulle d\'information";
    HEALBOT_OPTIONS_TAB_BUFFS     = "Buffs"

    HEALBOT_OPTIONS_BARALPHA      = "Opacit\195\169 vie";
    HEALBOT_OPTIONS_BARALPHAINHEAL= "Opacit\195\169 Sorts entrants";
    HEALBOT_OPTIONS_BARALPHABACK  = "Opacit\195\169 arri\195\168re-plan";
    HEALBOT_OPTIONS_BARALPHAEOR   = "Opacit\195\169 des joueurs hors d\'atteinte";
    HEALBOT_OPTIONS_ACTIONLOCKED  = "Verrouiller la position";
    HEALBOT_OPTIONS_AUTOSHOW      = "Fermer auto.";
    HEALBOT_OPTIONS_PANELSOUNDS   = "Son \195\160 l\'ouverture";
    HEALBOT_OPTIONS_HIDEOPTIONS   = "Enlever 'Options' du cadre";
    HEALBOT_OPTIONS_PROTECTPVP    = "Eviter le passage en JcJ";
    HEALBOT_OPTIONS_HEAL_CHATOPT  = "Options de chat";

    HEALBOT_OPTIONS_FRAMESCALE    = "Echelle du cadre"
    HEALBOT_OPTIONS_SKINTEXT      = "Skin"
    HEALBOT_SKINS_STD             = "Standard"
    HEALBOT_OPTIONS_SKINTEXTURE   = "Texture"
    HEALBOT_OPTIONS_SKINHEIGHT    = "Hauteur"
    HEALBOT_OPTIONS_SKINWIDTH     = "Largeur"
    HEALBOT_OPTIONS_SKINNUMCOLS   = "Nb de colonnes"
    HEALBOT_OPTIONS_SKINNUMHCOLS  = "Nb d\'en-t\195\170tes par col."
    HEALBOT_OPTIONS_SKINBRSPACE   = "Espacement rang\195\169es"
    HEALBOT_OPTIONS_SKINBCSPACE   = "Espacement col."
    HEALBOT_OPTIONS_EXTRASORT     = "Trier les barres de raid par"
    HEALBOT_SORTBY_NAME           = "Nom"
    HEALBOT_SORTBY_CLASS          = "Classe"
    HEALBOT_SORTBY_GROUP          = "Groupe"
    HEALBOT_SORTBY_MAXHEALTH      = "Vie max."
    HEALBOT_OPTIONS_NEWDEBUFFTEXT = "Nveau d\195\169buff"
    HEALBOT_OPTIONS_DELSKIN       = "Supprimer"
    HEALBOT_OPTIONS_NEWSKINTEXT   = "Nveau nom"
    HEALBOT_OPTIONS_SAVESKIN      = "Sauver"
    HEALBOT_OPTIONS_SKINBARS      = "Options des barres"
    HEALBOT_SKIN_ENTEXT           = "Activ\195\169"
    HEALBOT_SKIN_DISTEXT          = "Hors combat"
    HEALBOT_SKIN_DEBTEXT          = "D\195\169buff"
    HEALBOT_SKIN_BACKTEXT         = "Arri\195\168re plan"
    HEALBOT_SKIN_BORDERTEXT       = "Bordure"
    HEALBOT_OPTIONS_SKINFONT      = "Police"
    HEALBOT_OPTIONS_SKINFHEIGHT   = "Taille des caract\195\168res"
    HEALBOT_OPTIONS_SKINFOUTLINE  = "Contour de police"
    HEALBOT_OPTIONS_BARALPHADIS   = "Opacit\195\169 Hors combat"
    HEALBOT_OPTIONS_SHOWHEADERS   = "Afficher les en-t\195\170tes"

    HEALBOT_OPTIONS_ITEMS         = "Objets";

    HEALBOT_OPTIONS_COMBOCLASS    = "Combinaison de touche pour";
    HEALBOT_OPTIONS_CLICK         = "Clic";
    HEALBOT_OPTIONS_SHIFT         = "Maj";
    HEALBOT_OPTIONS_CTRL          = "Ctrl";
    HEALBOT_OPTIONS_ENABLEHEALTHY = "Tjrs util. cfg. \'en combat\'";

    HEALBOT_OPTIONS_CASTNOTIFY1         = "Pas de messages";
    HEALBOT_OPTIONS_CASTNOTIFY2         = "Avertir soi-m\195\170me";
    HEALBOT_OPTIONS_CASTNOTIFY3         = "Avertir la cible";
    HEALBOT_OPTIONS_CASTNOTIFY4         = "Avertir le groupe";
    HEALBOT_OPTIONS_CASTNOTIFY5         = "Avertir le raid";
    HEALBOT_OPTIONS_CASTNOTIFY6         = "Sur canal";
    HEALBOT_OPTIONS_CASTNOTIFYRESONLY   = "Avertir uniquement de la r\195\169surrection";

    HEALBOT_OPTIONS_CDCBARS             = "Couleur";
    HEALBOT_OPTIONS_CDCSHOWHBARS        = "Sur la barre de vie";
    HEALBOT_OPTIONS_CDCSHOWABARS        = "Sur la barre d\'aggro";
    HEALBOT_OPTIONS_CDCWARNINGS         = "Alertes d\195\169buffs";
    HEALBOT_OPTIONS_SHOWDEBUFFICON      = "Afficher les d\195\169buffs";
    HEALBOT_OPTIONS_SHOWDEBUFFWARNING   = "Afficher une alerte de d\195\169buff";
    HEALBOT_OPTIONS_SOUNDDEBUFFWARNING  = "Son pour les d\195\169buffs";
    HEALBOT_OPTIONS_SOUND               = "Son"

    HEALBOT_OPTIONS_HEAL_BUTTONS    = "Barres de soins"
    HEALBOT_OPTIONS_SELFHEALS       = "soi-m\195\170me"
    HEALBOT_OPTIONS_PETHEALS        = "Familiers"
    HEALBOT_OPTIONS_GROUPHEALS      = "Groupe";
    HEALBOT_OPTIONS_TANKHEALS       = "Tank principal";
    HEALBOT_OPTIONS_MAINASSIST      = "Assist principal";
    HEALBOT_OPTIONS_PRIVATETANKS    = "Main Tanks perso.";
    HEALBOT_OPTIONS_TARGETHEALS     = "Cibles";
    HEALBOT_OPTIONS_EMERGENCYHEALS  = "Raid";
    HEALBOT_OPTIONS_ALERTLEVEL      = "Niveau d'alerte";
    HEALBOT_OPTIONS_EMERGFILTER     = "Barre pour";
    HEALBOT_OPTIONS_EMERGFCLASS     = "Config. classes pour";
    HEALBOT_OPTIONS_COMBOBUTTON     = "Bouton";
    HEALBOT_OPTIONS_BUTTONLEFT      = "Gauche";
    HEALBOT_OPTIONS_BUTTONMIDDLE    = "Milieu";
    HEALBOT_OPTIONS_BUTTONRIGHT     = "Droite";
    HEALBOT_OPTIONS_BUTTON4         = "Bouton4";
    HEALBOT_OPTIONS_BUTTON5         = "Bouton5";
    HEALBOT_OPTIONS_BUTTON6         = "Bouton6";
    HEALBOT_OPTIONS_BUTTON7         = "Bouton7";
    HEALBOT_OPTIONS_BUTTON8         = "Bouton8";
    HEALBOT_OPTIONS_BUTTON9         = "Bouton9";
    HEALBOT_OPTIONS_BUTTON10        = "Bouton10";
    HEALBOT_OPTIONS_BUTTON11        = "Bouton11";
    HEALBOT_OPTIONS_BUTTON12        = "Bouton12";
    HEALBOT_OPTIONS_BUTTON13        = "Bouton13";
    HEALBOT_OPTIONS_BUTTON14        = "Bouton14";
    HEALBOT_OPTIONS_BUTTON15        = "Bouton15";

    HEALBOT_CLASSES_ALL     = "Toutes les classes";
    HEALBOT_CLASSES_MELEE   = "Corps \195\160 corps";
    HEALBOT_CLASSES_RANGES  = "A distance";
    HEALBOT_CLASSES_HEALERS = "Soigneurs";
    HEALBOT_CLASSES_CUSTOM  = "Personnalis\195\169";

    HEALBOT_OPTIONS_SHOWTOOLTIP     = "Montrer infos";
    HEALBOT_OPTIONS_SHOWDETTOOLTIP  = "Montrer le d\195\169tail des sorts";
    HEALBOT_OPTIONS_SHOWCDTOOLTIP   = "Montrer le CD des sorts";
    HEALBOT_OPTIONS_SHOWUNITTOOLTIP = "Montrer infos sur la cible";
    HEALBOT_OPTIONS_SHOWRECTOOLTIP  = "Montrer le soin HoT recommand\195\169";
    HEALBOT_TOOLTIP_POSDEFAULT      = "Par d\195\169faut";
    HEALBOT_TOOLTIP_POSLEFT         = "A gauche de Healbot";
    HEALBOT_TOOLTIP_POSRIGHT        = "A droite de Healbot";
    HEALBOT_TOOLTIP_POSABOVE        = "Au dessus de Healbot";
    HEALBOT_TOOLTIP_POSBELOW        = "Au dessous de Healbot";
    HEALBOT_TOOLTIP_POSCURSOR       = "Pr\195\170t du Curseur";
    HEALBOT_TOOLTIP_RECOMMENDTEXT   = "Soin HoT recommand\195\169";
    HEALBOT_TOOLTIP_NONE            = "Non disponible";
    HEALBOT_TOOLTIP_CORPSE          = "Cadavre de ";
    HEALBOT_TOOLTIP_CD              = " (CD ";
    HEALBOT_TOOLTIP_SECS            = "s)";
    HEALBOT_WORDS_SEC               = "sec";
    HEALBOT_WORDS_CAST              = "lancer";
    HEALBOT_WORDS_UNKNOWN           = "inconnu";
    HEALBOT_WORDS_YES               = "Oui";
    HEALBOT_WORDS_NO                = "Sans";
    HEALBOT_WORDS_THIN              = "Fin";
    HEALBOT_WORDS_THICK             = "Epais";

    HEALBOT_WORDS_NONE                  = "Aucun(e)";
    HEALBOT_OPTIONS_ALT                 = "Alt";
    HEALBOT_DISABLED_TARGET             = "Cible"
    HEALBOT_OPTIONS_SHOWCLASSONBAR      = "Afficher la classe";
    HEALBOT_OPTIONS_SHOWHEALTHONBAR     = "Afficher la vie";
    HEALBOT_OPTIONS_BARHEALTHINCHEALS   = "Inclure les soins entrants";
    HEALBOT_OPTIONS_BARHEALTHSEPHEALS   = "S\195\169parer les soins entrants";
    HEALBOT_OPTIONS_BARHEALTHINCALL     = "Inclure les heals entrants et les absorptions"
    HEALBOT_OPTIONS_BARHEALTHSEPALL     = "S\195\169parer les heals entrants et les absorptions"
    HEALBOT_OPTIONS_BARHEALTH1          = "en \195\169cart";
    HEALBOT_OPTIONS_BARHEALTH2          = "en pourcentage";
    HEALBOT_OPTIONS_TIPTEXT             = "Bulle d\'information";
    HEALBOT_OPTIONS_POSTOOLTIP          = "Position";
    HEALBOT_OPTIONS_SHOWNAMEONBAR       = "Afficher le nom";
    HEALBOT_OPTIONS_BARTEXTCLASSCOLOUR1 = "Coul. des noms par classe";
    HEALBOT_OPTIONS_EMERGFILTERGROUPS   = "Inclure groupes";

    HEALBOT_ONE                             = "1";
    HEALBOT_TWO                             = "2";
    HEALBOT_THREE                           = "3";
    HEALBOT_FOUR                            = "4";
    HEALBOT_FIVE                            = "5";
    HEALBOT_SIX                             = "6";
    HEALBOT_SEVEN                           = "7";
    HEALBOT_EIGHT                           = "8";

    HEALBOT_OPTIONS_SETDEFAULTS      = "R\195\169g. par d\195\169faut";
    HEALBOT_OPTIONS_SETDEFAULTSMSG   = "R\195\169-initialise toutes les options par d\195\169faut";
    HEALBOT_OPTIONS_RIGHTBOPTIONS    = "Clic droit ouvre les options";

    HEALBOT_OPTIONS_HEADEROPTTEXT    = "Options des titres";
    HEALBOT_OPTIONS_ICONOPTTEXT      = "Options d\'ic\195\180nes";
    HEALBOT_SKIN_HEADERBARCOL        = "Couleur de la barre";
    HEALBOT_SKIN_HEADERTEXTCOL       = "Couleur du texte";
    HEALBOT_OPTIONS_BUFFSTEXT1       = "Type de buff";
    HEALBOT_OPTIONS_BUFFSTEXT2       = "V\195\169rifier membres";
    HEALBOT_OPTIONS_BUFFSTEXT3       = "Couleur";
    HEALBOT_OPTIONS_BUFF             = "Buff ";
    HEALBOT_OPTIONS_BUFFSELF         = "sur soi";
    HEALBOT_OPTIONS_BUFFPARTY        = "sur le groupe";
    HEALBOT_OPTIONS_BUFFRAID         = "sur le raid";
    HEALBOT_OPTIONS_MONITORBUFFS     = "Afficher les buffs manquants";
    HEALBOT_OPTIONS_MONITORBUFFSC    = "aussi en combat";
    HEALBOT_OPTIONS_ENABLESMARTCAST  = "Sorts intelligents hors combat";
    HEALBOT_OPTIONS_SMARTCASTSPELLS  = "Inclure les sorts";
    HEALBOT_OPTIONS_SMARTCASTDISPELL = "Enlever les d\195\169buffs";
    HEALBOT_OPTIONS_SMARTCASTBUFF    = "Ajouter les buffs";
    HEALBOT_OPTIONS_SMARTCASTHEAL    = "Sorts de soin";
    HEALBOT_OPTIONS_BAR2SIZE         = "Taille de la barre de mana";
    HEALBOT_OPTIONS_SETSPELLS        = "Conf. sorts pour";
    HEALBOT_OPTIONS_ENABLEDBARS      = "Barres en combat";
    HEALBOT_OPTIONS_DISABLEDBARS     = "Barres hors combat";
    HEALBOT_OPTIONS_MONITORDEBUFFS   = "Afficher les d\195\169buffs";
    HEALBOT_OPTIONS_DEBUFFTEXT1      = "Sort pour retirer les d\195\169buffs";

    HEALBOT_OPTIONS_IGNOREDEBUFF         = "Ignorer d\195\169buffs:";
    HEALBOT_OPTIONS_IGNOREDEBUFFCLASS    = "Par classe";
    HEALBOT_OPTIONS_IGNOREDEBUFFMOVEMENT = "Ralentissement";
    HEALBOT_OPTIONS_IGNOREDEBUFFDURATION = "Dur\195\169e courte";
    HEALBOT_OPTIONS_IGNOREDEBUFFNOHARM   = "Non nocifs";
    HEALBOT_OPTIONS_IGNOREDEBUFFCOOLDOWN = "Quand CD sort de debuff > 1.5 secs (GCD)";
    HEALBOT_OPTIONS_IGNOREDEBUFFFRIEND   = "Quand lanceur de sort est un ami";

    HEALBOT_OPTIONS_RANGECHECKFREQ       = "Fr\195\169quence de v\195\169rif. de la distance, des auras et de l\'aggro";

    HEALBOT_OPTIONS_HIDEPARTYFRAMES      = "Masquer avatars";
    HEALBOT_OPTIONS_HIDEPLAYERTARGET     = "Y compris joueur & Cible";
    HEALBOT_OPTIONS_DISABLEHEALBOT       = "D\195\169sactiver HealBot";

HEALBOT_ASSIST                       = "Assist";
HEALBOT_FOCUS                        = "Focus";
HEALBOT_MENU                         = "Menu";
HEALBOT_MAINTANK                     = "MainTank";
HEALBOT_MAINASSIST                   = "MainAssist";
HEALBOT_STOP                         = "Stop";
    HEALBOT_TELL                         = "Dire";

    HEALBOT_OPTIONS_SHOWMINIMAPBUTTON    = "Aff. le bouton sur la minicarte";
    HEALBOT_OPTIONS_BARBUTTONSHOWHOT     = "Afficher les HoT";
    HEALBOT_OPTIONS_BARBUTTONSHOWRAIDICON = "Afficher les ic\195\180nes de raid";
    HEALBOT_OPTIONS_HOTONBAR             = "Sur barre";
    HEALBOT_OPTIONS_HOTOFFBAR            = "Hors barre";
    HEALBOT_OPTIONS_HOTBARRIGHT          = "Droite";
    HEALBOT_OPTIONS_HOTBARLEFT           = "Gauche";

    HEALBOT_ZONE_AB = "Bassin d\'Arathi";
    HEALBOT_ZONE_AV = "Vall\195\169e d\'Alterac";  
    HEALBOT_ZONE_ES = "Oeil du cyclone";
    HEALBOT_ZONE_IC = "Ile des conqu\195\169rants";
    HEALBOT_ZONE_SA = "Rivage des anciens";

    HEALBOT_OPTION_AGGROTRACK     = "Moniteur d'aggro"
    HEALBOT_OPTION_AGGROBAR       = "Barre"
    HEALBOT_OPTION_AGGROTXT       = ">> Texte <<"
    HEALBOT_OPTION_AGGROIND       = "Indicateur"
    HEALBOT_OPTION_BARUPDFREQ     = "Fr\195\169quence de mise \195\160 jour"
    HEALBOT_OPTION_USEFLUIDBARS   = "Barres fluides"
    HEALBOT_OPTION_CPUPROFILE     = "Aff. utilisation CPU des addons (intensif pour le CPU !)"
    HEALBOT_OPTIONS_RELOADUIMSG   = "Requiert un re-chargement de l\'UI, charger maintenant ?"

    HEALBOT_BUFF_PVP              = "PvP"
    HEALBOT_BUFF_PVE              = "PvE"
    HEALBOT_OPTIONS_ANCHOR        = "Ancre du cadre"
    HEALBOT_OPTIONS_BARSANCHOR    = "Ancre des barres"
    HEALBOT_OPTIONS_TOPLEFT       = "Haut \195\160 gauche"
    HEALBOT_OPTIONS_BOTTOMLEFT    = "Bas \195\160 gauche"
    HEALBOT_OPTIONS_TOPRIGHT      = "Haut \195\160 droite"
    HEALBOT_OPTIONS_BOTTOMRIGHT   = "Bas \195\160 droite"
    HEALBOT_OPTIONS_TOP           = "Haut"
    HEALBOT_OPTIONS_BOTTOM        = "Bas"

    HEALBOT_PANEL_BLACKLIST       = "BlackList"

    HEALBOT_WORDS_REMOVEFROM      = "Retirer de";
    HEALBOT_WORDS_ADDTO           = "Ajouter \195\160";
    HEALBOT_WORDS_INCLUDE         = "Inclure";

    HEALBOT_OPTIONS_TTALPHA       = "Opacit\195\169"
    HEALBOT_TOOLTIP_TARGETBAR     = "Barre de cible"
    HEALBOT_OPTIONS_MYTARGET      = "Mes cibles"

    HEALBOT_DISCONNECTED_TEXT                   = "<DC>"
    HEALBOT_OPTIONS_SHOWUNITBUFFTIME    = "y compris mes buffs";
    HEALBOT_OPTIONS_TOOLTIPUPDATE       = "M\195\160J permanente";
    HEALBOT_OPTIONS_BUFFSTEXTTIMER      = "Pr\195\169venir de la fin des buffs avant expiration";
    HEALBOT_OPTIONS_SHORTBUFFTIMER      = "Buffs courts"
    HEALBOT_OPTIONS_LONGBUFFTIMER       = "Buffs longs"

HEALBOT_OPTIONS_NOTIFY_MSG      = "Message"
    HEALBOT_WORDS_YOU                = "vous";
    HEALBOT_NOTIFYOTHERMSG           = "Incante #s sur #n";

    HEALBOT_OPTIONS_HOTPOSITION     = "Position ic\195\180ne"
    HEALBOT_OPTIONS_HOTSHOWTEXT     = "Texte de l\'ic\195\180ne"
    HEALBOT_OPTIONS_HOTTEXTCOUNT    = "D\195\169compte"
    HEALBOT_OPTIONS_HOTTEXTDURATION = "Dur\195\169e"
    HEALBOT_OPTIONS_ICONSCALE       = "Echelle de l\'ic\195\180ne"
    HEALBOT_OPTIONS_ICONTEXTSCALE   = "Echelle du texte de l\'ic\195\180ne "

    HEALBOT_OPTIONS_AGGROBARSIZE    = "Taille de la barre d\'aggro"
    HEALBOT_OPTIONS_DOUBLETEXTLINES = "Texte sur deux lignes"
    HEALBOT_OPTIONS_TEXTALIGNMENT   = "Alignement du texte"
    HEALBOT_VEHICLE                 = "V\195\169hicules"
    HEALBOT_WORDS_ERROR             = "Erreur"
    HEALBOT_SPELL_NOT_FOUND         = "Sort pas trouv\195\169"
    HEALBOT_OPTIONS_DISABLETOOLTIPINCOMBAT = "Masquer les infos durant les combats"
    HEALBOT_OPTIONS_ENABLELIBQH     = "Activer HealBot fastHealth"

    HEALBOT_OPTIONS_BUFFNAMED       = "Nom du joueur \195\160 surveiller\n\n"
    HEALBOT_WORD_ALWAYS             = "Toujours";
    HEALBOT_WORD_SOLO               = "En solo";
    HEALBOT_WORD_NEVER              = "Jamais";
    HEALBOT_SHOW_CLASS_AS_ICON      = "Ic\195\180ne";
    HEALBOT_SHOW_CLASS_AS_TEXT      = "Texte";
    HEALBOT_SHOW_ROLE               = "Afficher le r\195\180le";

    HEALBOT_SHOW_INCHEALS           = "Montrer les soins entrants";

HEALBOT_HELP={  [1] = "[HealBot] /hb h -- Afficher l\'aide",
                [2] = "[HealBot] /hb o -- Bascule options",
                [3] = "[HealBot] /hb ri -- R\195\160Z HealBot",
                [4] = "[HealBot] /hb t -- Bascule Healbot activ\195\169/d\195\169sactiv\195\169",
                [5] = "[HealBot] /hb bt -- Bascule moniteur de Buffs activ\195\169/d\195\169sactiv\195\169",
                [6] = "[HealBot] /hb dt -- Bascule moniteur de D\195\169buffs activ\195\169/d\195\169sactiv\195\169",
                [7] = "[HealBot] /hb skin <skinName> -- Changer de Skin",
                [8] = "[HealBot] /hb ui -- Recharger UI (reloadui)",
                [9] = "[HealBot] /hb hs -- Afficher les commandes slash suppl\195\169mentaires",
              }

HEALBOT_HELP2={ [1] = "[HealBot] /hb d -- R\195\160Z des options",
                [2] = "[HealBot] /hb aggro 2 <n> -- Fixe le niveau d\aggro 2 au \% de menace <n>",
                [3] = "[HealBot] /hb aggro 3 <n> -- Fixe le niveau d\aggro 3 au \% de menace <n>",
                [4] = "[HealBot] /hb tr <Role> -- D\195\169termine le r\195\180le prioritaire pour le sous-tri par r\195\180le. Les r\195\180les valides sont 'TANK', 'HEALER' ou 'DPS'",
                [5] = "[HealBot] /hb use10 -- Utilisation auto. du slot 10 d\'ing\195\169nieur",
                [6] = "[HealBot] /hb pcs <n> -- Ajuste la taille de l\indicateur de charge de Puissance Sacr\195\169e \195\160 <n>, valeur par d\195\169faut : 7 ",
                [7] = "[HealBot] /hb spt -- Bascule Self Pet",
                [8] = "[HealBot] /hb ws -- Bascule l\'affichage de l\'ic\195\180ne d\'Ame affaiblie au lieu de MdP : Bouclier avec un -",
                [9] = "[HealBot] /hb rld <n> -- En secondes, dur\195\169e de l\'affichage en vert du nom du joueur apr\195\168s le res",
                [10] = "[HealBot] /hb flb -- Bascule verrouillage position (Ctrl+Alt+Left clic permet toujours de la d\195\169placer)",
                [11] = "[HealBot] /hb rtb -- Bascule restriction barre de cible sur bt gauche=SmartCast et bt droit=ajouter/enlever de \'Mes cibles\'",
              }
             
    HEALBOT_OPTION_HIGHLIGHTACTIVEBAR   = "Surbrillance au mouseover"
    HEALBOT_OPTION_HIGHLIGHTTARGETBAR   = "Surbrillance cible"
    HEALBOT_OPTIONS_TESTBARS            = "Barres de test"
    HEALBOT_OPTION_NUMBARS              = "Nombre de barres"
    HEALBOT_OPTION_NUMTANKS             = "Nombre de tanks"
    HEALBOT_OPTION_NUMMYTARGETS         = "Nombre de cibles"
    HEALBOT_OPTION_NUMPETS              = "Nombre de familiers"
HEALBOT_WORD_TEST                   = "Test";
HEALBOT_WORD_OFF                    = "Off";
HEALBOT_WORD_ON                     = "On";

    HEALBOT_OPTIONS_TAB_PROTECTION          = "Protection"
    HEALBOT_OPTIONS_TAB_CHAT            = "Chat"
    HEALBOT_OPTIONS_TAB_HEADERS         = "En-t\195\170tes"
    HEALBOT_OPTIONS_TAB_BARS            = "Barres"
    HEALBOT_OPTIONS_TAB_ICONS           = "Ic\195\180nes"
    HEALBOT_OPTIONS_TAB_WARNING             = "Attention"
    HEALBOT_OPTIONS_SKINDEFAULTFOR      = "Skin par d\195\169faut pour"
    HEALBOT_OPTIONS_INCHEAL             = "les soins entrants"
    HEALBOT_WORD_ARENA                  = "Ar\195\170ne"
    HEALBOT_WORD_BATTLEGROUND           = "Champ de bataille"
    HEALBOT_OPTIONS_TEXTOPTIONS         = "Options de texte"
    HEALBOT_WORD_PARTY                  = "Groupe"
    HEALBOT_OPTIONS_COMBOAUTOTARGET     = "Cible Auto"
    HEALBOT_OPTIONS_COMBOAUTOTRINKET    = "Trinket Auto"
    HEALBOT_OPTIONS_GROUPSPERCOLUMN     = "Groupes par colonne"

    HEALBOT_OPTIONS_MAINSORT            = "Cl\195\169 principale"
    HEALBOT_OPTIONS_SUBSORT             = "Cl\195\169 secondaire"
    HEALBOT_OPTIONS_SUBSORTINC          = "Trier par cl\195\169 sec. :"

    HEALBOT_OPTIONS_BUTTONCASTMETHOD    = "Incanter qd"
    HEALBOT_OPTIONS_BUTTONCASTPRESSED   = "press\195\169"
    HEALBOT_OPTIONS_BUTTONCASTRELEASED  = "relach\195\169"

    HEALBOT_INFO_ADDONCPUUSAGE          = "== Utilisation CPU en sec. =="
    HEALBOT_INFO_ADDONCOMMUSAGE         = "== Comm. des addons =="
    HEALBOT_WORD_HEALER                     = "Soigneur"
HEALBOT_WORD_DAMAGER                    = "DPS"
HEALBOT_WORD_TANK                       = "Tank"
    HEALBOT_WORD_LEADER                     = "Chef"
HEALBOT_WORD_VERSION                    = "Version"
HEALBOT_WORD_CLIENT                     = "Client"
HEALBOT_WORD_ADDON                  = "Addon"
HEALBOT_INFO_CPUSECS                = "CPU Sec."
    HEALBOT_INFO_MEMORYKB               = "M\195\169moire Ko"
    HEALBOT_INFO_COMMS                  = "Comm. Ko"

    HEALBOT_WORD_STAR                   = "\195\169toile"
    HEALBOT_WORD_CIRCLE                 = "cercle"
    HEALBOT_WORD_DIAMOND                = "diamant"
    HEALBOT_WORD_TRIANGLE               = "triangle"
    HEALBOT_WORD_MOON                   = "lune"
    HEALBOT_WORD_SQUARE                 = "carr\195\169"
    HEALBOT_WORD_CROSS                  = "croix"
    HEALBOT_WORD_SKULL                  = "cr\195\162ne"

    HEALBOT_OPTIONS_ACCEPTSKINMSG       = "Accepter skin [HealBot] : "
    HEALBOT_OPTIONS_ACCEPTSKINMSGFROM   = " de "
    HEALBOT_OPTIONS_BUTTONSHARESKIN     = "Partager avec"

    HEALBOT_CHAT_ADDONID                = "[HealBot]  "
    HEALBOT_CHAT_NEWVERSION1            = "Une version plus r\195\169cente est disponible"
    HEALBOT_CHAT_NEWVERSION2            = "sur "..HEALBOT_ABOUT_URL
    HEALBOT_CHAT_SHARESKINERR1          = " Skin pas trouv\195\169e pour le partage"
    HEALBOT_CHAT_SHARESKINERR3          = " pas trouv\195\169e pour le partage de skin"
    HEALBOT_CHAT_SHARESKINACPT          = "Partage de skin accept\195\169 de "
    HEALBOT_CHAT_CONFIRMSKINDEFAULTS    = "Skins par d\195\169faut"
    HEALBOT_CHAT_CONFIRMCUSTOMDEFAULTS  = "RaZ Debuffs personnalis\195\169s"
    HEALBOT_CHAT_CHANGESKINERR1         = "Skin inconnu: /hb skin "
    HEALBOT_CHAT_CHANGESKINERR2         = "Skins valides:  "
    HEALBOT_CHAT_CONFIRMSPELLCOPY       = "Sort actuel copi\195\169 pour toutes les sp\195\169."
    HEALBOT_CHAT_UNKNOWNCMD             = "Commande slash inconnue: /hb "
    HEALBOT_CHAT_ENABLED                = "Entr\195\169e en mode combat"
    HEALBOT_CHAT_DISABLED               = "Entr\195\169e en mode hors combat"
    HEALBOT_CHAT_SOFTRELOAD             = "Reload healbot demand\195\169"
    HEALBOT_CHAT_HARDRELOAD             = "Reload UI demand\195\169"
    HEALBOT_CHAT_CONFIRMSPELLRESET      = "RaZ des sorts"
    HEALBOT_CHAT_CONFIRMCURESRESET      = "RaZ des gu\195\169risons"
    HEALBOT_CHAT_CONFIRMBUFFSRESET      = "RaZ des buffs"
    HEALBOT_CHAT_POSSIBLEMISSINGMEDIA   = "Impossible de recevoir les r\195\169glages de Skin - Possible absence de SharedMedia, voir HealBot/Docs/readme.html pour les liens"
    HEALBOT_CHAT_MACROSOUNDON           = "Son pas supprim\195\169 \195\160 l\'utilisation auto d\'un trinket"
    HEALBOT_CHAT_MACROSOUNDOFF          = "Son supprim\195\169 \195\160 l\'utilisation auto d\'un trinket"
    HEALBOT_CHAT_MACROERRORON           = "Erreurs pas supprim\195\169es \195\160 l\'utilisation auto d\'un trinket"
    HEALBOT_CHAT_MACROERROROFF          = "Erreurs supprim\195\169es \195\160 l\'utilisation auto d\'un trinket"
    HEALBOT_CHAT_ACCEPTSKINON           = "Partage de skin actif - Afficher une fen\195\170tre de confirmation avant d'accepter un skin"
    HEALBOT_CHAT_ACCEPTSKINOFF          = "Partage de Skin inactif - Ignorer les propositions de skin"
    HEALBOT_CHAT_USE10ON                = "Trinket auto - Use10 est actif - Vous devez activer un auto trinket existant pour que use10 fonctionne"
    HEALBOT_CHAT_USE10OFF               = "Trinket auto - Use10 est inactif"
    HEALBOT_CHAT_SKINREC                = " skin re\195\167u de "

    HEALBOT_OPTIONS_SELFCASTS           = "Seulement mes sorts"
    HEALBOT_OPTIONS_HOTSHOWICON         = "Afficher ic\195\180ne"
    HEALBOT_OPTIONS_ALLSPELLS           = "Tous les sorts"
    HEALBOT_OPTIONS_DOUBLEROW           = "Sur deux lignes"
    HEALBOT_OPTIONS_HOTBELOWBAR         = "Sous la barre"
    HEALBOT_OPTIONS_OTHERSPELLS         = "Autres sorts"
    HEALBOT_WORD_MACROS                 = "Macros"
    HEALBOT_WORD_SELECT                 = "S\195\169lection"
    HEALBOT_OPTIONS_QUESTION            = "?"
    HEALBOT_WORD_CANCEL                 = "Annuler"
    HEALBOT_WORD_COMMANDS               = "Commandes"
    HEALBOT_OPTIONS_BARHEALTH3          = "vie actuelle";
    HEALBOT_SORTBY_ROLE                 = "R\195\180le"
    HEALBOT_WORD_DPS                    = "DPS"
    HEALBOT_CHAT_TOPROLEERR             = " r\195\180le non valide - utiliser 'TANK', 'DPS' ou 'HEALER'"
    HEALBOT_CHAT_NEWTOPROLE             = "Le r\195\180le prioritaire est "
    HEALBOT_CHAT_SUBSORTPLAYER1         = "Joueur en premier dans le sous-tri"
    HEALBOT_CHAT_SUBSORTPLAYER2         = "Joueur tri\195\169 avec les autres"
    HEALBOT_OPTIONS_SHOWREADYCHECK      = "Afficher l\'appel Raid";
    HEALBOT_OPTIONS_SUBSORTSELFFIRST    = "Soi en premier"
    HEALBOT_WORD_FILTER                 = "Filtre"
    HEALBOT_OPTION_AGGROPCTBAR          = "Bouger la barre" ---- ??????????????????
    HEALBOT_OPTION_AGGROPCTTXT          = "Aff. texte"
    HEALBOT_OPTION_AGGROPCTTRACK        = "Suivre pourcent."
    HEALBOT_OPTIONS_ALERTAGGROLEVEL1    = "1 - Menace basse"
    HEALBOT_OPTIONS_ALERTAGGROLEVEL2    = "2 - Menace haute"
    HEALBOT_OPTIONS_ALERTAGGROLEVEL3    = "3 - Tanking"
    HEALBOT_OPTIONS_AGGROALERT          = "Barre : niveau d\'alerte"
    HEALBOT_OPTIONS_AGGROINDALERT           = "Indicateur de niveau d\'alerte"
    HEALBOT_OPTIONS_TOOLTIPSHOWHOT      = "Montrer les d\195\169tails des HoT suivis"
    HEALBOT_WORDS_MIN                   = "min"
    HEALBOT_WORDS_MAX                   = "max"
    HEALBOT_CHAT_SELFPETSON             = "Auto Pet activ\195\169"
    HEALBOT_CHAT_SELFPETSOFF            = "Auto Pet d\195\169sactiv\195\169"
    HEALBOT_WORD_PRIORITY               = "Priorit\195\169"
    HEALBOT_VISIBLE_RANGE               = "Dans les 100m"
    HEALBOT_SPELL_RANGE                 = "A port\195\169e de sorts"
    HEALBOT_WORD_RESET                  = "R\195\160Z"
    HEALBOT_HBMENU                      = "menuHB"
    HEALBOT_ACTION_HBFOCUS              = "Bouton gauche\npour focus la cible"
    HEALBOT_WORD_CLEAR                  = "Effacer"
    HEALBOT_WORD_SET                    = "D\195\169terminer"
    HEALBOT_WORD_HBFOCUS                = "Focus HealBot"
    HEALBOT_WORD_OUTSIDE                    = "En ext\195\169rieur"
    HEALBOT_WORD_ALLZONE                    = "Toutes les zones"
    HEALBOT_OPTIONS_TAB_ALERT           = "Alerte"
    HEALBOT_OPTIONS_TAB_SORT            = "Tri"
    HEALBOT_OPTIONS_TAB_HIDE            = "Masquer"
    HEALBOT_OPTIONS_TAB_AGGRO           = "Aggro"
    HEALBOT_OPTIONS_TAB_ICONTEXT        = "Aff. ic\195\180nes"
    HEALBOT_OPTIONS_TAB_TEXT            = "Aff. barres"
    HEALBOT_OPTIONS_AGGRO3COL           = "Barre d\'Aggro\ncouleur"
    HEALBOT_OPTIONS_AGGROFLASHFREQ      = "Fr\195\169quence flash"
    HEALBOT_OPTIONS_AGGROFLASHALPHA     = "Opacit\195\169 flash"
    HEALBOT_OPTIONS_SHOWDURATIONFROM    = "Dur\195\169e restante \195\160 partir de "
    HEALBOT_OPTIONS_SHOWDURATIONWARN    = "Alerte \195\160 partir de "
    HEALBOT_CMD_RESETCUSTOMDEBUFFS      = "R\195\160Z d\195\169buffs personnalis\195\169s"
    HEALBOT_CMD_RESETSKINS              = "R\195\160Z skins"
    HEALBOT_CMD_CLEARBLACKLIST          = "Effacer blackList"
    HEALBOT_CMD_TOGGLEACCEPTSKINS       = "Bascule accepter Skins des autres"
    HEALBOT_CMD_TOGGLEDISLIKEMOUNT      = "Bascule monture exclue"
    HEALBOT_OPTION_DISLIKEMOUNT_ON      = "Exclure la monture"
    HEALBOT_OPTION_DISLIKEMOUNT_OFF     = "Ne plus exclure la monture"
    HEALBOT_CMD_COPYSPELLS              = "Copier les sorts pour toutes les sp\195\169cialisations"
    HEALBOT_CMD_RESETSPELLS             = "R\195\160Z sorts"
    HEALBOT_CMD_RESETCURES              = "R\195\160Z gu\195\169risons"
    HEALBOT_CMD_RESETBUFFS              = "R\195\160Z buffs"
    HEALBOT_CMD_RESETBARS               = "R\195\160Z position des barres"
    HEALBOT_CMD_SUPPRESSSOUND           = "Bascule son pour trinket auto"
    HEALBOT_CMD_SUPPRESSERRORS          = "Bascule messages d\'erreurs pour trinket auto"
    HEALBOT_OPTIONS_COMMANDS            = "Commandes HealBot"
    HEALBOT_WORD_RUN                    = "Ex\195\169cuter"
    HEALBOT_OPTIONS_MOUSEWHEEL          = "Utiliser la roue de souris"
    HEALBOT_OPTIONS_MOUSEUP             = "Vers le haut"
    HEALBOT_OPTIONS_MOUSEDOWN           = "Vers le bas"
    HEALBOT_CMD_DELCUSTOMDEBUFF10       = "Effacer les d\195\169buffs personnalis\195\169s de priorit\195\169 10"
    HEALBOT_CMD_DELCUSTOMDEBUFF9        = "Effacer les debuffs perso. en priorit\195\169 9"
    HEALBOT_CMD_DELCUSTOMDEBUFF11       = "Effacer les debuffs perso. en priorit\195\169  11"
    HEALBOT_CMD_DELCUSTOMDEBUFF12       = "Effacer les debuffs perso. en priorit\195\169  12"
    HEALBOT_ACCEPTSKINS                 = "Accepter les Skins"
    HEALBOT_SUPPRESSSOUND               = "Auto Trinket : Suppr. son"
    HEALBOT_SUPPRESSERROR               = "Auto Trinket : Suppr. erreurs"
    HEALBOT_OPTIONS_CRASHPROT           = "Protection anti-Crash"
    HEALBOT_OPTIONS_USEGENERALMACRO     = "Utiliser les slots macro de Wow"
    HEALBOT_CP_MACRO_LEN                = "Le nom de la macro doit avoir 1 \195\160 14 caract\195\168res"
    HEALBOT_CP_MACRO_BASE               = "hbMacro"
    HEALBOT_CP_MACRO_SAVE               = "Derni\195\168re sauvegarde: "
    HEALBOT_CP_STARTTIME                = "Dur\195\169e de la protection \195\160 la connexion"
    HEALBOT_WORD_RESERVED               = "R\195\169serv\195\169"
    HEALBOT_OPTIONS_COMBATPROT          = "Protection en combat "
    HEALBOT_COMBATPROT_PARTYNO          = "barres r\195\169serv\195\169es pour le groupe"
    HEALBOT_COMBATPROT_RAIDNO           = "barres r\195\169serv\195\169es pour le raid"

    HEALBOT_WORD_HEALTH                     = "Vie"
    HEALBOT_OPTIONS_DONT_SHOW               = "Ne pas montrer"
    HEALBOT_OPTIONS_SAME_AS_HLTH_CURRENT    = "Comme la vie (vie actuelle)"
    HEALBOT_OPTIONS_SAME_AS_HLTH_FUTURE     = "Comme la vie (vie future)"
    HEALBOT_OPTIONS_FUTURE_HLTH             = "Vie future"
    HEALBOT_SKIN_HEALTHBARCOL_TEXT          = "Barre de vie";
    HEALBOT_SKIN_HEALTHBACKCOL_TEXT         = "Arri\195\168re-plan";
    HEALBOT_SKIN_INCHEALBARCOL_TEXT         = "Soins entrants";
    HEALBOT_OPTIONS_ALWAYS_SHOW_TARGET      = "Cible: Toujours montrer"
    HEALBOT_OPTIONS_ALWAYS_SHOW_FOCUS       = "Focus: Toujours montrer"
    HEALBOT_OPTIONS_GROUP_PETS_BY_FIVE      = "Familiers : Groupes de cinq"
    HEALBOT_OPTIONS_USEGAMETOOLTIP          = "Utiliser le tooltip du jeu"
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER        = "Afficher le compteur de puissance"
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER_PALA   = "Afficher la puissance sacr\195\169e"
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER_MONK   = "Afficher le Chi"
    HEALBOT_OPTIONS_CUSTOMDEBUFF_REVDUR     = "Dur\195\169e invers\195\169e"
    HEALBOT_OPTIONS_DISABLEHEALBOTSOLO      = "seulement en solo"
    HEALBOT_OPTIONS_CUSTOM_ALLDISEASE       = "Maladies (toutes)"
    HEALBOT_OPTIONS_CUSTOM_ALLMAGIC         = "Magiques (tous)"
    HEALBOT_OPTIONS_CUSTOM_ALLCURSE         = "Mal\195\169dictions (Toutes)"
    HEALBOT_OPTIONS_CUSTOM_ALLPOISON        = "Poisons (tous)"
    HEALBOT_OPTIONS_CUSTOM_CASTBY           = "Incanter par"

    HEALBOT_BLIZZARD_MENU                   = "Menu Blizzard"
    HEALBOT_HB_MENU                         = "Menu Healbot"
    HEALBOT_FOLLOW                          = "Suivre"
    HEALBOT_TRADE                           = "Echanger"
    HEALBOT_PROMOTE_RA                      = "Nommer assistant raid"
    HEALBOT_DEMOTE_RA                       = "D\195\169grader"
    HEALBOT_TOGGLE_ENABLED                  = "Bascule \'activ\195\169s\'"
    HEALBOT_TOGGLE_MYTARGETS                = "Bascule \'Mes cibles\'"
    HEALBOT_TOGGLE_PRIVATETANKS             = "Bascule \'Tanks perso.\'"
    HEALBOT_RESET_BAR                       = "R\195\160Z barres"
    HEALBOT_HIDE_BARS                       = "Masquer les barres si au del\195\160 de 100m"
    HEALBOT_RANDOMMOUNT                     = "Monture al\195\169atoire"
    HEALBOT_RANDOMGOUNDMOUNT                = "Monture terrestre al\195\169atoire"
    HEALBOT_RANDOMPET                       = "Mascotte al\195\169atoire"
    HEALBOT_ZONE_AQ40                       = "Ahn\'Qiraj"
    HEALBOT_ZONE_VASHJIR1                   = "For\195\170t de Varech\'thar"
    HEALBOT_ZONE_VASHJIR2                   = "\195\137tendues Chatoyantes"
    HEALBOT_ZONE_VASHJIR3                   = "Profondeurs Abyssales"
    HEALBOT_ZONE_VASHJIR                    = "Vashj'ir"
    HEALBOT_RESLAG_INDICATOR                = "Dur\195\169e d\'affichage du nom en vert apr\195\168s rez"
    HEALBOT_RESLAG_INDICATOR_ERROR          = "Dur\195\169e d\'affichage du nom en vert apr\195\168s rez entre 1 et 30"
    HEALBOT_FRAMELOCK_BYPASS_OFF            = "Bouger le cadre malgr\195\169 le verrouillage : inactif"
    HEALBOT_FRAMELOCK_BYPASS_ON             = "Bouger le cadre malgr\195\169 le verrouillage : actif  (Ctl+Alt+Gauche)"
    HEALBOT_RESTRICTTARGETBAR_ON            = "Restriction barre de cible Active"
    HEALBOT_RESTRICTTARGETBAR_OFF           = "Restriction barre de cible Inactive"
    HEALBOT_AGGRO2_ERROR_MSG                = "Pour r\195\169gler le niveau 2 d\'aggro, le pourcentage de menace doit \195\170tre entre 25 et 95"
    HEALBOT_AGGRO3_ERROR_MSG                = "Pour r\195\169gler le niveau 3 d\'aggro, le pourcentage de menace doit \195\170tre entre 75 et 100"
    HEALBOT_AGGRO2_SET_MSG                  = "Pourcentage de menace du niveau 2 d\'aggro r\195\169gl\195\169 sur "
    HEALBOT_AGGRO3_SET_MSG                  = "Pourcentage de menace du niveau 3 d\'aggro r\195\169gl\195\169 sur "
    HEALBOT_WORD_THREAT                     = "Menace"
    HEALBOT_AGGRO_ERROR_MSG                 = "Niveau d\'aggro non valable - utiliser 2 ou 3"

    HEALBOT_OPTIONS_QUERYTALENTS            = "Requ\195\170te infos talent"        
    HEALBOT_OPTIONS_LOWMANAINDICATOR        = "Indicateur de Mana faible"
    HEALBOT_OPTIONS_LOWMANAINDICATOR1       = "Ne pas afficher"
    HEALBOT_OPTIONS_LOWMANAINDICATOR2       = "*10% / **20% / ***30%"
    HEALBOT_OPTIONS_LOWMANAINDICATOR3       = "*15% / **30% / ***45%"
    HEALBOT_OPTIONS_LOWMANAINDICATOR4       = "*20% / **40% / ***60%"
    HEALBOT_OPTIONS_LOWMANAINDICATOR5       = "*25% / **50% / ***75%"
    HEALBOT_OPTIONS_LOWMANAINDICATOR6       = "*30% / **60% / ***90%"

    HEALBOT_OPTION_IGNORE_AURA_RESTED       = "Ignorer les  Buffs/D\195\169buffs... pendant le repos"
    HEALBOT_OPTION_ADJUST_MAX_HEALTH        = "Ajuster les PV max du personnage"
    

    HEALBOT_WORD_ENABLE                     = "Activer"
    HEALBOT_WORD_DISABLE                    = "D\195\169sactiver"

    HEALBOT_OPTIONS_MYCLASS                 = "Ma Classe"

HEALBOT_OPTIONS_CONTENT_ABOUT           = "        A Propos"
    HEALBOT_OPTIONS_CONTENT_GENERAL         = "        " .. HEALBOT_OPTIONS_TAB_GENERAL
    HEALBOT_OPTIONS_CONTENT_SPELLS          = "        " .. HEALBOT_OPTIONS_TAB_SPELLS
    HEALBOT_OPTIONS_CONTENT_SKINS           = "        " .. HEALBOT_OPTIONS_TAB_SKIN
    HEALBOT_OPTIONS_CONTENT_CURE            = "        " .. HEALBOT_OPTIONS_TAB_CDC
    HEALBOT_OPTIONS_CONTENT_BUFFS           = "        " .. HEALBOT_OPTIONS_TAB_BUFFS
    HEALBOT_OPTIONS_CONTENT_TIPS            = "        " .. HEALBOT_OPTIONS_TAB_TIPS
    HEALBOT_OPTIONS_CONTENT_MOUSEWHEEL      = "        Roue de souris"
HEALBOT_OPTIONS_CONTENT_TEST            = "        Test"
    HEALBOT_OPTIONS_CONTENT_USAGE           = "        Utilisation CPU"
    HEALBOT_OPTIONS_REFRESH                 = "Rafraichir"

    HEALBOT_CUSTOM_CATEGORY                 = "Cat\195\169gorie"
    HEALBOT_CUSTOM_CAT_CUSTOM               = "Personnalis\195\169"
HEALBOT_CUSTOM_CAT_02                   = "A - B"   -- ****************************************************
HEALBOT_CUSTOM_CAT_03                   = "C - D"   -- Custom Debuff Categories can be translated
HEALBOT_CUSTOM_CAT_04                   = "E - F"   -- 
HEALBOT_CUSTOM_CAT_05                   = "G - H"   -- If translating into a language with a completely different alphabet,
HEALBOT_CUSTOM_CAT_06                   = "I - J"   -- the descriptions of HEALBOT_CUSTOM_CAT_02 - HEALBOT_CUSTOM_CAT_14 can be changed.
HEALBOT_CUSTOM_CAT_07                   = "K - L"   -- Just ensure all 13 variables are used
HEALBOT_CUSTOM_CAT_08                   = "M - N"   -- 
HEALBOT_CUSTOM_CAT_09                   = "O - P"   -- Setting debuffs in HEALBOT_CUSTOM_DEBUFF_CATS,
HEALBOT_CUSTOM_CAT_10                   = "Q - R"   -- The only rule is the category number needs to match the last digits of the variable names, for example:
HEALBOT_CUSTOM_CAT_11                   = "S - T"   -- If HEALBOT_DEBUFF_AGONIZING_FLAMES starts with an T in a different region
HEALBOT_CUSTOM_CAT_12                   = "U - V"   -- the category would be 11, simply change the 2 to 11.
HEALBOT_CUSTOM_CAT_13                   = "W - X"   --
HEALBOT_CUSTOM_CAT_14                   = "Y - Z"   -- ****************************************************

    HEALBOT_CUSTOM_CASTBY_EVERYONE          = "Tous"
    HEALBOT_CUSTOM_CASTBY_ENEMY             = "Ennemi"
    HEALBOT_CUSTOM_CASTBY_FRIEND            = "Ami"

    HEALBOT_ABOUT_DESC1                    = "Ajoute un panneau param\195\169trable de barres pour soigner, buff, debuff, rez et suivi d\'aggro"
    HEALBOT_ABOUT_WEBSITE                  = "Site Web :"
    HEALBOT_ABOUT_AUTHORH                  = "Auteur :"
    HEALBOT_ABOUT_AUTHORD                  = "Strife"
    HEALBOT_ABOUT_CATH                     = "Cat\195\169gorie :"
    HEALBOT_ABOUT_CATD                     = "Unit Frames, Buffs and Debuffs, Combat:Healer"
    HEALBOT_ABOUT_CREDITH                  = "Cr\195\169dits :"
    HEALBOT_ABOUT_CREDITD                  = "Acirac, Kubik, Von, Aldetal, Brezza, CT, Moonlight Han Xing"  -- Anyone taking on translations (if required), feel free to add yourself here.
    HEALBOT_ABOUT_LOCALH                   = "Traductions :"
    HEALBOT_ABOUT_LOCALD                   = "deDE, enUK, esES, frFR, huHU, itIT, koKR, ruRU, poBR, zhCN, zhTW"
    HEALBOT_ABOUT_FAQH                     = "FAQ"
HEALBOT_ABOUT_FAQ_QUESTION             = "Question"
HEALBOT_ABOUT_FAQ_ANSWER               = "R\195\169ponse"

HEALBOT_ABOUT_FAQ_QUESTIONS = {   [1]   = "Buffs - Toutes les barres sont blanches, que se passe-t-il ?",
                                  [2]   = "Sorts - Le curseur devient bleu et je ne peux rien faire ?",
                                  [3]   = "Macros - Avez-vous des exemples de macro pour g\195\169rer les probl\195\168mes de CD ?",
                                  [4]   = "Macros - Avez-vous des exemples de macro pour utiliser les trinkets avec les sorts ?",
                                  [5]   = "Souris - Comment utiliser les macros 'mouseover' avec la roue de souris ?",
                                  [6]   = "Options - Les barres peuvent-elles \195\170tre tri\195\169es par groupes, par exemple 2 groupes par colonne ?",
                                  [7]   = "Options - Peut-on masquer toutes les barres sauf celles de joueurs ayant un debuff \195\160 enlever ?",
                                  [8]   = "Options - Peut-on masquer les soins entrants ?",
                                  [9]   = "Options - Healbot n\'enregistre pas les options quand je me d\195\169connecte",
                                  [10]  = "Options - Comment faire pour toujours utiliser les r\195\169glages \'en combat\' ?",
                                  [11]  = "Options - Comment d\195\169sactiver Healbot ?",
                                  [12]  = "Options - Comment faire pour que les barres croissent de droite \195\160 gauche ?",
                                  [13]  = "Options - Comment d\195\169finir 'Mes cibles' ?",
                                  [14]  = "Options - Comment d\195\169finir mes 'Tanks perso.' ?",
                                  [15]  = "Options - Healbot peut-il cr\195\169\195\169-t-il une barre pour un PNJ ?",
                                  [16]  = "Port\195\169e - Comment identifier les joueurs hors de port\195\169e ?",
                                  [17]  = "Sorts - Healbot lance des sorts qui ne sont pas ceux que j\'ai d\195\169fini ?",
                                  [18]  = "Sorts - Je ne peux plus lancer des sorts sur les cibles qui ne sont pas bless\195\169es ?",
                              }

HEALBOT_ABOUT_FAQ_SPELLS_ANSWER01       = "C\'est \195\162 cause d\'une option dans l\'onglet Sorts\n" ..
                                          "essayez ces solutions : \n\n" ..
                                          "     1: Onglet Sorts : Activez Tjrs util. cfg. \'en combat\' \n" ..
                                          "     2: Onglet Sorts : D\195\169sactivez Sorts intelligents hors combat\n\n" ..
                                          "Nota : Logiquement la plupart des joueurs\n"..
                                          "           utiliseront cette option de sorts intelligents\n\n" ..
                                          "Nota : Logiquement la plupart des joueurs exp\195\169riment\195\169s\n" ..
                                          "           d\195\169sactiveront l\'option Tjrs util. cfg. \'en combat\'\n" ..
                                          "           et d\195\169finiront des sorts pour \'hors combat\'"
                                          
HEALBOT_ABOUT_FAQ_ANSWERS = {     [1]   = "Vous surveillez les buffs manquants \n\n" .. 
                                          "Cela peut \195\170tre modifi\195\169 dans l\'onglet Buffs \n" ..
                                          "Autrement cliquez sur la barre pour lancer le sort de Buff",
                                  [2]   = "C\'est une fonctionnalit\195\169 de Blizzard, pas de Healbot \n\n" .. 
                                          "En utilisant l\'interface Blizzard, \n" ..
                                          "essayez de lancer un sort qui est en cours de CD \n" ..
                                          "vous pourrez voir que le curseur devient bleu. \n" ..
                                          "(CD : Cooldown = Temps de recharge) \n\n" ..
                                          "Nota : Rien ne peut \195\170tre fait pour modifier cela car en combat, \n" ..
                                          "la totalit\195\169 de l\'interface est verrouill\195\169e.\n\n" ..
                                          "La meilleure solution est de surveiller le CD dans la bulle d\info",
                                  [3]   = "Oui \n\n"..
                                          "Exemple de macro pour g\195\169rer le CD de Main de salut du Paladin : \n\n" ..
                                          "    #show Main de salut \n" ..
                                          '    /script local n=UnitName("hbtarget"); ' .. "\n" ..
                                          '    if GetSpellCooldown("Main de salut")==0 then ' .. " \n" ..
                                          '        SendChatMessage("Main de salut sur "..n,"YELL") ' .. "\n" ..
                                          '        SendChatMessage("Main de salut!","WHISPER",nil,n) ' .. "\n" ..
                                          "    end; \n" ..
                                          "    /cast [@hbtarget] Main de salut",
                                  [4]   = "Oui \n\n"..
                                          "Exemple de macro pour utiliser les deux trinkets avec\n" ..
                                          "le Soin Rapide du pr\195\170tre : \n\n" ..
                                          "    #show Soins rapides \n" ..
                                          "    /script UIErrorsFrame:Hide() \n" ..
                                          "    /console Sound_EnableSFX 0 \n" ..
                                          "    /use 13 \n" ..
                                          "    /use 14 \n" ..
                                          "    /console Sound_EnableSFX 1 \n" ..
                                          "    /cast [@hbtarget] Soins rapides \n" ..
                                          "    /script UIErrorsFrame:Clear(); UIErrorsFrame:Show()",
                                  [5]   = "1: Dans l'onglet Roue de souris : \n" ..
                                          "        D\195\169sactivez l'utilisation de la roue de souris\n\n" ..
                                          "2: Utilisez [@mouseover] dans vos macros \n\n" ..
                                          "Exemple : \n\n" ..
                                          "    #showtooltip Soins rapides \n" ..
                                          "    /cast [@mouseover] Soins rapides \n\n" ..
                                          "3: Choisissez la macro dans l'onglet Sorts \n",
                                  [6]   = "Oui \n\n\n"..
                                          "Avec en-t\195\170tes : \n" ..
                                          "     1: Onglet Skin>En-t\195\170tes, cochez Afficher les en-t\195\170tes \n" ..
                                          "     2: Onglet Skin>Barres, pr\195\169cisez le Nb d\'en-t\195\170tes par col. \n\n" ..
                                          "Sans en-t\195\170tes : \n" ..
                                          "     1: Onglet Skin>En-t\195\170tes, d\195\169cochez Afficher les en-t\195\170tes \n" ..
                                          "     1: Onglet Skin>Barres, cochez Groupes par colonne \n" ..
                                          "     2: Onglet Skin>Barres, pr\195\169cisez le Nb d\'en-t\195\170tes par col.  ",
                                  [7]   = "Oui \n\n"..
                                          "1: Onglet Skin>Soins>Onglet Alerte, Niveau d'alerte \195\160 0 \n" ..
                                          "2: Onglet Skin>Aggro, D\195\169sctivez le Moniteur d'aggro \n" .. 
                                          "3: Onglet Skin>Barres, r\195\169glez Opacit\195\169 Hors combat \195\160 0 \n" ..
                                          "4: Onglet Skin>Barres, r\195\169glez Opacit\195\169 Arri\195\168re plan \195\160 0 \n" ..
                                          "5: Onglet Skin>Aff. barres, cliquez sur la barre Hors combat \n" ..
                                          "     et r\195\169glez l'opacit\195\169 \195\160 0 \n" ..
                                          "6: Onglet Skin>G\195\169n\195\169ral, cliquez sur la barre Arri\195\168re plan \n" ..
                                          "     et r\195\169glez l'opacit\195\169 \195\160 0 \n" ..
                                          "7: Onglet Gu\195\169rison, Cochez Afficher les d\195\169buffs",
                                  [8]   = "Oui \n\n"..
                                          "1: Onglet Skin>Barres, \n" ..
                                          "          Mettre les Soins entrants sur 'Ne pas montrer' \n" ..
                                          "2: Onglet Skin>Aff. barres, \n" ..
                                          "          R\195\169gler Afficher la vie \195\160 Sans les soins entrants",
                                  [9]   = "Probl\195\168me pr\195\169sent depuis la version 3.2 de WoW, \n" ..
                                          "cela peut affecter des personnages ayant des caract\195\168res\n" ..
                                          "bizarres dans leur nom \n\n" ..
                                          "Sur Vista ou Win7, essayez cette solution : \n\n"..
                                          "     Dans Panneau de configuration > R\195\169gion et Langue\n"..
                                          "      > Administration > Langue pour les programmes non-unicode \n\n"..
                                          "     Mettre les param\195\168tres r\195\169gionaux \195\160 Anglais \n",
                                  [10]   = "Onglet Sorts : Cocher Tjrs util. cfg. \'en combat\' \n\n" ..
                                          "Si vous voulez r\195\169gler le niveau d'alerte \195\160 100 \n" ..
                                          "Cela peu \195\170tre fait dans l'onglet Skin>Soins>Niveau d'alerte",
                                  [11]  = "D\195\169sactivation pour un personnage : \n\n" ..       
                                          "     1: Onglet G\195\169n\195\169ral\n" ..
                                          "     2: Cocher D\195\169sactiver Healbot\n\n\n" ..
                                          "D\195\169sactivation quand on joue en solo: \n\n" ..
                                          "     1: Onglet G\195\169n\195\169ral \n" ..
                                          "     2: A droite de D\195\169sactiver Healbot, cochez Seulement en solo \n"..
                                          "     3: Cocher D\195\169sactiver Healbot\n",
                                  [12]  = "Changez les r\195\169glages de l'ancre des barres \n" ..
                                          "dans l'onglet Skin>G\195\169n\195\169ral \n\n" ..
                                          "     Haut \195\160 droite:    les barres vont cro\195\174tre vers le bas \195\160 gauche \n" ..
                                          "     Haut \195\160 gauche:  les barres vont cro\195\174tre vers le bas \195\160 droite \n" ..
                                          "     Bas \195\160 droite:      les barres vont cro\195\174tre vers le haut \195\160 gauche \n" ..
                                          "     Bas \195\160 gauche:    les barres vont cro\195\174tre vers le haut \195\160 droite",
                                  [13]  = "Mes cibles permet de cr\195\169er une liste de cibles qui sera \n" ..
                                          "regroup\195\169e s\195\169par\195\169ment des autres, comme le groupe de MT \n\n" ..
                                          "Les options suivantes sont disponibles pour \n" .. 
                                          "ajouter/enlever des personnages du groupe Mes cibles : \n\n" ..
                                          "- Shift+Ctrl+Alt+Clic droit sur la barre \n" ..
                                          "- Utilisez le menu Healbot, entrez 'menuHB' dans l'onglet Sorts \n" ..
                                          "- Utilisez la roue de souris, r\195\169glages dans l'onglet Roue de souris",
                                  [14]  = "Des 'Tanks perso' peuvent \195\170tre ajout\195\169s \195\160 la liste des Main Tanks, \n" ..
                                          "ces tanks ne sont visibles que dans votre Healbot \n" ..
                                          "et n'affectent pas les autres joueurs ou addons. \n\n" ..
                                          "Options disponibles pour ajouter/enlever \n" ..
                                          "des personnages de la liste des tanks : \n\n" ..
                                          "- Utilisez le menu Healbot, entrez 'menuHB' dans l'onglet Sorts \n" ..
                                          "- Utilisez la roue de souris, r\195\169glages dans l'onglet Roue de souris",
                                  
                                  [15]  = "Oui \n\n"..
                                          "     1: Onglet Skin>Soins, cochez Focus \n" ..
                                          "     2: R\195\169glez votre focus sur le PNJ (ou un PJ hors du groupe/raid) \n" ..
                                          "         Healbot va cr\195\169er une barre dans 'Mes cibles' \n\n" ..
                                          "Nota: Si vous changez de focus en situation de combat la barre \n" ..
                                          "          risque de dispara\195\174tre. Solution : \n" ..
                                          "          dans l'onglet Skin>Soins cochez Focus: toujours montrer, \n" ..
                                          "          cela gardera la barre affich\195\169e pendant le combat. \n\n" ..
                                          "Nota: Le menu HealBot a une option 'R\195\169gler le Focus Healbot' \n" ..
                                          "          Cela permet un r\195\169glage facile du focus sur un PNJ \n" ..
                                          "          et sert de rappel au r\195\169glage du focus. \n\n" ..
                                          "          Pour utiliser le menu HealBot : \n"..
                                                                                  "              Entrez 'menuHB' dans l'onglet Sorts  \n" ..
                                          "              ou r\195\169glez cela dans l'onglet Roue de souris",
                                  [16]  = "1:  Onglet Skin>Barres, \n" ..
                                                                                  "          ajustez 'Opacit\195\169 des joueurs hors d\'atteinte' \n" ..
                                          "2:  Onglet Skin>Aff. Barres, ajustez l'opacit\195\169 du texte \n" ..
                                          "       pour cela cliquez sur la barre 'Hors combat'. \n\n" ..
                                          "Si vous voulez r\195\169gler le niveau d'alerte \195\160 100 \n" ..
                                          "Cela peu \195\170tre fait dans l'onglet Skin>Soins>Niveau d'alerte",
                                  [17]  = "Healbot lance exactement les sorts d\195\169finis. \n\n" .. HEALBOT_ABOUT_FAQ_SPELLS_ANSWER01,
                                  [18]  = HEALBOT_ABOUT_FAQ_SPELLS_ANSWER01,
                              }

    HEALBOT_OPTIONS_SKINAUTHOR              = "Auteur du Skin :"
    HEALBOT_OPTIONS_AVOIDBLUECURSOR         = "Eviter\nCurseur bleu"
    HEALBOT_PLAYER_OF_REALM                 = "de"
    
    HEALBOT_OPTIONS_LANG                    = "Langue"
    HEALBOT_OPTIONS_LANG_ZHCN               = "Chinois (zhCN)"
    HEALBOT_OPTIONS_LANG_DEDE               = "Allemand (deDE)"
    HEALBOT_OPTIONS_LANG_ENUK               = "Anglais (enUK)"
    HEALBOT_OPTIONS_LANG_ENUS               = "Anglais (enUS)"
    HEALBOT_OPTIONS_LANG_ESES               = "Espagnol (esES)"
    HEALBOT_OPTIONS_LANG_FRFR               = "Fran\195\167ais (frFR)"
    HEALBOT_OPTIONS_LANG_HUHU               = "Hongrois (huHU)"
    HEALBOT_OPTIONS_LANG_ITIT               = "Italien (itIT)"
    HEALBOT_OPTIONS_LANG_KRKR               = "Kor\195\169en (krKR)"
    HEALBOT_OPTIONS_LANG_PTBR               = "Portugais (ptBR)"
    HEALBOT_OPTIONS_LANG_RURU               = "Russe (ruRU)"
    HEALBOT_OPTIONS_LANG_TWTW               = "Ta\195\175wanais (twTW)"
    
    HEALBOT_OPTIONS_LANG_ADDON_FAIL1        = "Echec du chargement de l\'addon de traduction"
    HEALBOT_OPTIONS_LANG_ADDON_FAIL2        = "Raison de l\'\195\169chec :"
    HEALBOT_OPTIONS_LANG_ADDON_FAIL3        = "Note de la version actuelle, c\'est le seul avertissement pour"
    
    HEALBOT_OPTIONS_ADDON_FAIL              = "Echec de chargement de Healbot"
    
    HEALBOT_OPTIONS_IN_A_GROUP              = "Seulement en groupe ou en raid"
    
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
    
    HEALBOT_SKIN_ABSORBCOL_TEXT             = "Effets d'absorption";
    HEALBOT_OPTIONS_BARALPHAABSORB          = "Opacit\195\169  des effets d'absorption";
    HEALBOT_OPTIONS_OUTLINE                 = "Contour"
    HEALBOT_OPTIONS_FRAME                   = "Cadre"
    HEALBOT_OPTION_NUMHEALERS               = "Nombre de soigneurs"
    HEALBOT_OPTIONS_CONTENT_SKINS_FRAMES    = "    " .. "Cadres"
    HEALBOT_OPTIONS_FRAMESOPTTEXT           = "Options  de cadres"
    HEALBOT_OPTIONS_SETTOOLTIP_POSITION     = "Position tooltip"
    HEALBOT_OPTIONS_FRAME_TITLE             = "Titre du cadre"
    HEALBOT_OPTIONS_FRAME_TITLE_SHOW        = "Afficher le titre"
    HEALBOT_OPTIONS_GROW_DIRECTION          = "Sens d\'accroissement"
    HEALBOT_OPTIONS_BARSORIENTATION         = "Orientation de la barre"
    HEALBOT_OPTIONS_GROW_HORIZONTAL         = "Horizontal"
    HEALBOT_OPTIONS_GROW_VERTICAL           = "Vertical"
    HEALBOT_OPTIONS_FONT_OFFSET             = "Offset police"
    HEALBOT_OPTIONS_SET_FRAME_HEALGROUPS    = "Assigner les groupes de soins"
    HEALBOT_OPTION_EXCLUDEMOUNT_ON          = "Exclure le monture maintenant"
    HEALBOT_OPTION_EXCLUDEMOUNT_OFF         = "Ne plus exclure la monture"
    HEALBOT_CMD_TOGGLEEXCLUDEMOUNT          = "Bascule 'Exclure la monture'"
    HEALBOT_OPTIONS_HIDEMINIBOSSFRAMES      = "Masquer les portraits des mini boss";
    HEALBOT_OPTIONS_HIDERAIDFRAMES          = "Masquer les portraits de raid";
    HEALBOT_OPTIONS_FRAME_ALIAS             = "Alias"
    HEALBOT_OPTIONS_CONTENT_SKINS_HEALGROUP = "        " .. "Groupes de soins"
    HEALBOT_OPTIONS_CONTENT_SKINS_BARCOLOUR = "        " .. "Couleur des barres";
    HEALBOT_OPTIONS_SET_ALL_FRAMES          = "Appliquer ces r\195\169glages \195\160 tous les cadres"
    HEALBOT_WORDS_PROFILE                   = "Profil";
    HEALBOT_SHARE_SCREENSHOT                = "Copie d'\195\169cran faite"
    HEALBOT_SHARE_INSTRUCTION               = "Allez sur le site internet pour les instructions de partage : "..HEALBOT_ABOUT_URL
    HEALBOT_ENEMY_SHOW_BARS                 = "Afficher des barres pour les ennemis"
    HEALBOT_ENEMY_USE_FRAME                 = "Utiliser le cadre"
    HEALBOT_ENEMY_INCLUDE_SELF              = "Inclure ma cible"
    HEALBOT_ENEMY_INCLUDE_TANKS             = "Inclure les cibles des tanks"
    HEALBOT_OPTIONS_ENEMY_OPT               = "Options pour les ennemis";
    HEALBOT_OPTIONS_SHARE_OPT               = "Partage des options";
    HEALBOT_OPTIONS_CONTENT_SKINS_SHARE     = "    " .. "Partager"
    HEALBOT_OPTIONS_CONTENT_SKINS_ENEMY     = "    " .. "Ennemi"
    HEALBOT_OPTIONS_BUTTONLOADSKIN          = "Charger skin"
    HEALBOT_ENEMY_NO_TARGET                 = "Pas de cible"
    HEALBOT_OPTIONS_ENEMYBARS               = "Barres des ennemis"
	HEALBOT_OPTIONS_HARMFUL_SPELLS          = "Sorts de d\195\169g\195\162ts"
	HEALBOT_ENEMY_INCLUDE_MYTARGETS         = "Inclure la cible de ma cible"
	HEALBOT_ENEMY_NUMBER_BOSSES             = "Nombre de boss"
	HEALBOT_ENEMY_HIDE_OUTOFCOMBAT          = "Cacher les barres hors combat"
	HEALBOT_ENEMY_EXISTS_SHOW               = "N\'afficher que si l\'unit\195\169".."\n".."existe au d\195\169but du combat"
	HEALBOT_ENEMY_EXISTS_SHOW_PTARGETS      = "Barres des cibles"
	HEALBOT_ENEMY_EXISTS_SHOW_BOSSES        = "Barres des boss"
    HEALBOT_OPTIONS_TARGET_ONLY_FRIEND      = "Cible : Uniquement si amicale"
    HEALBOT_OPTIONS_FOCUS_ONLY_FRIEND       = "Focus : Uniquement si amicale"
    HEALBOT_OPTIONS_PROFILE                 = "Profil pour".."\n".."Sorts/Buffs/Debuffs"
    HEALBOT_OPTIONS_PROFILE_CHARACTER       = "Personnage"
    HEALBOT_OPTIONS_PROFILE_CLASS           = "Classe"
    HEALBOT_OPTIONS_INCOMBATALERTLEVEL      = "Niveau d\'alerte - En combat";
    HEALBOT_OPTIONS_OUTCOMBATALERTLEVEL     = "Niveau d\'alerte - Hors combat";
    HEALBOT_OPTION_NUMENEMYS                = "Nombre d\'ennemis"
    HEALBOT_WORD_AUTO                       = "Auto"
	HEALBOT_OPTIONS_ENABLEAUTOCOMBAT        = "Activer autoCombat HealBot"
    HEALBOT_WORDS_CUSTOMNAME                = "Nom personnalis\195\169"
    HEALBOT_WORDS_REMOVETEMPCUSTOMNAME      = "Enlever le nom perso. temporaire"
    HEALBOT_WORDS_REMOVEPERMCUSTOMNAME      = "Enlever le nom perso. permanent"
    HEALBOT_WORDS_ADDTEMPCUSTOMNAME         = "Ajouter un nom perso. temporaire"
    HEALBOT_WORDS_ADDPERMCUSTOMNAME         = "Ajouter un nom perso. permanent"
    HEALBOT_OPTIONS_ENABLELIBUTF8           = "Activer caract\195\168res UTF8"
    HEALBOT_OPTIONS_SHOWDIRECTION           = "Indiquer la direction hors d'atteinte";
    HEALBOT_OPTIONS_SHOWDIRECTIONMOUSE      = "Seulement au passage de la souris"
    --HEALBOT_OPTIONS_SHOWDIRECTIONARROWCOL   = "Couleur de la fl\195\168che"
    HEALBOT_LDB_LEFT_TOOLTIP                = "|cffffff00 Clic gauche :|r Panneau d\'options HealBot";
    HEALBOT_LDB_SHIFTLEFT_TOOLTIP           = "|cffffff00 Shift-Clic gauche :|r Skin suivant";
    HEALBOT_LDB_RIGHT_TOOLTIP               = "|cffffff00 Clic droit :|r Reset HealBot";
    HEALBOT_LDB_SHIFTRIGHT_TOOLTIP          = "|cffffff00 Shift-Clic droit :|r HealBot On/Off";
    HEALBOT_WORD_PETBATTLE                  = "Combat de mascottes"
    HEALBOT_ENEMY_INCLUDE_ARENA             = "Inclure les opposants d\'ar\195\170ne"
    HEALBOT_ENEMY_INCLUDE_ARENAPETS         = "Inclure les familiers"
    HEALBOT_ENEMY_EXISTS_SHOW_ARENA         = "Barres des adversaires en ar\195\170ne"
end

if (GetLocale() == "frFR") then
    HealBot_Lang_frFR()
end
