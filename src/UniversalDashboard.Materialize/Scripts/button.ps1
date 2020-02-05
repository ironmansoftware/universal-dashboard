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
        [Switch]$Disabled,
        [Parameter()]
        [Hashtable]$Style,
        [Parameter()]
        [string]
        $Height,
        [Parameter()]
        [string]
        $Width
    )

    if ($null -ne $OnClick) {
        if ($OnClick -is [scriptblock]) {
            $OnClick = New-UDEndpoint -Endpoint $OnClick -Id $Id
        }
        elseif ($OnClick -isnot [UniversalDashboard.Models.Endpoint]) {
            throw "OnClick must be a script block or UDEndpoint"
        }
    }

    if ((!($Style.BackgroundColor)) -and ($BackgroundColor)) {
        $Style += @{"Background-Color" = $BackgroundColor.HtmlColor}
    }
    if ((!($Style.Color)) -and ($FontColor)) {
        $Style += @{Color = $FontColor.HtmlColor}
    }
    if ((!($Style.Width)) -and ($Width)) {
        #check if the width is numerical, to append with "px" or if it is string, and not to be appended
        if ($Width -match "^[\d\.]+$") {
            $Style += @{Width = "$($Width)px"}
        }
        else {
            $Style += @{Width = $Width}
        }
    }
    if ((!($Style.Heigth)) -and ($Height)) {
        #check if the width is numerical, to append with "px" or if it is string, and not to be appended
        if ($Height -match "^[\d\.]+$") {
            $Style += @{Height = "$($Height)px"}
        }
        else {
            $Style += @{Height = $Height}
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
        style = $Style
    }
}
