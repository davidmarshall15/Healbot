local function read(path)
    local f=assert(io.open(path,'rb')); local s=f:read('*a'); f:close()
    return s:gsub('\r\n','\n'):gsub('^\239\187\191','')
end
local source=read('HealBot/Healbot_Aura.lua')
local start=assert(source:find('function HealBot_Aura_FilterNone(',1,true))
local finish=assert(source:find('local function HealBot_Aura_FilterUnitBuffs(',start,true))
local setterStart=assert(source:find('local function HealBot_Aura_ConfigBuffFilter(',1,true))
local setterEnd=assert(source:find('function HealBot_Aura_ConfigClassHoT()',setterStart,true))
local filters=assert(source:match('local HealBot_BuffFilter=%{%}'))..'\n'..source:sub(start,finish-1)..
    source:sub(setterStart,setterEnd-1)..'\nreturn HealBot_Aura_ConfigBuffFilter'
local prefix=assert(read('tests/native_buff_casters.lua'):match('^(.-)\nlocal function admits%('))
local fixture=assert(loadstring(prefix..'\nreturn fixture'))()
local d=fixture('PRIEST',4); local e=d.env
e.HealBot_Data={PGROUP=1}; e.HealBot_Config={PrivFocus='member'}
for _,name in ipairs({'HealBot_Panel_IsPrivateList','HealBot_Panel_IsPrivateTank','HealBot_Panel_IsPrivateHealer','HealBot_Panel_IsPrivateDamager'}) do
    e[name]=function(guid) return guid=='member' end
end
local setFilter=setfenv(assert(loadstring(filters)),e)()
assert(e.HealBot_BuffFilter==nil,'fixture leaked the private filter table to the native module')
setFilter(139,'Renew',1)
local b=d.button(); local row=assert(d.row(b)); local allocated=#d.frames
local function admitted()
    return row.groups.hbcahot.options.candidateFilters.includeSpellIDs[139]==true
end
for id=1,14 do
    for _,match in ipairs({false,true}) do
        b.roletxt=match and ({[2]='TANK',[3]='HEALER',[4]='DAMAGER'})[id] or 'NONE'
        b.mana={type=match and (id==6 and 1 or 0) or (id==6 and 0 or 1)}
        b.group=match and 1 or 2
        b.isplayer=(id==9) and not match or (id~=9 and match)
        b.guid=match and 'member' or 'other'
        setFilter(139,'Renew',id)
        local expected=(id==1 or match)
        assert((not not e.HealBot_Aura_BuffTargetMatches(b,e.HealBot_Aura_GetBuffTargetFilter(139,'Renew')))==expected)
        d.hook('HealBot_Aura_SetAuraCheckFlags')
        assert(admitted()==expected,'native target filter differs from legacy filter '..id)
        d.combat(true); d.hook('HealBot_Aura_CheckUnitBuffs',b)
        assert(admitted()==expected,'combat target filter differs from legacy filter '..id)
        d.combat(false)
        assert(#d.frames==allocated,'target filter change rebuilt native frames')
    end
end
-- A policy with denied IDs is reusable, rather than forcing native writes.
setFilter(139,'Renew',2); b.roletxt='NONE'; d.hook('HealBot_Aura_SetAuraCheckFlags')
local writes=row.filterWrites
for _=1,10 do d.hook('HealBot_Aura_CheckUnitBuffs',b) end
assert(row.filterWrites==writes,'unchanged filtered policy rewrites native filters')
setFilter(139,'Renew',nil); d.hook('HealBot_Aura_SetAuraCheckFlags')
assert(admitted(),'removing target filter did not restore configured buff')
setFilter(139,'Renew',2)
local role='TANK'
e.UnitGroupRolesAssigned=function() return role end
e.UnitPowerType=function() return 0 end
e.UnitGUID=function() return 'member' end
local reserve={unit='raid20',frame=1,healthBar={}}
function reserve:GetFrameLevel() return 5 end
e.HealBot_Forever_SkinArrivalAuras(reserve,b)
local reserveRow=reserve.arrivalAuras[1].container
assert(reserveRow.groups.hbcahot.options.candidateFilters.includeSpellIDs[139],'arrival row failed public role filter')
role='HEALER'; e.HealBot_Forever_UpdateArrivalAuras(reserve)
assert(not reserveRow.groups.hbcahot.options.candidateFilters.includeSpellIDs[139],'arrival role change ignored target filter')
role='TANK'; e.HealBot_Forever_UpdateArrivalAuras(reserve)
assert(reserveRow.groups.hbcahot.options.candidateFilters.includeSpellIDs[139],'arrival role recovery did not restore configured buff')
setFilter(139,'Renew',7)
local subgroup=1
e.GetRaidRosterInfo=function() return 'member',0,subgroup end
d.hook('HealBot_Aura_ConfigClassHoT')
e.HealBot_Forever_UpdateArrivalAuras(reserve)
assert(reserveRow.groups.hbcahot.options.candidateFilters.includeSpellIDs[139],'arrival own-group metadata ignored')
subgroup=2; e.HealBot_Forever_UpdateArrivalAuras(reserve)
assert(not reserveRow.groups.hbcahot.options.candidateFilters.includeSpellIDs[139],'arrival subgroup change ignored')

-- Triggered variants can have an entirely different name. An explicit
-- per-ID setting wins, otherwise the registered family's target rule applies.
d.names[401859]='Prayer of Mending'; d.names[41635]='Mending transfer'
d.globals.WatchHoT.PRIE[401859]=1
setFilter(401859,'Prayer of Mending',2)
b.roletxt='HEALER'
d.hook('HealBot_Aura_ConfigClassHoT')
local function permits(id) return row.groups.hbcahot.options.candidateFilters.includeSpellIDs[id]==true end
assert(not permits(41635),'name-different triggered rank bypassed its configured tank-only target')
d.globals.CustomBuffIDMethod[41635]=1
setFilter(41635,'Mending transfer',3)
d.hook('HealBot_Aura_ConfigClassHoT')
assert(permits(41635) and not permits(401859),'explicit triggered-ID rule lost to the base-family rule')

-- No visible identity is required by role-only filters. Restrict the
-- callback count to the configured predicates rather than the rank count.
local visits={}
local real=e.HealBot_Aura_BuffTargetMatches
e.HealBot_Aura_BuffTargetMatches=function(button,rule)
    visits[rule]=(visits[rule] or 0)+1
    return real(button,rule)
end
d.hook('HealBot_Aura_CheckUnitBuffs',b)
assert(visits[2]==1 and visits[3]==1 and visits[7]==1,'native update re-evaluated each spell rank')
local secret={}; e.HealBot_issecretvalue=function(value) return rawequal(value,secret) end
e.UnitGroupRolesAssigned=function() return secret end
e.HealBot_Forever_UpdateArrivalAuras(reserve)
assert(not reserveRow.groups.hbcahot.options.candidateFilters.includeSpellIDs[41635],'unknown reserve role admitted a restricted rule')
print('PASS: 14 real shared target predicates, matching/nonmatching targets and combat handoffs; no frame allocations or redundant native policy writes')
