-- Replay secure unit-watch visibility separately from addon Lua. A newcomer
-- can already have a clickable bar while the original panel remains one row tall.
local path=arg[1] or "HealBot/HealBot_ForeverPartyJoin.lua"
local file=assert(io.open(path,"rb"))
local source=file:read("*a"); file:close()
local baseline=arg[2]=="baseline"
local combat,raid=false,false
local units={player=true}
local frames,names,queue={},{},{}
local function noop() end
local function safe(f)
    assert(not combat or not f.protected,"addon changed protected geometry during combat")
end
local methods={}
local function frame(name,parent,protected)
    local f=setmetatable({name=name,parent=parent,protected=protected,shown=true,
        width=30,height=10,points={},hooks={},scripts={},events={}},{__index=methods})
    frames[#frames+1]=f
    if name then names[name]=f end
    return f
end
function methods:SetSize(w,h) safe(self); self.width,self.height=w,h end
function methods:GetWidth() return self.width end
function methods:GetHeight() return self.height end
function methods:GetEffectiveScale() return 1 end
function methods:SetPoint(a,p,b,x,y) safe(self); self.points[a]={a,p,b,x or 0,y or 0} end
function methods:SetAllPoints(p)
    safe(self); self.points={}
    self:SetPoint("TOPLEFT",p or self.parent,"TOPLEFT")
    self:SetPoint("BOTTOMRIGHT",p or self.parent,"BOTTOMRIGHT")
end
function methods:ClearAllPoints() safe(self); self.points={} end
function methods:GetNumPoints() local n=0; for _ in pairs(self.points) do n=n+1 end; return n end
function methods:GetPoint(i) local count=0; for _,p in pairs(self.points) do count=count+1; if i==count then return unpack(p) end end end
function methods:GetCenter()
    if self.cx then return self.cx,self.cy end
    local p=self.points.CENTER
    if p then local x,y=p[2]:GetCenter(); return x+p[4],y+p[5] end
end
function methods:GetLeft() local x=self:GetCenter(); return x-self.width/2 end
function methods:GetRight() local x=self:GetCenter(); return x+self.width/2 end
function methods:GetTop() local _,y=self:GetCenter(); return y+self.height/2 end
function methods:GetBottom() local _,y=self:GetCenter(); return y-self.height/2 end
function methods:IsShown() return self.shown end
function methods:IsVisible() return self.shown and (not self.parent or self.parent:IsVisible()) end
function methods:Hide() safe(self); self.shown=false end
function methods:Show() safe(self); self.shown=true end
function methods:HookScript(k,v)
    local previous=self.hooks[k]
    self.hooks[k]=previous and function(...) previous(...); v(...) end or v
end
function methods:SetScript(k,v) self.scripts[k]=v end
function methods:RegisterEvent(k) self.events[k]=true end
function methods:SetAttribute() safe(self) end
function methods:SetBackdrop(value) self.art=value end
function methods:SetFrameLevel(value) self.level=value end
function methods:EnableMouse(value) self.mouse=value end
function methods:CreateFontString() return frame(nil,self) end
function methods:CreateTexture() return frame(nil,self) end
for _,k in ipairs({"SetFrameStrata","RegisterUnitEvent","SetMinMaxValues","SetValue",
    "SetStatusBarColor","SetVertexColor","SetBackdropBorderColor","SetText","SetTextColor"}) do methods[k]=noop end

local player=frame(nil,nil,true)
player.cx,player.cy,player.frame,player.status,player.unit=100,100,1,{active=true},"player"
local style={BARS=1,GROW=0,SCALE=1,CMARGIN=2,RMARGIN=2,PADDING=0,NUMCOLS=1}
local env=setmetatable({_G=names,UIParent=frame(),HEALBOT_FOREVER=true,SlashCmdList={},
    HealBot_Globals={ForeverPartyJoin=true,OverrideColours={}},HealBot_Buttons={player},
    Healbot_Config_Skins={Current_Skin="test",HealGroups={test={}}},
    InCombatLockdown=function() return combat end,IsInRaid=function() return raid end,
    UnitExists=function(unit) return units[unit] end,UnitIsUnit=function(a,b) return a==b end,
    UnitClass=function() return "Druid","DRUID" end,UnitGroupRolesAssigned=function() return "NONE" end,
    UnitInRange=function() return true,true end,UnitName=function() return "Member" end,
    HealBot_issecretvalue=function() return false end,HealBot_Action_ClassColour=function() return 1,1,1 end,
    hbv_Skins_GetRoleCol=function() return 1,1,1 end,hbv_Skins_GetFrameBoolean=function() return false end,
    HealBot_WoWAPI_UnitHealth=function() return 100,100,1,100,0,0,1 end,
    HealBot_retLuVars=function() return true end,HealBot_Media_retLuVars=function() return true end,
    hbv_Skins_GetFrameVar=function(_,key) return style[key] or 1 end,hooksecurefunc=noop,
    C_Timer={After=function(_,cb) queue[#queue+1]=cb end},
    CreateFrame=function(_,name,parent,template)
        assert(not combat,"created frame in combat")
        return frame(name,parent,template and template:find("Secure",1,true))
    end,
    RegisterUnitWatch=function(row) safe(row); row.watch=true end,
    UnregisterUnitWatch=function(row) safe(row); row.watch=false end,
    RegisterStateDriver=function(panel,_,driver) safe(panel); panel.driver=driver end,
    UnregisterStateDriver=function(panel) safe(panel); panel.driver=nil end,
},{__index=_G})
local action=assert(io.open(path:gsub("HealBot_ForeverPartyJoin.lua$","HealBot_Action.lua"),"rb"))
local text=action:read("*a"):gsub("\r\n","\n"); action:close()
local block=assert(text:match('(grpFrame%[x%]=CreateFrame%("Frame", "f"%.%.x%.%."_HealBot_Action".-)\n%s*grpFrameText%[1000%+x%]'))
env.BackdropTemplateMixin=true
local main=setfenv(assert(loadstring("local x,grpFrame=1,{}\n"..block.."\nreturn grpFrame[x]")),env)()
local bg=main.hbArrivalBackdrop or main
assert(bg.art and bg.art.bgFile and bg.art.edgeFile,"panel artwork lacks its configured backdrop")
if not baseline then assert(bg.parent==main and not bg.protected and bg.mouse==false,"backdrop can capture input or change protected layout") end
main.cx,main.cy,main.width,main.height=100,100,40,20
player.parent=main
-- Skin art and click bindings are outside this geometry replay. CreateRow,
-- Sync, placement, event routing, OnShow/OnHide and visual updates are real.
local sync=setfenv(assert(loadstring(source..[[
    ApplySkin=function() end
    BindRow=function(row) row.bindingGeneration=bindingGeneration end
    FindSkinDonor=function() end
    return Sync
]])),env)()
local function pulse(event)
    local was={}
    for _,f in ipairs(frames) do was[f]=f:IsVisible() end
    for _,f in ipairs(frames) do
        if f.driver then
            local matches=f.driver:find("nogroup:raid",1,true) and not raid
                or f.driver:find(",group:raid",1,true) and raid
            f.shown=combat and matches or false
        end
        if f.watch then f.shown=not not units[f.unit] end
    end
    for _,f in ipairs(frames) do
        local now=f:IsVisible()
        local hook=f.hooks[now and "OnShow" or "OnHide"]
        if was[f]~=now and hook then hook(f) end
    end
    for _,f in ipairs(frames) do
        if f.events[event] and f.scripts.OnEvent then f.scripts.OnEvent(f,event) end
    end
    while #queue>0 do table.remove(queue,1)() end
end
local function assertCoverage(row)
    assert(row and row:IsVisible(),"newcomer secure bar failed to appear")
    local tl,br=bg.points.TOPLEFT,bg.points.BOTTOMRIGHT
    if not baseline then assert(tl and br and tl[2]==main and br[2]==main) end
    local left,right=tl and tl[4] or 0,br and br[4] or 0
    local top,bottom=tl and tl[5] or 0,br and br[5] or 0
    local covered=main:GetLeft()+left<=row:GetLeft() and main:GetRight()+right>=row:GetRight()
        and main:GetTop()+top>=row:GetTop() and main:GetBottom()+bottom<=row:GetBottom()
    assert(covered~=baseline,"visible newcomer fell outside the painted panel")
end
local function ordinarySize()
    for _,p in pairs(bg.points) do assert(p[4]==0 and p[5]==0,"empty roster left backdrop expanded") end
end
sync(); pulse("PLAYER_REGEN_ENABLED"); ordinarySize()
combat=true; units.party1=true; pulse("GROUP_ROSTER_UPDATE"); assertCoverage(names.HealBotForeverJoinparty1)
units.party1=nil; pulse("GROUP_ROSTER_UPDATE"); ordinarySize()
units.party1=true; pulse("GROUP_ROSTER_UPDATE")
-- A group that converts during lockdown leaves the old pool. Its stale
-- party backdrop must retire, and the first unlocked pass prepares raid slots.
raid=true; units.party1=nil; units.raid1=true; pulse("GROUP_ROSTER_UPDATE")
assert(not names.HealBotForeverJoinparty1:IsVisible(),"converted group kept its party-only secure row")
ordinarySize()
combat=false; pulse("PLAYER_REGEN_ENABLED")
assert(names.HealBotForeverJoinraid2 and not names.HealBotForeverJoinraid2:IsVisible(),"unlocked conversion did not prepare the new raid pool")
ordinarySize()
combat=true; units.raid2=true; pulse("GROUP_ROSTER_UPDATE"); assertCoverage(names.HealBotForeverJoinraid2)
units.raid2=nil; units.raid3=true; pulse("GROUP_ROSTER_UPDATE")
assert(not names.HealBotForeverJoinraid2:IsVisible()); assertCoverage(names.HealBotForeverJoinraid3)
combat=false; pulse("PLAYER_REGEN_ENABLED")
assert(not names.HealBotForeverJoinraid3:IsVisible(),"ordinary raid takeover left a duplicate")
ordinarySize()
print((baseline and "BASELINE: uncovered" or "PASS: covered").." secure combat arrivals, slot changes, removal and panel handoff without protected geometry writes")
