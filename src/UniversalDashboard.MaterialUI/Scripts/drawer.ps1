function New-UDDrawer 
{
    param(
        [Parameter()]
        [string]$Id = [Guid]::NewGuid()
    )

    @{
        type = 'mu-drawer'
        id = $Id 
        isPlugin = $true 
        assetId = $MUAssetId
    }
}