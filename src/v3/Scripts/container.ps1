function New-UDContainer 
{
    param(
        [Parameter()]
        [string]$Id = ([Guid]::NewGuid()).ToString(),

        [Alias("Content")]
        [Parameter(Mandatory, Position = 0)]
        [ScriptBlock]$Children        
    )

    Process {
        @{
            isPlugin = $true 
            id = $id 
            assetId = $MUAssetId
            type = "mu-container"

            children = & $Children
        }
    }
}