local f=assert(io.open(arg[1] or "HealBot/HealBot_Init.lua","rb"))
local source=f:read("*a");f:close()
local baseline=arg[2]=="baseline"
local noop=function() end
local preferred,replacement=5185,5186
local learned=preferred
local defaultRanges={}
local env=setmetatable({
    HEALBOT_GAME_VERSION=1,HEALBOT_CLIENT_VERSION=12,HEALBOT_FOREVER=true,
    HealBot_Data={PCLASSTRIM="DRUI"},HealBot_Config={CurrentSpec=1},HealBot_Globals={},
    HealBot_Spell_IDs={},HealBot_Spell_Names={},
    HEALBOT_HEALING_TOUCH=preferred,HEALBOT_RANK={},
    InCombatLockdown=function() return false end,getn=table.getn,
    HealBot_issecretvalue=function() return false end,
    HealBot_Options_InitBuffSpellsClassList=function() return {} end,
    HealBot_WoWAPI_NumSpellTabs=function() return 1 end,
    HealBot_WoWAPI_SpellTabInfo=function() return nil,nil,0,learned and 1 or 0,nil,0 end,
    HealBot_WoWAPI_SpellBookItemInfo=function() return "SPELL",learned end,
    HealBot_WoWAPI_SpellBookItemName=function() return learned==preferred and "First" or "Second","" end,
    HealBot_WoWAPI_SpellInfo=function() return learned==preferred and "First" or "Second",nil,123,0,0,30 end,
    HealBot_WoWAPI_SpellPowerCost=function() return {{cost=2}} end,
    HealBot_WoWAPI_IsSpellPassive=function() return false end,
    HealBot_Spells_KnownByName=function() return true end,
    HealBot_SetToolTip=noop,HealBot_WoWAPI_SetSpellBookTooltip=noop,
    HealBot_Util_isMidnight=function() return true end,
    HealBot_WoWAPI_HelpfulSpell=function() return true end, GetSpellBaseCooldown=function() return 0 end,
    HealBot_Range_InitSpell=function(k,v) defaultRanges[k]=v end,
},{__index=_G})
env._G=env
for _,prefix in ipairs({"HEALBOT_","HBC_"}) do
    for key in source:gmatch(prefix.."[A-Z_]+") do if env[key]==nil then env[key]=key end end
end
setfenv(assert(loadstring(source)),env)()
env.HealBot_Init_Spells_Defaults()
assert(defaultRanges.HEAL30=="First")
learned=replacement
env.HealBot_Init_Spells_Defaults()
assert(defaultRanges.HEAL30==(baseline and "First" or "Second"))
learned=nil
env.HealBot_Init_Spells_Defaults()
assert(defaultRanges.HEAL30==(baseline and "First" or nil))
print(baseline and "BASELINE: old 30-yard range spell survives replacement and removal" or "PASS: the same-range replacement is selected and an empty book releases its previous fallback")
