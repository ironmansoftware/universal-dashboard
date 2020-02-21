Enter-SeUrl -Target $Driver -Url "http://localhost:10000/icon"

Describe "icon" {
    It 'has content' {
        Find-SeElement -Id 'iconContent' -Driver $Driver | should not be $null
    }

    It 'has an solid icon' {
        $Element = Find-SeElement -Id 'iconRegular' -Driver $Driver
        Find-SeElement -ClassName 'fa-angry' -Target $Element | should not be $null
    }

    It 'has an regular type icon' {
        $Element = Find-SeElement -Id 'iconRegular' -Driver $Driver
        $element = Find-SeElement -ClassName 'fa-angry' -Target $Element
        Get-SeElementAttribute -Element $element -Attribute 'data-prefix' | should be 'far'
    }

    It 'has an regular type icon' {
        $Element = Find-SeElement -Id 'iconFallback' -Driver $Driver
        $element = Find-SeElement -ClassName 'fa-box' -Target $Element
        Get-SeElementAttribute -Element $element -Attribute 'data-prefix' | should be 'fas'
    }

    It 'has backgroundColor and icon color' {
        $Element = Find-SeElement -Id 'iconStyle' -Driver $Driver
        $element = Find-SeElement -ClassName 'fa-user' -Target $Element
        $element.GetCssValue('color') | should be 'rgb(33, 150, 243)'
    }

    It 'has an icon size of xs' {
        Find-SeElement -ClassName 'fa-xs' -Driver $Driver | should not be $null
    }
    It 'has an icon size of sm' {
        Find-SeElement -ClassName 'fa-sm' -Driver $Driver | should not be $null
    }
    It 'has an icon size of lg' {
        Find-SeElement -ClassName 'fa-lg' -Driver $Driver | should not be $null
    }
    It 'has an icon size of 2x' {
        Find-SeElement -ClassName 'fa-2x' -Driver $Driver | should not be $null
    }
    It 'has an icon size of 3x' {
        Find-SeElement -ClassName 'fa-3x' -Driver $Driver | should not be $null
    }
    It 'has an icon size of 4x' {
        Find-SeElement -ClassName 'fa-4x' -Driver $Driver | should not be $null
    }
    It 'has an icon size of 5x' {
        Find-SeElement -ClassName 'fa-5x' -Driver $Driver | should not be $null
    }
    It 'has an icon size of 6x' {
        Find-SeElement -ClassName 'fa-6x' -Driver $Driver | should not be $null
    }
    It 'has an icon size of 7x' {
        Find-SeElement -ClassName 'fa-7x' -Driver $Driver | should not be $null
    }
    It 'has an icon size of 8x' {
        Find-SeElement -ClassName 'fa-8x' -Driver $Driver | should not be $null
    }
    It 'has an icon size of 9x' {
        Find-SeElement -ClassName 'fa-9x' -Driver $Driver | should not be $null
    }
    It 'has an icon size of 10x' {
        Find-SeElement -ClassName 'fa-10x' -Driver $Driver | should not be $null
    }
}