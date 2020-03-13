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
    The icon to show next to the textbox. 
    
    .PARAMETER Autofocus
    Whether to autofocus this textbox. 
    
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
        [UniversalDashboard.Models.FontAwesomeIcons]$Icon,
        [Switch]$Autofocus
    )

    @{
        id = $id 
        assetId = $MUAssetId 
        isPlugin = $true 
        type = "mu-textbox"

        label = $Label
        helperText = $placeholder
        value = $value 
        textType = $type 
        disabled = $Disabled.IsPresent 
        autofocus = $AutoFocus.IsPresent
    }
}
