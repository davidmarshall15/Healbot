-- Exercise independent bar hooks outside the bulk roster preparation path.
local file=assert(io.open("tests/native_buff_casters.lua","rb"))
local source=file:read("*a"):gsub("\r\n","\n"); file:close()
local prefix=assert(source:match("^(.-)\nlocal d=fixture%("))
local fixture,copies=assert(loadstring(prefix.."\nreturn fixture,copies"))()
local marker,rank=990301,990302
local scans,callbacks=0,{}
local d=fixture("DRUID",4,function(env)
    env.HealBot_Spell_IDs[marker]={}
    local lookup=env.HealBot_WoWAPI_SpellName
    env.HealBot_WoWAPI_SpellName=function(id)
        if id==marker then scans=scans+1 end
        return lookup(id)
    end
    env.HealBot_Init_Spells_Defaults=function() end
    env.C_Timer={After=function(_,fn) callbacks[#callbacks+1]=fn end}
end)
for _=1,8 do d.hook("HealBot_Aura_SetAuraCheckFlags") end
assert(scans==0,"compiled without regular or reserve native rows")
local bars={}
for i=1,40 do bars[i]=d.button("raid"..i) end
assert(scans==1,"independent bar creation repeatedly compiled a global policy")
for _,bar in ipairs(bars) do
    d.hook("HealBot_Action_RegisterUnitEvents",bar)
    d.hook("HealBot_Skins_ResetSkin","bar",bar)
end
d.combat(true); d.hook("HealBot_Aura_SetAuraCheckFlags"); d.combat(false)
assert(scans==1,"warm retries, resets or combat flags recompiled unchanged rules")
local last=d.row(bars[40])
d.globals.WatchHoT.UNKNOWN=7
d.hook("HealBot_Aura_SetAuraCheckFlags")
d.globals.WatchHoT.UNKNOWN={[19740]=3}
d.hook("HealBot_Aura_SetAuraCheckFlags")
assert(copies(last,19740,"party2")==1,"a new settings table replaced a stale scalar")
d.globals.WatchHoT.UNKNOWN=7
d.hook("HealBot_Aura_SetAuraCheckFlags")
assert(copies(last,19740,"party2")==0,"a stale settings table survived replacement by a scalar")
local initial=scans
d.globals.WatchHoT.PRIE[139]=3
d.hook("HealBot_Aura_SetAuraCheckFlags")
assert(scans==initial+1 and copies(last,139,"party2")==1,"in-place watch edit did not reach all bars")
d.names[rank]="Renew"
d.env.HealBot_Spell_IDs[rank]={}
d.hook("HealBot_Init_Spells_Defaults")
assert(scans==initial+2 and copies(last,rank,"party2")==1,"in-place spellbook update did not reach active bars")
d.names[rank]=nil
d.hook("HealBot_Init_Spells_Defaults")
assert(copies(last,rank,"party2")==0,"unresolved spell name did not clear its old policy")
local eventFrame
for _,frame in ipairs(d.frames) do
    if frame.onEvent then eventFrame=frame;break end
end
d.names[rank]="Renew"
eventFrame.onEvent(eventFrame,"SPELL_DATA_LOAD_RESULT",rank,true)
eventFrame.onEvent(eventFrame,"SPELL_DATA_LOAD_RESULT",rank,true)
assert(#callbacks==1,"a newly available spell name should schedule one refresh")
table.remove(callbacks,1)()
assert(copies(last,rank,"party2")==1,"the loaded spell did not recover its policy")
d.env.HealBot_Spell_IDs[rank]=nil
d.hook("HealBot_Init_Spells_Defaults")
assert(copies(last,rank,"party2")==0,"removed spellbook entry stayed in the policy")
local before=scans
d.env.HealBot_CombatAuras_SetOption("enabled",false)
for _=1,12 do d.hook("HealBot_Aura_SetAuraCheckFlags") end
d.hook("HealBot_Init_Spells_Defaults")
assert(scans==before,"disabled native renderer rebuilt its policy")
d.globals.WatchHoT.PRIE[139]=1;d.env.HealBot_CombatAuras_SetOption("enabled",true)
d.combat(true)
assert(scans==before+1 and copies(d.row(bars[40]),139,"party2")==0,"re-enable missed a saved caster edit")
-- An unlearned rank from the real catalogue may receive its public spell
-- metadata after the first pass. Metadata for a non-candidate cannot add it.
local catalog=fixture("MAGE",4,function(env)
    env.C_Timer={After=function(_,fn) callbacks[#callbacks+1]=fn end}
    setfenv(assert(loadfile("HealBot/HealBot_ForeverSpellNames.lua")),env)()
end)
catalog.names[6117]="Mage Armor";catalog.globals.WatchHoT.ALL[6117]=3
local armor=catalog.row(catalog.button("party1"))
local events
for _,frame in ipairs(catalog.frames) do if frame.onEvent then events=frame; break end end
catalog.names[990304]="Mage Armor"
events.onEvent(events,"SPELL_DATA_LOAD_RESULT",990304,true)
assert(#callbacks==0 and copies(armor,990304,"party2")==0,"unobserved non-candidate metadata queued a refresh")
assert(copies(armor,22783,"party2")==0)
catalog.names[22783]="Mage Armor"
events.onEvent(events,"SPELL_DATA_LOAD_RESULT",22783,false)
assert(#callbacks==0,"failed metadata load queued a refresh")
events.onEvent(events,"SPELL_DATA_LOAD_RESULT",22783,true)
assert(#callbacks==1); table.remove(callbacks,1)()
assert(copies(armor,22783,"party2")==1,"late catalogue rank did not update its row")
events.onEvent(events,"SPELL_DATA_LOAD_RESULT",22783,true)
assert(#callbacks==0,"resolved catalogue rank recompiled repeatedly")
print("PASS: independent native bar and flag policy reuse, live option changes, spellbook and late spell data invalidation")
