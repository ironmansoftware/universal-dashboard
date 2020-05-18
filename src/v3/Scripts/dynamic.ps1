function New-UDDynamic
{
    param(
        [Parameter()]
        [string]$Id = [Guid]::NewGuid(),
        [Parameter()]
        [object[]]$ArgumentList,
        [Parameter(Position = 0, Mandatory)]
        [Endpoint]$Content,
        [Parameter()]
        [Switch]$AutoRefresh,
        [Parameter()]
        [int]$AutoRefreshInterval = 10,
        [Parameter()]
        [ScriptBlock]$LoadingComponent = {}
    )

    $Content.Register($Id, $PSCmdlet)

    @{
        id = $Id 
        autoRefresh = $AutoRefresh.IsPresent
        autoRefreshInterval = $AutoRefreshInterval
        type = "dynamic"
        isPlugin = $true 
        loadingComponent = & $LoadingComponent
    }
}