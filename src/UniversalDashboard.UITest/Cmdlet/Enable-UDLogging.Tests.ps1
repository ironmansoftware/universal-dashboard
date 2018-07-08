param([Switch]$Release)

if (-not $Release) {
    Import-Module "$PSScriptRoot\..\..\UniversalDashboard\bin\debug\UniversalDashboard.Community.psd1"
} else {
    Import-Module "$PSScriptRoot\..\..\output\UniversalDashboard.Community.psd1"
}

Describe "Enable-UDLogging" {

    $tempFile = [IO.Path]::GetTempFileName()

    It "should enable file logging" {
        Enable-UDLogging -FilePath $tempFile -Level Debug
        Write-UDLog -Message "test"

        [IO.File]::Exists($tempFile) | should be $true

        (Get-Content -Path $tempFile).Contains("test") | should be $true
    }

    Remove-Item $tempFile -ErrorAction SilentlyContinue
}