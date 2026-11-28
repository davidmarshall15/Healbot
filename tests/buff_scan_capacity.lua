-- Scan full public lists through the normal roster handler and its real priority sorter.
local e,make,put=assert(loadfile("tests/fixtures/public_helpful.lua"))()("party")
local g=e.HealBot_Globals
g.WatchHoT={ALL={}}
g.CustomBuffIDMethod={}; g.CustomBuffsIconSet={}; g.CustomBuffsIconGlow={}; g.CustomBuffsFilter={}
local names={}
e.HealBot_WoWAPI_SpellName=function(id) return names[id] end
e.HealBot_Data.PCLASSTRIM="PRIE"
e.HealBot_setLuVars=function() end
e.HealBot_Aura_CheckUnitBuffIcons=function() end
e.HealBot_Aura_BuffWarnings=function() end
e.HealBot_Aura_ClearBuff=function() end
e.HealBot_Aura_BuffUpdate_Plugins=function() end
e.HealBot_Aura_CheckUnitBuffOverDebuff=function() end
local max = 2
e.hbv_Skins_GetIconVar=function(_,_,set) return set==1 and max or 0 end
local original=e.HealBot_Aura_CacheBuffIcon
local drawn={}
e.HealBot_Aura_CacheBuffIcon=function(button, index, id, slot)
    original(button,index,id,slot)
    drawn[index]={id,slot}
end
local button, other=make("raid1",1),make("raid2",2)
local auras={}
for i=1,40 do
    local id=i==1 and 1002 or (i==21 and 100 or 20000+i)
    names[id]="Aura "..id
    g.WatchHoT.ALL[id]=3
    g.CustomBuffs[id]=(i==1 or i==21) and 2 or (i==40 and 1 or 15)
    g.CustomBuffsShowBarCol[id]=2
    auras[i]={name=names[id],spellId=id,sourceUnit="player",expirationTime=400,duration=180,applications=1,icon=1}
end
e.HealBot_Aura_ConfigClassHoT()
local function scan(which,list,recheck)
    put(list)
    which.aura.buff.update=not recheck
    drawn={}
    e.HealBot_Aura_CheckUnitBuffs(which,false)
end
scan(button,auras)
assert(button.aura.buff.id==20040 and button.aura.buff.priority==1 and drawn[1][2]==40,
    "the highest-priority public buff at the end of the roster scan must win the warning and first icon")
assert(button.icon.buff.count[1]==2 and not drawn[3],"configured icon cap applies after sorting")
max=3; scan(button,auras,true)
local slots={}
for _, row in ipairs(drawn) do slots[row[2]]=row[1] end
assert(slots[1]==1002 and slots[21]==100 and slots[40]==20040,
    "spell 1002/slot 1 and spell 100/slot 21 collided at equal priority")
local saved=auras[40]
auras[40]=nil
scan(other,{auras[1]}); scan(button,auras)
assert(drawn[1][2]~=40 and button.aura.buff.id~=20040,"removed overflow record leaked after another unit's scan")
auras[40]=saved; max=1; scan(button,auras)
assert(drawn[1][2]==40 and not drawn[2],"restored roster overflow did not respect its new display cap")
e.HEALBOT_FOREVER=false; scan(other,auras)
assert(drawn[1][2]==1 and other.aura.buff.id==1002,"non-Forever legacy capacity changed")
print("PASS: 40 readable buffs compete for icons and bar priority, with cached cap changes, unique slot keys and independent unit state")
