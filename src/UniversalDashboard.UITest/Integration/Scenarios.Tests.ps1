. "$PSScriptRoot\..\TestFramework.ps1"

Describe "Scenarios" {

    Context "466" {
        $Schedule = New-UDEndpointSchedule -Every 1 -Second
        $ScheduledEndpoint = New-UDEndpoint -Schedule $Schedule -Endpoint {
            $Item1 = [PSCustomObject]@{ PING = 100; VMIX = (New-UDButton -Text (Get-Date).Second); WRM = 1; NAME = "ITEM1" }
            $Item2 = [PSCustomObject]@{ PING = 200; VMIX = (New-UDButton -Text (Get-Date).Second); WRM = 1; NAME = "ITEM1" }
            $Item3 = [PSCustomObject]@{ PING = 300; VMIX = (New-UDButton -Text (Get-Date).Second); WRM = 1; NAME = "ITEM2" }
            $Item4 = [PSCustomObject]@{ PING = 400; VMIX = (New-UDButton -Text (Get-Date).Second); WRM = 1; NAME = "ITEM2" }
    
            $Cache:Items = @($Item1, $Item2, $Item3, $Item4)
        }

        $Page = New-UDPage -Name 'Autoreload' -Endpoint {

            New-UDCard -Title "Hi $((Get-Date).Second)" -Content {} -Id 'card'

            $MyItems = $Cache:Items | Group-Object Name
            foreach($Item in $MyItems) {

                $Status = $Cache:Items | Where { $_.Name -eq $Item.Name }

                New-UDTable -Title $Item.Name -Headers @("NAME", "PING", "VMIX", "WRM") -Content {
                    $Status | Out-UDTableData -Property @("NAME", "PING", "VMIX", "WRM")
                } 

                New-UDGrid -Title $Item.Name -Headers @("NAME", "PING", "VMIX", "WRM") -Properties @("NAME", "PING", "VMIX", "WRM") -Endpoint {
                    $ArgumentList | Out-UDGridData
                } -ArgumentList $Status -NoPaging -DefaultSortColumn "NAME"
            }
        } -AutoRefresh -RefreshInterval 1

        $Dashboard = New-UDDashboard -Title "Dashboard" -Pages $Page
        Start-UDDashboard -Dashboard $Dashboard -Port 10001 -Force -Endpoint $ScheduledEndpoint

        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"

        It "should refresh card" {
            $ElementText = (Find-SeElement -Id 'card' -Driver $Driver).Text
            Start-Sleep 2
            $ElementText | should not be (Find-SeElement -Id 'card' -Driver $Driver).Text
        }

        It "should refresh table and grid" {
            $ElementTexts = (Find-SeElement -ClassName 'btn' -Driver $Driver).Text

            Start-Sleep 2
            $NewElementTexts = (Find-SeElement -ClassName 'btn'  -Driver $Driver).Text

            for($i = 0; $i -lt $ElementTexts.Count; $i++) {
                $ElementTexts[$i] | should not be $NewElementTexts[$i]
            }
        }
    }
}
