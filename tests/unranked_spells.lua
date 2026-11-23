-- A spell typed without a rank ("Flash Heal") must follow the highest rank in
-- the spellbook, and the options spell boxes must keep showing it unranked:
-- they re-save their text on change, so showing "Flash Heal(Rank 3)" would
-- lock that rank in. Spells typed with a rank keep it.
local passed=0
local function eq(actual, expected, label)
    assert(actual==expected, label..": expected "..tostring(expected)..", got "..tostring(actual))
    passed=passed+1
end
local function read(path)
    local f=assert(io.open(path,"rb"))
    local s=f:read("*a"):gsub("\r\n","\n"); f:close(); return s
end
local function body(source, name)
    return assert(source:match("(function "..name.."%b().-\nend)"), name)
end
local function extract(env, source, names)
    for _,name in ipairs(names) do
        setfenv(assert(loadstring(body(source, name), name)),env)()
    end
end
local noop=function() end
local spellNames={}
local env=setmetatable({
    HEALBOT_GAME_VERSION=1, HEALBOT_CLIENT_VERSION=12,
    HealBot_Globals={NoRanks=false,IconKeyCombo={}}, HealBot_Config={},
    HealBot_Config_Spells={EnabledKeyCombo={},EnemyKeyCombo={},EmergKeyCombo={},SpellTargetLastTarget={}},
    HealBot_Spell_IDs={}, HealBot_Spell_Names={}, HealBot_Action_SpellCache={},
    skipSpells={}, HealBot_Ranks={}, HealBot_Buff_Names={},
    HealBot_Buff_Ranks={}, HealBot_KnownHeal_Names={}, HealBot_Spell_Ranks={},
    HealBot_Init_FindSpellRangeCast=noop, HealBot_Text_Len=string.len,
    HealBot_Action_SpellCmdCodes=noop, HealBot_WoWAPI_ItemInfoInstant=noop,
    HealBot_WoWAPI_SpellTexture=function() return 123 end,
    HealBot_WoWAPI_SpellId=noop,
    HealBot_WoWAPI_SpellName=function(id) return spellNames[id] end,
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
extract(env,action,{"HealBot_Action_IsUnrankedName","HealBot_Action_UsesRanks","HealBot_Action_HighestRankID",
    "HealBot_Action_ClearSpellCache","HealBot_Action_SetSpell","HealBot_Action_GetSpell",
    "HealBot_Action_GetSpellDisplay","HealBot_Action_DoSetButtonAttrib","HealBot_Action_AlterSpell2Macro"})

local function learn(id, name, rank)
    spellNames[id]=name
    env.HealBot_Spell_IDs[id]={}
    env.HealBot_Init_Spells_addSpell(id,name,nil,rank)
end
learn(2061,"Flash Heal","Rank 1")
learn(9472,"Flash Heal","Rank 2")
learn(9473,"Flash Heal","Rank 3")
learn(586,"Fade","")
env.HealBot_Action_ClearSpellCache()

local kinds={"ENABLED","ENEMY","EMERG","ICON"}
local function saved(kind, key)
    if kind=="ENABLED" then return env.HealBot_Config_Spells.EnabledKeyCombo[key]
    elseif kind=="ENEMY" then return env.HealBot_Config_Spells.EnemyKeyCombo[key]
    elseif kind=="EMERG" then return env.HealBot_Config_Spells.EmergKeyCombo[key] end
    return env.HealBot_Globals.IconKeyCombo[key]
end

for _,kind in ipairs(kinds) do
    env.HealBot_Action_SetSpell(kind,"Right","Flash Heal")
    eq(saved(kind,"Right"):match("%^(.*)$"),"Flash Heal",kind.." saves the name as typed")
    env.HealBot_Action_ClearSpellCache()
    local name,_,typ,id=env.HealBot_Action_GetSpell(kind,"Right")
    eq(name,"Flash Heal(Rank 3)",kind.." unranked name casts the highest rank")
    eq(id,9473,kind.." unranked name resolves to the highest rank ID")
    eq(typ,"spell",kind.." unranked type")
    eq(env.HealBot_Action_GetSpellDisplay(kind,"Right"),"Flash Heal",kind.." box shows the name unranked")
    -- The boxes save their own text when it changes; that round trip must not add a rank.
    env.HealBot_Action_SetSpell(kind,"Right",env.HealBot_Action_GetSpellDisplay(kind,"Right"))
    eq(saved(kind,"Right"):match("%^(.*)$"),"Flash Heal",kind.." box refresh keeps it unranked")
end

-- A binding saved before the newer ranks existed (rank 1's ID) still follows the top rank.
env.HealBot_Config_Spells.EnabledKeyCombo.Middle="S:2061^Flash Heal"
env.HealBot_Action_ClearSpellCache()
local name,_,_,id=env.HealBot_Action_GetSpell("ENABLED","Middle")
eq(name,"Flash Heal(Rank 3)","old rank-1 ID follows the highest rank")
eq(id,9473,"old rank-1 ID resolves to rank 3")

-- Learning a new rank upgrades the binding once the spell cache is rebuilt.
learn(9474,"Flash Heal","Rank 4")
env.HealBot_Action_ClearSpellCache()
name,_,_,id=env.HealBot_Action_GetSpell("ENABLED","Middle")
eq(name,"Flash Heal(Rank 4)","newly learned rank is used")
eq(id,9474,"newly learned rank ID")
eq(env.HealBot_Config_Spells.EnabledKeyCombo.Middle,"S:2061^Flash Heal","saved binding needs no rewrite")

local button={attrs={}}
function button:SetAttribute(k,v) self.attrs[k]=v end
env.HealBot_Action_DoSetButtonAttrib(button,"Enabled",2,"party1","","helpbutton",name,false,false,false,false,"heal")
eq(button.attrs["spell-heal2"],"Flash Heal(Rank 4)","highest rank reaches the secure attribute")

-- An explicit rank is kept, both for casting and in the box.
env.HealBot_Action_SetSpell("ENABLED","Left","Flash Heal(Rank 2)")
env.HealBot_Action_ClearSpellCache()
name,_,_,id=env.HealBot_Action_GetSpell("ENABLED","Left")
eq(name,"Flash Heal(Rank 2)","explicit rank kept")
eq(id,9472,"explicit rank ID kept")
eq(env.HealBot_Action_GetSpellDisplay("ENABLED","Left"),"Flash Heal(Rank 2)","box shows the explicit rank")

-- Spells without ranks, and empty slots, are unchanged.
env.HealBot_Action_SetSpell("ENABLED","Button4","Fade")
env.HealBot_Action_ClearSpellCache()
eq(env.HealBot_Action_GetSpell("ENABLED","Button4"),"Fade","rankless spell unchanged")
eq(env.HealBot_Action_GetSpellDisplay("ENABLED","Button4"),"Fade","rankless spell box unchanged")
eq(env.HealBot_Action_GetSpellDisplay("ENABLED","Button5"),nil,"empty slot shows nothing")

-- NoRanks and modern clients keep their previous behaviour.
env.HealBot_Globals.NoRanks=true
env.HealBot_Action_ClearSpellCache()
eq(env.HealBot_Action_GetSpell("ENABLED","Middle"),"Flash Heal(Rank 1)","NoRanks keeps the saved ID")
eq(env.HealBot_Action_GetSpellDisplay("ENABLED","Middle"),"Flash Heal(Rank 1)","NoRanks box uses GetSpell")
env.HealBot_Globals.NoRanks=false; env.HEALBOT_GAME_VERSION=11
env.HealBot_Action_ClearSpellCache()
eq(env.HealBot_Action_GetSpell("ENABLED","Middle"),"Flash Heal(Rank 1)","modern clients keep the saved ID")
eq(env.HealBot_Action_GetSpellDisplay("ENABLED","Middle"),"Flash Heal(Rank 1)","modern client box uses GetSpell")

-- The options spell boxes (and the spell drag-and-drop path) must use the display text.
local options=read("HealBot/HealBot_Options.lua")
for _,fn in ipairs({"HealBot_Options_ComboClass_Text","HealBot_Options_SpellsCheckTextValid"}) do
    local src=body(options, fn)
    eq(src:find("HealBot_Action_GetSpellDisplay(",1,true)~=nil,true,fn.." uses GetSpellDisplay")
    eq(src:find("HealBot_Action_GetSpell(",1,true),nil,fn.." no longer shows GetSpell's ranked text")
end
local dropped=options:match("HealBot_Action_SetSpell%(cType, HealBot_Action_GetCombo%(modifier, HealBot_Options_ComboClass_Button%(id%)%), info%)\n%s*info=([%w_]+)%(")
eq(dropped,"HealBot_Action_GetSpellDisplay","dropped spell is shown via GetSpellDisplay")

print("PASS: "..passed.." unranked spell assertions (mock APIs)")
