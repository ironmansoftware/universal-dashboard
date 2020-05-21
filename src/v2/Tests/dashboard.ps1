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
    New-UDButton -Text "Click Me" -Id button6 -Icon user
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

New-UDDashboard -Title 'Test' -Pages $Pages