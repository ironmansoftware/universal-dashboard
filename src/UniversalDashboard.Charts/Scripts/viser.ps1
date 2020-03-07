function New-ViserChart {
    [Cmdletbinding()]
    param(
        [Parameter()]
        [string]$Id = (New-Guid).Guid,
        [Parameter()]
        [object]$Content,
        [Parameter()]
        [string]$Title,
        [Parameter()]
        [string]$Description,
        [Parameter()]
        [string[]]$Fields,
        [Parameter()]
        [string]$ColorBy,
        [Parameter()]
        [ValidateSet("Line", "Bar", "Column")]
        [string]$ChartType = "Column"
    )
    end {  
        $Chart = @{
            type      = "viser-chart"
            id        = $Id
            isPlugin  = $true
            assetId   = $ChartAssetId
            content   = $Content | ConvertTo-Json -Compress
            chartType = $ChartType
            fields    = $Fields
            color = $ColorBy
        }
        $Chart
    }
}
function New-ViserMonitor {
    [Cmdletbinding()]
    param(
        [Parameter()]
        [string]$Id = (New-Guid).Guid,
        [Parameter()]
        [scriptblock]$Content,
        [Parameter()]
        [string]$Title,
        [Parameter()]
        [string]$Description,
        [Parameter()]
        [string[]]$Fields,
        [Parameter()]
        [string]$ColorBy,
        [Parameter()]
        [ValidateSet("Line", "Bar", "Column")]
        [string]$ChartType = "Column"
    )
    end {  

        $Endpoint = New-UDEndpoint -Endpoint $Content -Id $id 
        $monitor = @{
            type      = "viser-monitor"
            id        = $Id
            isPlugin  = $true
            assetId   = $ChartAssetId
            content   = $Content.Invoke()
            # chartType = $ChartType
            fields    = $Fields
            # color = $ColorBy
        }
        $monitor
    }
}