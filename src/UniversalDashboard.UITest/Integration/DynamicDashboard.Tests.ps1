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

Describe "DynamicDashboard" {
    Context "Should work" {
       
        $Colors = @{
            BackgroundColor = "#12A5EC"
            FontColor       = "#FFFFFFFF"
        }

        $Grids = 1..30

        $Dashboard = New-UDDashboard -NavbarLinks $NavBarLinks -Title "For Loop Example" -NavBarColor '#011721' -NavBarFontColor "#CCEDFD" -BackgroundColor "#66C7F6" -FontColor "#011721" -Content {
            New-UDRow {
                foreach ($Dataset in $Grids) {
                    New-UDColumn -Size 1 {
                         New-UDMonitor -Title $Dataset -RefreshInterval 1 -Endpoint {
                             $Dataset | Out-UDMonitorData
                         }
                    }
                }
            }
        }

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        It "should have title text" {
            $Element = Find-SeElement -Id "Card" -Driver $Driver
            $Element.Text.Split("`r`n")[0] | should be "Test"
        }

       Stop-SeDriver $Driver
       Stop-UDDashboard -Server $Server 
    }
}