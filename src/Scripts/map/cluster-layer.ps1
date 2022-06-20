function New-UDMapMarkerClusterLayer {
    param(
        [Parameter()]
        [string]$Id = (New-Guid).ToString(),
        [Parameter()]
        [Hashtable[]]$Markers,
        [Parameter()]
        [int]$MinimumClusterSize = 2,
        [Parameter()]
        [int]$GridSize = 60
    )

    @{
        type = "map-cluster-layer"
        isPlugin = $true
        assetId = $assetId 

        id = $id 
        markers = $Markers
        minClusterSize = $MinimumClusterSize
        gridSize = $GridSize
    }
}