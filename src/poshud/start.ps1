Import-Module "$PSScriptRoot\..\output\UniversalDashboard.Community.psd1"
Import-Module "$PSScriptRoot\dashboard.psm1"
$Dashboard = New-DemoDashboard
Start-UDDashboard -Port 10000 -Dashboard $Dashboard -Force

# $D = (Get-UDDashboard).DashboardService
# (Get-UDDashboard).DashboardService.EndpointService.SessionManager.Sessions.GetEnumerator().Value.Endpoints.GetEnumerator() |Measure
# $D.EndpointService.Get('9c1b6cbe-877d-424f-88d1-069e84d01bfe', 'c7b48bb6-3dfe-4164-bcbc-9c6b511a0e33')