function New-UDFab {
    param(
        [Parameter()]
        [string] $Id = ([Guid]::NewGuid()),
        [Parameter()]
        [ScriptBlock]$Content,
        [Parameter()]
        [UniversalDashboard.Models.DashboardColor]$ButtonColor,
        [Parameter()]
        [UniversalDashboard.Models.DashboardColor]$IconColor,
        [Parameter()]
        [UniversalDashboard.Models.FontAwesomeIcons]$Icon,
        [Parameter()]
        [ValidateSet("small", "large")]
        $Size = "large",
        [Parameter()]
        [Switch]$Horizontal,
        [Parameter()]
        [object]$onClick,
        [Parameter()]
        [ValidateSet("left", "right", "top", "bottom")]
        [string]$ExpandDirection = "top"
    )

    if ($Horizontal) {
        $ExpandDirection = "left"
    }

    $iconName = [UniversalDashboard.Models.FontAwesomeIconsExtensions]::GetIconName($Icon)

    if ($null -ne $OnClick) {
        if ($OnClick -is [scriptblock]) {
            $OnClick = New-UDEndpoint -Endpoint $OnClick -Id $Id
        }
        elseif ($OnClick -isnot [UniversalDashboard.Models.Endpoint]) {
            throw "OnClick must be a script block or UDEndpoint"
        }
    }

    $Children = @()
    if ($null -ne $Content)
    {
        $Children = & $Content
    }

    @{
        type = "ud-fab"
        assetId = $AssetId
        isPlugin = $true 

        id = $id
        content = $Children
        size = $Size.tolower()
        backgroundColor = $ButtonColor.HtmlColor
        color = $IconColor.HtmlColor
        expandDirection = $ExpandDirection
        icon = $iconName
        onClick = $OnClick.Name
    }
}
function New-UDFabButton {
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
        [ValidateSet("Small", "Large")]
        $Size = "Large",
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
        type = "udfabbutton"
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