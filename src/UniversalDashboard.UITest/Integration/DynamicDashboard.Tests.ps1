param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

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

        Start-Sleep 2

        It "should have title text" {
            $Element = Find-SeElement -Id "Card" -Driver $Driver
            $Element.Text.Split("`r`n")[0] | should be "Test"
        }

       Stop-SeDriver $Driver
       Stop-UDDashboard -Server $Server 
    }
}