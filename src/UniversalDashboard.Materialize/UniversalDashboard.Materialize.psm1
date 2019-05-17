
if ($Env:Debug -eq $true) {
    $AssetId = [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset("http://localhost:10000/materialize.index.bundle.js")
    [UniversalDashboard.Services.AssetService]::Instance.RegisterFramework("Materialize", $AssetId)
} else {
    $IndexJs = Get-ChildItem "$PSScriptRoot\index.*.bundle.js"
    $JsFiles = Get-ChildItem "$PSScriptRoot\*.bundle.js"
    $Maps = Get-ChildItem "$PSScriptRoot\*.map"
    
    $AssetId = [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset($IndexJs.FullName)
    [UniversalDashboard.Services.AssetService]::Instance.RegisterFramework("Materialize", $AssetId)
    
    foreach($item in $JsFiles)
    {
        [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset($item.FullName) | Out-Null
    }
    
    foreach($item in $Maps)
    {
        [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset($item.FullName) | Out-Null
    }
}

Get-ChildItem (Join-Path $PSScriptRoot "scripts") -File | ForEach-Object {
    . $_.FullName
}

