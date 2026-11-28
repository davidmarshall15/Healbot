-- Exercise the actual reserve styling path against warmed slots and donor changes.
local function read(path)
    local f=assert(io.open(path,"rb")); local result=f:read("*a"); f:close()
    return result:gsub("\r\n","\n")
end
local module=read(arg[1] or "HealBot/HealBot_ForeverPartyJoin.lua")
module=module:sub(1,assert(module:find("local function Sync()",1,true))-1)
local writes,fonts,centers,auras,allocated=0,0,0,0,0
local fail,enabled,floating=false,true,false
local state={x=40,y=25,width=72,height=9,texture=321,orientation="HORIZONTAL",reverse=false,
    r=.1,g=.2,b=.3,alpha=.7,tr=.3,tg=.4,tb=.5,ta=.6}
local config={ALIGN=1,HOFFSET=2,OFFSET=-3,FONT="power",HEIGHT=12,OUTLINE=1}
local resolvedFont="power.ttf"
local methods={}
local function region() return setmetatable({},{__index=methods}) end
for _,method in ipairs({"EnableMouse","ClearAllPoints","SetPoint","SetSize","SetStatusBarTexture","SetOrientation",
    "SetReverseFill","SetStatusBarColor","SetJustifyH","SetWidth","SetTextColor","Show","Hide"}) do
    methods[method]=function(self,...) writes=writes+1; self["last"..method]={...} end
end
function methods:CreateFontString() return region() end
function methods:GetWidth() return self.lastSetSize[1] end
function methods:SetFont(...) fonts=fonts+1; self.lastFont={...}; return not fail end
local source={}
function source:GetCenter() centers=centers+1; if not floating then return state.x,state.y end end
function source:GetWidth() return state.width end
function source:GetHeight() return state.height end
function source:GetStatusBarTexture() return self end
function source:GetTexture() return state.texture end
function source:GetOrientation() return state.orientation end
function source:GetReverseFill() return state.reverse end
function source:GetStatusBarColor() return state.r,state.g,state.b,state.alpha end
function source:GetTextColor() return state.tr,state.tg,state.tb,state.ta end
local donor={gref={aux={source},auxtxt={source}}}
local api=setmetatable({HEALBOT_FOREVER=true,HealBot_issecretvalue=function() return false end,
    hbv_Aux_GetBarVar=function(_,_,id) return enabled and id==1 and 4 or 0 end,
    hbv_Aux_GetBarTextVar=function(key) return config[key] end,
    hbv_Skins_GetFrameVar=function() return 1 end,
    HealBot_Media_ResolveFont=function(_,height,outline) return resolvedFont,height,outline end,
    HealBot_Media_UpdateFont=function(text,name,height,outline) text:SetFont(resolvedFont,height,outline) end,
    HealBot_Forever_SkinArrivalAuras=function() auras=auras+1 end,
    CreateFrame=function() allocated=allocated+1; return region() end},{__index=_G})
local skin=setfenv(assert(loadstring(module.."\nframe=1; return SkinExtras")),api)()
local rows={}
for i=1,39 do rows[i]={healthBar={},unit="raid"..i} end
local function pass()
    local context={}
    for _,row in ipairs(rows) do skin(row,donor,context,20,15) end
end
pass()
assert(allocated==39 and fonts==39 and auras==0)
writes,fonts,centers,auras=0,0,0,0
for i=1,10 do pass() end
assert(writes==0 and fonts==0 and centers==10 and auras==0,
    ("ten unchanged passes: %d writes, %d font calls, %d donor center reads, %d aura refreshes"):format(writes,fonts,centers,auras))
local function changed(t,k,v)
    t[k]=v; writes,fonts=0,0; pass()
    assert(fonts==39 and writes>0,"missed style change: "..k)
end
for k,v in pairs({x=5,y=12,width=92,height=13,texture=654,orientation="VERTICAL",reverse=true,
    r=.35,g=.45,b=.55,alpha=.65,tr=.71,tg=.72,tb=.73,ta=.74}) do changed(state,k,v) end
for k,v in pairs({ALIGN=3,HOFFSET=5,OFFSET=-4,HEIGHT=16,OUTLINE=2}) do changed(config,k,v) end
resolvedFont="replacement.ttf"; fonts=0; pass(); assert(fonts==39)
local entry=rows[1].skinPower[1]
assert(entry.bar.lastSetPoint[4]==-15 and entry.bar.lastSetPoint[5]==-3 and entry.bar.lastSetSize[1]==92
    and entry.bar.lastSetStatusBarTexture[1]==654 and entry.text.lastSetPoint[1]=="RIGHT" and entry.text.lastSetWidth[1]==92
    and entry.text.lastFont[1]==resolvedFont and entry.text.lastSetTextColor[4]==.74 and entry.alpha==.65)
rows[1].healthBar={}; fonts=0; pass()
assert(fonts==1 and entry.bar.lastSetPoint[2]==rows[1].healthBar)
enabled=false; writes=0; pass(); assert(writes==39)
writes=0; pass(); assert(writes==0)
enabled=true; floating=true; pass(); assert(writes==0)
floating=false; fonts=0; pass(); assert(fonts==39 and allocated==39)
floating=true; writes=0; pass(); assert(writes==39)
floating=false; fail=true; fonts=0; pass(); assert(fonts==39)
fail=false; fonts=0; pass(); assert(fonts==39,"failed font was cached")
writes,fonts=0,0; pass(); assert(writes==0 and fonts==0 and allocated==39)
print("PASS: 39 reserve power bars, zero repeat writes in 10 roster passes; all style inputs, media changes, missing geometry, retired slots and recovery verified")
