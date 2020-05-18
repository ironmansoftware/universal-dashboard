
if ($Env:DebugCharts -eq $true) {
    $AssetId = [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset("http://localhost:10000/udcharts.bundle.js")
    [UniversalDashboard.Enterprise.NewNivoChartCommand]::AssetId = $AssetId
} else {
    $JsFile = Get-ChildItem "$PSScriptRoot\udcharts.*.bundle.js"
    $AssetId = [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset($JsFile.FullName)
    [UniversalDashboard.Enterprise.NewNivoChartCommand]::AssetId = $AssetId
}

function New-UDNivoTheme {
    param(
        [Parameter()]
        [UniversalDashboard.Models.DashboardColor]$TickLineColor,
        [Parameter()]
        [UniversalDashboard.Models.DashboardColor]$TickTextColor,
        [Parameter()]
        [UniversalDashboard.Models.DashboardColor]$GridLineStrokeColor,
        [Parameter()]
        [int]$GridStrokeWidth
    )

    @{
        axis = @{
            ticks = @{
                line = @{
                    stoke = $TickLineColor.HtmlColor
                }
                text = @{
                    fill = $TickTextColor.HtmlColor
                }
            }
        }
        grid = @{
            line = @{
                stroke = $GridLineStrokeColor.HtmlColor
                strokeWidth = $GridStrokeWidth
            }
        }
    }
}