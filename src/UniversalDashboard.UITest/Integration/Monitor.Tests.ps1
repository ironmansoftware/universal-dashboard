. "$PSScriptRoot\..\TestFramework.ps1"
Describe "Monitor" {

    Context "Filter fields" {
        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDMonitor -Title "Monitor" -Id "Monitor" -ChartBackgroundColor "#80962F23" -ChartBorderColor "#80962F23" -Type Line -EndPoint {
                param($Text, $Select) 

                if ($Text -eq "Test") {
                    0 | Out-UDMonitorData
                } elseif ($Select -eq "Test2") {
                    100 | Out-UDMonitorData
                } else {
                    Get-Random | Out-UDMonitorData
                }

            } -FilterFields {
                New-UDInputField -Type "textbox" -Name "Text" -Placeholder 'Test Stuff'
                New-UDInputField -Type "select" -Name "Select" -Placeholder 'Test Other Stuff' -Values @("Test", "Test2", "Test3")
            }
        }

        Start-UDDashboard -Dashboard $Dashboard -Port 10001 -Force
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
        
        It "should filter" {
            $Element = Find-SeElement -Name "Text" -Driver $Driver
            Send-SeKeys -Element $Element -Keys "Test"
        }
    }

    Context "Single-dataset" {
        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDMonitor -Title "Monitor" -Id "Monitor" -ChartBackgroundColor "#80962F23" -ChartBorderColor "#80962F23" -Type Line -EndPoint {
                Get-Random | Out-UDMonitorData
            } -Links @(
                New-UDLink -Text "Hey" -Url "http://www.google.com"
            )
        }

        Start-UDDashboard -Dashboard $Dashboard -Port 10001 -Force
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
        
        It "should have Monitor" {
            Find-SeElement -Id "Monitor" -Driver $Driver | Should not be $null
        }

        It "should have link" {
            Find-SeElement -LinkText "HEY" -Driver $Driver | Should not be $null
        }
    }

    Context "Multi-dataset" {
        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDMonitor -Title "Monitor" -Id "Monitor" -ChartBackgroundColor @("#80962F23", "#8014558C") -ChartBorderColor @("#80962F23", "#8014558C") -Label @("Virutal Memory", "Physical Memory") -Type Line -EndPoint {
                Out-UDMonitorData -Data @(
                    Get-Random
                    Get-Random
                )
            }
        }

        Start-UDDashboard -Dashboard $Dashboard -Port 10001 -Force
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
        
        It "should have Monitor" {
            Find-SeElement -Id "Monitor" -Driver $Driver | Should not be $null
        }
    }

    Context "Min\max" {

        $Options = New-UDLineChartOptions -yAxes (
            New-UDLinearChartAxis -Maximum 150 -Minimum 5
        ) 

        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDMonitor -Title "Monitor" -Id "Monitor" -ChartBackgroundColor @("#80962F23", "#8014558C") -ChartBorderColor @("#80962F23", "#8014558C") -Label @("Virutal Memory", "Physical Memory") -Type Line -EndPoint {
                Out-UDMonitorData -Data @(
                    Get-Random
                    Get-Random
                )
            } -Options $options
        }

        Start-UDDashboard -Dashboard $Dashboard -Port 10001 -Force
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
        Start-Sleep 2

        It "should have Monitor" {
            Find-SeElement -Id "Monitor" -Driver $Driver | Should not be $null
        }
    }

}