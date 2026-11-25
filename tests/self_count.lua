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

print("Self count text tests passed: "..passed)
