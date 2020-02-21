. "$PSScriptRoot\..\TestFramework.ps1"

Describe "Sessions" {

    Context "should have session object" {
        $Dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDElement -Tag 'div' -Id 'session' -Endpoint { $Session.Id }
        }

        Start-UDDashboard -Dashboard $Dashboard -Port 10001 -Force
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        It "should have session object" {
            $Element = Find-SeElement -Driver $Driver -Id 'session'
            $Element.Text | should not be ""
        }
    } 

    Context "Should remove sessions" {
        $Dashboard = New-UDDashboard -Title "Test" -Content {
            
        } -IdleTimeout ([TimeSpan]::FromSeconds(5))

        Start-UDDashboard -Dashboard $Dashboard -Port 10001 -Force
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