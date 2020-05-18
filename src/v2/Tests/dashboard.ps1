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

}

New-UDDashboard -Title 'Test' -Pages $Pages