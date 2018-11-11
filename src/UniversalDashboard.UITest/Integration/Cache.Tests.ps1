param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

Describe "Cache" {
    Context "Xml" {
        It "Should work with XML" {
            $cache:data = [xml]"<data><xpath></xpath><xpath></xpath><xpath></xpath></data>"
            ($Cache:data.SelectNodes("//data/xpath")).Count | should be 3
        }
    }

    Context "Xml in counter" {
        $TempFile = [System.IO.Path]::GetTempFileName()
        "<data><xpath></xpath><xpath></xpath><xpath></xpath></data>" | Out-File $TempFile
        $cache:data = [xml](Get-Content $TempFile)

        Invoke-RestMethod -Method Post -Uri "http://localhost:10001/api/internal/component/terminal" -Body ('$dashboardservice.setDashboard((
            New-UDDashboard -Title "Test" -Content {
            New-UDCounter -Id "Counter" -Endpoint {
                ($Cache:data.SelectNodes("//data/xpath")).Count 
            }
        }))') -SessionVariable ss -ContentType 'text/plain'

        It "Should work with XML" {
            (Find-SeElement -Id "Counter" -Driver $Cache:Driver).Text | Should be "3"
        }

        Remove-Item $TempFile
    }
}