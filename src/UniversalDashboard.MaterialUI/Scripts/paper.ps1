function New-UDPaper {
    param(
        [Parameter()]
        [string]$Id = (New-Guid).ToString(),
        [Parameter()]
        [ScriptBlock]$Content,
        [Parameter()]
        [ValidateSet("primary", "secondary", "default")]
        [string]$Color = "default",
        [Parameter()]
        [string]$Width = '500',
        [Parameter()]
        [string]$Height = '500',
        [Parameter()]
        [Switch]$Square
    )

    End 
    {
        @{
            type = 'mu-paper'
            isPlugin = $true
            assetId = $MUAssetId
            id = $Id
            content = $Content.Invoke()
            color = $Color 
            width  = $Width 
            height = $Height
            square = $Square
        }
    }
}