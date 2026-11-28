-- Verify the visible party/raid panel bounds for every corner and growth
-- direction, including a reserve at a different effective scale.
local function source(path)
    local f=assert(io.open(path,"rb")); local code=f:read("*a"):gsub("\r\n","\n"); f:close(); return code
end
local party=source("HealBot/HealBot_ForeverPartyJoin.lua")
local tint=assert(source("HealBot/HealBot_Action.lua"):match("(function HealBot_Action_SetFrameColours%(frame%).-\nend)"))
local noop=function() end
local style={BARS=1,GROW=0,SCALE=1,CMARGIN=2,RMARGIN=3,PADDING=2,NUMCOLS=1}
local combat=false
local art={writes=0}
function art:ClearAllPoints() self.writes=self.writes+1; self.points={} end
function art:SetPoint(...) self.points[#self.points+1]={...} end
function art:SetAllPoints(parent) self.points={{"ALL",parent}} end
function art:SetBackdropColor(...) self.bg={...} end
function art:SetBackdropBorderColor(...) self.edge={...} end
local main={hbArrivalBackdrop=art,id=1}
function main:GetCenter() return 100,150 end
function main:GetWidth() return 60 end
function main:GetHeight() return 30 end
function main:GetEffectiveScale() return 1 end
main.SetPoint=function() error("repositioned secure panel") end
main.SetSize=function() error("resized secure panel") end
local unit={frame=1,status={active=true}}
function unit:GetCenter() return 100,150 end
function unit:GetWidth() return 40 end
function unit:GetHeight() return 12 end
function unit:IsShown() return true end
local rows={}
local ratio=1
for i=1,4 do
    local row={unit="party"..i,reserve=true,shown=false}
    row.GetWidth,row.GetHeight=unit.GetWidth,unit.GetHeight
    function row:GetNumPoints() return self.anchor and 1 or 0 end
    function row:GetPoint() return unpack(self.anchor) end
    function row:ClearAllPoints() assert(not combat); self.anchor=nil end
    function row:SetPoint(...) assert(not combat); self.anchor={...} end
    function row:GetEffectiveScale() return ratio end
    function row:IsVisible() return self.shown end
    rows[i]=row
end
local timers={}
local env=setmetatable({HEALBOT_FOREVER=true,_G={f1_HealBot_Action=main},HealBot_Buttons={unit},
    SlashCmdList={},hooksecurefunc=noop,C_Timer={After=function(_,cb) timers[#timers+1]=cb end},
    CreateFrame=function() return {RegisterEvent=noop,SetScript=noop} end,UnitExists=function() return false end,
    hbv_Skins_GetFrameVar=function(_,key) assert(style[key],key); return style[key] end,
},{__index=_G})
local place,schedule=setfenv(assert(loadstring(party..[[
rows=...; frame=1; rosterMode="party"; return PositionReservedRows,QueueBackdrop
]])),env)(rows)
local function drain()
    assert(#timers==1,"join/leave notifications did not coalesce")
    timers[1](); timers={}
end
local function verify(first,last)
    local l,t,r,b=0,0,0,0
    for i=first,last do
        local row=rows[i]; local x,y=row.anchor[4]*ratio,row.anchor[5]*ratio
        l=math.min(l,x-row:GetWidth()*ratio/2-7+30)
        t=math.max(t,y+row:GetHeight()*ratio/2+7-15)
        r=math.max(r,x+row:GetWidth()*ratio/2+7-30)
        b=math.min(b,y-row:GetHeight()*ratio/2-7+15)
    end
    assert(art.joinLeft==l and art.joinTop==t and art.joinRight==r and art.joinBottom==b,"incorrect bounds")
    if l==0 and t==0 and r==0 and b==0 then assert(art.points[1][1]=="ALL")
    else assert(art.points[1][1]=="TOPLEFT" and art.points[2][1]=="BOTTOMRIGHT") end
end
for _,scale in ipairs({1,.8}) do
    ratio=scale
    for _,grow in ipairs({0,1}) do
        for corner=1,4 do
            combat=false; style.GROW,style.BARS=grow,corner
            assert(place())
            combat=true
            rows[1].shown=true; schedule(rows[1]); drain(); verify(1,1)
            rows[2].shown=true; schedule(rows[2]); rows[3].shown=true; schedule(rows[3]); drain(); verify(1,3)
            local writes=art.writes
            schedule(rows[1]); drain(); assert(art.writes==writes,"unchanged bounds were rewritten")
            rows[3].shown=false; schedule(rows[3]); drain(); verify(1,2)
            rows[1].shown=false; rows[2].shown=false; schedule(rows[2]); drain(); verify(1,0)
        end
    end
end
env.HealBot_Action_luVars={GlobalDimmingEnabled=true,GlobalDimming=2}
env.HealBot_Action_IsFrameActive=function() return false end
for k,v in pairs({BACKR=.1,BACKG=.2,BACKB=.3,BACKA=.8,BORDERR=.4,BORDERG=.5,BORDERB=.6,BORDERA=.9}) do style[k]=v end
setfenv(assert(loadstring(tint)),env)()
env.HealBot_Action_SetFrameColours(main)
assert(art.bg[1]==.1 and art.bg[4]==.4 and art.edge[3]==.6 and art.edge[4]==.45)
env.HealBot_Action_luVars.GlobalDimmingEnabled=false
env.HealBot_Action_SetFrameColours(main)
assert(art.bg[4]==.8 and art.edge[4]==.9)
local legacy={id=1,SetBackdropColor=art.SetBackdropColor,SetBackdropBorderColor=art.SetBackdropBorderColor}
env.HealBot_Action_SetFrameColours(legacy)
assert(legacy.bg[4]==.8 and legacy.edge[4]==.9)
print("PASS: party panel artwork tracks arrivals/departures, eight growth arrangements, relative scales, padding and skin dimming without secure writes")
