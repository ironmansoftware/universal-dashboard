param([Switch]$Minimal)

$BuildFolder = $PSScriptRoot

$powerShellGet = Import-Module PowerShellGet  -PassThru -ErrorAction Ignore
if ($powerShellGet.Version -lt ([Version]'1.6.0')) {
    Install-Module PowerShellGet -Scope CurrentUser -Force -AllowClobber
    Import-Module PowerShellGet -Force
}

Set-Location $BuildFolder

$OutputPath = "$BuildFolder\output\$Name"

Remove-Item -Path $OutputPath -Force -Recurse
Remove-Item -Path "$BuildFolder\public" -Force -Recurse

New-Item -Path $OutputPath -ItemType Directory

npm run build

Copy-Item $BuildFolder\public\*.* $OutputPath
Copy-Item $BuildFolder\$Name.psm1 $OutputPath
Copy-Item $BuildFolder\Scripts $OutputPath\Scripts -Recurse -Force

$Version = "1.0.0"

$manifestParameters = @{
    Path              = "$OutputPath\$Name.psd1"
    Author            = ""
    CompanyName       = ""
    Copyright         = ""
    RootModule        = "$Name.psm1"
    Description       = "$Description"
    ModuleVersion     = $version
    Tags              = @("ud-component")
    ReleaseNotes      = ""
    FunctionsToExport = @(
        "New-UDComponent"
    )
    RequiredModules   = @()
}

New-ModuleManifest @manifestParameters

if ($prerelease -ne $null) {
    Update-ModuleManifest -Path "$OutputPath\$Name.psd1" -Prerelease $prerelease
}

