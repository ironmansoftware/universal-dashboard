
$JsFile = Get-ChildItem "$PSScriptRoot\index.*.bundle.js"
$JsFiles = Get-ChildItem "$PSScriptRoot\*.bundle.js"
$Maps = Get-ChildItem "$PSScriptRoot\*.bundle.map"
$CSSFile = Get-ChildItem "$PSScriptRoot\*.css"

# Register our style sheet with UD
[UniversalDashboard.Services.AssetService]::Instance.RegisterStyleSheet($CSSFile.FullName)

$JsFiles | ForEach-Object {
    [UniversalDashboard.Services.AssetService]::Instance.RegisterScript($_.FullName)
}

$Maps | ForEach-Object {
    [UniversalDashboard.Services.AssetService]::Instance.RegisterScript($_.FullName) | Out-Null
}

$MUAssetId = [UniversalDashboard.Services.AssetService]::Instance.RegisterScript($JSFile.FullName)
[UniversalDashboard.Services.AssetService]::Instance.RegisterFramework("MaterialUI", $MUAssetId)

# Load out controls
Get-ChildItem (Join-Path $PSScriptRoot "Scripts") -File -Filter "*.ps1" | ForEach-Object {
    . $_.FullName
} 