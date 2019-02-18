function New-UDSelect {
    param(
        [Parameter()]
        [String]$Id = (New-Guid),
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

    Process {
        $Attributes = @{
            onChange = $OnChange
        }
        if ($MultiSelect) {
            $Attributes.multiple = $true
        }

        if ($BrowserDefault) {
            $Attributes.className = "browser-default"
        }

        if ($Icons) {
            $Attributes.className = "icons"
        }

        New-UDElement -Tag "div" -Attributes @{className = 'input-field'} -Content {
            New-UDElement -Tag "select" -Id $Id -Content $Option -Attributes $Attributes

            if ($PSBoundParameters.ContainsKey('Label')) {
                New-UDElement -Tag "label" -Content { $Label }
            } 
        }
    }
}

function New-UDSelectGroup {
    param(
        [Parameter(Mandatory = $true)]
        [ScriptBlock]$Option,
        [Parameter(Mandatory = $true)]
        [String]$Name
    )

    Process {
        New-UDElement -Tag "optgroup" -Attributes @{ label = $Name }  -Content $Option
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

    $Attributes = @{
        value = $Value
    }

    if ($Disabled) {
        $Attributes.disabled = $Disabled
    }

    if ($Selected) {
        $Attributes.selected = $Selected
    }

    if ($PSBoundParameters.ContainsKey('Icon')) {
        $Attributes.'data-icon' = $Icon
    }

    New-UDElement -Tag "option" -Attributes $Attributes -Content {
        $Name
    }
}