-- Spanish translator required
-------------
-- SPANISH
--
-- á = \195\161
-- é = \195\169    
-- í = \195\173
-- ó = \195\179
-- ú = \195\186
-- ñ = \195\177
--
-- (http://www.wowwiki.com/Localizing_an_addon)
--
-- To localize this addon, it can be cloned from GitHub, find it at https://github.com/davidmarshall15/HealBot_es
--
--


function HealBot_Lang_esES()

-----------------
-- Translation --
-----------------
-- Class
    HEALBOT_DRUID   = "Druida";
    HEALBOT_HUNTER  = "Cazador";
    HEALBOT_MAGE    = "Mago";
    HEALBOT_PALADIN = "Palad\195\173n";
    HEALBOT_PRIEST  = "Sacerdote";
    HEALBOT_ROGUE   = "P\195\173caro";
    HEALBOT_SHAMAN  = "Cham\195\161n";
    HEALBOT_WARLOCK = "Brujo";
    HEALBOT_WARRIOR = "Guerrero";
    HEALBOT_DEATHKNIGHT = "Caballero de la Muerte";
HEALBOT_MONK                            = "Monk";

    HEALBOT_DISEASE            = "Enfermedad";
    HEALBOT_MAGIC              = "Magia";
    HEALBOT_CURSE              = "Maldici\195\179n";
    HEALBOT_POISON             = "Veneno";

    HB_TOOLTIP_OFFLINE        = "desconectado";
    HB_OFFLINE                = "desconectado"; -- has gone offline msg
    HB_ONLINE                 = "conectado"; -- has come online msg

    HEALBOT_HEALBOT                         = "HealBot";
    HEALBOT_ADDON  = HEALBOT_HEALBOT .. " " .. HEALBOT_VERSION;
    HEALBOT_LOADED = " cargado.";

    HEALBOT_ACTION_OPTIONS    = "Opciones";

    HEALBOT_OPTIONS_TITLE         = HEALBOT_ADDON;
    HEALBOT_OPTIONS_DEFAULTS      = "Defecto";
    HEALBOT_OPTIONS_CLOSE         = "Cerrar";
    HEALBOT_OPTIONS_HARDRESET     = "RecargarUI"
    HEALBOT_OPTIONS_SOFTRESET     = "ResetHB"
    HEALBOT_OPTIONS_TAB_GENERAL   = "General";
    HEALBOT_OPTIONS_TAB_SPELLS    = "Habilidades";
    HEALBOT_OPTIONS_TAB_HEALING   = "Sanaci\195\179n";
    HEALBOT_OPTIONS_TAB_CDC       = "Debuffs";
    HEALBOT_OPTIONS_TAB_SKIN      = "Skin";
    HEALBOT_OPTIONS_TAB_TIPS      = "Info";
    HEALBOT_OPTIONS_TAB_BUFFS     = "Buffs"

    HEALBOT_OPTIONS_BARALPHA      = "Opacidad barra habilitada";
    HEALBOT_OPTIONS_BARALPHAINHEAL= "Opacidad de curas entrantes";
HEALBOT_OPTIONS_BARALPHABACK            = "Background bar opacity";
    HEALBOT_OPTIONS_BARALPHAEOR   = "Opacidad fuera de rango";
    HEALBOT_OPTIONS_ACTIONLOCKED  = "Bloquear posici\195\179n";
    HEALBOT_OPTIONS_AUTOSHOW      = "Cerrar autom\195\161ticamente";
    HEALBOT_OPTIONS_PANELSOUNDS   = "Reproducir sonido al entrar";
    HEALBOT_OPTIONS_HIDEOPTIONS   = "Ocultar bot\195\179n Opciones";
    HEALBOT_OPTIONS_PROTECTPVP    = "Evitar ser marcado accidentalmente con PvP";
    HEALBOT_OPTIONS_HEAL_CHATOPT  = "Opciones de Chat";

HEALBOT_OPTIONS_FRAMESCALE              = "Frame Scale"
    HEALBOT_OPTIONS_SKINTEXT      = "Usar skin"
    HEALBOT_SKINS_STD             = "Est\195\161ndar"
    HEALBOT_OPTIONS_SKINTEXTURE   = "Textura"
    HEALBOT_OPTIONS_SKINHEIGHT    = "Alto"
    HEALBOT_OPTIONS_SKINWIDTH     = "Ancho"
    HEALBOT_OPTIONS_SKINNUMCOLS   = "No. columnas"
    HEALBOT_OPTIONS_SKINNUMHCOLS  = "No. cabeceras por columna"
    HEALBOT_OPTIONS_SKINBRSPACE   = "Espacio entre filas"
    HEALBOT_OPTIONS_SKINBCSPACE   = "Espacio entre columnas"
    HEALBOT_OPTIONS_EXTRASORT     = "Orden de barras"
    HEALBOT_SORTBY_NAME           = "Nombre"
    HEALBOT_SORTBY_CLASS          = "Clase"
    HEALBOT_SORTBY_GROUP          = "Grupo"
    HEALBOT_SORTBY_MAXHEALTH      = "Salud m\195\161x"
    HEALBOT_OPTIONS_NEWDEBUFFTEXT = "Nuevo debuff"
    HEALBOT_OPTIONS_DELSKIN       = "Borrar"
    HEALBOT_OPTIONS_NEWSKINTEXT   = "Nueva skin"
    HEALBOT_OPTIONS_SAVESKIN      = "Guardar"
    HEALBOT_OPTIONS_SKINBARS      = "Opciones de barras"
    HEALBOT_SKIN_ENTEXT           = "Habilitado"
    HEALBOT_SKIN_DISTEXT          = "Deshabilitado"
    HEALBOT_SKIN_DEBTEXT          = "Debuff"
    HEALBOT_SKIN_BACKTEXT         = "Fondo"
    HEALBOT_SKIN_BORDERTEXT       = "Borde"
    HEALBOT_OPTIONS_SKINFONT      = "Fuente"
    HEALBOT_OPTIONS_SKINFHEIGHT   = "Tama\195\177o de la fuente"
HEALBOT_OPTIONS_SKINFOUTLINE            = "Font Outline"
    HEALBOT_OPTIONS_BARALPHADIS   = "Opacidad barra deshabilitada"
    HEALBOT_OPTIONS_SHOWHEADERS   = "Mostrar cabeceras"

HEALBOT_OPTIONS_ITEMS                   = "Items";

    HEALBOT_OPTIONS_COMBOCLASS    = "Combos para";
    HEALBOT_OPTIONS_CLICK         = "Clic";
    HEALBOT_OPTIONS_SHIFT         = "Mayus";
    HEALBOT_OPTIONS_CTRL          = "Ctrl";
    HEALBOT_OPTIONS_ENABLEHEALTHY = "Siempre usar configuraci\195\179n habilitada";

    HEALBOT_OPTIONS_CASTNOTIFY1   = "Sin mensajes";
    HEALBOT_OPTIONS_CASTNOTIFY2   = "Notificarme a mi";
    HEALBOT_OPTIONS_CASTNOTIFY3   = "Notificar objetivo";
    HEALBOT_OPTIONS_CASTNOTIFY4   = "Notificar grupo";
    HEALBOT_OPTIONS_CASTNOTIFY5   = "Notificar raid";
    HEALBOT_OPTIONS_CASTNOTIFY6   = "Notificar canal";
    HEALBOT_OPTIONS_CASTNOTIFYRESONLY = "Notificar s\195\179lo resurrecci\195\179n";

    HEALBOT_OPTIONS_CDCBARS       = "Colores";
    HEALBOT_OPTIONS_CDCSHOWHBARS  = "Cambiar color barra de salud";
    HEALBOT_OPTIONS_CDCSHOWABARS  = "Cambiar color barra de aggro";
    HEALBOT_OPTIONS_CDCWARNINGS   = "Alertas de debuffs";
    HEALBOT_OPTIONS_SHOWDEBUFFICON = "Ver icono debuff";
    HEALBOT_OPTIONS_SHOWDEBUFFWARNING = "Mostrar alerta de debuffs";
    HEALBOT_OPTIONS_SOUNDDEBUFFWARNING = "Reproducir sonido";
    HEALBOT_OPTIONS_SOUND	      = "Sonido"

    HEALBOT_OPTIONS_HEAL_BUTTONS  = "Barras de curaci\195\179n:";
    HEALBOT_OPTIONS_SELFHEALS     = "Yo"
    HEALBOT_OPTIONS_PETHEALS      = "Mascotas"
    HEALBOT_OPTIONS_GROUPHEALS    = "Grupo";
    HEALBOT_OPTIONS_TANKHEALS     = "Main tanks";
HEALBOT_OPTIONS_MAINASSIST              = "Main assist";
HEALBOT_OPTIONS_PRIVATETANKS            = "Private main tanks";
    HEALBOT_OPTIONS_TARGETHEALS   = "Objetivos";
    HEALBOT_OPTIONS_EMERGENCYHEALS= "Raid";
    HEALBOT_OPTIONS_ALERTLEVEL    = "Nivel de Alerta";
    HEALBOT_OPTIONS_EMERGFILTER   = "Mostrar barras para";
    HEALBOT_OPTIONS_EMERGFCLASS   = "Configurar clases para";
    HEALBOT_OPTIONS_COMBOBUTTON   = "Bot\195\179n";
    HEALBOT_OPTIONS_BUTTONLEFT    = "Izqdo";
    HEALBOT_OPTIONS_BUTTONMIDDLE  = "Central";
    HEALBOT_OPTIONS_BUTTONRIGHT   = "Dcho";
    HEALBOT_OPTIONS_BUTTON4       = "Bot\195\179n4";
    HEALBOT_OPTIONS_BUTTON5       = "Bot\195\179n5";
    HEALBOT_OPTIONS_BUTTON6       = "Bot\195\179n6";
    HEALBOT_OPTIONS_BUTTON7       = "Bot\195\179n7";
    HEALBOT_OPTIONS_BUTTON8       = "Bot\195\179n8";
    HEALBOT_OPTIONS_BUTTON9       = "Bot\195\179n9";
    HEALBOT_OPTIONS_BUTTON10      = "Bot\195\179n10";
    HEALBOT_OPTIONS_BUTTON11      = "Bot\195\179n11";
    HEALBOT_OPTIONS_BUTTON12      = "Bot\195\179n12";
    HEALBOT_OPTIONS_BUTTON13      = "Bot\195\179n13";
    HEALBOT_OPTIONS_BUTTON14      = "Bot\195\179n14";
    HEALBOT_OPTIONS_BUTTON15      = "Bot\195\179n15";

    HEALBOT_CLASSES_ALL     = "Todas las clases";
    HEALBOT_CLASSES_MELEE   = "Melee";
    HEALBOT_CLASSES_RANGES  = "Ranged";
    HEALBOT_CLASSES_HEALERS = "Healers";
    HEALBOT_CLASSES_CUSTOM  = "Personalizado";

    HEALBOT_OPTIONS_SHOWTOOLTIP     = "Ver tooltips";
    HEALBOT_OPTIONS_SHOWDETTOOLTIP  = "Ver informaci\195\179n detallada de habilidades";
HEALBOT_OPTIONS_SHOWCDTOOLTIP           = "Show spell cooldown";
    HEALBOT_OPTIONS_SHOWUNITTOOLTIP = "Ver informaci\195\179n del objetivo";
    HEALBOT_OPTIONS_SHOWRECTOOLTIP  = "Ver recomendaci\195\179n de HoT";
    HEALBOT_TOOLTIP_POSDEFAULT      = "Localizaci\195\179n por defecto";
    HEALBOT_TOOLTIP_POSLEFT         = "Izqda de Healbot";
    HEALBOT_TOOLTIP_POSRIGHT        = "Dcha de Healbot";
    HEALBOT_TOOLTIP_POSABOVE        = "Sobre Healbot";
    HEALBOT_TOOLTIP_POSBELOW        = "Debajo de Healbot";
    HEALBOT_TOOLTIP_POSCURSOR       = "Junto al Cursor";
    HEALBOT_TOOLTIP_RECOMMENDTEXT   = "Recomendaci\195\179n HoT";
    HEALBOT_TOOLTIP_NONE            = "nada disponible";
    HEALBOT_TOOLTIP_CORPSE          = "Cuerpo de ";
HEALBOT_TOOLTIP_CD                      = " (CD ";
HEALBOT_TOOLTIP_SECS                    = "s)";
    HEALBOT_WORDS_SEC               = "seg";
    HEALBOT_WORDS_CAST              = "Lanzar";
    HEALBOT_WORDS_UNKNOWN           = "Desconocido";
    HEALBOT_WORDS_YES               = "S\195\173";
    HEALBOT_WORDS_NO                = "No";
HEALBOT_WORDS_THIN                      = "Thin";
HEALBOT_WORDS_THICK                     = "Thick";

    HEALBOT_WORDS_NONE              = "Ninguno";
    HEALBOT_OPTIONS_ALT             = "Alt";
    HEALBOT_DISABLED_TARGET         = "Target";
    HEALBOT_OPTIONS_SHOWCLASSONBAR  = "Ver clase en barra";
    HEALBOT_OPTIONS_SHOWHEALTHONBAR = "Ver vida en la barra";
    HEALBOT_OPTIONS_BARHEALTHINCHEALS = "Ver sanaci\195\179n entrante";
    HEALBOT_OPTIONS_BARHEALTHSEPHEALS = "Separar sanaci\195\179n entrante";
    HEALBOT_OPTIONS_BARHEALTH1      = "delta";
    HEALBOT_OPTIONS_BARHEALTH2      = "porcentaje";
    HEALBOT_OPTIONS_TIPTEXT         = "Informaci\195\179n Emergente";
    HEALBOT_OPTIONS_POSTOOLTIP      = "Posici\195\179n";
    HEALBOT_OPTIONS_SHOWNAMEONBAR   = "Ver nombre en la barra";
    HEALBOT_OPTIONS_BARTEXTCLASSCOLOUR1 = "Colorear texto por clase";
    HEALBOT_OPTIONS_EMERGFILTERGROUPS   = "Incluir grupo";

    HEALBOT_ONE   = "1";
    HEALBOT_TWO   = "2";
    HEALBOT_THREE = "3";
    HEALBOT_FOUR  = "4";
    HEALBOT_FIVE  = "5";
    HEALBOT_SIX   = "6";
    HEALBOT_SEVEN = "7";
    HEALBOT_EIGHT = "8";

    HEALBOT_OPTIONS_SETDEFAULTS      = "Establecer por defecto";
    HEALBOT_OPTIONS_SETDEFAULTSMSG   = "Volver todas las opciones a valores por defecto";
    HEALBOT_OPTIONS_RIGHTBOPTIONS    = "Clic dcho para abrir Opciones";

    HEALBOT_OPTIONS_HEADEROPTTEXT    = "Cabeceras";
    HEALBOT_OPTIONS_ICONOPTTEXT      = "Iconos";
    HEALBOT_SKIN_HEADERBARCOL        = "Color de barra";
    HEALBOT_SKIN_HEADERTEXTCOL       = "Color de texto";
    HEALBOT_OPTIONS_BUFFSTEXT1       = "Buff";
    HEALBOT_OPTIONS_BUFFSTEXT2       = "comprobar";
    HEALBOT_OPTIONS_BUFFSTEXT3       = "Color de barra";
    HEALBOT_OPTIONS_BUFF             = "Buff ";
    HEALBOT_OPTIONS_BUFFSELF         = "yo";
    HEALBOT_OPTIONS_BUFFPARTY        = "grupo";
    HEALBOT_OPTIONS_BUFFRAID         = "raid";
    HEALBOT_OPTIONS_MONITORBUFFS     = "Monitorizar buffs perdidos";
    HEALBOT_OPTIONS_MONITORBUFFSC    = "tambi\195\169n en combate";
    HEALBOT_OPTIONS_ENABLESMARTCAST  = "SmartCast fuera de combate";
    HEALBOT_OPTIONS_SMARTCASTSPELLS  = "Incluir";
    HEALBOT_OPTIONS_SMARTCASTDISPELL = "Quitar debuffs";
    HEALBOT_OPTIONS_SMARTCASTBUFF    = "Poner buffs";
    HEALBOT_OPTIONS_SMARTCASTHEAL    = "Curaciones";
    HEALBOT_OPTIONS_BAR2SIZE         = "Tama\195\177o barra de man\195\161";
    HEALBOT_OPTIONS_SETSPELLS        = "Habilidades para ";
    HEALBOT_OPTIONS_ENABLEDBARS      = "Barras habilitadas";
    HEALBOT_OPTIONS_DISABLEDBARS     = "Barras deshabilitadas";
    HEALBOT_OPTIONS_MONITORDEBUFFS   = "Monitorizar debuffs";
    HEALBOT_OPTIONS_DEBUFFTEXT1      = "Habilidades para debuffs";

    HEALBOT_OPTIONS_IGNOREDEBUFF         = "Ignorar debuffs:";
    HEALBOT_OPTIONS_IGNOREDEBUFFCLASS    = "Seg\195\186n clase";
    HEALBOT_OPTIONS_IGNOREDEBUFFMOVEMENT = "Ralentizadores";
    HEALBOT_OPTIONS_IGNOREDEBUFFDURATION = "Corta duraci\195\179n";
    HEALBOT_OPTIONS_IGNOREDEBUFFNOHARM   = "No da\195\177inos";
HEALBOT_OPTIONS_IGNOREDEBUFFCOOLDOWN     = "When cure spell CoolDown > 1.5 secs (GCD)";
HEALBOT_OPTIONS_IGNOREDEBUFFFRIEND       = "When caster is known as friend";

    HEALBOT_OPTIONS_RANGECHECKFREQ       = "Frec. de chequeo del rango";

    HEALBOT_OPTIONS_HIDEPARTYFRAMES      = "Ocultar grupo";
    HEALBOT_OPTIONS_HIDEPLAYERTARGET     = "Incluir jugador y objetivo";
    HEALBOT_OPTIONS_DISABLEHEALBOT       = "Deshabilitar HealBot";

HEALBOT_ASSIST                          = "Assist";
HEALBOT_FOCUS                           = "Focus";
HEALBOT_MENU                            = "Menu";
HEALBOT_MAINTANK                        = "MainTank";
HEALBOT_MAINASSIST                      = "MainAssist";
HEALBOT_STOP                            = "Stop";
HEALBOT_TELL                            = "Tell";

    HEALBOT_OPTIONS_SHOWMINIMAPBUTTON = "Ver icono en el minimapa";
    HEALBOT_OPTIONS_BARBUTTONSHOWHOT  = "Ver iconos HoT";
    HEALBOT_OPTIONS_BARBUTTONSHOWRAIDICON = "Ver iconos de raid";
    HEALBOT_OPTIONS_HOTONBAR     = "En barras";
    HEALBOT_OPTIONS_HOTOFFBAR    = "Fuera de barras";
    HEALBOT_OPTIONS_HOTBARRIGHT  = "Lado dcho";
    HEALBOT_OPTIONS_HOTBARLEFT   = "Lado izqdo";

    HEALBOT_ZONE_AB = "Cuenca de Arathi";
    HEALBOT_ZONE_AV = "Valle de Alterac";
    HEALBOT_ZONE_ES = "Ojo de la Tormenta";
HEALBOT_ZONE_IC                         = "Isle of Conquest";
HEALBOT_ZONE_SA                         = "Strand of the Ancients";

    HEALBOT_OPTION_AGGROTRACK     = "Monitorizar Aggro"
    HEALBOT_OPTION_AGGROBAR       = "Parpadear"
    HEALBOT_OPTION_AGGROTXT       = ">> Mostrar texto <<"
HEALBOT_OPTION_AGGROIND                 = "Indicator"
    HEALBOT_OPTION_BARUPDFREQ     = "Frecuencia refresco"
    HEALBOT_OPTION_USEFLUIDBARS   = "Usar barras fluidas"
    HEALBOT_OPTION_CPUPROFILE     = "Usar CPU profiler (Informaci\195\179n de uso de CPU)"
    HEALBOT_OPTIONS_RELOADUIMSG   = "Esta opci\195\179n requiere recargar la UI, recargar?"

HEALBOT_BUFF_PVP                        = "PvP"
HEALBOT_BUFF_PVE						= "PvE"
HEALBOT_OPTIONS_ANCHOR                  = "Frame anchor"
HEALBOT_OPTIONS_BARSANCHOR              = "Bars anchor"
    HEALBOT_OPTIONS_TOPLEFT       = "Arriba Izqda";
    HEALBOT_OPTIONS_BOTTOMLEFT    = "Abajo Izqda";
    HEALBOT_OPTIONS_TOPRIGHT      = "Arriba Dcha";
    HEALBOT_OPTIONS_BOTTOMRIGHT   = "Abajo Dcha";
    HEALBOT_OPTIONS_TOP           = "Arriba"
    HEALBOT_OPTIONS_BOTTOM        = "Abajo"

    HEALBOT_PANEL_BLACKLIST       = "Lista negra";

    HEALBOT_WORDS_REMOVEFROM      = "Eliminar de ";
    HEALBOT_WORDS_ADDTO           = "A\195\177adir a ";
    HEALBOT_WORDS_INCLUDE         = "Incluir";

    HEALBOT_OPTIONS_TTALPHA       = "Opacidad";
    HEALBOT_TOOLTIP_TARGETBAR     = "Barra Objetivo";
    HEALBOT_OPTIONS_MYTARGET      = "Mis Objetivos";

    HEALBOT_DISCONNECTED_TEXT	        = "<DESC>"
    HEALBOT_OPTIONS_SHOWUNITBUFFTIME    = "Ver mis buffs";
    HEALBOT_OPTIONS_TOOLTIPUPDATE       = "Actualizar continuamente";
    HEALBOT_OPTIONS_BUFFSTEXTTIMER      = "Avisar de buff antes de terminar";
    HEALBOT_OPTIONS_SHORTBUFFTIMER      = "Buffs cortos";
    HEALBOT_OPTIONS_LONGBUFFTIMER       = "Buffs largos";

HEALBOT_OPTIONS_NOTIFY_MSG              = "Message"
    HEALBOT_WORDS_YOU                = "t\195\186";
    HEALBOT_NOTIFYOTHERMSG           = "Lanzando #s en #n";

    HEALBOT_OPTIONS_HOTPOSITION     = "Posicinar icono";
    HEALBOT_OPTIONS_HOTSHOWTEXT     = "Texto del icono";
    HEALBOT_OPTIONS_HOTTEXTCOUNT    = "Cargas";
    HEALBOT_OPTIONS_HOTTEXTDURATION = "Duraci\195\179n";
    HEALBOT_OPTIONS_ICONSCALE       = "Escala de icono";
    HEALBOT_OPTIONS_ICONTEXTSCALE   = "Escala de texto";

    HEALBOT_OPTIONS_AGGROBARSIZE    = "Tama\195\177o barra de aggro";
    HEALBOT_OPTIONS_DOUBLETEXTLINES = "L\195\173neas de doble texto";
    HEALBOT_OPTIONS_TEXTALIGNMENT   = "Alineaci\195\179n del texto";
    HEALBOT_VEHICLE                 = "Veh\195\173culo"
    HEALBOT_WORDS_ERROR		        = "Error"
    HEALBOT_SPELL_NOT_FOUND		    = "Hechizo no encontrado"
    HEALBOT_OPTIONS_DISABLETOOLTIPINCOMBAT = "Ocultar tooltip en combate"
    HEALBOT_OPTIONS_ENABLELIBQH     = "Habilitar fastHealth";

    HEALBOT_OPTIONS_BUFFNAMED       = "Nombre de los jugadores a vigilar para"
    HEALBOT_WORD_ALWAYS             = "Siempre";
    HEALBOT_WORD_SOLO               = "Solo";
    HEALBOT_WORD_NEVER              = "Nunca";
    HEALBOT_SHOW_CLASS_AS_ICON      = "como icono";
    HEALBOT_SHOW_CLASS_AS_TEXT      = "como texto";
HEALBOT_SHOW_ROLE                       = "show role when set";

    HEALBOT_SHOW_INCHEALS           = "Ver sanaci\195\179n entrante";

HEALBOT_HELP={ [1] = "[HealBot] /hb h -- Mostrar ayuda",
               [2] = "[HealBot] /hb o -- Cambiar opciones",
               [3] = "[HealBot] /hb ri -- Restablecer HealBot",
               [4] = "[HealBot] /hb t -- Alternar Healbot entre habilitado y deshabilitado",
               [5] = "[HealBot] /hb bt -- Toggle Buff Monitor between disabled and enabled",
               [6] = "[HealBot] /hb dt -- Toggle Debuff Monitor between disabled and enabled",
               [7] = "[HealBot] /hb skin <nombre de la skin> -- Cambiar skins",
               [8] = "[HealBot] /hb ui -- Recargar UI",
               [9] = "[HealBot] /hb hs -- Display additional slash commands",
              }

HEALBOT_HELP2={ [1] = "[HealBot] /hb d -- Restaurar opciones por defecto",
                [2] = "[HealBot] /hb aggro 2 <n> -- Set aggro level 2 on threat percentage <n>",
                [3] = "[HealBot] /hb aggro 3 <n> -- Set aggro level 3 on threat percentage <n>",
                [4] = "[HealBot] /hb tr <Rol> -- Establece el rol con m\195\161s prioridad para SubOrdenar por Rol. Los roles son 'TANK', 'HEALER' o 'DPS'",
                [5] = "[HealBot] /hb use10 -- Automatically use Engineering slot 10",
                [6] = "[HealBot] /hb pcs <n> -- Adjust the size of the Holy power charge indicator by <n>, Default value is 7 ",
                [7] = "[HealBot] /hb spt -- Self Pet toggle",
                [8] = "[HealBot] /hb ws -- Toggle Hide/Show the Weaken Soul icon instead of the PW:S with a -",
                [9] = "[HealBot] /hb rld <n> -- In seconds, how long the players name stays green after a res",
                [10] = "[HealBot] /hb flb -- Toggle frame lock bypass (frame always moves with Ctrl+Alt+Left click)",
                [11] = "[HealBot] /hb rtb -- Toggle restrict target bar to Left=SmartCast and Right=add/remove to/from My Targets",
              }
              
    HEALBOT_OPTION_HIGHLIGHTACTIVEBAR   = "Destacar barra activa"
HEALBOT_OPTION_HIGHLIGHTTARGETBAR       = "Highlight target"
    HEALBOT_OPTIONS_TESTBARS            = "Prueba de barras"
    HEALBOT_OPTION_NUMBARS              = "N\195\186mero de barras"
    HEALBOT_OPTION_NUMTANKS             = "N\195\186mero de tankes"
    HEALBOT_OPTION_NUMMYTARGETS         = "N\195\186mero de Objetivos"
    HEALBOT_OPTION_NUMPETS              = "N\195\186mero de mascotas"
    HEALBOT_WORD_TEST                   = "Probar";
    HEALBOT_WORD_OFF                    = "Off";
    HEALBOT_WORD_ON                     = "On";

HEALBOT_OPTIONS_TAB_PROTECTION          = "Protection"
HEALBOT_OPTIONS_TAB_CHAT                = "Chat"
    HEALBOT_OPTIONS_TAB_HEADERS         = "Cabeceras"
    HEALBOT_OPTIONS_TAB_BARS            = "Barras"
    HEALBOT_OPTIONS_TAB_ICONS           = "Iconos"
    HEALBOT_OPTIONS_TAB_WARNING         = "Aviso"
    HEALBOT_OPTIONS_SKINDEFAULTFOR      = "Skin para"
    HEALBOT_OPTIONS_INCHEAL             = "Sanaci\195\179n entrante"
    HEALBOT_WORD_ARENA                  = "Arena"
    HEALBOT_WORD_BATTLEGROUND           = "BG"
    HEALBOT_OPTIONS_TEXTOPTIONS         = "Opciones de texto"
    HEALBOT_WORD_PARTY                  = "Grupo"
    HEALBOT_OPTIONS_COMBOAUTOTARGET     = "Auto Target"
    HEALBOT_OPTIONS_COMBOAUTOTRINKET    = "Auto Trinket"
    HEALBOT_OPTIONS_GROUPSPERCOLUMN     = "Grupos por Columna"

    HEALBOT_OPTIONS_MAINSORT            = "Ordenar por"
    HEALBOT_OPTIONS_SUBSORT             = "Subordenar por"
    HEALBOT_OPTIONS_SUBSORTINC          = "Ordenar:"

    HEALBOT_OPTIONS_BUTTONCASTMETHOD    = "Castear si el bot\195\179n se"
    HEALBOT_OPTIONS_BUTTONCASTPRESSED   = "Presiona"
    HEALBOT_OPTIONS_BUTTONCASTRELEASED  = "Libera"

    HEALBOT_INFO_ADDONCPUUSAGE          = "== Uso de CPU del Addon en segundos =="
    HEALBOT_INFO_ADDONCOMMUSAGE         = "== Uso de Comms del Addon =="
HEALBOT_WORD_HEALER                     = "Healer"
HEALBOT_WORD_DAMAGER                    = "Damager"
HEALBOT_WORD_TANK                       = "Tank"
HEALBOT_WORD_LEADER                     = "Leader"
HEALBOT_WORD_VERSION                = "Version"
    HEALBOT_WORD_CLIENT                 = "Cliente"
    HEALBOT_WORD_ADDON                  = "Addon"
    HEALBOT_INFO_CPUSECS                = "CPU Segs"
    HEALBOT_INFO_MEMORYKB               = "Memoria KB"
HEALBOT_INFO_COMMS 		    = "Comms KB"

    HEALBOT_WORD_STAR                   = "Estrella"
    HEALBOT_WORD_CIRCLE                 = "C\195\173rculo"
    HEALBOT_WORD_DIAMOND                = "Diamante"
    HEALBOT_WORD_TRIANGLE               = "Tri\195\161ngulo"
    HEALBOT_WORD_MOON                   = "Luna"
    HEALBOT_WORD_SQUARE                 = "Cuadrado"
    HEALBOT_WORD_CROSS                  = "Cruz"
    HEALBOT_WORD_SKULL                  = "Calavera"

    HEALBOT_OPTIONS_ACCEPTSKINMSG       = "Aceptar skin [de HealBot]: "
    HEALBOT_OPTIONS_ACCEPTSKINMSGFROM   = " de "
    HEALBOT_OPTIONS_BUTTONSHARESKIN     = "Compartir con"

    HEALBOT_CHAT_ADDONID                = "[HealBot]  "
    HEALBOT_CHAT_NEWVERSION1            = "Hay disponible nueva versi\195\179n"
    HEALBOT_CHAT_NEWVERSION2                = "en "..HEALBOT_ABOUT_URL
    HEALBOT_CHAT_SHARESKINERR1          = " Skin no encontrada para Compartir"
    HEALBOT_CHAT_SHARESKINERR3          = " no encontrado para compartir Skin"
    HEALBOT_CHAT_SHARESKINACPT          = "Compartir Skin aceptado de "
    HEALBOT_CHAT_CONFIRMSKINDEFAULTS    = "Skins establecidas por defecto"
    HEALBOT_CHAT_CONFIRMCUSTOMDEFAULTS  = "Debuffs personalizados restablecidos"
    HEALBOT_CHAT_CHANGESKINERR1         = "Skin desconocida: /hb skin "
    HEALBOT_CHAT_CHANGESKINERR2         = "Skins v\195\161lidas:  "
    HEALBOT_CHAT_CONFIRMSPELLCOPY       = "Habilidades actuales copiadas en todas las spec"
    HEALBOT_CHAT_UNKNOWNCMD             = "Comando desconocido: /hb "
    HEALBOT_CHAT_ENABLED                = "Entrando en estado Habilitado"
    HEALBOT_CHAT_DISABLED               = "Entrando en estado Deshabilitado"
    HEALBOT_CHAT_SOFTRELOAD             = "Petici\195\179n de recarga de Healbot"
    HEALBOT_CHAT_HARDRELOAD             = "Recarga de UI completada"
    HEALBOT_CHAT_CONFIRMSPELLRESET      = "Habilidades restablecidas"
    HEALBOT_CHAT_CONFIRMCURESRESET      = "Debuffs restablecidos"
    HEALBOT_CHAT_CONFIRMBUFFSRESET      = "Buffs restablecidos"
    HEALBOT_CHAT_POSSIBLEMISSINGMEDIA = "Imposible recibir todos los datos de la skin - Posiblemente falte SharedMedia Unable to receive all Skin settings - Possibly missing SharedMedia, download from curse.com"
    HEALBOT_CHAT_MACROSOUNDON           = "Sonido no suprimido al usar auto trinkets"
    HEALBOT_CHAT_MACROSOUNDOFF          = "Sonido suprimido al usar auto trinkets"
    HEALBOT_CHAT_MACROERRORON           = "Errores no suprimidos al usar auto trinkets"
    HEALBOT_CHAT_MACROERROROFF          = "Errores suprimidos al usar auto trinkets"
    HEALBOT_CHAT_ACCEPTSKINON           = "Compartir skin - Se muestra un popup cuando alguien comparte una skin contigo"
    HEALBOT_CHAT_ACCEPTSKINOFF          = "Compartir skin - Siempre se ignoran a los jugadores que comparten skins contigo"
    HEALBOT_CHAT_USE10ON                = "Auto Trinket - Use10 on - Debes habilitar un auto trinkwt para que Use10 funcione"
    HEALBOT_CHAT_USE10OFF               = "Auto Trinket - Use10 off"
HEALBOT_CHAT_SKINREC                    = " skin received from " 

    HEALBOT_OPTIONS_SELFCASTS           = "S\195\179lo mis casteos"
    HEALBOT_OPTIONS_HOTSHOWICON         = "Ver iconos"
    HEALBOT_OPTIONS_ALLSPELLS           = "Todos los hechizos"
    HEALBOT_OPTIONS_DOUBLEROW           = "Doble fila"
    HEALBOT_OPTIONS_HOTBELOWBAR         = "Bajo la barra"
    HEALBOT_OPTIONS_OTHERSPELLS         = "Otros hechizos"
    HEALBOT_WORD_MACROS                 = "Macros"
    HEALBOT_WORD_SELECT                 = "Seleccionar"
    HEALBOT_OPTIONS_QUESTION            = "?"
    HEALBOT_WORD_CANCEL                 = "Cancelar"
    HEALBOT_WORD_COMMANDS               = "Comandos"
    HEALBOT_OPTIONS_BARHEALTH3          = "como salud";
    HEALBOT_SORTBY_ROLE                 = "Rol"
    HEALBOT_WORD_DPS                    = "DPS"
    HEALBOT_CHAT_TOPROLEERR             = " rol no v\195\161lido en este contexto - usa 'TANK', 'DPS' o 'HEALER'"
    HEALBOT_CHAT_NEWTOPROLE             = "El top m\195\161s alto es "
    HEALBOT_CHAT_SUBSORTPLAYER1         = "El jugador ser\195\161 el primero en el SubOrden"
    HEALBOT_CHAT_SUBSORTPLAYER2         = "El jugador ser\195\161 ordenado normalmente en el SubOrden"
    HEALBOT_OPTIONS_SHOWREADYCHECK      = "Ver Ready Check";
    HEALBOT_OPTIONS_SUBSORTSELFFIRST    = "Yo primero"
    HEALBOT_WORD_FILTER                 = "Filtro"
    HEALBOT_OPTION_AGGROPCTBAR          = "Mover barra"
    HEALBOT_OPTION_AGGROPCTTXT          = "Ver texto"
    HEALBOT_OPTION_AGGROPCTTRACK        = "Ver porcentaje" 
    HEALBOT_OPTIONS_ALERTAGGROLEVEL1    = "1 - alta amenaza pero no tankea nada"
    HEALBOT_OPTIONS_ALERTAGGROLEVEL2    = "2 - casi tankeando, segundo en amenaza"
    HEALBOT_OPTIONS_ALERTAGGROLEVEL3    = "3 - primero en amenaza. tankeando"
    HEALBOT_OPTIONS_AGGROALERT          = "Nivel de alerta de aggro"
HEALBOT_OPTIONS_AGGROINDALERT           = "Indicator alert level"
    HEALBOT_OPTIONS_TOOLTIPSHOWHOT      = "Mostrar detalles de HOT activos monitorizados"
    HEALBOT_WORDS_MIN                   = "min"
    HEALBOT_WORDS_MAX                   = "max"
    HEALBOT_CHAT_SELFPETSON             = "AutoMascota activado"
    HEALBOT_CHAT_SELFPETSOFF             = "AutoMascota desactivado"
    HEALBOT_WORD_PRIORITY = "Prioridad"
    HEALBOT_VISIBLE_RANGE = "Dentro de 100 metros"
    HEALBOT_SPELL_RANGE   = "Dentro del rango del hechizo"
HEALBOT_WORD_RESET                      = "Reset"
HEALBOT_HBMENU                          = "HBmenu"
HEALBOT_ACTION_HBFOCUS                  = "Left click to set\nfocus on target"
HEALBOT_WORD_CLEAR                      = "Clear"
HEALBOT_WORD_SET                        = "Set"
HEALBOT_WORD_HBFOCUS                    = "HealBot Focus"
HEALBOT_WORD_OUTSIDE                    = "Outside"
HEALBOT_WORD_ALLZONE                    = "All zones"
HEALBOT_OPTIONS_TAB_ALERT               = "Alert"
HEALBOT_OPTIONS_TAB_SORT                = "Sort"
HEALBOT_OPTIONS_TAB_HIDE                = "Hide"
HEALBOT_OPTIONS_TAB_AGGRO               = "Aggro"
HEALBOT_OPTIONS_TAB_ICONTEXT            = "Icon text"
    HEALBOT_OPTIONS_TAB_TEXT            = "Texto"
HEALBOT_OPTIONS_AGGRO3COL               = "Aggro bar\ncolour"
HEALBOT_OPTIONS_AGGROFLASHFREQ          = "Flash frequency"
HEALBOT_OPTIONS_AGGROFLASHALPHA         = "Flash opacity"
HEALBOT_OPTIONS_SHOWDURATIONFROM        = "Show duration from"
HEALBOT_OPTIONS_SHOWDURATIONWARN        = "Duration warning from"
HEALBOT_CMD_RESETCUSTOMDEBUFFS          = "Reset custom debuffs"
HEALBOT_CMD_RESETSKINS                  = "Reset skins"
HEALBOT_CMD_CLEARBLACKLIST              = "Clear BlackList"
HEALBOT_CMD_TOGGLEACCEPTSKINS           = "Toggle accept Skins from others"
HEALBOT_CMD_TOGGLEDISLIKEMOUNT          = "Toggle Dislike Mount"
HEALBOT_OPTION_DISLIKEMOUNT_ON          = "Now Dislike Mount"
HEALBOT_OPTION_DISLIKEMOUNT_OFF         = "No longer Dislike Mount"
HEALBOT_CMD_COPYSPELLS                  = "Copy current spells to all specs"
HEALBOT_CMD_RESETSPELLS                 = "Reset spells"
HEALBOT_CMD_RESETCURES                  = "Reset cures"
HEALBOT_CMD_RESETBUFFS                  = "Reset buffs"
HEALBOT_CMD_RESETBARS                   = "Reset bar position"
HEALBOT_CMD_SUPPRESSSOUND               = "Toggle suppress sound when using auto trinkets"
HEALBOT_CMD_SUPPRESSERRORS              = "Toggle suppress errors when using auto trinkets"
HEALBOT_OPTIONS_COMMANDS                = "HealBot Commands"
HEALBOT_WORD_RUN                        = "Run"
HEALBOT_OPTIONS_MOUSEWHEEL              = "Use mouse wheel"
HEALBOT_OPTIONS_MOUSEUP                 = "Wheel up"
HEALBOT_OPTIONS_MOUSEDOWN               = "Wheel down"
HEALBOT_CMD_DELCUSTOMDEBUFF10           = "Delete custom debuffs on priority 10"
HEALBOT_ACCEPTSKINS                     = "Accept Skins from others"
HEALBOT_SUPPRESSSOUND                   = "Auto Trinket: Suppress sound"
HEALBOT_SUPPRESSERROR                   = "Auto Trinket: Suppress errors"
HEALBOT_OPTIONS_CRASHPROT               = "Crash Protection"
HEALBOT_CP_MACRO_LEN                    = "Macro name must be between 1 and 14 characters"
HEALBOT_CP_MACRO_BASE                   = "Base macro name"
HEALBOT_CP_MACRO_SAVE                   = "Last saved at: "
HEALBOT_CP_STARTTIME                    = "Protect duration on logon"
HEALBOT_WORD_RESERVED                   = "Reserved"
HEALBOT_OPTIONS_COMBATPROT              = "Combat Protection"
HEALBOT_COMBATPROT_PARTYNO              = "bars Reserved for Party"
HEALBOT_COMBATPROT_RAIDNO               = "bars Reserved for Raid"

HEALBOT_WORD_HEALTH                     = "Health"
HEALBOT_OPTIONS_DONT_SHOW               = "Don't show"
HEALBOT_OPTIONS_SAME_AS_HLTH_CURRENT    = "Same as health (current health)"
HEALBOT_OPTIONS_SAME_AS_HLTH_FUTURE     = "Same as health (future health)"
HEALBOT_OPTIONS_FUTURE_HLTH             = "Future health"
HEALBOT_SKIN_HEALTHBARCOL_TEXT          = "Health bar";
HEALBOT_SKIN_HEALTHBACKCOL_TEXT         = "Background bar";
HEALBOT_SKIN_INCHEALBARCOL_TEXT         = "Incoming heals";
HEALBOT_OPTIONS_ALWAYS_SHOW_TARGET      = "Target: Always show"
HEALBOT_OPTIONS_ALWAYS_SHOW_FOCUS       = "Focus: Always show"
HEALBOT_OPTIONS_GROUP_PETS_BY_FIVE      = "Pets: Groups of five"
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
HEALBOT_OPTIONS_CUSTOM_CASTBY           = "Cast By"

HEALBOT_BLIZZARD_MENU                   = "Blizzard menu"
HEALBOT_HB_MENU                         = "Healbot menu"
HEALBOT_FOLLOW                          = "Follow"
HEALBOT_TRADE                           = "Trade"
HEALBOT_PROMOTE_RA                      = "Promote raid assistant"
HEALBOT_DEMOTE_RA                       = "Demote raid assistant"
HEALBOT_TOGGLE_ENABLED                  = "Toggle enabled"
HEALBOT_TOGGLE_MYTARGETS                = "Toggle My Targets"
HEALBOT_TOGGLE_PRIVATETANKS             = "Toggle private tanks"
HEALBOT_RESET_BAR                       = "Reset bar"
HEALBOT_HIDE_BARS                       = "Hide bars over 100 yards"
HEALBOT_RANDOMMOUNT                     = "Random Mount"
HEALBOT_RANDOMGOUNDMOUNT                = "Random Ground Mount"
HEALBOT_RANDOMPET                       = "Random Pet"
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
HEALBOT_PRELOADOPTIONS_ON               = "PreLoad Options turned On"
HEALBOT_PRELOADOPTIONS_OFF              = "PreLoad Options turned Off"
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

HEALBOT_WORD_ENABLE                     = "Enable"
HEALBOT_WORD_DISABLE                    = "Disable"

HEALBOT_OPTIONS_MYCLASS                 = "My Class"

HEALBOT_OPTIONS_CONTENT_ABOUT           = "        About"
HEALBOT_OPTIONS_CONTENT_GENERAL         = "        " .. HEALBOT_OPTIONS_TAB_GENERAL
HEALBOT_OPTIONS_CONTENT_SPELLS          = "        " .. HEALBOT_OPTIONS_TAB_SPELLS
HEALBOT_OPTIONS_CONTENT_SKINS           = "        " .. HEALBOT_OPTIONS_TAB_SKIN
HEALBOT_OPTIONS_CONTENT_CURE            = "        " .. HEALBOT_OPTIONS_TAB_CDC
HEALBOT_OPTIONS_CONTENT_BUFFS           = "        " .. HEALBOT_OPTIONS_TAB_BUFFS
HEALBOT_OPTIONS_CONTENT_TIPS            = "        " .. HEALBOT_OPTIONS_TAB_TIPS
HEALBOT_OPTIONS_CONTENT_MOUSEWHEEL      = "        Mouse Wheel"
HEALBOT_OPTIONS_CONTENT_TEST            = "        Test"
HEALBOT_OPTIONS_CONTENT_USAGE           = "        Usage"
HEALBOT_OPTIONS_REFRESH                 = "Refresh"

HEALBOT_CUSTOM_CATEGORY                 = "Category"
HEALBOT_CUSTOM_CAT_CUSTOM               = "Custom"
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

HEALBOT_CUSTOM_CASTBY_EVERYONE          = "Everyone"
HEALBOT_CUSTOM_CASTBY_ENEMY             = "Enemy"
HEALBOT_CUSTOM_CASTBY_FRIEND            = "Friend"

    HEALBOT_CUSTOM_DEBUFF_CATS = {
             -- Defaults
            [HEALBOT_CUSTOM_CAT_CUSTOM_IMPORTANT]  = 1,
			[HEALBOT_CUSTOM_CAT_CUSTOM_DAMAGE]     = 1,
            [HEALBOT_CUSTOM_CAT_CUSTOM_EFFECT]     = 1,
            [HEALBOT_CUSTOM_CAT_CUSTOM_MISC]       = 1,
	}

HEALBOT_ABOUT_DESC1                    = "Add a panel with skinable bars for healing, decursive, buffing, ressing and aggro tracking"
HEALBOT_ABOUT_WEBSITE                  = "Website:"
HEALBOT_ABOUT_AUTHORH                  = "Author:"
HEALBOT_ABOUT_AUTHORD                  = "Strife"
HEALBOT_ABOUT_CATH                     = "Category:"
HEALBOT_ABOUT_CATD                     = "Unit Frames, Buffs and Debuffs, Combat:Healer"
HEALBOT_ABOUT_CREDITH                  = "Credits:"
HEALBOT_ABOUT_CREDITD                  = "Acirac, Kubik, Von, Aldetal, Brezza, CT"  -- Anyone taking on translations (if required), feel free to add yourself here.
HEALBOT_ABOUT_LOCALH                   = "Localizations:"
HEALBOT_ABOUT_LOCALD                   = "deDE, enUK, esES, frFR, huHU, itIT, koKR, poBR, ruRU, zhCN, zhTW"
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
                                  [10]   = "Options - How do I always use enabled settings",
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
                                          "     1: On the spells tab: Turn on Always Use Enabled \n" ..
                                          "     2: On the spells tab: Turn off SmartCast \n\n" ..
                                          "Note: It is expected that most users will want to \n"..
                                          "          turn SmartCast back on \n\n" ..
                                          "Note: It is expected that experienced users will want to \n" ..
                                          "          turn off Always Use Enabled  \n" ..
                                          "          and set the spells for disabled bars"
                                          
HEALBOT_ABOUT_FAQ_ANSWERS = {     [1]   = "You are monitoring for missing buffs \n\n" .. 
                                          "This can be turned off on the buffs tab \n" ..
                                          "Alternatively click on the bar and cast the buff",
                                  [2]   = "This is blizzard functionality, not Healbot \n\n" .. 
                                          "Using the standard blizzard frames, \n" ..
                                          "try casting a spell thats on Cooldown \n" ..
                                          "Notice how the cursor turns blue. \n\n" ..
                                          "Note: Nothing can be done to prevent this while \n" ..
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
    
    HEALBOT_OPTIONS_LANG                    = "Language"
    HEALBOT_OPTIONS_LANG_ZHCN               = "Chinese (zhCN - by Ydzzs)"
    HEALBOT_OPTIONS_LANG_ENUK               = "English (enUK - by Strife)"
    HEALBOT_OPTIONS_LANG_ENUS               = "English (enUS - by Strife)"
    HEALBOT_OPTIONS_LANG_FRFR               = "French (frFR - by Kubik)"
    HEALBOT_OPTIONS_LANG_DEDE               = "Deutsch (deDE - by Snaomi)"
    HEALBOT_OPTIONS_LANG_HUHU               = "Hungarian (huHU - by Von)"
    HEALBOT_OPTIONS_LANG_KRKR               = "Korean (krKR - translator required)"
    HEALBOT_OPTIONS_LANG_ITIT               = "Italian (itIT - by Brezza)"
    HEALBOT_OPTIONS_LANG_PTBR               = "Portuguese (ptBR - by Aldetal)"
    HEALBOT_OPTIONS_LANG_RURU               = "Russian (ruRU - translator required)"
    HEALBOT_OPTIONS_LANG_ESES               = "Spanish (esES - translator required)"
    HEALBOT_OPTIONS_LANG_TWTW               = "Taiwanese (twTW - translator required)"
    
    HEALBOT_OPTIONS_LANG_ADDON_FAIL1        = "Failed to load addon for localization"
    HEALBOT_OPTIONS_LANG_ADDON_FAIL2        = "Reason for failure is:"
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
