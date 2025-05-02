local GetAddOnMetadata=GetAddOnMetadata
HEALBOT_VERSION="11.x"

function HealBot_Global_MetaVersion()
    GetAddOnMetadata=GetAddOnMetadata or (C_AddOns and C_AddOns.GetAddOnMetadata)
    if GetAddOnMetadata then
        HEALBOT_VERSION=GetAddOnMetadata("HealBot", "Version")
    else
        HEALBOT_VERSION="11.x"
    end
    HealBot_Comms_SetVersion()
end

HEALBOT_ABOUT_URL="healbot.dpm15.net"

local vMajor        =string.split(".", select(1, GetBuildInfo()))
HEALBOT_GAME_VERSION=tonumber(vMajor)

function HealBot_Global_Version()
    return "11.1.5.1"
end
function HealBot_Global_InitVersion()
    return "11.1.5.0"  -- Keep just behind the global version
end

function HealBot_globalVars()
    --Consumables
    --Bandages
    HEALBOT_LINEN_BANDAGE                  =1251 --HealBot_WoWAPI_ItemInfo(1251) or "--Linen Bandage";
    HEALBOT_HEAVY_LINEN_BANDAGE            =2581 --HealBot_WoWAPI_ItemInfo(2581) or "--Heavy Linen Bandage";
    HEALBOT_WOOL_BANDAGE                   =3530 --HealBot_WoWAPI_ItemInfo(3530) or "--Wool Bandage";
    HEALBOT_HEAVY_WOOL_BANDAGE             =3531 --HealBot_WoWAPI_ItemInfo(3531) or "--Heavy Wool Bandage";
    HEALBOT_SILK_BANDAGE                   =6450 --HealBot_WoWAPI_ItemInfo(6450) or "--Silk Bandage";
    HEALBOT_HEAVY_SILK_BANDAGE             =6451 --HealBot_WoWAPI_ItemInfo(6451) or "--Heavy Silk Bandage";
    HEALBOT_MAGEWEAVE_BANDAGE              =8544 --HealBot_WoWAPI_ItemInfo(8544) or "--Mageweave Bandage";
    HEALBOT_HEAVY_MAGEWEAVE_BANDAGE        =8545 --HealBot_WoWAPI_ItemInfo(8545) or "--Heavy Mageweave Bandage";
    HEALBOT_RUNECLOTH_BANDAGE              =14529 --HealBot_WoWAPI_ItemInfo(14529) or "--Runecloth Bandage";
    HEALBOT_HEAVY_RUNECLOTH_BANDAGE        =14530 --HealBot_WoWAPI_ItemInfo(14530) or "--Heavy Runecloth Bandage";
    HEALBOT_NETHERWEAVE_BANDAGE            =21990 --HealBot_WoWAPI_ItemInfo(21990) or "--Netherweave Bandage";
    HEALBOT_HEAVY_NETHERWEAVE_BANDAGE      =21991 --HealBot_WoWAPI_ItemInfo(21991) or "--Heavy Netherweave Bandage";
    HEALBOT_FROSTWEAVE_BANDAGE             =34721 --HealBot_WoWAPI_ItemInfo(34721) or "--Frostweave Bandage";
    HEALBOT_HEAVY_FROSTWEAVE_BANDAGE       =34722 --HealBot_WoWAPI_ItemInfo(34722) or "--Heavy Frostweave Bandage";
    HEALBOT_EMBERSILK_BANDAGE              =53049 --HealBot_WoWAPI_ItemInfo(53049) or "--Embersilk Bandage";
    HEALBOT_HEAVY_EMBERSILK_BANDAGE        =53050 --HealBot_WoWAPI_ItemInfo(53050) or "--Heavy Embersilk Bandage";
    HEALBOT_DENSE_EMBERSILK_BANDAGE        =53051 --HealBot_WoWAPI_ItemInfo(53051) or "--Dense Embersilk Bandage";
    HEALBOT_WINDWOOL_BANDAGE               =72985 --HealBot_WoWAPI_ItemInfo(72985) or "--Windwool Bandage";
    HEALBOT_HEAVY_WINDWOOL_BANDAGE         =72986 --HealBot_WoWAPI_ItemInfo(72986) or "--Heavy Windwool Bandage";
    HEALBOT_ASHRAN_BANDAGE                 =115497 --HealBot_WoWAPI_ItemInfo(115497) or "--Ashran Bandage";
    HEALBOT_SILKWEAVE_BANDAGE              =133940 --HealBot_WoWAPI_ItemInfo(133940) or "--Silkweave Bandage";
    HEALBOT_DEEP_SEA_BANDAGE               =158382 --HealBot_WoWAPI_ItemInfo(158382) or "--Deep Sea Bandage";
    HEALBOT_TIDESPRAY_LINEN_BANDAGE        =158381 --HealBot_WoWAPI_ItemInfo(158381) or "--Tidespray Linen Bandage";
    HEALBOT_SHROUDED_CLOTH_BANDAGE         =173192 --HealBot_WoWAPI_ItemInfo(173192) or "--Shrouded Cloth Bandage";
    HEALBOT_HEAVY_SHROUDED_CLOTH_BANDAGE   =173191 --HealBot_WoWAPI_ItemInfo(173191) or "--Heavy Shrouded Cloth Bandage";
    --Potions
    HEALBOT_MAJOR_HEALING_POTION           =13446 --HealBot_WoWAPI_ItemInfo(13446) or "--Major Healing Potion";
    HEALBOT_SUPER_HEALING_POTION           =22829 --HealBot_WoWAPI_ItemInfo(22829) or "--Super Healing Potion";
    HEALBOT_MAJOR_COMBAT_HEALING_POTION    =31838 --HealBot_WoWAPI_ItemInfo(31838) or "--Major Combat Healing Potion";
    HEALBOT_RUNIC_HEALING_POTION           =33447 --HealBot_WoWAPI_ItemInfo(33447) or "--Runic Healing Potion";
    HEALBOT_ENDLESS_HEALING_POTION         =43569 --HealBot_WoWAPI_ItemInfo(43569) or "--Endless Healing Potion";
    HEALBOT_MAJOR_MANA_POTION              =13444 --HealBot_WoWAPI_ItemInfo(13444) or "--Major Mana Potion";
    HEALBOT_SUPER_MANA_POTION              =22832 --HealBot_WoWAPI_ItemInfo(22832) or "--Super Mana Potion";
    HEALBOT_MAJOR_COMBAT_MANA_POTION       =31840 --HealBot_WoWAPI_ItemInfo(31840) or "--Major Combat Mana Potion";
    HEALBOT_RUNIC_MANA_POTION              =33448 --HealBot_WoWAPI_ItemInfo(33448) or "--Runic Mana Potion";
    HEALBOT_ENDLESS_MANA_POTION            =43570 --HealBot_WoWAPI_ItemInfo(43570) or "--Endless Mana Potion";
    HEALBOT_PURIFICATION_POTION            =13462 --HealBot_WoWAPI_ItemInfo(13462) or "--Purification Potion";
    HEALBOT_ANTI_VENOM                     =6452 --HealBot_WoWAPI_ItemInfo(6452) or "--Anti-Venom";
    HEALBOT_POWERFUL_ANTI_VENOM            =19440 --HealBot_WoWAPI_ItemInfo(19440) or "--Powerful Anti-Venom";
    HEALBOT_ELIXIR_OF_POISON_RES           =3386 --HealBot_WoWAPI_ItemInfo(3386) or "--Potion of Curing";
    HEALBOT_SOULFUL_HEALING_POTION         =180317 --HealBot_WoWAPI_ItemInfo(180317) or "--Soulful Healing Potion";
    HEALBOT_SPIRITUAL_HEALING_POTION       =171267 --HealBot_WoWAPI_ItemInfo(171267) or "--Spiritual Healing Potion";
    HEALBOT_SOULFUL_MANA_POTION            =180318 --HealBot_WoWAPI_ItemInfo(180318) or "--Soulful Mana Potion";
    HEALBOT_SPIRITUAL_MANA_POTION          =171268 --HealBot_WoWAPI_ItemInfo(171268) or "--Spiritual Mana Potion";
    HEALBOT_POTION_OF_SOUL_PURITY          =171263 --HealBot_WoWAPI_ItemInfo(171263) or "--Potion of Soul Purity";
    HEALBOT_PHIAL_OF_SERENITY              =177278 --HealBot_WoWAPI_ItemInfo(177278) or "--Phial of Serenity";

    --Items
    HEALBOT_BLOOM                          =176160 --HealBot_WoWAPI_SpellName(176160) or "--Bloom";
    HEALBOT_EVER_BLOOMING_FROND            =118935 --HealBot_WoWAPI_ItemInfo(118935) or "--Ever-Blooming Frond";
    HEALBOT_ORALIUS_WHISPERING_CRYSTAL     =118922 --HealBot_WoWAPI_ItemInfo(118922) or "--Oralius' Whispering Crystal";
    HEALBOT_WHISPERS_OF_INSANITY           =176151 --HealBot_WoWAPI_SpellName(176151) or "--Whispers of Insanity";
    HEALBOT_REPURPOSED_FEL_FOCUSER         =147707 --HealBot_WoWAPI_ItemInfo(147707) or "--Repurposed Fel Focuser";
    HEALBOT_FEL_FOCUS                      =242551 --HealBot_WoWAPI_SpellName(242551) or "--Fel Focus";    
    HEALBOT_SHROUD_OF_THE_NAGLFAR          =215247 --HealBot_WoWAPI_SpellName(215247) or "--Shroud of the Naglfar";
    HEALBOT_SPIRIT_FRAGMENT                =221878 --HealBot_WoWAPI_SpellName(221878) or "--Spirit Fragment";
    HEALBOT_NORGANNONS_FORESIGHT           =208215 --HealBot_WoWAPI_SpellName(208215) or "--Norgannon's Foresight";
    HEALBOT_DELICIOUS_CAKE                 =225126 --HealBot_WoWAPI_SpellName(225126) or "--Delicious Cake!";
    HEALBOT_GUIDING_HAND                   =242622 --HealBot_WoWAPI_SpellName(242622) or "--Guiding Hand";
    HEALBOT_FRUITFUL_MACHINATIONS          =242623 --HealBot_WoWAPI_SpellName(242623) or "--Fruitful Machinations";
    HEALBOT_HIGHFATHERS_TIMEKEEPING        =253287 --HealBot_WoWAPI_SpellName(253287) or "--Highfather's Timekeeping";
    --HEALBOT_AOF_INFUSION_OF_LIGHT          =242621 --HealBot_WoWAPI_SpellName(242621) or "--Infusion of Light";
    HEALBOT_OCEANS_EMBRACE                 =242467 --HealBot_WoWAPI_SpellName(242467) or "--Ocean's Embrace";
    HEALBOT_VELENS_FUTURE_SIGHT            =235966 --HealBot_WoWAPI_SpellName(235966) or "--Velen's Future Sight"
    HEALBOT_SEPHUZS_SECRET                 =208052 --HealBot_WoWAPI_SpellName(208052) or "--Sephuz's Secret"
    HEALBOT_BATTLE_SCARRED_AUGMENT_RUNE    =160053 --HealBot_WoWAPI_ItemInfo(160053) or "--Battle-Scarred Augment Rune"
    HEALBOT_BATTLE_SCARRED_AUGMENT         =270058 --HealBot_WoWAPI_SpellName(270058) or "--Battle-Scarred Augment"
    HEALBOT_LIGHTNING_FORGED_AUGMENT_RUNE  =174906 --HealBot_WoWAPI_ItemInfo(174906) or "--Lightning-Forged Augment Rune"
    HEALBOT_LIGHTNING_FORGED_AUGMENT       =317065 --HealBot_WoWAPI_SpellName(317065) or "--Battle-Scarred Augment"
    HEALBOT_VEILED_AUGMENT_RUNE            =181468 --HealBot_WoWAPI_ItemInfo(181468) or "--Veiled Augment Rune"
    HEALBOT_VEILED_AUGMENTATION            =347901 --HealBot_WoWAPI_SpellName(347901) or "--Veiled Augmentation"
    HEALBOT_TAILWIND_SAPPHIRE              =284567 --HealBot_WoWAPI_ItemInfo(284567) or "--Tailwind Sapphire"
    HEALBOT_TAILWIND                       =284573 --HealBot_WoWAPI_SpellName(284573) or "--Tailwind"
    HEALBOT_AMETHYST_OF_THE_SHADOW_KING    =284558 --HealBot_WoWAPI_ItemInfo(284558) or "--Amethyst of the Shadow King"
    HEALBOT_SHADOW_TOUCHED                 =284556 --HealBot_WoWAPI_SpellName(284556) or "--Shadow-Touched"
    HEALBOT_INGENIOUS_MANA_BATTERY         =169344 
    
    --Procs
    HEALBOT_CONCORDANCE_OF_THE_LEGIONFALL  =242586 --HealBot_WoWAPI_SpellName(242586) or "--Concordance of the Legionfall";
    HEALBOT_BRACING_CHILL                  =272276 --HealBot_WoWAPI_SpellName(267884) or "--Bracing Chill";
    HEALBOT_BLESSED_PORTENTS               =271843 --HealBot_WoWAPI_SpellName(267889) or "--Blessed Portents";
    
    --Racial Abilities
    HEALBOT_DARKFLIGHT                     =68992 --HealBot_WoWAPI_SpellName(68992) or "--Darkflight";
    HEALBOT_GIFT_OF_THE_NAARU              =28880 --HealBot_WoWAPI_SpellName(59547) or "--Gift of the Naaru";
    HEALBOT_STONEFORM                      =20594 --HealBot_WoWAPI_SpellName(20594) or "--Stoneform";

    --Weapon Enchants
    HEALBOT_FLAMETONGUE_SPELL              =318038
    HEALBOT_FLAMETONGUE_ENCHANT            =5400
    HEALBOT_WINDFURY_SPELL                 =33757
    HEALBOT_WINDFURY_ENCHANT               =5401
    HEALBOT_BRILLIANT_MANA_OIL_SPELL       =20748
    HEALBOT_BRILLIANT_MANA_OIL_ENCHANT     =2629
    HEALBOT_SUPERIOR_MANA_OIL_SPELL        =22521
    HEALBOT_SUPERIOR_MANA_OIL_ENCHANT      =28016
    HEALBOT_BRILLIANT_WIZARD_OIL_SPELL     =20749
    HEALBOT_BRILLIANT_WIZARD_OIL_ENCHANT   =2628
    HEALBOT_SUPERIOR_WIZARD_OIL_SPELL      =22522
    HEALBOT_SUPERIOR_WIZARD_OIL_ENCHANT    =28019
    HEALBOT_BLESSED_WIZARD_OIL_SPELL       =23123
    HEALBOT_BLESSED_WIZARD_OIL_ENCHANT     =2685
    HEALBOT_WIZARD_OIL_SPELL               =20750
    --Harmful Spells
    --Death Knight
    HEALBOT_DEATH_COIL                     =47541 --HealBot_WoWAPI_SpellName(47541) or "--Death Coil"
    HEALBOT_PLAGUE_STRIKE                  =45462 --HealBot_WoWAPI_SpellName(45462) or "--Plague Strike"
    --Demon Hunter
    --Druid
    HEALBOT_CYCLONE                        =33786 --HealBot_WoWAPI_SpellName(33786) or "--Cyclone"
    HEALBOT_ENTANGLING_ROOTS               =339 --HealBot_WoWAPI_SpellName(339)  or "--Entangling Roots"
    HEALBOT_FAERIE_FIRE                    =770 --HealBot_WoWAPI_SpellName(770)  or "--Faerie Fire"
    HEALBOT_FAERIE_SWARM                   =106707 --HealBot_WoWAPI_SpellName(106707) or "--Faerie Swarm"
    HEALBOT_GROWL                          =6795 --HealBot_WoWAPI_SpellName(6795) or "--Growl"
    HEALBOT_HURRICANE                      =16914 --HealBot_WoWAPI_SpellName(16914)  or "--Hurricane"
    HEALBOT_MASS_ENTANGLEMENT              =102359 --HealBot_WoWAPI_SpellName(102359) or "--Mass Entanglement"
    HEALBOT_MOONFIRE                       =8921 --HealBot_WoWAPI_SpellName(8921) or "--Moonfire"
    HEALBOT_SOOTHE                         =2908 --HealBot_WoWAPI_SpellName(2908) or "--Soothe"
    HEALBOT_WRATH                          =5176 --HealBot_WoWAPI_SpellName(5176)  or "--Wrath"
    --Hunter
    HEALBOT_AIMED_SHOT                     =19434 --HealBot_WoWAPI_SpellName(19434) or "--Aimed Shot"  
    HEALBOT_ARCANE_SHOT                    =3044 --HealBot_WoWAPI_SpellName(3044) or "--Arcane Shot"
    HEALBOT_CONCUSSIVE_SHOT                =5116 --HealBot_WoWAPI_SpellName(5116) or "--Concussive Shot"
    --Mage
    HEALBOT_FIRE_BLAST                     =2136 --HealBot_WoWAPI_SpellName(2136) or "--Fire Blast" 
    HEALBOT_FROSTFIRE_BOLT                 =44614 --HealBot_WoWAPI_SpellName(44614) or "--Frostfire Bolt"
    HEALBOT_MAGE_BOMB                      =125430 --HealBot_WoWAPI_SpellName(125430) or "--Mage Bomb" 
    --Monk
    HEALBOT_BLACKOUT_KICK                  =100784 --HealBot_WoWAPI_SpellName(100784) or "--Blackout Kick"
    HEALBOT_CHI_BURST                      =123986 --HealBot_WoWAPI_SpellName(123986) or "--Chi Burst"
    HEALBOT_CRACKLING_JADE_LIGHTNING       =117952 --HealBot_WoWAPI_SpellName(117952) or "--Crackling Jade Lightning"
    HEALBOT_DISABLE                        =116095 --HealBot_WoWAPI_SpellName(116095) or "--Disable"
    HEALBOT_EXPEL_HARM                     =115072 
    HEALBOT_JAB                            =100780 --HealBot_WoWAPI_SpellName(100780) or "--Jab"
    HEALBOT_PARALYSIS                      =115078 --HealBot_WoWAPI_SpellName(115078) or "--Paralysis"
    HEALBOT_PROVOKE                        =115546 --HealBot_WoWAPI_SpellName(115546) or "--Provoke"
    HEALBOT_SPEAR_HAND_STRIKE              =116705 --HealBot_WoWAPI_SpellName(116705) or "--Spear Hand Strike"
    HEALBOT_TIGER_PALM                     =100787 --HealBot_WoWAPI_SpellName(100787) or "--Tiger Palm"
    HEALBOT_TOUCH_OF_DEATH                 =115080 --HealBot_WoWAPI_SpellName(115080) or "--Touch of Death"
    HEALBOT_TOUCH_OF_DEATH                 =115080 --HealBot_WoWAPI_SpellName(115080) or "--Touch of Death"
    --Paladin
    HEALBOT_BINDING_LIGHT                  =115750 --HealBot_WoWAPI_SpellName(115750) or "--Blinding Light"
    HEALBOT_CRUSADER_STRIKE                =35395 --HealBot_WoWAPI_SpellName(35395) or "--Crusader Strike"
    HEALBOT_DENOUNCE                       =2812 --HealBot_WoWAPI_SpellName(2812) or "--Denounce"
    HEALBOT_HAMMER_OF_JUSTICE              =853 --HealBot_WoWAPI_SpellName(853) or "--Hammer of Justice"
    HEALBOT_HAMMER_OF_WRATH                =24275 --HealBot_WoWAPI_SpellName(24275) or "--Hammer of Wrath"
    HEALBOT_HOLY_SHOCK                     =20473 --HealBot_WoWAPI_SpellName(20473) or "--Holy Shock"
    HEALBOT_JUDGMENT                       =20271 --HealBot_WoWAPI_SpellName(20271) or "--Judgment"
    HEALBOT_REBUKE                         =96231 --HealBot_WoWAPI_SpellName(96231) or "--Rebuke"
    HEALBOT_RECKONING                      =62124 --HealBot_WoWAPI_SpellName(62124) or "--Reckoning"
    HEALBOT_REPENTANCE                     =20066 --HealBot_WoWAPI_SpellName(20066) or "--Repentance"
    HEALBOT_SHIELD_OF_THE_RIGHTEOUS        =53600 --HealBot_WoWAPI_SpellName(53600) or "--Shield of the Righteous";
    HEALBOT_TURN_EVIL                      =10326 --HealBot_WoWAPI_SpellName(10326) or "--Turn Evil"
    --Priest
    HEALBOT_DOMINATE_MIND                  =605 --HealBot_WoWAPI_SpellName(605) or "--Dominate Mind"
    HEALBOT_HOLY_FIRE                      =14914 --HealBot_WoWAPI_SpellName(14914) or "--Holy Fire"
    HEALBOT_MIND_SEAR                      =48045 --HealBot_WoWAPI_SpellName(48045) or "--Mind Sear"
    HEALBOT_MINDBENDER                     =123040 --HealBot_WoWAPI_SpellName(123040) or "--Mindbender"
    HEALBOT_SHACKLE_UNDEAD                 =9484 --HealBot_WoWAPI_SpellName(9484) or "--Shackle Undead"
    HEALBOT_SHADOW_WORD_PAIN               =589 --HealBot_WoWAPI_SpellName(589) or "--Shadow Word: Pain"
    HEALBOT_SHADOW_WORD_DEATH              =32379 --HealBot_WoWAPI_SpellName(32379) or "--Shadow Word: Death"
    HEALBOT_SMITE                          =585 --HealBot_WoWAPI_SpellName(585) or "--Smite"
    HEALBOT_HOLY_WORD_CHASTISE             =88625 --HealBot_WoWAPI_SpellName(88625) or "--Holy Word: Chastise";
    HEALBOT_DISPEL_MAGIC                   =528 --HealBot_WoWAPI_SpellName(528) or "--Dispel Magic"
    --Rogue
    HEALBOT_GOUGE                          =1776 --HealBot_WoWAPI_SpellName(1776) or "--Gouge"
    HEALBOT_THROW                          =121733 --HealBot_WoWAPI_SpellName(121733) or "--Throw"  
    --Shaman
    HEALBOT_CHAIN_LIGHTNING                =421 --HealBot_WoWAPI_SpellName(421) or "--Chain Lightning"
    HEALBOT_EARTH_SHOCK                    =8042 --HealBot_WoWAPI_SpellName(8042) or "--Earth Shock"
    HEALBOT_ELEMENTAL_BLAST                =117014 --HealBot_WoWAPI_SpellName(117014) or "--Elemental Blast"
    HEALBOT_FLAME_SHOCK                    =188389
    HBC_FLAME_SHOCK                        =8050 --HealBot_WoWAPI_SpellName(8050) or "--Flame Shock"
    HEALBOT_FROST_SHOCK                    =8056 --HealBot_WoWAPI_SpellName(8056) or "--Frost Shock"
    HEALBOT_HEX                            =51514 --HealBot_WoWAPI_SpellName(51514) or "--Hex"
    HEALBOT_LAVA_BLAST                     =51505 --HealBot_WoWAPI_SpellName(51505) or "--Lava Blast"
    HEALBOT_LIGHTNING_BOLT                 =188196
    HBC_LIGHTNING_BOLT                     =403
    HEALBOT_PRIMAL_STRIKE                  =73899 --HealBot_WoWAPI_SpellName(73899) or "--Primal Strike"
    HEALBOT_PURGE                          =370 --HealBot_WoWAPI_SpellName(370) or "--Purge"
    HEALBOT_WIND_SHEAR                     =57994 --HealBot_WoWAPI_SpellName(57994) or "--Wind Shear" 
    --Warlock
    HEALBOT_CORRUPTION                     =172 --HealBot_WoWAPI_SpellName(172) or "--Corruption" 
    HEALBOT_FEAR                           =5782 --HealBot_WoWAPI_SpellName(5782) or "--Fear"   
    --Warrior
    HEALBOT_EXECUTE                        =5308 --HealBot_WoWAPI_SpellName(5308) or "--Execute"
    HEALBOT_TAUNT                          =355 --HealBot_WoWAPI_SpellName(355) or "--Taunt"

    --Healing Spells By Class 
    --Druid
    HEALBOT_CENARION_WARD                  =102352 --HealBot_WoWAPI_SpellName(102351) or "--Cenarion Ward";
    HEALBOT_HEALING_TOUCH                  =5185 --HealBot_WoWAPI_SpellName(5185) or "--Healing Touch";
    HEALBOT_LIFEBLOOM                      =33763 --HealBot_WoWAPI_SpellName(33763) or "--Lifebloom";
    HEALBOT_REGROWTH                       =8936 --HealBot_WoWAPI_SpellName(8936) or "--Regrowth";
    HEALBOT_REJUVENATION                   =774 --HealBot_WoWAPI_SpellName(774) or "--Rejuvenation";
    HEALBOT_SWIFTMEND                      =18562 --HealBot_WoWAPI_SpellName(18562) or "--Swiftmend";
    HEALBOT_TRANQUILITY                    =157982 --HealBot_WoWAPI_SpellName(740) or "--Tranquility";
    HEALBOT_WILD_GROWTH                    =48438 --HealBot_WoWAPI_SpellName(48438) or "--Wild Growth";
    HBC_NOURISH                            =50464
    HEALBOT_NOURISH                        =289022
    HEALBOT_OVERGROWTH                     =203651
    -- Evoker
    HEALBOT_DREAM_BREATH                   =355936
    HEALBOT_DREAM_FLIGHT                   =359816
    HEALBOT_DREAM_PROJECTION               =377509
    HEALBOT_ECHO                           =364343
    HEALBOT_EMERALD_BLOSSOM                =365261
    HEALBOT_EMERALD_COMMUNION              =370960
    HEALBOT_LIVING_FLAME                   =361469
    HEALBOT_REVERSION                      =367364
    HEALBOT_REWIND                         =363534
    HEALBOT_SPIRITBLOOM                    =367226
    HEALBOT_VERDANT_EMBRACE                =360995
    HEALBOT_RESCUE                         =370665
    HEALBOT_ZEPHYR                         =374227
    --Monk
    HEALBOT_CHI_WAVE                       =132463 --HealBot_WoWAPI_SpellName(132463) or "--Chi Wave"
    HEALBOT_CHI_BURST                      =130651 --HealBot_WoWAPI_SpellName(130651) or "--Chi Burst"
    HEALBOT_ENVELOPING_MIST                =124682 --HealBot_WoWAPI_SpellName(124682) or "--Enveloping Mist"
    HEALBOT_RENEWING_MIST                  =119611 --HealBot_WoWAPI_SpellName(115151) or "--Renewing Mist"
    HEALBOT_RENEWING_MIST_NAME             =HealBot_WoWAPI_SpellName(HEALBOT_RENEWING_MIST) or "--Renewing Mist"
    HEALBOT_REVIVAL                        =115310 --HealBot_WoWAPI_SpellName(115310) or "--Revival"
    HEALBOT_SOOTHING_MIST                  =198533 --HealBot_WoWAPI_SpellName(115175) or "--Soothing Mist" 
    HEALBOT_SURGING_MIST                   =116694 --HealBot_WoWAPI_SpellName(116694) or "--Surging Mist" 
    HEALBOT_UPLIFT                         =116670 --Changed to Vivify
    HEALBOT_ZEN_MEDITATION                 =115176 --HealBot_WoWAPI_SpellName(115176) or "--Zen Meditation"
    HEALBOT_ZEN_SPHERE                     =124081 --HealBot_WoWAPI_SpellName(124081) or "--Zen Sphere"
    --Paladin
    HEALBOT_FLASH_OF_LIGHT                 =19750 --HealBot_WoWAPI_SpellName(19750) or "--Flash of Light";
    HEALBOT_HOLY_LIGHT                     =82326 --HealBot_WoWAPI_SpellName(82326) or "--Holy Light";
    HBC_HOLY_LIGHT                         =635 --HealBot_WoWAPI_SpellName(635) or "--Holy Light";
    HEALBOT_HOLY_PRISM                     =114165 --HealBot_WoWAPI_SpellName(114165) or "--Holy Prism";
    HEALBOT_HOLY_RADIANCE                  =82327 --HealBot_WoWAPI_SpellName(82327) or "--Holy Radiance";
    HEALBOT_LIGHT_OF_DAWN                  =85222 --HealBot_WoWAPI_SpellName(85222) or "--Light of Dawn";
    HEALBOT_WORD_OF_GLORY                  =85673 --HealBot_WoWAPI_SpellName(85673) or "--Word of Glory";
    --Priest
    HEALBOT_BINDING_HEAL                   =32546 --HealBot_WoWAPI_SpellName(32546) or "--Binding Heal"
    HEALBOT_CASCADE                        =121135 --HealBot_WoWAPI_SpellName(121135) or "--Cascade"
    HEALBOT_CIRCLE_OF_HEALING              =204883 --HealBot_WoWAPI_SpellName(204883) or "--Circle of Healing";
    HEALBOT_DESPERATE_PRAYER               =19236 --HealBot_WoWAPI_SpellName(19236) or "--Desperate Prayer";
    HEALBOT_DIVINE_HYMN                    =64844 --HealBot_WoWAPI_SpellName(64843) or "--Divine Hymn";
    HEALBOT_DIVINE_STAR                    =110744 --HealBot_WoWAPI_SpellName(110744) or "--Divine Star"
    HEALBOT_FLASH_HEAL                     =2061 --HealBot_WoWAPI_SpellName(2061) or "--Flash Heal";
    HEALBOT_HALO                           =120517 --HealBot_WoWAPI_SpellName(120517) or "--Halo"
    HEALBOT_HEAL                           =2060 --HealBot_WoWAPI_SpellName(2060) or "--Heal"; -- Greater Heal in Classic
    HBC_HEAL                               =2054 
    HEALBOT_HOLY_WORD_SALVATION            =265202 --HealBot_WoWAPI_SpellName(265202) or "--Holy Word: Salvation";
    HEALBOT_HOLY_WORD_SERENITY             =2050 --Lesser Heal in Classic
    HBC_HOLY_WORD_SERENITY                 =88684  --HealBot_WoWAPI_SpellName(88684) or "Holy Word: Serenity";
    HEALBOT_HOLY_WORD_SANCTUARY            =88685 --HealBot_WoWAPI_SpellInfo(88685) or "Holy Word: Sanctuary"; -- PoH 


    HEALBOT_PENANCE                        =47540 --HealBot_WoWAPI_SpellName(47540) or "--Penance"
    HEALBOT_PRAYER_OF_HEALING              =596 --HealBot_WoWAPI_SpellName(596) or "--Prayer of Healing";
    HEALBOT_PRAYER_OF_MENDING              =33076 --HealBot_WoWAPI_SpellName(33076) or "--Prayer of Mending";  41635=buff icon - 33076=known spell
    HEALBOT_RENEW                          =139 --HealBot_WoWAPI_SpellName(139) or "--Renew";
    HEALBOT_PLEA                           =200829 --HealBot_WoWAPI_SpellName(200829) or "--Plea";    
    HEALBOT_POWER_WORD_RADIANCE            =194509 --HealBot_WoWAPI_SpellName(194509) or "--Power Word: Radiance";
    HEALBOT_POWER_WORD_LIFE                =373481
    HEALBOT_SHADOW_MEND                    =186263 --HealBot_WoWAPI_SpellName(186263) or "--Shadow Mend;"
    HEALBOT_HOLY_WORD_SANCTIFY             =34861 --HealBot_WoWAPI_SpellName(34861) or "--Holy Word: Sanctify";
    HEALBOT_SPIRIT_OF_REDEMPTION           =27827 --HealBot_WoWAPI_SpellName(20711) or "--Spirit of Redemption";
    HEALBOT_SPIRIT_OF_REDEMPTION_NAME      =HealBot_WoWAPI_SpellName(27827) or HealBot_WoWAPI_SpellName(20711) or "Spirit of Redemption"
    HEALBOT_HOLY_WARD                      =213610 --HealBot_WoWAPI_SpellName(213610) or "--Holy Ward";
    HBC_HOLY_NOVA                          =15237
    HEALBOT_UNHOLY_HOVA                    =324724
    
    --Shaman
    HEALBOT_CHAIN_HEAL                     =1064 --HealBot_WoWAPI_SpellName(1064) or "--Chain Heal";
    HEALBOT_HEALING_RAIN                   =73920 --HealBot_WoWAPI_SpellName(73920) or "--Healing Rain";
    HEALBOT_HEALING_STREAM_TOTEM           =5394 --HealBot_WoWAPI_SpellName(119523) or "--Healing Stream Totem";
    HEALBOT_HEALING_SURGE                  =8004 --HealBot_WoWAPI_SpellName(8004) or "--Healing Surge";
    HEALBOT_HEALING_TIDE_TOTEM             =108280 --HealBot_WoWAPI_SpellName(108280) or "--Healing Tide Totem";
    HEALBOT_HEALING_WAVE                   =77472 --HealBot_WoWAPI_SpellName(77472) or "--Healing Wave";
    HBC_LESSER_HEALING_WAVE                =8004
    HBC_RU_LESSER_HEALING_WAVE             =49275
    HBC_HEALING_WAVE                       =331
    HEALBOT_PRIMORDIAL_WAVE                =326059
    HEALBOT_RIPTIDE                        =61295 --HealBot_WoWAPI_SpellName(61295) or "--Riptide";
    HEALBOT_WELLSPRING                     =197995 --HealBot_WoWAPI_SpellName(197995) or "--Wellspring";
    HEALBOT_DOWNPOUR                       =207778 --HealBot_WoWAPI_SpellName(207778) or "--Downpour";
    --Warlock
    HEALBOT_HEALTH_FUNNEL                  =755 --HealBot_WoWAPI_SpellName(755) or "--Health Funnel";

    HBC_INSPELLS={ [5185]=55,    [5186]=119,   [5187]=253,   [5188]=459,   [5189]=712,   [6778]=914,  -- Healing Touch
                     [8903]=1143,  [9758]=1453,  [9888]=1826,  [9889]=2257,  [25297]=2677,              -- Healing Touch
                   }
    --Buffs, Talents, Traits, Glyphs and Other Spells By Class
    --Death Knight
    HEALBOT_ANTIMAGIC_SHELL                =48707 --HealBot_WoWAPI_SpellName(48707) or "--Antimagic Shell";
    HEALBOT_ANTIMAGIC_ZONE                 =51052 --HealBot_WoWAPI_SpellName(51052) or "--Antimagic Zone";
    HEALBOT_ARMY_OF_THE_DEAD               =42650 --HealBot_WoWAPI_SpellName(42650) or "--Army of the Dead";
    HEALBOT_BONE_SHIELD                    =49222 --HealBot_WoWAPI_SpellName(49222) or "--Bone Shield";
    HEALBOT_DANCING_RUNE_WEAPON            =81256 --HealBot_WoWAPI_SpellName(49028) or "--Dancing Rune Weapon"
    HEALBOT_HORN_OF_WINTER                 =57330 --HealBot_WoWAPI_SpellName(57330) or "--Horn of Winter";
    HEALBOT_ICEBOUND_FORTITUDE             =48792 --HealBot_WoWAPI_SpellName(48792) or "--Icebound Fortitude";
    --HEALBOT_LICHBORNE                      =49039 --HealBot_WoWAPI_SpellName(49039) or "--Lichborne";
    HEALBOT_POWER_OF_THE_GRAVE             =155522 --HealBot_WoWAPI_SpellName(155522) or "--Power of the Grave";  
    HEALBOT_SHROUD_OF_PURGATORY            =116888 --HealBot_WoWAPI_SpellName(116888) or "--Shroud of Purgatory"; 
    HEALBOT_UNHOLY_AURA                    =55610 --HealBot_WoWAPI_SpellName(55610) or "--Unholy Aura"
    HEALBOT_VAMPIRIC_BLOOD                 =55233 --HealBot_WoWAPI_SpellName(55233) or "--Vampiric Blood";
    
    --Demon Hunter
    HEALBOT_DEMON_SPIKES                   =203720 --HealBot_WoWAPI_SpellName(203720) or "--Demon Spikes";
    HEALBOT_BLUR                           =212800 --HealBot_WoWAPI_SpellName(198589) or "--Blur"
    --HEALBOT_EMPOWER_WARDS                  =218256 --HealBot_WoWAPI_SpellName(218256) or "--Empower Wards";
    HEALBOT_METAMORPHOSIS                  =187827 --HealBot_WoWAPI_SpellName(187827) or "--Metamorphosis";

    --Druid
    HEALBOT_BARKSKIN                       =22812 --HealBot_WoWAPI_SpellName(22812) or "--Barkskin";
    HEALBOT_CULTIVATION                    =200389 --HealBot_WoWAPI_SpellName(200390) or "--Cultivation";
    HEALBOT_DRUID_CLEARCASTING             =16870 --HealBot_WoWAPI_SpellName(16870) or "--Clearcasting";
    HEALBOT_FRENZIED_REGEN                 =22842 --HealBot_WoWAPI_SpellName(22842) or "--Frenzied Regeneration";
    HBC_GIFT_OF_THE_WILD                   =21849
    HEALBOT_HARMONY                        =77495 --HealBot_WoWAPI_SpellName(77495) or "--Mastery Harmony";
    HEALBOT_INNERVATE                      =29166 --HealBot_WoWAPI_SpellName(29166) or "--Innervate";
    HEALBOT_IRONBARK                       =102342 --HealBot_WoWAPI_SpellName(102342) or "--Ironbark";
    HEALBOT_IRONFUR                        =192081 --HealBot_WoWAPI_SpellName(192081) or "--Ironfur";
    HEALBOT_LEADER_OF_THE_PACK             =17007 --HealBot_WoWAPI_SpellName(17007) or "--Leader of the Pack";
    --HEALBOT_LIVING_SEED                    =48500 --HealBot_WoWAPI_SpellName(48500) or "--Living Seed";
    HEALBOT_MARK_OF_THE_WILD               =1126 --HealBot_WoWAPI_SpellName(1126) or "--Mark of the Wild";
    HEALBOT_SYMBIOTIC_RELATIONSHIP         =474750 -- "--Symbiotic Relationship"
    HEALBOT_MOONKIN_AURA                   =24907 --HealBot_WoWAPI_SpellName(24907) or "--Moonkin Aura";
    HBC_NATURE_GRASP                       =16689
    HEALBOT_NATURE_MOMENT_OF_CLARITY       =236068 --HealBot_WoWAPI_SpellName(236068) or "--Moment of Clarity";
    HEALBOT_NATURE_REJUVENATION_GERMINATION=155777 --HealBot_WoWAPI_SpellName(155777) or "--Rejuvenation (Germination)";
    HEALBOT_NATURE_RAMPANT_GROWTH          =155834 --HealBot_WoWAPI_SpellName(155834) or "--Rampant Growth";
    HBC_OMEN_OF_CLARITY                    =16864
    HEALBOT_SAVAGE_DEFENCE                 =62606 --HealBot_WoWAPI_SpellName(62606) or "--Savage Defense";
    HEALBOT_SURVIVAL_INSTINCTS             =61336 --HealBot_WoWAPI_SpellName(61336) or "--Survival Instincts";
    HEALBOT_TREE_OF_LIFE                   =33891 --HealBot_WoWAPI_SpellName(33891) or "--Tree of Life";
    HEALBOT_SPRING_BLOSSOMS                =207386 --HealBot_WoWAPI_SpellName(207385) or "--Spring Blossoms";
    HEALBOT_ESSENCE_OF_GHANIR              =208253 --HealBot_WoWAPI_SpellName(208253) or "--Essence of G'Hanir"
    HEALBOT_FOCUSED_GROWTH                 =203554 --HealBot_WoWAPI_SpellName(203554) or "--Focused Growth"
    HEALBOT_GROVE_TENDING                  =279793 --HealBot_WoWAPI_SpellName(279793) or "--Grove Tending";
    HBC_THORNS                             =467
    --Evoker
    HEALBOT_BLESSING_OF_THE_BRONZE         =364342
    HEALBOT_BLISTERING_SCALES              =360827
    HEALBOT_SOURCE_OF_MAGIC                =369459
    HEALBOT_LIFEBIND                       =373270
    HEALBOT_TIME_DILATION                  =357170
    HEALBOT_OBSIDIAN_SCALES                =363916
    HEALBOT_RENEWING_BLAZE                 =374348
    HEALBOT_TIME_STOP                      =378441
    HEALBOT_STASIS                         =370537
    HEALBOT_FURY_OF_THE_ASPECTS            =390386
    HEALBOT_VISAGE                         =372014
    HEALBOT_EXHILARATING_BURST             =377102
    HEALBOT_ESSENCE_BURST                  =369299
    HEALBOT_TEMPRAL_ANOMALY                =373861
    HEALBOT_TEMPRAL_COMPRESSION            =362877
    HEALBOT_NULLIFYING_SHROUD              =378464
    HEALBOT_CALL_OF_YSERA                  =373835
    --Hunter
    HEALBOT_A_CHEETAH                      =5118 --HealBot_WoWAPI_SpellName(5118) or "--Aspect of the Cheetah"
    HEALBOT_A_PACK                         =13159 --HealBot_WoWAPI_SpellName(13159) or "--Aspect of the Pack"
    HEALBOT_A_WILD                         =20043 --HealBot_WoWAPI_SpellName(20043) or "--Aspect of the Wild"
    HEALBOT_DETERRENCE                     =19263 --HealBot_WoWAPI_SpellName(19263) or "--Deterrence"
    HEALBOT_LW_FEROCITY_OF_THE_RAPTOR      =160200 --HealBot_WoWAPI_SpellName(160200) or "--Lone Wolf: Ferocity of the Raptor"
    HEALBOT_LW_FORTITUDE_OF_THE_BEAR       =160199 --HealBot_WoWAPI_SpellName(160199) or "--Lone Wolf: Fortitude of the Bear"
    HEALBOT_LW_GRACE_OF_THE_CAT            =160198 --HealBot_WoWAPI_SpellName(160198) or "--Lone Wolf: Grace of the Cat"
    HEALBOT_LW_HASTE_OF_THE_HYENA          =160203 --HealBot_WoWAPI_SpellName(160203) or "--Lone Wolf: Haste of the Hyena"
    HEALBOT_LW_POWER_OF_THE_PRIMATES       =160206 --HealBot_WoWAPI_SpellName(160206) or "--Lone Wolf: Power of the Primates"
    HEALBOT_LW_QUICKNESS_OF_THE_DRAGONHAWK =172968 --HealBot_WoWAPI_SpellName(172968) or "--Lone Wolf: Quickness of the Dragonhawk"
    HEALBOT_LW_VERSATILITY_OF_THE_RAVAGER  =172967 --HealBot_WoWAPI_SpellName(172967) or "--Lone Wolf: Versatility of the Ravager"
    HEALBOT_LW_WISDOM_OF_THE_SERPENT       =160205 --HealBot_WoWAPI_SpellName(160205) or "--Lone Wolf: Wisdom of the Serpent"
    HEALBOT_MENDPET                        =136 --HealBot_WoWAPI_SpellName(136) or "--Mend Pet"
    HEALBOT_TRAP_LAUNCHER                  =77769 --HealBot_WoWAPI_SpellName(77769) or "--Trap Launcher"
    HEALBOT_TRUESHOT_AURA                  =19506 --HealBot_WoWAPI_SpellName(19506) or "--Trueshot Aura"
    
    --Hunter Pets
    HEALBOT_BARK_OF_THE_WILD               =159988 --HealBot_WoWAPI_SpellName(159988) or "--Bark of the Wild"
    HEALBOT_BLESSING_OF_KONGS              =160017 --HealBot_WoWAPI_SpellName(160017) or "--Blessing of Kongs"
    HEALBOT_BREATH_OF_THE_WINDS            =24844 --HealBot_WoWAPI_SpellName(24844) or "--Breath of the Winds"
    HEALBOT_CACKLING_HOWL                  =128432 --HealBot_WoWAPI_SpellName(128432) or "--Cackling Howl"
    HEALBOT_CHITINOUS_ARMOR                =50518 --HealBot_WoWAPI_SpellName(50518) or "--Chitinous Armor"
    HEALBOT_DEFENSIVE_QUILLS               =160045 --HealBot_WoWAPI_SpellName(160045) or "--Defensive Quills"
    HEALBOT_DOUBLE_BITE                    =58604 --HealBot_WoWAPI_SpellName(58604) or "--Double Bite"
    HEALBOT_EMBRACE_OF_THE_SHALE_SPIDER    =90363 --HealBot_WoWAPI_SpellName(90363) or "--Embrace of the Shale Spider"
    HEALBOT_ENERGIZING_SPORES              =135678 --HealBot_WoWAPI_SpellName(135678) or "--Energizing Spores"
    HEALBOT_FEARLESS_ROAR                  =126373 --HealBot_WoWAPI_SpellName(126373) or "--Fearless Roar"
    HEALBOT_FURIOUS_HOWL                   =24604 --HealBot_WoWAPI_SpellName(24604) or "--Furious Howl"
    HEALBOT_GRACE                          =173035 --HealBot_WoWAPI_SpellName(173035) or "--Grace"
    HEALBOT_INVIGORATING_ROAR              =50256 --HealBot_WoWAPI_SpellName(50256) or "--Invigorating Roar"
    HEALBOT_INDOMITABLE                    =35290 --HealBot_WoWAPI_SpellName(35290) or "--Indomitable"
    HEALBOT_KEEN_SENSES                    =160039 --HealBot_WoWAPI_SpellName(160039) or "--Keen Senses"
    HEALBOT_PLAINSWALKING                  =160073 --HealBot_WoWAPI_SpellName(160073) or "--Plainswalking"
    HEALBOT_QIRAJI_FORTITUDE               =90364 --HealBot_WoWAPI_SpellName(90364) or "--Qiraji Fortitude"
    HEALBOT_ROAR_OF_COURAGE                =93435 --HealBot_WoWAPI_SpellName(93435) or "--Roar of Courage"
    HEALBOT_SONIC_FOCUS                    =50519 --HealBot_WoWAPI_SpellName(50519) or "--Sonic Focus"
    HEALBOT_SAVAGE_VIGOR                   =160003 --HealBot_WoWAPI_SpellName(160003) or "--Savage Vigor"
    HEALBOT_SERPENTS_CUNNING               =128433 --HealBot_WoWAPI_SpellName(128433) or "--Serpent's Cunning"
    HEALBOT_SPEED_OF_THE_SWARM             =160074 --HealBot_WoWAPI_SpellName(160074) or "--Speed of the Swarm"
    HEALBOT_SPIRIT_BEAST_BLESSING          =128997 --HealBot_WoWAPI_SpellName(128997) or "--Spirit Beast Blessing"
    HEALBOT_SPRY_ATTACKS                   =34889 --HealBot_WoWAPI_SpellName(34889) or "--Spry Attacks"
    HEALBOT_STILL_WATER                    =126309 --HealBot_WoWAPI_SpellName(126309) or "--Still Water"
    HEALBOT_STRENGTH_OF_THE_EARTH          =160077 --HealBot_WoWAPI_SpellName(160077) or "--Strength of the Earth"
    HEALBOT_STRENGTH_OF_THE_PACK           =160052 --HealBot_WoWAPI_SpellName(160052) or "--Strength of the Pack"
    HEALBOT_STURDINESS                     =160014 --HealBot_WoWAPI_SpellName(160014) or "--Sturdiness"
    HEALBOT_TENACITY                       =159735 --HealBot_WoWAPI_SpellName(159735) or "--Tenacity"
    HEALBOT_TERRIFYING_ROAR                =90309 --HealBot_WoWAPI_SpellName(90309) or "--Terrifying Roar"
    HEALBOT_WILD_STRENGTH                  =57386 --HealBot_WoWAPI_SpellName(57386) or "--Wild Strength"

    --Mage
    HBC_AMPLIFY_MAGIC                      =1008
    HEALBOT_ARCANE_BRILLIANCE              =1459 --HealBot_WoWAPI_SpellName(1459) or "--Arcane Brilliance"; -- Arcane Intellect in Classic
    HBC_ARCANE_BRILLIANCE                  =23028
    HEALBOT_ARCANE_POWER                   =12042 --HealBot_WoWAPI_SpellName(12042) or "--Arcane Power"
    HEALBOT_BLAZING_BARRIER                =235313 --HealBot_WoWAPI_SpellName(235313) or "--Blazing Barrier"
    HEALBOT_DALARAN_BRILLIANCE             =61316 --HealBot_WoWAPI_SpellName(61316) or "--Dalaran Brilliance";
    HBC_DAMPEN_MAGIC                       =604
    HEALBOT_EVOCATION                      =12051 --HealBot_WoWAPI_SpellName(12051) or "--Evocation";
    HBC_FOCUS_MAGIC                        =54646 --HealBot_WoWAPI_SpellName(54646) or "--Focus Magic";
    HEALBOT_FOCUS_MAGIC                    =321358
    HBC_FROST_ARMOR                        =168
    HBC_ICE_ARMOR                          =7302
    HBC_MOLTEN_ARMOR                       =30482
    HEALBOT_ICE_BARRIER                    =11426 --HealBot_WoWAPI_SpellName(11426) or "--Ice Barrier"
    HEALBOT_ICE_BLOCK                      =45438 --HealBot_WoWAPI_SpellName(45438) or "--Ice Block"
    HEALBOT_ICE_WARD                       =111264 --HealBot_WoWAPI_SpellName(111264) or "--Ice Ward"
    HEALBOT_INCANTERS_WARD                 =116267 --HealBot_WoWAPI_SpellName(1463) or "--Incanter's Ward"
    HBC_MAGE_ARMOR                         =6117
    HEALBOT_MAGE_WARD                      =543 --HealBot_WoWAPI_SpellName(543) or "--Mage Ward";
    HBC_MANA_SHIELD                        =1463
    HEALBOT_PRISMATIC_BARRIER              =235450 --HealBot_WoWAPI_SpellName(235450) or "--Prismatic Barrier"
    HEALBOT_SLOW_FALL                      =130 --HealBot_WoWAPI_SpellName(130) or "--Slow Fall"

    --Paladin
    HEALBOT_ARDENT_DEFENDER                =31850 --HealBot_WoWAPI_SpellName(31850) or "--Ardent Defender";
    HEALBOT_BEACON_OF_FAITH                =156910 --HealBot_WoWAPI_SpellName(156910) or "--Beacon of Faith";
    HEALBOT_BEACON_OF_INSIGHT              =157007 --HealBot_WoWAPI_SpellName(157007) or "--Beacon of Insight";
    HEALBOT_BEACON_OF_LIGHT                =53563 --HealBot_WoWAPI_SpellName(53563) or "--Beacon of Light";
    HEALBOT_BEACON_OF_VIRTUE               =200025 --HealBot_WoWAPI_SpellName(200025) or "--Beacon of Virtue";
    HEALBOT_TYRS_DELIVERANCE               =200654 --HealBot_WoWAPI_SpellName(200654) or "--Tyr's Deliverance";
    HEALBOT_BLESSING_OF_KINGS              =203538 --HealBot_WoWAPI_SpellName(203538) or "--Greater Blessing of Kings";
    HBC_BLESSING_OF_KINGS                  =20217
    HBC_BLESSING_OF_LIGHT                  =19977
    HBC_BLESSING_OF_SALVATION              =1038
    HEALBOT_BLESSING_OF_MIGHT              =203528 --HealBot_WoWAPI_SpellName(203528) or "--Greater Blessing of Might";
    HBC_BLESSING_OF_MIGHT                  =19740 --HealBot_WoWAPI_SpellName(19740) or "--Greater Blessing of Might";
    HBC_BLESSING_OF_SANCTUARY              =20911
    HEALBOT_BLESSING_OF_WISDOM             =203539 --HealBot_WoWAPI_SpellName(203539) or "--Greater Blessing of Wisdom";
    HBC_BLESSING_OF_WISDOM                 =19742
    HEALBOT_DAY_BREAK                      =88821 --HealBot_WoWAPI_SpellName(88821) or "--Daybreak";
    HEALBOT_DEVOTION_AURA                  =465 --HealBot_WoWAPI_SpellName(465) or "--Devotion Aura";
    HEALBOT_CONCENTRATION_AURA             =19746
    HBC_DIVINE_FAVOR                       =20216
    HBC_DIVINE_INTERVENTION                =19752
    HEALBOT_DIVINE_PROTECTION              =498 --HealBot_WoWAPI_SpellName(498) or "--Divine Protection";
    HEALBOT_DIVINE_PURPOSE                 =223817 --HealBot_WoWAPI_SpellName(86172) or "--Divine Purpose";
    HEALBOT_DIVINE_SAVED_BY_THE_LIGHT      =157047 --HealBot_WoWAPI_SpellName(157047) or "--Saved by the Light";
    HEALBOT_DIVINE_SHIELD                  =642 --HealBot_WoWAPI_SpellName(642) or "--Divine Shield";
    --HEALBOT_ETERNAL_FLAME                  =114163 --HealBot_WoWAPI_SpellName(114163) or "--Eternal Flame";
    HEALBOT_EXECUTION_SENTENCE             =114157 --HealBot_WoWAPI_SpellName(114157) or "--Execution Sentence";
    HBC_GREATER_BLESSING_OF_KINGS          =25898
    HBC_GREATER_BLESSING_OF_LIGHT          =25890
    HBC_GREATER_BLESSING_OF_MIGHT          =25782
    HBC_GREATER_BLESSING_OF_SALVATION      =25895
    HBC_GREATER_BLESSING_OF_SANCTUARY      =25899
    HBC_GREATER_BLESSING_OF_WISDOM         =25894
    --HEALBOT_GUARDED_BY_THE_LIGHT           =53592 --HealBot_WoWAPI_SpellName(53592) or "--Guarded by the Light";
    HEALBOT_GUARDIAN_ANCIENT_KINGS         =86659 --HealBot_WoWAPI_SpellName(86659) or "--Guardian of Ancient Kings";
    HEALBOT_HAND_OF_FREEDOM                =1044 --HealBot_WoWAPI_SpellName(1044) or "--Hand of Freedom";
    HEALBOT_HAND_OF_PROTECTION             =1022 --HealBot_WoWAPI_SpellName(1022) or "--Hand of Protection";
    HEALBOT_HAND_OF_PURITY                 =114039 --HealBot_WoWAPI_SpellName(114039) or "--Hand of Purity";
   -- HEALBOT_HAND_OF_SACRIFICE              =6940 --HealBot_WoWAPI_SpellName(6940) or "--Hand of Sacrifice";
    HEALBOT_HAND_OF_SALVATION              =1038 --HealBot_WoWAPI_SpellName(1038) or "--Hand of Salvation";
    HEALBOT_HOLY_SHOCK                     =20473 --HealBot_WoWAPI_SpellName(20473) or "--Holy Shock";
    HEALBOT_ILLUMINATED_HEALING            =86273 --HealBot_WoWAPI_SpellName(86273) or "--Illuminated Healing";
    HEALBOT_INFUSION_OF_LIGHT              =54149 --HealBot_WoWAPI_SpellName(53576) or "--Infusion of Light";
    HEALBOT_LAY_ON_HANDS                   =633 --HealBot_WoWAPI_SpellName(633) or "--Lay on Hands";
    HEALBOT_LIGHT_BEACON                   =53651 --HealBot_WoWAPI_SpellName(53651) or "--Light's Beacon";
    HBC_RETRIBUTION_AURA                   =7294
    HBC_FIRE_RESISTANCE_AURA               =19891
    HBC_FROST_RESISTANCE_AURA              =19888
    HBC_SHADOW_RESISTANCE_AURA             =19876
    HEALBOT_RIGHTEOUS_FURY                 =25780 --HealBot_WoWAPI_SpellName(25780) or "--Righteous Fury";
    HBC_RIGHTEOUS_DEFENSE                  =31789
    HEALBOT_SACRED_SHIELD                  =85285 --HealBot_WoWAPI_SpellName(85285) or "--Sacred Shield - Holy Shield in Classic";
    HBC_SACRED_SHIELD                      =53601
    HEALBOT_SANCTITY_AURA                  =167187 --HealBot_WoWAPI_SpellName(167187) or "--Sanctity Aura";
    HEALBOT_SEAL_OF_COMMAND                =105361 --HealBot_WoWAPI_SpellName(105361) or "--Seal of Command";
    HBC_SEAL_OF_COMMAND                    =20375
    HEALBOT_SEAL_OF_JUSTICE                =20164 --HealBot_WoWAPI_SpellName(20164) or "--Seal of Justice";
    HEALBOT_SEAL_OF_INSIGHT                =20165 --HealBot_WoWAPI_SpellName(20165) or "--Seal of Insight";
    HEALBOT_SEAL_OF_RIGHTEOUSNESS          =20154 --HealBot_WoWAPI_SpellName(20154) or "--Seal of Righteousness";
    HBC_SEAL_OF_THE_CRUSADER               =21082
    HBC_SEAL_WISDOM                        =20166
    HEALBOT_SEAL_OF_TRUTH                  =31801 --HealBot_WoWAPI_SpellName(31801) or "--Seal of Truth";
    HEALBOT_SPEED_OF_LIGHT                 =85499 --HealBot_WoWAPI_SpellName(85499) or "--Speed of Light";
    HBC_SEAL_OF_CORRUPTION                 =348704
    --Legion Added
    HEALBOT_BLESSING_OF_SACRIFICE          =6940 --HealBot_WoWAPI_SpellName(199448) or "--Blessing of Sacrifice";
    HEALBOT_BESTOW_FAITH                   =223306 --HealBot_WoWAPI_SpellName(223306) or "--Bestow Faith";
    HEALBOT_LIGHT_OF_THE_MARTYR            =183998 --HealBot_WoWAPI_SpellName(183998) or "--Light of the Martyr";
    HEALBOT_HAND_OF_THE_PROTECTOR          =213652 --HealBot_WoWAPI_SpellName(213652) or "--Hand of the Protector";
    HEALBOT_SACRED_DAWN                    =243174 --HealBot_WoWAPI_SpellName(243174) or "--Sacred Dawn";
    HEALBOT_LIGHTS_GRACE                   =216327 --HealBot_WoWAPI_SpellName(216327) or "--Light's Grace";
    HEALBOT_GLIMMER_OF_LIGHT               =287280 --HealBot_WoWAPI_SpellName(287268) or "--Glimmer of Light";
    HEALBOT_BLESSING_OF_SANCTUARY          =210256 --HealBot_WoWAPI_SpellName(210256) or "--Blessing of Sanctuary";
    HEALBOT_BLESSING_OF_SPELLWARDING       =204018 --HealBot_WoWAPI_SpellName(204018) or "--Blessing of Spellwarding";
    
    --Priest
    HEALBOT_ALMAIESH_THE_CORD_OF_HOPE      =211443 --HealBot_WoWAPI_SpellName(211443) or "--Al'maiesh, the Cord of Hope";
    HEALBOT_ANGELIC_BULWARK                =108945 --HealBot_WoWAPI_SpellName(108945) or "--Angelic Bulwark"
    HEALBOT_ANGELIC_FEATHER                =121557 --HealBot_WoWAPI_SpellName(121557) or "--Angelic Feather"
    HEALBOT_APOTHEOSIS                     =200183 --HealBot_WoWAPI_SpellName(200183) or "--Apotheosis"; --Holy
    HEALBOT_ARCHANGEL                      =81700 --HealBot_WoWAPI_SpellName(81700) or "--Archangel";
    HEALBOT_ASCENSION                      =161862 --HealBot_WoWAPI_SpellName(161862) or "--Ascension"
    HEALBOT_ATONEMENT                      =194384 --HealBot_WoWAPI_SpellName(81749) or "--Atonement";
    HEALBOT_AUSPICIOUS_SPIRITS             =155271 --HealBot_WoWAPI_SpellName(155271) or "--Auspicious Spirits"
    HEALBOT_BLESSED_HEALING                =70772 --HealBot_WoWAPI_SpellName(70772) or "--Blessed Healing";
    HEALBOT_BLESSING_OF_TUURE              =196644 --HealBot_WoWAPI_SpellName(196644) or "--Blessing of T'uure";
    HEALBOT_BODY_AND_MIND                  =214121 --HealBot_WoWAPI_SpellName(214121) or "--Body and Mind";
    HEALBOT_CHAKRA                         =14751 --HealBot_WoWAPI_SpellName(14751) or "--Chakra";
    HEALBOT_CHAKRA_CHASTISE                =81209 --HealBot_WoWAPI_SpellName(81209) or "--Chakra: Chastise";
    HEALBOT_CHAKRA_SANCTUARY               =81206 --HealBot_WoWAPI_SpellName(81206) or "--Chakra: Sanctuary";
    HEALBOT_CHAKRA_SERENITY                =81208 --HealBot_WoWAPI_SpellName(81208) or "--Chakra: Serenity";
    HEALBOT_CHAKRA_SERENITYNAME            =HealBot_WoWAPI_SpellName(81208) or "--Chakra: Serenity";
    HEALBOT_CLARITY_OF_POWER               =155246 --HealBot_WoWAPI_SpellName(155246) or "--Clarity of Power"
    HEALBOT_CLARITY_OF_PURPOSE             =155245 --HealBot_WoWAPI_SpellName(155245) or "--Clarity of Purpose"
    HEALBOT_CLARITY_OF_WILL                =152118 --HealBot_WoWAPI_SpellName(152118) or "--Clarity of Will"
    HEALBOT_DISPERSION                     =47585 --HealBot_WoWAPI_SpellName(47585) or "--Dispersion"
    HEALBOT_DIVINE_AEGIS                   =47515 --HealBot_WoWAPI_SpellName(47515) or "--Divine Aegis";
    HBC_DIVINE_SPIRIT                      =14752
    HEALBOT_DIVINITY                       =197031 --HealBot_WoWAPI_SpellName(197031) or "--Divinity";
    HEALBOT_ECHO_OF_LIGHT                  =77489 --HealBot_WoWAPI_SpellName(77489) or "--Echo of Light";
    HEALBOT_EVANGELISM                     =81661 --HealBot_WoWAPI_SpellName(81661) or "--Evangelism";
    HEALBOT_FEAR_WARD                      =6346 --HealBot_WoWAPI_SpellName(6346) or "--Fear Ward";
    HEALBOT_FOCUSED_WILL                   =45242 --HealBot_WoWAPI_SpellName(45243) or "--Focused Will";
    HEALBOT_GRACE                          =47517 --HealBot_WoWAPI_SpellName(47517) or "--Grace";
    HEALBOT_GUARDIAN_SPIRIT                =47788 --HealBot_WoWAPI_SpellName(47788) or "--Guardian Spirit";
    HEALBOT_HOLY_NOVA                      =132157 --HealBot_WoWAPI_SpellName(132157) or "--Holy Nova";
    HBC_INNER_FIRE                         =588
    HBC_INNER_WILL                         =73413
    HEALBOT_INSPIRATION                    =14893 --HealBot_WoWAPI_SpellName(14893) or "--Inspiration";
    HEALBOT_LEAP_OF_FAITH                  =73325 --HealBot_WoWAPI_SpellName(73325) or "--Leap of Faith";
    HEALBOT_LEVITATE                       =1706 --HealBot_WoWAPI_SpellName(1706) or "--Levitate";
    HEALBOT_LIGHTWELL_RENEW                =7001 --HealBot_WoWAPI_SpellName(7001) or "--Lightwell Renew";
    HEALBOT_LIGHT_OF_TUURE                 =208065 --HealBot_WoWAPI_SpellName(208065) or "--Light of T'uure";
    HEALBOT_MIND_QUICKENING                =49868 --HealBot_WoWAPI_SpellName(49868) or "--Mind Quickening"
    HEALBOT_PAIN_SUPPRESSION               =33206 --HealBot_WoWAPI_SpellName(33206) or "--Pain Suppression";
    HEALBOT_PERMEATING_GLOW                =272780 --HealBot_WoWAPI_SpellName(272780) or "--Permeating Glow";
    HEALBOT_POWER_INFUSION                 =10060 --HealBot_WoWAPI_SpellName(10060) or "--Power Infusion";
    HEALBOT_POWER_OF_THE_DARK_SIDE         =198069 --HealBot_WoWAPI_SpellName(198069) or "--Power of the Dark Side";
    HEALBOT_POWER_OF_THE_NAARU             =196490 --HealBot_WoWAPI_SpellName(196490) or "--Power of the Naaru";
    HEALBOT_POWER_WORD_BARRIER             =81782 --HealBot_WoWAPI_SpellName(62618) or "--Power Word: Barrier";
    HEALBOT_POWER_WORD_FORTITUDE           =21562 --HealBot_WoWAPI_SpellName(21562) or "--Power Word: Fortitude";
    HBC_POWER_WORD_FORTITUDE               =1243
    HEALBOT_POWER_WORD_SHIELD              =17 --HealBot_WoWAPI_SpellName(17) or "--Power Word:Shield";
    HBC_PRAYER_OF_SHADOW_PROTECTION        =27683
    HBC_PRAYER_OF_SPIRIT                   =27681
    HEALBOT_RAMMALS_ULTERIOR_MOTIVE        =234711 --HealBot_WoWAPI_SpellName(234711) or "--Rammal's Ulterior Motive";
    HEALBOT_RAPTURE                        =47536 --HealBot_WoWAPI_SpellName(47536) or "--Rapture"; --Disc
    HEALBOT_RAY_OF_HOPE                    =197268 --HealBot_WoWAPI_SpellName(197268) or "--Ray of Hope";
    HEALBOT_REVELATIONS                    =88627 --HealBot_WoWAPI_SpellName(88627) or "--Revelations";
    --HEALBOT_SAVING_GRACE                   =152116 --HealBot_WoWAPI_SpellName(152116) or "--Saving Grace"
    HEALBOT_SAVING_VOID_ENTROPY            =155361 --HealBot_WoWAPI_SpellName(155361) or "--Void Entropy"
    HEALBOT_SERENDIPITY                    =63733 --HealBot_WoWAPI_SpellName(63733) or "--Serendipity";
    HEALBOT_SHADOWFORM                     =232698 --HealBot_WoWAPI_SpellName(232698) or "--Shadowform"
    HBC_SHADOWGUARD                        =18137
    HEALBOT_SHADOW_COVENANT                =204065 --HealBot_WoWAPI_SpellName(204065) or "--Shadow Covenant";
    HBC_SHADOW_PROTECTION                  =976
    HEALBOT_SHADOW_PROTECTION              =27683
    HEALBOT_SHADOW_WORD_INSANITY           =132573 --HealBot_WoWAPI_SpellName(132573) or "--Shadow Word: Insanity";
    HEALBOT_SHINING_FORCE                  =204263 --HealBot_WoWAPI_SpellName(204263) or "--Shining Force";
    HEALBOT_SPIRIT_SHELL                   =109964 --HealBot_WoWAPI_SpellName(109964) or "--Spirit Shell";
    HEALBOT_SUNDERING_SOUL                 =212570 --HealBot_WoWAPI_SpellName(212570) or "--Sundering Soul";
    HEALBOT_SURGE_OF_DARKNESS              =162448 --HealBot_WoWAPI_SpellName(162448) or "--Surge of Darkness";
    HEALBOT_SURGE_OF_LIGHT                 =114255 --HealBot_WoWAPI_SpellName(114255) or "--Surge of Light";
    HEALBOT_SYMBOL_OF_HOPE                 =64901 --HealBot_WoWAPI_SpellName(64901) or "--Symbol of Hope";    
    HBC_TOUCH_OF_WEAKNESS                  =2652
    HEALBOT_TWIST_OF_FATE                  =265258 --HealBot_WoWAPI_SpellName(109142) or "--Twist of Fate";
--    HEALBOT_TRIAL_OF_LIGHT                 =200128 --HealBot_WoWAPI_SpellName(200128) or "--Trial of light";
    HEALBOT_VAMPIRIC_EMBRACE               =15286 --HealBot_WoWAPI_SpellName(15286) or "--Vampiric Embrace";
    HEALBOT_VESTMANTS_OF_DISCIPLINE        =197711 --HealBot_WoWAPI_SpellName(197711) or "--Vestments of Discipline";
    HEALBOT_WORD_OF_MENDING                =155362 --HealBot_WoWAPI_SpellName(155362) or "--Word of Mending";

    --Shaman
    HEALBOT_ANACESTRAL_GUIDANCE            =108281 --HealBot_WoWAPI_SpellName(108281) or "--Ancestral Guidance";
    HEALBOT_ANACESTRAL_SWIFTNESS           =16188 --HealBot_WoWAPI_SpellName(16188) or "--Ancestral Swiftness";
    HEALBOT_ASCENDANCE                     =114049 --HealBot_WoWAPI_SpellName(114049) or "--Ascendance";
    HEALBOT_ASTRAL_SHIFT                   =108271 --HealBot_WoWAPI_SpellName(108271) or "--Astral Shift";
    HEALBOT_BLOODLUST                      =2825
    HEALBOT_HEROISM                        =32182
    HEALBOT_CLOUDBURST_TOTEM               =157153 --HealBot_WoWAPI_SpellName(157153) or "--Cloudburst Totem";
    HEALBOT_EARTH_SHIELD                   =204288 --HealBot_WoWAPI_SpellName(204288) or "--Earth Shield";
    HEALBOT_ELEMENTAL_FUSION               =152257 --HealBot_WoWAPI_SpellName(152257) or "--Elemental Fusion";
    HEALBOT_ELEMENTAL_MASTERY              =260734 --HealBot_WoWAPI_SpellName(16166) or "--Elemental Mastery";
    HEALBOT_EMPOWER                        =118350 --HealBot_WoWAPI_SpellName(118350) or "--Empower";
    HEALBOT_FLAMETONGUE                    =193796 --HealBot_WoWAPI_SpellName(193796) or "--Flametongue";
    HEALBOT_FROSTBRAND                     =196834 --HealBot_WoWAPI_SpellName(196834) or "--Frostbrand";
    HEALBOT_GENESIS                        =145518 --HealBot_WoWAPI_SpellName(145518) or "--Genesis";
    HEALBOT_GRACE_OF_AIR                   =116956 --HealBot_WoWAPI_SpellName(116956) or "--Grace of Air";
    HEALBOT_HIGH_TIDE                      =157154 --HealBot_WoWAPI_SpellName(157154) or "--High Tide";
    HEALBOT_LIGHTNING_SHIELD               =192106 --HealBot_WoWAPI_SpellName(192106) or "--Lightning Shield";
    HBC_LIGHTNING_SHIELD                   =324
    HBC_EARTH_SHIELD                       =974
    HBC_ROCKBITER_WEAPON                   =8017
    HBC_FLAMETONGUE_WEAPON                 =8024
    HBC_WINDFURY_WEAPON                    =8232
    HBC_EARTHLIVING_WEAPON                 =51730
    HBC_WATER_SHIELD                       =24398
    HEALBOT_EARTHLIVING_WEAPON             =382021
    HEALBOT_SHAMANISTIC_RAGE               =30823 --HealBot_WoWAPI_SpellName(30823) or "--Shamanistic Rage";
    HEALBOT_SKYFURY                        =462854
    HEALBOT_SPIRITWALKERS_GRACE            =79206 --HealBot_WoWAPI_SpellName(79206) or "--Spiritwalker's Grace";
    HEALBOT_SPIRIT_LINK_TOTEM              =98008 --HealBot_WoWAPI_SpellName(98008) or "--Spirit Link Totem";
    HEALBOT_STORM_ELEMENTAL_TOTEM          =152256 --HealBot_WoWAPI_SpellName(152256) or "--Storm Elemenal Totem";
    HEALBOT_TIDAL_WAVES                    =51564 --HealBot_WoWAPI_SpellName(51564) or "--Tidal Waves";
    HEALBOT_UNLEASH_ELEMENTS               =73680 --HealBot_WoWAPI_SpellName(73680) or "--Unleash Elements";
    HEALBOT_UNLEASH_FLAME                  =165462 --HealBot_WoWAPI_SpellName(165462) or "--Unleash Flame";
    HEALBOT_UNLEASH_LIFE                   =73685 --HealBot_WoWAPI_SpellName(73685) or "--Unleash Life";
    HEALBOT_UNLEASHED_FURY                 =117012 --HealBot_WoWAPI_SpellName(117012) or "--Unleashed Fury";
    HEALBOT_WATER_SHIELD                   =52127 --HealBot_WoWAPI_SpellName(52127) or "--Water Shield";
    HEALBOT_WATER_WALKING                  =546 --HealBot_WoWAPI_SpellName(546) or "--Water Walking";
    HEALBOT_WATER_BREATHING                =131 --HealBot_WoWAPI_SpellName(131) or "--Water Breathing";
    HEALBOT_SPIRIT_OF_THE_ALPHA            =408696
    
    --Monk
    HEALBOT_BREATH_OF_THE_SERPENT          =157535 --HealBot_WoWAPI_SpellName(157535) or "--Breath of the Serpent"
    HEALBOT_CHI_EXPLOSION                  =157676 --HealBot_WoWAPI_SpellName(157676) or "--Chi Explosion"
    HEALBOT_CHI_TOROEDO                    =115008 --HealBot_WoWAPI_SpellName(115008) or "--Chi Torpedo"
    HEALBOT_DAMPEN_HARM                    =122278 --HealBot_WoWAPI_SpellName(122278) or "--Dampen Harm"
    HEALBOT_DETONATE_CHI                   =115460 --HealBot_WoWAPI_SpellName(115460) or "--Detonate Chi"
    HEALBOT_DIFFUSE_MAGIC                  =122783 --HealBot_WoWAPI_SpellName(122783) or "--Diffuse Magic"
    HEALBOT_ELUSIVE_BREW                   =115308 --HealBot_WoWAPI_SpellName(115308) or "--Elusive Brew"
    HEALBOT_FORTIFYING_BREW                =115203 --HealBot_WoWAPI_SpellName(115203) or "--Fortifying Brew"
    HEALBOT_GUARD                          =115295 --HealBot_WoWAPI_SpellName(115295) or "--Guard"
    HEALBOT_LEGACY_EMPEROR                 =115921 --HealBot_WoWAPI_SpellName(115921) or "--Legacy of the Emperor"
    HEALBOT_LEGACY_WHITETIGER              =116781 --HealBot_WoWAPI_SpellName(116781) or "--Legacy of the White Tiger"
    HEALBOT_LIFE_COCOON                    =116849 --HealBot_WoWAPI_SpellName(116849) or "--Life Cocoon"
    HEALBOT_MANA_TEA                       =115867 --HealBot_WoWAPI_SpellName(115867) or "--Mana Tea"
    HEALBOT_RUSHING_JADE_WIND              =116847 --HealBot_WoWAPI_SpellName(116847) or "--Rushing Jade Wind"
    HEALBOT_SERENITY                       =152173 --HealBot_WoWAPI_SpellName(152173) or "--Serenity"
    HEALBOT_SERPENT_ZEAL                   =127722 --HealBot_WoWAPI_SpellName(127722) or "--Serpent's Zeal"
    HEALBOT_STANCE_MONK_TIGER              =103985 --HealBot_WoWAPI_SpellName(103985) or "--Stance of the Fierce Tiger"
    HEALBOT_STANCE_MONK_CRANE              =154436 --HealBot_WoWAPI_SpellName(154436) or "--Stance of the Spirited Crane"
    HEALBOT_STANCE_MONK_OX                 =115069 --HealBot_WoWAPI_SpellName(115069) or "--Stance of the Sturdy Ox"
    HEALBOT_STANCE_MONK_SERPENT            =115070 --HealBot_WoWAPI_SpellName(115070) or "--Stance of the Wise Serpent"
    HEALBOT_THUNDER_FOCUS_TEA              =116680 --HealBot_WoWAPI_SpellName(116680) or "--Thunder Focus Tea"
    HEALBOT_WINDFLURRY                     =166916 --HealBot_WoWAPI_SpellName(166916) or "--Windflurry"
    HEALBOT_EXTEND_LIFE                    =185158 --HealBot_WoWAPI_SpellName(185158) or "--Extend Life"
    HEALBOT_ESSENCE_FONT                   =191840 --HealBot_WoWAPI_SpellName(191837) or "--Essence Font"
    HEALBOT_TOUCH_OF_KARMA                 =125174 --HealBot_WoWAPI_SpellName(122470) or "--Touch of Karma"
    
    --Warlock
    HEALBOT_BLOOD_PACT                     =166928 --HealBot_WoWAPI_SpellName(166928) or "--Blood Pact";
    --HEALBOT_DARK_BARGAIN                   =110913 --HealBot_WoWAPI_SpellName(110913) or "--Dark Bargain"
    HEALBOT_DARK_INTENT                    =109773 --HealBot_WoWAPI_SpellName(109773) or "--Dark Intent";
    HEALBOT_DEMON_ARMOR                    =687 --HealBot_WoWAPI_SpellName(687) or "--Demon Armor";
    HBC_DEMON_ARMOR                        =706
    HEALBOT_FEL_ARMOR                      =28176 --HealBot_WoWAPI_SpellName(28176) or "--Fel Armor";
    HEALBOT_LIFE_TAP                       =1454 --HealBot_WoWAPI_SpellName(1454) or "--Life Tap";
    HEALBOT_SOUL_LINK                      =19028 --HealBot_WoWAPI_SpellName(19028) or "--Soul Link";
    HEALBOT_UNENDING_BREATH                =5697 --HealBot_WoWAPI_SpellName(5697) or "--Unending Breath"
    HEALBOT_UNENDING_RESOLVE               =104773 --HealBot_WoWAPI_SpellName(104773) or "--Unending Resolve"
    HEALBOT_SOUL_LEECH                     =108366 --HealBot_WoWAPI_SpellName(108370) or "--Soul Leech"
    HBC_PHASE_SHIFT                        =4511 --HealBot_WoWAPI_SpellName(4511) or "Phase Shift"
    HBC_DETECT_LESSER_INVISIBILITY         =132
    HBC_DETECT_INVISIBILITY                =2970
    HBC_DETECT_GREATER_INVISIBILITY        =11743
    HBC_FEL_INTELLIGENCE                   =57567
    --Warrior
    HEALBOT_BATTLE_SHOUT                   =6673 --HealBot_WoWAPI_SpellName(6673) or "--Battle Shout";
    HEALBOT_COMMANDING_SHOUT               =469 --HealBot_WoWAPI_SpellName(469) or "--Commanding Shout";
    HEALBOT_ENRAGED_REGEN                  =55694 --HealBot_WoWAPI_SpellName(55694) or "--Enraged Regeneration";
    HEALBOT_INSPIRING_PRESENCE             =167188 --HealBot_WoWAPI_SpellName(167188) or "--Inspiring Presence"
    HEALBOT_INTERVENE                      =3411 --HealBot_WoWAPI_SpellName(3411) or "--Intervene";
    HEALBOT_LAST_STAND                     =12975 --HealBot_WoWAPI_SpellName(12975) or "--Last Stand";
    HEALBOT_SAFEGUARD                      =114029 --HealBot_WoWAPI_SpellName(114029) or "--Safeguard"
    --HEALBOT_SHIELD_BARRIER                 =112048 --HealBot_WoWAPI_SpellName(112048) or "--Shield Barrier"
    HEALBOT_SHIELD_BLOCK                   =132404 --HealBot_WoWAPI_SpellName(2565) or "--Shield Block";
    HEALBOT_SHIELD_WALL                    =871 --HealBot_WoWAPI_SpellName(871) or "--Shield Wall";
    HEALBOT_VIGILANCE                      =114030 --HealBot_WoWAPI_SpellName(114030) or "--Vigilance";
    
    --Rogue
    HEALBOT_CLOAK_OF_SHADOWS               =31224 --HealBot_WoWAPI_SpellName(31224) or "--Cloak of Shadows"
    HEALBOT_EVASION                        =5277 --HealBot_WoWAPI_SpellName(5277) or "--Evasion";
    HEALBOT_FEINT                          =1966 --HealBot_WoWAPI_SpellName(1966) or "--Feint"
    HEALBOT_SWIFTBLADES_CUNNING            =113742 --HealBot_WoWAPI_SpellName(113742) or "--Swiftblade's Cunning";
    HEALBOT_VANISH                         =11327 --HealBot_WoWAPI_SpellName(1856) or "--Vanish";
    HEALBOT_DEADLY_POISON                  =2823
    HEALBOT_CRIPPLING_POISON               =3408
    HEALBOT_WOUND_POISON                   =8679
    HEALBOT_INSTANT_POISON                 =315584
    
    
    --Resurrection Spells
    HEALBOT_ANCESTRALSPIRIT                =2008 --HealBot_WoWAPI_SpellName(2008) or "--Ancestral Spirit";
    HEALBOT_DEBUFF_MASS_RESURRECTED        =95223 --HealBot_WoWAPI_SpellName(95223) or "--Recently Mass Resurrected";
    
    HEALBOT_ABSOLUTION                     =212056 --HealBot_WoWAPI_SpellName(212056) or "--Absolution";
    HBC_ABSOLUTION                         =450761
    HEALBOT_ANCESTRAL_VISION               =212048 --HealBot_WoWAPI_SpellName(212048) or "--Ancestral Vision";
    HBC_ANCESTRAL_VISION                   =450762
    HEALBOT_MASS_RESURRECTION              =212036 --HealBot_WoWAPI_SpellName(212036) or "--Mass Resurrection";
    HBC_MASS_RESURRECTION                  =83968
    HEALBOT_REAWAKEN                       =212051 --HealBot_WoWAPI_SpellName(212051) or "--Reawaken";
    HEALBOT_REVITALIZE                     =212040 --HealBot_WoWAPI_SpellName(212040) or "--Revitalize";
    HBC_REVITALIZE                         =48544
    HEALBOT_MASS_RETURN                    =361178
    
    HEALBOT_REDEMPTION                     =7328 --HealBot_WoWAPI_SpellName(7328) or "--Redemption";
    HEALBOT_REBIRTH                        =20484 --HealBot_WoWAPI_SpellName(20484) or "--Rebirth";
    HEALBOT_RESURRECTION                   =2006 --HealBot_WoWAPI_SpellName(2006) or "--Resurrection";
    HEALBOT_RESUSCITATE                    =115178 --HealBot_WoWAPI_SpellName(115178) or "--Resuscitate"
    HEALBOT_REVIVE                         =50769 --HealBot_WoWAPI_SpellName(50769) or "--Revive";
    HBC_REVIVE                             =437138
    HEALBOT_INTERCESSION                   =391054
    HEALBOT_RETURN                         =361227
    
    --Cure Spells
    HEALBOT_BODY_AND_SOUL                  =HealBot_WoWAPI_SpellName(64127) or "--BODY_AND_SOUL"
    HEALBOT_CLEANSE                        =HealBot_WoWAPI_SpellName(4987) or "--CLEANSE"
    HEALBOT_CLEANSE_SPIRIT                 =HealBot_WoWAPI_SpellName(51886) or "--CLEANSE_SPIRIT"
    HEALBOT_CLEANSE_TOXIN                  =HealBot_WoWAPI_SpellName(213644) or "--CLEANSE_TOXIN"
    HBC_SHAMAN_CURE_DISEASE                =HealBot_WoWAPI_SpellName(2870) or "--CURE_DISEASE"
    HBC_PRIEST_CURE_DISEASE                =HealBot_WoWAPI_SpellName(528) or "--CURE_DISEASE"
    HEALBOT_DISPELL_MAGIC                  =HealBot_WoWAPI_SpellName(528) or "--DISPELL_MAGIC"
    HBC_PRIEST_ABOLISH_DISEASE             =HealBot_WoWAPI_SpellName(552) or "--ABOLISH_DISEASE"
    HBC_DISPELL_MAGIC                      =HealBot_WoWAPI_SpellName(527) or "--DISPELL_MAGIC"
    HBC_SHAMAN_CURE_POISON                 =HealBot_WoWAPI_SpellName(526) or "--SHAMAN_CURE_POISON"
    HBC_DRUID_REMOVE_CURSE                 =HealBot_WoWAPI_SpellName(2782) or "--DRUID_REMOVE_CURSE" -- Cata+ is now named Remove Corruption
    HBC_DRUID_CURE_POISON                  =HealBot_WoWAPI_SpellName(8946) or "--DRUID_CURE_POISON"
    HBC_DRUID_ABOLISH_POISON               =HealBot_WoWAPI_SpellName(2893) or "--DRUID_ABOLISH_POISON"
    HEALBOT_DETOX                          =HealBot_WoWAPI_SpellName(115450) or "--DETOX"
    HEALBOT_NATURES_CURE                   =HealBot_WoWAPI_SpellName(88423) or "--NATURES_CURE"
    HEALBOT_IMPROVED_NATURES_CURE          =HealBot_WoWAPI_SpellName(392378) or "--IMPROVED_NATURES_CURE"
    HEALBOT_PURIFY                         =HealBot_WoWAPI_SpellName(527) or "--PURIFY"
    HBC_PURIFY                             =HealBot_WoWAPI_SpellName(1152) or "--PURIFY"
    HEALBOT_PURIFY_SPIRIT                  =HealBot_WoWAPI_SpellName(77130) or "--PURIFY_SPIRIT"
    HEALBOT_PURIFY_DISEASE                 =HealBot_WoWAPI_SpellName(213634) or "--PURIFY_DISEASE"
    HEALBOT_MASS_DISPEL                    =HealBot_WoWAPI_SpellName(32375) or "--MASS_DISPEL"
    HEALBOT_REMOVE_CURSE                   =HealBot_WoWAPI_SpellName(475) or "--REMOVE_CURSE"
    HEALBOT_REMOVE_GREATER_CURSE           =HealBot_WoWAPI_SpellName(412113) or "--REMOVE_GREATER_CURSE"
    HEALBOT_REMOVE_CORRUPTION              =HealBot_WoWAPI_SpellName(2782) or "--REMOVE_CORRUPTION"
    HEALBOT_SACRED_CLEANSING               =HealBot_WoWAPI_SpellName(53551) or "--SACRED_CLEANSING"
    HEALBOT_NATURALIZE                     =HealBot_WoWAPI_SpellName(360823) or "--NATURALIZE"
    HEALBOT_CAUTERIZING_FLAME              =HealBot_WoWAPI_SpellName(374251) or "--CAUTERIZING_FLAME"
    HEALBOT_EXPUNGE                        =HealBot_WoWAPI_SpellName(365585) or "--EXPUNGE"
    HEALBOT_IMPROVEDPURIFY                 =HealBot_WoWAPI_SpellName(390632) or "--IMPROVEDPURIFY"
    HEALBOT_IMPROVEDCLEANSE                =HealBot_WoWAPI_SpellName(393024) or "--IMPROVEDCLEANSE"
    HEALBOT_IMPROVEDPURIFY_SPIRIT          =HealBot_WoWAPI_SpellName(383016) or "--IMPROVEDPURIFY_SPIRIT"
    HEALBOT_IMPROVEDNATURES_CURE           =HealBot_WoWAPI_SpellName(392378) or "--IMPROVEDNATURES_CURE"
    
    --[[END OF SPELL LIST]]--

    --Ignore Class Debuffs (ONLY DISPELLABLE DEBUFFS)
    HEALBOT_DEBUFF_CURSE_OF_IMPOTENCE      =34925 --HealBot_WoWAPI_SpellName(34925) or "--Curse of Impotence";
    HEALBOT_DEBUFF_DECAYED_INTELLECT       =31555 --HealBot_WoWAPI_SpellName(31555) or "--Decayed Intellect";
    HEALBOT_DEBUFF_DECAYED_STRENGHT        =6951 --HealBot_WoWAPI_SpellName(6951) or "--Decayed Strength";
    HEALBOT_DEBUFF_IGNITE_MANA             =19659 --HealBot_WoWAPI_SpellName(19659) or "--Ignite Mana";
    HEALBOT_DEBUFF_SILENCE                 =38913 --HealBot_WoWAPI_SpellName(38913) or "--Silence";
    HEALBOT_DEBUFF_TAINTED_MIND            =16567 --HealBot_WoWAPI_SpellName(16567) or "--Tainted Mind";
    HEALBOT_DEBUFF_TRAMPLE                 =126406 --HealBot_WoWAPI_SpellName(126406) or "--Trample";
    --HEALBOT_DEBUFF_UNSTABLE_AFFLICTION     =35183 --HealBot_WoWAPI_SpellName(35183) or "--Unstable Affliction";
    --HEALBOT_DEBUFF_UNSTABLE_AFFLICTION     =156954 --HealBot_WoWAPI_SpellName(156954) or "--Unstable Affliction";
    HEALBOT_DEBUFF_UNSTABLE_AFFLICTION     =30108 --HealBot_WoWAPI_SpellName(30108) or "--Unstable Affliction";
    HEALBOT_DEBUFF_VIPER_STING             =39413 --HealBot_WoWAPI_SpellName(39413) or "--Viper Sting";   
    HEALBOT_DEBUFF_VAMPIRIC_TOUCH          =34914 --HealBot_WoWAPI_SpellName(34914) or "--Vampiric Touch";    
    --Ignore Movement Debuffs (ONLY DISPELLABLE DEBUFFS)
    HEALBOT_DEBUFF_CHILLED                 =6136 --HealBot_WoWAPI_SpellName(6136) or "--Chilled";
    HEALBOT_DEBUFF_CONEOFCOLD              =64645 --HealBot_WoWAPI_SpellName(64645) or "--Cone of Cold";
    HEALBOT_DEBUFF_EARTHBIND               =3600 --HealBot_WoWAPI_SpellName(3600) or "--Earthbind";
    HEALBOT_DEBUFF_FROST_SHOCK             =41116 --HealBot_WoWAPI_SpellName(41116) or "--Frost Shock";
    HEALBOT_DEBUFF_FROSTBOLT               =69573 --HealBot_WoWAPI_SpellName(69573) or "--Frostbolt";
    HEALBOT_DEBUFF_MAGMA_SHACKLES          =19496 --HealBot_WoWAPI_SpellName(19496) or "--Magma Shackles";
    HEALBOT_DEBUFF_SEAL_OF_JUSTICE         =20170 --HealBot_WoWAPI_SpellName(20170) or "--Seal of Justice";
    HEALBOT_DEBUFF_SLOW                    =32922 --HealBot_WoWAPI_SpellName(32922) or "--Slow";  
    --Ignore Non-Harmful Debuffs (ONLY DISPELLABLE DEBUFFS)
    HEALBOT_DEBUFF_DREAMLESS_SLEEP         =15822 --HealBot_WoWAPI_SpellName(15822) or "--Dreamless Sleep";
    HEALBOT_DEBUFF_GREATER_DREAMLESS       =24360 --HealBot_WoWAPI_SpellName(24360) or "--Greater Dreamless Sleep";
    HEALBOT_DEBUFF_MAJOR_DREAMLESS         =28504 --HealBot_WoWAPI_SpellName(28504) or "--Major Dreamless Sleep";
    HEALBOT_DEBUFF_SHATTERED_DEFENSES      =209574 --HealBot_WoWAPI_SpellName(209574) or "--Shattered Defenses";
    HEALBOT_DEBUFF_OVERWHELMING_POWER      =266180 --HealBot_WoWAPI_SpellName(266180) or "--Overwhelming Power";
    
    --Common Buffs
   -- HEALBOT_ZAMAELS_PRAYER                 =88663 --HealBot_WoWAPI_SpellName(88663) or "--Zamael's Prayer";
    HEALBOT_FLESHCRAFT                     =324631
end
 
HEALBOT_TANK=1
HEALBOT_HEALER=2
HEALBOT_SELF=3
HEALBOT_PRIVATELIST=4
HEALBOT_PRIVATEFOCUS=5
HEALBOT_RAID=6
HEALBOT_GROUP=7
HEALBOT_VEHICLE=8
HEALBOT_PET=9
HEALBOT_TARGET=10
HEALBOT_TOT=11
HEALBOT_TOF=12
HEALBOT_PRIVFOCUSTOT=13
HEALBOT_FOCUS=14
HEALBOT_ENEMY=15
HEALBOT_PLAYERTARGET=16
HEALBOT_PRIVATETARGET=17

HEALBOT_DISEASE_en                     ="Disease";  -- Do NOT localize this value.
HEALBOT_MAGIC_en                       ="Magic";  -- Do NOT localize this value.
HEALBOT_CURSE_en                       ="Curse";  -- Do NOT localize this value.
HEALBOT_POISON_en                      ="Poison";  -- Do NOT localize this value.
HEALBOT_CUSTOM_en                      ="Custom";  -- Do NOT localize this value. 
HEALBOT_BLEED_en                       ="Bleed";  -- Do NOT localize this value.
