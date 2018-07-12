param([Switch]$Release)

Import-Module "$PSScriptRoot\Selenium\Selenium.psm1" -Force 

if (-not $Release) {
    $BrowserPort = 10000
    Import-Module "$PSScriptRoot\..\..\UniversalDashboard\bin\debug\UniversalDashboard.Community.psd1"
} else {
    $BrowserPort = 10001
    Import-Module "$PSScriptRoot\..\..\output\UniversalDashboard.Community.psd1"
}

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