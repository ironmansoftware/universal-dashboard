function New-UDMuPaper {
    param(
        [Parameter()][string]$Id = (New-Guid).ToString(),
        [Parameter()][ScriptBlock]$Content,
        [Parameter()][switch]$IsEndPoint,
        [Parameter()][string]$Width = '500',
        [Parameter()][string]$Height = '500',
        [Parameter()][Switch]$Square,
        [Parameter()][Hashtable]$Style,
        [Parameter()][int]$Elevation,
        [Parameter()][switch]$AutoRefresh,
        [Parameter()][int]$RefreshInterval = 5
    )

    End 
    {
        if($IsEndPoint){
            $EndPoint = New-UDEndPoint -Endpoint $Content -Id $Id 
        }

        @{
            type = 'mu-paper'
            isPlugin = $true
            assetId = $MUAssetId
            
            id = $Id
            isEndpoint = $IsEndPoint.IsPresent
            content = $Content.Invoke()
            width  = $Width 
            height = $Height
            square = $Square.IsPresent
            style = $Style
            elevation = $Elevation
            refreshInterval = $RefreshInterval
            autoRefresh = $AutoRefresh.IsPresent
        }
    }
}