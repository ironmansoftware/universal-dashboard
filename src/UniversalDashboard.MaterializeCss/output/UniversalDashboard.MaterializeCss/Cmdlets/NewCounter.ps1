function New-UDCounter {
    param(
        [Parameter()]
        [String]$Title,
        [Parameter()]
        [String]$Format = '0,0',
        [Parameter()]
        [UniversalDashboard.Models.FontAwesomeIcons]$Icon,
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
        [ValidateSet("left", "center", 'right')]
        [string]$TextAlignment,
        [Parameter()]
        [object]$Endpoint,
        [Parameter()]
        [object[]]$ArgumentList,
        [Parameter()]
        [Switch]$AutoRefresh = 5,
        [Parameter()]
        [int]$RefreshInterval,
        [Parameter()]
        [string]$Id = [System.Guid]::NewGuid()
    )

    End {

        if ($Endpoint -is [ScriptBlock]) {
            $Endpoint = New-UDEndpoint -Id $Id -Endpoint $Endpoint -ArgumentList $ArgumentList
        }

        $htmlBackgroundColor = $null
        if ($null -ne $BackgroundColor) {
            $htmlBackgroundColor = $BackgroundColor.HtmlColor
        }

        $htmlFontColor = $null
        if ($null -ne $FontColor) {
            $htmlFontColor = $FontColor.HtmlColor
        }

        @{
            autoRefresh = $AutoRefresh.IsPresent
            refreshInterval = $RefreshInterval
            hasCallback = $null -ne $Endpoint
            format = $Format
            icon = [UniversalDashboard.Models.FontAwesomeIconExtensions]::GetIconName($Icon)
            title = $Title
            id = $id 
            backgroundColor = $htmlBackgroundColor
            fontColor = $htmlFontColor
            links = $Links
            textSize = $TextSize
            textAlignment = $TextAlignment
            type = "counter"
            isPlugin = $true 
            assetId = $Script:AssetId
        }
    }
}