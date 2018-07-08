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
Describe "Grid" {
    Context "no data" {
        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDGrid -Title "Grid" -Id "Grid" -Headers @("hour", "minute", "second")  -Properties @("hour", "minute", "second") -RefreshInterval 1 -AutoRefresh -DefaultSortColumn "jpg" -DefaultSortDescending -EndPoint {
                $data = @()

                $data | Out-UDGridData 
            } 

            New-UDGrid -Title "Grid" -Id "Grid2" -Headers @("hour", "minute", "second")  -Properties @("hour", "minute", "second") -RefreshInterval 1 -AutoRefresh -DefaultSortColumn "jpg" -DefaultSortDescending -EndPoint {
                $data = @()

                "Has" | Out-UDGridData 
            } 
        }

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
        Start-Sleep 2

        It "should not shown an error with no data" {
            $Element = Find-SeElement -Id "Grid" -Driver $Driver
            $Element.Text.Contains("No results found") | Should be $true
        }

        It "should not shown an error with invalid output" {
            $Element = Find-SeElement -Id "Grid2" -Driver $Driver
            $Element.Text.Contains("No results found") | Should be $true
        }

        Stop-SeDriver $Driver
        Stop-UDDashboard -Server $Server 
    }

    Context "Custom Columns" {
        $dashboard = New-UDDashboard -Title "Test" -Content {

            $Variable = "Test"

            New-UDGrid -Title "Grid" -Id "Grid" -Headers @("day", "jpg", "mp4")  -Properties @("day", "jpg", "mp4") -EndPoint {
                $data = @(
                    [PSCustomObject]@{"day" = 1; jpg = $Variable; mp4= (New-UDLink -Text "This is text" -Url "http://www.google.com")}
                    [PSCustomObject]@{"day" = 2; jpg = "20"; mp4= (Get-Date -Day 2 -Month 12 -Year 2007)}
                    [PSCustomObject]@{"day" = 3; jpg = $true; mp4= (New-UDButton -Text "Hey" -OnClick{ Set-UDElement -Id "Hey" -Content {"Hey"}})}
                )

                $data | Out-UDGridData 
            } -Links @(
                (New-UDLink -Text "Other link" -Url "http://www.google.com")
            )
            New-UDElement -Id "Hey" -Tag "div"
        }

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
        Start-Sleep 2

        It "should click button" {
            $Button = Find-SeElement -LinkText "Hey" -Driver $Driver 
            Invoke-SeClick -Element $Button 

            Start-Sleep 1

            (Find-SeElement -Id "Hey" -Driver $Driver).Text | should be "Hey"
        }


        It "should have link" {
            Find-SeElement -LinkText "This is text" -Driver $Driver | Should not be $null
        }

        It "should have link in footer" {
            Find-SeElement -LinkText "Other link" -Driver $Driver | Should not be $null
        }

        It "should format date correctly" {
            $Element = Find-SeElement -Id "Grid" -Driver $Driver
            $Element = Find-SeElement -ClassName "griddle-cell" -Driver $Element[0] 
            $Element[5].Text | Should BeLike "Dec 2, 2007*"
        }

        It "should format bool correctly" {
            $Element = Find-SeElement -Id "Grid" -Driver $Driver
            $Element = Find-SeElement -ClassName "griddle-cell" -Driver $Element[0] 
            $Element[7].Text | Should Be 'true'
        }

        Stop-SeDriver $Driver
        Stop-UDDashboard -Server $Server 
    }

    Context "throws" {
        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDGrid -Title "Grid" -Id "Grid" -Headers @("hour", "minute", "second")  -Properties @("hour", "minute", "second") -DefaultSortColumn "jpg" -DefaultSortDescending -EndPoint {
                try {
                    throw "WTF"
                    $data = @()
                }
                catch {

                }

                $data | Out-UDGridData 
            } 
        }

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
        Start-Sleep 2

        It "should not shown an error with no data" {
            $Element = Find-SeElement -Id "Grid" -Driver $Driver
            $Element.Text.Contains("No results found") | Should be $true
        }

       Stop-SeDriver $Driver
       Stop-UDDashboard -Server $Server 
    }

    Context "server side processing" {
        $dashboard = New-UDDashboard -Title "Test" -Content {New-UDGrid -Title "Grid" -Id "Grid" -Headers @("day", "jpg", "mp4") -Properties @("day", "jpg", "mp4") -ServerSideProcessing -DefaultSortColumn "day" -EndPoint {
                $data = @(
                    [PSCustomObject]@{"day" = 1; jpg = "10"; mp4= "30"}
                    [PSCustomObject]@{"day" = 2; jpg = "20"; mp4= "20"}
                    [PSCustomObject]@{"day" = 3; jpg = "30"; mp4= "10"}
                    [PSCustomObject]@{"day" = 1; jpg = "10"; mp4= "30"}
                    [PSCustomObject]@{"day" = 2; jpg = "20"; mp4= "20"}
                    [PSCustomObject]@{"day" = 3; jpg = "30"; mp4= "10"}
                    [PSCustomObject]@{"day" = 1; jpg = "10"; mp4= "30"}
                    [PSCustomObject]@{"day" = 2; jpg = "20"; mp4= "20"}
                    [PSCustomObject]@{"day" = 3; jpg = "30"; mp4= "10"}
                    [PSCustomObject]@{"day" = 1; jpg = "10"; mp4= "30"}
                    [PSCustomObject]@{"day" = 2; jpg = "20"; mp4= "20"}
                    [PSCustomObject]@{"day" = 3; jpg = "30"; mp4= "10"}
                    [PSCustomObject]@{"day" = 1; jpg = "10"; mp4= "30"}
                    [PSCustomObject]@{"day" = 2; jpg = "20"; mp4= "20"}
                    [PSCustomObject]@{"day" = 3; jpg = "30"; mp4= "10"}
                    [PSCustomObject]@{"day" = 1; jpg = "10"; mp4= "30"}
                    [PSCustomObject]@{"day" = 2; jpg = "20"; mp4= "20"}
                    [PSCustomObject]@{"day" = 3; jpg = "30"; mp4= "10"}
                )

                if ($filterText -ne $null -and $filterText -ne "") {
                    $data = $data | Where  {$_.day -eq $filterText -or $_.jpg -eq $filterText -or $_.mp4 -eq $filterText }
                }
        
                $sortDescending = -not $sortAscending
                $data = $data | Sort-Object -Property $sortColumn -Descending:$sortDescending
        
                $total = $data.length
                $data = $data | Select-Object -First $take -Skip $skip

                $data | Out-UDGridData -TotalItems $total
            } 
        }

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
        Start-Sleep 2

        It "should have data" {
            $Element = Find-SeElement -ClassName "griddle-row" -Driver $Driver
            $Element = Find-SeElement -ClassName "griddle-cell" -Driver $Element[0] 
            $Element.Length | Should be 3
            $Element[0].Text | should be "1"
            $Element[1].Text | should be "10"
            $Element[2].Text | should be "30"
        }

        It "should sort data" {
            
            $Row = Find-SeElement -ClassName "griddle-row" -Driver $Driver
            $Element = Find-SeElement -ClassName "griddle-cell" -Driver $Row[0] 
            $Element[0].Text | should be "1"
            $Element = Find-SeElement -ClassName "griddle-cell" -Driver $Row[1] 
            $Element[0].Text | should be "1"

            $Element = Find-SeElement -ClassName "griddle-table-heading-cell" -Driver $Driver
            $header = $element[0]
            Invoke-SeClick $header

            Start-Sleep 1

            $Row = Find-SeElement -ClassName "griddle-row" -Driver $Driver
            $Element = Find-SeElement -ClassName "griddle-cell" -Driver $Row[0] 
            $Element[0].Text | should be "3"
            $Element = Find-SeElement -ClassName "griddle-cell" -Driver $Row[1] 
            $Element[0].Text | should be "3"
            
            $Element = Find-SeElement -ClassName "griddle-table-heading-cell" -Driver $Driver
            $header = $element[0]
            Invoke-SeClick $header

            Start-Sleep 1

            $Row = Find-SeElement -ClassName "griddle-row" -Driver $Driver
            $Element = Find-SeElement -ClassName "griddle-cell" -Driver $Row[0] 
            $Element[0].Text | should be "1"
            $Element = Find-SeElement -ClassName "griddle-cell" -Driver $Row[1] 
            $Element[0].Text | should be "1"
        }

        It "should filter data" {
            
            $Element = Find-SeElement -ClassName "griddle-filter" -Driver $Driver

            Send-SeKeys -Element $Element[0] -Keys "2"
            Sleep 1
            Send-SeKeys -Element $Element[0] -Keys "0"

            Sleep 1

            $Element = Find-SeElement -ClassName "griddle-row" -Driver $Driver
            $Element.Length | Should be 6
        }
        
        Stop-SeDriver $Driver
        Stop-UDDashboard -Server $Server 
    }
    
    Context "Grid" {
        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDGrid -Title "Grid" -Id "Grid" -Headers @("day", "jpg", "mp4")  -Properties @("day", "jpg", "mp4") -EndPoint {
                $data = @(
                    [PSCustomObject]@{"day" = 1; jpg = "10"; mp4= "30"}
                    [PSCustomObject]@{"day" = 2; jpg = "20"; mp4= "20"}
                    [PSCustomObject]@{"day" = 3; jpg = "30"; mp4= "10"}
                    [PSCustomObject]@{"day" = 1; jpg = "10"; mp4= "30"}
                    [PSCustomObject]@{"day" = 2; jpg = "20"; mp4= "20"}
                    [PSCustomObject]@{"day" = 3; jpg = "30"; mp4= "10"}
                    [PSCustomObject]@{"day" = 1; jpg = "10"; mp4= "30"}
                    [PSCustomObject]@{"day" = 2; jpg = "20"; mp4= "20"}
                    [PSCustomObject]@{"day" = 3; jpg = "30"; mp4= "10"}
                    [PSCustomObject]@{"day" = 1; jpg = "10"; mp4= "30"}
                    [PSCustomObject]@{"day" = 2; jpg = "20"; mp4= "20"}
                    [PSCustomObject]@{"day" = 3; jpg = "30"; mp4= "10"}
                    [PSCustomObject]@{"day" = 1; jpg = "10"; mp4= "30"}
                    [PSCustomObject]@{"day" = 2; jpg = "20"; mp4= "20"}
                    [PSCustomObject]@{"day" = 3; jpg = "30"; mp4= "10"}
                    [PSCustomObject]@{"day" = 1; jpg = "10"; mp4= "30"}
                    [PSCustomObject]@{"day" = 2; jpg = "20"; mp4= "20"}
                    [PSCustomObject]@{"day" = 3; jpg = "30"; mp4= "10"}
                )

                $data | Out-UDGridData 
            }

            New-UDGrid -Title "Grid" -Id "SingleItemGrid" -Headers @("day", "jpg", "mp4")  -Properties @("day", "jpg", "mp4") -EndPoint {
                [PSCustomObject]@{"day" = 1; jpg = "10"; mp4= "30"} | Out-UDGridData 
            }

            New-UDGrid -Title "Grid" -Id "NoPagingGrid" -Headers @("day", "jpg", "mp4")  -Properties @("day", "jpg", "mp4") -EndPoint {
                $data = @(
                    [PSCustomObject]@{"day" = 1; jpg = "10"; mp4= "30"}
                    [PSCustomObject]@{"day" = 2; jpg = "20"; mp4= "20"}
                    [PSCustomObject]@{"day" = 3; jpg = "30"; mp4= "10"}
                    [PSCustomObject]@{"day" = 1; jpg = "10"; mp4= "30"}
                    [PSCustomObject]@{"day" = 2; jpg = "20"; mp4= "20"}
                    [PSCustomObject]@{"day" = 3; jpg = "30"; mp4= "10"}
                    [PSCustomObject]@{"day" = 1; jpg = "10"; mp4= "30"}
                    [PSCustomObject]@{"day" = 2; jpg = "20"; mp4= "20"}
                    [PSCustomObject]@{"day" = 3; jpg = "30"; mp4= "10"}
                    [PSCustomObject]@{"day" = 1; jpg = "10"; mp4= "30"}
                    [PSCustomObject]@{"day" = 2; jpg = "20"; mp4= "20"}
                    [PSCustomObject]@{"day" = 3; jpg = "30"; mp4= "10"}
                    [PSCustomObject]@{"day" = 1; jpg = "10"; mp4= "30"}
                    [PSCustomObject]@{"day" = 2; jpg = "20"; mp4= "20"}
                    [PSCustomObject]@{"day" = 3; jpg = "30"; mp4= "10"}
                    [PSCustomObject]@{"day" = 1; jpg = "10"; mp4= "30"}
                    [PSCustomObject]@{"day" = 2; jpg = "20"; mp4= "20"}
                    [PSCustomObject]@{"day" = 3; jpg = "30"; mp4= "10"}
                )

                $data | Out-UDGridData 
            } -NoPaging

            New-UDGrid -Title "Grid" -Id "PageSizeGrid" -Headers @("day", "jpg", "mp4")  -Properties @("day", "jpg", "mp4") -EndPoint {
                $data = @(
                    [PSCustomObject]@{"day" = 1; jpg = "10"; mp4= "30"}
                    [PSCustomObject]@{"day" = 2; jpg = "20"; mp4= "20"}
                    [PSCustomObject]@{"day" = 3; jpg = "30"; mp4= "10"}
                    [PSCustomObject]@{"day" = 1; jpg = "10"; mp4= "30"}
                    [PSCustomObject]@{"day" = 2; jpg = "20"; mp4= "20"}
                    [PSCustomObject]@{"day" = 3; jpg = "30"; mp4= "10"}
                    [PSCustomObject]@{"day" = 1; jpg = "10"; mp4= "30"}
                    [PSCustomObject]@{"day" = 2; jpg = "20"; mp4= "20"}
                    [PSCustomObject]@{"day" = 3; jpg = "30"; mp4= "10"}
                    [PSCustomObject]@{"day" = 1; jpg = "10"; mp4= "30"}
                    [PSCustomObject]@{"day" = 2; jpg = "20"; mp4= "20"}
                    [PSCustomObject]@{"day" = 3; jpg = "30"; mp4= "10"}
                    [PSCustomObject]@{"day" = 1; jpg = "10"; mp4= "30"}
                    [PSCustomObject]@{"day" = 2; jpg = "20"; mp4= "20"}
                    [PSCustomObject]@{"day" = 3; jpg = "30"; mp4= "10"}
                    [PSCustomObject]@{"day" = 1; jpg = "10"; mp4= "30"}
                    [PSCustomObject]@{"day" = 2; jpg = "20"; mp4= "20"}
                    [PSCustomObject]@{"day" = 3; jpg = "30"; mp4= "10"}
                )

                $data | Out-UDGridData 
            } -PageSize 5
        }

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
        Start-Sleep 4

        It "should not page when NoPaging set" {
            $Element = Find-SeElement -Id "NoPagingGrid" -Driver $Driver
            $Element = Find-SeElement -ClassName "griddle-row" -Driver $Element[0] 
            $Element.Length | Should be 18
        }

        It "should set page size" {
            $Element = Find-SeElement -Id "PageSizeGrid" -Driver $Driver
            $Element = Find-SeElement -ClassName "griddle-row" -Driver $Element[0] 
            $Element.Length | Should be 5
        }

        It "should headings" {
            $Element = Find-SeElement -Id "Grid" -Driver $Driver
            $Element = Find-SeElement -ClassName "griddle-table-heading-cell" -Driver $Element[0]
            $Element.Length | Should be 3
            $Element[0].Text.Contains('day') | should be $true
            $Element[1].Text | should be "jpg"
            $Element[2].Text | should be "mp4"
        }

        It "should have data" {
            $Element = Find-SeElement -ClassName "griddle-row" -Driver $Driver
            $Element = Find-SeElement -ClassName "griddle-cell" -Driver $Element[0] 
            $Element.Length | Should be 3
            $Element[0].Text | should be "1"
            $Element[1].Text | should be "10"
            $Element[2].Text | should be "30"
        }

        It "should sort data" {
            
            $Row = Find-SeElement -ClassName "griddle-row" -Driver $Driver
            $Element = Find-SeElement -ClassName "griddle-cell" -Driver $Row[0] 
            $Element[0].Text | should be "1"
            $Element = Find-SeElement -ClassName "griddle-cell" -Driver $Row[1] 
            $Element[0].Text | should be "1"

            $Element = Find-SeElement -ClassName "griddle-table-heading-cell" -Driver $Driver
            $header = $element[0]
            Invoke-SeClick $header

            $Row = Find-SeElement -ClassName "griddle-row" -Driver $Driver
            $Element = Find-SeElement -ClassName "griddle-cell" -Driver $Row[0] 
            $Element[0].Text | should be "3"
            $Element = Find-SeElement -ClassName "griddle-cell" -Driver $Row[1] 
            $Element[0].Text | should be "3"
            
            $Element = Find-SeElement -ClassName "griddle-table-heading-cell" -Driver $Driver
            $header = $element[0]
            Invoke-SeClick $header

            $Row = Find-SeElement -ClassName "griddle-row" -Driver $Driver
            $Element = Find-SeElement -ClassName "griddle-cell" -Driver $Row[0] 
            $Element[0].Text | should be "1"
            $Element = Find-SeElement -ClassName "griddle-cell" -Driver $Row[1] 
            $Element[0].Text | should be "1"
        }

        It "should have data in single item grid" {
            $Element = Find-SeElement -Id "SingleItemGrid" -Driver $Driver
            $Element = Find-SeElement -ClassName "griddle-cell" -Driver $Element[0] 
            $Element.Length | Should be 3
            $Element[0].Text | should be "1"
            $Element[1].Text | should be "10"
            $Element[2].Text | should be "30"
        }

        It "should filter data" {
            
            $Element = Find-SeElement -ClassName "griddle-filter" -Driver $Driver

            Send-SeKeys -Element $Element[0] -Keys "2"
            Sleep 1
            Send-SeKeys -Element $Element[0] -Keys "0"

            Sleep 1

            $Element = Find-SeElement -Id "Grid" -Driver $Driver
            $Element = Find-SeElement -ClassName "griddle-row" -Driver $Element[0]
            $Element.Length | Should be 6
        }

       Stop-SeDriver $Driver
       Stop-UDDashboard -Server $Server 
    }


    
    Context "default sort" {
        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDGrid -Title "Grid" -Id "Grid" -Headers @("day", "jpg", "mp4")  -Properties @("day", "jpg", "mp4") -DefaultSortColumn "jpg" -DefaultSortDescending -EndPoint {
                $data = @(
                    [PSCustomObject]@{"day" = 1; jpg = "10"; mp4= (New-UDLink -Text "This is text" -Url "http://www.google.com")}
                    [PSCustomObject]@{"day" = 2; jpg = "20"; mp4= "200"}
                    [PSCustomObject]@{"day" = 3; jpg = "30"; mp4= "10"}
                )

                $data | Out-UDGridData 
            } -Links @(
                (New-UDLink -Text "Other link" -Url "http://www.google.com")
            )
        }

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
        Start-Sleep 2

        It "should have sorted correctly" {
            $Element = Find-SeElement -ClassName "griddle-row" -Driver $Driver
            $Element = Find-SeElement -ClassName "griddle-cell" -Driver $Element[0] 
            $Element[1].Text | should be "30"
            
            $Element = Find-SeElement -ClassName "griddle-row" -Driver $Driver
            $Element = Find-SeElement -ClassName "griddle-cell" -Driver $Element[1] 
            $Element[1].Text | should be "20"
        }


        Stop-SeDriver $Driver
        Stop-UDDashboard -Server $Server 
    }

    Context "refresh" {
        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDGrid -Title "Grid" -Id "Grid" -Headers @("hour", "minute", "second")  -Properties @("hour", "minute", "second") -RefreshInterval 1 -AutoRefresh -DefaultSortColumn "jpg" -DefaultSortDescending -EndPoint {
                $data = @(
                    [PSCustomObject]@{"hour" = [DateTime]::Now.Hour; "minute" = [DateTime]::Now.Minute; "second" = [DateTime]::Now.Second;}
                )

                $data | Out-UDGridData 
            } 
        }

        $Server = Start-UDDashboard -Port 10001 -Dashboard $dashboard 
        $Driver = Start-SeFirefox
        Enter-SeUrl -Driver $Driver -Url "http://localhost:$BrowserPort"
        Start-Sleep 2

        It "should have sorted correctly" {
            $previousText = ""

            1..10 | % {
                Start-Sleep 2

                $Element = Find-SeElement -ClassName "griddle-row" -Driver $Driver
                $Element = Find-SeElement -ClassName "griddle-cell" -Driver $Element[0] 
                $text = $Element[2].Text

                $previousText | Should not be $text

                $previousText = $text
            }            
        }

        Stop-SeDriver $Driver
        Stop-UDDashboard -Server $Server 
    }
}