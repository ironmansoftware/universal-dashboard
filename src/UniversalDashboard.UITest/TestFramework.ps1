. "$PSScriptRoot\..\Selenium\Selenium.ps1"

function Get-TestData {
    $Data = $null
    if ($Cache:StateCollection.TryTake([ref]$Data, 5000)) {
        $Data 
    } 
    else {
        throw "Retreiving data timed out (5000ms)."
    }
}

function Get-ModulePath {
    param([Switch]$Release)

    $Env:Debug = (-not $Release.IsPresent)
    "$PSScriptRoot\..\output\UniversalDashboard.Community.psd1"
}

function Get-BrowserPort {
    param([Switch]$Release)

    10001
}