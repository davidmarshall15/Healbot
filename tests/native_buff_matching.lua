-- Real configured-buff builder with real disabled/configured-caster helpers.
-- No AuraContainer or current-aura API is used by these matching checks.
local passed=0
local function eq(actual,expected,label)
    assert(actual==expected,label..": expected "..tostring(expected)..", got "..tostring(actual))
    passed=passed+1
end
local function read(path)
    local f=assert(io.open(path,"rb"));local source=f:read("*a");f:close()
    return source:gsub("\r\n","\n")
end
local function between(source,first,last)
    local start=assert(source:find(first,1,true))
    return source:sub(start,assert(source:find(last,start,true))-1)
end
local aura=read("HealBot/Healbot_Aura.lua")
local source=read("HealBot/HealBot_CombatAuras.lua")
local disabled=between(aura,"local hbCustomBuffsDisabled={}","local scbUnitClassEN")
local configure=between(aura,"local function HealBot_Aura_ConfigClassAllHoT(","local function HealBot_Aura_ConfigBuffIconSetId(")
    ..between(aura,"function HealBot_Aura_ConfigClassHoT()","local function HealBot_Aura_ConfigDebuffIconSetId(")
local policy=between(source,"local knownBuffIDs={}","local function HBCA_Defaults()")
local function fixture()
    local names={[139]="Renew",[6074]="Renew",[6075]="Renew",[774]="Rejuvenation",[1058]="Rejuvenation",
        [19740]="Blessing of Might",[19834]="Blessing of Might",[1310911]="Light's Vigil",[1311590]="Vigil effect",
        [99001]="Custom Mend",[99002]="Custom Mend",[99003]="Unselected buff",[99004]="Ignored buff"}
    local ids={Renew=139,Rejuvenation=774,["Custom Mend"]=99001,["Blessing of Might"]=19740}
    local env=setmetatable({
        HEALBOT_FOREVER=true,class="PRIEST",hb_lVars={mapName="Outside"},
        HealBot_Globals={WatchHoT={PRIE={},PALA={},ALL={}},CustomBuffsIconSet={},CustomBuffIDMethod={},
            IgnoreCustomBuff={},CustomBuffsIconGlow={},CustomBuffsFilter={}},
        HealBot_Watch_HoT={},HealBot_BuffIconSet={},HealBot_BuffIconGlow={},HealBot_BuffFilter={},HealBot_SpellID_LookupData={},
        HealBot_Spell_IDs={},HealBot_AuraBuffCache={},
        HealBot_issecretvalue=function() return false end,
        HealBot_WoWAPI_SpellName=function(id) return type(id)=="string" and id or names[id] end,
        HealBot_WoWAPI_SpellId=function(name) return ids[name] end,
        HealBot_BuffIconSetKey=function(id) return ({[6074]=139,[6075]=139,[1058]=774})[id] or id end,
        HealBot_Timers_Set=function() end,
        HealBot_Aura_ConfigBuffIconSetId=function() end,
        HealBot_Aura_ConfigBuffIconGlowId=function() end,
        HealBot_Aura_ConfigBuffFilter=function() end,
        C_UnitAuras=setmetatable({},{__index=function() error("policy inspected current auras") end}),
    },{__index=_G})
    env.UnitClass=function() return env.class,env.class end
    local build=setfenv(assert(loadstring(disabled..configure..policy.."\nreturn HBCA_ConfiguredBuffFilters")),env)()
    local function refresh()
        env.HealBot_Aura_ConfigClassHoT()
        env.HealBot_Aura_setCustomBuffFilterDisabled()
    end
    return env,function(skipRefresh)
        if not skipRefresh then refresh() end
        return build(env.HealBot_Globals)
    end,names
end
local function contains(filters,id,set,scope)
    local row=filters[set or 1]
    if not row then return false end
    if scope then row=row[scope] end
    return row and row.includeSpellIDs and row.includeSpellIDs[id]==true or false
end

do
    local env,build=fixture();local g=env.HealBot_Globals
    g.WatchHoT.PRIE[139]=1;g.CustomBuffIDMethod[139]=1
    local filters=build()
    eq(contains(filters,139),true,"strict-ID selected rank admitted")
    eq(contains(filters,6074),false,"strict-ID does not enable another rank")
    eq(contains(filters,139,1,"selfSpellFilter"),true,"strict-ID Self partition")
end
do
    local env,build=fixture();local g=env.HealBot_Globals
    g.WatchHoT.PRIE[139]=1;g.WatchHoT.PRIE[6074]=3
    g.CustomBuffIDMethod[139]=1;g.CustomBuffIDMethod[6074]=1;g.IgnoreCustomBuff[139]={ALL=true}
    local filters=build()
    eq(contains(filters,139),false,"strict ignored base hidden")
    eq(contains(filters,6074),true,"independent strict-ID rank not disabled by base")
    eq(contains(filters,6074,1,"everyoneSpellFilter"),true,"independent rank retains caster")
end
do
    local env,build=fixture();local g=env.HealBot_Globals
    g.WatchHoT.ALL[99001]=3;env.HealBot_Spell_IDs[99002]={}
    local filters=build()
    eq(contains(filters,99002,1,"everyoneSpellFilter"),true,"generic spellbook name-family rank admitted")
    eq(contains(filters,99003),false,"unselected spellbook family excluded")
    g.CustomBuffIDMethod[99001]=1
    filters=build()
    eq(contains(filters,99002),false,"generic spellbook candidate obeys strict-ID")
end
do
    local env,build=fixture();local g=env.HealBot_Globals
    g.WatchHoT.ALL["Custom Mend"]=3;env.HealBot_AuraBuffCache[99002]={name="Custom Mend"}
    local filters=build()
    eq(contains(filters,99002),true,"generic public-cache name-family candidate admitted")
    g.IgnoreCustomBuff["Custom Mend"]={Ironforge=true}
    filters=build();eq(contains(filters,99002),true,"zone ignore inactive outside selected zone")
    env.hb_lVars.mapName="Ironforge"
    filters=build();eq(contains(filters,99002),false,"zone ignore removes generic rank")
    env.hb_lVars.mapName="Outside"
    filters=build();eq(contains(filters,99002),true,"generic rank returns outside ignored zone")
end
do
    local env,build=fixture();local g=env.HealBot_Globals
    g.WatchHoT.PRIE[139]=1
    local self,changed=build();eq(changed,true,"first policy marked changed")
    local stable,same=build(true);eq(stable,self,"unchanged policy table reused");eq(same,false,"unchanged policy marked stable")
    g.WatchHoT.PRIE[139]=3
    local everyone,new=build();eq(new,true,"caster-only edit invalidates signature")
    eq(contains(everyone,139,1,"everyoneSpellFilter"),true,"Everyone partition admits selected ID")
    eq(contains(everyone,139,1,"selfSpellFilter"),false,"Everyone ID not duplicated in Self")
    g.WatchHoT.PRIE[139]=2
    local class,classChanged=build();eq(classChanged,true,"My Class has distinct signature")
    eq(contains(class,139,1,"selfSpellFilter"),true,"My Class conservatively retains PLAYER scope")
    eq(contains(class,139,1,"everyoneSpellFilter"),false,"My Class never widened to Everyone")
end
do
    local env,build=fixture();local g=env.HealBot_Globals
    g.WatchHoT.PRIE[139]=1;g.WatchHoT.PRIE[6074]=3;g.CustomBuffIDMethod[6074]=1
    local filters=build()
    eq(env.HealBot_Watch_HoT.Renew,"S","real configured table supplies name-level Self")
    eq(env.HealBot_Watch_HoT[6074],"A","real configured table retains exact Everyone")
    eq(contains(filters,6074,1,"selfSpellFilter"),true,"legacy name-first caster precedence retained")
    eq(contains(filters,6074,1,"everyoneSpellFilter"),false,"ID-first helper cannot override name precedence")
end
do
    local env,build=fixture();local g=env.HealBot_Globals
    g.WatchHoT.PALA[1310911]=3
    local filters=build()
    eq(contains(filters,1311590),true,"configured name mode retains explicit triggered family")
    g.CustomBuffIDMethod[1310911]=1
    filters=build();eq(contains(filters,1311590),false,"triggered family does not bypass strict-ID")
end
do
    local env,build=fixture();local g=env.HealBot_Globals
    g.WatchHoT.PRIE[139]=3;g.CustomBuffsIconSet[139]=2
    local filters=build()
    eq(contains(filters,139,2,"everyoneSpellFilter"),true,"Everyone selection routes to set two")
    eq(contains(filters,6074,2,"everyoneSpellFilter"),true,"name-family rank follows selected icon set")
    eq(contains(filters,139,1),false,"routed spell absent from set one union")
end
do
    local env,build=fixture();local g=env.HealBot_Globals
    g.WatchHoT.PRIE[139]=1
    local first,changed=build();eq(changed,true,"initial Self scope changes policy")
    local stable,unchanged=build(true)
    eq(stable,first,"stable settings reuse the prepared policy")
    eq(unchanged,false,"stable settings do not request a refresh")
    g.WatchHoT.PRIE[139]=3
    local everyone;everyone,changed=build()
    eq(changed,true,"caster-only Everyone change invalidates signature")
    eq(contains(everyone,139,1,"everyoneSpellFilter"),true,"Everyone change moves the selected ID")
    eq(contains(everyone,139,1,"selfSpellFilter"),false,"Everyone change removes the duplicate Self ID")
    g.WatchHoT.PRIE[139]=2
    local myClass;myClass,changed=build()
    eq(changed,true,"My Class change invalidates signature")
    eq(contains(myClass,139,1,"selfSpellFilter"),true,"My Class conservatively retains native Self limitation")
    g.WatchHoT.PRIE[139]=1
    local self;self,changed=build()
    eq(changed,true,"Self versus My Class stays distinct in the signature")
end
do
    local env,build=fixture();local g=env.HealBot_Globals
    env.class="PALADIN";g.CombatAurasPriestOnly=true
    g.WatchHoT.PRIE[139]=3;g.WatchHoT.ALL[99001]=1
    env.HealBot_Spell_IDs[99002]={};g.CustomBuffsIconSet[99001]=3
    g.IgnoreCustomBuff[99004]={ALL=true}
    local filters=build()
    eq(filters[1].includeSpellIDs,nil,"non-priest broad mode remains unrestricted")
    eq(filters[1].selfSpellFilter.includeSpellIDs,nil,"broad Self group stays unrestricted")
    eq(filters[1].selfSpellFilter.excludeSpellIDs[99004],true,"broad mode retains manual exclusion")
    eq(filters[1].selfSpellFilter.excludeSpellIDs[139],true,"broad Self group excludes Everyone ID")
    eq(contains(filters,139,1,"everyoneSpellFilter"),true,"broad mode still permits explicit Everyone")
    eq(filters[1].excludeSpellIDs[99001],true,"routed custom ID removed from broad set-one union")
    eq(filters[1].selfSpellFilter.excludeSpellIDs[99002],true,"routed generic family removed from broad Self group")
    eq(contains(filters,99002,3,"selfSpellFilter"),true,"broad mode honors explicit set-three route")
end
do
    local env,build=fixture();local g=env.HealBot_Globals
    env.class="PALADIN"
    eq(build()[1].includeSpellIDs~=nil,true,"unset priest filter keeps non-priest buffs restricted")
    g.CombatAurasPriestOnly=false
    eq(build()[1].includeSpellIDs~=nil,true,"disabled priest filter keeps non-priest buffs restricted")
    g.CombatAurasPriestOnly=true
    eq(build()[1].includeSpellIDs==nil,true,"enabled priest filter widens non-priest buffs")
end
do
    local env,build=fixture();local g=env.HealBot_Globals
    local filters=build()
    eq(type(filters[1].includeSpellIDs),"table","restricted empty set is explicit")
    eq(next(filters[1].includeSpellIDs),nil,"restricted empty set does not display all buffs")
    eq(next(filters[1].everyoneSpellFilter.includeSpellIDs),nil,"empty Everyone scope rejects all")
    for _,class in ipairs({"WARRIOR","PALADIN","HUNTER","ROGUE","PRIEST","SHAMAN","MAGE","WARLOCK","DRUID"}) do
        env.class=class;g.WatchHoT.ALL[99001]=3;env.HealBot_Spell_IDs[99002]={}
        filters=build()
        eq(contains(filters,99002,1,"everyoneSpellFilter"),true,"generic caster matching covers "..class)
    end
end
do
    local env,build,names=fixture()
    names[1243]="Power Word: Fortitude"
    names[450086]="Prayer of Fortitude"
    local g=env.HealBot_Globals
    g.WatchHoT.ALL[1243]=3
    g.CustomBuffsIconSet[1243]=2
    eq(contains(build(),450086,2,"everyoneSpellFilter"),true,"group Fortitude variant follows configured single-target buff")
    g.CustomBuffIDMethod[1243]=1
    eq(contains(build(),450086,2),false,"strict Fortitude ID excludes group variants")
end
print("PASS: "..passed.." native buff matching assertions (real configuration helpers, public caches only)")
