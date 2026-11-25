-- Exercise clearing one frame's aux bar assignments.
local passed=0
local function eq(actual,expected,label)
    assert(actual==expected,label..": expected "..tostring(expected)..", got "..tostring(actual))
    passed=passed+1
end
local function read(path)
    local f=assert(io.open(path,"rb"));local s=f:read("*a"):gsub("\r\n","\n");f:close();return s
end
local calls={}
local env=setmetatable({}, {__index=function(t,k)
    if k:match("^HealBot_") then
        return function(...) calls[k]={n=select("#",...),...} end
    end
    return _G[k]
end})
setfenv(assert(loadstring(assert(read("HealBot/HealBot_Options.lua"):match("(function HealBot_Options_clearAuxBars%b().-\nend)"),"clearAuxBars"))),env)()

env.HealBot_Options_clearAuxBars(2,5)
for _,name in ipairs({"HealBot_Aux_clearPowerAltAssigned","HealBot_Aux_clearPluginAssigned"}) do
    eq(calls[name]~=nil,true,name.." called")
    eq(calls[name][1],2,name.." frame")
    eq(calls[name][2],5,name.." id")
end

print("Clear aux bars tests passed: "..passed)
