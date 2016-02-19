-- Russian maintained by Justice

-------------
-- RUSSIAN --
-------------
--
--
--
--
--
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
    HEALBOT_MONK                            = "Монах";

    HEALBOT_DISEASE                         = "Болезнь";
    HEALBOT_MAGIC                           = "Магия";
    HEALBOT_CURSE                           = "Проклятие";
    HEALBOT_POISON                          = "Яд";

    HB_TOOLTIP_OFFLINE                      = PLAYER_OFFLINE;
    HB_OFFLINE                              = PLAYER_OFFLINE; -- has gone offline msg
    HB_ONLINE                               = GUILD_ONLINE_LABEL; -- has come online msg

    HEALBOT_HEALBOT                         = "HealBot";
    HEALBOT_ADDON                           = HEALBOT_HEALBOT .. " " .. HEALBOT_VERSION;
    HEALBOT_LOADED                          = " загружен.";

    HEALBOT_ACTION_OPTIONS                  = "Настройки";

    HEALBOT_OPTIONS_TITLE                   = HEALBOT_ADDON
    HEALBOT_OPTIONS_DEFAULTS                = "По умолчанию";
    HEALBOT_OPTIONS_CLOSE                   = "Закрыть";
    HEALBOT_OPTIONS_HARDRESET               = "Перезагрузить UI";
    HEALBOT_OPTIONS_SOFTRESET               = "Сбросить HB";
    HEALBOT_OPTIONS_TAB_GENERAL             = "Общее";
    HEALBOT_OPTIONS_TAB_SPELLS              = "Заклинания";
    HEALBOT_OPTIONS_TAB_HEALING             = "Исцеление";
    HEALBOT_OPTIONS_TAB_CDC                 = "Рассеивание";
    HEALBOT_OPTIONS_TAB_SKIN                = "Стили";
    HEALBOT_OPTIONS_TAB_TIPS                = "Подсказки";
    HEALBOT_OPTIONS_TAB_BUFFS               = "Баффы";

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
    HEALBOT_OPTIONS_SKINTEXT                = "Стиль";
    HEALBOT_SKINS_STD                       = "Стандарт";
    HEALBOT_OPTIONS_SKINTEXTURE             = "Текстура";
    HEALBOT_OPTIONS_SKINHEIGHT              = "Высота";
    HEALBOT_OPTIONS_SKINWIDTH               = "Ширина";
    HEALBOT_OPTIONS_SKINNUMCOLS             = "Колонок";
    HEALBOT_OPTIONS_SKINNUMHCOLS            = "Групп в колонке";
    HEALBOT_OPTIONS_SKINBRSPACE             = "Промежуток строк";
    HEALBOT_OPTIONS_SKINBCSPACE             = "Промежуток рядов";
    HEALBOT_OPTIONS_EXTRASORT               = "Сортировать панели по";
    HEALBOT_SORTBY_NAME                     = "Имя";
    HEALBOT_SORTBY_CLASS                    = "Класс";
    HEALBOT_SORTBY_GROUP                    = "Группа";
    HEALBOT_SORTBY_MAXHEALTH                = "Максимум здоровья";
    HEALBOT_OPTIONS_NEWDEBUFFTEXT           = "Новый дебафф";
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
    HEALBOT_OPTIONS_BARALPHADIS             = "Прозрачностьть неактивных";
    HEALBOT_OPTIONS_SHOWHEADERS             = "Показывать заголовки";

    HEALBOT_OPTIONS_ITEMS                   = "Предметы";

    HEALBOT_OPTIONS_COMBOCLASS              = "Клавиши для";
    HEALBOT_OPTIONS_CLICK                   = "Клик";
    HEALBOT_OPTIONS_SHIFT                   = "Shift";
    HEALBOT_OPTIONS_CTRL                    = "Ctrl";
    HEALBOT_OPTIONS_ENABLEHEALTHY           = "Панели всегда активны";

    HEALBOT_OPTIONS_CASTNOTIFY1             = "Без оповещений";
    HEALBOT_OPTIONS_CASTNOTIFY2             = "Оповещать себя";
    HEALBOT_OPTIONS_CASTNOTIFY3             = "Оповещать цель";
    HEALBOT_OPTIONS_CASTNOTIFY4             = "Оповещать группу";
    HEALBOT_OPTIONS_CASTNOTIFY5             = "Оповещать рейд";
    HEALBOT_OPTIONS_CASTNOTIFY6             = "Оповещать в канал";
    HEALBOT_OPTIONS_CASTNOTIFYRESONLY       = "Оповещать только о воскрешении";

    HEALBOT_OPTIONS_CDCBARS                 = "Цвет полос";
    HEALBOT_OPTIONS_CDCSHOWHBARS            = "На полосе здоровья";
    HEALBOT_OPTIONS_CDCSHOWABARS            = "На полосе угрозы";
    HEALBOT_OPTIONS_CDCWARNINGS             = "Предупреждения о дебафах";
    HEALBOT_OPTIONS_SHOWDEBUFFICON          = "Показывать дебафф";
    HEALBOT_OPTIONS_SHOWDEBUFFWARNING       = "Отображать предупреждение при дебаффе";
    HEALBOT_OPTIONS_SOUNDDEBUFFWARNING      = "Звук при дебаффе";
    HEALBOT_OPTIONS_SOUND                   = "Звук";

    HEALBOT_OPTIONS_HEAL_BUTTONS            = "Панели исцелений";
    HEALBOT_OPTIONS_SELFHEALS               = "Игрок";
    HEALBOT_OPTIONS_PETHEALS                = "Питомцы";
    HEALBOT_OPTIONS_GROUPHEALS              = "Группа";
    HEALBOT_OPTIONS_TANKHEALS               = "Главные танки";
    HEALBOT_OPTIONS_PRIVATETANKS            = "Личные танки";
    HEALBOT_OPTIONS_TARGETHEALS             = "Цели";
    HEALBOT_OPTIONS_EMERGENCYHEALS          = "Рейд";
    HEALBOT_OPTIONS_EMERGFILTER             = "Рейдовые полосы для";
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

    HEALBOT_OPTIONS_SHOWTOOLTIP             = "Показывать подсказки";
    HEALBOT_OPTIONS_SHOWDETTOOLTIP          = "Расширенная информация о заклинании";
    HEALBOT_OPTIONS_SHOWCDTOOLTIP           = "Восстановление заклинания";
    HEALBOT_OPTIONS_SHOWUNITTOOLTIP         = "Информация о цели";
    HEALBOT_OPTIONS_SHOWRECTOOLTIP          = "Показывать рекомендации по HoT-ам";
    HEALBOT_TOOLTIP_POSDEFAULT              = "По умолчанию";
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
    HEALBOT_WORDS_SEC                       = "сек";
    HEALBOT_WORDS_CAST                      = "Применение";
    HEALBOT_WORDS_UNKNOWN                   = "Неизвестно";
    HEALBOT_WORDS_YES                       = "Да";
    HEALBOT_WORDS_NO                        = "Нет";
    HEALBOT_WORDS_THIN                      = "Тонкий";
    HEALBOT_WORDS_THICK                     = "Толстый";

    HEALBOT_WORDS_NONE                      = "Нет";
    HEALBOT_OPTIONS_ALT                     = "Alt";
    HEALBOT_DISABLED_TARGET                 = "Цель";
    HEALBOT_OPTIONS_SHOWCLASSONBAR          = "Класс на панели";
    HEALBOT_OPTIONS_SHOWHEALTHONBAR         = "Здоровье на панели";
    HEALBOT_OPTIONS_BARHEALTHINCHEALS       = "Включая входящее исцеление";
    HEALBOT_OPTIONS_BARHEALTHSEPHEALS       = "Разделять входящие исцеления";
    HEALBOT_OPTIONS_BARHEALTHINCALL         = "Включать входящее лечение и поглощение"
    HEALBOT_OPTIONS_BARHEALTHSEPALL         = "Разделять входящее лечение и поглощение"
    HEALBOT_OPTIONS_BARHEALTH1              = "разница";
    HEALBOT_OPTIONS_BARHEALTH2              = "процент";
    HEALBOT_OPTIONS_TIPTEXT                 = "Информация в подсказке";
    HEALBOT_OPTIONS_POSTOOLTIP              = "Подсказка";
    HEALBOT_OPTIONS_SHOWNAMEONBAR           = "Имена на панели";
    HEALBOT_OPTIONS_BARTEXTCLASSCOLOUR1     = "Текст по цвету класса";
    HEALBOT_OPTIONS_EMERGFILTERGROUPS       = "Включая рейд-группы";

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

    HEALBOT_OPTIONS_HEADEROPTTEXT           = "Настройки заголовков";
    HEALBOT_OPTIONS_ICONOPTTEXT             = "Настройки иконок";
    HEALBOT_SKIN_HEADERBARCOL               = "Цвет панелей";
    HEALBOT_SKIN_HEADERTEXTCOL              = "Цвет текста";
    HEALBOT_OPTIONS_BUFFSTEXT1              = "Заклинание";
    HEALBOT_OPTIONS_BUFFSTEXT2              = "Проверять";
    HEALBOT_OPTIONS_BUFFSTEXT3              = "Цвета панелей";
    HEALBOT_OPTIONS_BUFF                    = "Бафф";
    HEALBOT_OPTIONS_BUFFSELF                = "на себя";
    HEALBOT_OPTIONS_BUFFPARTY               = "на группу";
    HEALBOT_OPTIONS_BUFFRAID                = "на рейд";
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
    HEALBOT_OPTIONS_MONITORDEBUFFS          = "Следить за наложением дебафов";
    HEALBOT_OPTIONS_DEBUFFTEXT1             = "Заклинание снимающее дебаффы";

    HEALBOT_OPTIONS_IGNOREDEBUFF            = "Игнорировать:";
    HEALBOT_OPTIONS_IGNOREDEBUFFCLASS       = "По классам";
    HEALBOT_OPTIONS_IGNOREDEBUFFMOVEMENT    = "Замедления";
    HEALBOT_OPTIONS_IGNOREDEBUFFDURATION    = "Короткого действия";
    HEALBOT_OPTIONS_IGNOREDEBUFFNOHARM      = "Не вредоносные";
    HEALBOT_OPTIONS_IGNOREDEBUFFCOOLDOWN    = "Когда кд на рассеивание > 1.5 сек (ГКД)";
    HEALBOT_OPTIONS_IGNOREDEBUFFFRIEND      = "Когда источник известен как друг";

    HEALBOT_OPTIONS_RANGECHECKFREQ          = "Частота проверки дальности, аур и угрозы";

    HEALBOT_OPTIONS_HIDEPARTYFRAMES         = "Скрыть окна группы";
    HEALBOT_OPTIONS_HIDEPLAYERTARGET        = "Включая игрока и цель";
    HEALBOT_OPTIONS_DISABLEHEALBOT          = "Отключить HealBot";

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

    HEALBOT_ZONE_AB                         = GetMapNameByID(461) or "Низина Арати";
    HEALBOT_ZONE_AV                         = GetMapNameByID(401) or "Альтеракская долина";
    HEALBOT_ZONE_ES                         = GetMapNameByID(482) or "Око Бури";
    HEALBOT_ZONE_IC                         = GetMapNameByID(540) or "Остров Завоеваний";
    HEALBOT_ZONE_SA                         = GetMapNameByID(512) or "Берег Древних";

    HEALBOT_OPTION_AGGROTRACK               = "Следить за угрозой";
    HEALBOT_OPTION_AGGROBAR                 = "Панель";
    HEALBOT_OPTION_AGGROTXT                 = ">> Текст <<";
    HEALBOT_OPTION_AGGROIND                 = "Индикатор";
    HEALBOT_OPTION_BARUPDFREQ               = "Частота обновления";
    HEALBOT_OPTION_USEFLUIDBARS             = "Использовать плавные полосы";
    HEALBOT_OPTION_CPUPROFILE               = "Использовать CPU-профайлер (Инфо об использовании CPU)";
    HEALBOT_OPTIONS_RELOADUIMSG             = "Для того, чтобы настройки вступили в силу, необходима перезагрузка интерфейса. Готовы?";

    HEALBOT_BUFF_PVP                        = "PvP";
    HEALBOT_BUFF_PVE                        = "PvE";
    HEALBOT_OPTIONS_ANCHOR                  = "Якорь окна";
    HEALBOT_OPTIONS_BARSANCHOR              = "Якорь полос";
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

    HEALBOT_OPTIONS_TTALPHA                 = "Прозрачность";
    HEALBOT_TOOLTIP_TARGETBAR               = "Панель цели";
    HEALBOT_OPTIONS_MYTARGET                = "Мои цели";

    HEALBOT_DISCONNECTED_TEXT               = "<ОФФ>";
    HEALBOT_OPTIONS_SHOWUNITBUFFTIME        = "Показывать мои баффы";
    HEALBOT_OPTIONS_TOOLTIPUPDATE           = "Постоянно обновлять";
    HEALBOT_OPTIONS_BUFFSTEXTTIMER          = "Показать бафф до того, как он кончится";
    HEALBOT_OPTIONS_SHORTBUFFTIMER          = "Короткие баффы";
    HEALBOT_OPTIONS_LONGBUFFTIMER           = "Длинные баффы";

    HEALBOT_OPTIONS_NOTIFY_MSG              = "Cообщение";
    HEALBOT_WORDS_YOU                       = "вы";
    HEALBOT_NOTIFYOTHERMSG                  = "Применяется #s на #n";

    HEALBOT_OPTIONS_HOTPOSITION             = "Позиция иконки";
    HEALBOT_OPTIONS_HOTSHOWTEXT             = "Текст иконки";
    HEALBOT_OPTIONS_HOTTEXTCOUNT            = "Стаки";
    HEALBOT_OPTIONS_HOTTEXTDURATION         = "Длительность";
    HEALBOT_OPTIONS_ICONSCALE               = "Масштаб иконки";
    HEALBOT_OPTIONS_ICONTEXTSCALE           = "Масштаб текста иконки";

    HEALBOT_OPTIONS_AGGROBARSIZE            = "Размер полосы угрозы";
    HEALBOT_OPTIONS_DOUBLETEXTLINES         = "Текст в 2 строки";
    HEALBOT_OPTIONS_TEXTALIGNMENT           = "Выравнивание текста";
    HEALBOT_VEHICLE                         = "Транспорт";
    HEALBOT_WORDS_ERROR                     = "Ошибка";
    HEALBOT_SPELL_NOT_FOUND                 = "Заклинание не найдено";
    HEALBOT_OPTIONS_DISABLETOOLTIPINCOMBAT  = "Скрыть подсказки в бою";
    HEALBOT_OPTIONS_ENABLELIBQH             = "Включить fastHealth";

    HEALBOT_OPTIONS_BUFFNAMED               = "введите имя игрока для наблюдения:\n\n";
    HEALBOT_WORD_ALWAYS                     = "Всегда";
    HEALBOT_WORD_SOLO                       = "Соло";
    HEALBOT_WORD_NEVER                      = "Никогда";
    HEALBOT_SHOW_CLASS_AS_ICON              = "как иконку";
    HEALBOT_SHOW_CLASS_AS_TEXT              = "как текст";
    HEALBOT_SHOW_ROLE                       = "показывать роль";

    HEALBOT_SHOW_INCHEALS                   = "Показывать входящее исцеление";

    HEALBOT_HELP = {
        [1] = "[HealBot] /hb h -- показать справку",
        [2] = "[HealBot] /hb o -- переключение настроек",
        [3] = "[HealBot] /hb t -- Вкл/Выкл HealBot",
        [4] = "[HealBot] /hb bt -- Вкл/Выкл отслеживание баффов",
        [5] = "[HealBot] /hb dt -- Вкл/Выкл отслеживание дебаффов",
        [6] = "[HealBot] /hb skin <skinName> -- сменить стиль",
        [7] = "[HealBot] /hb d -- сбросить настройки на стандартные",
        [8] = "[HealBot] /hb spt -- Self Pet toggle",
        [9] = "[HealBot] /hb flb -- Toggle frame lock bypass (frame always moves with Ctrl+Alt+Left click)",
        [10] = "[HealBot] /hb hs -- показать дополнительные слэш команды",
    }

    HEALBOT_HELP2 = {
        [1] = "[HealBot] /hb rtb -- Вкл/Выкл ограничение панели цели до ЛКМ=УмныйКаст и ПКМ=добавить/удалить мою цель",
        [2] = "[HealBot] /hb aggro 2 <n> -- Установить уровень угрозы 2 в процентах от угрозы <n>",
        [3] = "[HealBot] /hb aggro 3 <n> -- Установить уровень угрозы 3 в процентах от угрозы <n>",
        [4] = "[HealBot] /hb tr <Role> -- Установить высшый приоритет дял роли при дополнительной сортировке по ролям. Возможные роли: 'TANK', 'HEALER', 'DPS'",
        [5] = "[HealBot] /hb use10 -- Автоматически использовать инженерный слот 10",
        [6] = "[HealBot] /hb pcs <n> -- Установить размер индикатора зарядов Энергии Света в <n>, по умолчанию 7 ",
        [7] = "[HealBot] /hb hrfm -- Сменить метод скрытия рейдовых фреймов Blizzard, отключить совсем или спрятать",
        [8] = "[HealBot] /hb ws -- Переключить отображение иконки Ослабевшей Души вместо Слово Силы: Щит с минусом",
        [9] = "[HealBot] /hb rld <n> -- Время в секундах, в течение которого имена игроков остаются зелеными после воскрешения",
        [10] = "[HealBot] /hb shhp <n> -- Показывать бафф Гимн Надежды только когда мана меньше <n>",
        [11] = "[HealBot] - Также смотрите Команды в основной вкладке настроек",
    }

    HEALBOT_OPTION_HIGHLIGHTACTIVEBAR       = "Выделять активную полосу";
    HEALBOT_OPTION_HIGHLIGHTTARGETBAR       = "Выделять цель";
    HEALBOT_OPTIONS_TESTBARS                = "Тестовые полосы";
    HEALBOT_OPTION_NUMBARS                  = "Количество полос";
    HEALBOT_OPTION_NUMTANKS                 = "Количество танков";
    HEALBOT_OPTION_NUMMYTARGETS             = "Количество моих целей";
    HEALBOT_OPTION_NUMHEALERS               = "Количество целителей";
    HEALBOT_OPTION_NUMPETS                  = "Количество питомцев";
    HEALBOT_WORD_TEST                       = "Тест";
    HEALBOT_WORD_OFF                        = "Выкл";
    HEALBOT_WORD_ON                         = "Вкл";

    HEALBOT_OPTIONS_TAB_PROTECTION          = "Защита";
    HEALBOT_OPTIONS_TAB_CHAT                = "Чат";
    HEALBOT_OPTIONS_TAB_HEADERS             = "Заголовки";
    HEALBOT_OPTIONS_TAB_BARS                = "Панели";
    HEALBOT_OPTIONS_TAB_ICONS               = "Иконки";
    HEALBOT_OPTIONS_TAB_WARNING             = "Оповещене";
    HEALBOT_OPTIONS_SKINDEFAULTFOR          = "Стандартный стиль для";
    HEALBOT_OPTIONS_INCHEAL                 = "Входящее исцеление";
    HEALBOT_WORD_ARENA                      = "Арена";
    HEALBOT_WORD_BATTLEGROUND               = "Поле боя";
    HEALBOT_OPTIONS_TEXTOPTIONS             = "Настройки текста";
    HEALBOT_WORD_PARTY                      = "Группа";
    HEALBOT_OPTIONS_COMBOAUTOTARGET         = "Авто\nЦель";
    HEALBOT_OPTIONS_COMBOAUTOTRINKET        = "Авто Аксессуар";
    HEALBOT_OPTIONS_GROUPSPERCOLUMN         = "Количество групп в колонке";

    HEALBOT_OPTIONS_MAINSORT                = "Основная сортировка";
    HEALBOT_OPTIONS_SUBSORT                 = "Дополнительная сортировка";
    HEALBOT_OPTIONS_SUBSORTINC              = "Также сортировать:";

    HEALBOT_OPTIONS_BUTTONCASTMETHOD        = "Применить\nкогда";
    HEALBOT_OPTIONS_BUTTONCASTPRESSED       = "Нажата";
    HEALBOT_OPTIONS_BUTTONCASTRELEASED      = "Отпущена";

    HEALBOT_INFO_ADDONCPUUSAGE              = "= Использование CPU аддоном (в сек.) =";
    HEALBOT_INFO_ADDONCOMMUSAGE             = "= Использование траффика аддоном =";
    HEALBOT_WORD_HEALER                     = "Лекарь";
    HEALBOT_WORD_DAMAGER                    = "ДД";
    HEALBOT_WORD_TANK                       = "Танк";
    HEALBOT_WORD_LEADER                     = "Лидер";
    HEALBOT_WORD_VERSION                    = "Версия";
    HEALBOT_WORD_CLIENT                     = "Клиент";
    HEALBOT_WORD_ADDON                      = "Аддон";
    HEALBOT_INFO_CPUSECS                    = "CPU сек";
    HEALBOT_INFO_MEMORYMB                   = "Память MБ";
    HEALBOT_INFO_COMMS                      = "Траффик КБ";

    HEALBOT_WORD_STAR                       = "Звезда";
    HEALBOT_WORD_CIRCLE                     = "Круг";
    HEALBOT_WORD_DIAMOND                    = "Ромб";
    HEALBOT_WORD_TRIANGLE                   = "Треугольник";
    HEALBOT_WORD_MOON                       = "Луна";
    HEALBOT_WORD_SQUARE                     = "Квадрат";
    HEALBOT_WORD_CROSS                      = "Крест";
    HEALBOT_WORD_SKULL                      = "Череп";

    HEALBOT_OPTIONS_ACCEPTSKINMSG           = "Принять стиль [HealBot]: ";
    HEALBOT_OPTIONS_ACCEPTSKINMSGFROM       = " от ";
    HEALBOT_OPTIONS_BUTTONSHARESKIN         = "Поделиться с";

    HEALBOT_CHAT_ADDONID                    = "[HealBot]  ";
    HEALBOT_CHAT_NEWVERSION1                = "Доступна новая версия";
    HEALBOT_CHAT_NEWVERSION2                = "на "..HEALBOT_ABOUT_URL;
    HEALBOT_CHAT_SHARESKINERR1              = " Не найден расшаренный стиль";
    HEALBOT_CHAT_SHARESKINERR3              = " не найден для отправки";
    HEALBOT_CHAT_SHARESKINACPT              = "Расшаренный стиль от ";
    HEALBOT_CHAT_CONFIRMSKINDEFAULTS        = "Стиль по умолчанию";
    HEALBOT_CHAT_CONFIRMCUSTOMDEFAULTS      = "Пользовательские дебаффы сброшены";
    HEALBOT_CHAT_CHANGESKINERR1             = "Неизвестный стиль: /hb skin ";
    HEALBOT_CHAT_CHANGESKINERR2             = "Известные стили:  ";
    HEALBOT_CHAT_CONFIRMSPELLCOPY           = "Текущее заклинание скопировано на все наборы талантов";
    HEALBOT_CHAT_UNKNOWNCMD                 = "Неизвестная команда: /hb ";
    HEALBOT_CHAT_ENABLED                    = "Вхожу в активное состояние";
    HEALBOT_CHAT_DISABLED                   = "Вхожу в отключенное состояние";
    HEALBOT_CHAT_SOFTRELOAD                 = "Запрошен перезапуск HealBot'а";
    HEALBOT_CHAT_HARDRELOAD                 = "Запрошена перезагрузка UI";
    HEALBOT_CHAT_CONFIRMSPELLRESET          = "Заклинания сброшены";
    HEALBOT_CHAT_CONFIRMCURESRESET          = "Рассеивания сброшены";
    HEALBOT_CHAT_CONFIRMBUFFSRESET          = "Бафы сброшены";
    HEALBOT_CHAT_POSSIBLEMISSINGMEDIA       = "Не удалось получить все настройки стиля - Возможно отсутствует SharedMedia, скачайте на curse.com";
    HEALBOT_CHAT_MACROSOUNDON               = "Звук не отключен при использования авто-аксессуара";
    HEALBOT_CHAT_MACROSOUNDOFF              = "Звук отключен при использования авто-аксессуара";
    HEALBOT_CHAT_MACROERRORON               = "Ошибки не отключены при использования авто-аксессуара";
    HEALBOT_CHAT_MACROERROROFF              = "Ошибки отключены при использования авто-аксессуара";
    HEALBOT_CHAT_ACCEPTSKINON               = "Общие стили - Показывать окно приема стиля когда кто-то делится с вами стилем";
    HEALBOT_CHAT_ACCEPTSKINOFF              = "Общие стили - Всегда игнорировать общие стили от всех";
    HEALBOT_CHAT_USE10ON                    = "Авто-Аксессуар - Use10 вкл - Вы должны выбрать существующий авто-аксессуар";
    HEALBOT_CHAT_USE10OFF                   = "Авто-Аксессуар - Use10 выкл";
    HEALBOT_CHAT_SKINREC                    = " получен стиль от ";

    HEALBOT_OPTIONS_SELFCASTS               = "Только на себя";
    HEALBOT_OPTIONS_HOTSHOWICON             = "Показывать иконку";
    HEALBOT_OPTIONS_ALLSPELLS               = "Все заклинания";
    HEALBOT_OPTIONS_DOUBLEROW               = "Двойной ряд";
    HEALBOT_OPTIONS_HOTBELOWBAR             = "Под панелью";
    HEALBOT_OPTIONS_OTHERSPELLS             = "Другие заклинания";
    HEALBOT_WORD_MACROS                     = "Макросы";
    HEALBOT_WORD_SELECT                     = "Выбрать";
    HEALBOT_OPTIONS_QUESTION                = "?";
    HEALBOT_WORD_CANCEL                     = "Отмена";
    HEALBOT_WORD_COMMANDS                   = "Команды";
    HEALBOT_OPTIONS_BARHEALTH3              = "число";
    HEALBOT_SORTBY_ROLE                     = "Роль";
    HEALBOT_WORD_DPS                        = "DPS";
    HEALBOT_CHAT_TOPROLEERR                 = " роль не действительна в данном контексте - используйте 'TANK', 'DPS' или 'HEALER'";
    HEALBOT_CHAT_NEWTOPROLE                 = "Самая приоритетная роль ";
    HEALBOT_CHAT_SUBSORTPLAYER1             = "Игроки будут отображаться первыми в Доп.Сортировке";
    HEALBOT_CHAT_SUBSORTPLAYER2             = "Игроки будут отображаться как обычно в Доп.Сортировке";
    HEALBOT_OPTIONS_SHOWREADYCHECK          = "Показывать Проверку готовности";
    HEALBOT_OPTIONS_SUBSORTSELFFIRST        = "Сначала вы";
    HEALBOT_WORD_FILTER                     = "Фильтр";
    HEALBOT_OPTION_AGGROPCTBAR              = "Двигать панель";
    HEALBOT_OPTION_AGGROPCTTXT              = "Показать текст";
    HEALBOT_OPTION_AGGROPCTTRACK            = "Следить за %";
    HEALBOT_OPTIONS_ALERTAGGROLEVEL1        = "1 - Низкая угроза";
    HEALBOT_OPTIONS_ALERTAGGROLEVEL2        = "2 - Высокая угроза";
    HEALBOT_OPTIONS_ALERTAGGROLEVEL3        = "3 - Танкование";
    HEALBOT_OPTIONS_AGGROALERT              = "Уровень сигнала на панели";
    HEALBOT_OPTIONS_AGGROINDALERT           = "Уровень сигнала на индикаторе";
    HEALBOT_OPTIONS_TOOLTIPSHOWHOT          = "Показать подробности о наблюдаемом HoT'е";
    HEALBOT_WORDS_MIN                       = "мин";
    HEALBOT_WORDS_MAX                       = "макс";
    HEALBOT_CHAT_SELFPETSON                 = "Свой Питомец включен";
    HEALBOT_CHAT_SELFPETSOFF                = "Свой Питомец выключен";
    HEALBOT_WORD_PRIORITY                   = "Приоритет";
    HEALBOT_VISIBLE_RANGE                   = "В пределах 100 ярдов";
    HEALBOT_SPELL_RANGE                     = "В пределах действия заклинания";
    HEALBOT_WORD_RESET                      = "Сброс";
    HEALBOT_HBMENU                          = "HBmenu";
    HEALBOT_ACTION_HBFOCUS                  = "Левый клик - установить\nфокус на цель";
    HEALBOT_WORD_CLEAR                      = "Очистить";
    HEALBOT_WORD_SET                        = "Установить";
    HEALBOT_WORD_HBFOCUS                    = "Фокус HealBot";
    HEALBOT_WORD_OUTSIDE                    = "Внешний мир";
    HEALBOT_WORD_ALLZONE                    = "Все зоны";
    HEALBOT_OPTIONS_TAB_ALERT               = "Тревога";
    HEALBOT_OPTIONS_TAB_SORT                = "Сортировка";
    HEALBOT_OPTIONS_TAB_HIDE                = "Скрыть";
    HEALBOT_OPTIONS_TAB_AGGRO               = "Угроза";
    HEALBOT_OPTIONS_TAB_ICONTEXT            = "Текст иконки";
    HEALBOT_OPTIONS_TAB_TEXT                = "Текст панелей";
    HEALBOT_OPTIONS_AGGRO3COL               = "Цвет полосы\nугрозы";
    HEALBOT_OPTIONS_AGGROFLASHFREQ          = "Частота мерцания";
    HEALBOT_OPTIONS_AGGROFLASHALPHA         = "Прозрачность мерцания";
    HEALBOT_OPTIONS_SHOWDURATIONFROM        = "Показывать длительность от";
    HEALBOT_OPTIONS_SHOWDURATIONWARN        = "Оповещение об окончании на";
    HEALBOT_CMD_RESETCUSTOMDEBUFFS          = "Сброс пользовательских дебафов";
    HEALBOT_CMD_RESETSKINS                  = "Сброс стилей";
    HEALBOT_CMD_CLEARBLACKLIST              = "Очистить черный список";
    HEALBOT_CMD_TOGGLEACCEPTSKINS           = "Вкл/Выкл приём шкурок от других";
    HEALBOT_CMD_TOGGLEDISLIKEMOUNT          = "Вкл/Выкл игнорирование транспорта";
    HEALBOT_OPTION_DISLIKEMOUNT_ON          = "Игнорирую транспорт";
    HEALBOT_OPTION_DISLIKEMOUNT_OFF         = "Больше не игнорирую транспорт";
    HEALBOT_CMD_COPYSPELLS                  = "Копировать текущие заклинания во все наборы талантов";
    HEALBOT_CMD_RESETSPELLS                 = "Сброс заклинаний";
    HEALBOT_CMD_RESETCURES                  = "Сброс рассеиваний";
    HEALBOT_CMD_RESETBUFFS                  = "Сброс баффов";
    HEALBOT_CMD_RESETBARS                   = "Сброс позиций панелей";
    HEALBOT_CMD_SUPPRESSSOUND               = "Вкл/Выкл подавление звука при использовании авто-аксессуара";
    HEALBOT_CMD_SUPPRESSERRORS              = "Вкл/Выкл подавление ошибок при использовании авто-аксессуара";
    HEALBOT_OPTIONS_COMMANDS                = "Команды HealBot";
    HEALBOT_WORD_RUN                        = "Пуск";
    HEALBOT_OPTIONS_MOUSEWHEEL              = "Использовать колесико мыши";
    HEALBOT_OPTIONS_MOUSEUP                 = "Колесико вверх";
    HEALBOT_OPTIONS_MOUSEDOWN               = "Колесико вниз";
    HEALBOT_CMD_DELCUSTOMDEBUFF9            = "Удалить пользовательские дебаффы с приоритетом 9";
    HEALBOT_CMD_DELCUSTOMDEBUFF10           = "Удалить пользовательские дебаффы с приоритетом 10";
    HEALBOT_CMD_DELCUSTOMDEBUFF11           = "Удалить пользовательские дебаффы с приоритетом 11";
    HEALBOT_CMD_DELCUSTOMDEBUFF12           = "Удалить пользовательские дебаффы с приоритетом 12";
    HEALBOT_ACCEPTSKINS                     = "Принимать Стили от других";
    HEALBOT_SUPPRESSSOUND                   = "Авто-Аксессуар: подавлять звуки";
    HEALBOT_SUPPRESSERROR                   = "Авто-Аксессуар: подавлять ошибки";
    HEALBOT_OPTIONS_CRASHPROT               = "Защита от сбоев";
    HEALBOT_OPTIONS_USEGENERALMACRO         = "Исп. слот основных макросов"
    HEALBOT_CP_MACRO_LEN                    = "Имя макроса должно быть от 1 до 14 символов";
    HEALBOT_CP_MACRO_BASE                   = "Основное имя макроса";
    HEALBOT_CP_MACRO_SAVE                   = "Последнее сохранение в: ";
    HEALBOT_CP_STARTTIME                    = "Врямя ожидания входа в систему";
    HEALBOT_WORD_RESERVED                   = "Зарезаервировано";
    HEALBOT_OPTIONS_COMBATPROT              = "Защита в бою";
    HEALBOT_COMBATPROT_PARTYNO              = "панелей зарезервировано для Группы";
    HEALBOT_COMBATPROT_RAIDNO               = "панелей зарезервировано для Рейда";

    HEALBOT_WORD_HEALTH                     = "Здоровье";
    HEALBOT_OPTIONS_DONT_SHOW               = "Не показывать";
    HEALBOT_OPTIONS_SAME_AS_HLTH_CURRENT    = "То же, что и здоровье (текущее здоровье)";
    HEALBOT_OPTIONS_SAME_AS_HLTH_FUTURE     = "То же, что и здоровье (будущее здоровье)";
    HEALBOT_OPTIONS_FUTURE_HLTH             = "Будущее здоровье";
    HEALBOT_SKIN_HEALTHBARCOL_TEXT          = "Цвет полосы здоровья";
    HEALBOT_SKIN_HEALTHBACKCOL_TEXT         = "Цвет фона";
    HEALBOT_SKIN_INCHEALBARCOL_TEXT         = "Цвет входящего исцеления";
    HEALBOT_OPTIONS_ALWAYS_SHOW_TARGET      = "Цель: всегда показывать";
    HEALBOT_OPTIONS_ALWAYS_SHOW_FOCUS       = "Фокус: всегда показывать";
    HEALBOT_OPTIONS_GROUP_PETS_BY_FIVE      = "Питомцы: группировать по 5";
    HEALBOT_OPTIONS_USEGAMETOOLTIP          = "Использовать стандартную подсказку";
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER        = "Показывать полосу энергии";
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER_PALA   = "Показывать энергию света";
    HEALBOT_OPTIONS_SHOWPOWERCOUNTER_MONK   = "Показывать энергию чи";
    HEALBOT_OPTIONS_CUSTOMDEBUFF_REVDUR     = "Обратить длительность";
    HEALBOT_OPTIONS_DISABLEHEALBOTSOLO      = "только в соло";
    HEALBOT_OPTIONS_CUSTOM_ALLDISEASE       = "Все Болезни";
    HEALBOT_OPTIONS_CUSTOM_ALLMAGIC         = "Все Магические";
    HEALBOT_OPTIONS_CUSTOM_ALLCURSE         = "Все Проклятия";
    HEALBOT_OPTIONS_CUSTOM_ALLPOISON        = "Все Яды";
    HEALBOT_OPTIONS_CUSTOM_CASTBY           = "Источник";

    HEALBOT_BLIZZARD_MENU                   = "Меню Blizzard";
    HEALBOT_HB_MENU                         = "Меню Healbot";
    HEALBOT_FOLLOW                          = "Следовать";
    HEALBOT_TRADE                           = "Обмен";
    HEALBOT_PROMOTE_RA                      = "Назначить помощником";
    HEALBOT_DEMOTE_RA                       = "Разжаловать помощника";
    HEALBOT_TOGGLE_ENABLED                  = "Активировать/Деактикировать";
    HEALBOT_TOGGLE_MYTARGETS                = "Вкл/Выкл мои цели";
    HEALBOT_TOGGLE_PRIVATETANKS             = "Вкл/Выкл личных танков";
    HEALBOT_RESET_BAR                       = "Сброс панели";
    HEALBOT_HIDE_BARS                       = "Скрыть полосы дальше 100 метров";
    HEALBOT_RANDOMMOUNT                     = "Случайный транспорт";
    HEALBOT_RANDOMGOUNDMOUNT                = "Случайный наземный транспорт";
    HEALBOT_RANDOMPET                       = "Случайный спутник";
    HEALBOT_ZONE_AQ40                       = "Ан'Кираж";
    HEALBOT_ZONE_VASHJIR1                   = "Лес Келп'тар";
    HEALBOT_ZONE_VASHJIR2                   = "Мерцающий простор";
    HEALBOT_ZONE_VASHJIR3                   = "Бездонные глубины";
    HEALBOT_ZONE_VASHJIR                    = "Вайш'ир";
    HEALBOT_RESLAG_INDICATOR                = "Оставлять имя зеленым после воскрешения";
    HEALBOT_RESLAG_INDICATOR_ERROR          = "Оставлять имя зеленым после воскрешения должно быть от 1 до 30";
    HEALBOT_FRAMELOCK_BYPASS_OFF            = "Обход блокировки окон выключен";
    HEALBOT_FRAMELOCK_BYPASS_ON             = "Обход вбокировки окон (Ctl+Alt+Left) включен";
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
    HEALBOT_OPTIONS_CONTENT_CURE            = "        " .. HEALBOT_OPTIONS_TAB_CDC;
    HEALBOT_OPTIONS_CONTENT_BUFFS           = "        " .. HEALBOT_OPTIONS_TAB_BUFFS;
    HEALBOT_OPTIONS_CONTENT_TIPS            = "        " .. HEALBOT_OPTIONS_TAB_TIPS;
    HEALBOT_OPTIONS_CONTENT_MOUSEWHEEL      = "        Колесико мыши";
    HEALBOT_OPTIONS_CONTENT_TEST            = "        Тест";
    HEALBOT_OPTIONS_CONTENT_USAGE           = "        Производительность";
    HEALBOT_OPTIONS_REFRESH                 = "Обновить";

    HEALBOT_CUSTOM_CATEGORY                 = "Категория";
    HEALBOT_CUSTOM_CAT_CUSTOM               = "Свой";
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

    HEALBOT_CUSTOM_CAT_CUSTOM_IMPORTANT     = "Важные дебаффы";
    HEALBOT_CUSTOM_CAT_CUSTOM_DAMAGE        = "Наносящие урон дебаффы";
    HEALBOT_CUSTOM_CAT_CUSTOM_EFFECT        = "Дебаффы эффектов";
    HEALBOT_CUSTOM_CAT_CUSTOM_MISC          = "Другие дебаффы";

    HEALBOT_CUSTOM_DEBUFF_CATS = {
             -- Defaults
            [HEALBOT_CUSTOM_CAT_CUSTOM_IMPORTANT]  = 1,
			[HEALBOT_CUSTOM_CAT_CUSTOM_DAMAGE]     = 1,
            [HEALBOT_CUSTOM_CAT_CUSTOM_EFFECT]     = 1,
            [HEALBOT_CUSTOM_CAT_CUSTOM_MISC]       = 1,
	}

    HEALBOT_ABOUT_DESC1                     = "Добавляет окно со стилизуемыми панелями для исцеления, рассеивания, наложения баффов и отслеживания угрозы.";
    HEALBOT_ABOUT_WEBSITE                   = "Сайт:";
    HEALBOT_ABOUT_AUTHORH                   = "Автор:";
    HEALBOT_ABOUT_AUTHORD                   = "Strife";
    HEALBOT_ABOUT_CATH                      = "Категория:";
    HEALBOT_ABOUT_CATD                      = "Unit Frames, Buffs and Debuffs, Combat:Healer";
    HEALBOT_ABOUT_CREDITH                   = "Благодарности:";
    HEALBOT_ABOUT_CREDITD                   = "Acirac, Kubik, Von, Aldetal, Brezza, Moonlight Han Xing, CTShammy, Hermis, Ariá, Snaomi";  -- Anyone taking on translations (if required), feel free to add yourself here.
    HEALBOT_ABOUT_LOCALH                    = "Локализации:";
    HEALBOT_ABOUT_LOCALD                    = "deDE, enUK, esES, frFR, huHU, itIT, koKR, poBR, ruRU, zhCN, zhTW";
    HEALBOT_ABOUT_FAQH                      = "Часто Задаваемые Вопросы";
    HEALBOT_ABOUT_FAQ_QUESTION              = "Вопрос";
    HEALBOT_ABOUT_FAQ_ANSWER                = "Ответ";

    HEALBOT_ABOUT_FAQ_QUESTIONS = {
        [1]   = "Баффы - Все панели белые, что случилось?",
        [2]   = "Применение - Иногда курсор становится синим и я не могу ничего делать",
        [3]   = "Мкросы - Есть примеры с временем восстановления?",
        [4]   = "Мкросы - Есть примеры с применением заклинаний?",
        [5]   = "Мышь - Как использовать мой mouseover макрос с колесиком мыши?",
        [6]   = "Настройки - Как отсортировать панели по группам, например по 2 группы в колонке?",
        [7]   = "Настройки - Могу ли я спрятать все панели и показать только те, которым нужно рассеивание?",
        [8]   = "Настройки - Могу ли спрятать входящее исцеление?",
        [9]   = "Настройки - Healbot не сохраняет мои настройки при входе в игру/выходе из игры",
        [10]  = "Настройки - Как мне всегда использовать настройки для активных панелей?",
        [11]  = "Настройки - Как автоматически отключать healbot?",
        [12]  = "Настройки - Как заставить панели расти в разных направлениях?",
        [13]  = "Настройки - Как настроить 'Мои цели'?",
        [14]  = "Настройки - Как настроить 'Личных танков'?",
        [15]  = "Настройки - Healbot создает панели для NPC?",
        [16]  = "Расстояние - Я не вижу когда люди вне досягаемости, как это исправить?",
        [17]  = "Заклинания - Healbot применяет заклинание, отличное от настроенного",
        [18]  = "Заклинания - Я больше не могу применять заклинания к здоровым целям",
    }

    HEALBOT_ABOUT_FAQ_SPELLS_ANSWER01 = "Это из-за настроек закладки Заклинания\n" ..
                                        "попробуйте внести следующие изменения: \n\n" ..
                                        "1: В закладке Заклинания: выберите Панели всегда активны\n" ..
                                        "2: В закладке Заклинания: выключите УмныйКаст\n\n" ..
                                        "Примечание: Предполагается что большинство пользователей\n"..
                                        "захотят включить УмныйКаст обратно.\n\n" ..
                                        "Примечание: Предполагается что опытные пользователи захотят\n" ..
                                        "выключить Панели всегда активны и назначить заклинания для\n" ..
                                        "неактивных панелей."

    HEALBOT_ABOUT_FAQ_ANSWERS = {
        [1] = "Вы следите за отсутствующими баффами.\n\n" ..
              "Это может быть выключено в закладке Баффы.\n" ..
              "Или просто нажмите на панель для применения баффа.",
        [2] = "Это функционал blizzard, а не Healbot.\n\n" ..
              "Используя стандартные панели blizzard, попытайтесь\n" ..
              "применить заклинание, которое еще не восстановилось.\n" ..
              "Заметьте, что курсор стал синим.\n\n" ..
              "В закладке Заклинания, включите Избегать Синего Курсора.",
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
              "Пример применения Быстрого исцеления\nс использованием 2х аксессуаров:\n\n" ..
              "#show Быстрое исцеление\n" ..
              "/script UIErrorsFrame:Hide()\n" ..
              "/console Sound_EnableSFX 0\n" ..
              "/use 13\n" ..
              "/use 14\n" ..
              "/console Sound_EnableSFX 1\n" ..
              "/cast [@hbtarget] Быстрое исцеление\n" ..
              "/script UIErrorsFrame:Clear(); UIErrorsFrame:Show()",
        [5] = "1: В закладке Колесико мыши: Выключите\nИспользовать колесико мыши\n" ..
              "2: Назначьте ваш макрос с использованием\n[@mouseover]\n\n\n" ..
              "Пример:\n\n" ..
              "#showtooltip Быстрое исцеление\n" ..
              "/cast [@mouseover] Быстрое исцеление\n",
        [6] = "Да\n\n\n"..
              "С заголовками:\n" ..
              "1: Стили > Заголовки, включите Показывать заголовки.\n" ..
              "2: Стили > Панели, назначьте количество групп на колонку.\n\n" ..
              "Без Заголовков:\n" ..
              "1: Стили > Панели, включите Количество групп в колонке.\n" ..
              "2: Стили > Панели, назначьте количество групп на колонку.",
        [7] = "Да.\n\n"..
              "1: Стили > Исцеление, установите Уровень Тревоги на 0.\n" ..
              "2: Стили > Угроза, выключите Следить за Угрозой.\n" ..
              "3: Стили > Окна > Цвета панелей, установите Прозрачность неактивных в 0.\n" ..
              "4: Стили > Окна > Цвета панелей, установите прозрачность Цвета фона в 0.\n" ..
              "5: Стили > Окна > Текст панелей, нажмите на панель Неактивный\n" ..
              "и установите прозрачность цвета Неактивных в 0.\n" ..
              "6: Стили > Окна, нажмите на панель Фон.\n" ..
              "и установите прозрачность в 0.\n" ..
              "7: Во вкладке Рассеивания, Включите Следить за наложением дебаффов.",
        [8] = "Да.\n\n"..
              "1: Стили > Окна > Цвета панелей, установите Цвет входящего исцеления\nв Не показывать.\n" ..
              "2: Стили > Окна > Текст панелей, установите Здоровье на панели\n" ..
              "в Нет Входящие исцеления",
        [9] = "Это присутствует с начала патча 3.2, и затрагивает\n" ..
              "игроков со странными символами в имени.\n\n" ..
              "Если у вас Vista или Win7, попробуйте следущее:\n"..
              "измение системный язык на Английский\n(для програм, не использующих юникод)\n" ..
              "в Панели Управления > Язык и Региональные стандарты >\nАдминистративные",
        [10] = "В закладке Заклинания включите Панели всегда активны\n\n" ..
               "Некоторые так же захотят выставить уровень тревоги в 100\n" ..
               "Это может быть сделано в закладке Стили > Исцеление",
        [11] = "Отключить для персонажа:\n\n" ..
               "1: Откройте вкладку Общее\n" ..
               "2: Включите Отключить HealBot\n\n\n" ..
               "Отключить в соло: \n\n" ..
               "1: Откройте вкладку Общее\n" ..
               "2: Правее и ниже опции Отключить HealBot,\nвыберите только в соло\n" ..
               "3: Включите Отключить HealBot",
        [12] = "Измените насройки якоря полос во вкладке Стили > Окна\n\n" ..
               "Справа Сверху: полосы будут расти Вниз и Налево\n" ..
               "Слева Сверху: полосы будут расти Вниз и Направо\n" ..
               "Справа Снизу: полосы будут расти Вверх и Налево\n" ..
               "Слева Снизу: полосы будут расти Вверх и Направо",
        [13] = "Мои цели позволяет вам создать список целей, которые\n" ..
               "вы хотите группировать отдельно от остальных, подобно\nгруппе Главных Танков\n\n" ..
               "Следующие решения доступны для добавления/удаления\n" ..
               "людей в группе Мои Цели\n\n" ..
               "- Shift+Ctrl+Alt+ПКМ на панели\n" ..
               '- Используйте Меню HealBot (настройка "hbmenu" во вкладке Заклинания)\n' ..
               "- Используйте колесико мыши, настроенное во вкладке Колесико мыши",
        [14] = "Личные танки могут быть добавлены в список Главных танков,\n" ..
               "Главные танки видны только в вашем HealBot\n" ..
               "и не влияют на аддоны других игроков\n\n" ..
               "Следующие решения доступны для добавления/удаления\n" ..
               "людей в списке Танков\n\n" ..
               '- Используйте Меню HealBot (настройка "hbmenu" во вкладке Заклинания)\n' ..
               "- Используйте колесико мыши, настроенное во вкладке Колесико мыши",
        [15] = "Да\n\n"..
               "1: Стили > Исцеление, включите Фокус\n" ..
               "2: установите фокус на НИП (или на игроке вне вашей группы/рейда)\n" ..
               "Healbot создаст панель в списке Ваших целей\n\n" ..
               "Примечание: Если в бою вы переходите из одной зоны в другую\n" ..
               "фокус на НИП придется устанавливать заново.\n" ..
               "Во вкладке Стили > Исцеление включите Фокус: всегда показывать\n" ..
               "Это позволит вам устанавливать фокус также во время боя.\n\n" ..
               "Примечание: В меню HealBot присутствует опция\n'Установть Фокус HealBot'\n" ..
               "Она позволит вам легко устанавливать фокус на НИП и\n" ..
               "служит напоминанием для установки фокуса.\n\n" ..
               "Введите 'hbmenu' в закладке Заклинания для использования меню\n" ..
               "HealBot или используйте Колесико мыши дял установки меню HealBot",
        [16] = "1: Стили > Окна > Цвета панелей, настройте Прозрасность неактивных\n" ..
               "2: Стили > Окна > Текст панелей, настройте прозрасность текста\n" ..
               "Неактивных, для этого нажмите на панель с надписью Неактивный.\n\n" ..
               "Некоторые также захотят установить Уровень Тревоги в 100.\n" ..
               "Это можно сделать в закладке Стили > Исцеление.",
        [17] = "На самом деле, Healbot применяет в точности то, что настроено.\n\n" .. HEALBOT_ABOUT_FAQ_SPELLS_ANSWER01,
        [18] = HEALBOT_ABOUT_FAQ_SPELLS_ANSWER01
    }

    HEALBOT_OPTIONS_SKINAUTHOR              = "Автор Стиля:";
    HEALBOT_OPTIONS_AVOIDBLUECURSOR         = "Избегать\nСинего Курсора";
    HEALBOT_PLAYER_OF_REALM                 = "-";

    HEALBOT_OPTIONS_LANG                    = "Язык";

    HEALBOT_OPTIONS_LANG_ZHCN               = "Chinese (zhCN - by Ydzzs)";
    HEALBOT_OPTIONS_LANG_ENUK               = "English (enUK - by Strife)";
    HEALBOT_OPTIONS_LANG_ENUS               = "English (enUS - by Strife)";
    HEALBOT_OPTIONS_LANG_FRFR               = "French (frFR - by Kubik)";
    HEALBOT_OPTIONS_LANG_DEDE               = "German (deDE - by Snaomi)";
    HEALBOT_OPTIONS_LANG_GRGR               = "Greek (grGR - by Snaomi)";
    HEALBOT_OPTIONS_LANG_HUHU               = "Hungarian (huHU - by Von)";
    HEALBOT_OPTIONS_LANG_KRKR               = "Korean (krKR - translator required)";
    HEALBOT_OPTIONS_LANG_ITIT               = "Italian (itIT - by Brezza)";
    HEALBOT_OPTIONS_LANG_PTBR               = "Portuguese (ptBR - by Aldetal)";
    HEALBOT_OPTIONS_LANG_RURU               = "Русский (ruRU - by Justice)";
    HEALBOT_OPTIONS_LANG_ESES               = "Spanish (esES - translator required)";
    HEALBOT_OPTIONS_LANG_TWTW               = "Taiwanese (twTW - translator required)";

    HEALBOT_OPTIONS_LANG_ADDON_FAIL1        = "Не удалось загрузить аддон для локализации";
    HEALBOT_OPTIONS_LANG_ADDON_FAIL2        = "Причина ошибки:";
    HEALBOT_OPTIONS_LANG_ADDON_FAIL3        = "Учтите, что в текущей версии это единственное предупреждение для";

    HEALBOT_OPTIONS_ADDON_FAIL              = "Не удалось загрузить аддон HealBot";

    HEALBOT_OPTIONS_IN_A_GROUP              = "Только в составе Группы или Рейда";

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

    HEALBOT_SKIN_ABSORBCOL_TEXT             = "Эффекты поглощения";
    HEALBOT_OPTIONS_BARALPHAABSORB          = "Прозрачность эффектов поглощения";
    HEALBOT_OPTIONS_OUTLINE                 = "Границы";
    HEALBOT_OPTIONS_FRAME                   = "Окно";
    HEALBOT_OPTIONS_CONTENT_SKINS_FRAMES    = "    " .. "Окна";
    HEALBOT_OPTIONS_FRAMESOPTTEXT           = "Настройки окон";
    HEALBOT_OPTIONS_SETTOOLTIP_POSITION     = "Установить позицию подсказки";
    HEALBOT_OPTIONS_FRAME_TITLE             = "Заголовок окна";
    HEALBOT_OPTIONS_FRAME_TITLE_SHOW        = "Показывать заголовок";
    HEALBOT_OPTIONS_GROW_DIRECTION          = "Направление расширения";
    HEALBOT_OPTIONS_BARSORIENTATION         = "Ориентация полос";
    HEALBOT_OPTIONS_GROW_HORIZONTAL         = "Горизонтально";
    HEALBOT_OPTIONS_GROW_VERTICAL           = "Вертикально";
    HEALBOT_OPTIONS_FONT_OFFSET             = "Сдвиг шрифта";
    HEALBOT_OPTIONS_SET_FRAME_HEALGROUPS    = "Назначить группы исцеления";
    HEALBOT_OPTION_EXCLUDEMOUNT_ON          = "Игнорирую транспорт";
    HEALBOT_OPTION_EXCLUDEMOUNT_OFF         = "Не игнорирую транспорт";
    HEALBOT_CMD_TOGGLEEXCLUDEMOUNT          = "Вкл/Выкл игнорирование транспорта";
    HEALBOT_OPTIONS_HIDEMINIBOSSFRAMES      = "Скрыть панели боссов";
    HEALBOT_OPTIONS_HIDERAIDFRAMES          = "Скрыть рейдовые панели";
    HEALBOT_OPTIONS_FRAME_ALIAS             = "Профиль";
    HEALBOT_OPTIONS_CONTENT_SKINS_HEALGROUP = "        " .. "Группы исцеления";
    HEALBOT_OPTIONS_CONTENT_SKINS_BARCOLOUR = "        " .. "Цвета панелей";
    HEALBOT_OPTIONS_SET_ALL_FRAMES          = "Применить текущие настрокий ко всем окнам";
    HEALBOT_WORDS_PROFILE                   = "Профиль";
    HEALBOT_SHARE_SCREENSHOT                = "Скриншот сохранен";
    HEALBOT_SHARE_INSTRUCTION               = "Посетите сайт для получения инструкций о том, как поделиться "..HEALBOT_ABOUT_URL;
    HEALBOT_ENEMY_USE_FRAME                 = "Использовать окно";
    HEALBOT_ENEMY_INCLUDE_SELF              = "Включая мою цель";
    HEALBOT_ENEMY_INCLUDE_TANKS             = "Включая цели танков";
    HEALBOT_OPTIONS_ENEMY_OPT               = "Настройки врага";
    HEALBOT_OPTIONS_SHARE_OPT               = "Настройки общего доступа";
    HEALBOT_OPTIONS_CONTENT_SKINS_SHARE     = "    " .. "Поделиться";
    HEALBOT_OPTIONS_CONTENT_SKINS_ENEMY     = "    " .. "Враг";
    HEALBOT_OPTIONS_BUTTONLOADSKIN          = "Загрузить стиль";
    HEALBOT_ENEMY_NO_TARGET                 = "Нет цели";
    HEALBOT_OPTIONS_ENEMYBARS               = "Панелей врагов в любом состоянии";
    HEALBOT_OPTIONS_HARMFUL_SPELLS          = "Вредоносные заклинания";
    HEALBOT_ENEMY_INCLUDE_MYTARGETS         = "Включая цели моих целей";
    HEALBOT_ENEMY_NUMBER_BOSSES             = "Количество Боссов";
    HEALBOT_ENEMY_HIDE_OUTOFCOMBAT          = "Скрыть панели вне боя";
    HEALBOT_ENEMY_EXISTS_SHOW               = "Только при входе в бой".."\n".."показывать при выходе";
    HEALBOT_ENEMY_EXISTS_SHOW_PTARGETS      = "Полосы целей игроков"
    HEALBOT_ENEMY_EXISTS_SHOW_BOSSES        = "Панели боссов";
    HEALBOT_OPTIONS_TARGET_ONLY_FRIEND      = "Цель: Показывать только дружественную";
    HEALBOT_OPTIONS_FOCUS_ONLY_FRIEND       = "Фокус: Показывать только дружественный";
    HEALBOT_OPTIONS_PROFILE                 = "Профиль для".."\n".."Закл/Баффов/Рассеиваний";
    HEALBOT_OPTIONS_PROFILE_CHARACTER       = "Персонаж";
    HEALBOT_OPTIONS_PROFILE_CLASS           = "Класс";
    HEALBOT_OPTIONS_INCOMBATALERTLEVEL      = "Уровень Тревоги - В Бою";
    HEALBOT_OPTIONS_OUTCOMBATALERTLEVEL     = "Уровень Тревоги - Вне Боя";
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
    HEALBOT_LDB_SHIFTLEFT_TOOLTIP           = "|cffffff00 Shift-ЛКМ:|r Переключить стиль HealBot";
    HEALBOT_LDB_RIGHT_TOOLTIP               = "|cffffff00 ПКМ:|r Сбросить HealBot";
    HEALBOT_LDB_SHIFTRIGHT_TOOLTIP          = "|cffffff00 Shift-ПКМ:|r Вкл/Выкл HealBot";
    HEALBOT_WORD_PETBATTLE                  = "Битвы питомцев"
    HEALBOT_ENEMY_INCLUDE_ARENA             = "Включая оппонентов арены"
    HEALBOT_ENEMY_INCLUDE_ARENAPETS         = "Включая питомцев"
    HEALBOT_ENEMY_EXISTS_SHOW_ARENA         = "Полосы оппонентов арены"
    HEALBOT_CMD_TOGGLECUSTOMCURECASTBY      = "Вкл/Выкл свои рассеивания - по умолчанию по"
end
