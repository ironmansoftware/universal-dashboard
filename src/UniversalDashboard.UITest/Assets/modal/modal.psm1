function New-UDModal {
    param(
        $Header,
        $ButtonText,
        $Content
    )

    New-UDElement -JavaScriptPath "$PSScriptRoot\public\modal.bundle.js" -ModuleName "Modal" -ComponentName "default" -Properties @{
        header = $header
        buttonText = $ButtonText
        content = $Content
    } -Endpoint {
        [PSCustomObject]@{
            ServerTime = [DateTime]::Now
        } | ConvertTo-Json
    }
}