function Remove-UDElement {
    <#
    .SYNOPSIS
    Removes an element from the page.
    
    .DESCRIPTION
    Removes an element from the page.
    
    .PARAMETER Id
    The ID of the element to remove.
    
    .PARAMETER ParentId
    Not used
    
    .PARAMETER Broadcast
    Whether to remove this element from the page of all connected users.
    
    .EXAMPLE
    New-UDElement -Id 'myElement' -Tag 'div' -Content {
        New-UDTypography -Text 'Hello World'
    }
    
    New-UDButton -Text 'Click Me' -OnClick {
        Remove-UDElement -Id 'myElement'
    }
    #>
    param(
        [Parameter(Mandatory)]
        [string]$Id, 
        [Parameter()]
        [string]$ParentId,
        [Parameter()]
        [Switch]$Broadcast
    )

    $Data = @{
        componentId = $Id 
        parentId    = $ParentId
    }

    if ($Broadcast) {
        $DashboardHub.SendWebSocketMessage("removeElement", $Data)
    }
    else {
        $DashboardHub.SendWebSocketMessage($ConnectionId, "removeElement", $Data)
    }
}
