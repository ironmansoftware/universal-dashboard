Import-Module (Join-Path $PSScriptRoot "../output/UniversalDashboard.Community.psd1")
Import-Module (Join-Path $PSScriptRoot "UniversalDashboard.MaterialUI.psm1") -Force -ArgumentList $true

Set-Location $PSScriptRoot
Start-Process npm -ArgumentList @("run", "dev")

$Dashboard = New-UDDashboard -Title "Dashboard" -Pages @(
    New-UDPage -Name "Button" -Content {
        New-UDButton -Text 'Hello' -OnClick {
            Show-UDModal -Content {
                New-UDButton -Text 'Hello' 
            }
        }
    }

    New-UDPage -Name "Test" -Content {

    }
)

Start-UDDashboard -Port 10001 -Dashboard $Dashboard -AutoReload -Force
Start-Process http://localhost:10001