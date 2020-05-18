Enter-SeUrl -Target $Driver -Url "$Address/Test/checkbox"

Describe "Checkbox" {
    It "is checked" {
        (Find-SeElement -Id 'Test1' -Driver $Driver).GetAttribute("checked") | should be $true
    }

    It "is checked" {
        (Find-SeElement -Id 'Test2' -Driver $Driver).GetAttribute("disabled") | should be $true
    }

    It "is checked" {
        Find-SeElement -ClassName 'filled-in' -Driver $Driver | should not be $null
    }

    It "should check item" {
        $Element = Find-SeElement -Id 'Test4' -Driver $Driver 
        Invoke-SeClick -Element $Element -JavaScriptClick -Driver $Driver
        Get-TestData | should be $true

        Invoke-SeClick -Element $Element -JavaScriptClick -Driver $Driver
        Get-TestData | should be "False"
    }

    It "should check item" {
        $Element = Find-SeElement -Id 'Test5' -Driver $Driver 
        Invoke-SeClick -Element $Element -JavaScriptClick -Driver $Driver
        Start-Sleep 3

        (Find-SeElement -Id 'Result' -Driver $Driver).Text | Should be "true"
    }
}