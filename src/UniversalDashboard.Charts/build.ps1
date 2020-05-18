task Build {
	Remove-Item -Path "$PSScriptRoot\output" -Force -ErrorAction SilentlyContinue -Recurse
	New-Item -Path "$PSScriptRoot\output" -ItemType Directory

	Push-Location "$PSScriptRoot\classes"

	dotnet build -c Release 
	Copy-Item "$PSScriptRoot\classes\bin\Release\netstandard2.0\classes.dll" -Destination "$PSScriptRoot\output"

	Pop-Location

	Push-Location "$PSScriptRoot"
    & {
        $ErrorActionPreference = 'SilentlyContinue'
        npm install
        npm run build
	}
	Pop-Location

	Copy-Item "$PSScriptRoot\UniversalDashboard.Charts.psm1" "$PSScriptRoot\output"
	Copy-Item "$PSScriptRoot\UniversalDashboard.Charts.psd1" "$PSScriptRoot\output"
}

task . Build
