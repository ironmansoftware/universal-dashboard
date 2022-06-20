function Invoke-UDRedirect {
    <#
    .SYNOPSIS
    Redirect the user to another page.
    
    .DESCRIPTION
    Redirect the user to another page.
    
    .PARAMETER Url
    The URL to redirect the user to.
    
    .PARAMETER OpenInNewWindow
    Whether to open the URL in a new window.
    
    .EXAMPLE
    New-UDButton -Text 'Click Me' -OnClick {
        Invoke-UDRedirect 'https://www.google.com'
    }
    #>
    param(
        [Parameter(Mandatory)]
        [string]$Url,
        [Parameter()]
        [Switch]$OpenInNewWindow
    )

    $Data = @{
        url             = $Url 
        openInNewWindow = $OpenInNewWindow.IsPresent
    }

    $DashboardHub.SendWebSocketMessage($ConnectionId, "redirect", $Data)
}