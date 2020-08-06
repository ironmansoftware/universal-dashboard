function New-UDMonitor {
    param(
        [Parameter()]
        [string]$Id = [Guid]::NewGuid(),
        [Parameter()]
        [ValidateSet('bar', 'line', 'area', 'doughnut', 'radar', 'pie', 'horizontalBar')]
		[string]$Type = 'line',
		[Parameter(Mandatory)]
		[string]$Title,
		[Parameter()]
		[int]$DataPointHistory = 10,
		[Parameter()]
		[Hashtable]$Options,
		[Parameter()]
		[DashboardColor[]]$ChartBackgroundColor,
		[Parameter()]
		[DashboardColor[]]$ChartBorderColor,
		[Parameter()]
		[DashboardColor]$BackgroundColor,
		[Parameter()]
		[string]$Width,
		[Parameter()]
		[string]$Height = '500px',
		[Parameter()]
		[DashboardColor]$FontColor,
		[Parameter()]
		[int]$BorderWidth = 1,
		[Parameter()]
		[string[]]$Labels = @(),
		[Parameter()]
		[Hashtable[]]$Links,
		[Parameter()]
        [ScriptBlock]$FilterFields,
        [Parameter()]
        [Switch]$AutoRefresh,
        [Parameter()]
        [int]$RefreshInterval = 5,
        [Parameter(Mandatory)]
        [Endpoint]$Endpoint
    )

    $Endpoint.Register($Id, $PSCmdlet) | Out-Null

    if (-not $Labels)
    {
        $Labels = @($Title)
    }

    @{
        type = 'ud-monitor'
        id = $id 
        live = $true
        labels = $Labels
        title = $title 
        dataPointHistory = $DataPointHistory
        chartType = $Type.ToLower()
        options = $Options
        width = $Width 
        height = $Height 
        autoRefresh = $AutoRefresh
        refreshInterval = $RefreshInterval 
        backgroundColor = $BackgroundColor.HtmlColor 
        fontColor = $FontColor.HtmlColor
        links = $Links 
        chartBackgroundColor = if($chartBackgroundColor) { $chartBackgroundColor.HtmlColor } else { @() }
        chartBorderColor = if ($ChartBorderColor) { $ChartBorderColor.HtmlColor } else { @() }
    }
}