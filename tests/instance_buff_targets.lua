-- Group-only custom buff and debuff icons follow instance and home roster transitions.
local e,_,_,_,_,setGroup=dofile("tests/fixtures/ordinary_helpful.lua")
local function check(party,raid,home,wanted)
    setGroup(party,raid,home)
    assert((e.HealBot_Forever_BuffsEnabled() and true or false)==wanted)
    assert((e.HealBot_Forever_DebuffsEnabled() and true or false)==wanted)
end
check(false,false,0,false)
check(true,false,0,true)
check(false,true,0,true)
check(false,false,5,true)
check(false,false,0,false)
print("PASS: group-only custom aura rows follow instance party, instance raid, home and solo transitions")
