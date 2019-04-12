function New-UDButton {
    param(
        [Parameter()]
        [String]$Id = (New-Guid),
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
        [UniversalDashboard.Models.DashboardColor]$FontColor
    )

    $btnClass = 'btn'
    if ($Floating) {
        $btnClass = 'btn-floating'
    }

    if ($Flat) {
        $btnClass = 'btn-flat'
    }

    $style = @{ 
        backgroundColor = $BackgroundColor.HtmlColor 
        color = $FontColor.HtmlColor 
    }

    New-UDElement -Id $Id -Tag "a" -Attributes @{
        className = "$btnClass"
        onClick = $OnClick
        style = $style
    } -Content {
        if ($Icon -ne $null) {
            $faClass = $Icon.ToString().Replace('_', '-')
            New-UDElement -Tag 'i' -Attributes @{ className = "fa fa-$faClass $iconAlignment" }
        }

        $Text
    }
}