param([Switch]$Release)

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release
$BrowserPort = Get-BrowserPort -Release:$Release

Import-Module $ModulePath -Force

Get-UDDashboard | Stop-UDDashboard

Describe "Scheduled Endpoint" {

    Context "Correct parameter sets" {
        It 'should have every second' {
            $Schedule = New-UDEndpointSchedule -Every 1 -Second 
            $Schedule.Every | Should be ([TimeSpan]::FromSeconds(1))
        }

        It 'should have every minute' {
            $Schedule = New-UDEndpointSchedule -Every 1 -Minute 
            $Schedule.Every | Should be ([TimeSpan]::FromMinutes(1))
        }

        It 'should have every hour' {
            $Schedule = New-UDEndpointSchedule -Every 1 -Hour 
            $Schedule.Every | Should be ([TimeSpan]::FromHours(1))
        }

        It 'should have every days' {
            $Schedule = New-UDEndpointSchedule -Every 1 -Day 
            $Schedule.Every | Should be ([TimeSpan]::FromDays(1))
        }

        It 'should have cron' {
            $Schedule = New-UDEndpointSchedule -Cron 'test' 
            $Schedule.Cron | Should be 'test'
        }
    }

    Context "Scheduled Endpoints" {

        $Schedule = New-UDEndpointSchedule -Every 1 -Second 

        $EverySecond = New-UDEndpoint -Schedule $Schedule -Endpoint {
            $Cache:EverySecondNumber = Get-Random 
        }

        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDCounter -Title "Test" -Id "Counter" -Endpoint {
                $Cache:EverySecondNumber
            } -AutoRefresh -RefreshInterval 1
        } 

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard -Endpoint $EverySecond
        $Cache:Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Cache:Driver -Url "http://localhost:$BrowserPort"
        Start-Sleep 2

        It "should update number in background" {
            $Element = Find-SeElement -Driver $Cache:Driver -Id 'Counter'
            $Text = $Element.Text

            Start-Sleep 2

            (Find-SeElement -Driver $Cache:Driver -Id 'Counter').Text | Should not be $Text
        }

       Stop-SeDriver $Cache:Driver
       Stop-UDDashboard -Server $Server 
    }

}