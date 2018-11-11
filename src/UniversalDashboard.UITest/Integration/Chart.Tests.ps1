param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

Describe "Chart" {

    Context "filter controls" {
        Invoke-RestMethod -Method Post -Uri "http://localhost:10001/api/internal/component/terminal" -Body ('$dashboardservice.setDashboard((
            New-UDDashboard -Title "Test" -Content {
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
                New-UDInputField -Type "textbox" -Name "Text" -Placeholder "Test Stuff"
                New-UDInputField -Type "select" -Name "Select" -Placeholder "Test Other Stuff" -Values @("Test", "Test2", "Test3")
            }
        }))') -SessionVariable ss -ContentType 'text/plain'

        $Cache:Driver.navigate().refresh()

        It "Changes the chart with a filter" {
            $Element = Find-SeElement -Name "Text" -Driver $Cache:Driver
            Send-SeKeys -Element $Element -Keys "Test"
        }
    }

    Context "Multi-dataset" {
        Invoke-RestMethod -Method Post -Uri "http://localhost:10001/api/internal/component/terminal" -Body ('$dashboardservice.setDashboard((
            New-UDDashboard -Title "Test" -Content {
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
        }))') -SessionVariable ss -ContentType 'text/plain'

        $Cache:Driver.navigate().refresh()

        It "should have chart" {
            Find-SeElement -Id "Chart" -Driver $Cache:Driver | Should not be $null
        }

        It "should have chart" {
            Find-SeElement -LinkText "MY LINK" -Driver $Cache:Driver | Should not be $null
        }
    }

    Context "Custom Size" {
        Invoke-RestMethod -Method Post -Uri "http://localhost:10001/api/internal/component/terminal" -Body ('$dashboardservice.setDashboard((
            New-UDDashboard -Title "Test" -Content {
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
        }))') -SessionVariable ss -ContentType 'text/plain' 

        $Cache:Driver.navigate().refresh()

        $charts = Find-SeElement -Driver $Cache:driver -ClassName 'ud-chart'
        $chartContent = $charts.FindElementByClassName('card-content')
        $chartStyle = Get-SeElementAttribute -Element $chartContent -Attribute 'style'

        It "should have custom width size" {
            (($chartStyle -split ';') -split 'width:')[1].trim() | Should be '30vw'
        }

        It "should have custom height size" {
            (($chartStyle -split ';') -split 'height:')[2].trim() | Should be '300px'
        }
    }
}