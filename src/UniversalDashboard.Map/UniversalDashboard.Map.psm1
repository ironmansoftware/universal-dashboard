
if ($Env:Debug -eq $true) {
    $AssetId = [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset("http://localhost:10000/map.index.bundle.js")
    [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset("http://localhost:10000/layers.png") | Out-Null
    [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset("http://localhost:10000/marker-shadow.png") | Out-Null
    [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset("http://localhost:10000/marker-icon.png") | Out-Null
    [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset("http://localhost:10000/marker-icon-2x.png") | Out-Null
} else {
    $IndexJs = Get-ChildItem "$PSScriptRoot\index.*.bundle.js"
    $JsFiles = Get-ChildItem "$PSScriptRoot\*.bundle.js"
    $Maps = Get-ChildItem "$PSScriptRoot\*.map"
    $Pngs = Get-ChildItem "$PSScriptRoot\*.png"

    $AssetId = [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset($IndexJs.FullName)
    
    foreach($item in $JsFiles)
    {
        [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset($item.FullName) | Out-Null
    }

    foreach($item in $Maps)
    {
        [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset($item.FullName) | Out-Null
    }

    $Pngs = Get-ChildItem "$PSScriptRoot\*.png"
    foreach($item in $Pngs)
    {
        [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset($item.FullName) | Out-Null
    }
}



Get-ChildItem (Join-Path $PSScriptRoot "Scripts") -File | ForEach-Object {
    . $_.FullName
}

