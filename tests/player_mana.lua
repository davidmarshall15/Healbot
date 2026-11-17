-- Exercise the player's own mana line in the bar tooltip.
local passed=0
local function eq(actual,expected,label)
    assert(actual==expected,label..": expected "..tostring(expected)..", got "..tostring(actual))
    passed=passed+1
end
local function forbidden() error("attempt to inspect a secret mana value") end
local secret
secret=setmetatable({}, {__lt=forbidden,__le=forbidden,__div=forbidden,__mul=forbidden,
    __concat=function() return secret end})
local file=assert(io.open(arg[1] or "HealBot_Tips/HealBot_Tooltip.lua","rb"))
local source=file:read("*a"):gsub("\r\n","\n")
file:close()
local chunk=assert(source:match("(HEALBOT_TOOLTIP_YOUR_MANA=.-\nend)\n"))

local lines,isSelf,mana,maxMana
local env=setmetatable({
    floor=math.floor,format=string.format,
    playerPowerCols={r=1,g=1,b=1},
    UnitIsUnit=function() return isSelf end,
    UnitPower=function(unit,power) assert(unit=="player" and power==0) return mana end,
    UnitPowerMax=function(unit,power) assert(unit=="player" and power==0) return maxMana end,
    HealBot_issecretvalue=function(value) return rawequal(value,secret) end,
    HealBot_Tooltip_SetLine=function(left,_,_,_,_,right) lines[#lines+1]={left=left,right=right} end,
}, {__index=_G})
setfenv(assert(loadstring(chunk)),env)()
local function run(self,m,mx)
    lines,isSelf,mana,maxMana={},self,m,mx
    env.HealBot_Tooltip_PlayerManaLine("party1")
    return lines[1]
end

local line=run(false,1500,3000)
eq(line.left,"Your mana","line is labelled")
eq(line.right,"1500/3000 (50%)","readable mana with percentage")
eq(run(true,1500,3000),nil,"hovering yourself adds no line")
eq(run(false,0,0),nil,"no mana pool adds no line")
eq(run(false,nil,nil),nil,"missing values add no line")
line=run(false,secret,secret)
eq(line.right,secret,"protected mana reaches native tooltip text")
line=run(false,secret,3000)
eq(line.right,secret,"partly protected mana is not compared")

print("Player mana tests passed: "..passed)
