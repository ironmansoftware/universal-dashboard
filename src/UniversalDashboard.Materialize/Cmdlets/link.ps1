function New-UDLink {
    param(
        [Parameter()]
        [string]$Text,
        [Parameter()]
        [string]$Url,
        [Parameter()]
        [UniversalDashboard.Models.FontAwesomeIcon]$Icon,
        [Parameter()]
        [Switch]$OpenInNewWindow,
        [Parameter()]
        [UniversalDashboard.Models.DashboardColor]$FontColor
    )

    @{
        type = 'link'
        isPlugin = $true 
        assetId = $Script:AssetId
        text = $Text 
        url = $Url 
        icon = $Icon.ToString().Replace("_", '-')
        openInNewWindows = $OpenInNewWindow 
        fontColor = $FontColor.HtmlColor
    }
}