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
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
        Start-Sleep 2

        It "should update number in background" {
            $Element = Find-SeElement -Driver $Driver -Id 'Counter'
            $Text = $Element.Text

            Start-Sleep 2

            (Find-SeElement -Driver $Driver -Id 'Counter').Text | Should not be $Text
        }

       Stop-SeDriver $Driver
       Stop-UDDashboard -Server $Server 
    }

}