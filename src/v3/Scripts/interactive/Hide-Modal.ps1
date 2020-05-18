function Hide-UDModal 
{
    $DashboardHub.SendWebSocketMessage($ConnectionId, "closeModal", $null)
}