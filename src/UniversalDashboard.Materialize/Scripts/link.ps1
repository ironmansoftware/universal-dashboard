function New-UDLink {
    param(
        [Parameter()]
        [String]$Id = (New-Guid),
        [Parameter()]
        [string]$Text, 
        [Parameter()]
        [string]$Url, 
        [Parameter()]
        [string]$Icon,
        [Parameter()]
        [switch]$OpenInNewWindow,
        [Parameter()]
        [UniversalDashboard.Models.DashboardColor]$FontColor,
        [Parameter()]
        [object]$OnClick
    )

    End {

        if ($null -ne $OnClick) {
            if ($OnClick -is [scriptblock]) {
                $OnClick = New-UDEndpoint -Endpoint $OnClick -Id ($Id + "OnClick")
            }
            elseif ($OnClick -isnot [UniversalDashboard.Models.Endpoint]) {
                throw "OnClick must be a script block or UDEndpoint"
            }
        }

        @{
            type = 'ud-link'
            isPlugin = $true 
            assetId = $AssetId

            id = $Id
            text = $Text 
            url = $Url 
            icon = $Icon 
            openInNewWindow = $OpenInNewWindow.IsPresent
            color = $FontColor.HtmlColor
            onClick = $OnClick.Name
        }
    }
}