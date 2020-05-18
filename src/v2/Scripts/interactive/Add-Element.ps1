function Add-UDElement {
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
        elements = $NewContent
    }

    if ($Broadcast)
    {
        $DashboardHub.SendWebSocketMessage("addElement", $Data)
    }
    else 
    {
        $DashboardHub.SendWebSocketMessage($ConnectionId, "addElement", $Data)
    }    
}