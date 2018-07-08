param([Switch]$Release)

if (-not $Release) {
    Import-Module "$PSScriptRoot\..\..\UniversalDashboard\bin\debug\UniversalDashboard.Community.psd1"
} else {
    Import-Module "$PSScriptRoot\..\..\output\UniversalDashboard.Community.psd1"
}

Describe "New-UDElement" {
    It "should set properties" {
        $Element = New-UDElement -Tag "a" -Attributes @{
            className = "test"
        } -Content {
            "test"
        } -Id "Test"

        $Element.Id | Should be 'test'
        $Element.Tag | should be "a"
        $Element.Attributes.className | Should be "test"
        $Element.Content | should be "test"
    }

    It "should add event handlers" {
        $Element = New-UDElement -Tag "a" -Attributes @{
            onClick = {gps}
        }
        $Element.Events[0].Event | should be "onClick"
        $Element.Attributes.ContainsKey("onClick") | should be $false
    }
}