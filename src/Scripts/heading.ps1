function New-UDHeading {
    <#
    .SYNOPSIS
    Defines a new heading
    
    .DESCRIPTION
    Defines a new heading. This generates a new H tag. 
    
    .PARAMETER Id
    The ID of this component.
    
    .PARAMETER Content
    The content of the heading.
    
    .PARAMETER Text
    The text of the heading.
    
    .PARAMETER Size
    This size of this heading. This can be 1,2,3,4,5 or 6. 
    
    .PARAMETER Color
    The text color.
    
    .EXAMPLE
    A heading

    New-UDHeading -Text 'Heading 1' -Size 1 -Color Blue
    #>
    param(
        [Parameter()]
        [String]$Id = ([Guid]::NewGuid()),
        [Parameter(ParameterSetName = "Content")]
        [ScriptBlock]$Content,
        [Parameter(ParameterSetName = "Text")]
        [string]$Text,
        [Parameter()]
        [ValidateSet("1", "2", "3", "4", "5", "6")]
        $Size,
        [Parameter()]
        [UniversalDashboard.Models.DashboardColor]$Color = 'black',
        [Parameter()]
        [string]$ClassName
    )

    if ($PSCmdlet.ParameterSetName -eq "Text") {
        $Content = { $Text }
    }

    New-UDElement -Id $Id -Tag "h$size" -Content $Content -Attributes @{
        className = $className
        style     = @{
            color = $Color.HtmlColor
        }
    }
}