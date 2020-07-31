function New-UDDashboard
{
    param(
        [Parameter()]
        [string]$Title = "PowerShell Universal Dashboard",
        [Parameter(ParameterSetName = "Content", Mandatory)]
        [ScriptBlock]$Content,
        [Parameter(ParameterSetName = "Pages", Mandatory)]
        [Hashtable[]]$Pages = @(),
        [Parameter()]
        [Hashtable[]]$NavbarLinks,
        [Parameter()]
        [Element]$NavBarLogo,
        [Parameter()]
        [DashboardColor]$NavBarColor,
        [Parameter()]
        [DashboardColor]$NavBarFontColor,
        [Parameter()]
        [Hashtable]$Footer,
        [Parameter()]
        [Hashtable]$Navigation,
        [Parameter()]
        [Hashtable]$Theme
    )    

    if (-not $Theme)
    {
        $Theme = Get-UDTheme -Name Default
    }

    if ($PSCmdlet.ParameterSetName -eq 'Content')
    {
        $Pages += New-UDPage -Name 'Home' -Content $Content
    }

    $Cache:Pages = $Pages

    foreach($page in $Pages) {
        New-UDEndpoint -Id "$($page.Name)" -Endpoint {
            $page
        } | Out-Null
    }

    @{
        title = $Title 
        pages = $Pages
        navbarLinks = $NavbarLinks
        footer = $Footer
        navigation = $Navigation
        theme = ConvertTo-UDThemeCss -Theme $Theme
        navBarLogo = $NavBarLogo
        navBarColor = $NavBarColor.HtmlColor
        navBarFontColor = $NavBarFontColor.HtmlColor
    }
}
