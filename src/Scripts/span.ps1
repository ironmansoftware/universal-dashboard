function New-UDSpan {
    <#
    .SYNOPSIS
    A span component.
    
    .DESCRIPTION
    A span component. Defines a span HTML tag.
    
    .PARAMETER Id
    The ID of this component.
    
    .PARAMETER Content
    The content of the span.
    
    .EXAMPLE
    An example

    New-UDSpan -Content {
        New-UDTypography -Text 'Text'
    }
    #>
    param(
        [Parameter()]
        [String]$Id = ([Guid]::NewGuid()),
        [Parameter()]
        $Content
    )

    New-UDElement -Id $Id -Tag "span" -Content {
        $Content
    }
}