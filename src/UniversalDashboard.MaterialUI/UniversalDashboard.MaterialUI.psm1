
$JsFile = Get-ChildItem "$PSScriptRoot\index.*.bundle.js"
$JsFiles = Get-ChildItem "$PSScriptRoot\*.bundle.js"
$CSSFile = Get-ChildItem "$PSScriptRoot\*.css"

# Register our style sheet with UD
[UniversalDashboard.Services.AssetService]::Instance.RegisterStyleSheet($CSSFile.FullName)

$JsFiles | ForEach-Object {
    [UniversalDashboard.Services.AssetService]::Instance.RegisterScript($_.FullName)
}

$MUAssetId = [UniversalDashboard.Services.AssetService]::Instance.RegisterScript($JSFile.FullName)

# Load out controls
Get-ChildItem (Join-Path $PSScriptRoot "Scripts") -File -Filter "*.ps1" | ForEach-Object {
    . $_.FullName
} 