function New-AntvChart {
    [Cmdletbinding()]
    param(
        [Parameter()]
        [string]$Id = (New-Guid).Guid,
        [Parameter()]
        [scriptblock]$Content, 
        [Parameter()]
        [string]$title, 
        [Parameter()]
        [string]$description, 
        [Parameter()]
        [string]$XField, 
        [Parameter()]
        [string]$YField,
        [Parameter()]
        [ValidateSet('Line','Bar','Column','Area','Dashboard','Pie')]
        [string]$ChartType
    )
    end {
        @{
            type        = 'antv-chart'
            id          = $Id
            isPlugin    = $true
            assetId     = $MUAssetId
            content     = $Content.Invoke()
            title       = $Title
            description = $description
            xField      = $XField
            yField      = $YField
            chartType = $ChartType
        }
    }
}
