function New-UDAutocomplete {
    <#
    .SYNOPSIS
    Creates an autocomplete textbox.
    
    .DESCRIPTION
    Creates an autocomplete textbox. Autocomplete text boxes can be used to allow the user to select from a large list of static or dynamic items. Typing in the textbox will filter the list.
    
    .PARAMETER Id
    The ID of the component. It defaults to a random GUID.
    
    .PARAMETER Label
    The label to show for the textbox.
    
    .PARAMETER Value
    The value of the textbox.
    
    .PARAMETER OnChange
    A script block that is invoked when the selection changes.
    
    .PARAMETER OnLoadOptions
    A script block that is called when the user starts typing in the text box. The $Body variable will contain the typed text. You should return a JSON array of values that are a result of what the user has typed. 
    
    .PARAMETER Options
    Static options to display in the selection drop down. When the user types, these options will be filtered. 
    
    .EXAMPLE
    Creates a autocomplete with a static list of options. 

    New-UDAutocomplete -Id 'autoComplete' -Options @('Test', 'Test2', 'Test3', 'Test4') 
    
    .EXAMPLE
    Creates an autocomplete with a dynamically filtered set of options

    New-UDAutocomplete -Id 'autoCompleteDynamic' -OnLoadOptions { 
        @('Test', 'Test2', 'Test3', 'Test4') | Where-Object { $_ -match $Body } | ConvertTo-Json
    } 
    #>
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
        $OnChange.ContentType = 'text/plain';
        $OnChange.Register($Id + "onChange", $PSCmdlet)
    }

    if ($PSCmdlet.ParameterSetName -eq 'Dynamic')
    {
        if ($OnLoadOptions) {
            $OnLoadOptions.ContentType = 'text/plain';
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
