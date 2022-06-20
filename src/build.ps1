task Stage {
    Push-Location "$PSScriptRoot"
    Copy-Item "$PSScriptRoot\UniversalDashboard.MaterialUI.psm1" "$PSScriptRoot\output\UniversalDashboard.MaterialUI.psm1" -Force
    Get-ChildItem "$PSScriptRoot\Scripts" -File -Recurse -Filter "*.ps1" | ForEach-Object {
        Get-Content $_.FullName -Raw | Out-File "$PSScriptRoot\output\UniversalDashboard.MaterialUI.psm1" -Append -Encoding UTF8
    }
    Copy-Item "$PSScriptRoot\UniversalDashboard.psd1" "$PSScriptRoot\output" 
    Copy-Item "$PSScriptRoot\templates" "$PSScriptRoot\output" -Recurse

    Copy-Item "$PSScriptRoot\fontawesome.brands.txt" "$PSScriptRoot\output\fontawesome.brands.txt" -ErrorAction SilentlyContinue
    Copy-Item "$PSScriptRoot\fontawesome.regular.txt" "$PSScriptRoot\output\fontawesome.regular.txt" -ErrorAction SilentlyContinue
    Copy-Item "$PSScriptRoot\fontawesome.solid.txt"  "$PSScriptRoot\output\fontawesome.solid.txt" -ErrorAction SilentlyContinue

    $Version = (& ([ScriptBlock]::Create((get-content "$PSScriptRoot\UniversalDashboard.psd1" -Raw) ))).ModuleVersion
    $Output = "$PSScriptRoot\output\$Version"
    New-Item $Output -ItemType Directory
    Move-Item "$PSScriptRoot\output\*" -Exclude $Version $Output

    Pop-Location
}

task Build {
    Remove-Item "$PSScriptRoot\output" -Force -Recurse -ErrorAction SilentlyContinue
    Push-Location "$PSScriptRoot"
    & {
        $ErrorActionPreference = 'SilentlyContinue'
        npm install --force --legacy-peer-deps
        npm run build 
    }
    Pop-Location

    Push-Location "$PSScriptRoot\classes"
    dotnet build -c Release 
    Copy-Item "$PSScriptRoot\classes\bin\Release\netstandard2.0\classes.dll" -Destination "$PSScriptRoot\output"
}

task FontAwesomeIconList {
    $ScriptRoot = $PSScriptRoot

    function Out-FontFile {
        param($InputFolder, $OutputFile)

        $sb = [System.Text.StringBuilder]::new()
        Get-ChildItem $InputFolder | ForEach-Object {
            if ($_.Name -ne 'index.js' -and $_.Name -ne 'index.es.js' -and $_.Name -ne 'attribution.js') { 
                $sb.AppendLine($_.Name.Replace('.js', '').Substring(2).Trim()) | Out-Null
            }
        }
    
        $sb.ToString() | Out-File $OutputFile
    }

    function Out-JsFile {
        param($InputFolder, $OutputFile)

        $sb = [System.Text.StringBuilder]::new()
        $sb.AppendLine("export default [") | Out-Null
        Get-ChildItem $InputFolder | ForEach-Object {
            if ($_.Name -ne 'index.js' -and $_.Name -ne 'index.es.js' -and $_.Name -ne 'attribution.js') { 
                $sb.AppendLine("'" + $_.Name.Replace('.js', '').Substring(2).Trim() + "',") | Out-Null
            }
        }
        $sb.AppendLine("]") | Out-Null
        $sb.ToString() | Out-File $OutputFile
    }

    Out-JsFile -InputFolder "$ScriptRoot\node_modules\@fortawesome\free-brands-svg-icons\*.js" -OutputFile "$ScriptRoot\app\fontawesome.brands.js"
    Out-JsFile -InputFolder "$ScriptRoot\node_modules\@fortawesome\free-regular-svg-icons\*.js" -OutputFile "$ScriptRoot\app\fontawesome.regular.js"
    Out-JsFile -InputFolder "$ScriptRoot\node_modules\@fortawesome\free-solid-svg-icons\*.js" -OutputFile "$ScriptRoot\app\fontawesome.solid.js"

    New-Item $ScriptRoot\output -ItemType Directory
    Out-FontFile -InputFolder "$ScriptRoot\node_modules\@fortawesome\free-brands-svg-icons\*.js" -OutputFile "$ScriptRoot\output\fontawesome.brands.txt"
    Out-FontFile -InputFolder "$ScriptRoot\node_modules\@fortawesome\free-regular-svg-icons\*.js" -OutputFile "$ScriptRoot\output\fontawesome.regular.txt"
    Out-FontFile -InputFolder "$ScriptRoot\node_modules\@fortawesome\free-solid-svg-icons\*.js" -OutputFile "$ScriptRoot\output\fontawesome.solid.txt"
}


task . Build, Stage