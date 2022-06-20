function New-UDMapRasterLayer {
    param(
        [Parameter()]
        [string]$Id = (New-Guid).ToString(),
        [Parameter(ParameterSetName = "Generic")]
        [string]$TileServer = 'https://a.tile.openstreetmap.org/{z}/{x}/{y}.png',
        [Parameter(ParameterSetName = "Bing", Mandatory)]
        [string]$ApiKey,
        [Parameter(ParameterSetName = "Bing")]
        [ValidateSet("Aerial", "AerialWithLabels", "AerialWithLabelsOnDemand", "CanvasDark", "CanvasLight", "CanvasGray", "Road")]
        [string]$Type = "Aerial",
        [Parameter(ParameterSetName = "Bing", Mandatory)]
        [Switch]$Bing,
        [Parameter()]
        [string]$Attribution,
        [Parameter()]
        [int]$Opacity,
        [Parameter()]
        [int]$ZIndex,
        [Parameter()]
        [string]$Name
    )

    @{
        type = "map-raster-layer"
        isPlugin = $true
        assetId = $AssetId

        id = $id
        tileServer = $TileServer
        apiKey = $ApiKey
        attribution = $Attribution
        opacity = $Opactiy
        zIndex = $ZIndex
        name = $Name
        bing = $Bing.IsPresent
        mapType = $Type 
    }
}