param([Switch]$Release)

Import-Module "$PSScriptRoot\Selenium\Selenium.psm1"

if (-not $Release) {
    $BrowserPort = 10000
    Import-Module "$PSScriptRoot\..\..\UniversalDashboard\bin\debug\UniversalDashboard.Community.psd1"
} else {
    $BrowserPort = 10001
    Import-Module "$PSScriptRoot\..\..\output\UniversalDashboard.Community.psd1"
}
Get-UDDashboard | Stop-UDDashboard
Describe "EndpointInitializationScript" {
    Context "Variables" {

        $tempModule = [IO.Path]::GetTempFileName() + ".psm1"

        {
            function Get-Number {
                10
            }
        }.ToString() | Out-File -FilePath $tempModule

        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDCounter -Title "Counter" -Id "Counter" -Endpoint {
                Get-Number 
            }
        } -EndpointInitializationScript {
            Import-Module $tempModule
        }
        
        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
        It "should load module from temp dir" {
            $Target = Find-SeElement -Driver $Driver -Id "Counter"
            $Target.Text | Should be "Counter`r`n10" 
        }

        Remove-Item $tempModule -Force
        Stop-SeDriver $Driver
        Stop-UDDashboard -Server $Server 
    }
}