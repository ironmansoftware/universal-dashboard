. (Join-Path $PSScriptRoot "utils.ps1")

$NavBarLinks = @((New-UDLink -Text "Buy Universal Dashboard" -Url "https://ironmansoftware.com/product/powershell-universal-dashboard/" -Icon heart_o),
                 (New-UDLink -Text "Documentation" -Url "https://docs.universaldashboard.io" -Icon book))

$Pages = @()
$Pages += . (Join-Path $PSScriptRoot "pages\home.ps1")
$Pages += . (Join-Path $PSScriptRoot "pages\getting-started.ps1")
$Pages += . (Join-Path $PSScriptRoot "pages\rest-apis.ps1")
$Pages += . (Join-Path $PSScriptRoot "pages\scheduled-endpoints.ps1")
$Pages += . (Join-Path $PSScriptRoot "dashboards\azure.ps1")
$Pages += New-UDComponentPage -Command 'Invoke-UDRedirect'

$Components = @()
@('New-UDButton', 
  'New-UDCard', 
  'New-UDCheckbox', 
  "New-UDChart",
  'New-UDCollapsible',
  'New-UDCollection',
  'New-UDCounter',
  'New-UDElement',
  'New-UDFab',
  'New-UDGrid',
  'New-UDGridLayout',
  'New-UDHeading',
  'New-UDHtml',
  'New-UDIcon',
  'New-UDIFrame',
  'New-UDImage',
  'New-UDImageCarousel',
  'New-UDInput',
  'New-UDLink',
  'New-UDMonitor',
  'New-UDPreloader',
  'New-UDRadio',
  'New-UDRow',
  'New-UDSelect',
  'New-UDSwitch',
  'New-UDTabContainer',
  'New-UDTable',
  'New-UDTextbox',
  'New-UDTreeview') | Sort-Object | ForEach-Object {
    $Page = New-UDComponentPage -Command $_
    $Components += New-UDSideNavItem -Text $_.Split('-')[1].Substring(2) -Url $_
    $Pages += $Page
} 

$Pages += (New-UDComponentPage -Command "Show-UDModal")
$Pages += (New-UDComponentPage -Command "Show-UDToast")

$Navigation = New-UDSideNav -Content {
    New-UDSideNavItem -Text "Home" -Url "Home" -Icon home
    New-UDSideNavItem -SubHeader -Text "Sample Dashboards" -Icon chart_line  -Children {
        New-UDSideNavItem -Text "Azure Resources" -Url "Azure"
    }
    New-UDSideNavItem -SubHeader -Text "About Universal Dashboard" -Icon question -Children {
        New-UDSideNavItem -Text "Getting Started" -Url "Getting-Started"
    }
    New-UDSideNavItem -SubHeader -Text "UI Components" -Icon window_maximize -Children {
        $Components 
    }
    New-UDSideNavItem -SubHeader -Text "Utilities" -Icon wrench -Children {

        New-UDSideNavItem -Text "Modals" -Url "Show-UDModal"
        New-UDSideNavItem -Text 'Scheduled Endpoints' -Url 'Scheduled-Endpoints'
        New-UDSideNavItem -Text "Toasts" -Url "Show-UDToast"
        New-UDSideNavItem -Text 'Redirect' -Url 'Invoke-UDRedirect'
        New-UDSideNavItem -Text 'REST APIs' -Url 'REST-APIs'

    }
} -Fixed

$EndpointInitialization = New-UDEndpointInitialization -Function @("New-UDComponentExample", "New-UDRestApiExample", "New-UDRawExample")

New-UDDashboard -NavbarLinks $NavBarLinks -Title "PowerShell Universal Dashboard" -Pages $Pages -Footer $Footer -Navigation $Navigation -EndpointInitialization $EndpointInitialization
