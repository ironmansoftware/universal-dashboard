function New-UDDynamic
{
    <#
    .SYNOPSIS
    Defines a new dynamic region in a dashboard.
    
    .DESCRIPTION
    Defines a new dynamic region in a dashboard. Dynamic regions are used for loading data when the page is loaded or for loading data dynamically through user interaction or auto-reloading. 
    
    .PARAMETER Id
    The ID of this component.
    
    .PARAMETER ArgumentList
    Arguments to pass to this dynamic endpoint. 
    
    .PARAMETER Content
    The content of this dynamic region.
    
    .PARAMETER AutoRefresh
    Whether this dynamic region should refresh on an interval.
    
    .PARAMETER AutoRefreshInterval
    The amount of seconds between refreshes for this dynamic region.
    
    .PARAMETER LoadingComponent
    A component to display while this dynamic region is loading.
    
    .EXAMPLE
    A simple dynamic region that executes when the user loads the page.

    New-UDDynamic -Content {
        New-UDTypography -Text (Get-Date)
    }

    .EXAMPLE
    A dynamic region that refreshes every 3 seconds

    New-UDDynamic -Content {
        New-UDTypography -Text (Get-Date)
    } -AutoRefresh -AutoRefreshInterval 3

    .EXAMPLE
    A dynamic region that is updated when a button is clicked.

    New-UDDynamic -Content {
        New-UDTypography -Text (Get-Date)
    } -Id 'dynamic'

    New-UDButton -Text 'Refresh' -OnClick {
        Sync-UDElement -Id 'dynamic'
    }
    #>
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
        [ScriptBlock]$LoadingComponent
    )

    $Content.ArgumentList = $ArgumentList
    $Content.Register($Id, $PSCmdlet)

    $LC = $null
    if ($LoadingComponent)
    {
        $LC = New-UDErrorBoundary -Content $LoadingComponent
    }

    @{
        id = $Id 
        autoRefresh = $AutoRefresh.IsPresent
        autoRefreshInterval = $AutoRefreshInterval
        type = "dynamic"
        isPlugin = $true 
        loadingComponent = $LC
    }
}