function New-UDSwitch {
    param(
        [Parameter()]
        [String]$Id = (New-Guid),
        [Parameter()]
        $OnText = "On",
        [Parameter()]
        $OffText = "Off",
        [Parameter()]
        [Switch]$Disabled,
        [Parameter()]
        [ScriptBlock]$OnChange,
        [Parameter()]
        [Switch]$On
    )

    $Attributes = @{ 
        type = "checkbox"
        onChange = $OnChange
    }

    if ($On) {
        $Attributes.checked = 'checked'
    }


    if ($Disabled) {
        $Attributes.disabled = $true
    }

    New-UDElement -Tag "div" -Content {
        New-UDElement -Tag "label" -Content {
            $OffText
            New-UDElement -Tag "input" -Attributes $Attributes -Id $Id
            New-UDElement -Tag "span" -Attributes @{className = "lever"}
            $OnText
        }
    } -Attributes @{
        className = "switch"
    }
}