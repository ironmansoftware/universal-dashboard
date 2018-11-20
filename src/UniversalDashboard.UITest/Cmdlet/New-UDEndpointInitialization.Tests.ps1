param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
Import-Module $ModulePath -Force

Describe "New-UDEndpointInitialization" {
    It "should not throw error if function does not exist" {
        New-UDEndpointInitialization -Function 'doesNotExist' | should not be $null
    }
}