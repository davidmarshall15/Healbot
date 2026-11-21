# Screenshot review (2026-11-15)

Branch: `fix/forever-reported-bugs`. Review of all twelve supplied screenshots.

| Report | Finding / status |
| --- | --- |
| Power Word: Shield rank 6, middle click | Added regression for explicit rank 6 on left/right/middle buttons, through saving, reload and secure spell attributes. No further defect reproduced in these paths; actual casting needs client confirmation. |
| Incoming heals absent | Native prediction renderer already exists. The colour exception below can interrupt its refresh. In-game verification remains necessary. |
| Icon position and target stale, with prediction traceback | Existing layout fixes retained. Prediction exception and target display refresh addressed by this branch. |
| Debuffs disappear after combat; disabled XP buff visible | Post-combat rescanning alone was insufficient: native rows and tints were hidden unconditionally, while the legacy filter could exclude remaining DoTs. Forever now retains native debuffs and configured tints outside combat; see follow-up below. Pass configured global/instance buff exclusions to native widgets; rebuild when exclusion settings or map change. Respect monitoring toggles. |
| Target window absent/stale | Added display-only refresh of existing target/targettarget/focus buttons on target events and health/power events, including clearing/reacquiring a target and changed power type. No protected attributes or GUID tables are rebuilt. A frame not reserved before combat cannot be created during combat: use the existing always-reserve setting. |
| Delta health and modified Target | Delta now uses `UnitHealthMissing` when available; native protected zero displays as -0. Modified Target already covered by existing secure-action template fix and tests. |
| Fortitude chooses lower rank for warrior | SmartCast now queries the actual recipient level instead of using a reused button's cached level. Regression reproduces an erroneous rank 2 selection for a level 60 recipient cached as level 14. Client confirmation still needed for the specific report. |
| Alt+left Target | Existing modified Target regression suite passes. Needs confirmation in client. |
| SetPredictedValues spam | Fixed: never pass protected health fields to this setter. Native amounts still render; protected prediction colours use normal custom/current-health colours. Readable values retain predicted-colour calculations. |
| Target does not update in combat | Same target refresh correction above; mocks reject protected frame changes and secret-value inspection. |
| Rebuff flash at combat transitions | Missing-buff warnings are suppressed while aura reads are restricted or incomplete, rather than treating unreadable buffs as absent. Complete post-combat scans restore normal warnings. |
| Countdown text disappears in combat | Native numbers now follow each skin's buff/debuff icon-set 1 timer setting. Old false default migrates to skin settings; explicit true is preserved. `/hbca nums skin`, `on`, `off` select the desired behaviour. |

## Verification

`Test-Forever.ps1`: all 12 suites pass (1,268 assertions), 71 Lua files parse, 129 TOC/XML references exist. `git diff --check` passes.
Prediction mocks now reject secret fields passed to `SetPredictedValues`, matching the reported failure instead of accepting an invalid addon call.
Delta tests cover protected missing health, optional percentage, and zero.
No WoW client or taint validation was available. Passing mocks do not certify actual casting or native rendering in game. Target refresh uses a plain current name during combat, while the ordinary out-of-combat path retains full name formatting. Native aura filters remain subject to the client's identity-filter restrictions.

Native exclusion support was checked against Blizzard's exported [AuraContainerUtil source](https://github.com/Gethe/wow-ui-source/blob/live/Interface/AddOns/Blizzard_AuraContainer/Blizzard_AuraContainerUtil.lua), including `excludeSpellIDs` and the restrictions on friendly harmful auras. No protected aura identities are inspected by the addon.

## Follow-up: remaining DoTs after combat (2026-11-16)

The native icon row and debuff tint previously required combat. On exit, icons switched to HealBot's legacy dispel/custom filters, so a successful rescan could still omit a remaining harmful aura. Forever now keeps the same native harmful-aura row and configured tint active until the client removes the aura. No protected aura identity or expiration value is read by the addon.

`CombatAurasPersistDebuffs` defaults to true on Forever; `/hbca persist off` restores the previous out-of-combat behavior. Monitoring switches, tint settings and icon limits remain effective. Only legacy icon-set 1 is suppressed while a working native row owns it; cure processing and custom icon sets 2/3 remain. Disabling the row or a failed native setup returns ownership to the ordinary renderer and queues a rescan without waiting for `UNIT_AURA`.

Added regression checks for combat exit without an aura event, initial out-of-combat display, old countdown callbacks, duplicate icons/glows, legacy redraw, monitoring switches, unit reuse, failed retarget/setup and deferred creation. Native expiration/removal rendering still needs verification in the WoW client; the tests exercise mocked widgets and the real legacy rendering functions.

## Publication

Changes are prepared on `fix/forever-reported-bugs` for review against upstream `master`. In-game checks listed above remain necessary; automated tests use mocked client APIs.

## Follow-up: November 16–20 reports after merging 26.11.20

| Report | Finding / action |
| --- | --- |
| Health format ignored; Delta always 100% | Native `UnitHealthMissing(unit, false)` was already present in this branch. Current and missing health still bypassed the selected number format. Both now use native abbreviation with public precision settings; Include percent, surrounding characters and the minus sign remain. Protected zero still displays -0. |
| `SetPredictedValues` exceptions (two screenshots) | Master now uses `UnitHealthPercent` for prediction colours; the prediction module no longer calls `SetPredictedValues`. The existing regression rejects addon calls with protected fields and passes. No additional prediction change needed here. |
| Renew absent | The current native priest filter includes all listed Renew ranks and routes rank variants to the selected icon set. New tests cover this and visibility outside combat. No missing-Renew defect reproduced by these mocks; aura selection and actual spell IDs still need client confirmation. |
| Buff icons/text clutter; settings ineffective | Confirmed: the first native row ignored skin Max icons, including zero. It now obeys that limit within the slash-command cap and rebuilds/defer-rebuilds on changes. Duration/count settings are tested independently. The redundant Weakened Soul row is omitted when the persistent harmful row already includes it. |
| Long/world/profession buffs appear | Master deliberately changed the default duration cap to zero. `/hbca maxdur 120` restores a finite filter and excludes permanent buffs. Priest rows additionally use the existing priest whitelist; other classes retain their own buffs. Fixed stale exclusion filters for non-priest classes when configuration or zone exclusions change. |
| Target on left-click prevents SmartCast buffs | This branch explicitly preserves Target instead of letting SmartCast replace it; existing normal/emergency/modified Target tests pass. Kept that behaviour. Workaround: use a healing-spell binding for unmodified left-click and Target on another button/modifier. |

Native abbreviation support and its secret-value contract were checked against
[Forever Localization API](https://github.com/Gethe/wow-ui-source/blob/forever/Interface/AddOns/Blizzard_APIDocumentationGenerated/LocalizationDocumentation.lua)
and the [breakpoint schema](https://github.com/Gethe/wow-ui-source/blob/forever/Interface/AddOns/Blizzard_APIDocumentationGenerated/LocalizationSharedDocumentation.lua).
Only public format settings determine the breakpoints; health values and native
formatted output are forwarded without Lua arithmetic, comparisons or parsing.
The mock abbreviation sink does not certify native rounding/localization or taint.
Verify health/Delta formats in the German client, Renew in/out of combat, and
buff duration/count/limit changes in game before treating the reports as closed.
