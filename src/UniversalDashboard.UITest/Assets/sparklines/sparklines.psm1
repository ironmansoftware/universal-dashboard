function New-UDSparkline {
    param(
        $Data,
        $Color
    )

    New-UDElement -JavaScriptPath "$PSScriptRoot\public\sparklines.bundle.js" -ModuleName "UDSparklines" -Properties @{
        Data = $Data
        Color = $Color
    }
}