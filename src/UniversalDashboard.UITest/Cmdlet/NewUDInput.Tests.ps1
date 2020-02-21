. "$PSScriptRoot\..\TestFramework.ps1"

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