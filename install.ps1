[CmdletBinding()]
param(
    [ValidateSet('all', 'agents', 'claude')]
    [string]$Target = 'all',
    [switch]$Force
)

$ErrorActionPreference = 'Stop'
$repoRoot = (Resolve-Path $PSScriptRoot).Path
$skillSource = Join-Path $repoRoot 'skill'
$skillFile = Join-Path $skillSource 'SKILL.md'

if (-not (Test-Path -LiteralPath $skillFile -PathType Leaf)) {
    throw "Canonical skill not found at $skillFile"
}

function New-SkillJunction {
    param([Parameter(Mandatory = $true)][string]$Destination)

    $parent = Split-Path -Parent $Destination
    New-Item -ItemType Directory -Path $parent -Force | Out-Null

    if (Test-Path -LiteralPath $Destination) {
        $item = Get-Item -LiteralPath $Destination -Force
        $isReparsePoint = ($item.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0

        if (-not $isReparsePoint) {
            throw "$Destination exists and is not a junction or symlink. It was not changed."
        }

        if (-not $Force) {
            throw "$Destination already exists. Re-run with -Force to replace it."
        }

        Remove-Item -LiteralPath $Destination -Force
    }

    New-Item -ItemType Junction -Path $Destination -Target $skillSource | Out-Null
    Write-Host "Linked $Destination -> $skillSource"
}

if ($Target -in @('all', 'agents')) {
    New-SkillJunction -Destination (Join-Path $HOME '.agents\skills\portable-conductor')
}

if ($Target -in @('all', 'claude')) {
    New-SkillJunction -Destination (Join-Path $HOME '.claude\skills\portable-conductor')
}

Write-Host 'Done. Restart an agent if it does not discover the skill in the current session.'
