function Hide-UDToast
{
    param(
        [Parameter(Mandatory, Position = 0)]
        [string]$Id
    )

    $DashboardHub.SendWebSocketMessage($ConnectionId, "hideToast", $Id)
}
