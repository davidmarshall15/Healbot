local function read(path)
    local file=assert(io.open(path,"rb"))
    local data=file:read("*a")
    file:close()
    return data:gsub("\r\n","\n")
end
local source=assert(read("tests/native_buff_casters.lua"):match("^(.-)\nlocal function admits%("))
local fixture=assert(loadstring(source.."\nreturn fixture"))()
local d=fixture("PRIEST",4)
d.skin.limits={4,2,0}
d.skin.selfMarker=true
local override={BUFFI15EN={[2]=true},DI15EN={[1]=true}}
local e=d.env
local original=e.hbv_Skins_GetIconBoolean
e.hbv_Skins_GetIconBoolean=function(key,frame,set)
    if override[key] then return override[key][set] end
    return original(key,frame,set)
end
e.hbv_Skins_GetFrameVar=function(_,key,frame)
    assert(key=="HA" and frame==3)
    return .8
end
local dim=.5
e.HealBot_Action_BarColourAlpha=function(_,alpha,mult) assert(mult==1); return alpha*dim end
local button=d.button()
button.framecol=3
button.alpha=.5 -- opacity inherited from an outer window
local function effective(region)
    local alpha=1
    while region do alpha=alpha*(region.alpha or 1); region=region.parent end
    return alpha
end
local function eq(actual,expected) assert(math.abs(actual-expected)<.00001,actual.." vs "..expected) end
local actualSetEnabled=assert(read("HealBot/HealBot_Action.lua"):match("(function HealBot_Action_setEnabled%(.-\nend)"))
local normal=setmetatable({HEALBOT_FOREVER=true,HealBot_issecretvalue=function() return false end,
    HealBot_Aura_Update_AllIcons=function(b) d.hook("HealBot_Aura_Update_AllIcons",b) end},
    {__index=function() return function() end end})
setfenv(assert(loadstring(actualSetEnabled)),normal)()
button.health={absorbs=0}
normal.HealBot_Action_setEnabled(button,true,.25)
local main=assert(d.row(button,1))
local extra=assert(d.row(button,2))
local function debuff(b)
    for _,row in ipairs(d.frames) do
        if row.parent==b and row.groups.hbcadb then return row.groups.hbcadb.icon.boundIcon end
    end
    error("missing native debuff row")
end
local own=main.groups.hbcahot.icon
local everyone=main.groups.hbcahotEveryone.icon.boundIcon
eq(effective(own.boundIcon),.5*.25)
eq(effective(everyone),.5*.25)
eq(effective(extra.groups.hbcahot.icon.boundIcon),.5*.4)
eq(effective(debuff(button)),.5*.4)
assert(not main.alpha and not own.alpha and not own.cooldown.alpha and not own.count.alpha and not own.hbcaMarker.alpha)
local late=e.CreateFrame("AuraButton",nil,main)
main.groups.hbcahot.options.initializeFrame(late)
eq(effective(late.boundIcon),.5*.25)
local writes,lookups=0,0
own.boundIcon.SetAlpha=function(self,a) self.alpha=a; writes=writes+1 end
local lookup=e.HealBot_WoWAPI_SpellName
e.HealBot_WoWAPI_SpellName=function(...) lookups=lookups+1; return lookup(...) end
d.combat(true)
local allocated=#d.frames
lookups=0
normal.HealBot_Action_setEnabled(button,true,.75)
eq(effective(own.boundIcon),.5*.75)
eq(effective(late.boundIcon),.5*.75)
eq(effective(debuff(button)),.5*.4)
for i=1,40 do d.hook("HealBot_Aura_Update_AllIcons",button) end
assert(writes==1 and lookups==0 and #d.frames==allocated,"unchanged updates wrote art, scanned spells, or allocated")
override.BUFFI15EN[1]=true; d.hook("hbv_Skins_SetIconVar",true,"BUFFI15EN",1,1)
eq(effective(own.boundIcon),.5*.4)
override.DI15EN[1]=false; d.hook("hbv_Skins_SetIconVar",false,"DI15EN",1,1)
eq(effective(debuff(button)),.5*.75)
assert(#d.frames==allocated and lookups==0,"editing opacity performed unrelated work")
d.combat(false)
dim=.25; d.hook("HealBot_Skins_ResetSkin","bar",button)
eq(effective(own.boundIcon),.5*.2)

-- Exercise the reserve painter's public range selection and real prepared
-- row factory; the status-bar colour alpha is independent of child opacity.
local row={unit="raid23",frame=1,alpha=.5,healthBar={},GetFrameLevel=function() return 5 end}
function row.healthBar:SetStatusBarColor(_,_,_,alpha) self.barAlpha=alpha end
e.HealBot_Forever_SkinArrivalAuras(row,button)
local function reserve(set)
    for _,item in ipairs(row.arrivalAuras) do
        if item.set==set then return item.container.groups.hbcahot.icon.boundIcon end
    end
end
local inRange,checked=false,true
local partyJoin=read("HealBot/HealBot_ForeverPartyJoin.lua")
local rangeCode=assert(partyJoin:match("(local inRange,checked=UnitInRange%(unit%).-)\n    local incoming=row.incomingBar"))
local healthColour=assert(partyJoin:match("(local function ApplyHealthColour%b().-\nend)"))
local reserveEnv={UnitInRange=function() return inRange,checked end,
    Get=function(_,key) return ({HA=.9,ORA=.3,HLTH=1})[key] end,
    Colour=function() return 1,1,1 end,secret=function() return false end,
    HealBot_Forever_SetArrivalIconOpacity=e.HealBot_Forever_SetArrivalIconOpacity}
local paint=setfenv(assert(loadstring(healthColour.."\nreturn function(row) local unit,event=row.unit,'UNIT_HEALTH' "..rangeCode.." end")),reserveEnv)()
override.BUFFI15EN[1]=false; d.hook("hbv_Skins_SetIconVar",false,"BUFFI15EN",1,1)
paint(row)
eq(row.healthBar.barAlpha,.3)
eq(effective(reserve(1)),.5*.3)
eq(effective(reserve(2)),.5*.9)
eq(effective(row.arrivalDebuffs.db.container.groups.hbcadb.icon.boundIcon),.5*.3)
inRange=true
local reserveWrites=0
reserve(1).SetAlpha=function(self,a) self.alpha=a; reserveWrites=reserveWrites+1 end
paint(row); paint(row)
eq(effective(reserve(1)),.5*.9)
assert(reserveWrites==1)
checked=false; row.eventInRange=false; paint(row)
eq(effective(reserve(1)),.5*.3)
override.BUFFI15EN[1]=true; d.hook("hbv_Skins_SetIconVar",true,"BUFFI15EN",1,1)
eq(effective(reserve(1)),.5*.9)
assert(not row.healthBar.alpha)
print("PASS: normal and reserve native icon opacity follows range, enabled-opacity overrides, skin refresh and late pool creation; parent alpha applies once; unchanged updates skip writes and spell scans")
