param([Switch]$Release)

. "$PSScriptRoot\..\TestFramework.ps1"
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

Get-UDDashboard | Stop-UDDashboard

$Driver = Start-SeFirefox
$Server = Start-UDDashboard -Port 10001 

function Set-TestDashboard {
    param($Dashboard)

    $Server.DashboardService.SetDashboard($Dashboard)
    Enter-SeUrl -Url "http://localhost:$BrowserPort" -Driver $Driver 
}

Describe "New-UDSplitPane" {

    Context "creates split pane" {
        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDSplitPane -Content {
                New-UDHeading -Text "Content1"
                New-UDHeading -Text "Content2"
            }
        }
        
        Set-TestDashboard -Dashboard $dashboard

        It "should create a split pane" {
            Find-SeElement -Driver $Driver -ClassName "Resizer" | Should not be $null
        }
    }

    Context "creates horizontal split pane" {
        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDSplitPane -Direction horizontal -Content {
                New-UDHeading -Text "Content1"
                New-UDHeading -Text "Content2"
            }
        }
        
        Set-TestDashboard -Dashboard $dashboard

        It "should create a split pane" {
            Find-SeElement -Driver $Driver -ClassName "horizontal" | Should not be $null
        }
    }

    Context "3 items in split pane" {
        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDSplitPane -Direction horizontal -Content {
                New-UDHeading -Text "Content1"
                New-UDHeading -Text "Content2"
                New-UDHeading -Text "Content3"
            }
            New-UDElement -Content {} -Id 'test' -Tag div
        }
        
        Set-TestDashboard -Dashboard $dashboard

        It "should not blow up dashboard" {
            Find-SeElement -Driver $Driver -Id "test" | Should not be $null
        }
    }

    Stop-SeDriver $Driver
    Stop-UDDashboard $Server
}