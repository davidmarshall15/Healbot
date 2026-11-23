-- Run from the repository root with Lua 5.1. WoW APIs are mocked.
local function read(path)
    local file=assert(io.open(path,"rb"))
    local source=file:read("*a"):gsub("\r\n","\n"):gsub("^\239\187\191","")
    file:close()
    return source
end
local function between(source,first,last)
    local start=assert(source:find(first,1,true),first)
    local finish=assert(source:find(last,start,true),last)
    return source:sub(start,finish-1)
end
local function execute(source,env)
    return setfenv(assert(loadstring(source)),env)()
end

local setup=[=[

combat=false
ctrl=false
alt=false
sticky=false
HEALBOT_GAME_VERSION=1
HealBot_Data={UILOCK=false}
HealBot_luVars={MovingFrame=0}
HealBot_Action_luVars={FrameMoving=false, TestBarsOn=false}
locks={[1]=1,[2]=2}
stuck={[2]=true}
stuckTo={[2]=1}
calls={starts=0,stops=0,clear=0,anchor=0,stick=0,options=0,forbidden=0}
function InCombatLockdown() return combat end
function IsControlKeyDown() return ctrl end
function IsAltKeyDown() return alt end
function hbv_Skins_GetBoolean() return sticky end
function hbv_Skins_GetFrameBoolean(section, key, frame) return stuck[frame] or false end
function hbv_Skins_GetFrameVar(section, key, frame)
    if section=='Frame' then return locks[frame] end
    if key=='STUCKTO' then return stuckTo[frame] end
    error('Unexpected skin lookup')
end
function protected_call(key)
    if combat then
        calls.forbidden=calls.forbidden+1
        error('protected call during combat: '..key)
    end
    calls[key]=calls[key]+1
end
function HealBot_Action_StickyFrameCanStickTo() protected_call('stick') end
function HealBot_Action_StickyFrameClearStuck() protected_call('clear') end
function HealBot_Action_setPoint() protected_call('anchor') end
function HealBot_Action_FrameIsVisible() return true end
function HealBot_Action_OptionsButton_OnClick() calls.options=calls.options+1 end
function CreateFrame()
    local frame={}
    function frame:RegisterEvent(event) self.event=event end
    function frame:UnregisterEvent(event) assert(not self.event or self.event==event); self.event=nil end
    function frame:SetScript(event, handler) assert(event=='OnEvent'); self.handler=handler end
    moveEvents=frame
    return frame
end
function new_frame(id)
    local frame={id=id,isMoving=false}
    function frame:StartMoving() protected_call('starts') end
    function frame:StopMovingOrSizing() protected_call('stops') end
    return frame
end
grpFrame={[1]=new_frame(1),[2]=new_frame(2)}
f=grpFrame[1]
]=]
local main=read("HealBot/HealBot.lua")
local action=read("HealBot/HealBot_Action.lua")
local first=main:find("local hbPendingFrameStops={}",1,true)
    and "local hbPendingFrameStops={}" or "function HealBot_StartMoving("
local function runtime()
    local env=setmetatable({}, {__index=_G})
    execute(setup,env)
    execute(between(main,first,"function HealBot_CheckFrameHorizontal("),env)
    execute(between(action,"local modKey=1 -- Not Locked","local hbFrameTags="),env)
    execute(between(action,"function HealBot_Action_OnMouseUp(","function HealBot_Action_Toggle_Enabled("),env)
    return env
end
local passed=0
local function check(name,body)
    local env=runtime()
    execute(body.."\nassert(calls.forbidden==0)",env)
    passed=passed+1
end

check("Combat click with stale addon lock is ignored",[=[

        combat=true
        assert(HealBot_Action_IsFrameLocked(1))
        HealBot_Action_OnMouseDown(f,'LeftButton')
        HealBot_Action_OnMouseUp(f,'LeftButton')
        assert(calls.starts==0 and calls.stops==0 and calls.anchor==0)
        assert(not f.isMoving and not HealBot_Action_luVars.FrameMoving)
        assert(not moveEvents.event)
    ]=])

check("Direct movement helper is guarded in combat",[=[

        combat=true
        assert(HealBot_StartMoving(f,1)==false)
        assert(calls.starts==0 and not f.isMoving)
    ]=])

check("Normal dragging and duplicate starts still work",[=[

        HealBot_Action_OnMouseDown(f,'LeftButton')
        assert(f.isMoving and HealBot_Action_luVars.FrameMoving==f)
        assert(HealBot_StartMoving(f,1)==true and calls.starts==1)
        HealBot_Action_OnMouseUp(f,'LeftButton')
        assert(calls.stops==1 and calls.clear==1 and calls.anchor==1)
        assert(not f.isMoving and not HealBot_Action_luVars.FrameMoving)
    ]=])

check("Frame lock, modifier override and right click are preserved",[=[

        locks[1]=2
        HealBot_Action_OnMouseDown(f,'LeftButton')
        assert(calls.starts==0)
        locks[1]=3
        ctrl=true
        HealBot_Action_OnMouseDown(f,'LeftButton')
        assert(calls.starts==1)
        HealBot_Action_OnMouseUp(f,'LeftButton')
        HealBot_Globals={RightButtonOptions=true}
        HealBot_Action_OnMouseUp(f,'RightButton')
        assert(calls.options==1)
    ]=])

check("Test bars cannot bypass combat lockdown",[=[

        HealBot_Action_luVars.TestBarsOn=true
        combat=true
        assert(HealBot_Action_IsFrameLocked(1))
        HealBot_Action_OnMouseDown(f,'LeftButton')
        assert(calls.starts==0)
    ]=])

check("Existing later-client cached UI lock remains effective",[=[

        HEALBOT_GAME_VERSION=2
        HealBot_Data.UILOCK=true
        assert(HealBot_Action_IsFrameLocked(1))
        HealBot_Action_OnMouseDown(f,'LeftButton')
        assert(calls.starts==0)
    ]=])

check("Sticky frame forwards dragging to parent outside combat",[=[

        sticky=true
        HealBot_Action_OnMouseDown(grpFrame[2],'LeftButton')
        assert(f.isMoving and not grpFrame[2].isMoving)
        assert(HealBot_Action_luVars.FrameMoving==f)
        HealBot_Action_OnMouseUp(grpFrame[2],'LeftButton')
        assert(calls.starts==1 and calls.stops==1)
        combat=true
        HealBot_Action_OnMouseDown(grpFrame[2],'LeftButton')
        assert(calls.starts==1)
    ]=])

check("Combat during drag defers stop and anchors until safe",[=[

        HealBot_Action_OnMouseDown(f,'LeftButton')
        combat=true
        HealBot_Action_OnMouseUp(f,'LeftButton')
        assert(f.isMoving and calls.stops==0 and calls.anchor==0)
        assert(moveEvents.event=='PLAYER_REGEN_ENABLED')
        moveEvents.handler(moveEvents,'PLAYER_REGEN_ENABLED')
        assert(calls.stops==0 and moveEvents.event)
        combat=false
        moveEvents.handler(moveEvents,'PLAYER_REGEN_ENABLED')
        assert(calls.stops==1 and calls.anchor==1 and not f.isMoving)
        assert(not moveEvents.event and not HealBot_Action_luVars.FrameMoving)
    ]=])

check("Multiple pending stops include option windows without frame IDs",[=[

        sticky=true
        local option=new_frame(nil)
        HealBot_StartMoving(f,1)
        HealBot_StartMoving(grpFrame[2],2)
        HealBot_StartMoving(option)
        combat=true
        HealBot_StopMoving(f,1)
        HealBot_StopMoving(grpFrame[2],2)
        HealBot_StopMoving(option)
        assert(calls.stops==0 and calls.anchor==0)
        combat=false
        moveEvents.handler(moveEvents,'PLAYER_REGEN_ENABLED')
        assert(calls.stops==3 and calls.anchor==2 and calls.clear==2)
        assert(calls.stick==1 and HealBot_luVars.MovingFrame==0)
        assert(not option.isMoving and not moveEvents.event)
        moveEvents.handler(moveEvents,'PLAYER_REGEN_ENABLED')
        assert(calls.stops==3)
    ]=])

check("A refused start does not record a moving frame",[=[
    HealBot_StartMoving=function() return false end
    HealBot_Action_LockFrame(f)
    assert(not HealBot_Action_luVars.FrameMoving and not f.isMoving)
]=])
check("A nonmoving frame still defers protected anchor changes",[=[
    combat=true
    HealBot_StopMoving(f,1)
    assert(calls.stops==0 and calls.clear==0 and calls.anchor==0)
    combat=false
    moveEvents.handler(moveEvents,"PLAYER_REGEN_ENABLED")
    assert(calls.stops==0 and calls.clear==1 and calls.anchor==1)
    assert(not moveEvents.event)
]=])
print("PASS: "..passed.." movement safety scenarios (mock protected methods)")
