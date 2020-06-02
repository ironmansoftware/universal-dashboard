function New-UDError {
    param(
        [Parameter(Mandatory)]
        [string]$Message,
        [Parameter()]
        [string]$Title
    )

    @{
        type = "error"
        isPlugin = $true 
        assetId = $AssetId 

        errorRecords = @(@{message= $Message})
        title = $Title
    }
}