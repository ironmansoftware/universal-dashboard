Import-Module -Name "$PSScriptRoot/netstandard2.0/UniversalDashboard.dll" | Out-Null

Import-Module (Join-Path $PSScriptRoot "UniversalDashboardServer.psm1")
Import-Module (Join-Path $PSScriptRoot "UniversalDashboard.Controls.psm1")
Import-Module (Join-Path $PSScriptRoot "Modules\UniversalDashboard.Materialize\UniversalDashboard.Materialize.psd1")
Import-Module (Join-Path $PSScriptRoot "Modules\UniversalDashboard.MaterialUI\UniversalDashboard.MaterialUI.psd1")

$TAType = [psobject].Assembly.GetType("System.Management.Automation.TypeAccelerators")
$TAtype::Add("DashboardColor", "UniversalDashboard.Models.DashboardColor")
