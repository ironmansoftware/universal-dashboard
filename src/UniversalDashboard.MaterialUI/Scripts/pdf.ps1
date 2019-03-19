function New-UDPdf {
    param(
        [Parameter()]
        [string]$Id = (New-Guid).ToString(),

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