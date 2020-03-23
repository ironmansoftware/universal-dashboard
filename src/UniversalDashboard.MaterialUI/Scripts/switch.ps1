function New-UDSwitch {
    <#
    .SYNOPSIS
    Creates a new switch. 
    
    .DESCRIPTION
    Creates a new switch. A switch behaves like a checkbox but looks a little different. 
    
    .PARAMETER Id
    The ID of the component. It defaults to a random GUID.
    
    .PARAMETER Disabled
    Whether this switch is disabled. 
    
    .PARAMETER OnChange
    A script block that is called when this switch changes. The $EventData variable will contain the checked value ($true\$false). 
    
    .PARAMETER Checked
    Whether this switch is checked. 
    
    .EXAMPLE
    Creates a switch that shows a toast when changed. 
    
    New-UDSwitch -Id 'switchOnChange' -OnChange { 
        Show-UDToast -Message $EventData
    }
    #>
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