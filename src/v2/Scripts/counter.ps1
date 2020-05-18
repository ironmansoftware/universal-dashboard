function New-UDCounter {
    param(
        [Parameter()]
        [string]$Id = [Guid]::NewGuid(),
        [Parameter()]
		[string]$Title,
		[Parameter()]
		[string]$Format = "0,0",
		[Parameter()]
		[string]$Icon,
		[Parameter()]
		[DashboardColor]$BackgroundColor,
		[Parameter()]
		[DashboardColor]$FontColor,
	    [Parameter()]
        [Hashtable[]]$Links,
		[Parameter()]
		[string]$TextSize,
		[Parameter()]
		[string]$TextAlignment,
		[Parameter()]
        [Endpoint]$OnClick,
        [Parameter()]
        [Switch]$AutoRefresh,
        [Parameter()]
        [int]$RefreshInterval,
        [Parameter()]
        [Endpoint]$Endpoint
    )

    @{
        type = "ud-counter"
        id = $id 
        title = $title 
        format = $format 
        icon = $icon 
        backgroundColor = $BackgroundColor.HtmlColor
        fontColor = $FontColor.HtmlColor
        links = $Links 
        textSize = $TextSize 
        textAlignment = $TextAlignment
        autoRefresh = $AutoRefresh.IsPresent
        refreshInterval = $RefreshInterval 
    }
}