. "$PSScriptRoot\..\TestFramework.ps1"

Describe "Get-UDDashboard" {
    It "returns running dashboards" {
        Start-UDDashboard -Port 10001 -Content { New-UDDashboard -Title "Test" -Content {} } -Force

        Get-UDDashboard | should not be $null
    }

    It "returns multiple running dashboards" -skip {
        Start-UDDashboard -Port 10001 -Content { New-UDDashboard -Title "Test" -Content {} } -Force
        Start-UDDashboard -Port 10002 -Content { New-UDDashboard -Title "Test" -Content {} } -Force

        (Get-UDDashboard).COunt | should be 2
    }

    It "retuns dashboard by name" {
        Start-UDDashboard -Name "test" -Port 10001 -Content { New-UDDashboard -Title "Test" -Content {} } -Force
        Get-UDDashboard -Name "test" | should not be $null
    }
}