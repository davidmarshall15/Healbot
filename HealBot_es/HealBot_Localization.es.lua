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
--

function HealBot_Lang_esES()
    HealBot_Lang_esALL()
end

function HealBot_Lang_esMX()
    HealBot_Lang_esALL()
end

function HealBot_Lang_esALL()

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
HEALBOT_MONK                            = "Monje";

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

    HEALBOT_RANK   = {[1]="(Rango 1)", [2]="(Rango 2)", [3]="(Rango 3)", [4]="(Rango 4)", [5]="(Rango 5)", [6]="(Rango 6)", [7]="(Rango 7)",
                      [8]="(Rango 8)", [9]="(Rango 9)", [10]="(Rango 10)", [11]="(Rango 11)", [12]="(Rango 12)", [13]="(Rango 13)"}

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

HEALBOT_OPTIONS_FRAMESCALE              = "Escala de frames"
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

HEALBOT_OPTIONS_ITEMS                   = "objetos";

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
    HEALBOT_OPTIONS_TANKHEALS     = "Tanque principal";
HEALBOT_OPTIONS_MAINASSIST              = "Ayudante principal";
HEALBOT_OPTIONS_PRIVATETANKS            = "Tanques secundarios";
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
    HEALBOT_CLASSES_RANGES  = "Rango";
    HEALBOT_CLASSES_HEALERS = "Healers";
    HEALBOT_CLASSES_CUSTOM  = "Personalizado";

    HEALBOT_OPTIONS_SHOWTOOLTIP     = "Ver tooltips";
    HEALBOT_OPTIONS_SHOWDETTOOLTIP  = "Ver informaci\195\179n detallada de habilidades";
HEALBOT_OPTIONS_SHOWCDTOOLTIP           = "Mostrar cd hechizo";
    HEALBOT_OPTIONS_SHOWUNITTOOLTIP = "Ver informaci\195\179n del objetivo";
    HEALBOT_OPTIONS_SHOWRECTOOLTIP  = "Ver recomendaci\195\179n de HoT";
    HEALBOT_TOOLTIP_POSDEFAULT      = "Localizaci\195\179n por defecto";
    HEALBOT_TOOLTIP_POSLEFT         = "Izqda de Healbot";
    HEALBOT_TOOLTIP_POSRIGHT        = "Dcha de Healbot";
    HEALBOT_TOOLTIP_POSABOVE        = "Sobre Healbot";
    HEALBOT_TOOLTIP_POSBELOW        = "Debajo de Healbot";
    HEALBOT_TOOLTIP_POSCURSOR       = "Junto al Cursor";
    HEALBOT_TOOLTIP_RECOMMENDTEXT   = "Recomendaci\195\179n HoT";
    HEALBOT_TOOLTIP_NONE            = "Nada disponible";
    HEALBOT_TOOLTIP_CORPSE          = "Cuerpo de ";
HEALBOT_TOOLTIP_CD                      = " (CD ";
HEALBOT_TOOLTIP_SECS                    = "s)";
    HEALBOT_WORDS_SEC               = "seg";
    HEALBOT_WORDS_CAST              = "Lanzar";
    HEALBOT_WORDS_UNKNOWN           = "Desconocido";
    HEALBOT_WORDS_YES               = "S\195\173";
    HEALBOT_WORDS_NO                = "No";
HEALBOT_WORDS_THIN                      = "Delgado";
HEALBOT_WORDS_THICK                     = "Grueso";

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
    HEALBOT_OPTIONS_BUFFSELF         = "Yo";
    HEALBOT_OPTIONS_BUFFPARTY        = "Grupo";
    HEALBOT_OPTIONS_BUFFRAID         = "Raid";
    HEALBOT_OPTIONS_MONITORBUFFS     = "Monitorizar buffs perdidos";
    HEALBOT_OPTIONS_MONITORBUFFSC    = "Tambi\195\169n en combate";
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
HEALBOT_OPTIONS_IGNOREDEBUFFCOOLDOWN     = "Cuando una sanacion es mayor a 1.5 seg";
HEALBOT_OPTIONS_IGNOREDEBUFFFRIEND       = "Cuando el caster es conocido como amigo";

    HEALBOT_OPTIONS_RANGECHECKFREQ       = "Frec. de chequeo del rango";

    HEALBOT_OPTIONS_HIDEPARTYFRAMES      = "Ocultar grupo";
    HEALBOT_OPTIONS_HIDEPLAYERTARGET     = "Incluir jugador y objetivo";
    HEALBOT_OPTIONS_DISABLEHEALBOT       = "Deshabilitar HealBot";

HEALBOT_ASSIST                          = "Asistente";
HEALBOT_FOCUS                           = "Focus";
HEALBOT_MENU                            = "Menu";
HEALBOT_MAINTANK                        = "Tanque principal";
HEALBOT_MAINASSIST                      = "Asistente principal";
HEALBOT_STOP                            = "Detener";
HEALBOT_TELL                            = "Decir";

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
HEALBOT_ZONE_IC                         = "Isla de la conquista";
HEALBOT_ZONE_SA                         = "Playa de los ancestros";

    HEALBOT_OPTION_AGGROTRACK     = "Monitorizar Aggro"
    HEALBOT_OPTION_AGGROBAR       = "Parpadear"
    HEALBOT_OPTION_AGGROTXT       = ">> Mostrar texto <<"
HEALBOT_OPTION_AGGROIND                 = "Indicador"
    HEALBOT_OPTION_BARUPDFREQ     = "Frecuencia refresco"
    HEALBOT_OPTION_USEFLUIDBARS   = "Usar barras fluidas"
    HEALBOT_OPTION_CPUPROFILE     = "Usar perfil CPU (Informaci\195\179n de uso de CPU)"
    HEALBOT_OPTIONS_RELOADUIMSG   = "Esta opci\195\179n requiere recargar la UI, recargar?"

HEALBOT_BUFF_PVP                        = "PvP"
HEALBOT_BUFF_PVE						= "PvE"
HEALBOT_OPTIONS_ANCHOR                  = "Ancho Marcos"
HEALBOT_OPTIONS_BARSANCHOR              = "Ancho barras"
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

HEALBOT_OPTIONS_NOTIFY_MSG              = "Mensaje"
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
HEALBOT_SHOW_ROLE                       = "Mostrar rol al cargar";

    HEALBOT_SHOW_INCHEALS           = "Ver sanaci\195\179n entrante";

HEALBOT_HELP={ [1] = "[HealBot] /hb h -- Mostrar ayuda",
               [2] = "[HealBot] /hb o -- Cambiar opciones",
               [3] = "[HealBot] /hb ri -- Restablecer HealBot",
               [4] = "[HealBot] /hb t -- Alternar Healbot entre habilitado y deshabilitado",
               [5] = "[HealBot] /hb bt -- Alternar monitor de buffs entre habilitado y deshabilitado",
               [6] = "[HealBot] /hb dt -- Alternar monitor de debuffs entre habilitado y deshabilitado",
               [7] = "[HealBot] /hb skin <nombre de la skin> -- Cambiar skins",
               [8] = "[HealBot] /hb ui -- Recargar UI",
               [9] = "[HealBot] /hb hs -- Mostrar comandos / adicionales",
              }

HEALBOT_HELP2={ [1] = "[HealBot] /hb d -- Restaurar opciones por defecto",
                [2] = "[HealBot] /hb aggro 2 <n> -- Poner agro nivel 2 en porcentaje de amenaza <n>",
                [3] = "[HealBot] /hb aggro 3 <n> -- Poner agro nivel 3 en porcentaje de amenaza <n>",
                [4] = "[HealBot] /hb tr <Rol> -- Establece el rol con m\195\161s prioridad para SubOrdenar por Rol. Los roles son 'TANQUE', 'HEALER' o 'DPS'",
                [5] = "[HealBot] /hb use10 -- Automaticamente usa el slot de Inginieria 10",
                [6] = "[HealBot] /hb pcs <n> -- Ajusta el tama\195\177o del indicador de carga de poder sagrado por <n>, Valor por defecto es 7 ",
                [7] = "[HealBot] /hb spt -- Alternar mascota segura",
                [8] = "[HealBot] /hb ws -- Alternar Ocultar/Mostrar el icono de alma debilidad en lugar de PW:S con un -",
                [9] = "[HealBot] /hb rld <n> -- En segundos, Cuanto se mantienen los nombres en verde despues de una resurrecci\195\179n",
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

HEALBOT_OPTIONS_TAB_PROTECTION          = "Proteccion"
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
HEALBOT_WORD_DAMAGER                    = "Dps"
HEALBOT_WORD_TANK                       = "Tanque"
HEALBOT_WORD_LEADER                     = "Lider"
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
    HEALBOT_CHAT_POSSIBLEMISSINGMEDIA = "Imposible recibir todos los datos de la skin - Posiblemente falte SharedMedia, descargar de curse.com"
    HEALBOT_CHAT_MACROSOUNDON           = "Sonido no suprimido al usar auto trinkets"
    HEALBOT_CHAT_MACROSOUNDOFF          = "Sonido suprimido al usar auto trinkets"
    HEALBOT_CHAT_MACROERRORON           = "Errores no suprimidos al usar auto trinkets"
    HEALBOT_CHAT_MACROERROROFF          = "Errores suprimidos al usar auto trinkets"
    HEALBOT_CHAT_ACCEPTSKINON           = "Compartir skin - Se muestra un popup cuando alguien comparte una skin contigo"
    HEALBOT_CHAT_ACCEPTSKINOFF          = "Compartir skin - Siempre se ignoran a los jugadores que comparten skins contigo"
    HEALBOT_CHAT_USE10ON                = "Auto Trinket - Use10 on - Debes habilitar un auto trinkwt para que Use10 funcione"
    HEALBOT_CHAT_USE10OFF               = "Auto Trinket - Use10 off"
HEALBOT_CHAT_SKINREC                    = " skin recibida de " 

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
HEALBOT_OPTIONS_AGGROINDALERT           = "Indicador de nivel de alerta"
    HEALBOT_OPTIONS_TOOLTIPSHOWHOT      = "Mostrar detalles de HOT activos monitorizados"
    HEALBOT_WORDS_MIN                   = "min"
    HEALBOT_WORDS_MAX                   = "max"
    HEALBOT_CHAT_SELFPETSON             = "AutoMascota activado"
    HEALBOT_CHAT_SELFPETSOFF            = "AutoMascota desactivado"
    HEALBOT_WORD_PRIORITY 				= "Prioridad"
    HEALBOT_VISIBLE_RANGE				= "Dentro de 100 metros"
    HEALBOT_SPELL_RANGE  				= "Dentro del rango del hechizo"
HEALBOT_WORD_RESET                      = "Reset"
HEALBOT_HBMENU                          = "HBmenu"
HEALBOT_ACTION_HBFOCUS                  = "click izquierdo para set\nfocus sobre un objetivo"
HEALBOT_WORD_CLEAR                      = "Limpiar"
HEALBOT_WORD_SET                        = "Set"
HEALBOT_WORD_HBFOCUS                    = "HealBot Focus"
HEALBOT_WORD_OUTSIDE                    = "Exterior"
HEALBOT_WORD_ALLZONE                    = "Todas las zonas"
HEALBOT_OPTIONS_TAB_ALERT               = "Alerta"
HEALBOT_OPTIONS_TAB_SORT                = "Ordenar"
HEALBOT_OPTIONS_TAB_HIDE                = "Ocultar"
HEALBOT_OPTIONS_TAB_AGGRO               = "Aggro"
HEALBOT_OPTIONS_TAB_ICONTEXT            = "Texto del icono"
    HEALBOT_OPTIONS_TAB_TEXT            = "Texto"
HEALBOT_OPTIONS_AGGRO3COL               = "Aggro bar\ncolour"
HEALBOT_OPTIONS_AGGROFLASHFREQ          = "Flash frecuencia"
HEALBOT_OPTIONS_AGGROFLASHALPHA         = "Flash opacidad"
HEALBOT_OPTIONS_SHOWDURATIONFROM        = "Mostrar duracion de"
HEALBOT_OPTIONS_SHOWDURATIONWARN        = "Aviso duracion de"
HEALBOT_CMD_RESETCUSTOMDEBUFFS          = "Resetear custom debuffs"
HEALBOT_CMD_RESETSKINS                  = "Resetear skins"
HEALBOT_CMD_CLEARBLACKLIST              = "Limpiar lista negra"
HEALBOT_CMD_TOGGLEACCEPTSKINS           = "Cambiar: aceptar skins de otros "
HEALBOT_CMD_TOGGLEDISLIKEMOUNT          = "Cambiar montura que no te gusta"
HEALBOT_OPTION_DISLIKEMOUNT_ON          = "No me gusta esta montura"
HEALBOT_OPTION_DISLIKEMOUNT_OFF         = "Quitar no me gusta esta montura"
HEALBOT_CMD_COPYSPELLS                  = "Copiar los hechizos actuales para todas las especializaciones"
HEALBOT_CMD_RESETSPELLS                 = "Reset hechizos"
HEALBOT_CMD_RESETCURES                  = "Reset curas"
HEALBOT_CMD_RESETBUFFS                  = "Reset buffs"
HEALBOT_CMD_RESETBARS                   = "Resetear posicion barras"
HEALBOT_CMD_SUPPRESSSOUND               = "Cambiar suprimir error de sonido cuando se esta usando autotrinket"
HEALBOT_CMD_SUPPRESSERRORS              = "Cambiar suprimir alerta error cuando se esta usando autotrinket"
HEALBOT_OPTIONS_COMMANDS                = "Comandos HealBot"
HEALBOT_WORD_RUN                        = "Correr"
HEALBOT_OPTIONS_MOUSEWHEEL              = "Usar rueda del raton"
HEALBOT_OPTIONS_MOUSEUP                 = "Rueda arriba"
HEALBOT_OPTIONS_MOUSEDOWN               = "Rueda abajo"
HEALBOT_CMD_DELCUSTOMDEBUFF10           = "Eliminar custom debuffs en prioridad 10"
HEALBOT_ACCEPTSKINS                     = "Acceptar skins de otros"
HEALBOT_SUPPRESSSOUND                   = "Auto Trinket: Suprimir sonido"
HEALBOT_SUPPRESSERROR                   = "Auto Trinket: Suprimir error"
HEALBOT_OPTIONS_CRASHPROT               = "Crash Proteccion"
HEALBOT_OPTIONS_USEGENERALMACRO         = "Usar slots de macro general"
HEALBOT_CP_MACRO_LEN                    = "El nombre de la macro debe tener entre 1 a 14 letras"
HEALBOT_CP_MACRO_BASE                   = "Nombre base de Macro"
HEALBOT_CP_MACRO_SAVE                   = "Guardado por ultima vez en: "
HEALBOT_CP_STARTTIME                    = "Protejer la duracion en el logeo"
HEALBOT_WORD_RESERVED                   = "Reservado"
HEALBOT_OPTIONS_COMBATPROT              = "Proteccion en combate"
HEALBOT_COMBATPROT_PARTYNO              = "Barras reservadas para Grupo"
HEALBOT_COMBATPROT_RAIDNO               = "Barras reservadas para Raid"

HEALBOT_WORD_HEALTH                     = "Salud"
HEALBOT_OPTIONS_DONT_SHOW               = "No mostrar"
HEALBOT_OPTIONS_SAME_AS_HLTH_CURRENT    = "Igual que la salud (Salud actual)"
HEALBOT_OPTIONS_SAME_AS_HLTH_FUTURE     = "Igual que la salud (Salud entrante)"
HEALBOT_OPTIONS_FUTURE_HLTH             = "Salud entrante"
HEALBOT_SKIN_HEALTHBARCOL_TEXT          = "Barra de salud";
HEALBOT_SKIN_HEALTHBACKCOL_TEXT         = "Barras secundarias";
HEALBOT_SKIN_INCHEALBARCOL_TEXT         = "Sanaciones entrantes";
HEALBOT_OPTIONS_ALWAYS_SHOW_TARGET      = "Objetivo: Mostrar siempre"
HEALBOT_OPTIONS_ALWAYS_SHOW_FOCUS       = "Focus: Mostrar siempre"
HEALBOT_OPTIONS_GROUP_PETS_BY_FIVE      = "Mascotas: Grupos de cinco"
HEALBOT_OPTIONS_USEGAMETOOLTIP          = "Usar Tooltip del juego"
HEALBOT_OPTIONS_SHOWPOWERCOUNTER        = "Mostrar contador de poder"
HEALBOT_OPTIONS_SHOWPOWERCOUNTER_PALA   = "Mostrar poder sagrado"
HEALBOT_OPTIONS_SHOWPOWERCOUNTER_MONK   = "Mostrar chi"
HEALBOT_OPTIONS_CUSTOMDEBUFF_REVDUR     = "Duracion inversa"
HEALBOT_OPTIONS_DISABLEHEALBOTSOLO      = "Solo cuando estoy solo"
HEALBOT_OPTIONS_CUSTOM_ALLDISEASE       = "Todas las enfermedades"
HEALBOT_OPTIONS_CUSTOM_ALLMAGIC         = "Todas las magias"
HEALBOT_OPTIONS_CUSTOM_ALLCURSE         = "Todas las maldiciones"
HEALBOT_OPTIONS_CUSTOM_ALLPOISON        = "Todos los venenos"
HEALBOT_OPTIONS_CUSTOM_CASTBY           = "Casteado por"

HEALBOT_BLIZZARD_MENU                   = "Blizzard menu"
HEALBOT_HB_MENU                         = "Healbot menu"
HEALBOT_FOLLOW                          = "Seguir"
HEALBOT_TRADE                           = "Comerciar"
HEALBOT_PROMOTE_RA                      = "Promover assistente de raid"
HEALBOT_DEMOTE_RA                       = "Quitar assistente de raid"
HEALBOT_TOGGLE_ENABLED                  = "Cambiar Activado"
HEALBOT_TOGGLE_MYTARGETS                = "Cambiar mis objetivos"
HEALBOT_TOGGLE_PRIVATETANKS             = "Cambiar tanques ayudantes"
HEALBOT_RESET_BAR                       = "Resetear barra"
HEALBOT_HIDE_BARS                       = "Ocultar barras a mas de 100 yardas"
HEALBOT_RANDOMMOUNT                     = "Montura aleatoria"
HEALBOT_RANDOMGOUNDMOUNT                = "Montura terrestre aleatoria"
HEALBOT_RANDOMPET                       = "Mascota aleatoria"
HEALBOT_ZONE_AQ40                       = "Ahn'Qiraj"
HEALBOT_ZONE_VASHJIR1                   = "Bosque Kelp'thar"
HEALBOT_ZONE_VASHJIR2                   = "Extension Bru\195\177ida"
HEALBOT_ZONE_VASHJIR3                   = "Profundidades Abisales"
HEALBOT_ZONE_VASHJIR                    = "Vashj'ir"
HEALBOT_RESLAG_INDICATOR                = "Keep name green after res set to" 
HEALBOT_RESLAG_INDICATOR_ERROR          = "Keep name green after res must be between 1 and 30" 
HEALBOT_FRAMELOCK_BYPASS_OFF            = "Frame lock bypass turned Off"
HEALBOT_FRAMELOCK_BYPASS_ON             = "Frame lock bypass (Ctl+Alt+Left) turned On"
HEALBOT_RESTRICTTARGETBAR_ON            = "Restrict Target bar turned On"
HEALBOT_RESTRICTTARGETBAR_OFF           = "Restrict Target bar turned Off"
HEALBOT_PRELOADOPTIONS_ON               = "Precargar Opciones esta encendido"
HEALBOT_PRELOADOPTIONS_OFF              = "Precargar Opciones esta apagado"
HEALBOT_AGGRO2_ERROR_MSG                = "To set aggro level 2, threat percentage must be between 25 and 95"
HEALBOT_AGGRO3_ERROR_MSG                = "To set aggro level 3, threat percentage must be between 75 and 100"
HEALBOT_AGGRO2_SET_MSG                  = "Aggro level 2 set at threat percentage "
HEALBOT_AGGRO3_SET_MSG                  = "Aggro level 3 set at threat percentage "
HEALBOT_WORD_THREAT                     = "Amenaza"
HEALBOT_AGGRO_ERROR_MSG                 = "Nivel de aggro invalido - use 2 o 3"

HEALBOT_OPTIONS_QUERYTALENTS            = "Consultar informacion de talentos"       
HEALBOT_OPTIONS_LOWMANAINDICATOR        = "Indicador de mana bajo"
HEALBOT_OPTIONS_LOWMANAINDICATOR1       = "No mostrar"
HEALBOT_OPTIONS_LOWMANAINDICATOR2       = "*10% / **20% / ***30%"
HEALBOT_OPTIONS_LOWMANAINDICATOR3       = "*15% / **30% / ***45%"
HEALBOT_OPTIONS_LOWMANAINDICATOR4       = "*20% / **40% / ***60%"
HEALBOT_OPTIONS_LOWMANAINDICATOR5       = "*25% / **50% / ***75%"
HEALBOT_OPTIONS_LOWMANAINDICATOR6       = "*30% / **60% / ***90%"

HEALBOT_OPTION_IGNORE_AURA_RESTED       = "Ignore aura events when resting"
HEALBOT_OPTION_ADJUST_MAX_HEALTH        = "Adjust unit max health"

HEALBOT_WORD_ENABLE                     = "Activar"
HEALBOT_WORD_DISABLE                    = "Desactivar"

HEALBOT_OPTIONS_MYCLASS                 = "Mi clase"

HEALBOT_OPTIONS_CONTENT_ABOUT           = "        Acerca de"
HEALBOT_OPTIONS_CONTENT_GENERAL         = "        " .. HEALBOT_OPTIONS_TAB_GENERAL
HEALBOT_OPTIONS_CONTENT_SPELLS          = "        " .. HEALBOT_OPTIONS_TAB_SPELLS
HEALBOT_OPTIONS_CONTENT_SKINS           = "        " .. HEALBOT_OPTIONS_TAB_SKIN
HEALBOT_OPTIONS_CONTENT_CURE            = "        " .. HEALBOT_OPTIONS_TAB_CDC
HEALBOT_OPTIONS_CONTENT_BUFFS           = "        " .. HEALBOT_OPTIONS_TAB_BUFFS
HEALBOT_OPTIONS_CONTENT_TIPS            = "        " .. HEALBOT_OPTIONS_TAB_TIPS
HEALBOT_OPTIONS_CONTENT_MOUSEWHEEL      = "        Rueda del mouse"
HEALBOT_OPTIONS_CONTENT_TEST            = "        Test"
HEALBOT_OPTIONS_CONTENT_USAGE           = "        Uso"
HEALBOT_OPTIONS_REFRESH                 = "Refrescar"

HEALBOT_CUSTOM_CATEGORY                 = "Categoria"
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

HEALBOT_CUSTOM_CASTBY_EVERYONE          = "Cualquiera"
HEALBOT_CUSTOM_CASTBY_ENEMY             = "Enemigo"
HEALBOT_CUSTOM_CASTBY_FRIEND            = "Amigo"

HEALBOT_ABOUT_DESC1                    = "Agrega un panel con barras personalizables para curar, limpiar, buffear, revivir y vigilar agro"
HEALBOT_ABOUT_WEBSITE                  = "Pagina web:"
HEALBOT_ABOUT_AUTHORH                  = "Autor:"
HEALBOT_ABOUT_AUTHORD                  = "Strife"
HEALBOT_ABOUT_CATH                     = "Categoria:"
HEALBOT_ABOUT_CATD                     = "Unit Frames, Buffs y Debuffs, Combat:Healer"
HEALBOT_ABOUT_CREDITH                  = "Creditos:"
HEALBOT_ABOUT_CREDITD                  = "Acirac, Kubik, Von, Aldetal, Brezza, CT, Milotic"  -- Anyone taking on translations (if required), feel free to add yourself here.
HEALBOT_ABOUT_LOCALH                   = "Traducciones:"
HEALBOT_ABOUT_LOCALD                   = "deDE, enUK, esES, esMX, frFR, huHU, itIT, koKR, poBR, ruRU, zhCN, zhTW"
HEALBOT_ABOUT_FAQH                     = "Preguntas frecuentes"
HEALBOT_ABOUT_FAQ_QUESTION             = "Pregunta"
HEALBOT_ABOUT_FAQ_ANSWER               = "Respuesta"

HEALBOT_ABOUT_FAQ_QUESTIONS = {   [1]   = "Buffs - Todas las barras estan en blanco, Que paso",
                                  [2]   = "Casteando - Aveces el cursor se vuelve azul y yo no puedo hacer nada",
                                  [3]   = "Macros - Tienes algun ejemplo de CD",
                                  [4]   = "Macros - Tienes cualquier ejemplo de hechizo casteando",
                                  [5]   = "Mouse - Como yo puedo usar mis mouseover macros con la rueda del mouse",
                                  [6]   = "Opciones - Pueden las barras ser ordenadas por grupo, por ejemplo tener 2 grupos por columna",
                                  [7]   = "Opciones - Yo puedo ocultar todas las barras y solo mostrar aquellas que esten necesitando que un debuff sea removido",
                                  [8]   = "Opciones - Yo puedo ocultar la sanacion entrante",
                                  [9]   = "Opciones - Healbot no guarda mis opciones cuando yo logeo/desconecto",
                                  [10]   = "Options - How do I always use enabled settings",
                                  [11]  = "Options - How do I disable healbot automatically",
                                  [12]  = "Options - How do I make the bars grow a different direction",
                                  [13]  = "Options - How do I setup 'My Targets'",
                                  [14]  = "Options - How do I setup 'Private Tanks'",
                                  [15]  = "Opciones - Puede Healbot crear una barra para un NPC",
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

HEALBOT_OPTIONS_SKINAUTHOR              = "Autor de la skin:"
HEALBOT_OPTIONS_AVOIDBLUECURSOR         = "Avoid\nBlue Cursor"
HEALBOT_PLAYER_OF_REALM                 = "de"
    
    HEALBOT_OPTIONS_LANG                    = "Idioma"
    HEALBOT_OPTIONS_LANG_ZHCN               = "Chino (zhCN)"
    HEALBOT_OPTIONS_LANG_ENUK               = "Ingles Inglaterra (enUK)"
    HEALBOT_OPTIONS_LANG_ENUS               = "Ingles USA (enUS)"
    HEALBOT_OPTIONS_LANG_FRFR               = "Frances (frFR)"
    HEALBOT_OPTIONS_LANG_DEDE               = "Aleman (deDE)"
    HEALBOT_OPTIONS_LANG_HUHU               = "Hungaro (huHU)"
    HEALBOT_OPTIONS_LANG_KRKR               = "Coreano (krKR)"
    HEALBOT_OPTIONS_LANG_ITIT               = "Italiano (itIT)"
    HEALBOT_OPTIONS_LANG_PTBR               = "Portugues (ptBR)"
    HEALBOT_OPTIONS_LANG_RURU               = "Ruso (ruRU)"
    HEALBOT_OPTIONS_LANG_ESES               = "Español (esES)"
    HEALBOT_OPTIONS_LANG_TWTW               = "Taiwanes (twTW)"
    HEALBOT_OPTIONS_LANG_ESMX               = "Español latinoamerica (esMX)"
    
    HEALBOT_OPTIONS_LANG_ADDON_FAIL1        = "Failed to load addon for localization"
    HEALBOT_OPTIONS_LANG_ADDON_FAIL2        = "La razon del fallo es:"
    HEALBOT_OPTIONS_LANG_ADDON_FAIL3        = "Note in the current verison, this is the only warning for"
    
    HEALBOT_OPTIONS_ADDON_FAIL              = "Error para cargar Healbot addon"
    
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
    
    HEALBOT_SKIN_ABSORBCOL_TEXT             = "Efectos de absorcion";
    HEALBOT_OPTIONS_BARALPHAABSORB          = "Opacidad de los efectos de absorcion";
    HEALBOT_OPTIONS_OUTLINE                 = "Desconectado"
    HEALBOT_OPTIONS_FRAME                   = "Frame"
    HEALBOT_OPTIONS_CONTENT_SKINS_FRAMES    = "    " .. "Frames"
    HEALBOT_OPTIONS_FRAMESOPTTEXT           = "Frames options"
    HEALBOT_OPTIONS_SETTOOLTIP_POSITION     = "Set Tooltip Position"
    HEALBOT_OPTIONS_FRAME_ALIAS             = "Frame Title"
    HEALBOT_OPTIONS_FRAME_ALIAS_SHOW        = "Mostrar titulo"
    HEALBOT_OPTIONS_GROW_DIRECTION          = "Grow Direction"
    HEALBOT_OPTIONS_GROW_HORIZONTAL         = "Horizontal"
    HEALBOT_OPTIONS_GROW_VERTICAL           = "Vertical"
    HEALBOT_OPTIONS_FONT_OFFSET             = "Font Offset"
    HEALBOT_OPTIONS_SET_FRAME_HEALGROUPS    = "Assign Heal Groups"
    HEALBOT_OPTION_EXCLUDEMOUNT_ON          = "Now Excluding Mount"
    HEALBOT_OPTION_EXCLUDEMOUNT_OFF         = "No longer Excluding Mount"
    HEALBOT_CMD_TOGGLEEXCLUDEMOUNT          = "Toggle Exclude Mount"
    HEALBOT_OPTIONS_HIDEMINIBOSSFRAMES      = "Ocultar barras de Miniboss";
    HEALBOT_OPTIONS_FRAME_ALIAS             = "Alias"
    HEALBOT_OPTIONS_CONTENT_SKINS_HEALGROUP = "        " .. "Heal Groups"
    HEALBOT_OPTIONS_CONTENT_SKINS_BARCOLOUR = "        " .. "Bar Colors";
    HEALBOT_OPTIONS_SET_ALL_FRAMES          = "Apply current tab settings to all Frames"
    HEALBOT_WORDS_PROFILE                   = "Perfil"
    HEALBOT_SHARE_SCREENSHOT                = "Captura de pantalla tomada"
    HEALBOT_SHARE_INSTRUCTION               = "Go to the website for instrunctions on sharing with "..HEALBOT_ABOUT_URL
    HEALBOT_ENEMY_USE_FRAME                 = "Use frame"
    HEALBOT_ENEMY_INCLUDE_SELF              = "Include my target"
    HEALBOT_ENEMY_INCLUDE_TANKS             = "Include tanks targets"
    HEALBOT_OPTIONS_ENEMY_OPT               = "Enemy Options";
    HEALBOT_OPTIONS_SHARE_OPT               = "Compartir opciones";
    HEALBOT_OPTIONS_CONTENT_SKINS_SHARE     = "    " .. "Share"
    HEALBOT_OPTIONS_CONTENT_SKINS_ENEMY     = "    " .. "Enemy"
    HEALBOT_OPTIONS_BUTTONLOADSKIN          = "Cargar skin"
    HEALBOT_ENEMY_NO_TARGET                 = "Sin objetivo"
    HEALBOT_OPTIONS_ENEMYBARS               = "Enemy bars at all times";
    HEALBOT_OPTIONS_HARMFUL_SPELLS          = "Harmful Spells"
    HEALBOT_ENEMY_INCLUDE_MYTARGETS         = "Include My Targets targets"
    HEALBOT_ENEMY_NUMBER_BOSSES             = "Numero de boss"
    HEALBOT_ENEMY_HIDE_OUTOFCOMBAT          = "Ocultar barras fuera de combate"
    HEALBOT_ENEMY_EXISTS_SHOW               = "Entering combat only".."\n".."show when exists"
    HEALBOT_ENEMY_EXISTS_SHOW_PTARGETS      = "Player targets"
    HEALBOT_ENEMY_EXISTS_SHOW_BOSSES        = "Barras del boss"
    HEALBOT_OPTIONS_TARGET_ONLY_FRIEND      = "Target: Only show Friendly"
    HEALBOT_OPTIONS_FOCUS_ONLY_FRIEND       = "Focus: Only show Friendly"
    HEALBOT_OPTIONS_PROFILE                 = "Profile for".."\n".."Spells/Buffs/Cures"
    HEALBOT_OPTIONS_PROFILE_CHARACTER       = "Personaje"
    HEALBOT_OPTIONS_PROFILE_CLASS           = "Clase"
    HEALBOT_OPTIONS_INCOMBATALERTLEVEL      = "Alert Level - In Combat";
    HEALBOT_OPTIONS_OUTCOMBATALERTLEVEL     = "Alert Level - Out of Combat";
    HEALBOT_OPTION_NUMENEMYS                = "Numero de enemigos"
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
