Describe "Grid" {

    
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

                $data | Sort-Object -Property day | Out-UDGridData 
            } -PageSize 5
        }

        Set-TestDashboard -Dashboard $dashboard

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
            
            $Element = Find-SeElement -ClassName "griddle-table-heading-cell" -Driver $Driver
            $header = $element[0]
            Invoke-SeClick $header

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
            Start-Sleep 1
            Send-SeKeys -Element $Element[0] -Keys "0"

            $Element = Find-SeElement -Id "Grid" -Driver $Driver
            $Element = Find-SeElement -ClassName "griddle-row" -Driver $Element[0]
            $Element.Length | Should be 6

            $pagination  = Find-SeElement -ClassName "pagination" -Driver $Driver | Select-Object -First 1
            $pagination.FindElementsByTagName('li').Count | should be 0
        }
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

        Set-TestDashboard -Dashboard $dashboard

        It "should page data" {

            $Element = Find-SeElement -ClassName "page-right" -Driver $Driver
            Invoke-SeClick -Element $Element -JavaScriptClick -Driver $Driver

            Start-Sleep 1

            $Row = Find-SeElement -ClassName "griddle-row" -Driver $Driver
            $Element = Find-SeElement -ClassName "griddle-cell" -Driver $Row[7] 
            $Element[0].Text | should be "3"
        }

        It "should have data" {

            $Driver.Navigate().Refresh()

            Start-Sleep 1

            $Element = Find-SeElement -ClassName "griddle-row" -Driver $Driver
            $Element = Find-SeElement -ClassName "griddle-cell" -Driver $Element[0] 
            $Element.Length | Should be 3
            $Element[0].Text | should be "1"
            $Element[1].Text | should be "10"
            $Element[2].Text | should be "30"
        }

        It "should sort data" {

            $Driver.Navigate().Refresh()
            
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

        It "should filter data" {

            $Driver.Navigate().Refresh()
            
            $Element = Find-SeElement -ClassName "griddle-filter" -Driver $Driver

            Send-SeKeys -Element $Element[0] -Keys "2"
            Sleep 1
            Send-SeKeys -Element $Element[0] -Keys "0"

            $Element = Find-SeElement -ClassName "griddle-row" -Driver $Driver
            $Element.Length | Should be 6
        }
    }

    

    Context "refresh doesnt reset filter" {
        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDGrid -Title "Grid" -Id "Grid" -RefreshInterval 5 -AutoRefresh -DefaultSortColumn "jpg" -DefaultSortDescending -EndPoint {
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
        }

        Set-TestDashboard -Dashboard $dashboard

        It "should refresh" {
            $Element = Find-SeElement -ClassName "griddle-filter" -Driver $Driver

            Send-SeKeys -Element $Element[0] -Keys "2"
            Start-Sleep 1
            Send-SeKeys -Element $Element[0] -Keys "0"

            $Element = Find-SeElement -ClassName "griddle-row" -Driver $Driver
            $Element.Length | Should be 6

            Start-Sleep 5 

            $Element = Find-SeElement -ClassName "griddle-row" -Driver $Driver
            $Element.Length | Should be 6    
        }
    }    

    Context "simple grid" {
        $dashboard = New-UDDashboard -Title "Test" -Content {
            New-UDGrid -Title "Grid" -Id "Grid" -Endpoint {
                $data = @(
                    [PSCustomObject]@{"day" = 1; jpg = $Variable; mp4= (New-UDLink -Text "This is text" -Url "http://www.google.com")}
                    [PSCustomObject]@{"day" = 2; jpg = "20"; mp4= (Get-Date -Day 2 -Month 12 -Year 2007)}
                    [PSCustomObject]@{"day" = 3; jpg = $true; mp4= (New-UDButton -Text "Hey" -OnClick{ Set-UDElement -Id "Hey" -Content {"Hey"}})}
                    [PSCustomObject]@{"day" = 3; jpg = $true; mp4= (New-UDIcon -Icon check -Color Green)}
                )

                $data | Out-UDGridData 
            } 
        }

        Set-TestDashboard -Dashboard $dashboard

        It "should have link" {
            Find-SeElement -LinkText "This is text" -Driver $Driver | Should not be $null
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
    }

    Context "Custom Columns" {
        $dashboard = New-UDDashboard -Title "Test" -Content {

            $Variable = "Test"

            New-UDGrid -Title "Grid" -Id "Grid" -Headers @("day", "jpg", "mp4")  -Properties @("day", "jpg", "mp4") -EndPoint {
                $data = @(
                    [PSCustomObject]@{"day" = 1; jpg = $Variable; mp4= (New-UDLink -Text "This is text" -Url "http://www.google.com")}
                    [PSCustomObject]@{"day" = 2; jpg = "20"; mp4= (Get-Date -Day 2 -Month 12 -Year 2007)}
                    [PSCustomObject]@{"day" = 3; jpg = $true; mp4= (New-UDButton -Id button -Text "Hey" -OnClick{ Set-UDElement -Id "Hey" -Content {"Hey"}})}
                    [PSCustomObject]@{"day" = 3; jpg = $true; mp4= (New-UDIcon -Icon check -Color Green)}
                )

                $data | Out-UDGridData 
            } -Links @(
                (New-UDLink -Text "Other link" -Url "http://www.google.com")
            )
            New-UDElement -Id "Hey" -Tag "div"
        }

        Set-TestDashboard -Dashboard $dashboard

        It "should click button" {
            $Button = Find-SeElement -Id "button" -Driver $Driver 
            Invoke-SeClick -Element $Button 

            Start-Sleep -Seconds 5

            (Find-SeElement -Id "Hey" -Driver $Driver).Text | should be "Hey"
        }


        It "should have link" {
            Find-SeElement -LinkText "This is text" -Driver $Driver | Should not be $null
        }

        It "should have link in footer" {
            Find-SeElement -LinkText "OTHER LINK" -Driver $Driver | Should not be $null
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
    }

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

            New-UDGrid -Title "Service Grid with filter" -Id "Grid3" -Headers @("Name", "DisplayName", "Status") -Properties @("Name", "DisplayName", "Status") -Endpoint {
                [PSCustomObject]@{
                    Name = "bits"
                    DisplayName = "bits"
                    Status = "Stopped"
                }  | Select Name, DisplayName,
                @{
                    Name       = "Status"
                    Expression = {New-UDElement -Id "nested-element" -Tag div -Attributes @{ className = "red white-text" } -Content { $_.status.tostring() }}
                } | Out-UDGridData
            } 
        }

        Set-TestDashboard -Dashboard $dashboard

        It "should not shown an error with no data" {
            $Element = Find-SeElement -Id "Grid" -Driver $Driver

            Start-Sleep 2

            $Element.Text.Contains("No results found") | Should be $true
        }

        It "should not shown an error with invalid output" {
            $Element = Find-SeElement -Id "Grid2" -Driver $Driver

            Start-Sleep 2

            $Element.Text.Contains("No results found") | Should be $true
        }

        It "should be able to nest new-udelement in grid" {
            $Element = Find-SeElement -Id "nested-element" -Driver $Driver

            Start-Sleep 2

            $Element.Text.Contains("Stopped") | Should be $true
        }
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

        Set-TestDashboard -Dashboard $dashboard
 
        It "should not shown an error with no data" {
            $Element = Find-SeElement -Id "Grid" -Driver $Driver

            Start-Sleep 1

            $Element.Text.Contains("No results found") | Should be $true
        }
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

        Set-TestDashboard -Dashboard $dashboard

        It "should have sorted correctly" {
            $Element = Find-SeElement -ClassName "griddle-row" -Driver $Driver
            $Element = Find-SeElement -ClassName "griddle-cell" -Driver $Element[0] 
            $Element[1].Text | should be "30"
            
            $Element = Find-SeElement -ClassName "griddle-row" -Driver $Driver
            $Element = Find-SeElement -ClassName "griddle-cell" -Driver $Element[1] 
            $Element[1].Text | should be "20"
        }
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

        Set-TestDashboard -Dashboard $dashboard

        It "should refresh" {
            $previousText = ""

            $Element = Find-SeElement -ClassName "griddle-row" -Driver $Driver
            $Element = Find-SeElement -ClassName "griddle-cell" -Driver $Element[0] 
            $text = $Element[2].text 

            Start-Sleep 3

            $NewElement = Find-SeElement -ClassName "griddle-row" -Driver $Driver
            (Find-SeElement -ClassName "griddle-cell" -Driver $NewElement[0])[2].Text | should not be $text     
        }

        
    }    


}