function New-UDSelect {
    param(
        [Parameter()]
        [String]$Id = ([Guid]::NewGuid()),
        [Parameter()]
        [ScriptBlock]$Option,
        [Parameter()]
        [String]$Label,
        [Parameter()]
        [Endpoint]$OnChange,
        [Parameter()]
        [string]$DefaultValue,
        [Parameter()]
        [Switch]$Disabled,
        [Parameter()]
        [Switch]$Multiple
    )

    if ($OnChange) {
        $OnChange.Register($Id + "onChange", $PSCmdlet)
    }

    @{
        type = 'mu-select'
        assetId = $MUAssetId
        isPlugin = $true 

        id = $id 
        options = $Option.Invoke()
        label = $Label
        onChange = $OnChange
        defaultValue = $DefaultValue
        disabled = $Disabled.IsPresent
        multiple = $Multiple.IsPresent
    }
}

function New-UDSelectGroup {
    param(
        [Parameter(Mandatory = $true)]
        [ScriptBlock]$Option,
        [Parameter(Mandatory = $true)]
        [String]$Name
    )

    @{
        type = 'mu-select-group'
        name = $Name 
        options = $Option.Invoke()
    }

}

function New-UDSelectOption {
    param(
        [Parameter(Mandatory = $true)]
        [String]$Name,
        [Parameter(Mandatory = $true)]
        [String]$Value
    )

    @{
        type = 'mu-select-option'
        name = $Name 
        value = $Value 
    }
}
