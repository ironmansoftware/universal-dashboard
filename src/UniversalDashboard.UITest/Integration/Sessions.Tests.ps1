param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

Get-UDDashboard | Stop-UDDashboard

$Server = Start-UDDashboard -Port 10001 -Dashboard (New-UDDashboard -Title "Test" -Content {}) 
$Driver = Start-SeFirefox

Describe "Sessions" {

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

Stop-SeDriver $Driver
Stop-UDDashboard -Server $Server 