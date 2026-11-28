local function read(path)
    local f=assert(io.open(path,'rb')); local s=f:read('*a'); f:close()
    return s:gsub('\r\n','\n'):gsub('^\239\187\191','')
end
local prefix=assert(read('tests/native_buff_casters.lua'):match('^(.-)\nlocal function admits%('))
prefix=prefix:gsub('        function f:AddAuraGroup',[[
        function f:AddAuraSlot(key,filter,options)
            options.maxFrameCount=1
            return self:AddAuraGroup(key,filter,options)
        end
        function f:AddAuraGroup]],1)
local fixture=assert(loadstring(prefix..'\nreturn fixture'))()
local d=fixture('PRIEST',4); local e=d.env
local zone='none'; local allowed=true; local rest=true; local combatPreference=true
e.IsInInstance=function() return zone~='none',zone end
e.HealBot_Forever_WatchesWeakenedSoul=function() return allowed end
e.HealBot_Aura_GetDebuffIconPreference=function(_,combat) return allowed and (combat and combatPreference or not combat and rest) end
e.HealBot_Timers_Set=function() end
e.HealBot_Forever_GetDebuffTypes=function() return {},'' end
d.globals.CombatAurasNativeWeakenedSoul=true
local button=d.button(); local slot
for _,frame in ipairs(d.frames) do if frame.groups.hbcaweakenedSoul then slot=frame end end
if not slot then e.print=print; e.SlashCmdList.HBCOMBATAURAS('status') end
assert(slot,'native Weakened Soul slot was not prepared')
local slotIcon=slot.groups.hbcaweakenedSoul.icon
assert(slotIcon.point[1]==slot.point[1] and slotIcon.point[3]==slot.point[1],
    'slot-only native container can collapse and shift a centered icon')
assert(slot.point[1]==button.gref.icon[51].point[1]
    and slot.point[4]==button.gref.icon[51].point[4]
    and slot.point[5]==button.gref.icon[51].point[5], 'empty native row left a phantom gap before configured debuff anchor')
assert(not slot.shown,'world outside-combat ownership changed')
zone='pvp'; d.fire('PLAYER_ENTERING_WORLD')
assert(slot.shown,'BG outside combat still hides Weakened Soul')
d.combat(true); assert(slot.shown,'combat entry hides slot')
d.combat(false); assert(slot.shown,'combat exit hides slot in BG')
allowed=false; d.hook('HealBot_Aura_CheckUnitDebuffs',button)
assert(not slot.shown,'disabled custom icon preference ignored')
allowed=true; d.hook('HealBot_Aura_CheckUnitDebuffs',button)
assert(slot.shown,'enabled preference did not recover')
rest=false; d.hook('HealBot_Aura_RefreshDebuffIconVisibility')
assert(not slot.shown,'BG outside combat ignored rest visibility rule')
d.combat(true); assert(slot.shown,'combat rule incorrectly inherited disabled rest preference')
d.combat(false); assert(not slot.shown,'combat exit ignored rest rule')
rest=true; combatPreference=false; d.hook('HealBot_Aura_RefreshDebuffIconVisibility')
assert(slot.shown,'rest rule did not restore BG icon')
d.combat(true); assert(not slot.shown,'combat-specific hide rule ignored')
d.combat(false); assert(slot.shown,'rest rule incorrectly inherited hidden combat preference')
zone='none'; d.fire('PLAYER_ENTERING_WORLD')
assert(not slot.shown,'leaving BG failed to release native icon')
print('PASS: prepared Weakened Soul native slot persists through BG combat transitions and honors icon preference')
