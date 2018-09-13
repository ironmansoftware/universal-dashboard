param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

Get-UDDashboard | Stop-UDDashboard


Describe "Font Icons" {
    Context "Font Awesome Icons" {

        $Dashboard = New-UDDashboard -Title "Font Awesome Icons - Test" -Content {

            New-UDIcon -Icon github -Size 3x

        } -FontIconStyle FontAwesome

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        it "should have font-family of FontAwesome" {
            ((Find-SeElement -Driver $driver -TagName 'style')[-1] | Get-SeElementAttribute -Attribute 'textContent') -match "font-family:FontAwesome" | Should be $true
        }

        Stop-SeDriver $Driver
        Stop-UDDashboard -Server $Server 
    }

    Context "Font Awesome Icons - As default parameter value" {

        $Dashboard = New-UDDashboard -Title "Font Awesome Icons - Test" -Content {

            New-UDIcon -Icon github -Size 3x

        }

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        it "should have font-family of FontAwesome" {
            ((Find-SeElement -Driver $driver -TagName 'style')[-1] | Get-SeElementAttribute -Attribute 'textContent') -match "font-family:FontAwesome" | Should be $true
        }

        Stop-SeDriver $Driver
        Stop-UDDashboard -Server $Server 
    }

    Context "Line Awesome Icons" {
        $Dashboard = New-UDDashboard -Title "Icons8 Line Awesome Icons - Test" -Content {

            New-UDIcon -Icon github -Size 3x

        } -FontIconStyle LineAwesome

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        it "should have font-family of LineAwesome" {
            ((Find-SeElement -Driver $driver -TagName 'style')[-1] | Get-SeElementAttribute -Attribute 'textContent') -match "font-family:LineAwesome" | Should be $true
        }

        Stop-SeDriver $Driver
        Stop-UDDashboard -Server $Server 
    }
}
