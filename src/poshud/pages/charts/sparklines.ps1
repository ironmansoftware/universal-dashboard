New-ComponentPage -Title 'Sparklines' `
    -Enterprise `
    -Description 'Sparklines are tiny, little charts.' `
    -SecondDescription "Sparklines are great for putting in other controls like AppBars or tables. " -Content {

    New-Example -Title 'Sparklines' -Example {
        $Data = 1..10 | ForEach-Object { Get-Random -Max 1000 }
        New-UDSparklines -Data $Data -Max 1000 -Height 100 -Width 500
        New-UDSparklines -Data $Data -Type 'bars' -Max 1000 -Height 100 -Width 500
        New-UDSparklines -Data $Data -Type 'both' -Max 1000 -Height 100 -Width 500
    }
} -Cmdlet 'New-UDSparklines'