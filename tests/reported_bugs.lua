local passed=0
local function eq(a,b,label) assert(a==b,label); passed=passed+1 end
local function read(path)
    local f=assert(io.open(path,"rb"));local s=f:read("*a"):gsub("\r\n","\n");f:close();return s
end
local function extract(env,path,names)
    local s=read(path)
    for _,name in ipairs(names) do
        setfenv(assert(loadstring(assert(s:match("(function "..name.."%b().-\nend)"),name))),env)()
    end
end
local function forbidden() error("inspected secret or changed protected frame") end
local secret=setmetatable({}, {__lt=forbidden,__le=forbidden,__add=forbidden,__sub=forbidden,__tostring=forbidden})
local combat,exists=true,true
local currentName="First"
local powerType=1
local function region()
    return {SetText=function(self,v) self.text=v end,SetValue=function(self,v) self.value=v end}
end
local env=setmetatable({
    HEALBOT_FOREVER=true,
    InCombatLockdown=function() return combat end,
    UnitExists=function() return exists end,
    UnitName=function() return currentName end,
    HealBot_WoWAPI_UnitHealth=function() return secret,secret,secret,secret,secret,secret,secret end,
    HealBot_WoWAPI_UnitMana=function(_,t) eq(t,powerType,"current power type used");return secret,secret,secret,secret end,
    HealBot_Action_setButtonManaBarCol=function(b) b.mana.type=powerType end,
    HealBot_Aux_setPowerBars=function(b) b.renderedPower=b.mana.current end,
    HealBot_Text_DoSetHealthText=function(b) b.gref.txt.text2:SetText(b.health.current) end,
}, {__index=_G})
extract(env,"HealBot/HealBot_ForeverFrames.lua",{"HealBot_Forever_RefreshTarget"})
extract(env,"HealBot/HealBot.lua",{"HealBot_UnitHealth","HealBot_UnitMana"})
local b={unit="target",name="Old",text={},health={},mana={},status={current=99,isdead=true},
    gref={Bar=region(),txt={text=region(),text2=region()}},SetAttribute=forbidden,Show=forbidden,Hide=forbidden}
env.HealBot_Forever_RefreshTarget(b)
eq(b.gref.txt.text.text,"First","new target name replaces old cached name")
eq(b.gref.Bar.value,secret,"protected health renders despite previous dead/reserved state")
eq(b.renderedPower,secret,"protected power forwarded")
currentName="Second";powerType=0
env.HealBot_UnitHealth(b)
eq(b.name,"Second","health events retain fresh target name")
eq(b.mana.type,0,"target power type changes")
env.HealBot_UnitMana(b)
eq(b.gref.Bar.value,secret,"power event does not restore old target health")
currentName=secret;env.HealBot_Forever_RefreshTarget(b)
eq(b.gref.txt.text.text,secret,"protected name is only forwarded")
exists=false;env.HealBot_Forever_RefreshTarget(b)
eq(b.gref.txt.text.text,"","cleared target has no stale name")
eq(b.gref.Bar.value,0,"cleared target has no stale health")
eq(b.renderedPower,0,"cleared target has no stale resource")
exists=true;currentName="Third"
env.HealBot_Forever_RefreshTarget(b)
eq(b.name,"Third","target recovers after clearing")
b.unit="focus";env.HealBot_Forever_RefreshTarget(b)
eq(b.name,"Third","focus also refreshed")
b.unit="party1";currentName="Untouched";env.HealBot_Forever_RefreshTarget(b)
eq(b.name,"Third","party frames retain normal path")
b.unit="target";combat=false;env.HealBot_Forever_RefreshTarget(b)
eq(b.name,"Third","outside combat retains normal path")

-- Missing-buff warnings require a complete scan. A sealed entry or a failed
-- query cannot be treated as an absent aura, even just after combat ends.
local entries,scanError={},false
local a=setmetatable({
    C_UnitAuras={GetAuraDataByIndex=function(_,i) if scanError then error("unavailable") end;return entries[i] end},
    HealBot_issecretvalue=function(v) return rawequal(v,secret) end,
    HealBot_Aura_AuraDataIsUsable=function(v) return v.usable end,
    HealBot_Aura_UpdateUnitBuffsData=function() end,
    HealBot_Util_isMidnight=function() return combat end,
}, {__index=_G})
extract(a,"HealBot/Healbot_Aura.lua",{"HealBot_Aura_UpdateUnitBuffsV9Aura","HealBot_Aura_CheckGeneralBuff","HealBot_Aura_NativeBuffExclusions","HealBot_Aura_RefreshAfterCombat"})
local ab={unit="party1",aura={buff={}}}
entries={secret};a.HealBot_Aura_UpdateUnitBuffsV9Aura(ab,false,"HELPFUL")
eq(ab.aura.buff.scanIncomplete,true,"sealed aura marks incomplete scan")
a.HealBot_Aura_CheckGeneralBuff(ab) -- must return before reading missing buff tables
entries={{usable=false}};a.HealBot_Aura_UpdateUnitBuffsV9Aura(ab,false,"HELPFUL")
eq(ab.aura.buff.scanIncomplete,true,"sealed aura fields mark incomplete scan")
scanError=true;a.HealBot_Aura_UpdateUnitBuffsV9Aura(ab,false,"HELPFUL")
eq(ab.aura.buff.scanIncomplete,true,"API failure is not an empty scan")
scanError=false;entries={{usable=true}};a.HealBot_Aura_UpdateUnitBuffsV9Aura(ab,false,"HELPFUL")
eq(ab.aura.buff.scanIncomplete,false,"next complete scan recovers")
combat=true;a.HealBot_Aura_CheckGeneralBuff(ab)
combat=false;entries={};a.HealBot_Aura_UpdateUnitBuffsV9Aura(ab,false,"HELPFUL")
eq(ab.aura.buff.scanIncomplete,false,"genuinely empty readable scan is complete")
a.HealBot_Globals={IgnoreCustomBuff={[1]={ALL=true},[2]={Dungeon=true},[3]={Elsewhere=true}}}
a.hb_lVars={mapName="Dungeon"}
a.HealBot_AuraBuffCache={[4]={name="XP"}}
a.hbCustomBuffsDisabled={XP={ALL=true}}
local excluded=a.HealBot_Aura_NativeBuffExclusions()
eq(excluded[1],true,"globally ignored buff excluded")
eq(excluded[2],true,"zone-specific exclusion retained")
eq(excluded[3],nil,"another zone does not disable buff")
eq(excluded[4],true,"name-based cache exclusion retained")
local active={status={events=true},aura={buff={},debuff={}},event={}}
local inactive={status={events=false}}
a.HealBot_Buttons={active,inactive}
extract(a,"HealBot/HealBot_Events.lua",{"HealBot_Events_UnitBuff","HealBot_Events_UnitDebuff"})
a.HealBot_Aura_RefreshAfterCombat()
eq(active.aura.buff.update,true,"combat exit invalidates buff scan")
eq(active.aura.debuff.update,true,"combat exit invalidates debuff scan")
eq(active.event.buff,true,"buff refresh scheduled without UNIT_AURA")
eq(active.event.debuff,true,"debuff refresh scheduled without UNIT_AURA")
eq(inactive.aura,nil,"inactive buttons are untouched")

-- SmartCast uses current recipient level, not the previous slot occupant.
local level=60
local s=setmetatable({
    HEALBOT_GAME_VERSION=1,HealBot_Data={PCLASSTRIM="PRIE"},
    HBC_POWER_WORD_FORTITUDE=1,
    HealBot_Action_SmartCast=function() return "Fortitude" end,
    HealBot_Spells_KnownByName=function() return true end,
    HealBot_Spell_Names={Fortitude=1},
    UnitLevel=function() return level end,
    HealBot_issecretvalue=function(v) return rawequal(v,secret) end,
    HealBot_WoWAPI_SpellName=function() return "Fortitude" end,
    HealBot_Init_retRank=function(name,rank) return name..rank end,
}, {__index=_G})
extract(s,"HealBot/HealBot_Action.lua",{"HealBot_Action_UseSmartCast"})
local caster={attrs={},SetAttribute=function(self,k,v) self.attrs[k]=v end}
s.HealBot_Action_UseSmartCast(caster,{unit="party1",level=14})
eq(caster.attrs["spell-heal1"],"Fortitude6","stale level cannot downrank current high-level recipient")
level=14;s.HealBot_Action_UseSmartCast(caster,{unit="party1",level=60})
eq(caster.attrs["spell-heal1"],"Fortitude2","low-level recipient still receives suitable rank")
level=secret;s.HealBot_Action_UseSmartCast(caster,{unit="party1",level=14})
eq(caster.attrs["spell-heal1"],"Fortitude","unknown level does not reuse stale downrank")
print("PASS: "..passed.." reported bug assertions")
