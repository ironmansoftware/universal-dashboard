
$JsFiles = Get-ChildItem "$PSScriptRoot\*.bundle.js"

$Items = @("nivo-bar", "nivo-calendar", "nivo-heatmap", "nivo-line", "nivo-pie", "nivo-stream", "nivo-treemap")
foreach($item in $items) {
    $JsFiles | Where-Object { $_.FullName.Contains($item)} | ForEach-Object {
        [UniversalDashboard.Enterprise.NewNivoChartCommand]::AssetIds.Add($item, [UniversalDashboard.Services.AssetService]::Instance.RegisterScript($_))
    }
}

$SparklinesFile = $JsFiles | Where-Object { $_.FullName.Contains("sparklines")}

[UniversalDashboard.Enterprise.NewSparklinesCommand]::AssetId = [UniversalDashboard.Services.AssetService]::Instance.RegisterScript($SparklinesFile.FullName)