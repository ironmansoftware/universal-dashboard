function New-UDMapLayerControl {
    param(
        [Parameter()]
        [string]$Id = (New-Guid).ToString(),
        [Parameter()]
        [ValidateSet("topright", "topleft", "bottomright", "bottomleft")]
        [string]$Position = "topright",
        [Parameter()]
        [ScriptBlock]$Content
    )

    @{
        type = 'map-layer-control'
        isPlugin = $true
        assetId = $AssetId
        id = $Id
        content = & $Content
        position = $Position
    }
}