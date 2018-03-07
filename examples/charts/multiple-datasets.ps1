<#
    Provies an example of creating a chart with multiple datasets.
#>

Import-Module UniversalDashboard

$Data = @(
    @{Animal="Frog";Count=10;Babies=3}
    @{Animal="Tiger";Count=1;Babies=0}
    @{Animal="Bat";Count=34;Babies=30}
    @{Animal="Fox";Count=20;Babies=10}
)

$Dashboard = New-UDDashboard -Title "Charts - Multiple Datasets" -Content {
    New-UDChart -Title "Bottom Legend" -Type "Bar" -Endpoint {
        $Data | Out-UDChartData -LabelProperty "Animal"  -Dataset @(
            New-UDBarChartDataset -Label "Adults" -DataProperty Count -BackgroundColor "#205D4CFF" -BorderColor "#5D4CFF" -BorderWidth 3
            New-UDBarChartDataset -Label "Babies" -DataProperty Babies -BackgroundColor "#20A07DFF" -BorderColor "#A07DFF" -BorderWidth 3
        )
    } 
}

Start-UDDashboard -Dashboard $Dashboard -Port 8080