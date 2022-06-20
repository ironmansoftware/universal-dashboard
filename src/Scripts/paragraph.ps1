function New-UDParagraph {
    <#
    .SYNOPSIS
    A paragraph. 
    
    .DESCRIPTION
    A paragraph. Used to define a P HTML tag. 
    
    .PARAMETER Content
    The content of the paragraph.
    
    .PARAMETER Text
    The text of the paragraph.
    
    .PARAMETER Color
    The font color of the paragraph.
    
    .EXAMPLE
    A simple paragraph.

    New-UDParagraph -Text 'Hello, world!'
    #>
    param(
        [Parameter(ParameterSetName = 'content')]
        [ScriptBlock]$Content,
        [Parameter(ParameterSetName = 'text')]
        [string]$Text,
        [Parameter()]
        [UniversalDashboard.Models.DashboardColor]$Color = 'black'
    )

    if ($PSCmdlet.ParameterSetName -eq 'content') {
        New-UDElement -Tag 'p' -Content $Content -Attributes @{
            style = @{
                color = $Color.HtmlColor
            }
        }
    }
    else {
        New-UDElement -Tag 'p' -Content {
            $Text
        } -Attributes @{
            style = @{
                color = $Color.HtmlColor
            }
        }
    }
   
}