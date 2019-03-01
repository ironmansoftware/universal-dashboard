Describe "chips" {
    Context "label" {
        Set-TestDashboard {
            New-UDChip -Label "my Label" -Id "chip"
        }

        It 'has a label' {
            (Find-UDElement -Id 'chip' -Driver $Driver).Text | should be "my Label"
        }
    }
}