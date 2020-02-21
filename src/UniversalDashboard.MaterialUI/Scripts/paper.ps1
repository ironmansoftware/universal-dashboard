function New-UDPaper {
    param(
        [Parameter()][string]$Id = ([Guid]::NewGuid()).ToString(),
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
            width  = $Width 
            content = $Content.Invoke()
            height = $Height
            square = $Square.IsPresent
            style = $Style
            elevation = $Elevation
            refreshInterval = $RefreshInterval
            autoRefresh = $AutoRefresh.IsPresent
        }
    }
}