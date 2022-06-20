function New-UDIFrame {
    <#
    .SYNOPSIS
    An HTML IFrame component.
    
    .DESCRIPTION
    An HTML IFrame component. 
    
    .PARAMETER Id
    The ID of this component.
    
    .PARAMETER Uri
    The URI for the iframe. 
    
    .EXAMPLE
    Defines an IFrame for Google.

    New-UDIFrame -Uri https://www.google.com
    #>
    param(
        [Parameter()]
        [String]$Id = ([Guid]::NewGuid()),
        [Parameter()]
        $Uri
    )

    New-UDElement -Id $Id -Tag "iframe" -Attributes @{
        src = $Uri
    }
}