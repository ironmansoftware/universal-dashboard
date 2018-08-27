param(
    [ValidateSet("Debug", "Release")]
	[string]$Configuration = "Debug",
	[Switch]$NoHelp,
	[Switch]$Test
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

& dotnet publish -c $Configuration "$PSScriptRoot\UniversalDashboard\UniversalDashboard.csproj" -f net471
& dotnet publish -c $Configuration "$PSScriptRoot\UniversalDashboard.Server\UniversalDashboard.Server.csproj" -f net471

Push-Location "$PSScriptRoot\client"

Start-Process npm -ArgumentList "install" -Wait

& npm run build
Pop-Location

$outputDirectory = Join-Path $PSScriptRoot "output"
if ((Test-Path $outputDirectory)) {
	Remove-Item $outputDirectory -Force -Recurse
}

New-Item -ItemType Directory $outputDirectory

$net471 = Join-Path $outputDirectory "net471"
$netstandard20 = Join-Path $outputDirectory "netstandard2.0"
$help = Join-Path $outputDirectory "en-US"
$client = Join-Path $outputDirectory "client"
$poshud = Join-Path $outputDirectory "poshud"

New-Item -ItemType Directory net471
New-Item -ItemType Directory $netstandard20
New-Item -ItemType Directory $help
New-Item -ItemType Directory $client

Copy-Item "$PSScriptRoot\UniversalDashboard\bin\$Configuration\netstandard2.0\publish\*" $netstandard20 -Recurse
Copy-Item "$PSScriptRoot\UniversalDashboard\bin\$Configuration\net471\publish\*" $net471 -Recurse

Copy-Item "$PSScriptRoot\client\src\public\*" $client -Recurse

Copy-Item "$PSScriptRoot\UniversalDashboard.Server\bin\$Configuration\netstandard2.0\publish\UniversalDashboard.Server.dll" $netstandard20
Copy-Item "$PSScriptRoot\UniversalDashboard.Server\bin\$Configuration\netstandard2.0\publish\UniversalDashboard.Server.deps.json" $netstandard20
Copy-Item "$PSScriptRoot\UniversalDashboard.Server\bin\$Configuration\netstandard2.0\publish\DasMulli.Win32.ServiceUtils.dll" $netstandard20

Copy-Item "$PSScriptRoot\UniversalDashboard.Server\bin\$Configuration\net471\publish\UniversalDashboard.Server.exe" $net471
Copy-Item "$PSScriptRoot\UniversalDashboard.Server\bin\$Configuration\net471\publish\DasMulli.Win32.ServiceUtils.dll" $net471

Copy-Item "$PSScriptRoot\web.config" $outputDirectory
Copy-Item "$PSScriptRoot\UniversalDashboard\UniversalDashboard.psm1" $outputDirectory
Copy-Item "$PSScriptRoot\UniversalDashboard\UniversalDashboardServer.psm1" $outputDirectory
Copy-Item "$PSScriptRoot\UniversalDashboard\bin\$Configuration\net471\UniversalDashboard.Controls.psm1" $outputDirectory
Copy-Item "$PSScriptRoot\poshud" $poshud -Recurse -Container

. "$PSScriptRoot\CorFlags.exe" /32BITREQ-  "$outputDirectory\net471\UniversalDashboard.Server.exe" 

. (Join-Path $PSScriptRoot 'UniversalDashboard\New-UDModuleManifest.ps1') -outputDirectory $outputDirectory

if (-not $NoHelp) {
	New-ExternalHelp -Path "$PSScriptRoot\UniversalDashboard\Help" -OutputPath $help
}

if ($Test) {
	. "$PSScriptRoot\UniversalDashboard.UITest\shebang.tests.ps1" -Release
}

