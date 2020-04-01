New-ComponentPage -Title 'Nivo' -Description 'Nivo chart library' -Content {
    New-Example -Title 'Colors' -Description 'Nivo comes with numerous color palettes out of the box. You can select one of the color palettes by name using the -Colors property.' -Example {
        $Data = @(
            @{
                country = 'USA'
                burgers = (Get-Random -Minimum 10 -Maximum 100)
                fries = (Get-Random -Minimum 10 -Maximum 100)
                sandwich = (Get-Random -Minimum 10 -Maximum 100)
            }
            @{
                country = 'Germany'
                burgers = (Get-Random -Minimum 10 -Maximum 100)
                fries = (Get-Random -Minimum 10 -Maximum 100)
                sandwich = (Get-Random -Minimum 10 -Maximum 100)
            }
            @{
                country = 'Japan'
                burgers = (Get-Random -Minimum 10 -Maximum 100)
                fries = (Get-Random -Minimum 10 -Maximum 100)
                sandwich = (Get-Random -Minimum 10 -Maximum 100)
            }
        )
        New-UDNivoChart -Colors 'dark2' -Bar -Data $Data -Height 400 -Width 900 -Keys @('burgers', 'fries', 'sandwich')  -IndexBy 'country'
    }

    New-Example -Title 'Auto Refresh' -Description 'Nivo charts support auto refresh through the New-UDDyanmic cmdlet.' -Example {
        New-UDDynamic -Content {
            $Data = 1..10 | ForEach-Object { 
                $item = Get-Random -Max 1000 
                [PSCustomObject]@{
                    Name = "Test$item"
                    Value = $item
                }
            }
            New-UDNivoChart -Id 'autoRefreshingNivoBar' -Bar -Keys "Value" -IndexBy 'name' -Data $Data -Height 500 -Width 1000
        } -AutoRefresh
    }

    New-Example -Title 'Patterns' -Description 'You can also define patterns to use with your charts. You can use lines, dots or squares to provide extra emphasis to particular vectors of a series.' -Example {
        $Data = @(
            @{
                country = 'USA'
                burgers = (Get-Random -Minimum 10 -Maximum 100)
                fries = (Get-Random -Minimum 10 -Maximum 100)
                sandwich = (Get-Random -Minimum 10 -Maximum 100)
            }
            @{
                country = 'Germany'
                burgers = (Get-Random -Minimum 10 -Maximum 100)
                fries = (Get-Random -Minimum 10 -Maximum 100)
                sandwich = (Get-Random -Minimum 10 -Maximum 100)
            }
            @{
                country = 'Japan'
                burgers = (Get-Random -Minimum 10 -Maximum 100)
                fries = (Get-Random -Minimum 10 -Maximum 100)
                sandwich = (Get-Random -Minimum 10 -Maximum 100)
            }
        )
        
        $Pattern = New-UDNivoPattern -Dots -Id 'dots' -Background "inherit" -Color "#38bcb2" -Size 4 -Padding 1 -Stagger
        $Fill = New-UDNivoFill -ElementId "fries" -PatternId 'dots'
        
        New-UDNivoChart -Definitions $Pattern -Fill $Fill -Bar -Data $Data -Height 400 -Width 900 -Keys @('burgers', 'fries', 'sandwich')  -IndexBy 'country'
    }

    New-Example -Title 'Interactive Charts' -Description 'Nivo charts support OnClick event handlers. You can provide a script block to the -OnClick parameter of New-UDNivoChart to create an event handler. When a user clicks the chart, your script block will be invoked and the $EventData property will be populated with the JSON from the Nivo chart. The event data contains the data point as well as positional information.' -Example {
        $Data = @(
            @{
                country = 'USA'
                burgers = (Get-Random -Minimum 10 -Maximum 100)
                fries = (Get-Random -Minimum 10 -Maximum 100)
                sandwich = (Get-Random -Minimum 10 -Maximum 100)
            }
            @{
                country = 'Germany'
                burgers = (Get-Random -Minimum 10 -Maximum 100)
                fries = (Get-Random -Minimum 10 -Maximum 100)
                sandwich = (Get-Random -Minimum 10 -Maximum 100)
            }
            @{
                country = 'Japan'
                burgers = (Get-Random -Minimum 10 -Maximum 100)
                fries = (Get-Random -Minimum 10 -Maximum 100)
                sandwich = (Get-Random -Minimum 10 -Maximum 100)
            }
        )
        New-UDNivoChart -Bar -Data $Data -Height 400 -Width 900 -Keys @('burgers', 'fries', 'sandwich')  -IndexBy 'country' -OnClick {
            Show-UDToast -Message $EventData -Position topLeft
        }
    }

} -Cmdlet @("New-UDNivoChart") -Enterprise