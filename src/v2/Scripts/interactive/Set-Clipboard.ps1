function Set-UDClipboard
{
    param(
        [Parameter(Mandatory)]
		[string]$Data,
        [Parameter()]
        [Switch]$ToastOnSuccess,
        [Parameter()]
        [Switch]$ToastOnError
    )

    $cpData = @{
        data = $Data 
        toastOnSuccess = $ToastOnSuccess.IsPresent
        toastOnError = $ToastOnError.IsPresent
    }

    $DashboardHub.SendWebSocketMessage($ConnectionId, "clipboard", $cpData)
}
