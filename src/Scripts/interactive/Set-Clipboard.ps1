function Set-UDClipboard {
    <#
    .SYNOPSIS
    Sets string data into the clipboard.
    
    .DESCRIPTION
    Sets string data into the clipboard.
    
    .PARAMETER Data
    The data to set into the clipboard.
    
    .PARAMETER ToastOnSuccess
    Show a toast if the clipboard data was sent successfully.
    
    .PARAMETER ToastOnError
    Show a toast if the clipboard data was not sent successfully.
    
    .EXAMPLE
    New-UDButton -Text 'Click Me' -OnClick {
        Set-UDClipboard -Data 'Hello World!' -ShowToastOnSuccess
    }
    #>
    param(
        [Parameter(Mandatory)]
        [string]$Data,
        [Parameter()]
        [Switch]$ToastOnSuccess,
        [Parameter()]
        [Switch]$ToastOnError
    )

    $cpData = @{
        data           = $Data 
        toastOnSuccess = $ToastOnSuccess.IsPresent
        toastOnError   = $ToastOnError.IsPresent
    }

    $DashboardHub.SendWebSocketMessage($ConnectionId, "clipboard", $cpData)
}
