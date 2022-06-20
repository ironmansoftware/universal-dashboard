function New-UDDrawer {
    <#
    .SYNOPSIS
    Creates a new drawer.
    
    .DESCRIPTION
    Creates a new drawer. A drawer is a navigational component that is typically used for navigating between pages. It can be used with New-UDAppBar to provide a custom nav bar. 
    
    .PARAMETER Id
    The ID of the component. It defaults to a random GUID.
    
    .PARAMETER Children
    Navgiation controls to show within the drawer. Use New-UDList and New-UDListItem to generate links within the drawer. 

    .PARAMETER Variant
    The type of drawer. Valid values include "persistent", "permanent", "temporary"

    .PARAMETER Anchor
    Where to anchor the drawer. Valid values incldue "left", "right", "top", "bottom"
    
    .EXAMPLE
    Creates a custom navbar using New-UDDrawer

    $Drawer = New-UDDrawer -Id 'drawer' -Children {
        New-UDList -Content {
            New-UDListItem -Id 'lstHome' -Label 'Home' -OnClick { 
                Set-TestData 'Home'
                } -Content {
                    New-UDListItem -Id 'lstNested' -Label 'Nested' -OnClick {
                    Set-TestData 'Nested'
                    }
                } 
        }
    }

    New-UDElement -Tag 'main' -Content {
        New-UDAppBar -Children { New-UDTypography -Text 'Hello' -Paragraph } -Position relative -Drawer $Drawer
    }
    #>
    param(
        [Parameter()]
        [string]$Id = [Guid]::NewGuid(),
        [Parameter()]
        [Alias("Content")]
        [ScriptBlock]$Children,
        [ValidateSet("persistent", "permanent", "temporary")]
        [string]$Variant = "temporary",
        [ValidateSet("left", "right", "top", "bottom")]
        [string]$Anchor = "left",
        [Parameter()]
        [string]$ClassName
    )

    try {
        $c = & $Children
    }
    catch {
        $c = New-UDError -Message $_
    }

    @{
        type      = 'mu-drawer'
        id        = $Id 
        isPlugin  = $true 
        assetId   = $MUAssetId
        children  = $c
        variant   = $Variant.ToLower()
        anchor    = $Anchor.ToLower()
        className = $ClassName
    }
}