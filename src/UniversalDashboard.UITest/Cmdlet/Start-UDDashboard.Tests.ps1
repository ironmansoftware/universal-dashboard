param([Switch]$Release)

. "$PSScriptRoot\..\TestFramework.ps1"
$ModulePath = Get-ModulePath -Release:$Release
Import-Module $ModulePath -Force

Get-UDDashboard | Stop-UDDashboard

Describe "Start-UDDashboard" {
    It "starts the default dashboard" {
        Start-UDDashboard -Port 10000 -Content {} | Should not be $null
    }

    Get-UDDashboard | Stop-UDDashboard

    It "starts a dashboard" {

        $Dashboard = New-UDDashboard -Title "Test" -Content { }
        
        Start-UDDashboard -Dashboard $Dashboard -Port 10000 | Should not be $null
    }

}