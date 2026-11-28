-- A status bar can be bound before its native icon widgets are built in combat.
-- A restriction, world, or identity change must still queue both normal scans.
local file=assert(io.open("tests/native_buff_casters.lua","rb"))
local source=file:read("*a"):gsub("\r\n","\n")
file:close()
local prefix=assert(source:match("^(.-)\nlocal function admits%("))
local fixture=assert(loadstring(prefix.."\nreturn fixture"))()
local d=fixture("MAGE",4,function(env)
    env.C_RestrictedActions={}
    env.HealBot_Events_UnitBuff=function(button) button.queuedBuff=true end
    env.HealBot_Events_UnitDebuff=function(button) button.queuedDebuff=true end
end)
local party=d.button("party1")
d.combat(true)
local raid=d.button("raid15")
local inactive=d.button("raid2")
inactive.status.events=false
assert(d.row(raid)==nil,"fixture requires a bound bar without native widgets")
local function prime(button)
    button.queuedBuff,button.queuedDebuff=false,false
    button.aura={buff={publicGeneration=3},
                 debuff={scanUnit=button.unit}}
end
local function fresh(button)
    assert(button.aura.buff.update and button.queuedBuff,button.unit.." missed its helpful scan")
    assert(button.aura.debuff.update and button.queuedDebuff,button.unit.." missed its harmful scan")
    assert(not button.aura.buff.publicGeneration and not button.aura.debuff.scanUnit)
end
for _,event in ipairs({"ADDON_RESTRICTION_STATE_CHANGED","PLAYER_ENTERING_WORLD"}) do
    prime(party); prime(raid); prime(inactive)
    local before=#d.frames
    d.fire(event)
    fresh(party); fresh(raid)
    assert(not inactive.queuedBuff and not inactive.queuedDebuff)
    assert(#d.frames==before,"refreshing an existing bar allocated widgets in combat")
end
for _,hook in ipairs({"HealBot_UpdateUnitGUIDChange","HealBot_SetUnitDisconnectChange"}) do
    prime(raid)
    d.hook(hook,raid)
    fresh(raid)
end
d.combat(false)
prime(party)
d.fire("ADDON_RESTRICTION_STATE_CHANGED")
fresh(party)
print("PASS: both scans are renewed on roster bars across restrictions, rebinds and reconnects, with or without native rows")
