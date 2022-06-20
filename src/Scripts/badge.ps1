function New-UDBadge {
    param(
        [Parameter ()]
        [string]$Id = ([Guid]::NewGuid()).ToString(),
        [Parameter()]
        [ValidateSet("defeault", 'primary', 'secondary', 'error', 'info', 'success', 'warning')]
        [string]$Color = 'default', 
        [Parameter(Mandatory)]
        [Alias("Content")]
        [ScriptBlock]$Children = {},
        [Parameter()]
        [scriptblock]$BadgeContent = {},
        [Parameter()]
        [Switch]$Invisible,
        [Parameter()]
        [int]$Max = 99,
        [Parameter()]
        [ValidateSet('circular', 'rectangular')]
        [string]$Overlap = 'rectangular',
        [Parameter()]
        [Switch]$ShowZero,
        [Parameter()]
        [ValidateSet('standard', 'dot')]
        [string]$Variant = 'standard',
        [Parameter()]
        [ValidateSet('topright', 'topleft', 'bottomright', 'bottomleft')]
        [string]$Location = 'topright'
    )

    @{
        type         = 'mu-badge'
        isPlugin     = $true
        assetId      = $MUAssetId
        id           = $Id
        color        = $Color.ToLower()
        children     = & $Children
        badgeContent = & $BadgeContent
        invisible    = $Invisible.IsPresent
        max          = $Max 
        overlap      = $Overlap.ToLower()
        showZero     = $ShowZero.IsPresent
        variant      = $Variant.ToLower()
        location     = $Location.ToLower()
    }
}

<#
    New-UDBadge -Content {
            New-UDIcon -Icon 'User' -Size 2x
        } -BadgeContent {
            100
        } -Color primary

#>