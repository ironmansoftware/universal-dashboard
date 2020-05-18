function New-UDProgress {
    <#
    .SYNOPSIS
    Creates a progress dialog.
    
    .DESCRIPTION
    Creates a progress dialog. Progress dialogs can show both determinate and indeterminate progress. They can also be circular or linear. 
    
    .PARAMETER Id
    The ID of the component. It defaults to a random GUID.
    
    .PARAMETER PercentComplete
    The percent complete for the progress.
    
    .PARAMETER BackgroundColor
    The background color.
    
    .PARAMETER ProgressColor
    The progress bar color. 
    
    .PARAMETER Circular
    Whether the progress is circular. 
    
    .PARAMETER Color
    The color of the progress.
    
    .PARAMETER Size
    The size of the progress.
    
    .EXAMPLE
    Creates a progress bar at 75%.

    New-UDProgress -PercentComplete 75
    #>
    [CmdletBinding(DefaultParameterSetName = "indeterminate")]
    param(
        [Parameter()]
        [string]$Id = [Guid]::NewGuid().ToString(),
        [Parameter(ParameterSetName = "determinate")]
        [ValidateRange(0, 100)]
        $PercentComplete,
        [Parameter(ParameterSetName = "determinate")]
        [Parameter(ParameterSetName = "indeterminate")]
        [UniversalDashboard.Models.DashboardColor]$BackgroundColor,
        [Parameter(ParameterSetName = "determinate")]
        [Parameter(ParameterSetName = "indeterminate")]
        [UniversalDashboard.Models.DashboardColor]$ProgressColor,
        [Parameter(ParameterSetName = 'circular')]
        [Switch]$Circular,
        [Parameter(ParameterSetName = 'circular')]
        [ValidateSet('blue', 'red', 'green')]
        [string]$Color,
        [Parameter(ParameterSetName = 'circular')]
        [ValidateSet('small', 'medium', 'large')]
        [string]$Size
        )

        End {
            @{
                id = $Id
                assetId = $MUAssetId 
                isPlugin = $true 
                type = "mu-progress"
          
                variant = $PSCmdlet.ParameterSetName
                percentComplete = $PercentComplete
                backgroundColor = $BackgroundColor.HtmlColor
                progressColor = $ProgressColor.HtmlColor
                circular = $Circular.IsPresent
                color = $Color
                size = $Size
            }          
        }


}