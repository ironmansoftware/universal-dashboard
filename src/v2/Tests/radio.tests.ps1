Enter-SeUrl -Target $Driver -Url "$Address/Test/Radio"

Describe "New-UDRadio" {
    It 'selects first item' {
        Find-SeElement -Id 'first' -Driver $Driver | Invoke-SeClick -JavaScriptClick -Driver $Driver
        Find-SeElement -Id 'first' -Driver $Driver | Get-SeElementAttribute -Attribute "checked" | should be $true
    }

    It 'selects first item' {
        Find-SeElement -Id 'first2' -Driver $Driver | Invoke-SeClick -JavaScriptClick -Driver $Driver
        Get-TestData | Should be $true
    }

    It 'should have first item selected' {
        Find-SeElement -Id 'first3' -Driver $Driver | Get-SeElementAttribute -Attribute "checked" | should be $true
    }

    It 'should have first item selected' {
        Find-SeElement -Id 'first4' -Driver $Driver | Get-SeElementAttribute -Attribute  "disabled" | should be $true
    }
}