function Set-UDElement
{
    param(
        [Parameter(Mandatory)]
		[string]$Id,
        [Parameter()]
        [Hashtable]$Properties,
        [Parameter()]
        [Switch]$Broadcast
    )

    $Data = @{
        componentId = $Id 
        state = $Properties
    }

    if ($Broadcast)
    {
        $DashboardHub.SendWebSocketMessage("setState", $data)
    }
    else
    {
        $DashboardHub.SendWebSocketMessage($ConnectionId, "setState", $Data)
    }
}