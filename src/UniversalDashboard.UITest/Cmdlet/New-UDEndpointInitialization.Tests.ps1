. "$PSScriptRoot\..\TestFramework.ps1"

Describe "New-UDEndpointInitialization" {
    It "should not throw error if function does not exist" {
        New-UDEndpointInitialization -Function 'doesNotExist' | should not be $null
    }
}