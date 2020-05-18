function Remove-UDElement
{
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
        parentId = $ParentId
    }

    if ($Broadcast)
    {
        $DashboardHub.SendWebSocketMessage("removeElement", $Data)
    }
    else 
    {
        $DashboardHub.SendWebSocketMessage($ConnectionId, "removeElement", $Data)
    }
}
