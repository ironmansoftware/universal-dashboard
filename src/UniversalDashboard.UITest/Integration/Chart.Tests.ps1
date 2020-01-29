param([Switch]$Release)

. "$PSScriptRoot\..\TestFramework.ps1"
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

Get-UDDashboard | Stop-UDDashboard
Describe "Chart" {

    Context "filter controls" {
        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDChart -Title "Chart" -Id "Chart" -Type Line -EndPoint {
                param($Text, $Select) 

                $data = @(
                    [PSCustomObject]@{"Day" = 1; Jpg = "10"; MP4= "30"}
                    [PSCustomObject]@{"Day" = 2; Jpg = "20"; MP4= "20"}
                    [PSCustomObject]@{"Day" = 3; Jpg = "30"; MP4= "10"}
                )

                if ($Text -eq "Test") {
                    $data += [PSCustomObject]@{"Day" = 4; Jpg = "40"; MP4= "0"}
                }

                if ($Select -eq "Test2") {
                    $data += [PSCustomObject]@{"Day" = 5; Jpg = "50"; MP4= "100"}
                }

                $data | Out-UDChartData -LabelProperty "Day" -Dataset @(
                    New-UDChartDataset -DataProperty "Jpg" -Label "Jpg" -BackgroundColor "#80962F23" -HoverBackgroundColor "#80962F23"
                    New-UDChartDataset -DataProperty "MP4" -Label "MP4" -BackgroundColor "#8014558C" -HoverBackgroundColor "#8014558C"
                ) 
            } -FilterFields {
                New-UDInputField -Type "textbox" -Name "Text" -Placeholder 'Test Stuff'
                New-UDInputField -Type "select" -Name "Select" -Placeholder 'Test Other Stuff' -Values @("Test", "Test2", "Test3")
            }
        } 

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        It "Changes the chart with a filter" {
            $Element = Find-SeElement -Name "Text" -Driver $Driver
            Send-SeKeys -Element $Element -Keys "Test"
        }

        Stop-SeDriver $Driver
        Stop-UDDashboard -Server $Server 
    }

    Context "Multi-dataset" {
        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDChart -Title "Chart" -Id "Chart" -Type Line -EndPoint {
                $data = @(
                    [PSCustomObject]@{"Day" = 1; Jpg = "10"; MP4= "30"}
                    [PSCustomObject]@{"Day" = 2; Jpg = "20"; MP4= "20"}
                    [PSCustomObject]@{"Day" = 3; Jpg = "30"; MP4= "10"}
                )

                $data | Out-UDChartData -LabelProperty "Day" -Dataset @(
                    New-UDChartDataset -DataProperty "Jpg" -Label "Jpg" -BackgroundColor "#80962F23" -HoverBackgroundColor "#80962F23"
                    New-UDChartDataset -DataProperty "MP4" -Label "MP4" -BackgroundColor "#8014558C" -HoverBackgroundColor "#8014558C"
                ) 
            } -Links @(
                New-UDLink -Text "My Link" -Url "http://www.google.com"
            )
        } 

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        It "should have chart" {
            Find-SeElement -Id "Chart" -Driver $Driver | Should not be $null
        }

        It "should have chart" {
            Find-SeElement -LinkText "MY LINK" -Driver $Driver | Should not be $null
        }

       Stop-SeDriver $Driver
       Stop-UDDashboard -Server $Server 
    }

    Context "Custom Size" {
        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDChart -Title "Chart" -Id "Chart" -Type Line -EndPoint {
                $data = @(
                    [PSCustomObject]@{"Day" = 1; Jpg = "10"; MP4= "30"}
                    [PSCustomObject]@{"Day" = 2; Jpg = "20"; MP4= "20"}
                    [PSCustomObject]@{"Day" = 3; Jpg = "30"; MP4= "10"}
                )

                $data | Out-UDChartData -LabelProperty "Day" -Dataset @(
                    New-UDChartDataset -DataProperty "Jpg" -Label "Jpg" -BackgroundColor "#80962F23" -HoverBackgroundColor "#80962F23"
                    New-UDChartDataset -DataProperty "MP4" -Label "MP4" -BackgroundColor "#8014558C" -HoverBackgroundColor "#8014558C"
                ) 
            } -Links @(
                New-UDLink -Text "My Link" -Url "http://www.google.com"
            ) -Width 30vw -Height 300px
        } 

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        $charts = Find-SeElement -Driver $driver -ClassName 'ud-chart'
        $chartContent = $charts.FindElementByClassName('card-content')
        $chartStyle = Get-SeElementAttribute -Element $chartContent -Attribute 'style'

        It "should have custom width size" {
            (($chartStyle -split ';') -split 'width:')[1].trim() | Should be '30vw'
        }

        It "should have custom height size" {
            (($chartStyle -split ';') -split 'height:')[2].trim() | Should be '300px'
        }

       Stop-SeDriver $Driver
       Stop-UDDashboard -Server $Server 
    }


}