param([Switch]$Release)

. "$PSScriptRoot\..\TestFramework.ps1"
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

Get-UDDashboard | Stop-UDDashboard

$Driver = Start-SeFirefox
$Server = Start-UDDashboard -Port 10001 

function Set-TestDashboard {
    param($Dashboard)

    $Server.DashboardService.SetDashboard($Dashboard)
    Enter-SeUrl -Url "http://localhost:$BrowserPort" -Driver $Driver 
}

Describe "Set-UDClipboard" {

    Context "set the clipboard by button click" {
        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDButton -Id 'btnClipboard' -Floating -Icon clipboard -OnClick {
                Set-UDClipboard -Data 'You just copy me!!'
            } 
        }
        
        Set-TestDashboard -Dashboard $dashboard

        It "should set clipboard with You just copy me!! text" {
            Find-SeElement -Driver $Driver -Id "btnClipboard" | Invoke-SeClick 
            Start-Sleep 2
            Get-Clipboard | Should be 'You just copy me!!'
        }
    }

    Context "set the clipboard with text box value by button click" {
        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDTextbox -Label "Textbox" -Placeholder "Enter your name" -Id 'textToCopy1'
            New-UDButton -Id 'btnClipboard' -Icon clipboard -OnClick {
                $Element = Get-UDElement -Id 'textToCopy1'
                $text = $Element.Attributes.value
                Set-UDClipboard -Data $text
            } 
        }
        
        Set-TestDashboard -Dashboard $dashboard

        It "should set clipboard with hello text" {
            $Element = Find-SeElement -Id "textToCopy1" -Driver $Driver
            Send-SeKeys -Element $Element -Keys "hello"
            Start-Sleep 2
            Find-SeElement -Driver $Driver -Id "btnClipboard" | Invoke-SeClick
            Start-Sleep 2
            Get-Clipboard | Should be 'hello'
        }
    }

    Stop-SeDriver $Driver
    Stop-UDDashboard $Server
}