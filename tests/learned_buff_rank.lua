local function read(path)
    local f=assert(io.open(path,'rb')); local s=f:read('*a'); f:close(); return s:gsub('\r\n','\n')
end
local native=assert(read('tests/native_buff_casters.lua'):match('^(.-)\nlocal function admits%('))
local fixture=assert(loadstring(native..'\nreturn fixture'))()
local legacy,make,put,aura,_,setGroup=dofile("tests/fixtures/ordinary_helpful.lua")
setGroup(true,false,0)
legacy.HealBot_Aura_CheckUnitBuff=function() end
legacy.HealBot_Aura_CheckUnitBuffIcons=function() end
legacy.HealBot_Aura_BuffWarnings=function() end
legacy.HealBot_Aura_ClearBuff=function() end
legacy.HealBot_Aura_BuffUpdate_Plugins=function() end
legacy.HealBot_Aura_SortBuffIcons=function() return 0 end
local b=make('party2',1)
local function scan(auras)
    put(auras); b.aura.buff.update=true; legacy.HealBot_Aura_CheckUnitBuffs(b,false)
end
local queued, calls=nil,0
local d=fixture('PRIEST',4,function(e)
    e.HealBot_Aura_VisitKnownBuffs=legacy.HealBot_Aura_VisitKnownBuffs
    e.C_Timer={After=function(delay,callback)
        assert(delay==0 and not queued,'rank discovery scheduled redundant work')
        queued=callback; calls=calls+1
    end}
end)
legacy.HealBot_Forever_ObserveBuffRank=d.env.HealBot_Forever_ObserveBuffRank
local base,name=99080,'Unfamiliar heal'
d.names[base]=name; d.globals.WatchHoT.ALL[base]=3
local row=d.row(d.button())
local function tracks(id) return row.groups.hbcahotEveryone.options.candidateFilters.includeSpellIDs[id] end
assert(tracks(base) and not tracks(99081) and not tracks(99082))
local allocated=#d.frames
local function flush() local nextFrame=assert(queued); queued=nil; nextFrame() end
scan({aura(139,'Renew'),aura(99079,'Unrelated')}); assert(calls==0,'unrelated or known ID queued a refresh')
d.combat(true)
scan({aura(99081,name),aura(99082,name)}); assert(calls==1 and queued,'new public ranks did not coalesce')
flush(); assert(tracks(99081) and tracks(99082)); assert(#d.frames==allocated)
scan({aura(99081,name)}); assert(calls==1,'old rank compiled twice')
d.globals.CustomBuffIDMethod[base]=1; d.hook('HealBot_Aura_ConfigClassHoT')
scan({aura(99083,name)}); assert(calls==1 and not tracks(99083),'strict ID widened')
print('PASS: cold public ranks of an unfamiliar configured spell coalesce to one policy refresh, known/strict/unwatched IDs stay idle, no frames allocated in combat')
