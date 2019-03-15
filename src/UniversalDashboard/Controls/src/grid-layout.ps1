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
        [string]$LayoutJson,
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
        [switch]$Resizable,
        [Parameter()]
        [switch]$Persist,
        [Parameter()]
        [object]$OnLayoutChanged
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

        if ($null -ne $OnLayoutChanged -and $OnLayoutChanged -is ([ScriptBlock])) {
            $OnLayoutChanged = New-UDEndpoint -Endpoint $OnLayoutChanged
        }
        elseif ($null -ne $OnLayoutChanged -and $OnLayoutChanged -isnot ([UniversalDashboard.Models.Endpoint])) {
            throw "OnLayoutChanged must be a ScriptBlock of UDEndpoint"
        }

        @{
            type = "grid-layout"
            id = $Id
            className = "layout"
            rowHeight = $RowHeight
            content = $Content.Invoke()
            layout = $Layout
            layoutJson = $LayoutJson
            cols = $Columns
            breakpoints = $Breakpoints
            isDraggable = $Draggable.IsPresent
            isResizable = $Resizable.IsPresent
            persist = $Persist.IsPresent
            endpoint = $OnLayoutChanged.Name
        }
    }
}