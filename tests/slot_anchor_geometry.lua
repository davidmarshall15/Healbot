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
local function offset(point,w,h)
    return (point:find('LEFT') and -w/2 or point:find('RIGHT') and w/2 or 0),
        (point:find('BOTTOM') and -h/2 or point:find('TOP') and h/2 or 0)
end
for _,point in ipairs({'TOPLEFT','TOP','TOPRIGHT','LEFT','CENTER','RIGHT','BOTTOMLEFT','BOTTOM','BOTTOMRIGHT'}) do
    local d=fixture('PRIEST',4); local e=d.env
    e.HealBot_Forever_GetDebuffTypes=function() return {},'' end
    e.HealBot_Forever_WatchesWeakenedSoul=function() return true end
    e.HealBot_Timers_Set=function() end
    d.globals.CombatAurasNativeWeakenedSoul=true
    local b=d.button()
    local source=b.gref.icon[51]
    source:SetPoint(point,b,point,3,-4)
    d.hook('HealBot_Skins_ResetSkin','bar',b)
    local container
    for _,f in ipairs(d.frames) do if f.groups.hbcaweakenedSoul then container=f end end
    assert(container,'slot was not constructed')
    local icon=container.groups.hbcaweakenedSoul.icon
    local cw,ch=icon:GetWidth(),icon:GetHeight()
    local sx,sy=offset(source.point[1],cw,ch)
    -- Source's anchor is fixed at an arbitrary world position.
    local anchorX,anchorY=503,227
    local expectedX,expectedY=anchorX-sx,anchorY-sy
    for _,size in ipairs({0,1,16,40}) do
        -- Native flow can resize a slot-only container independently of icons.
        container:SetSize(size,size)
        local ax,ay=offset(container.point[1],size,size)
        local centerX,centerY=anchorX-ax,anchorY-ay
        local rx,ry=offset(icon.point[3],size,size)
        local ix,iy=offset(icon.point[1],cw,ch)
        local actualX=centerX+rx+(icon.point[4] or 0)-ix
        local actualY=centerY+ry+(icon.point[5] or 0)-iy
        assert(actualX==expectedX and actualY==expectedY,point..': native container resize moved the icon')
    end
end
print('PASS: all 9 configured anchors preserve exact icon coordinates through 0x0, 1x1, normal and expanded native container layouts')
