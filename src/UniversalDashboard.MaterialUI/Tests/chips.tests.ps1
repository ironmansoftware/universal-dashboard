Describe "chips" {
    Context "label" {
        Set-TestDashboard {
            New-UDChip -Label "my Label" -Id "chip"
        }

        It 'has a label' {
            (Find-SeElement -Id 'chip' -Driver $Driver).Text | should be "my Label"
        }
    }

    Context "icon" {
        Set-TestDashboard {
            $Icon = New-UDIcon -Icon 'user'
            New-UDChip -Label "my Label" -Id "chip" -Icon $Icon
        }

        It 'has an icon' {
            Find-SeElement -ClassName 'fa-user' -Driver $Driver | should not be $null
        }
    }

    Context "should click" {
        Set-TestDashboard {
            New-UDChip -Label "my Label" -Id "chip" -OnClick {
                Set-TestData -Data "OnClick"
            }
        }

        It "should click and have test data" {
            Find-SeElement -Id 'chip' -Driver $Driver | Invoke-SeClick
            Get-TestData | Should be "OnClick"
        }
    }

    Context "should delete" {
        Set-TestDashboard {
            New-UDChip -Label "my Label" -Id "chip" -OnDelete {
                Set-TestData -Data "OnDelete"
            }
        }

        It "should click delete and have test data" {
            Find-SeElement -TagName 'svg' -Driver $Driver | Invoke-SeClick
            Get-TestData | Should be "OnDelete"
        }
    }
}