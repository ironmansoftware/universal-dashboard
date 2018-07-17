param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

Get-UDDashboard | Stop-UDDashboard

Describe "Show-UDModal" {
    Context "Link in card" {
        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDButton -Text "Click" -Id "Click" -OnClick {
                Show-UDModal -Header {
                    New-UDHeading -Size 4 -Text "Heading" -Id "Heading"
                } -Content {
                    New-UDButton -Text "Press me" -Id "Close" -OnClick {
                        Hide-UDModal
                    }
                } -BackgroundColor black -FontColor red
            }

            New-UDButton -Text "Click" -Id "Click2" -OnClick {
                Show-UDModal -Header {
                    New-UDHeading -Size 4 -Text "Heading two" 
                } -Content {
                    New-UDButton -Text "Press me" -Id "Close2" -OnClick {
                        Hide-UDModal
                    }
                } 
            }
        } 

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
        Start-Sleep 5

        It "should open and close modal" {
            Find-SeElement -Driver $Driver -Id "Click" | Invoke-SeClick

            Start-Sleep 3

            (Find-SeElement -Driver $driver -Id "Heading").Text | Should be "Heading"
            Find-SeElement -Driver $Driver -Id "Close" | Invoke-SeClick
        }

        Stop-SeDriver $Driver
        Stop-UDDashboard -Server $Server 
    }
}
