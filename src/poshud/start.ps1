Import-Module "$PSScriptRoot\..\output\UniversalDashboard.Community.psd1"
$Dashboard = & "$PSScriptRoot\dashboard.ps1"
Start-UDDashboard -Port 10000 -Dashboard $Dashboard -Force