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

    Context "Xml in counter" {
        $TempFile = [System.IO.Path]::GetTempFileName()
        "<data><xpath></xpath><xpath></xpath><xpath></xpath></data>" | Out-File $TempFile
        $cache:data = [xml](Get-Content $TempFile)

        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDCounter -Id "Counter" -Endpoint {
                ($Cache:data.SelectNodes("//data/xpath")).Count 
            }
        }

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        Start-Sleep 1

        It "Should work with XML" {
            (Find-SeElement -Id "Counter" -Driver $Driver).Text | Should be "3"
        }

        Stop-SeDriver $Driver
        Stop-UDDashboard -Server $Server 
        Remove-Item $TempFile
    }
}