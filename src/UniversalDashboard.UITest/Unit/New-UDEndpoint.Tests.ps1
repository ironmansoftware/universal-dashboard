param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
Import-Module $ModulePath -Force

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