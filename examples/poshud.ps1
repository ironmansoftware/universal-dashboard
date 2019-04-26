$Colors = @{
    BackgroundColor = "#252525"
    FontColor = "#FFFFFF"
}

$AlternateColors = @{
    BackgroundColor = "#4081C9"
    FontColor = "#FFFFFF"
}

$ScriptColors = @{
    BackgroundColor = "#5A5A5A"
    FontColor = "#FFFFFF"
}

$NavBarLinks = @((New-UDLink -Text "Buy Universal Dashboard" -Url "https://poshtools.com/buy-powershell-pro-tools/" -Icon heart_o),
                 (New-UDLink -Text "Documentation" -Url "https://docs.universaldashboard.io/" -Icon book))

$Components = New-UDPage -Name Components -Icon area_chart -Content {
    New-UDHtml -Markup '<link rel="stylesheet"
    href="//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/styles/agate.min.css">
<script src="//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/highlight.min.js"></script><script>hljs.initHighlightingOnLoad();</script>'
    New-UDRow {
        New-UDColumn -Size 3 {
            New-UDCard  @AlternateColors -Title "Charts" -Text "Display data in different types of charts. Define your data using PowerShell scripts. Configure colors, data sets, and update frequency."
        }
        New-UDColumn -Size 9 {
            New-UDCard @ScriptColors -Language "PowerShell Script for a Chart" -Text 'New-UDChart -Title "Feature by operating system (Area)" -Type Area -AutoRefresh -RefreshInterval 7 @Colors -Endpoint {
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
}' -Title "PowerShell"
        }
    }
    New-UDRow {
        New-UDColumn -Size 4 {
            New-UDChart -Title "Feature by operating system (Bar)" -Type Bar -AutoRefresh -RefreshInterval 7 @Colors -Endpoint {
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
        New-UDColumn -Size 4 {
            New-UDChart -Title "Feature by operating system (Line)" -Type Line -AutoRefresh -RefreshInterval 7 @Colors -Endpoint {
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
        New-UDColumn -Size 4 {
            New-UDChart -Title "Feature by operating system (Area)" -Type Area -AutoRefresh -RefreshInterval 7 @Colors -Endpoint {
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
    }
    New-UDRow {
        New-UDColumn -Size 3 {
            New-UDCard @AlternateColors -Title "Monitors" -Text "Track data over time in simple charts. Output counts for items like processor usage, memory usage or event counts."
        }
        New-UDColumn -Size 9 {
            New-UDCard @ScriptColors -Language "powershell" -Text 'New-UDMonitor -Title "Visits per second" -Type Line -DataPointHistory 20 -RefreshInterval 20 -ChartBackgroundColor "#593479FF" -ChartBorderColor "#FF5479FF" @Colors -Endpoint {
    Get-Random -Minimum 0 -Maximum 10000 | Out-UDMonitorData
}' -Title "PowerShell"
        }

    }
    New-UDRow {
        New-UDColumn -Size 4 {
            New-UDMonitor -Title "Downloads per second" -Type Line -DataPointHistory 20 -RefreshInterval 5 -ChartBackgroundColor '#59FF681B' -ChartBorderColor '#FFFF681B' @Colors -Endpoint {
                Get-Random -Minimum 0 -Maximum 10 | Out-UDMonitorData
            }
        }
        New-UDColumn -Size 4 {
            New-UDMonitor -Title "Tweets per second" -Type Line -DataPointHistory 20 -RefreshInterval 20 -ChartBackgroundColor '#595479FF' -ChartBorderColor '#FF5479FF' @Colors -Endpoint {
                Get-Random -Minimum 0 -Maximum 10000 | Out-UDMonitorData
            }
        }
        New-UDColumn -Size 4 {
            New-UDMonitor -Title "Visits per second" -Type Line -DataPointHistory 20 -RefreshInterval 20 -ChartBackgroundColor '#591179FF' -ChartBorderColor '#FF1279FF' @Colors -Endpoint {
                Get-Random -Minimum 0 -Maximum 10000 | Out-UDMonitorData
            }
        }
    }
    New-UDRow {
        New-UDColumn -Size 3 {
            New-UDCard @AlternateColors -Title "Counters" -Text "Display simple counts. Format displayed numbers using Numeral.js."
        }
        New-UDColumn -Size 9 {
            New-UDCard @ScriptColors -Language "PowerShell Script for a Counter" -Text 'New-UDCounter -Title "Total Bytes Downloaded" -AutoRefresh -RefreshInterval 3 -Format "0.00b" -Icon cloud_download @Colors -Endpoint {
    Get-Random -Minimum 0 -Maximum 100000000 | ConvertTo-Json
} ' -Title "PowerShell"
        }
    }
    New-UDRow {
        New-UDColumn -Size 4 {
            New-UDCounter -Title "Total Bytes Downloaded" -AutoRefresh -RefreshInterval 3 -Format '0.00b' -Icon cloud_download @Colors -Endpoint {
                Get-Random -Minimum 0 -Maximum 100000000 | ConvertTo-Json
            }
        }
        New-UDColumn -Size 4 {
            New-UDCounter -Title "Total Bytes Uploaded" -AutoRefresh -RefreshInterval 3 -Format '0.00b' -Icon cloud_upload @Colors -Endpoint {
                Get-Random -Minimum 0 -Maximum 100000000 | ConvertTo-Json
            }
        }
        New-UDColumn -Size 4 {
            New-UDCounter -Title "Total Revenue" -AutoRefresh -RefreshInterval 3 -Format '$0,0.00' -Icon money @Colors -Endpoint {
                Get-Random -Minimum 0 -Maximum 100000000 | ConvertTo-Json
            }
        }
    }
    New-UDRow {
        New-UDColumn -Size 3 {
            New-UDCard @AlternateColors -Title "Grids" -Text "Display data in a table that supports client and server side paging."
        }
        New-UDColumn -Size 9 {
            New-UDCard @ScriptColors -Language "PowerShell" -Text 'New-UDGrid -Title "Customer Locations" @Colors -Headers @("Country", "Customers", "First Purchase Date") -Properties @("Country", "Customers", "FirstPurchaseDate") -AutoRefresh -RefreshInterval 20 -Endpoint {
                Invoke-RestMethod http://myserver/api/myendpoint | Out-UDGridData
} ' -Title "PowerShell"
        }
    }
    New-UDRow {
        New-UDColumn -Size 12 {
            New-UDGrid -Title "Customer Locations" @Colors -Headers @("Country", "Customers", "First Purchase Date") -Properties @("Country", "Customers", "FirstPurchaseDate") -AutoRefresh -RefreshInterval 20 -Endpoint {

                                     @(
                                            @{
                                                    Country = "MAURITANIA"
                                                    Customers = 262
                                                    FirstPurchaseDate = "5/30/2017"
                                                },
                                            @{
                                                    Country = "NAURU"
                                                    Customers = 649
                                                    FirstPurchaseDate = "9/11/2017"
                                                },
                                            @{
                                                    Country = "POLAND"
                                                    Customers = 92
                                                    FirstPurchaseDate = "8/8/2017"
                                                },
                                            @{
                                                    Country = "SWITZERLAND"
                                                    Customers = 830
                                                    FirstPurchaseDate = "5/8/2017"
                                                },
                                            @{
                                                    Country = "ISLE OF MAN"
                                                    Customers = 641
                                                    FirstPurchaseDate = "7/13/2017"
                                                },
                                            @{
                                                    Country = "KYRGYZSTAN"
                                                    Customers = 857
                                                    FirstPurchaseDate = "7/30/2017"
                                                },
                                            @{
                                                    Country = "GIBRALTAR"
                                                    Customers = 223
                                                    FirstPurchaseDate = "9/3/2017"
                                                },
                                            @{
                                                    Country = "BAHRAIN"
                                                    Customers = 912
                                                    FirstPurchaseDate = "9/10/2017"
                                                },
                                            @{
                                                    Country = "PAKISTAN"
                                                    Customers = 913
                                                    FirstPurchaseDate = "6/9/2017"
                                                },
                                            @{
                                                    Country = "MALAWI"
                                                    Customers = 281
                                                    FirstPurchaseDate = "6/14/2017"
                                                },
                                            @{
                                                    Country = "HONG KONG"
                                                    Customers = 255
                                                    FirstPurchaseDate = "8/19/2017"
                                                },
                                            @{
                                                    Country = "DOMINICA"
                                                    Customers = 80
                                                    FirstPurchaseDate = "8/3/2017"
                                                },
                                            @{
                                                    Country = "GHANA"
                                                    Customers = 275
                                                    FirstPurchaseDate = "4/15/2017"
                                                },
                                            @{
                                                    Country = "ISRAEL"
                                                    Customers = 380
                                                    FirstPurchaseDate = "5/11/2017"
                                                },
                                            @{
                                                    Country = "FRENCH POLYNESIA"
                                                    Customers = 155
                                                    FirstPurchaseDate = "4/20/2017"
                                                },
                                            @{
                                                    Country = "PANAMA"
                                                    Customers = 130
                                                    FirstPurchaseDate = "9/3/2017"
                                                },
                                            @{
                                                    Country = "ESTONIA"
                                                    Customers = 468
                                                    FirstPurchaseDate = "8/12/2017"
                                                },
                                            @{
                                                    Country = "BANGLADESH"
                                                    Customers = 794
                                                    FirstPurchaseDate = "7/29/2017"
                                                },
                                            @{
                                                    Country = "�LAND ISLANDS"
                                                    Customers = 989
                                                    FirstPurchaseDate = "8/20/2017"
                                                },
                                            @{
                                                    Country = "ANGOLA"
                                                    Customers = 377
                                                    FirstPurchaseDate = "4/22/2017"
                                                }

                                             )  | Out-UDGridData
                                }
        }
    }
    New-UDRow {
        New-UDColumn -Size 3 {
            New-UDCard @AlternateColors -Title "Tables" -Text "Display static table data. Refresh on a customizable interval."
        }
        New-UDColumn -Size 9 {
            New-UDCard @ScriptColors -Language "PowerShell" -Text 'New-UDTable -Title "Top GitHub Issues" -Headers @("Id", "Title", "Description", "Comments") @Colors -Endpoint {
    $issues = @();
    $issues += [PSCustomObject]@{ "ID" = (Get-Random -Minimum 10 -Maximum 10000);  "Title" = "Product is too awesome...";  "Description" = "Universal Desktop is just too awesome."; Comments = (Get-Random -Minimum 10 -Maximum 10000) }
    $issues += [PSCustomObject]@{ "ID" = (Get-Random -Minimum 10 -Maximum 10000);  "Title" = "Support for running on a PS4";  "Description" = "A dashboard on a PS4 would be pretty cool."; Comments = (Get-Random -Minimum 10 -Maximum 10000) }
    $issues += [PSCustomObject]@{ "ID" = (Get-Random -Minimum 10 -Maximum 10000);  "Title" = "Bug in the flux capacitor";  "Description" = "The flux capacitor is constantly crashing."; Comments = (Get-Random -Minimum 10 -Maximum 10000) }
    $issues += [PSCustomObject]@{ "ID" = (Get-Random -Minimum 10 -Maximum 10000);  "Title" = "Feature Request - Hypnotoad Widget";  "Description" = "Every dashboard needs more hypnotoad"; Comments = (Get-Random -Minimum 10 -Maximum 10000) }

    $issues | Out-UDTableData -Property @("ID", "Title", "Description", "Comments")
}' -Title "PowerShell"
        }

    }
    New-UDRow {
        New-UDColumn -Size 12 {
            New-UDTable -Title "Top GitHub Issues" -Headers @("Id", "Title", "Description", "Comments") @Colors -Endpoint {
                $issues = @();
                $issues += [PSCustomObject]@{ "ID" = (Get-Random -Minimum 10 -Maximum 10000);  "Title" = "Product is too awesome...";  "Description" = "Universal Desktop is just too awesome."; Comments = (Get-Random -Minimum 10 -Maximum 10000) }
                $issues += [PSCustomObject]@{ "ID" = (Get-Random -Minimum 10 -Maximum 10000);  "Title" = "Support for running on a PS4";  "Description" = "A dashboard on a PS4 would be pretty cool."; Comments = (Get-Random -Minimum 10 -Maximum 10000) }
                $issues += [PSCustomObject]@{ "ID" = (Get-Random -Minimum 10 -Maximum 10000);  "Title" = "Bug in the flux capacitor";  "Description" = "The flux capacitor is constantly crashing."; Comments = (Get-Random -Minimum 10 -Maximum 10000) }
                $issues += [PSCustomObject]@{ "ID" = (Get-Random -Minimum 10 -Maximum 10000);  "Title" = "Feature Request - Hypnotoad Widget";  "Description" = "Every dashboard needs more hypnotoad"; Comments = (Get-Random -Minimum 10 -Maximum 10000) }

                $issues | Out-UDTableData -Property @("ID", "Title", "Description", "Comments")
            }
        }
    }
    New-UDRow {
        New-UDColumn -Size 3 {
            New-UDCard @AlternateColors -Title "Images" -Text "Display images from the web or from disk. Refresh images on the fly and generate them from endpoints."
        }
        New-UDColumn -Size 9 {
            New-UDCard @ScriptColors -Language "PowerShell" -Text 'New-UDImage -Url https://poshtools.com/wp-content/uploads/2017/04/PoshToolsLogo-2.png -Height 100 -Width 100' -Title "PowerShell"
        }
    }
    New-UDRow {
        New-UDColumn -Size 3 {
            New-UDImage -Url https://poshtools.com/wp-content/uploads/2017/04/PoshToolsLogo-2.png -Height 75 -Width 300
        }
        New-UDColumn -Size 3 {
            New-UDImage -Url https://poshtools.com/wp-content/uploads/2017/04/PoshToolsLogo-2.png -Height 75 -Width 300
        }
        New-UDColumn -Size 3 {
            New-UDImage -Url https://poshtools.com/wp-content/uploads/2017/04/PoshToolsLogo-2.png -Height 75 -Width 300
        }
        New-UDColumn -Size 3 {
            New-UDImage -Url https://poshtools.com/wp-content/uploads/2017/04/PoshToolsLogo-2.png -Height 75 -Width 300
        }
    }
}

$Formatting = New-UDPage -Name "Formatting" -Icon th {


    New-UDRow {
        New-UDColumn -Size 3 {
            New-UDCard  @AlternateColors -Title "Grid System" -Text "Organize your dashboard using the Materialize grid system. Break down sections by rows and columns. Choose the size of each column. Nest rows and grids within each other for ultimate control." -Links @(New-UDLink -Url "http://materializecss.com/grid.html" -Text "Learn more about the grid system")
        }
        New-UDColumn -Size 9 {
            New-UDCard @ScriptColors -Language "PowerShell" -Text 'New-UDRow {
    New-UDColumn -Size 9 {
        New-UDRow {
            New-UDColumn -Size 3 {
                New-UDCard
            }
            New-UDColumn -Size 3 {
                New-UDCard
            }
            New-UDColumn -Size 6 {
                New-UDCard
            }
        }
    }
    New-UDColumn -Size 3 {
        New-UDCard
    }
}' -Title "PowerShell"
        }
    }

    New-UDRow {
        New-UDColumn -Size 9 {
            New-UDRow {
                New-UDColumn -Size 3 {
                    New-UDCard
                }
                New-UDColumn -Size 3 {
                    New-UDCard
                }
                New-UDColumn -Size 6 {
                    New-UDCard
                }
            }
        }
        New-UDColumn -Size 3 {
            New-UDCard
        }
    }

    New-UDRow {
        New-UDColumn -Size 3 {
            New-UDCard  @AlternateColors -Title "Layout" -Text "Create simple layouts by specifying the number of columns and adding content. Rows and columns will automatically be created."
        }
        New-UDColumn -Size 9 {
            New-UDCard @ScriptColors -Language "PowerShell" -Text 'New-UDLayout -Columns 3 -Content {
    New-UDCard
    New-UDCard
    New-UDCard
    New-UDCard
    New-UDCard
    New-UDCard
}' -Title "PowerShell"
        }
    }

    New-UDRow {
        New-UDColumn -Size 12 {
            New-UDLayout -Columns 3 -Content {
                New-UDCard
                New-UDCard
                New-UDCard
                New-UDCard
                New-UDCard
                New-UDCard
            }
        }
    }

    New-UDRow {
        New-UDColumn -Size 3 {
            New-UDCard  @AlternateColors -Title "Pages" -Text "Create multi-page dashboards. Provide icons and link text. Take advantage of ReactJS routing to provide custom URLs."
        }
        New-UDColumn -Size 9 {
            New-UDCard @ScriptColors -Language "PowerShell" -Text 'New-UDPage -Name Components -Icon area_chart -Content {
    New-UDChart {}
}' -Title "PowerShell"
        }
    }
    New-UDRow {
        New-UDColumn -Size 3 {
            New-UDCard  @AlternateColors -Title "Navigation Bar" -Text "Customize the navigation bar colors, text and links."
        }
        New-UDColumn -Size 9 {
            New-UDCard @ScriptColors -Language "PowerShell" -Text '$NavBarLinks = @((New-UDLink -Text "PowerShell Pro Tools" -Url "https://poshtools.com/buy-powershell-pro-tools/" -Icon heart_o),
(New-UDLink -Text "Documentation" -Url "https://docs.universaldashboard.io/" -Icon book))
New-UDDashboard -NavbarLinks $NavBarLinks -Title "PowerShell Universal Dashboard" -NavBarColor "#FF1c1c1c" -NavBarFontColor "#FF55b3ff" -BackgroundColor "#FF333333" -FontColor "#FFFFFFF" ' -Title "PowerShell"
        }
    }
}

$HomePage = New-UDPage -Name "Home" -Icon home -Content {
    New-UDRow {
        New-UDColumn -Size 12 {
            New-UDHtml -Markup "<div class='center-align white-text'><h3>Beautiful dashboards. All PowerShell.</h3></h3><h5>Universal Dashboard is a cross-platform PowerShell module for developing and hosting web-based, interactive dashboards.</h5></div>"
        }
    }
    New-UDRow {
        New-UDColumn -Size 4 {
            New-UDRow {
                New-UDColumn -Size 12 {
                    New-UDCard @Colors -Title "Interactive Components" -Text "Display data in interactive charts, grids, tables and counters. Automatically reload data on set intervals." -Links @(New-UDLink -Text "Check out the components" -Url "/Components")
                }
            }
            New-UDRow {
                New-UDColumn -Size 12 {
                    New-UDChart -Title "Favorite Sport by Country" -Type Bar -AutoRefresh -RefreshInterval 7 @Colors -Endpoint {
                        $features = @();
                        $features += [PSCustomObject]@{ "Country" = "United States"; "Football" = (Get-Random -Minimum 10 -Maximum 10000);  "Baseball" = (Get-Random -Minimum 10 -Maximum 10000);  "Curling" = (Get-Random -Minimum 10 -Maximum 10000) }
                        $features += [PSCustomObject]@{ "Country" = "Switzerland"; "Football" = (Get-Random -Minimum 10 -Maximum 10000);  "Baseball" = (Get-Random -Minimum 10 -Maximum 10000);  "Curling" = (Get-Random -Minimum 10 -Maximum 10000) }
                        $features += [PSCustomObject]@{ "Country" = "Germany"; "Football" = (Get-Random -Minimum 10 -Maximum 10000);  "Baseball" = (Get-Random -Minimum 10 -Maximum 10000);  "Curling" = (Get-Random -Minimum 10 -Maximum 10000) }
                        $features += [PSCustomObject]@{ "Country" = "Brazil"; "Football" = (Get-Random -Minimum 10 -Maximum 10000);  "Baseball" = (Get-Random -Minimum 10 -Maximum 10000);  "Curling" = (Get-Random -Minimum 10 -Maximum 10000) }
                        $features| Out-UDChartData -LabelProperty "Country" -Dataset @(
                            New-UDChartDataset -DataProperty "Football" -Label "Football" -BackgroundColor "#8052FFC7" -HoverBackgroundColor "#FF52FFC7"
                            New-UDChartDataset -DataProperty "Baseball" -Label "Baseball" -BackgroundColor "#80E841C8" -HoverBackgroundColor "#FFE841C8"
                            New-UDChartDataset -DataProperty "Curling" -Label "Curling" -BackgroundColor "#8052E837" -HoverBackgroundColor "#FF52E837"
                        )
                    }
                }
            }
        }
        New-UDColumn -Size 4 {
            New-UDRow {
                New-UDColumn -Size 12 {
                    New-UDCard @Colors -Title "Modern Technology" -Text "Using PowerShell Core, Material Design, ReactJS and ASP.NET Core, Universal Dashboard takes advantage of cutting-edge technology to provide cross-platform, cross-device dashboards that looks sleek and modern."
                }
            }
            New-UDRow {
                New-UDColumn -Size 6 {
                    New-UDImage -Height 125 -Width 165 -Url "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQH/2wBDAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQH/wAARCAEsAZADAREAAhEBAxEB/8QAHwABAAEDBQEBAAAAAAAAAAAAAAoBCQsCBQYHCAME/8QAZBAAAAYBAgQCBAYIDwgOCwAAAAECAwQFBgcRCAkSIRMxChRBURUiOWGBthYzcXZ4kbLwGCMkMjU2Qlhyd6G1wdHxFxklJjhSseEaJzRDU1RWV2KCl5i30kZVaIOHkpPC09XW/8QAHgEBAAICAwEBAQAAAAAAAAAAAAcIAQYCAwUECgn/xABeEQABAwIEAwMECgwHDAkFAAABAAIDBBEFBhIhBxMxIkFRFDJhgSMzNkJScXWRsbIIFRZDYnJzdKGztMEXJDWCotHwCSU0N1NVVpSV09ThJkRjZIOStcLxRVSWpdL/2gAMAwEAAhEDEQA/AI/4/oAr0ICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICKivL/Vvt8/YjPt59iMzMukvPcEXZ+juiWr3EHnVdprohpxl2qGdWafFYx3D6eRayI0RJqJyxtZDaSgU1THIlqetLiVDr2UoNRupNKiP46/E8PwmmfW4nWQUNIzZ808jI2k2LhGwODjLI7SS2KNrpHBrnAWa4j46/EKHDKZ9XiFXBR08f36dwA12JDIxu58ha1xayMOeQ1xtpDiJLXC/6MFqflEKtyPi41vrdMGpDaH5GmukcWJmOVRiURKTEuc6tUoxaBKRsbclmgqsmjEZEuPfOmXUUM43xtoYHPiwDDJK099biDnQQOcLhr4qSJz5XC1rGR8AIuDD2g5sRYxxho4XPiwLD5ay1x5XXOkp4n9buiiYRI9pNiOaY773bcAj3/L5bXIB4SGSha55ppla3MM0pfVrdxGy5F2iSy5srxcexjJM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porVR3mLGzLwvHiNNU2bZHFV4rkWzYjkaWo+q865/wA8yvw/BKeakpXktfDhET2ANd2HeX4g7S6Nh1AEunp4yS0FrjpadGqs353znKaHCKeWmp5DaSHDI5G6Wnsl1ZiLiXRss+x1Swxm7W2JLQbWvMW9IqzTVypudHeBysv9I8CnMvVd3rZetN1mpt5XrQbK4uBU0V59rT2ueQZl8PSZUrKXGOj4OZx14ieVvOT+ENNh748SzNJBXVbHiWHDY+3RwuuHa6yWwdUvBFtGhsTXHt8wDUtzypwsgoHx1+YnR11S1wkioIrPoonXverm7Lql4P3trRGCbuLrXUX9116Q89JkvvypMp5+TKlSnnJEqVKkOrekypUh9bj8mTJfccfkSHnHHnXlrW8tTqlGJtsGta1oa0NAbpFmgAbMa1jOw2Nrbho8LaNtSmFoDQGtDWhoA0tGkADZgazq1jW3DR5vwNrrSOK5ICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICKh/n/q+cvMvefYu5kCLk2G5vm2nN/GyvTzMcrwLJ4htnHyHDMhtsYuW0trJxDfwhTS4UhxhJ7KOLJeNhZl0uNrIkmXTPTU1ZE+CrpoKuF43iqIo5o7/C0SNcNQFwC0B1nEA2JXRUU1PVxOhqoIaiJ3WOeGOZhNiL6JGuF9JcLtAdYkA2JVzbTLne8z7S2KxAr+J25zGEzsk2tTsUw3UCW82R9kLt72kcuPinsknET0OkgiQ44tPnplbw0yTWnU7BYqZ3UuoZqilBdv97jkazrcmzR0HxLUKvh3k+tdrfhEcDj1NLNUUrSfHlRyNj37+yvQyvSOuZScU2CvdFkOmwTRTU6UxTkE4aOk5JIVcLh+N1GS9lRzjdZJP1cmyUk/IHB7JYcHCLFNINywVzi23gbxueB4kOXlnhTlEn2rERc30NrnFtvSSwSBvpa699gO9ea9UeddzOdWYj1fb8UWRYnXveIk42mON4jpy94DinT9VOxxukjW7iOh02zU9NXINom+pwzSTp+1RcNslUDg+LBKaocO0DWy1FeLjSQQyofoDttrMtbULEOK9Sj4e5QonNczBopXt3aamoqKq5uLEtqJnMvsOkZ8ANyrZ2TZXlWcXkrJs2ynJc0ySaXTKyHLr60yW8kN9anCadtbmZNnKYQtajbjm8bLPk0lJdhucVPT00bYaangpYW2DYKeKOCIW6HlxBjQR0B0XsevjuEEENPGIqeCGmhbs2GCOOJgsPO0xBjfRfRf8Lx2Mc13ICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICICL/2Q=="
                }
                New-UDColumn -Size 6 {
                    New-UDImage -Height 125 -Width 125 -Url "data:image/svg+xml;base64,PHN2ZyBpZD0iTGF5ZXJfMSIgZGF0YS1uYW1lPSJMYXllciAxIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyMyAyMC40NjM0OCI+PHRpdGxlPmxvZ288L3RpdGxlPjxwYXRoIGQ9Ik0xOC45MTA3LDYuNjMyNTdoMHEtLjM2NzIxLS4xMjYtLjc0MDQyLS4yMzMzLjA2MTg3LS4yNTE0MS4xMTQ0MS0uNTA1Yy41NjA0NS0yLjcyMDY0LjE5NC00LjkxMjM3LTEuMDU3MzktNS42MzM4Ni0xLjE5OTgtLjY5Mi0zLjE2MjEuMDI5NTItNS4xNDM5NCwxLjc1NDE0cS0uMjkyOTMuMjU1NS0uNTcyNjcuNTI1NTQtLjE4NzI3LS4xNzk1MS0uMzgxMS0uMzUyQzkuMDUyNTcuMzQzOSw2Ljk3MDY2LS40MzMxNiw1LjcyMDU4LjI5MDQ2LDQuNTIxOTEuOTg0MzYsNC4xNjY4NiwzLjA0NDg5LDQuNjcxNDQsNS42MjMyMnEuMDc1My4zODMuMTcuNzYxNzljLS4yOTQ1OC4wODM2Ny0uNTc5MDguMTcyODQtLjg1MTI3LjI2NzcxQzEuNTU1MTQsNy41MDE2NSwwLDguODMyMjUsMCwxMC4yMTIzMWMwLDEuNDI1NDYsMS42NjkzNSwyLjg1NTIsNC4yMDU3NSwzLjcyMnEuMzA4NS4xMDQ5NC42MjE5My4xOTQ0Mi0uMTAxNzkuNDA4LS4xODA2OC44MjExNGMtLjQ4MTA2LDIuNTMzNTQtLjEwNTM1LDQuNTQ1MjEsMS4wOTAxNyw1LjIzNDg0LDEuMjM0ODEuNzEyLDMuMzA3MjUtLjAxOTg1LDUuMzI1MzMtMS43ODM4N3EuMjM5MjYtLjIwOTE3LjQ3OTk0LS40NDIzOC4zMDI5LjI5MjI1LjYyMTczLjU2NzI3YzEuOTU0NzcsMS42ODIwNywzLjg4NTMxLDIuMzYxMzIsNS4wNzk4MiwxLjY2OTg2LDEuMjMzNjktLjcxNDE2LDEuNjM0NTQtMi44NzUyNSwxLjExNC01LjUwNDU5cS0uMDU5NTUtLjMwMTI0LS4xMzc5Mi0uNjE0ODEuMjE4MzQtLjA2NDQzLjQyNzcyLS4xMzM1NUMyMS4yODQ1NCwxMy4wNjkxNSwyMywxMS42NTY4MSwyMywxMC4yMTIzMiwyMyw4LjgyNzI2LDIxLjM5NDc4LDcuNDg3NzEsMTguOTEwNyw2LjYzMjU3Wk0xMi43Mjg0LDIuNzU1ODFDMTQuNDI2NDYsMS4yNzgsMTYuMDEzNDYuNjk0NTcsMTYuNzM2NTcsMS4xMTE2aDBjLjc3MDE0LjQ0NDIxLDEuMDY5NzEsMi4yMzU0LjU4NTgsNC41ODQ0MXEtLjA0NzU4LjIyOTUzLS4xMDM0Mi40NTcyNGEyMy41Mzc1MiwyMy41Mzc1MiwwLDAsMC0zLjA3NTI3LS40ODU4NEEyMy4wODEyOCwyMy4wODEyOCwwLDAsMCwxMi4xOTk1LDMuMjQwOTRRMTIuNDU3ODgsMi45OTE4NCwxMi43Mjg0LDIuNzU1ODFaTTYuNzkxMTEsMTEuMzkxMjRxLjMxMi42MDI2NS42NTIwNywxLjE5MDEzLjM0NjkyLjU5OTExLjcyMjEsMS4xODExN2EyMC45MjE2OCwyMC45MjE2OCwwLDAsMS0yLjExOTY3LS4zNDA4QzYuMjQ4NjcsMTIuNzY2LDYuNDk4ODcsMTIuMDg0NDMsNi43OTExMSwxMS4zOTEyNFpNNi43OSw5LjA4MDQxYy0uMjg2MTMtLjY3ODYzLS41MzA5My0xLjM0NTg2LS43MzA4NS0xLjk5MDE5LjY1NjI0LS4xNDY4OCwxLjM1Ni0uMjY2ODksMi4wODUxNi0uMzU4cS0uMzY2MTEuNTcxLS43MDUxLDEuMTU4NzdRNy4xMDA3Niw4LjQ3OCw2Ljc5LDkuMDgwNDFabS41MjIyOCwxLjE1NTUycS40NTQxMS0uOTQ1MTcuOTc4My0xLjg1NDJ2LjAwMDJxLjUyMzY5LS45MDg1NywxLjExNTIxLTEuNzc1NDJjLjY4NC0uMDUxNzEsMS4zODUzNi0uMDc4NzksMi4wOTQzMi0uMDc4NzkuNzEyMTIsMCwxLjQxNDM3LjAyNzI4LDIuMDk4MTkuMDc5NHEuNTg1MTQuODY0ODcsMS4xMDgxOCwxLjc2OTQxLjUyNTY1LjkwNjM1Ljk5MTUzLDEuODQ1NDUtLjQ2MDgzLjk0ODE3LS45ODgyOCwxLjg2MTczaC0uMDAwMXEtLjUyMjYxLjkwNzg2LTEuMTAzNCwxLjc4MDNjLS42ODI0LjA0ODc2LTEuMzg3Ni4wNzM5LTIuMTA2MjMuMDczOS0uNzE1NjgsMC0xLjQxMTkzLS4wMjIyOS0yLjA4MjQxLS4wNjU3NXEtLjU5NTU1LS44Njk5NS0xLjEyNDA2LTEuNzgzMDVRNy43Njc4OSwxMS4xODE0OCw3LjMxMjI3LDEwLjIzNTkzWm04LjI0ODUzLDIuMzM4NjJxLjM0Ny0uNjAxODIuNjY3LTEuMjE4NjNoMGEyMC44NjY3MSwyMC44NjY3MSwwLDAsMSwuNzcyMzgsMi4wMjMyNywyMC44NTE2NCwyMC44NTE2NCwwLDAsMS0yLjE0NTUyLjM2NTczUTE1LjIxOTM1LDEzLjE2NjgyLDE1LjU2MDgsMTIuNTc0NTVabS42NTc2Ny0zLjQ5MzQzcS0uMzE4ODMtLjYwNS0uNjYxNjMtMS4xOTY4NGgwcS0uMzM3MjctLjU4MjU4LS42OTk0LTEuMTUwMjJjLjczMzkuMDkyNjMsMS40MzcuMjE1NzksMi4wOTcxNy4zNjY1NEEyMC45NTkwOSwyMC45NTkwOSwwLDAsMSwxNi4yMTg0Nyw5LjA4MTEyWk0xMS41MTEsMy45NDM1OWEyMS4wMTI4OCwyMS4wMTI4OCwwLDAsMSwxLjM1MzUsMS42MzM5M3EtMS4zNTg0My0uMDY0MTktMi43MTg0LS4wMDA2MUMxMC41OTMsNC45ODc2NSwxMS4wNTA3LDQuNDQwMjIsMTEuNTExLDMuOTQzNTlaTTYuMjEyODQsMS4xNDA4MWMuNzY5NTMtLjQ0NTQzLDIuNDcwOTUuMTg5NzMsNC4yNjQyOCwxLjc4Mi4xMTQ2MS4xMDE3OS4yMjk3NC4yMDgzNi4zNDUwNy4zMTg2QTIzLjU0NTQyLDIzLjU0NTQyLDAsMCwwLDguODYyOTQsNS42NjYwOGEyNC4wMDgsMjQuMDA4LDAsMCwwLTMuMDY5MTYuNDc3cS0uMDg4LS4zNTIyOC0uMTU4MDgtLjcwODY2di4wMDAxQzUuMjAzMzksMy4yMjUzNiw1LjQ5MDQ0LDEuNTU5LDYuMjEyODQsMS4xNDA4MVpNNS4wOTEzMiwxMy4xODIzM3EtLjI4Ni0uMDgxODctLjU2Nzc4LS4xNzc3M0E4LjMyMzcxLDguMzIzNzEsMCwwLDEsMS44NDEsMTEuNTc5NTVhMi4wMzA3MiwyLjAzMDcyLDAsMCwxLS44NTg0OS0xLjM2NzI0YzAtLjgzNzQyLDEuMjQ4NjUtMS45MDU3MSwzLjMzMTE3LTIuNjMxNzhxLjM5MjA4LS4xMzYxLjc5MTYyLS4yNDkwOGEyMy41NjQ1NSwyMy41NjQ1NSwwLDAsMCwxLjEyMSwyLjkwNDc4QTIzLjkyMjQ3LDIzLjkyMjQ3LDAsMCwwLDUuMDkxMzIsMTMuMTgyMzNaTTEwLjQxNTk0LDE3LjY2MWE4LjMyMTYxLDguMzIxNjEsMCwwLDEtMi41NzQ2NywxLjYxMTg0aC0uMDAwMWEyLjAzMDQyLDIuMDMwNDIsMCwwLDEtMS42MTMwNi4wNjA2N2MtLjcyNTU2LS40MTgzNi0xLjAyNzA2LTIuMDMzNzYtLjYxNTczLTQuMjAwMzVxLjA3MzM3LS4zODQwNy4xNjgtLjc2MzYzYTIzLjEwNDQ0LDIzLjEwNDQ0LDAsMCwwLDMuMDk5NS40NDg2OSwyMy45MDk1NCwyMy45MDk1NCwwLDAsMCwxLjk3NDMxLDIuNDM5MjlRMTAuNjQsMTcuNDY0NTksMTAuNDE1OTQsMTcuNjYxWm0xLjEyMjIzLTEuMTEwNTNjLS40NjU2OS0uNTAyNTMtLjkzMDE1LTEuMDU4MzEtMS4zODM4My0xLjY1NjEycS42NjA1MS4wMjYsMS4zNDU2Ni4wMjYwNi43MDMyNiwwLDEuMzg4NDEtLjAzMDg0QTIwLjg5NDI1LDIwLjg5NDI1LDAsMCwxLDExLjUzODE3LDE2LjU1MDQ1Wm01Ljk2NjUxLDEuMzY3YTIuMDMwMzksMi4wMzAzOSwwLDAsMS0uNzUzLDEuNDI3OGMtLjcyNDg1LjQxOTU4LTIuMjc1LS4xMjU4MS0zLjk0NjU5LTEuNTY0MzFxLS4yODc1LS4yNDczNS0uNTc4MzctLjUyNzI3YTIzLjA4OTE0LDIzLjA4OTE0LDAsMCwwLDEuOTI3OS0yLjQ0OCwyMi45MzY0NywyMi45MzY0NywwLDAsMCwzLjExNTA3LS40ODAxNHEuMDcwMjQuMjg0LjEyNDQ5LjU1NjM4aDBBOC4zMiw4LjMyLDAsMCwxLDE3LjUwNDY4LDE3LjkxNzQ5Wm0uODM0MTctNC45MDczOWgtLjAwMDFjLS4xMjU3MS4wNDE2My0uMjU0NzguMDgxODQtLjM4NjI5LjEyMDgyYTIzLjA2MTIxLDIzLjA2MTIxLDAsMCwwLTEuMTY0NjgtMi45MTM3MywyMy4wNTExMiwyMy4wNTExMiwwLDAsMCwxLjExOTM4LTIuODcxMjhjLjIzNTI0LjA2ODIuNDYzNjUuMTQuNjgzNzIuMjE1NzksMi4xMjg0Mi43MzI1OCwzLjQyNjY1LDEuODE1OTMsMy40MjY2NSwyLjY1MDYxQzIyLjAxNzUzLDExLjEwMTQ1LDIwLjYxNTM4LDEyLjI1NTc0LDE4LjMzODg1LDEzLjAxMDFaIiBmaWxsPSIjNjFkYWZiIi8+PHBhdGggZD0iTTExLjUsOC4xNTg1YTIuMDUzODYsMi4wNTM4NiwwLDEsMS0yLjA1MzgxLDIuMDUzODFBMi4wNTM4MSwyLjA1MzgxLDAsMCwxLDExLjUsOC4xNTg1IiBmaWxsPSIjNjFkYWZiIi8+PC9zdmc+"
                }
            }
            New-UDRow {
                New-UDColumn -Size 6 {
                    New-UDImage -Height 125 -Width 125 -Url "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTYwIiBoZWlnaHQ9IjE2MCIgdmlld0JveD0iMCAwIDE2MCAxNjAiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+PHRpdGxlPkFydGJvYXJkIDY8L3RpdGxlPjxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+PHBhdGggZD0iTTE0NC4wODYgODAuNTY4Yy0yMS45NzguNDMtMTcuNDAyIDE0LjM0Ni0zMi44OSAxNy44NjZDOTUuNDYgMTAyLjAxIDkyLjk3NSA2MCA3Ny4yNDMgNjBjLTE1LjczMyAwLTE5LjIxNiA0MC44MDYtMzguOTE4IDY4LjgyM2wtLjU2Ljc5NEw4MCAxNTRsNjQuMDg2LTM3VjgwLjU2OHoiIGZpbGw9IiMzNkEyRUIiLz48cGF0aCBkPSJNMTQ0LjA4NiA3OS4zQzEzNi43MjYgNjkuODU2IDEzMS43MzYgNTkgMTIxIDU5Yy0xOSAwLTE0IDMxLTM1IDMxcy0yMy4yMDctMzMuMzQ2LTQ3LTJjLTcuNTggOS45ODgtMTMuNjgyIDIxLjEyNC0xOC40NzUgMzEuNjYyTDgwIDE1NGw2NC4wODYtMzdWNzkuM3oiIGZpbGw9IiNGRkNFNTYiLz48cGF0aCBkPSJNMTUuOTE0IDkyLjE0M0MyMy4xMjQgNzIuMTczIDI2LjIzNyA1NiA0MCA1NmMyMSAwIDI2IDU5IDQ0IDUzczE2LTM4IDQ0LTM4YzUuMzMgMCAxMC43NzIgMy4yNjMgMTYuMDg2IDguNTQ2VjExN0w4MCAxNTRsLTY0LjA4Ni0zN1Y5Mi4xNDN6IiBmaWxsLW9wYWNpdHk9Ii44IiBmaWxsPSIjRkU2MTg0Ii8+PHBhdGggc3Ryb2tlPSIjRTdFOUVEIiBzdHJva2Utd2lkdGg9IjgiIGQ9Ik04MCA2bDY0LjA4NiAzN3Y3NEw4MCAxNTRsLTY0LjA4Ni0zN1Y0M3oiLz48L2c+PC9zdmc+"
                }
                New-UDColumn -Size 6 {
                    New-UDImage -Height 125 -Width 125 -Url "data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz48c3ZnIHZlcnNpb249IjEuMSIgaWQ9IkxheWVyXzEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHg9IjBweCIgeT0iMHB4IiB3aWR0aD0iMTI4cHgiIGhlaWdodD0iMTI4cHgiIHZpZXdCb3g9IjAgMCAxMjggMTI4IiBlbmFibGUtYmFja2dyb3VuZD0ibmV3IDAgMCAxMjggMTI4IiB4bWw6c3BhY2U9InByZXNlcnZlIj48bGluZWFyR3JhZGllbnQgaWQ9IlNWR0lEXzFfIiBncmFkaWVudFVuaXRzPSJ1c2VyU3BhY2VPblVzZSIgeDE9Ijk1LjEyMzUiIHkxPSI5MS44MDQ5IiB4Mj0iMjYuODU1IiB5Mj0iMzAuODI0OSI+PHN0b3AgIG9mZnNldD0iMCIgc3R5bGU9InN0b3AtY29sb3I6IzUzOTFGRSIvPjxzdG9wICBvZmZzZXQ9IjEiIHN0eWxlPSJzdG9wLWNvbG9yOiMzRTZEQkYiLz48L2xpbmVhckdyYWRpZW50PjxwYXRoIGZpbGwtcnVsZT0iZXZlbm9kZCIgY2xpcC1ydWxlPSJldmVub2RkIiBmaWxsPSJ1cmwoI1NWR0lEXzFfKSIgZD0iTTkuNDkxLDEwOWMtMS42MiwwLTMuMDIxLTAuNjM4LTMuOTQ0LTEuNzk4Yy0wLjk0NC0xLjE4NS0xLjI2OC0yLjgxNC0wLjg4OS00LjQ3bDE3LjgzNC03Ny45MTFDMjMuMjM5LDIxLjU1NywyNi4zNzYsMTksMjkuNjM0LDE5SDExOC41YzEuNjIsMCwzLjAyMSwwLjYzOCwzLjk0NSwxLjc5OGMwLjk0NCwxLjE4NCwxLjI2OCwyLjgxNCwwLjg4OSw0LjQ3bC0xNy44MzQsNzcuOTExYy0wLjc0NywzLjI2NC0zLjg4NCw1LjgyMi03LjE0Myw1LjgyMkg5LjQ5MXoiLz48bGluZWFyR3JhZGllbnQgaWQ9IlNWR0lEXzJfIiBncmFkaWVudFVuaXRzPSJ1c2VyU3BhY2VPblVzZSIgeDE9IjI2LjE3NzUiIHkxPSIzMC4wMTQ2IiB4Mj0iOTMuNzQ4NSIgeTI9IjkwLjczODEiPjxzdG9wICBvZmZzZXQ9IjAiIHN0eWxlPSJzdG9wLWNvbG9yOiM1MzkxRkUiLz48c3RvcCAgb2Zmc2V0PSIxIiBzdHlsZT0ic3RvcC1jb2xvcjojM0U2REJGIi8+PC9saW5lYXJHcmFkaWVudD48cGF0aCBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGNsaXAtcnVsZT0iZXZlbm9kZCIgZmlsbD0idXJsKCNTVkdJRF8yXykiIGQ9Ik0yOS42MzQsMjBIMTE4LjVjMi43NjksMCw0LjQ5NiwyLjI1OSwzLjg1OCw1LjA0NWwtMTcuODM0LDc3LjkxMWMtMC42MzgsMi43ODYtMy4zOTksNS4wNDUtNi4xNjgsNS4wNDVIOS40OTFjLTIuNzY5LDAtNC40OTYtMi4yNTgtMy44NTgtNS4wNDVsMTcuODM0LTc3LjkxMUMyNC4xMDQsMjIuMjU5LDI2Ljg2NiwyMCwyOS42MzQsMjB6Ii8+PHBhdGggZmlsbC1ydWxlPSJldmVub2RkIiBjbGlwLXJ1bGU9ImV2ZW5vZGQiIGZpbGw9IiMyQzU1OTEiIGQ9Ik02NC4xNjUsODcuNTU4aDIxLjYxM2MyLjUxMywwLDQuNTUsMi4xMjUsNC41NSw0Ljc0NmMwLDIuNjIxLTIuMDM3LDQuNzQ3LTQuNTUsNC43NDdINjQuMTY1Yy0yLjUxMywwLTQuNTUtMi4xMjUtNC41NS00Ljc0N0M1OS42MTUsODkuNjgzLDYxLjY1Miw4Ny41NTgsNjQuMTY1LDg3LjU1OHoiLz48cGF0aCBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGNsaXAtcnVsZT0iZXZlbm9kZCIgZmlsbD0iIzJDNTU5MSIgZD0iTTc4LjE4NCw2Ni40NTVjLTAuMzcyLDAuNzQ5LTEuMTQ0LDEuNTc1LTIuNTA5LDIuNTM0TDM1LjU2Miw5Ny43OThjLTIuMTksMS41OTEtNS4zMzQsMS4wMDEtNy4wMjEtMS4zMTljLTEuNjg3LTIuMzItMS4yOC01LjQ5LDAuOTEtNy4wODJsMzYuMTczLTI2LjE5NHYtMC41MzhMNDIuODk2LDM4LjQ4N2MtMS44NTQtMS45NzItMS42NjEtNS4xNjEsMC40MzEtNy4xMjRjMi4wOTItMS45NjIsNS4yOS0xLjk1NCw3LjE0NCwwLjAxOGwyNy4yNzEsMjkuMDEyQzc5LjI5LDYyLjA0LDc5LjQwNSw2NC41MzQsNzguMTg0LDY2LjQ1NXoiLz48cGF0aCBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGNsaXAtcnVsZT0iZXZlbm9kZCIgZmlsbD0iI0ZGRkZGRiIgZD0iTTc3LjE4NCw2NS40NTVjLTAuMzcyLDAuNzQ5LTEuMTQ0LDEuNTc1LTIuNTA5LDIuNTM0TDM0LjU2Miw5Ni43OThjLTIuMTksMS41OTEtNS4zMzQsMS4wMDEtNy4wMjEtMS4zMTljLTEuNjg3LTIuMzItMS4yOC01LjQ5LDAuOTEtNy4wODJsMzYuMTczLTI2LjE5NHYtMC41MzhMNDEuODk2LDM3LjQ4N2MtMS44NTQtMS45NzItMS42NjEtNS4xNjEsMC40MzEtNy4xMjRjMi4wOTItMS45NjIsNS4yOS0xLjk1NCw3LjE0NCwwLjAxOGwyNy4yNzEsMjkuMDEyQzc4LjI5LDYxLjA0LDc4LjQwNSw2My41MzQsNzcuMTg0LDY1LjQ1NXoiLz48cGF0aCBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGNsaXAtcnVsZT0iZXZlbm9kZCIgZmlsbD0iI0ZGRkZGRiIgZD0iTTYzLjU1LDg3aDIxLjYxM2MyLjUxMywwLDQuNTUsMi4wMTUsNC41NSw0LjVjMCwyLjQ4NS0yLjAzNyw0LjUtNC41NSw0LjVINjMuNTVDNjEuMDM3LDk2LDU5LDkzLjk4NSw1OSw5MS41QzU5LDg5LjAxNSw2MS4wMzcsODcsNjMuNTUsODd6Ii8+PC9zdmc+"
                }
            }
        }
        New-UDColumn -Size 4 {
            New-UDRow {
                New-UDColumn -Size 12 {
                    New-UDCard @Colors -Title "Written in PowerShell" -Text "Develop both the front-end interface and backend endpoints in the same PowerShell script. Host dashboards right from the console or in Azure\IIS."  -Links @(New-UDLink -Text "View this dashboard's PowerShell Script" -Url "https://github.com/ironmansoftware/universal-dashboard/blob/master/examples/azure-dashboard.ps1")
                }
            }
            New-UDRow {
                New-UDColumn -Size 12 {
                    New-UDCard @Colors -Title "Install now" -Text "Install-Module UniversalDashboard" -Language "PowerShell" -Links @(New-UDLink -Text "PowerShell Gallery" -Url "https://www.powershellgallery.com/packages/UniversalDashboard")
                }
            }
        }
    }
}

Start-UDDashboard -Content {
    New-UDDashboard -NavbarLinks $NavBarLinks -Title "PowerShell Universal Dashboard" -NavBarColor '#FF1c1c1c' -NavBarFontColor "#FF55b3ff" -BackgroundColor "#FF333333" -FontColor "#FFFFFFF" -Pages @(
        $HomePage,
        $Components,
        $Formatting
    )
} -Port 10001 -Wait
