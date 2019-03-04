param(
    [string]$FileName
    [Switch]$OutputTestResultXml
    [Switch]$NoClose,
)

Import-Module (Join-Path $PSScriptRoot "../../Selenium/Selenium.psm1") -Force
#Don't auto-load the materialize from UD
$Global:UDNoMaterialize = $true
Import-Module (Join-Path $PSScriptRoot "../../output/UniversalDashboard.Community.psd1") -Force 
Import-Module (Join-Path $PSScriptRoot "../output/UniversalDashboard.MaterialUI/UniversalDashboard.MaterialUI.psd1") -Force

if($PSBoundParameters.keys -contains 'FileName'){
    $Tests = Get-ChildItem $PSScriptRoot -Filter $FileName
}else{
    $Tests = Get-ChildItem $PSScriptRoot -Filter "*.tests.ps1"
}

$Dashboard = New-UDDashboard -Title "Test" -Content {}
$files = Publish-UDFolder -Path $PSScriptRoot -RequestPath "/files"
$Server = Start-UDDashboard -Port 10000 -Dashboard $Dashboard -PublishedFolder $files
$Driver = Start-SeFirefox
Enter-SeUrl -Url "http://localhost:10000" -Driver $Driver

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
    Enter-SeUrl -Url "http://localhost:10000" -Driver $Driver
}

if ($OutputTestResultXml) {
    $OutputPath = "$PSScriptRoot\test-results" 
    Remove-Item $OutputPath -Recurse -ErrorAction SilentlyContinue -Force
    New-Item -Path $OutputPath -ItemType Directory

    Push-Location $PSScriptRoot
    Invoke-Pester -OutputFile (Join-Path $OutputPath "TEST-MaterialUI.xml") -OutputFormat NUnitXml
    Pop-Location
} else {
    $Tests | ForEach-Object {
        . $_.FullName
    }
}

if (-not $NoClose) 
{
    Stop-UDDashboard -Port 10000
    Stop-SeDriver $Driver
}