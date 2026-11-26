-- The DPS caster pick weights maximum health by the caster class bonus.
local passed=0
local function eq(actual,expected,label)
    assert(actual==expected,label..": expected "..tostring(expected)..", got "..tostring(actual))
    passed=passed+1
end
local file=assert(io.open(arg[1] or "HealBot/HealBot_Panel.lua","rb"))
local source=file:read("*a"):gsub("\r\n","\n")
file:close()
local chunk=assert(source:match("(local hbClassCasterPrefBonus={}.-)\nlocal aRole=nil"))

local classes,health={},{}
local env=setmetatable({
    HEALBOT_GAME_VERSION=11,HEALBOT_WORD_DPS="DPS",
    HealBot_issecretvalue=function() return false end,
    HealBot_unitRole={},hbRole={DPS=1},
    HealBot_WoWAPI_UnitHealth=function(unit) return health[unit],health[unit] end,
    UnitPowerType=function() return 0 end,
    UnitClass=function(unit) return unit,classes[unit],1 end,
}, {__index=_G})
local prefix="local hbDPS,hbDPSC=4,5\nlocal hbRoleOnes={[4]={health=0,guid=''},[5]={health=0,guid=''}}\n"
local run=setfenv(assert(loadstring(prefix..chunk.."\nreturn HealBot_Panel_DamagerRole,hbRoleOnes")),env)
local function pick(units)
    local damagerRole,roleOnes=run()
    for _,u in ipairs(units) do
        classes[u[1]],health[u[1]]=u[2],u[3]
        damagerRole(u[1],"G-"..u[1],true)
    end
    return roleOnes
end

local ones=pick({{"paladin","PALADIN",30000},{"mage","MAGE",20000}})
eq(ones[5].guid,"G-mage","a lower health mage beats a higher health paladin")
eq(ones[5].health,40000,"the mage health is doubled")
eq(ones[4].guid,"G-paladin","the plain DPS pick still ranks by health")

ones=pick({{"warrior","WARRIOR",30000},{"rogue","ROGUE",20000}})
eq(ones[5].guid,"G-warrior","classes without a bonus rank by health")
eq(ones[5].health,30000,"classes without a bonus keep their health")

ones=pick({{"mystery",nil,30000},{"mage","MAGE",20000}})
eq(ones[5].guid,"G-mage","an unknown class is not given a bonus")
ones=pick({{"mystery",nil,30000}})
eq(ones[5].guid,"G-mystery","an unknown class can still be picked")
eq(ones[5].health,30000,"an unknown class keeps its health")

print("Damager role tests passed: "..passed)
