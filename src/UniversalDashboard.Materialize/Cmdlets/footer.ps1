function New-UDFooter {
    param(
        [Parameter()]
        [object[]]$Links,
        [Parameter()]
        [string]$Copyright,
        [Parameter()]
        [UniversalDashboard.Model.DashboardColor]$BackgroundColor,
        [Parameter()]
        [UniversalDashboard.Model.DashboardColor]$FontColor
    )

    @{
        type = 'footer'
        isPlugin = $true
        assetId = $Script:AssetId
        links = $Links
        copyright = $Copyright
        backgroundColor = $BackgroundColor.HtmlColor
        fontColor = $FontColor.HtmlColor
    }
}