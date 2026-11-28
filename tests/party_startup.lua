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
loaded=false
HealBot_Globals={ForeverPartyJoin=true}
Healbot_Config_Skins={Current_Skin='test',HealGroups={test={}}}
HealBot_Buttons={}
UIParent={}
pending={}
createdRows={}
calls={created=0,styled=0,texture=0,font=0,fetch=0}
C_Timer={After=function(delay,callback) table.insert(pending,{delay=delay,callback=callback}) end}
function tick()
    assert(#pending>0,'No pending callback')
    table.remove(pending,1).callback()
end
function InCombatLockdown() return combat end
function HealBot_retLuVars(key) assert(key=='Loaded'); return loaded end
function IsInRaid() return false end
function GroupFrame() return 1 end
function PositionReservedRows() return true end
function UnitExists() return true end
function UnregisterUnitWatch() end
function RegisterUnitWatch() assert(not combat) end
function UnregisterStateDriver() assert(not combat) end
function RegisterStateDriver() assert(not combat) end
function BindRow() error('Unexpected binding path') end
function SkinExtras() error('Unexpected extras path') end
function CreateFrame()
    assert(not combat,'Frame mutation during combat')
    local object={}
    function object:SetSize() end
    function object:SetPoint() end
    function object:SetFrameStrata() end
    function object:Hide() end
    return object
end
function CreateRow(mode,index)
    assert(not combat)
    calls.created=calls.created+1
    local object={unit=mode..index}
    function object:SetStatusBarTexture(texture) calls.texture=calls.texture+1; self.appliedTexture=texture end
    function object:SetFont(font,height,outline) calls.font=calls.font+1; self.appliedFont=font end
    function object:Hide() end
    createdRows[#createdRows+1]=object
    return object
end
function ApplySkin()
    assert(not combat)
    calls.styled=calls.styled+1
    for _,object in ipairs(createdRows) do
        HealBot_Media_UpdateTexture(object,'Smooth v2','Forever party bar')
        HealBot_Media_UpdateFont(object,'DefaultFont',10,1,'Forever party name')
    end
end
local library={}
function library:Register(kind,name,file) end
function library:Fetch(kind,name) calls.fetch=calls.fetch+1; return kind..':'..name end
function HealBot_Libs_LSM() return library end
function hbv_Default_TextureFile() return 'default.tga' end
function hbv_Default_TextureName() return 'DefaultTexture' end
function hbv_Default_FontFile() return 'default.ttf' end
function hbv_Default_FontName() return 'DefaultFont' end
function hbv_Default_SoundFile() return 'default.ogg' end
function hbv_Default_SoundName() return 'DefaultSound' end
HealBot_Supplied_Textures={{name='Smooth v2',file='smooth.tga'}}
HealBot_Supplied_Fonts={}
HealBot_Supplied_Sounds={}
]=]
local locals=[=[

local rows={}
local panel
local refreshQueued=false
local rosterMode
local frame
local frameSkin
local skinDirty=true
local bindingError
local bindingGeneration=0
]=]
-- Sync and QueueSync are exercised directly. The skin fixture calls the
-- actual media helpers, so early initialization still reproduces nil LSM.
local source=read("HealBot/HealBot_ForeverPartyJoin.lua")
local sync=between(source,'local function FindSkinDonor()','local function SkinExtras(')
    ..between(source,'local auraWorker','local events=CreateFrame("Frame")')
local media=read("HealBot/Libs/LibMedia/HealBot_Media.lua")
media=media:sub(1,assert(media:find("local hbSounds={}",1,true))-1)
local function runtime()
    local env=setmetatable({}, {__index=_G})
    execute(setup,env)
    execute(media,env)
    env.API=execute(locals..sync.."\nreturn {queue=QueueSync,queued=function() return refreshQueued end}",env)
    return env
end
local passed=0
local function check(name,body)
    execute(body,runtime())
    passed=passed+1
end

check("Early login defers without creating or styling frames",[=[

        API.queue(); tick()
        assert(calls.created==0 and calls.fetch==0)
        assert(#pending==1 and pending[1].delay==0.5 and API.queued())
    ]=])

check("Core-ready but unregistered media still waits",[=[

        loaded=true
        API.queue(); tick()
        assert(calls.created==0 and calls.fetch==0 and #pending==1)
    ]=])

check("Registered media waits for core startup completion",[=[

        HealBot_Media_Register()
        API.queue(); tick()
        assert(calls.created==0 and calls.fetch==0 and #pending==1)
    ]=])

check("Missing skin data waits and later recovers",[=[

        loaded=true; HealBot_Media_Register()
        Healbot_Config_Skins.HealGroups.test=nil
        API.queue(); tick()
        assert(calls.created==0 and #pending==1)
        Healbot_Config_Skins.HealGroups.test={}
        tick()
        assert(calls.created==4 and calls.styled==1 and #pending==0)
    ]=])

check("Ready startup applies requested textures and fonts then stops retrying",[=[

        loaded=true; HealBot_Media_Register()
        API.queue(); tick()
        assert(calls.created==4 and calls.texture==4 and calls.font==4)
        assert(createdRows[1].appliedTexture=='statusbar:Smooth v2')
        assert(createdRows[1].appliedFont=='font:DefaultFont')
        assert(#pending==0 and not API.queued())
    ]=])

check("Repeated events coalesce into one half-second startup retry",[=[

        API.queue(); API.queue(); API.queue()
        assert(#pending==1)
        tick()
        for index=1,3 do
            API.queue(); API.queue()
            assert(#pending==1 and pending[1].delay==0.5)
            tick()
        end
        loaded=true; HealBot_Media_Register()
        tick()
        assert(calls.styled==1 and #pending==0 and not API.queued())
        API.queue(); tick()
        assert(calls.styled==1 and calls.created==4 and #pending==0)
    ]=])

check("Combat stops polling; the after-combat queue resumes safely",[=[

        API.queue(); tick()
        combat=true; tick()
        assert(calls.created==0 and #pending==0 and not API.queued())
        loaded=true; HealBot_Media_Register()
        combat=false; API.queue(); tick()
        assert(calls.created==4 and #pending==0)
    ]=])

check("Missing globals retries and disabled feature stays inactive after initialization",[=[

        HealBot_Globals=nil
        API.queue(); tick()
        assert(calls.created==0 and #pending==1)
        HealBot_Globals={ForeverPartyJoin=false}
        loaded=true; HealBot_Media_Register()
        tick()
        assert(calls.created==0 and calls.fetch==0 and #pending==0 and not API.queued())
    ]=])

check("Absent skin configuration waits without touching frames",[=[
    loaded=true; HealBot_Media_Register()
    Healbot_Config_Skins=nil
    API.queue(); tick()
    assert(calls.created==0 and #pending==1 and API.queued())
    Healbot_Config_Skins={Current_Skin="ready",HealGroups={ready={}}}
    tick()
    assert(calls.created==4 and calls.styled==1 and #pending==0)
]=])
print("PASS: "..passed.." party startup scenarios (mock events, actual media helpers)")
