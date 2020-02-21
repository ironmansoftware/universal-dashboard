Enter-SeUrl -Target $Driver -Url "http://localhost:10000/chips"

Describe "chips" {
    It 'has a label' {
        (Find-SeElement -Id 'chipLabel' -Driver $Driver).Text | should be "my Label"
    }

    It 'has an icon' {
        $Element = Find-SeElement -Id 'chipIcon' -Driver $Driver
        $Element.FindElementByTagName("svg").GetAttribute("data-icon") | Should be "user"
    }

    It "should click and have test data" {
        Find-SeElement -Id 'chipClick' -Driver $Driver | Invoke-SeClick
        Get-TestData | Should be "chipClick"
    }

    It "should click delete and have test data" {
        $Element = Find-SeElement -Id 'chipDelete' -Driver $Driver
        $Element.FindElementByClassName("MuiChip-deleteIcon") | Invoke-SeClick
        Get-TestData | Should be "chipDelete"
    }
}