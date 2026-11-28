-- Exercise the same health, power-type and periodic handlers used by the client.
local env=setmetatable({}, {__index=_G})
local function loadFunction(path,name)
    local f=assert(io.open("HealBot/"..path..".lua","rb"))
    local s=f:read("*a"):gsub("\r\n","\n")
    f:close()
    local body=assert(s:match("(function "..name.."%b().-\nend)"),name)
    setfenv(assert(loadstring(body,"@"..name)),env)()
end
local function forbidden() error("compared or inspected an opaque value") end
local function opaque()
    return setmetatable({}, {__tostring=forbidden,__lt=forbidden,__le=forbidden,__add=forbidden,__index=forbidden})
end
local opaqueGuid,opaqueVital=opaque(),opaque()
local exists,combat,guid,name,powerType=true,true,"Player-1","Player one",1
local calls={}
local function count(key)
    calls[key]=(calls[key] or 0)+1
end
local function check(key,n)
    assert((calls[key] or 0)==n,key..": expected "..n..", got "..(calls[key] or 0))
end
local function bar(unit)
    local function region()
        return {SetValue=function(self,v) self.value=v end,SetText=function(self,v) self.value=v end}
    end
    return {unit=unit,frame=1,text={},health={},mana={type=0},status={current=1,deadnextcheck=99,dirarrowshown=0},
        special={unit=true},range={nextcheck=99},poweralt={type=2,current=0,max=0},gref={Bar=region(),txt={text=region(),text2=region()}}}
end
env.HEALBOT_FOREVER=true
env.HEALBOT_CLIENT_VERSION=12
env.HealBot_TimeNow=1
env.HealBot_Data={UILOCK=true}
env.HealBot_Unit_Status={DEAD=5}
env.hbManaExtra={}
env.hbActionFallWatch={}
env.InCombatLockdown=function() return combat end
env.UnitExists=function() return exists end
env.UnitGUID=function() return guid end
env.UnitName=function() count("names");return name end
env.HealBot_issecretvalue=function(v) return rawequal(v,opaqueGuid) or rawequal(v,opaqueVital) end
env.HealBot_Util_isMidnight=function() return true end
env.HealBot_WoWAPI_UnitHealth=function()
    count("health");return opaqueVital,opaqueVital,opaqueVital,opaqueVital,opaqueVital,opaqueVital,opaqueVital
end
env.HealBot_Text_DoSetHealthText=function(b) count("health text");b.gref.txt.text2:SetText(b.health.current) end
env.HealBot_Action_setButtonManaBarCol=function(b) count("power type");b.mana.type=powerType end
env.HealBot_WoWAPI_UnitMana=function(unit,kind)
    count("power")
    assert(kind==powerType,"did not apply current power type")
    return opaqueVital,opaqueVital,opaqueVital,opaqueVital
end
env.HealBot_Aux_setPowerBars=function(b)
    count("power bar")
    if b.mana.change then count("dirty power paint") end
    b.renderedPower=b.mana.current
end
env.UnitPower=function() count("alternate");return 10 end
env.UnitPowerMax=function() return 100 end
env.HealBot_Aux_setPowerAltBars=function() count("alternate paint") end
env.HealBot_Events_PowerIndicators=function() count("indicators") end
env.HealBot_HealsInUpdate=function() count("heals") end
env.HealBot_AbsorbsUpdate=function() count("absorbs") end
loadFunction("HealBot_ForeverFrames","HealBot_Forever_RefreshTarget")
for _,name in ipairs({"HealBot_UnitHealth","HealBot_UnitMana","HealBot_UnitUpdateButton"}) do loadFunction("HealBot",name) end
loadFunction("HealBot_Events","HealBot_Events_UnitManaUpdate")

for _,unit in ipairs({"target","targettarget","focus"}) do
    local b=bar(unit)
    env.HealBot_Events_UnitManaUpdate(b)
    assert(b.mana.change==false,"the completed power-type paint left the color dirty")
    assert(rawequal(b.gref.Bar.value,opaqueVital),"the first power event must paint the full occupant")
    calls={}
    b.health.updhlth=true
    for i=1,100 do env.HealBot_UnitMana(b) end
    check("power",100);check("health",0);check("names",0);check("power type",0);check("dirty power paint",0)
    assert(b.health.updhlth,"power event swallowed pending health work")
    calls={}
    b.mana.update=true
    for i=1,100 do env.HealBot_UnitHealth(b) end
    check("health",100);check("power",0);check("names",0);check("power bar",0)
    assert(b.mana.update,"health event swallowed pending power work")
    powerType=3
    env.HealBot_Events_UnitManaUpdate(b)
    check("dirty power paint",1);check("power type",1)
    assert(not b.mana.change and not b.mana.update)
    powerType=1
end

local b=bar("target")
env.HealBot_UnitHealth(b)
guid,name,powerType="Player-2","Player two",2
env.HealBot_UnitHealth(b) -- no preceding PLAYER_TARGET_CHANGED
assert(b.name==name and b.mana.type==2 and rawequal(b.renderedPower,opaqueVital))
guid,powerType="Player-3",3 -- same displayed name
env.HealBot_UnitHealth(b)
assert(b.mana.type==3,"same-name replacement was misidentified as the old occupant")
calls={}
b.unit="focus"
env.HealBot_UnitMana(b)
check("health",1);check("names",1)
calls={}
guid=opaqueGuid
env.HealBot_UnitHealth(b);env.HealBot_UnitMana(b)
guid=nil
env.HealBot_UnitHealth(b)
check("power",3);check("health",3);check("names",3)
guid,name="Player-3",opaqueVital
env.HealBot_UnitMana(b)
assert(rawequal(b.gref.txt.text.value,opaqueVital))
name="Available"
env.HealBot_UnitHealth(b)
assert(b.gref.txt.text.value==name)
exists=false
b.mana.change=true
env.HealBot_UnitMana(b)
assert(b.gref.Bar.value==0 and b.gref.txt.text.value=="" and b.renderedPower==0 and b.mana.change==false)
exists=true
env.HealBot_UnitHealth(b)
assert(b.name==name and rawequal(b.renderedPower,opaqueVital))

calls={}
env.HealBot_UnitUpdateButton(b)
check("health",1);check("power",1);check("names",1);check("heals",1);check("absorbs",1)
check("alternate",0) -- Forever target renderer owns the primary resource only
local function ordinaryHealth() count("ordinary health") end
env.HealBot_UnitHealth=ordinaryHealth
for _,state in ipairs({{true,"boss1"},{false,"target"}}) do
    combat=state[1];b=bar(state[2]);b.mana.type=powerType
    calls={}
    env.HealBot_UnitUpdateButton(b)
    check("ordinary health",1);check("power",1);check("alternate",1);check("alternate paint",1)
    check("indicators",1);check("heals",1);check("absorbs",1)
end
print("PASS: target/focus vital storms, identity swaps and secrecy, deferred work, periodic and alternate-power paths")
