#requires -module Selenium

$Pester = Import-Module Pester  -PassThru -ErrorAction Ignore
if ($null -eq $Pester) {
	Install-Module Pester -Scope CurrentUser -Force
	Import-Module Pester -Force
}

Import-Module "$PSScriptRoot\..\output\UniversalDashboard.Community.psd1"
$OutputPath = "$PSScriptRoot\test-results" 

Remove-Item $OutputPath -Recurse -ErrorAction SilentlyContinue -Force
New-Item -Path $OutputPath -ItemType Directory
function Invoke-PesterTest {
    param($FileName, $Subfolder) 

    if ($Subfolder) {
        Invoke-Pester -Script @{ Path = "$PSScriptRoot\$SubFolder\$FileName" } -OutputFile (Join-Path $OutputPath "TEST-$Subfolder-$FileName.xml") -OutputFormat NUnitXml
    } else {
        Invoke-Pester -Script @{ Path = "$PSScriptRoot\$FileName" } -OutputFile (Join-Path $OutputPath "TEST-$FileName.xml") -OutputFormat NUnitXml
    }
}

Get-ChildItem (Join-Path $PSScriptRoot "Cmdlet") | ForEach-Object {
    Invoke-PesterTest -FileName ($_.Name) -Subfolder "Cmdlet"
}

Get-ChildItem (Join-Path $PSScriptRoot "Integration") -Filter '*.ps1' | ForEach-Object {
    Invoke-PesterTest -FileName ($_.Name) -Subfolder "Integration"
}

Invoke-PesterTest -FileName Manifest.Tests.ps1
Get-Process firefox -ErrorAction SilentlyContinue | Stop-Process