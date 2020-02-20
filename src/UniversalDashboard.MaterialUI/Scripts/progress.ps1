function New-UDProgress {
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
          
                percentComplete = $PercentComplete
                backgroundColor = $BackgroundColor.HtmlColor
                progressColor = $ProgressColor.HtmlColor
                circular = $Circular.IsPresent
                color = $Color
                size = $Size
            }          
        }


}