$OutputPath = "$PSScriptRoot\..\output"

task Build {
    Invoke-Build -File "$PSScriptRoot\UniversalDashboard.Charts\build.ps1"
    Invoke-Build -File "$PSScriptRoot\UniversalDashboard.Map\build.ps1"
    Invoke-Build -File "$PSScriptRoot\v2\build.ps1"
    Invoke-Build -File "$PSScriptRoot\v3\build.ps1"
}

task Test {
    Invoke-Build -File "$PSScriptRoot\v2\tests.build.ps1"
    Invoke-Build -File "$PSScriptRoot\v3\tests.build.ps1"
}

task DownloadUniversal {
    Remove-Item $OutputPath -Recurse -Force -ErrorAction SilentlyContinue
    $Version = (Invoke-WebRequest 'https://imsreleases.blob.core.windows.net/universal/production/version.txt' -UseBasicParsing).Content.Trim()
    $TempFile = [IO.Path]::GetTempFileName() + '.zip'
    Invoke-WebRequest "https://imsreleases.blob.core.windows.net/universal/production/$Version/Universal.win-x64.$Version.zip" -OutFile $TempFile
    Expand-Archive $TempFile -DestinationPath $OutputPath
    Get-ChildItem -Recurse $OutputPath | Unblock-File
}

task . Build, DownloadUniversal, Test