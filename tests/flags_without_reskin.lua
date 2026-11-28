local function read(path)
    local f=assert(io.open(path,'rb')); local s=f:read('*a'); f:close()
    return s:gsub('\r\n','\n'):gsub('^\239\187\191','')
end
local prefix=assert(read('tests/native_buff_casters.lua'):match('^(.-)\nlocal function admits%('))
local fixture=assert(loadstring(prefix..'\nreturn fixture'))()
local d=fixture('PRIEST',4); d.skin.limits={4,2,2}
local donor=d.button(); local rows={}
local context=d.env.HealBot_Forever_PrepareArrivalAuraContext()
for i=1,28 do
    local row={unit='raid'..i,frame=1,healthBar={}}
    function row:GetFrameLevel() return 5 end
    rows[i]=row; d.env.HealBot_Forever_SkinArrivalAuras(row,donor,context)
end
local allocated=#d.frames
d.skin.size=20
d.globals.WatchHoT.PRIE[139]=3
for _=1,25 do d.hook('HealBot_Aura_SetAuraCheckFlags') end
assert(#d.frames==allocated,'visibility/policy flags rebuilt reserve containers after donor layout change')
for _,row in ipairs(rows) do
    assert(row.arrivalAuras[1].container.groups.hbcahotEveryone.options.candidateFilters.includeSpellIDs[139],
        'removing layout work lost policy changes')
end
context=d.env.HealBot_Forever_PrepareArrivalAuraContext()
for _,row in ipairs(rows) do d.env.HealBot_Forever_SkinArrivalAuras(row,donor,context) end
assert(#d.frames>allocated,'explicit skin refresh failed to rebuild changed icon size')
allocated=#d.frames
d.combat(true)
for _=1,25 do d.hook('HealBot_Aura_SetAuraCheckFlags') end
assert(#d.frames==allocated,'combat flags allocated native frames')
print('PASS: 25 flag events over 28 reserves build zero frames; caster updates still apply and explicit skin refresh rebuilds changed size')
