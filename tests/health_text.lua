-- Exercise the actual modern health formatter. Native concatenation/format
-- propagate opaque values; addon arithmetic, inspection and tostring fail.
local passed=0
local hidden=setmetatable({}, {__mode="k"})
local function raw(v) if hidden[v]~=nil then return hidden[v] end return v end
local function forbidden() error("addon inspected protected health text") end
local secret
secret=function(value)
    local v=setmetatable({}, {__add=forbidden,__sub=forbidden,__mul=forbidden,
        __div=forbidden,__lt=forbidden,__le=forbidden,__tostring=forbidden,
        __concat=function(a,b) return secret(raw(a)..raw(b)) end})
    hidden[v]=value
    return v
end
local function eq(actual,expected,label)
    assert(raw(actual)==expected,label..": unexpected result")
    passed=passed+1
end
local f=assert(io.open("HealBot/HealBot_Text.lua","rb"))
local source=f:read("*a"):gsub("\r\n","\n"); f:close()
local formatter=assert(source:match("(function HealBot_Text_DoSetHealthText%([^\n]+.-)\nfunction "))
local function run(health,percent,include,places,healthType)
    local updates=0
    local button={frame=1,framecol=2,health={current=health,cpct=percent},text={}}
    local env=setmetatable({
        HealBot_Util_isMidnight=function() return true end,
        hbNumFormats={SurroundLeft={[2]="("},SurroundRight={[2]=")"},Places={[1]=0,[2]=places}},
        hbv_Skins_GetFrameVar=function(section,key,frame)
            assert(section=="BarText" and key=="HLTHTYPE" and frame==2)
            return healthType
        end,
        hbv_Skins_GetFrameBoolean=function(section,key,frame)
            assert(section=="BarText" and key=="HLTHINCPTC" and frame==2)
            return include
        end,
        format=function(fmt,value)
            local result=string.format(fmt,raw(value))
            return hidden[value]~=nil and secret(result) or result
        end,
        HealBot_Text_UpdateText=function(b) assert(b==button); updates=updates+1 end,
    },{__index=_G})
    setfenv(assert(loadstring(formatter)),env)()
    env.HealBot_Text_DoSetHealthText(button,false,false)
    eq(updates,1,"text refresh dispatched")
    eq(button.text.healthupdate,true,"health text marked for update")
    return button.text.healthcomplete
end
eq(run(500,50,true,0,1),"(500)  (50%)","current HP plus percentage")
eq(run(500,50,false,0,1),"(500)","disabled option retains HP only")
eq(run(500,50.24,true,1,1),"(500)  (50.2%)","one decimal from selected text frame")
eq(run(500,50.25,true,2,1),"(500)  (50.25%)","two decimals from selected text frame")
eq(run(500,50,true,3,1),"(500)  (50%)","unsupported precision uses integer")
eq(run(500,50,true,0,3),"(50%)","percentage mode does not duplicate text")
eq(run(500,50,false,0,2),"(50%)","existing modern deficit fallback preserved")
for _,values in ipairs({{secret(500),50},{500,secret(50)},{secret(500),secret(50)}}) do
    local text=run(values[1],values[2],true,0,1)
    eq(text,"(500)  (50%)","both fields survive protected values")
    eq(hidden[text]~=nil,true,"combined text remains protected")
end
eq(run(secret(500),secret(50),false,0,1),"(500)","protected HP-only output retained")
eq(run(secret(500),secret(50.25),false,2,3),"(50.25%)","protected percentage precision retained")
print("PASS: "..passed.." health text assertions (mock secret propagation)")
