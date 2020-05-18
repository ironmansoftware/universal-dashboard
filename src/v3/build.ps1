task Stage {
    Push-Location "$PSScriptRoot"
    Copy-Item "$PSScriptRoot\UniversalDashboard.MaterialUI.psm1" "$PSScriptRoot\output\UniversalDashboard.MaterialUI.psm1" -Force
    Get-ChildItem "$PSScriptRoot\Scripts" -File -Recurse -Filter "*.ps1" | ForEach-Object {
        Get-Content $_.FullName -Raw | Out-File "$PSScriptRoot\output\UniversalDashboard.MaterialUI.psm1" -Append -Encoding UTF8
    }
    Copy-Item "$PSScriptRoot\UniversalDashboard.psd1" "$PSScriptRoot\output" 

    Pop-Location
}

task Build {
    Remove-Item "$PSScriptRoot\output" -Recurse -Force -ErrorAction SilentlyContinue
    Push-Location "$PSScriptRoot"
    & {
        $ErrorActionPreference = 'SilentlyContinue'
        npm install
        npm run build
    }
    Pop-Location
}

task . Build, Stage