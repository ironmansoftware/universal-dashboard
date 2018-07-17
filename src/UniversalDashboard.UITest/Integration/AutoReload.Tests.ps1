param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

Get-UDDashboard | Stop-UDDashboard

Describe "Auto reload" {
    Context "Changed script" {
        $tempFile = [System.IO.Path]::GetTempFileName() + ".ps1"

        {
            Import-Module $ModulePath
            
            $dashboard = New-UDDashboard -Title "Test" -Content {
                New-UDCard -Title "Test" -Text "My text" -Id "Card" -Links @(
                    New-UDLink -Text "My Link" -Url "http://www.google.com"
                )
            }
    
            $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard -AutoReload
        }.ToString().Replace('$ModulePath', "'$ModulePath'") | Out-File $tempFile 

        . $TempFile

        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        It "auto reloads" {
            {
                Import-Module $ModulePath

                $dashboard = New-UDDashboard -Title "Test 123" -Content {
                    New-UDCard -Title "Test" -Text "THIS IS AUTORELOADED" -Id "Card" -Links @(
                        New-UDLink -Text "My Link" -Url "http://www.google.com"
                    )
                }
        
                $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard -AutoReload
            }.ToString().Replace('$ModulePath', "'$ModulePath'") | Out-File $tempFile -Force

            Start-Sleep 5

            Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
            (Find-SeElement -Driver $Driver -Id "Card").Text | Should BeLike "*THIS IS AUTORELOADED*"

        }

        Remove-Item $TempFile
        Stop-SeDriver $Driver
        Get-UDRestApi | Stop-UDRestApi
        Get-UDDashboard | Stop-UDDashboard
    }

    Context "Changed REST API script" {
        $tempFile = [System.IO.Path]::GetTempFileName() + ".ps1"

        {
            Import-Module $ModulePath
            $Endpoint = New-UDEndpoint -Url "user" -Endpoint {
                "2"
            }

            $Server = Start-UDRestApi -Port 10001 -Endpoint $Endpoint -AutoReload
        }.ToString().Replace('$ModulePath', "'$ModulePath'") | Out-File $tempFile 

        . $TempFile

        It "auto reloads" {

            Invoke-RestMethod http://localhost:10001/api/user | should be "2"

            {
                Import-Module $ModulePath
                $Endpoint = New-UDEndpoint -Url "user" -Endpoint {
                    "1"
                }

                $Server = Start-UDRestApi -Port 10001 -Endpoint $Endpoint -AutoReload
            }.ToString().Replace('$ModulePath', "'$ModulePath'") | Out-File $tempFile -Force

            Start-Sleep 1
            Invoke-RestMethod http://localhost:10001/api/user | should be "1"
        }

        Remove-Item $TempFile
        Get-UDRestApi | Stop-UDRestApi        
        Get-UDDashboard | Stop-UDDashboard 
    }
}