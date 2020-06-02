Enter-SeUrl -Target $Driver -Url "$Address/Test/Row"

Describe "New-UDRow" {
    It "should have content" {
        Find-SeElement -Id "hi" -Driver $Driver | Should not be $null
    }

    It "should have content" {
        Find-SeElement -Id "hi2" -Driver $Driver | Should not be $null
    }

    It "should have an ID" {
        Find-SeElement -Id "MyRow" -Driver $Driver | Should not be $null
    }
}