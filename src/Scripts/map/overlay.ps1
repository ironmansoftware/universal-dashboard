function New-UDMapOverlay {
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
        type = 'map-overlay'
        isPlugin = $true
        assetId = $AssetId

        id = $id
        name = $Name 
        content = & $Content
        checked = $Checked.IsPresent
    }
}