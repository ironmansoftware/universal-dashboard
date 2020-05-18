Enter-SeUrl -Url "$Address/test/collection" -Target $Driver

Describe "New-UDCollection" {
    Context "With Header" {
        It "has a header" {
            Find-SeElement -Driver $Driver -ClassName "with-header" | Should not be $null
            (Find-SeElement -Driver $Driver -ClassName "collection-header").Text | should be "Header"
        }
    }
}