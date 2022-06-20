function Select-UDElement {   
    <#
    .SYNOPSIS
    Selects the specified element.
    
    .DESCRIPTION
    Selects the specified element. This cmdlet is useful for selecting input fields.
    
    .PARAMETER Id
    The ID of the element to select. 
    
    .PARAMETER ScrollToElement
    Whether to scroll to the element.
    
    .EXAMPLE
    New-UDTextbox -Id 'txtName' -Label 'Name'

    New-UDButton -Text 'Click Me' -OnClick {
        Select-UDElement -Id 'txtName'
    }
    #>
    param(
        [Parameter(Mandatory, ParameterSetName = "Normal")]
        [string]$Id,
        [Parameter(ParameterSetName = "Normal")]
        [Switch]$ScrollToElement
    )

    $Data = @{
        id              = $Id 
        scrollToElement = $ScrollToElement
    }

    $DashboardHub.SendWebSocketMessage($ConnectionId, "select", $Data)
}