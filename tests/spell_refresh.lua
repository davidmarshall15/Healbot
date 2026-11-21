-- Real spell scanner and timer dispatch, with opaque tooltip text and combat
-- mocked. This cannot reproduce the client's taint propagation.
local passed=0
local function eq(actual,expected,label)
    assert(actual==expected,label)
    passed=passed+1
end
local function read(path)
    local f=assert(io.open(path,"rb"));local s=f:read("*a"):gsub("\r\n","\n");f:close();return s
end
local function load(env,path)
    setfenv(assert(loadstring(read(path),"@"..path)),env)()
end
local function extract(env,path,name)
    setfenv(assert(loadstring(assert(read(path):match("(function "..name.."%b().-\nend)")),name)),env)()
end
local function noop() end
local secret={}
local combat=false
local text,rangeText="Magic", "30 yd range"
local scans,reads,range,debuffUpdates=0,0,nil,0
local improved
local function region(get)
    return {GetObjectType=function() return "FontString" end,GetText=get}
end
local env=setmetatable({
    HEALBOT_FOREVER=true,HEALBOT_GAME_VERSION=1,HEALBOT_CLIENT_VERSION=12,
    HealBot_Data={PCLASSTRIM="PALA",UILOCK=false},HealBot_Config={CurrentSpec=1},
    HealBot_Globals={NoRanks=false},HealBot_Spell_IDs={},HealBot_Spell_Names={},
    HealBot_TimeNow=1,HealBot_setLuVars=noop,
    InCombatLockdown=function() return combat end,
    HealBot_issecretvalue=function(v) return rawequal(v,secret) end,
    HealBot_SetToolTip=noop,HealBot_WoWAPI_SetSpellBookTooltip=function() scans=scans+1 end,
    HealBot_WoWAPI_SpellInfo=function() return "Cleanse",nil,123,0,0,0 end,
    GetSpellBaseCooldown=function() return 0 end,
    HealBot_WoWAPI_SpellPowerCost=function() return {{cost=25}} end,
    HealBot_Util_isMidnight=function() return false end,
    HealBot_Options_setLuVars=function(key,value) improved=value end,
    HealBot_Options_InitDebuffTypes=function() debuffUpdates=debuffUpdates+1 end,
    HEALBOT_CLEANSE="Cleanse",HEALBOT_MAGIC="Magic",
    HealBot_Options_InitBuffSpellsClassList=function() return {} end,
    HealBot_WoWAPI_NumSpellTabs=function() return 1 end,
    HealBot_WoWAPI_SpellTabInfo=function() return nil,nil,0,1,nil,0 end,
    HealBot_WoWAPI_SpellBookItemInfo=function() return "SPELL",4987 end,
    HealBot_WoWAPI_SpellBookItemName=function() return "Cleanse","" end,
    HealBot_WoWAPI_IsSpellPassive=function() return false end,
    HealBot_Spells_KnownByName=function() return true end,
    HealBot_Range_InitSpell=noop,getn=table.getn,gsub=string.gsub,
}, {__index=_G})
env._G=env
for _,prefix in ipairs({"HEALBOT_","HBC_"}) do
    for key in read("HealBot/HealBot_Init.lua"):gmatch(prefix.."[A-Z_]+") do
        if env[key]==nil then env[key]=key end
    end
end
env.HealBot_ScanTooltip={GetRegions=function()
    return region(function() reads=reads+1;return text end),region(function() return "Other line" end)
end}
env.HealBot_ScanTooltipTextRight2=region(function() return rangeText end)
env.HealBot_ScanTooltipTextRight3=region(function() return "40 yd range" end)
load(env,"HealBot/HealBot_Init.lua")
env.HealBot_Init_SetSpellRange=function(_,_,v) range=v end
env.HealBot_Init_ClassicSpellRanks=noop
extract(env,"HealBot/HealBot.lua","HealBot_InitSpells")
for _,name in ipairs({"HealBot_Events_SpellsChanged","HealBot_Events_PlayerLevelSpellChange",
    "HealBot_Events_InvChange","HealBot_Events_EquipmentChange"}) do
    extract(env,"HealBot/HealBot_Events.lua",name)
end
load(env,"HealBot/HealBot_Timers.lua")
local scheduled={}
local deferred=0
local doSet=env.HealBot_Timers_DoSet
env.HealBot_Timers_DoSet=function(cat,name)
    if cat=="OOC" and name=="InitLoadSpells" then deferred=deferred+1 end
    return doSet(cat,name)
end
local setTimer=env.HealBot_Timers_Set
env.HealBot_Timers_Set=function(cat,name,...)
    scheduled[cat..":"..name]=(scheduled[cat..":"..name] or 0)+1
    return setTimer(cat,name,...)
end

-- The reported stack used this exact Magic scan. It must not pass a secret
-- string to string.find, even if a tooltip is still protected outside combat.
text=secret
env.HealBot_Init_FindSpellRangeCast(4987,"Cleanse",1,"")
eq(range,30,"readable tooltip range remains available")
eq(reads,1,"each tooltip line is read only once")
rangeText=secret
env.HealBot_Init_FindSpellRangeCast(4987,"Cleanse",1,"")
eq(range,40,"protected range uses readable fallback line")
text="Removes Magic effects"
env.HealBot_Init_FindSpellRangeCast(4987,"Cleanse",1,"")
eq(improved,true,"readable Magic line still detects improved cleanse")

-- Both events reach InitLoadSpells. Preserve the current spell cache throughout
-- combat, including an INIT callback queued just before entering combat.
local old={name="Existing spell"}
env.HealBot_Spell_IDs[999]=old;env.HealBot_Spell_Names[old.name]=999
combat=true;env.HealBot_Data.UILOCK=true
local before=scans
env.HealBot_Events_EquipmentChange()
env.HealBot_Events_PlayerLevelSpellChange(20)
eq(scheduled["LAST:InitLoadSpells"],2,"both reported events request a refresh")
env.HealBot_Timers_RunTimer("LAST","InitLoadSpells")
eq(scheduled["INIT:InitSpells"],nil,"combat refresh does not start INIT chain")
eq(scheduled["OOC:InitLoadSpells"],1,"refresh deferred until after combat")
env.HealBot_InitSpells()
eq(debuffUpdates,0,"already queued INIT callback skips follow-up work")
env.HealBot_Init_Spells_Defaults()
eq(scans,before,"combat refresh never scans spell tooltips")
eq(env.HealBot_Spell_IDs[999],old,"combat keeps spell ID cache")
eq(env.HealBot_Spell_Names[old.name],999,"combat keeps spell name cache")
eq(deferred,1,"repeated requests enqueue only one out-of-combat refresh")

-- Invoke the registered OOC callback through the real timer dispatch table.
combat=false;env.HealBot_Data.UILOCK=false
env.HealBot_Timers_RunTimer("OOC","InitLoadSpells")
eq(scheduled["INIT:InitSpells"],1,"post-combat refresh resumes normal INIT chain")
eq(scheduled["INIT:SpellsLoaded"],1,"post-combat refresh schedules binding follow-up")
rangeText="30 yd range"
env.HealBot_Timers_RunTimer("INIT","InitSpells")
eq(scans,before+1,"post-combat refresh scans spellbook")
eq(env.HealBot_Spell_IDs[999],nil,"completed rebuild removes stale spells")
eq(env.HealBot_Spell_Names.Cleanse,4987,"completed rebuild publishes known spells")
eq(debuffUpdates,1,"completed rebuild updates dispel configuration")

-- The combat deferral is specific to Forever; legacy clients keep their flow.
env.HEALBOT_FOREVER=false;combat=true
env.HealBot_Timers_InitSpells()
eq(scheduled["INIT:InitSpells"],2,"legacy client still schedules its normal refresh")
eq(deferred,1,"legacy refresh does not use Forever combat deferral")
print("PASS: "..passed.." combat spell refresh assertions (mock APIs)")
