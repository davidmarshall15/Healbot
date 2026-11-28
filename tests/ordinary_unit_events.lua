-- Bind the production normal/enemy button and deliver events as (frame, event, payload...).
local f=assert(io.open("HealBot/HealBot_Action.lua","rb"))
local src=f:read("*a"):gsub("\r\n","\n"); f:close()
local counters,dispatched,attributes={}, {}, {}
local function noop() end
local function button(id)
    return {id=id,status={},range={},text={},icon={},special={},gref={Back={ClearAllPoints=noop}},
        unit="nil",frame=0,guid="init",regClicks=true,events={},
        ClearAllPoints=noop,SetParent=noop,SetScript=function(b,script,fn) b[script]=fn end,
        SetAttribute=function(b,k,v) attributes[b.id..k]=v end,
        RegisterUnitEvent=function(b,e,u) b.events[e]=u end,
        UnregisterEvent=function(b,e) b.events[e]=nil end}
end
local normal,emergency=button(1),button(2)
local env=setmetatable({
    HEALBOT_CLIENT_VERSION=12,HealBot_Action_luVars={},
    Healbot_Config_Skins={Current_Skin="test"},HealBot_Emerg_Button={emergency},
    grpFrame={{},{},{},{},{},{},{},{},{},{}}, hbShouldHealSomePlayerFrames={},
    HealBot_Action_Unit_Button={raid1=normal,raid2=normal},HealBot_Private_Button={},HealBot_Unit_Button={},
    IsInGroup=noop,UnitInRaid=noop,UnitInParty=noop,UnitExists=function() return true end,
    HealBot_UpdateUnitGUIDChange=function(b) b.guid="guid" end,
    hbv_IsUnitType=function() return false end,hbv_Skins_GetFrameBoolean=noop,
    HealBot_issecretvalue=function() return false end,
},{__index=function(_,k)
    if _G[k]~=nil then return _G[k] end
    if k:match("^HealBot_") then
        return function(...)
            counters[k]=(counters[k] or 0)+1
            dispatched[k]={...}
        end
    end
end})
local function section(a,z)
    local i=assert(src:find(a,1,true)); local j=assert(src:find(z,i+#a,true))
    return src:sub(i,j-1)
end
local code=section("function HealBot_Action_setFrameHeader(","function HealBot_Action_SetStrata")
    ..section("function HealBot_Action_UnregisterUnitEvents(","HealBot_Action_luVars[\"regAggro\"]")
    ..section("function HealBot_Action_RegisterUnitEvents(","local tPrepButton=")
    ..section("local hButton=false","function HealBot_Action_ClearTestIcon(")
setfenv(assert(loadstring(code)),env)()
local function bind(unit,frame)
    assert(env.HealBot_Action_SetHealButton(unit,"guid",frame,11,false,0)==normal)
    assert(attributes["1unit"]==unit and attributes["2unit"]==unit and normal.status.events)
    assert(normal.events.UNIT_PHASE==unit and normal.events.UNIT_NAME_UPDATE==unit)
    assert(normal.events.UNIT_CLASSIFICATION_CHANGED==unit and normal.OnEvent,"missing registered event handler")
    normal:OnEvent("UNIT_NAME_UPDATE",unit,"extra",3,4)
    assert(dispatched.HealBot_UnitExists[1]==normal and dispatched.HealBot_UnitExists[2]==unit)
end
bind("raid1",10)
assert(not normal.events.UNIT_AURA)
bind("raid1",1)
assert(normal.events.UNIT_AURA=="raid1")
normal:OnEvent("UNIT_AURA","raid1","extra",3,4)
assert(dispatched.HealBot_Events_UnitAura[3]=="extra" and dispatched.HealBot_Events_UnitAura[5]==4)
bind("raid1",10)
assert(not normal.events.UNIT_AURA,"healing-only subscription remained on enemy panel")
normal:OnEvent("UNIT_AURA","raid1")
assert(counters.HealBot_Events_UnitAura==1)
bind("raid2",1)
assert(normal.events.UNIT_AURA=="raid2")
bind("raid1",1)
assert(normal.events.UNIT_AURA=="raid1","event subscription left on prior unit")
print("ordinary and enemy panel buttons dispatch their registered units and payload across rebinds")
