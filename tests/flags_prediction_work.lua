local function read(path)
    local f=assert(io.open(path,"rb"))
    local text=f:read("*a"):gsub("\r\n","\n")
    f:close()
    return text
end
local baseline=arg[2]=="baseline"
local prefix=assert(read("tests/forever_frames.lua"):match('^(.-)\nlocal b=button%("party1"%)'))
prefix=prefix:gsub('loadAddon%("HealBot/HealBot_ForeverFrames%.lua"%)','loadAddon(...)',1)
local env,hooks,button,fire,setAmount,setCombat,setMonitor=assert(loadstring(prefix..[[
return env,hooks,button,function(event) eventFrame.callback(nil,event) end,
    function(value) amount=value end,function(value) combat=value end,function(value) monitoring=value end
]]))(arg[1] or "HealBot/HealBot_ForeverFrames.lua")
local reads,tints,lastUnit=0,0,nil
env.UnitGetDetailedHealPrediction=function(unit,caster)
    assert(caster=="player"); lastUnit=unit; reads=reads+1
end
env.HealBot_Forever_UpdateOverShield=function() tints=tints+1 end
local bars={}
for i=1,40 do
    bars[i]=button("raid"..i)
    hooks.HealBot_Action_RegisterUnitEvents(bars[i])
end
assert(reads==40)
local before=reads
setMonitor(false)
for i=1,25 do hooks.HealBot_Aura_SetAuraCheckFlags(false,false,false,false,false) end
assert(reads-before==(baseline and 1000 or 0))
if not baseline then assert(tints==1000) end
for i=1,40 do assert(not bars[i].foreverDebuffs.all.shown) end
setMonitor(true); hooks.HealBot_Aura_SetAuraCheckFlags()
for i=1,40 do assert(bars[i].foreverDebuffs.all.shown) end
before=reads
setCombat(true); fire("PLAYER_REGEN_DISABLED")
assert(reads-before==40)
before=reads
setCombat(false); fire("PLAYER_REGEN_ENABLED")
assert(reads-before==40)
before=reads
hooks.hbv_Skins_SetFrameVar("test","BarIACol","IA",1)
assert(reads-before==40)

local update=assert(read("HealBot/HealBot.lua"):match('(function HealBot_HealsInUpdate%(button%).-\nend)\n'))
setfenv(assert(loadstring(update)),env)()
env.HealBot_Text_setInHealAbsorbsText=function() end
local first=bars[1]
setAmount(76);first.range.current=0
env.HealBot_HealsInUpdate(first)
assert(first.foreverIncoming.bar.value==76 and first.foreverIncoming.bar.color[4]==0.8*0.9/3)
first.range.current=1;first.unit="party1";setAmount(89)
hooks.HealBot_Action_ResetrCallsUnit(first)
env.HealBot_HealsInUpdate(first)
assert(lastUnit=="party1" and first.foreverIncoming.bar.value==89 and first.foreverIncoming.bar.color[4]==0.8*0.9)
before=reads
hooks.HealBot_Skins_ResetSkin("bar",first)
assert(reads==before+1)
print((baseline and "BASELINE: 1000" or "PASS: zero").." prediction reads for 25 aura flags over 40 bars; debuff/overshield, combat, actual unit prediction, rebinding, range, skin and caster checks")
