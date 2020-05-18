function New-UDSplitPane {
    param(
        [Parameter()]
        [string]$Id = ([Guid]::NewGuid()).ToString(),
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
        Write-Error "Split pane requires exactly two components in Content"
        return
    }

    $Options = @{
        content = $Children
        id = $Id
        split = $Direction.ToLower()
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