-- Exercise the player's own mana line in the bar tooltip.
local passed=0
local function eq(actual,expected,label)
    assert(actual==expected,label..": expected "..tostring(expected)..", got "..tostring(actual))
    passed=passed+1
end
local function forbidden() error("attempt to inspect a secret mana value") end
-- Concatenation is allowed and marks where protected text ends up
local secret
secret=setmetatable({}, {__lt=forbidden,__le=forbidden,__div=forbidden,__mul=forbidden,
    __concat=function(a,b)
        return (rawequal(a,secret) and "<secret>" or a)..(rawequal(b,secret) and "<secret>" or b)
    end})
local file=assert(io.open(arg[1] or "HealBot_Tips/HealBot_Tooltip.lua","rb"))
local source=file:read("*a"):gsub("\r\n","\n")
file:close()
local chunk=assert(source:match("(HEALBOT_TOOLTIP_YOUR_MANA=.-\nend)\n"))

local lines,isSelf,mana,maxMana,protectedPct
local env=setmetatable({
    floor=math.floor,format=string.format,
    playerPowerCols={r=1,g=1,b=1},
    UnitIsUnit=function() return isSelf end,
    UnitPower=function(unit,power) assert(unit=="player" and power==0) return mana end,
    UnitPowerMax=function(unit,power) assert(unit=="player" and power==0) return maxMana end,
    UnitPowerPercent=function() end,
    HealBot_WoWAPI_UnitMana=function(unit,power)
        assert(unit=="player" and power==0)
        return mana,maxMana,protectedPct,protectedPct
    end,
    HealBot_issecretvalue=function(value) return rawequal(value,secret) end,
    HealBot_Tooltip_SetLine=function(left,_,_,_,_,right) lines[#lines+1]={left=left,right=right} end,
}, {__index=_G})
setfenv(assert(loadstring(chunk)),env)()
local function run(self,m,mx,pct)
    lines,isSelf,mana,maxMana,protectedPct={},self,m,mx,pct
    env.HealBot_Tooltip_PlayerManaLine("party1")
    return lines[1]
end

local line=run(false,1500,3000)
eq(line.left,"Your mana","line is labelled")
eq(line.right,"1500/3000 (50%)","readable mana with percentage")
eq(run(true,1500,3000),nil,"hovering yourself adds no line")
eq(run(false,0,0),nil,"no mana pool adds no line")
eq(run(false,nil,nil),nil,"missing values add no line")
eq(run(false,secret,secret,80).right,"<secret>/<secret> (80%)","protected mana shows the displayable percentage")
eq(run(false,secret,3000,80).right,"<secret>/3000 (80%)","partly protected mana is not compared")
eq(run(false,secret,secret,secret).right,"<secret>/<secret>","unformattable percentage is left out")
env.UnitPowerPercent=nil
eq(run(false,secret,secret,80).right,"<secret>/<secret>","no percentage without UnitPowerPercent")

print("Player mana tests passed: "..passed)
