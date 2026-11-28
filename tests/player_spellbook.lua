local root=arg[1] or "HealBot"
local baseline=arg[2]=="baseline"
local function read(file)
    local f=assert(io.open(root.."/"..file,"rb"))
    local s=f:read("*a"):gsub("\r\n","\n"); f:close();return s
end
local init=read("HealBot_Init.lua")
local adapter=assert(read("Libs/LibWoWAPI/HealBot_WoWAPI.lua"):match("(%-%- C_SpellBook\n.-)%-%- C_Item"))
-- SpellName and normal-difficulty SpellLevels from the installed build. The
-- test models a player learning each rank at that level, then enumerates the
-- simulated book in both directions. No character-specific data is assumed.
local classes={
    WARR={"Heroic Strike",78,1,284,8,285,16}, PALA={"Holy Light",635,1,639,6,647,14},
    HUNT={"Raptor Strike",2973,1,14260,8,14261,16}, ROGU={"Sinister Strike",1752,1,1757,6,1758,14},
    PRIE={"Lesser Heal",2050,1,2052,4,2053,10}, SHAM={"Healing Wave",331,1,332,6,547,12},
    MAGE={"Fireball",133,1,143,6,145,12}, WARL={"Shadow Bolt",686,1,695,6,705,12},
    DRUI={"Healing Touch",5185,1,5186,8,5187,14},
}
local noop=function() end
local runs=0
local function run(class,data,level,reverse,buff,noRanks)
    local slots,names,ranks,learned={},{},{},{}
    local pending,timerCalls={},0
    local ready=false
    local function slot(kind,id,name,rank,extra)
        local t=extra or {}; t.itemType,t.actionID,t.name,t.subName=kind,id,name,rank
        slots[#slots+1]=t
    end
    local top=0
    for rank=1,3 do
        local id,minLevel=data[2*rank],data[2*rank+1]
        names[id],ranks[id]=data[1],"Rank "..rank
        if minLevel<=level then top=rank; learned[id]=true end
    end
    names[200001],names[200002],names[200003]="Future","Pet","Passive"
    names[200004],names[200005],names[200006]="Unlearned flyout","Base flyout","Override flyout"
    names[200007],names[200008],names[200009]="Offspec","Unresolved","Final"
    names[200010],names[200011]="Offspec line","NPC-only lookup"
    learned[200006],learned[200009]=true,true
    for j=1,top do
        local rank=reverse and top+1-j or j
        local id=data[2*rank]
        slot(1,id,data[1],ranks[id])
    end
    slot(1,200008,"Unresolved","") -- slot exists, definition temporarily misses
    slot(2,200001,"Future","")
    slot(3,200002,"Pet","")
    slot(1,200003,"Passive","",{isPassive=true})
    slot(1,200007,"Offspec","",{isOffSpec=true})
    slot(4,451,"Parent flyout","Rank 99")
    slot(4,452,"Unavailable flyout","")
    slot(1,false,"Bad ID","")
    slot(1,false,"","",{missing=true})
    slot(1,200009,"","") -- resolve the public name by learned slot ID
    local currentEnd=#slots
    slot(1,200010,"Offspec line","")
    local petRequests=0
    local e=setmetatable({
        HEALBOT_FOREVER=true,HEALBOT_GAME_VERSION=1,HEALBOT_CLIENT_VERSION=12,
        HealBot_Data={PCLASSTRIM=class},HealBot_Config={CurrentSpec=1},
        HealBot_Globals={NoRanks=noRanks}, HealBot_Spell_IDs={},HealBot_Spell_Names={},
        HealBot_issecretvalue=function() return false end, InCombatLockdown=function() return false end,
        HealBot_SetToolTip=noop,HealBot_ScanTooltip={GetRegions=noop,SetSpellBookItem=noop},
        getn=table.getn,gsub=string.gsub,HealBot_Util_isMidnight=function() return false end,
        HealBot_Options_InitBuffSpellsClassList=function() return buff and {data[2]} or {} end,
        HealBot_WoWAPI_SpellName=function(id) return names[id],ranks[id] end,
        HealBot_WoWAPI_SpellInfo=function(id)
            if type(id)=="string" then return end
            if (ready or id~=200008) and names[id] then
                local range
                if id~=200009 then range=30 end
                return names[id],nil,123,0,0,range,id
            end
        end,
        GetSpellBaseCooldown=function(id)
            assert(names[id] and (baseline or ready or id~=200008),"looked up cooldown for unresolved spell")
            return 0
        end,
        HealBot_WoWAPI_IsSpellPassive=function(id) assert(type(id)=="number");return false end,
        HealBot_WoWAPI_SpellPowerCost=function(id) return id==200009 and {} or {{cost=25}} end,
        HealBot_WoWAPI_HelpfulSpell=function() return true end,
        HealBot_WoWAPI_HarmfulSpell=function() return false end,
        HealBot_Spells_KnownByName=function(name) return name~="Final" and name and name~="" end,
        HealBot_Range_InitSpell=noop,HealBot_Options_setLuVars=noop,
        HealBot_Timers_Set=function(cat,name) if cat=="LAST" and name=="InitLoadSpells" then timerCalls=timerCalls+1 end end,
        C_Timer={After=function(_,fn) pending[#pending+1]=fn end},
        Enum={SpellBookSpellBank={Player=0,Pet=1}},
        GetFlyoutInfo=function(id) if id==451 then return nil,nil,3,true end;return nil,nil,nil,true end,
        GetFlyoutSlotInfo=function(_,i)
            if i==1 then return 200004,nil,false,"Unlearned flyout" end
            if i==2 then return nil,nil,true,"" end
            return 200005,200006,true,"Base flyout"
        end,
        C_SpellBook={
            GetNumSpellBookSkillLines=function() return 3 end,
            GetSpellBookSkillLineInfo=function(i)
                if i==1 then return {itemIndexOffset=0,numSpellBookItems=currentEnd} end
                if i==2 then return ready and {itemIndexOffset=currentEnd,numSpellBookItems=0} or {} end
                return {itemIndexOffset=currentEnd,numSpellBookItems=1,offSpecID=2}
            end,
            GetSpellBookItemInfo=function(i,bank)
                if bank==1 then petRequests=petRequests+1;return {itemType=1,actionID=200002} end
                if slots[i] and slots[i].missing then return end
                return slots[i]
            end,
            GetSpellBookItemName=function(i) return slots[i].name,slots[i].subName end,
            IsSpellKnown=function(id) return learned[id] end,
        },
        HEALBOT_RANK=setmetatable({},{__index=function(_,r) return "(Rank "..r..")" end}),
    },{__index=_G})
    e._G=e
    for _,prefix in ipairs({"HEALBOT_","HBC_"}) do
        for key in init:gmatch(prefix.."[A-Z_]+") do if e[key]==nil then e[key]=key end end
    end
    setfenv(assert(loadstring(adapter)),e)()
    e.HealBot_WoWAPI_SetC_SpellBook()
    setfenv(assert(loadstring(init)),e)()
    local ok,why=pcall(e.HealBot_Init_Spells_Defaults)
    if baseline then
        assert(not ok and tostring(why):find("attempt to index field '?'",1,true),tostring(why))
        return
    end
    assert(ok,why)
    assert(e.HealBot_Spell_Names.Final==200009 and e.HealBot_Spell_IDs[200006].name=="Override flyout")
    for id=200001,200011 do assert((e.HealBot_Spell_IDs[id]~=nil)==(learned[id]==true),"unlearned ID "..id) end
    assert(petRequests==0)
    for rank=1,3 do
        local id=data[2*rank]
        assert((e.HealBot_Spell_IDs[id]~=nil)==(rank<=top))
        if not noRanks then assert(e.HealBot_Spell_Names[data[1].."(Rank "..rank..")"]==(rank<=top and id or nil)) end
    end
    local base=(buff or noRanks) and e.HealBot_Spell_Names[data[1]] or e.HealBot_Init_knownClassicHealSpell(data[1])
    assert(base==data[top*2],class.." unranked ID")
    assert(#pending==1)
    pending[1]()
    assert(timerCalls==1)
    e.HealBot_Init_Spells_Defaults()
    assert(#pending==1,"permanently unresolved spell caused a retry loop")
    ready=true
    e.HealBot_Init_Spells_Defaults()
    assert(e.HealBot_Spell_Names.Unresolved==200008,"newly available learned spell was lost")
    local last=e.HealBot_Spell_IDs[200009]
    e.HealBot_WoWAPI_NumSpellTabs=function() return nil end
    assert(e.HealBot_Init_Spells_Defaults()==false and e.HealBot_Spell_IDs[200009]==last)
    runs=runs+1
end
for class,data in pairs(classes) do
    for i=1,3 do
        for _,reversed in ipairs({true,false}) do
            for _,buff in ipairs({true,false}) do
                for _,noRanks in ipairs({true,false}) do run(class,data,data[2*i+1],reversed,buff,noRanks) end
            end
        end
    end
end
print(baseline and "BASELINE: unresolved spell interrupts learned book before the later slot" or "PASS: "..runs.." nine-class level/rank layouts and partial player-book recovery")
