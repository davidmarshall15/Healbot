local env=setmetatable({}, {__index=_G})
local function production(path,name)
    local file=assert(io.open(path,"rb"))
    local source=file:read("*a"):gsub("\r\n","\n")
    file:close()
    local body=assert(source:match("(function "..name.."%b().-\nend)"),name)
    setfenv(assert(loadstring(body)),env)()
end
local events="HealBot/HealBot_Events.lua"
for _,name in ipairs({"HealBot_Events_CheckUnitAura","HealBot_Events_UnitBuff","HealBot_Events_UnitDebuff"}) do
    production(events,name)
end
production("HealBot/Libs/LibRange/HealBot_Range.lua","HealBot_Range_UpdateUnit")

local function noop() end
local secret={}
env.HEALBOT_FOREVER=true
env.HealBot_TimeNow=100
env.HealBot_ServerTimeNow=10000
env.HealBot_Data={UILOCK=true}
env.HealBot_luVars={}
env.HealBot_Unit_Status={DC=15}
env.HealBot_Range_luVars={rangeCheckInterval=1}
env.HealBot_issecretvalue=function(value) return value==secret end
env.UnitExists=function() return true end
local button={id=1,unit="raid7",frame=1,special={},guid=secret,event={},
    specupdate=0,mana={},status={current=1,events=true,dupid=0,dirarrowshown=0},
    range={current=-1},aura={buff={recheck={}},debuff={}}}
local function reset()
    button.event={}
    button.aura.buff.update,button.aura.debuff.update=false,false
end
local roster={raid7=true,party2=true,raidpet2=true}
env.HealBot_Panel_RaidPetUnitButtonCheck=function(unit) return roster[unit] end
env.HealBot_Emerg_Button={{state=0}}
env.hbRangeRequests,env.hbActionIconsInRange={},{}
env.hbv_Skins_GetFrameBoolean,env.HealBot_Text_TagInUse=noop,noop
for _,name in ipairs({"HealBot_Update_AuxRange","HealBot_RefreshUnit","HealBot_Update_TextPlayersAlphaButtonNow",
    "HealBot_HealsInUpdate","HealBot_AbsorbsUpdate","HealBot_Action_AdaptiveOORUpdate","HealBot_Action_UpdateHotBar",
    "HealBot_Action_UpdateGroupHealth"}) do env[name]=noop end
local function transition(from,to,expected)
    reset()
    button.range.current=from
    env.HealBot_Range_UnitCurrent=function() return to end
    env.HealBot_Range_UpdateUnit(button)
    assert((button.event.buff or false)==expected and (button.event.debuff or false)==expected,
        "incorrect aura scheduling for "..button.unit.." from "..from.." to "..to)
    assert(button.aura.buff.update==expected and button.aura.debuff.update==expected,
        "visibility refresh did not invalidate the cached scan")
end
for _,unit in ipairs({"raid7","party2","raidpet2"}) do
    button.unit=unit
    transition(-1,0,true) -- visible beyond spell range, disabled bar, no warning to replay
    transition(0,-1,true)
    transition(-2,1,true)
    transition(1,2,false)
    transition(0,1,false)
    transition(-1,-2,false)
    transition(1,1,false)
end
button.status.events=false
transition(-1,0,false)
button.status.events=true
button.unit="target"
transition(-1,0,false)
button.unit="raid7"
button.special.unit=true
transition(-1,0,false)
print("Roster aura visibility transitions passed")
