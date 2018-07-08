param([Switch]$Release)

if (-not $Release) {
    Import-Module "$PSScriptRoot\..\..\UniversalDashboard\bin\debug\UniversalDashboard.Community.psd1"
} else {
    Import-Module "$PSScriptRoot\..\..\output\UniversalDashboard.Community.psd1"
}

Describe "New-UDInput" {
    It "parses ValidateSet attribute" {
        $Input = New-UDInput -Endpoint {
            param(
                [ValidateSet("Hey", "This", "Is", "Cool")]
                $Argument
            )
        }

        $Input.Fields[0].ValidOptions[0] | SHould be "Hey"
        $Input.Fields[0].ValidOptions[1] | SHould be "This"
        $Input.Fields[0].ValidOptions[2] | SHould be "Is"
        $Input.Fields[0].ValidOptions[3] | SHould be "Cool"
    }
}