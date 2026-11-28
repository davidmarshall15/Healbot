local file=assert(io.open(arg[1] or "HealBot/HealBot_ForeverPeriodic.lua","rb"))
local code=file:read("*a"); file:close()
local baseline=arg[2]=="baseline"
local now,holder=0,"raid1"
local hooks,timers,rows={},{},{}
local watched,iterations,reads,lookups=nil,0,0,0
local eventHandler,secret=nil,{}
local inaccessible=setmetatable({}, {__index=function() error("read inaccessible aura") end})
local entries
local noop=function() end
local frame=setmetatable({}, {__index=function() return noop end})
function frame:SetScript(_,fn) eventHandler=fn end
local function widget()
    local w=setmetatable({}, {__index=function(_,name) if name:match("^%u") then return noop end end})
    function w:ClearAllPoints() self.reanchors=(self.reanchors or 0)+1 end
    function w:Show() self.shown=true end
    function w:Hide() self.shown=false end
    function w:GetStatusBarTexture() return self end
    function w:GetParent() return self end
    function w:GetFrameLevel() return self.level or 6 end
    function w:SetFrameLevel(level) self.level=level end
    function w:GetWidth() return 50 end
    function w:GetHeight() return 20 end
    function w:GetOrientation() return "HORIZONTAL" end
    function w:GetReverseFill() return false end
    function w:SetValue(value) self.amount=value end
    return w
end
local env=setmetatable({HEALBOT_FOREVER=true,SlashCmdList={},HealBot_Buttons=rows,
    UnitClass=function() return "Priest","PRIEST" end,CreateFrame=function() return frame end,
    GetTime=function() return now end,GetSpellBonusHealing=function() return 0 end,
    C_Timer={After=function(delay,callback) timers[#timers+1]={at=now+delay,run=callback} end},
    HealBot_issecretvalue=function(v) return rawequal(v,secret) end,
    canaccesstable=function(t) return t~=inaccessible end,
    UnitGUID=function(unit) return "guid"..unit end,UnitHealthMax=function() return 120 end,
    C_Spell={GetSpellName=function() lookups=lookups+1; return "Prayer of Mending" end},
    C_UnitAuras={GetAuraDataByIndex=function(unit,index,filter)
        assert(filter=="HELPFUL|PLAYER"); reads=reads+1
        if entries and unit==holder then return entries[index] end
        if unit==holder and index==1 then return {spellId=401863,name="Prayer of Mending"} end
    end},
    hooksecurefunc=function(name,fn) hooks[name]=fn end,
    pairs=function(t)
        if t~=watched then return pairs(t) end
        local function count(table_,key) local k,v=next(table_,key); if k then iterations=iterations+1 end; return k,v end
        return count,t,nil
    end,
    HealBot_Unit_Status={DEAD=9},hbv_Skins_GetFrameVar=function() return 3 end,
    HealBot_Media_UpdateTexture=noop,HealBot_Action_BarColourAlpha=function(_,alpha) return alpha end,
    wipe=function(t) for k in pairs(t) do t[k]=nil end end,
}, {__index=_G})
local function makeRow(unit)
    return {unit=unit,frame=1,status={events=true,enabled=true,current=1,alpha=1},range={current=1},
        health={},foreverPeriodic=widget(),gref={Bar=widget(),InHeal=widget()}}
end
for i=1,40 do rows[i]=makeRow("raid"..i) end
rows[41]=makeRow("raid1")
if not baseline then
    local frames=assert(io.open("HealBot/HealBot_ForeverFrames.lua","rb"))
    local helper=assert(frames:read("*a"):gsub("\r\n","\n"):match("(function HealBot_Forever_PositionPrediction%b().-\nend)"))
    frames:close()
    setfenv(assert(loadstring(helper)),env)()
end
watched=setfenv(assert(loadstring(code.."\nreturn buttons")),env)()
local function fire(event,unit,...) eventHandler(frame,event,unit,...) end
local function cast(spell) fire("UNIT_SPELLCAST_SUCCEEDED","player","cast",spell) end
local function advance(t)
    now=t
    for _,timer in ipairs(timers) do
        if not timer.done and timer.at<=now then timer.done=true; timer.run() end
    end
end
cast(401859)
assert(rows[1].foreverPeriodic.shown and rows[41].foreverPeriodic.shown and rows[1].foreverPeriodic.amount==172)
if not baseline then
    local periodic=rows[1].foreverPeriodic
    local before=periodic.reanchors
    for i=1,100 do hooks.HealBot_Action_UpdateHealthButton(rows[1]) end
    assert(periodic.reanchors==before,"unchanged periodic prediction repeatedly reanchors")
    rows[1].gref.InHeal:SetFrameLevel(9)
    hooks.HealBot_Action_UpdateHealthButton(rows[1])
    assert(periodic:GetFrameLevel()==8 and periodic.reanchors==before+1,"skin level did not move periodic overlay")
end
iterations,reads,lookups=0,0,0
for i=1,100 do fire("UNIT_AURA","nameplate"..i) end
assert(iterations==(baseline and 4100 or 0) and reads==0)
local activeWalks=iterations
fire("UNIT_AURA",secret)
holder="raid2"; fire("UNIT_AURA","raid1"); fire("UNIT_AURA","raid2")
assert(not rows[1].foreverPeriodic.shown and not rows[41].foreverPeriodic.shown and rows[2].foreverPeriodic.shown)
if not baseline then
    -- Existing registered bars can be rebound without an unregister/register pair.
    rows[41].unit="raid2"; hooks.HealBot_Action_ResetrCallsUnit(rows[41])
    assert(rows[41].foreverPeriodic.shown)
    hooks.HealBot_Action_UnregisterUnitEvents(rows[2])
    assert(not rows[2].foreverPeriodic.shown and rows[41].foreverPeriodic.shown)
end
advance(30); cast(1240826)
local recipient=baseline and rows[2] or rows[41]
assert(recipient.foreverPeriodic.amount==298)
advance(180)
assert(recipient.foreverPeriodic.shown,"earlier cast timer cancelled the recast")
advance(210)
if not baseline then assert(not recipient.foreverPeriodic.shown,"expired estimate remained painted") end
iterations,reads,lookups=0,0,0
for i=1,100 do fire("UNIT_AURA","nameplate"..i) end
assert(iterations==(baseline and 4100 or 0) and reads==0)
print(string.format("%s: 100 untracked-unit aura events visited %d raid bars while active and %d after expiry",
    baseline and "BASELINE" or "PASS",activeWalks,iterations))
if not baseline then
    cast(401859)
    assert(recipient.foreverPeriodic.shown)
    for _,id in ipairs({1240848,1240849}) do
        entries={inaccessible,{spellId=id,name=secret}}
        fire("UNIT_AURA",holder)
        assert(recipient.foreverPeriodic.shown and recipient.foreverPeriodic.amount==172)
        entries={{spellId=secret,name=secret}}
        fire("UNIT_AURA",holder)
        assert(not recipient.foreverPeriodic.shown)
    end
    entries={{spellId=secret,name="Prayer of Mending"}}
    fire("UNIT_AURA",holder); assert(recipient.foreverPeriodic.shown)
    env.SlashCmdList.HBPERIODIC("")
    assert(not recipient.foreverPeriodic.shown)
    advance(400)
    env.SlashCmdList.HBPERIODIC("")
    cast(401859)
    assert(recipient.foreverPeriodic.shown)
end
