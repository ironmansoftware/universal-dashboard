
$JsFile = Get-ChildItem "$PSScriptRoot\*.bundle.js"
$Script:AssetId = [UniversalDashboard.Services.AssetService]::Instance.RegisterScript($JsFile)

Get-ChildItem -Path (Join-Path $PSScriptRoot components) | ForEach-Object {
    . $_.FullName
}