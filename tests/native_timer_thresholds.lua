-- Run production skin and native factory code. The test client records native
-- bindings and evaluates their public breakpoints without supplying any auras.
local function read(path)
    local file=assert(io.open(path,"rb"))
    local source=file:read("*a")
    file:close()
    return source:gsub("\r\n","\n"):gsub("^\239\187\191","")
end
local prefix=assert(read("tests/native_buff_casters.lua"):match("^(.-)\nlocal function admits%("))
local widget="        function f:SetIcon(v)"
prefix=prefix:gsub(widget:gsub("([%(%)])","%%%1"),function()
    return [[        function f:AddAuraSlot(key,filter,options)
            self:AddAuraGroup(key,filter,options)
        end
        function f:SetDurationText(text,options)
            if env.rejectPolicy and options.textColor then error("unsupported duration policy") end
            if env.rejectFormatter and options.textFormatter then error("formatter unavailable") end
            self.boundText,self.durationOptions=text,options
        end
]]..widget
end,1)
local fixture=assert(loadstring(prefix.."\nreturn fixture"))()
local d=fixture("PRIEST",4)
local e=d.env
local activeThreshold=12
local old=e.hbv_Skins_GetIconTextVar
e.hbv_Skins_GetIconTextVar=function(key,...)
    if key=="BUFFDURTHRH" then return activeThreshold end
    if key=="BUFFDURWARN" then return 4 end
    if key=="DBDURTHRH" then return 8 end
    if key=="DBDURWARN" then return 3 end
    return old(key,...)
end
e.UnitIsFriend=function(_,unit) return unit~="arena1" end
e.Enum={LuaCurveType={Step=1},DurationTextBindingProperty={RemainingDuration=0},NumericRuleFormatRounding={Down=2}}
e.CreateColor=function(...) return {...} end
local curves=0
e.C_CurveUtil={CreateColorCurve=function()
    curves=curves+1
    return {SetType=function(self,t) self.kind=t end,
        AddPoint=function(self,t,c) self[#self+1]={t,c} end}
end}
e.C_StringUtil={CreateNumericRuleFormatter=function()
    return {AddBreakpoint=function(self,rule) self.rule=rule end}
end}
local function color(icon,t)
    local policy=assert(icon.durationOptions).textColor
    assert(policy.property==0 and policy.curve.kind==1)
    local selected
    for _,point in ipairs(policy.curve) do if t>=point[1] then selected=point[2] end end
    return table.concat(selected,",")
end
local function debuffIcon(button)
    local icon
    for _,f in ipairs(d.frames) do
        if f.parent==button and f.groups.hbcadb then icon=f.groups.hbcadb.icon end
    end
    return assert(icon)
end
local b=d.button("party1")
local own=assert(d.row(b)).groups.hbcahot.icon
assert(color(own,5.49)=="1,0.5,0,1" and color(own,5.5)=="1,1,1,1","helpful warning boundary")
assert(color(own,13.49)=="1,1,1,1" and color(own,13.5)=="1,1,1,0","helpful display threshold")
assert(own.durationOptions.textFormatter.rule.format=="%d" and own.durationOptions.textFormatter.rule.rounding==2)
assert(own.cooldown.hideNumbers and own.count,"exactly one timer and independent stack display")
local harmful=debuffIcon(b)
assert(color(harmful,4.49)=="0,1,0,1" and color(harmful,4.5)=="1,1,1,1")
assert(color(harmful,9.5)=="1,1,1,0","debuff threshold uses its own skin")
b.gref.txt.expire[1]:SetPoint("TOPRIGHT",b.gref.icon[1],"BOTTOMRIGHT",-4,3)
d.hook("HealBot_Skins_ResetSkin","bar",b)
own=assert(d.row(b)).groups.hbcahot.icon
assert(own.boundText.fontSize==12 and own.boundText.point[1]=="TOPRIGHT" and own.boundText.point[4]==-4)
local before=curves
local b2=d.button("raid3")
assert(d.row(b2).groups.hbcahot.icon.durationOptions==own.durationOptions and curves==before,"duplicate curves across roster")
local enemy=d.button("arena1"); assert(color(debuffIcon(enemy),1)=="1,0,0,1")
local frames=#d.frames
d.combat(true); d.combat(false)
assert(#d.frames==frames and curves==before+2,"combat handoff allocated timer frames or curves")
-- An empty raid position borrows a visible button's geometry. Its native
-- warning palette must survive a donor leaving, changing reaction or being
-- replaced by another geometrically identical donor during a roster pass.
do
    d.globals.CombatAurasNativeWeakenedSoul=true
    e.HealBot_Forever_WatchesWeakenedSoul=function() return true end
    d.skin.limits={4,2,2}
    local row={unit="raid28",frame=1,healthBar={},GetFrameLevel=function() return 5 end}
    local originalFriend,originalSecret=e.UnitIsFriend,e.HealBot_issecretvalue
    e.HealBot_Forever_SkinArrivalAuras(row,b2)
    local helpful,db,slot=row.arrivalAuras,row.arrivalDebuffs.db,row.arrivalDebuffs.slot
    assert(#helpful==3 and db and slot)
    for _,item in ipairs(helpful) do assert(color(item.container.groups.hbcahot.icon,1)=="1,0.5,0,1") end
    assert(color(db.container.groups.hbcadb.icon,1)=="0,1,0,1")
    assert(color(slot.container.groups.hbcaweakenedSoul.icon,1)=="0,1,0,1")
    local allocated=#d.frames
    local secret={}
    e.HealBot_issecretvalue=function(v) return v==secret end
    for _,reaction in ipairs({false,secret,1,0,true,"missing"}) do
        e.UnitIsFriend=function() if reaction~="missing" then return reaction end end
        e.HealBot_Forever_SkinArrivalAuras(row,enemy)
        assert(#d.frames==allocated and row.arrivalAuras==helpful and row.arrivalDebuffs.db==db and row.arrivalDebuffs.slot==slot,
            "donor reaction rebuilt native aura rows on an empty raid position")
    end
    e.UnitIsFriend,e.HealBot_issecretvalue=originalFriend,originalSecret
    d.skin.limits={4,0,0}
    d.globals.CombatAurasNativeWeakenedSoul=false
end
activeThreshold=2
d.hook("hbv_Skins_SetIconTextVar",2,"BUFFDURTHRH",1,1)
own=assert(d.row(b)).groups.hbcahot.icon
assert(color(own,3.49)=="1,0.5,0,1" and color(own,3.5)=="1,1,1,0","threshold smaller than warning")
e.rejectPolicy=true
local fallback=d.button("party2")
own=assert(d.row(fallback)).groups.hbcahot.icon
assert(not own.boundText and not own.cooldown.hideNumbers and own.cooldown.countdown.fontSize==12,
    "a rejected native policy should keep a styled cooldown timer")
e.rejectPolicy=false; e.rejectFormatter=true
local partial=d.button("party3")
own=assert(d.row(partial)).groups.hbcahot.icon
assert(own.boundText and own.durationOptions.textColor and not own.durationOptions.textFormatter
    and own.cooldown.hideNumbers,"partial API should keep threshold colors")
e.rejectFormatter=false
d.globals.CombatAurasNumsFollowSkin=false; d.globals.CombatAurasNums=true
local always=d.button("raid4")
own=assert(d.row(always)).groups.hbcahot.icon
assert(not own.boundText and not own.cooldown.hideNumbers,"explicit Always show inherited skin threshold")
d.globals.CombatAurasNumsFollowSkin=true; d.globals.CombatAurasNums=nil
e.rejectFormatter=false; e.C_CurveUtil=nil
local oldClient=d.button("party4")
own=assert(d.row(oldClient)).groups.hbcahot.icon
assert(not own.boundText and not own.cooldown.hideNumbers,"older clients retain the original timer")
d.skin.durations[1]=false
local off=d.button("party1")
own=assert(d.row(off)).groups.hbcahot.icon
assert(not own.boundText and own.cooldown.hideNumbers and own.count,"disabling duration affects only duration")
print("PASS: native duration and warning thresholds, colors, font placement, one countdown, curve sharing, old and partial APIs, combat handoff")
