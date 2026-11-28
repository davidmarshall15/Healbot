-- The production renderer owns a public row only for the precise compiled
-- policy under which the unit's complete scan finished.
local f=assert(io.open('tests/public_buff_handoff.lua','rb'))
local source=f:read('*a'):gsub('\r\n','\n'); f:close()
local setup=assert(source:match('^(.-)\nassert%(row%.shown,'))
assert(loadstring(setup..[[

d.combat(true); scan({aura(139,'Renew',330)},true,true)
local oldPolicy=b.aura.buff.publicPolicy
d.globals.WatchHoT.PRIE[139]=3; d.hook('HealBot_Aura_ConfigClassHoT')
assert(row.shown and not b.gref.icon[1].shown,'stale public scan hid the edited native row')
assert(b.aura.buff.publicPolicy==oldPolicy,'old scan incorrectly rebound to new policy')
scan({aura(139,'Renew',330)},true,true)
assert(b.aura.buff.publicPolicy~=oldPolicy,'new complete scan retained obsolete policy')
d.globals.WatchHoT.PRIE[139]=1; d.hook('HealBot_Aura_ConfigClassHoT')
assert(row.shown,'second edit did not invalidate public ownership')
scan({sealed},false,true)
scan({aura(139,'Renew',340)},true,true)
assert(#d.frames==frameCount,'caster-policy changes allocated native frames in combat')
]]))()
print('PASS: in-combat caster edits invalidate public ownership immediately; incomplete scans keep native rows visible and complete rescans restore the new policy')
