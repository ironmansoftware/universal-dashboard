param([Switch]$Release)

Import-Module "$PSScriptRoot\Selenium\Selenium.psm1" -Force 

if (-not $Release) {
    $BrowserPort = 10000
    Import-Module "$PSScriptRoot\..\..\UniversalDashboard\bin\debug\UniversalDashboard.Community.psd1"
} else {
    $BrowserPort = 10001
    Import-Module "$PSScriptRoot\..\..\output\UniversalDashboard.Community.psd1"
}

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