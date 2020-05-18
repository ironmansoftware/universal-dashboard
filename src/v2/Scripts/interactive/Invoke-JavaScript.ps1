function Invoke-UDJavaScript
{
    param(
        [Parameter(Mandatory)]
		[string]$JavaScript
    )

    $DashboardHub.SendWebSocketMessage($ConnectionId, "invokejavascript", $JavaScript)
}