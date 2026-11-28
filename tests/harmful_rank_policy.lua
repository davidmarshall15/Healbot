local function read(path)
    local f=assert(io.open(path,"rb"));local s=f:read("*a"):gsub("\r\n","\n");f:close();return s
end
local s=read("HealBot/Healbot_Aura.lua")
local function get(n) return assert(s:match("(function "..n.."%b().-\nend)"),n) end
local G={CustomDebuffs={[111]=2,[211]=1},CustomDebuffIDMethod={[211]=1},
    IgnoreCustomDebuff={[111]={ZoneA=true},[112]={ZoneB=true},[211]={ZoneC=true}},DebuffIconVisibility={}}
local names={[111]="Ranks",[112]="Ranks",[113]="Ranks",[114]="Ranks",[211]="Exact",[212]="Exact"}
local queried,expanded={},{}
local e=setmetatable({
    HealBot_Globals=G,HealBot_WoWAPI_SpellName=function(id) return names[id] end,
    hbCustomDebuffsDisabled={},hb_lVars={},HealBot_Timers_Set=function() end,
    HealBot_issecretvalue=function() return false end,
    HealBot_Forever_VisitSpellNameIDs=function(id,name,visit)
        expanded[id]=true
        for k,v in pairs(names) do if v==name then visit(k,v) end end
    end,
    C_Secrets={GetSpellAuraSecrecy=function(id) return id==113 and 1 or 0 end},
    Enum={SecrecyLevel={NeverSecret=0}},
    C_UnitAuras={GetUnitAuraBySpellID=function(_,id) queried[id]=true end},
    InCombatLockdown=function() return true end
},{__index=_G})
local ops=assert(s:match("(do\n    local function readable%(aura%).-\nend)\n\nfunction HealBot_Aura_UpdateUnitDebuffsV9"))
setfenv(assert(loadstring(get("HealBot_Aura_setCustomDebuffFilterDisabled").."\n"..get("HealBot_Aura_CustomDebuffDisabled").."\n"..ops)),e)()
e.HealBot_Aura_setCustomDebuffFilterDisabled()
for _,zone in ipairs({"ZoneA","ZoneB"}) do
    e.hb_lVars.mapName=zone
    assert(e.HealBot_Aura_CustomDebuffDisabled(119,"Ranks"),"lost one name-mode rank exclusion")
end
e.hb_lVars.mapName="ZoneC"
assert(e.HealBot_Aura_CustomDebuffDisabled(211,"Exact") and not e.HealBot_Aura_CustomDebuffDisabled(212,"Exact"))
local b={unit="raid1",aura={debuff={lookupSeen={[112]=true}}}}
e.HealBot_Aura_UpdateExplicitCombatDebuffs(b,false)
assert(queried[111] and queried[114] and not queried[113] and not queried[112])
assert(queried[211] and not queried[212] and not expanded[211],"ID-only rule expanded to a rank")
print("PASS: multiple name-mode zone exclusions, strict ID, public rank lookup and same-name duplicate suppression")
