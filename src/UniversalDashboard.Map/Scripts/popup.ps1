function New-UDMapPopup {
    param(
        [Parameter()]
        [string]$Id = (New-Guid).ToString(),
        [Parameter()]
        [ScriptBlock]$Content,
        [Parameter()]
        [float]$Longitude,
        [Parameter()]
        [float]$Latitude,
        [Parameter()]
        [int]$MaxWidth,
        [Parameter()]
        [int]$MinWidth
    )

    $Options = @{
        type = "map-popup"
        isPlugin = $true
        assetId = $AssetId

        id = $id
        content = & $Content

        maxWidth = $MaxWidth
        minWidth = $MinWidth
    }

    if ($PSCmdlet.MyInvocation.BoundParameters.ContainsKey("Longitude")) {
        $Options["longitude"] = $Longitude
    }

    if ($PSCmdlet.MyInvocation.BoundParameters.ContainsKey("Latitude")) {
        $Options["latitude"] = $Latitude
    }

    $Options
}