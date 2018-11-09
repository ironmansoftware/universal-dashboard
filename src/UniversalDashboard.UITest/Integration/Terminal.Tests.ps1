param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

Get-UDDashboard | Stop-UDDashboard

Describe "Select" {
    Context "onSelect" {
        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDTerminal

            New-UDElement -Tag 'div' -Id 'parent'
        }

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
       #Stop-SeDriver $Driver
       #Stop-UDDashboard -Server $Server 
    }
}