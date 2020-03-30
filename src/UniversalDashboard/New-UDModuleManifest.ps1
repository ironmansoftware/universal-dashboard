param(
    $outputDirectory,
    $Configuration = "Release"
)

Remove-Item  (Join-Path $outputDirectory 'UniversalDashboard.Community.psd1') -ErrorAction SilentlyContinue -Force

$version = "3.0.0"
$prerelease = "-beta1"

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
		"New-UDAppBar"
		"New-UDDrawer"
		"Out-UDChartData", 
		"Out-UDGridData", 
		"Out-UDTableData", 
		"New-UDChartDataset",
		"Out-UDMonitorData",
		"Get-UDCookie",
		"Set-UDCookie",
		"Remove-UDCookie",
		"New-UDPolarChartDataset",
		"New-UDDoughnutChartDataset",
		"New-UDRadarChartDataset",
		"New-UDBarChartDataset",
		"New-UDLineChartDataset",
		"New-UDChartOptions",
		"New-UDLogarithmicChartAxis",
		"New-UDCategoryChartAxis",
		"New-UDLinearChartAxis",
		"New-UDPolarChartOptions",
		"New-UDDoughnutChartOptions",
		"New-UDBarChartOptions",
		"New-UDLineChartOptions",
		"New-UDChartTooltipOptions",
		"New-UDChartTitleOptions",
		"New-UDChartLegendLabelOptions",
		"New-UDChartLegendOptions",
		"New-UDChartLayoutOptions",
		"Set-UDContentType",
		"Get-UDContentType",
		"Update-UDDashboard",
		"New-UDGrid", 
		"New-UDTable",
		"New-UDRow", 
		"New-UDColumn", 
		"New-UDCard",
		"New-UDCollapsible",
		"New-UDCollapsibleItem",
		"New-UDLayout",
		"New-UDParagraph",
		"New-UDHeading",
		"New-UDLink",
		"New-UDIFrame",
		"New-UDIcon",
		"New-UDPreloader",
		"New-UDSelect",
		"New-UDSelectOption",
		"New-UDSelectGroup",
		"New-UDCollection",
		"New-UDCollectionItem",
		"New-UDSpan", 
		"New-UDCheckbox", 
		"Write-UDLog",
		"New-UDButton",
		"New-UDSwitch",
		"New-UDRadio",
		"New-UDTextbox",
		"New-UDImage"
		"New-UDFab"
		"New-UDFabButton"
		"New-UDTab"
		"New-UDTabContainer"
		"New-UDGridLayout"
		"New-UDImageCarousel"
		"New-UDImageCarouselItem"
		"New-UDSplitPane"
		"New-UDTreeNode"
		"New-UDTreeView"
        "New-UDTooltip"
		"Invoke-UDEvent"
		'New-UDAvatar'
		'New-UDCardToolbar'
		'New-UDCardHeader'
		'New-UDCardBody'
		'New-UDCardExpand'
		'New-UDCardFooter'
		'New-UDCardMedia'
		'New-UDChip'
		'New-UDIconButton'
		'New-UDList'
		'New-UDListItem'
		'New-UDPaper'
		'New-UDTypography'
		"New-UDTableColumn"
		"New-UDExpansionPanelGroup"
        "New-UDExpansionPanel"
		"New-UDFloatingActionButton"
		"New-UDTabs"
		"New-UDProgress"
		"Out-UDTableData"
		"New-UDForm"
		"New-UDDatePicker"
		"New-UDTimePicker"
		"New-UDRadio"
		"New-UDRadioGroup"
		"New-UDContainer"
		"New-UDAutocomplete"
	)
	CmdletsToExport = @("New-UDChart", 
						"New-UDDashboard", 
						"Get-UDDashboard",
						"Start-UDDashboard", 
						"Stop-UDDashboard", 
						"New-UDMonitor", 
						"New-UDHtml",
						"New-UDCounter", 
						"New-UDPage",
						"Enable-UDLogging",
						"Disable-UDLogging",
						"New-UDInput",
						"New-UDInputAction",
						"New-UDEndpoint",
						"Start-UDRestApi",
						"Stop-UDRestApi",
						"Get-UDRestApi",
						"New-UDInputField",
						"New-UDFooter",
						"New-UDElement",
						"New-UDTheme",
						"Get-UDTheme"
						"Add-UDElement",
						"Set-UDElement",
						"Remove-UDElement",
						"Clear-UDElement",
						"Get-UDElement",
						"New-UDEndpointSchedule",
						"Show-UDToast",
						"Sync-UDElement",
						"ConvertTo-JsonEx",
						"Invoke-UDRedirect",
						"Show-UDModal",
						"Hide-UDModal",
						"Select-UDElement",
                        "Set-UDClipboard",
                        "Invoke-UDJavaScript",
						"Hide-UDToast"
						"Publish-UDFolder"
						"New-UDEndpointInitialization"
						"New-UDSideNav"
						"New-UDSideNavItem"
						"Clear-UDCache"
						"New-UDDynamic"
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
