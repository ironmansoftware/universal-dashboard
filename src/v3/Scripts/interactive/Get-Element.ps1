function Get-UDElement 
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
		[string]$Id
    )

    $requestId = ''

    $requestId = [Guid]::NewGuid().ToString()

    $Data = @{
        requestId = $requestId 
        componentId = $Id
    }

    $DashboardHub.SendWebSocketMessage($ConnectionId, "requestState", $Data)
    $stateRequestService.Get($requestId)    
}
