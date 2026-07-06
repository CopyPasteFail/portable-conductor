$ErrorActionPreference = 'Stop'

$destinations = @(
    (Join-Path $HOME '.agents\skills\portable-conductor'),
    (Join-Path $HOME '.claude\skills\portable-conductor')
)

foreach ($destination in $destinations) {
    if (Test-Path -LiteralPath $destination) {
        $item = Get-Item -LiteralPath $destination -Force
        $isReparsePoint = ($item.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0
        if ($isReparsePoint) {
            Remove-Item -LiteralPath $destination -Force
            Write-Host "Removed $destination"
        }
        else {
            Write-Warning "Skipped $destination because it is not a junction or symlink."
        }
    }
}
