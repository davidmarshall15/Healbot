local passed=0
local function eq(actual, expected, label)
    assert(actual==expected, label)
    passed=passed+1
end

local function forbidden() error("Inspected a secret value or changed a protected frame") end
local secret=setmetatable({}, {__add=forbidden,__sub=forbidden,__mul=forbidden,
    __div=forbidden,__lt=forbidden,__le=forbidden,__index=forbidden,__tostring=forbidden})
local combat=false
local hooks={}
local eventFrame, sampler
local frames={}
local walked, refreshed, queried, secretChecks, dispatched=0,0,0,0,0
local names={target="New target",targettarget="New target of target",focus="New focus"}
local exists={target=true,targettarget=true,focus=true}
local calls={}
local registered
local env=setmetatable({}, {__index=_G})
env._G=env
env.SlashCmdList={}

local function region()
    return {
        SetText=function(self,value) self.value=value end,
        SetValue=function(self,value) self.value=value end,
        SetParent=function() assert(not combat,"reparented a protected region in combat") end,
        SetDrawLayer=function() assert(not combat,"changed a protected region in combat") end,
    }
end

env.HEALBOT_FOREVER=true
env.InCombatLockdown=function() return combat end
env.HealBot_issecretvalue=function(value)
    secretChecks=secretChecks+1
    return rawequal(value,secret)
end
env.pairs=function(t)
    local iterator,state,initial=pairs(t)
    return function(state,key)
        local nextKey,value=iterator(state,key)
        if nextKey~=nil then walked=walked+1 end
        return nextKey,value
    end,state,initial
end
env.CreateFrame=function(kind)
    assert(not combat,"created a protected frame in combat")
    eq(kind,"Frame","module creates ordinary frames")
    local frame={
        events={},scripts={},shown=true,
        RegisterEvent=function(self,event) self.events[event]=true end,
        RegisterUnitEvent=function(self,event,unit,...)
            eq(select("#",...),0,"only the target unit dependency is registered")
            self.events[event]=unit
        end,
        SetScript=function(self,script,callback) self.scripts[script]=callback end,
        Hide=function(self) self.shown=false end,
    }
    frames[#frames+1]=frame
    return frame
end
env.hooksecurefunc=function(name,callback) hooks[name]=callback end
env.HealBot_Forever_GetDebuffTypes=function() return {},"" end
env.UnitExists=function(unit)
    queried=queried+1
    assert(exists[unit]~=nil,"queried an unrelated unit")
    return exists[unit]
end
env.UnitName=function(unit) return names[unit] end
env.UnitGUID=forbidden
env.UnitIsUnit=forbidden
env.HealBot_WoWAPI_UnitHealth=function()
    return secret,secret,secret,secret,secret,secret,secret
end
env.HealBot_WoWAPI_UnitMana=function() return secret,secret,secret,secret end
env.HealBot_Action_setButtonManaBarCol=function(button) button.mana.type=3 end
env.HealBot_Text_DoSetHealthText=function(button)
    button.gref.txt.text2:SetText(button.health.current)
end
env.HealBot_Aux_setPowerBars=function(button) button.renderedPower=button.mana.current end

local chunk=assert(loadfile("HealBot/HealBot_ForeverFrames.lua"))
setfenv(chunk,env)()
for _,frame in ipairs(frames) do
    if frame.events.PLAYER_TARGET_CHANGED then eventFrame=frame end
    if frame.scripts.OnUpdate then sampler=frame end
end
eq(#frames,2,"one shared target-event frame and one timing sampler")
assert(eventFrame and sampler and eventFrame~=sampler,"independent frames for target events and timing")
eq(type(eventFrame.scripts.OnEvent),"function","installed the real target-event handler")
eq(sampler.shown,false,"optional timing sampler stays hidden")
eq(next(sampler.events),nil,"optional timing sampler registers no events on load")
eq(type(env.SlashCmdList.HEALBOTLIVEPERF),"function","timing can be enabled explicitly")
registered=eventFrame.events
local refresh=env.HealBot_Forever_RefreshTarget
local debuffRebinds=0
env.HealBot_Forever_RebindDebuffScan=function() debuffRebinds=debuffRebinds+1 end
env.HealBot_Forever_RefreshTarget=function(button)
    refreshed=refreshed+1
    calls[button]=(calls[button] or 0)+1
    refresh(button)
end
eq(registered.UNIT_TARGET,"target","client filters target-of-target dependency events")

local function button(unit,frame)
    local b={unit=unit,frame=frame or 1,name="Old",health={},mana={},text={},
        status={events=true},aura={debuff={}},gref={Top={},Bar=region(),txt={}},
        SetAttribute=forbidden,Show=forbidden,Hide=forbidden,SetParent=forbidden}
    for _,key in ipairs({"text","text2","text3","text4","text5"}) do
        b.gref.txt[key]=region()
    end
    return b
end

local function attach(unit,frame)
    local b=button(unit,frame)
    hooks.HealBot_Action_RegisterUnitEvents(b)
    return b
end

local function dispatch(event,unit,routedUnit)
    walked,refreshed,queried,secretChecks,dispatched=0,0,0,0,0
    debuffRebinds=0
    calls={}
    -- Native filtering resolves which unit changed independently of the
    -- payload's spelling/readability; selected party/raid aliases may match.
    local registration=registered[event]
    if registration and (registration==true or registration==(routedUnit or unit)) then
        dispatched=1
        eventFrame.scripts.OnEvent(eventFrame,event,unit)
    end
end

local function work(expected,label)
    eq(debuffRebinds,expected,label..": only changed target bindings invalidate harmful state")
    eq(refreshed,expected,label..": refresh calls")
    eq(walked,expected,label..": only relevant buttons traversed")
    eq(queried,expected,label..": only relevant unit queries")
end

-- Registering many ordinary bars must not increase the target-event work.
combat=true
for i=1,200 do attach("raid"..i) end
for i=1,4 do attach("party"..i) end
local target=attach("target")
local duplicateTarget=attach("target",2)
local targettarget=attach("targettarget")
local duplicateTargettarget=attach("targettarget",2)
local focus=attach("focus")
local duplicateFocus=attach("focus",2)
local unsupported=attach("target",10)

dispatch("PLAYER_TARGET_CHANGED")
work(4,"player target change")
eq(calls[target],1,"target refreshed once")
eq(calls[duplicateTarget],1,"duplicate target refreshed once")
eq(calls[targettarget],1,"target of target refreshed once")
eq(calls[duplicateTargettarget],1,"duplicate target of target refreshed once")
eq(calls[focus],nil,"target change leaves focus alone")
eq(calls[unsupported],nil,"excluded frames stay outside the target index")
eq(target.name,"New target","target name updated")
eq(targettarget.name,"New target of target","target of target name updated")
eq(target.gref.Bar.value,secret,"secret health forwarded to the native bar")
eq(target.renderedPower,secret,"secret power forwarded without inspection")
refresh(target)
eq(debuffRebinds,4,"ordinary health or mana repaint invalidated the debuff scan")

dispatch("PLAYER_FOCUS_CHANGED")
work(2,"focus change")
eq(calls[focus],1,"focus refreshed once")
eq(calls[duplicateFocus],1,"duplicate focus refreshed once")
eq(calls[target],nil,"focus change leaves target alone")
eq(focus.name,"New focus","focus name updated")

dispatch("UNIT_TARGET","target")
work(2,"target's target change")
eq(dispatched,1,"matching native dependency reaches the handler")
eq(calls[targettarget],1,"target's target refreshed once")
eq(calls[duplicateTargettarget],1,"duplicate target's target refreshed once")
eq(calls[target],nil,"target's target change leaves target alone")
eq(calls[focus],nil,"target's target change leaves focus alone")

for _,unit in ipairs({"party1","raid40","boss1","focus","targettarget","player"}) do
    dispatch("UNIT_TARGET",unit)
    work(0,"unrelated UNIT_TARGET "..unit)
    eq(dispatched,0,"native filter rejects unrelated "..unit.." before Lua dispatch")
end
for _,unit in ipairs({"party1","raid40","boss1"}) do
    dispatch("UNIT_TARGET",unit,"target")
    work(2,"selected target alias "..unit)
    eq(dispatched,1,"selected alias is resolved by the native filter")
    eq(secretChecks,0,"selected alias payload is not inspected")
end
dispatch("UNIT_TARGET",secret,"target")
work(2,"opaque payload on matching native dependency")
eq(secretChecks,0,"secret event payload is not inspected")
dispatch("UNIT_TARGET",nil,"target")
work(2,"missing payload on matching native dependency")
eq(secretChecks,0,"missing event payload does not affect dependency routing")

-- Outside combat the normal renderer owns these bars. Do not even inspect
-- event-unit data or walk relevant-button sets on this path.
combat=false
for _,event in ipairs({"PLAYER_TARGET_CHANGED","PLAYER_FOCUS_CHANGED","UNIT_TARGET"}) do
    dispatch(event,secret,"target")
    work(0,"outside-combat "..event)
    eq(dispatched,1,"outside-combat event reaches the early guard")
    eq(secretChecks,0,"outside-combat event data remains uninspected")
end

-- Re-registering a reused button cleans the old set and keeps duplicates.
combat=true
target.unit="party2"
hooks.HealBot_Action_RegisterUnitEvents(target)
dispatch("PLAYER_TARGET_CHANGED")
work(3,"re-register target as party")
eq(calls[target],nil,"old target membership removed")
target.unit="focus"
hooks.HealBot_Action_RegisterUnitEvents(target)
dispatch("PLAYER_FOCUS_CHANGED")
work(3,"re-register party as focus")
eq(calls[target],1,"new focus membership added")
hooks.HealBot_Action_RegisterUnitEvents(target)
dispatch("PLAYER_FOCUS_CHANGED")
work(3,"repeated registration")
eq(calls[target],1,"repeated registration never duplicates refresh")

-- The real SetHealButton rebind path resets unit calls without always
-- re-registering events. Its hook must update just that active button.
duplicateTarget.unit="party3"
hooks.HealBot_Action_ResetrCallsUnit(duplicateTarget)
dispatch("PLAYER_TARGET_CHANGED")
work(2,"registered target rebound through unit reset")
eq(calls[duplicateTarget],nil,"unit reset removes old target membership")
duplicateTarget.unit="targettarget"
hooks.HealBot_Action_ResetrCallsUnit(duplicateTarget)
dispatch("UNIT_TARGET","target")
work(3,"registered party rebound through unit reset")
eq(calls[duplicateTarget],1,"unit reset adds new target-of-target membership")
duplicateTarget.frame=10
hooks.HealBot_Action_ResetrCallsUnit(duplicateTarget)
dispatch("UNIT_TARGET","target")
work(2,"rebind into an excluded frame")
duplicateTarget.frame=1
hooks.HealBot_Action_RegisterUnitEvents(duplicateTarget)

-- Detach must use recorded membership even when the button's token was
-- already changed, and a later reset must not reactivate a detached bar.
duplicateTargettarget.unit="party4"
hooks.HealBot_Action_UnregisterUnitEvents(duplicateTargettarget)
duplicateTargettarget.unit="focus"
hooks.HealBot_Action_ResetrCallsUnit(duplicateTargettarget)
dispatch("UNIT_TARGET","target")
work(2,"detach after token change")
dispatch("PLAYER_FOCUS_CHANGED")
work(3,"detached unit reset")
eq(calls[duplicateTargettarget],nil,"detached bar remains absent")
hooks.HealBot_Action_UnregisterUnitEvents(focus)
hooks.HealBot_Action_UnregisterUnitEvents(focus)
dispatch("PLAYER_FOCUS_CHANGED")
work(2,"repeated detach")
eq(calls[focus],nil,"detached focus is not refreshed")

-- The optimized route still clears disappearing targets and forwards opaque
-- names. These are display writes, with protected frame operations forbidden.
exists.targettarget=false
dispatch("UNIT_TARGET","target")
work(2,"target of target disappears")
eq(targettarget.name,"","missing target of target clears its cached name")
eq(targettarget.gref.txt.text.value,"","missing target of target clears displayed name")
eq(targettarget.gref.txt.text2.value,"","missing target of target clears displayed health")
eq(targettarget.gref.Bar.value,0,"missing target of target clears health bar")
eq(targettarget.renderedPower,0,"missing target of target clears power")
exists.targettarget=true
names.targettarget=secret
dispatch("UNIT_TARGET","target")
work(2,"target of target returns with opaque data")
eq(targettarget.gref.txt.text.value,secret,"secret name forwarded without inspection")
eq(targettarget.gref.Bar.value,secret,"returned target renders secret health")

print("PASS: "..passed.." target-event refresh assertions (mock APIs, not an in-game test)")
