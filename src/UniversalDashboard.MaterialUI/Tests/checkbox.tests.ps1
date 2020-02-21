Enter-SeUrl -Target $Driver -Url "http://localhost:10000/checkbox"

Describe "checkbox" {
    It 'has a label' {
        $Element = Find-SeElement -Id 'chkLabel' -Driver $Driver
        $Element = $Element.FindElement([OpenQA.Selenium.By]::XPath('../../..'))
        $Element.FindElementByClassName('MuiFormControlLabel-label').Text | Should be "Demo"
    }

    It 'has a label placement start' {
        $Element = Find-SeElement -Id 'chkLabelPlacementStart' -Driver $Driver
        $Element = $Element.FindElement([OpenQA.Selenium.By]::XPath('../../..'))
        $Element.GetCssValue("flex-direction") | Should be "row-reverse"
    }

    It 'has a label placement top' {
        $Element = Find-SeElement -Id 'chkLabelPlacementTop' -Driver $Driver
        $Element = $Element.FindElement([OpenQA.Selenium.By]::XPath('../../..'))
        $Element.GetCssValue("flex-direction") | Should be "column-reverse"
    }

    It 'has a label placement bottom' {
        $Element = Find-SeElement -Id 'chkLabelPlacementBottom' -Driver $Driver
        $Element = $Element.FindElement([OpenQA.Selenium.By]::XPath('../../..'))
        $Element.GetCssValue("flex-direction") | Should be "column"
    }

    It 'has a label placement end' {
        $Element = Find-SeElement -Id 'chkLabelPlacementEnd' -Driver $Driver
        $Element = $Element.FindElement([OpenQA.Selenium.By]::XPath('../../..'))
        $Element.GetCssValue("flex-direction") | Should be "row"
    }

    It 'has an custom icon' {
        Find-SeElement -Id 'demo-checkbox-icon' -Driver $Driver | should not be $null
    }

    It 'has an checked custom icon' {
        Find-SeElement -Id 'btnCustomIcon' -Driver $Driver | Invoke-SeClick
        Find-SeElement -Id 'demo-checkbox-icon-checked' -Driver $Driver | should not be $null
    }

    
    It "should click and have test data" {
        Find-SeElement -Id 'chkChange' -Driver $Driver | Invoke-SeClick
        Get-TestData | Should be "OnChange"
    }

    It "should have custom color" {
        $Element = Find-SeElement -Id 'chkStyle' -Driver $Driver
        $Element.GetCssValue('color') | should be 'rgb(255, 192, 203)'
    }

    It "should be disabled" {
        $element = Find-SeElement -Id 'chkDisabled' -Driver $Driver
        Get-SeElementAttribute -Element $element -Attribute 'disabled' | should be $true
    }

    It "should be checked" {
        $element = Find-SeElement -Id 'chkChecked' -Driver $Driver
        Get-SeElementAttribute -Element $element -Attribute 'checked' | should be $true
    }

    It "should be checked and disabled" {
        $element = Find-SeElement -Id 'chkCheckedDisabled' -Driver $Driver
        Get-SeElementAttribute -Element $element -Attribute 'checked' | should be $true
        Get-SeElementAttribute -Element $element -Attribute 'disabled' | should be $true
    }
}