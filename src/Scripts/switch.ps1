function New-UDSwitch {
    <#
    .SYNOPSIS
    Creates a new switch. 
    
    .DESCRIPTION
    Creates a new switch. A switch behaves like a checkbox but looks a little different. 
    
    .PARAMETER Id
    The ID of the component. It defaults to a random GUID.
    
    .PARAMETER Disabled
    Whether this switch is disabled. 
    
    .PARAMETER OnChange
    A script block that is called when this switch changes. The $EventData variable will contain the checked value ($true\$false). 
    
    .PARAMETER Checked
    Whether this switch is checked. 

    .PARAMETER Color
    The theme color to apply to this switch.

    .PARAMETER Label
    The label to display next to the switch

    .PARAMETER CheckedLabel
    The label to display for when the switch is checked

    .PARAMETER UncheckedLabel
    The label to display for when the switch is unchecked
    
    .EXAMPLE
    Creates a switch that shows a toast when changed. 
    
    New-UDSwitch -Id 'switchOnChange' -OnChange { 
        Show-UDToast -Message $EventData
    }
    #>
    param(
        [Parameter()]
        [String]$Id = ([Guid]::NewGuid()),
        [Parameter()]
        [Switch]$Disabled,
        [Parameter()]
        [Endpoint]$OnChange,
        [Parameter()]
        [bool]$Checked,
        [Parameter()]
        [string]$ClassName,
        [Parameter ()]
        [ValidateSet('default', 'primary', 'secondary')]
        [string]$Color = 'default',
        [Parameter()]
        [string]$Label,
        [Parameter()]
        [string]$CheckedLabel,
        [Parameter()]
        [string]$UncheckedLabel
    )

    if ($OnChange) {
        $OnChange.Register($Id, $PSCmdlet)
    }

    @{
        type           = 'mu-switch'
        id             = $Id 
        assetId        = $MUAssetId 
        isPlugin       = $true 

        disabled       = $Disabled.IsPresent 
        checked        = $Checked 
        onChange       = $onChange
        className      = $ClassName
        color          = $Color.ToLower()
        label          = $Label
        checkedLabel   = $CheckedLabel
        uncheckedLabel = $UncheckedLabel
    }
}