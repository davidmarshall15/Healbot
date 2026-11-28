-- Drive the real Forever (content version 1, modern client 12) entry points.
local noop=function() end
local instanceParty,instanceRaid,homeCount,combat,visible,exists=false,false,0,false,true,true
local friendly,entries={},{}
local secret={}
local e=setmetatable({
    HEALBOT_GAME_VERSION=1, HEALBOT_CLIENT_VERSION=12, HEALBOT_FOREVER=true,
    HEALBOT_CUSTOM_CASTBY_EVERYONE='EVERYONE',HEALBOT_CUSTOM_CASTBY_ENEMY='ENEMY',
    HEALBOT_CUSTOM_CASTBY_FRIEND='FRIEND',HEALBOT_OPTIONS_SELFHEALS='SELF',
    HEALBOT_MAGIC_en='Magic', HEALBOT_CURSE_en='Curse', HEALBOT_POISON_en='Poison',
    HEALBOT_DISEASE_en='Disease', HEALBOT_BLEED_en='Bleed', LE_PARTY_CATEGORY_INSTANCE=2,
    GetNumGroupMembers=function() return homeCount end,
    IsInGroup=function(category) assert(category==2); return instanceParty end,
    IsInRaid=function(category) assert(category==2); return instanceRaid end,
    UnitIsFriend=function(unit,other) return unit=='player' and friendly[other] end,
    HealBot_issecretvalue=function(v) return rawequal(v,secret) end,
    HealBot_Util_isMidnight=function(onlyCombat) return not onlyCombat or combat end,
    UnitIsConnected=function() return true end, UnitExists=function() return exists end,
    UnitIsVisible=function() return visible end, IsMounted=function() return false end,
    InCombatLockdown=function() return combat end,
    HealBot_SafeUnitIsUnit=function(a,b) return a==b end,
    C_UnitAuras={GetAuraDataByIndex=function(_,index) return entries[index] end},
    HealBot_Globals={CustomBuffs={},CustomBuffsShowBarCol={DEFAULT=4},CustomBuffTag={}},
    HealBot_Config_Buffs={BuffWatch=true,BuffWatchWhenGrouped=true,BuffCustomWatchInCombat=true,
        BuffWatchInCombat=false,LongBuffTimer=30},
    HealBot_Config_Cures={DebuffWatch=true,DebuffWatchWhenGrouped=true,DebuffWatchInCombat=true},
    HealBot_Data={PALIVE=true,UILOCK=false}, HealBot_TimeNow=100,
    HealBot_WoWAPI_SpellCooldown=function() return 0,0 end,
    HealBot_Text_TagInUse=function() return false end, HealBot_Action_setLuVars=noop,
    HealBot_Timers_Set=noop, HealBot_ActionIcons_setLuVars=noop, HealBot_retLuVars=noop,
    HealBot_BuffIconSetKey=function(id) return id end, HealBot_Util_Round=function(v) return v end,
    hbv_Auras_SetData=noop,hbv_GetStatic=function() return 10 end,
},{__index=_G})
setfenv(assert(loadfile('HealBot/Healbot_Aura.lua')),e)()
local function makeButton(unit,id)
    e.HealBot_Aura_InitUnitBuffIcons(id)
    return {id=id,unit=unit,special={},status={},text={},level=20,mana={type=0},aura={buff={recheck={},temp={}}},icon={buff={count={0,0,0}}}}
end
local function flags()
    e.HealBot_Data.UILOCK=combat
    e.HealBot_Aura_SetAuraCheckFlags(false,false,false,false,false)
end
local function aura(id,name,exp)
    return {name=name,spellId=id,sourceUnit='player',expirationTime=exp or 0,duration=exp or 0,applications=1,icon=1}
end

local function setAuras(list,locked)
    entries=list
    combat=locked or false
    flags()
end
local function setGroup(party,raid,count)
    instanceParty,instanceRaid,homeCount=party,raid,count or 0
    flags()
end
return e,makeButton,setAuras,aura,secret,setGroup
