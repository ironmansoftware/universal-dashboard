param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
Import-Module $ModulePath -Force

Describe "Get-UDDashboard" {
    It "returns running dashboards" {
        Get-UDDashboard | should not be $null
    }

    It "returns multiple running dashboards" {
        Start-UDDashboard -Port 10003 -Name 'D3' -Content { New-UDDashboard -Title "Test" -Content {} }
        Start-UDDashboard -Port 10004 -Name 'D4' -Content { New-UDDashboard -Title "Test" -Content {} }

        (Get-UDDashboard).COunt | should not be 2

        Stop-UDDashboard -Name 'D3'
        Stop-UDDashboard -Name 'D4'
    }

    It "retuns dashboard by name" {
        Get-UDDashboard -Name "Dashboard_For_Tests" | should not be $null
    }
}