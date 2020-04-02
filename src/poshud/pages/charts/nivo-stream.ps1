New-ComponentPage -Title 'Nivo Stream' -Description 'Creates a stream chart' -Content {
    New-Example -Title 'Stream' -Description '' -Example {
        $Data = 1..10 | ForEach-Object { 
            @{
                "Adam" = Get-Random 
                "Alon" = Get-Random 
                "Lee" = Get-Random 
                "Frank" = Get-Random 
                "Bill" = Get-Random 
            }
        }

        New-UDNivoChart -Stream -Data $Data -Height 500 -Width 1000 -Keys @("Adam", "Alon", "Lee", "Frank", "Bill")
    }
} -Cmdlet @("New-UDNivoChart") -Enterprise