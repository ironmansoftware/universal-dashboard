param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

Get-UDDashboard | Stop-UDDashboard

Describe "Card" {
    Context "Simple Card" {
        $tempDir = [System.IO.Path]::GetTempPath()
        $tempFile = Join-Path $tempDir "output.txt"

        if ((Test-path $tempFile)) {
            Remove-Item $tempFile -Force
        }

        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDCard -Title "Test" -Text "My text" -Id "Card" -Links @(
                New-UDLink -Text "My Link" -Url "http://www.google.com"
            )
        }

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        It "should have title text" {
            $Element = Find-SeElement -Id "Card" -Driver $Driver
            $Element.Text.Split("`r`n")[0] | should be "Test"
        }

        It "should have link" {
            Find-SeElement -LinkText "My Link" -Driver $Driver | Should not be $null
        }

       Stop-SeDriver $Driver
       Stop-UDDashboard -Server $Server 
    }

        
    Context "No text card" {
        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDCard -Title "Test" -Id "Card" -Endpoint {
                New-UDElement -Tag "div" -Content { "Endpoint Content" } 
            }
        }

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        Start-Sleep 2

        It "should have body text" {
            $Element = Find-SeElement -Id "Card" -Driver $Driver
            ($Element.Text).Contains("Endpoint Content") | should be $true
        }

        Stop-SeDriver $Driver
        Stop-UDDashboard -Server $Server 
    }
    
    Context "No text card" {
        $tempDir = [System.IO.Path]::GetTempPath()
        $tempFile = Join-Path $tempDir "output.txt"

        if ((Test-path $tempFile)) {
            Remove-Item $tempFile -Force
        }

        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDCard -Title "Test" -Id "Card"
        }

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        It "should have title text" {
            $Element = Find-SeElement -Id "Card" -Driver $Driver
            $Element.Text | should be "Test"
        }

       Stop-SeDriver $Driver
       Stop-UDDashboard -Server $Server 
    }

    Context "Multi-line Card" {
        $tempDir = [System.IO.Path]::GetTempPath()
        $tempFile = Join-Path $tempDir "output.txt"

        if ((Test-path $tempFile)) {
            Remove-Item $tempFile -Force
        }

        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDCard -Title "Test" -Text "My text`r`nNew Line" -Id "Card"
        }

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        It "should support new line in card" {
            $Element = Find-SeElement -Id "Card" -Driver $Driver
            $Br = Find-SeElement -Tag "br" -Element $Element
            $Br | should not be $null
        }
       Stop-SeDriver $Driver
       Stop-UDDashboard -Server $Server 
    }

    Context "Custom Card" {
        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDCard -Title "Test" -Text "My text`r`nNew Line" -Id "Card" -TextAlignment Center -TextSize Medium -Watermark user
        }

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        It "should support new line in card" {
        
        }

       Stop-SeDriver $Driver
       Stop-UDDashboard -Server $Server 
    }

    Context "Card with content" {
        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDCard -Title "Test" -Content {
                New-UDElement -Tag "span" -Attributes @{id = "spanTest"} -Content {
                    "This is some custom content"
                }
            }
        }

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        It "should have custom content" {
            $Element = Find-SeElement -Id "spanTest" -Driver $Driver
            $Element.Text | should be "This is some custom content"
        }

       Stop-SeDriver $Driver
       Stop-UDDashboard -Server $Server 
    }

}