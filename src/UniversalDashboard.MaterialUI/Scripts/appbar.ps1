function New-UDMUAppBar {
    param(
        [Parameter ()][string]$Id = ([Guid]::NewGuid()).ToString()
    )

    @{
        type = 'mu-appbar'
        assetId = $MUAssetId
        id = $Id
        isPlugin = $true
    }
}