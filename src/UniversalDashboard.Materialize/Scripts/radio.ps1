function New-UDRadio {
    param(
        [Parameter()]
        [String]$Id = (New-Guid),
        [Parameter()]
        [String]$Label,
        [Parameter()]
        [Switch]$WithGap,
        [Parameter()]
        [Switch]$Disabled,
        [Parameter()]
        [object]$OnChange,
        [Parameter()]
        [string]$Group,
        [Parameter()]
        [Switch]$Checked
    )

    $Attributes = @{
        type = "radio"
        onChange = $OnChange
        name = $Group
    }

    if ($Checked) {
        $Attributes.checked = 'checked'
    }

    if ($WithGap) {
        $Attributes.className = 'with-gap'
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