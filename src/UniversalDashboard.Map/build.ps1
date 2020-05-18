task Stage {
    Push-Location "$PSScriptRoot"
    Copy-Item "$PSScriptRoot\UniversalDashboard.Map.psm1" "$PSScriptRoot\output\UniversalDashboard.Map.psm1" -Force
    Get-ChildItem "$PSScriptRoot\Scripts" -File -Recurse -Filter "*.ps1" | ForEach-Object {
        Get-Content $_.FullName -Raw | Out-File "$PSScriptRoot\output\UniversalDashboard.Map.psm1" -Append -Encoding UTF8
    }
    Copy-Item "$PSScriptRoot\UniversalDashboard.Map.psd1" "$PSScriptRoot\output" 

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