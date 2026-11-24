-- Exercise the heal amount shown beside the spell cost in the bar tooltip,
-- parsed from the client's spell descriptions.
local passed=0
local function eq(actual,expected,label)
    assert(actual==expected,label..": expected '"..tostring(expected).."', got '"..tostring(actual).."'")
    passed=passed+1
end
local function forbidden() error("attempt to inspect a secret spell description") end
local secret=setmetatable({}, {__lt=forbidden,__le=forbidden,__concat=forbidden,__index=forbidden})
local file=assert(io.open(arg[1] or "HealBot_Tips/HealBot_Tooltip.lua","rb"))
local source=file:read("*a"):gsub("\r\n","\n")
file:close()
local chunk=assert(source:match("(local HealBot_Tooltip_Power=9.-)\nlocal UnitBuffIcons"))

local descriptions={
    [1]="Heal your target for 47 to 58.",
    [2]="Heals the target of 45 damage over 15 sec.",
    [3]="Heals the target for 32 over 12 sec.",
    [4]="Draws on the soul of the party member to shield them, absorbing 44 damage. Lasts 30 sec.",
    [5]="Brings a dead player back to life with 70 health and 135 mana.",
    [6]="Smite an enemy for 13 to 17 Holy damage.",
    [7]="Heals a friendly target for 1,234 to 1,456.",
    [8]="",
    [9]=secret,
    [10]="Launches a volley of holy light at the target, causing 134 Holy damage to an enemy, or 134 healing to an ally instantly and every 1 sec for 2 sec.",
}
local requested
local env=setmetatable({
    HealBot_Data={POWERTYPE=0},
    HealBot_Spell_Names={},
    HealBot_Spell_IDs={},
    HealBot_issecretvalue=function(value) return rawequal(value,secret) end,
    C_Spell={GetSpellDescription=function(id) return descriptions[id] end,
             RequestLoadSpellData=function(id) requested=id end},
}, {__index=_G})
setfenv(assert(loadstring(chunk)),env)()
local amount=env.HealBot_Tooltip_SpellHealAmount

eq(amount(1),"47-58 heal  ","direct heal range")
eq(amount(2),"45 heal  ","heal over time worded as damage")
eq(amount(3),"32 heal  ","heal over time")
eq(amount(4),"44 absorb  ","absorb shield")
eq(amount(5),"","health in a description is not a heal")
eq(amount(6),"","damage spells show no heal amount")
eq(amount(7),"1,234-1,456 heal  ","thousands separators kept")
eq(amount(8),"","empty description shows nothing")
eq(requested,8,"empty description requests the spell data")
eq(amount(9),"","secret description is not inspected")
eq(amount(10),"134 x3 heal  ","Penance bolts, not the 2 sec duration")
eq(amount("Flash Heal"),"","non-numeric spell id is ignored")

env.HealBot_Spell_Names["Lesser Heal"]=1
env.HealBot_Spell_IDs[1]={Mana=30}
eq(env.HealBot_Tooltip_SpellSummary("Lesser Heal","Spell")," -  47-58 heal  30 Mana","summary shows heal before mana")
env.HealBot_Spell_Names["Resurrection"]=5
env.HealBot_Spell_IDs[5]={Mana=120}
eq(env.HealBot_Tooltip_SpellSummary("Resurrection","Spell")," -  120 Mana","summary unchanged without a heal amount")
eq(env.HealBot_Tooltip_SpellSummary("Unknown","Macro")," - Macro","unknown spells keep their type")

print("Heal amount tests passed: "..passed)
