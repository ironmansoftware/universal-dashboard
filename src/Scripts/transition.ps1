function New-UDTransition {
    <#
    .SYNOPSIS
    Creates a transition effect.
    
    .DESCRIPTION
    Creates a transition effect.
    
    .PARAMETER Id
    The ID of this component.
    
    .PARAMETER Collapse
    Creates a collapse transition.
    
    .PARAMETER CollapseHeight
    The height of the content when collapsed.
    
    .PARAMETER Fade
    Creates a fade transition.
    
    .PARAMETER Grow
    Creates a grow transition.
    
    .PARAMETER Slide
    Creates a slide transition.
    
    .PARAMETER SlideDirection
    The direction of the slide transition.
    
    .PARAMETER Zoom
    Creates a zoom transition.
    
    .PARAMETER Children
    The content or children to transition.
    
    .PARAMETER In
    Whether the content is transitioned in. You can use Set-UDElement to trigger a transition.
    
    .PARAMETER Timeout
    The number of milliseconds it takes to transition.
    #>
    param(
        [Parameter()]
        [string]$Id = [Guid]::NewGuid().ToString(),
        [Parameter(ParameterSetName = "Collapse")]
        [Switch]$Collapse,
        [Parameter(ParameterSetName = "Collapse")]
        [int]$CollapseHeight,
        [Parameter(ParameterSetName = "Fade")]
        [Switch]$Fade,
        [Parameter(ParameterSetName = "Grow")]
        [Switch]$Grow,
        [Parameter(ParameterSetName = "Slide")]
        [Switch]$Slide,
        [Parameter(ParameterSetName = "Slide")]
        [ValidateSet("Left", "Right", "Down", "Up")]
        [string]$SlideDirection = "Down",
        [Parameter(ParameterSetName = "Zoom")]
        [Switch]$Zoom,
        [Parameter(Mandatory)]
        [Alias("Content")]
        [scriptblock]$Children,
        [Parameter()]
        [Switch]$In,
        [Parameter()]
        [int]$Timeout
    )

    @{
        type = "mu-transition"
        id = $Id 
        asset = $MUAssetId
        isPlugin = $true 

        transition = $PSCmdlet.ParameterSetName.ToLower()
        collapseHeight = $CollapseHeight
        slideDirection = $SlideDirection
        timeout = $Timeout
        in = $In.IsPresent
        children = & $Children 
    }
}