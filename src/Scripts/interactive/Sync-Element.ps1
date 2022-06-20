function Sync-UDElement {
    <#
    .SYNOPSIS
    Causes an element to update. 
    
    .DESCRIPTION
    Causes an element to update. Not all elements can be updated. For elements that cannot be updated, wrap them in New-UDDynamic and update that.
    
    .PARAMETER Id
    The ID of the element to update. 
    
    .PARAMETER Broadcast
    Whether to broadcast the update to all clients.
    
    .EXAMPLE
    New-UDDyanmic -Id 'dateTime' -Content {
        Get-Date
    }

    New-UDButton -Text 'Refresh' -Content {
        Sync-UDElement 'dateTime'
    }
    #>
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [string[]]$Id,
        [Parameter()]
        [Switch]$Broadcast
    )

    Process {
        foreach ($i in $Id) {
            if ($Broadcast) {
                $DashboardHub.SendWebSocketMessage("syncElement", $I)
            }
            else {
                $DashboardHub.SendWebSocketMessage($ConnectionId, "syncElement", $I)
            }
        } 
    }
}