param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

# Get-UDDashboard | Stop-UDDashboard

Describe "Speed Tests Card" {
    # Start-UDDashboard -Port 10001 -Content {} 


    Context "Simple Card" {
        $tempDir = [System.IO.Path]::GetTempPath()
        $tempFile = Join-Path $tempDir "output.txt"

        if ((Test-path $tempFile)) {
            Remove-Item $tempFile -Force
        }

        Push-NewDashboard -Dashboard New-UDDashboard -Title "Test" -Content {
            New-UDCard -Title "Test" -Text "My text" -Id "Card" -Links @(
                New-UDLink -Text "My Link" -Url "http://www.google.com"
            )

            New-UDCard -Title "ÆØÅ" -Text "Test" -Id "nordic"

            New-UDCard -Title "Test" -Id "EndpointCard" -Endpoint {
                New-UDElement -Tag "div" -Content { "Endpoint Content" } 
            }

            New-UDCard -Title "Test" -Id "NoTextCard"

            New-UDCard -Title "Test" -Text "My text`r`nNew Line" -Id "MultiLineCard"

            New-UDCard -Title "Test" -Text "Small Text" -Id "Card-Small-Text" -TextSize Small

            New-UDCard -Title "Test" -Text "Medium Text" -Id "Card-Medium-Text" -TextSize Medium

            New-UDCard -Title "Test" -Text "Large Text" -Id "Card-Large-Text" -TextSize Large

            New-UDCard -Title "Test" -Content {
                New-UDElement -Tag "span" -Attributes @{id = "spanTest"} -Content {
                    "This is some custom content"
                }
            }
        }

        # $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"


        It "should have title text" {
            $Element = Find-SeElement -Id "Card" -Driver $Driver
            $Element.Text.Split("`r`n")[0] | should be "Test"
        }

        It "should have link" {
            Find-SeElement -LinkText "MY LINK" -Driver $Driver | Should not be $null
        }

        It "should show nordic chars correctly" {
            $Element = Find-SeElement -Id "nordic" -Driver $Driver
            $Element.Text.Split("`r`n")[0] | should be "ÆØÅ"
        }

        It "should load content from endpoint" {
            $Element = Find-SeElement -Id "EndpointCard" -Driver $Driver
            ($Element.Text).Contains("Endpoint Content") | should be $true
        }

        It "should have title text" {
            $Element = Find-SeElement -Id "NoTextCard" -Driver $Driver
            $Element.Text | should be "Test"
        }

        It "should support new line in card" {
            $Element = Find-SeElement -Id "MultiLineCard" -Driver $Driver
            $Br = Find-SeElement -Tag "br" -Element $Element
            $Br | should not be $null
        }

        It "should have text of Small Text" {
            $Element = Find-SeElement -Id "Card-Small-Text" -Driver $Driver
            ($Element.Text -split "`r`n")[1] | should be 'Small Text'
        }

        $Element = Find-SeElement -Id "Card-Medium-Text" -Driver $Driver
        $CardContent = Find-SeElement -Element $Element -TagName 'h5'

        It "should have html H5 tag" {
            $CardContent.TagName | should be 'h5'
        }

        It "should have text of Medium Text" {
            $CardContent.Text | should be 'Medium Text'
        }

        $Element = Find-SeElement -Id "Card-Large-Text" -Driver $Driver
        $CardContent = Find-SeElement -Element $Element -TagName 'h3'

        It "should have html H3 tag" {
            $CardContent.TagName | should be 'h3'
        }

        It "should have text of Large Text" {
            $CardContent.Text | should be 'Large Text'
        }

        It "should have custom content" {
            $Element = Find-SeElement -Id "spanTest" -Driver $Driver
            $Element.Text | should be "This is some custom content"
        }

        # Stop-SeDriver $Driver
        # Stop-UDDashboard -Server $Server 
    }
}

Describe "Speed Tests Monitor" {

    Context "Filter fields" {
        Push-NewDashboard -Dashboard New-UDDashboard -Title "Test" -Content {
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

        # $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        # $Driver = Start-SeFirefox
        # Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
        Start-Sleep 2

        It "should filter" {
            $Element = Find-SeElement -Name "Text" -Driver $Driver
            Send-SeKeys -Element $Element -Keys "Test"
        }

    #    Stop-SeDriver $Driver
    #    Stop-UDDashboard -Server $Server 
    }

    Context "Single-dataset" {
        Push-NewDashboard -Dashboard New-UDDashboard -Title "Test" -Content {
            New-UDMonitor -Title "Monitor" -Id "Monitor" -ChartBackgroundColor "#80962F23" -ChartBorderColor "#80962F23" -Type Line -EndPoint {
                Get-Random | Out-UDMonitorData
            } -Links @(
                New-UDLink -Text "Hey" -Url "http://www.google.com"
            )
        }

        # $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        # $Driver = Start-SeFirefox
        # Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
        Start-Sleep 2

        It "should have Monitor" {
            Find-SeElement -Id "Monitor" -Driver $Driver | Should not be $null
        }

        It "should have link" {
            Find-SeElement -LinkText "HEY" -Driver $Driver | Should not be $null
        }

    #    Stop-SeDriver $Driver
    #    Stop-UDDashboard -Server $Server 
    }

    Context "Multi-dataset" {
        Push-NewDashboard -Dashboard New-UDDashboard -Title "Test" -Content {
            New-UDMonitor -Title "Monitor" -Id "Monitor" -ChartBackgroundColor @("#80962F23", "#8014558C") -ChartBorderColor @("#80962F23", "#8014558C") -Label @("Virutal Memory", "Physical Memory") -Type Line -EndPoint {
                Out-UDMonitorData -Data @(
                    Get-Random
                    Get-Random
                )
            }
        }

        # $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        # $Driver = Start-SeFirefox
        # Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
        Start-Sleep 2

        It "should have Monitor" {
            Find-SeElement -Id "Monitor" -Driver $Driver | Should not be $null
        }

    #    Stop-SeDriver $Driver
    #    Stop-UDDashboard -Server $Server 
    }

    Context "Min\max" {

        $Options = New-UDLineChartOptions -yAxes (
            New-UDLinearChartAxis -Maximum 150 -Minimum 5
        ) 

        Push-NewDashboard -Dashboard New-UDDashboard -Title "Test" -Content {
            New-UDMonitor -Title "Monitor" -Id "Monitor" -ChartBackgroundColor @("#80962F23", "#8014558C") -ChartBorderColor @("#80962F23", "#8014558C") -Label @("Virutal Memory", "Physical Memory") -Type Line -EndPoint {
                Out-UDMonitorData -Data @(
                    Get-Random
                    Get-Random
                )
            } -Options $options
        }

        # $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        # $Driver = Start-SeFirefox
        # Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
        Start-Sleep 2

        It "should have Monitor" {
            Find-SeElement -Id "Monitor" -Driver $Driver | Should not be $null
        }

        

        Stop-SeDriver $Driver
        # Stop-UDDashboard -Server $Server 
    }

}

