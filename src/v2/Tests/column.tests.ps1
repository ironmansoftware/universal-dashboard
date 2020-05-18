Enter-SeUrl -Url "$Address/test/column" -Target $Driver

Describe "New-UDColumn" {
    It "has a small size" {
        Find-SeElement -ClassName "s12" -Driver $Driver | should not be $null
    }

    It "has a medium size" {
        Find-SeElement -ClassName "m12" -Driver $Driver | should not be $null
    }

    It "has a large size" {
        Find-SeElement -ClassName "l12" -Driver $Driver | should not be $null
    }

    It "has a small size" {
        Find-SeElement -ClassName "offset-s6" -Driver $Driver | should not be $null
    }

    It "has a medium offset" {
        Find-SeElement -ClassName "offset-m6" -Driver $Driver | should not be $null
    }

    It "has a large offset" {
        Find-SeElement -ClassName "offset-l6" -Driver $Driver | should not be $null
    }

    It "has a small size" {
        Find-SeElement -ClassName "s12" -Driver $Driver | should not be $null
    }

    It "has id" {
        Find-SeElement -Id "myCol" -Driver $Driver | should not be $null
    }

    It "has content" {
        Find-SeElement -Id "card" -Driver $Driver | should not be $null
    }

    It "has content from endpoint" {
        Find-SeElement -Id "card2" -Driver $Driver | should not be $null
    }
}