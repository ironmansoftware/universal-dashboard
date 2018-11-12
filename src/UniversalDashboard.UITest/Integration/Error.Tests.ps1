param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

Describe "Error" {
    Context "Components" {
        #Create a dashboard to test
        Invoke-RestMethod -Method Post -Uri "http://localhost:10001/api/internal/component/terminal" -Body ('$dashboardservice.setDashboard((
            New-UDDashboard -Title "Test" -Content {
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
        }))') -SessionVariable ss -ContentType "text/plain"
        
        $Cache:Driver.navigate().refresh()

        #Run some tests using selenium
        It "should show an error for chart" {
            $Target = Find-SeElement -Driver $Cache:Driver -Id "Chart"
            $Target.Text | Should be "Chart`r`nThe term 'New-UDTest' is not recognized as the name of a cmdlet, function, script file, or operable program. Check the spelling of the name, or if a path was included, verify that the path is correct and try again." 
        }

        It "should show an error for monitor" {
            $Target = Find-SeElement -Driver $Cache:Driver -Id "Monitor"
            $Target.Text | Should be "Monitor`r`nThe term 'New-UDTest' is not recognized as the name of a cmdlet, function, script file, or operable program. Check the spelling of the name, or if a path was included, verify that the path is correct and try again." 
        }

        It "should show an error for counter" {
            $Target = Find-SeElement -Driver $Cache:Driver -Id "Counter"
            $Target.Text | Should be "Counter`r`nThe term 'New-UDTest' is not recognized as the name of a cmdlet, function, script file, or operable program. Check the spelling of the name, or if a path was included, verify that the path is correct and try again." 
        }

        It "should show an error for grid" {
            $Target = Find-SeElement -Driver $Cache:Driver -Id "Grid"
            $Target.Text | Should be "Grid`r`nThe term 'New-UDTest' is not recognized as the name of a cmdlet, function, script file, or operable program. Check the spelling of the name, or if a path was included, verify that the path is correct and try again." 
        }
    }

    Context "Page" {
        Invoke-RestMethod -Method Post -Uri "http://localhost:10001/api/internal/component/terminal" -Body ('$dashboardservice.setDashboard((
            New-UDDashboard -Title "Test" -Pages @(
            New-UDPage -Id "Page" -Name "Home" -Content {
                New-UDTest
            }
        )))') -SessionVariable ss -ContentType "text/plain"
        
        $Cache:Driver.navigate().refresh()

        It "should show error for whole page" {
            $Target = Find-SeElement -Driver $Cache:Driver -Id "Page"
            $Target.Text | Should be "An error occurred on this page`r`nThe term 'New-UDTest' is not recognized as the name of a cmdlet, function, script file, or operable program. Check the spelling of the name, or if a path was included, verify that the path is correct and try again." 
        }
    }
}