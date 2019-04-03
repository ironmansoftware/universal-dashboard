function New-UDMuButton {
    param
    (
        [Parameter (Position = 0)]
        [string]$Text,

        [Parameter (Position = 1)]
        [PSTypeName('UniversalDashboard.MaterialUI.Icon')]$Icon,

        [Parameter (Position = 2)]
        [ValidateSet("text", "outlined", "contained", "flat", "raised")]
        [string]$Variant,

        [Parameter (Position = 3)]
        [ValidateSet("left", "right")]
        [string]$IconAlignment = "left",

        [Parameter (Position = 6)]
        [switch]$FullWidth,

        [Parameter (Position = 7)]
        [object]$OnClick,

        [Parameter (Position = 8)]
        [ValidateSet("small", "medium", "large")]
        [string]$Size,

        [Parameter (Position = 9)]
        [Hashtable]$Style,

        [Parameter (Position = 10)]
        [string]$Href,

        [Parameter()]
        [string]$Id = (New-Guid).ToString()

    )

    End {

        if ($null -ne $OnClick) {
            if ($OnClick -is [scriptblock]) {
                $OnClick = New-UDEndpoint -Endpoint $OnClick -Id ($Id + "onClick")
            }
            elseif ($OnClick -isnot [UniversalDashboard.Models.Endpoint]) {
                throw "OnClick must be a script block or UDEndpoint"
            }
        }

        @{
            # Mandatory properties to load as plugin.
            type          = 'mu-button'
            isPlugin      = $true
            assetId       = $MUAssetId

            # Command properties.
            id            = $Id
            text          = $Text
            variant       = $Variant
            onClick       = $OnClick
            iconAlignment = $IconAlignment
            disabled      = $Disabled.IsPresent
            icon          = $Icon
            fullWidth     = $FullWidth.IsPresent
            size          = $Size
            href          = $Href
            style         = $Style
        }

    }
}