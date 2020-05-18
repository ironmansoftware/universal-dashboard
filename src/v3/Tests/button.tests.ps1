Enter-SeUrl -Target $Driver -Url "$Address/Test/button"

Describe "button" {

    It 'works with argumentlist' {
        Find-SeElement -Id 'arugmentList' -Driver $Driver | Invoke-SeClick
        Get-TestData | Should be "Some Text"
    }

    It 'has default variant' {
        $Element = Find-SeElement -Id 'btnDefault' -Driver $Driver
        $Element.GetAttribute("class").Contains('MuiButton-contained') | should be $true
    }

    It 'has full width' {
        $Element = Find-SeElement -Id 'btnFullWidth' -Driver $Driver        
        $Element.GetAttribute("class").Contains('MuiButton-fullWidth') | should be $true
    }

    It 'has text variant' {
        $Element = Find-SeElement -Id 'btnText' -Driver $Driver
        $Element.GetAttribute("class").Contains('MuiButton-text') | should be $true
    }
    
    It 'has outlined variant' {
        $Element = Find-SeElement -Id 'btnOutlined' -Driver $Driver
        $Element.GetAttribute("class").Contains('MuiButton-outlined') | should be $true
    }

    It 'has a label' {
        (Find-SeElement -Id 'btnLabel' -Driver $Driver).Text | should be "Submit"
    }

    It 'has an icon' {
        Find-SeElement -ClassName 'fa-github' -Driver $Driver | should not be $null
    }

    It "should click and have test data" {
        Find-SeElement -Id 'btnClick' -Driver $Driver | Invoke-SeClick
        Get-TestData | Should be "OnClick"
    }

    It 'has small size' {
        $Element = Find-SeElement -Id 'btnSmall' -Driver $Driver
        $Element.GetAttribute("class").Contains('MuiButton-sizeSmall') | should be $true
    }
    
    It 'has small large' {
        $Element = Find-SeElement -Id 'btnLarge' -Driver $Driver
        $Element.GetAttribute("class").Contains('MuiButton-sizeLarge') | should be $true
    }
}