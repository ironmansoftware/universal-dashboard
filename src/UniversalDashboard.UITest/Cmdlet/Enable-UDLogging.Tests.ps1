. "$PSScriptRoot\..\TestFramework.ps1"

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