<#
    Provides an example of configuring a chart's tooltips.
#>

Import-Module UniversalDashboard

$Data = @(
    @{Animal="Frog";Count=10}
    @{Animal="Tiger";Count=1}
    @{Animal="Bat";Count=34}
    @{Animal="Fox";Count=20}
)

$Dashboard = New-UDDashboard -Title "Charts - Tooltips" -Content {

    $LegendOptions = New-UDChartTooltipOptions -BackgroundColor "#2928FF" -BodyFontColor "#FFFFFF" -TitleFontColor "#FFFFFF" -CornerRadius 20 -TitleFontSize 50
    $Options = New-UDLineChartOptions -TooltipOptions $LegendOptions

    New-UDChart -Title "Big tooltips with custom colors" -Type "Line" -Endpoint {
        $Data | Out-UDChartData -LabelProperty "Animal"  -Dataset @(
            New-UDLineChartDataset -Label "Animals" -DataProperty Count -BackgroundColor "#205D4CFF" -BorderColor "#5D4CFF" -BorderWidth 3
        )
    } -Options $Options
}

Start-UDDashboard -Dashboard $Dashboard -Port 8080