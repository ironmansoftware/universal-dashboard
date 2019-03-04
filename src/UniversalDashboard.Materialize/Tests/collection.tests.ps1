Describe "New-UDCollection" {
    Context "With Header" {
        Set-TestDashboard {
            New-UDCollection -Header "Header" -Content {}
        }

        It "has a header" {
            Find-SeElement -Driver $Driver -ClassName "with-header" | Should not be $null
            (Find-SeElement -Driver $Driver -ClassName "collection-header").Text | should be "Header"
        }
    }
}