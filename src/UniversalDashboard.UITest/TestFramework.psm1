Import-Module "$PSScriptRoot\..\Selenium\Selenium.psm1" -Force 

function Get-ModulePath {
    param([Switch]$Release)

    if (-not $Release) {
        "$PSScriptRoot\..\UniversalDashboard\bin\debug\UniversalDashboard.Community.psd1"
    } else {
        "$PSScriptRoot\..\output\UniversalDashboard.Community.psd1"
    }
}

function Get-BrowserPort {
    10000
}