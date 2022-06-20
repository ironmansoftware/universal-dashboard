function New-UDTimePicker {
    <#
    .SYNOPSIS
    Creates a time picker.
    
    .DESCRIPTION
    Creates a time picker. This component can be used stand alone or within New-UDForm. 
    
    .PARAMETER Id
    The ID of the component. It defaults to a random GUID.
    
    .PARAMETER Label
    The label to show with the time picker.
    
    .PARAMETER OnChange
    A script block to call when the time is changed. The $EventData variable contains the currently selected time. 
    
    .PARAMETER Value
    The current value of the time picker.

    .PARAMETER Locale
    Change the language of the time picker.
    
    .EXAMPLE
    Creates a new time picker 

    New-UDTimePicker -Id 'timePicker'
    #>
    param(
        [Parameter()]
        [string]$Id = [Guid]::NewGuid().ToString(),
        [Parameter()]
        [string]$Label,
        [Parameter()]
        [Endpoint]$OnChange, 
        [Parameter()]
        [string]$Value,
        [Parameter()]
        [ValidateSet("en", "de", 'ru', 'fr')]
        [string]$Locale = "en",
        [Parameter()]
        [string]$ClassName,
        [Parameter()]
        [Switch]$DisableAmPm
    )

    if ($OnChange) {
        $OnChange.Register($Id, $PSCmdlet)
    }

    @{
        id        = $Id 
        type      = 'mu-timepicker'
        asset     = $MUAssetId
        isPlugin  = $true 

        onChange  = $OnChange 
        value     = $Value
        label     = $Label
        locale    = $Locale.ToLower()
        className = $ClassName
        ampm      = -not ($DisableAmPm.IsPresent)
    }
}