HEALBOT_VERSION_SC = "9.2.0.11";
HEALBOT_VERSION    = GetAddOnMetadata("HealBot", "Version") or "9.x"
HEALBOT_ABOUT_URL  = "healbot.dpm15.net"

local vMajor         = string.split(".", select(1, GetBuildInfo()))
HEALBOT_GAME_VERSION = tonumber(vMajor)

function HealBot_globalVars()
    --Consumables
    --Bandages
    HEALBOT_LINEN_BANDAGE                   = 1251 --GetItemInfo(1251) or "--Linen Bandage";
    HEALBOT_HEAVY_LINEN_BANDAGE             = 2581 --GetItemInfo(2581) or "--Heavy Linen Bandage";
    HEALBOT_WOOL_BANDAGE                    = 3530 --GetItemInfo(3530) or "--Wool Bandage";
    HEALBOT_HEAVY_WOOL_BANDAGE              = 3531 --GetItemInfo(3531) or "--Heavy Wool Bandage";
    HEALBOT_SILK_BANDAGE                    = 6450 --GetItemInfo(6450) or "--Silk Bandage";
    HEALBOT_HEAVY_SILK_BANDAGE              = 6451 --GetItemInfo(6451) or "--Heavy Silk Bandage";
    HEALBOT_MAGEWEAVE_BANDAGE               = 8544 --GetItemInfo(8544) or "--Mageweave Bandage";
    HEALBOT_HEAVY_MAGEWEAVE_BANDAGE         = 8545 --GetItemInfo(8545) or "--Heavy Mageweave Bandage";
    HEALBOT_RUNECLOTH_BANDAGE               = 14529 --GetItemInfo(14529) or "--Runecloth Bandage";
    HEALBOT_HEAVY_RUNECLOTH_BANDAGE         = 14530 --GetItemInfo(14530) or "--Heavy Runecloth Bandage";
    HEALBOT_NETHERWEAVE_BANDAGE             = 21990 --GetItemInfo(21990) or "--Netherweave Bandage";
    HEALBOT_HEAVY_NETHERWEAVE_BANDAGE       = 21991 --GetItemInfo(21991) or "--Heavy Netherweave Bandage";
    HEALBOT_FROSTWEAVE_BANDAGE              = 34721 --GetItemInfo(34721) or "--Frostweave Bandage";
    HEALBOT_HEAVY_FROSTWEAVE_BANDAGE        = 34722 --GetItemInfo(34722) or "--Heavy Frostweave Bandage";
    HEALBOT_EMBERSILK_BANDAGE               = 53049 --GetItemInfo(53049) or "--Embersilk Bandage";
    HEALBOT_HEAVY_EMBERSILK_BANDAGE         = 53050 --GetItemInfo(53050) or "--Heavy Embersilk Bandage";
    HEALBOT_DENSE_EMBERSILK_BANDAGE         = 53051 --GetItemInfo(53051) or "--Dense Embersilk Bandage";
    HEALBOT_WINDWOOL_BANDAGE                = 72985 --GetItemInfo(72985) or "--Windwool Bandage";
    HEALBOT_HEAVY_WINDWOOL_BANDAGE          = 72986 --GetItemInfo(72986) or "--Heavy Windwool Bandage";
    HEALBOT_ASHRAN_BANDAGE                  = 115497 --GetItemInfo(115497) or "--Ashran Bandage";
    HEALBOT_SILKWEAVE_BANDAGE               = 133940 --GetItemInfo(133940) or "--Silkweave Bandage";
    HEALBOT_DEEP_SEA_BANDAGE                = 158382 --GetItemInfo(158382) or "--Deep Sea Bandage";
    HEALBOT_TIDESPRAY_LINEN_BANDAGE         = 158381 --GetItemInfo(158381) or "--Tidespray Linen Bandage";
    HEALBOT_SHROUDED_CLOTH_BANDAGE          = 173192 --GetItemInfo(173192) or "--Shrouded Cloth Bandage";
    HEALBOT_HEAVY_SHROUDED_CLOTH_BANDAGE    = 173191 --GetItemInfo(173191) or "--Heavy Shrouded Cloth Bandage";
    --Potions
    HEALBOT_MAJOR_HEALING_POTION            = 13446 --GetItemInfo(13446) or "--Major Healing Potion";
    HEALBOT_SUPER_HEALING_POTION            = 22829 --GetItemInfo(22829) or "--Super Healing Potion";
    HEALBOT_MAJOR_COMBAT_HEALING_POTION     = 31838 --GetItemInfo(31838) or "--Major Combat Healing Potion";
    HEALBOT_RUNIC_HEALING_POTION            = 33447 --GetItemInfo(33447) or "--Runic Healing Potion";
    HEALBOT_ENDLESS_HEALING_POTION          = 43569 --GetItemInfo(43569) or "--Endless Healing Potion";
    HEALBOT_MAJOR_MANA_POTION               = 13444 --GetItemInfo(13444) or "--Major Mana Potion";
    HEALBOT_SUPER_MANA_POTION               = 22832 --GetItemInfo(22832) or "--Super Mana Potion";
    HEALBOT_MAJOR_COMBAT_MANA_POTION        = 31840 --GetItemInfo(31840) or "--Major Combat Mana Potion";
    HEALBOT_RUNIC_MANA_POTION               = 33448 --GetItemInfo(33448) or "--Runic Mana Potion";
    HEALBOT_ENDLESS_MANA_POTION             = 43570 --GetItemInfo(43570) or "--Endless Mana Potion";
    HEALBOT_PURIFICATION_POTION             = 13462 --GetItemInfo(13462) or "--Purification Potion";
    HEALBOT_ANTI_VENOM                      = 6452 --GetItemInfo(6452) or "--Anti-Venom";
    HEALBOT_POWERFUL_ANTI_VENOM             = 19440 --GetItemInfo(19440) or "--Powerful Anti-Venom";
    HEALBOT_ELIXIR_OF_POISON_RES            = 3386 --GetItemInfo(3386) or "--Potion of Curing";
    HEALBOT_SOULFUL_HEALING_POTION          = 180317 --GetItemInfo(180317) or "--Soulful Healing Potion";
    HEALBOT_SPIRITUAL_HEALING_POTION        = 171267 --GetItemInfo(171267) or "--Spiritual Healing Potion";
    HEALBOT_SOULFUL_MANA_POTION             = 180318 --GetItemInfo(180318) or "--Soulful Mana Potion";
    HEALBOT_SPIRITUAL_MANA_POTION           = 171268 --GetItemInfo(171268) or "--Spiritual Mana Potion";
    HEALBOT_POTION_OF_SOUL_PURITY           = 171263 --GetItemInfo(171263) or "--Potion of Soul Purity";
    HEALBOT_PHIAL_OF_SERENITY               = 177278 --GetItemInfo(177278) or "--Phial of Serenity";

    --Items
    HEALBOT_BLOOM                           = 176160 --GetSpellInfo(176160) or "--Bloom";
    HEALBOT_EVER_BLOOMING_FROND             = 118935 --GetItemInfo(118935) or "--Ever-Blooming Frond";
    HEALBOT_ORALIUS_WHISPERING_CRYSTAL      = 118922 --GetItemInfo(118922) or "--Oralius' Whispering Crystal";
    HEALBOT_WHISPERS_OF_INSANITY            = 176151 --GetSpellInfo(176151) or "--Whispers of Insanity";
    HEALBOT_REPURPOSED_FEL_FOCUSER          = 147707 --GetItemInfo(147707) or "--Repurposed Fel Focuser";
    HEALBOT_FEL_FOCUS                       = 242551 --GetSpellInfo(242551) or "--Fel Focus";    
    HEALBOT_SHROUD_OF_THE_NAGLFAR           = 215247 --GetSpellInfo(215247) or "--Shroud of the Naglfar";
    HEALBOT_SPIRIT_FRAGMENT                 = 221878 --GetSpellInfo(221878) or "--Spirit Fragment";
    HEALBOT_NORGANNONS_FORESIGHT            = 208215 --GetSpellInfo(208215) or "--Norgannon's Foresight";
    HEALBOT_DELICIOUS_CAKE                  = 225126 --GetSpellInfo(225126) or "--Delicious Cake!";
    HEALBOT_GUIDING_HAND                    = 242622 --GetSpellInfo(242622) or "--Guiding Hand";
    HEALBOT_FRUITFUL_MACHINATIONS           = 242623 --GetSpellInfo(242623) or "--Fruitful Machinations";
    HEALBOT_HIGHFATHERS_TIMEKEEPING         = 253287 --GetSpellInfo(253287) or "--Highfather's Timekeeping";
    --HEALBOT_AOF_INFUSION_OF_LIGHT           = 242621 --GetSpellInfo(242621) or "--Infusion of Light";
    HEALBOT_OCEANS_EMBRACE                  = 242467 --GetSpellInfo(242467) or "--Ocean's Embrace";
    HEALBOT_VELENS_FUTURE_SIGHT             = 235966 --GetSpellInfo(235966) or "--Velen's Future Sight"
    HEALBOT_SEPHUZS_SECRET                  = 208052 --GetSpellInfo(208052) or "--Sephuz's Secret"
    HEALBOT_BATTLE_SCARRED_AUGMENT_RUNE     = 160053 --GetItemInfo(160053) or "--Battle-Scarred Augment Rune"
    HEALBOT_BATTLE_SCARRED_AUGMENT          = 270058 --GetSpellInfo(270058) or "--Battle-Scarred Augment"
    HEALBOT_LIGHTNING_FORGED_AUGMENT_RUNE   = 174906 --GetItemInfo(174906) or "--Lightning-Forged Augment Rune"
    HEALBOT_LIGHTNING_FORGED_AUGMENT        = 317065 --GetSpellInfo(317065) or "--Battle-Scarred Augment"
    HEALBOT_VEILED_AUGMENT_RUNE             = 181468 --GetItemInfo(181468) or "--Veiled Augment Rune"
    HEALBOT_VEILED_AUGMENTATION             = 347901 --GetSpellInfo(347901) or "--Veiled Augmentation"
    HEALBOT_TAILWIND_SAPPHIRE               = 284567 --GetItemInfo(284567) or "--Tailwind Sapphire"
    HEALBOT_TAILWIND                        = 284573 --GetSpellInfo(284573) or "--Tailwind"
    HEALBOT_AMETHYST_OF_THE_SHADOW_KING     = 284558 --GetItemInfo(284558) or "--Amethyst of the Shadow King"
    HEALBOT_SHADOW_TOUCHED                  = 284556 --GetSpellInfo(284556) or "--Shadow-Touched"
    HEALBOT_INGENIOUS_MANA_BATTERY          = 169344 
    
    HEALBOT_WELL_FED                        = "Well Fed"
    --Procs
    HEALBOT_CONCORDANCE_OF_THE_LEGIONFALL   = 242586 --GetSpellInfo(242586) or "--Concordance of the Legionfall";
    HEALBOT_BRACING_CHILL                   = 272276 --GetSpellInfo(267884) or "--Bracing Chill";
    HEALBOT_BLESSED_PORTENTS                = 271843 --GetSpellInfo(267889) or "--Blessed Portents";
    
    --Racial Abilities
    HEALBOT_DARKFLIGHT                      = 68992 --GetSpellInfo(68992) or "--Darkflight";
    HEALBOT_GIFT_OF_THE_NAARU               = 28880 --GetSpellInfo(59547) or "--Gift of the Naaru";
    HEALBOT_STONEFORM                       = 20594 --GetSpellInfo(20594) or "--Stoneform";

    --Weapon Enchants
    HEALBOT_FLAMETONGUE_SPELL               = 318038
    HEALBOT_FLAMETONGUE_ENCHANT             = 5400
    HEALBOT_WINDFURY_SPELL                  = 33757
    HEALBOT_WINDFURY_ENCHANT                = 5401
    HEALBOT_BRILLIANT_MANA_OIL_SPELL        = 20748
    HEALBOT_BRILLIANT_MANA_OIL_ENCHANT      = 2629
    HEALBOT_SUPERIOR_MANA_OIL_SPELL         = 22521
    HEALBOT_SUPERIOR_MANA_OIL_ENCHANT       = 28016
    HEALBOT_BRILLIANT_WIZARD_OIL_SPELL      = 20749
    HEALBOT_BRILLIANT_WIZARD_OIL_ENCHANT    = 2628
    HEALBOT_SUPERIOR_WIZARD_OIL_SPELL       = 22522
    HEALBOT_SUPERIOR_WIZARD_OIL_ENCHANT     = 28019
    HEALBOT_BLESSED_WIZARD_OIL_SPELL        = 23123
    HEALBOT_BLESSED_WIZARD_OIL_ENCHANT      = 2685
    --Harmful Spells
    --Death Knight
    HEALBOT_DEATH_COIL                      = 47541 --GetSpellInfo(47541) or "--Death Coil"
    HEALBOT_PLAGUE_STRIKE                   = 45462 --GetSpellInfo(45462) or "--Plague Strike"
    --Demon Hunter
    --Druid
    HEALBOT_CYCLONE                         = 33786 --GetSpellInfo(33786) or "--Cyclone"
    HEALBOT_ENTANGLING_ROOTS                = 339 --GetSpellInfo(339)  or "--Entangling Roots"
    HEALBOT_FAERIE_FIRE                     = 770 --GetSpellInfo(770)  or "--Faerie Fire"
    HEALBOT_FAERIE_SWARM                    = 106707 --GetSpellInfo(106707) or "--Faerie Swarm"
    HEALBOT_GROWL                           = 6795 --GetSpellInfo(6795) or "--Growl"
    HEALBOT_HURRICANE                       = 16914 --GetSpellInfo(16914)  or "--Hurricane"
    HEALBOT_MASS_ENTANGLEMENT               = 102359 --GetSpellInfo(102359) or "--Mass Entanglement"
    HEALBOT_MOONFIRE                        = 8921 --GetSpellInfo(8921) or "--Moonfire"
    HEALBOT_SOOTHE                          = 2908 --GetSpellInfo(2908) or "--Soothe"
    HEALBOT_WRATH                           = 5176 --GetSpellInfo(5176)  or "--Wrath"
    --Hunter
    HEALBOT_AIMED_SHOT                      = 19434 --GetSpellInfo(19434) or "--Aimed Shot"  
    HEALBOT_ARCANE_SHOT                     = 3044 --GetSpellInfo(3044) or "--Arcane Shot"
    HEALBOT_CONCUSSIVE_SHOT                 = 5116 --GetSpellInfo(5116) or "--Concussive Shot"
    --Mage
    HEALBOT_FIRE_BLAST                      = 2136 --GetSpellInfo(2136) or "--Fire Blast" 
    HEALBOT_FROSTFIRE_BOLT                  = 44614 --GetSpellInfo(44614) or "--Frostfire Bolt"
    HEALBOT_MAGE_BOMB                       = 125430 --GetSpellInfo(125430) or "--Mage Bomb" 
    --Monk
    HEALBOT_BLACKOUT_KICK                   = 100784 --GetSpellInfo(100784) or "--Blackout Kick"
    HEALBOT_CHI_BURST                       = 123986 --GetSpellInfo(123986) or "--Chi Burst"
    HEALBOT_CRACKLING_JADE_LIGHTNING        = 117952 --GetSpellInfo(117952) or "--Crackling Jade Lightning"
    HEALBOT_DISABLE                         = 116095 --GetSpellInfo(116095) or "--Disable"
    HEALBOT_EXPEL_HARM                      = 115072 
    HEALBOT_JAB                             = 100780 --GetSpellInfo(100780) or "--Jab"
    HEALBOT_PARALYSIS                       = 115078 --GetSpellInfo(115078) or "--Paralysis"
    HEALBOT_PROVOKE                         = 115546 --GetSpellInfo(115546) or "--Provoke"
    HEALBOT_SPEAR_HAND_STRIKE               = 116705 --GetSpellInfo(116705) or "--Spear Hand Strike"
    HEALBOT_TIGER_PALM                      = 100787 --GetSpellInfo(100787) or "--Tiger Palm"
    HEALBOT_TOUCH_OF_DEATH                  = 115080 --GetSpellInfo(115080) or "--Touch of Death"
    HEALBOT_TOUCH_OF_DEATH                  = 115080 --GetSpellInfo(115080) or "--Touch of Death"
    --Paladin
    HEALBOT_BINDING_LIGHT                   = 115750 --GetSpellInfo(115750) or "--Blinding Light"
    HEALBOT_CRUSADER_STRIKE                 = 35395 --GetSpellInfo(35395) or "--Crusader Strike"
    HEALBOT_DENOUNCE                        = 2812 --GetSpellInfo(2812) or "--Denounce"
    HEALBOT_HAMMER_OF_JUSTICE               = 853 --GetSpellInfo(853) or "--Hammer of Justice"
    HEALBOT_HAMMER_OF_WRATH                 = 24275 --GetSpellInfo(24275) or "--Hammer of Wrath"
    HEALBOT_HOLY_SHOCK                      = 20473 --GetSpellInfo(20473) or "--Holy Shock"
    HEALBOT_JUDGMENT                        = 20271 --GetSpellInfo(20271) or "--Judgment"
    HEALBOT_REBUKE                          = 96231 --GetSpellInfo(96231) or "--Rebuke"
    HEALBOT_RECKONING                       = 62124 --GetSpellInfo(62124) or "--Reckoning"
    HEALBOT_REPENTANCE                      = 20066 --GetSpellInfo(20066) or "--Repentance"
    HEALBOT_SHIELD_OF_THE_RIGHTEOUS         = 53600 --GetSpellInfo(53600) or "--Shield of the Righteous";
    HEALBOT_TURN_EVIL                       = 10326 --GetSpellInfo(10326) or "--Turn Evil"
    --Priest
    HEALBOT_DOMINATE_MIND                   = 605 --GetSpellInfo(605) or "--Dominate Mind"
    HEALBOT_HOLY_FIRE                       = 14914 --GetSpellInfo(14914) or "--Holy Fire"
    HEALBOT_MIND_SEAR                       = 48045 --GetSpellInfo(48045) or "--Mind Sear"
    HEALBOT_MINDBENDER                      = 123040 --GetSpellInfo(123040) or "--Mindbender"
    HEALBOT_SHACKLE_UNDEAD                  = 9484 --GetSpellInfo(9484) or "--Shackle Undead"
    HEALBOT_SHADOW_WORD_PAIN                = 589 --GetSpellInfo(589) or "--Shadow Word: Pain"
    HEALBOT_SHADOW_WORD_DEATH               = 32379 --GetSpellInfo(32379) or "--Shadow Word: Death"
    HEALBOT_SMITE                           = 585 --GetSpellInfo(585) or "--Smite"
    HEALBOT_HOLY_WORD_CHASTISE              = 88625 --GetSpellInfo(88625) or "--Holy Word: Chastise";
    HEALBOT_DISPEL_MAGIC                    = 528 --GetSpellInfo(528) or "--Dispel Magic"
    --Rogue
    HEALBOT_GOUGE                           = 1776 --GetSpellInfo(1776) or "--Gouge"
    HEALBOT_THROW                           = 121733 --GetSpellInfo(121733) or "--Throw"  
    --Shaman
    HEALBOT_CHAIN_LIGHTNING                 = 421 --GetSpellInfo(421) or "--Chain Lightning"
    HEALBOT_EARTH_SHOCK                     = 8042 --GetSpellInfo(8042) or "--Earth Shock"
    HEALBOT_ELEMENTAL_BLAST                 = 117014 --GetSpellInfo(117014) or "--Elemental Blast"
    HEALBOT_FLAME_SHOCK                     = 188389
    HBC_FLAME_SHOCK                         = 8050 --GetSpellInfo(8050) or "--Flame Shock"
    HEALBOT_FROST_SHOCK                     = 8056 --GetSpellInfo(8056) or "--Frost Shock"
    HEALBOT_HEX                             = 51514 --GetSpellInfo(51514) or "--Hex"
    HEALBOT_LAVA_BLAST                      = 51505 --GetSpellInfo(51505) or "--Lava Blast"
    HEALBOT_LIGHTNING_BOLT                  = 188196
    HBC_LIGHTNING_BOLT                      = 403
    HEALBOT_PRIMAL_STRIKE                   = 73899 --GetSpellInfo(73899) or "--Primal Strike"
    HEALBOT_PURGE                           = 370 --GetSpellInfo(370) or "--Purge"
    HEALBOT_WIND_SHEAR                      = 57994 --GetSpellInfo(57994) or "--Wind Shear" 
    --Warlock
    HEALBOT_CORRUPTION                      = 172 --GetSpellInfo(172) or "--Corruption" 
    HEALBOT_FEAR                            = 5782 --GetSpellInfo(5782) or "--Fear"   
    --Warrior
    HEALBOT_EXECUTE                         = 5308 --GetSpellInfo(5308) or "--Execute"
    HEALBOT_TAUNT                           = 355 --GetSpellInfo(355) or "--Taunt"

    --Healing Spells By Class 
    --Druid
    HEALBOT_CENARION_WARD                   = 102352 --GetSpellInfo(102351) or "--Cenarion Ward";
    HEALBOT_HEALING_TOUCH                   = 5185 --GetSpellInfo(5185) or "--Healing Touch";
    HEALBOT_LIFEBLOOM                       = 33763 --GetSpellInfo(33763) or "--Lifebloom";
    HEALBOT_REGROWTH                        = 8936 --GetSpellInfo(8936) or "--Regrowth";
    HEALBOT_REJUVENATION                    = 774 --GetSpellInfo(774) or "--Rejuvenation";
    HEALBOT_SWIFTMEND                       = 18562 --GetSpellInfo(18562) or "--Swiftmend";
    HEALBOT_TRANQUILITY                     = 157982 --GetSpellInfo(740) or "--Tranquility";
    HEALBOT_WILD_GROWTH                     = 48438 --GetSpellInfo(48438) or "--Wild Growth";
    HEALBOT_NOURISH                         = 289022
    HEALBOT_OVERGROWTH                      = 203651
    --Monk
    HEALBOT_CHI_WAVE                        = 132463 --GetSpellInfo(132463) or "--Chi Wave"
    HEALBOT_CHI_BURST                       = 130651 --GetSpellInfo(130651) or "--Chi Burst"
    HEALBOT_ENVELOPING_MIST                 = 124682 --GetSpellInfo(124682) or "--Enveloping Mist"
    HEALBOT_RENEWING_MIST                   = 119611 --GetSpellInfo(115151) or "--Renewing Mist"
    HEALBOT_REVIVAL                         = 115310 --GetSpellInfo(115310) or "--Revival"
    HEALBOT_SOOTHING_MIST                   = 198533 --GetSpellInfo(115175) or "--Soothing Mist" 
    HEALBOT_SURGING_MIST                    = 116694 --GetSpellInfo(116694) or "--Surging Mist" 
    HEALBOT_UPLIFT                          = 116670 --Changed to Vivify
    HEALBOT_ZEN_MEDITATION                  = 115176 --GetSpellInfo(115176) or "--Zen Meditation"
    HEALBOT_ZEN_SPHERE                      = 124081 --GetSpellInfo(124081) or "--Zen Sphere"
    --Paladin
    HEALBOT_FLASH_OF_LIGHT                  = 19750 --GetSpellInfo(19750) or "--Flash of Light";
    HEALBOT_HOLY_LIGHT                      = 82326 --GetSpellInfo(82326) or "--Holy Light";
    HBC_HOLY_LIGHT                          = 635 --GetSpellInfo(635) or "--Holy Light";
    HEALBOT_HOLY_PRISM                      = 114165 --GetSpellInfo(114165) or "--Holy Prism";
    HEALBOT_HOLY_RADIANCE                   = 82327 --GetSpellInfo(82327) or "--Holy Radiance";
    HEALBOT_LIGHT_OF_DAWN                   = 85222 --GetSpellInfo(85222) or "--Light of Dawn";
    HEALBOT_WORD_OF_GLORY                   = 85673 --GetSpellInfo(85673) or "--Word of Glory";
    --Priest
    HEALBOT_BINDING_HEAL                    = 32546 --GetSpellInfo(32546) or "--Binding Heal"
    HEALBOT_CASCADE                         = 121135 --GetSpellInfo(121135) or "--Cascade"
    HEALBOT_CIRCLE_OF_HEALING               = 204883 --GetSpellInfo(204883) or "--Circle of Healing";
    HEALBOT_DESPERATE_PRAYER                = 19236 --GetSpellInfo(19236) or "--Desperate Prayer";
    HEALBOT_DIVINE_HYMN                     = 64844 --GetSpellInfo(64843) or "--Divine Hymn";
    HEALBOT_DIVINE_STAR                     = 110744 --GetSpellInfo(110744) or "--Divine Star"
    HEALBOT_FLASH_HEAL                      = 2061 --GetSpellInfo(2061) or "--Flash Heal";
    HEALBOT_HALO                            = 120517 --GetSpellInfo(120517) or "--Halo"
    HEALBOT_HEAL                            = 2060 --GetSpellInfo(2060) or "--Heal"; -- Greater Heal in Classic
    HBC_HEAL                                = 2054 
    HEALBOT_HOLY_WORD_SALVATION             = 265202 --GetSpellInfo(265202) or "--Holy Word: Salvation";
    HEALBOT_HOLY_WORD_SERENITY              = 2050 --Lesser Heal in Classic
    HEALBOT_PENANCE                         = 47540 --GetSpellInfo(47540) or "--Penance"
    HEALBOT_PRAYER_OF_HEALING               = 596 --GetSpellInfo(596) or "--Prayer of Healing";
    HEALBOT_PRAYER_OF_MENDING               = 33076 --GetSpellInfo(33076) or "--Prayer of Mending";  41635=buff icon - 33076=known spell
    HEALBOT_RENEW                           = 139 --GetSpellInfo(139) or "--Renew";
    HEALBOT_PLEA                            = 200829 --GetSpellInfo(200829) or "--Plea";    
    HEALBOT_POWER_WORD_RADIANCE             = 194509 --GetSpellInfo(194509) or "--Power Word: Radiance";
    HEALBOT_SHADOW_MEND                     = 186263 --GetSpellInfo(186263) or "--Shadow Mend;"
    HEALBOT_HOLY_WORD_SANCTIFY              = 34861 --GetSpellInfo(34861) or "--Holy Word: Sanctify";
    HEALBOT_SPIRIT_OF_REDEMPTION            = 27827 --GetSpellInfo(20711) or "--Spirit of Redemption";
    HEALBOT_HOLY_WARD                       = 213610 --GetSpellInfo(213610) or "--Holy Ward";
    HBC_HOLY_NOVA                           = 15237
    HEALBOT_UNHOLY_HOVA                     = 324724
    
    --Shaman
    HEALBOT_CHAIN_HEAL                      = 1064 --GetSpellInfo(1064) or "--Chain Heal";
    HEALBOT_HEALING_RAIN                    = 73920 --GetSpellInfo(73920) or "--Healing Rain";
    HEALBOT_HEALING_STREAM_TOTEM            = 5394 --GetSpellInfo(119523) or "--Healing Stream Totem";
    HEALBOT_HEALING_SURGE                   = 8004 --GetSpellInfo(8004) or "--Healing Surge";
    HEALBOT_HEALING_TIDE_TOTEM              = 108280 --GetSpellInfo(108280) or "--Healing Tide Totem";
    HEALBOT_HEALING_WAVE                    = 77472 --GetSpellInfo(77472) or "--Healing Wave";
    HBC_LESSER_HEALING_WAVE                 = 8004
    HBC_HEALING_WAVE                        = 331
    HEALBOT_PRIMORDIAL_WAVE                 = 326059
    HEALBOT_RIPTIDE                         = 61295 --GetSpellInfo(61295) or "--Riptide";
    HEALBOT_WELLSPRING                      = 197995 --GetSpellInfo(197995) or "--Wellspring";
    HEALBOT_DOWNPOUR                        = 207778 --GetSpellInfo(207778) or "--Downpour";
    --Warlock
    HEALBOT_HEALTH_FUNNEL                   = 755 --GetSpellInfo(755) or "--Health Funnel";

    HBC_INSPELLS = { [5185]=55,    [5186]=119,   [5187]=253,   [5188]=459,   [5189]=712,   [6778]=914,  -- Healing Touch
                     [8903]=1143,  [9758]=1453,  [9888]=1826,  [9889]=2257,  [25297]=2677,              -- Healing Touch
                   }
    --Buffs, Talents, Traits, Glyphs and Other Spells By Class
    --Death Knight
    HEALBOT_ANTIMAGIC_SHELL                 = 48707 --GetSpellInfo(48707) or "--Antimagic Shell";
    HEALBOT_ANTIMAGIC_ZONE                  = 51052 --GetSpellInfo(51052) or "--Antimagic Zone";
    HEALBOT_ARMY_OF_THE_DEAD                = 42650 --GetSpellInfo(42650) or "--Army of the Dead";
    HEALBOT_BONE_SHIELD                     = 49222 --GetSpellInfo(49222) or "--Bone Shield";
    HEALBOT_DANCING_RUNE_WEAPON             = 81256 --GetSpellInfo(49028) or "--Dancing Rune Weapon"
    HEALBOT_HORN_OF_WINTER                  = 57330 --GetSpellInfo(57330) or "--Horn of Winter";
    HEALBOT_ICEBOUND_FORTITUDE              = 48792 --GetSpellInfo(48792) or "--Icebound Fortitude";
    --HEALBOT_LICHBORNE                       = 49039 --GetSpellInfo(49039) or "--Lichborne";
    HEALBOT_POWER_OF_THE_GRAVE              = 155522 --GetSpellInfo(155522) or "--Power of the Grave";  
    HEALBOT_SHROUD_OF_PURGATORY             = 116888 --GetSpellInfo(116888) or "--Shroud of Purgatory"; 
    HEALBOT_UNHOLY_AURA                     = 55610 --GetSpellInfo(55610) or "--Unholy Aura"
    HEALBOT_VAMPIRIC_BLOOD                  = 55233 --GetSpellInfo(55233) or "--Vampiric Blood";
    
    --Demon Hunter
    HEALBOT_DEMON_SPIKES                    = 203720 --GetSpellInfo(203720) or "--Demon Spikes";
    HEALBOT_BLUR                            = 212800 --GetSpellInfo(198589) or "--Blur"
    --HEALBOT_EMPOWER_WARDS                   = 218256 --GetSpellInfo(218256) or "--Empower Wards";
    HEALBOT_METAMORPHOSIS                   = 187827 --GetSpellInfo(187827) or "--Metamorphosis";
    
    --Druid
    HEALBOT_BARKSKIN                        = 22812 --GetSpellInfo(22812) or "--Barkskin";
    HEALBOT_CULTIVATION                     = 200389 --GetSpellInfo(200390) or "--Cultivation";
    HEALBOT_DRUID_CLEARCASTING              = 16870 --GetSpellInfo(16870) or "--Clearcasting";
    HEALBOT_FRENZIED_REGEN                  = 22842 --GetSpellInfo(22842) or "--Frenzied Regeneration";
    HBC_GIFT_OF_THE_WILD                    = 21849
    HEALBOT_HARMONY                         = 77495 --GetSpellInfo(77495) or "--Mastery Harmony";
    HEALBOT_INNERVATE                       = 29166 --GetSpellInfo(29166) or "--Innervate";
    HEALBOT_IRONBARK                        = 102342 --GetSpellInfo(102342) or "--Ironbark";
    HEALBOT_IRONFUR                         = 192081 --GetSpellInfo(192081) or "--Ironfur";
    HEALBOT_LEADER_OF_THE_PACK              = 17007 --GetSpellInfo(17007) or "--Leader of the Pack";
    --HEALBOT_LIVING_SEED                     = 48500 --GetSpellInfo(48500) or "--Living Seed";
    HEALBOT_MARK_OF_THE_WILD                = 1126 --GetSpellInfo(1126) or "--Mark of the Wild";
    HEALBOT_MOONKIN_AURA                    = 24907 --GetSpellInfo(24907) or "--Moonkin Aura";
    HBC_NATURE_GRASP                        = 16689
    HEALBOT_NATURE_MOMENT_OF_CLARITY        = 236068 --GetSpellInfo(236068) or "--Moment of Clarity";
    HEALBOT_NATURE_REJUVENATION_GERMINATION = 155777 --GetSpellInfo(155777) or "--Rejuvenation (Germination)";
    HEALBOT_NATURE_RAMPANT_GROWTH           = 155834 --GetSpellInfo(155834) or "--Rampant Growth";
    HBC_OMEN_OF_CLARITY                     = 16864
    HEALBOT_SAVAGE_DEFENCE                  = 62606 --GetSpellInfo(62606) or "--Savage Defense";
    HEALBOT_SURVIVAL_INSTINCTS              = 61336 --GetSpellInfo(61336) or "--Survival Instincts";
    HEALBOT_TREE_OF_LIFE                    = 33891 --GetSpellInfo(33891) or "--Tree of Life";
    HEALBOT_SPRING_BLOSSOMS                 = 207386 --GetSpellInfo(207385) or "--Spring Blossoms";
    HEALBOT_ESSENCE_OF_GHANIR               = 208253 --GetSpellInfo(208253) or "--Essence of G'Hanir"
    HEALBOT_FOCUSED_GROWTH                  = 203554 --GetSpellInfo(203554) or "--Focused Growth"
    HEALBOT_GROVE_TENDING                    = 279793 --GetSpellInfo(279793) or "--Grove Tending";
    HBC_THORNS                              = 467
    --Hunter
    HEALBOT_A_CHEETAH                       = 5118 --GetSpellInfo(5118) or "--Aspect of the Cheetah"
    HEALBOT_A_PACK                          = 13159 --GetSpellInfo(13159) or "--Aspect of the Pack"
    HEALBOT_A_WILD                          = 20043 --GetSpellInfo(20043) or "--Aspect of the Wild"
    HEALBOT_DETERRENCE                      = 19263 --GetSpellInfo(19263) or "--Deterrence"
    HEALBOT_LW_FEROCITY_OF_THE_RAPTOR       = 160200 --GetSpellInfo(160200) or "--Lone Wolf: Ferocity of the Raptor"
    HEALBOT_LW_FORTITUDE_OF_THE_BEAR        = 160199 --GetSpellInfo(160199) or "--Lone Wolf: Fortitude of the Bear"
    HEALBOT_LW_GRACE_OF_THE_CAT             = 160198 --GetSpellInfo(160198) or "--Lone Wolf: Grace of the Cat"
    HEALBOT_LW_HASTE_OF_THE_HYENA           = 160203 --GetSpellInfo(160203) or "--Lone Wolf: Haste of the Hyena"
    HEALBOT_LW_POWER_OF_THE_PRIMATES        = 160206 --GetSpellInfo(160206) or "--Lone Wolf: Power of the Primates"
    HEALBOT_LW_QUICKNESS_OF_THE_DRAGONHAWK  = 172968 --GetSpellInfo(172968) or "--Lone Wolf: Quickness of the Dragonhawk"
    HEALBOT_LW_VERSATILITY_OF_THE_RAVAGER   = 172967 --GetSpellInfo(172967) or "--Lone Wolf: Versatility of the Ravager"
    HEALBOT_LW_WISDOM_OF_THE_SERPENT        = 160205 --GetSpellInfo(160205) or "--Lone Wolf: Wisdom of the Serpent"
    HEALBOT_MENDPET                         = 136 --GetSpellInfo(136) or "--Mend Pet"
    HEALBOT_TRAP_LAUNCHER                   = 77769 --GetSpellInfo(77769) or "--Trap Launcher"
    HEALBOT_TRUESHOT_AURA                   = 19506 --GetSpellInfo(19506) or "--Trueshot Aura"
    
    --Hunter Pets
    HEALBOT_BARK_OF_THE_WILD                = 159988 --GetSpellInfo(159988) or "--Bark of the Wild"
    HEALBOT_BLESSING_OF_KONGS               = 160017 --GetSpellInfo(160017) or "--Blessing of Kongs"
    HEALBOT_BREATH_OF_THE_WINDS             = 24844 --GetSpellInfo(24844) or "--Breath of the Winds"
    HEALBOT_CACKLING_HOWL                   = 128432 --GetSpellInfo(128432) or "--Cackling Howl"
    HEALBOT_CHITINOUS_ARMOR                 = 50518 --GetSpellInfo(50518) or "--Chitinous Armor"
    HEALBOT_DEFENSIVE_QUILLS                = 160045 --GetSpellInfo(160045) or "--Defensive Quills"
    HEALBOT_DOUBLE_BITE                     = 58604 --GetSpellInfo(58604) or "--Double Bite"
    HEALBOT_EMBRACE_OF_THE_SHALE_SPIDER     = 90363 --GetSpellInfo(90363) or "--Embrace of the Shale Spider"
    HEALBOT_ENERGIZING_SPORES               = 135678 --GetSpellInfo(135678) or "--Energizing Spores"
    HEALBOT_FEARLESS_ROAR                   = 126373 --GetSpellInfo(126373) or "--Fearless Roar"
    HEALBOT_FURIOUS_HOWL                    = 24604 --GetSpellInfo(24604) or "--Furious Howl"
    HEALBOT_GRACE                           = 173035 --GetSpellInfo(173035) or "--Grace"
    HEALBOT_INVIGORATING_ROAR               = 50256 --GetSpellInfo(50256) or "--Invigorating Roar"
    HEALBOT_INDOMITABLE                     = 35290 --GetSpellInfo(35290) or "--Indomitable"
    HEALBOT_KEEN_SENSES                     = 160039 --GetSpellInfo(160039) or "--Keen Senses"
    HEALBOT_PLAINSWALKING                   = 160073 --GetSpellInfo(160073) or "--Plainswalking"
    HEALBOT_QIRAJI_FORTITUDE                = 90364 --GetSpellInfo(90364) or "--Qiraji Fortitude"
    HEALBOT_ROAR_OF_COURAGE                 = 93435 --GetSpellInfo(93435) or "--Roar of Courage"
    HEALBOT_SONIC_FOCUS                     = 50519 --GetSpellInfo(50519) or "--Sonic Focus"
    HEALBOT_SAVAGE_VIGOR                    = 160003 --GetSpellInfo(160003) or "--Savage Vigor"
    HEALBOT_SERPENTS_CUNNING                = 128433 --GetSpellInfo(128433) or "--Serpent's Cunning"
    HEALBOT_SPEED_OF_THE_SWARM              = 160074 --GetSpellInfo(160074) or "--Speed of the Swarm"
    HEALBOT_SPIRIT_BEAST_BLESSING           = 128997 --GetSpellInfo(128997) or "--Spirit Beast Blessing"
    HEALBOT_SPRY_ATTACKS                    = 34889 --GetSpellInfo(34889) or "--Spry Attacks"
    HEALBOT_STILL_WATER                     = 126309 --GetSpellInfo(126309) or "--Still Water"
    HEALBOT_STRENGTH_OF_THE_EARTH           = 160077 --GetSpellInfo(160077) or "--Strength of the Earth"
    HEALBOT_STRENGTH_OF_THE_PACK            = 160052 --GetSpellInfo(160052) or "--Strength of the Pack"
    HEALBOT_STURDINESS                      = 160014 --GetSpellInfo(160014) or "--Sturdiness"
    HEALBOT_TENACITY                        = 159735 --GetSpellInfo(159735) or "--Tenacity"
    HEALBOT_TERRIFYING_ROAR                 = 90309 --GetSpellInfo(90309) or "--Terrifying Roar"
    HEALBOT_WILD_STRENGTH                   = 57386 --GetSpellInfo(57386) or "--Wild Strength"
    
    --Mage
    HBC_AMPLIFY_MAGIC                       = 1008
    HEALBOT_ARCANE_BRILLIANCE               = 1459 --GetSpellInfo(1459) or "--Arcane Brilliance"; -- Arcane Intellect in Classic
    HBC_ARCANE_BRILLIANCE                   = 23028
    HEALBOT_ARCANE_POWER                    = 12042 --GetSpellInfo(12042) or "--Arcane Power"
    HEALBOT_BLAZING_BARRIER                 = 235313 --GetSpellInfo(235313) or "--Blazing Barrier"
    HEALBOT_DALARAN_BRILLIANCE              = 61316 --GetSpellInfo(61316) or "--Dalaran Brilliance";
    HBC_DAMPEN_MAGIC                        = 604
    HEALBOT_EVOCATION                       = 12051 --GetSpellInfo(12051) or "--Evocation";
    HEALBOT_FOCUS_MAGIC                     = 54646 --GetSpellInfo(54646) or "--Focus Magic";
    HBC_FROST_ARMOR                         = 168
    HBC_ICE_ARMOR                           = 7302
    HBC_MOLTEN_ARMOR                        = 30482
    HEALBOT_ICE_BARRIER                     = 11426 --GetSpellInfo(11426) or "--Ice Barrier"
    HEALBOT_ICE_BLOCK                       = 45438 --GetSpellInfo(45438) or "--Ice Block"
    HEALBOT_ICE_WARD                        = 111264 --GetSpellInfo(111264) or "--Ice Ward"
    HEALBOT_INCANTERS_WARD                  = 116267 --GetSpellInfo(1463) or "--Incanter's Ward"
    HBC_MAGE_ARMOR                          = 6117
    HEALBOT_MAGE_WARD                       = 543 --GetSpellInfo(543) or "--Mage Ward";
    HBC_MANA_SHIELD                         = 1463
    HEALBOT_PRISMATIC_BARRIER               = 235450 --GetSpellInfo(235450) or "--Prismatic Barrier"
    HEALBOT_SLOW_FALL                       = 130 --GetSpellInfo(130) or "--Slow Fall"

    --Paladin
    HEALBOT_ARDENT_DEFENDER                 = 31850 --GetSpellInfo(31850) or "--Ardent Defender";
    HEALBOT_BEACON_OF_FAITH                 = 156910 --GetSpellInfo(156910) or "--Beacon of Faith";
    HEALBOT_BEACON_OF_INSIGHT               = 157007 --GetSpellInfo(157007) or "--Beacon of Insight";
    HEALBOT_BEACON_OF_LIGHT                 = 53563 --GetSpellInfo(53563) or "--Beacon of Light";
    HEALBOT_BEACON_OF_VIRTUE                = 200025 --GetSpellInfo(200025) or "--Beacon of Virtue";
    HEALBOT_TYRS_DELIVERANCE                = 200654 --GetSpellInfo(200654) or "--Tyr's Deliverance";
    HEALBOT_BLESSING_OF_KINGS               = 203538 --GetSpellInfo(203538) or "--Greater Blessing of Kings";
    HBC_BLESSING_OF_KINGS                   = 20217
    HBC_BLESSING_OF_LIGHT                   = 19977
    HBC_BLESSING_OF_SALVATION               = 1038
    HEALBOT_BLESSING_OF_MIGHT               = 203528 --GetSpellInfo(203528) or "--Greater Blessing of Might";
    HBC_BLESSING_OF_MIGHT                   = 19740 --GetSpellInfo(19740) or "--Greater Blessing of Might";
    HBC_BLESSING_OF_SANCTUARY               = 20912
    HEALBOT_BLESSING_OF_WISDOM              = 203539 --GetSpellInfo(203539) or "--Greater Blessing of Wisdom";
    HBC_BLESSING_OF_WISDOM                  = 19742
    HEALBOT_DAY_BREAK                       = 88821 --GetSpellInfo(88821) or "--Daybreak";
    HEALBOT_DEVOTION_AURA                   = 465 --GetSpellInfo(465) or "--Devotion Aura";
    HBC_DIVINE_FAVOR                        = 20216
    HBC_DIVINE_INTERVENTION                 = 19752
    HEALBOT_DIVINE_PROTECTION               = 498 --GetSpellInfo(498) or "--Divine Protection";
    HEALBOT_DIVINE_PURPOSE                  = 223817 --GetSpellInfo(86172) or "--Divine Purpose";
    HEALBOT_DIVINE_SAVED_BY_THE_LIGHT       = 157047 --GetSpellInfo(157047) or "--Saved by the Light";
    HEALBOT_DIVINE_SHIELD                   = 642 --GetSpellInfo(642) or "--Divine Shield";
    --HEALBOT_ETERNAL_FLAME                   = 114163 --GetSpellInfo(114163) or "--Eternal Flame";
    HEALBOT_EXECUTION_SENTENCE              = 114157 --GetSpellInfo(114157) or "--Execution Sentence";
    HBC_GREATER_BLESSING_OF_KINGS           = 25898
    HBC_GREATER_BLESSING_OF_LIGHT           = 25890
    HBC_GREATER_BLESSING_OF_MIGHT           = 25782
    HBC_GREATER_BLESSING_OF_SALVATION       = 25895
    HBC_GREATER_BLESSING_OF_SANCTUARY       = 25899
    HBC_GREATER_BLESSING_OF_WISDOM          = 25894
    --HEALBOT_GUARDED_BY_THE_LIGHT            = 53592 --GetSpellInfo(53592) or "--Guarded by the Light";
    HEALBOT_GUARDIAN_ANCIENT_KINGS          = 86659 --GetSpellInfo(86659) or "--Guardian of Ancient Kings";
    HEALBOT_HAND_OF_FREEDOM                 = 1044 --GetSpellInfo(1044) or "--Hand of Freedom";
    HEALBOT_HAND_OF_PROTECTION              = 1022 --GetSpellInfo(1022) or "--Hand of Protection";
    HEALBOT_HAND_OF_PURITY                  = 114039 --GetSpellInfo(114039) or "--Hand of Purity";
   -- HEALBOT_HAND_OF_SACRIFICE               = 6940 --GetSpellInfo(6940) or "--Hand of Sacrifice";
    HEALBOT_HAND_OF_SALVATION               = 1038 --GetSpellInfo(1038) or "--Hand of Salvation";
    HEALBOT_HOLY_SHIELD                     = 20925 --GetSpellInfo(20925) or "--Holy Shield"
    HEALBOT_HOLY_SHOCK                      = 20473 --GetSpellInfo(20473) or "--Holy Shock";
    HEALBOT_ILLUMINATED_HEALING             = 86273 --GetSpellInfo(86273) or "--Illuminated Healing";
    HEALBOT_INFUSION_OF_LIGHT               = 54149 --GetSpellInfo(53576) or "--Infusion of Light";
    HEALBOT_LAY_ON_HANDS                    = 633 --GetSpellInfo(633) or "--Lay on Hands";
    HEALBOT_LIGHT_BEACON                    = 53651 --GetSpellInfo(53651) or "--Light's Beacon";
    HBC_RETRIBUTION_AURA                    = 7294
    HBC_FIRE_RESISTANCE_AURA                = 19891
    HBC_FROST_RESISTANCE_AURA               = 19888
    HBC_SHADOW_RESISTANCE_AURA              = 19876
    HEALBOT_RIGHTEOUS_FURY                  = 25780 --GetSpellInfo(25780) or "--Righteous Fury";
    HEALBOT_SACRED_SHIELD                   = 20925 --GetSpellInfo(20925) or "--Sacred Shield";
    HEALBOT_SANCTITY_AURA                   = 167187 --GetSpellInfo(167187) or "--Sanctity Aura";
    HEALBOT_SEAL_OF_COMMAND                 = 105361 --GetSpellInfo(105361) or "--Seal of Command";
    HEALBOT_SEAL_OF_JUSTICE                 = 20164 --GetSpellInfo(20164) or "--Seal of Justice";
    HEALBOT_SEAL_OF_INSIGHT                 = 20165 --GetSpellInfo(20165) or "--Seal of Insight";
    HEALBOT_SEAL_OF_RIGHTEOUSNESS           = 20154 --GetSpellInfo(20154) or "--Seal of Righteousness";
    HBC_SEAL_OF_THE_CRUSADER                = 21082
    HEALBOT_SEAL_OF_TRUTH                   = 31801 --GetSpellInfo(31801) or "--Seal of Truth";
    HEALBOT_SPEED_OF_LIGHT                  = 85499 --GetSpellInfo(85499) or "--Speed of Light";
    --Legion Added
    HEALBOT_BLESSING_OF_SACRIFICE           = 6940 --GetSpellInfo(199448) or "--Blessing of Sacrifice";
    HEALBOT_BESTOW_FAITH                    = 223306 --GetSpellInfo(223306) or "--Bestow Faith";
    HEALBOT_LIGHT_OF_THE_MARTYR             = 183998 --GetSpellInfo(183998) or "--Light of the Martyr";
    HEALBOT_HAND_OF_THE_PROTECTOR           = 213652 --GetSpellInfo(213652) or "--Hand of the Protector";
    HEALBOT_SACRED_DAWN                     = 243174 --GetSpellInfo(243174) or "--Sacred Dawn";
    HEALBOT_LIGHTS_GRACE                    = 216327 --GetSpellInfo(216327) or "--Light's Grace";
    HEALBOT_GLIMMER_OF_LIGHT                = 287280 --GetSpellInfo(287268) or "--Glimmer of Light";
    HEALBOT_BLESSING_OF_SANCTUARY           = 210256 --GetSpellInfo(210256) or "--Blessing of Sanctuary";
    HEALBOT_BLESSING_OF_SPELLWARDING        = 204018 --GetSpellInfo(204018) or "--Blessing of Spellwarding";
    
    --Priest
    HEALBOT_ALMAIESH_THE_CORD_OF_HOPE       = 211443 --GetSpellInfo(211443) or "--Al'maiesh, the Cord of Hope";
    HEALBOT_ANGELIC_BULWARK                 = 108945 --GetSpellInfo(108945) or "--Angelic Bulwark"
    HEALBOT_ANGELIC_FEATHER                 = 121557 --GetSpellInfo(121557) or "--Angelic Feather"
    HEALBOT_APOTHEOSIS                      = 200183 --GetSpellInfo(200183) or "--Apotheosis"; --Holy
    HEALBOT_ARCHANGEL                       = 81700 --GetSpellInfo(81700) or "--Archangel";
    HEALBOT_ASCENSION                       = 161862 --GetSpellInfo(161862) or "--Ascension"
    HEALBOT_ATONEMENT                       = 194384 --GetSpellInfo(81749) or "--Atonement";
    HEALBOT_AUSPICIOUS_SPIRITS              = 155271 --GetSpellInfo(155271) or "--Auspicious Spirits"
    HEALBOT_BLESSED_HEALING                 = 70772 --GetSpellInfo(70772) or "--Blessed Healing";
    HEALBOT_BLESSING_OF_TUURE               = 196644 --GetSpellInfo(196644) or "--Blessing of T'uure";
    HEALBOT_BODY_AND_MIND                   = 214121 --GetSpellInfo(214121) or "--Body and Mind";
    HEALBOT_CHAKRA                          = 14751 --GetSpellInfo(14751) or "--Chakra";
    HEALBOT_CHAKRA_CHASTISE                 = 81209 --GetSpellInfo(81209) or "--Chakra: Chastise";
    HEALBOT_CHAKRA_SANCTUARY                = 81206 --GetSpellInfo(81206) or "--Chakra: Sanctuary";
    HEALBOT_CHAKRA_SERENITY                 = 81208 --GetSpellInfo(81208) or "--Chakra: Serenity";
    HEALBOT_CLARITY_OF_POWER                = 155246 --GetSpellInfo(155246) or "--Clarity of Power"
    HEALBOT_CLARITY_OF_PURPOSE              = 155245 --GetSpellInfo(155245) or "--Clarity of Purpose"
    HEALBOT_CLARITY_OF_WILL                 = 152118 --GetSpellInfo(152118) or "--Clarity of Will"
    HEALBOT_DISPERSION                      = 47585 --GetSpellInfo(47585) or "--Dispersion"
    HEALBOT_DIVINE_AEGIS                    = 47515 --GetSpellInfo(47515) or "--Divine Aegis";
    HBC_DIVINE_SPIRIT                       = 14752
    HEALBOT_DIVINITY                        = 197031 --GetSpellInfo(197031) or "--Divinity";
    HEALBOT_ECHO_OF_LIGHT                   = 77489 --GetSpellInfo(77489) or "--Echo of Light";
    HEALBOT_EVANGELISM                      = 81661 --GetSpellInfo(81661) or "--Evangelism";
    HEALBOT_FEAR_WARD                       = 6346 --GetSpellInfo(6346) or "--Fear Ward";
    HEALBOT_FOCUSED_WILL                    = 45242 --GetSpellInfo(45243) or "--Focused Will";
    HEALBOT_GRACE                           = 47517 --GetSpellInfo(47517) or "--Grace";
    HEALBOT_GUARDIAN_SPIRIT                 = 47788 --GetSpellInfo(47788) or "--Guardian Spirit";
    HEALBOT_HOLY_NOVA                       = 132157 --GetSpellInfo(132157) or "--Holy Nova";
    HBC_INNER_FIRE                          = 588
    HEALBOT_INSPIRATION                     = 14893 --GetSpellInfo(14893) or "--Inspiration";
    HEALBOT_LEAP_OF_FAITH                   = 73325 --GetSpellInfo(73325) or "--Leap of Faith";
    HEALBOT_LEVITATE                        = 1706 --GetSpellInfo(1706) or "--Levitate";
    HEALBOT_LIGHTWELL_RENEW                 = 7001 --GetSpellInfo(7001) or "--Lightwell Renew";
    HEALBOT_LIGHT_OF_TUURE                  = 208065 --GetSpellInfo(208065) or "--Light of T'uure";
    HEALBOT_MIND_QUICKENING                 = 49868 --GetSpellInfo(49868) or "--Mind Quickening"
    HEALBOT_PAIN_SUPPRESSION                = 33206 --GetSpellInfo(33206) or "--Pain Suppression";
    HEALBOT_PERMEATING_GLOW                 = 272780 --GetSpellInfo(272780) or "--Permeating Glow";
    HEALBOT_POWER_INFUSION                  = 10060 --GetSpellInfo(10060) or "--Power Infusion";
    HEALBOT_POWER_OF_THE_DARK_SIDE          = 198069 --GetSpellInfo(198069) or "--Power of the Dark Side";
    HEALBOT_POWER_OF_THE_NAARU              = 196490 --GetSpellInfo(196490) or "--Power of the Naaru";
    HEALBOT_POWER_WORD_BARRIER              = 81782 --GetSpellInfo(62618) or "--Power Word:Barrier";
    HEALBOT_POWER_WORD_FORTITUDE            = 21562 --GetSpellInfo(21562) or "--Power Word:Fortitude";
    HBC_POWER_WORD_FORTITUDE                = 1243
    HEALBOT_POWER_WORD_SHIELD               = 17 --GetSpellInfo(17) or "--Power Word:Shield";
    HBC_PRAYER_OF_SHADOW_PROTECTION         = 27683
    HBC_PRAYER_OF_SPIRIT                    = 27681
    HEALBOT_RAMMALS_ULTERIOR_MOTIVE         = 234711 --GetSpellInfo(234711) or "--Rammal's Ulterior Motive";
    HEALBOT_RAPTURE                         = 47536 --GetSpellInfo(47536) or "--Rapture"; --Disc
    HEALBOT_RAY_OF_HOPE                     = 197268 --GetSpellInfo(197268) or "--Ray of Hope";
    HEALBOT_REVELATIONS                     = 88627 --GetSpellInfo(88627) or "--Revelations";
    --HEALBOT_SAVING_GRACE                    = 152116 --GetSpellInfo(152116) or "--Saving Grace"
    HEALBOT_SAVING_VOID_ENTROPY             = 155361 --GetSpellInfo(155361) or "--Void Entropy"
    HEALBOT_SERENDIPITY                     = 63733 --GetSpellInfo(63733) or "--Serendipity";
    HEALBOT_SHADOWFORM                      = 232698 --GetSpellInfo(232698) or "--Shadowform"
    HBC_SHADOWGUARD                         = 18137
    HEALBOT_SHADOW_COVENANT                 = 204065 --GetSpellInfo(204065) or "--Shadow Covenant";
    HBC_SHADOW_PROTECTION                   = 976
    HEALBOT_SHADOW_WORD_INSANITY            = 132573 --GetSpellInfo(132573) or "--Shadow Word: Insanity";
    HEALBOT_SHINING_FORCE                   = 204263 --GetSpellInfo(204263) or "--Shining Force";
    HEALBOT_SPIRIT_SHELL                    = 109964 --GetSpellInfo(109964) or "--Spirit Shell";
    HEALBOT_SUNDERING_SOUL                  = 212570 --GetSpellInfo(212570) or "--Sundering Soul";
    HEALBOT_SURGE_OF_DARKNESS               = 162448 --GetSpellInfo(162448) or "--Surge of Darkness";
    HEALBOT_SURGE_OF_LIGHT                  = 114255 --GetSpellInfo(114255) or "--Surge of Light";
    HEALBOT_SYMBOL_OF_HOPE                  = 64901 --GetSpellInfo(64901) or "--Symbol of Hope";    
    HBC_TOUCH_OF_WEAKNESS                   = 2652
    HEALBOT_TWIST_OF_FATE                   = 265258 --GetSpellInfo(109142) or "--Twist of Fate";
--    HEALBOT_TRIAL_OF_LIGHT                  = 200128 --GetSpellInfo(200128) or "--Trial of light";
    HEALBOT_VAMPIRIC_EMBRACE                = 15286 --GetSpellInfo(15286) or "--Vampiric Embrace";
    HEALBOT_VESTMANTS_OF_DISCIPLINE         = 197711 --GetSpellInfo(197711) or "--Vestments of Discipline";
    HEALBOT_WORD_OF_MENDING                 = 155362 --GetSpellInfo(155362) or "--Word of Mending";

    --Shaman
    HEALBOT_ANACESTRAL_GUIDANCE             = 108281 --GetSpellInfo(108281) or "--Ancestral Guidance";
    HEALBOT_ANACESTRAL_SWIFTNESS            = 16188 --GetSpellInfo(16188) or "--Ancestral Swiftness";
    HEALBOT_ASCENDANCE                      = 114049 --GetSpellInfo(114049) or "--Ascendance";
    HEALBOT_ASTRAL_SHIFT                    = 108271 --GetSpellInfo(108271) or "--Astral Shift";
    HEALBOT_CLOUDBURST_TOTEM                = 157153 --GetSpellInfo(157153) or "--Cloudburst Totem";
    HEALBOT_EARTH_SHIELD                    = 204288 --GetSpellInfo(204288) or "--Earth Shield";
    HEALBOT_ELEMENTAL_FUSION                = 152257 --GetSpellInfo(152257) or "--Elemental Fusion";
    HEALBOT_ELEMENTAL_MASTERY               = 260734 --GetSpellInfo(16166) or "--Elemental Mastery";
    HEALBOT_EMPOWER                         = 118350 --GetSpellInfo(118350) or "--Empower";
    HEALBOT_FLAMETONGUE                     = 193796 --GetSpellInfo(193796) or "--Flametongue";
    HEALBOT_FROSTBRAND                      = 196834 --GetSpellInfo(196834) or "--Frostbrand";
    HEALBOT_GENESIS                         = 145518 --GetSpellInfo(145518) or "--Genesis";
    HEALBOT_GRACE_OF_AIR                    = 116956 --GetSpellInfo(116956) or "--Grace of Air";
    HEALBOT_HIGH_TIDE                       = 157154 --GetSpellInfo(157154) or "--High Tide";
    HEALBOT_LIGHTNING_SHIELD                = 192106 --GetSpellInfo(192106) or "--Lightning Shield";
    HBC_LIGHTNING_SHIELD                    = 324
    HBC_EARTH_SHIELD                        = 974
    HBC_ROCKBITER_WEAPON                    = 8017
    HBC_FLAMETONGUE_WEAPON                  = 8024
    HBC_WINDFURY_WEAPON                     = 8232
    HBC_WATER_SHIELD                        = 24398
    HEALBOT_SHAMANISTIC_RAGE                = 30823 --GetSpellInfo(30823) or "--Shamanistic Rage";
    HEALBOT_SPIRITWALKERS_GRACE             = 79206 --GetSpellInfo(79206) or "--Spiritwalker's Grace";
    HEALBOT_SPIRIT_LINK_TOTEM               = 98008 --GetSpellInfo(98008) or "--Spirit Link Totem";
    HEALBOT_STORM_ELEMENTAL_TOTEM           = 152256 --GetSpellInfo(152256) or "--Storm Elemenal Totem";
    HEALBOT_TIDAL_WAVES                     = 51564 --GetSpellInfo(51564) or "--Tidal Waves";
    HEALBOT_UNLEASH_ELEMENTS                = 73680 --GetSpellInfo(73680) or "--Unleash Elements";
    HEALBOT_UNLEASH_FLAME                   = 165462 --GetSpellInfo(165462) or "--Unleash Flame";
    HEALBOT_UNLEASH_LIFE                    = 73685 --GetSpellInfo(73685) or "--Unleash Life";
    HEALBOT_UNLEASHED_FURY                  = 117012 --GetSpellInfo(117012) or "--Unleashed Fury";
    HEALBOT_WATER_SHIELD                    = 52127 --GetSpellInfo(52127) or "--Water Shield";
    HEALBOT_WATER_WALKING                   = 546 --GetSpellInfo(546) or "--Water Walking";
    HEALBOT_WATER_BREATHING                 = 131 --GetSpellInfo(131) or "--Water Breathing";
    
    --Monk
    HEALBOT_BREATH_OF_THE_SERPENT           = 157535 --GetSpellInfo(157535) or "--Breath of the Serpent"
    HEALBOT_CHI_EXPLOSION                   = 157676 --GetSpellInfo(157676) or "--Chi Explosion"
    HEALBOT_CHI_TOROEDO                     = 115008 --GetSpellInfo(115008) or "--Chi Torpedo"
    HEALBOT_DAMPEN_HARM                     = 122278 --GetSpellInfo(122278) or "--Dampen Harm"
    HEALBOT_DETONATE_CHI                    = 115460 --GetSpellInfo(115460) or "--Detonate Chi"
    HEALBOT_DIFFUSE_MAGIC                   = 122783 --GetSpellInfo(122783) or "--Diffuse Magic"
    HEALBOT_ELUSIVE_BREW                    = 115308 --GetSpellInfo(115308) or "--Elusive Brew"
    HEALBOT_FORTIFYING_BREW                 = 115203 --GetSpellInfo(115203) or "--Fortifying Brew"
    HEALBOT_GUARD                           = 115295 --GetSpellInfo(115295) or "--Guard"
    HEALBOT_LEGACY_EMPEROR                  = 115921 --GetSpellInfo(115921) or "--Legacy of the Emperor"
    HEALBOT_LEGACY_WHITETIGER               = 116781 --GetSpellInfo(116781) or "--Legacy of the White Tiger"
    HEALBOT_LIFE_COCOON                     = 116849 --GetSpellInfo(116849) or "--Life Cocoon"
    HEALBOT_MANA_TEA                        = 115867 --GetSpellInfo(115867) or "--Mana Tea"
    HEALBOT_RUSHING_JADE_WIND               = 116847 --GetSpellInfo(116847) or "--Rushing Jade Wind"
    HEALBOT_SERENITY                        = 152173 --GetSpellInfo(152173) or "--Serenity"
    HEALBOT_SERPENT_ZEAL                    = 127722 --GetSpellInfo(127722) or "--Serpent's Zeal"
    HEALBOT_STANCE_MONK_TIGER               = 103985 --GetSpellInfo(103985) or "--Stance of the Fierce Tiger"
    HEALBOT_STANCE_MONK_CRANE               = 154436 --GetSpellInfo(154436) or "--Stance of the Spirited Crane"
    HEALBOT_STANCE_MONK_OX                  = 115069 --GetSpellInfo(115069) or "--Stance of the Sturdy Ox"
    HEALBOT_STANCE_MONK_SERPENT             = 115070 --GetSpellInfo(115070) or "--Stance of the Wise Serpent"
    HEALBOT_THUNDER_FOCUS_TEA               = 116680 --GetSpellInfo(116680) or "--Thunder Focus Tea"
    HEALBOT_WINDFLURRY                      = 166916 --GetSpellInfo(166916) or "--Windflurry"
    HEALBOT_EXTEND_LIFE                     = 185158 --GetSpellInfo(185158) or "--Extend Life"
    HEALBOT_ESSENCE_FONT                    = 191840 --GetSpellInfo(191837) or "--Essence Font"
    HEALBOT_TOUCH_OF_KARMA                  = 125174 --GetSpellInfo(122470) or "--Touch of Karma"
    
    --Warlock
    HEALBOT_BLOOD_PACT                      = 166928 --GetSpellInfo(166928) or "--Blood Pact";
    --HEALBOT_DARK_BARGAIN                    = 110913 --GetSpellInfo(110913) or "--Dark Bargain"
    HEALBOT_DARK_INTENT                     = 109773 --GetSpellInfo(109773) or "--Dark Intent";
    HEALBOT_DEMON_ARMOR                     = 687 --GetSpellInfo(687) or "--Demon Armor";
    HBC_DEMON_ARMOR                         = 706
    HEALBOT_FEL_ARMOR                       = 28176 --GetSpellInfo(28176) or "--Fel Armor";
    HEALBOT_LIFE_TAP                        = 1454 --GetSpellInfo(1454) or "--Life Tap";
    HEALBOT_SOUL_LINK                       = 19028 --GetSpellInfo(19028) or "--Soul Link";
    HEALBOT_UNENDING_BREATH                 = 5697 --GetSpellInfo(5697) or "--Unending Breath"
    HEALBOT_UNENDING_RESOLVE                = 104773 --GetSpellInfo(104773) or "--Unending Resolve"
    HEALBOT_SOUL_LEECH                      = 108366 --GetSpellInfo(108370) or "--Soul Leech"
    HBC_PHASE_SHIFT                         = 4511 --GetSpellInfo(4511) or "Phase Shift"
    HBC_DETECT_LESSER_INVISIBILITY          = 132
    HBC_DETECT_INVISIBILITY                 = 2970
    HBC_DETECT_GREATER_INVISIBILITY         = 11743
    
    --Warrior
    HEALBOT_BATTLE_SHOUT                    = 6673 --GetSpellInfo(6673) or "--Battle Shout";
    HEALBOT_COMMANDING_SHOUT                = 469 --GetSpellInfo(469) or "--Commanding Shout";
    HEALBOT_ENRAGED_REGEN                   = 55694 --GetSpellInfo(55694) or "--Enraged Regeneration";
    HEALBOT_INSPIRING_PRESENCE              = 167188 --GetSpellInfo(167188) or "--Inspiring Presence"
    HEALBOT_INTERVENE                       = 3411 --GetSpellInfo(3411) or "--Intervene";
    HEALBOT_LAST_STAND                      = 12975 --GetSpellInfo(12975) or "--Last Stand";
    HEALBOT_SAFEGUARD                       = 114029 --GetSpellInfo(114029) or "--Safeguard"
    --HEALBOT_SHIELD_BARRIER                  = 112048 --GetSpellInfo(112048) or "--Shield Barrier"
    HEALBOT_SHIELD_BLOCK                    = 132404 --GetSpellInfo(2565) or "--Shield Block";
    HEALBOT_SHIELD_WALL                     = 871 --GetSpellInfo(871) or "--Shield Wall";
    HEALBOT_VIGILANCE                       = 114030 --GetSpellInfo(114030) or "--Vigilance";
    
    --Rogue
    HEALBOT_CLOAK_OF_SHADOWS                = 31224 --GetSpellInfo(31224) or "--Cloak of Shadows"
    HEALBOT_EVASION                         = 5277 --GetSpellInfo(5277) or "--Evasion";
    HEALBOT_FEINT                           = 1966 --GetSpellInfo(1966) or "--Feint"
    HEALBOT_SWIFTBLADES_CUNNING             = 113742 --GetSpellInfo(113742) or "--Swiftblade's Cunning";
    HEALBOT_VANISH                          = 11327 --GetSpellInfo(1856) or "--Vanish";
    HEALBOT_DEADLY_POISON                   = 2823
    HEALBOT_CRIPPLING_POISON                = 3408
    HEALBOT_WOUND_POISON                    = 8679
    HEALBOT_INSTANT_POISON                  = 315584
    
    
    --Resurrection Spells
    HEALBOT_ANCESTRALSPIRIT                 = 2008 --GetSpellInfo(2008) or "--Ancestral Spirit";
    HEALBOT_DEBUFF_MASS_RESURRECTED         = 95223 --GetSpellInfo(95223) or "--Recently Mass Resurrected";
    --HEALBOT_MASS_RESURRECTION               = GetSpellInfo(83968) or "--Mass Resurrection";
    
    HEALBOT_ABSOLUTION                      = 212056 --GetSpellInfo(212056) or "--Absolution";
    HEALBOT_ANCESTRAL_VISION                = 212048 --GetSpellInfo(212048) or "--Ancestral Vision";
    HEALBOT_MASS_RESURRECTION               = 212036 --GetSpellInfo(212036) or "--Mass Resurrection";
    HEALBOT_REAWAKEN                        = 212051 --GetSpellInfo(212051) or "--Reawaken";
    HEALBOT_REVITALIZE                      = 212040 --GetSpellInfo(212040) or "--Revitalize";
    
    HEALBOT_REDEMPTION                      = 7328 --GetSpellInfo(7328) or "--Redemption";
    HEALBOT_REBIRTH                         = 20484 --GetSpellInfo(20484) or "--Rebirth";
    HEALBOT_RESURRECTION                    = 2006 --GetSpellInfo(2006) or "--Resurrection";
    HEALBOT_RESUSCITATE                     = 115178 --GetSpellInfo(115178) or "--Resuscitate"
    HEALBOT_REVIVE                          = 50769 --GetSpellInfo(50769) or "--Revive";
    
    --Cure Spells
    HEALBOT_BODY_AND_SOUL                   = GetSpellInfo(64127) or 64127
    HEALBOT_CLEANSE                         = GetSpellInfo(4987) or 4987
    HEALBOT_CLEANSE_SPIRIT                  = GetSpellInfo(51886) or 51886
    HEALBOT_CLEANSE_TOXIN                   = GetSpellInfo(213644) or 213644
    HBC_SHAMAN_CURE_DISEASE                 = GetSpellInfo(2870) or 2870
    HBC_PRIEST_CURE_DISEASE                 = GetSpellInfo(528) or 528
    HEALBOT_DISPELL_MAGIC                   = GetSpellInfo(528) or 528
    HBC_PRIEST_ABOLISH_DISEASE              = GetSpellInfo(552) or 552
    HBC_DISPELL_MAGIC                       = GetSpellInfo(527) or 527
    HBC_SHAMAN_CURE_POISON                  = GetSpellInfo(526) or 526
    HBC_DRUID_REMOVE_CURSE                  = GetSpellInfo(2782) or 2782
    HBC_DRUID_CURE_POISON                   = GetSpellInfo(8946) or 8946
    HBC_DRUID_ABOLISH_POISON                = GetSpellInfo(2893) or 2893
    HEALBOT_DETOX                           = GetSpellInfo(115450) or 115450
    HEALBOT_NATURES_CURE                    = GetSpellInfo(88423) or 88423
    HEALBOT_PURIFY                          = GetSpellInfo(527) or 527
    HBC_PURIFY                              = GetSpellInfo(1152) or 1152
    HEALBOT_PURIFY_SPIRIT                   = GetSpellInfo(77130) or 77130
    HEALBOT_PURIFY_DISEASE                  = GetSpellInfo(213634) or 213634
    HEALBOT_MASS_DISPEL                     = GetSpellInfo(32375) or 32375
    HEALBOT_REMOVE_CURSE                    = GetSpellInfo(475) or 475
    HEALBOT_REMOVE_CORRUPTION               = GetSpellInfo(2782) or 2782
    HEALBOT_SACRED_CLEANSING                = GetSpellInfo(53551) or 53551
    
    --[[END OF SPELL LIST]]--

    --Ignore Class Debuffs (ONLY DISPELLABLE DEBUFFS)
    HEALBOT_DEBUFF_CURSE_OF_IMPOTENCE       = 34925 --GetSpellInfo(34925) or "--Curse of Impotence";
    HEALBOT_DEBUFF_DECAYED_INTELLECT        = 31555 --GetSpellInfo(31555) or "--Decayed Intellect";
    HEALBOT_DEBUFF_DECAYED_STRENGHT         = 6951 --GetSpellInfo(6951) or "--Decayed Strength";
    HEALBOT_DEBUFF_IGNITE_MANA              = 19659 --GetSpellInfo(19659) or "--Ignite Mana";
    HEALBOT_DEBUFF_SILENCE                  = 38913 --GetSpellInfo(38913) or "--Silence";
    HEALBOT_DEBUFF_TAINTED_MIND             = 16567 --GetSpellInfo(16567) or "--Tainted Mind";
    HEALBOT_DEBUFF_TRAMPLE                  = 126406 --GetSpellInfo(126406) or "--Trample";
    --HEALBOT_DEBUFF_UNSTABLE_AFFLICTION      = 35183 --GetSpellInfo(35183) or "--Unstable Affliction";
    --HEALBOT_DEBUFF_UNSTABLE_AFFLICTION      = 156954 --GetSpellInfo(156954) or "--Unstable Affliction";
    HEALBOT_DEBUFF_UNSTABLE_AFFLICTION      = 30108 --GetSpellInfo(30108) or "--Unstable Affliction";
    HEALBOT_DEBUFF_VIPER_STING              = 39413 --GetSpellInfo(39413) or "--Viper Sting";   
    HEALBOT_DEBUFF_VAMPIRIC_TOUCH           = 34914 --GetSpellInfo(34914) or "--Vampiric Touch";    
    --Ignore Movement Debuffs (ONLY DISPELLABLE DEBUFFS)
    HEALBOT_DEBUFF_CHILLED                  = 6136 --GetSpellInfo(6136) or "--Chilled";
    HEALBOT_DEBUFF_CONEOFCOLD               = 64645 --GetSpellInfo(64645) or "--Cone of Cold";
    HEALBOT_DEBUFF_EARTHBIND                = 3600 --GetSpellInfo(3600) or "--Earthbind";
    HEALBOT_DEBUFF_FROST_SHOCK              = 41116 --GetSpellInfo(41116) or "--Frost Shock";
    HEALBOT_DEBUFF_FROSTBOLT                = 69573 --GetSpellInfo(69573) or "--Frostbolt";
    HEALBOT_DEBUFF_MAGMA_SHACKLES           = 19496 --GetSpellInfo(19496) or "--Magma Shackles";
    HEALBOT_DEBUFF_SEAL_OF_JUSTICE          = 20170 --GetSpellInfo(20170) or "--Seal of Justice";
    HEALBOT_DEBUFF_SLOW                     = 32922 --GetSpellInfo(32922) or "--Slow";  
    --Ignore Non-Harmful Debuffs (ONLY DISPELLABLE DEBUFFS)
    HEALBOT_DEBUFF_DREAMLESS_SLEEP          = 15822 --GetSpellInfo(15822) or "--Dreamless Sleep";
    HEALBOT_DEBUFF_GREATER_DREAMLESS        = 24360 --GetSpellInfo(24360) or "--Greater Dreamless Sleep";
    HEALBOT_DEBUFF_MAJOR_DREAMLESS          = 28504 --GetSpellInfo(28504) or "--Major Dreamless Sleep";
    HEALBOT_DEBUFF_SHATTERED_DEFENSES       = 209574 --GetSpellInfo(209574) or "--Shattered Defenses";
    HEALBOT_DEBUFF_OVERWHELMING_POWER       = 266180 --GetSpellInfo(266180) or "--Overwhelming Power";
    
    --Common Buffs
   -- HEALBOT_ZAMAELS_PRAYER                  = 88663 --GetSpellInfo(88663) or "--Zamael's Prayer";
    HEALBOT_FLESHCRAFT                      = 324631
    
    --Harmful Debuffs
    --Debuffs
    HEALBOT_DEBUFF_ROCKET_FUEL_LEAK         = 94794 --GetSpellInfo(94794) or "--Rocket Fuel Leak"; --Engineering 
    --HEALBOT_DEBUFF_SAVING_GRACE             = GetSpellInfo(155274) or "--Saving Grace"; --DO NOT REMOVE

    
    --Unit Max Health Modifier Debuffs
    HEALBOT_DEBUFF_AURA_OF_CONTEMPT         = 179986 --GetSpellInfo(179986) or "--Aura of Contempt";

    -- Debuffs restricting spell casts
    HEALBOT_DEBUFF_FORBEARANCE              = 25771 --GetSpellInfo(25771) or "--Forbearance";
    HEALBOT_DEBUFF_WEAKENED_SOUL            = 6788 --GetSpellInfo(6788) or "--Weakened Soul";
end
HealBot_globalVars()

HEALBOT_DISEASE_en                      = "Disease";  -- Do NOT localize this value.
HEALBOT_MAGIC_en                        = "Magic";  -- Do NOT localize this value.
HEALBOT_CURSE_en                        = "Curse";  -- Do NOT localize this value.
HEALBOT_POISON_en                       = "Poison";  -- Do NOT localize this value.
HEALBOT_CUSTOM_en                       = "Custom";  -- Do NOT localize this value. 
