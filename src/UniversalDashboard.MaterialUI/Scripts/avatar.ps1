function New-UDAvatar {
    param(
        [Parameter ()][string]$Id = ([Guid]::NewGuid()).ToString(),
        [Parameter ()][string]$Image,
        [Parameter ()][string]$Alt,
        [Parameter ()][string]$ClassName,
        [Parameter ()][hashtable]$Style
    )
    End {
        $Avatar = @{
            type     = 'mu-avatar'
            isPlugin = $true
            assetId  = $MUAssetId

            id       = $Id
            image    = $Image
            alt      = $Alt
            style    = $Style
            className = $ClassName
        }
        $Avatar.PSTypeNames.Insert(0, "UniversalDashboard.MaterialUI.Avatar") | Out-Null
        $Avatar
    }
}