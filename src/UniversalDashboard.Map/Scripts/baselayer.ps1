function New-UDMapBaseLayer {
    param(
        [Parameter()]
        [string]$Id = (New-Guid).ToString(),
        [Parameter(Mandatory)]
        [string]$Name,
        [Parameter(Mandatory)]
        [ScriptBlock]$Content,
        [Parameter()]
        [Switch]$Checked
    )

    @{
        type = "map-base-layer"
        isPlugin = $true
        assetId = $AssetId
        id = $Id
        name = $Name
        content = & $Content
        checked = $Checked.IsPresent
    }
}