function New-UDStack {
    <#
    .SYNOPSIS
    The Stack component manages layout of immediate children along the vertical or horizontal axis with optional spacing and/or dividers between each child.
    
    .DESCRIPTION
    Stack is concerned with one-dimensional layouts, while Grid handles two-dimensional layouts. The default direction is column which stacks children vertically.
    
    .PARAMETER Id
    The ID of this component.
    
    .PARAMETER Children
    The children to stack.
    
    .PARAMETER Divider
    An optional divider component. 
    
    .PARAMETER Spacing
    The spacing between the items. 
    
    .PARAMETER Direction
    The stack direction.
    
    .EXAMPLE
    New-UDStack -Content {
        New-UDPaper
        New-UDPaper
        New-UDPaper
    } -Spacing 2
    
    Creates a stack of papers with 2 spacing. 
    #>
    param(
        [Parameter()]
        [String]$Id = ([Guid]::NewGuid()),
        [Parameter(Mandatory)]
        [Alias("Content")]
        [scriptblock]$Children,
        [Parameter()]
        [scriptblock]$Divider = {},
        [Parameter()]
        [int]$Spacing,
        [Parameter()]
        [ValidateSet('row', 'column')]
        [string]$Direction = 'row'
    )

    @{
        id        = $id 
        assetId   = $MUAssetId 
        isPlugin  = $true 
        type      = "mu-stack"

        children  = & $Children
        divider   = & $Divider
        spacing   = $Spacing
        direction = $Direction.ToLower()
    }
}
