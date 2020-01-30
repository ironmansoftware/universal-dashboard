param([Switch]$Release)

. "$PSScriptRoot\..\TestFramework.ps1"
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

Get-UDDashboard | Stop-UDDashboard

Describe "Image" {
    Context "path" {

        $image = (Join-Path $PSScriptRoot '..\assets\logo1.png')

        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDImage -Path $image -Id "img" -height 100 -Width 100
        }

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        It "should have set base64 string" {
            $Element = Find-SeElement -Id "img" -Driver $Driver
        }

       Stop-SeDriver $Driver
       Stop-UDDashboard -Server $Server 
    }
}