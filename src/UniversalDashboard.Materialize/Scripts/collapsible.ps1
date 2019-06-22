function New-UDCollapsible {
    param(
        [Parameter()]
        [String]$Id = (New-Guid),
        [Parameter(Mandatory = $true, Position = 0)]
        [ScriptBlock]$Items,
        [Parameter()]
        [UniversalDashboard.Models.DashboardColor]$BackgroundColor = 'White',
        [Parameter()]
        [UniversalDashboard.Models.DashboardColor]$FontColor = 'Black',
        [Parameter()]
        [Switch]$Popout,
        [Parameter()]
        [ValidateSet("Expandable", "Accordion")]
        [String]$Type = 'Expandable'
    )

    @{
        type = 'ud-collapsible'
        isPlugin = $true
        assetId = $AssetId

        id = $id
        items = $Items.Invoke()
        backgroundColor = $BackgroundColor.HtmlColor
        color = $Color.HtmlColor
        popout = $Popout.IsPresent
        accordion = $Type -eq 'Accordion'
    }
}

function New-UDCollapsibleItem {
    [CmdletBinding(DefaultParameterSetName = "content")]
    param(
        [Parameter()]
        [String]$Id = (New-Guid),
        [Parameter()]
		[String]$Title,
		[Parameter()]
	    [UniversalDashboard.Models.FontAwesomeIcons]$Icon,
		[Parameter(ParameterSetName = "content")]
        [ScriptBlock]$Content,
        [Parameter(ParameterSetName = "endpoint")]
        [object]$Endpoint,
        [Parameter(ParameterSetName = "endpoint")]
        [Switch]$AutoRefresh,
        [Parameter(ParameterSetName = "endpoint")]
		[int]$RefreshInterval = 5,
		[Parameter()]
        [Switch]$Active,
        [Parameter()]
        [UniversalDashboard.Models.DashboardColor]$BackgroundColor = 'White',
        [Parameter()]
        [UniversalDashboard.Models.DashboardColor]$FontColor = 'Black'
    )

    if ($PSCmdlet.ParameterSetName -eq 'Content') {
        $pContent = $Content.Invoke()
    }
    else {
        if ($null -ne $Endpoint) {
            if ($Endpoint -is [scriptblock]) {
                $Endpoint = New-UDEndpoint -Endpoint $Endpoint -Id $Id
            }
            elseif ($Endpoint -isnot [UniversalDashboard.Models.Endpoint]) {
                throw "Endpoint must be a script block or UDEndpoint"
            }
        }
    }

    $iconName = $null
    if ($PSBoundParameters.ContainsKey("Icon")) {
        $iconName = [UniversalDashboard.Models.FontAwesomeIconsExtensions]::GetIconName($Icon)
    }

    @{
        id = $Id 
        title = $Title 
        content = $pContent 
        endpoint = $Endpoint.Name 
        autoRefresh = $AutoRefresh.IsPresent
        refreshInterval = $RefreshInterval
        active = $Active.IsPresent
        backgroundColor = $BackgroundColor.HtmlColor
        color = $Color.HtmlColor
        icon = $iconName
    }
}