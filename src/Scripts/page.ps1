function New-UDPage {
    <#
    .SYNOPSIS
    Defines a new page.
    
    .DESCRIPTION
    Defines a new page. Dashboards can contain multiple pages that each contain different components.
    
    .PARAMETER Name
    The name of the page. 
    
    .PARAMETER Content
    The content of the page.
    
    .PARAMETER Url
    The URL for the page.
    
    .PARAMETER DefaultHomePage
    Whether this page is the default home page. Only one page can be the default home page.
    
    .PARAMETER Title
    The title of the page.
    
    .PARAMETER Blank
    Whether to define a blank page. Blank pages won't have a navigation bar.
    
    .PARAMETER Id
    The ID of this component.
    
    .PARAMETER OnLoading
    A component to return while this page is loading.
    
    .PARAMETER Role
    The role of the user that is allowed to access this page.
    
    .PARAMETER NavigationLayout
    How the navigation is layed out on the page.
    
    .PARAMETER Navigation
    Custom navigation to show for this page. You can use New-UDList and New-UDListItem to define custom navigation links.
    
    .PARAMETER Logo
    The logo to display on this page.
    
    .PARAMETER LoadNavigation
    An endpoint that is called when loading the navigation for the page.

    .PARAMETER HeaderPosition
    Position of the header within the dashboard.

    .PARAMETER HeaderContent 
    Content of the header.
    
    .EXAMPLE
    Creates a basic page.

    New-UDPage -Name 'Test' -Content {
        New-UDTypography -Text 'Page'
    }
    #>
    [CmdletBinding(DefaultParameterSetName = "Simple")]
    param(
        [Parameter(Position = 0, Mandatory)]
        [string]$Name,
        [Parameter(Position = 2, Mandatory)]
        [Alias("Endpoint")]
        [Endpoint]$Content,
        [Parameter(Position = 0)]
        [string]$Url,
        [Parameter(Position = 3)]
        [Switch]$DefaultHomePage,
        [Parameter(Position = 4)]
        [string]$Title,
        [Parameter(ParameterSetName = 'Advanced')]
        [Switch]$Blank,
        [Parameter()]
        [string]$Id = [Guid]::NewGuid(),
        [Parameter()]
        [ScriptBlock]$OnLoading,
        [Parameter()]
        [string[]]$Role,
        [Parameter(ParameterSetName = 'Simple')]
        [Parameter(ParameterSetName = 'DynamicNav')]
        [ValidateSet("Temporary", "Permanent")]
        [string]$NavigationLayout = 'Temporary',
        [Parameter(ParameterSetName = 'Simple')]
        [Hashtable[]]$Navigation,
        [Parameter(ParameterSetName = "Simple")]
        [Parameter(ParameterSetName = 'DynamicNav')]
        [string]$Logo,
        [Parameter(ParameterSetName = 'DynamicNav')]
        [Endpoint]$LoadNavigation,
        [ValidateSet('absolute', 'fixed', 'relative', 'static', 'sticky')]
        [Parameter()]
        [string]$HeaderPosition = 'static',
        [Parameter()]
        [UniversalDashboard.Models.DashboardColor]$HeaderColor,
        [Parameter()]
        [UniversalDashboard.Models.DashboardColor]$HeaderBackgroundColor,
        [Parameter(ParameterSetName = "Simple")]
        [Parameter(ParameterSetName = 'DynamicNav')]
        [Endpoint]$HeaderContent,
        [Parameter()]
        [Switch]$HideUserName,
        [Parameter()]
        [Switch]$HideNavigation,
        [Parameter()]
        [Hashtable]$Icon
    )

    $Content.Register($Id, $Role, $PSCmdlet)

    if (-not [string]::IsNullOrEmpty($Url) -and -not $Url.StartsWith("/")) {
        $Url = "/" + $Url
    }

    if ([string]::IsNullOrEmpty($Url) -and $null -ne $Name) {
        $Url = "/" + $Name.Replace(' ', '-');
    }

    if ($OnLoading) {
        $LoadingContent = New-UDErrorBoundary -Content $OnLoading
    }

    if ($LoadNavigation) {
        $LoadNavigation.Register('nav' + $Id, $Role, $PSCmdlet)
    }

    if ($HeaderContent) {
        $HeaderContent.Register('headerContent' + $Id, $Role, $PSCmdlet)
    }

    
    @{
        name                  = $Name
        url                   = $Url
        id                    = $Id
        defaultHomePage       = $DefaultHomePage.IsPresent
        title                 = $Title
        blank                 = $Blank.IsPresent
        loading               = $LoadingContent
        content               = $Content 
        navLayout             = $NavigationLayout.ToLower()
        navigation            = $navigation
        role                  = $Role
        logo                  = $Logo
        loadNavigation        = $LoadNavigation
        headerPosition        = $HeaderPosition.ToLower()
        headerColor           = $HeaderColor.HtmlColor
        headerBackgroundColor = $HeaderBackgroundColor.HtmlColor
        headerContent         = $HeaderContent
        hideUserName          = $HideUserName.IsPresent
        icon                  = $Icon
        hideNavigation        = $HideNavigation.IsPresent
    }
}