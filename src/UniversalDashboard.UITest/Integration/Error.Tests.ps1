param([Switch]$Release)

Import-Module "$PSScriptRoot\Selenium\Selenium.psm1"

if (-not $Release) {
    $BrowserPort = 10000
    Import-Module "$PSScriptRoot\..\..\UniversalDashboard\bin\debug\UniversalDashboard.Community.psd1"
} else {
    $BrowserPort = 10001
    Import-Module "$PSScriptRoot\..\..\output\UniversalDashboard.Community.psd1"
}
Get-UDDashboard | Stop-UDDashboard
Describe "Error" {
    Context "Components" {
        #Create a dashboard to test
        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDChart -Title "Chart" -Id "Chart" -Endpoint {
                New-UDTest 
            }

            New-UDMonitor -Title "Monitor" -Id "Monitor" -Endpoint {
                New-UDTest 
            }

            New-UDCounter -Title "Counter" -Id "Counter" -Endpoint {
                New-UDTest 
            }

            New-UDGrid -Title "Grid" -Id "Grid" -Headers @("None") -Properties @("None") -Endpoint {
                New-UDTest 
            }
        }
        
        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        #Open firefox
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        #Run some tests using selenium
        It "should show an error for chart" {
            $Target = Find-SeElement -Driver $Driver -Id "Chart"
            $Target.Text | Should be "Chart`r`nThe term 'New-UDTest' is not recognized as the name of a cmdlet, function, script file, or operable program. Check the spelling of the name, or if a path was included, verify that the path is correct and try again." 
        }

        It "should show an error for monitor" {
            $Target = Find-SeElement -Driver $Driver -Id "Monitor"
            $Target.Text | Should be "Monitor`r`nThe term 'New-UDTest' is not recognized as the name of a cmdlet, function, script file, or operable program. Check the spelling of the name, or if a path was included, verify that the path is correct and try again." 
        }

        It "should show an error for counter" {
            $Target = Find-SeElement -Driver $Driver -Id "Counter"
            $Target.Text | Should be "Counter`r`nThe term 'New-UDTest' is not recognized as the name of a cmdlet, function, script file, or operable program. Check the spelling of the name, or if a path was included, verify that the path is correct and try again." 
        }

        It "should show an error for grid" {
            $Target = Find-SeElement -Driver $Driver -Id "Grid"
            $Target.Text | Should be "Grid`r`nThe term 'New-UDTest' is not recognized as the name of a cmdlet, function, script file, or operable program. Check the spelling of the name, or if a path was included, verify that the path is correct and try again." 
        }

        Stop-SeDriver $Driver
        Stop-UDDashboard -Server $Server 
    }

    Context "Page" {
        $dashboard = New-UDDashboard -Title "Test" -Pages @(
            New-UDPage -Id "Page" -Name "Home" -Content {
                New-UDTest
            }
        )
        
        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        It "should show error for whole page" {
            $Target = Find-SeElement -Driver $Driver -Id "Page"
            $Target.Text | Should be "An error occurred on this page`r`nThe term 'New-UDTest' is not recognized as the name of a cmdlet, function, script file, or operable program. Check the spelling of the name, or if a path was included, verify that the path is correct and try again." 
        }

        Stop-SeDriver $Driver
        Stop-UDDashboard -Server $Server 
    }
}