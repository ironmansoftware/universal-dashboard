function New-UDMonitor {
    param(
        [Parameter(Mandatory)]
        [object]$Endpoint,
        [Parameter()]
        [string]$Id = (New-Guid).ToString(),
        [Parameter()]
        [Switch]$AutoRefresh,
        [Parameter()]
        [int]$RefreshInterval,
        [Parameter()]
		[string[]]$Labels,
        [Parameter()]
        [ValidateSet('Bar', 'Line', 'Area', 'Doughnut', 'Radar', 'Pie', 'HorizontalBar')]
		[string]$Type,
		[Parameter()]
		[string]$Title,
		[Parameter()]
		[Hashtable]$Options,
		[Parameter()]
		[string]$Width,
		[Parameter()]
		[string]$Height,
		[Parameter()]
		[UniversalDashboard.Models.DashboardColor]$BackgroundColor,
		[Parameter()]
		[UniversalDashboard.Models.DashboardColor]$FontColor,
		[Parameter()]
		[object[]]$Links,
		[Parameter()]
        [ScriptBlock]$FilterFields,
        [Parameter()]
		[int]$DataPointHistory = 10
    )

    @{
        type = 'monitor'
        isPlugin = $true 
        assetId = $Script:AssetId
        id = $Id
        labels = $Labels
        title = $Title
        chartType = $Type
        options = $Options
        width = $Width
        height = $Height
        autoRefresh = $AutoRefresh
        refreshInterval = $RefreshInterval
        backgroundColor = $BackgroundColor.HtmlColor
        fontColor = $FontColor.HtmlColor
        links = $Links
        filterFields = $FilterFields.Invoke()
        live = $true
        dataPointRetention = $DataPointHistory 
    }
}