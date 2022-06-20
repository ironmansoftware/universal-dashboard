function New-UDError {
    <#
    .SYNOPSIS
    Creates a new error card.
    
    .DESCRIPTION
    Creates a new error card.
    
    .PARAMETER Message
    The message to display. 
    
    .PARAMETER Title
    A title for the card.
    
    .EXAMPLE
    Displays the error 'Invalid data' on the page.

    New-UDError -Message 'Invalid data'
    #>
    param(
        [Parameter(Mandatory)]
        [string]$Message,
        [Parameter()]
        [string]$Title
    )

    @{
        type = "error"
        isPlugin = $true 
        assetId = $AssetId 

        errorRecords = @(@{message= $Message})
        title = $Title
    }
}