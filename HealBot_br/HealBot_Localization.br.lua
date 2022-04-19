-- Brazilian translator required

---------------
-- Brazilian --
---------------
--
--
--
--

function HealBot_Lang_ptBR()

    -----------------
    -- Translation --
    -----------------

    -- Class
    HEALBOT_DRUID                           = "Druida";
    HEALBOT_HUNTER                          = "Ca\195\167ador";
    HEALBOT_MAGE                            = "Mago";
    HEALBOT_PALADIN                         = "Paladino";
    HEALBOT_PRIEST                          = "Sacerdote";
    HEALBOT_ROGUE                           = "Ladino";
    HEALBOT_SHAMAN                          = "Xam\195\163";
    HEALBOT_WARLOCK                         = "Bruxo";
    HEALBOT_WARRIOR                         = "Guerreiro";
    HEALBOT_DEATHKNIGHT                     = "Cavaleiro da Morte";
    HEALBOT_DEMONHUNTER                     = "Demon Hunter";
    HEALBOT_MONK                            = "Monge";

    HEALBOT_DISEASE                         = "Infec\195\167\195\163o";
    HEALBOT_MAGIC                           = "Magia";
    HEALBOT_CURSE                           = "Maldi\195\167\195\163o";
    HEALBOT_POISON                          = "Veneno";

    HB_TOOLTIP_OFFLINE                      = "Desconectado";



    HEALBOT_HEALBOT                         = "HealBot";
    HEALBOT_ADDON                           = HEALBOT_HEALBOT .. " " .. HEALBOT_VERSION;
    HEALBOT_LOADED                          = " carregado.";

    HEALBOT_RANK   = {[1]="(Rango 1)", [2]="(Rango 2)", [3]="(Rango 3)", [4]="(Rango 4)", [5]="(Rango 5)", [6]="(Rango 6)", [7]="(Rango 7)",
                      [8]="(Rango 8)", [9]="(Rango 9)", [10]="(Rango 10)", [11]="(Rango 11)", [12]="(Rango 12)", [13]="(Rango 13)"}

    HEALBOT_ACTION_OPTIONS                  = "Op\195\167\195\181es";
    HEALBOT_ACTION_UNLOCKED                 = "Unlocked";

    HEALBOT_OPTIONS_TITLE                   = HEALBOT_ADDON;
    HEALBOT_OPTIONS_DEFAULTS                = "Padr\195\163o";
    HEALBOT_OPTIONS_LOCALDEFAULTS           = "Local Defaults";
    HEALBOT_OPTIONS_CLOSE                   = "Fechar";
    HEALBOT_OPTIONS_HARDRESET               = "ReloadUI"
    HEALBOT_OPTIONS_SOFTRESET               = "ResetarHB"
    HEALBOT_OPTIONS_COPY                    = "Copy";
    HEALBOT_OPTIONS_TAB_GENERAL             = "Geral";
    HEALBOT_OPTIONS_TAB_SPELLS              = "Magias";
    HEALBOT_OPTIONS_TAB_FRAMES              = "Frames";
    HEALBOT_OPTIONS_TAB_HEALING             = "Curas";
    HEALBOT_OPTIONS_TAB_SKIN                = "Skins";
    HEALBOT_OPTIONS_TAB_TIPS                = "Dicas";
    HEALBOT_OPTIONS_TAB_DEBUFFS             = "Debuffs"
    HEALBOT_OPTIONS_TAB_CUSTOM_DEBUFFS      = "Custom Debuffs";
    HEALBOT_OPTIONS_TAB_CUSTOM_BUFFS        = "Custom Buffs";
    HEALBOT_OPTIONS_TAB_BUFFS               = "Buffs"
    HEALBOT_OPTIONS_TAB_GENERALBUFFS        = "General Buffs"
    HEALBOT_OPTIONS_TAB_STATETEXT           = "State";
    HEALBOT_OPTIONS_TAB_NAMETEXT            = "Name";
    HEALBOT_OPTIONS_TAB_OVERRIDES           = "Overrides"
    HEALBOT_OPTIONS_TAB_EXTRAS              = "Extras"
    
    HEALBOT_STRING_MATCH_WELLFED            = "become well fed"

    HEALBOT_OPTIONS_GLOBAL                  = "Global"
    HEALBOT_OPTIONS_ALPHA                   = "Opacity";
    HEALBOT_OPTIONS_BARALPHA                = "Habilitar opacidade";
    HEALBOT_OPTIONS_BARALPHAINHEAL          = "Opacidade de Curas Futuras";
    HEALBOT_OPTIONS_BARALPHABACK            = "Opacidade do fundo da barra";
    HEALBOT_OPTIONS_BARALPHAEOR             = "Opacidade de Fora de Alcance";
    HEALBOT_OPTIONS_ACTIONLOCKED            = "Travar posi\195\167\195\163o";
    HEALBOT_OPTIONS_UNITINCOMBAT            = "Group/Raid member enters combat"
    HEALBOT_OPTIONS_UNITINCOMBAT01          = "Do nothing"
    HEALBOT_OPTIONS_UNITINCOMBAT02          = "Show enemy frame"
    HEALBOT_OPTIONS_UNITINCOMBAT03          = "Lockdown HealBot"
    HEALBOT_OPTIONS_AUTOSHOW                = "Fechar automaticamente";
    HEALBOT_OPTIONS_HIDEOPTIONS             = "Ocultar bot\195\163o de op\195\167\195\181es";
    HEALBOT_OPTIONS_HIDEUNLOCKEDTAG         = "Hide unlocked tag"
    HEALBOT_OPTIONS_PROTECTPVP              = "Evitar JxJ";
    HEALBOT_OPTIONS_HEAL_CHATOPT            = "Op\195\167\195\181es de Conversa";
    HEALBOT_OPTIONS_BLIZZARD_FRAMES         = "Blizzard Frames";

    HEALBOT_OPTIONS_FRAMESCALE              = "Escala do quadro"
    HEALBOT_OPTIONS_STICKFRAMEOFFSETH       = "Sticky frame horizontal offset"
    HEALBOT_OPTIONS_STICKFRAMEOFFSETV       = "Sticky frame vertical offset"
    HEALBOT_OPTIONS_SKINTEXT                = "Usar skin"
    HEALBOT_SKINS_STD                       = "Padr\195\163o"
    HEALBOT_OPTIONS_SKINTEXTURE             = "Textura"
    HEALBOT_OPTIONS_SKINHEIGHT              = "Altura"
    HEALBOT_OPTIONS_SKINWIDTH               = "Comprimento"
    HEALBOT_OPTIONS_SKINNUMCOLS             = "No. colunas"
    HEALBOT_OPTIONS_SKINNUMHCOLS            = "No. grupos por coluna"
    HEALBOT_OPTIONS_SKINBRSPACE             = "Espa\195\167o entre linhas"
    HEALBOT_OPTIONS_SKINBCSPACE             = "Espa\195\167o entre colunas"
    HEALBOT_SORTBY_NAME                     = "Nome"
    HEALBOT_SORTBY_CLASS                    = "Classe"
    HEALBOT_SORTBY_GROUP                    = "Grupo"
    HEALBOT_SORTBY_MAXHEALTH                = "HP M\195\161ximo"
    HEALBOT_SORTBY_UNITID                   = "Unit ID"
    HEALBOT_OPTIONS_NEWDEBUFFTEXT           = "Novo debuff"
    HEALBOT_OPTIONS_NEWHOTBUFFTEXT          = "New Buff"
    HEALBOT_OPTIONS_DELSKIN                 = "Excluir"
    HEALBOT_OPTIONS_NEWSKINTEXT             = "Novo skin"
    HEALBOT_OPTIONS_SAVESKIN                = "Salvar"
    HEALBOT_OPTIONS_SKINBARS                = "Op\195\167\195\181es da Barra"
    HEALBOT_SKIN_ENTEXT                     = "Habilitado"
    HEALBOT_SKIN_DISTEXT                    = "Desabilitado"
    HEALBOT_SKIN_DEBTEXT                    = "Debuff"
    HEALBOT_SKIN_BACKTEXT                   = "Fundo"
    HEALBOT_SKIN_BORDERTEXT                 = "Borda"
    HEALBOT_OPTIONS_SKINFONT                = "Fonte"
    HEALBOT_OPTIONS_SKINFHEIGHT             = "Tamanho da Fonte"
    HEALBOT_OPTIONS_SKINFOUTLINE            = "Contorno da Fonte"
    HEALBOT_OPTIONS_BARALPHADIS             = "Opacidade desabilitada"
    HEALBOT_OPTIONS_SHOWHEADERS             = "Exibir cabe\195\167alhos"
    HEALBOT_OPTIONS_PRESETCOLOURBTN         = "*"
    HEALBOT_OPTIONS_PRESET                  = "Preset"
    HEALBOT_OPTIONS_ICONPOSITION            = "Icon Position"
    HEALBOT_OPTIONS_ICONANCHOR              = "Icon Anchor"

    HEALBOT_OPTIONS_ITEMS                   = "Itens";

    HEALBOT_OPTIONS_COMBOCLASS              = "Teclas combinadas para";
    HEALBOT_OPTIONS_CLICK                   = "Clique";
    HEALBOT_OPTIONS_SHIFT                   = "Shift";
    HEALBOT_OPTIONS_CTRL                    = "Ctrl";
    HEALBOT_OPTIONS_ENABLEHEALTHY           = "UsarSempre habilitado";
    HEALBOT_OPTIONS_FADEONEXPIRE            = "Fade on expire";
    HEALBOT_OPTIONS_FADESTARTTIME           = "Fade start time";

    HEALBOT_OPTIONS_CASTNOTIFY1             = "Sem mensagens";
    HEALBOT_OPTIONS_CASTNOTIFY2             = "Notificar a si";
    HEALBOT_OPTIONS_CASTNOTIFY3             = "Notificar alvo";
    HEALBOT_OPTIONS_CASTNOTIFY4             = "Notificar grupo";
    HEALBOT_OPTIONS_CASTNOTIFY5             = "Notificar raide";
    HEALBOT_OPTIONS_CASTNOTIFY6             = "Notificar canal";
    HEALBOT_OPTIONS_CASTNOTIFYRESONLY       = "Notificar apenas para ressurrei\195\167\195\163o";
    HEALBOT_OPTIONS_EOC_OOM                 = "After combat warn when out of mana"
    HEALBOT_OPTIONS_EOC_OOM_VALUE           = "When mana below"

    HEALBOT_OPTIONS_CDCBARS                 = "Alterar cor da barra";
    HEALBOT_OPTIONS_CDCSHOWHBARS            = "Alterar cor da barra de HP";
    HEALBOT_OPTIONS_CDCSHOWABARS            = "Alterar cor de aggro";
    HEALBOT_OPTIONS_CDCWARNINGS             = "Avisos de debuff";
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
    HEALBOT_OPTIONS_SHOWDEBUFFWARNING       = "Exibir aviso em debuff";
    HEALBOT_OPTIONS_SOUNDDEBUFFWARNING      = "Tocar som em debuff";
    HEALBOT_OPTIONS_SHOWBUFFWARNING         = "Display warning on buff";
    HEALBOT_OPTIONS_SOUNDBUFFWARNING        = "Play sound on buff";
    HEALBOT_OPTIONS_SOUND                   = "Som"
    HEALBOT_OPTIONS_WARN_CLASSCOL           = "Unable to change text color when\nColor text by class is on"

    HEALBOT_OPTIONS_PLAYERVISIBILITY        = "Player and Pet Visibility";
    HEALBOT_OPTIONS_TARGETVISIBILITY        = "Target Visibility";
    HEALBOT_OPTIONS_FOCUSVISIBILITY         = "Focus Visibility";
    HEALBOT_OPTIONS_PLAYERSORT              = "Player Sort"
    HEALBOT_OPTIONS_VEHICLESORT             = "Vehicle Sort"
    HEALBOT_OPTIONS_PETSORT                 = "Pet Sort"
    HEALBOT_OPTIONS_ENEMYSORT               = "Enemy Sort"
    HEALBOT_OPTIONS_SELFHEALS               = "Pr\195\179prio"
    HEALBOT_OPTIONS_PETHEALS                = "Ajudantes"
    HEALBOT_WORD_PET                        = "Pet"
    HEALBOT_OPTIONS_GROUPHEALS              = "Grupo";
    HEALBOT_OPTIONS_TANKHEALS               = "Tanques Principais";
    HEALBOT_OPTIONS_SINGLETANK              = "Single tank";
    HEALBOT_OPTIONS_PRIVATETANKS            = "Tanques Privados principais";
    HEALBOT_OPTIONS_PRIVATEHEALERS          = "Private healers";
    HEALBOT_OPTIONS_TARGETHEALS             = "Alvos";
    HEALBOT_OPTIONS_EMERGENCYHEALS          = "Raide";
    HEALBOT_OPTIONS_RAID10                  = HEALBOT_OPTIONS_EMERGENCYHEALS.." 10";
    HEALBOT_OPTIONS_RAID20                  = HEALBOT_OPTIONS_EMERGENCYHEALS.." 20";
    HEALBOT_OPTIONS_RAID25                  = HEALBOT_OPTIONS_EMERGENCYHEALS.." 25";
    HEALBOT_OPTIONS_RAID40                  = HEALBOT_OPTIONS_EMERGENCYHEALS.." 40";
    HEALBOT_OPTIONS_EMERGFILTER             = "Exibir barras de raide para";
    HEALBOT_OPTIONS_EMERGFCLASS             = "Configurar classes para";
    HEALBOT_OPTIONS_MODIFIER                = "Modifier key"
    HEALBOT_OPTIONS_MODIFIERKEYS            = "Modifier keys:"
    HEALBOT_OPTIONS_COMBOBUTTON             = "Bot\195\163o";
    HEALBOT_OPTIONS_BUTTONANY               = "Any button";
    HEALBOT_OPTIONS_BUTTONLEFT              = "Esquerdo";
    HEALBOT_OPTIONS_BUTTONMIDDLE            = "Meio";
    HEALBOT_OPTIONS_BUTTONRIGHT             = "Direito";
    HEALBOT_OPTIONS_BUTTON4                 = "Bot\195\163o4";
    HEALBOT_OPTIONS_BUTTON5                 = "Bot\195\163o5";
    HEALBOT_OPTIONS_BUTTON6                 = "Bot\195\163o6";
    HEALBOT_OPTIONS_BUTTON7                 = "Bot\195\163o7";
    HEALBOT_OPTIONS_BUTTON8                 = "Bot\195\163o8";
    HEALBOT_OPTIONS_BUTTON9                 = "Bot\195\163o9";
    HEALBOT_OPTIONS_BUTTON10                = "Bot\195\163o10";
    HEALBOT_OPTIONS_BUTTON11                = "Bot\195\163o11";
    HEALBOT_OPTIONS_BUTTON12                = "Bot\195\163o12";
    HEALBOT_OPTIONS_BUTTON13                = "Bot\195\163o13";
    HEALBOT_OPTIONS_BUTTON14                = "Bot\195\163o14";
    HEALBOT_OPTIONS_BUTTON15                = "Bot\195\163o15";

    HEALBOT_CLASSES_ALL                     = "Todas as classes";
    HEALBOT_CLASSES_MELEE                   = "Corpo-a-corpo";
    HEALBOT_CLASSES_RANGES                  = "\195\128 Dist\195\162ncia";
    HEALBOT_CLASSES_HEALERS                 = "Curadores";
    HEALBOT_CLASSES_CUSTOM                  = "Personalizado";

    HEALBOT_OPTIONS_DEBUFFNAME              = "Debuff Name"
    HEALBOT_OPTIONS_DEBUFFAUTOTOCUSTOM      = "Add to custom list"
    HEALBOT_OPTIONS_SHOWTOOLTIP             = "Exibir dicas";
    HEALBOT_OPTIONS_SHOWDETTOOLTIP          = "Exibir informa\195\167\195\163o detalhada de magia";
    HEALBOT_OPTIONS_SHOWCDTOOLTIP           = "Exibir recarga da magia";
    HEALBOT_OPTIONS_IGNOREGCDTOOLTIP        = "Ignorar recarga global da magia";
    HEALBOT_OPTIONS_SHOWMOUSEWHEELTOOLTIP   = "Show mouse wheel commands"
    HEALBOT_OPTIONS_SHOWUNITTOOLTIP         = "Exibir informa\195\167\195\163o do alvo";
    HEALBOT_OPTIONS_SHOWRECTOOLTIP          = "Exibir recomenda\195\167\195\163o de Cura-pelo-Tempo";
    HEALBOT_TOOLTIP_POSDEFAULT              = "Local padr\195\163o";
    HEALBOT_TOOLTIP_POSLEFT                 = "Esquerda do Healbot";
    HEALBOT_TOOLTIP_POSRIGHT                = "Direita do Healbot";
    HEALBOT_TOOLTIP_POSABOVE                = "Sobre o Healbot";
    HEALBOT_TOOLTIP_POSBELOW                = "Abaixo do Healbot";
    HEALBOT_TOOLTIP_POSCURSOR               = "Pr\195\179ximo ao Cursor";
    HEALBOT_TOOLTIP_RECOMMENDTEXT           = "Cura-pelo-tempo recomendada";
    HEALBOT_TOOLTIP_NONE                    = "nenhum dispon\195\173vel";
    HEALBOT_TOOLTIP_CORPSE                  = "Cad\195\161ver de ";
    HEALBOT_TOOLTIP_CD                      = " (CD ";
    HEALBOT_TOOLTIP_SECS                    = "s)";
    HEALBOT_TOOLTIP_MINS                    = " min)";
    HEALBOT_WORDS_SMALL                     = "Small"
    HEALBOT_WORDS_MEDIUM                    = "Medium"
    HEALBOT_WORDS_LARGE                     = "Large"
    HEALBOT_WORDS_SEC                       = "seg";
    HEALBOT_WORDS_CAST                      = "Lan\195\167ando";
    HEALBOT_WORDS_UNKNOWN                   = "Desconhecido";
    HEALBOT_WORDS_YES                       = "Sim";
    HEALBOT_WORDS_NO                        = "N\195\163o";
    HEALBOT_WORDS_OK                        = "OK";
    HEALBOT_WORDS_THIN                      = "Delgado";
    HEALBOT_WORDS_THICK                     = "Espesso";

    HEALBOT_WORDS_NONE                      = "Nenhum";
    HEALBOT_OPTIONS_ALT                     = "Alt";
    HEALBOT_OPTIONS_LOCKOFF                 = "Always Unlocked";
    HEALBOT_OPTIONS_LOCKON                  = "Always Locked";
    HEALBOT_OPTIONS_LOCKCTRL                = "Unlock with Ctrl";
    HEALBOT_OPTIONS_LOCKALT                 = "Unlock with Alt";
    HEALBOT_OPTIONS_LOCKCTRLALT             = "Unlock with Ctrl + Alt";
    HEALBOT_DISABLED_TARGET                 = "Alvo";
    HEALBOT_OPTIONS_SHOWCLASSONBAR          = "Exibir classe na barra";
    HEALBOT_OPTIONS_SHOWHEALTHONBAR         = "Exibir HP na barra";
    HEALBOT_OPTIONS_SHOWTEXT                = "Show text";
    HEALBOT_OPTIONS_IGNOREINCOMINGONFULL    = "On full health ignore all incoming heals and "..HEALBOT_classicABSORBHOT.."s";
    HEALBOT_OPTIONS_TEXTONLYTIP             = "Only show in tooltip";
    HEALBOT_OPTIONS_TEXTSTATENAMEFONT       = "Use name font string";
    HEALBOT_OPTIONS_BARHEALTHINCHEALS       = "Incluir curas futuras";
    HEALBOT_OPTIONS_BARHEALTHSEPHEALS       = "Separar curas futuras";
    HEALBOT_OPTIONS_BARHEALTHINCABSORBS     = "Include "..HEALBOT_classicABSORBHOT.."s"
    HEALBOT_OPTIONS_BARHEALTHSEPABSORBS     = "Separate "..HEALBOT_classicABSORBHOT.."s"
    HEALBOT_OPTIONS_BARHEALTHMYOVERHEALS    = "Show my overheals";
    HEALBOT_OPTIONS_BARHEALTHALLOVERHEALS   = "Show all overheals";
    HEALBOT_OPTIONS_BARHEALTH1              = "como delta";
    HEALBOT_OPTIONS_BARHEALTH2              = "como porcentagem";
    HEALBOT_OPTIONS_TIPTEXT                 = "Informa\195\167\195\163o das Dicas";
    HEALBOT_OPTIONS_POSTOOLTIP              = "Posi\195\167\195\163o das Dicas";
    HEALBOT_OPTIONS_SHOWNAMEONBAR           = "Exibir nome na barra";
    HEALBOT_OPTIONS_BARTEXTCLASSCOLOUR1     = "Cor do texto por classe";
    HEALBOT_OPTIONS_EMERGFILTERGROUPS       = "Incluir grupos de raide";
    HEALBOT_OPTIONS_PLAYERPET               = "Players and Pets"

    HEALBOT_ONE                             = "1";
    HEALBOT_TWO                             = "2";
    HEALBOT_THREE                           = "3";
    HEALBOT_FOUR                            = "4";
    HEALBOT_FIVE                            = "5";
    HEALBOT_SIX                             = "6";
    HEALBOT_SEVEN                           = "7";
    HEALBOT_EIGHT                           = "8";

    HEALBOT_OPTIONS_SETDEFAULTS             = "Definir Padr\195\181es";
    HEALBOT_OPTIONS_SETDEFAULTSMSG          = "Resetar todas as op\195\167\195\181es para valores padr\195\163o";
    HEALBOT_OPTIONS_SETLOCALDEFAULTSMSG     = "Reset spells/buffs/debuffs for this character\nto default values";
    HEALBOT_OPTIONS_RIGHTBOPTIONS           = "Abrir Op\195\167\195\181es com clique direito";

    HEALBOT_OPTIONS_BARHEADEROPTTEXT        = "Op\195\167\195\181es de Cabe\195\167alho";
    HEALBOT_OPTIONS_FRAMEHEADEROPTTEXT      = "Frame Header options";
    HEALBOT_OPTIONS_ICONBUFFOPTTEXT         = "Op\195\167\195\181es de \195\173cone";
    HEALBOT_OPTIONS_ICONDEBUFFOPTTEXT       = "Op\195\167\195\181es de \195\173cone";
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
    HEALBOT_OPTIONS_OVERHEALCOLOUR          = "Overheals color";
    HEALBOT_OPTIONS_SEPARATEFORMAT          = "Separate format";
    HEALBOT_OPTIONS_SEPARATECOLOUR          = "Separate color";
    HEALBOT_OPTIONS_PERCENTAGEFORMAT        = "Percentage format";
    HEALBOT_SKIN_HEADERBARCOL               = "Cor da barra";
    HEALBOT_SKIN_HEADERTEXTCOL              = "Cor do Texto da barra";
    HEALBOT_OPTIONS_BUFFSTEXT1              = "Magia para buff";
    HEALBOT_OPTIONS_BUFFSTEXTWE             = "Weapon enchants";
    HEALBOT_OPTIONS_BUFFSTEXTWEMAIN         = "Main hand / 2H";
    HEALBOT_OPTIONS_BUFFSTEXTWEOFF          = "Off hand";
    HEALBOT_OPTIONS_ITEMNAME                = "Item name";
    HEALBOT_OPTIONS_BUFFSTEXT2              = "Checar membros";
    HEALBOT_OPTIONS_BUFFSTEXT3              = "Cor da barra";
    HEALBOT_OPTIONS_EMERGCOLS               = "Emergency colors";
    HEALBOT_OPTIONS_EMERGGENERAL            = "Emergency general";
    HEALBOT_OPTIONS_EMERGSPELLS             = "Emergency spells";
    HEALBOT_OPTIONS_ICONSCMD                = "Icon commands";
    HEALBOT_OPTIONS_BUFF                    = "Buff ";
    HEALBOT_OPTIONS_BUFFSELF                = "em si";
    HEALBOT_OPTIONS_BUFFPARTY               = "no grupo";
    HEALBOT_OPTIONS_BUFFRAID                = "na raide";
    HEALBOT_OPTIONS_MONITORBUFFS            = "Monitorar buffs ausentes";
    HEALBOT_OPTIONS_MONITORBUFFSC           = "tamb\195\169m em combate";
    HEALBOT_OPTIONS_ENABLESMARTCAST         = "SmartCast fora de combate";
    HEALBOT_OPTIONS_SMARTCASTSPELLS         = "Incluir magias";
    HEALBOT_OPTIONS_SMARTCASTDISPELL        = "Remover debuffs";
    HEALBOT_OPTIONS_SMARTCASTBUFF           = "Adicionar buffs";
    HEALBOT_OPTIONS_SMARTCASTHEAL           = "Magias de Cura";
    HEALBOT_OPTIONS_BAR2SIZE                = "Tamanho da barra de poder";
    HEALBOT_OPTIONS_SETSPELLS               = "Definir magias para";
    HEALBOT_OPTIONS_USEICONCMDS             = "Use icon commands";
    HEALBOT_OPTIONS_ENABLEDBARS             = "Habilitar barras a todo momento";
    HEALBOT_OPTIONS_EMERGBARS               = "Emergency Bars - All spells on all characters";
    HEALBOT_OPTIONS_ICONS                   = "Icons: Commands that can be used on icons";
    HEALBOT_OPTIONS_MONITORDEBUFFS          = "Monitorar para remover debuffs";
    HEALBOT_OPTIONS_DEBUFFTEXT1             = "Magia para remover debuffs";

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
    
    HEALBOT_OPTIONS_IGNOREDEBUFF            = "Ignorar debuffs:";
    HEALBOT_OPTIONS_IGNOREDEBUFFDURATION    = "Curta dura\195\167\195\163o";
    HEALBOT_OPTIONS_IGNOREDEBUFFCOOLDOWN    = "Quando o CD da magia de cura > 1.5 seg (GCD)";
    HEALBOT_OPTIONS_IGNOREDEBUFFFRIEND      = "Quando for lan\195\167ado por unidade amiga";

    HEALBOT_OPTIONS_OPTIONSOPACITY          = "Options opacity";

    HEALBOT_OPTIONS_HIDEPARTYFRAMES         = "Ocultar quadros de grupo";
    HEALBOT_OPTIONS_HIDEPLAYERTARGET        = "Incluir jogador e alvo";
    HEALBOT_OPTIONS_DISABLEHEALBOT          = "Desabilitar HealBot";
    
    HEALBOT_OPTIONS_STICKYFRAMES            = "Sticky Frames"
    HEALBOT_OPTIONS_STICKYSENSITIVITY       = "Sticky Sensitivity"
    HEALBOT_WORD_VLOW                       = "Very Low"
    HEALBOT_WORD_LOW                        = "Low"
    HEALBOT_WORD_NORMAL                     = "Normal"
    HEALBOT_WORD_HIGH                       = "High"
    HEALBOT_WORD_EXTREME                    = "Extreme"
    HEALBOT_WORD_CASTER                     = "Caster"
    HEALBOT_WORD_TYPE                       = "Type"
    
    HEALBOT_ASSIST                          = "Assist\195\170ncia";
    HEALBOT_FOCUS                           = "Foco";
    HEALBOT_MENU                            = "Menu";
    HEALBOT_MAINTANK                        = "TanquePrincipal";
    HEALBOT_STOP                            = "Parar";
    HEALBOT_TELL                            = "Dizer";
    HEALBOT_IGNOREAURAALL                   = "Disable - Ignore in all zones";
    HEALBOT_ICONRAISEPRIO1                  = "Priority raise x1";
    HEALBOT_ICONRAISEPRIO3                  = "Priority raise x3";
    HEALBOT_ICONLOWERPRIO1                  = "Priority lower x1";
    HEALBOT_ICONLOWERPRIO3                  = "Priority lower x3";
    HEALBOT_ICONRAISESCALE                  = "Scale increase";
    HEALBOT_ICONLOWERSCALE                  = "Scale decrease";
    HEALBOT_ICONBARCOLOURON                 = "Bar color on"
    HEALBOT_ICONBARCOLOUROFF                = "Bar color off"

    HEALBOT_OPTIONS_SHOWMINIMAPBUTTON       = "Exibir bot\195\163o do minimapa";
    HEALBOT_OPTIONS_BARBUTTONSHOWRAIDICON   = "Exibir Alvo da Raide";
    HEALBOT_OPTIONS_HOTONBAR                = "Na barra";
    HEALBOT_OPTIONS_HOTOFFBAR               = "Fora da barra";

    if HEALBOT_GAME_VERSION>7 then
        HEALBOT_ZONE_AB                     = C_Map.GetMapInfo(93).name or "Bacia Arathi";
        HEALBOT_ZONE_AV                     = C_Map.GetMapInfo(91).name or "Vale Alterac";
        HEALBOT_ZONE_ES                     = C_Map.GetMapInfo(121).name or "Olho da Tormenta";
        HEALBOT_ZONE_IC                     = C_Map.GetMapInfo(169).name or "Ilha da Conquista";
        HEALBOT_ZONE_SA                     = C_Map.GetMapInfo(128).name or "Ba\195\173a dos Ancestrais";
    else
        HEALBOT_ZONE_AB                     = "Bacia Arathi";
        HEALBOT_ZONE_AV                     = "Vale Alterac";
        HEALBOT_ZONE_ES                     = "Olho da Tormenta";
        HEALBOT_ZONE_IC                     = "Ilha da Conquista";
        HEALBOT_ZONE_SA                     = "Ba\195\173a dos Ancestrais";
    end

    HEALBOT_OPTION_AGGROTRACK               = "Monitorar Aggro"
    HEALBOT_OPTION_AGGROBAR                 = "Barra"
    HEALBOT_OPTION_AGGROTXT                 = ">> Texto <<"
    HEALBOT_OPTION_AGGROIND                 = "Indicador"
    HEALBOT_OPTION_MANAONLY                 = "Show mana only"
    HEALBOT_OPTION_BARUPDFREQ               = "Renovar Multiplicador"
    HEALBOT_OPTION_USEFLUIDBARS             = "Usar barras fluidas"
    HEALBOT_OPTION_USEFOCUSGROUPS           = "Use focus groups"
    HEALBOT_OPTION_FOCUSGROUPDIMMING        = "Unfocused groups - Opacity reduction"
    HEALBOT_OPTION_FLUIDBARS                = "Fluid Bars"
    HEALBOT_OPTIONS_RELOADUIMSG             = "Esta op\195\167\195\163o requer uma recarga da IU, recarregar agora?"

    HEALBOT_BUFF_PVP                        = "JxJ"
    HEALBOT_BUFF_PVE                        = "JxA"
    HEALBOT_OPTIONS_ANCHOR                  = "\195\130ncora do quadro"
    HEALBOT_OPTIONS_BARSANCHOR              = "\195\130ncora das Barras"
    HEALBOT_OPTIONS_TOPLEFT                 = "Superior \195\160 Esquerda"
    HEALBOT_OPTIONS_BOTTOMLEFT              = "Inferior \195\160 Esquerda"
    HEALBOT_OPTIONS_TOPRIGHT                = "Superior \195\160 Direita"
    HEALBOT_OPTIONS_BOTTOMRIGHT             = "Inferior \195\160 Direita"
    HEALBOT_OPTIONS_TOP                     = "Superior"
    HEALBOT_OPTIONS_BOTTOM                  = "Inferior"

    HEALBOT_PANEL_BLACKLIST                 = "ListaNegra"

    HEALBOT_WORDS_REMOVEFROM                = "Remover de";
    HEALBOT_WORDS_ADDTO                     = "Adicionar a";
    HEALBOT_WORDS_INCLUDE                   = "Incluir";
    HEALBOT_WORDS_UNSET                     = "Unset";
    HEALBOT_WORDS_SETAS                     = "Set as";
    HEALBOT_OPTIONS_MAXSECS                 = "Maximum seconds"
    HEALBOT_WORDS_REQUIRED                  = "Required";
    HEALBOT_WORDS_PENDING                   = "Pending";
    HEALBOT_WORD_STATUS                     = "Status"
    HEALBOT_WORD_TIME                       = "Time"
    HEALBOT_WORD_SUMMONS                    = "Summons"
    HEALBOT_WORD_RESURRECTION               = "Resurrection"

    HEALBOT_OPTIONS_TTALPHA                 = "Opacidade"
    HEALBOT_TOOLTIP_TARGETBAR               = "Barra do Alvo"
    HEALBOT_OPTIONS_MYTARGET                = "Meus Alvos"
    HEALBOT_OPTIONS_MYFRIEND                = "My Friend"

    HEALBOT_DISCONNECTED_LABEL              = "Disconnected"
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
    
    HEALBOT_OPTIONS_SHOWUNITBUFFTIME        = "Exibir meus buffs";
    HEALBOT_OPTIONS_BUFFSTEXTTIMER          = "Exibir buff antes de expirar";
    HEALBOT_OPTIONS_SHORTBUFFTIMER          = "Buffs curtos"
    HEALBOT_OPTIONS_LONGBUFFTIMER           = "Buffs longos"

    HEALBOT_OPTIONS_NOTIFY_MSG              = "Mensagem"
    HEALBOT_OPTIONS_CASTNOTIFYTAGS          = " #s=spell name  -  #l=spell link  -  #n=players name "
    HEALBOT_WORDS_YOU                       = "voc\195\170";
    HEALBOT_WORDS_MOREMEM                   = "More Memory";
    HEALBOT_WORDS_LESSMEM                   = "Less Memory";
    HEALBOT_WORDS_MORECPU                   = "More CPU";
    HEALBOT_WORDS_LESSCPU                   = "Less CPU";
    HEALBOT_WORDS_CRITICAL                  = "Critical";
    HEALBOT_WORDS_INJURED                   = "Injured";
    HEALBOT_WORDS_HEALTHY                   = "Healthy";
    HEALBOT_NOTIFYOTHERMSG                  = "Lan\195\167ando #s em #n";

    HEALBOT_OPTIONS_HOTPOSITION             = "Posi\195\167\195\163o do \195\173cone"
    HEALBOT_OPTIONS_HOTSHOWTEXT             = "Exibir texto do \195\173cone"
    HEALBOT_OPTIONS_HOTTEXTCOUNT            = "Contar"
    HEALBOT_OPTIONS_HOTTEXTDURATION         = "Dura\195\167\195\163o"
    HEALBOT_OPTIONS_ICONSCALE               = "Escala do \195\173cone"
    HEALBOT_OPTIONS_MAXICONS                = "Max Icons"
    HEALBOT_OPTIONS_ICONSPACER              = "Icon Spacer"
    HEALBOT_OPTIONS_EMERGBUTTONUSE          = "Use the Emergency Bar"

    HEALBOT_OPTIONS_AGGROBARSIZE            = "Tamanho da barra de aggro"
    HEALBOT_OPTIONS_DOUBLETEXTLINES         = "Linha dupla de texto"
    HEALBOT_OPTIONS_TEXTALIGNMENT           = "Alinhamento de texto"
    HEALBOT_OPTIONS_TEXTOFFSET              = "Vertical Offset"
    HEALBOT_OPTIONS_TEXTHOROFFSET           = "Horizontal Offset"
    HEALBOT_OPTIONS_EMERGINJTRIG            = "Injured threshold"
    HEALBOT_OPTIONS_EMERGCRITTRIG           = "Critical threshold"
    HEALBOT_OPTIONS_CUSTOMCOLHEALTH         = "Health bar custom colors"
    HEALBOT_OPTIONS_CUSTOMCOLBACK           = "Background bar custom colors"
    HEALBOT_OPTIONS_CUSTOMCOLINHEAL         = "Incoming heals bar custom colors"
    HEALBOT_OPTIONS_CUSTOMCOLABSORB         = "Absorb effects bar custom colors"
    HEALBOT_OPTIONS_CUSTOMTEXTCOLNAME       = "Name text custom colors"
    HEALBOT_OPTIONS_CUSTOMTEXTCOLHEALTH     = "Health text custom colors"
    HEALBOT_OPTIONS_CUSTOMTEXTCOLSTATE      = "State text bar custom colors"
    HEALBOT_OPTIONS_CUSTOMTEXTCOLAGGRO      = "Aggro text bar custom colors"
    HEALBOT_OPTIONS_TXTOFFSET               = "Offset"
    HEALBOT_OPTIONS_TXTDEPTH                = "Depth"
    HEALBOT_OPTIONS_TXTSIZE                 = "Size"
    HEALBOT_WORDS_SPACE                     = "Space"
    HEALBOT_OPTIONS_MAXCHARS                = "Max Characters"
    HEALBOT_OPTIONS_PLAYERMAXCHARS          = "Max Characters - Player Name"
    HEALBOT_OPTIONS_MOBMAXCHARS             = "Max Characters - Mob Name"
    HEALBOT_VEHICLE                         = "Ve\195\173culo"
    HEALBOT_WORDS_ERROR                     = "Erro"
    HEALBOT_SPELL_NOT_FOUND                 = "Magia n\195\163o encontrada"
    HEALBOT_OPTIONS_DISABLETOOLTIPINCOMBAT  = "Ocultar dica em Combate"
    
    HEALBOT_OPTIONS_BUFFNAMED               = "Inclua os nomes dos jogadores para vigiar por\n\n"
    HEALBOT_WORD_ALWAYS                     = "Sempre";
    HEALBOT_WORD_SOLO                       = "Solo";
    HEALBOT_WORD_NEVER                      = "Nunca";
    HEALBOT_SHOW_CLASS_AS_ICON              = "como \195\173cone";
    HEALBOT_SHOW_CLASS_AS_TEXT              = "como texto";
    HEALBOT_SHOW_ROLE                       = "exibir fun\195\167\195\163o quando def.";

    HEALBOT_SHOW_INCHEALS                   = "Exibir Curas Futuras";

    HEALBOT_FORHELP    = "For help use: "
    HEALBOT_HELP={ [1] = "[HealBot] /hb h -- Exibir ajuda",
                   [2] = "[HealBot] /hb o -- Exibir op\195\167\195\181es",
                   [3] = "[HealBot] /hb ri -- Resetar HealBot",
                   [4] = "[HealBot] /hb t -- Habilitar/Desabilitar Healbot",
                   [5] = "[HealBot] /hb bt -- Habilitar/Desabilitar Monitor de Buffs",
                   [6] = "[HealBot] /hb dt -- Habilitar/Desabilitar Monitor de Debuffs",
                   [7] = "[HealBot] /hb skin <skinName> -- Trocar Skins",
                   [8] = "[HealBot] /hb ui -- Recarregar UI",
                   [9] = "[HealBot] /hb hs -- Exibir comandos adicionais",
                  }

    HEALBOT_HELP2={ [1] = "[HealBot] /hb d -- Resetar op\195\167\195\181es para Padr\195\163o",
                    [2] = "[HealBot] /hb aggro 2 <n> -- Definir n\195\173vel de aggro 2 em porcentagem de amea\195\167a <n>",
                    [3] = "[HealBot] /hb aggro 3 <n> -- Definir n\195\173vel de aggro 3 em porcentagem de amea\195\167a <n>",
                    [4] = "[HealBot] /hb tr <Role> -- Definir a mais alta prioridade de fun\195\167\195\163o como sub-ordenado pelas Fun\195\167\195\181es. Fun\195\167\195\181es v\195\161lidas s\195\163o 'TANQUE', 'CURADOR' ou 'DANO'",
                    [5] = "[HealBot] /hb use10 -- Usar automaticamente espa\195\167o 10 de Engenharia",
                    [6] = "[HealBot] /hb pcs <n> -- Ajustar o tamanho do indicador de Poder Sagrado por <n>, valor padr\195\163o \195\169 7 ",
                    [7] = "[HealBot] /hb spt -- Alternar Ajudante pr\195\179prio",
                    [8] = "[HealBot] /hb ws -- Alternar Ocultar/Exibir o \195\173cone de Alma Enfraquecida da PS:E com um -",
                    [9] = "[HealBot] /hb rld <n> -- Em segundos, o tempo em que o nome dos jogadores permanece verde ap\195\179s uma ressurrei\195\167\195\163o",
                    [10] = "[HealBot] /hb flb -- Alternar a trava de atalho do quadro (quador sempre se move com Ctrl+Alt+clique Esquerdo)",
                    [11] = "[HealBot] /hb rtb -- Alternar restri\195\167\195\163o da barra de alvo para Esquerdo=SmartCast e Direito=adicionar/remover de/para MeusAlvos",
                  }
                  
    HEALBOT_OPTION_HIGHLIGHTACTIVEBAR       = "Destacar mouseover"
    HEALBOT_OPTION_HIGHLIGHTTARGETBAR       = "Destacar alvo"
    HEALBOT_OPTIONS_TESTBARS                = "Barras de Teste"
    HEALBOT_OPTIONS_TURNTESTBARSON          = "Turn On"
    HEALBOT_OPTIONS_TURNTESTBARSOFF         = "Turn Off"
    HEALBOT_OPTION_NUMBARS                  = "N\195\186mero de Barras"
    HEALBOT_OPTION_NUMTANKS                 = "N\195\186mero de Tanques"
    HEALBOT_OPTION_NUMMYTARGETS             = "N\195\186mero de MeusAlvos"
    HEALBOT_OPTION_NUMHEALERS               = "N\195\186mero de Healers"
    HEALBOT_OPTION_NUMPETS                  = "N\195\186mero de Ajudantes"
    HEALBOT_WORD_TEST                       = "Testar";
    HEALBOT_OPTION_TESTMODE                 = "Test mode";
    HEALBOT_WORD_TEXT                       = "Text";
    HEALBOT_WORD_OFF                        = "Desligado";
    HEALBOT_WORD_ON                         = "Ligado";
    HEALBOT_WORD_ONWITHOUTSOUND             = "On without sound";
    HEALBOT_WORD_ONWITHSOUND                = "On with sound";

    HEALBOT_OPTIONS_TAB_CHAT                = "Conversa"
    HEALBOT_OPTIONS_TAB_HEADERS             = "Cabe\195\167alho"
    HEALBOT_OPTIONS_TAB_BARS                = "Barras"
    HEALBOT_OPTIONS_TAB_BUTTONS             = "Buttons"
    HEALBOT_OPTIONS_TAB_ICONS               = "\195\141cones"
    HEALBOT_OPTIONS_TAB_INDICATORS          = "Indicators"
    HEALBOT_OPTIONS_TAB_AGGROINDICATORS     = "Aggro indicators"
    HEALBOT_OPTIONS_TAB_LOWMANAINDICATORS   = "Low mana indicators"
    HEALBOT_OPTIONS_TAB_SELFCASTINDICATORS  = "Self cast icon indicators"
    HEALBOT_OPTIONS_TAB_POWERINDICATORS     = "Power indicators"
    HEALBOT_OPTIONS_TAB_WARNING             = "Avisos"
    HEALBOT_OPTIONS_SKINDEFAULTFOR          = "Skin padr\195\163o para"
    HEALBOT_OPTIONS_INCHEAL                 = "exibir curas futuras"
    HEALBOT_OPTIONS_INCABSORB               = HEALBOT_classicABSORBHOT.."s"
    HEALBOT_OPTIONS_NOOVERHEALS             = "No overheals"
    HEALBOT_WORD_OVERHEALS                  = "Overheals"
    HEALBOT_WORD_ARENA                      = "Arena"
    HEALBOT_WORD_BATTLEGROUND               = "Campos de Batalha"
    HEALBOT_WORD_BG10                       = "BG 10"; 
    HEALBOT_WORD_BG15                       = "BG 15";
    HEALBOT_WORD_BG40                       = "BG 40";   
    HEALBOT_OPTIONS_TEXTOPTIONS             = "Op\195\167\195\181es de Texto"
    HEALBOT_WORD_PARTY                      = "Grupo"
    HEALBOT_WORD_COLOURS                    = "Colors";
    HEALBOT_WORD_COLOUR                     = "Color"
    HEALBOT_OPTIONS_COMBOAUTOTARGET         = "Auto\nAlvo"
    HEALBOT_OPTIONS_COMBOAUTOTRINKET        = "Auto Berloque"
    HEALBOT_OPTIONS_GROUPSPERCOLUMN         = "Usar Grupos por Coluna"

    HEALBOT_OPTIONS_MAINSORT                = "Ordena\195\167\195\163o principal"
    HEALBOT_OPTIONS_SUBSORT                 = "Sub-ordena\195\167\195\163o"
    HEALBOT_OPTIONS_SUBSORTINC              = "Incluir sub-ordena\195\167\195\163o:"

    HEALBOT_OPTIONS_BUTTONCASTMETHOD        = "Lan\195\167ar quando"
    HEALBOT_OPTIONS_BUTTONCASTPRESSED       = "Pressionado"
    HEALBOT_OPTIONS_BUTTONCASTRELEASED      = "Liberado"

    HEALBOT_WORD_HEALER                     = "Curador"
    HEALBOT_WORD_DAMAGER                    = "Dano"
    HEALBOT_WORD_TANK                       = "Tanque"
    HEALBOT_WORD_LEADER                     = "L\195\173der"
    HEALBOT_WORD_VERSION                    = "Vers\195\163o"
    HEALBOT_WORD_CLIENT                     = "Cliente"

    HEALBOT_WORD_STAR                       = "Estrela"
    HEALBOT_WORD_CIRCLE                     = "C\195\173rculo"
    HEALBOT_WORD_DIAMOND                    = "Diamante"
    HEALBOT_WORD_TRIANGLE                   = "Tri\195\162ngulo"
    HEALBOT_WORD_MOON                       = "Lua"
    HEALBOT_WORD_SQUARE                     = "Quadrado"
    HEALBOT_WORD_CROSS                      = "Cruz"
    HEALBOT_WORD_SKULL                      = "Caveira"

    HEALBOT_OPTIONS_ACCEPTSKINMSG           = "Aceitar Skin [HealBot]: "
    HEALBOT_OPTIONS_ACCEPTSKINMSGFROM       = " de "
    HEALBOT_OPTIONS_EXPORTSKIN              = "Select Skin"
    HEALBOT_OPTIONS_EXTRASKINS              = "Extra Skins"
    HEALBOT_OPTIONS_BUTTONEXPORT            = "Export"
    HEALBOT_OPTIONS_BUTTONIMPORT            = "Import"
    HEALBOT_OPTIONS_BUTTONIMPORTMETHOD      = "Import Method"
    HEALBOT_IMPORT_OVERWRITEALL             = "Overwrite All (Delete existing then insert all)"
    HEALBOT_IMPORT_MERGEALL                 = "Merge All (Update existing and insert new)"
    HEALBOT_IMPORT_MERGENEW                 = "Merge New (Only insert new)"

    HEALBOT_CHAT_ADDONID                    = "[HealBot]  "
    HEALBOT_CHAT_NEWVERSION1                = "Uma nova vers\195\163o est\195\161 dispon\195\173vel"
    HEALBOT_CHAT_NEWVERSION2                = "em "..HEALBOT_ABOUT_URL
    HEALBOT_CHAT_SHARESKINERR1              = " Skin n\195\163o encontrada para compartilhamento"
    HEALBOT_CHAT_SHARESKINERR3              = " n\195\163o encontrado compartilhamento de Skin"
    HEALBOT_CHAT_SHARESKINACPT              = "Compartilhamento de Skin aceito por"
    HEALBOT_CHAT_CONFIRMSKINDEFAULTS        = "Definir Skins para Padr\195\163o"
    HEALBOT_CHAT_CONFIRMCUSTOMDEFAULTS      = "Resetar Debuffs personalizados"
    HEALBOT_CHAT_CHANGESKINERR1             = "Skin desconhecido: /hb skin "
    HEALBOT_CHAT_CHANGESKINERR2             = "Skins v\195\161lidos:  "
    HEALBOT_CHAT_CONFIRMSPELLCOPY           = "Magias atuais copiados para todas as espec."
    HEALBOT_CHAT_UNKNOWNCMD                 = "Comando desconhecido: /hb "
    HEALBOT_CHAT_ENABLED                    = "Habilitando"
    HEALBOT_CHAT_DISABLED                   = "Desabilitando"
    HEALBOT_CHAT_SOFTRELOAD                 = "Requer a recarga do Healbot"
    HEALBOT_CHAT_HARDRELOAD                 = "Requer a recarga da IU"
    HEALBOT_CHAT_CONFIRMSPELLRESET          = "Magias foram resetadas"
    HEALBOT_CHAT_CONFIRMCURESRESET          = "Curas foram resetadas"
    HEALBOT_CHAT_CONFIRMBUFFSRESET          = "Buffs foram resetados"
    HEALBOT_CHAT_CONFIRMICONRESET           = "Icons have been reset"
    HEALBOT_CHAT_POSSIBLEMISSINGMEDIA       = "Incapaz de receber ajustes de todas as Skins - SharedMedia provavelmente ausente, baixe de curse.com"
    HEALBOT_CHAT_MACROSOUNDON               = "N\195\163o suprimir sons ao usar auto berloques"
    HEALBOT_CHAT_MACROSOUNDOFF              = "Suprimir sons ao usar auto berloques"
    HEALBOT_CHAT_MACROERRORON               = "N\195\163o suprimir erros ao usar auto berloques"
    HEALBOT_CHAT_MACROERROROFF              = "Suprimir erros ao usar auto berloques"
    HEALBOT_CHAT_USE10ON                    = "Auto Berloque - Usar10 ligado - Voc\195\170 deve se equipar um auto berloque existente para que o Usar10 funcione"
    HEALBOT_CHAT_USE10OFF                   = "Auto Berloque - Usar10 desligado"
    HEALBOT_CHAT_SKINREC                    = " skin recebido de " 
    HEALBOT_CHAT_MAINASSISTOFF              = "Main Assist excluded from Tanks"
    HEALBOT_CHAT_MAINASSISTON               = "Main Assist included with Tanks"

    HEALBOT_OPTIONS_SELFCASTS               = "Lan\195\167ar em si apenas"
    HEALBOT_OPTIONS_SELFINDICATOR           = "Self indicator"
    HEALBOT_OPTIONS_HOTSHOWICON             = "Exibir \195\173cone"
    HEALBOT_OPTIONS_ALLSPELLS               = "Todas as magias"
    HEALBOT_OPTIONS_BUFFNAME                = "Buff Name"
    HEALBOT_OPTIONS_DOUBLEROW               = "Linhas duplas"
    HEALBOT_OPTIONS_HOTBELOWBAR             = "Abaixo da barra"
    HEALBOT_OPTIONS_OTHERSPELLS             = "Outras magias"
    HEALBOT_WORD_MACROS                     = "Macros"
    HEALBOT_WORD_SELECT                     = "Selecionar"
    HEALBOT_WORD_SELECT_ALL                 = "Select all"
    HEALBOT_WORD_SELECT_NONE                = "Select none"
    HEALBOT_OPTIONS_QUESTION                = "?"
    HEALBOT_WORD_CANCEL                     = "Cancelar"
    HEALBOT_WORD_DONE                       = "Done"
    HEALBOT_WORD_COMMANDS                   = "Comandos"
    HEALBOT_OPTIONS_BARHEALTH3              = "como HP";
    HEALBOT_SORTBY_ROLE                     = "Fun\195\167\195\163o"
    HEALBOT_WORD_DPS                        = "Dano"
    HEALBOT_CHAT_TOPROLEERR                 = " fun\195\167\195\163o n\195\163o v\195\161lida neste contexto - use 'TANQUE', 'DANO' ou 'CURADOR'"
    HEALBOT_CHAT_NEWTOPROLE                 = "Fun\195\167\195\163o priorit\195\161ria agora \195\169 "
    HEALBOT_CHAT_SUBSORTPLAYER1             = "Jogador ser\195\161 definido como o primeiro na Sub-ordena\195\167\195\163o"
    HEALBOT_CHAT_SUBSORTPLAYER2             = "Jogador ordenado comumente na Sub-ordena\195\167\195\163o"
    HEALBOT_OPTIONS_SHOWREADYCHECK          = "Exibir Checagem de Raide";
    HEALBOT_OPTIONS_SHOWCLASSICON           = "Show Class";
    HEALBOT_OPTIONS_SUBSORTSELFFIRST        = "Em si primeiro"
    HEALBOT_OPTION_AGGROPCTBAR              = "Mover barra"
    HEALBOT_OPTION_AGGROPCTTRACK            = "Rastrear porcentagem" 
    HEALBOT_OPTIONS_ALERTAGGROLEVEL1        = "1 - Baixa amea\195\167a"
    HEALBOT_OPTIONS_ALERTAGGROLEVEL2        = "2 - Alta amea\195\167a"
    HEALBOT_OPTIONS_ALERTAGGROLEVEL3        = "3 - Tancando"
    HEALBOT_OPTIONS_AGGROALERT              = "N\195\173vel de alerta da barra"
    HEALBOT_OPTIONS_AGGROINDALERT           = "Indicador de n\195\173vel de alerta"
    HEALBOT_OPTIONS_TOOLTIPSHOWHOT          = "Exibir detalhes monitorados de CpT ativas"
    HEALBOT_WORDS_MIN                       = "min"
    HEALBOT_WORDS_MAX                       = "max"
    HEALBOT_CHAT_SELFPETSON                 = "Ajudante pr\195\179prio ligado"
    HEALBOT_CHAT_SELFPETSOFF                = "Ajudante pr\195\179prio desligado"
    HEALBOT_WORD_PRIORITY                   = "Prioridade"
    HEALBOT_VISIBLE_RANGE                   = "Dentro de 100 jardas"
    HEALBOT_SPELL_RANGE                     = "Dentro de alcance de magias"
    HEALBOT_WORD_RESET                      = "Reset"
    HEALBOT_WOWMENU                         = "Blizzard Menu";
    HEALBOT_HBMENU                          = "HealBot Menu"
    HEALBOT_ACTION_HBFOCUS                  = "Clique esquerdo para definir \nfocus no alvo"
    HEALBOT_WORD_CLEAR                      = "Limpar"
    HEALBOT_WORD_SET                        = "Definir"
    HEALBOT_WORD_HBFOCUS                    = "Foco do HealBot"
    HEALBOT_WORD_OUTSIDE                    = "Por fora"
    HEALBOT_WORD_ALLZONE                    = "Todas as zonas"
    HEALBOT_OPTIONS_TAB_ALERT               = "Alertas"
    HEALBOT_OPTIONS_TAB_SORT                = "Ordenar"
    HEALBOT_OPTIONS_TAB_HIDE                = "Ocultar"
    HEALBOT_OPTIONS_TAB_VISIBILITY          = "Visibility"
    HEALBOT_OPTIONS_TAB_AGGRO               = "Aggro"
    HEALBOT_OPTIONS_TAB_AUX                 = "Aux"
    HEALBOT_OPTIONS_TAB_ICONTEXT            = "Texto do \195\173cone"
    HEALBOT_OPTIONS_TAB_DEBUFFICONTEXT      = "Debuff icon text"
    HEALBOT_OPTIONS_TAB_BUFFICONTEXT        = "Buff icon text"
    HEALBOT_OPTIONS_TAB_TEXT                = "Texto da Barra"
    HEALBOT_OPTIONS_AGGRO3COL               = "Cor da Barra de Aggro"
    HEALBOT_OPTIONS_AGGROFLASHFREQ          = "Frequ\195\170ncia de fa\195\173sca"
    HEALBOT_OPTIONS_WORD_FASTER             = "Faster"
    HEALBOT_OPTIONS_WORD_SLOWER             = "Slower"
    HEALBOT_OPTIONS_AGGROFLASHALPHA         = "Opacidade de fa\195\173sca"
    HEALBOT_OPTIONS_FOCUSGROUPS             = "Focus Groups"
    HEALBOT_OPTIONS_FOCUSGROUPS1            = "OFF"
    HEALBOT_OPTIONS_FOCUSGROUPS2            = "ON: Fade unfocused groups"
    HEALBOT_OPTIONS_FOCUSGROUPS3            = "ON: Hide unfocused groups"
    HEALBOT_OPTIONS_SHOWDURATIONFROM        = "Exibir dura\195\167\195\163o de"
    HEALBOT_OPTIONS_SHOWDURATIONWARN        = "Aviso de dura\195\167\195\163o de"
    HEALBOT_OPTIONS_GOTOAUXCONFIG           = "Set Aux Bar Opacity Type"
    HEALBOT_CMD_RESETCUSTOMDEBUFFS          = "Resetar debuffs personalizados"
    HEALBOT_CMD_RESETSKINS                  = "Resetar skins"
    HEALBOT_CMD_CLEARBLACKLIST              = "Limpar ListaNegra"
    HEALBOT_CMD_TOGGLEDISLIKEMOUNT          = "Alternar Montaria Indesejada"
    HEALBOT_OPTION_DISLIKEMOUNT_ON          = "Montaria Indesejada agora"
    HEALBOT_CMD_DISMOUNT                    = "Dismount"
    HEALBOT_OPTION_DISLIKEMOUNT_OFF         = "Saiu de Montaria Indesejada"
    HEALBOT_CMD_COPYSPELLS                  = "Copiar magias atuais para todas as espec."
    HEALBOT_CMD_RESETSPELLS                 = "Resetar magias"
    HEALBOT_CMD_RESETCURES                  = "Resetar curas"
    HEALBOT_CMD_RESETBUFFS                  = "Resetar buffs"
    HEALBOT_CMD_RESETICONS                  = "Reset custom buffs"
    HEALBOT_CMD_RESETBARS                   = "Resetar posi\195\167\195\163o da barra"
    HEALBOT_CMD_SUPPRESSSOUND               = "Alternar supress\195\163o de som quando usar auto berloques"
    HEALBOT_CMD_SUPPRESSERRORS              = "Alternar supress\195\163o de erros quando usar auto berloques"
    HEALBOT_OPTIONS_COMMANDS                = "Comandos do HealBot"
    HEALBOT_WORD_RUN                        = "Executar"
    HEALBOT_OPTIONS_MOUSEWHEEL              = "Usar roda do mouse"
    HEALBOT_OPTIONS_MOUSEUP                 = "Roda para cima"
    HEALBOT_OPTIONS_MOUSEDOWN               = "Roda para baixo"
    HEALBOT_CMD_DELCUSTOMDEBUFF9            = "Excluir debuffs personalizados em prioridade 9"
    HEALBOT_CMD_DELCUSTOMDEBUFF10           = "Excluir debuffs personalizados em prioridade 10"
    HEALBOT_CMD_DELCUSTOMDEBUFF11           = "Excluir debuffs personalizados em prioridade 11"
    HEALBOT_CMD_DELCUSTOMDEBUFF12           = "Excluir debuffs personalizados em prioridade 12"
    HEALBOT_ACCEPTSKINS                     = "Aceitar Skins de outros"
    HEALBOT_SUPPRESSSOUND                   = "Auto Berloque: Suprimir som"
    HEALBOT_SUPPRESSERROR                   = "Auto Berloque: Suprimir erros"
    HEALBOT_PERFLEVEL                       = "Performance Level"
    HEALBOT_OPTIONS_USEGENERALMACRO          = "Use general macro slots"
    HEALBOT_CP_MACRO_LEN                    = "Nome da macro deve conter de 1 a 14 caracteres"
    HEALBOT_CP_MACRO_BASE                   = "Nome da macro base"
    HEALBOT_CP_MACRO_SAVE                   = "?ltima grava\195\167\195\163o em: "
    HEALBOT_CP_STARTTIME                    = "Proteger dura\195\167\195\163o no logon"
    HEALBOT_COMBATPROT_PARTYNO              = "barras Reservadas para o Grupo"
    HEALBOT_COMBATPROT_RAIDNO               = "barras Reservadas para a Raide"
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

    HEALBOT_WORD_HEALTH                     = "HP"
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
    HEALBOT_OPTIONS_DONT_SHOW               = "N\195\163o mostrar"
    HEALBOT_OPTIONS_SAME_AS_HLTH_CURRENT    = "Mesmo que o HP (HP atual)"
    HEALBOT_OPTIONS_SAME_AS_HLTH_FUTURE     = "Mesmo que o HP (HP futuro)"
    HEALBOT_OPTIONS_FUTURE_HLTH             = "HP futuro"
    HEALBOT_OPTIONS_CLASSHLTHMIX            = "Class Health mix"
    HEALBOT_SKIN_HEALTHBARCOL_TEXT          = "Barra de HP";
    HEALBOT_SKIN_NAMETEXTCOL_TEXT           = "Text color"
    HEALBOT_SKIN_HEALTHBACKCOL_TEXT         = "Fundo da barra";
    HEALBOT_SKIN_INCHEALBARCOL_TEXT         = "Curas futuras";
    HEALBOT_OPTIONS_GROUP_PETS_BY_FIVE      = "Ajudantes: Grupos de cinco"
    HEALBOT_OPTIONS_OWN_PET_WITH_SELF       = "Own pet: with self"
    HEALBOT_OPTIONS_USEGAMETOOLTIP          = "Usar dicas do Jogo"
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER        = "Exibir contador de poder"
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER_PALA   = "Exibir Poder Sagrado"
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER_ROGU   = "Show combo points"
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER_WARL   = "Show soul shards"
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER_MONK   = "Exibir Poder de Chi"
    HEALBOT_OPTIONS_DISABLEHEALBOTSOLO      = "Apenas quando solo"
    HEALBOT_OPTIONS_CUSTOM_ALLDISEASE       = "Todas as Infec\195\167\195\181es"
    HEALBOT_OPTIONS_CUSTOM_ALLMAGIC         = "Todas as Magias"
    HEALBOT_OPTIONS_CUSTOM_ALLCURSE         = "Todas as Maldi\195\167\195\181es"
    HEALBOT_OPTIONS_CUSTOM_ALLPOISON        = "Todos os Venenos"
    HEALBOT_OPTIONS_CUSTOM_ALLBOSS          = "All Bosses"
    HEALBOT_OPTIONS_CUSTOM_ALLTIMED         = "All Timed"
    HEALBOT_OPTIONS_CUSTOM_IDMETHOD         = "Identify By"
    HEALBOT_OPTIONS_CUSTOM_CASTBY           = "Lan\195\167ado por"
    HEALBOT_OPTIONS_CUSTOM_IDMETHODSID      = "Spell ID"
    HEALBOT_OPTIONS_CUSTOM_IDMETHODSNAME    = "Spell Name"
    HEALBOT_OPTIONS_CUSTOM_IDMETHODSBOTH    = "ID or Name"

    HEALBOT_BLIZZARD_MENU                   = "Menu Blizzard"
    HEALBOT_HB_MENU                         = "Menu Healbot"
    HEALBOT_FOLLOW                          = "Seguir"
    HEALBOT_TRADE                           = "Negociar"
    HEALBOT_PROMOTE_RA                      = "Promover assist\195\170ncia da raide"
    HEALBOT_DEMOTE_RA                       = "Demover assist\195\170ncia da raide "
    HEALBOT_TOGGLE_ENABLED                  = "Alternar habilitado"
    HEALBOT_TOGGLE_MYTARGETS                = "Alternar MeusAlvos"
    HEALBOT_WORD_PERMANENT                  = "Permanent"
    HEALBOT_TOGGLE_PRIVATETANKS             = "Alternar tanques privados"
    HEALBOT_TOGGLE_PRIVATEHEALERS           = "Toggle private healers"
    HEALBOT_RESET_BAR                       = "Resetar barra"
    HEALBOT_HIDE_BARS                       = "Ocultar barras al\195\169m de 100 jardas"
    HEALBOT_RANDOMMOUNT                     = "Montaria Aleat\195\179ria"
    HEALBOT_RANDOMGOUNDMOUNT                = "Montaria Aleat\195\179ria terrena"
    HEALBOT_RANDOMPET                       = "Ajudante Aleat\195\179rio"
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
    HEALBOT_ZONE_VASHJIR1                   = "Floresta Kelp'thar"
    HEALBOT_ZONE_VASHJIR2                   = "Vastid\195\163o Cintilante"
    HEALBOT_ZONE_VASHJIR3                   = "Profundezas Abissais"
    HEALBOT_ZONE_VASHJIR                    = "Vashj'ir"
    HEALBOT_RESLAG_INDICATOR                = "Manter nome verde ap\195\179s ressurei\195\167\195\163o definido para" 
    HEALBOT_CLASSIC_HOT_IHDUR               = "Classic HoT incoming heal duration set to" 
    HEALBOT_RESLAG_INDICATOR_ERROR          = "Manter nome verde ap\195\179s ressurei\195\167\195\163o deve estar entre 1 e 30" 
    HEALBOT_RESTRICTTARGETBAR_ON            = "Restringir barra do Alvo ligado"
    HEALBOT_RESTRICTTARGETBAR_OFF           = "Restringir barra do Alvo desligado"
    HEALBOT_AGGRO2_ERROR_MSG                = "Para definir n\195\173vel de aggro 2, porcentagem de amea\195\167a deve estar entre 25 e 95"
    HEALBOT_AGGRO3_ERROR_MSG                = "Para definir n\195\173vel de aggro 3, porcentagem de amea\195\167a deve estar entre 75 e 100"
    HEALBOT_AGGRO2_SET_MSG                  = "N\195\173vel de aggro 2 definido pela porcentagem de amea\195\167a "
    HEALBOT_AGGRO3_SET_MSG                  = "N\195\173vel de aggro 3 definido pela porcentagem de amea\195\167a "
    HEALBOT_WORD_THREAT                     = "Amea\195\167a"
    HEALBOT_AGGRO_ERROR_MSG                 = "N\195\173vel de aggro inv\195\161lido - use 2 ou 3"
      
    HEALBOT_OPTIONS_LOWMANAINDICATOR        = "Indicador de Mana Baixo"
    HEALBOT_OPTIONS_LOWMANA                 = "Low mana"
    HEALBOT_OPTIONS_LOWMANAINDICATOR1       = "N\195\163o mostrar"
    HEALBOT_OPTIONS_LOWMANAINDICATOR2       = "*10% / **20% / ***30%"
    HEALBOT_OPTIONS_LOWMANAINDICATOR3       = "*15% / **30% / ***45%"
    HEALBOT_OPTIONS_LOWMANAINDICATOR4       = "*20% / **40% / ***60%"
    HEALBOT_OPTIONS_LOWMANAINDICATOR5       = "*25% / **50% / ***75%"
    HEALBOT_OPTIONS_LOWMANAINDICATOR6       = "*30% / **60% / ***90%"

    HEALBOT_OPTIONS_SELFCASTIND             = "Self cast"
    HEALBOT_OPTION_IGNORE_AURA_RESTED       = "Ignorar eventos de aura quando estiver descansando"

    HEALBOT_WORD_ENABLE                     = "Habilitar"
    HEALBOT_WORD_DISABLE                    = "Desabilitar"

    HEALBOT_OPTIONS_MYCLASS                 = "Minha Classe"
    HEALBOT_OPTIONS_PLUGINS                 = "Plugins"
    HEALBOT_OPTIONS_PLUGIN_NA               = "Plugin not available"

    HEALBOT_OPTIONS_CONTENT_ABOUT           = "        Sobre"
    HEALBOT_OPTIONS_CONTENT_OVERRIDES       = "        " .. HEALBOT_OPTIONS_TAB_OVERRIDES
    HEALBOT_OPTIONS_CONTENT_GENERAL         = "        " .. HEALBOT_OPTIONS_TAB_GENERAL
    HEALBOT_OPTIONS_CONTENT_SPELLS          = "        " .. HEALBOT_OPTIONS_TAB_SPELLS
    HEALBOT_OPTIONS_CONTENT_SKINS           = "        " .. HEALBOT_OPTIONS_TAB_SKIN
    HEALBOT_OPTIONS_CONTENT_BUFFS           = "        " .. HEALBOT_OPTIONS_TAB_BUFFS
    HEALBOT_OPTIONS_CONTENT_TIPS            = "        " .. HEALBOT_OPTIONS_TAB_TIPS
    HEALBOT_OPTIONS_CONTENT_MOUSEWHEEL      = "        Roda do Mouse"
    HEALBOT_OPTIONS_CONTENT_TEST            = "        Teste"
    HEALBOT_OPTIONS_CONTENT_INOUT           = "        Import / Export"
    HEALBOT_OPTIONS_CONTENT_PLUGINS         = "        " .. HEALBOT_OPTIONS_PLUGINS
    HEALBOT_OPTIONS_REFRESH                 = "Atualizar"

    HEALBOT_CUSTOM_CATEGORY                 = "Categoria"
    HEALBOT_CUSTOM_CAT_CUSTOM               = "Personalizado"
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
    
    HEALBOT_CUSTOM_CASTBY_EVERYONE          = "Todos"
    HEALBOT_CUSTOM_CASTBY_ENEMY             = "Inimigos"
    HEALBOT_CUSTOM_CASTBY_FRIEND            = "Amigos"
    HEALBOT_CUSTOM_CAT_CUSTOM_AUTOMATIC     = "Automatic Debuffs"
    HEALBOT_CUSTOM_DEBUFF_CATS = {}

    HEALBOT_ABOUT_DESC1                    = "Adiciona um painel com barras de cura, remo\195\167\195\163o de maldi\195\167\195\181es, buffs e rastreamento de aggro"
    HEALBOT_ABOUT_WEBSITE                  = "Website:"
    HEALBOT_ABOUT_AUTHORH                  = "Autor:"
    HEALBOT_ABOUT_AUTHORD                  = "Strife"
    HEALBOT_ABOUT_CATH                     = "Categoria:"
    HEALBOT_ABOUT_CATD                     = "Quadros de Unidades, Buffs e Debuffs, Combate:Curador"
    HEALBOT_ABOUT_CREDITH                  = "Cr\195\169ditos:"
    HEALBOT_ABOUT_LOCALH                   = "Adapta\195\167\195\181es:"
    HEALBOT_ABOUT_LOCALD                   = "deDE, enUK, esES, frFR, huHU, itIT, koKR, poBR, ruRU, zhCN, zhTW, ptBR"
    HEALBOT_ABOUT_FAQH                     = "Perguntas Frequentes"
    HEALBOT_ABOUT_FAQ_QUESTION             = "Pergunta"
    HEALBOT_ABOUT_FAQ_ANSWER               = "Resposta"

    HEALBOT_ABOUT_FAQ_QUESTIONS = {   [1]   = "Buffs - Todas as barras est\195\163o Brancas, o que aconteceu",
                                      [2]   = "Lan\195\167amento - \195\160s vezes o cursor fica azul e n\195\163o consigo fazer mais nada",
                                      [3]   = "Macros - Voc\195\170 possui exemplos de recarga",
                                      [4]   = "Macros - Voc\195\170 possui exemplos de lan\195\167amento de magias",
                                      [5]   = "Mouse - Como usar minhas macros de mouseover com a roda do mouse",
                                      [6]   = "Op\195\167\195\181es - As barras podem ser ordenadas por grupos, por exemplo tendo 2 grupor por coluna",
                                      [7]   = "Op\195\167\195\181es - Posso ocultar as barras e mostr\195\161-las somente quando precisar remover um debuff",
                                      [8]   = "Op\195\167\195\181es - Posso ocultar as curas futuras",
                                      [9]   = "Op\195\167\195\181es - Healbot n\195\163o est\195\161 salvando minhas op\195\167\195\181es quando eu dou logout/login",
                                      [10]  = "Op\195\167\195\181es - Como sempre usar meus ajustes definidos",
                                      [11]  = "Op\195\167\195\181es - Como desabilitar o healbot automaticamente",
                                      [12]  = "Op\195\167\195\181es - Como fa\195\167o as barras popularem em dire\195\167\195\181es diferentes",
                                      [13]  = "Op\195\167\195\181es - Como ajustar 'Meus Alvos'",
                                      [14]  = "Op\195\167\195\181es - Como ajustar 'Tanques Privados'",
                                      [15]  = "Op\195\167\195\181es - Healbot pode criar uma barra para um PNJ",
                                      [16]  = "Alcance - N\195\163o consigo ver quando os jogadores est\195\163o fora de alcance, como posso corrigir isso",
                                      [17]  = "Magias - Healbot lan\195\167a uma magia diferente da definida",
                                      [18]  = "Magias - N\195\163o consigo lan\195\167ar mais magias em alvos curados",
                                  }

    HEALBOT_ABOUT_FAQ_SPELLS_ANSWER01       = "Isto deve-se a op\195\167\195\181es definidas na aba de Magias. \n" ..
                                              "Tente alterar e testar o seguinte: \n\n" ..
                                              "     1: Na aba de magias: ligar UsarSempre habilitado \n" ..
                                              "     2: Na aba de magias: desligar SmartCast \n\n" ..
                                              "Nota: Espera-se que a maior parte dos jogadores desejem \n"..
                                              "          ligar novamente o SmartCast. \n\n" ..
                                              "Nota: Espera-se que grande parte dos jogadores experientes queiram \n" ..
                                              "          desligar o UsarSempre habilitado e definir as magias \n" ..
                                              "          para as barras desabilitadas."
                                              
    HEALBOT_ABOUT_FAQ_ANSWERS = {     [1]   = "Voc\195\170 est\195\161 monitorando por buffs ausentes. \n\n" .. 
                                              "Esta op\195\167\195\163o pode ser desabilitada na aba Buffs. \n" ..
                                              "Uma alternativa \195\169 clicar na barra e lan\195\167ar o buff",
                                      [2]   = "Esta \195\169 uma funcionalidade da Blizzard, n\195\163o do Healbot \n\n" .. 
                                              "Usando os quadros padr\195\181es da Blizzard, \n" ..
                                              "tente lan\195\167ar uma magia que est\195\161 em recarga \n" ..
                                              "Perceba que o cursor torna-se azul. \n\n" ..
                                              "Nota: N\195\163o h\195\161 nada que previna que isso aconte\195\167a enquanto \n" ..
                                              "estiver em combate, desde o WoW 2.0 a Blizzard travou \n" ..
                                              "a IU durante o combate evitando que addons pudessem alterar \n" ..
                                              "o lan\195\167amento de magias ou alvos que pudessem ser pr\195\169-definidos. \n\n" ..
                                              "Pode ser \195\186til observar a recarga da magia mostrado nas dicas.",
                                      [3]   = "Sim \n\n"..
                                              "Exemplo de recarga para a M\195\163o da Salva\195\167\195\163o de Paladinos: \n\n" ..
                                              "    #show M\195\163o da Salva\195\167\195\163o \n" ..
                                              '    /script local n=UnitName("hbtarget"); ' .. "\n" ..
                                              '    if GetSpellCooldown("M\195\163o da Salva\195\167\195\163o")==0 then ' .. " \n" ..
                                              '        SendChatMessage("M\195\163o da Salva\195\167\195\163o em "..n,"YELL") ' .. "\n" ..
                                              '        SendChatMessage("M\195\163o da Salva\195\167\195\163o!","WHISPER",nil,n) ' .. "\n" ..
                                              "    end; \n" ..
                                              "    /cast [@hbtarget] M\195\163o da Salva\195\167\195\163o",
                                      [4]   = "Sim. \n\n"..
                                              "Exemplo usando ambos os berloques com Cura C\195\169lere de Sacerdotes: \n\n" ..
                                              "    #show Cura C\195\169lere \n" ..
                                              "    /script UIErrorsFrame:Hide() \n" ..
                                              "    /console Sound_EnableSFX 0 \n" ..
                                              "    /usar 13 \n" ..
                                              "    /usar 14 \n" ..
                                              "    /console Sound_EnableSFX 1 \n" ..
                                              "    /cast [@hbtarget] Cura C\195\169lere \n" ..
                                              "    /script UIErrorsFrame:Clear(); UIErrorsFrame:Show()",
                                      [5]   = "1: Na aba de Roda do Mouse: Desabilite Usar roda do mouse \n" ..
                                              "2: Vincule suas macros para os atalhos Blizzard com [@mouseover] \n\n\n" ..
                                              "Exemplo de macro: \n\n" ..
                                              "    #showtooltip Cura C\195\169lere \n" ..
                                              "    /cast [@mouseover] Cura C\195\169lere \n",
                                      [6]   = "Sim. \n\n"..
                                              "Com Cabe\195\167alhos: \n" ..
                                              "     1: Na aba Skins>Cabe\195\167alhos, habilite Exibir Cabe\195\167alhos \n" ..
                                              "     2: Na aba Skins>Barras, defina o N\195\186mero de Grupos por coluna \n\n" ..
                                              "Sem Cabe\195\167alhos: \n" ..
                                              "     1: Na aba Skins>Barras, habilite o Usar Grupos por Coluna \n" ..
                                              "     2: Na aba Skins>Barras, defina o N\195\186mero de Grupos por coluna ",
                                      [7]   = "Sim. \n\n"..
                                              "1: Na aba Skins>Cura>Alerta, defina o N\195\173vel de Alerta para 0 \n" ..
                                              "2: Na aba Skins>Aggro, Desabilite o Monitor de Aggro \n" .. 
                                              "3: Na aba Skins>Barras, defina Opacidade de Desabilitado para 0 \n" ..
                                              "4: Na aba Skins>Barras, defina Opacidade de Fundo para 0 \n" ..
                                              "5: Na aba Skins>Texto de Barra, clique na barra Desabilitado \n" ..
                                              "     e defina a Opacidade de texto desabilitado para 0 \n" ..
                                              "6: Na aba Skins>Geral, clique na barra Fundo \n" ..
                                              "     e defina a Opacidade de fundo para 0 \n" ..
                                              "7: Na aba Dissipar, habilite o Monitorar debuff",
                                      [8]   = "Sim \n\n"..
                                              "1: Na aba Skins>Barras, defina Curas futuras para N\195\163o mostrar \n" ..
                                              "2: Na aba Skins>Texto da Barra, defina Exibir HP na barra para \n" ..
                                              "          N\195\163o exibir curas futuras",
                                      [9]   = "Isto acontece desde a mudan\195\167a no WoW 3.2, pode afetar \n" ..
                                              "personagens com caracteres estranhos em seus nomes. \n\n" ..
                                              "Se voc\195\170 usa o Vista ou Win7, tente o seguinte: \n"..
                                              "     altere o idioma local para Ingl\195\170s (para programas n\195\163o-unicode) \n" ..
                                              "     em Painel de Controle > Regi\195\163o e Idioma > aba Administrativo",

                                      [10]   = "Na aba Magias ligue UsarSempre Habilitado. \n\n" ..
                                              "Pode-se tamb\195\169m definir o N\195\173vel de Alerta para 100 \n" ..
                                              "Isto pode ser feito na aba Skins>Curas>Alerta",
                                      [11]  = "Desabilitar para um personagem: \n\n" ..
                                              "     1: Abra a aba Geral \n" ..
                                              "     2: Marque a op\195\167\195\163o Desabilitado \n\n" ..
                                              "Desabilitar quando solo: \n\n" ..
                                              "     1: Abra a aba Geral \n" ..
                                              "     2: \195\128 direita da op\195\167\195\163o Desabilitado, selecione Apenas quando solo \n" ..
                                              "     3: Marque a op\195\167\195\163o Desabilitado",
                                      [12]  = "Altere as defini\195\167\195\181es da \195\162ncora de Barras na aba Skins>Geral \n\n" ..
                                              "     Superior \195\160 Direita:  as barras popular\195\163o para baixo e esquerda \n" ..
                                              "     Superior \195\160 Esquerda: as barras popular\195\163o para baixo e direita \n" ..
                                              "     Inferior \195\160 Direita:  as barras popular\195\163o para cima e esquerda \n" ..
                                              "     Inferior \195\160 Esquerda: as barras popular\195\163o para cima e direita",
                                      [13]  = "Meus Alvos permite que voc\195\170 crie uma lista personalizada de Alvos\n" ..
                                              "para agrup\195\161-los separadamente dos demais, similar ao grupo dos TP. \n\n" ..
                                              "As seguintes op\195\167\195\181es est\195\163o dispon\195\173veis para adicionar/remover \n" .. 
                                              "personagens de/para o grupo Meus Alvos: \n\n" ..
                                              "     - Shift+Ctrl+Alt+Bot\195\163o Direito na barra\n" ..
                                              '     - Usando o Menu do Healbot, escolha "hbmenu" na aba de Magias ' .. "\n" ..
                                              "     - Usando a Roda do Mouse, definido na aba Roda do Mouse",
                                      [14]  = "Tanques Privados podem ser adicionados \195\160 lista de Tanques Principais,\n" ..
                                              "mas estar\195\163o vis\195\173veis apenas no seu Healbot e n\195\163o afetar\195\163o outros \n" ..
                                              "jogadores ou addons. \n\n" ..
                                              "As seguintes op\195\167\195\181es est\195\163o dispon\195\173veis para adicionar/remover \n" ..
                                              "personagens de/para a lista de Tanques: \n\n" ..
                                              '     - Pelo menu do Healbot, escolha "hbmenu" na aba de Magias ' .. "\n" ..
                                              "     - Com a roda do mouse, como definido na aba Roda do Mouse",
                                      
                                      [15]  = "Sim. \n\n"..
                                              "     1: Na aba Skins>Curas, habilite Foco \n" ..
                                              "     2: defina o seu foco no PNJ (ou PJ no grupo/raide) \n" ..
                                              "          Healbot criar\195\161 uma barra na sua lista de Meus Alvos \n\n" ..
                                              "Nota: Se estiver em uma situa\195\167\195\163o de combate onde haja altern\195\162ncia\n" ..
                                              "          de zonas durante o combate e seja necess\195\161rio resetar o\n" ..
                                              "          foco em um PNJ, defina na aba Skins>Curas> Foco: Sempre\n" ..
                                              "          mostrar para ligado. Isto manter\195\161 a barra dispon\195\173vel\n" ..
                                              "          durante o combate. \n" ..
                                              "Nota: O Menu do HealBot possui a op\195\167\195\163o 'Definir Foco do Healbot' \n" ..
                                              "          Isto facilita a defini\195\167\195\163o do foco em PNJ e \n" ..
                                              "          serve como um lembrete para definir o foco. \n" ..
                                              "          Usando o Menu do Healbot, escolha 'hbmenu' na aba de Magias. \n" ..
                                              "          Ou use a roda do mouse, definido na aba Roda do Mouse.",
                                      [16]  = "1:  Na aba Skins>Barras, ajuste a opacidade da barra desabilitada. \n" ..
                                              "2:  Na aba Skins>Texto das Barras, ajuste a opacidade do texto \n" ..
                                              "          desabilitado.\n" ..
                                              "       Para fazer isto, clique na barra Desabilitado. \n\n" ..
                                              "Tamb\195\169m pode-se definir o N\195\173vel de Alerta para 100. \n" ..
                                              "Isto pode ser feito na aba Skins>Curas>Alertas.",
                                      [17]  = "Na verdade o Healbot ir\195\161 lan\195\167ar o que foi definido em seu ajuste. \n\n" .. HEALBOT_ABOUT_FAQ_SPELLS_ANSWER01,
                                      [18]  = HEALBOT_ABOUT_FAQ_SPELLS_ANSWER01,
                                  }

    HEALBOT_OPTIONS_SKINAUTHOR              = "Autor do Skin:"
    HEALBOT_OPTIONS_MORESKINSURL            = "Extra skins are available on the Import/Export > Skins tab"
    HEALBOT_OPTIONS_AVOIDBLUECURSOR         = "Avoid\nBlue Cursor"
    HEALBOT_PLAYER_OF_REALM                 = "de"
    
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
    
    HEALBOT_OPTIONS_LANG_ADDON_FAIL1        = "Failed to load addon for localization"
    HEALBOT_OPTIONS_LANG_ADDON_FAIL2        = "Reason for failure is:"
    HEALBOT_OPTIONS_LANG_ADDON_FAIL3        = "Note in the current verison, this is the only warning for"
    HEALBOT_OPTIONS_IMPORT_FAIL1            = "Failed to Import"
    HEALBOT_OPTIONS_IMPORT_FAIL2            = "Reason for failure is:"
    
    HEALBOT_OPTIONS_ADDON_FAIL              = "Failed to load headbot addon"
    
    HEALBOT_OPTIONS_IN_A_GROUP              = "Apenas quando em grupo ou raide"
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
    HEALBOT_OPTIONS_SET_ALL_FRAMES          = "Apply current tab settings to all Frames"
    HEALBOT_OPTIONS_CURRENT_FRAME           = "Current frame: "
    HEALBOT_OPTIONS_COPY_TABS               = "Copy tabs"
    HEALBOT_OPTIONS_TO_FRAMES               = "To frames"    HEALBOT_WORDS_PROFILE                   = "Profile"
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