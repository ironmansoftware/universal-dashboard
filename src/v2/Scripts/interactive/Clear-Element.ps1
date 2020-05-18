function Clear-UDElement
{
    param(
        [Parameter(Mandatory)]
        [string]$Id,
        [Parameter()]
        [Switch]$Broadcast
    )

    if ($Broadcast)
    {
        $DashboardHub.SendWebSocketMessage("clearElement", $Id)
    }
    else 
    {
        $DashboardHub.SendWebSocketMessage($ConnectionId, "clearElement", $Id)
    }
}
