Enter-SeUrl -Target $Driver -Url "$Address/Test/expansion-panel"

Describe "expansion panel" {
    It 'has a label' {
        $Element = Find-SeElement -Id 'expTitle' -Driver $Driver | Select-Object -First 1
        $Element.FindElementByClassName('MuiTypography-root').Text | Should be "Hello"
    }

    It 'has a content' {
        Find-SeElement -Id 'expContent' -Driver $Driver | Select-Object -First 1 | Invoke-SeClick
        (Find-SeElement -Id 'expContentDiv' -Driver $Driver).Text | Should be "Hello"
    }
}