function New-UDChart {
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
            color     = $ColorBy
        }
        $Chart
    }
}
function New-UDMonitor {
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
        [int]$Width,
        [Parameter()]
        [int]$Height = 400,
        [Parameter()]
        [int]$refresh = 1000

    )
    end {  

        $Endpoint = New-UDEndpoint -Endpoint $Content -Id $id 

        $monitor = @{
            type     = "viser-monitor"
            id       = $Id
            isPlugin = $true
            assetId  = $ChartAssetId
            content  = $Content.Invoke()
            fields   = $Fields
            color    = $ColorBy
            title    = $Title
            width    = $Width
            height   = $Height
            refresh  = $Refresh
        }
        $monitor
    }
}