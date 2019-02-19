function New-UDCounter {
    param(
        [Parameter()]
        [string]$Id = (New-Guid).ToString(),
        [Parameter()]
        [string]$Title,
        [Parameter()]
        [string]$Format = '0,0',
        [Parameter()]
        [UniversalDashboard.Models.FontAwesomeIcon]$Icon,
        [Parameter()]
        [UniversalDashboard.Models.DashboardColor]$BackgroundColor, 
        [Parameter()]
        [UniversalDashboard.Models.DashboardColor]$FontColor,
        [Parameter()]
        [object[]]$Links,
        [Parameter()]
        [ValidateSet("small", "medium", "large")]
        [string]$TextSize,
        [Parameter()]
        [ValidateSet("left", "center", "right")]
        [string]$TextAlignment,
        [Parameter(Mandatory)]
        [object]$Endpoint
    )

    $callback = $Endpoint
    if (-not ($callback -is [UniversalDashboard.Models.Endpoint]))
    {
        $callback = New-UDEndpoint -Endpoint $Endpoint -Id $Id
    }

    @{
        isPlugin = $true
        assetId = $Script:AssetId
        id = $Id
        title = $Title 
        format = $Format 
        icon = $Icon.ToString().Replace('_', '-')
        backgroundColor = $BackgroundColor.HtmlColor
        fontColor = $FontColor.HtmlColor
        links = $Links 
        textSize = $TextSize 
        textAlignment = $TextAlignment
        type = 'counter'
    }
}