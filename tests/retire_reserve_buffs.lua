local f=assert(io.open("tests/native_buff_casters.lua","rb"))
local source=f:read("*a"):gsub("\r\n","\n")
f:close()
local fixture=assert(loadstring(assert(source:match("^(.-)\nlocal function admits%(")).."\nreturn fixture"))()
local d=fixture("PRIEST",4)
d.skin.limits={4,2,2}
local donor=d.button()
local row={unit="raid20",frame=1,healthBar={},GetFrameLevel=function() return 5 end}
local function skin() d.env.HealBot_Forever_SkinArrivalAuras(row,donor) end
local function item(set)
    for _,entry in ipairs(row.arrivalAuras) do
        if entry.set==set then return entry.container end
    end
end
skin()
local first,old,third=item(1),item(2),item(3)
assert(first and old.enabled and third)
-- Replacing and then removing a set must release its subscriptions. Other
-- sets keep their already prepared groups for the same reserve unit.
d.skin.limits[2]=3
skin()
assert(not old.enabled and not old.shown,"replaced reserve group still enabled")
assert(first==item(1) and third==item(3) and first.enabled and third.enabled)
local removed=item(2)
d.skin.limits[2]=0
skin()
assert(not removed.enabled and not removed.shown and not item(2),"disabled icon set left a live group")
-- If the native API rejects teardown, the obsolete container stays hidden
-- and is retried by the normal regeneration path.
local setEnabled=third.SetEnabled
function third:SetEnabled(value)
    self.SetEnabled=setEnabled
    error("injected native teardown rejection")
end
d.skin.limits[3]=0
skin()
assert(third.enabled and not third.shown and not item(3))
d.combat(true)
assert(third.enabled,"retirement ran in combat")
d.combat(false)
assert(not third.enabled and not third.shown,"release of rejected reserve group was never retried")
assert(item(1)==first and first.enabled)
print("PASS: replaced, removed, and rejected reserve helpful groups retire while unaffected groups persist")
