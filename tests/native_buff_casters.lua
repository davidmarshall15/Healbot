-- Exercise the complete native module with separate prepared caster groups.
-- Aura selection below models only the native HELPFUL/PLAYER and candidate-ID
-- rules; no addon code is allowed to inspect native aura frames or identities.
local passed=0
local function eq(actual,expected,label)
    assert(actual==expected,label..": expected "..tostring(expected)..", got "..tostring(actual))
    passed=passed+1
end
local function read(path)
    local f=assert(io.open(path,"rb")); local s=f:read("*a"); f:close()
    return s:gsub("\r\n","\n"):gsub("^\239\187\191","")
end
local source=read("HealBot/HealBot_CombatAuras.lua")
local noop=function() end

local function fixture(class,limit,configure)
    local combat=false
    local frames,hooks,events={},{},{}
    local names={[139]="Renew",[6074]="Renew",[17]="Power Word: Shield",[592]="Power Word: Shield",
        [774]="Rejuvenation",[1058]="Rejuvenation",[19740]="Blessing of Might",[19834]="Blessing of Might"}
    local ids={Renew=139,["Power Word: Shield"]=17,Rejuvenation=774,["Blessing of Might"]=19740}
    local skin={limits={limit or 4,0,0},size=16,spacing=1,double=false,selfMarker=false,
        durations={true,true,true},counts={true,true,true}}
    local disabled={}
    local config={BuffWatch=true,BuffCustomWatchInCombat=true}
    local globals={WatchHoT={PRIE={[139]=1,[17]=1},DRUI={[774]=3},ALL={}},
        CustomBuffIDMethod={},CustomBuffsIconSet={},IgnoreCustomBuff={},CombatAurasHots=limit or 4}
    local env
    local function region(parent)
        local r={parent=parent,shown=true}
        function r:SetShown(v) self.shown=v end
        function r:Hide() self.shown=false end
        function r:Show() self.shown=true end
        function r:SetAllPoints(v) self.allPoints=v end
        function r:SetTexCoord(...) self.coords={...} end
        function r:SetTexture(v) self.texture=v end
        function r:GetTexture() return self.texture end
        function r:SetPoint(...) self.point={...} end
        function r:GetPoint() return unpack(self.point or {}) end
        function r:ClearAllPoints() self.point=nil end
        function r:SetSize(w,h) self.width,self.height=w,h end
        function r:GetWidth() return self.width or skin.size end
        function r:GetHeight() return self.height or skin.size end
        function r:GetCenter() return 100,200 end
        function r:SetWidth(v) self.width=v end
        function r:SetJustifyH(v) self.justify=v end
        function r:SetWordWrap(v) self.wordWrap=v end
        function r:SetText(v) self.text=v end
        function r:SetTextColor(...) self.textColor={...} end
        function r:SetFrameLevel(v) self.level=v end
        function r:SetAlpha(v) self.alpha=v end
        return r
    end
    local function widget(kind,parent)
        assert(not combat,"allocated a frame during combat")
        local f=region(parent)
        f.kind,f.groups,f.groupOrder=kind,{},{}
        frames[#frames+1]=f
        function f:GetFrameLevel() return self.level or 5 end
        function f:SetMouseClickEnabled(v) self.click=v end
        function f:SetMouseMotionEnabled(v) self.motion=v end
        function f:SetUnit(v) self.unit=v end
        function f:SetEnabled(v) assert(not combat,"enabled container during combat"); self.enabled=v end
        function f:SetFlowLayoutAnchorPoint(v) assert(not combat); self.anchor=v end
        function f:SetFlowLayoutGrowthDirection(h,v) assert(not combat); self.growH,self.growV=h,v end
        function f:SetFlowLayoutAxis(v) assert(not combat); self.axis=v end
        function f:SetFlowLayoutMaximumLineSize(v) assert(not combat); self.maxLine=v end
        function f:SetReverse(v) self.reverse=v end
        function f:SetDrawEdge(v) self.drawEdge=v end
        function f:SetHideCountdownNumbers(v) self.hideNumbers=v end
        function f:GetCountdownFontString() self.countdown=self.countdown or region(self); return self.countdown end
        function f:SetIcon(v) self.boundIcon=v end
        function f:SetDurationCooldown(v) self.cooldown=v end
        function f:SetApplicationCount(v) self.count=v end
        function f:CreateTexture() return region(self) end
        function f:CreateFontString() return region(self) end
        function f:UpdateAllAuras() self.updates=(self.updates or 0)+1 end
        function f:RegisterEvent(name) events[name]=self end
        function f:SetScript(_,callback) self.onEvent=callback end
        function f:AddAuraGroup(key,filter,options)
            assert(not combat,"created a native group during combat")
            assert(not self.groups[key],"duplicate native group")
            local icon=widget("AuraButton",self)
            options.initializeFrame(icon)
            self.groups[key]={filter=filter,options=options,icon=icon}
            self.groupOrder[#self.groupOrder+1]=key
        end
        function f:HasAuraGroup(key) return self.groups[key]~=nil end
        function f:SetAuraGroupCandidateFilters(key,value)
            local group=assert(self.groups[key],"filter update requires a prepared group")
            group.options.candidateFilters=value
            self.filterWrites=(self.filterWrites or 0)+1
        end
        function f:SetAuraGroupMaxFrameCount(key,value)
            assert(type(value)=="number" and value>=0 and value==math.floor(value))
            assert(self.groups[key],"limit update requires a prepared group").options.maxFrameCount=value
        end
        function f:GetAuraGroupFrameCount() error("native aura frame counts are private") end
        function f:GetAuraGroup() error("native aura group internals are private") end
        function f:GetChildren() error("native aura frame identities are private") end
        return f
    end
    env=setmetatable({
        HEALBOT_FOREVER=true,HEALBOT_MIDNIGHT=true,SlashCmdList={},HealBot_Globals=globals,
        HealBot_Config_Buffs=config,HealBot_Spell_IDs={},HealBot_AuraBuffCache={},
        InCombatLockdown=function() return combat end,
        UnitClass=function() return class or "PRIEST",class or "PRIEST" end,
        UnitIsConnected=function() return true end,UnitExists=function() return true end,
        HealBot_issecretvalue=function() return false end,
        CreateFrame=function(kind,_,parent) return widget(kind,parent) end,
        hooksecurefunc=function(name,callback)
            hooks[name]=hooks[name] or {}; hooks[name][#hooks[name]+1]=callback
        end,
        HealBot_WoWAPI_SpellName=function(id) return type(id)=="string" and id or names[id] end,
        HealBot_WoWAPI_SpellId=function(name) return ids[name] end,
        HealBot_BuffIconSetKey=function(id) return id end,
        HealBot_Aura_CustomBuffDisabled=function(id,name)
            if disabled[id] or disabled[name] then return true end
            for base,ignore in pairs(disabled) do
                if ignore and type(base)=="number" and (globals.CustomBuffIDMethod[base] or 2)>1
                    and names[base]==name then return true end
            end
            return false
        end,
        HealBot_Aura_NativeBuffExclusions=function() return disabled end,
        HealBot_Forever_BuffsEnabled=function() return config.BuffWatch and (not combat or config.BuffCustomWatchInCombat) end,
        HealBot_Forever_DebuffsEnabled=function() return true end,
        HealBot_Forever_GetDebuffTypes=function() return {Magic=true},"Magic" end,
        hbv_Skins_GetIconVar=function(key,_,set)
            if key=="MAXBICONS" then return skin.limits[set] end
            if key=="MAXDICONS" then return 2 end
            if key=="BZOOM" or key=="DZOOM" then return .08 end
            return skin.spacing
        end,
        hbv_Skins_GetIconBoolean=function() return skin.double end,
        hbv_Skins_GetFrameBoolean=function(_,key) return key=="SELFIND" and skin.selfMarker end,
        hbv_Skins_GetIconTextVar=function(key)
            if key:find("HEIGHT",1,true) then return 12 end
            if key:find("OUTLINE",1,true) then return "OUTLINE" end
            return "test-font"
        end,
        hbv_Skins_GetIconTextBoolean=function(key,_,set)
            if key:find("SDUR",1,true) then return skin.durations[set] end
            if key:find("SCNT",1,true) then return skin.counts[set] end
            return false
        end,
        HealBot_Media_UpdateFont=function(text,font,size,outline)
            text.font,text.fontSize,text.fontOutline=font,size,outline
        end,
        AnchorUtil={FlowDirection={Left=-1,Right=1,Up=1,Down=-1},FlowLayoutAxis={Horizontal=0,Vertical=1}},
        print=noop,
    },{__index=_G})
    env.HealBot_Aura_CustomBuffCaster=function(id,name)
        for _,spells in pairs(globals.WatchHoT) do
            for configured,value in pairs(spells) do
                if configured==id or ((globals.CustomBuffIDMethod[configured] or 2)>1 and names[configured]==name) then
                    return value==1 and "S" or (value==2 and "C" or "A")
                end
            end
        end
    end
    local driver={env=env,skin=skin,config=config,globals=globals,disabled=disabled,frames=frames,names=names}
    function driver.hook(name,...)
        assert(hooks[name],"missing native lifecycle hook: "..name)
        for _,callback in ipairs(hooks[name]) do callback(...) end
    end
    function driver.fire(name)
        assert(events[name],"missing native event: "..name).onEvent(events[name],name)
    end
    function driver.combat(value)
        combat=value; driver.fire(value and "PLAYER_REGEN_DISABLED" or "PLAYER_REGEN_ENABLED")
    end
    function driver.button(unit)
        local b={unit=unit or "party1",frame=1,status={events=true},gref={Bar=region(),icon={},iconf={},
            txt={expire={},count={}},indicator={selfcast={}}}}
        function b:GetFrameLevel() return 5 end
        function b:IsShown() return true end
        for i=1,60 do
            for _,mapping in ipairs({b.gref.icon,b.gref.iconf,b.gref.txt.expire,b.gref.txt.count,b.gref.indicator.selfcast}) do
                mapping[i]=region(b)
            end
            local point=(i==9 or i==10) and "TOPRIGHT" or "BOTTOMRIGHT"
            b.gref.icon[i]:SetPoint(point,b,point,-2,2)
            b.gref.indicator.selfcast[i]:SetPoint("CENTER",b.gref.icon[i],"CENTER",0,0)
            b.gref.indicator.selfcast[i]:SetTexture("self-marker")
        end
        driver.hook("HealBot_Action_RegisterUnitEvents",b)
        return b
    end
    function driver.row(button,set)
        local index=({1,9,11})[set or 1]
        local icon=button.gref.icon[index]
        local found
        for _,f in ipairs(frames) do
            if f.parent==button and f.groups.hbcahot and f.point and f.point[1]==icon.point[1]
                and f.point[4]==icon.point[4] and f.point[5]==icon.point[5] then found=f end
        end
        return found
    end
    if configure then configure(env) end
    setfenv(assert(loadstring(source)),env)()
    driver.fire("PLAYER_LOGIN")
    return driver
end

local function admits(group,id,caster)
    if not group or group.options.maxFrameCount==0 then return false end
    if group.filter:find("PLAYER",1,true) and caster~="player" then return false end
    local cf=group.options.candidateFilters or {}
    return not (cf.includeSpellIDs and not cf.includeSpellIDs[id])
        and not (cf.excludeSpellIDs and cf.excludeSpellIDs[id])
end
local function copies(row,id,caster)
    local count=0
    for _,group in pairs(row.groups) do if admits(group,id,caster) then count=count+1 end end
    return count
end

local d=fixture("PRIEST",4)
local b=d.button()
local row=assert(d.row(b))
eq(row.shown,false,"Forever native buffs stay hidden outside combat")
eq(b.gref.icon[1].shown,true,"legacy buff icons own the out-of-combat display")
eq(row.groups.hbcahot.filter,"HELPFUL|PLAYER","Self uses the native PLAYER selector")
eq(row.groups.hbcahotEveryone.filter,"HELPFUL","Everyone uses the native helpful selector")
d.combat(true)
eq(row.shown,true,"prepared native row appears in combat")
eq(b.gref.icon[1].shown,false,"legacy buff icons hide during native takeover")
eq(copies(row,139,"player"),1,"own Self Renew is displayed")
eq(copies(row,139,"party2"),0,"another healer's Self Renew is hidden")
eq(copies(row,774,"player"),1,"own Everyone Rejuvenation is displayed once")
eq(copies(row,774,"party2"),1,"another healer's Everyone Rejuvenation is displayed")
eq(copies(row,19740,"player"),0,"an unconfigured buff stays outside the configured native list")
eq(row.groups.hbcahot.options.maxFrameCount+row.groups.hbcahotEveryone.options.maxFrameCount,4,"mixed caster groups share the existing icon cap")
local allocated=#d.frames
d.globals.WatchHoT.PRIE[139]=3; d.hook("HealBot_Aura_ConfigClassHoT")
eq(#d.frames,allocated,"caster changes allocate no frames during combat")
eq(row.shown,true,"caster changes retain the visible native row")
eq(copies(row,139,"party2"),1,"Everyone starts working before combat ends")
eq(copies(row,139,"player"),1,"moving a spell to Everyone does not duplicate own casts")
d.disabled[139]=true; d.env.HealBot_Forever_RefreshBuffExclusions()
eq(copies(row,139,"player"),0,"manual disable removes own Everyone Renew immediately")
eq(copies(row,139,"party2"),0,"manual disable removes other casters immediately")
eq(#d.frames,allocated,"disable changes reuse prepared groups")
d.disabled[139]=nil; d.env.HealBot_Forever_RefreshBuffExclusions()
eq(copies(row,139,"party2"),1,"custom re-enable restores the existing native group immediately")
d.globals.WatchHoT.PRIE[139]=1; d.hook("HealBot_Aura_ConfigClassHoT")
eq(copies(row,139,"party2"),0,"switching back to Self takes effect in combat")
d.config.BuffCustomWatchInCombat=false
d.hook("HealBot_Aura_SetAuraCheckFlags")
eq(row.shown,false,"Also in combat off hides native helpful rows")
d.globals.WatchHoT.PRIE[139]=3; d.hook("HealBot_Aura_ConfigClassHoT")
eq(copies(row,139,"party2"),0,"disabled combat monitoring defers the native setting change")
d.combat(false)
d.config.BuffCustomWatchInCombat=true
d.combat(true)
row=assert(d.row(b))
eq(copies(row,139,"party2"),1,"deferred caster change applies safely after regeneration")
eq(row.shown,true,"native row returns with combat monitoring enabled")
d.combat(false)
eq(row.shown,false,"native row releases legacy icons outside combat")
eq(b.gref.icon[1].shown,true,"legacy icons restore at combat exit")

for _,class in ipairs({"DRUID","HUNTER","MAGE","PALADIN","PRIEST","ROGUE","SHAMAN","WARLOCK","WARRIOR"}) do
    local f=fixture(class,3)
    local unit=f.button("raid1"); f.combat(true)
    local native=assert(f.row(unit))
    eq(copies(native,774,"party2"),1,class.." admits configured Everyone HoTs")
    eq(copies(native,139,"party2"),0,class.." preserves Self filtering")
    eq(native.groups.hbcahot.options.maxFrameCount+native.groups.hbcahotEveryone.options.maxFrameCount,3,class.." keeps an odd shared icon limit")
end

local single=fixture("PALADIN",4)
single.globals.WatchHoT.PRIE={}; single.globals.WatchHoT.DRUI={[774]=3}
local sb=single.button(); local sr=single.row(sb)
eq(sr.groups.hbcahot.options.maxFrameCount,0,"an empty Self scope reserves no icon slots")
eq(sr.groups.hbcahotEveryone.options.maxFrameCount,4,"a single Everyone scope uses the whole row")
single.combat(true)
allocated=#single.frames
single.globals.WatchHoT.PRIE[139]=1; single.hook("HealBot_Aura_ConfigClassHoT")
eq(sr.groups.hbcahot.options.maxFrameCount,2,"a newly configured Self scope receives its share")
eq(sr.groups.hbcahotEveryone.options.maxFrameCount,2,"Everyone budget adjusts without recreating native groups")
eq(#single.frames,allocated,"activating an initially empty scope allocates no frames")

local style=fixture("PRIEST",4)
style.skin.selfMarker=true
local styled=style.row(style.button())
local selfIcon=styled.groups.hbcahot.icon
local everyoneIcon=styled.groups.hbcahotEveryone.icon
eq(selfIcon.hbcaMarker~=nil,true,"Self icons retain the configured self marker")
eq(everyoneIcon.hbcaMarker,nil,"Everyone icons do not falsely mark other casters as self")
eq(everyoneIcon.cooldown.hideNumbers,false,"Everyone countdown follows skin settings")
eq(everyoneIcon.cooldown.countdown.font,"test-font","Everyone countdown uses the configured font")
eq(everyoneIcon.cooldown.countdown.fontSize,12,"Forever countdown text respects configured skin height")
eq(everyoneIcon.count.fontSize,12,"Forever stack text respects configured skin height")
eq(everyoneIcon.count.justify,"LEFT","stack text keeps its configured corner alignment")

local empty=fixture("MAGE",4)
empty.globals.WatchHoT.PRIE={}; empty.globals.WatchHoT.DRUI={}
local eb=empty.button(); local er=empty.row(eb)
empty.combat(true)
eq(er.shown,false,"prepared empty groups do not hide an otherwise empty row")
allocated=#empty.frames
empty.globals.WatchHoT.DRUI[774]=3; empty.hook("HealBot_Aura_ConfigClassHoT")
eq(#empty.frames,allocated,"adding the first custom buff in combat uses a prepared row")
eq(er.shown,true,"the first configured custom buff activates its prepared row")
eq(copies(er,774,"party2"),1,"the first custom Everyone selection appears in combat")
empty.globals.WatchHoT.DRUI={}; empty.hook("HealBot_Aura_ConfigClassHoT")
eq(er.shown,false,"removing the last configured buff hides its prepared row immediately")
eq(er.groups.hbcahot.options.maxFrameCount+er.groups.hbcahotEveryone.options.maxFrameCount,0,"empty scopes reserve no visible native slots")

local arrival=fixture("PRIEST",4)
arrival.skin.limits[2]=2
arrival.globals.CustomBuffsIconSet[139]=2
local donor=arrival.button()
local reserve={unit="party2",frame=1,healthBar={}}
function reserve:GetFrameLevel() return 5 end
arrival.env.HealBot_Forever_SkinArrivalAuras(reserve,donor)
arrival.env.HealBot_Forever_UpdateArrivalAuras(reserve)
local reserveSet2
for _,item in ipairs(reserve.arrivalAuras) do
    if item.set==2 then reserveSet2=item.container end
end
assert(reserveSet2,"reserved arrival row lost its configured icon-set metadata")
eq(copies(reserveSet2,139,"party3"),0,"arrival Self scope initially excludes other casters")
arrival.combat(true); allocated=#arrival.frames
arrival.globals.WatchHoT.PRIE[139]=3; arrival.hook("HealBot_Aura_ConfigClassHoT")
eq(#arrival.frames,allocated,"arrival caster updates reuse existing native containers in combat")
eq(copies(reserveSet2,139,"party3"),1,"arrival icon set receives the new Everyone scope immediately")
eq(copies(reserveSet2,139,"player"),1,"arrival Everyone scope does not duplicate own casts")
arrival.disabled[139]=true; arrival.env.HealBot_Forever_RefreshBuffExclusions()
eq(copies(reserveSet2,139,"party3"),0,"arrival custom disable applies to its own icon set")
eq(reserveSet2.shown,false,"an empty reserved icon set hides without a rebuild")

local zero=fixture("MAGE",4)
local zb=zero.button(); zero.combat(true)
local old=zero.row(zb)
zero.combat(false); zero.skin.limits[1]=0
zero.hook("hbv_Skins_SetIconVar",0,"MAXBICONS",1)
eq(old.shown,false,"zero skin limit retires its old prepared row")
allocated=#zero.frames
zero.combat(true)
eq(old.shown,false,"a zero-limit row does not resurface on entering combat")
eq(#zero.frames,allocated,"zero-limit combat transition creates no replacement widgets")

print("PASS: "..passed.." native buff caster assertions (mock native widgets; not an in-game test)")
