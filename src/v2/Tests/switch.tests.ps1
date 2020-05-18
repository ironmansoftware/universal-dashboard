Describe "New-UDSwitch" {
    Context "On" {
        Set-TestDashboard -Content {
            New-UDSwitch -On -Id 'switch'
        }

        It "should be checked" {
            Find-SeElement -Id 'switch' -Driver $Driver | Get-SeElementAttribute -Attribute "checked" | should be $true
        }
    }

    Context "Disabled" {
        Set-TestDashboard -Content {
            New-UDSwitch -Id 'switch' -Disabled
        }

        It "should be disabled" {
            Find-SeElement -Id 'switch' -Driver $Driver | Get-SeElementAttribute -Attribute "disabled" | should be $true
        }
    }

    Context "OnChange" {
        Set-TestDashboard -Content {
            New-UDSwitch -Id 'switch' -OnChange {
                Set-TestData -Data $true
            }
        }

        It "should be checked" {
            Find-SeElement -Id 'switch' -Driver $Driver | Invoke-SeClick -JavascriptCLick -Driver $Driver
            Get-TestData | Should be $true
        }
    }
}