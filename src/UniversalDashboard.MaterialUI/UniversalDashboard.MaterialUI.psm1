
if ($args[0])
{
    $MUAssetId = [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset("http://localhost:10000/materialui.index.bundle.js")
    [UniversalDashboard.Services.AssetService]::Instance.RegisterFramework("MaterialUI", "http://localhost:10000/materialui.index.bundle.js")
}
else 
{
    $JsFile = Get-ChildItem "$PSScriptRoot\index.*.bundle.js"
    $Files = Get-ChildItem "$PSScriptRoot\*.*"
    
    $Files | ForEach-Object {
        [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset($_.FullName)
    }
    
    $MUAssetId = [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset($JSFile.FullName)
    [UniversalDashboard.Services.AssetService]::Instance.RegisterFramework("MaterialUI", $JSFile.FullName)
}

# Load out controls
Get-ChildItem (Join-Path $PSScriptRoot "Scripts") -File -Filter "*.ps1" | ForEach-Object {
    . $_.FullName
} 