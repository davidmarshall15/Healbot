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
} finally {
    Pop-Location
}
