param([Switch]$Release)

#TODO: 
return

. "$PSScriptRoot\..\TestFramework.ps1"
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

Get-UDDashboard | Stop-UDDashboard

Describe "Chart"  {
    Context "Multi-dataset" {
        $dashboard = New-UDDashboard -Title "Test" -Content {

            $Options = New-UDLineChartOptions -LayoutOptions (
                New-UDChartLayoutOptions -Padding 15
            ) -LegendOptions (
                New-UDChartLegendOptions -Position "bottom" 
            ) -TooltipOptions (
                New-UDChartTooltipOptions -TitleFontSize 50
            ) -yAxes (
                New-UDLinearChartAxis -Maximum 150 -Minimum 5
            ) -TitleOptions (
                New-UDChartTitleOptions -Display -Text "Hey!"
            )

            New-UDChart -Title "Chart" -Id "Chart" -Type Line -EndPoint {
                $data = @(
                    [PSCustomObject]@{"Day" = 1; Jpg = 100; MP4= 30}
                    [PSCustomObject]@{"Day" = 2; Jpg = 100; MP4= 40}
                    [PSCustomObject]@{"Day" = 3; Jpg = 100; MP4= 10}
                )

                $data | Out-UDChartData -LabelProperty "Day" -Dataset @(
                    New-UDLineChartDataset -DataProperty "Jpg" -Label "Jpg" -BackgroundColor "#80962F23" -PointBackgroundColor "#80962F23" -PointStyle "cross"
                    New-UDLineChartDataset -DataProperty "MP4" -Label "MP4" -BackgroundColor "#8014558C" -PointBackgroundColor "#8014558C" -PointStyle @("triangle", "star")
                ) 
            } -Options $Options
        } 

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        It "should have chart" {
            Find-SeElement -Id "Chart" -Driver $Driver | Should not be $null
        }

        Stop-SeDriver $Driver
        Stop-UDDashboard -Server $Server 
    }

}