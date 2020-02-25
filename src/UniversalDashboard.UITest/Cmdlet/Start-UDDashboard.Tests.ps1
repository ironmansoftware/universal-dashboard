. "$PSScriptRoot\..\TestFramework.ps1"

Describe "Start-UDDashboard" {
    It "starts the default dashboard" {
        Start-UDDashboard -Port 10001 -Dashboard (New-UDDashboard -Title 'hey' -Content{}) -Force | Should not be $null
    }

    It "starts a dashboard" {
        $Dashboard = New-UDDashboard -Title "Test" -Content { }
        Start-UDDashboard -Dashboard $Dashboard -Port 10001 -Force | Should not be $null
    }

}