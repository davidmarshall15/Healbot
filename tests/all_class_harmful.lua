-- For every corpus ID, feed an applied harmful AuraData through the real Forever
-- dispatch, policy, priority, icon sort and warning path. An ID in a spell table
-- does not imply it naturally applies a harmful aura or can be dispelled.
local function read(path)
    local f=assert(io.open(path,"rb"))
    local s=f:read("*a"):gsub("\r\n","\n")
    f:close()
    return s
end
local source=read("HealBot/Healbot_Aura.lua")
local options=read("HealBot/HealBot_Options.lua")
local function get(name,s)
    return assert((s or source):match("(function "..name.."%b().-\nend)"),name)
end
local function noop() end
local function yes() return true end
local classes={"WARRIOR","PALADIN","HUNTER","ROGUE","PRIEST","SHAMAN","MAGE","WARLOCK","DRUID"}
local types={"Magic","Poison","Curse","Disease","Bleed"}
local secret={}
local broad,removable,scope,lock,restricted
local paints={}
local e=setmetatable({
    HEALBOT_FOREVER=true,HEALBOT_CLIENT_VERSION=12,HEALBOT_CUSTOM_en="Custom",HEALBOT_BLEED_en="Bleed",
    HEALBOT_CUSTOM_CASTBY_EVERYONE="ALL",HEALBOT_CUSTOM_CAT_CUSTOM_AUTOMATIC="Auto",
    HealBot_issecretvalue=function(v) return rawequal(v,secret) end,
    InCombatLockdown=function() return lock end, C_Secrets={ShouldAurasBeSecret=function() return restricted end},
    C_UnitAuras={GetUnitAuras=function(_,filter) if filter=="HARMFUL" then return broad end return removable end},
    UnitIsFriend=function(_,u) return u=="raid1" or u=="raid2" end,UnitIsEnemy=function() return false end,
    HealBot_SafeUnitIsUnit=function(a,b) return a==b end,IsInGroup=yes,IsInRaid=yes,
    HealBot_Globals={CustomDebuffs={},DebuffIconVisibility={},CDCTag={},CureCustomDefaultCastBy=1,CustomDebuffsShowBarCol={DEFAULT=2,Auto=5}},
    HealBot_Config_Cures={IgnoreCannotDispell=true,HealBot_Custom_Debuffs_All={},HealBotDebuffPriority={}},
    HealBot_Data={},hb_lVars={IgnoreFastDurDebuffsSecs=2,mapName="Zone A"},
    HealBot_DebuffIconSet={},HealBot_DebuffFilter={},BleedList={},HealBot_Aura_IconSet={},HealBot_Aura_ID={},
    HealBot_AuraDebuffCache={},HealBot_Aura_CanDispel={},HealBot_UnitDebuffCurrent={},HealBot_UnitDebuffTagsCurrent={},
    HealBot_DebuffTagNames={},HealBot_Aura_DebuffUpdate_Plugins=noop,HealBot_Aura_prevIconCount={DEBUFF={}},
    HealBot_UnusedSelfDebuffs={},HealBot_UnusedDebuffs={},hbDebuffOnCD={},hbCustomDebuffsDisabled={},
    hbCustomDebuffPrio={},HealBot_DebuffSpell={},castByListIndexed={ALL=1},hbCustomDebuffsCastBy={},
    HealBot_TimeNow=100,uaDebuffData={{},{}},HealBot_Unit_Status={DEAD=5},debuffCheck=true,
    HealBot_AuraDebuffXRef={},debuffSort={{},{},{}},HealBot_UnitDebuffIcons={{},{}},
    hbv_Skins_GetIconVar=function() return 2 end,
    HealBot_Aura_CacheDebuffIcon=function(button,index,id,slot) paints[index]=id end,
    HealBot_Aura_CheckUnitDebuffIcons=noop,HealBot_Aura_DebuffWarnings=noop,
    HealBot_Aura_CheckUnitBuffOverDebuff=noop,HealBot_Panel_RaidPetUnitButtonCheck=yes,
    HealBot_Aura_ClearDebuff=function(b) b.aura.debuff.id=0; b.aura.debuff.dispellable=false end,
    HealBot_WoWAPI_SpellName=function() return nil end,
    HealBot_Aura_UnusedAuraInfo=function() return "enemy" end,
    HealBot_Util_Round=function(x) return x end,
    HealBot_Options_retDebuffWatchTarget=function(t) return scope end
},{__index=_G})
local code={}
for _,name in ipairs({"AuraDataIsUsable","PostUpdateInitDebuffsCache","PostUpdateUnitDebuffsData","FilterUnitDebuffs","UpdateUnitDebuffsData",
    "CheckCurCustomDebuff","CheckCurDebuff","CustomDebuffDisabled","CheckUnitDebuff","setDebuffXRefUID","GetDebuffIconPreference",
    "CustomDebuffSetting","SortDebuffIconSet","SortDebuffIcons","UpdateUnitDebuffsV9","CheckUnitDebuffs","AutoUpdateCustomDebuff"}) do
    code[#code+1]=get("HealBot_Aura_"..name)
end
code[#code+1]=get("HealBot_Options_retDebuffPriority",options)
code[#code+1]=assert(source:match("(do\n    local function public%(value%).-\nend)\n\nfunction HealBot_Aura_CheckCurDebuff"))
code[#code+1]=assert(source:match("(do\n    local function readable%(aura%).-\nend)\n\nfunction HealBot_Aura_UpdateUnitDebuffsV9"))
e.ForeverHarmfulBleeds=assert(loadstring("return "..assert(source:match("local ForeverHarmfulBleeds=HEALBOT_FOREVER and (%b{})"))))()
setfenv(assert(loadstring(table.concat(code,"\n"))),e)()
e.HealBot_Aura_UpdateUnitDebuffs=e.HealBot_Aura_UpdateUnitDebuffsV9
local function button(i)
    return {id=i,unit="raid"..i,frame=1,text={},special={},status={current=1},icon={debuff={count={0,0,0}}},aura={debuff={temp={}}}}
end
local a,b=button(1),button(2)
local function run(unit,items,filter)
    broad,removable=items,filter
    unit.aura.debuff.update=true
    paints={}
    e.HealBot_Aura_CheckUnitDebuffs(unit,false)
    return unit.aura.debuff
end
local app={name="Fixture",duration=9,expirationTime=110,applications=1,icon=10,sourceUnit="boss1",auraInstanceID=121,isHarmful=true}
local listed={app}
local empty={}
local applications=0
local ids={}
for line in io.lines("tests/harmful_ids.txt") do ids[#ids+1]=assert(tonumber(line)) end
for c,class in ipairs(classes) do
    local classKey=class:sub(1,4)
    a.text.classtrim=classKey
    b.text.classtrim=classes[c%#classes+1]:sub(1,4)
    lock=(c%2==0)
    scope={[classKey]=true}
    for n,id in ipairs(ids) do
        local t=types[(n+c-2)%#types+1]
        e.HealBot_DebuffSpell[t]=true
        e.HealBot_Config_Cures.HealBotDebuffPriority[t]=7
        app.spellId,app.dispelName=id,t
        app.isBossAura=false
        local set=(n-1)%3+1
        e.HealBot_AuraDebuffCache[id]=nil
        e.HealBot_DebuffIconSet[id]=set
        e.HealBot_Config_Cures.AlwaysShowBoss=false
        e.HealBot_Globals.CustomDebuffs[id]=nil
        e.hbCustomDebuffPrio[id]=nil
        restricted=true
        local ignored=run(a,listed,empty)
        assert(ignored.id==0,"unremovable aura painted as removable")
        restricted=false
        local visible=run(a,listed,listed)
        assert(visible.id==id and visible.dispellable and visible.type==t and visible.priority==7 and visible.colbar==1)
        local index=({51,57,59})[set]
        assert(paints[index]==id,"lost type-tracked artwork")
        assert(run(b,listed,listed).id==0,"matching spell bypassed target scope")
        e.HealBot_Config_Cures.AlwaysShowBoss=true
        app.isBossAura=true
        local boss=run(a,listed,empty)
        assert(boss.id==id and boss.type=="Custom" and boss.priority==15 and boss.colbar==4 and not boss.dispellable)
        e.HealBot_Globals.CustomDebuffs[id]=3
        e.hbCustomDebuffPrio[id]=3
        e.HealBot_Globals.CustomDebuffsShowBarCol[id]=3
        e.HealBot_AuraDebuffCache[id].reset=true
        restricted=true
        local custom=run(b,listed,empty)
        assert(custom.id==id and custom.type=="Custom" and custom.priority==3 and custom.colbar==2 and not custom.dispellable)
        assert(paints[index]==id,"lost custom artwork")
        e.HealBot_Globals.CustomDebuffs[id]=nil
        e.hbCustomDebuffPrio[id]=nil
        e.HealBot_Globals.CustomDebuffsShowBarCol[id]=nil
        applications=applications+5
    end
end
-- Same spell/caster but different public instances, both in HARMFUL. Only one
-- is in the dispellable filter. They must keep separate priority, type and tint.
local id=12345
a.text.classtrim="PRIE";scope={PRIE=true};restricted=false
app.spellId=id;app.dispelName="Magic";app.isBossAura=true
e.HealBot_DebuffSpell.Magic=true;e.HealBot_Config_Cures.HealBotDebuffPriority.Magic=7
e.HealBot_Globals.CustomDebuffs[id]=nil;e.hbCustomDebuffPrio[id]=nil;e.HealBot_AuraDebuffCache[id]=nil
local second={}
for k,v in pairs(app) do second[k]=v end
second.auraInstanceID=122
local state=run(a,{app,second},{app})
assert(state.id==id and state.dispellable and state.type=="Magic" and state.priority==7 and state.colbar==1)
assert(e.uaDebuffData[1][2].priority==15 and e.uaDebuffData[1][2].warningType=="Custom")
state=run(a,{second,app},{app})
assert(state.id==id and state.dispellable and state.type=="Magic" and state.priority==7 and state.colbar==1)
-- Ambiguous public instance handles must not transfer removability to a
-- different-timer application just because spell and caster match.
app.auraInstanceID=secret;second.auraInstanceID=secret;second.expirationTime=212
state=run(a,{second,app},{app})
assert(state.id==id and state.dispellable and e.uaDebuffData[1][1].priority==15
    and e.uaDebuffData[1][2].priority==7 and e.uaDebuffData[1][2].expirationTime==110)
app.auraInstanceID=121
-- Exercise the actual, registered bleed table against applied untyped data.
local bleeds=0
for line in io.lines("tests/forever_bleed_ids.txt") do
    local k=assert(tonumber(line));bleeds=bleeds+1
    app.spellId=k;app.dispelName=nil;app.isBossAura=false
    e.HealBot_AuraDebuffCache[k]=nil;e.hbCustomDebuffPrio[k]=nil;e.HealBot_Globals.CustomDebuffs[k]=nil
    e.HealBot_Config_Cures.HealBot_Custom_Debuffs_All.Bleed=true
    assert(run(a,listed,empty).id==k and e.uaDebuffData[1][1].debuffType=="Bleed")
    app.dispelName="Magic"
    assert(run(a,listed,listed).type=="Magic","metadata displaced a real client's dispel type")
end
assert(bleeds==145)
app.spellId=2147483646;app.dispelName=nil
assert(run(a,listed,empty).id==0,"unknown effect was classified as Bleed")
e.HealBot_Config_Cures.HealBot_Custom_Debuffs_All.Bleed=nil
-- Same visible names can have independently configured colors and bar modes.
setfenv(assert(loadstring(get("HealBot_Aura_DebuffWarnings").."\n"..get("HealBot_Options_RetDebuffRGB",options))),e)()
e.HealBot_Text_TagInUse=function() return false end
e.HealBot_Emerg_Button={{},{}}
e.HealBot_Options_retDebuffCureSpell=noop
e.HealBot_Range_WarnInRange=function() return false end
e.HealBot_Aura_AuxClearAuraDebuffBars=noop
e.HealBot_RefreshUnit=noop
a.hazard={};a.glow={};a.range={current=0};a.hotbars={}
e.HealBot_Config_Cures.CDCBarColour={}
e.HealBot_Globals.CDCBarColour={[101]={R=0.2,G=0.3,B=0.4},[102]={R=0.9,G=0.7,B=0.6}}
for _,k in ipairs({101,102}) do
    e.HealBot_Globals.CustomDebuffs[k]=2;e.hbCustomDebuffPrio[k]=2
    e.HealBot_AuraDebuffCache[k]=nil
    app.spellId=k;app.name="Shared name";app.isBossAura=false
    local q=run(a,listed,empty)
    assert(q.r==e.HealBot_Globals.CDCBarColour[k].R and q.b==e.HealBot_Globals.CDCBarColour[k].B)
end
e.hb_lVars.customDebuffNameOwners={["Shared name"]=101}
app.spellId=103
e.hbCustomDebuffPrio[103]=2;e.HealBot_Globals.CustomDebuffs[103]=2;e.HealBot_AuraDebuffCache[103]=nil
assert(run(a,listed,empty).r==0.2,"matched name-mode rank lost its configured RGB")

-- Equal priorities with formerly colliding keys 1002+1 and 100+21.
local many={}
for i=1,21 do
    local t={}
    for k,v in pairs(app) do t[k]=v end
    t.spellId=i==1 and 1002 or (i==21 and 100 or 201000+i)
    t.auraInstanceID=i
    e.hbCustomDebuffPrio[t.spellId]=3;e.HealBot_Globals.CustomDebuffs[t.spellId]=3
    e.HealBot_AuraDebuffCache[t.spellId]=nil;e.HealBot_DebuffIconSet[t.spellId]=1
    many[i]=t
end
run(a,many,empty)
assert(e.HealBot_AuraDebuffXRef["x031002:1"].spellID==1002 and e.HealBot_AuraDebuffXRef["x03100:21"].spellID==100)
print(("PASS: %d unique spell IDs, %d class scopes, %d full policy runs; 2 sibling priority/order regressions"):format(#ids,#classes,applications))
