-- Exercise the real ingest and warning selection used by the Forever roster.
local f=assert(io.open("HealBot/Healbot_Aura.lua","rb"))
local source=f:read("*a"):gsub("\r\n","\n")
f:close()
local function definition(name)
    local body=assert(source:match("(function "..name.."%b().-\nend)"),name)
    return body
end
local e=setmetatable({
    HEALBOT_FOREVER=true,HealBot_UnitDebuffIcons={},uaDebuffData={},HealBot_AuraDebuffCache={},
    HealBot_UnitDebuffCurrent={raid1={}},BleedList={},
    HealBot_issecretvalue=function() return false end,
    HealBot_Util_Round=function(n) return n end,
    HealBot_Aura_FilterUnitDebuffs=function() return true end,
    HealBot_Aura_PostUpdateInitDebuffsCache=function() end,
    HealBot_Aura_PostUpdateUnitDebuffsData=function() end,
    UnitIsEnemy=function() return false end,
    InCombatLockdown=function() return true end,
    HealBot_AuraDebuffXRef={},debuffSort={{},{},{}},
    HealBot_Aura_GetDebuffIconPreference=function() return true end,
},{__index=_G})
local code=table.concat({definition("HealBot_Aura_InitUnitDebuffIcons"),definition("HealBot_Aura_UpdateUnitDebuffsData"),
    definition("HealBot_Aura_SortDebuffIconSet"),definition("HealBot_Aura_SortDebuffIcons")},"\n")
e.ForeverHarmfulBleeds=assert(loadstring("return "..assert(source:match("local ForeverHarmfulBleeds=HEALBOT_FOREVER and (%b{})"))))()
setfenv(assert(loadstring(code)),e)()
local button={id=1,unit="raid1",frame=1,icon={debuff={count={0,0,0}}}}
e.HealBot_Aura_InitUnitDebuffIcons(button.id)
local written={}
e.hbv_Skins_GetIconVar=function(_,_,set) return set==1 and 1 or 0 end
e.HealBot_Aura_CacheDebuffIcon=function(_,index,id) written[index]=id end
local function scan()
    e.uaSlot=0
    for i=1,30 do
        e.uaSpellId,e.uaName,e.uaExpirationTime,e.uaUnitCaster=1000+i,"debuff"..i,99,"player"
        e.HealBot_AuraDebuffCache[1000+i]={priority=10}
        e.HealBot_Aura_UpdateUnitDebuffsData(button,false,i)
    end
end
scan()
assert(e.uaDebuffData[1].lastslot==30 and e.uaDebuffData[1][30].spellId==1030,
    "a high-priority public debuff beyond entry twenty was dropped before sorting")
local old=e.uaDebuffData[1][30]
scan()
assert(e.uaDebuffData[1][30]==old,"rechecking the same unit allocated new overflow records")
e.HealBot_AuraDebuffCache[1030].priority=1
e.debuffSort[1]={"a"}; e.HealBot_AuraDebuffXRef.a={spellID=1001,slot=1}
e.debuffSort[2]={"b"}; e.HealBot_AuraDebuffXRef.b={spellID=1030,slot=30}
assert(e.HealBot_Aura_SortDebuffIcons(button)==30,"an icon-disabled set lost its highest-priority bar warning")
assert(written[51]==1001 and not written[57] and button.icon.debuff.count[2]==0,"icon caps were ignored")
e.HEALBOT_FOREVER=false
e.HealBot_Aura_InitUnitDebuffIcons(1)
scan()
assert(e.uaDebuffData[1].lastslot==20,"other clients changed their ingestion capacity")
print("PASS: 30 readable harmful auras, reused overflow rows, hidden-set warning priority and exact icon caps")
