function New-UDMapIcon {
    param(
        [Parameter(Mandatory)]
        [string]$Url,
        [Parameter()]
        [int]$Height,
        [Parameter()]
        [int]$Width,
        [Parameter()]
        [int]$AnchorX,
        [Parameter()]
        [int]$AnchorY,
        [Parameter()]
        [int]$PopupAnchorX,
        [Parameter()]
        [int]$PopupAnchorY
    )

    $Options = @{
    }

    foreach($boundParameter in $PSCmdlet.MyInvocation.BoundParameters.GetEnumerator()) {
        $Options[[char]::ToLowerInvariant($boundParameter.Key[0]) + $boundParameter.Key.Substring(1)] = $boundParameter.Value
    }

    $Options
}