New-ComponentPage -Title 'Nivo Line' -Description 'Creates a line chart' -Content {
    New-Example -Title 'Line' -Description '' -Example {
        $Data = 1..10 | ForEach-Object { 
            @{
                id = "Line$_"
                data = @(
                    $item = Get-Random -Max 1000 
                    [PSCustomObject]@{
                        x = "Test$item"
                        y = $item
                    }
                )
            }
        }

        New-UDNivoChart -Line -Data $Data -Height 500 -Width 1000 -UseMesh -LineWidth 1
    }
} -Cmdlet @("New-UDNivoChart") -Enterprise