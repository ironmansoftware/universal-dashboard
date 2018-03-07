<#
    Provides an example of creating a custom axis with a minimum and maximum value for the axis.
#>

Import-Module UniversalDashboard

$Data = @(
    @{Animal="Frog";Count=10}
    @{Animal="Tiger";Count=1}
    @{Animal="Bat";Count=34}
    @{Animal="Fox";Count=20}
)

$Dashboard = New-UDDashboard -Title "Charts - Custom Axis" -Content {

    $MinMaxAxis = New-UDLinearChartAxis -Minimum 10 -Maximum 20
    $Options = New-UDLineChartOptions -yAxes $MinMaxAxis

    New-UDChart -Title "Line Chart" -Type "Line" -Endpoint {
        $Data | Out-UDChartData -LabelProperty "Animal"  -Dataset @(
            New-UDLineChartDataset -Label "Animals" -DataProperty Count -BackgroundColor "#205D4CFF" -BorderColor "#5D4CFF" -BorderWidth 3
        )
    } -Options $Options
}

Start-UDDashboard -Dashboard $Dashboard -Port 8080