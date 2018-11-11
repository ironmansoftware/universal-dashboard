param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
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
        $Cache:Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Cache:Driver -Url "http://localhost:$BrowserPort"

        It "should have set base64 string" {
            $Element = Find-SeElement -Id "img" -Driver $Cache:Driver
        }

       Stop-SeDriver $Cache:Driver
       Stop-UDDashboard -Server $Server 
    }
}