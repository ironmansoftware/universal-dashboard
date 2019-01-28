if ($Env:APPVEYOR) {
    $BuildFolder = $env:APPVEYOR_BUILD_FOLDER
} else {
    $BuildFolder = $PSScriptRoot
}


$OutputPath = "$BuildFolder\output\UniversalDashboard.Charts"

$powerShellGet = Import-Module PowerShellGet  -PassThru -ErrorAction Ignore

if ($powerShellGet.Version -lt ([Version]'1.6.0')) {
	Install-Module PowerShellGet -Scope CurrentUser -Force
	Import-Module PowerShellGet -Force
}

$nugetPath = "c:\nuget"

Write-Verbose "Create C:\nuget folder"
mkdir $nugetPath 

Write-Verbose "Download Nuget.exe to C:\nuget"
Invoke-WebRequest -Uri "http://go.microsoft.com/fwlink/?LinkID=690216&clcid=0x409" -OutFile $nugetPath\Nuget.exe

Write-Verbose "Add C:\nuget as %PATH%"
$pathenv= [System.Environment]::GetEnvironmentVariable("path")
$pathenv=$pathenv+";"+$nugetPath
[System.Environment]::SetEnvironmentVariable("path", $pathenv)

Write-Verbose "Create NuGet package provider"
Install-PackageProvider -Name NuGet -Scope CurrentUser -Force

Write-Verbose "Publishing module"
Publish-Module -Path $OutputPath -NuGetApiKey $ENV:NuGetApiKey