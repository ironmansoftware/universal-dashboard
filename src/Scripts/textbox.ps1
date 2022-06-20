function New-UDTextbox {
    <#
    .SYNOPSIS
    Creates a textbox.
    
    .DESCRIPTION
    Creates a textbox. Textboxes can be used by themselves or within a New-UDForm.
    
    .PARAMETER Id
    The ID of the component. It defaults to a random GUID.

    .PARAMETER Label
    A label to show above this textbox.
    
    .PARAMETER Placeholder
    A placeholder to place within the text box. 
    
    .PARAMETER Value
    The current value of the textbox. 
    
    .PARAMETER Type
    The type of textbox. This can be values such as text, password or email. 
    
    .PARAMETER Disabled
    Whether this textbox is disabled. 
    
    .PARAMETER Icon
    The icon to show next to the textbox. Use New-UDIcon to create an icon. 
    
    .PARAMETER Autofocus
    Whether to autofocus this textbox. 

    .PARAMETER Mutliline
    Creates a multiline textbox

    .PARAMETER Rows
    The number of rows in a multiline textbox. 

    .PARAMETER RowsMax
    The maximum number of rows in a multiline textbox.

    .PARAMETER FullWidth
    Whether to make this textbox take up the full width of the parent control.

    .PARAMETER Mask
    The mask to apply over a textbox. 

    .PARAMETER Variant
    The variant of textbox. Valid values are "filled", "outlined", "standard"
    
    .EXAMPLE
    Creates a standard textbox. 

    New-UDTextbox -Label 'text' -Id 'txtLabel'

    .EXAMPLE 
    Creates a password textbox. 

    New-UDTextbox -Label 'password' -Id 'txtPassword' -Type 'password'
    #>
    param(
        [Parameter()]
        [String]$Id = ([Guid]::NewGuid()),
        [Parameter()]
        [string]$Label,
        [Parameter()]
        [string]$Placeholder,
        [Parameter()]
        $Value,
        [Parameter()]
        [ValidateSet('text', 'password', 'email')]
        [String]$Type = 'text',
        [Parameter()]
        [Switch]$Disabled,
        [Parameter()]
        [PSTypeName('UniversalDashboard.Icon')]$Icon,
        [Parameter()]
        [Switch]$Autofocus,
        [Parameter()]
        [Switch]$Multiline,
        [Parameter()]
        [int]$Rows = 1,
        [Parameter()]
        [int]$RowsMax = 9999,
        [Parameter()]
        [Switch]$FullWidth,
        [Parameter()]
        [string[]]$Mask,
        [Parameter()]
        [ValidateSet("filled", "outlined", "standard")]
        [string]$Variant = "standard",
        [Parameter()]
        [string]$ClassName,
        [Parameter()]
        [Endpoint]$OnEnter
    )

    if ($OnEnter) {
        $OnEnter.Register($Id, $PSCmdlet)
    }

    @{
        id         = $id 
        assetId    = $MUAssetId 
        isPlugin   = $true 
        type       = "mu-textbox"

        label      = $Label
        helperText = $placeholder
        value      = $value 
        textType   = $type 
        disabled   = $Disabled.IsPresent 
        autoFocus  = $AutoFocus.IsPresent
        icon       = $icon
        multiline  = $Multiline.IsPresent
        rows       = $Rows 
        rowsMax    = $RowsMax
        fullWidth  = $FullWidth.IsPresent
        mask       = $Mask
        variant    = $Variant.ToLower()
        className  = $ClassName
        onEnter    = $OnEnter
    }
}
