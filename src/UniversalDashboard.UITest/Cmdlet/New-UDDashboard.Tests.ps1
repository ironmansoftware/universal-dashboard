. "$PSScriptRoot\..\TestFramework.ps1"

Describe "New-UDDashboard" {
    It "Should set properties" {
        $Dashboard = New-UDDashboard -Title "Test" -Content {  } -GeoLocation 

        $Dashboard.Title | Should be "Test"
        $Dashboard.GeoLocation | should be $true 
    }

    It "should set default page name when using content" {
        $Dashboard = New-UDDashboard -Title "Test" -Content {}

        $Dashboard.Pages[0].Name | should be "home"
    }

    It "should set pages" {
        $Page = New-UDPage -Name "Test" -Content {}

        $Dashboard = New-UDDashboard -Title "Test" -Pages @($Page)

        $Dashboard.Pages[0].Name | should be 'test'
    }
}