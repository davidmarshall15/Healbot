# Forever compatibility regression tests

Run from the repository root with Lua 5.1:

```sh
lua tests/compatibility.lua
lua tests/forever_frames.lua
lua tests/opacity.lua
lua tests/tooltip.lua
lua tests/health_text.lua
lua tests/secret_values.lua
lua tests/prediction.lua
lua tests/target_binding.lua
lua tests/modified_target.lua
lua tests/rank_range.lua
lua tests/combat_auras.lua
lua tests/reported_bugs.lua
```

On Windows, the following also checks addon Lua syntax and TOC/XML references:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File ./Test-Forever.ps1
```

The compatibility suite exercises client/content selection for Forever and other
supported client families, spellbook return values and arguments, protected-value
forwarding, LibHealComm isolation, and player/aura refresh during level changes.
The frame suite exercises native incoming-heal rendering, horizontal/vertical and
reverse bars, opacity and unit changes, combat debuff filters, text layering and
frame lifecycle using mock APIs. Secret-value sentinels reject arithmetic and
inspection; they do not reproduce the client's security system.

The opacity and tooltip suites execute the corresponding real refresh functions
with mock client data. Tooltip cases cover protected current/max health and mana,
hidden health, readable health clamping, and legacy versus modern formatting.
The health-text suite covers the modern Include percent setting, independent
protected HP/percentage values, precision from the selected text frame, and
unchanged HP-only/percentage-only modes. Mock native formatting propagates
protected text while Lua arithmetic and inspection are rejected.
The mixed-value suite independently protects the health, healing, absorb and
overheal inputs to shield, prediction, emergency and adaptive-colour functions.
It checks both conservative fallbacks and readable-value behaviour, including
hidden smoothing targets and the native Forever prediction path.

The prediction suite loads the actual frame and auxiliary modules with opaque
values propagated by mock native calculators. It covers absorb clamping,
overflow, auxiliary totals, colour thresholds, live colour changes and cleanup.
Its texture setup uses Blizzard's actual address-mode helper from
`fixtures/forever_texture_util.lua`, which rejects invalid enum arguments.
It also checks incomplete overlays/calculators, failures during initialization,
continued incoming-heal rendering, and out-of-combat recovery without rebuilding
complete renderers or creating frames during combat.
The Target suite checks that SmartCast preserves explicit Target bindings on
normal and emergency buttons while still selecting spells for healing bindings.
The modified-Target suite uses a snapshot of Blizzard's Forever click handlers
in `fixtures/forever_secure_clicks.lua`. It reproduces rejection of Ctrl+Target
by SecureUnitButton_OnClick, then exercises the actual addon template selection
and attribute generation through SecureActionButton_OnClick. It covers normal
and emergency frames, modifiers, mouse buttons, both click edges, conflicting
global click bindings and the global key-down CVar. Engine calls are mocked;
this does not simulate client taint or perform an actual TargetUnit call.
The rank/range suite checks explicit buff ranks through saving, reloading,
secure attributes and macros, plus readable range events when polling is
unavailable and cache cleanup when unit buttons are reused. The combat-aura
suite checks skin anchors, offsets, spacing, double layouts, click-through
widgets, unit changes and deferred setup while combat is active. It also covers
disabled rows during unit changes, inactive buttons across combat transitions,
re-registering and retargeting existing rows in combat, and recovery after a
native retarget failure without showing auras for the previous unit.

## In-game verification still required

The reported-bug suite covers combat target/focus display changes, clearing and
reacquiring targets, secret names/health/power, health and power event dispatch,
incomplete aura scans, post-combat cache invalidation, native buff exclusions,
and SmartCast using the current recipient's level rather than a cached level.
The rank suite also checks Shield rank 6 on left, right and middle buttons.
Combat aura tests cover separate skin timer preferences, legacy-default migration,
explicit timer overrides and monitoring toggles.

Native countdowns now follow icon-set 1's buff/debuff timer settings by default.
The old `CombatAurasNums=false` default migrates to skin settings; an existing
true override is retained. Use `/hbca nums off` or `/hbca nums on` for an explicit
override, and `/hbca nums skin` to restore skin settings.

- Cast a timed heal on an injured unit with incoming-heal colour enabled; check
  the prediction while health changes, at full health and when the cast stops.
- Check horizontal, vertical and reverse-fill bars, range fading and skin changes.
- Apply a dispellable debuff in combat; check the bar tint with combat icons on
  and off, monitoring disabled, and the dispellable-only filter toggled.
- Check that names, health and status text remain visible above the tint.
- Check group changes, reused unit buttons and entering/leaving combat.
- Check level changes, talent changes, spell ranks, click casting and reloads.
- Apply a shield at partial and full health, with incoming heals enabled/disabled;
  check the absorb segment and the configured overflow indicator in combat.
- Assign incoming-heal/absorb auxiliary bars; check totals, scale, expiry and
  changing the auxiliary slot to another bar type with smoothing enabled.
- Check normal/injured/critical custom colours and future-health colours while
  casting, including enemy palettes, equal thresholds and settings changes.
- Bind Target to left-click with SmartCast enabled; check normal and emergency
  bars outside combat, then check that ordinary healing still uses SmartCast.
- Bind a lower-rank buff with SmartCast disabled, reload, and check both its
  displayed rank and the actual cast. Repeat with Target enabled on the binding.
- With nearby group members in combat, compare range fading with `/hbca range`;
  also check a genuinely distant player and a reassigned group slot.
- Enter/leave combat with icons at different corners, outside the bar, and in
  double rows. Change the skin outside combat and repeat. Combat icon size and
  maximum counts can be adjusted with `/hbca`; size follows the skin unless
  manually overridden. Also try only one enabled row and a reused group slot.
- Enable Include percent with Current health; verify both values update together
  in and out of combat, including the selected decimal precision.
- Verify other supported clients retain their existing behaviour.
- Switch between hostile/friendly, dead/alive targets and different power types
  during combat, clear the target, then acquire another. Check name, health and
  power immediately and on subsequent unit events. Repeat for focus and target
  of target. This refresh updates existing frames only: select the skin's
  always-reserve-target-in-combat option if a target must appear after entering
  combat without one. It does not create protected buttons during combat.
- Leave combat with a persistent debuff and without a new aura event; verify the
  normal icon engine repopulates. Check no false rebuff alert while aura reads
  are restricted, then verify genuinely missing buffs after a readable scan.
- Disable the XP buff globally and per instance, then enter combat; verify the
  native row honours its configured spell ID. Native filters still obey client
  restrictions; they do not restore arbitrary Lua filtering of protected auras.

The implementation renders native incoming-heal amounts without Lua arithmetic.
It does not restore numerical prediction text for secret values. Combat debuff
selection uses native filters and sorting, not custom Lua name/ID filtering of
secret auras. Custom debuff colours are captured when the native widgets are
created; reload after changing them. Native frame behaviour and taint must be
tested in the game. Classic spell presets are not a certification of Forever's
redesigned spells or talents.
