. "$PSScriptRoot\..\TestFramework.ps1"

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

        Start-UDRestApi -Endpoint @($Endpoint, $EverySecond) -Port 10001 -Force

        It "should update number in background" {

            $Result  = Invoke-RestMethod http://localhost:10001/api/test
            Start-Sleep 2
            $Result2  = Invoke-RestMethod http://localhost:10001/api/test

            $Result | Should not be $Result2
        }
    }

    Context "Manage schedule endpoints" {

        $Schedule = New-UDEndpointSchedule -Every 1 -Second 

        $EverySecond = New-UDEndpoint -Schedule $Schedule -Endpoint {
            $Cache:Value = "FirstSchedule"
        } -Id 'schedule'

        $Endpoint = New-UDEndpoint -Url "changeSchedule" -Endpoint {
            Remove-UDEndpoint -Id 'schedule'
            $Schedule = New-UDEndpointSchedule -Every 1 -Second 
            New-UDEndpoint -Schedule $Schedule -Endpoint {
                $Cache:Value = "SecondSchedule"
            } -Id 'schedule'
        }

        $Endpoint = New-UDEndpoint -Url "test" -Endpoint {
            $Cache:Value
        }

        Start-UDRestApi -Endpoint @($Endpoint, $EverySecond) -Port 10001 -Force

        It "should set remove and recreate schedule" {
            Invoke-RestMethod http://localhost:10001/api/test | Should be "FirstSchedule"
            Invoke-RestMethod http://localhost:10001/api/changeSchedule
            Start-Sleep 2
            Invoke-RestMethod http://localhost:10001/api/test | Should be "SecondSchedule"

            (Get-UDRestApi).DashboardService.EndpointService.ScheduledEndpointManager.GetUpcomingJobs().Result.Length | Should be 1
        }
    }

    Context "Manual Invoke" {

        $Schedule = New-UDEndpointSchedule -Every 1 -Day 

        $EverySecond = New-UDEndpoint -Schedule $Schedule -Endpoint {
            $Cache:Value = Get-Random
        } -Id 'schedule'

        $Endpoint = New-UDEndpoint -Url "changeSchedule" -Endpoint {
            Invoke-UDEndpoint -Id 'schedule'
        }

        $Endpoint = New-UDEndpoint -Url "test" -Endpoint {
            $Cache:Value
        }

        Start-UDRestApi -Endpoint @($Endpoint, $EverySecond) -Port 10001 -Force

        It "should set remove and recreate schedule" {
            $Result = Invoke-RestMethod http://localhost:10001/api/test
            Invoke-RestMethod http://localhost:10001/api/changeSchedule
            Invoke-RestMethod http://localhost:10001/api/test | should not be $result
        }
    }


}