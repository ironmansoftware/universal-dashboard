Describe "web.config" {
    It "has correct framework version" {
        $webconfig = Get-Content (Join-Path $PSScriptRoot "..\..\web.config") -Raw
        $webconfig.Contains("net472") | Should be $true
    }
}