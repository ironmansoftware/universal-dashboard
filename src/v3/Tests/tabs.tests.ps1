Enter-SeUrl -Target $Driver -Url "$Address/Test/tabs"

Describe "tabs" {
    It 'has multiple tabs' {
        $Element = Find-SeElement -Id 'Tab1' -Driver $Driver | Invoke-SeClick 
        $Element = Find-SeElement -Id 'tab1Content' -Driver $Driver
        $Element.FindElementByXPath("..").GetAttribute("style") | Should be "display: block;"

        $Element = Find-SeElement -Id 'Tab2' -Driver $Driver | Invoke-SeClick 
        $Element = Find-SeElement -Id 'tab2Content' -Driver $Driver
        $Element.FindElementByXPath("..").GetAttribute("style") | Should be "display: block;"

        $Element = Find-SeElement -Id 'Tab3' -Driver $Driver | Invoke-SeClick 
        $Element = Find-SeElement -Id 'tab3Content' -Driver $Driver
        $Element.FindElementByXPath("..").GetAttribute("style") | Should be "display: block;"
    }

    It 'loads tabs on click' {
        Find-SeElement -Id 'DynamicTab1' -Driver $Driver | Invoke-SeClick 
        $Tab1Text = (Find-SeElement -Id 'DynamicTab1Content' -Driver $Driver).Text

        Find-SeElement -Id 'DynamicTab2' -Driver $Driver | Invoke-SeClick 
        $Tab2Text = (Find-SeElement -Id 'DynamicTab2Content' -Driver $Driver).Text

        $Tab1Text | should not be $Tab2Text

        Find-SeElement -Id 'DynamicTab1' -Driver $Driver | Invoke-SeClick 
        $Tab1TextNew = (Find-SeElement -Id 'DynamicTab1Content' -Driver $Driver).Text

        $Tab1Text | should not be $Tab1TextNew
    }

    It 'has vertical tabs' {
        (Find-SeElement -Id 'verticalTabs' -Driver $Driver).FindElementByClassName('MuiTabs-flexContainerVertical') | should not be $null
    }
}