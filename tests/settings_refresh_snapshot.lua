-- Roster-wide existing-button settings hooks should do one public policy scan.
local f=assert(io.open('tests/native_buff_casters.lua','rb'))
local fixture=f:read('*a'):gsub('\r\n','\n'):match('^(.-)\nlocal function admits%('); f:close()
if arg[1] then fixture=fixture:gsub('local source=read%("HealBot/HealBot_CombatAuras.lua"%)','local source=read(arg[1])') end
local d=assert(loadstring(fixture..'\nreturn fixture'))()('PRIEST',4,function(env)
    env.HealBot_Forever_WatchesWeakenedSoul=function() return false end
    local create=env.CreateFrame
    env.CreateFrame=function(...)
        local row=create(...)
        -- This suite includes the "refresh custom debuffs" hook, which
        -- requests a prepared native slot. The caster fixture only builds groups.
        function row:AddAuraSlot(key,filter,options) self.slot={key,filter,options} end
        return row
    end
end)
local scans=0
local calls=0
local originalLookup=d.env.HealBot_WoWAPI_SpellName
d.env.HealBot_WoWAPI_SpellName=function(...) calls=calls+1; return originalLookup(...) end
d.env.HealBot_Forever_VisitAuraPerfScopes(function(name,original)
    if name=='Aura.ConfiguredBuffFilters' then return function(...) scans=scans+1; return original(...) end end
    return original
end)
local buttons={}
for i=1,40 do buttons[i]=d.button('raid'..i) end
local function expect(n,hook,...)
    scans,calls=0,0
    d.hook(hook,...)
    assert(scans==n,hook..' compiled '..scans..' times; expected '..n)
    assert((n==0)==(calls==0),hook..' actual spell lookups: '..calls)
end
expect(1,'hbv_Skins_SetIconVar',4,'MAXBICONS',1,1)
expect(1,'hbv_Skins_SetIconTextVar',12,'BUFFHEIGHT',1,1)
expect(0,'hbv_Skins_SetIconTextVar',12,'BUFFHEIGHT',8,1)
expect(0,'HealBot_Options_Debuff_Reset')
d.env.HealBot_Forever_GetDebuffTypes=function() return {Magic=true,Curse=true},'Magic,Curse' end
expect(1,'HealBot_Options_Debuff_Reset')
expect(0,'HealBot_Options_Debuff_Reset')
d.globals.CombatAurasNativeWeakenedSoul=true
expect(1,'HealBot_Aura_ConfigDebuffs')
local count=#d.frames
-- A fresh callback must see the new caster rule and all forty bars must adopt it.
d.globals.WatchHoT.PRIE[139]=3
expect(1,'hbv_Skins_SetIconVar',4,'MAXBICONS',1,1)
for _,b in ipairs(buttons) do assert(d.row(b).groups.hbcahotEveryone.options.candidateFilters.includeSpellIDs[139]) end
assert(#d.frames==count,'unchanged structural layouts were rebuilt')
d.combat(true)
expect(0,'hbv_Skins_SetIconVar',4,'MAXBICONS',1,1)
expect(0,'HealBot_Aura_ConfigDebuffs')
d.env.HealBot_Forever_GetDebuffTypes=function() return {Magic=true},'Magic' end
expect(0,'HealBot_Options_Debuff_Reset')
assert(#d.frames==count,'combat hook allocated a container')
d.combat(false)
d.globals.CombatAurasOn=false
expect(0,'HealBot_Aura_ConfigDebuffs')
for i=1,40 do buttons[i].status.events=false end
d.globals.CombatAurasOn=true
expect(0,'hbv_Skins_SetIconTextVar',12,'BUFFHEIGHT',1,1)
print('PASS: four settings sweeps compile policy once for 40 active bars; no scans or structural work for ineligible sweeps; caster edits reach every bar')
