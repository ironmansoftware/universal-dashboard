function New-UDColumn {
    [CmdletBinding(DefaultParameterSetName = 'content')]
    param(
        [Parameter()]
        [String]$Id = (New-Guid),

        [Parameter()]
        [Alias('Size')]
        [ValidateRange(1,12)]
        [int]$SmallSize = 12,
        [Parameter()]
        [ValidateRange(1,12)]
        [int]$LargeSize = 12,
        [Parameter()]
        [ValidateRange(1,12)]
        [int]$MediumSize = 12,

        [Parameter()]
        [ValidateRange(1,12)]
        [int]$SmallOffset = 1,
        [Parameter()]
        [ValidateRange(1,12)]
        [int]$MediumOffset = 1,
        [Parameter()]
        [ValidateRange(1,12)]
        [int]$LargeOffset = 1,

        [Parameter(ParameterSetName = 'content', Position = 1)]
        [ScriptBlock]$Content,

        [Parameter(ParameterSetName = "endpoint")]
        [object]$Endpoint,
        [Parameter(ParameterSetName = "endpoint")]
        [Switch]$AutoRefresh,
        [Parameter(ParameterSetName = "endpoint")]
        [int]$RefreshInterval = 5
    )

    $classes = "col"

    if ($PSBoundParameters.ContainsKey("SmallSize")) {
        $classes += " s$SmallSize"
    }

    if ($PSBoundParameters.ContainsKey("MediumSize")) {
        $classes += " m$MediumSize"
    }

    if ($PSBoundParameters.ContainsKey("LargeSize")) {
        $classes += " l$LargeSize"
    }

    if ($PSBoundParameters.ContainsKey("SmallOffset")) {
        $classes += " offset-s$SmallOffset"
    }

    if ($PSBoundParameters.ContainsKey("MediumOffset")) {
        $classes += " offset-m$MediumOffset"
    }

    if ($PSBoundParameters.ContainsKey("LargeOffset")) {
        $classes += " offset-l$LargeOffset"
    }

    if ($PSCmdlet.ParameterSetName -eq 'content') {
        New-UDElement -Id $Id -Tag 'div' -Attributes @{
            className = $classes
        } -Content $Content
    } else {
        New-UDElement -Id $id -Tag 'div' -Attributes @{
            className = $classes
        } -Endpoint $Endpoint -AutoRefresh:$AutoRefresh -RefreshInterval $RefreshInterval 
    }

    
}