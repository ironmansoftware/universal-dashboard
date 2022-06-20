function New-UDDatePicker {
    <#
    .SYNOPSIS
    Creates a new date picker.
    
    .DESCRIPTION
    Creates a new date picker. Date pickers can be used stand alone or within New-UDForm.
    
    .PARAMETER Id
    The ID of the component. It defaults to a random GUID.
    
    .PARAMETER Label
    The label to show next to the date picker.
    
    .PARAMETER Variant
    The theme variant to apply to the date picker.
    
    .PARAMETER DisableToolbar
    Disables the date picker toolbar. 
    
    .PARAMETER OnChange
    A script block to call with the selected date. The $EventData variable will be the date selected. 
    
    .PARAMETER Format
    The format of the date when it is selected. 
    
    .PARAMETER Value
    The current value of the date picker. 

    .PARAMETER Locale
    Change the language of the date picker.
    
    .EXAMPLE
    Creates a new date picker with the default date value. 

    New-UDDatePicker -Id 'dateDateDefault' -Value '1-2-2020'
    #>
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
        [DateTime]$Value = ([DateTime]::Now),
        [Parameter()]
        [ValidateSet("en", "de", 'ru', 'fr')]
        [string]$Locale = "en",
        [Parameter()]
        [string]$ClassName
    )

    if ($OnChange) {
        $OnChange.Register($Id, $PSCmdlet)
    }

    $Arguments = @{
        id        = $Id 
        type      = 'mu-datepicker'
        asset     = $MUAssetId
        isPlugin  = $true 

        onChange  = $OnChange 
        variant   = $Variant 
        format    = $Format 
        value     = $Value
        label     = $Label
        locale    = $Locale.ToLower()
        className = $ClassName
    }

    if ($PSBoundParameters.ContainsKey('Value')) {
        $Arguments['value'] = $Value
    }

    $Arguments
}