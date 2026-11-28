local function read(path)
    local f=assert(io.open(path,'rb')); local s=f:read('*a'); f:close(); return s:gsub('\r\n','\n')
end
local n=assert(read('tests/native_buff_casters.lua'):match('^(.-)\nlocal function admits%('))
local fixture=assert(loadstring(n..'\nreturn fixture'))()
local e,bare,swap,aura,sealed=assert(loadfile("tests/fixtures/public_helpful.lua"))()("party",true)
local zone,guid,restricted,visible='pvp','public-one',false,true
local d=fixture('PRIEST',4,function(env)
    env.IsInInstance=function() return true,zone end
    env.UnitGUID=function() return guid end; env.UnitIsVisible=function() return visible end
    env.C_Secrets={ShouldAurasBeSecret=function() return restricted end};env.C_RestrictedActions={}
    env.HealBot_issecretvalue=e.HealBot_issecretvalue
end)
e.HealBot_CombatAuras_PublicBuffContext=d.env.HealBot_CombatAuras_PublicBuffContext
e.HealBot_CombatAuras_LegacyBuffMatches=d.env.HealBot_CombatAuras_LegacyBuffMatches
local b=d.button('raid3'); local mock=bare('raid3',1)
for k,v in pairs(mock) do if not b[k] then b[k]=v end end
b.aura=mock.aura; b.icon=mock.icon; b.id=1
local row=d.row(b); local frameCount=#d.frames
local function scan(auras,expected,locked)
    swap(auras,locked); b.aura.buff.update=true
    e.HealBot_Aura_CheckUnitBuffs(b,false)
    d.hook('HealBot_Aura_CheckUnitBuffs',b)
    assert(row.shown==(not expected),'wrong renderer after '..#auras..'-aura scan')
    assert(b.gref.icon[1].shown==expected,'legacy artwork ownership mismatch')
end
assert(row.shown,'unproven BG bar failed to use native row')
scan({aura(139,'Renew',300)},true)
assert(not b.aura.buff.scanIncomplete and b.aura.buff.publicRendered)
guid='public-two'; d.hook('HealBot_Aura_SetAuraCheckFlags'); assert(row.shown,'reused token kept old scan')
scan({},true); d.fire('PLAYER_ENTERING_WORLD'); assert(row.shown,'stale world generation survived')
scan({sealed},false); scan({},true)
restricted=true; d.fire('ADDON_RESTRICTION_STATE_CHANGED'); assert(row.shown); scan({},false)
restricted=sealed; scan({},false); restricted=false; visible=false; scan({},false)
visible=true; guid=sealed; scan({},false); guid='public-two'
local many={}; for i=1,21 do many[i]=aura(10000+i,'Other'..i) end; scan(many,true)
many[21]=sealed; scan(many,false)
local readBeyondTwenty=e.C_UnitAuras.GetAuraDataByIndex
e.C_UnitAuras.GetAuraDataByIndex=function(unit,index,filter)
    if index==21 then error('partial scan after twenty readable entries') end
    return readBeyondTwenty(unit,index,filter)
end
scan(many,false); assert(b.aura.buff.scanIncomplete)
e.C_UnitAuras.GetAuraDataByIndex=readBeyondTwenty
many[21]=nil; scan(many,true)
-- The native-only trigger is a different public name, outside the legacy watch list.
d.globals.WatchHoT.ALL[99010]=3
assert(d.env.HealBot_Forever_RegisterAuraFamily(99010,{99011}))
scan({aura(99011,'Triggered Effect')},false)
scan({aura(139,'Renew',320)},true); d.combat(true); assert(row.shown)
local originalRead=e.C_UnitAuras.GetAuraDataByIndex
local readFilter
e.C_UnitAuras.GetAuraDataByIndex=function(unit,index,filter)
    readFilter=filter
    return originalRead(unit,index,filter)
end
scan({aura(139,'Renew',320)},true,true); assert(readFilter=='HELPFUL')
scan({sealed},false,true)
restricted=true; d.fire('ADDON_RESTRICTION_STATE_CHANGED')
scan({},false,true); assert(readFilter=='RAID_IN_COMBAT')
restricted=false; scan({},true,true)
d.combat(false); assert(row.shown,'combat-era scan survived regen')
scan({},true); d.hook('HealBot_Action_UnregisterUnitEvents',b)
d.hook('HealBot_Action_RegisterUnitEvents',b,'unrelated argument'); assert(row.shown,'rebind reused old scan')
d.env.C_Secrets=nil; scan({},false)
assert(#d.frames==frameCount,'ownership transitions rebuilt frames')
print('PASS: complete public helpful scans of all sizes restore legacy ownership; restrictions, partial scans, world changes, GUID reuse and native-only triggers retain native rows')
