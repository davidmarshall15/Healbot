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

-- A departing donor may lose its reaction before the normal unit buttons
-- settle. Replay both the departure and the subsequent update at each size.
local d=fixture("DRUID",4)
d.skin.limits={4,2,2}
local api=d.env
local readText=api.hbv_Skins_GetIconTextVar
api.hbv_Skins_GetIconTextVar=function(key,...)
    if key=="BUFFDURTHRH" then return 12 end
    if key=="BUFFDURWARN" then return 4 end
    return readText(key,...)
end
local friendly=true
api.UnitIsFriend=function() return friendly end
local donor=d.button("raid4")
local rows={}
local function reservePass(members,reaction)
    friendly=reaction
    local pass=api.HealBot_Forever_PrepareArrivalAuraContext(true)
    for i=members+1,40 do
        rows[i]=rows[i] or {unit="raid"..i,frame=1,healthBar={},GetFrameLevel=function() return 5 end}
        api.HealBot_Forever_SkinArrivalAuras(rows[i],donor,pass)
    end
end
local function countBuffContainers()
    local count=0
    for _,frame in ipairs(d.frames) do
        if frame.parent~=donor and frame.groups.hbcahot then count=count+1 end
    end
    return count
end
reservePass(10,true)
local warm=countBuffContainers()
assert(warm==30*3,"expected three prepared buff sets per reserve position")
reservePass(4,true)
reservePass(3,nil)
reservePass(3,true)
reservePass(2,nil)
reservePass(2,true)
local built=countBuffContainers()-warm
assert(built==8*3,"eight newly empty positions should build 24 buff containers, got "..built)
print("PASS: a battleground shrinking from ten to two players builds only the 24 new buff containers")
