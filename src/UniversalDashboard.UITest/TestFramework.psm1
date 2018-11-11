Import-Module "$PSScriptRoot\Integration\Selenium\Selenium.psm1" -Force 

function Get-ModulePath {
    param([Switch]$Release)

    if (-not $Release) {
        "$PSScriptRoot\..\UniversalDashboard\bin\debug\UniversalDashboard.Community.psd1"
    } else {
        "$PSScriptRoot\..\output\UniversalDashboard.Community.psd1"
    }
}

function Get-BrowserPort {
    param([Switch]$Release)

    if (-not $Release) {
        10000
    } else {
        10001
    }
}

function Push-NewDashboard {
    param(
        $Dashboard
    )
    $BrowserPort = Get-BrowserPort -Release:$Release
    Invoke-RestMethod -Method Post -Uri "http://localhost:$BrowserPort/api/internal/component/terminal" -Body ('$dashboardservice.setDashboard(($Dashboard))') -SessionVariable ss -ContentType 'text/plain'
}