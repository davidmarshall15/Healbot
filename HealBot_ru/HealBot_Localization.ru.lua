-- Russian maintained by Justice (updated by R1SK)

-------------
-- RUSSIAN --
-------------
--
--
--
--

function HealBot_Lang_ruRU()

-----------------
-- Translation --
-----------------

-- Class
    HEALBOT_DRUID                           = "Друид";
    HEALBOT_HUNTER                          = "Охотник";
    HEALBOT_MAGE                            = "Маг";
    HEALBOT_PALADIN                         = "Паладин";
    HEALBOT_PRIEST                          = "Жрец";
    HEALBOT_ROGUE                           = "Разбойник";
    HEALBOT_SHAMAN                          = "Шаман";
    HEALBOT_WARLOCK                         = "Чернокнижник";
    HEALBOT_WARRIOR                         = "Воин";
    HEALBOT_DEATHKNIGHT                     = "Рыцарь cмерти";
    HEALBOT_DEMONHUNTER                     = "Охотник на демонов";
    HEALBOT_MONK                            = "Монах";

    HEALBOT_DISEASE                         = "Болезнь";
    HEALBOT_MAGIC                           = "Магия";
    HEALBOT_CURSE                           = "Проклятие";
    HEALBOT_POISON                          = "Яд";

    HB_TOOLTIP_OFFLINE                      = "Оффлайн";

    HEALBOT_HEALBOT                         = "HealBot";
    HEALBOT_ADDON                           = HEALBOT_HEALBOT .. " " .. HEALBOT_VERSION;
    HEALBOT_LOADED                          = " загружен.";

    HEALBOT_ACTION_OPTIONS                  = "Настройки";

    HEALBOT_OPTIONS_TITLE                   = HEALBOT_ADDON;
    HEALBOT_OPTIONS_DEFAULTS                = "По умолчанию";
    HEALBOT_OPTIONS_CLOSE                   = "Закрыть";
    HEALBOT_OPTIONS_HARDRESET               = "Перезагрузить UI";
    HEALBOT_OPTIONS_SOFTRESET               = "Сбросить HB";
    HEALBOT_OPTIONS_TAB_GENERAL             = "Общее";
    HEALBOT_OPTIONS_TAB_SPELLS              = "Заклинания";
    HEALBOT_OPTIONS_TAB_FRAMES              = "Окна";
    HEALBOT_OPTIONS_TAB_HEALING             = "Лечение";
    HEALBOT_OPTIONS_TAB_SKIN                = "Скины";
    HEALBOT_OPTIONS_TAB_TIPS                = "Подсказки";
    HEALBOT_OPTIONS_TAB_DEBUFFS             = "Дебаффы"
    HEALBOT_OPTIONS_TAB_CUSTOM_DEBUFFS      = "Кастомные Дебаффы";
    HEALBOT_OPTIONS_TAB_CUSTOM_BUFFS        = "Кастомные Баффы";
    HEALBOT_OPTIONS_TAB_BUFFS               = "Баффы";
    HEALBOT_OPTIONS_TAB_NAMETEXT            = "Имя";

    HEALBOT_OPTIONS_BARALPHA                = "Прозрачность активных";
    HEALBOT_OPTIONS_BARALPHAINHEAL          = "Прозрачность входящего исцеления";
    HEALBOT_OPTIONS_BARALPHABACK            = "Прозрачность фона";
    HEALBOT_OPTIONS_BARALPHAEOR             = "Прозрачность вне досягаемости";
    HEALBOT_OPTIONS_ACTIONLOCKED            = "Закрепить позицию";
    HEALBOT_OPTIONS_AUTOSHOW                = "Закрывать автоматически";
    HEALBOT_OPTIONS_PANELSOUNDS             = "Звук при открытии";
    HEALBOT_OPTIONS_HIDEOPTIONS             = "Скрыть кнопку настроек";
    HEALBOT_OPTIONS_PROTECTPVP              = "Избегать PvP";
    HEALBOT_OPTIONS_HEAL_CHATOPT            = "Настройки чата";

    HEALBOT_OPTIONS_FRAMESCALE              = "Масштаб окна";
    HEALBOT_OPTIONS_STICKFRAMEOFFSETH       = "Прилипающее окно: горизонтальный отступ";
    HEALBOT_OPTIONS_STICKFRAMEOFFSETV       = "Прилипающее окно: вертикальный отступ";
    HEALBOT_OPTIONS_SKINTEXT                = "Стиль";
    HEALBOT_SKINS_STD                       = "Стандарт";
    HEALBOT_OPTIONS_SKINTEXTURE             = "Текстура";
    HEALBOT_OPTIONS_SKINHEIGHT              = "Высота";
    HEALBOT_OPTIONS_SKINWIDTH               = "Ширина";
    HEALBOT_OPTIONS_SKINNUMCOLS             = "Колонок";
    HEALBOT_OPTIONS_SKINNUMHCOLS            = "Групп в колонке";
    HEALBOT_OPTIONS_SKINBRSPACE             = "Промежуток строк";
    HEALBOT_OPTIONS_SKINBCSPACE             = "Промежуток рядов";
    HEALBOT_SORTBY_NAME                     = "Имя";
    HEALBOT_SORTBY_CLASS                    = "Класс";
    HEALBOT_SORTBY_GROUP                    = "Группа";
    HEALBOT_SORTBY_MAXHEALTH                = "Максимум здоровья";
    HEALBOT_OPTIONS_NEWDEBUFFTEXT           = "Новый дебафф";
    HEALBOT_OPTIONS_NEWHOTBUFFTEXT          = "Новый бафф";
    HEALBOT_OPTIONS_DELSKIN                 = "Удалить";
    HEALBOT_OPTIONS_NEWSKINTEXT             = "Новый стиль";
    HEALBOT_OPTIONS_SAVESKIN                = "Сохранить";
    HEALBOT_OPTIONS_SKINBARS                = "Опции панели";
    HEALBOT_SKIN_ENTEXT                     = "Активный";
    HEALBOT_SKIN_DISTEXT                    = "Неактивный";
    HEALBOT_SKIN_DEBTEXT                    = "Дебафф";
    HEALBOT_SKIN_BACKTEXT                   = "Фон";
    HEALBOT_SKIN_BORDERTEXT                 = "Рамка";
    HEALBOT_OPTIONS_SKINFONT                = "Шрифт";
    HEALBOT_OPTIONS_SKINFHEIGHT             = "Размер шрифта";
    HEALBOT_OPTIONS_SKINFOUTLINE            = "Контур шрифта";
    HEALBOT_OPTIONS_BARALPHADIS             = "Прозрачность неактивных";
    HEALBOT_OPTIONS_SHOWHEADERS             = "Показывать заголовки";
    HEALBOT_OPTIONS_PRESETCOLOURBTN         = "*";
    HEALBOT_OPTIONS_PRESET                  = "Предустановки";

    HEALBOT_OPTIONS_ITEMS                   = "Предметы";

    HEALBOT_OPTIONS_COMBOCLASS              = "Комбинации клавиш для";
    HEALBOT_OPTIONS_CLICK                   = "Клик";
    HEALBOT_OPTIONS_SHIFT                   = "Shift";
    HEALBOT_OPTIONS_CTRL                    = "Ctrl";
    HEALBOT_OPTIONS_ENABLEHEALTHY           = "Панели всегда активны";
    HEALBOT_OPTIONS_FADEONEXPIRE            = "Исчезеать по истечении";
    HEALBOT_OPTIONS_FADESTARTTIME           = "Время старта исчезновения";

    HEALBOT_OPTIONS_CASTNOTIFY1             = "Без оповещений";
    HEALBOT_OPTIONS_CASTNOTIFY2             = "Оповещать себя";
    HEALBOT_OPTIONS_CASTNOTIFY3             = "Оповещать цель";
    HEALBOT_OPTIONS_CASTNOTIFY4             = "Оповещать группу";
    HEALBOT_OPTIONS_CASTNOTIFY5             = "Оповещать рейд";
    HEALBOT_OPTIONS_CASTNOTIFY6             = "Оповещать в канал";
    HEALBOT_OPTIONS_CASTNOTIFYRESONLY       = "Оповещать только о воскрешении";
    HEALBOT_OPTIONS_EOC_OOM                 = "После боя предупреждать, когда нет маны";
    HEALBOT_OPTIONS_EOC_OOM_VALUE           = "Когда маны меньше, чем";

    HEALBOT_OPTIONS_CDCBARS                 = "Цвет полос";
    HEALBOT_OPTIONS_CDCSHOWHBARS            = "На полосе здоровья";
    HEALBOT_OPTIONS_CDCSHOWABARS            = "На полосе угрозы";
    HEALBOT_OPTIONS_CDCWARNINGS             = "Предупреждения о дебаффах";
    HEALBOT_OPTIONS_BUFFWARNINGS            = "Предупреждения о баффах";
    HEALBOT_OPTIONS_BUFFCUSTOM              = "Пользовательские баффы";
    HEALBOT_OPTIONS_BUFFCUSTOMURL           = "Пользовательские баффы доступны в  "..HEALBOT_ABOUT_URL;
    HEALBOT_OPTIONS_DEBUFFCUSTOM            = "Пользовательские дебаффы";
    HEALBOT_OPTIONS_DEBUFFCUSTOMURL         = "Пользовательские дебаффы доступны в  "..HEALBOT_ABOUT_URL;
    HEALBOT_OPTIONS_BUFFMISSING             = "Пропущенные баффы";
    HEALBOT_OPTIONS_DEBUFFDISPELL           = "Рассеиваемые дебаффы";
    HEALBOT_OPTIONS_SHOWDEBUFFICON          = "Показывать дебафф";
    HEALBOT_OPTIONS_SHOWDEBUFFWARNING       = "Отображать предупреждение при дебаффе";
    HEALBOT_OPTIONS_SOUNDDEBUFFWARNING      = "Звук при дебаффе";
    HEALBOT_OPTIONS_SHOWBUFFWARNING         = "Отображать предупреждение при баффе";
    HEALBOT_OPTIONS_SOUNDBUFFWARNING        = "Воспроизводить звук при баффе";
    HEALBOT_OPTIONS_SOUND                   = "Звук";
    HEALBOT_OPTIONS_WARN_CLASSCOL           = "Нельзя изменить цвет текста, когда\nвключен цвет текста по цвету класса";

    HEALBOT_OPTIONS_PLAYERVISIBILITY        = "Игрок и Питомец: Видимость";
    HEALBOT_OPTIONS_TARGETVISIBILITY        = "Цель: Видимость";
    HEALBOT_OPTIONS_FOCUSVISIBILITY         = "Фокус: Видимость";
    HEALBOT_OPTIONS_PLAYERSORT              = "Игрок: Сортировка";
    HEALBOT_OPTIONS_VEHICLESORT             = "Транспорт: Сортировка";
    HEALBOT_OPTIONS_PETSORT                 = "Питомец: Сортировка";
    HEALBOT_OPTIONS_ENEMYSORT               = "Враг: Сортировка";
    HEALBOT_OPTIONS_SELFHEALS               = "Игрок";
    HEALBOT_OPTIONS_PETHEALS                = "Питомцы";
    HEALBOT_WORD_PET                        = "Питомец";
    HEALBOT_OPTIONS_GROUPHEALS              = "Группа";
    HEALBOT_OPTIONS_TANKHEALS               = "Главные танки";
    HEALBOT_OPTIONS_SINGLETANK              = "Одиночный танк";
    HEALBOT_OPTIONS_PRIVATETANKS            = "Личные танки";
    HEALBOT_OPTIONS_PRIVATEHEALERS          = "Личные лекари";
    HEALBOT_OPTIONS_TARGETHEALS             = "Цели";
    HEALBOT_OPTIONS_EMERGENCYHEALS          = "Рейд";
    HEALBOT_OPTIONS_RAID10                  = HEALBOT_OPTIONS_EMERGENCYHEALS.." 10";
    HEALBOT_OPTIONS_RAID20                  = HEALBOT_OPTIONS_EMERGENCYHEALS.." 20";
    HEALBOT_OPTIONS_RAID25                  = HEALBOT_OPTIONS_EMERGENCYHEALS.." 25";
    HEALBOT_OPTIONS_RAID40                  = HEALBOT_OPTIONS_EMERGENCYHEALS.." 40";
    HEALBOT_OPTIONS_EMERGFILTER             = "Отображать панели для";
    HEALBOT_OPTIONS_EMERGFCLASS             = "Настроить классы для";
    HEALBOT_OPTIONS_COMBOBUTTON             = "Кнопка";
    HEALBOT_OPTIONS_BUTTONLEFT              = "Левая";
    HEALBOT_OPTIONS_BUTTONMIDDLE            = "Средняя";
    HEALBOT_OPTIONS_BUTTONRIGHT             = "Правая";
    HEALBOT_OPTIONS_BUTTON4                 = "Кнопка4";
    HEALBOT_OPTIONS_BUTTON5                 = "Кнопка5";
    HEALBOT_OPTIONS_BUTTON6                 = "Кнопка6";
    HEALBOT_OPTIONS_BUTTON7                 = "Кнопка7";
    HEALBOT_OPTIONS_BUTTON8                 = "Кнопка8";
    HEALBOT_OPTIONS_BUTTON9                 = "Кнопка9";
    HEALBOT_OPTIONS_BUTTON10                = "Кнопка10";
    HEALBOT_OPTIONS_BUTTON11                = "Кнопка11";
    HEALBOT_OPTIONS_BUTTON12                = "Кнопка12";
    HEALBOT_OPTIONS_BUTTON13                = "Кнопка13";
    HEALBOT_OPTIONS_BUTTON14                = "Кнопка14";
    HEALBOT_OPTIONS_BUTTON15                = "Кнопка15";

    HEALBOT_CLASSES_ALL                     = "Все классы";
    HEALBOT_CLASSES_MELEE                   = "Ближний бой";
    HEALBOT_CLASSES_RANGES                  = "Дальний бой";
    HEALBOT_CLASSES_HEALERS                 = "Лекари";
    HEALBOT_CLASSES_CUSTOM                  = "Пользовательские";

    HEALBOT_OPTIONS_DEBUFFNAME              = "Название дебаффа";
    HEALBOT_OPTIONS_SHOWTOOLTIP             = "Показывать подсказки";
    HEALBOT_OPTIONS_SHOWDETTOOLTIP          = "Показывать расширенную информацию о заклинании";
    HEALBOT_OPTIONS_SHOWCDTOOLTIP           = "Показывать кулдаун заклинания";
    HEALBOT_OPTIONS_SHOWMOUSEWHEELTOOLTIP   = "Показывать команды колёсика мыши"
    HEALBOT_OPTIONS_SHOWUNITTOOLTIP         = "Показывать инфо о цели";
    HEALBOT_OPTIONS_SHOWRECTOOLTIP          = "Показывать рекомендации по HoT-ам";
    HEALBOT_TOOLTIP_POSDEFAULT              = "Расположение по умолчанию";
    HEALBOT_TOOLTIP_POSLEFT                 = "Слева от Healbot'a";
    HEALBOT_TOOLTIP_POSRIGHT                = "Справа от Healbot'a";
    HEALBOT_TOOLTIP_POSABOVE                = "Над Healbot'ом";
    HEALBOT_TOOLTIP_POSBELOW                = "Под Healbot'ом";
    HEALBOT_TOOLTIP_POSCURSOR               = "Под курсором";
    HEALBOT_TOOLTIP_RECOMMENDTEXT           = "Рекомендации по HoT-ам";
    HEALBOT_TOOLTIP_NONE                    = "нет доступных";
    HEALBOT_TOOLTIP_CORPSE                  = "Труп ";
    HEALBOT_TOOLTIP_CD                      = " (КД ";
    HEALBOT_TOOLTIP_SECS                    = "с)";
    HEALBOT_TOOLTIP_MINS                    = " мин)";
    HEALBOT_WORDS_SMALL                     = "Маленький";
    HEALBOT_WORDS_MEDIUM                    = "Средний";
    HEALBOT_WORDS_LARGE                     = "Большой";
    HEALBOT_WORDS_SEC                       = "сек";
    HEALBOT_WORDS_CAST                      = "Применение";
    HEALBOT_WORDS_UNKNOWN                   = "Неизвестно";
    HEALBOT_WORDS_YES                       = "Да";
    HEALBOT_WORDS_NO                        = "Нет";
    HEALBOT_WORDS_OK                        = "OK";
    HEALBOT_WORDS_THIN                      = "Тонкий";
    HEALBOT_WORDS_THICK                     = "Толстый";

    HEALBOT_WORDS_NONE                      = "Нет";
    HEALBOT_OPTIONS_ALT                     = "Alt";
    HEALBOT_DISABLED_TARGET                 = "Цель";
    HEALBOT_OPTIONS_SHOWCLASSONBAR          = "Показывать класс на панели";
    HEALBOT_OPTIONS_SHOWHEALTHONBAR         = "Показ здоровья на панели";
    HEALBOT_OPTIONS_IGNOREINCOMINGONFULL    = "С полным здоровьем игнор всего входящего лечения и поглощения";
    HEALBOT_OPTIONS_BARHEALTHINCHEALS       = "Включая входящее исцеление";
    HEALBOT_OPTIONS_BARHEALTHSEPHEALS       = "Разделять входящие исцеления";
    HEALBOT_OPTIONS_BARHEALTHINCABSORBS     = "Включая поглощения"
    HEALBOT_OPTIONS_BARHEALTHSEPABSORBS     = "Разделять поглощения"
    HEALBOT_OPTIONS_BARHEALTHMYOVERHEALS    = "Показывать мой оверхил";
    HEALBOT_OPTIONS_BARHEALTHALLOVERHEALS   = "Показывать весь оверхил";
    HEALBOT_OPTIONS_BARHEALTH1              = "разница";
    HEALBOT_OPTIONS_BARHEALTH2              = "процент";
    HEALBOT_OPTIONS_TIPTEXT                 = "Информация в подсказке";
    HEALBOT_OPTIONS_POSTOOLTIP              = "Расположение подсказки";
    HEALBOT_OPTIONS_SHOWNAMEONBAR           = "Показывать имена на панели";
    HEALBOT_OPTIONS_BARTEXTCLASSCOLOUR1     = "Текст по цвету класса";
    HEALBOT_OPTIONS_EMERGFILTERGROUPS       = "Включая группы";
    HEALBOT_OPTIONS_PLAYERPET               = "Игроки и Питомцы";
    HEALBOT_ONE                             = "1";
    HEALBOT_TWO                             = "2";
    HEALBOT_THREE                           = "3";
    HEALBOT_FOUR                            = "4";
    HEALBOT_FIVE                            = "5";
    HEALBOT_SIX                             = "6";
    HEALBOT_SEVEN                           = "7";
    HEALBOT_EIGHT                           = "8";

    HEALBOT_OPTIONS_SETDEFAULTS             = "По умолчанию";
    HEALBOT_OPTIONS_SETDEFAULTSMSG          = "Сброс всех настроек на стандартные";
    HEALBOT_OPTIONS_RIGHTBOPTIONS           = "ПКМ открывает настройки";

    HEALBOT_OPTIONS_BARHEADEROPTTEXT        = "Настройки заголовка панели";
    HEALBOT_OPTIONS_FRAMEHEADEROPTTEXT      = "Настройки заголовка окна";
    HEALBOT_OPTIONS_ICONOPTTEXT             = "Настройки иконок";
    HEALBOT_OPTIONS_NAMEOPTTEXT             = "Настройки текста имени";
    HEALBOT_OPTIONS_HEALTHOPTTEXT           = "Настройки текста здоровья";
    HEALBOT_OPTIONS_HEALTHTEXTANCHOR        = "Якорь текста здоровья";
    HEALBOT_SKIN_HEADERBARCOL               = "Цвет панелей";
    HEALBOT_SKIN_HEADERTEXTCOL              = "Цвет текста";
    HEALBOT_OPTIONS_BUFFSTEXT1              = "Заклинание баффа";
    HEALBOT_OPTIONS_BUFFSTEXT2              = "Проверять членов группы";
    HEALBOT_OPTIONS_BUFFSTEXT3              = "Цвета панелей";
    HEALBOT_OPTIONS_BUFF                    = "Бафф ";
    HEALBOT_OPTIONS_BUFFSELF                = "на себе";
    HEALBOT_OPTIONS_BUFFPARTY               = "на группе";
    HEALBOT_OPTIONS_BUFFRAID                = "на рейде";
    HEALBOT_OPTIONS_MONITORBUFFS            = "Следить за отсутствием баффов";
    HEALBOT_OPTIONS_MONITORBUFFSC           = "также в бою";
    HEALBOT_OPTIONS_ENABLESMARTCAST         = "УмныйКаст вне боя";
    HEALBOT_OPTIONS_SMARTCASTSPELLS         = "Включая заклинания";
    HEALBOT_OPTIONS_SMARTCASTDISPELL        = "Снять дебафф";
    HEALBOT_OPTIONS_SMARTCASTBUFF           = "Применить бафф";
    HEALBOT_OPTIONS_SMARTCASTHEAL           = "Заклинания исцеления";
    HEALBOT_OPTIONS_BAR2SIZE                = "Размер полосы энергии";
    HEALBOT_OPTIONS_SETSPELLS               = "Заклинания для";
    HEALBOT_OPTIONS_ENABLEDBARS             = "Активных панелей в любом состоянии";
    HEALBOT_OPTIONS_DISABLEDBARS            = "Неактивных панелей вне боя";
    HEALBOT_OPTIONS_MONITORDEBUFFS          = "Следить за дебаффами";
    HEALBOT_OPTIONS_DEBUFFTEXT1             = "Заклинание, снимающее дебаффы";
    
    
    HEALBOT_OPTIONS_POWER                   = "Энергия";
    
    HEALBOT_OPTIONS_HLTHTXTANCHOR01         = "Независимо";
    HEALBOT_OPTIONS_HLTHTXTANCHOR02         = "Справа от Имени";
    HEALBOT_OPTIONS_HLTHTXTANCHOR03         = "Слева от Имени";
    HEALBOT_OPTIONS_HLTHTXTANCHOR04         = "Под Именем";
    HEALBOT_OPTIONS_HLTHTXTANCHOR05         = "Над Именем";
    
    HEALBOT_OPTIONS_AUXBARANCHOR            = "Якорь";
    HEALBOT_OPTIONS_AUXBARANCHOR01          = "Под панелью здоровья";
    HEALBOT_OPTIONS_AUXBARANCHOR02          = "Над панелью здоровья";
    HEALBOT_OPTIONS_AUXBARANCHOR03          = "Слева от панели здоровья";
    HEALBOT_OPTIONS_AUXBARANCHOR04          = "Справа от панели здоровья";
    HEALBOT_OPTIONS_AUXBARANCHOR05          = "Под";
    HEALBOT_OPTIONS_AUXBARANCHOR06          = "Над";
    HEALBOT_OPTIONS_AUXBARANCHOR07          = "Слева";
    HEALBOT_OPTIONS_AUXBARANCHOR08          = "Справа";
    HEALBOT_OPTIONS_IGNOREDEBUFF            = "Игнорировать дебаффы:";

    HEALBOT_OPTIONS_IGNOREDEBUFFDURATION    = "Короткого действия";
    HEALBOT_OPTIONS_IGNOREDEBUFFCOOLDOWN    = "Когда кд на рассеивание > 2.0 сек (ГКД)";
    HEALBOT_OPTIONS_IGNOREDEBUFFFRIEND      = "Когда источник известен, как друг";
    HEALBOT_OPTIONS_MAXBARCACHE             = "Внутренний кеш";
    HEALBOT_OPTIONS_RANGECHECKFREQ          = "Частота проверки дальности, баффов и прочего";

    HEALBOT_OPTIONS_HIDEPARTYFRAMES         = "Скрыть окна группы";
    HEALBOT_OPTIONS_HIDEPLAYERTARGET        = "Включая игрока и цель";
    HEALBOT_OPTIONS_DISABLEHEALBOT          = "Отключить HealBot";
    
    HEALBOT_OPTIONS_STICKYFRAMES            = "Прилипающие окна"
    HEALBOT_OPTIONS_STICKYSENSITIVITY       = "Чувствительность Прилипания"
    HEALBOT_WORD_LOW                        = "Низкая"
    HEALBOT_WORK_HIGH                       = "Высокая"

    HEALBOT_ASSIST                          = "Помощник";
    HEALBOT_FOCUS                           = "Фокус";
    HEALBOT_MENU                            = "Меню";
    HEALBOT_MAINTANK                        = "Главный Танк";
    HEALBOT_STOP                            = "Стоп";
    HEALBOT_TELL                            = "Сказать";

    HEALBOT_OPTIONS_SHOWMINIMAPBUTTON       = "Показывать кнопку у мини-карты";
    HEALBOT_OPTIONS_BARBUTTONSHOWHOT        = "Показывать HoT'ы";
    HEALBOT_OPTIONS_BARBUTTONSHOWRAIDICON   = "Показывать цель рейда";
    HEALBOT_OPTIONS_HOTONBAR                = "На панели";
    HEALBOT_OPTIONS_HOTOFFBAR               = "Вне панели";
    HEALBOT_OPTIONS_HOTBARRIGHT             = "Справа";
    HEALBOT_OPTIONS_HOTBARLEFT              = "Слева";

    HEALBOT_ZONE_AB                         = "Низина Арати"; 
    HEALBOT_ZONE_AV                         = "Альтеракская долина"; 
    HEALBOT_ZONE_ES                         = "Око Бури";
    HEALBOT_ZONE_IC                         = "Остров Завоеваний"; 
    HEALBOT_ZONE_SA                         = "Берег Древних"; 

    HEALBOT_OPTION_AGGROTRACK               = "Следить за угрозой";
    HEALBOT_OPTION_AGGROBAR                 = "Панель";
    HEALBOT_OPTION_AGGROTXT                 = ">> Текст <<";
    HEALBOT_OPTION_AGGROIND                 = "Индикатор";
    HEALBOT_OPTION_BARUPDFREQ               = "Частота обновления";
    HEALBOT_OPTION_USEFLUIDBARS             = "Использовать плавные полосы";
    HEALBOT_OPTIONS_RELOADUIMSG             = "Для того, чтобы настройки вступили в силу, необходима перезагрузка интерфейса. Готовы?";

    HEALBOT_BUFF_PVP                        = "PvP";
    HEALBOT_BUFF_PVE                        = "PvE";
    HEALBOT_OPTIONS_ANCHOR                  = "Якорь окна";
    HEALBOT_OPTIONS_BARSANCHOR              = "Якорь панелей";
    HEALBOT_OPTIONS_TOPLEFT                 = "Слева Сверху";
    HEALBOT_OPTIONS_BOTTOMLEFT              = "Слева Снизу";
    HEALBOT_OPTIONS_TOPRIGHT                = "Справа Сверху";
    HEALBOT_OPTIONS_BOTTOMRIGHT             = "Справа Снизу";
    HEALBOT_OPTIONS_TOP                     = "Сверху";
    HEALBOT_OPTIONS_BOTTOM                  = "Снизу";

    HEALBOT_PANEL_BLACKLIST                 = "Черный Список";
    HEALBOT_WORDS_REMOVEFROM                = "Удалить из";
    HEALBOT_WORDS_ADDTO                     = "Добавить в";
    HEALBOT_WORDS_INCLUDE                   = "Включая";
    HEALBOT_WORDS_UNSET                     = "Выключить";
    HEALBOT_WORDS_SETAS                     = "Включить, как";
    HEALBOT_OPTIONS_TTALPHA                 = "Прозрачность";
    HEALBOT_TOOLTIP_TARGETBAR               = "Панель цели";
    HEALBOT_OPTIONS_MYTARGET                = "Личный Список Целей";
    HEALBOT_OPTIONS_MYFRIEND                = "Мой друг";

    HEALBOT_DISCONNECTED_LABEL              = "Дисконнект"
    HEALBOT_DISCONNECTED_TAG                = "[ DC ] "
    HEALBOT_DEAD_LABEL                      = "Мёртв"
    HEALBOT_DEAD_TAG                        = "[ RIP ] "
    HEALBOT_OUTOFRANGE_LABEL                = "Вне досягаемости"
    HEALBOT_OUTOFRANGE_TAG                  = "[ OOR ] "
    HEALBOT_RESERVED_LABEL                  = "Зарезервирован"
    HEALBOT_RESERVED_TAG                    = "[ R ] "
    HEALBOT_TAGS                            = "Теги"

    HEALBOT_OPTIONS_SHOWUNITBUFFTIME        = "Показывать мои баффы";
    HEALBOT_OPTIONS_BUFFSTEXTTIMER          = "Показать бафф до того, как он кончится";
    HEALBOT_OPTIONS_SHORTBUFFTIMER          = "Короткие баффы";
    HEALBOT_OPTIONS_LONGBUFFTIMER           = "Долгие баффы";

    HEALBOT_OPTIONS_NOTIFY_MSG              = "Cообщение";
    HEALBOT_OPTIONS_CASTNOTIFYTAGS          = " #s='название заклинания'  -  #n='имя игрока' "
    HEALBOT_WORDS_YOU                       = "вы";
    HEALBOT_WORDS_LESSMEM                   = "Меньше Памяти";
    HEALBOT_WORDS_MORECPU                   = "Больше CPU";
    HEALBOT_WORDS_LESSCPU                   = "Меньше CPU";
    HEALBOT_NOTIFYOTHERMSG                  = "Применяется #s на #n";
    HEALBOT_OPTIONS_HOTPOSITION             = "Позиция иконки";
    HEALBOT_OPTIONS_HOTSHOWTEXT             = "Показывать текст иконки";
    HEALBOT_OPTIONS_HOTTEXTCOUNT            = "Стаки";
    HEALBOT_OPTIONS_HOTTEXTDURATION         = "Длительность";
    HEALBOT_OPTIONS_ICONSCALE               = "Масштаб иконки баффа";
    HEALBOT_OPTIONS_DEBUFFICONSCALE         = "Масштаб иконки дебаффа";
    HEALBOT_OPTIONS_MAXICONS                = "Максимально Иконок";
    HEALBOT_OPTIONS_ENABLELIBQH             = "Включить fastHealth";

    HEALBOT_OPTIONS_AGGROBARSIZE            = "Размер панели угрозы";
    HEALBOT_OPTIONS_DOUBLETEXTLINES         = "Текст в 2 строки";
    HEALBOT_OPTIONS_TEXTALIGNMENT           = "Горизонатльное выравнивание";
    HEALBOT_OPTIONS_TEXTOFFSET              = "Вертикальное смещение";
    HEALBOT_OPTIONS_TEXTHOROFFSET           = "Горизонтальное смещение";
    HEALBOT_OPTIONS_TXTOFFSET               = "Смещение";
    HEALBOT_OPTIONS_TXTDEPTH                = "Высота";
    HEALBOT_OPTIONS_TXTSIZE                 = "Размер";
    HEALBOT_OPTIONS_MAXCHARS                = "Максимально Символов";
    HEALBOT_VEHICLE                         = "Транспорт";
    HEALBOT_WORDS_ERROR                     = "Ошибка";
    HEALBOT_SPELL_NOT_FOUND                 = "Заклинание не найдено";
    HEALBOT_OPTIONS_DISABLETOOLTIPINCOMBAT  = "Скрыть подсказки в бою";
    HEALBOT_OPTIONS_BUFFNAMED               = "введите имя игрока для наблюдения:\n\n";
    HEALBOT_WORD_ALWAYS                     = "Всегда";
    HEALBOT_WORD_SOLO                       = "Соло";
    HEALBOT_WORD_NEVER                      = "Никогда";
    HEALBOT_SHOW_CLASS_AS_ICON              = "как иконку";
    HEALBOT_SHOW_CLASS_AS_TEXT              = "как текст";
    HEALBOT_SHOW_ROLE                       = "показ роли, если включено";

    HEALBOT_SHOW_INCHEALS                   = "Показывать входящее исцеление";
    HEALBOT_HELP = {
        [1] = "[HealBot] /hb h -- Показать справку",
        [2] = "[HealBot] /hb o -- Переключение настроек",
        [3] = "[HealBot] /hb t -- Вкл/Выкл HealBot",
        [4] = "[HealBot] /hb bt -- Вкл/Выкл отслеживание баффов",
        [5] = "[HealBot] /hb dt -- Вкл/Выкл отслеживание дебаффов",
        [6] = "[HealBot] /hb skin <skinName> -- Сменить Скин",
        [7] = "[HealBot] /hb d -- Сбросить настройки на стандартные",
        [8] = "[HealBot] /hb spt -- Вкл/Выкл Своего Питомца",
        [9] = "[HealBot] /hb flb -- Вкл/Выкл обхода блокировки окна (окна всегда двигается при момощи Ctrl+Alt+ЛКМ)",
        [10] = "[HealBot] /hb hs -- Показать дополнительные слеш-команды",
        [11] = "[HealBot] - Все команды перечислены на сайте HealBot'а "..HEALBOT_ABOUT_URL,
        }

    HEALBOT_HELP2 = {
        [1] = "[HealBot] /hb rtb -- Вкл/Выкл ограничение панели цели до ЛКМ=УмныйКаст и ПКМ=добавить/удалить мою цель",
        [2] = "[HealBot] /hb aggro 2 <n> -- Установить уровень угрозы 2 в процентах от угрозы <n>",
        [3] = "[HealBot] /hb aggro 3 <n> -- Установить уровень угрозы 3 в процентах от угрозы <n>",
        [4] = "[HealBot] /hb tr <Role> -- Установить высший приоритет для роли при дополнительной сортировке по ролям. Возможные роли: 'TANK', 'HEALER', 'DPS'",
        [5] = "[HealBot] /hb use10 -- Автоматически использовать инженерный слот 10",
        [6] = "[HealBot] /hb pcs <n> -- Установить размер индикатора зарядов Энергии Света в <n>, по умолчанию 7 ",
        [7] = "[HealBot] /hb hrfm -- Сменить метод скрытия рейдовых фреймов Blizzard, отключить совсем или просто спрятать",
        [8] = "[HealBot] /hb ws -- Переключить отображение иконки Ослабевшей Души вместо Слово Силы: Щит с минусом",
        [9] = "[HealBot] /hb rld <n> -- Время в секундах, в течение которого имена игроков остаются зелеными после воскрешения",
        [10] = "[HealBot] /hb shhp <n> -- Показывать бафф Гимна Надежды только когда мана меньше <n>",
        [11] = "[HealBot] - Также смотрите Команды в основной вкладке настроек",
    }

    HEALBOT_OPTION_HIGHLIGHTACTIVEBAR       = "Выделять";
    HEALBOT_OPTION_HIGHLIGHTTARGETBAR       = "Выделять цель";
    HEALBOT_OPTIONS_TESTBARS                = "Тестовые панели";
    HEALBOT_OPTIONS_TURNTESTBARSON          = "Включить"
    HEALBOT_OPTIONS_TURNTESTBARSOFF         = "Выключить"
    HEALBOT_OPTION_NUMBARS                  = "Количество панелей";
    HEALBOT_OPTION_NUMTANKS                 = "Количество танков";
    HEALBOT_OPTION_NUMMYTARGETS             = "Количество моих целей";
    HEALBOT_OPTION_NUMHEALERS               = "Количество целителей";
    HEALBOT_OPTION_NUMPETS                  = "Количество питомцев";
    HEALBOT_WORD_TEST                       = "Тест";
    HEALBOT_WORD_TEXT                       = "Текст";
    HEALBOT_WORD_OFF                        = "Выкл";
    HEALBOT_WORD_ON                         = "Вкл";

    HEALBOT_OPTIONS_TAB_PROTECTION          = "Защита";
    HEALBOT_OPTIONS_TAB_CHAT                = "Чат";
    HEALBOT_OPTIONS_TAB_HEADERS             = "Заголовки";
    HEALBOT_OPTIONS_TAB_BARS                = "Панели";
    HEALBOT_OPTIONS_TAB_ICONS               = "Иконки";
    HEALBOT_OPTIONS_TAB_WARNING             = "Оповещене";
    HEALBOT_OPTIONS_SKINDEFAULTFOR          = "Стандартный скин для";
    HEALBOT_OPTIONS_INCHEAL                 = "Входящее исцеление";
    HEALBOT_OPTIONS_INCABSORB               = "Поглощения"
    HEALBOT_OPTIONS_NOOVERHEALS             = "Без оверхила"
    HEALBOT_WORD_OVERHEALS                  = "Оверхил"
    HEALBOT_WORD_ARENA                      = "Арена";
    HEALBOT_WORD_BATTLEGROUND               = "Поле боя";
    HEALBOT_WORD_BG10                       = "BG 10"; 
    HEALBOT_WORD_BG15                       = "BG 15";
    HEALBOT_WORD_BG40                       = "BG 40";     
    HEALBOT_OPTIONS_TEXTOPTIONS             = "Текст панели";
    HEALBOT_WORD_PARTY                      = "Группа";
    HEALBOT_WORD_COLOUR                     = "Цвет";
    HEALBOT_OPTIONS_COMBOAUTOTARGET         = "Авто-цель";
    HEALBOT_OPTIONS_COMBOAUTOTRINKET        = "Авто Тринкет";
    HEALBOT_OPTIONS_GROUPSPERCOLUMN         = "Количество групп в колонке";

    HEALBOT_OPTIONS_MAINSORT                = "Основная сортировка";
    HEALBOT_OPTIONS_SUBSORT                 = "Дополнительная сортировка";
    HEALBOT_OPTIONS_SUBSORTINC              = "Также сортировать:";
    HEALBOT_OPTIONS_BUTTONCASTMETHOD        = "Применить, \nкогда";
    HEALBOT_OPTIONS_BUTTONCASTPRESSED       = "Нажата";
    HEALBOT_OPTIONS_BUTTONCASTRELEASED      = "Отпущена";

    HEALBOT_WORD_HEALER                     = "Лекарь";
    HEALBOT_WORD_DAMAGER                    = "ДД";
    HEALBOT_WORD_TANK                       = "Танк";
    HEALBOT_WORD_LEADER                     = "Лидер";
    HEALBOT_WORD_VERSION                    = "Версия";
    HEALBOT_WORD_CLIENT                     = "Клиент";

    HEALBOT_WORD_STAR                       = "Звезда";
    HEALBOT_WORD_CIRCLE                     = "Круг";
    HEALBOT_WORD_DIAMOND                    = "Ромб";
    HEALBOT_WORD_TRIANGLE                   = "Треугольник";
    HEALBOT_WORD_MOON                       = "Луна";
    HEALBOT_WORD_SQUARE                     = "Квадрат";
    HEALBOT_WORD_CROSS                      = "Крест";
    HEALBOT_WORD_SKULL                      = "Череп";

    HEALBOT_OPTIONS_ACCEPTSKINMSG           = "Принять скин [HealBot]: ";
    HEALBOT_OPTIONS_ACCEPTSKINMSGFROM       = " от ";
    HEALBOT_OPTIONS_EXPORTSKIN              = "Выбрать скин";
    HEALBOT_OPTIONS_EXTRASKINS              = "Дополнительные скины";
    HEALBOT_OPTIONS_BUTTONEXPORT            = "Экспортировать";
    HEALBOT_OPTIONS_BUTTONIMPORT            = "Импортировать";
    HEALBOT_OPTIONS_BUTTONIMPORTMETHOD      = "Метод импортирования";
    HEALBOT_IMPORT_OVERWRITEALL             = "Перезаписать все (Удалить существующие, затем вставить все)";
    HEALBOT_IMPORT_MERGEALL                 = "Объединить все (Обновить существующие, затем вставить новый)";
    HEALBOT_IMPORT_MERGENEW                 = "Объединить новый (Только вставить новый)";

    HEALBOT_CHAT_ADDONID                    = "[HealBot]  ";
    HEALBOT_CHAT_NEWVERSION1                = "Доступна новая версия";
    HEALBOT_CHAT_NEWVERSION2                = "на "..HEALBOT_ABOUT_URL;
    HEALBOT_CHAT_SHARESKINERR1              = " Скин для отправки не найден";
    HEALBOT_CHAT_SHARESKINERR3              = " не найден для отправки";
    HEALBOT_CHAT_SHARESKINACPT              = "Скин принят от ";
    HEALBOT_CHAT_CONFIRMSKINDEFAULTS        = "Скин по умолчанию";
    HEALBOT_CHAT_CONFIRMCUSTOMDEFAULTS      = "Пользовательские дебаффы сброшены";
    HEALBOT_CHAT_CHANGESKINERR1             = "Неизвестный скин: /hb skin ";
    HEALBOT_CHAT_CHANGESKINERR2             = "Работающие скины:  ";
    HEALBOT_CHAT_CONFIRMSPELLCOPY           = "Текущие заклинания скопированы во все спеки";
    HEALBOT_CHAT_UNKNOWNCMD                 = "Неизвестная слеш-команда: /hb ";
    HEALBOT_CHAT_ENABLED                    = "Вход в активное состояние";
    HEALBOT_CHAT_DISABLED                   = "Вход в отключенное состояние";
    HEALBOT_CHAT_SOFTRELOAD                 = "Запрошен перезапуск HealBot'а";
    HEALBOT_CHAT_HARDRELOAD                 = "Запрошена перезагрузка UI";
    HEALBOT_CHAT_CONFIRMSPELLRESET          = "Заклинания сброшены";
    HEALBOT_CHAT_CONFIRMCURESRESET          = "Рассеивания сброшены";
    HEALBOT_CHAT_CONFIRMBUFFSRESET          = "Баффы сброшены";
    HEALBOT_CHAT_POSSIBLEMISSINGMEDIA       = "Не удалось получить все настройки скина - Возможно отсутствует SharedMedia, скачайте на curse.com";
    HEALBOT_CHAT_MACROSOUNDON               = "Звук не отключен при использовании авто-тринкета";
    HEALBOT_CHAT_MACROSOUNDOFF              = "Звук отключен при использовании авто-тринкета";
    HEALBOT_CHAT_MACROERRORON               = "Ошибки не отключены при использовании авто-тринкета";
    HEALBOT_CHAT_MACROERROROFF              = "Ошибки отключены при использованияи авто-тринкета";
    HEALBOT_CHAT_USE10ON                    = "Авто-Тринкет - Use10 вкл - Вы должны выбрать существующий авто-тринкет";
    HEALBOT_CHAT_USE10OFF                   = "Авто-Тринкет - Use10 выкл";
    HEALBOT_CHAT_SKINREC                    = " скин импортирован";

    HEALBOT_OPTIONS_SELFCASTS               = "Только на себя";
    HEALBOT_OPTIONS_HOTSHOWICON             = "Показывать иконку";
    HEALBOT_OPTIONS_ALLSPELLS               = "Баффы/HoT'ы";
    HEALBOT_OPTIONS_DOUBLEROW               = "Двойной ряд";
    HEALBOT_OPTIONS_HOTBELOWBAR             = "Под панелью";
    HEALBOT_OPTIONS_OTHERSPELLS             = "Другие заклинания";
    HEALBOT_WORD_MACROS                     = "Макрос";
    HEALBOT_WORD_SELECT                     = "Выбрать";
    HEALBOT_OPTIONS_QUESTION                = "?";
    HEALBOT_WORD_CANCEL                     = "Отмена";
    HEALBOT_WORD_COMMANDS                   = "Команды";
    HEALBOT_OPTIONS_BARHEALTH3              = "как здоровье";
    HEALBOT_SORTBY_ROLE                     = "Роль";
    HEALBOT_WORD_DPS                        = "DPS";
    HEALBOT_CHAT_TOPROLEERR                 = " роль не действительна в данном контексте - используйте 'TANK', 'DPS' или 'HEALER'";
    HEALBOT_CHAT_NEWTOPROLE                 = "Самая приоритетная роль теперь ";
    HEALBOT_CHAT_SUBSORTPLAYER1             = "Игрок будет отображаться первым в Доп.Сортировке";
    HEALBOT_CHAT_SUBSORTPLAYER2             = "Игрок будет отображаться как обычно в Доп.Сортировке";
    HEALBOT_OPTIONS_SHOWREADYCHECK          = "Показывать Проверку готовности";
    HEALBOT_OPTIONS_SUBSORTSELFFIRST        = "Доп.Сортировка - Сначала вы";
    HEALBOT_OPTION_AGGROPCTBAR              = "Двигать панель";
    HEALBOT_OPTION_AGGROPCTTXT              = "Показать текст";
    HEALBOT_OPTION_AGGROPCTTRACK            = "Следить за %";
    HEALBOT_OPTIONS_ALERTAGGROLEVEL1        = "1 - Низкая угроза";
    HEALBOT_OPTIONS_ALERTAGGROLEVEL2        = "2 - Высокая угроза";
    HEALBOT_OPTIONS_ALERTAGGROLEVEL3        = "3 - Танкование";
    HEALBOT_OPTIONS_AGGROALERT              = "Уровень оповещения на вспом.панели";
    HEALBOT_OPTIONS_AGGROINDALERT           = "Уровень оповещения на индикаторе";
    HEALBOT_OPTIONS_TOOLTIPSHOWHOT          = "Показать подробности о наблюдаемом HoT'е";
    HEALBOT_WORDS_MIN                       = "мин";
    HEALBOT_WORDS_MAX                       = "макс";
    HEALBOT_CHAT_SELFPETSON                 = "Свой Питомец включен";
    HEALBOT_CHAT_SELFPETSOFF                = "Свой Питомец выключен";
    HEALBOT_WORD_PRIORITY                   = "Приоритет";
    HEALBOT_VISIBLE_RANGE                   = "В пределах 100 метров";
    HEALBOT_SPELL_RANGE                     = "В пределах действия заклинания";
    HEALBOT_WORD_RESET                      = "Сброс";
    HEALBOT_WOWMENU                         = "Меню Blizzard";
    HEALBOT_HBMENU                          = "Меню HealBot";
    HEALBOT_ACTION_HBFOCUS                  = "Левый клик - установить\nфокус на цель";
    HEALBOT_WORD_CLEAR                      = "Очистить";
    HEALBOT_WORD_SET                        = "Установить";
    HEALBOT_WORD_HBFOCUS                    = "Фокус HealBot";
    HEALBOT_WORD_OUTSIDE                    = "Внешний мир";
    HEALBOT_WORD_ALLZONE                    = "Все зоны";
    HEALBOT_OPTIONS_TAB_ALERT               = "Тревога";
    HEALBOT_OPTIONS_TAB_SORT                = "Сортировка";
    HEALBOT_OPTIONS_TAB_HIDE                = "Скрыть";
    HEALBOT_OPTIONS_TAB_VISIBILITY          = "Видимость"
    HEALBOT_OPTIONS_TAB_AGGRO               = "Угроза";
    HEALBOT_OPTIONS_TAB_AUX                 = "Вспом.панель"
    HEALBOT_OPTIONS_TAB_ICONTEXT            = "Текст иконки";
    HEALBOT_OPTIONS_TAB_TEXT                = "Текст";
    HEALBOT_OPTIONS_AGGRO3COL               = "Цвет панели\nугрозы";
    HEALBOT_OPTIONS_AGGROFLASHFREQ          = "Частота мерцания";
    HEALBOT_OPTIONS_WORD_FASTER             = "Быстрее"
    HEALBOT_OPTIONS_WORD_SLOWER             = "Медленнее"
    HEALBOT_OPTIONS_AGGROFLASHALPHA         = "Прозрачность мерцания";
    HEALBOT_OPTIONS_SHOWDURATIONFROM        = "Показывать длительность от";
    HEALBOT_OPTIONS_SHOWDURATIONWARN        = "Оповещение об окончании на";
    HEALBOT_CMD_RESETCUSTOMDEBUFFS          = "Сброс пользовательских дебаффов";
    HEALBOT_CMD_RESETSKINS                  = "Сброс скинов";
    HEALBOT_CMD_CLEARBLACKLIST              = "Очистить черный список";
    HEALBOT_CMD_TOGGLEDISLIKEMOUNT          = "Вкл/Выкл игнорирование маунта";
    HEALBOT_OPTION_DISLIKEMOUNT_ON          = "Маунт игнорируется";
    HEALBOT_OPTION_DISLIKEMOUNT_OFF         = "Маунт больше не игнорируется";
    HEALBOT_CMD_COPYSPELLS                  = "Копировать текущие заклинания во все спеки";
    HEALBOT_CMD_RESETSPELLS                 = "Сброс заклинаний";
    HEALBOT_CMD_RESETCURES                  = "Сброс дебаффов";
    HEALBOT_CMD_RESETBUFFS                  = "Сброс баффов";
    HEALBOT_CMD_RESETICONS                  = "Сброс пользовательских баффов"
    HEALBOT_CMD_RESETBARS                   = "Сброс позиций панелей";
    HEALBOT_CMD_SUPPRESSSOUND               = "Вкл/Выкл подавление звука при использовании авто-тринкета";
    HEALBOT_CMD_SUPPRESSERRORS              = "Вкл/Выкл подавление ошибок при использовании авто-тринкета";
    HEALBOT_OPTIONS_COMMANDS                = "Команды HealBot";
    HEALBOT_WORD_RUN                        = "Пуск";
    HEALBOT_OPTIONS_MOUSEWHEEL              = "Использовать колёсико мыши";
    HEALBOT_OPTIONS_MOUSEUP                 = "Колёсико вверх";
    HEALBOT_OPTIONS_MOUSEDOWN               = "Колёсико вниз";
    HEALBOT_CMD_DELCUSTOMDEBUFF9            = "Удалить пользовательские дебаффы с приоритетом 9";
    HEALBOT_CMD_DELCUSTOMDEBUFF10           = "Удалить пользовательские дебаффы с приоритетом 10";
    HEALBOT_CMD_DELCUSTOMDEBUFF11           = "Удалить пользовательские дебаффы с приоритетом 11";
    HEALBOT_CMD_DELCUSTOMDEBUFF12           = "Удалить пользовательские дебаффы с приоритетом 12";
    HEALBOT_ACCEPTSKINS                     = "Принимать Скины от других";
    HEALBOT_SUPPRESSSOUND                   = "Авто-Тринкет: подавлять звуки";
    HEALBOT_SUPPRESSERROR                   = "Авто-Тринкет: подавлять ошибки";
    HEALBOT_OPTIONS_CRASHPROT               = "Защита от сбоев";
    HEALBOT_OPTIONS_USEGENERALMACRO         = "Исп. слот основных макросов"
    HEALBOT_CP_MACRO_LEN                    = "Имя макроса должно быть от 1 до 14 символов";
    HEALBOT_CP_MACRO_BASE                   = "Основное имя макроса";
    HEALBOT_CP_MACRO_SAVE                   = "Последнее сохранение в: ";
    HEALBOT_CP_STARTTIME                    = "Время ожидания входа в систему";
    HEALBOT_OPTIONS_COMBATPROT              = "Защита в состоянии боя"
    HEALBOT_COMBATPROT_PARTYNO              = "панелей зарезервировано для Группы";
    HEALBOT_COMBATPROT_RAIDNO               = "панелей зарезервировано для Рейда";
    HEALBOT_SKIN_CHECK_DONE                 = "Проверка целостности скинов завершена";
    HEALBOT_ALLOW_DUPLICATES                = "Разрешить дубликаты";
    HEALBOT_OPTIONS_AUXSETTINGS             = "Вспомогательные панели: Настройки";
    HEALBOT_OPTIONS_AUXASSIGN               = "Вспомогательные панели: Назначения";
    HEALBOT_OPTIONS_AUXCONFIG               = "Вспомогательные панели: Конфигурация";
    HEALBOT_OPTIONS_AUXFLASH                = "Переменная Прозрачность";
    HEALBOT_WORD_ASSIGNMENT                 = "Назначение:";
    HEALBOT_WORD_ANCHOR                     = "Якорь:";
    HEALBOT_OPTIONS_AUXOVERLAP              = "Расширить размер Вспом.панелей";
    HEALBOT_OPTIONS_AUXINDCONFIG            = "Индивидуальная конфигурация панели";
    HEALBOT_OPTIONS_AUX1                    = "Вспом.панель 1";
    HEALBOT_OPTIONS_AUX2                    = "Вспом.панель 2";
    HEALBOT_OPTIONS_AUX3                    = "Вспом.панель 3";
    HEALBOT_OPTIONS_AUX4                    = "Вспом.панель 4";
    HEALBOT_OPTIONS_AUX5                    = "Вспом.панель 5";
    HEALBOT_OPTIONS_AUX6                    = "Вспом.панель 6";
    HEALBOT_OPTIONS_AUX7                    = "Вспом.панель 7";
    HEALBOT_OPTIONS_AUX8                    = "Вспом.панель 8";
    HEALBOT_OPTIONS_AUX9                    = "Вспом.панель 9";
    HEALBOT_OPTIONS_FULLAUX                 = "Вспомогательная панель ";
    HEALBOT_OPTIONS_AUXOPACITYTYPE          = "Тип Прозрачности";
    HEALBOT_OPTIONS_AUXOPACITYTYPE1         = "Фиксированная";
    HEALBOT_OPTIONS_AUXOPACITYTYPE2         = "Переменная";

    HEALBOT_WORD_HEALTH                     = "Здоровье";
    HEALBOT_OPTIONS_DONT_SHOW               = "Не показывать";
    HEALBOT_OPTIONS_SAME_AS_HLTH_CURRENT    = "То же, что и здоровье (текущее здоровье)";
    HEALBOT_OPTIONS_SAME_AS_HLTH_FUTURE     = "То же, что и здоровье (будущее здоровье)";
    HEALBOT_OPTIONS_FUTURE_HLTH             = "Будущее здоровье";
    HEALBOT_SKIN_HEALTHBARCOL_TEXT          = "Панель здоровья";
    HEALBOT_SKIN_NAMETEXTCOL_TEXT           = "Цвет текста"
    HEALBOT_SKIN_HEALTHBACKCOL_TEXT         = "Фон панели";
    HEALBOT_SKIN_INCHEALBARCOL_TEXT         = "Цвет входящего исцеления";
    HEALBOT_OPTIONS_GROUP_PETS_BY_FIVE      = "Питомцы: группировать по пять";
    HEALBOT_OPTIONS_OWN_PET_WITH_SELF       = "Свой питомец: вместе с собой";
    HEALBOT_OPTIONS_USEGAMETOOLTIP          = "Использовать Игровую Подсказку";
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER        = "Показывать полосу энергии";
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER_PALA   = "Показывать энергию света";
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER_MONK   = "Показывать энергию чи";
    HEALBOT_OPTIONS_DISABLEHEALBOTSOLO      = "только в соло";
    HEALBOT_OPTIONS_CUSTOM_ALLDISEASE       = "Все Болезни";
    HEALBOT_OPTIONS_CUSTOM_ALLMAGIC         = "Все Магические";
    HEALBOT_OPTIONS_CUSTOM_ALLCURSE         = "Все Проклятия";
    HEALBOT_OPTIONS_CUSTOM_ALLPOISON        = "Все Яды";
    HEALBOT_OPTIONS_CUSTOM_ALLBOSS          = "Все боссы";
    HEALBOT_OPTIONS_CUSTOM_ALLBOSSSTRICT    = "Строгий Режим";
    HEALBOT_OPTIONS_CUSTOM_IDMETHOD         = "Определять по";
    HEALBOT_OPTIONS_CUSTOM_CASTBY           = "Источник";
    HEALBOT_OPTIONS_CUSTOM_IDMETHODSID      = "ID заклинания"
    HEALBOT_OPTIONS_CUSTOM_IDMETHODSNAME    = "Название Заклинания"
    HEALBOT_OPTIONS_CUSTOM_IDMETHODSBOTH    = "ID или Название"

    HEALBOT_BLIZZARD_MENU                   = "Меню Blizzard";
    HEALBOT_HB_MENU                         = "Меню Healbot";
    HEALBOT_FOLLOW                          = "Следовать";
    HEALBOT_TRADE                           = "Обмен";
    HEALBOT_PROMOTE_RA                      = "Назначить рейд-ассист";
    HEALBOT_DEMOTE_RA                       = "Разжаловать рейд-ассист";
    HEALBOT_TOGGLE_ENABLED                  = "Активировать/Деактивировать";
    HEALBOT_TOGGLE_MYTARGETS                = "Вкл/Выкл Личный Список Целей";
    HEALBOT_WORD_PERMANENT                  = "Постоянно"
    HEALBOT_TOGGLE_PRIVATETANKS             = "Вкл/Выкл личных танков";
    HEALBOT_TOGGLE_PRIVATEHEALERS           = "Вкл/Выкл личных лекарей"
    HEALBOT_RESET_BAR                       = "Сброс панели";
    HEALBOT_HIDE_BARS                       = "Скрыть полосы дальше 100 метров";
    HEALBOT_RANDOMMOUNT                     = "Случайный маунт";
    HEALBOT_RANDOMGOUNDMOUNT                = "Случайный наземный маунт";
    HEALBOT_RANDOMPET                       = "Случайный спутник";
    HEALBOT_RANDOMFAVMOUNT                  = "Случайный избранный маунт"
    HEALBOT_RANDOMFAVPET                    = "Случайный избранный спутник"        
    HEALBOT_EXTRASKINS_CAT_GROUP            = "Группа"
    HEALBOT_EXTRASKINS_CAT_SRAID            = "Небольшой Рейд"
    HEALBOT_EXTRASKINS_CAT_LRAID            = "Большой рейд"
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
    HEALBOT_ZONE_AQ40                       = "Ан'Кираж";
    HEALBOT_ZONE_VASHJIR1                   = "Лес Келп'тар";
    HEALBOT_ZONE_VASHJIR2                   = "Мерцающий простор";
    HEALBOT_ZONE_VASHJIR3                   = "Бездонные глубины";
    HEALBOT_ZONE_VASHJIR                    = "Вайш'ир";
    HEALBOT_RESLAG_INDICATOR                = "Оставлять имя зеленым после воскрешения";
    HEALBOT_RESLAG_INDICATOR_ERROR          = "Оставлять имя зеленым после воскрешения должно быть от 1 до 30";
    HEALBOT_FRAMELOCK_BYPASS_OFF            = "Обход блокировки окон выключен";
    HEALBOT_FRAMELOCK_BYPASS_ON             = "Обход блокировки окон (Ctl+Alt+ЛКМ) включен";
    HEALBOT_RESTRICTTARGETBAR_ON            = "Панель ограниченной цели включена";
    HEALBOT_RESTRICTTARGETBAR_OFF           = "Панель ограниченной цели выключена";
    HEALBOT_AGGRO2_ERROR_MSG                = "Для установки уровня угрозы 2, процент угрозы дожен быть между 25 и 95";
    HEALBOT_AGGRO3_ERROR_MSG                = "Для установки уровня угрозы 3, процент угрозы дожен быть между 75 and 100";
    HEALBOT_AGGRO2_SET_MSG                  = "Уровень угрозы 2 установлен на процент угрозы ";
    HEALBOT_AGGRO3_SET_MSG                  = "Уровень угрозы 3 установлен на процент угрозы ";
    HEALBOT_WORD_THREAT                     = "Угроза";
    HEALBOT_AGGRO_ERROR_MSG                 = "Неправильный уровень угрозы - используйте 2 или 3";
    HEALBOT_OPTIONS_QUERYTALENTS            = "Запрашивать данные о талантах";
    HEALBOT_OPTIONS_LOWMANAINDICATOR        = "Индикатор малого запаса маны";
    HEALBOT_OPTIONS_LOWMANAINDICATOR1       = "Не показывать";
    HEALBOT_OPTIONS_LOWMANAINDICATOR2       = "*10% / **20% / ***30%";
    HEALBOT_OPTIONS_LOWMANAINDICATOR3       = "*15% / **30% / ***45%";
    HEALBOT_OPTIONS_LOWMANAINDICATOR4       = "*20% / **40% / ***60%";
    HEALBOT_OPTIONS_LOWMANAINDICATOR5       = "*25% / **50% / ***75%";
    HEALBOT_OPTIONS_LOWMANAINDICATOR6       = "*30% / **60% / ***90%";
    HEALBOT_OPTION_IGNORE_AURA_RESTED       = "Игнорировать события аур при отдыхе";
    HEALBOT_OPTION_ADJUST_MAX_HEALTH        = "Выровнять макс. здоровье"

    HEALBOT_WORD_ENABLE                     = "Включить";
    HEALBOT_WORD_DISABLE                    = "Выключить";

    HEALBOT_OPTIONS_MYCLASS                 = "Мой Класс";
    HEALBOT_OPTIONS_CONTENT_ABOUT           = "        Информация";
    HEALBOT_OPTIONS_CONTENT_GENERAL         = "        " .. HEALBOT_OPTIONS_TAB_GENERAL;
    HEALBOT_OPTIONS_CONTENT_SPELLS          = "        " .. HEALBOT_OPTIONS_TAB_SPELLS;
    HEALBOT_OPTIONS_CONTENT_SKINS           = "        " .. HEALBOT_OPTIONS_TAB_SKIN;
    HEALBOT_OPTIONS_CONTENT_CURE            = "        " .. HEALBOT_OPTIONS_TAB_DEBUFFS;
    HEALBOT_OPTIONS_CONTENT_BUFFS           = "        " .. HEALBOT_OPTIONS_TAB_BUFFS;
    HEALBOT_OPTIONS_CONTENT_TIPS            = "        " .. HEALBOT_OPTIONS_TAB_TIPS;
    HEALBOT_OPTIONS_CONTENT_MOUSEWHEEL      = "        Колёсико мыши";
    HEALBOT_OPTIONS_CONTENT_TEST            = "        Тест";
    HEALBOT_OPTIONS_CONTENT_INOUT           = "        Импорт / Экспорт"
    HEALBOT_OPTIONS_REFRESH                 = "Обновить";

    HEALBOT_CUSTOM_CATEGORY                 = "Категория";
    HEALBOT_CUSTOM_CAT_CUSTOM               = "Своя";
    HEALBOT_CUSTOM_CAT_02                   = "А-Б";   -- ****************************************************
    HEALBOT_CUSTOM_CAT_03                   = "В-Г";   -- Custom Debuff Categories can be translated
    HEALBOT_CUSTOM_CAT_04                   = "Д-Е";   --
    HEALBOT_CUSTOM_CAT_05                   = "Ж-З";   -- If translating into a language with a completely different alphabet,
    HEALBOT_CUSTOM_CAT_06                   = "И-К";   -- the descriptions of HEALBOT_CUSTOM_CAT_02 - HEALBOT_CUSTOM_CAT_14 can be changed.
    HEALBOT_CUSTOM_CAT_07                   = "Л-М";   -- Just ensure all 13 variables are used
    HEALBOT_CUSTOM_CAT_08                   = "Н-О";   --
    HEALBOT_CUSTOM_CAT_09                   = "П-Р";   -- Setting debuffs in HEALBOT_CUSTOM_DEBUFF_CATS,
    HEALBOT_CUSTOM_CAT_10                   = "С-Т";   -- The only rule is the category number needs to match the last digits of the variable names, for example:
    HEALBOT_CUSTOM_CAT_11                   = "У-Ф";   -- If HEALBOT_DEBUFF_AGONIZING_FLAMES starts with an T in a different region
    HEALBOT_CUSTOM_CAT_12                   = "Х-Ц";   -- the category would be 11, simply change the 2 to 11.
    HEALBOT_CUSTOM_CAT_13                   = "Ч-Щ";   --
    HEALBOT_CUSTOM_CAT_14                   = "Э-Я";   -- ****************************************************

    HEALBOT_CUSTOM_CASTBY_EVERYONE          = "Все";
    HEALBOT_CUSTOM_CASTBY_ENEMY             = "Враг";
    HEALBOT_CUSTOM_CASTBY_FRIEND            = "Друг";
    
    HEALBOT_CUSTOM_CAT_CUSTOM_AUTOMATIC     = "Автоматические дебаффы"
    HEALBOT_CUSTOM_DEBUFF_CATS = {}

    HEALBOT_ABOUT_DESC1                     = "Добавляет окно со стилизуемыми панелями для исцеления, рассеивания, наложения баффов и отслеживания угрозы.";
    HEALBOT_ABOUT_WEBSITE                   = "Сайт:";
    HEALBOT_ABOUT_AUTHORH                   = "Автор:";
    HEALBOT_ABOUT_AUTHORD                   = "Strife";
    HEALBOT_ABOUT_CATH                      = "Категория:";
    HEALBOT_ABOUT_CATD                      = "Unit Frames, Buffs and Debuffs, Combat:Healer";
    HEALBOT_ABOUT_CREDITH                   = "Благодарности:";
    HEALBOT_ABOUT_CREDITD                   = "Acirac, Kubik, Von, Aldetal, Brezza, Moonlight Han Xing, CTShammy, Hermis, Ariá, Snaomi, R1SK";  -- Anyone taking on translations (if required), feel free to add yourself here.
    HEALBOT_ABOUT_LOCALH                    = "Локализации:";
    HEALBOT_ABOUT_LOCALD                    = "deDE, enUK, esES, frFR, huHU, itIT, koKR, poBR, ruRU, zhCN, zhTW";
    HEALBOT_ABOUT_FAQH                      = "Часто Задаваемые Вопросы";
    HEALBOT_ABOUT_FAQ_QUESTION              = "Вопрос";
    HEALBOT_ABOUT_FAQ_ANSWER                = "Ответ";

    HEALBOT_ABOUT_FAQ_QUESTIONS = {
        [1]   = "Баффы - Все панели белые, что случилось?",
        [2]   = "Применение - Иногда курсор становится синим и я не могу ничего делать",
        [3]   = "Макросы - Есть примеры с временем восстановления?",
        [4]   = "Макросы - Есть примеры с применением заклинаний?",
        [5]   = "Мышь - Как использовать мой mouseover макрос с колесиком мыши?",
        [6]   = "Настройки - Как отсортировать панели по группам, например по 2 группы в колонке?",
        [7]   = "Настройки - Могу ли я спрятать все панели и показать только те, которым нужно рассеивание?",
        [8]   = "Настройки - Могу ли спрятать входящее исцеление?",
        [9]   = "Настройки - Healbot не сохраняет мои настройки при входе в игру/выходе из игры",
        [10]  = "Настройки - Как мне всегда использовать настройки для активных панелей?",
        [11]  = "Настройки - Как автоматически отключать healbot?",
        [12]  = "Настройки - Как заставить панели расти в разных направлениях?",
        [13]  = "Настройки - Как настроить 'Личный Список Целей'?",
        [14]  = "Настройки - Как настроить 'Личных танков'?",
        [15]  = "Настройки - Может ли Healbot создавать панели для NPC?",
        [16]  = "Расстояние - Я не вижу когда люди вне досягаемости, как это исправить?",
        [17]  = "Заклинания - Healbot применяет заклинание, отличное от настроенного",
        [18]  = "Заклинания - Я больше не могу применять заклинания к здоровым целям",
    }

    HEALBOT_ABOUT_FAQ_SPELLS_ANSWER01 = "Это из-за настроек вкладки Заклинания\n" ..
                                        "попробуйте внести следующие изменения: \n\n" ..
                                        "1: Во вкладке Заклинания: выберите Панели всегда активны\n" ..
                                        "2: Во вкладке Заклинания: выключите УмныйКаст\n\n" ..
                                        "Примечание: Предполагается что большинство пользователей\n"..
                                        "захотят включить УмныйКаст обратно.\n\n" ..
                                        "Примечание: Предполагается что опытные пользователи захотят\n" ..
                                        "выключить Панели всегда активны и назначить заклинания для\n" ..
                                        "неактивных панелей."

    HEALBOT_ABOUT_FAQ_ANSWERS = {
        [1] = "Вы следите за отсутствующими баффами.\n\n" ..
              "Это может быть выключено во вкладке Баффы.\n" ..
              "Или просто нажмите на панель для применения баффа.",
        [2] = "Это функционал Blizzard, а не Healbot.\n\n" ..
              "Используя стандартные панели Blizzard, попытайтесь\n" ..
              "применить заклинание, которое еще не восстановилось.\n" ..
              "Заметьте, что курсор стал синим.\n\n" ..
              "Во вкладке Заклинания, включите Избегать Синего Курсора.",
        [3] = "Да.\n\n"..
              "Пример макроса для восстановления заклинания\nпаладина Длань спасения:\n\n" ..
              "#show Длань спасения\n" ..
              '/script local n=UnitName("hbtarget");' .. "\n" ..
              'if GetSpellCooldown("Длань спасения")==0 then' .. " \n" ..
              'SendChatMessage("Длань спасения на "..n,"YELL")' .. "\n" ..
              'SendChatMessage("Длань спасения!","WHISPER",nil,n)' .. "\n" ..
              "end; \n" ..
              "/cast [@hbtarget] Длань спасения",
        [4] = "Да\n\n"..
              "Пример применения Быстрого исцеления\nс использованием обоих тринкетов:\n\n" ..
              "#show Быстрое исцеление\n" ..
              "/script UIErrorsFrame:Hide()\n" ..
              "/console Sound_EnableSFX 0\n" ..
              "/use 13\n" ..
              "/use 14\n" ..
              "/console Sound_EnableSFX 1\n" ..
              "/cast [@hbtarget] Быстрое исцеление\n" ..
              "/script UIErrorsFrame:Clear(); UIErrorsFrame:Show()",
        [5] = "1: Во вкладке Колёсико мыши: Выключите\nИспользовать колесико мыши\n" ..
              "2: Назначьте ваш макрос с использованием\n[@mouseover]\n\n\n" ..
              "Пример:\n\n" ..
              "#showtooltip Быстрое исцеление\n" ..
              "/cast [@mouseover] Быстрое исцеление\n",
        [6] = "Да\n\n\n"..
              "С заголовками:\n" ..
              "1: Скины > Заголовки, включите Показывать заголовки.\n" ..
              "2: Скины > Панели, назначьте количество групп на колонку.\n\n" ..
              "Без Заголовков:\n" ..
              "1: Скины > Панели, включите Количество групп в колонке.\n" ..
              "2: Скины > Панели, назначьте количество групп на колонку.",
        [7] = "Да.\n\n"..
              "1: Скины > Исцеление, установите Уровень Тревоги на 0.\n" ..
              "2: Скины > Угроза, выключите Следить за Угрозой.\n" ..
              "3: Скины > Окна > Цвета панелей, установите Прозрачность неактивных в 0.\n" ..
              "4: Скины > Окна > Цвета панелей, установите прозрачность Цвета фона в 0.\n" ..
              "5: Скины > Окна > Текст панелей, нажмите на панель Неактивный\n" ..
              "и установите прозрачность цвета Неактивных в 0.\n" ..
              "6: Скины > Окна, нажмите на панель Фон.\n" ..
              "и установите прозрачность в 0.\n" ..
              "7: Во вкладке Рассеивания, Включите Следить за наложением дебаффов.",
        [8] = "Да.\n\n"..
              "1: Скины > Окна > Цвета панелей, установите Цвет входящего исцеления\nв Не показывать.\n" ..
              "2: Скины > Окна > Текст панелей, установите Здоровье на панели\n" ..
              "в Нет Входящие исцеления",
        [9] = "Это присутствует с начала патча 3.2, и затрагивает\n" ..
              "игроков со странными символами в имени.\n\n" ..
              "Если у вас Vista или Win7, попробуйте следущее:\n"..
              "измение системный язык на Английский\n(для програм, не использующих юникод)\n" ..
              "в Панели Управления > Язык и Региональные стандарты >\nАдминистративные",
        [10] = "Во вкладке Заклинания включите Панели всегда активны\n\n" ..
               "Некоторые так же захотят выставить уровень тревоги в 100\n" ..
               "Это может быть сделано во вкладке Скины > Исцеление",
        [11] = "Отключить для персонажа:\n\n" ..
               "1: Откройте вкладку Общее\n" ..
               "2: Включите Отключить HealBot\n\n\n" ..
               "Отключить в соло: \n\n" ..
               "1: Откройте вкладку Общее\n" ..
               "2: Правее и ниже опции Отключить HealBot,\nвыберите только в соло\n" ..
               "3: Включите Отключить HealBot",
        [12] = "Измените насройки якоря полос во вкладке Скины > Окна\n\n" ..
               "Справа Сверху: полосы будут расти Вниз и Налево\n" ..
               "Слева Сверху: полосы будут расти Вниз и Направо\n" ..
               "Справа Снизу: полосы будут расти Вверх и Налево\n" ..
               "Слева Снизу: полосы будут расти Вверх и Направо",
        [13] = "Личный список целей позволяет вам создать список целей, которые\n" ..
               "вы хотите группировать отдельно от остальных, подобно\nгруппе Главных Танков\n\n" ..
               "Следующие решения доступны для добавления/удаления\n" ..
               "людей в группе Личный Список Целей\n\n" ..
               "- Shift+Ctrl+Alt+ПКМ на панели\n" ..
               '- Используйте Меню HealBot (настройка "hbmenu" во вкладке Заклинания)\n' ..
               "- Используйте колесико мыши, настроенное во вкладке Колесико мыши",
        [14] = "Личные танки могут быть добавлены в список Главных танков,\n" ..
               "Главные танки видны только в вашем HealBot\n" ..
               "и не влияют на аддоны других игроков\n\n" ..
               "Следующие решения доступны для добавления/удаления\n" ..
               "людей в списке Танков\n\n" ..
               '- Используйте Меню HealBot (настройка "hbmenu" во вкладке Заклинания)\n' ..
               "- Используйте колёсико мыши, настроенное во вкладке Колёсико мыши",
        [15] = "Да\n\n"..
               "1: Скины > Исцеление, включите Фокус\n" ..
               "2: установите фокус на NPC (или на игроке вне вашей группы/рейда)\n" ..
               "Healbot создаст панель в списке Ваших целей\n\n" ..
               "Примечание: Если в бою вы переходите из одной зоны в другую\n" ..
               "фокус на NPC придётся устанавливать заново.\n" ..
               "Во вкладке Скины > Исцеление включите Фокус: всегда показывать\n" ..
               "Это позволит вам устанавливать фокус также во время боя.\n\n" ..
               "Примечание: В меню HealBot присутствует опция\n'Установть Фокус HealBot'\n" ..
               "Она позволит вам легко устанавливать фокус на NPC и\n" ..
               "служит напоминанием для установки фокуса.\n\n" ..
               "Введите 'hbmenu' Во вкладке Заклинания для использования меню\n" ..
               "HealBot или используйте Колесико мыши дял установки меню HealBot",
        [16] = "1: Скины > Окна > Цвета панелей, настройте Прозрачность неактивных\n" ..
               "2: Скины > Окна > Текст панелей, настройте Прозрачность текста\n" ..
               "Неактивных, для этого нажмите на панель с надписью Неактивный.\n\n" ..
               "Некоторые также захотят установить Уровень Тревоги в 100.\n" ..
               "Это можно сделать Во вкладке Скины > Исцеление.",
        [17] = "На самом деле, Healbot применяет в точности то, что настроено.\n\n" .. HEALBOT_ABOUT_FAQ_SPELLS_ANSWER01,
        [18] = HEALBOT_ABOUT_FAQ_SPELLS_ANSWER01
    }

    HEALBOT_OPTIONS_SKINAUTHOR              = "Автор Скина:";
    HEALBOT_OPTIONS_MORESKINSURL            = "Дополнительные скины доступны во вкладке Импорт / Экспорт > Скины"
    HEALBOT_OPTIONS_AVOIDBLUECURSOR         = "Избегать\nсинего курсора";
    HEALBOT_PLAYER_OF_REALM                 = "-";

    HEALBOT_OPTIONS_LANG                    = "Язык";

    HEALBOT_OPTIONS_LANG_ZHCN               = "Chinese (zhCN)"
    HEALBOT_OPTIONS_LANG_ENUK               = "English (enUK)"
    HEALBOT_OPTIONS_LANG_ENUS               = "English (enUS)"
    HEALBOT_OPTIONS_LANG_FRFR               = "French (frFR)"
    HEALBOT_OPTIONS_LANG_DEDE               = "German (deDE)"
    HEALBOT_OPTIONS_LANG_GRGR               = "Greek (grGR)"
    HEALBOT_OPTIONS_LANG_HUHU               = "Hungarian (huHU)"
    HEALBOT_OPTIONS_LANG_KRKR               = "Korean (krKR)"
    HEALBOT_OPTIONS_LANG_ITIT               = "Italian (itIT)"
    HEALBOT_OPTIONS_LANG_PTBR               = "Portuguese (ptBR)"
    HEALBOT_OPTIONS_LANG_RURU               = "Russian (ruRU)"
    HEALBOT_OPTIONS_LANG_ESES               = "Spanish (esES)"
    HEALBOT_OPTIONS_LANG_TWTW               = "Taiwanese (twTW)"
    HEALBOT_OPTIONS_LANG_ESMX               = "Mexican (esMX)"

    HEALBOT_OPTIONS_LANG_ADDON_FAIL1        = "Не удалось загрузить аддон для локализации";
    HEALBOT_OPTIONS_LANG_ADDON_FAIL2        = "Причина ошибки:";
    HEALBOT_OPTIONS_LANG_ADDON_FAIL3        = "Учтите, что в текущей версии это единственное предупреждение для";

    HEALBOT_OPTIONS_IMPORT_FAIL1            = "Не удалось импортировать"
    HEALBOT_OPTIONS_IMPORT_FAIL2            = "Причина ошибки:"

    HEALBOT_OPTIONS_ADDON_FAIL              = "Не удалось загрузить аддон HealBot";
    HEALBOT_OPTIONS_IN_A_GROUP              = "Только в составе Группы или Рейда";
    HEALBOT_OPTIONS_PALADIN_BLESSINGS       = "Видеть все мои благословения как одинаковые"
    HEALBOT_OPTIONS_CONTENT_SKINS_GENERAL   = "    " .. HEALBOT_OPTIONS_TAB_GENERAL;
    HEALBOT_OPTIONS_CONTENT_SKINS_HEALING   = "    " .. HEALBOT_OPTIONS_TAB_HEALING;
    HEALBOT_OPTIONS_CONTENT_SKINS_HEADERS   = "        " .. HEALBOT_OPTIONS_TAB_HEADERS;
    HEALBOT_OPTIONS_CONTENT_SKINS_BARS      = "        " .. HEALBOT_OPTIONS_TAB_BARS;
    HEALBOT_OPTIONS_CONTENT_SKINS_ICONS     = "        " .. HEALBOT_OPTIONS_TAB_ICONS;
    HEALBOT_OPTIONS_CONTENT_SKINS_AGGRO     = "    " .. HEALBOT_OPTIONS_TAB_AGGRO;
    HEALBOT_OPTIONS_CONTENT_SKINS_PROT      = "    " .. HEALBOT_OPTIONS_TAB_PROTECTION;
    HEALBOT_OPTIONS_CONTENT_SKINS_CHAT      = "    " .. HEALBOT_OPTIONS_TAB_CHAT;
    HEALBOT_OPTIONS_CONTENT_SKINS_TEXT      = "        " .. HEALBOT_OPTIONS_TAB_TEXT;
    HEALBOT_OPTIONS_CONTENT_SKINS_ICONTEXT  = "        " .. HEALBOT_OPTIONS_TAB_ICONTEXT;

    HEALBOT_OPTIONS_CONTENT_CURE_DEBUFF     = "    " .. HEALBOT_SKIN_DEBTEXT;
    HEALBOT_OPTIONS_CONTENT_CURE_CUSTOM     = "    " .. HEALBOT_CLASSES_CUSTOM;
    HEALBOT_OPTIONS_CONTENT_CURE_WARNING    = "    " .. HEALBOT_OPTIONS_TAB_WARNING;

    HEALBOT_OPTIONS_CONTENT_BUFFS_GENERAL   = "    " .. HEALBOT_OPTIONS_TAB_GENERAL
    HEALBOT_OPTIONS_CONTENT_BUFFS_HOTS      = "    " .. HEALBOT_CLASSES_CUSTOM

    HEALBOT_OPTIONS_CONTENT_INOUT_SKINS     = "    " .. HEALBOT_OPTIONS_TAB_SKIN
    HEALBOT_OPTIONS_CONTENT_INOUT_CDEBUFF   = "    " .. HEALBOT_OPTIONS_TAB_CUSTOM_DEBUFFS
    HEALBOT_OPTIONS_CONTENT_INOUT_BUFF      = "    " .. HEALBOT_OPTIONS_TAB_CUSTOM_BUFFS
    HEALBOT_OPTIONS_CONTENT_INOUT_SPELLS    = "    " .. HEALBOT_OPTIONS_TAB_SPELLS
    HEALBOT_OPTIONS_CONTENT_INOUT_PRESETCOL = "    " .. HEALBOT_OPTIONS_PRESET.." Цвета"
    HEALBOT_OPTIONS_CONTENT_SKINS_FRAMES    = "    " .. HEALBOT_OPTIONS_TAB_FRAMES

    HEALBOT_SKIN_ABSORBCOL_TEXT             = "Эффекты поглощения";
    HEALBOT_OPTIONS_BARALPHAABSORB          = "Прозрачность эффектов поглощения";
    HEALBOT_OPTIONS_OUTLINE                 = "Границы";
    HEALBOT_OPTIONS_FRAME                   = "Окно";
    HEALBOT_OPTIONS_FRAMESOPTTEXT           = "Настройки окон";
    HEALBOT_OPTIONS_SETTOOLTIP_POSITION     = "Установить позицию подсказки";
    HEALBOT_OPTIONS_FRAME_TITLE             = "Заголовок окна";
    HEALBOT_OPTIONS_FRAME_TITLE_SHOW        = "Показывать заголовок";
    HEALBOT_OPTIONS_GROW_DIRECTION          = "Направление расширения";
    HEALBOT_OPTIONS_BARSORIENTATION         = "Ориентация панелей";
    HEALBOT_OPTIONS_GROW_HORIZONTAL         = "Горизонтально";
    HEALBOT_OPTIONS_GROW_VERTICAL           = "Вертикально";
    HEALBOT_OPTIONS_FONT_OFFSET             = "Смещение шрифта";
    HEALBOT_OPTIONS_SET_FRAME_HEALGROUPS    = "Назначить группы исцеления";
    HEALBOT_OPTION_EXCLUDEMOUNT_ON          = "Маунт исключён";
    HEALBOT_OPTION_EXCLUDEMOUNT_OFF         = "Маунт больше не исключён";
    HEALBOT_CMD_TOGGLEEXCLUDEMOUNT          = "Вкл/Выкл исключение маунта";
    HEALBOT_OPTIONS_HIDEMINIBOSSFRAMES      = "Скрыть панели мини-боссов";
    HEALBOT_OPTIONS_HIDERAIDFRAMES          = "Скрыть рейдовые панели";
    HEALBOT_OPTIONS_FRAME_ALIAS             = "Профиль";
    HEALBOT_OPTIONS_CONTENT_SKINS_HEALGROUP = "        " .. "Группы исцеления";
    HEALBOT_OPTIONS_CONTENT_SKINS_BARCOLOUR = "        " .. "Цвета панелей";
    HEALBOT_OPTIONS_SET_ALL_FRAMES          = "Применить текущие настройки ко всем Окнам";
    HEALBOT_WORDS_PROFILE                   = "Профиль";
    HEALBOT_SHARE_SCREENSHOT                = "Скриншот сохранён";
    HEALBOT_SHARE_INSTRUCTION               = "Посетите сайт для получения инструкций о том, как поделиться "..HEALBOT_ABOUT_URL;
    HEALBOT_INOUT_STATUS_SKINSINIT          = "Скинами можно поделиться в "..HEALBOT_ABOUT_URL;
    HEALBOT_INOUT_STATUS_CDEBUFFINIT        = "Пользовательскими дебаффами можно поделиться в "..HEALBOT_ABOUT_URL;
    HEALBOT_INOUT_STATUS_BUFFINIT           = "Пользовательскими баффами можно поделиться в "..HEALBOT_ABOUT_URL;
    HEALBOT_INOUT_STATUS_SPELLINIT          = "Заклинаниями можно поделиться в "..HEALBOT_ABOUT_URL;
    HEALBOT_INOUT_STATUS_PRESETCOLINIT      = HEALBOT_OPTIONS_PRESET.." Цветами можно поделиться в "..HEALBOT_ABOUT_URL;
    HEALBOT_ENEMY_USE_FRAME                 = "Использовать окно";
    HEALBOT_ENEMY_INCLUDE_SELF              = "Включая мою цель";
    HEALBOT_ENEMY_INCLUDE_TANKS             = "Включая цели танков";
    HEALBOT_OPTIONS_ENEMY_OPT               = "Видимость врага";
    HEALBOT_OPTIONS_SHARE_OPT               = "Настройки общего доступа";
    HEALBOT_OPTIONS_CONTENT_SKINS_SHARE     = "    " .. "Поделиться";
    HEALBOT_OPTIONS_CONTENT_SKINS_ENEMY     = "    " .. "Враг";
    HEALBOT_ENEMY_NO_TARGET                 = "Нет цели";
    HEALBOT_OPTIONS_ENEMYBARS               = "Панели врагов в любом состоянии";
    HEALBOT_OPTIONS_HARMFUL_SPELLS          = "Вредоносные заклинания";
    HEALBOT_ENEMY_INCLUDE_MYTARGETS         = "Включая цели Личного Списка Целей";
    HEALBOT_ENEMY_NUMBER_BOSSES             = "Количество Боссов";
    HEALBOT_ENEMY_HIDE_OUTOFCOMBAT          = "Скрыть панели вне боя";
    HEALBOT_ENEMY_SHOW_TARGET               = "Показать цель врага"
    HEALBOT_ENEMY_DOUBLE_WIDTH              = "Двойная общая ширина панели"
    HEALBOT_ENEMY_TARGET_SIZE               = "Размер цели врага"
    HEALBOT_ENEMY_EXISTS_SHOW               = "Только при входе в бой".."\n".."показывать при выходе";
    HEALBOT_ENEMY_EXISTS_SHOW_PTARGETS      = "Панели целей игроков"
    HEALBOT_ENEMY_EXISTS_SHOW_BOSSES        = "Панели боссов";
    HEALBOT_OPTIONS_TARGET_ONLY_FRIEND      = "Цель: Показывать только дружественную";
    HEALBOT_OPTIONS_EXCLUDE_RAID            = "Исключая Себя, Группу и Рейд"
    HEALBOT_OPTIONS_PROFILE                 = "Профиль для".."\n".."Закл/Баффов/Рассеиваний";
    HEALBOT_OPTIONS_PROFILE_CHARACTER       = "Персонаж";
    HEALBOT_OPTIONS_PROFILE_CLASS           = "Класс";
    HEALBOT_OPTIONS_INCOMBATALERTLEVEL      = "Уровень Тревоги - В Бою";
    HEALBOT_OPTIONS_OUTCOMBATALERTLEVEL     = "Уровень Тревоги - Вне Боя";
    HEALBOT_OPTIONS_SORTOORLAST             = "Сортировать вне досягаемости"
    HEALBOT_OPTION_NUMENEMYS                = "Количество врагов";
    HEALBOT_WORD_AUTO                       = "Авто";
    HEALBOT_OPTIONS_ENABLEAUTOCOMBAT        = "Включить HealBot autoCombat";
    HEALBOT_WORDS_REMOVETEMPCUSTOMNAME      = "Удалить временное пользовательское имя";
    HEALBOT_WORDS_REMOVEPERMCUSTOMNAME      = "Удалить постоянное пользовательское имя";
    HEALBOT_WORDS_ADDTEMPCUSTOMNAME         = "Добавить временное пользовательское имя";
    HEALBOT_WORDS_ADDPERMCUSTOMNAME         = "Добавить постоянное пользовательское имя";
    HEALBOT_OPTIONS_ENABLELIBUTF8           = "Включить библиотеку UTF8";
    HEALBOT_OPTIONS_SHOWDIRECTION           = "Показывать направление вне досягаемости";
    HEALBOT_OPTIONS_SHOWDIRECTIONMOUSE      = "Только при наведении курсора";
    HEALBOT_LDB_LEFT_TOOLTIP                = "|cffffff00 ЛКМ:|r Вкл/Выкл панель опций HealBot";
    HEALBOT_LDB_SHIFTLEFT_TOOLTIP           = "|cffffff00 Shift-ЛКМ:|r Переключить скин HealBot";
    HEALBOT_LDB_RIGHT_TOOLTIP               = "|cffffff00 ПКМ:|r Сбросить HealBot";
    HEALBOT_LDB_SHIFTRIGHT_TOOLTIP          = "|cffffff00 Shift-ПКМ:|r Вкл/Выкл HealBot";
    HEALBOT_WORD_PETBATTLE                  = "Битвы питомцев"
    HEALBOT_ENEMY_INCLUDE_ARENA             = "Включая оппонентов арены"
    HEALBOT_ENEMY_INCLUDE_ARENAPETS         = "Включая питомцев"
    HEALBOT_ENEMY_EXISTS_SHOW_ARENA         = "Панели оппонентов арены"
    HEALBOT_CMD_TOGGLECUSTOMCURECASTBY      = "Вкл/Выкл свои рассеивания - по умолчанию применяется"
    HEALBOT_OPTIONS_ENTERINGCOMBAT          = "При вступлении в бой"
    HEALBOT_OPTIONS_OUTOFCOMBAT             = "При выходе из боя"
    HEALBOT_OPTIONS_TEXTCOL_DEBUFF          = "Исп. пользовательский при дебаффе"
    HEALBOT_OPTIONS_ALWAYSHIDE              = "Всегда скрывать"
    HEALBOT_OPTIONS_NOCHANGE                = "Не менять"
    HEALBOT_OPTIONS_ALWAYSSHOW              = "Всегда отображать"
    HEALBOT_OPTIONS_PAGE                    = "Страница"
    HEALBOT_OPTIONS_PREV                    = "<<"
    HEALBOT_OPTIONS_NEXT                    = ">>"
    HEALBOT_OPTIONS_PRESET_COLOUR           = HEALBOT_OPTIONS_PRESET.." Цвет"
    
    HEALBOT_WORD_SUPPORTERS                 = "Помощники"
    HEALBOT_SUPPORTERS_PEOPLE = {  [01] = "Mythagos - Draenor",  -- Mythago
                                   [02] = "SUNET",
                                   [03] = "Daskills",
                                   [04] = "killerdavy",
                                   [05] = "zathrain",
                                   [06] = "Droodibaby",
                                   [07] = "Redemption",
                                   [08] = "Jaiseck",
                                   [09] = "xtacie",
                                   [10] = "bkwildlifecntrl",
                                   [11] = "mlharg",
                                   [12] = "Yuriusha",
                                   [13] = "spicy_squid",
                                   [14] = "Ameralanna_675",
                                   [15] = "nydiah",
                                   [16] = "Doomsdaze",
                                   [17] = "Solution",
                                   [18] = "selena817",
                                   [19] = "SirArion",
                                   [20] = "Xarava",
                                   [21] = "jchap2k",
                                   [22] = "Vayah",
                                   [23] = "Madaleine",
                                   [24] = "ADDYDARI",
                                   [25] = "plastisch",
                                   [26] = "MMOnster",
                                }
                               
end
function HealBot_Lang_InitVars()
    HEALBOT_CUSTOM_DEBUFF_CATS = {
         -- Defaults
        [HEALBOT_CUSTOM_CAT_CUSTOM_AUTOMATIC]  = 1,

        --Class Profession & Harmful Debuffs
        --[HEALBOT_DEBUFF_SAVING_GRACE]      = 11, --Priest
        --[HEALBOT_DARK_BARGAIN]             = 3, --Warlock
        [HEALBOT_SHROUD_OF_PURGATORY]      = 11, --Death Knight
        [HEALBOT_DEBUFF_ROCKET_FUEL_LEAK]  = 10, --Engineering
        
        [HEALBOT_DEBUFF_FORBEARANCE]              = 4,
        [HEALBOT_DEBUFF_WEAKENED_SOUL]            = 13,
        [HEALBOT_SHADOW_TOUCHED]                  = 11,

    --[[
	A-B 2
	C-D 3
	E-F 4
	G-H 5
	I-J 6
	K-L 7
	M-N 8
	O-P 9
	Q-R 10
	S-T 11
	U-V 12
	W-X 13
	Y-Z 14
	]]

	}
end
