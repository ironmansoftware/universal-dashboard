function New-UDTextbox {
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
