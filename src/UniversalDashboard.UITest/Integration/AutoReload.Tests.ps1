param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

Describe "Auto reload" {
    Context "Changed script" {
        $tempFile = [System.IO.Path]::GetTempFileName() + ".ps1"

        {
            Import-Module $ModulePath
            
            Invoke-RestMethod -Method Post -Uri "http://localhost:10001/api/internal/component/terminal" -Body ('$dashboardservice.setDashboard((
                New-UDDashboard -Title "Test" -Content {
                New-UDCard -Title "Test" -Text "My text" -Id "Card" -Links @(
                    New-UDLink -Text "My Link" -Url "http://www.google.com"
                )
            }))') -SessionVariable ss -ContentType 'text/plain'


            Invoke-RestMethod -Method Post -Uri "http://localhost:10001/api/internal/component/terminal" -Body ('$dashboardservice.Dashboard.AutoReload = $true') -SessionVariable ss -ContentType 'text/plain'

        }.ToString().Replace('$ModulePath', "'$ModulePath'") | Out-File $tempFile 

        . $TempFile

        $Cache:Driver.navigate().refresh()

        It "auto reloads" {
            {
                Import-Module $ModulePath

                Invoke-RestMethod -Method Post -Uri "http://localhost:10001/api/internal/component/terminal" -Body ('$dashboardservice.setDashboard((
                    New-UDDashboard -Title "Test 123" -Content {
                    New-UDCard -Title "Test" -Text "THIS IS AUTORELOADED" -Id "Card" -Links @(
                        New-UDLink -Text "My Link" -Url "http://www.google.com"
                    )
                }))') -SessionVariable ss -ContentType 'text/plain'
        
                Invoke-RestMethod -Method Post -Uri "http://localhost:10001/api/internal/component/terminal" -Body ('$dashboardservice.Dashboard.AutoReload = $true') -SessionVariable ss -ContentType 'text/plain'

            }.ToString().Replace('$ModulePath', "'$ModulePath'") | Out-File $tempFile -Force

            $Cache:Driver.navigate().refresh()

            (Find-SeElement -Driver $Cache:Driver -Id "Card").Text | Should BeLike "*THIS IS AUTORELOADED*"

        }

        Remove-Item $TempFile
        Get-UDRestApi | Stop-UDRestApi
    }

    Context "Changed REST API script" {
        $tempFile = [System.IO.Path]::GetTempFileName() + ".ps1"

        {
            Import-Module $ModulePath
            $Endpoint = New-UDEndpoint -Url "user" -Endpoint {
                "2"
            }

            $Server = Start-UDRestApi -Port 10002 -Endpoint $Endpoint -AutoReload
        }.ToString().Replace('$ModulePath', "'$ModulePath'") | Out-File $tempFile 

        . $TempFile

        It "auto reloads" {

            Invoke-RestMethod http://localhost:10002/api/user | should be "2"

            {
                Import-Module $ModulePath
                $Endpoint = New-UDEndpoint -Url "user" -Endpoint {
                    "1"
                }

                $Server = Start-UDRestApi -Port 10002 -Endpoint $Endpoint -AutoReload
            }.ToString().Replace('$ModulePath', "'$ModulePath'") | Out-File $tempFile -Force

            Start-Sleep 1
            Invoke-RestMethod http://localhost:10002/api/user | should be "1"
        }

        Remove-Item $TempFile
        Get-UDRestApi | Stop-UDRestApi        
    }
}