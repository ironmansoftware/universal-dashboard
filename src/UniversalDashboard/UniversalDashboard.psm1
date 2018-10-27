if ($PSEdition -eq "Core") {
	Import-Module -Name "$PSScriptRoot/netstandard2.0/UniversalDashboard.dll" | Out-Null
} else {
	$DotNetVersion = [Version](Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full\').Version
	if ($DotNetVersion -lt [Version]::new(4, 7)) {
		throw "Universal Dashboard requires .NET Framework version 4.7 or later when running within Windows PowerShell"
	}

	Import-Module -Name "$PSScriptRoot/net471/UniversalDashboard.dll" | Out-Null
}

Import-Module (Join-Path $PSScriptRoot "UniversalDashboardServer.psm1")
Import-Module (Join-Path $PSScriptRoot "UniversalDashboard.Controls.psm1")