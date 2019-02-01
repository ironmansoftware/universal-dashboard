Import-Module F:\universal-dashboard\src\output\UniversalDashboard.Community.psd1

Get-UDDashboard | Stop-UDDashboard

Import-Module "$PSScriptRoot\control-laboratory.psm1" -Force

$EndpointInit = New-UDEndpointInitialization -Module @("control-laboratory")

$Navigation = New-UDSideNav -Endpoint {
    New-UDSideNavItem -Text "Standard" -Icon plus -Children {
        New-UDSideNavItem -Text "Button" -OnClick { Show-ControlProperties -ControlName "New-UDButton" } -Icon arrow_right
        New-UDSideNavItem -Text "Card" -OnClick { Show-ControlProperties -ControlName "New-UDCard" } -Icon arrow_right
        New-UDSideNavItem -Text "Checkbox" -OnClick { Show-ControlProperties -ControlName "New-UDCheckbox" } -Icon arrow_right
        New-UDSideNavItem -Text "Button" -OnClick { Show-ControlProperties -ControlName "New-UDButton" } -Icon arrow_right
        New-UDSideNavItem -Text "Button" -OnClick { Show-ControlProperties -ControlName "New-UDButton" } -Icon arrow_right
    }
    New-UDSideNavItem -Divider
    New-UDSideNavItem -Text 'Import Control Library' -OnClick {
        Show-UDMOdal -Content {
            New-UDInput -Title "Load Control Library"  -SubmitText "Import" -Endpoint {
                param(
                    $controlLibrary
                )

                $Cache:ControlLibrary = Import-Module $controlLibrary -Force -PassThru
                New-ControlLibrary -PSModuleInfo $Cache:ControlLibrary
            } -Content {
                New-UDInputField -Name "controlLibrary" -Type textbox
            }
        }
    } -Icon plus
} -Fixed

$Dashboard = New-UDDashboard -Title "Control Labratory" -Content {
    New-UDElement -Tag "div" -Content {
        New-UDElement -Tag "div" -Id "Container" -Content {}
    } -Attributes @{
        className = "valign-wrapper center-align"
        style = @{
            height = "100ch"
            width = "100%"
            backgroundColor = "#cccccc"
        }
    }

    New-UDElement -Tag "div" -Endpoint {
        if ($null -ne $Cache:ControlLibrary) {
            New-ControlLibrary -PSModuleInfo $Cache:ControlLibrary
        }
    }
} -EndpointInitialization $EndpointInit -Navigation $Navigation

Start-UDDashboard -Dashboard $Dashboard -Port 1234