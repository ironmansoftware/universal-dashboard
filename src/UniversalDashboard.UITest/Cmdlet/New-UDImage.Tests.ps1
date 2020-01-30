param([Switch]$Release)

. "$PSScriptRoot\..\TestFramework.ps1"
$ModulePath = Get-ModulePath -Release:$Release
Import-Module $ModulePath -Force
Describe "New-UDImage" {
    It "should support url parameter" {
        $Image = New-UDImage -Url http://www.google.com/image.png
        $Image.Attributes['src'] | Should be 'http://www.google.com/image.png'
    }

    It "should support path parameter"{
        (New-UDImage -Path $PSCommandPath).Attributes.Src | should not be $null
    }
}