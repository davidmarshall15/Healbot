-- Korean translator required

-------------
-- KOREAN --
-------------
--
--
--
--

function HealBot_Lang_koKR()

-----------------
-- Translation --
-----------------

-- Class
    HEALBOT_DRUID = "드루이드";
    HEALBOT_HUNTER = "사냥꾼";
    HEALBOT_MAGE = "마법사";
    HEALBOT_PALADIN = "성기사";
    HEALBOT_PRIEST = "사제";
    HEALBOT_ROGUE = "도적";
    HEALBOT_SHAMAN = "주술사";
    HEALBOT_WARLOCK = "흑마법사";
    HEALBOT_WARRIOR = "전사";
    HEALBOT_DEATHKNIGHT = "죽음의 기사";
HEALBOT_MONK                            = "Monk";

    HEALBOT_DISEASE = "질병";
    HEALBOT_MAGIC = "마법";
    HEALBOT_CURSE = "저주";
    HEALBOT_POISON = "독";

    HB_TOOLTIP_OFFLINE = "오프라인";
    HB_OFFLINE = "님이 게임을 종료했습니다."; -- has gone offline msg
    HB_ONLINE = "님이 게임에 접속했습니다."; -- has come online msg

    HEALBOT_HEALBOT                         = "HealBot";
    HEALBOT_ADDON                           = HEALBOT_HEALBOT .. " " .. HEALBOT_VERSION;
    HEALBOT_LOADED = "|1을;를; 불려옵니다.";

    HEALBOT_RANK   = {[1]="(1 레벨)", [2]="(2 레벨)", [3]="(3 레벨)", [4]="(4 레벨)", [5]="(5 레벨)", [6]="(6 레벨)", [7]="(7 레벨)",
                      [8]="(8 레벨)", [9]="(9 레벨)", [10]="(10 레벨)", [11]="(11 레벨)", [12]="(12 레벨)", [13]="(13 레벨)"}

    HEALBOT_ACTION_OPTIONS = "옵션";

    HEALBOT_OPTIONS_TITLE = HEALBOT_ADDON;
    HEALBOT_OPTIONS_DEFAULTS = "기본값";
    HEALBOT_OPTIONS_CLOSE = "닫기";
    HEALBOT_OPTIONS_HARDRESET = "UI 재시작"
    HEALBOT_OPTIONS_SOFTRESET = "HB 초기화"
    HEALBOT_OPTIONS_TAB_GENERAL = "일반";
    HEALBOT_OPTIONS_TAB_SPELLS = "주문";
    HEALBOT_OPTIONS_TAB_HEALING = "치유";
    HEALBOT_OPTIONS_TAB_CDC = "치료";
    HEALBOT_OPTIONS_TAB_SKIN = "스킨";
    HEALBOT_OPTIONS_TAB_TIPS = "툴팁";
    HEALBOT_OPTIONS_TAB_BUFFS = "버프"

    HEALBOT_OPTIONS_BARALPHA = "투명도 사용";
    HEALBOT_OPTIONS_BARALPHAINHEAL = "들어오는 치유 투명도";
HEALBOT_OPTIONS_BARALPHABACK            = "Background bar opacity";
    HEALBOT_OPTIONS_BARALPHAEOR = "사거리 벗어남 투명도";
    HEALBOT_OPTIONS_ACTIONLOCKED = "위치 잠금";
    HEALBOT_OPTIONS_AUTOSHOW = "자동 닫기";
    HEALBOT_OPTIONS_PANELSOUNDS = "옵션 열때 효과음 재생";
    HEALBOT_OPTIONS_HIDEOPTIONS = "옵션 버튼 숨김";
    HEALBOT_OPTIONS_PROTECTPVP = "우발적 PvP 피함";
    HEALBOT_OPTIONS_HEAL_CHATOPT = "대화 옵션";

HEALBOT_OPTIONS_FRAMESCALE              = "Frame Scale"
    HEALBOT_OPTIONS_SKINTEXT = "스킨 사용"
    HEALBOT_SKINS_STD = "표준"
    HEALBOT_OPTIONS_SKINTEXTURE = "무늬"
    HEALBOT_OPTIONS_SKINHEIGHT = "높이"
    HEALBOT_OPTIONS_SKINWIDTH = "너비"
    HEALBOT_OPTIONS_SKINNUMCOLS = "번호. 컬럼"
    HEALBOT_OPTIONS_SKINNUMHCOLS = "번호. 컬럼당 그룹"
    HEALBOT_OPTIONS_SKINBRSPACE = "줄 간격"
    HEALBOT_OPTIONS_SKINBCSPACE = "칸 간격"
    HEALBOT_OPTIONS_EXTRASORT = "공격 바 정렬"
    HEALBOT_SORTBY_NAME = "이름"
    HEALBOT_SORTBY_CLASS = "직업"
    HEALBOT_SORTBY_GROUP = "그룹"
    HEALBOT_SORTBY_MAXHEALTH = "최대 생명력"
    HEALBOT_OPTIONS_NEWDEBUFFTEXT = "새로운 디버프"
    HEALBOT_OPTIONS_DELSKIN = "삭제"
    HEALBOT_OPTIONS_NEWSKINTEXT = "새로운 스킨"
    HEALBOT_OPTIONS_SAVESKIN = "저장"
    HEALBOT_OPTIONS_SKINBARS = "바 옵션"
    HEALBOT_SKIN_ENTEXT = "사용"
    HEALBOT_SKIN_DISTEXT = "사용 안함"
    HEALBOT_SKIN_DEBTEXT = "디버프"
    HEALBOT_SKIN_BACKTEXT = "배경"
    HEALBOT_SKIN_BORDERTEXT = "테두리"
    HEALBOT_OPTIONS_SKINFONT = "글꼴"
    HEALBOT_OPTIONS_SKINFHEIGHT = "글꼴 크기"
HEALBOT_OPTIONS_SKINFOUTLINE            = "Font Outline"
    HEALBOT_OPTIONS_BARALPHADIS = "투명도 사용 안함"
    HEALBOT_OPTIONS_SHOWHEADERS = "제목 표시"

    HEALBOT_OPTIONS_ITEMS = "아이템";

    HEALBOT_OPTIONS_COMBOCLASS = "단축 키";
    HEALBOT_OPTIONS_CLICK = "클릭";
HEALBOT_OPTIONS_SHIFT                   = "Shift";
HEALBOT_OPTIONS_CTRL                    = "Ctrl";
    HEALBOT_OPTIONS_ENABLEHEALTHY = "항상 사용";

    HEALBOT_OPTIONS_CASTNOTIFY1 = "알림 없음";
    HEALBOT_OPTIONS_CASTNOTIFY2 = "자신 알림";
    HEALBOT_OPTIONS_CASTNOTIFY3 = "대상 알림";
    HEALBOT_OPTIONS_CASTNOTIFY4 = "파티 알림";
    HEALBOT_OPTIONS_CASTNOTIFY5 = "공대 알림";
    HEALBOT_OPTIONS_CASTNOTIFY6 = "채널 알림";
    HEALBOT_OPTIONS_CASTNOTIFYRESONLY = "부활만 알림";

    HEALBOT_OPTIONS_CDCBARS = "바 색상";
    HEALBOT_OPTIONS_CDCSHOWHBARS = "생명력 바 색상 변경";
    HEALBOT_OPTIONS_CDCSHOWABARS = "어그로 바 색상 변경";
    HEALBOT_OPTIONS_CDCWARNINGS = "디버프 경고";
    HEALBOT_OPTIONS_SHOWDEBUFFICON = "디버프 표시";
    HEALBOT_OPTIONS_SHOWDEBUFFWARNING = "디버프 경고 표시";
    HEALBOT_OPTIONS_SOUNDDEBUFFWARNING = "디버프시 효과음";
    HEALBOT_OPTIONS_SOUND = "효과음"

    HEALBOT_OPTIONS_HEAL_BUTTONS = "치유 바";
    HEALBOT_OPTIONS_SELFHEALS = "자신"
    HEALBOT_OPTIONS_PETHEALS = "소환수"
    HEALBOT_OPTIONS_GROUPHEALS = "파티";
    HEALBOT_OPTIONS_TANKHEALS = "방어 담당";
    HEALBOT_OPTIONS_MAINASSIST = "공격 담당";
    HEALBOT_OPTIONS_PRIVATETANKS = "개인적 방어 담당";
    HEALBOT_OPTIONS_TARGETHEALS = "대상";
    HEALBOT_OPTIONS_EMERGENCYHEALS = "공격대";
    HEALBOT_OPTIONS_ALERTLEVEL = "경고 레벨";
    HEALBOT_OPTIONS_EMERGFILTER = "공격대 바 표시";
    HEALBOT_OPTIONS_EMERGFCLASS = "직업 설정";
    HEALBOT_OPTIONS_COMBOBUTTON = "버튼";
    HEALBOT_OPTIONS_BUTTONLEFT = "왼쪽";
    HEALBOT_OPTIONS_BUTTONMIDDLE = "중앙";
    HEALBOT_OPTIONS_BUTTONRIGHT = "오른쪽";
    HEALBOT_OPTIONS_BUTTON4 = "버튼 4";
    HEALBOT_OPTIONS_BUTTON5 = "버튼 5";
    HEALBOT_OPTIONS_BUTTON6 = "버튼 6";
    HEALBOT_OPTIONS_BUTTON7 = "버튼 7";
    HEALBOT_OPTIONS_BUTTON8 = "버튼 8";
    HEALBOT_OPTIONS_BUTTON9 = "버튼 9";
    HEALBOT_OPTIONS_BUTTON10 = "버튼 10";
    HEALBOT_OPTIONS_BUTTON11 = "버튼 11";
    HEALBOT_OPTIONS_BUTTON12 = "버튼 12";
    HEALBOT_OPTIONS_BUTTON13 = "버튼 13";
    HEALBOT_OPTIONS_BUTTON14 = "버튼 14";
    HEALBOT_OPTIONS_BUTTON15 = "버튼 15";

    HEALBOT_CLASSES_ALL = "모든 직업";
    HEALBOT_CLASSES_MELEE = "근거리";
    HEALBOT_CLASSES_RANGES = "원거리";
    HEALBOT_CLASSES_HEALERS = "치유사";
    HEALBOT_CLASSES_CUSTOM = "사용자";

    HEALBOT_OPTIONS_SHOWTOOLTIP = "툴팁 표시";
    HEALBOT_OPTIONS_SHOWDETTOOLTIP = "상세한 주문 정보 표시";
    HEALBOT_OPTIONS_SHOWCDTOOLTIP = "주문 재사용 대기시간 표시";
    HEALBOT_OPTIONS_SHOWUNITTOOLTIP = "대상 정보 표시";
    HEALBOT_OPTIONS_SHOWRECTOOLTIP = "지속 치유 추천 표시";
    HEALBOT_TOOLTIP_POSDEFAULT = "기본 위치";
    HEALBOT_TOOLTIP_POSLEFT = "Healbot의 좌측";
    HEALBOT_TOOLTIP_POSRIGHT = "Healbot의 우측";
    HEALBOT_TOOLTIP_POSABOVE = "Healbot의 상단";
    HEALBOT_TOOLTIP_POSBELOW = "Healbot의 하단";
    HEALBOT_TOOLTIP_POSCURSOR = "커서 옆";
    HEALBOT_TOOLTIP_RECOMMENDTEXT = "지속 치유 추천";
    HEALBOT_TOOLTIP_NONE = "사용 가능 없음";
    HEALBOT_TOOLTIP_CORPSE = "의 시체";
    HEALBOT_TOOLTIP_CD = " (CD ";
    HEALBOT_TOOLTIP_SECS = "s)";
    HEALBOT_WORDS_SEC = "초";
    HEALBOT_WORDS_CAST = "시전";
    HEALBOT_WORDS_UNKNOWN = "알 수 없음";
    HEALBOT_WORDS_YES = "예";
    HEALBOT_WORDS_NO = "아니요";
HEALBOT_WORDS_THIN                      = "Thin";
HEALBOT_WORDS_THICK                     = "Thick";

    HEALBOT_WORDS_NONE = "없음";
    HEALBOT_OPTIONS_ALT = "Alt";
    HEALBOT_DISABLED_TARGET = "대상";
    HEALBOT_OPTIONS_SHOWCLASSONBAR = "바에 직업 표시";
    HEALBOT_OPTIONS_SHOWHEALTHONBAR = "바에 생명력 표시";
    HEALBOT_OPTIONS_BARHEALTHINCHEALS = "들어오는 치유 포함";
    HEALBOT_OPTIONS_BARHEALTHSEPHEALS = "들어오는 치유 분리";
    HEALBOT_OPTIONS_BARHEALTH1 = "결손치";
    HEALBOT_OPTIONS_BARHEALTH2 = "백분율";
    HEALBOT_OPTIONS_TIPTEXT = "툴팁 정보";
    HEALBOT_OPTIONS_POSTOOLTIP = "위치 정보";
    HEALBOT_OPTIONS_SHOWNAMEONBAR = "바에 이름 표시";
    HEALBOT_OPTIONS_BARTEXTCLASSCOLOUR1 = "직업에 의한 문자 색상";
    HEALBOT_OPTIONS_EMERGFILTERGROUPS = "공격대 그룹 포함";

    HEALBOT_ONE                             = "1";
    HEALBOT_TWO                             = "2";
    HEALBOT_THREE                           = "3";
    HEALBOT_FOUR                            = "4";
    HEALBOT_FIVE                            = "5";
    HEALBOT_SIX                             = "6";
    HEALBOT_SEVEN                           = "7";
    HEALBOT_EIGHT                           = "8";

    HEALBOT_OPTIONS_SETDEFAULTS = "기본값 설정";
    HEALBOT_OPTIONS_SETDEFAULTSMSG = "모든 옵션을 기본값으로 되돌립니다.";
    HEALBOT_OPTIONS_RIGHTBOPTIONS = "우 클릭시 옵션 열기";

    HEALBOT_OPTIONS_HEADEROPTTEXT = "제목 옵션";
    HEALBOT_OPTIONS_ICONOPTTEXT = "아이콘 옵션";
    HEALBOT_SKIN_HEADERBARCOL = "바 색상";
    HEALBOT_SKIN_HEADERTEXTCOL = "문자 색상";
    HEALBOT_OPTIONS_BUFFSTEXT1 = "버프 주문";
    HEALBOT_OPTIONS_BUFFSTEXT2 = "멤버 체크";
    HEALBOT_OPTIONS_BUFFSTEXT3 = "바 색상";
    HEALBOT_OPTIONS_BUFF = "보프 ";
    HEALBOT_OPTIONS_BUFFSELF = "자신";
    HEALBOT_OPTIONS_BUFFPARTY = "파티시";
    HEALBOT_OPTIONS_BUFFRAID = "공격대시";
    HEALBOT_OPTIONS_MONITORBUFFS = "사라진 버프 모니터";
    HEALBOT_OPTIONS_MONITORBUFFSC = "전투중";
    HEALBOT_OPTIONS_ENABLESMARTCAST = "비전투 상태일 때 신속시전";
    HEALBOT_OPTIONS_SMARTCASTSPELLS = "주문들 포함";
    HEALBOT_OPTIONS_SMARTCASTDISPELL = "디버프 제거";
    HEALBOT_OPTIONS_SMARTCASTBUFF = "버프 추가";
    HEALBOT_OPTIONS_SMARTCASTHEAL = "치유 주문들";
    HEALBOT_OPTIONS_BAR2SIZE = "파워 바 크기";
    HEALBOT_OPTIONS_SETSPELLS = "주문 설정";
    HEALBOT_OPTIONS_ENABLEDBARS = "항상 바 사용";
    HEALBOT_OPTIONS_DISABLEDBARS = "비전투 상태일 때 바 사용 안함";
    HEALBOT_OPTIONS_MONITORDEBUFFS = "디버프들 해제 모니터";
    HEALBOT_OPTIONS_DEBUFFTEXT1 = "디버프 해제 주문";

    HEALBOT_OPTIONS_IGNOREDEBUFF = "디버프들 무시:";
    HEALBOT_OPTIONS_IGNOREDEBUFFCLASS = "직업별";
    HEALBOT_OPTIONS_IGNOREDEBUFFMOVEMENT = "감속 효과";
    HEALBOT_OPTIONS_IGNOREDEBUFFDURATION = "짧은 지속시간";
    HEALBOT_OPTIONS_IGNOREDEBUFFNOHARM = "해롭지 않은 ";
HEALBOT_OPTIONS_IGNOREDEBUFFCOOLDOWN    = "When cure spell CoolDown > 1.5 secs (GCD)";
HEALBOT_OPTIONS_IGNOREDEBUFFFRIEND      = "When caster is known as friend";

    HEALBOT_OPTIONS_RANGECHECKFREQ = "거리, 오라, 어그로 업데이트 빈도";

    HEALBOT_OPTIONS_HIDEPARTYFRAMES = "파티원 프레임 숨김";
    HEALBOT_OPTIONS_HIDEPLAYERTARGET = "플레이어와 대상 포함";
    HEALBOT_OPTIONS_DISABLEHEALBOT = "HealBot 사용 안함";

    HEALBOT_ASSIST = "지원";
    HEALBOT_FOCUS = "주시";
    HEALBOT_MENU = "메뉴";
    HEALBOT_MAINTANK = "방어  담당";
    HEALBOT_MAINASSIST = "공격 담당";
    HEALBOT_STOP = "정지";
    HEALBOT_TELL = "알림";

    HEALBOT_OPTIONS_SHOWMINIMAPBUTTON = "미니맵 버튼 표시";
    HEALBOT_OPTIONS_BARBUTTONSHOWHOT = "HoT 표시";
    HEALBOT_OPTIONS_BARBUTTONSHOWRAIDICON = "전술 목표 표시";
    HEALBOT_OPTIONS_HOTONBAR = "바 켬";
    HEALBOT_OPTIONS_HOTOFFBAR = "바 끔";
    HEALBOT_OPTIONS_HOTBARRIGHT = "오른쪽";
    HEALBOT_OPTIONS_HOTBARLEFT = "왼쪽";

    HEALBOT_ZONE_AB = "아라시 분지";
    HEALBOT_ZONE_AV = "알터랙 계곡";
    HEALBOT_ZONE_ES = "폭풍의 눈";
    HEALBOT_ZONE_IC = "정복의 섬";
    HEALBOT_ZONE_SA = "고대의 해안";

    HEALBOT_OPTION_AGGROTRACK = "어그로 모니터"
    HEALBOT_OPTION_AGGROBAR = "반작임 바"
    HEALBOT_OPTION_AGGROTXT = ">> 문자 표시 <<"
HEALBOT_OPTION_AGGROIND                 = "Indicator"
    HEALBOT_OPTION_BARUPDFREQ = "업데이트 빈도"
    HEALBOT_OPTION_USEFLUIDBARS = "유동적 바 사용"
    HEALBOT_OPTION_CPUPROFILE = "CPU 프로필 사용 (애드온의 CPU 사용 정보)"
    HEALBOT_OPTIONS_RELOADUIMSG = "이 옵션은 UI 재시작 후 적용됩니다, 지금 재시작 하시겠습니까?"

    HEALBOT_BUFF_PVP                        = "PvP"
    HEALBOT_BUFF_PVE						= "PvE"
    HEALBOT_OPTIONS_ANCHOR = "프레임 위치"
    HEALBOT_OPTIONS_BARSANCHOR = "바 위치"
    HEALBOT_OPTIONS_TOPLEFT = "좌측 상단"
    HEALBOT_OPTIONS_BOTTOMLEFT = "좌측 하단"
    HEALBOT_OPTIONS_TOPRIGHT = "우측 상단"
    HEALBOT_OPTIONS_BOTTOMRIGHT = "우측 하단"
    HEALBOT_OPTIONS_TOP = "상단"
    HEALBOT_OPTIONS_BOTTOM = "하단"

    HEALBOT_PANEL_BLACKLIST = "블랙리스트"

    HEALBOT_WORDS_REMOVEFROM = "제거";
    HEALBOT_WORDS_ADDTO = "추가";
    HEALBOT_WORDS_INCLUDE = "포함";

    HEALBOT_OPTIONS_TTALPHA = "투명도"
    HEALBOT_TOOLTIP_TARGETBAR = "대상 바"
    HEALBOT_OPTIONS_MYTARGET = "나의 대상"

    HEALBOT_DISCONNECTED_TEXT = "<DC>"
    HEALBOT_OPTIONS_SHOWUNITBUFFTIME = "나의 버프들 표시";
    HEALBOT_OPTIONS_TOOLTIPUPDATE = "지속적 업데이트";
    HEALBOT_OPTIONS_BUFFSTEXTTIMER = "만료전 버프 표시";
    HEALBOT_OPTIONS_SHORTBUFFTIMER = "짧은 버프들"
    HEALBOT_OPTIONS_LONGBUFFTIMER = "긴 버프들"

    HEALBOT_OPTIONS_NOTIFY_MSG = "메시지"
    HEALBOT_WORDS_YOU = "당신";
    HEALBOT_NOTIFYOTHERMSG ="#n님에게 #s 시전을 시작합니다.";

    HEALBOT_OPTIONS_HOTPOSITION = "아이콘 위치"
    HEALBOT_OPTIONS_HOTSHOWTEXT = "아이콘 문자 표시"
    HEALBOT_OPTIONS_HOTTEXTCOUNT = "갯수"
    HEALBOT_OPTIONS_HOTTEXTDURATION = "지속시간"
    HEALBOT_OPTIONS_ICONSCALE = "아이콘 크기"
    HEALBOT_OPTIONS_ICONTEXTSCALE = "아이콘 문자 크기"

    HEALBOT_OPTIONS_AGGROBARSIZE = "어그로 바 크기"
    HEALBOT_OPTIONS_DOUBLETEXTLINES = "이중 문자 라인"
    HEALBOT_OPTIONS_TEXTALIGNMENT = "문자 정렬"
    HEALBOT_VEHICLE = "차량"
    HEALBOT_WORDS_ERROR = "오류"
    HEALBOT_SPELL_NOT_FOUND = "주문을 찾을수 없음"
    HEALBOT_OPTIONS_DISABLETOOLTIPINCOMBAT = "중투 상태시 툴팁 숨김"
    HEALBOT_OPTIONS_ENABLELIBQH = "fastHealth 사용"

    HEALBOT_OPTIONS_BUFFNAMED = "볼 플레이어의 이름 입력\n\n"
    HEALBOT_WORD_ALWAYS = "항상";
    HEALBOT_WORD_SOLO = "솔로잉";
    HEALBOT_WORD_NEVER = "표시 안함";
    HEALBOT_SHOW_CLASS_AS_ICON = "아이콘";
    HEALBOT_SHOW_CLASS_AS_TEXT = "문자";
HEALBOT_SHOW_ROLE                       = "show role when set";

    HEALBOT_SHOW_INCHEALS = "들어오는 치유 표시";

HEALBOT_HELP={ [1] = "[HealBot] /hb h -- Display help",
               [2] = "[HealBot] /hb o -- Toggles options",
               [3] = "[HealBot] /hb ri -- Reset HealBot",
               [4] = "[HealBot] /hb t -- Toggle Healbot between disabled and enabled",
               [5] = "[HealBot] /hb bt -- Toggle Buff Monitor between disabled and enabled",
               [6] = "[HealBot] /hb dt -- Toggle Debuff Monitor between disabled and enabled",
               [7] = "[HealBot] /hb skin <skinName> -- Switch Skins",
               [8] = "[HealBot] /hb ui -- Reload UI",
               [9] = "[HealBot] /hb hs -- Display additional slash commands",
              }

HEALBOT_HELP2={ [1] = "[HealBot] /hb d -- Reset options to default",
                [2] = "[HealBot] /hb aggro 2 <n> -- Set aggro level 2 on threat percentage <n>",
                [3] = "[HealBot] /hb aggro 3 <n> -- Set aggro level 3 on threat percentage <n>",
                [4] = "[HealBot] /hb tr <Role> -- Set highest role priority for SubSort by Role. Valid Roles are 'TANK', 'HEALER' or 'DPS'",
                [5] = "[HealBot] /hb use10 -- Automatically use Engineering slot 10",
                [6] = "[HealBot] /hb pcs <n> -- Adjust the size of the Holy power charge indicator by <n>, Default value is 7 ",
                [7] = "[HealBot] /hb spt -- Self Pet toggle",
                [8] = "[HealBot] /hb ws -- Toggle Hide/Show the Weaken Soul icon instead of the PW:S with a -",
                [9] = "[HealBot] /hb rld <n> -- In seconds, how long the players name stays green after a res",
                [10] = "[HealBot] /hb flb -- Toggle frame lock bypass (frame always moves with Ctrl+Alt+Left click)",
                [11] = "[HealBot] /hb rtb -- Toggle restrict target bar to Left=SmartCast and Right=add/remove to/from My Targets",
              }
              
    HEALBOT_OPTION_HIGHLIGHTACTIVEBAR = "마우스 오버 강조"
    HEALBOT_OPTION_HIGHLIGHTTARGETBAR = "대상 강조"
    HEALBOT_OPTIONS_TESTBARS = "테스트 바"
    HEALBOT_OPTION_NUMBARS = "바 수"
    HEALBOT_OPTION_NUMTANKS = "방어 담당 수"
    HEALBOT_OPTION_NUMMYTARGETS = "나의 대상 수"
    HEALBOT_OPTION_NUMPETS = "소환수 수"
    HEALBOT_WORD_TEST = "테스트";
    HEALBOT_WORD_OFF = "끔";
    HEALBOT_WORD_ON = "켬";

    HEALBOT_OPTIONS_TAB_PROTECTION = "보호"
    HEALBOT_OPTIONS_TAB_CHAT = "대화"
    HEALBOT_OPTIONS_TAB_HEADERS = "제목"
    HEALBOT_OPTIONS_TAB_BARS = "바들"
    HEALBOT_OPTIONS_TAB_ICONS = "아이콘들"
    HEALBOT_OPTIONS_TAB_WARNING = "경고"
    HEALBOT_OPTIONS_SKINDEFAULTFOR = "기본 스킨"
    HEALBOT_OPTIONS_INCHEAL = "들어오는 치유"
    HEALBOT_WORD_ARENA = "투기장"
    HEALBOT_WORD_BATTLEGROUND = "전장"
    HEALBOT_OPTIONS_TEXTOPTIONS = "문자 옵션"
    HEALBOT_WORD_PARTY = "파티"
    HEALBOT_OPTIONS_COMBOAUTOTARGET = "자동 대상"
    HEALBOT_OPTIONS_COMBOAUTOTRINKET = "자동 장신구"
    HEALBOT_OPTIONS_GROUPSPERCOLUMN = "컬럼 당 그룹 사용"

    HEALBOT_OPTIONS_MAINSORT = "주 정렬"
    HEALBOT_OPTIONS_SUBSORT = "보조 정렬"
    HEALBOT_OPTIONS_SUBSORTINC = "다른 보조 정렬:"

    HEALBOT_OPTIONS_BUTTONCASTMETHOD = "언제 시전"
HEALBOT_OPTIONS_BUTTONCASTPRESSED       = "Pressed"
HEALBOT_OPTIONS_BUTTONCASTRELEASED      = "Released"

HEALBOT_INFO_ADDONCPUUSAGE              = "== Addon CPU Usage in Seconds =="
HEALBOT_INFO_ADDONCOMMUSAGE             = "== Addon Comms Usage =="
HEALBOT_WORD_HEALER                     = "Healer"
HEALBOT_WORD_DAMAGER                    = "Damager"
HEALBOT_WORD_TANK                       = "Tank"
HEALBOT_WORD_LEADER                     = "Leader"
HEALBOT_WORD_VERSION                    = "Version"
HEALBOT_WORD_CLIENT                     = "Client"
HEALBOT_WORD_ADDON                      = "Addon"
HEALBOT_INFO_CPUSECS                    = "CPU Secs"
HEALBOT_INFO_MEMORYMB                   = "Memory MB"
HEALBOT_INFO_COMMS                      = "Comms KB"

    HEALBOT_WORD_STAR = "별"
    HEALBOT_WORD_CIRCLE = "동그라미"
    HEALBOT_WORD_DIAMOND = "다이아몬드"
    HEALBOT_WORD_TRIANGLE = "세모"
    HEALBOT_WORD_MOON = "달"
    HEALBOT_WORD_SQUARE = "네모"
    HEALBOT_WORD_CROSS = "가위표"
    HEALBOT_WORD_SKULL = "해골"

    HEALBOT_OPTIONS_ACCEPTSKINMSG = "[HealBot] 스킨 수락: "
HEALBOT_OPTIONS_ACCEPTSKINMSGFROM = " from "
    HEALBOT_OPTIONS_BUTTONSHARESKIN = "공유"

HEALBOT_CHAT_ADDONID                    = "[HealBot]  "
HEALBOT_CHAT_NEWVERSION1                = "A newer version is available"
HEALBOT_CHAT_NEWVERSION2                = "at "..HEALBOT_ABOUT_URL
HEALBOT_CHAT_SHARESKINERR1              = " Skin not found for Sharing"
HEALBOT_CHAT_SHARESKINERR3              = " not found for Skin Sharing"
HEALBOT_CHAT_SHARESKINACPT              = "Share Skin accepted from "
HEALBOT_CHAT_CONFIRMSKINDEFAULTS        = "Skins set to Defaults"
HEALBOT_CHAT_CONFIRMCUSTOMDEFAULTS      = "Custom Debuffs reset"
    HEALBOT_CHAT_CHANGESKINERR1 = "알 수 없는 스킨: /hb skin "
    HEALBOT_CHAT_CHANGESKINERR2 = "Valid 스킨:  "
HEALBOT_CHAT_CONFIRMSPELLCOPY           = "Current spells copied for all specs"
HEALBOT_CHAT_UNKNOWNCMD                 = "Unknown slash command: /hb "
HEALBOT_CHAT_ENABLED                    = "Entering enabled state"
HEALBOT_CHAT_DISABLED                   = "Entering disabled state"
HEALBOT_CHAT_SOFTRELOAD                 = "Reload healbot requested"
HEALBOT_CHAT_HARDRELOAD                 = "Reload UI requested"
HEALBOT_CHAT_CONFIRMSPELLRESET          = "Spells have been reset"
HEALBOT_CHAT_CONFIRMCURESRESET          = "Cures have been reset"
HEALBOT_CHAT_CONFIRMBUFFSRESET          = "Buffs have been reset"
HEALBOT_CHAT_POSSIBLEMISSINGMEDIA       = "Unable to receive all Skin settings - Possibly missing SharedMedia, download from curse.com"
HEALBOT_CHAT_MACROSOUNDON               = "Sound not suppressed when using auto trinkets"
HEALBOT_CHAT_MACROSOUNDOFF              = "Sound suppressed when using auto trinkets"
HEALBOT_CHAT_MACROERRORON               = "Errors not suppressed when using auto trinkets"
HEALBOT_CHAT_MACROERROROFF              = "Errors suppressed when using auto trinkets"
HEALBOT_CHAT_ACCEPTSKINON               = "Share Skin - Show accept skin popup when someone shares a skin with you"
HEALBOT_CHAT_ACCEPTSKINOFF              = "Share Skin - Always ignore share skins from everyone"
HEALBOT_CHAT_USE10ON                    = "Auto Trinket - Use10 is on - You must enable an existing auto trinket for use10 to work"
HEALBOT_CHAT_USE10OFF                   = "Auto Trinket - Use10 is off"
HEALBOT_CHAT_SKINREC                    = " skin received from " 

    HEALBOT_OPTIONS_SELFCASTS = "자신의 시전만"
    HEALBOT_OPTIONS_HOTSHOWICON = "아이콘 표시"
    HEALBOT_OPTIONS_ALLSPELLS = "모든 주문들"
    HEALBOT_OPTIONS_DOUBLEROW = "두줄"
    HEALBOT_OPTIONS_HOTBELOWBAR = "바 아래"
    HEALBOT_OPTIONS_OTHERSPELLS = "기타 주문들"
    HEALBOT_WORD_MACROS = "매크로"
    HEALBOT_WORD_SELECT = "선택"
    HEALBOT_OPTIONS_QUESTION = "?"
    HEALBOT_WORD_CANCEL = "취소"
    HEALBOT_WORD_COMMANDS = "명령"
    HEALBOT_OPTIONS_BARHEALTH3 = "생명력";
    HEALBOT_SORTBY_ROLE = "역할"
HEALBOT_WORD_DPS                        = "DPS"
HEALBOT_CHAT_TOPROLEERR                 = " role not valid in this context - use 'TANK', 'DPS' or 'HEALER'"
HEALBOT_CHAT_NEWTOPROLE                 = "Highest top role is now "
HEALBOT_CHAT_SUBSORTPLAYER1             = "Player will be set to first in SubSort"
HEALBOT_CHAT_SUBSORTPLAYER2             = "Player will be sorted normally in SubSort"
    HEALBOT_OPTIONS_SHOWREADYCHECK = "공격대 준비 표시";
    HEALBOT_OPTIONS_SUBSORTSELFFIRST = "자신 첫째"
    HEALBOT_WORD_FILTER = "필터"
    HEALBOT_OPTION_AGGROPCTBAR = "바 이동"
    HEALBOT_OPTION_AGGROPCTTXT = "문자 표시"
    HEALBOT_OPTION_AGGROPCTTRACK = "백분율 추적"
HEALBOT_OPTIONS_ALERTAGGROLEVEL1        = "1 - Low threat"
HEALBOT_OPTIONS_ALERTAGGROLEVEL2        = "2 - High threat"
HEALBOT_OPTIONS_ALERTAGGROLEVEL3        = "3 - Tanking"
    HEALBOT_OPTIONS_AGGROALERT = "어그로 경고 레벨"
HEALBOT_OPTIONS_AGGROINDALERT           = "Indicator alert level"
    HEALBOT_OPTIONS_TOOLTIPSHOWHOT = "활성화된 HOT 품질 모니터 표시"
    HEALBOT_WORDS_MIN = "분"
    HEALBOT_WORDS_MAX = "최대"
    HEALBOT_CHAT_SELFPETSON = "자신의 소환수 켬"
    HEALBOT_CHAT_SELFPETSOFF = "자신의 소환수 끔"
    HEALBOT_WORD_PRIORITY = "우선 순위"
    HEALBOT_VISIBLE_RANGE = "100미터 안"
    HEALBOT_SPELL_RANGE = "주문 거리 안"
    HEALBOT_WORD_RESET = "초기화"
    HEALBOT_HBMENU = "HB 메뉴"
    HEALBOT_ACTION_HBFOCUS = "왼쪽 클릭시\n주시 대상 설정"
    HEALBOT_WORD_CLEAR = "제거"
    HEALBOT_WORD_SET = "세트"
    HEALBOT_WORD_HBFOCUS = "HealBot 주시"
    HEALBOT_WORD_OUTSIDE = "외부"
    HEALBOT_WORD_ALLZONE = "모든 지역"
    HEALBOT_OPTIONS_TAB_ALERT = "경고"
    HEALBOT_OPTIONS_TAB_SORT = "종류"
HEALBOT_OPTIONS_TAB_HIDE                = "Hide"
    HEALBOT_OPTIONS_TAB_AGGRO = "어그로"
    HEALBOT_OPTIONS_TAB_ICONTEXT = "아이콘 문자"
    HEALBOT_OPTIONS_TAB_TEXT = "바 문자"
    HEALBOT_OPTIONS_AGGRO3COL = "안전한\n탱킹"
    HEALBOT_OPTIONS_AGGROFLASHFREQ = "반짝임 빈도"
    HEALBOT_OPTIONS_AGGROFLASHALPHA = "투명도 빈도"
    HEALBOT_OPTIONS_SHOWDURATIONFROM = "지속시간 표시"
    HEALBOT_OPTIONS_SHOWDURATIONWARN = "지속시간 만료 경고"
    HEALBOT_CMD_RESETCUSTOMDEBUFFS = "사용자 디버프들 초기화"
    HEALBOT_CMD_RESETSKINS = "스킨 초기화"
    HEALBOT_CMD_CLEARBLACKLIST = "블랙리스트 제거"
    HEALBOT_CMD_TOGGLEACCEPTSKINS = "다른 스킨 수락 토글"
HEALBOT_CMD_TOGGLEDISLIKEMOUNT          = "Toggle Dislike Mount"
HEALBOT_OPTION_DISLIKEMOUNT_ON          = "Now Dislike Mount"
HEALBOT_OPTION_DISLIKEMOUNT_OFF         = "No longer Dislike Mount"
    HEALBOT_CMD_COPYSPELLS = "현재 주문 모든 특성에 복사"
    HEALBOT_CMD_RESETSPELLS = "주문들 초기화"
    HEALBOT_CMD_RESETCURES = "치료 초기화"
    HEALBOT_CMD_RESETBUFFS = "버프들 초기화"
    HEALBOT_CMD_RESETBARS = "바 위치 초기화"
    HEALBOT_CMD_SUPPRESSSOUND = "자동 장신구 사용 효과음 억제 토글"
    HEALBOT_CMD_SUPPRESSERRORS = "자동 장신구 사용 오류 억제토글"
    HEALBOT_OPTIONS_COMMANDS = "HealBot 명령어"
    HEALBOT_WORD_RUN = "실행"
    HEALBOT_OPTIONS_MOUSEWHEEL = "마우스 휠 메뉴"
HEALBOT_OPTIONS_MOUSEUP                 = "Wheel up"
HEALBOT_OPTIONS_MOUSEDOWN               = "Wheel down"
    HEALBOT_CMD_DELCUSTOMDEBUFF10 = "우선 순위 10개의 사용자 디버프들 삭제"
    HEALBOT_ACCEPTSKINS = "기타 스킨 수락"
    HEALBOT_SUPPRESSSOUND = "자동 장신구: 효과음 억제"
    HEALBOT_SUPPRESSERROR = "자동 장신구: 오류 억제"
    HEALBOT_OPTIONS_CRASHPROT = "충돌 보호"
    HEALBOT_OPTIONS_USEGENERALMACRO = "Use general macro slots"
    HEALBOT_CP_MACRO_LEN = "매크로 이름은 1~14 글자 사이여야 합니다."
    HEALBOT_CP_MACRO_BASE = "기본 매크로 이름"
    HEALBOT_CP_MACRO_SAVE = "마지막 저장: "
    HEALBOT_CP_STARTTIME = "로그인시 지속시간 보호"
    HEALBOT_WORD_RESERVED = "예약"
    HEALBOT_OPTIONS_COMBATPROT = "전투 보호"
    HEALBOT_COMBATPROT_PARTYNO = "파티 대비 예약 바"
    HEALBOT_COMBATPROT_RAIDNO = "공격대 대비 예약 바"

    HEALBOT_WORD_HEALTH = "생명력"
    HEALBOT_OPTIONS_DONT_SHOW = "표시 안함"
    HEALBOT_OPTIONS_SAME_AS_HLTH_CURRENT = "생명력과 같이 (현재 생명력)"
    HEALBOT_OPTIONS_SAME_AS_HLTH_FUTURE = "생명력과 같이 (향후 생명력)"
    HEALBOT_OPTIONS_FUTURE_HLTH = "향후 생명력"
    HEALBOT_SKIN_HEALTHBARCOL_TEXT = "생명력 바 색상";
HEALBOT_SKIN_HEALTHBACKCOL_TEXT         = "Background bar";
    HEALBOT_SKIN_INCHEALBARCOL_TEXT = "들어오는 치유 색상";
    HEALBOT_OPTIONS_ALWAYS_SHOW_TARGET = "대상: 항상 표시"
    HEALBOT_OPTIONS_ALWAYS_SHOW_FOCUS = "주시: 항상 표시"
HEALBOT_OPTIONS_GROUP_PETS_BY_FIVE      = "Pets: Groups of five"
    HEALBOT_OPTIONS_USEGAMETOOLTIP = "게임 툴팁 사용"
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
HEALBOT_OPTION_ADJUST_MAX_HEALTH        = "Adjust unit max health"

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

    HEALBOT_CUSTOM_CATEGORY = "목록"
    HEALBOT_CUSTOM_CAT_CUSTOM = "사용자"
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

HEALBOT_ABOUT_DESC1                    = "Add a panel with skinable bars for healing, decursive, buffing, ressing and aggro tracking"
HEALBOT_ABOUT_WEBSITE                  = "Website:"
HEALBOT_ABOUT_AUTHORH                  = "Author:"
HEALBOT_ABOUT_AUTHORD                  = "Strife"
HEALBOT_ABOUT_CATH                     = "Category:"
HEALBOT_ABOUT_CATD                     = "Unit Frames, Buffs and Debuffs, Combat:Healer"
HEALBOT_ABOUT_CREDITH                  = "Credits:"
HEALBOT_ABOUT_CREDITD                  = "Acirac, Kubik, Von, Aldetal, Brezza, CT, Moonlight Han Xing"  -- Anyone taking on translations (if required), feel free to add yourself here.
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
