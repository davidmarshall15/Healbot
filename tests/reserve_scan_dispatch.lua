-- Count scans at the shared aura engine's entry points during real reserve
-- frame events. Timers advance explicitly to distinguish coalescing within a
-- frame from repeatedly rescanning an unchanged roster across frames.
local sourceFile=assert(io.open("HealBot/HealBot_ForeverPartyJoin.lua","rb"))
local source=sourceFile:read("*a"); sourceFile:close()
local noop=function() end
local combat,opaque=false,{}
local timers,guids,roles,groups,buffs,debuffs={},{},{},{},{},{}
local totalQueued,now=0,1
local widgetMethods={}
local function widget()
    assert(not combat,"combat event allocated a widget")
    return setmetatable({scripts={},events={},visible=false},{__index=widgetMethods})
end
for _,method in ipairs({"SetAllPoints","EnableMouse","SetMinMaxValues","SetValue","SetStatusBarColor",
    "SetTextColor","SetText","SetBackdropBorderColor","SetVertexColor"}) do widgetMethods[method]=noop end
function widgetMethods:SetAttribute() assert(not combat,"combat event changed a secure attribute") end
function widgetMethods:SetScript(event,fn) self.scripts[event]=fn end
widgetMethods.HookScript=widgetMethods.SetScript
function widgetMethods:RegisterEvent(event) self.events[event]=true end
function widgetMethods:RegisterUnitEvent(event,unit) self.events[event]=unit end
function widgetMethods:IsVisible() return self.visible end
function widgetMethods:Hide() self.visible=false; if self.scripts.OnHide then self.scripts.OnHide(self) end end
function widgetMethods:Show() self.visible=true; if self.scripts.OnShow then self.scripts.OnShow(self) end end
widgetMethods.CreateTexture=widget
widgetMethods.CreateFontString=widget
local function count(tab,unit) tab[unit]=(tab[unit] or 0)+1 end
local function total(tab)
    local n=0; for _,v in pairs(tab) do n=n+v end; return n
end
local function drain()
    now=now+1/60
    for turn=1,8 do
        if #timers==0 then return end
        local current=timers
        timers={}
        for _,cb in ipairs(current) do cb() end
    end
    error("timer callbacks continuously requeued without any new event")
end
local function yes() return true end
local env=setmetatable({
    HEALBOT_FOREVER=true,SlashCmdList={},hooksecurefunc=noop,CreateFrame=widget,
    HealBot_Globals={OverrideColours={}},HealBot_Data={PLAYERGROUP=1},
    C_Timer={After=function(_,fn) timers[#timers+1]=fn; totalQueued=totalQueued+1 end},
    HealBot_issecretvalue=function(v) return rawequal(v,opaque) end,
    InCombatLockdown=function() return combat end,GetTime=function() return now end,
    HealBot_Panel_IsTank=function(unit) return roles[unit]=="TANK" end,
    UnitExists=yes,UnitIsConnected=yes,UnitIsVisible=yes,UnitIsDeadOrGhost=function() return false end,
    UnitGUID=function(unit) return guids[unit] end,UnitName=function() return "Member" end,
    UnitClass=function() return "Warrior","WARRIOR" end,UnitLevel=function() return 40 end,
    UnitGroupRolesAssigned=function(unit) return roles[unit] or "DAMAGER" end,
    UnitPowerType=function() return 1,"RAGE" end,UnitInRange=function() return true,true end,
    UnitIsUnit=function(a,b) return a==b end,
    GetRaidRosterInfo=function(slot) return nil,nil,groups[slot] or 1 end,
    HealBot_WoWAPI_UnitMana=function() return 30,100,30 end,
    HealBot_WoWAPI_UnitHealth=function() return 70,100,.7,70,0,.3,.7 end,
    HealBot_Action_ClassColour=function() return .7,.6,.5 end,
    hbv_Skins_GetRoleCol=function() return .7,.6,.5 end,hbv_Skins_GetFrameVar=function() return 1 end,
    hbv_Skins_GetFrameBoolean=function() return false end,
    HealBot_Aura_InitReserveWarnings=noop,
    HealBot_Aura_CheckUnitBuffs=function(b) count(buffs,b.unit) end,
    HealBot_Aura_CheckUnitDebuffs=function(b) count(debuffs,b.unit) end,
    HealBot_Events_UnitAura=function(b,unit,info)
        assert(b.unit==unit)
        if info.helpful then b.event.buff=true end
        if info.harmful then b.event.debuff=true end
    end,
},{__index=_G})
local module=setfenv(assert(loadstring(source..[[
    frame=1
    for i=1,40 do rows[i]=CreateRow("raid",i); rows[i].reserve=true end
    return rows,events
]])),env)
local rows,world=module()
local function dispatch(i,event,info)
    local row=rows[i]
    if row.events[event]==row.unit then row.scripts.OnEvent(row,event,row.unit,info) end
end
local function broadcast(event)
    assert(world.events[event]); world.scripts.OnEvent(world,event)
end
combat=true
for i=1,4 do guids[rows[i].unit]="member-"..i; rows[i]:Show() end
drain()
assert(total(buffs)==4 and total(debuffs)==4)
local queued=totalQueued
for n=1,25 do
    for i=1,40 do
        for _,event in ipairs({"UNIT_HEALTH","UNIT_MAXHEALTH","UNIT_POWER_UPDATE","UNIT_MAXPOWER"}) do dispatch(i,event) end
    end
    drain()
end
assert(totalQueued==queued and total(buffs)==4 and total(debuffs)==4,"health/power update scheduled an aura scan")
for n=1,12 do broadcast("GROUP_ROSTER_UPDATE"); drain() end
assert(total(buffs)==4 and total(debuffs)==4,"stable roster repeatedly rescanned visible reserve members")
guids.raid2="replacement"
broadcast("GROUP_ROSTER_UPDATE"); drain()
assert(buffs.raid2==2 and debuffs.raid2==2 and total(buffs)==5 and total(debuffs)==5,"one replaced member rescanned its neighbors")
for n=1,20 do
    dispatch(3,"UNIT_AURA",{helpful=true})
    dispatch(3,"UNIT_AURA",{harmful=true})
    dispatch(10,"UNIT_AURA",{helpful=true,harmful=true})
end
drain()
assert(buffs.raid3==2 and debuffs.raid3==2 and total(buffs)==6 and total(debuffs)==6,"aura burst was not coalesced per visible member")
dispatch(3,"UNIT_AURA",{helpful=true}); drain()
assert(buffs.raid3==3 and debuffs.raid3==2,"one-family delta scanned both families")
for n=1,12 do broadcast("ADDON_RESTRICTION_STATE_CHANGED") end
drain()
assert(total(buffs)==11 and total(debuffs)==10,"restriction changes should recheck each visible member once per batch")
guids.raid1=opaque
for n=1,12 do broadcast("GROUP_ROSTER_UPDATE") end
drain()
assert(total(buffs)<=12 and total(debuffs)<=11,"one protected roster slot caused repeated scans or invalidated other slots")
dispatch(4,"UNIT_AURA",{helpful=true})
rows[4]:Hide()
local before=buffs.raid4; drain()
assert(buffs.raid4==before,"a queued update scanned a hidden member")
guids.raid1="visible-again"
broadcast("GROUP_ROSTER_UPDATE"); drain()
local b,d=total(buffs),total(debuffs)
groups[2]=2; roles.raid2="TANK"
broadcast("GROUP_ROSTER_UPDATE"); drain()
assert(total(buffs)==b+1 and total(debuffs)==d+1,"a member's role/subgroup change must update only that member")
b,d=total(buffs),total(debuffs)
env.HealBot_Data.PLAYERGROUP=2
broadcast("GROUP_ROSTER_UPDATE"); drain()
assert(total(buffs)==b+3 and total(debuffs)==d+3,"player subgroup changes must reevaluate party watches on every visible member")
print("PASS: active reserve warning scans stay bounded during unit events, roster churn, combat restrictions and slot reuse")
