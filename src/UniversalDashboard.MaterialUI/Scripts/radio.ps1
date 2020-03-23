function New-UDRadioGroup {
    <#
    .SYNOPSIS
    Creates a group of radio buttons.
    
    .DESCRIPTION
    Creates a group of radio buttons. Within a group, only a single radio will be able to be selected.
    
    .PARAMETER Id
    The ID of the component. It defaults to a random GUID.
    
    .PARAMETER Label
    The label to show for this radio group. 
    
    .PARAMETER Children
    The radio buttons to include within this group. 
    
    .PARAMETER OnChange
    A script block to call when the radio group selection changes. The $EventData variable will include the value of the radio that is selected. 
    
    .PARAMETER Value
    The selected value for this radio group. 
    
    .EXAMPLE
    Creates a radio group that shows a toast message when a radio is selected. 

    New-UDRadioGroup -Label 'group' -Id 'onChangeRadio' -Children {
        New-UDRadio -Value 'Adam' -Label 'Adam'  -Id 'adamOnChange'
        New-UDRadio -Value 'Alon' -Label 'Alon' -Id 'alonOnChange'
        New-UDRadio -Value 'Lee' -Label 'Lee' -Id 'leeOnChange'
    } -OnChange { 
        Show-UDToast $EventData 
    }
    #>
    param(
        [Parameter()]
        [String]$Id = ([Guid]::NewGuid()),
        [Parameter()]
        [String]$Label,
        [Parameter()]
        [Alias("Content")]
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
    <#
    .SYNOPSIS
    Creates a radio. 
    
    .DESCRIPTION
    Creates a radio. Radios should be included within a New-UDRadioGroup.
    
    .PARAMETER Id
    The ID of the component. It defaults to a random GUID.
    
    .PARAMETER Label
    The label to show next to the radio.
    
    .PARAMETER Disabled
    Whether the radio is disabled. 
    
    .PARAMETER Value
    The value of the radio. 
    
    .PARAMETER LabelPlacement
    The position to place the label in relation to the radio. 
    
    .EXAMPLE
    Creates a radio group that shows a toast message when a radio is selected. 

    New-UDRadioGroup -Label 'group' -Id 'onChangeRadio' -Children {
        New-UDRadio -Value 'Adam' -Label 'Adam'  -Id 'adamOnChange'
        New-UDRadio -Value 'Alon' -Label 'Alon' -Id 'alonOnChange'
        New-UDRadio -Value 'Lee' -Label 'Lee' -Id 'leeOnChange'
    } -OnChange { 
        Show-UDToast $EventData 
    }
    #>
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