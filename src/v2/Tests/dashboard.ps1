$DebugPreference = 'Continue'
$Cache:StateCollection = New-Object -TypeName 'System.Collections.Concurrent.BlockingCollection[object]'

New-UDEndpoint -Id 'testdata' -Endpoint {
    $Data = $null
    if ($Cache:StateCollection.TryTake([ref]$Data, 5000)) {
        $Data | ConvertTo-Json
    } 
    else {
        throw "Retreiving data timed out (5000ms)."
    }
} | Out-Null

function Set-TestData {
    param($Data)

    $Cache:StateCollection.Add($Data)
}

$Pages = @()

$Pages += New-UDPage -Name Button -Content {
    New-UDButton -Text "Click Me" -Id "button1"
    New-UDButton -Text "Click Me" -Id "button2" -Floating
    New-UDButton -Text "Click Me" -Id "button3" -Flat
    New-UDButton -Text "Click Me" -Id "button4" -Flat
    New-UDButton -Text "Click Me" -Id "button5" -OnClick {
        Set-TestData -Data $true
    }
    New-UDButton -Text "Click Me" -Id button6 -Icon user -IconAlignment right
    New-UDButton -Text "Click Me" -Id button7 -BackgroundColor red -FontColor black
}

$Pages += New-UDPage -Name Card -Content {
    New-UDCard -Title "Test" -Text "My text" -Id "Card" -Links @(
        New-UDLink -Text "My Link" -Url "http://www.google.com"
    )

    New-UDCard -Title "ÆØÅ" -Text "Test" -Id "nordic"

    New-UDCard -Title "Test" -Id "EndpointCard" -Endpoint {
        New-UDElement -Tag "div" -Content { "Endpoint Content" } 
    }

    New-UDCard -Title "Test" -Id "NoTextCard"

    New-UDCard -Title "Test" -Text "My text`r`nNew Line" -Id "MultiLineCard"

    New-UDCard -Title "Test" -Text "Small Text" -Id "Card-Small-Text" -TextSize Small

    New-UDCard -Title "Test" -Text "Medium Text" -Id "Card-Medium-Text" -TextSize Medium

    New-UDCard -Title "Test" -Text "Large Text" -Id "Card-Large-Text" -TextSize Large

    New-UDCard -Title "Test" -Content {
        New-UDElement -Tag "span" -Attributes @{id = "spanTest"} -Content {
            "This is some custom content"
        }
    }

    New-UDCard -Title "Test" -Text "Text" -Id "Card-Watermark" -Watermark address_book
}

$Pages += New-UDPage -Name 'Monitor' -Content {
    New-UDMonitor -Title "DatagramsPersec" -Type Line -Width 20vw -Height 22vw -DataPointHistory 200 -RefreshInterval 1 -Endpoint {
        Get-Random | Out-UDMonitorData
      } -Options @{
          scales = @{
            yAxes = @(
              @{
                ticks = @{
                  beginAtZero = $true
                  min = 0
                  max = [int]::MaxValue
                }
              }
            )
            xAxes = @(
              @{
                display = $false
              }
            )
          }
          legend = @{
            display = $false
          }
        }
}

$Pages += New-UDPage -Name 'Checkbox' -Content {
    New-UDCheckbox -Id 'Test1' -Label 'Check me' -Checked 
    New-UDCheckbox -Id 'Test2' -Label 'Check me' -Disabled 
    New-UDCheckbox -Id 'Test3' -Label 'Check me' -FilledIn 
    New-UDCheckbox -Id "Test4" -Label "Check me" -OnChange {
        Set-TestData -Data $EventData
    }
    New-UDCheckbox -Id "Test5" -Label "Check me" 

    New-UDElement -Tag div -Id 'Result' -Endpoint {
        try {
            New-UDElement -Tag div -Content { (Get-UDElement -Id 'Test5').Attributes['checked'].ToString() }
        }
        catch {

        }
    } -AutoRefresh -RefreshInterval 1
}

$Pages += New-UDPage -Name 'Collapsible' -Content {
    New-UDCollapsible -Id "Collapsible" -Items {
        New-UDCollapsibleItem -Id "First" -Title "FirstHeader" -Icon user -Content {
            New-UDCard -Title "FirstBody"
        } -Active
        New-UDCollapsibleItem -Id "Second" -Title "Second" -Icon user -Content {
            New-UDCard -Title "Second"
        }
        New-UDCollapsibleItem -Id "Third" -Title "Third" -Icon user -Content {
            New-UDCard -Title "Third"
        }
    }

    New-UDCollapsible -Id "Collapsible2" -BackgroundColor "#4945FF" -FontColor "#A938FF" -Items {
        New-UDCollapsibleItem -Id "First-Endpoint" -Title "First" -Icon user -Endpoint {
            New-UDCard -Title "Endpoint"
        } -Active

        New-UDCollapsibleItem -Id "Collapsible2-Second" -Title "Second" -BackgroundColor "#4CFF6E" -FontColor "#98FF3F" -Icon user -Content  {
            New-UDCard -Title "Third"
        } 
    }

    New-UDCollapsible -Id "Collapsible with changing icon" -BackgroundColor "#4945FF" -FontColor "#A938FF" -Items {
        New-UDCollapsibleItem -Id "ChangeMyIcon" -Title "First" -Icon user -Content {
            New-UDCard -Title "Endpoint"

            New-UDButton -Text "Change Icon" -Id "changeIcon" -OnClick {
                Set-UDElement -Id "ChangeMyIcon-icon" -Attributes @{
                    className = 'fa fa-user'
                }
            }

        } -Active
    }
}

$Pages += New-UDPage -Name 'Collection' -Content {
    New-UDCollection -Header "Header" -Content {}
}

$Pages += New-UDPage -Name 'Column' -Content {
    New-UDColumn -SmallSize 12
    New-UDColumn -MediumSize 12
    New-UDColumn -LargeSize 12
    New-UDColumn -SmallOffset 6
    New-UDColumn -MediumOffset 6
    New-UDColumn -LargeOffset 6
    New-UDColumn -Size 12
    New-UDColumn -Id "myCol"
    New-UDColumn -Content {
        New-UDCard -Id "card"
    }
    New-UDColumn -Endpoint {
        New-UDCard -Id "card2"
    }
}

$Pages += New-UDPage -Name 'Error' -Content {
    throw "Exception"
}

$Pages += New-UDPage -Name 'Fab' -Content {
    New-UdFab -Id "main" -Icon "plus" -Size "large" -ButtonColor "red" -onClick {
        Set-TestData -Data "parent"
        Show-UDToast -Message "Parent"
    } -Content {
        New-UDFabButton -ButtonColor "green" -Icon "edit" -size "small"
        New-UDFabButton -Id "btn" -ButtonColor "yellow" -Icon "trash" -size "large" -onClick {
            Set-TestData -Data "child"
            Show-UDToast -Message "Child"
        }
    }
}

$Pages += New-UDPage -Name 'Grid' -Content {
    $Cache:refreshdata = @(
        [PSCustomObject]@{"day" = 1; jpg = "10"; mp4= "30"}
        [PSCustomObject]@{"day" = 2; jpg = "20"; mp4= "20"}
    )

    New-UDGrid -Title "Grid" -Id "RefreshGrid" -Headers @("day", "jpg", "mp4")  -Properties @("day", "jpg", "mp4") -EndPoint {
        $data = $Cache:refreshdata
        $data | Out-UDGridData 
    }

    New-UDGrid -Title "Grid" -Id "AGrid" -Headers @("day", "jpg", "mp4")  -Properties @("day", "jpg", "mp4") -EndPoint {
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

    New-UDGrid -Title "ServerSideGrid" -Id "ServerSideGrid" -Headers @("day", "jpg", "mp4") -Properties @("day", "jpg", "mp4") -ServerSideProcessing -DefaultSortColumn "day" -EndPoint {
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

    New-UDGrid -Title "Grid" -Id "RefreshFilterGrid" -RefreshInterval 5 -AutoRefresh -DefaultSortColumn "jpg" -DefaultSortDescending -EndPoint {
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

    New-UDGrid -Title "Grid" -Id "SimpleGrid" -Endpoint {
        $data = @(
            [PSCustomObject]@{"day" = 1; jpg = $Variable; mp4= (New-UDLink -Text "This is text" -Url "http://www.google.com")}
            [PSCustomObject]@{"day" = 2; jpg = "20"; mp4= (Get-Date -Day 2 -Month 12 -Year 2007)}
            [PSCustomObject]@{"day" = 3; jpg = $true; mp4= (New-UDButton -Text "Hey" -OnClick{ Set-UDElement -Id "Hey" -Content {"Hey"}})}
            [PSCustomObject]@{"day" = 3; jpg = $true; mp4= (New-UDIcon -Icon check -Color Green)}
        )

        $data | Out-UDGridData 
    } 

    
    $Variable = "Test"

    New-UDGrid -Title "Grid" -Id "CustomGrid" -Headers @("day", "jpg", "mp4")  -Properties @("day", "jpg", "mp4") -EndPoint {
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

    New-UDGrid -Title "Grid" -Id "Grid1" -Headers @("hour", "minute", "second")  -Properties @("hour", "minute", "second") -RefreshInterval 1 -AutoRefresh -DefaultSortColumn "jpg" -DefaultSortDescending -EndPoint {
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

    New-UDGrid -Title "Grid" -Id "ThrowGrid" -Headers @("hour", "minute", "second")  -Properties @("hour", "minute", "second") -DefaultSortColumn "jpg" -DefaultSortDescending -EndPoint {
        try {
            throw "WTF"
            $data = @()
        }
        catch {

        }

        $data | Out-UDGridData 
    } 

    New-UDGrid -Title "Grid" -Id "DefaultSortGrid" -Headers @("day", "jpg", "mp4")  -Properties @("day", "jpg", "mp4") -DefaultSortColumn "jpg" -DefaultSortDescending -EndPoint {
        $data = @(
            [PSCustomObject]@{"day" = 1; jpg = "10"; mp4= (New-UDLink -Text "This is text" -Url "http://www.google.com")}
            [PSCustomObject]@{"day" = 2; jpg = "20"; mp4= "200"}
            [PSCustomObject]@{"day" = 3; jpg = "30"; mp4= "10"}
        )

        $data | Out-UDGridData 
    } -Links @(
        (New-UDLink -Text "Other link" -Url "http://www.google.com")
    )

    New-UDGrid -Title "Grid" -Id "RefreshGrid2" -Headers @("hour", "minute", "second")  -Properties @("hour", "minute", "second") -RefreshInterval 1 -AutoRefresh -DefaultSortColumn "jpg" -DefaultSortDescending -EndPoint {
        $data = @(
            [PSCustomObject]@{"hour" = [DateTime]::Now.Hour; "minute" = [DateTime]::Now.Minute; "second" = [DateTime]::Now.Second;}
        )

        $data | Out-UDGridData 
    } 
}

$Pages += New-UDPage -Name "Image Carousel" -Content {
    <#
    $FirstSlide = @{
        backgroundRepeat = 'no-repeat'
        BackgroundImage = 'https://stmed.net/sites/default/files/lady-deadpool-wallpapers-27626-5413437.jpg'
        BackgroundColor  = 'transparent'
        BackgroundSize = 'cover'
        BackgroundPosition = '0% 0%'
        Url  = 'https://universaldashboard.io/'
    }
    $SecondSlide = @{
        BackgroundColor  = 'transparent'
        BackgroundSize = 'cover'
        BackgroundPosition = '0% 0%'
        Url  = 'images/thor_-ragnarok-wallpapers-30137-2449291.jpg'
        BackgroundImage  = 'images/thor_-ragnarok-wallpapers-30137-2449291.jpg'
    }
    $ThirdSlide = @{
        BackgroundColor  = 'transparent'
        BackgroundSize = 'cover'
        BackgroundPosition = '0% 0%'
        Url  = 'https://stmed.net/sites/default/files/ultimate-spider-man-wallpapers-27724-2035627.jpg'
        BackgroundImage  = 'https://stmed.net/sites/default/files/ultimate-spider-man-wallpapers-27724-2035627.jpg'
    }
    New-UDImageCarousel -Id 'carousel-demo' -Items {
        New-UDImageCarouselItem @FirstSlide
        New-UDImageCarouselItem @SecondSlide
        New-UDImageCarouselItem @ThirdSlide
    }  -Height 750 -FullWidth -ShowIndicators -Speed 8000
#>
}

$Pages += New-UDPage -Name 'Input1' -Endpoint {
    New-UDInput -Title "Simple Form" -Id "Form1" -Content {
        New-UDInputField -Name 'checkbox' -Type 'checkbox'
        New-UDInputField -Name 'textbox' -Type 'textbox'
    } -Endpoint {
        param($checkbox, $textbox)

        Set-TestData -Data @{
            checkbox = $checkbox.GetType().Name
            textbox = $textbox.GetType().Name 
        }
    }
}

$Pages += New-UDPage -Name 'Input2' -Endpoint {
    New-UDInput -Title "Simple Form" -Id "Form2" -Endpoint {
        New-UDInputAction -Content { New-UDElement -Tag 'div' -Id 'hello' }
    }
}

$Pages += New-UDPage -Name 'Input3' -Endpoint {
    New-UDInput -Title "Simple Form" -Id "Form3" -Content {
        New-UDInputField -Type 'textbox' -Name 'test' -Placeholder 'Test testbox' -DefaultValue "Test"
        New-UDInputField -Type 'checkbox' -Name 'test2' -Placeholder 'checkbox'
        New-UDInputField -Type 'select' -Name 'test3' -Placeholder 'select' -Values @("Test", "Test2", "Test3") -DefaultValue "Test"
        New-UDInputField -Type 'radioButtons' -Name 'test4' -Values @("MyTestValue", "MyTestValue2", "MyTestValue3")

        New-UDInputField -Type 'password' -Name 'test5' -Placeholder 'Password'
        New-UDInputField -Type 'textarea' -Name 'test6' -Placeholder 'Big Box o Text'
        New-UDInputField -Type 'switch' -Name 'test7' -Placeholder @("Yes", "No")
        New-UDInputField -Type 'select' -Name 'test8' -Placeholder 'select2'
        New-UDInputField -Type 'date' -Name 'test9' -Placeholder 'My Time' 
        New-UDInputField -Type 'time' -Name 'test10' -Placeholder 'My Date' 
        New-UDInputField -Type 'radioButtons' -Name 'test11' -Values @("1", "2", "3")
    } -Endpoint {
        param($Test, $Test2, $Test3, $Test4, $Test5, $Test6, $Test7, $Test8, $Test9, $Test10, $test11)

        Set-TestData @{
            test = $test
            test2 = $test2 
            test3 = $test3
            test4 = $test4
            test5 = $test5
            test6 = $test6
            test7 = $test7
            test8 = $test8
            test9 = $test9
            test10 = $test10
            test11 = $test11
        } 
    } 

}

$Pages += New-UDPage -Name 'Input4' -Content {
    New-UDInput -Title "Simple Form" -Id "Form4" -Endpoint {
        param(
            [Parameter(HelpMessage = "My Textbox")][string]$Textbox, 
            [Parameter(HelpMessage = "My Checkbox")][bool]$Checkbox, 
            [Switch]$Checkbox2, 
            [Parameter(HelpMessage = "Day of the week")]
            [System.DayOfWeek]$DayOfWeek,
            [Parameter(HelpMessage = "Favorite Fruit")]
            [ValidateSet("Banana", "Apple", "Grape")]$Fruit,
            [Parameter()]
            [System.Security.SecureString]$SecureString,
            [Parameter()]
            [String[]]$ArrayOfStrings)

        Set-TestData @{
            Textbox = $Textbox
            Checkbox = $Checkbox 
            Checkbox2= [bool]$Checkbox2
            DayOfWeek = $DayOfWeek
            Vals = $Vals
            SecureString = $SecureString
            Strings = $ArrayOfStrings
        } 
    }
}

$Pages += New-UDPage -Name "Layout" -Content {
    New-UDElement -Tag 'div' -Id layout1 -Content {
        New-UDLayout -Columns 3 -Content {
            New-UDCard -Title "Test" -Content {}
            New-UDCard -Title "Test" -Content {}
            New-UDCard -Title "Test" -Content {}
            New-UDCard -Title "Test" -Content {}
        }
    }
}

$Pages += New-UDPage -Name "Link" -Content {
    New-UDLink -Text "hi" -Id 'link' -OnClick {
        Set-TestData -Data "Clicked"
    }
}

$Pages += New-UDPage -Name "Modal" -Content {
    New-UDButton -Text "Show" -Id 'buttonShow' -OnClick {
        Show-UDModal -Content {
            New-UDElement -Tag 'div' -Id 'modal-content1'
        }
    }

    New-UDButton -Text "Show" -Id 'button2' -OnClick {
        Show-UDModal -Content {
            New-UDElement -Tag 'div' -Id 'modal-content2'
            New-UDButton -OnClick { Hide-UDModal } -Text "Hide" -Id 'hide'
        }
    }

    New-UDButton -Text "Click" -Id "Click" -OnClick {
        Show-UDModal -Header {
            New-UDHeading -Size 4 -Text "Heading" -Id "Heading"
        } -Content {
            New-UDButton -Text "Press me" -Id "Close" -OnClick {
                Hide-UDModal
            }
        } 
    }
}

$Pages += New-UDPage -Name 'Toast' -Content {
    New-UDButton -Id 'button' -OnClick {
        Show-UDToast -Message 'hello' -Icon 'user' -Duration 5000
    }
}

$Pages += New-UDPage -Name "Preloader" -Content {
    New-UDPreloader
}

$Pages += New-UDPage -Name "Radio" -Content {
    New-UDRadio -Group '1' -Id 'first'
    New-UDRadio -Group '1' -Id 'second'
    New-UDRadio -Group '1' -Id 'third'

    New-UDRadio -Group '2' -Id 'first2' -onChange { Set-TestData -Data $true }
    New-UDRadio -Group '2' -Id 'second2'
    New-UDRadio -Group '2' -Id 'third2'

    New-UDRadio -Group '3' -Id 'first3' -Checked
    New-UDRadio -Group '3' -Id 'second3'
    New-UDRadio -Group '3' -Id 'third3'

    New-UDRadio -Group '4' -Id 'first4' -Disabled
    New-UDRadio -Group '4' -Id 'second4'
    New-UDRadio -Group '4' -Id 'third4'
}

$Pages += New-UDPage -Name "Row" -Content {
    New-UDRow -Columns {
        New-UDColumn -Content {
            New-UDElement -Id "hi" -Tag "div"
        }
    }

    New-UDRow -Endpoint {
        New-UDColumn -Content {
            New-UDElement -Id "hi2" -Tag "div"
        }
    }

    New-UDRow -Id 'MyRow' -Columns {
        New-UDColumn -Content {
            New-UDElement -Id 'content' -Tag "div"
        }
    }
}

$Pages += New-UDPage -Name "Select" -Content {
    New-UDElement -Tag 'div' -Id 'largeSelectTest' -Content {
        New-UDButton -Text "Button" -Id 'btn1' -OnClick {
            $Value = (Get-UDElement -Id 'test').Attributes['value'] 
    
            Set-TestData -Data $Value
        }
    
        New-UDGrid -Title "" -Endpoint {
            @([PSCustomObject]@{
                Name = New-UDSelect -Label "Test" -Id 'largeSelect' -Option {
                    1..150 | ForEach-Object {
                        New-UDSelectOption -Name "Test $_" -Value "$_"
                    }
                } -OnChange {
                    Set-TestData -Data $EventData
                }
            }) | Out-UDGridData
        }
    }

    New-UDElement -Tag 'div' -Id 'onSelectTest' -Content {
        New-UDButton -Text "Button" -Id 'btn2' -OnClick {
            $Value = (Get-UDElement -Id 'test').Attributes['value'] 
    
            Set-TestData -Data $Value
        }
    
        New-UDSelect -Label "Test" -Id 'onSelectSelect' -Option {
            New-UDSelectOption -Nam "Test 1" -Value "1"
            New-UDSelectOption -Nam "Test 2" -Value "2"
            New-UDSelectOption -Nam "Test 3" -Value "3"
        } -OnChange {
            Set-TestData -Data $EventData
        }
    }

    New-UDElement -Tag 'div' -Id 'getElementTest' -Content {
        New-UDButton -Text "Button" -Id 'btn3' -OnClick {
            $Value = (Get-UDElement -Id 'test').Attributes['value'] 
    
            Set-TestData -Data $Value
        }
    
        New-UDSelect -Label "Test" -Id 'getElementSelect' -Option {
            New-UDSelectOption -Nam "Test 1" -Value "1"
            New-UDSelectOption -Nam "Test 2" -Value "2"
            New-UDSelectOption -Nam "Test 3" -Value "3"
        }
    }    
}

$Pages += New-UDPage -Name "Switch" -Content {
    New-UDSwitch -On -Id 'switch1'
    New-UDSwitch -Id 'switch2' -Disabled
    New-UDSwitch -Id 'switch3' -OnChange {
        Set-TestData -Data $true
    }
}

$Pages += New-UDPage -Name "Tabs" -Content {
    New-UDTabContainer -Tabs {
        New-UDTab -Text "Tab1" -Content { New-UDCard -Title "Hi" -Content {} }
        New-UDTab -Text "Tab2" -Content { New-UDCard -Title "Hi2" -Content {} }
    }
}

$Pages += New-UDPage -Name "SingleItem" -Content {
    New-UDParagraph -Text "Stuff"
}

$Footer = New-UDFooter -Copyright "Test" -Links @(
    New-UDLink -Text "test"
    New-UDLink -Text "test2"
) 

$Navigation = New-UDSideNav -Content {
    New-UDSideNavItem -Text "Text" -Url "/Button" -Id 'sideNav1'
    New-UDSideNavItem -Text "testpage" -PageName "testpage" -icon home -id 'sideNav4'
    New-UDSideNavItem -Text "Text2" -Id 'sideNav2' -Children {
        New-UDSideNavItem -Text "Text3" -Url "/Button" -Id 'sideNav3'
    } 
}

New-UDDashboard -Title 'Test' -Pages $Pages -Footer $Footer -Navigation $Navigation