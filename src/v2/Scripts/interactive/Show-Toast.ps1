function Show-UDToast 
{
    param(
        [Parameter(Mandatory, Position = 0)]
		[string]$Message,
        [Parameter()]
        [DashboardColor]$MessageColor,
        [Parameter()]
        [string]$MessageSize,
        [Parameter()]
        [int]$Duration = 1000,
        [Parameter()]
        [string]$Title, 
        [Parameter()]
        [DashboardColor]$TitleColor,
        [Parameter()]
        [string]$TitleSize,
        [Parameter()]
        [string]$Id = [Guid]::NewGuid(),
        [Parameter()]
        [DashboardColor]$BackgroundColor,
        [Parameter()]
        [ValidateSet("light", "dark")]
        [string]$Theme,
        [Parameter()]
        [FontAwesomeIcons]$Icon,
        [Parameter()]
        [DashboardColor]$IconColor,
        [Parameter()]
        [ValidateSet("bottomRight", "bottomLeft", "topRight", "topLeft", "topCenter", "bottomCenter", "center")]
        [string]$Position = "topRight",
        [Parameter()]
        [Switch]$HideCloseButton,
        [Parameter()]
        [Switch]$CloseOnClick,
        [Parameter()]
        [Switch]$CloseOnEscape,
        [Parameter()]
        [Switch]$ReplaceToast,
        [Parameter()]
        [Switch]$RightToLeft,
        [Parameter()]
        [Switch]$Balloon,
        [Parameter()]
        [Switch]$Overlay,
        [Parameter()]
        [Switch]$OverlayClose,
        [Parameter()]
        [DashboardColor]$OverlayColor,
        [Parameter()]
        [ValidateSet("bounceInLeft", "bounceInRight", "bounceInUp", "bounceInDown", "fadeIn", "fadeInDown", "fadeInUp", "fadeInLeft", "fadeInRight", "flipInX")]
        [string]$TransitionIn = "fadeInUp",
        [Parameter()]
        [ValidateSet("bounceInLeft", "bounceInRight", "bounceInUp", "bounceInDown", "fadeIn", "fadeInDown", "fadeInUp", "fadeInLeft", "fadeInRight", "flipInX")]
        [string]$TransitionOut = "fadeOut",
        [Parameter()]
        [Switch]$Broadcast
    )

    $options = @{
        close = -not $HideCloseButton.IsPresent
        id = $Id
        message = $Message
        messageColor = $MessageColor.HtmlColor
        messageSize = $MessageSize
        title = $Title
        titleColor = $TitleColor.HtmlColor
        titleSize = $TitleSize
        timeout = $Duration
        position = $Position
        backgroundColor = $BackgroundColor.HtmlColor
        theme = $Theme
        icon = if ($Icon -eq [FontAwesomeIcons]::None) { "" } else { [UniversalDashboard.Models.FontAwesomeIconsExtensions]::GetIconName($Icon) }
        iconColor = $IconColor.HtmlColor
        displayMode = if ($ReplaceToast.IsPresent) {2 } else { 0 }
        rtl = $RightToLeft.IsPresent
        balloon = $Balloon.IsPresent
        overlay = $Overlay.IsPresent
        overlayClose = $OverlayClose.IsPresent
        overlayColor = $OverlayColor.HtmlColor
        closeOnClick = $CloseOnClick.IsPresent
        closeOnEscape = $CloseOnEscape.IsPresent
        transitionIn = $TransitionIn
        transitionOut = $TransitionOut
    }

    if ($Broadcast)
    {
        $DashboardHub.SendWebSocketMessage("showToast", $options)
    }
    else 
    {
        $DashboardHub.SendWebSocketMessage($ConnectionId, "showToast", $options)
    }
}
