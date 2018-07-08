param([Switch]$Release)

if (-not $Release) {
    Import-Module "$PSScriptRoot\..\..\UniversalDashboard\bin\debug\UniversalDashboard.Community.psd1"
} else {
    Import-Module "$PSScriptRoot\..\..\output\UniversalDashboard.Community.psd1"
}

Get-UDDashboard | Stop-UDDashboard

Describe "Get-UDDashboard" {
    It "returns running dashboards" {
        Start-UDDashboard -Port 10001 -Content { New-UDDashboard -Title "Test" -Content {} }

        Get-UDDashboard | should not be $null
    }

    It "returns multiple running dashboards" {
        Start-UDDashboard -Port 10002 -Content { New-UDDashboard -Title "Test" -Content {} }
        Start-UDDashboard -Port 10003 -Content { New-UDDashboard -Title "Test" -Content {} }

        (Get-UDDashboard).COunt | should not be 2
    }

    It "retuns dashboard by name" {
        Start-UDDashboard -Name "test" -Port 10004 -Content { New-UDDashboard -Title "Test" -Content {} }
        Get-UDDashboard -Name "test" | should not be $null
    }
}