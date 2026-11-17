-- Exercise the optional GCD sweep: off by default, attaches to bars once
-- enabled, follows the GCD, clears when toggled off and accepts secret values.
local passed=0
local function eq(actual,expected,label)
    assert(actual==expected,label..": expected "..tostring(expected)..", got "..tostring(actual))
    passed=passed+1
end
local function forbidden() error("attempt to inspect a secret cooldown value") end
local secret=setmetatable({}, {__lt=forbidden,__le=forbidden,__add=forbidden,__sub=forbidden})

local hooks,frames,chat={},{},{}
local eventHandler
local cooldown={startTime=0,duration=0}
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
    function f:SetScript(_,handler) eventHandler=handler end
    return f
end
local env=setmetatable({
    HealBot_Globals={ShowGCDSweep=false},
    HealBot_issecretvalue=function(value) return rawequal(value,secret) end,
    HealBot_AddChat=function(msg) chat[#chat+1]=msg end,
    hooksecurefunc=function(name,fn) hooks[name]=fn end,
    CreateFrame=function(kind,_,parent)
        local f=newFrame(kind)
        f.parent=parent
        if kind=="Cooldown" then frames[#frames+1]=f end
        return f
    end,
    C_Spell={GetSpellCooldown=function(id) assert(id==61304) return cooldown end},
}, {__index=_G})
setfenv(assert(loadfile(arg[1] or "HealBot/HealBot_GCD.lua")),env)()

local bar=newFrame("StatusBar")
local button={frame=1,gref={Bar=bar}}
local special={frame=10,gref={Bar=newFrame("StatusBar")}}

hooks["HealBot_Action_UpdateHealthButton"](button)
eq(#frames,0,"no sweep is created while disabled")

env.HealBot_GCD_Toggle()
eq(env.HealBot_Globals.ShowGCDSweep,true,"toggle enables the sweep")
eq(chat[1],"GCD sweep on","toggle reports on")
hooks["HealBot_Action_UpdateHealthButton"](button)
hooks["HealBot_Action_UpdateHealthButton"](button)
hooks["HealBot_Action_RegisterUnitEvents"](special)
eq(#frames,1,"one sweep per bar, none on frame 10+")
local cd=frames[1]
eq(cd.parent,bar,"sweep sits on the health bar")
eq(cd.level,7,"sweep is above the bar")

cooldown={startTime=50,duration=1.5}
eventHandler()
eq(cd.start,50,"sweep follows the GCD start")
eq(cd.duration,1.5,"sweep follows the GCD duration")

cooldown={startTime=0,duration=0}
eventHandler()
eq(cd.start,nil,"sweep clears when the GCD ends")

cooldown={startTime=secret,duration=secret}
eventHandler()
eq(cd.start,secret,"secret GCD values are passed to the sweep")
cooldown={startTime=60,duration=1.5}
eventHandler()
eq(cd.start,60,"readable values replace secret ones")

env.HealBot_GCD_Toggle()
eq(cd.start,nil,"toggling off clears the sweep")
eq(chat[2],"GCD sweep off","toggle reports off")
cooldown={startTime=70,duration=1.5}
eventHandler()
eq(cd.start,nil,"disabled sweep ignores the GCD")

print("GCD sweep tests passed: "..passed)
