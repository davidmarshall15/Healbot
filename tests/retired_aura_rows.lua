local function read(path)
    local f=assert(io.open(path,"rb")); local text=f:read("*a"):gsub("\r\n","\n")
    f:close()
    return text
end
local prefix=assert(read("tests/bg_weakened_soul.lua"):match("^(.-)local d=fixture"))
local fixture=assert(loadstring(prefix.."return fixture"))()
local d=fixture("PRIEST",4)
d.skin.limits={4,2,2}
d.globals.CombatAurasNativeWeakenedSoul=true
d.env.HealBot_Forever_WatchesWeakenedSoul=function() return true end
d.env.HealBot_Aura_GetDebuffIconPreference=function() return true end
d.env.HealBot_Timers_Set=function() end
local b=d.button()
local function rows()
    local result={}
    for _,frame in ipairs(d.frames) do
        if frame.enabled and frame.groups and next(frame.groups) then result[#result+1]=frame end
    end
    return result
end
local first=rows()
assert(#first>=4,"fixture needs both helpful and harmful groups plus a slot")
d.hook("HealBot_Action_UnregisterUnitEvents",b)
for _,frame in ipairs(first) do assert(frame.enabled,"unregistration retired a reusable bar") end
d.hook("HealBot_Action_RegisterUnitEvents",b)
assert(d.env.HealBot_CombatAuras_SetOption("size",16))
for _,frame in ipairs(first) do assert(not frame.enabled and not frame.shown,"obsolete group remained enabled") end
local second=rows()
assert(#second==#first,"structural rebuild lost groups")
d.combat(true)
local n=#d.frames
assert(d.env.HealBot_CombatAuras_SetOption("size",18))
for _,frame in ipairs(second) do assert(frame.enabled and not frame.shown,"lockdown teardown changed native enablement") end
assert(#d.frames==n,"allocated during the settings edit in combat")
local failOnce=second[1]
local original=failOnce.SetEnabled
function failOnce:SetEnabled(value)
    self.SetEnabled=original
    error("injected rejection")
end
d.combat(false)
for _,frame in ipairs(second) do
    if frame~=failOnce then assert(not frame.enabled and not frame.shown,"deferred group not retired") end
end
assert(failOnce.enabled and not failOnce.shown,"failed teardown displayed old content")
d.combat(true); d.combat(false)
assert(not failOnce.enabled,"rejected teardown never retried")
assert(#rows()==#first,"duplicate groups remain enabled after recovery")
print("PASS: ordinary rows survive rebind, retire on replacement, defer in lockdown and recover rejected retirement")
