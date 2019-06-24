function New-UDSplitPane {
    param(
        [Parameter()]
        [string]$Id = (New-Guid).ToString(),
        [Parameter(Mandatory)]
        [ScriptBlock]$Content,
        [Parameter()]
        [ValidateSet("vertical", "horizontal")]
        [string]$Direction = "vertical",
        [Parameter()]
        [int]$MinimumSize,
        [Parameter()]
        [int]$DefaultSize
    )

    $Children = & $Content

    if ($Children.Length -ne 2) {
        throw "Split pane requires exactly two components in Content"
    }

    $Options = @{
        content = $Children
        id = $Id
        split = $Direction
        type = "ud-splitpane"
    }

    if ($PSCmdlet.MyInvocation.BoundParameters.ContainsKey("MinimumSize")) {
        $Options["minSize"] = $MinimumSize
    }

    if ($PSCmdlet.MyInvocation.BoundParameters.ContainsKey("DefaultSize")) {
        $Options["defaultSize"] = $DefaultSize
    }

    $Options
}