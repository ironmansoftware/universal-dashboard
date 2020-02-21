function New-UDSelect {
    param(
        [Parameter()]
        [String]$Id = ([Guid]::NewGuid()),
        [Parameter()]
        [ScriptBlock]$Option,
        [Parameter()]
        [String]$Label,
        [Parameter()]
        [object]$OnChange,
        [Parameter()]
        [object]$DefaultValue,
        [Parameter()]
        [Switch]$Disabled
    )

    if ($null -ne $OnChange) {
        if ($OnChange -is [scriptblock]) {
            $OnChange = New-UDEndpoint -Endpoint $OnChange -Id ($Id + "onChange")
        }
        elseif ($OnChange -isnot [UniversalDashboard.Models.Endpoint]) {
            throw "OnChange must be a script block or UDEndpoint"
        }
    }

    @{
        type = 'mu-select'
        assetId = $MUAssetId
        isPlugin = $true 

        id = $id 
        options = $Option.Invoke()
        label = $Label
        onChange = $OnChange.Name
        defaultValue = $DefaultValue
        disabled = $Disabled.IsPresent
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
        disabled = $Disabled.IsPresent
        selected = $Selected.IsPresent
        icon = $Icon
    }
}
