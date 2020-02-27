function New-UDAppBar {
    param(
        [Parameter()]
        [string]$Id = [Guid]::NewGuid(),
        [Parameter()]
        [Hashtable]$Drawer,
        [Parameter()]
        [ScriptBlock]$Content
    )

    @{
        id = $Id 
        type = 'mu-appbar'
        assetId = $MUAssetId 
        isPlugin = $true 

        children = & $Content
        drawer = $Drawer
    }
}