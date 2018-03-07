<#
    Provides an example of customizing the legend.
#>

Import-Module UniversalDashboard

$Data = @(
    @{Animal="Frog";Count=10}
    @{Animal="Tiger";Count=1}
    @{Animal="Bat";Count=34}
    @{Animal="Fox";Count=20}
)

$Dashboard = New-UDDashboard -Title "Charts - Legend" -Content {

    $LegendOptions = New-UDChartLegendOptions -Position bottom
    $Options = New-UDLineChartOptions -LegendOptions $LegendOptions

    New-UDChart -Title "Bottom Legend" -Type "Line" -Endpoint {
        $Data | Out-UDChartData -LabelProperty "Animal"  -Dataset @(
            New-UDLineChartDataset -Label "Animals" -DataProperty Count -BackgroundColor "#205D4CFF" -BorderColor "#5D4CFF" -BorderWidth 3
        )
    } -Options $Options
}

Start-UDDashboard -Dashboard $Dashboard -Port 8080