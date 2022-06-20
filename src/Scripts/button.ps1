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
    The variant type for this button. Valid values are: "text", "outlined", "contained"
    
    .PARAMETER IconAlignment
    How to align the icon within the button. Valid values are: "left", "right"
    
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

    .PARAMETER Color
    The color of the component. Valid values are: 'default', 'inherit', 'primary', 'secondary'

    .PARAMETER Disabled
    Whether the button is disabled. 

    .PARAMETER ClassName
    The CSS Class to apply to the button.
    
    .EXAMPLE
    Creates a button with the GitHub logo and redirects the user to GitHub when clicked. 

    $Icon = New-UDIcon -Icon 'github'
    New-UDButton -Text "Submit" -Id "btnClick" -Icon $Icon -OnClick {
        Invoke-UDRedirect https://github.com
    }

    .EXAMPLE 
    Creates a button with a blue background. 

    New-UDButton -Text "Submit" -Style @{ backgroundColor = "blue"}  -OnClick {
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
        [Endpoint]$OnClick,

        [Parameter (Position = 8)]
        [ValidateSet("small", "medium", "large")]
        [string]$Size,

        [Parameter (Position = 9)]
        [Hashtable]$Style,

        [Parameter (Position = 10)]
        [string]$Href,

        [Parameter()]
        [string]$Id = ([Guid]::NewGuid()).ToString(),

        [Parameter()]
        [ValidateSet('default', 'inherit', 'primary', 'secondary', 'success', 'error', 'info', 'warning')]
        [string]$Color = "inherit",

        [Parameter()]
        [Switch]$Disabled,

        [Parameter()]
        [string]$ClassName

    )

    End {

        if ($OnClick) {
            $OnClick.Register($Id, $PSCmdlet)
        }

        if ($Color -eq 'default') {
            $Color = 'inherit'
        }

        @{
            # Mandatory properties to load as plugin.
            type          = 'mu-button'
            isPlugin      = $true
            assetId       = $MUAssetId

            # Command properties.
            id            = $Id
            text          = $Text
            variant       = $Variant.ToLower()
            onClick       = $OnClick
            iconAlignment = $IconAlignment
            disabled      = $Disabled.IsPresent
            icon          = $Icon
            fullWidth     = $FullWidth.IsPresent
            size          = $Size
            href          = $Href
            style         = $Style
            color         = $Color.ToLower()
            className     = $ClassName
        }

    }
}