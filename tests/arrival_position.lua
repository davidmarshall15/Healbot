local function read(path)
    local f=assert(io.open(path,'rb')); local s=f:read('*a'); f:close()
    return s:gsub('\r\n','\n'):gsub('^\239\187\191','')
end
local prefix=assert(read('tests/native_buff_casters.lua'):match('^(.-)\nlocal function admits%('))
local fixture=assert(loadstring(prefix..'\nreturn fixture'))()
local d=fixture('PRIEST',4); d.skin.limits={4,2,2}
local donor=d.button(); local rows={}
for i=1,28 do
    local row={unit='raid'..i,frame=1,healthBar={}}
    function row:GetFrameLevel() return 5 end
    rows[i]=row; d.env.HealBot_Forever_SkinArrivalAuras(row,donor)
end
local allocated=#d.frames
for _,index in ipairs({1,9,11}) do
    donor.gref.icon[index].GetCenter=function() return 123.125,214.75 end
end
for _,row in ipairs(rows) do
    d.env.HealBot_Forever_SkinArrivalAuras(row,donor)
    for _,item in ipairs(row.arrivalAuras) do
        assert(item.container.point[4]==31.125,'horizontal anchor not updated exactly')
        assert(item.container.point[5]==(item.set==2 and 22.75 or 6.75),'vertical anchor not updated exactly')
    end
end
assert(#d.frames==allocated,'position-only changes rebuilt native frames')
local item=rows[1].arrivalAuras[1]; local original=item.container.SetPoint
item.container.SetPoint=function() error('injected anchor failure') end
donor.gref.icon[1].GetCenter=function() return 124.125,214.75 end
d.env.HealBot_Forever_SkinArrivalAuras(rows[1],donor)
d.env.HealBot_Forever_UpdateArrivalAuras(rows[1])
assert(item.anchorFailed and not item.container.shown,'failed anchor left visible')
item.container.SetPoint=original
d.env.HealBot_Forever_SkinArrivalAuras(rows[1],donor)
d.env.HealBot_Forever_UpdateArrivalAuras(rows[1])
assert(not item.anchorFailed and item.container.shown,'anchor retry did not recover')
assert(item.container.point[4]==32.125 and #d.frames==allocated,'retry rebuilt or lost exact offset')
-- A structural style change still replaces native icon factories.
d.skin.size=20
d.env.HealBot_Forever_SkinArrivalAuras(rows[1],donor)
assert(#d.frames>allocated,'icon size change incorrectly reused old factory')
allocated=#d.frames
d.combat(true)
donor.gref.icon[1].GetCenter=function() error('combat inspected donor geometry') end
d.env.HealBot_Forever_SkinArrivalAuras(rows[1],donor)
assert(#d.frames==allocated,'combat allocated frames')
print('PASS: 28 reserve rows reanchor without allocations; exact offsets, failure hiding/retry, size rebuilds and combat guard preserved')
