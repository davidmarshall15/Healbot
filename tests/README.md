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
lua tests/unranked_spells.lua
lua tests/spell_refresh.lua
lua tests/combat_auras.lua
lua tests/forever_buffs.lua
lua tests/native_buff_matching.lua
lua tests/native_buff_casters.lua
lua tests/movement_safety.lua
lua tests/party_startup.lua
lua tests/native_aura_options.lua
lua tests/reported_bugs.lua
lua tests/player_mana.lua
lua tests/adaptive_reset.lua
lua tests/clear_aux_bars.lua
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
inspection. The prediction suite also models the untainted-only rule for
`SetPredictedValues`, rejecting secret arguments passed from addon code. The
mocks still do not reproduce the client's full security system.

The opacity and tooltip suites execute the corresponding real refresh functions
with mock client data. Tooltip cases cover protected current/max health and mana,
hidden health, readable health clamping, and legacy versus modern formatting.
The health-text suite covers the modern Include percent setting, independent
protected HP/percentage values, precision from the selected text frame, and
unchanged HP-only/percentage-only modes. Mock native formatting propagates
protected text while Lua arithmetic and inspection are rejected.
It also covers native current/deficit abbreviations at all selectable precisions,
automatic precision, small values, narrow bars, lowercase suffixes, localized
output propagation and safe fallback when the native abbreviation API is absent.
The locale mock verifies forwarding, not the client's actual German typography.

The Forever buff suite loads the native aura module with Forever enabled from
startup, so its settings hooks run. It covers configured Renew ranks and icon-set
routing, skin limits (including zero), per-set duration/count styling, long-buff
filtering, non-priest broad-mode exclusions and the shared settings setter.
Native helpful icons stay hidden outside combat while the legacy renderer owns
the display; existing groups are reused for custom filter changes during combat.
Structural skin/size/duration UI changes still defer protected setup until combat
ends.

The native buff matching suite executes the actual configuration helpers with
public settings/caches. It covers Self/Everyone scopes, ID-only versus name/rank
matching, independent rank exclusions, all nine classes, manual ALL/zone rules,
icon-set routing, public spell-cache candidates and deterministic signatures.
The native caster suite loads the whole module with mock native widgets. It
checks disjoint Self/Everyone groups, no duplicate own casts, shared odd/even icon
limits, immediate custom enable/disable and caster changes in combat, the Also in
combat gate, prepared empty rows, reserved arrival icon sets, zero skin limits,
all-class behavior and matching icon/countdown/count styling. It rejects native
aura-frame inspection, new frames/groups and container enabling during combat.
Mixed caster groups reserve half the existing limit for Everyone (rounded up)
and the rest for Self; unused reserved slots cannot be borrowed. At a limit of
one, Everyone gets the single slot. My Class keeps conservative player-only
native behavior because no exact native source-class selector is exposed.

The frame suite also guards outside-combat debuff tint updates after a handoff:
monitoring, coloring, selected dispel mode, opacity, death, range and special-unit
changes must be applied without waiting for another aura event. The combat-aura
suite retains native/legacy takeover tests for explicit persistent mode on other
supported clients; it does not impose an obsolete always-native Forever icon
policy. Hidden rows retarget before their next visible display.

The movement safety suite runs protected frame drag/stop paths through combat
transitions and prevents geometry changes until the deferred stop succeeds. The
party startup suite checks delayed media/core readiness, missing settings, late
startup events, load coalescing and combat deferral using the real media helpers.

The native-aura options suite executes the actual UI callbacks, XML tab click and
panel router with mock widgets, using the real shared settings setter. It checks
UI/slash synchronization, reopening, timer modes, validation, language changes,
dependent controls, unsupported clients and global versus per-frame navigation.
The buff suite also verifies that the UI setter defers row creation in combat.
Native WoW widget layout still requires an in-game visual check.
The mixed-value suite independently protects the health, healing, absorb and
overheal inputs to shield, prediction, emergency and adaptive-colour functions.
It checks both conservative fallbacks and readable-value behaviour, including
hidden smoothing targets and the native Forever prediction path.

The prediction suite loads the actual frame and auxiliary modules with opaque
values propagated by mock native calculators. It covers absorb clamping,
overflow, auxiliary totals, colour thresholds, live colour changes and cleanup.
The native shield bar always stays cerulean; the predicted-health colour for
absorbs only feeds the auxiliary absorb bar and legacy colour consumers.
Its texture setup uses Blizzard's actual address-mode helper from
`fixtures/forever_texture_util.lua`, which rejects invalid enum arguments.
It also checks incomplete overlays, failures during initialization,
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
unavailable and cache cleanup when unit buttons are reused. The unranked-spell
suite checks that a spell typed without a rank ("Flash Heal") casts the highest
known rank, follows a newly learned rank without a rebind, and stays unranked
in the options spell boxes across their save-on-change round trip, while an
explicit rank, rankless spells, NoRanks and modern clients are unchanged. The combat-aura
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
- Type a ranked heal without its rank (e.g. Flash Heal); check the spell box
  keeps the plain name after reopening the options and that the highest rank is
  cast. Learn a new rank and check it is used without rebinding.
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
- Configure Renew or Rejuvenation as Everyone and have a second healer cast it;
  verify it appears in combat. Switch back to Self and verify only your casts
  remain. Repeat for another class and a reserved arrival row.
- Enable/disable a custom buff during combat with Also in combat checked; verify
  the existing icons update immediately without unrelated buffs or timer clusters.
  Repeat with the option off and check the change after leaving combat.
- Configure two ranks as ID only; disable one and verify the other remains
  visible. Check name matching still includes the selected spell family.
- Toggle debuff bar coloring, monitoring and dispellable-only mode outside combat;
  check the tint changes immediately while names and health text stay on top.
- Attempt a HealBot drag in combat, then end combat before releasing it; verify
  the frame does not remain stuck to the mouse and can be moved afterward.
- Reload with party/arrival bars enabled; verify there is no nil media error while
  the skin and media libraries initialize.
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
