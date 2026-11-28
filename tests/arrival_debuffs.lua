local f=assert(io.open("tests/native_buff_casters.lua","rb"))
local prefix=assert(f:read("*a"):gsub("\r\n","\n"):match("^(.-)\nlocal function admits%("))
f:close()
prefix=prefix:gsub("        function f:AddAuraGroup",[[
        function f:AddAuraSlot(key,filter,options)
            if env.rejectSlot then error("injected unavailable native slot") end
            options.maxFrameCount=1
            return self:AddAuraGroup(key,filter,options)
        end
        function f:AddAuraGroup]],1)
local d=assert(loadstring(prefix.."\nreturn fixture"))()("PRIEST",3)
local e=d.env
local scoped,allowed,exists,connected,combatIcon=true,false,false,true,true
local cures={DebuffWatch=true,DebuffWatchInCombat=true}
local types=""
local typeQueries,unitQueries=0,0
e.HealBot_Config_Cures=cures
e.HealBot_Forever_DebuffsEnabled=function() return cures.DebuffWatch and cures.DebuffWatchInCombat end
e.UnitExists=function(unit) return unit=="party1" or exists end
e.UnitIsConnected=function() return connected end
local auraFile=assert(io.open("HealBot/Healbot_Aura.lua","rb"))
local auraSource=auraFile:read("*a"):gsub("\r\n","\n"); auraFile:close()
local matches=assert(auraSource:match("(do\n    local function public%(value%).-\nend)\n\nfunction HealBot_Aura_CheckCurDebuff"))
local compile=assert(auraSource:match('(do\n    local names={"Magic","Curse","Disease","Poison","Bleed"}.-\nend)'))
local tank,raid={MainTanks=true},{Raid=true}
e.HealBot_Panel_IsTank=function() return allowed end
e.HealBot_Options_retDebuffWatchTarget=function(name)
    if types==name then return scoped and tank or raid end
end
setfenv(assert(loadstring(matches.."\n"..compile)),e)()
local configuredTypes=e.HealBot_Forever_GetDebuffTypes
e.HealBot_Forever_GetDebuffTypes=function(button)
    if button then unitQueries=unitQueries+1 else typeQueries=typeQueries+1 end
    return configuredTypes(button)
end
e.HealBot_Aura_GetDebuffIconPreference=function(_,inCombat) return inCombat and combatIcon or false end
e.HealBot_Aura_GetTrackedDebuffIconSet=function(button) return allowed and 2 or nil end
e.HealBot_Forever_WatchesWeakenedSoul=function() return true end
e.HealBot_Timers_Set=function() end
d.globals.CustomDebuffsIconSet={[6788]=2}
local donor=d.button("party1")
local rows={}
for i=1,28 do rows[i]={unit="raid"..i,frame=1,healthBar={},GetFrameLevel=function() return 5 end} end
local function skin()
    local context=e.HealBot_Forever_PrepareArrivalAuraContext()
    for _,row in ipairs(rows) do e.HealBot_Forever_SkinArrivalAuras(row,donor,context) end
end
skin()
for _,row in ipairs(rows) do assert(not row.arrivalDebuffs,"default empty configuration created harmful containers") end
local hot=rows[1].arrivalAuras[1].container
types="Magic"; d.globals.CombatAurasNativeWeakenedSoul=true
local before=typeQueries
skin(); assert(typeQueries==before+1,"dispel configuration scanned separately for empty positions")
local row=rows[1]; local db=row.arrivalDebuffs.db; local slot=row.arrivalDebuffs.slot
assert(db and slot and not db.shown and not slot.shown and row.arrivalAuras[1].container==hot)
local count=#d.frames
skin(); assert(#d.frames==count and row.arrivalDebuffs.db==db and row.arrivalDebuffs.slot==slot)
local index=57
local oldX=slot.container.point[4]
donor.gref.icon[index].GetCenter=function() return 109,200 end
skin(); assert(slot.container.point[4]==oldX+9,"late-join custom slot did not move with configured debuff set")
assert(#d.frames==count,"position-only change rebuilt harmful frames")
d.combat(true)
exists=true
e.HealBot_Forever_UpdateArrivalAuras(row)
assert(not db.shown and not slot.shown,"out-of-scope target was shown")
allowed=true; e.HealBot_Forever_UpdateArrivalAuras(row)
assert(db.shown and slot.shown and db.container.groups.hbcadb.options.candidateFilters.includeDispelTypes.Magic)
local writes=db.container.filterWrites
local queries=unitQueries
for _=1,50 do e.HealBot_Forever_UpdateArrivalAuras(row,false) end
assert(db.container.filterWrites==writes and unitQueries==queries,"health repaint re-evaluated scoped dispel targets")
d.config.BuffWatch=false; e.HealBot_Forever_UpdateArrivalAuras(row)
assert(db.shown and slot.shown and not hot.shown,"buff monitor setting hid harmful auras")
combatIcon=false; e.HealBot_Forever_UpdateArrivalAuras(row); assert(db.shown and not slot.shown)
connected=false; e.HealBot_Forever_UpdateArrivalAuras(row); assert(not db.shown and not slot.shown)
connected=true; combatIcon=true; e.HealBot_Forever_UpdateArrivalAuras(row); assert(db.shown and slot.shown)
allowed=false; e.HealBot_Forever_UpdateArrivalAuras(row); assert(not db.shown and not slot.shown)
types=""; allowed=true; e.HealBot_Forever_RefreshArrivalDebuffPolicy()
assert(not db.shown and slot.shown,"in-combat type edit did not clear the prepared dispel group")
types="Magic"; e.HealBot_Forever_RefreshArrivalDebuffPolicy()
assert(db.shown and slot.shown,"in-combat type edit did not restore matching group")
assert(#d.frames==count,"late join or combat updates allocated native frames")
d.combat(false)
local function rejectFirstDisable(container)
    local original=container.SetEnabled
    function container:SetEnabled(enabled)
        assert(not enabled)
        self.SetEnabled=original
        error("transient teardown failure")
    end
end
rejectFirstDisable(db.container)
rejectFirstDisable(slot.container)
types=""; skin()
assert(not row.arrivalDebuffs.db and not db.container.shown and db.container.enabled and row.arrivalDebuffs.slot==slot)
cures.DebuffWatch=false; skin()
assert(not row.arrivalDebuffs.slot and not slot.container.shown and slot.container.enabled and row.arrivalAuras[1].container==hot)
d.combat(true)
assert(db.container.enabled and slot.container.enabled)
d.combat(false)
assert(not db.container.enabled and not slot.container.enabled and hot.enabled, "obsolete harmful widgets were not retired on regen")
cures.DebuffWatch=true; cures.DebuffWatchInCombat=false; types="Magic"; skin()
assert(not next(row.arrivalDebuffs),"combat-disabled monitor prepared reserve widgets")
cures.DebuffWatchInCombat=true; e.rejectSlot=true
local clock=10; e.GetTime=function() return clock end
local function skinOne() e.HealBot_Forever_SkinArrivalAuras(row,donor,e.HealBot_Forever_PrepareArrivalAuraContext()) end
skinOne(); assert(row.arrivalDebuffs.db and not row.arrivalDebuffs.slot)
skinOne(); local failedFrames=#d.frames
for _=1,5 do skinOne() end
assert(#d.frames==failedFrames,"permanently rejected slot allocated repeatedly without backoff")
e.rejectSlot=false; clock=clock+1; skinOne()
assert(row.arrivalDebuffs.slot and #d.frames>failedFrames,"transient native slot failure did not recover")
print("PASS: 28 reserve bars, scoped harmful groups, combat-only custom slot/set geometry, reuse, retirement, monitor controls and zero combat allocations")
