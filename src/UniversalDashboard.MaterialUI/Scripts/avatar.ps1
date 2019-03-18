function New-UDMuAvatar {
    param(
        [Parameter ()][string]$Id = (New-Guid).ToString(),
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