function New-UDContainer {
    <#
    .SYNOPSIS
    Creates a Material UI container. 
    
    .DESCRIPTION
    Creates a Material UI container. Containers pad the left and right side of the contained content to center it on larger resolution screens.
    
    .PARAMETER Id
    The ID of this component.
    
    .PARAMETER Children
    The child items to include within the container. 
    
    .EXAMPLE
    Creates a container with some text.

    New-UDContainer -Content {
        New-UDTypography -Text 'Nice'
    }
    #>
    param(
        [Parameter()]
        [string]$Id = ([Guid]::NewGuid()).ToString(),

        [Alias("Content")]
        [Parameter(Mandatory, Position = 0)]
        [ScriptBlock]$Children,

        [Parameter()]
        [string]$ClassName
    )

    Process {
        try {
            $c = New-UDErrorBoundary -Content $Children    
        }
        catch {
            $c = New-UDError -Message $_
        }
        

        @{
            isPlugin  = $true 
            id        = $id 
            assetId   = $MUAssetId
            type      = "mu-container"

            children  = $c
            className = $ClassName
        }
    }
}