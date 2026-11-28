local function read(path)
    local f=assert(io.open(path,"rb"))
    local s=f:read("*a"):gsub("\r\n","\n")
    f:close()
    return s
end
local base=assert(read("tests/bg_weakened_soul.lua"):match("^(.-)local d=fixture"))
local fixture=assert(loadstring(base.."return fixture"))()
for _,double in ipairs({false,true}) do
    local d=fixture("DRUID",4)
    local e=d.env
    e.IsInInstance=function() return true,"pvp" end
    e.HealBot_Forever_GetDebuffTypes=function() return {Magic=true},"Magic",false end
    e.HealBot_Forever_WatchesWeakenedSoul=function() return false end
    e.HealBot_Timers_Set=function() end
    d.globals.CombatAurasDebuffs=4
    d.skin.double=double
    local def=e.hbv_Skins_GetIconVar
    e.hbv_Skins_GetIconVar=function(k,f,z)
        if k=="MAXDICONS" then return 4 end
        return def(k,f,z)
    end
    local b=d.button()
    d.combat(true)
    local row
    for _,f in ipairs(d.frames) do if f.groups.hbcadb then row=f end end
    assert(row and row.shown)
    local count=#d.frames
    local originalX=row.point[4]
    local layout=row.groups.hbcadb.options
    local state={scanUnit=b.unit,scanCombat=true,sortedPublicIcons=true,
        publicDispels={[201]=true,[202]=true},visibleDispels={[201]=true}}
    b.aura={debuff=state}
    b.icon={debuff={count={2,0,0}}}
    local setLimit=row.SetAuraGroupMaxFrameCount
    local attempts=0
    row.SetPoint=function() error("lockdown rejects moving the native anchor") end
    row.SetAuraGroupMaxFrameCount=function(...)
        attempts=attempts+1
        return setLimit(...)
    end
    local offset,public=e.HealBot_CombatAuras_GetMixedDebuffSlots(b,4,2)
    assert(offset==2 and public==2)
    d.hook("HealBot_Aura_CheckUnitDebuffs",b)
    assert(row.shown and row.point[4]==originalX and #d.frames==count)
    assert(layout.maxFrameCount==2,"public and native artwork exceeded the total skin cap")
    assert(layout.candidateFilters.excludeSpellIDs[201] and not layout.candidateFilters.excludeSpellIDs[202])
    assert(layout.candidateFilters.includeDispelTypes.Magic,"public ID hid a protected sibling of the same type")
    -- Real ordinary sorter and add/remove pass use prepared indices 53/54
    -- after native slots 51/52, including on a double-column skin.
    local source=read("HealBot/Healbot_Aura.lua")
    local function fn(name) return assert(source:match("(function "..name.."%b().-\nend)")) end
    local rendered,appeared={},{}
    b.id=1
    local icons={}
    for i=51,60 do icons[i]={current=false} end
    local env=setmetatable({HealBot_AuraDebuffXRef={a={spellID=201,slot=1},b={spellID=203,slot=2}},
        debuffSort={{"a","b"},{},{}},uaDebuffData={{{priority=1},{priority=2}}},
        HealBot_AuraDebuffCache={[201]={priority=1},[203]={priority=2}},HealBot_UnitDebuffIcons={icons},
        HealBot_Aura_prevIconCount={DEBUFF={0,0,0}},debuffIconPrio=21,
        HealBot_Aura_GetDebuffIconPreference=function() return true end,
        HealBot_Aura_CacheDebuffIcon=function(_,slot,id) rendered[slot]=id end,
        HealBot_Aura_DebuffAddIcon=function(_,slot) appeared[slot]=true end,
        HealBot_Aura_RemoveIcon=function(_,slot) appeared[slot]=nil end},{__index=e})
    setfenv(assert(loadstring(fn("HealBot_Aura_SortDebuffIconSet").."\n"..fn("HealBot_Aura_CheckUnitDebuffIcons"))),env)()
    env.HealBot_Aura_SortDebuffIconSet(b,1,50)
    env.HealBot_Aura_CheckUnitDebuffIcons(b)
    assert(appeared[53] and appeared[54] and rendered[53]==201 and rendered[54]==203
        and not appeared[51] and not appeared[52],"ordinary artwork occupied the native slots")
    e.HealBot_CombatAuras_GetMixedDebuffSlots(b,4,2)
    d.hook("HealBot_Aura_CheckUnitDebuffs",b)
    assert(attempts==1,"unchanged mixed ownership rewrote a live budget")
    row.SetAuraGroupMaxFrameCount=function(...)
        attempts=attempts+1
        error("lockdown rejects changing the native capacity")
    end
    -- Continue using both confirmed native slots and the two prepared public
    -- slots. Further aura events cannot repeatedly call the rejected API.
    for i=1,10 do
        offset,public=e.HealBot_CombatAuras_GetMixedDebuffSlots(b,4,3)
        assert(offset==2 and public==2 and layout.maxFrameCount==2)
    end
    assert(attempts==2 and row.shown and #d.frames==count)
    state.scanCombat=false
    d.combat(false)
    row.SetAuraGroupMaxFrameCount=setLimit
    -- A fresh, visible public-only scan returns every slot to ordinary icons.
    state.publicUnit=b.unit
    d.hook("HealBot_Aura_CheckUnitDebuffs",b)
    offset,public=e.HealBot_CombatAuras_GetMixedDebuffSlots(b,4,4)
    assert(not row.shown and offset==0 and public==4)
    state.publicUnit=nil;b.icon.debuff.count[1]=0
    -- The first rest attempt was denied during the fake transition; the
    -- native row keeps its last safe budget, then can recover after cooldown.
    e.GetTime=function() return 100 end
    d.hook("HealBot_Aura_CheckUnitDebuffs",b)
    assert(row.shown and layout.maxFrameCount==4 and #d.frames==count)

end
print("PASS: mixed public/protected debuff geometry, per-effect exclusions, shared cap, retry and no extra frames")
