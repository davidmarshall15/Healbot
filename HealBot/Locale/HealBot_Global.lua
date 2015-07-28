HEALBOT_VERSION   = "6.2.0.1";
HEALBOT_ABOUT_URL = "http://healbot.darktech.org/"

function HealBot_globalVars()
    --Harmful Spells
    --Priest
	HEALBOT_MINDBENDER                      = GetSpellInfo(123040) or "--Mindbender"
    HEALBOT_SMITE                           = GetSpellInfo(585) or "--Smite"
    HEALBOT_HOLY_FIRE                       = GetSpellInfo(14914) or "--Holy Fire"
    HEALBOT_SHADOW_WORD_PAIN                = GetSpellInfo(589) or "--Shadow Word: Pain"
    HEALBOT_SHADOW_WORD_DEATH               = GetSpellInfo(32379) or "--Shadow Word: Death"
    HEALBOT_DISPEL_MAGIC                    = GetSpellInfo(528) or "--Dispel Magic"
    HEALBOT_DOMINATE_MIND                   = GetSpellInfo(605) or "--Dominate Mind"
    HEALBOT_MIND_SEAR                       = GetSpellInfo(48045) or "--Mind Sear"
    HEALBOT_SHACKLE_UNDEAD                  = GetSpellInfo(9484) or "--Shackle Undead"    
    --Druid
	HEALBOT_WRATH                           = GetSpellInfo(5176)  or "--Wrath"
    HEALBOT_HURRICANE                       = GetSpellInfo(16914)  or "--Hurricane"
    HEALBOT_FAERIE_FIRE                     = GetSpellInfo(770)  or "--Faerie Fire"
    HEALBOT_ENTANGLING_ROOTS                = GetSpellInfo(339)  or "--Entangling Roots"
    HEALBOT_FAERIE_SWARM                    = GetSpellInfo(106707) or "--Faerie Swarm"
    HEALBOT_MOONFIRE                        = GetSpellInfo(8921) or "--Moonfire"
    HEALBOT_GROWL                           = GetSpellInfo(6795) or "--Growl"
    HEALBOT_SOOTHE                          = GetSpellInfo(2908) or "--Soothe"
    HEALBOT_MASS_ENTANGLEMENT               = GetSpellInfo(102359) or "--Mass Entanglement"
    HEALBOT_CYCLONE                         = GetSpellInfo(33786) or "--Cyclone"   
    --Monk
	HEALBOT_JAB                             = GetSpellInfo(100780) or "--Jab"
    HEALBOT_TIGER_PALM                      = GetSpellInfo(100787) or "--Tiger Palm"
    HEALBOT_CHI_BURST                       = GetSpellInfo(123986) or "--Chi Burst"
    HEALBOT_BLACKOUT_KICK                   = GetSpellInfo(100784) or "--Blackout Kick"
    HEALBOT_PROVOKE                         = GetSpellInfo(115546) or "--Provoke"
    HEALBOT_TOUCH_OF_DEATH                  = GetSpellInfo(115080) or "--Touch of Death"
    HEALBOT_DISABLE                         = GetSpellInfo(116095) or "--Disable"
    HEALBOT_SPEAR_HAND_STRIKE               = GetSpellInfo(116705) or "--Spear Hand Strike"
    HEALBOT_PARALYSIS                       = GetSpellInfo(115078) or "--Paralysis"
    HEALBOT_CRACKLING_JADE_LIGHTNING        = GetSpellInfo(117952) or "--Crackling Jade Lightning"
  
    --Paladin
	HEALBOT_REBUKE                          = GetSpellInfo(96231) or "--Rebuke"
    HEALBOT_JUDGMENT                        = GetSpellInfo(20271) or "--Judgment"
    HEALBOT_CRUSADER_STRIKE                 = GetSpellInfo(35395) or "--Crusader Strike"
    HEALBOT_DENOUNCE                        = GetSpellInfo(2812) or "--Denounce"
    HEALBOT_HAMMER_OF_JUSTICE               = GetSpellInfo(853) or "--Hammer of Justice"
    HEALBOT_HAMMER_OF_WRATH                 = GetSpellInfo(24275) or "--Hammer of Wrath"
    HEALBOT_HOLY_SHOCK                      = GetSpellInfo(20473) or "--Holy Shock"
    HEALBOT_RECKONING                       = GetSpellInfo(62124) or "--Reckoning"
    HEALBOT_REPENTANCE                      = GetSpellInfo(20066) or "--Repentance"
    HEALBOT_TURN_EVIL                       = GetSpellInfo(10326) or "--Turn Evil" 
	HEALBOT_BINDING_LIGHT                   = GetSpellInfo(115750) or "--Blinding Light"
    --Shaman
	HEALBOT_CHAIN_LIGHTNING                 = GetSpellInfo(421) or "--Chain Lightning"
    HEALBOT_LIGHTNING_BOLT                  = GetSpellInfo(403) or "--Lightning Bolt"
    HEALBOT_EARTH_SHOCK                     = GetSpellInfo(8042) or "--Earth Shock"
    HEALBOT_FLAME_SHOCK                     = GetSpellInfo(8050) or "--Flame Shock"
    HEALBOT_FROST_SHOCK                     = GetSpellInfo(8056) or "--Frost Shock"
    HEALBOT_ELEMENTAL_BLAST                 = GetSpellInfo(8056) or "--Elemental Blast"
    --HEALBOT_BIND_ELEMENTAL                  = GetSpellInfo(76780) or "--Bind Elemental"
    HEALBOT_HEX                             = GetSpellInfo(51514) or "--Hex"
    HEALBOT_LAVA_BLAST                      = GetSpellInfo(51505) or "--Lava Blast"
    HEALBOT_PRIMAL_STRIKE                   = GetSpellInfo(73899) or "--Primal Strike"
    HEALBOT_PURGE                           = GetSpellInfo(370) or "--Purge"
    HEALBOT_WIND_SHEAR                      = GetSpellInfo(57994) or "--Wind Shear"   
    --Mage
	HEALBOT_MAGE_BOMB                       = GetSpellInfo(125430) or "--Mage Bomb"
    HEALBOT_FROSTFIRE_BOLT                  = GetSpellInfo(44614) or "--Frostfire Bolt"
    HEALBOT_FIRE_BLAST                      = GetSpellInfo(2136) or "--Fire Blast"  
	--Hunter
	HEALBOT_CONCUSSIVE_SHOT                 = GetSpellInfo(5116) or "--Concussive Shot"
    HEALBOT_ARCANE_SHOT                     = GetSpellInfo(3044) or "--Arcane Shot"
    HEALBOT_AIMED_SHOT                      = GetSpellInfo(19434) or "--Aimed Shot"       
	--Death Knight
	HEALBOT_PLAGUE_STRIKE                   = GetSpellInfo(45462) or "--Plague Strike"
    HEALBOT_DEATH_COIL                      = GetSpellInfo(47541) or "--Death Coil"   
	--Rogue
	HEALBOT_GOUGE                           = GetSpellInfo(1776) or "--Gouge"
    HEALBOT_THROW                           = GetSpellInfo(121733) or "--Throw"   
	--Warlock
	HEALBOT_FEAR                            = GetSpellInfo(5782) or "--Fear"
	HEALBOT_CORRUPTION                      = GetSpellInfo(172) or "--Corruption"    
	--Warrior
	HEALBOT_EXECUTE                         = GetSpellInfo(5308) or "--Execute"
    HEALBOT_TAUNT                           = GetSpellInfo(355) or "--Taunt"    
   
	
	--Consumables
    --Bandages 
    HEALBOT_LINEN_BANDAGE                   = GetItemInfo(1251) or "--Linen Bandage";
	HEALBOT_HEAVY_LINEN_BANDAGE             = GetItemInfo(2581) or "--Heavy Linen Bandage";
	HEALBOT_SILK_BANDAGE                    = GetItemInfo(6450) or "--Silk Bandage";
    HEALBOT_HEAVY_SILK_BANDAGE              = GetItemInfo(6451) or "--Heavy Silk Bandage";
    HEALBOT_MAGEWEAVE_BANDAGE               = GetItemInfo(8544) or "--Mageweave Bandage";
    HEALBOT_HEAVY_MAGEWEAVE_BANDAGE         = GetItemInfo(8545) or "--Heavy Mageweave Bandage";
    HEALBOT_RUNECLOTH_BANDAGE               = GetItemInfo(14529) or "--Runecloth Bandage";
    HEALBOT_HEAVY_RUNECLOTH_BANDAGE         = GetItemInfo(14530) or "--Heavy Runecloth Bandage";
    HEALBOT_NETHERWEAVE_BANDAGE             = GetItemInfo(21990) or "--Netherweave Bandage";
    HEALBOT_HEAVY_NETHERWEAVE_BANDAGE       = GetItemInfo(21991) or "--Heavy Netherweave Bandage";
    HEALBOT_FROSTWEAVE_BANDAGE              = GetItemInfo(34721) or "--Frostweave Bandage";
    HEALBOT_HEAVY_FROSTWEAVE_BANDAGE        = GetItemInfo(34722) or "--Heavy Frostweave Bandage";
    HEALBOT_EMBERSILK_BANDAGE               = GetItemInfo(53049) or "--Embersilk Bandage";
    HEALBOT_DENSE_EMBERSILK_BANDAGE         = GetItemInfo(53051) or "--Dense Embersilk Bandage";
	HEALBOT_WINDWOOL_BANDAGE                = GetItemInfo(72985) or "--Windwool Bandage";
	HEALBOT_HEAVY_WINDWOOL_BANDAGE          = GetItemInfo(72986) or "--Heavy Windwool Bandage";    
	--Potions
	HEALBOT_MAJOR_HEALING_POTION            = GetItemInfo(13446) or "--Major Healing Potion";
    HEALBOT_SUPER_HEALING_POTION            = GetItemInfo(22829) or "--Super Healing Potion";
    HEALBOT_MAJOR_COMBAT_HEALING_POTION     = GetItemInfo(31838) or "--Major Combat Healing Potion";
    HEALBOT_RUNIC_HEALING_POTION            = GetItemInfo(33447) or "--Runic Healing Potion";
    HEALBOT_ENDLESS_HEALING_POTION          = GetItemInfo(43569) or "--Endless Healing Potion";   
    HEALBOT_MAJOR_MANA_POTION               = GetItemInfo(13444) or "--Major Mana Potion";
    HEALBOT_SUPER_MANA_POTION               = GetItemInfo(22832) or "--Super Mana Potion";
    HEALBOT_MAJOR_COMBAT_MANA_POTION        = GetItemInfo(31840) or "--Major Combat Mana Potion";
    HEALBOT_RUNIC_MANA_POTION               = GetItemInfo(33448) or "--Runic Mana Potion";
    HEALBOT_ENDLESS_MANA_POTION             = GetItemInfo(43570) or "--Endless Mana Potion";
    HEALBOT_PURIFICATION_POTION             = GetItemInfo(13462) or "--Purification Potion";
    HEALBOT_ANTI_VENOM                      = GetItemInfo(6452) or "--Anti-Venom";
    HEALBOT_POWERFUL_ANTI_VENOM             = GetItemInfo(19440) or "--Powerful Anti-Venom";
    HEALBOT_ELIXIR_OF_POISON_RES            = GetItemInfo(3386) or "--Potion of Curing";

    --Items
    HEALBOT_ORALIUS_WHISPERING_CRYSTAL      = GetItemInfo(118922) or "--Oralius' Whispering Crystal";
    HEALBOT_WHISPERS_OF_INSANITY            = GetSpellInfo(176151) or "--Whispers of Insanity"
    HEALBOT_EVER_BLOOMING_FROND             = GetItemInfo(118935) or "--Ever-Blooming Frond"
    HEALBOT_BLOOM                           = GetSpellInfo(176160) or "--Bloom"
    
	--Racial Abilities
    HEALBOT_STONEFORM                       = GetSpellInfo(20594) or "--Stoneform";
	HEALBOT_DARKFLIGHT                      = GetSpellInfo(68992) or "--Darkflight";
    HEALBOT_GIFT_OF_THE_NAARU               = GetSpellInfo(59547) or "--Gift of the Naaru";
    

    --Healing Spells By Class 
    --Druid
	HEALBOT_REJUVENATION                    = GetSpellInfo(774) or "--Rejuvenation";
    HEALBOT_LIFEBLOOM                       = GetSpellInfo(33763) or "--Lifebloom";
    HEALBOT_WILD_GROWTH                     = GetSpellInfo(48438) or "--Wild Growth";
    HEALBOT_TRANQUILITY                     = GetSpellInfo(740) or "--Tranquility";
    HEALBOT_SWIFTMEND                       = GetSpellInfo(18562) or "--Swiftmend";
    HEALBOT_REGROWTH                        = GetSpellInfo(8936) or "--Regrowth";
    HEALBOT_HEALING_TOUCH                   = GetSpellInfo(5185) or "--Healing Touch";
    HEALBOT_CENARION_WARD                   = GetSpellInfo(102351) or "--Cenarion Ward";
    --Paladin
	HEALBOT_FLASH_OF_LIGHT                  = GetSpellInfo(19750) or "--Flash of Light";
    HEALBOT_WORD_OF_GLORY                   = GetSpellInfo(85673) or "--Word of Glory";
    HEALBOT_LIGHT_OF_DAWN                   = GetSpellInfo(85222) or "--Light of Dawn";
    HEALBOT_HOLY_LIGHT                      = GetSpellInfo(82326) or "--Holy Light";
    --HEALBOT_DIVINE_LIGHT                    = GetSpellInfo(82326) or "--Divine Light";
    HEALBOT_HOLY_RADIANCE                   = GetSpellInfo(82327) or "--Holy Radiance";
    HEALBOT_HOLY_PRISM                      = GetSpellInfo(114165) or "--Holy Prism";
    --Priest
    HEALBOT_BINDING_HEAL                    = GetSpellInfo(32546) or "--Binding Heal"
    HEALBOT_PENANCE                         = GetSpellInfo(47540) or "--Penance"
    HEALBOT_PRAYER_OF_MENDING               = GetSpellInfo(33076) or "--Prayer of Mending";
    HEALBOT_FLASH_HEAL                      = GetSpellInfo(2061) or "--Flash Heal";
    HEALBOT_HEAL                            = GetSpellInfo(2060) or "--Heal";
    HEALBOT_DIVINE_HYMN                     = GetSpellInfo(64843) or "--Divine Hymn";
    HEALBOT_RENEW                           = GetSpellInfo(139) or "--Renew";
    HEALBOT_DESPERATE_PRAYER                = GetSpellInfo(19236) or "--Desperate Prayer";
    HEALBOT_PRAYER_OF_HEALING               = GetSpellInfo(596) or "--Prayer of Healing";
    HEALBOT_CIRCLE_OF_HEALING               = GetSpellInfo(34861) or "--Circle of Healing";
    HEALBOT_HOLY_WORD_CHASTISE              = GetSpellInfo(88625) or "--Holy Word: Chastise";
    HEALBOT_HOLY_WORD_SERENITY              = GetSpellInfo(88684) or "--Holy Word: Serenity";
    HEALBOT_HOLY_WORD_SANCTUARY             = GetSpellInfo(88685) or "--Holy Word: Sanctuary"; 
    HEALBOT_CASCADE                         = GetSpellInfo(121135) or "--Cascade"
	HEALBOT_DIVINE_STAR                     = GetSpellInfo(110744) or "--Divine Star"
	HEALBOT_HALO                            = GetSpellInfo(120517) or "--Halo"
    --Shaman
	HEALBOT_HEALING_WAVE                    = GetSpellInfo(77472) or "--Healing Wave";
    HEALBOT_HEALING_SURGE                   = GetSpellInfo(8004) or "--Healing Surge";
    HEALBOT_RIPTIDE                         = GetSpellInfo(61295) or "--Riptide";
    HEALBOT_HEALING_RAIN                    = GetSpellInfo(73920) or "--Healing Rain";
    HEALBOT_CHAIN_HEAL                      = GetSpellInfo(1064) or "--Chain Heal";
    HEALBOT_HEALING_STREAM_TOTEM            = GetSpellInfo(119523) or "--Healing Stream Totem";
    HEALBOT_HEALING_TIDE_TOTEM              = GetSpellInfo(108280) or "--Healing Tide Totem";
    --Monk
	HEALBOT_SOOTHING_MIST                   = GetSpellInfo(115175) or "--Soothing Mist"
    HEALBOT_ZEN_MEDITATION                  = GetSpellInfo(115176) or "--Zen Meditation"
    HEALBOT_ENVELOPING_MIST                 = GetSpellInfo(124682) or "--Enveloping Mist"
    HEALBOT_REVIVAL                         = GetSpellInfo(115310) or "--Revival"
    HEALBOT_RENEWING_MIST                   = GetSpellInfo(115151) or "--Renewing Mist"  
    HEALBOT_UPLIFT                          = GetSpellInfo(116670) or "--Uplift"
    HEALBOT_SURGING_MIST                    = GetSpellInfo(116694) or "--Surging Mist"
    HEALBOT_CHI_WAVE                        = GetSpellInfo(132463) or "--Chi Wave"
    HEALBOT_CHI_BURST                       = GetSpellInfo(130651) or "--Chi Burst"
    HEALBOT_ZEN_SPHERE                      = GetSpellInfo(124081) or "--Zen Sphere"
    --Warlock
	HEALBOT_HEALTH_FUNNEL                   = GetSpellInfo(755) or "--Health Funnel";

    
	--Buffs, Talents, Glyphs and Other Spells By Class
    --Death Knight
	HEALBOT_ICEBOUND_FORTITUDE              = GetSpellInfo(48792) or "--Icebound Fortitude";
    HEALBOT_ANTIMAGIC_SHELL                 = GetSpellInfo(48707) or "--Antimagic Shell";
    HEALBOT_ARMY_OF_THE_DEAD                = GetSpellInfo(42650) or "--Army of the Dead";
    HEALBOT_LICHBORNE                       = GetSpellInfo(49039) or "--Lichborne";
    HEALBOT_ANTIMAGIC_ZONE                  = GetSpellInfo(51052) or "--Antimagic Zone";
    HEALBOT_VAMPIRIC_BLOOD                  = GetSpellInfo(55233) or "--Vampiric Blood";
    HEALBOT_BONE_SHIELD                     = GetSpellInfo(49222) or "--Bone Shield";
    HEALBOT_HORN_OF_WINTER                  = GetSpellInfo(57330) or "--Horn of Winter";
    HEALBOT_DANCING_RUNE_WEAPON             = GetSpellInfo(49028) or "--Dancing Rune Weapon"
	HEALBOT_SHROUD_OF_PURGATORY             = GetSpellInfo(116888) or "--Shroud of Purgatory";
    
	--Druid
	HEALBOT_MARK_OF_THE_WILD                = GetSpellInfo(1126) or "--Mark of the Wild";
    HEALBOT_BARKSKIN                        = GetSpellInfo(22812) or "--Barkskin";
    HEALBOT_IRONBARK                        = GetSpellInfo(102342) or "--Ironbark";
    HEALBOT_SURVIVAL_INSTINCTS              = GetSpellInfo(61336) or "--Survival Instincts";
    HEALBOT_FRENZIED_REGEN                  = GetSpellInfo(22842) or "--Frenzied Regeneration";
    HEALBOT_DRUID_CLEARCASTING              = GetSpellInfo(16870) or "--Clearcasting";
    HEALBOT_TREE_OF_LIFE                    = GetSpellInfo(33891) or "--Tree of Life";
    HEALBOT_HARMONY                         = GetSpellInfo(100977) or "--Harmony";
    HEALBOT_LIVING_SEED                     = GetSpellInfo(48500) or "--Living Seed";
    HEALBOT_SAVAGE_DEFENCE                  = GetSpellInfo(62606) or "--Savage Defense";

	--WoD Added
	HEALBOT_NATURE_MOMENT_OF_CLARITY        = GetSpellInfo(155577) or "--Moment of Clarity";
	HEALBOT_NATURE_REJUVENATION_GERMINATION = GetSpellInfo(155777) or "--Rejuvenation (Germination)";
	HEALBOT_NATURE_RAMPANT_GROWTH           = GetSpellInfo(155834) or "--Rampant Growth";
    
	--Hunter
    HEALBOT_A_CHEETAH                       = GetSpellInfo(5118) or "--Aspect of the Cheetah"
    HEALBOT_A_PACK                          = GetSpellInfo(13159) or "--Aspect of the Pack"
    HEALBOT_A_WILD                          = GetSpellInfo(20043) or "--Aspect of the Wild"
    HEALBOT_TRUESHOT_AURA                   = GetSpellInfo(19506) or "--Trueshot Aura"
    HEALBOT_MENDPET                         = GetSpellInfo(136) or "--Mend Pet"
    HEALBOT_DETERRENCE                      = GetSpellInfo(19263) or "--Deterrence"
    HEALBOT_TRAP_LAUNCHER                   = GetSpellInfo(77769) or "--Trap Launcher"
    
	--Mage
	HEALBOT_ARCANE_BRILLIANCE               = GetSpellInfo(1459) or "--Arcane Brilliance";
    HEALBOT_DALARAN_BRILLIANCE              = GetSpellInfo(61316) or "--Dalaran Brilliance";
    HEALBOT_MAGE_WARD                       = GetSpellInfo(543) or "--Mage Ward";
    HEALBOT_FOCUS_MAGIC                     = GetSpellInfo(54646) or "--Focus Magic";
    HEALBOT_TEMPORAL_SHIELD                 = GetSpellInfo(115610) or "--Temporal Shield"
    HEALBOT_ICE_BARRIER                     = GetSpellInfo(11426) or "--Ice Barrier"
    HEALBOT_INCANTERS_WARD                  = GetSpellInfo(1463) or "--Incanter's Ward"
    HEALBOT_ICE_BLOCK                       = GetSpellInfo(45438) or "--Ice Block"
    HEALBOT_ICE_WARD                        = GetSpellInfo(111264) or "--Ice Ward"
	HEALBOT_EVOCATION                       = GetSpellInfo(12051) or "--Evocation";
    
	--Paladin
    HEALBOT_BEACON_OF_LIGHT                 = GetSpellInfo(53563) or "--Beacon of Light";
    HEALBOT_LIGHT_BEACON                    = GetSpellInfo(53651) or "--Light's Beacon";
    HEALBOT_SACRED_SHIELD                   = GetSpellInfo(20925) or "--Sacred Shield";
    HEALBOT_LAY_ON_HANDS                    = GetSpellInfo(633) or "--Lay on Hands";
    HEALBOT_INFUSION_OF_LIGHT               = GetSpellInfo(53576) or "--Infusion of Light";
    HEALBOT_SPEED_OF_LIGHT                  = GetSpellInfo(85499) or "--Speed of Light";
    HEALBOT_DAY_BREAK                       = GetSpellInfo(88821) or "--Daybreak";
    HEALBOT_HOLY_SHOCK                      = GetSpellInfo(20473) or "--Holy Shock";
    HEALBOT_DIVINE_SHIELD                   = GetSpellInfo(642) or "--Divine Shield";
    HEALBOT_BLESSING_OF_MIGHT               = GetSpellInfo(19740) or "--Blessing of Might";
    HEALBOT_BLESSING_OF_KINGS               = GetSpellInfo(20217) or "--Blessing of Kings";
    HEALBOT_SEAL_OF_RIGHTEOUSNESS           = GetSpellInfo(20154) or "--Seal of Righteousness";
    HEALBOT_SEAL_OF_JUSTICE                 = GetSpellInfo(20164) or "--Seal of Justice";
    HEALBOT_SEAL_OF_INSIGHT                 = GetSpellInfo(20165) or "--Seal of Insight";
    HEALBOT_SEAL_OF_COMMAND                 = GetSpellInfo(105361) or "--Seal of Command";
    HEALBOT_SEAL_OF_TRUTH                   = GetSpellInfo(31801) or "--Seal of Truth";
    HEALBOT_HAND_OF_FREEDOM                 = GetSpellInfo(1044) or "--Hand of Freedom";
    HEALBOT_HAND_OF_PROTECTION              = GetSpellInfo(1022) or "--Hand of Protection";
    HEALBOT_HAND_OF_SACRIFICE               = GetSpellInfo(6940) or "--Hand of Sacrifice";
    HEALBOT_HAND_OF_SALVATION               = GetSpellInfo(1038) or "--Hand of Salvation";
    HEALBOT_RIGHTEOUS_FURY                  = GetSpellInfo(25780) or "--Righteous Fury";
    HEALBOT_DEVOTION_AURA                   = GetSpellInfo(465) or "--Devotion Aura";
    HEALBOT_DIVINE_PROTECTION               = GetSpellInfo(498) or "--Divine Protection";
    HEALBOT_ILLUMINATED_HEALING             = GetSpellInfo(86273) or "--Illuminated Healing";
    HEALBOT_ARDENT_DEFENDER                 = GetSpellInfo(31850) or "--Ardent Defender";
    HEALBOT_HOLY_SHIELD                     = GetSpellInfo(20925) or "--Holy Shield"
    HEALBOT_GUARDED_BY_THE_LIGHT            = GetSpellInfo(53592) or "--Guarded by the Light";
    HEALBOT_GUARDIAN_ANCIENT_KINGS          = GetSpellInfo(86659) or "--Guardian of Ancient Kings";
    HEALBOT_ETERNAL_FLAME                   = GetSpellInfo(114163) or "--Eternal Flame";
    HEALBOT_HAND_OF_PURITY                  = GetSpellInfo(114039) or "--Hand of Purity";
    HEALBOT_EXECUTION_SENTENCE              = GetSpellInfo(114157) or "--Execution Sentence";
    HEALBOT_DIVINE_PURPOSE                  = GetSpellInfo(86172) or "--Divine Purpose";
	--WoD Added
	HEALBOT_BEACON_OF_FAITH                 = GetSpellInfo(156910) or "--Beacon of Faith";
	HEALBOT_BEACON_OF_INSIGHT               = GetSpellInfo(157007) or "--Beacon of Insight";
	HEALBOT_DIVINE_SAVED_BY_THE_LIGHT       = GetSpellInfo(157047) or "--Saved by the Light";
	
	--Priest
	HEALBOT_HOLY_NOVA                       = GetSpellInfo(132157) or "--Holy Nova";
	HEALBOT_POWER_WORD_SHIELD               = GetSpellInfo(17) or "--Power Word:Shield";
    HEALBOT_POWER_WORD_BARRIER              = GetSpellInfo(62618) or "--Power Word:Barrier";
    HEALBOT_SPIRIT_SHELL                    = GetSpellInfo(109964) or "--Spirit Shell";
    HEALBOT_ECHO_OF_LIGHT                   = GetSpellInfo(77489) or "--Echo of Light";
    HEALBOT_GUARDIAN_SPIRIT                 = GetSpellInfo(47788) or "--Guardian Spirit";
    HEALBOT_LEVITATE                        = GetSpellInfo(1706) or "--Levitate";
    HEALBOT_DIVINE_AEGIS                    = GetSpellInfo(47515) or "--Divine Aegis";
    HEALBOT_BLESSED_HEALING                 = GetSpellInfo(70772) or "--Blessed Healing";
    HEALBOT_PAIN_SUPPRESSION                = GetSpellInfo(33206) or "--Pain Suppression";
    HEALBOT_POWER_INFUSION                  = GetSpellInfo(10060) or "--Power Infusion";
    HEALBOT_POWER_WORD_FORTITUDE            = GetSpellInfo(21562) or "--Power Word:Fortitude";
    HEALBOT_SHADOWFORM                      = GetSpellInfo(15473) or "--Shadowform"
    HEALBOT_CHAKRA                          = GetSpellInfo(14751) or "--Chakra";
    HEALBOT_CHAKRA_SANCTUARY                = GetSpellInfo(81206) or "--Chakra: Sanctuary";
    HEALBOT_CHAKRA_SERENITY                 = GetSpellInfo(81208) or "--Chakra: Serenity";
    HEALBOT_CHAKRA_CHASTISE                 = GetSpellInfo(81209) or "--Chakra: Chastise";
    HEALBOT_REVELATIONS                     = GetSpellInfo(88627) or "--Revelations";
    HEALBOT_FEAR_WARD                       = GetSpellInfo(6346) or "--Fear Ward";
    HEALBOT_SERENDIPITY                     = GetSpellInfo(63733) or "--Serendipity";
    HEALBOT_VAMPIRIC_EMBRACE                = GetSpellInfo(15286) or "--Vampiric Embrace";
    HEALBOT_LIGHTWELL_RENEW                 = GetSpellInfo(7001) or "--Lightwell Renew";
    HEALBOT_GRACE                           = GetSpellInfo(47517) or "--Grace";
    HEALBOT_LEAP_OF_FAITH                   = GetSpellInfo(73325) or "--Leap of Faith";
    HEALBOT_EVANGELISM                      = GetSpellInfo(81661) or "--Evangelism";
    HEALBOT_ARCHANGEL                       = GetSpellInfo(81700) or "--Archangel";
    HEALBOT_DIVINE_INSIGHT                  = GetSpellInfo(109175) or "--Divine Insight";
    HEALBOT_ANGELIC_BULWARK                 = GetSpellInfo(108945) or "--Angelic Bulwark"
    HEALBOT_DISPERSION                      = GetSpellInfo(47585) or "--Dispersion"
    HEALBOT_TWIST_OF_FATE                   = GetSpellInfo(109142) or "--Twist of Fate";
	--WoD Added
	HEALBOT_SHADOW_WORD_INSANITY            = GetSpellInfo(132573) or "--Shadow Word: Insanity"
	HEALBOT_SURGE_OF_DARKNESS               = GetSpellInfo(162448) or "--Surge of Darkness"
	HEALBOT_SURGE_OF_LIGHT                  = GetSpellInfo(114255) or "--Surge of Light"
	HEALBOT_ASCENSION                       = GetSpellInfo(161862) or "--Ascension"
	HEALBOT_WORD_OF_MENDING                 = GetSpellInfo(155362) or "--Word of Mending"
    HEALBOT_WORDS_OF_MENDING                = GetSpellInfo(152117) or "--Words of Mending"
	HEALBOT_CLARITY_OF_WILL                 = GetSpellInfo(152118) or "--Clarity of Will"
	HEALBOT_SAVING_GRACE                    = GetSpellInfo(152116) or "--Saving Grace"
	HEALBOT_CLARITY_OF_PURPOSE              = GetSpellInfo(155245) or "--Clarity of Purpose"
	HEALBOT_CLARITY_OF_POWER                = GetSpellInfo(155246) or "--Clarity of Power"
	HEALBOT_SAVING_VOID_ENTROPY             = GetSpellInfo(155361) or "--Void Entropy"
	HEALBOT_AUSPICIOUS_SPIRITS              = GetSpellInfo(155271) or "--Auspicious Spirits"
    
	--Shaman
    HEALBOT_TIDAL_WAVES                     = GetSpellInfo(51564) or "--Tidal Waves";
    HEALBOT_ANACESTRAL_SWIFTNESS            = GetSpellInfo(16188) or "--Ancestral Swiftness";
    HEALBOT_LIGHTNING_SHIELD                = GetSpellInfo(324) or "--Lightning Shield";
    HEALBOT_EARTH_SHIELD                    = GetSpellInfo(974) or "--Earth Shield";
    HEALBOT_WATER_SHIELD                    = GetSpellInfo(52127) or "--Water Shield";
    HEALBOT_WATER_WALKING                   = GetSpellInfo(546) or "--Water Walking";
    --HEALBOT_EARTHLIVING                     = GetSpellInfo(51945) or "--Earthliving";
    HEALBOT_UNLEASH_ELEMENTS                = GetSpellInfo(73680) or "--Unleash Elements";
    HEALBOT_UNLEASHED_FURY                  = GetSpellInfo(117012) or "--Unleashed Fury";
    HEALBOT_ASTRAL_SHIFT                    = GetSpellInfo(108271) or "--Astral Shift";
    --HEALBOT_ANACESTRAL_VIGOR                = GetSpellInfo(105284) or "--Ancestral Vigor";
    HEALBOT_EMPOWER                         = GetSpellInfo(118350) or "--Empower";
    HEALBOT_ANACESTRAL_GUIDANCE             = GetSpellInfo(108281) or "--Ancestral Guidance";
    HEALBOT_ASCENDANCE                      = GetSpellInfo(114049) or "--Ascendance";
    HEALBOT_UNLEASH_LIFE                    = GetSpellInfo(73685) or "--Unleash Life";
    HEALBOT_UNLEASH_FLAME                   = GetSpellInfo(165462) or "--Unleash Flame";
    HEALBOT_SPIRITWALKERS_GRACE             = GetSpellInfo(79206) or "--Spiritwalker's Grace";
    HEALBOT_ELEMENTAL_MASTERY               = GetSpellInfo(16166) or "--Elemental Mastery";
    HEALBOT_SHAMANISTIC_RAGE                = GetSpellInfo(30823) or "--Shamanistic Rage";
	--WoD Added	
	HEALBOT_GENESIS                         = GetSpellInfo(145518) or "--Genesis";
	HEALBOT_ELEMENTAL_FUSION                = GetSpellInfo(152257) or "--Elemental Fusion";
	HEALBOT_CLOUDBURST_TOTEM                = GetSpellInfo(157153) or "--Cloudburst Totem";
	HEALBOT_STORM_ELEMENTAL_TOTEM           = GetSpellInfo(152256) or "--Storm Elemenal Totem";
	HEALBOT_HIGH_TIDE                       = GetSpellInfo(157154) or "--High Tide";
    
	--Monk
	HEALBOT_LEGACY_EMPEROR                  = GetSpellInfo(115921) or "--Legacy of the Emperor"
    HEALBOT_LEGACY_WHITETIGER               = GetSpellInfo(116781) or "--Legacy of the White Tiger"
    HEALBOT_RUSHING_JADE_WIND               = GetSpellInfo(116847) or "--Rushing Jade Wind"
    HEALBOT_CHI_TOROEDO                     = GetSpellInfo(115008) or "--Chi Torpedo"
	HEALBOT_LIFE_COCOON                     = GetSpellInfo(116849) or "--Life Cocoon"
    HEALBOT_THUNDER_FOCUS_TEA               = GetSpellInfo(116680) or "--Thunder Focus Tea"
    HEALBOT_SERPENT_ZEAL                    = GetSpellInfo(127722) or "--Serpent's Zeal"
    HEALBOT_MANA_TEA                        = GetSpellInfo(115867) or "--Mana Tea"
    HEALBOT_STANCE_MONK_OX                  = GetSpellInfo(115069) or "--Stance of the Sturdy Ox"
    HEALBOT_STANCE_MONK_TIGER               = GetSpellInfo(103985) or "--Stance of the Fierce Tiger"	
	HEALBOT_STANCE_MONK_SERPENT             = GetSpellInfo(115070) or "--Stance of the Wise Serpent"
	HEALBOT_STANCE_MONK_CRANE               = GetSpellInfo(154436) or "--Stance of the Spirited Crane"
    HEALBOT_ELUSIVE_BREW                    = GetSpellInfo(115308) or "--Elusive Brew"
    HEALBOT_FORTIFYING_BREW                 = GetSpellInfo(115203) or "--Fortifying Brew"
    HEALBOT_DAMPEN_HARM                     = GetSpellInfo(122278) or "--Dampen Harm"
    HEALBOT_DIFFUSE_MAGIC                   = GetSpellInfo(122783) or "--Diffuse Magic"
    --HEALBOT_AVERT_HARM                      = GetSpellInfo(115213) or "--Avert Harm"
    HEALBOT_GUARD                           = GetSpellInfo(115295) or "--Guard"
	--WoD Added
	HEALBOT_CHI_EXPLOSION                   = GetSpellInfo(157676) or "--Chi Explosion"
	HEALBOT_BREATH_OF_THE_SERPENT           = GetSpellInfo(157535) or "--Breath of the Serpent"
	HEALBOT_DETONATE_CHI                    = GetSpellInfo(115460) or "--Detonate Chi"
	HEALBOT_SERENITY                        = GetSpellInfo(152173) or "--Serenity"
	 
	--Warlock
	HEALBOT_DEMON_ARMOR                     = GetSpellInfo(687) or "--Demon Armor";
    HEALBOT_FEL_ARMOR                       = GetSpellInfo(28176) or "--Fel Armor";
    HEALBOT_SOUL_LINK                       = GetSpellInfo(19028) or "--Soul Link";
    HEALBOT_UNENDING_BREATH                 = GetSpellInfo(5697) or "--Unending Breath"
    HEALBOT_LIFE_TAP                        = GetSpellInfo(1454) or "--Life Tap";
    HEALBOT_BLOOD_PACT                      = GetSpellInfo(6307) or "--Blood Pact";
    HEALBOT_DARK_INTENT                     = GetSpellInfo(109773) or "--Dark Intent";
    HEALBOT_DARK_BARGAIN                    = GetSpellInfo(110913) or "--Dark Bargain"
    --HEALBOT_TWILIGHT_WARD                   = GetSpellInfo(6229) or "--Twilight Ward"
    HEALBOT_UNENDING_RESOLVE                = GetSpellInfo(104773) or "--Unending Resolve"
    
	--Warrior
	HEALBOT_BATTLE_SHOUT                    = GetSpellInfo(6673) or "--Battle Shout";
    HEALBOT_COMMANDING_SHOUT                = GetSpellInfo(469) or "--Commanding Shout";
    HEALBOT_INTERVENE                       = GetSpellInfo(3411) or "--Intervene";
    HEALBOT_VIGILANCE                       = GetSpellInfo(114030) or "--Vigilance";
    HEALBOT_LAST_STAND                      = GetSpellInfo(12975) or "--Last Stand";
    HEALBOT_SHIELD_WALL                     = GetSpellInfo(871) or "--Shield Wall";
    HEALBOT_SHIELD_BLOCK                    = GetSpellInfo(2565) or "--Shield Block";
    HEALBOT_ENRAGED_REGEN                   = GetSpellInfo(55694) or "--Enraged Regeneration";
    HEALBOT_SHIELD_BARRIER                  = GetSpellInfo(112048) or "--Shield Barrier"
    HEALBOT_SAFEGUARD                       = GetSpellInfo(114029) or "--Safeguard"
    
	--Rogue
	HEALBOT_VANISH                          = GetSpellInfo(1856) or "--Vanish";
    HEALBOT_FEINT                           = GetSpellInfo(1966) or "--Feint"
    HEALBOT_CLOAK_OF_SHADOWS                = GetSpellInfo(31224) or "--Cloak of Shadows"
    HEALBOT_EVASION                         = GetSpellInfo(5277) or "--Evasion";

    
	--Resurrection Spells
    HEALBOT_RESURRECTION                    = GetSpellInfo(2006) or "--Resurrection";
    HEALBOT_MASS_RESURRECTION               = GetSpellInfo(83968) or "--Mass Resurrection";
    HEALBOT_REDEMPTION                      = GetSpellInfo(7328) or "--Redemption";
    HEALBOT_REBIRTH                         = GetSpellInfo(20484) or "--Rebirth";
    HEALBOT_REVIVE                          = GetSpellInfo(50769) or "--Revive";
    HEALBOT_ANCESTRALSPIRIT                 = GetSpellInfo(2008) or "--Ancestral Spirit";
    HEALBOT_RESUSCITATE                     = GetSpellInfo(115178) or "--Resuscitate"
    HEALBOT_DEBUFF_MASS_RESURRECTED         = GetSpellInfo(95223) or "--Recently Mass Resurrected";
    
	--Cure Spells
    HEALBOT_CLEANSE                         = GetSpellInfo(4987) or "--Cleanse";
    HEALBOT_REMOVE_CURSE                    = GetSpellInfo(475) or "--Remove Curse";
    HEALBOT_REMOVE_CORRUPTION               = GetSpellInfo(2782) or "--Remove Corruption";
    HEALBOT_NATURES_CURE                    = GetSpellInfo(88423) or "--Nature's Cure";
    HEALBOT_PURIFY                          = GetSpellInfo(527) or "--Purify";
    HEALBOT_CLEANSE_SPIRIT                  = GetSpellInfo(51886) or "--Cleanse Spirit";
    HEALBOT_SACRED_CLEANSING                = GetSpellInfo(53551) or "--Sacred Cleansing";
    HEALBOT_BODY_AND_SOUL                   = GetSpellInfo(64127) or "--Body and Soul";
    HEALBOT_PURIFY_SPIRIT                   = GetSpellInfo(77130) or "--Purify Spirit";
    HEALBOT_DETOX                           = GetSpellInfo(115450) or "--Detox"; 

	--END OF SPELL LIST
	
	
	HEALBOT_DISEASE_en                      = "Disease";  -- Do NOT localize this value.
    HEALBOT_MAGIC_en                        = "Magic";  -- Do NOT localize this value.
    HEALBOT_CURSE_en                        = "Curse";  -- Do NOT localize this value.
    HEALBOT_POISON_en                       = "Poison";  -- Do NOT localize this value.
    HEALBOT_CUSTOM_en                       = "Custom";  -- Do NOT localize this value. 
	
	
	--Ignore Class Debuffs (ONLY DISPELLABLE DEBUFFS)
	HEALBOT_DEBUFF_IGNITE_MANA              = GetSpellInfo(19659) or "--Ignite Mana";
	HEALBOT_DEBUFF_TAINTED_MIND             = GetSpellInfo(16567) or "--Tainted Mind";
	HEALBOT_DEBUFF_VIPER_STING              = GetSpellInfo(39413) or "--Viper Sting";
	HEALBOT_DEBUFF_CURSE_OF_IMPOTENCE       = GetSpellInfo(34925) or "--Curse of Impotence";
	HEALBOT_DEBUFF_DECAYED_INTELLECT        = GetSpellInfo(31555) or "--Decayed Intellect";
	HEALBOT_DEBUFF_DECAYED_STRENGHT         = GetSpellInfo(6951) or "--Decayed Strength";
	HEALBOT_DEBUFF_SILENCE                  = GetSpellInfo(38913) or "--Silence";
	HEALBOT_DEBUFF_TRAMPLE                  = GetSpellInfo(126406) or "--Trample";
	HEALBOT_DEBUFF_UNSTABLE_AFFLICTION      = GetSpellInfo(35183) or "--Unstable Affliction";
	HEALBOT_DEBUFF_UNSTABLE_AFFLICTION      = GetSpellInfo(156954) or "--Unstable Affliction";	
	--Ignore Movement Debuffs (ONLY DISPELLABLE DEBUFFS)
	HEALBOT_DEBUFF_FROSTBOLT                = GetSpellInfo(69573) or "--Frostbolt";
	HEALBOT_DEBUFF_MAGMA_SHACKLES           = GetSpellInfo(19496) or "--Magma Shackles";
	HEALBOT_DEBUFF_SLOW                     = GetSpellInfo(32922) or "--Slow";
	HEALBOT_DEBUFF_CHILLED                  = GetSpellInfo(6136) or "--Chilled";
    HEALBOT_DEBUFF_CONEOFCOLD               = GetSpellInfo(64645) or "--Cone of Cold";
	HEALBOT_DEBUFF_FROST_SHOCK              = GetSpellInfo(41116) or "--Frost Shock";
	HEALBOT_DEBUFF_EARTHBIND                = GetSpellInfo(3600) or "--Earthbind";
	HEALBOT_DEBUFF_SEAL_OF_JUSTICE          = GetSpellInfo(20170) or "--Seal of Justice";	
	--Ignore Non-Harmful Debuffs (ONLY DISPELLABLE DEBUFFS)
	HEALBOT_DEBUFF_DREAMLESS_SLEEP          = GetSpellInfo(15822) or "--Dreamless Sleep";
    HEALBOT_DEBUFF_GREATER_DREAMLESS        = GetSpellInfo(24360) or "--Greater Dreamless Sleep";
    HEALBOT_DEBUFF_MAJOR_DREAMLESS          = GetSpellInfo(28504) or "--Major Dreamless Sleep";			
	
	
	--Common Buffs
    HEALBOT_ZAMAELS_PRAYER                  = GetSpellInfo(88663) or "--Zamael's Prayer";
	
	--Harmful Debuffs
	--Debuffs
    HEALBOT_DEBUFF_WEAKENED_SOUL            = GetSpellInfo(6788) or "--Weakened Soul"; --DO NOT REMOVE
	HEALBOT_DEBUFF_SAVING_GRACE             = GetSpellInfo(155274) or "--Saving Grace"; --DO NOT REMOVE
	HEALBOT_DEBUFF_ROCKET_FUEL_LEAK         = GetSpellInfo(94794) or "--Rocket Fuel Leak"; --Engineering 
			
	--[[Updated Patch 6.0.3 Warlords Of Draenor Expansion by Ariá - Silvermoon EU
	World Bosses
	Drov The Ruiner]]
    HEALBOT_DEBUFF_COLOSSAL_BLOW             = GetSpellInfo(175973) or "--Colossal Blow";
	--Tarlna The Ageless	
	HEALBOT_DEBUFF_COLOSSAL_BLOW             = GetSpellInfo(175973) or "--Colossal Blow";
	HEALBOT_DEBUFF_NOXIOUS_SPIT              = GetSpellInfo(161833) or "--Noxious Spit";
	--Rukhmar
	HEALBOT_DEBUFF_PIERCED_ARMOR             = GetSpellInfo(167615) or "--Pierced Armor";
		
	--Scenarios, Dungeons & Proving Grounds
	HEALBOT_DEBUFF_CHOMP                    = GetSpellInfo(145263) or "--Chomp";
	HEALBOT_DEBUFF_LAVA_BURNS               = GetSpellInfo(145403) or "--Lava Burns";
	--DISPELABLE (DO NOT REMOVE)
	HEALBOT_DEBUFF_WITHERING_FLAMES          = GetSpellInfo(150032) or "--Withering Flames";
	
	--[[= GetMapNameByID(994)) or "--Highmaul" 
	Trash]]
	HEALBOT_DEBUFF_MOLTEN_BOMB               = GetSpellInfo(161635) or "--Molten Bomb";
	HEALBOT_DEBUFF_TAINED_CLAWS              = GetSpellInfo(175601) or "--Tainted Claws";
	HEALBOT_DEBUFF_DEVOUR                    = GetSpellInfo(175599) or "--Devour";
	HEALBOT_DEBUFF_INFESTED_WATERS           = GetSpellInfo(164642) or "--Infested Waters";
	HEALBOT_DEBUFF_RADIATING_POISON          = GetSpellInfo(172066) or "--Radiating Poison";
	HEALBOT_DEBUFF_STAGGERING_BLOW           = GetSpellInfo(166779) or "--Staggering Blow";
	HEALBOT_DEBUFF_RUNE_OF_DESTRUCTION       = GetSpellInfo(175636) or "--Rune of Destruction";
	HEALBOT_DEBUFF_RUNE_OF_DISINTEGRATION    = GetSpellInfo(175654) or "--Rune of Disintegration";
	HEALBOT_DEBUFF_RENDING_SLASH             = GetSpellInfo(166185) or "--Rending Slash";
	HEALBOT_DEBUFF_EARTHDEVASTATING_SLAM     = GetSpellInfo(166175) or "--Earthdevastating Slam";
	HEALBOT_DEBUFF_FROZEN_CORE               = GetSpellInfo(174404) or "--Frozen Core";
	HEALBOT_DEBUFF_WILD_FLAMES               = GetSpellInfo(173827) or "--Wild Flames";
	HEALBOT_DEBUFF_RENDING_THROW             = GetSpellInfo(174500) or "--Rending Throw";
	HEALBOT_DEBUFF_ARCANE_RESIDUE            = GetSpellInfo(175056) or "--Arcane Residue";
	HEALBOT_DEBUFF_PULVERIZED                = GetSpellInfo(174452) or "--Pulverized";
	--The Butcher
	HEALBOT_DEBUFF_GUSHING_WOUNDS            = GetSpellInfo(156152) or "--Gushing Wounds";
	HEALBOT_DEBUFF_THE_TENDERIZER            = GetSpellInfo(156151) or "--The Tenderizer";
	HEALBOT_DEBUFF_THE_CLEAVER               = GetSpellInfo(156143) or "--The Cleaver";
	HEALBOT_DEBUFF_PALE_VITRIOL              = GetSpellInfo(163046) or "--Pale Vitriol"; --Mythic
	--Kargath Bladefist
	HEALBOT_DEBUFF_IMPALE                    = GetSpellInfo(159113) or "--Impale";
	HEALBOT_DEBUFF_OPEN_WOUNDS               = GetSpellInfo(159178) or "--Open Wounds";
	HEALBOT_DEBUFF_MONSTERS_BRAWL            = GetSpellInfo(159213) or "--Monster's Brawl";
	HEALBOT_DEBUFF_BERSERKER_RUSH            = GetSpellInfo(158986) or "--Berserker Rush";
	HEALBOT_DEBUFF_MAULING_BREW              = GetSpellInfo(159410) or "--Mauling Brew";
	HEALBOT_DEBUFF_VILE_BREATH               = GetSpellInfo(160521) or "--Vile Breath"; --Mythic
	HEALBOT_DEBUFF_IRON_BOMB                 = GetSpellInfo(159386) or "--Iron Bomb";
	HEALBOT_DEBUFF_GRAPPLE                   = GetSpellInfo(159188) or "--Grapple";
	HEALBOT_DEBUFF_FLAME_JET                 = GetSpellInfo(175946) or "--Flame Jet";
	HEALBOT_DEBUFF_ON_THE_HUNT               = GetSpellInfo(162497) or "--On the Hunt";
	--Twin Ogron 
	HEALBOT_DEBUFF_ENFEEBLING_ROAR           = GetSpellInfo(158026) or "--Enfeebling Roar";
	HEALBOT_DEBUFF_BLAZE                     = GetSpellInfo(158241) or "--Blaze";
	HEALBOT_DEBUFF_INJURED                   = GetSpellInfo(155569) or "--Injured";
	HEALBOT_DEBUFF_ARCANE_WOUND              = GetSpellInfo(167200) or "--Arcane Wound";
	HEALBOT_DEBUFF_WEAKENED_DEFENSES         = GetSpellInfo(159709) or "--Weakened Defenses";
	HEALBOT_DEBUFF_ARCANE_VOLATILITY         = GetSpellInfo(163372) or "--Arcane Volatility";
	--Ko'ragh
	HEALBOT_DEBUFF_CAUSTIC_ENERGY            = GetSpellInfo(161242) or "--Caustic Energy";
	HEALBOT_DEBUFF_SUPPRESSION_FIELD         = GetSpellInfo(161345) or "--Suppression Field";
	HEALBOT_DEBUFF_EXPEL_MAGIC_SHADOW        = GetSpellInfo(162184) or "--Expel Magic: Shadow";
	HEALBOT_DEBUFF_EXPEL_MAGIC_ARCANE        = GetSpellInfo(162186) or "--Expel Magic: Arcane";
	HEALBOT_DEBUFF_DOMINATING_POWER          = GetSpellInfo(163472) or "--Dominating Power";
	HEALBOT_DEBUFF_EXPEL_MAGIC_FEL           = GetSpellInfo(172917) or "--Expel Magic: Fel";
	HEALBOT_DEBUFF_NULLIFICATION_BARRIER     = GetSpellInfo(163134) or "--Nullification Barrier";
	--HEALBOT_DEBUFF_EXPEL_MAGIC_FROST         = GetSpellInfo(172813) or "--Expel Magic: Frost";
	--Tectus
	HEALBOT_DEBUFF_CRYSTALLINE_BARRAGE       = GetSpellInfo(162346) or "--Crystalline Barrage";
	HEALBOT_DEBUFF_PETRIFICATION             = GetSpellInfo(162892) or "--Petrification";
	--Brackenspore
	HEALBOT_DEBUFF_INFESTING_SPORES          = GetSpellInfo(163242) or "--Infesting Spores";
	HEALBOT_DEBUFF_CREEPING_MOSS             = GetSpellInfo(163590) or "--Creeping Moss";
	HEALBOT_DEBUFF_ROT                       = GetSpellInfo(163241) or "--Rot";
	HEALBOT_DEBUFF_NECROTIC_BREATH           = GetSpellInfo(159220) or "--Necrotic Breath";
	HEALBOT_DEBUFF_FLESH_EATER               = GetSpellInfo(159972) or "--Flesh Eater";
	HEALBOT_DEBUFF_MIND_FUNGUS               = GetSpellInfo(160179) or "--Mind Fungus";
	--Imperator Mar'gok 
	HEALBOT_DEBUFF_BRANDED                   = GetSpellInfo(156225) or "--Branded";
	HEALBOT_DEBUFF_DESTRUCTIVE_RESONANCE     = GetSpellInfo(159200) or "--Destructive Resonance";
	HEALBOT_DEBUFF_MARK_OF_CHAOS             = GetSpellInfo(158605) or "--Mark of Chaos";
	HEALBOT_DEBUFF_BRANDED_DISPLACEMENT                   = GetSpellInfo(164004) or "--Branded: Displacement";
	HEALBOT_DEBUFF_DESTRUCTIVE_RESONANCE_DISPLACEMENT     = GetSpellInfo(164075) or "--Destructive Resonance: Displacement";
	HEALBOT_DEBUFF_MARK_OF_CHAOS_DISPLACEMENT             = GetSpellInfo(164176) or "--Mark of Chaos: Displacement";	
	HEALBOT_DEBUFF_BRANDED_FORTIFICATION                   = GetSpellInfo(164005) or "--Branded: Fortification";
	HEALBOT_DEBUFF_DESTRUCTIVE_RESONANCE_FORTIFICATION     = GetSpellInfo(164076) or "--Destructive Resonance: Fortification";
	HEALBOT_DEBUFF_MARK_OF_CHAOS_FORTIFICATION             = GetSpellInfo(164178) or "--Mark of Chaos: Fortification";	
	HEALBOT_DEBUFF_BRANDED_REPLICATION                   = GetSpellInfo(164006) or "--Branded: Replication";
	HEALBOT_DEBUFF_DESTRUCTIVE_RESONANCE_REPLICATION     = GetSpellInfo(164077) or "--Destructive Resonance: Replication";
	HEALBOT_DEBUFF_MARK_OF_CHAOS_REPLICATION             = GetSpellInfo(164191) or "--Mark of Chaos: Replication";
	HEALBOT_DEBUFF_FIXATE                    = GetSpellInfo(157763) or "--Fixate";
	HEALBOT_DEBUFF_CRUSH_ARMOR               = GetSpellInfo(158553) or "--Crush Armour";
	--[[HEALBOT_DEBUFF_DESTRUCTIVE_RESONANCE     = GetSpellInfo(159200) or "--Destructive Resonance";
	HEALBOT_DEBUFF_FORCE_NOVA                = GetSpellInfo(157353) or "--Force Nova";
	HEALBOT_DEBUFF_DESTRUCTIVE_RESONANCE_DISPLACEMENT     = GetSpellInfo(164075) or "--Destructive Resonance: Displacement";
	HEALBOT_DEBUFF_FORCE_NOVA_DISPLACEMENT                = GetSpellInfo(164232) or "--Force Nova: Displacement";
	HEALBOT_DEBUFF_DESTRUCTIVE_RESONANCE_FORTIFICATION     = GetSpellInfo(164076) or "--Destructive Resonance: Fortification";
	HEALBOT_DEBUFF_FORCE_NOVA_FORTIFICATION                = GetSpellInfo(164235) or "--Force Nova: Fortification";
	HEALBOT_DEBUFF_DESTRUCTIVE_RESONANCE_REPLICATION     = GetSpellInfo(164077) or "--Destructive Resonance: Replication";
	HEALBOT_DEBUFF_FORCE_NOVA_REPLICATION                = GetSpellInfo(164240) or "--Force Nova: Replication";]]
	
	--[[= GetMapNameByID(988) or "--Blackrock Foundry"
	Trash]]
	--Blackhand
	HEALBOT_DEBUFF_MARKED_FOR_DEATH          = GetSpellInfo(156096) or "--Marked for Death";
	HEALBOT_DEBUFF_IMPALED                   = GetSpellInfo(175020) or "--Impaled";
	HEALBOT_DEBUFF_SLAGGED                   = GetSpellInfo(156047) or "--Slagged";
	HEALBOT_DEBUFF_MOLTEN_SLAG               = GetSpellInfo(156401) or "--Molten Slag";
	HEALBOT_DEBUFF_BURNED                    = GetSpellInfo(156404) or "--Burned";
	HEALBOT_DEBUFF_SHATTERING_SMASH          = GetSpellInfo(155992) or "--Shattering Smash";
	HEALBOT_DEBUFF_OVERHEATED                = GetSpellInfo(156888) or "--Overheated";	
	--Beastlord Darmac
	HEALBOT_DEBUFF_PINNED_DOWN               = GetSpellInfo(118135) or "--Marked for Death";
	HEALBOT_DEBUFF_REND_AND_TEAR             = GetSpellInfo(155061) or "--Rend and Tear";
	HEALBOT_DEBUFF_SEARED_FLESH              = GetSpellInfo(155030) or "--Seared Flesh";
	HEALBOT_DEBUFF_CRUSH_ARMOR               = GetSpellInfo(155236) or "--Crush Armour";
	HEALBOT_DEBUFF_EPICENTRE                 = GetSpellInfo(159044) or "--Epicentre";
	HEALBOT_DEBUFF_UNSTEADY                  = GetSpellInfo(162276) or "--Unsteady";
	HEALBOT_DEBUFF_FLAME_INFUSION            = GetSpellInfo(155657) or "--Flame Infusion";	
	--Flamebender Ka'graz
	HEALBOT_DEBUFF_LAVA_SLASH                = GetSpellInfo(155314) or "--Lava Slash";
	HEALBOT_DEBUFF_BLAZING_RADIANCE          = GetSpellInfo(155484) or "--Blazing Radiance";
	HEALBOT_DEBUFF_FIXATE                    = GetSpellInfo(154952) or "--Fixate";
	HEALBOT_DEBUFF_CHARRING_BREATH           = GetSpellInfo(155074) or "--Charring Breath";
	HEALBOT_DEBUFF_RISING_FLAME              = GetSpellInfo(163284) or "--Rising Flames";
	HEALBOT_DEBUFF_EMPOWERED_ARMAMENT        = GetSpellInfo(162293) or "--Empowered Armament";	
	--Operator Thogar 
	HEALBOT_DEBUFF_ENKINDLE                  = GetSpellInfo(155921) or "--Enkindle";
	HEALBOT_DEBUFF_PROTOTYPE_PULSE_GRENADE   = GetSpellInfo(165195) or "--Prototype Pulse Grenade";
	HEALBOT_DEBUFF_SERRATED_SLASH            = GetSpellInfo(155701) or "--Serrated Slash";
	HEALBOT_DEBUFF_BURNING                   = GetSpellInfo(164380) or "--Burning";
	--The Blast Furnace
	HEALBOT_DEBUFF_TEMPERED                  = GetSpellInfo(155240) or "--Tempered";
	HEALBOT_DEBUFF_HEAT                      = GetSpellInfo(155242) or "--Heat";
	HEALBOT_DEBUFF_BOMB                      = GetSpellInfo(178279) or "--Bomb";
	HEALBOT_DEBUFF_RUPTURE                   = GetSpellInfo(156932) or "--Rupture";
	HEALBOT_DEBUFF_MELT_ARMOR                = GetSpellInfo(175104) or "--Melt Armour";
	HEALBOT_DEBUFF_VOLATILE_FIRE             = GetSpellInfo(176121) or "--Volatile Fire";
	HEALBOT_DEBUFF_FIXATE                    = GetSpellInfo(158702) or "--Fixate";
	HEALBOT_DEBUFF_MELT                      = GetSpellInfo(155223) or "--Melt";
	--Hans'gar and Franzok 
	HEALBOT_DEBUFF_SHATTERED_VERTEBRAE       = GetSpellInfo(157139) or "--Shattered Vertebrae";
	HEALBOT_DEBUFF_SEARING_PLATES            = GetSpellInfo(161570) or "--Searing Plates";
	HEALBOT_DEBUFF_AFTERSHOCK                = GetSpellInfo(157853) or "--Aftershock";
	--Gruul
	HEALBOT_DEBUFF_INFERNO_SLICE             = GetSpellInfo(155080) or "--Inferno Slice";
	HEALBOT_DEBUFF_INFERNO_STRIKE            = GetSpellInfo(162322) or "--Inferno Strike";
	HEALBOT_DEBUFF_OVERWHELMING_BLOWS        = GetSpellInfo(155078) or "--Overwhelming Blows";
	HEALBOT_DEBUFF_CAVE_IN                   = GetSpellInfo(173192) or "--Cave In";
	HEALBOT_DEBUFF_FLARE                     = GetSpellInfo(165298) or "--Flare";
	--Kromog
	HEALBOT_DEBUFF_RUNE_OF_GRASPING_EARTH    = GetSpellInfo(157059) or "--Rune of Grasping Earth";
	HEALBOT_DEBUFF_WARPED_ARMOR              = GetSpellInfo(156766) or "--Warped Armor";
	HEALBOT_DEBUFF_RUNE_OF_CRUSHING_EARTH    = GetSpellInfo(161839) or "--Rune of Crushing Earth";	
	--Oregorger
	HEALBOT_DEBUFF_ACID_TORRENT              = GetSpellInfo(156297) or "--Acid Torrent";
	HEALBOT_DEBUFF_RETCHED_BLACKROCK         = GetSpellInfo(156203) or "--Retched Blackrock";
	HEALBOT_DEBUFF_EXPLOSIVE_SHARD           = GetSpellInfo(156374) or "--Explosive Shard";	
	HEALBOT_DEBUFF_ACID_MAW                  = GetSpellInfo(173471) or "--Acid Maw";
	--The Iron Maidens
	HEALBOT_DEBUFF_PENETRATING_SHOT          = GetSpellInfo(164271) or "--Penetrating Shot";  
	HEALBOT_DEBUFF_DARK_HUNT                 = GetSpellInfo(158315) or "--Dark Hunt";  
	HEALBOT_DEBUFF_SANGUINE_STRIKES          = GetSpellInfo(156601) or "--Sanguine Strikes";  	
	HEALBOT_DEBUFF_SORKAS_PREY               = GetSpellInfo(170395) or "--Sorka's Prey";
	HEALBOT_DEBUFF_MARAKS_BLOODCALLING       = GetSpellInfo(170405) or "--Marak's Bloodcalling";
	HEALBOT_DEBUFF_DEADLY_THROW              = GetSpellInfo(158692) or "--Deadly Throw";	
	HEALBOT_DEBUFF_FIXATE                    = GetSpellInfo(158702) or "--Fixate";
	HEALBOT_DEBUFF_EXPOSE_ARMOR              = GetSpellInfo(158686) or "--Expose Armour";	
	HEALBOT_DEBUFF_CORRUPTED_BLOOD           = GetSpellInfo(158683) or "--Corrupted Blood";
end

HealBot_globalVars()

if GetLocale()=="ptBR" then
    HEALBOT_ALT_RENEWING_MIST = "Brumas da Renovação"
else
    HEALBOT_ALT_RENEWING_MIST = HEALBOT_RENEWING_MIST
end
