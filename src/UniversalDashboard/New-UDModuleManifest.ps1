param(
    $outputDirectory,
    $Configuration = "Release"
)

Remove-Item  (Join-Path $outputDirectory 'UniversalDashboard.Community.psd1') -ErrorAction SilentlyContinue -Force

$version = "3.0.0"
$prerelease = "-alpha1"

$manifestParameters = @{
	Guid = 'c7894dd1-357e-4474-b8e1-b416afd70c2d'
	Path = "$outputDirectory\UniversalDashboard.Community.psd1"
	Author = "Adam Driscoll"
	CompanyName = "Ironman Software, LLC"
	Copyright = "2020 Ironman Software, LLC"
	RootModule = "UniversalDashboard.psm1"
	Description = "Cross-platform module for developing websites and REST APIs."
	ModuleVersion = $version
	Tags = @("dashboard", "web", "linux", "windows", "asp.net", "website", "REST")
	ReleaseNotes = "https://github.com/ironmansoftware/universal-dashboard/blob/master/CHANGELOG.md"
	LicenseUri = "https://github.com/ironmansoftware/universal-dashboard/blob/master/LICENSE"
	ProjectUri = "https://github.com/ironmansoftware/universal-dashboard"
	IconUri = 'https://raw.githubusercontent.com/ironmansoftware/universal-dashboard/master/images/logo.png'
	PrivateData = $PrivateData
    DotNetFrameworkVersion = '4.7'
	PowerShellVersion = '5.0'
	FunctionsToExport = @(
		"Get-UDCookie",
		"Set-UDCookie",
		"Remove-UDCookie",
		"Update-UDDashboard",
		"Write-UDLog",
		"New-UDGridLayout"
		"Invoke-UDEvent"
        
	)
	CmdletsToExport = @(
						"New-UDDashboard", 
						"Get-UDDashboard",
						"Start-UDDashboard", 
						"Stop-UDDashboard", 
						"New-UDHtml",
						"New-UDPage",
						"Enable-UDLogging",
						"Disable-UDLogging",
						"New-UDEndpoint",
						"Start-UDRestApi",
						"Stop-UDRestApi",
						"Get-UDRestApi",
						"New-UDElement",
						"New-UDTheme",
						"Get-UDTheme"
						"Add-UDElement",
						"Set-UDElement",
						"Remove-UDElement",
						"Clear-UDElement",
						"Get-UDElement",
						"New-UDEndpointSchedule",
						"Sync-UDElement",
						"ConvertTo-JsonEx",
						"Invoke-UDRedirect",
						"Select-UDElement",
                        "Set-UDClipboard",
                        "Invoke-UDJavaScript",
						"Publish-UDFolder"
						"New-UDEndpointInitialization"
						"Clear-UDCache"
						)
}

New-ModuleManifest @manifestParameters

if ($prerelease -ne $null) {
	Update-ModuleManifest -Path "$outputDirectory\UniversalDashboard.Community.psd1" -Prerelease $prerelease
} 

if ($Configuration -eq "Debug") {
    @("UniversalDashboard.psm1", "UniversalDashboardServer.psm1", "UniversalDashboard.Community.psd1", "UniversalDashboard.Controls.psm1") | ForEach-Object {
        Copy-Item (Join-Path $outputDirectory $_) (Join-Path "$outputDirectory\..\" $_) -Force
    }
}
