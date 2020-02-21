Enter-SeUrl -Target $Driver -Url "http://localhost:10000/switch"

Describe "Switch" {
    It 'is not checked' {
        (Find-SeElement -Id 'switchOff' -Driver $Driver).GetAttribute("value") | should be ""
    }

    It 'is not checked explicit' {
        (Find-SeElement -Id 'switchOffExplicit' -Driver $Driver).GetAttribute("value") | should be ""
    }

    It 'is checked' {
        (Find-SeElement -Id 'switchOn' -Driver $Driver).GetAttribute("checked") | should be $true
    }

    It 'should send test data' {
        Find-SeElement -Id 'switchOnChange' -Driver $Driver | Invoke-SeClick
        Get-TestData | should be $true
    }

    It 'should be disabled' {
        (Find-SeElement -Id 'switchDisabled' -Driver $Driver).GetAttribute("disabled") | should be $true
    }
}