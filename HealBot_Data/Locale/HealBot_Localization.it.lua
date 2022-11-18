-- Italian translator required

-------------
-- ITALIAN --
-------------
--
--
--
--

function HealBot_Lang_itIT()

    -----------------
    -- Translation --
    -----------------

    -- Class
    HEALBOT_DRUID                           = "Druido";
    HEALBOT_HUNTER                          = "Cacciatore";
    HEALBOT_MAGE                            = "Mago";
    HEALBOT_PALADIN                         = "Paladino";
    HEALBOT_PRIEST                          = "Sacerdote";
    HEALBOT_ROGUE                           = "Ladro";
    HEALBOT_SHAMAN                          = "Sciamano";
    HEALBOT_WARLOCK                         = "Stregone";
    HEALBOT_WARRIOR                         = "Guerriero";
    HEALBOT_DEATHKNIGHT                     = "Cavaliere della Morte";
    HEALBOT_MONK                            = "Monaco";

    HEALBOT_DISEASE                         = "Malattia";
    HEALBOT_MAGIC                           = "Magia";
    HEALBOT_CURSE                           = "Maledizione";
    HEALBOT_POISON                          = "Veleno";

    HB_TOOLTIP_OFFLINE                      = "connesso";
    HB_OFFLINE                              = "disconnesso"; -- has gone offline msg
    HB_ONLINE                               = "connesso"; -- has come online msg

    HEALBOT_LOADED                          = " caricato.";

    HEALBOT_ACTION_OPTIONS                  = "Opzioni";

    HEALBOT_OPTIONS_TITLE                   = HEALBOT_ADDON;
    HEALBOT_OPTIONS_DEFAULTS                = "Predefinite";
    HEALBOT_OPTIONS_CLOSE                   = "Chiudi";
    HEALBOT_OPTIONS_HARDRESET               = "RicaricaUI"
    HEALBOT_OPTIONS_SOFTRESET               = "ResettaHB"
    HEALBOT_OPTIONS_TAB_GENERAL             = "Generale";
    HEALBOT_OPTIONS_TAB_SPELLS              = "Incantesimi";
    HEALBOT_OPTIONS_TAB_HEALING             = "Cura";
    HEALBOT_OPTIONS_TAB_BUFFS               = "Benefici";

    HEALBOT_OPTIONS_BARALPHA                = "Opacità abilitato";
    HEALBOT_OPTIONS_BARALPHAINHEAL          = "Opacità cure ricevute";
    HEALBOT_OPTIONS_BARALPHABACK            = "Opacità sfondo barre";
    HEALBOT_OPTIONS_BARALPHAEOR             = "Opacità fuori range";
    HEALBOT_OPTIONS_ACTIONLOCKED            = "Blocca in posizione";
    HEALBOT_OPTIONS_AUTOSHOW                = "Chiudi automaticamente";
    HEALBOT_OPTIONS_PANELSOUNDS             = "Riproduci suono all'apertura";
    HEALBOT_OPTIONS_HIDEOPTIONS             = "Nascondi pulsante Opzioni";
    HEALBOT_OPTIONS_PROTECTPVP              = "Previeni attivazione PvP";
    HEALBOT_OPTIONS_HEAL_CHATOPT            = "Opzioni della Chat";

    HEALBOT_OPTIONS_FRAMESCALE              = "Dimensione frame"
    HEALBOT_OPTIONS_SKINHEIGHT              = "Altezza"
    HEALBOT_OPTIONS_SKINWIDTH               = "Larghezza"
    HEALBOT_OPTIONS_SKINNUMCOLS             = "Nr. colonne"
    HEALBOT_OPTIONS_SKINNUMHCOLS            = "Nr. gruppi per colonna"
    HEALBOT_OPTIONS_SKINBRSPACE             = "Spaziatura righe"
    HEALBOT_OPTIONS_SKINBCSPACE             = "Spaziatura colonne"
    HEALBOT_OPTIONS_EXTRASORT               = "Metodo Ordinamento barre in Incursione"
    HEALBOT_SORTBY_NAME                     = "Nome"
    HEALBOT_SORTBY_CLASS                    = "Classe"
    HEALBOT_SORTBY_GROUP                    = "Gruppo"
    HEALBOT_SORTBY_MAXHEALTH                = "Salute massima"
    HEALBOT_OPTIONS_NEWDEBUFFTEXT           = "Nuovo debuff"
    HEALBOT_OPTIONS_DELSKIN                 = "Cancella"
    HEALBOT_OPTIONS_NEWSKINTEXT             = "Nuova skin"
    HEALBOT_OPTIONS_SAVESKIN                = "Salva"
    HEALBOT_OPTIONS_SKINBARS                = "Opzioni barre"
    HEALBOT_SKIN_ENTEXT                     = "Abilitato"
    HEALBOT_SKIN_DISTEXT                    = "Disabilitato"
    HEALBOT_SKIN_DEBTEXT                    = "Penalità"
    HEALBOT_SKIN_BACKTEXT                   = "Sfondo"
    HEALBOT_SKIN_BORDERTEXT                 = "Bordo"
    HEALBOT_OPTIONS_SKINFHEIGHT             = "Dimensione font"
    HEALBOT_OPTIONS_BARALPHADIS             = "Opacità disabilitato"
    HEALBOT_OPTIONS_SHOWHEADERS             = "Mostra intestazioni"

    HEALBOT_OPTIONS_ITEMS                   = "Oggetti";

    HEALBOT_OPTIONS_COMBOCLASS              = "Combinazione tasti per";
    HEALBOT_OPTIONS_CLICK                   = "Click";
    HEALBOT_OPTIONS_SHIFT                   = "Maiusc";
    HEALBOT_OPTIONS_CTRL                    = "Ctrl";
    HEALBOT_OPTIONS_ENABLEHEALTHY           = "Usa sempre barre abilitate";

    HEALBOT_OPTIONS_CASTNOTIFY1             = "Nessun messaggio";
    HEALBOT_OPTIONS_CASTNOTIFY2             = "Notifica a te stesso";
    HEALBOT_OPTIONS_CASTNOTIFY3             = "Notifica al bersaglio";
    HEALBOT_OPTIONS_CASTNOTIFY4             = "Notifica al gruppo";
    HEALBOT_OPTIONS_CASTNOTIFY5             = "Notifica all'incursione";
    HEALBOT_OPTIONS_CASTNOTIFY6             = "Notifica nel canale";
    HEALBOT_OPTIONS_CASTNOTIFYRESONLY       = "Notifica solo le resurrezioni";

    HEALBOT_OPTIONS_CDCBARS                 = "Colori barre";
    HEALBOT_OPTIONS_CDCSHOWHBARS            = "Cambia colore barra salute";
    HEALBOT_OPTIONS_CDCSHOWABARS            = "Cambia colore barra aggro";
    HEALBOT_OPTIONS_CDCWARNINGS             = "Avvisi debuff";
    HEALBOT_OPTIONS_SHOWDEBUFFICON          = "Mostra debuff";
    HEALBOT_OPTIONS_SHOWDEBUFFWARNING       = "Mostra avviso per debuff";
    HEALBOT_OPTIONS_SOUNDDEBUFFWARNING      = "Esegui effetto audio per debuff";
    HEALBOT_OPTIONS_SOUND                   = "Effetto audio"

    HEALBOT_OPTIONS_HEAL_BUTTONS            = "Barre della salute";
    HEALBOT_OPTIONS_SELFHEALS               = "Te stesso"
    HEALBOT_OPTIONS_PETHEALS                = "Famigli"
    HEALBOT_OPTIONS_GROUPHEALS              = "Gruppo";
    HEALBOT_OPTIONS_TANKHEALS               = "Difensori principali";
    HEALBOT_OPTIONS_MAINASSIST              = "Assistente principale";
    HEALBOT_OPTIONS_PRIVATETANKS            = "Difensori principali personali";
    HEALBOT_OPTIONS_TARGETHEALS             = "Bersagli";
    HEALBOT_OPTIONS_EMERGENCYHEALS          = "Incursione";
    HEALBOT_OPTIONS_ALERTLEVEL              = "Livello di allerta";
    HEALBOT_OPTIONS_EMERGFILTER             = "Mostra barre incursione per";
    HEALBOT_OPTIONS_EMERGFCLASS             = "Configura classi per";
    HEALBOT_OPTIONS_COMBOBUTTON             = "Pulsante";
    HEALBOT_OPTIONS_BUTTONLEFT              = "Sinistro";
    HEALBOT_OPTIONS_BUTTONMIDDLE            = "Centrale";
    HEALBOT_OPTIONS_BUTTONRIGHT             = "Destro";
    HEALBOT_OPTIONS_BUTTON4                 = "Pulsante4";
    HEALBOT_OPTIONS_BUTTON5                 = "Pulsante5";
    HEALBOT_OPTIONS_BUTTON6                 = "Pulsante6";
    HEALBOT_OPTIONS_BUTTON7                 = "Pulsante7";
    HEALBOT_OPTIONS_BUTTON8                 = "Pulsante8";
    HEALBOT_OPTIONS_BUTTON9                 = "Pulsante9";
    HEALBOT_OPTIONS_BUTTON10                = "Pulsante10";
    HEALBOT_OPTIONS_BUTTON11                = "Pulsante11";
    HEALBOT_OPTIONS_BUTTON12                = "Pulsante12";
    HEALBOT_OPTIONS_BUTTON13                = "Pulsante13";
    HEALBOT_OPTIONS_BUTTON14                = "Pulsante14";
    HEALBOT_OPTIONS_BUTTON15                = "Pulsante15";

    HEALBOT_CLASSES_ALL                     = "Tutte le classi";
    HEALBOT_CLASSES_MELEE                   = "Assaltatore di mischia";
    HEALBOT_CLASSES_RANGES                  = "Assaltatore di distanza";
    HEALBOT_CLASSES_HEALERS                 = "Guaritori";
    HEALBOT_CLASSES_CUSTOM                  = "Personalizzata";

    HEALBOT_OPTIONS_SHOWTOOLTIP             = "Mostra tooltips";
    HEALBOT_OPTIONS_SHOWDETTOOLTIP          = "Mostra informazioni incantesimo dettagliate";
    HEALBOT_OPTIONS_SHOWCDTOOLTIP           = "Mostra cooldown incantesimo";
    HEALBOT_OPTIONS_SHOWUNITTOOLTIP         = "Mostra info bersaglio";
    HEALBOT_OPTIONS_SHOWRECTOOLTIP          = "Mostra consigli per le HoT";
    HEALBOT_TOOLTIP_POSDEFAULT              = "Posizione predefinita";
    HEALBOT_TOOLTIP_POSLEFT                 = "Alla sinistra di Healbot";
    HEALBOT_TOOLTIP_POSRIGHT                = "Alla destra di Healbot";
    HEALBOT_TOOLTIP_POSABOVE                = "Sopra Healbot";
    HEALBOT_TOOLTIP_POSBELOW                = "Sotto Healbot";
    HEALBOT_TOOLTIP_POSCURSOR               = "Accanto al cursore";
    HEALBOT_TOOLTIP_RECOMMENDTEXT           = "Consiglio per la HoT";
    HEALBOT_TOOLTIP_NONE                    = "nessuna disponibile";
    HEALBOT_TOOLTIP_CORPSE                  = "Corpo di ";
    HEALBOT_TOOLTIP_CD                      = " (CD ";
    HEALBOT_TOOLTIP_SECS                    = "s)";
    HEALBOT_WORDS_SEC                       = "sec";
    HEALBOT_WORDS_CAST                      = "Lancio";
    HEALBOT_WORDS_UNKNOWN                   = "Sconosciuto";
    HEALBOT_WORDS_YES                       = "Si";
    HEALBOT_WORDS_THIN                      = "Sottile";
    HEALBOT_WORDS_THICK                     = "Spesso";

    HEALBOT_WORDS_NONE                      = "Nessuno";
    HEALBOT_DISABLED_TARGET                 = "Bersaglio";
    HEALBOT_OPTIONS_SHOWCLASSONBAR          = "Mostra classe sulla barra";
    HEALBOT_OPTIONS_SHOWHEALTHONBAR         = "Mostra salute sulla barra";
    HEALBOT_OPTIONS_BARHEALTHINCHEALS       = "Includi cure ricevute";
    HEALBOT_OPTIONS_BARHEALTHSEPHEALS       = "Separa cure ricevute";
    HEALBOT_OPTIONS_BARHEALTH1              = "come delta";
    HEALBOT_OPTIONS_BARHEALTH2              = "come percentuale";
    HEALBOT_OPTIONS_TIPTEXT                 = "Impostazioni Tooltip";
    HEALBOT_OPTIONS_POSTOOLTIP              = "Posizione del tooltip";
    HEALBOT_OPTIONS_SHOWNAMEONBAR           = "Mostra nome sulla barra";
    HEALBOT_OPTIONS_BARTEXTCLASSCOLOUR1     = "Colore testo in base alla classe";
    HEALBOT_OPTIONS_EMERGFILTERGROUPS       = "Includi gruppi incursione";

    HEALBOT_OPTIONS_SETDEFAULTS             = "Imposta predefinite";
    HEALBOT_OPTIONS_SETDEFAULTSMSG          = "Resetta le opzioni ai valori predefiniti";
    HEALBOT_OPTIONS_RIGHTBOPTIONS           = "Tasto destro apre finestra opzioni";

    HEALBOT_OPTIONS_HEADEROPTTEXT           = "Opzioni intestazioni";
    HEALBOT_OPTIONS_ICONOPTTEXT             = "Opzioni icone";
    HEALBOT_SKIN_HEADERBARCOL               = "Colore barra";
    HEALBOT_SKIN_HEADERTEXTCOL              = "Colore testo";
    HEALBOT_OPTIONS_BUFFSTEXT1              = "Incantesimo per buffare";
    HEALBOT_OPTIONS_BUFFSTEXT2              = "controlla membri";
    HEALBOT_OPTIONS_BUFFSTEXT3              = "Colori barra";
    HEALBOT_OPTIONS_BUFF                    = "Benifici ";
    HEALBOT_OPTIONS_BUFFSELF                = "su se stessi";
    HEALBOT_OPTIONS_BUFFPARTY               = "sul gruppo";
    HEALBOT_OPTIONS_BUFFRAID                = "sull'incursione";
    HEALBOT_OPTIONS_MONITORBUFFS            = "Monìtora per buff mancanti";
    HEALBOT_OPTIONS_MONITORBUFFSC           = "anche in combattimento";
    HEALBOT_OPTIONS_ENABLESMARTCAST         = "SmartCast fuori dal combattimento";
    HEALBOT_OPTIONS_SMARTCASTSPELLS         = "Incantesimi inclusi";
    HEALBOT_OPTIONS_SMARTCASTDISPELL        = "Rimozione debuff";
    HEALBOT_OPTIONS_SMARTCASTBUFF           = "Applicazione buff";
    HEALBOT_OPTIONS_SMARTCASTHEAL           = "Incantesimi di cura";
    HEALBOT_OPTIONS_BAR2SIZE                = "Dimensione barra potere";
    HEALBOT_OPTIONS_SETSPELLS               = "Imposta spell per";
    HEALBOT_OPTIONS_ENABLEDBARS             = "Barre abilitate sempre";
    HEALBOT_OPTIONS_DISABLEDBARS            = "Barre disabilitate quando fuori dal combattimento";
    HEALBOT_OPTIONS_MONITORDEBUFFS          = "Monìtora per rimuovere debuff";
    HEALBOT_OPTIONS_DEBUFFTEXT1             = "Incantesimo per rimuovere debuff";

    HEALBOT_OPTIONS_IGNOREDEBUFF            = "Debuff da ignorare:";
    HEALBOT_OPTIONS_IGNOREDEBUFFCLASS       = "Per classe";
    HEALBOT_OPTIONS_IGNOREDEBUFFMOVEMENT    = "Rallentamento";
    HEALBOT_OPTIONS_IGNOREDEBUFFDURATION    = "Breve durata";
    HEALBOT_OPTIONS_IGNOREDEBUFFNOHARM      = "Non dannoso";
    HEALBOT_OPTIONS_IGNOREDEBUFFCOOLDOWN    = "Quando l'incantesimo di rimozione ha CoolDown > 1.5 secs (GCD)";
    HEALBOT_OPTIONS_IGNOREDEBUFFFRIEND      = "Quando il caster è amichevole";

    HEALBOT_OPTIONS_RANGECHECKFREQ          = "Frequenza di controllo Distanza, Aura e Aggro";

    HEALBOT_OPTIONS_HIDEPARTYFRAMES         = "Nascondi frame del gruppo";
    HEALBOT_OPTIONS_HIDEPLAYERTARGET        = "Includi te stesso e bersaglio";
    HEALBOT_OPTIONS_DISABLEHEALBOT          = "Disabilita HealBot";

    HEALBOT_ASSIST                          = "Assistere";
    HEALBOT_FOCUS                           = "Fokus";
    HEALBOT_MENU                            = "Menù";
    HEALBOT_MAINTANK                        = "Difensore principale";
    HEALBOT_MAINASSIST                      = "Assistente principale";
    HEALBOT_TELL                            = "Sussurra";

    HEALBOT_OPTIONS_SHOWMINIMAPBUTTON       = "Mostra pulsante sulla minimappa";
    HEALBOT_OPTIONS_BARBUTTONSHOWHOT        = "Mostra HoT";
    HEALBOT_OPTIONS_BARBUTTONSHOWRAIDICON   = "Mostra icone Raid";
    HEALBOT_OPTIONS_HOTONBAR                = "Sulla barra";
    HEALBOT_OPTIONS_HOTOFFBAR               = "Fuori barra";
    HEALBOT_OPTIONS_HOTBARRIGHT             = "A destra";
    HEALBOT_OPTIONS_HOTBARLEFT              = "A sinistra";

    HEALBOT_ZONE_AB                         = "Bacino d'Arathi";
    HEALBOT_ZONE_AV                         = "Valle d'Alterac";
    HEALBOT_ZONE_ES                         = "Occhio del Ciclone";
    HEALBOT_ZONE_IC                         = "Isola della Conquista";
    HEALBOT_ZONE_SA                         = "Lido degli Antichi";

    HEALBOT_OPTION_AGGROTRACK               = "Monìtora Aggro"
    HEALBOT_OPTION_AGGROBAR                 = "Barra"
    HEALBOT_OPTION_AGGROTXT                 = ">> Testo <<"
    HEALBOT_OPTION_AGGROIND                 = "Indicatore"
    HEALBOT_OPTION_BARUPDFREQ               = "Moltiplicatore di aggiornamento"
    HEALBOT_OPTION_CPUPROFILE               = "Usa CPU profiler (Info su quanto gli Addon usano la CPU)"
    HEALBOT_OPTIONS_RELOADUIMSG             = "Questa opzione richiede di ricaricare la UI, Ricaricare adesso?"

    HEALBOT_BUFF_PVP                        = "PvP"
    HEALBOT_BUFF_PVE						= "PvE"
    HEALBOT_OPTIONS_ANCHOR                  = "Ancoraggio riquadro"
    HEALBOT_OPTIONS_BARSANCHOR              = "Ancoraggio Barre"
    HEALBOT_OPTIONS_TOPLEFT                 = "In alto a sinistra"
    HEALBOT_OPTIONS_BOTTOMLEFT              = "In basso a sinistra"
    HEALBOT_OPTIONS_TOPRIGHT                = "In alto a destra"
    HEALBOT_OPTIONS_BOTTOMRIGHT             = "In basso a destra"
    HEALBOT_OPTIONS_TOP                     = "In alto"
    HEALBOT_OPTIONS_BOTTOM                  = "In basso"

    HEALBOT_PANEL_BLACKLIST                 = "BlackList"

    HEALBOT_WORDS_REMOVEFROM                = "Rimuovi da";
    HEALBOT_WORDS_ADDTO                     = "Aggiungi a";
    HEALBOT_WORDS_INCLUDE                   = "Includi";

    HEALBOT_OPTIONS_TTALPHA                 = "Opacità"
    HEALBOT_TOOLTIP_TARGETBAR               = "Barra bersaglio"
    HEALBOT_OPTIONS_MYTARGET                = "Miei bersagli"

    HEALBOT_DISCONNECTED_TEXT               = "<DC>"
    HEALBOT_OPTIONS_SHOWUNITBUFFTIME        = "Mostra i miei buff";
    HEALBOT_OPTIONS_TOOLTIPUPDATE           = "Aggiorna costantemente";
    HEALBOT_OPTIONS_BUFFSTEXTTIMER          = "Mostra buff prima che scada";
    HEALBOT_OPTIONS_SHORTBUFFTIMER          = "Buff brevi"
    HEALBOT_OPTIONS_LONGBUFFTIMER           = "Buff lunghi"

    HEALBOT_OPTIONS_NOTIFY_MSG              = "Messaggio"
    HEALBOT_WORDS_YOU                       = "tu";
    HEALBOT_NOTIFYOTHERMSG                  = "Lanciando #s su #n";

    HEALBOT_OPTIONS_HOTPOSITION             = "Posizione icona"
    HEALBOT_OPTIONS_HOTSHOWTEXT             = "Mostra testo icona"
    HEALBOT_OPTIONS_HOTTEXTCOUNT            = "Conteggio"
    HEALBOT_OPTIONS_HOTTEXTDURATION         = "Durata"
    HEALBOT_OPTIONS_ICONSCALE               = "Dimensione icona"
    HEALBOT_OPTIONS_ICONTEXTSCALE           = "Dimensione testo icona"

    HEALBOT_OPTIONS_AGGROBARSIZE            = "Dimensione barra Aggro"
    HEALBOT_OPTIONS_DOUBLETEXTLINES         = "Raddoppia le righe di testo"
    HEALBOT_OPTIONS_TEXTALIGNMENT           = "Allineamento testo"
    HEALBOT_VEHICLE                         = "Veicolo"
    HEALBOT_WORDS_ERROR                     = "Errore"
    HEALBOT_SPELL_NOT_FOUND	                = "Incantesimo non trovato"
    HEALBOT_OPTIONS_DISABLETOOLTIPINCOMBAT  = "Nacondi Tooltip in Combattimento"
    HEALBOT_OPTIONS_ENABLELIBQH             = "Abilita fastHealth di HealBot"

    HEALBOT_OPTIONS_BUFFNAMED               = "Inserisci i nomi dei personaggi da controllare per\n\n"
    HEALBOT_WORD_ALWAYS                     = "Sempre";
    HEALBOT_WORD_SOLO                       = "Solo";
    HEALBOT_WORD_NEVER                      = "Mai";
    HEALBOT_SHOW_CLASS_AS_ICON              = "come icona";
    HEALBOT_SHOW_CLASS_AS_TEXT              = "come testo";
    HEALBOT_SHOW_ROLE                       = "Mostra ruolo se impostato";

    HEALBOT_SHOW_INCHEALS                   = "Mostra cure ricevute";

    HEALBOT_HELP={ [1] = "[HealBot] /hb h -- Mostra aiuti",
                   [2] = "[HealBot] /hb o -- Apri/chiudi Opzioni",
                   [3] = "[HealBot] /hb ri -- Resetta HealBot",
                   [4] = "[HealBot] /hb t -- Abilita/Disabilita Healbot",
                   [5] = "[HealBot] /hb bt -- Abilita/Disabilita il Buff Monitor",
                   [6] = "[HealBot] /hb dt -- Abilita/Disabilita il Debuff Monitor",
                   [7] = "[HealBot] /hb skin <skinName> -- Cambia Skin in quella indicata",
                   [8] = "[HealBot] /hb ui -- Ricarica UI",
                   [9] = "[HealBot] /hb hs -- Mostra comandi slash aggiuntivi",
                  }

    HEALBOT_HELP2={ [1] = "[HealBot] /hb d -- Resetta le opzioni a quelle predefinite",
                    [2] = "[HealBot] /hb aggro 2 <n> -- Imposta il livello aggro 2 per la percentuale di threat <n>",
                    [3] = "[HealBot] /hb aggro 3 <n> -- Imposta il livello aggro 3 per la percentuale di threat <n>",
                    [4] = "[HealBot] /hb tr <Role> -- Imposta la priorità di ruolo alta in SubSort per Ruolo. Ruoli validi sono 'TANK', 'HEALER' o 'DPS'",
                    [5] = "[HealBot] /hb use10 -- Usa automaticamente lo slot 10 di Ingegneria",
                    [6] = "[HealBot] /hb pcs <n> -- Modifica la dimensione dell'indicatore di carica del Potere Sacro di <n>, Valore predefinito 7 ",
                    [7] = "[HealBot] /hb spt -- Attiva/Disattiva il tuo famiglio",
                    [8] = "[HealBot] /hb ws -- Attiva/Disattiva la possibilità di mostrare/nascondere l'icona Anima Indebolita al posto di quella di PW:S con il -",
                    [9] = "[HealBot] /hb rld <n> -- Imposta (in secondi), quanto a lungo il nome dei personaggi rimane verde dopo una resurrezione",
                    [10] = "[HealBot] /hb flb -- Attiva/Disattiva il bypass del blocco dei frame (i frame si spostano sempre con Ctrl+Alt+Click sinistro)",
                    [11] = "[HealBot] /hb rtb -- Attiva/Disattiva la restrizione per la barra del bersaglio a Sinistro=SmartCast e Destro=aggiungi/rimuovi a/dai Miei Bersagli",
                  }
                  
    HEALBOT_OPTION_HIGHLIGHTACTIVEBAR       = "Evidenzia mouseover"
    HEALBOT_OPTION_HIGHLIGHTTARGETBAR       = "Evidenzia bersaglio"
    HEALBOT_OPTIONS_TESTBARS                = "Barre di Test"
    HEALBOT_OPTION_NUMBARS                  = "Numero di Barre"
    HEALBOT_OPTION_NUMTANKS                 = "Numero di Difensori"
    HEALBOT_OPTION_NUMMYTARGETS             = "Numero di Miei Bersagli"
    HEALBOT_OPTION_NUMPETS                  = "Numero di Famigli"
    HEALBOT_WORD_TEST                       = "Test";
    HEALBOT_WORD_OFF                        = "Off";
    HEALBOT_WORD_ON                         = "On";

    HEALBOT_OPTIONS_TAB_CHAT                = "Chat"
    HEALBOT_OPTIONS_TAB_HEADERS             = "Intestazioni"
    HEALBOT_OPTIONS_TAB_BARS                = "Barre"
    HEALBOT_OPTIONS_TAB_ICONS               = "Icone"
    HEALBOT_OPTIONS_TAB_WARNING             = "Avviso"
    HEALBOT_OPTIONS_SKINDEFAULTFOR          = "Skin predefinita per"
    HEALBOT_OPTIONS_INCHEAL                 = "Cure ricevute"
    HEALBOT_WORD_ARENA                      = "Arena"
    HEALBOT_WORD_BATTLEGROUND               = "Campo di battaglia"
    HEALBOT_OPTIONS_TEXTOPTIONS             = "Opzioni del Testo"
    HEALBOT_WORD_PARTY                      = "Gruppo"
    HEALBOT_OPTIONS_COMBOAUTOTARGET         = "Auto\nTarget"
    HEALBOT_OPTIONS_COMBOAUTOTRINKET        = "Auto Trinket"
    HEALBOT_OPTIONS_GROUPSPERCOLUMN         = "Imposta gruppi in colonne"

    HEALBOT_OPTIONS_MAINSORT                = "Primo ordinamento"
    HEALBOT_OPTIONS_SUBSORT                 = "Sub-ordinamento"
    HEALBOT_OPTIONS_SUBSORTINC              = "Sub-ordina anche:"

    HEALBOT_OPTIONS_BUTTONCASTMETHOD        = "Lancia quando"
    HEALBOT_OPTIONS_BUTTONCASTPRESSED       = "Premuto"
    HEALBOT_OPTIONS_BUTTONCASTRELEASED      = "Rilasciato"

    HEALBOT_WORD_HEALER                     = "Guaritore"
    HEALBOT_WORD_DAMAGER                    = "Assaltatore"
    HEALBOT_WORD_TANK                       = "Difensore"
    HEALBOT_WORD_LEADER                     = "Capo incursione"
    HEALBOT_WORD_VERSION                    = "Versione"

    HEALBOT_WORD_STAR                       = "Stella"
    HEALBOT_WORD_CIRCLE                     = "Cerchio"
    HEALBOT_WORD_DIAMOND                    = "Diamante"
    HEALBOT_WORD_TRIANGLE                   = "Triangolo"
    HEALBOT_WORD_MOON                       = "Luna"
    HEALBOT_WORD_SQUARE                     = "Quadrato"
    HEALBOT_WORD_CROSS                      = "Croce"
    HEALBOT_WORD_SKULL                      = "Teschio"

    HEALBOT_OPTIONS_ACCEPTSKINMSG           = "Accetta Skin di [HealBot]: "
    HEALBOT_OPTIONS_ACCEPTSKINMSGFROM       = " da "
    HEALBOT_OPTIONS_BUTTONSHARESKIN         = "Condividi con"

    HEALBOT_CHAT_NEWVERSION1                = "Una nuova versione è disponibile"
    HEALBOT_CHAT_NEWVERSION2                = "su "..HEALBOT_ABOUT_URL
    HEALBOT_CHAT_SHARESKINERR1              = " Skin da condividere non trovata"
    HEALBOT_CHAT_SHARESKINERR3              = " non trovata per la condivisione Skin"
    HEALBOT_CHAT_SHARESKINACPT              = "Condivisione Skin accettata da "
    HEALBOT_CHAT_CONFIRMSKINDEFAULTS        = "Skin impostate a Predefinite"
    HEALBOT_CHAT_CONFIRMCUSTOMDEFAULTS      = "Reset Debuff personalizzati"
    HEALBOT_CHAT_CHANGESKINERR1             = "Skin sconosciuta: /hb skin "
    HEALBOT_CHAT_CHANGESKINERR2             = "Skin valide:  "
    HEALBOT_CHAT_CONFIRMSPELLCOPY           = "Incantesimo corrente copiato per tutte le spec"
    HEALBOT_CHAT_UNKNOWNCMD                 = "Comando slash sconosciuto: /hb "
    HEALBOT_CHAT_ENABLED                    = "Stato ATTIVATO in attivazione"
    HEALBOT_CHAT_DISABLED                   = "Stato DISATTIVATO in attivazione"
    HEALBOT_CHAT_SOFTRELOAD                 = "Richiesto ricaricamento Healbot"
    HEALBOT_CHAT_HARDRELOAD                 = "Richiesto ricaricamento UI"
    HEALBOT_CHAT_CONFIRMSPELLRESET          = "Incantesimi resettati"
    HEALBOT_CHAT_CONFIRMCURESRESET          = "Dissoluzioni resettate"
    HEALBOT_CHAT_CONFIRMBUFFSRESET          = "Benefici resettati"
    HEALBOT_CHAT_POSSIBLEMISSINGMEDIA       = "Impossibile ricevere le impostazioni delle Skin - Probabilmente manca SharedMedia, scaricalo da curse.com"
    HEALBOT_CHAT_MACROSOUNDON               = "Suono non soppresso quando abilitato auto trinkets"
    HEALBOT_CHAT_MACROSOUNDOFF              = "Suono soppresso quando abilitato auto trinkets"
    HEALBOT_CHAT_MACROERRORON               = "Errori non soppressi quando abilitato auto trinkets"
    HEALBOT_CHAT_MACROERROROFF              = "Errori soppressi quando abilitato auto trinkets"
    HEALBOT_CHAT_ACCEPTSKINON               = "Condivisione Skin - Mostra finestra popup per accettare la skin condivisa da qualcuno con te"
    HEALBOT_CHAT_ACCEPTSKINOFF              = "Condivisione Skin - Ignora sempre condivisione skins da tutti"
    HEALBOT_CHAT_USE10ON                    = "Auto Trinket - Use10 è on - Devi abilitare un auto trinket perché use10 funzioni"
    HEALBOT_CHAT_USE10OFF                   = "Auto Trinket - Use10 è off"
    HEALBOT_CHAT_SKINREC                    = " skin ricevuta da " 

    HEALBOT_OPTIONS_SELFCASTS               = "Solo lancio su se stessi"
    HEALBOT_OPTIONS_HOTSHOWICON             = "Mostra icona"
    HEALBOT_OPTIONS_ALLSPELLS               = "Tutti gli incantesimi"
    HEALBOT_OPTIONS_DOUBLEROW               = "Raddoppia righe"
    HEALBOT_OPTIONS_HOTBELOWBAR             = "Sotto la barra"
    HEALBOT_OPTIONS_OTHERSPELLS             = "Altri incantesimi"
    HEALBOT_WORD_MACROS                     = "Macro"
    HEALBOT_WORD_SELECT                     = "Seleziona"
    HEALBOT_OPTIONS_QUESTION                = "?"
    HEALBOT_WORD_CANCEL                     = "Cancella"
    HEALBOT_WORD_COMMANDS                   = "Comandi"
    HEALBOT_OPTIONS_BARHEALTH3              = "come salute";
    HEALBOT_SORTBY_ROLE                     = "Ruolo"
    HEALBOT_CHAT_TOPROLEERR                 = " ruolo non valido in questo contesto - usa 'TANK', 'DPS' o 'HEALER'"
    HEALBOT_CHAT_NEWTOPROLE                 = "Adesso il massimo ruolo è "
    HEALBOT_CHAT_SUBSORTPLAYER1             = "Il personaggio sarà impostato primo nel SubSort"
    HEALBOT_CHAT_SUBSORTPLAYER2             = "Il personaggio sarà ordinato normalmente nel SubSort"
    HEALBOT_OPTIONS_SHOWREADYCHECK          = "Mostra Appello";
    HEALBOT_OPTIONS_SUBSORTSELFFIRST        = "Se stessi per primi"
    HEALBOT_WORD_FILTER                     = "Filtra"
    HEALBOT_OPTION_AGGROPCTBAR              = "Sposta barra"
    HEALBOT_OPTION_AGGROPCTTXT              = "Mostra testo"
    HEALBOT_OPTION_AGGROPCTTRACK            = "Monìtora percentuale" 
    HEALBOT_OPTIONS_ALERTAGGROLEVEL1        = "1 - Threat basso"
    HEALBOT_OPTIONS_ALERTAGGROLEVEL2        = "2 - Threat alto"
    HEALBOT_OPTIONS_ALERTAGGROLEVEL3        = "3 - Tanking"
    HEALBOT_OPTIONS_AGGROALERT              = "Barra livello allerta"
    HEALBOT_OPTIONS_AGGROINDALERT           = "Indicatore livello allerta"
    HEALBOT_OPTIONS_TOOLTIPSHOWHOT          = "Mostra dettagli HoT attivi monitorati"
    HEALBOT_CHAT_SELFPETSON                 = "Proprio famiglio attivato"
    HEALBOT_CHAT_SELFPETSOFF                = "Proprio famiglio disattivato"
    HEALBOT_WORD_PRIORITY                   = "Priorità"
    HEALBOT_VISIBLE_RANGE                   = "Entro 100 yard"
    HEALBOT_SPELL_RANGE                     = "Entro il range dell'incantesimo"
    HEALBOT_WORD_RESET                      = "Resetta"
    HEALBOT_HBMENU                          = "HBmenu"
    HEALBOT_ACTION_HBFOCUS                  = "Click sinistro per impostare\nil focus sul bersaglio"
    HEALBOT_WORD_CLEAR                      = "Pulisci"
    HEALBOT_WORD_SET                        = "Imposta"
    HEALBOT_WORD_HBFOCUS                    = "HealBot Focus"
    HEALBOT_WORD_OUTSIDE                    = "Esterno"
    HEALBOT_WORD_ALLZONE                    = "Tutte le zone"
    HEALBOT_OPTIONS_TAB_ALERT               = "Allerta"
    HEALBOT_OPTIONS_TAB_SORT                = "Ordina"
    HEALBOT_OPTIONS_TAB_HIDE                = "Nascondi"
    HEALBOT_OPTIONS_TAB_AGGRO               = "Aggro"
    HEALBOT_OPTIONS_TAB_ICONTEXT            = "Testo Icona"
    HEALBOT_OPTIONS_TAB_TEXT                = "Testo Barra"
    HEALBOT_OPTIONS_AGGRO3COL               = "Colore della barra\ndell'Aggro"
    HEALBOT_OPTIONS_AGGROFLASHFREQ          = "Frequenza lampeggiamento"
    HEALBOT_OPTIONS_AGGROFLASHALPHA         = "Opacità lampeggiamento"
    HEALBOT_OPTIONS_SHOWDURATIONFROM        = "Mostra durata da"
    HEALBOT_OPTIONS_SHOWDURATIONWARN        = "Avviso durata da"
    HEALBOT_CMD_RESETCUSTOMDEBUFFS          = "Resetta debuff personalizzati"
    HEALBOT_CMD_RESETSKINS                  = "Resetta skin"
    HEALBOT_CMD_CLEARBLACKLIST              = "Pulisci BlackList"
    HEALBOT_CMD_TOGGLEACCEPTSKINS           = "Attiva/Disattiva accetta Skin dagli altri"
    HEALBOT_CMD_TOGGLEDISLIKEMOUNT          = "Attiva/Disattiva Cavalvatura Sgradita"
    HEALBOT_OPTION_DISLIKEMOUNT_ON          = "Adesso sgradisci la Cavalcatura"
    HEALBOT_OPTION_DISLIKEMOUNT_OFF         = "Non sgradire più la Cavalcatura"
    HEALBOT_CMD_COPYSPELLS                  = "Copia l'incantesimo corrente in tutte le spec"
    HEALBOT_CMD_RESETSPELLS                 = "Resetta incantesimi"
    HEALBOT_CMD_RESETCURES                  = "Resetta dissoluzioni"
    HEALBOT_CMD_RESETBUFFS                  = "Resetta buff"
    HEALBOT_CMD_RESETBARS                   = "Resetta la posizione della barra"
    HEALBOT_CMD_SUPPRESSSOUND               = "Attiva/Disattiva soppressione suono quando auto trinket abilitato"
    HEALBOT_CMD_SUPPRESSERRORS              = "Attiva/Disattiva soppressione errori quando auto trinket abilitato"
    HEALBOT_OPTIONS_COMMANDS                = "Comandi di HealBot"
    HEALBOT_WORD_RUN                        = "Esegui"
    HEALBOT_OPTIONS_MOUSEWHEEL              = "Usa rotellina del mouse"
    HEALBOT_OPTIONS_MOUSEUP                 = "Rotellina su"
    HEALBOT_OPTIONS_MOUSEDOWN               = "Rotellina giù"
    HEALBOT_CMD_DELCUSTOMDEBUFF10           = "Cancella debuff personalizzati con priorità 10"
    HEALBOT_ACCEPTSKINS                     = "Accetta Skin dagli altri"
    HEALBOT_SUPPRESSSOUND                   = "Auto Trinket: Sopprimi suono"
    HEALBOT_SUPPRESSERROR                   = "Auto Trinket: Sopprimi errori"
    HEALBOT_OPTIONS_CRASHPROT               = "Protezione dai Crash"
    HEALBOT_OPTIONS_USEGENERALMACRO         = "Use general macro slots"
    HEALBOT_CP_MACRO_LEN                    = "Il nome della Macro deve avere da 1 a 14 caratteri"
    HEALBOT_CP_MACRO_BASE                   = "Nome Base della macro"
    HEALBOT_CP_MACRO_SAVE                   = "Ultimo salvataggio alle: "
    HEALBOT_CP_STARTTIME                    = "Durata protezione alla connessione"
    HEALBOT_WORD_RESERVED                   = "Riservato"
    HEALBOT_OPTIONS_COMBATPROT              = "Protezione Combattimento"
    HEALBOT_COMBATPROT_PARTYNO              = "Barre Riservate per il Gruppo"
    HEALBOT_COMBATPROT_RAIDNO               = "Barre Riservate per il Raid"

    HEALBOT_WORD_HEALTH                     = "Salute"
    HEALBOT_OPTIONS_DONT_SHOW               = "Non mostrare"
    HEALBOT_OPTIONS_SAME_AS_HLTH_CURRENT    = "Lo stesso della salute (salute attuale)"
    HEALBOT_OPTIONS_SAME_AS_HLTH_FUTURE     = "Lo stesso della salute (salute futura)"
    HEALBOT_OPTIONS_FUTURE_HLTH             = "Salute futura"
    HEALBOT_SKIN_HEALTHBARCOL_TEXT          = "Barra della Salute";
    HEALBOT_SKIN_HEALTHBACKCOL_TEXT         = "Sfondo della barra";
    HEALBOT_SKIN_INCHEALBARCOL_TEXT         = "Cure ricevute";
    HEALBOT_OPTIONS_ALWAYS_SHOW_TARGET      = "Bersaglio: Mostra sempre"
    HEALBOT_OPTIONS_ALWAYS_SHOW_FOCUS       = "Focus: Mostra sempre"
    HEALBOT_OPTIONS_GROUP_PETS_BY_FIVE      = "Famigli: in gruppi di cinque"
    HEALBOT_OPTIONS_USEGAMETOOLTIP          = "Usa il Tooltip del Gioco"
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER        = "Mostra conteggio potere"
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER_PALA   = "Mostra potere sacro"
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER_MONK   = "Mostra potere chi"
    HEALBOT_OPTIONS_CUSTOMDEBUFF_REVDUR     = "Inverti durata"
    HEALBOT_OPTIONS_DISABLEHEALBOTSOLO      = "soltanto quando in solo"
    HEALBOT_OPTIONS_CUSTOM_ALLDISEASE       = "Tutte le Malattie"
    HEALBOT_OPTIONS_CUSTOM_ALLMAGIC         = "Tutte le Magie"
    HEALBOT_OPTIONS_CUSTOM_ALLCURSE         = "Tutte le Maledizioni"
    HEALBOT_OPTIONS_CUSTOM_ALLPOISON        = "Tutti i Veleni"
    HEALBOT_OPTIONS_CUSTOM_CASTBY           = "Lanciato da"

    HEALBOT_BLIZZARD_MENU                   = "Menù Blizzard"
    HEALBOT_HB_MENU                         = "Menù di Healbot"
    HEALBOT_FOLLOW                          = "Segui"
    HEALBOT_TRADE                           = "Commercia"
    HEALBOT_PROMOTE_RA                      = "Promuovi ad assistente"
    HEALBOT_DEMOTE_RA                       = "Degrada ad assistente"
    HEALBOT_TOGGLE_ENABLED                  = "Attiva/Disattiva abilitato"
    HEALBOT_TOGGLE_MYTARGETS                = "Attiva/Disattiva Miei Bersagli"
    HEALBOT_TOGGLE_PRIVATETANKS             = "Attiva/Disattiva Tank personali"
    HEALBOT_RESET_BAR                       = "Resetta barra"
    HEALBOT_HIDE_BARS                       = "Nascondi barre oltre 100 yard"
    HEALBOT_RANDOMMOUNT                     = "Cavalcatura Casuale"
    HEALBOT_RANDOMGOUNDMOUNT                = "Cavalcatura Terrestre Casuale"
    HEALBOT_RANDOMPET                       = "Mascotte Casuale"
    HEALBOT_ZONE_AQ40                       = "Ahn'Qiraj"
    HEALBOT_ZONE_VASHJIR1                   = "Foresta di Kelp'thar"
    HEALBOT_ZONE_VASHJIR2                   = "Distesa Scintillante"
    HEALBOT_ZONE_VASHJIR3                   = "Profondità Abissali"
    HEALBOT_ZONE_VASHJIR                    = "Vashj'ir"
    HEALBOT_RESLAG_INDICATOR                = "Mantieni il nome in verde dopo il res impostato a" 
    HEALBOT_RESLAG_INDICATOR_ERROR          = "Mantieni il nome in verde dopo il res deve essere da 1 a 30" 
    HEALBOT_FRAMELOCK_BYPASS_OFF            = "Bypass del blocco frame disabilitato"
    HEALBOT_FRAMELOCK_BYPASS_ON             = "Bypass del blocco frame (Ctl+Alt+Left) abilitato"
    HEALBOT_RESTRICTTARGETBAR_ON            = "Restrizione barra bersaglio abilitata"
    HEALBOT_RESTRICTTARGETBAR_OFF           = "Restrizione barra bersaglio disabilitata"
    HEALBOT_PRELOADOPTIONS_ON               = "Precaricamento Opzioni abilitato"
    HEALBOT_PRELOADOPTIONS_OFF              = "Precaricamento Opzioni disabilitato"
    HEALBOT_AGGRO2_ERROR_MSG                = "Per impostare il livello aggro 2, la percentuale di threat deve essere tra 25 e 95"
    HEALBOT_AGGRO3_ERROR_MSG                = "Per impostare il livello aggro 2, la percentuale di threat deve essere tra 75 e 100"
    HEALBOT_AGGRO2_SET_MSG                  = "Livello aggro 2 impostato alla percentuale di threat "
    HEALBOT_AGGRO3_SET_MSG                  = "Livello aggro 3 impostato alla percentuale di threat "
    HEALBOT_WORD_THREAT                     = "Threat"
    HEALBOT_AGGRO_ERROR_MSG                 = "Livello aggro non valido - usare 2 o 3"

    HEALBOT_OPTIONS_QUERYTALENTS            = "Interrogazione dati talenti"
    HEALBOT_OPTIONS_LOWMANAINDICATOR        = "Indicatore Mana basso"
    HEALBOT_OPTIONS_LOWMANAINDICATOR1       = "Non mostrare"

    HEALBOT_OPTION_IGNORE_AURA_RESTED       = "Ignora eventi aura durante il riposo"

    HEALBOT_WORD_ENABLE                     = "Abilita"
    HEALBOT_WORD_DISABLE                    = "Disabilita"

    HEALBOT_OPTIONS_MYCLASS                 = "Mia Classe"

    HEALBOT_OPTIONS_CONTENT_ABOUT           = "        Info"
    HEALBOT_OPTIONS_CONTENT_GENERAL         = "        " .. HEALBOT_OPTIONS_TAB_GENERAL
    HEALBOT_OPTIONS_CONTENT_SPELLS          = "        " .. HEALBOT_OPTIONS_TAB_SPELLS
    HEALBOT_OPTIONS_CONTENT_SKINS           = "        " .. HEALBOT_OPTIONS_TAB_SKIN
    HEALBOT_OPTIONS_CONTENT_BUFFS           = "        " .. HEALBOT_OPTIONS_TAB_BUFFS
    HEALBOT_OPTIONS_CONTENT_TIPS            = "        " .. HEALBOT_OPTIONS_TAB_TIPS
    HEALBOT_OPTIONS_CONTENT_MOUSEWHEEL      = "        Rotellina Mouse"
    HEALBOT_OPTIONS_CONTENT_USAGE           = "        Utilizzo"
    HEALBOT_OPTIONS_REFRESH                 = "Aggiorna"

    HEALBOT_CUSTOM_CATEGORY                 = "Categoria"
    HEALBOT_CUSTOM_CAT_CUSTOM               = "Personalizzato"

    HEALBOT_CUSTOM_CASTBY_EVERYONE          = "Tutti"
    HEALBOT_CUSTOM_CASTBY_ENEMY             = "Nemico"
    HEALBOT_CUSTOM_CASTBY_FRIEND            = "Amico"

    HEALBOT_ABOUT_DESC1                    = "Aggiunge un pannello con barre skinnabili per curare, decursare, buffare, ressare e trackare aggro"
    HEALBOT_ABOUT_WEBSITE                  = "Website:"
    HEALBOT_ABOUT_AUTHORH                  = "Autore:"
    HEALBOT_ABOUT_AUTHORD                  = "Strife"
    HEALBOT_ABOUT_CATH                     = "Categoria:"
    HEALBOT_ABOUT_CATD                     = "Unit Frames, Buffs and Debuffs, Combat:Healer"
    HEALBOT_ABOUT_CREDITH                  = "Crediti:"
    HEALBOT_ABOUT_CREDITD                  = "Acirac, Kubik, Von, Aldetal, Brezza (itIT), CT, Moonlight Han Xing"  -- Anyone taking on translations (if required), feel free to add yourself here.
    HEALBOT_ABOUT_LOCALH                   = "Lingue:"
    HEALBOT_ABOUT_LOCALD                   = "deDE, enUK, esES, frFR, huHU, itIT, koKR, poBR, ruRU, zhCN, zhTW"
    HEALBOT_ABOUT_FAQH                     = "Domande Frequenti (FAQ)"
    HEALBOT_ABOUT_FAQ_QUESTION             = "Domanda"
    HEALBOT_ABOUT_FAQ_ANSWER               = "Risposta"

    HEALBOT_ABOUT_FAQ_QUESTIONS = {   [1]   = "Buffs - Tutte le barre sono bianche, cos'è successo",
                                      [2]   = "Lancio - Ogni tanto il cursore diventa blu e non posso fare niente",
                                      [3]   = "Macro - Esiste qualche esempio di cooldown",
                                      [4]   = "Macro - Esiste qualche esempio di lancio d'incantesimo",
                                      [5]   = "Mouse - Come posso usare le mie macro mouseover con la rotellina del mouse",
                                      [6]   = "Opzioni - Si possono ordinare le barre in base ai gruppi, per esempio avere 2 gruppi per colonna",
                                      [7]   = "Opzioni - Posso nascondere tutte le barre e mostrare solo quelle di chi ha un debuff da rimuovere",
                                      [8]   = "Opzioni - Posso nascondere le cure ricevute",
                                      [9]   = "Opzioni - Healbot non salva le mie opzioni quando sloggo/loggo",
                                      [10]  = "Opzioni - Come posso impostare l'uso delle barre sempre abilitate",
                                      [11]  = "Opzioni - Come posso disabilitare Healbot automaticamente",
                                      [12]  = "Opzioni - Come posso fare in modo che le barre vengano create in una direzione diversa",
                                      [13]  = "Opzioni - Come posso impostare i 'Miei Bersagli'",
                                      [14]  = "Opzioni - Come posso impostare i 'Tank Personali'",
                                      [15]  = "Opzioni - Con Healbot è possibile creare una barra per un NPC",
                                      [16]  = "Distanza - Non riesco a vedere quando i bersagli sono fuori range (troppo distanti), come posso risolvere",
                                      [17]  = "Incantesimi - Healbot lancia un incantesimo differente rispetto a quello che ho impostato",
                                      [18]  = "Incantesimi - Non posso lanciare cure su bersagli non feriti",
                                  }

    HEALBOT_ABOUT_FAQ_SPELLS_ANSWER01       = "Questo è dovuto alle opzioni impostate nella sezione Incantesimi \n" ..
                                              "prova a fare queste modifiche e testale: \n\n" ..
                                              "     1: Nella sezione Incantesimi: Attiva Usa sempre barre abilitate \n" ..
                                              "     2: Nella sezione Incantesimi: Disattiva SmartCast \n\n" ..
                                              "Nota: Si prevede che la maggior parte degli utenti voglia \n"..
                                              "         riabilitare SmartCast \n\n" ..
                                              "Nota: Si prevede che gli utenti più esperti vogliano \n" ..
                                              "         disabilitare Usa sempre barre abilitate \n" ..
                                              "         e impostare gli incantesimi per le barre disabilitate"
                                              
    HEALBOT_ABOUT_FAQ_ANSWERS = {     [1]   = "Hai il monitoraggio per i buff mancanti attivo \n\n" .. 
                                              "Puoi disabilitare questa opzione nella sezione Buffs \n" ..
                                              "In alternativa clicca sulla barra e lancia il buff",
                                      [2]   = "Questa è una funzione Blizzard, non di Healbot \n\n" .. 
                                              "Usando i frame standard Blizzard, \n" ..
                                              "prova a lanciare un incantesimo che è in Cooldown \n" ..
                                              "Nota come il cursore diventa blu. \n\n" ..
                                              "Nota: Nulla può essere fatto per prevenirlo finché si è \n" ..
                                              "in combattimento, sin da WoW 2.0 la Blizzard ha bloccato \n" ..
                                              "l'interfaccia (UI) durante il combattimento impedendo a tutti gli addon \n" ..
                                              "di cambiare incantesimi o bersagli da quel che è stato preimpostato \n\n" ..
                                              "Può essere d'aiuto monitorare il cooldown dell'incantesimo nel tooltip",
                                      [3]   = "Si \n\n"..
                                              "Esempio di macro cooldown usando Imposizione della Salvezza (Hand of Salvation) \ndel Paladino: \n\n" ..
                                              "    #show Imposizione della Salvezza \n" ..
                                              '    /script local n=UnitName("hbtarget"); ' .. "\n" ..
                                              '    if GetSpellCooldown("Imposizione della Salvezza")==0 then ' .. " \n" ..
                                              '        SendChatMessage("Imposizione della Salvezza su "..n,"YELL") ' .. "\n" ..
                                              '        SendChatMessage("Imposizione della Salvezza!","WHISPER",nil,n) ' .. "\n" ..
                                              "    end; \n" ..
                                              "    /cast [@hbtarget] Imposizione della Salvezza",
                                      [4]   = "Si \n\n"..
                                              "Esempio con Cura Rapida del Sacerdote, usando entrambi i trinket: \n\n" ..
                                              "    #show Cura Rapida \n" ..
                                              "    /script UIErrorsFrame:Hide() \n" ..
                                              "    /console Sound_EnableSFX 0 \n" ..
                                              "    /use 13 \n" ..
                                              "    /use 14 \n" ..
                                              "    /console Sound_EnableSFX 1 \n" ..
                                              "    /cast [@hbtarget] Cura Rapida \n" ..
                                              "    /script UIErrorsFrame:Clear(); UIErrorsFrame:Show()",
                                      [5]   = "1: Nella sezione Rotellina Mouse: Disabilita Usa rotellina del mouse \n" ..
                                              "2: Associa le macro alle associazioni Blizzard usando [@mouseover] \n\n\n" ..
                                              "Macro di esempio: \n\n" ..
                                              "    #showtooltip Cura Rapida \n" ..
                                              "    /cast [@mouseover] Cura Rapida \n",
                                      [6]   = "Si \n\n\n"..
                                              "Con Intestazioni: \n" ..
                                              "     1: Nella sezione Skins>Intestazioni, attiva Mostra Intestazioni \n" ..
                                              "     2: Nella sezione Skins>Barre, imposta Nr. gruppi per colonna \n\n" ..
                                              "Senza Intestazioni: \n" ..
											  "     1: Nella sezione Skins>Intestazioni, disattiva Mostra Intestazioni \n" ..
                                              "     2: Nella sezione Skins>Barre, attiva Imposta gruppi in colonne \n" ..
                                              "     3: Nella sezione Skins>Barre, imposta Nr. Colonne",
                                      [7]   = "Si \n\n"..
                                              "1: Nella sezione Skins>Cure>Allerta, imposta Livello di allerta a 0 \n" ..
                                              "2: Nella sezione Skins>Aggro, disattiva Monìtora Aggro \n" .. 
                                              "3: Nella sezione Skins>Barre, imposta Opacità disabilitato a 0 \n" ..
                                              "4: Nella sezione Skins>Barre, imposta Opacità sfondo barre a 0 \n" ..
                                              "5: Nella sezione Skins>Testo Barra, clicca sulla barra Disabilitato \n" ..
                                              "    e imposta l'opacità a 0 \n" ..
                                              "6: Nella sezione Skins>Generale, clicca su Sfondo \n" ..
                                              "    e imposta l'opacità a 0 \n" ..
                                              "7: Nella sezione Dissoluzioni, abilita Monìtora per rimuovere debuff",
                                      [8]   = "Si \n\n"..
                                              "1: Nella sezione Skins>Barre, imposta Cure ricevute su Non mostrare \n" ..
                                              "2: Nella sezione Skins>Testo Barra, imposta Mostra salute sulla barra \n" ..
                                              "    a No cure ricevute",
                                      [9]   = "Questo problema esiste da quando vi fu un cambiamento in WoW 3.2, \n" ..
                                              "può colpire personaggi con caratteri strani (non-unicode) nel nome \n\n" ..
											  "  Se usi Vista o Win7 puoi provare a risolvere andando in \n" ..
											  "     - Pannello di Controllo > Paese e lingua > Opzioni di Amministrazione \n" ..
                                              "     - Nella sezione Lingua per programmi non Unicode clicca su \n" ..
											  "       Cambia impostazioni locali del sistema \n" ..
											  "     - scegli quindi una lingua, clicca su OK e poi su Riavvia ora",

                                      [10]   = "Nella sezione Incantesimi abilita Usa sempre barre abilitate \n\n" ..
                                              "Alcuni vorranno anche impostare il livello di allerta a 100 \n" ..
                                              "Questo può essere fatto nella sezione Skins>Cure>Allerta",
                                      [11]  = "Disabilitarlo per un solo personaggio: \n\n" ..
                                              "     1: Apri le la sezione Generale \n" ..
                                              "     2: Metti la spunta su Disabilita HealBot \n\n\n" ..
                                              "Disabilitarlo solo quando si è soli: \n\n" ..
                                              "     1: Apri la sezione Generale \n" ..
                                              "     2: Vicino all'opzione Disabilita HealBot, seleziona Soltanto quando in solo \n" ..
                                              "     3: Metti la spunta su Disabilita HealBot",
                                      [12]  = "Cambia le impostazioni di Ancoraggio Barre nella sezione Skins>Generale \n\n" ..
                                              "     In alto a destra:        le barre verranno generate verso il basso e a sinistra \n" ..
                                              "     In alto a sinistra:      le barre verranno generate verso il basso e a destra \n" ..
                                              "     In basso a destra:     le barre verranno generate verso l'alto e a sinistra \n" ..
                                              "     In basso a sinistra:   le barre verranno generate verso l'alto e a destra",
                                      [13]  = "Miei Bersagli permette di creare una lista di Bersagli che si vogliono \n" ..
                                              "gruppare separatamente dagli altri, simile al gruppo dei MainTanks \n\n" ..
                                              "Le seguenti opzioni sono disponibili per \n" .. 
                                              "aggiungere/rimuovere personaggi al/dal gruppo Miei Bersagli \n\n" ..
                                              "     - Maiusc+Ctrl+Alt+Click destro sulla barra \n" ..
                                              '     - Usare il Menù di HealBot, inserire "hbmenu" nella sezione Incantesimi ' .. "\n" ..
                                              "     - Usare la rotellina del mouse, impostandola nella sezione Rotellina Mouse",
                                      [14]  = "I Tank Personali possono essere aggiunti alla lista Main Tanks, \n" ..
                                              "sono visibili solo nel TUO HealBot\n" ..
                                              "e non coinvolgono altri giocatori o addons \n\n" ..
                                              "Le seguenti opzioni sono disponibili per \n" ..
                                              "aggiungere/rimuovere personaggi alla/dalla lista dei Tank \n\n" ..
                                              '     - Usare il Menù di HealBot, inserire "hbmenu" nella sezione Incantesimi ' .. "\n" ..
                                              "     - Usare la rotellina del mouse, impostandola nella sezione Rotellina Mouse",
                                      
                                      [15]  = "Si \n\n"..
                                              "     1: Nella sezione Skins>Cure, abilita Focus \n" ..
                                              "     2: Imposta il tuo focus sull'NPC (o PG non in raid/gruppo) \n" ..
                                              "         Healbot creerà una barra nella tua lista Miei Bersagli \n\n" ..
                                              "Nota: Se ti trovi in una situazione di combattimento in cui entri e esci dalla zona \n" ..
                                              "         durante il combattimento e hai bisogno di risettare il focus su un NPC \n" ..
                                              "         nella sezione Skins>Cure abilita l'opzione Focus: Mostra sempre \n" ..
                                              "         Questo manterrà disponibile la barra durante il combattimento. \n\n" ..
                                              "Nota: Nel menù di HealBot c'è l'opzione 'Imposta HealBot Focus' \n" ..
                                              "         Questo può rendere più semplice l'impostare il focus su un NPC e\n" ..
                                              "         serve da promemoria per l'impostazione del focus. \n\n" ..
                                              "         Inserisci 'hbmenu' nella sezione Incantesimi per usare il menù di HealBot \n" ..
                                              "         o impostalo nella sezione Rotellina Mouse",
                                      [16]  = "1:  Nella sezione Skins>Barre, regola l'impostazione Opacità disabilitato \n" ..
                                              "2:  Nella sezione Skins>Testo Barre, regola l'impostazione dell'opacità Disabilitato \n" ..
                                              "     Per farlo clicca sulla barra chiamata Disabilitato (quella in mezzo alle altre due). \n\n" ..
                                              "Alcuni vorranno anche impostare il livello di Allerta a 100 \n" ..
                                              "Questo può essere fatto nella sezione Skins>Cure>Allerta",
                                      [17]  = "In realtà Healbot lancia esattamente quanto impostato nelle impostazioni. \n\n" .. HEALBOT_ABOUT_FAQ_SPELLS_ANSWER01,
                                      [18]  = HEALBOT_ABOUT_FAQ_SPELLS_ANSWER01,
                                  }

    HEALBOT_OPTIONS_SKINAUTHOR              = "Autore delle Skin:"
    HEALBOT_OPTIONS_AVOIDBLUECURSOR         = "Evita\nCursore Blu"
    HEALBOT_PLAYER_OF_REALM                 = "di"
    
    HEALBOT_OPTIONS_LANG                    = "Lingua"
    
    HEALBOT_OPTIONS_LANG_ZHCN               = "Cinese (zhCN)"
    HEALBOT_OPTIONS_LANG_ENUK               = "Inglese (enUK)"
    HEALBOT_OPTIONS_LANG_ENUS               = "Inglese (enUS)"
    HEALBOT_OPTIONS_LANG_FRFR               = "Francese (frFR)"
    HEALBOT_OPTIONS_LANG_DEDE               = "Deutsch (deDE)"
    HEALBOT_OPTIONS_LANG_GRGR               = "Greek (grGR)"
    HEALBOT_OPTIONS_LANG_HUHU               = "Ungherese (huHU)"
    HEALBOT_OPTIONS_LANG_ITIT               = "Italiana (itIT)"
    HEALBOT_OPTIONS_LANG_KRKR               = "Coreano (krKR)"
    HEALBOT_OPTIONS_LANG_PTBR               = "Portoghese (ptBR)"
    HEALBOT_OPTIONS_LANG_RURU               = "Russo (ruRU)"
    HEALBOT_OPTIONS_LANG_ESES               = "Spagnolo (esES)"
    HEALBOT_OPTIONS_LANG_TWTW               = "Taiwanese (twTW)"
    
    HEALBOT_OPTIONS_LANG_ADDON_FAIL1        = "Caricamento traduzione fallito"
    HEALBOT_OPTIONS_LANG_ADDON_FAIL2        = "Il motivo del problema è:"
    HEALBOT_OPTIONS_LANG_ADDON_FAIL3        = "Nota della versione corrente, questo è il solo avviso per"
    
    HEALBOT_OPTIONS_ADDON_FAIL              = "Caricamento di HealBot fallito"
    
    HEALBOT_OPTIONS_CONTENT_SKINS_GENERAL   = "    " .. HEALBOT_OPTIONS_TAB_GENERAL
    HEALBOT_OPTIONS_CONTENT_SKINS_HEALING   = "    " .. HEALBOT_OPTIONS_TAB_HEALING
    HEALBOT_OPTIONS_CONTENT_SKINS_HEADERS   = "        " .. HEALBOT_OPTIONS_TAB_HEADERS
    HEALBOT_OPTIONS_CONTENT_SKINS_BARS      = "        " .. HEALBOT_OPTIONS_TAB_BARS
    HEALBOT_OPTIONS_CONTENT_SKINS_ICONS     = "        " .. HEALBOT_OPTIONS_TAB_ICONS
    HEALBOT_OPTIONS_CONTENT_SKINS_AGGRO     = "    " .. HEALBOT_OPTIONS_TAB_AGGRO
    HEALBOT_OPTIONS_CONTENT_SKINS_CHAT      = "    " .. HEALBOT_OPTIONS_TAB_CHAT
    HEALBOT_OPTIONS_CONTENT_SKINS_TEXT      = "        " .. HEALBOT_OPTIONS_TAB_TEXT
    HEALBOT_OPTIONS_CONTENT_SKINS_ICONTEXT  = "        " .. HEALBOT_OPTIONS_TAB_ICONTEXT

    HEALBOT_OPTIONS_CONTENT_CURE_DEBUFF     = "    " .. HEALBOT_SKIN_DEBTEXT
    HEALBOT_OPTIONS_CONTENT_CURE_CUSTOM     = "    " .. HEALBOT_CLASSES_CUSTOM
    HEALBOT_OPTIONS_CONTENT_CURE_WARNING    = "    " .. HEALBOT_OPTIONS_TAB_WARNING
    
    HEALBOT_SKIN_ABSORBCOL_TEXT             = "Effetti assorbenti";
    HEALBOT_OPTIONS_BARALPHAABSORB          = "Opacità degli effetti assorbenti";
    HEALBOT_OPTIONS_FRAME                   = "Riquadro"
    HEALBOT_OPTIONS_CONTENT_SKINS_FRAMES    = "    " .. "Riquardi"
    HEALBOT_OPTIONS_FRAMESOPTTEXT           = "Opzioni i riquardi"
    HEALBOT_OPTIONS_SETTOOLTIP_POSITION     = "Imposta le informazioni dettagliate"
    HEALBOT_OPTIONS_FRAME_ALIAS             = "Titolo dei riquadri"
    HEALBOT_OPTIONS_FRAME_ALIAS_SHOW        = "Mostra titolo"
    HEALBOT_OPTIONS_GROW_DIRECTION          = "Direzione della ricrescita"
    HEALBOT_OPTIONS_GROW_HORIZONTAL         = "Orizzontale"
    HEALBOT_OPTIONS_GROW_VERTICAL           = "Verticale"
    HEALBOT_OPTIONS_SET_FRAME_HEALGROUPS    = "Assegna gruppi delle guarigioni"
    HEALBOT_OPTION_EXCLUDEMOUNT_ON          = "Now Excluding Mount"
    HEALBOT_OPTION_EXCLUDEMOUNT_OFF         = "No longer Excluding Mount"
    HEALBOT_CMD_TOGGLEEXCLUDEMOUNT          = "Toggle Exclude Mount"
    HEALBOT_OPTIONS_HIDEMINIBOSSFRAMES      = "Nascondi i riquadri dei mini-boss";
    HEALBOT_OPTIONS_HIDERAIDFRAMES          = "Nascondi i riquadri delle incursioni";
    HEALBOT_OPTIONS_CONTENT_SKINS_HEALGROUP = "        " .. "Gruppi d. guarigioni"
    HEALBOT_OPTIONS_CONTENT_SKINS_BARCOLOUR = "        " .. "Colori delle barre";
    HEALBOT_OPTIONS_SET_ALL_FRAMES          = "Applica le impostazioni d. scheda corrente a tutti riquadri"
    HEALBOT_WORDS_PROFILE                   = "Profilo"
    HEALBOT_SHARE_SCREENSHOT                = "Schiermata salvata"
    HEALBOT_SHARE_INSTRUCTION               = "Vai sul sito online pers istruzioni sulla condivisione"..HEALBOT_ABOUT_URL
    HEALBOT_ENEMY_USE_FRAME                 = "Usa riquadro"
    HEALBOT_ENEMY_INCLUDE_SELF              = "Includi il mio bersaglio"
    HEALBOT_ENEMY_INCLUDE_TANKS             = "Includi il bersaglio del difensore"
    HEALBOT_OPTIONS_ENEMY_OPT               = "Opzioni di Nemici";
    HEALBOT_OPTIONS_SHARE_OPT               = "Condividi le opzioni";
    HEALBOT_OPTIONS_CONTENT_SKINS_SHARE     = "    " .. "Condividi"
    HEALBOT_OPTIONS_CONTENT_SKINS_ENEMY     = "    " .. "Nemico"
    HEALBOT_OPTIONS_BUTTONLOADSKIN          = "Attiva skin"
    HEALBOT_ENEMY_NO_TARGET                 = "Nessun bersaglio"
    HEALBOT_OPTIONS_ENEMYBARS               = "sempre le barre dei nemici";
    HEALBOT_OPTIONS_HARMFUL_SPELLS          = "Incantesimi d'attacco"
    HEALBOT_ENEMY_INCLUDE_MYTARGETS         = "Incorpora il bersaglio del bersaglio"
    HEALBOT_ENEMY_NUMBER_BOSSES             = "Numero di nemici"
    HEALBOT_ENEMY_HIDE_OUTOFCOMBAT          = "Nascondi le barre al di fuori del combattimento"
    HEALBOT_ENEMY_EXISTS_SHOW               = "L'entrata in combattimento viene mostrata ".."\n".." solo quando esiste"
    HEALBOT_ENEMY_EXISTS_SHOW_PTARGETS      = "Bersaglio del giocatore"
    HEALBOT_ENEMY_EXISTS_SHOW_BOSSES        = "Barra del boss"
    HEALBOT_OPTIONS_TARGET_ONLY_FRIEND      = "Bersaglio: Mostra solo alleati"
    HEALBOT_OPTIONS_FOCUS_ONLY_FRIEND       = "Focus: Mostra solo alleati"
    HEALBOT_OPTIONS_PROFILE                 = "Profile for".."\n".."Spells/Buffs/Cures"
    HEALBOT_OPTIONS_PROFILE_CHARACTER       = "Personaggio"
    HEALBOT_OPTIONS_PROFILE_CLASS           = "Classe"
    HEALBOT_OPTIONS_INCOMBATALERTLEVEL      = "Livello di allerta - in combattimento";
    HEALBOT_OPTIONS_OUTCOMBATALERTLEVEL     = "Livello di allerta - fuori dal combattimento";
    HEALBOT_OPTION_NUMENEMYS                = "Numero di nemici"
	HEALBOT_OPTIONS_ENABLEAUTOCOMBAT        = "Attiva HealBot autoCombat"
    HEALBOT_WORDS_REMOVETEMPCUSTOMNAME      = "Rimuovi un nome customizzato temporaneo"
    HEALBOT_WORDS_REMOVEPERMCUSTOMNAME      = "Rimuovi un nome customizzato permanente"
    HEALBOT_WORDS_ADDTEMPCUSTOMNAME         = "Aggiungi un nome customizzato temporaneo"
    HEALBOT_WORDS_ADDPERMCUSTOMNAME         = "Aggiungi un nome customizzato permanente"
    HEALBOT_OPTIONS_ENABLELIBUTF8           = "Attiva UTF8 library"
    HEALBOT_OPTIONS_SHOWDIRECTION           = "Mostra la direzione fuori portata"
    HEALBOT_OPTIONS_SHOWDIRECTIONMOUSE      = "Solo al passaggio del mouse"
end

if (GetLocale() == "itIT") then
    HealBot_Lang_itIT()
end
