param([Switch]$Release)

$Env:Debug = -not $Release

Import-Module "$PSScriptRoot\..\TestFramework.psm1" -Force
$ModulePath = Get-ModulePath -Release:$Release

Import-Module $ModulePath -Force

Get-UDDashboard | Stop-UDDashboard
$Server = Start-UDDashboard -Dashboard $dash -Port 10001
$Driver = Start-SeFirefox

Describe "Theme" {

    Context "Controls" {

        $AzureTheme = Get-UDTheme -Name 'Azure'

        $Dashboard = New-UdDashboard -Title "Theme" -Theme $AzureTheme -Content {
            New-UDInput -Title "Input" -Content {
                New-UDInputField -Name 'Textbox' -Type textbox
                New-UDInputField -Name 'Textarea' -Type textarea
                New-UDInputField -Name 'Password' -Type password
                New-UDInputField -Name 'Date' -Type date
            } -Endpoint {

            }
        } 

        $Server.DashboardService.SetDashboard($Dashboard)
        Enter-SeUrl -Driver $Driver -Url "http://localhost:10001"
        
        It "should have the correct UDInput colors" {
            $Element = Find-SeElement -Driver $Driver -Id Textbox 
            $Element | Get-SeElementCssValue -Name 'color' | Should be 'rgb(255, 255, 255)'

            $Element = Find-SeElement -Driver $Driver -Id Textarea
            $Element | Get-SeElementCssValue -Name 'color' | Should be 'rgb(255, 255, 255)'

            $Element = Find-SeElement -Driver $Driver -Id Password
            $Element | Get-SeElementCssValue -Name 'color' | Should be 'rgb(255, 255, 255)'

            $Element = Find-SeElement -Driver $Driver -Id Date
            $Element | Get-SeElementCssValue -Name 'color' | Should be 'rgb(255, 255, 255)'

        }
    }

    Context "no stackoverflow" {
        $Theme3 = New-UDTheme -Name "Basic" -Definition @{
            UDDashboard = @{
                BackgroundColor = "rgb(255,255,255)"
                FontColor = "rgb(0, 0, 0)"
            }
          } -Parent "Azure"

        $Dashboard = New-UDDashboard -Title 'Debug' -Theme $Theme3 -Content {}
        $Server.DashboardService.SetDashboard($Dashboard)

        It "should not throw stackoverflow exception" {
            Get-UDDashboard |  should not be $null
        }
    }

    Context "basic theme" {
        $Theme = New-UDTheme -Name "Default" -Definition @{
            '.ud-card' = @{
                'background-color' = '#123123'
                'color' = '#999999'
            }
        }

        $Dashboard = New-UdDashboard -Title "Theme" -Content {
            New-UDCard -Title "Theme Test"
            New-UDCard -Title "Theme Test" -BackgroundColor "#888888"
        } -Theme $Theme

        $Server.DashboardService.SetDashboard($Dashboard)
        
        It "should generate the correct theme" {
            $Theme = Invoke-WebRequest http://localhost:10001/api/internal/dashboard/theme -WebSession $ud

            $Theme.Content.Contains(".ud-card {`r`n`tcolor : #999999;`r`n`tbackground-color : #123123;`r`n}`r`n") | should be $true
        }
    }

    Context "css mapper theme" {
        $Theme = New-UDTheme -Name "Default" -Definition @{
            'UDCard' = @{
                'Fontcolor' = '#999999'
                'BackgroundColor' = '#123123'
            }
        }

        $Dashboard = New-UdDashboard -Title "Theme" -Content {
            New-UDCard -Title "Theme Test"
            New-UDCard -Title "Theme Test" -BackgroundColor "#888888"
        } -Theme $Theme

        $Server.DashboardService.SetDashboard($Dashboard)

        It "should generate the correct theme" {
            $Theme = Invoke-WebRequest http://localhost:10001/api/internal/dashboard/theme -WebSession $ud

            $Theme.Content.Contains(".ud-card {`r`n`tbackground-color : #123123;`r`n`tcolor : #999999;`r`n}") | should be $true
        }
    }


    Context "parent theme" {
        $Theme = New-UDTheme -Name "Default" -Definition @{
            'UDTable' = @{
                'background-color' = '#123123'
            }
        } -Parent Test

        $Dashboard = New-UdDashboard -Title "Theme" -Content {
            New-UDCard -Title "Theme Test"
            New-UDCard -Title "Theme Test" -BackgroundColor "#888888"
        } -Theme $Theme
        $Server.DashboardService.SetDashboard($Dashboard)
        It "should generate the correct theme" {
            $Theme = Invoke-WebRequest http://localhost:10001/api/internal/dashboard/theme -WebSession $ud

            Wait-Debugger

            $Theme.Content.Contains(".ud-dashboard {`r`n`tbackground-color : #234234;`r`n`tcolor : #959595;`r`n}`r`n.ud-table {`r`n`tbackground-color : #123123;`r`n}`r`n") | should be $true
        }
    }

    Context "predefined theme" {
        $Theme = Get-UDTheme | Where-Object Name -eq "Azure"

        $Dashboard = New-UdDashboard -Title "Theme" -Content {
            New-UDCard -Title "Theme Test"
            New-UDCard -Title "Theme Test" -BackgroundColor "#888888"
            New-UDGrid -Title "Grid" -Headers @("1", "2") -Properties @("1", "2") -Endpoint {
                [PSCUstomObject]@{"1" = 1; "2" = 2} | Out-UDGridData
            }
            New-UDTable -Title "Table" -Headers @("1", "2") -Endpoint {
                [PSCUstomObject]@{"1" = 1; "2" = 2} | Out-UDTableData -Property @("1", "2")
            }
            New-UDChart -Title "Chart" -Id "Chart" -Type Line -EndPoint {
                $data = @(
                    [PSCustomObject]@{"Day" = 1; Jpg = "10"; MP4= "30"}
                    [PSCustomObject]@{"Day" = 2; Jpg = "20"; MP4= "20"}
                    [PSCustomObject]@{"Day" = 3; Jpg = "30"; MP4= "10"}
                )

                $data | Out-UDChartData -LabelProperty "Day" -Dataset @(
                    New-UDChartDataset -DataProperty "Jpg" -Label "Jpg" -BackgroundColor "#80962F23" -HoverBackgroundColor "#80962F23"
                    New-UDChartDataset -DataProperty "MP4" -Label "MP4" -BackgroundColor "#8014558C" -HoverBackgroundColor "#8014558C"
                ) 
            }
            New-UDMonitor -Title "Monitor" -Id "Monitor" -ChartBackgroundColor "#80962F23" -ChartBorderColor "#80962F23" -Type Line -EndPoint {
                Get-Random | Out-UDMonitorData
            } 
        } -Theme $Theme

        $Server.DashboardService.SetDashboard($Dashboard)
        
        It "should generate the correct theme" {
            $Theme = Invoke-WebRequest http://localhost:10001/api/internal/dashboard/theme -WebSession $ud

            $Theme.Content | Should not be $null
        }
    }

    Context "default theme" {
        $Dashboard = New-UdDashboard -Title "Theme" -Content {
            New-UDCard -Title "Theme Test"
            New-UDCard -Title "Theme Test" -BackgroundColor "#888888"
        } 

        $Server.DashboardService.SetDashboard($Dashboard)
        
        It "should generate the correct theme" {
            $Theme = Invoke-WebRequest http://localhost:10001/api/internal/dashboard/theme -WebSession $ud

            $Theme.Content | Should not be $null
        }
    }
}

Stop-SeDriver $Driver
Stop-UDDashboard -Server $Server 




