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

npm install
npm run build

Copy-Item $BuildFolder\public\*.bundle.js $OutputPath
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
	FunctionsToExport = @("New-UDTab", "New-UDTabContainer")
    RequiredModules = @()
}

New-ModuleManifest @manifestParameters

if ($prerelease -ne $null) {
	Update-ModuleManifest -Path "$OutputPath\UniversalDashboard.Materialize.psd1" -Prerelease $prerelease
}

