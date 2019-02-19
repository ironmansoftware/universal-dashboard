function New-UDTreeNode {
    param(
        [Parameter(Mandatory, Position = 1)]
		[string]$Name,
		[Parameter()]
		[string]$Id = (New-Guid).ToString(),
        [Parameter()]
		[ScriptBlock]$Children,
		[Parameter()]
        [UniversalDashboard.Models.FontAwesomeIcons]$Icon
    )

    @{
        type = 'treeNode'
        isPlugin = $true
        assetId = $Script:AssetId
        name = $Name 
        id = $Id 
        children = $Children.Invoke()
        icon = $Icon.ToString().Replace('_', '-')
    }
}

function New-UDTreeView {
    param(
        [Parameter(Mandatory)]
        [object]$Node,

        [Parameter()]
        [object]$OnNodeClicked,

        [Parameter()]
        [UniversalDashboard.Models.DashboardColor]$BackgroundColor = 'White',

        [Parameter()]
        [UniversalDashboard.Models.DashboardColor]$FontColor = 'Black',

        [Parameter()]
        [UniversalDashboard.Models.DashboardColor]$ActiveBackgroundColor = 0xDFE8E4,

        [Parameter()]
        [UniversalDashboard.Models.DashboardColor]$ToggleColor = 'black'
    )

    if (-not ($OnNodeClicked -is [UniversalDashboard.Models.Endpoint])) {
        $OnNodeClicked = New-UDEndpoint -Endpoint $OnNodeClicked -Id $Id
    }

    @{
        type = 'treeView'
        isPlugin = $true
        assetId = $Script:AssetId 
        node = $Node
        backgroundColor = $BackgroundColor.HtmlColor
        fontColor = $FontColor.HtmlColor
        activeBackgroundColor = $ActiveBackgroundColor.HtmlColor
        toggleColor = $ToggleColor.HtmlColor
    }
}