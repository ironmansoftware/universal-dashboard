param($TargetDir)

if ($Env:APPVEYOR) {
    $BuildFolder = $env:APPVEYOR_BUILD_FOLDER
} else {
    $BuildFolder = $PSScriptRoot
}

$powerShellGet = Import-Module PowerShellGet  -PassThru -ErrorAction Ignore
if ($powerShellGet.Version -lt ([Version]'1.6.0')) {
	Install-Module PowerShellGet -Scope CurrentUser -Force -AllowClobber
	Import-Module PowerShellGet -Force
}

Set-Location $BuildFolder

$OutputPath = "$BuildFolder\output\UniversalDashboard.MaterializeCss"

Remove-Item -Path $OutputPath -Force -ErrorAction SilentlyContinue -Recurse
Remove-Item -Path "$BuildFolder\client\public" -Force -ErrorAction SilentlyContinue -Recurse

New-Item -Path $OutputPath -ItemType Directory

Push-Location "$BuildFolder\client"

npm install
npm run build

Pop-Location

Copy-Item $BuildFolder\client\public\*.bundle.js $OutputPath
Copy-Item $BuildFolder\UniversalDashboard.MaterializeCss.psm1 $OutputPath
New-Item "$OutputPath\Cmdlets" -ItemType Directory
Copy-Item $BuildFolder\Cmdlets\**.* "$OutputPath\Cmdlets"

$Version = "1.0.0"

$manifestParameters = @{
	Path = "$OutputPath\UniversalDashboard.MaterializeCss.psd1"
	Author = "Adam Driscoll"
	CompanyName = "Ironman Software, LLC"
	Copyright = "2019 Ironman Software, LLC"
	RootModule = "UniversalDashboard.Materialize.psm1"
	Description = "Materialize bundle for Universal Dashboard."
	ModuleVersion = $version
	Tags = @("universaldashboard", "materialize")
	ReleaseNotes = "Initial release"
	FunctionsToExport = @("New-UDCounter")
	CmdletsToExport = @()
    RequiredModules = @()
}

New-ModuleManifest @manifestParameters

if ($prerelease -ne $null) {
	Update-ModuleManifest -Path "$OutputPath\UniversalDashboard.MaterializeCss.psd1" -Prerelease $prerelease
}

if ($null -ne $TargetDir) {
	Copy-Item "$BuildFolder\output\UniversalDashboard.MaterializeCss" $TargetDir
}