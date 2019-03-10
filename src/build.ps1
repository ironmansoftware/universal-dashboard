param(
    [ValidateSet("Debug", "Release")]
	[string]$Configuration = "Debug",
	[Switch]$NoHelp
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

& dotnet clean "$PSScriptRoot\UniversalDashboard\UniversalDashboard.csproj"
& dotnet restore "$PSScriptRoot\UniversalDashboard\UniversalDashboard.csproj" 
  
& dotnet publish -c $Configuration "$PSScriptRoot\UniversalDashboard\UniversalDashboard.csproj" -f netstandard2.0
& dotnet publish -c $Configuration "$PSScriptRoot\UniversalDashboard.Server\UniversalDashboard.Server.csproj" -f netstandard2.0 

& dotnet publish -c $Configuration "$PSScriptRoot\UniversalDashboard\UniversalDashboard.csproj" -f net472
& dotnet publish -c $Configuration "$PSScriptRoot\UniversalDashboard.Server\UniversalDashboard.Server.csproj" -f net472

Push-Location "$PSScriptRoot\client"

Start-Process npm -ArgumentList "install" -Wait

& npm run build
Pop-Location

# Build Child Modules 

Push-Location "$PSScriptRoot\UniversalDashboard.Materialize"
.\build.ps1
Pop-Location

Push-Location "$PSScriptRoot\UniversalDashboard.MaterialUI"
.\build.ps1
Pop-Location

# End Build Child Modules

$outputDirectory = Join-Path $PSScriptRoot "output"
if ((Test-Path $outputDirectory)) {
	Remove-Item $outputDirectory -Force -Recurse
}

New-Item -ItemType Directory $outputDirectory

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

Copy-Item "$PSScriptRoot\UniversalDashboard.Server\bin\$Configuration\netstandard2.0\publish\UniversalDashboard.Server.dll" $netstandard20
Copy-Item "$PSScriptRoot\UniversalDashboard.Server\bin\$Configuration\netstandard2.0\publish\UniversalDashboard.Server.deps.json" $netstandard20
Copy-Item "$PSScriptRoot\UniversalDashboard.Server\bin\$Configuration\netstandard2.0\publish\DasMulli.Win32.ServiceUtils.dll" $netstandard20

Copy-Item "$PSScriptRoot\UniversalDashboard.Server\bin\$Configuration\net472\publish\UniversalDashboard.Server.exe" $net472
Copy-Item "$PSScriptRoot\UniversalDashboard.Server\bin\$Configuration\net472\publish\UniversalDashboard.Server.exe.config" $net472
Copy-Item "$PSScriptRoot\UniversalDashboard.Server\bin\$Configuration\net472\publish\DasMulli.Win32.ServiceUtils.dll" $net472

Copy-Item "$PSScriptRoot\web.config" $outputDirectory
Copy-Item "$PSScriptRoot\UniversalDashboard\UniversalDashboard.psm1" $outputDirectory
Copy-Item "$PSScriptRoot\UniversalDashboard\UniversalDashboardServer.psm1" $outputDirectory
Copy-Item "$PSScriptRoot\UniversalDashboard\bin\$Configuration\net472\UniversalDashboard.Controls.psm1" $outputDirectory
Copy-Item "$PSScriptRoot\poshud" $poshud -Recurse -Container

# Copy Child Modules

Copy-Item "$PSScriptRoot\UniversalDashboard.Materialize\output\UniversalDashboard.Materialize" $childModules -Recurse -Container
Copy-Item "$PSScriptRoot\UniversalDashboard.MaterialUI\output\UniversalDashboard.MaterialUI" $childModules -Recurse -Container

# End Copy Child Modules 

. "$PSScriptRoot\CorFlags.exe" /32BITREQ-  "$outputDirectory\net472\UniversalDashboard.Server.exe" 

. (Join-Path $PSScriptRoot 'UniversalDashboard\New-UDModuleManifest.ps1') -outputDirectory $outputDirectory

if (-not $NoHelp) {
	New-ExternalHelp -Path "$PSScriptRoot\UniversalDashboard\Help" -OutputPath $help
}