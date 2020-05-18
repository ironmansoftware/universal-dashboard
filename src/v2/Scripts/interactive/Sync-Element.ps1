function Sync-UDElement
{
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [string[]]$Id,
        [Parameter()]
        [Switch]$Broadcast
    )

    Process 
    {
        foreach($i in $Id) 
        {
            if ($Broadcast)
            {
                $DashboardHub.SendWebSocketMessage("syncElement", $I)
            }
            else
            {
                $DashboardHub.SendWebSocketMessage($ConnectionId, "syncElement", $I)
            }
        } 
    }
}