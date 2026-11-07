local passed=0
local function eq(actual, expected, label)
    assert(actual==expected, label..": expected "..tostring(expected)..", got "..tostring(actual))
    passed=passed+1
end
local function read(path)
    local f=assert(io.open(path,"rb"))
    local s=f:read("*a"):gsub("\r\n","\n"):gsub("^\239\187\191",""); f:close(); return s
end
local combat=false
local hooks,containers,events,errors={},{},{},{}
local noop=function() end
local function onlyOOC() assert(not combat,"protected setup attempted in combat") end
local function region()
    return {SetAllPoints=noop,SetTexCoord=noop}
end
local function frame(kind,parent)
    if kind=="AuraContainer" then onlyOOC() end
    local f={kind=kind,parent=parent,shown=false}
    function f:SetPoint(...) onlyOOC(); self.point={...} end
    f.ClearAllPoints=noop
    function f:SetFlowLayoutAnchorPoint(v) onlyOOC(); self.anchor=v end
    function f:SetFlowLayoutGrowthDirection(h,v) onlyOOC(); self.h=h; self.v=v end
    function f:SetFlowLayoutAxis(v) onlyOOC(); self.axis=v end
    function f:SetFlowLayoutMaximumLineSize(v) onlyOOC(); self.maxLine=v end
    function f:SetFrameLevel(v) self.level=v end
    function f:SetMouseClickEnabled(v) self.click=v end
    function f:SetMouseMotionEnabled(v) self.motion=v end
    function f:SetUnit(v) self.unit=v end
    function f:SetEnabled(v) onlyOOC(); assert(self.options and self.unit); self.enabled=v end
    function f:SetShown(v) self.shown=v end
    function f:Hide() self.shown=false end
    f.UpdateAllAuras=noop
    function f:RegisterEvent(name) events[name]=self end
    function f:SetScript(_,fn) self.onEvent=fn end
    function f:AddAuraGroup(key,filter,options)
        onlyOOC(); self.key=key; self.filter=filter; self.options=options
        local b={CreateTexture=region,SetSize=noop,SetIcon=noop,SetDurationCooldown=noop,
                 SetMouseClickEnabled=self.SetMouseClickEnabled,SetMouseMotionEnabled=self.SetMouseMotionEnabled}
        options.initializeFrame(b); self.auraButton=b
    end
    f.SetAllPoints=noop; f.SetReverse=noop; f.SetDrawEdge=noop; f.SetHideCountdownNumbers=noop
    if kind=="AuraContainer" then containers[#containers+1]=f end
    return f
end
local double=false
local spacing=3
local env=setmetatable({
    HEALBOT_MIDNIGHT=true, HealBot_Globals={}, SlashCmdList={},
    InCombatLockdown=function() return combat end,
    CreateFrame=function(kind,_,parent) return frame(kind,parent) end,
    hooksecurefunc=function(name,fn) hooks[name]=fn end,
    hbv_Skins_GetIconVar=function() return spacing end,
    hbv_Skins_GetIconBoolean=function() return double end,
    AnchorUtil={FlowDirection={Left=-1,Right=1,Up=1,Down=-1},FlowLayoutAxis={Horizontal=0,Vertical=1}},
    pcall=function(fn,...)
        local ok,result=pcall(fn,...)
        if not ok then errors[#errors+1]=result end
        return ok,result
    end,
    print=noop,
}, {__index=_G})
setfenv(assert(loadstring(read("HealBot/HealBot_CombatAuras.lua"))),env)()
local function fire(name) events[name].onEvent(events[name],name) end
local function button()
    local b={unit="party1",frame=1,status={events=true},gref={icon={}},GetFrameLevel=function() return 5 end,IsShown=function() return true end}
    local hot={"TOPRIGHT",b,"TOPRIGHT",-4,7}
    local db={"BOTTOMRIGHT",b,"BOTTOMLEFT",-6,-3}
    b.gref.icon[1]={GetPoint=function() return unpack(hot) end}
    b.gref.icon[51]={GetPoint=function() return unpack(db) end}
    return b,hot,db
end
fire("PLAYER_LOGIN")
local b,hotPoint,dbPoint=button()
hooks.HealBot_Action_RegisterUnitEvents(b)
local hot,db=containers[#containers-1],containers[#containers]
eq(hot.point[1],"TOPRIGHT","buff uses skin corner")
eq(hot.point[2],b,"buff relative frame")
eq(hot.point[4],-4,"buff horizontal offset")
eq(hot.point[5],7,"buff vertical offset")
eq(hot.anchor,"TOPRIGHT","native layout origin matches anchor")
eq(hot.h,-1,"top-right grows left")
eq(hot.v,-1,"top-right grows down")
eq(hot.axis,0,"single row horizontal")
eq(hot.maxLine,nil,"single row does not wrap")
eq(db.point[1],"BOTTOMRIGHT","debuff uses outside icon edge")
eq(db.point[3],"BOTTOMLEFT","debuff stays outside left of bar")
eq(db.h,-1,"outside-left grows away from bar")
eq(db.v,1,"bottom anchor grows up")
eq(hot.options.layout.elementSpacing,3,"skin spacing")
eq(hot.options.layout.elementWidth,12,"existing combat size retained")
eq(hot.filter,"HELPFUL|PLAYER","HoT filter retained")
eq(db.filter,"HARMFUL","debuff filter retained")
eq(hot.options.candidateFilters.maxDuration,120,"duration filter retained")
eq(hot.auraButton.click,false,"aura icons pass clicks through")
eq(hot.click,false,"container passes clicks through")
eq(hot.shown,false,"combat icons hidden outside combat")
local count=#containers
hooks.HealBot_Skins_ResetSkin("bar",b)
eq(#containers,count,"unchanged skin reuses containers")
hotPoint[1]="BOTTOMLEFT"; hotPoint[3]="BOTTOM"; hotPoint[4]=8; hotPoint[5]=-5
double=true; spacing=2
hooks.HealBot_Skins_ResetSkin("bar",b)
eq(#containers,count+2,"changed skin rebuilds outside combat")
eq(hot.shown,false,"old container stays hidden")
hot=containers[#containers-1]
eq(hot.point[3],"BOTTOM","centred skin anchor retained")
eq(hot.point[4],8,"new offset applied")
eq(hot.h,1,"bottom-left grows right")
eq(hot.v,1,"bottom-left grows up")
eq(hot.axis,1,"double layout fills columns")
eq(hot.maxLine,26,"double layout fits two icons plus spacing")
combat=true; fire("PLAYER_REGEN_DISABLED")
eq(hot.shown,true,"icons appear in combat")
count=#containers
hotPoint[1]="TOPLEFT"; hotPoint[3]="BOTTOMLEFT"; hotPoint[5]=-10
hooks.HealBot_Skins_ResetSkin("bar",b)
eq(#containers,count,"skin changes do not create containers in combat")
eq(hot.point[1],"BOTTOMLEFT","active layout unchanged during combat")
local newButton=button()
hooks.HealBot_Action_RegisterUnitEvents(newButton)
eq(#containers,count,"new button deferred in combat")
combat=false; fire("PLAYER_REGEN_ENABLED")
eq(#containers,count+4,"both deferred buttons built at combat exit")
eq(hot.shown,false,"previous layout hidden on exit")
local replacement
for _,c in ipairs(containers) do
    if c.parent==b and c.key=="hbcahot" then replacement=c end
end
eq(replacement.point[1],"TOPLEFT","deferred anchor applied")
eq(replacement.point[3],"BOTTOMLEFT","below-bar placement retained")
eq(replacement.v,-1,"below-bar icons grow down")
eq(replacement.shown,false,"rebuilt icons hidden outside combat")
count=#containers; b.unit="party2"
hooks.HealBot_Action_RegisterUnitEvents(b)
eq(#containers,count,"unit change reuses same layout")
eq(replacement.unit,"party2","unit change retargets container")
combat=true; fire("PLAYER_REGEN_DISABLED")
hooks.HealBot_Action_UnregisterUnitEvents(b)
eq(replacement.shown,false,"unregistered button hidden")
eq(#errors,0,"no swallowed API errors or protected setup calls")
combat=false; fire("PLAYER_REGEN_ENABLED")
b.gref.icon[1].GetWidth=function() return 24 end
b.gref.icon[51].GetWidth=function() return 18 end
hooks.HealBot_Skins_ResetSkin("bar",b)
local function latest(side)
    local found
    for _,c in ipairs(containers) do if c.parent==b and c.key=="hbca"..side then found=c end end
    return found
end
eq(latest("hot").options.layout.elementWidth,24,"buff skin size followed")
eq(latest("db").options.layout.elementWidth,18,"debuff skin size followed separately")
eq(latest("hot").maxLine,50,"double layout uses skin size")
env.SlashCmdList.HBCOMBATAURAS("size 20")
eq(latest("hot").options.layout.elementWidth,20,"manual size remains available")
env.SlashCmdList.HBCOMBATAURAS("size skin")
eq(latest("hot").options.layout.elementWidth,24,"skin size can be restored")
combat=true
b.gref.icon[1].GetWidth=function() return 28 end
hooks.HealBot_Skins_ResetSkin("bar",b)
eq(latest("hot").options.layout.elementWidth,24,"size change deferred during combat")
combat=false;fire("PLAYER_REGEN_ENABLED")
eq(latest("hot").options.layout.elementWidth,28,"size refreshed after combat")
eq(#errors,0,"size setup has no API errors")

-- A disabled row must not prevent the other row from being retargeted.
env.SlashCmdList.HBCOMBATAURAS("hots 0")
b.unit="party3"
combat=true; fire("PLAYER_REGEN_DISABLED")
eq(latest("db").unit,"party3","debuff-only row follows changed unit")
eq(latest("db").shown,true,"debuff-only row visible in combat")
combat=false; fire("PLAYER_REGEN_ENABLED")
env.SlashCmdList.HBCOMBATAURAS("hots 4")
env.SlashCmdList.HBCOMBATAURAS("debuffs 0")
b.unit="party4"
combat=true; fire("PLAYER_REGEN_DISABLED")
eq(latest("hot").unit,"party4","HoT-only row follows changed unit")
eq(latest("hot").shown,true,"HoT-only row visible in combat")
eq(#errors,0,"disabled rows do not raise swallowed nil errors")

-- Registration may change while already in combat. Reuse existing widgets;
-- hiding on unregister must last until the button is registered again.
local current=latest("hot")
count=#containers
b.status.events=false
hooks.HealBot_Action_UnregisterUnitEvents(b)
eq(current.shown,false,"unregister hides current row")
combat=false; fire("PLAYER_REGEN_ENABLED")
combat=true; fire("PLAYER_REGEN_DISABLED")
eq(current.shown,false,"unregistered row stays hidden next combat")
b.status.events=true
hooks.HealBot_Action_RegisterUnitEvents(b)
eq(current.shown,true,"re-register same unit restores row in combat")
b.unit="party1"
hooks.HealBot_Action_RegisterUnitEvents(b)
eq(current.unit,"party1","existing row retargets during combat")
eq(current.shown,true,"retargeted row remains visible")
eq(#containers,count,"combat retarget does not create widgets")

-- A rejected native SetUnit must hide stale auras and recover after combat.
local setUnit=current.SetUnit
current.SetUnit=function() error("injected SetUnit failure") end
b.unit="party2"
hooks.HealBot_Action_RegisterUnitEvents(b)
eq(current.shown,false,"failed retarget hides old unit's auras")
eq(#errors,1,"retarget failure is contained")
current.SetUnit=setUnit
combat=false; fire("PLAYER_REGEN_ENABLED")
eq(current.unit,"party2","failed combat retarget retries after combat")
combat=true; fire("PLAYER_REGEN_DISABLED")
eq(current.shown,true,"recovered row returns next combat")
eq(#errors,1,"no unexpected API errors during recovery")
print("PASS: "..passed.." combat aura layout assertions (mock native widgets)")
