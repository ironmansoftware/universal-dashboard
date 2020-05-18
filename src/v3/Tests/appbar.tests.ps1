Enter-SeUrl -Target $Driver -Url "$Address/Test/AppBar"

Describe 'AppBar' {
    It 'has custom navigation' {
        Find-SeElement -Id 'btndrawer' -Driver $Driver | Invoke-SeClick
        Find-SeElement -Id 'lstHome' -Driver $Driver | Invoke-SeClick
        Get-TestData | should be "Home"
    }

    It 'has nested navigation' {
        Find-SeElement -TagName 'body' -Driver $Driver | Invoke-SeClick
        Find-SeElement -Id 'btndrawer' -Driver $Driver | Invoke-SeClick
        Find-SeElement -Id 'lstHome' -Driver $Driver | Invoke-SeClick
        Get-TestData | should be "Home"
        Find-SeElement -id 'lstNested' -Driver $Driver | Invoke-SeClick
        Get-TestData | should be "Nested"
    }
}