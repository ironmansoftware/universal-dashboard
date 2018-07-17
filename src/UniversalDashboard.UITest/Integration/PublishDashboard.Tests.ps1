param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

if (-not $Release) {
    Write-Warning "Publish tests must run in a release build"
    return
}

$tempDashboard = Join-Path ([IO.Path]::GetTempPath()) "dashboard.ps1"

Describe "Publish-UDDashboard" {
    sc.exe stop UniversalDashboard
    sc.exe delete UniversalDashboard
    
    Remove-Item $tempDashboard -Force -ErrorAction SilentlyContinue
    $deploymentPath = Join-Path ([IO.Path]::GetTempPath()) "service"

    It "should publish a dashboard with just a dashboard file" {
        "Import-Module '$ModulePath'; Start-UDDashboard -Port 10000 -Dashboard (New-UDDashboard -Title 'Test' -Content {})" | Out-File $tempDashboard

        Publish-UDDashboard -DashboardFile $tempDashboard

        Start-Sleep 3

        (Invoke-WebRequest http://localhost:10000).StatusCode | Should be 200
    }

    sc.exe stop UniversalDashboard
    sc.exe delete UniversalDashboard
    Remove-Item $tempDashboard -Force -ErrorAction SilentlyContinue

    It "should publish a dashboard with target path" {
        "Import-Module '$ModulePath'; Start-UDDashboard -Port 10000 -Dashboard (New-UDDashboard -Title 'Test' -Content {})" | Out-File $tempDashboard

        Publish-UDDashboard -DashboardFile $tempDashboard -TargetPath $deploymentPath

        Start-Sleep 3

        (Invoke-WebRequest http://localhost:10000).StatusCode | Should be 200
    }

    sc.exe stop UniversalDashboard
    sc.exe delete UniversalDashboard
    Remove-Item $tempDashboard -Force -ErrorAction SilentlyContinue
    Remove-Item $deploymentPath -Force -ErrorAction SilentlyContinue -Recurse

    It "should delete service and recreate service" {
        "Import-Module '$ModulePath'; Start-UDDashboard -Port 10000 -Dashboard (New-UDDashboard -Title 'Test' -Content {})" | Out-File $tempDashboard

        $Error.Clear()

        Publish-UDDashboard -DashboardFile $tempDashboard

        Start-Sleep 10

        Publish-UDDashboard -DashboardFile $tempDashboard

        Start-Sleep 10

        (Invoke-WebRequest http://localhost:10000).StatusCode | Should be 200
        $Error.Length | Should be 1

        Start-Sleep 10
    }

    sc.exe stop UniversalDashboard
    sc.exe delete UniversalDashboard
    Remove-Item $tempDashboard -Force -ErrorAction SilentlyContinue
    Remove-Item $deploymentPath -Force -ErrorAction SilentlyContinue -Recurse

    It "should set service start type to manual" {
        "Import-Module '$ModulePath'; Start-UDDashboard -Port 10000 -Dashboard (New-UDDashboard -Title 'Test' -Content {})" | Out-File $tempDashboard

        $Error.Clear()

        Publish-UDDashboard -DashboardFile $tempDashboard -Manual 

        (Get-Service UniversalDashboard).StartType | should be "Manual"
    }

    sc.exe delete UniversalDashboard
    Remove-Item $tempDashboard -Force -ErrorAction SilentlyContinue
    Remove-Item $deploymentPath -Force -ErrorAction SilentlyContinue -Recurse
}