param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

Get-UDDashboard | Stop-UDDashboard

Describe "Tabs" {
    Context "Static Tabs" {
        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDTabContainer -Tabs {
                New-UDTab -Text "Tab1" -Content { New-UDCard -Title "Hi" -Content {} }
                New-UDTab -Text "Tab2" -Content { New-UDCard -Title "Hi2" -Content {} }
            }
        }

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        Stop-SeDriver $Driver
        Stop-UDDashboard -Server $Server 
    }
}