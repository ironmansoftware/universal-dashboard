function New-UDTimePicker {
    param(
        [Parameter()]
        [string]$Id = [Guid]::NewGuid().ToString(),
        [Parameter()]
        [string]$Label,
        [Parameter()]
        [Endpoint]$OnChange, 
        [Parameter()]
        [string]$Value 
    )

    if ($OnChange) {
        $OnChange.Register($Id, $PSCmdlet)
    }

    @{
        id = $Id 
        type = 'mu-timepicker'
        asset = $MUAssetId
        isPlugin = $true 

        onChange = $OnChange 
        value = $Value
    }
}