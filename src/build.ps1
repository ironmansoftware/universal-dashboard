param(
    [ValidateSet("Debug", "Release")]
	[string]$Configuration = "Debug",
	[Switch]$Minimal
)

$platyPS = Import-Module platyPS  -PassThru -ErrorAction Ignore
if ($platyPS -eq $null) {
	Install-Module platyPS -Scope CurrentUser -Force
	Import-Module platyPS -Force
}

$powerShellGet = Import-Module PowerShellGet  -PassThru -ErrorAction Ignore

if ($powerShellGet.Version -lt ([Version]'1.6.0')) {
	Install-Module PowerShellGet -Scope CurrentUser -Force -AllowClobber
	Import-Module PowerShellGet -Force
}

if (-not $Minimal)
{
	& dotnet tool install --global CycloneDX
	& dotnet CycloneDX "$PSScriptRoot/UniversalDashboard.Sln" -o ".\"
}


& dotnet clean "$PSScriptRoot\UniversalDashboard\UniversalDashboard.csproj"
& dotnet restore "$PSScriptRoot\UniversalDashboard\UniversalDashboard.csproj" 
  
& dotnet publish -c $Configuration "$PSScriptRoot\UniversalDashboard\UniversalDashboard.csproj" -f netstandard2.0
& dotnet publish -c $Configuration "$PSScriptRoot\UniversalDashboard\UniversalDashboard.csproj" -f net472

$public = Join-Path $PSScriptRoot ".\client\src\public"
if ((Test-Path $public)) {
	Remove-Item $public -Force -Recurse
}

Push-Location "$PSScriptRoot\client"

if (-not $Minimal)
{
	& npm install
	& npm install -g @cyclonedx/bom
	& cyclonedx-bom -o core.bom.xml	
	Rename-Item "bom.xml" "dotnet.bom.xml"
}

& npm run build
Pop-Location

$outputDirectory = Join-Path $PSScriptRoot "output"
if ((Test-Path $outputDirectory)) {
	Remove-Item $outputDirectory -Force -Recurse
}

New-Item -ItemType Directory $outputDirectory

$bomDirectory = Join-Path $PSScriptRoot "boms"
if ((Test-Path $bomDirectory)) {
	Remove-Item $bomDirectory -Force -Recurse
}

New-Item -ItemType Directory $bomDirectory

$net472 = Join-Path $outputDirectory "net472"
$netstandard20 = Join-Path $outputDirectory "netstandard2.0"
$help = Join-Path $outputDirectory "en-US"
$client = Join-Path $outputDirectory "client"
$poshud = Join-Path $outputDirectory "poshud"
$childModules = Join-Path $outputDirectory "Modules"

New-Item -ItemType Directory $net472
New-Item -ItemType Directory $netstandard20
New-Item -ItemType Directory $help
New-Item -ItemType Directory $client
New-Item -ItemType Directory $childModules

Copy-Item "$PSScriptRoot\UniversalDashboard\bin\$Configuration\netstandard2.0\publish\*" $netstandard20 -Recurse
Copy-Item "$PSScriptRoot\UniversalDashboard\bin\$Configuration\net472\publish\*" $net472 -Recurse

Copy-Item "$PSScriptRoot\client\src\public\*" $client -Recurse

Copy-Item "$PSScriptRoot\web.config" $outputDirectory
Copy-Item "$PSScriptRoot\UniversalDashboard\UniversalDashboard.psm1" $outputDirectory
Copy-Item "$PSScriptRoot\UniversalDashboard\UniversalDashboardServer.psm1" $outputDirectory
Copy-Item "$PSScriptRoot\UniversalDashboard\bin\$Configuration\net472\UniversalDashboard.Controls.psm1" $outputDirectory
Copy-Item "$PSScriptRoot\poshud" $poshud -Recurse -Container

Copy-Item "$PSScriptRoot\..\LICENSE" "$outputDirectory\LICENSE.txt" 

. (Join-Path $PSScriptRoot 'UniversalDashboard\New-UDModuleManifest.ps1') -outputDirectory $outputDirectory

if (-not $Minimal) {
	New-ExternalHelp -Path "$PSScriptRoot\UniversalDashboard\Help" -OutputPath "$help\UniversalDashboard.Community-help.xml"
	Get-ChildItem $PSScriptRoot -Include "*.bom.xml" -Recurse | ForEach-Object { Copy-Item $_.FullName ".\boms" }
}