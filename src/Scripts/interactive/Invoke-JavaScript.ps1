function Invoke-UDJavaScript {
    <#
    .SYNOPSIS
    Invokes JavaScript within the browser.
    
    .DESCRIPTION
    Invokes JavaScript within the browser. JavaScript is executed with eval()
    
    .PARAMETER JavaScript
    The JavaScript to execute. 
    
    .EXAMPLE
    New-UDButton -Text 'Click Me' -OnClick {
        Invoke-UDJavaScript 'alert("Hello World!")'
    }
    #>
    param(
        [Parameter(Mandatory)]
        [string]$JavaScript
    )

    $DashboardHub.SendWebSocketMessage($ConnectionId, "invokejavascript", $JavaScript)
}