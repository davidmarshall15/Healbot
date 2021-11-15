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
    HEALBOT_MONK                            = "Monge";

    HEALBOT_DISEASE                         = "Infec\195\167\195\163o";
    HEALBOT_MAGIC                           = "Magia";
    HEALBOT_CURSE                           = "Maldi\195\167\195\163o";
    HEALBOT_POISON                          = "Veneno";

    HB_TOOLTIP_OFFLINE                      = "Desconectado";
    HB_OFFLINE                              = "desconectou-se"; -- has gone offline msg
    HB_ONLINE                               = "conectou-se"; -- has come online msg

    HEALBOT_HEALBOT                         = "HealBot";
    HEALBOT_ADDON                           = HEALBOT_HEALBOT .. " " .. HEALBOT_VERSION;
    HEALBOT_LOADED                          = " carregado.";

    HEALBOT_RANK   = {[1]="(Rango 1)", [2]="(Rango 2)", [3]="(Rango 3)", [4]="(Rango 4)", [5]="(Rango 5)", [6]="(Rango 6)", [7]="(Rango 7)",
                      [8]="(Rango 8)", [9]="(Rango 9)", [10]="(Rango 10)", [11]="(Rango 11)", [12]="(Rango 12)", [13]="(Rango 13)"}

    HEALBOT_ACTION_OPTIONS                  = "Op\195\167\195\181es";

    HEALBOT_OPTIONS_TITLE                   = HEALBOT_ADDON;
    HEALBOT_OPTIONS_DEFAULTS                = "Padr\195\163o";
    HEALBOT_OPTIONS_CLOSE                   = "Fechar";
    HEALBOT_OPTIONS_HARDRESET               = "ReloadUI"
    HEALBOT_OPTIONS_SOFTRESET               = "ResetarHB"
    HEALBOT_OPTIONS_TAB_GENERAL             = "Geral";
    HEALBOT_OPTIONS_TAB_SPELLS              = "Magias";
    HEALBOT_OPTIONS_TAB_HEALING             = "Curas";
    HEALBOT_OPTIONS_TAB_CDC                 = "Dissipar";
    HEALBOT_OPTIONS_TAB_SKIN                = "Skins";
    HEALBOT_OPTIONS_TAB_TIPS                = "Dicas";
    HEALBOT_OPTIONS_TAB_BUFFS               = "Buffs"

    HEALBOT_OPTIONS_BARALPHA                = "Habilitar opacidade";
    HEALBOT_OPTIONS_BARALPHAINHEAL          = "Opacidade de Curas Futuras";
    HEALBOT_OPTIONS_BARALPHABACK            = "Opacidade do fundo da barra";
    HEALBOT_OPTIONS_BARALPHAEOR             = "Opacidade de Fora de Alcance";
    HEALBOT_OPTIONS_ACTIONLOCKED            = "Travar posi\195\167\195\163o";
    HEALBOT_OPTIONS_AUTOSHOW                = "Fechar automaticamente";
    HEALBOT_OPTIONS_PANELSOUNDS             = "Tocar som ao abrir";
    HEALBOT_OPTIONS_HIDEOPTIONS             = "Ocultar bot\195\163o de op\195\167\195\181es";
    HEALBOT_OPTIONS_PROTECTPVP              = "Evitar JxJ";
    HEALBOT_OPTIONS_HEAL_CHATOPT            = "Op\195\167\195\181es de Conversa";

    HEALBOT_OPTIONS_FRAMESCALE              = "Escala do quadro"
    HEALBOT_OPTIONS_SKINTEXT                = "Usar skin"
    HEALBOT_SKINS_STD                       = "Padr\195\163o"
    HEALBOT_OPTIONS_SKINTEXTURE             = "Textura"
    HEALBOT_OPTIONS_SKINHEIGHT              = "Altura"
    HEALBOT_OPTIONS_SKINWIDTH               = "Comprimento"
    HEALBOT_OPTIONS_SKINNUMCOLS             = "No. colunas"
    HEALBOT_OPTIONS_SKINNUMHCOLS            = "No. grupos por coluna"
    HEALBOT_OPTIONS_SKINBRSPACE             = "Espa\195\167o entre linhas"
    HEALBOT_OPTIONS_SKINBCSPACE             = "Espa\195\167o entre colunas"
    HEALBOT_OPTIONS_EXTRASORT               = "Organizar barras de raide por"
    HEALBOT_SORTBY_NAME                     = "Nome"
    HEALBOT_SORTBY_CLASS                    = "Classe"
    HEALBOT_SORTBY_GROUP                    = "Grupo"
    HEALBOT_SORTBY_MAXHEALTH                = "HP M\195\161ximo"
    HEALBOT_OPTIONS_NEWDEBUFFTEXT           = "Novo debuff"
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

    HEALBOT_OPTIONS_ITEMS                   = "Itens";

    HEALBOT_OPTIONS_COMBOCLASS              = "Teclas combinadas para";
    HEALBOT_OPTIONS_CLICK                   = "Clique";
    HEALBOT_OPTIONS_SHIFT                   = "Shift";
    HEALBOT_OPTIONS_CTRL                    = "Ctrl";
    HEALBOT_OPTIONS_ENABLEHEALTHY           = "UsarSempre habilitado";

    HEALBOT_OPTIONS_CASTNOTIFY1             = "Sem mensagens";
    HEALBOT_OPTIONS_CASTNOTIFY2             = "Notificar a si";
    HEALBOT_OPTIONS_CASTNOTIFY3             = "Notificar alvo";
    HEALBOT_OPTIONS_CASTNOTIFY4             = "Notificar grupo";
    HEALBOT_OPTIONS_CASTNOTIFY5             = "Notificar raide";
    HEALBOT_OPTIONS_CASTNOTIFY6             = "Notificar canal";
    HEALBOT_OPTIONS_CASTNOTIFYRESONLY       = "Notificar apenas para ressurrei\195\167\195\163o";

    HEALBOT_OPTIONS_CDCBARS                 = "Alterar cor da barra";
    HEALBOT_OPTIONS_CDCSHOWHBARS            = "Alterar cor da barra de HP";
    HEALBOT_OPTIONS_CDCSHOWABARS            = "Alterar cor de aggro";
    HEALBOT_OPTIONS_CDCWARNINGS             = "Avisos de debuff";
    HEALBOT_OPTIONS_SHOWDEBUFFICON          = "Exibir debuff";
    HEALBOT_OPTIONS_SHOWDEBUFFWARNING       = "Exibir aviso em debuff";
    HEALBOT_OPTIONS_SOUNDDEBUFFWARNING      = "Tocar som em debuff";
    HEALBOT_OPTIONS_SOUND                   = "Som"

    HEALBOT_OPTIONS_HEAL_BUTTONS            = "Barras de cura";
    HEALBOT_OPTIONS_SELFHEALS               = "Pr\195\179prio"
    HEALBOT_OPTIONS_PETHEALS                = "Ajudantes"
    HEALBOT_OPTIONS_GROUPHEALS              = "Grupo";
    HEALBOT_OPTIONS_TANKHEALS               = "Tanques Principais";
    HEALBOT_OPTIONS_MAINASSIST              = "Assistentes Principais";
    HEALBOT_OPTIONS_PRIVATETANKS            = "Tanques Privados principais";
    HEALBOT_OPTIONS_TARGETHEALS             = "Alvos";
    HEALBOT_OPTIONS_EMERGENCYHEALS          = "Raide";
    HEALBOT_OPTIONS_ALERTLEVEL              = "N\195\173vel de Alerta";
    HEALBOT_OPTIONS_EMERGFILTER             = "Exibir barras de raide para";
    HEALBOT_OPTIONS_EMERGFCLASS             = "Configurar classes para";
    HEALBOT_OPTIONS_COMBOBUTTON             = "Bot\195\163o";
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

    HEALBOT_OPTIONS_SHOWTOOLTIP             = "Exibir dicas";
    HEALBOT_OPTIONS_SHOWDETTOOLTIP          = "Exibir informa\195\167\195\163o detalhada de magia";
    HEALBOT_OPTIONS_SHOWCDTOOLTIP           = "Exibir recarga da magia";
    HEALBOT_OPTIONS_IGNOREGCDTOOLTIP        = "Ignorar recarga global da magia";
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
    HEALBOT_WORDS_SEC                       = "seg";
    HEALBOT_WORDS_CAST                      = "Lan\195\167ando";
    HEALBOT_WORDS_UNKNOWN                   = "Desconhecido";
    HEALBOT_WORDS_YES                       = "Sim";
    HEALBOT_WORDS_NO                        = "N\195\163o";
    HEALBOT_WORDS_THIN                      = "Delgado";
    HEALBOT_WORDS_THICK                     = "Espesso";

    HEALBOT_WORDS_NONE                      = "Nenhum";
    HEALBOT_OPTIONS_ALT                     = "Alt";
    HEALBOT_DISABLED_TARGET                 = "Alvo";
    HEALBOT_OPTIONS_SHOWCLASSONBAR          = "Exibir classe na barra";
    HEALBOT_OPTIONS_SHOWHEALTHONBAR         = "Exibir HP na barra";
    HEALBOT_OPTIONS_BARHEALTHINCHEALS       = "Incluir curas futuras";
    HEALBOT_OPTIONS_BARHEALTHSEPHEALS       = "Separar curas futuras";
    HEALBOT_OPTIONS_BARHEALTH1              = "como delta";
    HEALBOT_OPTIONS_BARHEALTH2              = "como porcentagem";
    HEALBOT_OPTIONS_TIPTEXT                 = "Informa\195\167\195\163o das Dicas";
    HEALBOT_OPTIONS_POSTOOLTIP              = "Posi\195\167\195\163o das Dicas";
    HEALBOT_OPTIONS_SHOWNAMEONBAR           = "Exibir nome na barra";
    HEALBOT_OPTIONS_BARTEXTCLASSCOLOUR1     = "Cor do texto por classe";
    HEALBOT_OPTIONS_EMERGFILTERGROUPS       = "Incluir grupos de raide";

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
    HEALBOT_OPTIONS_RIGHTBOPTIONS           = "Abrir Op\195\167\195\181es com clique direito";

    HEALBOT_OPTIONS_HEADEROPTTEXT           = "Op\195\167\195\181es de Cabe\195\167alho";
    HEALBOT_OPTIONS_ICONOPTTEXT             = "Op\195\167\195\181es de \195\173cone";
    HEALBOT_SKIN_HEADERBARCOL               = "Cor da barra";
    HEALBOT_SKIN_HEADERTEXTCOL              = "Cor do Texto da barra";
    HEALBOT_OPTIONS_BUFFSTEXT1              = "Magia para buff";
    HEALBOT_OPTIONS_BUFFSTEXT2              = "Checar membros";
    HEALBOT_OPTIONS_BUFFSTEXT3              = "Cor da barra";
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
    HEALBOT_OPTIONS_ENABLEDBARS             = "Habilitar barras a todo momento";
    HEALBOT_OPTIONS_DISABLEDBARS            = "Desabilitar barras quando fora de combate";
    HEALBOT_OPTIONS_MONITORDEBUFFS          = "Monitorar para remover debuffs";
    HEALBOT_OPTIONS_DEBUFFTEXT1             = "Magia para remover debuffs";

    HEALBOT_OPTIONS_IGNOREDEBUFF            = "Ignorar debuffs:";
    HEALBOT_OPTIONS_IGNOREDEBUFFCLASS       = "Por classe";
    HEALBOT_OPTIONS_IGNOREDEBUFFMOVEMENT    = "Lerdeza";
    HEALBOT_OPTIONS_IGNOREDEBUFFDURATION    = "Curta dura\195\167\195\163o";
    HEALBOT_OPTIONS_IGNOREDEBUFFNOHARM      = "N\195\163o prejudicial";
    HEALBOT_OPTIONS_IGNOREDEBUFFCOOLDOWN    = "Quando o CD da magia de cura > 1.5 seg (GCD)";
    HEALBOT_OPTIONS_IGNOREDEBUFFFRIEND      = "Quando for lan\195\167ado por unidade amiga";

    HEALBOT_OPTIONS_RANGECHECKFREQ          = "Frequ\195\170ncia de verifica\195\167\195\163o de Alcance, Aura e Aggro";

    HEALBOT_OPTIONS_HIDEPARTYFRAMES         = "Ocultar quadros de grupo";
    HEALBOT_OPTIONS_HIDEPLAYERTARGET        = "Incluir jogador e alvo";
    HEALBOT_OPTIONS_DISABLEHEALBOT          = "Desabilitar HealBot";

    HEALBOT_ASSIST                          = "Assist\195\170ncia";
    HEALBOT_FOCUS                           = "Foco";
    HEALBOT_MENU                            = "Menu";
    HEALBOT_MAINTANK                        = "TanquePrincipal";
    HEALBOT_MAINASSIST                      = "AssistPrincipal";
    HEALBOT_STOP                            = "Parar";
    HEALBOT_TELL                            = "Dizer";

    HEALBOT_OPTIONS_SHOWMINIMAPBUTTON       = "Exibir bot\195\163o do minimapa";
    HEALBOT_OPTIONS_BARBUTTONSHOWHOT        = "Exibir CpT";
    HEALBOT_OPTIONS_BARBUTTONSHOWRAIDICON   = "Exibir Alvo da Raide";
    HEALBOT_OPTIONS_HOTONBAR                = "Na barra";
    HEALBOT_OPTIONS_HOTOFFBAR               = "Fora da barra";
    HEALBOT_OPTIONS_HOTBARRIGHT             = "Lado direito";
    HEALBOT_OPTIONS_HOTBARLEFT              = "Lado esquerdo";

    HEALBOT_ZONE_AB                         = "Bacia Arathi";
    HEALBOT_ZONE_AV                         = "Vale Alterac";
    HEALBOT_ZONE_ES                         = "Olho da Tormenta";
    HEALBOT_ZONE_IC                         = "Ilha da Conquista";
    HEALBOT_ZONE_SA                         = "Ba\195\173a dos Ancestrais";

    HEALBOT_OPTION_AGGROTRACK               = "Monitorar Aggro"
    HEALBOT_OPTION_AGGROBAR                 = "Barra"
    HEALBOT_OPTION_AGGROTXT                 = ">> Texto <<"
    HEALBOT_OPTION_AGGROIND                 = "Indicador"
    HEALBOT_OPTION_BARUPDFREQ               = "Renovar Multiplicador"
    HEALBOT_OPTION_USEFLUIDBARS             = "Usar barras fluidas"
    HEALBOT_OPTION_CPUPROFILE               = "Usar CPU profiler (Info. de uso de CPU pelos Addons)"
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

    HEALBOT_OPTIONS_TTALPHA                 = "Opacidade"
    HEALBOT_TOOLTIP_TARGETBAR               = "Barra do Alvo"
    HEALBOT_OPTIONS_MYTARGET                = "Meus Alvos"

    HEALBOT_DISCONNECTED_TEXT               = "<DC>"
    HEALBOT_OPTIONS_SHOWUNITBUFFTIME        = "Exibir meus buffs";
    HEALBOT_OPTIONS_TOOLTIPUPDATE           = "Atualizar constantemente";
    HEALBOT_OPTIONS_BUFFSTEXTTIMER          = "Exibir buff antes de expirar";
    HEALBOT_OPTIONS_SHORTBUFFTIMER          = "Buffs curtos"
    HEALBOT_OPTIONS_LONGBUFFTIMER           = "Buffs longos"

    HEALBOT_OPTIONS_NOTIFY_MSG              = "Mensagem"
    HEALBOT_WORDS_YOU                       = "voc\195\170";
    HEALBOT_NOTIFYOTHERMSG                  = "Lan\195\167ando #s em #n";

    HEALBOT_OPTIONS_HOTPOSITION             = "Posi\195\167\195\163o do \195\173cone"
    HEALBOT_OPTIONS_HOTSHOWTEXT             = "Exibir texto do \195\173cone"
    HEALBOT_OPTIONS_HOTTEXTCOUNT            = "Contar"
    HEALBOT_OPTIONS_HOTTEXTDURATION         = "Dura\195\167\195\163o"
    HEALBOT_OPTIONS_ICONSCALE               = "Escala do \195\173cone"
    HEALBOT_OPTIONS_ICONTEXTSCALE           = "Escala do Texto do \195\173cone"

    HEALBOT_OPTIONS_AGGROBARSIZE            = "Tamanho da barra de aggro"
    HEALBOT_OPTIONS_DOUBLETEXTLINES         = "Linha dupla de texto"
    HEALBOT_OPTIONS_TEXTALIGNMENT           = "Alinhamento de texto"
    HEALBOT_VEHICLE                         = "Ve\195\173culo"
    HEALBOT_WORDS_ERROR                     = "Erro"
    HEALBOT_SPELL_NOT_FOUND                 = "Magia n\195\163o encontrada"
    HEALBOT_OPTIONS_DISABLETOOLTIPINCOMBAT  = "Ocultar dica em Combate"
    HEALBOT_OPTIONS_ENABLELIBQH             = "Habilitar HealBot fastHealth"

    HEALBOT_OPTIONS_BUFFNAMED               = "Inclua os nomes dos jogadores para vigiar por\n\n"
    HEALBOT_WORD_ALWAYS                     = "Sempre";
    HEALBOT_WORD_SOLO                       = "Solo";
    HEALBOT_WORD_NEVER                      = "Nunca";
    HEALBOT_SHOW_CLASS_AS_ICON              = "como \195\173cone";
    HEALBOT_SHOW_CLASS_AS_TEXT              = "como texto";
    HEALBOT_SHOW_ROLE                       = "exibir fun\195\167\195\163o quando def.";

    HEALBOT_SHOW_INCHEALS                   = "Exibir Curas Futuras";

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
    HEALBOT_OPTION_NUMBARS                  = "N\195\186mero de Barras"
    HEALBOT_OPTION_NUMTANKS                 = "N\195\186mero de Tanques"
    HEALBOT_OPTION_NUMMYTARGETS             = "N\195\186mero de MeusAlvos"
    HEALBOT_OPTION_NUMPETS                  = "N\195\186mero de Ajudantes"
    HEALBOT_WORD_TEST                       = "Testar";
    HEALBOT_WORD_OFF                        = "Desligado";
    HEALBOT_WORD_ON                         = "Ligado";

    HEALBOT_OPTIONS_TAB_PROTECTION          = "Prote\195\167\195\163o"
    HEALBOT_OPTIONS_TAB_CHAT                = "Conversa"
    HEALBOT_OPTIONS_TAB_HEADERS             = "Cabe\195\167alho"
    HEALBOT_OPTIONS_TAB_BARS                = "Barras"
    HEALBOT_OPTIONS_TAB_ICONS               = "\195\141cones"
    HEALBOT_OPTIONS_TAB_WARNING             = "Avisos"
    HEALBOT_OPTIONS_SKINDEFAULTFOR          = "Skin padr\195\163o para"
    HEALBOT_OPTIONS_INCHEAL                 = "exibir curas futuras"
    HEALBOT_WORD_ARENA                      = "Arena"
    HEALBOT_WORD_BATTLEGROUND               = "Campos de Batalha"
    HEALBOT_OPTIONS_TEXTOPTIONS             = "Op\195\167\195\181es de Texto"
    HEALBOT_WORD_PARTY                      = "Grupo"
    HEALBOT_OPTIONS_COMBOAUTOTARGET         = "Auto\nAlvo"
    HEALBOT_OPTIONS_COMBOAUTOTRINKET        = "Auto Berloque"
    HEALBOT_OPTIONS_GROUPSPERCOLUMN         = "Usar Grupos por Coluna"

    HEALBOT_OPTIONS_MAINSORT                = "Ordena\195\167\195\163o principal"
    HEALBOT_OPTIONS_SUBSORT                 = "Sub-ordena\195\167\195\163o"
    HEALBOT_OPTIONS_SUBSORTINC              = "Incluir sub-ordena\195\167\195\163o:"

    HEALBOT_OPTIONS_BUTTONCASTMETHOD        = "Lan\195\167ar quando"
    HEALBOT_OPTIONS_BUTTONCASTPRESSED       = "Pressionado"
    HEALBOT_OPTIONS_BUTTONCASTRELEASED      = "Liberado"

    HEALBOT_INFO_ADDONCPUUSAGE              = "== Uso de CPU por Addon em segundos =="
    HEALBOT_INFO_ADDONCOMMUSAGE             = "== Uso de Comms por Addon =="
    HEALBOT_WORD_HEALER                     = "Curador"
    HEALBOT_WORD_DAMAGER                    = "Dano"
    HEALBOT_WORD_TANK                       = "Tanque"
    HEALBOT_WORD_LEADER                     = "L\195\173der"
    HEALBOT_WORD_VERSION                    = "Vers\195\163o"
    HEALBOT_WORD_CLIENT                     = "Cliente"
    HEALBOT_WORD_ADDON                      = "Addon"
    HEALBOT_INFO_CPUSECS                    = "Segs. CPU"
    HEALBOT_INFO_MEMORYMB                   = "Mem\195\179ria em MB"
    HEALBOT_INFO_COMMS                      = "Comms em KB"

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
    HEALBOT_OPTIONS_BUTTONSHARESKIN         = "Compartilhar com"

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
    HEALBOT_CHAT_POSSIBLEMISSINGMEDIA       = "Incapaz de receber ajustes de todas as Skins - SharedMedia provavelmente ausente, baixe de curse.com"
    HEALBOT_CHAT_MACROSOUNDON               = "N\195\163o suprimir sons ao usar auto berloques"
    HEALBOT_CHAT_MACROSOUNDOFF              = "Suprimir sons ao usar auto berloques"
    HEALBOT_CHAT_MACROERRORON               = "N\195\163o suprimir erros ao usar auto berloques"
    HEALBOT_CHAT_MACROERROROFF              = "Suprimir erros ao usar auto berloques"
    HEALBOT_CHAT_ACCEPTSKINON               = "Compartilhar Skin - Exibir popup para aceitar quando algu\195\169m compartilhar uma skin com voc\195\170"
    HEALBOT_CHAT_ACCEPTSKINOFF              = "Compartilhar Skin - Sempre ignorar o compartilhamento de skins de qualquer um"
    HEALBOT_CHAT_USE10ON                    = "Auto Berloque - Usar10 ligado - Voc\195\170 deve se equipar um auto berloque existente para que o Usar10 funcione"
    HEALBOT_CHAT_USE10OFF                   = "Auto Berloque - Usar10 desligado"
    HEALBOT_CHAT_SKINREC                    = " skin recebido de " 

    HEALBOT_OPTIONS_SELFCASTS               = "Lan\195\167ar em si apenas"
    HEALBOT_OPTIONS_HOTSHOWICON             = "Exibir \195\173cone"
    HEALBOT_OPTIONS_ALLSPELLS               = "Todas as magias"
    HEALBOT_OPTIONS_DOUBLEROW               = "Linhas duplas"
    HEALBOT_OPTIONS_HOTBELOWBAR             = "Abaixo da barra"
    HEALBOT_OPTIONS_OTHERSPELLS             = "Outras magias"
    HEALBOT_WORD_MACROS                     = "Macros"
    HEALBOT_WORD_SELECT                     = "Selecionar"
    HEALBOT_OPTIONS_QUESTION                = "?"
    HEALBOT_WORD_CANCEL                     = "Cancelar"
    HEALBOT_WORD_COMMANDS                   = "Comandos"
    HEALBOT_OPTIONS_BARHEALTH3              = "como HP";
    HEALBOT_SORTBY_ROLE                     = "Fun\195\167\195\163o"
    HEALBOT_WORD_DPS                        = "Dano"
    HEALBOT_CHAT_TOPROLEERR                 = " fun\195\167\195\163o n\195\163o v\195\161lida neste contexto - use 'TANQUE', 'DANO' ou 'CURADOR'"
    HEALBOT_CHAT_NEWTOPROLE                 = "Fun\195\167\195\163o priorit\195\161ria agora \195\169 "
    HEALBOT_CHAT_SUBSORTPLAYER1             = "Jogador ser\195\161 definido como o primeiro na Sub-ordena\195\167\195\163o"
    HEALBOT_CHAT_SUBSORTPLAYER2             = "Jogador ordenado comumente na Sub-ordena\195\167\195\163o"
    HEALBOT_OPTIONS_SHOWREADYCHECK          = "Exibir Checagem de Raide";
    HEALBOT_OPTIONS_SUBSORTSELFFIRST        = "Em si primeiro"
    HEALBOT_WORD_FILTER                     = "Filtro"
    HEALBOT_OPTION_AGGROPCTBAR              = "Mover barra"
    HEALBOT_OPTION_AGGROPCTTXT              = "Mostrar texto"
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
    HEALBOT_HBMENU                          = "HBmenu"
    HEALBOT_ACTION_HBFOCUS                  = "Clique esquerdo para definir \nfocus no alvo"
    HEALBOT_WORD_CLEAR                      = "Limpar"
    HEALBOT_WORD_SET                        = "Definir"
    HEALBOT_WORD_HBFOCUS                    = "Foco do HealBot"
    HEALBOT_WORD_OUTSIDE                    = "Por fora"
    HEALBOT_WORD_ALLZONE                    = "Todas as zonas"
    HEALBOT_OPTIONS_TAB_ALERT               = "Alertas"
    HEALBOT_OPTIONS_TAB_SORT                = "Ordenar"
    HEALBOT_OPTIONS_TAB_HIDE                = "Ocultar"
    HEALBOT_OPTIONS_TAB_AGGRO               = "Aggro"
    HEALBOT_OPTIONS_TAB_ICONTEXT            = "Texto do \195\173cone"
    HEALBOT_OPTIONS_TAB_TEXT                = "Texto da Barra"
    HEALBOT_OPTIONS_AGGRO3COL               = "Cor da Barra de Aggro"
    HEALBOT_OPTIONS_AGGROFLASHFREQ          = "Frequ\195\170ncia de fa\195\173sca"
    HEALBOT_OPTIONS_AGGROFLASHALPHA         = "Opacidade de fa\195\173sca"
    HEALBOT_OPTIONS_SHOWDURATIONFROM        = "Exibir dura\195\167\195\163o de"
    HEALBOT_OPTIONS_SHOWDURATIONWARN        = "Aviso de dura\195\167\195\163o de"
    HEALBOT_CMD_RESETCUSTOMDEBUFFS          = "Resetar debuffs personalizados"
    HEALBOT_CMD_RESETSKINS                  = "Resetar skins"
    HEALBOT_CMD_CLEARBLACKLIST              = "Limpar ListaNegra"
    HEALBOT_CMD_TOGGLEACCEPTSKINS           = "Alternar aceitar Skins de outros"
    HEALBOT_CMD_TOGGLEDISLIKEMOUNT          = "Alternar Montaria Indesejada"
    HEALBOT_OPTION_DISLIKEMOUNT_ON          = "Montaria Indesejada agora"
    HEALBOT_OPTION_DISLIKEMOUNT_OFF         = "Saiu de Montaria Indesejada"
    HEALBOT_CMD_COPYSPELLS                  = "Copiar magias atuais para todas as espec."
    HEALBOT_CMD_RESETSPELLS                 = "Resetar magias"
    HEALBOT_CMD_RESETCURES                  = "Resetar curas"
    HEALBOT_CMD_RESETBUFFS                  = "Resetar buffs"
    HEALBOT_CMD_RESETBARS                   = "Resetar posi\195\167\195\163o da barra"
    HEALBOT_CMD_SUPPRESSSOUND               = "Alternar supress\195\163o de som quando usar auto berloques"
    HEALBOT_CMD_SUPPRESSERRORS              = "Alternar supress\195\163o de erros quando usar auto berloques"
    HEALBOT_OPTIONS_COMMANDS                = "Comandos do HealBot"
    HEALBOT_WORD_RUN                        = "Executar"
    HEALBOT_OPTIONS_MOUSEWHEEL              = "Usar roda do mouse"
    HEALBOT_OPTIONS_MOUSEUP                 = "Roda para cima"
    HEALBOT_OPTIONS_MOUSEDOWN               = "Roda para baixo"
    HEALBOT_CMD_DELCUSTOMDEBUFF10           = "Excluir debuffs personalizados em prioridade 10"
    HEALBOT_ACCEPTSKINS                     = "Aceitar Skins de outros"
    HEALBOT_SUPPRESSSOUND                   = "Auto Berloque: Suprimir som"
    HEALBOT_SUPPRESSERROR                   = "Auto Berloque: Suprimir erros"
    HEALBOT_OPTIONS_CRASHPROT               = "Prote\195\167\195\163o de erros"
    HEALBOT_OPTIONS_USEGENERALMACRO          = "Use general macro slots"
    HEALBOT_CP_MACRO_LEN                    = "Nome da macro deve conter de 1 a 14 caracteres"
    HEALBOT_CP_MACRO_BASE                   = "Nome da macro base"
    HEALBOT_CP_MACRO_SAVE                   = "?ltima grava\195\167\195\163o em: "
    HEALBOT_CP_STARTTIME                    = "Proteger dura\195\167\195\163o no logon"
    HEALBOT_WORD_RESERVED                   = "Reservedo"
    HEALBOT_OPTIONS_COMBATPROT              = "Prote\195\167\195\163o de Combate"
    HEALBOT_COMBATPROT_PARTYNO              = "barras Reservadas para o Grupo"
    HEALBOT_COMBATPROT_RAIDNO               = "barras Reservadas para a Raide"

    HEALBOT_WORD_HEALTH                     = "HP"
    HEALBOT_OPTIONS_DONT_SHOW               = "N\195\163o mostrar"
    HEALBOT_OPTIONS_SAME_AS_HLTH_CURRENT    = "Mesmo que o HP (HP atual)"
    HEALBOT_OPTIONS_SAME_AS_HLTH_FUTURE     = "Mesmo que o HP (HP futuro)"
    HEALBOT_OPTIONS_FUTURE_HLTH             = "HP futuro"
    HEALBOT_SKIN_HEALTHBARCOL_TEXT          = "Barra de HP";
    HEALBOT_SKIN_HEALTHBACKCOL_TEXT         = "Fundo da barra";
    HEALBOT_SKIN_INCHEALBARCOL_TEXT         = "Curas futuras";
    HEALBOT_OPTIONS_ALWAYS_SHOW_TARGET      = "Alvo: Sempre mostrar"
    HEALBOT_OPTIONS_ALWAYS_SHOW_FOCUS       = "Foco: Sempre mostrar"
    HEALBOT_OPTIONS_GROUP_PETS_BY_FIVE      = "Ajudantes: Grupos de cinco"
    HEALBOT_OPTIONS_USEGAMETOOLTIP          = "Usar dicas do Jogo"
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER        = "Exibir contador de poder"
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER_PALA   = "Exibir Poder Sagrado"
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER_MONK   = "Exibir Poder de Chi"
    HEALBOT_OPTIONS_CUSTOMDEBUFF_REVDUR     = "Dura\195\167\195\163o inversa"
    HEALBOT_OPTIONS_DISABLEHEALBOTSOLO      = "Apenas quando solo"
    HEALBOT_OPTIONS_CUSTOM_ALLDISEASE       = "Todas as Infec\195\167\195\181es"
    HEALBOT_OPTIONS_CUSTOM_ALLMAGIC         = "Todas as Magias"
    HEALBOT_OPTIONS_CUSTOM_ALLCURSE         = "Todas as Maldi\195\167\195\181es"
    HEALBOT_OPTIONS_CUSTOM_ALLPOISON        = "Todos os Venenos"
    HEALBOT_OPTIONS_CUSTOM_CASTBY           = "Lan\195\167ado por"

    HEALBOT_BLIZZARD_MENU                   = "Menu Blizzard"
    HEALBOT_HB_MENU                         = "Menu Healbot"
    HEALBOT_FOLLOW                          = "Seguir"
    HEALBOT_TRADE                           = "Negociar"
    HEALBOT_PROMOTE_RA                      = "Promover assist\195\170ncia da raide"
    HEALBOT_DEMOTE_RA                       = "Demover assist\195\170ncia da raide "
    HEALBOT_TOGGLE_ENABLED                  = "Alternar habilitado"
    HEALBOT_TOGGLE_MYTARGETS                = "Alternar MeusAlvos"
    HEALBOT_TOGGLE_PRIVATETANKS             = "Alternar tanques privados"
    HEALBOT_RESET_BAR                       = "Resetar barra"
    HEALBOT_HIDE_BARS                       = "Ocultar barras al\195\169m de 100 jardas"
    HEALBOT_RANDOMMOUNT                     = "Montaria Aleat\195\179ria"
    HEALBOT_RANDOMGOUNDMOUNT                = "Montaria Aleat\195\179ria terrena"
    HEALBOT_RANDOMPET                       = "Ajudante Aleat\195\179rio"
    HEALBOT_ZONE_AQ40                       = "Ahn'Qiraj"
    HEALBOT_ZONE_VASHJIR1                   = "Floresta Kelp'thar"
    HEALBOT_ZONE_VASHJIR2                   = "Vastid\195\163o Cintilante"
    HEALBOT_ZONE_VASHJIR3                   = "Profundezas Abissais"
    HEALBOT_ZONE_VASHJIR                    = "Vashj'ir"
    HEALBOT_RESLAG_INDICATOR                = "Manter nome verde ap\195\179s ressurei\195\167\195\163o definido para" 
    HEALBOT_RESLAG_INDICATOR_ERROR          = "Manter nome verde ap\195\179s ressurei\195\167\195\163o deve estar entre 1 e 30" 
    HEALBOT_FRAMELOCK_BYPASS_OFF            = "Ignorar trava do quadro desligado"
    HEALBOT_FRAMELOCK_BYPASS_ON             = "Ignorar trava do quadro (Ctl+Alt+Esquerdo) ligado"
    HEALBOT_RESTRICTTARGETBAR_ON            = "Restringir barra do Alvo ligado"
    HEALBOT_RESTRICTTARGETBAR_OFF           = "Restringir barra do Alvo desligado"
    HEALBOT_PRELOADOPTIONS_ON               = "Op\195\167\195\181es de Pr\195\169Carga ligadas"
    HEALBOT_PRELOADOPTIONS_OFF              = "Op\195\167\195\181es de Pr\195\169Carga desligadas"
    HEALBOT_AGGRO2_ERROR_MSG                = "Para definir n\195\173vel de aggro 2, porcentagem de amea\195\167a deve estar entre 25 e 95"
    HEALBOT_AGGRO3_ERROR_MSG                = "Para definir n\195\173vel de aggro 3, porcentagem de amea\195\167a deve estar entre 75 e 100"
    HEALBOT_AGGRO2_SET_MSG                  = "N\195\173vel de aggro 2 definido pela porcentagem de amea\195\167a "
    HEALBOT_AGGRO3_SET_MSG                  = "N\195\173vel de aggro 3 definido pela porcentagem de amea\195\167a "
    HEALBOT_WORD_THREAT                     = "Amea\195\167a"
    HEALBOT_AGGRO_ERROR_MSG                 = "N\195\173vel de aggro inv\195\161lido - use 2 ou 3"

    HEALBOT_OPTIONS_QUERYTALENTS            = "Consultar dados de talentos"       
    HEALBOT_OPTIONS_LOWMANAINDICATOR        = "Indicador de Mana Baixo"
    HEALBOT_OPTIONS_LOWMANAINDICATOR1       = "N\195\163o mostrar"
    HEALBOT_OPTIONS_LOWMANAINDICATOR2       = "*10% / **20% / ***30%"
    HEALBOT_OPTIONS_LOWMANAINDICATOR3       = "*15% / **30% / ***45%"
    HEALBOT_OPTIONS_LOWMANAINDICATOR4       = "*20% / **40% / ***60%"
    HEALBOT_OPTIONS_LOWMANAINDICATOR5       = "*25% / **50% / ***75%"
    HEALBOT_OPTIONS_LOWMANAINDICATOR6       = "*30% / **60% / ***90%"

    HEALBOT_OPTION_IGNORE_AURA_RESTED       = "Ignorar eventos de aura quando estiver descansando"
    HEALBOT_OPTION_ADJUST_MAX_HEALTH        = "Adjust unit max health"

    HEALBOT_WORD_ENABLE                     = "Habilitar"
    HEALBOT_WORD_DISABLE                    = "Desabilitar"

    HEALBOT_OPTIONS_MYCLASS                 = "Minha Classe"

    HEALBOT_OPTIONS_CONTENT_ABOUT           = "        Sobre"
    HEALBOT_OPTIONS_CONTENT_GENERAL         = "        " .. HEALBOT_OPTIONS_TAB_GENERAL
    HEALBOT_OPTIONS_CONTENT_SPELLS          = "        " .. HEALBOT_OPTIONS_TAB_SPELLS
    HEALBOT_OPTIONS_CONTENT_SKINS           = "        " .. HEALBOT_OPTIONS_TAB_SKIN
    HEALBOT_OPTIONS_CONTENT_CURE            = "        " .. HEALBOT_OPTIONS_TAB_CDC
    HEALBOT_OPTIONS_CONTENT_BUFFS           = "        " .. HEALBOT_OPTIONS_TAB_BUFFS
    HEALBOT_OPTIONS_CONTENT_TIPS            = "        " .. HEALBOT_OPTIONS_TAB_TIPS
    HEALBOT_OPTIONS_CONTENT_MOUSEWHEEL      = "        Roda do Mouse"
    HEALBOT_OPTIONS_CONTENT_TEST            = "        Teste"
    HEALBOT_OPTIONS_CONTENT_USAGE           = "        Uso"
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

    HEALBOT_CUSTOM_CASTBY_EVERYONE          = "Todos"
    HEALBOT_CUSTOM_CASTBY_ENEMY             = "Inimigos"
    HEALBOT_CUSTOM_CASTBY_FRIEND            = "Amigos"

    HEALBOT_ABOUT_DESC1                    = "Adiciona um painel com barras de cura, remo\195\167\195\163o de maldi\195\167\195\181es, buffs e rastreamento de aggro"
    HEALBOT_ABOUT_WEBSITE                  = "Website:"
    HEALBOT_ABOUT_AUTHORH                  = "Autor:"
    HEALBOT_ABOUT_AUTHORD                  = "Strife"
    HEALBOT_ABOUT_CATH                     = "Categoria:"
    HEALBOT_ABOUT_CATD                     = "Quadros de Unidades, Buffs e Debuffs, Combate:Curador"
    HEALBOT_ABOUT_CREDITH                  = "Cr\195\169ditos:"
    HEALBOT_ABOUT_CREDITD                  = "Acirac, Kubik, Von, Aldetal, Brezza, CT, Moonlight Han Xing"  -- Anyone taking on translations (if required), feel free to add yourself here.
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
    HEALBOT_PLAYER_OF_REALM                 = "de"
    
    HEALBOT_OPTIONS_LANG                    = "Language"
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
    
    HEALBOT_OPTIONS_LANG_ADDON_FAIL1        = "Failed to load addon for localization"
    HEALBOT_OPTIONS_LANG_ADDON_FAIL2        = "Reason for failure is:"
    HEALBOT_OPTIONS_LANG_ADDON_FAIL3        = "Note in the current verison, this is the only warning for"
    
    HEALBOT_OPTIONS_ADDON_FAIL              = "Failed to load headbot addon"
    
    HEALBOT_OPTIONS_IN_A_GROUP              = "Apenas quando em grupo ou raide"
    
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