param([Switch]$Minimal)

$BuildFolder = $PSScriptRoot

$powerShellGet = Import-Module PowerShellGet  -PassThru -ErrorAction Ignore
if ($powerShellGet.Version -lt ([Version]'2.2.0')) {
    Install-Module PowerShellGet -Scope CurrentUser -Force -AllowClobber
    Import-Module PowerShellGet -Force
}

Set-Location $BuildFolder

$OutputPath = "$BuildFolder\output\UniversalDashboard.Charts"

Remove-Item -Path $OutputPath -Force -Recurse
Remove-Item -Path "$BuildFolder\public" -Force -Recurse

New-Item -Path $OutputPath -ItemType Directory

if (-not $Minimal) {
    & cyclonedx-bom -o Charts.bom.xml
    npm install
}

npm run build

Copy-Item $BuildFolder\public\*.bundle.js $OutputPath
Copy-Item $BuildFolder\public\*.bundle.map $OutputPath
Copy-Item $BuildFolder\UniversalDashboard.Charts.psm1 $OutputPath
Copy-Item $BuildFolder\Scripts $OutputPath\Scripts -Recurse -Force



$manifestParameters = @{
    Path              = "$OutputPath\UniversalDashboard.Charts.psd1"
    Author            = "Alon Gvili"
    CompanyName       = "Ironman Software, LLC"
    Copyright         = "2020 Ironman Software, LLC"
    RootModule        = "UniversalDashboard.Charts.psm1"
    Description       = "UniversalDashboard Charts pack using AntV javascript library."
    ModuleVersion     = "1.0.0"
    # $Version          = 1.0.0
    Tags              = @("universaldashboard", "antv", "charts", "monitoring", "reactjs")
    ReleaseNotes      = "Initial release"
    FunctionsToExport = @(
        # "New-Chart"
        # "New-ChartTitle"
        # "New-ChartDescription"
        # "New-ChartLegend"
        # "New-ChartTooltip"
        # "New-ChartLabel"
        # "New-ChartTooltipCrosshairs"
        "New-ViserChart"
        "New-UDMonitor"
    )
    RequiredModules   = @()
}

New-ModuleManifest @manifestParameters

if ($prerelease -ne $null) {
    Update-ModuleManifest -Path "$OutputPath\UniversalDashboard.Charts.psd1" -Prerelease $prerelease
}

