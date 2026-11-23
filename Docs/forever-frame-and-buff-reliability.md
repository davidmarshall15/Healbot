# Forever frame movement, startup and native buffs

These changes use HealBot's existing settings. They add no hide-self-buffs
checkbox or default buff-hiding policy.

## Movement and startup

Protected frame movement is refused while the client is in combat lockdown.
If combat starts after a drag begins, the stop and sticky-frame anchor work is
queued until `PLAYER_REGEN_ENABLED`. A failed start does not record a moving
frame. This covers header drags and the shared movement helpers.

Reserved party-arrival bars wait for core `Loaded`, registered media and the
current skin's HealGroups data before creating or styling rows. Incomplete
startup keeps one half-second retry queued. Combat pauses that attempt; the
existing regeneration event resumes it. Incoming-heal prediction is retained.

## Custom Buff caster and matching rules

On Forever, ordinary bars still use the legacy renderer outside combat and
native containers in combat. Both native groups live in the same container:

- `hbcahot` uses `HELPFUL|PLAYER` for Self selections.
- `hbcahotEveryone` uses `HELPFUL` for Everyone selections, including own casts.

Their spell lists are disjoint, so an own cast of an Everyone spell appears
only once. Everyone icons use the same skin styling without a fixed Self
marker. The existing Monitor buffs and Also in combat controls still govern
visibility and combat updates.

My Class retains the existing player-only native behavior: the public native
filter interface has no exact source-class selector. Legacy outside-combat
class filtering is unchanged. This change does not substitute Everyone for it.

ID-only registrations match only that ID. Disabling one ID-only rank does not
disable a separately enabled rank. Name-mode registrations expand through
public spellbook/cache names and the known spell-family mappings, while manual
ALL/zone exclusions and icon-set routes remain authoritative. Caster scope is
part of the policy signature, so changing Self/Everyone invalidates the policy
even when its spell IDs remain the same.

## Native limits and combat updates

Groups and rows with positive configured skin limits are prepared outside
combat. Custom-buff, exclusion and caster changes update candidate filters and
limits on those prepared groups; they do not allocate frames, inspect native
aura identities or rebuild the containers during combat. Reserved arrival rows
use the same policy. Structural size/skin changes still wait until combat ends.

Blizzard limits groups independently, so mixed caster groups reserve portions
of the existing row limit: Everyone gets half rounded up, and Self gets the
remainder. A single populated scope uses the whole limit. Unused reserved slots
cannot be borrowed; at a one-icon limit, Everyone receives the slot. This keeps
the combined count bounded without reading protected aura/frame counts.

The non-priest broad-buff mode remains available through its existing setting.
Explicit Everyone spells and spells routed elsewhere are excluded from its Self
group to avoid duplicates. No new polling loop or saved preference is added.

## Debuff tint handoff

The native tint may persist while the legacy debuff pass catches up after
combat, but that handoff must not skip live monitoring, range, coloring or
opacity checks. Those settings are re-evaluated on every normal overlay refresh;
an unchanged visible overlay does not request a redundant aura refresh.

The v3 Weakened Soul slot, prediction behavior and subsequent unranked spell
binding changes are retained. The older broad harmful-aura workaround is not
reintroduced.

## Verification

The regression suites use actual addon functions with Lua 5.1 and mocked client
APIs. Run `Test-Forever.ps1` with Lua 5.1 on PATH, or use the individual commands
in [tests/README.md](../tests/README.md).

Before release, test in the client without another addon rewriting HealBot's
native buff filters:

1. Try an unlocked header drag in combat, and start a drag before combat then
   release it after combat begins. Check movement and sticky anchors afterward.
2. Reload with reserved party-arrival bars enabled and check media/skin startup.
3. Have another healer apply a Custom Buff set to Everyone. Enter combat, switch
   it to Self, and switch back. Check ordinary bars and reserved arrival rows.
4. Enable/disable a custom buff and change its exclusions during combat with
   Also in combat enabled. Check existing icons update before another aura event.
5. Register two ranks as ID only, disable one and check the other. Repeat with
   name-mode tracking and with multiple icon sets and skin limits.
6. Check single and mixed caster groups, timer/count fonts and small icon limits.
   Check a party/raid layout for frame creation cost and rendering behavior.
7. Leave combat with a debuff tint, then disable monitoring or coloring and
   change range/opacity. Check the tint responds without waiting for a new aura.

Offline tests do not reproduce WoW's full security system, server aura secrecy
or rendering. A live second-healer test remains necessary before declaring the
new native Everyone behavior accepted in game.
