param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
Import-Module $ModulePath -Force

Describe "Out-UDGridData" {
    It "should serialize to JSON" {
        $Data = @(
            [PSCustomObject]@{
                Value1 = "1"
                Value2 = 1
            }
            [PSCustomObject]@{
                Value1 = "2"
                Value2 = 2
            }
            [PSCustomObject]@{
                Value1 = "3"
                Value2 = 3
            }
        )

        $GridData = $Data | Out-UDGridData | ConvertFrom-Json

        $GridData.recordsTotal | Should be 3
        $GridData.recordsFiltered | Should be 3
        $GridData.data[0].Value1 | should be "1"
        $GridData.data[0].Value2 | should be 1
        $GridData.data[1].Value1 | should be "2"
        $GridData.data[1].Value2 | should be 2
        $GridData.data[2].Value1 | should be "3"
        $GridData.data[2].Value2 | should be 3
    }

    It "should serialize UDElements correctly" {
        $Data = @(
            [PSCustomObject]@{
                Element = New-UDElement -Tag "div" -Attributes @{
                    attribu = "test"
                }
            }
        )

        $GridData = $Data | Out-UDGridData | ConvertFrom-Json

        $GridData.data[0].Element.Type | Should be 'element'
    }
}