function New-UDSwitch {
    param(
        [Parameter()]
        [String]$Id = ([Guid]::NewGuid()),
        [Parameter()]
        [Switch]$Disabled,
        [Parameter()]
        [object]$OnChange,
        [Parameter()]
        [bool]$Checked
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
        type = 'mu-switch'
        id = $Id 
        assetId = $MUAssetId 
        isPlugin = $true 

        disabled = $Disabled.IsPresent 
        checked = $Checked 
        onChange = $onChange.Name
    }
}