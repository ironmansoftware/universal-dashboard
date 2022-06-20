function Set-UDElement {
    <#
    .SYNOPSIS
    Set properties of an element. 
    
    .DESCRIPTION
    Set the properties of an element. 
    
    .PARAMETER Id
    The element to set properites on. 
    
    .PARAMETER Properties
    The properties to set in the form of a hashtable.
    
    .PARAMETER Broadcast
    Whether to update this element on all connected clients. 
    
    .PARAMETER Content
    Content to set within the element. 
    
    .EXAMPLE
    New-UDButton -Id 'button' -Text 'Disable Me' -OnClick {
        Set-UDElement -Id 'button -Properties @{
            'disabled' = $true
        }
    }
    #>
    param(
        [Parameter(Mandatory)]
        [string]$Id,
        [Alias("Attributes")]
        [Parameter()]
        [Hashtable]$Properties,
        [Parameter()]
        [Switch]$Broadcast,
        [Parameter()]
        [ScriptBlock]$Content
    )

    if ($Content -and -not $Properties) {
        $Properties = @{}
    }

    if ($Content) {
        $Properties['content'] = [Array](& $Content)
    }

    $Data = @{
        componentId = $Id 
        state       = $Properties
    }

    if ($Broadcast) {
        $DashboardHub.SendWebSocketMessage("setState", $data)
    }
    else {
        $DashboardHub.SendWebSocketMessage($ConnectionId, "setState", $Data)
    }
}