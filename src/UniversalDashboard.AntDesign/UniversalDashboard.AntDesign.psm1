
if ($Env:Debug -eq $true) {
    $AssetId = [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset("http://localhost:10000/antdesign.index.bundle.js")
    [UniversalDashboard.Services.AssetService]::Instance.RegisterFramework("AntDesign", $AssetId)
} else {
    $IndexJs = Get-ChildItem "$PSScriptRoot\index.*.bundle.js"
    $JsFiles = Get-ChildItem "$PSScriptRoot\*.bundle.js"
    $Maps = Get-ChildItem "$PSScriptRoot\*.map"
    
    $AssetId = [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset($IndexJs.FullName)
    [UniversalDashboard.Services.AssetService]::Instance.RegisterFramework("AntDesign", $AssetId)
    
    foreach($item in $JsFiles)
    {
        [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset($item.FullName) | Out-Null
    }
    
    foreach($item in $Maps)
    {
        [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset($item.FullName) | Out-Null
    }
}

Get-ChildItem (Join-Path $PSScriptRoot "Scripts") -File | ForEach-Object {
    . $_.FullName
}

