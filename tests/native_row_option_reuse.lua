local source=assert(io.open("tests/native_buff_casters.lua","rb"))
local prefix=assert(source:read("*a"):gsub("\r\n","\n"):match("^(.-)\nlocal function admits%("))
source:close()
local fixture=assert(loadstring(prefix.."\nreturn fixture"))()
local d=fixture("DRUID",4)
local e=d.env
d.skin.limits={4,2,2}
local ordinary=d.button("raid1")
local context=e.HealBot_Forever_PrepareArrivalAuraContext()
local reserve={}
for i=2,32 do
    local row={unit="raid"..i,frame=1,healthBar={},GetFrameLevel=function() return 5 end}
    reserve[#reserve+1]=row
    e.HealBot_Forever_SkinArrivalAuras(row,ordinary,context)
end
local allocations=#d.frames
local snapshot
e.HealBot_Forever_UpdateQueuedArrivalFilters=function(filters) snapshot=filters end
local function checkDuration(value)
    assert(#d.frames==allocations,"option change rebuilt native widgets")
    for _,frame in ipairs(d.frames) do
        local own=frame.groups and frame.groups.hbcahot
        if own then
            assert(frame.enabled,"option retired a reusable row")
            assert(own.options.candidateFilters.maxDuration==value)
            assert(frame.groups.hbcahotEveryone.options.candidateFilters.maxDuration==value)
        end
    end
end
e.HealBot_CombatAuras_SetOption("maxdur",60)
checkDuration(60)
assert(snapshot,"pending cold reserve rows retained an obsolete policy")
e.HealBot_CombatAuras_SetOption("persist",not d.globals.CombatAurasPersistDebuffs)
checkDuration(60)
d.combat(true)
e.HealBot_CombatAuras_SetOption("maxdur",45)
checkDuration(45)
d.config.BuffCustomWatchInCombat=false
e.HealBot_CombatAuras_SetOption("maxdur",90)
checkDuration(45)
d.combat(false)
checkDuration(90)

local scheduled,inline=0,0
e.HealBot_Forever_QueueReserveAuraRefresh=function() scheduled=scheduled+1 end
local skin=e.HealBot_Forever_SkinArrivalAuras
e.HealBot_Forever_SkinArrivalAuras=function(...) inline=inline+1; return skin(...) end
e.HealBot_CombatAuras_SetOption("size",19)
assert(scheduled==1 and inline==0,"full reset synchronously rebuilt historical reserve rows")
d.combat(true)
e.HealBot_CombatAuras_SetOption("size",22)
assert(scheduled==2 and inline==0,"combat edit lost the deferred reserve refresh")
print("PASS: 31 reserves and an ordinary bar retain native rows for duration and visibility changes; structural edits use the roster queue")
