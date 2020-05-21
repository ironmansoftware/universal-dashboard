Describe "Select" {
    It "should select item" {
        $Element = Find-SeElement -Id "largeSelectTest" -Target $Driver
        $Element = Find-SeElement -ClassName "select-wrapper" -Target $Element | Select-Object -First 1
        Invoke-SeClick -Element $Element

        Start-Sleep 1
        
        $Element = Find-SeElement -XPath "//ul/li" -Element $Element | Select-Object -Skip 149 -First 1
        Invoke-SeClick -Element $Element

        Get-TestData | Should be "150"
    }

    It "should select item" {
        $Element = Find-SeElement -Id "onSelectTest" -Target $Driver
        $Element = Find-SeElement -ClassName "select-wrapper" -Target $Element | Select-Object -First 1
        Invoke-SeClick -Element $Element

        Start-Sleep 1
        
        $Element = Find-SeElement -XPath "//ul/li" -Element $Element | Select-Object -Skip 1 -First 1
        Invoke-SeClick -Element $Element

        Get-TestData | Should be "2"
    }

    It "should select item and get it with Get-UDElement" {
        $Element = Find-SeElement -Id "onSelectTest" -Target $Driver
        $Element = Find-SeElement -ClassName "select-wrapper" -Target $Element | Select-Object -First 1
        Invoke-SeClick -Element $Element

        Start-Sleep 1
        
        $Element = Find-SeElement -XPath "//ul/li" -Element $Element | Select-Object -Skip 2 -First 1
        Invoke-SeClick -Element $Element

        $Button = Find-SeElement -Driver $Driver -Id 'btn'
        Invoke-SeClick -Element $Button

        Get-TestData | Should be "3"
    }

    It "should select item and get it with Get-UDElement" {
        $Element = Find-SeElement -Id "getElementTest" -Target $Driver
        $Element = Find-SeElement -ClassName "select-wrapper" -Target $Element | Select-Object -First 1
        Invoke-SeClick -Element $Element

        Start-Sleep 1
        
        $Element = Find-SeElement -XPath "//ul/li" -Element $Element | Select-Object -Skip 2 -First 1
        Invoke-SeClick -Element $Element

        $Button = Find-SeElement -Driver $Driver -Id 'btn3'
        Invoke-SeClick -Element $Button

        Get-TestData | Should be "3"
    }
}