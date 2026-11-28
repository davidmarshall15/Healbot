local file=assert(io.open("HealBot/HealBot_Action.lua","rb"))
local source=file:read("*a"):gsub("\r\n","\n")
file:close()
local env=setmetatable({lGlow={},hbGlowCol={ICONBUFF={},ICONDEBUFF={}},hbGlowFreq={},
    hbIconGlowSize={},hbIconGlowSizeStars={},hbIconGlowLen={}}, {__index=_G})
local function register(kind)
    env.lGlow[kind.."_Start"]=function(region,...)
        local key=select(select("#",...),...)
        region[kind..key]=true
    end
    env.lGlow[kind.."_Stop"]=function(region,key) region[kind..key]=nil end
end
register("PixelGlow")
register("AutoCastGlow")
for _,name in ipairs({"IconGlow","IconGlowBall","EnableIconGlow","DisableIconGlow","DisableBuffIconGlow","DisableDebuffIconGlow"}) do
    local body=assert(source:match("(function HealBot_Action_"..name.."%(.-\nend)"))
    setfenv(assert(loadstring(body)),env)()
end
local button={frame=1,glow={icon={}},gref={iconf={}}}
for i=1,60 do button.glow.icon[i]=0; button.gref.iconf[i]={} end
for _,v in ipairs({{1,3},{9,4},{12,3},{51,4}}) do
    local key=v[1]<50 and "ICONBUFF" or "ICONDEBUFF"
    env.HealBot_Action_EnableIconGlow(button,1,.5,.25,key,v[2],v[1],1)
    assert(next(button.gref.iconf[v[1]]),"glow start was not exercised")
end
env.HealBot_Action_DisableBuffIconGlow(button)
for _,i in ipairs({1,9,12}) do
    assert(not next(button.gref.iconf[i]) and button.glow.icon[i]==0,"bulk removal left buff glow running")
end
assert(button.gref.iconf[51].AutoCastGlowICONDEBUFF and button.glow.icon[51]==4)
env.HealBot_Action_DisableDebuffIconGlow(button)
assert(not next(button.gref.iconf[51]) and button.glow.icon[51]==0)
print("PASS: bulk cleanup releases the same keyed pixel and autocast glows that started across all three buff icon sets")
