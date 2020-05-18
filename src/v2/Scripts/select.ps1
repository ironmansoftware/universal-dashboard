function New-UDSelect {
    param(
        [Parameter()]
        [String]$Id = ([Guid]::NewGuid()),
        [Parameter()]
        [ScriptBlock]$Option,
        [Parameter()]
        [Switch]$MultiSelect,
        [Parameter()]
        [String]$Label,
        [Parameter()]
        [Switch]$BrowserDefault,
        [Parameter()]
        [Switch]$Icons,
        [Parameter()]
        [object]$OnChange
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
        type = 'ud-select'
        isPlugin = $true 

        id = $id 
        options = $Option.Invoke()
        multiple = $MultiSelect.IsPresent
        label = $Label
        browserDefault = $BrowserDefault.IsPresent
        icons = $Icons.IsPresent
        onChange = $OnChange.Name
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
        type = 'ud-select-group'
        name = $Name 
        options = $Option.Invoke()
    }

}

function New-UDSelectOption {
    param(
        [Parameter(Mandatory = $true)]
        [String]$Name,
        [Parameter(Mandatory = $true)]
        [String]$Value,
        [Parameter()]
        [Switch]$Disabled,
        [Parameter()]
        [Switch]$Selected,
        [Parameter()]
        [String]$Icon
    )

    @{
        name = $Name 
        value = $Value 
        disabled = $Disabled.IsPresent
        selected = $Selected.IsPresent
        icon = $Icon
    }
}
