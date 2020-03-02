function New-UDAppBar {
    param(
        [Parameter()]
        [string]$Id = [Guid]::NewGuid(),
        [Parameter()]
        [Hashtable]$Drawer,
        [Parameter()]
        [ScriptBlock]$Content,
        [Parameter()]
        [ValidateSet('absolute', 'fixed', 'relative', 'static', 'sticky')]
        [string]$Position = 'fixed'
    )

    @{
        id = $Id 
        type = 'mu-appbar'
        assetId = $MUAssetId 
        isPlugin = $true 

        children = & $Content
        drawer = $Drawer
        position = $Position
    }
}