function New-UDRadioGroup {
    param(
        [Parameter()]
        [String]$Id = ([Guid]::NewGuid()),
        [Parameter()]
        [String]$Label,
        [Parameter()]
        [ScriptBlock]$Children,
        [Parameter()]
        [Endpoint]$OnChange,
        [Parameter()]
        [string]$Value
    )

    if ($OnChange) {
        $OnChange.Register($Id, $PSCmdlet)
    }

    @{
        assetId = $MUAssetId 
        id = $Id 
        isPlugin = $true 
        type = 'mu-radiogroup'

        onChange = $OnChange 
        value = $Value 
        label = $Label 
        children = & $Children
    }
}

function New-UDRadio {
    param(
        [Parameter()]
        [String]$Id = ([Guid]::NewGuid()),
        [Parameter()]
        [String]$Label,
        [Parameter()]
        [Switch]$Disabled,
        [Parameter()]
        [string]$Value,
        [Parameter()]
        [ValidateSet('start', 'end')]
        [string]$LabelPlacement = 'end'
    )

    @{
        assetId = $MUAssetId 
        id = $Id 
        isPlugin = $true 
        type = 'mu-radio'

        label = $Label 
        disabled = $Disabled.IsPresent 
        value = $value 
        labelPlacement = $LabelPlacement
    }
}