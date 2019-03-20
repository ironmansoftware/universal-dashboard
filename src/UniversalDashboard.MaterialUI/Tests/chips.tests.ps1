Describe "chips" {
    Context "label" {
        Set-TestDashboard {
            New-UDMuChip -Label "my Label" -Id "chip"
        }

        It 'has a label' {
            (Find-SeElement -Id 'chip' -Driver $Driver).Text | should be "my Label"
        }
    }

    Context "icon" {
        Set-TestDashboard {
            $Icon = New-UDMuIcon -Icon 'user' -Size sm -Style @{color = '#fff'}
            New-UDMuChip -Label "Demo User" -Id "chip" -Icon $Icon -OnClick {Show-UDToast -Message 'test'} -Clickable -Style @{backgroundColor = '#00838f'}
        }

        It 'has an icon' {
            Find-SeElement -ClassName 'fa-user' -Driver $Driver | should not be $null
        }
    }

    Context "should click" {
        Set-TestDashboard {
            New-UDMuChip -Label "my Label" -Id "chip" -OnClick {
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
            $Icon = New-UDMuIcon -Icon 'user_circle' -Size sm -Style @{color = '#fff'}
            New-UDMuChip -Label "my Label" -Id "chip" -Icon $Icon -OnDelete {
                Set-TestData -Data "OnDelete"
            } -Style @{backgroundColor = '#00838f'} 
            $Icon = New-UDMuIcon -Icon 'user_circle' -Size sm -Style @{color = '#2196f3'}
            New-UDMuChip -Label "my Label" -Id "dmeo" -Icon $Icon -OnDelete {
                Set-TestData -Data "OnDelete"
            } -Style @{borderColor = '#2196f3'} -Variant outlined
        }

        It "should click delete and have test data" {
            Find-SeElement -TagName 'svg' -Driver $Driver | Invoke-SeClick
            Get-TestData | Should be "OnDelete"
        }
    }
}