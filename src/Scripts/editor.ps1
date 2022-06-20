function New-UDEditor {
    param(
        [Parameter()]
        [string]$Id = (New-Guid).ToString(),
        [Parameter()]
        [Hashtable]$Data,
        [Parameter()]
        [Endpoint]$OnChange,
        [Parameter()]
        [ValidateSet("json", "html")]
        [string]$Format = "json"
    )

    if ($OnChange) {
        $OnChange.Register($Id, $PSCmdlet);
    }

    @{
        assetId  = $AssetId 
        isPlugin = $true 
        type     = "ud-editor"
        id       = $Id

        onChange = $OnChange
        data     = $Data
        format   = $Format.ToLower()
    }
}