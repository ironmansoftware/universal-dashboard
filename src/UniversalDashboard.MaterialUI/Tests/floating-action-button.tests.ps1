Enter-SeUrl -Target $Driver -Url "http://localhost:10000/floating-action-button"

Describe "floating action button" {
    It 'has a icon' {
        $Element = Find-SeElement -Id 'fabIcon' -Driver $Driver
        $Element.FindElementByTagName('svg').GetAttribute('data-icon') | Should be "user"
    }

    It 'clicks' {
        Find-SeElement -Id 'fabClick' -Driver $Driver | Invoke-SeClick
        Get-TestData | Should be "fabClick"
    }

    It 'has small size' {
        $Element = Find-SeElement -Id 'fabSmall' -Driver $Driver
        $Element.GetAttribute("class").Contains('MuiFab-sizeSmall') | should be $true
    }

    It 'has medium size' {
        $Element = Find-SeElement -Id 'fabMedium' -Driver $Driver
        $Element.GetAttribute("class").Contains('MuiFab-sizeMedium') | should be $true
    }
}