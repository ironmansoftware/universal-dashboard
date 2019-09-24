function New-UDButton {
    param(
        [Parameter()]
        [String]$Id = ([Guid]::NewGuid()),
        [Parameter()]
        $Text,
        [Parameter()]
        [object]$OnClick,
        [Parameter()]
        [Switch]$Floating,
        [Parameter()]
        [Switch]$Flat,
        [Parameter()]
        [UniversalDashboard.Models.FontAwesomeIcons]$Icon,
        [Parameter()]
        [ValidateSet('left', 'right')]
        [String]$IconAlignment = 'left',
        [Parameter()] 
        [UniversalDashboard.Models.DashboardColor]$BackgroundColor,
        [Parameter()] 
        [UniversalDashboard.Models.DashboardColor]$FontColor,
        [Parameter()]
        [Switch]$Disabled
    )

    if ($null -ne $OnClick) {
        if ($OnClick -is [scriptblock]) {
            $OnClick = New-UDEndpoint -Endpoint $OnClick -Id $Id
        }
        elseif ($OnClick -isnot [UniversalDashboard.Models.Endpoint]) {
            throw "OnClick must be a script block or UDEndpoint"
        }
    }

    if ($PSBoundParameters.ContainsKey("Icon")) {
        $IconName = [UniversalDashboard.Models.FontAwesomeIconsExtensions]::GetIconName($Icon)
    }

    @{
        type = 'ud-button'
        isPlugin = $true 

        id = $id 
        onClick = $OnClick.Name
        icon = $IconName
        disabled = $Disabled.IsPresent
        flat = $Flat.IsPresent 
        floating = $Floating.IsPresent
        iconAlignment = $IconAlignment
        text = $Text 
        backgroundColor = $BackgroundColor.HtmlColor 
        fontColor = $FontColor.HtmlColor
    }
}