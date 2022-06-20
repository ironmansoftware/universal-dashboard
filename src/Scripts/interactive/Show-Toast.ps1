function Show-UDToast {
    <#
    .SYNOPSIS
    Displays a toast message to the user. 
    
    .DESCRIPTION
    Displays a toast message to the user. 
    
    .PARAMETER Message
    The message to display. 
    
    .PARAMETER MessageColor
    The text color of the message.
    
    .PARAMETER MessageSize
    The size of the message. 
    
    .PARAMETER Duration
    The duration in milleseconds before the message disappears. 
    
    .PARAMETER Title
    The title to display. 
    
    .PARAMETER TitleColor
    The text color of the title. 
    
    .PARAMETER TitleSize
    The size of the title. 
    
    .PARAMETER Id
    The ID of the toast. For use with Hide-UDToast. 
    
    .PARAMETER BackgroundColor
    The background color of the toast. 
    
    .PARAMETER Theme
    Light or dark theme. 
    
    .PARAMETER Icon
    The icon to display in the toast.
    
    .PARAMETER IconColor
    The color of the icon.
    
    .PARAMETER Position
    Where to display the toast. 
    
    .PARAMETER HideCloseButton
    Hides the close button.
    
    .PARAMETER CloseOnClick
    Closes the toast when clicked.
    
    .PARAMETER CloseOnEscape
    Closes the toast when esc is pressed. 
    
    .PARAMETER ReplaceToast
    Replaces an existing toast if one is already showing.
    
    .PARAMETER RightToLeft
    Right to left text.
    
    .PARAMETER Balloon
    Creates a balloon toast.
    
    .PARAMETER Overlay
    Displays an overlay behind the toast.
    
    .PARAMETER OverlayClose
    Allow the user to close the overlay. 
    
    .PARAMETER OverlayColor
    The color of the overlay. 
    
    .PARAMETER TransitionIn
    The transition in effect.
    
    .PARAMETER TransitionOut
    The transition out effect.
    
    .PARAMETER Broadcast
    Broadcasts the toast to all connected users. 
    
    .PARAMETER Persistent
    Prevents the toast from closing due to the duration.
    
    .EXAMPLE
    Show-UDToast -Message 'Hello, World!'

    Shows a toast message.
    #>
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
        [string]$Icon,
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
        [Switch]$Broadcast,
        [Parameter()]
        [Switch]$Persistent
    )

    $faIcon = $null
    if ($PSBoundParameters.ContainsKey('Icon') -and -not $Icon.StartsWith('fa')) {
        $faIcon = "fa fa-$($Icon.ToLower().Replace("_", "-"))"
    }
    elseif ($PSBoundParameters.ContainsKey('Icon')) {
        $faIcon = $Icon
    }

    if ($Persistent) {
        $Duration = $false
    }

    # if ($id -notmatch '^[a-zA-Z0-9]+$') {
    #     throw "Invalid ID. ID must be alphanumeric."
    # }

    $options = @{
        close           = -not $HideCloseButton.IsPresent
        id              = "x" + $Id
        message         = $Message
        messageColor    = $MessageColor.HtmlColor
        messageSize     = $MessageSize
        title           = $Title
        titleColor      = $TitleColor.HtmlColor
        titleSize       = $TitleSize
        timeout         = $Duration
        position        = $Position
        backgroundColor = $BackgroundColor.HtmlColor
        theme           = $Theme
        icon            = $faIcon
        iconColor       = $IconColor.HtmlColor
        displayMode     = if ($ReplaceToast.IsPresent) { 2 } else { 0 }
        rtl             = $RightToLeft.IsPresent
        balloon         = $Balloon.IsPresent
        overlay         = $Overlay.IsPresent
        overlayClose    = $OverlayClose.IsPresent
        overlayColor    = $OverlayColor.HtmlColor
        closeOnClick    = $CloseOnClick.IsPresent
        closeOnEscape   = $CloseOnEscape.IsPresent
        transitionIn    = $TransitionIn
        transitionOut   = $TransitionOut
    }

    if ($Broadcast) {
        $DashboardHub.SendWebSocketMessage("showToast", $options)
    }
    else {
        $DashboardHub.SendWebSocketMessage($ConnectionId, "showToast", $options)
    }
}
