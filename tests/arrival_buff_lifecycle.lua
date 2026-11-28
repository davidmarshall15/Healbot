local f=assert(io.open("tests/native_buff_casters.lua","rb"))
local source=f:read("*a"):gsub("\r\n","\n")
f:close()
local fixture=assert(loadstring(assert(source:match("^(.-)\nlocal function admits%(")).."\nreturn fixture"))()
local fail,failAnchor,clock=false,false,100
local d=fixture("PRIEST",4,function(env)
    env.GetTime=function() return clock end
    local create=env.CreateFrame
    env.CreateFrame=function(...)
        local frame=create(...)
        if frame.kind=="AuraContainer" then
            local point=frame.SetPoint
            function frame:SetPoint(anchor,...)
                if anchor=="TOPRIGHT" and failAnchor then failAnchor=false; error("transient anchor failure") end
                return point(self,anchor,...)
            end
            local add=frame.AddAuraGroup
            function frame:AddAuraGroup(key,...)
                if key=="hbcahotEveryone" and fail then
                    if fail~="persistent" then fail=false end
                    error("injected native failure")
                end
                return add(self,key,...)
            end
        end
        return frame
    end
end)
d.skin.limits={4,2,2}
local donor=d.button()
local row={unit="raid28",frame=1,healthBar={},GetFrameLevel=function() return 5 end}
local function skin() d.env.HealBot_Forever_SkinArrivalAuras(row,donor) end
local function item(set)
    for _,entry in ipairs(row.arrivalAuras) do
        if entry.set==set then return entry end
    end
end
local function countHelpful()
    local n=0
    for _,frame in ipairs(d.frames) do
        if frame.parent==row and frame.groups.hbcahot then n=n+1 end
    end
    return n
end

skin()
local first,second,third=item(1),item(2),item(3)
assert(first and second and third)
-- Rebuilding a single set allocates one helpful row and keeps the other two
-- intact, including their existing native icons and visibility.
local n=countHelpful()
d.skin.limits[2]=3
skin()
assert(item(1)==first and item(2)~=second and item(3)==third,"unrelated sets abandoned")
assert(not second.container.shown,"retired row visible")
assert(countHelpful()==n+1,"rebuilt unrelated native groups")
second=item(2)

-- Partially created rows stay hidden. The next explicit skin pass may retry
-- this set even when its geometry is unchanged. No retry work occurs in combat.
fail=true
d.skin.limits[2]=4
skin()
assert(not item(2) and item(1)==first and item(3)==third,"failed set or unrelated set reused incorrectly")
assert(not second.container.shown,"stale row still visible on failed replacement")
n=countHelpful()
d.combat(true)
skin()
assert(not item(2) and countHelpful()==n,"combat retried native creation")
d.combat(false)
skin()
assert(item(2) and item(1)==first and item(3)==third and countHelpful()==n+1,"unchanged pass failed to recover one set")
second=item(2)
d.skin.limits[2]=0
skin()
assert(not item(2) and not second.container.shown and item(1)==first and item(3)==third)
n=countHelpful()
for i=1,12 do skin() end
assert(countHelpful()==n,"intentional zero slots retried native creation")
d.skin.limits[2]=2
skin()
assert(item(2) and item(1)==first and item(3)==third and countHelpful()==n+1)
print("PASS: reserve helpful rows retain unaffected sets, retire changed sets, retry a transient native failure, and respect zero slots and combat lockdown")

-- Initial ordinary-bar construction can fail independently for two different
-- sets. They must recover on a regular skin pass even with the same profile.
fail,failAnchor=true,true
local player=d.button("player")
local function prepared()
    local valid={}
    for _,frame in ipairs(d.frames) do
        if frame.parent==player and frame.enabled and frame.groups.hbcahot then
            valid[frame]=true
        end
    end
    return valid
end
local healthy=prepared()
assert(next(healthy) and not next(healthy,next(healthy)),"fixture did not lose exactly two groups")
d.hook("HealBot_Skins_ResetSkin","bar",player)
local recovered=prepared()
assert(recovered[next(healthy)],"successful set was rebuilt during recovery")
local n=0
for _ in pairs(recovered) do n=n+1 end
assert(n==3,"unchanged skin did not retry the missing ordinary aura sets")
local allocated=#d.frames
d.hook("HealBot_Skins_ResetSkin","bar",player)
assert(#d.frames==allocated,"recovered ordinary bar still retried structural creation")
print("PASS: partial ordinary-bar group and anchor failures recover on the next skin pass without rebuilding working containers")

d.skin.limits[2]=3
fail="persistent"
skin()
skin()
local failedCount=#d.frames
for i=1,50 do skin() end
assert(#d.frames==failedCount and not item(2),"roster churn retried a persistent failure without backoff")
clock=101
skin()
assert(#d.frames>failedCount and not item(2),"elapsed cooldown lost retry")
fail=false
d.skin.limits[2]=4
skin()
assert(item(2),"new layout was held behind an obsolete failure cooldown")
print("PASS: repeated native rejection backs off, retries after elapsed time, and new configuration can recover immediately")
