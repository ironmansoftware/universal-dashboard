function New-UDComponentModule {
    param(
        [Parameter(Mandatory)]
        $Name,
        [Parameter()]
        $Description,
        [Parameter(Mandatory)]
        $Path
    )

    Process {
        New-Item -Path $Path -ItemType Directory -ErrorAction SilentlyContinue

        @{
            Name = $Name
            Description = $Description
            Dependencies = @{}
            Cmdlets = @()
        } | ConvertTo-Json | Out-File (Join-Path $Path 'UDManifest.json')

        $PowerShell = Join-Path $Path "PowerShell"
        New-Item -Path $PowerShell -ItemType Directory | Out-Null
        $JavaScript = Join-Path $Path "JavaScript"
        New-Item -Path $JavaScript -ItemType Directory | Out-Null

        $Templates = Join-Path $PSScriptRoot "templates"
        Copy-Item (Join-Path $Templates "component.jsx") $JavaScript 
        Copy-Item (Join-Path $Templates "index.js") $JavaScript
        Copy-Item (Join-Path $Templates "component.ps1") $PowerShell
        Copy-Item (Join-Path $Templates ".gitignore") $Path
        Copy-Item (Join-Path $Templates "module.psm1") (Join-Path $Path "$Name.psm1")  
        
        $DebugModule = Get-Content (Join-Path $Templates "module.debug.psm1") -Raw
        $DebugModule = $DebugModule.Replace('$Name', $Name)
        $DebugModule | Out-File (Join-Path $Path "$Name.debug.psm1") -Encoding UTF8
    }
}

function Import-UDManifest {
    param(
        [Parameter()]
        $Path
    )
    

    End {
        if ($Path)
        {
            $Manifest = Join-Path $Path "UDManifest.json"
        }
        else 
        {
            $Manifest = Join-Path (Get-Location).Path "UDManifest.json"
        }

        if (-not (Test-Path $Manifest))
        {
            throw "Directory does not contain UDManifest.json"
        }

        $Root = Split-Path $Manifest -Parent

        Get-Content $Manifest -Raw | ConvertFrom-Json
    }
}
function Invoke-UDComponentBuild {
    param(
        [Parameter()]
        $Path,
        [Parameter()]
        $OutputPath 
    )

    if ($Path)
    {
        $ManifestPath = Join-Path $Path "UDManifest.json"
    }
    else 
    {
        $ManifestPath = Join-Path (Get-Location).Path "UDManifest.json"
    }

    $Manifest = Import-UDManifest -Path $Path
    $Directory = Split-Path $ManifestPath -Parent
    $UdBuildFolder = Join-Path $Directory '.udbuild'

    if (-not (Test-Path $UdBuildFolder))
    {
        New-Item -Path $UdBuildFolder -ItemType Directory | Out-Null
    }

    $templatesFolder = Join-Path $PSScriptRoot "templates"
    $PackageJson = Get-Content (Join-Path $templatesFolder "package.json") -Encoding UTF8 -Raw | ConvertFrom-Json

    $PackageJson.name = $Manifest.Name.ToLower()
    $PackageJson.dependencies = $Manifest.Dependencies

    $PackageJson | ConvertTo-Json | Out-File (Join-Path $UdBuildFolder "package.json") -Encoding UTF8 -Force

    $WebpackConfig = Get-Content (Join-Path $templatesFolder "webpack.config.js") -Raw
    $WebpackConfig = $WebpackConfig.Replace('$Name', $manifest.Name.ToLower().Replace('.', ''))
    $WebpackConfig | Out-File (Join-Path $UdBuildFolder "webpack.config.js") -Encoding UTF8 -Force
    
    Copy-Item (Join-Path $templatesFolder '.babelrc') $UdBuildFolder -Force 
    Copy-Item (Join-Path $Directory 'JavaScript') $UdBuildFolder -Container -Force -Recurse

    $npm = Get-Command -Name 'npm'
    if ($null -eq $npm)
    {
        throw "NPM is required."
    }

    Push-Location $UdBuildFolder

    & npm install
    & npm run build

    Pop-Location

    Remove-Item $OutputPath -Force -Recurse -ErrorAction SilentlyContinue
    New-Item $OutputPath -ItemType Directory

    Copy-Item (Join-Path  $UdBuildFolder 'public/*.*') $OutputPath
    Copy-Item (Join-Path $Directory 'PowerShell') $OutputPath -Container -Force -Recurse
    Copy-Item (Join-Path $Directory '*.psm1') $OutputPath -Container -Force -Recurse
}

function Start-UDComponentTestServer {
    param(
        [Parameter()]
        $Path
    )

    if ($Path)
    {
        $ManifestPath = Join-Path $Path "UDManifest.json"
    }
    else 
    {
        $ManifestPath = Join-Path (Get-Location).Path "UDManifest.json"
    }

    $Manifest = Import-UDManifest -Path $Path
    $Directory = Split-Path $ManifestPath -Parent
    $UdBuildFolder = Join-Path $Directory '.udbuild'

    if (-not (Test-Path $UdBuildFolder))
    {
        New-Item -Path $UdBuildFolder -ItemType Directory | Out-Null
    }

    $templatesFolder = Join-Path $PSScriptRoot "templates"
    $PackageJson = Get-Content (Join-Path $templatesFolder "package.json") -Encoding UTF8 -Raw | ConvertFrom-Json

    $PackageJson.name = $Manifest.Name.ToLower()
    $PackageJson.dependencies = $Manifest.Dependencies

    $PackageJson | ConvertTo-Json | Out-File (Join-Path $UdBuildFolder "package.json") -Encoding UTF8 -Force

    $WebpackConfig = Get-Content (Join-Path $templatesFolder "webpack.config.js") -Raw
    $WebpackConfig = $WebpackConfig.Replace('$Name', $manifest.Name.ToLower().Replace('.', ''))
    $WebpackConfig | Out-File (Join-Path $UdBuildFolder "webpack.config.js") -Encoding UTF8 -Force
    
    Copy-Item (Join-Path $templatesFolder '.babelrc') $UdBuildFolder -Force 
    Copy-Item (Join-Path $Directory 'JavaScript') $UdBuildFolder -Container -Force -Recurse

    $npm = Get-Command -Name 'npm'
    if ($null -eq $npm)
    {
        throw "NPM is required."
    }

    Push-Location $UdBuildFolder

    & npm install

    Start-Process npm -ArgumentList ("run", "dev")

    Pop-Location

    Import-Module (Get-ChildItem (Join-Path $Path "*.debug.psm1")) -Force
    Start-UDDashboard -Dashboard (New-UDDashboard -Pages @(
        
    ))
}
