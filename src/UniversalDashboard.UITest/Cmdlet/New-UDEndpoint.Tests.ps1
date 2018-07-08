param([Switch]$Release)

if (-not $Release) {
    Import-Module "$PSScriptRoot\..\..\UniversalDashboard\bin\debug\UniversalDashboard.Community.psd1"
} else {
    Import-Module "$PSScriptRoot\..\..\output\UniversalDashboard.Community.psd1"
}

Describe "New-UDEndpoint" {
    It "Should support all HTTP methods" {
        (New-UDEndpoint -Method GET -Url "url" -Endpoint {}).Method | Should be "Get"
        (New-UDEndpoint -Method Post -Url "url" -Endpoint {}).Method | Should be "Post"
        (New-UDEndpoint -Method Put -Url "url" -Endpoint {}).Method | Should be "Put"
        (New-UDEndpoint -Method Delete -Url "url" -Endpoint {}).Method | Should be "Delete"
    }

    It "should set schedule" {
        $Schedule = New-UDEndpointSchedule -Every 10 -Minute 
        (New-UDEndpoint -Schedule $Schedule -Endpoint {}).schedule | should not be $null
    }
}