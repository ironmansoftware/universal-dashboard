param(
    [Switch]$NoClose
)

Import-Module (Join-Path $PSScriptRoot "../../Selenium/Selenium.psm1") -Force
#Don't auto-load the materialize from UD
$Global:UDNoMaterialize = $true
Import-Module (Join-Path $PSScriptRoot "../../output/UniversalDashboard.Community.psd1") -Force 
Import-Module (Join-Path $PSScriptRoot "../output/UniversalDashboard.Materialize/UniversalDashboard.Materialize.psd1") -Force

$Tests = Get-ChildItem $PSScriptRoot -Filter "*.tests.ps1"

$Dashboard = New-UDDashboard -Title "Test" -Content {}
$Server = Start-UDDashboard -Port 10000 -Dashboard $Dashboard
$Driver = Start-SeFirefox
Enter-SeUrl -Url "http://localhost:10000" -Driver $Driver
function Set-TestDashboard {
    param(
        [ScriptBlock]$Content
    )

    $Global:StateDictionary = @{}

    $Dashboard = New-UDDashboard -Content $Content -Title "TEST" -EndpointInitialization (New-UDEndpointInitialization -Variable "StateDictionary")
    $Server.DashboardService.SetDashboard($Dashboard)
    Enter-SeUrl -Url "http://localhost:10000" -Driver $Driver
}

$Tests | ForEach-Object {
    . $_.FullName
}

if (-not $NoClose) 
{
    Stop-UDDashboard -Port 10000
    Stop-SeDriver $Driver
}