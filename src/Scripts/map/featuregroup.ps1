function New-UDMapFeatureGroup 
{
    param(
        [Parameter()]
        [string]$Id = (New-Guid).ToString(),
        [Parameter()]
        [Hashtable]$Popup,
        [Parameter(Mandatory)]
        [ScriptBlock]$Content
    )

    End {
        @{
            type = 'map-feature-group'
            id = $id 
            isPlugin = $true
            assetId = $AssetId
            content = & $Content 
            popup = $Popup
        }
    }
}