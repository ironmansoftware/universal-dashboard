New-ComponentPage -Title 'Nivo Bar' -Description 'Creates a bar chart based on the Nivo library' -Content {
    New-Example -Title 'Bar' -Description '' -Example {
        $Data = 1..10 | ForEach-Object { 
            $item = Get-Random -Max 1000 
            [PSCustomObject]@{
                Name = "Test$item"
                Value = $item
            }
        }
        New-UDNivoChart -Bar -Keys "Value" -IndexBy 'name' -Data $Data -Height 500 -Width 1000
    }
} -Cmdlet @("New-UDNivoChart") -Enterprise