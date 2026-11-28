local input=assert(io.open(arg[1] or "HealBot/HealBot_ForeverPartyJoin.lua","rb"))
local code=input:read("*a"); input:close()
local baseline=arg[2]=="baseline"
local mx,my,bx,by=100,100,75,90
local style={BARS=1,GROW=0,SCALE=1,CMARGIN=2,RMARGIN=3,PADDING=0,NUMCOLS=2}
local function size()
    return {GetWidth=function() return 30 end,GetHeight=function() return 10 end}
end
local main,used=size(),size()
function main:GetCenter() return mx,my end
function used:GetCenter() return bx,by end
function used:IsShown() return true end
used.frame,used.status=1,{active=true}
local rows,known={},{}
local writes,clears=0,0
for i=1,40 do
    local row=size()
    row.unit="raid"..i
    row.points={}
    function row:GetNumPoints() return #self.points end
    function row:GetPoint(i) return unpack(self.points[i]) end
    function row:ClearAllPoints() clears=clears+1; self.points={} end
    function row:SetPoint(...) writes=writes+1; self.points[#self.points+1]={...} end
    rows[i]=row
end
known.raid1=true
local noop=function() end
local env=setmetatable({HEALBOT_FOREVER=true,SlashCmdList={},hooksecurefunc=noop,HealBot_Buttons={used},
    hbv_Skins_GetFrameVar=function(_,key) assert(style[key],key); return style[key] end,
    CreateFrame=function() return {RegisterEvent=noop,SetScript=noop} end,
    UnitExists=function(unit) return known[unit] end,
    _G={f1_HealBot_Action=main}}, {__index=_G})
local position=setfenv(assert(loadstring(code.."\nrows=...; frame=1; rosterMode='raid'; return PositionReservedRows")),env)(rows)
local function pass(expected)
    writes,clears=0,0
    assert(position())
    assert(clears==writes and writes==expected,"expected "..expected.." anchors, got "..writes)
end
local function verify()
    local coords={}
    for i=2,40 do
        local point,relative,relativePoint,x,y=rows[i]:GetPoint(1)
        assert(rows[i]:GetNumPoints()==1 and point=="CENTER" and relative==main and relativePoint=="CENTER")
        local k=x..","..y
        assert(not coords[k] and (x+mx~=bx or y+my~=by),"overlapping reserve or occupied grid position")
        coords[k]=true
    end
    assert(rows[1]:GetNumPoints()==0,"occupied row was repositioned")
end
pass(39); verify()
for _,grow in ipairs({0,1}) do
    for corner=1,4 do
        style.BARS,style.GROW=corner,grow
        position(); verify()
        pass(baseline and 39 or 0)
    end
end
local x=rows[40].points[1][4]
bx=bx+11
pass(39); verify()
assert(rows[40].points[1][4]==x+11)
rows[40].points[1][2]=used
rows[2].points[1][3]="RIGHT"
rows[13].points[2]={"LEFT",main,"RIGHT",2,3}
pass(baseline and 39 or 3); verify()
known.raid12=true
local old=rows[12].points[1]
position();assert(rows[12].points[1]==old)
known.raid12=nil; position();verify()
main.GetCenter=function() return nil end
writes=0;assert(not position() and writes==0)
print((baseline and "BASELINE: 39" or "PASS: zero").." redundant ClearAllPoints/SetPoint pairs per warmed 39-slot pass; all eight growth/corner combinations, roster move, anchor repair and unavailable panel checked")
