if ($Global:Debug) {
    $MUAssetId = [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset('http://localhost:10001/materialui.index.bundle.js')
    [UniversalDashboard.Services.AssetService]::Instance.RegisterFramework("MaterialUI", $MUAssetId)
} else {
    $JsFile = Get-ChildItem "$PSScriptRoot\materialui.index.*.bundle.js"
    $JsFiles = Get-ChildItem "$PSScriptRoot\*.bundle.js"
    $Maps = Get-ChildItem "$PSScriptRoot\*.bundle.map"

    $JsFiles | ForEach-Object {
        [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset($_.FullName)
    }

    $Maps | ForEach-Object {
        [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset($_.FullName) | Out-Null
    }

    $MUAssetId = [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset($JSFile.FullName)
    [UniversalDashboard.Services.AssetService]::Instance.RegisterFramework("MaterialUI", $MUAssetId)

}

# Load out controls
Get-ChildItem (Join-Path $PSScriptRoot "Scripts") -File -Filter "*.ps1" | ForEach-Object {
    . $_.FullName
}