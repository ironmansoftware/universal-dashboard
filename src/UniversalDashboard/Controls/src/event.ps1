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
        [string]$event
    )

    Begin {

    }

    Process {
        if ($PSCmdlet.ParameterSetName -eq "onClick") {
            Invoke-UDJavaScript -javaScript "
                document.getElementById('$Id').click();
            "
        }
    }

    End {

    }
}
