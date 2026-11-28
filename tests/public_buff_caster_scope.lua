-- Drive the ordinary helpful-aura scan and its persistent spell/slot caches.
local e,make,put,aura,secret,setGroup=dofile("tests/fixtures/ordinary_helpful.lua")
setGroup(true,false,0)
local button=make('party2',1)
local shown,classes={},{}
local id,name=401863,'Prayer of Mending'
local g=e.HealBot_Globals
g.WatchHoT={PRIE={[id]=2}}
g.CustomBuffIDMethod={}; g.CustomBuffsIconSet={}; g.CustomBuffsIconGlow={}; g.CustomBuffsFilter={}
e.HealBot_Data.PCLASSTRIM='PRIE'
e.HealBot_WoWAPI_SpellName=function() return name end
e.UnitClass=function(source) return nil,classes[source] end
e.strsub=string.sub
e.HEALBOT_WORDS_UNKNOWN='Unknown'
e.HealBot_setLuVars=function() end
e.HealBot_Aura_UnusedAuraInfo=function() return '' end
e.HealBot_Aura_CheckUnitBuffIcons=function() end
e.HealBot_Aura_BuffWarnings=function() end
e.HealBot_Aura_ClearBuff=function() end
e.HealBot_Aura_BuffUpdate_Plugins=function() end
e.HealBot_Aura_SortBuffIcons=function() return 0 end
e.HealBot_Aura_setBuffXRefUID=function(_,_,slot) shown[slot]=true end
local duration=30
local function scan(expected,...)
    local entries={}
    for slot=1,select('#',...) do
        local who=select(slot,...)
        entries[slot]={name=name,spellId=id,sourceUnit=who,expirationTime=duration==0 and 0 or 180,duration=duration,applications=1,icon=1}
    end
    put(entries); shown={}; button.aura.buff.update=true
    e.HealBot_Aura_CheckUnitBuffs(button,false)
    for slot=1,#entries do
        assert((shown[slot] or false)==(expected[slot] or false),'caster scope leaked/lost slot '..slot..' ('..entries[slot].sourceUnit..')')
    end
end
local function configure(watch,auto)
    g.WatchHoT.PRIE[id]=watch
    e.HealBot_Config_Buffs.AutoBuff=3
    e.HealBot_Config_Buffs.AutoBuffCastBy=auto
    e.HealBot_Aura_ConfigClassHoT()
    e.HealBot_Aura_ResetBuffCache()
    e.HealBot_Aura_DeleteExcludeBuffInCache()
end
classes.party1='MAGE'; classes.party3='PRIEST'; classes.player='PRIEST'
for _,automatic in ipairs({false,true}) do
    if automatic then configure(nil,2) else configure(2,2) end
    scan({},'party1'); scan({true},'party3'); scan({},'party1')
    scan({false,true,true},'party1','party3','player')
    classes.party3='MAGE'; scan({},'party3'); classes.party3='PRIEST'; scan({true},'party3')
    classes.party3=secret; scan({},'party3'); classes.party3=nil; scan({},'party3')
    classes.party3='PRIEST'; scan({true},'party3')
end
configure(1,1); scan({false,true},'party3','player')
configure(3,3); scan({true,true},'party1','party3')
configure(nil,3); e.HealBot_Config_Buffs.AutoBuff=2; e.HealBot_Config_Buffs.AutoBuffExpireTime=60
for _,seconds in ipairs({0,120,30,60,59,0,20}) do
    duration=seconds; scan({seconds>0 and seconds<60},'player')
end
print('PASS: same-spell class filters follow each caster, reused unit tokens, unknown and restricted classes; both custom and automatic policies preserve Self and Everyone')
