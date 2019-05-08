Describe "checkbox" {
    Context "label" {
        Set-TestDashboard {
            New-UDMuCheckBox -Label 'Demo' -Id 'demo-checkbox' -OnChange {}
        }

        It 'has a label' {
            Find-SeElement -ClassName 'ud-mu-checkbox' -Driver $Driver | Invoke-SeClick
            (Find-SeElement -TagName 'label' -Driver $Driver).Text | should be "Demo"
        }
    }

    Context "label placement - start" {
        Set-TestDashboard {
            New-UDMuCheckBox -Label 'Demo' -Id 'demo-checkbox' -OnChange {} -LabelPlacement start
        }

        It 'has a label position in the start' {
            $element = Find-SeElement -TagName 'label' -Driver $Driver
            $element.GetCssValue('flex-direction') | Should be 'row-reverse'
        }
    }

    Context "label placement - top" {
        Set-TestDashboard {
            New-UDMuCheckBox -Label 'Demo' -Id 'demo-checkbox' -OnChange {} -LabelPlacement top
        }

        It 'has a label position in the top' {
            $element = Find-SeElement -TagName 'label' -Driver $Driver
            $element.GetCssValue('flex-direction') | Should be 'column-reverse'
        }
    }

    Context "label placement - bottom" {
        Set-TestDashboard {
            New-UDMuCheckBox -Label 'Demo' -Id 'demo-checkbox' -OnChange {} -LabelPlacement bottom
        }

        It 'has a label position in the bottom' {
            $element = Find-SeElement -TagName 'label' -Driver $Driver
            $element.GetCssValue('flex-direction') | Should be 'column'
        }
    }

    Context "label placement - end" {
        Set-TestDashboard {
            New-UDMuCheckBox -Label 'Demo' -Id 'demo-checkbox' -OnChange {} -LabelPlacement end
        }

        It 'has a label position in the end' {
            $element = Find-SeElement -TagName 'label' -Driver $Driver
            $element.GetCssValue('flex-direction') | Should be 'row'
        }
    }

    Context "custom icon" {
        Set-TestDashboard {
            $Icon = New-UDIcon -Icon angry -Size lg  -Id 'demo-checkbox-icon' -Regular
            $CheckedIcon = New-UDIcon -Icon angry -Size lg  -Id 'demo-checkbox-icon-checked' 
            New-UDMuCheckBox -Id 'demo-checkbox' -Icon $Icon -CheckedIcon $CheckedIcon -OnChange {} -Style @{color = '#2196f3'}
        }

        It 'has an custom icon' {
            $element = Find-SeElement -ClassName 'fa-angry' -Driver $Driver
            Get-SeElementAttribute -Element $element -Attribute 'data-prefix' | should be 'far'
        }

        It 'has an checked custom icon' {
            Find-SeElement -ClassName 'ud-mu-checkbox' -Driver $Driver | Invoke-SeClick
            $element = Find-SeElement -ClassName 'fa-angry' -Driver $Driver
            Get-SeElementAttribute -Element $element -Attribute 'data-prefix' | should be 'fas'
        }
    }

    Context "event" {
        Set-TestDashboard {
            $Icon = New-UDIcon -Icon circle -Size lg -Id 'demo-checkbox-icon' -Regular
            $CheckedIcon = New-UDIcon -Icon check_circle -Size lg  -Id 'demo-checkbox-icon-checked' 
            New-UDMuCheckBox -Id 'demo-checkbox' -Icon $Icon -CheckedIcon $CheckedIcon -OnChange {
                Set-TestData -Data "OnChange"
            }
        }

        It "should click and have test data" {
            Find-SeElement -ClassName 'ud-mu-checkbox' -Driver $Driver | Invoke-SeClick
            Get-TestData | Should be "OnChange"
        }
    }

    Context "style" {
        Set-TestDashboard {
            $Icon = New-UDIcon -Icon heart  -Id 'demo-checkbox-icon' -Regular
            $CheckedIcon = New-UDIcon -Icon heart  -Id 'demo-checkbox-icon-checked' 
            New-UDMuCheckBox -Id 'demo-checkbox' -Icon $Icon -CheckedIcon $CheckedIcon -OnChange {
                Set-TestData -Data "OnChange"
            } -Style @{color = 'pink'} -Label "I'm in love"
        }

        It "should have custom color" {
            Find-SeElement -ClassName 'ud-mu-checkbox' -Driver $Driver | Invoke-SeClick
            Get-TestData | Should be "OnChange"
        }
    }

    Context "disabled" {
        Set-TestDashboard {
            $Icon = New-UDIcon -Icon heart  -Id 'demo-checkbox-icon' -Regular
            $CheckedIcon = New-UDIcon -Icon heart  -Id 'demo-checkbox-icon-checked' 
            New-UDMuCheckBox -Id 'demo-checkbox' -Icon $Icon -CheckedIcon $CheckedIcon -OnChange {
                Set-TestData -Data "OnChange"
            } -Disabled

            New-UDMuCheckBox -Id 'demo-checkbox-1' -OnChange {
                Set-TestData -Data "OnChange"
            } -Disabled
        }

        It "should be disabled" {
            $element = Find-SeElement -Id 'demo-checkbox' -Driver $Driver
            Get-SeElementAttribute -Element $element -Attribute 'disabled' | should be $true
            $element1 = Find-SeElement -Id 'demo-checkbox-1' -Driver $Driver
            Get-SeElementAttribute -Element $element1 -Attribute 'disabled' | should be $true
        }
    }

    Context "checked" {
        Set-TestDashboard {
            New-UDMuCheckBox -Id 'demo-checkbox' -OnChange {
                Set-TestData -Data "OnChange"
            } -Style @{color = '#2196f3'} -Checked
        }

        It "should be checked" {
            $element = Find-SeElement -Id 'demo-checkbox' -Driver $Driver
            Get-SeElementAttribute -Element $element -Attribute 'checked' | should be $true
        }
    }

    Context "checked and disabled" {
        Set-TestDashboard {
            New-UDMuCheckBox -Id 'demo-checkbox' -OnChange {
                Set-TestData -Data "OnChange"
            } -Style @{color = '#2196f3'} -Checked -Disabled
        }

        It "should be checked" {
            $element = Find-SeElement -Id 'demo-checkbox' -Driver $Driver
            Get-SeElementAttribute -Element $element -Attribute 'checked' | should be $true
            Get-SeElementAttribute -Element $element -Attribute 'disabled' | should be $true
        }
    }
}