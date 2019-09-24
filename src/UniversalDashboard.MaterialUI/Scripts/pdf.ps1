function New-UDPdf {
    param(
        [Parameter()]
        [string]$Id = ([Guid]::NewGuid()).ToString(),

        [Parameter()]
        [string]$FilePath

    )

    End 
    {
        @{
            type = 'ud-pdf'
            isPlugin = $true
            assetId = $MUAssetId
            id = $Id
            filePath = $FilePath
        }
    }
}