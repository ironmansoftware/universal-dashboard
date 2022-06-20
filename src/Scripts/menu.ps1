function New-UDMenu {
    <#
    .SYNOPSIS
    Creates a pop up menu.
    
    .DESCRIPTION
    Creates a pop up menu.
    
    .PARAMETER Id
    The ID of this component.
    
    .PARAMETER Text
    The text to display in the button that opens this menu.
    
    .PARAMETER OnChange
    An event handler to call when the user selects an item from the menu. $EventData will include the selected item. 
    
    .PARAMETER Children
    The items to display in the menu.
    
    .PARAMETER ClassName
    The class name of the menu.
    
    .PARAMETER Variant
    The button variant for the menu.
    
    .EXAMPLE
    New-UDMenu -Text 'Click Me' -OnChange {
        Show-UDToast $EventData
    } -Children {
        New-UDMenuItem -Text 'Test'
        New-UDMenuItem -Text 'Test2'
        New-UDMenuItem -Text 'Test3'
    }

    Creates a simple menu.
    #>
    param(
        [Parameter()]
        [string]$Id = [Guid]::NewGuid(),
        [Parameter(Mandatory)]
        [string]$Text,
        [Parameter()]
        [Endpoint]$OnChange,
        [Parameter(Mandatory)]
        [Alias('Items')]
        [Alias('Content')]
        [ScriptBlock]$Children,
        [Parameter]
        [string]$ClassName,
        [ValidateSet("text", "outlined", "contained")]
        [string]$Variant = "contained",
        [Parameter()]
        [Hashtable]$Icon
    )

    if ($OnChange) {
        $OnChange.Register($Id, $PSCmdlet)
    }

    @{
        assetId   = $MUAssetId 
        id        = $Id 
        isPlugin  = $true 
        type      = 'mu-menu'

        text      = $Text
        onChange  = $OnChange
        children  = & $Children
        className = $ClassName
        icon      = $Icon
        variant   = $Variant.ToLower()
    }
}

function New-UDMenuItem {
    <#
    .SYNOPSIS
    Creates a menu item.
    
    .DESCRIPTION
    Creates a menu item.
    
    .PARAMETER Text
    The text to display in the menu item. 
    
    .PARAMETER Value
    The value of the menu item. If not specified, the text will be used.
    
    .EXAMPLE
    New-UDMenu -Text 'Click Me' -OnChange {
        Show-UDToast $EventData
    } -Children {
        New-UDMenuItem -Text 'Test'
        New-UDMenuItem -Text 'Test2'
        New-UDMenuItem -Text 'Test3'
    }

    Creates a simple menu.
    #>
    param(
        [Parameter(Mandatory)]
        [string]$Text,
        [Parameter()]
        [string]$Value,
        [Parameter()]
        [Hashtable]$Icon
    )

    @{
        text  = $Text 
        value = if ($Value) { $Value } else { $Text }
        icon  = $Icon
    }
}