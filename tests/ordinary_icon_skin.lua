-- Apply the real ordinary bar icon reset to a full raid of newly bound buttons.
local f=assert(io.open(arg[1] or "HealBot/HealBot_Skins.lua","rb"))
local src=f:read("*a"):gsub("\r\n","\n"); f:close()
local functions=assert(src:match("(function HealBot_Skins_UpdateIconGlowSize.-)\nlocal tmpHeightOffset"))
local reset=assert(src:match("if b.icon.reset then(.-)%s*%-%- Buff IconSet 1"))
local reads,fonts,sizes,glows=0,0,0,0
local env=setmetatable({floor=math.floor,bheight=40}, {__index=_G})
local offset=0
local function setting(key,frame,set)
    assert(frame==1 or frame==2)
    if key=="BUFFDOUBLE" then return set==2 end
    if key=="DEBUFFDOUBLE" then return set==3 end
    if key=="BSCALE" then return .5+set/10+offset end
    if key=="DSCALE" then return .4+set/10+offset end
    if key=="BZOOM" then return .01*set end
    if key=="DZOOM" then return .02*set end
    if key:find("HEIGHT") then return 10+set+offset end
    return key..frame..set..offset
end
local function read(...) reads=reads+1; return setting(...) end
env.hbv_Skins_GetIconBoolean=read
env.hbv_Skins_GetIconVar=read
env.hbv_Skins_GetIconTextVar=read
env.HealBot_Media_ResolveFont=function(name,height,outline)
    fonts=fonts+1
    return "resolved"..name,height,outline
end
env.HealBot_Media_UpdateFont=function(obj,...) obj:SetFont(env.HealBot_Media_ResolveFont(...)) end
setfenv(assert(loadstring(functions)),env)()
env.HealBot_Skins_UpdateIconGlowSize=function() glows=glows+1 end
local apply=setfenv(assert(loadstring("return function(b) "..reset.." end")),env)()
local function widget()
    return {
        SetWidth=function(w,v) sizes=sizes+1; w.width=v end,
        SetHeight=function(w,v) sizes=sizes+1; w.height=v end,
        SetSize=function(w,x,y) sizes=sizes+1; w.width,w.height=x,y end,
        SetTexCoord=function(w,...) w.coords={...} end,
        SetFont=function(w,...) w.font={...} end,
    }
end
local function verify(b,id,set,helpful)
    local refs,frame=b.gref,b.frame
    local prefix=helpful and "B" or "D"
    local size=env.bheight*setting(prefix.."SCALE",frame,set)-2
    if setting(helpful and "BUFFDOUBLE" or "DEBUFFDOUBLE",frame,set) then size=math.floor(size*.485) end
    local zoom=setting(prefix.."ZOOM",frame,set)
    local icon=refs.icon[id]
    assert(icon.width==size and icon.height==size and refs.iconf[id].width==size and refs.iconf[id].height==size)
    assert(table.concat(icon.coords,",")==table.concat({zoom,1-zoom,zoom,1-zoom},","))
    local text=helpful and "BUFF" or "DB"
    for _,label in ipairs({refs.txt.count[id],refs.txt.expire[id]}) do
        assert(label.font[1]=="resolved"..setting(text.."FONT",frame,set))
        assert(label.font[2]==setting(text.."HEIGHT",frame,set) and label.font[3]==setting(text.."OUTLINE",frame,set))
    end
end
local rows={}
for row=1,40 do
    local b={frame=1+row%2,gref={icon={},iconf={},txt={count={},expire={}}}}
    rows[row]=b
    for id=1,60 do
        for _,slots in ipairs({b.gref.icon,b.gref.iconf,b.gref.txt.count,b.gref.txt.expire}) do slots[id]=widget() end
    end
end
for pass=1,2 do
    offset=pass-1
    reads,fonts,sizes,glows=0,0,0,0
    for _,b in ipairs(rows) do
        apply(b)
        for id=1,12 do verify(b,id,id<=8 and 1 or id<=10 and 2 or 3,true) end
        for id=51,60 do verify(b,id,id<=56 and 1 or id<=58 and 2 or 3,false) end
        assert(b.gref.icon[13].width==nil)
    end
    print("40 ordinary bars",reads.." skin reads",fonts.." font resolutions",sizes.." geometry calls",glows.." mouse/glow updates")
    if arg[2]~="baseline" then assert(reads==1440 and fonts==240 and sizes==1760 and glows==880) end
end
-- A single-icon API call must still affect only its specified slot.
local b=rows[1]
offset=2
env.HealBot_Skins_UpdateBuffIcon(b,10,2)
verify(b,10,2,true)
assert(b.gref.icon[9].width~=b.gref.icon[10].width)
