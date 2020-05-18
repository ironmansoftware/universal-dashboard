function New-UDTreeView {
    param(
        [Parameter()]
        [string]$Id = [Guid]::NewGuid(),
        [Parameter(Mandatory)]
        [Hashtable]$Node,
        [Parameter()]
        [object]$OnNodeClicked,
        [Parameter()]
        [DashboardColor]$BackgroundColor,
        [Parameter()]
        [DashboardColor]$FontColor = 'black',
        [Parameter()]
        [DashboardColor]$ActiveBackgroundColor = '0xDFE8E4',
        [Parameter()]
        [DashboardColor]$ToggleColor = 'black'
    )

    End {
        if ($null -ne $OnNodeClicked) {
            if ($OnNodeClicked -is [scriptblock]) {
                $OnNodeClicked = New-UDEndpoint -Endpoint $OnNodeClicked -Id $Id
            }
            elseif ($OnNodeClicked -isnot [UniversalDashboard.Models.Endpoint]) {
                throw "OnNodeClicked must be a script block or UDEndpoint"
            }
        }

        
        @{
            assetId = $AssetId 
            isPlugin = $true 
            id = $Id 
            type = 'ud-treeview'

            node = $Node 
            hasCallback = $null -ne $OnNodeClicked
            backgroundColor = $BackgroundColor.HtmlColor
            fontColor = $FontColor.HtmlColor
            activeBackgroundColor = $ActiveBackgroundColor.HtmlColor
            toggleColor = $ToggleColor.HtmlColor
        }
    }
}

function New-UDTreeNode {
    param(
        [Parameter(Mandatory, Position = 1)]
		[string]$Name,
		[Parameter()]
		[string]$Id,
        [Parameter()]
		[ScriptBlock]$Children,
		[Parameter()]
        [UniversalDashboard.Models.FontAwesomeIcons]$Icon,
        [Parameter()]
        [UniversalDashboard.Models.FontAwesomeIcons]$ExpandedIcon
    )

    End {
        if ($PSBoundParameters.ContainsKey("Icon")) {
            $IconName = [UniversalDashboard.Models.FontAwesomeIconsExtensions]::GetIconName($Icon)
        }
        
        if ($PSBoundParameters.ContainsKey("ExpandedIcon")) {
            $ExpandedIconName = [UniversalDashboard.Models.FontAwesomeIconsExtensions]::GetIconName($ExpandedIcon)
        }

        $ChildrenArray = $null
        if ($PSBoundParameters.ContainsKey("Children"))
        {
            $ChildrenArray = & $Children
        }
        
        @{
            name = $Name 
            id = $Id 
            children = $ChildrenArray 
            icon = $IconName 
            expandedIcon = $ExpandedIconName
        }
    }
}