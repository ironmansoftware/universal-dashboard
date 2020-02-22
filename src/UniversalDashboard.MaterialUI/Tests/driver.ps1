#Requires -Modules Selenium

param(
    [string]$FileName,
    [Switch]$OutputTestResultXml,
    [Switch]$NoClose,
    [Switch]$StopSelenium
)

Import-Module (Join-Path $PSScriptRoot "../../output/UniversalDashboard.Community.psd1") -Force 

if($PSBoundParameters.keys -contains 'FileName'){
    $Tests = Get-ChildItem $PSScriptRoot -Filter $FileName
}else{
    $Tests = Get-ChildItem $PSScriptRoot -Filter "*.tests.ps1"
}

$Dashboard = . (Join-Path $PSScriptRoot "../dashboard.ps1")
$files = Publish-UDFolder -Path $PSScriptRoot -RequestPath "/files"
$Driver = Start-SeFirefox
$Global:StateCollection = New-Object -TypeName 'System.Collections.Concurrent.BlockingCollection[object]'

<# 
    Sets test data from within the dashboard that can be validated in Pester tests.
#>
function Set-TestData {
    param($Data)

    $StateCollection.Add($Data)
}

<#
    Retrieves test data from within the dashboard. This will block up to 5 seconds while waiting for the data. 

    This can be used for things that take time. For example, making sure that onClick events work. 
#>
function Get-TestData {
    $Data = $null
    if ($Global:StateCollection.TryTake([ref]$Data, 5000)) {
        $Data 
    } 
    else {
        throw "Retreiving data timed out (5000ms)."
    }
}

<# 
    Updates the dashboard with the latest test dashboard.  
#>
function Set-TestDashboard {
    param(
        [ScriptBlock]$Content
    )

    $Global:StateCollection = New-Object -TypeName 'System.Collections.Concurrent.BlockingCollection[object]'

    $Dashboard = New-UDDashboard -Content $Content -Title "TEST" -EndpointInitialization (New-UDEndpointInitialization -Variable "StateCollection" -Function "Set-TestData")
    $Server.DashboardService.SetDashboard($Dashboard)
    Enter-SeUrl -Url "http://localhost:10000" -Driver $Driver #DevSkim: ignore DS137138 
}

$Dashboard.EndpointInitialSessionState = New-UDEndpointInitialization -Variable "StateCollection" -Function "Set-TestData"
$Server = Start-UDDashboard -Port 10000 -Dashboard $Dashboard -PublishedFolder $files

if ($OutputTestResultXml) {
    $OutputPath = "$PSScriptRoot\test-results" 
    Remove-Item $OutputPath -Recurse -ErrorAction SilentlyContinue -Force
    New-Item -Path $OutputPath -ItemType Directory

    Push-Location $PSScriptRoot
    Invoke-Pester -OutputFile (Join-Path $OutputPath "TEST-MaterialUI.xml") -OutputFormat NUnitXml #DevSkim: ignore DS104456 
    Pop-Location
} else {
    $Tests | ForEach-Object {
        . $_.FullName
    }
}

if ($StopSelenium) 
{
    Stop-SeDriver $Driver
}

if (-not $NoClose) 
{
    Get-UDDashboard | Stop-UDDashboard
    Stop-SeDriver $Driver
}