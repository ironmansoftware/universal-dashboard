param([Switch]$Release)

if (-not $Release) {
    Import-Module "$PSScriptRoot\..\..\UniversalDashboard\bin\debug\UniversalDashboard.Community.psd1"
} else {
    Import-Module "$PSScriptRoot\..\..\output\UniversalDashboard.Community.psd1"
}

Get-UDDashboard | Stop-UDDashboard

Describe "Start-UDDashboard" {
    It "starts the default dashboard" {
        Start-UDDashboard -Port 10000 | Should not be $null
    }

    Get-UDDashboard | Stop-UDDashboard

    It "starts a dashboard" {

        $Dashboard = New-UDDashboard -Title "Test" -Content { New-UDCard -Title "Test"}
        
        Start-UDDashboard -Dashboard $Dashboard -Port 10000 | Should not be $null
    }

}