function New-UDGrid {
    <#
    .SYNOPSIS
    Creates a grid to layout components.
    
    .DESCRIPTION
    Creates a grid to layout components. The grid is a 24-point grid system that can adapt based on the size of the screen that is showing the controls. 
    
    .PARAMETER Id
    The ID of the component. It defaults to a random GUID.
    
    .PARAMETER ExtraSmallSize
    The size (1-24) for extra small devices.
    
    .PARAMETER SmallSize
    The size (1-24) for small devices.
    
    .PARAMETER MediumSize
    The size (1-24) for medium devices.
    
    .PARAMETER LargeSize
    The size (1-24) for large devices.
    
    .PARAMETER ExtraLargeSize
    The size (1-24) for extra large devices.
    
    .PARAMETER Container
    Whether this is a container. A container can be best described as a row. 
    
    .PARAMETER Spacing
    Spacing between the items. 
    
    .PARAMETER Item
    Whether this is an item in a container. 
    
    .PARAMETER Children
    Components included in this grid item. 
    
    .EXAMPLE
    An example
    
    .NOTES
    General notes
    #>
    param(
        [Parameter()]
        [string]$Id = [Guid]::NewGuid().ToString(),
        [Alias("Size")]
        [ValidateRange(1, 12)]
        [Parameter(ParameterSetName = "Item")]
        [int]$ExtraSmallSize,
        [Parameter(ParameterSetName = "Item")]
        [ValidateRange(1, 12)]
        [int]$SmallSize,
        [Parameter(ParameterSetName = "Item")]
        [ValidateRange(1, 12)]
        [int]$MediumSize,
        [Parameter(ParameterSetName = "Item")]
        [ValidateRange(1, 12)]
        [int]$LargeSize,
        [Parameter(ParameterSetName = "Item")]
        [ValidateRange(1, 12)]
        [int]$ExtraLargeSize,
        [Parameter(ParameterSetName = "Container")]
        [Switch]$Container,
        [Parameter(ParameterSetName = "Container")]
        [int]$Spacing,
        [Parameter(ParameterSetName = "Item")]
        [Switch]$Item,
        [Parameter()]
        [Alias("Content")]
        [ScriptBlock]$Children
    )

    End {
        @{
            id = $Id 
            isPlugin = $true 
            type = "mu-grid"
            assetId = $MUAssetId

            xs = $ExtraSmallSize
            sm = $SmallSize
            md = $MediumSize
            lg = $LargeSize
            xl = $ExtraLargeSize
            spacing = $Spacing

            container = $Container.IsPresent
            item = $Item.IsPresent

            children = & $Children
        }
    }
}