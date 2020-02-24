function New-UDSwitch {
    param(
        [Parameter()]
        [String]$Id = ([Guid]::NewGuid()),
        [Parameter()]
        [Switch]$Disabled,
        [Parameter()]
        [Endpoint]$OnChange,
        [Parameter()]
        [bool]$Checked
    )

    if ($OnChange) {
        $OnChange.Register($Id, $PSCmdlet)
    }

    @{
        type = 'mu-switch'
        id = $Id 
        assetId = $MUAssetId 
        isPlugin = $true 

        disabled = $Disabled.IsPresent 
        checked = $Checked 
        onChange = $onChange
    }
}