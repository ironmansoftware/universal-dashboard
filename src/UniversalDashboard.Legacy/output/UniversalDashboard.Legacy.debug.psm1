
$AssetId = [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset("http://localhost:10000/UniversalDashboard.Legacy.index.bundle.js")

Get-ChildItem (Join-Path $PSScriptRoot "PowerShell") -File -Filter "*.ps1" | ForEach-Object {
    . $_.FullName
} 
