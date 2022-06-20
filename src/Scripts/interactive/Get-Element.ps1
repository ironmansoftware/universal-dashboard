function Get-UDElement {
    <#
    .SYNOPSIS
    Get the state of the specified element.  
    
    .DESCRIPTION
    Get the state of the specified element. This cmdlet may behave differently depending on the type of parent element.
    
    .PARAMETER Id
    The ID of the element to retreive the state of.
    
    .EXAMPLE
    New-UDCodeEditor -Id 'editor' -Code 'Hello World'

    New-UDButton -Text 'Click Me' -OnClick {
        Show-UDToast (Get-UDElement).Code
    }
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Id
    )

    $requestId = ''

    $requestId = [Guid]::NewGuid().ToString()

    $Data = @{
        requestId   = $requestId 
        componentId = $Id
    }

    $DashboardHub.SendWebSocketMessage($ConnectionId, "requestState", $Data)
    ConvertFrom-Json -InputObject ($stateRequestService.Get($requestId))
}
