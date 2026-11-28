local function read(path)
    local f=assert(io.open(path,"rb")); local s=f:read("*a"); f:close()
    return s:gsub("\r\n","\n")
end
local prefix=assert(read("tests/native_buff_casters.lua"):match("^(.-)\nlocal function admits%("))
if arg[1] then prefix=prefix:gsub('local source=read%("HealBot/HealBot_CombatAuras.lua"%)','local source=read(arg[1])') end
local fixture=assert(loadstring(prefix.."\nreturn fixture"))()
local skins=read("HealBot/HealBot_Skins.lua")
local skinStart=assert(skins:find("function HealBot_Skins_setIconAnchors(",1,true))
local skinEnd=assert(skins:find("local indOffset=",skinStart,true))
local env=setmetatable({iAnchors={},b={frame=1},hbv_Skins_GetFrameVar=function() return 1 end},{__index=_G})
setfenv(assert(loadstring(skins:sub(skinStart,skinEnd-1))),env)()
local cases=0
local size=18
for mode,maxAnchor in ipairs({8,4,2}) do
    for anchor=1,maxAnchor do
        for _,double in ipairs({false,true}) do
            for _,space in ipairs({0,2,5}) do
                env.HealBot_Skins_setIconAnchors(mode,anchor)
                env.HealBot_Skins_setIconSpacer(anchor,space)
                local a=env.iAnchors
                local d=fixture("PRIEST",4)
                d.skin.double,d.skin.spacing,d.skin.size=double,space,size
                d.skin.limits={4,2,2}
                local b=d.button()
                for _,id in ipairs({1,9,11,51}) do b.gref.icon[id]:SetPoint(a.ICON,b,a.BUTTON,id,0) end
                d.hook("HealBot_Skins_ResetSkin","bar",b)
                local tested=0
                for _,r in ipairs(d.frames) do
                    if r.parent==b and r.shown~=nil and r.point and r.point[3]==a.BUTTON
                       and (r.point[4]==1 or r.point[4]==9 or r.point[4]==11 or r.point[4]==51) then
                        local group=r.groups.hbcahot or r.groups.hbcadb
                        assert(group)
                        local layout=group.options.layout
                        local gapX=double and layout.lineSpacing or layout.elementSpacing
                        local gapY=double and layout.elementSpacing or layout.lineSpacing
                        local dx=r.growH*(size+gapX)
                        local dy=r.growV*(size+gapY)
                        local label=mode.."/"..anchor.." double="..tostring(double).." space="..space.." id="..r.point[4]
                        -- The legacy second column starts at the 'RELATIVE'
                        -- edge of the first icon plus its signed pixel offset.
                        local legacyX=(a.RELATIVE:find("RIGHT") and size or -size)+a.ICONHSPACE
                        local legacyY=(a.DOUBLE:find("TOP") and size or -size)+a.ICONVSPACE
                        assert(dx==legacyX,label.." horizontal gap")
                        if double then
                            assert(dy==legacyY,label.." vertical gap")
                            assert(r.maxLine==size*2+gapY,label.." double-layout wrap")
                        end
                        tested=tested+1
                    end
                end
                assert(tested==4,"expected all 3 buff sets and the regular debuff row, got "..tested)
                cases=cases+tested
            end
        end
    end
end
print("PASS: "..cases.." native/legacy row comparisons across inside, outside, below, single/double, and spacing 0/2/5")
