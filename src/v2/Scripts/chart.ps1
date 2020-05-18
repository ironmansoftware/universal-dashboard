function New-UDChart {
    param(
        [Parameter()]
        [string]$Id = [Guid]::NewGuid(),
        [Parameter()]
		[string[]]$Labels,
        [Parameter()]
        [ValidateSet('bar', 'line', 'area', 'doughnut', 'radar', 'pie', 'horizontalBar')]
		[string]$Type,
		[Parameter()]
		[string]$Title,
		[Parameter()]
		[Hashtable]$Options,
		[Parameter()]
		[string]$Width = "100%",
		[Parameter()]
		[string]$Height = "500px",
		[Parameter()]
		[DashboardColor]$BackgroundColor,
		[Parameter()]
		[DashboardColor]$FontColor,
		[Parameter()]
		[Hashtable[]]$Links,
		[Parameter()]
		[ScriptBlock]$FilterFields,
		[Parameter()]
        [Endpoint]$OnClick,
        [Parameter()]
        [Switch]$AutoRefresh,
        [Parameter()]
        [int]$RefreshInterval,
        [Parameter(Mandatory)]
        [Endpoint]$Endpoint
    )

    $Endpoint.Register($Id, $PSCmdlet) | Out-Null

    @{
        type = 'ud-chart'
        id = $id 
        labels = $Labels
        title = $title 
        chartType = $Type.ToLower()
        options = $Options
        width = $Width 
        height = $Height 
        autoRefresh = $AutoRefresh
        refreshInterval = $RefreshInterval 
        backgroundColor = $BackgroundColor.HtmlColor 
        fontColor = $FontColor.HtmlColor
        links = $Links 
    }
}