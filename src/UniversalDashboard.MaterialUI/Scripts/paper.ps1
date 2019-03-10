function New-UDMuPaper {
    param(
        [Parameter()][string]$Id = (New-Guid).ToString(),
        [Parameter()][ScriptBlock]$Content,
        [Parameter()][string]$Width = '500',
        [Parameter()][string]$Height = '500',
        [Parameter()][Switch]$Square,
        [Parameter()][Hashtable]$Style,
        [Parameter()][int]$Elevation
    )

    End 
    {
        @{
            type = 'mu-paper'
            isPlugin = $true
            assetId = $MUAssetId
            id = $Id
            content = $Content.Invoke()
            width  = $Width 
            height = $Height
            square = $Square
            style = $Style
            elevation = $Elevation
        }
    }
}