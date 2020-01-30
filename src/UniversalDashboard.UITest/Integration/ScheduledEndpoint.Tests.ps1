param([Switch]$Release)

. "$PSScriptRoot\..\TestFramework.ps1"
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

        $Endpoint = New-UDEndpoint -Url "test" -Endpoint {
            $Cache:EverySecondNumber
        }

        $Server = Start-UDRestApi -Endpoint @($Endpoint, $EverySecond) -Port 10001

        It "should update number in background" {

            $Result  = Invoke-RestMethod http://localhost:10001/api/test
            Start-Sleep 2
            $Result2  = Invoke-RestMethod http://localhost:10001/api/test

            $Result | Should not be $Result2
        }

        Stop-UDRestApi -Server $Server
    }

}