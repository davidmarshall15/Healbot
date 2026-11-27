# Forever target and native buff refresh work

Players reported brief frame-rate drops in 26.11.27 when selecting mobs, when
mobs die, and when HealBot updates its frames. Reports describe worse stalls in
groups and battlegrounds. This change removes two sources of redundant work
found while investigating those reports. It does not establish that either was
the sole cause of the stalls, or claim a measured in-game FPS improvement.

## Target events

Previously, `PLAYER_TARGET_CHANGED`, `PLAYER_FOCUS_CHANGED` and every
`UNIT_TARGET` event walked all active Forever bars. The target refresh helper
rejected ordinary party/raid bars only after entering the function. Target,
target-of-target and focus bars all refreshed even if only one dependency had
changed.

The module now indexes registered bars by their supported target token. The
registration, unregistration and existing unit-rebind reset hooks maintain those
indexes, including duplicate bars. Target changes visit target and
target-of-target bars; focus changes visit focus bars. A native
`RegisterUnitEvent("UNIT_TARGET", "target")` subscription visits only
target-of-target bars when the selected unit changes targets. Its payload is
not inspected, so aliases and opaque event values do not require Lua identity
checks. Target refreshes still stop outside combat.

In the focused fixture, 204 unrelated party/raid bars and two bars for each of
the three supported tokens produce these counts:

| Event | Previously visited bars | Now visited bars |
| --- | ---: | ---: |
| Player target changes | 210 | 4 |
| Player focus changes | 210 | 2 |
| Selected unit changes targets | 210 | 2 |
| Unrelated unit changes targets | 210 | 0; native subscription rejects it |

These are deterministic mock traversal counts, not timings from WoW.

## Native buff policies

An unchanged skin reset previously reapplied filters and icon limits to both
caster groups in every prepared buff row: four candidate-filter writes and two
count writes per row. With three rows this meant 18 native setter calls for an
unchanged button.

Each row now records its last successfully applied addon-owned filter object,
normalized duration cap and icon limit. Creation seeds that record; an unchanged
update skips the native setters. Configured filter objects retain identity only
while their complete configuration signature matches. Caster, ID/name, zone,
exclusion and icon-set changes therefore still reach the native groups.

Before a changed policy is applied, its old success record is cleared. A partial
failure hides the unconfirmed row and leaves it eligible for retry, including
when settings are reverted or only duration changed. Arrival rows use the same
guard. Visibility and unit retargeting still run independently of policy reuse.

For 40 mock buttons with buff-set limits 4/2/2, 20 unchanged resets per button
previously made 9,600 filter writes and 4,800 count writes. The new code makes
zero of either and allocates no replacement frames in that workload. The test
also covers the first reset after creation, combat updates and failed retries.

Prepared rows and both caster groups remain available for changing Custom
Buffs during combat. Self/Everyone selection, shared icon budgets, Monitor
buffs and Also in combat retain their existing behavior. Public configuration
and spell-cache scanning still occurs when preparing a policy; this change
does not add a global configuration cache or remove the prepared groups.

## Validation and in-game follow-up

`tests/target_event_refresh.lua` and `tests/native_buff_refresh.lua` execute the
production modules with mocked APIs. The Windows runner includes both suites.
Their assertions reject protected frame changes and native aura inspection,
and cover index cleanup, native event routing, settings changes, combat gates,
empty rows, reserved arrivals, retargeting and partial setter failures.

An in-game comparison should use the same character, skin, enabled addons and
native aura options on 26.11.27 and this branch:

1. Outside combat and during combat, repeatedly select, clear and switch mobs;
   repeat while killing a small pack. Compare frame-time spikes, not just the
   displayed average FPS.
2. Repeat solo, in a party and in a raid or battleground. Check target,
   target-of-target and focus text, health and power. Include selecting a party
   member, raid member or boss while that unit changes targets.
3. Show duplicate target bars, change their units and hide them. Check that the
   current bars update and former target bars stop receiving target refreshes.
4. Change a Custom Buff between Self and Everyone, disable/re-enable it, and
   change zone or icon-set limits. Repeat a supported policy change in combat
   with Also in combat enabled, then disabled. Check prepared arrival bars when
   joining a group in combat.
5. Check that native helpful icons hand back to the legacy renderer outside
   combat and that no new protected-action or Lua errors appear.

No live frame-time measurements accompany this change. If stalls remain,
profile the other refresh and setup paths rather than treating these mock
operation counts as proof of an FPS fix.
