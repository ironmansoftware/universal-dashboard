param([Switch]$Release)

. "$PSScriptRoot\..\TestFramework.ps1"
$ModulePath = Get-ModulePath -Release:$Release
Import-Module $ModulePath -Force

Describe "New-UDDashboard" {
    It "Should set properties" {
        $Dashboard = New-UDDashboard -Title "Test" -Content { New-UDCard -Title "test" } -NavBarColor Black -NavBarFontColor Black -BackgroundColor Black -FontColor Black -GeoLocation 

        $Dashboard.Title | Should be "Test"
        $Dashboard.NavBarColor | should be "rgba(0, 0, 0, 1)"
        $Dashboard.NavBarFontColor | should be "rgba(0, 0, 0, 1)"
        $Dashboard.BackgroundColor | should be "rgba(0, 0, 0, 1)"
        $Dashboard.FontColor | should be "rgba(0, 0, 0, 1)"
        $Dashboard.GeoLocation | should be $true 
    }

    It "should set default page name when using content" {
        $Dashboard = New-UDDashboard -Title "Test" -Content {}

        $Dashboard.Pages[0].Name | should be "home"
    }

    It "should add components to default page" {
        $Dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDCard -Title "Test"
        }

        $Dashboard.Pages[0].components[0].Type | should be "element"
    }

    It "should set pages" {
        $Page = New-UDPage -Name "Test" -Content {}

        $Dashboard = New-UDDashboard -Title "Test" -Pages @($Page)

        $Dashboard.Pages[0].Name | should be 'test'
    }
}