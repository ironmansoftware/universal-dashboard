function Invoke-UDRedirect
{
    param(
        [Parameter(Mandatory)]
		[string]$Url,
        [Parameter()]
        [Switch]$OpenInNewWindow
    )

    $Data = @{
        url = $Url 
        openInNewWindow = $OpenInNewWindow.IsPresent
    }

    $DashboardHub.SendWebSocketMessage($ConnectionId, "redirect", $Data)
}