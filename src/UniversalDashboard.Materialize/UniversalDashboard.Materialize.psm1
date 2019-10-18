
if ($Env:Debug -eq $true) {
    $AssetId = Register-UDAsset -Uri "http://localhost:10000/materialize.index.bundle.js"
    Register-UDAsset -FrameworkName "Materialize" -AssetId $AssetId
} else {
    $IndexJs = Get-ChildItem "$PSScriptRoot\index.*.bundle.js"
    $JsFiles = Get-ChildItem "$PSScriptRoot\*.bundle.js"
    $Maps = Get-ChildItem "$PSScriptRoot\*.map"

    $AssetId = Register-UDAsset -Path $IndexJs
    Register-UDAsset -FrameworkName "Materialize" -AssetId $AssetId
    $JsFiles | Register-UDAsset | Out-Null
    $Maps | Register-UDAsset | Out-Null
}

Get-ChildItem (Join-Path $PSScriptRoot "Scripts") -File | ForEach-Object {
    . $_.FullName
}

