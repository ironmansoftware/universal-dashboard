function New-UDBackdrop {
    <#
    .SYNOPSIS
    Creates an overlay over the current page.
    
    .DESCRIPTION
    Creates an overlay over the current page.
    
    .PARAMETER Id
    The ID of this component
    
    .PARAMETER Color
    The color of the backdrop.
    
    .PARAMETER Children
    Child components to include in the backdrop.
    
    .PARAMETER Open
    Whether the backdrop is open.
    
    .PARAMETER OnClick
    A script block to invoke when the backdrop is clicked.
    #>
    param(
        [Parameter ()]
        [string]$Id = ([Guid]::NewGuid()).ToString(),
        [Parameter()]
        [DashboardColor]$Color = '#fff', 
        [Parameter(Mandatory)]
        [Alias("Content")]
        [ScriptBlock]$Children,
        [Parameter()]
        [Switch]$Open,
        [Parameter()]
        [Endpoint]$OnClick,
        [Parameter()]
        [string]$ClassName
    )

    if ($OnClick) {
        $OnClick.Register($Id, $PSCmdlet)
    }

    @{
        type      = 'mu-backdrop'
        isPlugin  = $true
        assetId   = $MUAssetId

        id        = $Id
        color     = $Color.HtmlColor 
        children  = & $Children
        open      = $Open.IsPresent
        onClick   = $OnClick
        className = $ClassName
    }
}