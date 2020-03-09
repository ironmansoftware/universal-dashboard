function New-UDPaper {
    <#
    .SYNOPSIS
    Creates a paper. 
    
    .DESCRIPTION
    Creates a paper. Paper is used to highlight content within a page. 
    
    .PARAMETER Id
    The ID of the component. It defaults to a random GUID.
    
    .PARAMETER Children
    The content of this paper element. 
    
    .PARAMETER Width
    The width of this paper.
    
    .PARAMETER Height
    The height of this paper.
    
    .PARAMETER Square
    Whether this paper is square.
    
    .PARAMETER Style
    The CSS style to apply to this paper.
    
    .PARAMETER Elevation
    The elevation of this paper. 
    
    .EXAMPLE
    An example
    
    .NOTES
    General notes
    #>
    param(
        [Parameter()][string]$Id = ([Guid]::NewGuid()).ToString(),
        [Parameter()][Alias("Content")][ScriptBlock]$Children,
        [Parameter()][string]$Width = '500',
        [Parameter()][string]$Height = '500',
        [Parameter()][Switch]$Square,
        [Parameter()][Hashtable]$Style,
        [Parameter()][int]$Elevation
    )

    End 
    {
        @{
            type = 'mu-paper'
            isPlugin = $true
            assetId = $MUAssetId
            
            id = $Id
            width  = $Width 
            children = & $Children
            height = $Height
            square = $Square.IsPresent
            style = $Style
            elevation = $Elevation
        }
    }
}