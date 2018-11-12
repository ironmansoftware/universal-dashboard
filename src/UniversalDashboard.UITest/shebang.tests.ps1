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
    Invoke-PesterTest -FileName DynamicDashboard.Tests.ps1 -Subfolder "Integration" -Release:$Release
    Invoke-PesterTest -FileName Element.Tests.ps1 -Subfolder "Integration" -Release:$Release
    Invoke-PesterTest -FileName EndpointInitialization.Tests.ps1 -Subfolder "Integration" -Release:$Release
    Invoke-PesterTest -FileName Error.Tests.ps1 -Subfolder "Integration" -Release:$Release
    Invoke-PesterTest -FileName Fab.Tests.ps1 -Subfolder "Integration" -Release:$Release
    Invoke-PesterTest -FileName FontIcon.Tests.ps1 -Subfolder "Integration" -Release:$Release
    Invoke-PesterTest -FileName Form.Tests.ps1 -Subfolder "Integration" -Release:$Release
    Invoke-PesterTest -FileName Formatting.Tests.ps1 -Subfolder "Integration" -Release:$Release
    Invoke-PesterTest -FileName Grid.Tests.ps1 -Subfolder "Integration" -Release:$Release
    # Invoke-PesterTest -FileName Https.Tests.ps1 -Subfolder "Integration" -Release:$Release
    # Invoke-PesterTest -FileName Image.Tests.ps1 -Subfolder "Integration" -Release:$Release
    # Invoke-PesterTest -FileName ImageCarousel.Tests.ps1 -Subfolder "Integration" -Release:$Release
    # Invoke-PesterTest -FileName Input.Tests.ps1 -Subfolder "Integration" -Release:$Release
    # Invoke-PesterTest -FileName Link.Tests.ps1 -Subfolder "Integration" -Release:$Release
    # Invoke-PesterTest -FileName Modal.Tests.ps1 -Subfolder "Integration" -Release:$Release
    # Invoke-PesterTest -FileName Monitor.Tests.ps1 -Subfolder "Integration" -Release:$Release
    # Invoke-PesterTest -FileName Page.Tests.ps1 -Subfolder "Integration" -Release:$Release
    # Invoke-PesterTest -FileName PublishDashboard.Tests.ps1 -Subfolder "Integration" -Release:$Release
    # Invoke-PesterTest -FileName PublishedFolders.Tests.ps1 -Subfolder "Integration" -Release:$Release
    # Invoke-PesterTest -FileName Redirect.Tests.ps1 -Subfolder "Integration" -Release:$Release
    # Invoke-PesterTest -FileName ScheduledEndpoint.Tests.ps1 -Subfolder "Integration" -Release:$Release
    # Invoke-PesterTest -FileName Scoping.Tests.ps1 -Subfolder "Integration" -Release:$Release
    # Invoke-PesterTest -FileName Select.Tests.ps1 -Subfolder "Integration" -Release:$Release
    # Invoke-PesterTest -FileName SpeedTests.Tests.ps1 -Subfolder "Integration" -Release:$Release
    # Invoke-PesterTest -FileName SyncElement.Tests.ps1 -Subfolder "Integration" -Release:$Release
    # Invoke-PesterTest -FileName Table.Tests.ps1 -Subfolder "Integration" -Release:$Release
    # Invoke-PesterTest -FileName TestModule.psm1 -Subfolder "Integration" -Release:$Release
    # Invoke-PesterTest -FileName Theme.Tests.ps1 -Subfolder "Integration" -Release:$Release
    # Invoke-PesterTest -FileName Toast.Tests.ps1 -Subfolder "Integration" -Release:$Release
    # Invoke-PesterTest -FileName TreeView.Tests.ps1 -Subfolder "Integration" -Release:$Release
    # Invoke-PesterTest -FileName webconfig.tests.ps1 -Subfolder "Integration" -Release:$Release
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
src\UniversalDashboard.UITest\RemoveSetup.ps1
Stop-Service -Name UniversalDashboard -ErrorAction SilentlyContinue


if ($null -ne $env:APPVEYOR_JOB_ID) {
    Get-ChildItem $OutputPath | ForEach-Object {
        $wc = New-Object 'System.Net.WebClient'
        $wc.UploadFile("https://ci.appveyor.com/api/testresults/nunit/$($env:APPVEYOR_JOB_ID)", ($_.FullName))
    }
}