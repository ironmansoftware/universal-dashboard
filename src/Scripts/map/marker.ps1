function New-UDMapMarker {
    param(
        [Parameter()]
        [string]$Id = (New-Guid).ToString(),
        [Parameter(ParameterSetName = "LatLng", Mandatory)]
        [float]$Longitude,
        [Parameter(ParameterSetName = "LatLng", Mandatory)]
        [float]$Latitude,
        [Parameter()]
        [string]$Attribution,
        [Parameter()]
        [int]$Opacity,
        [Parameter()]
        [int]$ZIndex,
        [Parameter()]
        [Hashtable]$Popup,
        [Parameter()]
        [Hashtable]$Icon,
        [Parameter(ParameterSetName = "GeoJSON", Mandatory)]
        [string]$GeoJSON
    )

    if ($PSCmdlet.ParameterSetName -eq 'GeoJSON') {
        $Json = $GeoJSON | ConvertFrom-Json
        $Coordinates = $Json.Geometry.Coordinates
        $Latitude = $Coordinates[1]
        $Longitude = $Coordinates[0]
    }

    @{
        type = "map-marker"
        isPlugin = $true
        assetId = $AssetId

        id = $id 
        longitude = $Longitude
        latitude = $Latitude
        attribution = $Attribution
        opacity = $Opacity
        zIndex = $ZIndex
        popup = $Popup 
        icon = $Icon
    }
}