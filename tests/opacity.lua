-- Reproduce the actual opacity refresh with values that reject comparisons.
local f=assert(io.open("HealBot/HealBot_Action.lua", "rb"))
local source=f:read("*a"):gsub("\r\n", "\n")
f:close()
local code=assert(source:match("(function HealBot_Action_ResetUnitButtonOpacity%(button%).-)\nfunction HealBot_Action_ResetOpacity"))
local secret=setmetatable({}, {__lt=function() error("secret comparison") end})
local passed=0
for _, case in ipairs({
    {true,secret,secret,1,0}, {true,0,0,1,0}, {true,10,20,1,1},
    {false,0,0,0,0}, {false,10,20,1,1}, {false,secret,secret,0,0},
}) do
    local heals,absorbs,finished=0,0,false
    local env=setmetatable({HEALBOT_FOREVER=case[1],
        HealBot_issecretvalue=function(value) return value==secret end,
        HealBot_Action_UpdateHealsInButton=function() heals=heals+1 end,
        HealBot_Action_UpdateAbsorbsButton=function() absorbs=absorbs+1 end,
        HealBot_Aggro_IndicatorUpdate=function() finished=true end,
    }, {__index=function() return function() end end})
    setfenv(assert(loadstring(code)),env)()
    env.HealBot_Action_ResetUnitButtonOpacity({health={incoming=case[2],absorbs=case[3]}})
    assert(heals==case[4], "incoming refresh count")
    assert(absorbs==case[5], "absorb refresh count")
    assert(finished, "opacity refresh completes")
    passed=passed+3
end
print("PASS: "..passed.." opacity regression assertions")
