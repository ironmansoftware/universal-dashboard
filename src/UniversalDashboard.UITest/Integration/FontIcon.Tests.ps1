param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release

Import-Module $ModulePath -Force

Describe "Font Icons" {
    Context "Font Awesome Icons" {

        Invoke-RestMethod -Method Post -Uri "http://localhost:10001/api/internal/component/terminal" -Body ('$dashboardservice.setDashboard((
            New-UDDashboard -Title "Font Awesome Icons - Test" -Content {

            New-UDIcon -Icon github -Size 3x

        } -FontIconStyle FontAwesome
        ))') -SessionVariable ss -ContentType "text/plain"

        Start-Sleep 1
        $Cache:Driver.navigate().refresh()

        it "should have font-family of FontAwesome" {
            $font = (Find-SeElement -Driver $Cache:Driver -TagName 'style' | Get-SeElementAttribute -Attribute 'textContent') -match "font-family:FontAwesome" 
            $font.count | Should be 1
        }
    }

    Context "Font Awesome Icons - As default parameter value" {

        Invoke-RestMethod -Method Post -Uri "http://localhost:10001/api/internal/component/terminal" -Body ('$dashboardservice.setDashboard((
            New-UDDashboard -Title "Font Awesome Icons - Test" -Content {

            New-UDIcon -Icon github -Size 3x

        }
        ))') -SessionVariable ss -ContentType "text/plain"
        Start-Sleep 1
        $Cache:Driver.navigate().refresh()

        it "should have font-family of FontAwesome" {
            $font = (Find-SeElement -Driver $Cache:Driver -TagName 'style' | Get-SeElementAttribute -Attribute 'textContent') -match "font-family:FontAwesome" 
            $font.count | Should be 1
        }
    }

    Context "Line Awesome Icons" {
        Invoke-RestMethod -Method Post -Uri "http://localhost:10001/api/internal/component/terminal" -Body ('$dashboardservice.setDashboard((
            New-UDDashboard -Title "Icons8 Line Awesome Icons - Test" -Content {

            New-UDIcon -Icon github -Size 3x

        } -FontIconStyle LineAwesome
        ))') -SessionVariable ss -ContentType "text/plain"

        $Cache:Driver.navigate().refresh()

        it "should have font-family of LineAwesome" {
            $font = (Find-SeElement -Driver $Cache:Driver -TagName 'style' | Get-SeElementAttribute -Attribute 'textContent') -match "font-family:LineAwesome" 
            $font.count | Should be 1
        }
    }
}
