function Set-UDElement
{
    param(
        [Parameter(Mandatory)]
		[string]$Id,
        [Parameter()]
        [Hashtable]$Attributes,
        [Parameter()]
        [ScriptBlock]$Content,
        [Parameter()]
        [Switch]$Broadcast
    )

    $c = @()
    if ($Content)
    {
        $c = . $Content
    }

    $Data = @{
        componentId = $Id 
        state = @{
            attributes = $Attributes
            content = $c
        }
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