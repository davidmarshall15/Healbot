local f=assert(io.open("tests/native_buff_casters.lua","rb"))
local source=f:read("*a"):gsub("\r\n","\n")
f:close()
local init=assert(source:match("^(.-)\nlocal function admits%("))
local fixture=assert(loadstring(init.."\nreturn fixture"))()

for _,count in ipairs({4,14,28,39}) do
    local d=fixture("PRIEST",4)
    d.skin.limits={4,2,2}
    local donor=d.button()
    local api=d.env
    local reads=0
    local function watch(icon)
        local original=icon.GetCenter
        function icon:GetCenter(...)
            reads=reads+1
            return original(self,...)
        end
    end
    for _,index in ipairs({1,9,11}) do watch(donor.gref.icon[index]) end
    local rows={}
    for i=1,count do
        rows[i]={unit="raid"..i,frame=1,healthBar={},GetFrameLevel=function() return 5 end}
    end
    local function sync()
        reads=0
        local pass=api.HealBot_Forever_PrepareArrivalAuraContext()
        for _,row in ipairs(rows) do
            api.HealBot_Forever_SkinArrivalAuras(row,donor,pass)
            for _,item in ipairs(row.arrivalAuras) do
                assert(item.container.point[2]==row.healthBar,"slot anchored to another unit")
            end
        end
        assert(reads==3,"roster size "..count.." reread donor icon centers "..reads.." times")
    end
    sync()
    local allocated=#d.frames
    rows[1].healthBar={}
    sync()
    assert(#d.frames==allocated,"moving a row's health bar rebuilt its icons")
    donor.gref.icon[1].GetCenter=function() reads=reads+1; return 125,215 end
    sync()
    assert(rows[count].arrivalAuras[1].x==33,"later roster pass kept stale donor position")
end
print("PASS: raid reserve layouts read three icon centers per pass for 4, 14, 28 and 39 slots")
