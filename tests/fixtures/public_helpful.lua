-- Start the ordinary Forever helpful-aura scanner with a group and an empty
-- public aura list. Tests can change the list and the combat state separately.
return function(group,scanOnly)
    local function noop() end
    local entries,secret={},{}
    local combat=false
    local e=setmetatable({
        HEALBOT_FOREVER=true,HEALBOT_GAME_VERSION=1,HEALBOT_CLIENT_VERSION=12,
        HEALBOT_CUSTOM_CASTBY_EVERYONE="EVERYONE",HEALBOT_CUSTOM_CASTBY_ENEMY="ENEMY",
        HEALBOT_CUSTOM_CASTBY_FRIEND="FRIEND",HEALBOT_OPTIONS_SELFHEALS="SELF",
        HEALBOT_MAGIC_en="Magic",HEALBOT_CURSE_en="Curse",HEALBOT_POISON_en="Poison",
        HEALBOT_DISEASE_en="Disease",HEALBOT_BLEED_en="Bleed",LE_PARTY_CATEGORY_INSTANCE=2,
        GetNumGroupMembers=function() return group=="raid" and 10 or 5 end,
        IsInGroup=function() return true end,IsInRaid=function() return group=="raid" end,
        UnitIsFriend=function() return true end,UnitExists=function() return true end,
        UnitIsVisible=function() return true end,UnitIsConnected=function() return true end,
        IsMounted=function() return false end,InCombatLockdown=function() return combat end,
        HealBot_issecretvalue=function(v) return rawequal(v,secret) end,
        HealBot_Util_isMidnight=function(onlyCombat) return not onlyCombat or combat end,
        HealBot_SafeUnitIsUnit=function(a,b) return a==b end,
        C_UnitAuras={GetAuraDataByIndex=function(_,i) return entries[i] end},
        HealBot_Globals={CustomBuffs={},CustomBuffsShowBarCol={DEFAULT=4},CustomBuffTag={}},
        HealBot_Config_Buffs={BuffWatch=true,BuffWatchWhenGrouped=true,BuffCustomWatchInCombat=true},
        HealBot_Config_Cures={DebuffWatch=true,DebuffWatchWhenGrouped=true,DebuffWatchInCombat=true},
        HealBot_Data={PALIVE=true,UILOCK=false},HealBot_TimeNow=100,
        HealBot_Text_TagInUse=function() return false end,HealBot_Action_setLuVars=noop,
        HealBot_Timers_Set=noop,HealBot_ActionIcons_setLuVars=noop,HealBot_retLuVars=noop,
        HealBot_BuffIconSetKey=function(id) return id end,HealBot_Util_Round=function(v) return v end,
        hbv_Auras_SetData=noop,hbv_GetStatic=function() return 10 end,
    },{__index=_G})
    setfenv(assert(loadfile("HealBot/Healbot_Aura.lua")),e)()
    if scanOnly then
        e.HealBot_Aura_CheckUnitBuff=noop
        e.HealBot_Aura_CheckUnitBuffIcons=noop
        e.HealBot_Aura_BuffWarnings=noop
        e.HealBot_Aura_ClearBuff=noop
        e.HealBot_Aura_BuffUpdate_Plugins=noop
        e.HealBot_Aura_SortBuffIcons=function() return 0 end
    end
    local function makeButton(unit,id)
        e.HealBot_Aura_InitUnitBuffIcons(id)
        return {id=id,unit=unit,special={},status={},text={},level=20,mana={type=0},
            aura={buff={recheck={},temp={}}},icon={buff={count={0,0,0}}}}
    end
    local function put(list,locked)
        entries=list
        if locked~=nil then
            combat=locked
            e.HealBot_Data.UILOCK=locked
            e.HealBot_Aura_SetAuraCheckFlags(false,false,false,false,false)
        end
    end
    local function aura(id,name,expiration)
        return {name=name,spellId=id,sourceUnit="player",expirationTime=expiration or 0,
            duration=expiration or 0,applications=1,icon=1}
    end
    put({},false)
    return e,makeButton,put,aura,secret
end
