New-ComponentPage -Title 'Nivo Treemap' -Description 'Creates a treemap chart' -Content {
    New-Example -Title 'Treemap' -Description '' -Example {
        $TreeData = @{
            Name     = "root"
            children = @(
                @{
                    Name  = "first"
                    children = @(
                        @{
                            Name = "first-first"
                            Count = 7
                        }
                        @{
                            Name = "first-second"
                            Count = 8
                        }
                    )
                },
                @{
                    Name  = "second"
                    Count = 21
                }
            )
        }

        New-UDNivoChart -Treemap -Data $TreeData -Value "Count" -Identity "Name" -Height 500 -Width 800
    }
} -Cmdlet @("New-UDNivoChart") -Enterprise