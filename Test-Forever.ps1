[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
Push-Location $PSScriptRoot
try {
    $addons = @('HealBot', 'HealBot_Tips', 'HealBot_ExtraSkins')
    $luaFiles = @(Get-ChildItem -LiteralPath $addons -Filter *.lua -Recurse)
    foreach ($file in $luaFiles) {
        & lua tests/syntax.lua $file.FullName
        if ($LASTEXITCODE -ne 0) { throw "Lua syntax failed: $($file.FullName)" }
    }
    Write-Output "Lua syntax OK: $($luaFiles.Count) files (UTF-8 BOM supported)."

    $references = 0
    foreach ($file in Get-ChildItem -LiteralPath $addons -Recurse -File) {
        if ($file.Extension -eq '.toc') {
            $paths = @(Get-Content -LiteralPath $file.FullName | ForEach-Object {
                $line = $_.Trim()
                if ($line -and -not $line.StartsWith('#')) { $line }
            })
        } elseif ($file.Extension -eq '.xml') {
            [xml]$document = Get-Content -LiteralPath $file.FullName -Raw
            $paths = @($document.SelectNodes('//*[@file]') | ForEach-Object {
                if ($_.LocalName -eq 'Script' -or $_.LocalName -eq 'Include') { $_.GetAttribute('file') }
            })
        } else {
            continue
        }
        foreach ($path in $paths) {
            if (-not (Test-Path -LiteralPath (Join-Path $file.DirectoryName $path) -PathType Leaf)) {
                throw "Missing reference in $($file.FullName): $path"
            }
            $references++
        }
    }
    Write-Output "TOC/XML references OK: $references."
    & lua tests/compatibility.lua
    if ($LASTEXITCODE -ne 0) { throw 'Compatibility tests failed.' }
    & lua tests/forever_frames.lua
    if ($LASTEXITCODE -ne 0) { throw 'Forever frame tests failed.' }
    & lua tests/opacity.lua
    if ($LASTEXITCODE -ne 0) { throw 'Opacity regression tests failed.' }
    & lua tests/tooltip.lua
    if ($LASTEXITCODE -ne 0) { throw 'Tooltip regression tests failed.' }
    & lua tests/health_text.lua
    if ($LASTEXITCODE -ne 0) { throw 'Health text regression tests failed.' }
    & lua tests/secret_values.lua
    if ($LASTEXITCODE -ne 0) { throw 'Mixed secret-value regression tests failed.' }
    & lua tests/prediction.lua
    if ($LASTEXITCODE -ne 0) { throw 'Native prediction regression tests failed.' }
    & lua tests/target_binding.lua
    if ($LASTEXITCODE -ne 0) { throw 'Target binding regression tests failed.' }
    & lua tests/modified_target.lua
    if ($LASTEXITCODE -ne 0) { throw 'Modified Target dispatch regression tests failed.' }
    & lua tests/rank_range.lua
    if ($LASTEXITCODE -ne 0) { throw 'Spell rank/range regression tests failed.' }
    & lua tests/unranked_spells.lua
    if ($LASTEXITCODE -ne 0) { throw 'Unranked spell regression tests failed.' }
    & lua tests/spell_refresh.lua
    if ($LASTEXITCODE -ne 0) { throw 'Combat spell refresh regression tests failed.' }
    & lua tests/combat_auras.lua
    if ($LASTEXITCODE -ne 0) { throw 'Combat aura layout regression tests failed.' }
    & lua tests/forever_buffs.lua
    if ($LASTEXITCODE -ne 0) { throw 'Forever buff settings regression tests failed.' }
    & lua tests/native_buff_matching.lua
    if ($LASTEXITCODE -ne 0) { throw 'Native buff matching regression tests failed.' }
    & lua tests/native_buff_casters.lua
    if ($LASTEXITCODE -ne 0) { throw 'Native buff caster regression tests failed.' }
    & lua tests/native_aura_options.lua
    if ($LASTEXITCODE -ne 0) { throw 'Native aura options regression tests failed.' }
    & lua tests/reported_bugs.lua
    if ($LASTEXITCODE -ne 0) { throw 'Reported bug regression tests failed.' }
    & lua tests/movement_safety.lua
    if ($LASTEXITCODE -ne 0) { throw 'Protected movement regression tests failed.' }
    & lua tests/party_startup.lua
    if ($LASTEXITCODE -ne 0) { throw 'Party startup/media regression tests failed.' }
    foreach ($suite in @('aggro', 'gcd', 'heal_amount')) {
        & lua "tests/$suite.lua"
        if ($LASTEXITCODE -ne 0) { throw "$suite regression tests failed." }
    }
    & lua tests/player_mana.lua
    if ($LASTEXITCODE -ne 0) { throw 'Player mana tooltip regression tests failed.' }
    & lua tests/adaptive_reset.lua
    if ($LASTEXITCODE -ne 0) { throw 'Adaptive colour reset regression tests failed.' }
} finally {
    Pop-Location
}
