function New-UDContainer 
{
    param(
        [Parameter()]
        [string]$Id = ([Guid]::NewGuid()).ToString(),

        [Alias("Content")]
        [Parameter(Mandatory, Position = 0)]
        [ScriptBlock]$Children        
    )

    try {
        $c = & $Children    
    }
    catch {
        $c = New-UDError -Message $_
    }
    
    Process {
        @{
            isPlugin = $true 
            id = $id 
            assetId = $MUAssetId
            type = "mu-container"

            children = $c
        }
    }
}