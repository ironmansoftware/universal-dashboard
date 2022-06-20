function New-UDErrorBoundary {
    <#
    .SYNOPSIS
    Defines a new error boundary around a section of code.
    
    .DESCRIPTION
    Defines a new error boundary around a section of code. Error boundaries are used to trap errors and display them on the page.  
    
    .PARAMETER Content
    The content to trap in an error boundary.
    
    .EXAMPLE
    Defines an error boundary that traps the exception that is thrown and displays it on the page.

    New-UDErrorBoundary -Content {
        throw 'This is an error'
    }
    #>
    param(
        [Parameter(Mandatory)]
        [ScriptBlock]$Content
    )

    try 
    {
        & $Content 
    }
    catch
    {
        New-UDError -Message $_
    }
}