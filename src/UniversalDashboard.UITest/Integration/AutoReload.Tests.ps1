. "$PSScriptRoot\..\TestFramework.ps1"

Describe "Auto reload" {
    Context "Changed script" {
        $tempFile = [System.IO.Path]::GetTempFileName() + ".ps1"

        $ModulePath = (Get-Module UniversalDashboard.Community).Path

        {
            Import-Module $ModulePath
            
            $dashboard = New-UDDashboard -Title "Test" -Content {
                
            }
    
            Start-UDDashboard -Force -Port 10001 -Dashboard $dashboard -AutoReload
        }.ToString().Replace('$ModulePath', "'$ModulePath'") | Out-File $tempFile 

        . $TempFile

        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        It "auto reloads" {
            {
                Import-Module $ModulePath

                $dashboard = New-UDDashboard -Title "Test 123" -Content {
                    New-UDCard -Title "Test" -Text "THIS IS AUTORELOADED" -Id "Card" -Links @(
                        New-UDLink -Text "My Link" -Url "http://www.google.com"
                    )
                }
        
                Start-UDDashboard -Force -Port 10001 -Dashboard $dashboard -AutoReload
            }.ToString().Replace('$ModulePath', "'$ModulePath'") | Out-File $tempFile -Force

            Start-Sleep 5

            Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
            (Find-SeElement -Driver $Driver -Id "Card").Text | Should BeLike "*THIS IS AUTORELOADED*"

        }

        Remove-Item $TempFile
    }

    Context "Changed REST API script" {
        $tempFile = [System.IO.Path]::GetTempFileName() + ".ps1"

        {
            Import-Module $ModulePath
            $Endpoint = New-UDEndpoint -Url "user" -Endpoint {
                "2"
            }

            Start-UDRestApi -Force -Port 10001 -Endpoint $Endpoint -AutoReload
        }.ToString().Replace('$ModulePath', "'$ModulePath'") | Out-File $tempFile 

        . $TempFile

        It "auto reloads" {

            Start-Sleep 3

            Invoke-RestMethod http://localhost:10001/api/autoreload | should be "2"

            {
                Import-Module $ModulePath
                $Endpoint = New-UDEndpoint -Url "autoreload" -Endpoint {
                    "1"
                }

                Start-UDRestApi -Port 10001 -Endpoint $Endpoint -AutoReload -Force
            }.ToString().Replace('$ModulePath', "'$ModulePath'") | Out-File $tempFile -Force

            Start-Sleep 3
            Invoke-RestMethod http://localhost:10001/api/autoreload | should be "1"
        }

        Remove-Item $TempFile
    }
}