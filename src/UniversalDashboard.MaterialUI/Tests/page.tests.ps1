Enter-SeUrl -Target $Driver -Url "http://localhost:10000/NotFound"

Describe "page" {
    It 'has not found' {
        Find-SeElement -Id 'not-found' -Driver $Driver | should not be $null
    }

    It 'has named page' {
        Enter-SeUrl -Target $Driver -Url "http://localhost:10000/Named-Page"
        Find-SeElement -Id 'namedPage' -Driver $Driver | should not be $null
    }

    It 'has URL page' {
        Enter-SeUrl -Target $Driver -Url "http://localhost:10000/myurl"
        Find-SeElement -Id 'urlPage' -Driver $Driver | should not be $null
    }

    It 'has URL page with variable' {
        Enter-SeUrl -Target $Driver -Url "http://localhost:10000/myurl/123"
        (Find-SeElement -Id 'urlPageWithVariable' -Driver $Driver).Text | should be "123"
    }

    It 'has custom loading dialog' {
        Enter-SeUrl -Target $Driver -Url "http://localhost:10000/loading"
        (Find-SeElement -Id 'loading' -Driver $Driver).Text | should be "Loading..."
    }
}
