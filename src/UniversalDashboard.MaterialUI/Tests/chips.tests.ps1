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
}