param([Switch]$Release)

. "$PSScriptRoot\TestFramework.ps1"

$BrowserPort = Get-BrowserPort -Release:$Release
$ModulePath = Get-ModulePath -Release:$Release

Import-Module $ModulePath -Force

Get-UDDashboard | Stop-UDDashboard

Describe "GeoLocation" {
    Context "Should return location for user" {
        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDRow -Columns {
                New-UDColumn -Size 12 -Endpoint {
                    if ($Location -eq $null) {
                        New-UDCard -Title "Waiting for permission...." -Text {
                            "waiting...."
                        }
                        return
                    }

                    New-UDCard -Title "Timestamp" -Id "Timestamp" -Content {
                        $Location.Timestamp
                    }

                    New-UDCard -Title "Latitude" -Id "Latitude" -Content {
                        $Location.Coords.Latitude
                    }

                    New-UDCard -Title "Longitude" -Id "Longitude"  -Content {
                        $Location.Coords.Longitude
                    }

                    New-UDCard -Title "Altitude" -Id "Altitude" -Content {
                        $Location.Coords.Altitude
                    }
                } -AutoRefresh -RefreshInterval 5
            }

            
        } -GeoLocation

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
        Start-Sleep 30

        It "has correct coord values" {
            $Element = Find-SeElement -Driver $Driver -Id "Timestamp" 
            $Element.Text | Should -contain ((Get-Date).Year.ToString())
        }

       Stop-SeDriver $Driver
       Stop-UDDashboard -Server $Server 
    }
}
