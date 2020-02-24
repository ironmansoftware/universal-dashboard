function New-UDDatePicker {
    param(
        [Parameter()]
        [string]$Id = [Guid]::NewGuid().ToString(),
        [Parameter()]
        [string]$Label,
        [Parameter()]
        [ValidateSet('inline', 'dialog', 'static')]
        [string]$Variant = 'inline',
        [Parameter()]
        [Switch]$DisableToolbar,
        [Parameter()]
        [Endpoint]$OnChange, 
        [Parameter()]
        [string]$Format = 'MM/dd/yyyy',
        [Parameter()]
        [DateTime]$Value = (Get-Date).Date
    )

    if ($OnChange) {
        $OnChange.Register($Id, $PSCmdlet)
    }

    @{
        id = $Id 
        type = 'mu-datepicker'
        asset = $MUAssetId
        isPlugin = $true 

        onChange = $OnChange 
        variant = $Variant 
        format = $Format 
        value = $Value.ToString()
    }
}