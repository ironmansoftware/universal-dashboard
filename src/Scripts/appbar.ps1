function New-UDAppBar {
    <#
    .SYNOPSIS
    Creates an AppBar.
    
    .DESCRIPTION
    Creates an AppBar. This can be used to replace the built-in AppBar. 
    
    .PARAMETER Id
    The ID of the component. It defaults to a random GUID.
    
    .PARAMETER Drawer
    A drawer that can be opened from this AppBar. Use New-UDDrawer to create a drawer to pass to this parameter. 
    
    .PARAMETER Children
    Children of this AppBar. The children of an AppBar are commonly text and buttons.
    
    .PARAMETER Position
    The position of this AppBar. A fixed position will override the default AppBar. 

    .PARAMETER Footer
    Positions the app bar at the bottom of the page to create a footer

    .PARAMETER DisableThemeToggle
    Removes the theme toggle switch from the app bar. 
    .PARAMETER Color
    The theme color to use for the app bar.
    
    .EXAMPLE
    Creates a new AppBar that is relative to other components.

    New-UDAppBar -Children { New-UDTypography -Text 'Hello' -Paragraph } -Position relative
    #>
    param(
        [Parameter()]
        [string]$Id = [Guid]::NewGuid(),
        [Parameter()]
        [Hashtable]$Drawer,
        [Parameter()]
        [Alias('Content')]
        [ScriptBlock]$Children,
        [Parameter()]
        [ValidateSet('absolute', 'fixed', 'relative', 'static', 'sticky')]
        [string]$Position = 'fixed',
        [Parameter()]
        [switch]$Footer,
        [Parameter()]
        [Switch]$DisableThemeToggle,
        [Parameter()]
        [string]$ClassName,
        [Parameter()]
        [ValidateSet('default', 'inherit', 'primary', 'secondary', 'transparent')]
        [string]$Color = 'default'
    )

    @{
        id                 = $Id 
        type               = 'mu-appbar'
        assetId            = $MUAssetId 
        isPlugin           = $true 

        children           = & $Children
        drawer             = $Drawer
        position           = $Position
        footer             = $Footer.IsPresent
        disableThemeToggle = $DisableThemeToggle.IsPresent
        className          = $ClassName
        color              = $Color.ToLower()
    }
}