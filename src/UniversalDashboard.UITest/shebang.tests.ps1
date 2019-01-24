param([Switch]$Release, [Switch]$Integration)

$Pester = Import-Module Pester  -PassThru -ErrorAction Ignore
if ($Pester -eq $null) {
	Install-Module Pester -Scope CurrentUser -Force
	Import-Module Pester -Force
}

if (-not $Release) {
    Import-Module "$PSScriptRoot\..\UniversalDashboard\bin\debug\UniversalDashboard.Community.psd1"
} else {
    Import-Module "$PSScriptRoot\..\output\UniversalDashboard.Community.psd1"
}

$OutputPath = "$PSScriptRoot\test-results" 

Remove-Item $OutputPath -Recurse -ErrorAction SilentlyContinue -Force
New-Item -Path $OutputPath -ItemType Directory

Stop-Service UniversalDashboard -Force -ErrorAction SilentlyContinue

function Invoke-PesterTest {
    param($FileName, $Subfolder, $Release) 

    if ($Subfolder) {
        Invoke-Pester -Script @{ Path = "$PSScriptRoot\$SubFolder\$FileName"; Parameters = @{Release = $Release}} -OutputFile (Join-Path $OutputPath "TEST-$Subfolder-$FileName.xml") -OutputFormat NUnitXml
    } else {
        Invoke-Pester -Script @{ Path = "$PSScriptRoot\$FileName"; Parameters = @{Release = $Release}} -OutputFile (Join-Path $OutputPath "TEST-$FileName.xml") -OutputFormat NUnitXml
    }
}

#Unit
Get-ChildItem (Join-Path $PSScriptRoot "Cmdlet") | ForEach-Object {
    Invoke-PesterTest -FileName ($_.Name) -Subfolder "Cmdlet" -Release:$Release
}

if (-not $Integration) {
    return
}

#Integration
Get-ChildItem (Join-Path $PSScriptRoot "Integration") | ForEach-Object {
    Invoke-PesterTest -FileName ($_.Name) -Subfolder "Integration" -Release:$Release
}

Invoke-PesterTest -FileName Manifest.Tests.ps1 -Release:$Release


Get-Process firefox -ErrorAction SilentlyContinue | Stop-Process
Stop-Service -Name UniversalDashboard -ErrorAction SilentlyContinue

if ($null -ne $env:APPVEYOR_JOB_ID) {
    Get-ChildItem $OutputPath | ForEach-Object {
        $wc = New-Object 'System.Net.WebClient'
        $wc.UploadFile("https://ci.appveyor.com/api/testresults/nunit/$($env:APPVEYOR_JOB_ID)", ($_.FullName))
    }
}