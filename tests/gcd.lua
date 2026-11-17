-- Exercise the optional GCD sweep: off by default, reaches bars set up before
-- it was switched on, uses the client's GCD (including haste) when it can and
-- only estimates it from spell haste when the client hides or omits it.
local passed=0
local function eq(actual,expected,label)
    assert(actual==expected,label..": expected "..tostring(expected)..", got "..tostring(actual))
    passed=passed+1
end
local function near(actual,expected,label)
    assert(math.abs(actual-expected)<0.001,label..": expected "..expected..", got "..tostring(actual))
    passed=passed+1
end
local function forbidden() error("attempt to inspect a secret cooldown value") end
local secret=setmetatable({}, {__lt=forbidden,__le=forbidden,__eq=forbidden,
    __add=forbidden,__sub=forbidden,__div=forbidden})

local hooks,frames,chat={},{},{}
local handler
local now=100
local gcd,spell,haste={startTime=0,duration=0},{startTime=0,duration=0},0
local function newFrame(kind)
    local f={kind=kind,level=5}
    function f:SetAllPoints(target) self.target=target end
    function f:EnableMouse() end
    function f:SetMouseClickEnabled() end
    function f:SetMouseMotionEnabled() end
    function f:SetDrawEdge() end
    function f:SetDrawBling() end
    function f:SetHideCountdownNumbers() end
    function f:SetSwipeColor() end
    function f:SetFrameLevel(value) self.level=value end
    function f:GetFrameLevel() return self.level end
    function f:SetCooldown(start,duration) self.start,self.duration=start,duration end
    function f:Clear() self.start,self.duration=nil,nil end
    function f:RegisterEvent() end
    function f:RegisterUnitEvent(_,unit) assert(unit=="player") end
    function f:SetScript(_,fn) handler=fn end
    return f
end
local env=setmetatable({
    HealBot_Globals={ShowGCDSweep=false},
    HealBot_issecretvalue=function(value) return rawequal(value,secret) end,
    HealBot_AddChat=function(msg) chat[#chat+1]=msg end,
    hooksecurefunc=function(name,fn) hooks[name]=fn end,
    GetTime=function() return now end,
    UnitSpellHaste=function() return haste end,
    format=string.format,
    CreateFrame=function(kind,_,parent)
        local f=newFrame(kind)
        f.parent=parent
        if kind=="Cooldown" then frames[#frames+1]=f end
        return f
    end,
    C_Spell={GetSpellCooldown=function(id) if id==61304 then return gcd end return spell end},
}, {__index=_G})
setfenv(assert(loadfile(arg[1] or "HealBot/HealBot_GCD.lua")),env)()

local bar=newFrame("StatusBar")
local button={frame=1,gref={Bar=bar}}
local special={frame=10,gref={Bar=newFrame("StatusBar")}}

-- Bars are set up while the sweep is off
hooks["HealBot_Action_RegisterUnitEvents"](button)
hooks["HealBot_Action_RegisterUnitEvents"](special)
eq(#frames,0,"no sweep is created while disabled")

env.HealBot_GCD_Toggle()
eq(env.HealBot_Globals.ShowGCDSweep,true,"toggle enables the sweep")
eq(#frames,1,"switching on reaches bars set up earlier, none on frame 10+")
hooks["HealBot_Action_UpdateHealthButton"](button)
eq(#frames,1,"one sweep per bar")
local cd=frames[1]
eq(cd.parent,bar,"sweep sits on the health bar")
eq(cd.level,7,"sweep is above the bar")

-- 1: the client's GCD, already shortened by haste
gcd={startTime=100,duration=1.15}
handler(nil,"UNIT_SPELLCAST_SUCCEEDED","player","cast1",2050)
eq(cd.start,100,"client GCD start used")
eq(cd.duration,1.15,"hasted client GCD used as-is")

-- Skin resets re-layer the bar; the sweep follows when it starts
bar.level=20
now=110; gcd={startTime=0,duration=0}; spell={startTime=110,duration=1.2}
-- 2: the spell just cast reports the GCD lockout
handler(nil,"UNIT_SPELLCAST_START","player","cast2",2060)
eq(cd.duration,1.2,"spell lockout used when the client GCD is missing")
eq(cd.level,22,"sweep re-layered above the bar")
now=112
handler(nil,"UNIT_SPELLCAST_SUCCEEDED","player","cast2",2060)
eq(cd.start,110,"a cast-time spell's GCD is not restarted when it lands")

-- A spell's own longer cooldown is not taken for the GCD; estimate from haste
now=120; spell={startTime=120,duration=30}; haste=30
handler(nil,"UNIT_SPELLCAST_SUCCEEDED","player","cast3",33076)
near(cd.duration,1.5/1.3,"long spell cooldown ignored, GCD estimated from haste")

-- 3: a hidden client GCD is handed to the native cooldown frame
now=130; gcd={startTime=secret,duration=secret}; spell={startTime=0,duration=0}
handler(nil,"UNIT_SPELLCAST_SUCCEEDED","player","cast4",2050)
eq(cd.duration,secret,"hidden GCD passed to the cooldown frame")

-- 4: nothing readable: 1.5s without haste, never below 0.75s
now=140; gcd={startTime=0,duration=0}; haste=0
handler(nil,"UNIT_SPELLCAST_SUCCEEDED","player","cast5",2050)
eq(cd.duration,1.5,"estimate without haste")
now=150; haste=150
handler(nil,"UNIT_SPELLCAST_SUCCEEDED","player","cast6",2050)
eq(cd.duration,0.75,"estimate floored at 0.75s")

-- The client's GCD arriving after the cast replaces an estimate
gcd={startTime=150,duration=1.0}
handler(nil,"SPELL_UPDATE_COOLDOWN")
eq(cd.duration,1.0,"late client GCD replaces the estimate")

-- Secret cast details are ignored rather than compared
now=160; gcd={startTime=160,duration=1.4}
handler(nil,"UNIT_SPELLCAST_SUCCEEDED","player",secret,secret)
eq(cd.duration,1.4,"secret cast details still start the sweep")

env.HealBot_GCD_Toggle("test")
eq(cd.duration,5,"test command forces a 5 second sweep")
assert(chat[#chat]:find("last GCD: game GCD 1.40s"),"test command reports the last GCD source")
passed=passed+1

env.HealBot_GCD_Toggle()
eq(cd.start,nil,"toggling off clears the sweep")
eq(chat[#chat]:sub(1,13),"GCD sweep off","toggle reports off")
now=170; gcd={startTime=170,duration=1.5}
handler(nil,"UNIT_SPELLCAST_SUCCEEDED","player","cast7",2050)
eq(cd.start,nil,"disabled sweep ignores casts")

print("GCD sweep tests passed: "..passed)
