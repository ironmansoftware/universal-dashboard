function  Debug-PSUDashboard {
    <#
    .SYNOPSIS
    Provides a utility function for debugging scripts running PowerShell Universal Dashboard.
    
    .DESCRIPTION
    Provides a utility function for debugging scripts running PowerShell Universal Dashboard. This cmdlet integrates with the VS Code PowerShell Universal extension to automatically connect the debugger to endpoints running in UD. 
    
    .EXAMPLE
    Creates an element that invokes the Debug-PSUDashboard cmdlet.

    New-UDElement -Tag div -Endpoint {
        Debug-PSUDashboard
    }
    #>
    [CmdletBinding()]
    param()

    $DebugPreference = 'continue'

    $Runspace = ([runspace]::DefaultRunspace).id

    Show-UDModal -Header {
        New-UDTypography -Text 'Debug Dashboard' -Variant h4
    } -Content {
        Write-Debug "IN DEBUG MODE: Enter-PSHostProcess -Id $PID then Debug-Runspace -Id $Runspace"
        New-UDTypography -Text "You can run the following PowerShell commands in any PowerShell host to debug this dashboard."
        New-UDElement -Tag 'pre' -Content {
            "Enter-PSHostProcess -Id $PID`r`nDebug-Runspace -Id $Runspace"
        }
    } -Footer {
        New-UDLink -Children {
            New-UDButton -Text 'Debug with VS Code' 
        } -Url "vscode://ironmansoftware.powershell-universal/debug?PID=$PID&RS=$Runspace" 
        New-UDLink -Children {
            New-UDButton -Text 'Debug with VS Code Insiders' 
        } -Url "vscode-insiders://ironmansoftware.powershell-universal/debug?PID=$PID&RS=$Runspace" 
        New-UDButton -Text 'Close' -OnClick { Hide-UDModal }
    }

    Wait-Debugger 
}