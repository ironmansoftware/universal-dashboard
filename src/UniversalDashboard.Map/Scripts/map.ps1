function New-UDMap {
    param(
        [Parameter()]
        [string]$Id = (New-Guid).ToString(),
        [Parameter()]
        [float]$Longitude,
        [Parameter()]
        [float]$Latitude,
        [Parameter()]
        [int]$Zoom,
        [Parameter()]
        [string]$Height = '500px',
        [Parameter()]
        [string]$Width = '100%',
        [Parameter(Mandatory)]
        [object]$Endpoint,
        [ValidateSet("topright", "topleft", "bottomright", "bottomleft")]
        [string]$ZoomControlPosition = "topright",
        [ValidateSet("topright", "topleft", "bottomright", "bottomleft", "hide")]
        [string]$ScaleControlPosition = "bottomleft",
        [Parameter()]
        [Switch]$Animate,
        [Parameter()]
        [int]$MaxZoom = 18
    )

    End {

        if ($Endpoint -is [scriptblock]) {
            $Endpoint = New-UDEndpoint -Endpoint $Endpoint -Id $Id
        }
        elseif ($Endpoint -isnot [UniversalDashboard.Models.Endpoint]) {
            throw "Endpoint must be a script block or UDEndpoint"
        }

        @{
            assetId = $AssetId 
            isPlugin = $true 
            type = "ud-map"
            id = $Id

            longitude = $Longitude
            latitude = $Latitude
            zoom = $Zoom
            height = $Height
            width = $Width
            zoomControlPosition = $ZoomControlPosition
            animate = $Animate.IsPresent
            scaleControlPosition = $ScaleControlPosition
            maxZoom = $MaxZoom
        }
    }
}