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
            Position = 1
        )]
        [ValidateSet("onClick")]
        [string]$event
    )

    Begin {

    }

    Process {
        Invoke-UDJavaScript -javaScript "
            document.getElementById('$Id').click();
        "
    }

    End {

    }
}