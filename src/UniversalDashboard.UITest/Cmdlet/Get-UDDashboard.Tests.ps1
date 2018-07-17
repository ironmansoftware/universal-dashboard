param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
Import-Module $ModulePath -Force

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