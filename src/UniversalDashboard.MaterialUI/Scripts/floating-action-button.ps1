function New-UDFloatingActionButton {
    <#
    .SYNOPSIS
    Creates a new floating action button. 
    
    .DESCRIPTION
    Creates a new floating action button. Floating action buttons are good for actions that make sense for an entire page. They can be pinned to the bottom of a page. 
    
    .PARAMETER Id
    The ID of the component. It defaults to a random GUID.
    
    .PARAMETER Icon
    The icon to put within the floating action button. 
    
    .PARAMETER Size
    The size of the button. 
    
    .PARAMETER OnClick
    A script block to execute when the floating action button is clicked. 
    
    .EXAMPLE
    Creates a floating action button with a user icon and shows a toast when clicked. 

    New-UDFloatingActionButton -Icon user -OnClick {
        Show-UDToast -Message 'Hello'
    }

    #>
    param(
        [Parameter()]
        [string] $Id = ([Guid]::NewGuid()),
        [Parameter()]
        [UniversalDashboard.Models.FontAwesomeIcons]$Icon,
        [Parameter()]
        [ValidateSet("small", "medium", "large")]
        $Size = "large",
        [Parameter()]
        [object]$OnClick
    )

    $iconName = [UniversalDashboard.Models.FontAwesomeIconsExtensions]::GetIconName($Icon)

    if ($null -ne $OnClick) {
        if ($OnClick -is [scriptblock]) {
            $OnClick = New-UDEndpoint -Endpoint $OnClick -Id $Id
        }
        elseif ($OnClick -isnot [UniversalDashboard.Models.Endpoint]) {
            throw "OnClick must be a script block or UDEndpoint"
        }
    }

    @{
        type = "mu-fab"
        assetId = $AssetId
        isPlugin = $true 

        id = $id
        size = $Size.tolower()
        backgroundColor = $ButtonColor.HtmlColor
        color = $IconColor.HtmlColor
        icon = $iconName
        onClick = $OnClick.Name
    }
}