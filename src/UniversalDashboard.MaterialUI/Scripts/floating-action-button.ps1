function New-UDFloatingActionButton {
    param(
        [Parameter()]
        [string] $Id = ([Guid]::NewGuid()),
        [Parameter()]
        [UniversalDashboard.Models.DashboardColor]$ButtonColor,
        [Parameter()]
        [UniversalDashboard.Models.DashboardColor]$IconColor,
        [Parameter()]
        [UniversalDashboard.Models.FontAwesomeIcons]$Icon,
        [Parameter()]
        [ValidateSet("small", "medium", "large")]
        $Size = "large",
        [Parameter()]
        [object]$onClick
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