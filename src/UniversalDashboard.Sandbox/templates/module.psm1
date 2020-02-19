$RootAsset = Get-ChildItem "$PSScriptRoot\index.*.bundle.js"
$Files = Get-ChildItem "$PSScriptRoot\*.*"

$Files | ForEach-Object {
    [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset($_.FullName) | Out-Null
}

$AssetId = [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset($RootAsset.FullName)

Get-ChildItem (Join-Path $PSScriptRoot "PowerShell") -File -Filter "*.ps1" | ForEach-Object {
    . $_.FullName
} 