
# The main index.js bundle
$IndexJs = Get-ChildItem "$PSScriptRoot\index.*.bundle.js"

# Any other JS files in the bundle
$JsFiles = Get-ChildItem "$PSScriptRoot\*.js"

# Source maps to make it easier to debug in the browser
$Maps = Get-ChildItem "$PSScriptRoot\*.map"

# Css files
$Css = Get-ChildItem "$PSScriptRoot\*.css"

# Register the main script and get the AssetID
$ChartAssetId = [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset($IndexJs.FullName)

# Register all the other scripts. We don't care about the asset ID. They will be loaded by the main JS file.
foreach ($item in $JsFiles) {
    [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset($item.FullName) | Out-Null
}

# Register all the source map files so we can make debugging easier.
foreach ($item in $Maps) {
    [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset($item.FullName) | Out-Null
}

# Register all the source map files so we can make debugging easier.
foreach ($item in $Css) {
    [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset($item.FullName) | Out-Null
}

# Dot source function
Get-ChildItem (Join-Path $PSScriptRoot "Scripts") -File -Filter "*.ps1" | ForEach-Object {
    . $_.FullName
}
