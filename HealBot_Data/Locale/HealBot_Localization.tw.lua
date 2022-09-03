-- Taiwanese translator required

---------------
-- TAIWANESE --
---------------
--
-- 
--


function HealBot_Lang_zhTW()

-----------------
-- Translation --
-----------------

-- Class
HEALBOT_DRUID   = "德魯伊";
HEALBOT_HUNTER  = "獵人";
HEALBOT_MAGE    = "法師";
HEALBOT_PALADIN = "聖騎士";
HEALBOT_PRIEST  = "牧師";
HEALBOT_ROGUE   = "潛行者";
HEALBOT_SHAMAN  = "薩滿祭司";
HEALBOT_WARLOCK = "術士";
HEALBOT_WARRIOR = "戰士";
HEALBOT_DEATHKNIGHT = "死亡騎士";
HEALBOT_MONK  = "武僧";

HEALBOT_DISEASE            = "疾病";
HEALBOT_MAGIC              = "魔法";
HEALBOT_CURSE              = "詛咒";
HEALBOT_POISON             = "中毒";

HB_TOOLTIP_OFFLINE = "離線";
HB_OFFLINE        = "離線";
HB_ONLINE         = "線上";

HEALBOT_HEALBOT     = "HealBot";
HEALBOT_ADDON       = HEALBOT_HEALBOT .. " " .. HEALBOT_VERSION;
HEALBOT_LOADED      = " 已載入.";

HEALBOT_RANK   = {[1]="(等級 1)", [2]="(等級 2)", [3]="(等級 3)", [4]="(等級 4)", [5]="(等級 5)", [6]="(等級 6)", [7]="(等級 7)",
                  [8]="(等級 8)", [9]="(等級 9)", [10]="(等級 10)", [11]="(等級 11)", [12]="(等級 12)", [13]="(等級 13)"}

HEALBOT_ACTION_OPTIONS        = "設置";

HEALBOT_OPTIONS_TITLE         = "HEALBOT 目錄";
HEALBOT_OPTIONS_DEFAULTS      = "預設";
HEALBOT_OPTIONS_CLOSE         = "關閉";
HEALBOT_OPTIONS_HARDRESET     = "重載UI"
HEALBOT_OPTIONS_SOFTRESET     = "重載HB"
HEALBOT_OPTIONS_TAB_GENERAL   = "綜合";
HEALBOT_OPTIONS_TAB_SPELLS    = "法術";
HEALBOT_OPTIONS_TAB_HEALING   = "治療";
HEALBOT_OPTIONS_TAB_SKIN      = "樣式";
HEALBOT_OPTIONS_TAB_TIPS      = "提示";
HEALBOT_OPTIONS_TAB_BUFFS     = "增益"

HEALBOT_OPTIONS_SKINAUTHOR              = "樣式條作者:"
HEALBOT_OPTIONS_AVOIDBLUECURSOR         = "防止藍\n色滑鼠"
HEALBOT_PLAYER_OF_REALM                  = "的"

HEALBOT_OPTIONS_BARALPHA      = "樣式條透明度";
HEALBOT_OPTIONS_BARALPHAINHEAL= "進入治療狀態時透明度";
HEALBOT_OPTIONS_BARALPHABACK  = "樣式條背景不透明度";
HEALBOT_OPTIONS_BARALPHAEOR   = "超出範圍透明度";
HEALBOT_OPTIONS_ACTIONLOCKED  = "鎖定";
HEALBOT_OPTIONS_AUTOSHOW      = "自動關閉顯示";
HEALBOT_OPTIONS_PANELSOUNDS   = "使用聲音提示";
HEALBOT_OPTIONS_HIDEOPTIONS   = "隱藏設置按鈕";
HEALBOT_OPTIONS_PROTECTPVP    = "防止意外進入PVP狀態";
HEALBOT_OPTIONS_HEAL_CHATOPT  = "聊天選項";

HEALBOT_OPTIONS_FRAMESCALE    = "框架比例"
HEALBOT_OPTIONS_SKINTEXT      = "皮膚"
HEALBOT_SKINS_STD             = "標準"
HEALBOT_OPTIONS_SKINTEXTURE   = "材質"
HEALBOT_OPTIONS_SKINHEIGHT    = "高度"
HEALBOT_OPTIONS_SKINWIDTH     = "寬度"
HEALBOT_OPTIONS_SKINNUMCOLS   = "佇列數量"
HEALBOT_OPTIONS_SKINNUMHCOLS  = "每列小隊數量"
HEALBOT_OPTIONS_SKINBRSPACE   = "行距離"
HEALBOT_OPTIONS_SKINBCSPACE   = "列距離"
HEALBOT_OPTIONS_EXTRASORT     = "排列方式"
HEALBOT_SORTBY_NAME           = "名字"
HEALBOT_SORTBY_CLASS          = "職業"
HEALBOT_SORTBY_GROUP          = "小隊"
HEALBOT_SORTBY_MAXHEALTH      = "最大生命值"
HEALBOT_OPTIONS_NEWDEBUFFTEXT = "新 Debuff"
HEALBOT_OPTIONS_DELSKIN       = "刪除"
HEALBOT_OPTIONS_NEWSKINTEXT   = "新皮膚"
HEALBOT_OPTIONS_SAVESKIN      = "保存"
HEALBOT_OPTIONS_SKINBARS      = "樣式條皮膚選項"
HEALBOT_SKIN_ENTEXT           = "啟用"
HEALBOT_SKIN_DISTEXT          = "禁用"
HEALBOT_SKIN_DEBTEXT          = "Debuff"
HEALBOT_SKIN_BACKTEXT         = "背景顏色"
HEALBOT_SKIN_BORDERTEXT       = "邊框顏色"
HEALBOT_OPTIONS_SKINFONT      = "字體"
HEALBOT_OPTIONS_SKINFHEIGHT   = "字體尺寸"
HEALBOT_OPTIONS_SKINFOUTLINE  = "字體輪廓"
HEALBOT_OPTIONS_BARALPHADIS   = "禁用透明度"
HEALBOT_OPTIONS_SHOWHEADERS   = "顯示標題頭"

HEALBOT_OPTIONS_ITEMS         = "物品";

HEALBOT_OPTIONS_COMBOCLASS    = "組合鍵設置";
HEALBOT_OPTIONS_CLICK         = "點擊";
HEALBOT_OPTIONS_SHIFT         = "Shift";
HEALBOT_OPTIONS_CTRL          = "Ctrl";
HEALBOT_OPTIONS_ENABLEHEALTHY = "總是使用已啟用的設置";

HEALBOT_OPTIONS_CASTNOTIFY1   = "無信息";
HEALBOT_OPTIONS_CASTNOTIFY2   = "通知自己";
HEALBOT_OPTIONS_CASTNOTIFY3   = "通知目標";
HEALBOT_OPTIONS_CASTNOTIFY4   = "通知隊伍";
HEALBOT_OPTIONS_CASTNOTIFY5   = "通知團隊";
HEALBOT_OPTIONS_CASTNOTIFY6   = "通知頻道";
HEALBOT_OPTIONS_CASTNOTIFYRESONLY = "只在復活目標發出資訊";

HEALBOT_OPTIONS_CDCBARS       = "顏色設置";
HEALBOT_OPTIONS_CDCSHOWHBARS  = "顯示生命條";
HEALBOT_OPTIONS_CDCSHOWABARS  = "顯示仇恨條";
HEALBOT_OPTIONS_CDCWARNINGS   = "Debuff 警報";
HEALBOT_OPTIONS_SHOWDEBUFFICON = "Debuff 圖示";
HEALBOT_OPTIONS_SHOWDEBUFFWARNING = "有 Debuff 時顯示警告";
HEALBOT_OPTIONS_SOUNDDEBUFFWARNING = "有 Debuff 時聲音提示";
HEALBOT_OPTIONS_SOUND         = "聲音"

HEALBOT_OPTIONS_HEAL_BUTTONS  = "治療樣式條選項";
HEALBOT_OPTIONS_SELFHEALS     = "自我"
HEALBOT_OPTIONS_PETHEALS      = "寵物"
HEALBOT_OPTIONS_GROUPHEALS    = "小隊";
HEALBOT_OPTIONS_TANKHEALS     = "主坦克";
HEALBOT_OPTIONS_MAINASSIST    = "主協助";
HEALBOT_OPTIONS_PRIVATETANKS  = "副坦克";
HEALBOT_OPTIONS_TARGETHEALS   = "目標";
HEALBOT_OPTIONS_EMERGENCYHEALS= "團隊";
HEALBOT_OPTIONS_ALERTLEVEL    = "警報等級";
HEALBOT_OPTIONS_EMERGFILTER   = "設置團隊框架";
HEALBOT_OPTIONS_EMERGFCLASS   = "設置職業";
HEALBOT_OPTIONS_COMBOBUTTON   = "按鈕";
HEALBOT_OPTIONS_BUTTONLEFT    = "左";
HEALBOT_OPTIONS_BUTTONMIDDLE  = "中";
HEALBOT_OPTIONS_BUTTONRIGHT   = "右";
HEALBOT_OPTIONS_BUTTON4       = "按鈕4";
HEALBOT_OPTIONS_BUTTON5       = "按鈕5";
HEALBOT_OPTIONS_BUTTON6       = "按鈕6";
HEALBOT_OPTIONS_BUTTON7       = "按鈕7";
HEALBOT_OPTIONS_BUTTON8       = "按鈕8";
HEALBOT_OPTIONS_BUTTON9       = "按鈕9";
HEALBOT_OPTIONS_BUTTON10      = "按鈕10";
HEALBOT_OPTIONS_BUTTON11      = "按鈕11";
HEALBOT_OPTIONS_BUTTON12      = "按鈕12";
HEALBOT_OPTIONS_BUTTON13      = "按鈕13";
HEALBOT_OPTIONS_BUTTON14      = "按鈕14";
HEALBOT_OPTIONS_BUTTON15      = "按鈕15";

HEALBOT_CLASSES_ALL     = "所有職業";
HEALBOT_CLASSES_MELEE   = "近戰";
HEALBOT_CLASSES_RANGES  = "遠程";
HEALBOT_CLASSES_HEALERS = "治療";
HEALBOT_CLASSES_CUSTOM  = "定制";

HEALBOT_OPTIONS_SHOWTOOLTIP     = "顯示提示";
HEALBOT_OPTIONS_SHOWDETTOOLTIP  = "顯示詳細法術資訊";
HEALBOT_OPTIONS_SHOWCDTOOLTIP   = "顯示冷卻時間";
HEALBOT_OPTIONS_SHOWUNITTOOLTIP = "顯示目標資訊";
HEALBOT_OPTIONS_SHOWRECTOOLTIP  = "顯示治療結束時間的建議";
HEALBOT_TOOLTIP_POSDEFAULT      = "本地預設";
HEALBOT_TOOLTIP_POSLEFT         = "Healbot左邊";
HEALBOT_TOOLTIP_POSRIGHT        = "Healbot右邊";
HEALBOT_TOOLTIP_POSABOVE        = "Healbot上部";
HEALBOT_TOOLTIP_POSBELOW        = "Healbot下部";
HEALBOT_TOOLTIP_POSCURSOR       = "滑鼠下方";
HEALBOT_TOOLTIP_RECOMMENDTEXT   = "治療結束時間的建議";
HEALBOT_TOOLTIP_NONE            = "無可用";
HEALBOT_TOOLTIP_CORPSE          = "屍體";
HEALBOT_TOOLTIP_CD              = " (CD ";
HEALBOT_TOOLTIP_SECS            = "s)";
HEALBOT_WORDS_SEC               = "秒";
HEALBOT_WORDS_CAST              = "施放時間";
HEALBOT_WORDS_UNKNOWN           = "未知";
HEALBOT_WORDS_YES               = "是";
HEALBOT_WORDS_NO                = "否";
HEALBOT_WORDS_THIN              = "細";
HEALBOT_WORDS_THICK             = "粗";

HEALBOT_WORDS_NONE              = "空";
HEALBOT_OPTIONS_ALT             = "Alt";
HEALBOT_DISABLED_TARGET         = "目標";
HEALBOT_OPTIONS_SHOWCLASSONBAR  = "顯示職業名稱";
HEALBOT_OPTIONS_SHOWHEALTHONBAR = "顯示生命值";
HEALBOT_OPTIONS_BARHEALTHINCHEALS = "包含進入治療";
HEALBOT_OPTIONS_BARHEALTHSEPHEALS = "分離進入治療";
HEALBOT_OPTIONS_BARHEALTH1      = "顯示數值";
HEALBOT_OPTIONS_BARHEALTH2      = "顯示百分比";
HEALBOT_OPTIONS_TIPTEXT         = "提示資訊";
HEALBOT_OPTIONS_POSTOOLTIP      = "職責提示";
HEALBOT_OPTIONS_SHOWNAMEONBAR   = "顯示玩家名";
HEALBOT_OPTIONS_BARTEXTCLASSCOLOUR1 = "玩家名著色";
HEALBOT_OPTIONS_EMERGFILTERGROUPS   = "包含團隊小隊";

HEALBOT_ONE   = "1";
HEALBOT_TWO   = "2";
HEALBOT_THREE = "3";
HEALBOT_FOUR  = "4";
HEALBOT_FIVE  = "5";
HEALBOT_SIX   = "6";
HEALBOT_SEVEN = "7";
HEALBOT_EIGHT = "8";

HEALBOT_OPTIONS_SETDEFAULTS    = "設置默認";
HEALBOT_OPTIONS_SETDEFAULTSMSG = "恢復所有設置為預設值";
HEALBOT_OPTIONS_RIGHTBOPTIONS  = "右擊圖示打開設置面板";

HEALBOT_OPTIONS_HEADEROPTTEXT  = "標題選項";
HEALBOT_OPTIONS_ICONOPTTEXT    = "圖示選項";
HEALBOT_SKIN_HEADERBARCOL      = "樣式條顏色";
HEALBOT_SKIN_HEADERTEXTCOL     = "文本顏色";
HEALBOT_OPTIONS_BUFFSTEXT1      = "Buff 法術";
HEALBOT_OPTIONS_BUFFSTEXT2      = "檢查範圍";
HEALBOT_OPTIONS_BUFFSTEXT3      = "樣式條顏色";
HEALBOT_OPTIONS_BUFF           = "Buff ";
HEALBOT_OPTIONS_BUFFSELF       = "對自身";
HEALBOT_OPTIONS_BUFFPARTY      = "對小隊";
HEALBOT_OPTIONS_BUFFRAID       = "對團隊";
HEALBOT_OPTIONS_MONITORBUFFS   = "監測缺少 Buff";
HEALBOT_OPTIONS_MONITORBUFFSC  = "戰鬥中監測";
HEALBOT_OPTIONS_ENABLESMARTCAST  = "當結束戰鬥啟用智能施法";
HEALBOT_OPTIONS_SMARTCASTSPELLS  = "包含法術:";
HEALBOT_OPTIONS_SMARTCASTDISPELL = "解除 Debuff";
HEALBOT_OPTIONS_SMARTCASTBUFF    = "增加 Buff";
HEALBOT_OPTIONS_SMARTCASTHEAL    = "治療法術";
HEALBOT_OPTIONS_BAR2SIZE         = "法力條尺寸";
HEALBOT_OPTIONS_SETSPELLS        = "設置法術";
HEALBOT_OPTIONS_ENABLEDBARS     = "總是啟用樣式條";
HEALBOT_OPTIONS_DISABLEDBARS    = "忽略時間極短的 Debuff";
HEALBOT_OPTIONS_MONITORDEBUFFS  = "監測 Debuff";
HEALBOT_OPTIONS_DEBUFFTEXT1     = "設置解 Debuff 的技能";

HEALBOT_OPTIONS_IGNOREDEBUFF         = "忽略 Debuff:";
HEALBOT_OPTIONS_IGNOREDEBUFFCLASS    = "不關聯職業";
HEALBOT_OPTIONS_IGNOREDEBUFFMOVEMENT = "減速效果";
HEALBOT_OPTIONS_IGNOREDEBUFFDURATION = "短時間效果";
HEALBOT_OPTIONS_IGNOREDEBUFFNOHARM   = "無害效果";
HEALBOT_OPTIONS_IGNOREDEBUFFCOOLDOWN    = "當治療法術的冷卻時間 > 1.5 秒 (GCD)";
HEALBOT_OPTIONS_IGNOREDEBUFFFRIEND      = "當施法者是友方";

HEALBOT_OPTIONS_RANGECHECKFREQ       = "檢測頻率";

HEALBOT_OPTIONS_HIDEPARTYFRAMES      = "隱藏隊伍框體";
HEALBOT_OPTIONS_HIDEPLAYERTARGET     = "包含玩家和目標";
HEALBOT_OPTIONS_DISABLEHEALBOT       = "禁用HealBot";

HEALBOT_ASSIST      = "協助";
HEALBOT_FOCUS       = "焦點";
HEALBOT_MENU        = "菜單";
HEALBOT_MAINTANK    = "主坦克";
HEALBOT_MAINASSIST  = "主協助";
HEALBOT_STOP        = "停止";
HEALBOT_TELL        = "標記";

HEALBOT_OPTIONS_SHOWMINIMAPBUTTON = "顯示小地圖按鈕";
HEALBOT_OPTIONS_BARBUTTONSHOWHOT  = "Hot 圖示";
HEALBOT_OPTIONS_BARBUTTONSHOWRAIDICON  = "Raid 圖示";
HEALBOT_OPTIONS_HOTONBAR     = "樣式條內"
HEALBOT_OPTIONS_HOTOFFBAR    = "樣式條外"
HEALBOT_OPTIONS_HOTBARRIGHT  = "右邊"
HEALBOT_OPTIONS_HOTBARLEFT   = "左邊"

HEALBOT_ZONE_AB = "阿拉希盆地";
HEALBOT_ZONE_AV = "奧特蘭克山谷";
HEALBOT_ZONE_ES = "風暴之眼";
HEALBOT_ZONE_IC = "冬擁湖";
HEALBOT_ZONE_SA = "遠古海灘";

HEALBOT_OPTION_AGGROTRACK = "仇恨提醒"
HEALBOT_OPTION_AGGROBAR = "閃爍"
HEALBOT_OPTION_AGGROTXT = ">文字<"
HEALBOT_OPTION_AGGROIND                 = "指示符"
HEALBOT_OPTION_BARUPDFREQ = "閃爍頻率"
HEALBOT_OPTION_USEFLUIDBARS = "動態監視"
HEALBOT_OPTION_CPUPROFILE  = "使用CPU性能測試（插件CPU使用資訊）"
HEALBOT_OPTIONS_RELOADUIMSG = "該選項需要重載UI,現在重載?"

HEALBOT_BUFF_PVP              = "PvP"
HEALBOT_BUFF_PVE              = "PvE"
HEALBOT_OPTIONS_ANCHOR        = "錨點"
HEALBOT_OPTIONS_BARSANCHOR    = "樣式條錨點"
HEALBOT_OPTIONS_TOPLEFT       = "左上"
HEALBOT_OPTIONS_BOTTOMLEFT    = "左下"
HEALBOT_OPTIONS_TOPRIGHT      = "右上"
HEALBOT_OPTIONS_BOTTOMRIGHT   = "右下"
HEALBOT_OPTIONS_TOP           = "頂端"
HEALBOT_OPTIONS_BOTTOM        = "底部"

HEALBOT_PANEL_BLACKLIST       = "黑名單"

HEALBOT_WORDS_REMOVEFROM      = "移除";
HEALBOT_WORDS_ADDTO           = "增加";
HEALBOT_WORDS_INCLUDE         = "包含";

HEALBOT_OPTIONS_TTALPHA       = "透明度"
HEALBOT_TOOLTIP_TARGETBAR     = "目標監視條"
HEALBOT_OPTIONS_MYTARGET      = "我的目標"

HEALBOT_DISCONNECTED_TEXT           = "<離線>"
HEALBOT_OPTIONS_SHOWUNITBUFFTIME    = "顯示我的 Buff";
HEALBOT_OPTIONS_TOOLTIPUPDATE       = "不斷刷新";
HEALBOT_OPTIONS_BUFFSTEXTTIMER      = "在 Buff 即將結束時顯示";
HEALBOT_OPTIONS_SHORTBUFFTIMER      = "短 Buff"
HEALBOT_OPTIONS_LONGBUFFTIMER       = "長 Buff"

HEALBOT_OPTIONS_NOTIFY_MSG       = "信息"
HEALBOT_WORDS_YOU                = "你";
HEALBOT_NOTIFYOTHERMSG           = "為#n施放了#s";

HEALBOT_OPTIONS_HOTPOSITION     = "圖示位置"
HEALBOT_OPTIONS_HOTSHOWTEXT     = "圖示文本"
HEALBOT_OPTIONS_HOTTEXTCOUNT    = "次數"
HEALBOT_OPTIONS_HOTTEXTDURATION = "持續時間"
HEALBOT_OPTIONS_ICONSCALE       = "圖示縮放比例"
HEALBOT_OPTIONS_ICONTEXTSCALE   = "圖示文字縮放比例"

HEALBOT_OPTIONS_AGGROBARSIZE    = "OT狀態條尺寸"
HEALBOT_OPTIONS_DOUBLETEXTLINES = "雙行文字"
HEALBOT_OPTIONS_TEXTALIGNMENT   = "文本調整"
HEALBOT_VEHICLE                 = "載具"
HEALBOT_WORDS_ERROR             = "錯誤"
HEALBOT_SPELL_NOT_FOUND         = "找不到法術" 
HEALBOT_OPTIONS_DISABLETOOLTIPINCOMBAT = "戰鬥中隱藏提示"
HEALBOT_OPTIONS_ENABLELIBQH     = "啟用 HealBot 快速治療"

HEALBOT_OPTIONS_BUFFNAMED       = "輸入需要驅散的玩家名字\n\n"
HEALBOT_WORD_ALWAYS             = "總是";
HEALBOT_WORD_SOLO               = "單獨";
HEALBOT_WORD_NEVER              = "從不";
HEALBOT_SHOW_CLASS_AS_ICON      = "職業圖示";
HEALBOT_SHOW_CLASS_AS_TEXT      = "文本文字";
HEALBOT_SHOW_ROLE               = "顯示角色職責";

HEALBOT_SHOW_INCHEALS           = "顯示進入治療";

HEALBOT_HELP={ [1] = "[HealBot] /hb h -- 顯示幫助",
               [2] = "[HealBot] /hb o -- 切換選項",
               [3] = "[HealBot] /hb ri -- 重置 HealBot",
               [4] = "[HealBot] /hb t -- 切換禁用和啟用Healbot",
               [5] = "[HealBot] /hb bt -- 切換禁用和啟用 Buff 監控",
               [6] = "[HealBot] /hb dt -- 切換禁用和啟用 DeBuff 監控",
               [7] = "[HealBot] /hb skin <皮膚名字> -- 切換皮膚",
               [8] = "[HealBot] /hb ui -- 重載 UI",
               [9] = "[HealBot] /hb hs -- 顯示額外的斜杠命令",
              }

HEALBOT_HELP2={ [1] = "[HealBot] /hb d -- 重置為默認選項",
                [2] = "[HealBot] /hb aggro 2 <n> -- 設置仇恨等級 2 在百分之<n>上",
                [3] = "[HealBot] /hb aggro 3 <n> -- 設置仇恨等級 3 在百分之<n>上",
                [4] = "[HealBot] /hb tr <Role> -- 設置最高優先等級排序. 有效的角色是'TANK', 'HEALER' or 'DPS",
                [5] = "[HealBot] /hb use10 -- 自動使用的工程插槽 10",
                [6] = "[HealBot] /hb pcs <n> -- 調整聖能指示器大小為 <n>, 預設值是 7 ",
                [7] = "[HealBot] /hb spt -- 寵物切換",
                [8] = "[HealBot] /hb ws -- 切換隱藏/顯示與削弱靈魂圖示,而不是用 PW:S 與 -",
                [9] = "[HealBot] /hb rld <n> -- 幾秒, 在切換變形之後玩家名字保持綠色的時間",
                [10] = "[HealBot] /hb flb -- 切換框架鎖定旁路 (框架總是使用 Ctrl+Alt+Left 點擊移動)",
                [11] = "[HealBot] /hb rtb -- 切換限制目標欄  左鍵=智慧施法 右鍵=從我的目標添加/刪除",
              }

HEALBOT_OPTION_HIGHLIGHTACTIVEBAR   = "突出顯示滑鼠懸停目標";
HEALBOT_OPTION_HIGHLIGHTTARGETBAR   = "突出顯示當前目標"
HEALBOT_OPTIONS_TESTBARS            = "測試樣式條";
HEALBOT_OPTION_NUMBARS              = "樣式條數目";
HEALBOT_OPTION_NUMTANKS             = "坦克數目";
HEALBOT_OPTION_NUMMYTARGETS         = "目標數目";
HEALBOT_OPTION_NUMHEALERS               = "治療數目"
HEALBOT_OPTION_NUMPETS              = "寵物數目";
HEALBOT_WORD_TEST                   = "測試";
HEALBOT_WORD_OFF                    = "關";
HEALBOT_WORD_ON                     = "開";

HEALBOT_OPTIONS_TAB_CHAT            = "聊天"
HEALBOT_OPTIONS_TAB_HEADERS         = "標題"
HEALBOT_OPTIONS_TAB_BARS            = "樣式條"
HEALBOT_OPTIONS_TAB_ICONS           = "圖示"
HEALBOT_OPTIONS_TAB_WARNING         = "警告"
HEALBOT_OPTIONS_SKINDEFAULTFOR      = "默認皮膚應用於"
HEALBOT_OPTIONS_INCHEAL             = "進入治療"
HEALBOT_WORD_ARENA                  = "競技場"
HEALBOT_WORD_BATTLEGROUND           = "戰場"
HEALBOT_OPTIONS_TEXTOPTIONS         = "文本選項"
HEALBOT_WORD_PARTY                  = "小隊"
HEALBOT_OPTIONS_COMBOAUTOTARGET     = "選定目標"
HEALBOT_OPTIONS_COMBOAUTOTRINKET    = "使用飾品"
HEALBOT_OPTIONS_GROUPSPERCOLUMN     = "按編號分列"

HEALBOT_OPTIONS_MAINSORT            = "主要排序"
HEALBOT_OPTIONS_SUBSORT             = "次要排序"
HEALBOT_OPTIONS_SUBSORTINC          = "其他排序:"

HEALBOT_OPTIONS_BUTTONCASTMETHOD    = "按鍵觸發"
HEALBOT_OPTIONS_BUTTONCASTPRESSED   = "按下"
HEALBOT_OPTIONS_BUTTONCASTRELEASED  = "釋放"

HEALBOT_INFO_ADDONCPUUSAGE          = "== 插件每秒 CPU 佔用率 =="
HEALBOT_INFO_ADDONCOMMUSAGE         = "== 插件通信使用 =="
HEALBOT_WORD_HEALER                 = "治療"
HEALBOT_WORD_DAMAGER                = "輸出"
HEALBOT_WORD_TANK                   = "坦克"
HEALBOT_WORD_LEADER                 = "領隊"
HEALBOT_WORD_VERSION                = "插件版本"
HEALBOT_WORD_CLIENT                 = "用戶端"
HEALBOT_WORD_ADDON                  = "插件"
HEALBOT_INFO_CPUSECS                = "CPU 每秒"
HEALBOT_INFO_MEMORYKB               = "記憶體 KB"
HEALBOT_INFO_COMMS                  = "通信 KB"

HEALBOT_WORD_STAR                   = "星星"
HEALBOT_WORD_CIRCLE                 = "圓形"
HEALBOT_WORD_DIAMOND                = "菱形"
HEALBOT_WORD_TRIANGLE               = "三角"
HEALBOT_WORD_MOON                   = "月亮"
HEALBOT_WORD_SQUARE                 = "方塊"
HEALBOT_WORD_CROSS                  = "十字"
HEALBOT_WORD_SKULL                  = "骷髏"

HEALBOT_OPTIONS_ACCEPTSKINMSG       = "接受 [HealBot] 皮膚: "
HEALBOT_OPTIONS_ACCEPTSKINMSGFROM   = " 從 "
HEALBOT_OPTIONS_BUTTONSHARESKIN     = "共用"

HEALBOT_CHAT_ADDONID                = "[HealBot]"
HEALBOT_CHAT_NEWVERSION1            = "有新的可用版本"
HEALBOT_CHAT_NEWVERSION2            = "在 "..HEALBOT_ABOUT_URL
HEALBOT_CHAT_SHARESKINERR1          = " 共用中沒有發現皮膚"
HEALBOT_CHAT_SHARESKINERR3          = " 沒有發現共用皮膚"
HEALBOT_CHAT_SHARESKINACPT          = "接受共用皮膚 "
HEALBOT_CHAT_CONFIRMSKINDEFAULTS    = "皮膚設置為默認"
HEALBOT_CHAT_CONFIRMCUSTOMDEFAULTS  = "重置自定義 Debuffs"
HEALBOT_CHAT_CHANGESKINERR1         = "未知皮膚: /hb skin "
HEALBOT_CHAT_CHANGESKINERR2         = "應用皮膚:  "
HEALBOT_CHAT_CONFIRMSPELLCOPY       = "當前法術複製到所有規範"
HEALBOT_CHAT_UNKNOWNCMD             = "未知的命令: /hb "
HEALBOT_CHAT_ENABLED                = "進入開啟狀態"
HEALBOT_CHAT_DISABLED               = "進入禁用狀態"
HEALBOT_CHAT_SOFTRELOAD             = "請求重載 HealBot"
HEALBOT_CHAT_HARDRELOAD             = "請求重載 UI"
HEALBOT_CHAT_CONFIRMSPELLRESET      = "法術已經重置"
HEALBOT_CHAT_CONFIRMCURESRESET      = "治療已經重置"
HEALBOT_CHAT_CONFIRMBUFFSRESET      = "Buffs 已經重置"
HEALBOT_CHAT_POSSIBLEMISSINGMEDIA   = "不能接受皮膚設置,可能是SharedMedia丟失,請參閱HealBot/Docs/readme.html 鏈結"
HEALBOT_CHAT_MACROSOUNDON           = "自動使用飾品狀態不取消聲音"
HEALBOT_CHAT_MACROSOUNDOFF          = "自動使用飾品狀態時取消聲音"
HEALBOT_CHAT_MACROERRORON           = "自動使用飾品狀態不取消錯誤資訊"
HEALBOT_CHAT_MACROERROROFF          = "自動使用飾品狀態取消錯誤資訊"
HEALBOT_CHAT_ACCEPTSKINON           = "共用皮膚 - 顯示其他人的共用皮膚彈出視窗"
HEALBOT_CHAT_ACCEPTSKINOFF          = "共用皮膚 - 總是忽略其他人的皮膚共用"
HEALBOT_CHAT_USE10ON                = "自動使用飾品 - 用 10 表示開啟 - 你必須使用現有的飾品"
HEALBOT_CHAT_USE10OFF               = "自動使用飾品 - 用 10 表示關閉"
HEALBOT_CHAT_SKINREC                = "皮膚收到自:" 

HEALBOT_OPTIONS_SELFCASTS           = "僅自己施放的"
HEALBOT_OPTIONS_HOTSHOWICON         = "顯示圖示"
HEALBOT_OPTIONS_ALLSPELLS           = "所有法術"
HEALBOT_OPTIONS_DOUBLEROW           = "雙列"
HEALBOT_OPTIONS_HOTBELOWBAR         = "樣式條下麵"
HEALBOT_OPTIONS_OTHERSPELLS         = "其他法術"
HEALBOT_WORD_MACROS                 = "宏"
HEALBOT_WORD_SELECT                 = "選擇"
HEALBOT_OPTIONS_QUESTION            = "?"
HEALBOT_WORD_CANCEL                 = "取消"
HEALBOT_WORD_COMMANDS               = "命令"
HEALBOT_OPTIONS_BARHEALTH3          = "按血量"
HEALBOT_SORTBY_ROLE                     = "角色"
HEALBOT_WORD_DPS                        = "輸出"
HEALBOT_CHAT_TOPROLEERR                 = "角色無效 - 使用 'TANK', 'HEALER' 或者 'DPS"
HEALBOT_CHAT_NEWTOPROLE                 = "現在是最高等級角色 "
HEALBOT_CHAT_SUBSORTPLAYER1             = "玩家將會被設置為第一優先次序"
HEALBOT_CHAT_SUBSORTPLAYER2             = "玩家將會被設置為正常優先次序"
HEALBOT_OPTIONS_SHOWREADYCHECK          = "就位檢查圖示";
HEALBOT_OPTIONS_SUBSORTSELFFIRST        = "優先自己"
HEALBOT_WORD_FILTER                     = "過濾"
HEALBOT_OPTION_AGGROPCTBAR              = "高亮血量條"
HEALBOT_OPTION_AGGROPCTTXT              = "顯示文本"
HEALBOT_OPTION_AGGROPCTTRACK            = "追蹤百分比" 
HEALBOT_OPTIONS_ALERTAGGROLEVEL1        = "1 - 低仇恨"
HEALBOT_OPTIONS_ALERTAGGROLEVEL2        = "2 - 高仇恨"
HEALBOT_OPTIONS_ALERTAGGROLEVEL3        = "3 - 坦克"
HEALBOT_OPTIONS_AGGROALERT              = "狀態條警告級別"
HEALBOT_OPTIONS_AGGROINDALERT           = "指示符警告級別"
HEALBOT_OPTIONS_TOOLTIPSHOWHOT          = "監視顯示詳細 Hot 資訊"
HEALBOT_WORDS_MIN                       = "最低"
HEALBOT_WORDS_MAX                       = "最高"
HEALBOT_CHAT_SELFPETSON                 = "寵物自動攻擊開啟"
HEALBOT_CHAT_SELFPETSOFF                = "寵物自動攻擊關閉"
HEALBOT_WORD_PRIORITY                   = "優先"
HEALBOT_VISIBLE_RANGE                   = "在100碼內"
HEALBOT_SPELL_RANGE                     = "在法術距離範圍內"
HEALBOT_WORD_RESET                      = "重置"
HEALBOT_HBMENU                          = "HealBot 菜單"
HEALBOT_ACTION_HBFOCUS                  = "左鍵點擊設置\n焦點目標"
HEALBOT_WORD_CLEAR                      = "清除"
HEALBOT_WORD_SET                        = "設置"
HEALBOT_WORD_HBFOCUS                    = "HealBot 焦點"
HEALBOT_WORD_OUTSIDE                    = "外面"
HEALBOT_WORD_ALLZONE                    = "所有區域"
HEALBOT_OPTIONS_TAB_ALERT               = "警告"
HEALBOT_OPTIONS_TAB_SORT                = "排序"
HEALBOT_OPTIONS_TAB_HIDE                = "隱藏"
HEALBOT_OPTIONS_TAB_AGGRO               = "仇恨"
HEALBOT_OPTIONS_TAB_ICONTEXT            = "圖示文本"
HEALBOT_OPTIONS_TAB_TEXT                = "樣式條文本"
HEALBOT_OPTIONS_AGGRO3COL               = "仇恨欄\n顏色"
HEALBOT_OPTIONS_AGGROFLASHFREQ          = "閃爍頻率"
HEALBOT_OPTIONS_AGGROFLASHALPHA         = "閃爍不透明度"
HEALBOT_OPTIONS_SHOWDURATIONFROM        = "顯示持續時間"
HEALBOT_OPTIONS_SHOWDURATIONWARN        = "時間警告"
HEALBOT_CMD_RESETCUSTOMDEBUFFS          = "重置自定 Debuffs"
HEALBOT_CMD_RESETSKINS                  = "重置皮膚"
HEALBOT_CMD_CLEARBLACKLIST              = "清除黑名單"
HEALBOT_CMD_TOGGLEACCEPTSKINS           = "切換接受其他人共用皮膚"
HEALBOT_CMD_TOGGLEDISLIKEMOUNT          = "切換載具"
HEALBOT_OPTION_DISLIKEMOUNT_ON          = "在載具上"
HEALBOT_OPTION_DISLIKEMOUNT_OFF         = "不在載具"
HEALBOT_CMD_COPYSPELLS                  = "複製當前法術到所有欄目"
HEALBOT_CMD_RESETSPELLS                 = "重置法術"
HEALBOT_CMD_RESETCURES                  = "重置治療"
HEALBOT_CMD_RESETBUFFS                  = "重置 Buffs"
HEALBOT_CMD_RESETBARS                   = "重置樣式條位置"
HEALBOT_CMD_SUPPRESSSOUND               = "切換自動飾品時的聲音"
HEALBOT_CMD_SUPPRESSERRORS              = "切換自動飾品時的錯誤提示"
HEALBOT_OPTIONS_COMMANDS                = "HealBot 命令"
HEALBOT_WORD_RUN                        = "運行"
HEALBOT_OPTIONS_MOUSEWHEEL              = "滑鼠滾輪功能表"
HEALBOT_OPTIONS_MOUSEUP                 = "向上滾動"
HEALBOT_OPTIONS_MOUSEDOWN               = "向下滾動"
HEALBOT_CMD_DELCUSTOMDEBUFF10           = "刪除自定 Debuffs 優先順序 10"
HEALBOT_ACCEPTSKINS                     = "接受他人皮膚"
HEALBOT_SUPPRESSSOUND                   = "自動飾品: 禁止聲音"
HEALBOT_SUPPRESSERROR                   = "自動飾品: 禁用錯誤提示"
HEALBOT_OPTIONS_CRASHPROT               = "緊急存儲"
HEALBOT_OPTIONS_USEGENERALMACRO         = "Use general macro slots"
HEALBOT_CP_MACRO_LEN                    = "巨集名字字元數必須在 1 至 14 之間."
HEALBOT_CP_MACRO_BASE                   = "基本宏名稱"
HEALBOT_CP_MACRO_SAVE                   = "最後保存在: "
HEALBOT_CP_STARTTIME                    = "登陸保護持續時間"
HEALBOT_WORD_RESERVED                   = "儲存"
HEALBOT_OPTIONS_COMBATPROT              = "戰鬥存儲"
HEALBOT_COMBATPROT_PARTYNO              = "儲存小隊樣式條"
HEALBOT_COMBATPROT_RAIDNO               = "儲存團隊樣式條"

HEALBOT_WORD_HEALTH                     = "血量"
HEALBOT_OPTIONS_DONT_SHOW               = "不顯示"
HEALBOT_OPTIONS_SAME_AS_HLTH_CURRENT    = "跟血量一樣 (當前血量)"
HEALBOT_OPTIONS_SAME_AS_HLTH_FUTURE     = "跟血量一樣 (預計血量)"
HEALBOT_OPTIONS_FUTURE_HLTH             = "預計血量"
HEALBOT_SKIN_HEALTHBARCOL_TEXT          = "血量條顏色";
HEALBOT_SKIN_HEALTHBACKCOL_TEXT         = "樣式條背景";
HEALBOT_SKIN_INCHEALBARCOL_TEXT         = "進入治療顏色";
HEALBOT_OPTIONS_ALWAYS_SHOW_TARGET      = "目標:始終顯示"
HEALBOT_OPTIONS_ALWAYS_SHOW_FOCUS       = "焦點:始終顯示"
HEALBOT_OPTIONS_GROUP_PETS_BY_FIVE      = "寵物:五組"
HEALBOT_OPTIONS_USEGAMETOOLTIP          = "使用遊戲提示"
HEALBOT_OPTIONS_SHOWPOWERCOUNTER        = "顯示能量計數器"
HEALBOT_OPTIONS_SHOWPOWERCOUNTER_PALA   = "顯示聖能"
HEALBOT_OPTIONS_SHOWPOWERCOUNTER_MONK   = "顯示氣能"
HEALBOT_OPTIONS_CUSTOMDEBUFF_REVDUR     = "反轉計時"
HEALBOT_OPTIONS_DISABLEHEALBOTSOLO      = "僅當單刷"
HEALBOT_OPTIONS_CUSTOM_ALLDISEASE       = "所有疾病"
HEALBOT_OPTIONS_CUSTOM_ALLMAGIC         = "所有魔法"
HEALBOT_OPTIONS_CUSTOM_ALLCURSE         = "所有詛咒"
HEALBOT_OPTIONS_CUSTOM_ALLPOISON        = "所有毒"
HEALBOT_OPTIONS_CUSTOM_CASTBY           = "施放:"

HEALBOT_BLIZZARD_MENU                   = "Blizzard 菜單"
HEALBOT_HB_MENU                         = "Healbot 菜單"
HEALBOT_FOLLOW                          = "跟隨"
HEALBOT_TRADE                           = "交易"
HEALBOT_PROMOTE_RA                      = "提升為團隊助理"
HEALBOT_DEMOTE_RA                       = "降職"
HEALBOT_TOGGLE_ENABLED                  = "開啟切換"
HEALBOT_TOGGLE_MYTARGETS                = "切換我的目標"
HEALBOT_TOGGLE_PRIVATETANKS             = "提升為主坦克"
HEALBOT_RESET_BAR                       = "重設狀態條"
HEALBOT_HIDE_BARS                       = "超過100碼隱藏動作條."
HEALBOT_RANDOMMOUNT                     = "隨機座騎"
HEALBOT_RANDOMGOUNDMOUNT                = "隨機地面座騎"
HEALBOT_RANDOMPET                       = "隨機寵物"
HEALBOT_ZONE_AQ40                       = "安其拉"
HEALBOT_ZONE_VASHJIR1                   = "柯爾普薩之森"
HEALBOT_ZONE_VASHJIR2                   = "爍光海床"
HEALBOT_ZONE_VASHJIR3                   = "無底海淵"
HEALBOT_ZONE_VASHJIR                    = "瓦絲琪爾廢墟"
HEALBOT_RESLAG_INDICATOR                = "保持名字綠色當變形為" 
HEALBOT_RESLAG_INDICATOR_ERROR          = "設置變形保持名字綠色必須在 1 和 30 之間" 
HEALBOT_FRAMELOCK_BYPASS_OFF            = "框架旁路鎖定關閉"
HEALBOT_FRAMELOCK_BYPASS_ON             = "框架旁路鎖定 (Ctl+Alt+Left) 開啟"
HEALBOT_RESTRICTTARGETBAR_ON            = "限制目標欄開"
HEALBOT_RESTRICTTARGETBAR_OFF           = "限制目標欄關"
HEALBOT_PRELOADOPTIONS_ON               = "開啟預讀選項"
HEALBOT_PRELOADOPTIONS_OFF              = "關閉預讀選項"
HEALBOT_AGGRO2_ERROR_MSG                = "要設置仇恨等級 2, 仇恨值必須在 25 和 95 之間"
HEALBOT_AGGRO3_ERROR_MSG                = "要設置仇恨等級 3, t仇恨值必須在 75 和 100 之間"
HEALBOT_AGGRO2_SET_MSG                  = "設置仇恨百分比為等級 2 "
HEALBOT_AGGRO3_SET_MSG                  = "設置仇恨百分比為等級 3 "
HEALBOT_WORD_THREAT                     = "仇恨"
HEALBOT_AGGRO_ERROR_MSG                 = "無效的仇恨等級 - 使用 2 或 3"

HEALBOT_OPTIONS_QUERYTALENTS            = "查詢天賦資料"       
HEALBOT_OPTIONS_LOWMANAINDICATOR        = "低法力指示器"
HEALBOT_OPTIONS_LOWMANAINDICATOR1       = "不顯示"
HEALBOT_OPTIONS_LOWMANAINDICATOR2       = "*10% / **20% / ***30%"
HEALBOT_OPTIONS_LOWMANAINDICATOR3       = "*15% / **30% / ***45%"
HEALBOT_OPTIONS_LOWMANAINDICATOR4       = "*20% / **40% / ***60%"
HEALBOT_OPTIONS_LOWMANAINDICATOR5       = "*25% / **50% / ***75%"
HEALBOT_OPTIONS_LOWMANAINDICATOR6       = "*30% / **60% / ***90%"

HEALBOT_OPTION_IGNORE_AURA_RESTED       = "休息時忽略光環效果"
HEALBOT_OPTION_ADJUST_MAX_HEALTH        = "Adjust unit max health"

HEALBOT_WORD_ENABLE                     = "開啟"
HEALBOT_WORD_DISABLE                    = "禁用"

HEALBOT_OPTIONS_MYCLASS                 = "我的類別"

HEALBOT_OPTIONS_CONTENT_ABOUT           = "        關於"
HEALBOT_OPTIONS_CONTENT_GENERAL         = "        " .. HEALBOT_OPTIONS_TAB_GENERAL
HEALBOT_OPTIONS_CONTENT_SPELLS          = "        " .. HEALBOT_OPTIONS_TAB_SPELLS
HEALBOT_OPTIONS_CONTENT_SKINS           = "        " .. HEALBOT_OPTIONS_TAB_SKIN
HEALBOT_OPTIONS_CONTENT_BUFFS           = "        " .. HEALBOT_OPTIONS_TAB_BUFFS
HEALBOT_OPTIONS_CONTENT_TIPS            = "        " .. HEALBOT_OPTIONS_TAB_TIPS
HEALBOT_OPTIONS_CONTENT_MOUSEWHEEL      = "        滑鼠滾輪"
HEALBOT_OPTIONS_CONTENT_TEST            = "        測試"
HEALBOT_OPTIONS_CONTENT_USAGE           = "        記憶體佔用"
HEALBOT_OPTIONS_REFRESH                 = "刷新"

HEALBOT_CUSTOM_CATEGORY                 = "類別"
HEALBOT_CUSTOM_CAT_CUSTOM               = "定制"
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

HEALBOT_CUSTOM_CASTBY_EVERYONE          = "任何人"
HEALBOT_CUSTOM_CASTBY_ENEMY             = "敵方"
HEALBOT_CUSTOM_CASTBY_FRIEND            = "友方"

HEALBOT_ABOUT_DESC1                    = "一個可定制樣式的治療、驅散、Buff、繃帶、隨機座騎、範圍檢查和仇恨框架的插件."
HEALBOT_ABOUT_WEBSITE                  = "網址:"
HEALBOT_ABOUT_AUTHORH                  = "作者:"
HEALBOT_ABOUT_AUTHORD                  = "Strife"
HEALBOT_ABOUT_EMAILH                   = "Email:"
HEALBOT_ABOUT_EMAILD                   = "healbot@outlook.com"
HEALBOT_ABOUT_CATH                     = "類別:"
HEALBOT_ABOUT_CATD                     = "單位框體／增加 Buffs／驅散 Debuffs／治療"
HEALBOT_ABOUT_CREDITH                  = "榮譽:"
HEALBOT_ABOUT_CREDITD                  = "Acirac, Kubik, Von, Aldetal, Brezza,月夜寒星@銀月"  -- 任何參與翻譯的人員 (如果需要的話), 請自行添加.
HEALBOT_ABOUT_LOCALH                   = "語言"
HEALBOT_ABOUT_LOCALD                   = "deDE, enUK, esES, frFR, huHU, itIT, koKR, poBR, ruRU, zhCN, zhTW"
HEALBOT_ABOUT_FAQH                     = "常見問題"
HEALBOT_ABOUT_FAQ_QUESTION             = "問題"
HEALBOT_ABOUT_FAQ_ANSWER               = "回答:"

HEALBOT_ABOUT_FAQ_QUESTIONS = {   [1]   = "Buffs - 為何所有的樣式條都變成白色的?",
                                  [2]   = "施法 - 為何有時滑鼠變成藍色,我不能有任何動作?",
                                  [3]   = "宏 - 你有冷卻時間的例子嗎?",
                                  [4]   = "宏 - 你有任意施法的例子嗎?",
                                  [5]   = "滑鼠 - 我如何用滾輪使用滑鼠指向巨集?",
                                  [6]   = "選項 - 樣式條如何排序,例如每列兩個小隊?",
                                  [7]   = "選項 - 我可以隱藏所有的樣式條而僅顯示需要驅散的 DeBuff 嗎?",
                                  [8]   = "選項 - 我可以隱藏進入治療嗎?",
                                  [9]   = "選項 - 當我登出/登錄的時候,Healbot 不保存我的設置.",
                                  [10]  = "選項 - 如何總是啟用設置?",
                                  [11]  = "選項 - 如何自動禁用 Healbot?",
                                  [12]  = "選項 - 如何使樣式條朝不同的方向擴展?",
                                  [13]  = "選項 - 如何設置我的目標?",
                                  [14]  = "選項 - 如何設置私立坦克?",
                                  [15]  = "選項 - 如何為 NPC 創建狀態欄?",
                                  [16]  = "範圍 - 我不能看到超出範圍的隊員,我應該如何解決?",
                                  [17]  = "法術 - 我如何設置Healbot 施放不同的法術?",
                                  [18]  = "法術 - 我可以不再施放治療給沒有受傷的目標嗎?",
                              }

HEALBOT_ABOUT_FAQ_SPELLS_ANSWER01       = "在法術標籤欄的選項設置 \n" ..
                                          "請嘗試更改設置並測試: \n\n" ..
                                          "     1: 在法術選項標籤: 總是使用已啟用的設置； \n" ..
                                          "     2: 在法術選項標籤: 關閉智能施法. \n\n" ..
                                          "注意: 大多數玩家會希望打開智慧施法. \n\n"..
                                          "注意: 有經驗的玩家會希望, \n" ..
                                          "         關閉總是使用已啟用的設置, \n" ..
                                          "         為禁用樣式條設置法術."
                                          
HEALBOT_ABOUT_FAQ_ANSWERS = {     [1]   = "你檢測到消失的 Buffs \n\n" .. 
                                          "你可以在 Buffs 標籤欄關閉, \n" ..
                                          "此外,單擊這個樣式條施放缺少的 Buff.",
                                  [2]   = "這是暴雪的功能而非 Healbot 問題, \n\n" .. 
                                          "使用標準的暴雪框架, \n" ..
                                          "嘗試施放已冷卻法術 \n" ..
                                          "請注意滑鼠為何會變成藍色. \n\n" ..
                                          "注意: 沒有什麼可以防止戰鬥中出現這種情況, \n" ..
                                          "自 WoW 2.0 起 Blizzard 已經在戰鬥中鎖定 UI, \n" ..
                                          "停止所有插件在戰鬥中不斷變換法術或目標, \n" ..
                                          "這將有助於監測法術冷卻時間提示.",
                                  [3]   = "是的 \n"..
                                          "騎士拯救之手冷卻宏示例: \n\n" ..
                                          "    #show 拯救之手 \n" ..
                                          '    /script local n=UnitName("hbtarget"); ' .. "\n" ..
                                          '    if GetSpellCooldown("拯救之手")==0 then ' .. " \n" ..
                                          '        SendChatMessage("拯救之手保佑你 "..n,"YELL") ' .. "\n" ..
                                          '        SendChatMessage("拯救之手!","WHISPER",nil,n) ' .. "\n" ..
                                          "    end; \n" ..
                                          "    /cast [@hbtarget] 拯救之手\n\n"..
                                          "注意:宏只有三行,中間段落其實只是間隔空格. \n"..
                                          "    插件會儲存設置的巨集,修改巨集之後要重新選擇.",
                                  [4]   = "是的 \n\n"..
                                          "牧師快速治療,使用兩種飾品: \n\n" ..
                                          "    #show 快速治療 \n" ..
                                          "    /script UIErrorsFrame:Hide() \n" ..
                                          "    /console Sound_EnableSFX 0 \n" ..
                                          "    /use 13 \n" ..
                                          "    /use 14 \n" ..
                                          "    /console Sound_EnableSFX 1 \n" ..
                                          "    /cast [@hbtarget] 快速治療 \n" ..
                                          "    /script UIErrorsFrame:Clear(); UIErrorsFrame:Show()",
                                  [5]   = "1: 在滑鼠滾輪 標籤欄: 關閉滑鼠滾輪 \n" ..
                                          "2: 綁定你的宏到暴雪設置 [@mouseover] \n\n\n" ..
                                          "示例宏: \n\n" ..
                                          "    #showtooltip 快速治療 \n" ..
                                          "    /cast [@mouseover] 快速治療 \n",
                                  [6]   = "是的 \n\n\n"..
                                          "顯示標題: \n" ..
                                          "     1: 在樣式>標題 標籤欄, 選擇 顯示標題頭 \n" ..
                                          "     2: 在樣式>樣式條 標籤欄, 設置每列小隊數量 \n\n" ..
                                          "不顯示標題: \n" ..
                                          "     1: 在樣式>樣式條 標籤欄, 選擇按編號分列 \n" ..
                                          "     2: 在樣式>樣式條 標籤欄, 設置每列小隊數量 ",
                                  [7]   = "是的 \n\n"..
                                          "1: 在樣式>治療>警告 標籤欄,設置等級為 0 \n" ..
                                          "2: 在樣式>仇恨 標籤欄, 關閉仇恨提醒 \n" .. 
                                          "3: 在樣式>樣式條 標籤欄, 設置禁用不透明度為 0 \n" ..
                                          "4: 在樣式>樣式條 標籤欄, 設置背景不透明度為 0 \n" ..
                                          "5: 在樣式>樣式條文本 標籤欄, 單擊 禁用 樣式條 \n" ..
                                          "    設置禁用文本不透明度為 0 \n" ..
                                          "6: 在樣式>綜合 標籤欄, 點擊 背景顏色 樣式條 \n" ..
                                          "    設置背景不透明度為 0 \n" ..
                                          "7: 在驅散 標籤欄,打開 監測 Debuff ",
                                  [8]   = "是的 \n\n"..
                                          "1: 在樣式>樣式條 標籤欄, 設置進入治療顏色不顯示 \n" ..
                                          "2: 在樣式>樣式條文本 標籤欄, \n" ..
                                          "          設置 顯示生命值 為 否進入治療",
                                  [9]   = "這是自 WoW 3.2 之後的變更, \n" ..
                                          "它會影響名字中帶有怪異字元的角色, \n\n" ..
                                          "如果你使用 Vista 或 Win7, 請嘗試: \n"..
                                          "     變更系統語言為 English (非-unicode 程式), \n" ..
                                          "     控制面板 > 區域和語言 > 管理標籤欄.",
                                  [10]   = "在法術標籤欄中打開總是使用已啟用的設置 \n\n" ..
                                          "有時候還要設置警報級別為 100, \n" ..
                                          "在樣式>治療>警告 標籤欄中能找到.",
                                  [11]  = "為某個角色禁用: \n\n" ..
                                          "     1: 打開綜合標籤欄 \n" ..
                                          "     2: 打開禁用 HealBot \n\n\n" ..
                                          "單刷禁用: \n\n" ..
                                          "     1: 打開綜合標籤欄 \n" ..
                                          "     2: 右邊的禁用選項, 選擇僅當單刷 \n" ..
                                          "     3: 打開禁用選項",
                                  [12]  = "更改樣式條錨點設置在 樣式>綜合 標籤欄  \n\n" ..
                                          "     右上:        樣式條朝左下延伸 \n" ..
                                          "     左上:        樣式條朝右下延伸 \n" ..
                                          "     右下:        樣式條朝左上延伸 \n" ..
                                          "     左下:        樣式條朝右上延伸 ",
                                  [13]  = "我的目標允許你創建一個你想要的目標列表, \n" ..
                                          "小組獨立分開, 類似 MT 組. \n\n" ..
                                          "下列選項可用 \n" .. 
                                          "添加/刪除人員到/從目標列表 \n\n" ..
                                          "     - Shift+Ctrl+Alt+右鍵點擊樣式條 \n" ..
                                          '     - 使用 Healbot 功能表, 輸入 "hbmenu" 在法術標籤欄 ' .. "\n" ..
                                          "     - 使用滑鼠滾輪, 設置到滑鼠滾輪標籤欄",
                                  [14]  = "私立坦克可以添加到主坦克列表, \n" ..
                                          "私立坦克僅可在你的 Healbot 中可見, \n" ..
                                          "不影響其他玩家或者插件. \n\n" ..
                                          "下列選線可以使用 \n" ..
                                          "添加/刪除人員到/從坦克列表 \n\n" ..
                                          '     - 使用 Healbot 功能表, 輸入 "hbmenu" 到法術標籤欄 ' .. "\n" ..
                                          "     - 使用滑鼠滾輪, 設置到滑鼠滾輪標籤欄",
                                  [15]  = "是的 \n"..
                                          "     1: 在樣式>治療 標籤欄, 打開焦點 \n" ..
                                          "     2: 設置 NPC 為焦點(或不在團隊/小隊的玩家) \n" ..
                                          "          Healbot 將創建一個你的目標列表樣式條. \n" ..
                                          "注意: 如果你反復進入和脫離戰鬥, \n" ..
                                          "          你需要重設 NPC 為焦點, \n" ..
                                          "          在樣式>治療 標籤欄設置焦點:始終顯示, \n" ..
                                          "          這將使樣式條在戰鬥中可用. \n" ..
                                          "注意: HealBot 功能表中有 'HealBot 焦點' 選項 \n" ..
                                          "          這可以使你很容易將 NPC's 設為焦點, \n" ..
                                          "          並且作為提醒你設置焦點. \n" ..
                                          "          輸入 'hbmenu' 在法術標籤上使用 HealBot 功能表, \n" ..
                                          "          或者使用滑鼠滾輪標籤並設置 HealBot 功能表.",
                                  [16]  = "1:  在樣式>樣式條 標籤欄中, \n" ..
                                              "    調整禁用樣式條不透明度 \n" ..
                                          "2:  在樣式>樣式條文本 標籤欄中,  \n" ..
                                          "    調整禁用文字不透明度. \n" ..
                                          "要調整必須點擊樣式條上的禁用. \n\n" ..
                                          "    有時候還要設置警報級別為 100, \n" ..
                                          "    在樣式>治療>警告 標籤欄中能找到.",
                                  [17]  = "事實上 Healbot 是定位為準確施法的插件. \n\n" .. HEALBOT_ABOUT_FAQ_SPELLS_ANSWER01,
                                  [18]  = HEALBOT_ABOUT_FAQ_SPELLS_ANSWER01,
                              }

HEALBOT_OPTIONS_SKINAUTHOR              = "樣式條作者:"
HEALBOT_OPTIONS_AVOIDBLUECURSOR         = "防止藍\n色滑鼠"
HEALBOT_PLAYER_OF_REALM                  = "的"
    
    HEALBOT_OPTIONS_LANG                    = "語言"
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
    
    HEALBOT_OPTIONS_LANG_ADDON_FAIL1        = "無法載入本地化語言."
    HEALBOT_OPTIONS_LANG_ADDON_FAIL2        = "失敗原因是:"
    HEALBOT_OPTIONS_LANG_ADDON_FAIL3        = "注意:在當前版本,這是唯一的警告"
    
    HEALBOT_OPTIONS_ADDON_FAIL              = "無法載入 HealBot 插件."

    HEALBOT_OPTIONS_IN_A_GROUP              = "僅在小隊或者團隊時"
    
    HEALBOT_OPTIONS_CONTENT_SKINS_GENERAL   = "        " .. HEALBOT_OPTIONS_TAB_GENERAL
    HEALBOT_OPTIONS_CONTENT_SKINS_HEALING   = "        " .. HEALBOT_OPTIONS_TAB_HEALING
    HEALBOT_OPTIONS_CONTENT_SKINS_HEADERS   = "        " .. HEALBOT_OPTIONS_TAB_HEADERS
    HEALBOT_OPTIONS_CONTENT_SKINS_BARS      = "        " .. HEALBOT_OPTIONS_TAB_BARS
    HEALBOT_OPTIONS_CONTENT_SKINS_ICONS     = "        " .. HEALBOT_OPTIONS_TAB_ICONS
    HEALBOT_OPTIONS_CONTENT_SKINS_AGGRO     = "        " .. HEALBOT_OPTIONS_TAB_AGGRO
    HEALBOT_OPTIONS_CONTENT_SKINS_CHAT      = "        " .. HEALBOT_OPTIONS_TAB_CHAT
    HEALBOT_OPTIONS_CONTENT_SKINS_TEXT      = "        " .. HEALBOT_OPTIONS_TAB_TEXT
    HEALBOT_OPTIONS_CONTENT_SKINS_ICONTEXT  = "        " .. HEALBOT_OPTIONS_TAB_ICONTEXT

    HEALBOT_OPTIONS_CONTENT_CURE_DEBUFF     = "        " .. HEALBOT_SKIN_DEBTEXT
    HEALBOT_OPTIONS_CONTENT_CURE_CUSTOM     = "        " .. HEALBOT_CLASSES_CUSTOM
    HEALBOT_OPTIONS_CONTENT_CURE_WARNING    = "        " .. HEALBOT_OPTIONS_TAB_WARNING

    HEALBOT_SKIN_ABSORBCOL_TEXT             = "吸收效果";
    HEALBOT_OPTIONS_BARALPHAABSORB          = "吸收效果不透明";
    HEALBOT_OPTIONS_OUTLINE                 = "輪廓"
    HEALBOT_OPTIONS_FRAME                   = "框架"
    HEALBOT_OPTIONS_CONTENT_SKINS_FRAMES    = "        " .. "框架"
    HEALBOT_OPTIONS_FRAMESOPTTEXT           = "框架選項"
    HEALBOT_OPTIONS_SETTOOLTIP_POSITION     = "設置提示位置"
    HEALBOT_OPTIONS_FRAME_TITLE             = "框架標題"
    HEALBOT_OPTIONS_FRAME_TITLE_SHOW        = "顯示標題"
    HEALBOT_OPTIONS_FRAME_ALIAS_SHOW        = "顯示標題"
    HEALBOT_OPTIONS_GROW_DIRECTION          = "擴展方向"
    HEALBOT_OPTIONS_GROW_HORIZONTAL         = "水準"
    HEALBOT_OPTIONS_GROW_VERTICAL           = "垂直"
    HEALBOT_OPTIONS_FONT_OFFSET             = "字體偏移"
    HEALBOT_OPTIONS_SET_FRAME_HEALGROUPS    = "分配治療群組"
    HEALBOT_OPTION_EXCLUDEMOUNT_ON          = "排除載具"
    HEALBOT_OPTION_EXCLUDEMOUNT_OFF         = "不排除載具"
    HEALBOT_CMD_TOGGLEEXCLUDEMOUNT          = "切換是否排除載具"
    HEALBOT_OPTIONS_HIDEMINIBOSSFRAMES      = "隱藏 Boss 小框架";
    HEALBOT_OPTIONS_HIDERAIDFRAMES          = "隱藏 Raid 框架";
    HEALBOT_OPTIONS_FRAME_ALIAS             = "別名"
    HEALBOT_OPTIONS_CONTENT_SKINS_HEALGROUP = "        " .. "治療群組"
    HEALBOT_OPTIONS_CONTENT_SKINS_BARCOLOUR = "        " .. "樣式條顏色";
    HEALBOT_OPTIONS_SET_ALL_FRAMES          = "應用當前樣式設置到所有框架"
    HEALBOT_WORDS_PROFILE                   = "隊伍配置"
    HEALBOT_SHARE_SCREENSHOT                = "拍攝截圖"
    HEALBOT_SHARE_INSTRUCTION               = "到網站查看共用的操作指南 "..HEALBOT_ABOUT_URL
    HEALBOT_ENEMY_USE_FRAME                 = "使用框架"
    HEALBOT_ENEMY_INCLUDE_SELF              = "包含我的目標"
    HEALBOT_ENEMY_INCLUDE_TANKS             = "包含坦克目標"
    HEALBOT_OPTIONS_ENEMY_OPT               = "敵方選項";
    HEALBOT_OPTIONS_SHARE_OPT               = "分享選項";
    HEALBOT_OPTIONS_CONTENT_SKINS_SHARE     = "    " .. "分享"
    HEALBOT_OPTIONS_CONTENT_SKINS_ENEMY     = "    " .. "敵方"
    HEALBOT_OPTIONS_BUTTONLOADSKIN          = "載入皮膚"
    HEALBOT_ENEMY_NO_TARGET                 = "沒有目標"
    HEALBOT_OPTIONS_ENEMYBARS               = "任何時間的敵方樣式條";
    HEALBOT_OPTIONS_HARMFUL_SPELLS          = "傷害性法術"
    HEALBOT_ENEMY_INCLUDE_MYTARGETS         = "包含我的目標的目標"
    HEALBOT_ENEMY_NUMBER_BOSSES             = "Boss 數目"
    HEALBOT_ENEMY_HIDE_OUTOFCOMBAT          = "脫離戰鬥隱藏樣式條"
    HEALBOT_ENEMY_EXISTS_SHOW               = "僅在進入戰鬥".."\n".."存在時顯示"
    HEALBOT_ENEMY_EXISTS_SHOW_PTARGETS      = "玩家目標"
    HEALBOT_ENEMY_EXISTS_SHOW_BOSSES        = "Boss 樣式條"
    HEALBOT_OPTIONS_TARGET_ONLY_FRIEND      = "目標: 僅顯示友好的"
    HEALBOT_OPTIONS_FOCUS_ONLY_FRIEND       = "焦點: 僅顯示友好的"
    HEALBOT_OPTIONS_PROFILE                 = "資料關於".."\n".."法術/Buffs/治療"
    HEALBOT_OPTIONS_PROFILE_CHARACTER       = "字元"
    HEALBOT_OPTIONS_PROFILE_CLASS           = "類別"
    HEALBOT_OPTIONS_INCOMBATALERTLEVEL      = "警報級別 - 在戰鬥中";
    HEALBOT_OPTIONS_OUTCOMBATALERTLEVEL     = "警報級別 - 脫離戰鬥";
end
