function New-UDGrid {
    param(
        [Parameter()]
        [string]$Id = [Guid]::NewGuid().ToString(),
        [Alias("Size")]
        [ValidateRange(1, 12)]
        [Parameter(ParameterSetName = "Item")]
        [int]$ExtraSmallSize,
        [Parameter(ParameterSetName = "Item")]
        [ValidateRange(1, 12)]
        [int]$SmallSize,
        [Parameter(ParameterSetName = "Item")]
        [ValidateRange(1, 12)]
        [int]$MediumSize,
        [Parameter(ParameterSetName = "Item")]
        [ValidateRange(1, 12)]
        [int]$LargeSize,
        [Parameter(ParameterSetName = "Item")]
        [ValidateRange(1, 12)]
        [int]$ExtraLargeSize,
        [Parameter(ParameterSetName = "Container")]
        [Switch]$Container,
        [Parameter(ParameterSetName = "Container")]
        [int]$Spacing,
        [Parameter(ParameterSetName = "Item")]
        [Switch]$Item,
        [Parameter()]
        [ScriptBlock]$Content
    )

    End {
        @{
            id = $Id 
            isPlugin = $true 
            type = "mu-grid"
            assetId = $MUAssetId

            xs = $ExtraSmallSize
            sm = $SmallSize
            md = $MediumSize
            lg = $LargeSize
            xl = $ExtraLargeSize
            spacing = $Spacing

            container = $Container.IsPresent
            item = $Item.IsPresent

            content = $Content.Invoke()
        }
    }
}