local function read(path)
    local f=assert(io.open(path,'rb')); local s=f:read('*a'); f:close()
    return s:gsub('\r\n','\n'):gsub('^\239\187\191','')
end
local prefix=assert(read('tests/party_startup.lua'):match('^(.-)\nlocal passed=0'))
local runtime=assert(loadstring(prefix..'\nreturn runtime'))()
local env=runtime()
env.loaded=true; env.HealBot_Media_Register()
env.IsInRaid=function() return true end
env.UnitExists=function(unit) return tonumber(unit:match('%d+'))<=12 end
env.BindRow=function() end
local snapshots,skins,bindings,watches=0,0,0,0
env.BindRow=function(row) bindings=bindings+1; row.bindingGeneration=0 end
env.RegisterUnitWatch=function() watches=watches+1 end
local last
env.HealBot_Forever_PrepareArrivalAuraContext=function(reusePolicy)
    assert(reusePolicy,'a structural roster pass requested a full spell-policy rebuild')
    snapshots=snapshots+1; last={generation=snapshots}; return last
end
env.SkinExtras=function(row,donor,context,x,y)
    skins=skins+1
    assert(x==1 and y==2,'reserve did not share the donor center')
    assert(context==last and context.generation==snapshots,'roster rows did not share this pass snapshot')
end
local centerReads=0
local donor={unit='raid1',frame=1,status={active=true},IsShown=function() return true end,
    gref={Bar={GetCenter=function() centerReads=centerReads+1; return 1,2 end}}}
env.HealBot_Buttons={donor}
env.API.queue(); env.tick()
assert(snapshots==1 and skins==28 and bindings==28 and watches==28,'raid reserve pass counts')
env.API.queue(); env.tick()
assert(snapshots==2 and skins==56,'next event must get a fresh snapshot')
assert(centerReads==2,'donor center read again for individual reserve rows')
assert(bindings==28 and watches==28,'unchanged pass repeated secure binding/watch changes')
env.UnitExists=function() return true end
env.API.queue(); env.tick()
assert(snapshots==2 and skins==56,'full roster unnecessarily scanned aura config')
assert(centerReads==2,'full roster read donor geometry without a reserve')
env.UnitExists=function() return false end
env.combat=true; env.API.queue(); env.tick()
assert(snapshots==2 and skins==56,'combat must retain existing secure roster behavior')
env.combat=false; env.HealBot_Buttons={}; env.API.queue(); env.tick()
assert(snapshots==2,'no-donor pass unnecessarily scanned aura config')
env.HealBot_Buttons={donor}
env.HealBot_Globals.ForeverPartyJoin=false; env.API.queue(); env.tick()
assert(snapshots==2,'disabled reserve bars unnecessarily scanned aura config')
print('PASS: actual roster Sync shares one fresh snapshot across 28 reserves; full/no-donor/disabled/combat paths, bindings and watches preserved')
