Enter-SeUrl -Target $Driver -Url "http://localhost:10000/NotFound"

Describe "page" {
    It 'has not found' {
        Find-SeElement -Id 'not-found' -Driver $Driver | should not be $null
    }
}
