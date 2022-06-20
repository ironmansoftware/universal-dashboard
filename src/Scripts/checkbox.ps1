function New-UDCheckBox {
    <#
    .SYNOPSIS
    Creates a checkbox.

    .DESCRIPTION
    Creates a checkbox. Checkboxes can be used in forms or by themselves. 

    .PARAMETER Label
    The label to show next to the checkbox.

    .PARAMETER Icon
    The icon to show instead of the default icon. Use New-UDIcon to create an icon.

    .PARAMETER CheckedIcon
    The icon to show instead of the default checked icon. Use New-UDIcon to create an icon.

    .PARAMETER OnChange
    Called when the value of the checkbox changes. The $EventData variable will have the current value of the checkbox. 

    .PARAMETER Style
    A hashtable of styles to apply to the checkbox.  

    .PARAMETER Disabled
    Whether the checkbox is disabled.

    .PARAMETER Checked
    Whether the checkbox is checked. 

    .PARAMETER ClassName
    A CSS class to assign to the checkbox. 

    .PARAMETER LabelPlacement
    Where to place the label. Valid values are: "top","start","bottom","end"

    .PARAMETER Id
    The ID of the component. It defaults to a random GUID.

    .PARAMETER Color
    The theme color to apply to this component

    .EXAMPLE

    Creates a checkbox with a custom icon and style. 

    $Icon = New-UDIcon -Icon angry -Size lg  -Id 'demo-checkbox-icon' -Regular
    $CheckedIcon = New-UDIcon -Icon angry -Size lg  -Id 'demo-checkbox-icon-checked' 
    New-UDCheckBox -Id 'btnCustomIcon' -Icon $Icon -CheckedIcon $CheckedIcon -OnChange {} -Style @{color = '#2196f3'}

    #>
    param
    (
        [Parameter (Position = 0)]
        [string]$Label,

        [Parameter (Position = 1)]
        [PSTypeName('UniversalDashboard.Icon')]$Icon,

        [Parameter (Position = 2)]
        [PSTypeName('UniversalDashboard.Icon')]$CheckedIcon,

        [Parameter (Position = 3)]
        [Endpoint]$OnChange,

        [Parameter (Position = 4)]
        [Hashtable]$Style,

        [Parameter (Position = 5)]
        [switch]$Disabled,

        [Parameter (Position = 6)]
        [bool]$Checked,

        [Parameter (Position = 7)]
        [string]$ClassName,

        [Parameter (Position = 7)]
        [ValidateSet("top", "start", "bottom", "end")]
        [string]$LabelPlacement,

        [Parameter(Position = 8)]
        [string]$Id = ([Guid]::NewGuid()).ToString(),

        [Parameter ()]
        [ValidateSet('default', 'primary', 'secondary')]
        [string]$Color = 'default'

    )

    End {

        if ($OnChange) {
            $OnChange.Register($Id + "onChange", $PSCmdlet)
        }

        @{
            # Mandatory properties to load as plugin.
            type           = 'mu-checkbox'
            isPlugin       = $true
            assetId        = $MUAssetId

            # Command properties.
            id             = $Id
            className      = $ClassName
            checked        = $Checked
            onChange       = $OnChange
            icon           = $Icon
            checkedIcon    = $CheckedIcon
            disabled       = $Disabled.IsPresent
            style          = $Style
            label          = $Label
            labelPlacement = $LabelPlacement
            color          = $Color.ToLower()
        }
    }
}