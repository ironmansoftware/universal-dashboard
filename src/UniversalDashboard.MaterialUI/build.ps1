param([Switch]$Minimal)

$BuildFolder = $PSScriptRoot

$powerShellGet = Import-Module PowerShellGet  -PassThru -ErrorAction Ignore
if ($powerShellGet.Version -lt ([Version]'1.6.0')) {
    Install-Module PowerShellGet -Scope CurrentUser -Force -AllowClobber
    Import-Module PowerShellGet -Force
}

Set-Location $BuildFolder

$OutputPath = "$BuildFolder\output\UniversalDashboard.MaterialUI"

Remove-Item -Path $OutputPath -Force -Recurse
Remove-Item -Path "$BuildFolder\public" -Force -Recurse

New-Item -Path $OutputPath -ItemType Directory

if (-not $Minimal)
{
    & cyclonedx-bom -o materialui.bom.xml
    npm install
}

npm run build

Copy-Item $BuildFolder\public\*.bundle.js $OutputPath
Copy-Item $BuildFolder\public\*.bundle.map $OutputPath
Copy-Item $BuildFolder\public\*.woff $OutputPath
Copy-Item $BuildFolder\public\*.woff2 $OutputPath
Copy-Item $BuildFolder\UniversalDashboard.MaterialUI.psm1 $OutputPath
Copy-Item $BuildFolder\Scripts $OutputPath\Scripts -Recurse -Force

$Version = "1.0.0"

$manifestParameters = @{
    Path              = "$OutputPath\UniversalDashboard.MaterialUI.psd1"
    Author            = "Adam Driscoll"
    CompanyName       = "Ironman Software, LLC"
    Copyright         = "2019 Ironman Software, LLC"
    RootModule        = "UniversalDashboard.MaterialUI.psm1"
    Description       = "Material UI bundle for Universal Dashboard."
    ModuleVersion     = $version
    Tags              = @("universaldashboard", "material UI", "materialdesign")
    ReleaseNotes      = "Initial release"
    FunctionsToExport = @(
        "New-UDMuChip", 
        "New-UDMuPaper", 
        "New-UDIconButton", 
        "New-UDMuList", 
        "New-UDMuListItem", 
        "New-UDPdf", 
        "New-UDMuExpandListItem", 
        "New-UDButton", 
        "New-UDMuCard", 
        "New-UDMuCardMedia" , 
        "New-UDMuTypography", 
        "New-UDMuCardToolbar"
        "New-UDMuCardHeader"
        "New-UDMuCardBody"
        "New-UDMuCardExpand"
        "New-UDMuCardFooter"
        "New-UDMuLink"
        "New-UDMuAvatar"
        "New-UDCheckBox"
        "New-UDProgress"
        "New-UDExpansionPanelGroup"
        "New-UDExpansionPanel"
        "New-UDFloatingActionButton"
        "New-UDTab"
        "New-UDTabs"
    )
    RequiredModules   = @()
}

New-ModuleManifest @manifestParameters

if ($prerelease -ne $null) {
    Update-ModuleManifest -Path "$OutputPath\UniversalDashboard.MaterialUI.psd1" -Prerelease $prerelease
}

