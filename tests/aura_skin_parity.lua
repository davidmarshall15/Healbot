local function read(path)
    local f=assert(io.open(path,'rb')); local s=f:read('*a'); f:close()
    return s:gsub('\r\n','\n'):gsub('^\239\187\191','')
end
local prefix=assert(read('tests/native_buff_casters.lua'):match('^(.-)\nlocal function admits%('))
local fixture=assert(loadstring(prefix..'\nreturn fixture'))()
local d=fixture('PRIEST',4)
d.skin.size=22; d.skin.spacing=3; d.skin.double=true
local b=d.button()
local icon=b.gref.icon[1]
b.gref.txt.expire[1]:SetPoint('TOPRIGHT',icon,'TOPRIGHT',-3,2)
b.gref.txt.expire[1].GetJustifyH=function() return 'RIGHT' end
b.gref.txt.count[1]:SetPoint('BOTTOMLEFT',icon,'BOTTOMLEFT',1,-2)
b.gref.txt.count[1].GetJustifyH=function() return 'LEFT' end
d.hook('HealBot_Skins_ResetSkin','bar',b)
local row=assert(d.row(b)); local own=row.groups.hbcahot.icon
local duration=own.cooldown.countdown; local count=own.count
assert(own.width==icon:GetWidth() and own.height==icon:GetHeight(),'native icon dimensions differ from legacy skin')
assert(duration.fontSize==12 and count.fontSize==12,'native text ignores configured font height')
assert(duration.point[1]=='TOPRIGHT' and duration.point[3]=='TOPRIGHT'
    and duration.point[4]==-3 and duration.point[5]==2,'native timer anchor differs from legacy anchor')
assert(count.point[1]=='BOTTOMLEFT' and count.point[3]=='BOTTOMLEFT'
    and count.point[4]==1 and count.point[5]==-2,'native count anchor differs from legacy anchor')
assert(row.groups.hbcahot.options.layout.elementSpacing==3,'configured icon spacing lost')
assert(row.axis==1 and row.maxLine==47,'configured double-row layout lost')
local frames=#d.frames
d.combat(true)
assert(row.shown and #d.frames==frames,'combat handoff changed geometry or allocated frames')
assert(duration.fontSize==12 and duration.point[1]=='TOPRIGHT','combat handoff changed text styling')
print('PASS: actual production factory matches legacy icon dimensions, font size, timer/count anchors, spacing and double layout across combat handoff')
