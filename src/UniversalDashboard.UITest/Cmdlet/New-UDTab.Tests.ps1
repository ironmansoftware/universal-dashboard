param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
Import-Module $ModulePath -Force
Describe "New-UDTab" {
    It "should support text parameter" {
        $Image = New-UDTab -Text 'hi' -Content {}
        $Image.Label | should be "hi"
    }

    It "should be plugin" {
        $Image = New-UDTab -Text 'hi' -Content {}
        $Image.isPlugin | should be $true
    }

    It "should have type of tab" {
        $Image = New-UDTab -Text 'hi' -Content {}
        $Image.type | should be 'tab'
    }
}