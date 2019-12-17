function Invoke-UDEvent {
    param(
        [Parameter(
            Mandatory = $true,
            ValueFromPipeline = $true,
            Position = 0
        )]
        [String]$Id,
        [Parameter(
            Mandatory = $true,
            Position = 1,
            ParameterSetName = "onClick"
        )]
        [ValidateSet("onClick")]
        [string]$event,
        [Parameter(
            Mandatory = $true,
            Position = 1,
            ParameterSetName = "Scheduled"
        )]
        [switch]$scheduled
    )

    Begin {

    }

    Process {
        if ($PSCmdlet.ParameterSetName -eq "onClick") {
            Invoke-UDJavaScript -javaScript "
                document.getElementById('$Id').click();
            "
        }
        elseif ($PSCmdlet.ParameterSetName -eq "Scheduled") {
            $dashboard = Get-UDDashboard
            $endpoint = $dashboard.DashboardService.EndpointService.ScheduledEndpoints | where-object Name -eq $Id

            if ($endpoint) {
                try {
                    $endpoint.ScriptBlock.Invoke() | Out-Null
                }
                catch {
                    throw ("Invoking endpoint $Id failed with: $($_.Exception.Message)")
                }
                
            }
            else {
                Write-UDLog "Attempting to trigger $Id failed, unable to locate endpoint."
            }
            
        }

    }

    End {

    }
}
