-- Count native widget calls at the end of the live health/debuff and reserve
-- aura-update paths. Warm frames first so initial setup is measured separately.
local prefix=arg[1] or "HealBot"
local baseline=arg[2]=="baseline"
local function read(path)
    local file=assert(io.open(path,"rb")); local value=file:read("*a"):gsub("\r\n","\n")
    file:close(); return value
end
local function wrapWrites(frame,counters)
    for method in pairs(counters) do
        local old=frame[method]
        frame[method]=function(self,...)
            counters[method]=counters[method]+1
            return old(self,...)
        end
    end
end
local regular=assert(read("tests/forever_frames.lua"):match('^(.-)\nlocal b=button%("party1'))
regular=regular:gsub('loadAddon%("HealBot/', 'loadAddon("'..prefix..'/')
local hooks,newButton,secret,env=assert(loadstring(regular.."\nreturn hooks,button,secret,env"))()
local buttons,writes={},{SetShown=0,SetAlpha=0}
for i=1,40 do
    local button=newButton("raid"..i)
    hooks.HealBot_Action_RegisterUnitEvents(button)
    buttons[i]=button
    for _,overlay in pairs(button.foreverDebuffs) do wrapWrites(overlay,writes) end
end
for wave=1,40 do
    local hook=wave%2==0 and hooks.HealBot_Action_UpdateHealthButton or hooks.HealBot_Aura_CheckUnitDebuffs
    for _,button in ipairs(buttons) do hook(button) end
end
local regularWrites=writes.SetShown+writes.SetAlpha
assert(regularWrites==(baseline and 6400 or 0),"redundant ordinary overlay writes")
local button=buttons[1]
button.status.alpha=0.6
hooks.HealBot_Action_UpdateHealthButton(button)
assert(writes.SetAlpha==(baseline and 3202 or 2) and button.foreverDebuffs.all.alpha==0.6)
button.status.alpha=secret
hooks.HealBot_Action_UpdateHealthButton(button)
hooks.HealBot_Action_UpdateHealthButton(button)
assert(rawequal(button.foreverDebuffs.all.alpha,secret))
button.status.alpha=0.6
hooks.HealBot_Action_UpdateHealthButton(button)
assert(button.foreverDebuffs.all.alpha==0.6)
env.HealBot_Config_Cures.CDCshownHBDispelOnly=true
hooks.HealBot_Action_UpdateHealthButton(button)
assert(not button.foreverDebuffs.all.shown and button.foreverDebuffs.dispel.shown)
local native=assert(read("tests/native_buff_casters.lua"):match("^(.-)\nlocal function admits%("))
native=native:gsub('local source=read%("HealBot/', 'local source=read("'..prefix..'/')
local fixture=assert(loadstring(native.."\nreturn fixture"))()
local d=fixture("DRUID",4)
d.skin.limits={4,2,2}
local donor=d.button()
local rows,arrivals={},{SetShown=0}
local function present(row) d.env.HealBot_Forever_UpdateArrivalAuras(row) end
local pass=d.env.HealBot_Forever_PrepareArrivalAuraContext()
for i=1,40 do
    local row={unit="raid"..i,frame=1,healthBar={},GetFrameLevel=function() return 5 end}
    d.env.HealBot_Forever_SkinArrivalAuras(row,donor,pass)
    present(row)
    rows[i]=row
    assert(#row.arrivalAuras==3)
    for _,item in ipairs(row.arrivalAuras) do wrapWrites(item.container,arrivals) end
end
for wave=1,40 do for _,row in ipairs(rows) do present(row) end end
local reserveWrites=arrivals.SetShown
assert(reserveWrites==(baseline and 4800 or 0),"redundant reserve writes")
local row=rows[1]
d.env.UnitIsConnected=function() return false end
present(row)
for _,item in ipairs(row.arrivalAuras) do assert(not item.container.shown) end
d.env.UnitIsConnected=function() return true end
present(row)
for _,item in ipairs(row.arrivalAuras) do assert(item.container.shown==(item.container.hbcaHasBuffs~=false)) end
print(string.format("%s: 40 x 40 warm UI updates -> %d ordinary overlay SetAlpha/SetShown and %d reserve helpful SetShown calls",baseline and "BASELINE" or "PASS",regularWrites,reserveWrites))
