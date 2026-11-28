local path=arg[1] or "HealBot"
local baseline=arg[2]=="baseline"
local function read(file)
    local f=assert(io.open(file,"rb"));local value=f:read("*a"):gsub("\r\n","\n")
    f:close();return value
end
local native=assert(read("tests/native_buff_casters.lua"):match("^(.-)\nlocal function admits%("))
native=native:gsub('local source=read%("HealBot/', 'local source=read("'..path..'/')
local fixture=assert(loadstring(native.."\nreturn fixture"))()
local d=fixture("DRUID",4)
d.skin.limits={4,2,2}
local noop=function() end
local donor=d.button()
donor.status.active=true
local context=d.env.HealBot_Forever_PrepareArrivalAuraContext()
local rows={}
local sizeWrites,fontWrites,queued=0,0,{}
local function graphic()
    local region=setmetatable({},{__index=function() return noop end})
    function region:GetStatusBarTexture() return self end
    function region:GetTexture() return 123 end
    return region
end
for i=1,40 do
    local row={unit="raid"..i,frame=1,healthBar=graphic(),background=graphic(),border=graphic(),
        nameText=graphic(),healthText=graphic(),reserve=true,bindingGeneration=0}
    function row:GetFrameLevel() return 5 end
    function row:SetSize() sizeWrites=sizeWrites+1 end
    function row:Hide() end
    rows[i]=row
    d.env.HealBot_Forever_SkinArrivalAuras(row,donor,context)
end
local e=d.env
local watchRefresh=e.HealBot_Forever_RefreshBuffExclusions
e.HealBot_Globals.ForeverPartyJoin=true
e.HealBot_Buttons={donor}
e.HealBot_retLuVars=function() return true end
e.HealBot_Media_retLuVars=function() return true end
e.HealBot_Media_UpdateTexture=noop
e.HealBot_Media_UpdateFont=function() fontWrites=fontWrites+1 end
e.hbv_Skins_GetFrameVar=function() return 1 end
e.Healbot_Config_Skins={Current_Skin="Fixture",HealGroups={Fixture={}}}
e.IsInRaid=function() return true end
e.UnitExists=function(unit) return unit=="raid1" end
e.UnregisterUnitWatch=noop
e.C_Timer={After=function(_,callback) queued[#queued+1]=callback end}
local hooks={}
e.hooksecurefunc=function(name,fn) hooks[name]=fn end
-- Install the real party hooks, queue, Sync and ApplySkin around a warmed
-- 40-slot roster. Grid positioning and aux controls are outside this check.
local party=read(path.."/HealBot_ForeverPartyJoin.lua")..[[
return function(warmed)
    rows,frame,frameSkin,rosterMode,skinDirty=warmed,1,"Fixture","raid",false
    PositionReservedRows=function() return true end
    SkinExtras=function() end
end]]
setfenv(assert(loadstring(party)),e)()(rows)
local function drain()
    while #queued>0 do table.remove(queued,1)() end
end
e.HealBot_Forever_RefreshBuffExclusions=function()
    watchRefresh()
    if hooks.HealBot_Forever_RefreshBuffExclusions then hooks.HealBot_Forever_RefreshBuffExclusions() end
end
d.globals.WatchHoT.DRUI[774]=1
e.HealBot_Forever_RefreshBuffExclusions()
drain()
for _,row in ipairs(rows) do
    local first=row.arrivalAuras[1].container
    assert(first.groups.hbcahot.options.candidateFilters.includeSpellIDs[774],"reserve watch did not update in place")
    assert(not first.groups.hbcahotEveryone.options.candidateFilters.includeSpellIDs[774])
end
assert(sizeWrites==(baseline and 40 or 0) and fontWrites==(baseline and 80 or 0))
local watchSizes,watchFonts=sizeWrites,fontWrites
hooks.HealBot_Options_framesChanged()
drain()
assert(sizeWrites==watchSizes+40 and fontWrites==watchFonts+80,"real skin change failed to restyle raid")
print(string.format("%s: one watch edit -> %d row sizes and %d font applications; explicit skin change still visits 40 rows",baseline and "BASELINE" or "PASS",watchSizes,watchFonts))
