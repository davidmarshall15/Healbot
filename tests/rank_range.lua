local passed=0
local function eq(actual, expected, label)
    assert(actual==expected, label..": expected "..tostring(expected)..", got "..tostring(actual))
    passed=passed+1
end
local function read(path)
    local f=assert(io.open(path,"rb"))
    local s=f:read("*a"):gsub("\r\n","\n"); f:close(); return s
end
local function extract(env, source, names)
    for _,name in ipairs(names) do
        setfenv(assert(loadstring(assert(source:match("(function "..name.."%b().-\nend)"), name))),env)()
    end
end
local noop=function() end
local env=setmetatable({
    HEALBOT_GAME_VERSION=1, HEALBOT_CLIENT_VERSION=12,
    HealBot_Globals={NoRanks=false,IconKeyCombo={}}, HealBot_Config={},
    HealBot_Config_Spells={EnabledKeyCombo={},EnemyKeyCombo={},EmergKeyCombo={},SpellTargetLastTarget={}},
    HealBot_Spell_IDs={}, HealBot_Spell_Names={}, HealBot_Action_SpellCache={},
    skipSpells={}, HealBot_Ranks={}, HealBot_Buff_Names={Buff=true},
    HealBot_Buff_Ranks={}, HealBot_KnownHeal_Names={}, HealBot_Spell_Ranks={},
    HealBot_Init_FindSpellRangeCast=noop, HealBot_Text_Len=string.len,
    HealBot_Action_SpellCmdCodes=noop, HealBot_WoWAPI_ItemInfoInstant=noop,
    HealBot_WoWAPI_SpellTexture=function() return 123 end,
    -- Simulate an API which resolves base names to the highest rank.
    HealBot_WoWAPI_SpellId=function() return 102 end,
    HealBot_WoWAPI_SpellName=function() return "Buff" end,
    GetMacroIndexByName=function() return 0 end, strlower=string.lower,
    HealBot_Action_UpdateAttribsMinReset=noop,
}, {__index=_G})
env.string=setmetatable({split=function(sep, value)
    local pos=value:find(sep,1,true)
    if pos then return value:sub(1,pos-1),value:sub(pos+1) end
    return value
end}, {__index=string})
extract(env,read("HealBot/HealBot_Init.lua"),{"HealBot_Init_Spells_addSpell","HealBot_Init_knownClassicHealSpell"})
extract(env,read("HealBot/Libs/LibSpells/HealBot_Spells.lua"),{"HealBot_Spells_KnownByID","HealBot_Spells_KnownByName"})
local action=read("HealBot/HealBot_Action.lua")
for key in action:gmatch("HEALBOT_[A-Z_]+") do if env[key]==nil then env[key]=key end end
extract(env,action,{"HealBot_Action_ClearSpellCache","HealBot_Action_SetSpell","HealBot_Action_GetSpell",
    "HealBot_Action_DoSetButtonAttrib","HealBot_Action_AlterSpell2Macro"})
for _,entry in ipairs({{101,"Buff","Rank 1"},{102,"Buff","Rank 2"},{201,"Heal","Rank 1"}}) do
    env.HealBot_Spell_IDs[entry[1]]={}
    env.HealBot_Init_Spells_addSpell(entry[1],entry[2],nil,entry[3])
end
env.HealBot_Action_ClearSpellCache()
eq(env.HealBot_Spells_KnownByName("Buff(Rank 1)"),101,"rank resolves to its spellbook ID")
eq(env.HealBot_Spells_KnownByID(101),"Buff","base buff ID lookup stays compatible")
eq(env.HealBot_Spell_Names.Buff,102,"unranked buff lookup stays at highest rank")
for _,kind in ipairs({"ENABLED","ENEMY","EMERG","ICON"}) do
    env.HealBot_Action_SetSpell(kind,"Left","Buff(Rank 1)")
    env.HealBot_Action_ClearSpellCache()
    local name,_,typ,id=env.HealBot_Action_GetSpell(kind,"Left")
    eq(name,"Buff(Rank 1)",kind.." rank survives reload")
    eq(id,101,kind.." saved ID")
    eq(typ,"spell",kind.." saved type")
    eq(env.HealBot_Action_GetSpell(kind,"Left"),name,kind.." cached rank")
end
local button={attrs={}}
function button:SetAttribute(k,v) self.attrs[k]=v end
local name=env.HealBot_Action_GetSpell("ENABLED","Left")
env.HealBot_Action_DoSetButtonAttrib(button,"Enabled",1,"party1","ctrl-","helpbutton",name,false,false,false,false,"heal")
eq(button.attrs["ctrl-spell-heal1"],"Buff(Rank 1)","rank reaches secure spell attribute")
env.HealBot_Action_DoSetButtonAttrib(button,"Enabled",1,"party1","","helpbutton",name,true,false,false,false,"heal")
eq(button.attrs.macrotext1,"/target party1\n/cast [@party1,help] Buff(Rank 1)\n","rank reaches cast macro")
env.HealBot_Action_SetSpell("ENABLED","Right","Heal(Rank 1)")
eq(env.HealBot_Action_GetSpell("ENABLED","Right"),"Heal(Rank 1)","healing rank retained")
env.HealBot_Action_SetSpell("ENABLED","Middle","Buff")
eq(env.HealBot_Action_GetSpell("ENABLED","Middle"),"Buff","unranked assignment unchanged")
env.HealBot_Config_Spells.EnabledKeyCombo.Left="S:102^Buff(Rank 1)"
env.HealBot_Action_ClearSpellCache()
eq(env.HealBot_Action_GetSpell("ENABLED","Left"),"Buff","mismatched saved name cannot override ID")
env.HealBot_Globals.NoRanks=true
env.HealBot_Action_ClearSpellCache()
eq(env.HealBot_Action_GetSpell("EMERG","Left"),"Buff","NoRanks setting retained")
env.HealBot_Spell_IDs[103]={}
env.HealBot_Init_Spells_addSpell(103,"Buff",nil,"Rank 3")
eq(env.HealBot_Spell_Names["Buff(Rank 3)"],nil,"NoRanks skips ranked aliases")
env.HealBot_Globals.NoRanks=false; env.HEALBOT_GAME_VERSION=11
env.HealBot_Action_ClearSpellCache()
eq(env.HealBot_Action_GetSpell("EMERG","Left"),"Buff","modern unranked clients unchanged")

local secret=setmetatable({}, {__lt=function() error("secret comparison") end})
local spellResult,unitResult,checked=nil,secret,secret
local visible,interact=true,false
local r=setmetatable({
    HealBot_issecretvalue=function(v) return rawequal(v,secret) end,
    HealBot_WoWAPI_SpellInRange=function() return spellResult end,
    UnitInRange=function() return unitResult,checked end,
    UnitIsVisible=function() return visible end,
    CheckInteractDistance=function() return interact end,
    UnitIsEnemy=function() return false end,
    HealBot_Range_UnitInPhase=function() return true end,
    HealBot_Data={UILOCK=true}, HealBot_Spell_Names={Heal=1}, HealBot_Spell_IDs={[1]={range=40}},
}, {__index=_G})
extract(r,read("HealBot/Libs/LibRange/HealBot_Range.lua"),{"HealBot_Range_IsSpellInRange",
    "HealBot_Range_InteractDistance","HealBot_Range_Unit","HealBot_Range_UnitCurrent"})
extract(r,read("HealBot/HealBot_Events.lua"),{"HealBot_Events_UpdateRange"})
local b={unit="party1",guid="one",range={inphase=true},status={},frame=1}
local function current(spell) return r.HealBot_Range_UnitCurrent(b,spell) end
r.HealBot_Events_UpdateRange(b,"party1",true)
eq(current("Heal"),1,"nil spell query uses readable range event")
eq(current(),1,"no range spell uses readable event")
eq(current("Unknown"),1,"unknown range spell uses readable event")
r.HealBot_Events_UpdateRange(b,"party1",secret)
eq(b.range.eventIn,true,"secret event cannot replace readable cache")
spellResult=false; eq(current("Heal"),0,"readable false spell result wins")
spellResult=0; eq(current("Heal"),0,"readable zero spell result wins")
spellResult=1; b.range.eventIn=false; eq(current("Heal"),1,"readable in-range spell wins")
r.HealBot_Spell_IDs[1].range=30
eq(current("Heal"),2,"short range classification retained")
r.HealBot_Spell_IDs[1].range=40
spellResult=nil; unitResult=false; checked=true; b.range.eventIn=true
eq(current("Heal"),0,"readable UnitInRange false wins")
unitResult=true; b.range.eventIn=false
eq(current("Heal"),1,"readable UnitInRange true wins")
unitResult=secret; checked=true; b.range.eventIn=true
eq(current("Heal"),1,"mixed secret range query uses event")
unitResult=nil; checked=true
eq(current("Heal"),1,"nil range payload uses event")
unitResult=false; checked=false
eq(current("Heal"),1,"unchecked range result uses event")
checked=secret; unitResult=secret; b.range.eventIn=false
eq(current("Heal"),0,"readable out-of-range event retained")
b.range.eventIn=nil
eq(current("Heal"),0,"no evidence keeps legacy nil-query fallback")
spellResult=secret
eq(current("Heal"),1,"protected spell query keeps existing unknown fallback")
b.range.eventIn=false; eq(current("Heal"),0,"protected spell query respects false event")
b.range.eventIn=true; b.range.inphase=false
eq(current("Heal"),-2,"out-of-phase takes priority")
b.range.inphase=true; visible=false
eq(current("Heal"),-1,"invisible takes priority")
visible=true; interact=true; r.HealBot_Data.UILOCK=false
eq(current("Heal"),2,"readable interaction range retained")
env.HealBot_Action_luVars={regAggro=false}
extract(env,action,{"HealBot_Action_UnregisterUnitEvents","HealBot_Action_RegisterUnitEvents"})
b.UnregisterEvent=noop; b.RegisterUnitEvent=noop
env.HealBot_Action_UnregisterUnitEvents(b)
eq(b.range.eventIn,nil,"unregister clears stale range payload")
b.range.eventIn=true; b.unit="party2"; b.guid="two"
env.HealBot_Action_RegisterUnitEvents(b)
eq(b.range.eventIn,nil,"register clears reused button payload")
print("PASS: "..passed.." spell-rank/range assertions (mock APIs)")
