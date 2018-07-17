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
            }
        }

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        It "should support new line in card" {
        
        }

       Stop-SeDriver $Driver
       Stop-UDDashboard -Server $Server 
    }

}