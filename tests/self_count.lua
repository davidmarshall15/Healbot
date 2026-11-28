-- Refresh the self-count text on every active frame, not only the first.
local passed=0
local function eq(actual,expected,label)
    assert(actual==expected,label..": expected "..tostring(expected)..", got "..tostring(actual))
    passed=passed+1
end
local file=assert(io.open(arg[1] or "HealBot/HealBot_ActionIcons.lua","rb"))
local source=file:read("*a"):gsub("\r\n","\n")
file:close()
local chunk=assert(source:match("(function HealBot_ActionIcons_SelfCountTextUpdateAll%(%).-\nend)\n"))

local timers,refreshed,rescheduled={},{},0
local env
env=setmetatable({
    activeFramesIdx={},hb_lVars={},
    C_Timer={After=function(delay,fn) timers[#timers+1]={delay=delay,fn=fn} end},
    HealBot_ActionIcons_SelfCountTextUpdateExisting=function(frame) refreshed[#refreshed+1]=frame end,
    HealBot_ActionIcons_setLuVars=function(name,value) env.hb_lVars[name]=value end,
    HealBot_Timers_Set=function() rescheduled=rescheduled+1 end,
}, {__index=_G})
setfenv(assert(loadstring(chunk)),env)()
local function run(frames)
    timers,refreshed,rescheduled={},{},0
    env.activeFramesIdx,env.hb_lVars=frames,{}
    env.HealBot_ActionIcons_SelfCountTextUpdateAll()
    for _,t in ipairs(timers) do t.fn() end
end

run({3,5,7})
eq(table.concat(refreshed,","),"3,5,7","every active frame is refreshed")
eq(rawget(env,"x"),nil,"the loop index stays local")
run({4})
eq(table.concat(refreshed,","),"4","a single active frame is refreshed")
run({})
eq(#refreshed,0,"no active frames means no refresh")
env.activeFramesIdx,env.hb_lVars={3,5},{SelfCountTextUpdate=true}
timers,refreshed={},{}
env.HealBot_ActionIcons_SelfCountTextUpdateAll()
eq(#timers,0,"a refresh already pending is not restarted")
eq(rescheduled,1,"a refresh already pending is rescheduled")

local function install(name)
    local definition=assert(source:match("(function "..name.."%b().-\nend)"))
    setfenv(assert(loadstring(definition)),env)()
end
local secret={}
local charges,casts,items=0,0,0
local castReads=0
env.HealBot_issecretvalue=function(value) return rawequal(value,secret) end
env.C_Spell={
    GetSpellCharges=function(id)
        if id==1 then return {currentCharges=charges} end
    end,
    GetSpellCastCount=function() castReads=castReads+1; return casts end,
}
local apiPath=arg[2] or "HealBot/Libs/LibWoWAPI/HealBot_WoWAPI.lua"
setfenv(assert(loadfile(apiPath)),env)()
env.HealBot_WoWAPI_SetC_Spell()
env.HealBot_WoWAPI_ItemCount=function() return items end
env.hbv_ActionIcons_GetBoolean=function() return false end
env.activeFrames={[3]=true,[5]=true}
env.iconFrame={[3]={numIcons=3},[5]={numIcons=1}}
env.actionIcons={[3]={{infoType="spell",infoID=1,count=0},{infoType="spell",infoID=2,count=0},{infoType="item",infoID=3,count=0}},
    [5]={{infoType="spell",infoID=1,count=0}}}
env.actionIconFrame={[3]={},[5]={}}
for frame,icons in pairs(env.actionIcons) do
    for k in ipairs(icons) do
        env.actionIconFrame[frame][k]={countText={SetText=function(self,value) self.value=value end}}
    end
end
install("HealBot_ActionIcons_SelfCountText")
install("HealBot_ActionIcons_SelfCountTextUpdate")
install("HealBot_ActionIcons_SelfCountTextUpdateExisting")
charges,casts,items=1,4,3
run({3})
eq(env.actionIconFrame[3][1].countText.value,1,"first charge restored from empty")
eq(env.actionIconFrame[3][2].countText.value,4,"reagent count uses the cast count API")
eq(env.actionIconFrame[3][3].countText.value,3,"first acquired item restores count")
eq(castReads,1,"charge-based spell does not query cast count")
charges,casts,items=secret,secret,secret
run({3});eq(castReads,2,"protected charge was not evaluated or replaced")
for k=1,3 do eq(env.actionIconFrame[3][k].countText.value,"","unknown count stays blank") end
charges=2
timers,env.hb_lVars,env.activeFramesIdx={},{},{3,5}
env.HealBot_ActionIcons_SelfCountTextUpdateAll()
env.activeFrames[3]=nil
env.activeFramesIdx={5}
for _,t in ipairs(timers) do t.fn() end
eq(env.actionIconFrame[3][1].countText.value,"","retired panel untouched")
eq(env.actionIconFrame[5][1].countText.value,2,"original active panel survives reordered list")
local legacy=setmetatable({GetSpellCount=function() return 7 end},{__index=_G})
setfenv(assert(loadfile(apiPath)),legacy)()
legacy.HealBot_WoWAPI_SetC_Spell()
eq(legacy.HealBot_WoWAPI_SpellCount(2),7,"legacy item-based count API")
eq(legacy.HealBot_WoWAPI_SpellCharges(2),nil,"legacy client without charges")
print("Self count text tests passed: "..passed)
