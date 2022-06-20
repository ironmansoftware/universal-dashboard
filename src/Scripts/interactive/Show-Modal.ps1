function Show-UDModal {
    <#
    .SYNOPSIS
    Show a modal.
    
    .DESCRIPTION
    Show a modal.
    
    .PARAMETER FullScreen
    Create a full screen modal.
    
    .PARAMETER Footer
    The footer components for the modal.
    
    .PARAMETER Header
    The header components for the modal. 
    
    .PARAMETER Content
    The content of the modal. 
    
    .PARAMETER Persistent
    Whether the modal can be closed by clicking outside of it.
    
    .PARAMETER FullWidth
    Whether the modal is full width.
    
    .PARAMETER MaxWidth
    The max width of the modal.
    
    .EXAMPLE
    New-UDButton -Text 'Click Me' -OnClick {
        Show-UDModal -Content {
            New-UDTypography -Text "Hello World"
        }
    }
    #>
    param(
        [Parameter()]
        [Switch]$FullScreen,
        [Parameter()]
        [ScriptBlock]$Footer = {},
        [Parameter()]
        [ScriptBlock]$Header = {},
        [Parameter()]
        [ScriptBlock]$Content = {},
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
        maxWidth    = $MaxWidth
        fullWidth   = $FullWidth.IsPresent
        fullScreen  = $FullScreen.IsPresent
    }

    if ($null -ne $Footer) {
        $Modal['footer'] = & $Footer
    }

    if ($null -ne $Header) {
        $Modal['header'] = & $Header
    }

    if ($null -ne $Content) {
        $Modal['content'] = & $Content
    }

    $DashboardHub.SendWebSocketMessage($ConnectionId, "showModal", $modal)
}
