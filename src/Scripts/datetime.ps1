function New-UDDateTime {
    <#
    .SYNOPSIS
    This date and time component is used for formatting dates and times using the user's browser settings.
    
    .DESCRIPTION
    This date and time component is used for formatting dates and times using the user's browser settings. Since Universal Dashboard PowerShell scripts run within the server, the date and time settings of the user's system are not taken into account. This component formats date and time within the client's browser to take into account their locale and time zone.
    
    .PARAMETER Id
    The ID of this component.
    
    .PARAMETER InputObject
    The date and time object to format. 
    
    .PARAMETER Format
    The format of the date and time.  This component uses Day.JS. You can learn more about formatting options on their documentation: https://day.js.org/docs/en/display/format
    
    .PARAMETER LocalizedFormat
    The localized format for the date and time. Use this format if you would like to take the user's browser locale and time zone settings into account.
    
    .EXAMPLE
    Formats a date and time using the format 'DD/MM/YYYY'

    New-UDDateTime -InputObject (Get-Date) -Format 'DD/MM/YYYY'
    #>
    [CmdletBinding(DefaultParameterSetName = "LocalizedFormat")]
    param(
        [Parameter()]
        [string]$Id = [Guid]::NewGuid(),
        [Parameter(Mandatory, Position = 0)]
        [string]$InputObject,
        [Parameter(ParameterSetName = "Format")]
        [string]$Format = "DD/MM/YYYY",
        [Parameter(ParameterSetName = "LocalizedFormat")]
        [ValidateSet("LT", "LTS", "L", "LL", "LLL", "LLLL", "l", "ll", "lll", "llll")]
        [string]$LocalizedFormat = "LLL"
    )

    $f = $Format 
    if ($PSCmdlet.ParameterSetName -eq 'LocalizedFormat')
    {
        $f = $LocalizedFormat
    }

    @{
        type = 'mu-datetime'
        id = $Id 
        isPlugin = $true 
        assetId = $MUAssetId

        inputObject = $InputObject 
        format = $f
    }
}