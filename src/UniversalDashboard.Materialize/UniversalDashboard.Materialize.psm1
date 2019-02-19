
$JsFile = Get-ChildItem "$PSScriptRoot\*.bundle.js"
$Script:AssetId = [UniversalDashboard.Services.AssetService]::Instance.RegisterScript($JSFile.FullName)

$Styles = Get-ChildItem  "$PSScriptRoot\*.css"
[UniversalDashboard.Services.AssetService]::Instance.RegisterStylesheet($Styles.FullName) | Out-Null

Get-ChildItem (Join-Path $PSScriptRoot 'cmdlets') | ForEach-Object {
    . $_.FullName
}