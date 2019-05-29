param([Switch]$Release)

Import-Module "$PSScriptRoot\TestFramework.psm1" -Force

$BrowserPort = Get-BrowserPort -Release:$Release
$ModulePath = Get-ModulePath -Release:$Release

Import-Module $ModulePath -Force

Get-UDDashboard | Stop-UDDashboard
Describe "Manifest" {

    It "should have correct version" {
        (Get-Module 'UniversalDashboard.Community').Version | Should be "2.4.1"
    }

    It "should have correct exported commands" {
        Get-Command 'Get-UDContentType' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'Get-UDCookie' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDBarChartDataset' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDBarChartOptions' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDButton' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDCard' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDCategoryChartAxis' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDChartDataset' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDChartLayoutOptions' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDChartLegendOptions' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDChartOptions' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDChartTitleOptions' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDChartTooltipOptions' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDCheckbox' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDCollapsible' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDCollapsibleItem' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDCollection' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDCollectionItem' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDColumn' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDDoughnutChartDataset' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDDoughnutChartOptions' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDHeading' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDIcon' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDIFrame' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDImage' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDLayout' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDLinearChartAxis' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDLineChartDataset' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDLineChartOptions' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDLogarithmicChartAxis' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDParagraph' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDPolarChartDataset' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDPolarChartOptions' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDPreloader' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDRadarChartDataset' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDRadio' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDRow' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDSelect' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDSelectGroup' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDSelectOption' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDSpan' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDSwitch' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDTable' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDTextbox' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'Out-UDChartData' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'Out-UDGridData' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'Out-UDMonitorData' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'Out-UDTableData' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'Publish-UDDashboard' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'Remove-UDCookie' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'Set-UDContentType' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'Set-UDCookie' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'Update-UDDashboard' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'Write-UDLog' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'Add-UDElement' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'Clear-UDElement' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'ConvertTo-JsonEx' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'Disable-UDLogging' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'Enable-UDLogging' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'Get-UDDashboard' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'Get-UDElement' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'Get-UDRestApi' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'Get-UDTheme' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDChart' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDCounter' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDDashboard' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDElement' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDEndpoint' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDEndpointSchedule' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDFooter' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDGrid' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDHtml' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDInput' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDInputAction' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDInputField' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDLink' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDMonitor' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDPage' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDTheme' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'Remove-UDElement' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'Show-UDToast' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'Set-UDElement' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'Start-UDDashboard' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'Start-UDRestApi' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'Stop-UDDashboard' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'Stop-UDRestApi' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'Sync-UDElement' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'Invoke-UDRedirect' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'Show-UDModal' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'Hide-UDModal' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'Hide-UDToast' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'Publish-UDFolder' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDTreeView' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDTreeNode' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDFab' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDFabButton' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDImageCarousel' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDImageCarouselItem' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDEndpointInitialization' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDSideNav' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDSideNavItem' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDTabContainer' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDTab' -ErrorAction SilentlyContinue | Should not be $null
        Get-Command 'New-UDGridLayout' -ErrorAction SilentlyContinue | Should not be $null
        
        (Get-Command -Module UniversalDashboard.Community | Measure-Object).Count | should be 122
    }

    It "should require .NET 4.7" -Skip  {

        Mock -CommandName Get-ItemProperty -ParameterFilter {
            $Path -eq 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full\'
        } -MockWith {
            @{ Version = "4.6" }
        }

        $Error.Clear()
        Import-Module $ModulePath -Force -Verbose

        $Error.Count | Should be "Universal Dashboard requires .NET Framework version 4.7 or later when running within Windows PowerShell"
        (Get-Command -Module UniversalDashboard | Measure-Object).Count | should be 0
    }
}