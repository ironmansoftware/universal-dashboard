function Clear-UDElement {
    <#
    .SYNOPSIS
    Removes all children from the specified element.
    
    .DESCRIPTION
    Removes all children from the specified element. This cmdlet may behave differently depending on the type of parent element.
    
    .PARAMETER Id
    The ID of the element to clear.
    
    .PARAMETER Broadcast
    Whether to clear the element on all connected clients.
    
    .EXAMPLE
    New-UDElement -Tag 'div' -Id 'parent' -Content {
        New-UDTypography -Text 'Hello World'
    }

    New-UDButton -Text 'Click Me' -OnClick {
        Clear-UDElement -Id 'parent'
    }
    #> 
    param(
        [Parameter(Mandatory)]
        [string]$Id,
        [Parameter()]
        [Switch]$Broadcast
    )

    if ($Broadcast) {
        $DashboardHub.SendWebSocketMessage("clearElement", $Id)
    }
    else {
        $DashboardHub.SendWebSocketMessage($ConnectionId, "clearElement", $Id)
    }
}
