$BuildFolder = $PSScriptRoot

$powerShellGet = Import-Module PowerShellGet  -PassThru -ErrorAction Ignore
if ($powerShellGet.Version -lt ([Version]'1.6.0')) {
	Install-Module PowerShellGet -Scope CurrentUser -Force -AllowClobber
	Import-Module PowerShellGet -Force
}

Set-Location $BuildFolder

$OutputPath = "$BuildFolder\output\UniversalDashboard.Materialize"

Remove-Item -Path $OutputPath -Force -ErrorAction SilentlyContinue -Recurse
Remove-Item -Path "$BuildFolder\public" -Force -ErrorAction SilentlyContinue -Recurse

New-Item -Path $OutputPath -ItemType Directory
New-Item -Path $OutputPath\Scripts -ItemType Directory

& cyclonedx-bom -o materialize.bom.xml
npm install
npm run build

Copy-Item $BuildFolder\public\*.bundle.js $OutputPath
Copy-Item $BuildFolder\public\*.map $OutputPath
Copy-Item $BuildFolder\scripts\*.ps1 $OutputPath\scripts
Copy-Item $BuildFolder\UniversalDashboard.Materialize.psm1 $OutputPath

$Version = "1.0.0"

$manifestParameters = @{
	Path = "$OutputPath\UniversalDashboard.Materialize.psd1"
	Author = "Adam Driscoll"
	CompanyName = "Ironman Software, LLC"
	Copyright = "2019 Ironman Software, LLC"
	RootModule = "UniversalDashboard.Materialize.psm1"
	Description = "Materialize bundle for Universal Dashboard."
	ModuleVersion = $version
	Tags = @("universaldashboard", "materialize", "materialdesign")
	ReleaseNotes = "Initial release"
	FunctionsToExport = @(
		"New-UDButton", 
		"New-UDCard", 
		"New-UDCheckbox", 
		"New-UDCollapsible", 
		"New-UDCollapsibleItem", 
		"New-UDCollection", 
		"New-UDCollectionItem",
		"New-UDColumn",
		"New-UDFab", 
		"New-UDFabButton",
		"New-UDGrid",
		"New-UDLink",
		"New-UDImageCarousel",
		"New-UDImageCarouselItem",
		"New-UDLayout",
		"New-UDPreloader",
		"New-UDRadio",
		"New-UDRow",
		"New-UDSelect",
		"New-UDSelectOption",
		"New-UDSelectGroup",
		"New-UDSwitch",
		"New-UDTab", 
		"New-UDTabContainer"
		"New-UDTable"
		)
    RequiredModules = @()
}

New-ModuleManifest @manifestParameters

if ($prerelease -ne $null) {
	Update-ModuleManifest -Path "$OutputPath\UniversalDashboard.Materialize.psd1" -Prerelease $prerelease
}

