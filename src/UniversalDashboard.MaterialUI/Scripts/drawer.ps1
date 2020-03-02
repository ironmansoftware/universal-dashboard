function New-UDDrawer 
{
    param(
        [Parameter()]
        [string]$Id = [Guid]::NewGuid(),
        [Parameter()]
        [ScriptBlock]$Children
    )

    @{
        type = 'mu-drawer'
        id = $Id 
        isPlugin = $true 
        assetId = $MUAssetId
        children = & $Children
    }
}