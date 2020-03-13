function New-UDDrawer 
{
    <#
    .SYNOPSIS
    Creates a new drawer.
    
    .DESCRIPTION
    Creates a new drawer. A drawer is a navigational component that is typically used for navigating between pages. It can be used with New-UDAppBar to provide a custom nav bar. 
    
    .PARAMETER Id
    The ID of the component. It defaults to a random GUID.
    
    .PARAMETER Children
    Navgiation controls to show within the drawer. Use New-UDList and New-UDListItem to generate links within the drawer. 
    
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
        [ScriptBlock]$Children
    )

    @{
        type = 'mu-drawer'
        id = $Id 
        isPlugin = $true 
        assetId = $MUAssetId
        children = & $Children
    }
}