param(
    [switch]$Enterprise,
    [switch]$Force,
    [switch]$Core
)

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$Url = "https://api.github.com/repos/ironmansoftware/universal-dashboard"
if ($Enterprise)
{
    $Url = "https://api.github.com/repos/ironmansoftware/universal-dashboard-enterprise"
}

$Url += "/releases"

$Release = (Invoke-RestMethod $Url) | Select-Object -First 1
$Asset = (Invoke-RestMethod $Release.assets_url) | Select-Object -First 1

$Zip = (Join-Path ([IO.Path]::GetTempPath()) "UniversalDashboard.zip")

Invoke-WebRequest $Asset.browser_download_url -OutFile $Zip 

$ModuleName = "UniversalDashboard.Community"

if ($Enterprise)
{
    $ModuleName = "UniversalDashboard"
}

$TempPath = (Join-Path ([IO.Path]::GetTempPath()) $ModuleName) 
if (Test-Path $TempPath)
{
    Remove-Item $TempPath -Force -Recurse
}

Expand-Archive $Zip $TempPath

$Manifest = Get-Content (Join-Path $TempPath "$ModuleName.psd1") -Raw

$UdManifest = Invoke-Expression $Manifest 

$Version = $UdManifest.ModuleVersion

if ($Core)
{
    $ModulePath = [IO.Path]::Combine("$env:USERPROFILE/Documents/PowerShell/Modules", $ModuleName, $Version)
}
else 
{
    $ModulePath = [IO.Path]::Combine("$env:USERPROFILE/Documents/WindowsPowerShell/Modules", $ModuleName, $Version)
}

if ($Force -and (Test-Path $ModulePath))
{
    Remove-Item $ModulePath -Force -Recurse
}

Copy-Item $TempPath $ModulePath -Recurse

if (Test-Path $Zip)
{
    Remove-Item $Zip -Force -Recurse
}

if (Test-Path $TempPath)
{
    Remove-Item $TempPath -Force -Recurse
}
