function New-UDFooter {
    param(
        [Parameter()]
		[Hashtable[]]$Links,
        [Parameter()]
        [string]$Copyright,
		[Parameter()]
		[DashboardColor]$BackgroundColor,
		[Parameter()]
		[DashboardColor]$FontColor
    )

    @{
        type = "ud-footer"
        isPlugin = $true 
        assetId = $AssetId
        
        links = $Links 
        copyright = $Copyright 
        backgroundColor = $BackgroundColor.HtmlColor 
        fontColor = $FontColor.HtmlColor
    }
}