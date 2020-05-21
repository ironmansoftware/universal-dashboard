Enter-SeUrl -Url "$Address/Test/Switch" -Target $Driver

Describe "New-UDSwitch" {
    It "should be checked" {
        Find-SeElement -Id 'switch1' -Driver $Driver | Get-SeElementAttribute -Attribute "checked" | should be $true
    }

    It "should be disabled" {
        Find-SeElement -Id 'switch2' -Driver $Driver | Get-SeElementAttribute -Attribute "disabled" | should be $true
    }

    It "should be checked" {
        Find-SeElement -Id 'switch3' -Driver $Driver | Invoke-SeClick -JavascriptCLick -Driver $Driver
        Get-TestData | Should be $true
    }
}