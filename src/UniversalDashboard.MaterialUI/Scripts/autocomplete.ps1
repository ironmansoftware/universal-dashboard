function New-UDAutocomplete {
    param(
        [Parameter()]
        [String]$Id = ([Guid]::NewGuid()),
        [Parameter()]
        [string]$Label,
        [Parameter()]
        [string]$Value,
        [Parameter()]
        [Endpoint]$OnChange, 
        [Parameter(Mandatory, ParameterSetName = "Dynamic")]
        [Endpoint]$OnLoadOptions,
        [Parameter(Mandatory, ParameterSetName = "Static")]
        [Array]$Options = @()
    )

    if ($OnChange) {
        $OnChange.Register($Id + "onChange", $PSCmdlet)
    }

    if ($PSCmdlet.ParameterSetName -eq 'Dynamic')
    {
        if ($OnLoadOptions) {
            $OnLoadOptions.Register($Id + "onLoadOptions", $PSCmdlet)
        }
    }
    
    @{
        id = $id 
        assetId = $MUAssetId 
        isPlugin = $true 
        type = "mu-autocomplete"

        label = $Label
        value = $value 
        onChange = $onChange 
        onLoadOptions = $OnLoadOptions
        options = $Options
    }
}
