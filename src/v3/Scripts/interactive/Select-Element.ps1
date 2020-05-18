function Select-UDElement 
{   
    param(
        [Parameter(Mandatory, ParameterSetName = "Normal")]
		[string]$Id,
        [Parameter(ParameterSetName = "Normal")]
        [Switch]$ScrollToElement
    )

    $Data = @{
        id = $Id 
        scrollToElement = $ScrollToElement
    }

    $DashboardHub.SendWebSocketMessage($ConnectionId, "select", $Data)
}