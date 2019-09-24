function New-UDCheckbox {
    param(
        [Parameter()]
        [String]$Id = ([Guid]::NewGuid()),
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

    if ($null -ne $OnChange) {
        if ($OnChange -is [scriptblock]) {
            $OnChange = New-UDEndpoint -Endpoint $OnChange -Id ($Id + "onChange")
        }
        elseif ($OnChange -isnot [UniversalDashboard.Models.Endpoint]) {
            throw "OnChange must be a script block or UDEndpoint"
        }
    }

    @{
        type = 'ud-checkbox'
        isPlugin = $true

        onChange = $OnChange.Name
        checked = $Checked.IsPresent
        filledIn = $FilledIn.IsPresent
        disabled = $Disabled.IsPresent
        id = $Id
        label = $Label
    }
}