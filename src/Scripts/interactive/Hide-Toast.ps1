function Hide-UDToast {
    param(
        [Parameter(Mandatory, Position = 0)]
        [string]$Id
    )

    if ($id -notmatch '^[a-zA-Z0-9]+$') {
        throw "Invalid ID. ID must be alphanumeric."
    }

    $DashboardHub.SendWebSocketMessage($ConnectionId, "hideToast", "x" + $Id)
}
