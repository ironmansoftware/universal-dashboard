Enter-SeUrl -Target $Driver -Url "http://localhost:10000/list"

Describe "list" {
    It 'has content' {
        Find-SeElement -Id 'listContent' -Driver $Driver | should not be $null
    }

    It 'has 5 list items' {
        (Find-SeElement -Id 'listContentItem' -Driver $Driver).count | should be 5
    }
}