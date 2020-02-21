Enter-SeUrl -Target $Driver -Url "http://localhost:10000/expansion-panel"

Describe "expansion panel" {
    It 'has a label' {
        $Element = Find-SeElement -Id 'expTitle' -Driver $Driver | Select-Object -First 1
        $Element.FindElementByClassName('MuiTypography-root').Text | Should be "Hello"
    }

    It 'has a content' {
        Find-SeElement -Id 'expContent' -Driver $Driver | Select-Object -First 1 | Invoke-SeClick
        (Find-SeElement -Id 'expContentDiv' -Driver $Driver).Text | Should be "Hello"
    }

    It 'has a endpoint' {
        Find-SeElement -Id 'expEndpoint' -Driver $Driver | Select-Object -First 1 | Invoke-SeClick
        (Find-SeElement -Id 'expEndpointDiv' -Driver $Driver).Text | Should be "Hello"
    }
}