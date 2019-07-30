Describe "Checkbox" {
    Context "Checked" {
        Set-TestDashboard {
            New-UDCheckbox -Id 'Test' -Label 'Check me' -Checked 
        }
        
        It "is checked" {
            (Find-SeElement -Id 'Test' -Driver $Driver).GetAttribute("checked") | should be $true
        }
    }

    Context "Disabled" {
        Set-TestDashboard {
            New-UDCheckbox -Id 'Test' -Label 'Check me' -Disabled 
        }
        
        It "is checked" {
            (Find-SeElement -Id 'Test' -Driver $Driver).GetAttribute("disabled") | should be $true
        }
    }

    Context "Filled in" {
        Set-TestDashboard {
            New-UDCheckbox -Id 'Test' -Label 'Check me' -FilledIn 
        }
        
        It "is checked" {
            Find-SeElement -ClassName 'filled-in' -Driver $Driver | should not be $null
        }
    }

    Context "OnChange" {
        Set-TestDashboard {
            New-UDCheckbox -Id "Test" -Label "Check me" -OnChange {
                Set-TestData -Data $true
            }
        }

        It "should check item" {
            $Element = Find-SeElement -Id 'Test' -Driver $Driver 
            Invoke-SeClick -Element $Element -JavaScriptClick -Driver $Driver
            Start-Sleep 1

            Get-TestData | should be $true
        }
    }

    Context "Get-UDElement" {
        Set-TestDashboard {
            New-UDCheckbox -Id "Test" -Label "Check me" 

            New-UDElement -Tag div -Id 'Result' -Endpoint {
                try {
                    New-UDElement -Tag div -Content { (Get-UDElement -Id 'Test').Attributes['checked'].ToString() }
                }
                catch {

                }
            } -AutoRefresh -RefreshInterval 1
        }

        It "should check item" {
            $Element = Find-SeElement -Id 'Test' -Driver $Driver 
            Invoke-SeClick -Element $Element -JavaScriptClick -Driver $Driver
            Start-Sleep 3

            (Find-SeElement -Id 'Result' -Driver $Driver).Text | Should be "true"
        }
    }
}