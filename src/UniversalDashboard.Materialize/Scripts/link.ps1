function New-UDLink {
    param(
        [Parameter()]
        [string]$Text, 
        [Parameter()]
        [string]$Url, 
        [Parameter()]
        [string]$Icon,
        [Parameter()]
        [switch]$OpenInNewWindow,
        [Parameter()]
        [UniversalDashboard.Models.DashboardColor]$FontColor
    )

    End {
        @{
            type = 'ud-link'
            isPlugin = $true 
            assetId = $AssetId

            text = $Text 
            url = $Url 
            icon = $Icon 
            openInNewWindow = $OpenInNewWindow.IsPresent
            color = $FontColor.HtmlColor
        }
    }
}