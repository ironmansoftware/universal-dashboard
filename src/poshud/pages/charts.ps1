$BasicChart = {
    New-UDChart -Title "Cost of Bitcoin" -Type Line -Endpoint {

        $30DaysBack = [DateTime]::Now.AddDays(-30)
        0..30 | ForEach-Object {
            [PSCustomObject]@{ 
                Date = $30DaysBack.AddDays($_).ToShortDateString()
                Price = (Get-Random -Minimum 5000 -Maximum 20000)
            }
        } | Out-UDChartData -LabelProperty "Date" -DataProperty "Price" -DatasetLabel "Price to USD"
    }
}

$AutoRefreshChart = {
    New-UDChart -Title "People Living in Madison" -Type Line -Endpoint {

        $30DaysBack = [DateTime]::Now.AddYears(-30)
        0..30 | ForEach-Object {
            [PSCustomObject]@{ 
                Year = $30DaysBack.AddDays($_).Year
                Population = (Get-Random -Minimum 50000 -Maximum 250000)
            }
        } | Out-UDChartData -LabelProperty "Year" -DataProperty "Population" -DatasetLabel "Population"
    } -AutoRefresh -RefreshInterval 5
}

$CustomColors = {
    New-UDChart -Title "Packets per second" -Type Bar -Endpoint {
        30..0 | ForEach-Object {
            [PSCustomObject]@{ 
                Minute = " -$_"
                PacketsPerSecond = (Get-Random -Minimum 50000 -Maximum 250000)
            }
        } | Out-UDChartData -LabelProperty "Minute" -DataProperty "PacketsPerSecond" -DatasetLabel "Packets per second" -BackgroundColor "#FF0000" -BorderColor "#6F0000" -HoverBackgroundColor "#CC0786" -HoverBorderColor "#900786"
    } -BackgroundColor "#252525" -FontColor "#FFFFFF"
}



$MultiDatasetChart = {
    New-UDChart -Title "Feature by operating system" -Type Line -AutoRefresh -RefreshInterval 7 @Colors -Endpoint {
        $features = @();
        $features += [PSCustomObject]@{ "OperatingSystem" = "Windows 10"; "FormsDesigner" = (Get-Random -Minimum 10 -Maximum 10000);  "WPFDesigner" = (Get-Random -Minimum 10 -Maximum 10000);  "UniversalDashboard" = (Get-Random -Minimum 10 -Maximum 10000) }
        $features += [PSCustomObject]@{ "OperatingSystem" = "Windows 8"; "FormsDesigner" = (Get-Random -Minimum 10 -Maximum 10000);  "WPFDesigner" = (Get-Random -Minimum 10 -Maximum 10000);  "UniversalDashboard" = (Get-Random -Minimum 10 -Maximum 10000) }
        $features += [PSCustomObject]@{ "OperatingSystem" = "Windows 7"; "FormsDesigner" = (Get-Random -Minimum 10 -Maximum 10000);  "WPFDesigner" = (Get-Random -Minimum 10 -Maximum 10000);  "UniversalDashboard" = (Get-Random -Minimum 10 -Maximum 10000) }
        $features += [PSCustomObject]@{ "OperatingSystem" = "Ubuntu 16.04"; "FormsDesigner" = (Get-Random -Minimum 10 -Maximum 10000);  "WPFDesigner" = (Get-Random -Minimum 10 -Maximum 10000);  "UniversalDashboard" = (Get-Random -Minimum 10 -Maximum 10000) }
        $features| Out-UDChartData -LabelProperty "OperatingSystem" -Dataset @(
            New-UDChartDataset -DataProperty "FormsDesigner" -Label "Forms Designer" -BackgroundColor "#80962F23" -HoverBackgroundColor "#80962F23"
            New-UDChartDataset -DataProperty "WPFDesigner" -Label "WPF Designer" -BackgroundColor "#8014558C" -HoverBackgroundColor "#8014558C"
            New-UDChartDataset -DataProperty "UniversalDashboard" -Label "Universal Dashboard" -BackgroundColor "#803AE8CE" -HoverBackgroundColor "#803AE8CE"
        )
    }
}

New-UDPage -Name "Charts" -Icon chart_area -Content {
    New-UDPageHeader -Title "Charts" -Icon "area-chart" -Description "Visual data using dynamic charts based on ChartJS" -DocLink "https://adamdriscoll.gitbooks.io/powershell-universal-dashboard/content/charts.html"
    New-UDExample -Title "Basic Charts" -Description "Create basic charts from any type of data." -Script $BasicChart
    New-UDExample -Title "Auto Refreshing Charts" -Description "Automatically refresh chart data on an interval" -Script $AutoRefreshChart
    New-UDExample -Title "Custom colors" -Description "Adjust colors of different components within the chart." -Script $CustomColors
    New-UDExample -Title "Multiple Datasets" -Description "Combine data from more than one dimension on a single chart." -Script $MultiDatasetChart
}