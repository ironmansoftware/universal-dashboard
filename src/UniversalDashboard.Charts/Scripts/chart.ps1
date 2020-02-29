function New-Chart {
    [Cmdletbinding()]
    param(
        [Parameter()]
        [string]$Id = (New-Guid).Guid,
        [Parameter()]
        [scriptblock]$Content, 
        [Parameter()]
        [PSTypeName("antv.chart.title")]$title, 
        [Parameter()]
        [PSTypeName("antv.chart.description")]$description, 
        [Parameter()]
        [string]$XField, 
        [Parameter()]
        [string]$YField,
        [Parameter()]
        [ValidateSet("Line", "Bar", "Column", "Area", "Dashboard", "Pie")]
        [string]$ChartType,
        [Parameter()]
        [PSTypeName("antv.chart.legend")]$Legend,
        [Parameter()]
        [PSTypeName("antv.chart.label")]$Label,
        [Parameter()]
        [PSTypeName("antv.chart.interactions")]$Interactions,
        [Parameter()]
        [PSTypeName("antv.chart.tooltip")]$ToolTip
    )
    end {
        @{
            type         = "chart"
            id           = $Id
            isPlugin     = $true
            assetId      = $ChartAssetId
            content      = $Content.Invoke() | ConvertTo-Json -Compress
            title        = $Title
            description  = $description
            xField       = $XField
            yField       = $YField
            chartType    = $ChartType
            legend       = $Legend
            tooltip      = $ToolTip
            label        = $Label
            interactions = $Interactions
        }
    }
}

function New-ChartTitle {
    [CmdletBinding()]
    [OutputType("antv.chart.title")]
    param(
        [Parameter()]
        [switch]$Visible,
        [Parameter()]
        [string]$Text,
        [Parameter()]
        [hashtable]$Style
    )

    end {
        $Title = @{
            visible = $Visible.IsPresent
            text    = $Text
            style   = $Style    
        }
        $Title.psobject.insert(0, "antv.chart.title")
        $Title
    }
}
function New-ChartDescription {
    [CmdletBinding()]
    [OutputType("antv.chart.description")]
    param(
        [Parameter()]
        [switch]$Visible,
        [Parameter()]
        [string]$Text,
        [Parameter()]
        [hashtable]$Style
    )

    end {
        $Description = @{
            visible = $Visible.IsPresent
            text    = $Text
            style   = $Style    
        }
        $Description.psobject.insert(0, "antv.chart.description")
        $Description
    }
}
function New-ChartLegend {
    [CmdletBinding()]
    [OutputType("antv.chart.legend")]
    param(
        [Parameter()]
        [switch]$Visible,
        [Parameter()]
        [ValidateSet(
            "left-top", "left-center", "left-bottom", "right-top", "right-center", "right-bottom", 
            "top-left", "top-center", "top-right", "bottom-left", "bottom-center", "bottom-right"
        )]
        [string]$Position,
        [Parameter()]
        [ValidateSet(
            "circle", "square", "bowtie", "diamond", "hexagon", "triangle", 
            "triang", "le-down", "hollowCircle", "hollowSquare", "hollow Bowtie", "hollowDiamond", 
            "hollowHexagon", "hollowTriangle", " hollowTriangle-down", "cross", "tick", "plus", "hyphen", "line"
        )]
        [string]$Marker,
        [Parameter()]
        [int]$OffsetX,
        [Parameter()]
        [int]$OffsetY
    )

    end {
        $Legend = @{
            visible  = $Visible.IsPresent
            position = $Position
            marker   = $Marker
            offsetX  = $OffsetX
            offsetY  = $OffsetY    
        }
        $Legend.psobject.insert(0, "antv.chart.legend")
        $Legend
    }
}

function New-ChartLabel {
    [CmdletBinding()]
    [OutputType("antv.chart.label")]
    param(
        [Parameter()]
        [switch]$Visible,
        [Parameter()]
        [ValidateSet("point", "line")]
        [string]$Type,
        [Parameter()]
        [int]$OffsetX,
        [Parameter()]
        [int]$OffsetY,
        [Parameter()]
        [hashtable]$Style
    )

    end {
        $Label = @{
            visible = $Visible.IsPresent
            type    = $Type
            offsetX = $OffsetX
            offsetY = $OffsetY    
            style   = $Style    
        }
        $Label.psobject.insert(0, "antv.chart.label")
        $Label
    }
}
function New-ChartTooltip {
    [CmdletBinding()]
    [OutputType("antv.chart.tooltip")]
    param(
        [Parameter()]
        [switch]$Visible,
        [Parameter()]
        [switch]$Shared,
        [Parameter()]
        [PSTypeName("antv.chart.tooltip.crosshairs")]$Crosshairs,
        [Parameter()]
        [object]$CustomTooltip
    )

    end {
        $Tooltip = @{
            visible       = $Visible.IsPresent
            shared        = $Shared.IsPresent
            crosshairs    = $Crosshairs
            customTooltip = $CustomTooltip
        }
        $Tooltip.psobject.insert(0, "antv.chart.tooltip")
        $Tooltip
    }
}

function New-ChartTooltipCrosshairs {
    [CmdletBinding()]
    [OutputType("antv.chart.tooltip.crosshairs")]
    param(
        [Parameter()]
        [ValidateSet("x", "y", "cross")]
        [string]$Type,
        [Parameter()]
        [hashtable]$Style
    )

    end {
        $Crosshairs = @{
            type  = $Type
            style = $Style    
        }
        $Crosshairs.psobject.insert(0, "antv.chart.tooltip.crosshairs")
        $Crosshairs
    }
}

