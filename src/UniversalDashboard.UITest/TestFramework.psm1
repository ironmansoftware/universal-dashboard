Import-Module "$PSScriptRoot\..\Selenium\Selenium.psm1" -Force 

function Get-ModulePath {
    param([Switch]$Release)

    $Global:Debug = (-not $Release.IsPresent)
    "$PSScriptRoot\..\output\UniversalDashboard.Community.psd1"
}

function Get-BrowserPort {
    param([Switch]$Release)

    10001
}