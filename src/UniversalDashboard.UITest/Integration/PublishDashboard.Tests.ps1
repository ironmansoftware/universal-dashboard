param([Switch]$Release)

Import-Module "$PSScriptRoot\Selenium\Selenium.psm1" -Force 

if (-not $Release) {
    $BrowserPort = 10000
    Import-Module "$PSScriptRoot\..\..\UniversalDashboard\bin\debug\UniversalDashboard.Community.psd1"
} else {
    $BrowserPort = 10001
    Import-Module "$PSScriptRoot\..\..\output\UniversalDashboard.Community.psd1"
}

if (-not $Release) {
    Write-Warning "Publish tests must run in a release build"
    return
}

Describe "Publish-UDDashboard" {
    Stop-Service UniversalDashboard -ErrorAction SilentlyContinue
    sc.exe delete UniversalDashboard
    $tempDashboard = Join-Path ([IO.Path]::GetTempPath()) "dashboard.ps1"
    Remove-Item $tempDashboard -Force -ErrorAction SilentlyContinue
    $deploymentPath = Join-Path ([IO.Path]::GetTempPath()) "service"

    It "should publish a dashboard with just a dashboard file" {
        "Start-UDDashboard -Port 10000 -Dashboard (New-UDDashboard -Title 'Test' -Content {})" | Out-File $tempDashboard

        Publish-UDDashboard -DashboardFile $tempDashboard

        Start-Sleep 3

        (Invoke-WebRequest http://localhost:10000).StatusCode | Should be 200
    }

    Stop-Service UniversalDashboard -ErrorAction SilentlyContinue
    sc.exe delete UniversalDashboard
    Remove-Item $tempDashboard -Force -ErrorAction SilentlyContinue

    It "should publish a dashboard with target path" {
        "Start-UDDashboard -Port 10000 -Dashboard (New-UDDashboard -Title 'Test' -Content {})" | Out-File $tempDashboard

        Publish-UDDashboard -DashboardFile $tempDashboard -TargetPath $deploymentPath

        Start-Sleep 3

        (Invoke-WebRequest http://localhost:10000).StatusCode | Should be 200
    }

    Stop-Service UniversalDashboard -ErrorAction SilentlyContinue
    sc.exe delete UniversalDashboard
    Remove-Item $tempDashboard -Force -ErrorAction SilentlyContinue
    Remove-Item $deploymentPath -Force -ErrorAction SilentlyContinue -Recurse

    It "should delete service and recreate service" {
        "Start-UDDashboard -Port 10000 -Dashboard (New-UDDashboard -Title 'Test' -Content {})" | Out-File $tempDashboard

        $Error.Clear()

        Publish-UDDashboard -DashboardFile $tempDashboard

        Start-Sleep 3

        Publish-UDDashboard -DashboardFile $tempDashboard

        Start-Sleep 3

        (Invoke-WebRequest http://localhost:10000).StatusCode | Should be 200
        $Error.Length | Should be 1
    }

    Stop-Service UniversalDashboard -ErrorAction SilentlyContinue
    sc.exe delete UniversalDashboard
    Remove-Item $tempDashboard -Force -ErrorAction SilentlyContinue
    Remove-Item $deploymentPath -Force -ErrorAction SilentlyContinue -Recurse

    It "should set service start type to manual" {
        "Start-UDDashboard -Port 10000 -Dashboard (New-UDDashboard -Title 'Test' -Content {})" | Out-File $tempDashboard

        $Error.Clear()

        Publish-UDDashboard -DashboardFile $tempDashboard -Manual 

        (Get-Service UniversalDashboard).StartType | should be "Manual"
    }

    sc.exe delete UniversalDashboard
    Remove-Item $tempDashboard -Force -ErrorAction SilentlyContinue
    Remove-Item $deploymentPath -Force -ErrorAction SilentlyContinue -Recurse
}