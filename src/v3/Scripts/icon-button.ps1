function New-UDIconButton {
    <#
    .SYNOPSIS
    Creates a button with an icon.
    
    .DESCRIPTION
    Creates a button with an icon.
    
    .PARAMETER Id
    The ID of the component. It defaults to a random GUID.
    
    .PARAMETER Icon
    The icon to display within the button. 
    
    .PARAMETER OnClick
    A script block to execute when the button is clicked. 
    
    .PARAMETER Disable
    Whether the button is disabled. 
    
    .PARAMETER Href
    A link to navigate to when the button is clicked.
    
    .PARAMETER Style
    The CSS sytle to apply to the icon. 
    
    .EXAMPLE
    Creates an icon button with a user icon with a custom style.

    New-UDIconButton -Icon (New-UDIcon -Icon user -Size sm -Style @{color = '#000'})  -Id 'iconButtonContent' 
    #>
    param(
        [Parameter()]
        [string]$Id = ([Guid]::NewGuid()).ToString(),
        [Parameter ()]
		[PSTypeName('UniversalDashboard.Icon')]$Icon,
		[Parameter ()]
		[object] $OnClick, 
        [Parameter ()]
		[Switch] $Disable, 
        [Parameter ()]
		[string] $Href, 
        [Parameter ()]
		[Hashtable] $Style


    )

    End 
    {
        if ($null -ne $OnClick) {
            if ($OnClick -is [scriptblock]) {
                $OnClick =  New-UDEndpoint -Endpoint $OnClick -Id ($Id + "onClick")
            }
            elseif ($OnClick -isnot [UniversalDashboard.Models.Endpoint]) {
                throw "OnClick must be a script block or UDEndpoint"
            }
        }

        @{
            type = 'mu-icon-button'
            isPlugin = $true
            assetId = $MUAssetId
            id = $Id
            disable = $Disable
            style = $Style
            onClick = $OnClick
            icon = $Icon
            href = $Href
        }
    }
}