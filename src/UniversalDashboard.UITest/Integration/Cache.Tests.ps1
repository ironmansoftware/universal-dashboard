param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

Get-UDDashboard | Stop-UDDashboard

Describe "Cache" {
    Context "Xml" {
        It "Should work with XML" {
            $cache:data = [xml]"<data><xpath></xpath><xpath></xpath><xpath></xpath></data>"
            ($Cache:data.SelectNodes("//data/xpath")).Count | should be 3
        }
    }

    Context "Clear-UDCache" {
        It "Should work with XML" {
            $cache:data = [xml]"<data><xpath></xpath><xpath></xpath><xpath></xpath></data>"
            Clear-UDCache
            $Cache:data | Should be $null
        }
    }
}