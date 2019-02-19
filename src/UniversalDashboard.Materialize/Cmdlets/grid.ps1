function New-UDGrid {
    param(
        [Parameter()]
        [string]$Id = (New-Guid).ToString(),
        [Parameter(Mandatory)]
        [object]$Endpoint,
        [Parameter()]
        [string]$Title,
        [Parameter(Mandatory)]
        [string[]]$Headers,
        [Parameter(Mandatory)]
        [string[]]$Properties,
        [Parameter()]
        [string]$DefaultSortColumn,
        [Parameter()]
        [UniversalDashboard.Models.DashboardColor]$BackgroundColor,
        [Parameter()]
        [UniversalDashboard.Models.DashboardColor]$FontColor,
        [Parameter()]
        [object[]]$Links,
        [Parameter()]
        [Switch]$ServerSidePaging,
        [Parameter()]
        [string]$DateTimeFormat = 'lll',
        [Parameter()]
        [int]$PageSize = 10,
        [Parameter()]
        [Switch]$NoPaging,
        [Parameter()]
        $FilterText = 'Filter'
    )

    if ($NoPaging) {
        $PageSize = [int]::MaxValue
    }

    if (-not ($Endpoint -is [UniversalDashboard.Models.Endpoint])) {
        $Endpoint = New-UDEndpoint -Endpoint $Endpoint -Id $Id
    }

    @{
        type = 'grid'
        isPlugin = $true
        assetId = $Script:AssetId
        id = $id 
        title = $Title
        headers = $Headers
        properties = $Properties
        defaultSortColumn = $DefaultSortColumn
        backgroundColor = $BackgroundColor.HtmlColor
        fontColor = $FontColor.HtmlColor
        links = $Links 
        serverSidePaging = $ServerSidePaging
        dateTimeFormat = $DateTimeFormat
        pageSize = $PageSize 
        filterText = $FilterText
    }
}