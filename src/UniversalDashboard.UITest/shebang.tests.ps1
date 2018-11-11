param([Switch]$Release, [Switch]$Integration, [Switch]$Speed)

$Pester = Import-Module Pester  -PassThru -ErrorAction Ignore
if ($Pester -eq $null) {
	Install-Module Pester -Scope CurrentUser -Force
	Import-Module Pester -Force
}


if (-not $Release) {
    Copy-Item "$PSScriptRoot\..\UniversalDashboard\bin\debug\net462\UniversalDashboard.Community.psd1" "$PSScriptRoot\..\UniversalDashboard\bin\debug\"
    Copy-Item "$PSScriptRoot\..\UniversalDashboard\bin\debug\net462\UniversalDashboard.psm1" "$PSScriptRoot\..\UniversalDashboard\bin\debug\"
    Copy-Item "$PSScriptRoot\..\UniversalDashboard\bin\debug\net462\UniversalDashboardServer.psm1" "$PSScriptRoot\..\UniversalDashboard\bin\debug\"
    Copy-Item "$PSScriptRoot\..\UniversalDashboard\bin\debug\net462\UniversalDashboard.Controls.psm1" "$PSScriptRoot\..\UniversalDashboard\bin\debug\"

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

src\UniversalDashboard.UITest\Setup.ps1

if($Speed){
    Invoke-PesterTest -FileName Api.Tests.ps1 -Subfolder "Integration" -Release:$Release
    Invoke-PesterTest -FileName AutoReload.Tests.ps1 -Subfolder "Integration" -Release:$Release
    Invoke-PesterTest -FileName Cache.Tests.ps1 -Subfolder "Integration" -Release:$Release
    Invoke-PesterTest -FileName Card.Tests.ps1 -Subfolder "Integration" -Release:$Release
    Invoke-PesterTest -FileName Chart.Options.Tests.ps1 -Subfolder "Integration" -Release:$Release
    Invoke-PesterTest -FileName Chart.Tests.ps1 -Subfolder "Integration" -Release:$Release
    Invoke-PesterTest -FileName Checkbox.Tests.ps1 -Subfolder "Integration" -Release:$Release
    Invoke-PesterTest -FileName Collapsible.Tests.ps1 -Subfolder "Integration" -Release:$Release
    Invoke-PesterTest -FileName Cookies.Tests.ps1 -Subfolder "Integration" -Release:$Release
    Invoke-PesterTest -FileName Counter.Tests.ps1 -Subfolder "Integration" -Release:$Release
    Invoke-PesterTest -FileName Crossplatform.Tests.ps1 -Subfolder "Integration" -Release:$Release
    Invoke-PesterTest -FileName Dashboard.Tests.ps1 -Subfolder "Integration" -Release:$Release
    Invoke-PesterTest -FileName Design.Tests.ps1 -Subfolder "Integration" -Release:$Release
}

#Unit
# Get-ChildItem (Join-Path $PSScriptRoot "Cmdlet") | ForEach-Object {
#     Invoke-PesterTest -FileName ($_.Name) -Subfolder "Cmdlet" -Release:$Release
# }


# if (-not $Integration) {
#     return
# }

# #Integration
# Get-ChildItem (Join-Path $PSScriptRoot "Integration") | ForEach-Object {
#     Invoke-PesterTest -FileName ($_.Name) -Subfolder "Integration" -Release:$Release
# }

Invoke-PesterTest -FileName Manifest.Tests.ps1 -Release:$Release


Get-Process firefox -ErrorAction SilentlyContinue | Stop-Process
Stop-Service -Name UniversalDashboard -ErrorAction SilentlyContinue

src\UniversalDashboard.UITest\RemoveSetup.ps1

if ($null -ne $env:APPVEYOR_JOB_ID) {
    Get-ChildItem $OutputPath | ForEach-Object {
        $wc = New-Object 'System.Net.WebClient'
        $wc.UploadFile("https://ci.appveyor.com/api/testresults/nunit/$($env:APPVEYOR_JOB_ID)", ($_.FullName))
    }
}