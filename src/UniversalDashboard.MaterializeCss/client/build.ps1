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

$OutputPath = "$BuildFolder\output\UniversalDashboard.Charts"

Remove-Item -Path $OutputPath -Force -ErrorAction SilentlyContinue -Recurse
Remove-Item -Path "$BuildFolder\public" -Force -ErrorAction SilentlyContinue -Recurse

New-Item -Path $OutputPath -ItemType Directory

Push-Location "$BuildFolder\classes"

dotnet build -c Release 
Copy-Item "$BuildFolder\classes\bin\Release\netstandard2.0\classes.dll" -Destination $OutputPath

Pop-Location

npm install
npm run build

Copy-Item $BuildFolder\public\*.bundle.js $OutputPath
Copy-Item $BuildFolder\UniversalDashboard.Charts.psm1 $OutputPath

$Version = "1.0.0"

$manifestParameters = @{
	Path = "$OutputPath\UniversalDashboard.Charts.psd1"
	Author = "Adam Driscoll"
	CompanyName = "Ironman Software, LLC"
	Copyright = "2019 Ironman Software, LLC"
	RootModule = "UniversalDashboard.Charts.psm1"
	Description = "Charts bundle for Universal Dashboard."
	ModuleVersion = $version
	Tags = @("universaldashboard", "charts")
	ReleaseNotes = "Initial release"
	FunctionsToExport = @()
	NestedModules = @("classes.dll")
	CmdletsToExport = @("New-UDNivoChart", "New-UDNivoChartAxisOptions", "New-UDNivoFill", "New-UDNivoPattern", "New-UDSparklines")
    RequiredModules = @()
}

New-ModuleManifest @manifestParameters

if ($prerelease -ne $null) {
	Update-ModuleManifest -Path "$OutputPath\UniversalDashboard.Charts.psd1" -Prerelease $prerelease
}

