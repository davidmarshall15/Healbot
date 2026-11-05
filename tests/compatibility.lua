local passed=0
local function eq(actual, expected, label)
    assert(actual==expected, label..": expected "..tostring(expected)..", got "..tostring(actual))
    passed=passed+1
end

local function loadAddon(file, env)
    local handle=assert(io.open(file,"rb"))
    local source=handle:read("*a")
    handle:close()
    -- WoW accepts UTF-8 BOMs; standalone Lua 5.1 does not.
    source=source:gsub("^\239\187\191", "")
    local chunk=assert(loadstring(source,"@"..file))
    setfenv(chunk, env)()
end

local function client(version, interface)
    local env=setmetatable({}, {__index=_G})
    env.string=setmetatable({split=function(_, value) return value:match("^(%d+)") end}, {__index=string})
    env.GetBuildInfo=function() return version, "69913", "Sep 18 2026", interface end
    loadAddon("HealBot/Locale/HealBot_Global.lua", env)
    return env
end

for _, case in ipairs({
    {"1.60.1",16001,1,12,true},
    {"1.60.2",16002,1,12,true},
    {"1.15.9",11509,1,1,false},
    {"2.5.6",20506,2,2,false},
    {"5.5.4",50504,5,5,false},
    {"12.1.0",120100,12,12,false},
}) do
    local env=client(case[1],case[2])
    eq(env.HEALBOT_GAME_VERSION,case[3],"content "..case[1])
    eq(env.HEALBOT_CLIENT_VERSION,case[4],"API "..case[1])
    eq(env.HEALBOT_FOREVER,case[5],"Forever "..case[1])
    eq(env.HEALBOT_MIDNIGHT,case[4]>11,"secrets "..case[1])
end

local env=client("1.60.1",16001)
env.Enum={SpellBookSpellBank={Player=0,Pet=1},LuaCurveType={Linear=0}}
env.C_SpellBook={
    GetNumSpellBookSkillLines=function() return 1 end,
    GetSpellBookSkillLineInfo=function() return {itemIndexOffset=0,numSpellBookItems=1} end,
    GetSpellBookItemInfo=function(slot,bank)
        eq(slot,1,"spell slot")
        eq(bank,0,"spell bank")
        return {itemType=1,actionID=2061}
    end,
    GetSpellBookItemName=function(slot,bank)
        eq(slot,1,"name slot")
        eq(bank,0,"name bank")
        return "Flash Heal","Rank 1"
    end,
}
env.C_Spell={
    GetSpellName=function() return "Flash Heal" end,
    GetSpellInfo=function(id) return {name="Flash Heal",spellID=id,iconID=1} end,
    IsSpellHelpful=function(id) eq(id,2061,"helpful uses ID") return true end,
    IsSpellHarmful=function(id) eq(id,585,"harmful uses ID") return true end,
}
loadAddon("HealBot/Libs/LibWoWAPI/HealBot_WoWAPI.lua",env)
env.HealBot_WoWAPI_SetC_SpellBook()
env.HealBot_WoWAPI_SetC_Spell()
local name,rank=env.HealBot_WoWAPI_SpellBookItemName(1)
eq(name,"Flash Heal","modern spell name")
eq(rank,"Rank 1","modern spell rank")
local kind,id=env.HealBot_WoWAPI_SpellBookItemInfo(1)
eq(kind,"SPELL","modern spell type")
eq(id,2061,"modern spell ID")
eq(env.HealBot_WoWAPI_HelpfulSpell("Flash Heal",2061),true,"helpful")
eq(env.HealBot_WoWAPI_HarmfulSpell("Smite",585),true,"harmful")
env.HealBot_WoWAPI_SetSpellBookTooltip({SetSpellBookItem=function(_,slot,bank)
    eq(slot,1,"modern tooltip slot")
    eq(bank,0,"modern tooltip bank")
end},1)

-- A sentinel catches accidental arithmetic/comparison on protected numbers.
-- Lua 5.1 cannot emulate WoW's secret-value taint or protected frame rules.
local function forbidden() error("Attempted to inspect a protected value") end
local secret=setmetatable({}, {__add=forbidden,__sub=forbidden,__mul=forbidden,
    __div=forbidden,__lt=forbidden,__le=forbidden,__index=forbidden})
env.UnitHealth=function() return secret end
env.UnitHealthMax=function() return secret end
env.UnitPower=function() return secret end
env.UnitPowerMax=function() return secret end
env.C_CurveUtil={
    CreateCurve=function() return {SetType=function() end,AddPoint=function() end} end,
    CreateColorCurve=function() return {SetType=function() end,AddPoint=function() end,color=true} end,
}
env.CreateColor=function() return {} end
env.UnitHealthPercent=function(_,_,curve)
    if curve and curve.color then return {GetRGB=function() return secret,secret end} end
    return secret
end
env.UnitPowerPercent=function() return secret end
env.HealBot_WoWAPI_SetAll()
local health,maxHealth,pct=env.HealBot_WoWAPI_UnitHealth("party1")
eq(health,secret,"health passthrough")
eq(maxHealth,secret,"max health passthrough")
eq(pct,secret,"health percent passthrough")
local mana,maxMana,manaPct=env.HealBot_WoWAPI_UnitMana("party1",0)
eq(mana,secret,"mana passthrough")
eq(maxMana,secret,"max mana passthrough")
eq(manaPct,secret,"mana percent passthrough")

env.LibStub=function() error("Forever must not use LibHealComm") end
loadAddon("HealBot/Libs/LibHealComm-4.0/LibHealComm-4.0.lua",env)
loadAddon("HealBot/Libs/HealBot_Libs.lua",env)
eq(env.HealBot_Libs_CHC(),nil,"no legacy heal prediction")

local classic=client("2.5.6",20506)
classic.BOOKTYPE_SPELL="spell"
classic.GetSpellBookItemName=function(slot,bank)
    eq(slot,1,"legacy slot")
    eq(bank,"spell","legacy bank")
    return "Lesser Heal","Rank 2"
end
classic.IsHelpfulSpell=function(spell) eq(spell,"Lesser Heal","legacy spell name") return true end
loadAddon("HealBot/Libs/LibWoWAPI/HealBot_WoWAPI.lua",classic)
classic.HealBot_WoWAPI_SetC_SpellBook()
local oldName,oldRank=classic.HealBot_WoWAPI_SpellBookItemName(1)
eq(oldName,"Lesser Heal","legacy name")
eq(oldRank,"Rank 2","legacy rank")
eq(classic.HealBot_WoWAPI_HelpfulSpell("Lesser Heal",2050),true,"legacy helpful")
classic.HealBot_WoWAPI_SetSpellBookTooltip({SetSpellBookItem=function(_,slot,bank)
    eq(slot,1,"legacy tooltip slot")
    eq(bank,"spell","legacy tooltip bank")
end},1)

-- Aura data is rebuilt after learning spells or gaining a level, including
-- in combat. Forever must keep Classic buff data without estimating shields.
for _, case in ipairs({{"1.60.1",16001,0}, {"1.15.9",11509,2}, {"2.5.6",20506,2}, {"5.5.4",50504,0}}) do
    local auraEnv=client(case[1],case[2])
    auraEnv.HealBot_WoWAPI_SpellName=function(id) return "Spell "..tostring(id) end
    auraEnv.HealBot_WoWAPI_SpellInfo=auraEnv.HealBot_WoWAPI_SpellName
    auraEnv.HealBot_globalVars()
    auraEnv.HEALBOT_PALADIN="PALA"
    auraEnv.HEALBOT_CUSTOM_CASTBY_EVERYONE="Everyone"
    auraEnv.HEALBOT_CUSTOM_CASTBY_ENEMY="Enemy"
    auraEnv.HEALBOT_CUSTOM_CASTBY_FRIEND="Friend"
    auraEnv.HEALBOT_OPTIONS_SELFHEALS="Self"
    auraEnv.hbv_GetStatic=function(key) return key end
    auraEnv.hbv_GetClass=function(_,class) return class end
    auraEnv.ceil=math.ceil
    auraEnv.HealBot_Data={PCLASSTRIM="PALA",PLEVEL=25,PGUID="player-guid"}
    auraEnv.HealBot_Config={ClassicAbsorbsFilter=1}
    auraEnv.HealBot_Config_Buffs={}
    local bonus, reads, itemUpdates=14,0,0
    auraEnv.GetSpellBonusHealing=function() reads=reads+1 return bonus end
    auraEnv.HealBot_Timers_Set=function(category,name)
        if category=="LAST" and name=="InitItemsData" then itemUpdates=itemUpdates+1 end
    end
    loadAddon("HealBot/Healbot_Aura.lua",auraEnv)
    auraEnv.HealBot_Aura_InitData()
    if auraEnv.HEALBOT_FOREVER then bonus=secret end
    auraEnv.HealBot_Data.PLEVEL=26
    auraEnv.HealBot_Aura_InitData()
    eq(reads,case[3],"legacy shield bonus reads "..case[1])
    eq(itemUpdates,2,"aura initialization completes after level-up "..case[1])
    if auraEnv.HEALBOT_GAME_VERSION<4 then
        eq(auraEnv.HealBot_Aura_HasBuffTypes("Spell "..auraEnv.HBC_BLESSING_OF_KINGS,{[5]=true}),true,
           "Classic blessing categories retained "..case[1])
    end
end

-- Test the real player-data refresh without bootstrapping the entire UI.
local playerFile=assert(io.open("HealBot/HealBot.lua","rb"))
local playerSource=playerFile:read("*a"):gsub("\r\n","\n")
playerFile:close()
local playerFunction=assert(playerSource:match("(function HealBot_SetPlayerData%(%).-)\nfunction HealBot_ReloadAddon"))
for _, case in ipairs({{"1.60.1",16001,0,0}, {"12.1.0",120100,0,0}, {"1.15.9",11509,8,2}, {"10.2.0",100200,15,2}}) do
    local playerEnv=client(case[1],case[2])
    playerEnv.HealBot_Data={}
    playerEnv.strsub=string.sub
    playerEnv.ceil=math.ceil
    playerEnv.UnitClass=function() return "Paladin","PALADIN" end
    playerEnv.UnitLevel=function() return 26 end
    playerEnv.UnitRace=function() return "Human","Human" end
    playerEnv.UnitIsDeadOrGhost=function() return false end
    playerEnv.UnitPowerType=function() return 0 end
    playerEnv.UnitGUID=function() return "player-guid" end
    playerEnv.UnitName=function() return "Player" end
    playerEnv.UnitFactionGroup=function() return "Alliance" end
    playerEnv.HealBot_Timers_Set=function() end
    playerEnv.HealBot_Comms_PlayerVersion=function() end
    local bonus, reads, debugMessages=15,0,0
    playerEnv.GetSpellBonusHealing=function() reads=reads+1 return bonus end
    playerEnv.HealBot_AddDebug=function() debugMessages=debugMessages+1 end
    local playerChunk=assert(loadstring("local HealBot_luVars={}\n"..playerFunction.."\nreturn HealBot_luVars"))
    local vars=setfenv(playerChunk,playerEnv)()
    playerEnv.HealBot_SetPlayerData()
    if playerEnv.HEALBOT_MIDNIGHT then bonus=secret end
    playerEnv.HealBot_SetPlayerData()
    eq(vars.BonusHealing,case[3],"player bonus calculation "..case[1])
    eq(reads,case[4],"player bonus API reads "..case[1])
    eq(debugMessages,2,"player refresh completes with safe debug text "..case[1])
end

print("PASS: "..passed.." compatibility assertions (mock APIs, not an in-game test)")
