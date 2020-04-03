Import-Module "$PSScriptRoot\..\output\UniversalDashboard.Community.psd1"
Import-Module "$PSScriptRoot\dashboard.psm1"
$Dashboard = New-DemoDashboard
Start-UDDashboard -Port 10000 -Dashboard $Dashboard -Force