# Screenshot review (2026-11-15)

Branch: `fix/forever-reported-bugs`. Review of all twelve supplied screenshots.

| Report | Finding / status |
| --- | --- |
| Power Word: Shield rank 6, middle click | Added regression for explicit rank 6 on left/right/middle buttons, through saving, reload and secure spell attributes. No further defect reproduced in these paths; actual casting needs client confirmation. |
| Incoming heals absent | Native prediction renderer already exists. The colour exception below can interrupt its refresh. In-game verification remains necessary. |
| Icon position and target stale, with prediction traceback | Existing layout fixes retained. Prediction exception and target display refresh addressed by this branch. |
| Debuffs disappear after combat; disabled XP buff visible | Invalidate aura caches and schedule both scans after HealBot clears its combat lock. Pass configured global/instance buff exclusions to native widgets; rebuild when exclusion settings or map change. Respect monitoring toggles. |
| Target window absent/stale | Added display-only refresh of existing target/targettarget/focus buttons on target events and health/power events, including clearing/reacquiring a target and changed power type. No protected attributes or GUID tables are rebuilt. A frame not reserved before combat cannot be created during combat: use the existing always-reserve setting. |
| Delta health and modified Target | Delta now uses `UnitHealthMissing` when available; native protected zero displays as -0. Modified Target already covered by existing secure-action template fix and tests. |
| Fortitude chooses lower rank for warrior | SmartCast now queries the actual recipient level instead of using a reused button's cached level. Regression reproduces an erroneous rank 2 selection for a level 60 recipient cached as level 14. Client confirmation still needed for the specific report. |
| Alt+left Target | Existing modified Target regression suite passes. Needs confirmation in client. |
| SetPredictedValues spam | Fixed: never pass protected health fields to this setter. Native amounts still render; protected prediction colours use normal custom/current-health colours. Readable values retain predicted-colour calculations. |
| Target does not update in combat | Same target refresh correction above; mocks reject protected frame changes and secret-value inspection. |
| Rebuff flash at combat transitions | Missing-buff warnings are suppressed while aura reads are restricted or incomplete, rather than treating unreadable buffs as absent. Complete post-combat scans restore normal warnings. |
| Countdown text disappears in combat | Native numbers now follow each skin's buff/debuff icon-set 1 timer setting. Old false default migrates to skin settings; explicit true is preserved. `/hbca nums skin`, `on`, `off` select the desired behaviour. |

## Verification

`Test-Forever.ps1`: all 12 suites pass (1,218 assertions), 70 Lua files parse, 128 TOC/XML references exist. `git diff --check` passes.
Prediction mocks now reject secret fields passed to `SetPredictedValues`, matching the reported failure instead of accepting an invalid addon call.
Delta tests cover protected missing health, optional percentage, and zero.
No WoW client or taint validation was available. Passing mocks do not certify actual casting or native rendering in game. Target refresh uses a plain current name during combat, while the ordinary out-of-combat path retains full name formatting. Native aura filters remain subject to the client's identity-filter restrictions.

Native exclusion support was checked against Blizzard's exported [AuraContainerUtil source](https://github.com/Gethe/wow-ui-source/blob/live/Interface/AddOns/Blizzard_AuraContainer/Blizzard_AuraContainerUtil.lua), including `excludeSpellIDs` and the restrictions on friendly harmful auras. No protected aura identities are inspected by the addon.

## Publication

Local branch created. Personal repository and PR are not created yet. The available GitHub connector identifies Cappe93 but has no repository creation/fork tool; GitHub CLI is not on PATH. Upstream origin is unchanged.
