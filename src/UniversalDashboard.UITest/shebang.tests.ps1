param([Switch]$Release, [Switch]$Integration, [Switch]$Unit, [Switch]$Coverage)

# Install the latest pester version.
Install-Module -Name 'Pester' -SkipPublisherCheck -Scope CurrentUser -Force

# Import the latest pester module version.
Import-Module Pester -ErrorAction Stop

# Import universal dashboard community module.
if (-not $Release) {
    Copy-Item "$PSScriptRoot\..\UniversalDashboard\bin\debug\net462\UniversalDashboard.Community.psd1" "$PSScriptRoot\..\UniversalDashboard\bin\debug\"
    Copy-Item "$PSScriptRoot\..\UniversalDashboard\bin\debug\net462\UniversalDashboard.psm1" "$PSScriptRoot\..\UniversalDashboard\bin\debug\"
    Copy-Item "$PSScriptRoot\..\UniversalDashboard\bin\debug\net462\UniversalDashboardServer.psm1" "$PSScriptRoot\..\UniversalDashboard\bin\debug\"
    Copy-Item "$PSScriptRoot\..\UniversalDashboard\bin\debug\net462\UniversalDashboard.Controls.psm1" "$PSScriptRoot\..\UniversalDashboard\bin\debug\"
    Import-Module "$PSScriptRoot\..\UniversalDashboard\bin\debug\UniversalDashboard.Community.psd1"
} else {
    Import-Module "$PSScriptRoot\..\output\UniversalDashboard.Community.psd1"
}

# Build the path for folder to hold tests result xml files.
$OutputPath = "$PSScriptRoot\test-results" 

# Remove tests result folder if exists.
Remove-Item $OutputPath -Recurse -ErrorAction SilentlyContinue -Force

# Create the tests result folder.
New-Item -Path $OutputPath -ItemType Directory

# Create folder to hold pester code coverage report.
New-Item -Path "$OutputPath\CodeCoverage" -ItemType Directory

# Create folder to hold pester code coverage report.
New-Item -Path "$OutputPath\Unit" -ItemType Directory

# Create folder to hold pester code coverage report.
New-Item -Path "$OutputPath\Integration" -ItemType Directory

# Custom function that invoke pester with parameters.
function Invoke-PesterTest { #DevSkim: ignore DS104456 
    param(
        $FileName, 
        $Subfolder, 
        $Release
    ) 
    if ($Subfolder) {
        Invoke-Pester -Script @{ Path = "$PSScriptRoot\$SubFolder\$FileName"; Parameters = @{Release = $Release}} -OutputFile (Join-Path "$OutputPath\$Subfolder" "TEST-$Subfolder-$FileName.xml") -OutputFormat NUnitXml #DevSkim: ignore DS104456 
    } else {
        Invoke-Pester -Script @{ Path = "$PSScriptRoot\$FileName"; Parameters = @{Release = $Release}} -OutputFile (Join-Path $OutputPath "TEST-$FileName.xml") -OutputFormat NUnitXml #DevSkim: ignore DS104456 
    }
}

# Build Env Setup 
src\UniversalDashboard.UITest\Setup.ps1

# Integration Tests
if($Integration){
    Invoke-PesterTest -FileName Api.Tests.ps1 -Subfolder "Integration" -Release:$Release #DevSkim: ignore DS104456 
    Invoke-PesterTest -FileName AutoReload.Tests.ps1 -Subfolder "Integration" -Release:$Release #DevSkim: ignore DS104456 
    Invoke-PesterTest -FileName Cache.Tests.ps1 -Subfolder "Integration" -Release:$Release #DevSkim: ignore DS104456 
    Invoke-PesterTest -FileName Card.Tests.ps1 -Subfolder "Integration" -Release:$Release #DevSkim: ignore DS104456 
    Invoke-PesterTest -FileName Chart.Options.Tests.ps1 -Subfolder "Integration" -Release:$Release #DevSkim: ignore DS104456 
    Invoke-PesterTest -FileName Chart.Tests.ps1 -Subfolder "Integration" -Release:$Release #DevSkim: ignore DS104456 
    Invoke-PesterTest -FileName Checkbox.Tests.ps1 -Subfolder "Integration" -Release:$Release #DevSkim: ignore DS104456 
    Invoke-PesterTest -FileName Collapsible.Tests.ps1 -Subfolder "Integration" -Release:$Release #DevSkim: ignore DS104456 
    Invoke-PesterTest -FileName Cookies.Tests.ps1 -Subfolder "Integration" -Release:$Release #DevSkim: ignore DS104456 
    Invoke-PesterTest -FileName Counter.Tests.ps1 -Subfolder "Integration" -Release:$Release #DevSkim: ignore DS104456 
    # Invoke-PesterTest -FileName Crossplatform.Tests.ps1 -Subfolder "Integration" -Release:$Release
    Invoke-PesterTest -FileName Dashboard.Tests.ps1 -Subfolder "Integration" -Release:$Release #DevSkim: ignore DS104456 
    Invoke-PesterTest -FileName Design.Tests.ps1 -Subfolder "Integration" -Release:$Release #DevSkim: ignore DS104456 until 2018-12-15 
    Invoke-PesterTest -FileName DynamicDashboard.Tests.ps1 -Subfolder "Integration" -Release:$Release #DevSkim: ignore DS104456 
    Invoke-PesterTest -FileName Element.Tests.ps1 -Subfolder "Integration" -Release:$Release #DevSkim: ignore DS104456 
    Invoke-PesterTest -FileName EndpointInitialization.Tests.ps1 -Subfolder "Integration" -Release:$Release #DevSkim: ignore DS104456 
    Invoke-PesterTest -FileName Error.Tests.ps1 -Subfolder "Integration" -Release:$Release #DevSkim: ignore DS104456 
    Invoke-PesterTest -FileName Fab.Tests.ps1 -Subfolder "Integration" -Release:$Release #DevSkim: ignore DS104456 
    Invoke-PesterTest -FileName FontIcon.Tests.ps1 -Subfolder "Integration" -Release:$Release #DevSkim: ignore DS104456 
    Invoke-PesterTest -FileName Form.Tests.ps1 -Subfolder "Integration" -Release:$Release #DevSkim: ignore DS104456 
    Invoke-PesterTest -FileName Formatting.Tests.ps1 -Subfolder "Integration" -Release:$Release #DevSkim: ignore DS104456 
    Invoke-PesterTest -FileName Grid.Tests.ps1 -Subfolder "Integration" -Release:$Release #DevSkim: ignore DS104456 
    Invoke-PesterTest -FileName Https.Tests.ps1 -Subfolder "Integration" -Release:$Release #DevSkim: ignore DS104456 
    Invoke-PesterTest -FileName Image.Tests.ps1 -Subfolder "Integration" -Release:$Release #DevSkim: ignore DS104456 
    Invoke-PesterTest -FileName ImageCarousel.Tests.ps1 -Subfolder "Integration" -Release:$Release #DevSkim: ignore DS104456 
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


# Unit Tests
if($Unit)
{
    Invoke-PesterTest -FileName Enable-UDLogging.Tests.ps1   -Subfolder "Unit" -Release:$Release #DevSkim: ignore DS104456
    Invoke-PesterTest -FileName Get-UDDashboard.Tests.ps1    -Subfolder "Unit" -Release:$Release #DevSkim: ignore DS104456
    Invoke-PesterTest -FileName New-UDButton.Tests.ps1       -Subfolder "Unit" -Release:$Release #DevSkim: ignore DS104456
    Invoke-PesterTest -FileName New-UDCard.Tests.ps1         -Subfolder "Unit" -Release:$Release #DevSkim: ignore DS104456
    Invoke-PesterTest -FileName New-UDCounter.Tests.ps1      -Subfolder "Unit" -Release:$Release #DevSkim: ignore DS104456
    Invoke-PesterTest -FileName New-UDDashboard.Tests.ps1    -Subfolder "Unit" -Release:$Release #DevSkim: ignore DS104456
    Invoke-PesterTest -FileName New-UDElement.Tests.ps1      -Subfolder "Unit" -Release:$Release #DevSkim: ignore DS104456
    Invoke-PesterTest -FileName New-UDEndpoint.Tests.ps1     -Subfolder "Unit" -Release:$Release #DevSkim: ignore DS104456
    Invoke-PesterTest -FileName New-UDImage.Tests.ps1        -Subfolder "Unit" -Release:$Release #DevSkim: ignore DS104456
    Invoke-PesterTest -FileName NewUDInput.Tests.ps1         -Subfolder "Unit" -Release:$Release #DevSkim: ignore DS104456
    Invoke-PesterTest -FileName Out-UDGridData.Tests.ps1     -Subfolder "Unit" -Release:$Release #DevSkim: ignore DS104456
    Invoke-PesterTest -FileName Start-UDDashboard.Tests.ps1  -Subfolder "Unit" -Release:$Release #DevSkim: ignore DS104456
    Invoke-PesterTest -FileName Write-UDLog.Tests.ps1        -Subfolder "Unit" -Release:$Release #DevSkim: ignore DS104456
    Invoke-PesterTest -FileName Manifest.Tests.ps1           -Subfolder "Unit" -Release:$Release #DevSkim: ignore DS104456 
}


# Code Coverage Tests
Switch($PSEdition)
{
    'Core'{
        $CodeCoverage =  ".\Src\Output\netstandard2.0\UniversalDashboard.dll"
        if($Unit){$TestsFolder = '.\src\UniversalDashboard.UITest\Cmdlet\'}
        else{$TestsFolder = '.\src\UniversalDashboard.UITest\Integration\'}
    }
    'Desktop'{
        $CodeCoverage =  ".\Src\Output\net472\UniversalDashboard.dll"
        if($Unit){$TestsFolder = '.\src\UniversalDashboard.UITest\Cmdlet'}
        else{$TestsFolder = '.\src\UniversalDashboard.UITest\Integration\'}
    }
}

# Pester code caverage properties.
$CodeCoverageProps = @{
    Script = 'src\UniversalDashboard.UITest\Integration\Card.Tests.ps1'
    CodeCoverage =  $CodeCoverage,
                    ".\Src\Output\UniversalDashboardServer.psm1",
                    ".\Src\Output\UniversalDashboard.Controls.psm1"
    CodeCoverageOutputFile = ".\src\UniversalDashboard.UITest\test-results\CodeCoverage\Test-CodeCoverageOutput.xml"
}

if($Coverage){
    # invoke-pester @CodeCoverageProps - Code Coverage will be disable for now. we need to test the ud dll as well.
}


# Remove Build Env Setup
src\UniversalDashboard.UITest\RemoveSetup.ps1

# Upload Tests Result To Appveyor
if ($null -ne $env:APPVEYOR_JOB_ID) {
    Get-ChildItem $OutputPath | ForEach-Object {
        $wc = New-Object 'System.Net.WebClient'
        $wc.UploadFile("https://ci.appveyor.com/api/testresults/nunit/$($env:APPVEYOR_JOB_ID)", ($_.FullName))
    }
}