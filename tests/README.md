# Forever compatibility regression tests

Run from the repository root with Lua 5.1:

```sh
lua tests/compatibility.lua
lua tests/forever_frames.lua
lua tests/opacity.lua
lua tests/tooltip.lua
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

## In-game verification still required

- Cast a timed heal on an injured unit with incoming-heal colour enabled; check
  the prediction while health changes, at full health and when the cast stops.
- Check horizontal, vertical and reverse-fill bars, range fading and skin changes.
- Apply a dispellable debuff in combat; check the bar tint with combat icons on
  and off, monitoring disabled, and the dispellable-only filter toggled.
- Check that names, health and status text remain visible above the tint.
- Check group changes, reused unit buttons and entering/leaving combat.
- Check level changes, talent changes, spell ranks, click casting and reloads.
- Verify other supported clients retain their existing behaviour.

The implementation renders native incoming-heal amounts without Lua arithmetic.
It does not restore numerical prediction text for secret values. Combat debuff
selection uses native filters and sorting, not custom Lua name/ID filtering of
secret auras. Custom debuff colours are captured when the native widgets are
created; reload after changing them. Native frame behaviour and taint must be
tested in the game. Classic spell presets are not a certification of Forever's
redesigned spells or talents.
