. "$PSScriptRoot\..\TestFramework.ps1"

Describe "Write-UDLog" {

    $tempFile = [IO.Path]::GetTempFileName()
    Enable-UDLogging -FilePath $tempFile -Level Debug

    Write-Host $tempFile

    It "should write info" {
        
        Write-UDLog -Message "Info" -Level Info

        [IO.File]::Exists($tempFile) | should be $true

        (Get-Content -Path $tempFile -Raw).Contains("Info") | should be $true
    }

    It "should write warning" {
        
        Write-UDLog -Message "Warning" -Level Warning

        [IO.File]::Exists($tempFile) | should be $true

        (Get-Content -Path $tempFile -Raw).Contains("Warning") | should be $true
    }

    It "should write error" {
        
        Write-UDLog -Message "Error" -Level Error

        [IO.File]::Exists($tempFile) | should be $true

        (Get-Content -Path $tempFile -Raw).Contains("Error") | should be $true
    }

    It "should write logger name" {
        
        Write-UDLog -Message "Error" -LoggerName "My Logger"

        [IO.File]::Exists($tempFile) | should be $true

        (Get-Content -Path $tempFile -Raw).Contains("My Logger") | should be $true
    }

    Remove-Item $tempFile -ErrorAction SilentlyContinue
}