function Add-UDElement {
    <#
    .SYNOPSIS
    Adds an element to a parent element.
    
    .DESCRIPTION
    Adds an element to a parent element. This cmdlet may behave differently depending on the type of parent element.
    
    .PARAMETER ParentId
    The parent element ID to add the item to. 
    
    .PARAMETER Content
    The content to add to the parent element.
    
    .PARAMETER Broadcast
    Whether to update all connected dashboards (all users).
    
    .EXAMPLE
    New-UDElement -Tag 'div' -Id 'parent' -Content {

    }

    New-UDButton -Text 'Click Me' -OnClick {
        Add-UDElement -ParentId 'parent' -Content {
            New-UDTypography -Text 'Hello World'
        }
    }
    #>
    param(
        [Parameter(Mandatory)]
        [string]$ParentId,
        [Parameter(Mandatory)]
        [ScriptBlock]$Content,
        [Parameter()]
        [Switch]$Broadcast
    )

    $NewContent = & $Content

    $Data = @{
        componentId = $ParentId
        elements    = $NewContent
    }

    if ($Broadcast) {
        $DashboardHub.SendWebSocketMessage("addElement", $Data)
    }
    else {
        $DashboardHub.SendWebSocketMessage($ConnectionId, "addElement", $Data)
    }    
}