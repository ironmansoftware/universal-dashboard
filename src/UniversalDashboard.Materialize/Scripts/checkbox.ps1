function New-UDCheckbox {
    param(
        [Parameter()]
        [String]$Id = (New-Guid),
        [Parameter()]
        $Label,
        [Parameter()]
        [Switch]$Checked,
        [Parameter()]
        [Switch]$FilledIn,
        [Parameter()]
        [Switch]$Disabled,
        [Parameter()]
        [object]$OnChange
    )

    $Attributes = @{
        type = "checkbox"
        onChange = $OnChange
    }

    if ($Checked) {
        $Attributes.checked = 'checked'
    }

    if ($FilledIn) {
        $Attributes.className = 'filled-in'
    }

    if ($Disabled) {
        $Attributes.disabled = $true
    }

    New-UDElement -Tag "p" -Content {
        New-UDElement -Id $Id -Tag "input" -Attributes $Attributes
        New-UDElement -Tag "label" -Attributes @{
            "for" = $id
        } -Content { $label }
    }
}