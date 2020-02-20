Enter-SeUrl -Target $Driver -Url "http://localhost:10000/icon-button"

Describe "icon button" {
    It 'has content' {
        Find-SeElement -Id 'iconButtonContent' -Driver $Driver | should not be $null
    }

    It 'has an icon' {
        $Element = Find-SeElement -Id 'iconButtonIcon' -Driver $Driver 
        $Element.FindElementByTagName('svg').GetAttribute('data-icon') | should be "user"
    }

    It 'has backgroundColor and icon color' {
        $element = Find-SeElement -Id 'iconButtonStyle' -Driver $Driver 
        $element.GetCssValue('color') | should be 'rgb(33, 150, 243)'
    }

    It 'has an icon size of xs' {
        $Element = Find-SeElement -Id 'iconButtonxs' -Driver $Driver 
        $Element.FindElementByTagName('svg').GetAttribute('class').contains("fa-xs") | should be $true
    }
    It 'has an icon size of sm' {
        $Element = Find-SeElement -Id 'iconButtonsm' -Driver $Driver 
        $Element.FindElementByTagName('svg').GetAttribute('class').contains("fa-sm") | should be $true
    }
    It 'has an icon size of lg' {
        $Element = Find-SeElement -Id 'iconButtonlg' -Driver $Driver 
        $Element.FindElementByTagName('svg').GetAttribute('class').contains("fa-lg") | should be $true
    }
    It 'has an icon size of 2x' {
        $Element = Find-SeElement -Id 'iconButton2x' -Driver $Driver 
        $Element.FindElementByTagName('svg').GetAttribute('class').contains("fa-2x") | should be $true
    }
    It 'has an icon size of 3x' {
        $Element = Find-SeElement -Id 'iconButton3x' -Driver $Driver 
        $Element.FindElementByTagName('svg').GetAttribute('class').contains("fa-3x") | should be $true
    }
    It 'has an icon size of 4x' {
        $Element = Find-SeElement -Id 'iconButton4x' -Driver $Driver 
        $Element.FindElementByTagName('svg').GetAttribute('class').contains("fa-4x") | should be $true
    }
    It 'has an icon size of 5x' {
        $Element = Find-SeElement -Id 'iconButton5x' -Driver $Driver 
        $Element.FindElementByTagName('svg').GetAttribute('class').contains("fa-5x") | should be $true
    }
    It 'has an icon size of 6x' {
        $Element = Find-SeElement -Id 'iconButton6x' -Driver $Driver 
        $Element.FindElementByTagName('svg').GetAttribute('class').contains("fa-6x") | should be $true
    }
    It 'has an icon size of 7x' {
        $Element = Find-SeElement -Id 'iconButton7x' -Driver $Driver 
        $Element.FindElementByTagName('svg').GetAttribute('class').contains("fa-7x") | should be $true
    }
    It 'has an icon size of 8x' {
        $Element = Find-SeElement -Id 'iconButton8x' -Driver $Driver 
        $Element.FindElementByTagName('svg').GetAttribute('class').contains("fa-8x") | should be $true
    }
    It 'has an icon size of 9x' {
        $Element = Find-SeElement -Id 'iconButton9x' -Driver $Driver 
        $Element.FindElementByTagName('svg').GetAttribute('class').contains("fa-9x") | should be $true
    }
    It 'has an icon size of 10x' {
        $Element = Find-SeElement -Id 'iconButton10x' -Driver $Driver 
        $Element.FindElementByTagName('svg').GetAttribute('class').contains("fa-10x") | should be $true
    }

    It 'should click and have test data' {
        Find-SeElement -Id 'iconButtonOnClick' -Driver $Driver | Invoke-SeClick
        Get-TestData | Should be "OnClick"
    }
}