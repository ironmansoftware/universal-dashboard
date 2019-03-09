function New-UDGridLayout {
    param(
        [Parameter()]
        [string]$Id = (New-Guid).ToString(),
        [Parameter()]
        [int]$RowHeight = 30,
        [Parameter()]
        [scriptblock]$Content,
        [Parameter()]
        [Hashtable[]]$Layout,
        [Parameter()]
        [int]$LargeColumns = 12,
        [Parameter()]
        [int]$MediumColumns = 10,
        [Parameter()]
        [int]$SmallColumns = 6,
        [Parameter()]
        [int]$ExtraSmallColumns = 4,
        [Parameter()]
        [int]$ExtraExtraSmallColumns = 2,
        [Parameter()]
        [int]$LargeBreakpoint = 1200,
        [Parameter()]
        [int]$MediumBreakpoint = 996,
        [Parameter()]
        [int]$SmallBreakpoint = 768,
        [Parameter()]
        [int]$ExtraSmallBreakpoint = 480,
        [Parameter()]
        [int]$ExtraExtraSmallBreakpoint = 0,
        [Parameter()]
        [switch]$Draggable,
        [Parameter()]
        [switch]$Resizable
    )

    End {
        $Breakpoints = @{
            lg = $LargeBreakpoint
            md = $MediumBreakpoint
            sm = $SmallBreakpoint
            xs = $ExtraSmallBreakpoint
            xxs = $ExtraExtraSmallBreakpoint
        }

        $Columns  = @{
            lg = $LargeColumns
            md = $MediumColumns
            sm = $SmallColumns
            xs = $ExtraSmallColumns
            xxs = $ExtraExtraSmallColumns
        }

        @{
            type = "grid-layout"
            id = $Id
            className = "layout"
            rowHeight = $RowHeight
            content = $Content.Invoke()
            layout = $Layout
            cols = $Columns
            breakpoints = $Breakpoints
            isDraggable = $Draggable.IsPresent
            isResizable = $Resizable.IsPresent
        }
    }
}

function New-UDGridLayoutElement {
    param(
        [Parameter()]
        [string]$Id,
        [Parameter()]
        [scriptblock]$Content
    )

    End {
        @{
            type = "grid-layout-element"
            id = $Id
            content = $Content.Invoke()
        }
    }
}