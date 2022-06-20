function New-UDTooltip {
    <#
    .SYNOPSIS
    A tooltip component.
    
    .DESCRIPTION
    A tooltip component. Tooltips can be placed over an other component to display a popup when the user hovers over the nested component.
    
    .PARAMETER Id
    The ID of this component.
    
    .PARAMETER Place
    Where to place the tooltip.
    
    .PARAMETER Type
    The type of tooltip.
    
    .PARAMETER Effect
    An effect to apply to the tooltip.
    
    .PARAMETER TooltipContent
    Content to display within the tooltip.
    
    .PARAMETER Content
    Content that activates the tooltip when hovered.
    
    .EXAMPLE
    A simple tooltip.

    New-UDTooltip -Content {
        New-UDTypography -Text 'Hover me'
    } -TooltipContent {
        New-UDTypography -Text 'I'm a tooltip'
    }
    #>
    param(
        [Parameter()]
        [string]$Id = [Guid]::NewGuid(),
        [Parameter()]
        [ValidateSet("top", "bottom", "left", "right")]
        [string]$Place = "top",
        [Parameter()]
        [ValidateSet("dark", "success", "warning", "error", "info", "light")]
        [string]$Type = "dark",
        [Parameter()]
        [ValidateSet("float", "solid")]
        [string]$Effect,
        [Parameter(Mandatory)]
        [ScriptBlock]$TooltipContent,
        [Parameter(Mandatory)]
        [ScriptBlock]$Content
    )

    @{
        type = "ud-tooltip"
        tooltipType = $Type
        effect = $Effect 
        place = $Place
        id = $Id
        tooltipContent = New-UDErrorBoundary -Content $TooltipContent
        content = New-UDErrorBoundary -Content $Content
    }
}