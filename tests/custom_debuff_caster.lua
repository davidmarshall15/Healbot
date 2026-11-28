local f=assert(io.open("HealBot/Healbot_Aura.lua","rb"))
local source=f:read("*a"):gsub("\r\n","\n"); f:close()
local function fn(name) return source:match("(function "..name.."%b().-\nend)") end
local partial=assert(source:match("(do\n    local function casterMatches.-\nend)\n\nfunction HealBot_Aura_CheckUnitDebuffs")
    or source:match("(do\n    local function customBar.-\nend)\n\nfunction HealBot_Aura_CheckUnitDebuffs"))
local opaque={}
local index={all=1,enemy=2,friend=3,self=4}
local e=setmetatable({
    HEALBOT_CUSTOM_CASTBY_EVERYONE="all",HEALBOT_CUSTOM_CASTBY_ENEMY="enemy",
    HEALBOT_CUSTOM_CASTBY_FRIEND="friend",HEALBOT_OPTIONS_SELFHEALS="self",HEALBOT_CUSTOM_en="Custom",
    HealBot_Globals={CureCustomDefaultCastBy=index.all,CustomDebuffsShowBarCol={}},
    castByListIndexed=index,hbCustomDebuffsCastBy={},HealBot_UnitDebuffCurrent={},HealBot_DebuffFilter={},
    HealBot_Config_Cures={CDCshownHB=true},HealBot_Options_retDebuffPriority=function() return 7,21 end,
    HealBot_Aura_CustomDebuffDisabled=function() return false end,HealBot_Aura_CustomDebuffSetting=function() return 4 end,
    HealBot_issecretvalue=function(v) return rawequal(v,opaque) end,
    HealBot_SafeUnitIsUnit=function(a,b) return (a=="raid3" and b=="player") or a==b end,
    uaDebuffSlot=1,uaDebuffData={[1]={{spellId=613,name="Fixture"}}},HealBot_AuraDebuffCache={},
},{__index=_G})
local helper=fn("HealBot_Aura_CustomDebuffCasterMatches") or ""
setfenv(assert(loadstring(helper.."\n"..assert(fn("HealBot_Aura_CheckCurCustomDebuff")).."\n"..partial)),e)()
local button={id=1,unit="raid1",aura={debuff={}}}
local data=e.uaDebuffData[1][1]
local function check(source,friendly,enemy,mine,accept)
    local function reaction(value,unit)
        assert(unit and unit~="nil" and unit~="" and not rawequal(unit,opaque),"queried a missing caster")
        return value
    end
    e.UnitIsFriend=function(_,unit) return reaction(friendly,unit) end
    e.UnitIsEnemy=function(_,unit) return reaction(enemy,unit) end
    for rule,id in pairs(index) do
        data.sourceUnit,data.sourceUnitIsPlayer=source,mine
        e.debuffIsCurrent=true; e.HealBot_AuraDebuffCache[613]={customPrio=7}
        e.hbCustomDebuffsCastBy[613]=id
        e.HealBot_Aura_CheckCurCustomDebuff(button,true)
        assert(e.debuffIsCurrent==(not not accept[rule]),"full scan misclassified "..rule)
        assert((not not e.HealBot_AuraDebuffCache[613].always)==(rule=="all"),"caster rule cached by ID")
        button.aura.debuff.partialWarnings={{id=613,name="Fixture",source=source}}
        local got=e.HealBot_Forever_GetPartialBarWarning(button,false)
        assert((got==613)==(not not accept[rule]),"partial scan misclassified "..rule)
        local own=e.HealBot_Forever_GetPartialBarWarning(button,true)
        assert((own==613)==(mine and not not accept[rule]),"self-only scan misclassified "..rule)
    end
end
check("neutral",false,false,false,{all=true})
check("party2",true,false,false,{all=true,friend=true})
check("target",false,true,false,{all=true,enemy=true})
check(nil,nil,nil,false,{all=true})
check("nil",nil,nil,false,{all=true})
check("",nil,nil,false,{all=true})
check(opaque,nil,nil,false,{all=true})
check("raid2",opaque,opaque,false,{all=true})
check("raid2",opaque,true,false,{all=true,enemy=true})
check("raid2",true,opaque,false,{all=true,friend=true})
check("player",nil,nil,true,{all=true,self=true,friend=true})
check("raid3",nil,nil,true,{all=true,self=true,friend=true})
print("PASS: full and partial custom-debuff rules agree for player aliases, friends, enemies, neutral, missing and restricted sources")
