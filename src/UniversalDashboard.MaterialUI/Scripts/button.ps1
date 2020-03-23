function New-UDButton {
    <#
    .SYNOPSIS
    Creates a new button.
    
    .DESCRIPTION
    Creates a new button. Buttons are used to allow the user to take action.
    
    .PARAMETER Text
    The text to show within the button.
    
    .PARAMETER Icon
    An icon to show within the button. Use New-UDIcon to create an icon for this parameter. 
    
    .PARAMETER Variant
    The variant type for this button. 
    
    .PARAMETER IconAlignment
    How to align the icon within the button. 
    
    .PARAMETER FullWidth
    Whether the button takes the full width of the it's container.
    
    .PARAMETER OnClick
    The action to take when the button is clicked. 
    
    .PARAMETER Size
    The size of the button. 
    
    .PARAMETER Style
    Styles to apply to the button. 
    
    .PARAMETER Href
    A URL that the user should be redirected to when clicking the button. 
    
    .PARAMETER Id
    The ID of the component. It defaults to a random GUID.
    
    .EXAMPLE
    Creates a button with the GitHub logo and redirects the user to GitHub when clicked. 

    $Icon = New-UDIcon -Icon 'github'
    New-UDButton -Text "Submit" -Id "btnClick" -Icon $Icon -OnClick {
        Invoke-UDRedirect https://github.com
    }
    #>
    param
    (
        [Parameter (Position = 0)]
        [string]$Text,

        [Parameter (Position = 1)]
        [PSTypeName('UniversalDashboard.Icon')]$Icon,

        [Parameter (Position = 2)]
        [ValidateSet("text", "outlined", "contained")]
        [string]$Variant = "contained",

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
        [string]$Id = ([Guid]::NewGuid()).ToString()

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