Describe "New-UDRadio" {
    Context "should select item in group" {
        Set-TestDashboard -Content {
            New-UDRadio -Group '1' -Id 'first'
            New-UDRadio -Group '1' -Id 'second'
            New-UDRadio -Group '1' -Id 'third'
        }

        It 'selects first item' {
            Find-SeElement -Id 'first' -Driver $Driver | Invoke-SeClick -JavaScriptClick -Driver $Driver
            Find-SeElement -Id 'first' -Driver $Driver | Get-SeElementAttribute -Attribute "checked" | should be $true
        }
    }

    Context "onClick" {
        Set-TestDashboard -Content {
            New-UDRadio -Group '1' -Id 'first' -onChange { Set-TestData -Data $true }
            New-UDRadio -Group '1' -Id 'second'
            New-UDRadio -Group '1' -Id 'third'
        }

        It 'selects first item' {
            Find-SeElement -Id 'first' -Driver $Driver | Invoke-SeClick -JavaScriptClick -Driver $Driver
            Get-TestData | Should be $true
        }
    }

    Context "should be checked" {
        Set-TestDashboard -Content {
            New-UDRadio -Group '1' -Id 'first' -Checked
            New-UDRadio -Group '1' -Id 'second'
            New-UDRadio -Group '1' -Id 'third'
        }

        It 'should have first item selected' {
            Find-SeElement -Id 'first' -Driver $Driver | Get-SeElementAttribute -Attribute "checked" | should be $true
        }
    }

    Context "should be disabled" {
        Set-TestDashboard -Content {
            New-UDRadio -Group '1' -Id 'first' -Disabled
            New-UDRadio -Group '1' -Id 'second'
            New-UDRadio -Group '1' -Id 'third'
        }

        It 'should have first item selected' {
            Find-SeElement -Id 'first' -Driver $Driver | Get-SeElementAttribute -Attribute  "disabled" | should be $true
        }
    }
}