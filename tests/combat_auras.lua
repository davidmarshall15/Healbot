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
local failEnable=false
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
    function f:SetEnabled(v)
        onlyOOC(); assert(self.options and self.unit)
        if failEnable then error("injected SetEnabled failure") end
        self.enabled=v
    end
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
    f.SetAllPoints=noop; f.SetReverse=noop; f.SetDrawEdge=noop
    function f:SetHideCountdownNumbers(v) self.hideNumbers=v end
    if kind=="AuraContainer" then containers[#containers+1]=f end
    return f
end
local double=false
local spacing=3
local env=setmetatable({
    HEALBOT_MIDNIGHT=true, HealBot_Globals={CombatAurasNums=false}, SlashCmdList={},
    InCombatLockdown=function() return combat end,
    CreateFrame=function(kind,_,parent) return frame(kind,parent) end,
    hooksecurefunc=function(name,fn) hooks[name]=fn end,
    hbv_Skins_GetIconVar=function() return spacing end,
    hbv_Skins_GetIconBoolean=function() return double end,
    hbv_Skins_GetIconTextBoolean=function(key) return key=="BUFFSDUR" end,
    HealBot_Aura_NativeBuffExclusions=function() return {[12345]=true} end,
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
local buttons={}
local function button()
    local b={unit="party1",frame=1,status={events=true},gref={icon={}},GetFrameLevel=function() return 5 end,IsShown=function() return true end}
    local hot={"TOPRIGHT",b,"TOPRIGHT",-4,7}
    local db={"BOTTOMRIGHT",b,"BOTTOMLEFT",-6,-3}
    b.gref.icon[1]={GetWidth=function() return 12 end,GetPoint=function() return unpack(hot) end}
    b.gref.icon[51]={GetWidth=function() return 12 end,GetPoint=function() return unpack(db) end}
for i=1,12 do
 b.gref.icon[i]=b.gref.icon[i] or {}
 b.gref.icon[i].SetShown=noop
end
b.gref.iconf=setmetatable({}, {__index=function() return {SetShown=noop,SetFrameLevel=noop,SetAlpha=noop,SetText=noop} end})
b.gref.txt={expire=setmetatable({},getmetatable(b.gref.iconf)),count=setmetatable({},getmetatable(b.gref.iconf))}
b.gref.indicator={selfcast=b.gref.iconf}
    buttons[#buttons+1]=b
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
eq(hot.options.candidateFilters.excludeSpellIDs[12345],true,"disabled buff passed to native filter")
eq(hot.auraButton.hbcaCD.hideNumbers,false,"buff timer follows skin")
eq(db.auraButton.hbcaCD.hideNumbers,true,"debuff timer independently follows skin")
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
combat=false
env.SlashCmdList.HBCOMBATAURAS("nums off")
eq(latest("hot").auraButton.hbcaCD.hideNumbers,true,"explicit off overrides skin")
env.SlashCmdList.HBCOMBATAURAS("nums skin")
eq(latest("hot").auraButton.hbcaCD.hideNumbers,false,"skin mode restores buff timer")
env.SlashCmdList.HBCOMBATAURAS("debuffs 3")
combat=true; fire("PLAYER_REGEN_DISABLED")
env.HealBot_Aura_BuffsEnabled=function() return false end
env.HealBot_Aura_DebuffsEnabled=function() return false end
hooks.HealBot_Aura_SetAuraCheckFlags()
eq(latest("hot").shown,false,"disabled monitoring hides native buffs")
eq(latest("db").shown,false,"disabled monitoring hides native debuffs")
env.HealBot_Aura_BuffsEnabled=function() return true end
env.HealBot_Aura_DebuffsEnabled=function() return true end
hooks.HealBot_Aura_SetAuraCheckFlags()
eq(latest("hot").shown,true,"reenabled monitoring restores native buffs")
eq(latest("db").shown,true,"reenabled monitoring restores native debuffs")

-- Forever must retain the same native harmful-aura row without requiring a
-- new UNIT_AURA event or a readable Lua scan at the combat boundary.
combat=false; fire("PLAYER_REGEN_ENABLED")
eq(latest("db").shown,false,"other clients retain combat-only default")
env.UnitClass=function() return "Mage","MAGE" end
env.UnitIsConnected=function() return true end
env.HealBot_Forever_BuffsEnabled=function() return env.HealBot_Aura_BuffsEnabled() end
env.HealBot_Forever_DebuffsEnabled=function() return env.HealBot_Aura_DebuffsEnabled() end
env.HealBot_Forever_GetDebuffTypes=function() return {}, "all" end
env.hbv_Skins_GetIconTextVar=function() end
env.hbv_Skins_GetFrameBoolean=function() return false end
for _,b in ipairs(buttons) do
for i=1,12 do
 b.gref.icon[i]=b.gref.icon[i] or {}
 b.gref.icon[i].SetShown=noop
end
b.gref.iconf=setmetatable({}, {__index=function() return {SetShown=noop,SetFrameLevel=noop,SetAlpha=noop,SetText=noop} end})
b.gref.txt={expire=setmetatable({},getmetatable(b.gref.iconf)),count=setmetatable({},getmetatable(b.gref.iconf))}
b.gref.indicator={selfcast=b.gref.iconf}
end
env.HEALBOT_FOREVER=true
env.HealBot_Globals.CombatAurasPersistDebuffs=nil
env.SlashCmdList.HBCOMBATAURAS("status")
eq(env.HealBot_Globals.CombatAurasPersistDebuffs,true,"Forever defaults to persistent debuffs")

-- Load the actual legacy render/removal functions to exercise duplicates and
-- restoration, including timer callbacks that were queued before takeover.
b.id=1; b.status.alpha=1
b.aura={debuff={update=false}}; b.icon={debuff={count={1,0,0}}}
b.glow={icon={}}
-- Preserve the mock buff regions.
env.HealBot_UnitDebuffIcons={[b.id]={}}
env.HealBot_Aura_prevIconCount={DEBUFF={6,2,2}}
env.HealBot_AuraDebuffCache={}
env.hbTextureUpdateTime={[b.id]={}}
env.HealBot_TimeNow=0; env.floor=math.floor
env.HealBot_issecretvalue=function() return false end
env.hbv_Skins_GetIconBoolean=function() return false end
env.hbv_Skins_GetIconTextBoolean=function() return false end
env.HealBot_Events_UnitDebuff=function(button) button.debuffQueued=true end
env.HealBot_Action_DisableIconGlow=function(button,_,i) button.glow.icon[i]=0 end
local function textRegion()
    return {SetText=function(self,v) self.text=v end,
            SetTextColor=function(self,r,g,bl,a) self.alpha=a end}
end
for i=51,60 do
    b.gref.icon[i]=b.gref.icon[i] or {}
    b.gref.icon[i].SetAlpha=function(self,v) self.alpha=v end
    b.gref.icon[i].SetTexture=noop
    b.gref.iconf[i]={SetFrameLevel=noop}
    b.gref.txt.expire[i]=textRegion(); b.gref.txt.count[i]=textRegion()
    b.glow.icon[i]=3
    env.HealBot_UnitDebuffIcons[b.id][i]={current=true,spellId=99,expirationTime=0,count=1,iconSet=1}
end
local auraSource=read("HealBot/Healbot_Aura.lua")
for _,name in ipairs({"HealBot_Aura_RemoveIcon","HealBot_Aura_DoUpdateDebuffIcon",
    "HealBot_Aura_UpdateDebuffIcon","HealBot_Aura_DebuffAddIcon","HealBot_Aura_CheckUnitDebuffIcons"}) do
    setfenv(assert(loadstring(assert(auraSource:match("(function "..name.."%b().-\nend)"),name))),env)()
end
local removeIcon=env.HealBot_Aura_RemoveIcon
env.HealBot_Aura_RemoveIcon=function(button,i)
    -- Only b has the full legacy renderer fixture; other bars test binding.
    if button==b then removeIcon(button,i) end
end
hooks.HealBot_Aura_SetAuraCheckFlags()
db=latest("db"); hot=latest("hot")
eq(db.shown,true,"existing harmful auras display outside combat")
eq(hot.shown,true,"Forever native buffs remain visible outside combat")
eq(env.HealBot_CombatAuras_UsesNativeDebuffs(b),true,"native row owns icon-set 1")
eq(b.gref.icon[51].alpha,0,"legacy texture hidden on takeover")
eq(b.gref.txt.expire[51].alpha,0,"legacy countdown hidden on takeover")
eq(b.gref.txt.count[51].alpha,0,"legacy stacks hidden on takeover")
eq(b.glow.icon[51],0,"legacy glow stopped on takeover")
eq(b.glow.icon[57],3,"custom second icon set retained")
eq(b.glow.icon[59],3,"custom third icon set retained")
local data=env.HealBot_UnitDebuffIcons[b.id][51]
data.current=true
env.HealBot_Aura_DoUpdateDebuffIcon(b,data,51,true,99,true)
eq(b.gref.icon[51].alpha,0,"old countdown callback cannot repaint native row")
data.current=true
env.HealBot_Aura_UpdateDebuffIcon(b,data,51,true,99)
eq(data.current,false,"normal legacy update remains suppressed")
eq(b.glow.icon[51],0,"legacy update cannot restart glow")
local refreshes=0
db.UpdateAllAuras=function() refreshes=refreshes+1 end
count=#containers
combat=true; fire("PLAYER_REGEN_DISABLED")
eq(db.shown,true,"same debuff row enters combat")
combat=false; fire("PLAYER_REGEN_ENABLED")
eq(db.shown,true,"remaining DoTs stay visible after combat")
eq(db.enabled,true,"native aura event processing stays enabled for removal and expiry")
eq(refreshes,2,"both transitions refresh native contents without UNIT_AURA")
eq(#containers,count,"combat transitions reuse existing containers")
eq(hot.shown,true,"Forever native buffs persist after combat")

env.HealBot_Aura_DebuffsEnabled=function() return false end
hooks.HealBot_Aura_SetAuraCheckFlags()
eq(db.shown,false,"monitoring toggle hides persistent row")
eq(env.HealBot_CombatAuras_UsesNativeDebuffs(b),false,"hidden native row releases legacy icons")
env.HealBot_Aura_DebuffsEnabled=function() return true end
hooks.HealBot_Aura_SetAuraCheckFlags()
eq(db.shown,true,"monitoring restores persistent row outside combat")
b.status.events=false; hooks.HealBot_Action_UnregisterUnitEvents(b)
eq(db.shown,false,"unregister hides persistent row")
b.status.events=true; hooks.HealBot_Action_RegisterUnitEvents(b)
eq(latest("db").shown,true,"same-unit registration restores row outside combat")
db=latest("db")
b.unit="party4"; hooks.HealBot_Action_RegisterUnitEvents(b)
eq(db.unit,"party4","persistent row retargets outside combat")
eq(db.shown,true,"retargeted row stays visible outside combat")
local restoreSetUnit=db.SetUnit
db.SetUnit=function() error("injected persistent retarget failure") end
combat=true; fire("PLAYER_REGEN_DISABLED")
b.unit="party2"; hooks.HealBot_Action_RegisterUnitEvents(b)
eq(db.shown,false,"failed retarget never displays old unit's debuffs")
eq(env.HealBot_CombatAuras_UsesNativeDebuffs(b),false,"failed retarget releases legacy renderer")
db.SetUnit=restoreSetUnit
combat=false; fire("PLAYER_REGEN_ENABLED")
eq(latest("db").unit,"party2","persistent retarget recovers at combat exit")
eq(latest("db").shown,true,"recovery does not wait for next combat")

b.aura.debuff.update=false; b.debuffQueued=false
env.SlashCmdList.HBCOMBATAURAS("persist off")
eq(latest("db").shown,false,"opt-out restores original out-of-combat path")
eq(b.aura.debuff.update,true,"opt-out invalidates legacy scan")
eq(b.debuffQueued,true,"opt-out queues rescan without an aura event")
env.HealBot_Aura_CheckUnitDebuffIcons(b)
eq(b.gref.icon[51].alpha,1,"legacy icon redraws after native row releases it")
eq(data.current,true,"legacy icon cache is restored")
env.SlashCmdList.HBCOMBATAURAS("persist on")
env.SlashCmdList.HBCOMBATAURAS("off")
eq(latest("db").shown,false,"global off overrides persistence")
eq(env.HealBot_CombatAuras_UsesNativeDebuffs(b),false,"global off releases legacy icons")
env.SlashCmdList.HBCOMBATAURAS("on")
eq(latest("db").shown,true,"global on restores persistent row immediately")
env.SlashCmdList.HBCOMBATAURAS("debuffs 0")
eq(env.HealBot_CombatAuras_UsesNativeDebuffs(b),false,"zero native icons retains legacy renderer")
env.SlashCmdList.HBCOMBATAURAS("debuffs 3")
eq(env.HealBot_CombatAuras_UsesNativeDebuffs(b),true,"reenabling row restores native ownership")
eq(#errors,2,"only the two injected retarget failures occurred")

failEnable=true
env.SlashCmdList.HBCOMBATAURAS("size 19")
eq(env.HealBot_CombatAuras_UsesNativeDebuffs(b),false,"failed native initialization preserves legacy icons")
eq(latest("db").shown,false,"failed native container stays hidden")
failEnable=false
env.SlashCmdList.HBCOMBATAURAS("size skin")
eq(latest("db").shown,true,"successful rebuild restores native display")

combat=true; fire("PLAYER_REGEN_DISABLED")
local lateButton=button()
count=#containers
hooks.HealBot_Action_RegisterUnitEvents(lateButton)
eq(#containers,count,"persistent row never creates protected widgets in combat")
combat=false; fire("PLAYER_REGEN_ENABLED")
local lateDebuff
for _,c in ipairs(containers) do if c.parent==lateButton and c.key=="hbcadb" then lateDebuff=c end end
eq(lateDebuff.shown,true,"deferred debuffs appear immediately after combat")
print("PASS: "..passed.." combat aura layout assertions (mock native widgets)")

