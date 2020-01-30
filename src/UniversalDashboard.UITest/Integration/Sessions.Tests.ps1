param([Switch]$Release)

. "$PSScriptRoot\..\TestFramework.ps1"
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

Get-UDDashboard | Stop-UDDashboard

$Server = Start-UDDashboard -Port 10001 -Dashboard (New-UDDashboard -Title "Test" -Content {}) 
$Driver = Start-SeFirefox

Describe "Sessions" {

    Context "should have session object" {
        $Dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDElement -Tag 'div' -Id 'session' -Endpoint { $Session.Id }
        }

        $Server.DashboardService.SetDashboard($Dashboard)
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        It "should have session object" {
            $Element = Find-SeElement -Driver $Driver -Id 'session'
            $Element.Text | should not be ""
        }
    } 

    Context "Should remove sessions" {
        $Dashboard = New-UDDashboard -Title "Test" -Content {
            
        } -IdleTimeout ([TimeSpan]::FromSeconds(5))

        $Server.DashboardService.SetDashboard($Dashboard)
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        Start-sleep 2

        It "should timeout session" {

            Stop-SeDriver $Driver

            Start-Sleep 8

            $Dashboard = Get-UDDashboard
            $Dashboard.DashboardService.EndpointService.SessionManager.Sessions.Count | Should be 0
        }
    }
}

Stop-UDDashboard -Server $Server 