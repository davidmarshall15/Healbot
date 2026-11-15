# Screenshot review (2026-11-15)

Branch: `fix/forever-reported-bugs`. Review of all twelve supplied screenshots.

| Report | Finding / status |
| --- | --- |
| Power Word: Shield rank 6, middle click | Existing rank and modified-click tests pass; exact spell/button combination still needs reproduction in game. |
| Incoming heals absent | Native prediction renderer already exists. The colour exception below can interrupt its refresh. In-game verification remains necessary. |
| Icon position and target stale, with prediction traceback | Layout fixes already present; prediction exception fixed here. Target freshness remains open. |
| Debuffs disappear after combat; disabled XP buff visible | Open: native combat filtering differs from custom out-of-combat filtering. |
| Target window absent/stale | Open: combat path in `HealBot_UnitExists` skips GUID refresh. A safe display-only update needs reproduction and testing without changing protected frame attributes. |
| Delta health and modified Target | Delta now uses `UnitHealthMissing` when available; native protected zero displays as -0. Modified Target already covered by existing secure-action template fix and tests. |
| Fortitude chooses lower rank for warrior | Existing explicit-rank tests pass; automatic rank selection on this recipient is not reproduced. |
| Alt+left Target | Existing modified Target regression suite passes. Needs confirmation in client. |
| SetPredictedValues spam | Fixed: never pass protected health fields to this setter. Native amounts still render; protected prediction colours use normal custom/current-health colours. Readable values retain predicted-colour calculations. |
| Target does not update in combat | Same unresolved target refresh issue above. |
| Rebuff flash at combat transitions | Open: needs aura transition reproduction; no speculative delay introduced. |
| Countdown text disappears in combat | Native countdown numbers are disabled by default through `CombatAurasNums`; `/hbca nums` toggles them, with rebuild outside combat. Matching the skin's countdown preference automatically is not implemented. |

## Verification

`Test-Forever.ps1`: all 11 suites pass, 70 Lua files parse, 128 TOC/XML references exist.
Prediction mocks now reject secret fields passed to `SetPredictedValues`, matching the reported failure instead of accepting an invalid addon call.
Delta tests cover protected missing health, optional percentage, and zero.
No WoW client or taint validation was available. Passing mocks do not certify the unresolved reports.

## Publication

Local branch created. Personal repository and PR are not created yet. The available GitHub connector identifies Cappe93 but has no repository creation/fork tool; GitHub CLI is not on PATH. Upstream origin is unchanged.
