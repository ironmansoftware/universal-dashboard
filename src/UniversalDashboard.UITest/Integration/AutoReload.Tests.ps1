param([Switch]$Release)

Import-Module "$PSScriptRoot\Selenium\Selenium.psm1" -Force 

if (-not $Release) {
    $BrowserPort = 10000
    Import-Module "$PSScriptRoot\..\..\UniversalDashboard\bin\debug\UniversalDashboard.Community.psd1"
} else {
    $BrowserPort = 10001
    Import-Module "$PSScriptRoot\..\..\output\UniversalDashboard.Community.psd1"
}

Get-UDDashboard | Stop-UDDashboard

Describe "Auto reload" {
    Context "Changed script" {
        $tempFile = [System.IO.Path]::GetTempFileName() + ".ps1"

        {
            
            $dashboard = New-UDDashboard -Title "Test" -Content {
                New-UDCard -Title "Test" -Text "My text" -Id "Card" -Links @(
                    New-UDLink -Text "My Link" -Url "http://www.google.com"
                )
            }
    
            $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard -AutoReload
        }.ToString() | Out-File $tempFile 

        . $TempFile

        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
        Start-Sleep 5

        It "auto reloads" {
            {
                $dashboard = New-UDDashboard -Title "Test 123" -Content {
                    New-UDCard -Title "Test" -Text "THIS IS AUTORELOADED" -Id "Card" -Links @(
                        New-UDLink -Text "My Link" -Url "http://www.google.com"
                    )
                }
        
                $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard -AutoReload
            }.ToString() | Out-File $tempFile -Force

            Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
            Start-Sleep 5

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
            $Endpoint = New-UDEndpoint -Url "user" -Endpoint {
                "2"
            }

            $Server = Start-UDRestApi -Port 10001 -Endpoint $Endpoint -AutoReload
        }.ToString() | Out-File $tempFile 

        . $TempFile

        It "auto reloads" {

            Invoke-RestMethod http://localhost:10001/api/user | should be "2"

            {
                $Endpoint = New-UDEndpoint -Url "user" -Endpoint {
                    "1"
                }

                $Server = Start-UDRestApi -Port 10001 -Endpoint $Endpoint -AutoReload
            }.ToString() | Out-File $tempFile -Force

            Start-Sleep 1
            Invoke-RestMethod http://localhost:10001/api/user | should be "1"
        }

        Remove-Item $TempFile
        Get-UDRestApi | Stop-UDRestApi        
        Get-UDDashboard | Stop-UDDashboard 
    }
}