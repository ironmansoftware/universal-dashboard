function New-UDMapHeatmapLayer {
    param(
        [Parameter(Mandatory)]
        $Points,
        [Parameter()]
        [string]$Id = (New-Guid).ToString(),
        [Parameter()]
        [double]$MaxIntensity,
        [Parameter()]
        [double]$Radius,
        [Parameter()]
        [int]$MaxZoom,
        [Parameter()]
        [double]$MinOpacity,
        [Parameter()]
        [int]$Blur,
        [Parameter()]
        [Hashtable]$Gradient
    )

    $Options = @{
        type = 'map-heatmap-layer'
        isPlugin = $true
        assetId = $AssetId
    }

    foreach($boundParameter in $PSCmdlet.MyInvocation.BoundParameters.GetEnumerator()) {
        $Options[[char]::ToLowerInvariant($boundParameter.Key[0]) + $boundParameter.Key.Substring(1)] = $boundParameter.Value
    }

    $Options
}