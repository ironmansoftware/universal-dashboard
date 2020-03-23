function New-UDAvatar {
    <#
    .SYNOPSIS
    Creates a new Avatar.
    
    .DESCRIPTION
    Creates a new Avatar. An avatar is typically an image of a user. 
    
    .PARAMETER Id
    The ID of the component. It defaults to a random GUID.
    
    .PARAMETER Image
    The URL of an image to show in the avatar. 
    
    .PARAMETER Alt
    The alt text to assign to the avatar. 
    
    .PARAMETER ClassName
    Classes to assign to the avatar component.
    
    .PARAMETER Variant
    The variant type of the avatar.
    
    .EXAMPLE
    A small avatar using Alon's image.

    New-UDAvatar -Image 'https://avatars2.githubusercontent.com/u/34351424?s=460&v=4' -Alt 'alon gvili avatar' -Id 'avatarContent' -Variant small
    #>
    param(
        [Parameter ()][string]$Id = ([Guid]::NewGuid()).ToString(),
        [Parameter ()][string]$Image,
        [Parameter ()][string]$Alt,
        [Parameter ()][string]$ClassName,
        [Parameter ()][string]$Variant
    )
    End {
        $Avatar = @{
            type     = 'mu-avatar'
            isPlugin = $true
            assetId  = $MUAssetId

            id       = $Id
            image    = $Image
            alt      = $Alt
            variant = $Variant
            className = $ClassName
        }
        $Avatar.PSTypeNames.Insert(0, "UniversalDashboard.MaterialUI.Avatar") | Out-Null
        $Avatar
    }
}