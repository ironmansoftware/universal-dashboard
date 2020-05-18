Import-Module Selenium

$OutputPath = "$PSScriptRoot\..\..\output"
$Address = 'http://localhost:5000'

task Clean {
   # Remove-Item $OutputPath -Force -Recurse
    Remove-Item "$Env:ProgramData\UniversalAutomation" -Force -Recurse -ErrorAction SilentlyContinue
    Remove-Item "$Env:ProgramData\PowerShellUniversal" -Force -Recurse -ErrorAction SilentlyContinue
}

task DownloadUniversal {
    $Version = (Invoke-WebRequest 'https://imsreleases.blob.core.windows.net/universal/production/version.txt' -UseBasicParsing).Content.Trim()
    $TempFile = [IO.Path]::GetTempFileName() + '.zip'
    Invoke-WebRequest "https://imsreleases.blob.core.windows.net/universal/production/$Version/Universal.$Version.zip" -OutFile $TempFile
    Expand-Archive $TempFile -DestinationPath $OutputPath
}

task InitTests {
    Import-Module "$OutputPath\Universal.psm1"
    Import-Module "$OutputPath\Universal.Cmdlets.dll"

    Start-Process "$OutputPath\Universal.Server.exe"

    while($true) {
        try {
            Invoke-WebRequest "$Address/api/v1/alive" | Out-null
            break
        }
        catch {}
    }

    try 
    {

        Invoke-WebRequest "$Address/api/v1/signin" -Method Post -Body (@{ username = 'admin'; password = '1234' } | ConvertTo-Json) -SessionVariable 'PUWS' -ContentType 'application/json' | out-null
        $AppToken = (Invoke-WebRequest "$Address/api/v1/apptoken/grant" -WebSession $PUWS).Content | ConvertFrom-Json
    
        Connect-UAServer -ComputerName $Address -AppToken $AppToken.Token
        $Framework = Add-UDDashboardFramework -Name 'Test' -Version 'Test' -ModulePath "$PSScriptRoot\output\UniversalDashboard.Materialize.psm1" -Path "$PSScriptRoot\output"
        Add-UDDashboard -Name 'Test' -FilePath "$PSScriptRoot\Tests\dashboard.ps1" -Framework $Framework -BaseUrl '/test' 
    }
    catch 
    {
        Get-Process "Universal.Server" | Stop-Process
        throw $_
    }
}

task Run {
    $Driver = Start-SeFirefox 
    $Global:Driver = $Driver

    function Get-TestData {
        Invoke-RestMethod "$Address/api/internal/component/element/testdata" -Headers @{dashboardid = 1}
    }

    $OutputPath = "$PSScriptRoot\test-results" 
    Remove-Item $OutputPath -Recurse -ErrorAction SilentlyContinue -Force
    New-Item -Path $OutputPath -ItemType Directory

    Push-Location $PSScriptRoot

    $Completed = @("button.tests.ps1", "card.tests.ps1", "checkbox.tests.ps1", 'collapsible.tests.ps1', 'collection.tests.ps1', "column.tests.ps1", 
    "fab.tests.ps1")

    $Completed | ForEach-Object {
        . (Join-Path "$PSScriptRoot\Tests" $_)
    }

 #   Get-ChildItem "$PSScriptRoot\Tests" -Filter "*.tests.ps1" | ForEach-Object {
  #      . $_.FullName
   # }

    Pop-Location
}

task Cleanup {
    Stop-SeDriver -Target $Global:Driver
    Get-Process "Universal.Server" | Stop-Process
}

task . Clean, InitTests, Run, Cleanup