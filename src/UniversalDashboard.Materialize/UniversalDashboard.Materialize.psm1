
$IndexJs = Get-ChildItem "$PSScriptRoot\index.*.bundle.js"
$JsFiles = Get-ChildItem "$PSScriptRoot\*.bundle.js"

$AssetId = [UniversalDashboard.Services.AssetService]::Instance.RegisterScript($IndexJs.FullName)

foreach($item in $JsFiles)
{
    [UniversalDashboard.Services.AssetService]::Instance.RegisterScript($item.FullName) | Out-Null
}

Get-ChildItem (Join-Path $PSScriptRoot "scripts") -File | ForEach-Object {
    . $_.FullName
}