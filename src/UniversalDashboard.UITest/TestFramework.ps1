#requires -Module Selenium

Import-Module "$PSScriptRoot\..\output\UniversalDashboard.Community.psd1"
Import-Module "$PSScriptRoot\..\output\Modules\UniversalDashboard.MaterialUI\UniversalDashboard.MaterialUI.psd1"

function Get-TestData {
    $Data = $null
    if ($Cache:StateCollection.TryTake([ref]$Data, 5000)) {
        $Data 
    } 
    else {
        throw "Retreiving data timed out (5000ms)."
    }
}

if ($null -eq $Global:Driver)
{
    $Global:Driver = Start-SeFirefox
    $Driver = $Global:Driver
}

$BrowserPort = 10001