-- Full native-aura module with Forever enabled from load (including its hooks).
local passed=0
local function eq(a,b,label)
    assert(a==b,label..": expected "..tostring(b)..", got "..tostring(a)); passed=passed+1
end
local noop=function() end
local combat=false
local hooks,rows,events={},{},{}
local function widget(kind,parent)
    if kind=="AuraContainer" then assert(not combat,"created native row in combat") end
    local f={kind=kind,parent=parent,shown=false}
    for _,name in ipairs({"SetAllPoints","SetTexCoord","SetReverse","SetDrawEdge","SetFrameLevel",
        "SetMouseClickEnabled","SetMouseMotionEnabled","ClearAllPoints","SetPoint","SetSize","SetIcon"}) do f[name]=noop end
    function f:GetPoint() return "TOPRIGHT",parent,"TOPRIGHT",0,0 end
    function f:GetWidth() return 16 end
    function f:SetShown(v) self.shown=v end
    function f:Hide() self.shown=false end
    function f:SetUnit(v) self.unit=v end
    function f:SetEnabled(v) assert(not combat); self.enabled=v end
    function f:SetHideCountdownNumbers(v) self.hideNumbers=v end
    function f:SetDurationCooldown(v) self.cooldown=v end
    function f:SetApplicationCount(v) self.count=v end
    function f:GetCountdownFontString() return self end
    function f:CreateTexture() return widget("Texture",self) end
    function f:CreateFontString() return widget("FontString",self) end
    function f:UpdateAllAuras() end
    function f:RegisterEvent(name) events[name]=self end
    function f:SetScript(_,fn) self.onEvent=fn end
    function f:AddAuraGroup(key,filter,options)
        assert(not combat); self.key=key; self.filter=filter; self.options=options
        self.icon=widget("AuraButton",self); options.initializeFrame(self.icon)
    end
    if kind=="AuraContainer" then rows[#rows+1]=f end
    return f
end
local limits={MAXBICONS={2,1,1},MAXDICONS={3,1,1}}
local durations={true,false,true}
local counts={false,true,false}
local disabled={}
local class="PRIEST"
local env=setmetatable({
    HEALBOT_FOREVER=true,HEALBOT_MIDNIGHT=true,SlashCmdList={},
    HealBot_Globals={CustomBuffsIconSet={},IgnoreCustomBuff={}},
    UnitClass=function() return class,class end, UnitIsConnected=function() return true end,
    InCombatLockdown=function() return combat end,
    CreateFrame=function(kind,_,parent) return widget(kind,parent) end,
    hooksecurefunc=function(name,fn) hooks[name]=fn end,
    -- Unexpected swallowed initialization errors must fail this regression.
    pcall=function(fn,...) return true,fn(...) end,
    HealBot_BuffIconSetKey=function(id) return id end,
    HealBot_WoWAPI_SpellName=function(id) return tostring(id) end,
    HealBot_Aura_CustomBuffDisabled=function(id) return disabled[id] end,
    HealBot_Aura_NativeBuffExclusions=function() return disabled end,
    HealBot_Forever_BuffsEnabled=function() return true end,
    HealBot_Forever_DebuffsEnabled=function() return true end,
    HealBot_Forever_GetDebuffTypes=function() return {},"all" end,
    HealBot_Media_UpdateFont=noop,
    hbv_Skins_GetIconVar=function(key,_,set)
        if limits[key] then return limits[key][set] end
        if key=="BZOOM" or key=="DZOOM" then return 0.08 end
        return 1
    end,
    hbv_Skins_GetIconBoolean=function() return false end,
    hbv_Skins_GetFrameBoolean=function() return false end,
    hbv_Skins_GetIconTextVar=function() return "font" end,
    hbv_Skins_GetIconTextBoolean=function(key,_,set)
        if key=="BUFFSDUR" then return durations[set] end
        if key=="BUFFSCNT" then return counts[set] end
        return false
    end,
    print=noop,
},{__index=_G})
local f=assert(io.open("HealBot/HealBot_CombatAuras.lua","rb"));local source=f:read("*a");f:close()
setfenv(assert(loadstring(source)),env)()
local b={unit="party1",frame=1,status={events=true},gref={icon={},iconf={},txt={expire={},count={}},indicator={selfcast={}}}}
function b:GetFrameLevel() return 5 end
function b:IsShown() return true end
for _,regions in ipairs({b.gref.icon,b.gref.iconf,b.gref.txt.expire,b.gref.txt.count,b.gref.indicator.selfcast}) do
    for i=1,60 do regions[i]=widget("Texture",b) end
end
local function latest(key)
    for i=#rows,1,-1 do if rows[i].parent==b and rows[i].key==key then return rows[i] end end
end
local function fire(event) events[event].onEvent(events[event],event) end
hooks.HealBot_Action_RegisterUnitEvents(b)
local hot=latest("hbcahot")
eq(hot.shown,true,"Renew row visible out of combat")
eq(hot.filter,"HELPFUL|PLAYER","own buffs selected by native filter")
for _,id in ipairs({139,6074,6075,6076,6077,6078,10927,10928,10929,25315}) do
    eq(hot.options.candidateFilters.includeSpellIDs[id],true,"Renew rank included")
end
eq(hot.options.candidateFilters.includeSpellIDs[999999],nil,"unrelated buffs excluded for priest")
eq(hot.options.maxFrameCount,2,"first row obeys skin limit")
eq(hot.icon.cooldown.hideNumbers,false,"skin duration enabled")
eq(hot.icon.count,nil,"skin count disabled")
eq(latest("hbcaweakenedSoul"),nil,"persistent harmful row does not duplicate weakened soul")
durations[1]=false; counts[1]=true
hooks.hbv_Skins_SetIconTextVar(false,"BUFFSDUR",1)
hot=latest("hbcahot")
eq(hot.icon.cooldown.hideNumbers,true,"skin duration switch takes effect")
eq(hot.icon.count~=nil,true,"skin stack count switch takes effect")
limits.MAXBICONS[1]=0
hooks.hbv_Skins_SetIconVar(0,"MAXBICONS",1)
eq(hot.shown,false,"zero skin limit hides old native row")
local count=#rows
limits.MAXBICONS[1]=1; combat=true
hooks.hbv_Skins_SetIconVar(1,"MAXBICONS",1)
eq(#rows,count,"skin change defers creation in combat")
combat=false; fire("PLAYER_REGEN_ENABLED")
hot=latest("hbcahot")
eq(hot.options.maxFrameCount,1,"skin limit applied after combat")
eq(hot.shown,true,"Renew row restored after deferred setup")
env.HealBot_Globals.CustomBuffsIconSet[139]=2
hooks.HealBot_Aura_ConfigClassHoT()
hot=latest("hbcahot")
eq(hot.options.candidateFilters.includeSpellIDs[139],true,"Renew routed to set 2")
eq(hot.options.candidateFilters.includeSpellIDs[6074],true,"lower Renew rank follows family")
eq(hot.icon.cooldown.hideNumbers,true,"set 2 uses its own timer setting")
eq(hot.icon.count~=nil,true,"set 2 uses its own count setting")
disabled={[139]=true}
env.HealBot_Forever_RefreshBuffExclusions()
eq(latest("hbcahot").options.candidateFilters.excludeSpellIDs[139],true,"disabled priest buff excluded")
env.SlashCmdList.HBCOMBATAURAS("maxdur 120")
eq(latest("hbcahot").options.candidateFilters.maxDuration,120,"long-buff workaround forwarded to client")
class="SHAMAN"; disabled={}
env.HealBot_Forever_RefreshBuffExclusions()
hot=latest("hbcahot")
eq(hot.options.candidateFilters.includeSpellIDs,nil,"other classes are not restricted to priest spells")
disabled={[12345]=true}
env.HealBot_Forever_RefreshBuffExclusions()
eq(hot.shown,false,"other classes rebuild stale exclusions")
eq(latest("hbcahot").options.candidateFilters.excludeSpellIDs[12345],true,"other classes honor exclusions")
combat=true; disabled={[12345]=true,[67890]=true}
count=#rows; env.HealBot_Forever_RefreshBuffExclusions()
eq(#rows,count,"exclusion changes never create protected rows in combat")
eq(latest("hbcahot").shown,false,"stale filter hidden until rebuild")
combat=false; fire("PLAYER_REGEN_ENABLED")
eq(latest("hbcahot").options.candidateFilters.excludeSpellIDs[67890],true,"deferred exclusion applied")
-- The UI uses this same setter, with real rows already attached.
combat=true; count=#rows
env.HealBot_CombatAuras_SetOption("maxdur",90)
eq(#rows,count,"UI setter defers row creation in combat")
eq(latest("hbcahot").shown,false,"old rows hidden until changed filter is ready")
combat=false; fire("PLAYER_REGEN_ENABLED")
eq(latest("hbcahot").options.candidateFilters.maxDuration,90,"UI duration applied at combat exit")
count=#rows;env.HealBot_CombatAuras_SetOption("maxdur",90)
eq(#rows,count,"unchanged UI value does not rebuild rows")
env.HealBot_CombatAuras_SetOption("enabled",false)
eq(latest("hbcahot").shown,false,"UI master switch hides native icons")
env.HealBot_CombatAuras_SetOption("enabled",true)
eq(latest("hbcahot").shown,true,"UI master switch restores native icons")
print("PASS: "..passed.." Forever buff settings assertions (mock native widgets)")
