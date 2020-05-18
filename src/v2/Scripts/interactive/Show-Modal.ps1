function Show-UDModal
{
    param(
        [Parameter()]
        [Switch]$FullScreen,
        [Parameter()]
        [ScriptBlock]$Footer,
        [Parameter()]
        [ScriptBlock]$Header,
        [Parameter()]
        [ScriptBlock]$Content,
        [Parameter()]
        [Switch]$Persistent,
        [Parameter()]
        [Switch]$FullWidth,
        [Parameter()]
        [ValidateSet("xs", "sm", "md", "lg", "xl")]
        [string]$MaxWidth
    )

    $Modal = @{
        dismissible = -not $Persistent.IsPresent
        max = $MaxWidth
        fullWidth = $FullWidth.IsPresent
        fullScreen = $FullScreen.IsPresent
    }

    if ($null -ne $Footer)
    {
        $Modal['footer'] = & $Footer
    }

    if ($null -ne $Header)
    {
        $Modal['header'] = & $Header
    }

    if ($null -ne $Content)
    {
        $Modal['content'] = & $Content
    }

    $DashboardHub.SendWebSocketMessage($ConnectionId, "showModal", $modal)
}
