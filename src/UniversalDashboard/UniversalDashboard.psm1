if ($PSEdition -eq "Core") {
	Import-Module -Name "$PSScriptRoot/netstandard2.0/UniversalDashboard.dll" | Out-Null
} else {
	$MinDotNetVersion = 461808
	[int]$DotNetRelease = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full\').Release
 	if ($DotNetRelease -lt $MinDotNetVersion) {
		throw "Universal Dashboard requires .NET Framework version 4.7.2 or later when running within Windows PowerShell. https://www.microsoft.com/net/download/dotnet-framework-runtime"
	}

	Import-Module -Name "$PSScriptRoot/net472/UniversalDashboard.dll" | Out-Null
}

Import-Module (Join-Path $PSScriptRoot "UniversalDashboardServer.psm1")
Import-Module (Join-Path $PSScriptRoot "UniversalDashboard.Controls.psm1")

if ($Global:UDNoMaterialize)
{
	Import-Module (Join-Path $PSScriptRoot "Modules\UniversalDashboard.Materialize\UniversalDashboard.Materialize.psd1")
}
