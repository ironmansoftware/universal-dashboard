New-UDPage -Name 'Chart.v2' -Icon barcode -Content {

    # Main Chart full width custom height.
    new-udrow -Columns {
        New-UDChart -Title "Feature by operating system" -Type Line -AutoRefresh -RefreshInterval 7 @Colors -Endpoint {
            $features = @();
            $features += [PSCustomObject]@{ "OperatingSystem" = "Windows 10"; "FormsDesigner" = (Get-Random -Minimum 10 -Maximum 10000);  "WPFDesigner" = (Get-Random -Minimum 10 -Maximum 10000);  "UniversalDashboard" = (Get-Random -Minimum 10 -Maximum 10000) }
            $features += [PSCustomObject]@{ "OperatingSystem" = "Windows 8"; "FormsDesigner" = (Get-Random -Minimum 10 -Maximum 10000);  "WPFDesigner" = (Get-Random -Minimum 10 -Maximum 10000);  "UniversalDashboard" = (Get-Random -Minimum 10 -Maximum 10000) }
            $features += [PSCustomObject]@{ "OperatingSystem" = "Windows 7"; "FormsDesigner" = (Get-Random -Minimum 10 -Maximum 10000);  "WPFDesigner" = (Get-Random -Minimum 10 -Maximum 10000);  "UniversalDashboard" = (Get-Random -Minimum 10 -Maximum 10000) }
            $features += [PSCustomObject]@{ "OperatingSystem" = "Ubuntu 16.04"; "FormsDesigner" = (Get-Random -Minimum 10 -Maximum 10000);  "WPFDesigner" = (Get-Random -Minimum 10 -Maximum 10000);  "UniversalDashboard" = (Get-Random -Minimum 10 -Maximum 10000) }
            $features| Out-UDChartData -LabelProperty "OperatingSystem" -Dataset @(
                New-UDChartDataset -DataProperty "FormsDesigner" -Label "Forms Designer" -BackgroundColor "#0288d1" -HoverBackgroundColor "#0d47a1" -BorderColor '#01579b' 
                New-UDChartDataset -DataProperty "WPFDesigner" -Label "WPF Designer" -BackgroundColor "#00b0ff" -HoverBackgroundColor "#fff" -BorderColor '#01579b'
                New-UDChartDataset -DataProperty "UniversalDashboard" -Label "Universal Dashboard" -BackgroundColor "#4fc3f7" -HoverBackgroundColor "#004d40" -BorderColor '#01579b'
            ) 
        } -Width 99vw -Height 560px -Links @(
            New-UDLink -Icon github_alt -Url 'https://github.com' -Text GitHub -FontColor '#0277bd'
        )
    }

    # Second line custom width from chart & monitor.
    new-udrow -Columns {
        new-udcolumn -Content {
            New-UDChart -Title "Demo" -Type Line -Endpoint {
                20..0 | ForEach-Object {
                    [PSCustomObject]@{ 
                        Minute = " -$_"
                        PacketsPerSecond = (Get-Random -Minimum 50000 -Maximum 250000)
                    }
                } | Out-UDChartData -LabelProperty "Minute" -DataProperty "PacketsPerSecond" -DatasetLabel "Packets per second" -BackgroundColor "#0277bd" -BorderColor "#03a9f4" -HoverBackgroundColor "#b3e5fc" -HoverBorderColor "#03a9f4"
            } -BackgroundColor "#252525" -FontColor "#FFFFFF" -Width 48.5vw
        }

        new-udcolumn -Content {
            New-UDMonitor -Title "Downloads per second" -Type Line  -Endpoint {
                Get-Random -Minimum 0 -Maximum 10 | Out-UDMonitorData
            } -DataPointHistory 20 -RefreshInterval 5 -Width 48.5vw -ChartBackgroundColor "#0277bd" -ChartBorderColor "#03a9f4" -BackgroundColor "#252525"
        } 
    }

    # Third line custom chart & monitor with width and height 
    New-UDRow -Columns {
        New-UDColumn  -Content {
            New-UDChart -Title "Demo" -Type Bar -Endpoint {
                5..0 | ForEach-Object {
                    [PSCustomObject]@{ 
                        Minute = " -$_"
                        PacketsPerSecond = (Get-Random -Minimum 50000 -Maximum 250000)
                    }
                } | Out-UDChartData -LabelProperty "Minute" -DataProperty "PacketsPerSecond" -DatasetLabel "Packets per second" -BackgroundColor "#0277bd" -BorderColor "#03a9f4" -HoverBackgroundColor "#b3e5fc" -HoverBorderColor "#03a9f4"
            } -BackgroundColor "#252525" -FontColor "#FFFFFF" -Width 16vw -Height 300px -Links @(

                New-UDlink -Url 'https://github.com/ironmansoftware/universal-dashboard' -Icon github -FontColor '#0277bd'
                New-UDlink -Url 'https://github.com/ironmansoftware/universal-dashboard' -Icon code_fork -FontColor '#0277bd'
                New-UDlink -Url 'https://github.com/ironmansoftware/universal-dashboard' -Icon book -FontColor '#0277bd'
                New-UDlink -Url 'https://github.com/ironmansoftware/universal-dashboard' -Icon comments -FontColor '#0277bd'

            )
        }
        New-UDColumn -Content {
            New-UDChart -Title "Demo" -Type Bar -Endpoint {
                10..0 | ForEach-Object {
                    [PSCustomObject]@{ 
                        Minute = " -$_"
                        PacketsPerSecond = (Get-Random -Minimum 50000 -Maximum 250000)
                    }
                } | Out-UDChartData -LabelProperty "Minute" -DataProperty "PacketsPerSecond" -DatasetLabel "Packets per second" -BackgroundColor "#0277bd" -BorderColor "#03a9f4" -HoverBackgroundColor "#b3e5fc" -HoverBorderColor "#03a9f4"
            } -BackgroundColor "#252525" -FontColor "#FFFFFF" -Width 30vw -Height 300px
        }
        New-UDColumn -Content {
            New-UDMonitor -Title "Downloads per second" -Type Line  -Endpoint {
                Get-Random -Minimum 0 -Maximum 10 | Out-UDMonitorData 
            } -DataPointHistory 20 -RefreshInterval 5 -Width 50vw -Height 300px -ChartBackgroundColor "#0277bd" -ChartBorderColor "#03a9f4" -BackgroundColor "#252525" -Links @(
                New-UDLink -Icon github_alt -Url 'https://github.com' 
            ) -FontColor '#ffffff'
        }
    }
}