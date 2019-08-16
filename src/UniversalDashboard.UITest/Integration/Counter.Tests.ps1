param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

Get-UDDashboard | Stop-UDDashboard

Describe "Counter" {
    Context "Custom Counter" {
        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDCounter -Title "Test" -Id "Counter" -TextAlignment Left -TextSize Small -Icon user -Endpoint {
                1000
            } -OnClick {
                Set-TestData -Data 'Counter OnClick Event'
            }

        }

        It "should have counter" {
            Find-SeElement -Id "Counter" -Driver $Driver | Should not be $null
        }

        Invoke-SeClick -Element (Find-SeElement -Id 'Counter' -Driver $Driver)

        It "should have OnClick event" {
            Get-TestData | Should -Be 'Counter OnClick Event'
        }

       Stop-SeDriver $Driver
       Stop-UDDashboard -Server $Server 
    }

}
