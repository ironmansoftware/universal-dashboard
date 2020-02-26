$Env:SkipMaterial = $true

Import-Module (Join-Path $PSScriptRoot "../output/UniversalDashboard.Community.psd1")
Import-Module (Join-Path $PSScriptRoot "UniversalDashboard.MaterialUI.psm1") -Force -ArgumentList $true

Set-Location $PSScriptRoot
Start-Process npm -ArgumentList @("run", "dev")

$Dashboard = . (Join-Path $PSScriptRoot 'dashboard.ps1')
Start-UDDashboard -Port 10001 -Dashboard $Dashboard -AutoReload -Force
Start-Process http://localhost:10001