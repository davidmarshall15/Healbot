-- Exercise the addon's real native button factory for both spell types.
local f=assert(io.open("tests/native_buff_casters.lua","rb"))
local prefix=assert(f:read("*a"):gsub("\r\n","\n"):match("^(.-)\nlocal function admits%("))
f:close()
if arg[1] then prefix=prefix:gsub('local source=read%("HealBot/HealBot_CombatAuras.lua"%)','local source=read(arg[1])') end
local errors={}
local function check(ok,reason) if not ok then errors[#errors+1]=reason end end
local formatterCount=0
local function numberAt(formatter,t)
    local rule
    for _,r in ipairs(formatter.rules) do if t>=r.threshold then rule=r end end
    return assert(rule).format=="%d" and math.floor(t) or tonumber(rule.format)
end
local function configure(e)
    local getText=e.hbv_Skins_GetIconTextVar
    e.hbv_Skins_GetIconTextVar=function(key,...)
        if key:find("DURTHRH") then return 99 end
        if key:find("DURWARN") then return 3 end
        return getText(key,...)
    end
    e.Enum={LuaCurveType={Step=1},DurationTextBindingProperty={RemainingDuration=0},NumericRuleFormatRounding={Down=2}}
    e.C_CurveUtil={CreateColorCurve=function() return {SetType=function() end,AddPoint=function() end} end}
    e.CreateColor=function(...) return {...} end
    e.C_StringUtil={CreateNumericRuleFormatter=function()
        formatterCount=formatterCount+1
        return {rules={},SetBreakpoints=function(self,rules)
                if e.rejectRules then error("breakpoint count unsupported") end
                self.rules=rules
            end,
            FormatNumber=function(self,t) return e.blankLiteral and "" or tostring(numberAt(self,t)) end,
            AddBreakpoint=function(self,rule) self.rules[#self.rules+1]=rule end}
    end}
end
-- Add the optional client method to the common mock widget. Keep production
-- policy and layout generation intact.
prefix=prefix:gsub("        function f:SetIcon%(v%)",function()
    return "        function f:SetDurationText(text,opts) self.duration=text; self.policy=opts end\n        function f:SetIcon(v)"
end,1)
local fixture=assert(loadstring(prefix.."\nreturn fixture"))()
local d=fixture("PRIEST",4,configure)
local button=d.button("party1")
local own=assert(d.row(button)).groups.hbcahot.icon
local harmful
for _,frame in ipairs(d.frames) do if frame.parent==button and frame.groups.hbcadb then harmful=frame.groups.hbcadb.icon end end
for _,entry in ipairs({{"helpful",own},{"harmful",assert(harmful)}}) do
    local name,icon=unpack(entry)
    check(icon.duration.width==0 and icon.count.width==0,name.." squeezes skin text into icon width")
    local formatter=assert(icon.policy.textFormatter)
    local boundaryError=false
    for tick=0,10049 do
        local remaining=tick/100
        if numberAt(formatter,remaining)~=math.max(0,math.floor(remaining-.5)) then boundaryError=true; break end
    end
    check(not boundaryError,name.." seconds differ from legacy countdown")
    check(numberAt(formatter,205)==205,name.." imported long countdown is truncated")
end
check(own.policy.textFormatter==harmful.policy.textFormatter and formatterCount==1,"formatter duplicated across icons")
local count=#d.frames
d.combat(true); d.combat(false)
check(#d.frames==count and formatterCount==1,"combat transition allocated new objects")
for _,flag in ipairs({"rejectRules","blankLiteral"}) do
    local partial=fixture("PRIEST",4,function(e) configure(e); e[flag]=true end)
    local icon=partial.row(partial.button()).groups.hbcahot.icon
    check(#icon.policy.textFormatter.rules==1 and numberAt(icon.policy.textFormatter,4.1)==4,
        "partial API failed to use basic seconds formatter: "..flag)
end
assert(#errors==0,table.concat(errors,", "))
print("PASS: natural width, 10,050 time samples on both helpful and harmful icons, shared formatter and unchanged combat handoff")
